#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace namespace_5f3ec5b3;

// Namespace namespace_5f3ec5b3/namespace_5f3ec5b3
// Params 0, eflags: 0x2
// Checksum 0x8a405632, Offset: 0x260
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_unstoppable_force", &__init__, undefined, undefined);
}

// Namespace namespace_5f3ec5b3/namespace_5f3ec5b3
// Params 0, eflags: 0x0
// Checksum 0x31539b6, Offset: 0x2a0
// Size: 0x114
function __init__() {
    ability_player::register_gadget_activation_callbacks(29, &function_d693cc29, &function_f5f70c55);
    ability_player::register_gadget_possession_callbacks(29, &function_b94ad56f, &function_4f4c1f25);
    ability_player::register_gadget_flicker_callbacks(29, &function_c6dc2378);
    ability_player::register_gadget_is_inuse_callbacks(29, &function_ae33369);
    ability_player::register_gadget_is_flickering_callbacks(29, &function_e70192cd);
    callback::on_connect(&function_23dd24ee);
    clientfield::register("toplayer", "unstoppableforce_state", 1, 1, "int");
}

// Namespace namespace_5f3ec5b3/namespace_5f3ec5b3
// Params 1, eflags: 0x0
// Checksum 0x70c3a038, Offset: 0x3c0
// Size: 0x2a
function function_ae33369(slot) {
    return self flagsys::get("gadget_unstoppable_force_on");
}

// Namespace namespace_5f3ec5b3/namespace_5f3ec5b3
// Params 1, eflags: 0x0
// Checksum 0xc0b9c318, Offset: 0x3f8
// Size: 0x5e
function function_e70192cd(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.unstoppable_force)) {
        return self [[ level.cybercom.unstoppable_force.var_875da84b ]](slot);
    }
    return 0;
}

// Namespace namespace_5f3ec5b3/namespace_5f3ec5b3
// Params 2, eflags: 0x0
// Checksum 0x8cce773b, Offset: 0x460
// Size: 0x68
function function_c6dc2378(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.unstoppable_force)) {
        self [[ level.cybercom.unstoppable_force.var_8d01efb6 ]](slot, weapon);
    }
}

// Namespace namespace_5f3ec5b3/namespace_5f3ec5b3
// Params 2, eflags: 0x0
// Checksum 0xf7b23c42, Offset: 0x4d0
// Size: 0x68
function function_b94ad56f(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.unstoppable_force)) {
        self [[ level.cybercom.unstoppable_force.var_bdb47551 ]](slot, weapon);
    }
}

// Namespace namespace_5f3ec5b3/namespace_5f3ec5b3
// Params 2, eflags: 0x0
// Checksum 0x7406c0b0, Offset: 0x540
// Size: 0x68
function function_4f4c1f25(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.unstoppable_force)) {
        self [[ level.cybercom.unstoppable_force.var_39ea6a1b ]](slot, weapon);
    }
}

// Namespace namespace_5f3ec5b3/namespace_5f3ec5b3
// Params 0, eflags: 0x0
// Checksum 0xaa557323, Offset: 0x5b0
// Size: 0x50
function function_23dd24ee() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.unstoppable_force)) {
        self [[ level.cybercom.unstoppable_force.var_5d2fec30 ]]();
    }
}

// Namespace namespace_5f3ec5b3/namespace_5f3ec5b3
// Params 2, eflags: 0x0
// Checksum 0xcbf99198, Offset: 0x608
// Size: 0x88
function function_d693cc29(slot, weapon) {
    self flagsys::set("gadget_unstoppable_force_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.unstoppable_force)) {
        self [[ level.cybercom.unstoppable_force._on ]](slot, weapon);
    }
}

// Namespace namespace_5f3ec5b3/namespace_5f3ec5b3
// Params 2, eflags: 0x0
// Checksum 0x33c6a5ec, Offset: 0x698
// Size: 0x88
function function_f5f70c55(slot, weapon) {
    self flagsys::clear("gadget_unstoppable_force_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.unstoppable_force)) {
        self [[ level.cybercom.unstoppable_force._off ]](slot, weapon);
    }
}

// Namespace namespace_5f3ec5b3/namespace_5f3ec5b3
// Params 2, eflags: 0x0
// Checksum 0x4524e958, Offset: 0x728
// Size: 0x68
function function_9d2a518e(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.unstoppable_force)) {
        self [[ level.cybercom.unstoppable_force.var_4135a1c4 ]](slot, weapon);
    }
}

