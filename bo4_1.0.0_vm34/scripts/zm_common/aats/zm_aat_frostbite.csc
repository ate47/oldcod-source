#using scripts\core_common\aat_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;

#namespace zm_aat_frostbite;

// Namespace zm_aat_frostbite/zm_aat_frostbite
// Params 0, eflags: 0x2
// Checksum 0xe999fb34, Offset: 0x180
// Size: 0x34
function autoexec __init__system__() {
    system::register("zm_aat_frostbite", &__init__, undefined, undefined);
}

// Namespace zm_aat_frostbite/zm_aat_frostbite
// Params 0, eflags: 0x0
// Checksum 0x9b867f4e, Offset: 0x1c0
// Size: 0x1c2
function __init__() {
    if (!(isdefined(level.aat_in_use) && level.aat_in_use)) {
        return;
    }
    aat::register("zm_aat_frostbite", #"hash_5386c3e338c1b314", "t7_icon_zm_aat_thunder_wall");
    clientfield::register("actor", "zm_aat_frostbite_trail_clientfield", 1, 1, "int", &function_5ad52821, 1, 0);
    clientfield::register("vehicle", "zm_aat_frostbite_trail_clientfield", 1, 1, "int", &function_5ad52821, 1, 0);
    clientfield::register("actor", "zm_aat_frostbite_explosion_clientfield", 1, 1, "counter", &aat_frostbite_explosion, 1, 0);
    clientfield::register("vehicle", "zm_aat_frostbite_explosion_clientfield", 1, 1, "counter", &aat_frostbite_explosion, 1, 0);
    level._effect[#"hash_139ac9f86d1a96cd"] = "zm_weapons/fx8_aat_water_torso";
    level._effect[#"aat_frostbite_explosion"] = "zm_weapons/fx8_aat_water_exp";
}

// Namespace zm_aat_frostbite/zm_aat_frostbite
// Params 7, eflags: 0x0
// Checksum 0xb3f231e3, Offset: 0x390
// Size: 0x104
function function_5ad52821(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_74465ae2 = util::playfxontag(localclientnum, level._effect[#"hash_139ac9f86d1a96cd"], self, self zm_utility::function_a7776589(1));
        if (!isdefined(self.var_525c4045)) {
            self.var_525c4045 = self playloopsound(#"hash_f5d043ac36e0244");
        }
        self thread function_6b535ff8(localclientnum, 1);
        return;
    }
    self thread function_6b535ff8(localclientnum, 0);
}

// Namespace zm_aat_frostbite/zm_aat_frostbite
// Params 2, eflags: 0x0
// Checksum 0xbb52af7e, Offset: 0x4a0
// Size: 0x1f0
function function_6b535ff8(localclientnum, b_freeze) {
    self notify(#"end_frosty");
    self endon(#"death", #"end_frosty");
    self playrenderoverridebundle("rob_test_character_ice");
    if (!isdefined(self.var_34e4e2c3)) {
        self.var_34e4e2c3 = 0;
    }
    if (b_freeze) {
        var_9b366fb9 = self.var_34e4e2c3 + 0.5;
    }
    while (true) {
        self function_98a01e4c("rob_test_character_ice", "Threshold", self.var_34e4e2c3);
        if (b_freeze) {
            self.var_34e4e2c3 += 0.2;
        } else {
            self.var_34e4e2c3 -= 0.05;
        }
        if (b_freeze && (self.var_34e4e2c3 >= var_9b366fb9 || self.var_34e4e2c3 >= 1)) {
            break;
        } else if (self.var_34e4e2c3 <= 0) {
            self stoprenderoverridebundle("rob_test_character_ice");
            if (isdefined(self.var_74465ae2)) {
                stopfx(localclientnum, self.var_74465ae2);
                self.var_74465ae2 = undefined;
            }
            if (isdefined(self.var_525c4045)) {
                self stoploopsound(self.var_525c4045);
                self.var_525c4045 = undefined;
            }
            break;
        }
        wait 0.1;
    }
}

// Namespace zm_aat_frostbite/zm_aat_frostbite
// Params 7, eflags: 0x0
// Checksum 0x754bb101, Offset: 0x698
// Size: 0xc4
function aat_frostbite_explosion(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playfx(localclientnum, level._effect[#"aat_frostbite_explosion"], self gettagorigin(self zm_utility::function_a7776589(1)));
    playsound(0, #"hash_7de1026336539baa", self.origin);
}

