#using scripts/core_common/archetype_shared/archetype_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/filter_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/vehicle_shared;

#namespace counteruav;

// Namespace counteruav/counteruav
// Params 0, eflags: 0x2
// Checksum 0xb0aaaec, Offset: 0x1d8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "counteruav", &__init__, undefined, undefined );
}

// Namespace counteruav/counteruav
// Params 0
// Checksum 0x80f724d1, Offset: 0x218
// Size: 0x4
function __init__()
{
    
}

