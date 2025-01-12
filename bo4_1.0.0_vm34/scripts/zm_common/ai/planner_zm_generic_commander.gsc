#using scripts\core_common\ai\planner_commander;
#using scripts\core_common\ai\planner_commander_utility;
#using scripts\core_common\ai\planner_generic_commander;
#using scripts\core_common\ai\systems\planner;
#using scripts\core_common\system_shared;
#using scripts\zm_common\ai\planner_zm_commander_utility;
#using scripts\zm_common\ai\planner_zm_generic_squad;

#namespace namespace_3bd9316b;

// Namespace namespace_3bd9316b/planner_zm_generic_commander
// Params 0, eflags: 0x2
// Checksum 0x45ce6a69, Offset: 0xa0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"planner_zm_generic_commander", &__init__, undefined, undefined);
}

// Namespace namespace_3bd9316b/planner_zm_generic_commander
// Params 0, eflags: 0x0
// Checksum 0xa9329a5b, Offset: 0xe8
// Size: 0x1c
function __init__() {
    level thread createcommander();
}

// Namespace namespace_3bd9316b/planner_zm_generic_commander
// Params 1, eflags: 0x0
// Checksum 0x7c0ce1f, Offset: 0x110
// Size: 0x3a
function createcommanderplanner(team) {
    planner = plannerutility::createplannerfromasset(#"zm_commander.ai_htn");
    return planner;
}

// Namespace namespace_3bd9316b/planner_zm_generic_commander
// Params 0, eflags: 0x0
// Checksum 0xa7f1df5e, Offset: 0x158
// Size: 0x20c
function createcommander() {
    team = #"allies";
    commander = plannercommanderutility::createcommander(team, createcommanderplanner(team), createsquadplanner(team));
    plannergenericcommander::commanderdaemons(commander);
    plannercommanderutility::adddaemon(commander, #"daemonzmaltars");
    plannercommanderutility::adddaemon(commander, #"daemonzmblockers");
    plannercommanderutility::adddaemon(commander, #"daemonzmchests");
    plannercommanderutility::adddaemon(commander, #"daemonzmpowerups");
    plannercommanderutility::adddaemon(commander, #"daemonzmswitches");
    plannercommanderutility::adddaemon(commander, #"daemonzmwallbuys");
    plannercommanderutility::addsquadevaluator(commander, #"commanderscorebotpresence");
    plannercommanderutility::addsquadevaluator(commander, #"commanderscoreescortpathing");
    plannercommanderutility::addsquadevaluator(commander, #"commanderscoreforcegoal");
    plannercommanderutility::addsquadevaluator(commander, #"commanderscoreteam");
    plannercommanderutility::addsquadevaluator(commander, #"commanderscoreviableescort");
    plannercommanderutility::addsquadevaluator(commander, #"commanderscoreage", [#"maxage":6000]);
}

