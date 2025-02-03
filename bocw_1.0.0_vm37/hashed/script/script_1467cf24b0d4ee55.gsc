#using scripts\core_common\callbacks_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\system_shared;

#namespace namespace_ce472ff1;

// Namespace namespace_ce472ff1/namespace_ce472ff1
// Params 0, eflags: 0x6
// Checksum 0x58682314, Offset: 0x78
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_788b2cd49344cd51", &preinit, undefined, undefined, undefined);
}

// Namespace namespace_ce472ff1/namespace_ce472ff1
// Params 0, eflags: 0x4
// Checksum 0xd0cd2e5f, Offset: 0xc0
// Size: 0x30
function private preinit() {
    if (level.var_f2814a96 !== 1 && level.var_f2814a96 !== 2) {
        return;
    }
}

// Namespace namespace_ce472ff1/namespace_ce472ff1
// Params 1, eflags: 0x0
// Checksum 0x9e3346c9, Offset: 0xf8
// Size: 0x4c
function on_spawn_player(predictedspawn) {
    if (isdefined(level.on_spawn_player)) {
        [[ level.on_spawn_player ]](predictedspawn);
        return;
    }
    spawning::onspawnplayer(undefined);
}

