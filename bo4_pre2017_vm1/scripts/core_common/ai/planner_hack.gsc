#using scripts/core_common/ai/planner_commander;
#using scripts/core_common/ai/planner_commander_utility;
#using scripts/core_common/ai/planner_generic_commander;
#using scripts/core_common/ai/planner_generic_squad;
#using scripts/core_common/ai/planner_squad_utility;
#using scripts/core_common/ai/systems/planner;

#namespace plannerhack;

// Namespace plannerhack/planner_hack
// Params 1, eflags: 0x4
// Checksum 0xb6206c0a, Offset: 0x1e0
// Size: 0x170
function private _createcommanderplanner(team) {
    planner = planner::createplanner("commanderHack");
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

// Namespace plannerhack/planner_hack
// Params 1, eflags: 0x4
// Checksum 0xc3c5a43e, Offset: 0x358
// Size: 0xd0
function private _createsquadplanner(team) {
    planner = planner::createplanner("squadHack");
    sequence = plannergenericsquad::squadseekammocache(planner);
    sequence = plannergenericsquad::squadassaultstrategy(planner);
    sequence = plannergenericsquad::squaddefendstrategy(planner);
    sequence = plannergenericsquad::squadescortstrategy(planner);
    sequence = plannergenericsquad::squadmovetoobjectivestrategy(planner);
    planner::addaction(planner, "squadWander");
    return planner;
}

// Namespace plannerhack/planner_hack
// Params 1, eflags: 0x0
// Checksum 0xbd0d2396, Offset: 0x430
// Size: 0x88
function createcommander(team) {
    commander = plannercommanderutility::createcommander(team, _createcommanderplanner(team), _createsquadplanner(team));
    plannergenericcommander::commanderdaemons(commander);
    plannergenericcommander::commanderutilityevaluators(commander);
    return commander;
}

