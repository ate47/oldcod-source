#using scripts/core_common/ai/planner_commander;
#using scripts/core_common/ai/planner_commander_utility;
#using scripts/core_common/ai/planner_generic_commander;
#using scripts/core_common/ai/planner_generic_squad;
#using scripts/core_common/ai/planner_squad_utility;
#using scripts/core_common/ai/systems/blackboard;
#using scripts/core_common/ai/systems/planner;

#namespace namespace_b8ec745a;

// Namespace namespace_b8ec745a/namespace_7d324e6c
// Params 1, eflags: 0x4
// Checksum 0x76fe88c2, Offset: 0x280
// Size: 0x218
function private _createcommanderplanner(team) {
    planner = planner::createplanner("commanderDataControl");
    sequence = plannergenericcommander::function_96caab78(planner);
    planner::addgoto(sequence, planner);
    sequence = plannergenericcommander::function_900bce7e(planner);
    planner::addgoto(sequence, planner);
    sequence = plannergenericcommander::function_8ad0227e(planner);
    planner::addgoto(sequence, planner);
    sequence = plannergenericcommander::function_1cf28baa(planner);
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

// Namespace namespace_b8ec745a/namespace_7d324e6c
// Params 1, eflags: 0x4
// Checksum 0xbba56bd4, Offset: 0x4a0
// Size: 0xd0
function private _createsquadplanner(team) {
    planner = planner::createplanner("squadDataControl");
    sequence = namespace_ff4ab724::function_44b382a7(planner);
    sequence = namespace_ff4ab724::function_c55f60e5(planner);
    sequence = namespace_ff4ab724::function_8d586a9e(planner);
    sequence = namespace_ff4ab724::function_a59be1a2(planner);
    sequence = namespace_ff4ab724::function_fe51b831(planner);
    planner::addaction(planner, "squadWander");
    return planner;
}

// Namespace namespace_b8ec745a/namespace_7d324e6c
// Params 0, eflags: 0x0
// Checksum 0x90da1623, Offset: 0x578
// Size: 0x98
function function_74f32e07() {
    team = "allies";
    commander = plannercommanderutility::createcommander(team, _createcommanderplanner(team), _createsquadplanner(team));
    plannergenericcommander::commanderdaemons(commander);
    plannergenericcommander::commanderutilityevaluators(commander);
    return commander;
}

// Namespace namespace_b8ec745a/namespace_7d324e6c
// Params 0, eflags: 0x0
// Checksum 0xe3e28aca, Offset: 0x618
// Size: 0xe0
function function_deecc0c0() {
    team = "axis";
    commander = plannercommanderutility::createcommander(team, _createcommanderplanner(team), _createsquadplanner(team));
    blackboard::setstructblackboardattribute(commander, "gameobjects_priority", array("deactivate_terminal_a", "deactivate_terminal_b", "deactivate_terminal_c"));
    plannergenericcommander::commanderdaemons(commander);
    plannergenericcommander::commanderutilityevaluators(commander);
    return commander;
}

