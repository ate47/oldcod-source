#using scripts\abilities\ability_player;
#using scripts\core_common\system_shared;

#namespace gadget_other;

// Namespace gadget_other/gadget_other
// Params 0, eflags: 0x2
// Checksum 0x98a837df, Offset: 0x78
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"gadget_other", &__init__, undefined, undefined);
}

// Namespace gadget_other/gadget_other
// Params 0, eflags: 0x0
// Checksum 0x5f89ea45, Offset: 0xc0
// Size: 0x44
function __init__() {
    ability_player::register_gadget_is_inuse_callbacks(1, &gadget_other_is_inuse);
    ability_player::register_gadget_is_flickering_callbacks(1, &gadget_other_is_flickering);
}

// Namespace gadget_other/gadget_other
// Params 1, eflags: 0x0
// Checksum 0x1b00c99c, Offset: 0x110
// Size: 0x22
function gadget_other_is_inuse(slot) {
    return self gadgetisactive(slot);
}

// Namespace gadget_other/gadget_other
// Params 1, eflags: 0x0
// Checksum 0x379073cc, Offset: 0x140
// Size: 0x22
function gadget_other_is_flickering(slot) {
    return self gadgetflickering(slot);
}

/#

    // Namespace gadget_other/gadget_other
    // Params 3, eflags: 0x0
    // Checksum 0xbe4befd9, Offset: 0x170
    // Size: 0xbc
    function set_gadget_other_status(weapon, status, time) {
        timestr = "<dev string:x30>";
        if (isdefined(time)) {
            timestr = "<dev string:x31>" + "<dev string:x34>" + time;
        }
        if (getdvarint(#"scr_cpower_debug_prints", 0) > 0) {
            self iprintlnbold("<dev string:x3d>" + weapon.name + "<dev string:x4b>" + status + timestr);
        }
    }

#/
