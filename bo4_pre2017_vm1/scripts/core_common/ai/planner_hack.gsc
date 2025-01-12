#using scripts/core_common/ai/planner_commander;
#using scripts/core_common/ai/planner_commander_utility;
#using scripts/core_common/ai/planner_generic_commander;
#using scripts/core_common/ai/planner_generic_squad;
#using scripts/core_common/ai/planner_squad_utility;
#using scripts/core_common/ai/systems/planner;

#namespace namespace_c93aa218;

// Namespace namespace_c93aa218/namespace_6f49b5d
// Params 1, eflags: 0x4
// Checksum 0xb6206c0a, Offset: 0x1e0
// Size: 0x170
function private _createcommanderplanner(team) {
    planner = planner::createplanner("commanderHack");
    sequence = plannergenericcommander::function_96caab78(planner);
    planner::addgoto(sequence, planner);
    sequence = plannergenericcommander::function_900bce7e(planner);
    planner::addgoto(sequence, planner);
    sequence = plannergenericcommander::function_3eac1247(planner);
    planner::addgoto(sequence, planner);
    sequence = plannergenericcommander::function_ec4dcfc2(planner);
    planner::addgoto(sequence, planner);
    sequence = plannergenericcommander::function_823fd55f(planner);
    planner::addgoto(sequence, planner);
    planner::addaction(planner, "commanderEndPlan");
    return planner;
}

// Namespace namespace_c93aa218/namespace_6f49b5d
// Params 1, eflags: 0x4
// Checksum 0xc3c5a43e, Offset: 0x358
// Size: 0xd0
function private _createsquadplanner(team) {
    planner = planner::createplanner("squadHack");
    sequence = namespace_ff4ab724::function_44b382a7(planner);
    sequence = namespace_ff4ab724::function_c55f60e5(planner);
    sequence = namespace_ff4ab724::function_8d586a9e(planner);
    sequence = namespace_ff4ab724::function_a59be1a2(planner);
    sequence = namespace_ff4ab724::function_fe51b831(planner);
    planner::addaction(planner, "squadWander");
    return planner;
}

// Namespace namespace_c93aa218/namespace_6f49b5d
// Params 1, eflags: 0x0
// Checksum 0xbd0d2396, Offset: 0x430
// Size: 0x88
function createcommander(team) {
    commander = plannercommanderutility::createcommander(team, _createcommanderplanner(team), _createsquadplanner(team));
    plannergenericcommander::commanderdaemons(commander);
    plannergenericcommander::commanderutilityevaluators(commander);
    return commander;
}

