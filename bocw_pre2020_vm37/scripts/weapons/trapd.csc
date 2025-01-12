#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace trapd;

// Namespace trapd/trapd
// Params 0, eflags: 0x6
// Checksum 0x67384e21, Offset: 0xb0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"trapd", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace trapd/trapd
// Params 0, eflags: 0x4
// Checksum 0xa597193, Offset: 0xf8
// Size: 0x64
function private function_70a657d8() {
    callback::add_weapon_type(#"mine_trapd", &function_9f6d38cf);
    callback::add_weapon_type(#"claymore_trapd", &function_9f6d38cf);
}

// Namespace trapd/trapd
// Params 1, eflags: 0x0
// Checksum 0xccac1ca, Offset: 0x168
// Size: 0x24
function function_9f6d38cf(localclientnum) {
    self thread fx_think(localclientnum);
}

// Namespace trapd/trapd
// Params 1, eflags: 0x0
// Checksum 0xc141669e, Offset: 0x198
// Size: 0xf8
function fx_think(localclientnum) {
    self notify(#"light_disable");
    self endon(#"light_disable");
    self endon(#"death");
    self util::waittill_dobj(localclientnum);
    for (;;) {
        self stop_light_fx(localclientnum);
        localplayer = function_5c10bd79(localclientnum);
        self start_light_fx(localclientnum);
        util::server_wait(localclientnum, 0.3, 0.01, "player_switch");
        self util::waittill_dobj(localclientnum);
    }
}

// Namespace trapd/trapd
// Params 1, eflags: 0x0
// Checksum 0xb89466b2, Offset: 0x298
// Size: 0x3a
function start_light_fx(localclientnum) {
    self.fx = util::playfxontag(localclientnum, "weapon/fx8_equip_light_os", self, "tag_fx");
}

// Namespace trapd/trapd
// Params 1, eflags: 0x0
// Checksum 0xf627766, Offset: 0x2e0
// Size: 0x4e
function stop_light_fx(localclientnum) {
    if (isdefined(self.fx) && self.fx != 0) {
        stopfx(localclientnum, self.fx);
        self.fx = undefined;
    }
}

