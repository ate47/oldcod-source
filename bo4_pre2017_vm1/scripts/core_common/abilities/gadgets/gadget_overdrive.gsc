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
function autoexec function_2dc19561() {
    system::register("gadget_overdrive", &__init__, undefined, undefined);
}

// Namespace gadget_overdrive/gadget_overdrive
// Params 0, eflags: 0x0
// Checksum 0xbeaf5f65, Offset: 0x2c8
// Size: 0x17c
function __init__() {
    ability_player::register_gadget_activation_callbacks(28, &function_372c774a, &function_a0a9dd0);
    ability_player::register_gadget_possession_callbacks(28, &function_6f36bade, &function_96f861b0);
    ability_player::register_gadget_flicker_callbacks(28, &function_8b256b93);
    ability_player::register_gadget_is_inuse_callbacks(28, &function_99c38cca);
    ability_player::register_gadget_is_flickering_callbacks(28, &function_fdada264);
    if (!isdefined(level.var_ec5c8ef9)) {
        level.var_ec5c8ef9 = 65;
    }
    visionset_mgr::register_info("visionset", "overdrive", 1, level.var_ec5c8ef9, 15, 1, &visionset_mgr::ramp_in_out_thread_per_player, 0);
    callback::on_connect(&function_f40798b5);
    clientfield::register("toplayer", "overdrive_state", 1, 1, "int");
}

// Namespace gadget_overdrive/gadget_overdrive
// Params 1, eflags: 0x0
// Checksum 0xd25ad0a3, Offset: 0x450
// Size: 0x2a
function function_99c38cca(slot) {
    return self flagsys::get("gadget_overdrive_on");
}

// Namespace gadget_overdrive/gadget_overdrive
// Params 1, eflags: 0x0
// Checksum 0x78fdd2d4, Offset: 0x488
// Size: 0xc
function function_fdada264(slot) {
    
}

// Namespace gadget_overdrive/gadget_overdrive
// Params 2, eflags: 0x0
// Checksum 0xa423f690, Offset: 0x4a0
// Size: 0x14
function function_8b256b93(slot, weapon) {
    
}

// Namespace gadget_overdrive/gadget_overdrive
// Params 2, eflags: 0x0
// Checksum 0x41aa542b, Offset: 0x4c0
// Size: 0x68
function function_6f36bade(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.overdrive)) {
        self [[ level.cybercom.overdrive.var_bdb47551 ]](slot, weapon);
    }
}

// Namespace gadget_overdrive/gadget_overdrive
// Params 2, eflags: 0x0
// Checksum 0x79a44c1, Offset: 0x530
// Size: 0x68
function function_96f861b0(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.overdrive)) {
        self [[ level.cybercom.overdrive.var_39ea6a1b ]](slot, weapon);
    }
}

// Namespace gadget_overdrive/gadget_overdrive
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x5a0
// Size: 0x4
function function_f40798b5() {
    
}

// Namespace gadget_overdrive/gadget_overdrive
// Params 2, eflags: 0x0
// Checksum 0x6e3ef138, Offset: 0x5b0
// Size: 0x84
function function_372c774a(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.overdrive)) {
        self thread [[ level.cybercom.overdrive._on ]](slot, weapon);
        self flagsys::set("gadget_overdrive_on");
    }
}

// Namespace gadget_overdrive/gadget_overdrive
// Params 2, eflags: 0x0
// Checksum 0x77761208, Offset: 0x640
// Size: 0x88
function function_a0a9dd0(slot, weapon) {
    self flagsys::clear("gadget_overdrive_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.overdrive)) {
        self thread [[ level.cybercom.overdrive._off ]](slot, weapon);
    }
}

