#using scripts/core_common/ai/planner_commander;
#using scripts/core_common/ai/planner_commander_utility;
#using scripts/core_common/ai/planner_generic_commander;
#using scripts/core_common/ai/planner_generic_squad;
#using scripts/core_common/ai/planner_squad_utility;
#using scripts/core_common/ai/systems/blackboard;
#using scripts/core_common/ai/systems/planner;

#namespace plannerblackmarketconvoy;

// Namespace plannerblackmarketconvoy/planner_black_market_convoy
// Params 0, eflags: 0x2
// Checksum 0x1d0a4e28, Offset: 0x300
// Size: 0x2c
function autoexec main() {
    plannercommanderutility::registerdaemonapi("daemonObstructions", &_updateobstructiondaemon);
}

// Namespace plannerblackmarketconvoy/planner_black_market_convoy
// Params 1, eflags: 0x4
// Checksum 0xcd2472c5, Offset: 0x338
// Size: 0x170
function private _createcommanderplanner(team) {
    planner = planner::createplanner("commanderDataEscape");
    sequence = plannergenericcommander::commanderforcegoalstrategy(planner);
    planner::addgoto(sequence, planner);
    sequence = plannergenericcommander::commanderassaultsquadstrategy(planner);
    planner::addgoto(sequence, planner);
    sequence = plannergenericcommander::commanderdefendsquadstrategy(planner);
    planner::addgoto(sequence, planner);
    sequence = plannergenericcommander::commanderobjectivesquadstrategy(planner);
    planner::addgoto(sequence, planner);
    sequence = plannergenericcommander::commanderwandersquadstrategy(planner);
    planner::addgoto(sequence, planner);
    planner::addaction(planner, "commanderEndPlan");
    return planner;
}

// Namespace plannerblackmarketconvoy/planner_black_market_convoy
// Params 1, eflags: 0x4
// Checksum 0x8110b0ef, Offset: 0x4b0
// Size: 0xb8
function private _createsquadplanner(team) {
    planner = planner::createplanner("squadDataEscape");
    sequence = plannergenericsquad::squadseekammocache(planner);
    sequence = plannergenericsquad::squadassaultstrategy(planner);
    sequence = plannergenericsquad::squaddefendstrategy(planner);
    sequence = plannergenericsquad::squadmovetoobjectivestrategy(planner);
    planner::addaction(planner, "squadWander");
    return planner;
}

// Namespace plannerblackmarketconvoy/planner_black_market_convoy
// Params 1, eflags: 0x4
// Checksum 0xb898f0d7, Offset: 0x570
// Size: 0x25c
function private _updateobstructiondaemon(commander) {
    if (!isdefined(level.vh_escort)) {
        return;
    }
    ignoredistance = 1024 * 1024;
    obstructions = associativearray("obstruction_1", 0, "obstruction_2", 0, "obstruction_3", 0);
    exclude = [];
    foreach (gameobject in level.a_gameobjects) {
        if (isdefined(gameobject.identifier) && isdefined(obstructions[gameobject.identifier])) {
            obstructions[gameobject.identifier] = 1;
            if (distance2dsquared(level.vh_escort.origin, gameobject.origin) >= ignoredistance) {
                exclude[exclude.size] = gameobject.identifier;
            }
        }
    }
    foreach (obstruction, found in obstructions) {
        if (!found) {
            exclude[exclude.size] = obstruction;
        }
    }
    if (exclude.size < obstructions.size) {
        exclude[exclude.size] = "siegebot";
    }
    blackboard::setstructblackboardattribute(commander, "gameobjects_exclude", exclude);
}

// Namespace plannerblackmarketconvoy/planner_black_market_convoy
// Params 0, eflags: 0x0
// Checksum 0x2ce44728, Offset: 0x7d8
// Size: 0x1b8
function createalliescommander() {
    team = "allies";
    commander = plannercommanderutility::createcommander(team, _createcommanderplanner(team), _createsquadplanner(team));
    blackboard::setstructblackboardattribute(commander, "gameobjects_priority", array("vip_convoy", "obstruction_1", "obstruction_2", "obstruction_3", "vehicle_reboot"));
    blackboard::setstructblackboardattribute(commander, "gameobjects_force_attack", array("vip_convoy", "siegebot"));
    plannergenericcommander::commanderdaemons(commander);
    plannercommanderutility::adddaemon(commander, "daemonObstructions");
    plannergenericcommander::commanderutilityevaluators(commander);
    plannercommanderutility::addsquadevaluator(commander, "commanderScoreGameobjectPriority", associativearray("priority", array("vip_convoy", "obstruction_1", "obstruction_2", "obstruction_3", "vehicle_reboot")));
    return commander;
}

// Namespace plannerblackmarketconvoy/planner_black_market_convoy
// Params 0, eflags: 0x0
// Checksum 0xdbc83311, Offset: 0x998
// Size: 0x1b8
function createaxiscommander() {
    team = "axis";
    commander = plannercommanderutility::createcommander(team, _createcommanderplanner(team), _createsquadplanner(team));
    blackboard::setstructblackboardattribute(commander, "gameobjects_priority", array("vip_convoy", "obstruction_1", "obstruction_2", "obstruction_3", "vehicle_reboot"));
    blackboard::setstructblackboardattribute(commander, "gameobjects_force_attack", array("vip_convoy", "siegebot"));
    plannergenericcommander::commanderdaemons(commander);
    plannercommanderutility::adddaemon(commander, "daemonObstructions");
    plannergenericcommander::commanderutilityevaluators(commander);
    plannercommanderutility::addsquadevaluator(commander, "commanderScoreGameobjectPriority", associativearray("priority", array("vip_convoy", "obstruction_1", "obstruction_2", "obstruction_3", "vehicle_reboot")));
    return commander;
}

