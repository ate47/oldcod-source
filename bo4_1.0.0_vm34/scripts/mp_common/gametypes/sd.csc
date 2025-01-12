#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;

#namespace sd;

// Namespace sd/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x2660a8d3, Offset: 0xc0
// Size: 0x8c
function event_handler[gametype_init] main(eventstruct) {
    if (getgametypesetting(#"silentplant") != 0) {
        setsoundcontext("bomb_plant", "silent");
    }
    clientfield::register("worlduimodel", "hudItems.war.attackingTeam", 1, 2, "int", undefined, 0, 1);
}

