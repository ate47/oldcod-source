#using scripts\core_common\math_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace acid_bomb;

// Namespace acid_bomb/acid_bomb
// Params 0, eflags: 0x2
// Checksum 0xfe7f3c13, Offset: 0xa8
// Size: 0x34
function autoexec __init__system__() {
    system::register(#"acid_bomb", undefined, &__main__, undefined);
}

// Namespace acid_bomb/acid_bomb
// Params 0, eflags: 0x0
// Checksum 0x563ab7c1, Offset: 0xe8
// Size: 0x32
function __main__() {
    level._effect[#"grenade_light"] = #"weapon/fx8_equip_light_os";
}

// Namespace acid_bomb/acid_bomb
// Params 1, eflags: 0x0
// Checksum 0x9f534f38, Offset: 0x128
// Size: 0x3c
function spawned(localclientnum) {
    if (self isgrenadedud()) {
        return;
    }
    self thread fx_think(localclientnum);
}

// Namespace acid_bomb/acid_bomb
// Params 1, eflags: 0x0
// Checksum 0xca3b906d, Offset: 0x170
// Size: 0x132
function fx_think(localclientnum) {
    self notify(#"light_disable");
    self endon(#"death", #"light_disable");
    self util::waittill_dobj(localclientnum);
    for (interval = 0.3; ; interval = math::clamp(interval / 1.2, 0.08, 0.3)) {
        self stop_light_fx(localclientnum);
        self start_light_fx(localclientnum);
        self fullscreen_fx(localclientnum);
        self playsound(localclientnum, #"hash_2bb4a8b02a0d697");
        util::server_wait(localclientnum, interval, 0.01, "player_switch");
    }
}

// Namespace acid_bomb/acid_bomb
// Params 1, eflags: 0x0
// Checksum 0xa45a13f6, Offset: 0x2b0
// Size: 0x4a
function start_light_fx(localclientnum) {
    self.fx = util::playfxontag(localclientnum, level._effect[#"grenade_light"], self, "tag_fx");
}

// Namespace acid_bomb/acid_bomb
// Params 1, eflags: 0x0
// Checksum 0x9a7f0df0, Offset: 0x308
// Size: 0x4e
function stop_light_fx(localclientnum) {
    if (isdefined(self.fx) && self.fx != 0) {
        stopfx(localclientnum, self.fx);
        self.fx = undefined;
    }
}

// Namespace acid_bomb/acid_bomb
// Params 1, eflags: 0x0
// Checksum 0xa460a045, Offset: 0x360
// Size: 0xc4
function fullscreen_fx(localclientnum) {
    if (function_1fe374eb(localclientnum)) {
        return;
    } else if (util::is_player_view_linked_to_entity(localclientnum)) {
        return;
    }
    if (self function_55a8b32b()) {
        return;
    }
    parent = self getparententity();
    if (isdefined(parent) && parent function_60dbc438()) {
        parent playrumbleonentity(localclientnum, "buzz_high");
    }
}

