#using scripts\core_common\entityheadicons_shared;
#using scripts\core_common\system_shared;

#namespace entityheadicons;

// Namespace entityheadicons/entityheadicons
// Params 0, eflags: 0x2
// Checksum 0x6902a695, Offset: 0x78
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"entityheadicons", &__init__, undefined, undefined);
}

// Namespace entityheadicons/entityheadicons
// Params 0, eflags: 0x0
// Checksum 0x6c520f53, Offset: 0xc0
// Size: 0x14
function __init__() {
    init_shared();
}
