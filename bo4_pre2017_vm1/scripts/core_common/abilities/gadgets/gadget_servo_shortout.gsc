#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace gadget_servo_shortout;

// Namespace gadget_servo_shortout/gadget_servo_shortout
// Params 0, eflags: 0x2
// Checksum 0x9213a7dd, Offset: 0x238
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_servo_shortout", &__init__, undefined, undefined);
}

// Namespace gadget_servo_shortout/gadget_servo_shortout
// Params 0, eflags: 0x0
// Checksum 0x71a2d308, Offset: 0x278
// Size: 0x104
function __init__() {
    ability_player::register_gadget_activation_callbacks(19, &gadget_servo_shortout_on, &gadget_servo_shortout_off);
    ability_player::register_gadget_possession_callbacks(19, &gadget_servo_shortout_on_give, &gadget_servo_shortout_on_take);
    ability_player::register_gadget_flicker_callbacks(19, &gadget_servo_shortout_on_flicker);
    ability_player::register_gadget_is_inuse_callbacks(19, &gadget_servo_shortout_is_inuse);
    ability_player::register_gadget_is_flickering_callbacks(19, &gadget_servo_shortout_is_flickering);
    ability_player::register_gadget_primed_callbacks(19, &gadget_servo_shortout_is_primed);
    callback::on_connect(&gadget_servo_shortout_on_connect);
}

// Namespace gadget_servo_shortout/gadget_servo_shortout
// Params 1, eflags: 0x0
// Checksum 0xe47231be, Offset: 0x388
// Size: 0x2a
function gadget_servo_shortout_is_inuse(slot) {
    return self flagsys::get("gadget_servo_shortout_on");
}

// Namespace gadget_servo_shortout/gadget_servo_shortout
// Params 1, eflags: 0x0
// Checksum 0xe2c0789e, Offset: 0x3c0
// Size: 0x5e
function gadget_servo_shortout_is_flickering(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.servo_shortout)) {
        return self [[ level.cybercom.servo_shortout._is_flickering ]](slot);
    }
    return 0;
}

// Namespace gadget_servo_shortout/gadget_servo_shortout
// Params 2, eflags: 0x0
// Checksum 0xc087fbde, Offset: 0x428
// Size: 0x68
function gadget_servo_shortout_on_flicker(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.servo_shortout)) {
        self [[ level.cybercom.servo_shortout._on_flicker ]](slot, weapon);
    }
}

// Namespace gadget_servo_shortout/gadget_servo_shortout
// Params 2, eflags: 0x0
// Checksum 0xe44f8176, Offset: 0x498
// Size: 0x68
function gadget_servo_shortout_on_give(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.servo_shortout)) {
        self [[ level.cybercom.servo_shortout._on_give ]](slot, weapon);
    }
}

// Namespace gadget_servo_shortout/gadget_servo_shortout
// Params 2, eflags: 0x0
// Checksum 0x605cd613, Offset: 0x508
// Size: 0x68
function gadget_servo_shortout_on_take(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.servo_shortout)) {
        self [[ level.cybercom.servo_shortout._on_take ]](slot, weapon);
    }
}

// Namespace gadget_servo_shortout/gadget_servo_shortout
// Params 0, eflags: 0x0
// Checksum 0x214fe55e, Offset: 0x578
// Size: 0x50
function gadget_servo_shortout_on_connect() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.servo_shortout)) {
        self [[ level.cybercom.servo_shortout._on_connect ]]();
    }
}

// Namespace gadget_servo_shortout/gadget_servo_shortout
// Params 2, eflags: 0x0
// Checksum 0x7c2df55d, Offset: 0x5d0
// Size: 0x88
function gadget_servo_shortout_on(slot, weapon) {
    self flagsys::set("gadget_servo_shortout_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.servo_shortout)) {
        self [[ level.cybercom.servo_shortout._on ]](slot, weapon);
    }
}

// Namespace gadget_servo_shortout/gadget_servo_shortout
// Params 2, eflags: 0x0
// Checksum 0xfc704ced, Offset: 0x660
// Size: 0x88
function gadget_servo_shortout_off(slot, weapon) {
    self flagsys::clear("gadget_servo_shortout_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.servo_shortout)) {
        self [[ level.cybercom.servo_shortout._off ]](slot, weapon);
    }
}

// Namespace gadget_servo_shortout/gadget_servo_shortout
// Params 2, eflags: 0x0
// Checksum 0xb705ba58, Offset: 0x6f0
// Size: 0x68
function gadget_servo_shortout_is_primed(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.servo_shortout)) {
        self [[ level.cybercom.servo_shortout._is_primed ]](slot, weapon);
    }
}

