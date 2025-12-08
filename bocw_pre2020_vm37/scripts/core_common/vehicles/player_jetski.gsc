#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicles\player_vehicle;

#namespace player_jetski;

// Namespace player_jetski/player_jetski
// Params 0, eflags: 0x6
// Checksum 0xb5f7e54c, Offset: 0x98
// Size: 0x44
function private autoexec __init__system__()
{
    system::register( #"player_jetski", &preinit, undefined, undefined, #"player_vehicle" );
}

// Namespace player_jetski/player_jetski
// Params 0, eflags: 0x4
// Checksum 0xa44a4e6e, Offset: 0xe8
// Size: 0x2c
function private preinit()
{
    vehicle::add_main_callback( "player_jetski", &function_966d6664 );
}

// Namespace player_jetski/player_jetski
// Params 0, eflags: 0x4
// Checksum 0x512e4f74, Offset: 0x120
// Size: 0x74
function private function_966d6664()
{
    self.var_84fed14b = 40;
    self.var_4ca92b57 = 20;
    self.var_d6691161 = 175;
    self.var_5d662124 = 2;
    callback::function_d8abfc3d( #"hash_666d48a558881a36", &function_4fc75987 );
}

// Namespace player_jetski/player_jetski
// Params 1, eflags: 0x4
// Checksum 0x4233cf9a, Offset: 0x1a0
// Size: 0x24
function private function_4fc75987( *params )
{
    self thread player_vehicle::function_e8e41bbb();
}

