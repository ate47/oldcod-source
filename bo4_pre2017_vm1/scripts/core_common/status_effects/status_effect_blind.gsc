#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/hud_shared;
#using scripts/core_common/status_effects/status_effect_util;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace status_effect_blind;

// Namespace status_effect_blind/status_effect_blind
// Params 0, eflags: 0x2
// Checksum 0x6e1e7324, Offset: 0x1c8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("status_effect_blind", &__init__, undefined, undefined);
}

// Namespace status_effect_blind/status_effect_blind
// Params 0, eflags: 0x0
// Checksum 0x844f8cd1, Offset: 0x208
// Size: 0x7c
function __init__() {
    status_effect::register_status_effect_callback_apply(3, &blind_apply);
    status_effect::function_9acf95a1(3, "blind");
    status_effect::function_96de5b5e(3, getscriptbundle("blind").var_804bc9d5 * 1000);
}

// Namespace status_effect_blind/status_effect_blind
// Params 0, eflags: 0x0
// Checksum 0xba7aeb9f, Offset: 0x290
// Size: 0x74
function blind_apply() {
    var_bb6d051e = getscriptbundle("blind");
    thread hud::fade_to_black_for_x_sec(0, status_effect::status_effect_get_duration(3) / 1000, var_bb6d051e.fadeintime, var_bb6d051e.fadeouttime, (1, 1, 1));
}

