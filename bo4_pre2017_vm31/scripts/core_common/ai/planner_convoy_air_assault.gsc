#using scripts/core_common/ai/planner_commander;
#using scripts/core_common/ai/planner_commander_utility;
#using scripts/core_common/ai/planner_generic_commander;
#using scripts/core_common/ai/planner_generic_squad;
#using scripts/core_common/ai/planner_squad_utility;
#using scripts/core_common/ai/systems/blackboard;
#using scripts/core_common/ai/systems/planner;

#namespace plannerconvoyairassault;

// Namespace plannerconvoyairassault/planner_convoy_air_assault
// Params 1, eflags: 0x4
// Checksum 0xcda7f1da, Offset: 0x310
// Size: 0x138
function private _createcommanderplanner(team) {
    planner = planner::createplanner("commanderSabotage");
    sequence = plannergenericcommander::commanderforcegoalstrategy(planner);
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

// Namespace plannerconvoyairassault/planner_convoy_air_assault
// Params 1, eflags: 0x4
// Checksum 0x98e920f3, Offset: 0x450
// Size: 0xb8
function private _createsquadplanner(team) {
    planner = planner::createplanner("squadSabotage");
    sequence = plannergenericsquad::squadseekammocache(planner);
    sequence = plannergenericsquad::squadassaultstrategy(planner);
    sequence = plannergenericsquad::squaddefendstrategy(planner);
    sequence = plannergenericsquad::squadmovetoobjectivestrategy(planner);
    planner::addaction(planner, "squadWander");
    return planner;
}

// Namespace plannerconvoyairassault/planner_convoy_air_assault
// Params 0, eflags: 0x0
// Checksum 0xecaab8fc, Offset: 0x510
// Size: 0x1a0
function createaxiscommander() {
    team = "axis";
    commander = plannercommanderutility::createcommander(team, _createcommanderplanner(team), _createsquadplanner(team));
    blackboard::setstructblackboardattribute(commander, "gameobjects_exclude", array("obstruction_1", "obstruction_2", "obstruction_3"));
    blackboard::setstructblackboardattribute(commander, "gameobjects_priority", array("tunnel_door", "obstruction_hack_priority", "obstruction_1_priority", "obstruction_2_priority", "obstruction_3_priority"));
    plannercommanderutility::addsquadevaluator(commander, "commanderScoreGameobjectPriority", associativearray("priority", array("tunnel_door", "obstruction_hack_priority", "obstruction_1_priority", "obstruction_2_priority", "obstruction_3_priority")));
    plannergenericcommander::commanderdaemons(commander);
    plannergenericcommander::commanderutilityevaluators(commander);
    return commander;
}

