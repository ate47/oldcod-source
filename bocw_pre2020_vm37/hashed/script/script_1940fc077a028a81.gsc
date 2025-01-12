#using script_3357acf79ce92f4b;
#using script_3411bb48d41bd3b;
#using scripts\core_common\ai\systems\animation_state_machine_mocomp;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\ai\systems\behavior_state_machine;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\zombie;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\values_shared;

#namespace namespace_e292b080;

// Namespace namespace_e292b080/namespace_e292b080
// Params 0, eflags: 0x6
// Checksum 0x2eec1834, Offset: 0x318
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_1f8830cd01b39f8f", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_e292b080/namespace_e292b080
// Params 0, eflags: 0x5 linked
// Checksum 0x8ad72d02, Offset: 0x360
// Size: 0x4c
function private function_70a657d8() {
    function_7ff2a0fc();
    val::register("blockingpain", 1);
    val::default_value("blockingpain", 0);
}

// Namespace namespace_e292b080/namespace_e292b080
// Params 0, eflags: 0x5 linked
// Checksum 0xc76df93e, Offset: 0x3b8
// Size: 0x1194
function private function_7ff2a0fc() {
    assert(isscriptfunctionptr(&function_e91d8371));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"wzzombieupdatethrottle", &function_e91d8371, 2);
    assert(isscriptfunctionptr(&function_5aeeecac));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3ac312897079296a", &function_5aeeecac, 2);
    assert(isscriptfunctionptr(&function_eea7a68a));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_300dd0c6326499f2", &function_eea7a68a, 1);
    assert(isscriptfunctionptr(&function_1ca9d31b));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_35bf14858fe8b5cf", &function_1ca9d31b, 3);
    assert(isscriptfunctionptr(&zombieshouldmelee));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"wzzombieshouldmelee", &zombieshouldmelee);
    assert(isscriptfunctionptr(&function_d8b225ae));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"wzzombieshouldmeleeattackable", &function_d8b225ae);
    assert(isscriptfunctionptr(&zombieshouldmove));
    behaviorstatemachine::registerbsmscriptapiinternal(#"wzzombieshouldmove", &zombieshouldmove);
    assert(isscriptfunctionptr(&function_bfc25c77));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_502cf2e8eca970f0", &function_bfc25c77);
    assert(isscriptfunctionptr(&function_b9b03294));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_91cfd1edd5185d1", &function_b9b03294);
    assert(isscriptfunctionptr(&zombieshouldknockdown));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"wzzombieshouldknockdown", &zombieshouldknockdown);
    assert(isscriptfunctionptr(&function_2a7b4aab));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_27c0b6c5a7e05804", &function_2a7b4aab);
    assert(isscriptfunctionptr(&function_931b615f));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5ecbb3fc61f4458c", &function_931b615f);
    assert(isscriptfunctionptr(&function_e1b85c34));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_570afe82cdfa6969", &function_e1b85c34);
    assert(isscriptfunctionptr(&function_e9e6482));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7d363abffd05f58a", &function_e9e6482);
    assert(isscriptfunctionptr(&function_10b38c5a));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1d366f17af8db750", &function_10b38c5a);
    assert(isscriptfunctionptr(&function_10b38c5a));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_1d366f17af8db750", &function_10b38c5a);
    assert(isscriptfunctionptr(&function_573545a));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_35721134610efe59", &function_573545a);
    assert(isscriptfunctionptr(&function_573545a));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_35721134610efe59", &function_573545a);
    assert(isscriptfunctionptr(&zombiemoveactionstart));
    behaviorstatemachine::registerbsmscriptapiinternal(#"wzzombiemoveactionstart", &zombiemoveactionstart);
    assert(isscriptfunctionptr(&zombiemoveactionupdate));
    behaviorstatemachine::registerbsmscriptapiinternal(#"wzzombiemoveactionupdate", &zombiemoveactionupdate);
    assert(isscriptfunctionptr(&zombiemoveactionstart));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"wzzombiemoveactionstart", &zombiemoveactionstart);
    assert(isscriptfunctionptr(&zombiemoveactionupdate));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"wzzombiemoveactionupdate", &zombiemoveactionupdate);
    assert(isscriptfunctionptr(&function_7c8e35e8));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5b037e170b517862", &function_7c8e35e8);
    assert(!isdefined(&function_7c8e35e8) || isscriptfunctionptr(&function_7c8e35e8));
    assert(!isdefined(&function_fee7d867) || isscriptfunctionptr(&function_fee7d867));
    assert(!isdefined(&function_3f71b9c2) || isscriptfunctionptr(&function_3f71b9c2));
    behaviortreenetworkutility::registerbehaviortreeaction(#"hash_5bd00a38dffd47e", &function_7c8e35e8, &function_fee7d867, &function_3f71b9c2);
    assert(isscriptfunctionptr(&zombieknockdownactionstart));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"wzzombieknockdownactionstart", &zombieknockdownactionstart);
    assert(isscriptfunctionptr(&function_c8939973));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7a21325931f5ca2f", &function_c8939973);
    assert(isscriptfunctionptr(&zombiegetupactionterminate));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"wzzombiegetupactionterminate", &zombiegetupactionterminate);
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    assert(!isdefined(&function_78106a79) || isscriptfunctionptr(&function_78106a79));
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    behaviortreenetworkutility::registerbehaviortreeaction(#"hash_43da8039096f842f", undefined, &function_78106a79, undefined);
    assert(isscriptfunctionptr(&function_f8250d5e));
    behaviorstatemachine::registerbsmscriptapiinternal(#"wzzombieidleactionstart", &function_f8250d5e);
    assert(isscriptfunctionptr(&function_860d5d8));
    behaviorstatemachine::registerbsmscriptapiinternal(#"wzzombieidleactionupdate", &function_860d5d8);
    assert(isscriptfunctionptr(&function_f8250d5e));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"wzzombieidleactionstart", &function_f8250d5e);
    assert(isscriptfunctionptr(&function_860d5d8));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"wzzombieidleactionupdate", &function_860d5d8);
    assert(isscriptfunctionptr(&function_f37b0fbd));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_23cab4c0aa3e9ee0", &function_f37b0fbd);
    assert(isscriptfunctionptr(&function_da99776f));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_45589afe0073d903", &function_da99776f);
    assert(isscriptfunctionptr(&function_da99776f));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_45589afe0073d903", &function_da99776f);
    assert(isscriptfunctionptr(&function_c8caa34b));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1cb57a93258839fc", &function_c8caa34b);
    assert(isscriptfunctionptr(&function_c8caa34b));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_1cb57a93258839fc", &function_c8caa34b);
    animationstatenetwork::registernotetrackhandlerfunction("zombieRiserFx", &function_79c3a487);
    animationstatenetwork::registernotetrackhandlerfunction("showZombie", &showzombie);
    animationstatenetwork::registernotetrackhandlerfunction("damageDoor", &damagedoor);
    animationstatenetwork::registeranimationmocomp("mocomp_zombie_attack_attackable", &function_81349d20, undefined, undefined);
    animationstatenetwork::registeranimationmocomp("mocomp_attack_traversal_blocker", &function_8aa7d53, undefined, undefined);
    animationstatenetwork::registeranimationmocomp("mocomp_force_face_attackable_or_enemy", &function_933af241, undefined, undefined);
}

// Namespace namespace_e292b080/namespace_e292b080
// Params 1, eflags: 0x5 linked
// Checksum 0xb9f15b61, Offset: 0x1558
// Size: 0xe4
function private function_e91d8371(entity) {
    if (!is_true(entity.ai.var_870d0893)) {
        return;
    }
    if (!isdefined(level.var_a2fbb776)) {
        level.var_a2fbb776 = 0;
    }
    level.var_8de0b84e[level.var_a2fbb776] = entity getentitynumber();
    level.var_a2fbb776 = (level.var_a2fbb776 + 1) % 2;
    if (is_true(level.is_survival) && is_true(entity.has_awareness)) {
        function_eea7a68a(entity);
    }
}

// Namespace namespace_e292b080/namespace_e292b080
// Params 1, eflags: 0x5 linked
// Checksum 0x7e2e8816, Offset: 0x1648
// Size: 0x148
function private function_5aeeecac(entity) {
    if (is_true(entity.var_4c85ebad)) {
        return;
    }
    radiusmultiplier = entity.var_e729ffb;
    if (!isdefined(radiusmultiplier)) {
        radiusmultiplier = 3;
    }
    forwardoffset = anglestoforward(entity.angles) * entity getpathfindingradius() * radiusmultiplier;
    var_d54999e4 = namespace_85745671::ee_head(entity, 0.8, forwardoffset);
    foreach (dynent in var_d54999e4) {
        if (namespace_85745671::function_8f57dc52(dynent)) {
            entity.var_4c85ebad = 1;
            return;
        }
    }
}

// Namespace namespace_e292b080/namespace_e292b080
// Params 1, eflags: 0x1 linked
// Checksum 0x7b974a7, Offset: 0x1798
// Size: 0x4c
function function_eea7a68a(entity) {
    entity.enemy_override = namespace_85745671::function_b67c088d();
    namespace_85745671::function_744beb04(entity);
    awareness::target_update(entity);
}

// Namespace namespace_e292b080/namespace_e292b080
// Params 3, eflags: 0x1 linked
// Checksum 0xee0e1535, Offset: 0x17f0
// Size: 0x1f2
function function_7c70e7fa(entity, var_21bdf069, dynent) {
    bounds = function_c440d28e(dynent.var_15d44120);
    var_21a49757 = bounds.maxs[1] - bounds.mins[1];
    var_cc87c802 = getxmodelcenteroffset(dynent.var_15d44120);
    var_f712cb3c = anglestoright(dynent.angles);
    doorcenter = dynent.origin + var_f712cb3c * -1 * var_cc87c802[1];
    /#
        recordstar(doorcenter, (0, 1, 0), "<dev string:x38>");
    #/
    end_point = doorcenter + var_f712cb3c * var_21a49757 / 2;
    start_point = doorcenter - var_f712cb3c * var_21a49757 / 2;
    /#
        recordline(start_point, end_point, (1, 0, 0), "<dev string:x38>");
        recordcircle(entity.origin, entity getpathfindingradius(), (0, 1, 0), "<dev string:x38>");
    #/
    point = math::closest_point_on_line(entity.origin, start_point, end_point);
    if (lengthsquared(point - entity.origin) > var_21bdf069) {
        return false;
    }
    return true;
}

// Namespace namespace_e292b080/namespace_e292b080
// Params 1, eflags: 0x1 linked
// Checksum 0x35dcfd2b, Offset: 0x19f0
// Size: 0x2c8
function function_1ca9d31b(entity) {
    if (!getdvarint(#"hash_397bf855bf5ab4de", 1)) {
        return;
    }
    var_577fefe8 = entity getpathfindingradius() + 275;
    var_e86a4d9 = function_c3d68575(entity.origin, (var_577fefe8, var_577fefe8, entity function_6a9ae71()));
    height_check = max(entity function_6a9ae71(), 95);
    var_21bdf069 = function_a3f6cdac(entity getpathfindingradius());
    foreach (dynent in var_e86a4d9) {
        if (abs(dynent.origin[2] - entity.origin[2]) > height_check) {
            continue;
        }
        var_7f45fe8f = 0;
        if (dynent.script_noteworthy === #"hash_4d1fb8524fdfd254" || dynent.var_15d44120 === #"p8_fxanim_wz_rollup_door_medium_mod" || dynent.var_15d44120 === #"hash_30cb30fe79cd7bc0" || dynent.var_15d44120 === #"p8_fxanim_wz_rollup_door_small_mod" || dynent.var_15d44120 === #"p8_fxanim_wz_rollup_door_large_mod") {
            var_7f45fe8f = function_7c70e7fa(entity, var_21bdf069, dynent);
        }
        if (var_7f45fe8f && dynent.health > 0) {
            dynent dodamage(dynent.health, entity.origin, entity, entity, undefined, "MOD_MELEE");
        }
    }
}

// Namespace namespace_e292b080/namespace_e292b080
// Params 1, eflags: 0x1 linked
// Checksum 0xb806cb6a, Offset: 0x1cc0
// Size: 0x67e
function zombieshouldmelee(entity) {
    if (is_true(entity.var_8a96267d) || is_true(entity.var_8ba6ede3)) {
        return false;
    }
    if (is_true(entity.var_4c85ebad)) {
        return true;
    }
    if (function_d8b225ae(entity)) {
        return true;
    }
    if (!isdefined(entity.enemy)) {
        return false;
    }
    if (!namespace_85745671::is_player_valid(entity.enemy) && !namespace_85745671::function_1b9ed9b0(entity.enemy) && entity.team === level.zombie_team) {
        return false;
    }
    if (is_true(entity.ignoremelee)) {
        return false;
    }
    meleedistsq = zombiebehavior::function_997f1224(entity);
    enemy_vehicle = undefined;
    test_origin = entity.enemy.origin;
    if (isplayer(entity.enemy)) {
        if (namespace_85745671::function_142c3c86(entity.enemy)) {
            enemy_vehicle = entity.enemy getvehicleoccupied();
            var_81952387 = enemy_vehicle.origin;
            for (i = 0; i < 11; i++) {
                if (enemy_vehicle function_dcef0ba1(i)) {
                    var_ec950ebd = enemy_vehicle function_defc91b2(i);
                    if (isdefined(var_ec950ebd) && var_ec950ebd >= 0) {
                        seat_pos = enemy_vehicle function_5051cc0c(i);
                        if (distancesquared(entity.origin, var_81952387) > distancesquared(entity.origin, seat_pos)) {
                            var_81952387 = seat_pos;
                        }
                    }
                }
            }
            test_origin = var_81952387;
        } else if (isvehicle(entity.enemy getgroundent())) {
            enemy_vehicle = entity.enemy getgroundent();
            test_origin = isdefined(entity.enemy.last_valid_position) ? entity.enemy.last_valid_position : entity.enemy.origin;
        } else if (isvehicle(entity.enemy getmoverent())) {
            enemy_vehicle = entity.enemy getmoverent();
            test_origin = isdefined(entity.enemy.last_valid_position) ? entity.enemy.last_valid_position : entity.enemy.origin;
        }
        if (isdefined(enemy_vehicle) && isdefined(entity.var_cbc65493)) {
            meleedistsq *= entity.var_cbc65493;
        }
    }
    if (abs(entity.origin[2] - test_origin[2]) > (isdefined(entity.var_737e8510) ? entity.var_737e8510 : 64)) {
        return false;
    }
    if (distancesquared(entity.origin, test_origin) > meleedistsq) {
        return false;
    }
    yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(entity.enemy.origin - entity.origin)[1]);
    if (abs(yawtoenemy) > (isdefined(entity.var_1c0eb62a) ? entity.var_1c0eb62a : 60)) {
        return false;
    }
    if (!entity cansee(isdefined(enemy_vehicle) ? enemy_vehicle : entity.enemy)) {
        return false;
    }
    if (distancesquared(entity.origin, test_origin) < function_a3f6cdac(40)) {
        entity.idletime = gettime();
        entity.var_1b250399 = entity.origin;
        return true;
    }
    if (isdefined(enemy_vehicle)) {
        entity.idletime = gettime();
        entity.var_1b250399 = entity.origin;
        return true;
    }
    if (is_true(self.isonnavmesh) && !tracepassedonnavmesh(entity.origin, isdefined(entity.enemy.last_valid_position) ? entity.enemy.last_valid_position : entity.enemy.origin, entity.enemy getpathfindingradius())) {
        return false;
    }
    entity.idletime = gettime();
    entity.var_1b250399 = entity.origin;
    return true;
}

// Namespace namespace_e292b080/namespace_e292b080
// Params 1, eflags: 0x1 linked
// Checksum 0xdd5f7ec4, Offset: 0x2348
// Size: 0xf6
function function_d8b225ae(entity) {
    if (!isdefined(entity.attackable)) {
        return false;
    }
    radius = entity.goalradius;
    if (is_true(entity.allowoffnavmesh)) {
        radius = 16;
    }
    if (isdefined(entity.var_b238ef38) && distance2dsquared(entity.origin, entity.var_b238ef38.position) < function_a3f6cdac(radius) && abs(entity.origin[2] - entity.var_b238ef38.position[2]) < 50) {
        return true;
    }
    return false;
}

// Namespace namespace_e292b080/namespace_e292b080
// Params 1, eflags: 0x5 linked
// Checksum 0xf9a80ca3, Offset: 0x2448
// Size: 0x2c
function private zombieshouldmove(entity) {
    return entity.allowoffnavmesh || entity haspath();
}

// Namespace namespace_e292b080/namespace_e292b080
// Params 1, eflags: 0x5 linked
// Checksum 0xb4b8dd15, Offset: 0x2480
// Size: 0xde
function private function_bfc25c77(entity) {
    if (!(isdefined(getgametypesetting(#"hash_2d40f1434ed94a2b")) ? getgametypesetting(#"hash_2d40f1434ed94a2b") : 0)) {
        return false;
    }
    if (self function_3c566724()) {
        return false;
    }
    startnode = entity.traversestartnode;
    if (!isnodeenabled(startnode)) {
        return false;
    }
    if (namespace_85745671::function_f4087909(startnode.var_597f08bf)) {
        entity.var_597f08bf = startnode.var_597f08bf;
        return true;
    }
    return false;
}

// Namespace namespace_e292b080/namespace_e292b080
// Params 1, eflags: 0x5 linked
// Checksum 0xf72c3521, Offset: 0x2568
// Size: 0x72
function private function_b9b03294(entity) {
    if (self function_3c566724()) {
        return true;
    }
    startnode = entity.traversestartnode;
    if (!isdefined(startnode) || !isnodeenabled(startnode)) {
        return false;
    }
    return true;
}

// Namespace namespace_e292b080/namespace_e292b080
// Params 1, eflags: 0x5 linked
// Checksum 0x2c87cb3f, Offset: 0x25e8
// Size: 0x1c
function private zombieshouldknockdown(entity) {
    return entity.knockdown === 1;
}

// Namespace namespace_e292b080/namespace_e292b080
// Params 1, eflags: 0x5 linked
// Checksum 0x704ad5ef, Offset: 0x2610
// Size: 0x1c
function private function_2a7b4aab(entity) {
    return entity.var_85c3882d === 1;
}

// Namespace namespace_e292b080/namespace_e292b080
// Params 1, eflags: 0x5 linked
// Checksum 0x1d691ab0, Offset: 0x2638
// Size: 0x84
function private function_931b615f(entity) {
    if (entity hasvalidinterrupt("pain") || entity hasvalidinterrupt("death") || is_true(entity.knockdown)) {
        function_3f71b9c2(entity);
    }
}

// Namespace namespace_e292b080/namespace_e292b080
// Params 1, eflags: 0x5 linked
// Checksum 0xe096e63e, Offset: 0x26c8
// Size: 0x22
function private function_e1b85c34(entity) {
    return is_true(entity.var_df840b81);
}

// Namespace namespace_e292b080/namespace_e292b080
// Params 1, eflags: 0x1 linked
// Checksum 0x13c19fe1, Offset: 0x26f8
// Size: 0x2e
function function_e9e6482(entity) {
    if (!is_true(entity.var_8c4d3e5d)) {
        return false;
    }
    return true;
}

// Namespace namespace_e292b080/namespace_e292b080
// Params 1, eflags: 0x1 linked
// Checksum 0xf1a9bcfa, Offset: 0x2730
// Size: 0x50
function function_10b38c5a(entity) {
    if (is_true(entity.var_1033fa72) && is_true(entity.var_9f6112bb)) {
        return true;
    }
    return false;
}

// Namespace namespace_e292b080/namespace_e292b080
// Params 1, eflags: 0x1 linked
// Checksum 0x17890777, Offset: 0x2788
// Size: 0x26
function function_da99776f(entity) {
    entity.var_1033fa72 = undefined;
    entity.var_9f6112bb = undefined;
    return true;
}

// Namespace namespace_e292b080/namespace_e292b080
// Params 1, eflags: 0x1 linked
// Checksum 0x9ef5c4c6, Offset: 0x27b8
// Size: 0x22
function function_573545a(entity) {
    return is_true(entity.var_2772a472);
}

// Namespace namespace_e292b080/namespace_e292b080
// Params 1, eflags: 0x1 linked
// Checksum 0x3f71db36, Offset: 0x27e8
// Size: 0x1a
function function_c8caa34b(entity) {
    entity.var_2772a472 = undefined;
    return true;
}

// Namespace namespace_e292b080/namespace_e292b080
// Params 1, eflags: 0x5 linked
// Checksum 0xf2009e60, Offset: 0x2810
// Size: 0x36
function private zombiemoveactionstart(entity) {
    entity.movetime = gettime();
    entity.moveorigin = entity.origin;
    entity.var_13138acf = 0;
    return true;
}

// Namespace namespace_e292b080/namespace_e292b080
// Params 1, eflags: 0x5 linked
// Checksum 0xa1ece9ab, Offset: 0x2850
// Size: 0xba
function private zombiemoveactionupdate(entity) {
    if (!is_true(entity.missinglegs) && gettime() - entity.movetime > 1000) {
        distsq = distance2dsquared(entity.origin, entity.moveorigin);
        if (distsq < 144) {
            if (isdefined(entity.cant_move_cb)) {
                entity thread [[ entity.cant_move_cb ]]();
            }
        }
        entity.movetime = gettime();
        entity.moveorigin = entity.origin;
    }
    return true;
}

// Namespace namespace_e292b080/namespace_e292b080
// Params 2, eflags: 0x5 linked
// Checksum 0xe2f5ce36, Offset: 0x2918
// Size: 0x1c6
function private function_7c8e35e8(entity, asmstate) {
    if (isdefined(self.traversestartnode)) {
        node = entity.traversestartnode;
        if (entity.traversestartnode.type !== #"begin" && entity.traversestartnode.type !== "Volume") {
            node = getothernodeinnegotiationpair(node);
        }
        unlinktraversal(node);
        entity.var_834b0770 = node;
        node.owner = entity;
        if (entity.archetype !== #"zombie" && !isentity(entity.var_597f08bf)) {
            entity callback::function_d8abfc3d(#"on_ai_melee", &damagedoor);
        }
        if (isdefined(asmstate)) {
            animationstatenetworkutility::requeststate(entity, asmstate);
        }
        entity pathmode("dont move");
    }
    if (isdefined(entity.var_597f08bf)) {
        entity.var_a476b329 = entity.var_597f08bf.angles;
    }
    if (!isdefined(self.traversemantlenode)) {
        entity.var_df840b81 = 1;
    } else {
        entity.var_df840b81 = undefined;
    }
    return 5;
}

// Namespace namespace_e292b080/namespace_e292b080
// Params 2, eflags: 0x5 linked
// Checksum 0xb54fa8d4, Offset: 0x2ae8
// Size: 0x220
function private function_fee7d867(entity, asmstate) {
    if (entity asmgetstatus() == "asm_status_complete" && isdefined(asmstate)) {
        animationstatenetworkutility::requeststate(entity, asmstate);
    }
    if (isdefined(entity.var_597f08bf) && isdefined(entity.var_a476b329) && abs(vectordot(anglestoforward(entity.var_a476b329), anglestoforward(entity.var_597f08bf.angles)) < 0.5)) {
        return 4;
    }
    if (!namespace_85745671::function_f4087909(entity.var_597f08bf)) {
        return 4;
    }
    goalinfo = entity function_4794d6a3();
    if (isdefined(goalinfo) && isdefined(goalinfo.goalpos)) {
        var_f940b57b = goalinfo.goalpos;
    }
    if (!isdefined(var_f940b57b) && isdefined(entity.favoriteenemy)) {
        var_f940b57b = entity.favoriteenemy.last_valid_position;
    }
    if (isdefined(var_f940b57b) && abs(var_f940b57b[2] - entity.origin[2]) < 100 && vectordot(anglestoforward(entity.angles), var_f940b57b - entity.origin) < 0) {
        entity.var_df840b81 = undefined;
        return 4;
    }
    return 5;
}

// Namespace namespace_e292b080/namespace_e292b080
// Params 2, eflags: 0x5 linked
// Checksum 0xbe2d98c5, Offset: 0x2d10
// Size: 0x112
function private function_3f71b9c2(entity, *asmstate) {
    asmstate finishtraversal();
    asmstate pathmode("move allowed", 1);
    if (isdefined(asmstate.var_834b0770)) {
        linktraversal(asmstate.var_834b0770);
        asmstate.var_834b0770.owner = undefined;
        asmstate.var_834b0770 = undefined;
    }
    asmstate.var_597f08bf = undefined;
    asmstate.var_a476b329 = undefined;
    asmstate callback::function_52ac9652(#"on_ai_melee", &damagedoor);
    if (asmstate asmgetstatus() == "asm_status_running") {
        asmstate.var_fc781a6f = 1;
    }
    return 4;
}

// Namespace namespace_e292b080/namespace_e292b080
// Params 1, eflags: 0x1 linked
// Checksum 0x58c25102, Offset: 0x2e30
// Size: 0xcc
function zombieknockdownactionstart(behaviortreeentity) {
    behaviortreeentity setblackboardattribute("_knockdown_type", behaviortreeentity.knockdown_type);
    behaviortreeentity setblackboardattribute("_knockdown_direction", behaviortreeentity.knockdown_direction);
    behaviortreeentity setblackboardattribute("_getup_direction", behaviortreeentity.getup_direction);
    behaviortreeentity collidewithactors(0);
    behaviortreeentity val::set(#"zombie_knockdown", "blockingpain", 1);
}

// Namespace namespace_e292b080/namespace_e292b080
// Params 1, eflags: 0x5 linked
// Checksum 0x1e051286, Offset: 0x2f08
// Size: 0x4c
function private function_c8939973(behaviortreeentity) {
    if (is_true(behaviortreeentity.missinglegs)) {
        behaviortreeentity.knockdown = 0;
        behaviortreeentity collidewithactors(1);
    }
}

// Namespace namespace_e292b080/namespace_e292b080
// Params 1, eflags: 0x5 linked
// Checksum 0x34e8aaa1, Offset: 0x2f60
// Size: 0x74
function private zombiegetupactionterminate(behaviortreeentity) {
    behaviortreeentity.knockdown = 0;
    behaviortreeentity collidewithactors(1);
    behaviortreeentity clearpath();
    behaviortreeentity val::reset(#"zombie_knockdown", "blockingpain");
}

// Namespace namespace_e292b080/namespace_e292b080
// Params 2, eflags: 0x5 linked
// Checksum 0x8d68caa, Offset: 0x2fe0
// Size: 0x5a
function private function_78106a79(entity, *asmstatename) {
    if (asmstatename ai::is_stunned() || is_true(asmstatename.var_85c3882d)) {
        return 5;
    }
    return 4;
}

// Namespace namespace_e292b080/namespace_e292b080
// Params 1, eflags: 0x5 linked
// Checksum 0x8b2add81, Offset: 0x3048
// Size: 0x2a
function private function_f8250d5e(entity) {
    entity.idletime = gettime();
    entity.var_1b250399 = entity.origin;
    return true;
}

// Namespace namespace_e292b080/namespace_e292b080
// Params 1, eflags: 0x5 linked
// Checksum 0xd2196e01, Offset: 0x3080
// Size: 0x102
function private function_860d5d8(entity) {
    if (!is_true(entity.missinglegs) && gettime() - entity.idletime > 1000) {
        if (is_true(level.is_survival) == 1 && gettime() - entity.idletime < 1700) {
            return;
        }
        distsq = distance2dsquared(entity.origin, entity.var_1b250399);
        if (distsq < 144) {
            if (isdefined(entity.cant_move_cb)) {
                entity thread [[ entity.cant_move_cb ]]();
            }
        }
        entity.idletime = gettime();
        entity.var_1b250399 = entity.origin;
    }
    return 1;
}

// Namespace namespace_e292b080/namespace_e292b080
// Params 1, eflags: 0x5 linked
// Checksum 0xc6eda449, Offset: 0x3190
// Size: 0x24
function private function_f37b0fbd(entity) {
    entity clearpath();
}

// Namespace namespace_e292b080/namespace_e292b080
// Params 1, eflags: 0x5 linked
// Checksum 0x1ce583af, Offset: 0x31c0
// Size: 0x2c
function private function_79c3a487(entity) {
    entity clientfield::set("zombie_riser_fx", 1);
}

// Namespace namespace_e292b080/namespace_e292b080
// Params 1, eflags: 0x5 linked
// Checksum 0x139f5231, Offset: 0x31f8
// Size: 0x24
function private showzombie(entity) {
    entity show();
}

// Namespace namespace_e292b080/namespace_e292b080
// Params 1, eflags: 0x5 linked
// Checksum 0xdcbf4aba, Offset: 0x3228
// Size: 0x114
function private damagedoor(*entity) {
    if (isdefined(self.var_597f08bf)) {
        if (self.var_597f08bf.targetname !== "barricade_window") {
            damage = isdefined(self.var_1a6dcdff) ? self.var_1a6dcdff : 30;
            if (is_true(self.var_12ec333b)) {
                damage = self.var_597f08bf.health;
            }
            self.var_597f08bf dodamage(damage, self.origin, self, self, "none", "MOD_EXPLOSIVE");
            if (!isdefined(self.var_597f08bf) || self.var_597f08bf.health <= 0) {
                self.var_597f08bf = undefined;
            }
            return;
        }
        self.var_597f08bf notify(#"hash_5cfbbb6ee8378665");
    }
}

// Namespace namespace_e292b080/namespace_e292b080
// Params 5, eflags: 0x5 linked
// Checksum 0x3a7b1845, Offset: 0x3348
// Size: 0xa4
function private function_81349d20(*entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    if (isdefined(self.attackable)) {
        self orientmode("face point", self.attackable.origin);
    } else {
        self orientmode("face current");
    }
    self animmode("angle deltas");
}

// Namespace namespace_e292b080/namespace_e292b080
// Params 5, eflags: 0x1 linked
// Checksum 0x711d46a3, Offset: 0x33f8
// Size: 0x1ec
function function_8aa7d53(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    forward = mocompduration.traversalendpos - mocompduration.traversalstartpos;
    forward = (forward[0], forward[1], 0);
    if (!isdefined(mocompduration.traversemantlenode)) {
        mocompduration forceteleport(mocompduration.origin, mocompduration.angles, 0);
        mocompduration animmode("noclip", 0);
        mocompduration orientmode("face angle", vectortoangles(forward)[1]);
        return;
    }
    var_ce870aa5 = 13 + mocompduration getpathfindingradius();
    mocompduration.var_910c3b2c = mocompduration.traversemantlenode.origin - vectornormalize(forward) * var_ce870aa5;
    mocompduration.var_910c3b2c = (mocompduration.var_910c3b2c[0], mocompduration.var_910c3b2c[1], mocompduration.traversalstartpos[2]);
    mocompduration animmode("angle deltas noclip", 0);
    mocompduration orientmode("face angle", vectortoangles(forward)[1]);
    mocompduration forceteleport(mocompduration.var_910c3b2c, mocompduration.angles, 0);
}

// Namespace namespace_e292b080/namespace_e292b080
// Params 5, eflags: 0x1 linked
// Checksum 0x2b18f4fb, Offset: 0x35f0
// Size: 0x8c
function function_933af241(entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration) {
    if (isdefined(mocompduration.attackable)) {
        self orientmode("face point", self.attackable.origin);
        return;
    }
    self orientmode("face enemy");
}

// Namespace namespace_e292b080/namespace_e292b080
// Params 1, eflags: 0x1 linked
// Checksum 0xb9913451, Offset: 0x3688
// Size: 0x9f4
function zombieupdategoal(goalpos) {
    aiprofile_beginentry("zombieUpdateGoal");
    shouldrepath = 0;
    zigzag_activation_distance = level.zigzag_activation_distance;
    if (isdefined(self.zigzag_activation_distance)) {
        zigzag_activation_distance = self.zigzag_activation_distance;
    }
    pathgoalpos = self.pathgoalpos;
    if (!isdefined(self.nextgoalupdate) || self.nextgoalupdate <= gettime()) {
        shouldrepath = 1;
    } else if (distancesquared(self.origin, goalpos) <= function_a3f6cdac(zigzag_activation_distance)) {
        shouldrepath = 1;
    } else if (isdefined(pathgoalpos)) {
        distancetogoalsqr = distancesquared(self.origin, pathgoalpos);
        shouldrepath = distancetogoalsqr < function_a3f6cdac(72);
    }
    if (is_true(level.validate_on_navmesh)) {
        if (!ispointonnavmesh(self.origin, self)) {
            shouldrepath = 0;
        }
    }
    if (is_true(self.keep_moving)) {
        if (gettime() > self.keep_moving_time) {
            self.keep_moving = 0;
        }
    }
    if (self function_dd070839() || self isplayinganimscripted()) {
        shouldrepath = 0;
    }
    if (isactor(self) && self asmistransitionrunning() || self asmistransdecrunning()) {
        shouldrepath = 0;
    }
    if (shouldrepath) {
        self setgoal(goalpos);
        should_zigzag = 1;
        if (isdefined(level.should_zigzag)) {
            should_zigzag = self [[ level.should_zigzag ]]();
        } else if (isdefined(self.should_zigzag)) {
            should_zigzag = self.should_zigzag;
        }
        if (isdefined(self.var_592a8227)) {
            should_zigzag = should_zigzag && self.var_592a8227;
        }
        var_eb1c6f1c = 0;
        if (is_true(level.do_randomized_zigzag_path) && should_zigzag) {
            if (distancesquared(self.origin, goalpos) > function_a3f6cdac(zigzag_activation_distance)) {
                self.keep_moving = 1;
                self.keep_moving_time = gettime() + 700;
                path = undefined;
                if (is_true(self.var_ceed8829)) {
                    pathdata = generatenavmeshpath(self.origin, goalpos, self);
                    if (isdefined(pathdata) && pathdata.status === "succeeded" && isdefined(pathdata.pathpoints)) {
                        path = pathdata.pathpoints;
                    }
                } else {
                    path = self calcapproximatepathtoposition(goalpos, 0);
                }
                if (isdefined(path)) {
                    /#
                        if (getdvarint(#"ai_debugzigzag", 0)) {
                            for (index = 1; index < path.size; index++) {
                                recordline(path[index - 1], path[index], (1, 0.5, 0), "<dev string:x42>", self);
                                record3dtext(abs(path[index - 1][2] - path[index][2]), path[index - 1], (1, 0, 0));
                            }
                        }
                    #/
                    deviationdistance = randomintrange(level.zigzag_distance_min, level.zigzag_distance_max);
                    if (isdefined(self.zigzag_distance_min) && isdefined(self.zigzag_distance_max)) {
                        deviationdistance = randomintrange(self.zigzag_distance_min, self.zigzag_distance_max);
                    }
                    segmentlength = 0;
                    for (index = 1; index < path.size; index++) {
                        if (isdefined(level.var_562c8f67) && abs(path[index - 1][2] - path[index][2]) > level.var_562c8f67) {
                            break;
                        }
                        currentseglength = distance(path[index - 1], path[index]);
                        var_570a7c72 = segmentlength + currentseglength > deviationdistance;
                        if (index == path.size - 1 && !var_570a7c72) {
                            deviationdistance = segmentlength + currentseglength - 1;
                            var_eb1c6f1c = 1;
                        }
                        if (var_570a7c72 || var_eb1c6f1c) {
                            remaininglength = deviationdistance - segmentlength;
                            dir = vectornormalize(path[index] - path[index - 1]);
                            seedposition = path[index - 1] + dir * remaininglength;
                            /#
                                recordcircle(seedposition, 2, (1, 0.5, 0), "<dev string:x42>", self);
                            #/
                            innerzigzagradius = level.inner_zigzag_radius;
                            if (var_eb1c6f1c) {
                                innerzigzagradius = 0;
                            } else if (isdefined(self.inner_zigzag_radius)) {
                                innerzigzagradius = self.inner_zigzag_radius;
                            }
                            outerzigzagradius = level.outer_zigzag_radius;
                            if (var_eb1c6f1c) {
                                outerzigzagradius = 48;
                            } else if (isdefined(self.outer_zigzag_radius)) {
                                outerzigzagradius = self.outer_zigzag_radius;
                            }
                            if (getdvarint(#"hash_32b7866126eb3f6", 1)) {
                                queryresult = positionquery_source_navigation(seedposition, innerzigzagradius, outerzigzagradius, 36, 16, self, 16);
                            } else {
                                queryresult = {#data:function_bc777234(seedposition, dir, 4, max(innerzigzagradius, outerzigzagradius / 2), outerzigzagradius, 36, self getpathfindingradius())};
                            }
                            positionquery_filter_inclaimedlocation(queryresult, self);
                            queryresult.data = function_7b8e26b3(queryresult.data, 0, "inClaimedLocation");
                            if (queryresult.data.size > 0) {
                                a_data = array::randomize(queryresult.data);
                                for (i = 0; i < a_data.size; i++) {
                                    point = a_data[i];
                                    n_z_diff = seedposition[2] - point.origin[2];
                                    if (abs(n_z_diff) < 32) {
                                        /#
                                            if (getdvarint(#"ai_debugzigzag", 0)) {
                                                recordstar(point.origin, (1, 0.5, 0), "<dev string:x42>");
                                            }
                                        #/
                                        self setgoal(point.origin);
                                        break;
                                    }
                                }
                            }
                            break;
                        }
                        segmentlength += currentseglength;
                    }
                }
            }
        }
        self.nextgoalupdate = gettime() + randomintrange(500, 1000);
    }
    aiprofile_endentry();
}

// Namespace namespace_e292b080/namespace_e292b080
// Params 7, eflags: 0x1 linked
// Checksum 0x5a38ef15, Offset: 0x4088
// Size: 0x1c4
function function_bc777234(position, forward, max_points, inner_radius, outer_radius, max_height, var_5e95f317) {
    points = [];
    var_467c5362 = getclosestpointonnavmesh(position, 256);
    var_8bd451f5 = function_a3f6cdac(inner_radius);
    angles = vectortoangles(forward);
    z_axis = (0, 0, 1);
    if (isdefined(var_467c5362)) {
        for (i = 0; i < max_points; i++) {
            var_436b8c8c = namespace_85745671::function_4ed3741d(var_467c5362, angles, 0, outer_radius, inner_radius, 45, 135);
            traceresult = checknavmeshdirection(var_467c5362, var_436b8c8c, randomfloatrange(inner_radius, outer_radius), var_5e95f317);
            if (abs(traceresult[2] - var_467c5362[2]) <= max_height && distancesquared(traceresult, var_467c5362) < var_8bd451f5) {
                points[points.size] = {#origin:traceresult};
            }
        }
    }
    return points;
}

