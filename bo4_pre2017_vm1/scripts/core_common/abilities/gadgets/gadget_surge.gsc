#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace gadget_surge;

// Namespace gadget_surge/gadget_surge
// Params 0, eflags: 0x2
// Checksum 0xcbaf0c2f, Offset: 0x218
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_surge", &__init__, undefined, undefined);
}

// Namespace gadget_surge/gadget_surge
// Params 0, eflags: 0x0
// Checksum 0x234fb697, Offset: 0x258
// Size: 0x104
function __init__() {
    ability_player::register_gadget_activation_callbacks(21, &gadget_surge_on, &gadget_surge_off);
    ability_player::register_gadget_possession_callbacks(21, &gadget_surge_on_give, &gadget_surge_on_take);
    ability_player::register_gadget_flicker_callbacks(21, &gadget_surge_on_flicker);
    ability_player::register_gadget_is_inuse_callbacks(21, &gadget_surge_is_inuse);
    ability_player::register_gadget_is_flickering_callbacks(21, &gadget_surge_is_flickering);
    ability_player::register_gadget_primed_callbacks(21, &gadget_surge_is_primed);
    callback::on_connect(&gadget_surge_on_connect);
}

// Namespace gadget_surge/gadget_surge
// Params 1, eflags: 0x0
// Checksum 0xcff79bcf, Offset: 0x368
// Size: 0x2a
function gadget_surge_is_inuse(slot) {
    return self flagsys::get("gadget_surge_on");
}

// Namespace gadget_surge/gadget_surge
// Params 1, eflags: 0x0
// Checksum 0x779debc6, Offset: 0x3a0
// Size: 0x5c
function gadget_surge_is_flickering(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.surge)) {
        return self [[ level.cybercom.surge._is_flickering ]](slot);
    }
}

// Namespace gadget_surge/gadget_surge
// Params 2, eflags: 0x0
// Checksum 0xe71e3f2a, Offset: 0x408
// Size: 0x68
function gadget_surge_on_flicker(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.surge)) {
        self [[ level.cybercom.surge._on_flicker ]](slot, weapon);
    }
}

// Namespace gadget_surge/gadget_surge
// Params 2, eflags: 0x0
// Checksum 0xd1c5e2a0, Offset: 0x478
// Size: 0x68
function gadget_surge_on_give(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.surge)) {
        self [[ level.cybercom.surge._on_give ]](slot, weapon);
    }
}

// Namespace gadget_surge/gadget_surge
// Params 2, eflags: 0x0
// Checksum 0xc65178f2, Offset: 0x4e8
// Size: 0x68
function gadget_surge_on_take(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.surge)) {
        self [[ level.cybercom.surge._on_take ]](slot, weapon);
    }
}

// Namespace gadget_surge/gadget_surge
// Params 0, eflags: 0x0
// Checksum 0xcda1b9c7, Offset: 0x558
// Size: 0x50
function gadget_surge_on_connect() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.surge)) {
        self [[ level.cybercom.surge._on_connect ]]();
    }
}

// Namespace gadget_surge/gadget_surge
// Params 2, eflags: 0x0
// Checksum 0xc05b302b, Offset: 0x5b0
// Size: 0x88
function gadget_surge_on(slot, weapon) {
    self flagsys::set("gadget_surge_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.surge)) {
        self [[ level.cybercom.surge._on ]](slot, weapon);
    }
}

// Namespace gadget_surge/gadget_surge
// Params 2, eflags: 0x0
// Checksum 0xf745e786, Offset: 0x640
// Size: 0x88
function gadget_surge_off(slot, weapon) {
    self flagsys::clear("gadget_surge_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.surge)) {
        self [[ level.cybercom.surge._off ]](slot, weapon);
    }
}

// Namespace gadget_surge/gadget_surge
// Params 2, eflags: 0x0
// Checksum 0x4553519c, Offset: 0x6d0
// Size: 0x68
function gadget_surge_is_primed(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.surge)) {
        self [[ level.cybercom.surge._is_primed ]](slot, weapon);
    }
}

