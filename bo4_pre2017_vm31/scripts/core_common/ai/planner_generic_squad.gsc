#using scripts/core_common/ai/planner_commander;
#using scripts/core_common/ai/planner_commander_utility;
#using scripts/core_common/ai/planner_squad_utility;
#using scripts/core_common/ai/systems/planner;

#namespace plannergenericsquad;

// Namespace plannergenericsquad/planner_generic_squad
// Params 1, eflags: 0x0
// Checksum 0xf8a2a867, Offset: 0x300
// Size: 0x164
function squadassaultstrategy(parent) {
    assert(isstruct(parent));
    sequence = planner::addsequence(parent);
    planner::addprecondition(sequence, "squadHasAttackObject");
    selector = planner::addselector(sequence);
    sequenceinner = planner::addsequence(selector);
    planner::addprecondition(sequenceinner, "squadHasBlackboardValue", associativearray("name", "order", "value", "order_attack_rush"));
    planner::addaction(sequenceinner, "squadRushAttackObject");
    sequenceinner = planner::addsequence(selector);
    planner::addaction(sequenceinner, "squadClearAreaToAttackObject");
}

// Namespace plannergenericsquad/planner_generic_squad
// Params 1, eflags: 0x0
// Checksum 0xe0c6e3a9, Offset: 0x470
// Size: 0x1c8
function squadseekammocache(parent) {
    assert(isstruct(parent));
    selector = planner::addselector(parent);
    sequence = planner::addsequence(selector);
    planner::addprecondition(sequence, "squadHasBelowXAmmo", associativearray("percent", 0.2));
    planner::addaction(sequence, "squadRushCloserThanXAmmoCache", associativearray("distance", 1024));
    planner::addprecondition(sequence, "squadHasPathableAmmoCache");
    sequence = planner::addsequence(selector);
    planner::addprecondition(sequence, "squadHasBelowXAmmo", associativearray("percent", 0.05));
    planner::addaction(sequence, "squadRushCloserThanXAmmoCache", associativearray("distance", 2048));
    planner::addprecondition(sequence, "squadHasPathableAmmoCache");
    return sequence;
}

// Namespace plannergenericsquad/planner_generic_squad
// Params 1, eflags: 0x0
// Checksum 0x2fadf8e2, Offset: 0x640
// Size: 0xa0
function squaddefendstrategy(parent) {
    assert(isstruct(parent));
    sequence = planner::addsequence(parent);
    planner::addprecondition(sequence, "squadHasDefendObject");
    planner::addaction(sequence, "squadClearAreaToDefendObject");
    return sequence;
}

// Namespace plannergenericsquad/planner_generic_squad
// Params 1, eflags: 0x0
// Checksum 0x64df6d17, Offset: 0x6e8
// Size: 0x130
function squadescortstrategy(parent) {
    assert(isstruct(parent));
    sequence = planner::addsequence(parent);
    planner::addprecondition(sequence, "squadHasEscort");
    selector = planner::addselector(sequence);
    sequence = planner::addsequence(selector);
    planner::addprecondition(sequence, "squadHasEscortPOI");
    planner::addaction(sequence, "squadClearAreaToGoldenPath");
    sequence = planner::addsequence(selector);
    planner::addaction(sequence, "squadClearAreaToEscort");
    return sequence;
}

// Namespace plannergenericsquad/planner_generic_squad
// Params 1, eflags: 0x0
// Checksum 0x2dd80579, Offset: 0x820
// Size: 0xa0
function squadforcegoalstrategy(parent) {
    assert(isstruct(parent));
    sequence = planner::addsequence(parent);
    planner::addprecondition(sequence, "squadHasForceGoal");
    planner::addaction(sequence, "squadRushForceGoal");
    return sequence;
}

// Namespace plannergenericsquad/planner_generic_squad
// Params 1, eflags: 0x0
// Checksum 0x1cded93d, Offset: 0x8c8
// Size: 0xa0
function squadmovetoobjectivestrategy(parent) {
    assert(isstruct(parent));
    sequence = planner::addsequence(parent);
    planner::addprecondition(sequence, "squadHasObjective");
    planner::addaction(sequence, "squadClearAreaToObjective");
    return sequence;
}

