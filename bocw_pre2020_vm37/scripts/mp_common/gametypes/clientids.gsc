#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;

#namespace clientids;

// Namespace clientids/clientids
// Params 0, eflags: 0x6
// Checksum 0x3199d952, Offset: 0x70
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"clientids", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace clientids/clientids
// Params 0, eflags: 0x5 linked
// Checksum 0xf0100965, Offset: 0xb8
// Size: 0x44
function private function_70a657d8() {
    callback::on_start_gametype(&init);
    callback::on_connect(&on_player_connect);
}

// Namespace clientids/clientids
// Params 0, eflags: 0x1 linked
// Checksum 0xe4f0ab2, Offset: 0x108
// Size: 0x10
function init() {
    level.clientid = 0;
}

// Namespace clientids/clientids
// Params 0, eflags: 0x1 linked
// Checksum 0x45c788d1, Offset: 0x120
// Size: 0x9c
function on_player_connect() {
    self.clientid = matchrecordnewplayer(self);
    if (!isdefined(self.clientid) || self.clientid == -1) {
        self.clientid = level.clientid;
        level.clientid++;
    }
    println("<dev string:x38>" + self.name + "<dev string:x44>" + self.clientid);
}

