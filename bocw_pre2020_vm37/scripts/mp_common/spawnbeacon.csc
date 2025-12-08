#using scripts\core_common\spawnbeacon_shared;
#using scripts\core_common\system_shared;

#namespace spawn_beacon;

// Namespace spawn_beacon/spawnbeacon
// Params 0, eflags: 0x6
// Checksum 0xb571e68f, Offset: 0x70
// Size: 0x44
function private autoexec __init__system__()
{
    system::register( #"spawnbeacon", &preinit, undefined, undefined, #"killstreaks" );
}

// Namespace spawn_beacon/spawnbeacon
// Params 0, eflags: 0x4
// Checksum 0x3f429e57, Offset: 0xc0
// Size: 0x14
function private preinit()
{
    init_shared();
}

