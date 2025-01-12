#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace namespace_fa91b5da;

// Namespace namespace_fa91b5da/namespace_fa91b5da
// Params 0, eflags: 0x2
// Checksum 0x541adf66, Offset: 0x230
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_exo_breakdown", &__init__, undefined, undefined);
}

// Namespace namespace_fa91b5da/namespace_fa91b5da
// Params 0, eflags: 0x0
// Checksum 0xb064ae51, Offset: 0x270
// Size: 0x104
function __init__() {
    ability_player::register_gadget_activation_callbacks(20, &function_1d36a30a, &function_ead04890);
    ability_player::register_gadget_possession_callbacks(20, &function_7bbc329e, &function_a37dd970);
    ability_player::register_gadget_flicker_callbacks(20, &function_fdf21253);
    ability_player::register_gadget_is_inuse_callbacks(20, &function_10ced8a);
    ability_player::register_gadget_is_flickering_callbacks(20, &function_9ea7a824);
    ability_player::register_gadget_primed_callbacks(20, &function_eef5315b);
    callback::on_connect(&function_126f0e75);
}

// Namespace namespace_fa91b5da/namespace_fa91b5da
// Params 1, eflags: 0x0
// Checksum 0x773c0d1e, Offset: 0x380
// Size: 0x2a
function function_10ced8a(slot) {
    return self flagsys::get("gadget_exo_breakdown_on");
}

// Namespace namespace_fa91b5da/namespace_fa91b5da
// Params 1, eflags: 0x0
// Checksum 0xcfaae20a, Offset: 0x3b8
// Size: 0x5e
function function_9ea7a824(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.exo_breakdown)) {
        return self [[ level.cybercom.exo_breakdown.var_875da84b ]](slot);
    }
    return 0;
}

// Namespace namespace_fa91b5da/namespace_fa91b5da
// Params 2, eflags: 0x0
// Checksum 0x8054652a, Offset: 0x420
// Size: 0x68
function function_fdf21253(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.exo_breakdown)) {
        self [[ level.cybercom.exo_breakdown.var_8d01efb6 ]](slot, weapon);
    }
}

// Namespace namespace_fa91b5da/namespace_fa91b5da
// Params 2, eflags: 0x0
// Checksum 0x817382e3, Offset: 0x490
// Size: 0x68
function function_7bbc329e(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.exo_breakdown)) {
        self [[ level.cybercom.exo_breakdown.var_bdb47551 ]](slot, weapon);
    }
}

// Namespace namespace_fa91b5da/namespace_fa91b5da
// Params 2, eflags: 0x0
// Checksum 0xb6e61ac2, Offset: 0x500
// Size: 0x68
function function_a37dd970(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.exo_breakdown)) {
        self [[ level.cybercom.exo_breakdown.var_39ea6a1b ]](slot, weapon);
    }
}

// Namespace namespace_fa91b5da/namespace_fa91b5da
// Params 0, eflags: 0x0
// Checksum 0x7075f48, Offset: 0x570
// Size: 0x50
function function_126f0e75() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.exo_breakdown)) {
        self [[ level.cybercom.exo_breakdown.var_5d2fec30 ]]();
    }
}

// Namespace namespace_fa91b5da/namespace_fa91b5da
// Params 2, eflags: 0x0
// Checksum 0x776fe517, Offset: 0x5c8
// Size: 0x88
function function_1d36a30a(slot, weapon) {
    self flagsys::set("gadget_exo_breakdown_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.exo_breakdown)) {
        self [[ level.cybercom.exo_breakdown._on ]](slot, weapon);
    }
}

// Namespace namespace_fa91b5da/namespace_fa91b5da
// Params 2, eflags: 0x0
// Checksum 0xd0d88c69, Offset: 0x658
// Size: 0x88
function function_ead04890(slot, weapon) {
    self flagsys::clear("gadget_exo_breakdown_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.exo_breakdown)) {
        self [[ level.cybercom.exo_breakdown._off ]](slot, weapon);
    }
}

// Namespace namespace_fa91b5da/namespace_fa91b5da
// Params 2, eflags: 0x0
// Checksum 0x85fca321, Offset: 0x6e8
// Size: 0x68
function function_eef5315b(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.exo_breakdown)) {
        self [[ level.cybercom.exo_breakdown.var_4135a1c4 ]](slot, weapon);
    }
}

