#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace namespace_82bfd9f7;

// Namespace namespace_82bfd9f7/namespace_82bfd9f7
// Params 0, eflags: 0x2
// Checksum 0x2204fcfb, Offset: 0x230
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_rapid_strike", &__init__, undefined, undefined);
}

// Namespace namespace_82bfd9f7/namespace_82bfd9f7
// Params 0, eflags: 0x0
// Checksum 0x73b87653, Offset: 0x270
// Size: 0xe4
function __init__() {
    ability_player::register_gadget_activation_callbacks(30, &function_e3ae201d, &function_5b9296a9);
    ability_player::register_gadget_possession_callbacks(30, &function_d7b6939b, &function_d2114e79);
    ability_player::register_gadget_flicker_callbacks(30, &function_dec6547c);
    ability_player::register_gadget_is_inuse_callbacks(30, &function_96b27bbd);
    ability_player::register_gadget_is_flickering_callbacks(30, &function_f168e6c9);
    callback::on_connect(&function_672b2d72);
}

// Namespace namespace_82bfd9f7/namespace_82bfd9f7
// Params 1, eflags: 0x0
// Checksum 0x60288d9d, Offset: 0x360
// Size: 0x2a
function function_96b27bbd(slot) {
    return self flagsys::get("gadget_rapid_strike_on");
}

// Namespace namespace_82bfd9f7/namespace_82bfd9f7
// Params 1, eflags: 0x0
// Checksum 0xd9b7024b, Offset: 0x398
// Size: 0x5c
function function_f168e6c9(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.rapid_strike)) {
        return self [[ level.cybercom.rapid_strike.var_875da84b ]](slot);
    }
}

// Namespace namespace_82bfd9f7/namespace_82bfd9f7
// Params 2, eflags: 0x0
// Checksum 0xa00cd6fa, Offset: 0x400
// Size: 0x68
function function_dec6547c(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.rapid_strike)) {
        self [[ level.cybercom.rapid_strike.var_8d01efb6 ]](slot, weapon);
    }
}

// Namespace namespace_82bfd9f7/namespace_82bfd9f7
// Params 2, eflags: 0x0
// Checksum 0xd523ee0e, Offset: 0x470
// Size: 0x68
function function_d7b6939b(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.rapid_strike)) {
        self [[ level.cybercom.rapid_strike.var_bdb47551 ]](slot, weapon);
    }
}

// Namespace namespace_82bfd9f7/namespace_82bfd9f7
// Params 2, eflags: 0x0
// Checksum 0x8647d87b, Offset: 0x4e0
// Size: 0x68
function function_d2114e79(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.rapid_strike)) {
        self [[ level.cybercom.rapid_strike.var_39ea6a1b ]](slot, weapon);
    }
}

// Namespace namespace_82bfd9f7/namespace_82bfd9f7
// Params 0, eflags: 0x0
// Checksum 0xda6fb6d2, Offset: 0x550
// Size: 0x50
function function_672b2d72() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.rapid_strike)) {
        self [[ level.cybercom.rapid_strike.var_5d2fec30 ]]();
    }
}

// Namespace namespace_82bfd9f7/namespace_82bfd9f7
// Params 2, eflags: 0x0
// Checksum 0x3abf6e8, Offset: 0x5a8
// Size: 0x88
function function_e3ae201d(slot, weapon) {
    self flagsys::set("gadget_rapid_strike_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.rapid_strike)) {
        self [[ level.cybercom.rapid_strike._on ]](slot, weapon);
    }
}

// Namespace namespace_82bfd9f7/namespace_82bfd9f7
// Params 2, eflags: 0x0
// Checksum 0xd0cc9727, Offset: 0x638
// Size: 0x88
function function_5b9296a9(slot, weapon) {
    self flagsys::clear("gadget_rapid_strike_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.rapid_strike)) {
        self [[ level.cybercom.rapid_strike._off ]](slot, weapon);
    }
}

