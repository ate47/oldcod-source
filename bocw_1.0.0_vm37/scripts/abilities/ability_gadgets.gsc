#using scripts\abilities\ability_player;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;

#namespace ability_gadgets;

// Namespace ability_gadgets/ability_gadgets
// Params 0, eflags: 0x6
// Checksum 0xf0cadbf2, Offset: 0xe0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"ability_gadgets", &preinit, undefined, undefined, undefined);
}

// Namespace ability_gadgets/ability_gadgets
// Params 0, eflags: 0x4
// Checksum 0x7d718999, Offset: 0x128
// Size: 0x94
function private preinit() {
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
    clientfield::register_clientuimodel("huditems.abilityHoldToActivate", 1, 2, "int");
    clientfield::register_clientuimodel("huditems.abilityDelayProgress", 1, 5, "float");
}

/#

    // Namespace ability_gadgets/ability_gadgets
    // Params 1, eflags: 0x0
    // Checksum 0x88a46cf1, Offset: 0x1c8
    // Size: 0x74
    function gadgets_print(str) {
        if (getdvarint(#"scr_debug_gadgets", 0)) {
            toprint = str;
            println(self.playername + "<dev string:x38>" + "<dev string:x3e>" + toprint);
        }
    }

#/

// Namespace ability_gadgets/ability_gadgets
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x248
// Size: 0x4
function on_player_connect() {
    
}

// Namespace ability_gadgets/ability_gadgets
// Params 2, eflags: 0x0
// Checksum 0x5ea90909, Offset: 0x258
// Size: 0x44
function setflickering(slot, length = 0) {
    self gadgetflickering(slot, 1, length);
}

// Namespace ability_gadgets/ability_gadgets
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x2a8
// Size: 0x4
function on_player_spawned() {
    
}

// Namespace ability_gadgets/gadget_give
// Params 1, eflags: 0x40
// Checksum 0x494e9c21, Offset: 0x2b8
// Size: 0x6c
function event_handler[gadget_give] gadget_give_callback(eventstruct) {
    /#
        eventstruct.entity gadgets_print("<dev string:x4a>" + eventstruct.slot + "<dev string:x4e>");
    #/
    eventstruct.entity ability_player::give_gadget(eventstruct.slot, eventstruct.weapon);
}

// Namespace ability_gadgets/gadget_take
// Params 1, eflags: 0x40
// Checksum 0xa78f742, Offset: 0x330
// Size: 0x6c
function event_handler[gadget_take] gadget_take_callback(eventstruct) {
    /#
        eventstruct.entity gadgets_print("<dev string:x4a>" + eventstruct.slot + "<dev string:x5b>");
    #/
    eventstruct.entity ability_player::take_gadget(eventstruct.slot, eventstruct.weapon);
}

// Namespace ability_gadgets/gadget_primed
// Params 1, eflags: 0x40
// Checksum 0xe30d62e7, Offset: 0x3a8
// Size: 0x6c
function event_handler[gadget_primed] gadget_primed_callback(eventstruct) {
    /#
        eventstruct.entity gadgets_print("<dev string:x4a>" + eventstruct.slot + "<dev string:x68>");
    #/
    eventstruct.entity ability_player::gadget_primed(eventstruct.slot, eventstruct.weapon);
}

// Namespace ability_gadgets/gadget_ready
// Params 1, eflags: 0x40
// Checksum 0x99d64167, Offset: 0x420
// Size: 0x6c
function event_handler[gadget_ready] gadget_ready_callback(eventstruct) {
    /#
        eventstruct.entity gadgets_print("<dev string:x4a>" + eventstruct.slot + "<dev string:x77>");
    #/
    eventstruct.entity ability_player::gadget_ready(eventstruct.slot, eventstruct.weapon);
}

// Namespace ability_gadgets/gadget_on
// Params 1, eflags: 0x40
// Checksum 0xd07ad786, Offset: 0x498
// Size: 0x6c
function event_handler[gadget_on] gadget_on_callback(eventstruct) {
    /#
        eventstruct.entity gadgets_print("<dev string:x4a>" + eventstruct.slot + "<dev string:x85>");
    #/
    eventstruct.entity ability_player::turn_gadget_on(eventstruct.slot, eventstruct.weapon);
}

// Namespace ability_gadgets/gadget_off
// Params 1, eflags: 0x40
// Checksum 0x3780c343, Offset: 0x510
// Size: 0x6c
function event_handler[gadget_off] gadget_off_callback(eventstruct) {
    /#
        eventstruct.entity gadgets_print("<dev string:x4a>" + eventstruct.slot + "<dev string:x90>");
    #/
    eventstruct.entity ability_player::turn_gadget_off(eventstruct.slot, eventstruct.weapon);
}

// Namespace ability_gadgets/event_dfabd488
// Params 1, eflags: 0x40
// Checksum 0xad558e3e, Offset: 0x588
// Size: 0x6c
function event_handler[event_dfabd488] function_40d8d1ec(eventstruct) {
    /#
        eventstruct.entity gadgets_print("<dev string:x4a>" + eventstruct.slot + "<dev string:x9c>");
    #/
    eventstruct.entity ability_player::function_50557027(eventstruct.slot, eventstruct.weapon);
}

// Namespace ability_gadgets/event_e46d75fa
// Params 1, eflags: 0x40
// Checksum 0x7833a331, Offset: 0x600
// Size: 0x6c
function event_handler[event_e46d75fa] function_15061ae6(eventstruct) {
    /#
        eventstruct.entity gadgets_print("<dev string:x4a>" + eventstruct.slot + "<dev string:xb0>");
    #/
    eventstruct.entity ability_player::function_d5260ebe(eventstruct.slot, eventstruct.weapon);
}

// Namespace ability_gadgets/gadget_flicker
// Params 1, eflags: 0x40
// Checksum 0x2261c0a7, Offset: 0x678
// Size: 0x6c
function event_handler[gadget_flicker] gadget_flicker_callback(eventstruct) {
    /#
        eventstruct.entity gadgets_print("<dev string:x4a>" + eventstruct.slot + "<dev string:xc5>");
    #/
    eventstruct.entity ability_player::gadget_flicker(eventstruct.slot, eventstruct.weapon);
}

