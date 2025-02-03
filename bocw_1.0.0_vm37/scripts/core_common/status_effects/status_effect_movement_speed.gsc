#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;

#namespace status_effect_movement_speed;

// Namespace status_effect_movement_speed/status_effect_movement_speed
// Params 0, eflags: 0x6
// Checksum 0x5d1b5a76, Offset: 0x80
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"status_effect_movement_speed", &preinit, undefined, undefined, undefined);
}

// Namespace status_effect_movement_speed/status_effect_movement_speed
// Params 0, eflags: 0x4
// Checksum 0xd64e9a21, Offset: 0xc8
// Size: 0x4c
function private preinit() {
    status_effect::function_6f4eaf88(getstatuseffect("movement"));
    status_effect::function_5bae5120(8, &function_f7e9c0bb);
}

// Namespace status_effect_movement_speed/status_effect_movement_speed
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x120
// Size: 0x4
function function_f7e9c0bb() {
    
}

