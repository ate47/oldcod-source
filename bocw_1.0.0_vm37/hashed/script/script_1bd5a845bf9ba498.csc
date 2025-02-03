#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;

#namespace namespace_14c21b91;

// Namespace namespace_14c21b91/namespace_14c21b91
// Params 0, eflags: 0x6
// Checksum 0x7d0cc141, Offset: 0x70
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_e77f876300a38be", &preinit, undefined, undefined, undefined);
}

// Namespace namespace_14c21b91/namespace_14c21b91
// Params 0, eflags: 0x4
// Checksum 0xbeb0fa56, Offset: 0xb8
// Size: 0x24
function private preinit() {
    callback::on_end_game(&on_end_game);
}

// Namespace namespace_14c21b91/gametype_start
// Params 1, eflags: 0x40
// Checksum 0xcc69af3b, Offset: 0xe8
// Size: 0x4c
function event_handler[gametype_start] codecallback_startgametype(*eventstruct) {
    if (sessionmodeismultiplayergame() && function_8f29c880()) {
        function_3ae87223();
    }
}

// Namespace namespace_14c21b91/namespace_14c21b91
// Params 1, eflags: 0x0
// Checksum 0x42afe8f7, Offset: 0x140
// Size: 0x4c
function on_end_game(*localclientnum) {
    if (sessionmodeismultiplayergame() && function_8f29c880()) {
        function_8871747f();
    }
}

