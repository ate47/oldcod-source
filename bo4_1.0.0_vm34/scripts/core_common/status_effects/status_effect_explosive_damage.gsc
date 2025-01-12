#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;

#namespace status_effect_explosive_damage;

// Namespace status_effect_explosive_damage/status_effect_explosive_damage
// Params 0, eflags: 0x2
// Checksum 0xe844c16b, Offset: 0xa0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"status_effect_explosive_damage", &__init__, undefined, undefined);
}

// Namespace status_effect_explosive_damage/status_effect_explosive_damage
// Params 0, eflags: 0x0
// Checksum 0x9042ff28, Offset: 0xe8
// Size: 0x2c
function __init__() {
    status_effect::function_5cf962b4(getstatuseffect("explosive_damage"));
}
