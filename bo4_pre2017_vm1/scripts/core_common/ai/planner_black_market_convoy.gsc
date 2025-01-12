#using scripts/core_common/ai/planner_commander;
#using scripts/core_common/ai/planner_commander_utility;
#using scripts/core_common/ai/planner_generic_commander;
#using scripts/core_common/ai/planner_generic_squad;
#using scripts/core_common/ai/planner_squad_utility;
#using scripts/core_common/ai/systems/blackboard;
#using scripts/core_common/ai/systems/planner;

#namespace namespace_e6f9eb3e;

// Namespace namespace_e6f9eb3e/namespace_6f074cfb
// Params 0, eflags: 0x2
// Checksum 0x1d0a4e28, Offset: 0x300
// Size: 0x2c
function autoexec main() {
    plannercommanderutility::registerdaemonapi("daemonObstructions", &function_df76832b);
}

// Namespace namespace_e6f9eb3e/namespace_6f074cfb
// Params 1, eflags: 0x4
// Checksum 0xcd2472c5, Offset: 0x338
// Size: 0x170
function private _createcommanderplanner(team) {
    planner = planner::createplanner("commanderDataEscape");
    sequence = plannergenericcommander::function_96caab78(planner);
    planner::addgoto(sequence, planner);
    sequence = plannergenericcommander::function_3eac1247(planner);
    planner::addgoto(sequence, planner);
    sequence = plannergenericcommander::function_ec4dcfc2(planner);
    planner::addgoto(sequence, planner);
    sequence = plannergenericcommander::function_9d26171f(planner);
    planner::addgoto(sequence, planner);
    sequence = plannergenericcommander::function_823fd55f(planner);
    planner::addgoto(sequence, planner);
    planner::addaction(planner, "commanderEndPlan");
    return planner;
}

// Namespace namespace_e6f9eb3e/namespace_6f074cfb
// Params 1, eflags: 0x4
// Checksum 0x8110b0ef, Offset: 0x4b0
// Size: 0xb8
function private _createsquadplanner(team) {
    planner = planner::createplanner("squadDataEscape");
    sequence = namespace_ff4ab724::function_44b382a7(planner);
    sequence = namespace_ff4ab724::function_c55f60e5(planner);
    sequence = namespace_ff4ab724::function_8d586a9e(planner);
    sequence = namespace_ff4ab724::function_fe51b831(planner);
    planner::addaction(planner, "squadWander");
    return planner;
}

// Namespace namespace_e6f9eb3e/namespace_6f074cfb
// Params 1, eflags: 0x4
// Checksum 0xb898f0d7, Offset: 0x570
// Size: 0x25c
function private function_df76832b(commander) {
    if (!isdefined(level.vh_escort)) {
        return;
    }
    var_1b4e4bf6 = 1024 * 1024;
    var_672a7d74 = associativearray("obstruction_1", 0, "obstruction_2", 0, "obstruction_3", 0);
    exclude = [];
    foreach (gameobject in level.a_gameobjects) {
        if (isdefined(gameobject.identifier) && isdefined(var_672a7d74[gameobject.identifier])) {
            var_672a7d74[gameobject.identifier] = 1;
            if (distance2dsquared(level.vh_escort.origin, gameobject.origin) >= var_1b4e4bf6) {
                exclude[exclude.size] = gameobject.identifier;
            }
        }
    }
    foreach (var_9bc7e65, found in var_672a7d74) {
        if (!found) {
            exclude[exclude.size] = var_9bc7e65;
        }
    }
    if (exclude.size < var_672a7d74.size) {
        exclude[exclude.size] = "siegebot";
    }
    blackboard::setstructblackboardattribute(commander, "gameobjects_exclude", exclude);
}

// Namespace namespace_e6f9eb3e/namespace_6f074cfb
// Params 0, eflags: 0x0
// Checksum 0x2ce44728, Offset: 0x7d8
// Size: 0x1b8
function function_74f32e07() {
    team = "allies";
    commander = plannercommanderutility::createcommander(team, _createcommanderplanner(team), _createsquadplanner(team));
    blackboard::setstructblackboardattribute(commander, "gameobjects_priority", array("vip_convoy", "obstruction_1", "obstruction_2", "obstruction_3", "vehicle_reboot"));
    blackboard::setstructblackboardattribute(commander, "gameobjects_force_attack", array("vip_convoy", "siegebot"));
    plannergenericcommander::commanderdaemons(commander);
    plannercommanderutility::adddaemon(commander, "daemonObstructions");
    plannergenericcommander::commanderutilityevaluators(commander);
    plannercommanderutility::addsquadevaluator(commander, "commanderScoreGameobjectPriority", associativearray("priority", array("vip_convoy", "obstruction_1", "obstruction_2", "obstruction_3", "vehicle_reboot")));
    return commander;
}

// Namespace namespace_e6f9eb3e/namespace_6f074cfb
// Params 0, eflags: 0x0
// Checksum 0xdbc83311, Offset: 0x998
// Size: 0x1b8
function function_deecc0c0() {
    team = "axis";
    commander = plannercommanderutility::createcommander(team, _createcommanderplanner(team), _createsquadplanner(team));
    blackboard::setstructblackboardattribute(commander, "gameobjects_priority", array("vip_convoy", "obstruction_1", "obstruction_2", "obstruction_3", "vehicle_reboot"));
    blackboard::setstructblackboardattribute(commander, "gameobjects_force_attack", array("vip_convoy", "siegebot"));
    plannergenericcommander::commanderdaemons(commander);
    plannercommanderutility::adddaemon(commander, "daemonObstructions");
    plannergenericcommander::commanderutilityevaluators(commander);
    plannercommanderutility::addsquadevaluator(commander, "commanderScoreGameobjectPriority", associativearray("priority", array("vip_convoy", "obstruction_1", "obstruction_2", "obstruction_3", "vehicle_reboot")));
    return commander;
}

