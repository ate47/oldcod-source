#using scripts\core_common\ai\systems\fx_character;
#using scripts\core_common\ai_shared;
#using scripts\core_common\system_shared;

#namespace archetype_blight_father;

// Namespace archetype_blight_father/archetype_blight_father
// Params 0, eflags: 0x2
// Checksum 0xaaa0e020, Offset: 0xa0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"blight_father", &__init__, undefined, undefined);
}

// Namespace archetype_blight_father/archetype_blight_father
// Params 0, eflags: 0x2
// Checksum 0x5ed09b52, Offset: 0xe8
// Size: 0x2c
function autoexec precache() {
    ai::add_archetype_spawn_function("blight_father", &function_1a270ebd);
}

// Namespace archetype_blight_father/archetype_blight_father
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x120
// Size: 0x4
function __init__() {
    
}

// Namespace archetype_blight_father/archetype_blight_father
// Params 1, eflags: 0x4
// Checksum 0x407282b7, Offset: 0x130
// Size: 0x5c
function private function_1a270ebd(localclientnum) {
    fxclientutils::playfxbundle(localclientnum, self, self.fxdef);
    self mapshaderconstant(localclientnum, 0, "scriptVector2", 1, 0, 0, 1);
}

