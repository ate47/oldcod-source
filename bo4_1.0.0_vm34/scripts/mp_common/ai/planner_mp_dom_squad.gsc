#using scripts\core_common\ai\planner_commander;
#using scripts\core_common\ai\planner_commander_utility;
#using scripts\core_common\ai\planner_squad_utility;
#using scripts\core_common\ai\systems\planner;
#using scripts\mp_common\ai\planner_mp_squad_utility;

#namespace plannermpdomsquad;

// Namespace plannermpdomsquad/planner_mp_dom_squad
// Params 1, eflags: 0x0
// Checksum 0x43aeccfa, Offset: 0xa8
// Size: 0x32
function createsquadplanner(team) {
    planner = plannerutility::createplannerfromasset("mp_dom_squad.ai_htn");
    return planner;
}

