#using scripts\core_common\ai\planner_commander;
#using scripts\core_common\ai\planner_commander_utility;
#using scripts\core_common\ai\planner_squad_utility;
#using scripts\core_common\ai\systems\planner;
#using scripts\mp_common\ai\planner_mp_squad_utility;

#namespace plannermpcontrolsquad;

// Namespace plannermpcontrolsquad/planner_mp_control_squad
// Params 1, eflags: 0x0
// Checksum 0x4f1cb476, Offset: 0xa8
// Size: 0x32
function createsquadplanner(team) {
    planner = plannerutility::createplannerfromasset("mp_control_squad.ai_htn");
    return planner;
}

