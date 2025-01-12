#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace gadget_forced_malfunction;

// Namespace gadget_forced_malfunction/gadget_forced_malfunction
// Params 0, eflags: 0x2
// Checksum 0x8aeb97ea, Offset: 0x240
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_forced_malfunction", &__init__, undefined, undefined);
}

// Namespace gadget_forced_malfunction/gadget_forced_malfunction
// Params 0, eflags: 0x0
// Checksum 0x1b4e6b46, Offset: 0x280
// Size: 0x104
function __init__() {
    ability_player::register_gadget_activation_callbacks(26, &gadget_forced_malfunction_on, &gadget_forced_malfunction_off);
    ability_player::register_gadget_possession_callbacks(26, &gadget_forced_malfunction_on_give, &gadget_forced_malfunction_on_take);
    ability_player::register_gadget_flicker_callbacks(26, &gadget_forced_malfunction_on_flicker);
    ability_player::register_gadget_is_inuse_callbacks(26, &gadget_forced_malfunction_is_inuse);
    ability_player::register_gadget_is_flickering_callbacks(26, &gadget_forced_malfunction_is_flickering);
    ability_player::register_gadget_primed_callbacks(26, &gadget_forced_malfunction_is_primed);
    callback::on_connect(&gadget_forced_malfunction_on_connect);
}

// Namespace gadget_forced_malfunction/gadget_forced_malfunction
// Params 1, eflags: 0x0
// Checksum 0x1d3014cb, Offset: 0x390
// Size: 0x2a
function gadget_forced_malfunction_is_inuse(slot) {
    return self flagsys::get("gadget_forced_malfunction_on");
}

// Namespace gadget_forced_malfunction/gadget_forced_malfunction
// Params 1, eflags: 0x0
// Checksum 0x4cc116f7, Offset: 0x3c8
// Size: 0x5e
function gadget_forced_malfunction_is_flickering(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.forced_malfunction)) {
        return self [[ level.cybercom.forced_malfunction._is_flickering ]](slot);
    }
    return 0;
}

// Namespace gadget_forced_malfunction/gadget_forced_malfunction
// Params 2, eflags: 0x0
// Checksum 0x54546906, Offset: 0x430
// Size: 0x68
function gadget_forced_malfunction_on_flicker(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.forced_malfunction)) {
        self [[ level.cybercom.forced_malfunction._on_flicker ]](slot, weapon);
    }
}

// Namespace gadget_forced_malfunction/gadget_forced_malfunction
// Params 2, eflags: 0x0
// Checksum 0x9666608a, Offset: 0x4a0
// Size: 0x68
function gadget_forced_malfunction_on_give(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.forced_malfunction)) {
        self [[ level.cybercom.forced_malfunction._on_give ]](slot, weapon);
    }
}

// Namespace gadget_forced_malfunction/gadget_forced_malfunction
// Params 2, eflags: 0x0
// Checksum 0xa9145736, Offset: 0x510
// Size: 0x68
function gadget_forced_malfunction_on_take(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.forced_malfunction)) {
        self [[ level.cybercom.forced_malfunction._on_take ]](slot, weapon);
    }
}

// Namespace gadget_forced_malfunction/gadget_forced_malfunction
// Params 0, eflags: 0x0
// Checksum 0x237803f8, Offset: 0x580
// Size: 0x50
function gadget_forced_malfunction_on_connect() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.forced_malfunction)) {
        self [[ level.cybercom.forced_malfunction._on_connect ]]();
    }
}

// Namespace gadget_forced_malfunction/gadget_forced_malfunction
// Params 2, eflags: 0x0
// Checksum 0x99bf348b, Offset: 0x5d8
// Size: 0x88
function gadget_forced_malfunction_on(slot, weapon) {
    self flagsys::set("gadget_forced_malfunction_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.forced_malfunction)) {
        self [[ level.cybercom.forced_malfunction._on ]](slot, weapon);
    }
}

// Namespace gadget_forced_malfunction/gadget_forced_malfunction
// Params 2, eflags: 0x0
// Checksum 0x9e9ed385, Offset: 0x668
// Size: 0x88
function gadget_forced_malfunction_off(slot, weapon) {
    self flagsys::clear("gadget_forced_malfunction_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.forced_malfunction)) {
        self [[ level.cybercom.forced_malfunction._off ]](slot, weapon);
    }
}

// Namespace gadget_forced_malfunction/gadget_forced_malfunction
// Params 2, eflags: 0x0
// Checksum 0xc98c7402, Offset: 0x6f8
// Size: 0x68
function gadget_forced_malfunction_is_primed(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.forced_malfunction)) {
        self [[ level.cybercom.forced_malfunction._is_primed ]](slot, weapon);
    }
}

