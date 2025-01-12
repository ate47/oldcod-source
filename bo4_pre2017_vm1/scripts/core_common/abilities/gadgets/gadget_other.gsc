#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/visionset_mgr_shared;

#namespace gadget_other;

// Namespace gadget_other/gadget_other
// Params 0, eflags: 0x2
// Checksum 0xb5346325, Offset: 0x248
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_other", &__init__, undefined, undefined);
}

// Namespace gadget_other/gadget_other
// Params 0, eflags: 0x0
// Checksum 0x6422909c, Offset: 0x288
// Size: 0xe4
function __init__() {
    ability_player::register_gadget_activation_callbacks(1, &function_73509156, &function_af4d837c);
    ability_player::register_gadget_possession_callbacks(1, &function_1efe9912, &function_4371972c);
    ability_player::register_gadget_flicker_callbacks(1, &function_2376cc6f);
    ability_player::register_gadget_is_inuse_callbacks(1, &gadget_other_is_inuse);
    ability_player::register_gadget_is_flickering_callbacks(1, &gadget_other_is_flickering);
    ability_player::register_gadget_ready_callbacks(1, &function_af938542);
}

// Namespace gadget_other/gadget_other
// Params 1, eflags: 0x0
// Checksum 0x7816ae00, Offset: 0x378
// Size: 0x22
function gadget_other_is_inuse(slot) {
    return self gadgetisactive(slot);
}

// Namespace gadget_other/gadget_other
// Params 1, eflags: 0x0
// Checksum 0x6e8302a7, Offset: 0x3a8
// Size: 0x22
function gadget_other_is_flickering(slot) {
    return self gadgetflickering(slot);
}

// Namespace gadget_other/gadget_other
// Params 2, eflags: 0x0
// Checksum 0x32607122, Offset: 0x3d8
// Size: 0x14
function function_2376cc6f(slot, weapon) {
    
}

// Namespace gadget_other/gadget_other
// Params 2, eflags: 0x0
// Checksum 0x8436570b, Offset: 0x3f8
// Size: 0x14
function function_1efe9912(slot, weapon) {
    
}

// Namespace gadget_other/gadget_other
// Params 2, eflags: 0x0
// Checksum 0x30e73566, Offset: 0x418
// Size: 0x14
function function_4371972c(slot, weapon) {
    
}

// Namespace gadget_other/gadget_other
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x438
// Size: 0x4
function function_327b4d11() {
    
}

// Namespace gadget_other/gadget_other
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x448
// Size: 0x4
function function_3a9413e6() {
    
}

// Namespace gadget_other/gadget_other
// Params 2, eflags: 0x0
// Checksum 0x836d6219, Offset: 0x458
// Size: 0x14
function function_73509156(slot, weapon) {
    
}

// Namespace gadget_other/gadget_other
// Params 2, eflags: 0x0
// Checksum 0xbc7d201b, Offset: 0x478
// Size: 0x14
function function_af4d837c(slot, weapon) {
    
}

// Namespace gadget_other/gadget_other
// Params 2, eflags: 0x0
// Checksum 0x78dee38a, Offset: 0x498
// Size: 0x14
function function_af938542(slot, weapon) {
    
}

// Namespace gadget_other/gadget_other
// Params 3, eflags: 0x0
// Checksum 0xcc9f8e4d, Offset: 0x4b8
// Size: 0xb4
function set_gadget_other_status(weapon, status, time) {
    timestr = "";
    if (isdefined(time)) {
        timestr = "^3" + ", time: " + time;
    }
    if (getdvarint("scr_cpower_debug_prints") > 0) {
        self iprintlnbold("Gadget Other " + weapon.name + ": " + status + timestr);
    }
}

