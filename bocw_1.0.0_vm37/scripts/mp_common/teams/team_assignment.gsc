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
// Checksum 0x52ec5117, Offset: 0xc0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"team_assignment", &preinit, undefined, undefined, undefined);
}

// Namespace teams/team_assignment
// Params 0, eflags: 0x4
// Checksum 0xf4ecbbc6, Offset: 0x108
// Size: 0x5c
function private preinit() {
    if (!isdefined(level.var_a3e209ba)) {
        level.var_a3e209ba = &function_321f8eb5;
    }
    /#
        level.var_ba13fb7a = getdvarint(#"hash_40fe9055da22add4", 1);
    #/
}

// Namespace teams/team_assignment
// Params 0, eflags: 0x0
// Checksum 0x1b9eb74a, Offset: 0x170
// Size: 0x26
function get_assigned_team() {
    teamname = getassignedteamname(self);
}

// Namespace teams/team_assignment
// Params 0, eflags: 0x0
// Checksum 0xed0b616d, Offset: 0x1a0
// Size: 0x36
function function_2ba5e3e6() {
    var_ac46c774 = util::gethostplayerforbots();
    if (isdefined(var_ac46c774)) {
        return var_ac46c774.team;
    }
    return "";
}

// Namespace teams/team_assignment
// Params 0, eflags: 0x0
// Checksum 0xf2349e30, Offset: 0x1e0
// Size: 0x8e
function function_582e5d7c() {
    max_players = player::function_d36b6597();
    return isbot(self) && isdefined(self.botteam) && self.botteam != "autoassign" && (max_players == 0 || getplayers(self.botteam).size < max_players);
}

// Namespace teams/team_assignment
// Params 1, eflags: 0x0
// Checksum 0x7b0b2aa2, Offset: 0x278
// Size: 0x3c
function function_ee150fcc(team_players) {
    max_players = player::function_d36b6597();
    return max_players - player::function_1cec6cba(team_players);
}

// Namespace teams/team_assignment
// Params 1, eflags: 0x0
// Checksum 0x461ad749, Offset: 0x2c0
// Size: 0x2c
function function_46edfa55(team_players) {
    return level.var_704bcca1 - player::function_1cec6cba(team_players);
}

// Namespace teams/team_assignment
// Params 1, eflags: 0x0
// Checksum 0xf887c9ba, Offset: 0x2f8
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
    available_spots = function_ee150fcc(team_players);
    party = self getparty();
    if (party.var_a15e4438 > available_spots) {
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
// Params 1, eflags: 0x0
// Checksum 0x8a15c84f, Offset: 0x468
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
// Params 1, eflags: 0x0
// Checksum 0x3421293b, Offset: 0x5a0
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
// Params 0, eflags: 0x0
// Checksum 0xbb910b52, Offset: 0x770
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
// Params 1, eflags: 0x0
// Checksum 0x4b7018ac, Offset: 0x828
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
// Params 0, eflags: 0x4
// Checksum 0x69c93fd3, Offset: 0xa68
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
// Params 1, eflags: 0x0
// Checksum 0xef5d7893, Offset: 0xc48
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
// Params 1, eflags: 0x4
// Checksum 0x75c5cc8a, Offset: 0xd08
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
// Params 0, eflags: 0x0
// Checksum 0xb46b3fa6, Offset: 0xec8
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
// Params 2, eflags: 0x0
// Checksum 0x592253bd, Offset: 0xfd0
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
// Params 1, eflags: 0x0
// Checksum 0x43169e36, Offset: 0x1108
// Size: 0x18a
function function_3efc8e60(var_e63a1390) {
    var_5df260bb = 0;
    squad_index = 0;
    foreach (key, squad in level.squads) {
        if (key == var_e63a1390) {
            var_5df260bb = 1;
            break;
        }
        squad_index++;
    }
    assert(var_5df260bb);
    assert(squad_index < level.teams.size);
    foreach (key, team in level.teams) {
        if (0 == squad_index) {
            return team;
        }
        squad_index--;
    }
    assert(0);
    return #"none";
}

// Namespace teams/team_assignment
// Params 3, eflags: 0x0
// Checksum 0xc5593e77, Offset: 0x12a0
// Size: 0x328
function function_d22a4fbb(comingfrommenu, var_4c542e39, var_432c77c2) {
    teamname = var_4c542e39;
    if (!isdefined(teamname)) {
        teamname = #"none";
    }
    squad_name = var_432c77c2;
    if (!isdefined(squad_name)) {
        squad_name = #"none";
    }
    println("<dev string:x38>" + "<dev string:x259>" + self.name + "<dev string:x270>" + (comingfrommenu ? "<dev string:x276>" : "<dev string:x283>") + "<dev string:x294>" + (isdefined(var_4c542e39) ? function_2c846a74(var_4c542e39) : "<dev string:x299>"));
    if (level.teamcount > 2 && squad_name !== #"none" && !comingfrommenu) {
        assignment = function_3efc8e60(squad_name);
        println("<dev string:x38>" + "<dev string:x16e>" + self.name + "<dev string:x2ad>" + squad_name + "<dev string:x2c8>" + function_2c846a74(assignment));
    } else if (teamname !== #"none" && !comingfrommenu) {
        assignment = teamname;
        println("<dev string:x38>" + "<dev string:x16e>" + self.name + "<dev string:x2e0>" + function_2c846a74(assignment));
    } else if (function_a3e209ba(teamname, comingfrommenu)) {
        assignment = #"spectator";
        println("<dev string:x38>" + "<dev string:x16e>" + self.name + "<dev string:x2fa>");
    }
    if (!isdefined(assignment)) {
        assignment = function_bec6e9a();
        assert(isdefined(assignment));
        if (function_582e5d7c()) {
            println("<dev string:x38>" + "<dev string:x16e>" + self.name + "<dev string:x319>" + self.botteam);
            return self.botteam;
        }
    }
    return assignment;
}

// Namespace teams/team_assignment
// Params 0, eflags: 0x0
// Checksum 0x2b837b6e, Offset: 0x15d0
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
// Params 0, eflags: 0x0
// Checksum 0x4b61b21, Offset: 0x16a8
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
// Params 1, eflags: 0x0
// Checksum 0xe5da0804, Offset: 0x1770
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
// Params 0, eflags: 0x0
// Checksum 0x75603475, Offset: 0x17f0
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
// Params 1, eflags: 0x0
// Checksum 0x2df6454f, Offset: 0x18c8
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
// Params 1, eflags: 0x0
// Checksum 0xc2a9a65, Offset: 0x1988
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
// Params 1, eflags: 0x0
// Checksum 0x71ac4b7f, Offset: 0x1a50
// Size: 0x10
function function_321f8eb5(*player) {
    return true;
}

// Namespace teams/team_assignment
// Params 2, eflags: 0x0
// Checksum 0x289b730f, Offset: 0x1a68
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
// Params 0, eflags: 0x0
// Checksum 0x16238d9c, Offset: 0x1b78
// Size: 0x64
function function_567994de() {
    if (!isdefined(level.teams[self.pers[#"team"]]) || level.var_c58668ea) {
        return #"none";
    }
    return self.pers[#"team"];
}

// Namespace teams/team_assignment
// Params 0, eflags: 0x0
// Checksum 0x473bb318, Offset: 0x1be8
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
// Params 1, eflags: 0x4
// Checksum 0x460a86f, Offset: 0x1d88
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
// Params 4, eflags: 0x0
// Checksum 0x529c8960, Offset: 0x1ff8
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
// Params 1, eflags: 0x4
// Checksum 0x84ad738a, Offset: 0x2160
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
// Params 2, eflags: 0x4
// Checksum 0x793767ad, Offset: 0x2260
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
// Params 0, eflags: 0x0
// Checksum 0x232472c2, Offset: 0x2360
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
            println("<dev string:x38>" + "<dev string:x339>");
            function_a9bfa6d6();
            println("<dev string:x38>" + "<dev string:x34f>");
        }
    #/
    foreach (team, var_e08edbde in var_f36ce5dd) {
        println("<dev string:x36e>" + team);
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
                    println("<dev string:x377>" + var_f36ce5dd[team].size);
                    foreach (var_1e066fba in var_f36ce5dd[team]) {
                        println("<dev string:x38c>" + var_1e066fba.size);
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
            println("<dev string:x38>" + "<dev string:x3a5>");
            function_a9bfa6d6();
        }
    #/
}

/#

    // Namespace teams/team_assignment
    // Params 0, eflags: 0x4
    // Checksum 0xae186714, Offset: 0x28e0
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
// Checksum 0x179adfb1, Offset: 0x2988
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
    // Checksum 0xc5c53286, Offset: 0x29f0
    // Size: 0x2b0
    function private function_6c66cc64(team) {
        players = getplayers(team);
        if (players.size == 0) {
            return;
        }
        team_str = function_2c846a74(team);
        voip = "<dev string:x3c4>";
        if (isdefined(level.var_75dffa9f[team])) {
            voip += level.var_75dffa9f[team] == #"game" ? "<dev string:x3cd>" : "<dev string:x3d5>";
        } else {
            voip += "<dev string:x3df>";
        }
        println("<dev string:x38>" + "<dev string:x294>" + team_str + "<dev string:x294>" + voip);
        foreach (player in players) {
            squad = player.squad;
            squad_name = undefined;
            if (squad == #"invalid") {
                squad_name = "<dev string:x3ec>";
            } else if (squad == #"none") {
                squad_name = "<dev string:x3f7>";
            } else if (isdefined(level.squads[squad])) {
                squad_name = level.squads[squad].name;
            }
            party = player getparty();
            println("<dev string:x38>" + "<dev string:x16e>" + player.name + "<dev string:x3ff>" + squad_name + "<dev string:x40d>" + (party.fill ? "<dev string:x419>" : "<dev string:x420>") + "<dev string:x426>" + party.var_a15e4438);
        }
    }

    // Namespace teams/team_assignment
    // Params 0, eflags: 0x0
    // Checksum 0xc6d1330e, Offset: 0x2ca8
    // Size: 0x43c
    function function_58b6d2c9() {
        if (level.multiteam && level.maxteamplayers > 0) {
            max_players = player::function_d36b6597();
            players = getplayers();
            foreach (team in level.teams) {
                var_dcbb8617 = getplayers(team);
                if (var_dcbb8617.size > max_players) {
                    var_f554d31e = "<dev string:x430>";
                    foreach (player in var_dcbb8617) {
                        party = player getparty();
                        var_f554d31e = var_f554d31e + player.name + "<dev string:x434>" + party.party_id + "<dev string:x442>";
                    }
                    assertmsg("<dev string:x447>" + self.name + "<dev string:x45d>" + (ishash(team) ? function_9e72a96(team) : team) + "<dev string:x483>" + var_dcbb8617.size + "<dev string:x498>" + level.maxteamplayers + "<dev string:x442>" + var_f554d31e);
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
                            assertmsg("<dev string:x4a9>" + player.name + "<dev string:x4d8>" + function_9e72a96(player.team) + "<dev string:x4de>" + party_member.name + "<dev string:x4d8>" + function_9e72a96(party_member.team) + "<dev string:x4e4>");
                        }
                    }
                }
            }
        }
    }

    // Namespace teams/team_assignment
    // Params 0, eflags: 0x0
    // Checksum 0x84b1b1c9, Offset: 0x30f0
    // Size: 0x14c
    function function_1aa0418f() {
        while (true) {
            wait 3;
            players = getplayers();
            if (players.size > 0 && players[0] isstreamerready()) {
                setdvar(#"devgui_bot", "<dev string:x4eb>");
                wait 3;
                function_344e464d();
                wait 1;
                bots = get_bots();
                foreach (bot in bots) {
                    level thread bot::remove_bot(bot);
                }
            }
        }
    }

    // Namespace teams/team_assignment
    // Params 0, eflags: 0x0
    // Checksum 0xf36cc0a1, Offset: 0x3248
    // Size: 0xcc
    function get_bots() {
        players = getplayers();
        bots = [];
        foreach (player in players) {
            if (isbot(player)) {
                bots[bots.size] = player;
            }
        }
        return bots;
    }

#/
