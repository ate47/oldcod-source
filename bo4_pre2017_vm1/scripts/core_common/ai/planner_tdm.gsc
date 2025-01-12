#using scripts/core_common/ai/planner_commander;
#using scripts/core_common/ai/planner_commander_utility;
#using scripts/core_common/ai/planner_generic_commander;
#using scripts/core_common/ai/planner_generic_squad;
#using scripts/core_common/ai/planner_squad_utility;
#using scripts/core_common/ai/systems/blackboard;
#using scripts/core_common/ai/systems/planner;

#namespace namespace_ceda4ee8;

// Namespace namespace_ceda4ee8/namespace_481d858b
// Params 1, eflags: 0x4
// Checksum 0xc9843c74, Offset: 0x208
// Size: 0x90
function private _createcommanderplanner(team) {
    planner = planner::createplanner("commanderTDM");
    sequence = plannergenericcommander::function_823fd55f(planner);
    planner::addgoto(sequence, planner);
    planner::addaction(planner, "commanderEndPlan");
    return planner;
}

// Namespace namespace_ceda4ee8/namespace_481d858b
// Params 1, eflags: 0x4
// Checksum 0x1dbd774e, Offset: 0x2a0
// Size: 0x50
function private _createsquadplanner(team) {
    planner = planner::createplanner("squadTDM");
    planner::addaction(planner, "squadWander");
    return planner;
}

// Namespace namespace_ceda4ee8/namespace_481d858b
// Params 1, eflags: 0x0
// Checksum 0x69175240, Offset: 0x2f8
// Size: 0x88
function createcommander(team) {
    commander = plannercommanderutility::createcommander(team, _createcommanderplanner(team), _createsquadplanner(team));
    plannergenericcommander::commanderdaemons(commander);
    plannergenericcommander::commanderutilityevaluators(commander);
    return commander;
}

