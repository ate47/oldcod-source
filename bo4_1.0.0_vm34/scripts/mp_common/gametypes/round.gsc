#using scripts\mp_common\gametypes\outcome;
#using scripts\mp_common\gametypes\overtime;

#namespace round;

// Namespace round/round
// Params 0, eflags: 0x0
// Checksum 0x8a962178, Offset: 0x78
// Size: 0x5e
function function_8a70e2c() {
    outcome = outcome::function_8e946334();
    game.outcome.var_c810ad89[game.outcome.var_c810ad89.size] = outcome;
    game.outcome.var_60666430 = outcome;
}

// Namespace round/round
// Params 0, eflags: 0x0
// Checksum 0xa8747402, Offset: 0xe0
// Size: 0x16
function function_35b54582() {
    return game.outcome.var_60666430;
}

// Namespace round/round
// Params 0, eflags: 0x0
// Checksum 0xb510cf6, Offset: 0x100
// Size: 0x212
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
        level.teamspawnpoints[team] = [];
        level.spawn_point_team_class_names[team] = [];
    }
}

// Namespace round/round
// Params 1, eflags: 0x0
// Checksum 0xe7e7e6e3, Offset: 0x320
// Size: 0x34
function set_flag(flag) {
    outcome::set_flag(game.outcome.var_60666430, flag);
}

// Namespace round/round
// Params 1, eflags: 0x0
// Checksum 0x9b41e020, Offset: 0x360
// Size: 0x32
function get_flag(flag) {
    return outcome::get_flag(game.outcome.var_60666430, flag);
}

// Namespace round/round
// Params 1, eflags: 0x0
// Checksum 0x9b7eae0, Offset: 0x3a0
// Size: 0x32
function clear_flag(flag) {
    return outcome::clear_flag(game.outcome.var_60666430, flag);
}

// Namespace round/round
// Params 1, eflags: 0x0
// Checksum 0xb05760cb, Offset: 0x3e0
// Size: 0x34
function function_b14d882c(var_c3d87d03) {
    outcome::function_b14d882c(game.outcome.var_60666430, var_c3d87d03);
}

// Namespace round/round
// Params 0, eflags: 0x0
// Checksum 0x48fbcf4, Offset: 0x420
// Size: 0x22
function function_fa0cfd68() {
    return outcome::function_fa0cfd68(game.outcome.var_60666430);
}

// Namespace round/round
// Params 0, eflags: 0x0
// Checksum 0x54260178, Offset: 0x450
// Size: 0x22
function get_winning_team() {
    return outcome::get_winning_team(game.outcome.var_60666430);
}

// Namespace round/round
// Params 0, eflags: 0x0
// Checksum 0xdfdd9da5, Offset: 0x480
// Size: 0x22
function function_2da88e92() {
    return outcome::function_2da88e92(game.outcome.var_60666430);
}

// Namespace round/round
// Params 0, eflags: 0x0
// Checksum 0x24a3c2b0, Offset: 0x4b0
// Size: 0x22
function get_winner() {
    return outcome::get_winner(game.outcome.var_60666430);
}

// Namespace round/round
// Params 1, eflags: 0x0
// Checksum 0x68f41119, Offset: 0x4e0
// Size: 0x32
function is_winner(team_or_player) {
    return outcome::is_winner(game.outcome.var_60666430, team_or_player);
}

// Namespace round/round
// Params 1, eflags: 0x0
// Checksum 0xa05fb9ad, Offset: 0x520
// Size: 0x34
function set_winner(team_or_player) {
    outcome::set_winner(game.outcome.var_60666430, team_or_player);
}

// Namespace round/round
// Params 1, eflags: 0x0
// Checksum 0x3f3f9f64, Offset: 0x560
// Size: 0x34
function function_622b7e5e(winner) {
    outcome::function_622b7e5e(game.outcome.var_60666430, winner);
}

// Namespace round/round
// Params 0, eflags: 0x0
// Checksum 0x77985e9f, Offset: 0x5a0
// Size: 0x24
function function_76a0135d() {
    outcome::function_76a0135d(game.outcome.var_60666430);
}

// Namespace round/round
// Params 0, eflags: 0x0
// Checksum 0xc0b9ca9a, Offset: 0x5d0
// Size: 0x1c
function is_overtime_round() {
    if (game.overtime_round > 0) {
        return true;
    }
    return false;
}

