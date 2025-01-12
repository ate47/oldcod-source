#using script_2c5daa95f8fec03c;
#using script_3819e7a1427df6d2;
#using scripts\core_common\ai\archetype_mocomps_utility;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\animation_state_machine_mocomp;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai\systems\debug;
#using scripts\core_common\ai\systems\destructible_character;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\weapons\weaponobjects;

#namespace namespace_b619101e;

// Namespace namespace_b619101e/raz
// Params 0, eflags: 0x2
// Checksum 0x50e4cbac, Offset: 0x830
// Size: 0x164
function autoexec init() {
    function_c7bb75d5();
    spawner::add_archetype_spawn_function(#"raz", &function_fd79187b);
    spawner::add_archetype_spawn_function(#"raz", &namespace_eb2895::function_3113cf8f);
    spawner::function_89a2cd87(#"raz", &namespace_eb2895::function_ac64daa7);
    clientfield::register("scriptmover", "raz_detonate_ground_torpedo", 1, 1, "int");
    clientfield::register("scriptmover", "raz_torpedo_play_fx_on_self", 1, 1, "int");
    clientfield::register("scriptmover", "raz_torpedo_play_trail", 1, 1, "counter");
    clientfield::register("actor", "raz_gun_weakpoint_hit", 1, 1, "counter");
}

// Namespace namespace_b619101e/raz
// Params 0, eflags: 0x5 linked
// Checksum 0x3717906b, Offset: 0x9a0
// Size: 0x894
function private function_c7bb75d5() {
    assert(isscriptfunctionptr(&razsprintservice));
    behaviortreenetworkutility::registerbehaviortreescriptapi("razSprintService", &razsprintservice);
    assert(isscriptfunctionptr(&razshouldmelee));
    behaviortreenetworkutility::registerbehaviortreescriptapi("razShouldMelee", &razshouldmelee);
    assert(isscriptfunctionptr(&razshouldshowpain));
    behaviortreenetworkutility::registerbehaviortreescriptapi("razShouldShowPain", &razshouldshowpain);
    assert(isscriptfunctionptr(&razshouldshowspecialpain));
    behaviortreenetworkutility::registerbehaviortreescriptapi("razShouldShowSpecialPain", &razshouldshowspecialpain);
    assert(isscriptfunctionptr(&razshouldshowshieldpain));
    behaviortreenetworkutility::registerbehaviortreescriptapi("razShouldShowShieldPain", &razshouldshowshieldpain);
    assert(isscriptfunctionptr(&razshouldshootgroundtorpedo));
    behaviortreenetworkutility::registerbehaviortreescriptapi("razShouldShootGroundTorpedo", &razshouldshootgroundtorpedo);
    assert(isscriptfunctionptr(&razshouldgoberserk));
    behaviortreenetworkutility::registerbehaviortreescriptapi("razShouldGoBerserk", &razshouldgoberserk);
    assert(isscriptfunctionptr(&razshouldtraversewindow));
    behaviortreenetworkutility::registerbehaviortreescriptapi("razShouldTraverseWindow", &razshouldtraversewindow);
    assert(isscriptfunctionptr(&razgroundtorpedowasinterrupted));
    behaviortreenetworkutility::registerbehaviortreescriptapi("razGroundTorpedoWasInterrupted", &razgroundtorpedowasinterrupted);
    assert(isscriptfunctionptr(&razshouldcutoffarm));
    behaviortreenetworkutility::registerbehaviortreescriptapi("razShouldCutOffArm", &razshouldcutoffarm);
    assert(isscriptfunctionptr(&razshouldmeleerun));
    behaviortreenetworkutility::registerbehaviortreescriptapi("razShouldMeleeRun", &razshouldmeleerun);
    assert(isscriptfunctionptr(&razstartmelee));
    behaviortreenetworkutility::registerbehaviortreescriptapi("razStartMelee", &razstartmelee);
    assert(isscriptfunctionptr(&razfinishmelee));
    behaviortreenetworkutility::registerbehaviortreescriptapi("razFinishMelee", &razfinishmelee);
    assert(isscriptfunctionptr(&razfinishgroundtorpedo));
    behaviortreenetworkutility::registerbehaviortreescriptapi("razFinishGroundTorpedo", &razfinishgroundtorpedo);
    assert(isscriptfunctionptr(&razgoneberserk));
    behaviortreenetworkutility::registerbehaviortreescriptapi("razGoneBerserk", &razgoneberserk);
    assert(isscriptfunctionptr(&raztookpain));
    behaviortreenetworkutility::registerbehaviortreescriptapi("razTookPain", &raztookpain);
    assert(isscriptfunctionptr(&razstartdeath));
    behaviortreenetworkutility::registerbehaviortreescriptapi("razStartDeath", &razstartdeath);
    assert(isscriptfunctionptr(&razgroundtorpedostaggerstart));
    behaviortreenetworkutility::registerbehaviortreescriptapi("razGroundTorpedoStaggerStart", &razgroundtorpedostaggerstart);
    assert(!isdefined(&function_68ef46bd) || isscriptfunctionptr(&function_68ef46bd));
    assert(!isdefined(&function_46545247) || isscriptfunctionptr(&function_46545247));
    assert(!isdefined(&razfinishgroundtorpedo) || isscriptfunctionptr(&razfinishgroundtorpedo));
    behaviortreenetworkutility::registerbehaviortreeaction("razGroundTorpedoAction", &function_68ef46bd, &function_46545247, &razfinishgroundtorpedo);
    animationstatenetwork::registeranimationmocomp("mocomp_raz_shoot_torpedo", &function_20e100b4, &function_70204084, &function_bf9973c);
    animationstatenetwork::registernotetrackhandlerfunction("mangler_fire", &function_67e66d54);
    animationstatenetwork::registernotetrackhandlerfunction("raz_mangler_gib", &function_c49e4c9);
}

// Namespace namespace_b619101e/raz
// Params 0, eflags: 0x5 linked
// Checksum 0x786343c6, Offset: 0x1240
// Size: 0x32
function private function_fd79187b() {
    blackboard::createblackboardforentity(self);
    self.___archetypeonanimscriptedcallback = &function_1004084b;
}

// Namespace namespace_b619101e/raz
// Params 1, eflags: 0x5 linked
// Checksum 0xdd3c66dd, Offset: 0x1280
// Size: 0xb4
function private function_1004084b(entity) {
    entity.__blackboard = undefined;
    entity function_fd79187b();
    if (is_true(entity.var_6f97029e)) {
        entity.var_a55d2294 = undefined;
        entity setblackboardattribute("_locomotion_speed", "locomotion_speed_sprint");
    }
    if (!is_true(entity.var_5c09e990)) {
        entity setblackboardattribute("_gibbed_limbs", "right_arm");
    }
}

// Namespace namespace_b619101e/raz
// Params 0, eflags: 0x4
// Checksum 0x5ada3d88, Offset: 0x1340
// Size: 0x2a
function private bb_getshouldturn() {
    if (isdefined(self.should_turn) && self.should_turn) {
        return "should_turn";
    }
    return "should_not_turn";
}

// Namespace namespace_b619101e/raz
// Params 1, eflags: 0x5 linked
// Checksum 0x688e6d8e, Offset: 0x1378
// Size: 0xcc
function private razsprintservice(entity) {
    if (is_true(entity.var_6f97029e)) {
        return 0;
    }
    if (!isdefined(entity.var_a55d2294)) {
        return 0;
    }
    if (gettime() > entity.var_a55d2294) {
        entity.var_a55d2294 = undefined;
        entity.var_6f97029e = 1;
        entity.berserk = 1;
        entity thread function_3c423226();
        entity setblackboardattribute("_locomotion_speed", "locomotion_speed_sprint");
        entity asmsetanimationrate(1);
    }
}

// Namespace namespace_b619101e/raz
// Params 1, eflags: 0x1 linked
// Checksum 0x5f4b9eec, Offset: 0x1450
// Size: 0xba
function razshouldmelee(entity) {
    if (is_true(entity.var_bb461bfb)) {
        return true;
    }
    if (!isdefined(entity.enemy)) {
        return false;
    }
    if (distancesquared(entity.origin, entity.enemy.origin) > 5625) {
        return false;
    }
    yaw = abs(zombie_utility::getyawtoenemy());
    if (yaw > 45) {
        return false;
    }
    return true;
}

// Namespace namespace_b619101e/raz
// Params 1, eflags: 0x5 linked
// Checksum 0xae09fba3, Offset: 0x1518
// Size: 0x80
function private razshouldshowpain(entity) {
    if (is_true(entity.berserk) && !is_true(entity.var_4e179643) || isdefined(entity.var_3059ea5f) || is_true(entity.var_6d2f7ac8)) {
        return false;
    }
    return true;
}

// Namespace namespace_b619101e/raz
// Params 1, eflags: 0x5 linked
// Checksum 0x84caafd5, Offset: 0x15a0
// Size: 0xd2
function private razshouldshowspecialpain(entity) {
    var_76279076 = entity getblackboardattribute("_gib_location");
    if (var_76279076 === "right_arm") {
        return true;
    }
    if (!razshouldshowpain(entity)) {
        return false;
    }
    if (var_76279076 === "head" || var_76279076 === "arms" || var_76279076 === "right_leg" || var_76279076 === "left_leg" || var_76279076 === "left_arm") {
        return true;
    }
    return false;
}

// Namespace namespace_b619101e/raz
// Params 1, eflags: 0x5 linked
// Checksum 0x8bf7c334, Offset: 0x1680
// Size: 0x54
function private razshouldshowshieldpain(entity) {
    if (isdefined(entity.damageweapon) && isdefined(entity.damageweapon.name)) {
        return (entity.damageweapon.name == "dragonshield");
    }
    return false;
}

// Namespace namespace_b619101e/raz
// Params 1, eflags: 0x5 linked
// Checksum 0x10c0eb61, Offset: 0x16e0
// Size: 0x52
function private razshouldgoberserk(entity) {
    if (is_true(entity.berserk) && !is_true(entity.var_4e179643)) {
        return true;
    }
    return false;
}

// Namespace namespace_b619101e/raz
// Params 1, eflags: 0x5 linked
// Checksum 0xb89b4d01, Offset: 0x1740
// Size: 0x22
function private razshouldtraversewindow(entity) {
    return is_true(entity.var_54ce29af);
}

// Namespace namespace_b619101e/raz
// Params 1, eflags: 0x5 linked
// Checksum 0xa3e16ddb, Offset: 0x1770
// Size: 0x22
function private razgroundtorpedowasinterrupted(entity) {
    return is_true(entity.var_6d2f7ac8);
}

// Namespace namespace_b619101e/raz
// Params 1, eflags: 0x5 linked
// Checksum 0xe951f3fa, Offset: 0x17a0
// Size: 0x1a
function private razshouldcutoffarm(entity) {
    return entity.var_417905cf <= 0;
}

// Namespace namespace_b619101e/raz
// Params 1, eflags: 0x5 linked
// Checksum 0x74eac663, Offset: 0x17c8
// Size: 0x17a
function private razshouldmeleerun(entity) {
    if (!isdefined(entity.favoriteenemy) || entity getblackboardattribute("_locomotion_speed") != "locomotion_speed_sprint") {
        return false;
    }
    var_ff38566a = lengthsquared(entity.favoriteenemy getvelocity());
    var_17c3916f = 7225;
    if (var_ff38566a < function_a3f6cdac(100)) {
        var_17c3916f = 30625;
    }
    if (distancesquared(entity.origin, entity.favoriteenemy.origin) > var_17c3916f) {
        return false;
    }
    yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(entity.favoriteenemy.origin - entity.origin)[1]);
    if (abs(yawtoenemy) > 60) {
        return false;
    }
    return true;
}

// Namespace namespace_b619101e/raz
// Params 1, eflags: 0x5 linked
// Checksum 0x4ef864d5, Offset: 0x1950
// Size: 0x1a
function private razgoneberserk(entity) {
    entity.var_4e179643 = 1;
}

// Namespace namespace_b619101e/raz
// Params 1, eflags: 0x5 linked
// Checksum 0xbba37eee, Offset: 0x1978
// Size: 0x34
function private raztookpain(entity) {
    entity setblackboardattribute("_gib_location", "legs");
}

// Namespace namespace_b619101e/raz
// Params 1, eflags: 0x5 linked
// Checksum 0x8d973bb3, Offset: 0x19b8
// Size: 0x23e
function private razstartdeath(entity) {
    entity playsoundontag("zmb_raz_death", "tag_eye");
    weakpoints = namespace_81245006::function_fab3ee3e(entity);
    if (!isdefined(weakpoints)) {
        return;
    }
    foreach (weakpoint in weakpoints) {
        if (namespace_81245006::function_f29756fe(weakpoint) === 1 && isdefined(weakpoint.var_f371ebb0)) {
            destructserverutils::function_8475c53a(self, weakpoint.var_f371ebb0);
            switch (weakpoint.var_f371ebb0) {
            case #"helmet":
                self namespace_eb2895::function_2eb802f5(undefined);
                break;
            case #"body_armor":
                self namespace_eb2895::function_50c2a59e(undefined);
                break;
            case #"left_arm_armor":
                self namespace_eb2895::function_597f31c9(undefined);
                break;
            case #"right_leg_armor":
                self namespace_eb2895::function_578362e9(undefined);
                break;
            case #"left_leg_armor":
                self namespace_eb2895::function_50f53d3b(undefined);
                break;
            case #"right_arm_armor":
                self namespace_eb2895::function_afcd63e1(undefined, undefined);
                break;
            default:
                break;
            }
        }
    }
}

// Namespace namespace_b619101e/raz
// Params 1, eflags: 0x5 linked
// Checksum 0xbfdaf7d7, Offset: 0x1c00
// Size: 0x16
function private razgroundtorpedostaggerstart(entity) {
    entity.var_6d2f7ac8 = undefined;
}

// Namespace namespace_b619101e/raz
// Params 1, eflags: 0x5 linked
// Checksum 0x45f02bf3, Offset: 0x1c20
// Size: 0x166
function private razshouldshootgroundtorpedo(entity) {
    if (is_true(entity.var_467d69c7)) {
        return true;
    }
    target = get_target_ent(entity);
    if (!isdefined(target)) {
        return false;
    }
    if (!is_true(entity.var_5c09e990)) {
        return false;
    }
    time = gettime();
    if (time < entity.var_af9cbc1c) {
        return false;
    }
    enemy_dist_sq = distancesquared(entity.origin, target.origin);
    if (!(enemy_dist_sq >= 22500 && enemy_dist_sq <= 2250000 && entity function_bb9de4d7(target))) {
        return false;
    }
    if (isdefined(entity.check_point_in_enabled_zone)) {
        var_8a3fbe2f = [[ entity.check_point_in_enabled_zone ]](entity.origin);
        if (!var_8a3fbe2f) {
            return false;
        }
    }
    if (is_true(entity.var_e8f3d773)) {
        return false;
    }
    return true;
}

// Namespace namespace_b619101e/raz
// Params 1, eflags: 0x5 linked
// Checksum 0xf6dc429b, Offset: 0x1d90
// Size: 0x168
function private function_bb9de4d7(enemy) {
    entity = self;
    var_b5b97aba = entity gettagorigin("tag_weapon_right");
    target_point = enemy.origin + (0, 0, 48);
    var_8b96a9fe = anglestoforward(self.angles);
    var_6c822643 = target_point - var_b5b97aba;
    if (vectordot(var_8b96a9fe, var_6c822643) <= 0) {
        return false;
    }
    var_69a5225c = anglestoright(self.angles);
    var_6b5b7991 = vectordot(var_6c822643, var_69a5225c);
    if (abs(var_6b5b7991) > 50) {
        return false;
    }
    trace = bullettrace(var_b5b97aba, target_point, 0, enemy);
    if (trace[#"fraction"] === 1) {
        return true;
    }
    return false;
}

// Namespace namespace_b619101e/raz
// Params 1, eflags: 0x5 linked
// Checksum 0x8469f2e, Offset: 0x1f00
// Size: 0xc
function private razstartmelee(*entity) {
    
}

// Namespace namespace_b619101e/raz
// Params 1, eflags: 0x5 linked
// Checksum 0x39fd169c, Offset: 0x1f18
// Size: 0x16
function private razfinishmelee(entity) {
    entity.var_bb461bfb = undefined;
}

// Namespace namespace_b619101e/raz
// Params 2, eflags: 0x5 linked
// Checksum 0xfe11a5e9, Offset: 0x1f38
// Size: 0x30
function private function_68ef46bd(entity, asmstate) {
    animationstatenetworkutility::requeststate(entity, asmstate);
    return 5;
}

// Namespace namespace_b619101e/raz
// Params 2, eflags: 0x5 linked
// Checksum 0x65c6985, Offset: 0x1f70
// Size: 0xba
function private function_46545247(entity, *asmstate) {
    if (isdefined(asmstate.var_417905cf) && isdefined(asmstate.var_3059ea5f) && is_true(asmstate.var_3059ea5f.var_2b605d6f) && asmstate.var_417905cf <= asmstate.var_3059ea5f.var_f4c2aef8) {
        asmstate.var_6d2f7ac8 = 1;
        return 4;
    }
    if (asmstate asmgetstatus() == "asm_status_complete") {
        return 4;
    }
    return 5;
}

// Namespace namespace_b619101e/raz
// Params 2, eflags: 0x5 linked
// Checksum 0xf957f6d4, Offset: 0x2038
// Size: 0x32
function private razfinishgroundtorpedo(entity, *asmstate) {
    asmstate.var_467d69c7 = undefined;
    asmstate.var_af9cbc1c = gettime() + 3000;
    return 4;
}

// Namespace namespace_b619101e/raz
// Params 5, eflags: 0x5 linked
// Checksum 0x614e045e, Offset: 0x2078
// Size: 0x1a6
function private function_20e100b4(entity, mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    mocompanimflag orientmode("face current");
    mocompanimflag animmode("zonly_physics");
    mocompanimflag.blockingpain = 1;
    health_multiplier = 1;
    n_player_count = getplayers().size;
    var_9385094f = n_player_count - 1;
    if (isdefined(self.var_b3c613a7) && isdefined(self.var_b3c613a7[var_9385094f])) {
        health_multiplier = self.var_b3c613a7[var_9385094f];
    }
    mocompanimflag.var_3059ea5f = {#var_2b605d6f:0, #var_f4c2aef8:max(mocompanimflag.var_417905cf - 50 * health_multiplier, 0), #var_a0a74f78:getnotetracktimes(mocompduration, "raz_vulnerable_start")[0], #var_eea3c0a6:getnotetracktimes(mocompduration, "raz_vulnerable_end")[0]};
}

// Namespace namespace_b619101e/raz
// Params 5, eflags: 0x5 linked
// Checksum 0x6e82bf0a, Offset: 0x2228
// Size: 0xb2
function private function_70204084(entity, mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    animtime = mocompanimflag getanimtime(mocompduration);
    if (animtime >= mocompanimflag.var_3059ea5f.var_a0a74f78 && animtime < mocompanimflag.var_3059ea5f.var_eea3c0a6) {
        mocompanimflag.var_3059ea5f.var_2b605d6f = 1;
    } else {
        mocompanimflag.var_3059ea5f.var_2b605d6f = 0;
    }
    return 5;
}

// Namespace namespace_b619101e/raz
// Params 5, eflags: 0x5 linked
// Checksum 0xfa6b884, Offset: 0x22e8
// Size: 0x42
function private function_bf9973c(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    mocompduration.var_3059ea5f = undefined;
    mocompduration.blockingpain = 0;
}

// Namespace namespace_b619101e/raz
// Params 1, eflags: 0x5 linked
// Checksum 0x50d51689, Offset: 0x2338
// Size: 0xae
function private function_67e66d54(entity) {
    target = get_target_ent(entity);
    if (!isdefined(target) && !is_true(entity.var_467d69c7)) {
        println("<dev string:x38>");
        return;
    }
    entity function_4860f26d(target, (0, 0, 48));
    entity.var_af9cbc1c = gettime() + 3000;
}

// Namespace namespace_b619101e/raz
// Params 1, eflags: 0x5 linked
// Checksum 0x934fc358, Offset: 0x23f0
// Size: 0x24
function private function_c49e4c9(entity) {
    namespace_eb2895::function_30df6d2b(entity);
}

// Namespace namespace_b619101e/raz
// Params 1, eflags: 0x1 linked
// Checksum 0x1ca94176, Offset: 0x2420
// Size: 0x32
function get_target_ent(entity) {
    if (isdefined(entity.attackable)) {
        return entity.attackable;
    }
    return entity.favoriteenemy;
}

// Namespace namespace_b619101e/raz
// Params 4, eflags: 0x5 linked
// Checksum 0x7d42cc41, Offset: 0x2460
// Size: 0x106
function private function_ca603f82(forward_dir, var_d3db66ab, var_5107adf5, max_angle) {
    vec_to_enemy = var_5107adf5 - var_d3db66ab;
    vec_to_enemy_normal = vectornormalize(vec_to_enemy);
    angle_to_enemy = vectordot(forward_dir, vec_to_enemy_normal);
    if (angle_to_enemy >= max_angle) {
        return vec_to_enemy_normal;
    }
    plane_normal = vectorcross(forward_dir, vec_to_enemy_normal);
    perpendicular_normal = vectorcross(plane_normal, forward_dir);
    var_adf30eca = forward_dir * cos(max_angle) + perpendicular_normal * sin(max_angle);
    return var_adf30eca;
}

// Namespace namespace_b619101e/raz
// Params 2, eflags: 0x5 linked
// Checksum 0x545529d8, Offset: 0x2570
// Size: 0x234
function private function_4860f26d(var_ad2d46ff, var_e6e4425) {
    var_d3db66ab = self gettagorigin("tag_weapon_right");
    var_5107adf5 = var_ad2d46ff.origin + var_e6e4425;
    torpedo = spawn("script_model", var_d3db66ab);
    torpedo setmodel("tag_origin");
    torpedo clientfield::set("raz_torpedo_play_fx_on_self", 1);
    torpedo.var_90d59738 = 0;
    torpedo.var_a45c4e6 = self;
    if (!isdefined(level.var_9ded2ca6)) {
        level.var_9ded2ca6 = [];
    } else if (!isarray(level.var_9ded2ca6)) {
        level.var_9ded2ca6 = array(level.var_9ded2ca6);
    }
    level.var_9ded2ca6[level.var_9ded2ca6.size] = torpedo;
    vec_to_enemy = function_ca603f82(anglestoforward(self.angles), var_d3db66ab, var_5107adf5, 0.7);
    angles_to_enemy = vectortoangles(vec_to_enemy);
    torpedo.angles = angles_to_enemy;
    normal_vector = vectornormalize(vec_to_enemy);
    torpedo.var_d070aa8d = normal_vector;
    torpedo.var_d4d27cb6 = 0;
    torpedo thread function_8e224906(var_ad2d46ff);
    torpedo thread function_265f547e(var_ad2d46ff);
    torpedo thread function_328c7269(var_ad2d46ff, var_e6e4425);
}

// Namespace namespace_b619101e/raz
// Params 1, eflags: 0x5 linked
// Checksum 0x2ba9ded5, Offset: 0x27b0
// Size: 0xfc
function private function_8e224906(var_ad2d46ff) {
    self endon(#"death", #"detonated");
    torpedo = self;
    var_3707407 = 70;
    max_trail_iterations = int(1500 / var_3707407);
    while (isdefined(torpedo)) {
        if (!isdefined(var_ad2d46ff) || torpedo.var_90d59738 >= max_trail_iterations) {
            torpedo thread function_ddf221f2(0);
        } else {
            torpedo function_edb8ac3f(var_ad2d46ff);
            torpedo.var_90d59738 += 1;
        }
        wait 0.1;
    }
}

// Namespace namespace_b619101e/raz
// Params 2, eflags: 0x5 linked
// Checksum 0xebb568a0, Offset: 0x28b8
// Size: 0xbe
function private function_328c7269(var_ad2d46ff, var_e6e4425) {
    self endon(#"death", #"detonated");
    torpedo = self;
    while (isdefined(torpedo) && isdefined(var_ad2d46ff)) {
        var_5107adf5 = var_ad2d46ff.origin + var_e6e4425;
        if (distancesquared(torpedo.origin, var_5107adf5) <= 2304) {
            torpedo thread function_ddf221f2(0);
        }
        waitframe(1);
    }
}

// Namespace namespace_b619101e/raz
// Params 1, eflags: 0x5 linked
// Checksum 0xbf4ae60f, Offset: 0x2980
// Size: 0x43c
function private function_edb8ac3f(var_ad2d46ff) {
    self endon(#"death");
    self endon(#"detonated");
    if (!isdefined(self.var_c4f2952f)) {
        var_9c0d0e5b = 2.8;
        self.var_c4f2952f = cos(var_9c0d0e5b);
    }
    if (isdefined(self.var_d070aa8d)) {
        var_30c2c6c3 = var_ad2d46ff.origin + (0, 0, 48);
        if (isplayer(var_ad2d46ff)) {
            var_30c2c6c3 = var_ad2d46ff getplayercamerapos();
        }
        vector_to_target = var_30c2c6c3 - self.origin;
        normal_vector = vectornormalize(vector_to_target);
        var_700ba47b = vectornormalize((normal_vector[0], normal_vector[1], 0));
        var_cb266a = vectornormalize((self.var_d070aa8d[0], self.var_d070aa8d[1], 0));
        dot = vectordot(var_700ba47b, var_cb266a);
        if (dot >= 1) {
            dot = 1;
        } else if (dot <= -1) {
            dot = -1;
        }
        if (dot < self.var_c4f2952f) {
            new_vector = normal_vector - self.var_d070aa8d;
            angle_between_vectors = acos(dot);
            if (!isdefined(angle_between_vectors)) {
                angle_between_vectors = 180;
            }
            if (angle_between_vectors == 0) {
                angle_between_vectors = 0.0001;
            }
            var_fca71723 = 2.8;
            ratio = var_fca71723 / angle_between_vectors;
            if (ratio > 1) {
                ratio = 1;
            }
            new_vector *= ratio;
            new_vector += self.var_d070aa8d;
            normal_vector = vectornormalize(new_vector);
        }
    }
    move_distance = 70;
    move_vector = move_distance * normal_vector;
    move_to_point = self.origin + move_vector;
    trace = bullettrace(self.origin, move_to_point, 0, self);
    if (trace[#"surfacetype"] !== "none") {
        detonate_point = trace[#"position"];
        dist_sq = distancesquared(detonate_point, self.origin);
        move_dist_sq = move_distance * move_distance;
        ratio = dist_sq / move_dist_sq;
        delay = ratio * 0.1;
        self thread function_ddf221f2(delay);
    }
    self.var_d070aa8d = normal_vector;
    self moveto(move_to_point, 0.1);
    /#
        if (getdvarint(#"hash_4901482f884b01dc", 0)) {
            line(self.origin, move_to_point, (0, 0, 1), 1, 0, 500);
        }
    #/
}

// Namespace namespace_b619101e/raz
// Params 0, eflags: 0x4
// Checksum 0xf5166466, Offset: 0x2dc8
// Size: 0xd4
function private function_fc00dc60() {
    self endon(#"death");
    self endon(#"detonated");
    var_5bac442e = 26;
    if (self.var_90d59738 >= 1) {
        trace = bullettrace(self.origin + (0, 0, 10), self.origin - (0, 0, var_5bac442e), 0, self);
        if (trace[#"surfacetype"] !== "none") {
            self clientfield::increment("raz_torpedo_play_trail", 1);
        }
    }
}

// Namespace namespace_b619101e/raz
// Params 1, eflags: 0x5 linked
// Checksum 0x4e3d7f4e, Offset: 0x2ea8
// Size: 0x354
function private function_f95c27a2(target) {
    self endon(#"death");
    while (isdefined(self)) {
        if (isdefined(target)) {
            if (isplayer(target)) {
                var_71872c01 = target.origin + (0, 0, 48);
            } else {
                var_71872c01 = target.origin;
            }
            var_6ef49f96 = 0.3;
            if (isdefined(self.var_d4d27cb6) && self.var_d4d27cb6 < 3) {
                if (self.var_d4d27cb6 == 0) {
                    var_6ef49f96 = 0.075;
                }
                if (self.var_d4d27cb6 == 1) {
                    var_6ef49f96 = 0.15;
                }
                if (self.var_d4d27cb6 == 2) {
                    var_6ef49f96 = 0.225;
                }
            }
            self.var_d4d27cb6 += 1;
            vector_to_target = var_71872c01 - self.origin;
            normal_vector = vectornormalize(vector_to_target);
            move_distance = 700 * var_6ef49f96;
            move_vector = move_distance * normal_vector;
            self.angles = vectortoangles(move_vector);
        } else {
            velocity = self getvelocity();
            velocitymag = length(velocity);
            var_13849675 = velocitymag >= 40;
            if (var_13849675) {
                var_b98d779c = 0.2;
                move_vector = velocity * var_b98d779c;
            }
        }
        if (!isdefined(var_13849675) || var_13849675 == 1) {
            var_6c6317b9 = self.origin + move_vector;
            a_zombies = getentitiesinradius(var_6c6317b9, 48, 15);
            var_eb2cabb5 = array::filter(a_zombies, 0, &function_2171139f, self, var_6c6317b9);
        } else {
            wait 0.2;
            continue;
        }
        foreach (zombie in var_eb2cabb5) {
            zombie zombie_utility::setup_zombie_knockdown(self.origin);
        }
        wait 0.2;
    }
}

// Namespace namespace_b619101e/raz
// Params 1, eflags: 0x5 linked
// Checksum 0x57e0416c, Offset: 0x3208
// Size: 0x44
function private function_265f547e(var_ad2d46ff) {
    self endon(#"death");
    self endon(#"detonated");
    function_f95c27a2(var_ad2d46ff);
}

// Namespace namespace_b619101e/raz
// Params 0, eflags: 0x5 linked
// Checksum 0x11461cb4, Offset: 0x3258
// Size: 0x64
function private function_3c423226() {
    self endon(#"death", #"hash_ce013f00056f6fe");
    self notify(#"hash_3d58a1166d034e55");
    self endon(#"hash_3d58a1166d034e55");
    function_f95c27a2();
}

// Namespace namespace_b619101e/raz
// Params 1, eflags: 0x5 linked
// Checksum 0xc0e5ac18, Offset: 0x32c8
// Size: 0x1e4
function private function_ddf221f2(delay) {
    self endon(#"death");
    self notify(#"detonated");
    torpedo = self;
    var_a45c4e6 = self.var_a45c4e6;
    if (delay > 0) {
        wait delay;
    }
    if (isdefined(self)) {
        self function_abaec088();
        w_weapon = getweapon("none");
        explosion_point = torpedo.origin;
        torpedo clientfield::set("raz_detonate_ground_torpedo", 1);
        radiusdamage(explosion_point + (0, 0, 18), 96, 75, 50, self.var_a45c4e6, "MOD_UNKNOWN", w_weapon);
        function_a90fe496(explosion_point + (0, 0, 18));
        self clientfield::set("raz_torpedo_play_fx_on_self", 0);
        if (isarray(level.var_9ded2ca6)) {
            arrayremovevalue(level.var_9ded2ca6, self);
        }
        wait 0.5;
        if (isdefined(var_a45c4e6) && is_true(level.var_21b0396e)) {
            var_a45c4e6.var_af9cbc1c = gettime();
        }
        if (isdefined(self)) {
            self delete();
        }
    }
}

// Namespace namespace_b619101e/raz
// Params 1, eflags: 0x5 linked
// Checksum 0x69af956b, Offset: 0x34b8
// Size: 0x23c
function private function_a90fe496(var_cf34de7a) {
    players = getplayers();
    v_length = function_a3f6cdac(100);
    for (i = 0; i < players.size; i++) {
        player = players[i];
        if (!isalive(player)) {
            continue;
        }
        if (player.sessionstate == "spectator") {
            continue;
        }
        if (player.sessionstate == "intermission") {
            continue;
        }
        if (is_true(player.ignoreme)) {
            continue;
        }
        if (player isnotarget()) {
            continue;
        }
        if (!player isonground()) {
            continue;
        }
        n_distance = distance2dsquared(var_cf34de7a, player.origin);
        if (n_distance < 0.01) {
            continue;
        }
        if (n_distance < v_length) {
            v_dir = player.origin - var_cf34de7a;
            v_dir = (v_dir[0], v_dir[1], 0.1);
            v_dir = vectornormalize(v_dir);
            n_push_strength = getdvarint(#"hash_3ce74fce73494ef0", 500);
            n_push_strength = 200 + randomint(n_push_strength - 200);
            v_player_velocity = player getvelocity();
            player setvelocity(v_player_velocity + v_dir * n_push_strength);
        }
    }
}

// Namespace namespace_b619101e/raz
// Params 0, eflags: 0x5 linked
// Checksum 0xf53e2513, Offset: 0x3700
// Size: 0xe8
function private function_abaec088() {
    earthquake(0.4, 0.8, self.origin, 300);
    players = getentitiesinradius(self.origin, 48, 1);
    foreach (player in players) {
        player playrumbleonentity("damage_heavy");
    }
}

// Namespace namespace_b619101e/raz
// Params 2, eflags: 0x5 linked
// Checksum 0x82fdcdc0, Offset: 0x37f0
// Size: 0x160
function private function_2171139f(zombie, target) {
    if (zombie.archetype !== #"zombie" || zombie.knockdown === 1 || gibserverutils::isgibbed(zombie, 384)) {
        return false;
    }
    origin = target.origin;
    var_3c08a493 = anglestoforward(target.angles);
    var_e14511cb = zombie.origin - origin;
    var_660d1fec = (var_e14511cb[0], var_e14511cb[1], 0);
    var_58877074 = (var_3c08a493[0], var_3c08a493[1], 0);
    var_660d1fec = vectornormalize(var_660d1fec);
    var_58877074 = vectornormalize(var_58877074);
    var_704c3d16 = vectordot(var_58877074, var_660d1fec);
    if (var_704c3d16 < 0) {
        return false;
    }
    return true;
}

#namespace namespace_eb2895;

// Namespace namespace_eb2895/raz
// Params 0, eflags: 0x5 linked
// Checksum 0xaae800, Offset: 0x3958
// Size: 0xd4
function private function_3113cf8f() {
    self.var_af9cbc1c = gettime();
    self.var_5c09e990 = 1;
    self.var_e4fc6a2f = 1;
    self.var_9f71af13 = 1;
    self.var_8e205014 = 1;
    self.var_c0a83965 = 1;
    self.var_cb66dfbf = 1;
    self.var_4e179643 = 0;
    self.canbetargetedbyturnedzombies = 1;
    self.var_2672b13c = 1;
    self.flame_fx_timeout = 3;
    aiutility::addaioverridedamagecallback(self, &function_85b9ec36);
    self thread function_37c7f369();
    self destructserverutils::togglespawngibs(self, 1);
}

// Namespace namespace_eb2895/raz
// Params 0, eflags: 0x5 linked
// Checksum 0x5ce59f56, Offset: 0x3a38
// Size: 0xbc
function private function_ac64daa7() {
    self.var_417905cf = 0.25 * self.maxhealth;
    self.var_7cda74 = 0.1 * self.maxhealth;
    self.var_e0947b4e = 0.2 * self.maxhealth;
    self.var_d6fdc42c = 0.1 * self.maxhealth;
    self.var_972ecf6d = 0.1 * self.maxhealth;
    self.var_6eabd43c = 0.1 * self.maxhealth;
    namespace_81245006::initweakpoints(self);
}

// Namespace namespace_eb2895/raz
// Params 0, eflags: 0x5 linked
// Checksum 0x7bb2aefe, Offset: 0x3b00
// Size: 0x3d4
function private function_37c7f369() {
    self endon(#"death");
    self endon(#"disconnect");
    while (true) {
        self waittill(#"melee_fire");
        a_zombies = getentitiesinradius(self.origin, 90, 15);
        foreach (zombie in a_zombies) {
            if (zombie.archetype !== #"zombie" || is_true(zombie.no_gib)) {
                continue;
            }
            heightdiff = abs(zombie.origin[2] - self.origin[2]);
            if (heightdiff > 50) {
                continue;
            }
            var_49122837 = distance2dsquared(zombie.origin, self.origin);
            if (var_49122837 > function_a3f6cdac(90)) {
                continue;
            }
            var_3e3046da = anglestoforward(self.angles);
            var_6c822643 = zombie.origin - self.origin;
            if (vectordot(var_3e3046da, var_6c822643) <= 0) {
                continue;
            }
            var_69a5225c = anglestoright(self.angles);
            var_6b5b7991 = vectordot(var_6c822643, var_69a5225c);
            if (abs(var_6b5b7991) > 35) {
                continue;
            }
            b_gibbed = 0;
            val = randomint(100);
            if (val > 50) {
                if (!gibserverutils::isgibbed(zombie, 32)) {
                    gibserverutils::gibrightarm(zombie);
                    b_gibbed = 1;
                }
            }
            val = randomint(100);
            if (val > 50) {
                if (!gibserverutils::isgibbed(zombie, 16)) {
                    gibserverutils::gibleftarm(zombie);
                    b_gibbed = 1;
                }
            }
            if (!is_true(b_gibbed)) {
                if (!gibserverutils::isgibbed(zombie, 32)) {
                    gibserverutils::gibrightarm(zombie);
                    continue;
                }
                if (!gibserverutils::isgibbed(zombie, 16)) {
                    gibserverutils::gibleftarm(zombie);
                }
            }
        }
    }
}

// Namespace namespace_eb2895/raz
// Params 0, eflags: 0x5 linked
// Checksum 0xd7ca99a4, Offset: 0x3ee0
// Size: 0x30c
function private function_7428d843() {
    if (!is_true(self.var_5c09e990)) {
        self hidepart("j_shouldertwist_ri_attach", "", 1);
        self hidepart("j_shoulder_ri_attach");
    }
    if (!is_true(self.var_8e205014)) {
        self hidepart("j_spine4_attach", "", 1);
        self hidepart("j_spineupper_attach", "", 1);
        self hidepart("j_spinelower_attach", "", 1);
        self hidepart("j_mainroot_attach", "", 1);
        self hidepart("j_clavicle_ri_attachbp", "", 1);
        self hidepart("j_clavicle_le_attachbp", "", 1);
    }
    if (!is_true(self.var_9f71af13)) {
        self hidepart("j_shouldertwist_le_attach", "", 1);
        self hidepart("j_shoulder_le_attach", "", 1);
        self hidepart("j_clavicle_le_attach", "", 1);
    }
    if (!is_true(self.var_c0a83965)) {
        self hidepart("j_hiptwist_ri_attach", "", 1);
        self hidepart("j_hip_ri_attach", "", 1);
    }
    if (!is_true(self.var_cb66dfbf)) {
        self hidepart("j_hiptwist_le_attach", "", 1);
        self hidepart("j_hip_le_attach", "", 1);
    }
    if (!is_true(self.var_e4fc6a2f)) {
        self hidepart("j_head_attach", "", 1);
    }
}

// Namespace namespace_eb2895/raz
// Params 12, eflags: 0x5 linked
// Checksum 0xa77be288, Offset: 0x41f8
// Size: 0x5ce
function private function_85b9ec36(*inflictor, attacker, damage, *dflags, mod, weapon, *point, *dir, hitloc, *offsettime, boneindex, *modelindex) {
    entity = self;
    entity.last_damage_hit_armor = 0;
    if (isdefined(point) && point == entity) {
        return 0;
    }
    var_a70572a9 = 0.25;
    if (isdefined(level.var_dff96419) && isplayer(point)) {
        var_a70572a9 = point [[ level.var_dff96419 ]](0.25, offsettime);
    }
    if (!isdefined(entity.var_a55d2294) && !is_true(entity.berserk)) {
        entity.var_a55d2294 = gettime() + 60000;
    }
    if (hitloc === "MOD_PROJECTILE_SPLASH" || hitloc === "MOD_GRENADE_SPLASH" || hitloc === "MOD_EXPLOSIVE") {
        dir *= 3;
    }
    var_ebcff177 = 1;
    weakpoint = namespace_81245006::function_3131f5dd(self, boneindex, 1);
    if (!isdefined(weakpoint)) {
        weakpoint = namespace_81245006::function_37e3f011(self, modelindex, 1);
    }
    if (isdefined(weakpoint)) {
        if (weakpoint.type === #"weakpoint") {
            level scoreevents::doscoreeventcallback("scoreEventZM", {#attacker:point, #scoreevent:"hit_weak_point_zm"});
        } else if (weakpoint.type === #"armor") {
            if (namespace_81245006::function_f29756fe(weakpoint) === 1 && isdefined(weakpoint.var_f371ebb0)) {
                if (weakpoint.var_f371ebb0 == "right_arm_armor") {
                    namespace_81245006::function_ef87b7e8(weakpoint, dir);
                    entity clientfield::increment("raz_gun_weakpoint_hit", 1);
                    entity.var_417905cf = weakpoint.health;
                    var_ebcff177 = 1;
                } else {
                    dir *= var_a70572a9;
                    namespace_81245006::function_ef87b7e8(weakpoint, dir);
                    var_ebcff177 = 3;
                }
            }
            if (namespace_81245006::function_f29756fe(weakpoint) === 3 && isdefined(weakpoint.var_f371ebb0)) {
                destructserverutils::function_8475c53a(self, weakpoint.var_f371ebb0);
                scoreevent = "destroyed_armor_zm";
                if (weakpoint.var_f371ebb0 == "helmet") {
                    self function_2eb802f5(point);
                }
                if (weakpoint.var_f371ebb0 == "body_armor") {
                    self function_50c2a59e(point);
                }
                if (weakpoint.var_f371ebb0 == "left_arm_armor") {
                    self function_597f31c9(point);
                }
                if (weakpoint.var_f371ebb0 == "right_leg_armor") {
                    self function_578362e9(point);
                }
                if (weakpoint.var_f371ebb0 == "left_leg_armor") {
                    self function_50f53d3b(point);
                }
                if (weakpoint.var_f371ebb0 == "right_arm_armor") {
                    scoreevent = "mangler_cannon_destroyed_zm";
                    self function_afcd63e1(point, dir);
                }
                level scoreevents::doscoreeventcallback("scoreEventZM", {#attacker:point, #scoreevent:scoreevent});
            }
        }
    }
    if (weakpoint.var_3765e777 === 1) {
        var_ebcff177 = 2;
    }
    /#
        if (is_true(level.var_85a39c96)) {
            dir = self.health + 1;
        }
    #/
    callback::callback(#"hash_3886c79a26cace38", {#eattacker:point, #var_dcc8dd60:self getentitynumber(), #idamage:dir, #type:var_ebcff177});
    var_d58c98fd = 0;
    return dir;
}

// Namespace namespace_eb2895/raz
// Params 6, eflags: 0x4
// Checksum 0x718c7c6f, Offset: 0x47d0
// Size: 0xbc
function private function_550f17ad(entity, hitloc, point, location, var_971b8272, tag) {
    var_877657e9 = 0;
    if (isdefined(hitloc) && hitloc != "none") {
        if (hitloc == location) {
            var_877657e9 = 1;
        }
    } else {
        dist_sq = distancesquared(point, entity gettagorigin(tag));
        if (dist_sq <= var_971b8272) {
            var_877657e9 = 1;
        }
    }
    return var_877657e9;
}

// Namespace namespace_eb2895/raz
// Params 1, eflags: 0x1 linked
// Checksum 0xc74a4bc4, Offset: 0x4898
// Size: 0xec
function function_30df6d2b(entity) {
    self hidepart("j_shouldertwist_ri_attach", "", 1);
    self hidepart("j_shoulder_ri_attach");
    entity setblackboardattribute("_locomotion_speed", "locomotion_speed_sprint");
    entity asmsetanimationrate(1);
    entity setblackboardattribute("_gibbed_limbs", "right_arm");
    entity setblackboardattribute("_gib_location", "right_arm");
}

// Namespace namespace_eb2895/raz
// Params 2, eflags: 0x1 linked
// Checksum 0xf01cc507, Offset: 0x4990
// Size: 0x332
function function_afcd63e1(attacker, damage) {
    entity = self;
    entity.var_417905cf = 0;
    entity.var_5c09e990 = 0;
    entity.var_a55d2294 = undefined;
    entity.var_6f97029e = 1;
    entity thread namespace_b619101e::function_3c423226();
    if (!isdefined(entity.var_3059ea5f) || !is_true(entity.var_3059ea5f.var_2b605d6f)) {
        function_30df6d2b(entity);
    }
    var_b7949894 = 0.1 * entity.maxhealth;
    var_60d6e159 = 0.05 * entity.maxhealth;
    weapon = getweapon("raz_melee");
    radiusdamage(self.origin + (0, 0, 18), 128, var_b7949894, var_60d6e159, entity, "MOD_PROJECTILE_SPLASH", weapon);
    function_7428d843();
    if (isdefined(attacker)) {
        level notify(#"hash_60f75ee59e5d030f", attacker);
        self notify(#"hash_60f75ee59e5d030f", attacker);
    }
    if (isdefined(damage)) {
        var_64d07420 = entity.health - damage;
        var_8b859118 = entity.maxhealth * 0.33;
        var_fc9b8786 = (var_64d07420 - var_8b859118) / entity.maxhealth;
        if (var_fc9b8786 > 0.25) {
            var_a57e3f9d = entity.health - entity.maxhealth * 0.25;
            callback::callback(#"hash_3886c79a26cace38", {#eattacker:attacker, #var_dcc8dd60:self getentitynumber(), #idamage:var_a57e3f9d, #type:2});
            return var_a57e3f9d;
        }
        callback::callback(#"hash_3886c79a26cace38", {#eattacker:attacker, #var_dcc8dd60:self getentitynumber(), #idamage:var_8b859118, #type:2});
        return var_8b859118;
    }
}

// Namespace namespace_eb2895/raz
// Params 1, eflags: 0x1 linked
// Checksum 0xc468708a, Offset: 0x4cd0
// Size: 0xa0
function function_2eb802f5(attacker) {
    entity = self;
    entity.var_e4fc6a2f = 0;
    entity setblackboardattribute("_gib_location", "head");
    println("<dev string:x71>");
    entity function_5027ed0f();
    if (isdefined(attacker)) {
        level notify(#"hash_84a93496c95c377", attacker);
    }
}

// Namespace namespace_eb2895/raz
// Params 1, eflags: 0x1 linked
// Checksum 0x39e6949f, Offset: 0x4d78
// Size: 0x174
function function_50c2a59e(*attacker) {
    entity = self;
    entity hidepart("j_spine4_attach", "", 1);
    entity hidepart("j_spineupper_attach", "", 1);
    entity hidepart("j_spinelower_attach", "", 1);
    entity hidepart("j_mainroot_attach", "", 1);
    entity hidepart("j_clavicle_ri_attachbp", "", 1);
    entity hidepart("j_clavicle_le_attachbp", "", 1);
    entity.var_8e205014 = 0;
    entity setblackboardattribute("_gib_location", "arms");
    println("<dev string:xa0>");
    entity function_5027ed0f();
}

// Namespace namespace_eb2895/raz
// Params 1, eflags: 0x1 linked
// Checksum 0x974a0be9, Offset: 0x4ef8
// Size: 0xc4
function function_597f31c9(*attacker) {
    entity = self;
    entity hidepart("j_shouldertwist_le_attach", "", 1);
    entity hidepart("j_shoulder_le_attach", "", 1);
    entity hidepart("j_clavicle_le_attach", "", 1);
    entity.var_9f71af13 = 0;
    entity setblackboardattribute("_gib_location", "left_arm");
}

// Namespace namespace_eb2895/raz
// Params 1, eflags: 0x1 linked
// Checksum 0xd1a71ff4, Offset: 0x4fc8
// Size: 0x9c
function function_50f53d3b(*attacker) {
    entity = self;
    entity hidepart("j_hiptwist_le_attach", "", 1);
    entity hidepart("j_hip_le_attach", "", 1);
    entity.var_cb66dfbf = 0;
    entity setblackboardattribute("_gib_location", "left_leg");
}

// Namespace namespace_eb2895/raz
// Params 1, eflags: 0x1 linked
// Checksum 0xc3cf9486, Offset: 0x5070
// Size: 0x9c
function function_578362e9(*attacker) {
    entity = self;
    entity hidepart("j_hiptwist_ri_attach", "", 1);
    entity hidepart("j_hip_ri_attach", "", 1);
    entity.var_c0a83965 = 0;
    entity setblackboardattribute("_gib_location", "right_leg");
}

// Namespace namespace_eb2895/raz
// Params 1, eflags: 0x1 linked
// Checksum 0x28b52ff4, Offset: 0x5118
// Size: 0xc6
function function_296795d8(time) {
    self endon(#"death");
    self notify("700b7151bdab42");
    self endon("700b7151bdab42");
    wait time;
    self.var_4e179643 = 0;
    self.var_e8f3d773 = 0;
    if (!is_true(self.berserk)) {
        self setblackboardattribute("_locomotion_speed", "locomotion_speed_walk");
        self asmsetanimationrate(1);
        self notify(#"hash_ce013f00056f6fe");
    }
}

// Namespace namespace_eb2895/raz
// Params 0, eflags: 0x1 linked
// Checksum 0x8647395f, Offset: 0x51e8
// Size: 0x94
function function_5027ed0f() {
    entity = self;
    entity.var_e8f3d773 = 1;
    entity setblackboardattribute("_locomotion_speed", "locomotion_speed_sprint");
    entity thread namespace_b619101e::function_3c423226();
    entity thread function_296795d8(15);
    entity asmsetanimationrate(1);
}

