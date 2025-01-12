#using scripts\core_common\spawnbeacon_shared;
#using scripts\core_common\system_shared;

#namespace spawn_beacon;

// Namespace spawn_beacon/spawnbeacon
// Params 0, eflags: 0x2
// Checksum 0xb24996c9, Offset: 0x78
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"spawnbeacon", &__init__, undefined, #"killstreaks");
}

// Namespace spawn_beacon/spawnbeacon
// Params 0, eflags: 0x0
// Checksum 0x67e6a64a, Offset: 0xc8
// Size: 0x14
function __init__() {
    init_shared();
}

