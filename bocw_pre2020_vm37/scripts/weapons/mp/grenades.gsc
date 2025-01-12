#using scripts\core_common\system_shared;
#using scripts\weapons\grenades;

#namespace grenades;

// Namespace grenades/grenades
// Params 0, eflags: 0x6
// Checksum 0x6614aeb8, Offset: 0x70
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"grenades", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace grenades/grenades
// Params 0, eflags: 0x4
// Checksum 0x3f429e57, Offset: 0xb8
// Size: 0x14
function private function_70a657d8() {
    init_shared();
}

