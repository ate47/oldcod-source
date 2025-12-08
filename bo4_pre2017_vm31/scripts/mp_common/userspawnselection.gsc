#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/spawning_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace userspawnselection;

// Namespace userspawnselection/userspawnselection
// Params 0, eflags: 0x2
// Checksum 0x26d20a01, Offset: 0x328
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "userspawnselection", &__init__, undefined, undefined );
}

// Namespace userspawnselection/userspawnselection
// Params 0
// Checksum 0xb1f5ced8, Offset: 0x368
// Size: 0x16c
function __init__()
{
    level.spawnselect = spawnstruct();
    level.spawnselect.spawnbeacons = [];
    level.spawnselect.lastchosenplayerspawns = [];
    level.spawnselectenabled = getgametypesetting( "spawnSelectEnabled" );
    level.useteamspecificforwardspawns = getgametypesetting( "forwardSpawnTeamSpecificSpawns" );
    level.spawngroups = [];
    level.next_spawn_group_index = 0;
    level.spawnselect_timelimit_ms = getdvarint( "spawnselect_timelimit_ms", 10000 );
    
    if ( isspawnselectenabled() )
    {
        callback::on_start_gametype( &on_start_gametype );
        callback::on_disconnect( &on_player_disconnect );
        spawning::setgamemodepopulatespawnlistcallback( &populatespawnlistcallback );
    }
    
    registerclientfields();
}

// Namespace userspawnselection/userspawnselection
// Params 2
// Checksum 0x3134f997, Offset: 0x4e0
// Size: 0x6a
function registeravailablespawnbeacon( spawnbeaconid, spawnbeacon )
{
    assert( !isdefined( level.spawnselect.spawnbeacons[ spawnbeaconid ] ) );
    level.spawnselect.spawnbeacons[ spawnbeaconid ] = spawnbeacon;
}

// Namespace userspawnselection/userspawnselection
// Params 1
// Checksum 0x6b6caed1, Offset: 0x558
// Size: 0xa4
function removespawnbeacon( spawnbeaconid )
{
    if ( !isdefined( level.spawnselect.spawnbeacons[ spawnbeaconid ] ) )
    {
        return;
    }
    
    spawnbeacon = level.spawnselect.spawnbeacons[ spawnbeaconid ];
    
    if ( isdefined( spawnbeacon ) && isdefined( spawnbeacon.spawnlist ) )
    {
        clearspawnpoints( spawnbeacon.spawnlist );
    }
    
    level.spawnselect.spawnbeacons[ spawnbeaconid ] = undefined;
}

// Namespace userspawnselection/userspawnselection
// Params 0
// Checksum 0x59b724f4, Offset: 0x608
// Size: 0xe
function isspawnselectenabled()
{
    return level.spawnselectenabled;
}

// Namespace userspawnselection/userspawnselection
// Params 1
// Checksum 0x69449e9b, Offset: 0x620
// Size: 0x1c
function getspawngroup( index )
{
    return level.spawngroups[ index ];
}

// Namespace userspawnselection/userspawnselection
// Params 1
// Checksum 0x14d36861, Offset: 0x648
// Size: 0xc6
function getspawngroupbyname( groupname )
{
    retunrarr = [];
    
    foreach ( spawngroup in level.spawngroups )
    {
        if ( spawngroup.groupname == groupname )
        {
            array::add( retunrarr, spawngroup );
        }
    }
    
    return retunrarr;
}

// Namespace userspawnselection/userspawnselection
// Params 1
// Checksum 0xbdaaaafd, Offset: 0x718
// Size: 0xc6
function getspawngroupsforzone( zoneindex )
{
    returnarray = [];
    
    foreach ( spawngroup in level.spawngroups )
    {
        if ( spawngroup.script_zoneindex == zoneindex )
        {
            array::add( returnarray, spawngroup );
        }
    }
    
    return returnarray;
}

// Namespace userspawnselection/userspawnselection
// Params 1
// Checksum 0xda5e7e08, Offset: 0x7e8
// Size: 0xd6
function getspawngroupwithscriptnoteworthy( script_noteworthy )
{
    returnarray = [];
    
    foreach ( spawngroup in level.spawngroups )
    {
        if ( isdefined( spawngroup.script_noteworthy ) && spawngroup.script_noteworthy == script_noteworthy )
        {
            array::add( returnarray, spawngroup );
        }
    }
    
    return returnarray;
}

// Namespace userspawnselection/userspawnselection
// Params 1
// Checksum 0xd636f3a6, Offset: 0x8c8
// Size: 0x64
function changeusability( isusable )
{
    usestatusmodel = getclientfieldprefix( self.uiindex ) + "useStatus";
    self.ison = isusable;
    level clientfield::set_world_uimodel( usestatusmodel, isusable );
}

// Namespace userspawnselection/userspawnselection
// Params 1
// Checksum 0x169289c1, Offset: 0x938
// Size: 0x5c
function changevisibility( isvisible )
{
    visstatusmodel = getclientfieldprefix( self.uiindex ) + "visStatus";
    level clientfield::set_world_uimodel( visstatusmodel, isvisible );
}

// Namespace userspawnselection/userspawnselection
// Params 1
// Checksum 0x395c3cb3, Offset: 0x9a0
// Size: 0xb4
function changeteam( teamname )
{
    teamclientfieldindex = getteamclientfieldvalue( teamname );
    teammodel = getclientfieldprefix( self.uiindex ) + "team";
    level clientfield::set_world_uimodel( teammodel, teamclientfieldindex );
    enablespawnpointlist( self.spawnlist, util::getteammask( teamname ) );
}

// Namespace userspawnselection/userspawnselection
// Params 0
// Checksum 0xd574d10, Offset: 0xa60
// Size: 0xd2
function setspawngroupsenabled()
{
    if ( !isdefined( level.spawngroups ) )
    {
        return;
    }
    
    foreach ( spawngroup in level.spawngroups )
    {
        if ( !spawngroup.isforwardspawn )
        {
            spawngroup changeusability( 1 );
        }
        
        spawngroup changevisibility( 1 );
    }
}

// Namespace userspawnselection/userspawnselection
// Params 1
// Checksum 0x930f2be0, Offset: 0xb40
// Size: 0x10, Type: bool
function canplayerusespawngroup( spawngroupindex )
{
    return true;
}

// Namespace userspawnselection/userspawnselection
// Params 1
// Checksum 0x5ae12a6c, Offset: 0xb58
// Size: 0x32
function setspawngroupforplayer( selectedspawngroupindex )
{
    level.spawnselect.lastchosenplayerspawns[ self.clientid ] = selectedspawngroupindex;
}

// Namespace userspawnselection/userspawnselection
// Params 0
// Checksum 0x17ba453d, Offset: 0xb98
// Size: 0xd0
function getspawnbeaconplayerspawnedfrom()
{
    player = self;
    
    if ( !isdefined( level.spawnselect.lastchosenplayerspawns[ player.clientid ] ) || level.usestartspawns )
    {
        return undefined;
    }
    
    spawbeaconid = level.spawnselect.lastchosenplayerspawns[ player.clientid ];
    
    if ( spawbeaconid == -1 )
    {
        return undefined;
    }
    
    if ( !isdefined( level.spawnselect.spawnbeacons[ spawbeaconid ] ) )
    {
        return undefined;
    }
    
    return level.spawnselect.spawnbeacons[ spawbeaconid ];
}

// Namespace userspawnselection/userspawnselection
// Params 0
// Checksum 0x785b6dcf, Offset: 0xc70
// Size: 0x122
function fillspawnlists()
{
    foreach ( spawngroup in level.spawngroups )
    {
        if ( !level.useteamspecificforwardspawns )
        {
            if ( isdefined( spawngroup.spawnflags ) && ( spawngroup.spawnflags & 1 ) == 1 && spawngroup.script_team == "defenders" )
            {
                continue;
            }
        }
        
        spawngroup setupspawnlistforspawngroup( spawngroup.groupname, spawngroup.spawnlist, getteamname( spawngroup.script_team ) );
    }
}

// Namespace userspawnselection/userspawnselection
// Params 0
// Checksum 0x8fcc1c20, Offset: 0xda0
// Size: 0x7c
function clearcacheforplayer()
{
    if ( !isdefined( self ) || !isdefined( self.clientid ) )
    {
        return;
    }
    
    if ( isdefined( level.spawnselect.lastchosenplayerspawns ) && isdefined( level.spawnselect.lastchosenplayerspawns[ self.clientid ] ) )
    {
        level.spawnselect.lastchosenplayerspawns[ self.clientid ] = undefined;
    }
}

// Namespace userspawnselection/userspawnselection
// Params 0
// Checksum 0x7929fe67, Offset: 0xe28
// Size: 0x1c
function clearcacheforallplayers()
{
    level.spawnselect.lastchosenplayerspawns = [];
}

// Namespace userspawnselection/userspawnselection
// Params 0
// Checksum 0xfdea735a, Offset: 0xe50
// Size: 0x88
function getlastchosenspawngroupforplayer()
{
    if ( !isdefined( level.spawnselect.lastchosenplayerspawns[ self.clientid ] ) )
    {
        return undefined;
    }
    
    lastchosenid = level.spawnselect.lastchosenplayerspawns[ self.clientid ];
    
    if ( !isdefined( level.spawngroups[ lastchosenid ] ) )
    {
        return undefined;
    }
    
    return level.spawngroups[ lastchosenid ];
}

// Namespace userspawnselection/userspawnselection
// Params 0
// Checksum 0x7db051c6, Offset: 0xee0
// Size: 0x34
function onroundchange()
{
    clearcacheforallplayers();
    supressspawnselectionmenuforallplayers();
    closespawnselectionmenuforallplayers();
}

// Namespace userspawnselection/userspawnselection
// Params 0
// Checksum 0x609df86e, Offset: 0xf20
// Size: 0x14
function supressspawnselectionmenuforallplayers()
{
    level.showspawnselectionmenu = [];
}

// Namespace userspawnselection/userspawnselection
// Params 0
// Checksum 0xad8462b8, Offset: 0xf40
// Size: 0x5c, Type: bool
function shouldshowspawnselectionmenu()
{
    isbot = self isbot();
    return isdefined( level.showspawnselectionmenu ) && isdefined( level.showspawnselectionmenu[ self.clientid ] ) && !isbot;
}

// Namespace userspawnselection/userspawnselection
// Params 0
// Checksum 0x4aecacd, Offset: 0xfa8
// Size: 0x22
function activatespawnselectionmenu()
{
    level.showspawnselectionmenu[ self.clientid ] = 1;
}

// Namespace userspawnselection/userspawnselection
// Params 0
// Checksum 0xf6359d3c, Offset: 0xfd8
// Size: 0x24
function openspawnselect()
{
    self clientfield::set_player_uimodel( "hudItems.showSpawnSelect", 1 );
}

// Namespace userspawnselection/userspawnselection
// Params 0
// Checksum 0x69d481b, Offset: 0x1008
// Size: 0x24
function closespawnselect()
{
    self clientfield::set_player_uimodel( "hudItems.showSpawnSelect", 0 );
}

// Namespace userspawnselection/userspawnselection
// Params 0
// Checksum 0xb28c1a47, Offset: 0x1038
// Size: 0xa2
function closespawnselectionmenuforallplayers()
{
    players = getplayers();
    
    foreach ( player in players )
    {
        player closespawnselect();
    }
}

// Namespace userspawnselection/userspawnselection
// Params 0
// Checksum 0x2c623b22, Offset: 0x10e8
// Size: 0x130
function openspawnselectionandwait()
{
    self endon( #"disconnect" );
    self endon( #"end_respawn" );
    util::wait_network_frame( 2 );
    spawnselected = 0;
    self openspawnselect();
    self thread watchforselectiontimeout();
    
    while ( !spawnselected )
    {
        waitresult = self waittill( "menuresponse" );
        menu = waitresult.menu;
        response = waitresult.response;
        
        if ( menu == "Hud_MP" )
        {
            if ( isplayer( self ) )
            {
                self setspawngroupforplayer( int( response ) );
            }
            
            spawnselected = 1;
        }
        
        waitframe( 1 );
    }
}

// Namespace userspawnselection/userspawnselection
// Params 0
// Checksum 0x35382438, Offset: 0x1220
// Size: 0xa4
function watchforselectiontimeout()
{
    self endon( #"disconnect" );
    self endon( #"end_respawn" );
    self.spawnselect_start_time = gettime();
    self clientfield::set_to_player( "spawnselect_timeout", self.spawnselect_start_time );
    
    while ( true )
    {
        if ( level.spawnselect_timelimit_ms - gettime() - self.spawnselect_start_time <= 0 )
        {
            self luinotifyevent( &"force_spawn_selection" );
            return;
        }
        
        wait 0.1;
    }
}

// Namespace userspawnselection/userspawnselection
// Params 0, eflags: 0x4
// Checksum 0x4cbd9b5a, Offset: 0x12d0
// Size: 0x1c
function private on_player_disconnect()
{
    self clearcacheforplayer();
}

// Namespace userspawnselection/userspawnselection
// Params 1, eflags: 0x4
// Checksum 0x83bfa8e8, Offset: 0x12f8
// Size: 0x14c
function private populatespawnlistcallback( &spawnlistarray )
{
    if ( !isdefined( level.spawnselect.lastchosenplayerspawns[ self.clientid ] ) || level.usestartspawns )
    {
        return;
    }
    
    spawbeaconid = level.spawnselect.lastchosenplayerspawns[ self.clientid ];
    
    if ( spawbeaconid == -1 )
    {
        return;
    }
    
    if ( !isdefined( level.spawnselect.spawnbeacons[ spawbeaconid ] ) )
    {
        /#
            print( "^1WARNING: Tried to choose a spawn beacon ID that does not exist! Using auto spawns instead." );
        #/
        
        level.spawnselect.lastchosenplayerspawns[ self.clientid ] = -1;
        return;
    }
    
    while ( spawnlistarray.size > 0 )
    {
        array::pop_front( spawnlistarray );
    }
    
    array::add( spawnlistarray, level.spawnselect.spawnbeacons[ spawbeaconid ].spawnlist );
}

// Namespace userspawnselection/userspawnselection
// Params 1, eflags: 0x4
// Checksum 0xcb20d88a, Offset: 0x1450
// Size: 0x20
function private getclientfieldprefix( id )
{
    return "spawngroupStatus." + id + ".";
}

// Namespace userspawnselection/userspawnselection
// Params 0, eflags: 0x4
// Checksum 0xf25727cd, Offset: 0x1478
// Size: 0x154
function private registerclientfields()
{
    for ( index = 0; index < 20 ; index++ )
    {
        basename = getclientfieldprefix( index );
        clientfield::register( "worlduimodel", basename + "visStatus", 1, 1, "int" );
        clientfield::register( "worlduimodel", basename + "useStatus", 1, 1, "int" );
        clientfield::register( "worlduimodel", basename + "team", 1, 2, "int" );
    }
    
    clientfield::register( "toplayer", "spawnselect_timeout", 1, 1, "int" );
    clientfield::register( "clientuimodel", "hudItems.showSpawnSelect", 1, 1, "int" );
}

// Namespace userspawnselection/userspawnselection
// Params 0
// Checksum 0x7d1b7c4, Offset: 0x15d8
// Size: 0x2c
function waitandenablespawngroups()
{
    util::wait_network_frame( 1 );
    setspawngroupsenabled();
}

// Namespace userspawnselection/userspawnselection
// Params 0
// Checksum 0x52c9c010, Offset: 0x1610
// Size: 0x194
function on_start_gametype()
{
    spawngroups = struct::get_array( "spawn_group_marker", "targetname" );
    
    if ( !isdefined( spawngroups ) || spawngroups.size == 0 )
    {
        return;
    }
    
    spawngroupssorted = arraysort( spawngroups, ( 0, 0, 0 ), 1 );
    
    foreach ( spawngroup in spawngroupssorted )
    {
        if ( isdefined( spawngroup.spawnflags ) && !level.useteamspecificforwardspawns && ( spawngroup.spawnflags & 1 ) == 1 && spawngroup.script_team == "defenders" )
        {
            continue;
        }
        
        setupspawngroup( spawngroup );
    }
    
    waitandenablespawngroups();
    
    if ( isspawnselectenabled() )
    {
        fillspawnlists();
    }
}

// Namespace userspawnselection/userspawnselection
// Params 3, eflags: 0x4
// Checksum 0x40fffa26, Offset: 0x17b0
// Size: 0x264
function private setupspawnlistforspawngroup( spawngroupkey, spawnlistname, team )
{
    rawspawns = struct::get_array( spawngroupkey, "targetname" );
    
    if ( !isdefined( rawspawns ) )
    {
        return;
    }
    
    self.spawns = [];
    
    foreach ( spawn in rawspawns )
    {
        if ( spawn.targetname == "spawn_group_marker" )
        {
            continue;
        }
        
        if ( !isdefined( spawn.enabled ) )
        {
            spawn.enabled = -1;
        }
        
        array::add( self.spawns, spawn );
    }
    
    if ( level.useteamspecificforwardspawns )
    {
        addspawnpoints( team, self.spawns, spawnlistname );
    }
    else
    {
        addspawnpoints( game.attackers, self.spawns, spawnlistname );
        addspawnpoints( game.defenders, self.spawns, spawnlistname );
    }
    
    if ( level.forwardspawnsettings.isenabled && level.forwardspawnsettings.isneutral && !level.useteamspecificforwardspawns )
    {
        if ( !self.isforwardspawn )
        {
            self changeteam( team );
        }
        else
        {
            self changeteam( "neutral" );
        }
        
        return;
    }
    
    self changeteam( team );
}

// Namespace userspawnselection/userspawnselection
// Params 1, eflags: 0x4
// Checksum 0xa6125c1b, Offset: 0x1a20
// Size: 0x9c
function private setupspawngroup( spawngroup )
{
    spawngroup.uiindex = level.next_spawn_group_index;
    level.next_spawn_group_index++;
    level.spawngroups[ spawngroup.uiindex ] = spawngroup;
    spawngroup.isforwardspawn = isdefined( spawngroup.spawnflags ) && ( spawngroup.spawnflags & 1 ) == 1;
    spawngroup.ison = 0;
}

// Namespace userspawnselection/userspawnselection
// Params 1
// Checksum 0xf82c5186, Offset: 0x1ac8
// Size: 0x68
function getteamname( raw_team_str )
{
    returnstr = raw_team_str;
    
    if ( raw_team_str == "attackers" )
    {
        returnstr = game.attackers;
    }
    else if ( raw_team_str == "defenders" )
    {
        returnstr = game.defenders;
    }
    
    return returnstr;
}

// Namespace userspawnselection/userspawnselection
// Params 1
// Checksum 0xb29a786a, Offset: 0x1b38
// Size: 0x90
function getteamclientfieldvalue( team )
{
    if ( !isdefined( team ) )
    {
        return 0;
    }
    
    teamname = getteamname( team );
    
    if ( team == "allies" )
    {
        return 1;
    }
    else if ( team == "axis" )
    {
        return 2;
    }
    else if ( team == "neutral" )
    {
        return 3;
    }
    
    return 0;
}

