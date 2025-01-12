#using scripts\core_common\callbacks_shared;
#using scripts\core_common\math_shared;

#namespace tickets;

// Namespace tickets/globallogic_tickets
// Params 0, eflags: 0x2
// Checksum 0x2460ea70, Offset: 0x78
// Size: 0x24
function autoexec __init__() {
    callback::on_player_killed(&on_player_killed);
}

// Namespace tickets/globallogic_tickets
// Params 1, eflags: 0x0
// Checksum 0x1a426f3d, Offset: 0xa8
// Size: 0x52
function reset_match_start(total_stages) {
    if (game.tickets_initialized === 1) {
        return;
    }
    reset_stages(total_stages);
    reset_tickets();
    game.tickets_initialized = 1;
}

// Namespace tickets/globallogic_tickets
// Params 1, eflags: 0x0
// Checksum 0x6c61ae37, Offset: 0x108
// Size: 0xfc
function reset_stages(total_stages) {
    game.stat[#"stagetickets"] = [];
    foreach (team, _ in level.teams) {
        game.stat[#"stagetickets"][team] = [];
        for (stage = 0; stage < total_stages; stage++) {
            game.stat[#"stagetickets"][team][stage] = 0;
        }
    }
}

// Namespace tickets/globallogic_tickets
// Params 0, eflags: 0x0
// Checksum 0x9e67bdd8, Offset: 0x210
// Size: 0xa8
function reset_tickets() {
    game.stat[#"tickets"] = [];
    foreach (team, _ in level.teams) {
        game.stat[#"tickets"][team] = 0;
    }
}

// Namespace tickets/globallogic_tickets
// Params 2, eflags: 0x0
// Checksum 0xd035edc, Offset: 0x2c0
// Size: 0x5c
function setup_mission_ticket_logic(team, zone_index) {
    setup_stage_start_tickets(team, zone_index);
    thread setup_death_penalties(team);
    thread watch_time_penalties(team);
}

// Namespace tickets/globallogic_tickets
// Params 2, eflags: 0x0
// Checksum 0xea26c262, Offset: 0x328
// Size: 0x5c
function setup_stage_start_tickets(team, zone_index) {
    reset_tickets();
    zone_start_tickets = get_zone_start_tickets(zone_index);
    set_tickets(team, zone_start_tickets);
}

// Namespace tickets/globallogic_tickets
// Params 1, eflags: 0x0
// Checksum 0x8d1ed594, Offset: 0x390
// Size: 0x68
function get_zone_start_tickets(zone_index) {
    return isdefined(getgametypesetting(#"ticketsgivenatstagestart_" + zone_index)) ? getgametypesetting(#"ticketsgivenatstagestart_" + zone_index) : 0;
}

// Namespace tickets/globallogic_tickets
// Params 1, eflags: 0x0
// Checksum 0xb6523c74, Offset: 0x400
// Size: 0x1a0
function watch_time_penalties(team) {
    level notify(#"tickets_watch_time_penalties");
    level endon(#"tickets_watch_time_penalties");
    level endon(#"mission_ended");
    level endon(#"game_ended");
    while (true) {
        penalty_interval = isdefined(getgametypesetting(#"ticketslostontimeinterval")) ? getgametypesetting(#"ticketslostontimeinterval") : 0;
        if (penalty_interval <= 0) {
            wait 0.5;
            continue;
        }
        frames_to_wait = int(ceil(penalty_interval / float(function_f9f48566()) / 1000));
        waitframe(frames_to_wait);
        lose_tickets(team, isdefined(getgametypesetting(#"ticketslostontimeamount")) ? getgametypesetting(#"ticketslostontimeamount") : 0);
    }
}

// Namespace tickets/globallogic_tickets
// Params 1, eflags: 0x0
// Checksum 0x5f9a7839, Offset: 0x5a8
// Size: 0x1a
function setup_death_penalties(team) {
    level.ticket_death_penalty_team = team;
}

// Namespace tickets/globallogic_tickets
// Params 0, eflags: 0x0
// Checksum 0x26cc438d, Offset: 0x5d0
// Size: 0x118
function on_player_killed() {
    player = self;
    if (!isplayer(player)) {
        return;
    }
    if (!isdefined(player.team)) {
        return;
    }
    if (!isdefined(level.ticket_death_penalty_team)) {
        return;
    }
    if (level.ticket_death_penalty_team == player.team) {
        death_penalty = isdefined(getgametypesetting(#"ticketslostondeath")) ? getgametypesetting(#"ticketslostondeath") : 0;
        if (death_penalty > 0) {
            lose_tickets(player.team, death_penalty);
            level notify(#"ticket_death", {#team:player.team});
        }
    }
}

// Namespace tickets/globallogic_tickets
// Params 2, eflags: 0x0
// Checksum 0x4eb17d12, Offset: 0x6f0
// Size: 0x7c
function set_tickets(team, tickets) {
    original_total = game.stat[#"tickets"][team];
    game.stat[#"tickets"][team] = tickets;
    notify_tickets_updated(team, original_total);
}

// Namespace tickets/globallogic_tickets
// Params 2, eflags: 0x0
// Checksum 0x2e8a7b28, Offset: 0x778
// Size: 0xac
function earn_tickets(team, tickets) {
    original_total = game.stat[#"tickets"][team];
    game.stat[#"tickets"][team] = game.stat[#"tickets"][team] + tickets;
    clamp_tickets(team);
    notify_tickets_updated(team, original_total);
}

// Namespace tickets/globallogic_tickets
// Params 2, eflags: 0x0
// Checksum 0x1400b977, Offset: 0x830
// Size: 0xac
function lose_tickets(team, tickets) {
    original_total = game.stat[#"tickets"][team];
    game.stat[#"tickets"][team] = game.stat[#"tickets"][team] - tickets;
    clamp_tickets(team);
    notify_tickets_updated(team, original_total);
}

// Namespace tickets/globallogic_tickets
// Params 2, eflags: 0x0
// Checksum 0x1bddc520, Offset: 0x8e8
// Size: 0x192
function notify_tickets_updated(team, original_total) {
    if (original_total != game.stat[#"tickets"][team]) {
        level notify(#"tickets_updated", {#team:team, #total_tickets:game.stat[#"tickets"][team]});
        low_ticket_threshold = 30;
        very_low_ticket_threshold = 10;
        /#
            if (getdvarint(#"scr_disable_war_score_limits", 0) > 0) {
                low_ticket_threshold = -1;
                very_low_ticket_threshold = -1;
            }
        #/
        low_tickets_enabled = level.low_tickets_enabled === 1;
        level.low_ticket_count = game.stat[#"tickets"][team] <= low_ticket_threshold && !level.inprematchperiod && low_tickets_enabled;
        level.very_low_ticket_count = game.stat[#"tickets"][team] <= very_low_ticket_threshold && !level.inprematchperiod && low_tickets_enabled;
    }
}

// Namespace tickets/globallogic_tickets
// Params 1, eflags: 0x4
// Checksum 0xf624f00, Offset: 0xa88
// Size: 0x64
function private clamp_tickets(team) {
    game.stat[#"tickets"][team] = math::clamp(game.stat[#"tickets"][team], 0, 2147483647);
}

// Namespace tickets/globallogic_tickets
// Params 2, eflags: 0x0
// Checksum 0xdb267ece, Offset: 0xaf8
// Size: 0x6c
function commit_tickets(team, stage) {
    game.stat[#"stagetickets"][team][stage] = game.stat[#"tickets"][team];
    notify_stage_tickets_updated(team, stage);
}

// Namespace tickets/globallogic_tickets
// Params 2, eflags: 0x0
// Checksum 0x1bed74d9, Offset: 0xb70
// Size: 0x5c
function award_stage_win(team, stage) {
    earned_tickets = get_stage_win_tickets(stage);
    if (earned_tickets > 0) {
        earn_tickets(team, earned_tickets);
    }
}

// Namespace tickets/globallogic_tickets
// Params 1, eflags: 0x0
// Checksum 0xe95c790f, Offset: 0xbd8
// Size: 0x68
function get_stage_win_tickets(stage) {
    return isdefined(getgametypesetting(#"ticketsearnedatstagewin_" + stage)) ? getgametypesetting(#"ticketsearnedatstagewin_" + stage) : 0;
}

// Namespace tickets/globallogic_tickets
// Params 1, eflags: 0x0
// Checksum 0x8cfa01d6, Offset: 0xc48
// Size: 0x4e
function get_tickets(team) {
    if (!isdefined(game.tickets_initialized) || !game.tickets_initialized) {
        return 0;
    }
    return game.stat[#"tickets"][team];
}

// Namespace tickets/globallogic_tickets
// Params 2, eflags: 0x0
// Checksum 0xbb539248, Offset: 0xca0
// Size: 0x60
function get_stage_tickets(team, stage) {
    if (!isdefined(game.tickets_initialized) || !game.tickets_initialized) {
        return 0;
    }
    return game.stat[#"stagetickets"][team][stage];
}

// Namespace tickets/globallogic_tickets
// Params 2, eflags: 0x0
// Checksum 0x41145f47, Offset: 0xd08
// Size: 0x78
function notify_stage_tickets_updated(team, stage) {
    level notify(#"tickets_stage_updated", {#team:team, #zone_number:stage, #total_tickets:game.stat[#"stagetickets"][team][stage]});
}

// Namespace tickets/globallogic_tickets
// Params 2, eflags: 0x0
// Checksum 0x3619541, Offset: 0xd88
// Size: 0x6e
function get_total_tickets(team, total_stages) {
    team_total = 0;
    for (i = 0; i < total_stages; i++) {
        team_total += get_stage_tickets(team, i);
    }
    return team_total;
}

