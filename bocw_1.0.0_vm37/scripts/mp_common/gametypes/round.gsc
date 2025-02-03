#using scripts\mp_common\gametypes\outcome;
#using scripts\mp_common\gametypes\overtime;

#namespace round;

// Namespace round/round
// Params 0, eflags: 0x0
// Checksum 0xe5d252ab, Offset: 0x70
// Size: 0x5e
function function_37f04b09() {
    outcome = outcome::function_a1a81955();
    game.outcome.var_3c5fdf73[game.outcome.var_3c5fdf73.size] = outcome;
    game.outcome.var_aefc8b8d = outcome;
}

// Namespace round/round
// Params 0, eflags: 0x0
// Checksum 0x9b03d28e, Offset: 0xd8
// Size: 0x16
function function_f37f02fc() {
    return game.outcome.var_aefc8b8d;
}

// Namespace round/round
// Params 0, eflags: 0x0
// Checksum 0xf0969953, Offset: 0xf8
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
// Params 1, eflags: 0x0
// Checksum 0x4f7e2d66, Offset: 0x2f0
// Size: 0x34
function set_flag(flag) {
    outcome::set_flag(game.outcome.var_aefc8b8d, flag);
}

// Namespace round/round
// Params 1, eflags: 0x0
// Checksum 0x796efd23, Offset: 0x330
// Size: 0x32
function get_flag(flag) {
    return outcome::get_flag(game.outcome.var_aefc8b8d, flag);
}

// Namespace round/round
// Params 1, eflags: 0x0
// Checksum 0x93f455c6, Offset: 0x370
// Size: 0x32
function clear_flag(flag) {
    return outcome::clear_flag(game.outcome.var_aefc8b8d, flag);
}

// Namespace round/round
// Params 1, eflags: 0x0
// Checksum 0xb85df72a, Offset: 0x3b0
// Size: 0x34
function function_897438f4(var_c1e98979) {
    outcome::function_897438f4(game.outcome.var_aefc8b8d, var_c1e98979);
}

// Namespace round/round
// Params 0, eflags: 0x0
// Checksum 0xb5f5a577, Offset: 0x3f0
// Size: 0x22
function function_3624d032() {
    return outcome::function_3624d032(game.outcome.var_aefc8b8d);
}

// Namespace round/round
// Params 0, eflags: 0x0
// Checksum 0xad01df2f, Offset: 0x420
// Size: 0x22
function get_winning_team() {
    return outcome::get_winning_team(game.outcome.var_aefc8b8d);
}

// Namespace round/round
// Params 0, eflags: 0x0
// Checksum 0x602ecfff, Offset: 0x450
// Size: 0x22
function function_b5f4c9d8() {
    return outcome::function_b5f4c9d8(game.outcome.var_aefc8b8d);
}

// Namespace round/round
// Params 0, eflags: 0x0
// Checksum 0xa32e6740, Offset: 0x480
// Size: 0x22
function get_winner() {
    return outcome::get_winner(game.outcome.var_aefc8b8d);
}

// Namespace round/round
// Params 1, eflags: 0x0
// Checksum 0xa5fe7767, Offset: 0x4b0
// Size: 0x32
function is_winner(team_or_player) {
    return outcome::is_winner(game.outcome.var_aefc8b8d, team_or_player);
}

// Namespace round/round
// Params 1, eflags: 0x0
// Checksum 0x84f2e505, Offset: 0x4f0
// Size: 0x34
function set_winner(team_or_player) {
    outcome::set_winner(game.outcome.var_aefc8b8d, team_or_player);
}

// Namespace round/round
// Params 1, eflags: 0x0
// Checksum 0xc3f83352, Offset: 0x530
// Size: 0x34
function function_af2e264f(winner) {
    outcome::function_af2e264f(game.outcome.var_aefc8b8d, winner);
}

// Namespace round/round
// Params 0, eflags: 0x0
// Checksum 0xa4859669, Offset: 0x570
// Size: 0x24
function function_870759fb() {
    outcome::function_870759fb(game.outcome.var_aefc8b8d);
}

// Namespace round/round
// Params 0, eflags: 0x0
// Checksum 0x648109d0, Offset: 0x5a0
// Size: 0x1c
function is_overtime_round() {
    if (game.overtime_round > 0) {
        return true;
    }
    return false;
}

