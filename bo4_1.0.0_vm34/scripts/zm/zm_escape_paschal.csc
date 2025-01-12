#using scripts\core_common\beam_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;

#namespace paschal;

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x0
// Checksum 0x59104365, Offset: 0x198
// Size: 0x80c
function init() {
    var_eaa623ff = getminbitcountfornum(6);
    clientfield::register("scriptmover", "" + #"hash_1f572bbcdde55d9d", 1, 1, "int", &function_b09f8e3a, 0, 0);
    clientfield::register("scriptmover", "" + #"dm_energy", 1, var_eaa623ff, "int", &function_b4de4d5c, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_4bea78fdf78a2613", 1, 1, "int", &function_3e21859f, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_6e2f9a57d1bc4b6a", 1, 1, "int", &function_b1101380, 0, 0);
    clientfield::register("scriptmover", "" + #"ritual_gobo", 1, 1, "int", &function_15aeb47b, 0, 0);
    clientfield::register("scriptmover", "" + #"seagull_fx", 1, 1, "int", &seagull_fx, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_7c708a514455bf88", 1, 1, "int", &function_e86e735a, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_592c96b2803d9fd5", 1, 1, "int", &function_6fec9901, 0, 0);
    clientfield::register("scriptmover", "" + #"summoning_key_glow", 1, 1, "int", &summoning_key_glow, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_2b6e463a7a482630", 1, 1, "counter", &function_1b585287, 0, 0);
    clientfield::register("actor", "" + #"hash_df589cc30f4c7dd", 1, 1, "int", &function_56b838b1, 0, 0);
    clientfield::register("allplayers", "" + #"hash_4f58771e117ee3ee", 1, 1, "int", &function_6d32e208, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_2928b6d60aaacda6", 1, getminbitcountfornum(7), "int", &function_8a14a4fd, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_670a34b297f8faca", 1, 1, "int", &function_64fdb1b8, 0, 0);
    level._effect[#"energy_blue"] = #"hash_5a51f6c91ceb37a5";
    level._effect[#"energy_green"] = #"hash_24e8d0b53e783e64";
    level._effect[#"energy_orange"] = #"hash_5740c7d662846db3";
    level._effect[#"energy_red"] = #"hash_7909599a5d17a4b4";
    level._effect[#"energy_white"] = #"hash_1c2a3285932c7a7e";
    level._effect[#"energy_glow"] = #"hash_390f28af5955af1f";
    level._effect[#"kr_glow"] = #"hash_10198f7ef5535f3a";
    level._effect[#"ritual_gobo"] = #"hash_140f0bd65e4d70d2";
    level._effect[#"hash_180f832f742958d6"] = #"hash_66bb6697a9882bd6";
    level._effect[#"door_explosion"] = #"hash_4fba451426ea3bb7";
    level._effect[#"hash_1a454ca256b757e6"] = #"hash_5028a74e717df332";
    level._effect[#"hash_592c96b2803d9fd5"] = #"hash_2a63b961f5ed2417";
    level._effect[#"hash_6d3840ae2ba64bdd"] = #"hash_362eac491136c198";
    level._effect[#"hash_3959cfb0404cb74a"] = #"hash_5affa48c16d2c319";
    level._effect[#"hash_2928b6d60aaacda6"] = #"hash_271838b9716f9931";
    scene::add_scene_func(#"p8_fxanim_zm_esc_blast_afterlife_seagull_ghost_bundle", &function_41bd01af, "shot_1");
}

// Namespace paschal/zm_escape_paschal
// Params 7, eflags: 0x0
// Checksum 0xfd57f051, Offset: 0x9b0
// Size: 0x25a
function function_b4de4d5c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    self endon(#"death");
    if (isdefined(self.var_4383d80b)) {
        stopfx(localclientnum, self.var_4383d80b);
        self.var_4383d80b = undefined;
    }
    switch (newval) {
    case 1:
        self.var_4383d80b = util::playfxontag(localclientnum, level._effect[#"energy_blue"], self, "tag_origin");
        break;
    case 2:
        self.var_4383d80b = util::playfxontag(localclientnum, level._effect[#"energy_green"], self, "tag_origin");
        break;
    case 3:
        self.var_4383d80b = util::playfxontag(localclientnum, level._effect[#"energy_white"], self, "tag_origin");
        break;
    case 4:
        self.var_4383d80b = util::playfxontag(localclientnum, level._effect[#"energy_orange"], self, "tag_origin");
        break;
    case 5:
        self.var_4383d80b = util::playfxontag(localclientnum, level._effect[#"energy_red"], self, "tag_origin");
        break;
    case 0:
        break;
    default:
        break;
    }
}

// Namespace paschal/zm_escape_paschal
// Params 7, eflags: 0x0
// Checksum 0x3d527fce, Offset: 0xc18
// Size: 0x19c
function function_3e21859f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    s_portal = struct::get(#"hash_4f3ae1de39c4b3e3");
    if (newval == 1) {
        if (!isdefined(s_portal.mdl_portal)) {
            s_portal.mdl_portal = util::spawn_model(localclientnum, "tag_origin", s_portal.origin, s_portal.angles);
        }
        self.mdl_orb = util::spawn_model(localclientnum, "tag_origin", self.origin, self.angles);
        self.var_939ad91b = self beam::launch(s_portal.mdl_portal, "tag_origin", self.mdl_orb, "tag_origin", "beam8_zm_shield_key_ray_targeted");
        return;
    }
    util::playfxontag(localclientnum, level._effect[#"energy_orange"], self.mdl_orb, "tag_origin");
    wait 0.064;
    self.mdl_orb delete();
}

// Namespace paschal/zm_escape_paschal
// Params 7, eflags: 0x0
// Checksum 0x92bc14e5, Offset: 0xdc0
// Size: 0xaa
function function_b1101380(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(self.var_4d48cfd0)) {
        killfx(localclientnum, self.var_4d48cfd0);
    }
    if (newval) {
        self.var_4d48cfd0 = util::playfxontag(localclientnum, level._effect[#"kr_glow"], self, "tag_cover");
    }
}

// Namespace paschal/zm_escape_paschal
// Params 7, eflags: 0x0
// Checksum 0xa22e4338, Offset: 0xe78
// Size: 0xec
function function_15aeb47b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self.n_fx_id = util::playfxontag(localclientnum, level._effect[#"ritual_gobo"], self, "tag_origin");
        wait 1.6;
        util::playfxontag(localclientnum, level._effect[#"hash_180f832f742958d6"], self, "tag_origin");
        return;
    }
    stopfx(localclientnum, self.n_fx_id);
}

// Namespace paschal/zm_escape_paschal
// Params 7, eflags: 0x0
// Checksum 0x8f5572e0, Offset: 0xf70
// Size: 0x154
function seagull_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(self.var_37f668ad)) {
        killfx(localclientnum, self.var_37f668ad);
        self.var_37f668ad = undefined;
    }
    if (isdefined(self.var_997d1c18)) {
        killfx(localclientnum, self.var_997d1c18);
        self.var_997d1c18 = undefined;
    }
    if (newval) {
        self.var_37f668ad = util::playfxontag(localclientnum, level._effect[#"hash_1a454ca256b757e6"], self, "j_wrist_ri");
        self.var_997d1c18 = util::playfxontag(localclientnum, level._effect[#"hash_1a454ca256b757e6"], self, "j_wrist_le");
        self function_98a01e4c(#"hash_24cdaac09819f0e", "Alpha", 1);
    }
}

// Namespace paschal/zm_escape_paschal
// Params 0, eflags: 0x4
// Checksum 0x78a54214, Offset: 0x10d0
// Size: 0xb4
function private function_c1c8a2d7() {
    self playrenderoverridebundle(#"hash_24cdaac09819f0e");
    self function_98a01e4c(#"hash_24cdaac09819f0e", "Brightness", 1);
    self function_98a01e4c(#"hash_24cdaac09819f0e", "Tint", 1);
    self function_98a01e4c(#"hash_24cdaac09819f0e", "Alpha", 1);
}

// Namespace paschal/zm_escape_paschal
// Params 2, eflags: 0x0
// Checksum 0xeccb3b8a, Offset: 0x1190
// Size: 0xec
function function_41bd01af(clientnum, a_ents) {
    a_ents[#"seagull_ghost"] function_c1c8a2d7();
    self playrenderoverridebundle(#"hash_68ee9247aaae4517");
    self function_98a01e4c(#"hash_68ee9247aaae4517", "Brightness", 1);
    self function_98a01e4c(#"hash_68ee9247aaae4517", "Tint", 1);
    self function_98a01e4c(#"hash_68ee9247aaae4517", "Alpha", 1);
}

// Namespace paschal/zm_escape_paschal
// Params 7, eflags: 0x0
// Checksum 0xdf0d2c63, Offset: 0x1288
// Size: 0x1ea
function function_e86e735a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(self.var_1245fb0f)) {
        killfx(localclientnum, self.var_1245fb0f);
        self.var_1245fb0f = undefined;
    }
    if (isdefined(self.var_717f49e6)) {
        killfx(localclientnum, self.var_717f49e6);
        self.var_717f49e6 = undefined;
    }
    if (newval) {
        if (isdefined(level._effect[#"air_blast"])) {
            self.var_1245fb0f = util::playfxontag(localclientnum, level._effect[#"air_blast"], self, "tag_origin");
            mdl_ghost = util::spawn_model(localclientnum, "tag_origin", self.origin + (0, 0, 20), self.angles);
            mdl_ghost scene::play(#"p8_fxanim_zm_esc_blast_afterlife_seagull_ghost_bundle", "shot_1");
            mdl_ghost delete();
        }
        if (isdefined(level._effect[#"hash_1839aae8f96148af"])) {
            self.var_717f49e6 = util::playfxontag(localclientnum, level._effect[#"hash_1839aae8f96148af"], self, "tag_origin");
        }
    }
}

// Namespace paschal/zm_escape_paschal
// Params 7, eflags: 0x0
// Checksum 0xf86f8a3, Offset: 0x1480
// Size: 0x7a
function function_6fec9901(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self.var_8998abcc = util::playfxontag(localclientnum, level._effect[#"hash_592c96b2803d9fd5"], self, "tag_origin");
}

// Namespace paschal/zm_escape_paschal
// Params 7, eflags: 0x0
// Checksum 0x30048401, Offset: 0x1508
// Size: 0x1f6
function function_6d32e208(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_69faecb8 = struct::get("s_p_s4_s_k_ins");
    if (newval) {
        if (!isdefined(self.var_f929ecf4)) {
            self.var_f929ecf4 = util::spawn_model(localclientnum, "tag_origin", var_69faecb8.origin, var_69faecb8.angles);
        }
        if (!isdefined(self.var_815fa541)) {
            self.var_815fa541 = util::spawn_model(localclientnum, "tag_origin", self.origin + (0, 0, 40), self.angles);
            self.var_815fa541 linkto(self, "tag_origin");
        }
        self.var_9a7b77e8 = level beam::launch(self.var_815fa541, "tag_origin", self.var_f929ecf4, "tag_origin", "beam8_zm_shield_key_ray_targeted");
        return;
    }
    level beam::kill(self.var_815fa541, "tag_origin", self.var_f929ecf4, "tag_origin", "beam8_zm_shield_key_ray_targeted");
    self.var_f929ecf4 delete();
    self.var_f929ecf4 = undefined;
    self.var_815fa541 delete();
    self.var_815fa541 = undefined;
    self.var_9a7b77e8 = undefined;
}

// Namespace paschal/zm_escape_paschal
// Params 7, eflags: 0x0
// Checksum 0xc5d7a618, Offset: 0x1708
// Size: 0xaa
function function_b09f8e3a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(self.var_e7063de)) {
        killfx(localclientnum, self.var_e7063de);
    }
    if (newval) {
        self.var_e7063de = util::playfxontag(localclientnum, level._effect[#"hash_6d3840ae2ba64bdd"], self, "tag_origin");
    }
}

// Namespace paschal/zm_escape_paschal
// Params 7, eflags: 0x0
// Checksum 0x693ac819, Offset: 0x17c0
// Size: 0xaa
function summoning_key_glow(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(self.var_4d48cfd0)) {
        killfx(localclientnum, self.var_4d48cfd0);
    }
    if (newval) {
        self.var_4d48cfd0 = util::playfxontag(localclientnum, level._effect[#"hash_3959cfb0404cb74a"], self, "tag_origin");
    }
}

// Namespace paschal/zm_escape_paschal
// Params 7, eflags: 0x0
// Checksum 0xe58fc0b1, Offset: 0x1878
// Size: 0x74
function function_1b585287(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    util::playfxontag(localclientnum, level._effect[#"lightning_dog_spawn"], self, "tag_origin");
}

// Namespace paschal/zm_escape_paschal
// Params 7, eflags: 0x0
// Checksum 0x966f885a, Offset: 0x18f8
// Size: 0x278
function function_8a14a4fd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self.var_bdf43a0c)) {
        self.var_bdf43a0c = [];
    }
    if (!isdefined(self.var_bdf43a0c[localclientnum])) {
        self.var_bdf43a0c[localclientnum] = [];
    }
    if (newval > 0) {
        switch (newval) {
        case 1:
            str_tag = "tag_socket_a";
            break;
        case 2:
            str_tag = "tag_socket_b";
            break;
        case 3:
            str_tag = "tag_socket_c";
            break;
        case 4:
            str_tag = "tag_socket_d";
            break;
        case 5:
            str_tag = "tag_socket_e";
            break;
        case 6:
            str_tag = "tag_socket_f";
            break;
        case 7:
            str_tag = "tag_socket_g";
            break;
        }
        self.var_bdf43a0c[localclientnum][self.var_bdf43a0c[localclientnum].size] = util::playfxontag(localclientnum, level._effect[#"hash_2928b6d60aaacda6"], self, str_tag);
        return;
    }
    if (self.var_bdf43a0c[localclientnum].size) {
        foreach (fx in self.var_bdf43a0c[localclientnum]) {
            deletefx(localclientnum, fx);
        }
        self.var_bdf43a0c[localclientnum] = undefined;
    }
}

// Namespace paschal/zm_escape_paschal
// Params 7, eflags: 0x0
// Checksum 0xc3d66027, Offset: 0x1b78
// Size: 0xa4
function function_56b838b1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_abd5ed3c = util::playfxontag(localclientnum, level._effect[#"energy_blue"], self, "tag_origin");
        return;
    }
    stopfx(localclientnum, self.var_abd5ed3c);
}

// Namespace paschal/zm_escape_paschal
// Params 7, eflags: 0x0
// Checksum 0xcc29c94b, Offset: 0x1c28
// Size: 0xba
function function_64fdb1b8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(self.var_4d48cfd0)) {
        stopfx(localclientnum, self.var_4d48cfd0);
        self.var_4d48cfd0 = undefined;
    }
    if (newval == 1) {
        self.var_4d48cfd0 = util::playfxontag(localclientnum, level._effect[#"spk_glint"], self, "tag_origin");
    }
}

