#using scripts\core_common\system_shared;
#using scripts\weapons\grenades;

#namespace grenades;

// Namespace grenades/grenades
// Params 0, eflags: 0x6
// Checksum 0xaf2c4476, Offset: 0x70
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"grenades", &preinit, undefined, undefined, undefined);
}

// Namespace grenades/grenades
// Params 0, eflags: 0x4
// Checksum 0xa0c3f4d0, Offset: 0xb8
// Size: 0x14
function private preinit() {
    init_shared();
}

