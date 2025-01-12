#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\spawner_shared;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_hud;
#using scripts\zm_common\zm_round_logic;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_zonemgr;

#namespace zm_towers_zones;

// Namespace zm_towers_zones/zm_towers_zones
// Params 0, eflags: 0x0
// Checksum 0x894fc8fd, Offset: 0x6a0
// Size: 0x2a6
function init() {
    callback::on_spawned(&on_player_spawned);
    if (!zm_utility::is_standard()) {
        spawner::add_archetype_spawn_function("zombie", &function_48979a16);
        level thread function_2879e57b();
    }
    var_53b2b1f6 = array("zone_starting_area_tunnel", "zone_starting_area_center", "zone_starting_area_danu", "zone_starting_area_ra", "zone_starting_area_odin", "zone_starting_area_zeus");
    var_75003b1d = array("zone_danu_hallway", "zone_ra_hallway", "zone_odin_hallway", "zone_zeus_hallway");
    var_a4cd1acf = array("zone_danu_ground_floor", "zone_danu_top_floor");
    var_5754e26a = array("zone_ra_ground_floor", "zone_ra_top_floor");
    var_8ea0cfc5 = array("zone_odin_ground_floor", "zone_odin_top_floor");
    var_b9de1ec6 = array("zone_zeus_ground_floor", "zone_zeus_top_floor");
    var_a1966316 = array("zone_danu_ra_bridge", "zone_odin_zeus_bridge");
    var_de31807a = arraycombine(var_53b2b1f6, var_75003b1d, 0, 0);
    var_de31807a = arraycombine(var_de31807a, var_a4cd1acf, 0, 0);
    var_de31807a = arraycombine(var_de31807a, var_5754e26a, 0, 0);
    var_de31807a = arraycombine(var_de31807a, var_8ea0cfc5, 0, 0);
    var_de31807a = arraycombine(var_de31807a, var_b9de1ec6, 0, 0);
    var_de31807a = arraycombine(var_de31807a, var_a1966316, 0, 0);
    level.var_de31807a = var_de31807a;
    level.var_53b2b1f6 = var_53b2b1f6;
}

// Namespace zm_towers_zones/zm_towers_zones
// Params 0, eflags: 0x0
// Checksum 0x455f389b, Offset: 0x950
// Size: 0xc34
function zone_init() {
    level flag::init("always_on");
    level flag::set("always_on");
    zm_zonemgr::zone_init("zone_starting_area_tunnel");
    zm_zonemgr::enable_zone("zone_starting_area_tunnel");
    zm_zonemgr::zone_init("zone_starting_area_ra");
    zm_zonemgr::enable_zone("zone_starting_area_ra");
    zm_zonemgr::zone_init("zone_boss_battle");
    zm_zonemgr::enable_zone("zone_boss_battle");
    zm_zonemgr::zone_init("zone_danu_basement_decayed");
    zm_zonemgr::zone_init("zone_danu_ground_floor_decayed");
    zm_zonemgr::zone_init("zone_danu_top_floor_decayed");
    level.disable_kill_thread = 1;
    zm_zonemgr::add_adjacent_zone("zone_starting_area_tunnel", "zone_starting_area_ra", "always_on", 0);
    zm_zonemgr::add_adjacent_zone("zone_starting_area_tunnel", "zone_starting_area_odin", "always_on", 0);
    zm_zonemgr::add_adjacent_zone("zone_starting_area_center", "zone_starting_area_danu", "always_on", 0);
    zm_zonemgr::add_adjacent_zone("zone_starting_area_center", "zone_starting_area_ra", "always_on", 0);
    zm_zonemgr::add_adjacent_zone("zone_starting_area_center", "zone_starting_area_odin", "always_on", 0);
    zm_zonemgr::add_adjacent_zone("zone_starting_area_center", "zone_starting_area_zeus", "always_on", 0);
    zm_zonemgr::add_adjacent_zone("zone_starting_area_danu", "zone_danu_hallway", "connect_starting_area_to_danu_hallway", 0);
    zm_zonemgr::add_adjacent_zone("zone_danu_hallway", "zone_danu_ground_floor", "connect_starting_area_to_danu_hallway", 0);
    zm_zonemgr::add_adjacent_zone("zone_danu_ground_floor", "zone_starting_area_danu", "connect_starting_area_to_danu_hallway");
    zm_zonemgr::add_adjacent_zone("zone_danu_top_floor", "zone_danu_ground_floor", "connect_danu_tower", 0);
    zm_zonemgr::add_adjacent_zone("zone_danu_basement", "zone_danu_ground_floor", "connect_danu_tower", 0);
    zm_zonemgr::add_adjacent_zone("zone_danu_basement", "zone_danu_ra_tunnel", "connect_danu_basement_to_danu_ra_tunnel", 0);
    zm_zonemgr::add_adjacent_zone("zone_danu_basement_decayed", "zone_danu_ground_floor_decayed", #"hash_55461b9e82131f3", 0);
    zm_zonemgr::add_adjacent_zone("zone_danu_top_floor_decayed", "zone_danu_ground_floor_decayed", #"hash_1596bce02bfee2fe", 0);
    zm_zonemgr::add_adjacent_zone("zone_starting_area_ra", "zone_ra_hallway", "connect_starting_area_to_ra_hallway", 0);
    zm_zonemgr::add_adjacent_zone("zone_ra_hallway", "zone_ra_ground_floor", "connect_starting_area_to_ra_hallway", 0);
    zm_zonemgr::add_adjacent_zone("zone_ra_ground_floor", "zone_starting_area_ra", "connect_starting_area_to_ra_hallway");
    zm_zonemgr::add_adjacent_zone("zone_ra_top_floor", "zone_ra_ground_floor", "connect_ra_tower", 0);
    zm_zonemgr::add_adjacent_zone("zone_ra_basement", "zone_ra_ground_floor", "connect_ra_tower", 0);
    zm_zonemgr::add_adjacent_zone("zone_ra_basement", "zone_danu_ra_tunnel", "connect_ra_basement_to_danu_ra_tunnel", 0);
    zm_zonemgr::add_adjacent_zone("zone_starting_area_odin", "zone_odin_hallway", "connect_starting_area_to_odin_hallway", 0);
    zm_zonemgr::add_adjacent_zone("zone_odin_hallway", "zone_odin_ground_floor", "connect_starting_area_to_odin_hallway", 0);
    zm_zonemgr::add_adjacent_zone("zone_odin_ground_floor", "zone_starting_area_odin", "connect_starting_area_to_odin_hallway");
    zm_zonemgr::add_adjacent_zone("zone_odin_top_floor", "zone_odin_ground_floor", "connect_odin_tower", 0);
    zm_zonemgr::add_adjacent_zone("zone_odin_basement", "zone_odin_ground_floor", "connect_odin_tower", 0);
    zm_zonemgr::add_adjacent_zone("zone_odin_basement", "zone_odin_zeus_tunnel", "connect_odin_basement_to_odin_zeus_tunnel", 0);
    zm_zonemgr::add_adjacent_zone("zone_starting_area_zeus", "zone_zeus_hallway", "connect_starting_area_to_zeus_hallway", 0);
    zm_zonemgr::add_adjacent_zone("zone_zeus_hallway", "zone_zeus_ground_floor", "connect_starting_area_to_zeus_hallway", 0);
    zm_zonemgr::add_adjacent_zone("zone_zeus_ground_floor", "zone_starting_area_zeus", "connect_starting_area_to_zeus_hallway");
    zm_zonemgr::add_adjacent_zone("zone_zeus_top_floor", "zone_zeus_ground_floor", "connect_zeus_tower", 0);
    zm_zonemgr::add_adjacent_zone("zone_zeus_basement", "zone_zeus_ground_floor", "connect_zeus_tower", 0);
    zm_zonemgr::add_adjacent_zone("zone_zeus_basement", "zone_odin_zeus_tunnel", "connect_zeus_basement_to_odin_zeus_tunnel", 0);
    zm_zonemgr::add_adjacent_zone("zone_danu_top_floor", "zone_ra_top_floor", "connect_danu_ra_bridge", 0);
    zm_zonemgr::add_adjacent_zone("zone_danu_top_floor", "zone_danu_ra_bridge", "connect_danu_ra_bridge", 0);
    zm_zonemgr::add_adjacent_zone("zone_ra_top_floor", "zone_danu_ra_bridge", "connect_danu_ra_bridge", 0);
    zm_zonemgr::add_adjacent_zone("zone_odin_top_floor", "zone_zeus_top_floor", "connect_odin_zeus_bridge", 0);
    zm_zonemgr::add_adjacent_zone("zone_odin_top_floor", "zone_odin_zeus_bridge", "connect_odin_zeus_bridge", 0);
    zm_zonemgr::add_adjacent_zone("zone_zeus_top_floor", "zone_odin_zeus_bridge", "connect_odin_zeus_bridge", 0);
    zm_zonemgr::add_adjacent_zone("zone_danu_tunnel", "zone_danu_ra_tunnel", "connect_danu_ra_tunnels", 0);
    zm_zonemgr::add_adjacent_zone("zone_danu_ra_tunnel", "zone_ra_tunnel", "connect_danu_ra_tunnels", 0);
    zm_zonemgr::add_adjacent_zone("zone_danu_ra_tunnel", "zone_fallen_hero", "connect_danu_ra_tunnels", 0);
    zm_zonemgr::add_adjacent_zone("zone_ra_tunnel", "zone_fallen_hero", "connect_danu_ra_tunnels", 0);
    zm_zonemgr::add_adjacent_zone("zone_danu_ra_tunnel", "zone_flooded_crypt", "connect_zeus_tunnel_to_flooded_crypt", 0);
    zm_zonemgr::add_adjacent_zone("zone_odin_tunnel", "zone_odin_zeus_tunnel", "connect_odin_zeus_tunnels", 0);
    zm_zonemgr::add_adjacent_zone("zone_odin_tunnel", "zone_odin_basement", "connect_odin_basement_to_odin_zeus_tunnel");
    zm_zonemgr::add_adjacent_zone("zone_odin_tunnel", "zone_zeus_tunnel", "connect_odin_zeus_tunnels");
    zm_zonemgr::add_adjacent_zone("zone_odin_tunnel", "zone_cursed_room", "connect_odin_zeus_tunnels");
    zm_zonemgr::add_adjacent_zone("zone_zeus_tunnel", "zone_cursed_room", "connect_odin_zeus_tunnels");
    zm_zonemgr::add_adjacent_zone("zone_odin_zeus_tunnel", "zone_zeus_tunnel", "connect_odin_zeus_tunnels", 0);
    zm_zonemgr::add_adjacent_zone("zone_odin_zeus_tunnel", "zone_cursed_room", "connect_odin_zeus_tunnels", 0);
    zm_zonemgr::add_adjacent_zone("zone_odin_zeus_tunnel", "zone_body_pit", "connect_ra_tunnel_to_body_pit", 0);
    zm_zonemgr::add_adjacent_zone("zone_body_pit", "zone_ra_tunnel", "connect_ra_tunnel_to_body_pit", 0);
    zm_zonemgr::add_adjacent_zone("zone_body_pit", "zone_fallen_hero", "connect_ra_tunnel_to_body_pit", 0);
    zm_zonemgr::add_adjacent_zone("zone_body_pit", "zone_odin_tunnel", "connect_ra_tunnel_to_body_pit", 0);
    zm_zonemgr::add_adjacent_zone("zone_flooded_crypt", "zone_danu_tunnel", "connect_zeus_tunnel_to_flooded_crypt", 0);
    zm_zonemgr::add_adjacent_zone("zone_flooded_crypt", "zone_cursed_room", "connect_zeus_tunnel_to_flooded_crypt", 0);
    zm_zonemgr::add_adjacent_zone("zone_flooded_crypt", "zone_zeus_tunnel", "connect_zeus_tunnel_to_flooded_crypt", 0);
    zm_zonemgr::add_adjacent_zone("zone_pap_room", "zone_danu_ra_tunnel", "connect_pap_room_to_danu_ra_tunnel", 0);
    zm_zonemgr::add_adjacent_zone("zone_pap_room", "zone_odin_zeus_tunnel", "connect_pap_room_to_odin_zeus_tunnel", 0);
    zm_zonemgr::add_adjacent_zone("zone_pap_room", "zone_ra_tunnel", "connect_pap_room_to_danu_ra_tunnel");
    zm_zonemgr::add_adjacent_zone("zone_pap_room", "zone_fallen_hero", "connect_pap_room_to_danu_ra_tunnel");
    zm_zonemgr::add_adjacent_zone("zone_pap_room", "zone_zeus_tunnel", "connect_pap_room_to_odin_zeus_tunnel");
    zm_zonemgr::add_adjacent_zone("zone_pap_room_balcony_flooded_crypt", "zone_flooded_crypt", "connect_pap_room_balconies", 0);
    zm_zonemgr::add_adjacent_zone("zone_pap_room_balcony_flooded_crypt", "zone_pap_room", "connect_pap_room_balconies", 0);
    zm_zonemgr::add_adjacent_zone("zone_pap_room", "zone_body_pit", "connect_pap_room_balconies", 0);
    zm_zonemgr::add_adjacent_zone("zone_pap_room", "zone_flooded_crypt", "connect_pap_room_balconies");
    level thread connect_danu_tower();
    level thread connect_ra_tower();
    level thread connect_odin_tower();
    level thread connect_zeus_tower();
    level thread connect_odin_zeus_tunnels();
    level thread connect_danu_ra_tunnels();
    level thread function_6fcaf81();
}

// Namespace zm_towers_zones/zm_towers_zones
// Params 0, eflags: 0x0
// Checksum 0x13bca65f, Offset: 0x1590
// Size: 0x74
function connect_danu_tower() {
    level endon(#"end_game");
    level flag::wait_till_any(array("connect_starting_area_to_danu_hallway", "connect_danu_ra_bridge", "connect_danu_basement_to_danu_ra_tunnel"));
    level flag::set("connect_danu_tower");
}

// Namespace zm_towers_zones/zm_towers_zones
// Params 0, eflags: 0x0
// Checksum 0x3ffec91f, Offset: 0x1610
// Size: 0x74
function connect_ra_tower() {
    level endon(#"end_game");
    level flag::wait_till_any(array("connect_starting_area_to_ra_hallway", "connect_danu_ra_bridge", "connect_ra_basement_to_danu_ra_tunnel"));
    level flag::set("connect_ra_tower");
}

// Namespace zm_towers_zones/zm_towers_zones
// Params 0, eflags: 0x0
// Checksum 0x873066aa, Offset: 0x1690
// Size: 0x74
function connect_odin_tower() {
    level endon(#"end_game");
    level flag::wait_till_any(array("connect_starting_area_to_odin_hallway", "connect_odin_zeus_bridge", "connect_odin_basement_to_odin_zeus_tunnel"));
    level flag::set("connect_odin_tower");
}

// Namespace zm_towers_zones/zm_towers_zones
// Params 0, eflags: 0x0
// Checksum 0x3df9e22b, Offset: 0x1710
// Size: 0x74
function connect_zeus_tower() {
    level endon(#"end_game");
    level flag::wait_till_any(array("connect_starting_area_to_zeus_hallway", "connect_odin_zeus_bridge", "connect_zeus_basement_to_odin_zeus_tunnel"));
    level flag::set("connect_zeus_tower");
}

// Namespace zm_towers_zones/zm_towers_zones
// Params 0, eflags: 0x0
// Checksum 0x3b6d5b9b, Offset: 0x1790
// Size: 0x6c
function connect_odin_zeus_tunnels() {
    level endon(#"end_game");
    level flag::wait_till_any(array("connect_odin_basement_to_odin_zeus_tunnel", "connect_zeus_basement_to_odin_zeus_tunnel"));
    level flag::set("connect_odin_zeus_tunnels");
}

// Namespace zm_towers_zones/zm_towers_zones
// Params 0, eflags: 0x0
// Checksum 0xa8f75c76, Offset: 0x1808
// Size: 0x6c
function connect_danu_ra_tunnels() {
    level endon(#"end_game");
    level flag::wait_till_any(array("connect_danu_basement_to_danu_ra_tunnel", "connect_ra_basement_to_danu_ra_tunnel"));
    level flag::set("connect_danu_ra_tunnels");
}

// Namespace zm_towers_zones/zm_towers_zones
// Params 0, eflags: 0x0
// Checksum 0xa1f0464b, Offset: 0x1880
// Size: 0xac
function function_6fcaf81() {
    level endon(#"end_game");
    level flag::wait_till_any(array("connect_zeus_tunnel_to_flooded_crypt", "connect_ra_tunnel_to_body_pit"));
    level flag::set("connect_danu_ra_tunnels");
    level flag::set("connect_odin_zeus_tunnels");
    level flag::set("connect_pap_room_balconies");
}

// Namespace zm_towers_zones/zm_towers_zones
// Params 0, eflags: 0x0
// Checksum 0xa72a930b, Offset: 0x1938
// Size: 0xb4
function function_48979a16() {
    self endon(#"death");
    waitframe(1);
    if (!isdefined(level.var_61172f53)) {
        level.var_61172f53 = zm_round_logic::get_zombie_count_for_round(level.round_number, level.players.size);
    }
    if (level.var_ab2cfb2f < level.var_61172f53 / 2) {
        self zombie_utility::set_zombie_run_cycle("run");
        level.var_ab2cfb2f++;
        self thread function_e2c50181();
    }
}

// Namespace zm_towers_zones/zm_towers_zones
// Params 0, eflags: 0x0
// Checksum 0x8b6b3afb, Offset: 0x19f8
// Size: 0x7c
function function_2879e57b() {
    level endon(#"end_game");
    level flag::wait_till("begin_spawning");
    while (level.round_number < 15) {
        wait 1;
    }
    spawner::remove_global_spawn_function("zombie", &function_48979a16);
}

// Namespace zm_towers_zones/zm_towers_zones
// Params 0, eflags: 0x0
// Checksum 0xd63c0542, Offset: 0x1a80
// Size: 0x6c
function function_e2c50181() {
    s_notify = self waittill(#"death");
    e_attacker = s_notify.attacker;
    if (isplayer(e_attacker)) {
        return;
    }
    if (level.var_ab2cfb2f > 0) {
        level.var_ab2cfb2f--;
    }
}

// Namespace zm_towers_zones/zm_towers_zones
// Params 0, eflags: 0x0
// Checksum 0x7b30f398, Offset: 0x1af8
// Size: 0x11c
function on_player_spawned() {
    self endon(#"death");
    self thread function_da2970c7();
    self thread zm_audio::function_83711320(#"hash_7a784e915fb4da82", #"body_pit");
    self thread zm_audio::function_83711320(#"hash_2a27c4b2d37ac547", #"odin_floor");
    self thread zm_audio::function_83711320(#"hash_f06f1d12b9e06bb", #"ra_base");
    self thread zm_audio::function_83711320(#"hash_54ab01103f8534bd", #"temple");
    self thread zm_audio::function_83711320(#"hash_3bf0a3cc4bf210d3", #"zeus_base");
}

// Namespace zm_towers_zones/zm_towers_zones
// Params 0, eflags: 0x0
// Checksum 0x8a679d32, Offset: 0x1c20
// Size: 0x1c
function function_cdf71e06() {
    self thread function_da2970c7();
}

// Namespace zm_towers_zones/zm_towers_zones
// Params 0, eflags: 0x0
// Checksum 0xacf8ab16, Offset: 0x1c48
// Size: 0xb8
function function_da2970c7() {
    self endon(#"disconnect");
    while (true) {
        if (isalive(self)) {
            str_location = function_50f2bc89(self);
            self zm_hud::function_3a4fb187(isdefined(str_location) ? str_location : #"");
        } else {
            self zm_hud::function_3a4fb187(#"");
        }
        wait 0.5;
    }
}

// Namespace zm_towers_zones/zm_towers_zones
// Params 1, eflags: 0x0
// Checksum 0x5408a555, Offset: 0x1d08
// Size: 0x57e
function function_50f2bc89(e_player) {
    str_zone = e_player zm_zonemgr::get_player_zone();
    if (!isdefined(str_zone)) {
        return undefined;
    }
    switch (str_zone) {
    case #"zone_starting_area_center":
        str_display = #"hash_4a67009994e6a476";
        break;
    case #"zone_starting_area_tunnel":
    case #"zone_starting_area_odin":
    case #"zone_starting_area_ra":
    case #"zone_starting_area_danu":
    case #"zone_starting_area_zeus":
        str_display = #"hash_1567549ec3ba97d4";
        break;
    case #"zone_danu_top_floor":
        str_display = #"hash_5c1dcbfe0b5001dd";
        break;
    case #"zone_danu_ground_floor":
    case #"zone_danu_hallway":
        str_display = #"hash_7a9264bacc159479";
        break;
    case #"zone_danu_basement":
        str_display = #"hash_397ee221838b64ee";
        break;
    case #"zone_ra_top_floor":
        str_display = #"hash_6803828af6a2f994";
        break;
    case #"zone_ra_hallway":
    case #"zone_ra_ground_floor":
        str_display = #"hash_42941b7294416898";
        break;
    case #"zone_ra_basement":
        str_display = #"hash_f06f1d12b9e06bb";
        break;
    case #"zone_odin_top_floor":
        str_display = #"hash_2a27c4b2d37ac547";
        break;
    case #"zone_odin_ground_floor":
    case #"zone_odin_hallway":
        str_display = #"hash_6edbbd092bc3117f";
        break;
    case #"zone_odin_basement":
        str_display = #"hash_6182c3f17fbe7e38";
        break;
    case #"zone_zeus_top_floor":
        str_display = #"hash_9a1707dc944a3bc";
        break;
    case #"zone_zeus_hallway":
    case #"zone_zeus_ground_floor":
        str_display = #"hash_2795247ad0a93910";
        break;
    case #"zone_zeus_basement":
        if (level flag::get(#"hash_26c0c05d0a3e382f")) {
            str_display = #"hash_1d78b48769eec427";
        } else {
            str_display = #"hash_3bf0a3cc4bf210d3";
        }
        break;
    case #"zone_danu_ra_bridge":
        str_display = #"hash_340eafe8d0baeac2";
        break;
    case #"zone_odin_zeus_bridge":
        str_display = #"hash_3eb632726bcfd3b8";
        break;
    case #"zone_danu_ra_tunnel":
        str_display = #"hash_75825b791d3a7f4d";
        break;
    case #"zone_danu_tunnel":
        str_display = #"hash_384dc630decdd5e5";
        break;
    case #"zone_ra_tunnel":
        str_display = #"hash_1ad73836208cbff4";
        break;
    case #"zone_fallen_hero":
        str_display = #"hash_26bd00647976ee13";
        break;
    case #"zone_odin_tunnel":
        str_display = #"hash_2e1e7d63d11c4a1b";
        break;
    case #"zone_odin_zeus_tunnel":
        str_display = #"hash_553f97cb9500b3bf";
        break;
    case #"zone_zeus_tunnel":
        str_display = #"hash_622a5e1614b58b7c";
        break;
    case #"zone_cursed_room":
        str_display = #"hash_68fd9aced4fcdecc";
        break;
    case #"zone_flooded_crypt":
        str_display = #"hash_140d9887b328fc9a";
        break;
    case #"zone_body_pit":
        str_display = #"hash_7a784e915fb4da82";
        break;
    case #"zone_pap_room":
    case #"hash_3c2efff9d599c329":
    case #"zone_pap_room_balcony_flooded_crypt":
        str_display = #"hash_54ab01103f8534bd";
        break;
    default:
        str_display = undefined;
        break;
    }
    return str_display;
}

