#using script_54a67b7ed7b385e6;
#using scripts\core_common\audio_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
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

#namespace zodt8_pap_quest;

// Namespace zodt8_pap_quest/zm_zodt8_pap_quest
// Params 0, eflags: 0x0
// Checksum 0xc967f4ce, Offset: 0x340
// Size: 0x1f4
function init() {
    level._effect[#"hash_711cbb6b36694a2a"] = #"hash_76b535da68eacfe5";
    level._effect[#"hash_2ad6c6017f084d7a"] = #"hash_4e58e9dad90ada6d";
    level._effect[#"hash_23bb6df1e8d8a032"] = #"hash_4f8332385445d967";
    level._effect[#"hash_14d2dc2c31e6dab9"] = #"hash_37e114058b86991a";
    level._effect[#"hash_79b06b6af34ac1ab"] = #"hash_1e30126e06b4956";
    clientfield::register("zbarrier", "pap_chunk_small_rune", 1, getminbitcountfornum(16), "int", &pap_chunk_small_rune, 0, 0);
    clientfield::register("zbarrier", "pap_chunk_big_rune", 1, getminbitcountfornum(5), "int", &pap_chunk_big_rune, 0, 0);
    clientfield::register("zbarrier", "pap_machine_rune", 1, getminbitcountfornum(5), "int", &pap_machine_rune, 0, 0);
}

// Namespace zodt8_pap_quest/zm_zodt8_pap_quest
// Params 7, eflags: 0x0
// Checksum 0x5b741dae, Offset: 0x540
// Size: 0x432
function pap_chunk_big_rune(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self.var_8797e73b)) {
        self.var_8797e73b = [];
    }
    var_3b203e1f = self zbarriergetpiece(0);
    v_forward = anglestoright(self.angles);
    var_3b203e1f hidepart(localclientnum, "j_map_rune_loc_001");
    var_3b203e1f hidepart(localclientnum, "j_map_rune_loc_003");
    var_3b203e1f hidepart(localclientnum, "j_map_rune_loc_002");
    var_3b203e1f hidepart(localclientnum, "j_map_rune_loc_004");
    switch (newval) {
    case 2:
        self.var_8797e73b[localclientnum] = playfx(localclientnum, level._effect[#"hash_711cbb6b36694a2a"], self.origin, v_forward);
        audio::playloopat("zmb_pap_plinth_symbol_lp", self.origin + (0, 0, 70));
        break;
    case 3:
        self.var_8797e73b[localclientnum] = playfx(localclientnum, level._effect[#"hash_2ad6c6017f084d7a"], self.origin, v_forward);
        audio::playloopat("zmb_pap_plinth_symbol_lp", self.origin + (0, 0, 70));
        break;
    case 4:
        self.var_8797e73b[localclientnum] = playfx(localclientnum, level._effect[#"hash_23bb6df1e8d8a032"], self.origin, v_forward);
        audio::playloopat("zmb_pap_plinth_symbol_lp", self.origin + (0, 0, 70));
        break;
    case 5:
        self.var_8797e73b[localclientnum] = playfx(localclientnum, level._effect[#"hash_14d2dc2c31e6dab9"], self.origin, v_forward);
        audio::playloopat("zmb_pap_plinth_symbol_lp", self.origin + (0, 0, 70));
        break;
    case 1:
        audio::stoploopat("zmb_pap_plinth_symbol_lp", self.origin + (0, 0, 70));
        if (isdefined(self.var_8797e73b[localclientnum])) {
            stopfx(localclientnum, self.var_8797e73b[localclientnum]);
            self.var_8797e73b[localclientnum] = undefined;
            playfx(localclientnum, level._effect[#"hash_79b06b6af34ac1ab"], self.origin, v_forward);
        }
        break;
    }
}

// Namespace zodt8_pap_quest/zm_zodt8_pap_quest
// Params 7, eflags: 0x0
// Checksum 0x83bbbfa9, Offset: 0x980
// Size: 0xa4c
function pap_chunk_small_rune(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_3b203e1f = self zbarriergetpiece(0);
    sndorigin = var_3b203e1f gettagorigin("j_map_rune_003");
    switch (newval) {
    case 1:
        var_3b203e1f function_ec4d688(localclientnum, 0, 1);
        var_3b203e1f function_ec4d688(localclientnum, 1, 1);
        var_3b203e1f function_ec4d688(localclientnum, 2, 1);
        var_3b203e1f function_ec4d688(localclientnum, 3, 1);
        playsound(localclientnum, #"hash_3e22cef1a7b16893", var_3b203e1f gettagorigin("j_map_rune_004"));
        break;
    case 2:
        var_3b203e1f function_ec4d688(localclientnum, 0, 0);
        var_3b203e1f function_ec4d688(localclientnum, 1, 1);
        var_3b203e1f function_ec4d688(localclientnum, 2, 1);
        var_3b203e1f function_ec4d688(localclientnum, 3, 1);
        break;
    case 3:
        var_3b203e1f function_ec4d688(localclientnum, 0, 0);
        var_3b203e1f function_ec4d688(localclientnum, 1, 0);
        var_3b203e1f function_ec4d688(localclientnum, 2, 1);
        var_3b203e1f function_ec4d688(localclientnum, 3, 1);
        break;
    case 4:
        var_3b203e1f function_ec4d688(localclientnum, 0, 0);
        var_3b203e1f function_ec4d688(localclientnum, 1, 0);
        var_3b203e1f function_ec4d688(localclientnum, 2, 0);
        var_3b203e1f function_ec4d688(localclientnum, 3, 1);
        break;
    case 5:
        var_3b203e1f function_ec4d688(localclientnum, 0, 0);
        var_3b203e1f function_ec4d688(localclientnum, 1, 0);
        var_3b203e1f function_ec4d688(localclientnum, 2, 1);
        var_3b203e1f function_ec4d688(localclientnum, 3, 0);
        break;
    case 6:
        var_3b203e1f function_ec4d688(localclientnum, 0, 0);
        var_3b203e1f function_ec4d688(localclientnum, 1, 1);
        var_3b203e1f function_ec4d688(localclientnum, 2, 0);
        var_3b203e1f function_ec4d688(localclientnum, 3, 1);
        break;
    case 7:
        var_3b203e1f function_ec4d688(localclientnum, 0, 0);
        var_3b203e1f function_ec4d688(localclientnum, 1, 1);
        var_3b203e1f function_ec4d688(localclientnum, 2, 0);
        var_3b203e1f function_ec4d688(localclientnum, 3, 0);
        break;
    case 8:
        var_3b203e1f function_ec4d688(localclientnum, 0, 0);
        var_3b203e1f function_ec4d688(localclientnum, 1, 1);
        var_3b203e1f function_ec4d688(localclientnum, 2, 1);
        var_3b203e1f function_ec4d688(localclientnum, 3, 0);
        break;
    case 9:
        var_3b203e1f function_ec4d688(localclientnum, 0, 1);
        var_3b203e1f function_ec4d688(localclientnum, 1, 0);
        var_3b203e1f function_ec4d688(localclientnum, 2, 1);
        var_3b203e1f function_ec4d688(localclientnum, 3, 1);
        break;
    case 10:
        var_3b203e1f function_ec4d688(localclientnum, 0, 1);
        var_3b203e1f function_ec4d688(localclientnum, 1, 0);
        var_3b203e1f function_ec4d688(localclientnum, 2, 0);
        var_3b203e1f function_ec4d688(localclientnum, 3, 1);
        break;
    case 11:
        var_3b203e1f function_ec4d688(localclientnum, 0, 1);
        var_3b203e1f function_ec4d688(localclientnum, 1, 0);
        var_3b203e1f function_ec4d688(localclientnum, 2, 0);
        var_3b203e1f function_ec4d688(localclientnum, 3, 0);
        break;
    case 12:
        var_3b203e1f function_ec4d688(localclientnum, 0, 1);
        var_3b203e1f function_ec4d688(localclientnum, 1, 0);
        var_3b203e1f function_ec4d688(localclientnum, 2, 1);
        var_3b203e1f function_ec4d688(localclientnum, 3, 0);
        break;
    case 13:
        var_3b203e1f function_ec4d688(localclientnum, 0, 1);
        var_3b203e1f function_ec4d688(localclientnum, 1, 1);
        var_3b203e1f function_ec4d688(localclientnum, 2, 0);
        var_3b203e1f function_ec4d688(localclientnum, 3, 1);
        break;
    case 14:
        var_3b203e1f function_ec4d688(localclientnum, 0, 1);
        var_3b203e1f function_ec4d688(localclientnum, 1, 1);
        var_3b203e1f function_ec4d688(localclientnum, 2, 0);
        var_3b203e1f function_ec4d688(localclientnum, 3, 0);
        break;
    case 15:
        var_3b203e1f function_ec4d688(localclientnum, 0, 1);
        var_3b203e1f function_ec4d688(localclientnum, 1, 1);
        var_3b203e1f function_ec4d688(localclientnum, 2, 1);
        var_3b203e1f function_ec4d688(localclientnum, 3, 0);
        break;
    case 16:
        var_3b203e1f function_ec4d688(localclientnum, 0, 0);
        var_3b203e1f function_ec4d688(localclientnum, 1, 0);
        var_3b203e1f function_ec4d688(localclientnum, 2, 0);
        var_3b203e1f function_ec4d688(localclientnum, 3, 0);
        break;
    }
    if (newval != 1) {
        playsound(localclientnum, #"hash_291ff1a1ce5cc02f", sndorigin);
    }
}

// Namespace zodt8_pap_quest/zm_zodt8_pap_quest
// Params 3, eflags: 0x0
// Checksum 0x162c8c5c, Offset: 0x13d8
// Size: 0x19a
function function_ec4d688(localclientnum, var_b30ce373, n_state) {
    switch (var_b30ce373) {
    case 0:
        var_a80ee7ca = "j_map_rune_003";
        var_83885826 = "j_map_rune_off_003";
        break;
    case 1:
        var_a80ee7ca = "j_map_rune_004";
        var_83885826 = "j_map_rune_off_004";
        break;
    case 2:
        var_a80ee7ca = "j_map_rune_001";
        var_83885826 = "j_map_rune_off_001";
        break;
    case 3:
        var_a80ee7ca = "j_map_rune_002";
        var_83885826 = "j_map_rune_off_002";
        break;
    }
    switch (n_state) {
    case 0:
        self showpart(localclientnum, var_a80ee7ca);
        self hidepart(localclientnum, var_83885826);
        break;
    case 1:
        self hidepart(localclientnum, var_a80ee7ca);
        self showpart(localclientnum, var_83885826);
        break;
    }
}

// Namespace zodt8_pap_quest/zm_zodt8_pap_quest
// Params 7, eflags: 0x0
// Checksum 0xc370ac0c, Offset: 0x1580
// Size: 0x362
function pap_machine_rune(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_3b203e1f = self zbarriergetpiece(4);
    switch (newval) {
    case 1:
        var_3b203e1f function_b3135748(localclientnum, 0, 2);
        var_3b203e1f function_b3135748(localclientnum, 1, 2);
        var_3b203e1f function_b3135748(localclientnum, 2, 2);
        var_3b203e1f function_b3135748(localclientnum, 3, 2);
        break;
    case 2:
        var_3b203e1f function_b3135748(localclientnum, 0, 0);
        var_3b203e1f function_b3135748(localclientnum, 1, 1);
        var_3b203e1f function_b3135748(localclientnum, 2, 1);
        var_3b203e1f function_b3135748(localclientnum, 3, 1);
        break;
    case 3:
        var_3b203e1f function_b3135748(localclientnum, 0, 1);
        var_3b203e1f function_b3135748(localclientnum, 1, 0);
        var_3b203e1f function_b3135748(localclientnum, 2, 1);
        var_3b203e1f function_b3135748(localclientnum, 3, 1);
        break;
    case 4:
        var_3b203e1f function_b3135748(localclientnum, 0, 1);
        var_3b203e1f function_b3135748(localclientnum, 1, 1);
        var_3b203e1f function_b3135748(localclientnum, 2, 0);
        var_3b203e1f function_b3135748(localclientnum, 3, 1);
        break;
    case 5:
        var_3b203e1f function_b3135748(localclientnum, 0, 1);
        var_3b203e1f function_b3135748(localclientnum, 1, 1);
        var_3b203e1f function_b3135748(localclientnum, 2, 1);
        var_3b203e1f function_b3135748(localclientnum, 3, 0);
        break;
    }
}

// Namespace zodt8_pap_quest/zm_zodt8_pap_quest
// Params 3, eflags: 0x0
// Checksum 0x79d2fb44, Offset: 0x18f0
// Size: 0x1e2
function function_b3135748(localclientnum, var_b30ce373, n_state) {
    switch (var_b30ce373) {
    case 0:
        var_a80ee7ca = "j_machine_rune_003";
        var_83885826 = "j_machine_rune_off_003";
        break;
    case 1:
        var_a80ee7ca = "j_machine_rune_004";
        var_83885826 = "j_machine_rune_off_004";
        break;
    case 2:
        var_a80ee7ca = "j_machine_rune_001";
        var_83885826 = "j_machine_rune_off_001";
        break;
    case 3:
        var_a80ee7ca = "j_machine_rune_002";
        var_83885826 = "j_machine_rune_off_002";
        break;
    }
    switch (n_state) {
    case 0:
        self showpart(localclientnum, var_a80ee7ca);
        self hidepart(localclientnum, var_83885826);
        break;
    case 1:
        self hidepart(localclientnum, var_a80ee7ca);
        self showpart(localclientnum, var_83885826);
        break;
    case 2:
        self hidepart(localclientnum, var_a80ee7ca);
        self hidepart(localclientnum, var_83885826);
        break;
    }
}

