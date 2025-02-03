#using scripts\core_common\entityheadicons_shared;
#using scripts\core_common\system_shared;

#namespace entityheadicons;

// Namespace entityheadicons/entityheadicons
// Params 0, eflags: 0x6
// Checksum 0x31773f66, Offset: 0x70
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"entityheadicons", &preinit, undefined, undefined, undefined);
}

// Namespace entityheadicons/entityheadicons
// Params 0, eflags: 0x4
// Checksum 0xa0c3f4d0, Offset: 0xb8
// Size: 0x14
function private preinit() {
    init_shared();
}

