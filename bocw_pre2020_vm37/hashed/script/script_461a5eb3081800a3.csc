#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;

#namespace namespace_bff7ce85;

// Namespace namespace_bff7ce85/level_init
// Params 1, eflags: 0x40
// Checksum 0xc4756d50, Offset: 0x160
// Size: 0x184
function event_handler[level_init] main(*eventstruct) {
    clientfield::register("scriptmover", "" + #"hash_74d70bb7fe52c00", 1, 1, "int", &function_e15dd642, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_3eeee7f3f5bdb9ff", 1, 1, "int", &function_7b661739, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_18bcf106c476dfeb", 1, 1, "counter", &function_32398bfc, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_186c35405f4624bc", 1, 2, "int", &function_968ccb74, 0, 0);
    util::waitforclient(0);
}

// Namespace namespace_bff7ce85/namespace_cb308359
// Params 7, eflags: 0x0
// Checksum 0x1bbe5fc2, Offset: 0x2f0
// Size: 0x9c
function function_7b661739(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    playfx(bwastimejump, "explosions/fx8_exp_elec_killstreak", self.origin + (0, 0, 32), anglestoforward(self.angles), anglestoup(self.angles));
}

// Namespace namespace_bff7ce85/namespace_cb308359
// Params 7, eflags: 0x0
// Checksum 0x9fe299e5, Offset: 0x398
// Size: 0x64
function function_e15dd642(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    util::playfxontag(bwastimejump, "explosions/fx9_exp_generic_lg", self, "tag_origin");
}

// Namespace namespace_bff7ce85/namespace_cb308359
// Params 7, eflags: 0x0
// Checksum 0x4b0740c0, Offset: 0x408
// Size: 0x64
function function_32398bfc(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    util::playfxontag(bwastimejump, "sr/fx9_obj_console_defend_dmg_os", self, "tag_origin");
}

// Namespace namespace_bff7ce85/namespace_cb308359
// Params 7, eflags: 0x0
// Checksum 0xae27a1ee, Offset: 0x478
// Size: 0xda
function function_968ccb74(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 1) {
        self.var_bccdae1e = util::playfxontag(fieldname, "sr/fx9_obj_console_defend_dmg_state_1", self, "tag_origin");
        return;
    }
    if (bwastimejump == 2) {
        if (isdefined(self.var_bccdae1e)) {
            stopfx(fieldname, self.var_bccdae1e);
        }
        self.var_f3fe9c83 = util::playfxontag(fieldname, "sr/fx9_obj_console_defend_dmg_state_2", self, "tag_origin");
    }
}

