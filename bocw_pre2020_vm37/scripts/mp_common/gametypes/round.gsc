#using scripts\mp_common\gametypes\outcome;
#using scripts\mp_common\gametypes\overtime;

#namespace round;

// Namespace round/round
// Params 0, eflags: 0x1 linked
// Checksum 0xb5040859, Offset: 0x70
// Size: 0x5e
function function_37f04b09() {
    outcome = outcome::function_a1a81955();
    game.outcome.var_3c5fdf73[game.outcome.var_3c5fdf73.size] = outcome;
    game.outcome.var_aefc8b8d = outcome;
}

// Namespace round/round
// Params 0, eflags: 0x1 linked
// Checksum 0x26864b17, Offset: 0xd8
// Size: 0x16
function function_f37f02fc() {
    return game.outcome.var_aefc8b8d;
}

// Namespace round/round
// Params 0, eflags: 0x1 linked
// Checksum 0xac97b44b, Offset: 0xf8
// Size: 0x1ec
function round_stats_init() {
    if (!isdefined(game.roundsplayed)) {
        game.roundsplayed = 0;
    }
    setroundsplayed(game.roundsplayed + overtime::get_rounds_played());
    overtime::round_stats_init();
    if (!isdefined(game.roundwinner)) {
        game.roundwinner = [];
    }
    if (!isdefined(game.lastroundscore)) {
        game.lastroundscore = [];
    }
    if (!isdefined(game.stat[#"roundswon"])) {
        game.stat[#"roundswon"] = [];
    }
    if (!isdefined(game.stat[#"roundswon"][#"tie"])) {
        game.stat[#"roundswon"][#"tie"] = 0;
    }
    foreach (team, _ in level.teams) {
        if (!isdefined(game.stat[#"roundswon"][team])) {
            game.stat[#"roundswon"][team] = 0;
        }
        level.spawn_point_team_class_names[team] = [];
    }
}

// Namespace round/round
// Params 1, eflags: 0x1 linked
// Checksum 0x65f084e1, Offset: 0x2f0
// Size: 0x34
function set_flag(flag) {
    outcome::set_flag(game.outcome.var_aefc8b8d, flag);
}

// Namespace round/round
// Params 1, eflags: 0x1 linked
// Checksum 0x9ce6d8b5, Offset: 0x330
// Size: 0x32
function get_flag(flag) {
    return outcome::get_flag(game.outcome.var_aefc8b8d, flag);
}

// Namespace round/round
// Params 1, eflags: 0x0
// Checksum 0xa2be0897, Offset: 0x370
// Size: 0x32
function clear_flag(flag) {
    return outcome::clear_flag(game.outcome.var_aefc8b8d, flag);
}

// Namespace round/round
// Params 1, eflags: 0x1 linked
// Checksum 0x827a6bd7, Offset: 0x3b0
// Size: 0x34
function function_897438f4(var_c1e98979) {
    outcome::function_897438f4(game.outcome.var_aefc8b8d, var_c1e98979);
}

// Namespace round/round
// Params 0, eflags: 0x1 linked
// Checksum 0x43efd182, Offset: 0x3f0
// Size: 0x22
function function_3624d032() {
    return outcome::function_3624d032(game.outcome.var_aefc8b8d);
}

// Namespace round/round
// Params 0, eflags: 0x1 linked
// Checksum 0x111a236, Offset: 0x420
// Size: 0x22
function get_winning_team() {
    return outcome::get_winning_team(game.outcome.var_aefc8b8d);
}

// Namespace round/round
// Params 0, eflags: 0x0
// Checksum 0x72f9acb9, Offset: 0x450
// Size: 0x22
function function_b5f4c9d8() {
    return outcome::function_b5f4c9d8(game.outcome.var_aefc8b8d);
}

// Namespace round/round
// Params 0, eflags: 0x1 linked
// Checksum 0xaa61648c, Offset: 0x480
// Size: 0x22
function get_winner() {
    return outcome::get_winner(game.outcome.var_aefc8b8d);
}

// Namespace round/round
// Params 1, eflags: 0x0
// Checksum 0x20fd5735, Offset: 0x4b0
// Size: 0x32
function is_winner(team_or_player) {
    return outcome::is_winner(game.outcome.var_aefc8b8d, team_or_player);
}

// Namespace round/round
// Params 1, eflags: 0x1 linked
// Checksum 0x82d87626, Offset: 0x4f0
// Size: 0x34
function set_winner(team_or_player) {
    outcome::set_winner(game.outcome.var_aefc8b8d, team_or_player);
}

// Namespace round/round
// Params 1, eflags: 0x1 linked
// Checksum 0x34c63fa5, Offset: 0x530
// Size: 0x34
function function_af2e264f(winner) {
    outcome::function_af2e264f(game.outcome.var_aefc8b8d, winner);
}

// Namespace round/round
// Params 0, eflags: 0x1 linked
// Checksum 0xaf63992c, Offset: 0x570
// Size: 0x24
function function_870759fb() {
    outcome::function_870759fb(game.outcome.var_aefc8b8d);
}

// Namespace round/round
// Params 0, eflags: 0x0
// Checksum 0xb243a542, Offset: 0x5a0
// Size: 0x1c
function is_overtime_round() {
    if (game.overtime_round > 0) {
        return true;
    }
    return false;
}

