#using scripts\core_common\system_shared;

#namespace namespace_ce472ff1;

// Namespace namespace_ce472ff1/namespace_ce472ff1
// Params 0, eflags: 0x6
// Checksum 0x9150c9da, Offset: 0x68
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_788b2cd49344cd51", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_ce472ff1/namespace_ce472ff1
// Params 0, eflags: 0x4
// Checksum 0x5c09bb2, Offset: 0xb0
// Size: 0x30
function private function_70a657d8() {
    if (level.var_f2814a96 !== 1 && level.var_f2814a96 !== 2) {
        return;
    }
}

