#using scripts\core_common\ai_shared;
#using scripts\core_common\system_shared;

#namespace archetype_catalyst;

// Namespace archetype_catalyst/archetype_catalyst
// Params 0, eflags: 0x6
// Checksum 0x618da27d, Offset: 0x88
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"catalyst", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace archetype_catalyst/archetype_catalyst
// Params 0, eflags: 0x2
// Checksum 0x80f724d1, Offset: 0xd0
// Size: 0x4
function autoexec precache() {
    
}

// Namespace archetype_catalyst/archetype_catalyst
// Params 0, eflags: 0x5 linked
// Checksum 0x645327d4, Offset: 0xe0
// Size: 0x34
function private function_70a657d8() {
    ai::add_archetype_spawn_function(#"catalyst", &function_5608540a);
}

// Namespace archetype_catalyst/archetype_catalyst
// Params 1, eflags: 0x5 linked
// Checksum 0xd9fc43ce, Offset: 0x120
// Size: 0x54
function private function_5608540a(localclientnum) {
    self enableonradar();
    self mapshaderconstant(localclientnum, 0, "scriptVector2", 1, 0, 0, 1);
}

