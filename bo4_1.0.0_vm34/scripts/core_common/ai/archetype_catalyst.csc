#using scripts\core_common\ai_shared;
#using scripts\core_common\system_shared;

#namespace archetype_catalyst;

// Namespace archetype_catalyst/archetype_catalyst
// Params 0, eflags: 0x2
// Checksum 0xe377cf09, Offset: 0x90
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"catalyst", &__init__, undefined, undefined);
}

// Namespace archetype_catalyst/archetype_catalyst
// Params 0, eflags: 0x2
// Checksum 0x80f724d1, Offset: 0xd8
// Size: 0x4
function autoexec precache() {
    
}

// Namespace archetype_catalyst/archetype_catalyst
// Params 0, eflags: 0x0
// Checksum 0x81e4ab11, Offset: 0xe8
// Size: 0x2c
function __init__() {
    ai::add_archetype_spawn_function("catalyst", &function_7556ceb8);
}

// Namespace archetype_catalyst/archetype_catalyst
// Params 1, eflags: 0x4
// Checksum 0xb10e919e, Offset: 0x120
// Size: 0x3c
function private function_7556ceb8(localclientnum) {
    self mapshaderconstant(localclientnum, 0, "scriptVector2", 1, 0, 0, 1);
}

