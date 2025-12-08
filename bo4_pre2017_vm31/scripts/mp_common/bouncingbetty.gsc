#using scripts/core_common/callbacks_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/bouncingbetty;
#using scripts/mp_common/util;

#namespace bouncingbetty;

// Namespace bouncingbetty/bouncingbetty
// Params 0, eflags: 0x2
// Checksum 0xd1bb0f8b, Offset: 0x168
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "bouncingbetty", &__init__, undefined, undefined );
}

// Namespace bouncingbetty/bouncingbetty
// Params 0
// Checksum 0xa754bd4d, Offset: 0x1a8
// Size: 0x24
function __init__()
{
    init_shared();
    level.trackbouncingbettiesonowner = 1;
}

