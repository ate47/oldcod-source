#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace namespace_d8cbbad5;

// Namespace namespace_d8cbbad5/namespace_d8cbbad5
// Params 0, eflags: 0x2
// Checksum 0x7cacf58, Offset: 0x220
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_mrpukey", &__init__, undefined, undefined);
}

// Namespace namespace_d8cbbad5/namespace_d8cbbad5
// Params 0, eflags: 0x0
// Checksum 0xfe4da15c, Offset: 0x260
// Size: 0xe4
function __init__() {
    ability_player::register_gadget_activation_callbacks(38, &function_79fd7153, &function_a21f6e7);
    ability_player::register_gadget_possession_callbacks(38, &function_70600839, &function_86cffd43);
    ability_player::register_gadget_flicker_callbacks(38, &function_37c482e);
    ability_player::register_gadget_is_inuse_callbacks(38, &function_ec5153d3);
    ability_player::register_gadget_is_flickering_callbacks(38, &function_f1409fc3);
    ability_player::register_gadget_primed_callbacks(38, &function_a05ccc6c);
}

// Namespace namespace_d8cbbad5/namespace_d8cbbad5
// Params 1, eflags: 0x0
// Checksum 0xbe096247, Offset: 0x350
// Size: 0x2a
function function_ec5153d3(slot) {
    return self flagsys::get("gadget_mrpukey_on");
}

// Namespace namespace_d8cbbad5/namespace_d8cbbad5
// Params 1, eflags: 0x0
// Checksum 0xcfe60e0a, Offset: 0x388
// Size: 0x5c
function function_f1409fc3(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.var_9b2c750e)) {
        return self [[ level.cybercom.var_9b2c750e.var_875da84b ]](slot);
    }
}

// Namespace namespace_d8cbbad5/namespace_d8cbbad5
// Params 2, eflags: 0x0
// Checksum 0x9dc5b5be, Offset: 0x3f0
// Size: 0x68
function function_37c482e(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.var_9b2c750e)) {
        self [[ level.cybercom.var_9b2c750e.var_8d01efb6 ]](slot, weapon);
    }
}

// Namespace namespace_d8cbbad5/namespace_d8cbbad5
// Params 2, eflags: 0x0
// Checksum 0x673ec75d, Offset: 0x460
// Size: 0x68
function function_70600839(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.var_9b2c750e)) {
        self [[ level.cybercom.var_9b2c750e.var_bdb47551 ]](slot, weapon);
    }
}

// Namespace namespace_d8cbbad5/namespace_d8cbbad5
// Params 2, eflags: 0x0
// Checksum 0x6a1d9cba, Offset: 0x4d0
// Size: 0x68
function function_86cffd43(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.var_9b2c750e)) {
        self [[ level.cybercom.var_9b2c750e.var_39ea6a1b ]](slot, weapon);
    }
}

// Namespace namespace_d8cbbad5/namespace_d8cbbad5
// Params 0, eflags: 0x0
// Checksum 0xb09d4ed7, Offset: 0x540
// Size: 0x50
function function_6f66c54a() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.var_9b2c750e)) {
        self [[ level.cybercom.var_9b2c750e.var_5d2fec30 ]]();
    }
}

// Namespace namespace_d8cbbad5/namespace_d8cbbad5
// Params 2, eflags: 0x0
// Checksum 0x847992a4, Offset: 0x598
// Size: 0x88
function function_79fd7153(slot, weapon) {
    self flagsys::set("gadget_mrpukey_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.var_9b2c750e)) {
        self [[ level.cybercom.var_9b2c750e._on ]](slot, weapon);
    }
}

// Namespace namespace_d8cbbad5/namespace_d8cbbad5
// Params 2, eflags: 0x0
// Checksum 0xebff9333, Offset: 0x628
// Size: 0x88
function function_a21f6e7(slot, weapon) {
    self flagsys::clear("gadget_mrpukey_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.var_9b2c750e)) {
        self [[ level.cybercom.var_9b2c750e._off ]](slot, weapon);
    }
}

// Namespace namespace_d8cbbad5/namespace_d8cbbad5
// Params 2, eflags: 0x0
// Checksum 0x2c2b4601, Offset: 0x6b8
// Size: 0x68
function function_a05ccc6c(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.var_9b2c750e)) {
        self [[ level.cybercom.var_9b2c750e.var_4135a1c4 ]](slot, weapon);
    }
}

