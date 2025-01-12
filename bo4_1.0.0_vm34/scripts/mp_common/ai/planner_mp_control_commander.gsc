#using scripts\core_common\ai\planner_commander;
#using scripts\core_common\ai\planner_commander_utility;
#using scripts\core_common\ai\planner_generic_commander;
#using scripts\core_common\ai\planner_squad_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai\systems\planner;
#using scripts\mp_common\ai\planner_mp_commander_utility;
#using scripts\mp_common\ai\planner_mp_control_squad;

#namespace plannermpcontrolcommander;

// Namespace plannermpcontrolcommander/planner_mp_control_commander
// Params 1, eflags: 0x4
// Checksum 0x4eafb64, Offset: 0x160
// Size: 0x32
function private createcommanderplanner(team) {
    planner = plannerutility::createplannerfromasset("mp_control_commander.ai_htn");
    return planner;
}

// Namespace plannermpcontrolcommander/planner_mp_control_commander
// Params 1, eflags: 0x0
// Checksum 0x92a9c28f, Offset: 0x1a0
// Size: 0x1c0
function createcommander(team) {
    commander = plannercommanderutility::createcommander(team, createcommanderplanner(team), plannermpcontrolsquad::createsquadplanner(team), float(function_f9f48566()) / 1000 * 40, float(function_f9f48566()) / 1000 * 100, 3, 3);
    plannergenericcommander::commanderdaemons(commander);
    plannercommanderutility::adddaemon(commander, "daemonControlZones");
    plannercommanderutility::addsquadevaluator(commander, "commanderScoreBotPresence");
    plannercommanderutility::addsquadevaluator(commander, "commanderScoreForceGoal");
    plannercommanderutility::addsquadevaluator(commander, "commanderScoreTeam");
    plannercommanderutility::addsquadevaluator(commander, "commanderScoreAge", [#"maxage":5000]);
    plannercommanderutility::addsquadevaluator(commander, "commanderScoreAlive");
    plannercommanderutility::addsquadevaluator(commander, "commanderScoreControlZones");
    return commander;
}

