#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;

#namespace clientids;

// Namespace clientids/clientids
// Params 0, eflags: 0x2
// Checksum 0x3a7b6cc8, Offset: 0x78
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"clientids", &__init__, undefined, undefined);
}

// Namespace clientids/clientids
// Params 0, eflags: 0x0
// Checksum 0x81bce80, Offset: 0xc0
// Size: 0x44
function __init__() {
    callback::on_start_gametype(&init);
    callback::on_connect(&on_player_connect);
}

// Namespace clientids/clientids
// Params 0, eflags: 0x0
// Checksum 0x80a8fde6, Offset: 0x110
// Size: 0x12
function init() {
    level.clientid = 0;
}

// Namespace clientids/clientids
// Params 0, eflags: 0x0
// Checksum 0x526867ec, Offset: 0x130
// Size: 0x9c
function on_player_connect() {
    self.clientid = matchrecordnewplayer(self);
    if (!isdefined(self.clientid) || self.clientid == -1) {
        self.clientid = level.clientid;
        level.clientid++;
    }
    println("<dev string:x30>" + self.name + "<dev string:x39>" + self.clientid);
}

