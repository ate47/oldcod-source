#using scripts\core_common\callbacks_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;

#namespace spectating;

// Namespace spectating/spectating
// Params 0, eflags: 0x2
// Checksum 0xf39ac536, Offset: 0xa8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_spectating", &__init__, undefined, undefined);
}

// Namespace spectating/spectating
// Params 0, eflags: 0x0
// Checksum 0x67d5ffa6, Offset: 0xf0
// Size: 0x24
function __init__() {
    callback::on_start_gametype(&main);
}

// Namespace spectating/spectating
// Params 0, eflags: 0x0
// Checksum 0x776d5c65, Offset: 0x120
// Size: 0xac
function main() {
    foreach (team, _ in level.teams) {
        level.spectateoverride[team] = spawnstruct();
    }
    callback::on_connecting(&on_player_connecting);
}

// Namespace spectating/spectating
// Params 0, eflags: 0x0
// Checksum 0x3ae8b908, Offset: 0x1d8
// Size: 0x64
function on_player_connecting() {
    callback::on_joined_team(&on_joined_team);
    callback::on_spawned(&on_player_spawned);
    callback::on_joined_spectate(&on_joined_spectate);
}

// Namespace spectating/spectating
// Params 0, eflags: 0x0
// Checksum 0x2287217b, Offset: 0x248
// Size: 0x2c
function on_player_spawned() {
    self endon(#"disconnect");
    self setspectatepermissions();
}

// Namespace spectating/spectating
// Params 1, eflags: 0x0
// Checksum 0x18f38f9c, Offset: 0x280
// Size: 0x34
function on_joined_team(params) {
    self endon(#"disconnect");
    self setspectatepermissionsformachine();
}

// Namespace spectating/spectating
// Params 1, eflags: 0x0
// Checksum 0x71eb2c40, Offset: 0x2c0
// Size: 0x34
function on_joined_spectate(params) {
    self endon(#"disconnect");
    self setspectatepermissionsformachine();
}

// Namespace spectating/spectating
// Params 0, eflags: 0x0
// Checksum 0x1f130a37, Offset: 0x300
// Size: 0x66
function updatespectatesettings() {
    level endon(#"game_ended");
    for (index = 0; index < level.players.size; index++) {
        level.players[index] setspectatepermissions();
    }
}

// Namespace spectating/spectating
// Params 0, eflags: 0x0
// Checksum 0x67b83e95, Offset: 0x370
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
// Params 0, eflags: 0x0
// Checksum 0xd7294a35, Offset: 0x448
// Size: 0xb8
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
// Params 1, eflags: 0x0
// Checksum 0xc5d6c60b, Offset: 0x508
// Size: 0x88
function allowspectateallteams(allow) {
    foreach (team, _ in level.teams) {
        self allowspectateteam(team, allow);
    }
}

// Namespace spectating/spectating
// Params 2, eflags: 0x0
// Checksum 0x4e00c6e1, Offset: 0x598
// Size: 0xa8
function allowspectateallteamsexceptteam(skip_team, allow) {
    foreach (team, _ in level.teams) {
        if (team == skip_team) {
            continue;
        }
        self allowspectateteam(team, allow);
    }
}

// Namespace spectating/spectating
// Params 0, eflags: 0x0
// Checksum 0x39f9023b, Offset: 0x648
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
// Params 0, eflags: 0x0
// Checksum 0x3c8a4314, Offset: 0xba0
// Size: 0xde
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

