#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace namespace_e2d0cc68;

// Namespace namespace_e2d0cc68/namespace_e2d0cc68
// Params 0, eflags: 0x2
// Checksum 0x9213a7dd, Offset: 0x238
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_servo_shortout", &__init__, undefined, undefined);
}

// Namespace namespace_e2d0cc68/namespace_e2d0cc68
// Params 0, eflags: 0x0
// Checksum 0x71a2d308, Offset: 0x278
// Size: 0x104
function __init__() {
    ability_player::register_gadget_activation_callbacks(19, &function_39b385d0, &function_c1ce069e);
    ability_player::register_gadget_possession_callbacks(19, &function_fc4fe7cc, &function_3e88bf7a);
    ability_player::register_gadget_flicker_callbacks(19, &function_2b96d045);
    ability_player::register_gadget_is_inuse_callbacks(19, &function_d0064a78);
    ability_player::register_gadget_is_flickering_callbacks(19, &function_a850a436);
    ability_player::register_gadget_primed_callbacks(19, &function_2be7b311);
    callback::on_connect(&function_901d2323);
}

// Namespace namespace_e2d0cc68/namespace_e2d0cc68
// Params 1, eflags: 0x0
// Checksum 0xe47231be, Offset: 0x388
// Size: 0x2a
function function_d0064a78(slot) {
    return self flagsys::get("gadget_servo_shortout_on");
}

// Namespace namespace_e2d0cc68/namespace_e2d0cc68
// Params 1, eflags: 0x0
// Checksum 0xe2c0789e, Offset: 0x3c0
// Size: 0x5e
function function_a850a436(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.servo_shortout)) {
        return self [[ level.cybercom.servo_shortout.var_875da84b ]](slot);
    }
    return 0;
}

// Namespace namespace_e2d0cc68/namespace_e2d0cc68
// Params 2, eflags: 0x0
// Checksum 0xc087fbde, Offset: 0x428
// Size: 0x68
function function_2b96d045(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.servo_shortout)) {
        self [[ level.cybercom.servo_shortout.var_8d01efb6 ]](slot, weapon);
    }
}

// Namespace namespace_e2d0cc68/namespace_e2d0cc68
// Params 2, eflags: 0x0
// Checksum 0xe44f8176, Offset: 0x498
// Size: 0x68
function function_fc4fe7cc(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.servo_shortout)) {
        self [[ level.cybercom.servo_shortout.var_bdb47551 ]](slot, weapon);
    }
}

// Namespace namespace_e2d0cc68/namespace_e2d0cc68
// Params 2, eflags: 0x0
// Checksum 0x605cd613, Offset: 0x508
// Size: 0x68
function function_3e88bf7a(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.servo_shortout)) {
        self [[ level.cybercom.servo_shortout.var_39ea6a1b ]](slot, weapon);
    }
}

// Namespace namespace_e2d0cc68/namespace_e2d0cc68
// Params 0, eflags: 0x0
// Checksum 0x214fe55e, Offset: 0x578
// Size: 0x50
function function_901d2323() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.servo_shortout)) {
        self [[ level.cybercom.servo_shortout.var_5d2fec30 ]]();
    }
}

// Namespace namespace_e2d0cc68/namespace_e2d0cc68
// Params 2, eflags: 0x0
// Checksum 0x7c2df55d, Offset: 0x5d0
// Size: 0x88
function function_39b385d0(slot, weapon) {
    self flagsys::set("gadget_servo_shortout_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.servo_shortout)) {
        self [[ level.cybercom.servo_shortout._on ]](slot, weapon);
    }
}

// Namespace namespace_e2d0cc68/namespace_e2d0cc68
// Params 2, eflags: 0x0
// Checksum 0xfc704ced, Offset: 0x660
// Size: 0x88
function function_c1ce069e(slot, weapon) {
    self flagsys::clear("gadget_servo_shortout_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.servo_shortout)) {
        self [[ level.cybercom.servo_shortout._off ]](slot, weapon);
    }
}

// Namespace namespace_e2d0cc68/namespace_e2d0cc68
// Params 2, eflags: 0x0
// Checksum 0xb705ba58, Offset: 0x6f0
// Size: 0x68
function function_2be7b311(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.servo_shortout)) {
        self [[ level.cybercom.servo_shortout.var_4135a1c4 ]](slot, weapon);
    }
}

