#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\teleport_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_zonemgr;

#namespace zm_towers_player_spawns;

// Namespace zm_towers_player_spawns/zm_towers_player_spawns
// Params 0, eflags: 0x0
// Checksum 0xf2494de9, Offset: 0x318
// Size: 0x8c
function init() {
    level thread function_209bfb79();
    level thread function_9523a27f();
    level thread function_3183fdef();
    callback::on_connect(&function_1d6edc87);
    callback::on_spawned(&function_9c20187b);
}

// Namespace zm_towers_player_spawns/zm_towers_player_spawns
// Params 0, eflags: 0x0
// Checksum 0xd57f1df2, Offset: 0x3b0
// Size: 0x4c
function function_209bfb79() {
    level endon(#"end_game");
    level flag::wait_till("begin_spawning");
    teleport::team("teleport_starting_tunnel");
}

// Namespace zm_towers_player_spawns/zm_towers_player_spawns
// Params 0, eflags: 0x0
// Checksum 0x419745b1, Offset: 0x408
// Size: 0x524
function function_9523a27f() {
    level endon(#"end_game");
    mdl_clip = getent("arena_gate_east_clip", "targetname");
    mdl_gate = getent("arena_gate_east", "targetname");
    mdl_clip linkto(mdl_gate);
    level flag::wait_till("begin_spawning");
    wait 2.5;
    mdl_gate movez(100, 3);
    mdl_gate playsound(#"hash_2dfa3192317aab20");
    mdl_gate clientfield::set("entry_gate_dust", 1);
    wait 3;
    var_7225649d = 0;
    vol_spawn_area = getent("vol_spawn_area", "targetname");
    while (!var_7225649d) {
        a_e_touching = [];
        foreach (e_player in util::get_active_players()) {
            if (e_player istouching(vol_spawn_area)) {
                if (!isdefined(a_e_touching)) {
                    a_e_touching = [];
                } else if (!isarray(a_e_touching)) {
                    a_e_touching = array(a_e_touching);
                }
                a_e_touching[a_e_touching.size] = e_player;
                continue;
            }
            if (e_player clientfield::get_to_player("snd_crowd_react") != 8) {
                e_player clientfield::set_to_player("snd_crowd_react", 8);
                if (level clientfield::get("crowd_react") != 3) {
                    level clientfield::set("crowd_react", 3);
                }
            }
        }
        if (a_e_touching.size == 0) {
            a_ai_zombies = getactorarray();
            foreach (ai_zombie in a_ai_zombies) {
                if (ai_zombie istouching(vol_spawn_area)) {
                    if (!isdefined(a_e_touching)) {
                        a_e_touching = [];
                    } else if (!isarray(a_e_touching)) {
                        a_e_touching = array(a_e_touching);
                    }
                    a_e_touching[a_e_touching.size] = ai_zombie;
                }
            }
            if (a_e_touching.size == 0) {
                var_7225649d = 1;
                break;
            }
        }
        waitframe(1);
    }
    level notify(#"hash_576f1c2e68b31710");
    mdl_gate movez(100 * -1, 0.5);
    mdl_gate playsound(#"hash_7f2e66132114e68c");
    wait 0.5;
    zm_zonemgr::function_f0b4b2ce("zone_starting_area_tunnel");
    exploder::exploder("exp_gate_slam");
    exploder::exploder("exp_lgt_player_start");
    level util::clientnotify("crowd_ducker_lvlstart");
    wait 10;
    if (level clientfield::get("crowd_react") == 3) {
        level clientfield::set("crowd_react", 0);
    }
}

// Namespace zm_towers_player_spawns/zm_towers_player_spawns
// Params 0, eflags: 0x0
// Checksum 0x7767f507, Offset: 0x938
// Size: 0xbc
function function_3183fdef() {
    level endon(#"end_game");
    scene::init("p8_fxanim_zm_towers_center_platform_rails_bundle");
    level flag::wait_till("begin_spawning");
    t_trigger = getent("t_raise_center_platform_rails", "targetname");
    t_trigger waittilltimeout(6, #"trigger");
    scene::play("p8_fxanim_zm_towers_center_platform_rails_bundle");
}

// Namespace zm_towers_player_spawns/zm_towers_player_spawns
// Params 0, eflags: 0x0
// Checksum 0x5d85f1b8, Offset: 0xa00
// Size: 0x7c
function function_9c20187b() {
    level endon(#"end_game");
    self endon(#"death");
    self thread function_dab4d5a7(array("zone_danu_ground_floor", "zone_danu_top_floor", "zone_danu_basement"), "location_enter", "danu");
}

// Namespace zm_towers_player_spawns/zm_towers_player_spawns
// Params 4, eflags: 0x0
// Checksum 0xf7acf006, Offset: 0xa88
// Size: 0x256
function function_dab4d5a7(a_str_zones, str_category, var_41750e29, var_91e89018) {
    level endon(#"end_game");
    self endon(#"death");
    str_flag = #"hash_7e6136dc67c1a920" + str_category + "_" + var_41750e29 + "_said";
    if (!self flag::exists(str_flag)) {
        self flag::init(str_flag);
    }
    if (self flag::get(str_flag)) {
        return;
    }
    if (!isdefined(a_str_zones)) {
        a_str_zones = [];
    } else if (!isarray(a_str_zones)) {
        a_str_zones = array(a_str_zones);
    }
    while (true) {
        if (zm_utility::is_player_valid(self, 0, 0)) {
            b_play_vo = 0;
            foreach (str_zone in a_str_zones) {
                if (self zm_zonemgr::get_player_zone() === str_zone) {
                    b_play_vo = 1;
                    break;
                }
            }
            if (b_play_vo && isdefined(var_91e89018)) {
                var_fe485afe = struct::get(var_91e89018);
                b_play_vo = zm_utility::is_player_looking_at(var_fe485afe.origin, undefined, 0);
            }
            if (b_play_vo) {
                self flag::set(str_flag);
                self thread zm_audio::create_and_play_dialog(str_category, var_41750e29);
            }
        }
        wait 1;
    }
}

// Namespace zm_towers_player_spawns/zm_towers_player_spawns
// Params 0, eflags: 0x0
// Checksum 0x12e7b8e0, Offset: 0xce8
// Size: 0x25e
function function_1d6edc87() {
    level endon(#"end_game");
    self endon(#"disconnect");
    str_flag = #"hash_54172324bad1b2ad";
    if (!self flag::exists(str_flag)) {
        self flag::init(str_flag);
    }
    if (self flag::get(str_flag)) {
        return;
    }
    var_275fc39a = array("zone_starting_area_tunnel", "zone_starting_area_center", "zone_starting_area_danu", "zone_starting_area_ra", "zone_starting_area_odin", "zone_starting_area_zeus", "zone_danu_hallway", "zone_ra_hallway", "zone_odin_hallway", "zone_zeus_hallway");
    while (true) {
        str_zone = self zm_zonemgr::get_player_zone();
        if (!isinarray(var_275fc39a, str_zone)) {
            wait 30;
            str_zone = self zm_zonemgr::get_player_zone();
            if (!isinarray(var_275fc39a, str_zone)) {
                break;
            }
        }
        wait 1;
    }
    var_53b2b1f6 = array("zone_starting_area_center", "zone_starting_area_danu", "zone_starting_area_ra", "zone_starting_area_odin", "zone_starting_area_zeus");
    while (true) {
        str_zone = self zm_zonemgr::get_player_zone();
        if (zm_utility::is_player_valid(self, 0, 0) && isinarray(var_53b2b1f6, str_zone)) {
            self flag::set(str_flag);
            self thread zm_audio::create_and_play_dialog("location_enter", "arena");
        }
        wait 1;
    }
}

