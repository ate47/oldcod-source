#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace gadget_cacophany;

// Namespace gadget_cacophany/gadget_cacophany
// Params 0, eflags: 0x2
// Checksum 0x5bfb3aa, Offset: 0x228
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_cacophany", &__init__, undefined, undefined);
}

// Namespace gadget_cacophany/gadget_cacophany
// Params 0, eflags: 0x0
// Checksum 0xed7e4d6c, Offset: 0x268
// Size: 0x104
function __init__() {
    ability_player::register_gadget_activation_callbacks(25, &gadget_cacophany_on, &gadget_cacophany_off);
    ability_player::register_gadget_possession_callbacks(25, &gadget_cacophany_on_give, &gadget_cacophany_on_take);
    ability_player::register_gadget_flicker_callbacks(25, &gadget_cacophany_on_flicker);
    ability_player::register_gadget_is_inuse_callbacks(25, &gadget_cacophany_is_inuse);
    ability_player::register_gadget_is_flickering_callbacks(25, &gadget_cacophany_is_flickering);
    ability_player::register_gadget_primed_callbacks(25, &gadget_cacophany_is_primed);
    callback::on_connect(&gadget_cacophany_on_connect);
}

// Namespace gadget_cacophany/gadget_cacophany
// Params 1, eflags: 0x0
// Checksum 0xc35c3e85, Offset: 0x378
// Size: 0x2a
function gadget_cacophany_is_inuse(slot) {
    return self flagsys::get("gadget_cacophany_on");
}

// Namespace gadget_cacophany/gadget_cacophany
// Params 1, eflags: 0x0
// Checksum 0x93a8d287, Offset: 0x3b0
// Size: 0x5c
function gadget_cacophany_is_flickering(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.cacophany)) {
        return self [[ level.cybercom.cacophany._is_flickering ]](slot);
    }
}

// Namespace gadget_cacophany/gadget_cacophany
// Params 2, eflags: 0x0
// Checksum 0x44acccd1, Offset: 0x418
// Size: 0x68
function gadget_cacophany_on_flicker(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.cacophany)) {
        self [[ level.cybercom.cacophany._on_flicker ]](slot, weapon);
    }
}

// Namespace gadget_cacophany/gadget_cacophany
// Params 2, eflags: 0x0
// Checksum 0xd9748397, Offset: 0x488
// Size: 0x68
function gadget_cacophany_on_give(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.cacophany)) {
        self [[ level.cybercom.cacophany._on_give ]](slot, weapon);
    }
}

// Namespace gadget_cacophany/gadget_cacophany
// Params 2, eflags: 0x0
// Checksum 0x9301f070, Offset: 0x4f8
// Size: 0x68
function gadget_cacophany_on_take(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.cacophany)) {
        self [[ level.cybercom.cacophany._on_take ]](slot, weapon);
    }
}

// Namespace gadget_cacophany/gadget_cacophany
// Params 0, eflags: 0x0
// Checksum 0xb00dd439, Offset: 0x568
// Size: 0x50
function gadget_cacophany_on_connect() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.cacophany)) {
        self [[ level.cybercom.cacophany._on_connect ]]();
    }
}

// Namespace gadget_cacophany/gadget_cacophany
// Params 2, eflags: 0x0
// Checksum 0xad2cf24a, Offset: 0x5c0
// Size: 0x88
function gadget_cacophany_on(slot, weapon) {
    self flagsys::set("gadget_cacophany_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.cacophany)) {
        self [[ level.cybercom.cacophany._on ]](slot, weapon);
    }
}

// Namespace gadget_cacophany/gadget_cacophany
// Params 2, eflags: 0x0
// Checksum 0xf472bee5, Offset: 0x650
// Size: 0x88
function gadget_cacophany_off(slot, weapon) {
    self flagsys::clear("gadget_cacophany_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.cacophany)) {
        self [[ level.cybercom.cacophany._off ]](slot, weapon);
    }
}

// Namespace gadget_cacophany/gadget_cacophany
// Params 2, eflags: 0x0
// Checksum 0xe713721e, Offset: 0x6e0
// Size: 0x68
function gadget_cacophany_is_primed(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.cacophany)) {
        self [[ level.cybercom.cacophany._is_primed ]](slot, weapon);
    }
}

