#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace end_game_flow;

// Namespace end_game_flow/end_game_flow
// Params 0, eflags: 0x6
// Checksum 0xae3fd11c, Offset: 0x80
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"end_game_flow", &preinit, undefined, undefined, undefined);
}

// Namespace end_game_flow/end_game_flow
// Params 0, eflags: 0x4
// Checksum 0x80f724d1, Offset: 0xc8
// Size: 0x4
function private preinit() {
    
}

