#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/util_shared;
#using scripts/mp_common/shoutcaster;

#namespace war;

// Namespace war/GameType_Init
// Params 1, eflags: 0x40
// Checksum 0x77539e9d, Offset: 0x5e0
// Size: 0x31c
function event_handler[GameType_Init] main( eventstruct )
{
    level.current_zone = [];
    level.current_state = [];
    
    for ( i = 0; i < 4 ; i++ )
    {
        level.current_zone[ i ] = 0;
        level.current_state[ i ] = 0;
    }
    
    level.warzones = [];
    level.visuals = [];
    level.warzonefx = [];
    clientfield::register( "world", "warzone", 1, 5, "int", &warzone, 0, 0 );
    clientfield::register( "world", "warzonestate", 1, 10, "int", &warzone_state, 0, 0 );
    level.effect_scriptbundles = [];
    level.effect_scriptbundles[ "zoneEdgeMarker" ] = struct::get_script_bundle( "teamcolorfx", "teamcolorfx_koth_edge_marker" );
    level.effect_scriptbundles[ "zoneEdgeMarkerWndw" ] = struct::get_script_bundle( "teamcolorfx", "teamcolorfx_koth_edge_marker_window" );
    level._effect[ "zoneEdgeMarker" ] = [];
    level._effect[ "zoneEdgeMarker" ][ 0 ] = "ui/fx_koth_marker_neutral";
    level._effect[ "zoneEdgeMarker" ][ 1 ] = "ui/fx_koth_marker_blue";
    level._effect[ "zoneEdgeMarker" ][ 2 ] = "ui/fx_koth_marker_orng";
    level._effect[ "zoneEdgeMarker" ][ 3 ] = "ui/fx_koth_marker_contested";
    level._effect[ "zoneEdgeMarkerWndw" ] = [];
    level._effect[ "zoneEdgeMarkerWndw" ][ 0 ] = "ui/fx_koth_marker_neutral_window";
    level._effect[ "zoneEdgeMarkerWndw" ][ 1 ] = "ui/fx_koth_marker_blue_window";
    level._effect[ "zoneEdgeMarkerWndw" ][ 2 ] = "ui/fx_koth_marker_orng_window";
    level._effect[ "zoneEdgeMarkerWndw" ][ 3 ] = "ui/fx_koth_marker_contested_window";
    register_clientfields();
}

// Namespace war/war
// Params 0
// Checksum 0xe3ebddfe, Offset: 0x908
// Size: 0x57c
function register_clientfields()
{
    clientfield::register( "worlduimodel", "hudItems.war.team1.tickets", 1, 10, "int", undefined, 0, 1 );
    clientfield::register( "worlduimodel", "hudItems.war.team1.zone1", 1, 10, "int", undefined, 0, 1 );
    clientfield::register( "worlduimodel", "hudItems.war.team1.zone2", 1, 10, "int", undefined, 0, 1 );
    clientfield::register( "worlduimodel", "hudItems.war.team1.zone3", 1, 10, "int", undefined, 0, 1 );
    clientfield::register( "worlduimodel", "hudItems.war.team1.zone4", 1, 10, "int", undefined, 0, 1 );
    clientfield::register( "worlduimodel", "hudItems.war.team1.zone5", 1, 10, "int", undefined, 0, 1 );
    clientfield::register( "worlduimodel", "hudItems.war.team1.bonus", 1, 1, "int", undefined, 0, 1 );
    clientfield::register( "worlduimodel", "hudItems.war.team1.progress", 1, 3, "int", undefined, 0, 1 );
    clientfield::register( "worlduimodel", "hudItems.war.team2.tickets", 1, 10, "int", undefined, 0, 1 );
    clientfield::register( "worlduimodel", "hudItems.war.team2.zone1", 1, 10, "int", undefined, 0, 1 );
    clientfield::register( "worlduimodel", "hudItems.war.team2.zone2", 1, 10, "int", undefined, 0, 1 );
    clientfield::register( "worlduimodel", "hudItems.war.team2.zone3", 1, 10, "int", undefined, 0, 1 );
    clientfield::register( "worlduimodel", "hudItems.war.team2.zone4", 1, 10, "int", undefined, 0, 1 );
    clientfield::register( "worlduimodel", "hudItems.war.team2.zone5", 1, 10, "int", undefined, 0, 1 );
    clientfield::register( "worlduimodel", "hudItems.war.team2.bonus", 1, 1, "int", undefined, 0, 1 );
    clientfield::register( "worlduimodel", "hudItems.war.team2.progress", 1, 3, "int", undefined, 0, 1 );
    clientfield::register( "worlduimodel", "hudItems.war.attackingTeam", 1, 2, "int", undefined, 0, 1 );
    clientfield::register( "worlduimodel", "hudItems.war.currentZone", 1, 3, "int", undefined, 0, 1 );
    clientfield::register( "worlduimodel", "hudItems.war.currentZoneStartTime", 1, 10, "int", undefined, 0, 1 );
    clientfield::register( "worlduimodel", "hudItems.war.attackingDeaths", 1, 4, "counter", undefined, 0, 0 );
    clientfield::register( "worlduimodel", "hudItems.war.currentZoneProgress", 1, 8, "float", undefined, 0, 0 );
    clientfield::register( "worlduimodel", "hudItems.war.robotCurrentDistance", 1, 16, "int", undefined, 0, 0 );
    clientfield::register( "worlduimodel", "hudItems.war.batteryState1", 1, 3, "int", undefined, 0, 0 );
    clientfield::register( "worlduimodel", "hudItems.war.batteryState2", 1, 3, "int", undefined, 0, 0 );
    clientfield::register( "worlduimodel", "hudItems.missions.captureMultiplierStatus", 1, 2, "int", undefined, 0, 1 );
}

// Namespace war/war
// Params 1
// Checksum 0xfe38d5d1, Offset: 0xe90
// Size: 0x230
function get_shoutcaster_fx( local_client_num )
{
    caster_effects = [];
    caster_effects[ "zoneEdgeMarker" ] = shoutcaster::get_color_fx( local_client_num, level.effect_scriptbundles[ "zoneEdgeMarker" ] );
    caster_effects[ "zoneEdgeMarkerWndw" ] = shoutcaster::get_color_fx( local_client_num, level.effect_scriptbundles[ "zoneEdgeMarkerWndw" ] );
    effects = [];
    effects[ "zoneEdgeMarker" ] = level._effect[ "zoneEdgeMarker" ];
    effects[ "zoneEdgeMarkerWndw" ] = level._effect[ "zoneEdgeMarkerWndw" ];
    
    if ( getdvarint( "tu11_programaticallyColoredGameFX" ) )
    {
        effects[ "zoneEdgeMarker" ][ 1 ] = "ui/fx_koth_marker_white";
        effects[ "zoneEdgeMarker" ][ 2 ] = "ui/fx_koth_marker_white";
        effects[ "zoneEdgeMarkerWndw" ][ 1 ] = "ui/fx_koth_marker_white_window";
        effects[ "zoneEdgeMarkerWndw" ][ 2 ] = "ui/fx_koth_marker_white_window";
    }
    else
    {
        effects[ "zoneEdgeMarker" ][ 1 ] = caster_effects[ "zoneEdgeMarker" ][ "allies" ];
        effects[ "zoneEdgeMarker" ][ 2 ] = caster_effects[ "zoneEdgeMarker" ][ "axis" ];
        effects[ "zoneEdgeMarkerWndw" ][ 1 ] = caster_effects[ "zoneEdgeMarkerWndw" ][ "allies" ];
        effects[ "zoneEdgeMarkerWndw" ][ 2 ] = caster_effects[ "zoneEdgeMarkerWndw" ][ "axis" ];
    }
    
    return effects;
}

// Namespace war/war
// Params 3
// Checksum 0x4f8b5c60, Offset: 0x10c8
// Size: 0xaa
function get_fx_state( local_client_num, state, is_shoutcaster )
{
    if ( is_shoutcaster )
    {
        return state;
    }
    
    if ( state == 1 )
    {
        if ( util::friend_not_foe_team( local_client_num, "allies" ) )
        {
            return 1;
        }
        else
        {
            return 2;
        }
    }
    else if ( state == 2 )
    {
        if ( util::friend_not_foe_team( local_client_num, "axis" ) )
        {
            return 1;
        }
        else
        {
            return 2;
        }
    }
    
    return state;
}

// Namespace war/war
// Params 3
// Checksum 0xb68849b1, Offset: 0x1180
// Size: 0x2c
function get_fx( fx_name, fx_state, effects )
{
    return effects[ fx_name ][ fx_state ];
}

// Namespace war/war
// Params 3
// Checksum 0x7a6171d7, Offset: 0x11b8
// Size: 0x3ec
function setup_warzone_fx( local_client_num, zone_index, state )
{
    effects = [];
    
    if ( shoutcaster::is_shoutcaster_using_team_identity( local_client_num ) )
    {
        effects = get_shoutcaster_fx( local_client_num );
    }
    else
    {
        effects[ "zoneEdgeMarker" ] = level._effect[ "zoneEdgeMarker" ];
        effects[ "zoneEdgeMarkerWndw" ] = level._effect[ "zoneEdgeMarkerWndw" ];
    }
    
    if ( isdefined( level.warzonefx[ local_client_num ] ) )
    {
        foreach ( fx in level.warzonefx[ local_client_num ] )
        {
            stopfx( local_client_num, fx );
        }
    }
    
    level.warzonefx[ local_client_num ] = [];
    
    if ( zone_index )
    {
        if ( isdefined( level.visuals[ zone_index ] ) )
        {
            fx_state = get_fx_state( local_client_num, state, shoutcaster::is_shoutcaster( local_client_num ) );
            
            foreach ( visual in level.visuals[ zone_index ] )
            {
                if ( !isdefined( visual.script_fxid ) )
                {
                    continue;
                }
                
                fxid = get_fx( visual.script_fxid, fx_state, effects );
                
                if ( isdefined( visual.angles ) )
                {
                    forward = anglestoforward( visual.angles );
                }
                else
                {
                    forward = ( 0, 0, 0 );
                }
                
                fxhandle = playfx( local_client_num, fxid, visual.origin, forward );
                level.warzonefx[ local_client_num ][ level.warzonefx[ local_client_num ].size ] = fxhandle;
                
                if ( isdefined( fxhandle ) )
                {
                    if ( state == 1 )
                    {
                        setfxteam( local_client_num, fxhandle, "allies" );
                        continue;
                    }
                    
                    if ( state == 2 )
                    {
                        setfxteam( local_client_num, fxhandle, "axis" );
                        continue;
                    }
                    
                    setfxteam( local_client_num, fxhandle, "free" );
                }
            }
        }
    }
    
    thread watch_for_team_change( local_client_num );
}

// Namespace war/war
// Params 7
// Checksum 0xb93c0289, Offset: 0x15b0
// Size: 0x22c
function warzone( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( level.warzones.size == 0 )
    {
        warzones = struct::get_array( "war_zone_center", "targetname" );
        
        foreach ( point in warzones )
        {
            level.warzones[ point.script_index ] = point;
        }
        
        foreach ( point in level.warzones )
        {
            if ( isdefined( point.target ) )
            {
                level.visuals[ point.script_index ] = struct::get_array( point.target, "targetname" );
            }
        }
    }
    
    level.current_zone[ localclientnum ] = newval;
    level.current_state[ localclientnum ] = 0;
    setup_warzone_fx( localclientnum, level.current_zone[ localclientnum ], level.current_state[ localclientnum ] );
}

// Namespace war/war
// Params 7
// Checksum 0x344a547, Offset: 0x17e8
// Size: 0xa4
function warzone_state( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval != level.current_state[ localclientnum ] )
    {
        level.current_state[ localclientnum ] = newval;
        setup_warzone_fx( localclientnum, level.current_zone[ localclientnum ], level.current_state[ localclientnum ] );
    }
}

// Namespace war/war
// Params 1
// Checksum 0x496cb91f, Offset: 0x1898
// Size: 0x9c
function watch_for_team_change( localclientnum )
{
    level notify( #"end_team_change_watch" );
    level endon( #"end_team_change_watch" );
    level waittill( "team_changed" );
    
    while ( !isdefined( getnonpredictedlocalplayer( localclientnum ) ) )
    {
        wait 0.05;
    }
    
    thread setup_warzone_fx( localclientnum, level.current_zone[ localclientnum ], level.current_state[ localclientnum ] );
}

