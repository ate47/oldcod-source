#using script_3d703ef87a841fe4;
#using scripts\core_common\flag_shared;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_score;

#namespace outcome;

// Namespace outcome/outcome
// Params 0, eflags: 0x2
// Checksum 0x5366bc6, Offset: 0xa8
// Size: 0x94
function autoexec main() {
    level.var_9b671c3c[#"tie"] = {#flag:"tie", #code_flag:1};
    level.var_9b671c3c[#"overtime"] = {#flag:"overtime", #code_flag:2};
}

// Namespace outcome/outcome
// Params 0, eflags: 0x0
// Checksum 0x79379f43, Offset: 0x148
// Size: 0x66
function function_a1a81955() {
    outcome = spawnstruct();
    outcome.flags = 0;
    outcome.var_c1e98979 = 0;
    outcome.team = #"none";
    outcome.players = [];
    outcome.players_score = [];
    return outcome;
}

// Namespace outcome/outcome
// Params 2, eflags: 0x0
// Checksum 0x1048b728, Offset: 0x1b8
// Size: 0xce
function is_winner(outcome, team_or_player) {
    if (isplayer(team_or_player)) {
        if (isdefined(outcome.players) && outcome.players.size && outcome.players[0] == team_or_player) {
            return true;
        }
        if (isdefined(outcome.team) && outcome.team == team_or_player.team) {
            return true;
        }
    } else if (isdefined(outcome.team) && outcome.team == team_or_player) {
        return true;
    }
    return false;
}

// Namespace outcome/outcome
// Params 2, eflags: 0x0
// Checksum 0x70a1a1c5, Offset: 0x290
// Size: 0x2c
function set_flag(outcome, flag) {
    outcome flag::set(flag);
}

// Namespace outcome/outcome
// Params 2, eflags: 0x0
// Checksum 0x936cf109, Offset: 0x2c8
// Size: 0x2a
function get_flag(outcome, flag) {
    return outcome flag::get(flag);
}

// Namespace outcome/outcome
// Params 2, eflags: 0x0
// Checksum 0x2654ebfe, Offset: 0x300
// Size: 0x2a
function clear_flag(outcome, flag) {
    return outcome flag::clear(flag);
}

// Namespace outcome/outcome
// Params 1, eflags: 0x0
// Checksum 0x6f1c50d0, Offset: 0x338
// Size: 0xc0
function function_2e00fa44(outcome) {
    flags = 0;
    foreach (flag_type in level.var_9b671c3c) {
        if (outcome flag::get(flag_type.flag)) {
            flags |= flag_type.code_flag;
        }
    }
    return flags;
}

// Namespace outcome/outcome
// Params 2, eflags: 0x0
// Checksum 0x129e2d17, Offset: 0x400
// Size: 0x22
function function_897438f4(outcome, var_c1e98979) {
    outcome.var_c1e98979 = var_c1e98979;
}

// Namespace outcome/outcome
// Params 1, eflags: 0x0
// Checksum 0x166b6dc9, Offset: 0x430
// Size: 0x16
function function_3624d032(outcome) {
    return outcome.var_c1e98979;
}

// Namespace outcome/outcome
// Params 1, eflags: 0x0
// Checksum 0xee24b908, Offset: 0x450
// Size: 0x5a
function get_winning_team(outcome) {
    if (isdefined(outcome.team)) {
        return outcome.team;
    }
    if (outcome.players.size) {
        return outcome.players[0].team;
    }
    return #"none";
}

// Namespace outcome/outcome
// Params 1, eflags: 0x0
// Checksum 0x4b30e6f0, Offset: 0x4b8
// Size: 0x2c
function function_b5f4c9d8(outcome) {
    if (outcome.players.size) {
        return outcome.players[0];
    }
    return undefined;
}

// Namespace outcome/outcome
// Params 1, eflags: 0x0
// Checksum 0x820d172f, Offset: 0x4f0
// Size: 0x48
function get_winner(outcome) {
    if (isdefined(outcome.team)) {
        return outcome.team;
    }
    if (outcome.players.size) {
        return outcome.players[0];
    }
    return undefined;
}

// Namespace outcome/outcome
// Params 2, eflags: 0x0
// Checksum 0x3d495bfe, Offset: 0x540
// Size: 0x72
function set_winner(outcome, team_or_player) {
    if (!isdefined(team_or_player)) {
        return;
    }
    if (isplayer(team_or_player)) {
        outcome.players[outcome.players.size] = team_or_player;
        outcome.team = team_or_player.team;
        return;
    }
    outcome.team = team_or_player;
}

// Namespace outcome/outcome
// Params 2, eflags: 0x0
// Checksum 0x52135fb6, Offset: 0x5c0
// Size: 0x54
function function_af2e264f(outcome, winner) {
    if (isdefined(winner)) {
        set_winner(outcome, winner);
        return;
    }
    set_flag(outcome, "tie");
}

// Namespace outcome/outcome
// Params 0, eflags: 0x0
// Checksum 0x1180637a, Offset: 0x620
// Size: 0x52
function function_6d0354e3() {
    if (level.teambased) {
        winner = teams::function_d85770f0("teamScores");
    } else {
        winner = globallogic_score::gethighestscoringplayer();
    }
    return winner;
}

// Namespace outcome/outcome
// Params 1, eflags: 0x0
// Checksum 0x665783ef, Offset: 0x680
// Size: 0x3c
function function_870759fb(outcome) {
    winner = function_6d0354e3();
    function_af2e264f(outcome, winner);
}

