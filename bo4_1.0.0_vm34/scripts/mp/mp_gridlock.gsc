#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\compass;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\util_shared;
#using scripts\mp\mp_gridlock_fx;
#using scripts\mp\mp_gridlock_sound;
#using scripts\mp_common\gametypes\globallogic_spawn;
#using scripts\mp_common\load;

#namespace mp_gridlock;

// Namespace mp_gridlock/level_init
// Params 1, eflags: 0x40
// Checksum 0x30ba099c, Offset: 0xf8
// Size: 0x1a4
function event_handler[level_init] main(eventstruct) {
    callback::on_game_playing(&on_game_playing);
    globallogic_spawn::function_4410852b((-2453.83, -38.9564, 0.125), (0, 10.9204, 0), "allies", "tdm");
    globallogic_spawn::function_4410852b((3247.04, -923.406, 0.125), (0, 174.957, 0), "axis", "tdm");
    globallogic_spawn::function_4410852b((-2453.83, -38.9564, 0.125), (0, 10.9204, 0), "allies", "conf");
    globallogic_spawn::function_4410852b((3247.04, -923.406, 0.125), (0, 174.957, 0), "axis", "conf");
    mp_gridlock_fx::main();
    mp_gridlock_sound::main();
    load::main();
    compass::setupminimap("");
    function_a272d512();
}

// Namespace mp_gridlock/mp_gridlock
// Params 0, eflags: 0x0
// Checksum 0x8f76fa09, Offset: 0x2a8
// Size: 0x84
function on_game_playing() {
    array::delete_all(getentarray("sun_block", "targetname"));
    wait getdvarfloat(#"hash_205d729c5c415715", 0.3);
    if (util::isfirstround()) {
        exploder::exploder("fxexp_tanker_explosion");
    }
}

// Namespace mp_gridlock/mp_gridlock
// Params 0, eflags: 0x0
// Checksum 0x8e722d73, Offset: 0x338
// Size: 0x2c
function function_a272d512() {
    if (!util::isfirstround()) {
        exploder::exploder("fxexp_tanker_explosion");
    }
}

/#

    // Namespace mp_gridlock/mp_gridlock
    // Params 0, eflags: 0x0
    // Checksum 0xf057bf7f, Offset: 0x370
    // Size: 0x74
    function init_devgui() {
        mapname = util::get_map_name();
        adddebugcommand("<dev string:x30>" + mapname + "<dev string:x3e>");
        adddebugcommand("<dev string:x30>" + mapname + "<dev string:x7d>");
    }

#/
