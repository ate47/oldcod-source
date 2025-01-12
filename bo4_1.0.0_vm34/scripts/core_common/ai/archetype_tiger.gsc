#using scripts\core_common\ai\archetype_tiger_interface;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\animation_state_machine_mocomp;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\ai\systems\behavior_state_machine;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_utility;

#namespace tigerbehavior;

// Namespace tigerbehavior
// Method(s) 2 Total 2
class class_8d5ffc42 {

    var adjustmentstarted;
    var var_98b8af1;

    // Namespace class_8d5ffc42/archetype_tiger
    // Params 0, eflags: 0x8
    // Checksum 0xdc00f88f, Offset: 0x2918
    // Size: 0x1a
    constructor() {
        adjustmentstarted = 0;
        var_98b8af1 = 1;
    }

}

// Namespace tigerbehavior/archetype_tiger
// Params 0, eflags: 0x2
// Checksum 0x861303f, Offset: 0x328
// Size: 0x954
function autoexec registerbehaviorscriptfunctions() {
    spawner::add_archetype_spawn_function("tiger", &function_a60cd232);
    assert(isscriptfunctionptr(&tigertargetservice));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"tigertargetservice", &tigertargetservice);
    assert(isscriptfunctionptr(&tigershouldmelee));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"tigershouldmelee", &tigershouldmelee);
    assert(isscriptfunctionptr(&tigershouldmelee));
    behaviorstatemachine::registerbsmscriptapiinternal(#"tigershouldmelee", &tigershouldmelee);
    assert(isscriptfunctionptr(&function_4114a5a2));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_761781d8d1315760", &function_4114a5a2);
    assert(isscriptfunctionptr(&function_4114a5a2));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_761781d8d1315760", &function_4114a5a2);
    assert(isscriptfunctionptr(&function_595f1621));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_121b237a33ad1e99", &function_595f1621);
    assert(isscriptfunctionptr(&function_595f1621));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_121b237a33ad1e99", &function_595f1621);
    assert(isscriptfunctionptr(&function_cb05b5a0));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6263cd4f7b34692e", &function_cb05b5a0);
    assert(isscriptfunctionptr(&function_cb05b5a0));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_6263cd4f7b34692e", &function_cb05b5a0);
    assert(isscriptfunctionptr(&function_4731982a));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4068cafe20c75854", &function_4731982a);
    assert(isscriptfunctionptr(&function_4731982a));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_4068cafe20c75854", &function_4731982a);
    assert(!isdefined(&function_831e0564) || isscriptfunctionptr(&function_831e0564));
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    assert(!isdefined(&function_827c9499) || isscriptfunctionptr(&function_827c9499));
    behaviortreenetworkutility::registerbehaviortreeaction(#"hash_374d5c1343974286", &function_831e0564, undefined, &function_827c9499);
    assert(!isdefined(&function_cd0fa9d2) || isscriptfunctionptr(&function_cd0fa9d2));
    assert(!isdefined(&function_422ca15d) || isscriptfunctionptr(&function_422ca15d));
    assert(!isdefined(&function_cd6346e3) || isscriptfunctionptr(&function_cd6346e3));
    behaviortreenetworkutility::registerbehaviortreeaction(#"hash_167c243dad6945a8", &function_cd0fa9d2, &function_422ca15d, &function_cd6346e3);
    assert(isscriptfunctionptr(&function_3452b278));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6d3bf729ded27272", &function_3452b278);
    assert(isscriptfunctionptr(&function_35d9ce1b));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_595b57a789c88ad7", &function_35d9ce1b);
    animationstatenetwork::registeranimationmocomp("mocomp_tiger_pounce", &function_5307b3c5, &function_8d25f64, &function_2227cf06);
    animationstatenetwork::registeranimationmocomp("mocomp_tiger_melee", &function_3655a7a1, &function_7b3b58e8, &function_7882cb9a);
    animationstatenetwork::registeranimationmocomp("mocomp_tiger_run_melee", &function_a54306c0, &function_d212c017, undefined);
    animationstatenetwork::registernotetrackhandlerfunction("tiger_melee_left", &function_8cf8a7e);
    animationstatenetwork::registernotetrackhandlerfunction("tiger_melee_right", &function_d3387c3b);
    animationstatenetwork::registernotetrackhandlerfunction("tiger_pounce", &function_d5709a03);
    tigerinterface::registertigerinterfaceattributes();
    /#
        if (isarchetypeloaded("<dev string:x30>")) {
            level thread function_16678bdf();
        }
    #/
}

// Namespace tigerbehavior/archetype_tiger
// Params 0, eflags: 0x0
// Checksum 0xb1056236, Offset: 0xc88
// Size: 0xc4
function function_a60cd232() {
    blackboard::createblackboardforentity(self);
    ai::createinterfaceforentity(self);
    self.___archetypeonanimscriptedcallback = &function_ae69eae4;
    blackboard::registerblackboardattribute(self, "_should_run", "walk", &bb_getshouldrunstatus);
    blackboard::registerblackboardattribute(self, "_should_howl", "dont_howl", &bb_getshouldhowlstatus);
    self function_643dbbb0();
}

// Namespace tigerbehavior/archetype_tiger
// Params 0, eflags: 0x0
// Checksum 0x48c55012, Offset: 0xd58
// Size: 0x16
function function_643dbbb0() {
    self.var_ff860bd8 = gettime() + 15000;
}

// Namespace tigerbehavior/archetype_tiger
// Params 1, eflags: 0x4
// Checksum 0xdaad90d4, Offset: 0xd78
// Size: 0x2c
function private function_ae69eae4(entity) {
    entity.__blackboard = undefined;
    entity function_a60cd232();
}

// Namespace tigerbehavior/archetype_tiger
// Params 0, eflags: 0x0
// Checksum 0x1f7ebfe0, Offset: 0xdb0
// Size: 0x92
function bb_getshouldrunstatus() {
    /#
        if (isdefined(self.ispuppet) && self.ispuppet) {
            return "<dev string:x36>";
        }
    #/
    if (isdefined(self.hasseenfavoriteenemy) && self.hasseenfavoriteenemy || ai::hasaiattribute(self, "sprint") && ai::getaiattribute(self, "sprint")) {
        return "run";
    }
    return "walk";
}

// Namespace tigerbehavior/archetype_tiger
// Params 0, eflags: 0x0
// Checksum 0x5c54a4a0, Offset: 0xe50
// Size: 0xc2
function bb_getshouldhowlstatus() {
    if (self ai::has_behavior_attribute("howl_chance") && isdefined(self.hasseenfavoriteenemy) && self.hasseenfavoriteenemy) {
        if (!isdefined(self.shouldhowl)) {
            chance = self ai::get_behavior_attribute("howl_chance");
            self.shouldhowl = randomfloat(1) <= chance;
        }
        if (self.shouldhowl) {
            return "howl";
        } else {
            return "dont_howl";
        }
    }
    return "dont_howl";
}

// Namespace tigerbehavior/archetype_tiger
// Params 1, eflags: 0x0
// Checksum 0x7af16538, Offset: 0xf20
// Size: 0x40
function getyaw(org) {
    angles = vectortoangles(org - self.origin);
    return angles[1];
}

// Namespace tigerbehavior/archetype_tiger
// Params 0, eflags: 0x0
// Checksum 0xb3fc5065, Offset: 0xf68
// Size: 0x92
function absyawtoenemy() {
    assert(isdefined(self.enemy));
    yaw = self.angles[1] - getyaw(self.enemy.origin);
    yaw = angleclamp180(yaw);
    if (yaw < 0) {
        yaw = -1 * yaw;
    }
    return yaw;
}

// Namespace tigerbehavior/archetype_tiger
// Params 0, eflags: 0x0
// Checksum 0x79f05dc1, Offset: 0x1008
// Size: 0x212
function need_to_run() {
    run_dist_squared = self ai::get_behavior_attribute("min_run_dist") * self ai::get_behavior_attribute("min_run_dist");
    run_yaw = 20;
    run_pitch = 30;
    run_height = 64;
    if (self.health < self.maxhealth) {
        return true;
    }
    if (!isdefined(self.enemy) || !isalive(self.enemy)) {
        return false;
    }
    if (!self cansee(self.enemy)) {
        return false;
    }
    dist = distancesquared(self.origin, self.enemy.origin);
    if (dist > run_dist_squared) {
        return false;
    }
    height = self.origin[2] - self.enemy.origin[2];
    if (abs(height) > run_height) {
        return false;
    }
    yaw = self absyawtoenemy();
    if (yaw > run_yaw) {
        return false;
    }
    pitch = angleclamp180(vectortoangles(self.origin - self.enemy.origin)[0]);
    if (abs(pitch) > run_pitch) {
        return false;
    }
    return true;
}

// Namespace tigerbehavior/archetype_tiger
// Params 2, eflags: 0x4
// Checksum 0x90ce2c20, Offset: 0x1228
// Size: 0x1e4
function private is_target_valid(tiger, target) {
    if (!isdefined(target)) {
        return 0;
    }
    if (!isalive(target)) {
        return 0;
    }
    if (!(tiger.team == #"allies")) {
        if (!isplayer(target) && sessionmodeiszombiesgame()) {
            return 0;
        }
        if (isdefined(target.is_zombie) && target.is_zombie == 1) {
            return 0;
        }
    }
    if (isplayer(target) && target.sessionstate == "spectator") {
        return 0;
    }
    if (isplayer(target) && target.sessionstate == "intermission") {
        return 0;
    }
    if (isdefined(self.intermission) && self.intermission) {
        return 0;
    }
    if (isdefined(target.ignoreme) && target.ignoreme) {
        return 0;
    }
    if (target isnotarget()) {
        return 0;
    }
    if (tiger.team === target.team) {
        return 0;
    }
    if (isplayer(target) && isdefined(level.is_player_valid_override)) {
        return [[ level.is_player_valid_override ]](target);
    }
    return 1;
}

// Namespace tigerbehavior/archetype_tiger
// Params 1, eflags: 0x4
// Checksum 0xd392019b, Offset: 0x1418
// Size: 0x258
function private get_favorite_enemy(tiger) {
    var_a817ff2d = [];
    if (sessionmodeiszombiesgame()) {
        if (self.team == #"allies") {
            var_a817ff2d = getaiteamarray(level.zombie_team);
        } else {
            var_a817ff2d = getplayers();
        }
    } else {
        var_a817ff2d = arraycombine(getplayers(), getaiarray(), 0, 0);
    }
    least_hunted = var_a817ff2d[0];
    closest_target_dist_squared = undefined;
    for (i = 0; i < var_a817ff2d.size; i++) {
        if (!isdefined(var_a817ff2d[i].hunted_by)) {
            var_a817ff2d[i].hunted_by = 0;
        }
        if (!is_target_valid(tiger, var_a817ff2d[i])) {
            continue;
        }
        if (!is_target_valid(tiger, least_hunted)) {
            least_hunted = var_a817ff2d[i];
        }
        dist_squared = distancesquared(tiger.origin, var_a817ff2d[i].origin);
        if (var_a817ff2d[i].hunted_by <= least_hunted.hunted_by && (!isdefined(closest_target_dist_squared) || dist_squared < closest_target_dist_squared)) {
            least_hunted = var_a817ff2d[i];
            closest_target_dist_squared = dist_squared;
        }
    }
    if (!is_target_valid(tiger, least_hunted)) {
        return undefined;
    }
    least_hunted.hunted_by += 1;
    return least_hunted;
}

// Namespace tigerbehavior/archetype_tiger
// Params 0, eflags: 0x0
// Checksum 0xb684178, Offset: 0x1678
// Size: 0x2e
function get_last_valid_position() {
    if (isplayer(self)) {
        return self.last_valid_position;
    }
    return self.origin;
}

// Namespace tigerbehavior/archetype_tiger
// Params 1, eflags: 0x0
// Checksum 0x929fa4a3, Offset: 0x16b0
// Size: 0x23a
function get_locomotion_target(behaviortreeentity) {
    last_valid_position = behaviortreeentity.favoriteenemy get_last_valid_position();
    if (!isdefined(last_valid_position)) {
        return undefined;
    }
    locomotion_target = last_valid_position;
    if (ai::has_behavior_attribute("spacing_value")) {
        spacing_near_dist = ai::get_behavior_attribute("spacing_near_dist");
        spacing_far_dist = ai::get_behavior_attribute("spacing_far_dist");
        spacing_horz_dist = ai::get_behavior_attribute("spacing_horz_dist");
        spacing_value = ai::get_behavior_attribute("spacing_value");
        to_enemy = behaviortreeentity.favoriteenemy.origin - behaviortreeentity.origin;
        perp = vectornormalize((to_enemy[1] * -1, to_enemy[0], 0));
        offset = perp * spacing_horz_dist * spacing_value;
        spacing_dist = math::clamp(length(to_enemy), spacing_near_dist, spacing_far_dist);
        lerp_amount = math::clamp((spacing_dist - spacing_near_dist) / (spacing_far_dist - spacing_near_dist), 0, 1);
        desired_point = last_valid_position + offset * lerp_amount;
        desired_point = getclosestpointonnavmesh(desired_point, spacing_horz_dist * 1.2, 16);
        if (isdefined(desired_point)) {
            locomotion_target = desired_point;
        }
    }
    return locomotion_target;
}

// Namespace tigerbehavior/archetype_tiger
// Params 1, eflags: 0x0
// Checksum 0xf146ef02, Offset: 0x18f8
// Size: 0x3ea
function tigertargetservice(behaviortreeentity) {
    if (isdefined(level.intermission) && level.intermission) {
        behaviortreeentity clearpath();
        return;
    }
    /#
        if (isdefined(behaviortreeentity.ispuppet) && behaviortreeentity.ispuppet) {
            return;
        }
    #/
    if (behaviortreeentity.ignoreall || behaviortreeentity.pacifist || isdefined(behaviortreeentity.favoriteenemy) && !is_target_valid(behaviortreeentity, behaviortreeentity.favoriteenemy)) {
        if (isdefined(behaviortreeentity.favoriteenemy) && isdefined(behaviortreeentity.favoriteenemy.hunted_by) && behaviortreeentity.favoriteenemy.hunted_by > 0) {
            behaviortreeentity.favoriteenemy.hunted_by--;
        }
        behaviortreeentity.favoriteenemy = undefined;
        behaviortreeentity.hasseenfavoriteenemy = 0;
        behaviortreeentity setblackboardattribute("_seen_enemy", "hasnt_seen");
        if (!behaviortreeentity.ignoreall) {
            behaviortreeentity setgoal(behaviortreeentity.origin);
        }
        return;
    }
    if ((!sessionmodeiszombiesgame() || behaviortreeentity.team == #"allies") && !is_target_valid(behaviortreeentity, behaviortreeentity.favoriteenemy)) {
        behaviortreeentity.favoriteenemy = get_favorite_enemy(behaviortreeentity);
    }
    if (!(isdefined(behaviortreeentity.hasseenfavoriteenemy) && behaviortreeentity.hasseenfavoriteenemy)) {
        if (isdefined(behaviortreeentity.favoriteenemy) && behaviortreeentity need_to_run()) {
            behaviortreeentity.hasseenfavoriteenemy = 1;
            behaviortreeentity setblackboardattribute("_seen_enemy", "has_seen");
        }
    }
    if (isdefined(behaviortreeentity.favoriteenemy)) {
        if (isdefined(level.enemy_location_override_func)) {
            goalpos = [[ level.enemy_location_override_func ]](behaviortreeentity, behaviortreeentity.favoriteenemy);
            if (isdefined(goalpos)) {
                behaviortreeentity setgoal(goalpos);
                return;
            }
        }
        locomotion_target = get_locomotion_target(behaviortreeentity);
        if (isdefined(locomotion_target)) {
            repathdist = 16;
            if (!isdefined(behaviortreeentity.lasttargetposition) || distancesquared(behaviortreeentity.lasttargetposition, locomotion_target) > repathdist * repathdist || !behaviortreeentity haspath()) {
                navmesh_point = getclosestpointonnavmesh(locomotion_target, 128, 54);
                if (isdefined(navmesh_point)) {
                    behaviortreeentity function_3c8dce03(navmesh_point);
                    behaviortreeentity.lasttargetposition = locomotion_target;
                }
            }
        }
    }
}

// Namespace tigerbehavior/archetype_tiger
// Params 1, eflags: 0x0
// Checksum 0xb7940714, Offset: 0x1cf0
// Size: 0x10a
function tigershouldmelee(behaviortreeentity) {
    if (behaviortreeentity.ignoreall || !is_target_valid(behaviortreeentity, behaviortreeentity.favoriteenemy)) {
        return false;
    }
    if (distancesquared(behaviortreeentity.origin, behaviortreeentity.favoriteenemy.origin) > 102 * 102) {
        return false;
    }
    yawtoenemy = angleclamp180(behaviortreeentity.angles[1] - vectortoangles(behaviortreeentity.favoriteenemy.origin - behaviortreeentity.origin)[1]);
    if (abs(yawtoenemy) > 60) {
        return false;
    }
    return true;
}

// Namespace tigerbehavior/archetype_tiger
// Params 1, eflags: 0x0
// Checksum 0xcd549b12, Offset: 0x1e08
// Size: 0x10a
function function_4114a5a2(behaviortreeentity) {
    if (behaviortreeentity.ignoreall || !is_target_valid(behaviortreeentity, behaviortreeentity.favoriteenemy)) {
        return false;
    }
    if (distancesquared(behaviortreeentity.origin, behaviortreeentity.favoriteenemy.origin) > 180 * 180) {
        return false;
    }
    yawtoenemy = angleclamp180(behaviortreeentity.angles[1] - vectortoangles(behaviortreeentity.favoriteenemy.origin - behaviortreeentity.origin)[1]);
    if (abs(yawtoenemy) > 60) {
        return false;
    }
    return true;
}

// Namespace tigerbehavior/archetype_tiger
// Params 1, eflags: 0x0
// Checksum 0x4c30f3d4, Offset: 0x1f20
// Size: 0x1bc
function function_595f1621(behaviortreeentity) {
    if (behaviortreeentity.ignoreall || !is_target_valid(behaviortreeentity, behaviortreeentity.favoriteenemy)) {
        return false;
    }
    if (gettime() <= self.var_ff860bd8) {
        return false;
    }
    enemydistsq = distancesquared(behaviortreeentity.origin, behaviortreeentity.favoriteenemy.origin);
    if (enemydistsq < 128 * 128) {
        return false;
    }
    offset = behaviortreeentity.favoriteenemy.origin - vectornormalize(behaviortreeentity.favoriteenemy.origin - behaviortreeentity.origin) * 36;
    if (enemydistsq < 256 * 256) {
        if (behaviortreeentity maymovetopoint(offset, 1, 1)) {
            yawtoenemy = angleclamp180(behaviortreeentity.angles[1] - vectortoangles(behaviortreeentity.favoriteenemy.origin - behaviortreeentity.origin)[1]);
            if (abs(yawtoenemy) <= 80) {
                return true;
            }
        }
    }
    return false;
}

// Namespace tigerbehavior/archetype_tiger
// Params 1, eflags: 0x0
// Checksum 0xb4e78dd, Offset: 0x20e8
// Size: 0x24
function function_cb05b5a0(behaviortreeentity) {
    return bb_getshouldrunstatus() == "walk";
}

// Namespace tigerbehavior/archetype_tiger
// Params 1, eflags: 0x0
// Checksum 0x7f0cf41d, Offset: 0x2118
// Size: 0x4c
function function_4731982a(behaviortreeentity) {
    if (isdefined(behaviortreeentity.aat_turned) && behaviortreeentity.aat_turned) {
        return true;
    }
    return bb_getshouldrunstatus() == "run";
}

// Namespace tigerbehavior/archetype_tiger
// Params 0, eflags: 0x0
// Checksum 0x15dd7926, Offset: 0x2170
// Size: 0x16e
function use_low_attack() {
    if (!isdefined(self.enemy) || !isplayer(self.enemy)) {
        return false;
    }
    height_diff = self.enemy.origin[2] - self.origin[2];
    low_enough = 30;
    if (height_diff < low_enough && self.enemy getstance() == "prone") {
        return true;
    }
    melee_origin = (self.origin[0], self.origin[1], self.origin[2] + 65);
    enemy_origin = (self.enemy.origin[0], self.enemy.origin[1], self.enemy.origin[2] + 32);
    if (!bullettracepassed(melee_origin, enemy_origin, 0, self)) {
        return true;
    }
    return false;
}

// Namespace tigerbehavior/archetype_tiger
// Params 2, eflags: 0x0
// Checksum 0xe0628620, Offset: 0x22e8
// Size: 0xa8
function function_831e0564(behaviortreeentity, asmstatename) {
    behaviortreeentity pathmode("dont move", 1);
    context = "high";
    if (behaviortreeentity use_low_attack()) {
        context = "low";
    }
    behaviortreeentity setblackboardattribute("_context", context);
    animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
    return 5;
}

// Namespace tigerbehavior/archetype_tiger
// Params 2, eflags: 0x0
// Checksum 0x96dfa72f, Offset: 0x2398
// Size: 0x58
function function_827c9499(behaviortreeentity, asmstatename) {
    behaviortreeentity setblackboardattribute("_context", undefined);
    behaviortreeentity pathmode("move allowed");
    return 4;
}

// Namespace tigerbehavior/archetype_tiger
// Params 2, eflags: 0x4
// Checksum 0x227c6b42, Offset: 0x23f8
// Size: 0x56
function private function_cd0fa9d2(entity, asmstatename) {
    animationstatenetworkutility::requeststate(entity, asmstatename);
    function_3452b278(entity);
    entity.hit_ent = 0;
    return 5;
}

// Namespace tigerbehavior/archetype_tiger
// Params 2, eflags: 0x4
// Checksum 0xec798d9b, Offset: 0x2458
// Size: 0x2b8
function private function_422ca15d(entity, asmstatename) {
    if (entity asmgetstatus() == "asm_status_complete") {
        return 4;
    }
    if (entity.hit_ent || !isdefined(entity.favoriteenemy) || !(isdefined(entity.var_408856ee) && entity.var_408856ee)) {
        return 5;
    }
    if (function_1af17862(entity)) {
        /#
            record3dtext("<dev string:x3a>", self.origin, (1, 0, 0), "<dev string:x48>", entity);
        #/
        entity.hit_ent = 1;
        return 5;
    }
    eye_pos = entity util::get_eye();
    enemy_eye_pos = entity.favoriteenemy util::get_eye();
    if (distancesquared(eye_pos, enemy_eye_pos) > entity.meleeweapon.aimeleerange * entity.meleeweapon.aimeleerange) {
        return 5;
    }
    trace = physicstrace(eye_pos, enemy_eye_pos, (-15, -15, -15), (15, 15, 15), self);
    if (trace[#"fraction"] < 1) {
        hit_ent = trace[#"entity"];
    }
    entity.hit_ent = isdefined(hit_ent);
    if (isdefined(hit_ent)) {
        hit_ent dodamage(150, hit_ent.origin, entity);
        hit_ent notify(#"hash_53620e40c7e139b9");
    }
    if (isdefined(level.var_c4ef77c)) {
        entity [[ level.var_c4ef77c ]]("tiger_melee_left", hit_ent);
    }
    if (isdefined(level.var_6a116baa)) {
        entity [[ level.var_6a116baa ]](entity.favoriteenemy, entity.hit_ent);
    }
    return 5;
}

// Namespace tigerbehavior/archetype_tiger
// Params 2, eflags: 0x4
// Checksum 0x7d426935, Offset: 0x2718
// Size: 0x5e
function private function_cd6346e3(entity, asmstatename) {
    function_35d9ce1b(entity);
    entity.hit_ent = undefined;
    entity.var_9a091f8a = 0;
    entity.var_7d2830bc = 0;
    entity.var_f45f364b = undefined;
    return 4;
}

// Namespace tigerbehavior/archetype_tiger
// Params 1, eflags: 0x0
// Checksum 0x39c972d5, Offset: 0x2780
// Size: 0x4c
function function_3452b278(entity) {
    entity.var_16fe609e = 1;
    self function_643dbbb0();
    entity pathmode("dont move", 1);
}

// Namespace tigerbehavior/archetype_tiger
// Params 1, eflags: 0x0
// Checksum 0xb4d7a5ac, Offset: 0x27d8
// Size: 0x4c
function function_35d9ce1b(entity) {
    entity.var_16fe609e = 0;
    self function_643dbbb0();
    entity pathmode("move allowed");
}

// Namespace tigerbehavior/archetype_tiger
// Params 4, eflags: 0x0
// Checksum 0xd90266cc, Offset: 0x2830
// Size: 0x44
function function_ecba8a0c(entity, attribute, oldvalue, value) {
    entity setblackboardattribute("_low_gravity", value);
}

// Namespace tigerbehavior/archetype_tiger
// Params 2, eflags: 0x0
// Checksum 0x31950cc2, Offset: 0x2880
// Size: 0x8c
function function_acd6bf1(tiger, entity) {
    forward = anglestoforward(tiger.angles);
    to_enemy = vectornormalize(entity.origin - tiger.origin);
    return vectordot(forward, to_enemy) >= 0.966;
}

// Namespace tigerbehavior/archetype_tiger
// Params 5, eflags: 0x0
// Checksum 0xc0688d6b, Offset: 0x29e0
// Size: 0x3c4
function function_5307b3c5(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity animmode("gravity", 1);
    entity orientmode("face angle", entity.angles[1]);
    entity.blockingpain = 1;
    entity.var_4d775096 = 1;
    entity.var_67b0a19a = 1;
    entity.usegoalanimweight = 1;
    entity pathmode("dont move");
    entity collidewithactors(0);
    entity.var_408856ee = 0;
    entity.var_494dc665 = getnotetracktimes(mocompanim, "start_trace")[0];
    entity.var_749bf77f = getnotetracktimes(mocompanim, "stop_trace")[0];
    if (isdefined(entity.enemy)) {
        dirtoenemy = vectornormalize(entity.enemy.origin - entity.origin);
        entity forceteleport(entity.origin, vectortoangles(dirtoenemy));
    }
    if (!isdefined(self.meleeinfo)) {
        self.meleeinfo = new class_8d5ffc42();
        self.meleeinfo.var_b41f1299 = entity.origin;
        self.meleeinfo.var_14f9d875 = getnotetracktimes(mocompanim, "start_procedural")[0];
        self.meleeinfo.var_4a9e662e = getnotetracktimes(mocompanim, "stop_procedural")[0];
        var_37cebf4f = getnotetracktimes(mocompanim, "stop_procedural_distance_check")[0];
        var_4e4d2dde = getmovedelta(mocompanim, 0, isdefined(var_37cebf4f) ? var_37cebf4f : 1, entity);
        self.meleeinfo.var_773d1d97 = entity localtoworldcoords(var_4e4d2dde);
        /#
            movedelta = getmovedelta(mocompanim, 0, 1, entity);
            animendpos = entity localtoworldcoords(movedelta);
            distance = distance(entity.origin, animendpos);
            recordcircle(animendpos, 3, (0, 1, 0), "<dev string:x4f>");
            record3dtext("<dev string:x56>" + distance, animendpos, (0, 1, 0), "<dev string:x4f>");
        #/
    }
}

// Namespace tigerbehavior/archetype_tiger
// Params 5, eflags: 0x0
// Checksum 0xfd22e251, Offset: 0x2db0
// Size: 0xa0c
function function_8d25f64(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    assert(isdefined(self.meleeinfo));
    currentanimtime = entity getanimtime(mocompanim);
    if (currentanimtime >= self.var_494dc665 && currentanimtime <= self.var_749bf77f) {
        self.var_408856ee = 1;
    } else {
        self.var_408856ee = 0;
    }
    if (isdefined(self.enemy) && !self.meleeinfo.adjustmentstarted && self.meleeinfo.var_98b8af1 && currentanimtime >= self.meleeinfo.var_14f9d875) {
        predictedenemypos = entity.enemy.origin;
        if (isplayer(entity.enemy)) {
            velocity = entity.enemy getvelocity();
            if (length(velocity) >= 0) {
                predictedenemypos += vectorscale(velocity, 0.25);
            }
        }
        var_7df9e75d = vectornormalize(predictedenemypos - entity.origin);
        var_fa4b714d = predictedenemypos - var_7df9e75d * entity getpathfindingradius();
        self.meleeinfo.adjustedendpos = var_fa4b714d;
        var_66728108 = distancesquared(self.meleeinfo.var_773d1d97, self.meleeinfo.adjustedendpos);
        var_873d139c = distancesquared(self.meleeinfo.var_b41f1299, self.meleeinfo.adjustedendpos);
        if (var_66728108 <= 35 * 35) {
            /#
                record3dtext("<dev string:x57>", entity.origin + (0, 0, 60), (1, 0, 0), "<dev string:x4f>");
            #/
            self.meleeinfo.var_98b8af1 = 0;
        } else if (var_873d139c <= 200 * 200) {
            /#
                record3dtext("<dev string:x62>", entity.origin + (0, 0, 60), (1, 0, 0), "<dev string:x4f>");
            #/
            self.meleeinfo.var_98b8af1 = 0;
        } else if (var_873d139c >= 400 * 400) {
            /#
                record3dtext("<dev string:x6e>", entity.origin + (0, 0, 60), (1, 0, 0), "<dev string:x4f>");
            #/
            self.meleeinfo.var_98b8af1 = 0;
        }
        if (self.meleeinfo.var_98b8af1) {
            var_66728108 = distancesquared(self.meleeinfo.var_773d1d97, self.meleeinfo.adjustedendpos);
            myforward = anglestoforward(self.angles);
            var_63d012a3 = (entity.enemy.origin[0], entity.enemy.origin[1], entity.origin[2]);
            dirtoenemy = vectornormalize(var_63d012a3 - entity.origin);
            zdiff = self.meleeinfo.var_773d1d97[2] - entity.enemy.origin[2];
            withinzrange = abs(zdiff) <= 30;
            withinfov = vectordot(myforward, dirtoenemy) > cos(30);
            var_4f74dce4 = withinzrange && withinfov;
            isvisible = bullettracepassed(entity.origin, entity.enemy.origin, 0, self);
            var_98b8af1 = isvisible && var_4f74dce4;
            /#
                reasons = "<dev string:x7a>" + isvisible + "<dev string:x7f>" + withinzrange + "<dev string:x83>" + withinfov;
                if (var_98b8af1) {
                    record3dtext(reasons, entity.origin + (0, 0, 60), (0, 1, 0), "<dev string:x4f>");
                } else {
                    record3dtext(reasons, entity.origin + (0, 0, 60), (1, 0, 0), "<dev string:x4f>");
                }
            #/
            if (var_98b8af1) {
                var_fb46decc = length(self.meleeinfo.adjustedendpos - self.meleeinfo.var_773d1d97);
                timestep = function_f9f48566();
                animlength = getanimlength(mocompanim) * 1000;
                starttime = self.meleeinfo.var_14f9d875 * animlength;
                stoptime = self.meleeinfo.var_4a9e662e * animlength;
                starttime = floor(starttime / timestep);
                stoptime = floor(stoptime / timestep);
                adjustduration = stoptime - starttime;
                self.meleeinfo.var_e4382b96 = vectornormalize(self.meleeinfo.adjustedendpos - self.meleeinfo.var_773d1d97);
                self.meleeinfo.var_8ae4eb71 = var_fb46decc / adjustduration;
                self.meleeinfo.var_98b8af1 = 1;
                self.meleeinfo.adjustmentstarted = 1;
            } else {
                self.meleeinfo.var_98b8af1 = 0;
            }
        }
    }
    if (self.meleeinfo.adjustmentstarted && currentanimtime <= self.meleeinfo.var_4a9e662e) {
        assert(isdefined(self.meleeinfo.var_e4382b96) && isdefined(self.meleeinfo.var_8ae4eb71));
        /#
            recordsphere(self.meleeinfo.var_773d1d97, 3, (0, 1, 0), "<dev string:x4f>");
            recordsphere(self.meleeinfo.adjustedendpos, 3, (0, 0, 1), "<dev string:x4f>");
        #/
        adjustedorigin = entity.origin + entity.meleeinfo.var_e4382b96 * self.meleeinfo.var_8ae4eb71;
    }
    if (isdefined(entity.favoriteenemy) && distancesquared(entity.favoriteenemy.origin, entity.origin) <= 64 * 64 && function_acd6bf1(entity, entity.favoriteenemy)) {
        entity animmode("angle deltas");
        return;
    }
    entity animmode("gravity");
    if (isdefined(adjustedorigin)) {
        entity forceteleport(adjustedorigin);
    }
}

// Namespace tigerbehavior/archetype_tiger
// Params 5, eflags: 0x0
// Checksum 0xfa280ed8, Offset: 0x37c8
// Size: 0xbe
function function_2227cf06(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity.blockingpain = 0;
    entity.var_4d775096 = undefined;
    entity.var_67b0a19a = undefined;
    entity.usegoalanimweight = 0;
    entity pathmode("move allowed");
    entity orientmode("face default");
    entity collidewithactors(1);
    entity.meleeinfo = undefined;
}

// Namespace tigerbehavior/archetype_tiger
// Params 5, eflags: 0x0
// Checksum 0x764e7f2b, Offset: 0x3890
// Size: 0x5a
function function_3655a7a1(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity orientmode("face enemy");
    entity.melee_notetrack = 0;
}

// Namespace tigerbehavior/archetype_tiger
// Params 5, eflags: 0x0
// Checksum 0xef2d1d58, Offset: 0x38f8
// Size: 0x12c
function function_7b3b58e8(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    if (isdefined(entity.melee_notetrack) && entity.melee_notetrack) {
        entity orientmode("face current");
        entity.melee_notetrack = 0;
    }
    if (isdefined(entity.favoriteenemy)) {
        if (distancesquared(entity.favoriteenemy.origin, entity.origin) <= 64 * 64 && function_acd6bf1(entity, entity.favoriteenemy)) {
            entity animmode("angle deltas");
            return;
        }
        entity animmode("normal");
    }
}

// Namespace tigerbehavior/archetype_tiger
// Params 5, eflags: 0x0
// Checksum 0xd55a8386, Offset: 0x3a30
// Size: 0x4c
function function_7882cb9a(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity orientmode("face default");
}

// Namespace tigerbehavior/archetype_tiger
// Params 5, eflags: 0x0
// Checksum 0x88b99baa, Offset: 0x3a88
// Size: 0xc4
function function_a54306c0(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    if (isdefined(entity.favoriteenemy)) {
        to_enemy = entity.favoriteenemy.origin - entity.origin;
        angles_to_enemy = vectortoangles(to_enemy);
        entity orientmode("face angle", angles_to_enemy);
        return;
    }
    entity orientmode("face enemy");
}

// Namespace tigerbehavior/archetype_tiger
// Params 5, eflags: 0x0
// Checksum 0xa9f44143, Offset: 0x3b58
// Size: 0x144
function function_d212c017(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    if (isdefined(entity.favoriteenemy)) {
        to_enemy = entity.favoriteenemy.origin - entity.origin;
        angles_to_enemy = vectortoangles(to_enemy);
        entity orientmode("face angle", angles_to_enemy);
        if (distancesquared(entity.favoriteenemy.origin, entity.origin) <= 64 * 64 && function_acd6bf1(entity, entity.favoriteenemy)) {
            entity animmode("angle deltas");
            return;
        }
        entity animmode("zonly_physics");
    }
}

// Namespace tigerbehavior/archetype_tiger
// Params 1, eflags: 0x0
// Checksum 0xadbe1e16, Offset: 0x3ca8
// Size: 0x22c
function function_1af17862(entity) {
    if (isdefined(entity.aat_turned) && entity.aat_turned) {
        if (isdefined(entity.favoriteenemy) && !isplayer(entity.favoriteenemy)) {
            if ((isdefined(entity.favoriteenemy.var_7d06ae6a) && entity.favoriteenemy.var_7d06ae6a || isdefined(entity.favoriteenemy.var_82c786f1) && entity.favoriteenemy.var_82c786f1) && isdefined(entity.favoriteenemy.allowdeath) && entity.favoriteenemy.allowdeath) {
                if (isdefined(entity.var_fcc82858)) {
                    e_attacker = entity.var_fcc82858;
                } else {
                    e_attacker = entity;
                }
                gibserverutils::gibhead(entity.favoriteenemy);
                entity.favoriteenemy zombie_utility::gib_random_parts();
                entity.favoriteenemy.var_74df1377 = 1;
                entity.favoriteenemy.var_7e95e0f5 = entity;
                entity.favoriteenemy kill(entity.favoriteenemy.origin, e_attacker, e_attacker, undefined, undefined, 1);
                entity.n_aat_turned_zombie_kills++;
            } else if (isdefined(entity.favoriteenemy.canbetargetedbyturnedzombies) && entity.favoriteenemy.canbetargetedbyturnedzombies) {
                entity melee();
            }
        }
        return true;
    }
    return false;
}

// Namespace tigerbehavior/archetype_tiger
// Params 1, eflags: 0x0
// Checksum 0x70ab0cb4, Offset: 0x3ee0
// Size: 0x34
function function_8cf8a7e(entity) {
    entity.var_10dac2a8 = "tiger_melee_left";
    function_aa2f1ef5(entity);
}

// Namespace tigerbehavior/archetype_tiger
// Params 1, eflags: 0x0
// Checksum 0x4a795c02, Offset: 0x3f20
// Size: 0x34
function function_d3387c3b(entity) {
    entity.var_10dac2a8 = "tiger_melee_right";
    function_aa2f1ef5(entity);
}

// Namespace tigerbehavior/archetype_tiger
// Params 1, eflags: 0x0
// Checksum 0x528c8ed7, Offset: 0x3f60
// Size: 0xc8
function function_aa2f1ef5(entity) {
    if (function_1af17862(entity)) {
        /#
            record3dtext("<dev string:x89>", self.origin, (1, 0, 0), "<dev string:x48>", entity);
        #/
    } else {
        hitent = entity melee();
        entity.melee_notetrack = 1;
        /#
            record3dtext("<dev string:x96>", self.origin, (1, 0, 0), "<dev string:x48>", entity);
        #/
    }
    return hitent;
}

// Namespace tigerbehavior/archetype_tiger
// Params 1, eflags: 0x0
// Checksum 0x88355fb5, Offset: 0x4030
// Size: 0x1cc
function function_d5709a03(entity) {
    if (function_1af17862(entity)) {
        /#
            record3dtext("<dev string:x3a>", self.origin, (1, 0, 0), "<dev string:x48>", entity);
        #/
        return;
    }
    eye_pos = entity util::get_eye();
    enemy_eye_pos = entity util::get_eye();
    trace = physicstrace(eye_pos, enemy_eye_pos, (-15, -15, -15), (15, 15, 15), self);
    if (trace[#"fraction"] < 1) {
        hit_ent = trace[#"entity"];
    }
    hit = isdefined(hit_ent);
    if (isdefined(hit_ent)) {
        hit_ent dodamage(150, hit_ent.origin, entity);
        hit_ent notify(#"hash_53620e40c7e139b9");
    }
    if (isdefined(level.var_c4ef77c)) {
        entity [[ level.var_c4ef77c ]]("tiger_melee_left", hit_ent);
    }
    if (isdefined(level.var_6a116baa)) {
        entity [[ level.var_6a116baa ]](entity.favoriteenemy, hit);
    }
}

// Namespace tigerbehavior/archetype_tiger
// Params 1, eflags: 0x0
// Checksum 0x478ed452, Offset: 0x4208
// Size: 0x1a
function function_6a116baa(func) {
    level.var_6a116baa = func;
}

// Namespace tigerbehavior/archetype_tiger
// Params 0, eflags: 0x0
// Checksum 0xa85126c5, Offset: 0x4230
// Size: 0x8e
function function_57b3ae76() {
    if (isdefined(self.favoriteenemy)) {
        predictedpos = self lastknownpos(self.favoriteenemy);
        if (isdefined(predictedpos)) {
            turnyaw = absangleclamp360(self.angles[1] - vectortoangles(predictedpos - self.origin)[1]);
            return turnyaw;
        }
    }
    return undefined;
}

/#

    // Namespace tigerbehavior/archetype_tiger
    // Params 0, eflags: 0x4
    // Checksum 0x2970a0c7, Offset: 0x42c8
    // Size: 0xb8
    function private function_56708dab() {
        enemies = getaiarchetypearray("<dev string:x30>");
        foreach (enemy in enemies) {
            if (isalive(enemy)) {
                enemy kill();
            }
        }
    }

    // Namespace tigerbehavior/archetype_tiger
    // Params 0, eflags: 0x4
    // Checksum 0x5c861f12, Offset: 0x4388
    // Size: 0xae
    function private function_4a051e92() {
        enemies = getaiarchetypearray("<dev string:x30>");
        foreach (enemy in enemies) {
            if (isalive(enemy)) {
                enemy.var_ff860bd8 = gettime();
            }
        }
    }

    // Namespace tigerbehavior/archetype_tiger
    // Params 0, eflags: 0x4
    // Checksum 0xc893534a, Offset: 0x4440
    // Size: 0x1c8
    function private function_16678bdf() {
        adddebugcommand("<dev string:x9c>");
        adddebugcommand("<dev string:xdb>");
        adddebugcommand("<dev string:x11c>");
        while (true) {
            waitframe(1);
            string = getdvarstring(#"hash_3b467d1615c469f8", "<dev string:x56>");
            cmd = strtok(string, "<dev string:x163>");
            if (cmd.size > 0) {
                switch (cmd[0]) {
                case #"spawn":
                    zm_devgui::spawn_archetype("<dev string:x165>");
                    break;
                case #"kill":
                    function_56708dab();
                    break;
                case #"pounce":
                    function_4a051e92();
                    break;
                default:
                    if (isdefined(level.var_9bdaa5ed)) {
                        [[ level.var_9bdaa5ed ]](cmd);
                    }
                    break;
                }
            }
            setdvar(#"hash_3b467d1615c469f8", "<dev string:x56>");
        }
    }

#/
