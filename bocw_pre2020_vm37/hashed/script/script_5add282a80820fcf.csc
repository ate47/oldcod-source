#using scripts\core_common\ai\systems\fx_character;
#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\visionset_mgr_shared;

#namespace mechz;

// Namespace mechz/mechz
// Params 0, eflags: 0x6
// Checksum 0xc489a538, Offset: 0x548
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"mechz", &init, undefined, undefined, undefined);
}

// Namespace mechz/mechz
// Params 0, eflags: 0x1 linked
// Checksum 0xb05b6349, Offset: 0x590
// Size: 0x328
function init() {
    clientfield::register("actor", "mechz_ft", 1, 1, "int", &namespace_e0c51a8c::function_3fb58860, 0, 0);
    clientfield::register("actor", "mechz_faceplate_detached", 1, 1, "int", &namespace_e0c51a8c::function_e7cbec57, 0, 0);
    clientfield::register("actor", "mechz_powercap_detached", 1, 1, "int", &namespace_e0c51a8c::function_e364c573, 0, 0);
    clientfield::register("actor", "mechz_claw_detached", 1, 1, "int", &namespace_e0c51a8c::function_fbdc5222, 0, 0);
    clientfield::register("actor", "mechz_115_gun_firing", 1, 1, "int", &namespace_e0c51a8c::function_b17ecff3, 0, 0);
    clientfield::register("actor", "mechz_headlamp_off", 1, 2, "int", &namespace_e0c51a8c::mechz_headlamp_off, 0, 0);
    clientfield::register("actor", "mechz_long_jump", 1, 1, "counter", &namespace_e0c51a8c::mechz_long_jump, 0, 0);
    clientfield::register("actor", "mechz_jetpack_explosion", 1, 1, "int", &namespace_e0c51a8c::mechz_jetpack_explosion, 0, 0);
    clientfield::register("actor", "mechz_face", 1, 3, "int", &namespace_e0c51a8c::function_624ec357, 0, 0);
    ai::add_archetype_spawn_function(#"mechz", &namespace_e0c51a8c::function_b8b1efcd);
    precache();
    level.var_bfb097e0 = [];
    level.var_bfb097e0[1] = "ai_face_zombie_generic_attack_1";
    level.var_bfb097e0[2] = "ai_face_zombie_generic_death_1";
    level.var_bfb097e0[3] = "ai_face_zombie_generic_idle_1";
    level.var_bfb097e0[4] = "ai_face_zombie_generic_pain_1";
}

// Namespace mechz/mechz
// Params 0, eflags: 0x1 linked
// Checksum 0xc7e75237, Offset: 0x8c0
// Size: 0x244
function precache() {
    level._effect[#"hash_1e6936398caedb41"] = "zm_ai/fx9_mech_wpn_flamethrower";
    level._effect[#"hash_32801ddd989327df"] = "zm_ai/fx9_mech_dmg_armor_face";
    level._effect[#"hash_7ce82c82604705ed"] = "zm_ai/fx9_mech_dmg_armor";
    level._effect[#"hash_7ce82c82604705ed"] = "zm_ai/fx9_mech_dmg_armor";
    level._effect[#"hash_3e338ce8948f836b"] = "zm_ai/fx9_mech_wpn_mltv_muz";
    level._effect[#"hash_7ce82c82604705ed"] = "zm_ai/fx9_mech_dmg_armor";
    level._effect[#"hash_7ce82c82604705ed"] = "zm_ai/fx9_mech_dmg_armor";
    level._effect[#"hash_7ce82c82604705ed"] = "zm_ai/fx9_mech_dmg_armor";
    level._effect[#"hash_7ce82c82604705ed"] = "zm_ai/fx9_mech_dmg_armor";
    level._effect[#"hash_34deead728cd2cbe"] = "zm_ai/fx9_mech_head_light";
    level._effect[#"hash_17c29f528fb7ca60"] = "zm_ai/fx9_mech_dmg_sparks";
    level._effect[#"hash_34bb84802c99ce70"] = "zm_ai/fx9_mech_dmg_knee_sparks";
    level._effect[#"hash_17c29f528fb7ca60"] = "zm_ai/fx9_mech_dmg_sparks";
    level._effect[#"hash_3d292f6ede2dac76"] = "zm_ai/fx9_mech_foot_step";
    level._effect[#"hash_76d9f51aeca015ea"] = "zm_ai/fx9_mech_light_dmg";
    level._effect[#"hash_500cb52978dcca71"] = "zm_ai/fx9_mech_foot_step_steam";
    level._effect[#"hash_3df306b1a5119041"] = "zm_ai/fx9_mech_dmg_body_light";
    level._effect[#"hash_2b72eba2856c6e18"] = "zm_ai/fx9_mech_jetpack_dest";
}

#namespace namespace_e0c51a8c;

// Namespace namespace_e0c51a8c/mechz
// Params 1, eflags: 0x5 linked
// Checksum 0x2857bc73, Offset: 0xb10
// Size: 0xac
function private function_b8b1efcd(localclientnum) {
    self enableonradar();
    level._footstepcbfuncs[self.archetype] = &function_e7aefb0;
    self.var_a0bf769b = util::playfxontag(localclientnum, level._effect[#"hash_34deead728cd2cbe"], self, "tag_headlamp_FX");
    self.var_44ac8cdd = 1;
    fxclientutils::playfxbundle(localclientnum, self, self.fxdef);
}

// Namespace namespace_e0c51a8c/mechz
// Params 5, eflags: 0x1 linked
// Checksum 0xb9d83b92, Offset: 0xbc8
// Size: 0x26e
function function_e7aefb0(localclientnum, pos, *surface, *notetrack, bone) {
    e_player = function_5c10bd79(surface);
    n_dist = distancesquared(notetrack, e_player.origin);
    var_5fe097a = 1000000;
    if (var_5fe097a > 0) {
        n_scale = n_dist / var_5fe097a;
    } else {
        return;
    }
    if (n_scale > 1 || n_scale <= 0) {
        return;
    }
    var_1826041c = (1 - n_scale) * 0.15;
    if (var_1826041c > 0.01) {
        earthquake(surface, var_1826041c, 0.1, notetrack, 1000);
    }
    if (n_scale <= 1 && n_scale > 0.8) {
        e_player playrumbleonentity(surface, "mechz_footstep_heavy");
    } else if (n_scale <= 0.8 && n_scale > 0.4) {
        e_player playrumbleonentity(surface, "mechz_footstep_medium");
    } else {
        e_player playrumbleonentity(surface, "mechz_footstep_light");
    }
    fx = util::playfxontag(surface, level._effect[#"hash_3d292f6ede2dac76"], self, bone);
    if (bone == "j_ball_le") {
        var_cdc96555 = "tag_foot_steam_le";
    } else {
        var_cdc96555 = "tag_foot_steam_ri";
    }
    var_c04ea775 = util::playfxontag(surface, level._effect[#"hash_500cb52978dcca71"], self, var_cdc96555);
}

// Namespace namespace_e0c51a8c/mechz
// Params 7, eflags: 0x5 linked
// Checksum 0x60c7fd5b, Offset: 0xe40
// Size: 0x16a
function private function_3fb58860(localclientnum, *oldvalue, newvalue, *bnewent, *binitialsnap, *fieldname, *wasdemojump) {
    switch (wasdemojump) {
    case 1:
        self.var_755e43c0 = beamlaunch(fieldname, self, "tag_flamethrower_fx", undefined, "none", "flamethrower_beam_3p_zm_mechz");
        self playsound(0, "zmb_ai_mechz_flame_start");
        self.var_28f02418 = self playloopsound("zmb_ai_mechz_flame_loop");
        break;
    case 0:
        self notify(#"hash_3998a66b558348cf");
        if (isdefined(self.var_755e43c0)) {
            beamkill(fieldname, self.var_755e43c0);
            self playsound(0, "zmb_ai_mechz_flame_stop");
            self stoploopsound(self.var_28f02418);
        }
        break;
    }
}

// Namespace namespace_e0c51a8c/mechz
// Params 7, eflags: 0x1 linked
// Checksum 0xf936432c, Offset: 0xfb8
// Size: 0x94
function function_e7cbec57(localclientnum, *oldvalue, *newvalue, *bnewent, *binitialsnap, *fieldname, *wasdemojump) {
    util::playfxontag(wasdemojump, level._effect[#"hash_32801ddd989327df"], self, "j_spine4");
    self playsound(0, "zmb_ai_mechz_faceplate");
}

// Namespace namespace_e0c51a8c/mechz
// Params 7, eflags: 0x1 linked
// Checksum 0x52570eda, Offset: 0x1058
// Size: 0xd2
function function_e364c573(localclientnum, *oldvalue, *newvalue, *bnewent, *binitialsnap, *fieldname, *wasdemojump) {
    util::playfxontag(wasdemojump, level._effect[#"hash_7ce82c82604705ed"], self, "tag_powersupply");
    self playsound(0, "zmb_ai_mechz_destruction");
    self.var_34528362 = util::playfxontag(wasdemojump, level._effect[#"hash_3df306b1a5119041"], self, "tag_powersupply");
}

// Namespace namespace_e0c51a8c/mechz
// Params 7, eflags: 0x1 linked
// Checksum 0x5d10295c, Offset: 0x1138
// Size: 0xfc
function function_fbdc5222(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (isdefined(level.var_88bea78c)) {
        self [[ level.var_88bea78c ]](localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump);
        return;
    }
    util::playfxontag(localclientnum, level._effect[#"hash_7ce82c82604705ed"], self, "tag_gun_spin");
    self playsound(0, "zmb_ai_mechz_destruction");
    util::playfxontag(localclientnum, level._effect[#"hash_17c29f528fb7ca60"], self, "tag_gun_spin");
}

// Namespace namespace_e0c51a8c/mechz
// Params 7, eflags: 0x1 linked
// Checksum 0x87dabe55, Offset: 0x1240
// Size: 0x74
function function_b17ecff3(localclientnum, *oldvalue, *newvalue, *bnewent, *binitialsnap, *fieldname, *wasdemojump) {
    util::playfxontag(wasdemojump, level._effect[#"hash_3e338ce8948f836b"], self, "tag_gun_barrel2");
}

// Namespace namespace_e0c51a8c/mechz
// Params 7, eflags: 0x1 linked
// Checksum 0xf961449c, Offset: 0x12c0
// Size: 0x94
function mechz_jetpack_explosion(localclientnum, *oldvalue, *newvalue, *bnewent, *binitialsnap, *fieldname, *wasdemojump) {
    util::playfxontag(wasdemojump, level._effect[#"hash_2b72eba2856c6e18"], self, "j_spine4");
    self playsound(0, "zmb_ai_mechz_destroy_jetpack");
}

// Namespace namespace_e0c51a8c/mechz
// Params 7, eflags: 0x1 linked
// Checksum 0xf1bc72de, Offset: 0x1360
// Size: 0xd4
function mechz_headlamp_off(localclientnum, *oldvalue, newvalue, *bnewent, *binitialsnap, *fieldname, *wasdemojump) {
    if (self.var_44ac8cdd === 1 && wasdemojump != 0 && isdefined(self.var_a0bf769b)) {
        stopfx(fieldname, self.var_a0bf769b);
        self.var_44ac8cdd = 0;
        if (wasdemojump == 2) {
            util::playfxontag(fieldname, level._effect[#"hash_3d292f6ede2dac76"], self, "tag_headlamp_fx");
        }
    }
}

// Namespace namespace_e0c51a8c/mechz
// Params 7, eflags: 0x5 linked
// Checksum 0xf787e4af, Offset: 0x1440
// Size: 0x74
function private mechz_long_jump(localclientnum, *oldvalue, *newvalue, *bnewent, *binitialsnap, *fieldname, *wasdemojump) {
    earthquake(wasdemojump, 0.5, 1, self.origin, 600, 1);
}

// Namespace namespace_e0c51a8c/mechz
// Params 7, eflags: 0x5 linked
// Checksum 0x7a7ed1c9, Offset: 0x14c0
// Size: 0xfa
function private function_624ec357(localclientnum, *oldvalue, newvalue, *bnewent, *binitialsnap, *fieldname, *wasdemojump) {
    util::waittill_dobj(fieldname);
    if (wasdemojump && isdefined(self)) {
        if (isdefined(self.var_edad38d7)) {
            self clearanim(self.var_edad38d7, 0.2);
        }
        var_fba1a1d5 = level.var_bfb097e0[wasdemojump];
        self setanim(var_fba1a1d5, 1, 0.2, 1);
        self.var_edad38d7 = var_fba1a1d5;
    }
}
