#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace gadget_security_breach;

// Namespace gadget_security_breach/gadget_security_breach
// Params 0, eflags: 0x2
// Checksum 0x8e424ee7, Offset: 0x238
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_security_breach", &__init__, undefined, undefined);
}

// Namespace gadget_security_breach/gadget_security_breach
// Params 0, eflags: 0x0
// Checksum 0xafbad60a, Offset: 0x278
// Size: 0x104
function __init__() {
    ability_player::register_gadget_activation_callbacks(23, &gadget_security_breach_on, &gadget_security_breach_off);
    ability_player::register_gadget_possession_callbacks(23, &gadget_security_breach_on_give, &gadget_security_breach_on_take);
    ability_player::register_gadget_flicker_callbacks(23, &gadget_security_breach_on_flicker);
    ability_player::register_gadget_is_inuse_callbacks(23, &gadget_security_breach_is_inuse);
    ability_player::register_gadget_is_flickering_callbacks(23, &gadget_security_breach_is_flickering);
    ability_player::register_gadget_primed_callbacks(23, &gadget_security_breach_is_primed);
    callback::on_connect(&gadget_security_breach_on_connect);
}

// Namespace gadget_security_breach/gadget_security_breach
// Params 1, eflags: 0x0
// Checksum 0xb431001c, Offset: 0x388
// Size: 0x2a
function gadget_security_breach_is_inuse(slot) {
    return self flagsys::get("gadget_security_breach_on");
}

// Namespace gadget_security_breach/gadget_security_breach
// Params 1, eflags: 0x0
// Checksum 0x9cfa19cc, Offset: 0x3c0
// Size: 0x5c
function gadget_security_breach_is_flickering(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.security_breach)) {
        return self [[ level.cybercom.security_breach._is_flickering ]](slot);
    }
}

// Namespace gadget_security_breach/gadget_security_breach
// Params 2, eflags: 0x0
// Checksum 0x8245023b, Offset: 0x428
// Size: 0x68
function gadget_security_breach_on_flicker(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.security_breach)) {
        self [[ level.cybercom.security_breach._on_flicker ]](slot, weapon);
    }
}

// Namespace gadget_security_breach/gadget_security_breach
// Params 2, eflags: 0x0
// Checksum 0xfeccfd5f, Offset: 0x498
// Size: 0x68
function gadget_security_breach_on_give(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.security_breach)) {
        return self [[ level.cybercom.security_breach._on_give ]](slot, weapon);
    }
}

// Namespace gadget_security_breach/gadget_security_breach
// Params 2, eflags: 0x0
// Checksum 0xd1ba175c, Offset: 0x508
// Size: 0x68
function gadget_security_breach_on_take(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.security_breach)) {
        return self [[ level.cybercom.security_breach._on_take ]](slot, weapon);
    }
}

// Namespace gadget_security_breach/gadget_security_breach
// Params 0, eflags: 0x0
// Checksum 0xfe4c0f77, Offset: 0x578
// Size: 0x50
function gadget_security_breach_on_connect() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.security_breach)) {
        return self [[ level.cybercom.security_breach._on_connect ]]();
    }
}

// Namespace gadget_security_breach/gadget_security_breach
// Params 2, eflags: 0x0
// Checksum 0xcc0f9272, Offset: 0x5d0
// Size: 0x88
function gadget_security_breach_on(slot, weapon) {
    self flagsys::set("gadget_security_breach_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.security_breach)) {
        return self [[ level.cybercom.security_breach._on ]](slot, weapon);
    }
}

// Namespace gadget_security_breach/gadget_security_breach
// Params 2, eflags: 0x0
// Checksum 0x1d8d65f5, Offset: 0x660
// Size: 0x88
function gadget_security_breach_off(slot, weapon) {
    self flagsys::clear("gadget_security_breach_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.security_breach)) {
        return self [[ level.cybercom.security_breach._off ]](slot, weapon);
    }
}

// Namespace gadget_security_breach/gadget_security_breach
// Params 2, eflags: 0x0
// Checksum 0xf2d5e59e, Offset: 0x6f0
// Size: 0x68
function gadget_security_breach_is_primed(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.security_breach)) {
        self [[ level.cybercom.security_breach._is_primed ]](slot, weapon);
    }
}

