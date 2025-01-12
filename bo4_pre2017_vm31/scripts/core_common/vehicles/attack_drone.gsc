#using scripts/core_common/math_shared;
#using scripts/core_common/statemachine_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/vehicle_ai_shared;
#using scripts/core_common/vehicle_death_shared;
#using scripts/core_common/vehicle_shared;

#namespace attack_drone;

// Namespace attack_drone/attack_drone
// Params 0, eflags: 0x2
// Checksum 0x2a3335d1, Offset: 0x1d0
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("attack_drone", &__init__, undefined, undefined);
}

// Namespace attack_drone/attack_drone
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x210
// Size: 0x4
function __init__() {
    
}

