#using scripts\abilities\ability_player;
#using scripts\core_common\system_shared;

#namespace gadget_other;

// Namespace gadget_other/gadget_other
// Params 0, eflags: 0x6
// Checksum 0x35fe6930, Offset: 0x70
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"gadget_other", &preinit, undefined, undefined, undefined);
}

// Namespace gadget_other/gadget_other
// Params 0, eflags: 0x4
// Checksum 0xcddabece, Offset: 0xb8
// Size: 0x44
function private preinit() {
    ability_player::register_gadget_is_inuse_callbacks(1, &gadget_other_is_inuse);
    ability_player::register_gadget_is_flickering_callbacks(1, &gadget_other_is_flickering);
}

// Namespace gadget_other/gadget_other
// Params 1, eflags: 0x0
// Checksum 0xde9e7835, Offset: 0x108
// Size: 0x22
function gadget_other_is_inuse(slot) {
    return self gadgetisactive(slot);
}

// Namespace gadget_other/gadget_other
// Params 1, eflags: 0x0
// Checksum 0xa89c8aba, Offset: 0x138
// Size: 0x22
function gadget_other_is_flickering(slot) {
    return self gadgetflickering(slot);
}

/#

    // Namespace gadget_other/gadget_other
    // Params 3, eflags: 0x0
    // Checksum 0x690ad94c, Offset: 0x168
    // Size: 0xbc
    function set_gadget_other_status(weapon, status, time) {
        timestr = "<dev string:x38>";
        if (isdefined(time)) {
            timestr = "<dev string:x3c>" + "<dev string:x42>" + time;
        }
        if (getdvarint(#"scr_cpower_debug_prints", 0) > 0) {
            self iprintlnbold("<dev string:x4e>" + weapon.name + "<dev string:x5f>" + status + timestr);
        }
    }

#/
