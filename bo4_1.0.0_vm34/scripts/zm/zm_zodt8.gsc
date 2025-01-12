#using script_444bc5b4fa0fe14f;
#using script_7893277eec698972;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\zm\ai\zm_ai_stoker;
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
#using scripts\zm\zm_zodt8_achievements;
#using scripts\zm\zm_zodt8_devgui;
#using scripts\zm\zm_zodt8_eye;
#using scripts\zm\zm_zodt8_gamemodes;
#using scripts\zm\zm_zodt8_pap_quest;
#using scripts\zm\zm_zodt8_sentinel_trial;
#using scripts\zm\zm_zodt8_side_quests;
#using scripts\zm\zm_zodt8_sound;
#using scripts\zm\zm_zodt8_trials;
#using scripts\zm\zm_zodt8_tutorial;
#using scripts\zm_common\bgbs\zm_bgb_anywhere_but_here;
#using scripts\zm_common\callbacks;
#using scripts\zm_common\load;
#using scripts\zm_common\trials\zm_trial_disable_buys;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_audio_sq;
#using scripts\zm_common\zm_characters;
#using scripts\zm_common\zm_cleanup_mgr;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_fasttravel;
#using scripts\zm_common\zm_hud;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_magicbox;
#using scripts\zm_common\zm_pack_a_punch;
#using scripts\zm_common\zm_pack_a_punch_util;
#using scripts\zm_common\zm_power;
#using scripts\zm_common\zm_round_logic;
#using scripts\zm_common\zm_round_spawning;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;
#using scripts\zm_common\zm_zonemgr;

#namespace zm_zodt8;

// Namespace zm_zodt8/level_init
// Params 1, eflags: 0x40
// Checksum 0x87fff70b, Offset: 0x1378
// Size: 0x654
function event_handler[level_init] main(eventstruct) {
    init_level_vars();
    clientfield::register("clientuimodel", "player_lives", 1, 2, "int");
    clientfield::register("vehicle", "pap_projectile_fx", 1, 1, "int");
    clientfield::register("vehicle", "pap_projectile_end_fx", 1, 1, "counter");
    clientfield::register("world", "narrative_trigger", 1, 1, "int");
    clientfield::register("world", "sfx_waterdrain_fore", 1, 1, "int");
    clientfield::register("world", "sfx_waterdrain_aft", 1, 1, "int");
    clientfield::register("world", "" + #"hash_16cc25b3f87f06ad", 1, 1, "int");
    clientfield::register("scriptmover", "tilt", 1, 1, "int");
    clientfield::register("scriptmover", "change_wave_water_height", 1, 1, "int");
    clientfield::register("scriptmover", "update_wave_water_height", 1, 1, "counter");
    clientfield::register("scriptmover", "activate_sentinel_artifact", 1, 2, "int");
    clientfield::register("scriptmover", "ocean_water", 1, 1, "int");
    clientfield::register("actor", "sndActorUnderwater", 1, 1, "int");
    setdvar(#"player_shallowwaterwadescale", 1);
    setdvar(#"player_waistwaterwadescale", 1);
    setdvar(#"player_deepwaterwadescale", 1);
    scene::add_scene_func("p8_fxanim_zm_zod_skybox_bundle", &function_dc30d70, "init");
    scene::add_scene_func(#"p8_fxanim_zm_zod_tentacle_bundle", &function_4d8208d9);
    zm::init_fx();
    zodt8_pap_quest::init();
    zodt8_sentinel::init();
    namespace_d17fd4ae::init();
    namespace_7890c038::init();
    zodt8_achievements::init();
    zm_audio_sq::init();
    zodt8_sound::main();
    level thread function_e6b7d92e();
    level thread zm::function_46aa9fe2(&function_e64b3fce);
    callback::on_spawned(&on_player_spawned);
    callback::on_ai_spawned(&function_59eb1245);
    load::main();
    function_f70551f4();
    level thread sndfunctions();
    level thread zm_zonemgr::manage_zones("zone_forecastle_upper");
    /#
        level thread zm_zodt8_devgui::function_91912a79();
    #/
    level thread lore_room_door();
    level thread function_73427f9f();
    level thread function_603766b1();
    if (util::get_game_type() != "ztutorial") {
        level thread function_e0d6a708();
    }
    level clientfield::set("" + #"hash_3c58464f16d8a1be", 0);
    flag::wait_till("all_players_spawned");
    var_c42a21af = getnodearray("traversal_unlink_at_start", "targetname");
    array::thread_all(var_c42a21af, &function_3ac1493f);
    level thread function_664ecd7c();
    level thread function_94ef36d7();
    level thread function_63cd5d80();
    level thread function_3cca550e();
    water_init();
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x0
// Checksum 0x49960d3a, Offset: 0x19d8
// Size: 0x74
function function_e64b3fce() {
    self endon(#"disconnect");
    self forcestreambundle("p8_fxanim_zm_zod_iceberg_bundle");
    level flag::wait_till(#"start_zombie_round_logic");
    wait 20;
    self function_5094c112("p8_fxanim_zm_zod_iceberg_bundle");
}

// Namespace zm_zodt8/zm_zodt8
// Params 1, eflags: 0x0
// Checksum 0x91364faf, Offset: 0x1a58
// Size: 0x3c
function function_4d8208d9(a_ents) {
    wait 0.65;
    playrumbleonposition(#"hash_7b580995b5562bfc", self.origin);
}

// Namespace zm_zodt8/zm_zodt8
// Params 1, eflags: 0x0
// Checksum 0x76561e82, Offset: 0x1aa0
// Size: 0x1b0
function function_dc30d70(a_ents) {
    level.e_sway = a_ents[#"skybox_water"];
    level.e_sway clientfield::set("tilt", 1);
    var_e5b5e934 = getentarray("ocean_water", "targetname");
    foreach (var_21f69925 in var_e5b5e934) {
        var_21f69925 linkto(level.e_sway);
        var_21f69925 clientfield::set("ocean_water", 1);
    }
    callback::on_spawned(&function_e290cf19);
    foreach (player in getplayers()) {
        player function_e290cf19();
    }
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x0
// Checksum 0xdd819cb1, Offset: 0x1c58
// Size: 0x24
function function_e290cf19() {
    self playersetgroundreferenceent(level.e_sway);
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x0
// Checksum 0xd22386c1, Offset: 0x1c88
// Size: 0x43e
function init_level_vars() {
    level.var_4af51a33 = &function_93443875;
    level.var_cb79b581 = 1;
    level.default_start_location = "zone_forecastle_upper";
    level.default_game_mode = "zclassic";
    level.var_a732b3aa = &offhand_weapon_overrride;
    level.zombiemode_offhand_weapon_give_override = &offhand_weapon_give_override;
    level.var_237b30e2 = &function_7837e42a;
    level._allow_melee_weapon_switching = 1;
    level.zombiemode_reusing_pack_a_punch = 1;
    level.player_out_of_playable_area_monitor_callback = &player_out_of_playable_area_monitor_callback;
    level.exit_level_func = &zm::default_exit_level;
    level.custom_spawner_entry[#"crawl"] = &zm_spawner::function_48cfc7df;
    level.var_ed1b24b8 = &function_b6e81445;
    level.var_23045784 = getweapon(#"ww_tricannon_t8");
    level.var_72db4a17 = getweapon(#"ww_tricannon_t8_upgraded");
    level._no_vending_machine_auto_collision = 1;
    level.var_6a8290be = 0;
    zm_pap_util::function_2ad8bbcd(32);
    level.var_693191cb = array(#"ww_tricannon_t8");
    level.var_e777f0b0 = &function_62adf486;
    level.var_b99001e6 = &function_407dc692;
    level.var_8a959e57 = &function_f7ba5491;
    level.zones = [];
    level.zone_manager_init_func = &zone_init;
    level.chest_joker_model = "p8_fxanim_zm_zod_magic_box_skull_mod";
    level.chest_joker_custom_movement = &zm_magicbox::function_e4e638c2;
    if (util::get_game_type() != "ztutorial") {
        level.random_pandora_box_start = 1;
        level.var_694c1302 = &function_1f76e57;
        level.custom_magic_box_timer_til_despawn = &function_4a85b505;
    }
    level.open_chest_location = [];
    level.magic_box_zbarrier_state_func = &zm_magicbox::function_b8398043;
    level.var_4f18c7cc = #"hash_3dc033ef1e67a5c0";
    a_s_boxes = struct::get_array(#"treasure_chest_use");
    for (i = 0; i < a_s_boxes.size; i++) {
        level.open_chest_location[i] = a_s_boxes[i].script_noteworthy;
    }
    level flag::init(#"hash_1daec0e8f3d0444");
    if (zm_trial::is_trial_mode()) {
        level.var_2d7d4aab = &function_9f77fe2a;
        level.var_920cc8e7 = &function_de70712e;
        level.var_78722f01 = &function_4d06718c;
    }
    level.var_d04cc94c = 200;
    level.zm_bgb_anywhere_but_here_validation_override = &function_869d6f66;
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x4
// Checksum 0x632d9ea1, Offset: 0x20d0
// Size: 0xb4
function private function_9f77fe2a() {
    assert(isdefined(level.var_b21e401b));
    if (level.var_b21e401b.name == #"waterlogged") {
        level flag::set(#"hash_1daec0e8f3d0444");
        self.var_6477bfeb = isdefined(level.water_drained_fore) && level.water_drained_fore;
        if (self.var_6477bfeb) {
            level thread change_water_height_fore(0);
        }
    }
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x4
// Checksum 0x1fb7ea00, Offset: 0x2190
// Size: 0x94
function private function_de70712e() {
    assert(isdefined(level.var_b21e401b));
    if (level.var_b21e401b.name == #"waterlogged") {
        level flag::clear(#"hash_1daec0e8f3d0444");
        if (self.var_6477bfeb) {
            level thread change_water_height_fore(1);
        }
    }
}

// Namespace zm_zodt8/zm_zodt8
// Params 1, eflags: 0x4
// Checksum 0x7bc0e88f, Offset: 0x2230
// Size: 0x3c
function private function_4d06718c(b_show) {
    if (b_show) {
        zodt8_pap_quest::function_29c316c0();
        return;
    }
    zodt8_pap_quest::function_2187d93b();
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x2
// Checksum 0x722c65ca, Offset: 0x2278
// Size: 0x10c
function autoexec opt_in() {
    level.aat_in_use = 1;
    level.bgb_in_use = 1;
    level.bgb_machine_count = 2;
    level.random_pandora_box_start = 1;
    level.clientfieldaicheck = 1;
    level.var_8b3ad83a = #"hash_7bef4c44b5d916bc";
    level flag::init("forecastle_cargo_hatch_destroyed");
    level flag::init("water_drained_fore");
    level flag::init("water_drained_aft");
    level flag::init(#"water_initialized");
    level flag::init(level.var_8b3ad83a);
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x4
// Checksum 0x24cf2868, Offset: 0x2390
// Size: 0x1fc
function private function_664ecd7c() {
    if (zm_utility::is_standard()) {
        return;
    }
    if (level.players.size == 1) {
        var_255299e8 = zombie_utility::get_zombie_var(#"hash_376905ad360fc2e8");
        var_6def3cd3 = randomintrange(zombie_utility::get_zombie_var(#"hash_2374f3ef775ac2c3"), zombie_utility::get_zombie_var(#"hash_2374f3ef775ac2c3") + 2);
    } else {
        var_255299e8 = zombie_utility::get_zombie_var(#"hash_6eb9b2d60babd5aa");
        var_6def3cd3 = randomintrange(zombie_utility::get_zombie_var(#"hash_3b4ad7449c039d1b"), zombie_utility::get_zombie_var(#"hash_3b4ad7449c039d1b") + 2);
    }
    var_9403026e = var_6def3cd3 + randomintrange(3, 5);
    zm_round_spawning::function_c9b9ab96("catalyst", var_255299e8);
    zm_round_spawning::function_2b3870c9("stoker", var_6def3cd3);
    zm_round_spawning::function_2b3870c9("blight_father", var_9403026e);
    level thread function_17188377(var_6def3cd3);
    if (zm_trial::is_trial_mode()) {
        function_39b7d6ba(var_255299e8);
    }
}

// Namespace zm_zodt8/zm_zodt8
// Params 1, eflags: 0x4
// Checksum 0x80f736b8, Offset: 0x2598
// Size: 0xd4
function private function_17188377(var_6def3cd3) {
    level endon(#"end_game");
    while (true) {
        level waittill(#"end_of_round");
        if (level.round_number >= var_6def3cd3) {
            break;
        }
    }
    zm_round_spawning::function_f1a0928("stoker", &function_825c762d);
    level flag::wait_till(#"hash_1562cc6d96b2bc4");
    zm_round_spawning::function_36256795("stoker", &function_825c762d);
}

// Namespace zm_zodt8/zm_zodt8
// Params 1, eflags: 0x0
// Checksum 0x5e3a3ae9, Offset: 0x2678
// Size: 0x22
function function_825c762d(n_max) {
    if (n_max < 1) {
        return 1;
    }
    return n_max;
}

// Namespace zm_zodt8/zm_zodt8
// Params 1, eflags: 0x4
// Checksum 0x5f4f59a1, Offset: 0x26a8
// Size: 0x162
function private function_39b7d6ba(var_255299e8) {
    assert(zm_trial::is_trial_mode());
    foreach (round_info in level.var_f0a67892.rounds) {
        for (i = 0; i < round_info.challenges.size; i++) {
            challenge = round_info.challenges[i];
            if (challenge.name == #"hash_3746f3c279f7a5ea") {
                assert(round_info.round > var_255299e8);
                level.var_9a7ba542 = round_info.round;
                callback::function_8def5e51(&function_b7de706);
            }
        }
    }
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x0
// Checksum 0xee913d48, Offset: 0x2818
// Size: 0x124
function function_b7de706() {
    if (level.round_number == level.var_9a7ba542) {
        zm_round_spawning::function_f1a0928("catalyst", &function_b9168d29);
        zm_round_spawning::function_f1a0928("stoker", &function_bbdc036e);
        zm_round_spawning::function_f1a0928("blight_father", &function_bbdc036e);
        level waittill(#"end_of_round");
        zm_round_spawning::function_36256795("catalyst", &function_b9168d29);
        zm_round_spawning::function_36256795("stoker", &function_bbdc036e);
        zm_round_spawning::function_36256795("blight_father", &function_bbdc036e);
    }
}

// Namespace zm_zodt8/zm_zodt8
// Params 1, eflags: 0x0
// Checksum 0x16954b02, Offset: 0x2948
// Size: 0x1a
function function_b9168d29(var_accce304) {
    return namespace_31bdfe2d::function_54400533();
}

// Namespace zm_zodt8/zm_zodt8
// Params 1, eflags: 0x0
// Checksum 0xfbc7168b, Offset: 0x2970
// Size: 0xe
function function_bbdc036e(var_accce304) {
    return false;
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x0
// Checksum 0x6ecc80a7, Offset: 0x2988
// Size: 0x64
function function_3ac1493f() {
    level endon(#"end_game");
    unlinktraversal(self);
    level flag::wait_till(self.script_flag);
    linktraversal(self);
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x0
// Checksum 0x886373f3, Offset: 0x29f8
// Size: 0x516
function function_e6b7d92e() {
    level.var_2ce6cac6 = getentarray("magic_box_map", "targetname");
    while (true) {
        s_result = level waittill(#"hash_e39eca74fa250b4");
        foreach (mdl_map in level.var_2ce6cac6) {
            if (zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_on")) {
                mdl_map showpart("j_bridge");
                mdl_map showpart("j_cargo");
                mdl_map showpart("j_dining_hall");
                mdl_map showpart("j_engine_room");
                mdl_map showpart("j_grand_stair_lower");
                mdl_map showpart("j_grand_stair_upper");
                mdl_map showpart("j_lounge");
                mdl_map showpart("j_promenade");
                continue;
            }
            mdl_map hidepart("j_bridge");
            mdl_map hidepart("j_cargo");
            mdl_map hidepart("j_dining_hall");
            mdl_map hidepart("j_engine_room");
            mdl_map hidepart("j_grand_stair_lower");
            mdl_map hidepart("j_grand_stair_upper");
            mdl_map hidepart("j_lounge");
            mdl_map hidepart("j_promenade");
            foreach (s_magic_box in level.chests) {
                if (!(isdefined(s_magic_box.hidden) && s_magic_box.hidden) && isdefined(s_magic_box.script_noteworthy)) {
                    switch (s_magic_box.script_noteworthy) {
                    case #"promenade_chest":
                        mdl_map showpart("j_promenade");
                        break;
                    case #"cargo_chest":
                        mdl_map showpart("j_cargo");
                        break;
                    case #"hash_1cb95429bf87e1dd":
                        mdl_map showpart("j_engine_room");
                        break;
                    case #"grand_stair_lower_chest":
                        mdl_map showpart("j_grand_stair_lower");
                        break;
                    case #"lounge_chest":
                        mdl_map showpart("j_lounge");
                        break;
                    case #"hash_23cfa652ecaa206e":
                        mdl_map showpart("j_grand_stair_upper");
                        break;
                    case #"bridge_chest":
                        mdl_map showpart("j_bridge");
                        break;
                    case #"hash_51c31615840ad554":
                        mdl_map showpart("j_dining_hall");
                        break;
                    }
                }
            }
        }
    }
}

// Namespace zm_zodt8/zm_zodt8
// Params 1, eflags: 0x0
// Checksum 0x63113bd3, Offset: 0x2f18
// Size: 0x1da
function function_1f76e57(e_player) {
    if (isdefined(self.stub.trigger_target.weapon_out) && self.stub.trigger_target.weapon_out) {
        if (self.stub.trigger_target.zbarrier.weapon == level.var_23045784) {
            if (e_player hasweapon(level.var_23045784, 1)) {
                return false;
            }
            var_31156880 = array(#"ww_tricannon_t8_upgraded", #"ww_tricannon_air_t8", #"ww_tricannon_air_t8_upgraded", #"ww_tricannon_earth_t8", #"ww_tricannon_earth_t8_upgraded", #"ww_tricannon_fire_t8", #"ww_tricannon_fire_t8_upgraded", #"ww_tricannon_water_t8", #"ww_tricannon_water_t8_upgraded");
            foreach (var_a72742e9 in var_31156880) {
                if (e_player hasweapon(getweapon(var_a72742e9), 1)) {
                    return false;
                }
            }
        }
    }
    return true;
}

// Namespace zm_zodt8/zm_zodt8
// Params 1, eflags: 0x0
// Checksum 0xa8fa0c25, Offset: 0x3100
// Size: 0xbc
function function_4a85b505(zbarrier_magicbox) {
    if (zbarrier_magicbox.weapon === level.w_tricannon_base) {
        v_offset = vectornormalize(anglestoforward(zbarrier_magicbox.angles)) * 16;
        self.origin += v_offset;
    }
    v_float = anglestoup(self.angles) * 40;
    self thread zm_magicbox::timer_til_despawn(v_float);
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x0
// Checksum 0xbb6a5664, Offset: 0x31c8
// Size: 0x110
function lore_room_door() {
    level endon(#"end_game");
    level flag::init(#"open_lore_room");
    var_a104d3b8 = getent("lore_room_door", "targetname");
    var_b13b9d71 = getent("lore_room_door_clip", "targetname");
    while (true) {
        level flag::wait_till(#"open_lore_room");
        function_805e8ef(1, var_a104d3b8, var_b13b9d71);
        level flag::wait_till_clear(#"open_lore_room");
        function_805e8ef(0, var_a104d3b8, var_b13b9d71);
    }
}

// Namespace zm_zodt8/zm_zodt8
// Params 3, eflags: 0x0
// Checksum 0x8d3e0760, Offset: 0x32e0
// Size: 0x154
function function_805e8ef(b_open, e_door, var_26a4bb0) {
    var_54c2ce93 = (0, 270, 0);
    var_9225a44b = (0, 35, 0);
    if (!isdefined(e_door)) {
        e_door = getent("lore_room_door", "targetname");
    }
    if (!isdefined(var_26a4bb0)) {
        var_26a4bb0 = getent("lore_room_door_clip", "targetname");
    }
    if (isdefined(b_open) && b_open) {
        level clientfield::set("narrative_trigger", 1);
        e_door rotateto(var_9225a44b, 1, 0, 0);
        wait 1 * 0.5;
        var_26a4bb0 notsolid();
        return;
    }
    var_26a4bb0 solid();
    e_door rotateto(var_54c2ce93, 1, 0, 0);
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x4
// Checksum 0xbb5306c9, Offset: 0x3440
// Size: 0x1d8
function private function_63cd5d80() {
    level endon(#"end_game");
    var_27dcf9e2 = 0;
    var_6daa0ea5 = 0;
    var_43cdaa3a = array("zone_grand_stairs_b_deck", "zone_grand_stairs_c_deck", "zone_grand_stairs_d_deck", "zone_dining_hall_fore", "zone_dining_hall_aft", "zone_galley");
    var_e15c5e6f = getent("moonlight_on_volume", "targetname");
    while (true) {
        var_27dcf9e2 = 0;
        for (i = 0; i < level.players.size && !var_27dcf9e2; i++) {
            e_player = level.players[i];
            if (isinarray(var_43cdaa3a, e_player.zone_name)) {
                var_27dcf9e2 = 1;
                break;
            }
            if (e_player.zone_name === "zone_promenade_deck" && e_player istouching(var_e15c5e6f)) {
                var_27dcf9e2 = 1;
                break;
            }
        }
        if (var_6daa0ea5) {
            if (!var_27dcf9e2) {
                exploder::exploder("exp_lgt_fakemoon_c_deck");
                var_6daa0ea5 = 0;
            }
        } else if (var_27dcf9e2) {
            exploder::stop_exploder("exp_lgt_fakemoon_c_deck");
            var_6daa0ea5 = 1;
        }
        wait 0.1;
    }
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x0
// Checksum 0xb7f4e989, Offset: 0x3620
// Size: 0x128
function function_3cca550e() {
    while (true) {
        hidemiscmodels("coal_warm");
        hidemiscmodels("coal_hot");
        level waittill(#"hash_47ecba5609d2b603");
        hidemiscmodels("coal_cold");
        if (level flag::get(#"hash_65e37079e0d22d47") && !level flag::get(#"planet_step_completed")) {
            showmiscmodels("coal_hot");
        } else {
            showmiscmodels("coal_warm");
        }
        level waittill(#"hash_74a58a7760ce1b5c");
        wait 12;
        showmiscmodels("coal_cold");
    }
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x0
// Checksum 0x1ef2986a, Offset: 0x3750
// Size: 0xb0
function function_94ef36d7() {
    while (true) {
        var_3405ce14 = level.round_number + randomintrangeinclusive(3, 6);
        while (var_3405ce14 > level.round_number) {
            level waittill(#"end_of_round");
        }
        wait randomint(10);
        exploder::exploder("fx_exp_flare_vista_white");
    }
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x0
// Checksum 0xfb06a802, Offset: 0x3808
// Size: 0xe6
function function_603766b1() {
    level flag::wait_till("start_zombie_round_logic");
    wait 25;
    while (true) {
        exploder::exploder("exp_lgt_sos");
        wait randomintrange(5, 55);
        exploder::exploder_stop("exp_lgt_sos");
        wait 5;
        exploder::exploder("exp_lgt_cqd");
        wait randomintrange(5, 55);
        exploder::exploder_stop("exp_lgt_cqd");
        wait 5;
    }
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x0
// Checksum 0x3d0641a0, Offset: 0x38f8
// Size: 0xbc
function function_d45fc115() {
    do {
        t_trigger = trigger::wait_till("trigger_sentinel_los", "targetname");
        b_played = t_trigger.who zm_audio::create_and_play_dialog(#"sentinel", #"los_first");
        waitframe(1);
    } while (b_played !== 1 && !level flag::get(level.var_8b3ad83a));
    t_trigger delete();
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x0
// Checksum 0xec2d10e, Offset: 0x39c0
// Size: 0x5dc
function function_73427f9f() {
    level thread function_d45fc115();
    mdl_artifact = getent("artifact_mind", "script_noteworthy");
    mdl_artifact clientfield::set("activate_sentinel_artifact", 1);
    level thread scene::play("p8_fxanim_zm_zod_sent_trail1_boat_bundle", "boat_idle");
    level util::delay_network_frames(3, undefined, &scene::play, "p8_fxanim_zm_zod_skybox_bundle", "idle");
    var_2e8f6101 = getentarray("fc_hatch_cover", "targetname");
    foreach (e_blocker in var_2e8f6101) {
        e_blocker disconnectpaths();
    }
    s_result = level waittill(#"hash_3e80d503318a5674");
    array::run_all(util::get_active_players(), &forcestreambundle, "p8_fxanim_zm_zod_smokestack_01_bundle", 3);
    mdl_artifact clientfield::set("activate_sentinel_artifact", 2);
    var_17ff3d6f = (0, 18, -32);
    mdl_artifact moveto(mdl_artifact.origin + var_17ff3d6f, 5, 1, 3);
    mdl_artifact waittill(#"movedone");
    mdl_artifact setmodel(#"hash_2c0078538e398b4f");
    wait 2.5;
    mdl_artifact clientfield::set("activate_sentinel_artifact", 0);
    foreach (player in util::get_active_players()) {
        player playrumbleonentity("zm_power_on_rumble");
    }
    exploder::exploder("fxexp_power_artifact_burst");
    level thread scene::play("p8_fxanim_zm_zod_sentinel_chaos_bundle");
    level flag::set(level.var_8b3ad83a);
    earthquake(0.3, 3, mdl_artifact.origin, 1024);
    level thread zm_audio::sndmusicsystem_playstate("sentinel_artifact_activated");
    var_47ee7db6 = getent("veh_fasttravel_cam", "targetname");
    for (i = 1; i <= 4; i++) {
        var_2698204e[i] = spawner::simple_spawn_single(var_47ee7db6);
    }
    level thread pap_projectile_fx("pap_projectile_path_1", var_2698204e[1], 30, 75);
    level thread pap_projectile_fx("pap_projectile_path_2", var_2698204e[2], 30, 75);
    level thread pap_projectile_fx("pap_projectile_path_3", var_2698204e[3], 30, 75);
    level thread pap_projectile_fx("pap_projectile_path_4", var_2698204e[4], 7.5, 18.75);
    level thread function_71862632();
    level thread function_4b83abc9();
    level thread function_25813160();
    wait 0.1;
    mdl_artifact delete();
    wait 7.5;
    if (isalive(s_result.player)) {
        s_result.player zm_audio::create_and_play_dialog(#"sentinel", #"key");
    }
}

// Namespace zm_zodt8/zm_zodt8
// Params 4, eflags: 0x0
// Checksum 0x6a672cdd, Offset: 0x3fa8
// Size: 0x144
function pap_projectile_fx(var_110b6d20, var_d67411ae, n_acceleration, n_speed) {
    nd_spline = getvehiclenode(var_110b6d20, "targetname");
    var_d67411ae.origin = nd_spline.origin;
    var_d67411ae.angles = nd_spline.angles;
    var_d67411ae setacceleration(n_acceleration);
    var_d67411ae setspeed(n_speed);
    var_d67411ae clientfield::set("pap_projectile_fx", 1);
    var_d67411ae vehicle::get_on_and_go_path(nd_spline);
    var_d67411ae clientfield::set("pap_projectile_fx", 0);
    waitframe(1);
    var_d67411ae clientfield::increment("pap_projectile_end_fx", 1);
    waitframe(1);
    var_d67411ae delete();
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x0
// Checksum 0x37408d46, Offset: 0x40f8
// Size: 0x8c
function function_71862632() {
    level waittill(#"hash_41c098a05040b314");
    level flag::set("flag_open_sun_deck_power_doors");
    level thread function_d704d44e();
    level waittill(#"hash_609a3944e7a7d4c3");
    level flag::set("flag_open_grand_staircase_lower_power_doors");
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x0
// Checksum 0xcf1d8fca, Offset: 0x4190
// Size: 0x84
function function_d704d44e() {
    level thread scene::play("p8_fxanim_zm_zod_sent_trail1_boat_bundle", "boat_break");
    level waittill(#"hash_5ca90be035a1c92b");
    e_clip = getent("e_clip_lifeboat", "targetname");
    e_clip notsolid();
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x0
// Checksum 0x88b6da29, Offset: 0x4220
// Size: 0x4dc
function function_4b83abc9() {
    level waittill(#"hash_5ae5281126d5236f");
    level thread scene::play("p8_fxanim_zm_zod_smokestack_01_bundle", "Shot 2");
    level waittill(#"hash_393ef28eb68b1cb");
    array::run_all(util::get_active_players(), &function_5094c112, "p8_fxanim_zm_zod_smokestack_01_bundle");
    level flag::set("flag_open_grand_staircase_upper_power_doors");
    level thread scene::play("p8_fxanim_zm_zod_sent_trail2_skylight_bundle");
    level waittill(#"hash_35bd56ac05bd31c9");
    level flag::set("flag_open_cargo_hold_power_door");
    level exploder::exploder("fxexp_power_trail_burst_iceberg");
    level thread scene::play("p8_fxanim_zm_zod_sent_trail2_cargo_hatch_bundle");
    var_2e8f6101 = getentarray("fc_hatch_cover", "targetname");
    foreach (e_blocker in var_2e8f6101) {
        e_blocker connectpaths();
        e_blocker delete();
    }
    a_e_players = getplayers();
    nd_cargo_hatch = getvehiclenode("nd_cargo_hatch", "targetname");
    var_d7533189 = 312 * 312;
    foreach (e_player in a_e_players) {
        if (distance2dsquared(e_player.origin, nd_cargo_hatch.origin) <= var_d7533189) {
            e_player playerknockback(1);
            e_player applyknockback(100, e_player.origin - (nd_cargo_hatch.origin[0], nd_cargo_hatch.origin[1], e_player.origin[2]));
            e_player playerknockback(0);
            e_player playrumbleonentity("damage_heavy");
        }
    }
    if (isdefined(level.ai[#"axis"]) && level.ai[#"axis"].size) {
        var_97b453fa = array::get_all_closest(nd_cargo_hatch.origin, level.ai[#"axis"], undefined, undefined, 312);
        var_c9d221d8 = array::filter(var_97b453fa, 0, &zm_fasttravel::function_f15785cf);
        foreach (e_zombie in var_c9d221d8) {
            e_zombie zombie_utility::setup_zombie_knockdown(nd_cargo_hatch);
        }
    }
    level flag::set("forecastle_cargo_hatch_destroyed");
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x0
// Checksum 0x90304846, Offset: 0x4708
// Size: 0xb4
function function_25813160() {
    level waittill(#"hash_703c6b32242cc333");
    level flag::set("flag_open_midship_power_doors");
    level exploder::exploder("fxexp_power_trail_burst_midship");
    level thread scene::play("p8_fxanim_zm_zod_sent_trail3_grate_bundle");
    level waittill(#"hash_5b1017b8dcf55c09");
    level thread scene::play("p8_fxanim_zm_zod_sent_trail3_fan_bundle");
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x0
// Checksum 0xeee1cb, Offset: 0x47c8
// Size: 0x304
function water_init() {
    level.e_clip_water_fore = getent("e_clip_water_fore", "targetname");
    level.var_b7b0edd0 = struct::get("s_water_height_flooded_fore").origin[2];
    level.var_ed90adf6 = struct::get("s_water_height_drained_fore").origin[2];
    level.e_clip_water_aft = getent("e_clip_water_aft", "targetname");
    level.var_964cf4cd = struct::get("s_water_height_flooded_aft").origin[2];
    level.var_aa02e70f = struct::get("s_water_height_drained_aft").origin[2];
    level.e_clip_water_fore.origin = (level.e_clip_water_fore.origin[0], level.e_clip_water_fore.origin[1], level.var_b7b0edd0);
    level.e_clip_water_fore.angles = (level.e_clip_water_fore.angles[0], level.e_clip_water_fore.angles[1], 0);
    level.forewater = function_e5f7e1a7(level.e_clip_water_fore getentitynumber());
    level.e_clip_water_aft.origin = (level.e_clip_water_aft.origin[0], level.e_clip_water_aft.origin[1], level.var_964cf4cd);
    level.e_clip_water_aft.angles = (level.e_clip_water_aft.angles[0], level.e_clip_water_aft.angles[1], 0);
    level.aftwater = function_e5f7e1a7(level.e_clip_water_aft getentitynumber());
    level.e_clip_water_fore clientfield::increment("update_wave_water_height", 1);
    level.e_clip_water_aft clientfield::increment("update_wave_water_height", 1);
    level flag::set(#"water_initialized");
    function_ec11ded0();
}

// Namespace zm_zodt8/zm_zodt8
// Params 2, eflags: 0x0
// Checksum 0xcb9b90de, Offset: 0x4ad8
// Size: 0x224
function function_ec11ded0(b_fore = 1, b_aft = 1) {
    if (b_fore) {
        t_use_water_pump_fore = getent("t_use_water_pump_fore", "targetname");
        var_d1ad0c05 = struct::get("water_pump_fore", "targetname");
        var_d1ad0c05 scene::play(#"p8_fxanim_zm_zod_water_pump_bundle", "end");
        level thread function_46b621b3(t_use_water_pump_fore, var_d1ad0c05, level.e_clip_water_fore, "water_drained_fore", 40, level.var_ed90adf6, -1.5, "fxexp_ambient_drain_cargo", "exp_lgt_underwater_cargo", "sfx_waterdrain_fore");
        level exploder::exploder("exp_lgt_underwater_cargo");
    }
    if (b_aft) {
        t_use_water_pump_aft = getent("t_use_water_pump_aft", "targetname");
        var_235db982 = struct::get("water_pump_aft", "targetname");
        var_235db982 scene::play(#"p8_fxanim_zm_zod_water_pump_bundle", "end");
        level thread function_46b621b3(t_use_water_pump_aft, var_235db982, level.e_clip_water_aft, "water_drained_aft", 30, level.var_aa02e70f, -0.75, "fxexp_ambient_drain_boilers", "exp_lgt_underwater_engine", "sfx_waterdrain_aft");
        level exploder::exploder("exp_lgt_underwater_engine");
    }
}

// Namespace zm_zodt8/zm_zodt8
// Params 10, eflags: 0x4
// Checksum 0x1917a05, Offset: 0x4d08
// Size: 0x254
function private function_46b621b3(var_b9a923e4, var_2602b380, var_67abc22b, var_93e5e263, n_time, var_552d3553, var_b497f047, var_5dc1d02b, var_a4f8ab35, var_34f0665c) {
    self notify(var_93e5e263 + "_water_pump");
    self endon(var_93e5e263 + "_water_pump");
    var_b9a923e4 sethintstring(#"hash_200f613f8001b6b9");
    var_b9a923e4 setvisibletoall();
    var_8ed0acaf = var_2602b380.scene_ents[#"prop 1"];
    waitresult = var_b9a923e4 waittill(#"trigger");
    var_b9a923e4 setinvisibletoall();
    if (isdefined(waitresult.activator)) {
        waitresult.activator notify(#"hash_361427de75870cde");
    }
    var_8ed0acaf playsound(#"hash_7dbe54dbc8709530");
    var_8ed0acaf playloopsound(#"hash_5f1c2aeb92331d60");
    level clientfield::set(var_34f0665c, 1);
    var_2602b380 thread function_4b475d8b(1);
    function_742c3c83(var_67abc22b, var_93e5e263, n_time, var_552d3553, var_b497f047, var_5dc1d02b, var_a4f8ab35, 1);
    var_2602b380 thread function_4b475d8b(0);
    var_8ed0acaf playsound(#"hash_1fc479499a911511");
    var_8ed0acaf stoploopsound();
    level clientfield::set(var_34f0665c, 0);
}

// Namespace zm_zodt8/zm_zodt8
// Params 1, eflags: 0x0
// Checksum 0x85ace5ae, Offset: 0x4f68
// Size: 0xb4
function function_4b475d8b(b_on) {
    self notify("6bb7cebf125868c3");
    self endon("6bb7cebf125868c3");
    if (b_on) {
        self scene::play(#"p8_fxanim_zm_zod_water_pump_bundle", "start");
        self scene::play(#"p8_fxanim_zm_zod_water_pump_bundle", "on");
        return;
    }
    self scene::play(#"p8_fxanim_zm_zod_water_pump_bundle", "end");
}

// Namespace zm_zodt8/zm_zodt8
// Params 1, eflags: 0x0
// Checksum 0x2633f25c, Offset: 0x5028
// Size: 0xa4
function change_water_height_fore(b_drain) {
    if (b_drain) {
        function_742c3c83(level.e_clip_water_fore, "water_drained_fore", 40, level.var_ed90adf6, -1.5, "fxexp_ambient_drain_cargo", "exp_lgt_underwater_cargo", 1);
        return;
    }
    function_742c3c83(level.e_clip_water_fore, "water_drained_fore", 40, level.var_b7b0edd0, 0, "fxexp_ambient_drain_cargo", "exp_lgt_underwater_cargo", 0);
}

// Namespace zm_zodt8/zm_zodt8
// Params 1, eflags: 0x0
// Checksum 0x214f2db1, Offset: 0x50d8
// Size: 0xa4
function change_water_height_aft(b_drain) {
    if (b_drain) {
        function_742c3c83(level.e_clip_water_aft, "water_drained_aft", 30, level.var_aa02e70f, -0.75, "fxexp_ambient_drain_boilers", "exp_lgt_underwater_engine", 1);
        return;
    }
    function_742c3c83(level.e_clip_water_aft, "water_drained_aft", 30, level.var_964cf4cd, 0, "fxexp_ambient_drain_boilers", "exp_lgt_underwater_engine", 0);
}

// Namespace zm_zodt8/zm_zodt8
// Params 8, eflags: 0x4
// Checksum 0xad30afb9, Offset: 0x5188
// Size: 0x29e
function private function_742c3c83(var_67abc22b, var_93e5e263, n_time, var_552d3553, var_b497f047, var_5dc1d02b, var_a4f8ab35, b_drain) {
    level notify(var_93e5e263 + "_end");
    level endon(var_93e5e263 + "_end");
    level.(var_93e5e263) = b_drain;
    if (b_drain) {
        if (var_93e5e263 == "water_drained_fore") {
            level thread scene::play("p8_fxanim_zm_zod_cargo_hold_net_bundle", "Shot 2");
            level thread scene::play("p8_fxanim_zm_zod_cargo_hold_net_02_bundle", "Shot 2");
        }
        level notify(var_93e5e263 + "_drain_start");
        level exploder::exploder(var_5dc1d02b);
        level exploder::exploder(var_5dc1d02b + "2");
        level exploder::stop_exploder(var_a4f8ab35);
        var_67abc22b function_fa5d7796(n_time, var_552d3553, var_b497f047);
        level flag::set(var_93e5e263);
        level notify(var_93e5e263 + "_drain_finish");
        return;
    }
    if (var_93e5e263 == "water_drained_fore") {
        level thread scene::play("p8_fxanim_zm_zod_cargo_hold_net_bundle", "Shot 3");
        level thread scene::play("p8_fxanim_zm_zod_cargo_hold_net_02_bundle", "Shot 3");
    }
    level notify(var_93e5e263 + "_refill_start");
    level exploder::stop_exploder(var_5dc1d02b);
    level exploder::stop_exploder(var_5dc1d02b + "2");
    level exploder::exploder(var_a4f8ab35);
    var_67abc22b function_fa5d7796(n_time, var_552d3553, var_b497f047);
    level flag::clear(var_93e5e263);
    level notify(var_93e5e263 + "_refill_finish");
}

// Namespace zm_zodt8/zm_zodt8
// Params 3, eflags: 0x4
// Checksum 0xa349c46, Offset: 0x5430
// Size: 0x124
function private function_fa5d7796(n_time, var_552d3553, var_b497f047) {
    self clientfield::set("change_wave_water_height", 1);
    self moveto((self.origin[0], self.origin[1], var_552d3553), n_time);
    self rotateroll(var_b497f047, n_time);
    self waittill(#"movedone");
    self.origin = (self.origin[0], self.origin[1], var_552d3553);
    self.angles = (self.angles[0], self.angles[1], var_b497f047);
    util::wait_network_frame();
    self clientfield::set("change_wave_water_height", 0);
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x0
// Checksum 0xc46a1f7e, Offset: 0x5560
// Size: 0x54
function function_d96fa5e3() {
    level endon(#"draft_complete", #"start_zombie_round_logic");
    while (level clientfield::get("draft") < 3) {
        waitframe(1);
    }
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x0
// Checksum 0x51aabfb, Offset: 0x55c0
// Size: 0x1e4
function function_e0d6a708() {
    function_d96fa5e3();
    exploder::exploder("exp_lgt_start_iceberg_spotlights");
    exploder::exploder("exp_lgt_forecastle_gamplay");
    exploder::exploder("exp_lgt_forecastle_pre_clean");
    level flag::wait_till("start_zombie_round_logic");
    util::delay("smokestack01", undefined, &scene::play, "p8_fxanim_zm_zod_smokestack_01_bundle", "Shot 1");
    util::delay("smokestack02", undefined, &scene::play, "p8_fxanim_zm_zod_smokestack_02_bundle", "Shot 1");
    util::delay("wire_snaps", undefined, &scene::play, "p8_fxanim_zm_zod_smokestack_wire_snap_bundle");
    a_ents = getentarray("iceberg_fxanim_objects", "script_noteworthy");
    level thread scene::play("p8_fxanim_zm_zod_iceberg_bundle", "iceberg_impact", a_ents);
    level thread scene::play("p8_fxanim_zm_zod_skybox_bundle", "impact");
    level thread function_55313630("chunk_open", "connect_forecastle_to_bridge");
    level thread function_4b7d0b2("boat_break", "iceberg_boat_break_lookat_trigger");
}

// Namespace zm_zodt8/zm_zodt8
// Params 2, eflags: 0x0
// Checksum 0x62bd451c, Offset: 0x57b0
// Size: 0x4c
function function_55313630(str_shot, str_flag) {
    level flag::wait_till(str_flag);
    level thread scene::play("p8_fxanim_zm_zod_iceberg_bundle", str_shot);
}

// Namespace zm_zodt8/zm_zodt8
// Params 2, eflags: 0x0
// Checksum 0x97ccbe7, Offset: 0x5808
// Size: 0x9c
function function_4b7d0b2(str_shot, str_trigger) {
    trigger::wait_till(str_trigger, "targetname");
    level thread scene::play("p8_fxanim_zm_zod_iceberg_bundle", str_shot);
    t_trigger = getent(str_trigger, "targetname");
    if (isdefined(t_trigger)) {
        t_trigger delete();
    }
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x0
// Checksum 0x57f27c40, Offset: 0x58b0
// Size: 0x24
function player_out_of_playable_area_monitor_callback() {
    if (isdefined(self.var_fa6d2a24) && self.var_fa6d2a24) {
        return false;
    }
    return true;
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x0
// Checksum 0xb520b364, Offset: 0x58e0
// Size: 0x4c
function offhand_weapon_overrride() {
    zm_loadout::register_tactical_grenade_for_level(#"zhield_dw", 1);
    zm_loadout::register_tactical_grenade_for_level(#"zhield_frost_dw");
}

// Namespace zm_zodt8/zm_zodt8
// Params 1, eflags: 0x0
// Checksum 0x1f7f7540, Offset: 0x5938
// Size: 0xc6
function offhand_weapon_give_override(str_weapon) {
    self endon(#"death");
    if (zm_loadout::is_tactical_grenade(str_weapon) && isdefined(self zm_loadout::get_player_tactical_grenade()) && !self zm_loadout::is_player_tactical_grenade(str_weapon)) {
        self setweaponammoclip(self zm_loadout::get_player_tactical_grenade(), 0);
        self takeweapon(self zm_loadout::get_player_tactical_grenade());
    }
    return false;
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x0
// Checksum 0x8e8e0493, Offset: 0x5a08
// Size: 0x121c
function zone_init() {
    level flag::init("always_on");
    level flag::set("always_on");
    setdvar(#"hash_6ec233a56690f409", 1);
    zm_zonemgr::zone_init("zone_forecastle_upper");
    level.disable_kill_thread = 1;
    zm_zonemgr::add_adjacent_zone("zone_forecastle_upper", "zone_forecastle_lower", "always_on", 0);
    zm_zonemgr::add_adjacent_zone("zone_forecastle_lower", "zone_state_rooms_front", "connect_forecastle_to_state_rooms");
    zm_zonemgr::add_adjacent_zone("zone_forecastle_lower", "zone_mail_room", "connect_forecastle_to_mail");
    zm_zonemgr::add_adjacent_zone("zone_forecastle_lower", "zone_bridge", "connect_forecastle_to_bridge");
    zm_zonemgr::add_adjacent_zone("zone_zipline_fore", "zone_forecastle_lower", "power_on");
    zm_zonemgr::add_adjacent_zone("zone_zipline_fore", "zone_forecastle_upper", "power_on");
    zm_zonemgr::add_adjacent_zone("zone_zipline_fore", "zone_fore_deck", "power_on");
    zm_zonemgr::add_adjacent_zone("zone_zipline_aft", "zone_poop_deck", "power_on");
    zm_zonemgr::add_adjacent_zone("zone_zipline_aft", "zone_poop_deck_lower", "power_on");
    zm_zonemgr::add_adjacent_zone("zone_zipline_aft", "zone_fore_deck", "power_on");
    zm_zonemgr::add_adjacent_zone("zone_state_rooms_front", "zone_forecastle_lower", "connect_forecastle_to_state_rooms");
    zm_zonemgr::add_adjacent_zone("zone_state_rooms_front", "zone_state_rooms_rear", "connect_forecastle_to_state_rooms");
    zm_zonemgr::add_adjacent_zone("zone_state_rooms_rear", "zone_state_rooms_front", "connect_forecastle_to_state_rooms");
    zm_zonemgr::add_adjacent_zone("zone_state_rooms_rear", "millionaire_suite_zone", "connect_state_rooms_to_millionaire");
    zm_zonemgr::add_adjacent_zone("zone_state_rooms_front", "zone_state_rooms_rear", "connect_state_rooms_to_millionaire");
    zm_zonemgr::add_adjacent_zone("zone_state_rooms_rear", "zone_state_rooms_front", "connect_state_rooms_to_millionaire");
    zm_zonemgr::add_adjacent_zone("zone_grand_stairs_c_deck", "zone_grand_stairs_b_deck", "power_on");
    zm_zonemgr::add_adjacent_zone("zone_grand_stairs_c_deck", "zone_grand_stairs_d_deck", "power_on");
    zm_zonemgr::add_adjacent_zone("zone_grand_stairs_c_deck", "zone_grand_stairs_d_deck", "connect_state_rooms_to_millionaire");
    zm_zonemgr::add_adjacent_zone("zone_grand_stairs_c_deck", "zone_grand_stairs_d_deck", "connect_grand_stair_lower_to_dining");
    zm_zonemgr::add_adjacent_zone("zone_grand_stairs_c_deck", "zone_dining_hall_fore", "connect_grand_stair_lower_to_dining");
    zm_zonemgr::add_adjacent_zone("zone_grand_stairs_d_deck", "millionaire_suite_zone", "connect_state_rooms_to_millionaire");
    zm_zonemgr::add_adjacent_zone("zone_grand_stairs_d_deck", "millionaire_suite_zone", "connect_grand_stair_lower_to_dining");
    zm_zonemgr::add_adjacent_zone("zone_grand_stairs_d_deck", "millionaire_suite_zone", "power_on");
    zm_zonemgr::add_adjacent_zone("zone_grand_stairs_d_deck", "zone_grand_stairs_c_deck", "power_on");
    zm_zonemgr::add_adjacent_zone("zone_grand_stairs_d_deck", "zone_grand_stairs_c_deck", "connect_state_rooms_to_millionaire");
    zm_zonemgr::add_adjacent_zone("zone_grand_stairs_d_deck", "zone_grand_stairs_c_deck", "connect_grand_stair_lower_to_dining");
    zm_zonemgr::add_adjacent_zone("zone_grand_stairs_bottom", "zone_grand_stairs_d_deck", "power_on");
    zm_zonemgr::add_adjacent_zone("zone_grand_stairs_d_deck", "zone_grand_stairs_bottom", "power_on");
    zm_zonemgr::add_adjacent_zone("zone_dining_hall_fore", "zone_grand_stairs_c_deck", "connect_grand_stair_lower_to_dining");
    zm_zonemgr::add_adjacent_zone("zone_dining_hall_fore", "zone_dining_hall_aft", "connect_grand_stair_lower_to_dining");
    zm_zonemgr::add_adjacent_zone("zone_dining_hall_aft", "zone_dining_hall_fore", "connect_grand_stair_lower_to_dining");
    zm_zonemgr::add_adjacent_zone("zone_dining_hall_aft", "zone_dining_hall_fore", "connect_dining_to_promenade");
    zm_zonemgr::add_adjacent_zone("zone_dining_hall_aft", "zone_galley", "connect_grand_stair_lower_to_dining");
    zm_zonemgr::add_adjacent_zone("zone_dining_hall_aft", "zone_galley", "connect_dining_to_promenade");
    zm_zonemgr::add_adjacent_zone("zone_galley", "zone_dining_hall_aft", "connect_grand_stair_lower_to_dining");
    zm_zonemgr::add_adjacent_zone("zone_galley", "zone_dining_hall_aft", "connect_dining_to_promenade");
    zm_zonemgr::add_adjacent_zone("zone_galley", "zone_promenade_deck", "connect_dining_to_promenade");
    zm_zonemgr::add_adjacent_zone("millionaire_suite_zone", "zone_grand_stairs_d_deck", "power_on");
    zm_zonemgr::add_adjacent_zone("millionaire_suite_zone", "zone_grand_stairs_d_deck", "connect_grand_stair_lower_to_dining");
    zm_zonemgr::add_adjacent_zone("millionaire_suite_zone", "zone_grand_stairs_d_deck", "connect_state_rooms_to_millionaire");
    zm_zonemgr::add_adjacent_zone("millionaire_suite_zone", "zone_state_rooms_rear", "connect_state_rooms_to_millionaire");
    zm_zonemgr::add_adjacent_zone("zone_bridge", "zone_grand_stairs_a_deck", "connect_bridge_to_grand_stairs");
    zm_zonemgr::add_adjacent_zone("zone_bridge", "zone_forecastle_lower", "connect_forecastle_to_bridge");
    zm_zonemgr::add_adjacent_zone("zone_grand_stairs_a_deck", "zone_bridge", "connect_bridge_to_grand_stairs");
    zm_zonemgr::add_adjacent_zone("zone_grand_stairs_a_deck", "zone_grand_stairs_b_deck", "connect_bridge_to_grand_stairs");
    zm_zonemgr::add_adjacent_zone("zone_grand_stairs_a_deck", "zone_grand_stairs_b_deck", "power_on");
    zm_zonemgr::add_adjacent_zone("zone_grand_stairs_a_deck", "zone_fore_deck", "connect_grand_stairs_to_boat_deck");
    zm_zonemgr::add_adjacent_zone("zone_grand_stairs_a_deck", "zone_grand_stairs_b_deck", "connect_grand_stairs_to_lounge");
    zm_zonemgr::add_adjacent_zone("zone_grand_stairs_b_deck", "zone_grand_stairs_a_deck", "connect_bridge_to_grand_stairs");
    zm_zonemgr::add_adjacent_zone("zone_grand_stairs_b_deck", "zone_grand_stairs_a_deck", "power_on");
    zm_zonemgr::add_adjacent_zone("zone_grand_stairs_b_deck", "zone_grand_stairs_c_deck", "power_on");
    zm_zonemgr::add_adjacent_zone("zone_grand_stairs_b_deck", "zone_lounge", "connect_grand_stairs_to_lounge");
    zm_zonemgr::add_adjacent_zone("zone_grand_stairs_b_deck", "zone_grand_stairs_a_deck", "connect_grand_stairs_to_lounge");
    zm_zonemgr::add_adjacent_zone("zone_lounge", "zone_grand_stairs_b_deck", "connect_grand_stairs_to_lounge");
    zm_zonemgr::add_adjacent_zone("zone_lounge", "zone_lounge_aft_deck", "connect_suites_to_aft");
    zm_zonemgr::add_adjacent_zone("zone_fore_deck", "zone_grand_stairs_a_deck", "connect_grand_stairs_to_boat_deck");
    zm_zonemgr::add_adjacent_zone("zone_fore_deck", "zone_mid_deck", "connect_grand_stairs_to_boat_deck");
    zm_zonemgr::add_adjacent_zone("zone_fore_deck", "zone_mid_deck", "power_on");
    zm_zonemgr::add_adjacent_zone("zone_mid_deck", "zone_fore_deck", "connect_grand_stairs_to_boat_deck");
    zm_zonemgr::add_adjacent_zone("zone_mid_deck", "zone_fore_deck", "power_on");
    zm_zonemgr::add_adjacent_zone("zone_mid_deck", "zone_promenade_deck", "connect_foredeck_promenade");
    zm_zonemgr::add_adjacent_zone("zone_mid_deck", "zone_sun_deck_stbd", "power_on");
    zm_zonemgr::add_adjacent_zone("zone_mid_deck", "zone_sun_deck_port", "power_on");
    zm_zonemgr::add_adjacent_zone("zone_mid_deck", "zone_lounge_aft_deck", "power_on");
    zm_zonemgr::add_adjacent_zone("zone_sun_deck_stbd", "zone_mid_deck", "power_on");
    zm_zonemgr::add_adjacent_zone("zone_sun_deck_stbd", "zone_aft_deck", "power_on");
    zm_zonemgr::add_adjacent_zone("zone_sun_deck_port", "zone_mid_deck", "power_on");
    zm_zonemgr::add_adjacent_zone("zone_sun_deck_port", "zone_lounge_aft_deck", "power_on");
    zm_zonemgr::add_adjacent_zone("zone_sun_deck_port", "zone_promenade_deck", "power_on");
    zm_zonemgr::add_adjacent_zone("zone_aft_deck", "zone_sun_deck_stbd", "power_on");
    zm_zonemgr::add_adjacent_zone("zone_aft_deck", "zone_lounge_aft_deck", "connect_suites_to_aft");
    zm_zonemgr::add_adjacent_zone("zone_aft_deck", "zone_lounge_aft_deck", "connect_aft_to_poop_deck");
    zm_zonemgr::add_adjacent_zone("zone_aft_deck", "zone_lounge_aft_deck", "power_on");
    zm_zonemgr::add_adjacent_zone("zone_aft_deck", "zone_aft_deck_lower", "connect_aft_to_poop_deck");
    zm_zonemgr::add_adjacent_zone("zone_lounge_aft_deck", "zone_mid_deck", "power_on");
    zm_zonemgr::add_adjacent_zone("zone_lounge_aft_deck", "zone_lounge", "connect_suites_to_aft");
    zm_zonemgr::add_adjacent_zone("zone_lounge_aft_deck", "zone_aft_deck", "connect_suites_to_aft");
    zm_zonemgr::add_adjacent_zone("zone_lounge_aft_deck", "zone_aft_deck", "connect_aft_to_poop_deck");
    zm_zonemgr::add_adjacent_zone("zone_lounge_aft_deck", "zone_aft_deck", "power_on");
    zm_zonemgr::add_adjacent_zone("zone_lounge_aft_deck", "zone_sun_deck_port", "power_on");
    zm_zonemgr::add_adjacent_zone("zone_promenade_deck", "zone_aft_deck_lower", "connect_promenade_to_poop");
    zm_zonemgr::add_adjacent_zone("zone_promenade_deck", "zone_mid_deck", "connect_foredeck_promenade");
    zm_zonemgr::add_adjacent_zone("zone_promenade_deck", "zone_galley", "connect_dining_to_promenade");
    zm_zonemgr::add_adjacent_zone("zone_promenade_deck", "zone_sun_deck_port", "power_on");
    zm_zonemgr::add_adjacent_zone("zone_aft_deck_lower", "zone_promenade_deck", "connect_promenade_to_poop");
    zm_zonemgr::add_adjacent_zone("zone_aft_deck_lower", "zone_poop_deck_lower", "connect_promenade_to_poop");
    zm_zonemgr::add_adjacent_zone("zone_aft_deck_lower", "zone_aft_deck", "connect_aft_to_poop_deck");
    zm_zonemgr::add_adjacent_zone("zone_aft_deck_lower", "zone_poop_deck_lower", "connect_aft_to_poop_deck");
    zm_zonemgr::add_adjacent_zone("zone_poop_deck", "zone_poop_deck_lower", "connect_aft_to_poop_deck");
    zm_zonemgr::add_adjacent_zone("zone_poop_deck", "zone_poop_deck_lower", "connect_promenade_to_poop");
    zm_zonemgr::add_adjacent_zone("zone_poop_deck_lower", "zone_poop_deck", "connect_aft_to_poop_deck");
    zm_zonemgr::add_adjacent_zone("zone_poop_deck_lower", "zone_poop_deck", "connect_promenade_to_poop");
    zm_zonemgr::add_adjacent_zone("zone_poop_deck_lower", "zone_aft_deck_lower", "connect_aft_to_poop_deck");
    zm_zonemgr::add_adjacent_zone("zone_poop_deck_lower", "zone_aft_deck_lower", "connect_promenade_to_poop");
    zm_zonemgr::add_adjacent_zone("zone_poop_deck_lower", "zone_berths", "connect_berths_to_poop_deck");
    zm_zonemgr::add_adjacent_zone("zone_cargo", "zone_mail_room", "connect_mail_rooms_to_cargo");
    zm_zonemgr::add_adjacent_zone("zone_mail_room", "zone_forecastle_lower", "connect_forecastle_to_mail");
    zm_zonemgr::add_adjacent_zone("zone_mail_room", "zone_cargo", "connect_mail_rooms_to_cargo");
    zm_zonemgr::add_adjacent_zone("zone_berths", "zone_poop_deck_lower", "connect_berths_to_poop_deck");
    zm_zonemgr::add_adjacent_zone("zone_berths", "zone_berths_subdeck", "connect_berths_to_poop_deck");
    zm_zonemgr::add_adjacent_zone("zone_berths_subdeck", "zone_berths", "connect_berths_to_poop_deck");
    zm_zonemgr::add_adjacent_zone("zone_berths_subdeck", "zone_provisions", "connect_berths_provisions");
    zm_zonemgr::add_zone_flags("connect_berths_to_poop_deck", "connect_berths_provisions");
    zm_zonemgr::add_adjacent_zone("zone_provisions", "zone_berths_subdeck", "connect_berths_provisions");
    zm_zonemgr::add_adjacent_zone("zone_provisions", "zone_upper_engine_room", "connect_provisions_to_engine_room");
    zm_zonemgr::add_zone_flags("connect_grand_stairs_to_boat_deck", "power_on");
    zm_zonemgr::add_zone_flags("connect_cargo_to_mail_room", "power_on");
    zm_zonemgr::add_zone_flags("connect_engine", "power_on");
    zm_zonemgr::add_adjacent_zone("zone_upper_engine_room", "zone_provisions", "connect_provisions_to_engine_room");
    zm_zonemgr::add_adjacent_zone("zone_engine", "zone_upper_engine_room", "connect_provisions_to_engine_room", 0);
    zm_zonemgr::add_adjacent_zone("zone_engine", "zone_boiler_room", "connect_provisions_to_engine_room", 0);
    zm_zonemgr::add_adjacent_zone("zone_engine", "zone_turbine_room", "connect_provisions_to_engine_room", 0);
}

// Namespace zm_zodt8/zm_zodt8
// Params 1, eflags: 0x0
// Checksum 0xb214a0bf, Offset: 0x6c30
// Size: 0x172
function function_93443875(str_zone_name) {
    switch (str_zone_name) {
    case #"zone_zipline_fore":
    case #"zone_zipline_aft":
        foreach (e_player in getplayers()) {
            if (isdefined(e_player.var_56c7266a) && e_player.var_56c7266a) {
                if (e_player.var_cdec605d === "aft_to_fore" && str_zone_name == "zone_zipline_fore") {
                    return 1;
                }
                if (e_player.var_cdec605d === "fore_to_aft" && str_zone_name == "zone_zipline_aft") {
                    return 1;
                }
            }
        }
        return zm_zonemgr::any_player_in_zone(str_zone_name);
    default:
        return zm_zonemgr::any_player_in_zone(str_zone_name);
    }
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x0
// Checksum 0x2cba6db2, Offset: 0x6db0
// Size: 0x24
function function_7837e42a() {
    zm_weapons::load_weapon_spec_from_table(#"gamedata/weapons/zm/zm_zodt8_weapons.csv", 0);
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x0
// Checksum 0xa6bd39d5, Offset: 0x6de0
// Size: 0x64
function custom_add_vox() {
    zm_audio::loadplayervoicecategories(#"hash_41c3d60c9fdc1c1a");
    zm_audio::loadplayervoicecategories(#"hash_5963a3db3032ab46");
    zm_audio::loadplayervoicecategories(#"hash_34c18561cc19c360");
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x0
// Checksum 0xee849961, Offset: 0x6e50
// Size: 0x87e
function function_62adf486() {
    var_8133ca06 = getplayers();
    var_8133ca06 = function_a1e11af(var_8133ca06);
    foreach (e_target in var_8133ca06) {
        if (!isdefined(e_target.var_bf9a9362)) {
            e_target.var_bf9a9362 = 0;
        }
    }
    var_8133ca06 = function_f8608b8(var_8133ca06);
    var_b6349cf = function_11502d52();
    var_36483880 = [];
    foreach (e_player in var_8133ca06) {
        if (isdefined(e_player.zone_name)) {
            if (!isinarray(var_b6349cf, e_player.zone_name) && !isinarray(var_b6349cf, hash(e_player.zone_name))) {
                if (!isdefined(var_36483880)) {
                    var_36483880 = [];
                } else if (!isarray(var_36483880)) {
                    var_36483880 = array(var_36483880);
                }
                var_36483880[var_36483880.size] = e_player;
            }
        }
    }
    if (var_36483880.size) {
        var_b6c78991 = var_36483880[0];
    } else if (var_8133ca06.size) {
        var_b6c78991 = var_8133ca06[0];
    }
    if (!isdefined(var_b6c78991)) {
        return undefined;
    }
    var_b6c78991.var_bf9a9362++;
    str_player_zone = isdefined(var_b6c78991.zone_name) ? var_b6c78991.zone_name : var_b6c78991 zm_utility::get_current_zone();
    a_s_spawn_locs = [];
    if (isdefined(str_player_zone)) {
        if (isdefined(level.zm_loc_types[#"stoker_location"]) && level.zm_loc_types[#"stoker_location"].size > 0) {
            foreach (s_loc in level.zm_loc_types[#"stoker_location"]) {
                if (s_loc.zone_name === str_player_zone) {
                    /#
                        if (getdvarint(#"hash_1f8efa579fee787c", 0)) {
                            iprintlnbold("<dev string:x30>" + s_loc.zone_name + "<dev string:x4b>");
                        }
                    #/
                    if (!isdefined(a_s_spawn_locs)) {
                        a_s_spawn_locs = [];
                    } else if (!isarray(a_s_spawn_locs)) {
                        a_s_spawn_locs = array(a_s_spawn_locs);
                    }
                    a_s_spawn_locs[a_s_spawn_locs.size] = s_loc;
                }
            }
        }
        if (!a_s_spawn_locs.size) {
            var_39b0b810 = getnodearray(str_player_zone, "targetname");
            var_9121b830 = var_39b0b810[0];
            if (isdefined(var_9121b830.target)) {
                var_bae0069e = struct::get_array(var_9121b830.target, "targetname");
                foreach (var_c0854407 in var_bae0069e) {
                    if (var_c0854407.script_noteworthy === "stoker_location") {
                        /#
                            if (getdvarint(#"hash_1f8efa579fee787c", 0)) {
                                iprintlnbold("<dev string:x61>");
                            }
                        #/
                        if (!isdefined(a_s_spawn_locs)) {
                            a_s_spawn_locs = [];
                        } else if (!isarray(a_s_spawn_locs)) {
                            a_s_spawn_locs = array(a_s_spawn_locs);
                        }
                        a_s_spawn_locs[a_s_spawn_locs.size] = var_c0854407;
                    }
                }
            }
        }
        if (!a_s_spawn_locs.size) {
            var_8c9779af = zm_cleanup::get_adjacencies_to_zone(str_player_zone);
            var_8c9779af = array::randomize(var_8c9779af);
            foreach (var_21e0f10c in var_8c9779af) {
                var_39b0b810 = getnodearray(level.zones[var_21e0f10c].name, "targetname");
                var_9121b830 = var_39b0b810[0];
                if (isdefined(var_9121b830.target)) {
                    var_bae0069e = struct::get_array(var_9121b830.target, "targetname");
                    foreach (var_c0854407 in var_bae0069e) {
                        if (var_c0854407.script_noteworthy === "stoker_location") {
                            /#
                                if (getdvarint(#"hash_1f8efa579fee787c", 0)) {
                                    iprintlnbold("<dev string:x30>" + s_loc.zone_name + "<dev string:xa7>");
                                }
                            #/
                            if (!isdefined(a_s_spawn_locs)) {
                                a_s_spawn_locs = [];
                            } else if (!isarray(a_s_spawn_locs)) {
                                a_s_spawn_locs = array(a_s_spawn_locs);
                            }
                            a_s_spawn_locs[a_s_spawn_locs.size] = var_c0854407;
                        }
                    }
                }
            }
        }
    } else {
        /#
            if (getdvarint(#"hash_1f8efa579fee787c", 0)) {
                iprintlnbold("<dev string:xc6>");
            }
        #/
    }
    if (a_s_spawn_locs.size) {
        return array::random(a_s_spawn_locs);
    }
    /#
        if (getdvarint(#"hash_1f8efa579fee787c", 0)) {
            iprintlnbold("<dev string:xf0>");
        }
    #/
    return undefined;
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x0
// Checksum 0xe99464ce, Offset: 0x76d8
// Size: 0x1a0
function function_407dc692() {
    var_b6349cf = function_11502d52();
    var_e5ff5926 = isdefined(self.zone_name) ? self.zone_name : zm_zonemgr::get_zone_from_position(self.origin);
    if (!isinarray(var_b6349cf, var_e5ff5926)) {
        /#
            if (getdvarint(#"hash_1f8efa579fee787c", 0)) {
                iprintlnbold("<dev string:x115>" + (isdefined(var_e5ff5926) ? var_e5ff5926 : "<dev string:x13d>"));
            }
        #/
        return true;
    }
    if (!isdefined(self.var_c320c149)) {
        self.var_c320c149 = gettime() - 5000;
    }
    n_time = gettime();
    if (gettime() - self.var_c320c149 <= 200) {
        /#
            if (getdvarint(#"hash_1f8efa579fee787c", 0)) {
                iprintlnbold("<dev string:x14c>" + (ishash(var_e5ff5926) ? function_15979fa9(var_e5ff5926) : var_e5ff5926));
            }
        #/
        return true;
    }
    self.var_c320c149 = gettime();
    return false;
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x0
// Checksum 0xdb375e9a, Offset: 0x7880
// Size: 0x910
function function_f7ba5491() {
    if (!isdefined(level.var_e899fd7b)) {
        level.var_e899fd7b = struct::get_array("blight_father_location", "script_noteworthy");
    }
    if (level.var_e899fd7b.size < 1) {
        self.b_ignore_cleanup = 1;
        return true;
    }
    var_e8c20bad = arraycopy(level.players);
    var_e8c20bad = function_a1e11af(var_e8c20bad);
    var_b6349cf = function_11502d52();
    var_9e35884e = [];
    foreach (e_player in var_e8c20bad) {
        str_player_zone = isdefined(e_player.zone_name) ? e_player.zone_name : e_player zm_utility::get_current_zone();
        if (isdefined(str_player_zone)) {
            if (!isdefined(var_9e35884e)) {
                var_9e35884e = [];
            } else if (!isarray(var_9e35884e)) {
                var_9e35884e = array(var_9e35884e);
            }
            var_9e35884e[var_9e35884e.size] = str_player_zone;
        }
    }
    var_e0e3f478 = 0;
    var_b7c68fb1 = [];
    if (var_9e35884e.size) {
        for (var_9b4e2d05 = 0; var_9b4e2d05 < 2; var_9b4e2d05++) {
            if (!var_e0e3f478) {
                foreach (var_ec1c9465 in level.var_e899fd7b) {
                    if (isdefined(level.zm_loc_types[#"blight_father_location"]) && level.zm_loc_types[#"blight_father_location"].size > 0) {
                        foreach (s_loc in level.zm_loc_types[#"blight_father_location"]) {
                            if (isinarray(var_9e35884e, s_loc.zone_name)) {
                                if (!var_9b4e2d05) {
                                    if (!isinarray(var_b6349cf, s_loc.zone_name)) {
                                        if (!isdefined(var_b7c68fb1)) {
                                            var_b7c68fb1 = [];
                                        } else if (!isarray(var_b7c68fb1)) {
                                            var_b7c68fb1 = array(var_b7c68fb1);
                                        }
                                        var_b7c68fb1[var_b7c68fb1.size] = s_loc;
                                        var_e0e3f478 = 1;
                                    }
                                    continue;
                                }
                                if (!isdefined(var_b7c68fb1)) {
                                    var_b7c68fb1 = [];
                                } else if (!isarray(var_b7c68fb1)) {
                                    var_b7c68fb1 = array(var_b7c68fb1);
                                }
                                var_b7c68fb1[var_b7c68fb1.size] = s_loc;
                                var_e0e3f478 = 1;
                            }
                        }
                    }
                }
            }
            if (!var_e0e3f478) {
                foreach (str_player_zone in var_9e35884e) {
                    if (!var_9b4e2d05) {
                        if (isinarray(var_b6349cf, str_player_zone)) {
                            continue;
                        }
                    }
                    var_39b0b810 = getnodearray(str_player_zone, "targetname");
                    var_9121b830 = var_39b0b810[0];
                    if (isdefined(var_9121b830) && isdefined(var_9121b830.target)) {
                        var_bae0069e = struct::get_array(var_9121b830.target, "targetname");
                        foreach (var_c0854407 in var_bae0069e) {
                            if (var_c0854407.script_noteworthy === "blight_father_location") {
                                if (!isdefined(var_b7c68fb1)) {
                                    var_b7c68fb1 = [];
                                } else if (!isarray(var_b7c68fb1)) {
                                    var_b7c68fb1 = array(var_b7c68fb1);
                                }
                                var_b7c68fb1[var_b7c68fb1.size] = var_c0854407;
                                var_e0e3f478 = 1;
                            }
                        }
                    }
                }
            }
            if (!var_e0e3f478) {
                foreach (str_player_zone in var_9e35884e) {
                    if (!var_9b4e2d05) {
                        if (isinarray(var_b6349cf, str_player_zone)) {
                            continue;
                        }
                    }
                    var_8c9779af = zm_cleanup::get_adjacencies_to_zone(str_player_zone);
                    var_8c9779af = array::randomize(var_8c9779af);
                    foreach (var_21e0f10c in var_8c9779af) {
                        var_39b0b810 = getnodearray(level.zones[var_21e0f10c].name, "targetname");
                        var_9121b830 = var_39b0b810[0];
                        if (isdefined(var_9121b830.target)) {
                            var_bae0069e = struct::get_array(var_9121b830.target, "targetname");
                            foreach (var_c0854407 in var_bae0069e) {
                                if (var_c0854407.script_noteworthy === "blight_father_location") {
                                    if (!isdefined(var_b7c68fb1)) {
                                        var_b7c68fb1 = [];
                                    } else if (!isarray(var_b7c68fb1)) {
                                        var_b7c68fb1 = array(var_b7c68fb1);
                                    }
                                    var_b7c68fb1[var_b7c68fb1.size] = var_c0854407;
                                    var_e0e3f478 = 1;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    if (isalive(self) && var_b7c68fb1.size) {
        self.completed_emerging_into_playable_area = 0;
        var_a2cdabee = array::random(var_b7c68fb1);
        self forceteleport(var_a2cdabee.origin);
    } else {
        /#
            if (getdvarint(#"hash_1f8efa579fee787c", 0)) {
                iprintlnbold("<dev string:x17c>");
            }
        #/
    }
    return true;
}

// Namespace zm_zodt8/zm_zodt8
// Params 1, eflags: 0x0
// Checksum 0x8a65339, Offset: 0x8198
// Size: 0x32
function function_a1e11af(&array) {
    return array::filter(array, 0, &function_4f4dfe5d);
}

// Namespace zm_zodt8/zm_zodt8
// Params 1, eflags: 0x0
// Checksum 0xbc0ec48c, Offset: 0x81d8
// Size: 0x28
function function_4f4dfe5d(e_player) {
    return isdefined(e_player.am_i_valid) && e_player.am_i_valid;
}

// Namespace zm_zodt8/zm_zodt8
// Params 1, eflags: 0x0
// Checksum 0x6b45788f, Offset: 0x8208
// Size: 0x32
function function_f8608b8(&a_ents) {
    return array::merge_sort(a_ents, &function_dc4198e1, 1);
}

// Namespace zm_zodt8/zm_zodt8
// Params 3, eflags: 0x0
// Checksum 0x5e858fbe, Offset: 0x8248
// Size: 0x34
function function_dc4198e1(e1, e2, b_lowest_first) {
    return e1.var_bf9a9362 <= e2.var_bf9a9362;
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x0
// Checksum 0x71894fa6, Offset: 0x8288
// Size: 0x146
function function_11502d52() {
    var_b6349cf = [];
    var_5877d71a = [];
    var_5877d71a = getaiarchetypearray("stoker");
    var_5877d71a = arraycombine(var_5877d71a, getaiarchetypearray("blight_father"), 0, 0);
    for (i = 0; i < var_5877d71a.size; i++) {
        var_ffbb686c = isdefined(var_5877d71a[i].zone_name) ? var_5877d71a[i].zone_name : zm_zonemgr::get_zone_from_position(var_5877d71a[i].origin);
        if (isdefined(var_ffbb686c)) {
            if (!isdefined(var_b6349cf)) {
                var_b6349cf = [];
            } else if (!isarray(var_b6349cf)) {
                var_b6349cf = array(var_b6349cf);
            }
            var_b6349cf[var_b6349cf.size] = var_ffbb686c;
        }
    }
    return var_b6349cf;
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x0
// Checksum 0xb8c14e84, Offset: 0x83d8
// Size: 0x94
function sndfunctions() {
    if (zm_utility::is_standard()) {
        level.zmannouncerprefix = "vox_rush_";
    } else {
        level.zmannouncerprefix = "vox_prst_";
    }
    zm_utility::add_sound("zmb_heavy_door_open", "zmb_heavy_door_open");
    level thread setupmusic();
    level thread custom_add_vox();
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x0
// Checksum 0x3c344803, Offset: 0x8478
// Size: 0x1ac
function setupmusic() {
    zm_audio::musicstate_create("round_start", 3, "zodt8_roundstart_1", "zodt8_roundstart_2");
    zm_audio::musicstate_create("round_start_first", 3, "zodt8_roundstart_first_1");
    zm_audio::musicstate_create("round_end", 3, "zodt8_roundend_1", "zodt8_roundend_2", "zodt8_roundend_3");
    zm_audio::musicstate_create("game_over", 5, "gameover");
    zm_audio::musicstate_create("sentinel_artifact_activated", 4, "zodt8_sentinel_artifact");
    level thread zm_audio::function_105831ac(#"hash_69ebb1abe1e2d695", "location_staterooms");
    level thread zm_audio::function_105831ac(#"hash_4254e25038a56598", "location_stairwell");
    level thread zm_audio::function_105831ac(#"hash_1f322078edfcfba3", "location_bowels");
    level thread zm_audio::function_105831ac(#"hash_3325f6b80c910400", "location_dining_room");
    level thread zm_audio::function_105831ac(#"hash_64c435d9bd0cdd9e", "location_aft_deck");
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x0
// Checksum 0xe4dbc0ce, Offset: 0x8630
// Size: 0xdc
function on_player_spawned() {
    self thread function_21c53c36();
    self thread function_da2970c7();
    level flag::wait_till(#"start_zombie_round_logic");
    level flag::wait_till(#"water_initialized");
    self thread function_b722fadf();
    level.e_clip_water_fore clientfield::increment("update_wave_water_height", 1);
    level.e_clip_water_aft clientfield::increment("update_wave_water_height", 1);
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x0
// Checksum 0x15b05393, Offset: 0x8718
// Size: 0x168
function function_b722fadf() {
    e_water = getent("ocean_water_hidden", "script_noteworthy");
    var_9d5a9bd = array("zone_mail_room", "zone_cargo", "zone_upper_engine_room", "zone_engine", "zone_boiler_room", "zone_turbine_room");
    self thread function_4ae5315(e_water);
    while (true) {
        s_result = self waittill(#"zone_change", #"death", #"hash_20a44fff6b27cb96");
        if (s_result._notify == #"zone_change") {
            if (!self.var_81efcfd1 && isinarray(var_9d5a9bd, s_result.zone_name)) {
                e_water setinvisibletoplayer(self, 1);
            } else {
                e_water setinvisibletoplayer(self, 0);
            }
            continue;
        }
        break;
    }
}

// Namespace zm_zodt8/zm_zodt8
// Params 1, eflags: 0x0
// Checksum 0x49c19abf, Offset: 0x8888
// Size: 0x138
function function_4ae5315(e_water) {
    self endon(#"death");
    e_trigger = getent("water_vis_trigger", "targetname");
    while (true) {
        self.var_81efcfd1 = 0;
        trigger::wait_till("water_vis_trigger", "targetname", self);
        self.var_81efcfd1 = 1;
        if (self.cached_zone_name === "zone_mail_room") {
            e_water setinvisibletoplayer(self, 0);
        }
        while (self istouching(e_trigger)) {
            waitframe(1);
        }
        if (self zm_zonemgr::is_player_in_zone(array("zone_mail_room"))) {
            e_water setinvisibletoplayer(self, 1);
        }
    }
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x0
// Checksum 0x1553c1c5, Offset: 0x89c8
// Size: 0xc0
function function_da2970c7() {
    self endon(#"disconnect");
    while (true) {
        str_location = function_50f2bc89(self);
        str_location = isdefined(str_location) ? str_location : #"";
        if (isalive(self)) {
            self zm_hud::function_3a4fb187(str_location);
        } else {
            self zm_hud::function_3a4fb187(#"");
        }
        wait 0.5;
    }
}

// Namespace zm_zodt8/zm_zodt8
// Params 1, eflags: 0x0
// Checksum 0x402e6850, Offset: 0x8a90
// Size: 0x4fe
function function_50f2bc89(e_player) {
    str_zone = e_player zm_zonemgr::get_player_zone();
    if (!isdefined(str_zone)) {
        if (e_player.var_56c7266a !== 1 && level flag::get(#"hash_280d10a2ac060edb")) {
            return #"hash_51b7577e1fe8e0da";
        }
        return undefined;
    }
    switch (str_zone) {
    case #"zone_forecastle_upper":
    case #"zone_forecastle_lower":
        str_display = #"hash_4800ed4f22425bbb";
        break;
    case #"zone_state_rooms_front":
    case #"zone_state_rooms_rear":
        str_display = #"hash_69ebb1abe1e2d695";
        break;
    case #"millionaire_suite_zone":
        str_display = #"hash_302fc7a8b597825c";
        break;
    case #"zone_bridge":
        str_display = #"hash_6e14395e9fafcfb8";
        break;
    case #"zone_grand_stairs_c_deck":
    case #"zone_grand_stairs_d_deck":
    case #"zone_grand_stairs_bottom":
        str_display = #"hash_40db3f8450c1cdd1";
        break;
    case #"zone_grand_stairs_a_deck":
    case #"zone_grand_stairs_b_deck":
        str_display = #"hash_23a9baa5b7fb1b8";
        break;
    case #"zone_lounge":
        str_display = #"hash_21aaa58eff63ee6f";
        break;
    case #"zone_dining_hall_aft":
    case #"zone_dining_hall_fore":
        str_display = #"hash_3325f6b80c910400";
        break;
    case #"zone_galley":
        str_display = #"hash_1b6d24a149bb4863";
        break;
    case #"zone_promenade_deck":
        str_display = #"hash_4254e25038a56598";
        break;
    case #"zone_lounge_aft_deck":
        str_display = #"hash_577acc33401ccf26";
        break;
    case #"zone_aft_deck_lower":
    case #"zone_aft_deck":
        str_display = #"hash_64c435d9bd0cdd9e";
        break;
    case #"zone_sun_deck_stbd":
        str_display = #"hash_38887942b83c8cbb";
        break;
    case #"zone_fore_deck":
        str_display = #"hash_5c9be164190cf031";
        break;
    case #"zone_sun_deck_port":
    case #"zone_mid_deck":
        str_display = #"hash_7361752642f5d7cf";
        break;
    case #"zone_poop_deck":
    case #"zone_poop_deck_lower":
        str_display = #"hash_788531c390c09f9";
        break;
    case #"zone_berths":
    case #"zone_berths_subdeck":
        str_display = #"hash_1f322078edfcfba3";
        break;
    case #"zone_provisions":
        str_display = #"hash_4e21f45a939d9031";
        break;
    case #"zone_upper_engine_room":
    case #"zone_engine":
        str_display = #"hash_118b4d5763e21783";
        break;
    case #"zone_boiler_room":
        str_display = #"hash_21f25d50ac7b1ae0";
        break;
    case #"zone_turbine_room":
        str_display = #"hash_5479cc9d545c2adc";
        break;
    case #"zone_cargo":
        str_display = #"hash_35000bfda3024a1f";
        break;
    case #"zone_mail_room":
        str_display = #"hash_79da5cb2d068ceb6";
        break;
    default:
        str_display = undefined;
        break;
    }
    return str_display;
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x0
// Checksum 0xb05763f9, Offset: 0x8f98
// Size: 0x154
function function_21c53c36() {
    self thread zm_audio::function_83711320(#"hash_23a9baa5b7fb1b8", #"grandstairs");
    self thread zm_audio::function_83711320(#"hash_3325f6b80c910400", #"dininghall");
    self thread zm_audio::function_83711320(#"hash_21aaa58eff63ee6f", #"lounge");
    self thread zm_audio::function_83711320(#"hash_1f322078edfcfba3", #"berths");
    self thread zm_audio::function_83711320(#"hash_118b4d5763e21783", #"engineroom");
    self thread zm_audio::function_83711320(#"hash_35000bfda3024a1f", #"cargohold");
    self thread function_72e7d32d();
    self thread function_8f655031();
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x0
// Checksum 0xd0d2dc7b, Offset: 0x90f8
// Size: 0x7c
function function_72e7d32d() {
    self endon(#"death");
    self endon(#"disconnect");
    while (!self isplayerunderwater()) {
        waitframe(1);
    }
    if (level.musicsystem.currentplaytype == 0) {
        music::setmusicstate("location_underwater", self);
    }
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x0
// Checksum 0x725ed580, Offset: 0x9180
// Size: 0x98
function function_8f655031() {
    self endon(#"death");
    self endon(#"disconnect");
    level endon(#"hash_361427de75870cde");
    self waittill(#"hash_361427de75870cde");
    if (level.musicsystem.currentplaytype == 0) {
        music::setmusicstate("zodt8_underwater_switch", self);
    }
    level notify(#"hash_361427de75870cde");
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x0
// Checksum 0xbbb09f1c, Offset: 0x9220
// Size: 0x16a
function function_869d6f66() {
    s_point = zm_bgb_anywhere_but_here::function_728dfe3();
    if (!isdefined(s_point)) {
        return false;
    }
    a_s_respawn_points = struct::get_array("player_respawn_point", "targetname");
    a_s_valid_respawn_points = [];
    foreach (s_respawn_point in a_s_respawn_points) {
        if (zm_utility::is_point_inside_enabled_zone(s_respawn_point.origin)) {
            if (!isdefined(a_s_valid_respawn_points)) {
                a_s_valid_respawn_points = [];
            } else if (!isarray(a_s_valid_respawn_points)) {
                a_s_valid_respawn_points = array(a_s_valid_respawn_points);
            }
            a_s_valid_respawn_points[a_s_valid_respawn_points.size] = s_respawn_point;
        }
    }
    if (a_s_valid_respawn_points.size == 1 && a_s_valid_respawn_points[0].script_noteworthy == "zone_forecastle_upper") {
        return false;
    }
    return true;
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x0
// Checksum 0x1c81b580, Offset: 0x9398
// Size: 0x62
function function_b6e81445() {
    if (isdefined(self.var_56c7266a) && self.var_56c7266a || !self isonground() || !ispointonnavmesh(self.origin, self)) {
        return false;
    }
    return true;
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x0
// Checksum 0x1c0c37ca, Offset: 0x9408
// Size: 0x1c8
function function_59eb1245() {
    if (self ai::has_behavior_attribute("gravity")) {
        while (isalive(self)) {
            if (level flag::get(#"activate_sea_walkers")) {
                self ai::set_behavior_attribute("gravity", "low");
            } else {
                depth = getwaterheight(self.origin) - self.origin[2];
                if (depth > 48) {
                    self ai::set_behavior_attribute("gravity", "low");
                    if (!self clientfield::get("sndActorUnderwater")) {
                        self clientfield::set("sndActorUnderwater", 1);
                    }
                } else if (self ai::get_behavior_attribute("gravity") != "normal") {
                    self ai::set_behavior_attribute("gravity", "normal");
                    if (self clientfield::get("sndActorUnderwater")) {
                        self clientfield::set("sndActorUnderwater", 0);
                    }
                }
            }
            wait 0.5;
        }
    }
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x0
// Checksum 0x8dff7508, Offset: 0x95d8
// Size: 0x36
function function_f70551f4() {
    level.var_18e96d09 = &function_302c8417;
    level.var_6a5cf7c6 = &function_89c5074c;
}

// Namespace zm_zodt8/zm_zodt8
// Params 2, eflags: 0x0
// Checksum 0x9efa4744, Offset: 0x9618
// Size: 0x646
function function_302c8417(player, var_796a4e2a) {
    b_result = 0;
    if (isdefined(self.stub)) {
        str_loc = self.stub.script_string;
    }
    if (!isdefined(self.hint_string)) {
        self.hint_string = [];
    }
    n_player_index = player getentitynumber();
    if (zm_trial_disable_buys::is_active()) {
        self.hint_string[n_player_index] = #"";
        return 0;
    }
    if (!self zm_fasttravel::function_a2ffb0c6(player)) {
        self.hint_string[n_player_index] = #"";
    } else if (isdefined(self.stub.var_7e252f66) && !level flag::get(self.stub.var_7e252f66)) {
        switch (self.stub.var_7e252f66) {
        case #"connect_provisions_to_engine_room":
            self.hint_string[n_player_index] = #"hash_6134f96bfd8584b9";
            break;
        case #"connect_mail_rooms_to_cargo":
            self.hint_string[n_player_index] = #"hash_2bdcee65a214c377";
            break;
        default:
            self.hint_string[n_player_index] = #"";
            break;
        }
        b_result = 1;
    } else if (isdefined(player.var_bf7ec16c[var_796a4e2a]) && player.var_bf7ec16c[var_796a4e2a]) {
        self.hint_string[n_player_index] = #"hash_7667bd0f83307360";
        b_result = 1;
    } else if (isdefined(self.stub.delay) && !self.stub flag::get("delayed")) {
        self.hint_string[n_player_index] = #"zombie/fasttravel_delay";
        b_result = 1;
    } else {
        switch (str_loc) {
        case #"aft_to_fore":
            if (zm_utility::is_standard()) {
                self.hint_string[n_player_index] = #"hash_4b2858f776c52ccd";
            } else {
                self.hint_string[n_player_index] = #"hash_700c960774ba5e4a";
            }
            break;
        case #"fore_to_aft":
            if (zm_utility::is_standard()) {
                self.hint_string[n_player_index] = #"hash_62ae1c4f8ac4e714";
            } else {
                self.hint_string[n_player_index] = #"hash_3a81aa36cd6dd5cd";
            }
            break;
        case #"hash_6976e0f87940fc21":
            if (zm_utility::is_standard()) {
                self.hint_string[n_player_index] = #"hash_562ff3387984d58f";
            } else {
                self.hint_string[n_player_index] = #"hash_1dc8421f2e165fc4";
            }
            break;
        case #"hash_b20cb95c337f16d":
            if (zm_utility::is_standard()) {
                self.hint_string[n_player_index] = #"hash_6208942bcbbe4e11";
            } else {
                self.hint_string[n_player_index] = #"hash_5b6a4c36df9369b6";
            }
            break;
        case #"cargo":
            if (zm_utility::is_standard()) {
                self.hint_string[n_player_index] = #"hash_4ab3571c0c7854bc";
            } else {
                self.hint_string[n_player_index] = #"hash_133d9515d811aa75";
            }
            break;
        case #"engine_room":
            if (zm_utility::is_standard()) {
                self.hint_string[n_player_index] = #"hash_7a287075190064ab";
            } else {
                self.hint_string[n_player_index] = #"hash_87c8f2dc2aee648";
            }
            break;
        case #"boiler_room":
            if (zm_utility::is_standard()) {
                self.hint_string[n_player_index] = #"hash_7ad135e043cefb4b";
            } else {
                self.hint_string[n_player_index] = #"hash_4e6660ce01be0ca8";
            }
            break;
        case #"suites":
            if (zm_utility::is_standard()) {
                self.hint_string[n_player_index] = #"hash_3f66eedf08d403bb";
            } else {
                self.hint_string[n_player_index] = #"hash_59f561a519beb2f8";
            }
            break;
        default:
            self.hint_string[n_player_index] = #"hash_2731cc5c1208e2e4";
            break;
        }
        b_result = 1;
    }
    return b_result;
}

// Namespace zm_zodt8/zm_zodt8
// Params 0, eflags: 0x0
// Checksum 0xeae63e52, Offset: 0x9c68
// Size: 0x112
function function_89c5074c() {
    switch (self.unitrigger_stub.script_string) {
    case #"hash_b20cb95c337f16d":
    case #"hash_6976e0f87940fc21":
        self.unitrigger_stub.var_796a4e2a = "smoke_stack";
        break;
    case #"engine_room":
    case #"cargo":
        self.unitrigger_stub.var_796a4e2a = "engine_room";
        break;
    case #"fore_to_aft":
    case #"aft_to_fore":
        self.unitrigger_stub.var_796a4e2a = "top_deck";
        break;
    case #"boiler_room":
    case #"suites":
        self.unitrigger_stub.var_796a4e2a = "mid_ship";
        break;
    }
}

