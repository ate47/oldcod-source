#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\archetype_catalyst;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\ai\systems\behavior_state_machine;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\trials\zm_trial_special_enemy;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_behavior;
#using scripts\zm_common\zm_cleanup_mgr;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_round_spawning;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_transformation;
#using scripts\zm_common\zm_utility;

#namespace zm_ai_catalyst;

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x6
// Checksum 0x98f217e7, Offset: 0x678
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_ai_catalyst", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x5 linked
// Checksum 0x7d837ce1, Offset: 0x6c0
// Size: 0x544
function private function_70a657d8() {
    registerbehaviorscriptfunctions();
    if (!isarchetypeloaded(#"catalyst")) {
        return;
    }
    archetypecatalyst::function_8f9b9d24(0, &function_d422ab54);
    archetypecatalyst::function_8f9b9d24(1, &function_19287ba5);
    archetypecatalyst::function_8f9b9d24(3, &function_30b33bc4);
    archetypecatalyst::function_8f9b9d24(2, &function_57285eec);
    archetypecatalyst::function_8f9b9d24(4, &function_f9f8d9e6);
    spawner::add_archetype_spawn_function(#"zombie", &function_49d71e38);
    zm_utility::function_d0f02e71(#"catalyst");
    zm_player::register_player_damage_callback(&function_22e12b7);
    zm_cleanup::function_39553a7c(#"catalyst", &function_5ea7ae19);
    zm_cleanup::function_cdf5a512(#"catalyst", &function_3eaa8337);
    zm_trial_special_enemy::function_95c1dd81(#"catalyst", &function_52ce9654);
    level.var_3ecc60fc[0] = 1;
    level.var_3ecc60fc[2] = 3;
    level.var_3ecc60fc[1] = 2;
    level.var_3ecc60fc[3] = 4;
    clientfield::register("actor", "catalyst_aura_clientfield", 1, 3, "int");
    clientfield::register("actor", "catalyst_damage_explosion_clientfield", 1, 1, "counter");
    clientfield::register("actor", "corrosive_death_clientfield", 1, 1, "int");
    clientfield::register("actor", "corrosive_miasma_clientfield", 1, 1, "int");
    clientfield::register("actor", "water_catalyst_purified", 1, 1, "int");
    clientfield::register("actor", "electricity_catalyst_blast", 1, 1, "int");
    clientfield::register("actor", "plasma_catalyst_blast", 1, 1, "int");
    level thread aat::register_immunity("zm_aat_brain_decay", #"catalyst", 1, 1, 0);
    level thread aat::register_immunity("zm_aat_kill_o_watt", #"catalyst", 1, 1, 0);
    zm_spawner::register_zombie_death_event_callback(&killed_callback);
    zm_round_spawning::register_archetype(#"catalyst", &function_55f82550, &round_spawn, undefined, 25);
    zm_round_spawning::function_306ce518(#"catalyst", &function_587a3171);
    /#
        spawner::add_archetype_spawn_function(#"catalyst", &zombie_utility::updateanimationrate);
    #/
    spawner::add_archetype_spawn_function(#"zombie", &function_59e10bc5);
    spawner::function_89a2cd87(#"catalyst", &function_47fdbfbb);
    function_6e75e858();
    registertransformations();
    /#
        level thread function_1a0ae193();
    #/
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x5 linked
// Checksum 0xdccd6026, Offset: 0xc10
// Size: 0x28c
function private function_52ce9654() {
    if (isarray(level.zm_loc_types) && level.zm_loc_types[#"zombie_location"].size > 0) {
        a_s_spawn_locs = level.zm_loc_types[#"zombie_location"];
        var_31b16a0 = [];
        foreach (s_spawn_loc in a_s_spawn_locs) {
            if (isdefined(s_spawn_loc.script_noteworthy) && (s_spawn_loc.script_noteworthy == "riser_location" || s_spawn_loc.script_noteworthy == "faller_location")) {
                continue;
            }
            if (!isdefined(var_31b16a0)) {
                var_31b16a0 = [];
            } else if (!isarray(var_31b16a0)) {
                var_31b16a0 = array(var_31b16a0);
            }
            var_31b16a0[var_31b16a0.size] = s_spawn_loc;
        }
        if (isarray(level.zm_loc_types[#"blight_father_location"]) && level.zm_loc_types[#"blight_father_location"].size > 0) {
            var_31b16a0 = arraycombine(var_31b16a0, level.zm_loc_types[#"blight_father_location"], 0, 0);
        }
        ai_catalyst = zombie_utility::spawn_zombie(array::random(level.a_sp_catalyst), undefined, array::random(var_31b16a0));
        if (isdefined(ai_catalyst)) {
            ai_catalyst zm_transform::function_bbaec2fd();
            if (ai_catalyst.catalyst_type == 1) {
                level thread function_4329a51b(ai_catalyst);
            }
            return true;
        }
    }
    return false;
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x5 linked
// Checksum 0xe230aa78, Offset: 0xea8
// Size: 0x1e4
function private registertransformations() {
    zm_transform::function_cfca77a7(function_bbb2bab5(1), #"catalyst_corrosive", &function_39212989, 5, &function_f4043bc8, &function_2ed1300e, "aib_vign_zm_zod_catalyst_corrosive_spawn_pre_split", "aib_vign_zm_zod_catalyst_corrosive_spawn_post_split");
    zm_transform::function_cfca77a7(function_bbb2bab5(3), #"catalyst_electric", &function_39212989, 5, &function_f4043bc8, &function_2ed1300e, "aib_vign_zm_zod_catalyst_electric_spawn_pre_split", "aib_vign_zm_zod_catalyst_electric_spawn_post_split");
    zm_transform::function_cfca77a7(function_bbb2bab5(2), #"catalyst_plasma", &function_39212989, 5, &function_f4043bc8, &function_2ed1300e, "aib_vign_zm_zod_catalyst_plasma_spawn_pre_split", "aib_vign_zm_zod_catalyst_plasma_spawn_post_split");
    zm_transform::function_cfca77a7(function_bbb2bab5(4), #"catalyst_water", &function_39212989, 5, &function_f4043bc8, &function_2ed1300e, "aib_vign_zm_zod_catalyst_water_spawn_pre_split", "aib_vign_zm_zod_catalyst_water_spawn_post_split");
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x5 linked
// Checksum 0xa340c583, Offset: 0x1098
// Size: 0x50c
function private registerbehaviorscriptfunctions() {
    assert(isscriptfunctionptr(&function_177aa69d));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_6e732e3940240c58", &function_177aa69d);
    assert(isscriptfunctionptr(&function_f4e7fd8f));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_69f8b2358092c7d2", &function_f4e7fd8f);
    assert(isscriptfunctionptr(&function_787ce068));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5ff2f90caf2f463d", &function_787ce068);
    assert(!isdefined(&function_21cbb589) || isscriptfunctionptr(&function_21cbb589));
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    assert(!isdefined(&function_6c92ebda) || isscriptfunctionptr(&function_6c92ebda));
    behaviortreenetworkutility::registerbehaviortreeaction(#"electriccatalystelectricburst", &function_21cbb589, undefined, &function_6c92ebda);
    assert(isscriptfunctionptr(&function_1043897a));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1430ed09cf5c6db5", &function_1043897a);
    assert(isscriptfunctionptr(&function_dec8327a));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1747a785a62d469f", &function_dec8327a);
    assert(isscriptfunctionptr(&function_554a7c58));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_55c082fcd22cf9d7", &function_554a7c58);
    assert(isscriptfunctionptr(&function_d647a79d));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3891bbe2c51e97c9", &function_d647a79d);
    animationstatenetwork::registernotetrackhandlerfunction("tag_fx_electric_attack", &function_d697a1e3);
    animationstatenetwork::registernotetrackhandlerfunction("tag_fx_electric_attack_stop", &function_aef521f5);
    animationstatenetwork::registernotetrackhandlerfunction("tag_fx_plasma_death", &function_3b07d86e);
    animationstatenetwork::registernotetrackhandlerfunction("corrosive_hide_model", &function_4329a51b);
    animationstatenetwork::registernotetrackhandlerfunction("corrosive_hide_gas", &function_247a46c1);
    animationstatenetwork::registernotetrackhandlerfunction("tag_fx_corrosive_death", &function_cda81e65);
    animationstatenetwork::registernotetrackhandlerfunction("ghost_catalyst", &ghostcatalyst);
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x5 linked
// Checksum 0x80f724d1, Offset: 0x15b0
// Size: 0x4
function private function_49d71e38() {
    
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x5 linked
// Checksum 0x78ccfede, Offset: 0x15c0
// Size: 0x2bc
function private function_47fdbfbb() {
    if (!isdefined(self.var_9fde8624)) {
        return;
    }
    health_multiplier = 1;
    switch (self.var_9fde8624) {
    case #"catalyst_corrosive":
        health_multiplier = self ai::function_9139c839().var_51ce117f;
        self.var_17a22c08 = self ai::function_9139c839().var_57140ac3;
        break;
    case #"catalyst_electric":
        health_multiplier = self ai::function_9139c839().var_6e7acfb4;
        self.var_17a22c08 = self ai::function_9139c839().var_fe586e50;
        break;
    case #"catalyst_plasma":
        health_multiplier = self ai::function_9139c839().var_33236cb0;
        self.var_17a22c08 = self ai::function_9139c839().var_145b14e6;
        break;
    case #"catalyst_water":
        health_multiplier = self ai::function_9139c839().var_bacb0199;
        self.var_17a22c08 = self ai::function_9139c839().var_ead9d81d;
        break;
    }
    health_multiplier *= isdefined(level.var_1eb98fb1) ? level.var_1eb98fb1 : 1;
    round_health = zombie_utility::ai_calculate_health(zombie_utility::function_d2dfacfd(#"zombie_health_start"), isdefined(self._starting_round_number) ? self._starting_round_number : level.round_number);
    self.maxhealth = int(max(round_health * health_multiplier, 1));
    self.health = int(max(self.maxhealth * (isdefined(self.var_d67de8a4) ? self.var_d67de8a4 : 1), 1));
    self zm_score::function_82732ced();
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x5 linked
// Checksum 0x125120a6, Offset: 0x1888
// Size: 0x3a
function private function_befab5d9() {
    if (math::cointoss()) {
        self.zombie_arms_position = "up";
        return;
    }
    self.zombie_arms_position = "down";
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x5 linked
// Checksum 0x8dbd07ab, Offset: 0x18d0
// Size: 0x12c
function private function_d422ab54() {
    self clientfield::set("catalyst_aura_clientfield", self.catalyst_type);
    self.canbetargetedbyturnedzombies = 1;
    self.var_6d23c054 = 1;
    self.ignorepathenemyfightdist = 1;
    self.custom_location = &function_bbe2a1d2;
    self.closest_player_override = &zm_utility::function_c52e1749;
    self.var_2f68be48 = 1;
    self.var_7cc959b1 = 1;
    self.var_1731eda3 = 1;
    self thread function_734195be();
    self.var_d1c70689 = &function_439c457c;
    self thread zm_spawner::zombie_think();
    level thread zm_spawner::zombie_death_event(self);
    self thread zm_utility::function_13cc9756();
    self pushplayer(0);
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x5 linked
// Checksum 0x9fd8338c, Offset: 0x1a08
// Size: 0xc6
function private function_734195be() {
    self endon(#"death");
    self.var_69a981e6 = 1;
    while (true) {
        s_notify = level waittill(#"transformation_complete");
        if (isdefined(s_notify.var_944250d2) && isarray(s_notify.var_944250d2) && isinarray(s_notify.var_944250d2, self)) {
            self.var_69a981e6 = 0;
            self.zombie_think_done = 1;
            self.completed_emerging_into_playable_area = 1;
        }
    }
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x5 linked
// Checksum 0x71a9f74a, Offset: 0x1ad8
// Size: 0x22c
function private killed_callback(e_attacker) {
    if (!isdefined(self.catalyst_type)) {
        return;
    }
    if (!isplayer(e_attacker)) {
        return;
    }
    if (is_true(self.var_85387c5b)) {
        e_attacker zm_stats::increment_challenge_stat(#"aat_catalyst_kills");
        self thread function_d0673f24(e_attacker, self getcentroid());
    } else if (isdefined(self.damageweapon) && isdefined(e_attacker.var_b01de37)) {
        weapon_root = aat::function_702fb333(self.damageweapon);
        a_keys = getarraykeys(e_attacker.var_b01de37);
        if (isinarray(a_keys, weapon_root)) {
            if (self.catalyst_type === e_attacker.var_b01de37[weapon_root]) {
                e_attacker zm_stats::increment_challenge_stat(#"aat_catalyst_kills");
                self thread function_d0673f24(e_attacker, self getcentroid());
            }
        }
    }
    if (isdefined(e_attacker)) {
        if (is_true(self.var_69a981e6)) {
            if (isdefined(self.var_6a4ce3f7)) {
                e_attacker zm_score::player_add_points("transform_kill", self.var_6a4ce3f7);
            } else {
                e_attacker zm_score::player_add_points("transform_kill");
            }
        }
        scoreevents::processscoreevent("kill_catalyst", e_attacker, undefined, self.damageweapon);
    }
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x5 linked
// Checksum 0x972c78ec, Offset: 0x1d10
// Size: 0x3c
function private ghostcatalyst(behaviortreeentity) {
    behaviortreeentity ghost();
    behaviortreeentity notsolid();
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x5 linked
// Checksum 0x610dba99, Offset: 0x1d58
// Size: 0x162
function private function_f4e7fd8f(behaviortreeentity) {
    if (isdefined(behaviortreeentity.enemyoverride) && isdefined(behaviortreeentity.enemyoverride[1])) {
        return true;
    }
    if (!isdefined(behaviortreeentity.enemy)) {
        return true;
    }
    if (isdefined(behaviortreeentity.marked_for_death)) {
        return true;
    }
    if (is_true(behaviortreeentity.ignoremelee)) {
        return true;
    }
    if (distancesquared(behaviortreeentity.origin, behaviortreeentity.enemy.origin) > function_a3f6cdac(behaviortreeentity ai::function_9139c839().var_c9e47b3f)) {
        return true;
    }
    yawtoenemy = angleclamp180(behaviortreeentity.angles[1] - vectortoangles(behaviortreeentity.enemy.origin - behaviortreeentity.origin)[1]);
    if (abs(yawtoenemy) > 60) {
        return true;
    }
    return false;
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x1 linked
// Checksum 0xb7c260ae, Offset: 0x1ec8
// Size: 0x3e0
function function_3eaa8337() {
    a_s_spawn_locs = level.zm_loc_types[#"zombie_location"];
    var_91562d8c = [];
    var_f2a95155 = [];
    foreach (s_spawn_loc in a_s_spawn_locs) {
        if (isdefined(s_spawn_loc.script_noteworthy) && (s_spawn_loc.script_noteworthy == "riser_location" || s_spawn_loc.script_noteworthy == "faller_location")) {
            continue;
        }
        if (s_spawn_loc.script_string == "find_flesh") {
            if (!isdefined(var_91562d8c)) {
                var_91562d8c = [];
            } else if (!isarray(var_91562d8c)) {
                var_91562d8c = array(var_91562d8c);
            }
            var_91562d8c[var_91562d8c.size] = s_spawn_loc;
            continue;
        }
        if (!isdefined(var_f2a95155)) {
            var_f2a95155 = [];
        } else if (!isarray(var_f2a95155)) {
            var_f2a95155 = array(var_f2a95155);
        }
        var_f2a95155[var_f2a95155.size] = s_spawn_loc;
    }
    if (isdefined(level.zm_loc_types[#"blight_father_location"]) && level.zm_loc_types[#"blight_father_location"].size > 0) {
        var_91562d8c = arraycombine(var_91562d8c, level.zm_loc_types[#"blight_father_location"], 0, 0);
    }
    if (isdefined(level.var_78a428fe)) {
        points = [[ level.var_78a428fe ]]();
        if (isdefined(points) && points.size > 0) {
            var_91562d8c = arraycombine(var_91562d8c, points, 0, 0);
        }
    }
    if (var_91562d8c.size) {
        var_d7eff26a = zm_spawner::function_20e7d186(var_91562d8c);
    } else if (var_f2a95155.size) {
        var_d7eff26a = zm_spawner::function_20e7d186(var_f2a95155);
    } else {
        /#
            if (zm_devgui::any_player_in_noclip()) {
            }
        #/
        return false;
    }
    if (isdefined(self) && isentity(self)) {
        self clientfield::set("catalyst_aura_clientfield", 0);
        if (self.catalyst_type == 1) {
            self clientfield::set("corrosive_miasma_clientfield", 0);
        }
        self zm_ai_utility::function_a8dc3363(var_d7eff26a);
        if (isdefined(self)) {
            self clientfield::set("catalyst_aura_clientfield", self.catalyst_type);
            if (self.catalyst_type == 1) {
                self clientfield::set("corrosive_miasma_clientfield", 1);
            }
        }
    }
    return true;
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x1 linked
// Checksum 0x407510c9, Offset: 0x22b0
// Size: 0x34
function function_5ea7ae19(var_3a145c54) {
    if (var_3a145c54) {
        level thread function_616468cb(self.var_9fde8624);
    }
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x1 linked
// Checksum 0xe7a68955, Offset: 0x22f0
// Size: 0x54
function function_616468cb(var_56c95dd4) {
    level endon(#"game_ended");
    level waittill(#"start_of_round");
    zm_transform::function_bdd8aba6(var_56c95dd4);
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x5 linked
// Checksum 0x22c48533, Offset: 0x2350
// Size: 0x94
function private function_19287ba5() {
    self setblackboardattribute("_catalyst_type", "corrosive");
    self thread zm_audio::play_ambient_zombie_vocals();
    self thread zm_audio::zmbaivox_notifyconvert();
    self function_befab5d9();
    self zombie_utility::set_zombie_run_cycle("run");
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x5 linked
// Checksum 0xe41b2c61, Offset: 0x23f0
// Size: 0x24
function private function_d647a79d(*entity) {
    return self.var_9fde8624 === #"catalyst_corrosive";
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x5 linked
// Checksum 0x65ef2568, Offset: 0x2420
// Size: 0x5c
function private function_cda81e65(entity) {
    entity clientfield::set("corrosive_death_clientfield", 1);
    entity ghost();
    entity notsolid();
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x1 linked
// Checksum 0xee8a83c7, Offset: 0x2488
// Size: 0x3c
function function_4329a51b(entity) {
    if (isalive(entity)) {
        entity thread function_e13aa91c();
    }
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x5 linked
// Checksum 0x4f306d3c, Offset: 0x24d0
// Size: 0x2c
function private function_247a46c1(entity) {
    entity clientfield::set("corrosive_miasma_clientfield", 0);
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x5 linked
// Checksum 0xe469da81, Offset: 0x2508
// Size: 0x2c
function private function_d4953883(*notifyhash) {
    self clientfield::set("corrosive_miasma_clientfield", 0);
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x5 linked
// Checksum 0xccb45370, Offset: 0x2540
// Size: 0x2f2
function private function_e13aa91c() {
    self notify("3c982e36ee0f1e8");
    self endon("3c982e36ee0f1e8");
    self endon(#"death");
    self endoncallback(&function_d4953883, #"hash_11d4cfae418fcfe1");
    self clientfield::set("corrosive_miasma_clientfield", 1);
    var_7a79774b = getstatuseffect("dot_corrosive_catalyst");
    while (true) {
        trigger_midpoint = self.origin + (0, 0, self ai::function_9139c839().var_2a523c14 / 2);
        foreach (player in level.players) {
            if (isalive(player) && !is_true(player.var_a0a1475c) && !player scene::is_igc_active() && distancesquared(player.origin, self.origin) <= function_a3f6cdac(self ai::function_9139c839().var_f3af70e6) && (abs(player.origin[2] - trigger_midpoint[2]) <= self ai::function_9139c839().var_2a523c14 / 2 || abs(player geteye()[2] - trigger_midpoint[2]) <= self ai::function_9139c839().var_2a523c14 / 2)) {
                player status_effect::status_effect_apply(var_7a79774b, undefined, self, 0);
                player thread zm_audio::create_and_play_dialog(#"hash_50660c7d730b03a1", #"react");
            }
        }
        waitframe(1);
    }
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x5 linked
// Checksum 0x948ac59, Offset: 0x2840
// Size: 0xca
function private function_30b33bc4() {
    self setblackboardattribute("_catalyst_type", "electric");
    self function_befab5d9();
    self zombie_utility::set_zombie_run_cycle("run");
    self thread zm_audio::play_ambient_zombie_vocals();
    self thread zm_audio::zmbaivox_notifyconvert();
    self.var_51f067e3 = gettime() + self ai::function_9139c839().var_65b97e5e;
    self.var_eaa92291 = gettime();
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x5 linked
// Checksum 0xc722b1fc, Offset: 0x2918
// Size: 0x2f6
function private function_787ce068(behaviortreeentity) {
    if (!isdefined(behaviortreeentity.catalyst_type) || behaviortreeentity.catalyst_type != 3) {
        return 0;
    }
    if (is_true(behaviortreeentity.var_529093ee)) {
        behaviortreeentity.var_529093ee = 0;
        return 1;
    }
    if (behaviortreeentity.var_eaa92291 > gettime()) {
        return 0;
    } else {
        behaviortreeentity.var_eaa92291 = gettime() + 500;
    }
    if (is_true(behaviortreeentity.missinglegs)) {
        return 0;
    }
    if (isdefined(behaviortreeentity.traversal)) {
        return 0;
    }
    if (is_true(behaviortreeentity.barricade_enter)) {
        return 0;
    }
    if (is_true(behaviortreeentity.is_leaping)) {
        return 0;
    }
    if (is_true(behaviortreeentity.var_a85128a4)) {
        return 0;
    }
    if (behaviortreeentity.var_51f067e3 > gettime()) {
        return 0;
    }
    var_55edeb64 = 0;
    foreach (player in level.players) {
        if (!zm_utility::is_player_valid(player, 1, 1)) {
            continue;
        }
        if (isdefined(player.var_6b8f84c7) || is_true(player.var_a0a1475c)) {
            continue;
        }
        if (player scene::is_igc_active()) {
            continue;
        }
        if (distancesquared(player.origin, behaviortreeentity.origin) > function_a3f6cdac(self ai::function_9139c839().var_cbf14156)) {
            continue;
        }
        if (player sightconetrace(behaviortreeentity.origin, behaviortreeentity, anglestoforward(behaviortreeentity.angles), self ai::function_9139c839().var_95922bb3)) {
            behaviortreeentity.var_529093ee = 1;
            var_55edeb64 = 1;
            break;
        }
    }
    return var_55edeb64;
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 2, eflags: 0x5 linked
// Checksum 0xb6dbfcf0, Offset: 0x2c18
// Size: 0x3e
function private function_21cbb589(behaviortreeentity, asmstatename) {
    animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
    behaviortreeentity.var_a85128a4 = 1;
    return 5;
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x5 linked
// Checksum 0xc5ddc08f, Offset: 0x2c60
// Size: 0x21a
function private function_d697a1e3() {
    self endon(#"hash_321b8431208f19bd", #"death");
    self clientfield::set("electricity_catalyst_blast", 1);
    wait self ai::function_9139c839().var_ce7e1def;
    while (true) {
        foreach (player in level.players) {
            if (isdefined(player.var_6b8f84c7) || is_true(player.var_a0a1475c)) {
                continue;
            }
            if (player laststand::player_is_in_laststand()) {
                continue;
            }
            if (player scene::is_igc_active()) {
                continue;
            }
            if (distancesquared(player.origin, self.origin) > function_a3f6cdac(self ai::function_9139c839().var_cbf14156)) {
                continue;
            }
            if (player sightconetrace(self.origin, self, anglestoforward(self.angles), self ai::function_9139c839().var_95922bb3)) {
                player thread function_e7a0424c(self);
            }
        }
        waitframe(1);
    }
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x5 linked
// Checksum 0x57d0046f, Offset: 0x2e88
// Size: 0x3c
function private function_aef521f5(*behaviortreeentity) {
    self notify(#"hash_321b8431208f19bd");
    self clientfield::set("electricity_catalyst_blast", 0);
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 2, eflags: 0x5 linked
// Checksum 0xfa1b0e41, Offset: 0x2ed0
// Size: 0xce
function private function_6c92ebda(behaviortreeentity, asmstatename) {
    animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
    behaviortreeentity notify(#"hash_321b8431208f19bd");
    behaviortreeentity clientfield::set("electricity_catalyst_blast", 0);
    var_12588ac8 = randomfloatrange(behaviortreeentity ai::function_9139c839().var_984d7701, behaviortreeentity ai::function_9139c839().var_58ac6ec4);
    behaviortreeentity.var_51f067e3 = gettime() + var_12588ac8;
    behaviortreeentity.var_a85128a4 = 0;
    return 4;
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x5 linked
// Checksum 0xa1dcf4a2, Offset: 0x2fa8
// Size: 0x66
function private function_e137506e(electriccatalyst) {
    self endon(#"death", #"disconnect", #"hash_7283e5f17e4fa10a");
    electriccatalyst waittill(#"death");
    self notify(#"killed_electric_catalyst");
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x5 linked
// Checksum 0xa28d1277, Offset: 0x3018
// Size: 0xf6
function private function_73961a38(*notifyhash) {
    blind_status_effect = getstatuseffect("blind_zm_catalyst");
    deaf_status_effect = getstatuseffect("deaf_electricity_catalyst");
    if (self status_effect::function_4617032e(blind_status_effect.setype)) {
        self status_effect::function_408158ef(blind_status_effect.setype, blind_status_effect.var_18d16a6b);
    }
    if (self status_effect::function_4617032e(deaf_status_effect.setype)) {
        self status_effect::function_408158ef(deaf_status_effect.setype, deaf_status_effect.var_18d16a6b);
    }
    self.var_6b8f84c7 = undefined;
    self notify(#"hash_7283e5f17e4fa10a");
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x5 linked
// Checksum 0x29e56e2c, Offset: 0x3118
// Size: 0x24c
function private function_e7a0424c(behaviortreeentity) {
    self.var_6b8f84c7 = behaviortreeentity;
    var_116cfaae = behaviortreeentity ai::function_9139c839().var_10a535a6;
    var_a7594ae8 = behaviortreeentity ai::function_9139c839().var_ea39f524;
    self endoncallback(&function_73961a38, #"death", #"disconnect", #"killed_electric_catalyst", #"hash_11d4cfae418fcfe1");
    self thread function_e137506e(self.var_6b8f84c7);
    blind_status_effect = getstatuseffect("blind_zm_catalyst");
    self status_effect::status_effect_apply(blind_status_effect, undefined, self.var_6b8f84c7, 0, var_116cfaae);
    self util::delay(1.3, undefined, &zm_audio::create_and_play_dialog, #"hash_4c7748b237c6fcbe", #"react");
    wait float(var_116cfaae) / 1000;
    if (self status_effect::function_4617032e(blind_status_effect.setype)) {
        self status_effect::function_408158ef(blind_status_effect.setype, blind_status_effect.var_18d16a6b);
    }
    util::wait_network_frame();
    self status_effect::status_effect_apply(getstatuseffect("deaf_electricity_catalyst"), undefined, self.var_6b8f84c7, 0, var_a7594ae8);
    wait float(var_a7594ae8) / 1000;
    self function_73961a38();
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x5 linked
// Checksum 0xfd47ac3, Offset: 0x3370
// Size: 0xde
function private function_57285eec() {
    self setblackboardattribute("_catalyst_type", "plasma");
    self function_befab5d9();
    self zombie_utility::set_zombie_run_cycle("walk");
    self.var_146fbd4b = gettime() + self ai::function_9139c839().var_c7d67645 + self ai::function_9139c839().var_65b97e5e;
    self thread zm_audio::zmbaivox_notifyconvert();
    self.var_ab8f2b90 = 2;
    self.b_override_explosive_damage_cap = 1;
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x5 linked
// Checksum 0x10a7cbce, Offset: 0x3458
// Size: 0x5e
function private function_1043897a(behaviortreeentity) {
    if (!isdefined(behaviortreeentity.catalyst_type) || behaviortreeentity.catalyst_type != 2) {
        return false;
    }
    if (is_true(behaviortreeentity.is_exploding)) {
        return false;
    }
    return true;
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x5 linked
// Checksum 0xd6f7c88c, Offset: 0x34c0
// Size: 0x19c
function private function_dec8327a(behaviortreeentity) {
    if (behaviortreeentity.catalyst_type !== 2) {
        return false;
    }
    if (behaviortreeentity.var_146fbd4b > gettime()) {
        return false;
    }
    if (is_true(behaviortreeentity.is_exploding)) {
        return true;
    }
    foreach (player in level.players) {
        if (!zombie_utility::is_player_valid(player)) {
            continue;
        }
        if (is_true(player.var_a0a1475c)) {
            continue;
        }
        if (player scene::is_igc_active()) {
            continue;
        }
        if (is_true(player.bgb_in_plain_sight_active)) {
            continue;
        }
        if (distancesquared(player.origin, behaviortreeentity.origin) <= function_a3f6cdac(behaviortreeentity ai::function_9139c839().var_febbf56f)) {
            return true;
        }
    }
    return false;
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x5 linked
// Checksum 0xfd0d18e, Offset: 0x3668
// Size: 0xb2
function private function_de076722(entity) {
    origins = spawnstruct();
    origins.eye = entity geteye();
    origins.feet = entity.origin + (0, 0, 8);
    origins.mid = (origins.feet[0], origins.feet[1], (origins.feet[2] + origins.eye[2]) / 2);
    return origins;
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x5 linked
// Checksum 0x6e2a64de, Offset: 0x3728
// Size: 0x1a
function private function_554a7c58(behaviortreeentity) {
    behaviortreeentity.is_exploding = 1;
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 2, eflags: 0x5 linked
// Checksum 0xd563ddc8, Offset: 0x3750
// Size: 0x166
function private function_49248f23(v_blast_origin, var_84dd3dd) {
    level endon(#"game_ended");
    var_109e8af9 = 0;
    a_ai = zombie_utility::get_round_enemy_array();
    foreach (entity in a_ai) {
        if (!isalive(entity)) {
            continue;
        }
        if (entity === self) {
            continue;
        }
        if (distancesquared(v_blast_origin, entity.origin) > var_84dd3dd) {
            continue;
        }
        entity zombie_utility::setup_zombie_knockdown(v_blast_origin);
        var_109e8af9++;
        if (var_109e8af9 >= 6) {
            util::wait_network_frame();
            var_109e8af9 = 0;
        }
    }
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x5 linked
// Checksum 0xf3d86029, Offset: 0x38c0
// Size: 0x3bc
function private function_3b07d86e() {
    var_f152d0cc = function_de076722(self);
    self clientfield::set("plasma_catalyst_blast", 1);
    v_blast_origin = self.origin;
    var_84dd3dd = function_a3f6cdac(self ai::function_9139c839().var_c30a9dc5);
    var_2ffdfebc = self ai::function_9139c839().var_35692434;
    level notify(#"hash_528115ad9eebc84f");
    if (!self isragdoll()) {
        foreach (player in getplayers()) {
            if (!zombie_utility::is_player_valid(player, undefined, undefined, 0)) {
                continue;
            }
            if (distancesquared(v_blast_origin, player.origin) > var_84dd3dd) {
                continue;
            }
            var_d2b8d08a = function_de076722(player);
            if (!bullettracepassed(var_f152d0cc.eye, var_d2b8d08a.eye, 0, undefined)) {
                if (!bullettracepassed(var_f152d0cc.mid, var_d2b8d08a.mid, 0, undefined)) {
                    if (!bullettracepassed(var_f152d0cc.feet, var_d2b8d08a.feet, 0, undefined)) {
                        continue;
                    }
                }
            }
            player dodamage(var_2ffdfebc, v_blast_origin, self, self, "none", "MOD_EXPLOSIVE");
            var_6826a387 = getstatuseffect(#"hash_528115ad9eebc84f");
            player status_effect::status_effect_apply(var_6826a387, undefined, self, 0, undefined, undefined, v_blast_origin);
            player thread zm_audio::create_and_play_dialog(#"hash_695932a4ae89574f", #"react");
        }
        level thread function_49248f23(v_blast_origin, var_84dd3dd);
    }
    if (isdefined(self)) {
        if (zm_utility::is_magic_bullet_shield_enabled(self)) {
            self util::stop_magic_bullet_shield();
        }
        self val::set(#"catalyst", "hide", 2);
        if (isalive(self)) {
            self.takedamage = 1;
            self.allowdeath = 1;
            self kill();
        }
    }
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 2, eflags: 0x5 linked
// Checksum 0x55b76ed8, Offset: 0x3c88
// Size: 0x112
function private function_72a1933a(zombie, catalyst) {
    if (!isdefined(catalyst.last_closest_player) || !isdefined(catalyst.last_closest_player.cached_zone) || !isdefined(catalyst.cached_zone) || !isdefined(zombie.cached_zone)) {
        return false;
    }
    if (zombie.completed_emerging_into_playable_area !== 1) {
        return false;
    }
    if (zombie.var_d53c2370 !== 1) {
        return false;
    }
    if (zombie.var_5c8ac43e === 1) {
        return false;
    }
    if (zombie.cached_zone != catalyst.last_closest_player.cached_zone && !isdefined(catalyst.last_closest_player.cached_zone.adjacent_zones[zombie.cached_zone.name])) {
        return false;
    }
    return true;
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x5 linked
// Checksum 0x69c7c0ab, Offset: 0x3da8
// Size: 0x24c
function private function_d9d6e939(entity) {
    if (isdefined(self.var_8020a7f2)) {
        self.need_closest_player = 0;
        if (isalive(self.var_8020a7f2) && function_72a1933a(self.var_8020a7f2, self)) {
            self setgoal(self.var_8020a7f2.origin);
            return;
        }
    }
    zombies = getaiarchetypearray(#"zombie");
    var_31a419e0 = [];
    foreach (zombie in zombies) {
        if (function_72a1933a(zombie, self)) {
            if (!isdefined(var_31a419e0)) {
                var_31a419e0 = [];
            } else if (!isarray(var_31a419e0)) {
                var_31a419e0 = array(var_31a419e0);
            }
            var_31a419e0[var_31a419e0.size] = zombie;
        }
    }
    if (var_31a419e0.size == 0) {
        self.var_8020a7f2 = undefined;
        self.b_ignore_cleanup = undefined;
        self.should_zigzag = undefined;
        zm_behavior::zombiefindflesh(entity);
        return;
    }
    self.need_closest_player = 0;
    var_31a419e0 = arraysortclosest(var_31a419e0, entity.origin);
    self.var_8020a7f2 = var_31a419e0[0];
    self.b_ignore_cleanup = 1;
    self.should_zigzag = 0;
    self setgoal(self.var_8020a7f2.origin);
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x5 linked
// Checksum 0x4d370f70, Offset: 0x4000
// Size: 0x72
function private function_177aa69d(behaviortreeentity) {
    if (behaviortreeentity.catalyst_type === 4 && behaviortreeentity ai::has_behavior_attribute("gravity") && behaviortreeentity ai::get_behavior_attribute("gravity") == "normal") {
        return true;
    }
    return false;
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x5 linked
// Checksum 0x8b285d1c, Offset: 0x4080
// Size: 0x12
function private function_59e10bc5() {
    self.var_d53c2370 = 1;
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x4
// Checksum 0xbc10f18b, Offset: 0x40a0
// Size: 0x54
function private function_f49b9b11(*var_3a145c54) {
    if (is_true(self.var_5c8ac43e)) {
        if (!isdefined(level.var_53b28340)) {
            level.var_53b28340 = 1;
            return;
        }
        level.var_53b28340++;
    }
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x5 linked
// Checksum 0x38046297, Offset: 0x4100
// Size: 0x1c
function private function_304eef2e() {
    self thread function_e5e8cbd2(1);
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x5 linked
// Checksum 0x607e3c36, Offset: 0x4128
// Size: 0x134
function private function_f9f8d9e6() {
    self setblackboardattribute("_catalyst_type", "water");
    self function_befab5d9();
    self zombie_utility::set_zombie_run_cycle("sprint");
    self.var_72411ccf = &function_d9d6e939;
    level.var_1ea3f886 = self ai::function_9139c839().var_803e192e;
    level.var_e1ade08 = self ai::function_9139c839().var_f00dd43c;
    self thread zm_audio::play_ambient_zombie_vocals();
    self thread zm_audio::zmbaivox_notifyconvert();
    wait self ai::function_9139c839().var_65b97e5e;
    if (isdefined(self)) {
        self function_12cb11ca();
    }
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x5 linked
// Checksum 0x1c5f1ca8, Offset: 0x4268
// Size: 0x34
function private function_12cb11ca() {
    if (isalive(self)) {
        self thread function_75070c6();
    }
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x5 linked
// Checksum 0xc3e15eb5, Offset: 0x42a8
// Size: 0x220
function private function_75070c6() {
    self endon(#"death");
    while (true) {
        trigger_height = self ai::function_9139c839().var_1803b87d;
        var_a00ff069 = function_a3f6cdac(self ai::function_9139c839().var_baa0ac60);
        foreach (zombie in zombie_utility::get_round_enemy_array()) {
            if (isalive(zombie) && is_true(zombie.var_d53c2370) && !is_true(zombie.var_5c8ac43e)) {
                if (zombie.origin[2] >= self.origin[2] && abs(zombie.origin[2] - self.origin[2]) <= trigger_height && distancesquared(zombie.origin, self.origin) <= var_a00ff069) {
                    zombie thread function_e5e8cbd2(0);
                    wait 2;
                }
            }
        }
        wait randomfloatrange(0.1, 0.2);
    }
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x1 linked
// Checksum 0xaddc188f, Offset: 0x44d0
// Size: 0x1d4
function function_e5e8cbd2(b_respawn) {
    self notify(#"hash_25ca29da51a78702");
    self endon(#"hash_25ca29da51a78702");
    self.var_5c8ac43e = 1;
    if (isdefined(level.var_e1ade08)) {
        self.var_9b416b35 = level.var_e1ade08;
    }
    if (!b_respawn && isdefined(level.var_1ea3f886)) {
        self.health = int(self.health * level.var_1ea3f886);
    }
    self.var_bd2c55ef = 1;
    if (!isdefined(self.var_e0d660f6)) {
        self.var_e0d660f6 = [];
    } else if (!isarray(self.var_e0d660f6)) {
        self.var_e0d660f6 = array(self.var_e0d660f6);
    }
    if (!isinarray(self.var_e0d660f6, &function_304eef2e)) {
        self.var_e0d660f6[self.var_e0d660f6.size] = &function_304eef2e;
    }
    self clientfield::set("water_catalyst_purified", 1);
    self thread zm_audio::function_ef9ba49c(#"hash_4433242e2d225df8");
    self waittill(#"death");
    if (isdefined(self)) {
        self clientfield::set("water_catalyst_purified", 0);
    }
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x1 linked
// Checksum 0x95338e05, Offset: 0x46b0
// Size: 0x1a
function function_50a8406d() {
    return is_true(self.var_5c8ac43e);
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 10, eflags: 0x5 linked
// Checksum 0x34f14ab3, Offset: 0x46d8
// Size: 0xe0
function private function_22e12b7(*einflictor, eattacker, idamage, *idflags, *smeansofdeath, *weapon, *vpoint, *vdir, *shitloc, *psoffsettime) {
    if (isdefined(shitloc) && shitloc function_50a8406d() && isdefined(shitloc.var_9b416b35) && !is_true(self.var_a0a1475c)) {
        return int(ceil(psoffsettime * shitloc.var_9b416b35));
    }
    return -1;
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x0
// Checksum 0xf512078, Offset: 0x47c0
// Size: 0x54
function function_55c235fa(s_spot) {
    if (isdefined(level.var_c97f9f06)) {
        self thread [[ level.var_c97f9f06 ]](s_spot);
    }
    if (isdefined(level.var_ce7b374c)) {
        self thread [[ level.var_ce7b374c ]]();
    }
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x1 linked
// Checksum 0x5189953, Offset: 0x4820
// Size: 0xe8
function function_6e75e858() {
    level.a_sp_catalyst = getentarray("zombie_catalyst_spawner", "script_noteworthy");
    if (level.a_sp_catalyst.size == 0) {
        return;
    }
    foreach (sp_catalyst in level.a_sp_catalyst) {
        sp_catalyst.is_enabled = 1;
        sp_catalyst.script_forcespawn = 1;
        sp_catalyst spawner::add_spawn_function(&catalyst_init);
    }
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x1 linked
// Checksum 0x80f724d1, Offset: 0x4910
// Size: 0x4
function catalyst_init() {
    
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x0
// Checksum 0x1b6bdccc, Offset: 0x4920
// Size: 0xaa
function function_da7cd6ce() {
    n_player_count = zm_utility::function_a2541519(level.players.size);
    switch (n_player_count) {
    case 1:
        return 1;
    case 2:
        return 2;
    case 3:
        return 3;
    case 4:
        return 4;
    }
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x1 linked
// Checksum 0x22bf7ff2, Offset: 0x49d8
// Size: 0xb8
function function_bbb2bab5(var_3d9951bb) {
    var_b62aefe1 = function_e1763259(var_3d9951bb);
    foreach (e_spawner in level.a_sp_catalyst) {
        if (e_spawner.var_9fde8624 == var_b62aefe1) {
            return e_spawner;
        }
    }
    return undefined;
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x1 linked
// Checksum 0x833080d2, Offset: 0x4a98
// Size: 0x242
function function_39212989() {
    if (!level flag::get("spawn_zombies") && !is_true(level.var_c9f5947d)) {
        return 0;
    }
    if (is_true(level.var_5e45f817)) {
        return 0;
    }
    if (zm_ai_utility::function_db610082() == 0) {
        return 0;
    }
    if (is_true(level.var_4a03b294)) {
        return 1;
    }
    if (isdefined(self.var_641025d6) && self.var_641025d6 > gettime()) {
        return 0;
    }
    if (is_true(self.var_9528ba7a)) {
        return 1;
    } else {
        var_57bb4de2 = 0;
        foreach (player in level.players) {
            if (!isalive(player)) {
                continue;
            }
            if (distancesquared(player.origin, self.origin) < 147456) {
                continue;
            }
            if (distancesquared(player.origin, self.origin) > 589824) {
                continue;
            }
            var_57bb4de2 = self sightconetrace(player geteye(), player, anglestoforward(player.angles));
            if (var_57bb4de2) {
                break;
            }
        }
    }
    return var_57bb4de2;
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x1 linked
// Checksum 0x8b5ad10d, Offset: 0x4ce8
// Size: 0x34
function function_f4043bc8() {
    self.b_ignore_cleanup = 1;
    self thread zm_audio::function_ef9ba49c(#"catalyst_transform");
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x1 linked
// Checksum 0xeaebdb1d, Offset: 0x4d28
// Size: 0x1a
function function_2ed1300e(n_health_percent) {
    self.var_d67de8a4 = n_health_percent;
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x1 linked
// Checksum 0x1c1dfdc3, Offset: 0x4d50
// Size: 0x26
function function_bbe2a1d2(*var_3b720eb2) {
    if (isdefined(self)) {
        self notify(#"risen");
    }
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x1 linked
// Checksum 0xb2b9c4d6, Offset: 0x4d80
// Size: 0xc6
function function_e1763259(var_3d9951bb) {
    switch (var_3d9951bb) {
    case 1:
        var_b62aefe1 = #"catalyst_corrosive";
        break;
    case 3:
        var_b62aefe1 = #"catalyst_electric";
        break;
    case 2:
        var_b62aefe1 = #"catalyst_plasma";
        break;
    case 4:
        var_b62aefe1 = #"catalyst_water";
        break;
    }
    return var_b62aefe1;
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x0
// Checksum 0x3854ac11, Offset: 0x4e50
// Size: 0x8c
function function_b2090194(var_3d9951bb) {
    if (!isdefined(var_3d9951bb)) {
        zm_transform::function_d2374144(self, function_e1763259(randomintrange(1, 5)));
        return;
    }
    var_b62aefe1 = function_e1763259(var_3d9951bb);
    zm_transform::function_d2374144(self, var_b62aefe1);
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 12, eflags: 0x1 linked
// Checksum 0x3031b683, Offset: 0x4ee8
// Size: 0x132
function function_439c457c(*inflictor, attacker, damage, *flags, *meansofdeath, weapon, *vpoint, *vdir, *shitloc, *psoffsettime, *boneindex, *surfacetype) {
    if (isdefined(psoffsettime) && isplayer(psoffsettime) && isdefined(self.catalyst_type) && isdefined(surfacetype) && isdefined(psoffsettime.var_b01de37)) {
        weapon_root = aat::function_702fb333(surfacetype);
        if (self.catalyst_type === psoffsettime.var_b01de37[weapon_root]) {
            boneindex *= 2;
            if (boneindex >= self.health || psoffsettime zm_powerups::is_insta_kill_active()) {
                self.var_85387c5b = 1;
            }
        }
    }
    return boneindex;
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 2, eflags: 0x1 linked
// Checksum 0x75de85c2, Offset: 0x5028
// Size: 0x19c
function function_d0673f24(player, v_loc) {
    self clientfield::increment("catalyst_damage_explosion_clientfield");
    a_ai_zombies = array::get_all_closest(v_loc, getaiteamarray(level.zombie_team), array(self), undefined, self ai::function_9139c839().var_746e06db);
    level notify(#"hash_166cac102910cdb3");
    if (a_ai_zombies.size == 0) {
        return;
    }
    foreach (ai_zombie in a_ai_zombies) {
        if (!isalive(ai_zombie)) {
            continue;
        }
        ai_zombie function_3f664506(self, player, v_loc);
        waitframe(1);
    }
    if (isalive(self)) {
        self thread function_27a8f02d();
    }
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 3, eflags: 0x1 linked
// Checksum 0x2abd6f2a, Offset: 0x51d0
// Size: 0x26c
function function_3f664506(e_catalyst, player, v_loc) {
    if (!isalive(self) || zm_utility::is_magic_bullet_shield_enabled(self)) {
        return;
    }
    if (is_true(self.var_69a981e6)) {
        return;
    }
    if (is_true(self.aat_turned)) {
        return;
    }
    if (!isdefined(self.var_6f84b820)) {
        return;
    }
    b_stun = 0;
    switch (self.var_6f84b820) {
    case #"normal":
        var_103da188 = self.health;
        if (self.archetype === #"zombie" || self.archetype === #"catalyst") {
            self function_27a8f02d();
        }
        break;
    case #"special":
        var_103da188 = self.maxhealth * 0.5;
        b_stun = 1;
        break;
    case #"elite":
        var_103da188 = self.maxhealth * 0.2;
        b_stun = 1;
        break;
    case #"boss":
        var_103da188 = 2700;
        break;
    default:
        var_103da188 = self.health;
        break;
    }
    if (isalive(self)) {
        self dodamage(var_103da188, v_loc, player, e_catalyst, "none", "MOD_EXPLOSIVE", 0, player getcurrentweapon());
        if (isalive(self) && b_stun) {
            self thread ai::stun();
        }
    }
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x1 linked
// Checksum 0xab94377b, Offset: 0x5448
// Size: 0x64
function function_27a8f02d() {
    gibserverutils::gibhead(self);
    gibserverutils::gibleftarm(self);
    gibserverutils::gibrightarm(self);
    gibserverutils::giblegs(self);
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x1 linked
// Checksum 0xc75449c1, Offset: 0x54b8
// Size: 0x1c0
function function_587a3171(n_round_number) {
    level endon(#"end_game");
    var_f31e767a = array::randomize(array(1, 3, 2, 4));
    /#
        var_47099258 = level.round_number - n_round_number;
        if (var_47099258 >= 4) {
            var_f31e767a = undefined;
        } else if (var_47099258 > 0) {
            for (i = 0; i < var_47099258; i++) {
                arrayremoveindex(var_f31e767a, 0);
            }
        }
    #/
    while (true) {
        level waittill(#"hash_5d3012139f083ccb");
        if (zm_round_spawning::function_d0db51fc(#"catalyst")) {
            if (isdefined(var_f31e767a)) {
                level.var_1643d0d = array(array::pop(var_f31e767a));
                if (!var_f31e767a.size) {
                    var_f31e767a = undefined;
                }
                continue;
            }
            level.var_1643d0d = arraycopy(level.var_3ecc60fc);
            arrayremoveindex(level.var_1643d0d, randomint(level.var_1643d0d.size));
        }
    }
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x1 linked
// Checksum 0xaafc150d, Offset: 0x5680
// Size: 0xa2
function function_55f82550(var_dbce0c44) {
    var_8cf00d40 = int(floor(var_dbce0c44 / 25));
    var_a1737466 = randomfloatrange(0.08, 0.12);
    return min(var_8cf00d40, int(level.zombie_total * var_a1737466));
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x1 linked
// Checksum 0xec09b8f1, Offset: 0x5730
// Size: 0x13e
function round_spawn() {
    if (!isdefined(level.var_1643d0d)) {
        level.var_1643d0d = arraycopy(level.var_3ecc60fc);
        arrayremoveindex(level.var_1643d0d, randomint(level.var_1643d0d.size));
    }
    var_3d9951bb = array::random(level.var_1643d0d);
    if (isdefined(level.var_ed006fe8)) {
        if (!isdefined(level.var_ed006fe8)) {
            level.var_ed006fe8 = [];
        } else if (!isarray(level.var_ed006fe8)) {
            level.var_ed006fe8 = array(level.var_ed006fe8);
        }
        var_3d9951bb = array::random(level.var_ed006fe8);
    }
    zm_transform::function_bdd8aba6(function_e1763259(var_3d9951bb));
    return false;
}

/#

    // Namespace zm_ai_catalyst/zm_ai_catalyst
    // Params 0, eflags: 0x4
    // Checksum 0xf8d84656, Offset: 0x5878
    // Size: 0xa6
    function private function_255c7194() {
        player = getplayers()[0];
        queryresult = positionquery_source_navigation(player.origin, 256, 512, 128, 20);
        if (isdefined(queryresult) && queryresult.data.size > 0) {
            return queryresult.data[0];
        }
        return {#origin:player.origin};
    }

    // Namespace zm_ai_catalyst/zm_ai_catalyst
    // Params 1, eflags: 0x4
    // Checksum 0x2dda6b64, Offset: 0x5928
    // Size: 0x36c
    function private function_fa69f8d2(type) {
        var_7a56405a = [];
        var_7a56405a[1] = #"catalyst_corrosive";
        var_7a56405a[3] = #"catalyst_electric";
        var_7a56405a[2] = #"catalyst_plasma";
        var_7a56405a[4] = #"catalyst_water";
        player = getplayers()[0];
        direction = player getplayerangles();
        direction_vec = anglestoforward(direction);
        eye = player geteye();
        scale = 8000;
        direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
        trace = bullettrace(eye, eye + direction_vec, 0, undefined);
        catalyst_zombie = undefined;
        var_16805a00 = getspawnerarray("<dev string:x38>", "<dev string:x53>");
        if (var_16805a00.size == 0) {
            iprintln("<dev string:x68>");
            return;
        }
        if (!isdefined(var_7a56405a[type])) {
            iprintln("<dev string:x86>" + type);
            return;
        }
        foreach (spawner in var_16805a00) {
            if (spawner.var_9fde8624 === var_7a56405a[type]) {
                catalyst_spawner = spawner;
                break;
            }
        }
        if (!isdefined(catalyst_spawner)) {
            iprintln("<dev string:xb3>" + var_7a56405a[type]);
            return;
        }
        catalyst_zombie = zombie_utility::spawn_zombie(catalyst_spawner, undefined, catalyst_spawner);
        if (isdefined(catalyst_zombie)) {
            wait 0.5;
            catalyst_zombie zm_transform::function_bbaec2fd();
            catalyst_zombie forceteleport(trace[#"position"], player.angles + (0, 180, 0));
            if (catalyst_zombie.catalyst_type == 1) {
                level thread function_4329a51b(catalyst_zombie);
            }
        }
    }

    // Namespace zm_ai_catalyst/zm_ai_catalyst
    // Params 0, eflags: 0x4
    // Checksum 0x1f4e041d, Offset: 0x5ca0
    // Size: 0x178
    function private function_1a0ae193() {
        mapname = util::get_map_name();
        adddebugcommand("<dev string:xe3>" + 1 + "<dev string:x12c>");
        adddebugcommand("<dev string:x132>" + 3 + "<dev string:x12c>");
        adddebugcommand("<dev string:x17d>" + 2 + "<dev string:x12c>");
        adddebugcommand("<dev string:x1c3>" + 4 + "<dev string:x12c>");
        while (true) {
            waitframe(1);
            if (getdvarstring(#"hash_403368b958977fcb", "<dev string:x208>") != "<dev string:x208>") {
                function_fa69f8d2(int(getdvarstring(#"hash_403368b958977fcb")));
                setdvar(#"hash_403368b958977fcb", "<dev string:x208>");
            }
        }
    }

#/
