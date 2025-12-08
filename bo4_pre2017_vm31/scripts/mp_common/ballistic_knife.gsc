#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/weapons/ballistic_knife;

#namespace ballistic_knife;

// Namespace ballistic_knife/ballistic_knife
// Params 0, eflags: 0x2
// Checksum 0xcf1f4d18, Offset: 0x158
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "ballistic_knife", &__init__, undefined, undefined );
}

// Namespace ballistic_knife/ballistic_knife
// Params 0
// Checksum 0x74ed26f8, Offset: 0x198
// Size: 0x14
function __init__()
{
    init_shared();
}

