#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace namespace_c7c9ced8;

// Namespace namespace_c7c9ced8/namespace_c7c9ced8
// Params 0, eflags: 0x2
// Checksum 0xd4392a59, Offset: 0x238
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_concussive_wave", &__init__, undefined, undefined);
}

// Namespace namespace_c7c9ced8/namespace_c7c9ced8
// Params 0, eflags: 0x0
// Checksum 0xbe092474, Offset: 0x278
// Size: 0x104
function __init__() {
    ability_player::register_gadget_activation_callbacks(27, &function_34dd1440, &function_92fc0c6e);
    ability_player::register_gadget_possession_callbacks(27, &function_6418a4dc, &function_1d94dc8a);
    ability_player::register_gadget_flicker_callbacks(27, &function_52e40575);
    ability_player::register_gadget_is_inuse_callbacks(27, &function_9b3f10a8);
    ability_player::register_gadget_is_flickering_callbacks(27, &function_52a16de6);
    ability_player::register_gadget_primed_callbacks(27, &function_96c5b0e1);
    callback::on_connect(&function_1d1db9d3);
}

// Namespace namespace_c7c9ced8/namespace_c7c9ced8
// Params 1, eflags: 0x0
// Checksum 0x63833aca, Offset: 0x388
// Size: 0x2a
function function_9b3f10a8(slot) {
    return self flagsys::get("gadget_concussive_wave_on");
}

// Namespace namespace_c7c9ced8/namespace_c7c9ced8
// Params 1, eflags: 0x0
// Checksum 0xf8ba1ec2, Offset: 0x3c0
// Size: 0x5e
function function_52a16de6(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.concussive_wave)) {
        return self [[ level.cybercom.concussive_wave.var_875da84b ]](slot);
    }
    return 0;
}

// Namespace namespace_c7c9ced8/namespace_c7c9ced8
// Params 2, eflags: 0x0
// Checksum 0x68246236, Offset: 0x428
// Size: 0x68
function function_52e40575(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.concussive_wave)) {
        self [[ level.cybercom.concussive_wave.var_8d01efb6 ]](slot, weapon);
    }
}

// Namespace namespace_c7c9ced8/namespace_c7c9ced8
// Params 2, eflags: 0x0
// Checksum 0xa1deb453, Offset: 0x498
// Size: 0x68
function function_6418a4dc(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.concussive_wave)) {
        self [[ level.cybercom.concussive_wave.var_bdb47551 ]](slot, weapon);
    }
}

// Namespace namespace_c7c9ced8/namespace_c7c9ced8
// Params 2, eflags: 0x0
// Checksum 0x6ae744e5, Offset: 0x508
// Size: 0x68
function function_1d94dc8a(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.concussive_wave)) {
        self [[ level.cybercom.concussive_wave.var_39ea6a1b ]](slot, weapon);
    }
}

// Namespace namespace_c7c9ced8/namespace_c7c9ced8
// Params 0, eflags: 0x0
// Checksum 0xa82100d3, Offset: 0x578
// Size: 0x50
function function_1d1db9d3() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.concussive_wave)) {
        self [[ level.cybercom.concussive_wave.var_5d2fec30 ]]();
    }
}

// Namespace namespace_c7c9ced8/namespace_c7c9ced8
// Params 2, eflags: 0x0
// Checksum 0xa8a02c5a, Offset: 0x5d0
// Size: 0x88
function function_34dd1440(slot, weapon) {
    self flagsys::set("gadget_concussive_wave_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.concussive_wave)) {
        self [[ level.cybercom.concussive_wave._on ]](slot, weapon);
    }
}

// Namespace namespace_c7c9ced8/namespace_c7c9ced8
// Params 2, eflags: 0x0
// Checksum 0x8fc4b0c6, Offset: 0x660
// Size: 0x88
function function_92fc0c6e(slot, weapon) {
    self flagsys::clear("gadget_concussive_wave_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.concussive_wave)) {
        self [[ level.cybercom.concussive_wave._off ]](slot, weapon);
    }
}

// Namespace namespace_c7c9ced8/namespace_c7c9ced8
// Params 2, eflags: 0x0
// Checksum 0x4c2a5f35, Offset: 0x6f0
// Size: 0x68
function function_96c5b0e1(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.concussive_wave)) {
        self [[ level.cybercom.concussive_wave.var_4135a1c4 ]](slot, weapon);
    }
}

