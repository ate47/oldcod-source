#using scripts/core_common/ai/planner_commander;
#using scripts/core_common/ai/planner_commander_utility;
#using scripts/core_common/ai/planner_generic_commander;
#using scripts/core_common/ai/planner_generic_squad;
#using scripts/core_common/ai/planner_squad_utility;
#using scripts/core_common/ai/systems/blackboard;
#using scripts/core_common/ai/systems/planner;

#namespace namespace_f280956f;

// Namespace namespace_f280956f/namespace_33480b62
// Params 0, eflags: 0x2
// Checksum 0x4363de54, Offset: 0x2b8
// Size: 0x2c
function autoexec main() {
    plannercommanderutility::registerdaemonapi("daemonObstructions", &function_df76832b);
}

// Namespace namespace_f280956f/namespace_33480b62
// Params 1, eflags: 0x4
// Checksum 0xbb13697c, Offset: 0x2f0
// Size: 0x100
function private _createcommanderplanner(team) {
    planner = planner::createplanner("commanderSabotage");
    sequence = plannergenericcommander::function_3eac1247(planner);
    planner::addgoto(sequence, planner);
    sequence = plannergenericcommander::function_ec4dcfc2(planner);
    planner::addgoto(sequence, planner);
    sequence = plannergenericcommander::function_823fd55f(planner);
    planner::addgoto(sequence, planner);
    planner::addaction(planner, "commanderEndPlan");
    return planner;
}

// Namespace namespace_f280956f/namespace_33480b62
// Params 1, eflags: 0x4
// Checksum 0x92a78bed, Offset: 0x3f8
// Size: 0xb8
function private _createsquadplanner(team) {
    planner = planner::createplanner("squadSabotage");
    sequence = namespace_ff4ab724::function_44b382a7(planner);
    sequence = namespace_ff4ab724::function_c55f60e5(planner);
    sequence = namespace_ff4ab724::function_8d586a9e(planner);
    sequence = namespace_ff4ab724::function_fe51b831(planner);
    planner::addaction(planner, "squadWander");
    return planner;
}

// Namespace namespace_f280956f/namespace_33480b62
// Params 1, eflags: 0x4
// Checksum 0x58eb2335, Offset: 0x4b8
// Size: 0x1c4
function private function_df76832b(commander) {
    var_1b4e4bf6 = 1024 * 1024;
    var_672a7d74 = array("obstr_1", "obstr_2");
    siegebot = level.var_417de22d;
    exclude = [];
    foreach (var_aeb253ac in var_672a7d74) {
        var_9bc7e65 = getent(var_aeb253ac, "targetname");
        if (isdefined(siegebot) && isdefined(var_9bc7e65)) {
            if (distance2dsquared(siegebot.origin, var_9bc7e65.origin) >= var_1b4e4bf6) {
                exclude[exclude.size] = var_aeb253ac;
            }
            continue;
        }
        exclude[exclude.size] = var_aeb253ac;
    }
    if (exclude.size < var_672a7d74.size) {
        exclude[exclude.size] = "siegebot";
    }
    blackboard::setstructblackboardattribute(commander, "gameobjects_exclude", exclude);
}

// Namespace namespace_f280956f/namespace_33480b62
// Params 0, eflags: 0x0
// Checksum 0xfe42c593, Offset: 0x688
// Size: 0x160
function function_74f32e07() {
    team = "allies";
    commander = plannercommanderutility::createcommander(team, _createcommanderplanner(team), _createsquadplanner(team));
    blackboard::setstructblackboardattribute(commander, "gameobjects_priority", array("obstr_1", "obstr_2", "siegebot_reboot"));
    plannergenericcommander::commanderdaemons(commander);
    plannercommanderutility::adddaemon(commander, "daemonObstructions");
    plannergenericcommander::commanderutilityevaluators(commander);
    plannercommanderutility::addsquadevaluator(commander, "commanderScoreGameobjectPriority", associativearray("priority", array("obstr_1", "obstr_2", "siegebot_reboot")));
    return commander;
}

// Namespace namespace_f280956f/namespace_33480b62
// Params 0, eflags: 0x0
// Checksum 0x3c4abc5, Offset: 0x7f0
// Size: 0x128
function function_deecc0c0() {
    team = "axis";
    commander = plannercommanderutility::createcommander(team, _createcommanderplanner(team), _createsquadplanner(team));
    blackboard::setstructblackboardattribute(commander, "gameobjects_exclude", array("obstr_1", "obstr_2"));
    plannergenericcommander::commanderdaemons(commander);
    plannergenericcommander::commanderutilityevaluators(commander);
    plannercommanderutility::addsquadevaluator(commander, "commanderScoreGameobjectPriority", associativearray("priority", array("siegebot_reboot")));
    return commander;
}

