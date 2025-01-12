#using scripts/core_common/callbacks_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;

#namespace clientids;

// Namespace clientids/clientids_shared
// Params 0, eflags: 0x2
// Checksum 0xb1c11300, Offset: 0x100
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("clientids", &__init__, undefined, undefined);
}

// Namespace clientids/clientids_shared
// Params 0, eflags: 0x0
// Checksum 0xad2844c7, Offset: 0x140
// Size: 0x44
function __init__() {
    callback::on_start_gametype(&init);
    callback::on_connect(&on_player_connect);
}

// Namespace clientids/clientids_shared
// Params 0, eflags: 0x0
// Checksum 0x3e676b2f, Offset: 0x190
// Size: 0x14
function init() {
    level.clientid = 0;
}

// Namespace clientids/clientids_shared
// Params 0, eflags: 0x0
// Checksum 0xb3d5ed10, Offset: 0x1b0
// Size: 0xa4
function on_player_connect() {
    self.clientid = matchrecordnewplayer(self);
    if (!isdefined(self.clientid) || self.clientid == -1) {
        self.clientid = level.clientid;
        level.clientid++;
    }
    /#
        println("<dev string:x28>" + self.name + "<dev string:x31>" + self.clientid);
    #/
}

