#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\system_shared;

#namespace namespace_8d132335;

// Namespace namespace_8d132335/namespace_8d132335
// Params 0, eflags: 0x6
// Checksum 0xcb48a675, Offset: 0xa8
// Size: 0x34
function private autoexec __init__system__() {
    system::register(#"hash_3bd9e2eea62b0bb1", undefined, undefined, &finalize, undefined);
}

// Namespace namespace_8d132335/namespace_8d132335
// Params 0, eflags: 0x1 linked
// Checksum 0xb30156c3, Offset: 0xe8
// Size: 0x5c
function finalize() {
    callback::on_game_playing(&on_game_playing);
    scene::add_scene_func(#"hash_56615f5479fe92c5", &function_e0632f11, "play");
}

// Namespace namespace_8d132335/namespace_8d132335
// Params 0, eflags: 0x1 linked
// Checksum 0xa6664f57, Offset: 0x150
// Size: 0xde
function on_game_playing() {
    level endon(#"game_ended");
    if (!getdvarint(#"hash_563c8d526f418928", 1) || getdvarstring(#"g_gametype") === "survival" || getdvarstring(#"g_gametype") === "zsurvival") {
        return;
    }
    wait 1;
    while (true) {
        level scene::play(#"hash_56615f5479fe92c5");
        wait 10;
    }
}

// Namespace namespace_8d132335/namespace_8d132335
// Params 1, eflags: 0x1 linked
// Checksum 0xf92c6f4a, Offset: 0x238
// Size: 0x34
function function_e0632f11(a_ents) {
    array::run_all(a_ents, &setmovingplatformenabled, 1, 0);
}

