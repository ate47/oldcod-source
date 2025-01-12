#using scripts\core_common\ai\systems\fx_character;
#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_9f3d3e9;

// Namespace namespace_9f3d3e9/namespace_9f3d3e9
// Params 0, eflags: 0x6
// Checksum 0x7c2538c2, Offset: 0x88
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"wz_ai_avogadro", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_9f3d3e9/namespace_9f3d3e9
// Params 0, eflags: 0x0
// Checksum 0xa7faabd6, Offset: 0xd0
// Size: 0x34
function function_70a657d8() {
    ai::add_archetype_spawn_function(#"avogadro", &function_1caf705e);
}

// Namespace namespace_9f3d3e9/namespace_9f3d3e9
// Params 1, eflags: 0x4
// Checksum 0xb9cd1583, Offset: 0x110
// Size: 0x24
function private function_1caf705e(*localclientnum) {
    self enableonradar();
}

