#using scripts\core_common\clientfield_shared;

#namespace namespace_45690bb8;

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 0, eflags: 0x1 linked
// Checksum 0xb0251c32, Offset: 0x88
// Size: 0x14
function init() {
    init_clientfields();
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 0, eflags: 0x1 linked
// Checksum 0x6db8ab41, Offset: 0xa8
// Size: 0x10c
function init_clientfields() {
    clientfield::register("scriptmover", "" + #"hash_18735ccb22cdefb5", 1, 1, "int", &function_d9576449, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_1df73c94e87e145c", 1, 1, "int", &function_7d5ce4d9, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_7e481cd16f021d79", 1, 1, "int", &function_5402e221, 0, 0);
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 7, eflags: 0x1 linked
// Checksum 0xd23e6c79, Offset: 0x1c0
// Size: 0x94
function function_d9576449(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        self.var_c0049122 = playfx(fieldname, #"zombie/fx_powerup_on_caution_zmb", self.origin);
        return;
    }
    stopfx(fieldname, self.var_c0049122);
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 7, eflags: 0x1 linked
// Checksum 0x758c8425, Offset: 0x260
// Size: 0xa4
function function_7d5ce4d9(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        var_d300bb6a = playfx(fieldname, #"zombie/fx_powerup_on_caution_zmb", self.origin + (0, 0, 80));
        return;
    }
    stopfx(fieldname, var_d300bb6a);
}

// Namespace namespace_45690bb8/namespace_45690bb8
// Params 7, eflags: 0x1 linked
// Checksum 0x2c9cddc6, Offset: 0x310
// Size: 0x94
function function_5402e221(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        self.var_d7267130 = playfx(fieldname, #"zombie/fx_powerup_on_caution_zmb", self.origin);
        return;
    }
    stopfx(fieldname, self.var_d7267130);
}

