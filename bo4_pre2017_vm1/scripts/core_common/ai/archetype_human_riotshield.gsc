#using scripts/core_common/ai/archetype_cover_utility;
#using scripts/core_common/ai/archetype_human_riotshield_interface;
#using scripts/core_common/ai/archetype_locomotion_utility;
#using scripts/core_common/ai/archetype_mocomps_utility;
#using scripts/core_common/ai/archetype_utility;
#using scripts/core_common/ai/systems/ai_interface;
#using scripts/core_common/ai/systems/animation_state_machine_mocomp;
#using scripts/core_common/ai/systems/animation_state_machine_utility;
#using scripts/core_common/ai/systems/behavior_tree_utility;
#using scripts/core_common/ai/systems/blackboard;
#using scripts/core_common/ai/systems/debug;
#using scripts/core_common/ai/systems/gib;
#using scripts/core_common/ai/systems/shared;
#using scripts/core_common/ai/zombie_utility;
#using scripts/core_common/ai_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/spawner_shared;

#namespace archetype_human_riotshield;

// Namespace archetype_human_riotshield/archetype_human_riotshield
// Params 0, eflags: 0x2
// Checksum 0x3d40091, Offset: 0x5b8
// Size: 0x74
function autoexec main() {
    spawner::add_archetype_spawn_function("human_riotshield", &namespace_6e11afc3::function_bd56fc7d);
    spawner::add_archetype_spawn_function("human_riotshield", &namespace_4cdbfe2b::function_6cd135fd);
    namespace_6e11afc3::registerbehaviorscriptfunctions();
    namespace_cbd97d62::function_8f5cbafa();
}

#namespace namespace_6e11afc3;

// Namespace namespace_6e11afc3/archetype_human_riotshield
// Params 0, eflags: 0x0
// Checksum 0xeb6669bf, Offset: 0x638
// Size: 0x3c4
function registerbehaviorscriptfunctions() {
    assert(isscriptfunctionptr(&riotshieldShouldTacticalWalk));
    behaviortreenetworkutility::registerbehaviortreescriptapi("riotshieldShouldTacticalWalk", &riotshieldShouldTacticalWalk);
    assert(isscriptfunctionptr(&riotshieldNonCombatLocomotionCondition));
    behaviortreenetworkutility::registerbehaviortreescriptapi("riotshieldNonCombatLocomotionCondition", &riotshieldNonCombatLocomotionCondition);
    assert(isscriptfunctionptr(&function_6bf49b30));
    behaviortreenetworkutility::registerbehaviortreescriptapi("unarmedWalkAction", &function_6bf49b30);
    assert(isscriptfunctionptr(&riotshieldTacticalWalkStart));
    behaviortreenetworkutility::registerbehaviortreescriptapi("riotshieldTacticalWalkStart", &riotshieldTacticalWalkStart);
    assert(isscriptfunctionptr(&riotshieldAdvanceOnEnemyService));
    behaviortreenetworkutility::registerbehaviortreescriptapi("riotshieldAdvanceOnEnemyService", &riotshieldAdvanceOnEnemyService);
    assert(isscriptfunctionptr(&riotshieldShouldFlinch));
    behaviortreenetworkutility::registerbehaviortreescriptapi("riotshieldShouldFlinch", &riotshieldShouldFlinch);
    assert(isscriptfunctionptr(&riotshieldIncrementFlinchCount));
    behaviortreenetworkutility::registerbehaviortreescriptapi("riotshieldIncrementFlinchCount", &riotshieldIncrementFlinchCount);
    assert(isscriptfunctionptr(&riotshieldClearFlinchCount));
    behaviortreenetworkutility::registerbehaviortreescriptapi("riotshieldClearFlinchCount", &riotshieldClearFlinchCount);
    assert(isscriptfunctionptr(&riotshieldUnarmedTargetService));
    behaviortreenetworkutility::registerbehaviortreescriptapi("riotshieldUnarmedTargetService", &riotshieldUnarmedTargetService);
    assert(isscriptfunctionptr(&riotshieldUnarmedAdvanceOnEnemyService));
    behaviortreenetworkutility::registerbehaviortreescriptapi("riotshieldUnarmedAdvanceOnEnemyService", &riotshieldUnarmedAdvanceOnEnemyService);
}

// Namespace namespace_6e11afc3/archetype_human_riotshield
// Params 0, eflags: 0x4
// Checksum 0x754e262e, Offset: 0xa08
// Size: 0x5c
function private function_bd56fc7d() {
    entity = self;
    blackboard::createblackboardforentity(entity);
    ai::createinterfaceforentity(entity);
    self.___archetypeonanimscriptedcallback = &function_b589481b;
}

// Namespace namespace_6e11afc3/archetype_human_riotshield
// Params 1, eflags: 0x4
// Checksum 0x87f778c1, Offset: 0xa70
// Size: 0x34
function private function_b589481b(entity) {
    entity.__blackboard = undefined;
    entity function_bd56fc7d();
}

// Namespace namespace_6e11afc3/archetype_human_riotshield
// Params 0, eflags: 0x4
// Checksum 0xa770066e, Offset: 0xab0
// Size: 0x46
function private function_ef5bd70a() {
    entity = self;
    if (entity ai::get_behavior_attribute("phalanx")) {
        return "marching";
    }
    return "normal";
}

// Namespace namespace_6e11afc3/archetype_human_riotshield
// Params 1, eflags: 0x4
// Checksum 0x30b9596, Offset: 0xb00
// Size: 0xc4
function private riotshieldShouldFlinch(entity) {
    if (entity haspath() && entity ai::get_behavior_attribute("phalanx")) {
        return true;
    }
    if (entity.damagelocation != "riotshield") {
        return false;
    }
    if (entity.damagelocation == "riotshield" && entity.var_33646074 >= 5 && entity.var_b6532634 + 1500 >= gettime()) {
        return false;
    }
    return true;
}

// Namespace namespace_6e11afc3/archetype_human_riotshield
// Params 1, eflags: 0x4
// Checksum 0x26da216f, Offset: 0xbd0
// Size: 0x2c
function private riotshieldIncrementFlinchCount(entity) {
    entity.var_33646074++;
    entity.var_b6532634 = gettime();
}

// Namespace namespace_6e11afc3/archetype_human_riotshield
// Params 1, eflags: 0x4
// Checksum 0x9235cdf9, Offset: 0xc08
// Size: 0x2c
function private riotshieldClearFlinchCount(entity) {
    entity.var_b6532634 = gettime();
    entity.var_33646074 = 0;
}

// Namespace namespace_6e11afc3/archetype_human_riotshield
// Params 1, eflags: 0x4
// Checksum 0x1faa0bfd, Offset: 0xc40
// Size: 0x10
function private riotshieldShouldTacticalWalk(behaviortreeentity) {
    return true;
}

// Namespace namespace_6e11afc3/archetype_human_riotshield
// Params 1, eflags: 0x4
// Checksum 0xb89be726, Offset: 0xc58
// Size: 0x70
function private riotshieldNonCombatLocomotionCondition(behaviortreeentity) {
    if (isdefined(behaviortreeentity.enemy)) {
        if (distancesquared(behaviortreeentity.origin, behaviortreeentity lastknownpos(behaviortreeentity.enemy)) > 490000) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_6e11afc3/archetype_human_riotshield
// Params 1, eflags: 0x4
// Checksum 0x8234414a, Offset: 0xcd0
// Size: 0x38e
function private riotshieldAdvanceOnEnemyService(behaviortreeentity) {
    itsbeenawhile = gettime() > behaviortreeentity.nextfindbestcovertime;
    isatscriptgoal = behaviortreeentity isatgoal();
    var_89889720 = 0;
    if (behaviortreeentity ai::get_behavior_attribute("phalanx")) {
        return false;
    }
    if (isdefined(behaviortreeentity.var_3100f1e7)) {
        dist_sq = distancesquared(behaviortreeentity.origin, behaviortreeentity.var_3100f1e7.origin);
        if (dist_sq < 256) {
            if (!isdefined(behaviortreeentity.var_15f999a3)) {
                behaviortreeentity.var_15f999a3 = gettime();
            }
        }
    }
    if (isdefined(behaviortreeentity.var_15f999a3)) {
        if (gettime() - behaviortreeentity.var_15f999a3 > behaviortreeentity.var_30eff5f9) {
            var_89889720 = 1;
            behaviortreeentity.var_15f999a3 = undefined;
        }
    }
    shouldlookforbettercover = itsbeenawhile || !isatscriptgoal || var_89889720;
    if (shouldlookforbettercover && isdefined(behaviortreeentity.enemy)) {
        closestrandomnode = undefined;
        var_82379626 = behaviortreeentity findbestcovernodes(behaviortreeentity.goalradius, behaviortreeentity.goalpos);
        foreach (node in var_82379626) {
            if (isdefined(behaviortreeentity.var_3100f1e7) && behaviortreeentity.var_3100f1e7 == node) {
                continue;
            }
            if (aiutility::getcovertype(node) == "cover_exposed") {
                closestrandomnode = node;
                break;
            }
        }
        if (!isdefined(closestrandomnode)) {
            closestrandomnode = var_82379626[0];
        }
        if (isdefined(closestrandomnode) && behaviortreeentity findpath(behaviortreeentity.origin, closestrandomnode.origin, 1, 0)) {
            aiutility::releaseclaimnode(behaviortreeentity);
            aiutility::usecovernodewrapper(behaviortreeentity, closestrandomnode);
            behaviortreeentity.var_3100f1e7 = closestrandomnode;
            behaviortreeentity.var_30eff5f9 = randomintrange(behaviortreeentity.var_5147db9, behaviortreeentity.var_5fba5c47);
            behaviortreeentity.var_15f999a3 = undefined;
            return true;
        }
    }
    return false;
}

// Namespace namespace_6e11afc3/archetype_human_riotshield
// Params 1, eflags: 0x4
// Checksum 0xf79e7c7d, Offset: 0x1068
// Size: 0x84
function private riotshieldTacticalWalkStart(behaviortreeentity) {
    aiutility::resetcoverparameters(behaviortreeentity);
    aiutility::setcanbeflanked(behaviortreeentity, 0);
    behaviortreeentity setblackboardattribute("_stance", "stand");
    behaviortreeentity orientmode("face enemy");
}

// Namespace namespace_6e11afc3/archetype_human_riotshield
// Params 1, eflags: 0x4
// Checksum 0x4bfa2968, Offset: 0x10f8
// Size: 0x31c
function private riotshieldUnarmedTargetService(behaviortreeentity) {
    if (!aiutility::shouldmutexmelee(behaviortreeentity)) {
        return false;
    }
    enemies = [];
    ai = getaiarray();
    foreach (index, value in ai) {
        if (value.team != behaviortreeentity.team && isactor(value)) {
            enemies[enemies.size] = value;
        }
    }
    if (enemies.size > 0) {
        closestenemy = undefined;
        closestenemydistance = 0;
        for (index = 0; index < enemies.size; index++) {
            enemy = enemies[index];
            enemydistance = distancesquared(behaviortreeentity.origin, enemy.origin);
            var_874bdbed = 0;
            if (enemydistance > behaviortreeentity.goalradius * behaviortreeentity.goalradius) {
                continue;
            }
            if (!isdefined(enemy.var_158ff9b3) || enemy.var_158ff9b3 == behaviortreeentity) {
                var_874bdbed = 1;
            } else {
                targetdistance = distancesquared(enemy.var_158ff9b3.origin, enemy.origin);
                if (enemydistance < targetdistance) {
                    var_874bdbed = 1;
                }
            }
            if (var_874bdbed) {
                if (!isdefined(closestenemy) || enemydistance < closestenemydistance) {
                    closestenemydistance = enemydistance;
                    closestenemy = enemy;
                }
            }
        }
        if (isdefined(behaviortreeentity.favoriteenemy)) {
            behaviortreeentity.favoriteenemy.var_158ff9b3 = undefined;
        }
        behaviortreeentity.favoriteenemy = closestenemy;
        if (isdefined(behaviortreeentity.favoriteenemy)) {
            behaviortreeentity.favoriteenemy.var_158ff9b3 = behaviortreeentity;
        }
        return true;
    }
    return false;
}

// Namespace namespace_6e11afc3/archetype_human_riotshield
// Params 1, eflags: 0x4
// Checksum 0x2750db3a, Offset: 0x1420
// Size: 0x13e
function private riotshieldUnarmedAdvanceOnEnemyService(behaviortreeentity) {
    if (gettime() < behaviortreeentity.nextfindbestcovertime) {
        return false;
    }
    if (isdefined(behaviortreeentity.favoriteenemy)) {
        /#
            recordline(behaviortreeentity.favoriteenemy.origin, behaviortreeentity.origin, (1, 0.5, 0), "<dev string:x28>", behaviortreeentity);
        #/
        enemydistance = distancesquared(behaviortreeentity.favoriteenemy.origin, behaviortreeentity.origin);
        if (enemydistance < behaviortreeentity.goalradius * behaviortreeentity.goalradius) {
            behaviortreeentity useposition(behaviortreeentity.favoriteenemy.origin);
            return true;
        }
    }
    behaviortreeentity clearuseposition();
    return false;
}

// Namespace namespace_6e11afc3/archetype_human_riotshield
// Params 1, eflags: 0x4
// Checksum 0xf02195c4, Offset: 0x1568
// Size: 0x54
function private function_6bf49b30(behaviortreeentity) {
    behaviortreeentity setblackboardattribute("_stance", "stand");
    behaviortreeentity orientmode("face enemy");
}

// Namespace namespace_6e11afc3/archetype_human_riotshield
// Params 8, eflags: 0x4
// Checksum 0xa79ec264, Offset: 0x15c8
// Size: 0x70
function private function_f6b6cd67(inflictor, attacker, damage, meansofdeath, weapon, dir, hitloc, offsettime) {
    entity = self;
    aiutility::dropriotshield(entity);
    return damage;
}

// Namespace namespace_6e11afc3/archetype_human_riotshield
// Params 12, eflags: 0x4
// Checksum 0xb8506337, Offset: 0x1640
// Size: 0xf8
function private function_b12197(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex) {
    entity = self;
    if (shitloc == "riotshield") {
        riotshieldIncrementFlinchCount(entity);
        entity.health += 1;
        return 1;
    }
    if (sweapon.name == "incendiary_grenade") {
        idamage = entity.health;
    }
    return idamage;
}

#namespace namespace_4cdbfe2b;

// Namespace namespace_4cdbfe2b/archetype_human_riotshield
// Params 0, eflags: 0x0
// Checksum 0x999b4419, Offset: 0x1740
// Size: 0xe4
function function_6cd135fd() {
    entity = self;
    aiutility::attachriotshield(entity, getweapon("riotshield"), "wpn_t7_shield_riot_world_lh", "tag_weapon_left");
    entity.var_5147db9 = 2500;
    entity.var_5fba5c47 = 5000;
    entity.ignorerunandgundist = 1;
    aiutility::addaioverridedamagecallback(entity, &namespace_6e11afc3::function_b12197);
    aiutility::addaioverridekilledcallback(entity, &namespace_6e11afc3::function_f6b6cd67);
    namespace_6e11afc3::riotshieldClearFlinchCount(entity);
}

