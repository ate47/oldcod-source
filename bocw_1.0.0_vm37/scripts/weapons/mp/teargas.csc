#using scripts\core_common\system_shared;
#using scripts\weapons\teargas;

#namespace teargas;

// Namespace teargas/teargas
// Params 0, eflags: 0x6
// Checksum 0x154eae0c, Offset: 0x70
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_2d15b1979434a7ae", &preinit, undefined, undefined, undefined);
}

// Namespace teargas/teargas
// Params 0, eflags: 0x4
// Checksum 0xa0c3f4d0, Offset: 0xb8
// Size: 0x14
function private preinit() {
    init_shared();
}

