#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;

#namespace namespace_7890c038;

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0xb6a9bbb9, Offset: 0xd0
// Size: 0x34
function init() {
    init_clientfields();
    init_flags();
    init_fx();
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0xaf04a6ed, Offset: 0x110
// Size: 0x424
function init_clientfields() {
    clientfield::register("scriptmover", "" + #"hash_7876f33937c8a764", 1, 1, "int", &vomit, 0, 0);
    clientfield::register("scriptmover", "" + #"safe_fx", 1, 1, "int", &safe_fx, 0, 0);
    clientfield::register("scriptmover", "" + #"flare_fx", 1, 2, "int", &flare_fx, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_2042191a7fc75994", 1, 2, "int", &function_301df2f, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_2ec182fecae80e80", 1, 1, "int", &function_a99e00ca, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_7b3de02b6d3084ab", 1, 1, "int", &function_22185724, 0, 0);
    clientfield::register("scriptmover", "" + #"portal_pass", 1, 2, "int", &function_1e5f6a2a, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_1cf8b9339139c50d", 1, 1, "int", &function_d3503039, 0, 0);
    clientfield::register("scriptmover", "" + #"car_fx", 1, 1, "int", &function_4b91cc15, 0, 0);
    clientfield::register("world", "" + #"hash_1166237b92466ac9", 1, 1, "int", &function_942151ab, 0, 0);
    clientfield::register("world", "" + #"fireworks_fx", 1, 2, "counter", &fireworks_fx, 0, 0);
    clientfield::register("world", "" + #"crash_fx", 1, 1, "int", &function_c9c137d6, 0, 0);
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x540
// Size: 0x4
function init_flags() {
    
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 0, eflags: 0x0
// Checksum 0x286f256d, Offset: 0x550
// Size: 0x3f2
function init_fx() {
    level._effect[#"safe_fx"] = #"hash_4bf40208439d50d6";
    level._effect[#"hash_3ed9aa5890e4cfd2"] = #"hash_4b6b503d842bc415";
    level._effect[#"hash_21893413efec355e"] = #"hash_cf3c06e4368bbb1";
    level._effect[#"hash_55ab46637a8fbcb3"] = #"hash_5508b1d8864ee2d2";
    level._effect[#"hash_2377de258e66b4ce"] = #"hash_33da19858ee59385";
    level._effect[#"hash_76a20bbf3432c804"] = #"hash_3c61ebb7d005c6f9";
    level._effect[#"hash_4817a1dbc7bf4ca4"] = #"hash_3c61e9b7d005c393";
    level._effect[#"hash_3ddf14b70581a57"] = #"hash_3c61ecb7d005c8ac";
    level._effect[#"hash_3bfcf7e07661fa18"] = #"hash_5e9dff5fcbf30022";
    level._effect[#"hash_26c9596a43d9be2e"] = #"hash_4144490ff4773f4b";
    level._effect[#"hash_7b3de02b6d3084ab"] = #"hash_623711abbea58074";
    level._effect[#"hash_6571250749b2c790"] = #"hash_1a3fcc6c808e55eb";
    level._effect[#"hash_51ecda6f24a58d05"] = #"hash_13c3cecd3d059c90";
    level._effect[#"hash_2f154bbb31e4abaf"] = #"hash_706103079a2bdb6d";
    level._effect[#"hash_3524e302fa83d12e"] = #"hash_3a791d490f01f5c7";
    level._effect[#"hash_2498ee8a7586b418"] = #"hash_15dc4292340f0f1c";
    level._effect[#"hash_16c2570acb38a0ed"] = #"hash_7691f79bfc16f0bf";
    level._effect[#"car_lights"] = #"hash_335feb1d213c22f6";
    level._effect[#"hash_1c0ed73a9b21a882"] = #"hash_cc7196a44e2fbe3";
    level._effect[#"hash_704d3c12d59fb5d7"] = #"hash_2aabc11b07ad74d8";
    level._effect[#"hash_4ec5da9e09256102"] = #"hash_3063115f97c18abf";
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 7, eflags: 0x0
// Checksum 0x5632cbc3, Offset: 0x950
// Size: 0xbe
function function_4b91cc15(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.n_trail_fx = util::playfxontag(localclientnum, level._effect[#"car_lights"], self, "tag_body");
        return;
    }
    if (isdefined(self.n_trail_fx)) {
        killfx(localclientnum, self.n_trail_fx);
        self.n_trail_fx = undefined;
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 7, eflags: 0x0
// Checksum 0x8b7f032b, Offset: 0xa18
// Size: 0x1cc
function function_d3503039(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self util::waittill_dobj(localclientnum);
        self.var_f2c42198 = util::playfxontag(localclientnum, level._effect[#"hash_2f154bbb31e4abaf"], self, "tag_origin");
        playfx(localclientnum, level._effect[#"hash_16c2570acb38a0ed"], self.origin, anglestoforward(self.angles), anglestoup(self.angles));
        playrumbleonposition(localclientnum, #"hash_743b325bf45e1c8c", self.origin);
        wait 0.75;
        playfx(localclientnum, level._effect[#"hash_2498ee8a7586b418"], self.origin, anglestoforward(self.angles), anglestoup(self.angles));
        return;
    }
    if (isdefined(self.var_f2c42198)) {
        stopfx(localclientnum, self.var_f2c42198);
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 7, eflags: 0x0
// Checksum 0xc81fac4a, Offset: 0xbf0
// Size: 0xdc
function function_942151ab(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        s_loc = struct::get(#"spark_loc");
        playfx(localclientnum, level._effect[#"hash_3524e302fa83d12e"], s_loc.origin, anglestoforward(s_loc.angles), anglestoup(s_loc.angles));
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 7, eflags: 0x0
// Checksum 0x2f709d78, Offset: 0xcd8
// Size: 0xb2
function vomit(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(self.var_7f7ef55a)) {
        stopfx(localclientnum, self.var_7f7ef55a);
        self.var_7f7ef55a = undefined;
    }
    if (newval) {
        self.var_7f7ef55a = util::playfxontag(localclientnum, level._effect[#"fx8_blightfather_vomit_object"], self, "tag_origin");
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 7, eflags: 0x0
// Checksum 0x7bd3087a, Offset: 0xd98
// Size: 0xcc
function function_a99e00ca(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self playrenderoverridebundle(#"rob_tricannon_character_ice");
        s_loc = struct::get(#"hash_583635858828e286");
        playfx(localclientnum, level._effect[#"hash_26c9596a43d9be2e"], s_loc.origin);
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 7, eflags: 0x0
// Checksum 0x99e060dc, Offset: 0xe70
// Size: 0x9c
function function_22185724(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self playrenderoverridebundle(#"rob_tricannon_character_ice");
        util::playfxontag(localclientnum, level._effect[#"hash_7b3de02b6d3084ab"], self, "tag_origin");
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 7, eflags: 0x0
// Checksum 0xc982aa11, Offset: 0xf18
// Size: 0xb4
function function_c9c137d6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        s_loc = struct::get(#"hash_27613769597daaf0");
        playfx(localclientnum, level._effect[#"hash_3bfcf7e07661fa18"], s_loc.origin);
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 7, eflags: 0x0
// Checksum 0x18349b12, Offset: 0xfd8
// Size: 0x15c
function function_1e5f6a2a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(self.var_112607c8)) {
        killfx(localclientnum, self.var_112607c8);
        self.var_112607c8 = undefined;
    }
    if (newval == 1) {
        self util::waittill_dobj(localclientnum);
        self.var_112607c8 = util::playfxontag(localclientnum, level._effect[#"hash_6571250749b2c790"], self, "tag_origin");
        return;
    }
    if (newval == 2) {
        self.var_112607c8 = util::playfxontag(localclientnum, level._effect[#"hash_51ecda6f24a58d05"], self, "tag_origin");
        return;
    }
    playfx(localclientnum, level._effect[#"hash_3ddf14b70581a57"], self.origin);
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 7, eflags: 0x0
// Checksum 0xefc4d075, Offset: 0x1140
// Size: 0x124
function function_7429ef7c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    s_loc = struct::get(#"floaters_fx");
    if (newval == 1) {
        s_loc.fx = playfx(localclientnum, level._effect[#"hash_29d523bd9b3bf58a"], s_loc.origin, anglestoforward(s_loc.angles), anglestoup(s_loc.angles));
        return;
    }
    if (isdefined(s_loc.fx)) {
        stopfx(localclientnum, s_loc.fx);
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 7, eflags: 0x0
// Checksum 0xeac8a2a0, Offset: 0x1270
// Size: 0x17e
function safe_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self util::waittill_dobj(localclientnum);
    if (newval == 1) {
        if (!isdefined(self.fx)) {
            v_forward = anglestoforward(self.angles);
            v_right = anglestoright(self.angles);
            v_loc = self.origin + v_right * 7;
            v_loc += v_forward * -8;
            self.fx = playfx(localclientnum, level._effect[#"safe_fx"], v_loc, v_forward, anglestoup(self.angles));
        }
        return;
    }
    if (isdefined(self.fx)) {
        stopfx(localclientnum, self.fx);
        self.fx = undefined;
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 7, eflags: 0x0
// Checksum 0x9f82a36, Offset: 0x13f8
// Size: 0x2ae
function flare_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        util::playfxontag(localclientnum, level._effect[#"hash_3ed9aa5890e4cfd2"], self, "tag_origin");
        if (newval == 1) {
            if (!isdefined(self.fx)) {
                self.fx = util::playfxontag(localclientnum, level._effect[#"hash_21893413efec355e"], self, "tag_origin");
                wait 2;
                if (isdefined(self)) {
                    playfx(localclientnum, level._effect[#"hash_76a20bbf3432c804"], self.origin);
                }
            }
        } else if (newval == 2) {
            if (!isdefined(self.fx)) {
                self.fx = util::playfxontag(localclientnum, level._effect[#"hash_2377de258e66b4ce"], self, "tag_origin");
                wait 2;
                if (isdefined(self)) {
                    playfx(localclientnum, level._effect[#"hash_4817a1dbc7bf4ca4"], self.origin);
                }
            }
        } else if (newval == 3) {
            if (!isdefined(self.fx)) {
                self.fx = util::playfxontag(localclientnum, level._effect[#"hash_55ab46637a8fbcb3"], self, "tag_origin");
                wait 2;
                if (isdefined(self)) {
                    playfx(localclientnum, level._effect[#"hash_3ddf14b70581a57"], self.origin);
                }
            }
        }
        return;
    }
    if (isdefined(self.fx)) {
        stopfx(localclientnum, self.fx);
        self.fx = undefined;
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 7, eflags: 0x0
// Checksum 0x6c0ad322, Offset: 0x16b0
// Size: 0x17a
function function_301df2f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(self.fx)) {
        stopfx(localclientnum, self.fx);
        self.fx = undefined;
    }
    switch (newval) {
    case 1:
        self.fx = util::playfxontag(localclientnum, level._effect[#"hash_1c0ed73a9b21a882"], self, "tag_origin");
        break;
    case 2:
        self.fx = util::playfxontag(localclientnum, level._effect[#"hash_4ec5da9e09256102"], self, "tag_origin");
        break;
    case 3:
        self.fx = util::playfxontag(localclientnum, level._effect[#"hash_704d3c12d59fb5d7"], self, "tag_origin");
        break;
    }
}

// Namespace namespace_7890c038/zm_zodt8_side_quests
// Params 7, eflags: 0x0
// Checksum 0xe14433eb, Offset: 0x1838
// Size: 0x274
function fireworks_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        a_s_locs = struct::get_array(#"hash_5af7eeb066c5efbe", "script_noteworthy");
        s_loc = a_s_locs[randomint(a_s_locs.size)];
        playfx(localclientnum, level._effect[#"hash_76a20bbf3432c804"], s_loc.origin);
        playsound(0, #"hash_40d3baad4b103e04", s_loc.origin);
        return;
    }
    if (newval == 2) {
        a_s_locs = struct::get_array(#"hash_5af7eeb066c5efbe", "script_noteworthy");
        s_loc = a_s_locs[randomint(a_s_locs.size)];
        playfx(localclientnum, level._effect[#"hash_4817a1dbc7bf4ca4"], s_loc.origin);
        playsound(0, #"hash_40d3baad4b103e04", s_loc.origin);
        return;
    }
    if (newval == 3) {
        a_s_locs = struct::get_array(#"hash_5af7eeb066c5efbe", "script_noteworthy");
        s_loc = a_s_locs[randomint(a_s_locs.size)];
        playfx(localclientnum, level._effect[#"hash_3ddf14b70581a57"], s_loc.origin);
        playsound(0, #"hash_40d3baad4b103e04", s_loc.origin);
    }
}

