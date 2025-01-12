#using scripts\core_common\flagsys_shared;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_score;

#namespace outcome;

// Namespace outcome/outcome
// Params 0, eflags: 0x2
// Checksum 0x71c57f5b, Offset: 0x98
// Size: 0x9a
function autoexec main() {
    level.var_995c757b[#"tie"] = {#flag:"tie", #code_flag:1};
    level.var_995c757b[#"overtime"] = {#flag:"overtime", #code_flag:2};
}

// Namespace outcome/outcome
// Params 0, eflags: 0x0
// Checksum 0x68e744d5, Offset: 0x140
// Size: 0xe2
function function_8e946334() {
    outcome = spawnstruct();
    outcome.flags = 0;
    outcome.var_c3d87d03 = 0;
    outcome.team = #"free";
    foreach (team, _ in level.teams) {
        outcome.team_score[team] = 0;
    }
    outcome.players = [];
    outcome.players_score = [];
    return outcome;
}

// Namespace outcome/outcome
// Params 2, eflags: 0x0
// Checksum 0xeba18a3b, Offset: 0x230
// Size: 0xda
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
// Checksum 0x24e3192a, Offset: 0x318
// Size: 0x2c
function set_flag(outcome, flag) {
    outcome flagsys::set(flag);
}

// Namespace outcome/outcome
// Params 2, eflags: 0x0
// Checksum 0x6f3d14e5, Offset: 0x350
// Size: 0x2a
function get_flag(outcome, flag) {
    return outcome flagsys::get(flag);
}

// Namespace outcome/outcome
// Params 2, eflags: 0x0
// Checksum 0x67ce16b9, Offset: 0x388
// Size: 0x2a
function clear_flag(outcome, flag) {
    return outcome flagsys::clear(flag);
}

// Namespace outcome/outcome
// Params 1, eflags: 0x0
// Checksum 0x3ff85e65, Offset: 0x3c0
// Size: 0xb4
function function_fcece5f9(outcome) {
    flags = 0;
    foreach (flag_type in level.var_995c757b) {
        if (outcome flagsys::get(flag_type.flag)) {
            flags |= flag_type.code_flag;
        }
    }
    return flags;
}

// Namespace outcome/outcome
// Params 2, eflags: 0x0
// Checksum 0x31f6c356, Offset: 0x480
// Size: 0x22
function function_b14d882c(outcome, var_c3d87d03) {
    outcome.var_c3d87d03 = var_c3d87d03;
}

// Namespace outcome/outcome
// Params 1, eflags: 0x0
// Checksum 0x3d6bed14, Offset: 0x4b0
// Size: 0x16
function function_fa0cfd68(outcome) {
    return outcome.var_c3d87d03;
}

// Namespace outcome/outcome
// Params 1, eflags: 0x0
// Checksum 0x41799342, Offset: 0x4d0
// Size: 0x5a
function get_winning_team(outcome) {
    if (isdefined(outcome.team)) {
        return outcome.team;
    }
    if (outcome.players.size) {
        return outcome.players[0].team;
    }
    return #"free";
}

// Namespace outcome/outcome
// Params 1, eflags: 0x0
// Checksum 0xcfee2ab0, Offset: 0x538
// Size: 0x30
function function_2da88e92(outcome) {
    if (outcome.players.size) {
        return outcome.players[0];
    }
    return undefined;
}

// Namespace outcome/outcome
// Params 1, eflags: 0x0
// Checksum 0xbdcb2ee2, Offset: 0x570
// Size: 0x4c
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
// Checksum 0xaef26c4, Offset: 0x5c8
// Size: 0x6a
function set_winner(outcome, team_or_player) {
    if (!isdefined(team_or_player)) {
        return;
    }
    if (isplayer(team_or_player)) {
        outcome.players[outcome.players.size] = team_or_player;
        return;
    }
    outcome.team = team_or_player;
}

// Namespace outcome/outcome
// Params 2, eflags: 0x0
// Checksum 0xfe0c23d4, Offset: 0x640
// Size: 0x54
function function_622b7e5e(outcome, winner) {
    if (isdefined(winner)) {
        set_winner(outcome, winner);
        return;
    }
    set_flag(outcome, "tie");
}

// Namespace outcome/outcome
// Params 0, eflags: 0x0
// Checksum 0x655aec40, Offset: 0x6a0
// Size: 0x52
function function_81e31796() {
    if (level.teambased) {
        winner = globallogic::determineteamwinnerbygamestat("teamScores");
    } else {
        winner = globallogic_score::gethighestscoringplayer();
    }
    return winner;
}

// Namespace outcome/outcome
// Params 1, eflags: 0x0
// Checksum 0x6f0bfb04, Offset: 0x700
// Size: 0x3c
function function_76a0135d(outcome) {
    winner = function_81e31796();
    function_622b7e5e(outcome, winner);
}

