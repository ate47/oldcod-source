#using scripts\core_common\system_shared;
#using scripts\weapons\weapons;

#namespace weapons;

// Namespace weapons/weapons
// Params 0, eflags: 0x2
// Checksum 0xb46abef7, Offset: 0x78
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"weapons", &__init__, undefined, undefined);
}

// Namespace weapons/weapons
// Params 0, eflags: 0x0
// Checksum 0xc914caea, Offset: 0xc0
// Size: 0x14
function __init__() {
    init_shared();
}

