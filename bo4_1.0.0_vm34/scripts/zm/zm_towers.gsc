#using script_6334bf874cddcc13;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\zm\ai\zm_ai_elephant;
#using scripts\zm\powerup\zm_powerup_bonus_points_team;
#using scripts\zm\powerup\zm_powerup_carpenter;
#using scripts\zm\powerup\zm_powerup_double_points;
#using scripts\zm\powerup\zm_powerup_fire_sale;
#using scripts\zm\powerup\zm_powerup_free_perk;
#using scripts\zm\powerup\zm_powerup_full_ammo;
#using scripts\zm\powerup\zm_powerup_hero_weapon_power;
#using scripts\zm\powerup\zm_powerup_insta_kill;
#using scripts\zm\powerup\zm_powerup_nuke;
#using scripts\zm\weapons\zm_weap_bowie;
#using scripts\zm\weapons\zm_weap_riotshield;
#using scripts\zm\zm_towers_achievements;
#using scripts\zm\zm_towers_challenges;
#using scripts\zm\zm_towers_crowd;
#using scripts\zm\zm_towers_gamemodes;
#using scripts\zm\zm_towers_main_quest;
#using scripts\zm\zm_towers_narrative;
#using scripts\zm\zm_towers_pap_quest;
#using scripts\zm\zm_towers_player_spawns;
#using scripts\zm\zm_towers_shield;
#using scripts\zm\zm_towers_side_quests;
#using scripts\zm\zm_towers_special_rounds;
#using scripts\zm\zm_towers_ww_quest;
#using scripts\zm\zm_towers_zones;
#using scripts\zm_common\load;
#using scripts\zm_common\util\ai_gladiator_util;
#using scripts\zm_common\util\ai_tiger_util;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_blockers;
#using scripts\zm_common\zm_characters;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_magicbox;
#using scripts\zm_common\zm_pack_a_punch;
#using scripts\zm_common\zm_pack_a_punch_util;
#using scripts\zm_common\zm_round_logic;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_trial_util;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_wallbuy;
#using scripts\zm_common\zm_weapons;
#using scripts\zm_common\zm_zonemgr;

#namespace zm_towers;

// Namespace zm_towers/zm_towers
// Params 0, eflags: 0x2
// Checksum 0x5de973b4, Offset: 0xe88
// Size: 0x7e
function autoexec opt_in() {
    level.aat_in_use = 1;
    level.bgb_in_use = 1;
    level.bgb_machine_count = 2;
    level.random_pandora_box_start = 1;
    setdvar(#"player_usewaterfriction", 0);
    level.var_ab2cfb2f = 0;
    level.zombie_round_start_delay = 0;
}

// Namespace zm_towers/level_init
// Params 1, eflags: 0x40
// Checksum 0x2de6a5de, Offset: 0xf10
// Size: 0x180c
function event_handler[level_init] main(eventstruct) {
    setclearanceceiling(360);
    zm::init_fx();
    clientfield::register("clientuimodel", "player_lives", 1, 2, "int");
    clientfield::register("scriptmover", "zombie_head_pickup_glow", 1, 1, "int");
    clientfield::register("scriptmover", "blue_glow", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"chaos_ball", 1, 1, "int");
    clientfield::register("scriptmover", "sentinel_artifact_fx_mist", 1, 1, "int");
    clientfield::register("world", "crowd_react", 1, 2, "int");
    clientfield::register("world", "crowd_react_boss", 1, 1, "int");
    clientfield::register("toplayer", "snd_crowd_react", 1, 4, "int");
    clientfield::register("world", "special_round_smoke", 1, 1, "int");
    clientfield::register("toplayer", "special_round_camera", 1, 2, "int");
    clientfield::register("world", "brazier_fire_blue", 1, 2, "int");
    clientfield::register("world", "brazier_fire_green", 1, 2, "int");
    clientfield::register("world", "brazier_fire_purple", 1, 2, "int");
    clientfield::register("world", "brazier_fire_red", 1, 2, "int");
    clientfield::register("scriptmover", "head_fire_blue", 1, 1, "int");
    clientfield::register("scriptmover", "head_fire_green", 1, 1, "int");
    clientfield::register("scriptmover", "head_fire_purple", 1, 1, "int");
    clientfield::register("scriptmover", "head_fire_red", 1, 1, "int");
    clientfield::register("scriptmover", "energy_soul", 1, 1, "int");
    clientfield::register("scriptmover", "energy_soul_target", 1, 1, "int");
    clientfield::register("actor", "acid_trap_death_fx", 1, 1, "int");
    clientfield::register("scriptmover", "trap_switch_green", 1, 1, "int");
    clientfield::register("scriptmover", "trap_switch_red", 1, 1, "int");
    clientfield::register("scriptmover", "trap_switch_smoke", 1, 1, "int");
    clientfield::register("toplayer", "acid_trap_postfx", 1, 1, "int");
    clientfield::register("toplayer", "" + #"pickup_dung", 1, 1, "int");
    clientfield::register("toplayer", "" + #"hash_2bbcb9e09bd7bb26", 1, 1, "counter");
    clientfield::register("scriptmover", "entry_gate_dust", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_42cc4bf5e47478c5", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_3b746cf6eec416b2", 1, 1, "int");
    clientfield::register("world", "" + #"hash_584e8f7433246444", 1, 1, "int");
    clientfield::register("world", "" + #"hash_418c1c843450232b", 1, 1, "int");
    clientfield::register("world", "" + #"hash_4d547bf36c6cb2d8", 1, 1, "int");
    clientfield::register("world", "" + #"hash_38ba3ad0902aa355", 1, 1, "int");
    clientfield::register("world", "" + #"hash_24d7233bb17e6558", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_2c6f04d08665dbda", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_2a332df32456c86f", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_48ad84f9cf6a33f0", 1, 1, "counter");
    clientfield::register("zbarrier", "" + #"hash_3974bea828fbf7f7", 1, 1, "int");
    clientfield::register("zbarrier", "" + #"hash_1add6939914df65a", 1, 1, "int");
    clientfield::register("zbarrier", "" + #"hash_5dc6f97e5850e1d1", 1, 1, "int");
    clientfield::register("toplayer", "" + #"ww_quest_earthquake", 1, 1, "counter");
    clientfield::register("world", "" + #"hash_2383fd01b106ced8", 1, 1, "int");
    clientfield::register("world", "" + #"hash_3c58464f16d8a1be", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_6ff3eb2dd0078a51", 1, 1, "counter");
    clientfield::register("world", "" + #"hash_445060dbbf244b04", 1, 1, "int");
    clientfield::register("world", "" + #"hash_a2fb645044ed12e", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_3f79f6da0222ebc2", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_c382c02584ba249", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_273efcc293063e5e", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"fertilizer_smell", 1, 1, "int");
    clientfield::register("world", "" + #"hash_5a3e1454226ef7a4", 1, 1, "int");
    clientfield::register("world", "" + #"hash_73088ea3053b96f1", 1, 1, "int");
    clientfield::register("actor", "" + #"hash_233e31d0c2b47b1b", 1, 1, "int");
    clientfield::register("actor", "" + #"hash_12dfb8249f8212d2", 1, 1, "int");
    clientfield::register("actor", "" + #"hash_17e3041649954b9f", 1, 1, "int");
    clientfield::register("scriptmover", "ra_eyes_beam_fire", 1, 1, "int");
    clientfield::register("scriptmover", "ra_rooftop_eyes_beam_fire", 1, 1, "int");
    clientfield::register("world", "" + #"hash_57c08e5f4792690c", 1, 1, "int");
    clientfield::register("world", "" + #"hash_440f23773f551a48", 1, 1, "int");
    clientfield::register("world", "" + #"hash_4e5e2b411c997804", 1, 1, "int");
    clientfield::register("toplayer", "" + #"maelstrom_initiate", 1, 1, "counter");
    clientfield::register("world", "" + #"maelstrom_initiate_fx", 1, 1, "int");
    clientfield::register("actor", "" + #"hash_451db92b932d90bf", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"maelstrom_conduct", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_1814d4cc1867739c", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_314d3a2e542805c0", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"maelstrom_discharge", 1, 1, "counter");
    clientfield::register("actor", "" + #"maelstrom_death", 1, 1, "counter");
    clientfield::register("toplayer", "" + #"maelstrom_storm", 1, 1, "int");
    clientfield::register("toplayer", "" + #"hash_182c03ff2a21c07c", 1, 1, "counter");
    clientfield::register("toplayer", "" + #"maelstrom_ending", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_23ba00d2f804acc2", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_2407f687f7d24a83", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_5afda864f8b64f5c", 1, 1, "int");
    level.var_f24d2121 = zm_towers_crowd_meter::register("zm_towers_crowd_meter");
    level._effect[#"eye_glow"] = #"zm_ai/fx8_zombie_eye_glow_red";
    level._effect[#"headshot"] = #"zombie/fx_bul_flesh_head_fatal_zmb";
    level._effect[#"headshot_nochunks"] = #"zombie/fx_bul_flesh_head_nochunks_zmb";
    level._effect[#"bloodspurt"] = #"zombie/fx_bul_flesh_neck_spurt_zmb";
    level._effect[#"animscript_gib_fx"] = #"zombie/fx_blood_torso_explo_zmb";
    level._effect[#"animscript_gibtrail_fx"] = #"blood/fx_blood_gib_limb_trail";
    level._effect[#"switch_sparks"] = #"electric/fx8_sparks_burst_dir_sm_orange_os";
    level._effect[#"hash_21167096dfea3409"] = #"hash_b6f89a048c38cf6";
    level.default_start_location = "zone_starting_area_ra";
    level.default_game_mode = "zclassic";
    level.var_3319a3d5 = 2;
    if (!zm_utility::is_standard()) {
        level.round_wait_func = &function_a2d3745e;
    }
    level thread zm_towers_special_rounds::init();
    level.var_a732b3aa = &function_c2cd1f49;
    level.zombiemode_offhand_weapon_give_override = &offhand_weapon_give_override;
    level.var_237b30e2 = &function_7837e42a;
    level._allow_melee_weapon_switching = 1;
    level.zombiemode_reusing_pack_a_punch = 1;
    level.pack_a_punch.custom_power_think = &zm_towers_pap_quest::function_ed66fefd;
    level.var_6a8290be = 0;
    level.use_powerup_volumes = 1;
    level.var_89c18e03 = 1;
    level.var_8a959e57 = &function_ea1f540;
    level._no_vending_machine_auto_collision = 1;
    level.custom_spawner_entry[#"crawl"] = &zm_spawner::function_48cfc7df;
    load::main();
    level.zones = [];
    level.zone_manager_init_func = &zm_towers_zones::zone_init;
    init_zones[0] = "zone_starting_area_ra";
    level thread zm_zonemgr::manage_zones(init_zones);
    level thread function_a6b86e9c();
    level.custom_pandora_show_func = &custom_pandora_show_func;
    level.random_pandora_box_start = 1;
    level.open_chest_location = [];
    level.magic_box_zbarrier_state_func = &zm_magicbox::function_b8398043;
    level.chest_joker_model = "p8_fxanim_zm_zod_magic_box_skull_mod";
    level.chest_joker_custom_movement = &zm_magicbox::function_e4e638c2;
    level thread magicbox_host_migration();
    level thread function_330e032a();
    a_s_boxes = struct::get_array("treasure_chest_use");
    for (i = 0; i < a_s_boxes.size; i++) {
        level.open_chest_location[i] = a_s_boxes[i].script_noteworthy;
    }
    level thread function_b81b2e5f();
    level thread sndfunctions();
    level thread zm_towers_achievements::init();
    level thread zm_towers_crowd::init();
    level thread zm_towers_narrative::init();
    level thread zm_towers_pap_quest::init();
    level thread zm_towers_player_spawns::init();
    level thread zm_towers_zones::init();
    level thread zm_towers_ww_quest::init();
    level thread namespace_c831ca5c::init();
    level.vending_machines_powered_on_at_start = 1;
    level flag::set("power_on");
    level.var_4f18c7cc = #"hash_30a8de8c86fd7103";
    if (!zm_utility::is_standard()) {
        level.var_de91b1b0 = &function_b1280cdf;
        level.custom_door_buy_check = &function_8e1c950;
        level thread function_6bd6724();
    }
    a_t_doors = getentarray("zombie_door", "targetname");
    array::thread_all(a_t_doors, &function_75362ca2);
    /#
        level thread function_1829f9bf();
    #/
    level thread setup_drawbridge();
}

// Namespace zm_towers/zm_towers
// Params 0, eflags: 0x0
// Checksum 0xf0b0176c, Offset: 0x2728
// Size: 0x54
function setup_drawbridge() {
    scene::init("p8_fxanim_zm_towers_drawbridge_bundle");
    level flag::wait_till("connect_odin_zeus_bridge");
    scene::play("p8_fxanim_zm_towers_drawbridge_bundle");
}

// Namespace zm_towers/zm_towers
// Params 0, eflags: 0x0
// Checksum 0xad7a5133, Offset: 0x2788
// Size: 0x4c
function function_b81b2e5f() {
    level flag::wait_till("all_players_spawned");
    array::thread_all(level.chests, &function_d451630d);
}

// Namespace zm_towers/zm_towers
// Params 0, eflags: 0x0
// Checksum 0x3a771c7b, Offset: 0x27e0
// Size: 0x320
function function_d451630d() {
    switch (self.script_noteworthy) {
    case #"tower_a_chest":
        str_exploder = "exp_lgt_magic_box_odin2";
        break;
    case #"tower_b_chest":
        str_exploder = "exp_lgt_magic_box_zeus2";
        break;
    case #"tower_c_chest":
        str_exploder = "exp_lgt_magic_box_danu2";
        break;
    case #"tower_d_chest":
        str_exploder = "exp_lgt_magic_box_ra2";
        break;
    case #"tower_a_lower_chest":
        str_exploder = "exp_lgt_magic_box_odinb";
        break;
    case #"tower_b_lower_chest":
        str_exploder = "exp_lgt_magic_box_zeusb";
        break;
    case #"tower_c_lower_chest":
        str_exploder = "exp_lgt_magic_box_danub";
        break;
    case #"tower_d_lower_chest":
        str_exploder = "exp_lgt_magic_box_rab";
        break;
    case #"ra_odin_tunnel_chest":
        str_exploder = "exp_lgt_magic_box_cat_swt";
        break;
    case #"danu_zeus_tunnel_chest":
        str_exploder = "exp_lgt_magic_box_cat_net";
        break;
    }
    zbarrier = self.zbarrier;
    self flag::init(#"hash_30f92e7370f31c86");
    while (true) {
        str_state = zbarrier zm_magicbox::get_magic_box_zbarrier_state();
        switch (str_state) {
        case #"initial":
            if (!self flag::get(#"hash_30f92e7370f31c86")) {
                self flag::set(#"hash_30f92e7370f31c86");
                exploder::exploder(str_exploder);
            }
            break;
        case #"arriving":
            if (!self flag::get(#"hash_30f92e7370f31c86")) {
                self flag::set(#"hash_30f92e7370f31c86");
                exploder::exploder(str_exploder);
            }
            break;
        case #"away":
            self flag::clear(#"hash_30f92e7370f31c86");
            exploder::stop_exploder(str_exploder);
            break;
        }
        zbarrier waittill(#"zbarrier_state_change");
    }
}

// Namespace zm_towers/zm_towers
// Params 0, eflags: 0x0
// Checksum 0xa92992b1, Offset: 0x2b08
// Size: 0x1d2
function function_a2d3745e() {
    level endon(#"restart_round");
    /#
        level endon(#"kill_round");
        if (getdvarint(#"zombie_rise_test", 0)) {
            level waittill(#"forever");
        }
        if (zm::cheat_enabled(2)) {
            level waittill(#"forever");
        }
        if (getdvarint(#"zombie_default_max", 0) == 0) {
            level waittill(#"forever");
        }
        level thread zm_round_logic::print_zombie_counts();
        level thread zm_round_logic::sndmusiconkillround();
    #/
    level.var_61172f53 = zm_round_logic::get_zombie_count_for_round(level.round_number, level.players.size);
    while (true) {
        var_377730f = zombie_utility::get_current_zombie_count() > 0 || level.zombie_total > 0 || level.intermission;
        if (!var_377730f || level flag::get("end_round_wait")) {
            break;
        }
        wait 1;
    }
    level.var_ab2cfb2f = 0;
}

// Namespace zm_towers/zm_towers
// Params 0, eflags: 0x0
// Checksum 0x6ae46927, Offset: 0x2ce8
// Size: 0xb4
function adjustments_for_solo() {
    if (isdefined(level.is_forever_solo_game) && level.is_forever_solo_game) {
        a_door_buys = getentarray("zombie_door", "targetname");
        array::thread_all(a_door_buys, &door_price_reduction_for_solo);
        a_debris_buys = getentarray("zombie_debris", "targetname");
        array::thread_all(a_debris_buys, &door_price_reduction_for_solo);
    }
}

// Namespace zm_towers/zm_towers
// Params 0, eflags: 0x0
// Checksum 0x2fcc7e, Offset: 0x2da8
// Size: 0xcc
function door_price_reduction_for_solo() {
    if (self.zombie_cost >= 750) {
        self.zombie_cost -= 250;
        if (isdefined(level.var_de91b1b0)) {
            self thread [[ level.var_de91b1b0 ]](self, self.zombie_cost);
            return;
        }
        if (self.targetname == "zombie_door") {
            self zm_utility::set_hint_string(self, "default_buy_door", self.zombie_cost);
            return;
        }
        self zm_utility::set_hint_string(self, "default_buy_debris", self.zombie_cost);
    }
}

// Namespace zm_towers/zm_towers
// Params 0, eflags: 0x0
// Checksum 0x2b6184a2, Offset: 0x2e80
// Size: 0x24
function function_7837e42a() {
    zm_weapons::load_weapon_spec_from_table(#"gamedata/weapons/zm/zm_towers_weapons.csv", 0);
}

// Namespace zm_towers/zm_towers
// Params 0, eflags: 0x0
// Checksum 0xd2408edd, Offset: 0x2eb0
// Size: 0x24
function function_c2cd1f49() {
    zm_loadout::register_tactical_grenade_for_level("zhield_zword_dw", 1);
}

// Namespace zm_towers/zm_towers
// Params 1, eflags: 0x0
// Checksum 0x2d7237cc, Offset: 0x2ee0
// Size: 0xc6
function offhand_weapon_give_override(str_weapon) {
    self endon(#"death");
    if (zm_loadout::is_tactical_grenade(str_weapon) && isdefined(self zm_loadout::get_player_tactical_grenade()) && !self zm_loadout::is_player_tactical_grenade(str_weapon)) {
        self setweaponammoclip(self zm_loadout::get_player_tactical_grenade(), 0);
        self takeweapon(self zm_loadout::get_player_tactical_grenade());
    }
    return false;
}

// Namespace zm_towers/zm_towers
// Params 0, eflags: 0x0
// Checksum 0xe8c39c0f, Offset: 0x2fb0
// Size: 0xac
function sndfunctions() {
    if (zm_utility::is_standard()) {
        level.zmannouncerprefix = "vox_rush_";
    } else {
        level.zmannouncerprefix = "vox_prst_";
    }
    zm_utility::add_sound("zmb_heavy_door_open", "zmb_heavy_door_open");
    level thread setupmusic();
    level thread custom_add_vox();
    level thread init_announcer();
}

// Namespace zm_towers/zm_towers
// Params 0, eflags: 0x0
// Checksum 0x9b14b29b, Offset: 0x3068
// Size: 0x64
function custom_add_vox() {
    zm_audio::loadplayervoicecategories(#"hash_41c3d60c9fdc1c1a");
    zm_audio::loadplayervoicecategories(#"hash_5963a3db3032ab46");
    zm_audio::loadplayervoicecategories(#"hash_54bad987adb5e01d");
}

// Namespace zm_towers/zm_towers
// Params 0, eflags: 0x0
// Checksum 0x55ad0a26, Offset: 0x30d8
// Size: 0xec
function setupmusic() {
    zm_audio::musicstate_create("round_start", 3, "towers_roundstart_1", "towers_roundstart_2", "towers_roundstart_3");
    zm_audio::musicstate_create("round_end", 3, "towers_roundend_1", "towers_roundend_2", "towers_roundend_3");
    zm_audio::musicstate_create("round_start_special", 3, "towers_roundstart_special_1");
    zm_audio::musicstate_create("round_end_special", 3, "towers_roundend_special_1");
    zm_audio::musicstate_create("game_over", 5, "gameover");
}

// Namespace zm_towers/zm_towers
// Params 0, eflags: 0x0
// Checksum 0xb4a485f9, Offset: 0x31d0
// Size: 0xa54
function init_announcer() {
    zm_audio::sndannouncervoxadd(#"hash_5f0f1e699aa7e761", "crowd_positive_general");
    zm_audio::sndannouncervoxadd(#"hash_7ff858c269b8be00", "challenges_danu_slash_0");
    zm_audio::sndannouncervoxadd(#"hash_260c83bb9470b", "challenges_ra_slash_0");
    zm_audio::sndannouncervoxadd(#"hash_78c79ed7fe5a14e6", "challenges_odin_slash_0");
    zm_audio::sndannouncervoxadd(#"hash_2865f19fb8f73873", "challenges_zeus_slash_0");
    zm_audio::sndannouncervoxadd(#"hash_1d17496d06e7c7f6", "challenges_new_available_0");
    zm_audio::sndannouncervoxadd(#"hash_1d174a6d06e7c9a9", "challenges_new_available_1");
    zm_audio::sndannouncervoxadd(#"hash_1d17476d06e7c490", "challenges_new_available_2");
    zm_audio::sndannouncervoxadd(#"hash_1d17486d06e7c643", "challenges_new_available_3");
    zm_audio::sndannouncervoxadd(#"hash_1d174d6d06e7cec2", "challenges_new_available_4");
    zm_audio::sndannouncervoxadd(#"hash_1d174e6d06e7d075", "challenges_new_available_5");
    zm_audio::sndannouncervoxadd(#"hash_1d174b6d06e7cb5c", "challenges_new_available_6");
    zm_audio::sndannouncervoxadd(#"hash_1d174c6d06e7cd0f", "challenges_new_available_7");
    zm_audio::sndannouncervoxadd(#"hash_1d17516d06e7d58e", "challenges_new_available_8");
    zm_audio::sndannouncervoxadd(#"hash_1d17526d06e7d741", "challenges_new_available_9");
    zm_audio::sndannouncervoxadd(#"hash_47b8d1dd75488e20", "challenges_complete_0");
    zm_audio::sndannouncervoxadd(#"hash_47b8d2dd75488fd3", "challenges_complete_1");
    zm_audio::sndannouncervoxadd(#"hash_47b8d3dd75489186", "challenges_complete_2");
    zm_audio::sndannouncervoxadd(#"hash_47b8d4dd75489339", "challenges_complete_3");
    zm_audio::sndannouncervoxadd(#"hash_47b8d5dd754894ec", "challenges_complete_4");
    zm_audio::sndannouncervoxadd(#"hash_47b8d6dd7548969f", "challenges_complete_5");
    zm_audio::sndannouncervoxadd(#"hash_47b8d7dd75489852", "challenges_complete_6");
    zm_audio::sndannouncervoxadd(#"hash_47b8d8dd75489a05", "challenges_complete_7");
    zm_audio::sndannouncervoxadd(#"hash_47b8d9dd75489bb8", "challenges_complete_8");
    zm_audio::sndannouncervoxadd(#"hash_47b8dadd75489d6b", "challenges_complete_9");
    zm_audio::sndannouncervoxadd(#"challenges_danu_completed", "challenges_danu_final_0");
    zm_audio::sndannouncervoxadd(#"challenges_ra_completed", "challenges_ra_final_0");
    zm_audio::sndannouncervoxadd(#"challenges_odin_completed", "challenges_odin_final_0");
    zm_audio::sndannouncervoxadd(#"challenges_zeus_completed", "challenges_zeus_final_0");
    zm_audio::sndannouncervoxadd(#"hash_597c4173f2fd41a4", "challenges_danu_help_0");
    zm_audio::sndannouncervoxadd(#"hash_550bed5125d97a89", "challenges_ra_help_0");
    zm_audio::sndannouncervoxadd(#"hash_31347fc188da1db6", "challenges_odin_help_0");
    zm_audio::sndannouncervoxadd(#"hash_6c9a2587a2563721", "challenges_zeus_help_0");
    zm_audio::sndannouncervoxadd(#"special_round_start", "special_round_start");
    zm_audio::sndannouncervoxadd(#"hash_18134dc5b9b39a96", "pap_quest_danu_tower_0");
    zm_audio::sndannouncervoxadd(#"hash_589679a12150767a", "pap_quest_danu_champ_0");
    zm_audio::sndannouncervoxadd(#"hash_582eea77824b014d", "pap_quest_ra_tower_0");
    zm_audio::sndannouncervoxadd(#"hash_4abb12b14a38d2e9", "pap_quest_ra_champ_0");
    zm_audio::sndannouncervoxadd(#"hash_5cc500f9282cd290", "pap_quest_odin_tower_0");
    zm_audio::sndannouncervoxadd(#"hash_15f5946d4968f144", "pap_quest_odin_champ_0");
    zm_audio::sndannouncervoxadd(#"hash_20c64c155f7a0065", "pap_quest_zeus_tower_0");
    zm_audio::sndannouncervoxadd(#"hash_355567a6fa6d44d1", "pap_quest_zeus_champ_0");
    zm_audio::sndannouncervoxadd(#"pap_quest_completed", "pap_quest_reveal_pap_0");
    zm_audio::sndannouncervoxadd(#"hash_28dbb5b91d8a954e", "imp_jar_pickup_0");
    zm_audio::sndannouncervoxadd(#"hash_3d5fccf222ba3ab6", "m_quest_danu_complete_0");
    zm_audio::sndannouncervoxadd(#"hash_5719edb294612f4c", "m_quest_ra_complete_resp_0");
    zm_audio::sndannouncervoxadd(#"hash_42bbe4989b9a4cbe", "m_quest_zeus_complete_0");
    zm_audio::sndannouncervoxadd(#"hash_41d25c641d7c8484", "m_quest_odin_complete_0");
    zm_audio::sndannouncervoxadd(#"hash_bc10546af7f7b09", "m_quest_chaos_realm_react_0");
    zm_audio::sndannouncervoxadd(#"hash_70f3ffdacf094858", "m_quest_ground_floor_0");
    zm_audio::sndannouncervoxadd(#"hash_5b34919a0ea0ac80", "m_quest_second_floor_0");
    zm_audio::sndannouncervoxadd(#"hash_260067c34ca719ab", "m_quest_ra_sacrifice_0");
    zm_audio::sndannouncervoxadd(#"hash_260066c34ca717f8", "m_quest_ra_sacrifice_1");
    zm_audio::sndannouncervoxadd(#"hash_260069c34ca71d11", "m_quest_ra_sacrifice_2");
    zm_audio::sndannouncervoxadd(#"hash_260068c34ca71b5e", "m_quest_ra_sacrifice_3");
    zm_audio::sndannouncervoxadd(#"hash_412f0a99d31887f", "m_quest_ra_complete_0");
    zm_audio::sndannouncervoxadd(#"hash_73183fb7534361f", "m_quest_storm_spikes_0");
    zm_audio::sndannouncervoxadd(#"hash_6211a32e1a9f23fa", "m_quest_gladiator_round_0");
    zm_audio::sndannouncervoxadd(#"hash_24e22336a0d988d0", "m_quest_body_pit_lock_0");
    zm_audio::sndannouncervoxadd(#"hash_43b0860b33146764", "m_quest_fury_start_0");
    zm_audio::sndannouncervoxadd(#"hash_c8182d04e7f43c9", "m_quest_arrive_0");
    zm_audio::sndannouncervoxadd(#"hash_77080de04389f4df", "m_quest_fury_kill_0");
    zm_audio::sndannouncervoxadd(#"hash_1b8dd2e5977116cb", "m_quest_stage_2_transition_4");
    zm_audio::sndannouncervoxadd(#"hash_436d318af3fd771f", "m_quest_wrath_arrive_0");
    zm_audio::sndannouncervoxadd(#"hash_7e9eb52954a81d6e", "m_quest_wrath_kill_0");
    zm_audio::sndannouncervoxadd(#"hash_7e9eb42954a81bbb", "m_quest_wrath_kill_1");
}

// Namespace zm_towers/zm_towers
// Params 0, eflags: 0x0
// Checksum 0xbc0fde67, Offset: 0x3c30
// Size: 0x2fe
function function_a6b86e9c() {
    level endon(#"end_game");
    vol_arena = getent("vol_arena", "targetname");
    var_53b2b1f6 = array(#"zone_starting_area_tunnel", #"zone_starting_area_center", #"zone_starting_area_danu", #"zone_starting_area_ra", #"zone_starting_area_odin", #"zone_starting_area_zeus", #"zone_danu_hallway", #"zone_ra_hallway", #"zone_odin_hallway", #"zone_zeus_hallway");
    level flag::wait_till("all_players_spawned");
    while (true) {
        wait 1;
        var_512661d5 = 0;
        foreach (e_player in util::get_active_players()) {
            if (e_player zm_zonemgr::is_player_in_zone(var_53b2b1f6)) {
                var_512661d5 = 1;
                break;
            }
        }
        foreach (ai_zombie in getaiarray()) {
            if (!isdefined(ai_zombie.var_1bbb82b6) && isdefined(ai_zombie.b_ignore_cleanup) && ai_zombie.b_ignore_cleanup) {
                continue;
            }
            if (var_512661d5 && ai_zombie istouching(vol_arena)) {
                ai_zombie.b_ignore_cleanup = 1;
                ai_zombie.var_1bbb82b6 = 1;
                continue;
            }
            if (isdefined(ai_zombie.var_1bbb82b6) && ai_zombie.var_1bbb82b6) {
                ai_zombie.var_1bbb82b6 = 0;
                ai_zombie.b_ignore_cleanup = 0;
            }
        }
    }
}

// Namespace zm_towers/zm_towers
// Params 0, eflags: 0x0
// Checksum 0x3ac0d099, Offset: 0x3f38
// Size: 0x4c
function function_330e032a() {
    zm_blockers::function_53852af7("zm_towers_start_boards_open", "script_label");
    zm_blockers::function_53852af7("zm_towers_start_boards_open_hidden", "script_label", 1);
}

// Namespace zm_towers/zm_towers
// Params 3, eflags: 0x0
// Checksum 0x5ca0e0c9, Offset: 0x3f90
// Size: 0x3c
function custom_pandora_show_func(anchor, anchortarget, pieces) {
    if (!isdefined(self.pandora_light)) {
        self thread custom_pandora_fx_func();
    }
}

// Namespace zm_towers/zm_towers
// Params 0, eflags: 0x0
// Checksum 0x1defb3b7, Offset: 0x3fd8
// Size: 0x20c
function custom_pandora_fx_func() {
    self endon(#"death");
    self.pandora_light = spawn("script_model", self.zbarrier.origin);
    s_pandora_fx_pos_override = struct::get(self.target, "targetname");
    if (isdefined(s_pandora_fx_pos_override) && s_pandora_fx_pos_override.script_noteworthy === "pandora_fx_pos_override") {
        self.pandora_light.origin = s_pandora_fx_pos_override.origin;
    }
    self.pandora_light.angles = self.zbarrier.angles + (-90, 0, -90);
    self.pandora_light setmodel(#"tag_origin");
    if (!(isdefined(level._box_initialized) && level._box_initialized)) {
        level flag::wait_till("start_zombie_round_logic");
        level._box_initialized = 1;
    }
    wait 1;
    if (isdefined(self) && isdefined(self.pandora_light)) {
        if (self.zbarrier.script_string === "t8_magicbox") {
            playfxontag(level._effect[#"hash_21167096dfea3409"], self.pandora_light, "tag_origin");
            return;
        }
        playfxontag(level._effect[#"lght_marker"], self.pandora_light, "tag_origin");
    }
}

// Namespace zm_towers/zm_towers
// Params 0, eflags: 0x0
// Checksum 0x77b49a39, Offset: 0x41f0
// Size: 0x1cc
function magicbox_host_migration() {
    level endon(#"end_game");
    level notify(#"mb_hostmigration");
    level endon(#"mb_hostmigration");
    while (true) {
        level waittill(#"host_migration_end");
        if (!isdefined(level.chests)) {
            continue;
        }
        foreach (chest in level.chests) {
            if (!(isdefined(chest.hidden) && chest.hidden)) {
                if (isdefined(chest) && isdefined(chest.pandora_light)) {
                    if (chest.zbarrier.script_string === "t8_magicbox") {
                        playfxontag(level._effect[#"hash_21167096dfea3409"], chest.pandora_light, "tag_origin");
                    } else {
                        playfxontag(level._effect[#"lght_marker"], chest.pandora_light, "tag_origin");
                    }
                }
            }
            util::wait_network_frame();
        }
    }
}

// Namespace zm_towers/zm_towers
// Params 0, eflags: 0x0
// Checksum 0xebbcb8a1, Offset: 0x43c8
// Size: 0x8
function function_ea1f540() {
    return true;
}

// Namespace zm_towers/zm_towers
// Params 0, eflags: 0x0
// Checksum 0x561ffc73, Offset: 0x43d8
// Size: 0xd0
function function_6bd6724() {
    level flag::wait_till("all_players_spawned");
    a_t_doors = getentarray("zombie_door", "targetname");
    foreach (t_door in a_t_doors) {
        t_door thread function_b1280cdf(t_door, t_door.zombie_cost);
    }
}

// Namespace zm_towers/zm_towers
// Params 2, eflags: 0x0
// Checksum 0x438c4b2f, Offset: 0x44b0
// Size: 0x7c
function function_b1280cdf(t_door, n_cost) {
    if (isdefined(t_door.var_3a93fc14) && t_door.var_3a93fc14) {
        t_door sethintstring(level.var_4f18c7cc);
        return;
    }
    t_door zm_utility::set_hint_string(t_door, "default_buy_door", n_cost);
}

// Namespace zm_towers/zm_towers
// Params 1, eflags: 0x0
// Checksum 0x6183ed9a, Offset: 0x4538
// Size: 0x2a
function function_8e1c950(t_door) {
    var_838b4378 = !isdefined(t_door.var_3a93fc14);
    return var_838b4378;
}

// Namespace zm_towers/zm_towers
// Params 0, eflags: 0x0
// Checksum 0x1904b6a1, Offset: 0x4570
// Size: 0x8c
function function_75362ca2() {
    if (!isdefined(self.var_6e89a356)) {
        return;
    }
    var_f60d3918 = getent(self.var_6e89a356, "prefabname");
    if (!isdefined(var_f60d3918)) {
        var_f60d3918 = getent(self.var_6e89a356, "targetname");
    }
    self waittill(#"door_opened");
    var_f60d3918 delete();
}

// Namespace zm_towers/zm_towers
// Params 0, eflags: 0x0
// Checksum 0x66aea358, Offset: 0x4608
// Size: 0xec
function function_71c26601() {
    var_c32a3b5 = getentarray("lore_room", "targetname");
    foreach (e_door in var_c32a3b5) {
        e_door delete();
    }
    exploder::exploder("exp_lgt_body_pit_secret_room");
    clientfield::set("" + #"hash_2383fd01b106ced8", 1);
}

// Namespace zm_towers/zm_towers
// Params 0, eflags: 0x0
// Checksum 0x898619d8, Offset: 0x4700
// Size: 0x258
function setup_end_igc() {
    util::set_lighting_state(1);
    level flag::clear("spawn_zombies");
    level flag::set(#"pause_round_timeout");
    level zm_utility::function_1a046290(0, 1, 1, 0);
    setdvar(#"zombie_unlock_all", 1);
    zombie_doors = getentarray("zombie_door", "targetname");
    for (i = 0; i < zombie_doors.size; i++) {
        if (!(isdefined(zombie_doors[i].has_been_opened) && zombie_doors[i].has_been_opened)) {
            zombie_doors[i] notify(#"trigger", {#activator:level.players[0]});
        }
        if (isdefined(zombie_doors[i].power_door_ignore_flag_wait) && zombie_doors[i].power_door_ignore_flag_wait) {
            zombie_doors[i] notify(#"power_on");
        }
        waitframe(1);
    }
    level notify(#"open_sesame");
    setdvar(#"zombie_unlock_all", 0);
    foreach (s_box in level.chests) {
        s_box zm_magicbox::hide_chest(0);
    }
}

/#

    // Namespace zm_towers/zm_towers
    // Params 0, eflags: 0x0
    // Checksum 0xf81665bb, Offset: 0x4960
    // Size: 0xf6
    function function_a0ebaa83() {
        level endon(#"end_game", #"hash_70406f82f80feda9");
        zm_devgui::zombie_devgui_open_sesame();
        level flag::clear("<dev string:x30>");
        level flag::set(#"pause_round_timeout");
        level zm_utility::function_1a046290(1);
        array::thread_all(level.players, &zm_towers_crowd::function_d3d3dcf0, 0, 1);
        while (level.var_ba93a1ac) {
            level scene::play("<dev string:x3e>");
            waitframe(1);
        }
    }

    // Namespace zm_towers/zm_towers
    // Params 0, eflags: 0x0
    // Checksum 0xd7c10254, Offset: 0x4a60
    // Size: 0x12e
    function function_a069fe49() {
        level endon(#"end_game", #"hash_71cb0d80cda209f1");
        level flag::clear("<dev string:x30>");
        level flag::set(#"pause_round_timeout");
        level zm_utility::function_1a046290(0, 0, 1);
        level thread scene::play("<dev string:x54>", "<dev string:x6b>");
        array::thread_all(level.players, &zm_towers_crowd::function_d3d3dcf0, 0, 1);
        while (level.var_24df7ca2) {
            level thread function_fe9236e4();
            level scene::play("<dev string:x76>");
            waitframe(1);
        }
    }

    // Namespace zm_towers/zm_towers
    // Params 0, eflags: 0x0
    // Checksum 0x99bcb4f1, Offset: 0x4b98
    // Size: 0x168
    function function_fe9236e4() {
        level endon(#"end_game");
        s_glyphs = struct::get("<dev string:x89>");
        s_flames = struct::get("<dev string:x9a>");
        while (level.var_24df7ca2) {
            level waittill(#"hash_1ea7a5302de9c85e");
            fx_glyphs = fx::play("<dev string:xb0>", s_glyphs.origin, s_glyphs.angles, "<dev string:xd4>");
            waitframe(1);
            fx_fire = fx::play("<dev string:xec>", s_flames.origin, s_flames.angles, "<dev string:xd4>");
            level waittill(#"hash_18462f29f613ebbf", #"hash_71cb0d80cda209f1");
            fx_fire delete();
            fx_glyphs delete();
        }
    }

    // Namespace zm_towers/zm_towers
    // Params 0, eflags: 0x0
    // Checksum 0xa00ef561, Offset: 0x4d08
    // Size: 0x116
    function function_5730678d() {
        level endon(#"end_game", #"hash_2231f086364099b7");
        level flag::clear("<dev string:x30>");
        level flag::set(#"pause_round_timeout");
        array::thread_all(level.players, &zm_towers_crowd::function_d3d3dcf0, 0, 1);
        scene::init_streamer(#"cin_zm_mvid_pack_a_punch_react", #"allies");
        while (level.var_c526ae80) {
            level thread function_9094b970();
            level scene::play("<dev string:x110>");
            waitframe(1);
        }
    }

    // Namespace zm_towers/zm_towers
    // Params 0, eflags: 0x0
    // Checksum 0xa2f2dc61, Offset: 0x4e28
    // Size: 0x314
    function function_9094b970() {
        level waittill(#"hash_550aae2e06c238ce");
        a_mdl_heads = getentarray("<dev string:x12f>", "<dev string:x6b>");
        foreach (mdl_head in a_mdl_heads) {
            mdl_head show();
        }
        a_mdl_heads = getentarray("<dev string:x12f>", "<dev string:x6b>");
        array::thread_all(a_mdl_heads, &zm_towers_pap_quest::function_d47819ae);
        level thread scene::play("<dev string:x142>");
        level thread scene::play("<dev string:x174>", "<dev string:x1a8>");
        level thread scene::play("<dev string:x1af>", "<dev string:x1a8>");
        level thread scene::play("<dev string:x1e3>", "<dev string:x1a8>");
        level thread scene::play("<dev string:x217>", "<dev string:x1a8>");
        level waittill(#"hash_6899d3d9802556ad");
        level thread scene::play("<dev string:x24b>");
        level thread scene::play("<dev string:x276>");
        level waittill(#"hash_61ed5ad857c2709c");
        foreach (mdl_head in a_mdl_heads) {
            mdl_head hide();
        }
        level thread scene::init("<dev string:x24b>");
        level thread scene::init("<dev string:x29e>");
        level thread scene::init("<dev string:x276>");
        level thread scene::init("<dev string:x142>");
    }

    // Namespace zm_towers/zm_towers
    // Params 0, eflags: 0x0
    // Checksum 0xb732c4cc, Offset: 0x5148
    // Size: 0x25e
    function function_1829f9bf() {
        zm_devgui::add_custom_devgui_callback(&function_23e8f16e);
        adddebugcommand("<dev string:x2c7>");
        adddebugcommand("<dev string:x316>");
        adddebugcommand("<dev string:x380>");
        adddebugcommand("<dev string:x3c4>");
        adddebugcommand("<dev string:x414>");
        adddebugcommand("<dev string:x473>");
        adddebugcommand("<dev string:x4d0>");
        adddebugcommand("<dev string:x526>");
        adddebugcommand("<dev string:x57f>");
        adddebugcommand("<dev string:x5d8>");
        adddebugcommand("<dev string:x62d>");
        adddebugcommand("<dev string:x686>");
        adddebugcommand("<dev string:x6df>");
        adddebugcommand("<dev string:x741>");
        adddebugcommand("<dev string:x7a1>");
        adddebugcommand("<dev string:x7fb>");
        adddebugcommand("<dev string:x855>");
        adddebugcommand("<dev string:x8b9>");
        adddebugcommand("<dev string:x929>");
        adddebugcommand("<dev string:x999>");
        if (getdvarint(#"zm_debug_ee", 0)) {
            adddebugcommand("<dev string:xa0b>");
        }
        level.var_f277a2d8 = &function_235b514e;
    }

    // Namespace zm_towers/zm_towers
    // Params 1, eflags: 0x0
    // Checksum 0xfd560c8d, Offset: 0x53b0
    // Size: 0x52a
    function function_23e8f16e(cmd) {
        switch (cmd) {
        case #"play_end_igc":
            level thread function_a1a194ee();
            return 1;
        case #"hash_5f00c356627b87c":
            if (isdefined(level.var_24df7ca2) && level.var_24df7ca2) {
                level.var_24df7ca2 = 0;
            } else {
                level.var_24df7ca2 = 1;
                level thread function_a069fe49();
            }
            break;
        case #"hash_3417e35e6adedf86":
            if (isdefined(level.var_ba93a1ac) && level.var_ba93a1ac) {
                level.var_ba93a1ac = 0;
            } else {
                level.var_ba93a1ac = 1;
                level thread function_a0ebaa83();
            }
            break;
        case #"hash_614f9d774217e602":
            if (isdefined(level.var_c526ae80) && level.var_c526ae80) {
                level.var_c526ae80 = 0;
            } else {
                level.var_c526ae80 = 1;
                level thread function_5730678d();
            }
            break;
        case #"hash_50d92ca3c6c7c2a8":
            level thread function_432361ef();
            return 1;
        case #"hash_3ce58f31f72a510f":
            level thread function_eba779ee();
            return 1;
        case #"hash_237913b2f4a85a44":
            level thread zm_towers_challenges::function_7ed63c2a();
            return 1;
        case #"lore_room":
            level thread function_71c26601();
            return 1;
        case #"hash_27bc74ddac87b156":
            level thread zm_towers_pap_quest::function_5ddcc755("<dev string:xa50>");
            return 1;
        case #"hash_3bb09c753859632b":
            level thread zm_towers_pap_quest::function_5ddcc755("<dev string:xa55>");
            return 1;
        case #"hash_40f87ec1dffc67d0":
            level thread zm_towers_pap_quest::function_5ddcc755("<dev string:xa58>");
            return 1;
        case #"hash_2ca290409187993b":
            level thread zm_towers_pap_quest::function_5ddcc755("<dev string:xa5d>");
            return 1;
        case #"hash_68370bceab1f118":
            level thread zm_towers_pap_quest::function_5ddcc755("<dev string:xa62>");
            return 1;
        case #"hash_2d60025acca3891":
            level thread zm_towers_pap_quest::function_e94d155c("<dev string:xa66>");
            return 1;
        case #"force_marauders":
            level thread zm_towers_pap_quest::function_e94d155c("<dev string:xa71>");
            return 1;
        case #"force_tigers":
            level thread zm_towers_pap_quest::function_e94d155c("<dev string:xa7b>");
            return 1;
        case #"hash_6aecfc20f8d3ae0d":
            level flag::set(#"hash_3551c4ab09311644");
            return 1;
        case #"hash_5220b8897cc03896":
            level flag::set(#"hash_392f20a71becaec7");
            level flag::set(#"hash_3551c4ab09311644");
            return 1;
        case #"hash_12584bff43cd127a":
            level flag::set(#"hash_17425b597c04b9c3");
            level flag::set(#"hash_392f20a71becaec7");
            level flag::set(#"hash_3551c4ab09311644");
            return 1;
        }
    }

    // Namespace zm_towers/zm_towers
    // Params 0, eflags: 0x0
    // Checksum 0x3da4f22d, Offset: 0x58e8
    // Size: 0x3c
    function function_a1a194ee() {
        level setup_end_igc();
        level scene::play(#"hash_18b88682c325ad3d");
    }

    // Namespace zm_towers/zm_towers
    // Params 0, eflags: 0x0
    // Checksum 0xefeff840, Offset: 0x5930
    // Size: 0x5c
    function function_432361ef() {
        zm_devgui::zombie_devgui_open_sesame();
        level zm_towers_pap_quest::function_71e9679b(1, 1);
        level zm_towers_pap_quest::function_d31b93ba(1, 1);
    }

    // Namespace zm_towers/zm_towers
    // Params 0, eflags: 0x0
    // Checksum 0xf8c0952b, Offset: 0x5998
    // Size: 0xf0
    function function_eba779ee() {
        foreach (e_player in level.activeplayers) {
            e_player.var_6c69e11e.n_charge_level++;
            e_player clientfield::set("<dev string:xa82>" + #"charge_gem", e_player.var_6c69e11e.n_charge_level);
            if (e_player.var_6c69e11e.n_charge_level >= 3) {
                e_player thread namespace_10544329::player_flame_on();
            }
        }
    }

    // Namespace zm_towers/zm_towers
    // Params 1, eflags: 0x4
    // Checksum 0x7020fc98, Offset: 0x5a90
    // Size: 0x1b4
    function private function_235b514e(round_number) {
        var_12120e51 = array(0, 500, 1000, 1000, 1400, 4000, 5000, 5500, 5500, 5500, 8000, 8000, 8000, 8000, 9000, 9000, 9000, 9500, 9500, 9500, 9500, 11000, 11000, 11000, 11000, 13000, 13000, 13000, 13000, 14000);
        round_index = round_number - 1;
        assert(round_index >= 0 && round_index < 30);
        foreach (player in getplayers()) {
            player zm_score::function_fb877e6e(var_12120e51[round_index]);
        }
        if (round_number >= 9) {
            zm_trial_util::open_all_doors();
        }
        if (round_number >= 24) {
            zm_trial_util::function_6440f858();
        }
    }

#/
