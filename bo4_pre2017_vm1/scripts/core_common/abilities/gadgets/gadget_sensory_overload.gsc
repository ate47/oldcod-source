#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace gadget_sensory_overload;

// Namespace gadget_sensory_overload/gadget_sensory_overload
// Params 0, eflags: 0x2
// Checksum 0x1ac99db6, Offset: 0x238
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_sensory_overload", &__init__, undefined, undefined);
}

// Namespace gadget_sensory_overload/gadget_sensory_overload
// Params 0, eflags: 0x0
// Checksum 0xc9499478, Offset: 0x278
// Size: 0x104
function __init__() {
    ability_player::register_gadget_activation_callbacks(32, &gadget_sensory_overload_on, &gadget_sensory_overload_off);
    ability_player::register_gadget_possession_callbacks(32, &gadget_sensory_overload_on_give, &gadget_sensory_overload_on_take);
    ability_player::register_gadget_flicker_callbacks(32, &gadget_sensory_overload_on_flicker);
    ability_player::register_gadget_is_inuse_callbacks(32, &gadget_sensory_overload_is_inuse);
    ability_player::register_gadget_is_flickering_callbacks(32, &gadget_sensory_overload_is_flickering);
    ability_player::register_gadget_primed_callbacks(32, &gadget_sensory_overload_is_primed);
    callback::on_connect(&gadget_sensory_overload_on_connect);
}

// Namespace gadget_sensory_overload/gadget_sensory_overload
// Params 1, eflags: 0x0
// Checksum 0x4817464c, Offset: 0x388
// Size: 0x2a
function gadget_sensory_overload_is_inuse(slot) {
    return self flagsys::get("gadget_sensory_overload_on");
}

// Namespace gadget_sensory_overload/gadget_sensory_overload
// Params 1, eflags: 0x0
// Checksum 0xe2df6f74, Offset: 0x3c0
// Size: 0x5c
function gadget_sensory_overload_is_flickering(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.sensory_overload)) {
        return self [[ level.cybercom.sensory_overload._is_flickering ]](slot);
    }
}

// Namespace gadget_sensory_overload/gadget_sensory_overload
// Params 2, eflags: 0x0
// Checksum 0x930a45c4, Offset: 0x428
// Size: 0x68
function gadget_sensory_overload_on_flicker(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.sensory_overload)) {
        self [[ level.cybercom.sensory_overload._on_flicker ]](slot, weapon);
    }
}

// Namespace gadget_sensory_overload/gadget_sensory_overload
// Params 2, eflags: 0x0
// Checksum 0x3a52146f, Offset: 0x498
// Size: 0x68
function gadget_sensory_overload_on_give(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.sensory_overload)) {
        self [[ level.cybercom.sensory_overload._on_give ]](slot, weapon);
    }
}

// Namespace gadget_sensory_overload/gadget_sensory_overload
// Params 2, eflags: 0x0
// Checksum 0x75d4b78a, Offset: 0x508
// Size: 0x68
function gadget_sensory_overload_on_take(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.sensory_overload)) {
        self [[ level.cybercom.sensory_overload._on_take ]](slot, weapon);
    }
}

// Namespace gadget_sensory_overload/gadget_sensory_overload
// Params 0, eflags: 0x0
// Checksum 0x81edcac6, Offset: 0x578
// Size: 0x50
function gadget_sensory_overload_on_connect() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.sensory_overload)) {
        self [[ level.cybercom.sensory_overload._on_connect ]]();
    }
}

// Namespace gadget_sensory_overload/gadget_sensory_overload
// Params 2, eflags: 0x0
// Checksum 0x9367b71f, Offset: 0x5d0
// Size: 0x88
function gadget_sensory_overload_on(slot, weapon) {
    self flagsys::set("gadget_sensory_overload_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.sensory_overload)) {
        self [[ level.cybercom.sensory_overload._on ]](slot, weapon);
    }
}

// Namespace gadget_sensory_overload/gadget_sensory_overload
// Params 2, eflags: 0x0
// Checksum 0x6eb66e22, Offset: 0x660
// Size: 0x88
function gadget_sensory_overload_off(slot, weapon) {
    self flagsys::clear("gadget_sensory_overload_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.sensory_overload)) {
        self [[ level.cybercom.sensory_overload._off ]](slot, weapon);
    }
}

// Namespace gadget_sensory_overload/gadget_sensory_overload
// Params 2, eflags: 0x0
// Checksum 0x2f13661e, Offset: 0x6f0
// Size: 0x68
function gadget_sensory_overload_is_primed(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.sensory_overload)) {
        self [[ level.cybercom.sensory_overload._is_primed ]](slot, weapon);
    }
}

