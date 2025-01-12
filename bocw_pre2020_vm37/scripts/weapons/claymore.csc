#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace claymore;

// Namespace claymore/claymore
// Params 0, eflags: 0x6
// Checksum 0x9b8b0587, Offset: 0x78
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"claymore", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace claymore/claymore
// Params 0, eflags: 0x4
// Checksum 0xc9e83da2, Offset: 0xc0
// Size: 0x34
function private function_70a657d8() {
    callback::add_weapon_type(#"claymore", &claymore_spawned);
}

// Namespace claymore/claymore
// Params 1, eflags: 0x0
// Checksum 0x5ec48459, Offset: 0x100
// Size: 0x90
function claymore_spawned(localclientnum) {
    self endon(#"death");
    self util::waittill_dobj(localclientnum);
    while (true) {
        if (isdefined(self.stunned) && self.stunned) {
            wait 0.1;
            continue;
        }
        self waittill(#"stunned");
        stopfx(localclientnum, self.claymorelaserfxid);
    }
}

