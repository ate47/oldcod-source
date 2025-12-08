#using scripts/core_common/callbacks_shared;
#using scripts/core_common/challenges_shared;
#using scripts/core_common/damagefeedback_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/struct;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/weaponobjects;
#using scripts/core_common/weapons/weapons;
#using scripts/mp_common/util;

#namespace airsupport;

// Namespace airsupport/airsupport
// Params 0
// Checksum 0xb3c20777, Offset: 0x3e0
// Size: 0x1cc
function init()
{
    if ( !isdefined( level.airsupportheightscale ) )
    {
        level.airsupportheightscale = 1;
    }
    
    level.airsupportheightscale = getdvarint( "scr_airsupportHeightScale", level.airsupportheightscale );
    level.noflyzones = [];
    level.noflyzones = getentarray( "no_fly_zone", "targetname" );
    airsupport_heights = struct::get_array( "air_support_height", "targetname" );
    
    /#
        if ( airsupport_heights.size > 1 )
        {
            util::error( "Found more then one 'air_support_height' structs in the map" );
        }
    #/
    
    airsupport_heights = getentarray( "air_support_height", "targetname" );
    
    /#
        if ( airsupport_heights.size > 0 )
        {
            util::error( "Found an entity in the map with an 'air_support_height' targetname.  There should be only structs." );
        }
    #/
    
    heli_height_meshes = getentarray( "heli_height_lock", "classname" );
    
    /#
        if ( heli_height_meshes.size > 1 )
        {
            util::error( "Found more then one 'heli_height_lock' classname in the map" );
        }
    #/
    
    initrotatingrig();
    callback::on_spawned( &clearmonitoredspeed );
}

// Namespace airsupport/airsupport
// Params 2
// Checksum 0xae26e365, Offset: 0x5b8
// Size: 0x48
function finishhardpointlocationusage( location, usedcallback )
{
    self notify( #"used" );
    waitframe( 1 );
    
    if ( isdefined( usedcallback ) )
    {
        return self [[ usedcallback ]]( location );
    }
    
    return 1;
}

// Namespace airsupport/airsupport
// Params 3
// Checksum 0x70c31084, Offset: 0x608
// Size: 0x44
function finishdualhardpointlocationusage( locationstart, locationend, usedcallback )
{
    self notify( #"used" );
    waitframe( 1 );
    return self [[ usedcallback ]]( locationstart, locationend );
}

// Namespace airsupport/airsupport
// Params 0
// Checksum 0x4251806a, Offset: 0x658
// Size: 0x5e
function endselectionongameend()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"cancel_location" );
    self endon( #"used" );
    self endon( #"host_migration_begin" );
    level waittill( "game_ended" );
    self notify( #"game_ended" );
}

// Namespace airsupport/airsupport
// Params 0
// Checksum 0xc7cccc23, Offset: 0x6c0
// Size: 0x5e
function endselectiononhostmigration()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"cancel_location" );
    self endon( #"used" );
    self endon( #"game_ended" );
    level waittill( "host_migration_begin" );
    self notify( #"cancel_location" );
}

// Namespace airsupport/airsupport
// Params 0
// Checksum 0xf824db92, Offset: 0x728
// Size: 0x176
function endselectionthink()
{
    assert( isplayer( self ) );
    assert( isalive( self ) );
    assert( isdefined( self.selectinglocation ) );
    assert( self.selectinglocation == 1 );
    self thread endselectionongameend();
    self thread endselectiononhostmigration();
    event = self waittill( "death", "disconnect", "cancel_location", "game_ended", "used", "weapon_change", "emp_jammed" );
    
    if ( event._notify != "disconnect" )
    {
        self.selectinglocation = undefined;
        self thread clearuplocationselection();
    }
    
    if ( event._notify != "used" )
    {
        self notify( #"confirm_location" );
    }
}

// Namespace airsupport/airsupport
// Params 0
// Checksum 0x8acfd907, Offset: 0x8a8
// Size: 0x7c
function clearuplocationselection()
{
    event = self waittill( "death", "disconnect", "game_ended", "used", "weapon_change", "emp_jammed", "weapon_change_complete" );
    
    if ( event._notify != "disconnect" )
    {
        self endlocationselection();
    }
}

// Namespace airsupport/airsupport
// Params 1
// Checksum 0xb50e3e20, Offset: 0x930
// Size: 0x34
function stoploopsoundaftertime( time )
{
    self endon( #"death" );
    wait time;
    self stoploopsound( 2 );
}

// Namespace airsupport/airsupport
// Params 1
// Checksum 0xb51db24a, Offset: 0x970
// Size: 0x64
function calculatefalltime( flyheight )
{
    gravity = getdvarint( "bg_gravity" );
    time = sqrt( 2 * flyheight / gravity );
    return time;
}

// Namespace airsupport/airsupport
// Params 4
// Checksum 0x1cc6b833, Offset: 0x9e0
// Size: 0x92
function calculatereleasetime( flytime, flyheight, flyspeed, bombspeedscale )
{
    falltime = calculatefalltime( flyheight );
    bomb_x = flyspeed * bombspeedscale * falltime;
    release_time = bomb_x / flyspeed;
    return flytime * 0.5 - release_time;
}

// Namespace airsupport/airsupport
// Params 0
// Checksum 0x81776669, Offset: 0xa80
// Size: 0x126
function getminimumflyheight()
{
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

// Namespace airsupport/airsupport
// Params 1
// Checksum 0x1de7fe, Offset: 0xbb0
// Size: 0x404
function callstrike( flightplan )
{
    level.bomberdamagedents = [];
    level.bomberdamagedentscount = 0;
    level.bomberdamagedentsindex = 0;
    assert( flightplan.distance != 0, "callStrike can not be passed a zero fly distance" );
    planehalfdistance = flightplan.distance / 2;
    path = getstrikepath( flightplan.target, flightplan.height, planehalfdistance );
    startpoint = path[ "start" ];
    endpoint = path[ "end" ];
    flightplan.height = path[ "height" ];
    direction = path[ "direction" ];
    d = length( startpoint - endpoint );
    flytime = d / flightplan.speed;
    bombtime = calculatereleasetime( flytime, flightplan.height, flightplan.speed, flightplan.bombspeedscale );
    
    if ( bombtime < 0 )
    {
        bombtime = 0;
    }
    
    assert( flytime > bombtime );
    flightplan.owner endon( #"disconnect" );
    requireddeathcount = flightplan.owner.deathcount;
    side = vectorcross( anglestoforward( direction ), ( 0, 0, 1 ) );
    plane_seperation = 25;
    side_offset = vectorscale( side, plane_seperation );
    level thread planestrike( flightplan.owner, requireddeathcount, startpoint, endpoint, bombtime, flytime, flightplan.speed, flightplan.bombspeedscale, direction, flightplan.planespawncallback );
    wait flightplan.planespacing;
    level thread planestrike( flightplan.owner, requireddeathcount, startpoint + side_offset, endpoint + side_offset, bombtime, flytime, flightplan.speed, flightplan.bombspeedscale, direction, flightplan.planespawncallback );
    wait flightplan.planespacing;
    side_offset = vectorscale( side, -1 * plane_seperation );
    level thread planestrike( flightplan.owner, requireddeathcount, startpoint + side_offset, endpoint + side_offset, bombtime, flytime, flightplan.speed, flightplan.bombspeedscale, direction, flightplan.planespawncallback );
}

// Namespace airsupport/airsupport
// Params 10
// Checksum 0x5115bf31, Offset: 0xfc0
// Size: 0x14c
function planestrike( owner, requireddeathcount, pathstart, pathend, bombtime, flytime, flyspeed, bombspeedscale, direction, planespawnedfunction )
{
    if ( !isdefined( owner ) )
    {
        return;
    }
    
    plane = spawnplane( owner, "script_model", pathstart );
    plane.angles = direction;
    plane moveto( pathend, flytime, 0, 0 );
    thread debug_plane_line( flytime, flyspeed, pathstart, pathend );
    
    if ( isdefined( planespawnedfunction ) )
    {
        plane [[ planespawnedfunction ]]( owner, requireddeathcount, pathstart, pathend, bombtime, bombspeedscale, flytime, flyspeed );
    }
    
    wait flytime;
    plane notify( #"delete" );
    plane delete();
}

// Namespace airsupport/airsupport
// Params 2
// Checksum 0x94c19129, Offset: 0x1118
// Size: 0x8c
function determinegroundpoint( player, position )
{
    ground = ( position[ 0 ], position[ 1 ], player.origin[ 2 ] );
    trace = bullettrace( ground + ( 0, 0, 10000 ), ground, 0, undefined );
    return trace[ "position" ];
}

// Namespace airsupport/airsupport
// Params 2
// Checksum 0x496562de, Offset: 0x11b0
// Size: 0x4a
function determinetargetpoint( player, position )
{
    point = determinegroundpoint( player, position );
    return clamptarget( point );
}

// Namespace airsupport/airsupport
// Params 0
// Checksum 0xa149c3f0, Offset: 0x1208
// Size: 0x1a
function getmintargetheight()
{
    return level.spawnmins[ 2 ] - 500;
}

// Namespace airsupport/airsupport
// Params 0
// Checksum 0x4f2df946, Offset: 0x1230
// Size: 0x1a
function getmaxtargetheight()
{
    return level.spawnmaxs[ 2 ] + 500;
}

// Namespace airsupport/airsupport
// Params 1
// Checksum 0xd7caf8f3, Offset: 0x1258
// Size: 0x94
function clamptarget( target )
{
    min = getmintargetheight();
    max = getmaxtargetheight();
    
    if ( target[ 2 ] < min )
    {
        target[ 2 ] = min;
    }
    
    if ( target[ 2 ] > max )
    {
        target[ 2 ] = max;
    }
    
    return target;
}

// Namespace airsupport/airsupport
// Params 4
// Checksum 0x34c41cec, Offset: 0x12f8
// Size: 0x8e, Type: bool
function _insidecylinder( point, base, radius, height )
{
    if ( isdefined( height ) )
    {
        if ( point[ 2 ] > base[ 2 ] + height )
        {
            return false;
        }
    }
    
    dist = distance2d( point, base );
    
    if ( dist < radius )
    {
        return true;
    }
    
    return false;
}

// Namespace airsupport/airsupport
// Params 3
// Checksum 0x64d89db9, Offset: 0x1390
// Size: 0xa2, Type: bool
function _insidenoflyzonebyindex( point, index, disregardheight )
{
    height = level.noflyzones[ index ].height;
    
    if ( isdefined( disregardheight ) )
    {
        height = undefined;
    }
    
    return _insidecylinder( point, level.noflyzones[ index ].origin, level.noflyzones[ index ].radius, height );
}

// Namespace airsupport/airsupport
// Params 1
// Checksum 0x1fa1753d, Offset: 0x1440
// Size: 0x10c
function getnoflyzoneheight( point )
{
    height = point[ 2 ];
    origin = undefined;
    
    for ( i = 0; i < level.noflyzones.size ; i++ )
    {
        if ( _insidenoflyzonebyindex( point, i ) )
        {
            if ( height < level.noflyzones[ i ].height )
            {
                height = level.noflyzones[ i ].height;
                origin = level.noflyzones[ i ].origin;
            }
        }
    }
    
    if ( !isdefined( origin ) )
    {
        return point[ 2 ];
    }
    
    return origin[ 2 ] + height;
}

// Namespace airsupport/airsupport
// Params 2
// Checksum 0xcc6b76b3, Offset: 0x1558
// Size: 0x8e
function insidenoflyzones( point, disregardheight )
{
    noflyzones = [];
    
    for ( i = 0; i < level.noflyzones.size ; i++ )
    {
        if ( _insidenoflyzonebyindex( point, i, disregardheight ) )
        {
            noflyzones[ noflyzones.size ] = i;
        }
    }
    
    return noflyzones;
}

// Namespace airsupport/airsupport
// Params 2
// Checksum 0xf4c694ab, Offset: 0x15f0
// Size: 0x172
function crossesnoflyzone( start, end )
{
    for ( i = 0; i < level.noflyzones.size ; i++ )
    {
        point = math::closest_point_on_line( level.noflyzones[ i ].origin + ( 0, 0, 0.5 * level.noflyzones[ i ].height ), start, end );
        dist = distance2d( point, level.noflyzones[ i ].origin );
        
        if ( point[ 2 ] > level.noflyzones[ i ].origin[ 2 ] + level.noflyzones[ i ].height )
        {
            continue;
        }
        
        if ( dist < level.noflyzones[ i ].radius )
        {
            return i;
        }
    }
    
    return undefined;
}

// Namespace airsupport/airsupport
// Params 2
// Checksum 0x6f1fd68c, Offset: 0x1770
// Size: 0x160
function crossesnoflyzones( start, end )
{
    zones = [];
    
    for ( i = 0; i < level.noflyzones.size ; i++ )
    {
        point = math::closest_point_on_line( level.noflyzones[ i ].origin, start, end );
        dist = distance2d( point, level.noflyzones[ i ].origin );
        
        if ( point[ 2 ] > level.noflyzones[ i ].origin[ 2 ] + level.noflyzones[ i ].height )
        {
            continue;
        }
        
        if ( dist < level.noflyzones[ i ].radius )
        {
            zones[ zones.size ] = i;
        }
    }
    
    return zones;
}

// Namespace airsupport/airsupport
// Params 3
// Checksum 0x5ba4ddb1, Offset: 0x18d8
// Size: 0x14e
function getnoflyzoneheightcrossed( start, end, minheight )
{
    height = minheight;
    
    for ( i = 0; i < level.noflyzones.size ; i++ )
    {
        point = math::closest_point_on_line( level.noflyzones[ i ].origin, start, end );
        dist = distance2d( point, level.noflyzones[ i ].origin );
        
        if ( dist < level.noflyzones[ i ].radius )
        {
            if ( height < level.noflyzones[ i ].height )
            {
                height = level.noflyzones[ i ].height;
            }
        }
    }
    
    return height;
}

// Namespace airsupport/airsupport
// Params 2
// Checksum 0x457fda81, Offset: 0x1a30
// Size: 0x7a, Type: bool
function _shouldignorenoflyzone( noflyzone, noflyzones )
{
    if ( !isdefined( noflyzone ) )
    {
        return true;
    }
    
    for ( i = 0; i < noflyzones.size ; i++ )
    {
        if ( isdefined( noflyzones[ i ] ) && noflyzones[ i ] == noflyzone )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace airsupport/airsupport
// Params 3
// Checksum 0xcb5b5c4d, Offset: 0x1ab8
// Size: 0x6e, Type: bool
function _shouldignorestartgoalnoflyzone( noflyzone, startnoflyzones, goalnoflyzones )
{
    if ( !isdefined( noflyzone ) )
    {
        return true;
    }
    
    if ( _shouldignorenoflyzone( noflyzone, startnoflyzones ) )
    {
        return true;
    }
    
    if ( _shouldignorenoflyzone( noflyzone, goalnoflyzones ) )
    {
        return true;
    }
    
    return false;
}

// Namespace airsupport/airsupport
// Params 2
// Checksum 0xcd655089, Offset: 0x1b30
// Size: 0x118
function gethelipath( start, goal )
{
    startnoflyzones = insidenoflyzones( start, 1 );
    thread debug_line( start, goal, ( 1, 1, 1 ) );
    goalnoflyzones = insidenoflyzones( goal );
    
    if ( goalnoflyzones.size )
    {
        goal = ( goal[ 0 ], goal[ 1 ], getnoflyzoneheight( goal ) );
    }
    
    goal_points = calculatepath( start, goal, startnoflyzones, goalnoflyzones );
    
    if ( !isdefined( goal_points ) )
    {
        return undefined;
    }
    
    assert( goal_points.size >= 1 );
    return goal_points;
}

// Namespace airsupport/airsupport
// Params 3
// Checksum 0xfd12f512, Offset: 0x1c50
// Size: 0x116
function followpath( path, donenotify, stopatgoal )
{
    for ( i = 0; i < path.size - 1 ; i++ )
    {
        self setvehgoalpos( path[ i ], 0 );
        thread debug_line( self.origin, path[ i ], ( 1, 1, 0 ) );
        self waittill( "goal" );
    }
    
    self setvehgoalpos( path[ path.size - 1 ], stopatgoal );
    thread debug_line( self.origin, path[ i ], ( 1, 1, 0 ) );
    self waittill( "goal" );
    
    if ( isdefined( donenotify ) )
    {
        self notify( donenotify );
    }
}

// Namespace airsupport/airsupport
// Params 3
// Checksum 0x5d03116f, Offset: 0x1d70
// Size: 0xac
function setgoalposition( goal, donenotify, stopatgoal )
{
    if ( !isdefined( stopatgoal ) )
    {
        stopatgoal = 1;
    }
    
    start = self.origin;
    goal_points = gethelipath( start, goal );
    
    if ( !isdefined( goal_points ) )
    {
        goal_points = [];
        goal_points[ 0 ] = goal;
    }
    
    followpath( goal_points, donenotify, stopatgoal );
}

// Namespace airsupport/airsupport
// Params 4
// Checksum 0xba46abe, Offset: 0x1e28
// Size: 0xa0, Type: bool
function clearpath( start, end, startnoflyzone, goalnoflyzone )
{
    noflyzones = crossesnoflyzones( start, end );
    
    for ( i = 0; i < noflyzones.size ; i++ )
    {
        if ( !_shouldignorestartgoalnoflyzone( noflyzones[ i ], startnoflyzone, goalnoflyzone ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace airsupport/airsupport
// Params 2
// Checksum 0xca9282cb, Offset: 0x1ed0
// Size: 0x56
function append_array( dst, src )
{
    for ( i = 0; i < src.size ; i++ )
    {
        dst[ dst.size ] = src[ i ];
    }
}

// Namespace airsupport/airsupport
// Params 6
// Checksum 0xe287a586, Offset: 0x1f30
// Size: 0x102
function calculatepath_r( start, end, points, startnoflyzones, goalnoflyzones, depth )
{
    depth--;
    
    if ( depth <= 0 )
    {
        points[ points.size ] = end;
        return points;
    }
    
    noflyzones = crossesnoflyzones( start, end );
    
    for ( i = 0; i < noflyzones.size ; i++ )
    {
        noflyzone = noflyzones[ i ];
        
        if ( !_shouldignorestartgoalnoflyzone( noflyzone, startnoflyzones, goalnoflyzones ) )
        {
            return undefined;
        }
    }
    
    points[ points.size ] = end;
    return points;
}

// Namespace airsupport/airsupport
// Params 4
// Checksum 0xebdd93b0, Offset: 0x2040
// Size: 0x172
function calculatepath( start, end, startnoflyzones, goalnoflyzones )
{
    points = [];
    points = calculatepath_r( start, end, points, startnoflyzones, goalnoflyzones, 3 );
    
    if ( !isdefined( points ) )
    {
        return undefined;
    }
    
    assert( points.size >= 1 );
    debug_sphere( points[ points.size - 1 ], 10, ( 1, 0, 0 ), 1, 1000 );
    point = start;
    
    for ( i = 0; i < points.size ; i++ )
    {
        thread debug_line( point, points[ i ], ( 0, 1, 0 ) );
        debug_sphere( points[ i ], 10, ( 0, 0, 1 ), 1, 1000 );
        point = points[ i ];
    }
    
    return points;
}

// Namespace airsupport/airsupport
// Params 3
// Checksum 0x54dff1cb, Offset: 0x21c0
// Size: 0x1ba
function _getstrikepathstartandend( goal, yaw, halfdistance )
{
    direction = ( 0, yaw, 0 );
    startpoint = goal + vectorscale( anglestoforward( direction ), -1 * halfdistance );
    endpoint = goal + vectorscale( anglestoforward( direction ), halfdistance );
    noflyzone = crossesnoflyzone( startpoint, endpoint );
    path = [];
    
    if ( isdefined( noflyzone ) )
    {
        path[ "noFlyZone" ] = noflyzone;
        startpoint = ( startpoint[ 0 ], startpoint[ 1 ], level.noflyzones[ noflyzone ].origin[ 2 ] + level.noflyzones[ noflyzone ].height );
        endpoint = ( endpoint[ 0 ], endpoint[ 1 ], startpoint[ 2 ] );
    }
    else
    {
        path[ "noFlyZone" ] = undefined;
    }
    
    path[ "start" ] = startpoint;
    path[ "end" ] = endpoint;
    path[ "direction" ] = direction;
    return path;
}

// Namespace airsupport/airsupport
// Params 4
// Checksum 0x6cc802c, Offset: 0x2388
// Size: 0x18a
function getstrikepath( target, height, halfdistance, yaw )
{
    noflyzoneheight = getnoflyzoneheight( target );
    worldheight = target[ 2 ] + height;
    
    if ( noflyzoneheight > worldheight )
    {
        worldheight = noflyzoneheight;
    }
    
    goal = ( target[ 0 ], target[ 1 ], worldheight );
    path = [];
    
    if ( !isdefined( yaw ) || yaw != "random" )
    {
        for ( i = 0; i < 3 ; i++ )
        {
            path = _getstrikepathstartandend( goal, randomint( 360 ), halfdistance );
            
            if ( !isdefined( path[ "noFlyZone" ] ) )
            {
                break;
            }
        }
    }
    else
    {
        path = _getstrikepathstartandend( goal, yaw, halfdistance );
    }
    
    path[ "height" ] = worldheight - target[ 2 ];
    return path;
}

// Namespace airsupport/airsupport
// Params 5
// Checksum 0xdac5be6a, Offset: 0x2520
// Size: 0x74
function doglassdamage( pos, radius, max, min, mod )
{
    wait randomfloatrange( 0.05, 0.15 );
    glassradiusdamage( pos, radius, max, min, mod );
}

// Namespace airsupport/airsupport
// Params 7
// Checksum 0xfd0aa20b, Offset: 0x25a0
// Size: 0x418, Type: bool
function entlosradiusdamage( ent, pos, radius, max, min, owner, einflictor )
{
    dist = distance( pos, ent.damagecenter );
    
    if ( ent.isplayer || ent.isactor )
    {
        assumed_ceiling_height = 800;
        eye_position = ent.entity geteye();
        head_height = eye_position[ 2 ];
        debug_display_time = 4000;
        trace = weapons::damage_trace( ent.entity.origin, ent.entity.origin + ( 0, 0, assumed_ceiling_height ), 0, undefined );
        indoors = trace[ "fraction" ] != 1;
        
        if ( indoors )
        {
            test_point = trace[ "position" ];
            debug_star( test_point, ( 0, 1, 0 ), debug_display_time );
            trace = weapons::damage_trace( ( test_point[ 0 ], test_point[ 1 ], head_height ), ( pos[ 0 ], pos[ 1 ], head_height ), 0, undefined );
            indoors = trace[ "fraction" ] != 1;
            
            if ( indoors )
            {
                debug_star( ( pos[ 0 ], pos[ 1 ], head_height ), ( 0, 1, 0 ), debug_display_time );
                dist *= 4;
                
                if ( dist > radius )
                {
                    return false;
                }
            }
            else
            {
                debug_star( ( pos[ 0 ], pos[ 1 ], head_height ), ( 1, 0, 0 ), debug_display_time );
                trace = weapons::damage_trace( ( pos[ 0 ], pos[ 1 ], head_height ), pos, 0, undefined );
                indoors = trace[ "fraction" ] != 1;
                
                if ( indoors )
                {
                    debug_star( pos, ( 0, 1, 0 ), debug_display_time );
                    dist *= 4;
                    
                    if ( dist > radius )
                    {
                        return false;
                    }
                }
                else
                {
                    debug_star( pos, ( 1, 0, 0 ), debug_display_time );
                }
            }
        }
        else
        {
            debug_star( ent.entity.origin + ( 0, 0, assumed_ceiling_height ), ( 1, 0, 0 ), debug_display_time );
        }
    }
    
    ent.damage = int( max + ( min - max ) * dist / radius );
    ent.pos = pos;
    ent.damageowner = owner;
    ent.einflictor = einflictor;
    return true;
}

// Namespace airsupport/airsupport
// Params 0
// Checksum 0x67bf11c5, Offset: 0x29c0
// Size: 0x70
function getmapcenter()
{
    minimaporigins = getentarray( "minimap_corner", "targetname" );
    
    if ( minimaporigins.size )
    {
        return math::find_box_center( minimaporigins[ 0 ].origin, minimaporigins[ 1 ].origin );
    }
    
    return ( 0, 0, 0 );
}

// Namespace airsupport/airsupport
// Params 4
// Checksum 0x3004eae9, Offset: 0x2a38
// Size: 0x216
function getrandommappoint( x_offset, y_offset, map_x_percentage, map_y_percentage )
{
    minimaporigins = getentarray( "minimap_corner", "targetname" );
    
    if ( minimaporigins.size )
    {
        rand_x = 0;
        rand_y = 0;
        
        if ( minimaporigins[ 0 ].origin[ 0 ] < minimaporigins[ 1 ].origin[ 0 ] )
        {
            rand_x = randomfloatrange( minimaporigins[ 0 ].origin[ 0 ] * map_x_percentage, minimaporigins[ 1 ].origin[ 0 ] * map_x_percentage );
            rand_y = randomfloatrange( minimaporigins[ 0 ].origin[ 1 ] * map_y_percentage, minimaporigins[ 1 ].origin[ 1 ] * map_y_percentage );
        }
        else
        {
            rand_x = randomfloatrange( minimaporigins[ 1 ].origin[ 0 ] * map_x_percentage, minimaporigins[ 0 ].origin[ 0 ] * map_x_percentage );
            rand_y = randomfloatrange( minimaporigins[ 1 ].origin[ 1 ] * map_y_percentage, minimaporigins[ 0 ].origin[ 1 ] * map_y_percentage );
        }
        
        return ( x_offset + rand_x, y_offset + rand_y, 0 );
    }
    
    return ( x_offset, y_offset, 0 );
}

// Namespace airsupport/airsupport
// Params 0
// Checksum 0x614e9462, Offset: 0x2c58
// Size: 0xf6
function getmaxmapwidth()
{
    minimaporigins = getentarray( "minimap_corner", "targetname" );
    
    if ( minimaporigins.size )
    {
        x = abs( minimaporigins[ 0 ].origin[ 0 ] - minimaporigins[ 1 ].origin[ 0 ] );
        y = abs( minimaporigins[ 0 ].origin[ 1 ] - minimaporigins[ 1 ].origin[ 1 ] );
        return max( x, y );
    }
    
    return 0;
}

// Namespace airsupport/airsupport
// Params 0
// Checksum 0x4c30545f, Offset: 0x2d58
// Size: 0x12c
function initrotatingrig()
{
    level.airsupport_rotator = spawn( "script_model", getmapcenter() + ( isdefined( level.rotator_x_offset ) ? level.rotator_x_offset : 0, isdefined( level.rotator_y_offset ) ? level.rotator_y_offset : 0, 1200 ) );
    level.airsupport_rotator setmodel( "tag_origin" );
    level.airsupport_rotator.angles = ( 0, 115, 0 );
    level.airsupport_rotator hide();
    level.airsupport_rotator thread rotaterig();
    level.airsupport_rotator thread swayrig();
}

// Namespace airsupport/airsupport
// Params 0
// Checksum 0xca117506, Offset: 0x2e90
// Size: 0x2e
function rotaterig()
{
    for ( ;; )
    {
        self rotateyaw( -360, 60 );
        wait 60;
    }
}

// Namespace airsupport/airsupport
// Params 0
// Checksum 0xae323ab4, Offset: 0x2ec8
// Size: 0x11e
function swayrig()
{
    centerorigin = self.origin;
    
    for ( ;; )
    {
        z = randomintrange( -200, -100 );
        time = randomintrange( 3, 6 );
        self moveto( centerorigin + ( 0, 0, z ), time, 1, 1 );
        wait time;
        z = randomintrange( 100, 200 );
        time = randomintrange( 3, 6 );
        self moveto( centerorigin + ( 0, 0, z ), time, 1, 1 );
        wait time;
    }
}

// Namespace airsupport/airsupport
// Params 1
// Checksum 0xd1cf453d, Offset: 0x2ff0
// Size: 0x34
function stoprotation( time )
{
    self endon( #"death" );
    wait time;
    self stoploopsound();
}

// Namespace airsupport/airsupport
// Params 1
// Checksum 0x17bbe1d5, Offset: 0x3030
// Size: 0xce
function flattenyaw( goal )
{
    self endon( #"death" );
    increment = 3;
    
    if ( self.angles[ 1 ] > goal )
    {
        increment *= -1;
    }
    
    while ( abs( self.angles[ 1 ] - goal ) > 3 )
    {
        self.angles = ( self.angles[ 0 ], self.angles[ 1 ] + increment, self.angles[ 2 ] );
        waitframe( 1 );
    }
}

// Namespace airsupport/airsupport
// Params 0
// Checksum 0x475984b, Offset: 0x3108
// Size: 0x72
function flattenroll()
{
    self endon( #"death" );
    
    while ( self.angles[ 2 ] < 0 )
    {
        self.angles = ( self.angles[ 0 ], self.angles[ 1 ], self.angles[ 2 ] + 2.5 );
        waitframe( 1 );
    }
}

// Namespace airsupport/airsupport
// Params 1
// Checksum 0x33bad7ce, Offset: 0x3188
// Size: 0x2ba
function leave( duration )
{
    self unlink();
    self thread stoprotation( 1 );
    tries = 10;
    yaw = 0;
    
    while ( tries > 0 )
    {
        exitvector = anglestoforward( self.angles + ( 0, yaw, 0 ) ) * 20000;
        exitpoint = ( self.origin[ 0 ] + exitvector[ 0 ], self.origin[ 1 ] + exitvector[ 1 ], self.origin[ 2 ] - 2500 );
        exitpoint = self.origin + exitvector;
        nfz = crossesnoflyzone( self.origin, exitpoint );
        
        if ( isdefined( nfz ) )
        {
            if ( tries != 1 )
            {
                if ( tries % 2 == 1 )
                {
                    yaw *= -1;
                }
                else
                {
                    yaw += 10;
                    yaw *= -1;
                }
            }
            
            tries--;
            continue;
        }
        
        tries = 0;
    }
    
    self thread flattenyaw( self.angles[ 1 ] + yaw );
    
    if ( self.angles[ 2 ] != 0 )
    {
        self thread flattenroll();
    }
    
    if ( isvehicle( self ) )
    {
        self setspeed( length( exitvector ) / duration / 17.6, 60 );
        self setvehgoalpos( exitpoint, 0, 0 );
    }
    else
    {
        self moveto( exitpoint, duration, 0, 0 );
    }
    
    self notify( #"leaving" );
}

// Namespace airsupport/airsupport
// Params 0
// Checksum 0x678b02c9, Offset: 0x3450
// Size: 0x1f4
function getrandomhelicopterstartorigin()
{
    dist = -1 * getdvarint( "scr_supplydropIncomingDistance", 10000 );
    pathrandomness = 100;
    direction = ( 0, randomintrange( -2, 3 ), 0 );
    start_origin = anglestoforward( direction ) * dist;
    start_origin += ( ( randomfloat( 2 ) - 1 ) * pathrandomness, ( randomfloat( 2 ) - 1 ) * pathrandomness, 0 );
    
    /#
        if ( getdvarint( "scr_noflyzones_debug", 0 ) )
        {
            if ( level.noflyzones.size )
            {
                index = randomintrange( 0, level.noflyzones.size );
                delta = level.noflyzones[ index ].origin;
                delta = ( delta[ 0 ] + randomint( 10 ), delta[ 1 ] + randomint( 10 ), 0 );
                delta = vectornormalize( delta );
                start_origin = delta * dist;
            }
        }
    #/
    
    return start_origin;
}

/#

    // Namespace airsupport/airsupport
    // Params 0
    // Checksum 0xbeaf548c, Offset: 0x3650
    // Size: 0xa6, Type: dev
    function debug_no_fly_zones()
    {
        for ( i = 0; i < level.noflyzones.size ; i++ )
        {
            debug_airsupport_cylinder( level.noflyzones[ i ].origin, level.noflyzones[ i ].radius, level.noflyzones[ i ].height, ( 1, 1, 1 ), undefined, 5000 );
        }
    }

#/

// Namespace airsupport/airsupport
// Params 4
// Checksum 0x4512ab2b, Offset: 0x3700
// Size: 0xc6
function debug_plane_line( flytime, flyspeed, pathstart, pathend )
{
    thread debug_line( pathstart, pathend, ( 1, 1, 1 ) );
    delta = vectornormalize( pathend - pathstart );
    
    for ( i = 0; i < flytime ; i++ )
    {
        thread debug_star( pathstart + vectorscale( delta, i * flyspeed ), ( 1, 0, 0 ) );
    }
}

// Namespace airsupport/airsupport
// Params 1
// Checksum 0x613c56b, Offset: 0x37d0
// Size: 0x9c
function debug_draw_bomb_explosion( prevpos )
{
    self notify( #"draw_explosion" );
    waitframe( 1 );
    self endon( #"draw_explosion" );
    waitresult = self waittill( "projectile_impact" );
    thread debug_line( prevpos, waitresult.position, ( 0.5, 1, 0 ) );
    thread debug_star( waitresult.position, ( 1, 0, 0 ) );
}

/#

    // Namespace airsupport/airsupport
    // Params 3
    // Checksum 0x465230f8, Offset: 0x3878
    // Size: 0x128, Type: dev
    function debug_draw_bomb_path( projectile, color, time )
    {
        self endon( #"death" );
        level.airsupport_debug = getdvarint( "scr_airsupport_debug", 0 );
        
        if ( !isdefined( color ) )
        {
            color = ( 0.5, 1, 0 );
        }
        
        if ( isdefined( level.airsupport_debug ) && level.airsupport_debug == 1 )
        {
            prevpos = self.origin;
            
            while ( isdefined( self.origin ) )
            {
                thread debug_line( prevpos, self.origin, color, time );
                prevpos = self.origin;
                
                if ( isdefined( projectile ) && projectile )
                {
                    thread debug_draw_bomb_explosion( prevpos );
                }
                
                wait 0.2;
            }
        }
    }

    // Namespace airsupport/airsupport
    // Params 4
    // Checksum 0xc0525a38, Offset: 0x39a8
    // Size: 0xe4, Type: dev
    function debug_print3d_simple( message, ent, offset, frames )
    {
        level.airsupport_debug = getdvarint( "scr_airsupport_debug", 0 );
        
        if ( isdefined( level.airsupport_debug ) && level.airsupport_debug == 1 )
        {
            if ( isdefined( frames ) )
            {
                thread draw_text( message, ( 0.8, 0.8, 0.8 ), ent, offset, frames );
                return;
            }
            
            thread draw_text( message, ( 0.8, 0.8, 0.8 ), ent, offset, 0 );
        }
    }

    // Namespace airsupport/airsupport
    // Params 5
    // Checksum 0xa1bbda38, Offset: 0x3a98
    // Size: 0x114, Type: dev
    function draw_text( msg, color, ent, offset, frames )
    {
        if ( frames == 0 )
        {
            while ( isdefined( ent ) && isdefined( ent.origin ) )
            {
                print3d( ent.origin + offset, msg, color, 0.5, 4 );
                waitframe( 1 );
            }
            
            return;
        }
        
        for ( i = 0; i < frames ; i++ )
        {
            if ( !isdefined( ent ) )
            {
                break;
            }
            
            print3d( ent.origin + offset, msg, color, 0.5, 4 );
            waitframe( 1 );
        }
    }

    // Namespace airsupport/airsupport
    // Params 5
    // Checksum 0xf7d15f79, Offset: 0x3bb8
    // Size: 0xac, Type: dev
    function debug_print3d( message, color, ent, origin_offset, frames )
    {
        level.airsupport_debug = getdvarint( "scr_airsupport_debug", 0 );
        
        if ( isdefined( level.airsupport_debug ) && level.airsupport_debug == 1 )
        {
            self thread draw_text( message, color, ent, origin_offset, frames );
        }
    }

#/

// Namespace airsupport/airsupport
// Params 5
// Checksum 0x1686d150, Offset: 0x3c70
// Size: 0xfc
function debug_line( from, to, color, time, depthtest )
{
    /#
        level.airsupport_debug = getdvarint( "scr_airsupport_debug", 0 );
        
        if ( isdefined( level.airsupport_debug ) && level.airsupport_debug == 1 )
        {
            if ( distancesquared( from, to ) < 0.01 )
            {
                return;
            }
            
            if ( !isdefined( time ) )
            {
                time = 1000;
            }
            
            if ( !isdefined( depthtest ) )
            {
                depthtest = 1;
            }
            
            line( from, to, color, 1, depthtest, time );
        }
    #/
}

// Namespace airsupport/airsupport
// Params 3
// Checksum 0xc4ca3494, Offset: 0x3d78
// Size: 0xb4
function debug_star( origin, color, time )
{
    /#
        level.airsupport_debug = getdvarint( "scr_airsupport_debug", 0 );
        
        if ( isdefined( level.airsupport_debug ) && level.airsupport_debug == 1 )
        {
            if ( !isdefined( time ) )
            {
                time = 1000;
            }
            
            if ( !isdefined( color ) )
            {
                color = ( 1, 1, 1 );
            }
            
            debugstar( origin, time, color );
        }
    #/
}

/#

    // Namespace airsupport/airsupport
    // Params 4
    // Checksum 0xafc2289c, Offset: 0x3e38
    // Size: 0xc4, Type: dev
    function debug_circle( origin, radius, color, time )
    {
        level.airsupport_debug = getdvarint( "scr_airsupport_debug", 0 );
        
        if ( isdefined( level.airsupport_debug ) && level.airsupport_debug == 1 )
        {
            if ( !isdefined( time ) )
            {
                time = 1000;
            }
            
            if ( !isdefined( color ) )
            {
                color = ( 1, 1, 1 );
            }
            
            circle( origin, radius, color, 1, 1, time );
        }
    }

#/

// Namespace airsupport/airsupport
// Params 5
// Checksum 0x233783dd, Offset: 0x3f08
// Size: 0x114
function debug_sphere( origin, radius, color, alpha, time )
{
    /#
        level.airsupport_debug = getdvarint( "scr_airsupport_debug", 0 );
        
        if ( isdefined( level.airsupport_debug ) && level.airsupport_debug == 1 )
        {
            if ( !isdefined( time ) )
            {
                time = 1000;
            }
            
            if ( !isdefined( color ) )
            {
                color = ( 1, 1, 1 );
            }
            
            sides = int( 10 * ( 1 + int( radius / 100 ) ) );
            sphere( origin, radius, color, alpha, 1, sides, time );
        }
    #/
}

/#

    // Namespace airsupport/airsupport
    // Params 6
    // Checksum 0x5fcb102a, Offset: 0x4028
    // Size: 0xac, Type: dev
    function debug_airsupport_cylinder( origin, radius, height, color, mustrenderheight, time )
    {
        level.airsupport_debug = getdvarint( "scr_airsupport_debug", 0 );
        
        if ( isdefined( level.airsupport_debug ) && level.airsupport_debug == 1 )
        {
            debug_cylinder( origin, radius, height, color, mustrenderheight, time );
        }
    }

    // Namespace airsupport/airsupport
    // Params 6
    // Checksum 0xcd4a3936, Offset: 0x40e0
    // Size: 0x14c, Type: dev
    function debug_cylinder( origin, radius, height, color, mustrenderheight, time )
    {
        subdivision = 600;
        
        if ( !isdefined( time ) )
        {
            time = 1000;
        }
        
        if ( !isdefined( color ) )
        {
            color = ( 1, 1, 1 );
        }
        
        count = height / subdivision;
        
        for ( i = 0; i < count ; i++ )
        {
            point = origin + ( 0, 0, i * subdivision );
            circle( point, radius, color, 1, 1, time );
        }
        
        if ( isdefined( mustrenderheight ) )
        {
            point = origin + ( 0, 0, mustrenderheight );
            circle( point, radius, color, 1, 1, time );
        }
    }

#/

// Namespace airsupport/airsupport
// Params 3
// Checksum 0xec769628, Offset: 0x4238
// Size: 0xa2
function getpointonline( startpoint, endpoint, ratio )
{
    nextpoint = ( startpoint[ 0 ] + ( endpoint[ 0 ] - startpoint[ 0 ] ) * ratio, startpoint[ 1 ] + ( endpoint[ 1 ] - startpoint[ 1 ] ) * ratio, startpoint[ 2 ] + ( endpoint[ 2 ] - startpoint[ 2 ] ) * ratio );
    return nextpoint;
}

// Namespace airsupport/airsupport
// Params 0
// Checksum 0x79ff8270, Offset: 0x42e8
// Size: 0x80, Type: bool
function cantargetplayerwithspecialty()
{
    if ( isdefined( self.specialty_nottargetedbyairsupport ) && ( self hasperk( "specialty_nottargetedbyairsupport" ) || self.specialty_nottargetedbyairsupport ) )
    {
        if ( !isdefined( self.nottargettedai_underminspeedtimer ) || self.nottargettedai_underminspeedtimer < getdvarint( "perk_nottargetedbyai_graceperiod" ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace airsupport/airsupport
// Params 1
// Checksum 0x8dd91074, Offset: 0x4370
// Size: 0x1aa
function monitorspeed( spawnprotectiontime )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    
    if ( self hasperk( "specialty_nottargetedbyairsupport" ) == 0 )
    {
        return;
    }
    
    getdvarstring( "perk_nottargetted_graceperiod" );
    graceperiod = getdvarint( "perk_nottargetedbyai_graceperiod" );
    minspeed = getdvarint( "perk_nottargetedbyai_min_speed" );
    minspeedsq = minspeed * minspeed;
    waitperiod = 0.25;
    waitperiodmilliseconds = waitperiod * 1000;
    
    if ( minspeedsq == 0 )
    {
        return;
    }
    
    self.nottargettedai_underminspeedtimer = 0;
    
    if ( isdefined( spawnprotectiontime ) )
    {
        wait spawnprotectiontime;
    }
    
    while ( true )
    {
        velocity = self getvelocity();
        speedsq = lengthsquared( velocity );
        
        if ( speedsq < minspeedsq )
        {
            self.nottargettedai_underminspeedtimer += waitperiodmilliseconds;
        }
        else
        {
            self.nottargettedai_underminspeedtimer = 0;
        }
        
        wait waitperiod;
    }
}

// Namespace airsupport/airsupport
// Params 0
// Checksum 0x16b145a5, Offset: 0x4528
// Size: 0x20
function clearmonitoredspeed()
{
    if ( isdefined( self.nottargettedai_underminspeedtimer ) )
    {
        self.nottargettedai_underminspeedtimer = 0;
    }
}

