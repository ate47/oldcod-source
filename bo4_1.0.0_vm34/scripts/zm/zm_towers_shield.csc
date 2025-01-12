#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;

#namespace namespace_10544329;

// Namespace namespace_10544329/zm_towers_shield
// Params 0, eflags: 0x2
// Checksum 0x5b67f966, Offset: 0xf8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"hash_7ca2cbd84515aff1", &__init__, undefined, undefined);
}

// Namespace namespace_10544329/zm_towers_shield
// Params 0, eflags: 0x0
// Checksum 0xf9feffc8, Offset: 0x140
// Size: 0x602
function __init__() {
    clientfield::register("allplayers", "" + #"hash_26af481b9a9d41ce", 1, 1, "counter", &function_91c12e44, 0, 0);
    clientfield::register("allplayers", "" + #"charge_gem", 1, 2, "int", &function_f88a7062, 0, 0);
    clientfield::register("allplayers", "" + #"hash_275debebcd185ea1", 1, 1, "int", &function_92f8023c, 0, 0);
    clientfield::register("toplayer", "" + #"hash_dc971935944f005", 1, 1, "counter", &function_21e10f71, 0, 0);
    clientfield::register("toplayer", "" + #"hash_6b725eefec5d09d1", 1, 1, "counter", &function_f716a7bd, 0, 0);
    clientfield::register("toplayer", "" + #"hash_73e9280f74528e8f", 1, 1, "counter", &function_a5d8f8d3, 0, 0);
    clientfield::register("toplayer", "" + #"hash_21ff5b4eccea85ff", 1, 1, "counter", &function_ebe78403, 0, 0);
    clientfield::register("toplayer", "" + #"hash_64a830301c1adbf3", 1, 1, "counter", &function_4eb83997, 0, 0);
    clientfield::register("toplayer", "" + #"hash_4f32455c6a0286cd", 1, 1, "counter", &function_b6aee999, 0, 0);
    clientfield::register("toplayer", "" + #"hash_32ef1785f4e55e5c", 1, 1, "counter", &function_6c71473e, 0, 0);
    clientfield::register("toplayer", "" + #"hash_2cd1bb15f71aedb8", 1, 1, "counter", &function_e016aa0a, 0, 0);
    clientfield::register("toplayer", "" + #"hash_1769e95fdb10dfae", 1, 1, "counter", &function_675e79b8, 0, 0);
    level._effect[#"firestorm_1p"] = #"hash_5a45cca38c2dd6c8";
    level._effect[#"firestorm_3p"] = #"hash_5a4cd8a38c3409da";
    level._effect[#"charged_eyes"] = #"hash_2d151fbde925d3e";
    level._effect[#"hash_75cfc1cd4cd9154"] = #"hash_2eeb08ff15dbd6b1";
    level._effect[#"hash_75cff1cd4cd966d"] = #"hash_5a07c709253f930e";
    level._effect[#"hash_75cfe1cd4cd94ba"] = #"hash_75bbd0f87c4680f";
    level._effect[#"hash_b6b43fcf47f973a"] = #"hash_459f76532c44d9de";
    level._effect[#"hash_b6437fcf4796428"] = #"hash_45986a532c3ea6cc";
    level._effect[#"hash_1f529a78925e826b"] = #"hash_459f76532c44d9de";
    level._effect[#"hash_3e1099f1a91d23a9"] = #"hash_45986a532c3ea6cc";
}

// Namespace namespace_10544329/zm_towers_shield
// Params 7, eflags: 0x0
// Checksum 0x41ecb224, Offset: 0x750
// Size: 0xcc
function function_91c12e44(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (zm_utility::function_a96d4c46(localclientnum)) {
        playviewmodelfx(localclientnum, level._effect[#"firestorm_1p"], "tag_barrels_fx");
        return;
    }
    util::playfxontag(localclientnum, level._effect[#"firestorm_3p"], self, "tag_barrels_fx");
}

// Namespace namespace_10544329/zm_towers_shield
// Params 7, eflags: 0x0
// Checksum 0x9407fd8, Offset: 0x828
// Size: 0x10c
function function_92f8023c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (zm_utility::function_a96d4c46(localclientnum)) {
            self.fx_docked = playviewmodelfx(localclientnum, level._effect[#"hash_1f529a78925e826b"], "tag_blade_fx");
        } else {
            self.fx_docked = util::playfxontag(localclientnum, level._effect[#"hash_3e1099f1a91d23a9"], self, "tag_blade_fx");
        }
        return;
    }
    if (isdefined(self.fx_docked)) {
        killfx(localclientnum, self.fx_docked);
    }
}

// Namespace namespace_10544329/zm_towers_shield
// Params 7, eflags: 0x0
// Checksum 0x8ec130e5, Offset: 0x940
// Size: 0x642
function function_f88a7062(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self.fx_katar)) {
        self.fx_katar = [];
    } else if (!isarray(self.fx_katar)) {
        self.fx_katar = array(self.fx_katar);
    }
    foreach (fx in self.fx_katar) {
        killfx(localclientnum, fx);
    }
    if (isdefined(self.var_2ec3751d)) {
        self stoploopsound(self.var_2ec3751d);
        self.var_2ec3751d = undefined;
    }
    switch (newval) {
    case 0:
        foreach (fx in self.fx_katar) {
            killfx(localclientnum, fx);
        }
        if (isdefined(self.var_cc673d16)) {
            killfx(localclientnum, self.var_cc673d16);
        }
        break;
    case 1:
        self.var_cc673d16 = util::playfxontag(localclientnum, level._effect[#"charged_eyes"], self, "tag_barrels_fx");
        if (zm_utility::function_a96d4c46(localclientnum)) {
            self.fx_katar[#"r"] = playviewmodelfx(localclientnum, level._effect[#"hash_75cfc1cd4cd9154"], "tag_gem_right3_fx");
            self.fx_katar[#"l"] = playviewmodelfx(localclientnum, level._effect[#"hash_75cfc1cd4cd9154"], "tag_gem_left3_fx");
            self playsound(localclientnum, #"hash_5bdfbb591ff7e29d");
        }
        break;
    case 2:
        if (zm_utility::function_a96d4c46(localclientnum)) {
            self.fx_katar[#"r"] = playviewmodelfx(localclientnum, level._effect[#"hash_75cff1cd4cd966d"], "tag_gem_right3_fx");
            self.fx_katar[#"l"] = playviewmodelfx(localclientnum, level._effect[#"hash_75cff1cd4cd966d"], "tag_gem_left3_fx");
            self playsound(localclientnum, #"hash_5bdfb8591ff7dd84");
        }
        break;
    case 3:
        if (zm_utility::function_a96d4c46(localclientnum)) {
            self.fx_katar[#"flame_1p"] = playviewmodelfx(localclientnum, level._effect[#"hash_b6b43fcf47f973a"], "tag_blade_fx");
            self.fx_katar[#"r"] = playviewmodelfx(localclientnum, level._effect[#"hash_75cfe1cd4cd94ba"], "tag_gem_right3_fx");
            self.fx_katar[#"l"] = playviewmodelfx(localclientnum, level._effect[#"hash_75cfe1cd4cd94ba"], "tag_gem_left3_fx");
            if (oldval != 0) {
                self playsound(localclientnum, #"hash_5bdfb9591ff7df37");
            }
        } else {
            self.fx_katar[#"flame_3p"] = util::playfxontag(localclientnum, level._effect[#"hash_b6437fcf4796428"], self, "tag_blade_fx");
        }
        if (!isdefined(self.var_2ec3751d)) {
            if (oldval != 0) {
                self playsound(localclientnum, #"hash_54365a8985bf4da9");
            }
            self.var_2ec3751d = self playloopsound(#"hash_5452ecceeecdc217");
        }
        break;
    }
}

// Namespace namespace_10544329/zm_towers_shield
// Params 7, eflags: 0x0
// Checksum 0x7e7c6aa2, Offset: 0xf90
// Size: 0xac
function function_21e10f71(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self function_517c9fa0();
    s_start = struct::get(#"hash_8f1fa9142d272b6");
    self thread function_52432d41(localclientnum, #"lower", s_start);
}

// Namespace namespace_10544329/zm_towers_shield
// Params 7, eflags: 0x0
// Checksum 0x4d8939be, Offset: 0x1048
// Size: 0x5c
function function_f716a7bd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self flag::set(#"hash_4752663d0689d2c2");
}

// Namespace namespace_10544329/zm_towers_shield
// Params 7, eflags: 0x0
// Checksum 0xab5dceb4, Offset: 0x10b0
// Size: 0x5c
function function_a5d8f8d3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self flag::set(#"hash_4d84827b8da5223d");
}

// Namespace namespace_10544329/zm_towers_shield
// Params 7, eflags: 0x0
// Checksum 0x4c166dce, Offset: 0x1118
// Size: 0xac
function function_ebe78403(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self function_517c9fa0();
    s_start = struct::get(#"hash_6ef4fc9a0ac3e3bc");
    self thread function_52432d41(localclientnum, #"katar", s_start);
}

// Namespace namespace_10544329/zm_towers_shield
// Params 7, eflags: 0x0
// Checksum 0x265cf7ff, Offset: 0x11d0
// Size: 0x5c
function function_4eb83997(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self flag::set(#"hash_3c5ef4492a237f89");
}

// Namespace namespace_10544329/zm_towers_shield
// Params 7, eflags: 0x0
// Checksum 0x8a565403, Offset: 0x1238
// Size: 0x5c
function function_b6aee999(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self flag::set(#"hash_748199dab24b7972");
}

// Namespace namespace_10544329/zm_towers_shield
// Params 7, eflags: 0x0
// Checksum 0x4759cbdf, Offset: 0x12a0
// Size: 0xac
function function_6c71473e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self function_517c9fa0();
    s_start = struct::get(#"hash_3c2d004790b50543");
    self thread function_52432d41(localclientnum, #"upper", s_start);
}

// Namespace namespace_10544329/zm_towers_shield
// Params 7, eflags: 0x0
// Checksum 0x2253f066, Offset: 0x1358
// Size: 0x5c
function function_e016aa0a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self flag::set(#"hash_5be88bdaaf36eedf");
}

// Namespace namespace_10544329/zm_towers_shield
// Params 7, eflags: 0x0
// Checksum 0xb5617dcf, Offset: 0x13c0
// Size: 0x5c
function function_675e79b8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self flag::set(#"hash_586e5d98fff291f8");
}

// Namespace namespace_10544329/zm_towers_shield
// Params 0, eflags: 0x0
// Checksum 0xa6b25371, Offset: 0x1428
// Size: 0x164
function function_517c9fa0() {
    self endon(#"disconnect");
    if (!self flag::exists(#"hash_6f18405679f0d57")) {
        self flag::init(#"hash_6f18405679f0d57");
    }
    if (self flag::get(#"hash_6f18405679f0d57")) {
        return;
    }
    self flag::init(#"hash_4752663d0689d2c2");
    self flag::init(#"hash_3c5ef4492a237f89");
    self flag::init(#"hash_5be88bdaaf36eedf");
    self flag::init(#"hash_4d84827b8da5223d");
    self flag::init(#"hash_748199dab24b7972");
    self flag::init(#"hash_586e5d98fff291f8");
    self flag::set(#"hash_6f18405679f0d57");
}

// Namespace namespace_10544329/zm_towers_shield
// Params 3, eflags: 0x0
// Checksum 0xd154a061, Offset: 0x1598
// Size: 0x2b4
function function_52432d41(localclientnum, str_piece, s_start) {
    self endon(#"disconnect");
    switch (str_piece) {
    case #"lower":
        str_model = #"hash_534a8889633c5f83";
        var_fd8f34ab = #"hash_4752663d0689d2c2";
        var_7fb8a845 = #"hash_4d84827b8da5223d";
        n_drop_time = 1;
        break;
    case #"katar":
        str_model = #"hash_55f4b4dc9ecc95a5";
        var_fd8f34ab = #"hash_3c5ef4492a237f89";
        var_7fb8a845 = #"hash_748199dab24b7972";
        n_drop_time = 0;
        break;
    case #"upper":
        str_model = #"hash_a3555c0c041bd06";
        var_fd8f34ab = #"hash_5be88bdaaf36eedf";
        var_7fb8a845 = #"hash_586e5d98fff291f8";
        n_drop_time = 0.5;
        break;
    }
    forcestreamxmodel(str_model);
    mdl_piece = util::spawn_model(localclientnum, str_model, s_start.origin, s_start.angles);
    self flag::wait_till(var_fd8f34ab);
    if (str_piece != #"katar") {
        s_end = struct::get(s_start.target);
        mdl_piece moveto(s_end.origin, n_drop_time);
        mdl_piece rotateto(s_end.angles, n_drop_time);
    }
    if (isdefined(self)) {
        self flag::wait_till(var_7fb8a845);
    }
    if (isdefined(self)) {
        self playsound(localclientnum, #"hash_230737b2535a3374");
    }
    mdl_piece delete();
    stopforcestreamingxmodel(str_model);
}

