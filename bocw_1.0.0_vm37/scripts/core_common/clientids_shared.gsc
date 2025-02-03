#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;

#namespace clientids;

// Namespace clientids/clientids_shared
// Params 0, eflags: 0x6
// Checksum 0xf8a1339c, Offset: 0x70
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"clientids", &preinit, undefined, undefined, undefined);
}

// Namespace clientids/clientids_shared
// Params 0, eflags: 0x4
// Checksum 0x8123551b, Offset: 0xb8
// Size: 0x44
function private preinit() {
    callback::on_start_gametype(&init);
    callback::on_connect(&on_player_connect);
}

// Namespace clientids/clientids_shared
// Params 0, eflags: 0x0
// Checksum 0xea29c15b, Offset: 0x108
// Size: 0x10
function init() {
    level.clientid = 0;
}

// Namespace clientids/clientids_shared
// Params 0, eflags: 0x0
// Checksum 0x67da3946, Offset: 0x120
// Size: 0x9c
function on_player_connect() {
    self.clientid = matchrecordnewplayer(self);
    if (!isdefined(self.clientid) || self.clientid == -1) {
        self.clientid = level.clientid;
        level.clientid++;
    }
    println("<dev string:x38>" + self.name + "<dev string:x44>" + self.clientid);
}

