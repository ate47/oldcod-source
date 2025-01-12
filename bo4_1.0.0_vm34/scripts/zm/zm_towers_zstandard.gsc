#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\zm\zm_towers_crowd;
#using scripts\zm\zm_towers_pap_quest;
#using scripts\zm\zm_towers_special_rounds;
#using scripts\zm_common\callbacks;
#using scripts\zm_common\util\ai_gladiator_util;
#using scripts\zm_common\util\ai_tiger_util;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_magicbox;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_round_logic;
#using scripts\zm_common\zm_round_spawning;
#using scripts\zm_common\zm_transformation;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_utility_zstandard;
#using scripts\zm_common\zm_zonemgr;

#namespace zm_towers_zstandard;

// Namespace zm_towers_zstandard/zm_towers_zstandard
// Params 0, eflags: 0x0
// Checksum 0x141eff24, Offset: 0x3a0
// Size: 0x14
function main() {
    init_level_vars();
}

// Namespace zm_towers_zstandard/zm_towers_zstandard
// Params 0, eflags: 0x0
// Checksum 0x7fa24d59, Offset: 0x3c0
// Size: 0xfc
function init_level_vars() {
    function_1f83c16e();
    function_5f0158fa();
    level.var_4f18c7cc = #"hash_17758d1de3b1fe6a";
    level.var_e10fd26b = "zblueprint_shield_zhield_zword";
    level.var_28af0a = 7;
    level.var_d31a8aee = 12;
    level.var_5f278dbe = 20;
    level.var_92aeb2a = 20;
    level.zombie_hints[#"default_treasure_chest"] = #"hash_57a34375dddce337";
    callback::function_8def5e51(&function_8def5e51);
    level thread defend_areas();
}

// Namespace zm_towers_zstandard/zm_towers_zstandard
// Params 0, eflags: 0x0
// Checksum 0x2a107894, Offset: 0x4c8
// Size: 0x3e
function function_8def5e51() {
    level.var_e40174fb = undefined;
    level.var_1c2b792c = undefined;
    level.var_fe52218 = undefined;
    level.var_11a34219 = undefined;
    level.var_1aa29bc2 = undefined;
}

/#

    // Namespace zm_towers_zstandard/zm_towers_zstandard
    // Params 0, eflags: 0x0
    // Checksum 0x2dad37df, Offset: 0x510
    // Size: 0x144
    function function_7e22570c() {
        zm_zonemgr::enable_zone("<dev string:x30>");
        zm_zonemgr::enable_zone("<dev string:x43>");
        zm_zonemgr::enable_zone("<dev string:x5a>");
        zm_zonemgr::enable_zone("<dev string:x6e>");
        zm_zonemgr::enable_zone("<dev string:x81>");
        zm_zonemgr::enable_zone("<dev string:x98>");
        zm_zonemgr::enable_zone("<dev string:xac>");
        zm_zonemgr::enable_zone("<dev string:xbf>");
        zm_zonemgr::enable_zone("<dev string:xd6>");
        zm_zonemgr::enable_zone("<dev string:xea>");
        zm_zonemgr::enable_zone("<dev string:xfb>");
        zm_zonemgr::enable_zone("<dev string:x110>");
        zm_zonemgr::enable_zone("<dev string:x122>");
    }

#/

// Namespace zm_towers_zstandard/zm_towers_zstandard
// Params 0, eflags: 0x0
// Checksum 0x8d2e09ec, Offset: 0x660
// Size: 0x674
function function_b08cc079() {
    zm_utility::function_91dbbd22(#"danu", #"hash_692e7036aa28a86e", array(#"zone_danu_top_floor", #"zone_danu_ground_floor"), array(#"temple", #"arena", #"flooded_crypt", #"pit"), #"hash_39a5e0978d0efd73", #"hash_78b1d1196746763d");
    zm_utility::function_91dbbd22(#"ra", #"hash_15c014d044ca67c1", array(#"zone_ra_top_floor", #"zone_ra_ground_floor"), array(#"arena", #"temple", #"flooded_crypt", #"pit"), #"hash_7d572184f439180a", #"hash_298247685ea80656");
    zm_utility::function_91dbbd22(#"odin", #"hash_644b220d0ab22c0c", array(#"zone_odin_top_floor", #"zone_odin_ground_floor"), array(#"temple", #"flooded_crypt", #"pit", #"arena"), #"hash_ed407098b77bc91", #"hash_5e203d11381c57c7");
    zm_utility::function_91dbbd22(#"zeus", #"hash_76fbf2acafa2c1b9", array(#"zone_zeus_ground_floor", #"zone_zeus_top_floor"), array(#"arena", #"flooded_crypt", #"pit", #"temple"), #"hash_417a5feff0cb56ea", #"hash_74941e980968cff6");
    zm_utility::function_91dbbd22(#"temple", #"hash_8117ce3b24d5287", array(#"zone_pap_room", #"zone_pap_room_balcony_flooded_crypt"), array(#"ra", #"danu", #"odin", #"zeus"), #"hash_75add73ac9df6bbc", #"hash_468014d28365550c");
    zm_utility::function_91dbbd22(#"arena", #"hash_67ff9fcb1f12e52d", array(#"zone_starting_area_center"), array(#"ra", #"danu", #"odin", #"zeus"), #"hash_4d59f666d8b7f20c", #"hash_c641ebe32c2d1fc");
    zm_utility::function_91dbbd22(#"pit", #"hash_2db9c4e4d97c7ca9", array(#"zone_body_pit", #"zone_fallen_hero"), array(#"ra", #"danu", #"odin", #"zeus"), #"hash_6880f6ff86cde47e", #"hash_30733dec2e9e228a");
    zm_utility::function_91dbbd22(#"flooded_crypt", #"hash_68baa2a5397d37da", array(#"zone_flooded_crypt", #"zone_cursed_room"), array(#"ra", #"danu", #"odin", #"zeus"), #"hash_107cd70abcec1413", #"hash_3235c0f8ff21201d");
}

// Namespace zm_towers_zstandard/zm_towers_zstandard
// Params 1, eflags: 0x0
// Checksum 0xcd10207, Offset: 0xce0
// Size: 0x24
function function_a946f544(n_round_number) {
    zombie_gladiator_util::function_30d02c01(1);
}

// Namespace zm_towers_zstandard/zm_towers_zstandard
// Params 1, eflags: 0x0
// Checksum 0xef4957a6, Offset: 0xd10
// Size: 0x24
function function_fb02b6de(n_round_number) {
    zombie_gladiator_util::function_33373b4f(1);
}

// Namespace zm_towers_zstandard/zm_towers_zstandard
// Params 1, eflags: 0x0
// Checksum 0x297457e2, Offset: 0xd40
// Size: 0x24
function intro_blight_father(n_round_number) {
    zm_transform::function_5dbbf742("blight_father");
}

// Namespace zm_towers_zstandard/zm_towers_zstandard
// Params 0, eflags: 0x0
// Checksum 0x46e18860, Offset: 0xd70
// Size: 0x41c
function function_6e652611() {
    var_57236533 = struct::get(#"p8_fxanim_zm_towers_pap_door_red_bundle", "scriptbundlename");
    var_6b793c62 = struct::get(#"p8_fxanim_zm_towers_pap_door_blue_bundle", "scriptbundlename");
    while (true) {
        var_db894141 = 0;
        foreach (player in level.players) {
            if (player zm_zonemgr::is_player_in_zone(array(#"zone_danu_ra_tunnel", #"zone_pap_room", #"zone_pap_room_balcony_flooded_crypt")) && player util::is_player_looking_at(var_57236533.origin, 0.9, 0) || player zm_zonemgr::is_player_in_zone(array(#"zone_odin_zeus_tunnel", #"zone_pap_room", #"zone_pap_room_balcony_flooded_crypt")) && player util::is_player_looking_at(var_6b793c62.origin, 0.9, 0)) {
                var_db894141 = 1;
                break;
            }
        }
        if (var_db894141) {
            break;
        }
        waitframe(1);
    }
    level thread scene::play(#"p8_fxanim_zm_towers_pap_door_blue_bundle");
    level thread scene::play(#"p8_fxanim_zm_towers_pap_door_red_bundle");
    a_mdl_pap_room_debris_clip = getentarray("mdl_pap_room_debris_clip", "targetname");
    foreach (mdl_pap_room_debris_clip in a_mdl_pap_room_debris_clip) {
        mdl_pap_room_debris_clip connectpaths();
        mdl_pap_room_debris_clip delete();
    }
    level flag::set(#"connect_pap_room_to_danu_ra_tunnel");
    level flag::set(#"connect_pap_room_to_odin_zeus_tunnel");
    zm_zonemgr::enable_zone(#"zone_flooded_crypt");
    zm_zonemgr::enable_zone(#"zone_pap_room_balcony_flooded_crypt");
    zm_zonemgr::enable_zone(#"zone_body_pit");
    zm_zonemgr::enable_zone(#"zone_odin_tunnel");
    zm_zonemgr::enable_zone(#"zone_zeus_tunnel");
    zm_zonemgr::enable_zone(#"zone_cursed_room");
    function_3642352();
}

// Namespace zm_towers_zstandard/zm_towers_zstandard
// Params 1, eflags: 0x0
// Checksum 0xf9fec7dc, Offset: 0x1198
// Size: 0x13c
function function_3642352(var_e34c1cf3 = 0) {
    a_mdl_heads = getentarray("mdl_pap_quest_head", "targetname");
    foreach (mdl_head in a_mdl_heads) {
        mdl_head show();
        if (var_e34c1cf3) {
            mdl_head playsound(#"hash_3d7066af9c9bf849");
            mdl_head thread zm_towers_pap_quest::function_a6816a11();
        }
    }
    if (var_e34c1cf3) {
        n_time = scene::function_3dd10dad(#"p8_fxanim_zm_towers_pap_sarcophagus_blood_01_bundle", "Shot 1");
        wait n_time;
    }
}

/#

    // Namespace zm_towers_zstandard/zm_towers_zstandard
    // Params 0, eflags: 0x0
    // Checksum 0x46969490, Offset: 0x12e0
    // Size: 0xea
    function function_970b3257() {
        while (true) {
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

// Namespace zm_towers_zstandard/zm_towers_zstandard
// Params 0, eflags: 0x0
// Checksum 0xe42cacf, Offset: 0x13d8
// Size: 0x194
function activate_pap_altar() {
    level thread function_3642352();
    var_1b69ee03 = struct::get(#"p8_fxanim_zm_towers_pap_sarcophagus_bundle", "scriptbundlename");
    while (true) {
        var_260748d1 = 0;
        foreach (player in level.players) {
            if (player zm_zonemgr::is_player_in_zone(array(#"zone_pap_room", #"zone_pap_room_balcony_flooded_crypt")) && player util::is_player_looking_at(var_1b69ee03.origin, 0.9, 0)) {
                var_260748d1 = 1;
                break;
            }
        }
        if (var_260748d1) {
            break;
        }
        waitframe(1);
    }
    level notify(#"hash_7ca261f468171655");
    level zm_utility::function_d7a33664(#"hash_3083207742f405f6");
}

// Namespace zm_towers_zstandard/zm_towers_zstandard
// Params 0, eflags: 0x0
// Checksum 0xc980ee6c, Offset: 0x1578
// Size: 0xee6
function defend_areas() {
    level endon(#"end_game");
    level flag::wait_till("start_zombie_round_logic");
    function_b08cc079();
    level thread function_9842511();
    /#
        if (getdvarint(#"hash_b3363e1d25715d7", 0)) {
            level thread function_970b3257();
            return;
        }
    #/
    level waittill(#"hash_576f1c2e68b31710");
    level.var_be72d53f = 1;
    str_next_defend = array::random(array(#"danu", #"ra"));
    var_c64fa545 = str_next_defend;
    zm_utility::function_a5e87276(4);
    if (str_next_defend == #"danu") {
        level zm_utility::open_door("door_starting_area_to_danu_hallway", undefined, undefined, 1);
    } else {
        level zm_utility::open_door("door_starting_area_to_ra_hallway", undefined, undefined, 1);
    }
    util::delay(4, undefined, &zm_utility::function_8eef3e0e, str_next_defend);
    wait 25;
    zm_zonemgr::function_6fd39598(array(#"zone_danu_ground_floor", #"zone_ra_ground_floor"));
    s_defend_area = zm_utility::function_f7cc2e9e(str_next_defend);
    zm_utility::function_9928fae6(s_defend_area.var_94785111, s_defend_area.a_str_zones, s_defend_area.var_bf9da5f0, undefined, undefined, 30);
    level notify(#"hash_6a0d2b5af489c227");
    var_dd8a17d3 = str_next_defend;
    str_next_defend = array::random(array(#"pit", #"flooded_crypt"));
    var_aeac197f = str_next_defend;
    var_1515a2c = [];
    if (var_dd8a17d3 == #"danu") {
        if (str_next_defend == #"pit") {
            var_1515a2c = array("door_danu_basement_to_danu_ra_tunnel", "door_ra_tunnel_to_body_pit");
        } else {
            var_1515a2c = array("door_danu_basement_to_danu_ra_tunnel", "door_zeus_tunnel_to_flooded_crypt");
        }
    } else if (str_next_defend == #"pit") {
        var_1515a2c = array("door_ra_basement_to_danu_ra_tunnel", "door_ra_tunnel_to_body_pit");
    } else {
        var_1515a2c = array("door_ra_basement_to_danu_ra_tunnel", "door_zeus_tunnel_to_flooded_crypt");
    }
    level zm_utility::open_door(var_1515a2c, undefined, 8, 1);
    util::delay(4, undefined, &zm_utility::function_8eef3e0e, str_next_defend);
    wait 45;
    s_defend_area = zm_utility::function_f7cc2e9e(str_next_defend);
    s_defend_area zm_zonemgr::function_6fd39598(s_defend_area.a_str_zones);
    zm_utility::function_9928fae6(s_defend_area.var_94785111, s_defend_area.a_str_zones, s_defend_area.var_bf9da5f0, undefined, undefined, 45);
    level thread function_6e652611();
    zm_utility::function_8eef3e0e(#"temple");
    level thread activate_pap_altar();
    wait 45;
    zm_zonemgr::zone_wait_till_enabled(#"zone_pap_room");
    zm_round_spawning::function_1a28bc99("gladiator_marauder", &function_a946f544);
    s_defend_area = zm_utility::function_f7cc2e9e(#"temple");
    level thread zm_utility::function_9928fae6(s_defend_area.var_94785111, s_defend_area.a_str_zones, s_defend_area.var_bf9da5f0, undefined, undefined, undefined);
    level flag::wait_till("started_defend_area");
    level util::delay(5, "end_game", &zm_round_spawning::function_c9b9ab96, "gladiator_marauder");
    level waittill(#"hash_7a04a7fb98fa4e4d");
    zm_utility::function_8107842e(#"temple");
    str_next_defend = array::random(array(#"odin", #"zeus"));
    var_b0cb0beb = str_next_defend;
    if (str_next_defend == #"odin") {
        var_1515a2c = array("door_starting_area_to_odin_hallway", "door_odin_basement_to_odin_zeus_tunnel");
    } else {
        var_1515a2c = array("door_starting_area_to_zeus_hallway", "door_zeus_basement_to_odin_zeus_tunnel");
    }
    level zm_utility::open_door(var_1515a2c, undefined, 8, 1);
    util::delay(4, undefined, &zm_utility::function_8eef3e0e, str_next_defend);
    wait 45;
    s_defend_area = zm_utility::function_f7cc2e9e(str_next_defend);
    zm_zonemgr::function_6fd39598(s_defend_area.a_str_zones);
    zm_round_spawning::function_1a28bc99("gladiator_destroyer", &function_fb02b6de);
    level util::delay("started_defend_area", "end_game", &zm_round_spawning::function_c9b9ab96, "gladiator_destroyer");
    zm_utility::function_9928fae6(s_defend_area.var_94785111, s_defend_area.a_str_zones, s_defend_area.var_bf9da5f0, undefined, undefined, undefined);
    zm_utility::function_8107842e(str_next_defend);
    str_next_defend = #"arena";
    zm_utility::function_8eef3e0e(#"arena");
    wait 45;
    s_defend_area = zm_utility::function_f7cc2e9e(#"arena");
    level thread zm_utility::function_9928fae6(s_defend_area.var_94785111, s_defend_area.a_str_zones, s_defend_area.var_bf9da5f0, undefined, undefined, 30);
    level flag::wait_till("started_defend_area");
    level thread zm_towers_special_rounds::function_85c80649();
    level waittill(#"hash_7a04a7fb98fa4e4d");
    level thread zm_towers_special_rounds::function_5c9925c8();
    zm_utility::function_8107842e(#"arena");
    if (var_c64fa545 == #"danu") {
        str_next_defend = #"ra";
        var_1515a2c = array("door_starting_area_to_ra_hallway", "door_danu_ra_bridge", "door_ra_basement_to_danu_ra_tunnel");
    } else {
        str_next_defend = #"danu";
        var_1515a2c = array("door_starting_area_to_danu_hallway", "door_danu_ra_bridge", "door_danu_basement_to_danu_ra_tunnel");
    }
    level zm_utility::open_door(var_1515a2c, undefined, 8, 1);
    util::delay(4, undefined, &zm_utility::function_8eef3e0e, str_next_defend);
    wait 45;
    zm_round_spawning::function_1a28bc99("blight_father", &intro_blight_father);
    level util::delay("started_defend_area", "end_game", &zm_round_spawning::function_c9b9ab96, "blight_father");
    s_defend_area = zm_utility::function_f7cc2e9e(str_next_defend);
    zm_zonemgr::function_6fd39598(s_defend_area.a_str_zones);
    zm_utility::function_9928fae6(s_defend_area.var_94785111, s_defend_area.a_str_zones, s_defend_area.var_bf9da5f0, undefined, undefined, undefined);
    if (var_aeac197f == #"pit") {
        str_next_defend = #"flooded_crypt";
        var_1515a2c = array("door_zeus_tunnel_to_flooded_crypt");
    } else {
        str_next_defend = #"pit";
        var_1515a2c = array("door_ra_tunnel_to_body_pit");
    }
    level zm_utility::open_door(var_1515a2c, undefined, 8, 1);
    util::delay(4, undefined, &zm_utility::function_8eef3e0e, str_next_defend);
    wait 45;
    s_defend_area = zm_utility::function_f7cc2e9e(str_next_defend);
    zm_zonemgr::function_6fd39598(s_defend_area.a_str_zones);
    zm_utility::function_9928fae6(s_defend_area.var_94785111, s_defend_area.a_str_zones, s_defend_area.var_bf9da5f0, undefined, undefined, undefined);
    if (var_b0cb0beb == #"odin") {
        str_next_defend = #"zeus";
        var_1515a2c = array("door_starting_area_to_zeus_hallway", "door_zeus_basement_to_odin_zeus_tunnel", "door_odin_zeus_bridge");
    } else {
        str_next_defend = #"odin";
        var_1515a2c = array("door_starting_area_to_odin_hallway", "door_odin_basement_to_odin_zeus_tunnel", "door_odin_zeus_bridge");
    }
    level zm_utility::open_door(var_1515a2c, undefined, 8, 1);
    util::delay(4, undefined, &zm_utility::function_8eef3e0e, str_next_defend);
    wait 45;
    s_defend_area = zm_utility::function_f7cc2e9e(str_next_defend);
    zm_zonemgr::function_6fd39598(s_defend_area.a_str_zones);
    zm_utility::function_9928fae6(s_defend_area.var_94785111, s_defend_area.a_str_zones, s_defend_area.var_bf9da5f0, undefined, undefined, undefined);
    str_next_defend = zm_utility::function_c3367f31(str_next_defend);
    n_wait_time = 45;
    for (var_23640b2c = 0; true; var_23640b2c++) {
        zm_utility::function_8eef3e0e(str_next_defend);
        wait n_wait_time;
        s_defend_area = zm_utility::function_f7cc2e9e(str_next_defend);
        zm_zonemgr::function_6fd39598(s_defend_area.a_str_zones);
        if (var_23640b2c == 3 || str_next_defend == #"arena") {
            level thread zm_towers_special_rounds::function_85c80649();
        }
        zm_utility::function_9928fae6(s_defend_area.var_94785111, s_defend_area.a_str_zones, s_defend_area.var_bf9da5f0, undefined, undefined, undefined);
        if (var_23640b2c == 3 || str_next_defend == #"arena") {
            level thread zm_towers_special_rounds::function_5c9925c8();
            var_23640b2c = 0;
        }
        str_next_defend = zm_utility::function_c3367f31(str_next_defend);
        n_wait_time -= 2.5;
        if (n_wait_time < 30) {
            n_wait_time = 30;
        }
    }
}

// Namespace zm_towers_zstandard/zm_towers_zstandard
// Params 0, eflags: 0x0
// Checksum 0xae212b8e, Offset: 0x2468
// Size: 0xdc
function function_9842511() {
    level endon(#"end_game");
    while (true) {
        level waittill(#"hash_7a04a7fb98fa4e4d");
        foreach (player in level.players) {
            if (isalive(player)) {
                player zm_towers_crowd::function_88f58c26(#"hash_5986c925a370e137");
            }
        }
    }
}

// Namespace zm_towers_zstandard/zm_towers_zstandard
// Params 0, eflags: 0x0
// Checksum 0xd2aa59bd, Offset: 0x2550
// Size: 0x3c
function function_1f83c16e() {
    if (zm_utility::function_39616495()) {
        zm_utility::function_68cfaf55(#"hash_6db3dde314ca084", 0);
    }
}

// Namespace zm_towers_zstandard/zm_towers_zstandard
// Params 0, eflags: 0x0
// Checksum 0xbb907b04, Offset: 0x2598
// Size: 0x3dc
function function_5f0158fa() {
    zm_utility::function_43a1716a(1, "zombie", 6, 6);
    zm_utility::function_43a1716a(2, "zombie", 6, 8);
    zm_utility::function_43a1716a(3, "zombie", 6, 8);
    zm_utility::function_43a1716a(4, "zombie", 6, 8);
    zm_utility::function_43a1716a(5, "zombie", 6, 8);
    zm_utility::function_43a1716a(6, "zombie", 10, 8);
    zm_utility::function_43a1716a(7, "zombie", 10, 8);
    zm_utility::function_43a1716a(8, "zombie", 10, 8);
    zm_utility::function_43a1716a(9, "zombie", 10, 8);
    zm_utility::function_43a1716a(10, "zombie", 12, 12);
    zm_utility::function_43a1716a(11, "zombie", 14, 12);
    zm_utility::function_43a1716a(12, "zombie", 14, 14);
    zm_utility::function_43a1716a(13, "zombie", 16, 14);
    zm_utility::function_43a1716a(14, "zombie", 20, 16);
    n_zombie_min = 16;
    for (n_round = 15; n_round < 255; n_round++) {
        zm_utility::function_43a1716a(n_round, "zombie", undefined, n_zombie_min);
        n_zombie_min++;
        n_zombie_min = math::clamp(n_zombie_min, 16, 24);
    }
    zm_round_spawning::function_1a28bc99("tiger", &function_758044bc);
    zm_round_spawning::function_1a28bc99("gladiator_destroyer", &function_b58d4c80);
    zm_round_spawning::function_1a28bc99("gladiator_marauder", &function_97a90dba);
    zm_round_spawning::function_1a28bc99("catalyst", &function_f1234c92);
    zm_round_spawning::function_1a28bc99("blight_father", &function_d255c122);
    zm_round_spawning::function_2b3870c9("catalyst", 6);
    zm_round_spawning::function_2b3870c9("tiger", 3);
    level thread function_ed4cb8a4();
}

// Namespace zm_towers_zstandard/zm_towers_zstandard
// Params 0, eflags: 0x0
// Checksum 0xdc7dfaf3, Offset: 0x2980
// Size: 0xb4
function function_ed4cb8a4() {
    level waittill(#"hash_6a0d2b5af489c227");
    var_917a8a87 = level.round_number + 1;
    if (var_917a8a87 == 3 || var_917a8a87 == 6) {
        var_917a8a87++;
    }
    zm_round_spawning::function_5788a6e7("tiger", var_917a8a87, &zm_towers_special_rounds::function_829f0562, &zm_towers_special_rounds::function_617c2489, &zm_towers_special_rounds::function_641b031f, &zombie_tiger_util::function_500a498e);
}

// Namespace zm_towers_zstandard/zm_towers_zstandard
// Params 1, eflags: 0x0
// Checksum 0xcb859597, Offset: 0x2a40
// Size: 0x2c
function function_758044bc(n_round_number) {
    zm_utility::function_5842b86c("tiger", 1);
}

// Namespace zm_towers_zstandard/zm_towers_zstandard
// Params 1, eflags: 0x0
// Checksum 0xbd2b8b49, Offset: 0x2a78
// Size: 0x2c
function function_b58d4c80(n_round_number) {
    zm_utility::function_5842b86c("gladiator_destroyer", 1);
}

// Namespace zm_towers_zstandard/zm_towers_zstandard
// Params 1, eflags: 0x0
// Checksum 0xc375ca82, Offset: 0x2ab0
// Size: 0x2c
function function_97a90dba(n_round_number) {
    zm_utility::function_5842b86c("gladiator_marauder", 1);
}

// Namespace zm_towers_zstandard/zm_towers_zstandard
// Params 1, eflags: 0x0
// Checksum 0x53c08e3, Offset: 0x2ae8
// Size: 0x2c
function function_f1234c92(n_round_number) {
    zm_utility::function_5842b86c("catalyst", 1);
}

// Namespace zm_towers_zstandard/zm_towers_zstandard
// Params 1, eflags: 0x0
// Checksum 0x520a0bfd, Offset: 0x2b20
// Size: 0x2c
function function_d255c122(n_round_number) {
    zm_utility::function_5842b86c("blight_father", 1);
}

// Namespace zm_towers_zstandard/zm_towers_zstandard
// Params 0, eflags: 0x0
// Checksum 0x8ee64f8c, Offset: 0x2b58
// Size: 0x2f8
function function_adbbf2fb() {
    level endon(#"end_game");
    while (true) {
        s_waitresult = level waittill(#"hash_4ffec9c5f552e6fc");
        if (isdefined(s_waitresult.e_door) && isdefined(s_waitresult.e_door.script_flag)) {
            switch (s_waitresult.e_door.script_flag) {
            case #"connect_starting_area_to_danu_hallway":
                var_a8b262b9 = #"hash_756891f8e9b19c50";
                break;
            case #"connect_starting_area_to_ra_hallway":
                var_a8b262b9 = #"hash_2bf18201f54178a3";
                break;
            case #"connect_starting_area_to_odin_hallway":
                var_a8b262b9 = #"hash_51ae58346462e5ea";
                break;
            case #"connect_starting_area_to_zeus_hallway":
                var_a8b262b9 = #"hash_2a82088dd0b6b42f";
                break;
            case #"connect_danu_ra_bridge":
                var_a8b262b9 = #"hash_25d85717f971c376";
                break;
            case #"connect_odin_zeus_bridge":
                var_a8b262b9 = #"hash_634e7ac7c0316c00";
                break;
            case #"connect_danu_basement_to_danu_ra_tunnel":
                var_a8b262b9 = #"hash_77bd07afdb58abd9";
                break;
            case #"connect_ra_basement_to_danu_ra_tunnel":
                var_a8b262b9 = #"hash_45d7dc4e4f0b00f4";
                break;
            case #"connect_odin_basement_to_odin_zeus_tunnel":
                var_a8b262b9 = #"hash_2e9e5b687ffd2e47";
                break;
            case #"connect_zeus_basement_to_odin_zeus_tunnel":
                var_a8b262b9 = #"hash_1354af92e864254c";
                break;
            case #"connect_zeus_tunnel_to_flooded_crypt":
                var_a8b262b9 = #"hash_1a0bc9a2403dc1ee";
                break;
            case #"connect_ra_tunnel_to_body_pit":
                var_a8b262b9 = #"hash_35fd31a4342c9786";
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

