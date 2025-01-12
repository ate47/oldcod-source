#using scripts\core_common\system_shared;
#using scripts\weapons\grenades;

#namespace grenades;

// Namespace grenades/grenades
// Params 0, eflags: 0x2
// Checksum 0x147e8c1f, Offset: 0x78
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"grenades", &__init__, undefined, undefined);
}

// Namespace grenades/grenades
// Params 0, eflags: 0x0
// Checksum 0x1de5bada, Offset: 0xc0
// Size: 0x14
function __init__() {
    init_shared();
}

