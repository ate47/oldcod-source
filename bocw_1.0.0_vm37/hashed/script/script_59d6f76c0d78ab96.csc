#using script_13da4e6b98ca81a1;
#using script_544e81d6e48b88c0;
#using scripts\core_common\audio_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;

#namespace spectate_view;

// Namespace spectate_view/spectate_view
// Params 0, eflags: 0x6
// Checksum 0x737b943e, Offset: 0xc0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"spectate_view", &preinit, undefined, undefined, undefined);
}

// Namespace spectate_view/spectate_view
// Params 0, eflags: 0x4
// Checksum 0x6f142efe, Offset: 0x108
// Size: 0x54
function private preinit() {
    callback::add_callback(#"territory", &function_59941838);
    callback::function_a880899e(&function_a880899e);
}

// Namespace spectate_view/spectate_view
// Params 2, eflags: 0x4
// Checksum 0x22fefe9f, Offset: 0x168
// Size: 0x34
function private function_59941838(*local_client_num, *eventstruct) {
    namespace_99c84a33::function_bb3bbc2c("overhead_spectate_cam", 64);
}

// Namespace spectate_view/spectate_view
// Params 1, eflags: 0x0
// Checksum 0xb197e108, Offset: 0x1a8
// Size: 0x7c
function function_a880899e(eventparams) {
    localclientnum = eventparams.localclientnum;
    if (!codcaster::function_b8fe9b52(localclientnum)) {
        if (eventparams.enabled) {
            self codeplaypostfxbundle("pstfx_spawn_cam");
            return;
        }
        self codestoppostfxbundle("pstfx_spawn_cam");
    }
}

