#using scripts/core_common/ai/planner_commander;
#using scripts/core_common/ai/planner_commander_utility;
#using scripts/core_common/ai/planner_generic_commander;
#using scripts/core_common/ai/planner_generic_squad;
#using scripts/core_common/ai/planner_squad_utility;
#using scripts/core_common/ai/systems/blackboard;
#using scripts/core_common/ai/systems/planner;

#namespace plannersabotage;

// Namespace plannersabotage/planner_sabotage
// Params 1, eflags: 0x4
// Checksum 0xdd2beb25, Offset: 0x280
// Size: 0x170
function private _createcommanderplanner(team) {
    planner = planner::createplanner("commanderSabotage");
    sequence = plannergenericcommander::commanderforcegoalstrategy(planner);
    planner::addgoto(sequence, planner);
    sequence = plannergenericcommander::commanderescortsquadstrategy(planner);
    planner::addgoto(sequence, planner);
    sequence = plannergenericcommander::commanderassaultsquadstrategy(planner);
    planner::addgoto(sequence, planner);
    sequence = plannergenericcommander::commanderdefendsquadstrategy(planner);
    planner::addgoto(sequence, planner);
    sequence = plannergenericcommander::commanderwandersquadstrategy(planner);
    planner::addgoto(sequence, planner);
    planner::addaction(planner, "commanderEndPlan");
    return planner;
}

// Namespace plannersabotage/planner_sabotage
// Params 1, eflags: 0x4
// Checksum 0xb8d90f18, Offset: 0x3f8
// Size: 0xd0
function private _createsquadplanner(team) {
    planner = planner::createplanner("squadSabotage");
    sequence = plannergenericsquad::squadseekammocache(planner);
    sequence = plannergenericsquad::squadassaultstrategy(planner);
    sequence = plannergenericsquad::squaddefendstrategy(planner);
    sequence = plannergenericsquad::squadescortstrategy(planner);
    sequence = plannergenericsquad::squadmovetoobjectivestrategy(planner);
    planner::addaction(planner, "squadWander");
    return planner;
}

// Namespace plannersabotage/planner_sabotage
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

