#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;

#namespace player_heavy_helicopter;

// Namespace player_heavy_helicopter/player_heavy_helicopter
// Params 0, eflags: 0x6
// Checksum 0x123ca246, Offset: 0xd0
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"player_heavy_helicopter", &function_70a657d8, undefined, undefined, #"player_vehicle");
}

// Namespace player_heavy_helicopter/player_heavy_helicopter
// Params 1, eflags: 0x5 linked
// Checksum 0xff049199, Offset: 0x120
// Size: 0x7c
function private function_70a657d8(*localclientnum) {
    vehicle::add_vehicletype_callback("helicopter_heavy", &function_8220feb0);
    clientfield::register("toplayer", "hind_gunner_postfx_active", 1, 1, "int", &function_44ad5e3e, 0, 1);
}

// Namespace player_heavy_helicopter/player_heavy_helicopter
// Params 1, eflags: 0x5 linked
// Checksum 0x5af1fc43, Offset: 0x1a8
// Size: 0xc
function private function_8220feb0(*localclientnum) {
    
}

// Namespace player_heavy_helicopter/player_heavy_helicopter
// Params 7, eflags: 0x1 linked
// Checksum 0x96af8740, Offset: 0x1c0
// Size: 0xcc
function function_44ad5e3e(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        if (!self postfx::function_556665f2(#"hash_4a4dfccbf3585bcc")) {
            self postfx::playpostfxbundle(#"hash_4a4dfccbf3585bcc");
        }
        return;
    }
    if (self postfx::function_556665f2(#"hash_4a4dfccbf3585bcc")) {
        self postfx::stoppostfxbundle(#"hash_4a4dfccbf3585bcc");
    }
}

