#using scripts\core_common\aat_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace ammomod_cryofreeze;

// Namespace ammomod_cryofreeze/ammomod_cryofreeze
// Params 0, eflags: 0x1 linked
// Checksum 0xe7600e5, Offset: 0x300
// Size: 0x264
function function_ab6c8a0b() {
    if (!is_true(level.aat_in_use)) {
        return;
    }
    aat::register("ammomod_cryofreeze", #"zmui/zm_ammomod_cryofreeze", "t7_icon_zm_aat_thunder_wall");
    aat::register("ammomod_cryofreeze_1", #"zmui/zm_ammomod_cryofreeze", "t7_icon_zm_aat_thunder_wall");
    aat::register("ammomod_cryofreeze_2", #"zmui/zm_ammomod_cryofreeze", "t7_icon_zm_aat_thunder_wall");
    aat::register("ammomod_cryofreeze_3", #"zmui/zm_ammomod_cryofreeze", "t7_icon_zm_aat_thunder_wall");
    aat::register("ammomod_cryofreeze_4", #"zmui/zm_ammomod_cryofreeze", "t7_icon_zm_aat_thunder_wall");
    aat::register("ammomod_cryofreeze_5", #"zmui/zm_ammomod_cryofreeze", "t7_icon_zm_aat_thunder_wall");
    clientfield::register("actor", "zm_ammomod_cryofreeze_trail_clientfield", 1, 1, "int", &function_a7a5e842, 1, 0);
    clientfield::register("vehicle", "zm_ammomod_cryofreeze_trail_clientfield", 1, 1, "int", &function_a7a5e842, 1, 0);
    clientfield::register("actor", "zm_ammomod_cryofreeze_explosion_clientfield", 1, 1, "counter", &function_de7bde57, 1, 0);
    clientfield::register("vehicle", "zm_ammomod_cryofreeze_explosion_clientfield", 1, 1, "counter", &function_de7bde57, 1, 0);
}

// Namespace ammomod_cryofreeze/ammomod_cryofreeze
// Params 7, eflags: 0x1 linked
// Checksum 0x84cce4f6, Offset: 0x570
// Size: 0x264
function function_a7a5e842(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        str_fx_tag = self aat::function_467efa7b(1);
        if (!isdefined(str_fx_tag)) {
            str_fx_tag = "tag_origin";
        }
        if (self.archetype === #"zombie_dog") {
            self.var_feabd9ee = util::playfxontag(fieldname, "zm_weapons/fx9_aat_cryofreeze_lvl1_slow_hound", self, "j_spine2");
        } else if (self.archetype === #"raz") {
            self.var_feabd9ee = util::playfxontag(fieldname, "zm_weapons/fx9_aat_cryofreeze_lvl1_slow_raz", self, "j_spine4");
        } else if (self.archetype === #"hash_7c0d83ac1e845ac2") {
            self.var_feabd9ee = util::playfxontag(fieldname, "zm_weapons/fx9_aat_cryofreeze_lvl1_slow_steiner", self, "j_spine4");
        } else if (self.archetype === #"zombie") {
            self.var_feabd9ee = util::playfxontag(fieldname, "zm_weapons/fx9_aat_cryofreeze_lvl1_slow", self, "j_spine4");
        } else {
            self.var_feabd9ee = util::playfxontag(fieldname, "zm_weapons/fx9_aat_cryofreeze_lvl1_slow", self, str_fx_tag);
        }
        if (self.archetype === #"zombie_dog") {
            self thread function_a565490f(fieldname);
        }
        if (!isdefined(self.var_f41344b)) {
            self.var_f41344b = self playloopsound(#"hash_57e86769d6cf4056");
        }
        self thread function_bfdbfcd(fieldname, 1);
        return;
    }
    self thread function_bfdbfcd(fieldname, 0);
}

// Namespace ammomod_cryofreeze/ammomod_cryofreeze
// Params 2, eflags: 0x1 linked
// Checksum 0x5afd6075, Offset: 0x7e0
// Size: 0x1f8
function function_bfdbfcd(localclientnum, b_freeze) {
    self notify(#"end_frosty");
    self endon(#"death", #"end_frosty");
    self playrenderoverridebundle("rob_test_character_ice");
    if (!isdefined(self.var_82fb67e7)) {
        self.var_82fb67e7 = 0;
    }
    if (b_freeze) {
        var_875c79c1 = self.var_82fb67e7 + 0.5;
    }
    while (true) {
        self function_78233d29("rob_test_character_ice", "", "Threshold", self.var_82fb67e7);
        if (b_freeze) {
            self.var_82fb67e7 += 0.2;
        } else {
            self.var_82fb67e7 -= 0.05;
        }
        if (b_freeze && (self.var_82fb67e7 >= var_875c79c1 || self.var_82fb67e7 >= 1)) {
            break;
        } else if (self.var_82fb67e7 <= 0) {
            self stoprenderoverridebundle("rob_test_character_ice");
            if (isdefined(self.var_feabd9ee)) {
                stopfx(localclientnum, self.var_feabd9ee);
                self.var_feabd9ee = undefined;
            }
            if (isdefined(self.var_f41344b)) {
                self stoploopsound(self.var_f41344b);
                self.var_f41344b = undefined;
            }
            break;
        }
        wait 0.1;
    }
}

// Namespace ammomod_cryofreeze/ammomod_cryofreeze
// Params 1, eflags: 0x1 linked
// Checksum 0xb4a5cfb2, Offset: 0x9e0
// Size: 0x74
function function_a565490f(localclientnum) {
    self notify("6b7cf8ef4714d26");
    self endon("6b7cf8ef4714d26");
    var_feabd9ee = self.var_feabd9ee;
    self waittill(#"death");
    if (isdefined(var_feabd9ee)) {
        killfx(localclientnum, var_feabd9ee);
    }
}

// Namespace ammomod_cryofreeze/ammomod_cryofreeze
// Params 7, eflags: 0x1 linked
// Checksum 0x22543d84, Offset: 0xa60
// Size: 0xcc
function function_de7bde57(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (isdefined(self)) {
        str_tag = isdefined(self gettagorigin("j_spine4")) ? "j_spine4" : "tag_origin";
        util::playfxontag(bwastimejump, "zm_weapons/fx9_aat_cryofreeze_lvl5_aoe", self, str_tag);
        self playsound(bwastimejump, #"hash_27366666d148d420");
    }
}

