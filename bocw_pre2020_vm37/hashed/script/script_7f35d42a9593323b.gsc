#using script_2c5daa95f8fec03c;
#using script_3819e7a1427df6d2;
#using scripts\core_common\ai\archetype_mocomps_utility;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\animation_state_machine_mocomp;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\ai\systems\behavior_state_machine;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai\systems\debug;
#using scripts\core_common\ai\systems\destructible_character;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\burnplayer;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\weapons\mechz_firebomb;
#using scripts\weapons\weaponobjects;

#namespace namespace_3444cb7b;

// Namespace namespace_3444cb7b/mechz
// Params 0, eflags: 0x6
// Checksum 0xa86b4086, Offset: 0x908
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"mechz", &init, undefined, undefined, undefined);
}

// Namespace namespace_3444cb7b/mechz
// Params 0, eflags: 0x1 linked
// Checksum 0x39e22e01, Offset: 0x950
// Size: 0x254
function init() {
    function_eebf86a4();
    spawner::add_archetype_spawn_function(#"mechz", &function_b19391ae);
    spawner::add_archetype_spawn_function(#"mechz", &namespace_8681f0e2::function_3b8b6e80);
    spawner::function_89a2cd87(#"mechz", &namespace_8681f0e2::function_5d873f78);
    clientfield::register("actor", "mechz_ft", 1, 1, "int");
    clientfield::register("actor", "mechz_faceplate_detached", 1, 1, "int");
    clientfield::register("actor", "mechz_powercap_detached", 1, 1, "int");
    clientfield::register("actor", "mechz_claw_detached", 1, 1, "int");
    clientfield::register("actor", "mechz_115_gun_firing", 1, 1, "int");
    clientfield::register("actor", "mechz_headlamp_off", 1, 2, "int");
    clientfield::register("actor", "mechz_long_jump", 1, 1, "counter");
    clientfield::register("actor", "mechz_jetpack_explosion", 1, 1, "int");
    clientfield::register("actor", "mechz_face", 1, 3, "int");
}

// Namespace namespace_3444cb7b/mechz
// Params 0, eflags: 0x5 linked
// Checksum 0x8272c8a, Offset: 0xbb0
// Size: 0x129c
function private function_eebf86a4() {
    assert(isscriptfunctionptr(&mechztargetservice));
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzTargetService", &mechztargetservice);
    assert(isscriptfunctionptr(&mechzgrenadeservice));
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzGrenadeService", &mechzgrenadeservice);
    assert(isscriptfunctionptr(&mechzberserkknockdownservice));
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzBerserkKnockdownService", &mechzberserkknockdownservice);
    assert(isscriptfunctionptr(&mechzLongJumpService));
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzLongJumpService", &mechzLongJumpService, 1);
    assert(isscriptfunctionptr(&mechzshouldmelee));
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzShouldMelee", &mechzshouldmelee);
    assert(isscriptfunctionptr(&mechzshouldshowpain));
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzShouldShowPain", &mechzshouldshowpain);
    assert(isscriptfunctionptr(&mechzshouldshowjetpackpain));
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzShouldShowJetpackPain", &mechzshouldshowjetpackpain);
    assert(isscriptfunctionptr(&mechzenemyinaim));
    behaviorstatemachine::registerbsmscriptapiinternal("mechzEnemyInAim", &mechzenemyinaim);
    assert(isscriptfunctionptr(&mechzshouldshootgrenade));
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzShouldShootGrenade", &mechzshouldshootgrenade);
    assert(isscriptfunctionptr(&mechzshouldshootflame));
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzShouldShootFlame", &mechzshouldshootflame);
    assert(isscriptfunctionptr(&mechzshouldshootflamesweep));
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzShouldShootFlameSweep", &mechzshouldshootflamesweep);
    assert(isscriptfunctionptr(&mechzshouldturnberserk));
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzShouldTurnBerserk", &mechzshouldturnberserk);
    assert(isscriptfunctionptr(&mechzshouldstumble));
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzShouldStumble", &mechzshouldstumble);
    assert(isscriptfunctionptr(&mechzShouldLongJump));
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzShouldLongJump", &mechzShouldLongJump);
    assert(isscriptfunctionptr(&mechzIsJumping));
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzIsJumping", &mechzIsJumping);
    assert(isscriptfunctionptr(&mechzisinsafezone));
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzIsInSafeZone", &mechzisinsafezone);
    assert(!isdefined(&function_db525b31) || isscriptfunctionptr(&function_db525b31));
    assert(!isdefined(&function_c21030e3) || isscriptfunctionptr(&function_c21030e3));
    assert(!isdefined(&function_c13b8a0c) || isscriptfunctionptr(&function_c13b8a0c));
    behaviortreenetworkutility::registerbehaviortreeaction("mechzStumbleLoop", &function_db525b31, &function_c21030e3, &function_c13b8a0c);
    assert(!isdefined(&function_5a7ad15e) || isscriptfunctionptr(&function_5a7ad15e));
    assert(!isdefined(&function_a3c24f6a) || isscriptfunctionptr(&function_a3c24f6a));
    assert(!isdefined(&function_d58e0db5) || isscriptfunctionptr(&function_d58e0db5));
    behaviortreenetworkutility::registerbehaviortreeaction("mechzShootFlameAction", &function_5a7ad15e, &function_a3c24f6a, &function_d58e0db5);
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    assert(!isdefined(&function_ecd21bd2) || isscriptfunctionptr(&function_ecd21bd2));
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    behaviortreenetworkutility::registerbehaviortreeaction("mechzLongJumpLoop", undefined, &function_ecd21bd2, undefined);
    assert(isscriptfunctionptr(&mechzpreptoshootgrenadestart));
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzPrepToShootGrenadeStart", &mechzpreptoshootgrenadestart);
    assert(isscriptfunctionptr(&mechzpreptoshootgrenadestart));
    behaviorstatemachine::registerbsmscriptapiinternal("mechzPrepToShootGrenadeStart", &mechzpreptoshootgrenadestart);
    assert(isscriptfunctionptr(&mechzpreptoshootgrenadesterminate));
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzPrepToShootGrenadesTerminate", &mechzpreptoshootgrenadesterminate);
    assert(isscriptfunctionptr(&mechzpreptoshootgrenadesterminate));
    behaviorstatemachine::registerbsmscriptapiinternal("mechzPrepToShootGrenadesTerminate", &mechzpreptoshootgrenadesterminate);
    assert(isscriptfunctionptr(&mechzshootgrenadestart));
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzShootGrenadeStart", &mechzshootgrenadestart);
    assert(isscriptfunctionptr(&mechzshootgrenadestart));
    behaviorstatemachine::registerbsmscriptapiinternal("mechzShootGrenadeStart", &mechzshootgrenadestart);
    assert(isscriptfunctionptr(&mechzshootgrenadeterminate));
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzShootGrenadeTerminate", &mechzshootgrenadeterminate);
    assert(isscriptfunctionptr(&mechzshootgrenadeterminate));
    behaviorstatemachine::registerbsmscriptapiinternal("mechzShootGrenadeTerminate", &mechzshootgrenadeterminate);
    assert(isscriptfunctionptr(&mechzsetspeedwalk));
    behaviorstatemachine::registerbsmscriptapiinternal("mechzSetSpeedWalk", &mechzsetspeedwalk);
    assert(isscriptfunctionptr(&mechzsetspeedrun));
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzSetSpeedRun", &mechzsetspeedrun);
    assert(isscriptfunctionptr(&mechzshootflame));
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzShootFlame", &mechzshootflame);
    assert(isscriptfunctionptr(&mechzupdateflame));
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzUpdateFlame", &mechzupdateflame);
    assert(isscriptfunctionptr(&mechzstopflame));
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzStopFlame", &mechzstopflame);
    assert(isscriptfunctionptr(&mechzplayedberserkintro));
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzPlayedBerserkIntro", &mechzplayedberserkintro);
    assert(isscriptfunctionptr(&mechzattackstart));
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzAttackStart", &mechzattackstart);
    assert(isscriptfunctionptr(&mechzdeathstart));
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzDeathStart", &mechzdeathstart);
    assert(isscriptfunctionptr(&mechzidlestart));
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzIdleStart", &mechzidlestart);
    assert(isscriptfunctionptr(&mechzpainstart));
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzPainStart", &mechzpainstart);
    assert(isscriptfunctionptr(&mechzpainterminate));
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzPainTerminate", &mechzpainterminate);
    assert(isscriptfunctionptr(&mechzjetpackpainterminate));
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzJetpackPainTerminate", &mechzjetpackpainterminate);
    assert(isscriptfunctionptr(&mechzLongJumpStart));
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzLongJumpStart", &mechzLongJumpStart);
    assert(isscriptfunctionptr(&mechzLongJumpTerminate));
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzLongJumpTerminate", &mechzLongJumpTerminate);
    animationstatenetwork::registeranimationmocomp("mocomp_mechz_long_jump", &function_e2c3704e, &function_9ba82c0a, &function_62826a8e);
    animationstatenetwork::registeranimationmocomp("mocomp_mechz_long_jump_face_goal", &function_1cc76960, undefined, &function_65225d1f);
    animationstatenetwork::registernotetrackhandlerfunction("melee_soldat", &function_d9de8431);
    animationstatenetwork::registernotetrackhandlerfunction("fire_chaingun", &function_e26728bc);
    animationstatenetwork::registernotetrackhandlerfunction("jump_shake", &function_4e89924a);
}

// Namespace namespace_3444cb7b/mechz
// Params 0, eflags: 0x5 linked
// Checksum 0x5a2d3b3d, Offset: 0x1e58
// Size: 0x32
function private function_b19391ae() {
    blackboard::createblackboardforentity(self);
    self.___archetypeonanimscriptedcallback = &function_dd01e0e4;
}

// Namespace namespace_3444cb7b/mechz
// Params 1, eflags: 0x5 linked
// Checksum 0x8c04978f, Offset: 0x1e98
// Size: 0x2c
function private function_dd01e0e4(entity) {
    entity.__blackboard = undefined;
    entity function_b19391ae();
}

// Namespace namespace_3444cb7b/mechz
// Params 1, eflags: 0x5 linked
// Checksum 0xfffc79d8, Offset: 0x1ed0
// Size: 0x44
function private function_d9de8431(entity) {
    if (isdefined(entity.var_9d23af0d)) {
        entity thread [[ entity.var_9d23af0d ]]();
    }
    entity melee();
}

// Namespace namespace_3444cb7b/mechz
// Params 1, eflags: 0x5 linked
// Checksum 0x220fcc68, Offset: 0x1f20
// Size: 0x28c
function private function_e26728bc(entity) {
    if (!isdefined(entity.enemy)) {
        return;
    }
    var_3e3a3402 = entity.enemy.origin;
    v_velocity = entity.enemy getvelocity();
    var_b6897326 = randomfloatrange(1, 2.5);
    var_3e3a3402 += v_velocity * var_b6897326;
    var_736d384 = math::randomsign() * randomint(48);
    var_6b1c9b42 = math::randomsign() * randomint(48);
    target_pos = var_3e3a3402 + (var_736d384, var_6b1c9b42, 0);
    dir = vectortoangles(target_pos - entity.origin);
    dir = anglestoforward(dir);
    var_7e2cde6 = dir * 5;
    var_8598bad6 = entity gettagorigin("tag_gun_barrel2") + var_7e2cde6;
    dist = distance(var_8598bad6, target_pos);
    velocity = dir * dist;
    velocity += (0, 0, 120);
    val = 1;
    oldval = entity clientfield::get("mechz_115_gun_firing");
    if (oldval === val) {
        val = 0;
    }
    entity clientfield::set("mechz_115_gun_firing", val);
    entity magicgrenadetype(getweapon("eq_mechz_firebomb"), var_8598bad6, velocity);
}

// Namespace namespace_3444cb7b/mechz
// Params 1, eflags: 0x1 linked
// Checksum 0x77319ce0, Offset: 0x21b8
// Size: 0x2c
function function_4e89924a(entity) {
    entity clientfield::increment("mechz_long_jump");
}

// Namespace namespace_3444cb7b/mechz
// Params 1, eflags: 0x1 linked
// Checksum 0x1947433a, Offset: 0x21f0
// Size: 0x238
function mechztargetservice(entity) {
    if (is_true(entity.ignoreall)) {
        return 0;
    }
    if (isdefined(entity.var_11efa4b6)) {
        return 0;
    }
    player = zombie_utility::get_closest_valid_player(self.origin, self.ignore_player);
    entity.favoriteenemy = player;
    if (!isdefined(player) || player isnotarget()) {
        if (isdefined(entity.ignore_player)) {
            if (isdefined(level._should_skip_ignore_player_logic) && [[ level._should_skip_ignore_player_logic ]]()) {
                return;
            }
            entity.ignore_player = [];
        }
        /#
            if (is_true(level.var_19bb726b)) {
                entity setgoal(entity.origin);
                return 0;
            }
        #/
        if (isdefined(level.no_target_override)) {
            [[ level.no_target_override ]](entity);
        } else {
            entity setgoal(entity.origin);
        }
        return 0;
    }
    if (isdefined(level.enemy_location_override_func)) {
        var_2c9acc81 = [[ level.enemy_location_override_func ]](entity, player);
        if (isdefined(var_2c9acc81)) {
            entity setgoal(var_2c9acc81);
            return 1;
        }
    }
    targetpos = getclosestpointonnavmesh(player.origin, 64, 30);
    if (isdefined(targetpos)) {
        entity setgoal(targetpos);
        return 1;
    }
    entity setgoal(entity.origin);
    return 0;
}

// Namespace namespace_3444cb7b/mechz
// Params 1, eflags: 0x5 linked
// Checksum 0xc41d7a8b, Offset: 0x2430
// Size: 0xce
function private mechzgrenadeservice(entity) {
    if (!isdefined(entity.var_a0e09fde)) {
        entity.var_a0e09fde = 0;
    }
    if (entity.var_a0e09fde >= 1) {
        if (gettime() > entity.var_a8e56aa3) {
            entity.var_a0e09fde = 0;
        }
    }
    if (isdefined(level.var_542ac835)) {
        arrayremovevalue(level.var_542ac835, undefined);
        var_a4615441 = array::filter(level.var_542ac835, 0, &function_424646a8, entity);
        entity.var_856a7b8a = var_a4615441.size;
        return;
    }
    entity.var_856a7b8a = 0;
}

// Namespace namespace_3444cb7b/mechz
// Params 2, eflags: 0x5 linked
// Checksum 0x62f81e02, Offset: 0x2508
// Size: 0x30
function private function_424646a8(grenade, mechz) {
    if (grenade.owner === mechz) {
        return true;
    }
    return false;
}

// Namespace namespace_3444cb7b/mechz
// Params 1, eflags: 0x5 linked
// Checksum 0x874656e5, Offset: 0x2540
// Size: 0x3ce
function private mechzberserkknockdownservice(entity) {
    velocity = entity getvelocity();
    var_b98d779c = 0.3;
    var_6c6317b9 = entity.origin + velocity * var_b98d779c;
    move_dist_sq = distancesquared(var_6c6317b9, entity.origin);
    speed = move_dist_sq / var_b98d779c;
    if (speed >= 10) {
        a_zombies = getentitiesinradius(entity.origin, 48, 15);
        var_eb2cabb5 = array::filter(a_zombies, 0, &function_c01bcef, entity, var_6c6317b9);
        if (var_eb2cabb5.size > 0) {
            foreach (zombie in var_eb2cabb5) {
                zombie.knockdown = 1;
                zombie.knockdown_type = "knockdown_shoved";
                var_c255a411 = entity.origin - zombie.origin;
                var_3355d62f = vectornormalize((var_c255a411[0], var_c255a411[1], 0));
                zombie_forward = anglestoforward(zombie.angles);
                zombie_forward_2d = vectornormalize((zombie_forward[0], zombie_forward[1], 0));
                zombie_right = anglestoright(zombie.angles);
                zombie_right_2d = vectornormalize((zombie_right[0], zombie_right[1], 0));
                dot = vectordot(var_3355d62f, zombie_forward_2d);
                if (dot >= 0.5) {
                    zombie.knockdown_direction = "front";
                    zombie.getup_direction = "getup_back";
                    continue;
                }
                if (dot < 0.5 && dot > -0.5) {
                    dot = vectordot(var_3355d62f, zombie_right_2d);
                    if (dot > 0) {
                        zombie.knockdown_direction = "right";
                        if (math::cointoss()) {
                            zombie.getup_direction = "getup_back";
                        } else {
                            zombie.getup_direction = "getup_belly";
                        }
                    } else {
                        zombie.knockdown_direction = "left";
                        zombie.getup_direction = "getup_belly";
                    }
                    continue;
                }
                zombie.knockdown_direction = "back";
                zombie.getup_direction = "getup_belly";
            }
        }
    }
}

// Namespace namespace_3444cb7b/mechz
// Params 3, eflags: 0x5 linked
// Checksum 0x66679368, Offset: 0x2918
// Size: 0x178
function private function_c01bcef(zombie, mechz, *var_6c6317b9) {
    if (!isdefined(mechz) || !isdefined(var_6c6317b9)) {
        return false;
    }
    if (mechz.knockdown === 1) {
        return false;
    }
    if (mechz.archetype !== #"zombie") {
        return false;
    }
    if (mechz.var_33fb0350 === 1) {
        return false;
    }
    origin = var_6c6317b9.origin;
    var_3c08a493 = anglestoforward(var_6c6317b9.angles);
    var_e14511cb = mechz.origin - origin;
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

// Namespace namespace_3444cb7b/mechz
// Params 1, eflags: 0x1 linked
// Checksum 0xb32155b1, Offset: 0x2a98
// Size: 0x23a
function function_12925fd(entity) {
    if (isdefined(entity.var_4b559171)) {
        goalpos = getclosestpointonnavmesh(entity.var_4b559171, 256, entity getpathfindingradius() * 1.2);
        entity.var_4b559171 = undefined;
    } else {
        goalinfo = entity function_4794d6a3();
        if (!isdefined(goalinfo) || !isdefined(goalinfo.goalpos)) {
            return undefined;
        }
        if (isdefined(entity.favoriteenemy)) {
            velocity = entity.favoriteenemy getvelocity();
            goalpos = goalinfo.goalpos + velocity * 1;
            goalpos = getclosestpointonnavmesh(goalpos, 256, entity getpathfindingradius() * 1.2);
        } else {
            goalpos = getclosestpointonnavmesh(goalinfo.goalpos, 256, entity getpathfindingradius() * 1.2);
        }
        if (!isdefined(goalpos)) {
            return undefined;
        }
        if (isdefined(entity.favoriteenemy) && distancesquared(entity.favoriteenemy.origin, goalpos) < function_a3f6cdac(96)) {
            to_origin = entity.origin - goalpos;
            goalpos = checknavmeshdirection(goalpos, to_origin, 96, entity getpathfindingradius() * 1.2);
        }
    }
    return goalpos;
}

// Namespace namespace_3444cb7b/mechz
// Params 1, eflags: 0x1 linked
// Checksum 0x6307b4db, Offset: 0x2ce0
// Size: 0x7e8
function mechzLongJumpService(entity) {
    if (isdefined(entity.var_80dcda45) || gettime() < entity.var_29386166 || !is_true(entity.var_7c4488fd)) {
        return 0;
    }
    goalpos = function_12925fd(entity);
    if (!isdefined(goalpos)) {
        return 0;
    }
    if (distance2dsquared(entity.origin, goalpos) <= function_a3f6cdac(500) && abs(entity.origin[2] - goalpos[2]) <= 2000) {
        return 0;
    }
    startpos = entity.origin + getmovedelta(#"hash_2cf640e3ec8ad827", 0, 1);
    distance2d = distance2d(goalpos, startpos);
    dir = goalpos - startpos;
    dir = (dir[0], dir[1], 0);
    dir = vectornormalize(dir);
    time = mapfloat(500, 10000, 1, 3.5, distance2d);
    /#
        record3dtext(time, entity.origin, (0, 0, 1), "<dev string:x38>", entity);
    #/
    time /= float(function_60d95f53()) / 1000;
    var_199c57d2 = distance2d / time;
    var_ef97a46c = (goalpos[2] - startpos[2] + 2.25 * function_a3f6cdac(time)) / time;
    entity.var_80dcda45 = {#time:1, #startpos:startpos, #nextpos:startpos, #goal:goalpos, #to_goal:goalpos - startpos, #vel:(dir[0] * var_199c57d2, dir[1] * var_199c57d2, var_ef97a46c)};
    entity.var_80dcda45.nextpos = entity.var_80dcda45.startpos + entity.var_80dcda45.vel * entity.var_80dcda45.time + 0.5 * (0, 0, -1) * 4.5 * function_a3f6cdac(entity.var_80dcda45.time);
    /#
        recordsphere(entity.var_80dcda45.goal, 10, (0, 0, 1), "<dev string:x38>", entity);
        recordline(startpos, entity.var_80dcda45.goal, (0, 0, 1), "<dev string:x38>", entity);
        prev_origin = startpos;
        for (i = 1; i <= time; i++) {
            pos = entity.var_80dcda45.startpos + entity.var_80dcda45.vel * i + 0.5 * (0, 0, -1) * 4.5 * function_a3f6cdac(i);
            recordline(prev_origin, pos, (0, 0, 1), "<dev string:x38>", entity);
            record3dtext(i, pos, (0, 0, 1), "<dev string:x38>", entity);
            prev_origin = pos;
        }
        recordline(prev_origin, entity.var_80dcda45.goal, (0, 0, 1), "<dev string:x38>", entity);
        record3dtext(i, entity.var_80dcda45.goal, (0, 0, 1), "<dev string:x38>", entity);
    #/
    prev_origin = entity.origin;
    passed = 1;
    for (i = 1; i <= 5; i++) {
        var_21dd2ef6 = time / 5 * i;
        pos = entity.var_80dcda45.startpos + entity.var_80dcda45.vel * var_21dd2ef6 + 0.5 * (0, 0, -1) * 4.5 * function_a3f6cdac(var_21dd2ef6);
        traceresult = physicstraceex(prev_origin, pos, entity getmins(), entity getmaxs(), entity);
        if (traceresult[#"fraction"] != 1) {
            if (traceresult[#"normal"][2] < sin(10)) {
                /#
                    recordline(prev_origin, pos, (1, 0, 0), "<dev string:x38>", entity);
                    recordsphere(traceresult[#"position"], 5, (1, 1, 0), "<dev string:x38>", entity);
                    recordline(traceresult[#"position"], traceresult[#"position"] + traceresult[#"normal"] * 20, (1, 1, 0), "<dev string:x38>", entity);
                #/
                passed = 0;
                break;
            }
            pointonnavmesh = function_9cc082d2(traceresult[#"position"], 2 * 39.3701);
            if (!isdefined(pointonnavmesh)) {
                /#
                    recordline(prev_origin, pos, (1, 0, 0), "<dev string:x38>", entity);
                #/
                passed = 0;
                break;
            }
        }
        /#
            recordline(prev_origin, pos, (0, 1, 0), "<dev string:x38>", entity);
        #/
        prev_origin = pos;
    }
    if (!passed) {
        entity.var_80dcda45 = undefined;
        return;
    }
}

// Namespace namespace_3444cb7b/mechz
// Params 1, eflags: 0x1 linked
// Checksum 0xbae247ec, Offset: 0x34d0
// Size: 0xca
function mechzshouldmelee(entity) {
    if (!isdefined(entity.enemy)) {
        return false;
    }
    if (distancesquared(entity.origin, entity.enemy.origin) > 12544) {
        return false;
    }
    if (is_true(entity.enemy.usingvehicle)) {
        return true;
    }
    yaw = abs(zombie_utility::getyawtoenemy());
    if (yaw > 45) {
        return false;
    }
    return true;
}

// Namespace namespace_3444cb7b/mechz
// Params 1, eflags: 0x5 linked
// Checksum 0xebbb4d62, Offset: 0x35a8
// Size: 0x28
function private mechzshouldshowpain(entity) {
    if (entity.var_bc17791c === 1) {
        return true;
    }
    return false;
}

// Namespace namespace_3444cb7b/mechz
// Params 1, eflags: 0x5 linked
// Checksum 0x93f87389, Offset: 0x35d8
// Size: 0x28
function private mechzshouldshowjetpackpain(entity) {
    if (entity.var_97601164 === 1) {
        return true;
    }
    return false;
}

// Namespace namespace_3444cb7b/mechz
// Params 1, eflags: 0x5 linked
// Checksum 0x65b9bc97, Offset: 0x3608
// Size: 0x2e
function private mechzenemyinaim(entity) {
    if (entity namespace_8681f0e2::function_923942a7()) {
        return true;
    }
    return false;
}

// Namespace namespace_3444cb7b/mechz
// Params 1, eflags: 0x5 linked
// Checksum 0x28945f41, Offset: 0x3640
// Size: 0x11e
function private mechzshouldshootgrenade(entity) {
    if (entity.berserk === 1) {
        return false;
    }
    if (entity.var_d03c4664 !== 1) {
        return false;
    }
    if (is_true(self.ignoreall)) {
        return false;
    }
    if (!isdefined(entity.favoriteenemy)) {
        return false;
    }
    if (entity.var_a0e09fde >= 1) {
        return false;
    }
    if (entity.var_856a7b8a >= 3) {
        return false;
    }
    if (!entity cansee(entity.favoriteenemy)) {
        return false;
    }
    dist_sq = distancesquared(entity.origin, entity.favoriteenemy.origin);
    if (dist_sq < 62500 || dist_sq > 1440000) {
        return false;
    }
    return true;
}

// Namespace namespace_3444cb7b/mechz
// Params 1, eflags: 0x1 linked
// Checksum 0xbedbff99, Offset: 0x3768
// Size: 0x1b6
function mechzshouldshootflame(entity) {
    /#
        if (is_true(entity.var_7b41c3ce)) {
            return true;
        }
    #/
    if (entity.berserk === 1) {
        return false;
    }
    if (is_true(entity.var_492622ad) && gettime() < entity.var_b25ccf7) {
        return true;
    }
    if (!isdefined(entity.favoriteenemy)) {
        return false;
    }
    if (entity.var_492622ad === 1 && entity.var_b25ccf7 <= gettime()) {
        return false;
    }
    if (entity.var_e05f2c0a > gettime()) {
        return false;
    }
    if (!entity namespace_8681f0e2::function_923942a7(26)) {
        return false;
    }
    dist_sq = distancesquared(entity.origin, entity.favoriteenemy.origin);
    if (dist_sq < 9216 || dist_sq > 90000) {
        return false;
    }
    can_see = bullettracepassed(entity.origin + (0, 0, 36), entity.favoriteenemy.origin + (0, 0, 36), 0, undefined);
    if (!can_see) {
        return false;
    }
    return true;
}

// Namespace namespace_3444cb7b/mechz
// Params 1, eflags: 0x5 linked
// Checksum 0x66a2ba57, Offset: 0x3928
// Size: 0xb4
function private mechzshouldshootflamesweep(entity) {
    if (entity.berserk === 1) {
        return false;
    }
    if (!mechzshouldshootflame(entity)) {
        return false;
    }
    if (randomint(100) > 10) {
        return false;
    }
    var_39156533 = 0;
    players = getplayers(undefined, entity.origin, 100);
    if (players.size < 2) {
        return false;
    }
    return true;
}

// Namespace namespace_3444cb7b/mechz
// Params 1, eflags: 0x5 linked
// Checksum 0x2dc96a94, Offset: 0x39e8
// Size: 0x3e
function private mechzshouldturnberserk(entity) {
    if (entity.berserk === 1 && entity.var_5eca4346 !== 1) {
        return true;
    }
    return false;
}

// Namespace namespace_3444cb7b/mechz
// Params 1, eflags: 0x5 linked
// Checksum 0x9e9c1957, Offset: 0x3a30
// Size: 0x2e
function private mechzshouldstumble(entity) {
    if (is_true(entity.stumble)) {
        return true;
    }
    return false;
}

// Namespace namespace_3444cb7b/mechz
// Params 1, eflags: 0x5 linked
// Checksum 0x280e2a57, Offset: 0x3a68
// Size: 0x24
function private mechzShouldLongJump(entity) {
    if (isdefined(entity.var_80dcda45)) {
        return true;
    }
    return false;
}

// Namespace namespace_3444cb7b/mechz
// Params 1, eflags: 0x5 linked
// Checksum 0x63af5c4e, Offset: 0x3a98
// Size: 0x2e
function private mechzIsJumping(entity) {
    if (is_true(entity.isjumping)) {
        return true;
    }
    return false;
}

// Namespace namespace_3444cb7b/mechz
// Params 1, eflags: 0x1 linked
// Checksum 0x823677f5, Offset: 0x3ad0
// Size: 0x80
function mechzisinsafezone(entity) {
    if (!isdefined(entity.favoriteenemy)) {
        return false;
    }
    distsqr = distancesquared(entity.origin, entity.favoriteenemy.origin);
    if (distsqr < 360000 && distsqr > 50625) {
        return true;
    }
    return false;
}

// Namespace namespace_3444cb7b/mechz
// Params 2, eflags: 0x4
// Checksum 0xfe23926f, Offset: 0x3b58
// Size: 0x42
function private function_cc7ec28(entity, asmstatename) {
    animationstatenetworkutility::requeststate(entity, asmstatename);
    entity.var_83ce7c8f = gettime() + 3000;
    return 5;
}

// Namespace namespace_3444cb7b/mechz
// Params 2, eflags: 0x4
// Checksum 0xc96f67af, Offset: 0x3ba8
// Size: 0x38
function private function_d09ba7f5(entity, *asmstatename) {
    if (!is_true(asmstatename.var_2cf1dc08)) {
        return 4;
    }
    return 5;
}

// Namespace namespace_3444cb7b/mechz
// Params 2, eflags: 0x5 linked
// Checksum 0xa70df361, Offset: 0x3be8
// Size: 0x42
function private function_db525b31(entity, asmstatename) {
    animationstatenetworkutility::requeststate(entity, asmstatename);
    entity.var_773b5b9a = gettime() + 500;
    return 5;
}

// Namespace namespace_3444cb7b/mechz
// Params 2, eflags: 0x5 linked
// Checksum 0x9d87cddc, Offset: 0x3c38
// Size: 0x2c
function private function_c21030e3(entity, *asmstatename) {
    if (gettime() > asmstatename.var_773b5b9a) {
        return 4;
    }
    return 5;
}

// Namespace namespace_3444cb7b/mechz
// Params 2, eflags: 0x5 linked
// Checksum 0xec726b18, Offset: 0x3c70
// Size: 0x32
function private function_c13b8a0c(entity, *asmstatename) {
    asmstatename.stumble = 0;
    asmstatename.var_57fca545 = gettime() + 10000;
    return 4;
}

// Namespace namespace_3444cb7b/mechz
// Params 2, eflags: 0x1 linked
// Checksum 0xe85dc36d, Offset: 0x3cb0
// Size: 0x56
function function_5a7ad15e(entity, asmstatename) {
    animationstatenetworkutility::requeststate(entity, asmstatename);
    mechzshootflame(entity);
    entity.blindaim = 1;
    return 5;
}

// Namespace namespace_3444cb7b/mechz
// Params 2, eflags: 0x1 linked
// Checksum 0xa7966a98, Offset: 0x3d10
// Size: 0x100
function function_a3c24f6a(entity, *asmstatename) {
    if (is_true(asmstatename.berserk)) {
        mechzstopflame(asmstatename);
        return 4;
    }
    if (is_true(mechzshouldmelee(asmstatename))) {
        mechzstopflame(asmstatename);
        return 4;
    }
    if (is_true(asmstatename.var_492622ad)) {
        if (isdefined(asmstatename.var_b25ccf7) && gettime() > asmstatename.var_b25ccf7) {
            mechzstopflame(asmstatename);
            return 4;
        }
        mechzupdateflame(asmstatename);
    }
    return 5;
}

// Namespace namespace_3444cb7b/mechz
// Params 2, eflags: 0x1 linked
// Checksum 0x395a65dd, Offset: 0x3e18
// Size: 0x3a
function function_d58e0db5(entity, *asmstatename) {
    mechzstopflame(asmstatename);
    asmstatename.blindaim = 0;
    return 4;
}

// Namespace namespace_3444cb7b/mechz
// Params 2, eflags: 0x1 linked
// Checksum 0x6c15911c, Offset: 0x3e60
// Size: 0x340
function function_ecd21bd2(entity, asmstatename) {
    if (!isdefined(entity.var_80dcda45)) {
        return 4;
    }
    if (entity asmgetstatus() == "asm_status_complete" && isdefined(asmstatename)) {
        animationstatenetworkutility::requeststate(entity, asmstatename);
    }
    entity.var_80dcda45.time += 1;
    entity.var_80dcda45.nextpos = entity.var_80dcda45.startpos + entity.var_80dcda45.vel * entity.var_80dcda45.time + 0.5 * (0, 0, -1) * 4.5 * function_a3f6cdac(entity.var_80dcda45.time);
    var_f423e961 = entity.var_80dcda45.goal - entity.var_80dcda45.nextpos;
    if (vectordot((var_f423e961[0], var_f423e961[1], 0), (entity.var_80dcda45.to_goal[0], entity.var_80dcda45.to_goal[1], 0)) < 0) {
        /#
            recordsphere(entity.var_80dcda45.goal, 10, (0, 1, 0), "<dev string:x38>", entity);
            recordline(entity.origin, entity.var_80dcda45.goal, (0, 1, 0), "<dev string:x38>", entity);
        #/
        entity.var_80dcda45.endpos = entity.var_80dcda45.goal;
        return 4;
    }
    traceresult = physicstraceex(entity.origin, entity.var_80dcda45.nextpos, entity getmins(), entity getmaxs(), entity);
    if (traceresult[#"fraction"] != 1) {
        /#
            recordsphere(traceresult[#"position"], 10, (0, 1, 0), "<dev string:x38>", entity);
            recordline(entity.origin, traceresult[#"position"], (0, 1, 0), "<dev string:x38>", entity);
        #/
        entity.var_80dcda45.endpos = traceresult[#"position"];
        return 4;
    }
    return 5;
}

// Namespace namespace_3444cb7b/mechz
// Params 1, eflags: 0x5 linked
// Checksum 0xf184ea0b, Offset: 0x41a8
// Size: 0x1e
function private mechzpreptoshootgrenadestart(entity) {
    entity.blindaim = 1;
    return true;
}

// Namespace namespace_3444cb7b/mechz
// Params 1, eflags: 0x5 linked
// Checksum 0xb0acd748, Offset: 0x41d0
// Size: 0x1a
function private mechzpreptoshootgrenadesterminate(entity) {
    entity.blindaim = 0;
    return true;
}

// Namespace namespace_3444cb7b/mechz
// Params 1, eflags: 0x5 linked
// Checksum 0xb511ee0c, Offset: 0x41f8
// Size: 0x4e
function private mechzshootgrenadestart(entity) {
    entity.var_a0e09fde++;
    if (entity.var_a0e09fde >= 1) {
        entity.var_a8e56aa3 = gettime() + 6000;
    }
    entity.blindaim = 1;
    return true;
}

// Namespace namespace_3444cb7b/mechz
// Params 1, eflags: 0x5 linked
// Checksum 0xa8a70a94, Offset: 0x4250
// Size: 0x50
function private mechzshootgrenadeterminate(entity) {
    entity.blindaim = 0;
    entity clearpath();
    entity setgoal(entity.origin);
    return true;
}

// Namespace namespace_3444cb7b/mechz
// Params 1, eflags: 0x5 linked
// Checksum 0xd71b3f46, Offset: 0x42a8
// Size: 0x34
function private mechzsetspeedwalk(entity) {
    entity setblackboardattribute("_locomotion_speed", "locomotion_speed_walk");
}

// Namespace namespace_3444cb7b/mechz
// Params 1, eflags: 0x5 linked
// Checksum 0xdff41e55, Offset: 0x42e8
// Size: 0x34
function private mechzsetspeedrun(entity) {
    entity setblackboardattribute("_locomotion_speed", "locomotion_speed_run");
}

// Namespace namespace_3444cb7b/mechz
// Params 1, eflags: 0x5 linked
// Checksum 0xabe12a22, Offset: 0x4328
// Size: 0x24
function private mechzshootflame(entity) {
    entity thread function_35c0aac1();
}

// Namespace namespace_3444cb7b/mechz
// Params 0, eflags: 0x5 linked
// Checksum 0x999797fa, Offset: 0x4358
// Size: 0x8a
function private function_35c0aac1() {
    self endon(#"death");
    self notify(#"hash_35afb115cb92d570");
    self endon(#"hash_35afb115cb92d570");
    wait 0.3;
    self clientfield::set("mechz_ft", 1);
    self.var_492622ad = 1;
    self.var_b25ccf7 = gettime() + 2500;
}

// Namespace namespace_3444cb7b/mechz
// Params 1, eflags: 0x5 linked
// Checksum 0x3d5bfaa9, Offset: 0x43f0
// Size: 0x15c
function private mechzupdateflame(entity) {
    if (isdefined(level.var_27748d3)) {
        [[ level.var_27748d3 ]](entity);
    } else {
        players = getplayers();
        foreach (player in players) {
            if (!is_true(player.is_burning)) {
                if (player istouching(entity.var_1df3d140)) {
                    if (isdefined(entity.var_13fbc6ec)) {
                        player thread [[ entity.var_13fbc6ec ]]();
                        continue;
                    }
                    player thread function_5afe5280(entity);
                }
            }
        }
    }
    if (isdefined(level.var_449f9dce)) {
        [[ level.var_449f9dce ]](entity);
    }
}

// Namespace namespace_3444cb7b/mechz
// Params 1, eflags: 0x1 linked
// Checksum 0x910e996, Offset: 0x4558
// Size: 0x10e
function function_5afe5280(mechz) {
    self endon(#"death");
    self endon(#"disconnect");
    if (!is_true(self.is_burning) && zombie_utility::is_player_valid(self, 1)) {
        self.is_burning = 1;
        if (!self hasperk("specialty_armorvest")) {
            self burnplayer::setplayerburning(1.5, 0.5, 30, mechz, undefined);
        } else {
            self burnplayer::setplayerburning(1.5, 0.5, 20, mechz, undefined);
        }
        wait 1.5;
        self.is_burning = 0;
    }
}

// Namespace namespace_3444cb7b/mechz
// Params 1, eflags: 0x1 linked
// Checksum 0x5614b900, Offset: 0x4670
// Size: 0x8a
function mechzstopflame(entity) {
    self notify(#"hash_35afb115cb92d570");
    entity clientfield::set("mechz_ft", 0);
    entity.var_492622ad = 0;
    var_82d51e42 = randomintrange(2500, 3500);
    entity.var_e05f2c0a = gettime() + var_82d51e42;
    entity.var_b25ccf7 = undefined;
}

// Namespace namespace_3444cb7b/mechz
// Params 0, eflags: 0x1 linked
// Checksum 0x969bc0b6, Offset: 0x4708
// Size: 0x8c
function function_34d763b5() {
    entity = self;
    g_time = gettime();
    entity.var_c109fa4b = g_time + 10000;
    if (entity.berserk !== 1) {
        entity.berserk = 1;
        entity thread function_9e135033();
        entity setblackboardattribute("_locomotion_speed", "locomotion_speed_sprint");
    }
}

// Namespace namespace_3444cb7b/mechz
// Params 1, eflags: 0x5 linked
// Checksum 0xae28c6eb, Offset: 0x47a0
// Size: 0x1a
function private mechzplayedberserkintro(entity) {
    entity.var_5eca4346 = 1;
}

// Namespace namespace_3444cb7b/mechz
// Params 0, eflags: 0x5 linked
// Checksum 0xda1d75dd, Offset: 0x47c8
// Size: 0xb0
function private function_9e135033() {
    self endon(#"death");
    self endon(#"disconnect");
    while (self.berserk === 1) {
        if (gettime() >= self.var_c109fa4b) {
            self.berserk = 0;
            self.var_5eca4346 = 0;
            self asmsetanimationrate(1);
            self setblackboardattribute("_locomotion_speed", "locomotion_speed_run");
        }
        wait 0.25;
    }
}

// Namespace namespace_3444cb7b/mechz
// Params 1, eflags: 0x5 linked
// Checksum 0x1e402f7c, Offset: 0x4880
// Size: 0x2c
function private mechzattackstart(entity) {
    entity clientfield::set("mechz_face", 1);
}

// Namespace namespace_3444cb7b/mechz
// Params 1, eflags: 0x5 linked
// Checksum 0x8ecb1546, Offset: 0x48b8
// Size: 0x2c
function private mechzdeathstart(entity) {
    entity clientfield::set("mechz_face", 2);
}

// Namespace namespace_3444cb7b/mechz
// Params 1, eflags: 0x5 linked
// Checksum 0x7ed88d30, Offset: 0x48f0
// Size: 0x2c
function private mechzidlestart(entity) {
    entity clientfield::set("mechz_face", 3);
}

// Namespace namespace_3444cb7b/mechz
// Params 1, eflags: 0x5 linked
// Checksum 0x621150e4, Offset: 0x4928
// Size: 0x2c
function private mechzpainstart(entity) {
    entity clientfield::set("mechz_face", 4);
}

// Namespace namespace_3444cb7b/mechz
// Params 1, eflags: 0x5 linked
// Checksum 0xb45c24bb, Offset: 0x4960
// Size: 0x22
function private mechzpainterminate(entity) {
    entity.var_bc17791c = 0;
    entity.var_54db22a4 = undefined;
}

// Namespace namespace_3444cb7b/mechz
// Params 1, eflags: 0x5 linked
// Checksum 0x91704382, Offset: 0x4990
// Size: 0x2c
function private mechzjetpackpainterminate(entity) {
    entity.var_97601164 = 0;
    mechzpainterminate(entity);
}

// Namespace namespace_3444cb7b/mechz
// Params 1, eflags: 0x5 linked
// Checksum 0xc28ee173, Offset: 0x49c8
// Size: 0x3c
function private mechzLongJumpStart(entity) {
    entity.isjumping = 1;
    entity callback::callback(#"hash_1c5ac76933317a1d");
}

// Namespace namespace_3444cb7b/mechz
// Params 1, eflags: 0x5 linked
// Checksum 0xe23605d5, Offset: 0x4a10
// Size: 0x7c
function private mechzLongJumpTerminate(entity) {
    entity.isjumping = undefined;
    entity.var_29386166 = gettime() + 3000 + randomfloat(2000);
    entity callback::callback(#"hash_6ce1d15fa3e62552");
    entity setgoal(entity.origin);
}

// Namespace namespace_3444cb7b/mechz
// Params 5, eflags: 0x5 linked
// Checksum 0xd1677e, Offset: 0x4a98
// Size: 0xdc
function private function_e2c3704e(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    mocompduration animmode("zonly_physics", 1);
    mocompduration pathmode("dont move");
    mocompduration.blockingpain = 1;
    mocompduration orientmode("face angle", vectortoangles((mocompduration.var_80dcda45.vel[0], mocompduration.var_80dcda45.vel[1], 0))[1]);
}

// Namespace namespace_3444cb7b/mechz
// Params 5, eflags: 0x5 linked
// Checksum 0x30d91835, Offset: 0x4b80
// Size: 0x5c
function private function_9ba82c0a(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    mocompduration forceteleport(mocompduration.var_80dcda45.nextpos, mocompduration.angles, 0);
}

// Namespace namespace_3444cb7b/mechz
// Params 5, eflags: 0x5 linked
// Checksum 0x2bad9445, Offset: 0x4be8
// Size: 0xb6
function private function_62826a8e(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    if (isdefined(mocompduration.var_80dcda45.endpos)) {
        mocompduration forceteleport(mocompduration.var_80dcda45.endpos, mocompduration.angles, 0);
    }
    mocompduration pathmode("move allowed", 1);
    mocompduration.blockingpain = 0;
    mocompduration.var_80dcda45 = undefined;
    mocompduration.var_c93384f1 = undefined;
}

// Namespace namespace_3444cb7b/mechz
// Params 5, eflags: 0x5 linked
// Checksum 0x9a644703, Offset: 0x4ca8
// Size: 0xdc
function private function_1cc76960(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    mocompduration pathmode("dont move");
    mocompduration.blockingpain = 1;
    mocompduration animmode("zonly_physics", 1);
    mocompduration orientmode("face angle", vectortoangles((mocompduration.var_80dcda45.vel[0], mocompduration.var_80dcda45.vel[1], 0))[1]);
}

// Namespace namespace_3444cb7b/mechz
// Params 5, eflags: 0x5 linked
// Checksum 0xacd2a475, Offset: 0x4d90
// Size: 0x56
function private function_65225d1f(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    mocompduration pathmode("move allowed");
    mocompduration.blockingpain = 0;
}

#namespace namespace_8681f0e2;

// Namespace namespace_8681f0e2/mechz
// Params 0, eflags: 0x5 linked
// Checksum 0x4d9cc1a8, Offset: 0x4df0
// Size: 0x26c
function private function_3b8b6e80() {
    self disableaimassist();
    self.disableammodrop = 1;
    self.no_gib = 1;
    self.ignore_nuke = 1;
    self.ignore_enemy_count = 1;
    self.var_262a6cba = 1;
    self.zombie_move_speed = "run";
    self setblackboardattribute("_locomotion_speed", "locomotion_speed_run");
    self.var_cccb0ad2 = 1;
    self.grenadecount = 3;
    self.var_e05f2c0a = gettime();
    self.var_57fca545 = gettime();
    self.var_29386166 = 0;
    self.var_e9c62827 = 1;
    self weaponobjects::createwatcher("eq_mechz_firebomb", &function_d0651b24, 1);
    /#
        self.debug_traversal_ast = "<dev string:x42>";
    #/
    self.var_1df3d140 = spawn("trigger_box", self.origin, 0, 300, 50, 25);
    self thread deleteondeath(self.var_1df3d140);
    self.var_1df3d140 enablelinkto();
    self.var_1df3d140.origin = self gettagorigin("tag_flamethrower_fx");
    self.var_1df3d140.angles = self gettagangles("tag_flamethrower_fx");
    self.var_1df3d140 linkto(self, "tag_flamethrower_fx");
    self thread weaponobjects::watchweaponobjectspawn();
    self.pers = [];
    self.pers[#"team"] = self.team;
    self destructserverutils::togglespawngibs(self, 1);
    aiutility::addaioverridedamagecallback(self, &function_679ee5b3);
}

// Namespace namespace_8681f0e2/mechz
// Params 0, eflags: 0x1 linked
// Checksum 0x38d67150, Offset: 0x5068
// Size: 0x34
function function_5d873f78() {
    self function_7202e3df();
    namespace_81245006::initweakpoints(self);
}

// Namespace namespace_8681f0e2/mechz
// Params 1, eflags: 0x1 linked
// Checksum 0x7de2f34b, Offset: 0x50a8
// Size: 0x24
function function_d0651b24(watcher) {
    mechzfirebomb::function_5545649e(watcher);
}

// Namespace namespace_8681f0e2/mechz
// Params 1, eflags: 0x1 linked
// Checksum 0x893b89c7, Offset: 0x50d8
// Size: 0x3c
function deleteondeath(object) {
    self waittill(#"death");
    if (isdefined(object)) {
        object delete();
    }
}

// Namespace namespace_8681f0e2/mechz
// Params 0, eflags: 0x4
// Checksum 0xb54cacbf, Offset: 0x5120
// Size: 0x76
function private function_769e329() {
    self endon(#"death");
    while (true) {
        if (isdefined(self.favoriteenemy)) {
            if (self.var_1df3d140 istouching(self.favoriteenemy)) {
                /#
                    printtoprightln("<dev string:x54>");
                #/
            }
        }
        waitframe(1);
    }
}

// Namespace namespace_8681f0e2/mechz
// Params 0, eflags: 0x5 linked
// Checksum 0xc3d15526, Offset: 0x51a0
// Size: 0x42
function private function_7202e3df() {
    self.var_7c4488fd = 1;
    self.var_d03c4664 = 1;
    self.var_c646abf1 = 1;
    self.var_e5dc4e62 = 1;
    self.var_5a91b92e = 1;
}

// Namespace namespace_8681f0e2/mechz
// Params 12, eflags: 0x1 linked
// Checksum 0xc62cff18, Offset: 0x51f0
// Size: 0x770
function function_679ee5b3(inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
    if (attacker === self || !util::function_fbce7263(attacker.team, self.team)) {
        return 0;
    }
    if (isdefined(self.var_28d6380a) && !is_true(self.var_28d6380a)) {
        return 0;
    }
    if (is_true(self.stumble)) {
        if (self.var_57fca545 < gettime() && !is_true(self.berserk)) {
            self [[ level.var_df70a9a7 ]](inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex);
        }
    }
    damage = function_311ae556(damage, weapon);
    if (isdefined(level.var_bb85b5a3)) {
        damage = [[ level.var_bb85b5a3 ]](attacker, damage);
    }
    if (!isdefined(self.var_c7b2318c) || gettime() >= self.var_c7b2318c) {
        self thread function_7101cd45();
        self.var_c7b2318c = gettime() + 250 + randomint(500);
    }
    if (isdefined(self.var_50a0c385)) {
        self [[ self.var_50a0c385 ]](inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex);
    }
    /#
        if (is_true(level.var_85a39c96)) {
            return (self.health + 1);
        }
    #/
    damage_type = 1;
    weakpoint = namespace_81245006::function_3131f5dd(self, hitloc, 1);
    if (weakpoint.var_3765e777 === 1) {
        attacker show_hit_marker();
        damage = int(damage * 1);
        /#
            iprintlnbold("<dev string:x60>" + damage + "<dev string:x6e>" + self.health - damage);
        #/
        damage_type = 2;
    }
    if (hitloc !== "none") {
        /#
            iprintlnbold("<dev string:x78>" + damage + "<dev string:x6e>" + self.health - damage);
        #/
    } else if (mod == "MOD_PROJECTILE" || mod == "MOD_GRENADE") {
        damage = int(damage * 2);
        /#
            iprintlnbold("<dev string:x89>" + damage + "<dev string:x6e>" + self.health - damage);
        #/
    } else if (mod == "MOD_PROJECTILE_SPLASH" || mod == "MOD_BURNED" || mod == "MOD_GRENADE_SPLASH" || mod == "MOD_EXPLOSIVE") {
        damage = int(damage * 3);
        /#
            iprintlnbold("<dev string:x9d>" + damage + "<dev string:x6e>" + self.health - damage);
        #/
    } else if (mod == "MOD_CRUSH") {
        /#
            iprintlnbold("<dev string:xb8>" + damage + "<dev string:x6e>" + self.health - damage);
        #/
    }
    if (!isdefined(weakpoint)) {
        weakpoint = namespace_81245006::function_37e3f011(self, boneindex, 1);
    }
    if (isdefined(weakpoint)) {
        if (weakpoint.type === #"weakpoint") {
            level scoreevents::doscoreeventcallback("scoreEventZM", {#attacker:attacker, #scoreevent:"hit_weak_point_zm"});
        } else if (weakpoint.type === #"armor") {
            namespace_81245006::function_ef87b7e8(weakpoint, damage);
            if (namespace_81245006::function_f29756fe(weakpoint) === 3 && isdefined(weakpoint.var_f371ebb0)) {
                destructserverutils::function_8475c53a(self, weakpoint.var_f371ebb0);
                scoreevent = "destroyed_armor_zm";
                if (weakpoint.var_f371ebb0 == "helmet") {
                    self function_40c68562();
                }
                if (weakpoint.var_f371ebb0 == "jet_pack") {
                    self function_4c489c31();
                    scoreevent = "mechz_jetpack_destroyed_zm";
                }
                if (weakpoint.var_f371ebb0 == "power_core_cover") {
                    self function_3ebf4258();
                }
                if (weakpoint.var_f371ebb0 == "left_arm_armor") {
                    self function_39d47bef();
                }
                level scoreevents::doscoreeventcallback("scoreEventZM", {#attacker:attacker, #scoreevent:scoreevent});
            }
        }
    }
    callback::callback(#"hash_3886c79a26cace38", {#eattacker:attacker, #var_dcc8dd60:self getentitynumber(), #idamage:damage, #type:damage_type});
    return damage;
}

// Namespace namespace_8681f0e2/mechz
// Params 2, eflags: 0x5 linked
// Checksum 0xbf8a723, Offset: 0x5968
// Size: 0x70
function private function_311ae556(damage, weapon) {
    if (isdefined(weapon) && isdefined(weapon.name)) {
        if (weapon.name == #"eq_mechz_firebomb") {
            return 0;
        }
        if (weapon.name == #"molotov_fire") {
            return 0;
        }
    }
    return damage;
}

// Namespace namespace_8681f0e2/mechz
// Params 0, eflags: 0x1 linked
// Checksum 0xff55e2f1, Offset: 0x59e0
// Size: 0x24
function function_7101cd45() {
    self playsound("zmb_ai_mechz_destruction");
}

// Namespace namespace_8681f0e2/mechz
// Params 0, eflags: 0x1 linked
// Checksum 0x46c5f446, Offset: 0x5a10
// Size: 0x1c
function show_hit_marker() {
    self util::show_hit_marker();
}

// Namespace namespace_8681f0e2/mechz
// Params 1, eflags: 0x1 linked
// Checksum 0xc8d50eb4, Offset: 0x5a38
// Size: 0x3c
function hide_part(var_7527000) {
    if (self haspart(var_7527000)) {
        self hidepart(var_7527000);
    }
}

// Namespace namespace_8681f0e2/mechz
// Params 0, eflags: 0x1 linked
// Checksum 0x5c636867, Offset: 0x5a80
// Size: 0xa0
function function_40c68562() {
    self clientfield::set("mechz_faceplate_detached", 1);
    self.var_c646abf1 = 0;
    self function_ee30c07();
    self.var_bc17791c = 1;
    self setblackboardattribute("_mechz_part", "mechz_faceplate");
    self namespace_3444cb7b::function_34d763b5();
    level notify(#"mechz_faceplate_detached");
}

// Namespace namespace_8681f0e2/mechz
// Params 0, eflags: 0x1 linked
// Checksum 0x6ee1ea12, Offset: 0x5b28
// Size: 0x5c
function function_3ebf4258() {
    self clientfield::set("mechz_powercap_detached", 1);
    self.var_5a91b92e = 0;
    self.var_bc17791c = 1;
    self setblackboardattribute("_mechz_part", "mechz_powercore");
}

// Namespace namespace_8681f0e2/mechz
// Params 0, eflags: 0x1 linked
// Checksum 0xc4e5fa1b, Offset: 0x5b90
// Size: 0x80
function function_39d47bef() {
    self clientfield::set("mechz_claw_detached", 1);
    self.var_e5dc4e62 = 0;
    self.var_d03c4664 = 0;
    self.var_bc17791c = 1;
    self setblackboardattribute("_mechz_part", "mechz_gun");
    level notify(#"hash_37e527c370856cf2");
}

// Namespace namespace_8681f0e2/mechz
// Params 0, eflags: 0x1 linked
// Checksum 0xe93a85c, Offset: 0x5c18
// Size: 0xa4
function function_4c489c31() {
    self hide_part("j_jetpack");
    self clientfield::set("mechz_jetpack_explosion", 1);
    self.var_7c4488fd = 0;
    self.var_97601164 = 1;
    self.var_bc17791c = 1;
    self radiusdamage(self.origin + (0, 0, 36), 128, 150, 95, undefined, "MOD_EXPLOSIVE");
}

// Namespace namespace_8681f0e2/mechz
// Params 3, eflags: 0x1 linked
// Checksum 0x5d2f5a43, Offset: 0x5cc8
// Size: 0x20a
function function_923942a7(var_a460aef2, aim_tag, var_40f25562 = 0.5) {
    origin = self.origin;
    angles = self.angles;
    if (isdefined(aim_tag)) {
        origin = self gettagorigin(aim_tag);
        angles = self gettagangles(aim_tag);
    }
    if (isdefined(var_a460aef2)) {
        var_b7ff6051 = anglestoright(angles);
        origin += var_b7ff6051 * var_a460aef2;
    }
    if (!isdefined(self.favoriteenemy)) {
        return false;
    }
    var_3c08a493 = anglestoforward(angles);
    var_e14511cb = self.favoriteenemy.origin - origin;
    var_660d1fec = (var_e14511cb[0], var_e14511cb[1], 0);
    var_58877074 = (var_3c08a493[0], var_3c08a493[1], 0);
    var_660d1fec = vectornormalize(var_660d1fec);
    var_58877074 = vectornormalize(var_58877074);
    var_704c3d16 = vectordot(var_58877074, var_660d1fec);
    if (var_704c3d16 < var_40f25562) {
        return false;
    }
    var_529624a4 = vectortoangles(var_e14511cb);
    if (abs(angleclamp180(var_529624a4[0])) > 60) {
        return false;
    }
    return true;
}

// Namespace namespace_8681f0e2/mechz
// Params 1, eflags: 0x1 linked
// Checksum 0x21301f1f, Offset: 0x5ee0
// Size: 0x64
function function_ee30c07(var_832f96cf) {
    if (var_832f96cf !== 1) {
        self clientfield::set("mechz_headlamp_off", 1);
        return;
    }
    self clientfield::set("mechz_headlamp_off", 2);
}

