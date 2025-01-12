#using scripts\core_common\ai\archetype_blight_father;
#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\footsteps_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm\weapons\zm_weap_riotshield;
#using scripts\zm_common\zm_grappler;
#using scripts\zm_common\zm_transformation;
#using scripts\zm_common\zm_utility;

#namespace zm_ai_blight_father;

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 0, eflags: 0x2
// Checksum 0x1c101522, Offset: 0x6e8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_ai_blight_father", &__init__, undefined, undefined);
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 0, eflags: 0x0
// Checksum 0xacd86d79, Offset: 0x730
// Size: 0x754
function __init__() {
    level._effect[#"fx8_blightfather_weakspot_sack_amb"] = "zm_ai/fx8_blightfather_weakspot_sack_amb";
    level._effect[#"fx8_blightfather_weakspot_elbow_amb"] = "zm_ai/fx8_blightfather_weakspot_elbow_amb";
    level._effect[#"fx8_blightfather_weakspot_jaw_amb"] = "zm_ai/fx8_blightfather_weakspot_jaw_amb";
    level._effect[#"fx8_plyr_pstfx_vomit_loop"] = "player/fx8_plyr_pstfx_vomit_loop";
    level._effect[#"fx8_blightfather_vomit"] = "zm_ai/fx8_blightfather_vomit";
    level._effect[#"fx8_blightfather_vomit_object"] = "zm_ai/fx8_blightfather_vomit_object";
    level._effect[#"fx8_blightfather_vomit_purchase"] = "zm_ai/fx8_blightfather_vomit_purchase";
    level._effect[#"fx8_blightfather_vomit_statue_purchase"] = "zm_ai/fx8_blightfather_vomit_statue_purchase";
    level._effect[#"fx8_blightfather_vomit_box_purchase"] = "zm_ai/fx8_blightfather_vomit_box_purchase";
    level._effect[#"fx8_blightfather_vomit_craft_purchase"] = "zm_ai/fx8_blightfather_vomit_craft_purchase";
    level._effect[#"fx8_blightfather_maggot_spawn_burst"] = "zm_ai/fx8_blightfather_maggot_spawn_burst";
    level._effect[#"fx8_blightfather_chaos_missle"] = "zm_ai/fx8_blightfather_chaos_missle";
    level._effect[#"fx8_blightfather_maggot_death_exp"] = "zm_ai/fx8_blightfather_maggot_death_exp";
    level.grappler_beam = "zod_blight_father_grapple_beam";
    footsteps::registeraitypefootstepcb("blight_father", &function_ab2416ae);
    clientfield::register("actor", "blight_father_amb_sac_clientfield", 1, 1, "int", &function_1b3c5c27, 0, 0);
    clientfield::register("actor", "blight_father_weakpoint_l_elbow_fx", 1, 1, "int", &function_99017f45, 0, 0);
    clientfield::register("actor", "blight_father_weakpoint_r_elbow_fx", 1, 1, "int", &function_6eb24dac, 0, 0);
    clientfield::register("actor", "blight_father_weakpoint_l_maggot_sac_fx", 1, 1, "int", &function_2578c497, 0, 0);
    clientfield::register("actor", "blight_father_weakpoint_r_maggot_sac_fx", 1, 1, "int", &function_1a8f3d36, 0, 0);
    clientfield::register("actor", "blight_father_weakpoint_jaw_fx", 1, 1, "int", &function_3bd3621f, 0, 0);
    clientfield::register("scriptmover", "blight_father_purchase_lockdown_vomit_fx", 1, 3, "int", &function_69580e3c, 0, 0);
    clientfield::register("toplayer", "tongueGrabPostFx", 1, 1, "int", &tonguegrabpostfx, 0, 0);
    clientfield::register("toplayer", "tongueGrabRumble", 1, 1, "int", &tonguegrabrumble, 0, 0);
    clientfield::register("actor", "blight_father_vomit_fx", 1, 2, "int", &function_68f32a4c, 0, 0);
    clientfield::register("actor", "blight_father_spawn_maggot_fx_left", 1, 1, "counter", &function_6837c297, 0, 0);
    clientfield::register("actor", "blight_father_spawn_maggot_fx_right", 1, 1, "counter", &function_5fa19952, 0, 0);
    clientfield::register("actor", "mtl_blight_father_clientfield", 1, 1, "int", &function_7af4453c, 0, 0);
    clientfield::register("scriptmover", "blight_father_maggot_trail_fx", 1, 1, "int", &function_bde842a9, 0, 0);
    clientfield::register("scriptmover", "blight_father_chaos_missile_explosion_clientfield", 1, 1, "int", &function_d275e1ba, 0, 0);
    clientfield::register("toplayer", "blight_father_chaos_missile_rumble_clientfield", 1, 1, "counter", &function_909bc01, 0, 0);
    clientfield::register("toplayer", "blight_father_vomit_postfx_clientfield", 1, 1, "int", &function_29a624e6, 0, 0);
    clientfield::register("scriptmover", "blight_father_gib_explosion", 1, 1, "int", &function_aa09791d, 0, 0);
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 7, eflags: 0x4
// Checksum 0xd09d5621, Offset: 0xe90
// Size: 0x94
function private function_aa09791d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self util::waittill_dobj(localclientnum);
    if (isdefined(self)) {
        physicsexplosionsphere(localclientnum, self gettagorigin("J_Spine4"), 200, 0, 2);
    }
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 7, eflags: 0x4
// Checksum 0x4b97157b, Offset: 0xf30
// Size: 0xbe
function private function_99017f45(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_28b2033e = util::playfxontag(localclientnum, level._effect[#"fx8_blightfather_weakspot_elbow_amb"], self, "tag_elbow_weakspot_le");
        return;
    }
    if (isdefined(self.var_28b2033e)) {
        stopfx(localclientnum, self.var_28b2033e);
        self.var_28b2033e = undefined;
    }
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 7, eflags: 0x4
// Checksum 0x96f3b367, Offset: 0xff8
// Size: 0xbe
function private function_6eb24dac(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_815958ac = util::playfxontag(localclientnum, level._effect[#"fx8_blightfather_weakspot_elbow_amb"], self, "tag_elbow_weakspot_ri");
        return;
    }
    if (isdefined(self.var_815958ac)) {
        stopfx(localclientnum, self.var_815958ac);
        self.var_815958ac = undefined;
    }
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 7, eflags: 0x4
// Checksum 0xc1ec0c8a, Offset: 0x10c0
// Size: 0xbe
function private function_2578c497(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_e326e938 = util::playfxontag(localclientnum, level._effect[#"fx8_blightfather_weakspot_sack_amb"], self, "tag_eggsack_weakspot_le_fx");
        return;
    }
    if (isdefined(self.var_e326e938)) {
        stopfx(localclientnum, self.var_e326e938);
        self.var_e326e938 = undefined;
    }
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 7, eflags: 0x4
// Checksum 0x13e4e5ff, Offset: 0x1188
// Size: 0xbe
function private function_1a8f3d36(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_6899b6f6 = util::playfxontag(localclientnum, level._effect[#"fx8_blightfather_weakspot_sack_amb"], self, "tag_eggsack_weakspot_ri_fx");
        return;
    }
    if (isdefined(self.var_6899b6f6)) {
        stopfx(localclientnum, self.var_6899b6f6);
        self.var_6899b6f6 = undefined;
    }
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 7, eflags: 0x4
// Checksum 0x12f964a2, Offset: 0x1250
// Size: 0xbe
function private function_3bd3621f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_86c58de1 = util::playfxontag(localclientnum, level._effect[#"fx8_blightfather_weakspot_jaw_amb"], self, "tag_jaw");
        return;
    }
    if (isdefined(self.var_86c58de1)) {
        stopfx(localclientnum, self.var_86c58de1);
        self.var_86c58de1 = undefined;
    }
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 7, eflags: 0x4
// Checksum 0xab7da5ff, Offset: 0x1318
// Size: 0x1ca
function private function_69580e3c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    switch (newval) {
    case 1:
        self.var_2aca00e9 = util::playfxontag(localclientnum, level._effect[#"fx8_blightfather_vomit_purchase"], self, "tag_origin");
        break;
    case 2:
        self.var_2aca00e9 = util::playfxontag(localclientnum, level._effect[#"fx8_blightfather_vomit_statue_purchase"], self, "tag_origin");
        break;
    case 3:
        self.var_2aca00e9 = util::playfxontag(localclientnum, level._effect[#"fx8_blightfather_vomit_box_purchase"], self, "tag_origin");
        break;
    case 4:
        self.var_2aca00e9 = util::playfxontag(localclientnum, level._effect[#"fx8_blightfather_vomit_craft_purchase"], self, "tag_origin");
        break;
    default:
        stopfx(localclientnum, self.var_2aca00e9);
        self.var_2aca00e9 = undefined;
        break;
    }
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 7, eflags: 0x4
// Checksum 0xef270432, Offset: 0x14f0
// Size: 0x84
function private tonguegrabpostfx(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (newvalue) {
        self thread postfx::playpostfxbundle(#"pstfx_zm_tongue_grab");
        return;
    }
    self postfx::stoppostfxbundle("pstfx_zm_tongue_grab");
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 7, eflags: 0x4
// Checksum 0xf4657663, Offset: 0x1580
// Size: 0x114
function private tonguegrabrumble(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (newvalue) {
        if (self function_60dbc438()) {
            function_d2913e3e(localclientnum, "grapple_collision");
            function_74354648(localclientnum, "grapple_reel");
        }
        return;
    }
    if (self function_60dbc438()) {
        function_d2913e3e(localclientnum, "grapple_detach");
        self stoprumble(localclientnum, "grapple_collision");
        self stoprumble(localclientnum, "grapple_reel");
    }
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 7, eflags: 0x4
// Checksum 0xe1ad21c6, Offset: 0x16a0
// Size: 0xfc
function private function_68f32a4c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self.var_e386c4fe = util::playfxontag(localclientnum, level._effect[#"fx8_blightfather_vomit"], self, "tag_jaw");
        return;
    }
    if (newval == 2) {
        self.var_e386c4fe = util::playfxontag(localclientnum, level._effect[#"fx8_blightfather_vomit_object"], self, "tag_jaw");
        return;
    }
    stopfx(localclientnum, self.var_e386c4fe);
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 7, eflags: 0x4
// Checksum 0x744fe692, Offset: 0x17a8
// Size: 0x74
function private function_6837c297(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    util::playfxontag(localclientnum, level._effect[#"fx8_blightfather_maggot_spawn_burst"], self, "tag_sac_fx_le");
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 7, eflags: 0x4
// Checksum 0x372116ee, Offset: 0x1828
// Size: 0x74
function private function_5fa19952(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    util::playfxontag(localclientnum, level._effect[#"fx8_blightfather_maggot_spawn_burst"], self, "tag_sac_fx_ri");
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 7, eflags: 0x4
// Checksum 0x934e6308, Offset: 0x18a8
// Size: 0xc4
function private function_1b3c5c27(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self util::waittill_dobj(localclientnum);
    if (newval) {
        self setanim(#"ai_t8_zm_zod_bltfthr_backsacs_add", 1, 0.1, 1);
        return;
    }
    self clearanim(#"ai_t8_zm_zod_bltfthr_backsacs_add", 0.2);
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 7, eflags: 0x4
// Checksum 0x7c07f7dc, Offset: 0x1978
// Size: 0xb4
function private function_bde842a9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_5d991347 = util::playfxontag(localclientnum, level._effect[#"fx8_blightfather_chaos_missle"], self, "tag_origin");
        return;
    }
    if (isdefined(self.var_5d991347)) {
        stopfx(localclientnum, self.var_5d991347);
    }
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 7, eflags: 0x4
// Checksum 0xbff3a5fc, Offset: 0x1a38
// Size: 0x11c
function private function_d275e1ba(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    position = self.origin;
    angles = self.angles;
    if (isdefined(position) && isdefined(angles)) {
        playfx(localclientnum, level._effect[#"fx8_blightfather_maggot_death_exp"], position, anglestoforward(angles), anglestoup(angles));
        function_e4a51e70(localclientnum, #"hash_7867f8f9aaaa0c40", position);
    }
    earthquake(localclientnum, 0.4, 0.8, self.origin, 300);
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 7, eflags: 0x4
// Checksum 0x2f0e2bc3, Offset: 0x1b60
// Size: 0x5c
function private function_909bc01(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    function_d2913e3e(localclientnum, "damage_heavy");
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 7, eflags: 0x4
// Checksum 0x9de361b9, Offset: 0x1bc8
// Size: 0x74
function private function_7af4453c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 1, 0, 0);
    }
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 5, eflags: 0x0
// Checksum 0x6c3bc486, Offset: 0x1c48
// Size: 0x1bc
function function_ab2416ae(localclientnum, pos, surface, notetrack, bone) {
    e_player = function_f97e7787(localclientnum);
    n_dist = distancesquared(pos, e_player.origin);
    var_21665d39 = 1000000;
    if (var_21665d39 > 0) {
        n_scale = (var_21665d39 - n_dist) / var_21665d39;
    } else {
        return;
    }
    if (n_scale > 1 || n_scale < 0) {
        return;
    }
    n_scale *= 0.25;
    if (n_scale <= 0.01) {
        return;
    }
    earthquake(localclientnum, n_scale, 0.1, pos, n_dist);
    if (n_scale <= 0.25 && n_scale > 0.2) {
        function_d2913e3e(localclientnum, "anim_med");
        return;
    }
    if (n_scale <= 0.2 && n_scale > 0.1) {
        function_d2913e3e(localclientnum, "damage_light");
        return;
    }
    function_d2913e3e(localclientnum, "damage_light");
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 7, eflags: 0x4
// Checksum 0xe6a34e66, Offset: 0x1e10
// Size: 0x13e
function private function_29a624e6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!self zm_utility::function_a96d4c46(localclientnum)) {
        return;
    }
    if (newval) {
        self.var_61a60dcb = playfxoncamera(localclientnum, level._effect[#"fx8_plyr_pstfx_vomit_loop"]);
        self postfx::playpostfxbundle("pstfx_zm_caustic_glob");
        self thread function_fd11c086();
        self notify(#"hash_6bc06e9af30f987");
        return;
    }
    if (isdefined(self.var_61a60dcb)) {
        stopfx(localclientnum, self.var_61a60dcb);
    }
    self postfx::exitpostfxbundle("pstfx_zm_caustic_glob");
    self notify(#"hash_3af6fe8d4a8fac02");
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 0, eflags: 0x0
// Checksum 0x2e4b5047, Offset: 0x1f58
// Size: 0x7c
function function_fd11c086() {
    self notify("504620c9d6a847ad");
    self endon("504620c9d6a847ad");
    self endon(#"death");
    self.var_79591d5f = 0;
    self thread function_96345f97();
    self waittill(#"hash_3af6fe8d4a8fac02");
    wait 1;
    self thread function_431d4a2c();
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 0, eflags: 0x0
// Checksum 0x9260008c, Offset: 0x1fe0
// Size: 0x11c
function function_96345f97() {
    self notify("7c6a053a7d23eb32");
    self endon("7c6a053a7d23eb32");
    self endon(#"death", #"hash_3af6fe8d4a8fac02");
    var_a42f03e4 = 0;
    self playrenderoverridebundle("rob_zm_viewarm_vomit");
    while (!var_a42f03e4) {
        var_42ef91a2 = self.var_79591d5f;
        var_99961383 = min(var_42ef91a2 + 0.05, 1);
        self.var_79591d5f = var_99961383;
        self function_98a01e4c("rob_zm_viewarm_vomit", "Threshold", var_99961383);
        if (var_99961383 >= 1) {
            var_a42f03e4 = 1;
            break;
        }
        wait 0.1;
    }
}

// Namespace zm_ai_blight_father/zm_ai_blight_father
// Params 0, eflags: 0x0
// Checksum 0x139b84b0, Offset: 0x2108
// Size: 0x114
function function_431d4a2c() {
    self notify("12f9592e2a3ac94f");
    self endon("12f9592e2a3ac94f");
    self endon(#"death", #"hash_6bc06e9af30f987");
    var_3a823968 = 0;
    while (!var_3a823968) {
        var_42ef91a2 = self.var_79591d5f;
        var_99961383 = max(var_42ef91a2 - 0.025, 0);
        self.var_79591d5f = var_99961383;
        self function_98a01e4c("rob_zm_viewarm_vomit", "Threshold", var_99961383);
        if (var_99961383 <= 0) {
            self stoprenderoverridebundle("rob_zm_viewarm_vomit");
            var_3a823968 = 1;
            break;
        }
        wait 0.1;
    }
}

