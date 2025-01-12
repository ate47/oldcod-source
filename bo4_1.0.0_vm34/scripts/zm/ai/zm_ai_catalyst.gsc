#using script_444bc5b4fa0fe14f;
#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\archetype_catalyst;
#using scripts\core_common\ai\archetype_damage_utility;
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
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_behavior;
#using scripts\zm_common\zm_cleanup_mgr;
#using scripts\zm_common\zm_hero_weapon;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_round_logic;
#using scripts\zm_common\zm_round_spawning;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_transformation;
#using scripts\zm_common\zm_utility;

#namespace zm_ai_catalyst;

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x2
// Checksum 0xe1cf200, Offset: 0x658
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_ai_catalyst", &__init__, undefined, undefined);
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x0
// Checksum 0xe192582f, Offset: 0x6a0
// Size: 0x4ac
function __init__() {
    registerbehaviorscriptfunctions();
    if (!isarchetypeloaded("catalyst")) {
        return;
    }
    archetypecatalyst::function_a303213c(0, &function_645b639a);
    archetypecatalyst::function_a303213c(1, &function_53f869ff);
    archetypecatalyst::function_a303213c(3, &function_5c91aa9e);
    archetypecatalyst::function_a303213c(2, &function_6a9bca3f);
    archetypecatalyst::function_a303213c(4, &function_995e7ae8);
    spawner::add_archetype_spawn_function("zombie", &function_77f4f044);
    zm_utility::function_81bbcc91("catalyst");
    zm_player::register_player_damage_callback(&function_e7ebbb6c);
    zm_cleanup::function_fa058f7e("catalyst", &function_66aeb0ef);
    level.var_6945ba47[0] = 1;
    level.var_6945ba47[2] = 3;
    level.var_6945ba47[1] = 2;
    level.var_6945ba47[3] = 4;
    clientfield::register("actor", "catalyst_aura_clientfield", 1, 3, "int");
    clientfield::register("actor", "catalyst_damage_explosion_clientfield", 1, 1, "counter");
    clientfield::register("actor", "corrosive_death_clientfield", 1, 1, "int");
    clientfield::register("actor", "corrosive_miasma_clientfield", 1, 1, "int");
    clientfield::register("actor", "water_catalyst_purified", 1, 1, "int");
    clientfield::register("actor", "electricity_catalyst_blast", 1, 1, "int");
    clientfield::register("actor", "plasma_catalyst_blast", 1, 1, "int");
    level thread aat::register_immunity("zm_aat_brain_decay", "catalyst", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_kill_o_watt", "catalyst", 1, 1, 1);
    zm_spawner::register_zombie_death_event_callback(&killed_callback);
    zm_round_spawning::register_archetype("catalyst", &function_9bb19f39, &round_spawn, undefined, 25);
    zm_round_spawning::function_1a28bc99("catalyst", &function_92f9bc22);
    /#
        spawner::add_archetype_spawn_function("<dev string:x30>", &zombie_utility::updateanimationrate);
    #/
    spawner::add_archetype_spawn_function("zombie", &function_e6945bd5);
    spawner::function_c2d00d5a("catalyst", &function_bcababa5);
    function_f1ae126();
    registertransformations();
    /#
        level thread function_ea1b6a73();
    #/
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x4
// Checksum 0x4236e885, Offset: 0xb58
// Size: 0x1c4
function private registertransformations() {
    zm_transform::function_17652056(function_80683be7(1), "catalyst_corrosive", &function_652d2382, 5, &function_4e1c9e9c, &function_137f5183, "aib_vign_zm_zod_catalyst_corrosive_spawn_pre_split", "aib_vign_zm_zod_catalyst_corrosive_spawn_post_split");
    zm_transform::function_17652056(function_80683be7(3), "catalyst_electric", &function_652d2382, 5, &function_4e1c9e9c, &function_137f5183, "aib_vign_zm_zod_catalyst_electric_spawn_pre_split", "aib_vign_zm_zod_catalyst_electric_spawn_post_split");
    zm_transform::function_17652056(function_80683be7(2), "catalyst_plasma", &function_652d2382, 5, &function_4e1c9e9c, &function_137f5183, "aib_vign_zm_zod_catalyst_plasma_spawn_pre_split", "aib_vign_zm_zod_catalyst_plasma_spawn_post_split");
    zm_transform::function_17652056(function_80683be7(4), "catalyst_water", &function_652d2382, 5, &function_4e1c9e9c, &function_137f5183, "aib_vign_zm_zod_catalyst_water_spawn_pre_split", "aib_vign_zm_zod_catalyst_water_spawn_post_split");
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x4
// Checksum 0xf099c24b, Offset: 0xd28
// Size: 0x4e4
function private registerbehaviorscriptfunctions() {
    assert(isscriptfunctionptr(&function_ff5cf0be));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_6e732e3940240c58", &function_ff5cf0be);
    assert(isscriptfunctionptr(&function_f9c711dc));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_69f8b2358092c7d2", &function_f9c711dc);
    assert(isscriptfunctionptr(&function_2a6d27e2));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5ff2f90caf2f463d", &function_2a6d27e2);
    assert(!isdefined(&function_337b7d35) || isscriptfunctionptr(&function_337b7d35));
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    assert(!isdefined(&function_962f80f6) || isscriptfunctionptr(&function_962f80f6));
    behaviortreenetworkutility::registerbehaviortreeaction(#"electriccatalystelectricburst", &function_337b7d35, undefined, &function_962f80f6);
    assert(isscriptfunctionptr(&function_96e64dd));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1430ed09cf5c6db5", &function_96e64dd);
    assert(isscriptfunctionptr(&function_3595827b));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1747a785a62d469f", &function_3595827b);
    assert(isscriptfunctionptr(&function_d949a053));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_55c082fcd22cf9d7", &function_d949a053);
    assert(isscriptfunctionptr(&function_173e3585));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3891bbe2c51e97c9", &function_173e3585);
    animationstatenetwork::registernotetrackhandlerfunction("tag_fx_electric_attack", &function_5366223a);
    animationstatenetwork::registernotetrackhandlerfunction("tag_fx_plasma_death", &function_7d5681be);
    animationstatenetwork::registernotetrackhandlerfunction("corrosive_hide_model", &function_83fce3e7);
    animationstatenetwork::registernotetrackhandlerfunction("corrosive_hide_gas", &function_ff73be3e);
    animationstatenetwork::registernotetrackhandlerfunction("tag_fx_corrosive_death", &function_8be504dd);
    animationstatenetwork::registernotetrackhandlerfunction("ghost_catalyst", &ghostcatalyst);
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x4
// Checksum 0x80f724d1, Offset: 0x1218
// Size: 0x4
function private function_77f4f044() {
    
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x4
// Checksum 0x4acecce1, Offset: 0x1228
// Size: 0x212
function private function_bcababa5() {
    if (!isdefined(self.var_ea94c12a)) {
        return;
    }
    health_multiplier = 1;
    switch (self.var_ea94c12a) {
    case #"catalyst_corrosive":
        health_multiplier = self ai::function_a0dbf10a().var_c51ed18a;
        break;
    case #"catalyst_electric":
        health_multiplier = self ai::function_a0dbf10a().var_84db62eb;
        break;
    case #"catalyst_plasma":
        health_multiplier = self ai::function_a0dbf10a().var_3447a9c4;
        break;
    case #"catalyst_water":
        health_multiplier = self ai::function_a0dbf10a().var_4b003ef5;
        break;
    }
    health_multiplier *= isdefined(level.var_8c9ffe54) ? level.var_8c9ffe54 : 1;
    round_health = zombie_utility::ai_calculate_health(zombie_utility::get_zombie_var(#"zombie_health_start"), isdefined(self._starting_round_number) ? self._starting_round_number : level.round_number);
    self.maxhealth = int(max(round_health * health_multiplier, 1));
    self.health = int(max(self.maxhealth * (isdefined(self.var_c8d52499) ? self.var_c8d52499 : 1), 1));
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x4
// Checksum 0xf7cd4f68, Offset: 0x1448
// Size: 0x3a
function private function_302e5382() {
    if (math::cointoss()) {
        self.zombie_arms_position = "up";
        return;
    }
    self.zombie_arms_position = "down";
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x4
// Checksum 0x721ee705, Offset: 0x1490
// Size: 0x164
function private function_645b639a() {
    self clientfield::set("catalyst_aura_clientfield", self.catalyst_type);
    self.canbetargetedbyturnedzombies = 1;
    self.var_7d06ae6a = 1;
    self.ignorepathenemyfightdist = 1;
    self.custom_location = &function_5c862d21;
    self.closest_player_override = &zm_utility::function_87d568c4;
    self.var_e9e45f3f = 1;
    self.var_ad0da952 = 1;
    self.var_cd095456 = 1;
    self.var_817e15c1 = 1;
    self thread function_337dfda6();
    self.var_bf88f06b = &function_336b87c8;
    self thread zm_spawner::zombie_think();
    level thread zm_spawner::zombie_death_event(self);
    self thread zm_utility::function_eada9bee();
    self thread zm_audio::play_ambient_zombie_vocals();
    self thread zm_audio::zmbaivox_notifyconvert();
    self pushplayer(0);
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x4
// Checksum 0x82fcf3f9, Offset: 0x1600
// Size: 0xc6
function private function_337dfda6() {
    self endon(#"death");
    self.var_3059fa07 = 1;
    while (true) {
        s_notify = level waittill(#"transformation_complete");
        if (isdefined(s_notify.new_ai) && isarray(s_notify.new_ai) && isinarray(s_notify.new_ai, self)) {
            self.var_3059fa07 = 0;
            self.zombie_think_done = 1;
            self.completed_emerging_into_playable_area = 1;
        }
    }
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x4
// Checksum 0x24c507b6, Offset: 0x16d0
// Size: 0xe4
function private killed_callback(e_attacker) {
    if (!isdefined(self.catalyst_type)) {
        return;
    }
    if (!isplayer(e_attacker)) {
        return;
    }
    if (isdefined(self.var_d06c62f1) && self.var_d06c62f1) {
        self thread function_20dfcd53(e_attacker, self getcentroid());
    }
    if (isdefined(e_attacker)) {
        if (isdefined(self.var_3059fa07) && self.var_3059fa07) {
            if (isdefined(self.var_bf80c633)) {
                e_attacker zm_score::player_add_points("transform_kill", self.var_bf80c633);
                return;
            }
            e_attacker zm_score::player_add_points("transform_kill");
        }
    }
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x4
// Checksum 0x5bfd16f1, Offset: 0x17c0
// Size: 0x3c
function private ghostcatalyst(behaviortreeentity) {
    behaviortreeentity ghost();
    behaviortreeentity notsolid();
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x4
// Checksum 0xc1bdd76d, Offset: 0x1808
// Size: 0x182
function private function_f9c711dc(behaviortreeentity) {
    if (isdefined(behaviortreeentity.enemyoverride) && isdefined(behaviortreeentity.enemyoverride[1])) {
        return true;
    }
    if (!isdefined(behaviortreeentity.enemy)) {
        return true;
    }
    if (isdefined(behaviortreeentity.marked_for_death)) {
        return true;
    }
    if (isdefined(behaviortreeentity.ignoremelee) && behaviortreeentity.ignoremelee) {
        return true;
    }
    if (distancesquared(behaviortreeentity.origin, behaviortreeentity.enemy.origin) > behaviortreeentity ai::function_a0dbf10a().var_8f8d0cea * behaviortreeentity ai::function_a0dbf10a().var_8f8d0cea) {
        return true;
    }
    yawtoenemy = angleclamp180(behaviortreeentity.angles[1] - vectortoangles(behaviortreeentity.enemy.origin - behaviortreeentity.origin)[1]);
    if (abs(yawtoenemy) > 60) {
        return true;
    }
    return false;
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x0
// Checksum 0xfff23df5, Offset: 0x1998
// Size: 0x34
function function_66aeb0ef(var_f740655c) {
    if (var_f740655c) {
        level thread function_1a63be22(self.var_ea94c12a);
    }
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x0
// Checksum 0xe9e4cf29, Offset: 0x19d8
// Size: 0x54
function function_1a63be22(var_c5efaa1c) {
    level endon(#"game_ended");
    level waittill(#"start_of_round");
    zm_transform::function_5dbbf742(var_c5efaa1c);
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x4
// Checksum 0xbe81378f, Offset: 0x1a38
// Size: 0x9c
function private function_53f869ff() {
    self setblackboardattribute("_catalyst_type", "corrosive");
    self function_302e5382();
    self zombie_utility::set_zombie_run_cycle("run");
    self.var_5f02c51 = self ai::function_a0dbf10a().var_887cfb8e;
    self zm_score::function_c4374c52();
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x4
// Checksum 0x9082bf2d, Offset: 0x1ae0
// Size: 0x1c
function private function_173e3585(entity) {
    return self.var_ea94c12a === "catalyst_corrosive";
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x4
// Checksum 0xa2975e24, Offset: 0x1b08
// Size: 0x5c
function private function_8be504dd(entity) {
    entity clientfield::set("corrosive_death_clientfield", 1);
    entity ghost();
    entity notsolid();
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x4
// Checksum 0x33c0a4e, Offset: 0x1b70
// Size: 0x3c
function private function_83fce3e7(entity) {
    if (isalive(entity)) {
        entity thread function_8ecf951f();
    }
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x4
// Checksum 0x2b5b572, Offset: 0x1bb8
// Size: 0x2c
function private function_ff73be3e(entity) {
    entity clientfield::set("corrosive_miasma_clientfield", 0);
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x4
// Checksum 0xd173cf81, Offset: 0x1bf0
// Size: 0x2c
function private function_158b2d57(notifyhash) {
    self clientfield::set("corrosive_miasma_clientfield", 0);
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x4
// Checksum 0x61345910, Offset: 0x1c28
// Size: 0x2d2
function private function_8ecf951f() {
    self endon(#"death");
    self endoncallback(&function_158b2d57, #"hash_11d4cfae418fcfe1");
    self clientfield::set("corrosive_miasma_clientfield", 1);
    var_95e6c12e = getstatuseffect("dot_corrosive_catalyst");
    while (true) {
        trigger_midpoint = self.origin + (0, 0, self ai::function_a0dbf10a().var_865a4a65 / 2);
        foreach (player in level.players) {
            if (isalive(player) && !(isdefined(player.var_6c6628c6) && player.var_6c6628c6) && distancesquared(player.origin, self.origin) <= self ai::function_a0dbf10a().var_2510967e * self ai::function_a0dbf10a().var_2510967e && (abs(player.origin[2] - trigger_midpoint[2]) <= self ai::function_a0dbf10a().var_865a4a65 / 2 || abs(player geteye()[2] - trigger_midpoint[2]) <= self ai::function_a0dbf10a().var_865a4a65 / 2)) {
                player status_effect::status_effect_apply(var_95e6c12e, undefined, self, 0);
                player thread zm_audio::create_and_play_dialog("catalyst_decay_gas", "react");
            }
        }
        waitframe(1);
    }
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x4
// Checksum 0x32f2bf16, Offset: 0x1f08
// Size: 0xd2
function private function_5c91aa9e() {
    self setblackboardattribute("_catalyst_type", "electric");
    self function_302e5382();
    self zombie_utility::set_zombie_run_cycle("run");
    self.var_5f02c51 = self ai::function_a0dbf10a().var_384922b9;
    self zm_score::function_c4374c52();
    self.var_d3d58ea9 = gettime() + self ai::function_a0dbf10a().var_226a09f4;
    self.var_2e5af83a = gettime();
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x4
// Checksum 0x25c40d5d, Offset: 0x1fe8
// Size: 0x2fa
function private function_2a6d27e2(behaviortreeentity) {
    if (!isdefined(behaviortreeentity.catalyst_type) || behaviortreeentity.catalyst_type != 3) {
        return 0;
    }
    if (isdefined(behaviortreeentity.var_5cdd0850) && behaviortreeentity.var_5cdd0850) {
        behaviortreeentity.var_5cdd0850 = 0;
        return 1;
    }
    if (behaviortreeentity.var_2e5af83a > gettime()) {
        return 0;
    } else {
        behaviortreeentity.var_2e5af83a = gettime() + 500;
    }
    if (isdefined(behaviortreeentity.missinglegs) && behaviortreeentity.missinglegs) {
        return 0;
    }
    if (isdefined(behaviortreeentity.traversal)) {
        return 0;
    }
    if (isdefined(behaviortreeentity.barricade_enter) && behaviortreeentity.barricade_enter) {
        return 0;
    }
    if (isdefined(behaviortreeentity.is_leaping) && behaviortreeentity.is_leaping) {
        return 0;
    }
    if (isdefined(behaviortreeentity.var_77ecdd27) && behaviortreeentity.var_77ecdd27) {
        return 0;
    }
    if (behaviortreeentity.var_d3d58ea9 > gettime()) {
        return 0;
    }
    var_f3717f8a = 0;
    foreach (player in level.players) {
        if (!zm_utility::is_player_valid(player, 1, 1)) {
            continue;
        }
        if (isdefined(player.var_e7c4b418) || isdefined(player.var_6c6628c6) && player.var_6c6628c6) {
            continue;
        }
        if (distancesquared(player.origin, behaviortreeentity.origin) > self ai::function_a0dbf10a().var_1ac61beb * self ai::function_a0dbf10a().var_1ac61beb) {
            continue;
        }
        if (player sightconetrace(behaviortreeentity.origin, behaviortreeentity, anglestoforward(behaviortreeentity.angles), self ai::function_a0dbf10a().var_7e10d9b5)) {
            behaviortreeentity.var_5cdd0850 = 1;
            var_f3717f8a = 1;
            break;
        }
    }
    return var_f3717f8a;
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 2, eflags: 0x4
// Checksum 0xac685571, Offset: 0x22f0
// Size: 0x3e
function private function_337b7d35(behaviortreeentity, asmstatename) {
    animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
    behaviortreeentity.var_77ecdd27 = 1;
    return 5;
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x4
// Checksum 0x7b89430, Offset: 0x2338
// Size: 0x1f2
function private function_5366223a() {
    self endon(#"hash_321b8431208f19bd", #"death");
    self clientfield::set("electricity_catalyst_blast", 1);
    wait self ai::function_a0dbf10a().var_75280773;
    while (true) {
        foreach (player in level.players) {
            if (isdefined(player.var_e7c4b418) || isdefined(player.var_6c6628c6) && player.var_6c6628c6) {
                continue;
            }
            if (player laststand::player_is_in_laststand()) {
                continue;
            }
            if (distancesquared(player.origin, self.origin) > self ai::function_a0dbf10a().var_1ac61beb * self ai::function_a0dbf10a().var_1ac61beb) {
                continue;
            }
            if (player sightconetrace(self.origin, self, anglestoforward(self.angles), self ai::function_a0dbf10a().var_7e10d9b5)) {
                player thread function_b5b63ca0(self);
            }
        }
        waitframe(1);
    }
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 2, eflags: 0x4
// Checksum 0x11a72a13, Offset: 0x2538
// Size: 0xda
function private function_962f80f6(behaviortreeentity, asmstatename) {
    behaviortreeentity notify(#"hash_321b8431208f19bd");
    animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
    behaviortreeentity clientfield::set("electricity_catalyst_blast", 0);
    var_5325b6d2 = randomfloatrange(behaviortreeentity ai::function_a0dbf10a().var_34a3ec1a, behaviortreeentity ai::function_a0dbf10a().var_a11e0d4);
    behaviortreeentity.var_d3d58ea9 = gettime() + var_5325b6d2;
    behaviortreeentity.var_77ecdd27 = 0;
    return 4;
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x4
// Checksum 0xfd8f9cf1, Offset: 0x2620
// Size: 0x66
function private function_5f20b61c(electriccatalyst) {
    self endon(#"death", #"disconnect", #"hash_7283e5f17e4fa10a");
    electriccatalyst waittill(#"death");
    self notify(#"killed_electric_catalyst");
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x4
// Checksum 0x64e90638, Offset: 0x2690
// Size: 0xf6
function private function_43ad5092(notifyhash) {
    blind_status_effect = getstatuseffect("blind_zm_catalyst");
    deaf_status_effect = getstatuseffect("deaf_electricity_catalyst");
    if (self status_effect::function_d7236ba9(blind_status_effect.setype)) {
        self status_effect::function_280d8ac0(blind_status_effect.setype, blind_status_effect.var_d20b8ed2);
    }
    if (self status_effect::function_d7236ba9(deaf_status_effect.setype)) {
        self status_effect::function_280d8ac0(deaf_status_effect.setype, deaf_status_effect.var_d20b8ed2);
    }
    self.var_e7c4b418 = undefined;
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x4
// Checksum 0x744e6c48, Offset: 0x2790
// Size: 0x216
function private function_b5b63ca0(behaviortreeentity) {
    self.var_e7c4b418 = behaviortreeentity;
    var_42f87579 = behaviortreeentity ai::function_a0dbf10a().var_e9d2f746;
    var_62042284 = behaviortreeentity ai::function_a0dbf10a().var_d490b679;
    self endoncallback(&function_43ad5092, #"death", #"disconnect", #"killed_electric_catalyst", #"hash_11d4cfae418fcfe1");
    self thread function_5f20b61c(self.var_e7c4b418);
    blind_status_effect = getstatuseffect("blind_zm_catalyst");
    self status_effect::status_effect_apply(blind_status_effect, undefined, self.var_e7c4b418, 0, var_42f87579);
    self util::delay(1.3, undefined, &zm_audio::create_and_play_dialog, "catalyst_radiant_scream", "react");
    wait var_42f87579 / 1000;
    if (self status_effect::function_d7236ba9(blind_status_effect.setype)) {
        self status_effect::function_280d8ac0(blind_status_effect.setype, blind_status_effect.var_d20b8ed2);
    }
    self status_effect::status_effect_apply(getstatuseffect("deaf_electricity_catalyst"), undefined, self.var_e7c4b418, 0, var_62042284);
    wait var_62042284 / 1000;
    self function_43ad5092();
    self notify(#"hash_7283e5f17e4fa10a");
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x4
// Checksum 0x2efd8d2c, Offset: 0x29b0
// Size: 0xf2
function private function_6a9bca3f() {
    self setblackboardattribute("_catalyst_type", "plasma");
    self function_302e5382();
    self zombie_utility::set_zombie_run_cycle("walk");
    self.var_2180f879 = gettime() + self ai::function_a0dbf10a().var_b82b3ff3 + self ai::function_a0dbf10a().var_226a09f4;
    self.var_5f02c51 = self ai::function_a0dbf10a().var_4e8ae1f4;
    self zm_score::function_c4374c52();
    self.var_f197caf2 = 2;
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x4
// Checksum 0xcbc928a0, Offset: 0x2ab0
// Size: 0x64
function private function_96e64dd(behaviortreeentity) {
    if (!isdefined(behaviortreeentity.catalyst_type) || behaviortreeentity.catalyst_type != 2) {
        return false;
    }
    if (isdefined(behaviortreeentity.is_exploding) && behaviortreeentity.is_exploding) {
        return false;
    }
    return true;
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x4
// Checksum 0xc9896461, Offset: 0x2b20
// Size: 0x18e
function private function_3595827b(behaviortreeentity) {
    if (behaviortreeentity.catalyst_type !== 2) {
        return false;
    }
    if (behaviortreeentity.var_2180f879 > gettime()) {
        return false;
    }
    if (isdefined(behaviortreeentity.is_exploding) && behaviortreeentity.is_exploding) {
        return true;
    }
    foreach (player in level.players) {
        if (!zombie_utility::is_player_valid(player)) {
            continue;
        }
        if (isdefined(player.var_6c6628c6) && player.var_6c6628c6) {
            continue;
        }
        if (isdefined(player.bgb_in_plain_sight_active) && player.bgb_in_plain_sight_active) {
            continue;
        }
        if (distancesquared(player.origin, behaviortreeentity.origin) <= behaviortreeentity ai::function_a0dbf10a().var_881805bc * behaviortreeentity ai::function_a0dbf10a().var_881805bc) {
            return true;
        }
    }
    return false;
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x4
// Checksum 0xa786f850, Offset: 0x2cb8
// Size: 0xca
function private function_240c0927(entity) {
    origins = spawnstruct();
    origins.eye = entity geteye();
    origins.feet = entity.origin + (0, 0, 8);
    origins.mid = (origins.feet[0], origins.feet[1], (origins.feet[2] + origins.eye[2]) / 2);
    return origins;
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x4
// Checksum 0xda80620, Offset: 0x2d90
// Size: 0x1a
function private function_d949a053(behaviortreeentity) {
    behaviortreeentity.is_exploding = 1;
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 2, eflags: 0x4
// Checksum 0x7c849c2b, Offset: 0x2db8
// Size: 0x120
function private function_5b191a5d(v_blast_origin, var_d67079b2) {
    level endon(#"game_ended");
    foreach (entity in zombie_utility::get_round_enemy_array()) {
        if (!isdefined(entity)) {
            continue;
        }
        if (entity === self) {
            continue;
        }
        if (distancesquared(v_blast_origin, entity.origin) > var_d67079b2) {
            continue;
        }
        entity zombie_utility::setup_zombie_knockdown(v_blast_origin);
        util::wait_network_frame(randomintrange(1, 3));
    }
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x4
// Checksum 0x30c9141a, Offset: 0x2ee0
// Size: 0x394
function private function_7d5681be() {
    var_b0811e83 = function_240c0927(self);
    self clientfield::set("plasma_catalyst_blast", 1);
    v_blast_origin = self.origin;
    var_d67079b2 = self ai::function_a0dbf10a().var_1888ae9b * self ai::function_a0dbf10a().var_1888ae9b;
    var_c649f0ce = self ai::function_a0dbf10a().var_5dd27c61;
    level notify(#"hash_528115ad9eebc84f");
    if (!self isragdoll()) {
        foreach (player in getplayers()) {
            if (!zombie_utility::is_player_valid(player)) {
                continue;
            }
            if (distancesquared(v_blast_origin, player.origin) > var_d67079b2) {
                continue;
            }
            var_47959d0b = function_240c0927(player);
            if (!bullettracepassed(var_b0811e83.eye, var_47959d0b.eye, 0, undefined)) {
                if (!bullettracepassed(var_b0811e83.mid, var_47959d0b.mid, 0, undefined)) {
                    if (!bullettracepassed(var_b0811e83.feet, var_47959d0b.feet, 0, undefined)) {
                        continue;
                    }
                }
            }
            player dodamage(var_c649f0ce, v_blast_origin, self, self, "none", "MOD_EXPLOSIVE");
            var_d8479a7e = getstatuseffect(#"hash_528115ad9eebc84f");
            player status_effect::status_effect_apply(var_d8479a7e, undefined, self, 0, undefined, undefined, v_blast_origin);
            player thread zm_audio::create_and_play_dialog("catalyst_plasma_detonation", "react");
        }
        level thread function_5b191a5d(v_blast_origin, var_d67079b2);
    }
    if (isdefined(self)) {
        if (zm_utility::is_magic_bullet_shield_enabled(self)) {
            self util::stop_magic_bullet_shield();
        }
        self val::set(#"catalyst", "hide", 2);
        self kill();
    }
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 2, eflags: 0x4
// Checksum 0xe9e39c9, Offset: 0x3280
// Size: 0x11e
function private function_aec6dce5(zombie, catalyst) {
    if (!isdefined(catalyst.last_closest_player) || !isdefined(catalyst.last_closest_player.cached_zone) || !isdefined(catalyst.cached_zone) || !isdefined(zombie.cached_zone)) {
        return false;
    }
    if (zombie.completed_emerging_into_playable_area !== 1) {
        return false;
    }
    if (zombie.var_21ae0c74 !== 1) {
        return false;
    }
    if (zombie.var_869cc6a5 === 1) {
        return false;
    }
    if (zombie.cached_zone != catalyst.last_closest_player.cached_zone && !isdefined(catalyst.last_closest_player.cached_zone.adjacent_zones[zombie.cached_zone.name])) {
        return false;
    }
    return true;
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x4
// Checksum 0x61301ca7, Offset: 0x33a8
// Size: 0x234
function private function_da929ac4(entity) {
    if (isdefined(self.var_bb130fd0)) {
        self.need_closest_player = 0;
        if (isalive(self.var_bb130fd0) && function_aec6dce5(self.var_bb130fd0, self)) {
            self setgoal(self.var_bb130fd0.origin);
            return;
        }
    }
    zombies = getaiarchetypearray("zombie");
    var_ee4e9ef4 = [];
    foreach (zombie in zombies) {
        if (function_aec6dce5(zombie, self)) {
            if (!isdefined(var_ee4e9ef4)) {
                var_ee4e9ef4 = [];
            } else if (!isarray(var_ee4e9ef4)) {
                var_ee4e9ef4 = array(var_ee4e9ef4);
            }
            var_ee4e9ef4[var_ee4e9ef4.size] = zombie;
        }
    }
    if (var_ee4e9ef4.size == 0) {
        self.var_bb130fd0 = undefined;
        self.b_ignore_cleanup = undefined;
        self.should_zigzag = undefined;
        zm_behavior::zombiefindflesh(entity);
        return;
    }
    self.need_closest_player = 0;
    var_ee4e9ef4 = arraysortclosest(var_ee4e9ef4, entity.origin);
    self.var_bb130fd0 = var_ee4e9ef4[0];
    self.b_ignore_cleanup = 1;
    self.should_zigzag = 0;
    self setgoal(self.var_bb130fd0.origin);
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x4
// Checksum 0x4fa7b2b6, Offset: 0x35e8
// Size: 0x72
function private function_ff5cf0be(behaviortreeentity) {
    if (behaviortreeentity.catalyst_type === 4 && behaviortreeentity ai::has_behavior_attribute("gravity") && behaviortreeentity ai::get_behavior_attribute("gravity") == "normal") {
        return true;
    }
    return false;
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x4
// Checksum 0xe2d81fce, Offset: 0x3668
// Size: 0x12
function private function_e6945bd5() {
    self.var_21ae0c74 = 1;
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x4
// Checksum 0x646d2424, Offset: 0x3688
// Size: 0x54
function private function_e7a153a9(var_f740655c) {
    if (isdefined(self.var_869cc6a5) && self.var_869cc6a5) {
        if (!isdefined(level.var_e2735689)) {
            level.var_e2735689 = 1;
            return;
        }
        level.var_e2735689++;
    }
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x4
// Checksum 0x9bfc593e, Offset: 0x36e8
// Size: 0x1c
function private function_cf1b3f95() {
    self thread function_ecf612de(1);
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x4
// Checksum 0x9356bda3, Offset: 0x3710
// Size: 0x13c
function private function_995e7ae8() {
    self setblackboardattribute("_catalyst_type", "water");
    self function_302e5382();
    self zombie_utility::set_zombie_run_cycle("sprint");
    self.var_77966006 = &function_da929ac4;
    level.var_7d8dd6b2 = self ai::function_a0dbf10a().var_45a11e20;
    level.var_4ac4a3ac = self ai::function_a0dbf10a().var_406f1d5c;
    self.var_5f02c51 = self ai::function_a0dbf10a().var_f94eb1ef;
    self zm_score::function_c4374c52();
    wait self ai::function_a0dbf10a().var_226a09f4;
    if (isdefined(self)) {
        self function_cb92fce5();
    }
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x4
// Checksum 0xb00b3bb6, Offset: 0x3858
// Size: 0x34
function private function_cb92fce5() {
    if (isalive(self)) {
        self thread function_a03fce2f();
    }
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x4
// Checksum 0x9677c75a, Offset: 0x3898
// Size: 0x228
function private function_a03fce2f() {
    self endon(#"death");
    while (true) {
        trigger_height = self ai::function_a0dbf10a().var_fc8c1077;
        var_4c0025fb = self ai::function_a0dbf10a().var_94e131ac * self ai::function_a0dbf10a().var_94e131ac;
        foreach (zombie in zombie_utility::get_round_enemy_array()) {
            if (isalive(zombie) && isdefined(zombie.var_21ae0c74) && zombie.var_21ae0c74 && !(isdefined(zombie.var_869cc6a5) && zombie.var_869cc6a5)) {
                if (zombie.origin[2] >= self.origin[2] && abs(zombie.origin[2] - self.origin[2]) <= trigger_height && distancesquared(zombie.origin, self.origin) <= var_4c0025fb) {
                    zombie thread function_ecf612de(0);
                    wait 2;
                }
            }
        }
        wait randomfloatrange(0.1, 0.2);
    }
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x0
// Checksum 0x2700c4e7, Offset: 0x3ac8
// Size: 0x1d4
function function_ecf612de(b_respawn) {
    self notify(#"hash_25ca29da51a78702");
    self endon(#"hash_25ca29da51a78702");
    self.var_869cc6a5 = 1;
    if (isdefined(level.var_4ac4a3ac)) {
        self.var_f90e636a = level.var_4ac4a3ac;
    }
    if (!b_respawn && isdefined(level.var_7d8dd6b2)) {
        self.health = int(self.health * level.var_7d8dd6b2);
    }
    self.var_e4ccc825 = 1;
    if (!isdefined(self.var_d766c1dc)) {
        self.var_d766c1dc = [];
    } else if (!isarray(self.var_d766c1dc)) {
        self.var_d766c1dc = array(self.var_d766c1dc);
    }
    if (!isinarray(self.var_d766c1dc, &function_cf1b3f95)) {
        self.var_d766c1dc[self.var_d766c1dc.size] = &function_cf1b3f95;
    }
    self clientfield::set("water_catalyst_purified", 1);
    self thread zm_audio::function_2b96f4d0("catalyst_purity_buff");
    self waittill(#"death");
    if (isdefined(self)) {
        self clientfield::set("water_catalyst_purified", 0);
    }
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x0
// Checksum 0x5b5c3a66, Offset: 0x3ca8
// Size: 0x18
function function_b0fb0192() {
    return isdefined(self.var_869cc6a5) && self.var_869cc6a5;
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 10, eflags: 0x4
// Checksum 0x8c779725, Offset: 0x3cc8
// Size: 0xc0
function private function_e7ebbb6c(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
    if (isdefined(eattacker) && eattacker function_b0fb0192() && isdefined(eattacker.var_f90e636a)) {
        return int(ceil(idamage * eattacker.var_f90e636a));
    }
    return -1;
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x0
// Checksum 0x4b8d2fe7, Offset: 0x3d90
// Size: 0x54
function function_b19512cc(s_spot) {
    if (isdefined(level.var_db9ec294)) {
        self thread [[ level.var_db9ec294 ]](s_spot);
    }
    if (isdefined(level.var_2420a64f)) {
        self thread [[ level.var_2420a64f ]]();
    }
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x0
// Checksum 0xeb1cbd22, Offset: 0x3df0
// Size: 0xe0
function function_f1ae126() {
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
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x3ed8
// Size: 0x4
function catalyst_init() {
    
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x0
// Checksum 0x45f878d6, Offset: 0x3ee8
// Size: 0x8a
function function_71f6d1a8() {
    switch (level.players.size) {
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
// Params 1, eflags: 0x0
// Checksum 0xf917ddf8, Offset: 0x3f80
// Size: 0xac
function function_80683be7(var_e0b300b4) {
    var_6922b666 = function_d62927(var_e0b300b4);
    foreach (e_spawner in level.a_sp_catalyst) {
        if (e_spawner.var_ea94c12a == var_6922b666) {
            return e_spawner;
        }
    }
    return undefined;
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x0
// Checksum 0xf005771d, Offset: 0x4038
// Size: 0x23a
function function_652d2382() {
    if (!level flag::get("spawn_zombies") && !(isdefined(level.var_f83f8181) && level.var_f83f8181)) {
        return 0;
    }
    if (isdefined(level.var_fe2329bd) && level.var_fe2329bd) {
        return 0;
    }
    if (zm_ai_utility::function_4f5236d3() == 0) {
        return 0;
    }
    if (isdefined(level.var_c7ce8d5c) && level.var_c7ce8d5c) {
        return 1;
    }
    if (isdefined(self.var_8c40dbcb) && self.var_8c40dbcb > gettime()) {
        return 0;
    }
    if (isdefined(self.var_24c73ad5) && self.var_24c73ad5) {
        return 1;
    } else {
        var_6ad1d636 = 0;
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
            var_6ad1d636 = self sightconetrace(player geteye(), player, anglestoforward(player.angles));
            if (var_6ad1d636) {
                break;
            }
        }
    }
    return var_6ad1d636;
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x0
// Checksum 0x3bfaf14c, Offset: 0x4280
// Size: 0x2c
function function_4e1c9e9c() {
    self.b_ignore_cleanup = 1;
    self thread zm_audio::function_2b96f4d0("catalyst_transform");
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x0
// Checksum 0xdd5df4f, Offset: 0x42b8
// Size: 0x1a
function function_137f5183(n_health_percent) {
    self.var_c8d52499 = n_health_percent;
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x0
// Checksum 0xcee9e4b6, Offset: 0x42e0
// Size: 0x26
function function_5c862d21(var_aebe5f46) {
    if (isdefined(self)) {
        self notify(#"risen");
    }
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x0
// Checksum 0x53924b2d, Offset: 0x4310
// Size: 0xae
function function_d62927(var_e0b300b4) {
    switch (var_e0b300b4) {
    case 1:
        var_6922b666 = "catalyst_corrosive";
        break;
    case 3:
        var_6922b666 = "catalyst_electric";
        break;
    case 2:
        var_6922b666 = "catalyst_plasma";
        break;
    case 4:
        var_6922b666 = "catalyst_water";
        break;
    }
    return var_6922b666;
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x0
// Checksum 0x76213023, Offset: 0x43c8
// Size: 0x8c
function function_ceb38eca(var_e0b300b4) {
    if (!isdefined(var_e0b300b4)) {
        zm_transform::function_78f90f3b(self, function_d62927(randomintrange(1, 5)));
        return;
    }
    var_6922b666 = function_d62927(var_e0b300b4);
    zm_transform::function_78f90f3b(self, var_6922b666);
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 12, eflags: 0x0
// Checksum 0x2e0c99b1, Offset: 0x4460
// Size: 0x102
function function_336b87c8(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
    if (isdefined(attacker) && isplayer(attacker) && isdefined(self.catalyst_type) && isdefined(weapon) && isdefined(attacker.var_eed271c5)) {
        if (self.catalyst_type === attacker.var_eed271c5[weapon]) {
            damage *= 2;
            if (damage >= self.health) {
                self.var_d06c62f1 = 1;
            }
        }
    }
    return damage;
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 2, eflags: 0x0
// Checksum 0x65dd414b, Offset: 0x4570
// Size: 0x1b4
function function_20dfcd53(player, v_loc) {
    self clientfield::increment("catalyst_damage_explosion_clientfield");
    a_ai_zombies = array::get_all_closest(v_loc, getaiteamarray(level.zombie_team), array(self), undefined, self ai::function_a0dbf10a().var_8238eecc);
    level notify(#"hash_166cac102910cdb3");
    if (a_ai_zombies.size == 0) {
        return;
    }
    foreach (ai_zombie in a_ai_zombies) {
        if (!isalive(ai_zombie)) {
            continue;
        }
        ai_zombie thread function_eb682a46(self, player, v_loc);
        util::wait_network_frame(randomintrange(1, 3));
    }
    if (isalive(self)) {
        self thread function_a8d225a4();
    }
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 3, eflags: 0x0
// Checksum 0xfc3ca85a, Offset: 0x4730
// Size: 0x1cc
function function_eb682a46(e_catalyst, player, v_loc) {
    if (!isalive(self) || zm_utility::is_magic_bullet_shield_enabled(self)) {
        return;
    }
    if (isdefined(self.var_3059fa07) && self.var_3059fa07) {
        return;
    }
    if (isdefined(self.aat_turned) && self.aat_turned) {
        return;
    }
    if (self.archetype === "zombie" || self.archetype === "catalyst") {
        self function_a8d225a4();
        util::wait_network_frame();
        if (isalive(self)) {
            self dodamage(self.health, v_loc, player, e_catalyst, "none", "MOD_EXPLOSIVE", 0, player getcurrentweapon());
        }
        return;
    }
    self dodamage(self.maxhealth * 0.75, v_loc, player, e_catalyst, "none", "MOD_EXPLOSIVE", 0, player getcurrentweapon());
    if (isalive(self)) {
        self thread ai::stun();
    }
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x0
// Checksum 0xd097b351, Offset: 0x4908
// Size: 0x64
function function_a8d225a4() {
    gibserverutils::gibhead(self);
    gibserverutils::gibleftarm(self);
    gibserverutils::gibrightarm(self);
    gibserverutils::giblegs(self);
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x0
// Checksum 0x9f1fc611, Offset: 0x4978
// Size: 0x1c0
function function_92f9bc22(n_round_number) {
    level endon(#"end_game");
    var_f8e3fc0b = array::randomize(array(1, 3, 2, 4));
    /#
        var_c90b0278 = level.round_number - n_round_number;
        if (var_c90b0278 >= 4) {
            var_f8e3fc0b = undefined;
        } else if (var_c90b0278 > 0) {
            for (i = 0; i < var_c90b0278; i++) {
                arrayremoveindex(var_f8e3fc0b, 0);
            }
        }
    #/
    while (true) {
        level waittill(#"hash_5d3012139f083ccb");
        if (zm_round_spawning::function_f172115b("catalyst")) {
            if (isdefined(var_f8e3fc0b)) {
                level.var_ae2b7a0b = array(array::pop(var_f8e3fc0b));
                if (!var_f8e3fc0b.size) {
                    var_f8e3fc0b = undefined;
                }
                continue;
            }
            level.var_ae2b7a0b = arraycopy(level.var_6945ba47);
            arrayremoveindex(level.var_ae2b7a0b, randomint(level.var_ae2b7a0b.size));
        }
    }
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 1, eflags: 0x0
// Checksum 0xa90eead, Offset: 0x4b40
// Size: 0xa2
function function_9bb19f39(var_e14d9cae) {
    var_13385fd5 = int(floor(var_e14d9cae / 25));
    var_cae84653 = randomfloatrange(0.08, 0.12);
    return min(var_13385fd5, int(level.zombie_total * var_cae84653));
}

// Namespace zm_ai_catalyst/zm_ai_catalyst
// Params 0, eflags: 0x0
// Checksum 0x66a57e9f, Offset: 0x4bf0
// Size: 0xae
function round_spawn() {
    if (!isdefined(level.var_ae2b7a0b)) {
        level.var_ae2b7a0b = arraycopy(level.var_6945ba47);
        arrayremoveindex(level.var_ae2b7a0b, randomint(level.var_ae2b7a0b.size));
    }
    zm_transform::function_5dbbf742(function_d62927(array::random(level.var_ae2b7a0b)));
    return false;
}

/#

    // Namespace zm_ai_catalyst/zm_ai_catalyst
    // Params 0, eflags: 0x4
    // Checksum 0x84061937, Offset: 0x4ca8
    // Size: 0xae
    function private function_c409b190() {
        player = getplayers()[0];
        queryresult = positionquery_source_navigation(player.origin, 256, 512, 128, 20);
        if (isdefined(queryresult) && queryresult.data.size > 0) {
            return queryresult.data[0];
        }
        return {#origin:player.origin};
    }

    // Namespace zm_ai_catalyst/zm_ai_catalyst
    // Params 1, eflags: 0x4
    // Checksum 0x3c6f19ee, Offset: 0x4d60
    // Size: 0x32c
    function private function_bb534c29(type) {
        var_3dd1b1a = [];
        var_3dd1b1a[1] = "<dev string:x39>";
        var_3dd1b1a[3] = "<dev string:x4c>";
        var_3dd1b1a[2] = "<dev string:x5e>";
        var_3dd1b1a[4] = "<dev string:x6e>";
        player = getplayers()[0];
        direction = player getplayerangles();
        direction_vec = anglestoforward(direction);
        eye = player geteye();
        scale = 8000;
        direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
        trace = bullettrace(eye, eye + direction_vec, 0, undefined);
        catalyst_zombie = undefined;
        var_f7c8a8ec = getspawnerarray("<dev string:x7d>", "<dev string:x95>");
        if (var_f7c8a8ec.size == 0) {
            iprintln("<dev string:xa7>");
            return;
        }
        if (!isdefined(var_3dd1b1a[type])) {
            iprintln("<dev string:xc2>" + type);
            return;
        }
        foreach (spawner in var_f7c8a8ec) {
            if (spawner.var_ea94c12a === var_3dd1b1a[type]) {
                catalyst_spawner = spawner;
                break;
            }
        }
        if (!isdefined(catalyst_spawner)) {
            iprintln("<dev string:xec>" + var_3dd1b1a[type]);
            return;
        }
        catalyst_zombie = zombie_utility::spawn_zombie(catalyst_spawner, undefined, catalyst_spawner);
        if (isdefined(catalyst_zombie)) {
            wait 0.5;
            catalyst_zombie zm_transform::function_b028c09b();
            catalyst_zombie forceteleport(trace[#"position"], player.angles + (0, 180, 0));
        }
    }

    // Namespace zm_ai_catalyst/zm_ai_catalyst
    // Params 0, eflags: 0x4
    // Checksum 0xb68da6c4, Offset: 0x5098
    // Size: 0x178
    function private function_ea1b6a73() {
        mapname = util::get_map_name();
        adddebugcommand("<dev string:x119>" + 1 + "<dev string:x15f>");
        adddebugcommand("<dev string:x162>" + 3 + "<dev string:x15f>");
        adddebugcommand("<dev string:x1aa>" + 2 + "<dev string:x15f>");
        adddebugcommand("<dev string:x1ed>" + 4 + "<dev string:x15f>");
        while (true) {
            waitframe(1);
            if (getdvarstring(#"hash_403368b958977fcb", "<dev string:x22f>") != "<dev string:x22f>") {
                function_bb534c29(int(getdvarstring(#"hash_403368b958977fcb")));
                setdvar(#"hash_403368b958977fcb", "<dev string:x22f>");
            }
        }
    }

#/
