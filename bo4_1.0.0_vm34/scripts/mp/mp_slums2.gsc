#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\compass;
#using scripts\core_common\scene_shared;
#using scripts\core_common\util_shared;
#using scripts\mp\mp_slums2_fx;
#using scripts\mp\mp_slums2_sound;
#using scripts\mp_common\load;

#namespace mp_slums2;

// Namespace mp_slums2/level_init
// Params 1, eflags: 0x40
// Checksum 0xc7c1fa9f, Offset: 0xc0
// Size: 0x74
function event_handler[level_init] main(eventstruct) {
    callback::on_game_playing(&on_game_playing);
    mp_slums2_fx::main();
    mp_slums2_sound::main();
    load::main();
    compass::setupminimap("");
}

// Namespace mp_slums2/mp_slums2
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x140
// Size: 0x4
function precache() {
    
}

// Namespace mp_slums2/mp_slums2
// Params 0, eflags: 0x0
// Checksum 0xf15806f9, Offset: 0x150
// Size: 0x34
function on_game_playing() {
    array::delete_all(getentarray("sun_block", "targetname"));
}

