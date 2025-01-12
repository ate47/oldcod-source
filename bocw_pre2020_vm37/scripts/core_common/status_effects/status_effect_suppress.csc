#using scripts\core_common\serverfield_shared;
#using scripts\core_common\system_shared;

#namespace status_effect_suppress;

// Namespace status_effect_suppress/status_effect_suppress
// Params 0, eflags: 0x6
// Checksum 0x8afa6b31, Offset: 0x98
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"status_effect_suppress", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace status_effect_suppress/status_effect_suppress
// Params 0, eflags: 0x5 linked
// Checksum 0xe1baa8c5, Offset: 0xe0
// Size: 0x2c
function private function_70a657d8() {
    serverfield::register("status_effect_suppress_field", 1, 5, "int");
}

