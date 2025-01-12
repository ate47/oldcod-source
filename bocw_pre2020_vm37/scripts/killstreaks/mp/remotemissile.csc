#using scripts\core_common\system_shared;
#using scripts\killstreaks\remotemissile_shared;

#namespace remotemissile;

// Namespace remotemissile/remotemissile
// Params 0, eflags: 0x6
// Checksum 0xc9957b03, Offset: 0x70
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"remotemissile", &function_70a657d8, undefined, undefined, #"killstreaks");
}

// Namespace remotemissile/remotemissile
// Params 0, eflags: 0x5 linked
// Checksum 0x3f429e57, Offset: 0xc0
// Size: 0x14
function private function_70a657d8() {
    init_shared();
}

