#using script_54a67b7ed7b385e6;
#using scripts\core_common\audio_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\zm\powerup\zm_powerup_bonus_points_team;
#using scripts\zm\powerup\zm_powerup_carpenter;
#using scripts\zm\powerup\zm_powerup_double_points;
#using scripts\zm\powerup\zm_powerup_fire_sale;
#using scripts\zm\powerup\zm_powerup_free_perk;
#using scripts\zm\powerup\zm_powerup_full_ammo;
#using scripts\zm\powerup\zm_powerup_hero_weapon_power;
#using scripts\zm\powerup\zm_powerup_insta_kill;
#using scripts\zm\powerup\zm_powerup_nuke;
#using scripts\zm\weapons\zm_weap_riotshield;
#using scripts\zm\zm_zodt8_eye;
#using scripts\zm\zm_zodt8_gamemodes;
#using scripts\zm\zm_zodt8_pap_quest;
#using scripts\zm\zm_zodt8_sentinel_trial;
#using scripts\zm\zm_zodt8_side_quests;
#using scripts\zm\zm_zodt8_sound;
#using scripts\zm\zm_zodt8_tutorial;
#using scripts\zm_common\load;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_audio_sq;
#using scripts\zm_common\zm_characters;
#using scripts\zm_common\zm_fasttravel;
#using scripts\zm_common\zm_pack_a_punch;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace zm_zodt8;

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x2
// Checksum 0x89346443, Offset: 0x10d0
// Size: 0x32
function autoexec opt_in() {
    level.aat_in_use = 1;
    level.bgb_in_use = 1;
    level.clientfieldaicheck = 1;
}

// Namespace zm_zodt8/level_init
// Params 1, eflags: 0x40
// Checksum 0x3f98ded0, Offset: 0x1110
// Size: 0x63c
function event_handler[level_init] main(eventstruct) {
    clientfield::register("clientuimodel", "player_lives", 1, 2, "int", undefined, 0, 0);
    clientfield::register("vehicle", "pap_projectile_fx", 1, 1, "int", &pap_projectile_fx, 0, 0);
    clientfield::register("vehicle", "pap_projectile_end_fx", 1, 1, "counter", &pap_projectile_end_fx, 0, 0);
    clientfield::register("world", "narrative_trigger", 1, 1, "int", &function_f8e31aee, 0, 0);
    clientfield::register("world", "sfx_waterdrain_fore", 1, 1, "int", &sfx_waterdrain_fore, 0, 0);
    clientfield::register("world", "sfx_waterdrain_aft", 1, 1, "int", &sfx_waterdrain_aft, 0, 0);
    clientfield::register("world", "" + #"hash_16cc25b3f87f06ad", 1, 1, "int", &function_3cb0d2b9, 0, 0);
    clientfield::register("scriptmover", "tilt", 1, 1, "int", &tilt, 0, 0);
    clientfield::register("scriptmover", "change_wave_water_height", 1, 1, "int", &change_wave_water_height, 0, 0);
    clientfield::register("scriptmover", "update_wave_water_height", 1, 1, "counter", &update_wave_water_height, 0, 0);
    clientfield::register("scriptmover", "activate_sentinel_artifact", 1, 2, "int", &sentinel_artifact_activated, 0, 0);
    clientfield::register("scriptmover", "ocean_water", 1, 1, "int", &function_a759bf0b, 0, 0);
    clientfield::register("actor", "sndActorUnderwater", 1, 1, "int", &sndactorunderwater, 0, 1);
    setdvar(#"player_shallowwaterwadescale", 1);
    setdvar(#"player_waistwaterwadescale", 1);
    setdvar(#"player_deepwaterwadescale", 1);
    level._effect[#"headshot"] = #"zombie/fx_bul_flesh_head_fatal_zmb";
    level._effect[#"headshot_nochunks"] = #"zombie/fx_bul_flesh_head_nochunks_zmb";
    level._effect[#"bloodspurt"] = #"zombie/fx_bul_flesh_neck_spurt_zmb";
    level._effect[#"animscript_gib_fx"] = #"zombie/fx_blood_torso_explo_zmb";
    level._effect[#"animscript_gibtrail_fx"] = #"blood/fx_blood_gib_limb_trail";
    level._effect[#"pap_projectile"] = #"hash_6009053e911b946a";
    level._effect[#"pap_projectile_end"] = #"hash_6c0eb029adb5f6c6";
    include_weapons();
    zodt8_pap_quest::init();
    zodt8_sentinel::init();
    namespace_d17fd4ae::init();
    namespace_7890c038::init();
    zm_audio_sq::init();
    load::main();
    init_water();
    init_flags();
    zm_zodt8_sound::main();
    callback::on_localplayer_spawned(&on_localplayer_spawned);
}

// Namespace zm_zodt8/zm_zodt8
// Params 1, eflags: 0x0
// Checksum 0x82af7794, Offset: 0x1758
// Size: 0xc4
function on_localplayer_spawned(localclientnum) {
    e_localplayer = function_f97e7787(localclientnum);
    var_59c97454 = e_localplayer isplayerswimmingunderwater();
    e_localplayer function_c85c2402(localclientnum, var_59c97454);
    if (function_9a47ed7f(localclientnum)) {
        e_localplayer thread function_7ad7dbe2(localclientnum, var_59c97454);
        return;
    }
    e_localplayer thread function_dc3b9b4(localclientnum, var_59c97454);
}

// Namespace zm_zodt8/zm_zodt8
// Params 2, eflags: 0x0
// Checksum 0x1b1b9678, Offset: 0x1828
// Size: 0xf4
function function_7ad7dbe2(localclientnum, var_59c97454) {
    level endon(#"game_ended");
    self endoncallback(&function_91da771a, #"death");
    b_underwater = var_59c97454;
    while (isalive(self)) {
        if (self isplayerswimmingunderwater()) {
            if (!b_underwater) {
                self function_c85c2402(localclientnum, 1);
                b_underwater = 1;
            }
        } else if (b_underwater) {
            self function_c85c2402(localclientnum, 0);
            b_underwater = 0;
        }
        waitframe(1);
    }
}

// Namespace zm_zodt8/zm_zodt8
// Params 2, eflags: 0x0
// Checksum 0x509ab109, Offset: 0x1928
// Size: 0x230
function function_dc3b9b4(localclientnum, var_59c97454) {
    self notify("2eeeeb956bc9a532");
    self endon("2eeeeb956bc9a532");
    level endon(#"game_ended");
    self endoncallback(&function_91da771a, #"death");
    b_underwater = var_59c97454;
    if (isalive(self)) {
        var_d3b19de4 = postfx::function_7348f3a5(#"hash_5249b3ef8b2f1988");
        if (b_underwater) {
            setpbgactivebank(localclientnum, 2);
            if (!var_d3b19de4) {
                self thread postfx::playpostfxbundle(#"hash_5249b3ef8b2f1988");
            }
        } else {
            if (self clientfield::get_to_player("" + #"boiler_fx")) {
                setpbgactivebank(localclientnum, 4);
            } else {
                setpbgactivebank(localclientnum, 1);
            }
            if (var_d3b19de4) {
                self thread postfx::stoppostfxbundle(#"hash_5249b3ef8b2f1988");
            }
        }
    }
    while (isalive(self)) {
        if (b_underwater) {
            self waittill(#"underwater_end");
            self function_c85c2402(localclientnum, 0);
            b_underwater = 0;
            continue;
        }
        self waittill(#"underwater_begin");
        self function_c85c2402(localclientnum, 1);
        b_underwater = 1;
    }
}

// Namespace zm_zodt8/zm_zodt8
// Params 2, eflags: 0x0
// Checksum 0x79377ace, Offset: 0x1b60
// Size: 0x124
function function_c85c2402(localclientnum, b_underwater) {
    if (b_underwater) {
        setpbgactivebank(localclientnum, 2);
        self thread postfx::playpostfxbundle(#"hash_5249b3ef8b2f1988");
        setsoundcontext("water_global", "under");
        return;
    }
    if (self clientfield::get_to_player("" + #"boiler_fx")) {
        setpbgactivebank(localclientnum, 4);
    } else {
        setpbgactivebank(localclientnum, 1);
    }
    self thread postfx::stoppostfxbundle(#"hash_5249b3ef8b2f1988");
    setsoundcontext("water_global", "over");
}

// Namespace zm_zodt8/zm_zodt8
// Params 1, eflags: 0x0
// Checksum 0x57d0a125, Offset: 0x1c90
// Size: 0x2c
function function_91da771a(str_notify) {
    self thread postfx::stoppostfxbundle(#"hash_5249b3ef8b2f1988");
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x0
// Checksum 0xe5c3b435, Offset: 0x1cc8
// Size: 0x24
function init_flags() {
    level flag::init(#"hash_13dc8f128d50bada");
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x0
// Checksum 0xb98b0141, Offset: 0x1cf8
// Size: 0x24
function include_weapons() {
    zm_weapons::load_weapon_spec_from_table(#"gamedata/weapons/zm/zm_zodt8_weapons.csv", 0);
}

// Namespace zm_zodt8/zm_zodt8
// Params 7, eflags: 0x0
// Checksum 0x3f2cd189, Offset: 0x1d28
// Size: 0x9c
function function_3cb0d2b9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_a5680ae5 = #"hash_d3b7cb6eb2177fb";
    ww_base = getweapon(#"ww_tricannon_t8");
    addzombieboxweapon(ww_base, var_a5680ae5, 0);
}

// Namespace zm_zodt8/zm_zodt8
// Params 7, eflags: 0x0
// Checksum 0x4a452fba, Offset: 0x1dd0
// Size: 0x84
function function_f8e31aee(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        function_a419c9f1(localclientnum, "narrative_room");
        return;
    }
    function_9fb45cd8(localclientnum, "narrative_room");
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x0
// Checksum 0xba32490, Offset: 0x1e60
// Size: 0x74
function init_water() {
    setdvar(#"phys_buoyancy", 1);
    setdvar(#"hash_7016ead6b3c7a246", 1);
    function_4fd774c4("e_wave_water_mid", 3);
}

// Namespace zm_zodt8/zm_zodt8
// Params 7, eflags: 0x0
// Checksum 0x57fe75ba, Offset: 0x1ee0
// Size: 0x17c
function update_wave_water_height(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejum) {
    player = function_f97e7787(localclientnum);
    player endon(#"death");
    player util::waittill_dobj(localclientnum);
    if (!self flag::exists("update_water")) {
        self flag::init("update_water");
    }
    if (self flag::get("update_water")) {
        self thread update_wave_water(localclientnum);
        return;
    }
    var_4f6cc28a = function_cbd0f349(self.origin);
    setwavewaterheight(var_4f6cc28a, self.origin[2]);
    function_4fd774c4(var_4f6cc28a, self.angles[2] * -1);
}

// Namespace zm_zodt8/zm_zodt8
// Params 7, eflags: 0x0
// Checksum 0x606fae9c, Offset: 0x2068
// Size: 0x17c
function change_wave_water_height(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejum) {
    if (newval) {
        if (!self flag::exists("update_water")) {
            self flag::init("update_water");
        }
        self flag::set("update_water");
        if (!self flag::exists("water_drained")) {
            self flag::init("water_drained");
        }
        self update_wave_water(localclientnum);
        if (!self flag::get("water_drained")) {
            self flag::set("water_drained");
        } else {
            self flag::clear("water_drained");
        }
        return;
    }
    self flag::clear("update_water");
}

// Namespace zm_zodt8/zm_zodt8
// Params 1, eflags: 0x0
// Checksum 0x8f5c9247, Offset: 0x21f0
// Size: 0x13c
function update_wave_water(localclientnum) {
    self notify("26863fb5dc0c0ea2");
    self endon("26863fb5dc0c0ea2");
    level endon(#"end_game");
    var_4f6cc28a = function_cbd0f349(self.origin);
    if (!self flag::get("water_drained")) {
        function_5ed2b30d(var_4f6cc28a, (0, 0, -1), 30);
    }
    while (isdefined(self) && self flag::get("update_water")) {
        setwavewaterheight(var_4f6cc28a, self.origin[2]);
        function_4fd774c4(var_4f6cc28a, self.angles[2] * -1);
        waitframe(1);
    }
    function_5ed2b30d(var_4f6cc28a, (0, 0, 0), 0);
}

// Namespace zm_zodt8/zm_zodt8
// Params 7, eflags: 0x0
// Checksum 0x26b8bc17, Offset: 0x2338
// Size: 0x194
function tilt(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self notify("cd72775004eb124");
    self endon("cd72775004eb124");
    if (newval) {
        while (isdefined(self)) {
            set_gravity(25);
            n_pitch = self.angles[0];
            n_yaw = self.angles[1];
            n_roll = self.angles[2];
            function_4bd4bafa(localclientnum, n_pitch);
            function_71d73563(localclientnum, -1 * n_roll);
            function_ffcfc628(localclientnum, -1 * n_yaw);
            waitframe(1);
        }
    }
    setdvar(#"phys_gravity_dir", (0, 0, 1));
    function_4bd4bafa(localclientnum, 0);
    function_71d73563(localclientnum, 0);
    function_ffcfc628(localclientnum, 0);
}

// Namespace zm_zodt8/zm_zodt8
// Params 1, eflags: 0x0
// Checksum 0x71359f1b, Offset: 0x24d8
// Size: 0xf4
function set_gravity(n_wait) {
    if (!isdefined(level.var_5ff43485)) {
        level.var_5ff43485 = n_wait;
    }
    if (level.var_5ff43485 >= n_wait) {
        if (level flag::get(#"hash_13dc8f128d50bada")) {
            return;
        }
        inversion = 1;
        if (level clientfield::get("newtonian_negation")) {
            inversion = -1;
        }
        setdvar(#"phys_gravity_dir", inversion * anglestoup(self.angles));
        level.var_5ff43485 = 0;
        return;
    }
    level.var_5ff43485++;
}

// Namespace zm_zodt8/zm_zodt8
// Params 7, eflags: 0x0
// Checksum 0x872fd8e7, Offset: 0x25d8
// Size: 0xc4
function sfx_waterdrain_fore(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    a_origin = (-5, -5176, 574);
    str_notify = "change_water_height_fore";
    str_suffix = "_fore";
    if (newval) {
        function_858eb1f6(str_suffix, str_notify, a_origin);
        return;
    }
    function_3a4544dc(str_suffix, str_notify, a_origin);
}

// Namespace zm_zodt8/zm_zodt8
// Params 7, eflags: 0x0
// Checksum 0x85ac940f, Offset: 0x26a8
// Size: 0xbc
function sfx_waterdrain_aft(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    a_origin = (0, 1145, 136);
    str_notify = "change_water_height_aft";
    str_suffix = "_aft";
    if (newval) {
        function_858eb1f6(str_suffix, str_notify, a_origin);
        return;
    }
    function_3a4544dc(str_suffix, str_notify, a_origin);
}

// Namespace zm_zodt8/zm_zodt8
// Params 3, eflags: 0x0
// Checksum 0x72a7558a, Offset: 0x2770
// Size: 0x6c
function function_858eb1f6(str_suffix, str_notify, a_origin) {
    level notify(str_notify);
    playsound(0, "zmb_waterdrain_quad_start" + str_suffix, a_origin);
    audio::playloopat("zmb_waterdrain_quad_lp" + str_suffix, a_origin);
}

// Namespace zm_zodt8/zm_zodt8
// Params 3, eflags: 0x0
// Checksum 0x98ffb3f3, Offset: 0x27e8
// Size: 0x6c
function function_3a4544dc(str_suffix, str_notify, a_origin) {
    level notify(str_notify);
    playsound(0, "zmb_waterdrain_quad_end" + str_suffix, a_origin);
    audio::stoploopat("zmb_waterdrain_quad_lp" + str_suffix, a_origin);
}

// Namespace zm_zodt8/zm_zodt8
// Params 7, eflags: 0x0
// Checksum 0x8059ccab, Offset: 0x2860
// Size: 0x134
function pap_projectile_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        if (!isdefined(self.var_ca800a67)) {
            self.var_ca800a67 = util::playfxontag(localclientnum, level._effect[#"pap_projectile"], self, "tag_origin");
        }
        if (!isdefined(self.var_dc93b8d0)) {
            self.var_dc93b8d0 = self playloopsound(#"hash_2ac2bbbfef2face4");
        }
        return;
    }
    if (newval == 0) {
        if (isdefined(self.var_ca800a67)) {
            stopfx(localclientnum, self.var_ca800a67);
        }
        if (isdefined(self.var_dc93b8d0)) {
            self stoploopsound(self.var_dc93b8d0);
        }
    }
}

// Namespace zm_zodt8/zm_zodt8
// Params 7, eflags: 0x0
// Checksum 0xd072ca25, Offset: 0x29a0
// Size: 0x84
function pap_projectile_end_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        util::playfxontag(localclientnum, level._effect[#"pap_projectile_end"], self, "tag_origin");
    }
}

// Namespace zm_zodt8/zm_zodt8
// Params 7, eflags: 0x0
// Checksum 0x60a231c0, Offset: 0x2a30
// Size: 0x2d4
function sentinel_artifact_activated(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self.fx = util::playfxontag(localclientnum, level._effect[#"sentinel_aura"], self, "tag_fx_x_pos");
        self playrenderoverridebundle(#"hash_1589a47f2fdc6c67");
        self.sfx_id = self playloopsound(#"hash_66df9cab2c64f968");
        return;
    }
    if (newval == 2) {
        self stoploopsound(self.sfx_id);
        self playsound(localclientnum, #"hash_75b9c9ad6ebe8af2");
        self stoprenderoverridebundle(#"hash_1589a47f2fdc6c67");
        if (isdefined(self.fx)) {
            stopfx(localclientnum, self.fx);
            self.fx = undefined;
        }
        util::playfxontag(localclientnum, level._effect[#"sentinel_activate"], self, "tag_fx_x_pos");
        while (isdefined(self) && self.model !== #"hash_2c0078538e398b4f") {
            waitframe(1);
        }
        self.fx = util::playfxontag(localclientnum, level._effect[#"sentinel_glow"], self, "tag_fx_x_pos");
        waitframe(1);
        self playrenderoverridebundle(#"hash_111d3e86bf2007e4");
        return;
    }
    if (isdefined(self.fx)) {
        stopfx(localclientnum, self.fx);
        self.fx = undefined;
    }
    self playsound(localclientnum, #"hash_5de064f33e9e49b8");
    self playsound(localclientnum, #"hash_3d8fef5997663b17");
}

// Namespace zm_zodt8/zm_zodt8
// Params 7, eflags: 0x0
// Checksum 0x17ad92cd, Offset: 0x2d10
// Size: 0x94
function sndactorunderwater(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self setsoundentcontext("water", "under");
        return;
    }
    self setsoundentcontext("water", "over");
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x0
// Checksum 0x605be988, Offset: 0x2db0
// Size: 0x1982
function setup_personality_character_exerts() {
    level.exert_sounds[1][#"playerbreathinsound"][0] = "vox_plr_0_exert_inhale_0";
    level.exert_sounds[1][#"playerbreathinsound"][1] = "vox_plr_0_exert_inhale_1";
    level.exert_sounds[1][#"playerbreathinsound"][2] = "vox_plr_0_exert_inhale_2";
    level.exert_sounds[2][#"playerbreathinsound"][0] = "vox_plr_1_exert_inhale_0";
    level.exert_sounds[2][#"playerbreathinsound"][1] = "vox_plr_1_exert_inhale_1";
    level.exert_sounds[2][#"playerbreathinsound"][2] = "vox_plr_1_exert_inhale_2";
    level.exert_sounds[3][#"playerbreathinsound"][0] = "vox_plr_2_exert_inhale_0";
    level.exert_sounds[3][#"playerbreathinsound"][1] = "vox_plr_2_exert_inhale_1";
    level.exert_sounds[3][#"playerbreathinsound"][2] = "vox_plr_2_exert_inhale_2";
    level.exert_sounds[4][#"playerbreathinsound"][0] = "vox_plr_3_exert_inhale_0";
    level.exert_sounds[4][#"playerbreathinsound"][1] = "vox_plr_3_exert_inhale_1";
    level.exert_sounds[4][#"playerbreathinsound"][2] = "vox_plr_3_exert_inhale_2";
    level.exert_sounds[1][#"playerbreathoutsound"][0] = "vox_plr_0_exert_exhale_0";
    level.exert_sounds[1][#"playerbreathoutsound"][1] = "vox_plr_0_exert_exhale_1";
    level.exert_sounds[1][#"playerbreathoutsound"][2] = "vox_plr_0_exert_exhale_2";
    level.exert_sounds[2][#"playerbreathoutsound"][0] = "vox_plr_1_exert_exhale_0";
    level.exert_sounds[2][#"playerbreathoutsound"][1] = "vox_plr_1_exert_exhale_1";
    level.exert_sounds[2][#"playerbreathoutsound"][2] = "vox_plr_1_exert_exhale_2";
    level.exert_sounds[3][#"playerbreathoutsound"][0] = "vox_plr_2_exert_exhale_0";
    level.exert_sounds[3][#"playerbreathoutsound"][1] = "vox_plr_2_exert_exhale_1";
    level.exert_sounds[3][#"playerbreathoutsound"][2] = "vox_plr_2_exert_exhale_2";
    level.exert_sounds[4][#"playerbreathoutsound"][0] = "vox_plr_3_exert_exhale_0";
    level.exert_sounds[4][#"playerbreathoutsound"][1] = "vox_plr_3_exert_exhale_1";
    level.exert_sounds[4][#"playerbreathoutsound"][2] = "vox_plr_3_exert_exhale_2";
    level.exert_sounds[1][#"playerbreathgaspsound"][0] = "vox_plr_0_exert_exhale_0";
    level.exert_sounds[1][#"playerbreathgaspsound"][1] = "vox_plr_0_exert_exhale_1";
    level.exert_sounds[1][#"playerbreathgaspsound"][2] = "vox_plr_0_exert_exhale_2";
    level.exert_sounds[2][#"playerbreathgaspsound"][0] = "vox_plr_1_exert_exhale_0";
    level.exert_sounds[2][#"playerbreathgaspsound"][1] = "vox_plr_1_exert_exhale_1";
    level.exert_sounds[2][#"playerbreathgaspsound"][2] = "vox_plr_1_exert_exhale_2";
    level.exert_sounds[3][#"playerbreathgaspsound"][0] = "vox_plr_2_exert_exhale_0";
    level.exert_sounds[3][#"playerbreathgaspsound"][1] = "vox_plr_2_exert_exhale_1";
    level.exert_sounds[3][#"playerbreathgaspsound"][2] = "vox_plr_2_exert_exhale_2";
    level.exert_sounds[4][#"playerbreathgaspsound"][0] = "vox_plr_3_exert_exhale_0";
    level.exert_sounds[4][#"playerbreathgaspsound"][1] = "vox_plr_3_exert_exhale_1";
    level.exert_sounds[4][#"playerbreathgaspsound"][2] = "vox_plr_3_exert_exhale_2";
    level.exert_sounds[1][#"falldamage"][0] = "vox_plr_0_exert_pain_low_0";
    level.exert_sounds[1][#"falldamage"][1] = "vox_plr_0_exert_pain_low_1";
    level.exert_sounds[1][#"falldamage"][2] = "vox_plr_0_exert_pain_low_2";
    level.exert_sounds[1][#"falldamage"][3] = "vox_plr_0_exert_pain_low_3";
    level.exert_sounds[1][#"falldamage"][4] = "vox_plr_0_exert_pain_low_4";
    level.exert_sounds[1][#"falldamage"][5] = "vox_plr_0_exert_pain_low_5";
    level.exert_sounds[1][#"falldamage"][6] = "vox_plr_0_exert_pain_low_6";
    level.exert_sounds[1][#"falldamage"][7] = "vox_plr_0_exert_pain_low_7";
    level.exert_sounds[2][#"falldamage"][0] = "vox_plr_1_exert_pain_low_0";
    level.exert_sounds[2][#"falldamage"][1] = "vox_plr_1_exert_pain_low_1";
    level.exert_sounds[2][#"falldamage"][2] = "vox_plr_1_exert_pain_low_2";
    level.exert_sounds[2][#"falldamage"][3] = "vox_plr_1_exert_pain_low_3";
    level.exert_sounds[2][#"falldamage"][4] = "vox_plr_1_exert_pain_low_4";
    level.exert_sounds[2][#"falldamage"][5] = "vox_plr_1_exert_pain_low_5";
    level.exert_sounds[2][#"falldamage"][6] = "vox_plr_1_exert_pain_low_6";
    level.exert_sounds[2][#"falldamage"][7] = "vox_plr_1_exert_pain_low_7";
    level.exert_sounds[3][#"falldamage"][0] = "vox_plr_2_exert_pain_low_0";
    level.exert_sounds[3][#"falldamage"][1] = "vox_plr_2_exert_pain_low_1";
    level.exert_sounds[3][#"falldamage"][2] = "vox_plr_2_exert_pain_low_2";
    level.exert_sounds[3][#"falldamage"][3] = "vox_plr_2_exert_pain_low_3";
    level.exert_sounds[3][#"falldamage"][4] = "vox_plr_2_exert_pain_low_4";
    level.exert_sounds[3][#"falldamage"][5] = "vox_plr_2_exert_pain_low_5";
    level.exert_sounds[3][#"falldamage"][6] = "vox_plr_2_exert_pain_low_6";
    level.exert_sounds[3][#"falldamage"][7] = "vox_plr_2_exert_pain_low_7";
    level.exert_sounds[4][#"falldamage"][0] = "vox_plr_3_exert_pain_low_0";
    level.exert_sounds[4][#"falldamage"][1] = "vox_plr_3_exert_pain_low_1";
    level.exert_sounds[4][#"falldamage"][2] = "vox_plr_3_exert_pain_low_2";
    level.exert_sounds[4][#"falldamage"][3] = "vox_plr_3_exert_pain_low_3";
    level.exert_sounds[4][#"falldamage"][4] = "vox_plr_3_exert_pain_low_4";
    level.exert_sounds[4][#"falldamage"][5] = "vox_plr_3_exert_pain_low_5";
    level.exert_sounds[4][#"falldamage"][6] = "vox_plr_3_exert_pain_low_6";
    level.exert_sounds[4][#"falldamage"][7] = "vox_plr_3_exert_pain_low_7";
    level.exert_sounds[1][#"mantlesoundplayer"][0] = "vox_plr_0_exert_grunt_0";
    level.exert_sounds[1][#"mantlesoundplayer"][1] = "vox_plr_0_exert_grunt_1";
    level.exert_sounds[1][#"mantlesoundplayer"][2] = "vox_plr_0_exert_grunt_2";
    level.exert_sounds[1][#"mantlesoundplayer"][3] = "vox_plr_0_exert_grunt_3";
    level.exert_sounds[1][#"mantlesoundplayer"][4] = "vox_plr_0_exert_grunt_4";
    level.exert_sounds[1][#"mantlesoundplayer"][5] = "vox_plr_0_exert_grunt_5";
    level.exert_sounds[1][#"mantlesoundplayer"][6] = "vox_plr_0_exert_grunt_6";
    level.exert_sounds[2][#"mantlesoundplayer"][0] = "vox_plr_1_exert_grunt_0";
    level.exert_sounds[2][#"mantlesoundplayer"][1] = "vox_plr_1_exert_grunt_1";
    level.exert_sounds[2][#"mantlesoundplayer"][2] = "vox_plr_1_exert_grunt_2";
    level.exert_sounds[2][#"mantlesoundplayer"][3] = "vox_plr_1_exert_grunt_3";
    level.exert_sounds[2][#"mantlesoundplayer"][4] = "vox_plr_1_exert_grunt_4";
    level.exert_sounds[2][#"mantlesoundplayer"][5] = "vox_plr_1_exert_grunt_5";
    level.exert_sounds[2][#"mantlesoundplayer"][6] = "vox_plr_1_exert_grunt_6";
    level.exert_sounds[3][#"mantlesoundplayer"][0] = "vox_plr_2_exert_grunt_0";
    level.exert_sounds[3][#"mantlesoundplayer"][1] = "vox_plr_2_exert_grunt_1";
    level.exert_sounds[3][#"mantlesoundplayer"][2] = "vox_plr_2_exert_grunt_2";
    level.exert_sounds[3][#"mantlesoundplayer"][3] = "vox_plr_2_exert_grunt_3";
    level.exert_sounds[3][#"mantlesoundplayer"][4] = "vox_plr_2_exert_grunt_4";
    level.exert_sounds[3][#"mantlesoundplayer"][5] = "vox_plr_2_exert_grunt_5";
    level.exert_sounds[3][#"mantlesoundplayer"][6] = "vox_plr_2_exert_grunt_6";
    level.exert_sounds[4][#"mantlesoundplayer"][0] = "vox_plr_3_exert_grunt_0";
    level.exert_sounds[4][#"mantlesoundplayer"][1] = "vox_plr_3_exert_grunt_1";
    level.exert_sounds[4][#"mantlesoundplayer"][2] = "vox_plr_3_exert_grunt_2";
    level.exert_sounds[4][#"mantlesoundplayer"][3] = "vox_plr_3_exert_grunt_3";
    level.exert_sounds[4][#"mantlesoundplayer"][4] = "vox_plr_3_exert_grunt_4";
    level.exert_sounds[4][#"mantlesoundplayer"][5] = "vox_plr_3_exert_grunt_5";
    level.exert_sounds[4][#"mantlesoundplayer"][6] = "vox_plr_3_exert_grunt_6";
    level.exert_sounds[1][#"meleeswipesoundplayer"][0] = "vox_plr_0_exert_knife_swipe_0";
    level.exert_sounds[1][#"meleeswipesoundplayer"][1] = "vox_plr_0_exert_knife_swipe_1";
    level.exert_sounds[1][#"meleeswipesoundplayer"][2] = "vox_plr_0_exert_knife_swipe_2";
    level.exert_sounds[1][#"meleeswipesoundplayer"][3] = "vox_plr_0_exert_knife_swipe_3";
    level.exert_sounds[1][#"meleeswipesoundplayer"][4] = "vox_plr_0_exert_knife_swipe_4";
    level.exert_sounds[1][#"meleeswipesoundplayer"][5] = "vox_plr_0_exert_knife_swipe_5";
    level.exert_sounds[2][#"meleeswipesoundplayer"][0] = "vox_plr_1_exert_knife_swipe_0";
    level.exert_sounds[2][#"meleeswipesoundplayer"][1] = "vox_plr_1_exert_knife_swipe_1";
    level.exert_sounds[2][#"meleeswipesoundplayer"][2] = "vox_plr_1_exert_knife_swipe_2";
    level.exert_sounds[2][#"meleeswipesoundplayer"][3] = "vox_plr_1_exert_knife_swipe_3";
    level.exert_sounds[2][#"meleeswipesoundplayer"][4] = "vox_plr_1_exert_knife_swipe_4";
    level.exert_sounds[2][#"meleeswipesoundplayer"][5] = "vox_plr_1_exert_knife_swipe_5";
    level.exert_sounds[3][#"meleeswipesoundplayer"][0] = "vox_plr_2_exert_knife_swipe_0";
    level.exert_sounds[3][#"meleeswipesoundplayer"][1] = "vox_plr_2_exert_knife_swipe_1";
    level.exert_sounds[3][#"meleeswipesoundplayer"][2] = "vox_plr_2_exert_knife_swipe_2";
    level.exert_sounds[3][#"meleeswipesoundplayer"][3] = "vox_plr_2_exert_knife_swipe_3";
    level.exert_sounds[3][#"meleeswipesoundplayer"][4] = "vox_plr_2_exert_knife_swipe_4";
    level.exert_sounds[3][#"meleeswipesoundplayer"][5] = "vox_plr_2_exert_knife_swipe_5";
    level.exert_sounds[4][#"meleeswipesoundplayer"][0] = "vox_plr_3_exert_knife_swipe_0";
    level.exert_sounds[4][#"meleeswipesoundplayer"][1] = "vox_plr_3_exert_knife_swipe_1";
    level.exert_sounds[4][#"meleeswipesoundplayer"][2] = "vox_plr_3_exert_knife_swipe_2";
    level.exert_sounds[4][#"meleeswipesoundplayer"][3] = "vox_plr_3_exert_knife_swipe_3";
    level.exert_sounds[4][#"meleeswipesoundplayer"][4] = "vox_plr_3_exert_knife_swipe_4";
    level.exert_sounds[4][#"meleeswipesoundplayer"][5] = "vox_plr_3_exert_knife_swipe_5";
    level.exert_sounds[1][#"dtplandsoundplayer"][0] = "vox_plr_0_exert_pain_medium_0";
    level.exert_sounds[1][#"dtplandsoundplayer"][1] = "vox_plr_0_exert_pain_medium_1";
    level.exert_sounds[1][#"dtplandsoundplayer"][2] = "vox_plr_0_exert_pain_medium_2";
    level.exert_sounds[1][#"dtplandsoundplayer"][3] = "vox_plr_0_exert_pain_medium_3";
    level.exert_sounds[2][#"dtplandsoundplayer"][0] = "vox_plr_1_exert_pain_medium_0";
    level.exert_sounds[2][#"dtplandsoundplayer"][1] = "vox_plr_1_exert_pain_medium_1";
    level.exert_sounds[2][#"dtplandsoundplayer"][2] = "vox_plr_1_exert_pain_medium_2";
    level.exert_sounds[2][#"dtplandsoundplayer"][3] = "vox_plr_1_exert_pain_medium_3";
    level.exert_sounds[3][#"dtplandsoundplayer"][0] = "vox_plr_2_exert_pain_medium_0";
    level.exert_sounds[3][#"dtplandsoundplayer"][1] = "vox_plr_2_exert_pain_medium_1";
    level.exert_sounds[3][#"dtplandsoundplayer"][2] = "vox_plr_2_exert_pain_medium_2";
    level.exert_sounds[3][#"dtplandsoundplayer"][3] = "vox_plr_2_exert_pain_medium_3";
    level.exert_sounds[4][#"dtplandsoundplayer"][0] = "vox_plr_3_exert_pain_medium_0";
    level.exert_sounds[4][#"dtplandsoundplayer"][1] = "vox_plr_3_exert_pain_medium_1";
    level.exert_sounds[4][#"dtplandsoundplayer"][2] = "vox_plr_3_exert_pain_medium_2";
    level.exert_sounds[4][#"dtplandsoundplayer"][3] = "vox_plr_3_exert_pain_medium_3";
}

// Namespace zm_zodt8/zm_zodt8
// Params 7, eflags: 0x0
// Checksum 0x5efdd970, Offset: 0x4740
// Size: 0x11c
function function_a759bf0b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_cd0d6bc5(4);
    wait 25;
    var_9d16939b = 4;
    n_time = 0;
    var_71f2cbe5 = (4 - 1) / (45 - 25) / 1;
    while (var_9d16939b > 1) {
        n_time += 1;
        var_9d16939b -= var_71f2cbe5;
        function_cd0d6bc5(var_9d16939b);
        wait 1;
    }
    function_cd0d6bc5(1);
}

