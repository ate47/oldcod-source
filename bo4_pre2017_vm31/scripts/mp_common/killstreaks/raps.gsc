#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/challenges_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/influencers_shared;
#using scripts/core_common/killstreaks_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/vehicle_ai_shared;
#using scripts/core_common/vehicle_shared;
#using scripts/core_common/vehicles/raps;
#using scripts/core_common/weapons/smokegrenade;
#using scripts/mp_common/gametypes/battlechatter;
#using scripts/mp_common/gametypes/globallogic_audio;
#using scripts/mp_common/killstreaks/airsupport;
#using scripts/mp_common/killstreaks/helicopter;
#using scripts/mp_common/killstreaks/killstreak_bundles;
#using scripts/mp_common/killstreaks/killstreak_detect;
#using scripts/mp_common/killstreaks/killstreak_hacking;
#using scripts/mp_common/killstreaks/killstreakrules;
#using scripts/mp_common/killstreaks/killstreaks;
#using scripts/mp_common/teams/teams;

#namespace raps_mp;

// Namespace raps_mp/raps
// Params 0
// Checksum 0xbd53fc77, Offset: 0x928
// Size: 0x2c6
function init()
{
    level.raps_settings = struct::get_script_bundle( "vehiclecustomsettings", "rapssettings_mp" );
    assert( isdefined( level.raps_settings ) );
    level.raps = [];
    level.raps_helicopters = [];
    level.raps_force_get_enemies = &forcegetenemies;
    killstreaks::register( "raps", "raps", "killstreak_raps", "raps_used", &activaterapskillstreak, 1 );
    killstreaks::register_strings( "raps", &"KILLSTREAK_EARNED_RAPS", &"KILLSTREAK_RAPS_NOT_AVAILABLE", &"KILLSTREAK_RAPS_INBOUND", undefined, &"KILLSTREAK_RAPS_HACKED" );
    killstreaks::register_dialog( "raps", "mpl_killstreak_raps", "rapsHelicopterDialogBundle", "rapsHelicopterPilotDialogBundle", "friendlyRaps", "enemyRaps", "enemyRapsMultiple", "friendlyRapsHacked", "enemyRapsHacked", "requestRaps", "threatRaps" );
    killstreaks::allow_assists( "raps", 1 );
    killstreaks::register_dev_debug_dvar( "raps" );
    killstreak_bundles::register_killstreak_bundle( "raps_drone" );
    inithelicopterpositions();
    callback::on_connect( &onplayerconnect );
    clientfield::register( "vehicle", "monitor_raps_drop_landing", 1, 1, "int" );
    clientfield::register( "vehicle", "raps_heli_low_health", 1, 1, "int" );
    clientfield::register( "vehicle", "raps_heli_extra_low_health", 1, 1, "int" );
    level.raps_helicopter_drop_tag_names = [];
    level.raps_helicopter_drop_tag_names[ 0 ] = "tag_raps_drop_left";
    level.raps_helicopter_drop_tag_names[ 1 ] = "tag_raps_drop_right";
}

// Namespace raps_mp/raps
// Params 0
// Checksum 0x6dad821e, Offset: 0xbf8
// Size: 0xb6
function onplayerconnect()
{
    self.entnum = self getentitynumber();
    level.raps[ self.entnum ] = spawnstruct();
    level.raps[ self.entnum ].killstreak_id = -1;
    level.raps[ self.entnum ].raps = [];
    level.raps[ self.entnum ].helicopter = undefined;
}

// Namespace raps_mp/raps
// Params 0
// Checksum 0xcf3a8610, Offset: 0xcb8
// Size: 0x78
function rapshelicopterdynamicavoidance()
{
    level endon( #"game_ended" );
    index_to_update = 0;
    
    while ( true )
    {
        rapshelicopterdynamicavoidanceupdate( index_to_update );
        index_to_update++;
        
        if ( index_to_update >= level.raps_helicopters.size )
        {
            index_to_update = 0;
        }
        
        wait 0.05;
    }
}

// Namespace raps_mp/raps
// Params 1
// Checksum 0xae588c49, Offset: 0xd38
// Size: 0xa9c
function rapshelicopterdynamicavoidanceupdate( index_to_update )
{
    helicopterreforigin = ( 0, 0, 0 );
    otherhelicopterreforigin = ( 0, 0, 0 );
    arrayremovevalue( level.raps_helicopters, undefined );
    
    if ( index_to_update >= level.raps_helicopters.size )
    {
        index_to_update = 0;
    }
    
    if ( level.raps_helicopters.size >= 2 )
    {
        helicopter = level.raps_helicopters[ index_to_update ];
        
        /#
            helicopter.__action_just_made = 0;
        #/
        
        for ( i = 0; i < level.raps_helicopters.size ; i++ )
        {
            if ( i == index_to_update )
            {
                continue;
            }
            
            if ( helicopter.droppingraps )
            {
                continue;
            }
            
            if ( !isdefined( helicopter.lastnewgoaltime ) )
            {
                helicopter.lastnewgoaltime = gettime();
            }
            
            helicopterforward = anglestoforward( helicopter getangles() );
            helicopterreforigin = helicopter.origin + helicopterforward * 500;
            otherhelicopterforward = anglestoforward( level.raps_helicopters[ i ] getangles() );
            otherhelicopterreforigin = level.raps_helicopters[ i ].origin + otherhelicopterforward * 100;
            deltatoother = otherhelicopterreforigin - helicopterreforigin;
            otherinfront = vectordot( helicopterforward, vectornormalize( deltatoother ) ) > 0.707;
            distancesqr = distance2dsquared( helicopterreforigin, otherhelicopterreforigin );
            
            if ( ( distancesqr < ( 200 + 1200 ) * ( 200 + 1200 ) || helicopter getspeed() == 0 ) && gettime() - helicopter.lastnewgoaltime > 5000 )
            {
                /#
                    helicopter.__last_dynamic_avoidance_action = 20;
                #/
                
                /#
                    helicopter.__action_just_made = 1;
                #/
                
                helicopter updatehelicopterspeed();
                
                if ( helicopter.isleaving )
                {
                    self.leavelocation = getrandomhelicopterleaveorigin( 0, self.origin );
                    helicopter setvehgoalpos( self.leavelocation, 0 );
                }
                else
                {
                    self.targetdroplocation = getrandomhelicopterposition( self.lastdroplocation );
                    helicopter setvehgoalpos( self.targetdroplocation, 1 );
                }
                
                helicopter.lastnewgoaltime = gettime();
                continue;
            }
            
            if ( distancesqr < 1200 * 1200 && otherinfront && gettime() - helicopter.laststoptime > 500 )
            {
                /#
                    helicopter.__last_dynamic_avoidance_action = 10;
                #/
                
                /#
                    helicopter.__action_just_made = 1;
                #/
                
                helicopter stophelicopter();
                continue;
            }
            
            if ( helicopter getspeed() == 0 && otherinfront && distancesqr < 1200 * 1200 )
            {
                /#
                    helicopter.__last_dynamic_avoidance_action = 50;
                #/
                
                /#
                    helicopter.__action_just_made = 1;
                #/
                
                delta = otherhelicopterreforigin - helicopterreforigin;
                newgoalposition = helicopter.origin - ( deltatoother[ 0 ] * randomfloatrange( 0.7, 2.5 ), deltatoother[ 1 ] * randomfloatrange( 0.7, 2.5 ), 0 );
                helicopter updatehelicopterspeed();
                helicopter setvehgoalpos( newgoalposition, 0 );
                
                if ( 1 || gettime() - helicopter.lastnewgoaltime > 5000 )
                {
                    /#
                        helicopter.__last_dynamic_avoidance_action = 51;
                    #/
                    
                    helicopter.targetdroplocation = getclosestrandomhelicopterposition( newgoalposition, 8 );
                    helicopter.lastnewgoaltime = gettime();
                }
                
                continue;
            }
            
            if ( distancesqr < ( 1000 + 200 + 1200 ) * ( 1000 + 200 + 1200 ) && helicopter.drivemodespeedscale == 1 )
            {
                /#
                    helicopter.__last_dynamic_avoidance_action = otherinfront ? 31 : 30;
                #/
                
                /#
                    helicopter.__action_just_made = 1;
                #/
                
                helicopter updatehelicopterspeed( otherinfront ? 2 : 1 );
                continue;
            }
            
            if ( distancesqr >= ( 1000 + 200 + 1200 ) * ( 1000 + 200 + 1200 ) && helicopter.drivemodespeedscale < 1 )
            {
                /#
                    helicopter.__last_dynamic_avoidance_action = 40;
                #/
                
                /#
                    helicopter.__action_just_made = 1;
                #/
                
                helicopter updatehelicopterspeed( 0 );
                continue;
            }
            
            if ( helicopter getspeed() == 0 && gettime() - helicopter.laststoptime > 500 )
            {
                helicopter updatehelicopterspeed();
            }
        }
        
        /#
            if ( getdvarint( "scr_raps_helav_debug" ) )
            {
                if ( isdefined( helicopter ) )
                {
                    server_frames_to_persist = int( 0.05 * 2 / 0.05 );
                    sphere( helicopterreforigin, 10, ( 0, 0, 1 ), 1, 0, 10, server_frames_to_persist );
                    sphere( otherhelicopterreforigin, 10, ( 1, 0, 0 ), 1, 0, 10, server_frames_to_persist );
                    circle( helicopterreforigin, 1000 + 200 + 1200, ( 1, 1, 0 ), 1, 1, server_frames_to_persist );
                    circle( helicopterreforigin, 200 + 1200, ( 0, 0, 0 ), 1, 1, server_frames_to_persist );
                    circle( helicopterreforigin, 1200, ( 1, 0, 0 ), 1, 1, server_frames_to_persist );
                    print3d( helicopter.origin, "Speed: " + int( helicopter getspeedmph() ), ( 1, 1, 1 ), 1, 2.5, server_frames_to_persist );
                    action_debug_color = ( 0.8, 0.8, 0.8 );
                    debug_action_string = "";
                    
                    if ( helicopter.__action_just_made )
                    {
                        action_debug_color = ( 0, 1, 0 );
                    }
                    
                    switch ( helicopter.__last_dynamic_avoidance_action )
                    {
                        case 0:
                            break;
                        case 10:
                            debug_action_string = "stop";
                            break;
                        case 20:
                            debug_action_string = "new goal";
                            break;
                        case 30:
                            debug_action_string = "cautious";
                            break;
                        case 31:
                            debug_action_string = "more cautious";
                            break;
                        case 40:
                            debug_action_string = "expedient";
                            break;
                        case 50:
                            debug_action_string = "back off";
                            break;
                        case 51:
                            debug_action_string = "back off + new goal";
                            break;
                        default:
                            debug_action_string = "unknown action";
                            break;
                    }
                    
                    print3d( helicopter.origin + ( 0, 0, -50 ), debug_action_string, action_debug_color, 1, 2.5, server_frames_to_persist );
                }
            }
        #/
    }
}

// Namespace raps_mp/raps
// Params 1
// Checksum 0x3bc6485c, Offset: 0x17e0
// Size: 0x3b8, Type: bool
function activaterapskillstreak( hardpointtype )
{
    player = self;
    
    if ( !player killstreakrules::iskillstreakallowed( "raps", player.team ) )
    {
        return false;
    }
    
    if ( game.raps_helicopter_positions.size <= 0 )
    {
        /#
            iprintlnbold( "RAPS helicopter position error, check NavMesh." );
        #/
        
        self iprintlnbold( &"KILLSTREAK_RAPS_NOT_AVAILABLE" );
        return false;
    }
    
    killstreakid = player killstreakrules::killstreakstart( "raps", player.team );
    
    if ( killstreakid == -1 )
    {
        player iprintlnbold( &"KILLSTREAK_RAPS_NOT_AVAILABLE" );
        return false;
    }
    
    player thread teams::waituntilteamchange( player, &onteamchanged, player.entnum, "raps_complete" );
    level thread watchrapskillstreakend( killstreakid, player.entnum, player.team );
    helicopter = player spawnrapshelicopter( killstreakid );
    helicopter.killstreakid = killstreakid;
    player killstreaks::play_killstreak_start_dialog( "raps", player.team, killstreakid );
    player addweaponstat( getweapon( "raps" ), "used", 1 );
    helicopter killstreaks::play_pilot_dialog_on_owner( "arrive", "raps", killstreakid );
    level.raps[ player.entnum ].helicopter = helicopter;
    
    if ( !isdefined( level.raps_helicopters ) )
    {
        level.raps_helicopters = [];
    }
    else if ( !isarray( level.raps_helicopters ) )
    {
        level.raps_helicopters = array( level.raps_helicopters );
    }
    
    level.raps_helicopters[ level.raps_helicopters.size ] = level.raps[ player.entnum ].helicopter;
    level thread updatekillstreakonhelicopterdeath( level.raps[ player.entnum ].helicopter, player.entnum );
    
    /#
        if ( getdvarint( "scr_raps_debug_auto_reactivate" ) )
        {
            level thread autoreactivaterapskillstreak( player.entnum, player, hardpointtype );
        }
    #/
    
    return true;
}

/#

    // Namespace raps_mp/raps
    // Params 3
    // Checksum 0x374bc6f, Offset: 0x1ba0
    // Size: 0xa2, Type: dev
    function autoreactivaterapskillstreak( ownerentnum, player, hardpointtype )
    {
        while ( true )
        {
            level waittill( "raps_updated_" + ownerentnum );
            
            if ( isdefined( level.raps[ ownerentnum ].helicopter ) )
            {
                continue;
            }
            
            wait randomfloatrange( 2, 5 );
            player thread activaterapskillstreak( hardpointtype );
            return;
        }
    }

#/

// Namespace raps_mp/raps
// Params 3
// Checksum 0x90e7411b, Offset: 0x1c50
// Size: 0x8a
function watchrapskillstreakend( killstreakid, ownerentnum, team )
{
    while ( true )
    {
        level waittill( "raps_updated_" + ownerentnum );
        
        if ( isdefined( level.raps[ ownerentnum ].helicopter ) )
        {
            continue;
        }
        
        killstreakrules::killstreakstop( "raps", team, killstreakid );
        return;
    }
}

// Namespace raps_mp/raps
// Params 2
// Checksum 0xb413d587, Offset: 0x1ce8
// Size: 0x3a
function updatekillstreakonhelicopterdeath( helicopter, ownerentenum )
{
    helicopter waittill( "death" );
    level notify( "raps_updated_" + ownerentenum );
}

// Namespace raps_mp/raps
// Params 2
// Checksum 0xb23dc201, Offset: 0x1d30
// Size: 0x44
function onteamchanged( entnum, event )
{
    abandoned = 1;
    destroyallraps( entnum, abandoned );
}

// Namespace raps_mp/raps
// Params 2
// Checksum 0x6507d667, Offset: 0x1d80
// Size: 0x2c
function onemp( attacker, ownerentnum )
{
    destroyallraps( ownerentnum );
}

// Namespace raps_mp/raps
// Params 2
// Checksum 0x554cadd4, Offset: 0x1db8
// Size: 0x44
function novehiclefacethread( mapcenter, radius )
{
    level endon( #"game_ended" );
    wait 3;
    marknovehiclenavmeshfaces( mapcenter, radius, 21 );
}

// Namespace raps_mp/raps
// Params 0
// Checksum 0x7c13dc72, Offset: 0x1e08
// Size: 0x105a
function inithelicopterpositions()
{
    startsearchpoint = airsupport::getmapcenter();
    mapcenter = getclosestpointonnavmesh( startsearchpoint, 1024 );
    
    if ( !isdefined( mapcenter ) )
    {
        startsearchpoint = ( startsearchpoint[ 0 ], startsearchpoint[ 1 ], 0 );
    }
    
    remaining_attempts = 10;
    
    while ( !isdefined( mapcenter ) && remaining_attempts > 0 )
    {
        startsearchpoint += ( 100, 100, 0 );
        mapcenter = getclosestpointonnavmesh( startsearchpoint, 1024 );
        remaining_attempts -= 1;
    }
    
    if ( !isdefined( mapcenter ) )
    {
        mapcenter = airsupport::getmapcenter();
    }
    
    radius = airsupport::getmaxmapwidth();
    
    if ( radius < 1 )
    {
        radius = 1;
    }
    
    if ( isdefined( game.raps_helicopter_positions ) )
    {
        return;
    }
    
    lots_of_height = 1024;
    randomnavmeshpoints = util::positionquery_pointarray( mapcenter, 0, radius * 3, lots_of_height, 132 );
    
    if ( randomnavmeshpoints.size == 0 )
    {
        mapcenter = ( 0, 0, 39 );
        randomnavmeshpoints = util::positionquery_pointarray( mapcenter, 0, radius, 70, 132 );
    }
    
    /#
        position_query_drop_location_count = randomnavmeshpoints.size;
    #/
    
    if ( isdefined( level.add_raps_drop_locations ) )
    {
        [[ level.add_raps_drop_locations ]]( randomnavmeshpoints );
    }
    
    /#
        if ( getdvarint( "scr_raps_nav_point_trace_debug" ) )
        {
            boxhalfwidth = 220 * 0.25;
            
            for ( i = position_query_drop_location_count; i < randomnavmeshpoints.size ; i++ )
            {
                box( randomnavmeshpoints[ i ], ( boxhalfwidth * -1, boxhalfwidth * -1, 0 ), ( boxhalfwidth, boxhalfwidth, 8.88 ), 0, ( 1, 0.53, 0 ), 0.9, 0, 9999999 );
            }
        }
    #/
    
    omit_locations = [];
    
    if ( isdefined( level.add_raps_omit_locations ) )
    {
        [[ level.add_raps_omit_locations ]]( omit_locations );
    }
    
    /#
        if ( getdvarint( "scr_raps_nav_point_trace_debug" ) )
        {
            debug_radius = 220 * 0.5;
            
            foreach ( omit_location in omit_locations )
            {
                circle( omit_location, debug_radius, ( 0.05, 0.05, 0.05 ), 0, 1, 9999999 );
                circle( omit_location + ( 0, 0, 4 ), debug_radius, ( 0.05, 0.05, 0.05 ), 0, 1, 9999999 );
                circle( omit_location + ( 0, 0, 8 ), debug_radius, ( 0.05, 0.05, 0.05 ), 0, 1, 9999999 );
            }
        }
    #/
    
    game.raps_helicopter_positions = [];
    minflyheight = int( airsupport::getminimumflyheight() + 1000 );
    test_point_radius = 12;
    fit_radius = 220 * 0.5;
    fit_radius_corner = fit_radius * 0.7071;
    omit_radius = 220 * 0.5;
    
    foreach ( point in randomnavmeshpoints )
    {
        start_water_trace = point + ( 0, 0, 6 );
        stop_water_trace = point + ( 0, 0, 8 );
        trace = physicstrace( start_water_trace, stop_water_trace, ( -2, -2, -2 ), ( 2, 2, 2 ), undefined, 4 );
        
        if ( trace[ "fraction" ] < 1 )
        {
            /#
                if ( getdvarint( "scr_raps_nav_point_trace_debug" ) )
                {
                    debugboxwidth = 220 * 0.5;
                    debugboxheight = 10;
                    box( start_water_trace, ( debugboxwidth * -1, debugboxwidth * -1, 0 ), ( debugboxwidth, debugboxwidth, debugboxheight ), 0, ( 0, 0, 1 ), 0.9, 0, 9999999 );
                    box( start_water_trace, ( -2, -2, -2 ), ( 2, 2, 2 ), 0, ( 0, 0, 1 ), 0.9, 0, 9999999 );
                }
            #/
            
            continue;
        }
        
        should_omit = 0;
        
        foreach ( omit_location in omit_locations )
        {
            if ( distancesquared( omit_location, point ) < omit_radius * omit_radius )
            {
                should_omit = 1;
                
                /#
                    if ( getdvarint( "scr_raps_nav_point_trace_debug" ) )
                    {
                        debugboxwidth = 220 * 0.5;
                        debugboxheight = 10;
                        box( point, ( debugboxwidth * -1, debugboxwidth * -1, 0 ), ( debugboxwidth, debugboxwidth, debugboxheight ), 0, ( 0.05, 0.05, 0.05 ), 1, 0, 9999999 );
                    }
                #/
                
                break;
            }
        }
        
        if ( should_omit )
        {
            continue;
        }
        
        randomtestpoints = util::positionquery_pointarray( point, 0, 128, lots_of_height, test_point_radius );
        max_attempts = 12;
        point_added = 0;
        
        for ( i = 0; !point_added && i < max_attempts && i < randomtestpoints.size ; i++ )
        {
            test_point = randomtestpoints[ i ];
            can_fit_on_nav_mesh = ispointonnavmesh( test_point + ( 0, fit_radius, 0 ), 0 ) && ispointonnavmesh( test_point + ( 0, fit_radius * -1, 0 ), 0 ) && ispointonnavmesh( test_point + ( fit_radius, 0, 0 ), 0 ) && ispointonnavmesh( test_point + ( fit_radius * -1, 0, 0 ), 0 ) && ispointonnavmesh( test_point + ( fit_radius_corner, fit_radius_corner, 0 ), 0 ) && ispointonnavmesh( test_point + ( fit_radius_corner, fit_radius_corner * -1, 0 ), 0 ) && ispointonnavmesh( test_point + ( fit_radius_corner * -1, fit_radius_corner, 0 ), 0 ) && ispointonnavmesh( test_point + ( fit_radius_corner * -1, fit_radius_corner * -1, 0 ), 0 );
            
            if ( can_fit_on_nav_mesh )
            {
                point_added = tryaddpointforhelicopterposition( test_point, minflyheight );
            }
        }
    }
    
    if ( game.raps_helicopter_positions.size == 0 )
    {
        /#
            iprintlnbold( "Error Finding Valid RAPS Helicopter Positions, Using Default Random NavMesh Points" );
        #/
        
        game.raps_helicopter_positions = randomnavmeshpoints;
    }
    
    flood_fill_start_point = undefined;
    flood_fill_start_point_distance_squared = 9999999;
    
    foreach ( point in game.raps_helicopter_positions )
    {
        if ( !isdefined( point ) )
        {
            continue;
        }
        
        distance_squared = distancesquared( point, mapcenter );
        
        if ( distance_squared < flood_fill_start_point_distance_squared )
        {
            flood_fill_start_point_distance_squared = distance_squared;
            flood_fill_start_point = point;
        }
    }
    
    if ( !isdefined( flood_fill_start_point ) )
    {
        flood_fill_start_point = mapcenter;
    }
    
    level thread novehiclefacethread( flood_fill_start_point, radius * 2 );
    force_debug_draw = 0;
    
    /#
        if ( killstreaks::should_draw_debug( "raps" ) || force_debug_draw )
        {
            time = 9999999;
            sphere( mapcenter, 20, ( 1, 1, 0 ), 1, 0, 10, time );
            circle( mapcenter, airsupport::getmaxmapwidth(), ( 0, 1, 0 ), 1, 1, time );
            box( mapcenter, ( -4, -4, 0 ), ( 4, 4, 5000 ), 0, ( 1, 1, 0 ), 0.6, 0, time );
            sphere( flood_fill_start_point, 20, ( 0, 1, 1 ), 1, 0, 10, time );
            box( flood_fill_start_point, ( -4, -4, 0 ), ( 4, 4, 4200 ), 0, ( 0, 1, 1 ), 0.6, 0, time );
            
            foreach ( point in randomnavmeshpoints )
            {
                sphere( point + ( 0, 0, 950 ), 10, ( 0, 0, 1 ), 1, 0, 10, time );
                circle( point, 128, ( 1, 0, 0 ), 1, 1, time );
            }
            
            foreach ( point in game.raps_helicopter_positions )
            {
                sphere( point + ( 0, 0, 1000 ), 10, ( 0, 1, 0 ), 1, 0, 10, time );
                circle( point + ( 0, 0, 2 ), 128, ( 0, 1, 0 ), 1, 1, time );
                airsupport::debug_cylinder( point, 8, 1000, ( 0, 0.8, 0 ), 16, time );
                box( point, ( -4, -4, 0 ), ( 4, 4, 1000 ), 0, ( 0, 0.7, 0 ), 0.6, 0, time );
                halfboxwidth = 220 * 0.5;
                box( point, ( halfboxwidth * -1, halfboxwidth * -1, 2 ), ( halfboxwidth, halfboxwidth, 300 ), 0, ( 0, 0, 0.6 ), 0.6, 0, time );
            }
        }
    #/
}

// Namespace raps_mp/raps
// Params 2
// Checksum 0xed0ef247, Offset: 0x2e70
// Size: 0xfe, Type: bool
function tryaddpointforhelicopterposition( spaciouspoint, minflyheight )
{
    traceheight = minflyheight + 500;
    traceboxhalfwidth = 220 * 0.5;
    
    if ( istracesafeforrapsdronedropfromhelicopter( spaciouspoint, traceheight, traceboxhalfwidth ) )
    {
        if ( !isdefined( game.raps_helicopter_positions ) )
        {
            game.raps_helicopter_positions = [];
        }
        else if ( !isarray( game.raps_helicopter_positions ) )
        {
            game.raps_helicopter_positions = array( game.raps_helicopter_positions );
        }
        
        game.raps_helicopter_positions[ game.raps_helicopter_positions.size ] = spaciouspoint;
        return true;
    }
    
    return false;
}

// Namespace raps_mp/raps
// Params 3
// Checksum 0x282565b4, Offset: 0x2f78
// Size: 0x208, Type: bool
function istracesafeforrapsdronedropfromhelicopter( spaciouspoint, traceheight, traceboxhalfwidth )
{
    start = ( spaciouspoint[ 0 ], spaciouspoint[ 1 ], traceheight );
    end = ( spaciouspoint[ 0 ], spaciouspoint[ 1 ], spaciouspoint[ 2 ] + 36 );
    trace = physicstrace( start, end, ( traceboxhalfwidth * -1, traceboxhalfwidth * -1, 0 ), ( traceboxhalfwidth, traceboxhalfwidth, traceboxhalfwidth * 2 ), undefined, 1 );
    
    /#
        if ( getdvarint( "scr_raps_nav_point_trace_debug" ) )
        {
            if ( trace[ "fraction" ] < 1 )
            {
                box( end, ( traceboxhalfwidth * -1, traceboxhalfwidth * -1, 0 ), ( traceboxhalfwidth, traceboxhalfwidth, ( start[ 2 ] - end[ 2 ] ) * ( 1 - trace[ "fraction" ] ) ), 0, ( 1, 0, 0 ), 0.6, 0, 9999999 );
            }
            else
            {
                box( end, ( traceboxhalfwidth * -1, traceboxhalfwidth * -1, 0 ), ( traceboxhalfwidth, traceboxhalfwidth, 8.88 ), 0, ( 0, 1, 0 ), 0.6, 0, 9999999 );
            }
        }
    #/
    
    return trace[ "fraction" ] == 1 && trace[ "surfacetype" ] == "none";
}

// Namespace raps_mp/raps
// Params 2
// Checksum 0x4c0df25e, Offset: 0x3188
// Size: 0x52
function getrandomhelicopterstartorigin( fly_height, firstdroplocation )
{
    best_node = helicopter::getvalidrandomstartnode( firstdroplocation );
    return best_node.origin + ( 0, 0, fly_height );
}

// Namespace raps_mp/raps
// Params 2
// Checksum 0x9e23a754, Offset: 0x31e8
// Size: 0x52
function getrandomhelicopterleaveorigin( fly_height, startlocationtoleavefrom )
{
    best_node = helicopter::getvalidrandomleavenode( startlocationtoleavefrom );
    return best_node.origin + ( 0, 0, fly_height );
}

// Namespace raps_mp/raps
// Params 0
// Checksum 0xa63e0f1a, Offset: 0x3248
// Size: 0x124
function getinitialhelicopterflyheight()
{
    arrayremovevalue( level.raps_helicopters, undefined );
    minimum_fly_height = airsupport::getminimumflyheight();
    
    if ( level.raps_helicopters.size > 0 )
    {
        already_assigned_height = level.raps_helicopters[ 0 ].assigned_fly_height;
        
        if ( already_assigned_height == minimum_fly_height + int( airsupport::getminimumflyheight() + 1000 ) )
        {
            return ( minimum_fly_height + int( airsupport::getminimumflyheight() + 1000 ) + 400 );
        }
    }
    
    return minimum_fly_height + int( airsupport::getminimumflyheight() + 1000 );
}

// Namespace raps_mp/raps
// Params 2
// Checksum 0x7369d74e, Offset: 0x3378
// Size: 0x54
function configurechopperteampost( owner, ishacked )
{
    helicopter = self;
    helicopter thread watchownerdisconnect( owner );
    helicopter thread createrapshelicopterinfluencer();
}

// Namespace raps_mp/raps
// Params 1
// Checksum 0x9e680520, Offset: 0x33d8
// Size: 0x4e8
function spawnrapshelicopter( killstreakid )
{
    player = self;
    assigned_fly_height = getinitialhelicopterflyheight();
    prepickeddroplocation = picknextdroplocation( undefined, 0, player.origin, assigned_fly_height );
    spawnorigin = getrandomhelicopterstartorigin( 0, prepickeddroplocation );
    helicopter = spawnhelicopter( player, spawnorigin, ( 0, 0, 0 ), "heli_raps_mp", "veh_t7_mil_vtol_dropship_raps" );
    helicopter.prepickeddroplocation = prepickeddroplocation;
    helicopter.assigned_fly_height = assigned_fly_height;
    helicopter killstreaks::configure_team( "raps", killstreakid, player, undefined, undefined, &configurechopperteampost );
    helicopter killstreak_hacking::enable_hacking( "raps" );
    helicopter.droppingraps = 0;
    helicopter.isleaving = 0;
    helicopter.droppedraps = 0;
    helicopter.drivemodespeedscale = 3;
    helicopter.drivemodeaccel = 20 * 5;
    helicopter.drivemodedecel = 20 * 5;
    helicopter.laststoptime = 0;
    helicopter.targetdroplocation = ( -1e+07, -1e+07, -1e+07 );
    helicopter.lastdroplocation = ( -1e+07, -1e+07, -1e+07 );
    helicopter.firstdropreferencepoint = ( player.origin[ 0 ], player.origin[ 1 ], int( airsupport::getminimumflyheight() + 1000 ) );
    
    /#
        helicopter.__last_dynamic_avoidance_action = 0;
    #/
    
    helicopter clientfield::set( "enemyvehicle", 1 );
    helicopter.health = 99999999;
    helicopter.maxhealth = killstreak_bundles::get_max_health( "raps" );
    helicopter.lowhealth = killstreak_bundles::get_low_health( "raps" );
    helicopter.extra_low_health = helicopter.lowhealth * 0.5;
    helicopter.extra_low_health_callback = &onextralowhealth;
    helicopter setcandamage( 1 );
    helicopter thread killstreaks::monitordamage( "raps", helicopter.maxhealth, &ondeath, helicopter.lowhealth, &onlowhealth, 0, undefined, 1 );
    helicopter.rocketdamage = helicopter.maxhealth / 4 + 1;
    helicopter.remotemissiledamage = helicopter.maxhealth / 1 + 1;
    helicopter.hackertooldamage = helicopter.maxhealth / 2 + 1;
    helicopter.detonateviaemp = &raps::detonate_damage_monitored;
    target_set( helicopter, ( 0, 0, 100 ) );
    helicopter setdrawinfrared( 1 );
    helicopter thread waitforhelicoptershutdown();
    helicopter thread helicopterthink();
    helicopter thread watchgameended();
    
    /#
        helicopter thread helicopterthinkdebugvisitall();
    #/
    
    return helicopter;
}

// Namespace raps_mp/raps
// Params 0
// Checksum 0xc3b6690, Offset: 0x38c8
// Size: 0x2ac
function waitforhelicoptershutdown()
{
    helicopter = self;
    waitresult = helicopter waittill( "raps_helicopter_shutdown" );
    killed = waitresult.is_killed;
    level notify( "raps_updated_" + helicopter.ownerentnum );
    
    if ( target_istarget( helicopter ) )
    {
        target_remove( helicopter );
    }
    
    if ( killed )
    {
        wait randomfloatrange( 0.1, 0.2 );
        helicopter firstheliexplo();
        helicopter helideathtrails();
        helicopter thread spin();
        goalx = randomfloatrange( 650, 700 );
        goaly = randomfloatrange( 650, 700 );
        
        if ( randomintrange( 0, 2 ) > 0 )
        {
            goalx *= -1;
        }
        
        if ( randomintrange( 0, 2 ) > 0 )
        {
            goaly *= -1;
        }
        
        helicopter setvehgoalpos( helicopter.origin + ( goalx, goaly, randomfloatrange( 285, 300 ) * -1 ), 0 );
        wait randomfloatrange( 3, 4 );
        helicopter finalhelideathexplode();
        wait 0.1;
        helicopter ghost();
        self notify( #"stop_death_spin" );
        wait 0.5;
    }
    else
    {
        helicopter helicopterleave();
    }
    
    helicopter delete();
}

// Namespace raps_mp/raps
// Params 1
// Checksum 0x197a43c6, Offset: 0x3b80
// Size: 0x84
function watchownerdisconnect( owner )
{
    self notify( #"watchownerdisconnect_singleton" );
    self endon( #"watchownerdisconnect_singleton" );
    helicopter = self;
    helicopter endon( #"raps_helicopter_shutdown" );
    owner waittill( "joined_team", "disconnect", "joined_spectators" );
    helicopter notify( #"raps_helicopter_shutdown", { #is_killed:0 } );
}

// Namespace raps_mp/raps
// Params 0
// Checksum 0x4ae1709a, Offset: 0x3c10
// Size: 0x60
function watchgameended()
{
    helicopter = self;
    helicopter endon( #"raps_helicopter_shutdown" );
    helicopter endon( #"death" );
    level waittill( "game_ended" );
    helicopter notify( #"raps_helicopter_shutdown", { #is_killed:0 } );
}

// Namespace raps_mp/raps
// Params 2
// Checksum 0xf1315235, Offset: 0x3c78
// Size: 0x1cc
function ondeath( attacker, weapon )
{
    helicopter = self;
    
    if ( !isdefined( helicopter.owner ) || isdefined( attacker ) && helicopter.owner util::isenemyplayer( attacker ) )
    {
        challenges::destroyedaircraft( attacker, weapon, 0 );
        attacker challenges::addflyswatterstat( weapon, self );
        scoreevents::processscoreevent( "destroyed_raps_deployship", attacker, helicopter.owner, weapon );
        
        if ( isdefined( helicopter.droppedraps ) && helicopter.droppedraps == 0 )
        {
            attacker addplayerstat( "destroy_raps_before_drop", 1 );
        }
        
        luinotifyevent( &"player_callout", 2, &"KILLSTREAK_DESTROYED_RAPS_DEPLOY_SHIP", attacker.entnum );
        helicopter notify( #"raps_helicopter_shutdown", { #is_killed:1 } );
    }
    
    if ( helicopter.isleaving !== 1 )
    {
        helicopter killstreaks::play_pilot_dialog_on_owner( "destroyed", "raps" );
        helicopter killstreaks::play_destroyed_dialog_on_owner( "raps", self.killstreakid );
    }
}

// Namespace raps_mp/raps
// Params 2
// Checksum 0x93e6c14a, Offset: 0x3e50
// Size: 0x6c
function onlowhealth( attacker, weapon )
{
    helicopter = self;
    helicopter killstreaks::play_pilot_dialog_on_owner( "damaged", "raps", helicopter.killstreakid );
    helicopter helilowhealthfx();
}

// Namespace raps_mp/raps
// Params 2
// Checksum 0xb9573fe6, Offset: 0x3ec8
// Size: 0x3c
function onextralowhealth( attacker, weapon )
{
    helicopter = self;
    helicopter heliextralowhealthfx();
}

// Namespace raps_mp/raps
// Params 3
// Checksum 0x9c56c5dc, Offset: 0x3f10
// Size: 0x388
function getrandomhelicopterposition( avoidpoint, otheravoidpoint, avoidradiussqr )
{
    if ( !isdefined( avoidpoint ) )
    {
        avoidpoint = ( -1e+07, -1e+07, -1e+07 );
    }
    
    if ( !isdefined( otheravoidpoint ) )
    {
        otheravoidpoint = ( -1e+07, -1e+07, -1e+07 );
    }
    
    if ( !isdefined( avoidradiussqr ) )
    {
        avoidradiussqr = 1800 * 1800;
    }
    
    flyheight = int( airsupport::getminimumflyheight() + 1000 );
    found = 0;
    tries = 0;
    
    for ( i = 0; i <= 3 ; i++ )
    {
        if ( i == 3 )
        {
            avoidradiussqr = -1;
        }
        
        /#
            if ( getdvarint( "scr_raps_hedeps_debug" ) > 0 )
            {
                server_frames_to_persist = int( 60 );
                circle( avoidpoint, 1800, ( 1, 0, 0 ), 1, 1, server_frames_to_persist );
                circle( avoidpoint, 1800 - 1, ( 1, 0, 0 ), 1, 1, server_frames_to_persist );
                circle( avoidpoint, 1800 - 2, ( 1, 0, 0 ), 1, 1, server_frames_to_persist );
                circle( otheravoidpoint, 1800, ( 1, 0, 0 ), 1, 1, server_frames_to_persist );
                circle( otheravoidpoint, 1800 - 1, ( 1, 0, 0 ), 1, 1, server_frames_to_persist );
                circle( otheravoidpoint, 1800 - 2, ( 1, 0, 0 ), 1, 1, server_frames_to_persist );
            }
        #/
        
        while ( !found && tries < game.raps_helicopter_positions.size )
        {
            index = randomintrange( 0, game.raps_helicopter_positions.size );
            randompoint = ( game.raps_helicopter_positions[ index ][ 0 ], game.raps_helicopter_positions[ index ][ 1 ], flyheight );
            found = distance2dsquared( randompoint, avoidpoint ) > avoidradiussqr && distance2dsquared( randompoint, otheravoidpoint ) > avoidradiussqr;
            tries++;
        }
        
        if ( !found )
        {
            avoidradiussqr *= 0.25;
            tries = 0;
        }
    }
    
    assert( found, "Failed to find a RAPS deploy point!" );
    return randompoint;
}

// Namespace raps_mp/raps
// Params 4
// Checksum 0xf5fde2bd, Offset: 0x42a0
// Size: 0x150
function getclosestrandomhelicopterposition( refpoint, pickcount, avoidpoint, otheravoidpoint )
{
    if ( !isdefined( avoidpoint ) )
    {
        avoidpoint = ( -1e+07, -1e+07, -1e+07 );
    }
    
    if ( !isdefined( otheravoidpoint ) )
    {
        otheravoidpoint = ( -1e+07, -1e+07, -1e+07 );
    }
    
    bestposition = getrandomhelicopterposition( avoidpoint, otheravoidpoint );
    bestdistancesqr = distance2dsquared( bestposition, refpoint );
    
    for ( i = 1; i < pickcount ; i++ )
    {
        candidateposition = getrandomhelicopterposition( avoidpoint, otheravoidpoint );
        candidatedistancesqr = distance2dsquared( candidateposition, refpoint );
        
        if ( candidatedistancesqr < bestdistancesqr )
        {
            bestposition = candidateposition;
            bestdistancesqr = candidatedistancesqr;
        }
    }
    
    return bestposition;
}

// Namespace raps_mp/raps
// Params 0
// Checksum 0x8d461399, Offset: 0x43f8
// Size: 0x42
function waitforstoppingmovetoexpire()
{
    elapsedtimestopping = gettime() - self.laststoptime;
    
    if ( elapsedtimestopping < 2000 )
    {
        wait ( 2000 - elapsedtimestopping ) * 0.001;
    }
}

// Namespace raps_mp/raps
// Params 0
// Checksum 0x830d65f9, Offset: 0x4448
// Size: 0xce
function getotherhelicopterpointtoavoid()
{
    avoid_point = undefined;
    arrayremovevalue( level.raps_helicopters, undefined );
    
    foreach ( heli in level.raps_helicopters )
    {
        if ( heli != self )
        {
            avoid_point = heli.targetdroplocation;
            break;
        }
    }
    
    return avoid_point;
}

// Namespace raps_mp/raps
// Params 5
// Checksum 0xc9f72238, Offset: 0x4520
// Size: 0x13a
function picknextdroplocation( heli, drop_index, firstdropreferencepoint, assigned_fly_height, lastdroplocation )
{
    avoid_point = self getotherhelicopterpointtoavoid();
    
    if ( isdefined( heli ) && isdefined( heli.prepickeddroplocation ) )
    {
        targetdroplocation = heli.prepickeddroplocation;
        heli.prepickeddroplocation = undefined;
        return targetdroplocation;
    }
    
    targetdroplocation = drop_index == 0 ? getclosestrandomhelicopterposition( firstdropreferencepoint, int( game.raps_helicopter_positions.size * 66.6 / 100 + 1 ), avoid_point ) : getrandomhelicopterposition( lastdroplocation, avoid_point );
    targetdroplocation = ( targetdroplocation[ 0 ], targetdroplocation[ 1 ], assigned_fly_height );
    return targetdroplocation;
}

// Namespace raps_mp/raps
// Params 0
// Checksum 0x1a06305d, Offset: 0x4668
// Size: 0x2fa
function helicopterthink()
{
    /#
        if ( getdvarint( "scr_raps_debug_visit_all" ) )
        {
            return;
        }
    #/
    
    self endon( #"raps_helicopter_shutdown" );
    
    for ( i = 0; i < 3 ; i++ )
    {
        self.targetdroplocation = picknextdroplocation( self, i, self.firstdropreferencepoint, self.assigned_fly_height, self.lastdroplocation );
        
        while ( distance2dsquared( self.origin, self.targetdroplocation ) > 25 )
        {
            self waitforstoppingmovetoexpire();
            self updatehelicopterspeed();
            self setvehgoalpos( self.targetdroplocation, 1 );
            self waittill( "goal" );
        }
        
        if ( isdefined( self.owner ) )
        {
            if ( i + 1 < 3 )
            {
                self killstreaks::play_pilot_dialog_on_owner( "waveStart", "raps", self.killstreakid );
            }
            else
            {
                self killstreaks::play_pilot_dialog_on_owner( "waveStartFinal", "raps", self.killstreakid );
            }
        }
        
        enemy = self.owner battlechatter::get_closest_player_enemy( self.origin, 1 );
        enemyradius = battlechatter::mpdialog_value( "rapsDropRadius", 0 );
        
        if ( isdefined( enemy ) && distance2dsquared( self.origin, enemy.origin ) < enemyradius * enemyradius )
        {
            enemy battlechatter::play_killstreak_threat( "raps" );
        }
        
        self dropraps();
        wait i + 1 >= 3 ? 2 + randomfloatrange( 1 * -1, 1 ) : 2 + randomfloatrange( 2 * -1, 2 );
    }
    
    self notify( #"raps_helicopter_shutdown", { #is_killed:0 } );
}

/#

    // Namespace raps_mp/raps
    // Params 0
    // Checksum 0x6f451944, Offset: 0x4970
    // Size: 0x27a, Type: dev
    function helicopterthinkdebugvisitall()
    {
        self endon( #"death" );
        
        if ( getdvarint( "scr_raps_debug_visit_all" ) == 0 )
        {
            return;
        }
        
        for ( i = 0; i < 100 ; i++ )
        {
            for ( j = 0; j < game.raps_helicopter_positions.size ; j++ )
            {
                self.targetdroplocation = ( game.raps_helicopter_positions[ j ][ 0 ], game.raps_helicopter_positions[ j ][ 1 ], self.assigned_fly_height );
                
                while ( distance2dsquared( self.origin, self.targetdroplocation ) > 25 )
                {
                    self waitforstoppingmovetoexpire();
                    self updatehelicopterspeed();
                    self setvehgoalpos( self.targetdroplocation, 1 );
                    self waittill( "goal" );
                }
                
                self dropraps();
                wait 1;
                
                if ( getdvarint( "scr_raps_debug_visit_all_fake_leave" ) > 0 )
                {
                    if ( ( j + 1 ) % 3 == 0 )
                    {
                        self.targetdroplocation = getrandomhelicopterstartorigin( self.assigned_fly_height, self.origin );
                        
                        while ( distance2dsquared( self.origin, self.targetdroplocation ) > 25 )
                        {
                            self waitforstoppingmovetoexpire();
                            self updatehelicopterspeed();
                            self setvehgoalpos( self.targetdroplocation, 1 );
                            self waittill( "goal" );
                        }
                    }
                }
            }
        }
        
        self notify( #"raps_helicopter_shutdown", { #is_killed:0 } );
    }

#/

// Namespace raps_mp/raps
// Params 0
// Checksum 0x609c309c, Offset: 0x4bf8
// Size: 0x268
function dropraps()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self.droppingraps = 1;
    self.lastdroplocation = self.origin;
    precisedroplocation = 0.5 * ( self gettagorigin( level.raps_helicopter_drop_tag_names[ 0 ] ) + self gettagorigin( level.raps_helicopter_drop_tag_names[ 1 ] ) );
    precisegoallocation = self.targetdroplocation + self.targetdroplocation - precisedroplocation;
    precisegoallocation = ( precisegoallocation[ 0 ], precisegoallocation[ 1 ], self.targetdroplocation[ 2 ] );
    self setvehgoalpos( precisegoallocation, 1 );
    self waittill( "goal" );
    self.droppedraps = 1;
    
    for ( i = 0; i < level.raps_settings.spawn_count ; i++ )
    {
        spawn_tag = level.raps_helicopter_drop_tag_names[ i % level.raps_helicopter_drop_tag_names.size ];
        origin = self gettagorigin( spawn_tag );
        angles = self gettagangles( spawn_tag );
        
        if ( !isdefined( origin ) || !isdefined( angles ) )
        {
            origin = self.origin;
            angles = self.angles;
        }
        
        self.owner thread spawnraps( origin, angles );
        self playsound( "veh_raps_launch" );
        wait 1;
    }
    
    self.droppingraps = 0;
}

// Namespace raps_mp/raps
// Params 0
// Checksum 0xd3a36873, Offset: 0x4e68
// Size: 0xd6
function spin()
{
    self endon( #"stop_death_spin" );
    speed = randomintrange( 180, 220 );
    self setyawspeed( speed, speed * 0.25, speed );
    
    if ( randomintrange( 0, 2 ) > 0 )
    {
        speed *= -1;
    }
    
    while ( isdefined( self ) )
    {
        self settargetyaw( self.angles[ 1 ] + speed * 0.4 );
        wait 1;
    }
}

// Namespace raps_mp/raps
// Params 0
// Checksum 0x7f1afb5e, Offset: 0x4f48
// Size: 0x4c
function firstheliexplo()
{
    playfxontag( "killstreaks/fx_heli_raps_exp_sm", self, "tag_fx_engine_exhaust_back" );
    self playsound( level.heli_sound[ "crash" ] );
}

// Namespace raps_mp/raps
// Params 0
// Checksum 0x155d099, Offset: 0x4fa0
// Size: 0x24
function helilowhealthfx()
{
    self clientfield::set( "raps_heli_low_health", 1 );
}

// Namespace raps_mp/raps
// Params 0
// Checksum 0x6552f723, Offset: 0x4fd0
// Size: 0x24
function heliextralowhealthfx()
{
    self clientfield::set( "raps_heli_extra_low_health", 1 );
}

// Namespace raps_mp/raps
// Params 0
// Checksum 0x32772185, Offset: 0x5000
// Size: 0x24
function helideathtrails()
{
    playfxontag( "killstreaks/fx_heli_raps_exp_trail", self, "tag_fx_engine_exhaust_back" );
}

// Namespace raps_mp/raps
// Params 0
// Checksum 0xf818dfb8, Offset: 0x5030
// Size: 0x4c
function finalhelideathexplode()
{
    playfxontag( "killstreaks/fx_heli_raps_exp_lg", self, "tag_fx_death" );
    self playsound( level.heli_sound[ "crash" ] );
}

// Namespace raps_mp/raps
// Params 0
// Checksum 0x88b1425c, Offset: 0x5088
// Size: 0xfe
function helicopterleave()
{
    self.isleaving = 1;
    self killstreaks::play_pilot_dialog_on_owner( "timeout", "raps" );
    self killstreaks::play_taacom_dialog_response_on_owner( "timeoutConfirmed", "raps" );
    self.leavelocation = getrandomhelicopterleaveorigin( 0, self.origin );
    
    while ( distance2dsquared( self.origin, self.leavelocation ) > 360000 )
    {
        self updatehelicopterspeed();
        self setvehgoalpos( self.leavelocation, 0 );
        self waittill( "goal" );
    }
}

// Namespace raps_mp/raps
// Params 1
// Checksum 0xef3daba5, Offset: 0x5190
// Size: 0x174
function updatehelicopterspeed( drivemode )
{
    if ( isdefined( drivemode ) )
    {
        switch ( drivemode )
        {
            case 0:
                self.drivemodespeedscale = 1;
                self.drivemodeaccel = 20;
                self.drivemodedecel = 20;
                break;
            case 1:
            case 2:
                self.drivemodespeedscale = drivemode == 2 ? 0.2 : 0.5;
                self.drivemodeaccel = 12;
                self.drivemodedecel = 100;
                break;
        }
    }
    
    desiredspeed = self getmaxspeed() / 17.6 * self.drivemodespeedscale;
    
    if ( desiredspeed < self getspeedmph() )
    {
        self setspeed( desiredspeed, self.drivemodedecel, self.drivemodedecel );
        return;
    }
    
    self setspeed( desiredspeed, self.drivemodeaccel, self.drivemodedecel );
}

// Namespace raps_mp/raps
// Params 0
// Checksum 0x8525dce6, Offset: 0x5310
// Size: 0x30
function stophelicopter()
{
    self setspeed( 0, 500, 500 );
    self.laststoptime = gettime();
}

// Namespace raps_mp/raps
// Params 2
// Checksum 0xfef8e98c, Offset: 0x5348
// Size: 0x374
function spawnraps( origin, angles )
{
    originalowner = self;
    originalownerentnum = originalowner.entnum;
    raps = spawnvehicle( "spawner_bo3_raps_mp", origin, angles, "dynamic_spawn_ai" );
    
    if ( !isdefined( raps ) )
    {
        return;
    }
    
    raps.forceonemissile = 1;
    raps.drop_deploying = 1;
    raps.hurt_trigger_immune_end_time = gettime() + ( isdefined( level.raps_hurt_trigger_immune_duration_ms ) ? level.raps_hurt_trigger_immune_duration_ms : 5000 );
    
    if ( !isdefined( level.raps[ originalownerentnum ].raps ) )
    {
        level.raps[ originalownerentnum ].raps = [];
    }
    else if ( !isarray( level.raps[ originalownerentnum ].raps ) )
    {
        level.raps[ originalownerentnum ].raps = array( level.raps[ originalownerentnum ].raps );
    }
    
    level.raps[ originalownerentnum ].raps[ level.raps[ originalownerentnum ].raps.size ] = raps;
    raps killstreaks::configure_team( "raps", "raps", originalowner, undefined, undefined, &configureteampost );
    raps killstreak_hacking::enable_hacking( "raps" );
    raps clientfield::set( "enemyvehicle", 1 );
    raps.soundmod = "raps";
    raps.ignore_vehicle_underneath_splash_scalar = 1;
    raps.detonate_sides_disabled = 1;
    raps.treat_owner_damage_as_friendly_fire = 1;
    raps.ignore_team_kills = 1;
    raps setinvisibletoall();
    raps thread autosetvisibletoall();
    raps vehicle::toggle_sounds( 0 );
    raps thread watchrapskills( originalowner );
    raps thread watchrapsdeath( originalowner );
    raps thread killstreaks::waitfortimeout( "raps", raps.settings.max_duration * 1000, &onrapstimeout, "death" );
}

// Namespace raps_mp/raps
// Params 2
// Checksum 0x169396f6, Offset: 0x56c8
// Size: 0x6c
function configureteampost( owner, ishacked )
{
    raps = self;
    raps thread createrapsinfluencer();
    raps thread initenemyselection( owner );
    raps thread watchrapstippedover( owner );
}

// Namespace raps_mp/raps
// Params 0
// Checksum 0xc26a5693, Offset: 0x5740
// Size: 0x34
function autosetvisibletoall()
{
    self endon( #"death" );
    waitframe( 1 );
    waitframe( 1 );
    self setvisibletoall();
}

// Namespace raps_mp/raps
// Params 0
// Checksum 0x25d7894a, Offset: 0x5780
// Size: 0x24
function onrapstimeout()
{
    self selfdestruct( self.owner );
}

// Namespace raps_mp/raps
// Params 1
// Checksum 0x21815b0c, Offset: 0x57b0
// Size: 0x34
function selfdestruct( attacker )
{
    self.selfdestruct = 1;
    self raps::detonate( attacker );
}

// Namespace raps_mp/raps
// Params 1
// Checksum 0x160d3d6e, Offset: 0x57f0
// Size: 0x110
function watchrapskills( originalowner )
{
    originalowner endon( #"raps_complete" );
    self endon( #"death" );
    
    if ( self.settings.max_kill_count == 0 )
    {
        return;
    }
    
    while ( true )
    {
        waitresult = self waittill( "killed" );
        victim = waitresult.victim;
        
        if ( isdefined( victim ) && isplayer( victim ) )
        {
            if ( !isdefined( self.killcount ) )
            {
                self.killcount = 0;
            }
            
            self.killcount++;
            
            if ( self.killcount >= self.settings.max_kill_count )
            {
                self raps::detonate( self.owner );
            }
        }
    }
}

// Namespace raps_mp/raps
// Params 1
// Checksum 0xb1204734, Offset: 0x5908
// Size: 0x80
function watchrapstippedover( owner )
{
    owner endon( #"disconnect" );
    self endon( #"death" );
    
    while ( true )
    {
        wait 3.5;
        
        if ( abs( self.angles[ 2 ] ) > 75 )
        {
            self raps::detonate( owner );
        }
    }
}

// Namespace raps_mp/raps
// Params 1
// Checksum 0xbb925c4f, Offset: 0x5990
// Size: 0x264
function watchrapsdeath( originalowner )
{
    originalownerentnum = originalowner.entnum;
    waitresult = self waittill( "death" );
    attacker = waitresult.attacker;
    weapon = waitresult.weapon;
    attacker = self [[ level.figure_out_attacker ]]( attacker );
    
    if ( isdefined( attacker ) && isplayer( attacker ) )
    {
        if ( isdefined( self.owner ) && self.owner != attacker && self.owner.team != attacker.team )
        {
            scoreevents::processscoreevent( "killed_raps", attacker );
            attacker challenges::destroyscorestreak( weapon, 1 );
            attacker challenges::destroynonairscorestreak_poststatslock( weapon );
            
            if ( isdefined( self.attackers ) )
            {
                foreach ( player in self.attackers )
                {
                    if ( isplayer( player ) && player != attacker && player != self.owner )
                    {
                        scoreevents::processscoreevent( "killed_raps_assist", player );
                    }
                }
            }
        }
    }
    
    arrayremovevalue( level.raps[ originalownerentnum ].raps, self );
}

// Namespace raps_mp/raps
// Params 1
// Checksum 0x6137bcc, Offset: 0x5c00
// Size: 0x28c
function initenemyselection( owner )
{
    owner endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"hacked" );
    self vehicle_ai::set_state( "off" );
    util::wait_network_frame();
    util::wait_network_frame();
    self setvehiclefordropdeploy();
    self clientfield::set( "monitor_raps_drop_landing", 1 );
    wait 3;
    
    if ( self initialwaituntilsettled() )
    {
        self resetvehiclefromdropdeploy();
        self setgoal( self.origin );
        self vehicle_ai::set_state( "combat" );
        self vehicle::toggle_sounds( 1 );
        self.drop_deploying = undefined;
        self.hurt_trigger_immune_end_time = undefined;
        target_set( self );
        
        for ( i = 0; i < level.raps[ owner.entnum ].raps.size ; i++ )
        {
            raps = level.raps[ owner.entnum ].raps[ i ];
            
            if ( isdefined( raps ) && isdefined( raps.enemy ) && isdefined( self ) && isdefined( self.enemy ) && raps != self && raps.enemy == self.enemy )
            {
                self setpersonalthreatbias( self.enemy, -2000, 5 );
            }
        }
        
        return;
    }
    
    self selfdestruct( self.owner );
}

// Namespace raps_mp/raps
// Params 0
// Checksum 0x34c20c95, Offset: 0x5e98
// Size: 0x136, Type: bool
function initialwaituntilsettled()
{
    waittime = 0;
    
    while ( abs( self.velocity[ 2 ] ) > 0.1 && waittime < 5 )
    {
        wait 0.2;
        waittime += 0.2;
    }
    
    while ( ( !ispointonnavmesh( self.origin, 36 ) || abs( self.velocity[ 2 ] ) > 0.1 ) && waittime < 5 + 5 )
    {
        wait 0.2;
        waittime += 0.2;
    }
    
    /#
        if ( false )
        {
            waittime += 5 + 5;
        }
    #/
    
    return waittime < 5 + 5;
}

// Namespace raps_mp/raps
// Params 2
// Checksum 0xf63ee45d, Offset: 0x5fd8
// Size: 0xfa
function destroyallraps( entnum, abandoned )
{
    if ( !isdefined( abandoned ) )
    {
        abandoned = 0;
    }
    
    foreach ( raps in level.raps[ entnum ].raps )
    {
        if ( isalive( raps ) )
        {
            raps.owner = undefined;
            raps.abandoned = abandoned;
            raps raps::detonate( raps );
        }
    }
}

// Namespace raps_mp/raps
// Params 0
// Checksum 0xe27408f9, Offset: 0x60e0
// Size: 0xfc
function forcegetenemies()
{
    foreach ( player in level.players )
    {
        if ( isdefined( self.owner ) && self.owner util::isenemyplayer( player ) && !player smokegrenade::isinsmokegrenade() && !player hasperk( "specialty_nottargetedbyraps" ) )
        {
            self getperfectinfo( player );
            return;
        }
    }
}

// Namespace raps_mp/raps
// Params 0
// Checksum 0x46ad216e, Offset: 0x61e8
// Size: 0x1a4
function createrapshelicopterinfluencer()
{
    level endon( #"game_ended" );
    helicopter = self;
    
    if ( isdefined( helicopter.influencerent ) )
    {
        helicopter.influencerent delete();
    }
    
    influencerent = spawn( "script_model", helicopter.origin - ( 0, 0, self.assigned_fly_height ) );
    helicopter.influencerent = influencerent;
    helicopter.influencerent.angles = ( 0, 0, 0 );
    helicopter.influencerent linkto( helicopter );
    preset = getinfluencerpreset( "helicopter" );
    
    if ( !isdefined( preset ) )
    {
        return;
    }
    
    enemy_team_mask = helicopter influencers::get_enemy_team_mask( helicopter.team );
    helicopter.influencerent influencers::create_entity_influencer( "helicopter", enemy_team_mask );
    helicopter waittill( "death" );
    
    if ( isdefined( influencerent ) )
    {
        influencerent delete();
    }
}

// Namespace raps_mp/raps
// Params 0
// Checksum 0xbf406eb, Offset: 0x6398
// Size: 0x94
function createrapsinfluencer()
{
    raps = self;
    preset = getinfluencerpreset( "raps" );
    
    if ( !isdefined( preset ) )
    {
        return;
    }
    
    enemy_team_mask = raps influencers::get_enemy_team_mask( raps.team );
    raps influencers::create_entity_influencer( "raps", enemy_team_mask );
}

