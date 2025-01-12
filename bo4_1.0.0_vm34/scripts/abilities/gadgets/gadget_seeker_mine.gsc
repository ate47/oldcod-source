#using scripts\abilities\ability_player;
#using scripts\core_common\system_shared;

#namespace gadget_seeker_mine;

// Namespace gadget_seeker_mine/gadget_seeker_mine
// Params 0, eflags: 0x2
// Checksum 0x9422ad40, Offset: 0x78
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"gadget_seeker_mine", &__init__, undefined, undefined);
}

// Namespace gadget_seeker_mine/gadget_seeker_mine
// Params 0, eflags: 0x0
// Checksum 0xd8fcbd03, Offset: 0xc0
// Size: 0x44
function __init__() {
    ability_player::register_gadget_is_inuse_callbacks(28, &gadget_seeker_mine_is_inuse);
    ability_player::register_gadget_is_flickering_callbacks(28, &gadget_seeker_mine_is_flickering);
}

// Namespace gadget_seeker_mine/gadget_seeker_mine
// Params 1, eflags: 0x0
// Checksum 0x55d902cb, Offset: 0x110
// Size: 0x22
function gadget_seeker_mine_is_inuse(slot) {
    return self gadgetisactive(slot);
}

// Namespace gadget_seeker_mine/gadget_seeker_mine
// Params 1, eflags: 0x0
// Checksum 0xb8dd97f8, Offset: 0x140
// Size: 0x22
function gadget_seeker_mine_is_flickering(slot) {
    return self gadgetflickering(slot);
}

