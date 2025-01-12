#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\zm\ai\zm_ai_stoker;
#using scripts\zm\zm_zodt8;
#using scripts\zm\zm_zodt8_pap_quest;
#using scripts\zm_common\callbacks;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_blockers;
#using scripts\zm_common\zm_characters;
#using scripts\zm_common\zm_crafting;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_fasttravel;
#using scripts\zm_common\zm_hero_weapon;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_magicbox;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_round_logic;
#using scripts\zm_common\zm_round_spawning;
#using scripts\zm_common\zm_transformation;
#using scripts\zm_common\zm_trial_util;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_utility_zstandard;
#using scripts\zm_common\zm_weapons;
#using scripts\zm_common\zm_zonemgr;

#namespace zm_zodt8_zstandard;

// Namespace zm_zodt8_zstandard/zm_zodt8_zstandard
// Params 0, eflags: 0x0
// Checksum 0x1e1f32f5, Offset: 0x580
// Size: 0x14
function main() {
    init_level_vars();
}

// Namespace zm_zodt8_zstandard/zm_zodt8_zstandard
// Params 0, eflags: 0x0
// Checksum 0x56168a60, Offset: 0x5a0
// Size: 0x20c
function init_level_vars() {
    function_1f83c16e();
    function_5f0158fa();
    level thread init_pack_a_punch();
    level.fn_custom_round_ai_spawn = undefined;
    level callback::function_8def5e51(&function_8def5e51);
    level.var_6293001b = 1;
    level.var_28af0a = 9;
    level.var_d31a8aee = 12;
    level.var_5f278dbe = 15;
    level.var_92aeb2a = 12;
    level.zombie_hints[#"default_treasure_chest"] = #"hash_57a34375dddce337";
    level thread zm_blockers::function_53852af7("forecastle_window_l", "script_string", 0);
    level thread zm_blockers::function_53852af7("forecastle_window_r", "script_string", 0);
    level thread zm_blockers::function_53852af7("forecastle_window_front", "script_string", 0);
    level thread defend_areas();
    zm_round_spawning::function_f1a0928("stoker", &function_900d27be);
    zm_round_spawning::function_f1a0928("blight_father", &function_c2646a84);
    zm_round_spawning::function_f1a0928("catalyst", &function_ab2b4313);
    level thread zm_crafting::function_4b55c808(#"zblueprint_zod_tricannon_upgrade");
}

// Namespace zm_zodt8_zstandard/zm_zodt8_zstandard
// Params 1, eflags: 0x0
// Checksum 0x18d121, Offset: 0x7b8
// Size: 0x10
function function_ab2b4313(n_max) {
    return n_max;
}

// Namespace zm_zodt8_zstandard/zm_zodt8_zstandard
// Params 1, eflags: 0x0
// Checksum 0xb6500b3a, Offset: 0x7d0
// Size: 0x10
function function_c2646a84(n_max) {
    return 3;
}

// Namespace zm_zodt8_zstandard/zm_zodt8_zstandard
// Params 1, eflags: 0x0
// Checksum 0x2ea203a, Offset: 0x7e8
// Size: 0x34
function function_900d27be(n_max) {
    if (!(isdefined(level.var_cd444a64) && level.var_cd444a64)) {
        return 0;
    }
    return 3;
}

// Namespace zm_zodt8_zstandard/zm_zodt8_zstandard
// Params 0, eflags: 0x0
// Checksum 0x47fe3b0c, Offset: 0x828
// Size: 0x8e
function init_pack_a_punch() {
    level flag::wait_till("start_zombie_round_logic");
    for (var_d49735a6 = 0; var_d49735a6 < level.s_pap_quest.a_s_locations.size; var_d49735a6++) {
        level.s_pap_quest.var_d6c419fd = var_d49735a6;
        zodt8_pap_quest::function_29c316c0();
    }
    level.var_52e58148 = 1;
}

// Namespace zm_zodt8_zstandard/zm_zodt8_zstandard
// Params 0, eflags: 0x0
// Checksum 0x8f5fbc8c, Offset: 0x8c0
// Size: 0x86
function function_8def5e51() {
    if (level.round_number <= 7) {
        level.var_fe52218 = 1;
        level.var_11a34219 = 62500;
        level.var_1aa29bc2 = 62500;
        return;
    }
    level.var_e40174fb = undefined;
    level.var_1c2b792c = undefined;
    level.var_fe52218 = undefined;
    level.var_11a34219 = undefined;
    level.var_1aa29bc2 = undefined;
}

// Namespace zm_zodt8_zstandard/zm_zodt8_zstandard
// Params 1, eflags: 0x0
// Checksum 0x670efca3, Offset: 0x950
// Size: 0x24
function function_3efef692(n_round_number) {
    zm_ai_stoker::spawn_single(1);
}

// Namespace zm_zodt8_zstandard/zm_zodt8_zstandard
// Params 1, eflags: 0x0
// Checksum 0xe949b0db, Offset: 0x980
// Size: 0x24
function intro_blight_father(n_round_number) {
    zm_transform::function_5dbbf742("blight_father");
}

// Namespace zm_zodt8_zstandard/zm_zodt8_zstandard
// Params 0, eflags: 0x0
// Checksum 0x19181c27, Offset: 0x9b0
// Size: 0x6f4
function defend_areas() {
    level endon(#"end_game");
    level flag::wait_till("start_zombie_round_logic");
    zm_utility::enable_power_switch(0);
    function_b08cc079();
    /#
        if (getdvarint(#"hash_b3363e1d25715d7", 0)) {
            zm_utility::enable_power_switch(1, 1);
            level function_d8a737b1();
            return;
        }
    #/
    str_next_defend = array::random(array(#"lounge", #"dining_hall"));
    s_defend_area = zm_utility::function_f7cc2e9e(str_next_defend);
    str_first_defend = str_next_defend;
    if (str_next_defend == #"dining_hall") {
        zm_utility::function_a5e87276(3);
        level zm_utility::open_door("forecastle_state_rooms_door", undefined, undefined, 1);
        util::delay(4, undefined, &zm_utility::function_8eef3e0e, #"dining_hall");
        zm_utility::function_a5e87276(5);
        level zm_utility::open_door("state_rooms_to_lower_stairs_door", undefined, undefined, 1);
        zm_utility::function_a5e87276(7);
        level zm_utility::open_door("grand_stair_lower_to_dining", undefined, undefined, 1);
    } else {
        zm_utility::function_a5e87276(3);
        level zm_utility::open_door("state_rooms_bridge_door", undefined, undefined, 1);
        zm_utility::function_8eef3e0e(#"lounge");
        zm_utility::function_a5e87276(5);
        level zm_utility::open_door("bridge_to_upper_stairs_door", undefined, undefined, 1);
        zm_utility::function_a5e87276(7);
        level zm_utility::open_door("grand_stairs_suites_door", undefined, undefined, 1);
    }
    zm_zonemgr::function_6fd39598(s_defend_area.a_str_zones);
    zm_round_spawning::function_1a28bc99("stoker", &function_3efef692);
    level thread zm_utility::function_9928fae6(s_defend_area.var_94785111, s_defend_area.a_str_zones, s_defend_area.var_bf9da5f0, undefined, undefined, 45);
    level flag::wait_till("started_defend_area");
    level util::delay(25, "end_game", &zm_round_spawning::function_c9b9ab96, "stoker");
    level waittill(#"hash_7a04a7fb98fa4e4d");
    if (str_next_defend == #"dining_hall") {
        level zm_utility::open_door(array("dining_to_promenade_door", "promenade_aft_door"), undefined, 15, 1);
    } else {
        level zm_utility::open_door(array("suites_promenade_door", "library_boat_deck_door"), undefined, 15, 1);
    }
    str_next_defend = #"poop_deck";
    util::delay(4, undefined, &zm_utility::function_8eef3e0e, #"poop_deck");
    zm_zonemgr::zone_wait_till_enabled("zone_poop_deck");
    level waittill(#"end_of_round");
    zm_round_spawning::function_1a28bc99("blight_father", &intro_blight_father);
    level thread zm_utility::function_9928fae6(#"hash_5f80d9ba2fc090a", array("zone_poop_deck"), "s_mandatory_destination_poop_deck");
    level flag::wait_till("started_defend_area");
    level util::delay(4, "end_game", &zm_round_spawning::function_c9b9ab96, "blight_father");
    level waittill(#"hash_7a04a7fb98fa4e4d");
    level.var_cd444a64 = 1;
    zm_utility::enable_power_switch(1, 1);
    if (str_first_defend == #"dining_hall") {
        var_1515a2c = array("suites_promenade_door", "library_boat_deck_door", "state_rooms_bridge_door", "bridge_to_upper_stairs_door", "grand_stairs_suites_door");
    } else {
        var_1515a2c = array("dining_to_promenade_door", "promenade_aft_door", "forecastle_state_rooms_door", "state_rooms_to_lower_stairs_door", "grand_stair_lower_to_dining");
    }
    level zm_utility::open_door(var_1515a2c, undefined, 15, 1);
    function_fea7e640();
}

// Namespace zm_zodt8_zstandard/zm_zodt8_zstandard
// Params 0, eflags: 0x0
// Checksum 0x1f37dc4e, Offset: 0x10b0
// Size: 0x59c
function function_b08cc079() {
    zm_utility::function_91dbbd22("poop_deck", "s_mandatory_destination_poop_deck", array("zone_poop_deck"), array("engine_room", "lounge", "dining_hall", "boat_deck"), #"hash_419e018f0a0f07fe", #"hash_5f80d9ba2fc090a");
    zm_utility::function_91dbbd22("lounge", "s_mandatory_destination_lounge", array("zone_lounge"), array("engine_room", "poop_deck", "cargo_hold", "bridge"), #"hash_40ba277929e49516", #"hash_2bed1c6d7afa4192");
    zm_utility::function_91dbbd22("dining_hall", "s_mandatory_destination_dining_hall", array("zone_dining_hall_fore", "zone_dining_hall_aft"), array("poop_deck", "engine_room", "cargo_hold", "forecastle"), #"hash_8a9d3480015e78b", #"hash_6bdaac7090cd4985");
    zm_utility::function_91dbbd22("boat_deck", "s_mandatory_destination_obj_fore_deck", array("zone_fore_deck"), array("bridge", "engine_room", "poop_deck", "forecastle"), #"hash_7ed3d98c25f1502a", #"hash_4b2d803f03300036");
    zm_utility::function_91dbbd22("forecastle", "s_mandatory_destination_obj_forecastle", array("zone_forecastle_lower", "zone_forecastle_upper"), array("cargo_hold", "bridge", "boat_deck", "dining_hall"), #"hash_27ad030950415bce", #"hash_fc714290197baba");
    zm_utility::function_91dbbd22("engine_room", "s_mandatory_destination_engine_room", array("zone_upper_engine_room", "zone_engine"), array("poop_deck", "boat_deck", "lounge", "dining_hall"), #"hash_1f86bdff7abc4240", #"hash_7b8e9ff889f16cb0");
    zm_utility::function_91dbbd22("cargo_hold", "s_mandatory_destination_obj_cargo", array("zone_cargo"), array("forecastle", "lounge", "dining_hall", "bridge"), #"hash_380fd44f5294766c", #"hash_49f3092df33c779c");
    zm_utility::function_91dbbd22("bridge", "s_mandatory_destination_obj_bridge", array("zone_bridge"), array("forecastle", "cargo_hold", "boat_deck", "lounge"), #"hash_a3060fdfbbfdadb", #"hash_705b2c8817bf3775");
    a_str_keys = getarraykeys(level.a_s_defend_areas);
    foreach (s_defend_area in level.a_s_defend_areas) {
        foreach (str_index in s_defend_area.a_str_next_defend) {
            str_index = hash(str_index);
            assert(isinarray(a_str_keys, str_index), str_index + "<dev string:x30>");
        }
    }
}

// Namespace zm_zodt8_zstandard/zm_zodt8_zstandard
// Params 0, eflags: 0x0
// Checksum 0xc9322ca0, Offset: 0x1658
// Size: 0x1a2
function function_fea7e640() {
    level endon(#"end_game");
    str_next_defend = zm_utility::function_c3367f31("poop_deck");
    for (var_7a1cf45f = zm_utility::function_f7cc2e9e(str_next_defend); true; var_7a1cf45f = zm_utility::function_f7cc2e9e(str_next_defend)) {
        zm_utility::function_8eef3e0e(str_next_defend);
        if (str_next_defend == #"engine_room") {
            level thread zm_utility::open_door(array("engine_room_door", "engine_room_dropdown"), undefined, 10);
        } else if (str_next_defend == #"cargo_hold") {
            level thread zm_utility::open_door("cargo_hold_door", undefined, 10);
        }
        wait 45;
        zm_zonemgr::function_6fd39598(var_7a1cf45f.a_str_zones);
        zm_utility::function_9928fae6(var_7a1cf45f.var_94785111, var_7a1cf45f.a_str_zones, var_7a1cf45f.var_bf9da5f0);
        str_previous_defend = str_next_defend;
        str_next_defend = zm_utility::function_c3367f31(str_next_defend);
    }
}

/#

    // Namespace zm_zodt8_zstandard/zm_zodt8_zstandard
    // Params 0, eflags: 0x0
    // Checksum 0x4730fbe1, Offset: 0x1808
    // Size: 0x114
    function function_25d773fe() {
        level flag::wait_till("<dev string:x55>");
        player = util::gethostplayer();
        player util::waittill_stance_button_pressed();
        zm_utility::function_3e7cd25d("<dev string:x6e>");
        wait 0.5;
        player util::waittill_stance_button_pressed();
        zm_utility::function_3e7cd25d("<dev string:x9b>");
        wait 0.5;
        player util::waittill_stance_button_pressed();
        zm_utility::function_3e7cd25d("<dev string:xc4>");
        wait 0.5;
        player util::waittill_stance_button_pressed();
        zm_utility::function_3e7cd25d("<dev string:xe5>");
    }

    // Namespace zm_zodt8_zstandard/zm_zodt8_zstandard
    // Params 0, eflags: 0x0
    // Checksum 0xa655b5a0, Offset: 0x1928
    // Size: 0x112
    function function_d8a737b1() {
        wait 5;
        str_next_defend = zm_utility::function_c3367f31("<dev string:x10f>");
        var_7a1cf45f = zm_utility::function_f7cc2e9e(str_next_defend);
        zm_utility::enable_power_switch(1, 1);
        while (true) {
            zm_utility::function_8eef3e0e(str_next_defend);
            wait 5;
            zm_utility::function_9928fae6(var_7a1cf45f.var_94785111, var_7a1cf45f.a_str_zones, var_7a1cf45f.var_bf9da5f0, undefined, undefined, 3);
            str_previous_defend = str_next_defend;
            str_next_defend = zm_utility::function_c3367f31(str_next_defend);
            var_7a1cf45f = zm_utility::function_f7cc2e9e(str_next_defend);
        }
    }

#/

// Namespace zm_zodt8_zstandard/zm_zodt8_zstandard
// Params 2, eflags: 0x0
// Checksum 0x3a318ca, Offset: 0x1a48
// Size: 0x376
function function_302c8417(player, var_796a4e2a) {
    b_result = 0;
    if (isdefined(self.stub)) {
        str_loc = self.stub.script_string;
    }
    if (!isdefined(self.hint_string)) {
        self.hint_string = [];
    }
    n_player_index = player getentitynumber();
    if (level flag::get(#"disable_fast_travel")) {
        self.hint_string[n_player_index] = #"hash_91829275c00db24";
    } else if (!(isdefined(player zombie_utility::is_player_valid(player)) && player zombie_utility::is_player_valid(player))) {
        self.hint_string[n_player_index] = #"";
    } else if (isdefined(player.var_14f171d3) && player.var_14f171d3) {
        self.hint_string[n_player_index] = #"";
    } else if (!level flag::get("power_on")) {
        self.hint_string[n_player_index] = #"";
    } else if (isdefined(player.var_56c7266a) && player.var_56c7266a && str_loc != "dropout") {
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
    } else {
        self.hint_string[n_player_index] = #"hash_204ec88c63b3436b";
        b_result = 1;
    }
    return b_result;
}

// Namespace zm_zodt8_zstandard/zm_zodt8_zstandard
// Params 0, eflags: 0x0
// Checksum 0x66586788, Offset: 0x1dc8
// Size: 0x3c
function function_1f83c16e() {
    if (zm_utility::function_39616495()) {
        zm_utility::function_68cfaf55(#"hash_6db3dde314ca084", 0);
    }
}

// Namespace zm_zodt8_zstandard/zm_zodt8_zstandard
// Params 0, eflags: 0x0
// Checksum 0x661b7295, Offset: 0x1e10
// Size: 0x3cc
function function_5f0158fa() {
    zm_utility::function_43a1716a(1, "zombie", 8, 6);
    zm_utility::function_43a1716a(2, "zombie", 10, 6);
    zm_utility::function_43a1716a(3, "zombie", 10, 6);
    zm_utility::function_43a1716a(4, "zombie", 10, 6);
    zm_utility::function_43a1716a(5, "zombie", 12, 6);
    zm_utility::function_43a1716a(6, "zombie", 12, 6);
    zm_utility::function_43a1716a(7, "zombie", 12, 8);
    zm_utility::function_43a1716a(8, "zombie", 14, 8);
    zm_utility::function_43a1716a(9, "zombie", 14, 8);
    zm_utility::function_43a1716a(10, "zombie", 14, 10);
    zm_utility::function_43a1716a(11, "zombie", 16, 10);
    zm_utility::function_43a1716a(12, "zombie", 16, 10);
    zm_utility::function_43a1716a(13, "zombie", 16, 12);
    zm_utility::function_43a1716a(14, "zombie", 16, 12);
    zm_utility::function_43a1716a(15, "zombie", 16, 14);
    zm_utility::function_43a1716a(16, "zombie", 20, 14);
    zm_utility::function_43a1716a(17, "zombie", 24, 14);
    n_zombie_min = 16;
    for (n_round = 18; n_round < 255; n_round++) {
        zm_utility::function_43a1716a(n_round, "zombie", undefined, n_zombie_min);
        n_zombie_min++;
        n_zombie_min = math::clamp(n_zombie_min, 16, 24);
    }
    zm_round_spawning::function_1a28bc99("stoker", &function_db462363);
    zm_round_spawning::function_1a28bc99("catalyst", &function_f1234c92);
    zm_round_spawning::function_1a28bc99("blight_father", &function_d255c122);
    zm_round_spawning::function_2b3870c9("catalyst", 4);
}

// Namespace zm_zodt8_zstandard/zm_zodt8_zstandard
// Params 1, eflags: 0x0
// Checksum 0x65045611, Offset: 0x21e8
// Size: 0x2c
function function_db462363(n_round_number) {
    zm_utility::function_5842b86c("stoker", 1);
}

// Namespace zm_zodt8_zstandard/zm_zodt8_zstandard
// Params 1, eflags: 0x0
// Checksum 0x4f5bce07, Offset: 0x2220
// Size: 0x2c
function function_f1234c92(n_round_number) {
    zm_utility::function_5842b86c("catalyst", 1);
}

// Namespace zm_zodt8_zstandard/zm_zodt8_zstandard
// Params 1, eflags: 0x0
// Checksum 0xf735a327, Offset: 0x2258
// Size: 0x2c
function function_d255c122(n_round_number) {
    zm_utility::function_5842b86c("blight_father", 1);
}

// Namespace zm_zodt8_zstandard/zm_zodt8_zstandard
// Params 0, eflags: 0x0
// Checksum 0xe8e7cfc8, Offset: 0x2290
// Size: 0x2f8
function function_8078dda0() {
    level endon(#"end_game");
    while (true) {
        s_waitresult = level waittill(#"hash_4ffec9c5f552e6fc");
        if (isdefined(s_waitresult.e_door) && isdefined(s_waitresult.e_door.script_flag)) {
            switch (s_waitresult.e_door.script_flag) {
            case #"connect_forecastle_to_state_rooms":
                var_a8b262b9 = #"hash_2b0a7eea7d5837b2";
                break;
            case #"connect_forecastle_to_bridge":
                var_a8b262b9 = #"hash_1164f7d8857e245";
                break;
            case #"connect_state_rooms_to_millionaire":
                var_a8b262b9 = #"hash_655f56d5efd95945";
                break;
            case #"connect_grand_stair_lower_to_dining":
                var_a8b262b9 = #"hash_aea2910160f712a";
                break;
            case #"connect_dining_to_promenade":
                var_a8b262b9 = #"hash_7e2ebfe7b5099a2e";
                break;
            case #"connect_promenade_to_poop":
                var_a8b262b9 = #"hash_34b52b88e2ff0049";
                break;
            case #"connect_aft_to_poop_deck":
                var_a8b262b9 = #"hash_1970bc2b9acd5bf5";
                break;
            case #"connect_suites_to_aft":
                var_a8b262b9 = #"hash_2bc3fbaefaa3b764";
                break;
            case #"connect_grand_stairs_to_lounge":
                var_a8b262b9 = #"hash_334ff5daed081f31";
                break;
            case #"connect_bridge_to_grand_stairs":
                var_a8b262b9 = #"hash_7f462ab50be41252";
                break;
            case #"connect_mail_rooms_to_cargo":
                var_a8b262b9 = #"hash_25929136eae0e6ae";
                break;
            case #"connect_provisions_to_engine_room":
                var_a8b262b9 = #"hash_a8d366608b42172";
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

