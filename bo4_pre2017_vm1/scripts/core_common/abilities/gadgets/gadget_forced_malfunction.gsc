#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace namespace_66d6b67c;

// Namespace namespace_66d6b67c/namespace_66d6b67c
// Params 0, eflags: 0x2
// Checksum 0x8aeb97ea, Offset: 0x240
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_forced_malfunction", &__init__, undefined, undefined);
}

// Namespace namespace_66d6b67c/namespace_66d6b67c
// Params 0, eflags: 0x0
// Checksum 0x1b4e6b46, Offset: 0x280
// Size: 0x104
function __init__() {
    ability_player::register_gadget_activation_callbacks(26, &function_9b45e254, &function_2d460862);
    ability_player::register_gadget_possession_callbacks(26, &function_d23df6e8, &function_197921fe);
    ability_player::register_gadget_flicker_callbacks(26, &function_7fa5f639);
    ability_player::register_gadget_is_inuse_callbacks(26, &function_dffae3dc);
    ability_player::register_gadget_is_flickering_callbacks(26, &function_d1d17a92);
    ability_player::register_gadget_primed_callbacks(26, &function_7f26eafd);
    callback::on_connect(&function_bd256077);
}

// Namespace namespace_66d6b67c/namespace_66d6b67c
// Params 1, eflags: 0x0
// Checksum 0x1d3014cb, Offset: 0x390
// Size: 0x2a
function function_dffae3dc(slot) {
    return self flagsys::get("gadget_forced_malfunction_on");
}

// Namespace namespace_66d6b67c/namespace_66d6b67c
// Params 1, eflags: 0x0
// Checksum 0x4cc116f7, Offset: 0x3c8
// Size: 0x5e
function function_d1d17a92(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.forced_malfunction)) {
        return self [[ level.cybercom.forced_malfunction.var_875da84b ]](slot);
    }
    return 0;
}

// Namespace namespace_66d6b67c/namespace_66d6b67c
// Params 2, eflags: 0x0
// Checksum 0x54546906, Offset: 0x430
// Size: 0x68
function function_7fa5f639(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.forced_malfunction)) {
        self [[ level.cybercom.forced_malfunction.var_8d01efb6 ]](slot, weapon);
    }
}

// Namespace namespace_66d6b67c/namespace_66d6b67c
// Params 2, eflags: 0x0
// Checksum 0x9666608a, Offset: 0x4a0
// Size: 0x68
function function_d23df6e8(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.forced_malfunction)) {
        self [[ level.cybercom.forced_malfunction.var_bdb47551 ]](slot, weapon);
    }
}

// Namespace namespace_66d6b67c/namespace_66d6b67c
// Params 2, eflags: 0x0
// Checksum 0xa9145736, Offset: 0x510
// Size: 0x68
function function_197921fe(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.forced_malfunction)) {
        self [[ level.cybercom.forced_malfunction.var_39ea6a1b ]](slot, weapon);
    }
}

// Namespace namespace_66d6b67c/namespace_66d6b67c
// Params 0, eflags: 0x0
// Checksum 0x237803f8, Offset: 0x580
// Size: 0x50
function function_bd256077() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.forced_malfunction)) {
        self [[ level.cybercom.forced_malfunction.var_5d2fec30 ]]();
    }
}

// Namespace namespace_66d6b67c/namespace_66d6b67c
// Params 2, eflags: 0x0
// Checksum 0x99bf348b, Offset: 0x5d8
// Size: 0x88
function function_9b45e254(slot, weapon) {
    self flagsys::set("gadget_forced_malfunction_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.forced_malfunction)) {
        self [[ level.cybercom.forced_malfunction._on ]](slot, weapon);
    }
}

// Namespace namespace_66d6b67c/namespace_66d6b67c
// Params 2, eflags: 0x0
// Checksum 0x9e9ed385, Offset: 0x668
// Size: 0x88
function function_2d460862(slot, weapon) {
    self flagsys::clear("gadget_forced_malfunction_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.forced_malfunction)) {
        self [[ level.cybercom.forced_malfunction._off ]](slot, weapon);
    }
}

// Namespace namespace_66d6b67c/namespace_66d6b67c
// Params 2, eflags: 0x0
// Checksum 0xc98c7402, Offset: 0x6f8
// Size: 0x68
function function_7f26eafd(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.forced_malfunction)) {
        self [[ level.cybercom.forced_malfunction.var_4135a1c4 ]](slot, weapon);
    }
}

