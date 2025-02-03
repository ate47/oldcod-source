#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;

#namespace player_heavy_helicopter;

// Namespace player_heavy_helicopter/player_heavy_helicopter
// Params 0, eflags: 0x6
// Checksum 0x4f8204d1, Offset: 0xf0
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"player_heavy_helicopter", &preinit, undefined, undefined, #"player_vehicle");
}

// Namespace player_heavy_helicopter/player_heavy_helicopter
// Params 1, eflags: 0x4
// Checksum 0xef90510d, Offset: 0x140
// Size: 0xc4
function private preinit(*localclientnum) {
    vehicle::add_vehicletype_callback("helicopter_heavy", &function_8220feb0);
    clientfield::register("toplayer", "hind_gunner_postfx_active", 1, 1, "int", &function_44ad5e3e, 0, 1);
    clientfield::register("vehicle", "hind_compass_icon", 1, 2, "int", &hind_compass_icon, 0, 1);
}

// Namespace player_heavy_helicopter/player_heavy_helicopter
// Params 1, eflags: 0x4
// Checksum 0x1a594472, Offset: 0x210
// Size: 0xc
function private function_8220feb0(*localclientnum) {
    
}

// Namespace player_heavy_helicopter/player_heavy_helicopter
// Params 7, eflags: 0x0
// Checksum 0xe0513d96, Offset: 0x228
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

// Namespace player_heavy_helicopter/player_heavy_helicopter
// Params 7, eflags: 0x0
// Checksum 0x9e6a76ae, Offset: 0x300
// Size: 0x112
function hind_compass_icon(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (!isdefined(self.scriptvehicletype) || self.scriptvehicletype != "helicopter_heavy") {
        return;
    }
    switch (bwastimejump) {
    case 0:
        self setcompassicon(#"hash_238039183607226d");
        break;
    case 1:
        self setcompassicon(#"hash_a6a2a558ed7bec6");
        break;
    case 2:
        self setcompassicon("");
        break;
    }
}

