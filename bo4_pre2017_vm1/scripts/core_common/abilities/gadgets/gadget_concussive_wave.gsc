#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace gadget_concussive_wave;

// Namespace gadget_concussive_wave/gadget_concussive_wave
// Params 0, eflags: 0x2
// Checksum 0xd4392a59, Offset: 0x238
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_concussive_wave", &__init__, undefined, undefined);
}

// Namespace gadget_concussive_wave/gadget_concussive_wave
// Params 0, eflags: 0x0
// Checksum 0xbe092474, Offset: 0x278
// Size: 0x104
function __init__() {
    ability_player::register_gadget_activation_callbacks(27, &gadget_concussive_wave_on, &gadget_concussive_wave_off);
    ability_player::register_gadget_possession_callbacks(27, &gadget_concussive_wave_on_give, &gadget_concussive_wave_on_take);
    ability_player::register_gadget_flicker_callbacks(27, &gadget_concussive_wave_on_flicker);
    ability_player::register_gadget_is_inuse_callbacks(27, &gadget_concussive_wave_is_inuse);
    ability_player::register_gadget_is_flickering_callbacks(27, &gadget_concussive_wave_is_flickering);
    ability_player::register_gadget_primed_callbacks(27, &gadget_concussive_wave_is_primed);
    callback::on_connect(&gadget_concussive_wave_on_connect);
}

// Namespace gadget_concussive_wave/gadget_concussive_wave
// Params 1, eflags: 0x0
// Checksum 0x63833aca, Offset: 0x388
// Size: 0x2a
function gadget_concussive_wave_is_inuse(slot) {
    return self flagsys::get("gadget_concussive_wave_on");
}

// Namespace gadget_concussive_wave/gadget_concussive_wave
// Params 1, eflags: 0x0
// Checksum 0xf8ba1ec2, Offset: 0x3c0
// Size: 0x5e
function gadget_concussive_wave_is_flickering(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.concussive_wave)) {
        return self [[ level.cybercom.concussive_wave._is_flickering ]](slot);
    }
    return 0;
}

// Namespace gadget_concussive_wave/gadget_concussive_wave
// Params 2, eflags: 0x0
// Checksum 0x68246236, Offset: 0x428
// Size: 0x68
function gadget_concussive_wave_on_flicker(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.concussive_wave)) {
        self [[ level.cybercom.concussive_wave._on_flicker ]](slot, weapon);
    }
}

// Namespace gadget_concussive_wave/gadget_concussive_wave
// Params 2, eflags: 0x0
// Checksum 0xa1deb453, Offset: 0x498
// Size: 0x68
function gadget_concussive_wave_on_give(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.concussive_wave)) {
        self [[ level.cybercom.concussive_wave._on_give ]](slot, weapon);
    }
}

// Namespace gadget_concussive_wave/gadget_concussive_wave
// Params 2, eflags: 0x0
// Checksum 0x6ae744e5, Offset: 0x508
// Size: 0x68
function gadget_concussive_wave_on_take(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.concussive_wave)) {
        self [[ level.cybercom.concussive_wave._on_take ]](slot, weapon);
    }
}

// Namespace gadget_concussive_wave/gadget_concussive_wave
// Params 0, eflags: 0x0
// Checksum 0xa82100d3, Offset: 0x578
// Size: 0x50
function gadget_concussive_wave_on_connect() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.concussive_wave)) {
        self [[ level.cybercom.concussive_wave._on_connect ]]();
    }
}

// Namespace gadget_concussive_wave/gadget_concussive_wave
// Params 2, eflags: 0x0
// Checksum 0xa8a02c5a, Offset: 0x5d0
// Size: 0x88
function gadget_concussive_wave_on(slot, weapon) {
    self flagsys::set("gadget_concussive_wave_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.concussive_wave)) {
        self [[ level.cybercom.concussive_wave._on ]](slot, weapon);
    }
}

// Namespace gadget_concussive_wave/gadget_concussive_wave
// Params 2, eflags: 0x0
// Checksum 0x8fc4b0c6, Offset: 0x660
// Size: 0x88
function gadget_concussive_wave_off(slot, weapon) {
    self flagsys::clear("gadget_concussive_wave_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.concussive_wave)) {
        self [[ level.cybercom.concussive_wave._off ]](slot, weapon);
    }
}

// Namespace gadget_concussive_wave/gadget_concussive_wave
// Params 2, eflags: 0x0
// Checksum 0x4c2a5f35, Offset: 0x6f0
// Size: 0x68
function gadget_concussive_wave_is_primed(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.concussive_wave)) {
        self [[ level.cybercom.concussive_wave._is_primed ]](slot, weapon);
    }
}

