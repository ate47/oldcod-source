#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/vehicle_shared;
#using scripts/mp_common/util;
#using scripts/mp_common/vehicle;

#namespace qrdrone;

// Namespace qrdrone/qrdrone
// Params 0, eflags: 0x2
// Checksum 0x780d82c8, Offset: 0x3d0
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "qrdrone", &__init__, undefined, undefined );
}

// Namespace qrdrone/qrdrone
// Params 0
// Checksum 0xee220c39, Offset: 0x410
// Size: 0x28c
function __init__()
{
    type = "qrdrone_mp";
    clientfield::register( "helicopter", "qrdrone_state", 1, 3, "int", &statechange, 0, 0 );
    clientfield::register( "vehicle", "qrdrone_state", 1, 3, "int", &statechange, 0, 0 );
    level._effect[ "qrdrone_enemy_light" ] = "killstreaks/fx_drgnfire_light_red_3p";
    level._effect[ "qrdrone_friendly_light" ] = "killstreaks/fx_drgnfire_light_green_3p";
    level._effect[ "qrdrone_viewmodel_light" ] = "killstreaks/fx_drgnfire_light_green_1p";
    clientfield::register( "helicopter", "qrdrone_countdown", 1, 1, "int", &start_blink, 0, 0 );
    clientfield::register( "helicopter", "qrdrone_timeout", 1, 1, "int", &final_blink, 0, 0 );
    clientfield::register( "vehicle", "qrdrone_countdown", 1, 1, "int", &start_blink, 0, 0 );
    clientfield::register( "vehicle", "qrdrone_timeout", 1, 1, "int", &final_blink, 0, 0 );
    clientfield::register( "vehicle", "qrdrone_out_of_range", 1, 1, "int", &out_of_range_update, 0, 0 );
    vehicle::add_vehicletype_callback( "qrdrone_mp", &spawned );
}

// Namespace qrdrone/qrdrone
// Params 1
// Checksum 0x2a8b6750, Offset: 0x6a8
// Size: 0x84
function spawned( localclientnum )
{
    self util::waittill_dobj( localclientnum );
    self thread restartfx( localclientnum, 0 );
    self thread collisionhandler( localclientnum );
    self thread enginestutterhandler( localclientnum );
    self thread qrdrone_watch_distance();
}

// Namespace qrdrone/qrdrone
// Params 7
// Checksum 0x31acfc26, Offset: 0x738
// Size: 0x84
function statechange( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self endon( #"death" );
    self util::waittill_dobj( localclientnum );
    self restartfx( localclientnum, newval );
}

// Namespace qrdrone/qrdrone
// Params 2
// Checksum 0x60db05b9, Offset: 0x7c8
// Size: 0x124
function restartfx( localclientnum, blinkstage )
{
    self notify( #"restart_fx" );
    println( "Restart QRDrone FX: stage " + blinkstage );
    
    switch ( blinkstage )
    {
        case 0:
            self spawn_solid_fx( localclientnum );
            break;
        case 1:
            self.fx_interval = 1;
            self spawn_blinking_fx( localclientnum );
            break;
        case 2:
            self.fx_interval = 0.133;
            self spawn_blinking_fx( localclientnum );
            break;
        case 3:
            self notify( #"stopfx" );
            self notify( #"fx_death" );
            return;
    }
    
    self thread watchrestartfx( localclientnum );
}

// Namespace qrdrone/qrdrone
// Params 1
// Checksum 0x441bbc86, Offset: 0x8f8
// Size: 0x74
function watchrestartfx( localclientnum )
{
    self endon( #"death" );
    level waittill( "demo_jump", "player_switch", "killcam_begin", "killcam_end" );
    self restartfx( localclientnum, clientfield::get( "qrdrone_state" ) );
}

// Namespace qrdrone/qrdrone
// Params 1
// Checksum 0x29926ac0, Offset: 0x978
// Size: 0x11c
function spawn_solid_fx( localclientnum )
{
    if ( self islocalclientdriver( localclientnum ) )
    {
        fx_handle = playfxontag( localclientnum, level._effect[ "qrdrone_viewmodel_light" ], self, "tag_body" );
    }
    else if ( self util::friend_not_foe( localclientnum ) )
    {
        fx_handle = playfxontag( localclientnum, level._effect[ "qrdrone_friendly_light" ], self, "tag_body" );
    }
    else
    {
        fx_handle = playfxontag( localclientnum, level._effect[ "qrdrone_enemy_light" ], self, "tag_body" );
    }
    
    self thread cleanupfx( localclientnum, fx_handle );
}

// Namespace qrdrone/qrdrone
// Params 1
// Checksum 0xaab43f1f, Offset: 0xaa0
// Size: 0x2c
function spawn_blinking_fx( localclientnum )
{
    self thread blink_fx_and_sound( localclientnum, "wpn_qr_alert" );
}

// Namespace qrdrone/qrdrone
// Params 2
// Checksum 0x60bc4468, Offset: 0xad8
// Size: 0x140
function blink_fx_and_sound( localclientnum, soundalias )
{
    self endon( #"death" );
    self endon( #"restart_fx" );
    self endon( #"fx_death" );
    
    if ( !isdefined( self.interval ) )
    {
        self.interval = 1;
    }
    
    while ( true )
    {
        self playsound( localclientnum, soundalias );
        self spawn_solid_fx( localclientnum );
        util::server_wait( localclientnum, self.interval / 2 );
        self notify( #"stopfx" );
        util::server_wait( localclientnum, self.interval / 2 );
        self.interval /= 1.17;
        
        if ( self.interval < 0.1 )
        {
            self.interval = 0.1;
        }
    }
}

// Namespace qrdrone/qrdrone
// Params 2
// Checksum 0x7456447f, Offset: 0xc20
// Size: 0x54
function cleanupfx( localclientnum, handle )
{
    self waittill( "death", "blink", "stopfx", "restart_fx" );
    stopfx( localclientnum, handle );
}

// Namespace qrdrone/qrdrone
// Params 7
// Checksum 0xc9dcd46b, Offset: 0xc80
// Size: 0x52
function start_blink( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( !newval )
    {
        return;
    }
    
    self notify( #"blink" );
}

// Namespace qrdrone/qrdrone
// Params 7
// Checksum 0xc78a760, Offset: 0xce0
// Size: 0x58
function final_blink( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( !newval )
    {
        return;
    }
    
    self.interval = 0.133;
}

// Namespace qrdrone/qrdrone
// Params 7
// Checksum 0xd47951da, Offset: 0xd40
// Size: 0x9c
function out_of_range_update( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    model = getuimodel( getuimodelforcontroller( localclientnum ), "vehicle.outOfRange" );
    
    if ( isdefined( model ) )
    {
        setuimodelvalue( model, newval );
    }
}

// Namespace qrdrone/qrdrone
// Params 4
// Checksum 0xb18bb3ff, Offset: 0xde8
// Size: 0x160
function loop_local_sound( localclientnum, alias, interval, fx )
{
    self endon( #"death" );
    self endon( #"stopfx" );
    level endon( #"demo_jump" );
    level endon( #"player_switch" );
    
    if ( !isdefined( self.interval ) )
    {
        self.interval = interval;
    }
    
    while ( true )
    {
        self playsound( localclientnum, alias );
        self spawn_solid_fx( localclientnum );
        util::server_wait( localclientnum, self.interval / 2 );
        self notify( #"stopfx" );
        util::server_wait( localclientnum, self.interval / 2 );
        self.interval /= 1.17;
        
        if ( self.interval < 0.1 )
        {
            self.interval = 0.1;
        }
    }
}

// Namespace qrdrone/qrdrone
// Params 1
// Checksum 0x5f0994d, Offset: 0xf50
// Size: 0xf4
function check_for_player_switch_or_time_jump( localclientnum )
{
    self endon( #"death" );
    level waittill( "demo_jump", "player_switch", "killcam_begin" );
    self notify( #"stopfx" );
    waittillframeend();
    self thread blink_light( localclientnum );
    
    if ( isdefined( self.blinkstarttime ) && self.blinkstarttime <= level.servertime )
    {
        self.interval = 1;
        self thread start_blink( localclientnum, 1 );
    }
    else
    {
        self spawn_solid_fx( localclientnum );
    }
    
    self thread check_for_player_switch_or_time_jump( localclientnum );
}

// Namespace qrdrone/qrdrone
// Params 1
// Checksum 0xba16a712, Offset: 0x1050
// Size: 0x164
function blink_light( localclientnum )
{
    self endon( #"death" );
    level endon( #"demo_jump" );
    level endon( #"player_switch" );
    level endon( #"killcam_begin" );
    self waittill( "blink" );
    
    if ( !isdefined( self.blinkstarttime ) )
    {
        self.blinkstarttime = level.servertime;
    }
    
    if ( self islocalclientdriver( localclientnum ) )
    {
        self thread loop_local_sound( localclientnum, "wpn_qr_alert", 1, level._effect[ "qrdrone_viewmodel_light" ] );
        return;
    }
    
    if ( self util::friend_not_foe( localclientnum ) )
    {
        self thread loop_local_sound( localclientnum, "wpn_qr_alert", 1, level._effect[ "qrdrone_friendly_light" ] );
        return;
    }
    
    self thread loop_local_sound( localclientnum, "wpn_qr_alert", 1, level._effect[ "qrdrone_enemy_light" ] );
}

// Namespace qrdrone/qrdrone
// Params 1
// Checksum 0x919e9a99, Offset: 0x11c0
// Size: 0x148
function collisionhandler( localclientnum )
{
    self endon( #"death" );
    
    while ( true )
    {
        waitresult = self waittill( "veh_collision" );
        hip = waitresult.velocity;
        hitn = waitresult.normal;
        hit_intensity = waitresult.intensity;
        driver_local_client = self getlocalclientdriver();
        
        if ( isdefined( driver_local_client ) )
        {
            player = getlocalplayer( driver_local_client );
            
            if ( isdefined( player ) )
            {
                if ( hit_intensity > 15 )
                {
                    player playrumbleonentity( driver_local_client, "damage_heavy" );
                    continue;
                }
                
                player playrumbleonentity( driver_local_client, "damage_light" );
            }
        }
    }
}

// Namespace qrdrone/qrdrone
// Params 1
// Checksum 0x21ceff79, Offset: 0x1310
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

// Namespace qrdrone/qrdrone
// Params 0
// Checksum 0x5064d2e9, Offset: 0x13b0
// Size: 0x146
function getminimumflyheight()
{
    if ( !isdefined( level.airsupportheightscale ) )
    {
        level.airsupportheightscale = 1;
    }
    
    airsupport_height = struct::get( "air_support_height", "targetname" );
    
    if ( isdefined( airsupport_height ) )
    {
        planeflyheight = airsupport_height.origin[ 2 ];
    }
    else
    {
        println( "WARNING:  Missing air_support_height entity in the map.  Using default height." );
        planeflyheight = 850;
        
        if ( isdefined( level.airsupportheightscale ) )
        {
            level.airsupportheightscale = getdvarint( "scr_airsupportHeightScale", level.airsupportheightscale );
            planeflyheight *= getdvarint( "scr_airsupportHeightScale", level.airsupportheightscale );
        }
        
        if ( isdefined( level.forceairsupportmapheight ) )
        {
            planeflyheight += level.forceairsupportmapheight;
        }
    }
    
    return planeflyheight;
}

// Namespace qrdrone/qrdrone
// Params 0
// Checksum 0xc1c130ef, Offset: 0x1500
// Size: 0x2e6
function qrdrone_watch_distance()
{
    self endon( #"death" );
    qrdrone_height = struct::get( "qrdrone_height", "targetname" );
    
    if ( isdefined( qrdrone_height ) )
    {
        self.maxheight = qrdrone_height.origin[ 2 ];
    }
    else
    {
        self.maxheight = int( getminimumflyheight() );
    }
    
    self.maxdistance = 12800;
    level.mapcenter = getmapcenter();
    self.minheight = level.mapcenter[ 2 ] - 800;
    inrangepos = self.origin;
    soundent = spawn( 0, self.origin, "script_origin" );
    soundent linkto( self );
    self thread qrdrone_staticstopondeath( soundent );
    
    while ( true )
    {
        if ( !self qrdrone_in_range() )
        {
            staticalpha = 0;
            
            while ( !self qrdrone_in_range() )
            {
                if ( isdefined( self.heliinproximity ) )
                {
                    dist = distance( self.origin, self.heliinproximity.origin );
                    staticalpha = 1 - ( dist - 150 ) / 150;
                }
                else
                {
                    dist = distance( self.origin, inrangepos );
                    staticalpha = min( 1, dist / 200 );
                }
                
                sid = soundent playloopsound( "veh_qrdrone_static_lp", 0.2 );
                self vehicle::set_static_amount( staticalpha * 2 );
                waitframe( 1 );
            }
            
            self thread qrdrone_staticfade( staticalpha, soundent, sid );
        }
        
        inrangepos = self.origin;
        waitframe( 1 );
    }
}

// Namespace qrdrone/qrdrone
// Params 0
// Checksum 0x78776154, Offset: 0x17f0
// Size: 0x66, Type: bool
function qrdrone_in_range()
{
    if ( self.origin[ 2 ] < self.maxheight && self.origin[ 2 ] > self.minheight )
    {
        if ( self isinsideheightlock() )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace qrdrone/qrdrone
// Params 3
// Checksum 0x8e8f6977, Offset: 0x1860
// Size: 0xf6
function qrdrone_staticfade( staticalpha, sndent, sid )
{
    self endon( #"death" );
    
    while ( self qrdrone_in_range() )
    {
        staticalpha -= 0.05;
        
        if ( staticalpha <= 0 )
        {
            sndent stopallloopsounds( 0.5 );
            self vehicle::set_static_amount( 0 );
            break;
        }
        
        setsoundvolumerate( sid, 0.6 );
        setsoundvolume( sid, staticalpha );
        self vehicle::set_static_amount( staticalpha * 2 );
        waitframe( 1 );
    }
}

// Namespace qrdrone/qrdrone
// Params 1
// Checksum 0x8348a941, Offset: 0x1960
// Size: 0x4c
function qrdrone_staticstopondeath( sndent )
{
    self waittill( "death" );
    sndent stopallloopsounds( 0.1 );
    sndent delete();
}

