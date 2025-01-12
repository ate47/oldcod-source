#using scripts/core_common/status_effects/status_effect_util;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace namespace_d490d367;

// Namespace namespace_d490d367/namespace_d490d367
// Params 0, eflags: 0x2
// Checksum 0x1bf20866, Offset: 0x150
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("status_effect_burn", &__init__, undefined, undefined);
}

// Namespace namespace_d490d367/namespace_d490d367
// Params 0, eflags: 0x0
// Checksum 0x2e6e1d34, Offset: 0x190
// Size: 0x44
function __init__() {
    status_effect::register_status_effect_callback_apply(5, &function_4e4e0657);
    status_effect::function_9acf95a1(5, "burn");
}

// Namespace namespace_d490d367/namespace_d490d367
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x1e0
// Size: 0x4
function function_4e4e0657() {
    
}

