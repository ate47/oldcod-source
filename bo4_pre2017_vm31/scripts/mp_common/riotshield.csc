#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/riotshield;
#using scripts/mp_common/util;

#namespace riotshield;

// Namespace riotshield/riotshield
// Params 0, eflags: 0x2
// Checksum 0x80b03f18, Offset: 0x160
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "riotshield", &__init__, undefined, undefined );
}

// Namespace riotshield/riotshield
// Params 0
// Checksum 0x3493d62f, Offset: 0x1a0
// Size: 0x14
function __init__()
{
    init_shared();
}

