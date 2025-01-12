#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/system_shared;

#namespace ability_gadgets;

// Namespace ability_gadgets/ability_gadgets
// Params 0, eflags: 0x2
// Checksum 0x9ad28ce2, Offset: 0x120
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("ability_gadgets", &__init__, undefined, undefined);
}

// Namespace ability_gadgets/ability_gadgets
// Params 0, eflags: 0x0
// Checksum 0x262de00d, Offset: 0x160
// Size: 0x44
function __init__() {
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
}

/#

    // Namespace ability_gadgets/ability_gadgets
    // Params 1, eflags: 0x0
    // Checksum 0xf7550912, Offset: 0x1b0
    // Size: 0x74
    function gadgets_print(str) {
        if (getdvarint("<dev string:x28>")) {
            toprint = str;
            println(self.playername + "<dev string:x3a>" + "<dev string:x3d>" + toprint);
        }
    }

#/

// Namespace ability_gadgets/ability_gadgets
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x230
// Size: 0x4
function on_player_connect() {
    
}

// Namespace ability_gadgets/ability_gadgets
// Params 2, eflags: 0x0
// Checksum 0x307443e5, Offset: 0x240
// Size: 0x44
function setflickering(slot, length) {
    if (!isdefined(length)) {
        length = 0;
    }
    self gadgetflickering(slot, 1, length);
}

// Namespace ability_gadgets/ability_gadgets
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x290
// Size: 0x4
function on_player_spawned() {
    
}

// Namespace ability_gadgets/gadget_give
// Params 1, eflags: 0x40
// Checksum 0xce96d407, Offset: 0x2a0
// Size: 0x84
function event_handler[gadget_give] gadget_give_callback(eventstruct) {
    /#
        eventstruct.entity gadgets_print("<dev string:x46>" + eventstruct.slot + "<dev string:x47>");
    #/
    eventstruct.entity ability_player::give_gadget(eventstruct.slot, eventstruct.weapon);
}

// Namespace ability_gadgets/gadget_take
// Params 1, eflags: 0x40
// Checksum 0x20a18f54, Offset: 0x330
// Size: 0x84
function event_handler[gadget_take] gadget_take_callback(eventstruct) {
    /#
        eventstruct.entity gadgets_print("<dev string:x46>" + eventstruct.slot + "<dev string:x51>");
    #/
    eventstruct.entity ability_player::take_gadget(eventstruct.slot, eventstruct.weapon);
}

// Namespace ability_gadgets/gadget_primed
// Params 1, eflags: 0x40
// Checksum 0xadb8bd08, Offset: 0x3c0
// Size: 0x84
function event_handler[gadget_primed] gadget_primed_callback(eventstruct) {
    /#
        eventstruct.entity gadgets_print("<dev string:x46>" + eventstruct.slot + "<dev string:x5b>");
    #/
    eventstruct.entity ability_player::gadget_primed(eventstruct.slot, eventstruct.weapon);
}

// Namespace ability_gadgets/gadget_ready
// Params 1, eflags: 0x40
// Checksum 0xc5454758, Offset: 0x450
// Size: 0x84
function event_handler[gadget_ready] gadget_ready_callback(eventstruct) {
    /#
        eventstruct.entity gadgets_print("<dev string:x46>" + eventstruct.slot + "<dev string:x67>");
    #/
    eventstruct.entity ability_player::gadget_ready(eventstruct.slot, eventstruct.weapon);
}

// Namespace ability_gadgets/gadget_on
// Params 1, eflags: 0x40
// Checksum 0x43dc5b8f, Offset: 0x4e0
// Size: 0x84
function event_handler[gadget_on] gadget_on_callback(eventstruct) {
    /#
        eventstruct.entity gadgets_print("<dev string:x46>" + eventstruct.slot + "<dev string:x72>");
    #/
    eventstruct.entity ability_player::turn_gadget_on(eventstruct.slot, eventstruct.weapon);
}

// Namespace ability_gadgets/gadget_off
// Params 1, eflags: 0x40
// Checksum 0xca0f1428, Offset: 0x570
// Size: 0x84
function event_handler[gadget_off] gadget_off_callback(eventstruct) {
    /#
        eventstruct.entity gadgets_print("<dev string:x46>" + eventstruct.slot + "<dev string:x7a>");
    #/
    eventstruct.entity ability_player::turn_gadget_off(eventstruct.slot, eventstruct.weapon);
}

// Namespace ability_gadgets/gadget_flicker
// Params 1, eflags: 0x40
// Checksum 0x6d055b39, Offset: 0x600
// Size: 0x84
function event_handler[gadget_flicker] gadget_flicker_callback(eventstruct) {
    /#
        eventstruct.entity gadgets_print("<dev string:x46>" + eventstruct.slot + "<dev string:x83>");
    #/
    eventstruct.entity ability_player::gadget_flicker(eventstruct.slot, eventstruct.weapon);
}

