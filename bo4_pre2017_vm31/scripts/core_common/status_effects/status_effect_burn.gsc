#using scripts/core_common/status_effects/status_effect_util;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace status_effect_burn;

// Namespace status_effect_burn/status_effect_burn
// Params 0, eflags: 0x2
// Checksum 0x1bf20866, Offset: 0x150
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("status_effect_burn", &__init__, undefined, undefined);
}

// Namespace status_effect_burn/status_effect_burn
// Params 0, eflags: 0x0
// Checksum 0x2e6e1d34, Offset: 0x190
// Size: 0x44
function __init__() {
    status_effect::register_status_effect_callback_apply(5, &burn_apply);
    status_effect::register_status_effect_name(5, "burn");
}

// Namespace status_effect_burn/status_effect_burn
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x1e0
// Size: 0x4
function burn_apply() {
    
}

