#using scripts\core_common\system_shared;
#using scripts\weapons\tabun;

#namespace tabun;

// Namespace tabun/tabun
// Params 0, eflags: 0x2
// Checksum 0x234c1c2, Offset: 0x78
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"tabun", &__init__, undefined, undefined);
}

// Namespace tabun/tabun
// Params 0, eflags: 0x0
// Checksum 0x235ee376, Offset: 0xc0
// Size: 0x14
function __init__() {
    init_shared();
}

