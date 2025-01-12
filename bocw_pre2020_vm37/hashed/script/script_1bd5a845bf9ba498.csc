#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;

#namespace namespace_14c21b91;

// Namespace namespace_14c21b91/namespace_14c21b91
// Params 0, eflags: 0x6
// Checksum 0xb4342b8f, Offset: 0x70
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_e77f876300a38be", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_14c21b91/namespace_14c21b91
// Params 0, eflags: 0x5 linked
// Checksum 0xd7bbc3ed, Offset: 0xb8
// Size: 0x24
function private function_70a657d8() {
    callback::on_end_game(&on_end_game);
}

// Namespace namespace_14c21b91/gametype_start
// Params 1, eflags: 0x40
// Checksum 0x9250b458, Offset: 0xe8
// Size: 0x4c
function event_handler[gametype_start] codecallback_startgametype(*eventstruct) {
    if (sessionmodeismultiplayergame() && function_8f29c880()) {
        function_3ae87223();
    }
}

// Namespace namespace_14c21b91/namespace_14c21b91
// Params 1, eflags: 0x1 linked
// Checksum 0xc63a7d8c, Offset: 0x140
// Size: 0x4c
function on_end_game(*localclientnum) {
    if (sessionmodeismultiplayergame() && function_8f29c880()) {
        function_8871747f();
    }
}

