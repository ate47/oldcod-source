#using scripts\core_common\ai\planner_commander;

#namespace commander_util;

// Namespace commander_util/commander_util
// Params 1, eflags: 0x0
// Checksum 0xa8af26d9, Offset: 0x70
// Size: 0x9a
function function_c48843ab(team) {
    switch (team) {
    case #"allies":
        if (isdefined(level.alliescommander)) {
            plannercommanderutility::function_3c8472ea(level.alliescommander);
        }
        break;
    case #"axis":
        if (isdefined(level.axiscommander)) {
            plannercommanderutility::function_3c8472ea(level.axiscommander);
        }
        break;
    }
}

// Namespace commander_util/commander_util
// Params 1, eflags: 0x0
// Checksum 0xae6ce3a6, Offset: 0x118
// Size: 0x9a
function pause_commander(team) {
    switch (team) {
    case #"allies":
        if (isdefined(level.alliescommander)) {
            plannercommanderutility::pausecommander(level.alliescommander);
        }
        break;
    case #"axis":
        if (isdefined(level.axiscommander)) {
            plannercommanderutility::pausecommander(level.axiscommander);
        }
        break;
    }
}

