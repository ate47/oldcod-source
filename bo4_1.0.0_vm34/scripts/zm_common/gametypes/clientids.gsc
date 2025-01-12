#using scripts\core_common\callbacks_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;

#namespace clientids;

// Namespace clientids/clientids
// Params 0, eflags: 0x2
// Checksum 0x6a81dead, Offset: 0x80
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"clientids", &__init__, undefined, undefined);
}

// Namespace clientids/clientids
// Params 0, eflags: 0x0
// Checksum 0xcbdaf653, Offset: 0xc8
// Size: 0x44
function __init__() {
    callback::on_start_gametype(&init);
    callback::on_connect(&on_player_connect);
}

// Namespace clientids/clientids
// Params 0, eflags: 0x0
// Checksum 0xe151dee9, Offset: 0x118
// Size: 0x12
function init() {
    level.clientid = 0;
}

// Namespace clientids/clientids
// Params 0, eflags: 0x0
// Checksum 0x3e9bea37, Offset: 0x138
// Size: 0x9c
function on_player_connect() {
    self.clientid = matchrecordnewplayer(self);
    if (!isdefined(self.clientid) || self.clientid == -1) {
        self.clientid = level.clientid;
        level.clientid++;
    }
    println("<dev string:x30>" + self.name + "<dev string:x39>" + self.clientid);
}

