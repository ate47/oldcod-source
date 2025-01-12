#using scripts\core_common\system_shared;
#using scripts\killstreaks\remotemissile_shared;

#namespace remotemissile;

// Namespace remotemissile/remotemissile
// Params 0, eflags: 0x2
// Checksum 0x834babcf, Offset: 0x78
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"remotemissile", &__init__, undefined, #"killstreaks");
}

// Namespace remotemissile/remotemissile
// Params 0, eflags: 0x0
// Checksum 0x6f1ac71b, Offset: 0xc8
// Size: 0x14
function __init__() {
    init_shared();
}

