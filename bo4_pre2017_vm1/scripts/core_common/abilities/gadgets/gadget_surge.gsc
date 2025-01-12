#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace namespace_fa9832ca;

// Namespace namespace_fa9832ca/namespace_fa9832ca
// Params 0, eflags: 0x2
// Checksum 0xcbaf0c2f, Offset: 0x218
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_surge", &__init__, undefined, undefined);
}

// Namespace namespace_fa9832ca/namespace_fa9832ca
// Params 0, eflags: 0x0
// Checksum 0x234fb697, Offset: 0x258
// Size: 0x104
function __init__() {
    ability_player::register_gadget_activation_callbacks(21, &function_c6108dba, &function_ebb88a60);
    ability_player::register_gadget_possession_callbacks(21, &function_113a0c6e, &function_aa2b0180);
    ability_player::register_gadget_flicker_callbacks(21, &function_3f2d883);
    ability_player::register_gadget_is_inuse_callbacks(21, &function_8721bfa);
    ability_player::register_gadget_is_flickering_callbacks(21, &function_e4b7ee54);
    ability_player::register_gadget_primed_callbacks(21, &function_5ff9a66b);
    callback::on_connect(&function_e8723625);
}

// Namespace namespace_fa9832ca/namespace_fa9832ca
// Params 1, eflags: 0x0
// Checksum 0xcff79bcf, Offset: 0x368
// Size: 0x2a
function function_8721bfa(slot) {
    return self flagsys::get("gadget_surge_on");
}

// Namespace namespace_fa9832ca/namespace_fa9832ca
// Params 1, eflags: 0x0
// Checksum 0x779debc6, Offset: 0x3a0
// Size: 0x5c
function function_e4b7ee54(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.surge)) {
        return self [[ level.cybercom.surge.var_875da84b ]](slot);
    }
}

// Namespace namespace_fa9832ca/namespace_fa9832ca
// Params 2, eflags: 0x0
// Checksum 0xe71e3f2a, Offset: 0x408
// Size: 0x68
function function_3f2d883(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.surge)) {
        self [[ level.cybercom.surge.var_8d01efb6 ]](slot, weapon);
    }
}

// Namespace namespace_fa9832ca/namespace_fa9832ca
// Params 2, eflags: 0x0
// Checksum 0xd1c5e2a0, Offset: 0x478
// Size: 0x68
function function_113a0c6e(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.surge)) {
        self [[ level.cybercom.surge.var_bdb47551 ]](slot, weapon);
    }
}

// Namespace namespace_fa9832ca/namespace_fa9832ca
// Params 2, eflags: 0x0
// Checksum 0xc65178f2, Offset: 0x4e8
// Size: 0x68
function function_aa2b0180(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.surge)) {
        self [[ level.cybercom.surge.var_39ea6a1b ]](slot, weapon);
    }
}

// Namespace namespace_fa9832ca/namespace_fa9832ca
// Params 0, eflags: 0x0
// Checksum 0xcda1b9c7, Offset: 0x558
// Size: 0x50
function function_e8723625() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.surge)) {
        self [[ level.cybercom.surge.var_5d2fec30 ]]();
    }
}

// Namespace namespace_fa9832ca/namespace_fa9832ca
// Params 2, eflags: 0x0
// Checksum 0xc05b302b, Offset: 0x5b0
// Size: 0x88
function function_c6108dba(slot, weapon) {
    self flagsys::set("gadget_surge_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.surge)) {
        self [[ level.cybercom.surge._on ]](slot, weapon);
    }
}

// Namespace namespace_fa9832ca/namespace_fa9832ca
// Params 2, eflags: 0x0
// Checksum 0xf745e786, Offset: 0x640
// Size: 0x88
function function_ebb88a60(slot, weapon) {
    self flagsys::clear("gadget_surge_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.surge)) {
        self [[ level.cybercom.surge._off ]](slot, weapon);
    }
}

// Namespace namespace_fa9832ca/namespace_fa9832ca
// Params 2, eflags: 0x0
// Checksum 0x4553519c, Offset: 0x6d0
// Size: 0x68
function function_5ff9a66b(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.surge)) {
        self [[ level.cybercom.surge.var_4135a1c4 ]](slot, weapon);
    }
}

