#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace gadget_misdirection;

// Namespace gadget_misdirection/gadget_misdirection
// Params 0, eflags: 0x2
// Checksum 0x8c07a465, Offset: 0x230
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_misdirection", &__init__, undefined, undefined);
}

// Namespace gadget_misdirection/gadget_misdirection
// Params 0, eflags: 0x0
// Checksum 0x1733b932, Offset: 0x270
// Size: 0x104
function __init__() {
    ability_player::register_gadget_activation_callbacks(37, &gadget_misdirection_on, &gadget_misdirection_off);
    ability_player::register_gadget_possession_callbacks(37, &gadget_misdirection_on_give, &gadget_misdirection_on_take);
    ability_player::register_gadget_flicker_callbacks(37, &gadget_misdirection_on_flicker);
    ability_player::register_gadget_is_inuse_callbacks(37, &gadget_misdirection_is_inuse);
    ability_player::register_gadget_is_flickering_callbacks(37, &gadget_misdirection_is_flickering);
    ability_player::register_gadget_primed_callbacks(37, &gadget_misdirection_is_primed);
    callback::on_connect(&gadget_misdirection_on_connect);
}

// Namespace gadget_misdirection/gadget_misdirection
// Params 1, eflags: 0x0
// Checksum 0xf7e485b3, Offset: 0x380
// Size: 0x2a
function gadget_misdirection_is_inuse(slot) {
    return self flagsys::get("gadget_misdirection_on");
}

// Namespace gadget_misdirection/gadget_misdirection
// Params 1, eflags: 0x0
// Checksum 0xdc2c58e0, Offset: 0x3b8
// Size: 0x5e
function gadget_misdirection_is_flickering(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.misdirection)) {
        return self [[ level.cybercom.misdirection._is_flickering ]](slot);
    }
    return 0;
}

// Namespace gadget_misdirection/gadget_misdirection
// Params 2, eflags: 0x0
// Checksum 0x49fb7906, Offset: 0x420
// Size: 0x68
function gadget_misdirection_on_flicker(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.misdirection)) {
        self [[ level.cybercom.misdirection._on_flicker ]](slot, weapon);
    }
}

// Namespace gadget_misdirection/gadget_misdirection
// Params 2, eflags: 0x0
// Checksum 0x4443d102, Offset: 0x490
// Size: 0x68
function gadget_misdirection_on_give(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.misdirection)) {
        self [[ level.cybercom.misdirection._on_give ]](slot, weapon);
    }
}

// Namespace gadget_misdirection/gadget_misdirection
// Params 2, eflags: 0x0
// Checksum 0x24bb0dba, Offset: 0x500
// Size: 0x68
function gadget_misdirection_on_take(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.misdirection)) {
        self [[ level.cybercom.misdirection._on_take ]](slot, weapon);
    }
}

// Namespace gadget_misdirection/gadget_misdirection
// Params 0, eflags: 0x0
// Checksum 0x4da30321, Offset: 0x570
// Size: 0x50
function gadget_misdirection_on_connect() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.misdirection)) {
        self [[ level.cybercom.misdirection._on_connect ]]();
    }
}

// Namespace gadget_misdirection/gadget_misdirection
// Params 2, eflags: 0x0
// Checksum 0x585eea58, Offset: 0x5c8
// Size: 0x88
function gadget_misdirection_on(slot, weapon) {
    self flagsys::set("gadget_misdirection_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.misdirection)) {
        self [[ level.cybercom.misdirection._on ]](slot, weapon);
    }
}

// Namespace gadget_misdirection/gadget_misdirection
// Params 2, eflags: 0x0
// Checksum 0xe71aa3ed, Offset: 0x658
// Size: 0x88
function gadget_misdirection_off(slot, weapon) {
    self flagsys::clear("gadget_misdirection_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.misdirection)) {
        self [[ level.cybercom.misdirection._off ]](slot, weapon);
    }
}

// Namespace gadget_misdirection/gadget_misdirection
// Params 2, eflags: 0x0
// Checksum 0x43f64212, Offset: 0x6e8
// Size: 0x68
function gadget_misdirection_is_primed(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.misdirection)) {
        self [[ level.cybercom.misdirection._is_primed ]](slot, weapon);
    }
}

