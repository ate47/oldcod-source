#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace namespace_5e9fbbe1;

// Namespace namespace_5e9fbbe1/namespace_5e9fbbe1
// Params 0, eflags: 0x2
// Checksum 0xebea3f63, Offset: 0x228
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_es_strike", &__init__, undefined, undefined);
}

// Namespace namespace_5e9fbbe1/namespace_5e9fbbe1
// Params 0, eflags: 0x0
// Checksum 0xfa13f15f, Offset: 0x268
// Size: 0xe4
function __init__() {
    ability_player::register_gadget_activation_callbacks(33, &function_3211462f, &function_ec5008e3);
    ability_player::register_gadget_possession_callbacks(33, &function_16de280d, &function_8a49b72f);
    ability_player::register_gadget_flicker_callbacks(33, &function_f4c32d3a);
    ability_player::register_gadget_is_inuse_callbacks(33, &function_411e6e2f);
    ability_player::register_gadget_is_flickering_callbacks(33, &function_91b1b897);
    callback::on_connect(&function_b61a584);
}

// Namespace namespace_5e9fbbe1/namespace_5e9fbbe1
// Params 1, eflags: 0x0
// Checksum 0x708eed75, Offset: 0x358
// Size: 0x2a
function function_411e6e2f(slot) {
    return self flagsys::get("gadget_es_strike_on");
}

// Namespace namespace_5e9fbbe1/namespace_5e9fbbe1
// Params 1, eflags: 0x0
// Checksum 0x6d460067, Offset: 0x390
// Size: 0x5c
function function_91b1b897(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.var_e3b77070)) {
        return self [[ level.cybercom.var_e3b77070.var_875da84b ]](slot);
    }
}

// Namespace namespace_5e9fbbe1/namespace_5e9fbbe1
// Params 2, eflags: 0x0
// Checksum 0x1d026125, Offset: 0x3f8
// Size: 0x68
function function_f4c32d3a(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.var_e3b77070)) {
        self [[ level.cybercom.var_e3b77070.var_8d01efb6 ]](slot, weapon);
    }
}

// Namespace namespace_5e9fbbe1/namespace_5e9fbbe1
// Params 2, eflags: 0x0
// Checksum 0xda34bc7d, Offset: 0x468
// Size: 0x68
function function_16de280d(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.var_e3b77070)) {
        self [[ level.cybercom.var_e3b77070.var_bdb47551 ]](slot, weapon);
    }
}

// Namespace namespace_5e9fbbe1/namespace_5e9fbbe1
// Params 2, eflags: 0x0
// Checksum 0xafc91072, Offset: 0x4d8
// Size: 0x68
function function_8a49b72f(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.var_e3b77070)) {
        self [[ level.cybercom.var_e3b77070.var_39ea6a1b ]](slot, weapon);
    }
}

// Namespace namespace_5e9fbbe1/namespace_5e9fbbe1
// Params 0, eflags: 0x0
// Checksum 0xfe1664a4, Offset: 0x548
// Size: 0x50
function function_b61a584() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.var_e3b77070)) {
        self [[ level.cybercom.var_e3b77070.var_5d2fec30 ]]();
    }
}

// Namespace namespace_5e9fbbe1/namespace_5e9fbbe1
// Params 2, eflags: 0x0
// Checksum 0x9057aa49, Offset: 0x5a0
// Size: 0x88
function function_3211462f(slot, weapon) {
    self flagsys::set("gadget_es_strike_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.var_e3b77070)) {
        self [[ level.cybercom.var_e3b77070._on ]](slot, weapon);
    }
}

// Namespace namespace_5e9fbbe1/namespace_5e9fbbe1
// Params 2, eflags: 0x0
// Checksum 0xe140f31a, Offset: 0x630
// Size: 0x88
function function_ec5008e3(slot, weapon) {
    self flagsys::clear("gadget_es_strike_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.var_e3b77070)) {
        self [[ level.cybercom.var_e3b77070._off ]](slot, weapon);
    }
}

