#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;

#namespace gadget_armor_regen;

// Namespace gadget_armor_regen/gadget_armor_regen
// Params 0, eflags: 0x2
// Checksum 0x3517958b, Offset: 0x1a8
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_armor_regen", &__init__, undefined, undefined);
}

// Namespace gadget_armor_regen/gadget_armor_regen
// Params 0, eflags: 0x0
// Checksum 0x9f3c531f, Offset: 0x1e8
// Size: 0xe4
function __init__() {
    ability_player::register_gadget_activation_callbacks(3, &gadget_armor_regen_on, &gadget_armor_regen_off);
    ability_player::register_gadget_possession_callbacks(3, &gadget_armor_regen_on_give, &gadget_armor_regen_on_take);
    ability_player::register_gadget_flicker_callbacks(3, &gadget_armor_regen_on_flicker);
    ability_player::register_gadget_is_inuse_callbacks(3, &gadget_armor_regen_is_inuse);
    ability_player::register_gadget_is_flickering_callbacks(3, &gadget_armor_regen_is_flickering);
    callback::on_connect(&gadget_armor_regen_on_connect);
}

// Namespace gadget_armor_regen/gadget_armor_regen
// Params 1, eflags: 0x0
// Checksum 0xb8126c2e, Offset: 0x2d8
// Size: 0x22
function gadget_armor_regen_is_inuse(slot) {
    return self gadgetisactive(slot);
}

// Namespace gadget_armor_regen/gadget_armor_regen
// Params 1, eflags: 0x0
// Checksum 0x8d11bf0e, Offset: 0x308
// Size: 0x22
function gadget_armor_regen_is_flickering(slot) {
    return self gadgetflickering(slot);
}

// Namespace gadget_armor_regen/gadget_armor_regen
// Params 2, eflags: 0x0
// Checksum 0x1f4b9e8c, Offset: 0x338
// Size: 0x14
function gadget_armor_regen_on_flicker(slot, weapon) {
    
}

// Namespace gadget_armor_regen/gadget_armor_regen
// Params 2, eflags: 0x0
// Checksum 0xa0dd371a, Offset: 0x358
// Size: 0x24
function gadget_armor_regen_on_give(slot, weapon) {
    self.has_gadget_armor_regen = 1;
}

// Namespace gadget_armor_regen/gadget_armor_regen
// Params 2, eflags: 0x0
// Checksum 0x8dff16e3, Offset: 0x388
// Size: 0x20
function gadget_armor_regen_on_take(slot, weapon) {
    self.has_gadget_armor_regen = 0;
}

// Namespace gadget_armor_regen/gadget_armor_regen
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x3b0
// Size: 0x4
function gadget_armor_regen_on_connect() {
    
}

// Namespace gadget_armor_regen/gadget_armor_regen
// Params 2, eflags: 0x0
// Checksum 0x869d0faa, Offset: 0x3c0
// Size: 0x14
function gadget_armor_regen_on(slot, weapon) {
    
}

// Namespace gadget_armor_regen/gadget_armor_regen
// Params 2, eflags: 0x0
// Checksum 0x150e3687, Offset: 0x3e0
// Size: 0x14
function gadget_armor_regen_off(slot, weapon) {
    
}

// Namespace gadget_armor_regen/gadget_armor_regen
// Params 0, eflags: 0x0
// Checksum 0x43c8626c, Offset: 0x400
// Size: 0xa
function get_regen_time_multiplier() {
    return 0.1;
}

// Namespace gadget_armor_regen/gadget_armor_regen
// Params 0, eflags: 0x0
// Checksum 0x7ddef23, Offset: 0x418
// Size: 0xa
function get_regen_delay_multiplier() {
    return 0.1;
}

// Namespace gadget_armor_regen/gadget_armor_regen
// Params 0, eflags: 0x0
// Checksum 0x99d44f3d, Offset: 0x430
// Size: 0x14
function has_gadget_armor_regen() {
    return self.has_gadget_armor_regen === 1;
}

// Namespace gadget_armor_regen/gadget_armor_regen
// Params 0, eflags: 0x0
// Checksum 0x3bc903ec, Offset: 0x450
// Size: 0x32
function is_regen_active() {
    if (!self has_gadget_armor_regen()) {
        return 0;
    }
    return self fragbuttonpressed();
}

// Namespace gadget_armor_regen/gadget_armor_regen
// Params 0, eflags: 0x0
// Checksum 0x116dc47c, Offset: 0x490
// Size: 0x5c
function can_increase_max_armor() {
    if (is_regen_active() == 0) {
        return false;
    }
    max_regen_applied_count = 5;
    if (!isdefined(self.gadget_armor_regen_applied)) {
        self.gadget_armor_regen_applied = 0;
    }
    return self.gadget_armor_regen_applied < max_regen_applied_count;
}

// Namespace gadget_armor_regen/gadget_armor_regen
// Params 0, eflags: 0x0
// Checksum 0x9c48b1e0, Offset: 0x4f8
// Size: 0x2c
function max_armor_increased() {
    if (!isdefined(self.gadget_armor_regen_applied)) {
        self.gadget_armor_regen_applied = 0;
    }
    self.gadget_armor_regen_applied++;
}

