#using scripts\core_common\system_shared;
#using scripts\weapons\ballistic_knife;

#namespace ballistic_knife;

// Namespace ballistic_knife/ballistic_knife
// Params 0, eflags: 0x2
// Checksum 0xc2d7184d, Offset: 0x78
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"ballistic_knife", &__init__, undefined, undefined);
}

// Namespace ballistic_knife/ballistic_knife
// Params 0, eflags: 0x0
// Checksum 0x8da6801, Offset: 0xc0
// Size: 0x14
function __init__() {
    init_shared();
}
