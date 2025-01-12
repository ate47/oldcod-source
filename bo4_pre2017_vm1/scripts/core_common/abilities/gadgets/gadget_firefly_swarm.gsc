#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace gadget_firefly_swarm;

// Namespace gadget_firefly_swarm/gadget_firefly_swarm
// Params 0, eflags: 0x2
// Checksum 0x21ded7f4, Offset: 0x230
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_firefly_swarm", &__init__, undefined, undefined);
}

// Namespace gadget_firefly_swarm/gadget_firefly_swarm
// Params 0, eflags: 0x0
// Checksum 0x8fb49ec5, Offset: 0x270
// Size: 0x104
function __init__() {
    ability_player::register_gadget_activation_callbacks(35, &gadget_firefly_swarm_on, &gadget_firefly_swarm_off);
    ability_player::register_gadget_possession_callbacks(35, &gadget_firefly_swarm_on_give, &gadget_firefly_swarm_on_take);
    ability_player::register_gadget_flicker_callbacks(35, &gadget_firefly_swarm_on_flicker);
    ability_player::register_gadget_is_inuse_callbacks(35, &gadget_firefly_swarm_is_inuse);
    ability_player::register_gadget_is_flickering_callbacks(35, &gadget_firefly_swarm_is_flickering);
    ability_player::register_gadget_primed_callbacks(35, &gadget_firefly_is_primed);
    callback::on_connect(&gadget_firefly_swarm_on_connect);
}

// Namespace gadget_firefly_swarm/gadget_firefly_swarm
// Params 1, eflags: 0x0
// Checksum 0x997bbdb, Offset: 0x380
// Size: 0x2a
function gadget_firefly_swarm_is_inuse(slot) {
    return self flagsys::get("gadget_firefly_swarm_on");
}

// Namespace gadget_firefly_swarm/gadget_firefly_swarm
// Params 1, eflags: 0x0
// Checksum 0xa9fa47eb, Offset: 0x3b8
// Size: 0x5e
function gadget_firefly_swarm_is_flickering(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.firefly_swarm)) {
        return self [[ level.cybercom.firefly_swarm._is_flickering ]](slot);
    }
    return 0;
}

// Namespace gadget_firefly_swarm/gadget_firefly_swarm
// Params 2, eflags: 0x0
// Checksum 0x7ebf40aa, Offset: 0x420
// Size: 0x68
function gadget_firefly_swarm_on_flicker(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.firefly_swarm)) {
        self [[ level.cybercom.firefly_swarm._on_flicker ]](slot, weapon);
    }
}

// Namespace gadget_firefly_swarm/gadget_firefly_swarm
// Params 2, eflags: 0x0
// Checksum 0x1a2c6d27, Offset: 0x490
// Size: 0x68
function gadget_firefly_swarm_on_give(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.firefly_swarm)) {
        self [[ level.cybercom.firefly_swarm._on_give ]](slot, weapon);
    }
}

// Namespace gadget_firefly_swarm/gadget_firefly_swarm
// Params 2, eflags: 0x0
// Checksum 0xe64858e1, Offset: 0x500
// Size: 0x68
function gadget_firefly_swarm_on_take(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.firefly_swarm)) {
        self [[ level.cybercom.firefly_swarm._on_take ]](slot, weapon);
    }
}

// Namespace gadget_firefly_swarm/gadget_firefly_swarm
// Params 0, eflags: 0x0
// Checksum 0xed44cf0c, Offset: 0x570
// Size: 0x50
function gadget_firefly_swarm_on_connect() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.firefly_swarm)) {
        self [[ level.cybercom.firefly_swarm._on_connect ]]();
    }
}

// Namespace gadget_firefly_swarm/gadget_firefly_swarm
// Params 2, eflags: 0x0
// Checksum 0x528fe0d4, Offset: 0x5c8
// Size: 0x88
function gadget_firefly_swarm_on(slot, weapon) {
    self flagsys::set("gadget_firefly_swarm_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.firefly_swarm)) {
        self [[ level.cybercom.firefly_swarm._on ]](slot, weapon);
    }
}

// Namespace gadget_firefly_swarm/gadget_firefly_swarm
// Params 2, eflags: 0x0
// Checksum 0xc89c1b97, Offset: 0x658
// Size: 0x88
function gadget_firefly_swarm_off(slot, weapon) {
    self flagsys::clear("gadget_firefly_swarm_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.firefly_swarm)) {
        self [[ level.cybercom.firefly_swarm._off ]](slot, weapon);
    }
}

// Namespace gadget_firefly_swarm/gadget_firefly_swarm
// Params 2, eflags: 0x0
// Checksum 0xb7afa6a3, Offset: 0x6e8
// Size: 0x68
function gadget_firefly_is_primed(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.firefly_swarm)) {
        self [[ level.cybercom.firefly_swarm._is_primed ]](slot, weapon);
    }
}

