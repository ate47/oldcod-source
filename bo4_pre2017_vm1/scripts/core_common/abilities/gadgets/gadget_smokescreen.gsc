#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace namespace_8c49c767;

// Namespace namespace_8c49c767/namespace_8c49c767
// Params 0, eflags: 0x2
// Checksum 0x8dcc17c5, Offset: 0x230
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_smokescreen", &__init__, undefined, undefined);
}

// Namespace namespace_8c49c767/namespace_8c49c767
// Params 0, eflags: 0x0
// Checksum 0xea9e9d95, Offset: 0x270
// Size: 0x104
function __init__() {
    ability_player::register_gadget_activation_callbacks(36, &function_bd67c28d, &function_89901879);
    ability_player::register_gadget_possession_callbacks(36, &function_a17871ab, &function_70f70b89);
    ability_player::register_gadget_flicker_callbacks(36, &function_bfb84b6c);
    ability_player::register_gadget_is_inuse_callbacks(36, &function_ceb5552d);
    ability_player::register_gadget_is_flickering_callbacks(36, &function_43a90939);
    ability_player::register_gadget_primed_callbacks(36, &function_e11cf076);
    callback::on_connect(&function_53ff0722);
}

// Namespace namespace_8c49c767/namespace_8c49c767
// Params 1, eflags: 0x0
// Checksum 0x5dcf4f73, Offset: 0x380
// Size: 0x2a
function function_ceb5552d(slot) {
    return self flagsys::get("gadget_smokescreen_on");
}

// Namespace namespace_8c49c767/namespace_8c49c767
// Params 1, eflags: 0x0
// Checksum 0x35366811, Offset: 0x3b8
// Size: 0x5e
function function_43a90939(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.smokescreen)) {
        return self [[ level.cybercom.smokescreen.var_875da84b ]](slot);
    }
    return 0;
}

// Namespace namespace_8c49c767/namespace_8c49c767
// Params 2, eflags: 0x0
// Checksum 0x72262243, Offset: 0x420
// Size: 0x68
function function_bfb84b6c(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.smokescreen)) {
        self [[ level.cybercom.smokescreen.var_8d01efb6 ]](slot, weapon);
    }
}

// Namespace namespace_8c49c767/namespace_8c49c767
// Params 2, eflags: 0x0
// Checksum 0xd375f064, Offset: 0x490
// Size: 0x68
function function_a17871ab(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.smokescreen)) {
        self [[ level.cybercom.smokescreen.var_bdb47551 ]](slot, weapon);
    }
}

// Namespace namespace_8c49c767/namespace_8c49c767
// Params 2, eflags: 0x0
// Checksum 0xa8a04c3, Offset: 0x500
// Size: 0x68
function function_70f70b89(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.smokescreen)) {
        self [[ level.cybercom.smokescreen.var_39ea6a1b ]](slot, weapon);
    }
}

// Namespace namespace_8c49c767/namespace_8c49c767
// Params 0, eflags: 0x0
// Checksum 0xcf8fcb3b, Offset: 0x570
// Size: 0x50
function function_53ff0722() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.smokescreen)) {
        self [[ level.cybercom.smokescreen.var_5d2fec30 ]]();
    }
}

// Namespace namespace_8c49c767/namespace_8c49c767
// Params 2, eflags: 0x0
// Checksum 0xe91309e6, Offset: 0x5c8
// Size: 0x88
function function_bd67c28d(slot, weapon) {
    self flagsys::set("gadget_smokescreen_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.smokescreen)) {
        self [[ level.cybercom.smokescreen._on ]](slot, weapon);
    }
}

// Namespace namespace_8c49c767/namespace_8c49c767
// Params 2, eflags: 0x0
// Checksum 0x44cbc927, Offset: 0x658
// Size: 0x88
function function_89901879(slot, weapon) {
    self flagsys::clear("gadget_smokescreen_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.smokescreen)) {
        self [[ level.cybercom.smokescreen._off ]](slot, weapon);
    }
}

// Namespace namespace_8c49c767/namespace_8c49c767
// Params 2, eflags: 0x0
// Checksum 0xc9b0a742, Offset: 0x6e8
// Size: 0x68
function function_e11cf076(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.smokescreen)) {
        self [[ level.cybercom.smokescreen.var_4135a1c4 ]](slot, weapon);
    }
}

