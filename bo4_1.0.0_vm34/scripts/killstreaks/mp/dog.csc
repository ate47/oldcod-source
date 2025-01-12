#using scripts\core_common\ai_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\dog_shared;
#using scripts\killstreaks\killstreak_bundles;

#namespace dog;

// Namespace dog/dog
// Params 0, eflags: 0x2
// Checksum 0xad43b437, Offset: 0xa8
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"killstreak_dog", &__init__, undefined, #"killstreaks");
}

// Namespace dog/dog
// Params 0, eflags: 0x0
// Checksum 0x637126cf, Offset: 0xf8
// Size: 0x74
function __init__() {
    init_shared();
    bundle = struct::get_script_bundle("killstreak", #"killstreak_dog");
    ai::add_archetype_spawn_function("mp_dog", &spawned, bundle);
}

// Namespace dog/dog
// Params 2, eflags: 0x0
// Checksum 0xe290e960, Offset: 0x178
// Size: 0x2c
function spawned(local_client_num, bundle) {
    self killstreak_bundles::spawned(local_client_num, bundle);
}

