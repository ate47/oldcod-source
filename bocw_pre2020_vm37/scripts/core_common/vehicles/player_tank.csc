#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;

#namespace player_tank;

// Namespace player_tank/player_tank
// Params 0, eflags: 0x6
// Checksum 0x880e4c98, Offset: 0xf8
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"player_tank", &function_70a657d8, undefined, undefined, #"player_vehicle");
}

// Namespace player_tank/player_tank
// Params 1, eflags: 0x5 linked
// Checksum 0x1e4023b5, Offset: 0x148
// Size: 0x7c
function private function_70a657d8(*localclientnum) {
    vehicle::add_vehicletype_callback("player_tank", &function_c0f1d81b);
    clientfield::register("vehicle", "tank_shellejectfx", 1, 1, "int", &function_5c44d585, 0, 0);
}

// Namespace player_tank/player_tank
// Params 1, eflags: 0x5 linked
// Checksum 0x439849b6, Offset: 0x1d0
// Size: 0xc
function private function_c0f1d81b(*localclientnum) {
    
}

// Namespace player_tank/player_tank
// Params 7, eflags: 0x5 linked
// Checksum 0x8f525743, Offset: 0x1e8
// Size: 0x6c
function private function_5c44d585(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        self util::playfxontag(fieldname, "vehicle/fx9_mil_tank_ru_t72_shell_eject", self, "tag_fx_shell_eject");
    }
}

