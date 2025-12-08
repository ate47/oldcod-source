#using scripts/core_common/abilities/gadgets/gadget_vision_pulse;
#using scripts/core_common/audio_shared;
#using scripts/core_common/burnplayer;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/exploder_shared;
#using scripts/core_common/filter_shared;
#using scripts/core_common/footsteps_shared;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/vehicle_shared;
#using scripts/core_common/vehicles/driving_fx;
#using scripts/core_common/weapons/sticky_grenade;
#using scripts/mp_common/callbacks;
#using scripts/mp_common/gametypes/globallogic;
#using scripts/mp_common/gametypes/globallogic_actor;
#using scripts/mp_common/killstreaks/ai_tank;
#using scripts/mp_common/killstreaks/airsupport;
#using scripts/mp_common/killstreaks/helicopter;
#using scripts/mp_common/killstreaks/qrdrone;
#using scripts/mp_common/killstreaks/rcbomb;
#using scripts/mp_common/util;
#using scripts/mp_common/vehicle;

#namespace callback;

// Namespace callback/callbacks
// Params 0, eflags: 0x2
// Checksum 0x42950980, Offset: 0x4c8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "callback", &__init__, undefined, undefined );
}

// Namespace callback/callbacks
// Params 0
// Checksum 0x2eacd8a5, Offset: 0x508
// Size: 0x1c
function __init__()
{
    level thread set_default_callbacks();
}

// Namespace callback/callbacks
// Params 0
// Checksum 0x63d2f870, Offset: 0x530
// Size: 0xc8
function set_default_callbacks()
{
    level.callbackplayerspawned = &playerspawned;
    level.callbacklocalclientconnect = &localclientconnect;
    level.callbackcreatingcorpse = &creating_corpse;
    level.callbackentityspawned = &entityspawned;
    level.callbackairsupport = &airsupport;
    level.callbackplayaifootstep = &footsteps::playaifootstep;
    level._custom_weapon_cb_func = &spawned_weapon_type;
    level.gadgetvisionpulse_reveal_func = &gadget_vision_pulse::gadget_visionpulse_reveal;
}

// Namespace callback/callbacks
// Params 1
// Checksum 0x8eca8feb, Offset: 0x600
// Size: 0x7c
function localclientconnect( localclientnum )
{
    println( "<dev string:x28>" + localclientnum );
    
    if ( isdefined( level.charactercustomizationsetup ) )
    {
        [[ level.charactercustomizationsetup ]]( localclientnum );
    }
    
    callback( #"hash_da8d7d74", localclientnum );
}

// Namespace callback/callbacks
// Params 1
// Checksum 0x23abbe31, Offset: 0x688
// Size: 0x12c
function playerspawned( localclientnum )
{
    self endon( #"death" );
    self notify( #"playerspawned_callback" );
    self endon( #"playerspawned_callback" );
    player = getlocalplayer( localclientnum );
    
    if ( isdefined( level.infraredvisionset ) )
    {
        player setinfraredvisionset( level.infraredvisionset );
    }
    
    if ( isdefined( level._playerspawned_override ) )
    {
        self thread [[ level._playerspawned_override ]]( localclientnum );
        return;
    }
    
    println( "<dev string:x55>" );
    
    if ( self islocalplayer() )
    {
        callback( #"hash_842e788a", localclientnum );
    }
    
    callback( #"hash_bc12b61f", localclientnum );
}

// Namespace callback/callbacks
// Params 1
// Checksum 0x8c8636b6, Offset: 0x7c0
// Size: 0x294
function entityspawned( localclientnum )
{
    self endon( #"death" );
    
    if ( self isplayer() )
    {
        if ( isdefined( level._clientfaceanimonplayerspawned ) )
        {
            self thread [[ level._clientfaceanimonplayerspawned ]]( localclientnum );
        }
    }
    
    if ( isdefined( level._entityspawned_override ) )
    {
        self thread [[ level._entityspawned_override ]]( localclientnum );
        return;
    }
    
    if ( !isdefined( self.type ) )
    {
        println( "<dev string:x64>" );
        return;
    }
    
    if ( self.type == "missile" )
    {
        if ( isdefined( level._custom_weapon_cb_func ) )
        {
            self thread [[ level._custom_weapon_cb_func ]]( localclientnum );
        }
    }
    else if ( self.type == "vehicle" || self.type == "helicopter" || self.type == "plane" )
    {
        if ( isdefined( level._customvehiclecbfunc ) )
        {
            self thread [[ level._customvehiclecbfunc ]]( localclientnum );
        }
        
        self thread vehicle::field_toggle_exhaustfx_handler( localclientnum, undefined, 0, 1 );
        self thread vehicle::field_toggle_lights_handler( localclientnum, undefined, 0, 1 );
        
        if ( self.type == "plane" || self.type == "helicopter" )
        {
            self thread vehicle::aircraft_dustkick();
        }
        else
        {
            self thread driving_fx::function_789b5418( localclientnum );
            self thread vehicle::vehicle_rumble( localclientnum );
        }
        
        if ( self.type == "helicopter" )
        {
            self thread helicopter::startfx_loop( localclientnum );
        }
    }
    
    if ( self.type == "actor" )
    {
        if ( isdefined( level._customactorcbfunc ) )
        {
            self thread [[ level._customactorcbfunc ]]( localclientnum );
        }
    }
}

// Namespace callback/callbacks
// Params 12
// Checksum 0xd5353934, Offset: 0xa60
// Size: 0x5ee
function airsupport( localclientnum, x, y, z, type, yaw, team, teamfaction, owner, exittype, time, height )
{
    pos = ( x, y, z );
    
    switch ( teamfaction )
    {
        case #"v":
            teamfaction = "vietcong";
            break;
        case #"n":
        case #"nva":
            teamfaction = "nva";
            break;
        case #"j":
            teamfaction = "japanese";
            break;
        case #"m":
            teamfaction = "marines";
            break;
        case #"s":
            teamfaction = "specops";
            break;
        case #"r":
            teamfaction = "russian";
            break;
        default:
            println( "<dev string:x7b>" );
            println( "<dev string:xb5>" + teamfaction + "<dev string:xcc>" );
            teamfaction = "marines";
            break;
    }
    
    switch ( team )
    {
        case #"x":
            team = "axis";
            break;
        case #"l":
            team = "allies";
            break;
        case #"r":
            team = "free";
            break;
        default:
            println( "<dev string:xce>" + team + "<dev string:xcc>" );
            team = "allies";
            break;
    }
    
    data = spawnstruct();
    data.team = team;
    data.owner = owner;
    data.bombsite = pos;
    data.yaw = yaw;
    direction = ( 0, yaw, 0 );
    data.direction = direction;
    data.flyheight = height;
    
    if ( type == "a" )
    {
        planehalfdistance = 12000;
        data.planehalfdistance = planehalfdistance;
        data.startpoint = pos + vectorscale( anglestoforward( direction ), -1 * planehalfdistance );
        data.endpoint = pos + vectorscale( anglestoforward( direction ), planehalfdistance );
        data.planemodel = "t5_veh_air_b52";
        data.flybysound = "null";
        data.washsound = "veh_b52_flyby_wash";
        data.apextime = 6145;
        data.exittype = -1;
        data.flyspeed = 2000;
        data.flytime = planehalfdistance * 2 / data.flyspeed;
        planetype = "airstrike";
        return;
    }
    
    if ( type == "n" )
    {
        planehalfdistance = 24000;
        data.planehalfdistance = planehalfdistance;
        data.startpoint = pos + vectorscale( anglestoforward( direction ), -1 * planehalfdistance );
        data.endpoint = pos + vectorscale( anglestoforward( direction ), planehalfdistance );
        data.planemodel = airsupport::getplanemodel( teamfaction );
        data.flybysound = "null";
        data.washsound = "evt_us_napalm_wash";
        data.apextime = 2362;
        data.exittype = exittype;
        data.flyspeed = 7000;
        data.flytime = planehalfdistance * 2 / data.flyspeed;
        planetype = "napalm";
        return;
    }
    
    /#
        println( "<dev string:x101>" );
        println( "<dev string:x102>" );
        println( type );
        println( "<dev string:x101>" );
    #/
    
    return;
}

// Namespace callback/callbacks
// Params 2
// Checksum 0x3b68127a, Offset: 0x1058
// Size: 0x14
function creating_corpse( localclientnum, player )
{
    
}

// Namespace callback/callbacks
// Params 7
// Checksum 0x21421f50, Offset: 0x1078
// Size: 0x92
function callback_stunned( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self.stunned = newval;
    println( "<dev string:x149>" );
    
    if ( newval )
    {
        self notify( #"stunned" );
        return;
    }
    
    self notify( #"not_stunned" );
}

// Namespace callback/callbacks
// Params 7
// Checksum 0xa7705784, Offset: 0x1118
// Size: 0x92
function callback_emp( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self.emp = newval;
    println( "<dev string:x15a>" );
    
    if ( newval )
    {
        self notify( #"emp" );
        return;
    }
    
    self notify( #"not_emp" );
}

// Namespace callback/callbacks
// Params 7
// Checksum 0xcd0c9cf6, Offset: 0x11b8
// Size: 0x4c
function callback_proximity( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self.enemyinproximity = newval;
}

