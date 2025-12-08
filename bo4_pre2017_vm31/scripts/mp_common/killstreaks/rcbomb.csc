#using scripts/core_common/clientfield_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/vehicle_shared;
#using scripts/core_common/vehicles/driving_fx;
#using scripts/mp_common/callbacks;
#using scripts/mp_common/util;
#using scripts/mp_common/vehicle;

#namespace rcbomb;

// Namespace rcbomb/rcbomb
// Params 0, eflags: 0x2
// Checksum 0x28e9623e, Offset: 0x468
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "rcbomb", &__init__, undefined, undefined );
}

// Namespace rcbomb/rcbomb
// Params 0
// Checksum 0xda338e5d, Offset: 0x4a8
// Size: 0x13c
function __init__()
{
    level._effect[ "rcbomb_enemy_light" ] = "killstreaks/fx_rcxd_lights_blinky";
    level._effect[ "rcbomb_friendly_light" ] = "killstreaks/fx_rcxd_lights_solid";
    level._effect[ "rcbomb_enemy_light_blink" ] = "killstreaks/fx_rcxd_lights_red";
    level._effect[ "rcbomb_friendly_light_blink" ] = "killstreaks/fx_rcxd_lights_grn";
    level._effect[ "rcbomb_stunned" ] = "_t6/weapon/grenade/fx_spark_disabled_rc_car";
    level.rcbombbundle = struct::get_script_bundle( "killstreak", "killstreak_rcbomb" );
    clientfield::register( "vehicle", "rcbomb_stunned", 1, 1, "int", &callback::callback_stunned, 0, 0 );
    vehicle::add_vehicletype_callback( "rc_car_mp", &spawned );
}

// Namespace rcbomb/rcbomb
// Params 1
// Checksum 0xad2fd658, Offset: 0x5f0
// Size: 0xb0
function spawned( localclientnum )
{
    self thread demo_think( localclientnum );
    self thread stunnedhandler( localclientnum );
    self thread boost_think( localclientnum );
    self thread shutdown_think( localclientnum );
    self.driving_fx_collision_override = &ondrivingfxcollision;
    self.driving_fx_jump_landing_override = &ondrivingfxjumplanding;
    self.killstreakbundle = level.rcbombbundle;
}

// Namespace rcbomb/rcbomb
// Params 1
// Checksum 0x929c35bb, Offset: 0x6a8
// Size: 0x68
function demo_think( localclientnum )
{
    self endon( #"death" );
    
    if ( !isdemoplaying() )
    {
        return;
    }
    
    for ( ;; )
    {
        level waittill( "demo_jump", "demo_player_switch" );
        self vehicle::lights_off( localclientnum );
    }
}

// Namespace rcbomb/rcbomb
// Params 1
// Checksum 0x1943b9d9, Offset: 0x718
// Size: 0xf4
function boost_blur( localclientnum )
{
    self endon( #"death" );
    
    if ( isdefined( self.owner ) && self.owner islocalplayer() )
    {
        enablespeedblur( localclientnum, getdvarfloat( "scr_rcbomb_amount", 0.1 ), getdvarfloat( "scr_rcbomb_inner_radius", 0.5 ), getdvarfloat( "scr_rcbomb_outer_radius", 0.75 ), 0, 0 );
        wait getdvarfloat( "scr_rcbomb_duration", 1 );
        disablespeedblur( localclientnum );
    }
}

// Namespace rcbomb/rcbomb
// Params 1
// Checksum 0xe1ea9831, Offset: 0x818
// Size: 0x40
function boost_think( localclientnum )
{
    self endon( #"death" );
    
    for ( ;; )
    {
        self waittill( "veh_boost" );
        self boost_blur( localclientnum );
    }
}

// Namespace rcbomb/rcbomb
// Params 1
// Checksum 0xaa22e21d, Offset: 0x860
// Size: 0x34
function shutdown_think( localclientnum )
{
    self waittill( "death" );
    disablespeedblur( localclientnum );
}

// Namespace rcbomb/rcbomb
// Params 1
// Checksum 0xd840ce01, Offset: 0x8a0
// Size: 0xc
function play_screen_fx_dirt( localclientnum )
{
    
}

// Namespace rcbomb/rcbomb
// Params 1
// Checksum 0x75bc05a4, Offset: 0x8b8
// Size: 0xc
function play_screen_fx_dust( localclientnum )
{
    
}

// Namespace rcbomb/rcbomb
// Params 1
// Checksum 0x22e7413d, Offset: 0x8d0
// Size: 0x122
function play_driving_screen_fx( localclientnum )
{
    speed_fraction = 0;
    
    while ( true )
    {
        speed = self getspeed();
        maxspeed = self getmaxspeed();
        
        if ( speed < 0 )
        {
            maxspeed = self getmaxreversespeed();
        }
        
        if ( maxspeed > 0 )
        {
            speed_fraction = abs( speed ) / maxspeed;
        }
        else
        {
            speed_fraction = 0;
        }
        
        if ( self iswheelcolliding( "back_left" ) || self iswheelcolliding( "back_right" ) )
        {
            if ( self islocalclientdriver( localclientnum ) )
            {
            }
        }
    }
}

// Namespace rcbomb/rcbomb
// Params 1
// Checksum 0xe7eaa3d5, Offset: 0xa00
// Size: 0x90
function play_boost_fx( localclientnum )
{
    self endon( #"death" );
    
    while ( true )
    {
        speed = self getspeed();
        
        if ( speed > 400 )
        {
            self playsound( localclientnum, "mpl_veh_rc_boost" );
            return;
        }
        
        util::server_wait( localclientnum, 0.1 );
    }
}

// Namespace rcbomb/rcbomb
// Params 1
// Checksum 0x72b15075, Offset: 0xa98
// Size: 0x98
function stunnedhandler( localclientnum )
{
    self endon( #"death" );
    self thread enginestutterhandler( localclientnum );
    
    while ( true )
    {
        self waittill( "stunned" );
        self setstunned( 1 );
        self thread notstunnedhandler( localclientnum );
        self thread play_stunned_fx_handler( localclientnum );
    }
}

// Namespace rcbomb/rcbomb
// Params 1
// Checksum 0xc55a15e9, Offset: 0xb38
// Size: 0x4c
function notstunnedhandler( localclientnum )
{
    self endon( #"death" );
    self endon( #"stunned" );
    self waittill( "not_stunned" );
    self setstunned( 0 );
}

// Namespace rcbomb/rcbomb
// Params 1
// Checksum 0x1681392a, Offset: 0xb90
// Size: 0x78
function play_stunned_fx_handler( localclientnum )
{
    self endon( #"death" );
    self endon( #"stunned" );
    self endon( #"not_stunned" );
    
    while ( true )
    {
        playfxontag( localclientnum, level._effect[ "rcbomb_stunned" ], self, "tag_origin" );
        wait 0.5;
    }
}

// Namespace rcbomb/rcbomb
// Params 1
// Checksum 0xfc45c88f, Offset: 0xc10
// Size: 0x98
function enginestutterhandler( localclientnum )
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( "veh_engine_stutter" );
        
        if ( self islocalclientdriver( localclientnum ) )
        {
            player = getlocalplayer( localclientnum );
            
            if ( isdefined( player ) )
            {
                player playrumbleonentity( localclientnum, "rcbomb_engine_stutter" );
            }
        }
    }
}

// Namespace rcbomb/rcbomb
// Params 5
// Checksum 0x8f482686, Offset: 0xcb0
// Size: 0x12c
function ondrivingfxcollision( localclientnum, player, hip, hitn, hit_intensity )
{
    if ( isdefined( hit_intensity ) && hit_intensity > 15 )
    {
        volume = driving_fx::get_impact_vol_from_speed();
        
        if ( isdefined( self.sounddef ) )
        {
            alias = self.sounddef + "_suspension_lg_hd";
        }
        else
        {
            alias = "veh_default_suspension_lg_hd";
        }
        
        id = playsound( 0, alias, self.origin, volume );
        player earthquake( 0.7, 0.25, player.origin, 1500 );
        player playrumbleonentity( localclientnum, "damage_heavy" );
    }
}

// Namespace rcbomb/rcbomb
// Params 2
// Checksum 0x646d3478, Offset: 0xde8
// Size: 0x14
function ondrivingfxjumplanding( localclientnum, player )
{
    
}

