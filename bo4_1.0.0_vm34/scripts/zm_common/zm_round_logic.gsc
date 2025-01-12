#using script_39eae6a6b493fe9e;
#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie_death;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_puppeteer_shared;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\globallogic\globallogic_vehicle;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\killcam_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\potm_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\status_effects\status_effects;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\zm_common\bb;
#using scripts\zm_common\callbacks;
#using scripts\zm_common\callings\zm_callings;
#using scripts\zm_common\gametypes\globallogic;
#using scripts\zm_common\gametypes\globallogic_player;
#using scripts\zm_common\gametypes\globallogic_scriptmover;
#using scripts\zm_common\gametypes\globallogic_spawn;
#using scripts\zm_common\gametypes\zm_gametype;
#using scripts\zm_common\trials\zm_trial_special_enemy;
#using scripts\zm_common\util;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_blockers;
#using scripts\zm_common\zm_cleanup_mgr;
#using scripts\zm_common\zm_crafting;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_daily_challenges;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_ffotd;
#using scripts\zm_common\zm_game_module;
#using scripts\zm_common\zm_hero_weapon;
#using scripts\zm_common\zm_hud;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_melee_weapon;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_placeable_mine;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_quick_spawning;
#using scripts\zm_common\zm_round_spawning;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_wallbuy;
#using scripts\zm_common\zm_weapons;
#using scripts\zm_common\zm_zonemgr;

#namespace zm_round_logic;

// Namespace zm_round_logic/zm_round_logic
// Params 0, eflags: 0x2
// Checksum 0x40dac764, Offset: 0x468
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_round_logic", &__init__, undefined, undefined);
}

// Namespace zm_round_logic/zm_round_logic
// Params 0, eflags: 0x0
// Checksum 0x6da1fc0f, Offset: 0x4b0
// Size: 0xd4
function __init__() {
    level flag::init("round_reset");
    level flag::init(#"trial_failed");
    level flag::init("enable_round_timeout");
    level flag::init("pause_round_timeout");
    level flag::init(#"infinite_round_spawning");
    zm_trial_special_enemy::function_6e25f633(#"zombie", &function_e40790de);
}

// Namespace zm_round_logic/zm_round_logic
// Params 0, eflags: 0x0
// Checksum 0x5f06f6df, Offset: 0x590
// Size: 0x18c
function function_83b0d780() {
    level flag::wait_till_any(array("start_zombie_round_logic", "start_encounters_match_logic"));
    while (true) {
        var_82d7c36d = get_round_number();
        level.round_number = undefined;
        var_fa2cbc15 = var_82d7c36d;
        switch (randomint(5)) {
        case 0:
            var_d42a41ac = var_82d7c36d;
        case 1:
            var_ae27c743 = var_82d7c36d;
        case 2:
            var_88254cda = var_82d7c36d;
        case 3:
            var_6222d271 = var_82d7c36d;
        case 4:
            var_3c205808 = var_82d7c36d;
            break;
        }
        level.round_number = var_82d7c36d;
        var_82d7c36d = undefined;
        var_202f367e = undefined;
        var_fa2cbc15 = undefined;
        var_d42a41ac = undefined;
        var_ae27c743 = undefined;
        var_88254cda = undefined;
        var_6222d271 = undefined;
        var_3c205808 = undefined;
        waitframe(1);
    }
}

// Namespace zm_round_logic/zm_round_logic
// Params 1, eflags: 0x0
// Checksum 0x28af2237, Offset: 0x728
// Size: 0x36
function set_round_number(new_round) {
    if (new_round > 1024) {
        new_round = 1024;
    }
    world.roundnumber = new_round ^ 115;
}

// Namespace zm_round_logic/zm_round_logic
// Params 0, eflags: 0x0
// Checksum 0xd22bc7e6, Offset: 0x768
// Size: 0x14
function get_round_number() {
    return world.roundnumber ^ 115;
}

// Namespace zm_round_logic/zm_round_logic
// Params 0, eflags: 0x0
// Checksum 0x89845661, Offset: 0x788
// Size: 0x182
function function_1e771aec() {
    if (!isdefined(level.var_3319a3d5)) {
        level.var_3319a3d5 = 4;
    }
    if (level.round_number < level.var_3319a3d5) {
        return;
    }
    level endon(#"intermission", #"end_of_round", #"restart_round");
    /#
        level endon(#"kill_round");
    #/
    while (level.zombie_total > 3) {
        wait 3;
    }
    for (a_ai_zombies = zombie_utility::get_round_enemy_array(); a_ai_zombies.size > 0 || level.zombie_total > 0; a_ai_zombies = zombie_utility::get_round_enemy_array()) {
        if (a_ai_zombies.size <= 3) {
            foreach (ai_zombie in a_ai_zombies) {
                ai_zombie thread function_58569eb6();
            }
        }
        wait 1;
    }
}

// Namespace zm_round_logic/zm_round_logic
// Params 0, eflags: 0x4
// Checksum 0xfc8d64ab, Offset: 0x918
// Size: 0x114
function private function_58569eb6() {
    if (isdefined(self.var_824d4e53) && self.var_824d4e53) {
        return;
    }
    self endon(#"death");
    if (isalive(self) && (self.archetype == "zombie" || self.archetype == "catalyst")) {
        self.var_824d4e53 = 1;
        if (self.zombie_move_speed !== "sprint") {
            while (!isdefined(self.favoriteenemy) || distancesquared(self.favoriteenemy.origin, self.origin) < 65536) {
                wait 1;
            }
            self zombie_utility::set_zombie_run_cycle("sprint");
        }
    }
}

// Namespace zm_round_logic/zm_round_logic
// Params 0, eflags: 0x4
// Checksum 0x54c0408f, Offset: 0xa38
// Size: 0xbc
function private function_e40790de() {
    assert(isdefined(level.zombie_spawners));
    spawner = array::random(level.zombie_spawners);
    ai = zombie_utility::spawn_zombie(spawner, spawner.targetname);
    if (isdefined(ai)) {
        if (level.zombie_respawns > 0) {
            level.zombie_respawns--;
            ai.var_be67606 = 1;
        }
        ai thread zombie_utility::round_spawn_failsafe();
        return true;
    }
    return false;
}

// Namespace zm_round_logic/zm_round_logic
// Params 0, eflags: 0x0
// Checksum 0x510011da, Offset: 0xb00
// Size: 0x768
function round_spawning() {
    if (level.zm_loc_types[#"zombie_location"].size < 1) {
        assertmsg("<dev string:x30>");
        return;
    }
    level.zombie_health = zombie_utility::ai_calculate_health(zombie_utility::get_zombie_var(#"zombie_health_start"), level.round_number);
    profilestart();
    level endon(#"intermission", #"end_of_round", #"restart_round");
    /#
        level endon(#"kill_round");
    #/
    if (level.intermission) {
        return;
    }
    if (zm::cheat_enabled(2)) {
        return;
    }
    if (zm_round_spawning::function_6f26880f()) {
        return;
    }
    profilestop();
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i].zombification_time = 0;
    }
    if (!(isdefined(level.kill_counter_hud) && level.zombie_total > 0)) {
        level.zombie_total = get_zombie_count_for_round(level.round_number, level.players.size);
        level.var_229b59d = level.zombie_total;
        level.var_90bfb00c = level.zombie_total;
        level.var_ad508a8d = level.var_1ffbf287;
        level.zombie_respawns = level.var_1ffbf287;
        level.zombie_total += level.var_1ffbf287;
        level notify(#"zombie_total_set");
    }
    var_eecb580c = function_fc0e3ee8(level.round_number, level.players.size);
    if (isdefined(level.zombie_total_set_func)) {
        level thread [[ level.zombie_total_set_func ]]();
    }
    level thread [[ level.var_164af731 ]]();
    zm_round_spawning::function_77a8d740();
    old_spawn = undefined;
    while (true) {
        var_6117c0c3 = zombie_utility::get_current_zombie_count();
        while (var_6117c0c3 >= level.zombie_ai_limit || level.zombie_total <= 0 && !level flag::get(#"infinite_round_spawning")) {
            wait 0.1;
            zm_quick_spawning::function_8817321f();
            var_6117c0c3 = zombie_utility::get_current_zombie_count();
            continue;
        }
        while (zombie_utility::get_current_actor_count() >= level.zombie_actor_limit) {
            zombie_utility::clear_all_corpses();
            wait 0.1;
        }
        if (flag::exists("world_is_paused")) {
            level flag::wait_till_clear("world_is_paused");
        }
        level flag::wait_till("spawn_zombies");
        while (level.zm_loc_types[#"zombie_location"].size <= 0) {
            wait 0.1;
        }
        run_custom_ai_spawn_checks();
        if (isdefined(level.hostmigrationtimer) && level.hostmigrationtimer) {
            util::wait_network_frame();
            continue;
        }
        if (isdefined(level.fn_custom_round_ai_spawn)) {
            if ([[ level.fn_custom_round_ai_spawn ]]()) {
                util::wait_network_frame();
                continue;
            }
        }
        if (zm_round_spawning::function_8f55c671()) {
            util::wait_network_frame();
            continue;
        }
        if (isdefined(level.zombie_spawners)) {
            if (isdefined(level.fn_custom_zombie_spawner_selection)) {
                spawner = [[ level.fn_custom_zombie_spawner_selection ]]();
            } else if (isdefined(level.use_multiple_spawns) && level.use_multiple_spawns) {
                if (isdefined(level.spawner_int) && isdefined(level.zombie_spawn[level.spawner_int].size) && level.zombie_spawn[level.spawner_int].size) {
                    spawner = array::random(level.zombie_spawn[level.spawner_int]);
                } else {
                    spawner = array::random(level.zombie_spawners);
                }
            } else {
                spawner = array::random(level.zombie_spawners);
            }
            ai = zombie_utility::spawn_zombie(spawner, spawner.targetname);
        }
        if (isdefined(ai)) {
            level.zombie_total--;
            if (level.zombie_respawns > 0) {
                level.zombie_respawns--;
                ai.var_be67606 = 1;
            }
            ai thread zombie_utility::round_spawn_failsafe();
            var_6117c0c3++;
            if (ai ai::has_behavior_attribute("can_juke")) {
                ai ai::set_behavior_attribute("can_juke", 0);
            }
            if (level.zombie_respawns > 0) {
                wait 0.1;
            } else if (var_6117c0c3 < var_eecb580c) {
                wait 0.1;
            } else {
                wait isdefined(zombie_utility::get_zombie_var(#"zombie_spawn_delay")) ? zombie_utility::get_zombie_var(#"zombie_spawn_delay") : zombie_utility::get_zombie_var(#"hash_7d5a25e2463f7fc5");
            }
        }
        util::wait_network_frame();
    }
}

// Namespace zm_round_logic/zm_round_logic
// Params 2, eflags: 0x0
// Checksum 0x2a86ac50, Offset: 0x1270
// Size: 0x1ea
function get_zombie_count_for_round(n_round, n_player_count) {
    if (isdefined(level.var_b18a7d0)) {
        n_zombie_count = [[ level.var_b18a7d0 ]](n_round, n_player_count);
        if (n_zombie_count >= 0) {
            return n_zombie_count;
        }
    }
    max = zombie_utility::get_zombie_var(#"zombie_max_ai");
    multiplier = n_round / 5;
    if (multiplier < 1) {
        multiplier = 1;
    }
    if (n_round >= 10) {
        multiplier *= n_round * zombie_utility::get_zombie_var(#"hash_607bc50072c2a386");
    }
    if (n_player_count == 1) {
        max += int(zombie_utility::get_zombie_var(#"hash_67b3cbf79292e047") * zombie_utility::get_zombie_var(#"zombie_ai_per_player") * multiplier);
    } else {
        max += int((n_player_count - 1) * zombie_utility::get_zombie_var(#"zombie_ai_per_player") * multiplier);
    }
    if (!isdefined(level.max_zombie_func)) {
        level.max_zombie_func = &zombie_utility::default_max_zombie_func;
    }
    n_zombie_count = [[ level.max_zombie_func ]](max, n_round);
    return n_zombie_count;
}

// Namespace zm_round_logic/zm_round_logic
// Params 2, eflags: 0x0
// Checksum 0x87bda2b9, Offset: 0x1468
// Size: 0x7c
function function_fc0e3ee8(n_round, n_player_count) {
    if (isdefined(level.var_ff2185d3)) {
        n_zombie_count = [[ level.var_ff2185d3 ]](n_round, n_player_count);
        if (n_zombie_count >= 0) {
            return n_zombie_count;
        }
    }
    return n_player_count + 4 + int(n_round % 2);
}

// Namespace zm_round_logic/zm_round_logic
// Params 0, eflags: 0x0
// Checksum 0x47979f49, Offset: 0x14f0
// Size: 0x514
function run_custom_ai_spawn_checks() {
    foreach (s in level.custom_ai_spawn_check_funcs) {
        if ([[ s.func_check ]]()) {
            a_spawners = [[ s.func_get_spawners ]]();
            level.zombie_spawners = arraycombine(level.zombie_spawners, a_spawners, 0, 0);
            if (isdefined(level.use_multiple_spawns) && level.use_multiple_spawns) {
                foreach (sp in a_spawners) {
                    if (isdefined(sp.script_int)) {
                        if (!isdefined(level.zombie_spawn[sp.script_int])) {
                            level.zombie_spawn[sp.script_int] = [];
                        }
                        if (!isinarray(level.zombie_spawn[sp.script_int], sp)) {
                            if (!isdefined(level.zombie_spawn[sp.script_int])) {
                                level.zombie_spawn[sp.script_int] = [];
                            } else if (!isarray(level.zombie_spawn[sp.script_int])) {
                                level.zombie_spawn[sp.script_int] = array(level.zombie_spawn[sp.script_int]);
                            }
                            level.zombie_spawn[sp.script_int][level.zombie_spawn[sp.script_int].size] = sp;
                        }
                    }
                }
            }
            if (isdefined(s.func_get_locations)) {
                a_locations = [[ s.func_get_locations ]]();
                level.zm_loc_types[#"zombie_location"] = arraycombine(level.zm_loc_types[#"zombie_location"], a_locations, 0, 0);
            }
            continue;
        }
        a_spawners = [[ s.func_get_spawners ]]();
        foreach (sp in a_spawners) {
            arrayremovevalue(level.zombie_spawners, sp);
        }
        if (isdefined(level.use_multiple_spawns) && level.use_multiple_spawns) {
            foreach (sp in a_spawners) {
                if (isdefined(sp.script_int) && isdefined(level.zombie_spawn[sp.script_int])) {
                    arrayremovevalue(level.zombie_spawn[sp.script_int], sp);
                }
            }
        }
        if (isdefined(s.func_get_locations)) {
            a_locations = [[ s.func_get_locations ]]();
            foreach (s_loc in a_locations) {
                arrayremovevalue(level.zm_loc_types[#"zombie_location"], s_loc);
            }
        }
    }
}

// Namespace zm_round_logic/zm_round_logic
// Params 4, eflags: 0x0
// Checksum 0xd45df0a9, Offset: 0x1a10
// Size: 0xb2
function register_custom_ai_spawn_check(str_id, func_check, func_get_spawners, func_get_locations) {
    if (!isdefined(level.custom_ai_spawn_check_funcs[str_id])) {
        level.custom_ai_spawn_check_funcs[str_id] = spawnstruct();
    }
    level.custom_ai_spawn_check_funcs[str_id].func_check = func_check;
    level.custom_ai_spawn_check_funcs[str_id].func_get_spawners = func_get_spawners;
    level.custom_ai_spawn_check_funcs[str_id].func_get_locations = func_get_locations;
}

// Namespace zm_round_logic/zm_round_logic
// Params 0, eflags: 0x0
// Checksum 0xf73707c4, Offset: 0x1ad0
// Size: 0xb6
function round_spawning_test() {
    while (true) {
        spawn_point = array::random(level.zm_loc_types[#"zombie_location"]);
        spawner = array::random(level.zombie_spawners);
        ai = zombie_utility::spawn_zombie(spawner, spawner.targetname, spawn_point);
        ai waittill(#"death");
        wait 5;
    }
}

// Namespace zm_round_logic/zm_round_logic
// Params 0, eflags: 0x0
// Checksum 0xea3cdbdb, Offset: 0x1b90
// Size: 0x284
function round_start() {
    if (!isdefined(level.zombie_spawners) || level.zombie_spawners.size == 0) {
        println("<dev string:x95>");
        level flag::set("begin_spawning");
        return;
    }
    println("<dev string:xc6>");
    if (isdefined(level.var_e9389b68)) {
        [[ level.var_e9389b68 ]]();
    } else {
        n_delay = 2;
        if (isdefined(level.zombie_round_start_delay)) {
            n_delay = level.zombie_round_start_delay;
        }
        wait n_delay;
    }
    if (getdvarint(#"scr_writeconfigstrings", 0) == 1) {
        wait 5;
        exitlevel();
        return;
    }
    level flag::set("begin_spawning");
    if (!isdefined(level.var_164af731)) {
        level.var_164af731 = &function_1e771aec;
    }
    if (!isdefined(level.round_spawn_func)) {
        level.round_spawn_func = &round_spawning;
    }
    if (!isdefined(level.move_spawn_func)) {
        level.move_spawn_func = &zm_utility::move_zombie_spawn_location;
    }
    if (!isdefined(level.var_97009e3f)) {
        level.var_97009e3f = &zm_quick_spawning::function_d379ad4b;
    }
    /#
        if (getdvarint(#"zombie_rise_test", 0)) {
            level.round_spawn_func = &round_spawning_test;
        }
    #/
    if (!isdefined(level.round_wait_func)) {
        level.round_wait_func = &round_wait;
    }
    if (!isdefined(level.round_think_func)) {
        level.round_think_func = &round_think;
    }
    level thread [[ level.round_think_func ]]();
}

// Namespace zm_round_logic/zm_round_logic
// Params 0, eflags: 0x0
// Checksum 0x940120ce, Offset: 0x1e20
// Size: 0x44
function wait_until_first_player() {
    players = getplayers();
    if (!isdefined(players[0])) {
        level waittill(#"first_player_ready");
    }
}

// Namespace zm_round_logic/zm_round_logic
// Params 0, eflags: 0x0
// Checksum 0x5f073998, Offset: 0x1e70
// Size: 0x20c
function round_one_up() {
    level endon(#"end_game");
    if (isdefined(level.noroundnumber) && level.noroundnumber == 1) {
        return;
    }
    if (!isdefined(level.doground_nomusic)) {
        level.doground_nomusic = 0;
    }
    if (level.first_round) {
        intro = 1;
        if (isdefined(level._custom_intro_vox)) {
            level thread [[ level._custom_intro_vox ]]();
        } else {
            level thread play_level_start_vox_delayed();
        }
    } else {
        intro = 0;
    }
    if (level.round_number == 5 || level.round_number == 10 || level.round_number == 20 || level.round_number == 35 || level.round_number == 50) {
        players = getplayers();
        rand = randomintrange(0, players.size);
        players[rand] thread zm_audio::create_and_play_dialog("general", "round_" + level.round_number);
    }
    if (intro) {
        if (isdefined(level.host_ended_game) && level.host_ended_game) {
            return;
        }
        wait 6.25;
        level notify(#"intro_hud_done");
        wait 2;
    } else {
        wait 2.5;
    }
    reportmtu(level.round_number);
}

// Namespace zm_round_logic/zm_round_logic
// Params 0, eflags: 0x0
// Checksum 0x122e0659, Offset: 0x2088
// Size: 0x244
function round_over() {
    if (isdefined(level.noroundnumber) && level.noroundnumber == 1) {
        return;
    }
    time = [[ level.func_get_delay_between_rounds ]]();
    players = getplayers();
    for (player_index = 0; player_index < players.size; player_index++) {
        if (!isdefined(players[player_index].pers[#"previous_distance_traveled"])) {
            players[player_index].pers[#"previous_distance_traveled"] = 0;
        }
        distancethisround = int(players[player_index].pers[#"distance_traveled"] - players[player_index].pers[#"previous_distance_traveled"]);
        players[player_index].pers[#"previous_distance_traveled"] = players[player_index].pers[#"distance_traveled"];
        players[player_index] incrementplayerstat("distance_traveled", distancethisround);
        if (players[player_index].pers[#"team"] != "spectator") {
            players[player_index] recordroundendstats();
        }
    }
    recordzombieroundend();
    level flag::wait_till_any_timeout(time, array("round_reset", #"trial_failed"));
}

// Namespace zm_round_logic/zm_round_logic
// Params 0, eflags: 0x0
// Checksum 0xe269a489, Offset: 0x22d8
// Size: 0x22
function get_delay_between_rounds() {
    return zombie_utility::get_zombie_var(#"zombie_between_round_time");
}

// Namespace zm_round_logic/zm_round_logic
// Params 2, eflags: 0x0
// Checksum 0xda8237c1, Offset: 0x2308
// Size: 0x64
function recordplayerroundweapon(weapon, statname) {
    if (isdefined(weapon)) {
        weaponidx = getbaseweaponitemindex(weapon);
        if (isdefined(weaponidx)) {
            self incrementplayerstat(statname, weaponidx);
        }
    }
}

// Namespace zm_round_logic/zm_round_logic
// Params 2, eflags: 0x0
// Checksum 0x61b3edb1, Offset: 0x2378
// Size: 0x96
function recordprimaryweaponsstats(base_stat_name, max_weapons) {
    current_weapons = self getweaponslistprimaries();
    for (index = 0; index < max_weapons && index < current_weapons.size; index++) {
        recordplayerroundweapon(current_weapons[index], base_stat_name + index);
    }
}

// Namespace zm_round_logic/zm_round_logic
// Params 0, eflags: 0x0
// Checksum 0x3f3f9ee, Offset: 0x2418
// Size: 0xdc
function recordroundstartstats() {
    zonename = self zm_utility::get_current_zone();
    if (isdefined(zonename)) {
        self recordzombiezone("startingZone", zonename);
    }
    self incrementplayerstat("score", self.score);
    primaryweapon = self getcurrentweapon();
    self recordprimaryweaponsstats("roundStartPrimaryWeapon", 3);
    self recordmapevent(8, gettime(), self.origin, level.round_number);
}

// Namespace zm_round_logic/zm_round_logic
// Params 0, eflags: 0x0
// Checksum 0x43d3e9, Offset: 0x2500
// Size: 0x94
function recordroundendstats() {
    zonename = self zm_utility::get_current_zone();
    if (isdefined(zonename)) {
        self recordzombiezone("endingZone", zonename);
    }
    self recordprimaryweaponsstats("roundEndPrimaryWeapon", 3);
    self recordmapevent(9, gettime(), self.origin, level.round_number);
}

// Namespace zm_round_logic/zm_round_logic
// Params 1, eflags: 0x0
// Checksum 0x18bf6dbf, Offset: 0x25a0
// Size: 0xc50
function round_think(restart = 0) {
    println("<dev string:xde>");
    level endon(#"end_round_think");
    level endon(#"end_game");
    if (!(isdefined(restart) && restart)) {
        if (isdefined(level.var_b31c6007)) {
            [[ level.var_b31c6007 ]]();
        }
        if (!(isdefined(level.host_ended_game) && level.host_ended_game)) {
            players = getplayers();
            foreach (player in players) {
                player zm_stats::set_global_stat("rounds", level.round_number);
            }
        }
    }
    setroundsplayed(level.round_number);
    level.var_f6545288 = gettime();
    zm_trial::function_8def5e51();
    callback::callback(#"hash_6df5348c2fb9a509");
    array::thread_all(level.players, &zm_blockers::rebuild_barrier_reward_reset);
    while (true) {
        zombie_utility::set_zombie_var(#"rebuild_barrier_cap_per_round", min(500, 50 * level.round_number));
        level.pro_tips_start_time = gettime();
        level.zombie_last_run_time = gettime();
        if (isdefined(level.var_d58439a1)) {
            level thread zm_audio::function_3aef57a7();
            [[ level.var_d58439a1 ]]();
        } else {
            level thread zm_audio::function_3aef57a7();
            round_one_up();
        }
        zm_powerups::powerup_round_start();
        if (!(isdefined(level.headshots_only) && level.headshots_only) && !restart) {
            level thread award_grenades_for_survivors();
        }
        println("<dev string:xf6>" + level.round_number + "<dev string:x110>" + level.players.size);
        level.round_start_time = gettime();
        while (level.zm_loc_types[#"zombie_location"].size <= 0) {
            wait 0.1;
        }
        /#
            zkeys = getarraykeys(level.zones);
            for (i = 0; i < zkeys.size; i++) {
                zonename = zkeys[i];
                level.zones[zonename].round_spawn_count = 0;
            }
        #/
        if (!(isdefined(level.var_95f84779) && level.var_95f84779)) {
            level thread round_timeout();
        }
        level thread [[ level.round_spawn_func ]]();
        level notify(#"start_of_round", {#n_round_number:level.round_number});
        recordnumzombierounds(level.round_number - 1);
        recordzombieroundstart();
        bb::logroundevent("start_of_round");
        players = getplayers();
        for (index = 0; index < players.size; index++) {
            players[index] recordroundstartstats();
        }
        if (isdefined(level.round_start_custom_func)) {
            [[ level.round_start_custom_func ]]();
        }
        [[ level.round_wait_func ]]();
        level thread zm_audio::function_a08f940c();
        level.first_round = 0;
        zm_trial::on_round_end();
        callback::callback(#"on_round_end");
        level notify(#"end_of_round");
        bb::logroundevent("end_of_round");
        uploadstats();
        if (isdefined(level.round_end_custom_logic)) {
            [[ level.round_end_custom_logic ]]();
        }
        if (!level flag::get("round_reset") && zm_custom::function_5638f689(#"zmroundcap") == level.round_number && level.round_number != 0) {
            wait 3;
            zm_custom::function_c4cdc40c("zmRoundCap");
            return;
        }
        assert(level.players.size == getplayers().size);
        if (level.players.size > 1 && !level flag::get("round_reset")) {
            level thread zm_player::spectators_respawn();
        }
        if (int(level.round_number / 5) * 5 == level.round_number) {
            level clientfield::set("round_complete_time", int((level.time - level.n_gameplay_start_time + 500) / 1000));
            level clientfield::set("round_complete_num", level.round_number);
        }
        if (level flag::get("round_reset")) {
            if (isdefined(level.var_8f0efe80)) {
                [[ level.var_8f0efe80 ]]();
            }
        } else {
            set_round_number(1 + get_round_number());
        }
        setroundsplayed(get_round_number());
        zombie_utility::set_zombie_var(#"zombie_spawn_delay", [[ level.func_get_zombie_spawn_delay ]](get_round_number()));
        matchutctime = getutc();
        players = getplayers();
        foreach (player in players) {
            if (level.curr_gametype_affects_rank && get_round_number() > 3 + level.start_round) {
                player zm_stats::add_client_stat("weighted_rounds_played", get_round_number());
            }
            player zm_stats::set_global_stat("rounds", get_round_number());
            player zm_stats::update_playing_utc_time(matchutctime);
            if (!(isdefined(zm_custom::function_5638f689(#"zmhealthdrain")) && zm_custom::function_5638f689(#"zmhealthdrain"))) {
                player zm_utility::set_max_health(1);
            }
            for (i = 0; i < 4; i++) {
                player.number_revives_per_round[i] = 0;
            }
            if (isalive(player) && player.sessionstate != "spectator" && !(isdefined(level.skip_alive_at_round_end_xp) && level.skip_alive_at_round_end_xp) && !level flag::get("round_reset")) {
                player zm_stats::increment_challenge_stat("SURVIVALIST_SURVIVE_ROUNDS");
                player zm_callings::function_7cafbdd3(21);
                score_number = get_round_number() - 1;
                if (score_number < 1) {
                    score_number = 1;
                } else if (score_number > 20) {
                    score_number = 20;
                }
                scoreevents::processscoreevent("alive_at_round_end_" + score_number, player);
            }
        }
        level.round_number = get_round_number();
        level flag::clear("round_reset");
        zm_trial::function_8def5e51();
        callback::callback(#"hash_6df5348c2fb9a509");
        array::thread_all(level.players, &zm_blockers::rebuild_barrier_reward_reset);
        level round_over();
        level notify(#"between_round_over");
        level.skip_alive_at_round_end_xp = 0;
        restart = 0;
    }
}

// Namespace zm_round_logic/zm_round_logic
// Params 0, eflags: 0x0
// Checksum 0xd1d57851, Offset: 0x31f8
// Size: 0x26c
function round_timeout() {
    level endon(#"end_of_round", #"end_game");
    level waittill(#"zombie_total_set");
    level.var_1ffbf287 = 0;
    if (level.round_number < 6) {
        level flag::wait_till_any(array("power_on", "enable_round_timeout"));
    }
    while (level.zombie_total > 0) {
        wait 1;
    }
    n_timeout = isdefined(level.var_e40174fb) ? level.var_e40174fb : 300;
    var_45ff82f4 = zombie_utility::get_current_zombie_count();
    var_760e03bc = var_45ff82f4;
    var_ecf0603a = isdefined(level.var_e702e62f) ? level.var_e702e62f : 20;
    while (n_timeout > 0 && var_ecf0603a > 0) {
        if (!level flag::get("pause_round_timeout")) {
            n_timeout--;
            if (isdefined(level.var_1c2b792c) && level.var_1c2b792c) {
                if (var_760e03bc == var_45ff82f4) {
                    var_ecf0603a--;
                } else {
                    var_ecf0603a = isdefined(level.var_135134e0) ? level.var_135134e0 : 20;
                }
            }
        }
        wait 1;
        var_45ff82f4 = var_760e03bc;
        var_760e03bc = zombie_utility::get_current_zombie_count();
    }
    level flag::wait_till_clear("pause_round_timeout");
    level thread zm_cleanup::function_c831bc22(1);
    level callback::on_round_end(&function_2a449730);
    level flag::set("end_round_wait");
}

// Namespace zm_round_logic/zm_round_logic
// Params 0, eflags: 0x0
// Checksum 0x748fe076, Offset: 0x3470
// Size: 0x44
function function_2a449730() {
    level flag::clear("end_round_wait");
    level callback::remove_on_round_end(&function_2a449730);
}

// Namespace zm_round_logic/zm_round_logic
// Params 0, eflags: 0x0
// Checksum 0x56ba9f74, Offset: 0x34c0
// Size: 0xc6
function award_grenades_for_survivors() {
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (!players[i].is_zombie && !(isdefined(players[i].altbody) && players[i].altbody) && !players[i] laststand::player_is_in_laststand()) {
            players[i] thread zm_weapons::function_f9d6b75e();
        }
    }
}

// Namespace zm_round_logic/zm_round_logic
// Params 1, eflags: 0x0
// Checksum 0xf7bff9e6, Offset: 0x3590
// Size: 0x19c
function get_zombie_spawn_delay(n_round) {
    if (n_round > 60) {
        n_round = 60;
    }
    switch (level.players.size) {
    case 1:
        n_delay = zombie_utility::get_zombie_var(#"hash_7d5a25e2463f7fc5");
        break;
    case 2:
        n_delay = zombie_utility::get_zombie_var(#"hash_7d5a25e2463f7fc5") * 0.75;
        break;
    case 3:
        n_delay = zombie_utility::get_zombie_var(#"hash_7d5a25e2463f7fc5") * 0.445;
        break;
    case 4:
        n_delay = zombie_utility::get_zombie_var(#"hash_7d5a25e2463f7fc5") * 0.335;
        break;
    }
    for (i = 1; i < n_round; i++) {
        n_delay *= 0.95;
        if (n_delay <= 0.1) {
            n_delay = 0.1;
            break;
        }
    }
    return n_delay;
}

/#

    // Namespace zm_round_logic/zm_round_logic
    // Params 0, eflags: 0x0
    // Checksum 0x60b6b98f, Offset: 0x3738
    // Size: 0xa8
    function round_spawn_failsafe_debug() {
        level notify(#"failsafe_debug_stop");
        level endon(#"failsafe_debug_stop");
        start = gettime();
        level.chunk_time = 0;
        while (true) {
            level.failsafe_time = gettime() - start;
            if (isdefined(self.lastchunk_destroy_time)) {
                level.chunk_time = gettime() - self.lastchunk_destroy_time;
            }
            util::wait_network_frame();
        }
    }

    // Namespace zm_round_logic/zm_round_logic
    // Params 0, eflags: 0x0
    // Checksum 0xd205156, Offset: 0x37e8
    // Size: 0x164
    function print_zombie_counts() {
        while (true) {
            if (getdvarint(#"zombiemode_debug_zombie_count", 0)) {
                if (!isdefined(level.debug_zombie_count_hud)) {
                    level.debug_zombie_count_hud = newdebughudelem();
                    level.debug_zombie_count_hud.alignx = "<dev string:x120>";
                    level.debug_zombie_count_hud.x = 100;
                    level.debug_zombie_count_hud.y = 10;
                    level.debug_zombie_count_hud settext("<dev string:x126>");
                }
                currentcount = zombie_utility::get_current_zombie_count();
                number_to_kill = level.zombie_total;
                level.debug_zombie_count_hud settext("<dev string:x12d>" + currentcount + "<dev string:x134>" + number_to_kill);
            } else if (isdefined(level.debug_zombie_count_hud)) {
                level.debug_zombie_count_hud destroy();
                level.debug_zombie_count_hud = undefined;
            }
            wait 0.1;
        }
    }

#/

// Namespace zm_round_logic/zm_round_logic
// Params 0, eflags: 0x0
// Checksum 0x6e009d30, Offset: 0x3958
// Size: 0x1d2
function round_wait() {
    level endon(#"restart_round");
    /#
        level endon(#"kill_round");
        if (getdvarint(#"zombie_rise_test", 0)) {
            level waittill(#"forever");
        }
    #/
    if (zm::cheat_enabled(2)) {
        level waittill(#"forever");
    }
    /#
        if (getdvarint(#"zombie_default_max", 0) == 0) {
            level waittill(#"forever");
        }
    #/
    wait 1;
    /#
        level thread print_zombie_counts();
        level thread sndmusiconkillround();
    #/
    while (true) {
        if (zombie_utility::get_current_zombie_count() == 0 && level.zombie_total <= 0 && !level.intermission && !level flag::get(#"infinite_round_spawning")) {
            return;
        }
        if (level flag::get("end_round_wait")) {
            return;
        }
        if (level flag::get("round_reset")) {
            return;
        }
        wait 1;
    }
}

// Namespace zm_round_logic/zm_round_logic
// Params 0, eflags: 0x0
// Checksum 0xcf6388c5, Offset: 0x3b38
// Size: 0x54
function sndmusiconkillround() {
    level endon(#"end_of_round");
    level waittill(#"kill_round");
    level thread zm_audio::sndmusicsystem_playstate("round_end");
}

// Namespace zm_round_logic/zm_round_logic
// Params 0, eflags: 0x0
// Checksum 0xb70f70d2, Offset: 0x3b98
// Size: 0x74
function play_level_start_vox_delayed() {
    wait 3;
    players = getplayers();
    num = randomintrange(0, players.size);
    players[num] zm_audio::create_and_play_dialog("general", "intro");
}

