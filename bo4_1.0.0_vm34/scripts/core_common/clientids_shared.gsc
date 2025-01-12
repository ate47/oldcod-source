#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;

#namespace clientids;

// Namespace clientids/clientids_shared
// Params 0, eflags: 0x2
// Checksum 0xfc363a9e, Offset: 0x78
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"clientids", &__init__, undefined, undefined);
}

// Namespace clientids/clientids_shared
// Params 0, eflags: 0x0
// Checksum 0xee371d3, Offset: 0xc0
// Size: 0x44
function __init__() {
    callback::on_start_gametype(&init);
    callback::on_connect(&on_player_connect);
}

// Namespace clientids/clientids_shared
// Params 0, eflags: 0x0
// Checksum 0xf10cfa31, Offset: 0x110
// Size: 0x12
function init() {
    level.clientid = 0;
}

// Namespace clientids/clientids_shared
// Params 0, eflags: 0x0
// Checksum 0xf647612, Offset: 0x130
// Size: 0x9c
function on_player_connect() {
    self.clientid = matchrecordnewplayer(self);
    if (!isdefined(self.clientid) || self.clientid == -1) {
        self.clientid = level.clientid;
        level.clientid++;
    }
    println("<dev string:x30>" + self.name + "<dev string:x39>" + self.clientid);
}

