#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_4faef43b;

// Namespace namespace_4faef43b/namespace_dd8b9b1a
// Params 0, eflags: 0x6
// Checksum 0x30d721f8, Offset: 0x148
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_3793eb4a6c52c66f", &__init__, undefined, undefined, undefined);
}

// Namespace namespace_4faef43b/namespace_dd8b9b1a
// Params 0, eflags: 0x0
// Checksum 0xaf81942d, Offset: 0x190
// Size: 0x1b4
function __init__() {
    clientfield::register("scriptmover", "" + #"hash_322ed89801938bb9", 1, 1, "counter", &function_40fcb7b0, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_6d9aa5215e695ca2", 1, 1, "counter", &function_65502dee, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_1f232116f775fa91", 1, 1, "counter", &function_de8dd244, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_4719ef7fda616f3a", 1, 1, "counter", &function_b6000359, 0, 0);
    clientfield::register_clientuimodel("hudItems.reinforcing", #"hash_6f4b11a0bee9b73d", #"hash_4e0958d6dca7cb1d", 1, 1, "int", undefined, 0, 0);
}

// Namespace namespace_4faef43b/namespace_dd8b9b1a
// Params 7, eflags: 0x0
// Checksum 0x7961d2, Offset: 0x350
// Size: 0xa4
function function_de8dd244(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        playfx(fieldname, "destruct/fx9_dmg_window_wood_wz", self.origin, anglestoforward(self.angles) + (0, 90, 0), anglestoup(self.angles));
    }
}

// Namespace namespace_4faef43b/namespace_dd8b9b1a
// Params 7, eflags: 0x0
// Checksum 0x34c4f277, Offset: 0x400
// Size: 0xa4
function function_b6000359(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        playfx(fieldname, "destruct/fx9_dest_window_wood_wz", self.origin, anglestoforward(self.angles) + (0, 90, 0), anglestoup(self.angles));
    }
}

// Namespace namespace_4faef43b/namespace_dd8b9b1a
// Params 7, eflags: 0x0
// Checksum 0x6104596a, Offset: 0x4b0
// Size: 0xa4
function function_40fcb7b0(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        playfx(fieldname, "destruct/fx9_dmg_door_metal_wz", self.origin, anglestoforward(self.angles) + (0, 90, 0), anglestoup(self.angles));
    }
}

// Namespace namespace_4faef43b/namespace_dd8b9b1a
// Params 7, eflags: 0x0
// Checksum 0xb7743fec, Offset: 0x560
// Size: 0xa4
function function_65502dee(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        playfx(fieldname, "destruct/fx9_dest_door_metal_wz", self.origin, anglestoforward(self.angles) + (0, 90, 0), anglestoup(self.angles));
    }
}

