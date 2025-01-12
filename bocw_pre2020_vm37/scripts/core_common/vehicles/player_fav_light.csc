#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;

#namespace player_fav_light;

// Namespace player_fav_light/player_fav_light
// Params 0, eflags: 0x6
// Checksum 0x29b83cf8, Offset: 0x98
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"player_fav_light", &function_70a657d8, undefined, undefined, #"player_vehicle");
}

// Namespace player_fav_light/player_fav_light
// Params 1, eflags: 0x5 linked
// Checksum 0x6212a1a2, Offset: 0xe8
// Size: 0x34
function private function_70a657d8(*localclientnum) {
    vehicle::add_vehicletype_callback("player_fav_light", &function_6e6e0d52);
}

// Namespace player_fav_light/player_fav_light
// Params 1, eflags: 0x5 linked
// Checksum 0xee196140, Offset: 0x128
// Size: 0xc
function private function_6e6e0d52(*localclientnum) {
    
}

