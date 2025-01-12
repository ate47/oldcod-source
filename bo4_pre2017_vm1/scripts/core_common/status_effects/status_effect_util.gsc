#using scripts/core_common/struct;
#using scripts/core_common/util_shared;

#namespace status_effect;

// Namespace status_effect/status_effect_util
// Params 1, eflags: 0x0
// Checksum 0x7d041101, Offset: 0xd8
// Size: 0x88
function register_status_effect(status_effect) {
    if (!isdefined(level._status_effects)) {
        level._status_effects = [];
    }
    if (!isdefined(level._status_effects[status_effect])) {
        level._status_effects[status_effect] = spawnstruct();
        level._status_effects[status_effect].index = status_effect;
    }
}

// Namespace status_effect/status_effect_util
// Params 2, eflags: 0x0
// Checksum 0x1cc5dbbf, Offset: 0x168
// Size: 0x58
function function_9acf95a1(status_effect, name) {
    register_status_effect(status_effect);
    if (isdefined(name)) {
        level._status_effects[status_effect].name = name;
    }
}

// Namespace status_effect/status_effect_util
// Params 2, eflags: 0x0
// Checksum 0x66e679df, Offset: 0x1c8
// Size: 0x68
function function_96de5b5e(status_effect, baseduration) {
    register_status_effect(status_effect);
    if (isdefined(baseduration)) {
        level._status_effects[status_effect].baseduration = int(baseduration);
    }
}

// Namespace status_effect/status_effect_util
// Params 2, eflags: 0x0
// Checksum 0xcbc8ef7e, Offset: 0x238
// Size: 0x58
function register_status_effect_callback_apply(status_effect, apply_func) {
    register_status_effect(status_effect);
    if (isdefined(apply_func)) {
        level._status_effects[status_effect].apply = apply_func;
    }
}

// Namespace status_effect/status_effect_util
// Params 1, eflags: 0x0
// Checksum 0x8d2ab3c6, Offset: 0x298
// Size: 0xcc
function function_f5daed9(name) {
    if (isdefined(level._status_effects)) {
        foreach (effect in level._status_effects) {
            if (isdefined(effect.name) && effect.name == name) {
                return effect.index;
            }
        }
    }
    return undefined;
}

// Namespace status_effect/status_effect_util
// Params 1, eflags: 0x0
// Checksum 0xc98d04ad, Offset: 0x370
// Size: 0xe0
function status_effect_apply(status_effect) {
    register_status_effect(status_effect);
    if (isdefined(level._status_effects[status_effect].baseduration)) {
        self applystatuseffect(status_effect, level._status_effects[status_effect].baseduration);
    } else {
        self applystatuseffect(status_effect);
    }
    if (isdefined(level._status_effects[status_effect].apply)) {
        self thread [[ level._status_effects[status_effect].apply ]]();
    }
}

// Namespace status_effect/status_effect_util
// Params 1, eflags: 0x0
// Checksum 0x8f6fa76d, Offset: 0x458
// Size: 0x34
function function_24365fad(status_effect) {
    isactive = self isstatuseffectactive(status_effect);
    return isactive;
}

// Namespace status_effect/status_effect_util
// Params 1, eflags: 0x0
// Checksum 0x95974b59, Offset: 0x498
// Size: 0x34
function status_effect_get_duration(status_effect) {
    duration = self getstatuseffectduration(status_effect);
    return duration;
}

// Namespace status_effect/status_effect_util
// Params 1, eflags: 0x0
// Checksum 0xca505a70, Offset: 0x4d8
// Size: 0x34
function function_c9de0b56(status_effect) {
    starttime = self getstatuseffectstarttime(status_effect);
    return starttime;
}

