#using scripts\core_common\aat_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\renderoverridebundle;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_d00dc3ab;

// Namespace namespace_d00dc3ab/namespace_d00dc3ab
// Params 0, eflags: 0x1 linked
// Checksum 0x7b3b9843, Offset: 0x1b8
// Size: 0x1ac
function function_3de84616() {
    if (!is_true(level.aat_in_use)) {
        return;
    }
    aat::register("zm_aat_brain_decay", #"hash_3c1c6f0860be6c5", "t7_icon_zm_aat_turned");
    clientfield::register("actor", "zm_aat_brain_decay", 1, 1, "int", &function_791e18ed, 0, 0);
    clientfield::register("vehicle", "zm_aat_brain_decay", 1, 1, "int", &function_791e18ed, 0, 0);
    clientfield::register("actor", "zm_aat_brain_decay_exp", 1, 1, "counter", &zm_aat_brain_decay_explosion, 0, 0);
    clientfield::register("vehicle", "zm_aat_brain_decay_exp", 1, 1, "counter", &zm_aat_brain_decay_explosion, 0, 0);
    renderoverridebundle::function_f72f089c(#"hash_5afb2d74423459bf", "rob_sonar_set_friendly_zm", &function_b9c917cc);
}

// Namespace namespace_d00dc3ab/namespace_d00dc3ab
// Params 7, eflags: 0x1 linked
// Checksum 0x2e327299, Offset: 0x370
// Size: 0x2b4
function function_791e18ed(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self renderoverridebundle::function_c8d97b8e(fieldname, #"zm_friendly", #"hash_5afb2d74423459bf");
    if (bwastimejump) {
        self setdrawname(#"hash_3a9d51a39880facd", 1);
        str_fx_tag = self aat::function_467efa7b(1);
        if (!isdefined(str_fx_tag)) {
            str_fx_tag = "tag_origin";
        }
        self.var_8c12ae9 = util::playfxontag(fieldname, "zm_weapons/fx8_aat_brain_decay_eye", self, "j_eyeball_le");
        self.var_8dfe2b97 = util::playfxontag(fieldname, "zm_weapons/fx8_aat_brain_decay_torso", self, str_fx_tag);
        if (!isdefined(self.var_67857d4d)) {
            self playsound(fieldname, #"hash_637c5e1579bb239a");
            self.var_67857d4d = self playloopsound(#"hash_6064261162c8a2e");
        }
        if (isdefined(self.var_4703d488)) {
            self [[ self.var_4703d488 ]](fieldname, bwastimejump);
        }
        return;
    }
    if (isdefined(self.var_8c12ae9)) {
        stopfx(fieldname, self.var_8c12ae9);
        self.var_8c12ae9 = undefined;
    }
    if (isdefined(self.var_4bc659c4)) {
        stopfx(fieldname, self.var_4bc659c4);
        self.var_4bc659c4 = undefined;
    }
    if (isdefined(self.var_8dfe2b97)) {
        stopfx(fieldname, self.var_8dfe2b97);
        self.var_8dfe2b97 = undefined;
    }
    if (isdefined(self.var_67857d4d)) {
        self stoploopsound(self.var_67857d4d);
        self.var_67857d4d = undefined;
    }
    if (isdefined(self.var_4703d488)) {
        self [[ self.var_4703d488 ]](fieldname, bwastimejump);
    }
}

// Namespace namespace_d00dc3ab/namespace_d00dc3ab
// Params 2, eflags: 0x1 linked
// Checksum 0xa90167ca, Offset: 0x630
// Size: 0x70
function function_b9c917cc(localclientnum, *str_bundle) {
    if (!self function_ca024039() || is_true(level.var_dc60105c) || isigcactive(str_bundle)) {
        return false;
    }
    return true;
}

// Namespace namespace_d00dc3ab/namespace_d00dc3ab
// Params 7, eflags: 0x1 linked
// Checksum 0xf3cdf8a, Offset: 0x6a8
// Size: 0x84
function zm_aat_brain_decay_explosion(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    util::playfxontag(bwastimejump, "zm_weapons/fx8_aat_brain_decay_head", self, "j_head");
    self playsound(0, #"hash_422ccb7ddff9b3f4");
}

