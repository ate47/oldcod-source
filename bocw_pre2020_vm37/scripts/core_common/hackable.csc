#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;

#namespace hackable;

// Namespace hackable/hackable
// Params 0, eflags: 0x6
// Checksum 0x9aca5c3, Offset: 0x70
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hackable", &init, undefined, undefined, undefined);
}

// Namespace hackable/hackable
// Params 0, eflags: 0x0
// Checksum 0x2e70691a, Offset: 0xb8
// Size: 0x24
function init() {
    callback::on_localclient_connect(&on_player_connect);
}

// Namespace hackable/hackable
// Params 1, eflags: 0x0
// Checksum 0xb9153c52, Offset: 0xe8
// Size: 0xc
function on_player_connect(*localclientnum) {
    
}

// Namespace hackable/hackable
// Params 2, eflags: 0x0
// Checksum 0x3f579fb1, Offset: 0x100
// Size: 0x4c
function set_hacked_ent(*local_client_num, ent) {
    if (ent !== self.hacked_ent) {
        if (isdefined(self.hacked_ent)) {
        }
        self.hacked_ent = ent;
        if (isdefined(self.hacked_ent)) {
        }
    }
}

