#using scripts\core_common\system_shared;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\outcome;
#using scripts\mp_common\gametypes\overtime;
#using scripts\mp_common\gametypes\round;

#namespace match;

// Namespace match/match
// Params 0, eflags: 0x2
// Checksum 0xede8425f, Offset: 0xc0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"match", &__init__, undefined, undefined);
}

// Namespace match/match
// Params 0, eflags: 0x0
// Checksum 0x1861701b, Offset: 0x108
// Size: 0x14
function __init__() {
    function_115144b3();
}

// Namespace match/match
// Params 0, eflags: 0x4
// Checksum 0x73f0adef, Offset: 0x128
// Size: 0x42
function private function_8a70e2c() {
    if (!isdefined(game.outcome)) {
        game.outcome = outcome::function_8e946334();
        game.outcome.var_c810ad89 = [];
    }
}

// Namespace match/match
// Params 0, eflags: 0x4
// Checksum 0xdf1e66e6, Offset: 0x178
// Size: 0x4c
function private function_115144b3() {
    function_8a70e2c();
    round::function_8a70e2c();
    if (overtime::is_overtime_round()) {
        set_overtime();
    }
}

// Namespace match/match
// Params 0, eflags: 0x0
// Checksum 0xdbdd04a1, Offset: 0x1d0
// Size: 0xe
function function_35b54582() {
    return game.outcome;
}

// Namespace match/match
// Params 0, eflags: 0x4
// Checksum 0x4b4a90d0, Offset: 0x1e8
// Size: 0x2c
function private function_a8517ee6() {
    if (overtime::is_overtime_round()) {
        set_overtime();
    }
}

// Namespace match/match
// Params 0, eflags: 0x0
// Checksum 0xd1f27d1e, Offset: 0x220
// Size: 0x34
function set_overtime() {
    round::set_flag("overtime");
    set_flag("overtime");
}

// Namespace match/match
// Params 1, eflags: 0x0
// Checksum 0x42350a4a, Offset: 0x260
// Size: 0x2c
function set_flag(flag) {
    outcome::set_flag(game.outcome, flag);
}

// Namespace match/match
// Params 1, eflags: 0x0
// Checksum 0x21f2a82c, Offset: 0x298
// Size: 0x2a
function get_flag(flag) {
    return outcome::get_flag(game.outcome, flag);
}

// Namespace match/match
// Params 1, eflags: 0x0
// Checksum 0xb587dddb, Offset: 0x2d0
// Size: 0x2a
function clear_flag(flag) {
    return outcome::clear_flag(game.outcome, flag);
}

// Namespace match/match
// Params 1, eflags: 0x0
// Checksum 0x2d00a4df, Offset: 0x308
// Size: 0x2c
function function_b14d882c(var_c3d87d03) {
    outcome::function_b14d882c(game.outcome, var_c3d87d03);
}

// Namespace match/match
// Params 0, eflags: 0x0
// Checksum 0x6615c82, Offset: 0x340
// Size: 0x1a
function function_fa0cfd68() {
    return outcome::function_fa0cfd68(game.outcome);
}

// Namespace match/match
// Params 0, eflags: 0x0
// Checksum 0x7ee53f66, Offset: 0x368
// Size: 0x64
function function_c6c8145e() {
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
// Checksum 0x7c2b02aa, Offset: 0x3d8
// Size: 0x1a
function get_winning_team() {
    return outcome::get_winning_team(game.outcome);
}

// Namespace match/match
// Params 1, eflags: 0x0
// Checksum 0xa908fa08, Offset: 0x400
// Size: 0x4a
function is_winning_team(team) {
    if (isdefined(game.outcome.team) && team == game.outcome.team) {
        return true;
    }
    return false;
}

// Namespace match/match
// Params 1, eflags: 0x0
// Checksum 0x2f3477ea, Offset: 0x458
// Size: 0x9e
function function_356f8b9b(player) {
    if (isdefined(game.outcome.team) && player.pers[#"team"] === game.outcome.team) {
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
// Checksum 0x9d856bd4, Offset: 0x500
// Size: 0x24
function function_ea1a6273() {
    if (game.outcome.players.size) {
        return true;
    }
    return false;
}

// Namespace match/match
// Params 0, eflags: 0x0
// Checksum 0xe8a7d45a, Offset: 0x530
// Size: 0x46
function function_c925deac() {
    if (game.outcome.players.size) {
        return game.outcome.players[0] ishost();
    }
    return 0;
}

// Namespace match/match
// Params 0, eflags: 0x0
// Checksum 0x87b7cb79, Offset: 0x580
// Size: 0x1a
function function_2da88e92() {
    return outcome::function_2da88e92(game.outcome);
}

// Namespace match/match
// Params 0, eflags: 0x0
// Checksum 0xf9e3c67d, Offset: 0x5a8
// Size: 0x52
function get_winner() {
    if (isdefined(level.teambased) && level.teambased) {
        return outcome::get_winning_team(game.outcome);
    }
    return outcome::function_2da88e92(game.outcome);
}

// Namespace match/match
// Params 1, eflags: 0x0
// Checksum 0x1c914778, Offset: 0x608
// Size: 0x2c
function set_winner(team_or_player) {
    outcome::set_winner(game.outcome, team_or_player);
}

// Namespace match/match
// Params 1, eflags: 0x0
// Checksum 0xda1eae9d, Offset: 0x640
// Size: 0x2c
function function_622b7e5e(winner) {
    outcome::function_622b7e5e(game.outcome, winner);
}

// Namespace match/match
// Params 0, eflags: 0x0
// Checksum 0x4b792a8d, Offset: 0x678
// Size: 0x3c
function function_76a0135d() {
    winner = function_81e31796();
    outcome::function_622b7e5e(game.outcome, winner);
}

// Namespace match/match
// Params 0, eflags: 0x0
// Checksum 0x86dfdb74, Offset: 0x6c0
// Size: 0x10a
function function_81e31796() {
    winner = round::get_winner();
    if (game.outcome.var_60666430.var_c3d87d03 != 7) {
        if (level.teambased && get_flag("overtime")) {
            if (!(isdefined(level.doubleovertime) && level.doubleovertime) || round::get_flag("tie")) {
                winner = globallogic::determineteamwinnerbygamestat("overtimeroundswon");
            }
        } else if (level.scoreroundwinbased) {
            winner = globallogic::determineteamwinnerbygamestat("roundswon");
        } else {
            winner = globallogic::determineteamwinnerbyteamscore();
        }
    }
    return winner;
}

