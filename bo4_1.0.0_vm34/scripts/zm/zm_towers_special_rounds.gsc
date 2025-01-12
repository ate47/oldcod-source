#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm\zm_towers;
#using scripts\zm_common\util\ai_gladiator_util;
#using scripts\zm_common\util\ai_tiger_util;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_round_logic;
#using scripts\zm_common\zm_round_spawning;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_zonemgr;

#namespace zm_towers_special_rounds;

// Namespace zm_towers_special_rounds/zm_towers_special_rounds
// Params 0, eflags: 0x0
// Checksum 0x1ef385d8, Offset: 0x370
// Size: 0x37c
function init() {
    level.var_dc8d88bb = 0;
    level.var_abef2fdd = 0;
    level.var_a320d973 = &function_9bf7d80f;
    level.tiger_on_spawned = &function_3683fdb;
    level.var_68e5fb1f = &function_36dc5475;
    spawner::add_archetype_spawn_function("gladiator", &function_41d0596b);
    level.var_42fa950e = getentarray("special_round_gate", "targetname");
    var_a92e442c = getent("arena_gate_east", "targetname");
    var_4124442 = getent("arena_gate_west", "targetname");
    var_ef5484f = getent("arena_gate_east_clip", "targetname");
    var_fa9930fd = getent("arena_gate_west_clip", "targetname");
    var_ef5484f linkto(var_a92e442c);
    var_fa9930fd linkto(var_4124442);
    array::add(level.var_42fa950e, var_a92e442c, 0);
    array::add(level.var_42fa950e, var_4124442, 0);
    function_ddd6f721("tiger_spawn_0", 4);
    function_ddd6f721("obelisk_tiger_0", 4);
    level waittill(#"all_players_spawned");
    level flag::init(#"hash_1baa9fb772fb9175");
    if (!zm_utility::is_standard()) {
        zm_round_spawning::function_6f7eee39(&function_a3617c42);
        zm_round_spawning::function_2b3870c9("tiger", 6);
        zm_round_spawning::function_c9b9ab96("catalyst", 7);
        zm_round_spawning::function_2b3870c9("gladiator_marauder", 8);
        zm_round_spawning::function_2b3870c9("gladiator_destroyer", 10);
        zm_round_spawning::function_2b3870c9("blight_father", 15);
        zm_round_spawning::function_5788a6e7("tiger", 9, &function_829f0562, &function_617c2489, &function_641b031f, &zombie_tiger_util::function_500a498e);
        level thread function_c07e2145();
    }
}

// Namespace zm_towers_special_rounds/zm_towers_special_rounds
// Params 0, eflags: 0x0
// Checksum 0x2dd1aab2, Offset: 0x6f8
// Size: 0x156
function function_c07e2145() {
    level endon(#"end_game");
    level flag::wait_till("all_players_spawned");
    while (true) {
        if (level.zombie_total == 0) {
            a_ai = getaiarray();
            if (a_ai.size == 1) {
                if (a_ai[0].archetype == "tiger") {
                    if (!a_ai[0] ai::get_behavior_attribute("sprint")) {
                        a_ai[0] ai::set_behavior_attribute("sprint", 1);
                    }
                } else if (a_ai[0].archetype == "gladiator") {
                    if (!a_ai[0] ai::get_behavior_attribute("run")) {
                        a_ai[0] ai::set_behavior_attribute("run", 1);
                    }
                }
            }
        }
        waitframe(1);
    }
}

// Namespace zm_towers_special_rounds/zm_towers_special_rounds
// Params 2, eflags: 0x0
// Checksum 0xf4e53004, Offset: 0x858
// Size: 0xa6
function function_ddd6f721(str_prefix, n_count) {
    for (i = 1; i <= n_count; i++) {
        var_5c0bccd0 = getent(str_prefix + i, "targetname");
        if (isdefined(var_5c0bccd0)) {
            var_5c0bccd0.script_vector = (0, 0, 45);
            array::add(level.var_42fa950e, var_5c0bccd0, 0);
        }
    }
}

// Namespace zm_towers_special_rounds/zm_towers_special_rounds
// Params 0, eflags: 0x0
// Checksum 0x155c1ee6, Offset: 0x908
// Size: 0x2fc
function function_9bf7d80f() {
    if (level flag::get("special_round")) {
        e_target_player = zm_utility::function_c0225f18();
        while (!isdefined(e_target_player)) {
            e_target_player = zm_utility::function_c0225f18();
            waitframe(1);
        }
        e_target_player.hunted_by++;
        a_locs = struct::get_array("special_round_location", "script_noteworthy");
        a_closest = arraysortclosest(a_locs, e_target_player.origin);
        a_str_active_zones = zm_zonemgr::get_active_zone_names();
        if (a_str_active_zones.size == 0) {
            return a_closest[0];
        }
        for (i = 0; i < a_closest.size; i++) {
            s_closest = a_closest[i];
            str_zone = isdefined(s_closest.script_zone) ? s_closest.script_zone : s_closest.zone_name;
            if (isdefined(str_zone)) {
                str_zone = hash(str_zone);
                if (isinarray(a_str_active_zones, str_zone) && !(isdefined(s_closest.b_cooldown) && s_closest.b_cooldown)) {
                    s_closest.b_cooldown = 1;
                    s_closest thread function_7ce1b70b();
                    return s_closest;
                }
            } else if (zm_utility::check_point_in_enabled_zone(s_closest.origin, 1, undefined) && !(isdefined(s_closest.b_cooldown) && s_closest.b_cooldown)) {
                s_closest.b_cooldown = 1;
                s_closest thread function_7ce1b70b();
                return s_closest;
            }
            if (i == a_closest.size) {
                return a_closest[0];
            }
        }
        return;
    }
    if (isdefined(level.zm_loc_types[#"tiger_location"]) && level.zm_loc_types[#"tiger_location"].size) {
        return array::random(level.zm_loc_types[#"tiger_location"]);
    }
}

// Namespace zm_towers_special_rounds/zm_towers_special_rounds
// Params 1, eflags: 0x0
// Checksum 0xa8cb0874, Offset: 0xc10
// Size: 0x21e
function function_d71029ad(var_d72bfa3e = 1) {
    a_locs = struct::get_array("special_round_location", "script_noteworthy");
    a_locs = array::randomize(a_locs);
    a_str_active_zones = zm_zonemgr::get_active_zone_names();
    if (a_str_active_zones.size == 0) {
        return a_locs[0];
    }
    for (i = 0; i < a_locs.size - 1; i++) {
        s_loc = a_locs[i];
        str_zone = s_loc.script_zone;
        if (var_d72bfa3e || !var_d72bfa3e && !(isdefined(s_loc.var_a95c1df3) && s_loc.var_a95c1df3)) {
            if (isdefined(str_zone)) {
                str_zone = hash(str_zone);
                if (isinarray(a_str_active_zones, str_zone) && !(isdefined(s_loc.b_cooldown) && s_loc.b_cooldown)) {
                    s_loc.b_cooldown = 1;
                    s_loc thread function_7ce1b70b();
                    return s_loc;
                }
            } else if (zm_utility::check_point_in_enabled_zone(s_loc.origin, 1, undefined) && !(isdefined(s_loc.b_cooldown) && s_loc.b_cooldown)) {
                return s_loc;
            }
        }
        if (i == a_locs.size) {
            return a_locs[0];
        }
    }
}

// Namespace zm_towers_special_rounds/zm_towers_special_rounds
// Params 0, eflags: 0x0
// Checksum 0x2b143d7b, Offset: 0xe38
// Size: 0x16
function function_7ce1b70b() {
    wait 2;
    self.b_cooldown = 0;
}

// Namespace zm_towers_special_rounds/zm_towers_special_rounds
// Params 0, eflags: 0x0
// Checksum 0xee9295b4, Offset: 0xe58
// Size: 0x2c
function function_829f0562() {
    level notify(#"hash_21672c4f6ccf13d0");
    level thread function_85c80649();
}

// Namespace zm_towers_special_rounds/zm_towers_special_rounds
// Params 1, eflags: 0x0
// Checksum 0x9673b8ce, Offset: 0xe90
// Size: 0x1bc
function function_617c2489(var_1569ac92) {
    if (var_1569ac92) {
        level.var_dc8d88bb++;
        for (var_b54144f2 = math::clamp(level.round_number + randomintrange(3, 5), 9, 255); isinarray(level.var_7698c308, var_b54144f2); var_b54144f2++) {
        }
        println("<dev string:x30>" + var_b54144f2);
        if (zm_utility::is_standard()) {
            zm_round_spawning::function_5788a6e7("tiger", var_b54144f2, &function_829f0562, &function_617c2489, &function_641b031f, &zombie_tiger_util::function_500a498e);
        } else {
            zm_round_spawning::function_5788a6e7("gladiator_destroyer", var_b54144f2, &function_9975124, &function_151232ef, &function_abef2fdd, &zombie_gladiator_util::function_14e58f78);
        }
    }
    level notify(#"hash_7b9245ff51f3d4f7");
    level function_5c9925c8();
    level thread function_77e74840();
}

// Namespace zm_towers_special_rounds/zm_towers_special_rounds
// Params 0, eflags: 0x0
// Checksum 0xa8820e98, Offset: 0x1058
// Size: 0x60
function function_641b031f() {
    players = getplayers();
    if (level.var_dc8d88bb <= 1) {
        n_max = players.size * 5;
    } else {
        n_max = players.size * 7;
    }
    return n_max;
}

// Namespace zm_towers_special_rounds/zm_towers_special_rounds
// Params 1, eflags: 0x0
// Checksum 0x14118a7f, Offset: 0x10c0
// Size: 0x18e
function function_3683fdb(spot) {
    if (isdefined(spot.var_c08b8290) && spot.var_c08b8290) {
        return;
    }
    self endon(#"death");
    if (isdefined(spot.var_7a0a5fef)) {
        self.var_7a0a5fef = spot.var_7a0a5fef;
    }
    str_gate = spot.script_gate;
    if (!level flag::get("special_round")) {
        if (isdefined(str_gate)) {
            mdl_gate = getent(spot.script_gate, "script_gate");
            if (!isdefined(mdl_gate)) {
                mdl_gate = getent(spot.script_gate, "targetname");
            }
            self thread function_818cee31(mdl_gate);
        }
    }
    if (!isdefined(spot.scriptbundlename)) {
        if (isdefined(mdl_gate)) {
            self thread function_c8ab13c0(mdl_gate);
        }
        return;
    }
    self.var_da4cbdc4 = 1;
    self scene::play(spot.scriptbundlename, self);
    self.var_da4cbdc4 = undefined;
    self notify(#"hash_1d525fe23da088ca");
}

// Namespace zm_towers_special_rounds/zm_towers_special_rounds
// Params 0, eflags: 0x0
// Checksum 0x966aac89, Offset: 0x1258
// Size: 0x2c
function function_9975124() {
    level notify(#"hash_21672c4f6ccf13d0");
    level thread function_85c80649();
}

// Namespace zm_towers_special_rounds/zm_towers_special_rounds
// Params 1, eflags: 0x0
// Checksum 0x9fce76b2, Offset: 0x1290
// Size: 0x1c4
function function_151232ef(var_1569ac92) {
    if (var_1569ac92) {
        level.var_abef2fdd++;
        for (var_b54144f2 = level.round_number + randomintrange(3, 5); isinarray(level.var_7698c308, var_b54144f2); var_b54144f2++) {
        }
        println("<dev string:x30>" + var_b54144f2);
        if (level.var_abef2fdd > 1) {
            zm_round_spawning::function_5788a6e7(array("gladiator_marauder", "gladiator_destroyer", "tiger"), var_b54144f2, &function_9975124, &function_151232ef, &function_abef2fdd, &zombie_gladiator_util::function_14e58f78);
        } else {
            zm_round_spawning::function_5788a6e7("gladiator_marauder", var_b54144f2, &function_9975124, &function_151232ef, &function_abef2fdd, &zombie_gladiator_util::function_14e58f78);
        }
    }
    level notify(#"hash_7b9245ff51f3d4f7");
    level function_5c9925c8();
    level thread function_77e74840();
}

// Namespace zm_towers_special_rounds/zm_towers_special_rounds
// Params 0, eflags: 0x0
// Checksum 0x4f91a50d, Offset: 0x1460
// Size: 0x5e
function function_abef2fdd() {
    players = getplayers();
    if (level.var_abef2fdd < 1) {
        n_max = players.size * 2;
    } else {
        n_max = players.size * 4;
    }
    return n_max;
}

// Namespace zm_towers_special_rounds/zm_towers_special_rounds
// Params 0, eflags: 0x0
// Checksum 0xc4252a83, Offset: 0x14c8
// Size: 0x88
function function_41d0596b() {
    self waittill(#"death");
    if (!(isdefined(self.var_64d09bee) && self.var_64d09bee)) {
        return;
    }
    if (zombie_utility::get_current_zombie_count() == 0 && level.zombie_total == 0) {
        level.var_e6d50548 = self.origin;
        level notify(#"hash_4904386846dd2cec");
    }
}

// Namespace zm_towers_special_rounds/zm_towers_special_rounds
// Params 1, eflags: 0x0
// Checksum 0xa77084e, Offset: 0x1558
// Size: 0x192
function function_36dc5475(spot) {
    if (isdefined(spot.var_c08b8290) && spot.var_c08b8290) {
        return;
    }
    self endon(#"death");
    str_scene = spot.var_b51e9cab;
    if (self.var_ea94c12a === "gladiator_marauder") {
        str_scene = spot.var_250f1dfd;
    }
    if (!isdefined(str_scene) && isdefined(spot.script_gate) && !level flag::get("special_round")) {
        mdl_gate = getent(spot.script_gate, "script_gate");
        if (isdefined(mdl_gate)) {
            self thread function_818cee31(mdl_gate);
            self thread function_c8ab13c0(mdl_gate);
        }
        return;
    }
    if (!isdefined(self.var_da4cbdc4)) {
        var_35c04ecd = 1;
        self.var_da4cbdc4 = 1;
    }
    level scene::play(str_scene, self);
    self notify(#"hash_7ff69a201a93f099");
    if (isdefined(var_35c04ecd) && var_35c04ecd) {
        self.var_da4cbdc4 = undefined;
    }
}

// Namespace zm_towers_special_rounds/zm_towers_special_rounds
// Params 0, eflags: 0x0
// Checksum 0x620b780c, Offset: 0x16f8
// Size: 0x60
function function_eb0dc73b() {
    players = getplayers();
    if (level.var_abef2fdd <= 2) {
        n_max = players.size * 3;
    } else {
        n_max = players.size * 5;
    }
    return n_max;
}

// Namespace zm_towers_special_rounds/zm_towers_special_rounds
// Params 1, eflags: 0x0
// Checksum 0x4c4c3952, Offset: 0x1760
// Size: 0x41c
function function_85c80649(var_208893b = 0) {
    if (level flag::get(#"hash_1baa9fb772fb9175")) {
        return;
    }
    level flag::set(#"hash_1baa9fb772fb9175");
    level exploder::exploder("fx8_exp_blaze_vista");
    callback::on_ai_killed(&function_bf2bf2dd);
    var_70b68f59 = 1;
    if (var_208893b) {
        var_70b68f59 = 2;
        exploder::exploder("exp_special_storm");
    }
    foreach (player in level.players) {
        if (zm_utility::is_player_valid(player, 0, 1)) {
            player clientfield::set_to_player("special_round_camera", var_70b68f59);
        }
    }
    exploder::exploder("exp_lgt_special_round");
    if (!var_208893b) {
        level clientfield::set("special_round_smoke", 1);
    }
    foreach (e_gate in level.var_42fa950e) {
        v_amount = vectorscale(e_gate.script_vector, 1);
        e_gate moveto(e_gate.origin + v_amount, 1);
        if (isdefined(e_gate.targetname) && (e_gate.targetname == "arena_gate_east" || e_gate.targetname == "arena_gate_west")) {
            e_gate playsound(#"hash_1259041350e5f60d");
            continue;
        }
        e_gate playsound(#"hash_75a2099e8df5a448");
    }
    var_be1ed6a6 = struct::get_array("special_round_smoke");
    foreach (s_loc in var_be1ed6a6) {
        s_loc.var_c2dfc61b = util::spawn_model("tag_origin", s_loc.origin);
        s_loc.var_c2dfc61b thread function_19ecbc3a(var_208893b);
    }
    level thread zm_audio::sndannouncerplayvox(#"special_round_start");
    level scene::play("special_round_drummers", "targetname");
}

// Namespace zm_towers_special_rounds/zm_towers_special_rounds
// Params 1, eflags: 0x0
// Checksum 0xdafa611a, Offset: 0x1b88
// Size: 0x39c
function function_5c9925c8(var_208893b = 0) {
    if (!level flag::get(#"hash_1baa9fb772fb9175")) {
        return;
    }
    level flag::clear(#"hash_1baa9fb772fb9175");
    exploder::exploder_stop("fx8_exp_blaze_vista");
    callback::remove_on_ai_killed(&function_bf2bf2dd);
    foreach (player in level.players) {
        player clientfield::set_to_player("special_round_camera", 0);
    }
    if (var_208893b) {
        exploder::exploder_stop("exp_special_storm");
    }
    var_be1ed6a6 = struct::get_array("special_round_smoke");
    exploder::stop_exploder("exp_lgt_special_round");
    foreach (e_gate in level.var_42fa950e) {
        if (isdefined(e_gate.script_vector)) {
            v_amount = vectorscale(e_gate.script_vector, -1);
            e_gate moveto(e_gate.origin + v_amount, 1);
            if (isdefined(e_gate.targetname) && (e_gate.targetname == "arena_gate_east" || e_gate.targetname == "arena_gate_west")) {
                e_gate playsound(#"hash_35413bdf3d48cfa7");
                continue;
            }
            e_gate playsound(#"hash_40e8e3be1a559184");
        }
    }
    foreach (s_loc in var_be1ed6a6) {
        if (isdefined(s_loc.var_c2dfc61b)) {
            s_loc.var_c2dfc61b delete();
        }
    }
    if (!var_208893b) {
        level clientfield::set("special_round_smoke", 0);
    }
    level scene::init("special_round_drummers", "targetname");
}

// Namespace zm_towers_special_rounds/zm_towers_special_rounds
// Params 1, eflags: 0x0
// Checksum 0x40bd8d3e, Offset: 0x1f30
// Size: 0x2c
function function_bf2bf2dd(s_params) {
    level exploder::exploder("fx8_exp_blaze_kill");
}

// Namespace zm_towers_special_rounds/zm_towers_special_rounds
// Params 1, eflags: 0x0
// Checksum 0xd856e53f, Offset: 0x1f68
// Size: 0x252
function function_19ecbc3a(var_e8980de7 = 0) {
    level endon(#"hash_7b9245ff51f3d4f7");
    self endon(#"death");
    if (!var_e8980de7) {
        var_95e6c12e = getstatuseffect("dot_corrosive_catalyst");
    }
    while (true) {
        trigger_midpoint = self.origin + (0, 0, 72);
        foreach (player in level.players) {
            if (isalive(player) && distancesquared(player.origin, self.origin) <= 128 * 128 && (abs(player.origin[2] - trigger_midpoint[2]) <= 36 || abs(player geteye()[2] - trigger_midpoint[2]) <= 36)) {
                if (!var_e8980de7) {
                    player status_effect::status_effect_apply(var_95e6c12e, undefined, self, 1);
                }
                if (!(isdefined(player.var_917e67a1) && player.var_917e67a1)) {
                    player.var_917e67a1 = 1;
                    player thread function_8351cb05(self);
                }
            }
        }
        waitframe(1);
    }
}

// Namespace zm_towers_special_rounds/zm_towers_special_rounds
// Params 1, eflags: 0x0
// Checksum 0xd406c6a2, Offset: 0x21c8
// Size: 0xfa
function function_8351cb05(s_source) {
    self endon(#"disconnect");
    self dodamage(25, s_source.origin);
    var_547a488d = getent("vol_spawn_area", "targetname");
    vol_opposite_tunnel = getent("vol_opposite_tunnel", "targetname");
    n_delay = 0.666;
    if (self istouching(var_547a488d) || self istouching(vol_opposite_tunnel)) {
        n_delay = 0.1;
    }
    wait n_delay;
    self.var_917e67a1 = 0;
}

// Namespace zm_towers_special_rounds/zm_towers_special_rounds
// Params 0, eflags: 0x0
// Checksum 0x30981512, Offset: 0x22d0
// Size: 0x126
function function_cb8deade() {
    while (true) {
        while (self.var_ac3db3b == 0) {
            waitframe(1);
        }
        v_amount = vectorscale(self.script_vector, 1);
        self moveto(self.origin + v_amount, 1);
        self playsound(#"hash_75a2099e8df5a448");
        self waittill(#"movedone");
        while (self.var_ac3db3b > 0) {
            waitframe(1);
        }
        v_amount = vectorscale(self.script_vector, -1);
        self moveto(self.origin + v_amount, 1);
        self playsound(#"hash_40e8e3be1a559184");
        self waittill(#"movedone");
    }
}

// Namespace zm_towers_special_rounds/zm_towers_special_rounds
// Params 1, eflags: 0x0
// Checksum 0x76427113, Offset: 0x2400
// Size: 0x78
function function_818cee31(mdl_gate) {
    if (!isdefined(mdl_gate.var_ac3db3b)) {
        mdl_gate.var_ac3db3b = 0;
        mdl_gate thread function_cb8deade();
    }
    mdl_gate.var_ac3db3b++;
    self waittill(#"death", #"hash_1d525fe23da088ca");
    mdl_gate.var_ac3db3b--;
}

// Namespace zm_towers_special_rounds/zm_towers_special_rounds
// Params 1, eflags: 0x0
// Checksum 0x3eac1783, Offset: 0x2480
// Size: 0xb6
function function_c8ab13c0(mdl_gate) {
    self endoncallback(&function_99097712, #"death");
    vol_gate = getent(mdl_gate.target, "targetname");
    while (!self istouching(vol_gate)) {
        waitframe(1);
    }
    while (self istouching(vol_gate)) {
        waitframe(1);
    }
    self notify(#"hash_1d525fe23da088ca");
}

// Namespace zm_towers_special_rounds/zm_towers_special_rounds
// Params 1, eflags: 0x0
// Checksum 0x1895773b, Offset: 0x2540
// Size: 0x1e
function function_99097712(notifyhash) {
    self notify(#"hash_1d525fe23da088ca");
}

// Namespace zm_towers_special_rounds/zm_towers_special_rounds
// Params 1, eflags: 0x0
// Checksum 0xc70456bd, Offset: 0x2568
// Size: 0x11c
function function_a3617c42(var_5d020ece) {
    var_939d583d = self.origin;
    var_66e5e32c = getentarray("spawn_closet", "script_string");
    foreach (e_volume in var_66e5e32c) {
        if (istouching(var_939d583d, e_volume)) {
            s_loc = struct::get(e_volume.target);
            var_939d583d = s_loc.origin;
        }
    }
    level thread zm_powerups::specific_powerup_drop("full_ammo", var_939d583d);
}

// Namespace zm_towers_special_rounds/zm_towers_special_rounds
// Params 0, eflags: 0x0
// Checksum 0x89a8be06, Offset: 0x2690
// Size: 0x17e
function function_77e74840() {
    var_547a488d = getent("vol_spawn_area", "targetname");
    vol_opposite_tunnel = getent("vol_opposite_tunnel", "targetname");
    foreach (e_player in util::get_active_players()) {
        if (e_player istouching(var_547a488d) || e_player istouching(vol_opposite_tunnel)) {
            e_player val::set(#"hash_70238d97120b1850", "takedamage", 1);
            e_player zm_laststand::function_7996dd34(0);
            e_player dodamage(e_player.health + 1000, e_player.origin);
            e_player.bleedout_time = 0;
        }
    }
}

