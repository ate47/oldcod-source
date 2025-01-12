#using scripts\core_common\callbacks_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;

#namespace status_effect_deaf;

// Namespace status_effect_deaf/status_effect_deaf
// Params 0, eflags: 0x6
// Checksum 0xdb8fd661, Offset: 0x80
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"status_effect_deaf", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace status_effect_deaf/status_effect_deaf
// Params 0, eflags: 0x5 linked
// Checksum 0x8369ff6c, Offset: 0xc8
// Size: 0x8c
function private function_70a657d8() {
    status_effect::register_status_effect_callback_apply(0, &deaf_apply);
    status_effect::function_5bae5120(0, &function_c5189bd);
    status_effect::function_6f4eaf88(getstatuseffect("deaf"));
    callback::on_spawned(&on_player_spawned);
}

// Namespace status_effect_deaf/status_effect_deaf
// Params 0, eflags: 0x1 linked
// Checksum 0x80f724d1, Offset: 0x160
// Size: 0x4
function on_player_spawned() {
    
}

// Namespace status_effect_deaf/status_effect_deaf
// Params 3, eflags: 0x1 linked
// Checksum 0x74709f20, Offset: 0x170
// Size: 0x1c
function deaf_apply(*var_756fda07, *weapon, *applicant) {
    
}

// Namespace status_effect_deaf/status_effect_deaf
// Params 0, eflags: 0x1 linked
// Checksum 0x80f724d1, Offset: 0x198
// Size: 0x4
function function_c5189bd() {
    
}

