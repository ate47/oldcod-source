#using script_2009cc4c4ecc010f;
#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;

#namespace player_tactical_raft;

// Namespace player_tactical_raft/player_tactical_raft
// Params 0, eflags: 0x6
// Checksum 0x1da33f5a, Offset: 0x90
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"player_tactical_raft", &function_70a657d8, undefined, undefined, #"player_vehicle");
}

// Namespace player_tactical_raft/player_tactical_raft
// Params 1, eflags: 0x5 linked
// Checksum 0x8093ae3, Offset: 0xe0
// Size: 0x5c
function private function_70a657d8(*localclientnum) {
    vehicle::add_vehicletype_callback("tactical_raft_wz", &function_9941dc42);
    setdvar(#"phys_buoyancy", 1);
}

// Namespace player_tactical_raft/player_tactical_raft
// Params 1, eflags: 0x5 linked
// Checksum 0x8bebfad4, Offset: 0x148
// Size: 0x2e
function private function_9941dc42(*localclientnum) {
    self.var_917cf8e3 = &player_vehicle::function_b0d51c9;
    self.var_1a6ef836 = 0;
}

