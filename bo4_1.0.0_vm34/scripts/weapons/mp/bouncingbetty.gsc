#using scripts\core_common\system_shared;
#using scripts\weapons\bouncingbetty;

#namespace bouncingbetty;

// Namespace bouncingbetty/bouncingbetty
// Params 0, eflags: 0x2
// Checksum 0x5df1c49a, Offset: 0x78
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"bouncingbetty", &__init__, undefined, undefined);
}

// Namespace bouncingbetty/bouncingbetty
// Params 0, eflags: 0x0
// Checksum 0x53f80a0f, Offset: 0xc0
// Size: 0x22
function __init__() {
    init_shared();
    level.trackbouncingbettiesonowner = 1;
}

