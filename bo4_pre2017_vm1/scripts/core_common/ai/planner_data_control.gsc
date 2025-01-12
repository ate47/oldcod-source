#using scripts/core_common/ai/planner_commander;
#using scripts/core_common/ai/planner_commander_utility;
#using scripts/core_common/ai/planner_generic_commander;
#using scripts/core_common/ai/planner_generic_squad;
#using scripts/core_common/ai/planner_squad_utility;
#using scripts/core_common/ai/systems/blackboard;
#using scripts/core_common/ai/systems/planner;

#namespace plannerdatacontrol;

// Namespace plannerdatacontrol/planner_data_control
// Params 1, eflags: 0x4
// Checksum 0x76fe88c2, Offset: 0x280
// Size: 0x218
function private _createcommanderplanner(team) {
    planner = planner::createplanner("commanderDataControl");
    sequence = plannergenericcommander::commanderforcegoalstrategy(planner);
    planner::addgoto(sequence, planner);
    sequence = plannergenericcommander::commanderescortsquadstrategy(planner);
    planner::addgoto(sequence, planner);
    sequence = plannergenericcommander::commanderthrottlesquadstrategy(planner);
    planner::addgoto(sequence, planner);
    sequence = plannergenericcommander::commanderprioritydefendsquadstrategy(planner);
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

// Namespace plannerdatacontrol/planner_data_control
// Params 1, eflags: 0x4
// Checksum 0xbba56bd4, Offset: 0x4a0
// Size: 0xd0
function private _createsquadplanner(team) {
    planner = planner::createplanner("squadDataControl");
    sequence = plannergenericsquad::squadseekammocache(planner);
    sequence = plannergenericsquad::squadassaultstrategy(planner);
    sequence = plannergenericsquad::squaddefendstrategy(planner);
    sequence = plannergenericsquad::squadescortstrategy(planner);
    sequence = plannergenericsquad::squadmovetoobjectivestrategy(planner);
    planner::addaction(planner, "squadWander");
    return planner;
}

// Namespace plannerdatacontrol/planner_data_control
// Params 0, eflags: 0x0
// Checksum 0x90da1623, Offset: 0x578
// Size: 0x98
function createalliescommander() {
    team = "allies";
    commander = plannercommanderutility::createcommander(team, _createcommanderplanner(team), _createsquadplanner(team));
    plannergenericcommander::commanderdaemons(commander);
    plannergenericcommander::commanderutilityevaluators(commander);
    return commander;
}

// Namespace plannerdatacontrol/planner_data_control
// Params 0, eflags: 0x0
// Checksum 0xe3e28aca, Offset: 0x618
// Size: 0xe0
function createaxiscommander() {
    team = "axis";
    commander = plannercommanderutility::createcommander(team, _createcommanderplanner(team), _createsquadplanner(team));
    blackboard::setstructblackboardattribute(commander, "gameobjects_priority", array("deactivate_terminal_a", "deactivate_terminal_b", "deactivate_terminal_c"));
    plannergenericcommander::commanderdaemons(commander);
    plannergenericcommander::commanderutilityevaluators(commander);
    return commander;
}

