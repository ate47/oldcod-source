#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\compass;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\util_shared;
#using scripts\mp\mp_seaside_fx;
#using scripts\mp\mp_seaside_sound;
#using scripts\mp_common\gametypes\globallogic_spawn;
#using scripts\mp_common\load;

#namespace mp_seaside;

// Namespace mp_seaside/level_init
// Params 1, eflags: 0x40
// Checksum 0xf21b64b9, Offset: 0xf8
// Size: 0x1cc
function event_handler[level_init] main(eventstruct) {
    precache();
    callback::on_game_playing(&on_game_playing);
    globallogic_spawn::function_4410852b((-266.03, 2540.2, 968.125), (0, 289.248, 0), "allies", "tdm");
    globallogic_spawn::function_4410852b((245.178, -4559.91, 560.443), (0, 105.606, 0), "axis", "tdm");
    globallogic_spawn::function_4410852b((-266.03, 2540.2, 968.125), (0, 289.248, 0), "allies", "conf");
    globallogic_spawn::function_4410852b((245.178, -4559.91, 560.443), (0, 105.606, 0), "axis", "conf");
    mp_seaside_fx::main();
    mp_seaside_sound::main();
    /#
        init_devgui();
    #/
    load::main();
    compass::setupminimap("");
    function_a272d512();
}

// Namespace mp_seaside/mp_seaside
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x2d0
// Size: 0x4
function precache() {
    
}

// Namespace mp_seaside/mp_seaside
// Params 0, eflags: 0x0
// Checksum 0xfaee942c, Offset: 0x2e0
// Size: 0xec
function on_game_playing() {
    array::delete_all(getentarray("sun_block", "targetname"));
    level flag::wait_till("first_player_spawned");
    wait getdvarfloat(#"hash_205d729c5c415715", 0);
    if (util::isfirstround()) {
        level thread scene::play(#"p8_fxanim_mp_seaside_pigeon_flock_bundle");
        if (getdvarint(#"hash_1ee1f013d124a26a", 0)) {
            level thread scene::play(#"p8_fxanim_mp_seaside_tanks_bundle");
        }
    }
}

// Namespace mp_seaside/mp_seaside
// Params 0, eflags: 0x0
// Checksum 0x9743f03b, Offset: 0x3d8
// Size: 0xe4
function function_a272d512() {
    if (util::isfirstround()) {
        level scene::init(#"p8_fxanim_mp_seaside_pigeon_flock_bundle");
        if (getdvarint(#"hash_1ee1f013d124a26a", 0)) {
            level scene::init(#"p8_fxanim_mp_seaside_tanks_bundle");
        }
        return;
    }
    level scene::skipto_end(#"p8_fxanim_mp_seaside_pigeon_flock_bundle", undefined, undefined, 1);
    if (getdvarint(#"hash_1ee1f013d124a26a", 0)) {
        level scene::skipto_end(#"p8_fxanim_mp_seaside_tanks_bundle", undefined, undefined, 1);
    }
}

/#

    // Namespace mp_seaside/mp_seaside
    // Params 0, eflags: 0x0
    // Checksum 0x8a35d6e1, Offset: 0x4c8
    // Size: 0x74
    function init_devgui() {
        mapname = util::get_map_name();
        adddebugcommand("<dev string:x30>" + mapname + "<dev string:x3e>");
        adddebugcommand("<dev string:x30>" + mapname + "<dev string:x7d>");
    }

#/
