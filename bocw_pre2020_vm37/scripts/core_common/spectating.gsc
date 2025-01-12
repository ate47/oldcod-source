#using script_7dc3a36c222eaf22;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\system_shared;

#namespace spectating;

// Namespace spectating/spectating
// Params 0, eflags: 0x6
// Checksum 0xdaf43d00, Offset: 0xb8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"spectating", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace spectating/spectating
// Params 0, eflags: 0x5 linked
// Checksum 0xbc2adffa, Offset: 0x100
// Size: 0xa4
function private function_70a657d8() {
    callback::on_start_gametype(&init);
    callback::on_spawned(&set_permissions);
    callback::on_joined_team(&set_permissions_for_machine);
    callback::on_joined_spectate(&set_permissions_for_machine);
    callback::on_player_killed(&on_player_killed);
}

// Namespace spectating/spectating
// Params 0, eflags: 0x1 linked
// Checksum 0xb2b6d31b, Offset: 0x1b0
// Size: 0x94
function init() {
    foreach (team, _ in level.teams) {
        level.spectateoverride[team] = spawnstruct();
    }
}

// Namespace spectating/spectating
// Params 0, eflags: 0x1 linked
// Checksum 0x2b49ac25, Offset: 0x250
// Size: 0xa0
function update_settings() {
    level endon(#"game_ended");
    foreach (player in level.players) {
        player set_permissions();
    }
}

// Namespace spectating/spectating
// Params 0, eflags: 0x1 linked
// Checksum 0x81724c5b, Offset: 0x2f8
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
    return self.sessionteam;
}

// Namespace spectating/spectating
// Params 0, eflags: 0x1 linked
// Checksum 0x68e1a348, Offset: 0x3d0
// Size: 0xb6
function other_local_player_still_alive() {
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
        if (isalive(level.players[index])) {
            return true;
        }
    }
    return false;
}

// Namespace spectating/spectating
// Params 0, eflags: 0x1 linked
// Checksum 0x3dc32ff4, Offset: 0x490
// Size: 0x5f4
function set_permissions() {
    team = self.sessionteam;
    if (team == #"spectator") {
        if (self issplitscreen() && !level.splitscreen) {
            team = get_splitscreen_team();
        }
        if (team == #"spectator") {
            self.spectatorteam = #"invalid";
            self allowspectateallteams(1);
            self allowspectateteam("freelook", 0);
            self allowspectateteam(#"none", 1);
            self allowspectateteam("localplayers", 1);
            return;
        }
    }
    self allowspectateallteams(0);
    self allowspectateteam("localplayers", 1);
    self allowspectateteam("freelook", 0);
    switch (level.spectatetype) {
    case 0:
        self.spectatorteam = #"invalid";
        self allowspectateteam(#"none", 1);
        self allowspectateteam("localplayers", 0);
        break;
    case 3:
        self.spectatorteam = #"invalid";
        if (self issplitscreen() && self other_local_player_still_alive()) {
            self allowspectateteam(#"none", 0);
            break;
        }
    case 1:
        self.spectatorteam = #"invalid";
        if (!level.teambased) {
            self allowspectateallteams(1);
            self allowspectateteam(#"none", 1);
        } else if (isdefined(team) && isdefined(level.teams[team])) {
            self allowspectateteam(team, 1);
            self allowspectateteam(#"none", 0);
        } else {
            self allowspectateteam(#"none", 0);
        }
        break;
    case 6:
        self.spectatorteam = team;
        self allowspectateteam(#"none", 0);
        self allowspectateteam(team, 1);
        break;
    case 2:
        self.spectatorteam = #"invalid";
        self allowspectateteam(#"none", 1);
        self allowspectateallteams(1);
        foreach (team in level.teams) {
            if (self.team == team) {
                continue;
            }
            self allowspectateteam(team, 1);
        }
        break;
    case 4:
    case 5:
        return;
    }
    if (isdefined(team) && isdefined(level.teams[team])) {
        if (isdefined(level.spectateoverride[team].allowfreespectate)) {
            self allowspectateteam("freelook", 1);
        }
        if (isdefined(level.spectateoverride[team].allowenemyspectate)) {
            if (level.spectateoverride[team].allowenemyspectate == #"all") {
                self allowspectateallteams(1);
                return;
            }
            self allowspectateallteams(0);
            self allowspectateteam(level.spectateoverride[team].allowenemyspectate, 1);
        }
    }
}

// Namespace spectating/spectating
// Params 2, eflags: 0x1 linked
// Checksum 0xe2c98e5e, Offset: 0xa90
// Size: 0x10e
function function_18b8b7e4(players, origin) {
    if (!isdefined(players) || players.size == 0) {
        return undefined;
    }
    sorted_players = arraysort(players, origin);
    foreach (player in sorted_players) {
        if (player == self) {
            continue;
        }
        if (!isalive(player)) {
            continue;
        }
        if (player laststand::player_is_in_laststand()) {
            continue;
        }
        return player;
    }
    return undefined;
}

// Namespace spectating/spectating
// Params 1, eflags: 0x1 linked
// Checksum 0xa0a9573e, Offset: 0xba8
// Size: 0x16
function spectator_team(player) {
    return player.spectatorteam;
}

// Namespace spectating/spectating
// Params 1, eflags: 0x1 linked
// Checksum 0x8322be83, Offset: 0xbc8
// Size: 0x16
function function_44d43a69(player) {
    return player.var_ba35b2d2;
}

// Namespace spectating/spectating
// Params 3, eflags: 0x1 linked
// Checksum 0xdbd5f00a, Offset: 0xbe8
// Size: 0xb4
function function_9c5853f5(players, var_22b78352, var_89bd5332) {
    foreach (player in players) {
        if (player != self && [[ var_22b78352 ]](player) != var_89bd5332) {
            return player;
        }
    }
    return undefined;
}

// Namespace spectating/spectating
// Params 3, eflags: 0x0
// Checksum 0x5f2aca1, Offset: 0xca8
// Size: 0x1b6
function function_327e6270(players, var_22b78352, var_89bd5332) {
    if (!isdefined(players) || players.size == 0) {
        return self;
    }
    player = function_18b8b7e4(players, self.origin);
    if (isdefined(player)) {
        println("<dev string:x38>" + [[ var_22b78352 ]](player) + "<dev string:x51>" + self.name + "<dev string:x5a>" + [[ var_22b78352 ]](self) + "<dev string:x68>" + player.name + "<dev string:x75>");
        return player;
    }
    player = function_9c5853f5(players, var_22b78352, var_89bd5332);
    if (isdefined(player)) {
        println("<dev string:x38>" + [[ var_22b78352 ]](player) + "<dev string:x51>" + self.name + "<dev string:x5a>" + [[ var_22b78352 ]](self) + "<dev string:x68>" + player.name + "<dev string:x82>");
        return player;
    }
    println("<dev string:x38>" + [[ var_22b78352 ]](self) + "<dev string:x51>" + self.name + "<dev string:x9e>");
    return self;
}

// Namespace spectating/spectating
// Params 4, eflags: 0x1 linked
// Checksum 0xb182295c, Offset: 0xe68
// Size: 0x170
function function_460b3788(players, var_22b78352, var_89bd5332, var_c9fe8766) {
    if (!isdefined(players) || players.size == 0) {
        return undefined;
    }
    var_156b3879 = self function_18b8b7e4(players, self.origin);
    if (isdefined(var_156b3879) && isplayer(var_156b3879)) {
        return var_156b3879;
    }
    target = function_9c5853f5(players, var_22b78352, var_89bd5332);
    if (isdefined(target)) {
        return target;
    }
    if (var_c9fe8766) {
        teammates = function_a1ef346b(self.team);
        return self function_460b3788(teammates, &spectator_team, #"invalid", 0);
    }
    target = array::random(function_a1ef346b());
    if (isdefined(target)) {
        return target;
    }
    return undefined;
}

// Namespace spectating/spectating
// Params 0, eflags: 0x1 linked
// Checksum 0x277dde60, Offset: 0xfe0
// Size: 0xfc
function function_4c37bb21() {
    players = undefined;
    if (self.team != #"spectator") {
        players = function_a1ef346b(self.team);
    }
    var_156b3879 = self function_460b3788(players, &spectator_team, #"invalid", 0);
    if (isdefined(var_156b3879) && isplayer(var_156b3879)) {
        self.spectatorteam = var_156b3879.team;
        if (self.sessionstate !== "playing") {
            self setcurrentspectatorclient(var_156b3879);
        }
        return var_156b3879;
    }
    return undefined;
}

// Namespace spectating/spectating
// Params 0, eflags: 0x1 linked
// Checksum 0xc9a50e88, Offset: 0x10e8
// Size: 0xfc
function function_10fbd7e5() {
    players = undefined;
    if (self.team != #"spectator") {
        players = function_a1cff525(self.squad);
    }
    var_156b3879 = self function_460b3788(players, &function_44d43a69, #"invalid", 1);
    if (isdefined(var_156b3879) && isplayer(var_156b3879)) {
        self.spectatorteam = var_156b3879.team;
        if (self.sessionstate !== "playing") {
            self setcurrentspectatorclient(var_156b3879);
        }
        return var_156b3879;
    }
    return undefined;
}

// Namespace spectating/spectating
// Params 0, eflags: 0x1 linked
// Checksum 0x7e3d87c3, Offset: 0x11f0
// Size: 0x86
function function_da128b1() {
    if (level.spectatetype == 5 && self.var_ba35b2d2 != #"invalid") {
        return function_10fbd7e5();
    }
    if (level.spectatetype == 4 && self.spectatorteam != #"invalid") {
        return function_4c37bb21();
    }
    return undefined;
}

// Namespace spectating/spectating
// Params 0, eflags: 0x1 linked
// Checksum 0xb05769c2, Offset: 0x1280
// Size: 0xf4
function set_permissions_for_machine() {
    self function_da128b1();
    self set_permissions();
    if (!self issplitscreen()) {
        return;
    }
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
        level.players[index] set_permissions();
    }
}

// Namespace spectating/spectating
// Params 0, eflags: 0x1 linked
// Checksum 0x3374a0d5, Offset: 0x1380
// Size: 0x6e
function function_7d15f599() {
    livesleft = !(level.numlives && !self.pers[#"lives"]);
    if (!function_a1ef346b(self.team).size && !livesleft) {
        return false;
    }
    return true;
}

// Namespace spectating/spectating
// Params 0, eflags: 0x0
// Checksum 0x5d44bcd4, Offset: 0x13f8
// Size: 0x3c
function function_23c5f4f2() {
    self endon(#"disconnect");
    waitframe(1);
    function_493d2e03(#"all");
}

// Namespace spectating/spectating
// Params 1, eflags: 0x5 linked
// Checksum 0x137c42ff, Offset: 0x1440
// Size: 0x5c
function private function_493d2e03(team) {
    if (!self function_7d15f599()) {
        level.spectateoverride[self.team].allowenemyspectate = team;
        update_settings();
    }
}

// Namespace spectating/spectating
// Params 1, eflags: 0x0
// Checksum 0x1cde099a, Offset: 0x14a8
// Size: 0xb8
function function_34460764(team) {
    players = getplayers(team);
    foreach (player in players) {
        player allowspectateallteams(1);
    }
}

// Namespace spectating/spectating
// Params 2, eflags: 0x0
// Checksum 0x679caa1, Offset: 0x1568
// Size: 0xe8
function function_ef775048(team, var_6f1b46b8) {
    self endon(#"disconnect");
    waitframe(1);
    if (function_a1ef346b(team).size) {
        return;
    }
    players = getplayers(team);
    foreach (player in players) {
        player function_493d2e03(var_6f1b46b8);
    }
}

// Namespace spectating/spectating
// Params 1, eflags: 0x1 linked
// Checksum 0x6db991d2, Offset: 0x1658
// Size: 0x56
function follow_chain(var_41349818) {
    if (!isdefined(var_41349818)) {
        return;
    }
    while (isdefined(var_41349818) && var_41349818.spectatorclient != -1) {
        var_41349818 = getentbynum(var_41349818.spectatorclient);
    }
    return var_41349818;
}

// Namespace spectating/spectating
// Params 2, eflags: 0x1 linked
// Checksum 0x6a818ed4, Offset: 0x16b8
// Size: 0xe6
function function_93281015(players, attacker) {
    if (!isdefined(self) || !isdefined(self.team)) {
        return undefined;
    }
    var_1178af52 = isdefined(attacker) && isplayer(attacker) && attacker != self && isalive(attacker);
    if (var_1178af52 && attacker.team == self.team) {
        return attacker;
    }
    friendly = function_18b8b7e4(players, self.origin);
    if (isdefined(friendly)) {
        return friendly;
    }
    return undefined;
}

// Namespace spectating/spectating
// Params 2, eflags: 0x0
// Checksum 0x8c9454aa, Offset: 0x17a8
// Size: 0x78
function function_e34c084d(*players, attacker) {
    var_1178af52 = isdefined(attacker) && isplayer(attacker) && attacker != self && isalive(attacker);
    if (var_1178af52) {
        return attacker;
    }
    return undefined;
}

// Namespace spectating/spectating
// Params 0, eflags: 0x5 linked
// Checksum 0x194198cc, Offset: 0x1828
// Size: 0xd2
function private function_770d7902() {
    assert(level.spectatetype == 4 || level.spectatetype == 5);
    switch (level.spectatetype) {
    case 5:
        players = function_a1cff525(self.squad);
        if (players.size > 0) {
            return players;
        }
    case 4:
    default:
        return function_a1ef346b(self.team);
    }
}

// Namespace spectating/spectating
// Params 1, eflags: 0x1 linked
// Checksum 0x415354e8, Offset: 0x1908
// Size: 0x7c
function function_26c5324a(var_156b3879) {
    self.spectatorclient = -1;
    self.spectatorteam = var_156b3879.team;
    self setcurrentspectatorclient(var_156b3879);
    self callback::callback(#"hash_37840d0d5a10e6b8", {#client:var_156b3879});
}

// Namespace spectating/spectating
// Params 1, eflags: 0x1 linked
// Checksum 0xfbe6e0df, Offset: 0x1990
// Size: 0xcc
function function_2b728d67(attacker) {
    players = function_770d7902();
    var_8447710e = player::figure_out_attacker(attacker);
    var_156b3879 = self function_93281015(players, var_8447710e);
    if (isdefined(var_156b3879)) {
        function_836ee9ed(var_156b3879);
        return;
    }
    if (!isdefined(level.var_18c9a2d1)) {
        level.var_18c9a2d1 = &function_7fe9c0d1;
    }
    [[ level.var_18c9a2d1 ]](players, attacker);
}

// Namespace spectating/spectating
// Params 1, eflags: 0x1 linked
// Checksum 0xae1664c5, Offset: 0x1a68
// Size: 0x6e
function function_836ee9ed(var_156b3879) {
    var_156b3879 = follow_chain(var_156b3879);
    if (isdefined(var_156b3879) && isplayer(var_156b3879)) {
        function_26c5324a(var_156b3879);
        return;
    }
    self.spectatorteam = self.team;
}

// Namespace spectating/spectating
// Params 2, eflags: 0x1 linked
// Checksum 0x2692f82d, Offset: 0x1ae0
// Size: 0xb4
function function_7fe9c0d1(*players, attacker) {
    var_1178af52 = isdefined(attacker) && isplayer(attacker) && attacker != self && isalive(attacker);
    if (var_1178af52) {
        var_156b3879 = attacker;
    }
    if (!isdefined(var_156b3879)) {
        var_156b3879 = self function_da128b1();
    }
    function_836ee9ed(var_156b3879);
}

// Namespace spectating/spectating
// Params 1, eflags: 0x1 linked
// Checksum 0x1b527374, Offset: 0x1ba0
// Size: 0xb4
function on_player_killed(params) {
    if (level.spectatetype == 4 || level.spectatetype == 5) {
        self thread function_2b728d67(params.eattacker);
        if (level.var_1ba484ad == 2 || self namespace_8a203916::function_500047aa(1)) {
            self namespace_8a203916::function_86df9236();
            return;
        }
        self namespace_8a203916::function_888901cb();
    }
}

