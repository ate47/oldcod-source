#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_58949729;

// Namespace namespace_58949729/namespace_58949729
// Params 0, eflags: 0x6
// Checksum 0x6cb40fb9, Offset: 0x130
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_5f19cd68b4607f52", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_58949729/namespace_58949729
// Params 0, eflags: 0x1 linked
// Checksum 0xa0bf5e64, Offset: 0x178
// Size: 0x5c
function function_70a657d8() {
    clientfield::register("scriptmover", "reward_chest_fx", 1, getminbitcountfornum(4), "int", &reward_chest_fx, 0, 0);
}

// Namespace namespace_58949729/namespace_58949729
// Params 7, eflags: 0x1 linked
// Checksum 0x9d6bd226, Offset: 0x1e0
// Size: 0x232
function reward_chest_fx(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    switch (bwastimejump) {
    case 0:
        if (isdefined(self.n_fx_id)) {
            stopfx(fieldname, self.n_fx_id);
        }
        if (isdefined(self.var_b3673abf)) {
            self stoploopsound(self.var_b3673abf);
        }
        break;
    case 1:
        self.n_fx_id = util::playfxontag(fieldname, "sr/fx9_chest_explore_amb_sm", self, "tag_origin");
        self.var_b3673abf = self playloopsound(#"hash_149989d596125e40");
        break;
    case 2:
        self.n_fx_id = util::playfxontag(fieldname, "sr/fx9_chest_explore_amb_md", self, "tag_origin");
        self.var_b3673abf = self playloopsound(#"hash_3b1f5984e7ae4c48");
        break;
    case 3:
        self.n_fx_id = util::playfxontag(fieldname, "sr/fx9_chest_explore_amb_lg", self, "tag_origin");
        self.var_b3673abf = self playloopsound(#"hash_5dc67061425177d4");
        break;
    case 4:
        self.n_fx_id = util::playfxontag(fieldname, "sr/fx9_chest_objective_amb", self, "tag_origin");
        break;
    }
}

