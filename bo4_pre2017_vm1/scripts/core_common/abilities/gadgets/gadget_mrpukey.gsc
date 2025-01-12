#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace gadget_mrpukey;

// Namespace gadget_mrpukey/gadget_mrpukey
// Params 0, eflags: 0x2
// Checksum 0x7cacf58, Offset: 0x220
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_mrpukey", &__init__, undefined, undefined);
}

// Namespace gadget_mrpukey/gadget_mrpukey
// Params 0, eflags: 0x0
// Checksum 0xfe4da15c, Offset: 0x260
// Size: 0xe4
function __init__() {
    ability_player::register_gadget_activation_callbacks(38, &gadget_mrpukey_on, &gadget_mrpukey_off);
    ability_player::register_gadget_possession_callbacks(38, &gadget_mrpukey_on_give, &gadget_mrpukey_on_take);
    ability_player::register_gadget_flicker_callbacks(38, &gadget_mrpukey_on_flicker);
    ability_player::register_gadget_is_inuse_callbacks(38, &gadget_mrpukey_is_inuse);
    ability_player::register_gadget_is_flickering_callbacks(38, &gadget_mrpukey_is_flickering);
    ability_player::register_gadget_primed_callbacks(38, &gadget_mrpukey_is_primed);
}

// Namespace gadget_mrpukey/gadget_mrpukey
// Params 1, eflags: 0x0
// Checksum 0xbe096247, Offset: 0x350
// Size: 0x2a
function gadget_mrpukey_is_inuse(slot) {
    return self flagsys::get("gadget_mrpukey_on");
}

// Namespace gadget_mrpukey/gadget_mrpukey
// Params 1, eflags: 0x0
// Checksum 0xcfe60e0a, Offset: 0x388
// Size: 0x5c
function gadget_mrpukey_is_flickering(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.mrpukey)) {
        return self [[ level.cybercom.mrpukey._is_flickering ]](slot);
    }
}

// Namespace gadget_mrpukey/gadget_mrpukey
// Params 2, eflags: 0x0
// Checksum 0x9dc5b5be, Offset: 0x3f0
// Size: 0x68
function gadget_mrpukey_on_flicker(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.mrpukey)) {
        self [[ level.cybercom.mrpukey._on_flicker ]](slot, weapon);
    }
}

// Namespace gadget_mrpukey/gadget_mrpukey
// Params 2, eflags: 0x0
// Checksum 0x673ec75d, Offset: 0x460
// Size: 0x68
function gadget_mrpukey_on_give(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.mrpukey)) {
        self [[ level.cybercom.mrpukey._on_give ]](slot, weapon);
    }
}

// Namespace gadget_mrpukey/gadget_mrpukey
// Params 2, eflags: 0x0
// Checksum 0x6a1d9cba, Offset: 0x4d0
// Size: 0x68
function gadget_mrpukey_on_take(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.mrpukey)) {
        self [[ level.cybercom.mrpukey._on_take ]](slot, weapon);
    }
}

// Namespace gadget_mrpukey/gadget_mrpukey
// Params 0, eflags: 0x0
// Checksum 0xb09d4ed7, Offset: 0x540
// Size: 0x50
function gadge_mrpukey_on_connect() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.mrpukey)) {
        self [[ level.cybercom.mrpukey._on_connect ]]();
    }
}

// Namespace gadget_mrpukey/gadget_mrpukey
// Params 2, eflags: 0x0
// Checksum 0x847992a4, Offset: 0x598
// Size: 0x88
function gadget_mrpukey_on(slot, weapon) {
    self flagsys::set("gadget_mrpukey_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.mrpukey)) {
        self [[ level.cybercom.mrpukey._on ]](slot, weapon);
    }
}

// Namespace gadget_mrpukey/gadget_mrpukey
// Params 2, eflags: 0x0
// Checksum 0xebff9333, Offset: 0x628
// Size: 0x88
function gadget_mrpukey_off(slot, weapon) {
    self flagsys::clear("gadget_mrpukey_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.mrpukey)) {
        self [[ level.cybercom.mrpukey._off ]](slot, weapon);
    }
}

// Namespace gadget_mrpukey/gadget_mrpukey
// Params 2, eflags: 0x0
// Checksum 0x2c2b4601, Offset: 0x6b8
// Size: 0x68
function gadget_mrpukey_is_primed(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.mrpukey)) {
        self [[ level.cybercom.mrpukey._is_primed ]](slot, weapon);
    }
}

