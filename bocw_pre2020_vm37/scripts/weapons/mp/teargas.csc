#using scripts\core_common\system_shared;
#using scripts\weapons\teargas;

#namespace namespace_8a3384f2;

// Namespace namespace_8a3384f2/namespace_8a3384f2
// Params 0, eflags: 0x6
// Checksum 0xdc7644c2, Offset: 0x70
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_2d15b1979434a7ae", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_8a3384f2/namespace_8a3384f2
// Params 0, eflags: 0x5 linked
// Checksum 0x3f429e57, Offset: 0xb8
// Size: 0x14
function private function_70a657d8() {
    init_shared();
}

