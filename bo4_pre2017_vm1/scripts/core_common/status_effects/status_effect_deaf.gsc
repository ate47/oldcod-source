#using scripts/core_common/status_effects/status_effect_util;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace status_effect_deaf;

// Namespace status_effect_deaf/status_effect_deaf
// Params 0, eflags: 0x2
// Checksum 0xe4ee9dfd, Offset: 0x150
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("status_effect_deaf", &__init__, undefined, undefined);
}

// Namespace status_effect_deaf/status_effect_deaf
// Params 0, eflags: 0x0
// Checksum 0xd43cc2a, Offset: 0x190
// Size: 0x44
function __init__() {
    status_effect::register_status_effect_callback_apply(2, &deaf_apply);
    status_effect::function_9acf95a1(2, "deaf");
}

// Namespace status_effect_deaf/status_effect_deaf
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x1e0
// Size: 0x4
function deaf_apply() {
    
}

