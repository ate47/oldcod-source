#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace namespace_82397aee;

// Namespace namespace_82397aee/namespace_82397aee
// Params 0, eflags: 0x2
// Checksum 0x21ded7f4, Offset: 0x230
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_firefly_swarm", &__init__, undefined, undefined);
}

// Namespace namespace_82397aee/namespace_82397aee
// Params 0, eflags: 0x0
// Checksum 0x8fb49ec5, Offset: 0x270
// Size: 0x104
function __init__() {
    ability_player::register_gadget_activation_callbacks(35, &function_1fe024ee, &function_b1976484);
    ability_player::register_gadget_possession_callbacks(35, &function_74f27faa, &function_db0a7244);
    ability_player::register_gadget_flicker_callbacks(35, &function_d4552077);
    ability_player::register_gadget_is_inuse_callbacks(35, &function_6194b7e);
    ability_player::register_gadget_is_flickering_callbacks(35, &function_e1e64030);
    ability_player::register_gadget_primed_callbacks(35, &function_9d2a518e);
    callback::on_connect(&function_4a3aa959);
}

// Namespace namespace_82397aee/namespace_82397aee
// Params 1, eflags: 0x0
// Checksum 0x997bbdb, Offset: 0x380
// Size: 0x2a
function function_6194b7e(slot) {
    return self flagsys::get("gadget_firefly_swarm_on");
}

// Namespace namespace_82397aee/namespace_82397aee
// Params 1, eflags: 0x0
// Checksum 0xa9fa47eb, Offset: 0x3b8
// Size: 0x5e
function function_e1e64030(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.firefly_swarm)) {
        return self [[ level.cybercom.firefly_swarm.var_875da84b ]](slot);
    }
    return 0;
}

// Namespace namespace_82397aee/namespace_82397aee
// Params 2, eflags: 0x0
// Checksum 0x7ebf40aa, Offset: 0x420
// Size: 0x68
function function_d4552077(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.firefly_swarm)) {
        self [[ level.cybercom.firefly_swarm.var_8d01efb6 ]](slot, weapon);
    }
}

// Namespace namespace_82397aee/namespace_82397aee
// Params 2, eflags: 0x0
// Checksum 0x1a2c6d27, Offset: 0x490
// Size: 0x68
function function_74f27faa(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.firefly_swarm)) {
        self [[ level.cybercom.firefly_swarm.var_bdb47551 ]](slot, weapon);
    }
}

// Namespace namespace_82397aee/namespace_82397aee
// Params 2, eflags: 0x0
// Checksum 0xe64858e1, Offset: 0x500
// Size: 0x68
function function_db0a7244(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.firefly_swarm)) {
        self [[ level.cybercom.firefly_swarm.var_39ea6a1b ]](slot, weapon);
    }
}

// Namespace namespace_82397aee/namespace_82397aee
// Params 0, eflags: 0x0
// Checksum 0xed44cf0c, Offset: 0x570
// Size: 0x50
function function_4a3aa959() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.firefly_swarm)) {
        self [[ level.cybercom.firefly_swarm.var_5d2fec30 ]]();
    }
}

// Namespace namespace_82397aee/namespace_82397aee
// Params 2, eflags: 0x0
// Checksum 0x528fe0d4, Offset: 0x5c8
// Size: 0x88
function function_1fe024ee(slot, weapon) {
    self flagsys::set("gadget_firefly_swarm_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.firefly_swarm)) {
        self [[ level.cybercom.firefly_swarm._on ]](slot, weapon);
    }
}

// Namespace namespace_82397aee/namespace_82397aee
// Params 2, eflags: 0x0
// Checksum 0xc89c1b97, Offset: 0x658
// Size: 0x88
function function_b1976484(slot, weapon) {
    self flagsys::clear("gadget_firefly_swarm_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.firefly_swarm)) {
        self [[ level.cybercom.firefly_swarm._off ]](slot, weapon);
    }
}

// Namespace namespace_82397aee/namespace_82397aee
// Params 2, eflags: 0x0
// Checksum 0xb7afa6a3, Offset: 0x6e8
// Size: 0x68
function function_9d2a518e(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.firefly_swarm)) {
        self [[ level.cybercom.firefly_swarm.var_4135a1c4 ]](slot, weapon);
    }
}

