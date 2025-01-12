#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;

#namespace namespace_2bc1f33;

// Namespace namespace_2bc1f33/namespace_2bc1f33
// Params 0, eflags: 0x2
// Checksum 0x3517958b, Offset: 0x1a8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_armor_regen", &__init__, undefined, undefined);
}

// Namespace namespace_2bc1f33/namespace_2bc1f33
// Params 0, eflags: 0x0
// Checksum 0x9f3c531f, Offset: 0x1e8
// Size: 0xe4
function __init__() {
    ability_player::register_gadget_activation_callbacks(3, &function_cae184a9, &function_c507dd5);
    ability_player::register_gadget_possession_callbacks(3, &function_ba29deef, &function_502b28a5);
    ability_player::register_gadget_flicker_callbacks(3, &function_84d86bf8);
    ability_player::register_gadget_is_inuse_callbacks(3, &function_e9ff27e9);
    ability_player::register_gadget_is_flickering_callbacks(3, &function_199c504d);
    callback::on_connect(&function_e1d96d6e);
}

// Namespace namespace_2bc1f33/namespace_2bc1f33
// Params 1, eflags: 0x0
// Checksum 0xb8126c2e, Offset: 0x2d8
// Size: 0x22
function function_e9ff27e9(slot) {
    return self gadgetisactive(slot);
}

// Namespace namespace_2bc1f33/namespace_2bc1f33
// Params 1, eflags: 0x0
// Checksum 0x8d11bf0e, Offset: 0x308
// Size: 0x22
function function_199c504d(slot) {
    return self gadgetflickering(slot);
}

// Namespace namespace_2bc1f33/namespace_2bc1f33
// Params 2, eflags: 0x0
// Checksum 0x1f4b9e8c, Offset: 0x338
// Size: 0x14
function function_84d86bf8(slot, weapon) {
    
}

// Namespace namespace_2bc1f33/namespace_2bc1f33
// Params 2, eflags: 0x0
// Checksum 0xa0dd371a, Offset: 0x358
// Size: 0x24
function function_ba29deef(slot, weapon) {
    self.var_ac83d290 = 1;
}

// Namespace namespace_2bc1f33/namespace_2bc1f33
// Params 2, eflags: 0x0
// Checksum 0x8dff16e3, Offset: 0x388
// Size: 0x20
function function_502b28a5(slot, weapon) {
    self.var_ac83d290 = 0;
}

// Namespace namespace_2bc1f33/namespace_2bc1f33
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x3b0
// Size: 0x4
function function_e1d96d6e() {
    
}

// Namespace namespace_2bc1f33/namespace_2bc1f33
// Params 2, eflags: 0x0
// Checksum 0x869d0faa, Offset: 0x3c0
// Size: 0x14
function function_cae184a9(slot, weapon) {
    
}

// Namespace namespace_2bc1f33/namespace_2bc1f33
// Params 2, eflags: 0x0
// Checksum 0x150e3687, Offset: 0x3e0
// Size: 0x14
function function_c507dd5(slot, weapon) {
    
}

// Namespace namespace_2bc1f33/namespace_2bc1f33
// Params 0, eflags: 0x0
// Checksum 0x43c8626c, Offset: 0x400
// Size: 0xa
function function_fcb803db() {
    return 0.1;
}

// Namespace namespace_2bc1f33/namespace_2bc1f33
// Params 0, eflags: 0x0
// Checksum 0x7ddef23, Offset: 0x418
// Size: 0xa
function function_4ed95049() {
    return 0.1;
}

// Namespace namespace_2bc1f33/namespace_2bc1f33
// Params 0, eflags: 0x0
// Checksum 0x99d44f3d, Offset: 0x430
// Size: 0x14
function function_ac83d290() {
    return self.var_ac83d290 === 1;
}

// Namespace namespace_2bc1f33/namespace_2bc1f33
// Params 0, eflags: 0x0
// Checksum 0x3bc903ec, Offset: 0x450
// Size: 0x32
function function_e0e60428() {
    if (!self function_ac83d290()) {
        return 0;
    }
    return self fragbuttonpressed();
}

// Namespace namespace_2bc1f33/namespace_2bc1f33
// Params 0, eflags: 0x0
// Checksum 0x116dc47c, Offset: 0x490
// Size: 0x5c
function function_de6f0bd7() {
    if (function_e0e60428() == 0) {
        return false;
    }
    var_cf0b1b1 = 5;
    if (!isdefined(self.var_ceae2809)) {
        self.var_ceae2809 = 0;
    }
    return self.var_ceae2809 < var_cf0b1b1;
}

// Namespace namespace_2bc1f33/namespace_2bc1f33
// Params 0, eflags: 0x0
// Checksum 0x9c48b1e0, Offset: 0x4f8
// Size: 0x2c
function function_1641f38c() {
    if (!isdefined(self.var_ceae2809)) {
        self.var_ceae2809 = 0;
    }
    self.var_ceae2809++;
}

