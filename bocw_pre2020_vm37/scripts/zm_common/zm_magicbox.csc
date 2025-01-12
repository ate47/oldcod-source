#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace zm_magicbox;

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x6
// Checksum 0xec714f49, Offset: 0x1a8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_magicbox", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_magicbox/zm_magicbox
// Params 0, eflags: 0x5 linked
// Checksum 0x6a7a18cb, Offset: 0x1f0
// Size: 0x4ac
function private function_70a657d8() {
    level._effect[#"hash_63f729c169af0c3e"] = #"hash_43a26488c9e5ce57";
    level._effect[#"chest_light_closed"] = #"zombie/fx_weapon_box_closed_glow_zmb";
    level._effect[#"hash_19f4dd97cbb87594"] = #"hash_5f376e9395e16666";
    level._effect[#"fire_runner"] = #"hash_409439bf8b3dd862";
    level._effect[#"hash_6778cbcf34bfebef"] = #"hash_43a26488c9e5ce57";
    level._effect[#"hash_5f2da0ff081c1699"] = #"hash_43a26488c9e5ce57";
    level._effect[#"hash_63697be07cc11490"] = #"hash_4924963a116d71bd";
    level._effect[#"hash_360e9275d6096589"] = #"hash_1bc8b1078984dbda";
    level._effect[#"hash_66be32f919d8b4a4"] = #"hash_53280ae47e5295e0";
    level._effect[#"hash_638a4ec653717ef6"] = #"hash_1a1142d2a6711364";
    level._effect[#"hash_1fa861cbe30adda9"] = #"hash_344ba1202db8c50a";
    clientfield::register("zbarrier", "magicbox_open_fx", 1, 1, "int", &function_8f69e904, 0, 0);
    clientfield::register("zbarrier", "magicbox_closed_fx", 1, 1, "int", &function_9253a233, 0, 0);
    clientfield::register("zbarrier", "magicbox_leave_fx", 1, 1, "counter", &function_68f67f85, 0, 0);
    clientfield::register("zbarrier", "zbarrier_arriving_sounds", 1, 1, "counter", &magicbox_show_sounds_callback, 1, 0);
    clientfield::register("zbarrier", "zbarrier_leaving_sounds", 1, 1, "counter", &magicbox_leave_sounds_callback, 1, 0);
    clientfield::register("zbarrier", "force_stream_magicbox", 1, 1, "int", &force_stream_magicbox, 0, 0);
    clientfield::register("zbarrier", "force_stream_magicbox_leave", 1, 1, "int", &force_stream_magicbox_leave, 0, 0);
    clientfield::register("scriptmover", "force_stream", 1, 1, "int", &force_stream_changed, 0, 0);
    clientfield::register("zbarrier", "" + #"hash_2fcdae6b889933c7", 1, 1, "int", &function_b5807489, 0, 0);
    clientfield::register("zbarrier", "" + #"hash_66b8b96e588ce1ac", 1, 3, "int", &function_abe84c14, 0, 0);
}

// Namespace zm_magicbox/zm_magicbox
// Params 7, eflags: 0x1 linked
// Checksum 0x82f304f0, Offset: 0x6a8
// Size: 0xa4
function force_stream_magicbox(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    var_d80c44f = self zbarriergetpiece(2);
    if (bwastimejump) {
        forcestreamxmodel(var_d80c44f.model);
        return;
    }
    stopforcestreamingxmodel(var_d80c44f.model);
}

// Namespace zm_magicbox/zm_magicbox
// Params 7, eflags: 0x1 linked
// Checksum 0x5a0940dd, Offset: 0x758
// Size: 0xa4
function force_stream_magicbox_leave(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    var_e6289732 = self zbarriergetpiece(1);
    if (bwastimejump) {
        forcestreamxmodel(var_e6289732.model);
        return;
    }
    stopforcestreamingxmodel(var_e6289732.model);
}

// Namespace zm_magicbox/zm_magicbox
// Params 7, eflags: 0x1 linked
// Checksum 0xe4cb26dc, Offset: 0x808
// Size: 0x7c
function force_stream_changed(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        model = self.model;
        if (isdefined(model)) {
            thread stream_model_for_time(fieldname, model, 15);
        }
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 3, eflags: 0x1 linked
// Checksum 0x2a1d55d, Offset: 0x890
// Size: 0x4c
function stream_model_for_time(*localclientnum, model, time) {
    util::lock_model(model);
    wait time;
    util::unlock_model(model);
}

// Namespace zm_magicbox/zm_magicbox
// Params 7, eflags: 0x1 linked
// Checksum 0xa0d42d61, Offset: 0x8e8
// Size: 0x3c
function magicbox_show_sounds_callback(*localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    
}

// Namespace zm_magicbox/zm_magicbox
// Params 7, eflags: 0x1 linked
// Checksum 0xa0ab4e11, Offset: 0x930
// Size: 0x3c
function magicbox_leave_sounds_callback(*localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    
}

// Namespace zm_magicbox/zm_magicbox
// Params 7, eflags: 0x1 linked
// Checksum 0x3a9db52a, Offset: 0x978
// Size: 0x5c
function function_8f69e904(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self thread function_b4b9937(fieldname, bwastimejump, "opened");
}

// Namespace zm_magicbox/zm_magicbox
// Params 7, eflags: 0x1 linked
// Checksum 0xe3702592, Offset: 0x9e0
// Size: 0x5c
function function_9253a233(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self thread function_b4b9937(fieldname, bwastimejump, "closed");
}

// Namespace zm_magicbox/zm_magicbox
// Params 7, eflags: 0x1 linked
// Checksum 0x41edabc8, Offset: 0xa48
// Size: 0x64
function function_68f67f85(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self thread function_b4b9937(bwastimejump, 1, "leave");
}

// Namespace zm_magicbox/zm_magicbox
// Params 3, eflags: 0x1 linked
// Checksum 0x76c0e45d, Offset: 0xab8
// Size: 0x43c
function function_b4b9937(localclientnum, newval, str_state) {
    if (!isdefined(self.var_7e616d59)) {
        self.var_7e616d59 = [];
    }
    if (!isdefined(self.var_93e0dfa9)) {
        self.var_93e0dfa9 = [];
    }
    if (!isdefined(self.var_6bcfabea)) {
        self.var_6bcfabea = [];
    }
    if (localclientnum != 0) {
        return;
    }
    if (isdefined(self)) {
        if (!isdefined(self.var_7e616d59[localclientnum])) {
            var_e0f13b51 = self zbarriergetpiece(2);
            v_tag_origin = var_e0f13b51 gettagorigin("tag_fx");
            v_tag_angles = var_e0f13b51 gettagangles("tag_fx");
            if (!isdefined(v_tag_origin)) {
                v_tag_origin = var_e0f13b51 gettagorigin("tag_origin");
                v_tag_angles = var_e0f13b51 gettagangles("tag_origin");
            }
            if (isdefined(level.var_4016a739)) {
                v_tag_angles += level.var_4016a739;
            }
            var_5b1d3ef = util::spawn_model(localclientnum, #"tag_origin", v_tag_origin, v_tag_angles);
            self.var_7e616d59[localclientnum] = var_5b1d3ef;
            waitframe(1);
        }
        if (isdefined(self) && !isdefined(self.var_93e0dfa9[localclientnum])) {
            v_tag_angles = self.angles;
            if (isdefined(level.var_4016a739)) {
                v_tag_angles += level.var_4016a739;
            }
            fx_obj = util::spawn_model(localclientnum, #"tag_origin", self.origin, v_tag_angles);
            self.var_93e0dfa9[localclientnum] = fx_obj;
            waitframe(1);
        }
        if (isdefined(self) && !isdefined(self.var_ed9e4472)) {
            self.var_ed9e4472 = self zbarriergetpiece(1);
            waitframe(1);
        }
        if (isdefined(self) && (str_state == "opened" || str_state == "closed")) {
            self function_d7e80953(localclientnum, newval, str_state);
            if (newval) {
                switch (str_state) {
                case #"opened":
                    str_fx = level._effect[#"hash_63f729c169af0c3e"];
                    var_4c5fde13 = self.var_7e616d59[localclientnum];
                    str_tag = "tag_origin";
                    break;
                case #"closed":
                    str_fx = level._effect[#"chest_light_closed"];
                    var_4c5fde13 = self.var_93e0dfa9[localclientnum];
                    str_tag = "tag_origin";
                    break;
                }
                if (isdefined(str_fx)) {
                    self.var_37becd64 = str_state;
                    self.var_6bcfabea[localclientnum] = util::playfxontag(localclientnum, str_fx, var_4c5fde13, str_tag);
                    self function_be97e893(localclientnum);
                }
            }
            return;
        }
        if (isdefined(self) && str_state == "leave") {
            util::playfxontag(localclientnum, level._effect[#"hash_19f4dd97cbb87594"], self.var_ed9e4472, "tag_fx");
        }
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 1, eflags: 0x1 linked
// Checksum 0x4b69a09c, Offset: 0xf00
// Size: 0x5c
function function_be97e893(localclientnum) {
    self endon(#"end_demo_jump_listener");
    level waittill(#"demo_jump");
    if (isdefined(self)) {
        self function_d7e80953(localclientnum, 1);
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 3, eflags: 0x1 linked
// Checksum 0x9ff5f305, Offset: 0xf68
// Size: 0xa6
function function_d7e80953(localclientnum, newval, str_state) {
    if (isdefined(self) && isdefined(self.var_6bcfabea[localclientnum])) {
        if (newval || !newval && self.var_37becd64 === str_state) {
            stopfx(localclientnum, self.var_6bcfabea[localclientnum]);
            self.var_6bcfabea[localclientnum] = undefined;
        }
    }
    self notify(#"end_demo_jump_listener");
}

// Namespace zm_magicbox/zm_magicbox
// Params 7, eflags: 0x1 linked
// Checksum 0x9bc4b41f, Offset: 0x1018
// Size: 0x104
function function_b5807489(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (isdefined(self)) {
        if (bwastimejump) {
            mdl_piece = self zbarriergetpiece(1);
            mdl_piece.tag_origin = mdl_piece gettagorigin("tag_origin");
            self.var_788272f2 = util::playfxontag(fieldname, level._effect[#"fire_runner"], mdl_piece, "tag_origin");
            return;
        }
        if (isdefined(self.var_788272f2)) {
            stopfx(fieldname, self.var_788272f2);
        }
    }
}

// Namespace zm_magicbox/zm_magicbox
// Params 7, eflags: 0x1 linked
// Checksum 0x92e734fb, Offset: 0x1128
// Size: 0x332
function function_abe84c14(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    mdl_piece = self zbarriergetpiece(2);
    switch (bwastimejump) {
    case 1:
        self.var_5ad9ac45 = util::playfxontag(fieldname, level._effect[#"hash_6778cbcf34bfebef"], mdl_piece, "tag_origin");
        break;
    case 2:
        self.var_5ad9ac45 = util::playfxontag(fieldname, level._effect[#"hash_5f2da0ff081c1699"], mdl_piece, "tag_origin");
        break;
    case 3:
        self.var_5ad9ac45 = util::playfxontag(fieldname, level._effect[#"hash_63697be07cc11490"], mdl_piece, "tag_origin");
        break;
    case 4:
        self.var_5ad9ac45 = util::playfxontag(fieldname, level._effect[#"hash_360e9275d6096589"], mdl_piece, "tag_origin");
        break;
    case 5:
        self.var_5ad9ac45 = util::playfxontag(fieldname, level._effect[#"hash_66be32f919d8b4a4"], mdl_piece, "tag_origin");
        break;
    case 6:
        self.var_5ad9ac45 = util::playfxontag(fieldname, level._effect[#"hash_638a4ec653717ef6"], mdl_piece, "tag_origin");
        break;
    case 7:
        self.var_5ad9ac45 = util::playfxontag(fieldname, level._effect[#"hash_1fa861cbe30adda9"], mdl_piece, "tag_origin");
        break;
    case 0:
    default:
        if (isdefined(self.var_5ad9ac45)) {
            stopfx(fieldname, self.var_5ad9ac45);
            self.var_5ad9ac45 = undefined;
        }
        break;
    }
}

