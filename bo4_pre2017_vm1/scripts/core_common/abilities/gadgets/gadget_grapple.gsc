#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/weapons/grapple;

#namespace namespace_599aae2d;

// Namespace namespace_599aae2d/namespace_599aae2d
// Params 0, eflags: 0x2
// Checksum 0xda04d627, Offset: 0x1c8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_grapple", &__init__, undefined, undefined);
}

// Namespace namespace_599aae2d/namespace_599aae2d
// Params 0, eflags: 0x0
// Checksum 0x8f53b881, Offset: 0x208
// Size: 0xe4
function __init__() {
    ability_player::register_gadget_activation_callbacks(51, &function_702f74eb, &gadget_grapple_off);
    ability_player::register_gadget_possession_callbacks(51, &function_24b38961, &function_6cbcfc2b);
    ability_player::register_gadget_flicker_callbacks(51, &function_871f35e6);
    ability_player::register_gadget_is_inuse_callbacks(51, &function_2a5a5eb);
    ability_player::register_gadget_is_flickering_callbacks(51, &function_62a6c8bb);
    callback::on_connect(&function_3d0ce0e0);
}

// Namespace namespace_599aae2d/namespace_599aae2d
// Params 1, eflags: 0x0
// Checksum 0xd12ff5ad, Offset: 0x2f8
// Size: 0x22
function function_2a5a5eb(slot) {
    return self gadgetisactive(slot);
}

// Namespace namespace_599aae2d/namespace_599aae2d
// Params 1, eflags: 0x0
// Checksum 0x745c62c7, Offset: 0x328
// Size: 0x22
function function_62a6c8bb(slot) {
    return self gadgetflickering(slot);
}

// Namespace namespace_599aae2d/namespace_599aae2d
// Params 2, eflags: 0x0
// Checksum 0xca276eed, Offset: 0x358
// Size: 0x14
function function_871f35e6(slot, weapon) {
    
}

// Namespace namespace_599aae2d/namespace_599aae2d
// Params 2, eflags: 0x0
// Checksum 0xb29a2397, Offset: 0x378
// Size: 0x2c
function function_24b38961(slot, weapon) {
    self thread function_8e943a3d(weapon);
}

// Namespace namespace_599aae2d/namespace_599aae2d
// Params 2, eflags: 0x0
// Checksum 0x7763da22, Offset: 0x3b0
// Size: 0x14
function function_6cbcfc2b(slot, weapon) {
    
}

// Namespace namespace_599aae2d/namespace_599aae2d
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x3d0
// Size: 0x4
function function_3d0ce0e0() {
    
}

// Namespace namespace_599aae2d/namespace_599aae2d
// Params 2, eflags: 0x0
// Checksum 0x7760cb57, Offset: 0x3e0
// Size: 0x2c
function function_702f74eb(slot, weapon) {
    self activategrapple();
}

// Namespace namespace_599aae2d/namespace_599aae2d
// Params 2, eflags: 0x0
// Checksum 0xa36290c1, Offset: 0x418
// Size: 0x14
function gadget_grapple_off(slot, weapon) {
    
}

// Namespace namespace_599aae2d/namespace_599aae2d
// Params 1, eflags: 0x0
// Checksum 0x8d9ff737, Offset: 0x438
// Size: 0x54
function function_8e943a3d(weapon) {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"spawned_player");
    self endon(#"hash_23671b0c");
    self thread grapple::watch_lockon(weapon);
}

