#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace zm_magicbox;

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x2
// Checksum 0x4cb3a4b9, Offset: 0x1f8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_magicbox", &__init__, undefined, undefined);
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x0
// Checksum 0xb71bb48c, Offset: 0x240
// Size: 0x4a4
function __init__() {
    level._effect[#"hash_2bba72fdcc5508b5"] = #"hash_3b22162a96d9389";
    level._effect[#"chest_light_closed"] = #"zombie/fx_weapon_box_closed_glow_zmb";
    level._effect[#"hash_19f4dd97cbb87594"] = #"hash_5f376e9395e16666";
    level._effect[#"hash_246062f68a34e289"] = #"hash_55cc904817de4a07";
    level._effect[#"hash_73c11d9bf55cbb6"] = #"hash_31c4723879504cb7";
    level._effect[#"hash_5239f7431d4c72ca"] = #"hash_3f4154d786124350";
    level._effect[#"hash_b6e7f724af1ad5b"] = #"hash_7ed77a22f165e308";
    level._effect[#"fire_runner"] = #"hash_409439bf8b3dd862";
    clientfield::register("zbarrier", "magicbox_open_fx", 1, 1, "int", &function_647c63c5, 0, 0);
    clientfield::register("zbarrier", "magicbox_closed_fx", 1, 1, "int", &function_11d609ad, 0, 0);
    clientfield::register("zbarrier", "magicbox_leave_fx", 1, 1, "counter", &function_1db2591c, 0, 0);
    clientfield::register("zbarrier", "zbarrier_show_sounds", 1, 1, "counter", &magicbox_show_sounds_callback, 1, 0);
    clientfield::register("zbarrier", "zbarrier_leave_sounds", 1, 1, "counter", &magicbox_leave_sounds_callback, 1, 0);
    clientfield::register("zbarrier", "force_stream_magicbox", 1, 1, "int", &force_stream_magicbox, 0, 0);
    clientfield::register("zbarrier", "force_stream_magicbox_leave", 1, 1, "int", &force_stream_magicbox_leave, 0, 0);
    clientfield::register("scriptmover", "force_stream", 1, 1, "int", &force_stream_changed, 0, 0);
    clientfield::register("zbarrier", "t8_magicbox_crack_glow_fx", 1, 1, "int", &t8_magicbox_crack_glow_fx, 0, 0);
    clientfield::register("zbarrier", "t8_magicbox_ambient_fx", 1, 1, "int", &t8_magicbox_ambient_fx, 0, 0);
    clientfield::register("zbarrier", "" + #"hash_2fcdae6b889933c7", 1, 1, "int", &function_fcb9ead7, 0, 0);
}

// Namespace zm_magicbox/zm_magicbox
// Params 7, eflags: 0x0
// Checksum 0xcf91c260, Offset: 0x6f0
// Size: 0xa4
function force_stream_magicbox(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_75362952 = self zbarriergetpiece(2);
    if (newval) {
        forcestreamxmodel(var_75362952.model);
        return;
    }
    stopforcestreamingxmodel(var_75362952.model);
}

// Namespace zm_magicbox/zm_magicbox
// Params 7, eflags: 0x0
// Checksum 0x14cf8c71, Offset: 0x7a0
// Size: 0xa4
function force_stream_magicbox_leave(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_435d5b1a = self zbarriergetpiece(1);
    if (newval) {
        forcestreamxmodel(var_435d5b1a.model);
        return;
    }
    stopforcestreamingxmodel(var_435d5b1a.model);
}

// Namespace zm_magicbox/zm_magicbox
// Params 7, eflags: 0x0
// Checksum 0x1ba18047, Offset: 0x850
// Size: 0x7c
function force_stream_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        model = self.model;
        if (isdefined(model)) {
            thread stream_model_for_time(localclientnum, model, 15);
        }
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 3, eflags: 0x0
// Checksum 0x56139ab1, Offset: 0x8d8
// Size: 0x4c
function stream_model_for_time(localclientnum, model, time) {
    util::lock_model(model);
    wait time;
    util::unlock_model(model);
}

// Namespace zm_magicbox/zm_magicbox
// Params 7, eflags: 0x0
// Checksum 0xcea0a0f0, Offset: 0x930
// Size: 0x3c
function magicbox_show_sounds_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    
}

// Namespace zm_magicbox/zm_magicbox
// Params 7, eflags: 0x0
// Checksum 0x4a2068b5, Offset: 0x978
// Size: 0x3c
function magicbox_leave_sounds_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    
}

// Namespace zm_magicbox/zm_magicbox
// Params 7, eflags: 0x0
// Checksum 0x2e8ebd8, Offset: 0x9c0
// Size: 0x64
function function_647c63c5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self thread function_b7a1e39c(localclientnum, newval, "opened");
}

// Namespace zm_magicbox/zm_magicbox
// Params 7, eflags: 0x0
// Checksum 0x6033ee37, Offset: 0xa30
// Size: 0x64
function function_11d609ad(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self thread function_b7a1e39c(localclientnum, newval, "closed");
}

// Namespace zm_magicbox/zm_magicbox
// Params 7, eflags: 0x0
// Checksum 0xce62926e, Offset: 0xaa0
// Size: 0x64
function function_1db2591c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self thread function_b7a1e39c(localclientnum, 1, "leave");
}

// Namespace zm_magicbox/zm_magicbox
// Params 3, eflags: 0x0
// Checksum 0xabb1b5cc, Offset: 0xb10
// Size: 0x3fc
function function_b7a1e39c(localclientnum, newval, str_state) {
    if (!isdefined(self.var_5212e1bc)) {
        self.var_5212e1bc = [];
    }
    if (!isdefined(self.var_e657680e)) {
        self.var_e657680e = [];
    }
    if (!isdefined(self.var_200996c5)) {
        self.var_200996c5 = [];
    }
    if (localclientnum != 0) {
        return;
    }
    if (isdefined(self)) {
        if (!isdefined(self.var_5212e1bc[localclientnum])) {
            var_682035c5 = self zbarriergetpiece(2);
            v_tag_origin = var_682035c5 gettagorigin("tag_fx");
            v_tag_angles = var_682035c5 gettagangles("tag_fx");
            if (!isdefined(v_tag_origin)) {
                v_tag_origin = var_682035c5 gettagorigin("tag_origin");
                v_tag_angles = var_682035c5 gettagangles("tag_origin");
            }
            var_c408791c = util::spawn_model(localclientnum, #"tag_origin", v_tag_origin, v_tag_angles);
            self.var_5212e1bc[localclientnum] = var_c408791c;
            waitframe(1);
        }
        if (isdefined(self) && !isdefined(self.var_e657680e[localclientnum])) {
            fx_obj = util::spawn_model(localclientnum, #"tag_origin", self.origin, self.angles);
            self.var_e657680e[localclientnum] = fx_obj;
            waitframe(1);
        }
        if (isdefined(self) && !isdefined(self.var_ebddf7dc)) {
            self.var_ebddf7dc = self zbarriergetpiece(1);
            waitframe(1);
        }
        if (isdefined(self) && (str_state == "opened" || str_state == "closed")) {
            self function_50118dba(localclientnum);
            if (newval) {
                switch (str_state) {
                case #"opened":
                    str_fx = level._effect[#"hash_2bba72fdcc5508b5"];
                    var_cbb85001 = self.var_5212e1bc[localclientnum];
                    str_tag = "tag_origin";
                    break;
                case #"closed":
                    str_fx = level._effect[#"chest_light_closed"];
                    var_cbb85001 = self.var_e657680e[localclientnum];
                    str_tag = "tag_origin";
                    break;
                }
                if (isdefined(str_fx)) {
                    self.var_200996c5[localclientnum] = util::playfxontag(localclientnum, str_fx, var_cbb85001, str_tag);
                    self function_b890d675(localclientnum);
                }
            }
            return;
        }
        if (isdefined(self) && str_state == "leave") {
            util::playfxontag(localclientnum, level._effect[#"hash_19f4dd97cbb87594"], self.var_ebddf7dc, "tag_fx");
        }
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x0
// Checksum 0x79cdfccd, Offset: 0xf18
// Size: 0x54
function function_b890d675(localclientnum) {
    self endon(#"end_demo_jump_listener");
    level waittill(#"demo_jump");
    if (isdefined(self)) {
        self function_50118dba(localclientnum);
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x0
// Checksum 0xae7a9224, Offset: 0xf78
// Size: 0x6e
function function_50118dba(localclientnum) {
    if (isdefined(self) && isdefined(self.var_200996c5[localclientnum])) {
        stopfx(localclientnum, self.var_200996c5[localclientnum]);
        self.var_200996c5[localclientnum] = undefined;
    }
    self notify(#"end_demo_jump_listener");
}

// Namespace zm_magicbox/zm_magicbox
// Params 7, eflags: 0x0
// Checksum 0x8d1d7bbb, Offset: 0xff0
// Size: 0x104
function t8_magicbox_crack_glow_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self.var_1bbc5972)) {
        self.var_1bbc5972 = [];
    }
    if (isdefined(self)) {
        self function_8ef2f247(localclientnum);
        if (newval) {
            mdl_piece = self zbarriergetpiece(1);
            self.var_1bbc5972[localclientnum] = util::playfxontag(localclientnum, level._effect[#"hash_246062f68a34e289"], mdl_piece, "tag_fx");
            self function_1e553286(localclientnum);
        }
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x0
// Checksum 0x3591561e, Offset: 0x1100
// Size: 0x54
function function_1e553286(localclientnum) {
    self endon(#"hash_22de3d549a25efd3");
    level waittill(#"demo_jump");
    if (isdefined(self)) {
        self function_8ef2f247(localclientnum);
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x0
// Checksum 0x5933bc70, Offset: 0x1160
// Size: 0x6e
function function_8ef2f247(localclientnum) {
    if (isdefined(self) && isdefined(self.var_1bbc5972[localclientnum])) {
        killfx(localclientnum, self.var_1bbc5972[localclientnum]);
        self.var_1bbc5972[localclientnum] = undefined;
    }
    self notify(#"hash_22de3d549a25efd3");
}

// Namespace zm_magicbox/zm_magicbox
// Params 7, eflags: 0x0
// Checksum 0x34b48fb3, Offset: 0x11d8
// Size: 0x10c
function function_fcb9ead7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(self)) {
        if (newval) {
            mdl_piece = self zbarriergetpiece(1);
            mdl_piece.tag_origin = mdl_piece gettagorigin("tag_origin");
            self.var_10edffe5 = util::playfxontag(localclientnum, level._effect[#"fire_runner"], mdl_piece, mdl_piece.tag_origin);
            return;
        }
        if (isdefined(self.var_10edffe5)) {
            stopfx(localclientnum, self.var_10edffe5);
        }
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 7, eflags: 0x0
// Checksum 0x729a7118, Offset: 0x12f0
// Size: 0x5b4
function t8_magicbox_ambient_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self.var_98bf1b12)) {
        self.var_98bf1b12 = [];
    }
    if (!isdefined(self.var_d3d4a7c6)) {
        self.var_d3d4a7c6 = [];
    }
    if (isdefined(self)) {
        self function_37b185f3(localclientnum);
        if (newval) {
            if (!isdefined(self.var_98bf1b12[localclientnum])) {
                self.var_98bf1b12[localclientnum] = [];
            }
            if (!isdefined(self.var_d3d4a7c6[localclientnum])) {
                self.var_d3d4a7c6[localclientnum] = [];
            }
            mdl_piece = self zbarriergetpiece(1);
            self.var_98bf1b12[localclientnum][self.var_98bf1b12[localclientnum].size] = util::playfxontag(localclientnum, level._effect[#"hash_73c11d9bf55cbb6"], mdl_piece, "top_skull_head_jnt");
            self.var_d3d4a7c6[localclientnum][self.var_d3d4a7c6[localclientnum].size] = util::playfxontag(localclientnum, level._effect[#"hash_b6e7f724af1ad5b"], mdl_piece, "tag_fx");
            self.var_d3d4a7c6[localclientnum][self.var_d3d4a7c6[localclientnum].size] = util::playfxontag(localclientnum, level._effect[#"hash_5239f7431d4c72ca"], mdl_piece, "tag_fx_mouth_05");
            self.var_d3d4a7c6[localclientnum][self.var_d3d4a7c6[localclientnum].size] = util::playfxontag(localclientnum, level._effect[#"hash_5239f7431d4c72ca"], mdl_piece, "tag_fx_mouth_06");
            self.var_d3d4a7c6[localclientnum][self.var_d3d4a7c6[localclientnum].size] = util::playfxontag(localclientnum, level._effect[#"hash_5239f7431d4c72ca"], mdl_piece, "tag_fx_mouth_07");
            self.var_d3d4a7c6[localclientnum][self.var_d3d4a7c6[localclientnum].size] = util::playfxontag(localclientnum, level._effect[#"hash_5239f7431d4c72ca"], mdl_piece, "tag_fx_mouth_08");
            mdl_piece = self zbarriergetpiece(2);
            self.var_98bf1b12[localclientnum][self.var_98bf1b12[localclientnum].size] = util::playfxontag(localclientnum, level._effect[#"hash_73c11d9bf55cbb6"], mdl_piece, "top_skull_head_jnt");
            self.var_d3d4a7c6[localclientnum][self.var_d3d4a7c6[localclientnum].size] = util::playfxontag(localclientnum, level._effect[#"hash_b6e7f724af1ad5b"], mdl_piece, "tag_fx");
            self.var_d3d4a7c6[localclientnum][self.var_d3d4a7c6[localclientnum].size] = util::playfxontag(localclientnum, level._effect[#"hash_5239f7431d4c72ca"], mdl_piece, "tag_fx_mouth_05");
            self.var_d3d4a7c6[localclientnum][self.var_d3d4a7c6[localclientnum].size] = util::playfxontag(localclientnum, level._effect[#"hash_5239f7431d4c72ca"], mdl_piece, "tag_fx_mouth_06");
            self.var_d3d4a7c6[localclientnum][self.var_d3d4a7c6[localclientnum].size] = util::playfxontag(localclientnum, level._effect[#"hash_5239f7431d4c72ca"], mdl_piece, "tag_fx_mouth_07");
            self.var_d3d4a7c6[localclientnum][self.var_d3d4a7c6[localclientnum].size] = util::playfxontag(localclientnum, level._effect[#"hash_5239f7431d4c72ca"], mdl_piece, "tag_fx_mouth_08");
            self function_d2e827d2(localclientnum);
        }
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x0
// Checksum 0xac515496, Offset: 0x18b0
// Size: 0x54
function function_d2e827d2(localclientnum) {
    self endon(#"hash_33c72dec301d4a01");
    level waittill(#"demo_jump");
    if (isdefined(self)) {
        self function_37b185f3(localclientnum);
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x0
// Checksum 0x7494a36d, Offset: 0x1910
// Size: 0x116
function function_37b185f3(localclientnum) {
    if (isdefined(self) && isdefined(self.var_98bf1b12[localclientnum])) {
        for (i = 0; i < self.var_98bf1b12[localclientnum].size; i++) {
            killfx(localclientnum, self.var_98bf1b12[localclientnum][i]);
        }
        self.var_98bf1b12[localclientnum] = undefined;
    }
    if (isdefined(self) && isdefined(self.var_d3d4a7c6[localclientnum])) {
        for (i = 0; i < self.var_d3d4a7c6[localclientnum].size; i++) {
            stopfx(localclientnum, self.var_d3d4a7c6[localclientnum][i]);
        }
        self.var_d3d4a7c6[localclientnum] = undefined;
    }
    self notify(#"hash_33c72dec301d4a01");
}

