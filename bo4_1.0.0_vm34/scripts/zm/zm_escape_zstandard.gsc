#using script_2595527427ea71eb;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\zm\zm_escape_pap_quest;
#using scripts\zm_common\callbacks;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_blockers;
#using scripts\zm_common\zm_characters;
#using scripts\zm_common\zm_crafting;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_fasttravel;
#using scripts\zm_common\zm_hero_weapon;
#using scripts\zm_common\zm_items;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_magicbox;
#using scripts\zm_common\zm_pack_a_punch;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_round_logic;
#using scripts\zm_common\zm_round_spawning;
#using scripts\zm_common\zm_transformation;
#using scripts\zm_common\zm_trial_util;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_utility_zstandard;
#using scripts\zm_common\zm_weapons;
#using scripts\zm_common\zm_zonemgr;

#namespace zm_escape_zstandard;

// Namespace zm_escape_zstandard/zm_escape_zstandard
// Params 0, eflags: 0x0
// Checksum 0x94a62cab, Offset: 0x4f8
// Size: 0x14
function main() {
    init_level_vars();
}

// Namespace zm_escape_zstandard/zm_escape_zstandard
// Params 0, eflags: 0x0
// Checksum 0x3074517d, Offset: 0x518
// Size: 0x114
function init_level_vars() {
    function_1f83c16e();
    function_5f0158fa();
    level thread init_pack_a_punch();
    level.fn_custom_round_ai_spawn = undefined;
    level callback::function_8def5e51(&function_8def5e51);
    level.var_6293001b = 1;
    level.var_28af0a = 8;
    level.var_d31a8aee = 13;
    level.var_5f278dbe = 13;
    level.var_92aeb2a = 16;
    level.zombie_hints[#"default_treasure_chest"] = #"hash_57a34375dddce337";
    level thread defend_areas();
    level thread function_8cc0f3a4();
}

// Namespace zm_escape_zstandard/zm_escape_zstandard
// Params 0, eflags: 0x0
// Checksum 0x85521d8c, Offset: 0x638
// Size: 0x20a
function function_8cc0f3a4() {
    level waittill(#"all_players_spawned");
    w_item = zm_crafting::get_component(#"zitem_spectral_shield_part_3");
    e_player = array::random(level.players);
    zm_items::player_pick_up(e_player, w_item);
    foreach (a_s_crafting in level.var_1c7ed52c) {
        foreach (s_crafting in a_s_crafting) {
            if (isarray(s_crafting.craftfoundry.blueprints)) {
                foreach (s_blueprint in s_crafting.craftfoundry.blueprints) {
                    if (s_blueprint.name === #"zblueprint_shield_spectral_shield") {
                        s_crafting.blueprint = s_blueprint;
                    }
                }
            }
        }
    }
}

// Namespace zm_escape_zstandard/zm_escape_zstandard
// Params 0, eflags: 0x0
// Checksum 0x2284be88, Offset: 0x850
// Size: 0x2bc
function init_pack_a_punch() {
    var_dd171a15 = getentarray("zm_pack_a_punch", "targetname");
    foreach (var_a2c0f1fa in var_dd171a15) {
        if (var_a2c0f1fa.script_string === "power_house") {
            var_a2c0f1fa zm_pack_a_punch::set_state_initial();
            var_a2c0f1fa zm_pack_a_punch::set_state_hidden();
            pap_quest::pap_debris(1, var_a2c0f1fa.script_string);
            var_a2c0f1fa notify(#"hash_168e8f0e18a79cf8");
            continue;
        }
        pap_quest::pap_debris(0, var_a2c0f1fa.script_string);
    }
    level waittill(#"hash_6c660debf41d6362", #"open_sesame");
    var_dd171a15 = getentarray("zm_pack_a_punch", "targetname");
    foreach (var_a2c0f1fa in var_dd171a15) {
        if (var_a2c0f1fa.script_string === "power_house") {
            exploder::exploder("lgtexp_pap_powerhouse_on");
        } else if (var_a2c0f1fa.script_string === "roof") {
            exploder::exploder("lgtexp_pap_rooftops_on");
        } else {
            exploder::exploder("lgtexp_pap_b64_on");
        }
        var_a2c0f1fa zm_pack_a_punch::function_e95839cd(1);
        pap_quest::pap_debris(0, var_a2c0f1fa.script_string);
        var_a2c0f1fa notify(#"hash_168e8f0e18a79cf8");
    }
    level zm_utility::function_d7a33664(#"hash_200e228d5c301025");
}

// Namespace zm_escape_zstandard/zm_escape_zstandard
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0xb18
// Size: 0x4
function function_8def5e51() {
    
}

// Namespace zm_escape_zstandard/zm_escape_zstandard
// Params 0, eflags: 0x0
// Checksum 0xde1d4209, Offset: 0xb28
// Size: 0x3c
function function_1f83c16e() {
    if (zm_utility::function_39616495()) {
        zm_utility::function_68cfaf55(#"hash_6db3dde314ca084", 0);
    }
}

// Namespace zm_escape_zstandard/zm_escape_zstandard
// Params 0, eflags: 0x0
// Checksum 0x5d756bf3, Offset: 0xb70
// Size: 0xcd0
function defend_areas() {
    level endon(#"end_game");
    level flag::wait_till("start_zombie_round_logic");
    function_b08cc079();
    var_c596feec = getent("t_catwalk_door_open", "targetname");
    var_c596feec sethintstring(#"hash_1228aacbdf256d7e");
    t_door_catwalk = getent("door_model_west_side_exterior_to_catwalk", "target");
    t_door_catwalk sethintstring(#"hash_1228aacbdf256d7e");
    zm_utility::enable_power_switch(0, 0, "power_house_power_switch", "script_noteworthy", #"hash_58ad53dcf0f18a1");
    zm_utility::enable_power_switch(0, 0, "building_64_switches", "script_noteworthy", #"hash_40e952a5e8c4e1f5");
    enable_gondola_at_docks(0);
    /#
        if (getdvarint(#"hash_b3363e1d25715d7", 0)) {
            level notify(#"hash_417b024aa81e3cb8");
            level thread function_ce3ea206();
            level thread enable_gondola_at_docks(1);
            level thread function_970b3257();
            return;
        }
    #/
    level waittill(#"end_of_round");
    level zm_utility::open_door("door_model_industries_to_west_side_exterior", undefined, undefined, 1);
    str_next_defend = array::random(array(#"powerhouse", #"new_industries"));
    level waittill(#"end_of_round");
    if (str_next_defend == #"powerhouse") {
        level zm_utility::open_door("door_model_west_side_exterior_upper_to_west_side_exterior_upper", undefined, undefined, 1);
    } else {
        level zm_utility::open_door("door_model_west_side_exterior_to_new_industries", undefined, undefined, 1);
    }
    util::delay(4, undefined, &zm_utility::function_8eef3e0e, str_next_defend);
    zm_zonemgr::function_6fd39598(array("zone_powerhouse", "zone_new_industries"));
    wait 3;
    zm_utility::enable_power_switch(1, 1, "power_house_power_switch", "script_noteworthy");
    level notify(#"hash_417b024aa81e3cb8");
    if (str_next_defend == #"new_industries") {
        str_first_defend = #"new_industries";
        str_second_defend = #"powerhouse";
    } else {
        str_first_defend = #"powerhouse";
        str_second_defend = #"new_industries";
    }
    wait 5;
    s_defend_area = zm_utility::function_f7cc2e9e(str_first_defend);
    zm_utility::function_9928fae6(s_defend_area.var_94785111, s_defend_area.a_str_zones, s_defend_area.var_bf9da5f0, undefined, undefined, 30);
    zm_utility::function_8107842e(str_first_defend);
    level zm_utility::open_door(array("door_model_west_side_exterior_upper_to_west_side_exterior_upper", "door_model_west_side_exterior_to_new_industries", "west_side_exterior_lower_to_tunnel"), 0, 8, 1);
    s_defend_area = zm_utility::function_f7cc2e9e(str_second_defend);
    zm_utility::function_9928fae6(s_defend_area.var_94785111, s_defend_area.a_str_zones, s_defend_area.var_bf9da5f0, undefined, undefined, 45);
    zm_utility::function_8107842e(str_second_defend);
    level notify(#"hash_545d84d6e7f5c7a6");
    str_next_defend = array::random(array(#"cd_street", #"times_square", #"michigan_avenue", #"cafeteria"));
    switch (str_next_defend) {
    case #"cd_street":
    case #"michigan_avenue":
    case #"times_square":
        var_1515a2c = array("cellblock_east_door", "cellblock_start_door");
        break;
    case #"cafeteria":
        var_1515a2c = array("cellblock_east_door", "cellblock_start_door", "door_cafeteria_to_times_square");
        break;
    }
    level zm_utility::open_door(var_1515a2c, 0, 8, 1);
    var_c596feec sethintstring(#"hash_52803ee9fe3f2ea5");
    var_c596feec notify(#"trigger");
    s_defend_area = zm_utility::function_f7cc2e9e(str_next_defend);
    util::delay(4, undefined, &zm_utility::function_8eef3e0e, str_next_defend);
    zm_zonemgr::function_6fd39598(s_defend_area.a_str_zones);
    wait 60;
    zm_utility::function_9928fae6(s_defend_area.var_94785111, s_defend_area.a_str_zones, s_defend_area.var_bf9da5f0, undefined, undefined, 30);
    zm_utility::function_8107842e(str_next_defend);
    level zm_utility::open_door("door_michigan_ave_to_citadel", 0, 8, 1);
    util::delay(4, undefined, &zm_utility::function_8eef3e0e, #"citadel");
    s_defend_area = zm_utility::function_f7cc2e9e(#"citadel");
    wait 45;
    zm_zonemgr::function_6fd39598(s_defend_area.a_str_zones);
    zm_utility::function_9928fae6(s_defend_area.var_94785111, s_defend_area.a_str_zones, s_defend_area.var_bf9da5f0, undefined, undefined, 45);
    zm_utility::function_8107842e(#"citadel");
    level thread function_ce3ea206(1);
    str_next_defend = array::random(array(#"building_64", #"docks"));
    if (str_next_defend == #"building_64") {
        var_1515a2c = array("door_citadel_to_tunnels", "sally_door");
    } else {
        var_1515a2c = array("door_citadel_to_tunnels", "door_alley_to_docks_bridge");
    }
    level zm_utility::open_door(var_1515a2c, 0, 8, 1);
    util::delay(4, undefined, &zm_utility::function_8eef3e0e, str_next_defend);
    wait 45;
    s_defend_area = zm_utility::function_f7cc2e9e(str_next_defend);
    zm_zonemgr::function_6fd39598(s_defend_area.a_str_zones);
    zm_utility::function_9928fae6(s_defend_area.var_94785111, s_defend_area.a_str_zones, s_defend_area.var_bf9da5f0, undefined, undefined, undefined);
    zm_utility::function_8107842e(str_next_defend);
    if (str_next_defend == #"building_64") {
        str_next_defend = #"docks";
        var_1515a2c = array("door_alley_to_docks_bridge", "door_sally_to_docks");
    } else {
        str_next_defend = #"building_64";
        var_1515a2c = array("sally_door", "door_sally_to_docks");
    }
    level zm_utility::open_door(var_1515a2c, 0, 8, 1);
    util::delay(4, undefined, &zm_utility::function_8eef3e0e, str_next_defend);
    s_defend_area = zm_utility::function_f7cc2e9e(str_next_defend);
    zm_zonemgr::function_6fd39598(s_defend_area.a_str_zones);
    wait 10;
    level thread zm_utility::function_9928fae6(s_defend_area.var_94785111, s_defend_area.a_str_zones, s_defend_area.var_bf9da5f0);
    level waittill(#"hash_7a04a7fb98fa4e4d");
    zm_utility::function_8107842e(str_next_defend);
    level enable_gondola_at_docks(1);
    zm_utility::open_door(array("door_cafeteria_to_times_square", "door_cell_block_floor_3", "door_cafeteria_to_infirmary", "door_shower_to_citadel", "door_model_warden_office_to_warden_house"), undefined, undefined, 1);
    wait 4;
    str_next_defend = array::random(array(#"roof", #"warden_house", #"cafeteria", #"showers"));
    while (true) {
        zm_utility::function_8eef3e0e(str_next_defend);
        wait 45;
        s_defend_area = zm_utility::function_f7cc2e9e(str_next_defend);
        zm_zonemgr::function_6fd39598(s_defend_area.a_str_zones);
        zm_utility::function_9928fae6(s_defend_area.var_94785111, s_defend_area.a_str_zones, s_defend_area.var_bf9da5f0, undefined, undefined, undefined);
        str_next_defend = zm_utility::function_c3367f31(str_next_defend);
        waitframe(1);
    }
}

// Namespace zm_escape_zstandard/zm_escape_zstandard
// Params 1, eflags: 0x0
// Checksum 0xe4102cf7, Offset: 0x1848
// Size: 0x58c
function enable_gondola_at_docks(b_enable) {
    var_adb5f9e = getentarray("gondola_call_trigger", "targetname");
    var_9cb23aff = getentarray("gondola_move_trigger", "targetname");
    var_c08d7af0 = arraycombine(var_adb5f9e, var_9cb23aff, 0, 0);
    if (b_enable) {
        level flag::wait_till("gondola_initialized");
        wait 0.5;
        foreach (t_trigger in var_adb5f9e) {
            t_trigger setvisibletoall();
            if (t_trigger.script_string === "docks") {
                t_trigger notify(#"trigger", {#b_forced:1});
            }
        }
        level util::delay(8, "end_game", &array::thread_all, level.players, &zm_equipment::show_hint_text, #"hash_62f8b47c0705cefd", 5);
        level flag::wait_till("gondola_at_docks");
        waitframe(1);
        array::run_all(var_c08d7af0, &setinvisibletoall);
        foreach (player in level.players) {
            player zm_trial_util::stop_timer();
            if (!level.var_bb57ff69 zm_trial_timer::is_open(player)) {
                level.var_bb57ff69 zm_trial_timer::open(player);
            }
            level.var_bb57ff69 zm_trial_timer::set_timer_text(player, #"hash_4de08152dbb1681f");
            player zm_trial_util::start_timer(45);
        }
        n_time = 45;
        while (n_time > 0) {
            var_5a5a5049 = 1;
            foreach (player in level.activeplayers) {
                if (!player istouching(level.e_gondola.t_ride)) {
                    var_5a5a5049 = 0;
                    break;
                }
            }
            if (var_5a5a5049) {
                break;
            }
            n_time--;
            wait 1;
        }
        foreach (player in level.players) {
            if (level.var_bb57ff69 zm_trial_timer::is_open(player)) {
                level.var_bb57ff69 zm_trial_timer::close(player);
            }
            player zm_trial_util::stop_timer();
        }
        foreach (t_trigger in var_9cb23aff) {
            t_trigger setvisibletoall();
            if (t_trigger.script_string === "docks") {
                t_trigger notify(#"trigger", {#b_forced:1});
            }
        }
        array::run_all(var_c08d7af0, &setvisibletoall);
        return;
    }
    array::run_all(var_c08d7af0, &setinvisibletoall);
}

// Namespace zm_escape_zstandard/zm_escape_zstandard
// Params 0, eflags: 0x0
// Checksum 0xacb677a7, Offset: 0x1de0
// Size: 0x924
function function_b08cc079() {
    zm_utility::function_91dbbd22(#"powerhouse", #"hash_3ba02a24d6f7086b", array(#"zone_powerhouse"), undefined, #"hash_5ca408aafa5fddf8", #"hash_6a3b160b4d946718");
    zm_utility::function_91dbbd22(#"new_industries", #"hash_7e3b2316f6e262e1", array(#"zone_new_industries"), undefined, #"hash_432017d6aa7988ed", #"hash_273ce801ad0cb483");
    zm_utility::function_91dbbd22(#"infirmary", #"hash_172bbfcfa72fefdb", array(#"zone_infirmary", #"zone_infirmary_roof"), array(#"roof", #"cafeteria", #"cd_street", #"michigan_avenue"), #"hash_354f9e364d7a69fb", #"hash_365c0402f060c7d5");
    zm_utility::function_91dbbd22(#"citadel", #"hash_2857c7fc5ecb8d5c", array(#"zone_citadel_shower", #"zone_citadel", #"zone_citadel_warden"), array(#"warden_house", #"showers", #"michigan_avenue", #"times_square"), #"hash_2fe5a7985e8825e6", #"hash_7ebaa16cf92b78c2");
    zm_utility::function_91dbbd22(#"cd_street", #"hash_29336180c57eb188", array(#"zone_library", #"zone_cellblock_west", #"zone_broadway_floor_2"), array(#"citadel", #"infirmary", #"cafeteria", #"showers"), #"hash_14700e7ff43a0782", #"hash_8e08c6f6759009e");
    zm_utility::function_91dbbd22(#"michigan_avenue", #"hash_4f13d455c1b0ecc9", array(#"zone_cellblock_west_barber", #"zone_cellblock_west_warden"), array(#"warden_house", #"showers", #"infirmary", #"cafeteria"), #"hash_705c102d1924f0dd", #"hash_6837df2367ad7713");
    zm_utility::function_91dbbd22(#"times_square", #"hash_1ea6cd0ac2c8866a", array(#"zone_cellblock_east"), array(#"citadel", #"roof", #"warden_house", #"infirmary"), #"hash_3f444c87fe7834fc", #"hash_3f7e50e6a57f764c");
    zm_utility::function_91dbbd22(#"cafeteria", #"hash_7e27b77c809a76a", array(#"zone_cafeteria", #"zone_cafeteria_end"), array(#"roof", #"michigan_avenue", #"cd_street", #"warden_house"), #"hash_492da84cdf727cb8", #"hash_694e547781b620d8");
    zm_utility::function_91dbbd22(#"roof", #"hash_218cfbef3166e972", array(#"zone_roof", #"zone_roof_infirmary"), array(#"cafeteria", #"times_square", #"infirmary", #"michigan_avenue"), #"hash_5e20d087e1e88e10", #"hash_606e86c2e28d9fa0");
    zm_utility::function_91dbbd22(#"showers", #"hash_56095721b91ef81f", array(#"cellblock_shower"), array(#"citadel", #"cd_street", #"roof", #"times_square"), #"hash_c1918d583361503", #"hash_3f95fb31de34752d");
    zm_utility::function_91dbbd22(#"building_64", #"hash_15a013048749503b", array(#"zone_studio"), undefined, #"hash_1feef237a0bc79f", #"hash_69300f7b6a0380f9");
    zm_utility::function_91dbbd22(#"docks", #"hash_5a800036a297a5eb", array(#"zone_dock", #"zone_dock_gondola"), undefined, #"hash_63491ae91f2492a6", #"hash_59ffc5ba5f91082");
    zm_utility::function_91dbbd22(#"warden_house", #"hash_6a595abeab660c6e", array(#"zone_warden_house", #"zone_warden_home"), array(#"citadel", #"cd_street", #"times_square", #"showers"), #"hash_7aedc433d6fa560c", #"hash_162e6d4e0e721dfc");
}

// Namespace zm_escape_zstandard/zm_escape_zstandard
// Params 1, eflags: 0x0
// Checksum 0xc4192b01, Offset: 0x2710
// Size: 0x168
function function_ce3ea206(b_wait_for_player = 0) {
    level endon(#"end_game");
    if (b_wait_for_player) {
        while (true) {
            var_12c3f58b = 0;
            foreach (player in level.activeplayers) {
                if (player zm_zonemgr::is_player_in_zone(#"zone_studio")) {
                    var_12c3f58b = 1;
                    break;
                }
            }
            if (var_12c3f58b) {
                break;
            }
            wait 0.5;
        }
    } else {
        zm_zonemgr::zone_wait_till_enabled(#"zone_studio");
    }
    level thread zm_utility::enable_power_switch(1, 1, "building_64_switches", "script_noteworthy");
    level notify(#"hash_6c660debf41d6362");
}

/#

    // Namespace zm_escape_zstandard/zm_escape_zstandard
    // Params 0, eflags: 0x0
    // Checksum 0xa814a192, Offset: 0x2880
    // Size: 0x1e2
    function function_970b3257() {
        while (true) {
            zm_utility::function_8eef3e0e("<dev string:x30>");
            wait 10;
            s_defend_area = zm_utility::function_f7cc2e9e("<dev string:x30>");
            zm_utility::function_9928fae6(s_defend_area.var_94785111, s_defend_area.a_str_zones, s_defend_area.var_bf9da5f0, undefined, undefined, 10, 2);
            zm_utility::function_8eef3e0e("<dev string:x38>");
            wait 10;
            s_defend_area = zm_utility::function_f7cc2e9e("<dev string:x38>");
            zm_utility::function_9928fae6(s_defend_area.var_94785111, s_defend_area.a_str_zones, s_defend_area.var_bf9da5f0, undefined, undefined, 10, 2);
            foreach (str_index, s_defend_area in level.a_s_defend_areas) {
                s_defend_area = zm_utility::function_f7cc2e9e(str_index);
                zm_utility::function_8eef3e0e(str_index);
                wait 10;
                zm_utility::function_9928fae6(s_defend_area.var_94785111, s_defend_area.a_str_zones, s_defend_area.var_bf9da5f0, undefined, undefined, 5);
            }
            waitframe(1);
        }
    }

#/

// Namespace zm_escape_zstandard/zm_escape_zstandard
// Params 0, eflags: 0x0
// Checksum 0x2cece8d1, Offset: 0x2a70
// Size: 0x2e0
function function_5f0158fa() {
    zm_utility::function_43a1716a(1, "zombie", 8, 6);
    zm_utility::function_43a1716a(2, "zombie", 10, 6);
    zm_utility::function_43a1716a(3, "zombie", 10, 6);
    zm_utility::function_43a1716a(4, "zombie", 10, 6);
    zm_utility::function_43a1716a(5, "zombie", 12, 6);
    zm_utility::function_43a1716a(6, "zombie", 12, 6);
    zm_utility::function_43a1716a(7, "zombie", 12, 8);
    zm_utility::function_43a1716a(8, "zombie", 14, 8);
    zm_utility::function_43a1716a(9, "zombie", 20, 8);
    zm_utility::function_43a1716a(10, "zombie", 20, 10);
    zm_utility::function_43a1716a(11, "zombie", 20, 12);
    zm_utility::function_43a1716a(12, "zombie", 20, 14);
    zm_utility::function_43a1716a(13, "zombie", 20, 16);
    zm_utility::function_43a1716a(14, "zombie", 30, 16);
    zm_utility::function_43a1716a(15, "zombie", 40, 16);
    n_zombie_min = 16;
    for (n_round = 16; n_round < 255; n_round++) {
        zm_utility::function_43a1716a(n_round, "zombie", undefined, n_zombie_min);
        n_zombie_min++;
        n_zombie_min = math::clamp(n_zombie_min, 16, 24);
    }
}

// Namespace zm_escape_zstandard/zm_escape_zstandard
// Params 0, eflags: 0x0
// Checksum 0xc59cf5b0, Offset: 0x2d58
// Size: 0x3c0
function function_1d4e4ee0() {
    level endon(#"end_game");
    while (true) {
        s_waitresult = level waittill(#"hash_4ffec9c5f552e6fc");
        if (isdefined(s_waitresult.e_door) && isdefined(s_waitresult.e_door.script_flag)) {
            switch (s_waitresult.e_door.script_flag) {
            case #"activate_west_side_exterior":
                var_a8b262b9 = #"hash_48b098165e01518e";
                break;
            case #"activate_new_industries":
                var_a8b262b9 = #"hash_50e05912992c7bc3";
                break;
            case #"activate_west_side_exterior_lower":
                var_a8b262b9 = #"hash_4ddad8473f8f44cd";
                break;
            case #"activate_west_side_exterior_tunnel":
                var_a8b262b9 = #"hash_3f684b6336ac27e7";
                break;
            case #"activate_cellblock_ca":
                var_a8b262b9 = #"hash_4766f082bbf2cbf0";
                break;
            case #"activate_cafeteria":
                var_a8b262b9 = #"hash_4f024ba2f12a1e8";
                break;
            case #"activate_infirmary":
                var_a8b262b9 = #"hash_2525f49ae61a9065";
                break;
            case #"activate_cellblock_infirmary":
                var_a8b262b9 = #"hash_18077f7c3b49f099";
                break;
            case #"activate_wa_h":
                var_a8b262b9 = #"hash_a15209027c6a477";
                break;
            case #"activate_cellblock_library":
                var_a8b262b9 = #"hash_2d2fbe4505249056";
                break;
            case #"activate_cellblock_gondola":
                var_a8b262b9 = #"hash_7a8ad982bdebf31";
                break;
            case #"activate_basement_gondola":
                var_a8b262b9 = #"hash_50679632c0929ef5";
                break;
            case #"activate_basement_building":
                var_a8b262b9 = #"hash_7b6541d8fb121048";
                break;
            case #"activate_dock_sally":
                var_a8b262b9 = #"hash_22b9577531ef397d";
                break;
            case #"activate_citadel_stair":
                var_a8b262b9 = #"hash_4febfe746d3a53b1";
                break;
            case #"activate_cellblock_citadel":
                var_a8b262b9 = #"hash_11d4351c92a0261";
                break;
            case #"activate_shower_citadel":
                var_a8b262b9 = #"hash_41102abe52b5027";
                break;
            default:
                if (s_waitresult.e_door.targetname === "zombie_debris") {
                    var_a8b262b9 = #"hash_782714d88bdaa1b6";
                } else {
                    var_a8b262b9 = #"hash_7203281c0385cddd";
                }
                break;
            }
            level zm_utility::function_d7a33664(var_a8b262b9);
        }
    }
}

