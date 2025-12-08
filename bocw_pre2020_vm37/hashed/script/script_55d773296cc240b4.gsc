#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace namespace_25845e22;

// Namespace namespace_25845e22/namespace_25845e22
// Params 0, eflags: 0x6
// Checksum 0x85a42384, Offset: 0xc0
// Size: 0x4c
function private autoexec __init__system__()
{
    system::register( #"slow_motion", &preload, &postload, undefined, undefined );
}

// Namespace namespace_25845e22/namespace_25845e22
// Params 0
// Checksum 0x684ead6b, Offset: 0x118
// Size: 0x34
function preload()
{
    clientfield::register( "toplayer", "slowmo_postfx", 1, 1, "int" );
}

// Namespace namespace_25845e22/namespace_25845e22
// Params 0
// Checksum 0x42271b25, Offset: 0x158
// Size: 0xb8
function postload()
{
    var_6fe715a6 = getentarray( "slow_motion", "targetname" );
    
    foreach ( var_38ea55bb in var_6fe715a6 )
    {
        var_38ea55bb callback::on_trigger_once( &function_4f175e9e );
    }
}

// Namespace namespace_25845e22/namespace_25845e22
// Params 1
// Checksum 0x5ebb9e77, Offset: 0x218
// Size: 0xd4
function function_4f175e9e( var_63fc1c2f )
{
    e_player = var_63fc1c2f.activator;
    e_player.var_77f8c549 = 1;
    e_player clientfield::set_to_player( "slowmo_postfx", 1 );
    callback::on_ai_damage( &function_9ee98725 );
    setslowmotion( 1, 0.35, 0.1, 1, 0.85 );
    e_player thread function_c32bbad3();
    e_player thread function_d9900009( self );
}

// Namespace namespace_25845e22/namespace_25845e22
// Params 1
// Checksum 0xf0c822f8, Offset: 0x2f8
// Size: 0xe4
function function_9ee98725( s_params )
{
    if ( isdefined( self ) && isalive( self ) && !isdefined( self.var_55dbe4ee ) && isdefined( s_params.eattacker ) && !( s_params.weapon.name == #"eq_flash_grenade" ) )
    {
        self.var_55dbe4ee = 1;
        self dodamage( 5000, s_params.eattacker.origin, s_params.eattacker, s_params.eattacker, s_params.shitloc, s_params.smeansofdeath, 0, s_params.weapon );
    }
}

// Namespace namespace_25845e22/namespace_25845e22
// Params 0, eflags: 0x4
// Checksum 0x572fc7d1, Offset: 0x3e8
// Size: 0xbe
function private function_c32bbad3()
{
    self endon( #"death" );
    self waittill( #"hash_49bcb69a66dac397", #"hash_74a5916d3f148a78" );
    setslowmotion( 0.35, 1, 0.1, 0.85, 1 );
    callback::remove_on_ai_damage( &function_9ee98725 );
    self clientfield::set_to_player( "slowmo_postfx", 0 );
    self.var_77f8c549 = 0;
}

// Namespace namespace_25845e22/namespace_25845e22
// Params 1, eflags: 0x4
// Checksum 0xfc5f0abc, Offset: 0x4b0
// Size: 0x66
function private function_d9900009( e_trigger )
{
    self endon( #"death", #"hash_49bcb69a66dac397" );
    
    while ( self istouching( e_trigger ) )
    {
        waitframe( 1 );
    }
    
    self notify( #"hash_74a5916d3f148a78" );
}

