#using scripts\core_common\spawnbeacon_shared;
#using scripts\core_common\system_shared;

#namespace spawn_beacon;

// Namespace spawn_beacon/spawnbeacon
// Params 0, eflags: 0x6
// Checksum 0xf7f357f6, Offset: 0x70
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"spawnbeacon", &preinit, undefined, undefined, #"killstreaks");
}

// Namespace spawn_beacon/spawnbeacon
// Params 0, eflags: 0x4
// Checksum 0xa0c3f4d0, Offset: 0xc0
// Size: 0x14
function private preinit() {
    init_shared();
}

