#using scripts\core_common\ai_shared;
#using scripts\core_common\system_shared;

#namespace zm_ai_utility;

// Namespace zm_ai_utility/zm_ai_utility
// Params 0, eflags: 0x6
// Checksum 0x95c391bd, Offset: 0x70
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_ai_utility", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 0, eflags: 0x5 linked
// Checksum 0x31ed9d16, Offset: 0xb8
// Size: 0x24
function private function_70a657d8() {
    ai::add_ai_spawn_function(&function_f3a051c6);
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 1, eflags: 0x5 linked
// Checksum 0xb9153c52, Offset: 0xe8
// Size: 0xc
function private function_f3a051c6(*localclientnum) {
    
}

