#using scripts\core_common\ai\planner_commander;
#using scripts\core_common\ai\strategic_command;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai\systems\planner;

#namespace plannergenericcommander;

// Namespace plannergenericcommander/planner_generic_commander
// Params 1, eflags: 0x4
// Checksum 0x2a57e019, Offset: 0x260
// Size: 0x32
function private _createcommanderplanner(team) {
    planner = plannerutility::createplannerfromasset("strategic_commander.ai_htn");
    return planner;
}

// Namespace plannergenericcommander/planner_generic_commander
// Params 1, eflags: 0x4
// Checksum 0x8a477919, Offset: 0x2a0
// Size: 0x32
function private _createsquadplanner(team) {
    planner = plannerutility::createplannerfromasset("strategic_squad.ai_htn");
    return planner;
}

// Namespace plannergenericcommander/planner_generic_commander
// Params 1, eflags: 0x0
// Checksum 0x105370cd, Offset: 0x2e0
// Size: 0xc8
function createcommander(team) {
    commander = plannercommanderutility::createcommander(team, _createcommanderplanner(team), _createsquadplanner(team));
    commanderdaemons(commander);
    commanderutilityevaluators(commander);
    blackboard::setstructblackboardattribute(commander, #"gameobjects_exclude", array("ammo_cache", "mobile_armory", "trap"));
    return commander;
}

// Namespace plannergenericcommander/planner_generic_commander
// Params 1, eflags: 0x0
// Checksum 0x3535e57e, Offset: 0x3b0
// Size: 0x74
function commanderdaemons(commander) {
    assert(isstruct(commander));
    plannercommanderutility::adddaemon(commander, "daemonClients");
    plannercommanderutility::adddaemon(commander, "daemonGameobjects");
}

// Namespace plannergenericcommander/planner_generic_commander
// Params 1, eflags: 0x0
// Checksum 0xb77e4b4d, Offset: 0x430
// Size: 0x1b4
function commanderutilityevaluators(commander) {
    assert(isstruct(commander));
    plannercommanderutility::addsquadevaluator(commander, "commanderScoreBotChain");
    plannercommanderutility::addsquadevaluator(commander, "commanderScoreBotPresence");
    plannercommanderutility::addsquadevaluator(commander, "commanderScoreBotVehiclePresence");
    plannercommanderutility::addsquadevaluator(commander, "commanderScoreEscortPathing");
    plannercommanderutility::addsquadevaluator(commander, "commanderScoreForceGoal");
    plannercommanderutility::addsquadevaluator(commander, "commanderScoreGameobjectsValidity");
    plannercommanderutility::addsquadevaluator(commander, "commanderScoreGameobjectPathing");
    plannercommanderutility::addsquadevaluator(commander, "commanderScoreNoTarget");
    plannercommanderutility::addsquadevaluator(commander, "commanderScoreTeam");
    plannercommanderutility::addsquadevaluator(commander, "commanderScoreViableEscort");
    plannercommanderutility::addsquadevaluator(commander, "commanderScoreProgressThrottling");
    plannercommanderutility::addsquadevaluator(commander, "commanderScoreTarget");
}

// Namespace plannergenericcommander/planner_generic_commander
// Params 0, eflags: 0x0
// Checksum 0x5e89baa7, Offset: 0x5f0
// Size: 0x66
function function_adb2ad71() {
    function_7e515343();
    level.axiscommander = createcommander(#"axis");
    level.alliescommander = createcommander(#"allies");
}

// Namespace plannergenericcommander/planner_generic_commander
// Params 0, eflags: 0x0
// Checksum 0x1afc9368, Offset: 0x660
// Size: 0x44
function function_7e515343() {
    strategiccommandutility::function_3ebf7ac8("default_strategicbundle", "sidea");
    strategiccommandutility::function_3ebf7ac8("default_strategicbundle", "sideb");
}

