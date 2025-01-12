#using scripts/core_common/ai/planner_commander;
#using scripts/core_common/ai/planner_commander_utility;
#using scripts/core_common/ai/planner_generic_commander;
#using scripts/core_common/ai/planner_generic_squad;
#using scripts/core_common/ai/planner_squad_utility;
#using scripts/core_common/ai/systems/blackboard;
#using scripts/core_common/ai/systems/planner;

#namespace plannerescort;

// Namespace plannerescort/planner_escort
// Params 0, eflags: 0x2
// Checksum 0x4363de54, Offset: 0x2b8
// Size: 0x2c
function autoexec main() {
    plannercommanderutility::registerdaemonapi("daemonObstructions", &_updateobstructiondaemon);
}

// Namespace plannerescort/planner_escort
// Params 1, eflags: 0x4
// Checksum 0xbb13697c, Offset: 0x2f0
// Size: 0x100
function private _createcommanderplanner(team) {
    planner = planner::createplanner("commanderSabotage");
    sequence = plannergenericcommander::commanderassaultsquadstrategy(planner);
    planner::addgoto(sequence, planner);
    sequence = plannergenericcommander::commanderdefendsquadstrategy(planner);
    planner::addgoto(sequence, planner);
    sequence = plannergenericcommander::commanderwandersquadstrategy(planner);
    planner::addgoto(sequence, planner);
    planner::addaction(planner, "commanderEndPlan");
    return planner;
}

// Namespace plannerescort/planner_escort
// Params 1, eflags: 0x4
// Checksum 0x92a78bed, Offset: 0x3f8
// Size: 0xb8
function private _createsquadplanner(team) {
    planner = planner::createplanner("squadSabotage");
    sequence = plannergenericsquad::squadseekammocache(planner);
    sequence = plannergenericsquad::squadassaultstrategy(planner);
    sequence = plannergenericsquad::squaddefendstrategy(planner);
    sequence = plannergenericsquad::squadmovetoobjectivestrategy(planner);
    planner::addaction(planner, "squadWander");
    return planner;
}

// Namespace plannerescort/planner_escort
// Params 1, eflags: 0x4
// Checksum 0x58eb2335, Offset: 0x4b8
// Size: 0x1c4
function private _updateobstructiondaemon(commander) {
    ignoredistance = 1024 * 1024;
    obstructions = array("obstr_1", "obstr_2");
    siegebot = level.veh_siegebot;
    exclude = [];
    foreach (obstructionname in obstructions) {
        obstruction = getent(obstructionname, "targetname");
        if (isdefined(siegebot) && isdefined(obstruction)) {
            if (distance2dsquared(siegebot.origin, obstruction.origin) >= ignoredistance) {
                exclude[exclude.size] = obstructionname;
            }
            continue;
        }
        exclude[exclude.size] = obstructionname;
    }
    if (exclude.size < obstructions.size) {
        exclude[exclude.size] = "siegebot";
    }
    blackboard::setstructblackboardattribute(commander, "gameobjects_exclude", exclude);
}

// Namespace plannerescort/planner_escort
// Params 0, eflags: 0x0
// Checksum 0xfe42c593, Offset: 0x688
// Size: 0x160
function createalliescommander() {
    team = "allies";
    commander = plannercommanderutility::createcommander(team, _createcommanderplanner(team), _createsquadplanner(team));
    blackboard::setstructblackboardattribute(commander, "gameobjects_priority", array("obstr_1", "obstr_2", "siegebot_reboot"));
    plannergenericcommander::commanderdaemons(commander);
    plannercommanderutility::adddaemon(commander, "daemonObstructions");
    plannergenericcommander::commanderutilityevaluators(commander);
    plannercommanderutility::addsquadevaluator(commander, "commanderScoreGameobjectPriority", associativearray("priority", array("obstr_1", "obstr_2", "siegebot_reboot")));
    return commander;
}

// Namespace plannerescort/planner_escort
// Params 0, eflags: 0x0
// Checksum 0x3c4abc5, Offset: 0x7f0
// Size: 0x128
function createaxiscommander() {
    team = "axis";
    commander = plannercommanderutility::createcommander(team, _createcommanderplanner(team), _createsquadplanner(team));
    blackboard::setstructblackboardattribute(commander, "gameobjects_exclude", array("obstr_1", "obstr_2"));
    plannergenericcommander::commanderdaemons(commander);
    plannergenericcommander::commanderutilityevaluators(commander);
    plannercommanderutility::addsquadevaluator(commander, "commanderScoreGameobjectPriority", associativearray("priority", array("siegebot_reboot")));
    return commander;
}

