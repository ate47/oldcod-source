#using scripts\abilities\ability_player;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;

#namespace ability_gadgets;

// Namespace ability_gadgets/ability_gadgets
// Params 0, eflags: 0x2
// Checksum 0x4c1f2ed7, Offset: 0x150
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"ability_gadgets", &__init__, undefined, undefined);
}

// Namespace ability_gadgets/ability_gadgets
// Params 0, eflags: 0x0
// Checksum 0x4fc799c0, Offset: 0x198
// Size: 0xd4
function __init__() {
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
    clientfield::register("clientuimodel", "huditems.abilityHoldToActivate", 1, 2, "int");
    clientfield::register("clientuimodel", "huditems.abilityDelayProgress", 1, 5, "float");
    clientfield::register("clientuimodel", "hudItems.abilityHintIndex", 1, 2, "int");
}

/#

    // Namespace ability_gadgets/ability_gadgets
    // Params 1, eflags: 0x0
    // Checksum 0xcea45c03, Offset: 0x278
    // Size: 0x74
    function gadgets_print(str) {
        if (getdvarint(#"scr_debug_gadgets", 0)) {
            toprint = str;
            println(self.playername + "<dev string:x30>" + "<dev string:x33>" + toprint);
        }
    }

#/

// Namespace ability_gadgets/ability_gadgets
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x2f8
// Size: 0x4
function on_player_connect() {
    
}

// Namespace ability_gadgets/ability_gadgets
// Params 2, eflags: 0x0
// Checksum 0x82d6b458, Offset: 0x308
// Size: 0x44
function setflickering(slot, length = 0) {
    self gadgetflickering(slot, 1, length);
}

// Namespace ability_gadgets/ability_gadgets
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x358
// Size: 0x4
function on_player_spawned() {
    
}

// Namespace ability_gadgets/gadget_give
// Params 1, eflags: 0x40
// Checksum 0xa0a7850a, Offset: 0x368
// Size: 0x7c
function event_handler[gadget_give] gadget_give_callback(eventstruct) {
    /#
        eventstruct.entity gadgets_print("<dev string:x3c>" + eventstruct.slot + "<dev string:x3d>");
    #/
    eventstruct.entity ability_player::give_gadget(eventstruct.slot, eventstruct.weapon);
}

// Namespace ability_gadgets/gadget_take
// Params 1, eflags: 0x40
// Checksum 0xbd987d9c, Offset: 0x3f0
// Size: 0x7c
function event_handler[gadget_take] gadget_take_callback(eventstruct) {
    /#
        eventstruct.entity gadgets_print("<dev string:x3c>" + eventstruct.slot + "<dev string:x47>");
    #/
    eventstruct.entity ability_player::take_gadget(eventstruct.slot, eventstruct.weapon);
}

// Namespace ability_gadgets/gadget_primed
// Params 1, eflags: 0x40
// Checksum 0x1a223103, Offset: 0x478
// Size: 0x7c
function event_handler[gadget_primed] gadget_primed_callback(eventstruct) {
    /#
        eventstruct.entity gadgets_print("<dev string:x3c>" + eventstruct.slot + "<dev string:x51>");
    #/
    eventstruct.entity ability_player::gadget_primed(eventstruct.slot, eventstruct.weapon);
}

// Namespace ability_gadgets/gadget_ready
// Params 1, eflags: 0x40
// Checksum 0x160b6774, Offset: 0x500
// Size: 0xec
function event_handler[gadget_ready] gadget_ready_callback(eventstruct) {
    /#
        eventstruct.entity gadgets_print("<dev string:x3c>" + eventstruct.slot + "<dev string:x5d>");
    #/
    if (level flag::get("all_players_spawned")) {
        params = {#slot:eventstruct.slot};
        voiceevent("specialist_equipment_ready", eventstruct.entity, params);
    }
    eventstruct.entity ability_player::gadget_ready(eventstruct.slot, eventstruct.weapon);
}

// Namespace ability_gadgets/gadget_on
// Params 1, eflags: 0x40
// Checksum 0x4f98344, Offset: 0x5f8
// Size: 0xec
function event_handler[gadget_on] gadget_on_callback(eventstruct) {
    /#
        eventstruct.entity gadgets_print("<dev string:x3c>" + eventstruct.slot + "<dev string:x68>");
    #/
    if (level flag::get("all_players_spawned")) {
        params = {#slot:eventstruct.slot};
        voiceevent("specialist_equipment_using", eventstruct.entity, params);
    }
    eventstruct.entity ability_player::turn_gadget_on(eventstruct.slot, eventstruct.weapon);
}

// Namespace ability_gadgets/gadget_off
// Params 1, eflags: 0x40
// Checksum 0xf0852e8f, Offset: 0x6f0
// Size: 0x7c
function event_handler[gadget_off] gadget_off_callback(eventstruct) {
    /#
        eventstruct.entity gadgets_print("<dev string:x3c>" + eventstruct.slot + "<dev string:x70>");
    #/
    eventstruct.entity ability_player::turn_gadget_off(eventstruct.slot, eventstruct.weapon);
}

// Namespace ability_gadgets/event_9316236
// Params 1, eflags: 0x40
// Checksum 0x2ffe53bb, Offset: 0x778
// Size: 0x7c
function event_handler[event_9316236] function_f19aff10(eventstruct) {
    /#
        eventstruct.entity gadgets_print("<dev string:x3c>" + eventstruct.slot + "<dev string:x79>");
    #/
    eventstruct.entity ability_player::function_eec487e0(eventstruct.slot, eventstruct.weapon);
}

// Namespace ability_gadgets/event_31a8dd0c
// Params 1, eflags: 0x40
// Checksum 0xecee5a18, Offset: 0x800
// Size: 0x7c
function event_handler[event_31a8dd0c] function_57b5bc86(eventstruct) {
    /#
        eventstruct.entity gadgets_print("<dev string:x3c>" + eventstruct.slot + "<dev string:x8a>");
    #/
    eventstruct.entity ability_player::function_5af5ab8e(eventstruct.slot, eventstruct.weapon);
}

// Namespace ability_gadgets/gadget_flicker
// Params 1, eflags: 0x40
// Checksum 0xe69cda57, Offset: 0x888
// Size: 0x7c
function event_handler[gadget_flicker] gadget_flicker_callback(eventstruct) {
    /#
        eventstruct.entity gadgets_print("<dev string:x3c>" + eventstruct.slot + "<dev string:x9c>");
    #/
    eventstruct.entity ability_player::gadget_flicker(eventstruct.slot, eventstruct.weapon);
}

