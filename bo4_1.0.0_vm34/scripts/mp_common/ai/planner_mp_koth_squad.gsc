#using scripts\core_common\ai\planner_commander;
#using scripts\core_common\ai\planner_commander_utility;
#using scripts\core_common\ai\planner_squad_utility;
#using scripts\core_common\ai\systems\planner;
#using scripts\mp_common\ai\planner_mp_squad_utility;

#namespace plannermpkothsquad;

// Namespace plannermpkothsquad/planner_mp_koth_squad
// Params 1, eflags: 0x0
// Checksum 0x54a48168, Offset: 0xa8
// Size: 0x32
function createsquadplanner(team) {
    planner = plannerutility::createplannerfromasset("mp_koth_squad.ai_htn");
    return planner;
}

