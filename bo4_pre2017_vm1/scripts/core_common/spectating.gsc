#using scripts/core_common/callbacks_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;

#namespace spectating;

// Namespace spectating/spectating
// Params 0, eflags: 0x2
// Checksum 0x72a45f65, Offset: 0x120
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("spectating", &__init__, undefined, undefined);
}

// Namespace spectating/spectating
// Params 0, eflags: 0x0
// Checksum 0x1f1af236, Offset: 0x160
// Size: 0x84
function __init__() {
    callback::on_start_gametype(&init);
    callback::on_spawned(&set_permissions);
    callback::on_joined_team(&set_permissions_for_machine);
    callback::on_joined_spectate(&set_permissions_for_machine);
}

// Namespace spectating/spectating
// Params 0, eflags: 0x0
// Checksum 0xa1e94d30, Offset: 0x1f0
// Size: 0x9c
function init() {
    foreach (team in level.teams) {
        level.spectateoverride[team] = spawnstruct();
    }
}

// Namespace spectating/spectating
// Params 0, eflags: 0x0
// Checksum 0x3934ccdd, Offset: 0x298
// Size: 0x66
function update_settings() {
    level endon(#"game_ended");
    for (index = 0; index < level.players.size; index++) {
        level.players[index] set_permissions();
    }
}

// Namespace spectating/spectating
// Params 0, eflags: 0x0
// Checksum 0x45ebbcd4, Offset: 0x308
// Size: 0xe6
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
        if (team != "spectator") {
            return team;
        }
    }
    return self.sessionteam;
}

// Namespace spectating/spectating
// Params 0, eflags: 0x0
// Checksum 0xd3abb632, Offset: 0x3f8
// Size: 0xc8
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
// Params 1, eflags: 0x0
// Checksum 0xdb16d87c, Offset: 0x4c8
// Size: 0x9a
function function_c532d79b(allow) {
    foreach (team in level.teams) {
        self allowspectateteam(team, allow);
    }
}

// Namespace spectating/spectating
// Params 2, eflags: 0x0
// Checksum 0xe6901165, Offset: 0x570
// Size: 0xba
function function_2cf41c8d(skip_team, allow) {
    foreach (team in level.teams) {
        if (team == skip_team) {
            continue;
        }
        self allowspectateteam(team, allow);
    }
}

// Namespace spectating/spectating
// Params 0, eflags: 0x0
// Checksum 0xe282c5a4, Offset: 0x638
// Size: 0x54c
function set_permissions() {
    team = self.sessionteam;
    if (team == "spectator") {
        if (self issplitscreen() && !level.splitscreen) {
            team = get_splitscreen_team();
        }
        if (team == "spectator") {
            self function_c532d79b(1);
            self allowspectateteam("freelook", 0);
            self allowspectateteam("none", 1);
            self allowspectateteam("localplayers", 1);
            return;
        }
    }
    spectatetype = level.spectatetype;
    switch (spectatetype) {
    case 0:
        self function_c532d79b(0);
        self allowspectateteam("freelook", 0);
        self allowspectateteam("none", 1);
        self allowspectateteam("localplayers", 0);
        break;
    case 3:
        if (self issplitscreen() && self other_local_player_still_alive()) {
            self function_c532d79b(0);
            self allowspectateteam("none", 0);
            self allowspectateteam("freelook", 0);
            self allowspectateteam("localplayers", 1);
            break;
        }
    case 1:
        if (!level.teambased) {
            self function_c532d79b(1);
            self allowspectateteam("none", 1);
            self allowspectateteam("freelook", 0);
            self allowspectateteam("localplayers", 1);
        } else if (isdefined(team) && isdefined(level.teams[team])) {
            self allowspectateteam(team, 1);
            self function_2cf41c8d(team, 0);
            self allowspectateteam("freelook", 0);
            self allowspectateteam("none", 0);
            self allowspectateteam("localplayers", 1);
        } else {
            self function_c532d79b(0);
            self allowspectateteam("freelook", 0);
            self allowspectateteam("none", 0);
            self allowspectateteam("localplayers", 1);
        }
        break;
    case 2:
        self function_c532d79b(1);
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
            self function_2cf41c8d(team, 1);
        }
    }
}

// Namespace spectating/spectating
// Params 0, eflags: 0x0
// Checksum 0xd1f540f2, Offset: 0xb90
// Size: 0xee
function set_permissions_for_machine() {
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

