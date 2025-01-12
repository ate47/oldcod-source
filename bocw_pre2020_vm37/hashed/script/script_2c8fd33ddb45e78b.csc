#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_25297a8a;

// Namespace namespace_25297a8a/namespace_4abf1500
// Params 0, eflags: 0x6
// Checksum 0xfeef99b7, Offset: 0xb8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_63e00d742a373f5f", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_25297a8a/namespace_4abf1500
// Params 0, eflags: 0x1 linked
// Checksum 0xd6d97eaa, Offset: 0x100
// Size: 0x7c
function function_70a657d8() {
    clientfield::register("scriptmover", "" + #"hash_475f3329eaf62eaf", 1, 1, "int", &function_63960208, 0, 0);
    level.var_238bd723 = struct::get_script_bundle_instances("zmintel");
}

// Namespace namespace_25297a8a/namespace_4abf1500
// Params 7, eflags: 0x1 linked
// Checksum 0x7ce5b3dd, Offset: 0x188
// Size: 0xb6
function function_63960208(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump) {
    if (bwasdemojump == 1) {
        self.var_a60e0aca = util::playfxontag(fieldname, #"zombie/fx_powerup_on_caution_zmb", self, "tag_origin");
        return;
    }
    if (isdefined(self.var_a60e0aca)) {
        stopfx(fieldname, self.var_a60e0aca);
        self.var_a60e0aca = undefined;
    }
}

