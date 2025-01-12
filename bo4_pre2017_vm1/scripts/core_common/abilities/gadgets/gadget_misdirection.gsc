#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace namespace_7e517e7c;

// Namespace namespace_7e517e7c/namespace_7e517e7c
// Params 0, eflags: 0x2
// Checksum 0x8c07a465, Offset: 0x230
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_misdirection", &__init__, undefined, undefined);
}

// Namespace namespace_7e517e7c/namespace_7e517e7c
// Params 0, eflags: 0x0
// Checksum 0x1733b932, Offset: 0x270
// Size: 0x104
function __init__() {
    ability_player::register_gadget_activation_callbacks(37, &function_6167a54, &function_53a55062);
    ability_player::register_gadget_possession_callbacks(37, &function_3149bee8, &function_7884e9fe);
    ability_player::register_gadget_flicker_callbacks(37, &function_44f18e39);
    ability_player::register_gadget_is_inuse_callbacks(37, &function_7f86bbdc);
    ability_player::register_gadget_is_flickering_callbacks(37, &function_a3f0292);
    ability_player::register_gadget_primed_callbacks(37, &function_a84bf2fd);
    callback::on_connect(&function_8270f877);
}

// Namespace namespace_7e517e7c/namespace_7e517e7c
// Params 1, eflags: 0x0
// Checksum 0xf7e485b3, Offset: 0x380
// Size: 0x2a
function function_7f86bbdc(slot) {
    return self flagsys::get("gadget_misdirection_on");
}

// Namespace namespace_7e517e7c/namespace_7e517e7c
// Params 1, eflags: 0x0
// Checksum 0xdc2c58e0, Offset: 0x3b8
// Size: 0x5e
function function_a3f0292(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.misdirection)) {
        return self [[ level.cybercom.misdirection.var_875da84b ]](slot);
    }
    return 0;
}

// Namespace namespace_7e517e7c/namespace_7e517e7c
// Params 2, eflags: 0x0
// Checksum 0x49fb7906, Offset: 0x420
// Size: 0x68
function function_44f18e39(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.misdirection)) {
        self [[ level.cybercom.misdirection.var_8d01efb6 ]](slot, weapon);
    }
}

// Namespace namespace_7e517e7c/namespace_7e517e7c
// Params 2, eflags: 0x0
// Checksum 0x4443d102, Offset: 0x490
// Size: 0x68
function function_3149bee8(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.misdirection)) {
        self [[ level.cybercom.misdirection.var_bdb47551 ]](slot, weapon);
    }
}

// Namespace namespace_7e517e7c/namespace_7e517e7c
// Params 2, eflags: 0x0
// Checksum 0x24bb0dba, Offset: 0x500
// Size: 0x68
function function_7884e9fe(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.misdirection)) {
        self [[ level.cybercom.misdirection.var_39ea6a1b ]](slot, weapon);
    }
}

// Namespace namespace_7e517e7c/namespace_7e517e7c
// Params 0, eflags: 0x0
// Checksum 0x4da30321, Offset: 0x570
// Size: 0x50
function function_8270f877() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.misdirection)) {
        self [[ level.cybercom.misdirection.var_5d2fec30 ]]();
    }
}

// Namespace namespace_7e517e7c/namespace_7e517e7c
// Params 2, eflags: 0x0
// Checksum 0x585eea58, Offset: 0x5c8
// Size: 0x88
function function_6167a54(slot, weapon) {
    self flagsys::set("gadget_misdirection_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.misdirection)) {
        self [[ level.cybercom.misdirection._on ]](slot, weapon);
    }
}

// Namespace namespace_7e517e7c/namespace_7e517e7c
// Params 2, eflags: 0x0
// Checksum 0xe71aa3ed, Offset: 0x658
// Size: 0x88
function function_53a55062(slot, weapon) {
    self flagsys::clear("gadget_misdirection_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.misdirection)) {
        self [[ level.cybercom.misdirection._off ]](slot, weapon);
    }
}

// Namespace namespace_7e517e7c/namespace_7e517e7c
// Params 2, eflags: 0x0
// Checksum 0x43f64212, Offset: 0x6e8
// Size: 0x68
function function_a84bf2fd(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.misdirection)) {
        self [[ level.cybercom.misdirection.var_4135a1c4 ]](slot, weapon);
    }
}

