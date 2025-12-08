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
#using scripts\core_common\vehicles\siegebot;

#namespace namespace_78792ce8;

// Namespace namespace_78792ce8/namespace_40af7eee
// Params 0
// Checksum 0x7f234923, Offset: 0x190
// Size: 0x86
function function_7980d69c()
{
    self endon( #"death" );
    self enableaimassist();
    
    while ( true )
    {
        target = self turretgettarget( 0 );
        
        if ( isdefined( target ) )
        {
            self turretsettarget( 1, target );
        }
        
        waitframe( 1 );
    }
}

// Namespace namespace_78792ce8/namespace_40af7eee
// Params 0
// Checksum 0x1378e500, Offset: 0x220
// Size: 0xba
function function_ba7e9b89()
{
    self endon( #"death", #"exit_vehicle" );
    firetime = max( self seatgetweapon( 1 ).firetime, self seatgetweapon( 2 ).firetime );
    self fireweapon( 1 );
    self fireweapon( 2 );
    wait firetime;
}

// Namespace namespace_78792ce8/namespace_40af7eee
// Params 2
// Checksum 0x8eae85ab, Offset: 0x2e8
// Size: 0x3ec
function function_b974aa72( origin, player )
{
    if ( !isdefined( player ) || isdefined( player.doa.vehicle ) || is_true( player.doa.var_36cc2d9a ) || !isdefined( level.doa.pickups.var_92a02b26 ) )
    {
        return;
    }
    
    if ( !is_true( level.var_7fcdba66 ) )
    {
        siegebot::function_5de06a3f();
    }
    
    player notify( #"hash_df25520ab279dff" );
    player endon( #"disconnect" );
    player.doa.var_36cc2d9a = 1;
    player namespace_7f5aeb59::function_77785447( 1 );
    player function_fee48e9e();
    siegebot = level.doa.pickups.var_92a02b26 spawner::spawn( 1, "zombietron_siegebot_spawner", origin );
    siegebot.var_8c05c51a = &function_ba7e9b89;
    siegebot thread namespace_ec06fe4a::function_ae010bb4( player );
    player.doa.var_36cc2d9a = undefined;
    player.doa.vehicle = siegebot;
    siegebot.angles = player.angles;
    siegebot.team = player.team;
    siegebot.owner = player;
    siegebot.playercontrolled = 1;
    siegebot.var_7efce95 = 0;
    siegebot setmodel( "zombietron_siegebot_mini_" + player.doa.color );
    siegebot usevehicle( player, 0 );
    siegebot makeunusable();
    siegebot.health = 9999999;
    siegebot thread function_7980d69c();
    siegebot function_d733412a( 0 );
    timeout = player namespace_1c2a96f9::function_4808b985( 40 );
    siegebot thread function_c45d8312( player, timeout );
    player namespace_83eb6304::turnofffx( "player_trail_" + player.doa.color );
    player waittill( #"hash_279998c5df86c04d" );
    
    if ( !is_true( self.doa.infps ) )
    {
        player namespace_83eb6304::function_3ecfde67( "player_trail_" + player.doa.color );
    }
    
    if ( isdefined( siegebot ) )
    {
        var_f3fd3234 = siegebot.origin;
        siegebot makeusable();
        
        if ( isdefined( player ) )
        {
            player thread function_9b3b2351( var_f3fd3234, siegebot );
        }
        
        siegebot makeunusable();
        waitframe( 1 );
    }
    
    siegebot delete();
}

// Namespace namespace_78792ce8/namespace_40af7eee
// Params 2
// Checksum 0x1933b382, Offset: 0x6e0
// Size: 0xf4
function function_9b3b2351( *var_f3fd3234, vehicle )
{
    self endon( #"disconnect" );
    vehicle.var_3e742dc1 = 1;
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

// Namespace namespace_78792ce8/namespace_40af7eee
// Params 0
// Checksum 0x77b9d544, Offset: 0x7e0
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

// Namespace namespace_78792ce8/namespace_40af7eee
// Params 0
// Checksum 0x48bb2d7b, Offset: 0x848
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

// Namespace namespace_78792ce8/namespace_40af7eee
// Params 2
// Checksum 0xe73f07e9, Offset: 0x8a0
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

