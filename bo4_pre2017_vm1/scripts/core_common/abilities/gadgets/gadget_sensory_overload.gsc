#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace namespace_561afc08;

// Namespace namespace_561afc08/namespace_561afc08
// Params 0, eflags: 0x2
// Checksum 0x1ac99db6, Offset: 0x238
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_sensory_overload", &__init__, undefined, undefined);
}

// Namespace namespace_561afc08/namespace_561afc08
// Params 0, eflags: 0x0
// Checksum 0xc9499478, Offset: 0x278
// Size: 0x104
function __init__() {
    ability_player::register_gadget_activation_callbacks(32, &function_15e437b0, &function_c1d76ffe);
    ability_player::register_gadget_possession_callbacks(32, &function_b0d7efec, &function_d9c4129a);
    ability_player::register_gadget_flicker_callbacks(32, &function_ceab21e5);
    ability_player::register_gadget_is_inuse_callbacks(32, &function_1a766e18);
    ability_player::register_gadget_is_flickering_callbacks(32, &function_d34dd456);
    ability_player::register_gadget_primed_callbacks(32, &function_ce8bf231);
    callback::on_connect(&function_e100d1c3);
}

// Namespace namespace_561afc08/namespace_561afc08
// Params 1, eflags: 0x0
// Checksum 0x4817464c, Offset: 0x388
// Size: 0x2a
function function_1a766e18(slot) {
    return self flagsys::get("gadget_sensory_overload_on");
}

// Namespace namespace_561afc08/namespace_561afc08
// Params 1, eflags: 0x0
// Checksum 0xe2df6f74, Offset: 0x3c0
// Size: 0x5c
function function_d34dd456(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.sensory_overload)) {
        return self [[ level.cybercom.sensory_overload.var_875da84b ]](slot);
    }
}

// Namespace namespace_561afc08/namespace_561afc08
// Params 2, eflags: 0x0
// Checksum 0x930a45c4, Offset: 0x428
// Size: 0x68
function function_ceab21e5(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.sensory_overload)) {
        self [[ level.cybercom.sensory_overload.var_8d01efb6 ]](slot, weapon);
    }
}

// Namespace namespace_561afc08/namespace_561afc08
// Params 2, eflags: 0x0
// Checksum 0x3a52146f, Offset: 0x498
// Size: 0x68
function function_b0d7efec(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.sensory_overload)) {
        self [[ level.cybercom.sensory_overload.var_bdb47551 ]](slot, weapon);
    }
}

// Namespace namespace_561afc08/namespace_561afc08
// Params 2, eflags: 0x0
// Checksum 0x75d4b78a, Offset: 0x508
// Size: 0x68
function function_d9c4129a(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.sensory_overload)) {
        self [[ level.cybercom.sensory_overload.var_39ea6a1b ]](slot, weapon);
    }
}

// Namespace namespace_561afc08/namespace_561afc08
// Params 0, eflags: 0x0
// Checksum 0x81edcac6, Offset: 0x578
// Size: 0x50
function function_e100d1c3() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.sensory_overload)) {
        self [[ level.cybercom.sensory_overload.var_5d2fec30 ]]();
    }
}

// Namespace namespace_561afc08/namespace_561afc08
// Params 2, eflags: 0x0
// Checksum 0x9367b71f, Offset: 0x5d0
// Size: 0x88
function function_15e437b0(slot, weapon) {
    self flagsys::set("gadget_sensory_overload_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.sensory_overload)) {
        self [[ level.cybercom.sensory_overload._on ]](slot, weapon);
    }
}

// Namespace namespace_561afc08/namespace_561afc08
// Params 2, eflags: 0x0
// Checksum 0x6eb66e22, Offset: 0x660
// Size: 0x88
function function_c1d76ffe(slot, weapon) {
    self flagsys::clear("gadget_sensory_overload_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.sensory_overload)) {
        self [[ level.cybercom.sensory_overload._off ]](slot, weapon);
    }
}

// Namespace namespace_561afc08/namespace_561afc08
// Params 2, eflags: 0x0
// Checksum 0x2f13661e, Offset: 0x6f0
// Size: 0x68
function function_ce8bf231(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.sensory_overload)) {
        self [[ level.cybercom.sensory_overload.var_4135a1c4 ]](slot, weapon);
    }
}

