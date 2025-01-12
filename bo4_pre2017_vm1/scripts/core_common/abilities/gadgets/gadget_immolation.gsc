#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace namespace_acef958d;

// Namespace namespace_acef958d/namespace_acef958d
// Params 0, eflags: 0x2
// Checksum 0x2ded66ff, Offset: 0x228
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_immolation", &__init__, undefined, undefined);
}

// Namespace namespace_acef958d/namespace_acef958d
// Params 0, eflags: 0x0
// Checksum 0xa1428bce, Offset: 0x268
// Size: 0x104
function __init__() {
    ability_player::register_gadget_activation_callbacks(34, &function_7c43428b, &function_43d6ec7f);
    ability_player::register_gadget_possession_callbacks(34, &function_f4ff64c1, &function_6947e88b);
    ability_player::register_gadget_flicker_callbacks(34, &function_51e92cc6);
    ability_player::register_gadget_is_inuse_callbacks(34, &function_b024aecb);
    ability_player::register_gadget_is_flickering_callbacks(34, &function_a881191b);
    ability_player::register_gadget_primed_callbacks(34, &function_77bcc634);
    callback::on_connect(&function_44821bc0);
}

// Namespace namespace_acef958d/namespace_acef958d
// Params 1, eflags: 0x0
// Checksum 0x8e7029d, Offset: 0x378
// Size: 0x2a
function function_b024aecb(slot) {
    return self flagsys::get("gadget_immolation_on");
}

// Namespace namespace_acef958d/namespace_acef958d
// Params 1, eflags: 0x0
// Checksum 0xf2d89ac8, Offset: 0x3b0
// Size: 0x5e
function function_a881191b(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.immolation)) {
        return self [[ level.cybercom.immolation.var_875da84b ]](slot);
    }
    return 0;
}

// Namespace namespace_acef958d/namespace_acef958d
// Params 2, eflags: 0x0
// Checksum 0xe7fb1cc0, Offset: 0x418
// Size: 0x68
function function_51e92cc6(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.immolation)) {
        self [[ level.cybercom.immolation.var_8d01efb6 ]](slot, weapon);
    }
}

// Namespace namespace_acef958d/namespace_acef958d
// Params 2, eflags: 0x0
// Checksum 0x38eb2afe, Offset: 0x488
// Size: 0x68
function function_f4ff64c1(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.immolation)) {
        self [[ level.cybercom.immolation.var_bdb47551 ]](slot, weapon);
    }
}

// Namespace namespace_acef958d/namespace_acef958d
// Params 2, eflags: 0x0
// Checksum 0x14d9952, Offset: 0x4f8
// Size: 0x68
function function_6947e88b(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.immolation)) {
        self [[ level.cybercom.immolation.var_39ea6a1b ]](slot, weapon);
    }
}

// Namespace namespace_acef958d/namespace_acef958d
// Params 0, eflags: 0x0
// Checksum 0x18eeba40, Offset: 0x568
// Size: 0x50
function function_44821bc0() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.immolation)) {
        self [[ level.cybercom.immolation.var_5d2fec30 ]]();
    }
}

// Namespace namespace_acef958d/namespace_acef958d
// Params 2, eflags: 0x0
// Checksum 0xf84db01f, Offset: 0x5c0
// Size: 0x88
function function_7c43428b(slot, weapon) {
    self flagsys::set("gadget_immolation_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.immolation)) {
        self [[ level.cybercom.immolation._on ]](slot, weapon);
    }
}

// Namespace namespace_acef958d/namespace_acef958d
// Params 2, eflags: 0x0
// Checksum 0x2d243a38, Offset: 0x650
// Size: 0x88
function function_43d6ec7f(slot, weapon) {
    self flagsys::clear("gadget_immolation_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.immolation)) {
        self [[ level.cybercom.immolation._off ]](slot, weapon);
    }
}

// Namespace namespace_acef958d/namespace_acef958d
// Params 2, eflags: 0x0
// Checksum 0x1cf3108d, Offset: 0x6e0
// Size: 0x68
function function_77bcc634(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.immolation)) {
        self [[ level.cybercom.immolation.var_4135a1c4 ]](slot, weapon);
    }
}

