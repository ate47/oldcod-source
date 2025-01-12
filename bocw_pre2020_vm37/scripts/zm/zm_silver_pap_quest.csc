#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;

#namespace zm_silver_pap_quest;

// Namespace zm_silver_pap_quest/zm_silver_pap_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xde08c1b0, Offset: 0x110
// Size: 0x2c4
function init_clientfield() {
    clientfield::register("toplayer", "" + #"hash_5cf186464ce9cdd6", 1, 1, "int", &function_33082eb4, 0, 0);
    clientfield::register("toplayer", "" + #"hash_63af42145e260fb5", 1, 2, "int", &function_4fd00e1f, 0, 0);
    clientfield::register("toplayer", "" + #"hash_1fa45e1c3652d753", 1, 1, "int", &function_6902ffa4, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_6cfa6a77c2e81774", 1, 1, "int", &function_6871664e, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_7ec80a02e9bb051a", 1, 1, "int", &function_760c94c, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_5a293ad1c677dc7e", 1, 1, "int", &function_2424f2ac, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_7919b736a767a0f5", 1, 1, "int", &function_e5ffabef, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_54d221181b1a11f", 1, 1, "int", &function_840cc260, 0, 0);
}

// Namespace zm_silver_pap_quest/zm_silver_pap_quest
// Params 7, eflags: 0x1 linked
// Checksum 0xbb1a483, Offset: 0x3e0
// Size: 0x74
function function_840cc260(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 1) {
        playfx(fieldname, #"hash_6722451e58f7f20b", self.origin);
    }
}

// Namespace zm_silver_pap_quest/zm_silver_pap_quest
// Params 7, eflags: 0x1 linked
// Checksum 0x72c47bad, Offset: 0x460
// Size: 0x94
function function_6902ffa4(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 1) {
        earthquake(fieldname, 0.2, 2, self.origin, 100);
        self playrumbleonentity(fieldname, "damage_light");
    }
}

// Namespace zm_silver_pap_quest/zm_silver_pap_quest
// Params 7, eflags: 0x1 linked
// Checksum 0xfd73d5c2, Offset: 0x500
// Size: 0xac
function function_e5ffabef(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 1) {
        self.var_46658967 = util::playfxontag(fieldname, #"hash_1e41146e1298a361", self, "tag_origin");
        return;
    }
    if (isdefined(self.var_46658967)) {
        stopfx(fieldname, self.var_46658967);
    }
}

// Namespace zm_silver_pap_quest/zm_silver_pap_quest
// Params 7, eflags: 0x1 linked
// Checksum 0x7f930b37, Offset: 0x5b8
// Size: 0x196
function function_33082eb4(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 1) {
        self postfx::playpostfxbundle(#"hash_7fbc9bc489aea188");
        self playsound(fieldname, #"hash_56a9d9da20064c3f");
        wait 7;
        setsoundcontext("dark_aether", "active");
        if (!isdefined(self.var_657d689b)) {
            self.var_657d689b = self playloopsound(#"hash_68e090d91dd5764f");
        }
        return;
    }
    self postfx::playpostfxbundle(#"hash_7fbc9bc489aea188");
    self playsound(fieldname, #"hash_56a9d9da20064c3f");
    wait 7;
    setsoundcontext("dark_aether", "inactive");
    if (isdefined(self.var_657d689b)) {
        self stoploopsound(self.var_657d689b);
        self.var_657d689b = undefined;
    }
}

// Namespace zm_silver_pap_quest/zm_silver_pap_quest
// Params 7, eflags: 0x1 linked
// Checksum 0xb48fd2a4, Offset: 0x758
// Size: 0x38c
function function_4fd00e1f(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 1) {
        self playsound(fieldname, #"hash_79a78504d4dbaf3f");
        if (self zm_utility::function_f8796df3(fieldname)) {
            if (viewmodelhastag(fieldname, "tag_flashlight") && !isdefined(self.flashlight_fx)) {
                self.flashlight_fx = playviewmodelfx(fieldname, #"hash_679d39e5fd4eae19", "tag_flashlight");
            } else if (viewmodelhastag(fieldname, "tag_camera") && !isdefined(self.flashlight_fx)) {
                self.flashlight_fx = playviewmodelfx(fieldname, #"hash_679d39e5fd4eae19", "tag_camera");
            }
        } else {
            self.flashlight_fx = util::playfxontag(fieldname, #"hash_64e79a7456f58dec", self, "tag_flashlight");
        }
        util::function_8eb5d4b0(3500, 0);
        return;
    }
    if (bwastimejump == 2) {
        self playsound(fieldname, #"hash_79a78504d4dbaf3f");
        if (self zm_utility::function_f8796df3(fieldname)) {
            if (viewmodelhastag(fieldname, "tag_flashlight") && !isdefined(self.flashlight_fx)) {
                self.flashlight_fx = playviewmodelfx(fieldname, #"hash_462352157053fa4a", "tag_flashlight");
            } else if (viewmodelhastag(fieldname, "tag_camera") && !isdefined(self.flashlight_fx)) {
                self.flashlight_fx = playviewmodelfx(fieldname, #"hash_462352157053fa4a", "tag_camera");
            }
        } else {
            self.flashlight_fx = util::playfxontag(fieldname, #"hash_64e79a7456f58dec", self, "tag_flashlight");
        }
        util::function_8eb5d4b0(3500, 0);
        return;
    }
    if (isdefined(self.flashlight_fx)) {
        self playsound(fieldname, #"hash_13715035b161a0c3");
        stopfx(fieldname, self.flashlight_fx);
        self.flashlight_fx = undefined;
        util::function_8eb5d4b0(3500, 2.5);
    }
}

// Namespace zm_silver_pap_quest/zm_silver_pap_quest
// Params 7, eflags: 0x1 linked
// Checksum 0xf8305b3d, Offset: 0xaf0
// Size: 0x6c
function function_6871664e(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 1) {
        self playrenderoverridebundle(#"hash_24cdaac09819f0e");
    }
}

// Namespace zm_silver_pap_quest/zm_silver_pap_quest
// Params 7, eflags: 0x1 linked
// Checksum 0xebec10af, Offset: 0xb68
// Size: 0x186
function function_760c94c(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 1) {
        util::playfxontag(fieldname, #"maps/zm_escape/fx8_pap_lightning_near", self, "tag_origin");
        self.portal_fx = util::playfxontag(fieldname, #"zombie/fx9_aether_tear_portal", self, "tag_origin");
        if (!isdefined(self.var_abc21e11)) {
            self playsound(fieldname, #"hash_4a04fd9edb696634");
            self.var_abc21e11 = self playloopsound(#"hash_61bfd6cc3f47194");
        }
        return;
    }
    stopfx(fieldname, self.portal_fx);
    if (isdefined(self.var_abc21e11)) {
        self playsound(fieldname, #"hash_257a16d125ce57ed");
        self stoploopsound(self.var_abc21e11);
        self.var_abc21e11 = undefined;
    }
}

// Namespace zm_silver_pap_quest/zm_silver_pap_quest
// Params 7, eflags: 0x1 linked
// Checksum 0xf81deb18, Offset: 0xcf8
// Size: 0x74
function function_2424f2ac(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 1) {
        util::playfxontag(fieldname, #"maps/zm_escape/fx8_pap_lightning_near", self, "tag_origin");
    }
}

