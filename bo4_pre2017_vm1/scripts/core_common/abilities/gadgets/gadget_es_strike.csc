#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_power;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/filter_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace namespace_5e9fbbe1;

// Namespace namespace_5e9fbbe1/namespace_5e9fbbe1
// Params 0, eflags: 0x2
// Checksum 0x9cfb9fcb, Offset: 0x218
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_es_strike", &__init__, undefined, undefined);
}

// Namespace namespace_5e9fbbe1/namespace_5e9fbbe1
// Params 0, eflags: 0x0
// Checksum 0x97a9c6d4, Offset: 0x258
// Size: 0x24
function __init__() {
    callback::on_spawned(&on_player_spawned);
}

// Namespace namespace_5e9fbbe1/namespace_5e9fbbe1
// Params 1, eflags: 0x0
// Checksum 0xa7d2587b, Offset: 0x288
// Size: 0xc
function on_player_spawned(local_client_num) {
    
}

