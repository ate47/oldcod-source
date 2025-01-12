#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/visionset_mgr_shared;

#namespace gadget_overdrive;

// Namespace gadget_overdrive/gadget_overdrive
// Params 0, eflags: 0x2
// Checksum 0x84303caa, Offset: 0x288
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_overdrive", &__init__, undefined, undefined);
}

// Namespace gadget_overdrive/gadget_overdrive
// Params 0, eflags: 0x0
// Checksum 0xbeaf5f65, Offset: 0x2c8
// Size: 0x17c
function __init__() {
    ability_player::register_gadget_activation_callbacks(28, &gadget_overdrive_on, &gadget_overdrive_off);
    ability_player::register_gadget_possession_callbacks(28, &gadget_overdrive_on_give, &gadget_overdrive_on_take);
    ability_player::register_gadget_flicker_callbacks(28, &gadget_overdrive_on_flicker);
    ability_player::register_gadget_is_inuse_callbacks(28, &gadget_overdrive_is_inuse);
    ability_player::register_gadget_is_flickering_callbacks(28, &gadget_overdrive_is_flickering);
    if (!isdefined(level.vsmgr_prio_visionset_overdrive)) {
        level.vsmgr_prio_visionset_overdrive = 65;
    }
    visionset_mgr::register_info("visionset", "overdrive", 1, level.vsmgr_prio_visionset_overdrive, 15, 1, &visionset_mgr::ramp_in_out_thread_per_player, 0);
    callback::on_connect(&gadget_overdrive_on_connect);
    clientfield::register("toplayer", "overdrive_state", 1, 1, "int");
}

// Namespace gadget_overdrive/gadget_overdrive
// Params 1, eflags: 0x0
// Checksum 0xd25ad0a3, Offset: 0x450
// Size: 0x2a
function gadget_overdrive_is_inuse(slot) {
    return self flagsys::get("gadget_overdrive_on");
}

// Namespace gadget_overdrive/gadget_overdrive
// Params 1, eflags: 0x0
// Checksum 0x78fdd2d4, Offset: 0x488
// Size: 0xc
function gadget_overdrive_is_flickering(slot) {
    
}

// Namespace gadget_overdrive/gadget_overdrive
// Params 2, eflags: 0x0
// Checksum 0xa423f690, Offset: 0x4a0
// Size: 0x14
function gadget_overdrive_on_flicker(slot, weapon) {
    
}

// Namespace gadget_overdrive/gadget_overdrive
// Params 2, eflags: 0x0
// Checksum 0x41aa542b, Offset: 0x4c0
// Size: 0x68
function gadget_overdrive_on_give(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.overdrive)) {
        self [[ level.cybercom.overdrive._on_give ]](slot, weapon);
    }
}

// Namespace gadget_overdrive/gadget_overdrive
// Params 2, eflags: 0x0
// Checksum 0x79a44c1, Offset: 0x530
// Size: 0x68
function gadget_overdrive_on_take(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.overdrive)) {
        self [[ level.cybercom.overdrive._on_take ]](slot, weapon);
    }
}

// Namespace gadget_overdrive/gadget_overdrive
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x5a0
// Size: 0x4
function gadget_overdrive_on_connect() {
    
}

// Namespace gadget_overdrive/gadget_overdrive
// Params 2, eflags: 0x0
// Checksum 0x6e3ef138, Offset: 0x5b0
// Size: 0x84
function gadget_overdrive_on(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.overdrive)) {
        self thread [[ level.cybercom.overdrive._on ]](slot, weapon);
        self flagsys::set("gadget_overdrive_on");
    }
}

// Namespace gadget_overdrive/gadget_overdrive
// Params 2, eflags: 0x0
// Checksum 0x77761208, Offset: 0x640
// Size: 0x88
function gadget_overdrive_off(slot, weapon) {
    self flagsys::clear("gadget_overdrive_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.overdrive)) {
        self thread [[ level.cybercom.overdrive._off ]](slot, weapon);
    }
}

