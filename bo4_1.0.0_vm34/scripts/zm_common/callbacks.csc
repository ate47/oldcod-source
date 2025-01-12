#using script_6a77db946eb71f73;
#using scripts\core_common\audio_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\filter_shared;
#using scripts\core_common\footsteps_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\weapons\acid_bomb;

#namespace callback;

// Namespace callback/callbacks
// Params 0, eflags: 0x2
// Checksum 0x5af2847f, Offset: 0xe8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"callback", &__init__, undefined, undefined);
}

// Namespace callback/callbacks
// Params 0, eflags: 0x0
// Checksum 0x8dda6b26, Offset: 0x130
// Size: 0x1c
function __init__() {
    level thread set_default_callbacks();
}

// Namespace callback/callbacks
// Params 0, eflags: 0x0
// Checksum 0x398fd1f4, Offset: 0x158
// Size: 0xae
function set_default_callbacks() {
    level.callbackplayerspawned = &playerspawned;
    level.callbacklocalclientconnect = &localclientconnect;
    level.callbackplayerlaststand = &playerlaststand;
    level.callbackentityspawned = &entityspawned;
    level.callbackhostmigration = &host_migration;
    level.callbackplayaifootstep = &footsteps::playaifootstep;
    level._custom_weapon_cb_func = &spawned_weapon_type;
}

// Namespace callback/callbacks
// Params 1, eflags: 0x0
// Checksum 0x6446484f, Offset: 0x210
// Size: 0x78
function localclientconnect(localclientnum) {
    println("<dev string:x30>" + localclientnum);
    callback(#"on_localclient_connect", localclientnum);
    if (isdefined(level.charactercustomizationsetup)) {
        [[ level.charactercustomizationsetup ]](localclientnum);
    }
}

// Namespace callback/callbacks
// Params 1, eflags: 0x0
// Checksum 0xfd0f70d0, Offset: 0x290
// Size: 0x44
function playerlaststand(localclientnum) {
    self endon(#"death");
    callback(#"on_player_laststand", localclientnum);
}

// Namespace callback/callbacks
// Params 1, eflags: 0x0
// Checksum 0x91843d11, Offset: 0x2e0
// Size: 0xee
function playerspawned(localclientnum) {
    self endon(#"death");
    util::function_2170ff73();
    if (isdefined(level._playerspawned_override)) {
        self thread [[ level._playerspawned_override ]](localclientnum);
        return;
    }
    println("<dev string:x5d>");
    if (self function_60dbc438()) {
        callback(#"on_localplayer_spawned", localclientnum);
    }
    callback(#"on_player_spawned", localclientnum);
    level.localplayers = getlocalplayers();
}

// Namespace callback/callbacks
// Params 1, eflags: 0x0
// Checksum 0x4af57488, Offset: 0x3d8
// Size: 0x2f0
function entityspawned(localclientnum) {
    self endon(#"death");
    util::function_2170ff73();
    if (self isplayer()) {
        if (isdefined(level._clientfaceanimonplayerspawned)) {
            self thread [[ level._clientfaceanimonplayerspawned ]](localclientnum);
        }
    }
    if (isdefined(level._entityspawned_override)) {
        self thread [[ level._entityspawned_override ]](localclientnum);
        return;
    }
    if (!isdefined(self.type)) {
        println("<dev string:x6c>");
        return;
    }
    if (self.type == "missile") {
        if (isdefined(level._custom_weapon_cb_func)) {
            self thread [[ level._custom_weapon_cb_func ]](localclientnum);
        }
        switch (self.weapon.name) {
        case #"eq_acid_bomb":
            self thread acid_bomb::spawned(localclientnum);
            break;
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
        if (self.type == "helicopter") {
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
    }
}

// Namespace callback/callbacks
// Params 1, eflags: 0x0
// Checksum 0xff6add77, Offset: 0x6d0
// Size: 0x24
function host_migration(localclientnum) {
    level thread prevent_round_switch_animation();
}

// Namespace callback/callbacks
// Params 0, eflags: 0x0
// Checksum 0x466fd80b, Offset: 0x700
// Size: 0xa
function prevent_round_switch_animation() {
    wait 3;
}

