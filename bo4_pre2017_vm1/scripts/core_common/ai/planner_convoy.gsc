#using scripts/core_common/ai/planner_commander;
#using scripts/core_common/ai/planner_commander_utility;
#using scripts/core_common/ai/planner_generic_commander;
#using scripts/core_common/ai/planner_generic_squad;
#using scripts/core_common/ai/planner_squad_utility;
#using scripts/core_common/ai/systems/blackboard;
#using scripts/core_common/ai/systems/planner;

#namespace namespace_bad384a9;

// Namespace namespace_bad384a9/namespace_c8eaf000
// Params 1, eflags: 0x4
// Checksum 0x94ca63cb, Offset: 0x250
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

// Namespace namespace_bad384a9/namespace_c8eaf000
// Params 1, eflags: 0x4
// Checksum 0xd1a00214, Offset: 0x3c8
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

// Namespace namespace_bad384a9/namespace_c8eaf000
// Params 1, eflags: 0x0
// Checksum 0x66e28470, Offset: 0x488
// Size: 0xf0
function createcommander(team) {
    commander = plannercommanderutility::createcommander(team, _createcommanderplanner(team), _createsquadplanner(team));
    blackboard::setstructblackboardattribute(commander, "gameobjects_priority", array("vip_interact"));
    blackboard::setstructblackboardattribute(commander, "gameobjects_force_attack", array("vip_interact"));
    plannergenericcommander::commanderdaemons(commander);
    plannergenericcommander::commanderutilityevaluators(commander);
    return commander;
}

