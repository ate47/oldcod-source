#using scripts\core_common\callbacks_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;

#namespace status_effect_deaf;

// Namespace status_effect_deaf/status_effect_deaf
// Params 0, eflags: 0x6
// Checksum 0x12b73caf, Offset: 0x80
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"status_effect_deaf", &preinit, undefined, undefined, undefined);
}

// Namespace status_effect_deaf/status_effect_deaf
// Params 0, eflags: 0x4
// Checksum 0x340e944d, Offset: 0xc8
// Size: 0x8c
function private preinit() {
    status_effect::register_status_effect_callback_apply(0, &deaf_apply);
    status_effect::function_5bae5120(0, &function_c5189bd);
    status_effect::function_6f4eaf88(getstatuseffect("deaf"));
    callback::on_spawned(&on_player_spawned);
}

// Namespace status_effect_deaf/status_effect_deaf
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x160
// Size: 0x4
function on_player_spawned() {
    
}

// Namespace status_effect_deaf/status_effect_deaf
// Params 3, eflags: 0x0
// Checksum 0xba00a724, Offset: 0x170
// Size: 0x1c
function deaf_apply(*var_756fda07, *weapon, *applicant) {
    
}

// Namespace status_effect_deaf/status_effect_deaf
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x198
// Size: 0x4
function function_c5189bd() {
    
}

