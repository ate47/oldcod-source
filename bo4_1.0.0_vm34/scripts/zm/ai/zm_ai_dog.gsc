#using scripts\core_common\ai\archetype_mocomps_utility;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\system_shared;
#using scripts\zm\ai\zm_ai_dog_interface;
#using scripts\zm_common\zm_utility;

#namespace zm_ai_dog;

// Namespace zm_ai_dog/zm_ai_dog
// Params 0, eflags: 0x2
// Checksum 0x6d57e9e0, Offset: 0x1b0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_ai_dog", &__init__, undefined, undefined);
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 0, eflags: 0x0
// Checksum 0x8e1c2adc, Offset: 0x1f8
// Size: 0x3c
function __init__() {
    registerbehaviorscriptfunctions();
    spawner::add_archetype_spawn_function("zombie_dog", &function_acf2197b);
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 0, eflags: 0x0
// Checksum 0x47f39efa, Offset: 0x240
// Size: 0x5a
function function_acf2197b() {
    self.var_532a149b = zm_utility::get_closest_valid_player(self.origin, undefined, 1);
    self.closest_player_override = &zm_utility::function_87d568c4;
    self.var_a015e2e5 = &function_bf5ae2aa;
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 0, eflags: 0x0
// Checksum 0xc4743983, Offset: 0x2a8
// Size: 0x35c
function registerbehaviorscriptfunctions() {
    spawner::add_archetype_spawn_function("zombie_dog", &archetypezombiedogblackboardinit);
    assert(isscriptfunctionptr(&zombiedogtargetservice));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiedogtargetservice", &zombiedogtargetservice);
    assert(isscriptfunctionptr(&function_aa887ec));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_29b43f0d0b6bd4e2", &function_aa887ec, 5);
    assert(isscriptfunctionptr(&zombiedogshouldmelee));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiedogshouldmelee", &zombiedogshouldmelee);
    assert(isscriptfunctionptr(&zombiedogshouldwalk));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiedogshouldwalk", &zombiedogshouldwalk);
    assert(isscriptfunctionptr(&zombiedogshouldrun));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiedogshouldrun", &zombiedogshouldrun);
    assert(!isdefined(&zombiedogmeleeaction) || isscriptfunctionptr(&zombiedogmeleeaction));
    assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
    assert(!isdefined(&zombiedogmeleeactionterminate) || isscriptfunctionptr(&zombiedogmeleeactionterminate));
    behaviortreenetworkutility::registerbehaviortreeaction("zombieDogMeleeAction", &zombiedogmeleeaction, undefined, &zombiedogmeleeactionterminate);
    zm_ai_dog_interface::registerzombiedoginterfaceattributes();
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 0, eflags: 0x0
// Checksum 0x9f491f08, Offset: 0x610
// Size: 0x56
function archetypezombiedogblackboardinit() {
    blackboard::createblackboardforentity(self);
    ai::createinterfaceforentity(self);
    self.___archetypeonanimscriptedcallback = &archetypezombiedogonanimscriptedcallback;
    self.kill_on_wine_coccon = 1;
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 1, eflags: 0x4
// Checksum 0x2249c2bc, Offset: 0x670
// Size: 0x2c
function private archetypezombiedogonanimscriptedcallback(entity) {
    entity.__blackboard = undefined;
    entity archetypezombiedogblackboardinit();
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 0, eflags: 0x0
// Checksum 0x99e92186, Offset: 0x6a8
// Size: 0x92
function bb_getshouldrunstatus() {
    /#
        if (isdefined(self.ispuppet) && self.ispuppet) {
            return "<dev string:x30>";
        }
    #/
    if (isdefined(self.hasseenfavoriteenemy) && self.hasseenfavoriteenemy || ai::hasaiattribute(self, "sprint") && ai::getaiattribute(self, "sprint")) {
        return "run";
    }
    return "walk";
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 0, eflags: 0x0
// Checksum 0x67d8f196, Offset: 0x748
// Size: 0xc2
function bb_getshouldhowlstatus() {
    if (self ai::has_behavior_attribute("howl_chance") && isdefined(self.hasseenfavoriteenemy) && self.hasseenfavoriteenemy) {
        if (!isdefined(self.shouldhowl)) {
            chance = self ai::get_behavior_attribute("howl_chance");
            self.shouldhowl = randomfloat(1) <= chance;
        }
        return (self.shouldhowl ? "howl" : "dont_howl");
    }
    return "dont_howl";
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 1, eflags: 0x0
// Checksum 0x33e9069c, Offset: 0x818
// Size: 0x40
function getyaw(org) {
    angles = vectortoangles(org - self.origin);
    return angles[1];
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 0, eflags: 0x0
// Checksum 0x2233dc09, Offset: 0x860
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

// Namespace zm_ai_dog/zm_ai_dog
// Params 0, eflags: 0x0
// Checksum 0x2caa17ff, Offset: 0x900
// Size: 0x22a
function need_to_run() {
    run_dist_squared = self ai::get_behavior_attribute("min_run_dist") * self ai::get_behavior_attribute("min_run_dist");
    run_yaw = 20;
    run_pitch = 30;
    run_height = 64;
    if (level.dog_round_count > 1) {
        return true;
    }
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

// Namespace zm_ai_dog/zm_ai_dog
// Params 2, eflags: 0x4
// Checksum 0x85003d9b, Offset: 0xb38
// Size: 0x224
function private is_target_valid(dog, target) {
    if (!isdefined(target)) {
        return 0;
    }
    if (!isalive(target)) {
        return 0;
    }
    if (!(dog.team == #"allies")) {
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
    if (isplayer(target) && isdefined(level.var_c69b1b9b)) {
        if (!dog [[ level.var_c69b1b9b ]](target)) {
            return 0;
        }
    }
    if (isplayer(target) && isdefined(level.is_player_valid_override)) {
        return [[ level.is_player_valid_override ]](target);
    }
    return 1;
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 1, eflags: 0x4
// Checksum 0xe860f146, Offset: 0xd68
// Size: 0x258
function private get_favorite_enemy(dog) {
    dog_targets = [];
    if (sessionmodeiszombiesgame()) {
        if (self.team == #"allies") {
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
        if (dog_targets[i].hunted_by <= least_hunted.hunted_by && (!isdefined(closest_target_dist_squared) || dist_squared < closest_target_dist_squared)) {
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

// Namespace zm_ai_dog/zm_ai_dog
// Params 0, eflags: 0x0
// Checksum 0xd96564e2, Offset: 0xfc8
// Size: 0x2e
function get_last_valid_position() {
    if (isplayer(self)) {
        return self.last_valid_position;
    }
    return self.origin;
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 1, eflags: 0x0
// Checksum 0x24d91fbf, Offset: 0x1000
// Size: 0x252
function get_locomotion_target(behaviortreeentity) {
    if (!isdefined(behaviortreeentity.favoriteenemy)) {
        return undefined;
    }
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

// Namespace zm_ai_dog/zm_ai_dog
// Params 1, eflags: 0x0
// Checksum 0x2cd3edaa, Offset: 0x1260
// Size: 0x3ba
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
    if (behaviortreeentity ai::has_behavior_attribute("patrol") && behaviortreeentity ai::get_behavior_attribute("patrol")) {
        return;
    }
    if (!is_target_valid(behaviortreeentity, behaviortreeentity.favoriteenemy)) {
        if (isdefined(behaviortreeentity.favoriteenemy)) {
            function_bf5ae2aa(behaviortreeentity);
            behaviortreeentity.hasseenfavoriteenemy = 0;
        }
        behaviortreeentity.favoriteenemy = get_favorite_enemy(behaviortreeentity);
    }
    if (behaviortreeentity.ignoreall || behaviortreeentity.pacifist || !is_target_valid(behaviortreeentity, behaviortreeentity.favoriteenemy)) {
        if (is_target_valid(behaviortreeentity, behaviortreeentity.favoriteenemy)) {
            if (isdefined(level.var_f86a6db6)) {
                [[ level.var_f86a6db6 ]](behaviortreeentity);
            }
        } else {
            if (isdefined(behaviortreeentity function_e9a79b0e().overridegoalpos)) {
                behaviortreeentity function_9f59031e();
            }
            if (isdefined(level.no_target_override)) {
                [[ level.no_target_override ]](behaviortreeentity);
                return;
            }
            behaviortreeentity setgoal(behaviortreeentity.origin);
            return;
        }
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
                behaviortreeentity function_3c8dce03(locomotion_target);
                behaviortreeentity.lasttargetposition = locomotion_target;
            }
        }
    }
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 1, eflags: 0x0
// Checksum 0x90313e0f, Offset: 0x1628
// Size: 0xe0
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

// Namespace zm_ai_dog/zm_ai_dog
// Params 1, eflags: 0x0
// Checksum 0x11bc3eee, Offset: 0x1710
// Size: 0x24
function zombiedogshouldwalk(behaviortreeentity) {
    return bb_getshouldrunstatus() == "walk";
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 1, eflags: 0x0
// Checksum 0x834fd331, Offset: 0x1740
// Size: 0x24
function zombiedogshouldrun(behaviortreeentity) {
    return bb_getshouldrunstatus() == "run";
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 0, eflags: 0x0
// Checksum 0x72a6f7e0, Offset: 0x1770
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

// Namespace zm_ai_dog/zm_ai_dog
// Params 2, eflags: 0x0
// Checksum 0xf8239085, Offset: 0x18e8
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

// Namespace zm_ai_dog/zm_ai_dog
// Params 2, eflags: 0x0
// Checksum 0x2d00898a, Offset: 0x1990
// Size: 0x38
function zombiedogmeleeactionterminate(behaviortreeentity, asmstatename) {
    behaviortreeentity setblackboardattribute("_context", undefined);
    return 4;
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 4, eflags: 0x0
// Checksum 0xe31643e9, Offset: 0x19d0
// Size: 0x44
function zombiedoggravity(entity, attribute, oldvalue, value) {
    entity setblackboardattribute("_low_gravity", value);
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 1, eflags: 0x0
// Checksum 0x183aea75, Offset: 0x1a20
// Size: 0x13c
function function_aa887ec(dog) {
    if (!isdefined(dog.favoriteenemy) || !zm_utility::is_player_valid(dog.favoriteenemy)) {
        return;
    }
    if (!isdefined(dog.var_532a149b) || dog.favoriteenemy == dog.var_532a149b) {
        return;
    }
    var_fdb1a1c3 = dog zm_utility::approximate_path_dist(dog.favoriteenemy);
    new_target_dist = dog zm_utility::approximate_path_dist(dog.var_532a149b);
    if (isdefined(var_fdb1a1c3)) {
        if (isdefined(new_target_dist) && var_fdb1a1c3 - new_target_dist > 200) {
            dog function_41698890(dog, dog.var_532a149b);
        }
        return;
    }
    if (isdefined(new_target_dist)) {
        dog function_41698890(dog, dog.var_532a149b);
    }
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 2, eflags: 0x0
// Checksum 0x3469b7d9, Offset: 0x1b68
// Size: 0x70
function function_41698890(dog, new_target) {
    function_bf5ae2aa(dog);
    if (!isdefined(new_target.hunted_by)) {
        new_target.hunted_by = 0;
    }
    dog.favoriteenemy = new_target;
    dog.favoriteenemy.hunted_by++;
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 1, eflags: 0x0
// Checksum 0x3697a572, Offset: 0x1be0
// Size: 0x72
function function_bf5ae2aa(dog) {
    if (isdefined(dog.favoriteenemy) && isdefined(dog.favoriteenemy.hunted_by) && dog.favoriteenemy.hunted_by > 0) {
        dog.favoriteenemy.hunted_by--;
    }
    dog.favoriteenemy = undefined;
}

