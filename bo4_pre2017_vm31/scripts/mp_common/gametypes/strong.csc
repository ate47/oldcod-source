#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/util_shared;
#using scripts/mp_common/shoutcaster;

#namespace strong;

// Namespace strong/GameType_Init
// Params 1, eflags: 0x40
// Checksum 0x2b8a3196, Offset: 0x3a8
// Size: 0x3d8
function event_handler[GameType_Init] main( eventstruct )
{
    level.current_zone_mask = [];
    level.current_zone_state_mask = [];
    level.visuals = [];
    level.warzonefx = [];
    level.zones = [];
    
    for ( i = 0; i < 4 ; i++ )
    {
        level.current_zone_mask[ i ] = 0;
        level.current_zone_state_mask[ i ] = 0;
        level.warzonefx[ i ] = [];
    }
    
    clientfield::register( "world", "warzone", 1, 5, "int", &warzone, 0, 0 );
    clientfield::register( "world", "warzonestate", 1, 10, "int", &warzone_state, 0, 0 );
    clientfield::register( "worlduimodel", "hudItems.missions.captureMultiplierStatus", 1, 2, "int", undefined, 0, 1 );
    clientfield::register( "worlduimodel", "hudItems.war.attackingTeam", 1, 2, "int", undefined, 0, 1 );
    level.effect_scriptbundles = [];
    level.effect_scriptbundles[ "zoneEdgeMarker" ] = struct::get_script_bundle( "teamcolorfx", "teamcolorfx_koth_edge_marker" );
    level.effect_scriptbundles[ "zoneEdgeMarkerWndw" ] = struct::get_script_bundle( "teamcolorfx", "teamcolorfx_koth_edge_marker_window" );
    level._effect[ "zoneEdgeMarker" ] = [];
    level._effect[ "zoneEdgeMarker" ][ 0 ] = "ui/fx8_strnghold_marker_nuetral";
    level._effect[ "zoneEdgeMarker" ][ 1 ] = "ui/fx8_strnghold_marker_blue";
    level._effect[ "zoneEdgeMarker" ][ 2 ] = "ui/fx8_strnghold_marker_orng";
    level._effect[ "zoneEdgeMarker" ][ 3 ] = "ui/fx8_strnghold_marker_contested";
    level._effect[ "zoneEdgeMarkerWndw" ] = [];
    level._effect[ "zoneEdgeMarkerWndw" ][ 0 ] = "ui/fx8_strnghold_marker_nuetral_window";
    level._effect[ "zoneEdgeMarkerWndw" ][ 1 ] = "ui/fx8_strnghold_marker_blue_window";
    level._effect[ "zoneEdgeMarkerWndw" ][ 2 ] = "ui/fx8_strnghold_marker_orng_window";
    level._effect[ "zoneEdgeMarkerWndw" ][ 3 ] = "ui/fx8_strnghold_marker_contested_window";
    level.zonecount = getgametypesetting( "zoneCount" );
    level.mission_bundle = getscriptbundle( "mission_settings_strong" );
}

// Namespace strong/strong
// Params 1
// Checksum 0x3bc02eb1, Offset: 0x788
// Size: 0x160
function get_shoutcaster_fx( local_client_num )
{
    caster_effects = [];
    caster_effects[ "zoneEdgeMarker" ] = shoutcaster::get_color_fx( local_client_num, level.effect_scriptbundles[ "zoneEdgeMarker" ] );
    caster_effects[ "zoneEdgeMarkerWndw" ] = shoutcaster::get_color_fx( local_client_num, level.effect_scriptbundles[ "zoneEdgeMarkerWndw" ] );
    effects = [];
    effects[ "zoneEdgeMarker" ] = level._effect[ "zoneEdgeMarker" ];
    effects[ "zoneEdgeMarkerWndw" ] = level._effect[ "zoneEdgeMarkerWndw" ];
    effects[ "zoneEdgeMarker" ][ 1 ] = "ui/fx_koth_marker_white";
    effects[ "zoneEdgeMarker" ][ 2 ] = "ui/fx_koth_marker_white";
    effects[ "zoneEdgeMarkerWndw" ][ 1 ] = "ui/fx_koth_marker_white_window";
    effects[ "zoneEdgeMarkerWndw" ][ 2 ] = "ui/fx_koth_marker_white_window";
    return effects;
}

// Namespace strong/strong
// Params 4
// Checksum 0xc691d0f0, Offset: 0x8f0
// Size: 0xb2
function get_fx_state( local_client_num, state, attackers, is_shoutcaster )
{
    if ( is_shoutcaster )
    {
        return state;
    }
    
    if ( state == 1 )
    {
        if ( !util::friend_not_foe_team( local_client_num, attackers ) )
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
        if ( util::friend_not_foe_team( local_client_num, attackers ) )
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

// Namespace strong/strong
// Params 3
// Checksum 0x761ec36e, Offset: 0x9b0
// Size: 0x2c
function get_fx( fx_name, fx_state, effects )
{
    return effects[ fx_name ][ fx_state ];
}

// Namespace strong/strong
// Params 0, eflags: 0x4
// Checksum 0xd3149fea, Offset: 0x9e8
// Size: 0x5c
function private get_attacking_team()
{
    attackers_key = codegetworlduimodelfield( "hudItems.war.attackingTeam" );
    attackers = "allies";
    
    if ( attackers_key == 2 )
    {
        attackers = "axis";
    }
    
    return attackers;
}

// Namespace strong/strong
// Params 1
// Checksum 0xa0ad8858, Offset: 0xa50
// Size: 0x4ac
function setup_warzone_fx( local_client_num )
{
    for ( zi = 0; zi < level.zones.size ; zi++ )
    {
        zonestate = level.current_zone_state_mask[ local_client_num ] >> zi * 2 & 3;
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
        
        if ( isdefined( level.warzonefx[ local_client_num ][ zi ] ) )
        {
            foreach ( fx in level.warzonefx[ local_client_num ][ zi ] )
            {
                stopfx( local_client_num, fx );
            }
        }
        
        level.warzonefx[ local_client_num ][ zi ] = [];
        
        if ( level.current_zone_mask[ local_client_num ] & 1 << zi )
        {
            if ( isdefined( level.visuals[ zi ] ) )
            {
                attackers = get_attacking_team();
                fx_state = get_fx_state( local_client_num, zonestate, attackers, shoutcaster::is_shoutcaster( local_client_num ) );
                
                foreach ( visual in level.visuals[ zi ] )
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
                    level.warzonefx[ local_client_num ][ zi ][ level.warzonefx[ local_client_num ][ zi ].size ] = fxhandle;
                    
                    if ( isdefined( fxhandle ) )
                    {
                        if ( zonestate == 2 )
                        {
                            setfxteam( local_client_num, fxhandle, attackers );
                            continue;
                        }
                        
                        if ( zonestate == 1 )
                        {
                            defenders = util::get_other_team( attackers );
                            setfxteam( local_client_num, fxhandle, defenders );
                            continue;
                        }
                        
                        setfxteam( local_client_num, fxhandle, "free" );
                    }
                }
            }
        }
    }
    
    thread watch_for_team_change( local_client_num );
}

// Namespace strong/strong
// Params 2
// Checksum 0xaad61f0a, Offset: 0xf08
// Size: 0x10e, Type: bool
function compare_zone_indicies( zone_a, zone_b )
{
    script_index_a = zone_a.script_index;
    script_index_b = zone_b.script_index;
    
    if ( !isdefined( script_index_a ) && !isdefined( script_index_b ) )
    {
        return false;
    }
    
    if ( !isdefined( script_index_a ) && isdefined( script_index_b ) )
    {
        println( "<dev string:x28>" + zone_a.origin );
        return true;
    }
    
    if ( isdefined( script_index_a ) && !isdefined( script_index_b ) )
    {
        println( "<dev string:x28>" + zone_b.origin );
        return false;
    }
    
    if ( script_index_a > script_index_b )
    {
        return true;
    }
    
    return false;
}

// Namespace strong/strong
// Params 0
// Checksum 0x4be1b45, Offset: 0x1020
// Size: 0x336
function get_zone_array()
{
    if ( level.zonecount > 1 )
    {
        allzones = struct::get_array( "stronghold_zone_center", "targetname" );
        
        if ( !isdefined( allzones ) )
        {
            return;
        }
        
        zoneindices = [];
        numberofzones = level.zonecount;
        
        for ( i = 0; i < numberofzones ; i++ )
        {
            fieldname = "zoneinfo" + numberofzones + i + 1;
            index = isdefined( level.mission_bundle.( fieldname ) ) ? level.mission_bundle.( fieldname ) : 0;
            zoneindices[ zoneindices.size ] = index;
        }
        
        zones = [];
        
        for ( i = 0; i < allzones.size ; i++ )
        {
            ind = allzones[ i ].script_index;
            
            if ( isdefined( ind ) )
            {
                for ( j = 0; j < zoneindices.size ; j++ )
                {
                    if ( zoneindices[ j ] == ind )
                    {
                        zones[ zones.size ] = allzones[ i ];
                        break;
                    }
                }
            }
        }
    }
    else
    {
        zones = struct::get_array( "stronghold_zone_center", "targetname" );
    }
    
    if ( !isdefined( zones ) )
    {
        return undefined;
    }
    
    swapped = 1;
    
    for ( n = zones.size; swapped ; n-- )
    {
        swapped = 0;
        
        for ( i = 0; i < n - 1 ; i++ )
        {
            if ( compare_zone_indicies( zones[ i ], zones[ i + 1 ] ) )
            {
                temp = zones[ i ];
                zones[ i ] = zones[ i + 1 ];
                zones[ i + 1 ] = temp;
                swapped = 1;
            }
        }
    }
    
    for ( i = 0; i < zones.size ; i++ )
    {
        zones[ i ].zone_index = i;
    }
    
    return zones;
}

// Namespace strong/strong
// Params 7
// Checksum 0xbfe55274, Offset: 0x1360
// Size: 0x1b4
function warzone( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( level.zones.size == 0 )
    {
        level.zones = get_zone_array();
        
        for ( zi = 0; zi < level.zones.size ; zi++ )
        {
            if ( isdefined( level.zones[ zi ].target ) )
            {
                level.visuals[ zi ] = struct::get_array( level.zones[ zi ].target, "targetname" );
            }
        }
    }
    
    level.current_zone_mask[ localclientnum ] = newval;
    
    for ( zi = 0; zi < level.zones.size ; zi++ )
    {
        if ( ( oldval & 1 << zi ) != ( newval & 1 << zi ) )
        {
            level.current_zone_state_mask[ localclientnum ] &= ~( 3 << zi );
        }
    }
    
    setup_warzone_fx( localclientnum );
}

// Namespace strong/strong
// Params 7
// Checksum 0xd9fb5e9a, Offset: 0x1520
// Size: 0x84
function warzone_state( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval != level.current_zone_state_mask[ localclientnum ] )
    {
        level.current_zone_state_mask[ localclientnum ] = newval;
        setup_warzone_fx( localclientnum );
    }
}

// Namespace strong/strong
// Params 1
// Checksum 0x2e969b99, Offset: 0x15b0
// Size: 0x7c
function watch_for_team_change( localclientnum )
{
    level notify( #"end_team_change_watch" );
    level endon( #"end_team_change_watch" );
    level waittill( "team_changed" );
    
    while ( !isdefined( getnonpredictedlocalplayer( localclientnum ) ) )
    {
        wait 0.05;
    }
    
    thread setup_warzone_fx( localclientnum );
}

