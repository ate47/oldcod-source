#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;

#namespace namespace_3f0e5106;

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 0, eflags: 0x2
// Checksum 0x6e5bdf6c, Offset: 0x240
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"hash_32658a301920c858", &__init__, undefined, undefined);
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 0, eflags: 0x0
// Checksum 0x7810d313, Offset: 0x288
// Size: 0x87a
function __init__() {
    clientfield::register("scriptmover", "magma_fireplace_fx", 1, getminbitcountfornum(4), "int", &magma_fireplace_fx, 0, 0);
    clientfield::register("scriptmover", "magma_fireplace_skull_fx", 1, 1, "int", &magma_fireplace_skull_fx, 0, 0);
    clientfield::register("scriptmover", "magma_door_barrier_fx", 1, 1, "int", &magma_door_barrier_fx, 0, 0);
    clientfield::register("scriptmover", "magma_glow_fx", 1, 1, "int", &magma_glow_fx, 0, 0);
    clientfield::register("scriptmover", "magma_forging_fx", 1, 2, "int", &magma_forging_fx, 0, 0);
    clientfield::register("scriptmover", "magma_urn_fire_fx", 1, 2, "int", &magma_urn_fire_fx, 0, 0);
    clientfield::register("scriptmover", "magma_urn_ember_fx", 1, 1, "int", &magma_urn_ember_fx, 0, 0);
    clientfield::register("scriptmover", "bg_spawn_fx", 1, 1, "int", &function_3a027ca0, 0, 0);
    clientfield::register("toplayer", "magma_gat_glow_override", 1, 1, "int", &magma_gat_glow_override, 0, 0);
    clientfield::register("toplayer", "magma_gat_glow_recharge", 1, 1, "counter", &magma_gat_glow_recharge, 0, 0);
    clientfield::register("toplayer", "magma_gat_glow_shot_fired", 1, 1, "counter", &magma_gat_glow_shot_fired, 0, 0);
    clientfield::register("scriptmover", "magma_essence_explode_fx", 1, 1, "counter", &magma_essence_explode_fx, 0, 0);
    clientfield::register("scriptmover", "magma_gat_essence_fx", 1, 1, "int", &magma_gat_essence_fx, 0, 0);
    clientfield::register("scriptmover", "magma_gat_disappear_fx", 1, 1, "counter", &magma_gat_disappear_fx, 0, 0);
    clientfield::register("scriptmover", "magma_urn_triggered_fx", 1, 1, "counter", &magma_urn_triggered_fx, 0, 0);
    clientfield::register("scriptmover", "acid_gat_lock_fx", 1, 1, "counter", &acid_gat_lock_fx, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_7692067c56d8b6cc", 1, 1, "int", &function_5a5fb4d2, 0, 0);
    level._effect[#"magma_fireplace"] = #"hash_50cd5a75aebe8def";
    level._effect[#"hash_22aea05cb07dd55e"] = #"hash_51005475aee9dd56";
    level._effect[#"hash_70407be743f59f31"] = #"hash_2fcb634860aadcc5";
    level._effect[#"hash_708f71e744396284"] = #"hash_303469486103d000";
    level._effect[#"magma_skull"] = #"hash_6b993f3f5e31e2b5";
    level._effect[#"hash_1553e20e5242f527"] = #"hash_ce21486cbb74ba2";
    level._effect[#"hash_d9adad5b2ead852"] = #"hash_1a2b69544013ee25";
    level._effect[#"magma_glow"] = #"hash_69324137a8ab8427";
    level._effect[#"hash_35748cc8bb5f678b"] = #"hash_6b993f3f5e31e2b5";
    level._effect[#"bg_quest_spawn"] = #"hash_1636a510bead42c2";
    level._effect[#"hash_40c10e05964e71b5"] = #"hash_4c5e26f94f35e7fb";
    level._effect[#"magma_urn"] = #"hash_2529982fe72e4e4";
    level._effect[#"hash_577c7197e639a24b"] = #"hash_6ce5c811700c8c4";
    level._effect[#"hash_71cebe03a25b3339"] = #"hash_6f5790d353dd5caf";
    level._effect[#"hash_28455b81d5e86c62"] = #"hash_4d293d8817fcdc0c";
    level._effect[#"hash_54790ee0d9025900"] = #"hash_6fdfb9444067e8f4";
    level._effect[#"hash_5d3b4b76ea5885f6"] = #"hash_4835bd332e8a78c7";
    level._effect[#"hash_3932ab509a43ca38"] = #"hash_7c63ac8e5b0a88e6";
    level._effect[#"acid_gat_lock_fx"] = #"hash_170bbc9437bc68c9";
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 7, eflags: 0x0
// Checksum 0x111e0cb9, Offset: 0xb10
// Size: 0x1ca
function magma_fireplace_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (isdefined(self.var_a604be76)) {
        stopfx(localclientnum, self.var_a604be76);
        self.var_a604be76 = undefined;
    }
    switch (newval) {
    case 1:
        self.var_a604be76 = util::playfxontag(localclientnum, level._effect[#"magma_fireplace"], self, "tag_origin");
        break;
    case 2:
        self.var_a604be76 = util::playfxontag(localclientnum, level._effect[#"hash_22aea05cb07dd55e"], self, "tag_origin");
        break;
    case 3:
        self.var_a604be76 = util::playfxontag(localclientnum, level._effect[#"hash_708f71e744396284"], self, "tag_origin");
        break;
    case 4:
        self.var_a604be76 = util::playfxontag(localclientnum, level._effect[#"hash_70407be743f59f31"], self, "tag_origin");
        break;
    }
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 7, eflags: 0x0
// Checksum 0x9f5550c6, Offset: 0xce8
// Size: 0xf6
function magma_fireplace_skull_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval == 1) {
        if (isdefined(self.var_e89a5538)) {
            stopfx(localclientnum, self.var_e89a5538);
            self.var_e89a5538 = undefined;
        }
        self.var_e89a5538 = util::playfxontag(localclientnum, level._effect[#"magma_skull"], self, "afterlife_01");
        return;
    }
    if (isdefined(self.var_e89a5538)) {
        stopfx(localclientnum, self.var_e89a5538);
        self.var_e89a5538 = undefined;
    }
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 7, eflags: 0x0
// Checksum 0x6fa98dc9, Offset: 0xde8
// Size: 0xf6
function magma_gat_essence_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval == 1) {
        if (isdefined(self.var_ace5f437)) {
            stopfx(localclientnum, self.var_ace5f437);
            self.var_ace5f437 = undefined;
        }
        self.var_ace5f437 = util::playfxontag(localclientnum, level._effect[#"hash_54790ee0d9025900"], self, "tag_origin");
        return;
    }
    if (isdefined(self.var_ace5f437)) {
        killfx(localclientnum, self.var_ace5f437);
        self.var_ace5f437 = undefined;
    }
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 7, eflags: 0x0
// Checksum 0x5a251f69, Offset: 0xee8
// Size: 0xf6
function magma_door_barrier_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval == 1) {
        if (isdefined(self.var_9e93d68d)) {
            stopfx(localclientnum, self.var_9e93d68d);
            self.var_9e93d68d = undefined;
        }
        self.var_9e93d68d = util::playfxontag(localclientnum, level._effect[#"hash_1553e20e5242f527"], self, "tag_origin");
        return;
    }
    if (isdefined(self.var_9e93d68d)) {
        stopfx(localclientnum, self.var_9e93d68d);
        self.var_9e93d68d = undefined;
    }
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 7, eflags: 0x0
// Checksum 0x5eefd424, Offset: 0xfe8
// Size: 0xf6
function magma_glow_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval == 1) {
        if (isdefined(self.var_4d48cfd0)) {
            stopfx(localclientnum, self.var_4d48cfd0);
            self.var_4d48cfd0 = undefined;
        }
        self.var_4d48cfd0 = util::playfxontag(localclientnum, level._effect[#"magma_glow"], self, "tag_origin");
        return;
    }
    if (isdefined(self.var_4d48cfd0)) {
        stopfx(localclientnum, self.var_4d48cfd0);
        self.var_4d48cfd0 = undefined;
    }
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 7, eflags: 0x0
// Checksum 0x99b3fd53, Offset: 0x10e8
// Size: 0x74
function magma_essence_explode_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    util::playfxontag(localclientnum, level._effect[#"hash_40c10e05964e71b5"], self, "tag_origin");
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 7, eflags: 0x0
// Checksum 0x80f16f2, Offset: 0x1168
// Size: 0x74
function magma_gat_disappear_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    util::playfxontag(localclientnum, level._effect[#"hash_d9adad5b2ead852"], self, "tag_origin");
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 7, eflags: 0x0
// Checksum 0xa3557f82, Offset: 0x11e8
// Size: 0x17c
function magma_gat_glow_override(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval == 1) {
        self playrenderoverridebundle(#"hash_4fb0136f51fcf7", "tag_weapon");
        self function_98a01e4c(#"hash_4fb0136f51fcf7", "Brightness", 0.7);
        self thread function_c8c8114d(localclientnum);
        self thread function_c479f842(localclientnum);
        return;
    }
    self notify(#"hash_4086299956cef09d");
    if (isdefined(self.var_8f740a21)) {
        self stoploopsound(self.var_8f740a21);
        self.var_8f740a21 = undefined;
    }
    self function_98a01e4c(#"hash_4fb0136f51fcf7", "Brightness", 0);
    self stoprenderoverridebundle(#"hash_4fb0136f51fcf7", "tag_weapon");
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 7, eflags: 0x0
// Checksum 0x8493fa04, Offset: 0x1370
// Size: 0x114
function magma_gat_glow_recharge(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (!isdefined(self.var_c5f33149)) {
        self.var_c5f33149 = 25;
    }
    if (self.var_c5f33149 + 25 > 25) {
        self.var_c5f33149 = 25;
    } else {
        self.var_c5f33149 += 25;
    }
    if (isdefined(self.var_933c7478)) {
        self.var_933c7478 = 0;
    }
    self thread function_21f13b8c(localclientnum);
    self playrumbleonentity(localclientnum, #"hash_41507a7755099d85");
    self stoprumble(localclientnum, #"hash_3c64ae4793e47b3a");
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 1, eflags: 0x4
// Checksum 0xef2eab09, Offset: 0x1490
// Size: 0x11a
function private function_21f13b8c(localclientnum) {
    self notify(#"hash_67dbde4a0231b582");
    self endon(#"disconnect", #"hash_4086299956cef09d", #"hash_67dbde4a0231b582");
    if (isdefined(self.var_8f740a21)) {
        self stoploopsound(self.var_8f740a21);
        self.var_8f740a21 = undefined;
    }
    if (!isdefined(self.var_49bc8869)) {
        self.var_49bc8869 = self playloopsound(#"hash_6d1e9399310efe71");
    }
    wait 2;
    if (isdefined(self.var_49bc8869)) {
        self stoploopsound(self.var_49bc8869);
        self.var_49bc8869 = undefined;
    }
    self.var_8f740a21 = self playloopsound(#"hash_1bc434008189933f");
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 1, eflags: 0x4
// Checksum 0x1db688cd, Offset: 0x15b8
// Size: 0x2ac
function private function_c8c8114d(localclientnum) {
    self endon(#"disconnect", #"hash_4086299956cef09d");
    self.var_c5f33149 = 25;
    self.var_8f740a21 = self playloopsound(#"hash_1bc434008189933f");
    self.var_933c7478 = 0;
    self.var_c67d8009 = gettime();
    while (isdefined(self) && self.var_c5f33149 > 0) {
        n_current_time = gettime();
        var_a363d411 = (n_current_time - self.var_c67d8009) / 1000;
        self.var_c67d8009 = n_current_time;
        if (self.var_933c7478) {
            self function_98a01e4c(#"hash_4fb0136f51fcf7", "Brightness", 0.016);
            self playrumbleonentity(localclientnum, #"hash_3c64ae4793e47b3a");
            self stoprumble(localclientnum, #"hash_41507a7755099d85");
        } else {
            var_3a28b737 = math::linear_map(self.var_c5f33149, 0, 25, 0.15, 0.7);
            self function_98a01e4c(#"hash_4fb0136f51fcf7", "Brightness", var_3a28b737);
        }
        if (self.var_c5f33149 <= 5) {
            self.var_c5f33149 -= 0.5;
            if (self.var_933c7478) {
                self.var_933c7478 = 0;
            } else {
                self.var_933c7478 = 1;
            }
            wait 0.5;
            continue;
        }
        self.var_c5f33149 -= var_a363d411;
        waitframe(1);
    }
    if (isdefined(self.var_8f740a21)) {
        self stoploopsound(self.var_8f740a21);
        self.var_8f740a21 = undefined;
    }
    self function_98a01e4c(#"hash_4fb0136f51fcf7", "Brightness", 0);
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 1, eflags: 0x0
// Checksum 0x1d02e1f4, Offset: 0x1870
// Size: 0x192
function function_c479f842(localclientnum) {
    self endon(#"death", #"disconnect", #"hash_4086299956cef09d");
    if (!self util::function_162f7df2(localclientnum)) {
        return;
    }
    while (isdefined(self.var_c5f33149) && self.var_c5f33149 > 0) {
        if (isdefined(self.var_6c2ba6ff)) {
            stopfx(localclientnum, self.var_6c2ba6ff);
        }
        if (self zm_utility::function_a96d4c46(localclientnum)) {
            if (isdefined(self gettagorigin("tag_flash"))) {
                self.var_6c2ba6ff = playviewmodelfx(localclientnum, level._effect[#"hash_5d3b4b76ea5885f6"], "tag_flash");
            }
        }
        if (self.var_c5f33149 > 20) {
            wait 0.1;
            continue;
        }
        if (self.var_c5f33149 > 15) {
            wait 0.2;
            continue;
        }
        if (self.var_c5f33149 > 10) {
            wait 0.4;
            continue;
        }
        if (self.var_c5f33149 > 5) {
            wait 1;
            continue;
        }
        wait 2;
    }
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 7, eflags: 0x0
// Checksum 0x639350a3, Offset: 0x1a10
// Size: 0x76
function magma_gat_glow_shot_fired(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (isdefined(self.var_c5f33149)) {
        self.var_c5f33149 -= 6;
        if (self.var_c5f33149 < 0) {
            self.var_c5f33149 = 0;
        }
    }
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 7, eflags: 0x0
// Checksum 0x39abb363, Offset: 0x1a90
// Size: 0x176
function magma_forging_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval == 2) {
        if (isdefined(self.var_a604be76)) {
            stopfx(localclientnum, self.var_a604be76);
            self.var_a604be76 = undefined;
        }
        self.var_a604be76 = util::playfxontag(localclientnum, level._effect[#"hash_22aea05cb07dd55e"], self, "tag_origin");
        return;
    }
    if (newval == 1) {
        if (isdefined(self.var_a604be76)) {
            stopfx(localclientnum, self.var_a604be76);
            self.var_a604be76 = undefined;
        }
        self.var_a604be76 = util::playfxontag(localclientnum, level._effect[#"magma_fireplace"], self, "tag_origin");
        return;
    }
    if (isdefined(self.var_a604be76)) {
        stopfx(localclientnum, self.var_a604be76);
        self.var_a604be76 = undefined;
    }
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 7, eflags: 0x0
// Checksum 0x22c831b4, Offset: 0x1c10
// Size: 0x1c2
function magma_urn_fire_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (isdefined(self.var_9dedc739)) {
        stopfx(localclientnum, self.var_9dedc739);
        self.var_9dedc739 = undefined;
    }
    if (isdefined(self.var_6f383a3a)) {
        stopfx(localclientnum, self.var_6f383a3a);
        self.var_6f383a3a = undefined;
    }
    if (newval == 1) {
        self.var_9dedc739 = util::playfxontag(localclientnum, level._effect[#"magma_urn"], self, "tag_origin");
        self.var_6f383a3a = util::playfxontag(localclientnum, level._effect[#"hash_71cebe03a25b3339"], self, "tag_origin");
        return;
    }
    if (newval == 2) {
        self.var_9dedc739 = util::playfxontag(localclientnum, level._effect[#"hash_577c7197e639a24b"], self, "tag_origin");
        self.var_6f383a3a = util::playfxontag(localclientnum, level._effect[#"hash_28455b81d5e86c62"], self, "tag_origin");
    }
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 7, eflags: 0x0
// Checksum 0x6434ea9d, Offset: 0x1de0
// Size: 0xf6
function magma_urn_ember_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval == 1) {
        if (isdefined(self.var_6e4c78ba)) {
            stopfx(localclientnum, self.var_6e4c78ba);
            self.var_6e4c78ba = undefined;
        }
        self.var_6e4c78ba = util::playfxontag(localclientnum, level._effect[#"hash_35748cc8bb5f678b"], self, "tag_origin");
        return;
    }
    if (isdefined(self.var_6e4c78ba)) {
        stopfx(localclientnum, self.var_6e4c78ba);
        self.var_6e4c78ba = undefined;
    }
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 7, eflags: 0x0
// Checksum 0xb95b9496, Offset: 0x1ee0
// Size: 0xba
function function_3a027ca0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (isdefined(self.var_adc88e6a)) {
        stopfx(localclientnum, self.var_adc88e6a);
        self.var_adc88e6a = undefined;
    }
    if (newval == 1) {
        self.var_adc88e6a = util::playfxontag(localclientnum, level._effect[#"bg_quest_spawn"], self, "tag_origin");
    }
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 7, eflags: 0x0
// Checksum 0x6715cc04, Offset: 0x1fa8
// Size: 0x76
function function_5a5fb4d2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        self thread function_3432e813(localclientnum);
        return;
    }
    self notify(#"hash_4236253d10aeec5e");
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 1, eflags: 0x0
// Checksum 0x61dbca65, Offset: 0x2028
// Size: 0xe8
function function_3432e813(localclientnum) {
    self endon(#"hash_4236253d10aeec5e");
    var_7578a666 = 1;
    self playrenderoverridebundle(#"hash_68ee9247aaae4517");
    self function_98a01e4c(#"hash_68ee9247aaae4517", "Alpha", 1);
    while (var_7578a666 >= 0 && isdefined(self)) {
        self function_98a01e4c(#"hash_68ee9247aaae4517", "Alpha", var_7578a666);
        var_7578a666 -= 0.1;
        wait 0.3;
    }
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 7, eflags: 0x0
// Checksum 0x6d0a801f, Offset: 0x2118
// Size: 0x74
function magma_urn_triggered_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    util::playfxontag(localclientnum, level._effect[#"hash_3932ab509a43ca38"], self, "tag_origin");
}

// Namespace namespace_3f0e5106/namespace_4b9249a2
// Params 7, eflags: 0x0
// Checksum 0xc1c6d5a, Offset: 0x2198
// Size: 0x74
function acid_gat_lock_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    util::playfxontag(localclientnum, level._effect[#"acid_gat_lock_fx"], self, "tag_origin");
}

