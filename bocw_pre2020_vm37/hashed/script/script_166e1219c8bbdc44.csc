#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;

#namespace namespace_b376a999;

// Namespace namespace_b376a999/namespace_b376a999
// Params 0, eflags: 0x6
// Checksum 0x731069f2, Offset: 0x478
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_36cdf1547e49b57a", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 0, eflags: 0x5 linked
// Checksum 0x4dd78cd8, Offset: 0x4c0
// Size: 0x584
function private function_70a657d8() {
    clientfield::register("missile", "" + #"hash_68195637521e3973", 1, 1, "int", &function_eba1c130, 0, 0);
    clientfield::register("allplayers", "" + #"hash_492f4817c4296ddf", 1, 1, "counter", &function_4df1985a, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_7e9eb1c31cf618f0", 1, 1, "int", &function_86ab58c7, 0, 0);
    clientfield::register("actor", "" + #"hash_2d55cfbf02091dd1", 1, 1, "int", &function_53f65b40, 0, 0);
    clientfield::register("actor", "" + #"hash_306339376ad218f0", 1, 1, "int", &function_d31198e7, 0, 0);
    clientfield::register("allplayers", "" + #"hash_392d4dd36fe37ce7", 1, 1, "counter", &function_ddb51446, 0, 0);
    clientfield::register("allplayers", "" + #"hash_7c865b5dcfbe46c0", 1, 1, "int", &function_20c975a8, 0, 0);
    clientfield::register("allplayers", "" + #"hash_40635c43f5d87929", 1, 3, "int", &function_f06d4b4, 0, 0);
    clientfield::register("actor", "" + #"hash_6dca42b5563953ef", 1, 1, "int", &function_6832bb19, 0, 0);
    clientfield::register("actor", "" + #"hash_2a7b72235f0b387e", 1, 1, "int", &function_6c72aae7, 0, 0);
    clientfield::register("actor", "" + #"hash_1709a7bbfac5e1e0", 1, 1, "int", &function_e807cd32, 0, 0);
    clientfield::register("actor", "" + #"hash_3a35110e6ccc5486", 1, 1, "int", &function_11695595, 0, 0);
    clientfield::register("actor", "" + #"hash_48257c0dba76b140", 1, 1, "int", &function_c5d4038a, 0, 0);
    clientfield::register("actor", "" + #"hash_97d03a2a0786ba6", 1, 2, "int", &function_cd07a2bb, 0, 0);
    clientfield::register("allplayers", "" + #"hash_3c92af57fde1f8f7", 1, 4, "int", &function_c72e22ff, 0, 0);
    clientfield::register("missile", "" + #"hash_685e6cfaf658518e", 1, 1, "int", &function_48f0fe69, 0, 0);
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 7, eflags: 0x1 linked
// Checksum 0xed3c7b49, Offset: 0xa50
// Size: 0x64
function function_eba1c130(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    util::playfxontag(bwastimejump, "zm_weapons/fx9_ww_ieu_plasma_tracer_b", self, "tag_origin");
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 7, eflags: 0x1 linked
// Checksum 0x548c9b54, Offset: 0xac0
// Size: 0x64
function function_4df1985a(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self playrumbleonentity(bwastimejump, #"hash_37176262d696964e");
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 7, eflags: 0x1 linked
// Checksum 0x8e12b8fc, Offset: 0xb30
// Size: 0xa4
function function_86ab58c7(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        self.damage_fx = util::playfxontag(fieldname, "zm_weapons/fx9_ww_ieu_impact_chunk_1p", self, "tag_origin");
        return;
    }
    if (isdefined(self.damage_fx)) {
        killfx(fieldname, self.damage_fx);
    }
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 7, eflags: 0x1 linked
// Checksum 0x26492159, Offset: 0xbe0
// Size: 0xc4
function function_53f65b40(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        if (isdefined(self.var_12b59dee)) {
            self function_f6e99a8d(self.var_12b59dee, "j_head");
            self.var_12b59dee = undefined;
        }
        self playrenderoverridebundle(#"hash_16d59f099e418f4f");
        return;
    }
    self stoprenderoverridebundle(#"hash_16d59f099e418f4f");
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 7, eflags: 0x1 linked
// Checksum 0x572b8be6, Offset: 0xcb0
// Size: 0x6c
function function_d31198e7(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        util::playfxontag(fieldname, "zm_weapons/fx9_ww_ieu_death", self, "J_Spine4");
    }
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 7, eflags: 0x1 linked
// Checksum 0x2c46a416, Offset: 0xd28
// Size: 0x64
function function_ddb51446(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self playrumbleonentity(bwastimejump, #"hash_6fed0a32376b64b2");
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 7, eflags: 0x1 linked
// Checksum 0xb56c58b, Offset: 0xd98
// Size: 0x14e
function function_f06d4b4(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        if (self zm_utility::function_f8796df3(fieldname)) {
            self thread function_f63c933e(fieldname, bwastimejump);
        } else {
            self thread function_7a17571a(fieldname, bwastimejump);
        }
        return;
    }
    if (self zm_utility::function_f8796df3(fieldname)) {
        self notify(#"hash_6c344a5f126eed34");
        if (isdefined(self.var_e4927fc7)) {
            killfx(fieldname, self.var_e4927fc7);
        }
        self.var_e4927fc7 = undefined;
        return;
    }
    self notify(#"hash_64ba35091b98a4a7");
    if (isdefined(self.var_8790ae67)) {
        killfx(fieldname, self.var_8790ae67);
    }
    self.var_8790ae67 = undefined;
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 2, eflags: 0x1 linked
// Checksum 0xd21a2e26, Offset: 0xef0
// Size: 0xf0
function function_f63c933e(localclientnum, newval) {
    self notify(#"hash_6c344a5f126eed34");
    self endon(#"death", #"hash_6c344a5f126eed34");
    while (isdefined(self) && viewmodelhastag(localclientnum, "tag_flash")) {
        self.var_e4927fc7 = playviewmodelfx(localclientnum, "zm_weapons/fx9_ww_ieu_muz_1p", "tag_flash");
        for (i = 1; i < newval; i++) {
            self.var_a3606f1e = playviewmodelfx(localclientnum, "zm_weapons/fx9_ww_ieu_muz_chunk_1p", "tag_flash");
        }
        wait 0.2;
    }
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 2, eflags: 0x1 linked
// Checksum 0x4501e35c, Offset: 0xfe8
// Size: 0xd0
function function_7a17571a(localclientnum, newval) {
    self notify(#"hash_64ba35091b98a4a7");
    self endon(#"death", #"hash_64ba35091b98a4a7");
    while (isdefined(self)) {
        self.var_8790ae67 = util::playfxontag(localclientnum, "zm_weapons/fx9_ww_ieu_muz_3p", self, "tag_flash");
        for (i = 1; i < newval; i++) {
            self.var_357dfad4 = util::playfxontag(localclientnum, "zm_weapons/fx9_ww_ieu_muz_chunk_3p", self, "tag_flash");
        }
        wait 0.2;
    }
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 7, eflags: 0x1 linked
// Checksum 0xcab337c4, Offset: 0x10c0
// Size: 0x9c
function function_20c975a8(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    var_fa5b0a8f = #"hash_432baacca32a077d";
    if (bwastimejump) {
        self playrumblelooponentity(fieldname, var_fa5b0a8f);
        return;
    }
    self stoprumble(fieldname, var_fa5b0a8f);
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 7, eflags: 0x1 linked
// Checksum 0xcd1185de, Offset: 0x1168
// Size: 0x114
function function_6832bb19(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (!(getdvarint(#"splitscreen_playercount", 1) > 2)) {
        self thread function_fb35f102(bwastimejump);
        self thread function_bf3da63d(bwastimejump);
    }
    self thread util::playfxontag(bwastimejump, #"hash_3da4857b4b1553dc", self, "J_SpineLower");
    if (!(getdvarint(#"splitscreen_playercount", 1) > 2)) {
        self function_23e3d541(bwastimejump);
    }
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 7, eflags: 0x1 linked
// Checksum 0x6f566c5, Offset: 0x1288
// Size: 0x14c
function function_6c72aae7(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (!(getdvarint(#"splitscreen_playercount", 1) > 2)) {
        self thread function_fb35f102(bwastimejump);
        self thread function_bf3da63d(bwastimejump);
    }
    self thread util::playfxontag(bwastimejump, #"hash_6910f1de979f539f", self, "J_SpineLower");
    self playrumbleonentity(bwastimejump, "ieu_cryo_shatter_rumble");
    if (!(getdvarint(#"splitscreen_playercount", 1) > 2)) {
        self function_33af39da(bwastimejump);
        return;
    }
    self hide();
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 7, eflags: 0x1 linked
// Checksum 0x238d3598, Offset: 0x13e0
// Size: 0x74
function function_e807cd32(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        self thread function_7dce2661(fieldname);
        return;
    }
    self thread function_bf3da63d(fieldname);
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 1, eflags: 0x1 linked
// Checksum 0x5ac5b5d7, Offset: 0x1460
// Size: 0x20c
function function_7dce2661(localclientnum) {
    if (!isdefined(self.var_228aab91)) {
        self.var_228aab91 = [];
    }
    if (isdefined(self.var_228aab91[localclientnum])) {
        return;
    }
    self.var_228aab91[localclientnum] = [];
    function_cc7d3ff(localclientnum, #"hash_50599e96f376b4fa", "torso", "j_spinelower");
    if (!self gibclientutils::isgibbed(localclientnum, self, 8)) {
        function_cc7d3ff(localclientnum, #"hash_7af6b9564f0fbeca", "chin", "j_head");
    }
    if (!self gibclientutils::isgibbed(localclientnum, self, 16)) {
        function_cc7d3ff(localclientnum, #"hash_58c964b815e4f69e", "right_arm", "j_elbow_ri");
    }
    if (!self gibclientutils::isgibbed(localclientnum, self, 32)) {
        function_cc7d3ff(localclientnum, #"hash_58c96eb815e5079c", "left_arm", "j_elbow_le");
    }
    if (!self gibclientutils::isgibbed(localclientnum, self, 128)) {
        function_cc7d3ff(localclientnum, #"hash_432cd0cd340f2644", "right_leg", "j_knee_ri");
    }
    if (!self gibclientutils::isgibbed(localclientnum, self, 256)) {
        function_cc7d3ff(localclientnum, #"hash_434ed0cd342c0caa", "left_leg", "j_knee_le");
    }
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 4, eflags: 0x1 linked
// Checksum 0x9ef6dd54, Offset: 0x1678
// Size: 0x4a
function function_cc7d3ff(localclientnum, fx, key, tag) {
    self.var_228aab91[localclientnum][key] = util::playfxontag(localclientnum, fx, self, tag);
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 1, eflags: 0x1 linked
// Checksum 0xff8b4a5d, Offset: 0x16d0
// Size: 0xb4
function function_bf3da63d(localclientnum) {
    self endon(#"death");
    if (isdefined(self.var_228aab91) && isdefined(self.var_228aab91[localclientnum])) {
        keys = getarraykeys(self.var_228aab91[localclientnum]);
        for (i = 0; i < keys.size; i++) {
            function_c587b012(localclientnum, keys[i]);
        }
        self.var_228aab91[localclientnum] = undefined;
    }
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 2, eflags: 0x1 linked
// Checksum 0x886747c2, Offset: 0x1790
// Size: 0x3c
function function_c587b012(localclientnum, key) {
    deletefx(localclientnum, self.var_228aab91[localclientnum][key]);
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 7, eflags: 0x1 linked
// Checksum 0x75766035, Offset: 0x17d8
// Size: 0x74
function function_11695595(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        self thread function_2eaa501a(fieldname);
        return;
    }
    self thread function_fb35f102(fieldname);
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 1, eflags: 0x1 linked
// Checksum 0x4ad8612f, Offset: 0x1858
// Size: 0x17c
function function_2eaa501a(localclientnum) {
    if (!isdefined(self.var_36d7ee48)) {
        self.var_36d7ee48 = [];
    }
    if (isdefined(self.var_36d7ee48[localclientnum])) {
        return;
    }
    self.var_36d7ee48[localclientnum] = [];
    var_18e19c80 = #"hash_7bd6bc3aea3ff42f";
    if (!self gibclientutils::isgibbed(localclientnum, self, 16)) {
        function_e2c3df2f(localclientnum, var_18e19c80, "right_arm", "j_elbow_ri");
    }
    if (!self gibclientutils::isgibbed(localclientnum, self, 32)) {
        function_e2c3df2f(localclientnum, var_18e19c80, "left_arm", "j_elbow_le");
    }
    if (!self gibclientutils::isgibbed(localclientnum, self, 128)) {
        function_e2c3df2f(localclientnum, var_18e19c80, "right_leg", "j_knee_ri");
    }
    if (!self gibclientutils::isgibbed(localclientnum, self, 256)) {
        function_e2c3df2f(localclientnum, var_18e19c80, "left_leg", "j_knee_le");
    }
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 4, eflags: 0x1 linked
// Checksum 0x1a429002, Offset: 0x19e0
// Size: 0x4a
function function_e2c3df2f(localclientnum, fx, key, tag) {
    self.var_36d7ee48[localclientnum][key] = util::playfxontag(localclientnum, fx, self, tag);
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 1, eflags: 0x1 linked
// Checksum 0x62630203, Offset: 0x1a38
// Size: 0x94
function function_fb35f102(localclientnum) {
    self endon(#"death");
    if (isdefined(self.var_36d7ee48)) {
        keys = getarraykeys(self.var_36d7ee48[localclientnum]);
        for (i = 0; i < keys.size; i++) {
            function_5f8032a3(localclientnum, keys[i]);
        }
    }
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 2, eflags: 0x1 linked
// Checksum 0xc1f93bc0, Offset: 0x1ad8
// Size: 0x3c
function function_5f8032a3(localclientnum, key) {
    deletefx(localclientnum, self.var_36d7ee48[localclientnum][key]);
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 7, eflags: 0x1 linked
// Checksum 0xabe9b088, Offset: 0x1b20
// Size: 0x84
function function_c5d4038a(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        self playrenderoverridebundle("rob_tricannon_classified_zombie_ice");
        return;
    }
    self stoprenderoverridebundle("rob_tricannon_classified_zombie_ice");
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 1, eflags: 0x1 linked
// Checksum 0xf06cb58f, Offset: 0x1bb0
// Size: 0x24
function function_23e3d541(localclientnum) {
    function_c9ba064d(localclientnum, 0);
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 1, eflags: 0x1 linked
// Checksum 0x8bd603a7, Offset: 0x1be0
// Size: 0x24
function function_33af39da(localclientnum) {
    function_c9ba064d(localclientnum, 1);
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 1, eflags: 0x1 linked
// Checksum 0x7448fe4d, Offset: 0x1c10
// Size: 0xa4
function function_42375efd(gib_origin) {
    start_pos = self.origin;
    force = vectornormalize(gib_origin - start_pos);
    force += (0, 0, randomfloatrange(0.4, 0.6));
    force *= randomfloatrange(0.8, 1.2);
    return force;
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 2, eflags: 0x5 linked
// Checksum 0xad61d0bb, Offset: 0x1cc0
// Size: 0xc4
function private function_c9ba064d(localclientnum, var_44146a38) {
    if (util::is_mature()) {
        function_ffcbd1b7(localclientnum, "j_elbow_ri", 16, var_44146a38);
        function_ffcbd1b7(localclientnum, "j_elbow_le", 32, var_44146a38);
        function_ffcbd1b7(localclientnum, "j_knee_ri", 128, var_44146a38);
        function_ffcbd1b7(localclientnum, "j_knee_le", 256, var_44146a38);
        self hide();
    }
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 1, eflags: 0x5 linked
// Checksum 0x7daf5275, Offset: 0x1d90
// Size: 0x19e
function private function_30c6731(gibflag) {
    gib_model = undefined;
    if (isdefined(self.archetype) && self.archetype == #"nova_crawler") {
        switch (gibflag) {
        case 16:
            gib_model = "c_t8_zmb_ofc_quadcrawler_s_rarmspawn";
            break;
        case 32:
            gib_model = "c_t8_zmb_ofc_quadcrawler_s_larmspawn";
            break;
        case 128:
            gib_model = "c_t8_zmb_ofc_quadcrawler_s_rlegspawn";
            break;
        case 256:
            gib_model = "c_t8_zmb_ofc_quadcrawler_s_llegspawn";
            break;
        default:
            break;
        }
    } else {
        switch (gibflag) {
        case 16:
            gib_model = "c_t8_zmb_ofc_zombie_male_s_rarmoff";
            break;
        case 32:
            gib_model = "c_t8_zmb_ofc_zombie_male_s_larmoff";
            break;
        case 128:
            gib_model = "c_t8_zmb_ofc_zombie_male_s_rlegoff";
            break;
        case 256:
            gib_model = "c_t8_zmb_ofc_zombie_male_s_llegoff";
            break;
        default:
            break;
        }
    }
    return gib_model;
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 4, eflags: 0x5 linked
// Checksum 0x5b887e08, Offset: 0x1f38
// Size: 0x11c
function private function_ffcbd1b7(localclientnum, tag_name, gibflag, var_44146a38) {
    gib_origin = self gettagorigin(tag_name);
    if (!self gibclientutils::isgibbed(localclientnum, self, gibflag) && isdefined(gib_origin)) {
        gib_angles = self gettagangles(tag_name);
        gib_force = var_44146a38 ? function_42375efd(gib_origin) : (0, 0, 0);
        gib_model = function_30c6731(gibflag);
        if (isdefined(gib_model)) {
            createdynentandlaunch(localclientnum, gib_model, gib_origin, gib_angles, gib_origin, gib_force, #"hash_6d51d7c934576ac8", 1);
        }
    }
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 7, eflags: 0x5 linked
// Checksum 0x92a7d640, Offset: 0x2060
// Size: 0x2f4
function private function_cd07a2bb(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    fx_tag = "J_Spine4";
    if (is_true(self.isdog)) {
        fx_tag = "J_Spine1";
    } else if (self.archetype !== #"zombie") {
        fx_tag = "tag_origin";
    }
    if (bwastimejump == 1) {
        if (!isdefined(self.var_48531c81)) {
            self.var_48531c81 = spawn(fieldname, self.origin, "script_model");
            self.var_48531c81 setmodel("tag_origin");
            self.var_48531c81 linkto(self, fx_tag);
        }
        self.var_48531c81.var_5e09354d = util::playfxontag(fieldname, #"hash_3e184ca7b210cca5", self.var_48531c81, "tag_origin");
        return;
    }
    if (bwastimejump == 2) {
        if (isdefined(self.var_48531c81.var_5e09354d)) {
            stopfx(fieldname, self.var_48531c81.var_5e09354d);
            if (isdefined(self.var_48531c81)) {
                self.var_48531c81 delete();
            }
        }
        var_e09ff13a = spawn(fieldname, self.origin, "script_model");
        var_e09ff13a setmodel("tag_origin");
        var_e09ff13a.var_cc0e9e52 = util::playfxontag(fieldname, #"hash_4b9be18c0ce06e50", var_e09ff13a, "tag_origin");
        var_e09ff13a linkto(self, fx_tag);
        var_e09ff13a thread function_bf22dbf0(fieldname, self);
        return;
    }
    if (isdefined(self.var_48531c81.var_5e09354d)) {
        stopfx(fieldname, self.var_48531c81.var_5e09354d);
        if (isdefined(self.var_48531c81)) {
            self.var_48531c81 delete();
        }
    }
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 2, eflags: 0x5 linked
// Checksum 0x64fce064, Offset: 0x2360
// Size: 0xa4
function private function_bf22dbf0(localclientnum, parent) {
    level endon(#"end_game");
    self endon(#"death");
    parent waittilltimeout(15, #"death");
    if (isdefined(self.var_cc0e9e52)) {
        stopfx(localclientnum, self.var_cc0e9e52);
        if (isdefined(self)) {
            self delete();
        }
    }
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 7, eflags: 0x5 linked
// Checksum 0xcca17aee, Offset: 0x2410
// Size: 0x23c
function private function_c72e22ff(localclientnum, oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (!isdefined(self.var_1d9be360)) {
        self.var_1d9be360 = [];
    }
    if (bwastimejump == 9) {
        for (var_dd6fbcf0 = fieldname; var_dd6fbcf0 > 0; var_dd6fbcf0--) {
            if (isdefined(self.var_1d9be360[var_dd6fbcf0])) {
                killfx(binitialsnap, self.var_1d9be360[var_dd6fbcf0]);
                self.var_1d9be360[var_dd6fbcf0] = undefined;
            }
        }
        return;
    }
    if (fieldname == 9 && bwastimejump != fieldname) {
        for (var_dd6fbcf0 = 1; var_dd6fbcf0 <= bwastimejump; var_dd6fbcf0++) {
            var_9051360a = function_12050e71(var_dd6fbcf0);
            self.var_1d9be360[var_dd6fbcf0] = playviewmodelfx(binitialsnap, #"hash_16c90556892a0ab7", var_9051360a);
        }
        return;
    }
    if (bwastimejump > fieldname) {
        for (var_dd6fbcf0 = fieldname + 1; var_dd6fbcf0 <= bwastimejump; var_dd6fbcf0++) {
            var_9051360a = function_12050e71(var_dd6fbcf0);
            self.var_1d9be360[var_dd6fbcf0] = playviewmodelfx(binitialsnap, #"hash_16c90556892a0ab7", var_9051360a);
        }
        return;
    }
    if (bwastimejump < fieldname) {
        for (var_dd6fbcf0 = fieldname; var_dd6fbcf0 > bwastimejump; var_dd6fbcf0--) {
            if (isdefined(self.var_1d9be360[var_dd6fbcf0])) {
                stopfx(binitialsnap, self.var_1d9be360[var_dd6fbcf0]);
                self.var_1d9be360[var_dd6fbcf0] = undefined;
            }
        }
    }
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 1, eflags: 0x5 linked
// Checksum 0xb1ab5315, Offset: 0x2658
// Size: 0x30
function private function_12050e71(var_dd6fbcf0) {
    str_tag = "tag_condenser_0" + var_dd6fbcf0 + "_fx";
    return str_tag;
}

// Namespace namespace_b376a999/namespace_b376a999
// Params 7, eflags: 0x1 linked
// Checksum 0xd3abfa5c, Offset: 0x2690
// Size: 0xe6
function function_48f0fe69(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        self.var_7c1596d6 = util::playfxontag(fieldname, "zm_weapons/fx9_ww_ieu_shockwave_trail_1p", self, "tag_origin");
        var_fa5b0a8f = #"hash_165ad2675780cb74";
        self playrumblelooponentity(fieldname, var_fa5b0a8f);
        return;
    }
    if (isdefined(self.var_7c1596d6)) {
        killfx(fieldname, self.var_7c1596d6);
        self.var_7c1596d6 = undefined;
    }
}

