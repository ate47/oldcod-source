#using scripts\core_common\callbacks_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;

#namespace spectating;

// Namespace spectating/spectating
// Params 0, eflags: 0x6
// Checksum 0x1d296785, Offset: 0xb0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_spectating", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace spectating/spectating
// Params 0, eflags: 0x5 linked
// Checksum 0x9b4badf4, Offset: 0xf8
// Size: 0x24
function private function_70a657d8() {
    callback::on_start_gametype(&main);
}

// Namespace spectating/spectating
// Params 0, eflags: 0x1 linked
// Checksum 0xca0fb1fb, Offset: 0x128
// Size: 0xb4
function main() {
    foreach (team, _ in level.teams) {
        level.spectateoverride[team] = spawnstruct();
    }
    callback::on_connecting(&on_player_connecting);
}

// Namespace spectating/spectating
// Params 0, eflags: 0x1 linked
// Checksum 0x9fddad4, Offset: 0x1e8
// Size: 0x64
function on_player_connecting() {
    callback::on_joined_team(&on_joined_team);
    callback::on_spawned(&on_player_spawned);
    callback::on_joined_spectate(&on_joined_spectate);
}

// Namespace spectating/spectating
// Params 0, eflags: 0x1 linked
// Checksum 0x97992e62, Offset: 0x258
// Size: 0x2c
function on_player_spawned() {
    self endon(#"disconnect");
    self setspectatepermissions();
}

// Namespace spectating/spectating
// Params 1, eflags: 0x1 linked
// Checksum 0xe557a930, Offset: 0x290
// Size: 0x34
function on_joined_team(*params) {
    self endon(#"disconnect");
    self setspectatepermissionsformachine();
}

// Namespace spectating/spectating
// Params 1, eflags: 0x1 linked
// Checksum 0xc0713510, Offset: 0x2d0
// Size: 0x34
function on_joined_spectate(*params) {
    self endon(#"disconnect");
    self setspectatepermissionsformachine();
}

// Namespace spectating/spectating
// Params 0, eflags: 0x0
// Checksum 0x3d1672df, Offset: 0x310
// Size: 0x64
function updatespectatesettings() {
    level endon(#"game_ended");
    for (index = 0; index < level.players.size; index++) {
        level.players[index] setspectatepermissions();
    }
}

// Namespace spectating/spectating
// Params 0, eflags: 0x1 linked
// Checksum 0x5228ec5e, Offset: 0x380
// Size: 0xca
function getsplitscreenteam() {
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
        if (team != "spectator") {
            return team;
        }
    }
    return self.sessionteam;
}

// Namespace spectating/spectating
// Params 0, eflags: 0x1 linked
// Checksum 0x23e15ecc, Offset: 0x458
// Size: 0xb6
function otherlocalplayerstillalive() {
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
// Params 1, eflags: 0x1 linked
// Checksum 0x9d24c9fa, Offset: 0x518
// Size: 0x98
function allowspectateallteams(allow) {
    foreach (team, _ in level.teams) {
        self allowspectateteam(team, allow);
    }
}

// Namespace spectating/spectating
// Params 2, eflags: 0x1 linked
// Checksum 0xc961b527, Offset: 0x5b8
// Size: 0xb0
function allowspectateallteamsexceptteam(skip_team, allow) {
    foreach (team, _ in level.teams) {
        if (team == skip_team) {
            continue;
        }
        self allowspectateteam(team, allow);
    }
}

// Namespace spectating/spectating
// Params 0, eflags: 0x1 linked
// Checksum 0x9cda8c8b, Offset: 0x670
// Size: 0x54c
function setspectatepermissions() {
    team = self.sessionteam;
    if (team == "spectator") {
        if (self issplitscreen() && !level.splitscreen) {
            team = getsplitscreenteam();
        }
        if (team == "spectator") {
            self allowspectateallteams(1);
            self allowspectateteam("freelook", 0);
            self allowspectateteam("none", 1);
            self allowspectateteam("localplayers", 1);
            return;
        }
    }
    spectatetype = level.spectatetype;
    switch (spectatetype) {
    case 0:
        self allowspectateallteams(0);
        self allowspectateteam("freelook", 0);
        self allowspectateteam("none", 1);
        self allowspectateteam("localplayers", 0);
        break;
    case 3:
        if (self issplitscreen() && self otherlocalplayerstillalive()) {
            self allowspectateallteams(0);
            self allowspectateteam("none", 0);
            self allowspectateteam("freelook", 0);
            self allowspectateteam("localplayers", 1);
            break;
        }
    case 1:
        if (!level.teambased) {
            self allowspectateallteams(1);
            self allowspectateteam("none", 1);
            self allowspectateteam("freelook", 0);
            self allowspectateteam("localplayers", 1);
        } else if (isdefined(team) && isdefined(level.teams[team])) {
            self allowspectateteam(team, 1);
            self allowspectateallteamsexceptteam(team, 0);
            self allowspectateteam("freelook", 0);
            self allowspectateteam("none", 0);
            self allowspectateteam("localplayers", 1);
        } else {
            self allowspectateallteams(0);
            self allowspectateteam("freelook", 0);
            self allowspectateteam("none", 0);
            self allowspectateteam("localplayers", 1);
        }
        break;
    case 2:
        self allowspectateallteams(1);
        self allowspectateteam("freelook", 1);
        self allowspectateteam("none", 1);
        self allowspectateteam("localplayers", 1);
        break;
    }
    if (isdefined(team) && isdefined(level.teams[team])) {
        if (isdefined(level.spectateoverride[team].allowfreespectate)) {
            self allowspectateteam("freelook", 1);
        }
        if (isdefined(level.spectateoverride[team].allowenemyspectate)) {
            self allowspectateallteamsexceptteam(team, 1);
        }
    }
}

// Namespace spectating/spectating
// Params 0, eflags: 0x1 linked
// Checksum 0xd88e9c0d, Offset: 0xbc8
// Size: 0xdc
function setspectatepermissionsformachine() {
    self setspectatepermissions();
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
        level.players[index] setspectatepermissions();
    }
}

