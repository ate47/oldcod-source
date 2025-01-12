#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace namespace_7e0d3ea4;

// Namespace namespace_7e0d3ea4/namespace_7e0d3ea4
// Params 0, eflags: 0x2
// Checksum 0xd78a252c, Offset: 0x230
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_iff_override", &__init__, undefined, undefined);
}

// Namespace namespace_7e0d3ea4/namespace_7e0d3ea4
// Params 0, eflags: 0x0
// Checksum 0xc753253f, Offset: 0x270
// Size: 0x104
function __init__() {
    ability_player::register_gadget_activation_callbacks(24, &function_3e1f85fc, &function_4377752a);
    ability_player::register_gadget_possession_callbacks(24, &function_2b859620, &function_bdd75256);
    ability_player::register_gadget_flicker_callbacks(24, &function_4c6c9561);
    ability_player::register_gadget_is_inuse_callbacks(24, &function_dd752664);
    ability_player::register_gadget_is_flickering_callbacks(24, &function_5dda9d3a);
    ability_player::register_gadget_primed_callbacks(24, &function_54113655);
    callback::on_connect(&function_96787fdf);
}

// Namespace namespace_7e0d3ea4/namespace_7e0d3ea4
// Params 1, eflags: 0x0
// Checksum 0x5dd6c43e, Offset: 0x380
// Size: 0x2a
function function_dd752664(slot) {
    return self flagsys::get("gadget_iff_override_on");
}

// Namespace namespace_7e0d3ea4/namespace_7e0d3ea4
// Params 1, eflags: 0x0
// Checksum 0xb3fb17ab, Offset: 0x3b8
// Size: 0x5e
function function_5dda9d3a(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.iff_override)) {
        return self [[ level.cybercom.iff_override.var_875da84b ]](slot);
    }
    return 0;
}

// Namespace namespace_7e0d3ea4/namespace_7e0d3ea4
// Params 2, eflags: 0x0
// Checksum 0x31982da6, Offset: 0x420
// Size: 0x68
function function_4c6c9561(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.iff_override)) {
        self [[ level.cybercom.iff_override.var_8d01efb6 ]](slot, weapon);
    }
}

// Namespace namespace_7e0d3ea4/namespace_7e0d3ea4
// Params 2, eflags: 0x0
// Checksum 0x6a653078, Offset: 0x490
// Size: 0x68
function function_2b859620(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.iff_override)) {
        self [[ level.cybercom.iff_override.var_bdb47551 ]](slot, weapon);
    }
}

// Namespace namespace_7e0d3ea4/namespace_7e0d3ea4
// Params 2, eflags: 0x0
// Checksum 0xb40d4200, Offset: 0x500
// Size: 0x68
function function_bdd75256(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.iff_override)) {
        self [[ level.cybercom.iff_override.var_39ea6a1b ]](slot, weapon);
    }
}

// Namespace namespace_7e0d3ea4/namespace_7e0d3ea4
// Params 0, eflags: 0x0
// Checksum 0x88a72b29, Offset: 0x570
// Size: 0x50
function function_96787fdf() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.iff_override)) {
        self [[ level.cybercom.iff_override.var_5d2fec30 ]]();
    }
}

// Namespace namespace_7e0d3ea4/namespace_7e0d3ea4
// Params 2, eflags: 0x0
// Checksum 0xc385b5dc, Offset: 0x5c8
// Size: 0x88
function function_3e1f85fc(slot, weapon) {
    self flagsys::set("gadget_iff_override_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.iff_override)) {
        self [[ level.cybercom.iff_override._on ]](slot, weapon);
    }
}

// Namespace namespace_7e0d3ea4/namespace_7e0d3ea4
// Params 2, eflags: 0x0
// Checksum 0xf9b2ab9c, Offset: 0x658
// Size: 0x88
function function_4377752a(slot, weapon) {
    self flagsys::clear("gadget_iff_override_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.iff_override)) {
        self [[ level.cybercom.iff_override._off ]](slot, weapon);
    }
}

// Namespace namespace_7e0d3ea4/namespace_7e0d3ea4
// Params 2, eflags: 0x0
// Checksum 0x897ee4ad, Offset: 0x6e8
// Size: 0x68
function function_54113655(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.iff_override)) {
        self [[ level.cybercom.iff_override.var_4135a1c4 ]](slot, weapon);
    }
}

