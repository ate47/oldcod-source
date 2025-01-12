#using script_272c2c9da7e6858;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;

#namespace hud_message;

// Namespace hud_message/hud_message_shared
// Params 0, eflags: 0x2
// Checksum 0x8ccb7cc8, Offset: 0xa0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"hud_message", &__init__, undefined, undefined);
}

// Namespace hud_message/hud_message_shared
// Params 0, eflags: 0x0
// Checksum 0xe4821c22, Offset: 0xe8
// Size: 0x44
function __init__() {
    level.lower_message = lower_message::register("lower_message");
    callback::on_start_gametype(&init);
}

// Namespace hud_message/hud_message_shared
// Params 0, eflags: 0x0
// Checksum 0x5f00c225, Offset: 0x138
// Size: 0x24
function init() {
    callback::on_connect(&on_player_connect);
}

// Namespace hud_message/hud_message_shared
// Params 0, eflags: 0x0
// Checksum 0x42fa58ea, Offset: 0x168
// Size: 0x1c
function on_player_connect() {
    self thread lowermessagethink();
}

// Namespace hud_message/hud_message_shared
// Params 1, eflags: 0x0
// Checksum 0xd4ea90ac, Offset: 0x190
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
// Params 0, eflags: 0x0
// Checksum 0xae8e92c, Offset: 0x230
// Size: 0x6c
function lowermessagethink() {
    self endon(#"disconnect");
    if (!isdefined(level.lower_message) || level.lower_message lower_message::is_open(self)) {
        return;
    }
    level.lower_message lower_message::open(self, 1);
}

// Namespace hud_message/hud_message_shared
// Params 2, eflags: 0x0
// Checksum 0x6a12a712, Offset: 0x2a8
// Size: 0x10c
function setlowermessage(text, time) {
    self notify(#"hash_6ceeeb477ece797b");
    if (!isdefined(level.lower_message)) {
        return;
    }
    level.lower_message lower_message::set_message(self, isdefined(text) ? text : #"");
    if (isdefined(time) && time > 0) {
        level.lower_message lower_message::set_countdowntimeseconds(self, int(time));
        level.lower_message lower_message::set_state(self, #"visible");
        return;
    }
    level.lower_message lower_message::set_state(self, #"hash_45bfcb1cd8c9b50a");
}

// Namespace hud_message/hud_message_shared
// Params 0, eflags: 0x0
// Checksum 0xebd432ed, Offset: 0x3c0
// Size: 0x84
function clearlowermessage() {
    self endon(#"hash_6ceeeb477ece797b");
    if (!isdefined(level.lower_message) || !isplayer(self)) {
        return;
    }
    level.lower_message lower_message::set_state(self, #"defaultstate");
    self thread function_e09c265e();
}

// Namespace hud_message/hud_message_shared
// Params 0, eflags: 0x4
// Checksum 0x2a69fa31, Offset: 0x450
// Size: 0x74
function private function_e09c265e() {
    self endon(#"hash_6ceeeb477ece797b", #"disconnect");
    wait 1;
    level.lower_message lower_message::set_message(self, #"");
    level.lower_message lower_message::set_countdowntimeseconds(self, 0);
}

// Namespace hud_message/hud_message_shared
// Params 2, eflags: 0x0
// Checksum 0xd56486a9, Offset: 0x4d0
// Size: 0x64
function isintop(players, topn) {
    for (i = 0; i < topn; i++) {
        if (isdefined(players[i]) && self == players[i]) {
            return true;
        }
    }
    return false;
}

