#using scripts/core_common/status_effects/status_effect_util;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace status_effect_poison;

// Namespace status_effect_poison/status_effect_poison
// Params 0, eflags: 0x2
// Checksum 0xb15ec799, Offset: 0x158
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("status_effect_poison", &__init__, undefined, undefined);
}

// Namespace status_effect_poison/status_effect_poison
// Params 0, eflags: 0x0
// Checksum 0xb8276b7a, Offset: 0x198
// Size: 0x44
function __init__() {
    status_effect::register_status_effect_callback_apply(6, &poison_apply);
    status_effect::register_status_effect_name(6, "poison");
}

// Namespace status_effect_poison/status_effect_poison
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x1e8
// Size: 0x4
function poison_apply() {
    
}

