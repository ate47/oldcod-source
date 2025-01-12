#using scripts\core_common\ai\planner_commander;
#using scripts\core_common\ai\planner_commander_utility;
#using scripts\core_common\ai\planner_squad_utility;
#using scripts\core_common\ai\systems\planner;
#using scripts\zm_common\ai\planner_zm_squad_utility;

#namespace namespace_3bd9316b;

// Namespace namespace_3bd9316b/planner_zm_generic_squad
// Params 1, eflags: 0x0
// Checksum 0x92b4ad02, Offset: 0xa0
// Size: 0x32
function createsquadplanner(team) {
    planner = plannerutility::createplannerfromasset("zm_squad.ai_htn");
    return planner;
}

