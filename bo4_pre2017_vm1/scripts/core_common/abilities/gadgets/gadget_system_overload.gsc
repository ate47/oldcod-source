#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace namespace_f3b73f0c;

// Namespace namespace_f3b73f0c/namespace_f3b73f0c
// Params 0, eflags: 0x2
// Checksum 0x935af96e, Offset: 0x238
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_system_overload", &__init__, undefined, undefined);
}

// Namespace namespace_f3b73f0c/namespace_f3b73f0c
// Params 0, eflags: 0x0
// Checksum 0x26ac978a, Offset: 0x278
// Size: 0x104
function __init__() {
    ability_player::register_gadget_activation_callbacks(18, &function_e1f18864, &function_7eb9a812);
    ability_player::register_gadget_possession_callbacks(18, &function_88154e18, &function_319ce16e);
    ability_player::register_gadget_flicker_callbacks(18, &function_d25b7289);
    ability_player::register_gadget_is_inuse_callbacks(18, &function_d7934bec);
    ability_player::register_gadget_is_flickering_callbacks(18, &function_a0a61e62);
    ability_player::register_gadget_primed_callbacks(18, &function_a7a30eed);
    callback::on_connect(&function_613dce47);
}

// Namespace namespace_f3b73f0c/namespace_f3b73f0c
// Params 1, eflags: 0x0
// Checksum 0xc87a15ea, Offset: 0x388
// Size: 0x2a
function function_d7934bec(slot) {
    return self flagsys::get("gadget_system_overload_on");
}

// Namespace namespace_f3b73f0c/namespace_f3b73f0c
// Params 1, eflags: 0x0
// Checksum 0xca75038e, Offset: 0x3c0
// Size: 0x5e
function function_a0a61e62(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.system_overload)) {
        return self [[ level.cybercom.system_overload.var_875da84b ]](slot);
    }
    return 0;
}

// Namespace namespace_f3b73f0c/namespace_f3b73f0c
// Params 2, eflags: 0x0
// Checksum 0x17734e11, Offset: 0x428
// Size: 0x68
function function_d25b7289(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.system_overload)) {
        self [[ level.cybercom.system_overload.var_8d01efb6 ]](slot, weapon);
    }
}

// Namespace namespace_f3b73f0c/namespace_f3b73f0c
// Params 2, eflags: 0x0
// Checksum 0x715b57e9, Offset: 0x498
// Size: 0x68
function function_88154e18(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.system_overload)) {
        self [[ level.cybercom.system_overload.var_bdb47551 ]](slot, weapon);
    }
}

// Namespace namespace_f3b73f0c/namespace_f3b73f0c
// Params 2, eflags: 0x0
// Checksum 0x32558e27, Offset: 0x508
// Size: 0x68
function function_319ce16e(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.system_overload)) {
        self [[ level.cybercom.system_overload.var_39ea6a1b ]](slot, weapon);
    }
}

// Namespace namespace_f3b73f0c/namespace_f3b73f0c
// Params 0, eflags: 0x0
// Checksum 0xbde5d147, Offset: 0x578
// Size: 0x50
function function_613dce47() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.system_overload)) {
        self [[ level.cybercom.system_overload.var_5d2fec30 ]]();
    }
}

// Namespace namespace_f3b73f0c/namespace_f3b73f0c
// Params 2, eflags: 0x0
// Checksum 0xd6ac6365, Offset: 0x5d0
// Size: 0x88
function function_e1f18864(slot, weapon) {
    self flagsys::set("gadget_system_overload_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.system_overload)) {
        self [[ level.cybercom.system_overload._on ]](slot, weapon);
    }
}

// Namespace namespace_f3b73f0c/namespace_f3b73f0c
// Params 2, eflags: 0x0
// Checksum 0x4c7909d7, Offset: 0x660
// Size: 0x88
function function_7eb9a812(slot, weapon) {
    self flagsys::clear("gadget_system_overload_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.system_overload)) {
        self [[ level.cybercom.system_overload._off ]](slot, weapon);
    }
}

// Namespace namespace_f3b73f0c/namespace_f3b73f0c
// Params 2, eflags: 0x0
// Checksum 0x1a22faaa, Offset: 0x6f0
// Size: 0x68
function function_a7a30eed(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.system_overload)) {
        self [[ level.cybercom.system_overload.var_4135a1c4 ]](slot, weapon);
    }
}

