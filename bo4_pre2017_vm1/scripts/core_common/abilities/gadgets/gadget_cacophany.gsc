#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace namespace_3eb4aa7c;

// Namespace namespace_3eb4aa7c/namespace_3eb4aa7c
// Params 0, eflags: 0x2
// Checksum 0x5bfb3aa, Offset: 0x228
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_cacophany", &__init__, undefined, undefined);
}

// Namespace namespace_3eb4aa7c/namespace_3eb4aa7c
// Params 0, eflags: 0x0
// Checksum 0xed7e4d6c, Offset: 0x268
// Size: 0x104
function __init__() {
    ability_player::register_gadget_activation_callbacks(25, &function_42e85e54, &function_120f3c62);
    ability_player::register_gadget_possession_callbacks(25, &function_77666ae8, &function_bea195fe);
    ability_player::register_gadget_flicker_callbacks(25, &function_639bf239);
    ability_player::register_gadget_is_inuse_callbacks(25, &function_dea97fdc);
    ability_player::register_gadget_is_flickering_callbacks(25, &function_2164e92);
    ability_player::register_gadget_primed_callbacks(25, &function_6c067efd);
    callback::on_connect(&function_a11b5c77);
}

// Namespace namespace_3eb4aa7c/namespace_3eb4aa7c
// Params 1, eflags: 0x0
// Checksum 0xc35c3e85, Offset: 0x378
// Size: 0x2a
function function_dea97fdc(slot) {
    return self flagsys::get("gadget_cacophany_on");
}

// Namespace namespace_3eb4aa7c/namespace_3eb4aa7c
// Params 1, eflags: 0x0
// Checksum 0x93a8d287, Offset: 0x3b0
// Size: 0x5c
function function_2164e92(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.cacophany)) {
        return self [[ level.cybercom.cacophany.var_875da84b ]](slot);
    }
}

// Namespace namespace_3eb4aa7c/namespace_3eb4aa7c
// Params 2, eflags: 0x0
// Checksum 0x44acccd1, Offset: 0x418
// Size: 0x68
function function_639bf239(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.cacophany)) {
        self [[ level.cybercom.cacophany.var_8d01efb6 ]](slot, weapon);
    }
}

// Namespace namespace_3eb4aa7c/namespace_3eb4aa7c
// Params 2, eflags: 0x0
// Checksum 0xd9748397, Offset: 0x488
// Size: 0x68
function function_77666ae8(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.cacophany)) {
        self [[ level.cybercom.cacophany.var_bdb47551 ]](slot, weapon);
    }
}

// Namespace namespace_3eb4aa7c/namespace_3eb4aa7c
// Params 2, eflags: 0x0
// Checksum 0x9301f070, Offset: 0x4f8
// Size: 0x68
function function_bea195fe(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.cacophany)) {
        self [[ level.cybercom.cacophany.var_39ea6a1b ]](slot, weapon);
    }
}

// Namespace namespace_3eb4aa7c/namespace_3eb4aa7c
// Params 0, eflags: 0x0
// Checksum 0xb00dd439, Offset: 0x568
// Size: 0x50
function function_a11b5c77() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.cacophany)) {
        self [[ level.cybercom.cacophany.var_5d2fec30 ]]();
    }
}

// Namespace namespace_3eb4aa7c/namespace_3eb4aa7c
// Params 2, eflags: 0x0
// Checksum 0xad2cf24a, Offset: 0x5c0
// Size: 0x88
function function_42e85e54(slot, weapon) {
    self flagsys::set("gadget_cacophany_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.cacophany)) {
        self [[ level.cybercom.cacophany._on ]](slot, weapon);
    }
}

// Namespace namespace_3eb4aa7c/namespace_3eb4aa7c
// Params 2, eflags: 0x0
// Checksum 0xf472bee5, Offset: 0x650
// Size: 0x88
function function_120f3c62(slot, weapon) {
    self flagsys::clear("gadget_cacophany_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.cacophany)) {
        self [[ level.cybercom.cacophany._off ]](slot, weapon);
    }
}

// Namespace namespace_3eb4aa7c/namespace_3eb4aa7c
// Params 2, eflags: 0x0
// Checksum 0xe713721e, Offset: 0x6e0
// Size: 0x68
function function_6c067efd(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.cacophany)) {
        self [[ level.cybercom.cacophany.var_4135a1c4 ]](slot, weapon);
    }
}

