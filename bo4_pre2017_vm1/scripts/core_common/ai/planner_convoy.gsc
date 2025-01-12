#using scripts/core_common/ai/planner_commander;
#using scripts/core_common/ai/planner_commander_utility;
#using scripts/core_common/ai/planner_generic_commander;
#using scripts/core_common/ai/planner_generic_squad;
#using scripts/core_common/ai/planner_squad_utility;
#using scripts/core_common/ai/systems/blackboard;
#using scripts/core_common/ai/systems/planner;

#namespace plannerconvoy;

// Namespace plannerconvoy/planner_convoy
// Params 1, eflags: 0x4
// Checksum 0x94ca63cb, Offset: 0x250
// Size: 0x170
function private _createcommanderplanner(team) {
    planner = planner::createplanner("commanderDataEscape");
    sequence = plannergenericcommander::commanderforcegoalstrategy(planner);
    planner::addgoto(sequence, planner);
    sequence = plannergenericcommander::commanderassaultsquadstrategy(planner);
    planner::addgoto(sequence, planner);
    sequence = plannergenericcommander::commanderdefendsquadstrategy(planner);
    planner::addgoto(sequence, planner);
    sequence = plannergenericcommander::commanderobjectivesquadstrategy(planner);
    planner::addgoto(sequence, planner);
    sequence = plannergenericcommander::commanderwandersquadstrategy(planner);
    planner::addgoto(sequence, planner);
    planner::addaction(planner, "commanderEndPlan");
    return planner;
}

// Namespace plannerconvoy/planner_convoy
// Params 1, eflags: 0x4
// Checksum 0xd1a00214, Offset: 0x3c8
// Size: 0xb8
function private _createsquadplanner(team) {
    planner = planner::createplanner("squadDataEscape");
    sequence = plannergenericsquad::squadseekammocache(planner);
    sequence = plannergenericsquad::squadassaultstrategy(planner);
    sequence = plannergenericsquad::squaddefendstrategy(planner);
    sequence = plannergenericsquad::squadmovetoobjectivestrategy(planner);
    planner::addaction(planner, "squadWander");
    return planner;
}

// Namespace plannerconvoy/planner_convoy
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

