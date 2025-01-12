#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace gadget_unstoppable_force;

// Namespace gadget_unstoppable_force/gadget_unstoppable_force
// Params 0, eflags: 0x2
// Checksum 0x8a405632, Offset: 0x260
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_unstoppable_force", &__init__, undefined, undefined);
}

// Namespace gadget_unstoppable_force/gadget_unstoppable_force
// Params 0, eflags: 0x0
// Checksum 0x31539b6, Offset: 0x2a0
// Size: 0x114
function __init__() {
    ability_player::register_gadget_activation_callbacks(29, &gadget_unstoppable_force_on, &gadget_unstoppable_force_off);
    ability_player::register_gadget_possession_callbacks(29, &gadget_unstoppable_force_on_give, &gadget_unstoppable_force_on_take);
    ability_player::register_gadget_flicker_callbacks(29, &gadget_unstoppable_force_on_flicker);
    ability_player::register_gadget_is_inuse_callbacks(29, &gadget_unstoppable_force_is_inuse);
    ability_player::register_gadget_is_flickering_callbacks(29, &gadget_unstoppable_force_is_flickering);
    callback::on_connect(&gadget_unstoppable_force_on_connect);
    clientfield::register("toplayer", "unstoppableforce_state", 1, 1, "int");
}

// Namespace gadget_unstoppable_force/gadget_unstoppable_force
// Params 1, eflags: 0x0
// Checksum 0x70c3a038, Offset: 0x3c0
// Size: 0x2a
function gadget_unstoppable_force_is_inuse(slot) {
    return self flagsys::get("gadget_unstoppable_force_on");
}

// Namespace gadget_unstoppable_force/gadget_unstoppable_force
// Params 1, eflags: 0x0
// Checksum 0xc0b9c318, Offset: 0x3f8
// Size: 0x5e
function gadget_unstoppable_force_is_flickering(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.unstoppable_force)) {
        return self [[ level.cybercom.unstoppable_force._is_flickering ]](slot);
    }
    return 0;
}

// Namespace gadget_unstoppable_force/gadget_unstoppable_force
// Params 2, eflags: 0x0
// Checksum 0x8cce773b, Offset: 0x460
// Size: 0x68
function gadget_unstoppable_force_on_flicker(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.unstoppable_force)) {
        self [[ level.cybercom.unstoppable_force._on_flicker ]](slot, weapon);
    }
}

// Namespace gadget_unstoppable_force/gadget_unstoppable_force
// Params 2, eflags: 0x0
// Checksum 0xf7b23c42, Offset: 0x4d0
// Size: 0x68
function gadget_unstoppable_force_on_give(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.unstoppable_force)) {
        self [[ level.cybercom.unstoppable_force._on_give ]](slot, weapon);
    }
}

// Namespace gadget_unstoppable_force/gadget_unstoppable_force
// Params 2, eflags: 0x0
// Checksum 0x7406c0b0, Offset: 0x540
// Size: 0x68
function gadget_unstoppable_force_on_take(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.unstoppable_force)) {
        self [[ level.cybercom.unstoppable_force._on_take ]](slot, weapon);
    }
}

// Namespace gadget_unstoppable_force/gadget_unstoppable_force
// Params 0, eflags: 0x0
// Checksum 0xaa557323, Offset: 0x5b0
// Size: 0x50
function gadget_unstoppable_force_on_connect() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.unstoppable_force)) {
        self [[ level.cybercom.unstoppable_force._on_connect ]]();
    }
}

// Namespace gadget_unstoppable_force/gadget_unstoppable_force
// Params 2, eflags: 0x0
// Checksum 0xcbf99198, Offset: 0x608
// Size: 0x88
function gadget_unstoppable_force_on(slot, weapon) {
    self flagsys::set("gadget_unstoppable_force_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.unstoppable_force)) {
        self [[ level.cybercom.unstoppable_force._on ]](slot, weapon);
    }
}

// Namespace gadget_unstoppable_force/gadget_unstoppable_force
// Params 2, eflags: 0x0
// Checksum 0x33c6a5ec, Offset: 0x698
// Size: 0x88
function gadget_unstoppable_force_off(slot, weapon) {
    self flagsys::clear("gadget_unstoppable_force_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.unstoppable_force)) {
        self [[ level.cybercom.unstoppable_force._off ]](slot, weapon);
    }
}

// Namespace gadget_unstoppable_force/gadget_unstoppable_force
// Params 2, eflags: 0x0
// Checksum 0x4524e958, Offset: 0x728
// Size: 0x68
function gadget_firefly_is_primed(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.unstoppable_force)) {
        self [[ level.cybercom.unstoppable_force._is_primed ]](slot, weapon);
    }
}

