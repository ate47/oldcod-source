#using scripts\core_common\system_shared;
#using scripts\killstreaks\supplydrop_shared;

#namespace supplydrop;

// Namespace supplydrop/supplydrop
// Params 0, eflags: 0x6
// Checksum 0xa592b6ea, Offset: 0x70
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"supplydrop", &preinit, undefined, undefined, #"killstreaks");
}

// Namespace supplydrop/supplydrop
// Params 0, eflags: 0x4
// Checksum 0xa0c3f4d0, Offset: 0xc0
// Size: 0x14
function private preinit() {
    init_shared();
}

