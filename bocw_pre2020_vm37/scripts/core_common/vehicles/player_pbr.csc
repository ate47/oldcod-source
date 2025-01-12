#using script_2009cc4c4ecc010f;
#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;

#namespace player_pbr;

// Namespace player_pbr/player_pbr
// Params 0, eflags: 0x6
// Checksum 0xbeb8eaaa, Offset: 0x88
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"player_pbr", &function_70a657d8, undefined, undefined, #"player_vehicle");
}

// Namespace player_pbr/player_pbr
// Params 1, eflags: 0x5 linked
// Checksum 0xb02c1e51, Offset: 0xd8
// Size: 0x5c
function private function_70a657d8(*localclientnum) {
    vehicle::add_vehicletype_callback("player_pbr", &function_cc0af45d);
    setdvar(#"phys_buoyancy", 1);
}

// Namespace player_pbr/player_pbr
// Params 1, eflags: 0x5 linked
// Checksum 0xa80607ed, Offset: 0x140
// Size: 0x2e
function private function_cc0af45d(*localclientnum) {
    self.var_917cf8e3 = &player_vehicle::function_b0d51c9;
    self.var_1a6ef836 = 0;
}

