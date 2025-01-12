#using scripts/core_common/callbacks_shared;
#using scripts/core_common/fx_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace acousticsensor;

// Namespace acousticsensor/acousticsensor
// Params 0, eflags: 0x0
// Checksum 0xe2525ff5, Offset: 0x1d0
// Size: 0xcc
function init_shared() {
    level._effect["acousticsensor_enemy_light"] = "_t6/misc/fx_equip_light_red";
    level._effect["acousticsensor_friendly_light"] = "_t6/misc/fx_equip_light_green";
    if (!isdefined(level.var_e1b96029)) {
        level.var_e1b96029 = [];
    }
    if (!isdefined(level.var_e19ee9a4)) {
        level.var_e19ee9a4 = 0;
    }
    callback::on_localclient_connect(&on_player_connect);
    callback::add_weapon_type("acoustic_sensor", &spawned);
}

// Namespace acousticsensor/acousticsensor
// Params 1, eflags: 0x0
// Checksum 0x2e370f91, Offset: 0x2a8
// Size: 0x44
function on_player_connect(localclientnum) {
    setlocalradarenabled(localclientnum, 0);
    if (localclientnum == 0) {
        level thread function_e128e674();
    }
}

// Namespace acousticsensor/acousticsensor
// Params 3, eflags: 0x0
// Checksum 0x2554c645, Offset: 0x2f8
// Size: 0xa6
function function_bb05d439(handle, sensorent, owner) {
    acousticsensor = spawnstruct();
    acousticsensor.handle = handle;
    acousticsensor.sensorent = sensorent;
    acousticsensor.owner = owner;
    size = level.var_e1b96029.size;
    level.var_e1b96029[size] = acousticsensor;
}

// Namespace acousticsensor/acousticsensor
// Params 1, eflags: 0x0
// Checksum 0xe4d9d6a4, Offset: 0x3a8
// Size: 0x13c
function function_98918d12(var_e19ee9a4) {
    for (i = 0; i < level.var_e1b96029.size; i++) {
        last = level.var_e1b96029.size - 1;
        if (level.var_e1b96029[i].handle == var_e19ee9a4) {
            level.var_e1b96029[i].handle = level.var_e1b96029[last].handle;
            level.var_e1b96029[i].sensorent = level.var_e1b96029[last].sensorent;
            level.var_e1b96029[i].owner = level.var_e1b96029[last].owner;
            level.var_e1b96029[last] = undefined;
            return;
        }
    }
}

// Namespace acousticsensor/acousticsensor
// Params 1, eflags: 0x0
// Checksum 0xe9f5c612, Offset: 0x4f0
// Size: 0xac
function spawned(localclientnum) {
    handle = level.var_e19ee9a4;
    level.var_e19ee9a4++;
    self thread watchshutdown(handle);
    owner = self getowner(localclientnum);
    function_bb05d439(handle, self, owner);
    util::local_players_entity_thread(self, &function_8bbd150b);
}

// Namespace acousticsensor/acousticsensor
// Params 1, eflags: 0x0
// Checksum 0x50b2a30c, Offset: 0x5a8
// Size: 0x64
function function_8bbd150b(localclientnum) {
    self endon(#"death");
    self thread fx::blinky_light(localclientnum, "tag_light", level._effect["acousticsensor_friendly_light"], level._effect["acousticsensor_enemy_light"]);
}

// Namespace acousticsensor/acousticsensor
// Params 1, eflags: 0x0
// Checksum 0xd9f090bf, Offset: 0x618
// Size: 0x34
function watchshutdown(handle) {
    self waittill("death");
    function_98918d12(handle);
}

// Namespace acousticsensor/acousticsensor
// Params 0, eflags: 0x0
// Checksum 0xee23752c, Offset: 0x658
// Size: 0x258
function function_e128e674() {
    self endon(#"death");
    var_c8eafd69 = [];
    var_1fdb8fee = -1;
    util::waitforclient(0);
    while (true) {
        localplayers = level.localplayers;
        if (var_1fdb8fee != 0 || level.var_e1b96029.size != 0) {
            for (i = 0; i < localplayers.size; i++) {
                var_c8eafd69[i] = 0;
            }
            for (i = 0; i < level.var_e1b96029.size; i++) {
                if (isdefined(level.var_e1b96029[i].sensorent.stunned) && level.var_e1b96029[i].sensorent.stunned) {
                    continue;
                }
                for (j = 0; j < localplayers.size; j++) {
                    if (localplayers[j] == level.var_e1b96029[i].sensorent getowner(j)) {
                        var_c8eafd69[j] = 1;
                        setlocalradarposition(j, level.var_e1b96029[i].sensorent.origin);
                    }
                }
            }
            for (i = 0; i < localplayers.size; i++) {
                setlocalradarenabled(i, var_c8eafd69[i]);
            }
        }
        var_1fdb8fee = level.var_e1b96029.size;
        wait 0.1;
    }
}

