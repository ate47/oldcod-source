#using scripts\core_common\math_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace sticky_grenade;

// Namespace sticky_grenade/zm_weap_sticky_grenade
// Params 0, eflags: 0x6
// Checksum 0x207e1760, Offset: 0xa8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"sticky_grenade", undefined, &postinit, undefined, undefined);
}

// Namespace sticky_grenade/zm_weap_sticky_grenade
// Params 0, eflags: 0x5 linked
// Checksum 0x4ecbd9a, Offset: 0xf0
// Size: 0x2c
function private postinit() {
    level._effect[#"hash_378b08f9ecc6d430"] = #"weapon/fx8_equip_light_os";
}

// Namespace sticky_grenade/zm_weap_sticky_grenade
// Params 1, eflags: 0x1 linked
// Checksum 0xd680e3ee, Offset: 0x128
// Size: 0x3c
function spawned(localclientnum) {
    if (self isgrenadedud()) {
        return;
    }
    self thread fx_think(localclientnum);
}

// Namespace sticky_grenade/zm_weap_sticky_grenade
// Params 1, eflags: 0x1 linked
// Checksum 0x4a4dd0b5, Offset: 0x170
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
        util::server_wait(localclientnum, interval, 0.01, "player_switch");
    }
}

// Namespace sticky_grenade/zm_weap_sticky_grenade
// Params 1, eflags: 0x1 linked
// Checksum 0xfd967543, Offset: 0x2b0
// Size: 0x4a
function start_light_fx(localclientnum) {
    self.fx = util::playfxontag(localclientnum, level._effect[#"hash_378b08f9ecc6d430"], self, "tag_fx");
}

// Namespace sticky_grenade/zm_weap_sticky_grenade
// Params 1, eflags: 0x1 linked
// Checksum 0xb60c5ed7, Offset: 0x308
// Size: 0x4e
function stop_light_fx(localclientnum) {
    if (isdefined(self.fx) && self.fx != 0) {
        stopfx(localclientnum, self.fx);
        self.fx = undefined;
    }
}

// Namespace sticky_grenade/zm_weap_sticky_grenade
// Params 1, eflags: 0x1 linked
// Checksum 0x37355f27, Offset: 0x360
// Size: 0xbc
function fullscreen_fx(localclientnum) {
    if (function_1cbf351b(localclientnum)) {
        return;
    } else if (util::is_player_view_linked_to_entity(localclientnum)) {
        return;
    }
    if (self function_e9fc6a64()) {
        return;
    }
    parent = self getparententity();
    if (isdefined(parent) && parent function_21c0fa55()) {
        parent playrumbleonentity(localclientnum, "buzz_high");
    }
}

