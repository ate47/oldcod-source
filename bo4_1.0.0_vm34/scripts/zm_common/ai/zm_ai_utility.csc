#using scripts\core_common\ai_shared;
#using scripts\core_common\system_shared;

#namespace zm_ai_utility;

// Namespace zm_ai_utility/zm_ai_utility
// Params 0, eflags: 0x2
// Checksum 0x4e6f6866, Offset: 0x78
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_ai_utility", &__init__, undefined, undefined);
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 0, eflags: 0x4
// Checksum 0xbdda4bc5, Offset: 0xc0
// Size: 0x24
function private __init__() {
    ai::add_ai_spawn_function(&function_1e18325f);
}

// Namespace zm_ai_utility/zm_ai_utility
// Params 1, eflags: 0x4
// Checksum 0x24a8c74f, Offset: 0xf0
// Size: 0x24
function private function_1e18325f(localclientnum) {
    function_c8fdf81(self, -10000);
}

