#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace spawnbeacon;

// Namespace spawnbeacon/spawnbeacon
// Params 0, eflags: 0x2
// Checksum 0x696349ba, Offset: 0x1f0
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "spawnbeacon", &__init__, undefined, undefined );
}

// Namespace spawnbeacon/spawnbeacon
// Params 0
// Checksum 0x2ee82936, Offset: 0x230
// Size: 0x14
function __init__()
{
    setupclientfields();
}

// Namespace spawnbeacon/spawnbeacon
// Params 0
// Checksum 0xd88a5d5e, Offset: 0x250
// Size: 0x3c
function setupclientfields()
{
    clientfield::register( "clientuimodel", "hudItems.spawnbeacon.cooldownPenalty", 1, 6, "int", undefined, 0, 1 );
}

