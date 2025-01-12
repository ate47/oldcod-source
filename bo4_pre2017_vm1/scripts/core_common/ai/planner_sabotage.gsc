#using scripts/core_common/ai/planner_commander;
#using scripts/core_common/ai/planner_commander_utility;
#using scripts/core_common/ai/planner_generic_commander;
#using scripts/core_common/ai/planner_generic_squad;
#using scripts/core_common/ai/planner_squad_utility;
#using scripts/core_common/ai/systems/blackboard;
#using scripts/core_common/ai/systems/planner;

#namespace namespace_577cc1ef;

// Namespace namespace_577cc1ef/namespace_6e667e3e
// Params 1, eflags: 0x4
// Checksum 0xdd2beb25, Offset: 0x280
// Size: 0x170
function private _createcommanderplanner(team) {
    planner = planner::createplanner("commanderSabotage");
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

// Namespace namespace_577cc1ef/namespace_6e667e3e
// Params 1, eflags: 0x4
// Checksum 0xb8d90f18, Offset: 0x3f8
// Size: 0xd0
function private _createsquadplanner(team) {
    planner = planner::createplanner("squadSabotage");
    sequence = namespace_ff4ab724::function_44b382a7(planner);
    sequence = namespace_ff4ab724::function_c55f60e5(planner);
    sequence = namespace_ff4ab724::function_8d586a9e(planner);
    sequence = namespace_ff4ab724::function_a59be1a2(planner);
    sequence = namespace_ff4ab724::function_fe51b831(planner);
    planner::addaction(planner, "squadWander");
    return planner;
}

// Namespace namespace_577cc1ef/namespace_6e667e3e
// Params 1, eflags: 0x0
// Checksum 0x1e3bdc73, Offset: 0x4d0
// Size: 0x120
function createcommander(team) {
    commander = plannercommanderutility::createcommander(team, _createcommanderplanner(team), _createsquadplanner(team));
    blackboard::setstructblackboardattribute(commander, "gameobjects_priority", array("sabotage_lockdown", "sabotage_lockdown_open"));
    plannergenericcommander::commanderdaemons(commander);
    plannergenericcommander::commanderutilityevaluators(commander);
    plannercommanderutility::addsquadevaluator(commander, "commanderScoreGameobjectPriority", associativearray("priority", array("sabotage_lockdown", "sabotage_lockdown_open")));
    return commander;
}

