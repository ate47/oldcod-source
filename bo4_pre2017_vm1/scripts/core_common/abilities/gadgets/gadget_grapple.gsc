#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/weapons/grapple;

#namespace gadget_grapple;

// Namespace gadget_grapple/gadget_grapple
// Params 0, eflags: 0x2
// Checksum 0xda04d627, Offset: 0x1c8
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_grapple", &__init__, undefined, undefined);
}

// Namespace gadget_grapple/gadget_grapple
// Params 0, eflags: 0x0
// Checksum 0x8f53b881, Offset: 0x208
// Size: 0xe4
function __init__() {
    ability_player::register_gadget_activation_callbacks(51, &gadget_grapple_on, &gadget_grapple_off);
    ability_player::register_gadget_possession_callbacks(51, &gadget_grapple_on_give, &gadget_grapple_on_take);
    ability_player::register_gadget_flicker_callbacks(51, &gadget_grapple_on_flicker);
    ability_player::register_gadget_is_inuse_callbacks(51, &gadget_grapple_is_inuse);
    ability_player::register_gadget_is_flickering_callbacks(51, &gadget_grapple_is_flickering);
    callback::on_connect(&gadget_grapple_on_connect);
}

// Namespace gadget_grapple/gadget_grapple
// Params 1, eflags: 0x0
// Checksum 0xd12ff5ad, Offset: 0x2f8
// Size: 0x22
function gadget_grapple_is_inuse(slot) {
    return self gadgetisactive(slot);
}

// Namespace gadget_grapple/gadget_grapple
// Params 1, eflags: 0x0
// Checksum 0x745c62c7, Offset: 0x328
// Size: 0x22
function gadget_grapple_is_flickering(slot) {
    return self gadgetflickering(slot);
}

// Namespace gadget_grapple/gadget_grapple
// Params 2, eflags: 0x0
// Checksum 0xca276eed, Offset: 0x358
// Size: 0x14
function gadget_grapple_on_flicker(slot, weapon) {
    
}

// Namespace gadget_grapple/gadget_grapple
// Params 2, eflags: 0x0
// Checksum 0xb29a2397, Offset: 0x378
// Size: 0x2c
function gadget_grapple_on_give(slot, weapon) {
    self thread watch_for_grapple_ability(weapon);
}

// Namespace gadget_grapple/gadget_grapple
// Params 2, eflags: 0x0
// Checksum 0x7763da22, Offset: 0x3b0
// Size: 0x14
function gadget_grapple_on_take(slot, weapon) {
    
}

// Namespace gadget_grapple/gadget_grapple
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x3d0
// Size: 0x4
function gadget_grapple_on_connect() {
    
}

// Namespace gadget_grapple/gadget_grapple
// Params 2, eflags: 0x0
// Checksum 0x7760cb57, Offset: 0x3e0
// Size: 0x2c
function gadget_grapple_on(slot, weapon) {
    self activategrapple();
}

// Namespace gadget_grapple/gadget_grapple
// Params 2, eflags: 0x0
// Checksum 0xa36290c1, Offset: 0x418
// Size: 0x14
function gadget_grapple_off(slot, weapon) {
    
}

// Namespace gadget_grapple/gadget_grapple
// Params 1, eflags: 0x0
// Checksum 0x8d9ff737, Offset: 0x438
// Size: 0x54
function watch_for_grapple_ability(weapon) {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"spawned_player");
    self endon(#"killReplayGunMonitor");
    self thread grapple::watch_lockon(weapon);
}

