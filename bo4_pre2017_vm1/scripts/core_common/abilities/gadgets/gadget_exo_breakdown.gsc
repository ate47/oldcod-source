#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace gadget_exo_breakdown;

// Namespace gadget_exo_breakdown/gadget_exo_breakdown
// Params 0, eflags: 0x2
// Checksum 0x541adf66, Offset: 0x230
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_exo_breakdown", &__init__, undefined, undefined);
}

// Namespace gadget_exo_breakdown/gadget_exo_breakdown
// Params 0, eflags: 0x0
// Checksum 0xb064ae51, Offset: 0x270
// Size: 0x104
function __init__() {
    ability_player::register_gadget_activation_callbacks(20, &gadget_exo_breakdown_on, &gadget_exo_breakdown_off);
    ability_player::register_gadget_possession_callbacks(20, &gadget_exo_breakdown_on_give, &gadget_exo_breakdown_on_take);
    ability_player::register_gadget_flicker_callbacks(20, &gadget_exo_breakdown_on_flicker);
    ability_player::register_gadget_is_inuse_callbacks(20, &gadget_exo_breakdown_is_inuse);
    ability_player::register_gadget_is_flickering_callbacks(20, &gadget_exo_breakdown_is_flickering);
    ability_player::register_gadget_primed_callbacks(20, &gadget_exo_breakdown_is_primed);
    callback::on_connect(&gadget_exo_breakdown_on_connect);
}

// Namespace gadget_exo_breakdown/gadget_exo_breakdown
// Params 1, eflags: 0x0
// Checksum 0x773c0d1e, Offset: 0x380
// Size: 0x2a
function gadget_exo_breakdown_is_inuse(slot) {
    return self flagsys::get("gadget_exo_breakdown_on");
}

// Namespace gadget_exo_breakdown/gadget_exo_breakdown
// Params 1, eflags: 0x0
// Checksum 0xcfaae20a, Offset: 0x3b8
// Size: 0x5e
function gadget_exo_breakdown_is_flickering(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.exo_breakdown)) {
        return self [[ level.cybercom.exo_breakdown._is_flickering ]](slot);
    }
    return 0;
}

// Namespace gadget_exo_breakdown/gadget_exo_breakdown
// Params 2, eflags: 0x0
// Checksum 0x8054652a, Offset: 0x420
// Size: 0x68
function gadget_exo_breakdown_on_flicker(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.exo_breakdown)) {
        self [[ level.cybercom.exo_breakdown._on_flicker ]](slot, weapon);
    }
}

// Namespace gadget_exo_breakdown/gadget_exo_breakdown
// Params 2, eflags: 0x0
// Checksum 0x817382e3, Offset: 0x490
// Size: 0x68
function gadget_exo_breakdown_on_give(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.exo_breakdown)) {
        self [[ level.cybercom.exo_breakdown._on_give ]](slot, weapon);
    }
}

// Namespace gadget_exo_breakdown/gadget_exo_breakdown
// Params 2, eflags: 0x0
// Checksum 0xb6e61ac2, Offset: 0x500
// Size: 0x68
function gadget_exo_breakdown_on_take(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.exo_breakdown)) {
        self [[ level.cybercom.exo_breakdown._on_take ]](slot, weapon);
    }
}

// Namespace gadget_exo_breakdown/gadget_exo_breakdown
// Params 0, eflags: 0x0
// Checksum 0x7075f48, Offset: 0x570
// Size: 0x50
function gadget_exo_breakdown_on_connect() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.exo_breakdown)) {
        self [[ level.cybercom.exo_breakdown._on_connect ]]();
    }
}

// Namespace gadget_exo_breakdown/gadget_exo_breakdown
// Params 2, eflags: 0x0
// Checksum 0x776fe517, Offset: 0x5c8
// Size: 0x88
function gadget_exo_breakdown_on(slot, weapon) {
    self flagsys::set("gadget_exo_breakdown_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.exo_breakdown)) {
        self [[ level.cybercom.exo_breakdown._on ]](slot, weapon);
    }
}

// Namespace gadget_exo_breakdown/gadget_exo_breakdown
// Params 2, eflags: 0x0
// Checksum 0xd0d88c69, Offset: 0x658
// Size: 0x88
function gadget_exo_breakdown_off(slot, weapon) {
    self flagsys::clear("gadget_exo_breakdown_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.exo_breakdown)) {
        self [[ level.cybercom.exo_breakdown._off ]](slot, weapon);
    }
}

// Namespace gadget_exo_breakdown/gadget_exo_breakdown
// Params 2, eflags: 0x0
// Checksum 0x85fca321, Offset: 0x6e8
// Size: 0x68
function gadget_exo_breakdown_is_primed(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.exo_breakdown)) {
        self [[ level.cybercom.exo_breakdown._is_primed ]](slot, weapon);
    }
}

