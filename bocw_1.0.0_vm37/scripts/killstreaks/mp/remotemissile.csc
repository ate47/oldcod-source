#using scripts\core_common\system_shared;
#using scripts\killstreaks\remotemissile_shared;

#namespace remotemissile;

// Namespace remotemissile/remotemissile
// Params 0, eflags: 0x6
// Checksum 0x8b17ca7a, Offset: 0x70
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"remotemissile", &preinit, undefined, undefined, #"killstreaks");
}

// Namespace remotemissile/remotemissile
// Params 0, eflags: 0x4
// Checksum 0xa0c3f4d0, Offset: 0xc0
// Size: 0x14
function private preinit() {
    init_shared();
}

