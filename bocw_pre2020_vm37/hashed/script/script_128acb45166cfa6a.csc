#using scripts\core_common\ai\systems\fx_character;
#using scripts\core_common\ai_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\footsteps_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_6479037a;

// Namespace namespace_6479037a/namespace_6479037a
// Params 0
// Checksum 0x39a2c76, Offset: 0x1f8
// Size: 0x10c
function init()
{
    function_cae618b4( "spawner_zombietron_steiner" );
    clientfield::register( "actor", "steiner_radiation_bomb_prepare_fire_clientfield", 1, 1, "int", &function_bc28111c, 0, 0 );
    clientfield::register( "actor", "steiner_split_combine_fx_clientfield", 1, 1, "int", &function_66027924, 0, 0 );
    footsteps::registeraitypefootstepcb( #"hash_7c0d83ac1e845ac2", &function_5a53905d );
    ai::add_archetype_spawn_function( #"hash_7c0d83ac1e845ac2", &function_7ec99c76 );
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 1, eflags: 0x4
// Checksum 0xdd9df682, Offset: 0x310
// Size: 0x5c
function private function_7ec99c76( localclientnum )
{
    util::playfxontag( localclientnum, "zm_ai/fx9_steiner_eyes_glow", self, "J_EyeBall_LE" );
    util::playfxontag( localclientnum, "zm_ai/fx9_steiner_eyes_glow", self, "J_EyeBall_RI" );
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 7
// Checksum 0x3d837dbc, Offset: 0x378
// Size: 0xb2
function function_bc28111c( localclientnum, *oldvalue, newvalue, *bnewent, *binitialsnap, *fieldname, *wasdemojump )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isdefined( self.var_ce9323af ) )
    {
        stopfx( fieldname, self.var_ce9323af );
        self.var_ce9323af = undefined;
    }
    
    if ( wasdemojump )
    {
        self.var_ce9323af = util::playfxontag( fieldname, "zm_ai/fx9_steiner_rad_bomb_ai", self, "tag_bombthrower_FX" );
    }
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 5
// Checksum 0x9811763c, Offset: 0x438
// Size: 0x174
function function_5a53905d( *localclientnum, *pos, *surface, *notetrack, *bone )
{
    if ( self.subarchetype === #"hash_5653bbc44a034094" || self.subarchetype === #"hash_70162f4bc795092" )
    {
        return;
    }
    
    /#
        if ( isdefined( level.var_53094f02 ) )
        {
            return;
        }
    #/
    
    a_players = getlocalplayers();
    
    for ( i = 0; i < a_players.size ; i++ )
    {
        if ( abs( self.origin[ 2 ] - a_players[ i ].origin[ 2 ] ) < 128 )
        {
            var_ed2e93e5 = a_players[ i ] getlocalclientnumber();
            
            if ( isdefined( var_ed2e93e5 ) )
            {
                earthquake( var_ed2e93e5, 0.5, 0.1, self.origin, 1000 );
                playrumbleonposition( var_ed2e93e5, "steiner_footsteps", self.origin );
            }
        }
    }
}

// Namespace namespace_6479037a/namespace_6479037a
// Params 7
// Checksum 0xd7137e5d, Offset: 0x5b8
// Size: 0x74
function function_66027924( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump )
{
    if ( bwasdemojump && isdefined( self ) )
    {
        util::playfxontag( fieldname, "zombie/fx8_red_bathhouse_mirror_glare_loop", self, "j_spineupper" );
    }
}

