#using scripts\core_common\player\player_shared;

#namespace teams;

// Namespace teams/teams
// Params 1, eflags: 0x0
// Checksum 0xd189762b, Offset: 0x68
// Size: 0x26
function function_7f8faff9(team) {
    return game.stat[#"teamscores"][team];
}

// Namespace teams/teams
// Params 1, eflags: 0x0
// Checksum 0xbeaf1fed, Offset: 0x98
// Size: 0x134
function function_dc7eaabd(assignment) {
    assert(isdefined(assignment));
    self.pers[#"team"] = assignment;
    self.team = assignment;
    self.sessionteam = assignment;
    if (isdefined(level.teams[assignment])) {
        status = self player::function_3d288f14();
        if (!isdefined(level.var_75dffa9f[assignment]) || status != level.var_75dffa9f[assignment] && status == #"game") {
            if (status == #"game") {
                level.var_75dffa9f[assignment] = #"game";
            } else {
                level.var_75dffa9f[assignment] = #"none";
            }
        }
    }
    /#
        self thread function_ba459d03(assignment);
    #/
}

// Namespace teams/teams
// Params 1, eflags: 0x0
// Checksum 0x145e8b9, Offset: 0x1d8
// Size: 0x42
function is_team_empty(team) {
    team_players = getplayers(team);
    if (team_players.size > 0) {
        return false;
    }
    return true;
}

// Namespace teams/teams
// Params 0, eflags: 0x0
// Checksum 0x6b6357c0, Offset: 0x228
// Size: 0xfa
function function_959bac94() {
    foreach (team in level.teams) {
        if (self is_team_empty(team)) {
            println("<dev string:x38>" + "<dev string:x4d>" + self.name + "<dev string:x63>" + team);
            /#
                function_d28f6fa0(team);
            #/
            return team;
        }
    }
    return #"spectator";
}

// Namespace teams/teams
// Params 1, eflags: 0x0
// Checksum 0xd27092ac, Offset: 0x330
// Size: 0xac
function function_712e3ba6(score) {
    foreach (team, _ in level.teams) {
        if (game.stat[#"teamscores"][team] >= score) {
            return true;
        }
    }
    return false;
}

// Namespace teams/teams
// Params 0, eflags: 0x0
// Checksum 0x7dd474df, Offset: 0x3e8
// Size: 0x1a
function any_team_hit_score_limit() {
    return function_712e3ba6(level.scorelimit);
}

// Namespace teams/teams
// Params 4, eflags: 0x4
// Checksum 0x9ad081ad, Offset: 0x410
// Size: 0xaa
function private function_67aac3d9(gamestat, teama, teamb, previous_winner_score) {
    winner = undefined;
    assert(teama !== "<dev string:x76>");
    if (previous_winner_score == game.stat[gamestat][teamb]) {
        winner = undefined;
    } else if (game.stat[gamestat][teamb] > previous_winner_score) {
        winner = teamb;
    } else {
        winner = teama;
    }
    return winner;
}

// Namespace teams/teams
// Params 1, eflags: 0x0
// Checksum 0x6e8cabb5, Offset: 0x4c8
// Size: 0xbe
function function_d85770f0(gamestat) {
    teamkeys = getarraykeys(level.teams);
    winner = teamkeys[0];
    previous_winner_score = game.stat[gamestat][winner];
    for (teamindex = 1; teamindex < teamkeys.size; teamindex++) {
        winner = function_67aac3d9(gamestat, winner, teamkeys[teamindex], previous_winner_score);
        if (isdefined(winner)) {
            previous_winner_score = game.stat[gamestat][winner];
        }
    }
    return winner;
}

// Namespace teams/teams
// Params 3, eflags: 0x4
// Checksum 0x21a85e11, Offset: 0x590
// Size: 0x7e
function private function_e390f598(currentwinner, teamb, var_2a5c5ccb) {
    assert(currentwinner !== "<dev string:x76>");
    teambscore = [[ level._getteamscore ]](teamb);
    if (teambscore == var_2a5c5ccb) {
        return undefined;
    } else if (teambscore > var_2a5c5ccb) {
        return teamb;
    }
    return currentwinner;
}

// Namespace teams/teams
// Params 0, eflags: 0x0
// Checksum 0xe78d75eb, Offset: 0x618
// Size: 0xb6
function function_ef80de99() {
    teamkeys = getarraykeys(level.teams);
    winner = teamkeys[0];
    var_2a5c5ccb = [[ level._getteamscore ]](winner);
    for (teamindex = 1; teamindex < teamkeys.size; teamindex++) {
        winner = function_e390f598(winner, teamkeys[teamindex], var_2a5c5ccb);
        if (isdefined(winner)) {
            var_2a5c5ccb = [[ level._getteamscore ]](winner);
        }
    }
    return winner;
}

/#

    // Namespace teams/teams
    // Params 1, eflags: 0x4
    // Checksum 0x423a1bf6, Offset: 0x6d8
    // Size: 0x12c
    function private function_ba459d03(team) {
        if (is_true(level.var_ba13fb7a)) {
            team_str = string(team);
            if (isdefined(level.teams[team])) {
                team_str = level.teams[team];
            }
            voip = "<dev string:x7d>";
            if (isdefined(level.var_75dffa9f[team])) {
                voip += level.var_75dffa9f[team] == #"game" ? "<dev string:x86>" : "<dev string:x8e>";
            } else {
                voip += "<dev string:x98>";
            }
            println("<dev string:x38>" + "<dev string:xa5>" + self.name + "<dev string:xab>" + team_str + "<dev string:xb1>" + voip);
        }
    }

    // Namespace teams/teams
    // Params 1, eflags: 0x0
    // Checksum 0x9146f90c, Offset: 0x810
    // Size: 0xd8
    function function_a9d594a0(party) {
        foreach (party_member in party.party_members) {
            var_2798314b = party_member getparty();
            if (var_2798314b.var_a15e4438 != party.var_a15e4438) {
                assertmsg("<dev string:xb6>");
            }
        }
    }

    // Namespace teams/teams
    // Params 1, eflags: 0x0
    // Checksum 0xa00ff10e, Offset: 0x8f0
    // Size: 0xc0
    function function_d28f6fa0(team) {
        players = getplayers(team);
        foreach (player in players) {
            function_a9d594a0(player getparty());
        }
    }

#/
