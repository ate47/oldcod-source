#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_350cffecd05ef6cf;
#using script_40f967ad5d18ea74;
#using script_47851dbeea22fe66;
#using script_4d748e58ce25b60c;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_74a56359b7d02ab6;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_56b772a5;

// Namespace namespace_56b772a5/namespace_c995c40a
// Params 1
// Checksum 0xc24d8ac, Offset: 0x180
// Size: 0x3bc
function function_ee81f2ca( player )
{
    if ( !isdefined( player ) || isdefined( player.doa.vehicle ) || is_true( player.doa.var_36cc2d9a ) )
    {
        return;
    }
    
    player notify( #"hash_df25520ab279dff" );
    player endon( #"disconnect" );
    player.doa.var_36cc2d9a = 1;
    player namespace_7f5aeb59::function_77785447( 1 );
    player function_fee48e9e();
    hind = level.doa.pickups.var_4480248f spawner::spawn( 1, "zombietron_hind_spawner" );
    hind thread namespace_ec06fe4a::function_ae010bb4( player );
    player.doa.var_36cc2d9a = undefined;
    player.doa.vehicle = hind;
    hind.origin = player.origin + ( 0, 0, 120 );
    hind.angles = player.angles;
    hind.team = player.team;
    hind.owner = player;
    hind.playercontrolled = 1;
    hind setmodel( "zombietron_hind_" + player.doa.color );
    hind vehclearlookat();
    hind.var_7efce95 = 0;
    hind.var_3e742dc1 = 1;
    hind function_803e9bf3( 1 );
    hind usevehicle( player, 0 );
    hind makeunusable();
    hind.health = 9999999;
    hind setheliheightlock( 1 );
    hind.heliheightlockoffset = 0;
    timeout = player namespace_1c2a96f9::function_4808b985( 40 );
    hind thread function_c45d8312( player, timeout );
    player namespace_83eb6304::turnofffx( "player_trail_" + player.doa.color );
    player waittill( #"hash_279998c5df86c04d" );
    
    if ( !is_true( self.doa.infps ) )
    {
        player namespace_83eb6304::function_3ecfde67( "player_trail_" + player.doa.color );
    }
    
    if ( isdefined( hind ) )
    {
        var_f3fd3234 = hind.origin;
        hind makeusable();
        
        if ( isdefined( player ) )
        {
            player thread function_9b3b2351( var_f3fd3234, hind );
        }
        
        hind delete();
    }
}

// Namespace namespace_56b772a5/namespace_c995c40a
// Params 2
// Checksum 0xa27dac1f, Offset: 0x548
// Size: 0xec
function function_9b3b2351( *var_f3fd3234, vehicle )
{
    if ( !isdefined( vehicle ) )
    {
        return;
    }
    
    self endon( #"disconnect" );
    vehicle usevehicle( self, 0 );
    self.ignoreme = 0;
    self.doa.vehicle = undefined;
    self.doa.var_baad518e = undefined;
    self namespace_7f5aeb59::function_77785447( 0 );
    self function_508772ec();
    self thread namespace_7f5aeb59::turnplayershieldon();
    self notify( #"hash_7893364bd228d63e" );
    self clientfield::increment_to_player( "controlBinding" );
}

// Namespace namespace_56b772a5/namespace_c995c40a
// Params 0
// Checksum 0x1fad9dca, Offset: 0x640
// Size: 0x5c
function function_fee48e9e()
{
    if ( !isdefined( self ) || !isdefined( self.doa ) )
    {
        return;
    }
    
    self notify( #"kill_shield" );
    self notify( #"kill_chickens" );
    util::wait_network_frame();
}

// Namespace namespace_56b772a5/namespace_c995c40a
// Params 0
// Checksum 0x15478e91, Offset: 0x6a8
// Size: 0x4c
function function_508772ec()
{
    if ( !isdefined( self ) || !isdefined( self.doa ) )
    {
        return;
    }
    
    self endon( #"disconnect" );
    util::wait_network_frame();
}

// Namespace namespace_56b772a5/namespace_c995c40a
// Params 2
// Checksum 0xc3cff902, Offset: 0x700
// Size: 0x80
function function_c45d8312( player, time )
{
    self endon( #"death" );
    player endon( #"disconnect", #"hash_279998c5df86c04d" );
    
    while ( !namespace_dfc652ee::function_f759a457() )
    {
        waitframe( 1 );
    }
    
    wait time;
    player notify( #"hash_279998c5df86c04d" );
}

