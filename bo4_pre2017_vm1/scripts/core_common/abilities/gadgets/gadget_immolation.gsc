#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace gadget_immolation;

// Namespace gadget_immolation/gadget_immolation
// Params 0, eflags: 0x2
// Checksum 0x2ded66ff, Offset: 0x228
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_immolation", &__init__, undefined, undefined);
}

// Namespace gadget_immolation/gadget_immolation
// Params 0, eflags: 0x0
// Checksum 0xa1428bce, Offset: 0x268
// Size: 0x104
function __init__() {
    ability_player::register_gadget_activation_callbacks(34, &gadget_immolation_on, &gadget_immolation_off);
    ability_player::register_gadget_possession_callbacks(34, &gadget_immolation_on_give, &gadget_immolation_on_take);
    ability_player::register_gadget_flicker_callbacks(34, &gadget_immolation_on_flicker);
    ability_player::register_gadget_is_inuse_callbacks(34, &gadget_immolation_is_inuse);
    ability_player::register_gadget_is_flickering_callbacks(34, &gadget_immolation_is_flickering);
    ability_player::register_gadget_primed_callbacks(34, &gadget_immolation_is_primed);
    callback::on_connect(&gadget_immolation_on_connect);
}

// Namespace gadget_immolation/gadget_immolation
// Params 1, eflags: 0x0
// Checksum 0x8e7029d, Offset: 0x378
// Size: 0x2a
function gadget_immolation_is_inuse(slot) {
    return self flagsys::get("gadget_immolation_on");
}

// Namespace gadget_immolation/gadget_immolation
// Params 1, eflags: 0x0
// Checksum 0xf2d89ac8, Offset: 0x3b0
// Size: 0x5e
function gadget_immolation_is_flickering(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.immolation)) {
        return self [[ level.cybercom.immolation._is_flickering ]](slot);
    }
    return 0;
}

// Namespace gadget_immolation/gadget_immolation
// Params 2, eflags: 0x0
// Checksum 0xe7fb1cc0, Offset: 0x418
// Size: 0x68
function gadget_immolation_on_flicker(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.immolation)) {
        self [[ level.cybercom.immolation._on_flicker ]](slot, weapon);
    }
}

// Namespace gadget_immolation/gadget_immolation
// Params 2, eflags: 0x0
// Checksum 0x38eb2afe, Offset: 0x488
// Size: 0x68
function gadget_immolation_on_give(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.immolation)) {
        self [[ level.cybercom.immolation._on_give ]](slot, weapon);
    }
}

// Namespace gadget_immolation/gadget_immolation
// Params 2, eflags: 0x0
// Checksum 0x14d9952, Offset: 0x4f8
// Size: 0x68
function gadget_immolation_on_take(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.immolation)) {
        self [[ level.cybercom.immolation._on_take ]](slot, weapon);
    }
}

// Namespace gadget_immolation/gadget_immolation
// Params 0, eflags: 0x0
// Checksum 0x18eeba40, Offset: 0x568
// Size: 0x50
function gadget_immolation_on_connect() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.immolation)) {
        self [[ level.cybercom.immolation._on_connect ]]();
    }
}

// Namespace gadget_immolation/gadget_immolation
// Params 2, eflags: 0x0
// Checksum 0xf84db01f, Offset: 0x5c0
// Size: 0x88
function gadget_immolation_on(slot, weapon) {
    self flagsys::set("gadget_immolation_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.immolation)) {
        self [[ level.cybercom.immolation._on ]](slot, weapon);
    }
}

// Namespace gadget_immolation/gadget_immolation
// Params 2, eflags: 0x0
// Checksum 0x2d243a38, Offset: 0x650
// Size: 0x88
function gadget_immolation_off(slot, weapon) {
    self flagsys::clear("gadget_immolation_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.immolation)) {
        self [[ level.cybercom.immolation._off ]](slot, weapon);
    }
}

// Namespace gadget_immolation/gadget_immolation
// Params 2, eflags: 0x0
// Checksum 0x1cf3108d, Offset: 0x6e0
// Size: 0x68
function gadget_immolation_is_primed(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.immolation)) {
        self [[ level.cybercom.immolation._is_primed ]](slot, weapon);
    }
}

