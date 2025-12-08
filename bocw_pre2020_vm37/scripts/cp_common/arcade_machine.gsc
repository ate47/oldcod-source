#using script_35ae72be7b4fec10;
#using scripts\core_common\array_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\values_shared;

#namespace arcade_machine;

// Namespace arcade_machine/arcade_machine
// Params 0, eflags: 0x6
// Checksum 0xcdfb83bc, Offset: 0x178
// Size: 0x2c
function private autoexec __init__system__()
{
    system::register( #"arcade_machine", undefined, undefined, undefined, undefined );
}

// Namespace arcade_machine/arcade_machine
// Params 1
// Checksum 0x7390732c, Offset: 0x1b0
// Size: 0x18c
function function_7718419d( var_dc872b64 = "" )
{
    if ( !isdefined( level.player ) )
    {
        level.player = getplayers()[ 0 ];
    }
    
    if ( !scripted_widgets::exists( #"hash_541706109c2cadca" ) )
    {
        scripted_widgets::create( #"hash_541706109c2cadca", #"arcademachine" );
    }
    
    level.player val::set( #"arcade_machine", "show_weapon_hud", 0 );
    level.player val::set( #"arcade_machine", "show_crosshair", 0 );
    level.player val::set( #"arcade_machine", "disable_weapons", 1 );
    level.player val::set( #"arcade_machine", "freezecontrols_allowlook", 1 );
    function_62443495( var_dc872b64 );
}

// Namespace arcade_machine/arcade_machine
// Params 1
// Checksum 0x4f535a3b, Offset: 0x348
// Size: 0xb4
function function_62443495( var_dc872b64 = "" )
{
    if ( !isdefined( level.player ) )
    {
        level.player = getplayers()[ 0 ];
    }
    
    scripted_widgets::function_9ade1d9b( #"hash_541706109c2cadca", "string", var_dc872b64 );
    
    if ( var_dc872b64 == "game_select" )
    {
        scripted_widgets::set_focus( #"hash_541706109c2cadca", 1 );
    }
}

// Namespace arcade_machine/arcade_machine
// Params 0
// Checksum 0xd7979557, Offset: 0x408
// Size: 0xec
function function_b2669077()
{
    if ( !isdefined( level.player ) )
    {
        level.player = getplayers()[ 0 ];
    }
    
    self notify( "6cdc0866d242c9d9" );
    self endon( "6cdc0866d242c9d9" );
    scripted_widgets::function_9ade1d9b( #"hash_541706109c2cadca", "string", "" );
    
    if ( scripted_widgets::exists( #"hash_541706109c2cadca" ) )
    {
        scripted_widgets::remove( #"hash_541706109c2cadca" );
    }
    
    level.player val::reset_all( #"arcade_machine" );
}

// Namespace arcade_machine/arcade_machine
// Params 2
// Checksum 0xea6aa1bc, Offset: 0x500
// Size: 0x154
function function_2a291669( var_cffbeaae, var_f35de83 )
{
    var_cffbeaae.origin = var_f35de83.origin;
    var_cffbeaae.angles = var_f35de83.angles;
    vec_right = anglestoright( self.angles );
    vec_to_player = vectornormalize( level.player getplayercamerapos() - self.origin );
    n_dot = vectordot( vec_right, vec_to_player );
    
    if ( abs( n_dot ) < 0.3 )
    {
        var_a16bf7b3 = "player_center_enter";
    }
    else
    {
        var_a16bf7b3 = vectordot( vec_right, vec_to_player ) > 0 ? "player_left_enter" : "player_right_enter";
    }
    
    var_cffbeaae scene::play( var_a16bf7b3 );
    var_cffbeaae thread scene::play( "player_loop" );
}

// Namespace arcade_machine/arcade_machine
// Params 1
// Checksum 0xbd6f1b60, Offset: 0x660
// Size: 0x2c
function function_67a244d3( var_cffbeaae )
{
    var_cffbeaae scene::play( "player_exit" );
}

// Namespace arcade_machine/arcade_machine
// Params 1
// Checksum 0xc5d94226, Offset: 0x698
// Size: 0xac
function function_85de737f( var_f35de83 )
{
    if ( isdefined( self.script_noteworthy ) )
    {
        function_7718419d( self.script_noteworthy );
        
        if ( isdefined( var_f35de83.target ) )
        {
            var_ca4dc1d1 = getdynentarray( var_f35de83.target, 1 );
            assert( var_ca4dc1d1.size == 1 );
            setdynentstate( var_ca4dc1d1[ 0 ], 1 );
        }
    }
}

// Namespace arcade_machine/arcade_machine
// Params 1
// Checksum 0x695d1813, Offset: 0x750
// Size: 0xa4
function function_b6d06a2d( var_f35de83 )
{
    function_b2669077();
    
    if ( isdefined( var_f35de83.target ) )
    {
        var_ca4dc1d1 = getdynentarray( struct::get( self.target ).target, 1 );
        assert( var_ca4dc1d1.size == 1 );
        setdynentstate( var_ca4dc1d1[ 0 ], 0 );
    }
}

