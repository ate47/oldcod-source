#using scripts/core_common/abilities/ability_gadgets;
#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;

#namespace namespace_c7ee22b1;

// Namespace namespace_c7ee22b1/namespace_c7ee22b1
// Params 0, eflags: 0x2
// Checksum 0x1e5cd19, Offset: 0x218
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_active_camo", &__init__, undefined, undefined);
}

// Namespace namespace_c7ee22b1/namespace_c7ee22b1
// Params 0, eflags: 0x0
// Checksum 0x63c91363, Offset: 0x258
// Size: 0x124
function __init__() {
    ability_player::register_gadget_activation_callbacks(31, &function_700380c0, &function_3078d9ee);
    ability_player::register_gadget_possession_callbacks(31, &function_58efbfed, &function_9da1d50f);
    ability_player::register_gadget_flicker_callbacks(31, &function_63b9579a);
    ability_player::register_gadget_is_inuse_callbacks(31, &function_6b246a0f);
    ability_player::register_gadget_is_flickering_callbacks(31, &function_558ba1f7);
    callback::on_connect(&function_7af2cde4);
    callback::on_spawned(&function_2fd91ec7);
    callback::on_disconnect(&function_3f5bf600);
}

// Namespace namespace_c7ee22b1/namespace_c7ee22b1
// Params 0, eflags: 0x0
// Checksum 0x6b8f8328, Offset: 0x388
// Size: 0x50
function function_7af2cde4() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.active_camo)) {
        self [[ level.cybercom.active_camo.var_5d2fec30 ]]();
    }
}

// Namespace namespace_c7ee22b1/namespace_c7ee22b1
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x3e0
// Size: 0x4
function function_3f5bf600() {
    
}

// Namespace namespace_c7ee22b1/namespace_c7ee22b1
// Params 0, eflags: 0x0
// Checksum 0xd475d797, Offset: 0x3f0
// Size: 0x54
function function_2fd91ec7() {
    self flagsys::clear("camo_suit_on");
    self notify(#"hash_af133c03");
    self clientfield::set("camo_shader", 0);
}

// Namespace namespace_c7ee22b1/namespace_c7ee22b1
// Params 1, eflags: 0x0
// Checksum 0x51a8b749, Offset: 0x450
// Size: 0x2a
function function_6b246a0f(slot) {
    return self flagsys::get("camo_suit_on");
}

// Namespace namespace_c7ee22b1/namespace_c7ee22b1
// Params 1, eflags: 0x0
// Checksum 0xd57a4fc3, Offset: 0x488
// Size: 0x22
function function_558ba1f7(slot) {
    return self gadgetflickering(slot);
}

// Namespace namespace_c7ee22b1/namespace_c7ee22b1
// Params 2, eflags: 0x0
// Checksum 0x3cf57dcd, Offset: 0x4b8
// Size: 0x68
function function_58efbfed(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.active_camo)) {
        self [[ level.cybercom.active_camo.var_bdb47551 ]](slot, weapon);
    }
}

// Namespace namespace_c7ee22b1/namespace_c7ee22b1
// Params 2, eflags: 0x0
// Checksum 0x7eca75b1, Offset: 0x528
// Size: 0x78
function function_9da1d50f(slot, weapon) {
    self notify(#"hash_6adca138");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.active_camo)) {
        self [[ level.cybercom.active_camo.var_39ea6a1b ]](slot, weapon);
    }
}

// Namespace namespace_c7ee22b1/namespace_c7ee22b1
// Params 2, eflags: 0x0
// Checksum 0x78429d15, Offset: 0x5a8
// Size: 0x88
function function_63b9579a(slot, weapon) {
    self thread function_a68d6bbe(slot, weapon);
    if (isdefined(level.cybercom) && isdefined(level.cybercom.active_camo)) {
        self thread [[ level.cybercom.active_camo.var_8d01efb6 ]](slot, weapon);
    }
}

// Namespace namespace_c7ee22b1/namespace_c7ee22b1
// Params 2, eflags: 0x0
// Checksum 0xbd9b263b, Offset: 0x638
// Size: 0xac
function function_700380c0(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.active_camo)) {
        self thread [[ level.cybercom.active_camo._on ]](slot, weapon);
    } else {
        self clientfield::set("camo_shader", 1);
    }
    self flagsys::set("camo_suit_on");
}

// Namespace namespace_c7ee22b1/namespace_c7ee22b1
// Params 2, eflags: 0x0
// Checksum 0x6d97a0ba, Offset: 0x6f0
// Size: 0xb4
function function_3078d9ee(slot, weapon) {
    self flagsys::clear("camo_suit_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.active_camo)) {
        self thread [[ level.cybercom.active_camo._off ]](slot, weapon);
    }
    self notify(#"hash_af133c03");
    self clientfield::set("camo_shader", 0);
}

// Namespace namespace_c7ee22b1/namespace_c7ee22b1
// Params 2, eflags: 0x0
// Checksum 0x88daf394, Offset: 0x7b0
// Size: 0x9c
function function_a68d6bbe(slot, weapon) {
    self endon(#"disconnect");
    self endon(#"hash_af133c03");
    self clientfield::set("camo_shader", 2);
    function_f93698a2(slot, weapon);
    if (self function_6b246a0f(slot)) {
        self clientfield::set("camo_shader", 1);
    }
}

// Namespace namespace_c7ee22b1/namespace_c7ee22b1
// Params 2, eflags: 0x0
// Checksum 0xfcf91e6a, Offset: 0x858
// Size: 0x54
function function_f93698a2(slot, weapon) {
    self endon(#"death");
    self endon(#"hash_af133c03");
    while (self function_558ba1f7(slot)) {
        wait 0.5;
    }
}

