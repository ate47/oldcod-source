#using scripts/core_common/ai/planner_commander;
#using scripts/core_common/ai/planner_commander_utility;
#using scripts/core_common/ai/planner_generic_commander;
#using scripts/core_common/ai/planner_generic_squad;
#using scripts/core_common/ai/planner_squad_utility;
#using scripts/core_common/ai/systems/blackboard;
#using scripts/core_common/ai/systems/planner;

#namespace namespace_7385a892;

// Namespace namespace_7385a892/namespace_6527246c
// Params 1, eflags: 0x4
// Checksum 0xf1b19418, Offset: 0x388
// Size: 0x1e0
function private _createcommanderplanner(team) {
    planner = planner::createplanner("commanderDataEscape");
    sequence = plannergenericcommander::function_96caab78(planner);
    planner::addgoto(sequence, planner);
    sequence = plannergenericcommander::function_900bce7e(planner);
    planner::addgoto(sequence, planner);
    sequence = plannergenericcommander::function_8ad0227e(planner);
    planner::addgoto(sequence, planner);
    sequence = plannergenericcommander::function_3eac1247(planner);
    planner::addgoto(sequence, planner);
    sequence = plannergenericcommander::function_ec4dcfc2(planner);
    planner::addgoto(sequence, planner);
    sequence = plannergenericcommander::function_9d26171f(planner);
    planner::addgoto(sequence, planner);
    sequence = plannergenericcommander::function_823fd55f(planner);
    planner::addgoto(sequence, planner);
    planner::addaction(planner, "commanderEndPlan");
    return planner;
}

// Namespace namespace_7385a892/namespace_6527246c
// Params 1, eflags: 0x4
// Checksum 0x6f12f0bf, Offset: 0x570
// Size: 0xd0
function private _createsquadplanner(team) {
    planner = planner::createplanner("squadDataEscape");
    sequence = namespace_ff4ab724::function_44b382a7(planner);
    sequence = namespace_ff4ab724::function_c55f60e5(planner);
    sequence = namespace_ff4ab724::function_8d586a9e(planner);
    sequence = namespace_ff4ab724::function_a59be1a2(planner);
    sequence = namespace_ff4ab724::function_fe51b831(planner);
    planner::addaction(planner, "squadWander");
    return planner;
}

// Namespace namespace_7385a892/namespace_6527246c
// Params 0, eflags: 0x0
// Checksum 0x4cd57094, Offset: 0x648
// Size: 0x138
function function_74f32e07() {
    team = "allies";
    commander = plannercommanderutility::createcommander(team, _createcommanderplanner(team), _createsquadplanner(team));
    blackboard::setstructblackboardattribute(commander, "gameobjects_exclude", array("carry_object", "hijack_vehicle", "bolster_forces", "security_wall_axis_0", "security_wall_axis_1", "security_wall_axis_2", "security_wall_axis_3"));
    blackboard::setstructblackboardattribute(commander, "gameobjects_force_attack", array("security_wall", "vehicle_vtol"));
    plannergenericcommander::commanderdaemons(commander);
    plannergenericcommander::commanderutilityevaluators(commander);
    return commander;
}

// Namespace namespace_7385a892/namespace_6527246c
// Params 0, eflags: 0x0
// Checksum 0xda72c9ce, Offset: 0x788
// Size: 0x1b0
function function_deecc0c0() {
    team = "axis";
    commander = plannercommanderutility::createcommander(team, _createcommanderplanner(team), _createsquadplanner(team));
    blackboard::setstructblackboardattribute(commander, "gameobjects_exclude", array("hijack_vehicle", "bolster_forces", "security_wall_allies_0", "security_wall_allies_1", "security_wall_allies_2", "security_wall_allies_3"));
    blackboard::setstructblackboardattribute(commander, "gameobjects_force_attack", array("security_wall", "vehicle_vtol"));
    blackboard::setstructblackboardattribute(commander, "gameobjects_priority", array("carry_object"));
    plannercommanderutility::addsquadevaluator(commander, "commanderScoreGameobjectPriority", associativearray("priority", array("carry_object")));
    plannergenericcommander::commanderdaemons(commander);
    plannergenericcommander::commanderutilityevaluators(commander);
    return commander;
}

