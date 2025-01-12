#using scripts/core_common/ai/archetype_mannequin_interface;
#using scripts/core_common/ai/systems/ai_interface;
#using scripts/core_common/ai/systems/behavior_tree_utility;
#using scripts/core_common/ai/zombie;
#using scripts/core_common/ai/zombie_utility;
#using scripts/core_common/spawner_shared;

#namespace mannequinbehavior;

// Namespace mannequinbehavior/archetype_mannequin
// Params 0, eflags: 0x2
// Checksum 0xf581eca9, Offset: 0x1f0
// Size: 0x2ac
function autoexec init() {
    level.zm_variant_type_max = [];
    level.zm_variant_type_max["walk"] = [];
    level.zm_variant_type_max["run"] = [];
    level.zm_variant_type_max["sprint"] = [];
    level.zm_variant_type_max["walk"]["down"] = 14;
    level.zm_variant_type_max["walk"]["up"] = 16;
    level.zm_variant_type_max["run"]["down"] = 13;
    level.zm_variant_type_max["run"]["up"] = 12;
    level.zm_variant_type_max["sprint"]["down"] = 7;
    level.zm_variant_type_max["sprint"]["up"] = 6;
    spawner::add_archetype_spawn_function("mannequin", &zombiebehavior::archetypezombieblackboardinit);
    spawner::add_archetype_spawn_function("mannequin", &zombiebehavior::archetypezombiedeathoverrideinit);
    spawner::add_archetype_spawn_function("mannequin", &zombie_utility::zombiespawnsetup);
    spawner::add_archetype_spawn_function("mannequin", &mannequinspawnsetup);
    mannequininterface::registermannequininterfaceattributes();
    /#
        assert(isscriptfunctionptr(&mannequincollisionservice));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("mannequinCollisionService", &mannequincollisionservice);
    /#
        assert(isscriptfunctionptr(&mannequinshouldmelee));
    #/
    behaviortreenetworkutility::registerbehaviortreescriptapi("mannequinShouldMelee", &mannequinshouldmelee);
}

// Namespace mannequinbehavior/archetype_mannequin
// Params 1, eflags: 0x0
// Checksum 0xed7d57cd, Offset: 0x4a8
// Size: 0x9c
function mannequincollisionservice(entity) {
    if (isdefined(entity.enemy) && distancesquared(entity.origin, entity.enemy.origin) > 300 * 300) {
        entity collidewithactors(0);
        return;
    }
    entity collidewithactors(1);
}

// Namespace mannequinbehavior/archetype_mannequin
// Params 1, eflags: 0x0
// Checksum 0xab48538d, Offset: 0x550
// Size: 0xc
function mannequinspawnsetup(entity) {
    
}

// Namespace mannequinbehavior/archetype_mannequin
// Params 1, eflags: 0x4
// Checksum 0xd4d4fe72, Offset: 0x568
// Size: 0x18c
function private mannequinshouldmelee(entity) {
    if (!isdefined(entity.enemy)) {
        return false;
    }
    if (isdefined(entity.marked_for_death)) {
        return false;
    }
    if (isdefined(entity.ignoremelee) && entity.ignoremelee) {
        return false;
    }
    if (distance2dsquared(entity.origin, entity.enemy.origin) > 64 * 64) {
        return false;
    }
    if (abs(entity.origin[2] - entity.enemy.origin[2]) > 72) {
        return false;
    }
    yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(entity.enemy.origin - entity.origin)[1]);
    if (abs(yawtoenemy) > 45) {
        return false;
    }
    return true;
}

