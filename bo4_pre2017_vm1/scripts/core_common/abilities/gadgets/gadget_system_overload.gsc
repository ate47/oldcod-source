#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace gadget_system_overload;

// Namespace gadget_system_overload/gadget_system_overload
// Params 0, eflags: 0x2
// Checksum 0x935af96e, Offset: 0x238
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_system_overload", &__init__, undefined, undefined);
}

// Namespace gadget_system_overload/gadget_system_overload
// Params 0, eflags: 0x0
// Checksum 0x26ac978a, Offset: 0x278
// Size: 0x104
function __init__() {
    ability_player::register_gadget_activation_callbacks(18, &gadget_system_overload_on, &gadget_system_overload_off);
    ability_player::register_gadget_possession_callbacks(18, &gadget_system_overload_on_give, &gadget_system_overload_on_take);
    ability_player::register_gadget_flicker_callbacks(18, &gadget_system_overload_on_flicker);
    ability_player::register_gadget_is_inuse_callbacks(18, &gadget_system_overload_is_inuse);
    ability_player::register_gadget_is_flickering_callbacks(18, &gadget_system_overload_is_flickering);
    ability_player::register_gadget_primed_callbacks(18, &gadget_system_overload_is_primed);
    callback::on_connect(&gadget_system_overload_on_connect);
}

// Namespace gadget_system_overload/gadget_system_overload
// Params 1, eflags: 0x0
// Checksum 0xc87a15ea, Offset: 0x388
// Size: 0x2a
function gadget_system_overload_is_inuse(slot) {
    return self flagsys::get("gadget_system_overload_on");
}

// Namespace gadget_system_overload/gadget_system_overload
// Params 1, eflags: 0x0
// Checksum 0xca75038e, Offset: 0x3c0
// Size: 0x5e
function gadget_system_overload_is_flickering(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.system_overload)) {
        return self [[ level.cybercom.system_overload._is_flickering ]](slot);
    }
    return 0;
}

// Namespace gadget_system_overload/gadget_system_overload
// Params 2, eflags: 0x0
// Checksum 0x17734e11, Offset: 0x428
// Size: 0x68
function gadget_system_overload_on_flicker(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.system_overload)) {
        self [[ level.cybercom.system_overload._on_flicker ]](slot, weapon);
    }
}

// Namespace gadget_system_overload/gadget_system_overload
// Params 2, eflags: 0x0
// Checksum 0x715b57e9, Offset: 0x498
// Size: 0x68
function gadget_system_overload_on_give(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.system_overload)) {
        self [[ level.cybercom.system_overload._on_give ]](slot, weapon);
    }
}

// Namespace gadget_system_overload/gadget_system_overload
// Params 2, eflags: 0x0
// Checksum 0x32558e27, Offset: 0x508
// Size: 0x68
function gadget_system_overload_on_take(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.system_overload)) {
        self [[ level.cybercom.system_overload._on_take ]](slot, weapon);
    }
}

// Namespace gadget_system_overload/gadget_system_overload
// Params 0, eflags: 0x0
// Checksum 0xbde5d147, Offset: 0x578
// Size: 0x50
function gadget_system_overload_on_connect() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.system_overload)) {
        self [[ level.cybercom.system_overload._on_connect ]]();
    }
}

// Namespace gadget_system_overload/gadget_system_overload
// Params 2, eflags: 0x0
// Checksum 0xd6ac6365, Offset: 0x5d0
// Size: 0x88
function gadget_system_overload_on(slot, weapon) {
    self flagsys::set("gadget_system_overload_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.system_overload)) {
        self [[ level.cybercom.system_overload._on ]](slot, weapon);
    }
}

// Namespace gadget_system_overload/gadget_system_overload
// Params 2, eflags: 0x0
// Checksum 0x4c7909d7, Offset: 0x660
// Size: 0x88
function gadget_system_overload_off(slot, weapon) {
    self flagsys::clear("gadget_system_overload_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.system_overload)) {
        self [[ level.cybercom.system_overload._off ]](slot, weapon);
    }
}

// Namespace gadget_system_overload/gadget_system_overload
// Params 2, eflags: 0x0
// Checksum 0x1a22faaa, Offset: 0x6f0
// Size: 0x68
function gadget_system_overload_is_primed(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.system_overload)) {
        self [[ level.cybercom.system_overload._is_primed ]](slot, weapon);
    }
}

