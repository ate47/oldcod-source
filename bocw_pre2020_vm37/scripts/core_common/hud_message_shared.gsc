#using script_6167e26342be354b;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;

#namespace hud_message;

// Namespace hud_message/hud_message_shared
// Params 0, eflags: 0x6
// Checksum 0x683bd400, Offset: 0x90
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hud_message", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace hud_message/hud_message_shared
// Params 0, eflags: 0x5 linked
// Checksum 0x9c1b9611, Offset: 0xd8
// Size: 0x24
function private function_70a657d8() {
    callback::on_start_gametype(&init);
}

// Namespace hud_message/hud_message_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x80f724d1, Offset: 0x108
// Size: 0x4
function init() {
    
}

// Namespace hud_message/hud_message_shared
// Params 1, eflags: 0x0
// Checksum 0x27b065d4, Offset: 0x118
// Size: 0x94
function playnotifyloop(duration) {
    playnotifyloop = spawn("script_origin", (0, 0, 0));
    playnotifyloop playloopsound(#"uin_notify_data_loop");
    duration -= 4;
    if (duration < 1) {
        duration = 1;
    }
    wait duration;
    playnotifyloop delete();
}

// Namespace hud_message/hud_message_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xa3be3de9, Offset: 0x1b8
// Size: 0xa4
function setlowermessage(text, time) {
    self notify(#"hash_6ceeeb477ece797b");
    if (isdefined(time) && time > 0) {
        self luinotifyevent(#"hash_424b9c54c8bf7a82", 2, text, int(time));
        return;
    }
    self luinotifyevent(#"hash_424b9c54c8bf7a82", 1, text);
}

// Namespace hud_message/hud_message_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x9110d972, Offset: 0x268
// Size: 0x54
function clearlowermessage() {
    self endon(#"hash_6ceeeb477ece797b");
    if (!isplayer(self)) {
        return;
    }
    self luinotifyevent(#"hash_6b9a1c6794314120");
}

// Namespace hud_message/hud_message_shared
// Params 2, eflags: 0x0
// Checksum 0x79ded452, Offset: 0x2c8
// Size: 0x56
function isintop(players, topn) {
    for (i = 0; i < topn; i++) {
        if (isdefined(players[i]) && self == players[i]) {
            return true;
        }
    }
    return false;
}

