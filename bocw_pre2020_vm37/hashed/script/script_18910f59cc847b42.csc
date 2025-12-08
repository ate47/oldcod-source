#using script_18910f59cc847b42;
#using script_30c7fb449869910;
#using script_3314b730521b9666;
#using script_38635d174016f682;
#using script_42cbbdcd1e160063;
#using script_64e5d3ad71ce8140;
#using script_67049b48b589d81;
#using script_6b71c9befed901f2;
#using script_71603a58e2da0698;
#using script_75c3996cce8959f7;
#using script_76abb7986de59601;
#using script_77163d5a569e2071;
#using script_771f5bff431d8d57;
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

#namespace namespace_ac2a80f5;

// Namespace namespace_ac2a80f5/namespace_ac2a80f5
// Params 0
// Checksum 0x55e7a3, Offset: 0x118
// Size: 0x14
function init()
{
    function_32d5e898();
}

// Namespace namespace_ac2a80f5/namespace_ac2a80f5
// Params 1
// Checksum 0x5a6af9, Offset: 0x138
// Size: 0x94
function function_32d5e898( *localclientnum )
{
    var_b2b025b1 = getlocalplayers()[ 0 ];
    
    if ( isdefined( var_b2b025b1 ) )
    {
        var_b2b025b1.doa.cameramode = 1;
    }
    
    level.var_d63c863c = 700;
    function_278f20a3( ( 75, 0, 0 ), function_ccf8a968( 1 ) );
}

// Namespace namespace_ac2a80f5/namespace_ac2a80f5
// Params 3
// Checksum 0xc8cd45df, Offset: 0x1d8
// Size: 0x140
function function_278f20a3( angles, min_dist, max_dist = 0 )
{
    if ( isdefined( level.doa.var_72b899ad.var_67c3a8db ) )
    {
        angles = level.doa.var_72b899ad.var_67c3a8db;
    }
    
    if ( isdefined( angles ) )
    {
        vectornormalize( angles );
        level.doa.camera_angles = angles;
        level.var_5363dec = anglestoforward( angles ) * -1;
        level.var_80148cc8 = anglestoup( angles );
    }
    
    if ( min_dist < 1 )
    {
        min_dist = 1;
    }
    
    level.var_d63c863c = min_dist;
    level.var_4b4553db = max_dist;
    
    if ( !isdefined( level.var_2d592f5b ) )
    {
        level.var_2d592f5b = level.doa.camera_angles;
    }
}

// Namespace namespace_ac2a80f5/namespace_ac2a80f5
// Params 2
// Checksum 0x8233d3a2, Offset: 0x320
// Size: 0x94
function function_7dd474a0( *localclientnum, *delta_time )
{
    player = level.localplayers[ 0 ];
    cam_pos = player.origin + ( 0, 0, 600 );
    player camerasetposition( cam_pos );
    player camerasetlookat( level.doa.camera_angles );
}

// Namespace namespace_ac2a80f5/namespace_ac2a80f5
// Params 2
// Checksum 0xfff9e6ab, Offset: 0x3c0
// Size: 0xc78
function function_14f1aa2b( localclientnum, delta_time )
{
    if ( !isdefined( level.localplayers ) || level.localplayers.size == 0 )
    {
        return;
    }
    
    if ( level.localplayers.size > 1 )
    {
        if ( !isdefined( level.var_96de21f5 ) )
        {
            setsaveddvar( #"r_splitscreenexpandfull", 1 );
            level.var_96de21f5 = 1;
        }
    }
    
    mins = ( 1e+06, 1e+06, 1e+06 );
    maxs = ( -1e+06, -1e+06, -1e+06 );
    cameramode = 1;
    var_b2b025b1 = getlocalplayers()[ 0 ];
    
    if ( isdefined( var_b2b025b1 ) && isdefined( var_b2b025b1.doa ) )
    {
        cameramode = var_b2b025b1.doa.cameramode;
    }
    
    players = [];
    angles = level.doa.camera_angles;
    
    if ( cameramode >= 0 && cameramode <= 2 )
    {
        assert( level.localplayers.size == 1 );
        players = level.localplayers;
    }
    else if ( cameramode == 3 )
    {
        players = getplayers( localclientnum );
    }
    else if ( cameramode == 5 )
    {
        assert( isdefined( level.doa.var_b73cc08 ) );
        cam_pos = level.doa.var_b73cc08.origin;
        angles = level.doa.var_b73cc08.angles;
        
        foreach ( player in level.localplayers )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            player camerasetposition( cam_pos );
            player camerasetlookat( angles );
        }
        
        level.var_45c6f27d = cam_pos;
        level.var_2d592f5b = angles;
        return;
    }
    
    var_be529a4e = level.var_5363dec;
    var_7dd1941e = level.var_80148cc8;
    
    if ( level.localplayers.size == 1 )
    {
        playercenter = level.localplayers[ 0 ].origin;
        vehicle = getplayervehicle( level.localplayers[ 0 ] );
        
        if ( isdefined( vehicle ) )
        {
            playercenter = vehicle.origin;
        }
    }
    
    if ( cameramode == 3 )
    {
        if ( level.localplayers.size == 1 )
        {
            dirtocenter = level.doa.var_72b899ad.origin - level.localplayers[ 0 ].origin;
            playercenter = level.localplayers[ 0 ].origin + dirtocenter * 0.25;
        }
        else
        {
            foreach ( player in players )
            {
                if ( !isdefined( player ) )
                {
                    continue;
                }
                
                origin = player.origin;
                vehicle = getplayervehicle( player );
                
                if ( isdefined( vehicle ) )
                {
                    origin = vehicle.origin;
                }
                
                mins = function_2d9b1c4e( origin, mins );
                maxs = function_663f7227( origin, maxs );
            }
            
            mins = function_2d9b1c4e( level.doa.var_72b899ad.origin, mins );
            maxs = function_663f7227( level.doa.var_72b899ad.origin, maxs );
            dims = maxs - mins;
            playercenter = ( mins + maxs ) * 0.5;
        }
    }
    
    if ( is_true( level.var_fb0679ad ) )
    {
        center = mins + maxs;
        center *= 0.5;
        cam_pos = center;
        var_91e98520 = center;
        
        if ( players.size == 1 && isdefined( players[ 0 ] ) && isplayer( players[ 0 ] ) )
        {
            cam_pos = ( players[ 0 ].origin[ 0 ], players[ 0 ].origin[ 1 ], players[ 0 ].origin[ 2 ] );
            facing = anglestoforward( players[ 0 ] getplayerangles() );
            var_91e98520 = cam_pos + facing * ( 130 + abs( facing[ 0 ] * 30 ) ) + players[ 0 ] getvelocity() * 0.5;
        }
        
        if ( isdefined( level.var_145dec4f ) )
        {
            lerp_rate = 3;
            dir = var_91e98520 - level.var_145dec4f;
            
            if ( lengthsquared( dir ) < 1000000 )
            {
                var_91e98520 = level.var_145dec4f + dir * lerp_rate * delta_time;
                cam_pos = var_91e98520;
            }
        }
        
        level.var_145dec4f = var_91e98520;
    }
    
    cam_pos = playercenter;
    cam_pos += var_be529a4e * level.var_d63c863c;
    cam_pos += var_7dd1941e * -20;
    var_fa5416a8 = 0;
    
    if ( isdefined( dims ) )
    {
        var_8172ec08 = 200;
        var_cfa24a5 = 1800;
        var_5bdd9694 = abs( dims[ 1 ] );
        var_189a34e8 = 0;
        
        if ( var_5bdd9694 > var_8172ec08 )
        {
            var_189a34e8 = ( var_5bdd9694 - var_8172ec08 ) / ( var_cfa24a5 - var_8172ec08 );
        }
        
        var_5c03fa4 = 50;
        var_d946d37e = 500;
        var_49a6f227 = abs( dims[ 0 ] );
        var_2280804 = 0;
        
        if ( var_49a6f227 > var_5c03fa4 )
        {
            var_2280804 = ( var_49a6f227 - var_5c03fa4 ) / ( var_d946d37e - var_5c03fa4 );
            frac = math::clamp( var_2280804, 0, 1 );
            center_y = level.doa.var_72b899ad.origin[ 1 ];
            var_9fe93364 = cam_pos[ 1 ] + ( center_y - cam_pos[ 1 ] ) * frac;
            cam_pos = ( cam_pos[ 0 ], var_9fe93364, cam_pos[ 2 ] );
        }
        
        t = var_189a34e8;
        
        if ( var_2280804 > t )
        {
            t = var_2280804;
        }
        
        var_fa5416a8 = 400;
        
        if ( players.size > 1 && cameramode == 3 )
        {
            var_c9fdfd75 = 200;
            
            if ( !isdefined( level.var_6a822745 ) )
            {
                level.var_6a822745 = var_c9fdfd75;
            }
            
            var_fa5416a8 -= var_c9fdfd75;
            
            if ( t > 1 )
            {
                var_c9fdfd75 *= t;
            }
            
            level.var_6a822745 += ( var_c9fdfd75 - level.var_6a822745 ) * 3 * delta_time;
            cam_pos += var_be529a4e * var_c9fdfd75;
        }
        
        var_fa5416a8 *= t;
        var_fa5416a8 = math::clamp( var_fa5416a8, 0, 400 );
    }
    
    if ( !isdefined( level.var_fa5416a8 ) )
    {
        level.var_fa5416a8 = var_fa5416a8;
    }
    
    level.var_fa5416a8 += ( var_fa5416a8 - level.var_fa5416a8 ) * 2 * delta_time;
    cam_pos += var_be529a4e * level.var_fa5416a8;
    
    if ( isdefined( level.var_45c6f27d ) )
    {
        lerp_rate = 2;
        dir = cam_pos - level.var_45c6f27d;
        
        if ( lengthsquared( dir ) < 1000000 )
        {
            cam_pos = level.var_45c6f27d + dir * lerp_rate * delta_time;
        }
    }
    
    level.var_ca14ee83 = angles;
    
    if ( isdefined( level.var_2d592f5b ) )
    {
        lerp_rate = 3;
        dir = angles - level.var_2d592f5b;
        angles = level.var_2d592f5b + dir * lerp_rate * delta_time;
    }
    
    if ( cam_pos[ 2 ] > 3800 )
    {
        cam_pos = ( cam_pos[ 0 ], cam_pos[ 1 ], 3800 );
    }
    
    foreach ( player in level.localplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player camerasetposition( cam_pos );
        player camerasetlookat( angles );
    }
    
    level.var_45c6f27d = cam_pos;
    level.var_2d592f5b = angles;
}

// Namespace namespace_ac2a80f5/namespace_ac2a80f5
// Params 2
// Checksum 0x187ec869, Offset: 0x1040
// Size: 0xa4
function function_2d9b1c4e( vec, mins )
{
    if ( vec[ 0 ] < mins[ 0 ] )
    {
        mins = ( vec[ 0 ], mins[ 1 ], mins[ 2 ] );
    }
    
    if ( vec[ 1 ] < mins[ 1 ] )
    {
        mins = ( mins[ 0 ], vec[ 1 ], mins[ 2 ] );
    }
    
    if ( vec[ 2 ] < mins[ 2 ] )
    {
        mins = ( mins[ 0 ], mins[ 1 ], vec[ 2 ] );
    }
    
    return mins;
}

// Namespace namespace_ac2a80f5/namespace_ac2a80f5
// Params 2
// Checksum 0x7939c8b6, Offset: 0x10f0
// Size: 0xa4
function function_663f7227( vec, maxs )
{
    if ( vec[ 0 ] > maxs[ 0 ] )
    {
        maxs = ( vec[ 0 ], maxs[ 1 ], maxs[ 2 ] );
    }
    
    if ( vec[ 1 ] > maxs[ 1 ] )
    {
        maxs = ( maxs[ 0 ], vec[ 1 ], maxs[ 2 ] );
    }
    
    if ( vec[ 2 ] > maxs[ 2 ] )
    {
        maxs = ( maxs[ 0 ], maxs[ 1 ], vec[ 2 ] );
    }
    
    return maxs;
}

// Namespace namespace_ac2a80f5/namespace_ac2a80f5
// Params 2
// Checksum 0x6faed192, Offset: 0x11a0
// Size: 0x29c
function changecamera( *localclientnum, mode )
{
    self.doa.cameramode = mode;
    assert( isdefined( self.doa.cameramode ) );
    self cameraforcedisablescriptcam( 0 );
    
    if ( is_true( level.doa.var_dec041f5 ) )
    {
        self.doa.cameramode = 5;
    }
    else if ( isdefined( level.localplayers ) && level.localplayers.size > 1 )
    {
        self.doa.cameramode = 3;
    }
    else if ( self.doa.cameramode == 4 )
    {
        self cameraforcedisablescriptcam( 1 );
    }
    
    height = function_ccf8a968( self.doa.cameramode );
    
    if ( isdefined( level.doa.var_72b899ad.camera_max_height ) )
    {
        if ( height > level.doa.var_72b899ad.camera_max_height )
        {
            height = level.doa.var_72b899ad.camera_max_height;
        }
    }
    
    if ( isdefined( level.doa.var_72b899ad ) )
    {
        if ( is_true( level.doa.flipped ) )
        {
            function_278f20a3( level.doa.var_72b899ad.var_46f3a17d, height );
        }
        else
        {
            function_278f20a3( level.doa.var_72b899ad.var_13ea8aea, height );
        }
    }
    else
    {
        function_278f20a3( ( 75, 0, 0 ), height );
    }
    
    /#
        namespace_1e25ad94::debugmsg( "<dev string:x38>" + self getentitynumber() + "<dev string:x43>" + self.doa.cameramode );
    #/
}

// Namespace namespace_ac2a80f5/namespace_ac2a80f5
// Params 2
// Checksum 0x523e41ef, Offset: 0x1448
// Size: 0xdc
function function_1d5dc8d2( *localclientnum, var_545466e8 )
{
    if ( isdefined( level.doa.var_dbdc241e ) )
    {
        return level.doa.var_dbdc241e;
    }
    
    if ( level.localplayers.size == 1 )
    {
        var_545466e8++;
        var_c0547bf3 = 2;
        
        if ( level.doa.world_state == 0 )
        {
            var_c0547bf3 = 3;
        }
        
        if ( isdefined( level.doa.var_938e4f08 ) && level.doa.var_938e4f08 != 0 )
        {
            var_c0547bf3 = 2;
        }
        
        if ( var_545466e8 > var_c0547bf3 )
        {
            var_545466e8 = 0;
        }
        
        return var_545466e8;
    }
    
    return 3;
}

// Namespace namespace_ac2a80f5/namespace_ac2a80f5
// Params 1
// Checksum 0x94741f2e, Offset: 0x1530
// Size: 0xaa
function function_ccf8a968( var_545466e8 )
{
    if ( !isdefined( var_545466e8 ) )
    {
        return 700;
    }
    
    switch ( var_545466e8 )
    {
        case 0:
            return 400;
        case 1:
        case 3:
            return 700;
        case 2:
            return 1000;
        case 6:
            return 800;
        default:
            return 700;
    }
}

