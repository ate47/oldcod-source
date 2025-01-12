#using script_37e409875b3ab3b6;
#using scripts\core_common\ai\planner_commander;
#using scripts\core_common\ai\planner_commander_utility;
#using scripts\core_common\ai\planner_generic_commander;
#using scripts\core_common\ai\planner_generic_squad;
#using scripts\core_common\ai\planner_squad_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai\systems\planner;
#using scripts\zm_common\ai\planner_zm_commander_utility;
#using scripts\zm_common\ai\planner_zm_generic_commander;
#using scripts\zm_common\ai\planner_zm_generic_squad;
#using scripts\zm_common\ai\planner_zm_squad_utility;

#namespace namespace_f7114d52;

// Namespace namespace_f7114d52/namespace_657a8255
// Params 1, eflags: 0x4
// Checksum 0x6be60069, Offset: 0x110
// Size: 0x32
function private _createcommanderplanner(team) {
    planner = plannerutility::createplannerfromasset("zm_commander.ai_htn");
    return planner;
}

// Namespace namespace_f7114d52/namespace_657a8255
// Params 1, eflags: 0x4
// Checksum 0xb6e74036, Offset: 0x150
// Size: 0x32
function private _createsquadplanner(team) {
    planner = plannerutility::createplannerfromasset("zm_squad.ai_htn");
    return planner;
}

// Namespace namespace_f7114d52/namespace_657a8255
// Params 0, eflags: 0x0
// Checksum 0x100734e3, Offset: 0x190
// Size: 0xcc
function createcommander() {
    team = #"allies";
    commander = plannercommanderutility::createcommander(team, _createcommanderplanner(team), _createsquadplanner(team));
    plannergenericcommander::commanderdaemons(commander);
    plannercommanderutility::adddaemon(commander, "daemonZmBlockers");
    plannercommanderutility::adddaemon(commander, "daemonZmWallBuys");
    plannergenericcommander::commanderutilityevaluators(commander);
}

