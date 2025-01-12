#using scripts\core_common\system_shared;
#using scripts\weapons\smokegrenade;

#namespace smokegrenade;

// Namespace smokegrenade/smokegrenade
// Params 0, eflags: 0x6
// Checksum 0x66c5a778, Offset: 0x70
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"smokegrenade", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace smokegrenade/smokegrenade
// Params 0, eflags: 0x5 linked
// Checksum 0x3f429e57, Offset: 0xb8
// Size: 0x14
function private function_70a657d8() {
    init_shared();
}

