#using script_3e57cc1a9084fdd6;
#using script_432a18be09b697bd;
#using script_4ce5d94e8c797350;
#using script_4cf51a28ef39b750;
#using script_4d1e366b77f0b4b;
#using script_6b2d896ac43eb90;
#using script_72596c919cdba3f7;
#using script_ab862743b3070a;
#using script_c08f3519167b630;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\compass;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\zm\weapons\zm_weap_cymbal_monkey;
#using scripts\zm\zm_silver_main_quest;
#using scripts\zm\zm_silver_pap_quest;
#using scripts\zm\zm_silver_sound;
#using scripts\zm\zm_silver_util;
#using scripts\zm\zm_silver_ww_quest;
#using scripts\zm\zm_silver_zones;
#using scripts\zm_common\callbacks;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_fasttravel;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_round_spawning;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_zonemgr;

#namespace zm_silver;

// Namespace zm_silver/zm_silver
// Params 0, eflags: 0x2
// Checksum 0xea6a514c, Offset: 0x580
// Size: 0xcc
function autoexec opt_in() {
    level.aat_in_use = 1;
    level.random_pandora_box_start = 1;
    level.var_5470be1c = 1;
    zm_fasttravel::function_44a82004(#"hash_447ca5049bb26ab6");
    setdvar(#"player_shallowwaterwadescale", 1);
    setdvar(#"player_waistwaterwadescale", 1);
    setdvar(#"player_deepwaterwadescale", 1);
}

// Namespace zm_silver/level_init
// Params 1, eflags: 0x40
// Checksum 0xd3f25bb0, Offset: 0x658
// Size: 0x3b4
function event_handler[level_init] main(*eventstruct) {
    level.zm_disable_recording_stats = 1;
    level.var_dfee7fc2 = #"hash_1c6b6adda3e5f98";
    zm::init_fx();
    zm_perks::function_9760a58b(#"hash_7f98b3dd3cce95aa");
    zm_perks::function_9760a58b(#"hash_210097a75bb6c49a");
    zm_perks::function_9760a58b(#"hash_602a1b6107105f07");
    level.var_7f72eddd = "default_zombies_silver";
    clientfield::register_clientuimodel("player_lives", 1, 2, "int");
    level.default_start_location = "zone_proto_start";
    level.default_game_mode = "zclassic";
    level._allow_melee_weapon_switching = 1;
    level.zombiemode_reusing_pack_a_punch = 1;
    level.custom_spawner_entry[#"crawl"] = &zm_spawner::function_45bb11e4;
    level.var_d0ab70a2 = #"hash_5e105c88ae5d540f";
    level.player_out_of_playable_area_monitor = 0;
    level.var_5fe8eeaa = gettime();
    level thread function_a58c1ef7();
    load::main();
    compass::setupminimap("");
    zm_silver_ww_quest::init();
    zm_silver_main_quest::init();
    zm_silver_pap_quest::init();
    namespace_45690bb8::init();
    zm_silver_util::init();
    zm_silver_sound::init();
    namespace_c3c0ef6f::init();
    level._effect[#"large_ceiling_dust"] = #"hash_32cd6b127f58a7bf";
    level._effect[#"hash_10dedae3d37c056f"] = #"explosions/fx8_exp_grenade_default";
    level.zones = [];
    level.zone_manager_init_func = &zm_silver_zones::zone_init;
    level thread zm_zonemgr::manage_zones("zone_proto_start");
    level thread function_963beb87();
    level thread sndfunctions();
    level thread zm_perks::spare_change();
    level thread function_3ada378c();
    level thread function_360fb84d();
    level callback::function_74872db6(&function_74872db6);
    level callback::on_round_end(&on_round_end);
    level.var_a5a050c1 = 5;
    namespace_dbb31ff3::function_fa5bd408(array("connect_start_to_proto_interior", "connect_interior_to_proto_upstairs_2", "connect_upstairs_2_to_proto_exterior_rear"));
}

// Namespace zm_silver/zm_silver
// Params 0, eflags: 0x1 linked
// Checksum 0x80f724d1, Offset: 0xa18
// Size: 0x4
function function_963beb87() {
    
}

// Namespace zm_silver/zm_silver
// Params 0, eflags: 0x1 linked
// Checksum 0xc3444651, Offset: 0xa28
// Size: 0x3c
function function_a58c1ef7() {
    level.use_multiple_spawns = 1;
    level.spawner_int = 1;
    level.fn_custom_zombie_spawner_selection = &function_ddc13fd6;
}

// Namespace zm_silver/zm_silver
// Params 0, eflags: 0x1 linked
// Checksum 0xee1c09d1, Offset: 0xa70
// Size: 0x254
function function_ddc13fd6() {
    var_88b0ae7e = [];
    a_s_spots = array::randomize(level.zm_loc_types[#"zombie_location"]);
    /#
        if (getdvarint(#"scr_zombie_spawn_in_view", 0)) {
            player = getplayers()[0];
            a_s_spots = zm_spawner::function_3f416d76(player, a_s_spots);
        }
    #/
    for (i = 0; i < a_s_spots.size; i++) {
        if (!isdefined(a_s_spots[i].script_int)) {
            var_bf65599c = 1;
        } else {
            var_bf65599c = a_s_spots[i].script_int;
        }
        a_sp_zombies = [];
        foreach (sp_zombie in level.zombie_spawners) {
            if (isdefined(sp_zombie.script_int)) {
                if (sp_zombie.script_int == var_bf65599c) {
                    if (!isdefined(a_sp_zombies)) {
                        a_sp_zombies = [];
                    } else if (!isarray(a_sp_zombies)) {
                        a_sp_zombies = array(a_sp_zombies);
                    }
                    a_sp_zombies[a_sp_zombies.size] = sp_zombie;
                }
            }
        }
        if (a_sp_zombies.size) {
            sp_zombie = array::random(a_sp_zombies);
            return sp_zombie;
        }
        return level.zombie_spawners[0];
    }
    assert(isdefined(sp_zombie), "<dev string:x38>" + var_bf65599c);
}

// Namespace zm_silver/zm_silver
// Params 0, eflags: 0x0
// Checksum 0x65d03e6a, Offset: 0xcd0
// Size: 0x2c
function offhand_weapon_overrride() {
    zm_loadout::register_tactical_grenade_for_level(#"zhield_dw", 1);
}

// Namespace zm_silver/zm_silver
// Params 1, eflags: 0x0
// Checksum 0xd21c5055, Offset: 0xd08
// Size: 0xc6
function offhand_weapon_give_override(str_weapon) {
    self endon(#"death");
    if (zm_loadout::is_tactical_grenade(str_weapon) && isdefined(self zm_loadout::get_player_tactical_grenade()) && !self zm_loadout::is_player_tactical_grenade(str_weapon)) {
        self setweaponammoclip(self zm_loadout::get_player_tactical_grenade(), 0);
        self takeweapon(self zm_loadout::get_player_tactical_grenade());
    }
    return false;
}

// Namespace zm_silver/zm_silver
// Params 0, eflags: 0x1 linked
// Checksum 0x7e6c899f, Offset: 0xdd8
// Size: 0x54
function sndfunctions() {
    zm_utility::add_sound("zmb_heavy_door_open", "zmb_heavy_door_open");
    level thread setup_personality_character_exerts();
    level thread setupmusic();
}

// Namespace zm_silver/zm_silver
// Params 0, eflags: 0x1 linked
// Checksum 0xe727eef4, Offset: 0xe38
// Size: 0x3c2
function setup_personality_character_exerts() {
    level.exert_sounds[1][#"hitmed"] = "vox_plr_1_exert_pain";
    level.exert_sounds[2][#"hitmed"] = "vox_plr_2_exert_pain";
    level.exert_sounds[3][#"hitmed"] = "vox_plr_3_exert_pain";
    level.exert_sounds[4][#"hitmed"] = "vox_plr_4_exert_pain";
    level.exert_sounds[1][#"hitlrg"] = "vox_plr_1_exert_pain";
    level.exert_sounds[2][#"hitlrg"] = "vox_plr_2_exert_pain";
    level.exert_sounds[3][#"hitlrg"] = "vox_plr_2_exert_pain";
    level.exert_sounds[4][#"hitlrg"] = "vox_plr_3_exert_pain";
    level.exert_sounds[1][#"drowning"] = "vox_plr_1_exert_underwater_air_low";
    level.exert_sounds[2][#"drowning"] = "vox_plr_2_exert_underwater_air_low";
    level.exert_sounds[3][#"drowning"] = "vox_plr_3_exert_underwater_air_low";
    level.exert_sounds[4][#"drowning"] = "vox_plr_4_exert_underwater_air_low";
    level.exert_sounds[1][#"cough"] = "vox_plr_1_exert_gas_cough";
    level.exert_sounds[2][#"cough"] = "vox_plr_2_exert_gas_cough";
    level.exert_sounds[3][#"cough"] = "vox_plr_3_exert_gas_cough";
    level.exert_sounds[4][#"cough"] = "vox_plr_4_exert_gas_cough";
    level.exert_sounds[1][#"underwater_emerge"] = "vox_plr_1_exert_underwater_emerge_breath";
    level.exert_sounds[2][#"underwater_emerge"] = "vox_plr_2_exert_underwater_emerge_breath";
    level.exert_sounds[3][#"underwater_emerge"] = "vox_plr_3_exert_underwater_emerge_breath";
    level.exert_sounds[4][#"underwater_emerge"] = "vox_plr_4_exert_underwater_emerge_breath";
    level.exert_sounds[1][#"underwater_gasp"] = "vox_plr_1_exert_underwater_emerge_gasp";
    level.exert_sounds[2][#"underwater_gasp"] = "vox_plr_2_exert_underwater_emerge_gasp";
    level.exert_sounds[3][#"underwater_gasp"] = "vox_plr_3_exert_underwater_emerge_gasp";
    level.exert_sounds[4][#"underwater_gasp"] = "vox_plr_4_exert_underwater_emerge_gasp";
}

// Namespace zm_silver/zm_silver
// Params 0, eflags: 0x1 linked
// Checksum 0x5669a60d, Offset: 0x1208
// Size: 0x7c
function setupmusic() {
    zm_audio::musicstate_create("round_start", 3, "round_start_00");
    zm_audio::musicstate_create("round_end", 3, "round_end_00");
    zm_audio::musicstate_create("game_over", 5, "gameover");
}

// Namespace zm_silver/zm_silver
// Params 0, eflags: 0x1 linked
// Checksum 0x7686203, Offset: 0x1290
// Size: 0x13a
function function_cd3a65e0() {
    switch (level.dog_round_count) {
    case 2:
        level.next_dog_round = level.round_number + randomintrangeinclusive(5, 7);
        break;
    case 3:
        level.next_dog_round = level.round_number + randomintrangeinclusive(6, 8);
        break;
    case 4:
        level.next_dog_round = level.round_number + randomintrangeinclusive(7, 9);
        break;
    default:
        level.next_dog_round = level.round_number + randomintrangeinclusive(8, 10);
        break;
    }
}

// Namespace zm_silver/zm_silver
// Params 0, eflags: 0x5 linked
// Checksum 0xa5b6c2c5, Offset: 0x13d8
// Size: 0x188
function private function_360fb84d() {
    level endon(#"end_game");
    var_d1ae80e1 = undefined;
    while (true) {
        s_waitresult = level waittill(#"start_of_round", #"pap_quest_completed");
        n_players = zm_utility::function_a2541519(getplayers().size);
        if (n_players == 1 && level.round_number >= 15 || n_players > 1 && level.round_number >= 13 || isdefined(var_d1ae80e1) && level.round_number >= var_d1ae80e1) {
            function_a95110c(level.round_number);
            return;
        }
        if (level flag::get("pap_quest_completed") && !isdefined(var_d1ae80e1)) {
            var_d1ae80e1 = level.round_number + 2;
            while (zm_round_spawning::function_40229072(var_d1ae80e1)) {
                var_d1ae80e1++;
                waitframe(1);
            }
        }
    }
}

// Namespace zm_silver/zm_silver
// Params 1, eflags: 0x5 linked
// Checksum 0x2cfe175f, Offset: 0x1568
// Size: 0x7c
function private function_a95110c(n_round) {
    level.var_ad49daf9 = n_round;
    zm_round_spawning::function_cc103b38(#"hash_7c0d83ac1e845ac2", level.var_ad49daf9);
    level.var_2a8acd42 = &function_55b0a71e;
    level flag::set(#"hash_6d4b62fdfe880888");
}

// Namespace zm_silver/zm_silver
// Params 0, eflags: 0x0
// Checksum 0x405ee21e, Offset: 0x15f0
// Size: 0x7a
function function_87f4bdb0() {
    if (isdefined(level.zm_loc_types[#"dog_location"]) && level.zm_loc_types[#"dog_location"].size) {
        s_spawn_loc = array::random(level.zm_loc_types[#"dog_location"]);
    }
    return s_spawn_loc;
}

// Namespace zm_silver/zm_silver
// Params 1, eflags: 0x1 linked
// Checksum 0x782208b9, Offset: 0x1678
// Size: 0xba
function function_55b0a71e(get_all = 0) {
    if (isdefined(level.zm_loc_types[#"steiner_location"]) && level.zm_loc_types[#"steiner_location"].size) {
        if (get_all) {
            s_spawn_loc = level.zm_loc_types[#"steiner_location"];
        } else {
            s_spawn_loc = array::random(level.zm_loc_types[#"steiner_location"]);
        }
    }
    return s_spawn_loc;
}

// Namespace zm_silver/zm_silver
// Params 0, eflags: 0x1 linked
// Checksum 0x80f724d1, Offset: 0x1740
// Size: 0x4
function function_74872db6() {
    
}

// Namespace zm_silver/zm_silver
// Params 0, eflags: 0x1 linked
// Checksum 0x80f724d1, Offset: 0x1750
// Size: 0x4
function on_round_end() {
    
}

// Namespace zm_silver/zm_silver
// Params 0, eflags: 0x0
// Checksum 0x5c5764eb, Offset: 0x1760
// Size: 0x90
function function_ccf0175a() {
    level endon(#"hash_3ff04dee69f9fe00");
    while (gettime() >= level.var_5fe8eeaa) {
        if (level.var_95198344.size < function_7040caed()) {
            namespace_ce8a59be::function_6b39d9c5(1);
            function_93abe410();
            continue;
        }
        function_93abe410();
    }
}

// Namespace zm_silver/zm_silver
// Params 0, eflags: 0x1 linked
// Checksum 0xa3f84c2c, Offset: 0x17f8
// Size: 0x42
function function_93abe410() {
    var_bcb1a003 = function_1401e135();
    level.var_5fe8eeaa += var_bcb1a003 * 1000;
    wait var_bcb1a003;
}

// Namespace zm_silver/zm_silver
// Params 0, eflags: 0x1 linked
// Checksum 0x1431c910, Offset: 0x1848
// Size: 0x1d2
function function_1401e135() {
    switch (level.round_number) {
    case 1:
    case 2:
    case 3:
    case 4:
    case 5:
    case 6:
    case 7:
    case 8:
    case 9:
    case 10:
    case 11:
    case 12:
        return randomintrange(70, 90);
    case 13:
    case 14:
    case 15:
    case 16:
    case 17:
        return randomintrange(40, 60);
    case 18:
    case 19:
    case 20:
        return randomintrange(35, 45);
    default:
        return randomintrange(35, 45);
    }
}

// Namespace zm_silver/zm_silver
// Params 0, eflags: 0x1 linked
// Checksum 0xe30dd01f, Offset: 0x1a28
// Size: 0x1b2
function function_7040caed() {
    if (!level flag::get("power_on")) {
        return -1;
    }
    switch (level.round_number) {
    case 1:
    case 2:
    case 3:
    case 4:
    case 5:
    case 6:
    case 7:
    case 8:
    case 9:
    case 10:
    case 11:
    case 12:
        return 4;
    case 13:
    case 14:
    case 15:
    case 16:
    case 17:
        return 6;
    case 18:
    case 19:
    case 20:
        return 8;
    default:
        return 8;
    }
}

// Namespace zm_silver/zm_silver
// Params 0, eflags: 0x1 linked
// Checksum 0x6a29f051, Offset: 0x1be8
// Size: 0x7c
function function_3ada378c() {
    level flag::wait_till("power_on");
    level.var_3161430e = level.round_number;
    level.var_539f36cd = &function_cd3a65e0;
    level.dog_round_track_override = &dog_round_tracker;
    zombie_dog_util::dog_enable_rounds(0);
}

// Namespace zm_silver/zm_silver
// Params 1, eflags: 0x1 linked
// Checksum 0x4824d9f6, Offset: 0x1c70
// Size: 0xfc
function dog_round_tracker(*var_634c65f0) {
    level.dog_round_count = 1;
    level.next_dog_round = level.round_number <= 5 ? 6 : level.round_number + 1;
    zm_round_spawning::function_b4a8f95a(#"zombie_dog", level.next_dog_round, &zombie_dog_util::dog_round_start, &zombie_dog_util::dog_round_stop, &zombie_dog_util::function_dd162858, &zombie_dog_util::waiting_for_next_dog_spawn, level.var_dc50acfa);
    zm_round_spawning::function_df803678(&zombie_dog_util::function_ed67c5e7);
    /#
        level thread zombie_dog_util::function_de0a6ae4();
    #/
}

