#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace namespace_f83e6bba;

// Namespace namespace_f83e6bba/namespace_f83e6bba
// Params 0, eflags: 0x2
// Checksum 0x28801e5a, Offset: 0x230
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_ravage_core", &__init__, undefined, undefined);
}

// Namespace namespace_f83e6bba/namespace_f83e6bba
// Params 0, eflags: 0x0
// Checksum 0xcddfbb5c, Offset: 0x270
// Size: 0xe4
function __init__() {
    ability_player::register_gadget_activation_callbacks(22, &function_272c182a, &function_38d64430);
    ability_player::register_gadget_possession_callbacks(22, &function_5f263c7e, &function_5aa8d250);
    ability_player::register_gadget_flicker_callbacks(22, &function_f2c75eb3);
    ability_player::register_gadget_is_inuse_callbacks(22, &function_9b19b36a);
    ability_player::register_gadget_is_flickering_callbacks(22, &function_7f87be84);
    callback::on_connect(&function_882e77d5);
}

// Namespace namespace_f83e6bba/namespace_f83e6bba
// Params 1, eflags: 0x0
// Checksum 0x5fd0f2, Offset: 0x360
// Size: 0x2a
function function_9b19b36a(slot) {
    return self flagsys::get("gadget_ravage_core_on");
}

// Namespace namespace_f83e6bba/namespace_f83e6bba
// Params 1, eflags: 0x0
// Checksum 0x6dcbd8a0, Offset: 0x398
// Size: 0x5c
function function_7f87be84(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.ravage_core)) {
        return self [[ level.cybercom.ravage_core.var_875da84b ]](slot);
    }
}

// Namespace namespace_f83e6bba/namespace_f83e6bba
// Params 2, eflags: 0x0
// Checksum 0x100c9e26, Offset: 0x400
// Size: 0x68
function function_f2c75eb3(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.ravage_core)) {
        self [[ level.cybercom.ravage_core.var_8d01efb6 ]](slot, weapon);
    }
}

// Namespace namespace_f83e6bba/namespace_f83e6bba
// Params 2, eflags: 0x0
// Checksum 0x7f536d29, Offset: 0x470
// Size: 0x68
function function_5f263c7e(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.ravage_core)) {
        self [[ level.cybercom.ravage_core.var_bdb47551 ]](slot, weapon);
    }
}

// Namespace namespace_f83e6bba/namespace_f83e6bba
// Params 2, eflags: 0x0
// Checksum 0xf32de9d0, Offset: 0x4e0
// Size: 0x68
function function_5aa8d250(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.ravage_core)) {
        self [[ level.cybercom.ravage_core.var_39ea6a1b ]](slot, weapon);
    }
}

// Namespace namespace_f83e6bba/namespace_f83e6bba
// Params 0, eflags: 0x0
// Checksum 0xf0a4da4b, Offset: 0x550
// Size: 0x50
function function_882e77d5() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.ravage_core)) {
        self [[ level.cybercom.ravage_core.var_5d2fec30 ]]();
    }
}

// Namespace namespace_f83e6bba/namespace_f83e6bba
// Params 2, eflags: 0x0
// Checksum 0x1ddf3d0d, Offset: 0x5a8
// Size: 0x88
function function_272c182a(slot, weapon) {
    self flagsys::set("gadget_ravage_core_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.ravage_core)) {
        self [[ level.cybercom.ravage_core._on ]](slot, weapon);
    }
}

// Namespace namespace_f83e6bba/namespace_f83e6bba
// Params 2, eflags: 0x0
// Checksum 0xe2671aff, Offset: 0x638
// Size: 0x88
function function_38d64430(slot, weapon) {
    self flagsys::clear("gadget_ravage_core_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.ravage_core)) {
        self [[ level.cybercom.ravage_core._off ]](slot, weapon);
    }
}

