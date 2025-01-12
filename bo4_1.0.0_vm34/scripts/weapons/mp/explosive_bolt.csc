#using scripts\core_common\callbacks_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace explosive_bolt;

// Namespace explosive_bolt/explosive_bolt
// Params 0, eflags: 0x2
// Checksum 0x71ce84db, Offset: 0xb0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"explosive_bolt", &__init__, undefined, undefined);
}

// Namespace explosive_bolt/explosive_bolt
// Params 0, eflags: 0x0
// Checksum 0x9fb59455, Offset: 0xf8
// Size: 0x64
function __init__() {
    level._effect[#"crossbow_light"] = #"weapon/fx8_equip_light_os";
    callback::add_weapon_type(#"explosive_bolt", &spawned);
}

// Namespace explosive_bolt/explosive_bolt
// Params 1, eflags: 0x0
// Checksum 0x60f21895, Offset: 0x168
// Size: 0x3c
function spawned(localclientnum) {
    if (self isgrenadedud()) {
        return;
    }
    self thread fx_think(localclientnum);
}

// Namespace explosive_bolt/explosive_bolt
// Params 1, eflags: 0x0
// Checksum 0xe4325162, Offset: 0x1b0
// Size: 0x132
function fx_think(localclientnum) {
    self notify(#"light_disable");
    self endon(#"death");
    self endon(#"light_disable");
    self util::waittill_dobj(localclientnum);
    for (interval = 0.3; ; interval = math::clamp(interval / 1.2, 0.08, 0.3)) {
        self stop_light_fx(localclientnum);
        self start_light_fx(localclientnum);
        self fullscreen_fx(localclientnum);
        self playsound(localclientnum, #"wpn_semtex_alert");
        util::server_wait(localclientnum, interval, 0.016, "player_switch");
    }
}

// Namespace explosive_bolt/explosive_bolt
// Params 1, eflags: 0x0
// Checksum 0xcf6fa94, Offset: 0x2f0
// Size: 0x4a
function start_light_fx(localclientnum) {
    self.fx = util::playfxontag(localclientnum, level._effect[#"crossbow_light"], self, "tag_origin");
}

// Namespace explosive_bolt/explosive_bolt
// Params 1, eflags: 0x0
// Checksum 0x9e815f06, Offset: 0x348
// Size: 0x4e
function stop_light_fx(localclientnum) {
    if (isdefined(self.fx) && self.fx != 0) {
        stopfx(localclientnum, self.fx);
        self.fx = undefined;
    }
}

// Namespace explosive_bolt/explosive_bolt
// Params 1, eflags: 0x0
// Checksum 0x27407da2, Offset: 0x3a0
// Size: 0xbc
function fullscreen_fx(localclientnum) {
    if (function_1fe374eb(localclientnum)) {
        return;
    }
    if (util::is_player_view_linked_to_entity(localclientnum)) {
        return;
    }
    if (self function_31d3dfec()) {
        return;
    }
    parent = self getparententity();
    if (isdefined(parent) && parent function_60dbc438()) {
        parent playrumbleonentity(localclientnum, "buzz_high");
    }
}

