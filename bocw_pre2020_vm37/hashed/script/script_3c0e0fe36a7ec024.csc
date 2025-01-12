#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace namespace_12a6a726;

// Namespace namespace_12a6a726/namespace_12a6a726
// Params 0, eflags: 0x6
// Checksum 0x18632de1, Offset: 0xe8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_72a9f15f4124442", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_12a6a726/namespace_12a6a726
// Params 0, eflags: 0x0
// Checksum 0x73b1a992, Offset: 0x130
// Size: 0x4c
function function_70a657d8() {
    clientfield::register("scriptmover", "helicopter_crash_fx", 1, 1, "int", &helicopter_crash_fx, 0, 0);
}

// Namespace namespace_12a6a726/namespace_12a6a726
// Params 7, eflags: 0x0
// Checksum 0xf2ab0060, Offset: 0x188
// Size: 0x186
function helicopter_crash_fx(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        if (!isdefined(self.var_f756621f)) {
            self.var_f756621f = playfx(fieldname, "smoke/fx9_smk_downed_heli_body", self.origin, anglestoforward(self.angles), anglestoup(self.angles));
        }
        if (!isdefined(self.var_d8243293)) {
            self.var_d8243293 = playfx(fieldname, "fire/fx9_fire_downed_heli_body", self.origin, anglestoforward(self.angles), anglestoup(self.angles));
        }
        return;
    }
    if (isdefined(self.var_f756621f)) {
        stopfx(fieldname, self.var_f756621f);
        self.var_f756621f = undefined;
    }
    if (isdefined(self.var_d8243293)) {
        stopfx(fieldname, self.var_d8243293);
        self.var_d8243293 = undefined;
    }
}

