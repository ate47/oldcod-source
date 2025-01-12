#using scripts/core_common/callbacks_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace bb;

// Namespace bb/bb_shared
// Params 0, eflags: 0x0
// Checksum 0x5f69cbc7, Offset: 0x248
// Size: 0x24
function init_shared() {
    callback::on_start_gametype(&init);
}

// Namespace bb/bb_shared
// Params 0, eflags: 0x0
// Checksum 0x152669b4, Offset: 0x278
// Size: 0x44
function init() {
    callback::on_connect(&player_init);
    callback::on_spawned(&on_player_spawned);
}

// Namespace bb/bb_shared
// Params 0, eflags: 0x0
// Checksum 0xa6018f65, Offset: 0x2c8
// Size: 0x1c
function player_init() {
    self thread on_player_death();
}

// Namespace bb/bb_shared
// Params 0, eflags: 0x0
// Checksum 0xf4226706, Offset: 0x2f0
// Size: 0x82
function on_player_spawned() {
    self endon(#"disconnect");
    self._bbdata = [];
    self._bbdata["score"] = 0;
    self._bbdata["momentum"] = 0;
    self._bbdata["spawntime"] = gettime();
    self._bbdata["shots"] = 0;
    self._bbdata["hits"] = 0;
}

// Namespace bb/bb_shared
// Params 0, eflags: 0x0
// Checksum 0xa56b3bc5, Offset: 0x380
// Size: 0x1a
function on_player_disconnect() {
    for (;;) {
        self waittill("disconnect");
        break;
    }
}

// Namespace bb/bb_shared
// Params 0, eflags: 0x0
// Checksum 0xc08b3973, Offset: 0x3a8
// Size: 0x22
function on_player_death() {
    self endon(#"disconnect");
    for (;;) {
        self waittill("death");
    }
}

// Namespace bb/bb_shared
// Params 0, eflags: 0x0
// Checksum 0xff572598, Offset: 0x3d8
// Size: 0xcc
function commit_spawn_data() {
    if (self isbot()) {
        return;
    }
    /#
        /#
            assert(isdefined(self._bbdata));
        #/
    #/
    if (!isdefined(self._bbdata)) {
        return;
    }
    bbprint("mpplayerlives", "gametime %d spawnid %d lifescore %d lifemomentum %d lifetime %d name %s", gettime(), getplayerspawnid(self), self._bbdata["score"], self._bbdata["momentum"], gettime() - self._bbdata["spawntime"], self.name);
}

// Namespace bb/bb_shared
// Params 3, eflags: 0x0
// Checksum 0xaf01188d, Offset: 0x4b0
// Size: 0x15e
function commit_weapon_data(spawnid, currentweapon, time0) {
    if (self isbot()) {
        return;
    }
    /#
        /#
            assert(isdefined(self._bbdata));
        #/
    #/
    if (!isdefined(self._bbdata)) {
        return;
    }
    time1 = gettime();
    blackboxeventname = "mpweapons";
    if (sessionmodeiscampaigngame()) {
        blackboxeventname = "cpweapons";
    } else if (sessionmodeiszombiesgame()) {
        blackboxeventname = "zmweapons";
    }
    bbprint(blackboxeventname, "spawnid %d name %s duration %d shots %d hits %d", spawnid, currentweapon.name, time1 - time0, self._bbdata["shots"], self._bbdata["hits"]);
    self._bbdata["shots"] = 0;
    self._bbdata["hits"] = 0;
}

// Namespace bb/bb_shared
// Params 2, eflags: 0x0
// Checksum 0x9e68a09b, Offset: 0x618
// Size: 0x7a
function add_to_stat(statname, delta) {
    if (self isbot()) {
        return;
    }
    if (isdefined(self._bbdata) && isdefined(self._bbdata[statname])) {
        self._bbdata[statname] = self._bbdata[statname] + delta;
    }
}

// Namespace bb/bb_shared
// Params 1, eflags: 0x0
// Checksum 0xc3151d54, Offset: 0x6a0
// Size: 0xf4
function function_6a33da3c(var_758db14b) {
    if (self isbot()) {
        return;
    }
    if (isdefined(level.gametype) && level.gametype === "doa") {
        return;
    }
    var_2b0e341 = self getmatchrecordlifeindex();
    if (var_2b0e341 == -1) {
        return;
    }
    movementtype = "";
    stance = "";
    bbprint(var_758db14b, "gametime %d lifeIndex %d posx %d posy %d posz %d yaw %d pitch %d movetype %s stance %s", gettime(), var_2b0e341, self.origin, self.angles[0], self.angles[1], movementtype, stance);
}

// Namespace bb/bb_shared
// Params 1, eflags: 0x0
// Checksum 0x6c7cd6c4, Offset: 0x7a0
// Size: 0xfc
function function_543e7299(var_758db14b) {
    level endon(#"game_ended");
    if (isdefined(level.gametype) && (!sessionmodeisonlinegame() || level.gametype === "doa")) {
        return;
    }
    while (true) {
        for (i = 0; i < level.players.size; i++) {
            player = level.players[i];
            if (isalive(player)) {
                player function_6a33da3c(var_758db14b);
            }
        }
        wait 2;
    }
}

