#using scripts\core_common\entityheadicons_shared;
#using scripts\core_common\system_shared;

#namespace entityheadicons;

// Namespace entityheadicons/entityheadicons
// Params 0, eflags: 0x6
// Checksum 0xf84fd5a8, Offset: 0x70
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"entityheadicons", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace entityheadicons/entityheadicons
// Params 0, eflags: 0x4
// Checksum 0x3f429e57, Offset: 0xb8
// Size: 0x14
function private function_70a657d8() {
    init_shared();
}

