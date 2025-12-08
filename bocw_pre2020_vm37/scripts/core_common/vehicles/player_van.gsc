#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;

#namespace player_van;

// Namespace player_van/player_van
// Params 0, eflags: 0x6
// Checksum 0xf8316f95, Offset: 0x88
// Size: 0x44
function private autoexec __init__system__()
{
    system::register( #"player_van", &preinit, undefined, undefined, #"player_vehicle" );
}

// Namespace player_van/player_van
// Params 0, eflags: 0x4
// Checksum 0x5d62ba9b, Offset: 0xd8
// Size: 0x2c
function private preinit()
{
    vehicle::add_main_callback( "player_van", &function_c6b4bcab );
}

// Namespace player_van/player_van
// Params 0, eflags: 0x4
// Checksum 0x93ffa878, Offset: 0x110
// Size: 0xaa
function private function_c6b4bcab()
{
    self setmovingplatformenabled( 1, 0 );
    callback::function_d8abfc3d( #"hash_666d48a558881a36", &function_e26ae7d4 );
    callback::function_d8abfc3d( #"hash_55f29e0747697500", &function_f5da89ea );
    self.var_84fed14b = 40;
    self.var_d6691161 = 175;
    self.var_5d662124 = 2;
}

// Namespace player_van/player_van
// Params 1
// Checksum 0x4d33700e, Offset: 0x1c8
// Size: 0x8c
function function_e26ae7d4( params )
{
    player = params.player;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( validateorigin( self.origin ) )
    {
        playsoundatposition( #"hash_5e5cbc0e6e2d1d4e", self.origin );
    }
    
    self vehicle::toggle_control_bone_group( 1, 1 );
}

// Namespace player_van/player_van
// Params 1
// Checksum 0xa5d1743e, Offset: 0x260
// Size: 0xdc
function function_f5da89ea( params )
{
    player = params.player;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    occupants = self getvehoccupants();
    
    if ( !isdefined( occupants ) || occupants.size == 0 )
    {
        if ( validateorigin( self.origin ) )
        {
            playsoundatposition( #"hash_5e5cbc0e6e2d1d4e", self.origin );
        }
        
        self vehicle::toggle_control_bone_group( 1, 0 );
    }
}

