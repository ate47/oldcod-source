#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace gadget_es_strike;

// Namespace gadget_es_strike/gadget_es_strike
// Params 0, eflags: 0x2
// Checksum 0xebea3f63, Offset: 0x228
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_es_strike", &__init__, undefined, undefined);
}

// Namespace gadget_es_strike/gadget_es_strike
// Params 0, eflags: 0x0
// Checksum 0xfa13f15f, Offset: 0x268
// Size: 0xe4
function __init__() {
    ability_player::register_gadget_activation_callbacks(33, &gadget_es_strike_on, &gadget_es_strike_off);
    ability_player::register_gadget_possession_callbacks(33, &gadget_es_strike_on_give, &gadget_es_strike_on_take);
    ability_player::register_gadget_flicker_callbacks(33, &gadget_es_strike_on_flicker);
    ability_player::register_gadget_is_inuse_callbacks(33, &gadget_es_strike_is_inuse);
    ability_player::register_gadget_is_flickering_callbacks(33, &gadget_es_strike_is_flickering);
    callback::on_connect(&gadget_es_strike_on_connect);
}

// Namespace gadget_es_strike/gadget_es_strike
// Params 1, eflags: 0x0
// Checksum 0x708eed75, Offset: 0x358
// Size: 0x2a
function gadget_es_strike_is_inuse(slot) {
    return self flagsys::get("gadget_es_strike_on");
}

// Namespace gadget_es_strike/gadget_es_strike
// Params 1, eflags: 0x0
// Checksum 0x6d460067, Offset: 0x390
// Size: 0x5c
function gadget_es_strike_is_flickering(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.electro_strike)) {
        return self [[ level.cybercom.electro_strike._is_flickering ]](slot);
    }
}

// Namespace gadget_es_strike/gadget_es_strike
// Params 2, eflags: 0x0
// Checksum 0x1d026125, Offset: 0x3f8
// Size: 0x68
function gadget_es_strike_on_flicker(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.electro_strike)) {
        self [[ level.cybercom.electro_strike._on_flicker ]](slot, weapon);
    }
}

// Namespace gadget_es_strike/gadget_es_strike
// Params 2, eflags: 0x0
// Checksum 0xda34bc7d, Offset: 0x468
// Size: 0x68
function gadget_es_strike_on_give(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.electro_strike)) {
        self [[ level.cybercom.electro_strike._on_give ]](slot, weapon);
    }
}

// Namespace gadget_es_strike/gadget_es_strike
// Params 2, eflags: 0x0
// Checksum 0xafc91072, Offset: 0x4d8
// Size: 0x68
function gadget_es_strike_on_take(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.electro_strike)) {
        self [[ level.cybercom.electro_strike._on_take ]](slot, weapon);
    }
}

// Namespace gadget_es_strike/gadget_es_strike
// Params 0, eflags: 0x0
// Checksum 0xfe1664a4, Offset: 0x548
// Size: 0x50
function gadget_es_strike_on_connect() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.electro_strike)) {
        self [[ level.cybercom.electro_strike._on_connect ]]();
    }
}

// Namespace gadget_es_strike/gadget_es_strike
// Params 2, eflags: 0x0
// Checksum 0x9057aa49, Offset: 0x5a0
// Size: 0x88
function gadget_es_strike_on(slot, weapon) {
    self flagsys::set("gadget_es_strike_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.electro_strike)) {
        self [[ level.cybercom.electro_strike._on ]](slot, weapon);
    }
}

// Namespace gadget_es_strike/gadget_es_strike
// Params 2, eflags: 0x0
// Checksum 0xe140f31a, Offset: 0x630
// Size: 0x88
function gadget_es_strike_off(slot, weapon) {
    self flagsys::clear("gadget_es_strike_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.electro_strike)) {
        self [[ level.cybercom.electro_strike._off ]](slot, weapon);
    }
}

