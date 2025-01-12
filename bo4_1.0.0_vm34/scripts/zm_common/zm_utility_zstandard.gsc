#using script_2595527427ea71eb;
#using script_742a29771db74d6f;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\zm_common\bgbs\zm_bgb_anywhere_but_here;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_trial_util;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_zonemgr;

#namespace zm_utility;

// Namespace zm_utility/zm_utility_zstandard
// Params 4, eflags: 0x0
// Checksum 0x31e9206e, Offset: 0x350
// Size: 0x386
function open_door(a_str_door_names, var_db63ae33 = 0, n_delay, var_6d13ae5e = 0) {
    if (!isdefined(a_str_door_names)) {
        a_str_door_names = [];
    } else if (!isarray(a_str_door_names)) {
        a_str_door_names = array(a_str_door_names);
    }
    if (var_db63ae33) {
        if (!function_73cac535()) {
            level waittill(#"player_grabbed_key");
        }
    }
    if (isdefined(n_delay)) {
        wait n_delay;
    }
    if (var_6d13ae5e) {
        util::playsoundonplayers(#"hash_5eca7fc11b300dd1");
    }
    var_ceffbce7 = 0;
    foreach (str_door_name in a_str_door_names) {
        a_e_zombie_doors = getentarray(str_door_name, "target");
        foreach (zombie_door in a_e_zombie_doors) {
            if (isdefined(zombie_door.b_opened) && zombie_door.b_opened) {
                continue;
            }
            zombie_door notify(#"trigger", {#activator:zombie_door, #is_forced:1});
            zombie_door.script_flag_wait = undefined;
            zombie_door notify(#"power_on");
            zombie_door.b_opened = 1;
            playsoundatposition(#"hash_27dc220231c7b8b3", zombie_door.origin);
            if (!isdefined(level.var_cadc1211) && !var_ceffbce7) {
                if (zombie_door.targetname === "zombie_debris") {
                    level thread function_d7a33664(#"hash_782714d88bdaa1b6");
                } else {
                    level thread function_d7a33664(#"hash_7203281c0385cddd");
                }
                var_ceffbce7 = 1;
            }
        }
        if (var_db63ae33) {
            level notify(#"hash_4ffec9c5f552e6fc", {#e_door:zombie_door});
            if (function_73cac535()) {
                function_df70544d();
            }
            waitframe(1);
        }
    }
}

// Namespace zm_utility/zm_utility_zstandard
// Params 2, eflags: 0x0
// Checksum 0xa35282d0, Offset: 0x6e0
// Size: 0x11e
function function_4737fa66(n_round_number, var_a5cc5962 = 1) {
    if (!isdefined(level.var_4737fa66)) {
        level.var_4737fa66 = [];
    }
    if (isdefined(level.var_4737fa66[n_round_number]) && !(isdefined(level.var_4737fa66[n_round_number].var_dc0e1ce7) && level.var_4737fa66[n_round_number].var_dc0e1ce7) && isdefined(level.var_4737fa66[n_round_number].var_a5cc5962)) {
        level.var_4737fa66[n_round_number].var_a5cc5962 = level.var_4737fa66[n_round_number].var_a5cc5962 + var_a5cc5962;
        return;
    }
    level.var_4737fa66[n_round_number] = {#var_dc0e1ce7:0, #var_a5cc5962:var_a5cc5962};
}

// Namespace zm_utility/zm_utility_zstandard
// Params 1, eflags: 0x0
// Checksum 0x30a74a53, Offset: 0x808
// Size: 0x9c
function function_c4ce3541(n_round_number) {
    if (!isdefined(level.var_4737fa66)) {
        level.var_4737fa66 = [];
    }
    if (isdefined(level.var_4737fa66[n_round_number]) && !(isdefined(level.var_4737fa66[n_round_number].var_dc0e1ce7) && level.var_4737fa66[n_round_number].var_dc0e1ce7)) {
        arrayremoveindex(level.var_4737fa66, n_round_number, 1);
    }
}

// Namespace zm_utility/zm_utility_zstandard
// Params 1, eflags: 0x0
// Checksum 0xe57da786, Offset: 0x8b0
// Size: 0x2a
function function_d7fbfa94(n_round_number) {
    if (isdefined(level.var_4737fa66[n_round_number])) {
        return true;
    }
    return false;
}

// Namespace zm_utility/zm_utility_zstandard
// Params 0, eflags: 0x0
// Checksum 0xa6ac27fc, Offset: 0x8e8
// Size: 0x58
function function_39616495() {
    if (getdvarint(#"hash_4d13a1555fce5382", 1) || level flag::exists("doorbuy_key_active")) {
        return true;
    }
    return false;
}

// Namespace zm_utility/zm_utility_zstandard
// Params 1, eflags: 0x0
// Checksum 0x1d09946c, Offset: 0x948
// Size: 0xaa
function function_73cac535(e_door) {
    if (level flag::exists("doorbuy_key_active") && level flag::get("doorbuy_key_active")) {
        if (function_faf8c4ca() && isdefined(e_door)) {
            if (e_door.script_flag === function_8554c9ff()) {
                return true;
            } else {
                return false;
            }
        } else {
            return true;
        }
    }
    return false;
}

// Namespace zm_utility/zm_utility_zstandard
// Params 1, eflags: 0x0
// Checksum 0x22d89bf7, Offset: 0xa00
// Size: 0x15a
function function_67e607c9(var_eb6fe2f2) {
    if (!isdefined(level.var_75ece702)) {
        level.var_75ece702 = spawnstruct();
    }
    if (!isdefined(level.var_75ece702.var_a6f89cc3)) {
        level.var_75ece702.var_a6f89cc3 = 0;
    }
    if (!isdefined(level.var_75ece702.var_9b1227a5)) {
        level.var_75ece702.var_9b1227a5 = [];
    }
    if (!isdefined(level.var_75ece702.var_9b1227a5)) {
        level.var_75ece702.var_9b1227a5 = [];
    } else if (!isarray(level.var_75ece702.var_9b1227a5)) {
        level.var_75ece702.var_9b1227a5 = array(level.var_75ece702.var_9b1227a5);
    }
    if (!isinarray(level.var_75ece702.var_9b1227a5, var_eb6fe2f2)) {
        level.var_75ece702.var_9b1227a5[level.var_75ece702.var_9b1227a5.size] = var_eb6fe2f2;
    }
}

// Namespace zm_utility/zm_utility_zstandard
// Params 0, eflags: 0x0
// Checksum 0xa5a5f831, Offset: 0xb68
// Size: 0x1c
function function_faf8c4ca() {
    if (isdefined(level.var_75ece702)) {
        return true;
    }
    return false;
}

// Namespace zm_utility/zm_utility_zstandard
// Params 0, eflags: 0x0
// Checksum 0xdff542d7, Offset: 0xb90
// Size: 0x18
function function_73aeea82() {
    level.var_75ece702.var_a6f89cc3++;
}

// Namespace zm_utility/zm_utility_zstandard
// Params 0, eflags: 0x0
// Checksum 0x11c9051c, Offset: 0xbb0
// Size: 0x5c
function function_8554c9ff() {
    if (!isdefined(level.var_75ece702)) {
        return undefined;
    }
    n_index = level.var_75ece702.var_a6f89cc3;
    var_eb6fe2f2 = level.var_75ece702.var_9b1227a5[n_index];
    return var_eb6fe2f2;
}

// Namespace zm_utility/zm_utility_zstandard
// Params 1, eflags: 0x0
// Checksum 0xc0b3e12, Offset: 0xc18
// Size: 0x2a
function function_7563e693(var_a5cc5962) {
    level.var_89e35bb9 = var_a5cc5962;
    level.var_9c0f8ddf = var_a5cc5962;
}

// Namespace zm_utility/zm_utility_zstandard
// Params 0, eflags: 0x0
// Checksum 0xa8a0c765, Offset: 0xc50
// Size: 0x44
function function_587070e3() {
    if (isdefined(level.var_9c0f8ddf) && level.var_9c0f8ddf > 0) {
        return true;
    }
    if (!isdefined(level.var_9c0f8ddf)) {
        return true;
    }
    return false;
}

// Namespace zm_utility/zm_utility_zstandard
// Params 0, eflags: 0x0
// Checksum 0x31fa1461, Offset: 0xca0
// Size: 0x72
function function_81efd58f() {
    level flag::increment("doorbuy_key_active");
    var_d2b64920 = gettime() - level.var_e53747c;
    if (var_d2b64920 < int(5 * 1000)) {
    }
    level.var_e53747c = gettime();
}

// Namespace zm_utility/zm_utility_zstandard
// Params 0, eflags: 0x0
// Checksum 0xc485e761, Offset: 0xd20
// Size: 0xf4
function function_df70544d() {
    level flag::decrement("doorbuy_key_active");
    if (level flag::get("doorbuy_key_active") && function_faf8c4ca()) {
        level util::delay(1, "end_game", &function_882ebf68, 1);
    } else if (!level flag::get("doorbuy_key_active")) {
        level thread function_882ebf68(0);
    }
    if (function_faf8c4ca()) {
        function_73aeea82();
    }
}

// Namespace zm_utility/zm_utility_zstandard
// Params 0, eflags: 0x0
// Checksum 0xa17e43ff, Offset: 0xe20
// Size: 0x42
function function_b15605eb() {
    return isdefined(level.flag_count[#"doorbuy_key_active"]) ? level.flag_count[#"doorbuy_key_active"] : 0;
}

// Namespace zm_utility/zm_utility_zstandard
// Params 3, eflags: 0x0
// Checksum 0xd7bea5c2, Offset: 0xe70
// Size: 0x64
function function_68cfaf55(var_43e94696, var_a2faa4a6 = 0, var_1400f3a0 = &function_6c831dc6) {
    level thread function_488589c2(var_43e94696, var_a2faa4a6, var_1400f3a0);
}

// Namespace zm_utility/zm_utility_zstandard
// Params 3, eflags: 0x0
// Checksum 0xe89f84b4, Offset: 0xee0
// Size: 0x14c
function function_488589c2(var_43e94696, var_a2faa4a6, var_1400f3a0) {
    level flag::init("doorbuy_key_active");
    level.var_4940fe86 = int(var_a2faa4a6 * 100);
    callback::on_ai_killed(&function_1a11b178);
    zm_powerups::register_powerup("zmarcade_key", var_1400f3a0);
    zm_powerups::add_zombie_powerup("zmarcade_key", var_43e94696, #"hash_776da083d1ecf583", &zm_powerups::func_should_never_drop, 0, 0, 0);
    zm_powerups::powerup_set_statless_powerup("zmarcade_key");
    /#
        adddebugcommand("<dev string:x30>");
    #/
    /#
        adddebugcommand("<dev string:x81>");
    #/
    wait 0.5;
    function_882ebf68(0);
}

// Namespace zm_utility/zm_utility_zstandard
// Params 0, eflags: 0x0
// Checksum 0xec364191, Offset: 0x1038
// Size: 0x82
function function_9fe04122() {
    a_zombie_doors = getentarray("zombie_door", "targetname");
    a_zombie_debris = getentarray("zombie_debris", "targetname");
    a_e_zombie_doors = arraycombine(a_zombie_doors, a_zombie_debris, 0, 0);
    return a_e_zombie_doors;
}

// Namespace zm_utility/zm_utility_zstandard
// Params 1, eflags: 0x0
// Checksum 0xf5ccd01d, Offset: 0x10c8
// Size: 0x34
function function_882ebf68(var_a9fa4929 = 1) {
    level thread function_a8b8995d(var_a9fa4929);
}

// Namespace zm_utility/zm_utility_zstandard
// Params 1, eflags: 0x0
// Checksum 0xffba947b, Offset: 0x1108
// Size: 0x232
function function_a8b8995d(var_a9fa4929 = 1) {
    level flag::wait_till("start_zombie_round_logic");
    a_e_zombie_doors = function_9fe04122();
    foreach (e_door in a_e_zombie_doors) {
        if (!isdefined(e_door)) {
            continue;
        }
        if (var_a9fa4929 && function_faf8c4ca() && e_door.script_flag !== function_8554c9ff()) {
            continue;
        }
        var_ce781e7e = getentarray(e_door.target, "targetname");
        foreach (var_5b419053 in var_ce781e7e) {
            if (isdefined(var_5b419053.objectid)) {
                switch (var_5b419053.objectid) {
                case #"symbol_back_debris":
                case #"symbol_back":
                case #"symbol_front":
                case #"symbol_front_debris":
                    var_5b419053 thread function_f381fe84(var_a9fa4929, var_5b419053.objectid);
                    break;
                default:
                    break;
                }
            }
        }
    }
}

// Namespace zm_utility/zm_utility_zstandard
// Params 2, eflags: 0x0
// Checksum 0x1fa333c0, Offset: 0x1348
// Size: 0x114
function function_f381fe84(var_a9fa4929 = 1, var_9a3b26a2) {
    self endon(#"death");
    if (var_a9fa4929) {
        if (var_9a3b26a2 == "symbol_front" || var_9a3b26a2 == "symbol_back") {
            self clientfield::set("doorbuy_ambient_fx", 1);
        } else {
            self clientfield::set("debrisbuy_ambient_fx", 1);
        }
        return;
    }
    if (var_9a3b26a2 == "symbol_front" || var_9a3b26a2 == "symbol_back") {
        self clientfield::set("doorbuy_ambient_fx", 0);
        return;
    }
    self clientfield::set("debrisbuy_ambient_fx", 0);
}

// Namespace zm_utility/zm_utility_zstandard
// Params 1, eflags: 0x0
// Checksum 0x572e6fe, Offset: 0x1468
// Size: 0x1ec
function function_6c831dc6(player) {
    if (!(isdefined(self.var_d5077e96) && self.var_d5077e96)) {
        player notify(#"player_grabbed_key");
    }
    level notify(#"player_grabbed_key", {#e_player:player});
    function_81efd58f();
    if (isdefined(self.var_e7b481da) && self.var_e7b481da) {
        level util::delay(1.5, "end_game", &zm_audio::sndannouncerplayvox, "picked_up_key");
    }
    if (isarray(level.var_ce8d9a15) && level.var_ce8d9a15.size) {
        arrayremoveindex(level.var_ce8d9a15, 0);
    }
    function_882ebf68(1);
    player playsound(#"zmb_key_pickup");
    if (!(isdefined(level.var_be72d53f) && level.var_be72d53f) && get_story() === 2) {
        level.var_be72d53f = 1;
        level util::delay(3, "end_game", &array::thread_all, level.players, &zm_equipment::show_hint_text, #"hash_68e088397871d66a");
    }
}

// Namespace zm_utility/zm_utility_zstandard
// Params 0, eflags: 0x0
// Checksum 0x52c5b790, Offset: 0x1660
// Size: 0x3ea
function function_1a11b178() {
    var_d9ab7b25 = level.round_number;
    a_ai_zombies = zombie_utility::get_round_enemy_array();
    n_chance = randomint(100);
    var_274739dc = 0;
    if (!(isdefined(self.ignore_enemy_count) && self.ignore_enemy_count) && a_ai_zombies.size == 1 && level.zombie_total <= 0 && !level flag::get("infinite_round_spawning")) {
        v_start = self.origin;
        foreach (var_595b62b8, s_key in level.var_4737fa66) {
            if (s_key.var_dc0e1ce7) {
                continue;
            }
            if (var_595b62b8 <= var_d9ab7b25 || n_chance < level.var_4940fe86) {
                s_key.var_dc0e1ce7 = 1;
                if (!var_274739dc && (isdefined(self.var_4d11bb60) && self.var_4d11bb60 || !(check_point_in_playable_area(v_start) && check_point_in_enabled_zone(v_start)) || isdefined(self.nuked) && self.nuked)) {
                    e_player = arraygetclosest(v_start, level.activeplayers);
                    v_start = e_player.origin;
                    s_result = positionquery_source_navigation(v_start, 96, 512, 64, 64, 1);
                    if (isdefined(s_result) && isarray(s_result.data)) {
                        var_768c948f = array::randomize(s_result.data);
                        foreach (var_be471012 in var_768c948f) {
                            if (check_point_in_playable_area(var_be471012.origin) && check_point_in_enabled_zone(var_be471012.origin) && e_player util::is_player_looking_at(var_be471012.origin, 0.6, 0)) {
                                v_start = var_be471012.origin;
                                break;
                            }
                        }
                    }
                }
                for (i = 0; i < s_key.var_a5cc5962; i++) {
                    level thread drop_key(v_start, var_274739dc);
                    var_274739dc = 1;
                }
            }
        }
    }
}

// Namespace zm_utility/zm_utility_zstandard
// Params 2, eflags: 0x0
// Checksum 0x138c03c6, Offset: 0x1a58
// Size: 0x300
function drop_key(v_start_pos, var_116c6652 = 0) {
    if (!function_587070e3()) {
        /#
            iprintlnbold("<dev string:xd5>" + level.var_89e35bb9 + "<dev string:xef>");
        #/
        return;
    }
    if (var_116c6652) {
        e_player = arraygetclosest(v_start_pos, level.activeplayers);
        s_result = positionquery_source_navigation(v_start_pos, 16, 100, 64, 8, 1);
        if (isdefined(s_result) && isarray(s_result.data)) {
            var_768c948f = array::randomize(s_result.data);
            foreach (var_be471012 in var_768c948f) {
                if (check_point_in_playable_area(var_be471012.origin) && check_point_in_enabled_zone(var_be471012.origin)) {
                    v_start_pos = var_be471012.origin;
                    break;
                }
            }
        }
    }
    level notify(#"key_dropped");
    if (isdefined(level.var_9c0f8ddf)) {
        level.var_9c0f8ddf--;
    }
    e_key = zm_powerups::specific_powerup_drop("zmarcade_key", v_start_pos, undefined, undefined, undefined, 1);
    if (!isdefined(level.var_ce8d9a15)) {
        level.var_ce8d9a15 = [];
    } else if (!isarray(level.var_ce8d9a15)) {
        level.var_ce8d9a15 = array(level.var_ce8d9a15);
    }
    level.var_ce8d9a15[level.var_ce8d9a15.size] = e_key;
    if (!var_116c6652) {
        e_key playsound(#"hash_5eca7fc11b300dd1");
        e_key.var_e7b481da = 1;
    }
    e_key thread function_b08409c5();
    return e_key;
}

// Namespace zm_utility/zm_utility_zstandard
// Params 0, eflags: 0x0
// Checksum 0xf57e37cd, Offset: 0x1d60
// Size: 0x236
function function_b08409c5() {
    self endon(#"death", #"powerup_timedout", #"powerup_grabbed", #"hacked");
    level endon(#"end_game");
    n_timer = 15;
    if (n_timer > 0) {
        wait n_timer;
    }
    self.var_d5077e96 = 1;
    var_3df89334 = [];
    foreach (player in level.players) {
        if (isalive(player) && player.sessionstate !== "spectator") {
            if (!isdefined(var_3df89334)) {
                var_3df89334 = [];
            } else if (!isarray(var_3df89334)) {
                var_3df89334 = array(var_3df89334);
            }
            var_3df89334[var_3df89334.size] = player;
        }
    }
    e_player = arraygetclosest(self.origin, var_3df89334);
    if (isplayer(e_player)) {
        /#
            if (n_timer > 0) {
                iprintlnbold("<dev string:x105>" + e_player.name + "<dev string:x118>" + n_timer + "<dev string:x120>");
            }
        #/
        self dontinterpolate();
        self.origin = e_player.origin;
    }
}

// Namespace zm_utility/zm_utility_zstandard
// Params 7, eflags: 0x0
// Checksum 0xc4f9b6ac, Offset: 0x1fa0
// Size: 0x17e
function function_43a1716a(n_round, archetype, n_count_total, var_67be72a0, var_2b02390e, var_18a8b881, var_32dcecaf) {
    if (!isdefined(level.var_2557dd2a)) {
        level.var_2557dd2a = [];
    }
    if (!isdefined(level.var_2557dd2a[n_round])) {
        level.var_2557dd2a[n_round] = [];
    }
    var_14501c94 = spawnstruct();
    var_14501c94.n_count_total = n_count_total;
    var_14501c94.var_2b02390e = var_2b02390e;
    var_14501c94.var_32dcecaf = var_32dcecaf;
    var_14501c94.var_18a8b881 = var_18a8b881;
    level.var_2557dd2a[n_round][archetype] = var_14501c94;
    if (archetype == "zombie") {
        if (!isdefined(level.var_c6562dd4)) {
            level.var_c6562dd4 = [];
        }
        var_7ed63d31 = spawnstruct();
        var_7ed63d31.var_67be72a0 = var_67be72a0;
        var_7ed63d31.n_count_total = n_count_total;
        level.var_c6562dd4[n_round] = var_7ed63d31;
    }
}

// Namespace zm_utility/zm_utility_zstandard
// Params 0, eflags: 0x0
// Checksum 0x7ebba122, Offset: 0x2128
// Size: 0x2c
function function_dc33a954() {
    n_wait = randomfloatrange(4, 10);
    wait n_wait;
}

// Namespace zm_utility/zm_utility_zstandard
// Params 6, eflags: 0x0
// Checksum 0xce6efe1, Offset: 0x2160
// Size: 0x19e
function function_91dbbd22(str_index, var_bf9da5f0, a_str_zones, a_str_next_defend, var_ef26453d, var_94785111) {
    if (!isdefined(level.a_s_defend_areas)) {
        level.a_s_defend_areas = [];
    }
    if (!isdefined(level.var_c6bed01a)) {
        level.var_c6bed01a = [];
    }
    if (!isdefined(a_str_zones)) {
        a_str_zones = [];
    } else if (!isarray(a_str_zones)) {
        a_str_zones = array(a_str_zones);
    }
    if (!isdefined(a_str_next_defend)) {
        a_str_next_defend = [];
    } else if (!isarray(a_str_next_defend)) {
        a_str_next_defend = array(a_str_next_defend);
    }
    assert(isdefined(struct::get(var_bf9da5f0)), "<dev string:x129>" + var_bf9da5f0 + "<dev string:x143>");
    level.a_s_defend_areas[str_index] = {#var_bf9da5f0:var_bf9da5f0, #a_str_zones:a_str_zones, #a_str_next_defend:a_str_next_defend, #var_ef26453d:var_ef26453d, #var_94785111:var_94785111};
}

// Namespace zm_utility/zm_utility_zstandard
// Params 1, eflags: 0x0
// Checksum 0x9fefc40b, Offset: 0x2308
// Size: 0xe4
function function_8107842e(str_index) {
    if (!isdefined(level.var_c6bed01a)) {
        level.var_c6bed01a = [];
    } else if (!isarray(level.var_c6bed01a)) {
        level.var_c6bed01a = array(level.var_c6bed01a);
    }
    if (!isinarray(level.var_c6bed01a, str_index)) {
        level.var_c6bed01a[level.var_c6bed01a.size] = str_index;
    }
    if (level.var_c6bed01a.size > 3) {
        arrayremoveindex(level.var_c6bed01a, 0);
    }
}

// Namespace zm_utility/zm_utility_zstandard
// Params 2, eflags: 0x0
// Checksum 0x735228f8, Offset: 0x23f8
// Size: 0x1b2
function function_c3367f31(var_25be3254, b_random = 1) {
    var_a0277872 = arraycopy(level.a_s_defend_areas[var_25be3254].a_str_next_defend);
    function_8107842e(var_25be3254);
    var_27e5fe48 = array::exclude(var_a0277872, level.var_c6bed01a);
    if (b_random) {
        str_defend = array::random(var_27e5fe48);
    } else {
        if (!isdefined(level.a_s_defend_areas[var_25be3254].var_19483fa7)) {
            level.a_s_defend_areas[var_25be3254].var_19483fa7 = 0;
        }
        str_defend = level.a_s_defend_areas[var_25be3254].a_str_next_defend[level.a_s_defend_areas[var_25be3254].var_19483fa7];
        level.a_s_defend_areas[var_25be3254].var_19483fa7++;
        if (level.a_s_defend_areas[var_25be3254].var_19483fa7 >= level.a_s_defend_areas[var_25be3254].a_str_next_defend.size) {
            level.a_s_defend_areas[var_25be3254].var_19483fa7 = 0;
        }
    }
    if (isdefined(str_defend)) {
        return str_defend;
    }
    return array::random(var_a0277872);
}

// Namespace zm_utility/zm_utility_zstandard
// Params 2, eflags: 0x0
// Checksum 0x8e3ca8d5, Offset: 0x25b8
// Size: 0x6a
function function_28ca7160(var_a7dcc895, b_random = 1) {
    str_index = function_c3367f31(var_a7dcc895, b_random);
    s_defend_area = function_f7cc2e9e(str_index);
    return s_defend_area;
}

// Namespace zm_utility/zm_utility_zstandard
// Params 1, eflags: 0x0
// Checksum 0x5fce651e, Offset: 0x2630
// Size: 0x6c
function function_f7cc2e9e(str_index) {
    assert(isdefined(level.a_s_defend_areas[str_index]), "<dev string:x153>" + function_15979fa9(str_index) + "<dev string:x161>");
    return level.a_s_defend_areas[str_index];
}

// Namespace zm_utility/zm_utility_zstandard
// Params 3, eflags: 0x0
// Checksum 0x779de1c, Offset: 0x26a8
// Size: 0x15c
function function_8eef3e0e(str_next_defend, var_da14fa07 = #"hash_3a35084ee8c333b2", hide_notify = "creating_zone_defend_area") {
    var_7a1cf45f = function_f7cc2e9e(str_next_defend);
    n_obj_id = function_6e3c4e7b(var_7a1cf45f.var_bf9da5f0, var_da14fa07, 0);
    foreach (player in level.players) {
        player thread zm_equipment::show_hint_text(var_7a1cf45f.var_ef26453d, 10, 1.75, 120);
    }
    level util::delay(hide_notify, "end_game", &function_a6a6b4cc, n_obj_id);
}

// Namespace zm_utility/zm_utility_zstandard
// Params 7, eflags: 0x0
// Checksum 0x8d9029e2, Offset: 0x2810
// Size: 0x564
function function_9928fae6(var_2ec67940, a_str_zones, var_8d7a5087, var_da14fa07 = #"hash_683cf7d37afcc3ae", var_83304650 = 45, var_da8785ce = 60, var_a5cc5962 = 0) {
    level endoncallback(&function_4e66b38d, #"end_game");
    if (!isdefined(a_str_zones)) {
        a_str_zones = [];
    } else if (!isarray(a_str_zones)) {
        a_str_zones = array(a_str_zones);
    }
    level flag::wait_till("start_zombie_round_logic");
    function_43d703b8(1, 5);
    var_15f81096 = level flag::get("disable_special_rounds");
    level flag::set(#"disable_special_rounds");
    level.var_8b5c6380 = function_6e3c4e7b(var_8d7a5087, var_da14fa07);
    level notify(#"creating_zone_defend_area", {#n_obj_id:level.var_8b5c6380});
    level.var_e0541a13 = var_8d7a5087;
    level.var_14890e44 = undefined;
    foreach (player in level.players) {
        player thread function_7e032ec2(var_2ec67940, a_str_zones, var_83304650, var_da8785ce);
        player thread function_518e72a4();
        waitframe(1);
    }
    level thread play_sound_2d("zmb_rush_defend_start");
    level zm_audio::sndannouncerplayvox("rush_zone_nag");
    level flag::wait_till("started_defend_area");
    level thread function_5659ce29(var_da8785ce);
    if (var_a5cc5962 > 0) {
        waittillframeend();
        function_4737fa66(level.round_number, var_a5cc5962);
    }
    zm_bgb_anywhere_but_here::function_f9947cd5(0);
    function_6b1e4771(1);
    callback::on_ai_damage(&function_b00946c0);
    callback::on_ai_killed(&function_1ec84b30);
    if (level flag::exists(#"disable_fast_travel")) {
        level flag::set(#"disable_fast_travel");
    }
    level waittill(#"hash_7a04a7fb98fa4e4d");
    if (level flag::exists(#"disable_fast_travel")) {
        level flag::clear(#"disable_fast_travel");
    }
    level thread play_sound_2d("zmb_rush_defend_end");
    if (!var_15f81096) {
        level flag::clear(#"disable_special_rounds");
    }
    zm_bgb_anywhere_but_here::function_f9947cd5(1);
    level flag::clear("started_defend_area");
    foreach (player in level.players) {
        player thread zm_equipment::show_hint_text(#"hash_5c4b994618e485b6");
    }
    function_a6a6b4cc(level.var_8b5c6380, level.var_e0541a13);
    level.var_8b5c6380 = undefined;
    wait 12;
    function_6b1e4771();
}

// Namespace zm_utility/zm_utility_zstandard
// Params 1, eflags: 0x0
// Checksum 0xf9ad5adb, Offset: 0x2d80
// Size: 0x96
function function_5659ce29(var_46b66cb3) {
    var_a94fc1a3 = level.zombie_powerups[#"nuke"].func_should_drop_with_regular_powerups;
    zm_powerups::powerup_remove_from_regular_drops(#"nuke");
    n_wait = var_46b66cb3 * 0.75;
    wait n_wait;
    level.zombie_powerups[#"nuke"].func_should_drop_with_regular_powerups = var_a94fc1a3;
}

// Namespace zm_utility/zm_utility_zstandard
// Params 1, eflags: 0x0
// Checksum 0xd703324c, Offset: 0x2e20
// Size: 0x3c
function function_4e66b38d(str_notify) {
    function_a6a6b4cc(level.var_8b5c6380, level.var_e0541a13);
    function_6b1e4771();
}

// Namespace zm_utility/zm_utility_zstandard
// Params 1, eflags: 0x0
// Checksum 0x8b4ae8c1, Offset: 0x2e68
// Size: 0x1ec
function function_1ec84b30(params) {
    a_ai_zombies = zombie_utility::get_round_enemy_array();
    if (!(isdefined(self.ignore_enemy_count) && self.ignore_enemy_count) && a_ai_zombies.size == 1 && level.zombie_total <= 0 && !level flag::get("infinite_round_spawning")) {
        v_start = self.origin + (0, 0, 8);
        if (isdefined(self.var_4d11bb60) && self.var_4d11bb60 || !(check_point_in_playable_area(v_start) && check_point_in_enabled_zone(v_start)) || isdefined(self.nuked) && self.nuked) {
            if (isdefined(level.var_e0541a13)) {
                s_defend_area = struct::get(level.var_e0541a13);
                v_start = s_defend_area.origin;
            }
        }
        playsoundatposition(#"hash_6124e4ccaf068cd0", v_start);
        level thread function_91e0af39(v_start, 20, 800, 1, 0.25);
        callback::remove_on_ai_killed(&function_b00946c0);
        callback::remove_on_ai_killed(&function_1ec84b30);
    }
}

// Namespace zm_utility/zm_utility_zstandard
// Params 1, eflags: 0x0
// Checksum 0x556ce717, Offset: 0x3060
// Size: 0x132
function function_b00946c0(params) {
    if (self.var_29ed62b2 !== #"miniboss") {
        return;
    }
    a_ai_enemies = getaiteamarray(level.zombie_team);
    var_fa1e4b46 = 0;
    foreach (ai in a_ai_enemies) {
        if (ai.var_29ed62b2 === #"miniboss") {
            var_fa1e4b46++;
        }
    }
    if (isplayer(params.eattacker) && var_fa1e4b46 == a_ai_enemies.size) {
        n_damage = params.idamage * 2;
        return n_damage;
    }
}

// Namespace zm_utility/zm_utility_zstandard
// Params 0, eflags: 0x0
// Checksum 0xe2960dff, Offset: 0x31a0
// Size: 0x29e
function function_518e72a4() {
    self endon(#"disconnect");
    s_defend_area = struct::get(level.var_e0541a13);
    var_72d2d101 = generatenavmeshpath(self.origin, s_defend_area.origin);
    if (isdefined(var_72d2d101) && isarray(var_72d2d101.pathpoints) && var_72d2d101.status === "succeeded") {
        var_56928d5d = arraysortclosest(var_72d2d101.pathpoints, self.origin, undefined, 400);
        if (isdefined(var_56928d5d[0])) {
            var_237f2d70 = var_56928d5d[0];
        }
        if (isdefined(var_237f2d70) && function_32fa7a1b(var_237f2d70)) {
            function_965eb051(var_237f2d70, 0, 0);
            wait 0.5;
        }
        for (i = 1; i < var_56928d5d.size; i++) {
            var_fd031af6 = distance(var_56928d5d[i], var_237f2d70);
            var_d1d34bea = distance(s_defend_area.origin, var_237f2d70);
            if (var_d1d34bea > 400 && var_fd031af6 > 400 && function_32fa7a1b(var_56928d5d[i])) {
                function_965eb051(var_56928d5d[i], 0, 0);
                var_237f2d70 = var_56928d5d[i];
                wait 0.5;
            }
        }
        if (function_32fa7a1b(s_defend_area.origin) && !isdefined(s_defend_area.e_powerup)) {
            s_defend_area.e_powerup = function_965eb051(s_defend_area.origin, 1, 0);
        }
    }
}

// Namespace zm_utility/zm_utility_zstandard
// Params 3, eflags: 0x0
// Checksum 0x20d2871e, Offset: 0x3448
// Size: 0x130
function function_32fa7a1b(v_pos, n_spacing = 400, var_6ab91ca7) {
    var_9284adec = zm_powerups::get_powerups(v_pos, n_spacing);
    if (var_9284adec.size > 0) {
        return false;
    }
    if (isarray(var_6ab91ca7)) {
        foreach (var_c66d0614 in var_6ab91ca7) {
            if (distance(v_pos, var_c66d0614) < n_spacing) {
                return false;
            }
        }
    }
    if (check_point_in_playable_area(v_pos) && check_point_in_enabled_zone(v_pos)) {
        return true;
    }
    return false;
}

// Namespace zm_utility/zm_utility_zstandard
// Params 4, eflags: 0x0
// Checksum 0xb466642c, Offset: 0x3580
// Size: 0x960
function function_7e032ec2(var_2ec67940, a_str_zones, var_83304650, var_da8785ce) {
    self endon(#"disconnect");
    level endon(#"end_game", #"hash_7a04a7fb98fa4e4d");
    self.var_7ade76e0 = 0;
    if (level.var_bb57ff69 zm_trial_timer::is_open(self)) {
        level.var_bb57ff69 zm_trial_timer::close(self);
    }
    zm_trial_util::stop_timer();
    waitframe(1);
    level.var_bb57ff69 zm_trial_timer::open(self);
    level.var_bb57ff69 zm_trial_timer::set_timer_text(self, var_2ec67940);
    self zm_trial_util::start_timer(var_83304650);
    s_defend_area = struct::get(level.var_e0541a13);
    n_time = var_83304650;
    var_77cd8dbf = 0;
    while (n_time >= 0) {
        if (n_time <= 30 && n_time % 5 == 0 || n_time <= 10) {
            self playsoundtoplayer(#"hash_531658e82d2845f7", self);
        }
        b_any_player_in_zone = 0;
        var_9c1c8e05 = 1;
        n_players_in_zone = 0;
        foreach (player in level.activeplayers) {
            if (!isalive(player) || player.sessionstate === "spectator") {
                continue;
            }
            if (player zm_zonemgr::is_player_in_zone(a_str_zones)) {
                b_any_player_in_zone = 1;
                n_players_in_zone++;
            }
            if (!player zm_zonemgr::is_player_in_zone(a_str_zones)) {
                var_9c1c8e05 = 0;
                break;
            }
        }
        if (b_any_player_in_zone && n_time < 20 && !(isdefined(level.var_14890e44) && level.var_14890e44)) {
            function_6b1e4771(1);
            level.var_14890e44 = 1;
        }
        if (b_any_player_in_zone && n_time <= 35 && var_77cd8dbf >= 5) {
            var_77cd8dbf = 0;
            playsoundatposition(#"hash_5755957467fab7c0", s_defend_area.origin);
            level thread function_91e0af39(s_defend_area.origin, randomintrange(1, 4), 1000, 1, 0.2);
        }
        if (var_9c1c8e05) {
            foreach (player in level.activeplayers) {
                if (isalive(player)) {
                    level.var_bb57ff69 zm_trial_timer::close(player);
                }
            }
            break;
        } else {
            foreach (player in level.activeplayers) {
                if (isalive(player) && player zm_zonemgr::is_player_in_zone(a_str_zones)) {
                    player notify(#"hash_b696fc900429737");
                    if (!(isdefined(player.var_7ade76e0) && player.var_7ade76e0)) {
                        player.var_7ade76e0 = 1;
                        level.var_bb57ff69 zm_trial_timer::set_timer_text(player, #"hash_64e686d0e2a5bfcb");
                    }
                    continue;
                }
                if (isalive(player) && !player zm_zonemgr::is_player_in_zone(a_str_zones) && isdefined(player.var_7ade76e0) && player.var_7ade76e0) {
                    player.var_7ade76e0 = 0;
                    level.var_bb57ff69 zm_trial_timer::set_timer_text(player, var_2ec67940);
                }
            }
        }
        var_77cd8dbf++;
        n_time--;
        wait 1;
    }
    if (level.var_bb57ff69 zm_trial_timer::is_open(self)) {
        level.var_bb57ff69 zm_trial_timer::close(self);
    }
    self zm_trial_util::stop_timer();
    waitframe(1);
    if (self zm_zonemgr::is_player_in_zone(a_str_zones)) {
        self function_447e7c95(level.var_8b5c6380, 0);
        self.var_7ade76e0 = 1;
        self playsoundtoplayer(#"hash_519872be58d1c467", self);
        self thread zm_equipment::show_hint_text(#"hash_215c2a48351115a1");
    } else {
        self function_447e7c95(level.var_8b5c6380, 1);
        self.var_7ade76e0 = 0;
        self thread player_left_zone(a_str_zones, 15, 1);
    }
    level flag::set("started_defend_area");
    level thread zm_audio::sndannouncerplayvox("defend_start");
    waitframe(1);
    var_350bdfc3 = 0;
    level.var_6e46a508 = undefined;
    level.var_34ffeefc = undefined;
    self thread function_aed5286b(a_str_zones);
    while (var_da8785ce >= 0 || !(isdefined(level.var_34ffeefc) && level.var_34ffeefc)) {
        if (self.var_7ade76e0) {
            var_350bdfc3++;
        }
        if (var_da8785ce <= 0 && !(isdefined(level.var_6e46a508) && level.var_6e46a508)) {
            level.var_6e46a508 = 1;
            level flag::clear("started_defend_area");
            level flag::clear(#"infinite_round_spawning");
            level flag::clear(#"pause_round_timeout");
            level thread function_43d703b8(1);
        }
        wait 1;
        var_da8785ce--;
    }
    level thread zm_audio::sndannouncerplayvox("defend_complete");
    if (level.var_bb57ff69 zm_trial_timer::is_open(self)) {
        level.var_bb57ff69 zm_trial_timer::close(self);
    }
    self clientfield::set_to_player("zm_zone_out_of_bounds", 0);
    self zm_trial_util::stop_timer();
    level notify(#"hash_7a04a7fb98fa4e4d");
}

// Namespace zm_utility/zm_utility_zstandard
// Params 1, eflags: 0x0
// Checksum 0x4dc16db0, Offset: 0x3ee8
// Size: 0x1de
function function_aed5286b(a_str_zones) {
    self endon(#"disconnect");
    level endon(#"end_game", #"hash_7a04a7fb98fa4e4d");
    while (true) {
        if (!self.var_7ade76e0 && self zm_zonemgr::is_player_in_zone(a_str_zones)) {
            self function_447e7c95(level.var_8b5c6380, 0);
            self.var_7ade76e0 = 1;
            self playsoundtoplayer(#"hash_519872be58d1c467", self);
            self clientfield::set_to_player("zm_zone_out_of_bounds", 0);
            self thread zm_equipment::show_hint_text(#"hash_215c2a48351115a1", 1);
            if (level.var_bb57ff69 zm_trial_timer::is_open(self)) {
                level.var_bb57ff69 zm_trial_timer::close(self);
            }
            self zm_trial_util::stop_timer();
        } else if (self.var_7ade76e0 && !self zm_zonemgr::is_player_in_zone(a_str_zones)) {
            self function_447e7c95(level.var_8b5c6380, 1);
            self.var_7ade76e0 = 0;
            self thread player_left_zone(a_str_zones);
        }
        waitframe(1);
    }
}

// Namespace zm_utility/zm_utility_zstandard
// Params 3, eflags: 0x0
// Checksum 0x3d62c818, Offset: 0x40d0
// Size: 0x740
function player_left_zone(a_str_zones, var_4ab09caa, var_ba513204) {
    self endon(#"disconnect");
    level endoncallback(&function_fc34aa1f, #"end_game", #"hash_7a04a7fb98fa4e4d");
    while (true) {
        n_time = isdefined(var_4ab09caa) ? var_4ab09caa : 5;
        if (!self zm_zonemgr::is_player_in_zone(a_str_zones) && self.sessionstate !== "spectator") {
            if (level.var_bb57ff69 zm_trial_timer::is_open(self)) {
                level.var_bb57ff69 zm_trial_timer::close(self);
            }
            if (!(isdefined(var_ba513204) && var_ba513204)) {
                waitframe(1);
                if (!level.var_bb57ff69 zm_trial_timer::is_open(self)) {
                    level.var_bb57ff69 zm_trial_timer::open(self);
                    level.var_bb57ff69 zm_trial_timer::set_timer_text(self, #"hash_4bef74a6e7f21aa0");
                    self zm_trial_util::start_timer(n_time);
                }
            } else {
                if (level.var_bb57ff69 zm_trial_timer::is_open(self)) {
                    level.var_bb57ff69 zm_trial_timer::close(self);
                }
                self zm_trial_util::stop_timer();
            }
        } else {
            if (level.var_bb57ff69 zm_trial_timer::is_open(self)) {
                level.var_bb57ff69 zm_trial_timer::close(self);
            }
            self zm_trial_util::stop_timer();
        }
        while (true) {
            if (self zm_zonemgr::is_player_in_zone(a_str_zones) && self.sessionstate !== "spectator") {
                if (level.var_bb57ff69 zm_trial_timer::is_open(self)) {
                    level.var_bb57ff69 zm_trial_timer::close(self);
                }
                self zm_trial_util::stop_timer();
                return;
            }
            if ((n_time < 0 || isdefined(var_ba513204) && var_ba513204) && !(isdefined(self.var_56c7266a) && self.var_56c7266a)) {
                if (level.var_bb57ff69 zm_trial_timer::is_open(self)) {
                    level.var_bb57ff69 zm_trial_timer::close(self);
                    self zm_trial_util::stop_timer();
                }
            }
            if (isdefined(var_ba513204) && var_ba513204) {
                var_b32f7076 = int(self.maxhealth * 0.0667);
                if (!(isdefined(self.var_56c7266a) && self.var_56c7266a)) {
                    self dodamage(var_b32f7076, self.origin);
                }
            } else {
                if (self clientfield::get_to_player("zm_zone_out_of_bounds") == 0) {
                    self clientfield::set_to_player("zm_zone_out_of_bounds", 1);
                }
                switch (n_time) {
                case 5:
                    n_damage = int(self.maxhealth * 10 / self.maxhealth);
                    break;
                case 4:
                    n_damage = int(self.maxhealth * 20 / self.maxhealth);
                    break;
                case 3:
                    n_damage = int(self.maxhealth * 30 / self.maxhealth);
                    break;
                case 2:
                    n_damage = int(self.maxhealth * 40 / self.maxhealth);
                    break;
                case 1:
                    n_damage = int(self.maxhealth * 45 / self.maxhealth);
                    break;
                default:
                    n_damage = int(self.maxhealth * 150 / self.maxhealth);
                    break;
                }
                if (!(isdefined(self.var_56c7266a) && self.var_56c7266a)) {
                    self dodamage(n_damage, self.origin);
                }
            }
            if (!isalive(self) || self laststand::player_is_in_laststand()) {
                break;
            }
            wait 1;
            n_time--;
        }
        if (isalive(self) && !self laststand::player_is_in_laststand()) {
            self dodamage(self.health + 666, self.origin);
        }
        if (!isalive(self) || self laststand::player_is_in_laststand()) {
            self clientfield::set_to_player("zm_zone_out_of_bounds", 0);
            self waittill(#"player_revived", #"hash_387bb170e38042d5");
            self function_1cf2007e();
        }
    }
}

// Namespace zm_utility/zm_utility_zstandard
// Params 1, eflags: 0x0
// Checksum 0x1906b3e7, Offset: 0x4818
// Size: 0xe8
function function_fc34aa1f(str_notify) {
    foreach (player in level.players) {
        if (level.var_bb57ff69 zm_trial_timer::is_open(player)) {
            level.var_bb57ff69 zm_trial_timer::close(player);
        }
        player clientfield::set_to_player("zm_zone_out_of_bounds", 0);
        player zm_trial_util::stop_timer();
    }
}

// Namespace zm_utility/zm_utility_zstandard
// Params 0, eflags: 0x0
// Checksum 0x33007433, Offset: 0x4908
// Size: 0x274
function function_1cf2007e() {
    self endon(#"disconnect");
    level endon(#"end_game", #"hash_7a04a7fb98fa4e4d");
    if (!isdefined(level.var_e0541a13)) {
        return;
    }
    s_objective = struct::get(level.var_e0541a13);
    v_origin = self.origin;
    v_angles = self.angles;
    if (check_point_in_playable_area(s_objective.origin) && !positionwouldtelefrag(s_objective.origin)) {
        v_origin = s_objective.origin;
        v_angles = s_objective.angles;
    } else {
        s_result = positionquery_source_navigation(s_objective.origin, 32, 1024, 64, 64);
        if (isdefined(s_result) && isarray(s_result.data)) {
            foreach (var_be471012 in s_result.data) {
                if (check_point_in_playable_area(var_be471012.origin) && check_point_in_enabled_zone(var_be471012.origin) && !positionwouldtelefrag(var_be471012.origin)) {
                    v_origin = var_be471012.origin;
                    v_angles = self.angles;
                    break;
                }
            }
        }
    }
    self setorigin(v_origin);
    self setplayerangles(v_angles);
}

// Namespace zm_utility/zm_utility_zstandard
// Params 3, eflags: 0x0
// Checksum 0xbb61535f, Offset: 0x4b88
// Size: 0xaa
function function_965eb051(v_origin, b_permanent = 1, var_ed5156de = 1) {
    if (var_ed5156de) {
        while (level.active_powerups.size >= 75) {
            waitframe(1);
        }
    }
    if (level.active_powerups.size < 75) {
        e_powerup = zm_powerups::specific_powerup_drop("bonus_points_player", v_origin, undefined, undefined, undefined, b_permanent);
    }
    return e_powerup;
}

// Namespace zm_utility/zm_utility_zstandard
// Params 2, eflags: 0x0
// Checksum 0x918f8af9, Offset: 0x4c40
// Size: 0x13e
function function_43d703b8(var_9a65c252 = 1, var_677ea8cc = 0) {
    level.var_34ffeefc = undefined;
    if (level flag::get("special_round")) {
        level waittill(#"end_of_round");
    }
    level flag::clear("spawn_zombies");
    if (var_9a65c252) {
        a_ai_enemies = getaiteamarray(level.zombie_team);
        while (a_ai_enemies.size > var_677ea8cc) {
            a_ai_enemies = getaiteamarray(level.zombie_team);
            waitframe(1);
        }
    } else {
        a_ai_enemies = zombie_utility::get_round_enemy_array();
        while (a_ai_enemies.size > var_677ea8cc) {
            a_ai_enemies = zombie_utility::get_round_enemy_array();
            waitframe(1);
        }
    }
    level.var_34ffeefc = 1;
}

// Namespace zm_utility/zm_utility_zstandard
// Params 1, eflags: 0x0
// Checksum 0x2e67dae3, Offset: 0x4d88
// Size: 0x7c
function function_6b1e4771(var_a0d5d040 = 0) {
    level flag::set("spawn_zombies");
    if (var_a0d5d040) {
        level flag::set(#"infinite_round_spawning");
        level flag::set(#"pause_round_timeout");
    }
}

// Namespace zm_utility/zm_utility_zstandard
// Params 2, eflags: 0x0
// Checksum 0x8ef118f, Offset: 0x4e10
// Size: 0x482
function function_5842b86c(str_archetype, var_4f27fc8f = 1) {
    if (!isdefined(level.var_b9586e60)) {
        level.var_b9586e60 = [];
    }
    if (!isdefined(level.var_b9586e60[str_archetype])) {
        level.var_b9586e60[str_archetype] = 0;
    }
    if (var_4f27fc8f && level.var_b9586e60[str_archetype]) {
        return;
    }
    level thread play_sound_2d("zmb_rush_monster_incoming");
    switch (str_archetype) {
    case #"catalyst":
        level function_fc24c484(#"hash_6b692a869903ac87", #"hash_451da0cb46417560");
        break;
    case #"catalyst_corrosive":
        level function_fc24c484(#"hash_6b692a869903ac87", #"hash_7641ba4524584595");
        break;
    case #"catalyst_electric":
        level function_fc24c484(#"hash_6b692a869903ac87", #"hash_70c3cc5975b6ae66");
        break;
    case #"catalyst_plasma":
        level function_fc24c484(#"hash_6b692a869903ac87", #"hash_462ab08cca184367");
        break;
    case #"catalyst_water":
        level function_fc24c484(#"hash_6b692a869903ac87", #"hash_44038d25e4255a68");
        break;
    case #"stoker":
        level function_fc24c484(#"hash_675460540c6a0e2", #"hash_602a33d6118f86cd");
        level thread zm_audio::sndannouncerplayvox("incoming_stoker");
        break;
    case #"blight_father":
        level function_fc24c484(#"hash_23f89b4249f680ca", #"hash_32d0a8ef63f997f0");
        level thread zm_audio::sndannouncerplayvox("incoming_blight_father");
        break;
    case #"gladiator":
        level function_fc24c484(#"hash_26da9999c27eae35", #"hash_5883640bac1406cc");
        level thread zm_audio::sndannouncerplayvox("incoming_heavy");
        break;
    case #"gladiator_destroyer":
        level function_fc24c484(#"hash_26da9999c27eae35", #"hash_63690aa1bddde5a");
        level thread zm_audio::sndannouncerplayvox("incoming_heavy");
        break;
    case #"gladiator_marauder":
        level function_fc24c484(#"hash_2c436e36d69569e5", #"hash_33dd4b2b1f843b78");
        level thread zm_audio::sndannouncerplayvox("incoming_heavy");
        break;
    case #"tiger":
        level function_fc24c484(#"hash_5c0af214835136af", #"hash_767128c196a4a356");
        break;
    }
    level.var_b9586e60[str_archetype] = 1;
}

// Namespace zm_utility/zm_utility_zstandard
// Params 5, eflags: 0x0
// Checksum 0x8482ac90, Offset: 0x52a0
// Size: 0x3da
function function_91e0af39(v_start_pos, var_c2ea7d7d, n_radius = 512, b_randomize = 1, var_a4930d06 = 0.2) {
    level endon(#"end_game");
    var_bce97935 = [];
    v_start_pos = groundtrace(v_start_pos + (0, 0, 8), v_start_pos + (0, 0, -100000), 0, undefined)[#"position"];
    s_result = positionquery_source_navigation(v_start_pos, 32, n_radius, 4, 16, 1, 32);
    if (isdefined(s_result) && isarray(s_result.data)) {
        if (b_randomize) {
            s_result.data = array::randomize(s_result.data);
        }
        foreach (var_be471012 in s_result.data) {
            if (function_32fa7a1b(var_be471012.origin, 24, var_bce97935)) {
                var_e7416d3b = var_be471012.origin;
                n_height_diff = abs(var_e7416d3b[2] - v_start_pos[2]);
                if (n_height_diff > 60) {
                    continue;
                }
                if (!isdefined(var_bce97935)) {
                    var_bce97935 = [];
                } else if (!isarray(var_bce97935)) {
                    var_bce97935 = array(var_bce97935);
                }
                var_bce97935[var_bce97935.size] = var_e7416d3b;
                if (var_bce97935.size > var_c2ea7d7d + 20) {
                    break;
                }
            }
        }
    }
    if (b_randomize) {
        var_bce97935 = array::randomize(var_bce97935);
    }
    level.var_751b1aad = 0;
    for (i = 0; i < var_c2ea7d7d; i++) {
        e_powerup = function_965eb051(v_start_pos, 0, 0);
        if (!isdefined(e_powerup)) {
            continue;
        }
        if (isdefined(var_bce97935[i])) {
            var_2685316e = length(v_start_pos - var_bce97935[i]);
            e_powerup fake_physicslaunch(var_bce97935[i] + (0, 0, 35), var_2685316e);
        } else {
            e_powerup fake_physicslaunch(v_start_pos + (0, 0, 35), n_radius / 3.5);
        }
        wait var_a4930d06;
    }
    level.var_751b1aad = 1;
}

// Namespace zm_utility/zm_utility_zstandard
// Params 2, eflags: 0x0
// Checksum 0xe7c5dc7e, Offset: 0x5688
// Size: 0xb8
function function_3e7cd25d(var_8d582c82, b_permanent = 0) {
    a_s_start_points = struct::get_array(var_8d582c82);
    foreach (s_start_point in a_s_start_points) {
        s_start_point thread function_69958c3a(b_permanent);
    }
}

// Namespace zm_utility/zm_utility_zstandard
// Params 1, eflags: 0x0
// Checksum 0x9e08f073, Offset: 0x5748
// Size: 0xf8
function function_69958c3a(b_permanent = 0) {
    if (!isdefined(self.e_powerup)) {
        self.e_powerup = self function_965eb051(self.origin, b_permanent);
    }
    if (isdefined(self.target)) {
        var_31975e56 = struct::get_array(self.target);
        foreach (var_8b19c76f in var_31975e56) {
            var_8b19c76f function_69958c3a(b_permanent);
        }
    }
}

// Namespace zm_utility/zm_utility_zstandard
// Params 5, eflags: 0x0
// Checksum 0x7d01be30, Offset: 0x5848
// Size: 0x2c8
function enable_power_switch(b_enable = 0, var_fce88df1 = 0, str_value, str_key, var_f86a549f) {
    if (isdefined(str_value) && isdefined(str_key)) {
        a_t_power = getentarray(str_value, str_key);
    } else {
        a_t_power = getentarray("use_elec_switch", "targetname");
    }
    if (b_enable) {
        var_2a30bb9b = 0;
        foreach (t_power in a_t_power) {
            t_power.var_58b0b006 = undefined;
            t_power setvisibletoall();
            if (var_fce88df1) {
                player = arraygetclosest(t_power.origin, level.activeplayers);
                t_power notify(#"trigger", {#activator:player});
                if (!var_2a30bb9b) {
                    var_2a30bb9b = 1;
                    level util::delay(4, "end_game", &array::thread_all, level.players, &zm_equipment::show_hint_text, #"hash_5bdc1f7024280e4e");
                    level thread zm_audio::sndannouncerplayvox("power_activated");
                }
            }
        }
        return;
    }
    foreach (t_power in a_t_power) {
        if (isdefined(var_f86a549f)) {
            t_power.var_58b0b006 = 1;
            t_power sethintstring(var_f86a549f);
            continue;
        }
        t_power setinvisibletoall();
    }
}

