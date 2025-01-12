#using script_5dc2afb89fe97cd0;
#using scripts\core_common\ai\systems\fx_character;
#using scripts\core_common\ai_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\footsteps_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_88795f45;

// Namespace namespace_88795f45/namespace_88795f45
// Params 0, eflags: 0x6
// Checksum 0xedb16588, Offset: 0x2a0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_338a74f5c94ba66a", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 0, eflags: 0x5 linked
// Checksum 0x108ce0e5, Offset: 0x2e8
// Size: 0x184
function private function_70a657d8() {
    clientfield::register("actor", "steiner_radiation_aura_clientfield", 1, 1, "int", &function_10ef7c18, 0, 0);
    clientfield::register("actor", "steiner_radiation_bomb_prepare_fire_clientfield", 1, 1, "int", &function_bc28111c, 0, 0);
    clientfield::register("scriptmover", "radiation_bomb_play_landed_fx", 1, 2, "int", &function_8a3fc4ac, 0, 0);
    clientfield::register("actor", "steiner_split_combine_fx_clientfield", 1, 1, "int", &function_66027924, 0, 0);
    footsteps::registeraitypefootstepcb(#"hash_7c0d83ac1e845ac2", &function_5a53905d);
    ai::add_archetype_spawn_function(#"hash_7c0d83ac1e845ac2", &function_7ec99c76);
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0x9f424635, Offset: 0x478
// Size: 0x14c
function private function_7ec99c76(localclientnum) {
    self enableonradar();
    if (self.var_9fde8624 === #"hash_5653bbc44a034094") {
        util::playfxontag(localclientnum, "zm_ai/fx9_steiner_eyes_glow_sm", self, "J_EyeBall_RI");
        self thread function_59ee055f(localclientnum);
    } else if (self.var_9fde8624 === #"hash_70162f4bc795092") {
        util::playfxontag(localclientnum, "zm_ai/fx9_steiner_eyes_glow_sm", self, "J_EyeBall_LE");
        self thread function_59ee055f(localclientnum);
    } else {
        util::playfxontag(localclientnum, "zm_ai/fx9_steiner_eyes_glow", self, "J_EyeBall_LE");
        fxclientutils::playfxbundle(localclientnum, self, self.fxdef);
        self thread function_8d607c5a(localclientnum);
    }
    self thread function_14dd171f(localclientnum);
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x1 linked
// Checksum 0x45cc7e9c, Offset: 0x5d0
// Size: 0x94
function function_8d607c5a(localclientnum) {
    self playsound(localclientnum, #"hash_13985582064d5e89");
    self.var_5bea7e99 = self playloopsound(#"hash_2353ca5802f38a90", undefined, (0, 0, 50));
    self thread function_c3ae0dcf();
    self thread function_ce1bd3f2(localclientnum);
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x1 linked
// Checksum 0x67b061ab, Offset: 0x670
// Size: 0x44
function function_59ee055f(localclientnum) {
    self thread function_c3ae0dcf();
    self thread function_ce1bd3f2(localclientnum, 1);
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 0, eflags: 0x1 linked
// Checksum 0x1330724c, Offset: 0x6c0
// Size: 0x76
function function_c3ae0dcf() {
    self endon(#"death", #"entitydeleted");
    while (true) {
        s_result = self waittill(#"sndambientbreath");
        self.var_ce0f9600 = int(s_result.active);
    }
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 2, eflags: 0x1 linked
// Checksum 0xb6248a9f, Offset: 0x740
// Size: 0x218
function function_ce1bd3f2(localclientnum, var_eca63392 = 0) {
    if (!isdefined(self.var_ce0f9600)) {
        self.var_ce0f9600 = 1;
    }
    self endon(#"death", #"entitydeleted");
    var_b240b48 = "inhale";
    suffix = "";
    var_4f50b172 = 0.7;
    var_5fbfc988 = 0.8;
    var_7f07b218 = 1.2;
    var_4dfa7e5a = 1.3;
    n_wait_min = var_4f50b172;
    n_wait_max = var_5fbfc988;
    var_d49193ec = #"hash_43accb909782c33";
    if (var_eca63392) {
        var_d49193ec = #"hash_24b7a2e5066beff3";
    }
    while (true) {
        if (self.var_ce0f9600 >= 1) {
            suffix = "";
            n_wait_min = var_4f50b172;
            n_wait_max = var_5fbfc988;
            if (self.var_ce0f9600 >= 2) {
                suffix = "_slow";
                n_wait_min = var_7f07b218;
                n_wait_max = var_4dfa7e5a;
            }
            self playsound(localclientnum, var_d49193ec + var_b240b48 + suffix, self.origin + (0, 0, 75));
            wait randomfloatrange(n_wait_min, n_wait_max);
            if (var_b240b48 === "inhale") {
                var_b240b48 = "exhale";
            } else {
                var_b240b48 = "inhale";
            }
            continue;
        }
        wait 0.1;
    }
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 7, eflags: 0x1 linked
// Checksum 0xc463eb3, Offset: 0x960
// Size: 0x11c
function function_10ef7c18(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump) {
    self util::waittill_dobj(fieldname);
    if (!isdefined(self)) {
        return;
    }
    if (bwasdemojump) {
        self.var_41834f36 = spawn(fieldname, self.origin, "script_model");
        self.var_41834f36 setmodel("tag_origin");
        self.var_91d3e8f2 = util::playfxontag(fieldname, #"hash_536a23796f72b437", self.var_41834f36, "tag_origin");
        self.var_41834f36 linkto(self);
        return;
    }
    self function_2566983f(fieldname);
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0xcc8ef207, Offset: 0xa88
// Size: 0x6e
function private function_2566983f(localclientnum) {
    if (isdefined(self.var_91d3e8f2)) {
        stopfx(localclientnum, self.var_91d3e8f2);
        self.var_91d3e8f2 = undefined;
        if (isdefined(self.var_41834f36)) {
            self.var_41834f36 delete();
            self.var_41834f36 = undefined;
        }
    }
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 7, eflags: 0x0
// Checksum 0x35730ddb, Offset: 0xb00
// Size: 0x74
function function_43c3e59b(localclientnum, *oldvalue, newvalue, *bnewent, *binitialsnap, *fieldname, *wasdemojump) {
    if (wasdemojump && self util::function_50ed1561(fieldname)) {
        self thread function_90825d39(fieldname);
    }
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0xad653741, Offset: 0xb80
// Size: 0xe6
function private function_90825d39(*localclientnum) {
    self notify(#"hash_508cee63b27b3dfe");
    self endon(#"death", #"disconnect", #"hash_508cee63b27b3dfe");
    var_9e38be0 = 1;
    self endoncallback(&function_8e5ed66f, #"death", #"hash_54e6312d7378b65e");
    if (!self postfx::function_556665f2("pstfx_damage_over_time")) {
        self postfx::playpostfxbundle("pstfx_damage_over_time");
    }
    wait var_9e38be0;
    self notify(#"hash_54e6312d7378b65e");
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0x7c7ea03a, Offset: 0xc70
// Size: 0x4c
function private function_8e5ed66f(*notifyhash) {
    if (self postfx::function_556665f2("pstfx_damage_over_time")) {
        self postfx::stoppostfxbundle("pstfx_damage_over_time");
    }
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 7, eflags: 0x1 linked
// Checksum 0x70ddd790, Offset: 0xcc8
// Size: 0x3c
function function_bc28111c(*localclientnum, *oldvalue, *newvalue, *bnewent, *binitialsnap, *fieldname, *wasdemojump) {
    
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 7, eflags: 0x1 linked
// Checksum 0x9d3908c5, Offset: 0xd10
// Size: 0x124
function function_8a3fc4ac(localclientnum, *oldvalue, newvalue, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (!isdefined(self)) {
        return;
    }
    if (isdefined(self.var_1b852a39)) {
        stopfx(fieldname, self.var_1b852a39);
        self.var_1b852a39 = undefined;
    }
    if (bwastimejump == 1) {
        forward = anglestoforward(self.angles);
        up = anglestoup(self.angles);
        self.var_1b852a39 = playfx(fieldname, "zm_ai/fx9_steiner_rad_bomb_circle_128", self.origin + (0, 0, 10), forward, up);
        return;
    }
    if (bwastimejump == 2) {
    }
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 5, eflags: 0x1 linked
// Checksum 0x79bb30b7, Offset: 0xe40
// Size: 0x174
function function_5a53905d(*localclientnum, *pos, *surface, *notetrack, *bone) {
    if (self.var_9fde8624 === #"hash_5653bbc44a034094" || self.var_9fde8624 === #"hash_70162f4bc795092") {
        return;
    }
    /#
        if (isdefined(level.var_53094f02)) {
            return;
        }
    #/
    a_players = getlocalplayers();
    for (i = 0; i < a_players.size; i++) {
        if (abs(self.origin[2] - a_players[i].origin[2]) < 128) {
            var_ed2e93e5 = a_players[i] getlocalclientnumber();
            if (isdefined(var_ed2e93e5)) {
                earthquake(var_ed2e93e5, 0.22, 0.1, self.origin, 1000);
                playrumbleonposition(var_ed2e93e5, "steiner_footsteps", self.origin);
            }
        }
    }
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 7, eflags: 0x1 linked
// Checksum 0xe2925a1a, Offset: 0xfc0
// Size: 0x74
function function_66027924(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump) {
    if (bwasdemojump && isdefined(self)) {
        util::playfxontag(fieldname, "zombie/fx8_red_bathhouse_mirror_glare_loop", self, "j_spineupper");
    }
}

// Namespace namespace_88795f45/namespace_88795f45
// Params 1, eflags: 0x5 linked
// Checksum 0xab99ac5b, Offset: 0x1040
// Size: 0x4c
function private function_14dd171f(localclientnum) {
    self waittill(#"death", #"entitydeleted");
    self function_2566983f(localclientnum);
}

