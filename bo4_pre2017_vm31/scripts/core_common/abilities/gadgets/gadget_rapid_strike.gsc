#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace gadget_rapid_strike;

// Namespace gadget_rapid_strike/gadget_rapid_strike
// Params 0, eflags: 0x2
// Checksum 0x2204fcfb, Offset: 0x230
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_rapid_strike", &__init__, undefined, undefined);
}

// Namespace gadget_rapid_strike/gadget_rapid_strike
// Params 0, eflags: 0x0
// Checksum 0x73b87653, Offset: 0x270
// Size: 0xe4
function __init__() {
    ability_player::register_gadget_activation_callbacks(30, &gadget_rapid_strike_on, &gadget_rapid_strike_off);
    ability_player::register_gadget_possession_callbacks(30, &gadget_rapid_strike_on_give, &gadget_rapid_strike_on_take);
    ability_player::register_gadget_flicker_callbacks(30, &gadget_rapid_strike_on_flicker);
    ability_player::register_gadget_is_inuse_callbacks(30, &gadget_rapid_strike_is_inuse);
    ability_player::register_gadget_is_flickering_callbacks(30, &gadget_rapid_strike_is_flickering);
    callback::on_connect(&gadget_rapid_strike_on_connect);
}

// Namespace gadget_rapid_strike/gadget_rapid_strike
// Params 1, eflags: 0x0
// Checksum 0x60288d9d, Offset: 0x360
// Size: 0x2a
function gadget_rapid_strike_is_inuse(slot) {
    return self flagsys::get("gadget_rapid_strike_on");
}

// Namespace gadget_rapid_strike/gadget_rapid_strike
// Params 1, eflags: 0x0
// Checksum 0xd9b7024b, Offset: 0x398
// Size: 0x5c
function gadget_rapid_strike_is_flickering(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.rapid_strike)) {
        return self [[ level.cybercom.rapid_strike._is_flickering ]](slot);
    }
}

// Namespace gadget_rapid_strike/gadget_rapid_strike
// Params 2, eflags: 0x0
// Checksum 0xa00cd6fa, Offset: 0x400
// Size: 0x68
function gadget_rapid_strike_on_flicker(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.rapid_strike)) {
        self [[ level.cybercom.rapid_strike._on_flicker ]](slot, weapon);
    }
}

// Namespace gadget_rapid_strike/gadget_rapid_strike
// Params 2, eflags: 0x0
// Checksum 0xd523ee0e, Offset: 0x470
// Size: 0x68
function gadget_rapid_strike_on_give(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.rapid_strike)) {
        self [[ level.cybercom.rapid_strike._on_give ]](slot, weapon);
    }
}

// Namespace gadget_rapid_strike/gadget_rapid_strike
// Params 2, eflags: 0x0
// Checksum 0x8647d87b, Offset: 0x4e0
// Size: 0x68
function gadget_rapid_strike_on_take(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.rapid_strike)) {
        self [[ level.cybercom.rapid_strike._on_take ]](slot, weapon);
    }
}

// Namespace gadget_rapid_strike/gadget_rapid_strike
// Params 0, eflags: 0x0
// Checksum 0xda6fb6d2, Offset: 0x550
// Size: 0x50
function gadget_rapid_strike_on_connect() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.rapid_strike)) {
        self [[ level.cybercom.rapid_strike._on_connect ]]();
    }
}

// Namespace gadget_rapid_strike/gadget_rapid_strike
// Params 2, eflags: 0x0
// Checksum 0x3abf6e8, Offset: 0x5a8
// Size: 0x88
function gadget_rapid_strike_on(slot, weapon) {
    self flagsys::set("gadget_rapid_strike_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.rapid_strike)) {
        self [[ level.cybercom.rapid_strike._on ]](slot, weapon);
    }
}

// Namespace gadget_rapid_strike/gadget_rapid_strike
// Params 2, eflags: 0x0
// Checksum 0xd0cc9727, Offset: 0x638
// Size: 0x88
function gadget_rapid_strike_off(slot, weapon) {
    self flagsys::clear("gadget_rapid_strike_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.rapid_strike)) {
        self [[ level.cybercom.rapid_strike._off ]](slot, weapon);
    }
}

