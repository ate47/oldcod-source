#using scripts/core_common/ai/archetype_mocomps_utility;
#using scripts/core_common/ai/archetype_utility;
#using scripts/core_common/ai/archetype_zombie_dog_interface;
#using scripts/core_common/ai/systems/ai_interface;
#using scripts/core_common/ai/systems/animation_state_machine_notetracks;
#using scripts/core_common/ai/systems/animation_state_machine_utility;
#using scripts/core_common/ai/systems/behavior_tree_utility;
#using scripts/core_common/ai/systems/blackboard;
#using scripts/core_common/ai/zombie;
#using scripts/core_common/ai_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/spawner_shared;

#namespace namespace_1db6d2c9;

// Namespace namespace_1db6d2c9/behavior_zombie_dog
// Params 0, eflags: 0x2
// Checksum 0xe5b44ad6, Offset: 0x410
// Size: 0x2f4
function autoexec registerbehaviorscriptfunctions() {
    spawner::add_archetype_spawn_function("zombie_dog", &archetypezombiedogblackboardinit);
    /#
        assert(isscriptfunctionptr(&zombiedogtargetservice));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieDogTargetService", &zombiedogtargetservice);
    /#
        assert(isscriptfunctionptr(&zombiedogshouldmelee));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieDogShouldMelee", &zombiedogshouldmelee);
    /#
        assert(isscriptfunctionptr(&zombiedogshouldwalk));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieDogShouldWalk", &zombiedogshouldwalk);
    /#
        assert(isscriptfunctionptr(&zombiedogshouldrun));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieDogShouldRun", &zombiedogshouldrun);
    /#
        assert(!isdefined(&zombiedogmeleeaction) || isscriptfunctionptr(&zombiedogmeleeaction));
    #/
    /#
        assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    #/
    /#
        assert(!isdefined(&zombiedogmeleeactionterminate) || isscriptfunctionptr(&zombiedogmeleeactionterminate));
    #/
    behaviortreenetworkutility::registerbehaviortreeaction("zombieDogMeleeAction", &zombiedogmeleeaction, undefined, &zombiedogmeleeactionterminate);
    animationstatenetwork::registernotetrackhandlerfunction("dog_melee", &zombiebehavior::zombienotetrackmeleefire);
    namespace_273d1a1c::registerzombiedoginterfaceattributes();
}

// Namespace namespace_1db6d2c9/behavior_zombie_dog
// Params 0, eflags: 0x0
// Checksum 0x8b52ed2c, Offset: 0x710
// Size: 0x5c
function archetypezombiedogblackboardinit() {
    blackboard::createblackboardforentity(self);
    ai::createinterfaceforentity(self);
    self.___archetypeonanimscriptedcallback = &archetypezombiedogonanimscriptedcallback;
    self.kill_on_wine_coccon = 1;
}

// Namespace namespace_1db6d2c9/behavior_zombie_dog
// Params 1, eflags: 0x4
// Checksum 0x61ffbdeb, Offset: 0x778
// Size: 0x34
function private archetypezombiedogonanimscriptedcallback(entity) {
    entity.__blackboard = undefined;
    entity archetypezombiedogblackboardinit();
}

// Namespace namespace_1db6d2c9/behavior_zombie_dog
// Params 0, eflags: 0x0
// Checksum 0x6ed4d65, Offset: 0x7b8
// Size: 0x9e
function bb_getshouldrunstatus() {
    /#
        if (isdefined(self.ispuppet) && self.ispuppet) {
            return "<dev string:x28>";
        }
    #/
    if (ai::hasaiattribute(self, "sprint") && (isdefined(self.hasseenfavoriteenemy) && self.hasseenfavoriteenemy || ai::getaiattribute(self, "sprint"))) {
        return "run";
    }
    return "walk";
}

// Namespace namespace_1db6d2c9/behavior_zombie_dog
// Params 0, eflags: 0x0
// Checksum 0x6704b077, Offset: 0x860
// Size: 0xc6
function bb_getshouldhowlstatus() {
    if (isdefined(self.hasseenfavoriteenemy) && self ai::has_behavior_attribute("howl_chance") && self.hasseenfavoriteenemy) {
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

// Namespace namespace_1db6d2c9/behavior_zombie_dog
// Params 1, eflags: 0x0
// Checksum 0x68408cf4, Offset: 0x930
// Size: 0x42
function getyaw(org) {
    angles = vectortoangles(org - self.origin);
    return angles[1];
}

// Namespace namespace_1db6d2c9/behavior_zombie_dog
// Params 0, eflags: 0x0
// Checksum 0xa052066c, Offset: 0x980
// Size: 0xa0
function absyawtoenemy() {
    /#
        assert(isdefined(self.enemy));
    #/
    yaw = self.angles[1] - getyaw(self.enemy.origin);
    yaw = angleclamp180(yaw);
    if (yaw < 0) {
        yaw = -1 * yaw;
    }
    return yaw;
}

// Namespace namespace_1db6d2c9/behavior_zombie_dog
// Params 0, eflags: 0x0
// Checksum 0x4cf515e5, Offset: 0xa28
// Size: 0x23c
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

// Namespace namespace_1db6d2c9/behavior_zombie_dog
// Params 2, eflags: 0x4
// Checksum 0xace42791, Offset: 0xc70
// Size: 0x1fc
function private is_target_valid(dog, target) {
    if (!isdefined(target)) {
        return 0;
    }
    if (!isalive(target)) {
        return 0;
    }
    if (!(dog.team == "allies")) {
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
    if (dog.team == target.team) {
        return 0;
    }
    if (isplayer(target) && isdefined(level.is_player_valid_override)) {
        return [[ level.is_player_valid_override ]](target);
    }
    return 1;
}

// Namespace namespace_1db6d2c9/behavior_zombie_dog
// Params 1, eflags: 0x4
// Checksum 0xe8e3fd63, Offset: 0xe78
// Size: 0x276
function private get_favorite_enemy(dog) {
    dog_targets = [];
    if (sessionmodeiszombiesgame()) {
        if (self.team == "allies") {
            dog_targets = getaiteamarray(level.zombie_team);
        } else {
            dog_targets = getplayers();
        }
    } else {
        dog_targets = arraycombine(getplayers(), getaiarray(), 0, 0);
    }
    least_hunted = dog_targets[0];
    closest_target_dist_squared = undefined;
    for (i = 0; i < dog_targets.size; i++) {
        if (!isdefined(dog_targets[i].hunted_by)) {
            dog_targets[i].hunted_by = 0;
        }
        if (!is_target_valid(dog, dog_targets[i])) {
            continue;
        }
        if (!is_target_valid(dog, least_hunted)) {
            least_hunted = dog_targets[i];
        }
        dist_squared = distancesquared(dog.origin, dog_targets[i].origin);
        if (!isdefined(closest_target_dist_squared) || dog_targets[i].hunted_by <= least_hunted.hunted_by && dist_squared < closest_target_dist_squared) {
            least_hunted = dog_targets[i];
            closest_target_dist_squared = dist_squared;
        }
    }
    if (!is_target_valid(dog, least_hunted)) {
        return undefined;
    }
    least_hunted.hunted_by += 1;
    return least_hunted;
}

// Namespace namespace_1db6d2c9/behavior_zombie_dog
// Params 0, eflags: 0x0
// Checksum 0x3b79c6d0, Offset: 0x10f8
// Size: 0x32
function get_last_valid_position() {
    if (isplayer(self)) {
        return self.last_valid_position;
    }
    return self.origin;
}

// Namespace namespace_1db6d2c9/behavior_zombie_dog
// Params 1, eflags: 0x0
// Checksum 0x5245aff0, Offset: 0x1138
// Size: 0x280
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

// Namespace namespace_1db6d2c9/behavior_zombie_dog
// Params 1, eflags: 0x0
// Checksum 0xe322d4c2, Offset: 0x13c0
// Size: 0x3d0
function zombiedogtargetservice(behaviortreeentity) {
    if (isdefined(level.intermission) && level.intermission) {
        behaviortreeentity clearpath();
        return;
    }
    /#
        if (isdefined(behaviortreeentity.ispuppet) && behaviortreeentity.ispuppet) {
            return;
        }
    #/
    if (isdefined(behaviortreeentity.favoriteenemy) && (behaviortreeentity.ignoreall || behaviortreeentity.pacifist || !is_target_valid(behaviortreeentity, behaviortreeentity.favoriteenemy))) {
        if (isdefined(behaviortreeentity.favoriteenemy) && isdefined(behaviortreeentity.favoriteenemy.hunted_by) && behaviortreeentity.favoriteenemy.hunted_by > 0) {
            behaviortreeentity.favoriteenemy.hunted_by--;
        }
        behaviortreeentity.favoriteenemy = undefined;
        behaviortreeentity.hasseenfavoriteenemy = 0;
        if (!behaviortreeentity.ignoreall) {
            behaviortreeentity setgoal(behaviortreeentity.origin);
        }
        return;
    }
    if (isdefined(behaviortreeentity.ignoreme) && behaviortreeentity.ignoreme) {
        return;
    }
    if ((!sessionmodeiszombiesgame() || behaviortreeentity.team == "allies") && !is_target_valid(behaviortreeentity, behaviortreeentity.favoriteenemy)) {
        behaviortreeentity.favoriteenemy = get_favorite_enemy(behaviortreeentity);
    }
    if (!(isdefined(behaviortreeentity.hasseenfavoriteenemy) && behaviortreeentity.hasseenfavoriteenemy)) {
        if (isdefined(behaviortreeentity.favoriteenemy) && behaviortreeentity need_to_run()) {
            behaviortreeentity.hasseenfavoriteenemy = 1;
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
                behaviortreeentity useposition(locomotion_target);
                behaviortreeentity.lasttargetposition = locomotion_target;
            }
        }
    }
}

// Namespace namespace_1db6d2c9/behavior_zombie_dog
// Params 1, eflags: 0x0
// Checksum 0x4cc4044, Offset: 0x1798
// Size: 0xe6
function zombiedogshouldmelee(behaviortreeentity) {
    if (behaviortreeentity.ignoreall || !is_target_valid(behaviortreeentity, behaviortreeentity.favoriteenemy)) {
        return false;
    }
    if (!(isdefined(level.intermission) && level.intermission)) {
        meleedist = 72;
        if (distancesquared(behaviortreeentity.origin, behaviortreeentity.favoriteenemy.origin) < meleedist * meleedist && behaviortreeentity cansee(behaviortreeentity.favoriteenemy)) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_1db6d2c9/behavior_zombie_dog
// Params 1, eflags: 0x0
// Checksum 0x7a5ca6f7, Offset: 0x1888
// Size: 0x24
function zombiedogshouldwalk(behaviortreeentity) {
    return bb_getshouldrunstatus() == "walk";
}

// Namespace namespace_1db6d2c9/behavior_zombie_dog
// Params 1, eflags: 0x0
// Checksum 0x8449945c, Offset: 0x18b8
// Size: 0x24
function zombiedogshouldrun(behaviortreeentity) {
    return bb_getshouldrunstatus() == "run";
}

// Namespace namespace_1db6d2c9/behavior_zombie_dog
// Params 0, eflags: 0x0
// Checksum 0xc7cce90c, Offset: 0x18e8
// Size: 0x186
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

// Namespace namespace_1db6d2c9/behavior_zombie_dog
// Params 2, eflags: 0x0
// Checksum 0x36bc8b1a, Offset: 0x1a78
// Size: 0xa0
function zombiedogmeleeaction(behaviortreeentity, asmstatename) {
    behaviortreeentity clearpath();
    context = "high";
    if (behaviortreeentity use_low_attack()) {
        context = "low";
    }
    behaviortreeentity setblackboardattribute("_context", context);
    animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
    return 5;
}

// Namespace namespace_1db6d2c9/behavior_zombie_dog
// Params 2, eflags: 0x0
// Checksum 0xf12638a7, Offset: 0x1b20
// Size: 0x38
function zombiedogmeleeactionterminate(behaviortreeentity, asmstatename) {
    behaviortreeentity setblackboardattribute("_context", undefined);
    return 4;
}

// Namespace namespace_1db6d2c9/behavior_zombie_dog
// Params 4, eflags: 0x0
// Checksum 0x5d162c44, Offset: 0x1b60
// Size: 0x44
function zombiedoggravity(entity, attribute, oldvalue, value) {
    entity setblackboardattribute("_low_gravity", value);
}

