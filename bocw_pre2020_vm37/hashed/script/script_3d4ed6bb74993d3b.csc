#using scripts\core_common\aat_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_56577988;

// Namespace namespace_56577988/namespace_56577988
// Params 0, eflags: 0x1 linked
// Checksum 0x752686d0, Offset: 0x1b0
// Size: 0x1b4
function function_a9c3764f() {
    if (!is_true(level.aat_in_use)) {
        return;
    }
    aat::register("zm_aat_plasmatic_burst", #"hash_164d02d599d1fa8f", "t7_icon_zm_aat_blast_furnace");
    clientfield::register("actor", "zm_aat_plasmatic_burst" + "_explosion", 1, 1, "counter", &zm_aat_plasmatic_burst_explosion, 0, 0);
    clientfield::register("vehicle", "zm_aat_plasmatic_burst" + "_explosion", 1, 1, "counter", &zm_aat_plasmatic_burst_explosion, 0, 0);
    clientfield::register("actor", "zm_aat_plasmatic_burst" + "_burn", 1, 1, "int", &function_7abfa551, 0, 0);
    clientfield::register("vehicle", "zm_aat_plasmatic_burst" + "_burn", 1, 1, "int", &function_a98c42a3, 0, 0);
    level._effect[#"zm_aat_plasmatic_burst"] = "zm_weapons/fx8_aat_plasmatic_burst_torso";
}

// Namespace namespace_56577988/namespace_56577988
// Params 7, eflags: 0x1 linked
// Checksum 0x7e35ea6d, Offset: 0x370
// Size: 0xdc
function zm_aat_plasmatic_burst_explosion(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (isdefined(self)) {
        str_fx_tag = self aat::function_467efa7b(1);
        if (!isdefined(str_fx_tag)) {
            str_fx_tag = "tag_origin";
        }
        self playsound(bwastimejump, #"hash_6990e5a39e894c04");
        util::playfxontag(bwastimejump, level._effect[#"zm_aat_plasmatic_burst"], self, str_fx_tag);
    }
}

// Namespace namespace_56577988/namespace_56577988
// Params 7, eflags: 0x1 linked
// Checksum 0xc56be5d6, Offset: 0x458
// Size: 0xbc
function function_7abfa551(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        str_tag = "j_spine4";
        v_tag = self gettagorigin(str_tag);
        if (!isdefined(v_tag)) {
            str_tag = "tag_origin";
        }
        self function_c36aebed(fieldname, str_tag);
        return;
    }
    self function_b4d21494(fieldname);
}

// Namespace namespace_56577988/namespace_56577988
// Params 7, eflags: 0x1 linked
// Checksum 0xd56acb8b, Offset: 0x520
// Size: 0xbc
function function_a98c42a3(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        str_tag = "tag_body";
        v_tag = self gettagorigin(str_tag);
        if (!isdefined(v_tag)) {
            str_tag = "tag_origin";
        }
        self function_c36aebed(fieldname, str_tag);
        return;
    }
    self function_b4d21494(fieldname);
}

// Namespace namespace_56577988/namespace_56577988
// Params 2, eflags: 0x1 linked
// Checksum 0x8ae72977, Offset: 0x5e8
// Size: 0x9a
function function_c36aebed(localclientnum, tag) {
    self.var_def62862 = util::playfxontag(localclientnum, "zm_weapons/fx8_aat_plasmatic_burst_torso_fire", self, tag);
    self.var_4a87444e = util::playfxontag(localclientnum, "zm_weapons/fx8_aat_plasmatic_burst_head", self, "j_head");
    if (!isdefined(self.var_fa3f8eb7)) {
        self.var_fa3f8eb7 = self playloopsound(#"hash_645b60f29309dc9b");
    }
}

// Namespace namespace_56577988/namespace_56577988
// Params 1, eflags: 0x1 linked
// Checksum 0x387d5aa6, Offset: 0x690
// Size: 0x84
function function_b4d21494(localclientnum) {
    if (isdefined(self.var_fa3f8eb7)) {
        self stoploopsound(self.var_fa3f8eb7);
    }
    if (isdefined(self.var_def62862)) {
        stopfx(localclientnum, self.var_def62862);
    }
    if (isdefined(self.var_4a87444e)) {
        stopfx(localclientnum, self.var_4a87444e);
    }
}

