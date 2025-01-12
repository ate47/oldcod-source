#using script_13da4e6b98ca81a1;
#using script_544e81d6e48b88c0;
#using scripts\core_common\audio_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;

#namespace namespace_8a203916;

// Namespace namespace_8a203916/namespace_8a203916
// Params 0, eflags: 0x6
// Checksum 0x79ff5e75, Offset: 0xe0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_62a9656d2aaa46aa", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_8a203916/namespace_8a203916
// Params 0, eflags: 0x5 linked
// Checksum 0x6d9c03d4, Offset: 0x128
// Size: 0x54
function private function_70a657d8() {
    callback::add_callback(#"territory", &function_59941838);
    callback::function_a880899e(&function_a880899e);
}

// Namespace namespace_8a203916/namespace_8a203916
// Params 2, eflags: 0x5 linked
// Checksum 0x604dbbad, Offset: 0x188
// Size: 0x34
function private function_59941838(*local_client_num, *eventstruct) {
    namespace_99c84a33::function_bb3bbc2c("overhead_spectate_cam", 64);
}

// Namespace namespace_8a203916/namespace_8a203916
// Params 1, eflags: 0x1 linked
// Checksum 0x2920e033, Offset: 0x1c8
// Size: 0xbc
function function_a880899e(eventparams) {
    localclientnum = eventparams.localclientnum;
    if (!codcaster::function_b8fe9b52(localclientnum)) {
        if (eventparams.enabled) {
            self codeplaypostfxbundle("pstfx_spawn_cam");
            audio::playloopat("uin_overhead_map_background_loop", (0, 0, 0));
            return;
        }
        self codestoppostfxbundle("pstfx_spawn_cam");
        audio::stoploopat("uin_overhead_map_background_loop", (0, 0, 0));
    }
}

