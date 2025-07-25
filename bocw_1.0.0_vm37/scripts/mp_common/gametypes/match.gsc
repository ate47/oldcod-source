#using script_3d703ef87a841fe4;
#using scripts\core_common\system_shared;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\outcome;
#using scripts\mp_common\gametypes\overtime;
#using scripts\mp_common\gametypes\round;

#namespace match;

// Namespace match/match
// Params 0, eflags: 0x6
// Checksum 0x833f63a2, Offset: 0xc8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"match", &preinit, undefined, undefined, undefined);
}

// Namespace match/match
// Params 0, eflags: 0x4
// Checksum 0xd72232f, Offset: 0x110
// Size: 0x14
function private preinit() {
    function_94003d29();
}

// Namespace match/match
// Params 0, eflags: 0x4
// Checksum 0x76c6419, Offset: 0x130
// Size: 0x3e
function private function_37f04b09() {
    if (!isdefined(game.outcome)) {
        game.outcome = outcome::function_a1a81955();
        game.outcome.var_3c5fdf73 = [];
    }
}

// Namespace match/match
// Params 0, eflags: 0x4
// Checksum 0xe1eb673a, Offset: 0x178
// Size: 0x4c
function private function_94003d29() {
    function_37f04b09();
    round::function_37f04b09();
    if (overtime::is_overtime_round()) {
        set_overtime();
    }
}

// Namespace match/match
// Params 0, eflags: 0x0
// Checksum 0xa8ff98fd, Offset: 0x1d0
// Size: 0xe
function function_f37f02fc() {
    return game.outcome;
}

// Namespace match/match
// Params 0, eflags: 0x4
// Checksum 0x72893cf9, Offset: 0x1e8
// Size: 0x2c
function private function_b6b94df8() {
    if (overtime::is_overtime_round()) {
        set_overtime();
    }
}

// Namespace match/match
// Params 0, eflags: 0x0
// Checksum 0x45fcd759, Offset: 0x220
// Size: 0x34
function set_overtime() {
    round::set_flag("overtime");
    set_flag("overtime");
}

// Namespace match/match
// Params 1, eflags: 0x0
// Checksum 0x758edd44, Offset: 0x260
// Size: 0x2c
function set_flag(flag) {
    outcome::set_flag(game.outcome, flag);
}

// Namespace match/match
// Params 1, eflags: 0x0
// Checksum 0xd2ce70c0, Offset: 0x298
// Size: 0x2a
function get_flag(flag) {
    return outcome::get_flag(game.outcome, flag);
}

// Namespace match/match
// Params 1, eflags: 0x0
// Checksum 0xac4b1786, Offset: 0x2d0
// Size: 0x2a
function clear_flag(flag) {
    return outcome::clear_flag(game.outcome, flag);
}

// Namespace match/match
// Params 1, eflags: 0x0
// Checksum 0xdc745cb9, Offset: 0x308
// Size: 0x2c
function function_897438f4(var_c1e98979) {
    outcome::function_897438f4(game.outcome, var_c1e98979);
}

// Namespace match/match
// Params 0, eflags: 0x0
// Checksum 0xee2a5c88, Offset: 0x340
// Size: 0x1a
function function_3624d032() {
    return outcome::function_3624d032(game.outcome);
}

// Namespace match/match
// Params 0, eflags: 0x0
// Checksum 0xe41aac04, Offset: 0x368
// Size: 0x64
function function_c10174e7() {
    if (isdefined(game.outcome.team) && isdefined(level.teams[game.outcome.team])) {
        return true;
    }
    if (game.outcome.players.size) {
        return true;
    }
    return false;
}

// Namespace match/match
// Params 0, eflags: 0x0
// Checksum 0xd808a41b, Offset: 0x3d8
// Size: 0x1a
function get_winning_team() {
    return outcome::get_winning_team(game.outcome);
}

// Namespace match/match
// Params 1, eflags: 0x0
// Checksum 0xdaeeda66, Offset: 0x400
// Size: 0x4a
function is_winning_team(team) {
    if (isdefined(game.outcome.team) && team == game.outcome.team) {
        return true;
    }
    return false;
}

// Namespace match/match
// Params 1, eflags: 0x0
// Checksum 0xd8ead95b, Offset: 0x458
// Size: 0xa2
function function_a2b53e17(player) {
    if (game.outcome.team !== #"none" && player.pers[#"team"] === game.outcome.team) {
        return true;
    }
    if (game.outcome.players.size) {
        if (player == game.outcome.players[0]) {
            return true;
        }
    }
    return false;
}

// Namespace match/match
// Params 0, eflags: 0x0
// Checksum 0xfde37d50, Offset: 0x508
// Size: 0x24
function function_75f97ac7() {
    if (game.outcome.players.size) {
        return true;
    }
    return false;
}

// Namespace match/match
// Params 0, eflags: 0x0
// Checksum 0xb5ff5346, Offset: 0x538
// Size: 0x46
function function_517c0ce0() {
    if (game.outcome.players.size) {
        return game.outcome.players[0] ishost();
    }
    return 0;
}

// Namespace match/match
// Params 0, eflags: 0x0
// Checksum 0xdb35b5fa, Offset: 0x588
// Size: 0x1a
function function_b5f4c9d8() {
    return outcome::function_b5f4c9d8(game.outcome);
}

// Namespace match/match
// Params 0, eflags: 0x0
// Checksum 0x72440a63, Offset: 0x5b0
// Size: 0x52
function get_winner() {
    if (is_true(level.teambased)) {
        return outcome::get_winning_team(game.outcome);
    }
    return outcome::function_b5f4c9d8(game.outcome);
}

// Namespace match/match
// Params 1, eflags: 0x0
// Checksum 0xd00ff1a1, Offset: 0x610
// Size: 0x2c
function set_winner(team_or_player) {
    outcome::set_winner(game.outcome, team_or_player);
}

// Namespace match/match
// Params 1, eflags: 0x0
// Checksum 0x56045116, Offset: 0x648
// Size: 0x2c
function function_af2e264f(winner) {
    outcome::function_af2e264f(game.outcome, winner);
}

// Namespace match/match
// Params 0, eflags: 0x0
// Checksum 0x4c7b2480, Offset: 0x680
// Size: 0x3c
function function_870759fb() {
    winner = function_6d0354e3();
    outcome::function_af2e264f(game.outcome, winner);
}

// Namespace match/match
// Params 0, eflags: 0x0
// Checksum 0xcf6b1a59, Offset: 0x6c8
// Size: 0x10a
function function_6d0354e3() {
    winner = round::get_winner();
    if (game.outcome.var_aefc8b8d.var_c1e98979 != 7) {
        if (level.teambased && get_flag("overtime")) {
            if (!is_true(level.doubleovertime) || round::get_flag("tie")) {
                winner = teams::function_d85770f0("overtimeroundswon");
            }
        } else if (level.scoreroundwinbased) {
            winner = teams::function_d85770f0("roundswon");
        } else {
            winner = teams::function_ef80de99();
        }
    }
    return winner;
}

