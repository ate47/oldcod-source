#using scripts/core_common/abilities/ability_gadgets;
#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;

#namespace gadget_active_camo;

// Namespace gadget_active_camo/gadget_active_camo
// Params 0, eflags: 0x2
// Checksum 0x1e5cd19, Offset: 0x218
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_active_camo", &__init__, undefined, undefined);
}

// Namespace gadget_active_camo/gadget_active_camo
// Params 0, eflags: 0x0
// Checksum 0x63c91363, Offset: 0x258
// Size: 0x124
function __init__() {
    ability_player::register_gadget_activation_callbacks(31, &camo_gadget_on, &camo_gadget_off);
    ability_player::register_gadget_possession_callbacks(31, &camo_on_give, &camo_on_take);
    ability_player::register_gadget_flicker_callbacks(31, &camo_on_flicker);
    ability_player::register_gadget_is_inuse_callbacks(31, &camo_is_inuse);
    ability_player::register_gadget_is_flickering_callbacks(31, &camo_is_flickering);
    callback::on_connect(&camo_on_connect);
    callback::on_spawned(&camo_on_spawn);
    callback::on_disconnect(&camo_on_disconnect);
}

// Namespace gadget_active_camo/gadget_active_camo
// Params 0, eflags: 0x0
// Checksum 0x6b8f8328, Offset: 0x388
// Size: 0x50
function camo_on_connect() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.active_camo)) {
        self [[ level.cybercom.active_camo._on_connect ]]();
    }
}

// Namespace gadget_active_camo/gadget_active_camo
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x3e0
// Size: 0x4
function camo_on_disconnect() {
    
}

// Namespace gadget_active_camo/gadget_active_camo
// Params 0, eflags: 0x0
// Checksum 0xd475d797, Offset: 0x3f0
// Size: 0x54
function camo_on_spawn() {
    self flagsys::clear("camo_suit_on");
    self notify(#"camo_off");
    self clientfield::set("camo_shader", 0);
}

// Namespace gadget_active_camo/gadget_active_camo
// Params 1, eflags: 0x0
// Checksum 0x51a8b749, Offset: 0x450
// Size: 0x2a
function camo_is_inuse(slot) {
    return self flagsys::get("camo_suit_on");
}

// Namespace gadget_active_camo/gadget_active_camo
// Params 1, eflags: 0x0
// Checksum 0xd57a4fc3, Offset: 0x488
// Size: 0x22
function camo_is_flickering(slot) {
    return self gadgetflickering(slot);
}

// Namespace gadget_active_camo/gadget_active_camo
// Params 2, eflags: 0x0
// Checksum 0x3cf57dcd, Offset: 0x4b8
// Size: 0x68
function camo_on_give(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.active_camo)) {
        self [[ level.cybercom.active_camo._on_give ]](slot, weapon);
    }
}

// Namespace gadget_active_camo/gadget_active_camo
// Params 2, eflags: 0x0
// Checksum 0x7eca75b1, Offset: 0x528
// Size: 0x78
function camo_on_take(slot, weapon) {
    self notify(#"camo_removed");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.active_camo)) {
        self [[ level.cybercom.active_camo._on_take ]](slot, weapon);
    }
}

// Namespace gadget_active_camo/gadget_active_camo
// Params 2, eflags: 0x0
// Checksum 0x78429d15, Offset: 0x5a8
// Size: 0x88
function camo_on_flicker(slot, weapon) {
    self thread suspend_camo_suit(slot, weapon);
    if (isdefined(level.cybercom) && isdefined(level.cybercom.active_camo)) {
        self thread [[ level.cybercom.active_camo._on_flicker ]](slot, weapon);
    }
}

// Namespace gadget_active_camo/gadget_active_camo
// Params 2, eflags: 0x0
// Checksum 0xbd9b263b, Offset: 0x638
// Size: 0xac
function camo_gadget_on(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.active_camo)) {
        self thread [[ level.cybercom.active_camo._on ]](slot, weapon);
    } else {
        self clientfield::set("camo_shader", 1);
    }
    self flagsys::set("camo_suit_on");
}

// Namespace gadget_active_camo/gadget_active_camo
// Params 2, eflags: 0x0
// Checksum 0x6d97a0ba, Offset: 0x6f0
// Size: 0xb4
function camo_gadget_off(slot, weapon) {
    self flagsys::clear("camo_suit_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.active_camo)) {
        self thread [[ level.cybercom.active_camo._off ]](slot, weapon);
    }
    self notify(#"camo_off");
    self clientfield::set("camo_shader", 0);
}

// Namespace gadget_active_camo/gadget_active_camo
// Params 2, eflags: 0x0
// Checksum 0x88daf394, Offset: 0x7b0
// Size: 0x9c
function suspend_camo_suit(slot, weapon) {
    self endon(#"disconnect");
    self endon(#"camo_off");
    self clientfield::set("camo_shader", 2);
    suspend_camo_suit_wait(slot, weapon);
    if (self camo_is_inuse(slot)) {
        self clientfield::set("camo_shader", 1);
    }
}

// Namespace gadget_active_camo/gadget_active_camo
// Params 2, eflags: 0x0
// Checksum 0xfcf91e6a, Offset: 0x858
// Size: 0x54
function suspend_camo_suit_wait(slot, weapon) {
    self endon(#"death");
    self endon(#"camo_off");
    while (self camo_is_flickering(slot)) {
        wait 0.5;
    }
}

