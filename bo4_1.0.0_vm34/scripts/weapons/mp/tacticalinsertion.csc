#using scripts\core_common\system_shared;
#using scripts\weapons\tacticalinsertion;

#namespace tacticalinsertion;

// Namespace tacticalinsertion/tacticalinsertion
// Params 0, eflags: 0x2
// Checksum 0x9faf44fd, Offset: 0x78
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"tacticalinsertion", &__init__, undefined, undefined);
}

// Namespace tacticalinsertion/tacticalinsertion
// Params 0, eflags: 0x0
// Checksum 0xaa3ce851, Offset: 0xc0
// Size: 0x14
function __init__() {
    init_shared();
}

