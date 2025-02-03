#using script_67ce8e728d8f37ba;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\compass;
#using scripts\core_common\load_shared;
#using scripts\core_common\scene_shared;
#using scripts\killstreaks\killstreaks_shared;

#namespace mp_satellite;

// Namespace mp_satellite/level_init
// Params 1, eflags: 0x40
// Checksum 0x1f6bb13f, Offset: 0xf0
// Size: 0x10c
function event_handler[level_init] main(*eventstruct) {
    namespace_66d6aa44::function_3f3466c9();
    callback::on_game_playing(&on_game_playing);
    callback::on_end_game(&on_end_game);
    killstreaks::function_257a5f13("straferun", 40);
    killstreaks::function_257a5f13("helicopter_comlink", 75);
    load::main();
    scene::add_scene_func(#"hash_4ac8864d2a236932", &function_29776f58);
    level thread function_8be0ab76();
    compass::setupminimap("");
}

// Namespace mp_satellite/mp_satellite
// Params 1, eflags: 0x0
// Checksum 0xb0cf4df, Offset: 0x208
// Size: 0x84
function function_29776f58(a_ents) {
    parachute = a_ents[#"prop 1"];
    clip = getent("parachute_clip", "targetname");
    if (isdefined(clip) && isdefined(parachute)) {
        clip linkto(parachute, "tag_clip");
    }
}

// Namespace mp_satellite/mp_satellite
// Params 0, eflags: 0x0
// Checksum 0x2cca97fb, Offset: 0x298
// Size: 0xcc
function on_game_playing() {
    if (!isdefined(level.var_df9213cd)) {
        level.var_df9213cd = [];
    }
    foreach (ent in level.var_df9213cd) {
        ent show();
    }
    level thread scene::play(#"hash_1e1ac7b63df20511");
}

// Namespace mp_satellite/mp_satellite
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x370
// Size: 0x4
function on_end_game() {
    
}

// Namespace mp_satellite/mp_satellite
// Params 0, eflags: 0x0
// Checksum 0x68423aa5, Offset: 0x380
// Size: 0x3c
function function_8be0ab76() {
    level thread scene::add_scene_func(#"hash_1e1ac7b63df20511", &function_b467087, "init");
}

// Namespace mp_satellite/mp_satellite
// Params 1, eflags: 0x0
// Checksum 0x76bdc72d, Offset: 0x3c8
// Size: 0xc0
function function_b467087(a_ents) {
    if (!is_true(level.inprematchperiod)) {
        return;
    }
    level.var_df9213cd = a_ents;
    foreach (ent in level.var_df9213cd) {
        ent hide();
    }
}

