#using script_3d703ef87a841fe4;
#using script_45fdb6cec5580007;
#using scripts\core_common\array_shared;
#using scripts\core_common\bots\bot;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\teams\teams;

#namespace teams;

// Namespace teams/team_assignment
// Params 0, eflags: 0x6
// Checksum 0x9bd4bbd9, Offset: 0xc0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"team_assignment", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace teams/team_assignment
// Params 0, eflags: 0x5 linked
// Checksum 0x4b466cd0, Offset: 0x108
// Size: 0x5c
function private function_70a657d8() {
    if (!isdefined(level.var_a3e209ba)) {
        level.var_a3e209ba = &function_321f8eb5;
    }
    /#
        level.var_ba13fb7a = getdvarint(#"hash_40fe9055da22add4", 1);
    #/
}

// Namespace teams/team_assignment
// Params 0, eflags: 0x0
// Checksum 0x6ed241a4, Offset: 0x170
// Size: 0x26
function get_assigned_team() {
    teamname = getassignedteamname(self);
}

// Namespace teams/team_assignment
// Params 0, eflags: 0x0
// Checksum 0x23df8400, Offset: 0x1a0
// Size: 0x36
function function_2ba5e3e6() {
    var_ac46c774 = util::gethostplayerforbots();
    if (isdefined(var_ac46c774)) {
        return var_ac46c774.team;
    }
    return "";
}

// Namespace teams/team_assignment
// Params 0, eflags: 0x1 linked
// Checksum 0x9c91f2ae, Offset: 0x1e0
// Size: 0x8e
function function_582e5d7c() {
    max_players = player::function_d36b6597();
    return isbot(self) && isdefined(self.botteam) && self.botteam != "autoassign" && (max_players == 0 || getplayers(self.botteam).size < max_players);
}

// Namespace teams/team_assignment
// Params 1, eflags: 0x1 linked
// Checksum 0xc32fe075, Offset: 0x278
// Size: 0x3c
function function_ee150fcc(team_players) {
    max_players = player::function_d36b6597();
    return max_players - player::function_1cec6cba(team_players);
}

// Namespace teams/team_assignment
// Params 1, eflags: 0x1 linked
// Checksum 0x8ff46219, Offset: 0x2c0
// Size: 0x2c
function function_46edfa55(team_players) {
    return level.var_704bcca1 - player::function_1cec6cba(team_players);
}

// Namespace teams/team_assignment
// Params 1, eflags: 0x1 linked
// Checksum 0x4e2ae56, Offset: 0x2f8
// Size: 0x162
function function_efe5a681(team) {
    max_players = player::function_d36b6597();
    team_players = getplayers(team);
    if (team_players.size >= max_players && max_players != 0) {
        return false;
    }
    if (!max_players) {
        return true;
    }
    var_fa810454 = function_ee150fcc(team_players);
    party = self getparty();
    if (party.var_a15e4438 > var_fa810454) {
        return false;
    }
    /#
        if (getdvarint(#"hash_2ffea48b89a9ff3f", 0) && self != getplayers()[0] && getplayers()[0].team == team && !isbot(self)) {
            return false;
        }
    #/
    return true;
}

// Namespace teams/team_assignment
// Params 1, eflags: 0x1 linked
// Checksum 0x99c8545d, Offset: 0x468
// Size: 0x12a
function function_ccb3bc7a(teams) {
    foreach (team in teams) {
        if (self function_efe5a681(team)) {
            println("<dev string:x38>" + "<dev string:x4d>" + self.name + "<dev string:x63>" + function_2c846a74(team) + "<dev string:x74>" + getplayers(team).size);
            /#
                function_d28f6fa0(team);
            #/
            return team;
        }
    }
    return #"spectator";
}

// Namespace teams/team_assignment
// Params 1, eflags: 0x1 linked
// Checksum 0x25b9d758, Offset: 0x5a0
// Size: 0x1c2
function function_b919f6aa(status) {
    foreach (team in level.teams) {
        if (status == #"game") {
            if (isdefined(level.var_75dffa9f[team]) && level.var_75dffa9f[team] != #"game") {
                continue;
            }
        } else if (isdefined(level.var_75dffa9f[team]) && level.var_75dffa9f[team] == #"game") {
            continue;
        }
        if (self function_efe5a681(team)) {
            println("<dev string:x38>" + "<dev string:x4d>" + self.name + "<dev string:x7f>" + function_2c846a74(team) + "<dev string:x74>" + getplayers(team).size);
            /#
                function_d28f6fa0(team);
            #/
            return team;
        }
    }
    return #"spectator";
}

// Namespace teams/team_assignment
// Params 0, eflags: 0x1 linked
// Checksum 0xa4d9c389, Offset: 0x770
// Size: 0xaa
function function_5c389625() {
    status = self player::function_3d288f14();
    assignment = self function_b919f6aa(status);
    if (!isdefined(assignment) || assignment == #"spectator") {
        assignment = function_959bac94();
    }
    if (!isdefined(assignment)) {
        assignment = function_ccb3bc7a(level.teams);
    }
    return assignment;
}

// Namespace teams/team_assignment
// Params 1, eflags: 0x1 linked
// Checksum 0x90b058ef, Offset: 0x828
// Size: 0x236
function function_5d02dd86(party) {
    if (!isdefined(party)) {
        println("<dev string:x38>" + "<dev string:x95>" + self.name + "<dev string:xbf>");
        return undefined;
    }
    if (party.var_a15e4438 <= 1) {
        println("<dev string:x38>" + "<dev string:x95>" + self.name + "<dev string:xdb>");
        return undefined;
    }
    foreach (member in party.party_members) {
        if (self == member) {
            continue;
        }
        if (member.team != "autoassign" && member.team != #"spectator" && member.team != #"none") {
            println("<dev string:x38>" + "<dev string:xf7>" + self.name + "<dev string:x11d>" + member.team + "<dev string:x12a>" + member.name);
            /#
                function_d28f6fa0(member.team);
            #/
            return member.team;
        }
    }
    println("<dev string:x38>" + "<dev string:x95>" + self.name + "<dev string:x13a>");
    return undefined;
}

// Namespace teams/team_assignment
// Params 0, eflags: 0x5 linked
// Checksum 0x1a467570, Offset: 0xa68
// Size: 0x1d8
function private function_650d105d() {
    teamkeys = array::randomize(getarraykeys(level.teams));
    assignment = undefined;
    playercounts = self count_players();
    if (teamplayercountsequal(playercounts)) {
        if (!level.splitscreen && self issplitscreen()) {
            assignment = self get_splitscreen_team();
            if (assignment == "") {
                assignment = function_dd2e9892(teamkeys);
            }
        } else {
            assignment = function_dd2e9892(teamkeys);
        }
        println("<dev string:x38>" + "<dev string:x16e>" + self.name + "<dev string:x174>" + function_2c846a74(assignment));
    } else {
        assignment = function_d078493a(playercounts);
        println("<dev string:x38>" + "<dev string:x16e>" + self.name + "<dev string:x1a6>" + function_2c846a74(assignment));
    }
    assert(isdefined(assignment));
    return assignment;
}

// Namespace teams/team_assignment
// Params 1, eflags: 0x1 linked
// Checksum 0x1cc15d61, Offset: 0xc48
// Size: 0xb8
function function_b0c92599(party) {
    /#
        var_f8896168 = getdvarint(#"hash_4cbf229ab691d987", 0);
        if (var_f8896168 && (var_f8896168 != 2 || self ishost())) {
            return false;
        }
    #/
    if (isdefined(level.var_7d3ed2bf) && level.var_7d3ed2bf && isdefined(party) && party.fill == 0) {
        return true;
    }
    return false;
}

// Namespace teams/team_assignment
// Params 1, eflags: 0x5 linked
// Checksum 0xcfe6da69, Offset: 0xd08
// Size: 0x1b8
function private function_868b679c(party) {
    if (level.teamcount == 0 && level.var_c58668ea && function_b0c92599(party)) {
        assignment = function_959bac94();
        println("<dev string:x38>" + "<dev string:x16e>" + self.name + "<dev string:x1d8>" + function_2c846a74(assignment));
    } else if (getdvarint(#"hash_587d8e03df4f4f8a", 0)) {
        assignment = function_ccb3bc7a(level.teams);
        println("<dev string:x38>" + "<dev string:x16e>" + self.name + "<dev string:x1fa>" + function_2c846a74(assignment));
    } else {
        assignment = self function_5c389625();
        println("<dev string:x38>" + "<dev string:x16e>" + self.name + "<dev string:x216>" + function_2c846a74(assignment));
    }
    return assignment;
}

// Namespace teams/team_assignment
// Params 0, eflags: 0x1 linked
// Checksum 0xeebb27bb, Offset: 0xec8
// Size: 0xfa
function function_bec6e9a() {
    party = self getparty();
    assignment = function_5d02dd86(party);
    if (isdefined(assignment)) {
        println("<dev string:x38>" + "<dev string:x16e>" + self.name + "<dev string:x237>" + function_2c846a74(assignment));
        return assignment;
    }
    max_players = player::function_d36b6597();
    if (level.multiteam && level.maxteamplayers > 0) {
        return function_868b679c();
    }
    return function_650d105d();
}

// Namespace teams/team_assignment
// Params 2, eflags: 0x1 linked
// Checksum 0x4a8dcd, Offset: 0xfd0
// Size: 0x12c
function function_b55ab4b3(comingfrommenu, var_4c542e39) {
    if (!comingfrommenu && var_4c542e39 === "spectator") {
        return var_4c542e39;
    }
    if (isdefined(level.var_4614c421) && [[ level.var_4614c421 ]]()) {
        return #"spectator";
    }
    clientnum = self getentitynumber();
    count = 0;
    foreach (team, _ in level.teams) {
        count++;
        if (count == clientnum + 1) {
            return team;
        }
    }
    return var_4c542e39;
}

// Namespace teams/team_assignment
// Params 2, eflags: 0x1 linked
// Checksum 0xb8440e43, Offset: 0x1108
// Size: 0x2d8
function function_d22a4fbb(comingfrommenu, var_4c542e39) {
    if (!isdefined(var_4c542e39)) {
        teamname = getassignedteamname(self);
    } else {
        teamname = var_4c542e39;
    }
    println("<dev string:x38>" + "<dev string:x259>" + self.name + "<dev string:x270>" + (comingfrommenu ? "<dev string:x276>" : "<dev string:x283>") + "<dev string:x294>" + (isdefined(var_4c542e39) ? function_2c846a74(var_4c542e39) : "<dev string:x299>"));
    if (teamname !== #"none" && !comingfrommenu) {
        assignment = teamname;
        println("<dev string:x38>" + "<dev string:x16e>" + self.name + "<dev string:x2ad>" + function_2c846a74(assignment));
    } else if (function_a3e209ba(teamname, comingfrommenu)) {
        assignment = #"spectator";
        println("<dev string:x38>" + "<dev string:x16e>" + self.name + "<dev string:x2c7>");
    } else if (isdefined(level.forcedplayerteam) && !isbot(self)) {
        assignment = level.forcedplayerteam;
        println("<dev string:x38>" + "<dev string:x16e>" + self.name + "<dev string:x2e6>" + function_2c846a74(assignment));
    } else {
        assignment = function_bec6e9a();
        assert(isdefined(assignment));
        if (function_582e5d7c()) {
            println("<dev string:x38>" + "<dev string:x16e>" + self.name + "<dev string:x2fe>" + self.botteam);
            return self.botteam;
        }
    }
    return assignment;
}

// Namespace teams/team_assignment
// Params 0, eflags: 0x1 linked
// Checksum 0xfd6a8e82, Offset: 0x13e8
// Size: 0xcc
function teamscoresequal() {
    score = undefined;
    foreach (team, _ in level.teams) {
        if (!isdefined(score)) {
            score = getteamscore(team);
            continue;
        }
        if (score != getteamscore(team)) {
            return false;
        }
    }
    return true;
}

// Namespace teams/team_assignment
// Params 0, eflags: 0x1 linked
// Checksum 0xe5559e7c, Offset: 0x14c0
// Size: 0xbe
function function_4818e9af() {
    score = 99999999;
    lowest_team = undefined;
    foreach (team, _ in level.teams) {
        if (score > getteamscore(team)) {
            lowest_team = team;
        }
    }
    return lowest_team;
}

// Namespace teams/team_assignment
// Params 1, eflags: 0x1 linked
// Checksum 0xc045a8ea, Offset: 0x1588
// Size: 0x72
function function_dd2e9892(teams) {
    assignment = #"allies";
    if (teamscoresequal()) {
        assignment = function_ccb3bc7a(teams);
    } else {
        assignment = function_4818e9af();
    }
    return assignment;
}

// Namespace teams/team_assignment
// Params 0, eflags: 0x1 linked
// Checksum 0x4b767d68, Offset: 0x1608
// Size: 0xce
function get_splitscreen_team() {
    for (index = 0; index < level.players.size; index++) {
        if (!isdefined(level.players[index])) {
            continue;
        }
        if (level.players[index] == self) {
            continue;
        }
        if (!self isplayeronsamemachine(level.players[index])) {
            continue;
        }
        team = level.players[index].sessionteam;
        if (team != #"spectator") {
            return team;
        }
    }
    return "";
}

// Namespace teams/team_assignment
// Params 1, eflags: 0x1 linked
// Checksum 0x34d8d219, Offset: 0x16e0
// Size: 0xb6
function teamplayercountsequal(playercounts) {
    count = undefined;
    foreach (team, _ in level.teams) {
        if (!isdefined(count)) {
            count = playercounts[team];
            continue;
        }
        if (count != playercounts[team]) {
            return false;
        }
    }
    return true;
}

// Namespace teams/team_assignment
// Params 1, eflags: 0x1 linked
// Checksum 0x5c4e57d4, Offset: 0x17a0
// Size: 0xbc
function function_d078493a(playercounts) {
    count = 9999;
    lowest_team = undefined;
    foreach (team, _ in level.teams) {
        if (count > playercounts[team]) {
            count = playercounts[team];
            lowest_team = team;
        }
    }
    return lowest_team;
}

// Namespace teams/team_assignment
// Params 1, eflags: 0x1 linked
// Checksum 0xe07a4458, Offset: 0x1868
// Size: 0x10
function function_321f8eb5(*player) {
    return true;
}

// Namespace teams/team_assignment
// Params 2, eflags: 0x1 linked
// Checksum 0xe103a91c, Offset: 0x1880
// Size: 0x106
function function_a3e209ba(teamname, comingfrommenu) {
    if (level.rankedmatch) {
        return false;
    }
    if (level.inprematchperiod) {
        return false;
    }
    if (teamname != #"none") {
        return false;
    }
    if (comingfrommenu) {
        return false;
    }
    if (self ishost()) {
        return false;
    }
    if (level.forceautoassign) {
        return false;
    }
    if (isbot(self)) {
        return false;
    }
    if (self issplitscreen()) {
        return false;
    }
    /#
        if (getdvarint(#"hash_4421e80faf4736fc", 0)) {
            return false;
        }
    #/
    if (![[ level.var_a3e209ba ]]()) {
        return false;
    }
    return true;
}

// Namespace teams/team_assignment
// Params 0, eflags: 0x1 linked
// Checksum 0x6affdb90, Offset: 0x1990
// Size: 0x64
function function_567994de() {
    if (!isdefined(level.teams[self.pers[#"team"]]) || level.var_c58668ea) {
        return #"none";
    }
    return self.pers[#"team"];
}

// Namespace teams/team_assignment
// Params 0, eflags: 0x1 linked
// Checksum 0xe38c56c6, Offset: 0x1a00
// Size: 0x192
function function_7d93567f() {
    distribution = [];
    foreach (player in level.players) {
        team = player function_567994de();
        squad = player.squad;
        if (squad == #"invalid") {
            continue;
        }
        if (!isdefined(distribution[team])) {
            distribution[team] = [];
        }
        if (!isdefined(distribution[team][squad])) {
            distribution[team][squad] = [];
        }
        if (!isdefined(distribution[team][squad])) {
            distribution[team][squad] = [];
        } else if (!isarray(distribution[team][squad])) {
            distribution[team][squad] = array(distribution[team][squad]);
        }
        distribution[team][squad][distribution[team][squad].size] = player;
    }
    return distribution;
}

// Namespace teams/team_assignment
// Params 1, eflags: 0x5 linked
// Checksum 0x4eab91a, Offset: 0x1ba0
// Size: 0x266
function private function_a119c7ef(distribution) {
    var_2def7656 = [];
    foreach (team, var_e08edbde in distribution) {
        if (!isdefined(var_2def7656[team])) {
            var_2def7656[team] = [];
        }
        for (i = 1; i < level.var_704bcca1; i++) {
            var_2def7656[team][i] = [];
        }
    }
    foreach (team, var_e08edbde in distribution) {
        if (!isdefined(var_2def7656[team])) {
            var_2def7656[team] = [];
        }
        foreach (squad, var_74578e76 in var_e08edbde) {
            if (var_74578e76.size < level.var_704bcca1) {
                var_a787dfe7 = function_46edfa55(var_74578e76);
                if (var_a787dfe7 > 0) {
                    if (!isdefined(var_2def7656[team][var_a787dfe7])) {
                        var_2def7656[team][var_a787dfe7] = [];
                    } else if (!isarray(var_2def7656[team][var_a787dfe7])) {
                        var_2def7656[team][var_a787dfe7] = array(var_2def7656[team][var_a787dfe7]);
                    }
                    var_2def7656[team][var_a787dfe7][var_2def7656[team][var_a787dfe7].size] = squad;
                }
            }
        }
    }
    return var_2def7656;
}

// Namespace teams/team_assignment
// Params 4, eflags: 0x1 linked
// Checksum 0xe097f28, Offset: 0x1e10
// Size: 0x15a
function function_569914e8(var_e439f5d6, var_a9ab69de, *var_d9438b7, var_f36ce5dd) {
    foreach (var_a787dfe7, var_2a80e9e0 in var_f36ce5dd) {
        if (level.var_704bcca1 - var_a787dfe7 > var_d9438b7) {
            continue;
        }
        if (var_2a80e9e0.size == 0) {
            continue;
        }
        foreach (squad in var_2a80e9e0) {
            if (squad == #"none") {
                continue;
            }
            if (squad == var_a9ab69de) {
                continue;
            }
            return squad;
        }
    }
    return undefined;
}

// Namespace teams/team_assignment
// Params 1, eflags: 0x5 linked
// Checksum 0x81e502d5, Offset: 0x1f78
// Size: 0xf2
function private function_5e84fc28(var_68253610) {
    team = #"none";
    var_d549939e = function_c65231e2(var_68253610);
    foreach (player in var_d549939e) {
        team = player.pers[#"team"];
        if (isdefined(level.teams[team])) {
            return team;
        }
    }
    return #"none";
}

// Namespace teams/team_assignment
// Params 2, eflags: 0x5 linked
// Checksum 0xbfa65b, Offset: 0x2078
// Size: 0xf6
function private function_8c162ba0(var_8de04fca, var_68253610) {
    new_team = function_5e84fc28(var_68253610);
    players = function_c65231e2(var_8de04fca);
    foreach (player in players) {
        player function_dc7eaabd(new_team);
        player squads::function_ff3321ee(var_68253610);
    }
    return players.size;
}

// Namespace teams/team_assignment
// Params 0, eflags: 0x1 linked
// Checksum 0xeb3433c4, Offset: 0x2178
// Size: 0x574
function function_344e464d() {
    if (getdvarint(#"hash_761d80face4c4459", 1)) {
        return;
    }
    customgame = gamemodeismode(1) || gamemodeismode(7);
    if (customgame) {
        return;
    }
    distribution = function_7d93567f();
    var_f36ce5dd = function_a119c7ef(distribution);
    /#
        if (level.var_ba13fb7a) {
            println("<dev string:x38>" + "<dev string:x31e>");
            function_a9bfa6d6();
            println("<dev string:x38>" + "<dev string:x334>");
        }
    #/
    foreach (team, var_e08edbde in var_f36ce5dd) {
        println("<dev string:x353>" + team);
        foreach (var_a787dfe7, var_2a80e9e0 in var_e08edbde) {
            foreach (index, squad in var_2a80e9e0) {
                if (squad == #"none") {
                    continue;
                }
                for (current_count = level.var_704bcca1 - var_a787dfe7; current_count < level.var_704bcca1; current_count += function_8c162ba0(var_d28e4159, squad)) {
                    var_d28e4159 = function_569914e8(squad, level.var_704bcca1 - current_count, distribution[squad], var_f36ce5dd[team]);
                    if (!isdefined(var_d28e4159)) {
                        break;
                    }
                    var_74578e76 = function_c65231e2(squad);
                    var_fd72a4f = function_c65231e2(var_d28e4159);
                    assert(function_c65231e2(squad).size + function_c65231e2(var_d28e4159).size <= level.var_704bcca1);
                    println("<dev string:x35c>" + var_f36ce5dd[team].size);
                    foreach (var_1e066fba in var_f36ce5dd[team]) {
                        println("<dev string:x371>" + var_1e066fba.size);
                        foreach (remove_index, var_16ba986d in var_1e066fba) {
                            if (var_16ba986d == var_d28e4159) {
                                var_1e066fba[remove_index] = #"none";
                            }
                        }
                    }
                }
                var_2a80e9e0[index] = #"none";
            }
        }
    }
    /#
        if (level.var_ba13fb7a) {
            println("<dev string:x38>" + "<dev string:x38a>");
            function_a9bfa6d6();
        }
    #/
}

/#

    // Namespace teams/team_assignment
    // Params 0, eflags: 0x4
    // Checksum 0x24dfb9c3, Offset: 0x26f8
    // Size: 0xa0
    function private function_a9bfa6d6() {
        if (level.var_ba13fb7a) {
            foreach (team in level.teams) {
                self thread function_6c66cc64(team);
            }
        }
    }

#/

// Namespace teams/team_assignment
// Params 1, eflags: 0x0
// Checksum 0x6fdb4b00, Offset: 0x27a0
// Size: 0x5a
function function_2c846a74(team) {
    /#
        team_str = string(team);
        if (isdefined(level.teams[team])) {
            team_str = level.teams[team];
        }
        return team_str;
    #/
}

/#

    // Namespace teams/team_assignment
    // Params 1, eflags: 0x4
    // Checksum 0xd3768807, Offset: 0x2808
    // Size: 0x2b0
    function private function_6c66cc64(team) {
        players = getplayers(team);
        if (players.size == 0) {
            return;
        }
        team_str = function_2c846a74(team);
        voip = "<dev string:x3a9>";
        if (isdefined(level.var_75dffa9f[team])) {
            voip += level.var_75dffa9f[team] == #"game" ? "<dev string:x3b2>" : "<dev string:x3ba>";
        } else {
            voip += "<dev string:x3c4>";
        }
        println("<dev string:x38>" + "<dev string:x294>" + team_str + "<dev string:x294>" + voip);
        foreach (player in players) {
            squad = player.squad;
            var_bdb3f6a6 = undefined;
            if (squad == #"invalid") {
                var_bdb3f6a6 = "<dev string:x3d1>";
            } else if (squad == #"none") {
                var_bdb3f6a6 = "<dev string:x3dc>";
            } else if (isdefined(level.squads[squad])) {
                var_bdb3f6a6 = level.squads[squad].name;
            }
            party = player getparty();
            println("<dev string:x38>" + "<dev string:x16e>" + player.name + "<dev string:x3e4>" + var_bdb3f6a6 + "<dev string:x3f2>" + (party.fill ? "<dev string:x3fe>" : "<dev string:x405>") + "<dev string:x40b>" + party.var_a15e4438);
        }
    }

    // Namespace teams/team_assignment
    // Params 0, eflags: 0x0
    // Checksum 0x3a71aead, Offset: 0x2ac0
    // Size: 0x43c
    function function_58b6d2c9() {
        if (level.multiteam && level.maxteamplayers > 0) {
            max_players = player::function_d36b6597();
            players = getplayers();
            foreach (team in level.teams) {
                var_dcbb8617 = getplayers(team);
                if (var_dcbb8617.size > max_players) {
                    var_f554d31e = "<dev string:x415>";
                    foreach (player in var_dcbb8617) {
                        party = player getparty();
                        var_f554d31e = var_f554d31e + player.name + "<dev string:x419>" + party.party_id + "<dev string:x427>";
                    }
                    assertmsg("<dev string:x42c>" + self.name + "<dev string:x442>" + (ishash(team) ? function_9e72a96(team) : team) + "<dev string:x468>" + var_dcbb8617.size + "<dev string:x47d>" + level.maxteamplayers + "<dev string:x427>" + var_f554d31e);
                }
            }
            if (!level.custommatch) {
                foreach (player in players) {
                    if (player.team == #"spectator") {
                        continue;
                    }
                    party = player getparty();
                    foreach (party_member in party.party_members) {
                        if (party_member.team == #"spectator") {
                            continue;
                        }
                        if (party_member.team != player.team) {
                            assertmsg("<dev string:x48e>" + player.name + "<dev string:x4bd>" + function_9e72a96(player.team) + "<dev string:x4c3>" + party_member.name + "<dev string:x4bd>" + function_9e72a96(party_member.team) + "<dev string:x4c9>");
                        }
                    }
                }
            }
        }
    }

    // Namespace teams/team_assignment
    // Params 0, eflags: 0x0
    // Checksum 0x791bd7cf, Offset: 0x2f08
    // Size: 0x14c
    function function_1aa0418f() {
        while (true) {
            wait 3;
            players = getplayers();
            if (players.size > 0 && players[0] isstreamerready()) {
                setdvar(#"devgui_bot", "<dev string:x4d0>");
                wait 3;
                function_344e464d();
                wait 1;
                bots = bot::get_bots();
                foreach (bot in bots) {
                    level thread bot::remove_bot(bot);
                }
            }
        }
    }

#/
