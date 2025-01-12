#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace zm_demo;

// Namespace zm_demo/zm_demo
// Params 0, eflags: 0x6
// Checksum 0x71a13d9a, Offset: 0xc8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_demo", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_demo/zm_demo
// Params 0, eflags: 0x5 linked
// Checksum 0x91db4506, Offset: 0x110
// Size: 0x54
function private function_70a657d8() {
    if (isdemoplaying()) {
        if (!isdefined(level.demolocalclients)) {
            level.demolocalclients = [];
        }
        callback::on_localclient_connect(&player_on_connect);
    }
}

// Namespace zm_demo/zm_demo
// Params 1, eflags: 0x1 linked
// Checksum 0x47837c42, Offset: 0x170
// Size: 0x24
function player_on_connect(localclientnum) {
    level thread watch_predicted_player_changes(localclientnum);
}

// Namespace zm_demo/zm_demo
// Params 1, eflags: 0x1 linked
// Checksum 0x3de21075, Offset: 0x1a0
// Size: 0x278
function watch_predicted_player_changes(localclientnum) {
    level.demolocalclients[localclientnum] = spawnstruct();
    level.demolocalclients[localclientnum].nonpredicted_local_player = function_27673a7(localclientnum);
    level.demolocalclients[localclientnum].predicted_local_player = function_5c10bd79(localclientnum);
    while (true) {
        nonpredicted_local_player = function_27673a7(localclientnum);
        predicted_local_player = function_5c10bd79(localclientnum);
        if (nonpredicted_local_player !== level.demolocalclients[localclientnum].nonpredicted_local_player) {
            level notify(#"demo_nplplayer_change", localclientnum);
            level notify("demo_nplplayer_change" + localclientnum, {#var_fb9ab71:level.demolocalclients[localclientnum].nonpredicted_local_player, #new_player:nonpredicted_local_player});
            level.demolocalclients[localclientnum].nonpredicted_local_player = nonpredicted_local_player;
        }
        if (predicted_local_player !== level.demolocalclients[localclientnum].predicted_local_player) {
            level notify(#"demo_plplayer_change", {#localclientnum:localclientnum, #var_fb9ab71:level.demolocalclients[localclientnum].predicted_local_player, #new_player:predicted_local_player});
            level notify("demo_plplayer_change" + localclientnum, {#var_fb9ab71:level.demolocalclients[localclientnum].predicted_local_player, #new_player:predicted_local_player});
            level.demolocalclients[localclientnum].predicted_local_player = predicted_local_player;
        }
        waitframe(1);
    }
}

