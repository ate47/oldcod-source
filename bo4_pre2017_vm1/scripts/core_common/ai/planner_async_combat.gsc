#using scripts/core_common/ai/planner_commander;
#using scripts/core_common/ai/planner_commander_utility;
#using scripts/core_common/ai/planner_generic_commander;
#using scripts/core_common/ai/planner_generic_squad;
#using scripts/core_common/ai/planner_squad_utility;
#using scripts/core_common/ai/systems/planner;

#namespace namespace_b3fa10b5;

// Namespace namespace_b3fa10b5/namespace_97ddd82d
// Params 1, eflags: 0x4
// Checksum 0x795be291, Offset: 0x1f0
// Size: 0x138
function private _createcommanderplanner(team) {
    planner = planner::createplanner("commanderAsyncCombat");
    sequence = plannergenericcommander::function_96caab78(planner);
    planner::addgoto(sequence, planner);
    sequence = plannergenericcommander::function_900bce7e(planner);
    planner::addgoto(sequence, planner);
    sequence = plannergenericcommander::function_3eac1247(planner);
    planner::addgoto(sequence, planner);
    sequence = plannergenericcommander::function_823fd55f(planner);
    planner::addgoto(sequence, planner);
    planner::addaction(planner, "commanderEndPlan");
    return planner;
}

// Namespace namespace_b3fa10b5/namespace_97ddd82d
// Params 1, eflags: 0x4
// Checksum 0xda52708d, Offset: 0x330
// Size: 0xb8
function private _createsquadplanner(team) {
    planner = planner::createplanner("squadAsyncCombat");
    sequence = namespace_ff4ab724::function_44b382a7(planner);
    sequence = namespace_ff4ab724::function_c55f60e5(planner);
    sequence = namespace_ff4ab724::function_a59be1a2(planner);
    sequence = namespace_ff4ab724::function_fe51b831(planner);
    planner::addaction(planner, "squadWander");
    return planner;
}

// Namespace namespace_b3fa10b5/namespace_97ddd82d
// Params 1, eflags: 0x0
// Checksum 0x2d7d437e, Offset: 0x3f0
// Size: 0x88
function createcommander(team) {
    commander = plannercommanderutility::createcommander(team, _createcommanderplanner(team), _createsquadplanner(team));
    plannergenericcommander::commanderdaemons(commander);
    plannergenericcommander::commanderutilityevaluators(commander);
    return commander;
}

