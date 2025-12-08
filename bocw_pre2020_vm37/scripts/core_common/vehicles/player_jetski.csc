#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicles\player_vehicle;

#namespace player_jetski;

// Namespace player_jetski/player_jetski
// Params 0, eflags: 0x6
// Checksum 0xb5f7e54c, Offset: 0x90
// Size: 0x44
function private autoexec __init__system__()
{
    system::register( #"player_jetski", &preinit, undefined, undefined, #"player_vehicle" );
}

// Namespace player_jetski/player_jetski
// Params 1, eflags: 0x4
// Checksum 0xd0400be6, Offset: 0xe0
// Size: 0x5c
function private preinit( *localclientnum )
{
    vehicle::add_vehicletype_callback( "player_jetski", &function_966d6664 );
    setdvar( #"phys_buoyancy", 1 );
}

// Namespace player_jetski/player_jetski
// Params 1, eflags: 0x4
// Checksum 0xa9eb0f51, Offset: 0x148
// Size: 0x2e
function private function_966d6664( *localclientnum )
{
    self.var_917cf8e3 = &player_vehicle::function_b0d51c9;
    self.var_1a6ef836 = 0;
}

