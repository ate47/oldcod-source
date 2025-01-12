#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace spawner;

// Namespace spawner/spawner_shared
// Params 0, eflags: 0x6
// Checksum 0x5737ae40, Offset: 0x70
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"spawner", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace spawner/spawner_shared
// Params 0, eflags: 0x5 linked
// Checksum 0x80f724d1, Offset: 0xb8
// Size: 0x4
function private function_70a657d8() {
    
}

