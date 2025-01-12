#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;

#namespace status_effect_movement_speed;

// Namespace status_effect_movement_speed/status_effect_movement_speed
// Params 0, eflags: 0x2
// Checksum 0x4b6bd04d, Offset: 0x88
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"status_effect_movement_speed", &__init__, undefined, undefined);
}

// Namespace status_effect_movement_speed/status_effect_movement_speed
// Params 0, eflags: 0x0
// Checksum 0x127a108f, Offset: 0xd0
// Size: 0x2c
function __init__() {
    status_effect::function_5cf962b4(getstatuseffect("movement"));
}

