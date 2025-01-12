#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace gadget_ravage_core;

// Namespace gadget_ravage_core/gadget_ravage_core
// Params 0, eflags: 0x2
// Checksum 0x28801e5a, Offset: 0x230
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_ravage_core", &__init__, undefined, undefined);
}

// Namespace gadget_ravage_core/gadget_ravage_core
// Params 0, eflags: 0x0
// Checksum 0xcddfbb5c, Offset: 0x270
// Size: 0xe4
function __init__() {
    ability_player::register_gadget_activation_callbacks(22, &gadget_ravage_core_on, &gadget_ravage_core_off);
    ability_player::register_gadget_possession_callbacks(22, &gadget_ravage_core_on_give, &gadget_ravage_core_on_take);
    ability_player::register_gadget_flicker_callbacks(22, &gadget_ravage_core_on_flicker);
    ability_player::register_gadget_is_inuse_callbacks(22, &gadget_ravage_core_is_inuse);
    ability_player::register_gadget_is_flickering_callbacks(22, &gadget_ravage_core_is_flickering);
    callback::on_connect(&gadget_ravage_core_on_connect);
}

// Namespace gadget_ravage_core/gadget_ravage_core
// Params 1, eflags: 0x0
// Checksum 0x5fd0f2, Offset: 0x360
// Size: 0x2a
function gadget_ravage_core_is_inuse(slot) {
    return self flagsys::get("gadget_ravage_core_on");
}

// Namespace gadget_ravage_core/gadget_ravage_core
// Params 1, eflags: 0x0
// Checksum 0x6dcbd8a0, Offset: 0x398
// Size: 0x5c
function gadget_ravage_core_is_flickering(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.ravage_core)) {
        return self [[ level.cybercom.ravage_core._is_flickering ]](slot);
    }
}

// Namespace gadget_ravage_core/gadget_ravage_core
// Params 2, eflags: 0x0
// Checksum 0x100c9e26, Offset: 0x400
// Size: 0x68
function gadget_ravage_core_on_flicker(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.ravage_core)) {
        self [[ level.cybercom.ravage_core._on_flicker ]](slot, weapon);
    }
}

// Namespace gadget_ravage_core/gadget_ravage_core
// Params 2, eflags: 0x0
// Checksum 0x7f536d29, Offset: 0x470
// Size: 0x68
function gadget_ravage_core_on_give(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.ravage_core)) {
        self [[ level.cybercom.ravage_core._on_give ]](slot, weapon);
    }
}

// Namespace gadget_ravage_core/gadget_ravage_core
// Params 2, eflags: 0x0
// Checksum 0xf32de9d0, Offset: 0x4e0
// Size: 0x68
function gadget_ravage_core_on_take(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.ravage_core)) {
        self [[ level.cybercom.ravage_core._on_take ]](slot, weapon);
    }
}

// Namespace gadget_ravage_core/gadget_ravage_core
// Params 0, eflags: 0x0
// Checksum 0xf0a4da4b, Offset: 0x550
// Size: 0x50
function gadget_ravage_core_on_connect() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.ravage_core)) {
        self [[ level.cybercom.ravage_core._on_connect ]]();
    }
}

// Namespace gadget_ravage_core/gadget_ravage_core
// Params 2, eflags: 0x0
// Checksum 0x1ddf3d0d, Offset: 0x5a8
// Size: 0x88
function gadget_ravage_core_on(slot, weapon) {
    self flagsys::set("gadget_ravage_core_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.ravage_core)) {
        self [[ level.cybercom.ravage_core._on ]](slot, weapon);
    }
}

// Namespace gadget_ravage_core/gadget_ravage_core
// Params 2, eflags: 0x0
// Checksum 0xe2671aff, Offset: 0x638
// Size: 0x88
function gadget_ravage_core_off(slot, weapon) {
    self flagsys::clear("gadget_ravage_core_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.ravage_core)) {
        self [[ level.cybercom.ravage_core._off ]](slot, weapon);
    }
}

