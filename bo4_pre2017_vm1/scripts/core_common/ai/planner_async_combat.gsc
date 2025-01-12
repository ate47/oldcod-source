#using scripts/core_common/ai/planner_commander;
#using scripts/core_common/ai/planner_commander_utility;
#using scripts/core_common/ai/planner_generic_commander;
#using scripts/core_common/ai/planner_generic_squad;
#using scripts/core_common/ai/planner_squad_utility;
#using scripts/core_common/ai/systems/planner;

#namespace plannerasynccombat;

// Namespace plannerasynccombat/planner_async_combat
// Params 1, eflags: 0x4
// Checksum 0x795be291, Offset: 0x1f0
// Size: 0x138
function private _createcommanderplanner(team) {
    planner = planner::createplanner("commanderAsyncCombat");
    sequence = plannergenericcommander::commanderforcegoalstrategy(planner);
    planner::addgoto(sequence, planner);
    sequence = plannergenericcommander::commanderescortsquadstrategy(planner);
    planner::addgoto(sequence, planner);
    sequence = plannergenericcommander::commanderassaultsquadstrategy(planner);
    planner::addgoto(sequence, planner);
    sequence = plannergenericcommander::commanderwandersquadstrategy(planner);
    planner::addgoto(sequence, planner);
    planner::addaction(planner, "commanderEndPlan");
    return planner;
}

// Namespace plannerasynccombat/planner_async_combat
// Params 1, eflags: 0x4
// Checksum 0xda52708d, Offset: 0x330
// Size: 0xb8
function private _createsquadplanner(team) {
    planner = planner::createplanner("squadAsyncCombat");
    sequence = plannergenericsquad::squadseekammocache(planner);
    sequence = plannergenericsquad::squadassaultstrategy(planner);
    sequence = plannergenericsquad::squadescortstrategy(planner);
    sequence = plannergenericsquad::squadmovetoobjectivestrategy(planner);
    planner::addaction(planner, "squadWander");
    return planner;
}

// Namespace plannerasynccombat/planner_async_combat
// Params 1, eflags: 0x0
// Checksum 0x2d7d437e, Offset: 0x3f0
// Size: 0x88
function createcommander(team) {
    commander = plannercommanderutility::createcommander(team, _createcommanderplanner(team), _createsquadplanner(team));
    plannergenericcommander::commanderdaemons(commander);
    plannergenericcommander::commanderutilityevaluators(commander);
    return commander;
}

