#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace gadget_security_breach;

// Namespace gadget_security_breach/gadget_security_breach
// Params 0, eflags: 0x2
// Checksum 0x8e424ee7, Offset: 0x238
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_security_breach", &__init__, undefined, undefined);
}

// Namespace gadget_security_breach/gadget_security_breach
// Params 0, eflags: 0x0
// Checksum 0xafbad60a, Offset: 0x278
// Size: 0x104
function __init__() {
    ability_player::register_gadget_activation_callbacks(23, &function_c5d34eae, &function_ae24e944);
    ability_player::register_gadget_possession_callbacks(23, &function_2f62c66a, &function_957ab904);
    ability_player::register_gadget_flicker_callbacks(23, &function_612f0337);
    ability_player::register_gadget_is_inuse_callbacks(23, &function_439b773e);
    ability_player::register_gadget_is_flickering_callbacks(23, &function_aab070f0);
    ability_player::register_gadget_primed_callbacks(23, &function_bbd467e7);
    callback::on_connect(&function_3ee9b19);
}

// Namespace gadget_security_breach/gadget_security_breach
// Params 1, eflags: 0x0
// Checksum 0xb431001c, Offset: 0x388
// Size: 0x2a
function function_439b773e(slot) {
    return self flagsys::get("gadget_security_breach_on");
}

// Namespace gadget_security_breach/gadget_security_breach
// Params 1, eflags: 0x0
// Checksum 0x9cfa19cc, Offset: 0x3c0
// Size: 0x5c
function function_aab070f0(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.var_76af92c1)) {
        return self [[ level.cybercom.var_76af92c1.var_875da84b ]](slot);
    }
}

// Namespace gadget_security_breach/gadget_security_breach
// Params 2, eflags: 0x0
// Checksum 0x8245023b, Offset: 0x428
// Size: 0x68
function function_612f0337(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.var_76af92c1)) {
        self [[ level.cybercom.var_76af92c1.var_8d01efb6 ]](slot, weapon);
    }
}

// Namespace gadget_security_breach/gadget_security_breach
// Params 2, eflags: 0x0
// Checksum 0xfeccfd5f, Offset: 0x498
// Size: 0x68
function function_2f62c66a(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.var_76af92c1)) {
        return self [[ level.cybercom.var_76af92c1.var_bdb47551 ]](slot, weapon);
    }
}

// Namespace gadget_security_breach/gadget_security_breach
// Params 2, eflags: 0x0
// Checksum 0xd1ba175c, Offset: 0x508
// Size: 0x68
function function_957ab904(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.var_76af92c1)) {
        return self [[ level.cybercom.var_76af92c1.var_39ea6a1b ]](slot, weapon);
    }
}

// Namespace gadget_security_breach/gadget_security_breach
// Params 0, eflags: 0x0
// Checksum 0xfe4c0f77, Offset: 0x578
// Size: 0x50
function function_3ee9b19() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.var_76af92c1)) {
        return self [[ level.cybercom.var_76af92c1.var_5d2fec30 ]]();
    }
}

// Namespace gadget_security_breach/gadget_security_breach
// Params 2, eflags: 0x0
// Checksum 0xcc0f9272, Offset: 0x5d0
// Size: 0x88
function function_c5d34eae(slot, weapon) {
    self flagsys::set("gadget_security_breach_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.var_76af92c1)) {
        return self [[ level.cybercom.var_76af92c1._on ]](slot, weapon);
    }
}

// Namespace gadget_security_breach/gadget_security_breach
// Params 2, eflags: 0x0
// Checksum 0x1d8d65f5, Offset: 0x660
// Size: 0x88
function function_ae24e944(slot, weapon) {
    self flagsys::clear("gadget_security_breach_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.var_76af92c1)) {
        return self [[ level.cybercom.var_76af92c1._off ]](slot, weapon);
    }
}

// Namespace gadget_security_breach/gadget_security_breach
// Params 2, eflags: 0x0
// Checksum 0xf2d5e59e, Offset: 0x6f0
// Size: 0x68
function function_bbd467e7(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.var_76af92c1)) {
        self [[ level.cybercom.var_76af92c1.var_4135a1c4 ]](slot, weapon);
    }
}

