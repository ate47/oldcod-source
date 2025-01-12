#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_power;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/values_shared;

#namespace gadget_invulnerable;

// Namespace gadget_invulnerable/gadget_invulnerable
// Params 0, eflags: 0x2
// Checksum 0x5f09a1cb, Offset: 0x260
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_invulnerable", &__init__, undefined, undefined);
}

// Namespace gadget_invulnerable/gadget_invulnerable
// Params 0, eflags: 0x0
// Checksum 0x80597985, Offset: 0x2a0
// Size: 0x114
function __init__() {
    ability_player::register_gadget_activation_callbacks(52, &gadget_invulnerable_on, &gadget_invulnerable_off);
    ability_player::register_gadget_possession_callbacks(52, &gadget_invulnerable_on_give, &gadget_invulnerable_on_take);
    ability_player::register_gadget_flicker_callbacks(52, &gadget_invulnerable_on_flicker);
    ability_player::register_gadget_is_inuse_callbacks(52, &gadget_invulnerable_is_inuse);
    ability_player::register_gadget_is_flickering_callbacks(52, &gadget_invulnerable_is_flickering);
    clientfield::register("allplayers", "invulnerable_status", 1, 1, "int");
    callback::on_connect(&gadget_invulnerable_on_connect);
}

// Namespace gadget_invulnerable/gadget_invulnerable
// Params 1, eflags: 0x0
// Checksum 0xc9a075c7, Offset: 0x3c0
// Size: 0x22
function gadget_invulnerable_is_inuse(slot) {
    return self gadgetisactive(slot);
}

// Namespace gadget_invulnerable/gadget_invulnerable
// Params 1, eflags: 0x0
// Checksum 0xd99de4e0, Offset: 0x3f0
// Size: 0x22
function gadget_invulnerable_is_flickering(slot) {
    return self gadgetflickering(slot);
}

// Namespace gadget_invulnerable/gadget_invulnerable
// Params 2, eflags: 0x0
// Checksum 0x5e56e45e, Offset: 0x420
// Size: 0x34
function gadget_invulnerable_on_flicker(slot, weapon) {
    self thread gadget_invulnerable_flicker(slot, weapon);
}

// Namespace gadget_invulnerable/gadget_invulnerable
// Params 2, eflags: 0x0
// Checksum 0xc2abe8c3, Offset: 0x460
// Size: 0x14
function gadget_invulnerable_on_give(slot, weapon) {
    
}

// Namespace gadget_invulnerable/gadget_invulnerable
// Params 2, eflags: 0x0
// Checksum 0x901ad903, Offset: 0x480
// Size: 0x34
function gadget_invulnerable_on_take(slot, weapon) {
    self gadget_invulnerable_off(slot, weapon);
}

// Namespace gadget_invulnerable/gadget_invulnerable
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x4c0
// Size: 0x4
function gadget_invulnerable_on_connect() {
    
}

// Namespace gadget_invulnerable/gadget_invulnerable
// Params 2, eflags: 0x0
// Checksum 0xda3dee18, Offset: 0x4d0
// Size: 0x9c
function gadget_invulnerable_on(slot, weapon) {
    self val::set("gadget_invulnerable", "freezecontrols", 0);
    self val::set("gadget_invulnerable", "takedamage", 0);
    self clientfield::set("invulnerable_status", 1);
    self setlowready(1);
}

// Namespace gadget_invulnerable/gadget_invulnerable
// Params 2, eflags: 0x0
// Checksum 0xa0cdbc8f, Offset: 0x578
// Size: 0x9c
function gadget_invulnerable_off(slot, weapon) {
    self val::reset("gadget_invulnerable", "freezecontrols");
    self val::reset("gadget_invulnerable", "takedamage");
    self clientfield::set("invulnerable_status", 0);
    self setlowready(0);
}

// Namespace gadget_invulnerable/gadget_invulnerable
// Params 2, eflags: 0x0
// Checksum 0x704886b0, Offset: 0x620
// Size: 0x14
function gadget_invulnerable_flicker(slot, weapon) {
    
}

