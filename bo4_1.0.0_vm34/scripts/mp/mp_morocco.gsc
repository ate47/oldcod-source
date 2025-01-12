#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\compass;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\util_shared;
#using scripts\mp\mp_morocco_fx;
#using scripts\mp\mp_morocco_sound;
#using scripts\mp_common\gametypes\globallogic_spawn;
#using scripts\mp_common\load;

#namespace mp_morocco;

// Namespace mp_morocco/level_init
// Params 1, eflags: 0x40
// Checksum 0xe3e4753a, Offset: 0xd0
// Size: 0x54
function event_handler[level_init] main(eventstruct) {
    callback::on_game_playing(&on_game_playing);
    load::main();
    compass::setupminimap("");
}

// Namespace mp_morocco/mp_morocco
// Params 0, eflags: 0x0
// Checksum 0xd1bccbcc, Offset: 0x130
// Size: 0x34
function on_game_playing() {
    array::delete_all(getentarray("sun_block", "targetname"));
}

