#using scripts\core_common\beam_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;

#namespace zodt8_boss;

// Namespace zodt8_boss/zm_zodt8_eye
// Params 0, eflags: 0x2
// Checksum 0x96e86595, Offset: 0x2f8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zodt8_boss", &__init__, undefined, undefined);
}

// Namespace zodt8_boss/zm_zodt8_eye
// Params 0, eflags: 0x0
// Checksum 0xcaa8e975, Offset: 0x340
// Size: 0x34
function __init__() {
    init_clientfields();
    init_flags();
    init_fx();
}

// Namespace zodt8_boss/zm_zodt8_eye
// Params 0, eflags: 0x0
// Checksum 0x453d9fa6, Offset: 0x380
// Size: 0x634
function init_clientfields() {
    clientfield::register("world", "engine_room_chillout_decals", 1, 1, "int", &function_b64219e4, 0, 0);
    clientfield::register("world", "state_rooms_chillout_decals", 1, 1, "int", &function_8fc2ed99, 0, 0);
    clientfield::register("world", "promenade_chillout_decals", 1, 1, "int", &function_bf040193, 0, 0);
    clientfield::register("world", "poop_deck_chillout_decals", 1, 1, "int", &function_71990d16, 0, 0);
    clientfield::register("scriptmover", "bs_bdy_fx_cf", 1, 2, "int", &function_f18f500e, 0, 0);
    clientfield::register("scriptmover", "bs_bdy_dmg_fx_cf", 1, 3, "int", &function_71970470, 0, 0);
    clientfield::register("scriptmover", "bs_dth_fx_cf", 1, 1, "counter", &function_d756219a, 0, 0);
    clientfield::register("scriptmover", "bs_spn_fx_cf", 1, 1, "int", &function_704c9a5f, 0, 0);
    clientfield::register("scriptmover", "bs_att_mst_tell_cf", 1, 1, "int", &function_7f1f2fb8, 0, 0);
    clientfield::register("scriptmover", "bs_att_mst_cf", 1, 1, "int", &function_34c02c6c, 0, 0);
    clientfield::register("scriptmover", "bs_att_bm_targ_ini_cf", 1, 1, "int", &function_4ad54c2, 0, 0);
    clientfield::register("scriptmover", "bs_att_bm_tell_cf", 1, 2, "int", &function_b4f6af2d, 0, 0);
    clientfield::register("scriptmover", "bs_att_bm_tell_fx_cf", 1, 1, "int", &function_55e015a, 0, 0);
    clientfield::register("scriptmover", "bs_att_bm_cf", 1, 1, "int", &function_df4d8cb9, 0, 0);
    clientfield::register("allplayers", "bs_att_bm_targ_hit_cf", 1, 1, "int", &function_2f2ae641, 0, 0);
    clientfield::register("toplayer", "bs_att_bm_targ_frz_fx_cf", 1, 1, "int", &function_7e59556a, 0, 0);
    clientfield::register("scriptmover", "bs_att_blst_tll", 1, 1, "int", &function_d0d0d551, 0, 0);
    clientfield::register("scriptmover", "bs_att_blst", 1, 1, "int", &function_45d2fdb7, 0, 0);
    clientfield::register("world", "in_engine_room", 1, 1, "int", &function_55a07bed, 0, 0);
    clientfield::register("world", "bs_gr_fog_fx_cf", 1, 1, "int", &function_69597075, 0, 0);
    clientfield::register("allplayers", "bs_player_ice_br_cf", 1, 1, "int", &function_a7386c4c, 0, 0);
    clientfield::register("allplayers", "bs_player_snow_cf", 1, 3, "int", &boss_player_snow_fx, 0, 0);
}

// Namespace zodt8_boss/zm_zodt8_eye
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x9c0
// Size: 0x4
function init_flags() {
    
}

// Namespace zodt8_boss/zm_zodt8_eye
// Params 0, eflags: 0x0
// Checksum 0xa5583f07, Offset: 0x9d0
// Size: 0x782
function init_fx() {
    level._effect[#"hash_3a7e3c711927a7c3"] = #"hash_79ffa4a673f5793b";
    level._effect[#"hash_4ae2fe21468d6415"] = #"hash_1c763e2ab2eae2d";
    level._effect[#"hash_3a7e3d711927a976"] = #"hash_79ffa5a673f57aee";
    level._effect[#"hash_3a7e3e711927ab29"] = #"hash_79ffa6a673f57ca1";
    level._effect[#"hash_18e0765b35d687e2"] = #"hash_4958a07a69145faa";
    level._effect[#"hash_18e0755b35d6862f"] = #"hash_49589f7a69145df7";
    level._effect[#"hash_18e0745b35d6847c"] = #"hash_49589e7a69145c44";
    level._effect[#"hash_22e302a3a629b9c5"] = #"hash_547e19d7efb5111d";
    level._effect[#"hash_22e2ffa3a629b4ac"] = #"hash_547e16d7efb50c04";
    level._effect[#"hash_5da2f8ba463838a7"] = #"hash_33d1bbba600a3baf";
    level._effect[#"hash_578d16a371861bf8"] = #"hash_51099a252cae240";
    level._effect[#"hash_5c6beca89bab7a09"] = #"hash_5bb2efa9ee678bb1";
    level._effect[#"hash_5d9fc9ba4635b2f3"] = #"hash_33ceccba600822bb";
    level._effect[#"hash_579039a371888d48"] = #"hash_513bca252cd5390";
    level._effect[#"hash_5c68c9a89ba908b9"] = #"hash_5bb00ca9ee658721";
    level._effect[#"hash_2605326ae3fedb78"] = #"hash_366330d81a1a6280";
    level._effect[#"hash_762024bd90ae81"] = #"hash_d289f9bdde6a4d9";
    level._effect[#"hash_43b082a97f3b9f23"] = #"hash_22f75cff6fc8279b";
    level._effect[#"hash_761d24bd90a968"] = #"hash_d289c9bdde69fc0";
    level._effect[#"hash_761e24bd90ab1b"] = #"hash_d289d9bdde6a173";
    level._effect[#"hash_4d839450cbef5d84"] = #"hash_2995f7f9d859901c";
    level._effect[#"hash_79943a1b52eab058"] = #"hash_4fdb4d96df507bb0";
    level._effect[#"hash_4d839750cbef629d"] = #"hash_2995faf9d8599535";
    level._effect[#"hash_4d839650cbef60ea"] = #"hash_2995f9f9d8599382";
    level._effect[#"hash_2568e622a63ee946"] = #"hash_76f4fd1c816279e";
    level._effect[#"hash_5c21a90a3a13ab3a"] = #"hash_14a03ad75e4665f2";
    level._effect[#"hash_2568e522a63ee793"] = #"hash_76f4ed1c81625eb";
    level._effect[#"hash_2568e422a63ee5e0"] = #"hash_76f4dd1c8162438";
    level._effect[#"hash_d64a32797383a44"] = #"hash_90d6010d0fb8a5c";
    level._effect[#"hash_461d8a431091f4f9"] = #"hash_2defa2a48c3074b1";
    level._effect[#"hash_2986daf3734aff57"] = #"hash_408a34d7969cd8ef";
    level._effect[#"hash_1ac926b170f08ed4"] = #"hash_5518be03ef1238bc";
    level._effect[#"hash_14c7ae107e96344f"] = #"hash_35345b470c26af97";
    level._effect[#"hash_7f40415d2fd7eca7"] = #"hash_140d0b129306d6bf";
    level._effect[#"hash_139a09a4b1249370"] = #"hash_7881fc0381feec68";
    level._effect[#"hash_76da38284b0c73ed"] = #"hash_153286962fe0c0c5";
    level._effect[#"hash_76e124284b12709f"] = #"hash_153992962fe6f3d7";
    level._effect[#"hash_6788a08fe46cb4c4"] = #"hash_6bb32223711e216c";
    level._effect[#"hash_2b51d1fecfaa7ae6"] = #"hash_682ef6e33412958e";
    level._effect[#"hash_3a6842a4656de818"] = #"hash_2b2be81e66f5e3ea";
}

// Namespace zodt8_boss/zm_zodt8_eye
// Params 7, eflags: 0x0
// Checksum 0x50660bfb, Offset: 0x1160
// Size: 0x168
function function_b64219e4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(level.var_aca42d8e)) {
        level.var_aca42d8e = findvolumedecalindexarray("engine_room_chillout_decals");
    }
    if (newval) {
        foreach (n_index in level.var_aca42d8e) {
            hidevolumedecal(n_index);
        }
        return;
    }
    foreach (n_index in level.var_aca42d8e) {
        unhidevolumedecal(n_index);
    }
}

// Namespace zodt8_boss/zm_zodt8_eye
// Params 7, eflags: 0x0
// Checksum 0xb33ff946, Offset: 0x12d0
// Size: 0x168
function function_8fc2ed99(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(level.var_c47916cb)) {
        level.var_c47916cb = findvolumedecalindexarray("state_rooms_chillout_decals");
    }
    if (newval) {
        foreach (n_index in level.var_c47916cb) {
            hidevolumedecal(n_index);
        }
        return;
    }
    foreach (n_index in level.var_c47916cb) {
        unhidevolumedecal(n_index);
    }
}

// Namespace zodt8_boss/zm_zodt8_eye
// Params 7, eflags: 0x0
// Checksum 0x267b354a, Offset: 0x1440
// Size: 0x168
function function_bf040193(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(level.var_4056c7c9)) {
        level.var_4056c7c9 = findvolumedecalindexarray("promenade_chillout_decals");
    }
    if (newval) {
        foreach (n_index in level.var_4056c7c9) {
            hidevolumedecal(n_index);
        }
        return;
    }
    foreach (n_index in level.var_4056c7c9) {
        unhidevolumedecal(n_index);
    }
}

// Namespace zodt8_boss/zm_zodt8_eye
// Params 7, eflags: 0x0
// Checksum 0xccad912a, Offset: 0x15b0
// Size: 0x168
function function_71990d16(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(level.var_7515cda4)) {
        level.var_7515cda4 = findvolumedecalindexarray("poop_deck_chillout_decals");
    }
    if (newval) {
        foreach (n_index in level.var_7515cda4) {
            hidevolumedecal(n_index);
        }
        return;
    }
    foreach (n_index in level.var_7515cda4) {
        unhidevolumedecal(n_index);
    }
}

// Namespace zodt8_boss/zm_zodt8_eye
// Params 7, eflags: 0x0
// Checksum 0x5f2ddb05, Offset: 0x1720
// Size: 0x41c
function function_f18f500e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(self.var_f219b375)) {
        stopfx(localclientnum, self.var_f219b375);
        self.var_f219b375 = undefined;
    }
    if (isdefined(self.var_a784effb)) {
        stopfx(localclientnum, self.var_a784effb);
        self.var_a784effb = undefined;
    }
    self stoprenderoverridebundle(#"hash_131484bd233d42ed");
    self stoprenderoverridebundle(#"hash_5eea61b7a4fc591f");
    if (newval != 2) {
        if (isdefined(level.var_d4436f8c) && level.var_d4436f8c) {
            self.var_a784effb = util::playfxontag(localclientnum, level._effect[#"hash_4ae2fe21468d6415"], self, "tag_origin");
        } else if (self.model == #"hash_5cb4b96f5c4d8f49" || self.model == #"hash_6df0aeb5fab34528") {
            self.var_a784effb = util::playfxontag(localclientnum, level._effect[#"hash_3a7e3d711927a976"], self, "tag_origin");
        } else if (self.model == #"hash_5cb4b86f5c4d8d96" || self.model == #"hash_6df0afb5fab346db") {
            self.var_a784effb = util::playfxontag(localclientnum, level._effect[#"hash_3a7e3e711927ab29"], self, "tag_origin");
        } else {
            self.var_a784effb = util::playfxontag(localclientnum, level._effect[#"hash_3a7e3c711927a7c3"], self, "tag_origin");
        }
        if (newval == 0) {
            self.var_589ff747 = 1;
            self playrenderoverridebundle(#"hash_131484bd233d42ed");
            if (self.model == #"hash_5cb4b96f5c4d8f49" || self.model == #"hash_6df0aeb5fab34528") {
                self.var_f219b375 = util::playfxontag(localclientnum, level._effect[#"hash_18e0755b35d6862f"], self, "tag_origin");
            } else if (self.model == #"hash_5cb4b86f5c4d8d96" || self.model == #"hash_6df0afb5fab346db") {
                self.var_f219b375 = util::playfxontag(localclientnum, level._effect[#"hash_18e0745b35d6847c"], self, "tag_origin");
            } else {
                self.var_f219b375 = util::playfxontag(localclientnum, level._effect[#"hash_18e0765b35d687e2"], self, "tag_origin");
            }
            return;
        }
        self.var_589ff747 = 0;
        self playrenderoverridebundle(#"hash_5eea61b7a4fc591f");
    }
}

// Namespace zodt8_boss/zm_zodt8_eye
// Params 7, eflags: 0x0
// Checksum 0xee1669a1, Offset: 0x1b48
// Size: 0x48c
function function_71970470(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(self.var_588339ff)) {
        stopfx(localclientnum, self.var_588339ff);
        self.var_588339ff = undefined;
    }
    if (newval == 1) {
        if (self.model == #"hash_5cb4b96f5c4d8f49" || self.model == #"hash_6df0aeb5fab34528") {
            self.var_588339ff = util::playfxontag(localclientnum, level._effect[#"hash_5da2f8ba463838a7"], self, "tag_origin");
        } else if (self.model == #"hash_5cb4b86f5c4d8d96" || self.model == #"hash_6df0afb5fab346db") {
            self.var_588339ff = util::playfxontag(localclientnum, level._effect[#"hash_5d9fc9ba4635b2f3"], self, "tag_origin");
        } else {
            self.var_588339ff = util::playfxontag(localclientnum, level._effect[#"hash_22e302a3a629b9c5"], self, "tag_origin");
        }
    } else if (newval == 2) {
        if (self.model == #"hash_5cb4b96f5c4d8f49" || self.model == #"hash_6df0aeb5fab34528") {
            self.var_588339ff = util::playfxontag(localclientnum, level._effect[#"hash_5c6beca89bab7a09"], self, "tag_origin");
        } else if (self.model == #"hash_5cb4b86f5c4d8d96" || self.model == #"hash_6df0afb5fab346db") {
            self.var_588339ff = util::playfxontag(localclientnum, level._effect[#"hash_579039a371888d48"], self, "tag_origin");
        } else {
            self.var_588339ff = util::playfxontag(localclientnum, level._effect[#"hash_22e2ffa3a629b4ac"], self, "tag_origin");
        }
    } else if (newval == 3) {
        if (self.model == #"hash_5cb4b96f5c4d8f49" || self.model == #"hash_6df0aeb5fab34528") {
            self.var_588339ff = util::playfxontag(localclientnum, level._effect[#"hash_5c6beca89bab7a09"], self, "tag_origin");
        } else if (self.model == #"hash_5cb4b86f5c4d8d96" || self.model == #"hash_6df0afb5fab346db") {
            self.var_588339ff = util::playfxontag(localclientnum, level._effect[#"hash_5c68c9a89ba908b9"], self, "tag_origin");
        }
    }
    if (isdefined(self.var_589ff747) && self.var_589ff747) {
        self stoprenderoverridebundle(#"hash_5eea61b7a4fc591f");
        self playrenderoverridebundle(#"hash_131484bd233d42ed");
        return;
    }
    self stoprenderoverridebundle(#"hash_131484bd233d42ed");
    self playrenderoverridebundle(#"hash_5eea61b7a4fc591f");
}

// Namespace zodt8_boss/zm_zodt8_eye
// Params 7, eflags: 0x0
// Checksum 0xee52eec8, Offset: 0x1fe0
// Size: 0x49a
function function_704c9a5f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (isdefined(self.var_42456660)) {
            stopfx(localclientnum, self.var_42456660);
            self.var_42456660 = undefined;
        }
        if (isdefined(level.var_d4436f8c) && level.var_d4436f8c) {
            self.var_42456660 = playfx(localclientnum, level._effect[#"hash_43b082a97f3b9f23"], self.origin, anglestoforward(self.angles));
        } else if (self.model == #"hash_5cb4b96f5c4d8f49" || self.model == #"hash_6df0aeb5fab34528") {
            self.var_42456660 = playfx(localclientnum, level._effect[#"hash_761d24bd90a968"], self.origin, anglestoforward(self.angles));
        } else if (self.model == #"hash_5cb4b86f5c4d8d96" || self.model == #"hash_6df0afb5fab346db") {
            self.var_42456660 = playfx(localclientnum, level._effect[#"hash_761e24bd90ab1b"], self.origin, anglestoforward(self.angles));
        } else {
            self.var_42456660 = playfx(localclientnum, level._effect[#"hash_762024bd90ae81"], self.origin, anglestoforward(self.angles));
        }
        return;
    }
    if (isdefined(self.var_7d4d5775)) {
        stopfx(localclientnum, self.var_7d4d5775);
        self.var_7d4d5775 = undefined;
    }
    if (isdefined(level.var_d4436f8c) && level.var_d4436f8c) {
        self.var_7d4d5775 = playfx(localclientnum, level._effect[#"hash_79943a1b52eab058"], self.origin, anglestoforward(self.angles));
        return;
    }
    if (self.model == #"hash_5cb4b96f5c4d8f49" || self.model == #"hash_6df0aeb5fab34528") {
        self.var_7d4d5775 = playfx(localclientnum, level._effect[#"hash_4d839750cbef629d"], self.origin, anglestoforward(self.angles));
        return;
    }
    if (self.model == #"hash_5cb4b86f5c4d8d96" || self.model == #"hash_6df0afb5fab346db") {
        self.var_7d4d5775 = playfx(localclientnum, level._effect[#"hash_4d839650cbef60ea"], self.origin, anglestoforward(self.angles));
        return;
    }
    self.var_7d4d5775 = playfx(localclientnum, level._effect[#"hash_4d839450cbef5d84"], self.origin, anglestoforward(self.angles));
}

// Namespace zodt8_boss/zm_zodt8_eye
// Params 7, eflags: 0x0
// Checksum 0x9e2c298f, Offset: 0x2488
// Size: 0x74
function function_d756219a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playfx(localclientnum, level._effect[#"hash_2605326ae3fedb78"], self.origin);
}

// Namespace zodt8_boss/zm_zodt8_eye
// Params 7, eflags: 0x0
// Checksum 0x1eb90fd2, Offset: 0x2508
// Size: 0x1de
function function_7f1f2fb8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (isdefined(level.var_d4436f8c) && level.var_d4436f8c) {
            self.var_ce5c4eb8 = util::playfxontag(localclientnum, level._effect[#"hash_5c21a90a3a13ab3a"], self, "tag_origin");
        } else if (self.model == #"hash_5cb4b96f5c4d8f49") {
            self.var_ce5c4eb8 = util::playfxontag(localclientnum, level._effect[#"hash_2568e522a63ee793"], self, "tag_origin");
        } else if (self.model == #"hash_5cb4b86f5c4d8d96") {
            self.var_ce5c4eb8 = util::playfxontag(localclientnum, level._effect[#"hash_2568e422a63ee5e0"], self, "tag_origin");
        } else {
            self.var_ce5c4eb8 = util::playfxontag(localclientnum, level._effect[#"hash_2568e622a63ee946"], self, "tag_origin");
        }
        return;
    }
    if (isdefined(self.var_ce5c4eb8)) {
        stopfx(localclientnum, self.var_ce5c4eb8);
        self.var_ce5c4eb8 = undefined;
    }
}

// Namespace zodt8_boss/zm_zodt8_eye
// Params 7, eflags: 0x0
// Checksum 0x107953f1, Offset: 0x26f0
// Size: 0x192
function function_34c02c6c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (isdefined(self.var_d0fd7372)) {
            stopfx(localclientnum, self.var_d0fd7372);
            self.var_d0fd7372 = undefined;
        }
        self thread function_f8d1a1a7(localclientnum);
        self.var_4cfcde0a = self playloopsound(#"hash_791cd998c9d4782b");
        return;
    }
    self stoploopsound(self.var_4cfcde0a);
    level notify(#"hash_d9ea00876d52b3d");
    if (isdefined(self.var_cab2a98d)) {
        stopfx(localclientnum, self.var_cab2a98d);
        self.var_cab2a98d = undefined;
    }
    if (isdefined(self.var_57ba16c)) {
        stopfx(localclientnum, self.var_57ba16c);
        self.var_57ba16c = undefined;
    }
    self.var_d0fd7372 = util::playfxontag(localclientnum, level._effect[#"hash_2986daf3734aff57"], self, self.origin);
}

// Namespace zodt8_boss/zm_zodt8_eye
// Params 1, eflags: 0x0
// Checksum 0x2f7a84df, Offset: 0x2890
// Size: 0xf2
function function_f8d1a1a7(localclientnum) {
    level endon(#"hash_d9ea00876d52b3d");
    self endon(#"death");
    self.var_cab2a98d = util::playfxontag(localclientnum, level._effect[#"hash_d64a32797383a44"], self, self.origin);
    wait 1;
    if (isdefined(self.var_cab2a98d)) {
        stopfx(localclientnum, self.var_cab2a98d);
        self.var_cab2a98d = undefined;
    }
    self.var_57ba16c = util::playfxontag(localclientnum, level._effect[#"hash_461d8a431091f4f9"], self, self.origin);
}

// Namespace zodt8_boss/zm_zodt8_eye
// Params 7, eflags: 0x0
// Checksum 0xb77c86c0, Offset: 0x2990
// Size: 0x5a
function function_4ad54c2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(level.var_362dc2f0)) {
        level.var_362dc2f0 = self;
    }
}

// Namespace zodt8_boss/zm_zodt8_eye
// Params 7, eflags: 0x0
// Checksum 0x81c0db01, Offset: 0x29f8
// Size: 0x74
function function_df4d8cb9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_a4152e5b(localclientnum);
    if (newval) {
        self thread function_9eb99ef1(localclientnum);
    }
}

// Namespace zodt8_boss/zm_zodt8_eye
// Params 7, eflags: 0x0
// Checksum 0x8e99b184, Offset: 0x2a78
// Size: 0xbe
function function_55e015a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_549b205a = util::playfxontag(localclientnum, level._effect[#"hash_1ac926b170f08ed4"], self, self.origin);
        return;
    }
    if (isdefined(self.var_549b205a)) {
        stopfx(localclientnum, self.var_549b205a);
        self.var_549b205a = undefined;
    }
}

// Namespace zodt8_boss/zm_zodt8_eye
// Params 1, eflags: 0x0
// Checksum 0xcc3d98a7, Offset: 0x2b40
// Size: 0x17e
function function_a4152e5b(localclientnum) {
    self notify(#"hash_2bb8be6b846aed93");
    if (isdefined(self.var_9609eab0)) {
        level beam::kill(self.var_9609eab0, "tag_origin", level.var_362dc2f0, "tag_origin", "beam8_zm_boss_eye_attack");
        level beam::kill(self.var_9609eab0, "tag_origin", level.var_362dc2f0, "tag_origin", "beam8_zm_boss_eye_attack_tell_a");
        level beam::kill(self.var_9609eab0, "tag_origin", level.var_362dc2f0, "tag_origin", "beam8_zm_boss_eye_attack_tell_b");
        var_fdd01dca = spawn(localclientnum, self.origin, "script_origin");
        var_fdd01dca playsound(localclientnum, #"hash_15ca81cba1081bc2");
        var_fdd01dca thread function_42db99be();
        self.var_9609eab0 delete();
        self.var_9609eab0 = undefined;
    }
}

// Namespace zodt8_boss/zm_zodt8_eye
// Params 0, eflags: 0x0
// Checksum 0xa28e0e19, Offset: 0x2cc8
// Size: 0x1c
function function_42db99be() {
    wait 3;
    self delete();
}

// Namespace zodt8_boss/zm_zodt8_eye
// Params 7, eflags: 0x0
// Checksum 0x103c6e3f, Offset: 0x2cf0
// Size: 0x88
function function_b4f6af2d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        level notify(#"hash_557a122dcb347759");
        return;
    }
    if (newval == 2) {
        level notify(#"hash_47a81f08f1d6531a");
    }
}

// Namespace zodt8_boss/zm_zodt8_eye
// Params 1, eflags: 0x0
// Checksum 0xb3d9d3a1, Offset: 0x2d80
// Size: 0x264
function function_9eb99ef1(localclientnum) {
    self notify(#"hash_2bb8be6b846aed93");
    self endon(#"hash_2bb8be6b846aed93");
    assert(isdefined(level.var_362dc2f0));
    if (!isdefined(self.var_9609eab0)) {
        self.var_9609eab0 = util::spawn_model(localclientnum, "tag_origin", self.origin);
    }
    self.var_9609eab0.origin = self.origin;
    self thread function_162e5c6d();
    level beam::function_31f5fd50(localclientnum, self.var_9609eab0, "tag_origin", level.var_362dc2f0, "tag_origin", "beam8_zm_boss_eye_attack_tell_a");
    level waittill(#"hash_557a122dcb347759");
    level beam::kill(self.var_9609eab0, "tag_origin", level.var_362dc2f0, "tag_origin", "beam8_zm_boss_eye_attack_tell_a");
    level beam::function_31f5fd50(localclientnum, self.var_9609eab0, "tag_origin", level.var_362dc2f0, "tag_origin", "beam8_zm_boss_eye_attack_tell_b");
    level waittill(#"hash_47a81f08f1d6531a");
    level beam::kill(self.var_9609eab0, "tag_origin", level.var_362dc2f0, "tag_origin", "beam8_zm_boss_eye_attack_tell_b");
    level beam::function_31f5fd50(localclientnum, self.var_9609eab0, "tag_origin", level.var_362dc2f0, "tag_origin", "beam8_zm_boss_eye_attack");
    self playsound(localclientnum, #"hash_65dbdd02d1dccf42");
    self thread function_7eaec68a(localclientnum);
}

// Namespace zodt8_boss/zm_zodt8_eye
// Params 0, eflags: 0x0
// Checksum 0xe2d1522a, Offset: 0x2ff0
// Size: 0x86
function function_162e5c6d() {
    self endon(#"hash_2bb8be6b846aed93");
    while (isdefined(self.var_9609eab0) && isdefined(level.var_362dc2f0)) {
        self.var_9609eab0 function_86e07bdc(level.var_362dc2f0);
        level.var_362dc2f0 function_86e07bdc(self.var_9609eab0);
        waitframe(1);
    }
}

// Namespace zodt8_boss/zm_zodt8_eye
// Params 1, eflags: 0x0
// Checksum 0xa38fa3f, Offset: 0x3080
// Size: 0x72
function function_86e07bdc(var_6a87069e) {
    if (!isdefined(self) || !isdefined(var_6a87069e)) {
        return;
    }
    v_target_position = var_6a87069e.origin;
    var_fa04bdf1 = vectortoangles(v_target_position - self.origin);
    self.angles = var_fa04bdf1;
}

// Namespace zodt8_boss/zm_zodt8_eye
// Params 1, eflags: 0x0
// Checksum 0x18c53e34, Offset: 0x3100
// Size: 0xe4
function function_7eaec68a(localclientnum) {
    self.var_8720bbdb = self.var_9609eab0 gettagorigin("tag_origin");
    self.var_2d31668f = level.var_362dc2f0 gettagorigin("tag_origin");
    if (!(isdefined(self.var_32bf7b20) && self.var_32bf7b20)) {
        self.var_32bf7b20 = 1;
        soundlineemitter(#"hash_3d5a33369bbe2308", self.var_8720bbdb, self.var_2d31668f);
        self thread function_80777501(localclientnum);
        self thread function_958faf7();
    }
}

// Namespace zodt8_boss/zm_zodt8_eye
// Params 0, eflags: 0x0
// Checksum 0x4196dfd3, Offset: 0x31f0
// Size: 0x150
function function_958faf7() {
    self endon(#"hash_2bb8be6b846aed93");
    level endon(#"intermission");
    while (true) {
        var_4c693dcb = level.var_362dc2f0 gettagorigin("tag_origin");
        if (var_4c693dcb[0] != self.var_2d31668f[0] || var_4c693dcb[1] != self.var_2d31668f[1] || var_4c693dcb[2] != self.var_2d31668f[2]) {
            var_a004a93d = self.var_8720bbdb;
            var_b3146569 = self.var_2d31668f;
            self.var_8720bbdb = self.var_9609eab0 gettagorigin("tag_origin");
            self.var_2d31668f = var_4c693dcb;
            soundupdatelineemitter(#"hash_3d5a33369bbe2308", var_a004a93d, var_b3146569, self.var_8720bbdb, self.var_2d31668f);
        }
        wait 0.1;
    }
}

// Namespace zodt8_boss/zm_zodt8_eye
// Params 1, eflags: 0x0
// Checksum 0xc3cfc582, Offset: 0x3348
// Size: 0x7e
function function_80777501(localclientnum) {
    level endon(#"intermission");
    self waittill(#"hash_2bb8be6b846aed93");
    soundstoplineemitter(#"hash_3d5a33369bbe2308", self.var_8720bbdb, self.var_2d31668f);
    if (isdefined(self)) {
        self.var_32bf7b20 = 0;
    }
}

// Namespace zodt8_boss/zm_zodt8_eye
// Params 7, eflags: 0x0
// Checksum 0xdb327214, Offset: 0x33d0
// Size: 0xd6
function function_2f2ae641(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (self zm_utility::function_a96d4c46(localclientnum)) {
            self.var_95b35b81 = self playloopsound(#"hash_10c1592e20803fc0");
        }
        return;
    }
    if (self zm_utility::function_a96d4c46(localclientnum) && isdefined(self.var_95b35b81)) {
        self stoploopsound(self.var_95b35b81);
        self.var_95b35b81 = undefined;
    }
}

// Namespace zodt8_boss/zm_zodt8_eye
// Params 7, eflags: 0x0
// Checksum 0xffa0870b, Offset: 0x34b0
// Size: 0x1c4
function function_7e59556a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self thread postfx::playpostfxbundle(#"hash_1c4bae784c38419");
        self function_202a8b08(#"hash_349a56ada2bc0bc8", "Reveal Threshold", 1);
        if (self zm_utility::function_a96d4c46(localclientnum)) {
            self playsound(localclientnum, #"hash_6448985393417e0c");
            self.var_89e92aeb = self playloopsound(#"hash_3c4934dafbb5efee");
        }
        return;
    }
    if (self zm_utility::function_a96d4c46(localclientnum)) {
        if (isdefined(self.var_89e92aeb)) {
            self stoploopsound(self.var_89e92aeb);
            self.var_89e92aeb = undefined;
        }
        self playsound(localclientnum, #"hash_286c32a151d527cf");
    }
    self function_202a8b08(#"hash_349a56ada2bc0bc8", "Reveal Threshold", 0);
    self thread postfx::exitpostfxbundle(#"hash_1c4bae784c38419");
}

// Namespace zodt8_boss/zm_zodt8_eye
// Params 7, eflags: 0x0
// Checksum 0x78cb1b9b, Offset: 0x3680
// Size: 0x136
function function_d0d0d551(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_8e08a251 = util::playfxontag(localclientnum, level._effect[#"hash_14c7ae107e96344f"], self, "tag_origin");
        self.var_e1a94207 = util::playfxontag(localclientnum, level._effect[#"hash_7f40415d2fd7eca7"], self, "tag_origin");
        return;
    }
    if (isdefined(self.var_8e08a251)) {
        stopfx(localclientnum, self.var_8e08a251);
        self.var_8e08a251 = undefined;
    }
    if (isdefined(self.var_e1a94207)) {
        stopfx(localclientnum, self.var_e1a94207);
        self.var_e1a94207 = undefined;
    }
}

// Namespace zodt8_boss/zm_zodt8_eye
// Params 7, eflags: 0x0
// Checksum 0x52fdba5d, Offset: 0x37c0
// Size: 0xbe
function function_45d2fdb7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_9081215e = util::playfxontag(localclientnum, level._effect[#"hash_139a09a4b1249370"], self, "tag_origin");
        return;
    }
    if (isdefined(self.var_9081215e)) {
        stopfx(localclientnum, self.var_9081215e);
        self.var_9081215e = undefined;
    }
}

// Namespace zodt8_boss/zm_zodt8_eye
// Params 7, eflags: 0x0
// Checksum 0x5572dfbe, Offset: 0x3888
// Size: 0x62
function function_55a07bed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level.var_d4436f8c = 1;
        return;
    }
    level.var_d4436f8c = 0;
}

// Namespace zodt8_boss/zm_zodt8_eye
// Params 7, eflags: 0x0
// Checksum 0xb9fc8656, Offset: 0x38f8
// Size: 0x7c
function function_69597075(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        setpbgactivebank(localclientnum, 8);
        return;
    }
    setpbgactivebank(localclientnum, 0);
}

// Namespace zodt8_boss/zm_zodt8_eye
// Params 7, eflags: 0x0
// Checksum 0xf61af222, Offset: 0x3980
// Size: 0x182
function function_a7386c4c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self notify(#"hash_7541447588c20db8");
    if (isdefined(self.var_d0764420) && self zm_utility::function_a96d4c46(localclientnum)) {
        deletefx(localclientnum, self.var_d0764420);
        self.var_d0764420 = undefined;
    }
    if (isdefined(self.var_cda51076) && self zm_utility::function_a96d4c46(localclientnum)) {
        deletefx(localclientnum, self.var_cda51076);
        self.var_cda51076 = undefined;
    }
    if (newval) {
        if (function_9a47ed7f(localclientnum)) {
            return;
        }
        if (self zm_utility::function_a96d4c46(localclientnum)) {
            self thread function_97788938(localclientnum);
            return;
        }
        self.var_cda51076 = util::playfxontag(localclientnum, level._effect[#"hash_76e124284b12709f"], self, "tag_head");
    }
}

// Namespace zodt8_boss/zm_zodt8_eye
// Params 1, eflags: 0x0
// Checksum 0x97fd2420, Offset: 0x3b10
// Size: 0xb8
function function_97788938(localclientnum) {
    self endon(#"hash_7541447588c20db8", #"death");
    while (true) {
        if (!isalive(self)) {
            break;
        }
        self.var_d0764420 = playfxoncamera(localclientnum, level._effect[#"hash_76da38284b0c73ed"], (0, 0, 0), (1, 0, 0), (0, 0, 1));
        wait randomfloatrange(0.9, 1.1);
    }
}

// Namespace zodt8_boss/zm_zodt8_eye
// Params 7, eflags: 0x0
// Checksum 0xcc56b9e8, Offset: 0x3bd0
// Size: 0x18c
function boss_player_snow_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self notify(#"boss_end_snow_fx");
    if (isdefined(self.boss_player_snow_fx) && self zm_utility::function_a96d4c46(localclientnum)) {
        deletefx(localclientnum, self.boss_player_snow_fx);
        self.boss_player_snow_fx = undefined;
    }
    if (newval) {
        if (function_9a47ed7f(localclientnum)) {
            return;
        }
        switch (newval) {
        case 1:
            str_type = #"hash_6788a08fe46cb4c4";
            break;
        case 2:
            str_type = #"hash_2b51d1fecfaa7ae6";
            break;
        case 3:
            str_type = #"hash_3a6842a4656de818";
            break;
        }
        if (self zm_utility::function_a96d4c46(localclientnum)) {
            self thread function_143d2095(localclientnum, str_type);
        }
    }
}

// Namespace zodt8_boss/zm_zodt8_eye
// Params 2, eflags: 0x0
// Checksum 0xe6282a7f, Offset: 0x3d68
// Size: 0xe0
function function_143d2095(localclientnum, str_type) {
    self endon(#"boss_end_snow_fx", #"death");
    while (true) {
        if (!isalive(self)) {
            break;
        }
        self.boss_player_snow_fx = playfxoncamera(localclientnum, level._effect[str_type], (0, 0, 0), anglestoforward(self.angles), anglestoup(self.angles));
        wait randomfloatrange(0.4, 0.7);
    }
}

