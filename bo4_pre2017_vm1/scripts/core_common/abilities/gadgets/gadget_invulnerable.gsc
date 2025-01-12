#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_power;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/values_shared;

#namespace namespace_61b1b96d;

// Namespace namespace_61b1b96d/namespace_61b1b96d
// Params 0, eflags: 0x2
// Checksum 0x5f09a1cb, Offset: 0x260
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_invulnerable", &__init__, undefined, undefined);
}

// Namespace namespace_61b1b96d/namespace_61b1b96d
// Params 0, eflags: 0x0
// Checksum 0x80597985, Offset: 0x2a0
// Size: 0x114
function __init__() {
    ability_player::register_gadget_activation_callbacks(52, &function_ff11872b, &function_4f2b8e9f);
    ability_player::register_gadget_possession_callbacks(52, &function_4b869ca1, &function_d6a16c6b);
    ability_player::register_gadget_flicker_callbacks(52, &function_683d3e26);
    ability_player::register_gadget_is_inuse_callbacks(52, &function_971eb2b);
    ability_player::register_gadget_is_flickering_callbacks(52, &function_f0cbfbfb);
    clientfield::register("allplayers", "invulnerable_status", 1, 1, "int");
    callback::on_connect(&function_b0332820);
}

// Namespace namespace_61b1b96d/namespace_61b1b96d
// Params 1, eflags: 0x0
// Checksum 0xc9a075c7, Offset: 0x3c0
// Size: 0x22
function function_971eb2b(slot) {
    return self gadgetisactive(slot);
}

// Namespace namespace_61b1b96d/namespace_61b1b96d
// Params 1, eflags: 0x0
// Checksum 0xd99de4e0, Offset: 0x3f0
// Size: 0x22
function function_f0cbfbfb(slot) {
    return self gadgetflickering(slot);
}

// Namespace namespace_61b1b96d/namespace_61b1b96d
// Params 2, eflags: 0x0
// Checksum 0x5e56e45e, Offset: 0x420
// Size: 0x34
function function_683d3e26(slot, weapon) {
    self thread function_da1d388c(slot, weapon);
}

// Namespace namespace_61b1b96d/namespace_61b1b96d
// Params 2, eflags: 0x0
// Checksum 0xc2abe8c3, Offset: 0x460
// Size: 0x14
function function_4b869ca1(slot, weapon) {
    
}

// Namespace namespace_61b1b96d/namespace_61b1b96d
// Params 2, eflags: 0x0
// Checksum 0x901ad903, Offset: 0x480
// Size: 0x34
function function_d6a16c6b(slot, weapon) {
    self function_4f2b8e9f(slot, weapon);
}

// Namespace namespace_61b1b96d/namespace_61b1b96d
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x4c0
// Size: 0x4
function function_b0332820() {
    
}

// Namespace namespace_61b1b96d/namespace_61b1b96d
// Params 2, eflags: 0x0
// Checksum 0xda3dee18, Offset: 0x4d0
// Size: 0x9c
function function_ff11872b(slot, weapon) {
    self val::set("gadget_invulnerable", "freezecontrols", 0);
    self val::set("gadget_invulnerable", "takedamage", 0);
    self clientfield::set("invulnerable_status", 1);
    self setlowready(1);
}

// Namespace namespace_61b1b96d/namespace_61b1b96d
// Params 2, eflags: 0x0
// Checksum 0xa0cdbc8f, Offset: 0x578
// Size: 0x9c
function function_4f2b8e9f(slot, weapon) {
    self val::reset("gadget_invulnerable", "freezecontrols");
    self val::reset("gadget_invulnerable", "takedamage");
    self clientfield::set("invulnerable_status", 0);
    self setlowready(0);
}

// Namespace namespace_61b1b96d/namespace_61b1b96d
// Params 2, eflags: 0x0
// Checksum 0x704886b0, Offset: 0x620
// Size: 0x14
function function_da1d388c(slot, weapon) {
    
}

