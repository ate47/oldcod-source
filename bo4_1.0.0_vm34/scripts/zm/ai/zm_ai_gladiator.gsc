#using script_2c5daa95f8fec03c;
#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\archetype_damage_utility;
#using scripts\core_common\ai\archetype_locomotion_utility;
#using scripts\core_common\ai\archetype_mocomps_utility;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\ai_blackboard;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\animation_state_machine_mocomp;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\ai\systems\behavior_state_machine;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai\systems\debug;
#using scripts\core_common\ai\systems\destructible_character;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm\ai\zm_ai_catalyst;
#using scripts\zm\ai\zm_ai_gladiator_interface;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_behavior;
#using scripts\zm_common\zm_cleanup_mgr;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_hero_weapon;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_zonemgr;

#namespace zm_ai_gladiator;

// Namespace zm_ai_gladiator
// Method(s) 2 Total 2
class class_36f71b4 {

    var adjustmentstarted;
    var var_98b8af1;

    // Namespace class_36f71b4/zm_ai_gladiator
    // Params 0, eflags: 0x8
    // Checksum 0x6281273b, Offset: 0x2e48
    // Size: 0x1a
    constructor() {
        adjustmentstarted = 0;
        var_98b8af1 = 1;
    }

}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 0, eflags: 0x2
// Checksum 0x98ad5601, Offset: 0x6e0
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_ai_gladiator", &__init__, &__main__, undefined);
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 0, eflags: 0x0
// Checksum 0xd24b2a93, Offset: 0x730
// Size: 0x294
function __init__() {
    spawner::add_archetype_spawn_function("gladiator", &function_1a2c3f84);
    registerbehaviorscriptfunctions();
    zm_player::register_player_damage_callback(&function_92188bbb);
    zm_ai_gladiator_interface::registergladiatorinterfaceattributes();
    spawner::add_archetype_spawn_function("gladiator", &function_1a99b842);
    clientfield::register("toplayer", "gladiator_melee_effect", 1, 1, "counter");
    clientfield::register("actor", "gladiator_arm_effect", 1, 2, "int");
    clientfield::register("scriptmover", "gladiator_axe_effect", 1, 1, "int");
    level thread aat::register_immunity("zm_aat_brain_decay", "gladiator", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_frostbite", "gladiator", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_kill_o_watt", "gladiator", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_plasmatic_burst", "gladiator", 1, 1, 1);
    /#
        if (isarchetypeloaded("<dev string:x30>")) {
            level thread function_16d54b7b();
        }
        spawner::add_archetype_spawn_function("<dev string:x30>", &zombie_utility::updateanimationrate);
    #/
    animationstatenetwork::registernotetrackhandlerfunction("dropgun_left", &detachleft);
    animationstatenetwork::registernotetrackhandlerfunction("dropgun_right", &detachright);
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 1, eflags: 0x0
// Checksum 0x2a3fd38c, Offset: 0x9d0
// Size: 0x4c
function detachleft(entity) {
    if (isdefined(self.var_3d795b5f) && self.var_3d795b5f) {
        destructserverutils::function_fa9a6761(entity, "left_hand", "tag_weapon_left");
    }
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 1, eflags: 0x0
// Checksum 0x57dd61a5, Offset: 0xa28
// Size: 0x4c
function detachright(entity) {
    if (isdefined(self.var_7a8c9af2) && self.var_7a8c9af2) {
        destructserverutils::function_fa9a6761(entity, "right_hand", "tag_weapon_right");
    }
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0xa80
// Size: 0x4
function __main__() {
    
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 0, eflags: 0x0
// Checksum 0xd76c19d3, Offset: 0xa90
// Size: 0x4a
function function_1a2c3f84() {
    blackboard::createblackboardforentity(self);
    ai::createinterfaceforentity(self);
    self.___archetypeonanimscriptedcallback = &function_f9c7622a;
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 1, eflags: 0x4
// Checksum 0xb987a0b1, Offset: 0xae8
// Size: 0x2c
function private function_f9c7622a(entity) {
    entity.__blackboard = undefined;
    entity function_1a2c3f84();
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 0, eflags: 0x0
// Checksum 0x3d9c1bd8, Offset: 0xb20
// Size: 0xe14
function registerbehaviorscriptfunctions() {
    assert(isscriptfunctionptr(&gladiatortargetservice));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"gladiatortargetservice", &gladiatortargetservice);
    assert(isscriptfunctionptr(&function_a090d398));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2f31066d04316712", &function_a090d398);
    assert(isscriptfunctionptr(&function_de6c770b));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_19f5dddb53541f2f", &function_de6c770b);
    assert(isscriptfunctionptr(&function_d7f10454));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3d538371b59fc4ce", &function_d7f10454);
    assert(isscriptfunctionptr(&function_293e5948));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_205614b8bf4014e6", &function_293e5948);
    assert(isscriptfunctionptr(&function_293e5948));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_205614b8bf4014e6", &function_293e5948);
    assert(isscriptfunctionptr(&function_7c59ac0d));
    behaviorstatemachine::registerbsmscriptapiinternal(#"hash_48c3fc4eec7605", &function_7c59ac0d);
    assert(isscriptfunctionptr(&function_7c59ac0d));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_48c3fc4eec7605", &function_7c59ac0d);
    assert(isscriptfunctionptr(&function_37cec80c));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4aefcc750ed27716", &function_37cec80c);
    assert(isscriptfunctionptr(&function_953b6aa3));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1e62e0f93339aad3", &function_953b6aa3);
    assert(isscriptfunctionptr(&function_ac3d6ce8));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4038d6d7b731c1de", &function_ac3d6ce8);
    assert(isscriptfunctionptr(&function_b19d727c));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1d96f193711e7602", &function_b19d727c);
    assert(isscriptfunctionptr(&function_5d3f0d94));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_753bdf09b9b21d9a", &function_5d3f0d94);
    assert(isscriptfunctionptr(&function_2eca5971));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_649ab6146cce9955", &function_2eca5971);
    assert(isscriptfunctionptr(&function_75c7c35e));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_19966227fe912af8", &function_75c7c35e);
    assert(isscriptfunctionptr(&gladiatorshouldreact));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"gladiatorshouldreact", &gladiatorshouldreact);
    assert(isscriptfunctionptr(&function_a2386928));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5934d511f3d43e76", &function_a2386928);
    assert(isscriptfunctionptr(&function_6727863c));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7114ad7e891644ce", &function_6727863c);
    assert(isscriptfunctionptr(&gladiatorpickaxe));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"gladiatorpickaxe", &gladiatorpickaxe);
    assert(isscriptfunctionptr(&gladiatorpickaxe));
    behaviorstatemachine::registerbsmscriptapiinternal(#"gladiatorpickaxe", &gladiatorpickaxe);
    assert(isscriptfunctionptr(&function_4e44c1d4));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2ec3db12905e5ef2", &function_4e44c1d4);
    assert(isscriptfunctionptr(&function_ad450e9f));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_324b5266aa732357", &function_ad450e9f);
    assert(isscriptfunctionptr(&function_cbbb856e));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7a99cf7ed75b85d4", &function_cbbb856e);
    assert(isscriptfunctionptr(&function_855ecfef));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_84d084fea1afb67", &function_855ecfef);
    assert(isscriptfunctionptr(&function_4ed41066));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_72578a0bdaf6cabc", &function_4ed41066);
    assert(isscriptfunctionptr(&function_9bc27177));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1c6cfcf6fdb404ff", &function_9bc27177);
    assert(isscriptfunctionptr(&function_bc378f53));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_50e5d4b2634f5877", &function_bc378f53);
    assert(isscriptfunctionptr(&function_4843f735));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_52aa25564f02b9a1", &function_4843f735);
    assert(isscriptfunctionptr(&function_70a12476));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2d6fdeb321d8ce80", &function_70a12476);
    assert(isscriptfunctionptr(&function_c691d75b));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7ed731cb43b72ab7", &function_c691d75b);
    assert(isscriptfunctionptr(&function_be3cb438));
    behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_51d4a260f5e68d32", &function_be3cb438);
    animationstatenetwork::registeranimationmocomp("mocomp_gladiator_leap", &function_85937c7b, &function_4ddd346e, &function_2733358);
    animationstatenetwork::registeranimationmocomp("mocomp_gladiator_throw", &function_69fde0a7, &function_c0af8072, &function_64beb50c);
    animationstatenetwork::registeranimationmocomp("mocomp_gladiator_run_melee", &function_e1952f16, &function_a3e76fd9, &function_939c0547);
    animationstatenetwork::registernotetrackhandlerfunction("gladiator_melee", &function_ba68aabf);
    animationstatenetwork::registernotetrackhandlerfunction("axe_throw_start", &function_37d38b77);
    animationstatenetwork::registernotetrackhandlerfunction("axe_reload", &function_4d0a5289);
    animationstatenetwork::registernotetrackhandlerfunction("detach_limb", &function_701636ae);
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 10, eflags: 0x4
// Checksum 0x4d787171, Offset: 0x1940
// Size: 0x128
function private function_92188bbb(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
    if (isdefined(eattacker) && isai(eattacker) && eattacker.archetype == "gladiator" && eattacker.team != self.team) {
        if (eattacker ai::has_behavior_attribute("damage_multiplier")) {
            damage_multiplier = eattacker ai::get_behavior_attribute("damage_multiplier");
            if (damage_multiplier != 1) {
                damage_mod = idamage * damage_multiplier;
                return damage_mod;
            }
        }
    }
    return -1;
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 1, eflags: 0x4
// Checksum 0x43b3fbb4, Offset: 0x1a70
// Size: 0x5b2
function private gladiatortargetservice(entity) {
    if (isdefined(entity.ignoreall) && entity.ignoreall) {
        return 0;
    }
    /#
        if (isdefined(entity.ispuppet) && entity.ispuppet) {
            return 0;
        }
    #/
    entity zombie_utility::run_ignore_player_handler();
    if (isdefined(entity.var_568f2779) && entity.var_568f2779 && isdefined(entity.favoriteenemy) && !isdefined(zm_zonemgr::function_a5972886(entity.favoriteenemy, entity))) {
        entity.var_568f2779 = 0;
    }
    if (entity.var_ea94c12a == "gladiator_marauder" && !(isdefined(entity.var_568f2779) && entity.var_568f2779)) {
        entity.favoriteenemy = entity.var_532a149b;
    } else if (entity.var_ea94c12a == "gladiator_destroyer") {
        entity.favoriteenemy = entity.var_532a149b;
    }
    if (!isdefined(entity.favoriteenemy) || zm_behavior::zombieshouldmoveawaycondition(entity)) {
        zone = zm_utility::get_current_zone();
        if (isdefined(zone)) {
            wait_locations = level.zones[zone].a_loc_types[#"wait_location"];
            if (isdefined(wait_locations) && wait_locations.size > 0) {
                return zm_utility::function_23a24406(wait_locations[0].origin);
            }
        }
        entity setgoal(entity.origin);
        return 0;
    }
    /#
        if (entity.favoriteenemy isnotarget()) {
            entity setgoal(entity.origin);
            return 0;
        }
    #/
    if (!(isdefined(entity.hasseenfavoriteenemy) && entity.hasseenfavoriteenemy)) {
        if (entity cansee(entity.favoriteenemy) || isdefined(entity.var_d6cf40a6)) {
            entity.var_d6cf40a6 = undefined;
            entity.hasseenfavoriteenemy = 1;
            entity.var_ca22e218 = 1;
            if (entity.var_ea94c12a == "gladiator_destroyer") {
                entity setblackboardattribute("_gladiator_react", "idle");
                if (entity haspath()) {
                    entity setblackboardattribute("_gladiator_react", "walk");
                }
            } else {
                var_229d843a = anglestoforward(entity.angles);
                var_229d843a = (var_229d843a[0], var_229d843a[1], 0);
                gladiator_right = anglestoright(entity.angles);
                gladiator_right = (gladiator_right[0], gladiator_right[1], 0);
                to_enemy = entity.favoriteenemy.origin - entity.origin;
                to_enemy = (to_enemy[0], to_enemy[1], 0);
                dot_forward = vectordot(var_229d843a, to_enemy);
                dot_right = vectordot(gladiator_right, to_enemy);
                if (abs(dot_forward) > abs(dot_right)) {
                    dot = dot_forward;
                    directions = array("front", "back");
                } else {
                    dot = dot_right;
                    directions = array("right", "left");
                }
                if (dot >= 0) {
                    entity setblackboardattribute("_gladiator_react", directions[0]);
                } else {
                    entity setblackboardattribute("_gladiator_react", directions[1]);
                }
            }
            if (entity.var_ea94c12a == "gladiator_marauder") {
                entity ai::set_behavior_attribute("run", 1);
            }
        }
    }
    return entity function_348a9185();
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 1, eflags: 0x4
// Checksum 0x4f2649a0, Offset: 0x2030
// Size: 0x1bc
function private function_a090d398(entity) {
    enemy = entity.favoriteenemy;
    /#
        if (isdefined(entity.var_dd277f9b)) {
            return false;
        }
    #/
    if (entity ai::has_behavior_attribute("run")) {
        if (entity ai::get_behavior_attribute("run")) {
            entity setblackboardattribute("_locomotion_speed", "locomotion_speed_run");
            return true;
        }
    }
    if (!(isdefined(entity.hasseenfavoriteenemy) && entity.hasseenfavoriteenemy)) {
        entity setblackboardattribute("_locomotion_speed", "locomotion_speed_walk");
        return false;
    }
    if (isdefined(enemy) && isalive(enemy)) {
        dist_sq = distancesquared(entity.origin, enemy.origin);
        if (dist_sq > 360000) {
            entity setblackboardattribute("_locomotion_speed", "locomotion_speed_run");
            return true;
        }
        if (dist_sq < 160000) {
            entity setblackboardattribute("_locomotion_speed", "locomotion_speed_walk");
            return true;
        }
    }
    return false;
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 1, eflags: 0x4
// Checksum 0xecfbf1ab, Offset: 0x21f8
// Size: 0x2c
function private function_de6c770b(entity) {
    if (entity.var_ea94c12a == "gladiator_destroyer") {
        return true;
    }
    return false;
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 1, eflags: 0x4
// Checksum 0xa63ee115, Offset: 0x2230
// Size: 0x4a
function private gladiatorpickaxe(entity) {
    if (math::cointoss()) {
        entity.var_e3d4e074 = "left";
        return;
    }
    entity.var_e3d4e074 = "right";
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 0, eflags: 0x4
// Checksum 0x5813ff30, Offset: 0x2288
// Size: 0x16
function private function_a8306aa() {
    self.var_2c4ee575 = gettime() + 3000;
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 0, eflags: 0x4
// Checksum 0x75868763, Offset: 0x22a8
// Size: 0x16
function private function_dac8ed2e() {
    self.next_leap_time = gettime() + 3000;
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 1, eflags: 0x4
// Checksum 0x2e98ed5e, Offset: 0x22c8
// Size: 0x1e6
function private function_d7f10454(entity) {
    if (!entity ai::get_behavior_attribute("axe_throw")) {
        return false;
    }
    if (!isdefined(entity.favoriteenemy)) {
        return false;
    }
    if (entity.var_ea94c12a != "gladiator_destroyer") {
        return false;
    }
    if (!entity.has_left_arm || !entity.has_right_arm) {
        return false;
    }
    if (entity.var_14fc43b7) {
        return false;
    }
    if (gettime() < entity.var_2c4ee575) {
        return false;
    }
    dist_sq = distancesquared(entity.origin, entity.favoriteenemy.origin);
    if (dist_sq < 57600) {
        return false;
    }
    if (dist_sq > 360000) {
        return false;
    }
    yaw = abs(zombie_utility::getyawtoenemy());
    if (yaw > 22.5) {
        return false;
    }
    can_see = bullettracepassed(entity.origin + (0, 0, 36), entity.favoriteenemy.origin + (0, 0, 36), 0, undefined);
    if (!can_see) {
        return false;
    }
    /#
        if (entity.favoriteenemy isnotarget()) {
            return false;
        }
    #/
    return true;
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 1, eflags: 0x4
// Checksum 0xaea4b0e3, Offset: 0x24b8
// Size: 0x28
function private function_293e5948(entity) {
    if (self.var_e3d4e074 === "left") {
        return true;
    }
    return false;
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 1, eflags: 0x4
// Checksum 0xdeae2d02, Offset: 0x24e8
// Size: 0x28
function private function_7c59ac0d(entity) {
    if (self.var_e3d4e074 === "right") {
        return true;
    }
    return false;
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 1, eflags: 0x4
// Checksum 0x3cddb74a, Offset: 0x2518
// Size: 0x40
function private function_953b6aa3(entity) {
    if (self.var_e3d4e074 === "left") {
        if (isdefined(self.var_df88e01b) && self.var_df88e01b) {
            return true;
        }
    }
    return false;
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 1, eflags: 0x4
// Checksum 0x78bf509e, Offset: 0x2560
// Size: 0x40
function private function_37cec80c(entity) {
    if (self.var_e3d4e074 === "right") {
        if (isdefined(self.var_df88e01b) && self.var_df88e01b) {
            return true;
        }
    }
    return false;
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 1, eflags: 0x0
// Checksum 0x6cfb1750, Offset: 0x25a8
// Size: 0x1d2
function function_ac3d6ce8(entity) {
    if (entity.ignoreall) {
        return false;
    }
    if (!isdefined(entity.favoriteenemy)) {
        return false;
    }
    if (!self.has_left_arm || !self.has_right_arm) {
        return false;
    }
    var_674d567a = 128 * 128;
    if (self.var_ea94c12a == "gladiator_marauder") {
        var_674d567a = 240 * 240;
        if (gettime() < entity.next_leap_time) {
            return false;
        }
        z_diff = abs(entity.origin[2] - entity.favoriteenemy.origin[2]);
        if (z_diff > 72) {
            return false;
        }
    }
    if (!(isdefined(level.intermission) && level.intermission)) {
        if (distancesquared(entity.origin, entity.favoriteenemy.origin) > var_674d567a) {
            return false;
        }
    }
    yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(entity.favoriteenemy.origin - entity.origin)[1]);
    if (abs(yawtoenemy) > 60) {
        return false;
    }
    return true;
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 1, eflags: 0x0
// Checksum 0xc16ca1e9, Offset: 0x2788
// Size: 0x1b2
function function_b19d727c(entity) {
    if (entity.ignoreall) {
        return false;
    }
    if (!isdefined(entity.favoriteenemy)) {
        return false;
    }
    if (self.var_ea94c12a != "gladiator_destroyer") {
        return false;
    }
    if (self.has_left_arm && self.has_right_arm) {
        return false;
    }
    var_e3f35002 = lengthsquared(entity.favoriteenemy getvelocity());
    var_674d567a = 100 * 100;
    if (var_e3f35002 < 175 * 175) {
        var_674d567a = 190 * 190;
    }
    if (!(isdefined(level.intermission) && level.intermission)) {
        if (distancesquared(entity.origin, entity.favoriteenemy.origin) > var_674d567a) {
            return false;
        }
    }
    yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(entity.favoriteenemy.origin - entity.origin)[1]);
    if (abs(yawtoenemy) > 60) {
        return false;
    }
    return true;
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 1, eflags: 0x4
// Checksum 0x4b7e08dd, Offset: 0x2948
// Size: 0x2c
function private function_4e44c1d4(entity) {
    entity pathmode("dont move", 1);
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 1, eflags: 0x4
// Checksum 0x92d363b4, Offset: 0x2980
// Size: 0x2c
function private function_ad450e9f(entity) {
    entity pathmode("move allowed");
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 1, eflags: 0x4
// Checksum 0x6fd740e0, Offset: 0x29b8
// Size: 0x34
function private function_bc378f53(entity) {
    if (isdefined(entity.knockdown) && entity.knockdown) {
        return false;
    }
    return true;
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 1, eflags: 0x4
// Checksum 0x5a91649d, Offset: 0x29f8
// Size: 0x34
function private function_5d3f0d94(entity) {
    if (isdefined(entity.var_b273cad8) && entity.var_b273cad8) {
        return true;
    }
    return false;
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 1, eflags: 0x4
// Checksum 0x129fbf87, Offset: 0x2a38
// Size: 0x50
function private function_2eca5971(entity) {
    locomotionspeed = entity getblackboardattribute("_locomotion_speed");
    if (locomotionspeed === "locomotion_speed_run") {
        return true;
    }
    return false;
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 1, eflags: 0x4
// Checksum 0x9f8ff62b, Offset: 0x2a90
// Size: 0x58
function private function_75c7c35e(entity) {
    if (entity getblackboardattribute("_locomotion_speed") === "locomotion_speed_run" && entity haspath()) {
        return true;
    }
    return false;
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 1, eflags: 0x4
// Checksum 0x4192ffd8, Offset: 0x2af0
// Size: 0x34
function private gladiatorshouldreact(entity) {
    if (isdefined(entity.var_ca22e218) && entity.var_ca22e218) {
        return true;
    }
    return false;
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 1, eflags: 0x4
// Checksum 0x4dcb2498, Offset: 0x2b30
// Size: 0x24
function private function_a2386928(entity) {
    entity function_a8306aa();
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 1, eflags: 0x4
// Checksum 0xbd30658, Offset: 0x2b60
// Size: 0x2c
function private function_6727863c(entity) {
    entity.var_df88e01b = 0;
    entity function_a8306aa();
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 1, eflags: 0x4
// Checksum 0x15ecae8c, Offset: 0x2b98
// Size: 0x74
function private function_cbbb856e(entity) {
    if (entity.var_ea94c12a == "gladiator_marauder") {
        entity.var_4d775096 = 1;
        entity.var_67b0a19a = 1;
        entity function_dac8ed2e();
        entity pathmode("dont move", 1);
    }
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 1, eflags: 0x4
// Checksum 0xd48a2891, Offset: 0x2c18
// Size: 0x6c
function private function_855ecfef(entity) {
    if (entity.var_ea94c12a == "gladiator_marauder") {
        entity.var_4d775096 = undefined;
        entity.var_67b0a19a = undefined;
        entity function_dac8ed2e();
        entity pathmode("move allowed");
    }
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 1, eflags: 0x4
// Checksum 0x20d5fc95, Offset: 0x2c90
// Size: 0x42
function private function_4ed41066(entity) {
    if (entity.var_ea94c12a == "gladiator_marauder") {
        entity.var_4d775096 = 1;
        entity.var_67b0a19a = 1;
    }
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 1, eflags: 0x4
// Checksum 0x2c27f1cb, Offset: 0x2ce0
// Size: 0x3a
function private function_9bc27177(entity) {
    if (entity.var_ea94c12a == "gladiator_marauder") {
        entity.var_4d775096 = undefined;
        entity.var_67b0a19a = undefined;
    }
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 1, eflags: 0x4
// Checksum 0x47539803, Offset: 0x2d28
// Size: 0x2c
function private function_4843f735(entity) {
    entity pathmode("dont move", 1);
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 1, eflags: 0x4
// Checksum 0x5398ed9e, Offset: 0x2d60
// Size: 0x34
function private function_70a12476(entity) {
    entity.var_b273cad8 = 0;
    entity pathmode("move allowed");
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 1, eflags: 0x4
// Checksum 0x10e2b164, Offset: 0x2da0
// Size: 0x52
function private function_c691d75b(entity) {
    entity pathmode("dont move", 1);
    if (entity.var_ea94c12a == "gladiator_marauder") {
        entity.var_568f2779 = 1;
    }
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 1, eflags: 0x4
// Checksum 0xbf8f8b27, Offset: 0x2e00
// Size: 0x3a
function private function_be3cb438(entity) {
    entity pathmode("move allowed");
    entity.var_ca22e218 = 0;
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 5, eflags: 0x0
// Checksum 0x6ad13cd3, Offset: 0x2f10
// Size: 0x324
function function_85937c7b(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity animmode("gravity", 1);
    entity orientmode("face angle", entity.angles[1]);
    entity.blockingpain = 1;
    entity.var_4d775096 = 1;
    entity.var_67b0a19a = 1;
    entity.usegoalanimweight = 1;
    entity pathmode("dont move");
    entity collidewithactors(0);
    if (isdefined(entity.enemy)) {
        dirtoenemy = vectornormalize(entity.enemy.origin - entity.origin);
        entity forceteleport(entity.origin, vectortoangles(dirtoenemy));
    }
    if (!isdefined(self.meleeinfo)) {
        self.meleeinfo = new class_36f71b4();
        self.meleeinfo.var_b41f1299 = entity.origin;
        self.meleeinfo.var_14f9d875 = getnotetracktimes(mocompanim, "start_procedural")[0];
        self.meleeinfo.var_4a9e662e = getnotetracktimes(mocompanim, "stop_procedural")[0];
        var_4e4d2dde = getmovedelta(mocompanim, 0, 1, entity);
        self.meleeinfo.var_773d1d97 = entity localtoworldcoords(var_4e4d2dde);
        /#
            movedelta = getmovedelta(mocompanim, 0, 1, entity);
            animendpos = entity localtoworldcoords(movedelta);
            distance = distance(entity.origin, animendpos);
            recordcircle(animendpos, 3, (0, 1, 0), "<dev string:x3a>");
            record3dtext("<dev string:x41>" + distance, animendpos, (0, 1, 0), "<dev string:x3a>");
        #/
    }
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 5, eflags: 0x0
// Checksum 0xe31e8e0, Offset: 0x3240
// Size: 0x914
function function_4ddd346e(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    assert(isdefined(self.meleeinfo));
    currentanimtime = entity getanimtime(mocompanim);
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
        if (var_66728108 <= 20 * 20) {
            /#
                record3dtext("<dev string:x42>", entity.origin + (0, 0, 60), (1, 0, 0), "<dev string:x3a>");
            #/
            self.meleeinfo.var_98b8af1 = 0;
        } else if (var_873d139c <= 90 * 90) {
            /#
                record3dtext("<dev string:x4d>", entity.origin + (0, 0, 60), (1, 0, 0), "<dev string:x3a>");
            #/
            self.meleeinfo.var_98b8af1 = 0;
        } else if (var_873d139c >= 400 * 400) {
            /#
                record3dtext("<dev string:x59>", entity.origin + (0, 0, 60), (1, 0, 0), "<dev string:x3a>");
            #/
            self.meleeinfo.var_98b8af1 = 0;
        }
        if (self.meleeinfo.var_98b8af1) {
            var_66728108 = distancesquared(self.meleeinfo.var_773d1d97, self.meleeinfo.adjustedendpos);
            myforward = anglestoforward(self.angles);
            var_63d012a3 = (entity.enemy.origin[0], entity.enemy.origin[1], entity.origin[2]);
            dirtoenemy = vectornormalize(var_63d012a3 - entity.origin);
            zdiff = self.meleeinfo.var_773d1d97[2] - entity.enemy.origin[2];
            withinzrange = abs(zdiff) <= 45;
            withinfov = vectordot(myforward, dirtoenemy) > cos(30);
            var_4f74dce4 = withinzrange && withinfov;
            isvisible = bullettracepassed(entity.origin, entity.enemy.origin, 0, self);
            var_98b8af1 = isvisible && var_4f74dce4;
            /#
                reasons = "<dev string:x65>" + isvisible + "<dev string:x6a>" + withinzrange + "<dev string:x6e>" + withinfov;
                if (var_98b8af1) {
                    record3dtext(reasons, entity.origin + (0, 0, 60), (0, 1, 0), "<dev string:x3a>");
                } else {
                    record3dtext(reasons, entity.origin + (0, 0, 60), (1, 0, 0), "<dev string:x3a>");
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
            recordsphere(self.meleeinfo.var_773d1d97, 3, (0, 1, 0), "<dev string:x3a>");
            recordsphere(self.meleeinfo.adjustedendpos, 3, (0, 0, 1), "<dev string:x3a>");
        #/
        adjustedorigin = entity.origin + entity.meleeinfo.var_e4382b96 * self.meleeinfo.var_8ae4eb71;
        entity forceteleport(adjustedorigin);
    }
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 5, eflags: 0x0
// Checksum 0x44bb338a, Offset: 0x3b60
// Size: 0xbe
function function_2733358(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity.blockingpain = 0;
    entity.var_4d775096 = undefined;
    entity.var_67b0a19a = undefined;
    entity.usegoalanimweight = 0;
    entity pathmode("move allowed");
    entity orientmode("face default");
    entity collidewithactors(1);
    entity.meleeinfo = undefined;
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 5, eflags: 0x0
// Checksum 0x38ae091f, Offset: 0x3c28
// Size: 0xbc
function function_69fde0a7(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    if (isdefined(entity.favoriteenemy)) {
        to_enemy = vectornormalize(entity.favoriteenemy.origin - entity.origin);
        angles_to_enemy = vectortoangles(to_enemy);
        entity orientmode("face angle", angles_to_enemy[1]);
    }
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 5, eflags: 0x0
// Checksum 0x758af643, Offset: 0x3cf0
// Size: 0xdc
function function_c0af8072(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    if (isdefined(entity.favoriteenemy)) {
        if (!(isdefined(entity.var_14fc43b7) && entity.var_14fc43b7)) {
            to_enemy = vectornormalize(entity.favoriteenemy.origin - entity.origin);
            angles_to_enemy = vectortoangles(to_enemy);
            entity orientmode("face angle", angles_to_enemy[1]);
        }
    }
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 5, eflags: 0x0
// Checksum 0x184d107a, Offset: 0x3dd8
// Size: 0x2c
function function_64beb50c(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 5, eflags: 0x0
// Checksum 0x34684235, Offset: 0x3e10
// Size: 0x6c
function function_e1952f16(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity animmode("normal");
    entity orientmode("face motion");
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 5, eflags: 0x0
// Checksum 0x528f7a10, Offset: 0x3e88
// Size: 0xb4
function function_a3e76fd9(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    if (isdefined(entity.favoriteenemy)) {
        if (distancesquared(entity.origin, entity.favoriteenemy.origin) <= 50 * 50) {
            entity animmode("angle deltas");
            return;
        }
        entity animmode("normal");
    }
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 5, eflags: 0x0
// Checksum 0x73b5f05a, Offset: 0x3f48
// Size: 0x4c
function function_939c0547(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity animmode("normal");
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 1, eflags: 0x4
// Checksum 0x771f5557, Offset: 0x3fa0
// Size: 0xa4
function private function_ba68aabf(entity) {
    hitent = entity melee();
    /#
        record3dtext("<dev string:x74>", self.origin, (1, 0, 0), "<dev string:x7a>", entity);
    #/
    entity.var_568f2779 = 0;
    if (isplayer(hitent)) {
        hitent clientfield::increment_to_player("gladiator_melee_effect");
    }
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 1, eflags: 0x4
// Checksum 0x2646cca1, Offset: 0x4050
// Size: 0x4c
function private function_37d38b77(entity) {
    if (!isdefined(entity.favoriteenemy)) {
        return;
    }
    entity function_ac208c31(0);
    entity function_19f3f683();
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 1, eflags: 0x4
// Checksum 0x77c37fe2, Offset: 0x40a8
// Size: 0x24
function private function_4d0a5289(entity) {
    entity function_ac208c31();
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 1, eflags: 0x4
// Checksum 0xe9198f5e, Offset: 0x40d8
// Size: 0x2cc
function private function_701636ae(entity) {
    var_e3d4e074 = "right";
    hand = "right_hand";
    if (entity.damage_info.hitloc == "left_arm_lower") {
        var_e3d4e074 = "left";
        hand = "left_hand";
    }
    entity destructserverutils::handledamage(entity.damage_info.inflictor, entity.damage_info.attacker, entity.damage_info.damage, entity.damage_info.idflags, entity.damage_info.meansofdeath, entity.damage_info.weapon, entity.damage_info.point, entity.damage_info.dir, entity.damage_info.hitloc, entity.damage_info.offsettime, entity.damage_info.boneindex, entity.damage_info.modelindex);
    if (entity.var_14fc43b7 && entity.var_e3d4e074 == var_e3d4e074) {
        if (isdefined(entity.axe_model)) {
            entity notify(#"arm_destroyed");
            entity.axe_model delete();
        }
        return;
    }
    entity destructserverutils::handledamage(entity.damage_info.inflictor, entity.damage_info.attacker, entity.damage_info.damage, entity.damage_info.idflags, entity.damage_info.meansofdeath, entity.damage_info.weapon, entity.damage_info.point, entity.damage_info.dir, hand, entity.damage_info.offsettime, entity.damage_info.boneindex, entity.damage_info.modelindex);
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 0, eflags: 0x4
// Checksum 0xa6c5e0c8, Offset: 0x43b0
// Size: 0x1f4
function private function_1a99b842() {
    self.b_ignore_cleanup = 1;
    self.instakill_func = &zm_powerups::function_ef67590f;
    self.var_101fcd59 = 1;
    self.cant_move_cb = &zombiebehavior::function_6137e5da;
    self setblackboardattribute("_locomotion_speed", "locomotion_speed_walk");
    self collidewithactors(1);
    if (self.var_ea94c12a == "gladiator_destroyer") {
        self function_2631a895();
    } else if (self.var_ea94c12a == "gladiator_marauder") {
        self function_c464439();
        self.next_leap_time = gettime() + 3000;
    }
    self function_a8306aa();
    self.var_2c4ee575 = gettime() + 3000;
    self.has_left_arm = 1;
    self.has_right_arm = 1;
    self.var_14fc43b7 = 0;
    self.var_8666ebbf = 1;
    self.var_82c786f1 = 1;
    self.ignorepathenemyfightdist = 1;
    self.allowdeath = 1;
    level thread zm_spawner::zombie_death_event(self);
    self thread zm_audio::zmbaivox_notifyconvert();
    self thread zm_audio::play_ambient_zombie_vocals();
    aiutility::addaioverridedamagecallback(self, &function_e2449b0b);
    self callback::on_ai_killed(&function_5f873f9b);
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 12, eflags: 0x4
// Checksum 0x5247c09a, Offset: 0x45b0
// Size: 0xacc
function private function_e2449b0b(inflictor, attacker, damage, idflags, meansofdeath, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
    if (isdefined(attacker) && attacker.team === self.team) {
        return 0;
    }
    if (isdefined(attacker) && !isplayer(attacker)) {
        return 0;
    }
    if (isdefined(attacker) && self.var_ea94c12a == "gladiator_marauder" && !isdefined(self.var_568f2779) && isdefined(zm_zonemgr::function_a5972886(attacker, self))) {
        self.favoriteenemy = attacker;
        self.var_568f2779 = 1;
        self.var_d6cf40a6 = 1;
    }
    var_503b241b = 0;
    if (zm_loadout::is_hero_weapon(weapon)) {
        var_503b241b = 1;
    }
    if (var_503b241b) {
        weakpoints = namespace_9088c704::function_6c1699d5(self);
        foreach (pointinfo in weakpoints) {
            if (namespace_9088c704::function_4abac7be(pointinfo) === 1 && pointinfo.type === #"armor") {
                var_216599c5 = pointinfo;
                var_a2040147 = 1;
                break;
            }
        }
    }
    var_ce4361a0 = zm_ai_utility::function_9094ed69(self, attacker, weapon, boneindex, var_216599c5);
    var_216599c5 = var_ce4361a0.var_b750d1c8;
    var_a2040147 = var_ce4361a0.var_9c192fd2;
    adjusted_damage = int(damage * var_ce4361a0.damage_scale);
    if (var_503b241b) {
        if (!isdefined(self.var_6f687f49) || self.var_6f687f49 >= 1000) {
            self.var_6f687f49 = 0;
        }
        self.var_6f687f49 += adjusted_damage;
    }
    if (isdefined(var_216599c5)) {
        if (isdefined(var_216599c5.var_a1bd2324) && var_216599c5.var_a1bd2324 > 0) {
            adjusted_damage = damage * var_ce4361a0.damage_scale * var_216599c5.var_a1bd2324;
            if (attacker hasperk(#"specialty_mod_awareness")) {
                adjusted_damage *= 1.2;
            }
        }
        adjusted_damage = int(adjusted_damage);
        if (var_a2040147) {
            namespace_9088c704::damageweakpoint(var_216599c5, adjusted_damage);
            /#
                if (getdvarint(#"scr_weakpoint_debug", 0) > 0) {
                    iprintlnbold("<dev string:x81>" + var_216599c5.health);
                }
            #/
            if (namespace_9088c704::function_4abac7be(var_216599c5) === 3 || var_503b241b && self.var_6f687f49 >= 1000) {
                /#
                    if (getdvarint(#"scr_weakpoint_debug", 0) > 0) {
                        iprintlnbold("<dev string:x94>");
                    }
                #/
                var_d50ea813 = 0;
                if (var_216599c5.hitloc == "left_arm_lower" || var_216599c5.hitloc == "right_arm_lower") {
                    var_d50ea813 = 1;
                    self.damage_info = {#inflictor:inflictor, #attacker:attacker, #damage:damage, #idflags:idflags, #meansofdeath:meansofdeath, #weapon:weapon, #point:point, #dir:dir, #hitloc:var_216599c5.hitloc, #offsettime:offsettime, #boneindex:boneindex, #modelindex:modelindex};
                }
                self destructserverutils::handledamage(inflictor, attacker, damage, idflags, meansofdeath, weapon, point, dir, var_216599c5.hitloc, offsettime, boneindex, modelindex);
                if (isdefined(level.var_7f08b6a7) && !var_d50ea813) {
                    self [[ level.var_7f08b6a7 ]](attacker);
                    playsoundatposition(#"hash_10711c56d7aa52d5", self.origin + (0, 0, 30));
                }
                if (var_216599c5.hitloc == "helmet") {
                    var_123f9228 = namespace_9088c704::function_fc6ac723(self, "j_head", 2);
                    namespace_9088c704::function_3ad01c52(var_123f9228, 1);
                    self.var_b273cad8 = 1;
                    self setblackboardattribute("_gladiator_weakpoint", "head");
                } else if (var_216599c5.hitloc == "left_arm_upper") {
                    var_f23a35ca = namespace_9088c704::function_fc6ac723(self, "j_shoulder_le");
                } else if (var_216599c5.hitloc == "right_arm_upper") {
                    var_f23a35ca = namespace_9088c704::function_fc6ac723(self, "j_shoulder_ri");
                } else if (var_216599c5.hitloc == "left_arm_lower") {
                    self.has_left_arm = 0;
                    if (!self.has_right_arm) {
                        if (!(isdefined(self.allowdeath) && self.allowdeath)) {
                            self notify(#"both_arms_destroyed");
                        } else {
                            self kill();
                        }
                    } else {
                        self ai::set_behavior_attribute("run", 1);
                        self setblackboardattribute("_gladiator_arm", "right_arm");
                    }
                    self attach(#"c_t8_zmb_dlc0_zombie_destroyer_larm1_dam");
                    self.var_b273cad8 = 1;
                    self clientfield::set("gladiator_arm_effect", 1);
                    self setblackboardattribute("_gladiator_weakpoint", "left_arm");
                    self ai::set_behavior_attribute("run", 1);
                } else if (var_216599c5.hitloc == "right_arm_lower") {
                    self.has_right_arm = 0;
                    if (!self.has_left_arm) {
                        if (!(isdefined(self.allowdeath) && self.allowdeath)) {
                            self notify(#"both_arms_destroyed");
                        } else {
                            self kill();
                        }
                    } else {
                        self setblackboardattribute("_gladiator_arm", "left_arm");
                    }
                    self attach(#"c_t8_zmb_dlc0_zombie_destroyer_rarm1_dam");
                    self.var_b273cad8 = 1;
                    self clientfield::set("gladiator_arm_effect", 2);
                    self setblackboardattribute("_gladiator_weakpoint", "right_arm");
                    self ai::set_behavior_attribute("run", 1);
                }
                if (isdefined(var_f23a35ca)) {
                    namespace_9088c704::function_3ad01c52(var_f23a35ca, 1);
                }
                if (isdefined(var_216599c5.var_a9732696) && var_216599c5.var_a9732696) {
                    namespace_9088c704::function_305cc7a5(self, var_216599c5);
                }
            }
            if (var_216599c5.type === #"armor" && !var_503b241b) {
                attacker util::show_hit_marker(!isalive(self));
                return 0;
            }
        }
    }
    return adjusted_damage;
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 1, eflags: 0x4
// Checksum 0x2eb0fed2, Offset: 0x5088
// Size: 0xb0
function private function_5f873f9b(s_params) {
    if (self.archetype != "gladiator") {
        return;
    }
    self val::set(#"gladiator_death", "takedamage", 0);
    if (isdefined(self.axe_model)) {
        self.axe_model clientfield::set("gladiator_axe_effect", 0);
        self.axe_model delete();
    }
    if (!isplayer(s_params.eattacker)) {
        return;
    }
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 2, eflags: 0x4
// Checksum 0x16985879, Offset: 0x5140
// Size: 0x6e4
function private function_4805b8e8(var_b23290ee, spin_dir) {
    self endon(#"death");
    self endon(#"arm_destroyed");
    var_a6a3e328 = self gettagorigin(var_b23290ee);
    var_d221f582 = self gettagangles(var_b23290ee);
    invert = 1;
    if (isdefined(spin_dir)) {
        invert *= spin_dir;
    }
    var_d221f582 = (0, self.angles[1], 0);
    axe = util::spawn_model("tag_origin", var_a6a3e328, var_d221f582);
    level notify(#"hash_27a9b4863f38ef7c", {#mdl_axe:axe});
    self.axe_model = axe;
    axe clientfield::set("gladiator_axe_effect", 1);
    /#
        recordent(axe);
    #/
    enemy = self.favoriteenemy;
    var_58471cfa = self.favoriteenemy geteye();
    dist_to_target = distance(var_a6a3e328, var_58471cfa);
    var_948c7b8f = 600;
    interval_dist = var_948c7b8f * 0.1;
    time_to_target = dist_to_target / var_948c7b8f;
    total_dist = 0;
    max_dist = 500;
    var_a0cc31cb = vectornormalize(var_58471cfa - var_a6a3e328);
    axe playloopsound(#"zmb_ai_gladiator_axe_lp");
    var_643a3f3b = undefined;
    var_9842d8c8 = undefined;
    var_45a5bd4f = vectortoangles(var_a0cc31cb);
    while (true) {
        enemy = self.favoriteenemy;
        if (isdefined(enemy) && isplayer(enemy) && enemy issliding() && !(isdefined(var_643a3f3b) && var_643a3f3b)) {
            if (distance2dsquared(enemy.origin, axe.origin) <= 45 * 45) {
                /#
                    recordsphere(enemy.origin, 3, (0, 0, 1), "<dev string:x3a>");
                    var_f50ad1f2 = distance2d(enemy.origin, axe.origin);
                    record3dtext("<dev string:x41>" + var_f50ad1f2, enemy.origin + (0, 0, 60), (0, 0, 1), "<dev string:x3a>");
                #/
                var_643a3f3b = 1;
            }
        }
        move_pos = axe.origin + var_a0cc31cb * interval_dist;
        if (isdefined(var_643a3f3b) && var_643a3f3b && !isdefined(var_9842d8c8)) {
            if (isdefined(enemy)) {
                if (distance2dsquared(enemy.origin, move_pos) > 45 * 45) {
                    /#
                        recordsphere(enemy.origin, 3, (0, 1, 0), "<dev string:x3a>");
                        var_f50ad1f2 = distance2d(enemy.origin, move_pos);
                        record3dtext("<dev string:x41>" + var_f50ad1f2, enemy.origin + (0, 0, 60), (0, 1, 0), "<dev string:x3a>");
                    #/
                    var_9842d8c8 = 1;
                } else if (!enemy issliding()) {
                    /#
                        recordsphere(enemy.origin, 3, (1, 0, 0), "<dev string:x3a>");
                        record3dtext("<dev string:xa8>", enemy.origin + (0, 0, 60), (1, 0, 0), "<dev string:x3a>");
                    #/
                    var_9842d8c8 = 0;
                }
            }
        } else if (self function_b048bd38(axe, var_a0cc31cb, move_pos)) {
            break;
        }
        axe moveto(move_pos, 0.1);
        wait 0.1;
        total_dist += interval_dist;
        if (total_dist >= max_dist) {
            break;
        }
        if (isdefined(enemy)) {
            enemy_eye_pos = enemy geteye();
            var_edda277 = vectornormalize(enemy_eye_pos - var_a6a3e328);
            vm_zom_raygun_mk2_first_raise = vectortoangles(var_edda277);
            yaw_diff = abs(angleclamp180(var_45a5bd4f[1] - vm_zom_raygun_mk2_first_raise[1]));
            if (yaw_diff <= 10) {
                var_a0cc31cb = vectornormalize(enemy_eye_pos - axe.origin);
            }
        }
    }
    self function_5ec8e99e(axe, var_b23290ee, spin_dir);
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 1, eflags: 0x0
// Checksum 0xd0aaf01c, Offset: 0x5830
// Size: 0x76
function function_cf5e67a3(spin_dir = 1) {
    self endon(#"death");
    while (true) {
        spin_rate = 0.2;
        self rotateyaw(360 * spin_dir, spin_rate);
        wait spin_rate;
    }
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 3, eflags: 0x4
// Checksum 0x70490aab, Offset: 0x58b0
// Size: 0x330
function private function_b048bd38(axe, var_a0cc31cb, move_pos) {
    trace = physicstrace(axe.origin, move_pos, (-16, -16, -12), (16, 16, 12), self);
    if (trace[#"fraction"] < 1) {
        hit_ent = trace[#"entity"];
        level notify(#"hash_435816ec8f13c19b", {#var_d6e9b4c3:trace, #ai_gladiator:self, #mdl_axe:axe, #hit_ent:hit_ent});
        if (isdefined(hit_ent)) {
            if (isplayer(hit_ent)) {
                if (isdefined(hit_ent.hasriotshield) && hit_ent.hasriotshield) {
                    if (isdefined(hit_ent.hasriotshieldequipped) && hit_ent.hasriotshieldequipped) {
                        if (hit_ent hasperk(#"specialty_shield") || hit_ent zm_utility::is_facing(axe, 0.2)) {
                            return true;
                        }
                    } else if (!isdefined(hit_ent.riotshieldentity)) {
                        if (!hit_ent zm_utility::is_facing(axe, -0.2)) {
                            return true;
                        }
                    }
                }
                hit_ent dodamage(50, axe.origin);
                hit_ent playsoundtoplayer(#"evt_player_swiped", hit_ent);
                return true;
            } else if (isai(hit_ent)) {
                if (hit_ent.archetype === "zombie") {
                    if (isalive(hit_ent) && !(isdefined(hit_ent.magic_bullet_shield) && hit_ent.magic_bullet_shield) && !zm_utility::is_magic_bullet_shield_enabled(hit_ent)) {
                        gibserverutils::gibhead(hit_ent);
                        hit_ent zm_cleanup::function_9d243698();
                        hit_ent kill();
                        bhtnactionstartevent(hit_ent, "attack_melee_notetrack");
                    }
                }
            }
        } else {
            return true;
        }
    }
    return false;
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 3, eflags: 0x4
// Checksum 0x3b1b87b, Offset: 0x5be8
// Size: 0xd6
function private function_286d58f1(axe, var_b23290ee, var_948c7b8f) {
    self endon(#"death");
    axe endon(#"death");
    while (true) {
        tag_pos = self gettagorigin(var_b23290ee);
        dist = distance(axe.origin, tag_pos);
        time = dist / var_948c7b8f;
        if (time < 0.7) {
            break;
        }
        waitframe(1);
    }
    self.var_df88e01b = 1;
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 3, eflags: 0x4
// Checksum 0xdf7f244c, Offset: 0x5cc8
// Size: 0x2ce
function private function_5ec8e99e(axe, var_b23290ee, spin_dir) {
    tag_pos = self gettagorigin(var_b23290ee);
    tag_ang = self gettagangles(var_b23290ee);
    var_2cf7605e = distance(axe.origin, tag_pos);
    var_948c7b8f = 1200;
    interval_dist = var_948c7b8f * 0.1;
    var_15095d64 = interval_dist * interval_dist;
    total_dist = 0;
    max_dist = 500;
    var_a0cc31cb = vectornormalize(tag_pos - axe.origin);
    new_yaw = absangleclamp360(axe.angles[1] + 180);
    axe.angles = (0, new_yaw, 0);
    self thread function_286d58f1(axe, var_b23290ee, var_948c7b8f);
    while (true) {
        tag_pos = self gettagorigin(var_b23290ee);
        var_a0cc31cb = vectornormalize(tag_pos - axe.origin);
        move_pos = axe.origin + var_a0cc31cb * interval_dist;
        self function_b048bd38(axe, var_a0cc31cb, move_pos);
        axe moveto(move_pos, 0.1);
        wait 0.1;
        var_b0bcbce5 = distancesquared(axe.origin, tag_pos);
        if (var_b0bcbce5 < var_15095d64) {
            break;
        }
    }
    axe clientfield::set("gladiator_axe_effect", 0);
    axe delete();
    self function_ac208c31();
    self.var_14fc43b7 = 0;
    self.axe_model = undefined;
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 0, eflags: 0x0
// Checksum 0xad9db16a, Offset: 0x5fa0
// Size: 0x136
function function_2631a895() {
    self attach("c_t8_zmb_dlc0_zombie_destroyer_le_arm1", "j_shoulder_le");
    self attach("c_t8_zmb_dlc0_zombie_destroyer_ri_arm1", "j_clavicle_ri");
    self attach("c_t8_zmb_dlc0_zombie_destroyer_helmet1", "j_head");
    self attach("c_t8_zmb_dlc0_zombie_destroyer_le_pauldron1", "tag_pauldron_le");
    self attach("c_t8_zmb_dlc0_zombie_destroyer_ri_pauldron1", "tag_pauldron_ri");
    self attach("c_t8_zmb_dlc0_zombie_destroyer_axe1", "tag_weapon_right");
    self attach("c_t8_zmb_dlc0_zombie_destroyer_axe1", "tag_weapon_left");
    self.var_7a8c9af2 = 1;
    self.var_3d795b5f = 1;
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 0, eflags: 0x0
// Checksum 0x86c708d0, Offset: 0x60e0
// Size: 0x24
function function_c464439() {
    self attach("c_t8_zmb_dlc0_zombie_marauder_helmet1");
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 1, eflags: 0x4
// Checksum 0x32a6a74e, Offset: 0x6110
// Size: 0x1be
function private function_ac208c31(display = 1) {
    if (self.var_e3d4e074 === "left") {
        if (display) {
            self attach("c_t8_zmb_dlc0_zombie_destroyer_axe1", "tag_weapon_left");
            self.var_3d795b5f = 1;
        } else if (isdefined(self.var_3d795b5f) && self.var_3d795b5f) {
            self detach("c_t8_zmb_dlc0_zombie_destroyer_axe1", "tag_weapon_left");
            self.var_3d795b5f = 0;
        }
        return;
    }
    if (display) {
        if (self.has_left_arm && self.var_3d795b5f) {
            self detach("c_t8_zmb_dlc0_zombie_destroyer_axe1", "tag_weapon_left");
            self.var_3d795b5f = 0;
        }
        self attach("c_t8_zmb_dlc0_zombie_destroyer_axe1", "tag_weapon_right");
        self.var_7a8c9af2 = 1;
        if (self.has_left_arm) {
            self attach("c_t8_zmb_dlc0_zombie_destroyer_axe1", "tag_weapon_left");
            self.var_3d795b5f = 1;
        }
        return;
    }
    if (self.var_7a8c9af2) {
        self detach("c_t8_zmb_dlc0_zombie_destroyer_axe1", "tag_weapon_right");
        self.var_7a8c9af2 = 0;
    }
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 0, eflags: 0x4
// Checksum 0x4a6e7531, Offset: 0x62d8
// Size: 0x6c
function private function_19f3f683() {
    self.var_14fc43b7 = 1;
    if (self.var_e3d4e074 === "left") {
        self thread function_4805b8e8("tag_weapon_left", -1);
        return;
    }
    self thread function_4805b8e8("tag_weapon_right");
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 1, eflags: 0x0
// Checksum 0x869cef45, Offset: 0x6350
// Size: 0x1a
function function_7f08b6a7(func) {
    level.var_7f08b6a7 = func;
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 0, eflags: 0x0
// Checksum 0xa406d6f6, Offset: 0x6378
// Size: 0x8e
function function_ef7ccbd4() {
    if (isdefined(self.favoriteenemy)) {
        predictedpos = self lastknownpos(self.favoriteenemy);
        if (isdefined(predictedpos)) {
            turnyaw = absangleclamp360(self.angles[1] - vectortoangles(predictedpos - self.origin)[1]);
            return turnyaw;
        }
    }
    return undefined;
}

// Namespace zm_ai_gladiator/zm_ai_gladiator
// Params 0, eflags: 0x0
// Checksum 0xff977bf0, Offset: 0x6410
// Size: 0x96e
function function_348a9185() {
    shouldrepath = 0;
    zigzag_activation_distance = level.zigzag_activation_distance;
    if (isdefined(self.zigzag_activation_distance)) {
        zigzag_activation_distance = self.zigzag_activation_distance;
    }
    if (!shouldrepath && isdefined(self.favoriteenemy)) {
        pathgoalpos = self.pathgoalpos;
        if (!isdefined(self.nextgoalupdate) || self.nextgoalupdate <= gettime()) {
            shouldrepath = 1;
        } else if (distancesquared(self.origin, self.favoriteenemy.origin) <= zigzag_activation_distance * zigzag_activation_distance) {
            shouldrepath = 1;
        } else if (isdefined(pathgoalpos)) {
            distancetogoalsqr = distancesquared(self.origin, pathgoalpos);
            shouldrepath = distancetogoalsqr < 72 * 72;
        }
    }
    if (isdefined(level.validate_on_navmesh) && level.validate_on_navmesh) {
        if (!ispointonnavmesh(self.origin, self)) {
            shouldrepath = 0;
        }
    }
    if (isdefined(self.keep_moving) && self.keep_moving) {
        if (gettime() > self.keep_moving_time) {
            self.keep_moving = 0;
        }
    }
    if (self function_482b72a()) {
        shouldrepath = 0;
    }
    if (shouldrepath) {
        if (isplayer(self.favoriteenemy)) {
            goalent = zm_ai_utility::function_93d978d(self, self.favoriteenemy);
            if (isdefined(goalent.last_valid_position)) {
                goalpos = getclosestpointonnavmesh(goalent.last_valid_position, 64, self getpathfindingradius());
                if (!isdefined(goalpos)) {
                    goalpos = goalent.origin;
                }
            } else {
                goalpos = goalent.origin;
            }
        } else {
            goalpos = getclosestpointonnavmesh(self.favoriteenemy.origin, 64, self getpathfindingradius());
            if (!isdefined(goalpos) && self.favoriteenemy function_482b72a() && isdefined(self.favoriteenemy.traversestartnode)) {
                goalpos = self.favoriteenemy.traversestartnode.origin;
            }
            if (!isdefined(goalpos)) {
                goalpos = self.origin;
            }
        }
        self zm_utility::function_23a24406(goalpos);
        should_zigzag = 1;
        if (isdefined(level.should_zigzag)) {
            should_zigzag = self [[ level.should_zigzag ]]();
        } else if (isdefined(self.should_zigzag)) {
            should_zigzag = self.should_zigzag;
        }
        if (isdefined(self.var_bf3d3b68)) {
            should_zigzag = should_zigzag && self.var_bf3d3b68;
        }
        var_35f2180f = 0;
        if (isdefined(level.do_randomized_zigzag_path) && level.do_randomized_zigzag_path && should_zigzag) {
            if (distancesquared(self.origin, goalpos) > zigzag_activation_distance * zigzag_activation_distance) {
                self.keep_moving = 1;
                self.keep_moving_time = gettime() + 250;
                path = self calcapproximatepathtoposition(goalpos, 0);
                /#
                    if (getdvarint(#"ai_debugzigzag", 0)) {
                        for (index = 1; index < path.size; index++) {
                            recordline(path[index - 1], path[index], (1, 0.5, 0), "<dev string:xaf>", self);
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
                    if (isdefined(level.var_d04cc94c) && abs(path[index - 1][2] - path[index][2]) > level.var_d04cc94c) {
                        break;
                    }
                    currentseglength = distance(path[index - 1], path[index]);
                    var_e6778ae0 = segmentlength + currentseglength > deviationdistance;
                    if (index == path.size - 1 && !var_e6778ae0) {
                        deviationdistance = segmentlength + currentseglength - 1;
                        var_35f2180f = 1;
                    }
                    if (var_e6778ae0 || var_35f2180f) {
                        remaininglength = deviationdistance - segmentlength;
                        seedposition = path[index - 1] + vectornormalize(path[index] - path[index - 1]) * remaininglength;
                        /#
                            recordcircle(seedposition, 2, (1, 0.5, 0), "<dev string:xaf>", self);
                        #/
                        innerzigzagradius = level.inner_zigzag_radius;
                        if (var_35f2180f) {
                            innerzigzagradius = 16;
                        } else if (isdefined(self.inner_zigzag_radius)) {
                            innerzigzagradius = self.inner_zigzag_radius;
                        }
                        outerzigzagradius = level.outer_zigzag_radius;
                        if (var_35f2180f) {
                            outerzigzagradius = 48;
                        } else if (isdefined(self.outer_zigzag_radius)) {
                            outerzigzagradius = self.outer_zigzag_radius;
                        }
                        queryresult = positionquery_source_navigation(seedposition, innerzigzagradius, outerzigzagradius, 36, 16, self, 16);
                        positionquery_filter_inclaimedlocation(queryresult, self);
                        if (queryresult.data.size > 0) {
                            a_data = array::randomize(queryresult.data);
                            for (i = 0; i < a_data.size; i++) {
                                point = a_data[i];
                                n_z_diff = seedposition[2] - point.origin[2];
                                if (abs(n_z_diff) < 32) {
                                    self zm_utility::function_23a24406(point.origin);
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
        self.nextgoalupdate = gettime() + randomintrange(500, 1000);
        return true;
    }
    return false;
}

/#

    // Namespace zm_ai_gladiator/zm_ai_gladiator
    // Params 0, eflags: 0x4
    // Checksum 0xf2c81d8f, Offset: 0x6d88
    // Size: 0x348
    function private function_16d54b7b() {
        adddebugcommand("<dev string:xba>");
        adddebugcommand("<dev string:x113>");
        adddebugcommand("<dev string:x16e>");
        adddebugcommand("<dev string:x1b7>");
        while (true) {
            waitframe(1);
            string = getdvarstring(#"hash_1a45d40a78c47d72", "<dev string:x41>");
            cmd = strtok(string, "<dev string:x206>");
            gladiators = getaiarchetypearray("<dev string:x30>");
            if (cmd.size > 0) {
                switch (cmd[0]) {
                case #"spawn_marauder":
                    zm_devgui::spawn_archetype("<dev string:x208>");
                    break;
                case #"spawn_destroyer":
                    zm_devgui::spawn_archetype("<dev string:x22a>");
                    break;
                case #"kill":
                    zm_devgui::kill_archetype("<dev string:x30>");
                    break;
                case #"spread":
                    if (getdvarint(#"ai_debugzigzag", 0)) {
                        setdvar(#"ai_debugzigzag", 0);
                    } else {
                        setdvar(#"ai_debugzigzag", 1);
                    }
                    break;
                case #"attach_left":
                    break;
                case #"detach_left":
                    gladiators[0] hidepart("<dev string:x24d>", "<dev string:x25d>", 1);
                    name = getpartname(gladiators[0], 83);
                    break;
                case #"attach_right":
                    break;
                case #"detach_right":
                    gladiators[0] hidepart("<dev string:x282>", "<dev string:x25d>", 1);
                    break;
                default:
                    break;
                }
            }
            setdvar(#"hash_1a45d40a78c47d72", "<dev string:x41>");
        }
    }

#/
