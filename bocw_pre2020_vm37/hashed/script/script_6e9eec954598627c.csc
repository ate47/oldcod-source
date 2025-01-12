#using scripts\core_common\aat_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace aat_frostbite;

// Namespace aat_frostbite/aat_frostbite
// Params 0, eflags: 0x1 linked
// Checksum 0x8476381, Offset: 0x1b8
// Size: 0x1b4
function function_b39d1bd2() {
    if (!is_true(level.aat_in_use)) {
        return;
    }
    aat::register("zm_aat_frostbite", #"hash_5386c3e338c1b314", "t7_icon_zm_aat_thunder_wall");
    clientfield::register("actor", "zm_aat_frostbite_trail_clientfield", 1, 1, "int", &function_bad6b477, 1, 0);
    clientfield::register("vehicle", "zm_aat_frostbite_trail_clientfield", 1, 1, "int", &function_bad6b477, 1, 0);
    clientfield::register("actor", "zm_aat_frostbite_explosion_clientfield", 1, 1, "counter", &aat_frostbite_explosion, 1, 0);
    clientfield::register("vehicle", "zm_aat_frostbite_explosion_clientfield", 1, 1, "counter", &aat_frostbite_explosion, 1, 0);
    level._effect[#"hash_139ac9f86d1a96cd"] = "zm_weapons/fx8_aat_water_torso";
    level._effect[#"aat_frostbite_explosion"] = "zm_weapons/fx8_aat_water_exp";
}

// Namespace aat_frostbite/aat_frostbite
// Params 7, eflags: 0x1 linked
// Checksum 0xcad048c8, Offset: 0x378
// Size: 0x174
function function_bad6b477(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        str_fx_tag = self aat::function_467efa7b(1);
        if (!isdefined(str_fx_tag)) {
            str_fx_tag = "tag_origin";
        }
        self.var_c19403bf = util::playfxontag(fieldname, level._effect[#"hash_139ac9f86d1a96cd"], self, str_fx_tag);
        if (self.archetype === #"catalyst" || self.archetype === #"tiger") {
            self thread function_b8cda358(fieldname);
        }
        if (!isdefined(self.var_dacf22f6)) {
            self.var_dacf22f6 = self playloopsound(#"hash_f5d043ac36e0244");
        }
        self thread function_d84b013b(fieldname, 1);
        return;
    }
    self thread function_d84b013b(fieldname, 0);
}

// Namespace aat_frostbite/aat_frostbite
// Params 2, eflags: 0x1 linked
// Checksum 0x27976e31, Offset: 0x4f8
// Size: 0x1f8
function function_d84b013b(localclientnum, b_freeze) {
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
            if (isdefined(self.var_c19403bf)) {
                stopfx(localclientnum, self.var_c19403bf);
                self.var_c19403bf = undefined;
            }
            if (isdefined(self.var_dacf22f6)) {
                self stoploopsound(self.var_dacf22f6);
                self.var_dacf22f6 = undefined;
            }
            break;
        }
        wait 0.1;
    }
}

// Namespace aat_frostbite/aat_frostbite
// Params 1, eflags: 0x1 linked
// Checksum 0xc296d8eb, Offset: 0x6f8
// Size: 0x74
function function_b8cda358(localclientnum) {
    self notify("41cc0bdf289d7d9c");
    self endon("41cc0bdf289d7d9c");
    var_c19403bf = self.var_c19403bf;
    self waittill(#"death");
    if (isdefined(var_c19403bf)) {
        killfx(localclientnum, var_c19403bf);
    }
}

// Namespace aat_frostbite/aat_frostbite
// Params 7, eflags: 0x1 linked
// Checksum 0xc675aa9a, Offset: 0x778
// Size: 0xe4
function aat_frostbite_explosion(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (isdefined(self)) {
        v_fx_origin = self gettagorigin(self aat::function_467efa7b(1));
        if (!isdefined(v_fx_origin)) {
            v_fx_origin = self.origin;
        }
        playfx(bwastimejump, level._effect[#"aat_frostbite_explosion"], v_fx_origin);
        self playsound(bwastimejump, #"hash_7de1026336539baa");
    }
}

