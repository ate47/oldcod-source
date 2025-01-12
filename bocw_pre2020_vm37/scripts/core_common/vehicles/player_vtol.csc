#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;

#namespace player_vtol;

// Namespace player_vtol/player_vtol
// Params 0, eflags: 0x6
// Checksum 0xbb4034b0, Offset: 0x80
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"player_vtol", &function_70a657d8, undefined, undefined, #"player_vehicle");
}

// Namespace player_vtol/player_vtol
// Params 1, eflags: 0x5 linked
// Checksum 0x9083f892, Offset: 0xd0
// Size: 0x34
function private function_70a657d8(*localclientnum) {
    vehicle::add_vehicletype_callback("player_vtol", &function_1b39ded0);
}

// Namespace player_vtol/player_vtol
// Params 1, eflags: 0x5 linked
// Checksum 0x13eeef33, Offset: 0x110
// Size: 0xc
function private function_1b39ded0(*localclientnum) {
    
}

