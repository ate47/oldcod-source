#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\compass;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\mp\mp_militia_fx;
#using scripts\mp\mp_militia_sound;
#using scripts\mp_common\load;
#using scripts\mp_common\util;

#namespace mp_militia;

// Namespace mp_militia/level_init
// Params 1, eflags: 0x40
// Checksum 0x56b38286, Offset: 0xc8
// Size: 0x74
function event_handler[level_init] main(eventstruct) {
    callback::on_game_playing(&on_game_playing);
    mp_militia_fx::main();
    mp_militia_sound::main();
    load::main();
    compass::setupminimap("");
}

// Namespace mp_militia/mp_militia
// Params 0, eflags: 0x0
// Checksum 0x680267ad, Offset: 0x148
// Size: 0x34
function on_game_playing() {
    array::delete_all(getentarray("sun_block", "targetname"));
}

