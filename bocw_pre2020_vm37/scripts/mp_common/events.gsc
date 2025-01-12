#using scripts\core_common\util_shared;
#using scripts\mp_common\gametypes\globallogic_utils;

#namespace events;

// Namespace events/events
// Params 3, eflags: 0x0
// Checksum 0x5bdd9e0a, Offset: 0x70
// Size: 0x6c
function add_timed_event(seconds, notify_string, client_notify_string) {
    assert(seconds >= 0);
    if (level.timelimit > 0) {
        level thread timed_event_monitor(seconds, notify_string, client_notify_string);
    }
}

// Namespace events/events
// Params 3, eflags: 0x0
// Checksum 0x7667743c, Offset: 0xe8
// Size: 0xaa
function timed_event_monitor(seconds, notify_string, client_notify_string) {
    for (;;) {
        wait 0.5;
        if (!isdefined(level.starttime)) {
            continue;
        }
        millisecs_remaining = globallogic_utils::gettimeremaining();
        seconds_remaining = float(millisecs_remaining) / 1000;
        if (seconds_remaining <= seconds) {
            event_notify(notify_string, client_notify_string);
            return;
        }
    }
}

// Namespace events/events
// Params 3, eflags: 0x0
// Checksum 0xb2815604, Offset: 0x1a0
// Size: 0x94
function add_score_event(score, notify_string, client_notify_string) {
    assert(score >= 0);
    if (level.scorelimit > 0) {
        if (level.teambased) {
            level thread score_team_event_monitor(score, notify_string, client_notify_string);
            return;
        }
        level thread score_event_monitor(score, notify_string, client_notify_string);
    }
}

// Namespace events/events
// Params 3, eflags: 0x0
// Checksum 0x7f3cf787, Offset: 0x240
// Size: 0xbc
function add_round_score_event(score, notify_string, client_notify_string) {
    assert(score >= 0);
    if (level.roundscorelimit > 0) {
        roundscoretobeat = level.roundscorelimit * game.roundsplayed + score;
        if (level.teambased) {
            level thread score_team_event_monitor(roundscoretobeat, notify_string, client_notify_string);
            return;
        }
        level thread score_event_monitor(roundscoretobeat, notify_string, client_notify_string);
    }
}

// Namespace events/events
// Params 1, eflags: 0x0
// Checksum 0xbcb4d640, Offset: 0x308
// Size: 0xac
function any_team_reach_score(score) {
    foreach (team, _ in level.teams) {
        if (game.stat[#"teamscores"][team] >= score) {
            return true;
        }
    }
    return false;
}

// Namespace events/events
// Params 3, eflags: 0x0
// Checksum 0x868247ab, Offset: 0x3c0
// Size: 0x5a
function score_team_event_monitor(score, notify_string, client_notify_string) {
    for (;;) {
        wait 0.5;
        if (any_team_reach_score(score)) {
            event_notify(notify_string, client_notify_string);
            return;
        }
    }
}

// Namespace events/events
// Params 3, eflags: 0x0
// Checksum 0xd1929880, Offset: 0x428
// Size: 0xaa
function score_event_monitor(score, notify_string, client_notify_string) {
    for (;;) {
        wait 0.5;
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            if (isdefined(players[i].score) && players[i].score >= score) {
                event_notify(notify_string, client_notify_string);
                return;
            }
        }
    }
}

// Namespace events/events
// Params 2, eflags: 0x0
// Checksum 0x900cfeae, Offset: 0x4e0
// Size: 0x44
function event_notify(notify_string, client_notify_string) {
    if (isdefined(notify_string)) {
        level notify(notify_string);
    }
    if (isdefined(client_notify_string)) {
        util::clientnotify(client_notify_string);
    }
}

