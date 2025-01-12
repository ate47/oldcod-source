#using scripts/core_common/ai/planner_commander;
#using scripts/core_common/ai/planner_commander_utility;
#using scripts/core_common/ai/planner_generic_commander;
#using scripts/core_common/ai/planner_generic_squad;
#using scripts/core_common/ai/planner_squad_utility;
#using scripts/core_common/ai/systems/blackboard;
#using scripts/core_common/ai/systems/planner;

#namespace namespace_8b4832c8;

// Namespace namespace_8b4832c8/namespace_57473954
// Params 1, eflags: 0x4
// Checksum 0x1bb33ace, Offset: 0x290
// Size: 0x1e0
function private _createcommanderplanner(team) {
    planner = planner::createplanner("commanderDataEscape");
    sequence = plannergenericcommander::function_96caab78(planner);
    planner::addgoto(sequence, planner);
    sequence = plannergenericcommander::function_900bce7e(planner);
    planner::addgoto(sequence, planner);
    sequence = plannergenericcommander::function_8ad0227e(planner);
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

// Namespace namespace_8b4832c8/namespace_57473954
// Params 1, eflags: 0x4
// Checksum 0xd4a33295, Offset: 0x478
// Size: 0xd0
function private _createsquadplanner(team) {
    planner = planner::createplanner("squadDataEscape");
    sequence = namespace_ff4ab724::function_44b382a7(planner);
    sequence = namespace_ff4ab724::function_c55f60e5(planner);
    sequence = namespace_ff4ab724::function_8d586a9e(planner);
    sequence = namespace_ff4ab724::function_a59be1a2(planner);
    sequence = namespace_ff4ab724::function_fe51b831(planner);
    planner::addaction(planner, "squadWander");
    return planner;
}

// Namespace namespace_8b4832c8/namespace_57473954
// Params 1, eflags: 0x0
// Checksum 0x4868b81e, Offset: 0x550
// Size: 0x108
function createcommander(team) {
    commander = plannercommanderutility::createcommander(team, _createcommanderplanner(team), _createsquadplanner(team));
    blackboard::setstructblackboardattribute(commander, "gameobjects_exclude", array("hijack_vehicle", "bolster_forces"));
    blackboard::setstructblackboardattribute(commander, "gameobjects_force_attack", array("breach_door", "vehicle_quadtank", "vehicle_vtol"));
    plannergenericcommander::commanderdaemons(commander);
    plannergenericcommander::commanderutilityevaluators(commander);
    return commander;
}

