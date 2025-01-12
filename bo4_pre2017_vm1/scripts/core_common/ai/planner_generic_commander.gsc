#using scripts/core_common/ai/planner_commander;
#using scripts/core_common/ai/planner_commander_utility;
#using scripts/core_common/ai/planner_squad_utility;
#using scripts/core_common/ai/systems/planner;

#namespace plannergenericcommander;

// Namespace plannergenericcommander/planner_generic_commander
// Params 1, eflags: 0x0
// Checksum 0x137a4030, Offset: 0xb20
// Size: 0x290
function function_3eac1247(parent) {
    /#
        assert(isstruct(parent));
    #/
    sequence = planner::addsequence(parent);
    planner::addprecondition(sequence, "commanderHasAtLeastXUnassignedBots", associativearray("amount", 1));
    planner::addprecondition(sequence, "commanderHasAtLeastXAssaultObjects", associativearray("amount", 1));
    planner::addaction(sequence, "commanderSquadCreateOfSizeX", associativearray("amount", 1));
    planner::addaction(sequence, "commanderPathingAddAssaultGameobjects");
    planner::addaction(sequence, "commanderPathingAddSquadBots");
    var_7fdba5d2 = function_ee3485ef(sequence);
    planner::addprecondition(sequence, "commanderSquadHasPathableObject");
    planner::addaction(sequence, "commanderSquadOrder", associativearray("order", "order_attack"));
    selector = planner::addselector(sequence);
    var_7fdba5d2 = planner::addsequence(selector);
    planner::addprecondition(var_7fdba5d2, "commanderSquadHasPathableUnclaimedObject");
    planner::addaction(var_7fdba5d2, "commanderSquadAssignPathableUnclaimedObject");
    planner::addaction(var_7fdba5d2, "commanderSquadClaimObject");
    var_7fdba5d2 = planner::addsequence(selector);
    planner::addaction(var_7fdba5d2, "commanderSquadAssignPathableObject");
    return sequence;
}

// Namespace plannergenericcommander/planner_generic_commander
// Params 1, eflags: 0x0
// Checksum 0xed5619c2, Offset: 0xdb8
// Size: 0x9c
function commanderdaemons(commander) {
    /#
        assert(isstruct(commander));
    #/
    plannercommanderutility::adddaemon(commander, "daemonClients");
    plannercommanderutility::adddaemon(commander, "daemonGameobjects");
    plannercommanderutility::adddaemon(commander, "daemonObjectives");
}

// Namespace plannergenericcommander/planner_generic_commander
// Params 1, eflags: 0x0
// Checksum 0xb34b6bf3, Offset: 0xe60
// Size: 0x290
function function_ec4dcfc2(parent) {
    /#
        assert(isstruct(parent));
    #/
    sequence = planner::addsequence(parent);
    planner::addprecondition(sequence, "commanderHasAtLeastXUnassignedBots", associativearray("amount", 1));
    planner::addprecondition(sequence, "commanderHasAtLeastXDefendObjects", associativearray("amount", 1));
    planner::addaction(sequence, "commanderSquadCreateOfSizeX", associativearray("amount", 1));
    planner::addaction(sequence, "commanderPathingAddDefendGameobjects");
    planner::addaction(sequence, "commanderPathingAddSquadBots");
    var_7fdba5d2 = function_ee3485ef(sequence);
    planner::addprecondition(sequence, "commanderSquadHasPathableObject");
    planner::addaction(sequence, "commanderSquadOrder", associativearray("order", "order_defend"));
    selector = planner::addselector(sequence);
    var_7fdba5d2 = planner::addsequence(selector);
    planner::addprecondition(var_7fdba5d2, "commanderSquadHasPathableUnclaimedObject");
    planner::addaction(var_7fdba5d2, "commanderSquadAssignPathableUnclaimedObject");
    planner::addaction(var_7fdba5d2, "commanderSquadClaimObject");
    var_7fdba5d2 = planner::addsequence(selector);
    planner::addaction(var_7fdba5d2, "commanderSquadAssignPathableObject");
    return sequence;
}

// Namespace plannergenericcommander/planner_generic_commander
// Params 1, eflags: 0x0
// Checksum 0xa22f801c, Offset: 0x10f8
// Size: 0x1e4
function function_900bce7e(parent) {
    /#
        assert(isstruct(parent));
    #/
    sequence = planner::addsequence(parent);
    planner::addprecondition(sequence, "commanderBlackboardValueIsTrue", associativearray("key", "allow_escort"));
    planner::addprecondition(sequence, "commanderHasAtLeastXUnassignedBots", associativearray("amount", 1));
    planner::addprecondition(sequence, "commanderHasAtLeastXPlayers", associativearray("amount", 1));
    planner::addaction(sequence, "commanderSquadCreateOfSizeX", associativearray("amount", 1));
    planner::addaction(sequence, "commanderSquadCalculatePathablePlayers");
    planner::addprecondition(sequence, "commanderSquadHasPathableEscort");
    planner::addaction(sequence, "commanderSquadAssignPathableEscort");
    var_7fdba5d2 = function_e75fb9b(sequence);
    var_7fdba5d2 = function_95a94e2d(sequence);
    return sequence;
}

// Namespace plannergenericcommander/planner_generic_commander
// Params 1, eflags: 0x0
// Checksum 0xcfeff96f, Offset: 0x12e8
// Size: 0x450
function function_e75fb9b(parent) {
    /#
        assert(isstruct(parent));
    #/
    selector = planner::addselector(parent);
    sequence = planner::addsequence(selector);
    planner::addprecondition(sequence, "commanderBlackboardValueIsTrue", associativearray("key", "allow_golden_path"));
    planner::addaction(sequence, "commanderPathingAddAssaultGameobjects");
    planner::addaction(sequence, "commanderPathingAddSquadEscorts");
    var_7fdba5d2 = function_ee3485ef(sequence);
    planner::addprecondition(sequence, "commanderSquadHasPathableObject");
    planner::addpostcondition(sequence, "commanderSquadCopyBlackboardValue", associativearray("from", "pathable_gameobjects", "to", "escort_poi"));
    planner::addpostcondition(sequence, "commanderSquadSortEscortPOI");
    sequence = planner::addsequence(selector);
    planner::addprecondition(sequence, "commanderBlackboardValueIsTrue", associativearray("key", "allow_golden_path"));
    planner::addaction(sequence, "commanderPathingAddDefendGameobjects");
    planner::addaction(sequence, "commanderPathingAddSquadEscorts");
    var_7fdba5d2 = function_ee3485ef(sequence);
    planner::addprecondition(sequence, "commanderSquadHasPathableObject");
    planner::addpostcondition(sequence, "commanderSquadCopyBlackboardValue", associativearray("from", "pathable_gameobjects", "to", "escort_poi"));
    planner::addpostcondition(sequence, "commanderSquadSortEscortPOI");
    sequence = planner::addsequence(selector);
    planner::addprecondition(sequence, "commanderBlackboardValueIsTrue", associativearray("key", "allow_golden_path"));
    planner::addaction(sequence, "commanderPathingAddObjectives");
    planner::addaction(sequence, "commanderPathingAddSquadEscorts");
    var_7fdba5d2 = function_40a89dfd(sequence);
    planner::addprecondition(sequence, "commanderSquadHasPathableObjective");
    planner::addpostcondition(sequence, "commanderSquadCopyBlackboardValue", associativearray("from", "pathable_objectives", "to", "escort_poi"));
    planner::addpostcondition(sequence, "commanderSquadSortEscortPOI");
    sequence = planner::addsequence(selector);
    planner::addaction(sequence, "commanderEndPlan");
    return selector;
}

// Namespace plannergenericcommander/planner_generic_commander
// Params 1, eflags: 0x0
// Checksum 0x8ef11864, Offset: 0x1740
// Size: 0x150
function function_95a94e2d(parent) {
    /#
        assert(isstruct(parent));
    #/
    selector = planner::addselector(parent);
    var_7fdba5d2 = planner::addsequence(selector);
    planner::addprecondition(var_7fdba5d2, "commanderSquadEscortHasNoVanguard");
    planner::addaction(var_7fdba5d2, "commanderSquadAssignVanguard");
    var_7fdba5d2 = planner::addsequence(selector);
    planner::addprecondition(var_7fdba5d2, "commanderSquadEscortHasNoRearguard");
    planner::addaction(var_7fdba5d2, "commanderSquadAssignRearguard");
    var_7fdba5d2 = planner::addsequence(selector);
    planner::addaction(var_7fdba5d2, "commanderSquadAssignMainguard");
    return selector;
}

// Namespace plannergenericcommander/planner_generic_commander
// Params 1, eflags: 0x0
// Checksum 0xab27b23b, Offset: 0x1898
// Size: 0x110
function function_96caab78(parent) {
    /#
        assert(isstruct(parent));
    #/
    sequence = planner::addsequence(parent);
    planner::addprecondition(sequence, "commanderHasAtLeastXUnassignedBots", associativearray("amount", 1));
    planner::addprecondition(sequence, "commanderHasForceGoal");
    planner::addaction(sequence, "commanderSquadCreateOfSizeX", associativearray("amount", 1));
    planner::addaction(sequence, "commanderSquadAssignForceGoal");
    return sequence;
}

// Namespace plannergenericcommander/planner_generic_commander
// Params 1, eflags: 0x0
// Checksum 0xcaa1f1bc, Offset: 0x19b0
// Size: 0x240
function function_ee3485ef(parent) {
    /#
        assert(isstruct(parent));
    #/
    sequence = planner::addsequence(parent);
    planner::addpostcondition(sequence, "commanderSetBlackboardValue", associativearray("name", "pathing_current_gameobject_index", "value", 0));
    planner::addpostcondition(sequence, "commanderSetBlackboardValue", associativearray("name", "pathing_calculated_gameobjects", "value", array()));
    selector = planner::addselector(sequence);
    var_7fdba5d2 = planner::addsequence(selector);
    planner::addprecondition(var_7fdba5d2, "commanderPathingHasUnprocessedGameobjects");
    planner::addaction(var_7fdba5d2, "commanderPathingCalculateGameobjectRequestPoints");
    function_ebf4c8a9(var_7fdba5d2);
    planner::addaction(var_7fdba5d2, "commanderPathingCalculateGameobjectPathability");
    planner::addpostcondition(var_7fdba5d2, "commanderIncrementBlackboardValue", associativearray("name", "pathing_current_gameobject_index"));
    planner::addgoto(var_7fdba5d2, selector);
    var_7fdba5d2 = planner::addsequence(selector);
    planner::addaction(var_7fdba5d2, "commanderPathingAddToSquadCalculatedGameobjects");
    return sequence;
}

// Namespace plannergenericcommander/planner_generic_commander
// Params 1, eflags: 0x0
// Checksum 0x670f02b6, Offset: 0x1bf8
// Size: 0x240
function function_40a89dfd(parent) {
    /#
        assert(isstruct(parent));
    #/
    sequence = planner::addsequence(parent);
    planner::addpostcondition(sequence, "commanderSetBlackboardValue", associativearray("name", "pathing_current_objective_index", "value", 0));
    planner::addpostcondition(sequence, "commanderSetBlackboardValue", associativearray("name", "pathing_calculated_objectives", "value", array()));
    selector = planner::addselector(sequence);
    var_7fdba5d2 = planner::addsequence(selector);
    planner::addprecondition(var_7fdba5d2, "commanderPathingHasUnprocessedObjectives");
    planner::addaction(var_7fdba5d2, "commanderPathingCalculateObjectiveRequestPoints");
    function_ebf4c8a9(var_7fdba5d2);
    planner::addaction(var_7fdba5d2, "commanderPathingCalculateObjectivePathability");
    planner::addpostcondition(var_7fdba5d2, "commanderIncrementBlackboardValue", associativearray("name", "pathing_current_objective_index"));
    planner::addgoto(var_7fdba5d2, selector);
    var_7fdba5d2 = planner::addsequence(selector);
    planner::addaction(var_7fdba5d2, "commanderPathingAddToSquadCalculatedObjectives");
    return sequence;
}

// Namespace plannergenericcommander/planner_generic_commander
// Params 1, eflags: 0x0
// Checksum 0x5f811b5e, Offset: 0x1e40
// Size: 0x2e0
function function_ebf4c8a9(parent) {
    /#
        assert(isstruct(parent));
    #/
    sequence = planner::addsequence(parent);
    planner::addpostcondition(sequence, "commanderSetBlackboardValue", associativearray("name", "pathing_current_bot_index", "value", 0));
    planner::addpostcondition(sequence, "commanderSetBlackboardValue", associativearray("name", "pathing_current_point_index", "value", 0));
    planner::addpostcondition(sequence, "commanderSetBlackboardValue", associativearray("name", "pathing_calculated_paths", "value", array()));
    selector = planner::addselector(sequence);
    var_7fdba5d2 = planner::addsequence(selector);
    planner::addprecondition(var_7fdba5d2, "commanderPathingHasNoRequestPoints");
    var_7fdba5d2 = planner::addsequence(selector);
    planner::addprecondition(var_7fdba5d2, "commanderPathingHasCalculatedPathablePath");
    var_7fdba5d2 = planner::addsequence(selector);
    planner::addprecondition(var_7fdba5d2, "commanderPathingHasUnreachablePath");
    planner::addpostcondition(var_7fdba5d2, "commanderSetBlackboardValue", associativearray("name", "pathing_calculated_paths", "value", array()));
    var_7fdba5d2 = planner::addsequence(selector);
    planner::addprecondition(var_7fdba5d2, "commanderPathingHasUnprocessedRequestPoints");
    planner::addaction(var_7fdba5d2, "commanderPathingCalculatePathToRequestedPoints");
    planner::addgoto(var_7fdba5d2, selector);
    return sequence;
}

// Namespace plannergenericcommander/planner_generic_commander
// Params 1, eflags: 0x0
// Checksum 0x7a97086c, Offset: 0x2128
// Size: 0x1a8
function function_9d26171f(parent) {
    /#
        assert(isstruct(parent));
    #/
    sequence = planner::addsequence(parent);
    planner::addprecondition(sequence, "commanderHasAtLeastXUnassignedBots", associativearray("amount", 1));
    planner::addprecondition(sequence, "commanderHasAtLeastXObjectives", associativearray("amount", 1));
    planner::addaction(sequence, "commanderSquadCreateOfSizeX", associativearray("amount", 1));
    planner::addaction(sequence, "commanderPathingAddObjectives");
    planner::addaction(sequence, "commanderPathingAddSquadBots");
    var_7fdba5d2 = function_40a89dfd(sequence);
    planner::addprecondition(sequence, "commanderSquadHasPathableObjective");
    planner::addaction(sequence, "commanderSquadAssignPathableObjective");
    return sequence;
}

// Namespace plannergenericcommander/planner_generic_commander
// Params 1, eflags: 0x0
// Checksum 0x51b32cc4, Offset: 0x22d8
// Size: 0x290
function function_1cf28baa(parent) {
    /#
        assert(isstruct(parent));
    #/
    sequence = planner::addsequence(parent);
    planner::addprecondition(sequence, "commanderHasAtLeastXUnassignedBots", associativearray("amount", 1));
    planner::addprecondition(sequence, "commanderHasAtLeastXUnclaimedPriorityDefendObjects", associativearray("amount", 1));
    planner::addaction(sequence, "commanderSquadCreateOfSizeX", associativearray("amount", 1));
    planner::addaction(sequence, "commanderPathingAddDefendGameobjects");
    planner::addaction(sequence, "commanderPathingAddSquadBots");
    var_7fdba5d2 = function_ee3485ef(sequence);
    planner::addprecondition(sequence, "commanderSquadHasPathableObject");
    planner::addaction(sequence, "commanderSquadOrder", associativearray("order", "order_defend"));
    selector = planner::addselector(sequence);
    var_7fdba5d2 = planner::addsequence(selector);
    planner::addprecondition(var_7fdba5d2, "commanderSquadHasPathableUnclaimedObject");
    planner::addaction(var_7fdba5d2, "commanderSquadAssignPathableUnclaimedObject");
    planner::addaction(var_7fdba5d2, "commanderSquadClaimObject");
    var_7fdba5d2 = planner::addsequence(selector);
    planner::addaction(var_7fdba5d2, "commanderSquadAssignPathableObject");
    return sequence;
}

// Namespace plannergenericcommander/planner_generic_commander
// Params 1, eflags: 0x0
// Checksum 0xacffa6f3, Offset: 0x2570
// Size: 0x1cc
function function_8ad0227e(parent) {
    /#
        assert(isstruct(parent));
    #/
    selector = planner::addselector(parent);
    sequence = planner::addsequence(selector);
    planner::addprecondition(sequence, "commanderShouldRushProgress");
    var_7fdba5d2 = function_3eac1247(sequence);
    planner::addaction(var_7fdba5d2, "commanderSquadOrder", associativearray("order", "order_attack_rush"));
    sequence = planner::addsequence(selector);
    planner::addprecondition(sequence, "commanderShouldThrottleProgress");
    var_3a99aa02 = planner::addselector(sequence);
    var_7fdba5d2 = function_3eac1247(var_3a99aa02);
    planner::addaction(var_7fdba5d2, "commanderSquadOrder", associativearray("order", "order_attack_surround"));
    var_7fdba5d2 = function_823fd55f(var_3a99aa02);
    return sequence;
}

// Namespace plannergenericcommander/planner_generic_commander
// Params 1, eflags: 0x0
// Checksum 0x77d7fbb7, Offset: 0x2748
// Size: 0x13c
function commanderutilityevaluators(commander) {
    /#
        assert(isstruct(commander));
    #/
    plannercommanderutility::addsquadevaluator(commander, "commanderScoreBotPresence");
    plannercommanderutility::addsquadevaluator(commander, "commanderScoreEscortPathing");
    plannercommanderutility::addsquadevaluator(commander, "commanderScoreForceGoal");
    plannercommanderutility::addsquadevaluator(commander, "commanderScoreGameobjectsValidity");
    plannercommanderutility::addsquadevaluator(commander, "commanderScoreGameobjectPathing");
    plannercommanderutility::addsquadevaluator(commander, "commanderScoreNoEscortOrGameobject");
    plannercommanderutility::addsquadevaluator(commander, "commanderScoreViableEscort");
    plannercommanderutility::addsquadevaluator(commander, "commanderScoreProgressThrottling");
}

// Namespace plannergenericcommander/planner_generic_commander
// Params 1, eflags: 0x0
// Checksum 0x640e93b9, Offset: 0x2890
// Size: 0x128
function function_823fd55f(parent) {
    /#
        assert(isstruct(parent));
    #/
    sequence = planner::addsequence(parent);
    planner::addprecondition(sequence, "commanderHasAtLeastXUnassignedBots", associativearray("amount", 1));
    planner::addaction(sequence, "commanderSquadCreateOfSizeX", associativearray("amount", 1));
    planner::addaction(sequence, "commanderSquadAssignWander");
    planner::addaction(sequence, "commanderSquadOrder", associativearray("order", "order_wander"));
    return sequence;
}

