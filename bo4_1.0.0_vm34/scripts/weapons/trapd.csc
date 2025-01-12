#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace trapd;

// Namespace trapd/trapd
// Params 0, eflags: 0x2
// Checksum 0x614e0abe, Offset: 0x98
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"trapd", &__init__, undefined, undefined);
}

// Namespace trapd/trapd
// Params 0, eflags: 0x0
// Checksum 0x702e51f6, Offset: 0xe0
// Size: 0x64
function __init__() {
    callback::add_weapon_type(#"mine_trapd", &function_460fac27);
    callback::add_weapon_type(#"claymore_trapd", &function_460fac27);
}

// Namespace trapd/trapd
// Params 1, eflags: 0x0
// Checksum 0x131e190e, Offset: 0x150
// Size: 0x24
function function_460fac27(localclientnum) {
    self thread fx_think(localclientnum);
}

// Namespace trapd/trapd
// Params 1, eflags: 0x0
// Checksum 0xef15f37b, Offset: 0x180
// Size: 0xf8
function fx_think(localclientnum) {
    self notify(#"light_disable");
    self endon(#"light_disable");
    self endon(#"death");
    self util::waittill_dobj(localclientnum);
    for (;;) {
        self stop_light_fx(localclientnum);
        localplayer = function_f97e7787(localclientnum);
        self start_light_fx(localclientnum);
        util::server_wait(localclientnum, 0.3, 0.01, "player_switch");
        self util::waittill_dobj(localclientnum);
    }
}

// Namespace trapd/trapd
// Params 1, eflags: 0x0
// Checksum 0x4e1aa466, Offset: 0x280
// Size: 0x4a
function start_light_fx(localclientnum) {
    self.fx = util::playfxontag(localclientnum, level._effect[#"grenade_light"], self, "tag_fx");
}

// Namespace trapd/trapd
// Params 1, eflags: 0x0
// Checksum 0xef3853b9, Offset: 0x2d8
// Size: 0x4e
function stop_light_fx(localclientnum) {
    if (isdefined(self.fx) && self.fx != 0) {
        stopfx(localclientnum, self.fx);
        self.fx = undefined;
    }
}

