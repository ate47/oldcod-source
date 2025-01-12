#using scripts\core_common\aat_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\renderoverridebundle;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace ammomod_brainrot;

// Namespace ammomod_brainrot/ammomod_brainrot
// Params 0, eflags: 0x1 linked
// Checksum 0xa5e54d57, Offset: 0x2d0
// Size: 0x29c
function function_9384b521() {
    if (!is_true(level.aat_in_use)) {
        return;
    }
    aat::register("ammomod_brainrot", #"zmui/zm_ammomod_brainrot", "t7_icon_zm_aat_turned");
    aat::register("ammomod_brainrot_1", #"zmui/zm_ammomod_brainrot", "t7_icon_zm_aat_turned");
    aat::register("ammomod_brainrot_2", #"zmui/zm_ammomod_brainrot", "t7_icon_zm_aat_turned");
    aat::register("ammomod_brainrot_3", #"zmui/zm_ammomod_brainrot", "t7_icon_zm_aat_turned");
    aat::register("ammomod_brainrot_4", #"zmui/zm_ammomod_brainrot", "t7_icon_zm_aat_turned");
    aat::register("ammomod_brainrot_5", #"zmui/zm_ammomod_brainrot", "t7_icon_zm_aat_turned");
    clientfield::register("actor", "ammomod_brainrot", 1, 1, "int", &function_d500905a, 0, 0);
    clientfield::register("vehicle", "ammomod_brainrot", 1, 1, "int", &function_d500905a, 0, 0);
    clientfield::register("actor", "zm_ammomod_brainrot_exp", 1, 1, "counter", &function_1d8434b9, 0, 0);
    clientfield::register("vehicle", "zm_ammomod_brainrot_exp", 1, 1, "counter", &function_1d8434b9, 0, 0);
    renderoverridebundle::function_f72f089c(#"hash_4e9065fcc3da0f7f", "rob_sonar_set_friendly_zm", &function_b9c917cc);
}

// Namespace ammomod_brainrot/ammomod_brainrot
// Params 7, eflags: 0x1 linked
// Checksum 0x92decacf, Offset: 0x578
// Size: 0x3b4
function function_d500905a(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self renderoverridebundle::function_c8d97b8e(fieldname, #"zm_friendly", #"hash_4e9065fcc3da0f7f");
    if (bwastimejump) {
        self setdrawname(#"hash_3bbbc2abb11e8ec1", 1);
        if (isdefined(self gettagorigin("j_eyeball_le"))) {
            if (self.archetype === #"avogadro") {
                self.var_d59aa7bb = util::playfxontag(fieldname, "zm_weapons/fx9_aat_brain_rot_lvl1_mc_avo_eye", self, "j_eyeball_le");
            } else if (self.archetype === #"zombie_dog") {
                if (self.var_9fde8624 == #"hash_28e36e7b7d5421f") {
                    self.var_d59aa7bb = util::playfxontag(fieldname, "zm_weapons/fx9_aat_brain_rot_lvl1_mc_hound_hell_eye", self, "j_eyeball_le");
                }
                if (self.var_9fde8624 == #"hash_2a5479b83161cb35") {
                    self.var_d59aa7bb = util::playfxontag(fieldname, "zm_weapons/fx9_aat_brain_rot_lvl1_mc_hound_plague_eye", self, "j_eyeball_le");
                }
            } else {
                self.var_d59aa7bb = util::playfxontag(fieldname, "zm_weapons/fx9_aat_brain_rot_lvl1_mc_eye", self, "j_eyeball_le");
            }
        }
        if (isdefined(self gettagorigin("j_spine4"))) {
            self.var_6e431702 = util::playfxontag(fieldname, "zm_weapons/fx9_aat_brain_rot_lvl1_mc_torso", self, "j_spine4");
        }
        if (!isdefined(self.var_85f16cb5)) {
            self playsound(fieldname, #"hash_637c5e1579bb239a");
            self.var_85f16cb5 = self playloopsound(#"hash_6064261162c8a2e");
        }
        if (isdefined(self.var_5da36454)) {
            self [[ self.var_5da36454 ]](fieldname, bwastimejump);
        }
        return;
    }
    if (isdefined(self.var_d59aa7bb)) {
        stopfx(fieldname, self.var_d59aa7bb);
        self.var_d59aa7bb = undefined;
    }
    if (isdefined(self.var_8a31e8f)) {
        stopfx(fieldname, self.var_8a31e8f);
        self.var_8a31e8f = undefined;
    }
    if (isdefined(self.var_6e431702)) {
        stopfx(fieldname, self.var_6e431702);
        self.var_6e431702 = undefined;
    }
    if (isdefined(self.var_85f16cb5)) {
        self stoploopsound(self.var_85f16cb5);
        self.var_85f16cb5 = undefined;
    }
    if (isdefined(self.var_5da36454)) {
        self [[ self.var_5da36454 ]](fieldname, bwastimejump);
    }
}

// Namespace ammomod_brainrot/ammomod_brainrot
// Params 2, eflags: 0x1 linked
// Checksum 0xeb95e67d, Offset: 0x938
// Size: 0x70
function function_b9c917cc(localclientnum, *str_bundle) {
    if (!self function_ca024039() || is_true(level.var_dc60105c) || isigcactive(str_bundle)) {
        return false;
    }
    return true;
}

// Namespace ammomod_brainrot/ammomod_brainrot
// Params 7, eflags: 0x1 linked
// Checksum 0xce3298cd, Offset: 0x9b0
// Size: 0xa4
function function_1d8434b9(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (isdefined(self gettagorigin("j_head"))) {
        util::playfxontag(bwastimejump, "zm_weapons/fx9_aat_brain_rot_lvl5_aoe", self, "j_head");
    }
    self playsound(0, #"hash_422ccb7ddff9b3f4");
}

