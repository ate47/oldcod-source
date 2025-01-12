#using scripts/core_common/status_effects/status_effect_util;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace status_effect_slowed;

// Namespace status_effect_slowed/status_effect_slowed
// Params 0, eflags: 0x2
// Checksum 0xdce1270e, Offset: 0x158
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("status_effect_slowed", &__init__, undefined, undefined);
}

// Namespace status_effect_slowed/status_effect_slowed
// Params 0, eflags: 0x0
// Checksum 0xcc6463ca, Offset: 0x198
// Size: 0x44
function __init__() {
    status_effect::register_status_effect_callback_apply(0, &slowed_apply);
    status_effect::function_9acf95a1(0, "slowed");
}

// Namespace status_effect_slowed/status_effect_slowed
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x1e8
// Size: 0x4
function slowed_apply() {
    
}

