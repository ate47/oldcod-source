#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/duplicaterender_mgr;
#using scripts/core_common/struct;
#using scripts/core_common/util_shared;

#namespace frontline;

// Namespace frontline/GameType_Init
// Params 1, eflags: 0x40
// Checksum 0x624a8c52, Offset: 0x1e0
// Size: 0xdc
function event_handler[GameType_Init] main( eventstruct )
{
    level._effect[ "zoneEdgeMarker" ] = [];
    level._effect[ "zoneEdgeMarker" ][ 1 ] = "ui/fx8_strnghold_marker_blue";
    level._effect[ "zoneEdgeMarker" ][ 2 ] = "ui/fx8_strnghold_marker_orng";
    callback::on_localplayer_spawned( &on_localclient_spawned );
    clientfield::register( "allplayers", "inProtectedZone", 1, 2, "int", &player_protectedzone_changed, 0, 1 );
}

// Namespace frontline/frontline
// Params 7
// Checksum 0x8e60120d, Offset: 0x2c8
// Size: 0xac
function player_protectedzone_changed( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 2 )
    {
        self duplicate_render::update_dr_flag( localclientnum, "threat_detector_enemy", 1 );
        return;
    }
    
    if ( newval == 0 && oldval == 2 )
    {
        self duplicate_render::update_dr_flag( localclientnum, "threat_detector_enemy", 0 );
    }
}

// Namespace frontline/frontline
// Params 2
// Checksum 0x311a4dfd, Offset: 0x380
// Size: 0x7c
function getzonemarkerfx( zonemarker, local_client_num )
{
    if ( util::friend_not_foe_team( local_client_num, zonemarker.script_team, 1 ) )
    {
        return level._effect[ "zoneEdgeMarker" ][ 1 ];
    }
    
    return level._effect[ "zoneEdgeMarker" ][ 2 ];
}

// Namespace frontline/frontline
// Params 1
// Checksum 0x542889b2, Offset: 0x408
// Size: 0x22c
function setupprotectionzonemarkers( local_client_num )
{
    while ( !isdefined( getnonpredictedlocalplayer( local_client_num ) ) )
    {
        waitframe( 1 );
    }
    
    zonemarkers = struct::get_array( "zoneEdgeMarker", "targetname" );
    
    foreach ( zonemarker in zonemarkers )
    {
        if ( isdefined( zonemarker.fxhandle ) )
        {
            stopfx( local_client_num, zonemarker.fxhandle );
        }
        
        forward = undefined;
        assignedzoneteam = zonemarker.script_team;
        
        if ( isdefined( zonemarker.angles ) )
        {
            forward = anglestoforward( zonemarker.angles );
        }
        else
        {
            forward = ( 0, 0, 0 );
        }
        
        zonefx = getzonemarkerfx( zonemarker, local_client_num );
        zonemarker.fxhandle = playfx( local_client_num, zonefx, zonemarker.origin, forward );
        
        if ( isdefined( zonemarker.fxhandle ) )
        {
            setfxteam( local_client_num, zonemarker.fxhandle, assignedzoneteam );
        }
    }
    
    thread watch_for_team_change( local_client_num );
}

// Namespace frontline/frontline
// Params 1
// Checksum 0x4c8105d1, Offset: 0x640
// Size: 0x54
function watch_for_team_change( localclientnum )
{
    level notify( #"end_team_change_watch" );
    level endon( #"end_team_change_watch" );
    level waittill( "team_changed" );
    thread setupprotectionzonemarkers( localclientnum );
}

// Namespace frontline/frontline
// Params 1
// Checksum 0xc1750548, Offset: 0x6a0
// Size: 0x6c
function on_localclient_spawned( localclientnum )
{
    if ( self != getlocalplayer( localclientnum ) )
    {
        return;
    }
    
    if ( isdefined( self.frontlinevisualssetup ) && self.frontlinevisualssetup )
    {
        return;
    }
    
    thread setupprotectionzonemarkers( localclientnum );
    self.frontlinevisualssetup = 1;
}

// Namespace frontline/frontline
// Params 0
// Checksum 0x80f724d1, Offset: 0x718
// Size: 0x4
function onprecachegametype()
{
    
}

// Namespace frontline/frontline
// Params 0
// Checksum 0x80f724d1, Offset: 0x728
// Size: 0x4
function onstartgametype()
{
    
}

