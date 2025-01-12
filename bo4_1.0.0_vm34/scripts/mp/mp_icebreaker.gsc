#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\compass;
#using scripts\mp_common\load;

#namespace mp_icebreaker;

// Namespace mp_icebreaker/level_init
// Params 1, eflags: 0x40
// Checksum 0x6db8e7e7, Offset: 0xa0
// Size: 0x54
function event_handler[level_init] main(eventstruct) {
    callback::on_game_playing(&on_game_playing);
    load::main();
    compass::setupminimap("");
}

// Namespace mp_icebreaker/mp_icebreaker
// Params 0, eflags: 0x0
// Checksum 0x7ad4db63, Offset: 0x100
// Size: 0x34
function on_game_playing() {
    array::delete_all(getentarray("sun_block", "targetname"));
}

