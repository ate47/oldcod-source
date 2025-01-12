#using script_22ebc4167e3bcd3f;
#using script_2ba3951675c7ee1c;
#using script_36222395658446f5;
#using script_46cea9e5d4ef9e21;
#using script_602009d88d859543;
#using script_61ef84ea1a82c001;
#using script_668c4fbb94671fb4;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\zm\powerup\zm_powerup_bonus_points_team;
#using scripts\zm\powerup\zm_powerup_carpenter;
#using scripts\zm\powerup\zm_powerup_double_points;
#using scripts\zm\powerup\zm_powerup_fire_sale;
#using scripts\zm\powerup\zm_powerup_full_ammo;
#using scripts\zm\powerup\zm_powerup_hero_weapon_power;
#using scripts\zm\powerup\zm_powerup_insta_kill;
#using scripts\zm\powerup\zm_powerup_nuke;
#using scripts\zm\powerup\zm_powerup_zombie_blood;
#using scripts\zm\weapons\zm_weap_blundergat;
#using scripts\zm\weapons\zm_weap_claymore;
#using scripts\zm\weapons\zm_weap_cymbal_monkey;
#using scripts\zm\weapons\zm_weap_flamethrower;
#using scripts\zm\weapons\zm_weap_gravityspikes;
#using scripts\zm\weapons\zm_weap_katana;
#using scripts\zm\weapons\zm_weap_minigun;
#using scripts\zm\weapons\zm_weap_riotshield;
#using scripts\zm\weapons\zm_weap_spectral_shield;
#using scripts\zm\weapons\zm_weap_spoon;
#using scripts\zm\zm_escape_achievement;
#using scripts\zm\zm_escape_catwalk_event;
#using scripts\zm\zm_escape_fx;
#using scripts\zm\zm_escape_gamemodes;
#using scripts\zm\zm_escape_magicbox;
#using scripts\zm\zm_escape_pap_quest;
#using scripts\zm\zm_escape_paschal;
#using scripts\zm\zm_escape_pebble;
#using scripts\zm\zm_escape_spoon;
#using scripts\zm\zm_escape_sq_bg;
#using scripts\zm\zm_escape_traps;
#using scripts\zm\zm_escape_travel;
#using scripts\zm\zm_escape_util;
#using scripts\zm\zm_escape_vo_hooks;
#using scripts\zm\zm_escape_weap_quest;
#using scripts\zm_common\load;
#using scripts\zm_common\util\ai_brutus_util;
#using scripts\zm_common\util\ai_dog_util;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_characters;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_fasttravel;
#using scripts\zm_common\zm_hud;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_magicbox;
#using scripts\zm_common\zm_pack_a_punch;
#using scripts\zm_common\zm_pack_a_punch_util;
#using scripts\zm_common\zm_power;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_ui_inventory;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_wallbuy;
#using scripts\zm_common\zm_weapons;
#using scripts\zm_common\zm_zonemgr;

#namespace zm_escape;

// Namespace zm_escape/zm_escape
// Params 0, eflags: 0x2
// Checksum 0x8f31b3df, Offset: 0xd78
// Size: 0x42
function autoexec opt_in() {
    level.aat_in_use = 1;
    level.bgb_in_use = 1;
    level.bgb_machine_count = 2;
    level.random_pandora_box_start = 1;
}

// Namespace zm_escape/level_init
// Params 1, eflags: 0x40
// Checksum 0xa7981568, Offset: 0xdc8
// Size: 0xa9c
function event_handler[level_init] main(eventstruct) {
    level._uses_default_wallbuy_fx = 1;
    level._uses_sticky_grenades = 1;
    level._uses_taser_knuckles = 1;
    zm::init_fx();
    clientfield::register("clientuimodel", "" + #"player_lives", 1, 2, "int");
    clientfield::register("toplayer", "" + #"rumble_gondola", 1, 1, "int");
    clientfield::register("toplayer", "" + #"hash_51b0de5e2b184c28", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_4be2ce4248d80d22", 1, 1, "int");
    clientfield::register("world", "" + #"hash_24deaa9795e06d41", 1, 1, "int");
    clientfield::register("world", "" + #"hash_4a8a7b58bf6cd5d8", 1, 1, "int");
    clientfield::register("world", "" + #"hash_cd028842e18845e", 1, 1, "counter");
    zm_escape_catwalk_event::init_clientfields();
    namespace_a9db3299::init_clientfields();
    zm_escape_util::init_clientfields();
    namespace_d8b81d0b::init_clientfields();
    level._effect[#"eye_glow"] = #"zm_ai/fx8_zombie_eye_glow_red";
    level._effect[#"headshot"] = #"zombie/fx_bul_flesh_head_fatal_zmb";
    level._effect[#"headshot_nochunks"] = #"zombie/fx_bul_flesh_head_nochunks_zmb";
    level._effect[#"bloodspurt"] = #"zombie/fx_bul_flesh_neck_spurt_zmb";
    level._effect[#"animscript_gib_fx"] = #"zombie/fx_blood_torso_explo_zmb";
    level._effect[#"animscript_gibtrail_fx"] = #"blood/fx_blood_gib_limb_trail";
    level.var_97e174e9 = 1;
    level._no_vending_machine_auto_collision = 1;
    level.default_start_location = "prison";
    level.default_game_mode = "zclassic";
    level.disableclassselection = 0;
    level.var_a732b3aa = &function_c2cd1f49;
    level.zombiemode_offhand_weapon_give_override = &offhand_weapon_give_override;
    level.var_237b30e2 = &function_7837e42a;
    level._allow_melee_weapon_switching = 1;
    level.zombiemode_reusing_pack_a_punch = 1;
    level._effect[#"lght_marker"] = #"hash_2eb17822848d1484";
    level._effect[#"lght_marker_flare"] = #"hash_4d4ecfd7d55314e9";
    level._effect[#"poltergeist"] = #"hash_64ab8440e31c3057";
    include_weapons();
    namespace_bd4d66e5::init();
    paschal::init();
    zm_escape_achievement::init();
    level.custom_spawner_entry[#"crawl"] = &zm_spawner::function_48cfc7df;
    level.custom_spawner_entry[#"hash_67303f9697bd0645"] = &zm_spawner::function_48cfc7df;
    level.custom_spawner_entry[#"hash_cd17ca22402a02b"] = &zm_spawner::function_48cfc7df;
    level.custom_spawner_entry[#"hash_2764304c155bb1f9"] = &zm_spawner::function_48cfc7df;
    level.custom_spawner_entry[#"hash_25469b9705aa3afa"] = &zm_spawner::function_48cfc7df;
    level.custom_spawner_entry[#"roof_climb"] = &zm_spawner::function_48cfc7df;
    level.var_d27b908a = &zm_pack_a_punch::function_cb83b6d8;
    if (zm_utility::is_standard()) {
        var_d6ad6540 = struct::get_array("perk_vapor_altar");
        foreach (var_4b57dfa9 in var_d6ad6540) {
            var_4b57dfa9.var_84d8f199 = 2;
        }
    }
    load::main();
    zm_fasttravel::function_73748e46("power_on1");
    level.zones = [];
    level.zone_manager_init_func = &function_9449672;
    init_zones[0] = "zone_model_industries";
    level thread zm_zonemgr::manage_zones(init_zones);
    level thread zm_escape_travel::init_alcatraz_zipline();
    level.random_pandora_box_start = 1;
    level.start_chest_name = "powerhouse_chest";
    level.var_c59d8c5 = 1;
    level.open_chest_location = [];
    level.open_chest_location[0] = "warden_office_chest";
    level.open_chest_location[1] = "cafe_chest";
    level.open_chest_location[2] = "dock_chest";
    level.open_chest_location[3] = "recreation_yard_chest";
    level.open_chest_location[4] = "powerhouse_chest";
    level.open_chest_location[5] = "new_industries_chest";
    level.open_chest_location[6] = "warden_house_chest";
    level._zombiemode_custom_box_move_logic = &function_383d7fc5;
    level thread sndfunctions();
    level.customrandomweaponweights = &function_659c2324;
    level.custom_magic_box_selection_logic = &function_fcab2314;
    callback::on_spawned(&function_cdf71e06);
    level thread zm_escape_catwalk_event::function_2a17bca0();
    level thread function_e41d3774();
    level thread function_539567c9();
    level thread function_9667511e();
    level thread namespace_a9db3299::main();
    level thread namespace_d8b81d0b::function_f17dfc5e();
    level.var_c69b1b9b = &zm_escape_util::function_f2668b19;
    level.var_d057a720 = &zm_escape_util::function_8160799a;
    level.player_out_of_playable_area_override = &zm_escape_util::function_4c99572a;
    level thread zm_escape_util::function_3f8f3d1a();
    level thread zm_escape_util::function_35e99b28("power_global", "start_zombie_round_logic");
    level thread zm_escape_util::function_35e99b28("power_building64", "power_on1");
    level thread zm_escape_util::function_35e99b28("power_powerhouse", "power_on2");
    level thread zm_escape_util::function_316c3cb7();
    paschal::main();
    /#
        level thread function_c6577a2f();
    #/
}

// Namespace zm_escape/zm_escape
// Params 0, eflags: 0x0
// Checksum 0x816b0c35, Offset: 0x1870
// Size: 0x84
function function_9667511e() {
    level waittill(#"all_players_spawned");
    if (zm_custom::function_5638f689(#"zmpowerstate") == 2) {
        level flag::set("power_on1");
        level flag::set("power_on2");
    }
}

// Namespace zm_escape/zm_escape
// Params 0, eflags: 0x0
// Checksum 0xf90f0d45, Offset: 0x1900
// Size: 0x1de
function function_539567c9() {
    exploder::exploder("fxexp_power_house_off");
    exploder::stop_exploder("fxexp_power_house_on");
    level flag::wait_till("power_on2");
    exploder::exploder("powerhouse_power_on");
    exploder::exploder("bx_cellblock_off");
    exploder::exploder("fxexp_power_house_on");
    exploder::stop_exploder("fxexp_power_house_off");
    a_s_generators = struct::get_array("powerhouse_generator", "targetname");
    foreach (s_generator in a_s_generators) {
        s_generator thread scene::play("Shot 2");
    }
    for (i = 0; i < 12; i++) {
        if (i <= 9) {
            exploder::exploder("fxexp_power_house_machine_0" + i);
            continue;
        }
        exploder::exploder("fxexp_power_house_machine_" + i);
    }
}

// Namespace zm_escape/zm_escape
// Params 0, eflags: 0x0
// Checksum 0x32f6db4c, Offset: 0x1ae8
// Size: 0xcc
function function_e41d3774() {
    if (zm_custom::function_5638f689(#"zmpowerstate") != 2) {
        level clientfield::set("" + #"hash_4a8a7b58bf6cd5d8", 1);
    }
    level flag::wait_till("power_on1");
    exploder::exploder("lgtexp_building64_power_on");
    level clientfield::set("" + #"hash_4a8a7b58bf6cd5d8", 0);
}

// Namespace zm_escape/zm_escape
// Params 1, eflags: 0x0
// Checksum 0x4951a749, Offset: 0x1bc0
// Size: 0x74
function function_dbad05cf(master_switch) {
    if (isdefined(master_switch.model_off)) {
        master_switch setmodel(master_switch.model_off);
    }
    if (isdefined(master_switch.bundle)) {
        master_switch thread scene::play(master_switch.bundle, "FAKE_OFF", master_switch);
    }
}

// Namespace zm_escape/zm_escape
// Params 1, eflags: 0x0
// Checksum 0xefe01913, Offset: 0x1c40
// Size: 0x74
function function_c65d0c7b(master_switch) {
    if (isdefined(master_switch.model_on)) {
        master_switch setmodel(master_switch.model_on);
    }
    if (isdefined(master_switch.bundle)) {
        master_switch thread scene::play(master_switch.bundle, "FAKE_ON", master_switch);
    }
}

// Namespace zm_escape/zm_escape
// Params 1, eflags: 0x0
// Checksum 0xf076a76e, Offset: 0x1cc0
// Size: 0xc6
function offhand_weapon_give_override(str_weapon) {
    self endon(#"death");
    if (zm_loadout::is_tactical_grenade(str_weapon) && isdefined(self zm_loadout::get_player_tactical_grenade()) && !self zm_loadout::is_player_tactical_grenade(str_weapon)) {
        self setweaponammoclip(self zm_loadout::get_player_tactical_grenade(), 0);
        self takeweapon(self zm_loadout::get_player_tactical_grenade());
    }
    return false;
}

// Namespace zm_escape/zm_escape
// Params 0, eflags: 0x0
// Checksum 0x9cdf33c5, Offset: 0x1d90
// Size: 0x1064
function function_9449672() {
    level flag::init(#"always_on");
    level flag::set(#"always_on");
    setdvar(#"hash_6ec233a56690f409", 1);
    zm_zonemgr::zone_init("zone_model_industries_upper");
    zm_zonemgr::zone_init("zone_west_side_exterior_upper_03");
    zm_zonemgr::add_adjacent_zone("zone_library", "zone_start", "activate_catwalk", 0);
    zm_zonemgr::add_adjacent_zone("zone_library", "zone_cellblock_west", "activate_cellblock_library", 0);
    zm_zonemgr::add_adjacent_zone("zone_library", "zone_broadway_floor_2", "activate_cellblock_library", 0);
    zm_zonemgr::add_adjacent_zone("zone_cellblock_west", "zone_cellblock_west_barber", "activate_cellblock_ca", 0);
    zm_zonemgr::add_adjacent_zone("zone_cellblock_west", "zone_broadway_floor_2", "activate_cellblock_ca", 0);
    zm_zonemgr::add_adjacent_zone("zone_broadway_floor_2", "zone_cellblock_west_barber", "activate_cellblock_ca", 0);
    zm_zonemgr::add_adjacent_zone("zone_cellblock_west", "zone_cellblock_west_barber", "activate_cellblock_library", 0);
    zm_zonemgr::add_adjacent_zone("zone_cellblock_west", "zone_broadway_floor_2", "activate_cellblock_library", 0);
    zm_zonemgr::add_adjacent_zone("zone_broadway_floor_2", "zone_cellblock_west_barber", "activate_cellblock_library", 0);
    zm_zonemgr::add_adjacent_zone("zone_cellblock_west_warden", "zone_cellblock_west_barber", "activate_cellblock_ca", 0);
    zm_zonemgr::add_adjacent_zone("zone_cellblock_west_warden", "zone_cellblock_west_barber", "activate_cellblock_library", 0);
    zm_zonemgr::add_adjacent_zone("zone_cellblock_west_warden", "zone_cellblock_west_barber", "activate_cellblock_gondola", 0);
    zm_zonemgr::add_adjacent_zone("zone_cellblock_west", "zone_cellblock_west_gondola", "activate_cellblock_gondola", 0);
    zm_zonemgr::add_adjacent_zone("zone_broadway_floor_2", "zone_cellblock_west_gondola", "activate_cellblock_gondola", 0);
    zm_zonemgr::add_adjacent_zone("zone_cellblock_west_barber", "zone_cellblock_west_gondola", "activate_cellblock_gondola", 0);
    zm_zonemgr::add_adjacent_zone("zone_cellblock_west_gondola", "zone_cellblock_west_barber", "activate_cellblock_gondola", 0);
    zm_zonemgr::add_adjacent_zone("zone_cellblock_west_gondola", "zone_cellblock_east", "activate_cellblock_gondola", 0);
    zm_zonemgr::add_adjacent_zone("zone_cellblock_west_gondola", "zone_infirmary", "activate_cellblock_infirmary", 0);
    zm_zonemgr::add_adjacent_zone("zone_infirmary_roof", "zone_infirmary", "activate_cellblock_infirmary", 0);
    zm_zonemgr::add_adjacent_zone("zone_cellblock_west_gondola", "zone_cellblock_west_barber", "activate_cellblock_infirmary", 0);
    zm_zonemgr::add_adjacent_zone("zone_cellblock_west_gondola", "zone_cellblock_west", "activate_cellblock_infirmary", 0);
    zm_zonemgr::add_adjacent_zone("zone_cellblock_west_gondola", "zone_broadway_floor_2", "activate_cellblock_infirmary", 0);
    zm_zonemgr::add_adjacent_zone("zone_cellblock_entrance", "zone_cellblock_east", "activate_cellblock_ca", 0);
    zm_zonemgr::add_adjacent_zone("zone_cellblock_west_barber", "zone_cellblock_west_warden", "activate_cellblock_infirmary", 0);
    zm_zonemgr::add_adjacent_zone("zone_cellblock_west_barber", "zone_cellblock_east", "activate_cellblock_ca", 0);
    zm_zonemgr::add_adjacent_zone("zone_cellblock_west_barber", "zone_cellblock_east", "activate_cellblock_library", 0);
    zm_zonemgr::add_adjacent_zone("zone_cellblock_west_barber", "zone_cellblock_west_warden", "activate_cellblock_east_west", 0);
    zm_zonemgr::add_adjacent_zone("zone_cellblock_west_warden", "zone_sally_port", "activate_warden_office", 0);
    zm_zonemgr::add_adjacent_zone("zone_cellblock_west_warden", "zone_administration", "activate_warden_office", 0);
    zm_zonemgr::add_adjacent_zone("zone_cellblock_west_warden", "zone_warden_office", "activate_warden_office", 0);
    zm_zonemgr::add_adjacent_zone("zone_sally_port", "zone_administration", "activate_warden_office", 0);
    zm_zonemgr::add_adjacent_zone("zone_sally_port", "zone_warden_office", "activate_warden_office", 0);
    zm_zonemgr::add_adjacent_zone("zone_administration", "zone_warden_office", "activate_warden_office", 0);
    zm_zonemgr::add_adjacent_zone("zone_cellblock_west_warden", "zone_citadel_warden", "activate_cellblock_citadel", 0);
    zm_zonemgr::add_adjacent_zone("zone_cellblock_west_warden", "zone_cellblock_west_barber", "activate_cellblock_citadel", 0);
    zm_zonemgr::add_adjacent_zone("zone_citadel", "zone_citadel_warden", "activate_cellblock_citadel", 0);
    zm_zonemgr::add_adjacent_zone("zone_citadel", "zone_citadel_shower", "activate_cellblock_citadel", 0);
    zm_zonemgr::add_adjacent_zone("zone_cellblock_east", "zone_cafeteria", "activate_cafeteria", 0);
    zm_zonemgr::add_adjacent_zone("zone_cafeteria", "zone_cafeteria_end", "activate_cafeteria", 0);
    zm_zonemgr::add_adjacent_zone("zone_sally_port", "zone_warden_house_exterior", "activate_wa_h", 0);
    zm_zonemgr::add_adjacent_zone("zone_administration", "zone_warden_house_exterior", "activate_wa_h", 0);
    zm_zonemgr::add_adjacent_zone("zone_warden_office", "zone_warden_house_exterior", "activate_wa_h", 0);
    zm_zonemgr::add_adjacent_zone("zone_warden_house_exterior", "zone_warden_house", "activate_wa_h", 0);
    zm_zonemgr::add_adjacent_zone("zone_warden_house_exterior", "zone_warden_house", #"hash_6804675ac314efd1", 0);
    zm_zonemgr::add_adjacent_zone("zone_warden_home", "zone_warden_house", #"activate_warden_house_2_attic", 0);
    zm_zonemgr::add_adjacent_zone("zone_cellblock_east", "cellblock_shower", "activate_shower_room", 0);
    zm_zonemgr::add_adjacent_zone("cellblock_shower", "zone_citadel_shower", "activate_shower_citadel", 0);
    zm_zonemgr::add_adjacent_zone("zone_citadel_shower", "zone_citadel", "activate_shower_citadel", 0);
    zm_zonemgr::add_adjacent_zone("zone_citadel", "zone_citadel_warden", "activate_shower_citadel", 0);
    zm_zonemgr::add_adjacent_zone("zone_cafeteria", "zone_infirmary", "activate_infirmary", 0);
    zm_zonemgr::add_adjacent_zone("zone_cafeteria", "zone_cafeteria_end", "activate_infirmary", 0);
    zm_zonemgr::add_adjacent_zone("zone_cafeteria", "zone_cafeteria_end", #"hash_6059fbd4a3d1823e", 0);
    zm_zonemgr::add_adjacent_zone("zone_infirmary_roof", "zone_infirmary", "activate_infirmary", 0);
    zm_zonemgr::add_adjacent_zone("zone_roof", "zone_roof_infirmary", "activate_roof", 0);
    zm_zonemgr::add_adjacent_zone("zone_roof_infirmary", "zone_infirmary_roof", "activate_roof", 0);
    zm_zonemgr::add_adjacent_zone("zone_citadel", "zone_citadel_stairs", "activate_citadel_stair", 0);
    zm_zonemgr::add_adjacent_zone("zone_citadel", "zone_citadel_shower", "activate_citadel_stair", 0);
    zm_zonemgr::add_adjacent_zone("zone_citadel", "zone_citadel_warden", "activate_citadel_stair", 0);
    zm_zonemgr::add_adjacent_zone("zone_citadel_stairs", "zone_citadel_basement", "activate_citadel_basement", 0);
    zm_zonemgr::add_adjacent_zone("zone_citadel_stairs", "zone_citadel_basement", "activate_citadel_stair", 0);
    zm_zonemgr::add_adjacent_zone("zone_citadel_stairs", "zone_citadel_basement", "activate_basement_gondola", 0);
    zm_zonemgr::add_adjacent_zone("zone_citadel_stairs", "zone_citadel_basement", "activate_basement_building", 0);
    zm_zonemgr::add_adjacent_zone("zone_citadel_basement", "zone_citadel_basement_building", "activate_citadel_basement", 0);
    zm_zonemgr::add_adjacent_zone("zone_citadel_basement", "zone_citadel_basement_building", "activate_citadel_stair", 0);
    zm_zonemgr::add_adjacent_zone("zone_citadel_basement", "zone_citadel_basement_building", "activate_basement_building", 0);
    zm_zonemgr::add_adjacent_zone("zone_citadel_basement_building", "zone_studio", "activate_basement_building", 0);
    zm_zonemgr::add_adjacent_zone("zone_citadel_basement", "zone_studio", "activate_basement_building", 0);
    zm_zonemgr::add_adjacent_zone("zone_citadel_basement_building", "zone_dock_gondola", "activate_basement_gondola", 0);
    zm_zonemgr::add_adjacent_zone("zone_citadel_basement", "zone_citadel_basement_building", "activate_basement_gondola", 0);
    zm_zonemgr::add_adjacent_zone("zone_dock", "zone_dock_gondola", "activate_basement_gondola", 0);
    zm_zonemgr::add_adjacent_zone("zone_studio", "zone_dock", "activate_dock_sally", 0);
    zm_zonemgr::add_adjacent_zone("zone_dock_gondola", "zone_dock", "activate_dock_sally", 0);
    zm_zonemgr::add_adjacent_zone("zone_dock", "zone_dock_gondola", "gondola_roof_to_dock", 0);
    zm_zonemgr::add_adjacent_zone("zone_gondola_ride", "zone_gondola_ride", "gondola_ride_zone_enabled");
    zm_zonemgr::add_adjacent_zone("zone_cellblock_west_gondola", "zone_cellblock_west_gondola_dock", "activate_cellblock_infirmary", 0);
    zm_zonemgr::add_adjacent_zone("zone_cellblock_west_gondola", "zone_cellblock_west_gondola_dock", "activate_cellblock_gondola", 0);
    zm_zonemgr::add_adjacent_zone("zone_cellblock_west_gondola", "zone_cellblock_west_gondola_dock", "gondola_dock_to_roof", 0);
    zm_zonemgr::add_adjacent_zone("zone_model_industries", "zone_model_industries_upper", #"always_on", 0);
    zm_zonemgr::add_adjacent_zone("zone_model_industries_upper", "zone_west_side_exterior_upper", "activate_west_side_exterior", 0);
    zm_zonemgr::add_adjacent_zone("zone_west_side_exterior_upper", "zone_west_side_exterior_upper_02", "activate_west_side_exterior", 0);
    zm_zonemgr::add_adjacent_zone("zone_west_side_exterior_upper_02", "zone_west_side_exterior_lower", "activate_west_side_exterior_lower", 0);
    zm_zonemgr::add_adjacent_zone("zone_west_side_exterior_lower", "zone_powerhouse", "activate_west_side_exterior_lower", 0);
    zm_zonemgr::add_adjacent_zone("zone_west_side_exterior_lower", "zone_powerhouse", "activate_west_side_exterior_tunnel", 0);
    zm_zonemgr::add_adjacent_zone("zone_west_side_exterior_lower", "zone_west_side_exterior_tunnel", "activate_west_side_exterior_tunnel", 0);
    zm_zonemgr::add_adjacent_zone("zone_west_side_exterior_tunnel", "zone_new_industries", "activate_west_side_exterior_tunnel", 0);
    zm_zonemgr::add_adjacent_zone("zone_west_side_exterior_tunnel", "zone_new_industries_transverse_tunnel", "activate_west_side_exterior_tunnel", 0);
    zm_zonemgr::add_adjacent_zone("zone_new_industries", "zone_new_industries_transverse_tunnel", "activate_west_side_exterior_tunnel", 0);
    zm_zonemgr::add_adjacent_zone("zone_west_side_exterior_upper_02", "zone_new_industries", "activate_new_industries", 0);
    zm_zonemgr::add_adjacent_zone("zone_west_side_exterior_upper_02", "zone_new_industries_transverse_tunnel", "activate_new_industries", 0);
    zm_zonemgr::add_adjacent_zone("zone_new_industries", "zone_new_industries_transverse_tunnel", "activate_new_industries", 0);
    zm_zonemgr::add_adjacent_zone("zone_new_industries", "zone_new_industries_transverse_tunnel", #"hash_2873d6b98dfeaf6d", 0);
    zm_zonemgr::add_adjacent_zone("zone_west_side_exterior_upper_02", "zone_catwalk_01", "activate_catwalk");
    zm_zonemgr::add_adjacent_zone("zone_catwalk_01", "zone_catwalk_02", "activate_catwalk", 0);
    zm_zonemgr::add_adjacent_zone("zone_catwalk_02", "zone_catwalk_03", "activate_catwalk", 0);
    zm_zonemgr::add_adjacent_zone("zone_catwalk_03", "zone_catwalk_04", "activate_catwalk", 0);
    zm_zonemgr::add_adjacent_zone("zone_catwalk_04", "zone_cellblock_entrance", "activate_catwalk", 0);
    zm_zonemgr::add_adjacent_zone("zone_cellblock_entrance", "zone_start", "activate_catwalk", 0);
    zm_zonemgr::add_adjacent_zone("zone_fast_travel_west_side_tunnel_to_cafeteria", "zone_fast_travel_west_side_tunnel_to_cafeteria", "power_on1", 0);
    zm_zonemgr::add_adjacent_zone("zone_fast_travel_warden_house_to_shower", "zone_fast_travel_warden_house_to_shower", "power_on1", 0);
    zm_zonemgr::add_adjacent_zone("zone_model_industries", "zone_west_side_exterior_stairs", "activate_west_side_exterior_stairs", 0);
}

// Namespace zm_escape/zm_escape
// Params 0, eflags: 0x0
// Checksum 0x4643ba01, Offset: 0x2e00
// Size: 0x34
function function_cdf71e06() {
    self thread function_21c53c36();
    self thread function_da2970c7();
}

// Namespace zm_escape/zm_escape
// Params 0, eflags: 0x0
// Checksum 0xa9f89672, Offset: 0x2e40
// Size: 0x110
function function_da2970c7() {
    self endon(#"disconnect");
    while (true) {
        if (isalive(self)) {
            str_location = self function_50f2bc89();
            if (isdefined(level.var_10debcec) && level.var_10debcec && isdefined(level.var_476496a5)) {
                str_location = self function_50f2bc89(level.var_476496a5.script_string);
            }
            self zm_hud::function_3a4fb187(isdefined(str_location) ? str_location : #"");
        } else {
            self zm_hud::function_3a4fb187(#"");
        }
        wait 0.5;
    }
}

// Namespace zm_escape/zm_escape
// Params 1, eflags: 0x0
// Checksum 0xbc99d6e4, Offset: 0x2f58
// Size: 0x6f6
function function_50f2bc89(str_location) {
    str_zone = self zm_zonemgr::get_player_zone();
    if (!isdefined(str_zone)) {
        return undefined;
    }
    if (isdefined(self.var_56c7266a) && self.var_56c7266a) {
        str_display = #"hash_4499d5469a09785c";
        return str_display;
    }
    if (isdefined(str_location)) {
        str_zone = str_location;
    }
    switch (str_zone) {
    case #"zone_model_industries":
        str_display = #"hash_1a8cabe1cd38cf05";
        break;
    case #"zone_model_industries_upper":
        str_display = #"hash_5d43e6a30d61f2c2";
        break;
    case #"zone_west_side_exterior_upper":
    case #"zone_west_side_exterior_upper_02":
        str_display = #"hash_1bb116d35c69f7";
        break;
    case #"zone_west_side_exterior_tunnel":
    case #"zone_new_industries_transverse_tunnel":
        str_display = #"hash_3487be8c75233a0b";
        break;
    case #"zone_west_side_exterior_lower":
    case #"zone_powerhouse":
        str_display = #"hash_7806b6b51cd2aed2";
        break;
    case #"zone_new_industries":
        str_display = #"hash_786af67b8225aaf4";
        break;
    case #"zone_catwalk_01":
    case #"zone_catwalk_02":
        str_display = #"hash_7d83ea134c9fa0e";
        break;
    case #"zone_catwalk_04":
    case #"zone_catwalk_03":
        str_display = #"hash_5d3ed783f8450d92";
        break;
    case #"zone_cellblock_entrance":
        str_display = #"hash_9b40009eaa83579";
        break;
    case #"zone_start":
        str_display = #"hash_3f0a132a9ef3cd11";
        break;
    case #"zone_library":
        str_display = #"hash_737ac11c81c21f4c";
        break;
    case #"zone_cellblock_east":
        str_display = #"hash_6578f574dddfb02e";
        break;
    case #"zone_cellblock_west":
        str_display = #"hash_23dc7787e4d6b8b5";
        break;
    case #"zone_broadway_floor_2":
        str_display = #"hash_6181016e2d71c94e";
        break;
    case #"zone_cellblock_west_gondola":
        str_display = #"hash_53208a43bb33987d";
        break;
    case #"zone_cellblock_west_gondola_dock":
        str_display = #"hash_578cde50a0ed0829";
        break;
    case #"zone_cellblock_west_warden":
    case #"zone_cellblock_west_barber":
        str_display = #"hash_70fa5ff9f448bc96";
        break;
    case #"zone_sally_port":
        str_display = #"hash_68ef83a1a918a522";
        break;
    case #"zone_administration":
        str_display = #"hash_7b3972c143382703";
        break;
    case #"zone_warden_office":
        str_display = #"hash_4c183909b38ae649";
        break;
    case #"zone_warden_house_exterior":
        str_display = #"hash_6ba6b293ed38ed6e";
        break;
    case #"zone_warden_house":
        str_display = #"hash_3aafbefc77b80ce3";
        break;
    case #"zone_warden_home":
        str_display = #"hash_5da659405984efa3";
        break;
    case #"zone_cafeteria":
    case #"zone_cafeteria_end":
        str_display = #"hash_f76546edee4a6a1";
        break;
    case #"zone_infirmary":
    case #"zone_infirmary_roof":
        str_display = #"hash_960d3edb9fefcec";
        break;
    case #"zone_roof":
    case #"zone_roof_infirmary":
        str_display = #"hash_676a058bfe70473";
        break;
    case #"cellblock_shower":
        str_display = #"hash_8a1754e2c346504";
        break;
    case #"zone_citadel":
    case #"zone_citadel_shower":
    case #"zone_citadel_warden":
        str_display = #"hash_12fef669980586e7";
        break;
    case #"zone_citadel_basement":
    case #"zone_citadel_stairs":
        str_display = #"hash_408e00ed0c7af3b3";
        break;
    case #"zone_citadel_basement_building":
        str_display = #"hash_5e714183f1264faa";
        break;
    case #"zone_studio":
        str_display = #"hash_68da319819d879ec";
        break;
    case #"zone_dock":
        str_display = #"hash_4213dc004145588f";
        break;
    case #"zone_dock_gondola":
        str_display = #"hash_3b3867cba3ae468a";
        break;
    case #"zone_gondola_ride":
        str_display = #"hash_3be34a9bf8a7da9d";
        break;
    case #"zone_fast_travel_west_side_tunnel_to_cafeteria":
    case #"zone_fast_travel_warden_house_to_shower":
        str_display = #"hash_4499d5469a09785c";
        break;
    default:
        str_display = undefined;
        break;
    }
    return str_display;
}

// Namespace zm_escape/zm_escape
// Params 0, eflags: 0x0
// Checksum 0xab4f8faf, Offset: 0x3658
// Size: 0x124
function function_21c53c36() {
    self thread zm_audio::function_83711320(#"hash_676a058bfe70473", #"roof");
    self thread zm_audio::function_83711320(#"hash_3aafbefc77b80ce3", #"wardens_house");
    self thread zm_audio::function_83711320(#"hash_4c183909b38ae649", #"wardens_office");
    self thread zm_audio::function_83711320(#"hash_f76546edee4a6a1", #"cafeteria");
    self thread zm_audio::function_83711320(#"hash_8a1754e2c346504", #"showers");
    self thread zm_audio::function_83711320(#"hash_9b40009eaa83579", #"cell_block");
}

// Namespace zm_escape/zm_escape
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x3788
// Size: 0x4
function include_weapons() {
    
}

// Namespace zm_escape/zm_escape
// Params 0, eflags: 0x0
// Checksum 0x4013aedd, Offset: 0x3798
// Size: 0x3c
function function_7837e42a() {
    zm_weapons::load_weapon_spec_from_table(#"gamedata/weapons/zm/zm_escape_weapons.csv", 1);
    zm_wallbuy::function_9e8dccbe();
}

// Namespace zm_escape/zm_escape
// Params 0, eflags: 0x0
// Checksum 0xe77cd7a7, Offset: 0x37e0
// Size: 0x54
function function_c2cd1f49() {
    level.var_2df16607 = 1;
    zm_loadout::register_tactical_grenade_for_level(#"zhield_spectral_dw", 1);
    zm_loadout::register_tactical_grenade_for_level(#"zhield_spectral_dw_upgraded");
}

// Namespace zm_escape/zm_escape
// Params 0, eflags: 0x0
// Checksum 0x9f6db87a, Offset: 0x3840
// Size: 0x13c
function sndfunctions() {
    zm_utility::add_sound("zmb_heavy_door_open", "zmb_heavy_door_open");
    level thread setupmusic();
    level thread custom_add_vox();
    if (zm_utility::is_standard()) {
        level.zmannouncerprefix = "vox_rush_";
    } else {
        level.zmannouncerprefix = "vox_ward_";
    }
    level.var_e4e95db = &function_e4e95db;
    level flag::wait_till("power_on2");
    playsoundatposition(#"hash_6d80127a29f6f4e0", (0, 0, 0));
    level flag::wait_till("power_on1");
    playsoundatposition(#"hash_6d80157a29f6f9f9", (0, 0, 0));
}

// Namespace zm_escape/zm_escape
// Params 1, eflags: 0x0
// Checksum 0xa6cb8113, Offset: 0x3988
// Size: 0xfe
function function_e4e95db(str_weapon_name) {
    if (!isdefined(str_weapon_name)) {
        return undefined;
    }
    str_weapon = undefined;
    switch (str_weapon_name) {
    case #"ww_blundergat_t8_upgraded":
    case #"ww_blundergat_t8":
        str_weapon = "wonder";
        break;
    case #"ww_blundergat_acid_t8":
    case #"hash_494f5501b3f8e1e9":
    case #"ww_blundergat_acid_t8_upgraded":
        str_weapon = "novox";
        break;
    case #"tomahawk_t8":
        str_weapon = "novox";
        break;
    case #"spork_alcatraz":
    case #"spoon_alcatraz":
        str_weapon = "melee";
        break;
    }
    return str_weapon;
}

// Namespace zm_escape/zm_escape
// Params 0, eflags: 0x0
// Checksum 0xddb12eba, Offset: 0x3a90
// Size: 0xfe
function custom_add_vox() {
    zm_audio::loadplayervoicecategories(#"hash_41c3d60c9fdc1c1a");
    zm_audio::loadplayervoicecategories(#"hash_6d9aadb58948623b");
    zm_audio::loadplayervoicecategories(#"hash_5513a399a5c36320");
    level.sndweaponpickupoverride = array(#"spoon", #"spork", #"spknifeork", #"tomahawk", #"blundergat", #"acidgat", #"magmagat", #"magmagat_unfinished");
}

// Namespace zm_escape/zm_escape
// Params 0, eflags: 0x0
// Checksum 0xd8af81b4, Offset: 0x3b98
// Size: 0x324
function setupmusic() {
    zm_audio::musicstate_create("round_start", 3, "escape_roundstart_1", "escape_roundstart_2", "escape_roundstart_3");
    zm_audio::musicstate_create("round_start_short", 3, "escape_roundstart_1", "escape_roundstart_2", "escape_roundstart_3");
    zm_audio::musicstate_create("round_start_first", 3, "escape_roundstart_first");
    zm_audio::musicstate_create("round_end", 3, "escape_roundend_1", "escape_roundend_2", "escape_roundend_3");
    zm_audio::musicstate_create("game_over", 5, "escape_death");
    zm_audio::musicstate_create("round_start_special", 3, "round_start_special");
    zm_audio::musicstate_create("round_end_special", 3, "round_end_special");
    zm_audio::musicstate_create("escape_catwalk", 4, "escape_catwalk");
    zm_audio::function_105831ac(#"hash_9b40009eaa83579", "escape_theme", 0, 4);
    zm_audio::function_105831ac(#"hash_23dc7787e4d6b8b5", "location_cellblock", 1);
    zm_audio::function_105831ac(#"hash_7806b6b51cd2aed2", "location_powerstation", 1);
    zm_audio::function_105831ac(#"hash_408e00ed0c7af3b3", "location_stairwell", 1);
    zm_audio::function_105831ac(#"hash_960d3edb9fefcec", "location_infirmary", 1);
    zm_audio::function_105831ac(#"hash_4213dc004145588f", "location_dock", 1);
    zm_audio::function_105831ac(#"hash_8a1754e2c346504", "location_showers", 1);
    zm_audio::function_105831ac(#"hash_68ef83a1a918a522", "location_wardens_office", 1);
    zm_audio::function_105831ac(#"hash_676a058bfe70473", "location_rooftop", 1);
}

// Namespace zm_escape/zm_escape
// Params 0, eflags: 0x0
// Checksum 0x9d6c3cb4, Offset: 0x3ec8
// Size: 0xe0
function function_383d7fc5() {
    if (level.chest_moves > 1) {
        zm_magicbox::default_box_move_logic();
        return;
    }
    level.chests = array::randomize(level.chests);
    for (i = 0; i < level.chests.size; i++) {
        if (level.chests[i].script_noteworthy != "new_industries_chest" && level.chests[i].script_noteworthy != "powerhouse_chest") {
            level.chest_index = i;
            break;
        }
    }
}

// Namespace zm_escape/zm_escape
// Params 1, eflags: 0x0
// Checksum 0x7fe3e163, Offset: 0x3fb0
// Size: 0x21a
function function_659c2324(a_keys) {
    if (!isdefined(self.var_12d3a848)) {
        self.var_12d3a848 = 0;
    }
    if (a_keys[0] === getweapon(#"ww_blundergat_t8")) {
        self.var_12d3a848 = 0;
        return a_keys;
    }
    n_chance = 0;
    if (zm_weapons::limited_weapon_below_quota(getweapon(#"ww_blundergat_t8"))) {
        self.var_12d3a848++;
        if (level.chest_moves == 0) {
            return a_keys;
        }
        if (self.var_12d3a848 > 2 && self.var_12d3a848 <= 5) {
            n_chance = 10;
        } else if (self.var_12d3a848 > 5 && self.var_12d3a848 <= 8) {
            n_chance = 25;
        } else if (self.var_12d3a848 > 8) {
            n_chance = 50;
        }
    } else {
        self.var_12d3a848 = 0;
    }
    if (randomint(100) <= n_chance && zm_magicbox::function_ba366d66(self, getweapon(#"ww_blundergat_t8")) && !self hasweapon(getweapon(#"ww_blundergat_t8_upgraded"))) {
        arrayinsert(a_keys, getweapon(#"ww_blundergat_t8"), 0);
        self.var_12d3a848 = 0;
    }
    return a_keys;
}

// Namespace zm_escape/zm_escape
// Params 2, eflags: 0x0
// Checksum 0xdc1154aa, Offset: 0x41d8
// Size: 0x218
function function_fcab2314(w_weapon, e_player) {
    if (w_weapon == getweapon(#"ww_blundergat_t8") && (e_player hasweapon(getweapon(#"ww_blundergat_t8")) || e_player hasweapon(getweapon(#"ww_blundergat_t8_upgraded")) || e_player hasweapon(getweapon(#"ww_blundergat_acid_t8")) || e_player hasweapon(getweapon(#"ww_blundergat_acid_t8_upgraded")) || e_player hasweapon(getweapon(#"ww_blundergat_fire_t8")) || e_player hasweapon(getweapon(#"ww_blundergat_fire_t8_upgraded")) || e_player hasweapon(getweapon(#"ww_blundergat_fire_t8_unfinished")))) {
        return 0;
    }
    if (w_weapon == getweapon(#"ww_blundergat_t8") && isdefined(e_player.var_c7229167)) {
        return 0;
    }
    return 1;
}

/#

    // Namespace zm_escape/zm_escape
    // Params 0, eflags: 0x0
    // Checksum 0xded45a8b, Offset: 0x43f8
    // Size: 0x1e4
    function function_c6577a2f() {
        zm_devgui::add_custom_devgui_callback(&function_edead455);
        adddebugcommand("<dev string:x30>");
        adddebugcommand("<dev string:x7f>");
        adddebugcommand("<dev string:xe6>");
        adddebugcommand("<dev string:x143>");
        adddebugcommand("<dev string:x1a6>");
        adddebugcommand("<dev string:x209>");
        adddebugcommand("<dev string:x268>");
        adddebugcommand("<dev string:x2cb>");
        adddebugcommand("<dev string:x329>");
        if (getdvarint(#"zm_debug_ee", 0)) {
            adddebugcommand("<dev string:x383>");
            adddebugcommand("<dev string:x3ca>");
            adddebugcommand("<dev string:x41e>");
            adddebugcommand("<dev string:x45c>");
            adddebugcommand("<dev string:x4ac>");
            adddebugcommand("<dev string:x4fe>");
            adddebugcommand("<dev string:x554>");
        }
        level thread open_sesame_watcher();
    }

    // Namespace zm_escape/zm_escape
    // Params 1, eflags: 0x0
    // Checksum 0x28740af1, Offset: 0x45e8
    // Size: 0x322
    function function_edead455(cmd) {
        switch (cmd) {
        case #"hash_50d92ca3c6c7c2a8":
            level thread function_fb60eed2();
            return 1;
        case #"hash_7ecd9429ad1bc7c7":
            level thread function_53fba9bb();
            return 1;
        case #"hash_3e92494695e7803f":
            level thread function_dba8a2cb();
            return 1;
        case #"hash_b30f093de3148f5":
            level thread function_da2f42fd();
            return 1;
        case #"hash_25b76a136a0ab4c8":
            level thread function_ccbf7a36();
            return 1;
        case #"hash_3fe16111be57cd0f":
            level thread function_5ae0985f();
            return 1;
        case #"hash_7683c4d00e818d43":
            level thread function_5f58d2c3();
            return 1;
        case #"hash_8f708281a7f98f4":
            level thread function_bf6b185e();
            return 1;
        case #"hash_19614ce604c9ce92":
            level thread function_225b9292();
            return 1;
        case #"hash_be933dada1170a":
            level thread function_e37c2a09("<dev string:x59c>");
            return 1;
        case #"hash_52c70e592a1e4183":
            level thread function_e37c2a09("<dev string:x5a9>");
            return 1;
        case #"hash_55a34e1b7b9aae2c":
            level thread function_96ddcf9e();
            return 1;
        case #"hash_5fc934c29edaf827":
            level thread function_ba407f1f();
            return 1;
        case #"hash_1eb585e188d312c2":
            level thread function_b00cc774();
            return 1;
        case #"hash_11b05ce1cac4119e":
            level.var_ac8946b9 = 1;
            break;
        case #"hash_1662437f1458600a":
            level.var_c4d7274a = 1;
            break;
        }
    }

    // Namespace zm_escape/zm_escape
    // Params 0, eflags: 0x0
    // Checksum 0xfae169f3, Offset: 0x4918
    // Size: 0x398
    function function_da2f42fd() {
        level flag::set(#"hash_dd62a8822ea4a38");
        level flag::set(#"hash_66f358c0066d77d8");
        level flag::set(#"spoon_quest_completed");
        var_c4cb2247 = struct::get("<dev string:x5b9>");
        mdl_spoon = var_c4cb2247.scene_ents[#"skeleton_arm"];
        mdl_spoon hide();
        foreach (player in level.players) {
            if (!player hasweapon(getweapon(#"spork_alcatraz"))) {
                while (!isdefined(player.var_22a7e110)) {
                    player.var_22a7e110 = player.slot_weapons[#"melee_weapon"];
                    wait 0.1;
                }
                w_current = player.currentweapon;
                player giveweapon(getweapon(#"spork_alcatraz"));
                player switchtoweapon(w_current);
                player flag::set(#"hash_79ab766693ef2532");
            }
            if (!player hasweapon(getweapon(#"tomahawk_t8_upgraded"))) {
                player.var_187e198d = player._gadgets_player[1];
                w_current = player.currentweapon;
                player giveweapon(getweapon(#"tomahawk_t8_upgraded"));
                player switchtoweapon(w_current);
            }
            if (!player hasweapon(getweapon(#"zhield_spectral_dw"))) {
                player.var_187e198d = player._gadgets_player[1];
                w_current = player.currentweapon;
                player giveweapon(getweapon(#"zhield_spectral_dw"));
                player switchtoweapon(w_current);
            }
            player clientfield::set_to_player("<dev string:x5c5>", 0);
        }
    }

    // Namespace zm_escape/zm_escape
    // Params 0, eflags: 0x0
    // Checksum 0x300bca7c, Offset: 0x4cb8
    // Size: 0x3d8
    function function_ccbf7a36() {
        level flag::set(#"hash_dd62a8822ea4a38");
        level flag::set(#"hash_66f358c0066d77d8");
        level flag::set(#"spoon_quest_completed");
        var_c4cb2247 = struct::get("<dev string:x5b9>");
        mdl_spoon = var_c4cb2247.scene_ents[#"skeleton_arm"];
        mdl_spoon hide();
        foreach (player in level.players) {
            if (!player hasweapon(getweapon(#"spork_alcatraz"))) {
                while (!isdefined(player.var_22a7e110)) {
                    player.var_22a7e110 = player.slot_weapons[#"melee_weapon"];
                    wait 0.1;
                }
                w_current = player.currentweapon;
                player giveweapon(getweapon(#"spork_alcatraz"));
                player switchtoweapon(w_current);
                player flag::set(#"hash_79ab766693ef2532");
            }
            if (!player hasweapon(getweapon(#"tomahawk_t8_upgraded"))) {
                player.var_187e198d = player._gadgets_player[1];
                w_current = player.currentweapon;
                player giveweapon(getweapon(#"tomahawk_t8_upgraded"));
                player switchtoweapon(w_current);
            }
            if (!player hasweapon(getweapon(#"zhield_spectral_dw"))) {
                player.var_187e198d = player._gadgets_player[1];
                w_current = player.currentweapon;
                player giveweapon(getweapon(#"zhield_spectral_dw"));
                player switchtoweapon(w_current);
            }
            level.var_fa799cf setvisibletoplayer(player);
            player clientfield::set_to_player("<dev string:x5c5>", 0);
            player flag::set(#"hash_d41f651bb868608");
        }
    }

    // Namespace zm_escape/zm_escape
    // Params 0, eflags: 0x0
    // Checksum 0xb39f2b89, Offset: 0x5098
    // Size: 0x3e8
    function function_5ae0985f() {
        level flag::set(#"hash_dd62a8822ea4a38");
        level flag::set(#"hash_66f358c0066d77d8");
        level flag::set(#"spoon_quest_completed");
        var_c4cb2247 = struct::get("<dev string:x5b9>");
        mdl_spoon = var_c4cb2247.scene_ents[#"skeleton_arm"];
        mdl_spoon hide();
        foreach (player in level.players) {
            if (player hasweapon(getweapon(#"spork_alcatraz"))) {
                player takeweapon(getweapon(#"spork_alcatraz"));
                w_current = player.currentweapon;
                player giveweapon(getweapon(#"knife"));
                player switchtoweapon(w_current);
            }
            if (!player hasweapon(getweapon(#"tomahawk_t8_upgraded"))) {
                player.var_187e198d = player._gadgets_player[1];
                w_current = player.currentweapon;
                player giveweapon(getweapon(#"tomahawk_t8_upgraded"));
                player switchtoweapon(w_current);
            }
            if (!player hasweapon(getweapon(#"zhield_spectral_dw"))) {
                player.var_187e198d = player._gadgets_player[1];
                w_current = player.currentweapon;
                player giveweapon(getweapon(#"zhield_spectral_dw"));
                player switchtoweapon(w_current);
            }
            level.var_fa799cf setvisibletoplayer(player);
            player clientfield::set_to_player("<dev string:x5c5>", 0);
            player flag::set(#"hash_79ab766693ef2532");
            player flag::set(#"hash_d41f651bb868608");
            player flag::set(#"hash_334221cd7977f5d5");
        }
    }

    // Namespace zm_escape/zm_escape
    // Params 0, eflags: 0x0
    // Checksum 0xfa68747a, Offset: 0x5488
    // Size: 0x4e8
    function function_5f58d2c3() {
        level flag::set(#"hash_dd62a8822ea4a38");
        level flag::set(#"hash_66f358c0066d77d8");
        level flag::set(#"spoon_quest_completed");
        level flag::set(#"hash_6ee51d9a7d37aecc");
        var_c4cb2247 = struct::get("<dev string:x5b9>");
        mdl_spoon = var_c4cb2247.scene_ents[#"skeleton_arm"];
        mdl_spoon hide();
        foreach (player in level.players) {
            if (player hasweapon(getweapon(#"spork_alcatraz"))) {
                player takeweapon(getweapon(#"spork_alcatraz"));
                w_current = player.currentweapon;
                player giveweapon(getweapon(#"knife"));
                player switchtoweapon(w_current);
            }
            if (!player hasweapon(getweapon(#"tomahawk_t8_upgraded"))) {
                player.var_187e198d = player._gadgets_player[1];
                w_current = player.currentweapon;
                player giveweapon(getweapon(#"tomahawk_t8_upgraded"));
                player switchtoweapon(w_current);
            }
            if (!player hasweapon(getweapon(#"zhield_spectral_dw"))) {
                player.var_187e198d = player._gadgets_player[1];
                w_current = player.currentweapon;
                player giveweapon(getweapon(#"zhield_spectral_dw"));
                player switchtoweapon(w_current);
            }
            level.var_fa799cf setvisibletoplayer(player);
            player clientfield::set_to_player("<dev string:x5c5>", 0);
            player flag::set(#"hash_79ab766693ef2532");
            player flag::set(#"hash_d41f651bb868608");
            player flag::set(#"hash_334221cd7977f5d5");
            player flag::set(#"hash_12826eeb0abe1308");
            player flag::set(#"hash_465b23ced2029d95");
            player flag::set(#"hash_3aa12cac41d4ba98");
            player flag::set(#"hash_7317dfbae4fa0df5");
            player clientfield::set_to_player("<dev string:x5ce>" + #"hash_11ff39a3100ac894", 0);
            player clientfield::set_to_player("<dev string:x5ce>" + #"hash_37c33178198d54e4", 0);
        }
    }

    // Namespace zm_escape/zm_escape
    // Params 0, eflags: 0x0
    // Checksum 0x84c7be0b, Offset: 0x5978
    // Size: 0x6a0
    function function_bf6b185e() {
        level flag::set(#"hash_dd62a8822ea4a38");
        level flag::set(#"hash_66f358c0066d77d8");
        level flag::set(#"spoon_quest_completed");
        level flag::set(#"hash_6ee51d9a7d37aecc");
        var_c4cb2247 = struct::get("<dev string:x5b9>");
        mdl_spoon = var_c4cb2247.scene_ents[#"skeleton_arm"];
        mdl_spoon hide();
        foreach (player in level.players) {
            if (player hasweapon(getweapon(#"spork_alcatraz"))) {
                player takeweapon(getweapon(#"spork_alcatraz"));
                w_current = player.currentweapon;
                player giveweapon(getweapon(#"knife"));
                player switchtoweapon(w_current);
            }
            if (!player hasweapon(getweapon(#"tomahawk_t8_upgraded"))) {
                player.var_187e198d = player._gadgets_player[1];
                w_current = player.currentweapon;
                player giveweapon(getweapon(#"tomahawk_t8_upgraded"));
                player switchtoweapon(w_current);
            }
            if (!player hasweapon(getweapon(#"zhield_spectral_dw"))) {
                player.var_187e198d = player._gadgets_player[1];
                w_current = player.currentweapon;
                player giveweapon(getweapon(#"zhield_spectral_dw"));
                player switchtoweapon(w_current);
            }
            level.var_fa799cf setvisibletoplayer(player);
            player clientfield::set_to_player("<dev string:x5c5>", 0);
            player flag::set(#"hash_79ab766693ef2532");
            player flag::set(#"hash_d41f651bb868608");
            player flag::set(#"hash_334221cd7977f5d5");
            player flag::set(#"hash_12826eeb0abe1308");
            player flag::set(#"hash_465b23ced2029d95");
            player flag::set(#"hash_3aa12cac41d4ba98");
            player flag::set(#"hash_7317dfbae4fa0df5");
            player clientfield::set_to_player("<dev string:x5ce>" + #"hash_11ff39a3100ac894", 0);
            player clientfield::set_to_player("<dev string:x5ce>" + #"hash_37c33178198d54e4", 0);
            level.var_197213e6 = getent("<dev string:x5cf>", "<dev string:x5e8>");
            level.var_197213e6 setinvisibletoall();
            level.var_e3e4433d = getent("<dev string:x5f3>", "<dev string:x5e8>");
            level.var_e3e4433d setinvisibletoall();
            level.var_2ea97558 = getent("<dev string:x60c>", "<dev string:x5e8>");
            level.var_2ea97558 setinvisibletoall();
            player flag::set(#"hash_2218e030b30c77e2");
            player flag::set(#"hash_12000c871284e0b5");
            player flag::set(#"hash_7e372a60b99a89e0");
            player flag::set(#"hash_59f3be0494c4801f");
            player flag::set(#"hash_29001ce64677a5cf");
            player flag::set(#"hash_1c96d8540b5d8c50");
            player flag::set(#"hash_1213756b45a941f0");
        }
    }

    // Namespace zm_escape/zm_escape
    // Params 0, eflags: 0x0
    // Checksum 0xae5a4577, Offset: 0x6020
    // Size: 0x168
    function function_53fba9bb() {
        foreach (player in level.players) {
            level flag::set(#"spoon_quest_completed");
            if (!player hasweapon(getweapon(#"spoon_alcatraz"))) {
                while (!isdefined(player.var_22a7e110)) {
                    player.var_22a7e110 = player.slot_weapons[#"melee_weapon"];
                    wait 0.1;
                }
                w_current = player.currentweapon;
                player giveweapon(getweapon(#"spoon_alcatraz"));
                player switchtoweapon(w_current);
            }
        }
    }

    // Namespace zm_escape/zm_escape
    // Params 0, eflags: 0x0
    // Checksum 0x8b2765d0, Offset: 0x6190
    // Size: 0x240
    function function_dba8a2cb() {
        foreach (player in level.players) {
            if (player hasweapon(getweapon(#"spoon_alcatraz"))) {
                player takeweapon(getweapon(#"spoon_alcatraz"));
                if (isdefined(player.var_22a7e110)) {
                    player giveweapon(player.var_22a7e110);
                }
            }
            player notify(#"roof_kills_completed");
            player flag::set(#"hash_30ae3926b2d211db");
            if (isdefined(player.var_721c41ba)) {
                player.var_721c41ba = undefined;
            }
            player clientfield::set_to_player("<dev string:x5ce>" + #"place_spoon", 1);
            player clientfield::set_to_player("<dev string:x5ce>" + #"fill_blood", 7);
            if (!isdefined(level.var_7d904193.var_c9d6121a)) {
                level.var_7d904193.var_c9d6121a = level.var_7d904193 zm_unitrigger::create(&namespace_ab10cedb::function_d33eb24a, 64, &namespace_ab10cedb::function_fc3e755);
            }
            level namespace_ab10cedb::function_d4d6fd52();
        }
    }

    // Namespace zm_escape/zm_escape
    // Params 0, eflags: 0x0
    // Checksum 0x93c6b13f, Offset: 0x63d8
    // Size: 0x80
    function function_fb60eed2() {
        zm_devgui::zombie_devgui_open_sesame();
        level thread zm_escape_catwalk_event::function_850db698();
        namespace_a9db3299::function_7f7351fd();
        var_7d34cd26 = getent("<dev string:x624>", "<dev string:x632>");
        var_7d34cd26 notify(#"blast_attack");
    }

    // Namespace zm_escape/zm_escape
    // Params 0, eflags: 0x0
    // Checksum 0x4f05259e, Offset: 0x6460
    // Size: 0x1e2
    function function_225b9292() {
        a_s_respawn_points = struct::get_array("<dev string:x640>");
        foreach (s_respawn_point in a_s_respawn_points) {
            a_s_points = struct::get_array(s_respawn_point.target);
            for (i = 1; i <= 4; i++) {
                var_8653a698 = 0;
                foreach (s_point in a_s_points) {
                    if (s_point.script_int == i) {
                        var_8653a698 = 1;
                    }
                    assert(ispointonnavmesh(s_point.origin), "<dev string:x655>" + s_point.origin);
                }
                assert(var_8653a698, "<dev string:x678>" + i + "<dev string:x69c>" + s_respawn_point.script_noteworthy);
            }
        }
    }

    // Namespace zm_escape/zm_escape
    // Params 1, eflags: 0x0
    // Checksum 0xb8e93490, Offset: 0x6650
    // Size: 0x13c
    function function_e37c2a09(var_1389e601) {
        var_75a81532 = 1;
        var_515d120d = struct::get_array(var_1389e601, "<dev string:x6b3>");
        foreach (s_point in var_515d120d) {
            if (!ispointonnavmesh(s_point.origin)) {
                var_75a81532 = 0;
                assert(0, "<dev string:x5ce>" + var_1389e601 + "<dev string:x6c5>" + s_point.origin + "<dev string:x6d0>");
            }
        }
        if (var_75a81532) {
            iprintlnbold("<dev string:x6e4>" + var_1389e601 + "<dev string:x6e9>");
        }
    }

    // Namespace zm_escape/zm_escape
    // Params 0, eflags: 0x0
    // Checksum 0x6c70b63b, Offset: 0x6798
    // Size: 0xec
    function function_96ddcf9e() {
        foreach (var_56269cbf in level.var_bc12a3e6) {
            var_56269cbf notify(#"hash_13c5316203561c4f");
            var_56269cbf notify(#"fully_charged");
            var_56269cbf.var_7b98b639 setmodel("<dev string:x707>");
        }
        level.n_soul_catchers_charged = level.var_bc12a3e6.size;
        level thread zm_escape_weap_quest::function_daa39c85();
    }

    // Namespace zm_escape/zm_escape
    // Params 0, eflags: 0x0
    // Checksum 0x1138ab0c, Offset: 0x6890
    // Size: 0x34
    function open_sesame_watcher() {
        level waittill(#"open_sesame");
        level thread zm_escape_catwalk_event::function_850db698();
    }

    // Namespace zm_escape/zm_escape
    // Params 0, eflags: 0x0
    // Checksum 0x57bb902f, Offset: 0x68d0
    // Size: 0x56
    function function_ba407f1f() {
        level notify(#"hash_3c3c6b906f6bbd6");
        if (!isdefined(level.var_91b12f5b)) {
            level.var_91b12f5b = 1;
            return;
        }
        level.var_91b12f5b = !level.var_91b12f5b;
    }

    // Namespace zm_escape/zm_escape
    // Params 0, eflags: 0x0
    // Checksum 0x5d40347a, Offset: 0x6930
    // Size: 0x38
    function function_b00cc774() {
        level notify(#"hash_6a6919e3cb8ef81");
        level notify(#"all_macguffins_acquired");
    }

#/
