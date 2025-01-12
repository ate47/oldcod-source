#using scripts\core_common\audio_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\footsteps_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\zm\weapons\zm_weap_sticky_grenade;

#namespace callback;

// Namespace callback/callbacks
// Params 0, eflags: 0x6
// Checksum 0xdd7f7355, Offset: 0xf8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"callback", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace callback/callbacks
// Params 0, eflags: 0x5 linked
// Checksum 0x9686d2f5, Offset: 0x140
// Size: 0x1c
function private function_70a657d8() {
    level thread set_default_callbacks();
}

// Namespace callback/callbacks
// Params 0, eflags: 0x1 linked
// Checksum 0xb91d5eed, Offset: 0x168
// Size: 0xc4
function set_default_callbacks() {
    level.callbackplayerspawned = &playerspawned;
    level.callbacklocalclientconnect = &localclientconnect;
    level.callbackplayerlaststand = &playerlaststand;
    level.callbackentityspawned = &entityspawned;
    level.callbackhostmigration = &host_migration;
    level.callbackplayaifootstep = &footsteps::playaifootstep;
    level._custom_weapon_cb_func = &spawned_weapon_type;
    level.var_6b11d5f6 = &function_cbfd8fd6;
}

// Namespace callback/callbacks
// Params 1, eflags: 0x1 linked
// Checksum 0x64ecd51d, Offset: 0x238
// Size: 0x78
function localclientconnect(localclientnum) {
    println("<dev string:x38>" + localclientnum);
    callback(#"on_localclient_connect", localclientnum);
    if (isdefined(level.charactercustomizationsetup)) {
        [[ level.charactercustomizationsetup ]](localclientnum);
    }
}

// Namespace callback/callbacks
// Params 1, eflags: 0x1 linked
// Checksum 0xbbe87b41, Offset: 0x2b8
// Size: 0x44
function playerlaststand(localclientnum) {
    self endon(#"death");
    callback(#"on_player_laststand", localclientnum);
}

// Namespace callback/callbacks
// Params 1, eflags: 0x1 linked
// Checksum 0x9e5cbf8d, Offset: 0x308
// Size: 0xec
function playerspawned(localclientnum) {
    self endon(#"death");
    util::function_89a98f85();
    if (isdefined(level._playerspawned_override)) {
        self thread [[ level._playerspawned_override ]](localclientnum);
        return;
    }
    println("<dev string:x68>");
    if (self function_21c0fa55()) {
        callback(#"on_localplayer_spawned", localclientnum);
    }
    callback(#"on_player_spawned", localclientnum);
    level.localplayers = getlocalplayers();
}

// Namespace callback/callbacks
// Params 1, eflags: 0x1 linked
// Checksum 0xb5fcdb95, Offset: 0x400
// Size: 0x364
function entityspawned(localclientnum) {
    self endon(#"death");
    util::function_89a98f85();
    if (isplayer(self)) {
        if (isdefined(level._clientfaceanimonplayerspawned)) {
            self thread [[ level._clientfaceanimonplayerspawned ]](localclientnum);
        }
    }
    if (isdefined(level._entityspawned_override)) {
        self thread [[ level._entityspawned_override ]](localclientnum);
        return;
    }
    if (!isdefined(self.type)) {
        println("<dev string:x7a>");
        return;
    }
    if (self.type == "missile") {
        if (isdefined(level._custom_weapon_cb_func)) {
            self thread [[ level._custom_weapon_cb_func ]](localclientnum);
        }
        switch (self.weapon.name) {
        case #"sticky_grenade":
            self thread sticky_grenade::spawned(localclientnum);
            break;
        }
        return;
    }
    if (self.type == "vehicle" || self.type == "helicopter" || self.type == "plane") {
        if (isdefined(level._customvehiclecbfunc)) {
            self thread [[ level._customvehiclecbfunc ]](localclientnum);
        }
        self thread vehicle::field_toggle_exhaustfx_handler(localclientnum, undefined, 0, 1);
        self thread vehicle::field_toggle_lights_handler(localclientnum, undefined, 0, 1);
        if (self.type == "plane" || self.type == "helicopter") {
            self thread vehicle::aircraft_dustkick();
        }
        if (self.archetype === #"bat") {
            if (isdefined(level._customactorcbfunc)) {
                self thread [[ level._customactorcbfunc ]](localclientnum);
            }
        }
        return;
    }
    if (self.type == "actor") {
        if (isdefined(level._customactorcbfunc)) {
            self thread [[ level._customactorcbfunc ]](localclientnum);
        }
        self callback(#"hash_1fc6e31d0d02aa3", localclientnum);
        return;
    }
    if (self.type == "scriptmover") {
        if (isdefined(self.weapon)) {
            if (isdefined(level.var_6b11d5f6)) {
                self thread [[ level.var_6b11d5f6 ]](localclientnum);
            }
        }
        return;
    }
    if (self.type == "NA") {
        if (isdefined(self.weapon)) {
            if (isdefined(level.var_6b11d5f6)) {
                self thread [[ level.var_6b11d5f6 ]](localclientnum);
            }
        }
    }
}

// Namespace callback/callbacks
// Params 1, eflags: 0x1 linked
// Checksum 0x39c14e0a, Offset: 0x770
// Size: 0x24
function host_migration(*localclientnum) {
    level thread prevent_round_switch_animation();
}

// Namespace callback/callbacks
// Params 0, eflags: 0x1 linked
// Checksum 0x2588ad13, Offset: 0x7a0
// Size: 0xa
function prevent_round_switch_animation() {
    wait 3;
}

