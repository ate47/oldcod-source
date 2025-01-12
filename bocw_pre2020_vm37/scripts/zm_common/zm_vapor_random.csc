#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace zm_vapor_random;

// Namespace zm_vapor_random/zm_vapor_random
// Params 0, eflags: 0x6
// Checksum 0x3abaa60d, Offset: 0xf8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_vapor_random", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_vapor_random/zm_vapor_random
// Params 0, eflags: 0x4
// Checksum 0x3fb0ef9e, Offset: 0x140
// Size: 0x6c
function private function_70a657d8() {
    clientfield::register("scriptmover", "random_vapor_altar_available", 1, 1, "int", &random_vapor_altar_available_fx, 0, 0);
    level._effect[#"random_vapor_altar_available"] = "zombie/fx_powerup_on_green_zmb";
}

// Namespace zm_vapor_random/zm_vapor_random
// Params 7, eflags: 0x0
// Checksum 0xf5479590, Offset: 0x1b8
// Size: 0xcc
function random_vapor_altar_available_fx(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 1) {
        if (!isdefined(self.var_476bef54)) {
            self.var_476bef54 = util::playfxontag(fieldname, level._effect[#"random_vapor_altar_available"], self, "tag_origin");
        }
        return;
    }
    if (isdefined(self.var_476bef54)) {
        stopfx(fieldname, self.var_476bef54);
    }
}

