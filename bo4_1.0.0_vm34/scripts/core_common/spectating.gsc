#using scripts\core_common\callbacks_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\system_shared;

#namespace spectating;

// Namespace spectating/spectating
// Params 0, eflags: 0x2
// Checksum 0x681e17b1, Offset: 0x98
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"spectating", &__init__, undefined, undefined);
}

// Namespace spectating/spectating
// Params 0, eflags: 0x0
// Checksum 0x96676743, Offset: 0xe0
// Size: 0xa4
function __init__() {
    callback::on_start_gametype(&init);
    callback::on_spawned(&set_permissions);
    callback::on_joined_team(&set_permissions_for_machine);
    callback::on_joined_spectate(&set_permissions_for_machine);
    callback::on_player_killed_with_params(&on_player_killed);
}

// Namespace spectating/spectating
// Params 0, eflags: 0x0
// Checksum 0xa391827a, Offset: 0x190
// Size: 0x8a
function init() {
    foreach (team, _ in level.teams) {
        level.spectateoverride[team] = spawnstruct();
    }
}

// Namespace spectating/spectating
// Params 0, eflags: 0x0
// Checksum 0x188eaf59, Offset: 0x228
// Size: 0x90
function update_settings() {
    level endon(#"game_ended");
    foreach (player in level.players) {
        player set_permissions();
    }
}

// Namespace spectating/spectating
// Params 0, eflags: 0x0
// Checksum 0xc4466d66, Offset: 0x2c0
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
// Params 0, eflags: 0x0
// Checksum 0x6f7b3550, Offset: 0x398
// Size: 0xb8
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
// Params 0, eflags: 0x0
// Checksum 0x17c52e40, Offset: 0x458
// Size: 0x4ec
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
    case 2:
        self.spectatorteam = #"invalid";
        self allowspectateteam("freelook", 1);
        self allowspectateteam(#"none", 1);
        break;
    case 4:
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
// Params 0, eflags: 0x0
// Checksum 0xad1ddd89, Offset: 0x950
// Size: 0x1de
function function_42efa5a2() {
    var_2c4fb7fb = self function_11f4f2e6(undefined, 0);
    if (isdefined(var_2c4fb7fb) && isplayer(var_2c4fb7fb)) {
        self.spectatorteam = var_2c4fb7fb.team;
        self setcurrentspectatorclient(var_2c4fb7fb);
        return;
    }
    spectator_team = undefined;
    players = getplayers(self.team);
    foreach (player in players) {
        if (player == self) {
            continue;
        }
        if (player.spectatorteam != #"invalid") {
            spectator_team = player.spectatorteam;
            break;
        }
    }
    if (!isdefined(spectator_team)) {
        foreach (team, count in level.alivecount) {
            if (count > 0) {
                self.spectatorteam = team;
                break;
            }
        }
    }
    if (isdefined(spectator_team)) {
        self.spectatorteam = spectator_team;
    }
}

// Namespace spectating/spectating
// Params 1, eflags: 0x0
// Checksum 0x316e907e, Offset: 0xb38
// Size: 0x126
function set_permissions_for_machine(params) {
    if (level.spectatetype == 4 && self.spectatorteam != #"invalid") {
        function_42efa5a2();
    }
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
// Params 0, eflags: 0x0
// Checksum 0xdb1cb9eb, Offset: 0xc68
// Size: 0x6a
function function_63a8f01f() {
    livesleft = !(level.numlives && !self.pers[#"lives"]);
    if (!level.alivecount[self.team] && !livesleft) {
        return false;
    }
    return true;
}

// Namespace spectating/spectating
// Params 0, eflags: 0x0
// Checksum 0x89c12493, Offset: 0xce0
// Size: 0x3c
function function_872ed1cd() {
    self endon(#"disconnect");
    waitframe(1);
    function_da02530(#"all");
}

// Namespace spectating/spectating
// Params 1, eflags: 0x4
// Checksum 0xa2319180, Offset: 0xd28
// Size: 0x5c
function private function_da02530(team) {
    if (!self function_63a8f01f()) {
        level.spectateoverride[self.team].allowenemyspectate = team;
        update_settings();
    }
}

// Namespace spectating/spectating
// Params 1, eflags: 0x0
// Checksum 0x2b84af1d, Offset: 0xd90
// Size: 0xa8
function function_f0e3b00a(team) {
    players = getplayers(team);
    foreach (player in players) {
        player allowspectateallteams(1);
    }
}

// Namespace spectating/spectating
// Params 2, eflags: 0x0
// Checksum 0x7b289605, Offset: 0xe40
// Size: 0xd8
function function_e1dc7e07(team, spectate_team) {
    self endon(#"disconnect");
    waitframe(1);
    if (level.alivecount[team]) {
        return;
    }
    players = getplayers(team);
    foreach (player in players) {
        player function_da02530(spectate_team);
    }
}

// Namespace spectating/spectating
// Params 1, eflags: 0x0
// Checksum 0x2d2e37df, Offset: 0xf20
// Size: 0xc6
function get_closest_alive_player(origin) {
    players = arraysort(level.activeplayers, origin);
    foreach (player in players) {
        if (player == self) {
            continue;
        }
        if (!isalive(player)) {
            continue;
        }
        return player;
    }
    return undefined;
}

// Namespace spectating/spectating
// Params 1, eflags: 0x0
// Checksum 0x65acb217, Offset: 0xff0
// Size: 0x140
function function_2859da22(team) {
    self endon(#"disconnect");
    waitframe(1);
    if (level.alivecount[team]) {
        return undefined;
    }
    closest_player = self get_closest_alive_player(self.origin);
    if (isdefined(closest_player)) {
        spectate_team = closest_player.team;
        players = getplayers(team);
        foreach (player in players) {
            player function_da02530(spectate_team);
        }
    } else {
        function_f0e3b00a(team);
    }
    return closest_player;
}

// Namespace spectating/spectating
// Params 0, eflags: 0x0
// Checksum 0x889f40f0, Offset: 0x1138
// Size: 0xfa
function function_f8014da1() {
    if (self.team == #"spectator") {
        return undefined;
    }
    assert(isdefined(level.aliveplayers[self.team]));
    teammates = level.aliveplayers[self.team];
    arraysortclosest(teammates, self.origin);
    foreach (player in teammates) {
        if (player == self) {
            continue;
        }
        return player;
    }
    return undefined;
}

// Namespace spectating/spectating
// Params 0, eflags: 0x0
// Checksum 0x835d3b64, Offset: 0x1240
// Size: 0xfe
function function_20d5a5cd() {
    teammates = getplayers(self.team);
    arraysortclosest(teammates, self.origin);
    foreach (player in teammates) {
        if (player == self) {
            continue;
        }
        livesleft = !(level.numlives && !player.pers[#"lives"]);
        if (livesleft) {
            return player;
        }
    }
    return undefined;
}

// Namespace spectating/spectating
// Params 2, eflags: 0x0
// Checksum 0xbd3aebfb, Offset: 0x1348
// Size: 0xb2
function function_11f4f2e6(attacker, var_5522198f) {
    if (!isdefined(self) || !isdefined(self.team)) {
        return undefined;
    }
    teammate = function_f8014da1();
    spectate_player = undefined;
    if (var_5522198f && attacker.team == self.team) {
        spectate_player = attacker;
    } else if (isdefined(teammate)) {
        spectate_player = teammate;
    } else if (var_5522198f) {
        spectate_player = attacker;
    }
    return spectate_player;
}

// Namespace spectating/spectating
// Params 1, eflags: 0x0
// Checksum 0xbbf04cae, Offset: 0x1408
// Size: 0x4e
function follow_chain(var_a91a63da) {
    if (!isdefined(var_a91a63da)) {
        return;
    }
    while (var_a91a63da.spectatorclient != -1) {
        var_a91a63da = getentbynum(var_a91a63da.spectatorclient);
    }
    return var_a91a63da;
}

// Namespace spectating/spectating
// Params 1, eflags: 0x0
// Checksum 0x401e38d8, Offset: 0x1460
// Size: 0x14e
function function_1b81aa24(attacker) {
    if (level.spectatetype != 4) {
        return;
    }
    var_d1485475 = player::figure_out_attacker(attacker);
    var_4f09003e = isdefined(var_d1485475) && isplayer(var_d1485475) && var_d1485475 != self;
    var_2c4fb7fb = self function_11f4f2e6(var_d1485475, var_4f09003e);
    if (!isdefined(var_2c4fb7fb)) {
        var_2c4fb7fb = self get_closest_alive_player(self.origin);
    }
    var_2c4fb7fb = follow_chain(var_2c4fb7fb);
    if (isdefined(var_2c4fb7fb) && isplayer(var_2c4fb7fb)) {
        self.spectatorclient = -1;
        self.spectatorteam = var_2c4fb7fb.team;
        self setcurrentspectatorclient(var_2c4fb7fb);
        return;
    }
    self.spectatorteam = self.team;
}

// Namespace spectating/spectating
// Params 1, eflags: 0x0
// Checksum 0x1d50dfb8, Offset: 0x15b8
// Size: 0x6c
function on_player_killed(params) {
    livesleft = !(level.numlives && !self.pers[#"lives"]);
    if (livesleft) {
        return;
    }
    self thread function_1b81aa24(params.eattacker);
}

