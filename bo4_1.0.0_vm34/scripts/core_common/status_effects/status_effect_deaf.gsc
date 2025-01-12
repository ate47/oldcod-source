#using scripts\core_common\callbacks_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;

#namespace status_effect_deaf;

// Namespace status_effect_deaf/status_effect_deaf
// Params 0, eflags: 0x2
// Checksum 0xcb8f30a0, Offset: 0x88
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"status_effect_deaf", &__init__, undefined, undefined);
}

// Namespace status_effect_deaf/status_effect_deaf
// Params 0, eflags: 0x0
// Checksum 0xd55fe65a, Offset: 0xd0
// Size: 0x8c
function __init__() {
    status_effect::register_status_effect_callback_apply(0, &deaf_apply);
    status_effect::function_81221eab(0, &function_8352e8fb);
    status_effect::function_5cf962b4(getstatuseffect("deaf"));
    callback::on_spawned(&on_player_spawned);
}

// Namespace status_effect_deaf/status_effect_deaf
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x168
// Size: 0x4
function on_player_spawned() {
    
}

// Namespace status_effect_deaf/status_effect_deaf
// Params 3, eflags: 0x0
// Checksum 0x89a05d7, Offset: 0x178
// Size: 0x1c
function deaf_apply(var_adce82d2, weapon, applicant) {
    
}

// Namespace status_effect_deaf/status_effect_deaf
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x1a0
// Size: 0x4
function function_8352e8fb() {
    
}
