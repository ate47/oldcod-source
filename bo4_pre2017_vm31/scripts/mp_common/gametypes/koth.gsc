#using scripts/core_common/callbacks_shared;
#using scripts/core_common/challenges_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/demo_shared;
#using scripts/core_common/gameobjects_shared;
#using scripts/core_common/hostmigration_shared;
#using scripts/core_common/hud_util_shared;
#using scripts/core_common/influencers_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/medals_shared;
#using scripts/core_common/popups_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/sound_shared;
#using scripts/core_common/spawning_shared;
#using scripts/core_common/util_shared;
#using scripts/mp_common/challenges;
#using scripts/mp_common/gametypes/battlechatter;
#using scripts/mp_common/gametypes/globallogic;
#using scripts/mp_common/gametypes/globallogic_audio;
#using scripts/mp_common/gametypes/globallogic_score;
#using scripts/mp_common/gametypes/globallogic_utils;
#using scripts/mp_common/gametypes/hostmigration;
#using scripts/mp_common/gametypes/spawning;
#using scripts/mp_common/util;

#namespace koth;

// Namespace koth/GameType_Init
// Params 1, eflags: 0x40
// Checksum 0x33287bab, Offset: 0x918
// Size: 0x4bc
function event_handler[GameType_Init] main( eventstruct )
{
    globallogic::init();
    util::registertimelimit( 0, 1440 );
    util::registerscorelimit( 0, 1000 );
    util::registernumlives( 0, 100 );
    util::registerroundswitch( 0, 9 );
    util::registerroundwinlimit( 0, 10 );
    globallogic::registerfriendlyfiredelay( level.gametype, 15, 0, 1440 );
    level.teambased = 1;
    level.doprematch = 1;
    level.overrideteamscore = 1;
    level.scoreroundwinbased = 1;
    level.kothstarttime = 0;
    level.onstartgametype = &onstartgametype;
    level.playerspawnedcb = &koth_playerspawnedcb;
    level.onroundswitch = &onroundswitch;
    level.onplayerkilled = &onplayerkilled;
    level.onendgame = &onendgame;
    clientfield::register( "world", "hardpoint", 1, 5, "int" );
    clientfield::register( "world", "hardpointteam", 1, 5, "int" );
    level.zoneautomovetime = getgametypesetting( "autoDestroyTime" );
    level.zonespawntime = getgametypesetting( "objectiveSpawnTime" );
    level.kothmode = getgametypesetting( "kothMode" );
    level.capturetime = getgametypesetting( "captureTime" );
    level.destroytime = getgametypesetting( "destroyTime" );
    level.delayplayer = getgametypesetting( "delayPlayer" );
    level.randomzonespawn = getgametypesetting( "randomObjectiveLocations" );
    level.scoreperplayer = getgametypesetting( "scorePerPlayer" );
    level.timepauseswheninzone = getgametypesetting( "timePausesWhenInZone" );
    level.iconoffset = ( 0, 0, 32 );
    gameobjects::register_allowed_gameobject( level.gametype );
    globallogic_audio::set_leader_gametype_dialog( "startHardPoint", "hcStartHardPoint", "objCapture", "objCapture" );
    game.objective_gained_sound = "mpl_flagcapture_sting_friend";
    game.objective_lost_sound = "mpl_flagcapture_sting_enemy";
    game.objective_contested_sound = "mpl_flagreturn_sting";
    level.zonespawnqueue = [];
    
    if ( !sessionmodeissystemlink() && !sessionmodeisonlinegame() && issplitscreen() )
    {
        globallogic::setvisiblescoreboardcolumns( "score", "kills", "objtime", "defends", "deaths" );
        return;
    }
    
    globallogic::setvisiblescoreboardcolumns( "score", "kills", "deaths", "objtime", "defends" );
}

// Namespace koth/koth
// Params 3
// Checksum 0x6571248e, Offset: 0xde0
// Size: 0xe0
function updateobjectivehintmessages( defenderteam, defendmessage, attackmessage )
{
    foreach ( team in level.teams )
    {
        if ( defenderteam == team )
        {
            game.strings[ "objective_hint_" + team ] = defendmessage;
            continue;
        }
        
        game.strings[ "objective_hint_" + team ] = attackmessage;
    }
}

// Namespace koth/koth
// Params 1
// Checksum 0x26c4c6dc, Offset: 0xec8
// Size: 0xa0
function updateobjectivehintmessage( message )
{
    foreach ( team in level.teams )
    {
        game.strings[ "objective_hint_" + team ] = message;
    }
}

// Namespace koth/koth
// Params 0
// Checksum 0x9a068edd, Offset: 0xf70
// Size: 0x47c
function onstartgametype()
{
    globallogic_utils::switch_sides();
    globallogic_score::resetteamscores();
    
    foreach ( team in level.teams )
    {
        util::setobjectivetext( team, &"OBJECTIVES_KOTH" );
        
        if ( level.splitscreen )
        {
            util::setobjectivescoretext( team, &"OBJECTIVES_KOTH" );
            continue;
        }
        
        util::setobjectivescoretext( team, &"OBJECTIVES_KOTH_SCORE" );
    }
    
    level.kothtotalsecondsinzone = 0;
    level.objectivehintpreparezone = &"MP_CONTROL_KOTH";
    level.objectivehintcapturezone = &"MP_CAPTURE_KOTH";
    level.objectivehintdefendhq = &"MP_DEFEND_KOTH";
    
    if ( level.zonespawntime )
    {
        updateobjectivehintmessage( level.objectivehintpreparezone );
    }
    else
    {
        updateobjectivehintmessage( level.objectivehintcapturezone );
    }
    
    setclientnamemode( "auto_change" );
    influencers::create_map_placed_influencers();
    level.spawnmins = ( 0, 0, 0 );
    level.spawnmaxs = ( 0, 0, 0 );
    
    foreach ( team in level.teams )
    {
        spawning::add_spawn_points( team, "mp_tdm_spawn" );
        spawning::add_spawn_points( team, "mp_multi_team_spawn" );
        spawning::place_spawn_points( spawning::gettdmstartspawnname( team ) );
    }
    
    spawning::updateallspawnpoints();
    
    foreach ( team in level.teams )
    {
        spawning::add_start_spawn_points( team, spawning::gettdmstartspawnname( team ) );
    }
    
    level.mapcenter = math::find_box_center( level.spawnmins, level.spawnmaxs );
    setmapcenter( level.mapcenter );
    spawnpoint = spawning::get_random_intermission_point();
    setdemointermissionpoint( spawnpoint.origin, spawnpoint.angles );
    level.spawn_all = spawning::get_spawnpoint_array( "mp_tdm_spawn" );
    
    if ( !level.spawn_all.size )
    {
        println( "<dev string:x28>" );
        callback::abort_level();
        return;
    }
    
    thread setupzones();
    updategametypedvars();
    thread kothmainloop();
}

// Namespace koth/koth
// Params 0
// Checksum 0x4ca25b9d, Offset: 0x13f8
// Size: 0x34
function pause_time()
{
    if ( level.timepauseswheninzone )
    {
        globallogic_utils::pausetimer();
        level.timerpaused = 1;
    }
}

// Namespace koth/koth
// Params 0
// Checksum 0x1b82e1d7, Offset: 0x1438
// Size: 0x44
function resume_time()
{
    if ( level.timepauseswheninzone )
    {
        globallogic_utils::resumetimerdiscardoverride( level.kothtotalsecondsinzone * 1000 );
        level.timerpaused = 0;
    }
}

// Namespace koth/koth
// Params 0
// Checksum 0x4534ec91, Offset: 0x1488
// Size: 0x50
function updategametypedvars()
{
    level.playercapturelpm = getgametypesetting( "maxPlayerEventsPerMinute" );
    level.timepauseswheninzone = getgametypesetting( "timePausesWhenInZone" );
}

// Namespace koth/koth
// Params 1
// Checksum 0xe5baeceb, Offset: 0x14e0
// Size: 0x14c
function spawn_first_zone( delay )
{
    if ( level.randomzonespawn == 1 )
    {
        level.zone = getnextzonefromqueue();
    }
    else
    {
        level.zone = getfirstzone();
    }
    
    if ( isdefined( level.zone ) )
    {
        /#
            print( "<dev string:x50>" + level.zone.trigorigin[ 0 ] + "<dev string:x60>" + level.zone.trigorigin[ 1 ] + "<dev string:x60>" + level.zone.trigorigin[ 2 ] + "<dev string:x62>" );
        #/
        
        level.zone enable_influencers( 1 );
    }
    
    level.zone.gameobject.trigger allowtacticalinsertion( 0 );
}

// Namespace koth/koth
// Params 0
// Checksum 0x8e7a4629, Offset: 0x1638
// Size: 0x174
function spawn_next_zone()
{
    level.zone.gameobject.trigger allowtacticalinsertion( 1 );
    
    if ( level.randomzonespawn != 0 )
    {
        level.zone = getnextzonefromqueue();
    }
    else
    {
        level.zone = getnextzone();
    }
    
    if ( isdefined( level.zone ) )
    {
        /#
            print( "<dev string:x50>" + level.zone.trigorigin[ 0 ] + "<dev string:x60>" + level.zone.trigorigin[ 1 ] + "<dev string:x60>" + level.zone.trigorigin[ 2 ] + "<dev string:x62>" );
        #/
        
        level.zone enable_influencers( 1 );
    }
    
    level.zone.gameobject.trigger allowtacticalinsertion( 0 );
}

// Namespace koth/koth
// Params 0
// Checksum 0xb09af081, Offset: 0x17b8
// Size: 0xa6
function getnumtouching()
{
    numtouching = 0;
    
    foreach ( team in level.teams )
    {
        numtouching += self.numtouching[ team ];
    }
    
    return numtouching;
}

// Namespace koth/koth
// Params 1
// Checksum 0xbf7a6cc8, Offset: 0x1868
// Size: 0x74
function togglezoneeffects( enabled )
{
    index = 0;
    
    if ( enabled )
    {
        index = self.script_index;
    }
    
    level clientfield::set( "hardpoint", index );
    level clientfield::set( "hardpointteam", 0 );
}

// Namespace koth/koth
// Params 0
// Checksum 0x6aa137d1, Offset: 0x18e8
// Size: 0x4e0
function kothcaptureloop()
{
    level endon( #"game_ended" );
    level endon( #"zone_moved" );
    level.kothstarttime = gettime();
    
    while ( true )
    {
        level.zone.gameobject gameobjects::allow_use( "any" );
        level.zone.gameobject gameobjects::set_use_time( level.capturetime );
        level.zone.gameobject gameobjects::set_use_text( &"MP_CAPTURING_OBJECTIVE" );
        numtouching = level.zone.gameobject getnumtouching();
        level.zone.gameobject gameobjects::set_visible_team( "any" );
        level.zone.gameobject gameobjects::set_model_visibility( 1 );
        level.zone.gameobject gameobjects::must_maintain_claim( 0 );
        level.zone.gameobject gameobjects::can_contest_claim( 1 );
        level.zone.gameobject.onuse = &onzonecapture;
        level.zone.gameobject.onbeginuse = &onbeginuse;
        level.zone.gameobject.onenduse = &onenduse;
        level.zone togglezoneeffects( 1 );
        msg = level waittill( "zone_captured", "zone_destroyed" );
        
        if ( msg._notify == "zone_destroyed" )
        {
            continue;
        }
        
        ownerteam = level.zone.gameobject gameobjects::get_owner_team();
        
        foreach ( team in level.teams )
        {
            updateobjectivehintmessages( ownerteam, level.objectivehintdefendhq, level.objectivehintcapturezone );
        }
        
        level.zone.gameobject gameobjects::allow_use( "none" );
        level.zone.gameobject.onuse = undefined;
        level.zone.gameobject.onunoccupied = &onzoneunoccupied;
        level.zone.gameobject.oncontested = &onzonecontested;
        level.zone.gameobject.onuncontested = &onzoneuncontested;
        waitresult = level waittill( "zone_destroyed" );
        
        if ( !level.kothmode || level.zonedestroyedbytimer )
        {
            break;
        }
        
        thread forcespawnteam( ownerteam );
        
        if ( isdefined( waitresult.destroy_team ) )
        {
            level.zone.gameobject gameobjects::set_owner_team( waitresult.destroy_team );
            continue;
        }
        
        level.zone.gameobject gameobjects::set_owner_team( "none" );
    }
}

// Namespace koth/koth
// Params 0
// Checksum 0xffc41bd1, Offset: 0x1dd0
// Size: 0x6c8
function kothmainloop()
{
    level endon( #"game_ended" );
    spawn_first_zone();
    
    while ( level.inprematchperiod )
    {
        waitframe( 1 );
    }
    
    pause_time();
    wait 5;
    setbombtimer( "A", 0 );
    setmatchflag( "bomb_timer_a", 0 );
    thread hidetimerdisplayongameend();
    
    while ( true )
    {
        resume_time();
        sound::play_on_players( "mp_suitcase_pickup" );
        globallogic_audio::leader_dialog( "kothLocated", undefined, undefined, "gamemode_objective", undefined, "kothActiveDialogBuffer" );
        level.zone.gameobject gameobjects::set_model_visibility( 1 );
        
        if ( level.zonespawntime )
        {
            level.zone.gameobject gameobjects::set_visible_team( "any" );
            level.zone.gameobject gameobjects::set_flags( 1 );
            updateobjectivehintmessage( level.objectivehintpreparezone );
            setmatchflag( "bomb_timer_a", 1 );
            setbombtimer( "A", int( gettime() + 1000 + level.zonespawntime * 1000 ) );
            wait level.zonespawntime;
            level.zone.gameobject gameobjects::set_flags( 0 );
            globallogic_audio::leader_dialog( "kothOnline", undefined, undefined, "gamemode_objective", undefined, "kothActiveDialogBuffer" );
        }
        
        setmatchflag( "bomb_timer_a", 0 );
        waittillframeend();
        updateobjectivehintmessage( level.objectivehintcapturezone );
        sound::play_on_players( "mpl_hq_cap_us" );
        level.zone.gameobject gameobjects::enable_object();
        objective_onentity( level.zone.gameobject.objectiveid, level.zone.objectiveanchor );
        level.zone.gameobject.capturecount = 0;
        
        if ( level.zoneautomovetime )
        {
            thread movezoneaftertime( level.zoneautomovetime );
            setmatchflag( "bomb_timer_a", 1 );
            setbombtimer( "A", int( gettime() + 1000 + level.zoneautomovetime * 1000 ) );
        }
        else
        {
            level.zonedestroyedbytimer = 0;
        }
        
        kothcaptureloop();
        ownerteam = level.zone.gameobject gameobjects::get_owner_team();
        
        if ( level.zone.gameobject.capturecount == 1 )
        {
            touchlist = [];
            touchkeys = getarraykeys( level.zone.gameobject.touchlist[ ownerteam ] );
            
            for ( i = 0; i < touchkeys.size ; i++ )
            {
                touchlist[ touchkeys[ i ] ] = level.zone.gameobject.touchlist[ ownerteam ][ touchkeys[ i ] ];
            }
            
            thread give_held_credit( touchlist );
        }
        
        pause_time();
        level.zone enable_influencers( 0 );
        level.zone.gameobject.lastcaptureteam = undefined;
        level.zone.gameobject gameobjects::disable_object();
        level.zone.gameobject gameobjects::allow_use( "none" );
        level.zone.gameobject gameobjects::set_owner_team( "neutral" );
        level.zone.gameobject gameobjects::set_model_visibility( 0 );
        level.zone.gameobject gameobjects::must_maintain_claim( 0 );
        level.zone togglezoneeffects( 0 );
        level notify( #"zone_reset" );
        setmatchflag( "bomb_timer_a", 0 );
        spawn_next_zone();
        wait 0.5;
        thread forcespawnteam( ownerteam );
        wait 0.5;
    }
}

// Namespace koth/koth
// Params 0
// Checksum 0xff23b084, Offset: 0x24a0
// Size: 0x2c
function hidetimerdisplayongameend()
{
    level waittill( "game_ended" );
    setmatchflag( "bomb_timer_a", 0 );
}

// Namespace koth/koth
// Params 1
// Checksum 0x85ddd310, Offset: 0x24d8
// Size: 0xaa
function forcespawnteam( team )
{
    players = level.players;
    
    for ( i = 0; i < players.size ; i++ )
    {
        player = players[ i ];
        
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( player.pers[ "team" ] == team )
        {
            player notify( #"force_spawn" );
            wait 0.1;
        }
    }
}

// Namespace koth/koth
// Params 0
// Checksum 0x368e460c, Offset: 0x2590
// Size: 0xf4
function updateteamclientfield()
{
    ownerteam = self gameobjects::get_owner_team();
    
    if ( isdefined( self.iscontested ) && self.iscontested )
    {
        level clientfield::set( "hardpointteam", 3 );
        return;
    }
    
    if ( ownerteam == "neutral" )
    {
        level clientfield::set( "hardpointteam", 0 );
        return;
    }
    
    if ( ownerteam == "allies" )
    {
        level clientfield::set( "hardpointteam", 1 );
        return;
    }
    
    level clientfield::set( "hardpointteam", 2 );
}

// Namespace koth/koth
// Params 1
// Checksum 0xd76555f3, Offset: 0x2690
// Size: 0xac
function onbeginuse( player )
{
    ownerteam = self gameobjects::get_owner_team();
    
    if ( ownerteam == "neutral" )
    {
        player thread battlechatter::gametype_specific_battle_chatter( "hq_protect", player.pers[ "team" ] );
        return;
    }
    
    player thread battlechatter::gametype_specific_battle_chatter( "hq_attack", player.pers[ "team" ] );
}

// Namespace koth/koth
// Params 3
// Checksum 0xcbded511, Offset: 0x2748
// Size: 0x2c
function onenduse( team, player, success )
{
    player notify( #"event_ended" );
}

// Namespace koth/koth
// Params 1
// Checksum 0xa4ceed92, Offset: 0x2780
// Size: 0x4e8
function onzonecapture( player )
{
    capture_team = player.pers[ "team" ];
    capturetime = gettime();
    
    /#
        print( "<dev string:x64>" );
    #/
    
    pause_time();
    string = &"MP_KOTH_CAPTURED_BY";
    level.zone.gameobject.iscontested = 0;
    level.usestartspawns = 0;
    
    if ( !isdefined( self.lastcaptureteam ) || self.lastcaptureteam != capture_team )
    {
        touchlist = [];
        touchkeys = getarraykeys( self.touchlist[ capture_team ] );
        
        for ( i = 0; i < touchkeys.size ; i++ )
        {
            touchlist[ touchkeys[ i ] ] = self.touchlist[ capture_team ][ touchkeys[ i ] ];
        }
        
        thread give_capture_credit( touchlist, string, capturetime, capture_team, self.lastcaptureteam );
    }
    
    level.kothcapteam = capture_team;
    self gameobjects::set_owner_team( capture_team );
    
    if ( !level.kothmode )
    {
        self gameobjects::set_use_time( level.destroytime );
    }
    
    foreach ( team in level.teams )
    {
        if ( team == capture_team )
        {
            if ( !isdefined( self.lastcaptureteam ) || self.lastcaptureteam != team )
            {
                globallogic_audio::leader_dialog( "kothSecured", team, undefined, "gamemode_objective", undefined, "kothActiveDialogBuffer" );
                
                for ( index = 0; index < level.players.size ; index++ )
                {
                    player = level.players[ index ];
                    
                    if ( player.pers[ "team" ] == team )
                    {
                        if ( player.lastkilltime + 500 > gettime() )
                        {
                            player challenges::killedlastcontester();
                        }
                    }
                }
            }
            
            thread sound::play_on_players( game.objective_gained_sound, team );
            continue;
        }
        
        if ( !isdefined( self.lastcaptureteam ) )
        {
            globallogic_audio::leader_dialog( "kothCaptured", team, undefined, "gamemode_objective", undefined, "kothActiveDialogBuffer" );
        }
        else if ( self.lastcaptureteam == team )
        {
            globallogic_audio::leader_dialog( "kothLost", team, undefined, "gamemode_objective", undefined, "kothActiveDialogBuffer" );
        }
        
        thread sound::play_on_players( game.objective_lost_sound, team );
    }
    
    self thread awardcapturepoints( capture_team, self.lastcaptureteam );
    self.capturecount++;
    self.lastcaptureteam = capture_team;
    self gameobjects::must_maintain_claim( 1 );
    self updateteamclientfield();
    player recordgameevent( "hardpoint_captured" );
    level notify( #"zone_captured" );
    level notify( "zone_captured" + capture_team );
    player notify( #"event_ended" );
}

// Namespace koth/koth
// Params 0
// Checksum 0x80f724d1, Offset: 0x2c70
// Size: 0x4
function track_capture_time()
{
    
}

// Namespace koth/koth
// Params 5
// Checksum 0xf71bf6d2, Offset: 0x2c80
// Size: 0x2b6
function give_capture_credit( touchlist, string, capturetime, capture_team, lastcaptureteam )
{
    waitframe( 1 );
    util::waittillslowprocessallowed();
    players = getarraykeys( touchlist );
    
    for ( i = 0; i < players.size ; i++ )
    {
        player = touchlist[ players[ i ] ].player;
        player updatecapsperminute( lastcaptureteam );
        
        if ( !isscoreboosting( player ) )
        {
            player challenges::capturedobjective( capturetime, self.trigger );
            
            if ( level.kothstarttime + 3000 > capturetime && level.kothcapteam == capture_team )
            {
                scoreevents::processscoreevent( "quickly_secure_point", player );
            }
            
            scoreevents::processscoreevent( "koth_secure", player );
            player recordgameevent( "capture" );
            level thread popups::displayteammessagetoall( string, player );
            
            if ( isdefined( player.pers[ "captures" ] ) )
            {
                player.pers[ "captures" ]++;
                player.captures = player.pers[ "captures" ];
            }
            
            if ( level.kothstarttime + 500 > capturetime )
            {
                player challenges::immediatecapture();
            }
            
            demo::bookmark( "event", gettime(), player );
            player addplayerstatwithgametype( "CAPTURES", 1 );
            continue;
        }
        
        /#
            player iprintlnbold( "<dev string:x72>" );
        #/
    }
}

// Namespace koth/koth
// Params 2
// Checksum 0x6bff1d2d, Offset: 0x2f40
// Size: 0xa2
function give_held_credit( touchlist, team )
{
    waitframe( 1 );
    util::waittillslowprocessallowed();
    players = getarraykeys( touchlist );
    
    for ( i = 0; i < players.size ; i++ )
    {
        player = touchlist[ players[ i ] ].player;
    }
}

// Namespace koth/koth
// Params 0
// Checksum 0x10f9f65d, Offset: 0x2ff0
// Size: 0xbc
function onzoneunoccupied()
{
    level notify( #"zone_destroyed" );
    level.kothcapteam = "neutral";
    level.zone.gameobject.wasleftunoccupied = 1;
    level.zone.gameobject.iscontested = 0;
    level.zone.gameobject recordgameeventnonplayer( "hardpoint_empty" );
    resume_time();
    self updateteamclientfield();
}

// Namespace koth/koth
// Params 0
// Checksum 0x906424c9, Offset: 0x30b8
// Size: 0x162
function onzonecontested()
{
    zoneowningteam = self gameobjects::get_owner_team();
    self.wascontested = 1;
    self.iscontested = 1;
    self updateteamclientfield();
    self recordgameeventnonplayer( "hardpoint_contested" );
    resume_time();
    
    foreach ( team in level.teams )
    {
        if ( team == zoneowningteam )
        {
            thread sound::play_on_players( game.objective_contested_sound, team );
            globallogic_audio::leader_dialog( "kothContested", team, undefined, "gamemode_objective", undefined, "kothActiveDialogBuffer" );
        }
    }
}

// Namespace koth/koth
// Params 1
// Checksum 0x9941619a, Offset: 0x3228
// Size: 0xbc
function onzoneuncontested( lastclaimteam )
{
    assert( lastclaimteam == level.zone.gameobject gameobjects::get_owner_team() );
    self.iscontested = 0;
    pause_time();
    self gameobjects::set_claim_team( lastclaimteam );
    self updateteamclientfield();
    self recordgameeventnonplayer( "hardpoint_uncontested" );
}

// Namespace koth/koth
// Params 1
// Checksum 0x6cf2ddb3, Offset: 0x32f0
// Size: 0x17c
function movezoneaftertime( time )
{
    level endon( #"game_ended" );
    level endon( #"zone_reset" );
    level.zonemovetime = gettime() + time * 1000;
    level.zonedestroyedbytimer = 0;
    wait time;
    
    if ( !isdefined( level.zone.gameobject.wascontested ) || level.zone.gameobject.wascontested == 0 )
    {
        if ( !isdefined( level.zone.gameobject.wasleftunoccupied ) || level.zone.gameobject.wasleftunoccupied == 0 )
        {
            zoneowningteam = level.zone.gameobject gameobjects::get_owner_team();
            challenges::controlzoneentirely( zoneowningteam );
        }
    }
    
    level.zonedestroyedbytimer = 1;
    level.zone.gameobject recordgameeventnonplayer( "hardpoint_moved" );
    level notify( #"zone_moved" );
}

// Namespace koth/koth
// Params 2
// Checksum 0xda3c4249, Offset: 0x3478
// Size: 0x256
function awardcapturepoints( team, lastcaptureteam )
{
    level endon( #"game_ended" );
    level endon( #"zone_destroyed" );
    level endon( #"zone_reset" );
    level endon( #"zone_moved" );
    level notify( #"awardcapturepointsrunning" );
    level endon( #"awardcapturepointsrunning" );
    seconds = 1;
    score = 1;
    
    while ( !level.gameended )
    {
        wait seconds;
        hostmigration::waittillhostmigrationdone();
        
        if ( !level.zone.gameobject.iscontested )
        {
            if ( level.scoreperplayer )
            {
                score = level.zone.gameobject.numtouching[ team ];
            }
            
            globallogic_score::giveteamscoreforobjective( team, score );
            level.kothtotalsecondsinzone++;
            
            foreach ( player in level.aliveplayers[ team ] )
            {
                if ( !isdefined( player.touchtriggers[ self.entnum ] ) )
                {
                    continue;
                }
                
                if ( isdefined( player.pers[ "objtime" ] ) )
                {
                    player.pers[ "objtime" ]++;
                    player.objtime = player.pers[ "objtime" ];
                }
                
                player addplayerstatwithgametype( "OBJECTIVE_TIME", 1 );
            }
        }
    }
}

// Namespace koth/koth
// Params 0
// Checksum 0xa5912d39, Offset: 0x36d8
// Size: 0xe
function koth_playerspawnedcb()
{
    self.lowermessageoverride = undefined;
}

// Namespace koth/koth
// Params 2
// Checksum 0x9ba72432, Offset: 0x36f0
// Size: 0x10e, Type: bool
function comparezoneindexes( zone_a, zone_b )
{
    script_index_a = zone_a.script_index;
    script_index_b = zone_b.script_index;
    
    if ( !isdefined( script_index_a ) && !isdefined( script_index_b ) )
    {
        return false;
    }
    
    if ( !isdefined( script_index_a ) && isdefined( script_index_b ) )
    {
        println( "<dev string:xb7>" + zone_a.origin );
        return true;
    }
    
    if ( isdefined( script_index_a ) && !isdefined( script_index_b ) )
    {
        println( "<dev string:xb7>" + zone_b.origin );
        return false;
    }
    
    if ( script_index_a > script_index_b )
    {
        return true;
    }
    
    return false;
}

// Namespace koth/koth
// Params 0
// Checksum 0xf0d8d7e5, Offset: 0x3808
// Size: 0x132
function getzonearray()
{
    zones = getentarray( "koth_zone_center", "targetname" );
    
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
            if ( comparezoneindexes( zones[ i ], zones[ i + 1 ] ) )
            {
                temp = zones[ i ];
                zones[ i ] = zones[ i + 1 ];
                zones[ i + 1 ] = temp;
                swapped = 1;
            }
        }
    }
    
    return zones;
}

// Namespace koth/koth
// Params 0
// Checksum 0xdfe858d9, Offset: 0x3948
// Size: 0x440, Type: bool
function setupzones()
{
    zones = getzonearray();
    trigs = getentarray( "koth_zone_trigger", "targetname" );
    
    for ( i = 0; i < zones.size ; i++ )
    {
        errored = 0;
        zone = zones[ i ];
        zone.trig = undefined;
        
        for ( j = 0; j < trigs.size ; j++ )
        {
            if ( zone istouching( trigs[ j ] ) )
            {
                if ( isdefined( zone.trig ) )
                {
                    globallogic_utils::add_map_error( "Zone at " + zone.origin + " is touching more than one \"zonetrigger\" trigger" );
                    errored = 1;
                    break;
                }
                
                zone.trig = trigs[ j ];
                break;
            }
        }
        
        if ( !isdefined( zone.trig ) )
        {
            if ( !errored )
            {
                globallogic_utils::add_map_error( "Zone at " + zone.origin + " is not inside any \"zonetrigger\" trigger" );
                continue;
            }
        }
        
        assert( !errored );
        zone.trigorigin = zone.trig.origin;
        zone.objectiveanchor = spawn( "script_model", zone.origin );
        visuals = [];
        visuals[ 0 ] = zone;
        
        if ( isdefined( zone.target ) )
        {
            othervisuals = getentarray( zone.target, "targetname" );
            
            for ( j = 0; j < othervisuals.size ; j++ )
            {
                visuals[ visuals.size ] = othervisuals[ j ];
            }
        }
        
        objective_name = istring( "hardpoint" );
        zone.gameobject = gameobjects::create_use_object( "neutral", zone.trig, visuals, ( 0, 0, 0 ), objective_name );
        zone.gameobject gameobjects::set_objective_entity( zone );
        zone.gameobject gameobjects::disable_object();
        zone.gameobject gameobjects::set_model_visibility( 0 );
        zone.trig.useobj = zone.gameobject;
        zone.trig.var_f52dc901 = 1;
        zone createzonespawninfluencer();
    }
    
    if ( globallogic_utils::print_map_errors() )
    {
        return false;
    }
    
    level.zones = zones;
    level.prevzone = undefined;
    level.prevzone2 = undefined;
    setupzoneexclusions();
    return true;
}

// Namespace koth/koth
// Params 0
// Checksum 0x63d310ef, Offset: 0x3d90
// Size: 0x1f0
function setupzoneexclusions()
{
    if ( !isdefined( level.levelkothdisable ) )
    {
        return;
    }
    
    foreach ( nullzone in level.levelkothdisable )
    {
        mindist = 1410065408;
        foundzone = undefined;
        
        foreach ( zone in level.zones )
        {
            distance = distancesquared( nullzone.origin, zone.origin );
            
            if ( distance < mindist )
            {
                foundzone = zone;
                mindist = distance;
            }
        }
        
        if ( isdefined( foundzone ) )
        {
            if ( !isdefined( foundzone.gameobject.exclusions ) )
            {
                foundzone.gameobject.exclusions = [];
            }
            
            foundzone.gameobject.exclusions[ foundzone.gameobject.exclusions.size ] = nullzone;
        }
    }
}

// Namespace koth/koth
// Params 0
// Checksum 0xc4d018e8, Offset: 0x3f88
// Size: 0x90
function getfirstzone()
{
    zone = level.zones[ 0 ];
    level.prevzone2 = level.prevzone;
    level.prevzone = zone;
    level.prevzoneindex = 0;
    shufflezones();
    arrayremovevalue( level.zonespawnqueue, zone );
    return zone;
}

// Namespace koth/koth
// Params 0
// Checksum 0xcc7aa438, Offset: 0x4020
// Size: 0x8c
function getnextzone()
{
    nextzoneindex = ( level.prevzoneindex + 1 ) % level.zones.size;
    zone = level.zones[ nextzoneindex ];
    level.prevzone2 = level.prevzone;
    level.prevzone = zone;
    level.prevzoneindex = nextzoneindex;
    return zone;
}

// Namespace koth/koth
// Params 0
// Checksum 0x7459a9b9, Offset: 0x40b8
// Size: 0x84
function pickrandomzonetospawn()
{
    level.prevzoneindex = randomint( level.zones.size );
    zone = level.zones[ level.prevzoneindex ];
    level.prevzone2 = level.prevzone;
    level.prevzone = zone;
    return zone;
}

// Namespace koth/koth
// Params 0
// Checksum 0x2ae849d3, Offset: 0x4148
// Size: 0x166
function shufflezones()
{
    level.zonespawnqueue = [];
    spawnqueue = arraycopy( level.zones );
    
    for ( total_left = spawnqueue.size; total_left > 0 ; total_left-- )
    {
        index = randomint( total_left );
        valid_zones = 0;
        
        for ( zone = 0; zone < level.zones.size ; zone++ )
        {
            if ( !isdefined( spawnqueue[ zone ] ) )
            {
                continue;
            }
            
            if ( valid_zones == index )
            {
                if ( level.zonespawnqueue.size == 0 && isdefined( level.zone ) && level.zone == spawnqueue[ zone ] )
                {
                    continue;
                }
                
                level.zonespawnqueue[ level.zonespawnqueue.size ] = spawnqueue[ zone ];
                spawnqueue[ zone ] = undefined;
                break;
            }
            
            valid_zones++;
        }
    }
}

// Namespace koth/koth
// Params 0
// Checksum 0xc6dbeb11, Offset: 0x42b8
// Size: 0x98
function getnextzonefromqueue()
{
    if ( level.zonespawnqueue.size == 0 )
    {
        shufflezones();
    }
    
    assert( level.zonespawnqueue.size > 0 );
    next_zone = level.zonespawnqueue[ 0 ];
    arrayremoveindex( level.zonespawnqueue, 0 );
    return next_zone;
}

// Namespace koth/koth
// Params 0
// Checksum 0xee940cf5, Offset: 0x4358
// Size: 0x1c
function onroundswitch()
{
    game.switchedsides = !game.switchedsides;
}

// Namespace koth/koth
// Params 9
// Checksum 0x7e53182b, Offset: 0x4380
// Size: 0x764
function onplayerkilled( einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration )
{
    if ( level.capturetime && !self.touchtriggers.size && ( !isplayer( attacker ) || !attacker.touchtriggers.size ) || attacker.pers[ "team" ] == self.pers[ "team" ] )
    {
        return;
    }
    
    medalgiven = 0;
    scoreeventprocessed = 0;
    ownerteam = undefined;
    
    if ( level.capturetime == 0 )
    {
        if ( !isdefined( level.zone ) )
        {
            return;
        }
        
        ownerteam = level.zone.gameobject.ownerteam;
        
        if ( !isdefined( ownerteam ) || ownerteam == "neutral" )
        {
            return;
        }
    }
    
    if ( level.capturetime == 0 && ( self.touchtriggers.size || self istouching( level.zone.trig ) ) )
    {
        if ( level.capturetime > 0 )
        {
            triggerids = getarraykeys( self.touchtriggers );
            ownerteam = self.touchtriggers[ triggerids[ 0 ] ].useobj.ownerteam;
        }
        
        if ( ownerteam != "neutral" )
        {
            attacker.lastkilltime = gettime();
            team = attacker.pers[ "team" ];
            
            if ( team == ownerteam )
            {
                if ( !medalgiven )
                {
                    attacker medals::offenseglobalcount();
                    attacker thread challenges::killedbaseoffender( level.zone.trig, weapon );
                    medalgiven = 1;
                }
                
                scoreevents::processscoreevent( "hardpoint_kill", attacker, undefined, weapon );
                self recordkillmodifier( "defending" );
                scoreeventprocessed = 1;
            }
            else
            {
                if ( !medalgiven )
                {
                    if ( isdefined( attacker.pers[ "defends" ] ) )
                    {
                        attacker.pers[ "defends" ]++;
                        attacker.defends = attacker.pers[ "defends" ];
                    }
                    
                    attacker medals::defenseglobalcount();
                    medalgiven = 1;
                    attacker thread challenges::killedbasedefender( level.zone.trig );
                    attacker recordgameevent( "defending" );
                }
                
                attacker challenges::killedzoneattacker( weapon );
                scoreevents::processscoreevent( "hardpoint_kill", attacker, undefined, weapon );
                self recordkillmodifier( "assaulting" );
                scoreeventprocessed = 1;
            }
        }
    }
    
    if ( level.capturetime == 0 && ( attacker.touchtriggers.size || attacker istouching( level.zone.trig ) ) )
    {
        if ( level.capturetime > 0 )
        {
            triggerids = getarraykeys( attacker.touchtriggers );
            ownerteam = attacker.touchtriggers[ triggerids[ 0 ] ].useobj.ownerteam;
        }
        
        if ( ownerteam != "neutral" )
        {
            team = self.pers[ "team" ];
            
            if ( team == ownerteam )
            {
                if ( !medalgiven )
                {
                    if ( isdefined( attacker.pers[ "defends" ] ) )
                    {
                        attacker.pers[ "defends" ]++;
                        attacker.defends = attacker.pers[ "defends" ];
                    }
                    
                    attacker medals::defenseglobalcount();
                    medalgiven = 1;
                    attacker thread challenges::killedbasedefender( level.zone.trig );
                    attacker recordgameevent( "defending" );
                }
                
                if ( scoreeventprocessed == 0 )
                {
                    attacker challenges::killedzoneattacker( weapon );
                    scoreevents::processscoreevent( "hardpoint_kill", attacker, undefined, weapon );
                    self recordkillmodifier( "assaulting" );
                }
            }
            else
            {
                if ( !medalgiven )
                {
                    attacker medals::offenseglobalcount();
                    medalgiven = 1;
                    attacker thread challenges::killedbaseoffender( level.zone.trig, weapon );
                }
                
                if ( scoreeventprocessed == 0 )
                {
                    scoreevents::processscoreevent( "hardpoint_kill", attacker, undefined, weapon );
                    self recordkillmodifier( "defending" );
                }
            }
        }
    }
    
    if ( medalgiven == 1 )
    {
        if ( isdefined( level.zone.gameobject.iscontested ) && level.zone.gameobject.iscontested )
        {
            attacker thread killwhilecontesting();
        }
    }
}

// Namespace koth/koth
// Params 0
// Checksum 0xb1f8525, Offset: 0x4af0
// Size: 0x148
function killwhilecontesting()
{
    self notify( #"killwhilecontesting" );
    self endon( #"killwhilecontesting" );
    self endon( #"disconnect" );
    killtime = gettime();
    playerteam = self.pers[ "team" ];
    
    if ( !isdefined( self.clearenemycount ) )
    {
        self.clearenemycount = 0;
    }
    
    self.clearenemycount++;
    var_b34f24c5 = level waittill( "zone_captured" + playerteam, "zone_destroyed", "zone_captured", "death" );
    
    if ( var_b34f24c5._notify == "death" || playerteam != self.pers[ "team" ] )
    {
        self.clearenemycount = 0;
        return;
    }
    
    if ( self.clearenemycount >= 2 && killtime + 200 > gettime() )
    {
        scoreevents::processscoreevent( "clear_2_attackers", self );
    }
    
    self.clearenemycount = 0;
}

// Namespace koth/koth
// Params 1
// Checksum 0x271e1185, Offset: 0x4c40
// Size: 0x6e
function onendgame( winningteam )
{
    for ( i = 0; i < level.zones.size ; i++ )
    {
        level.zones[ i ].gameobject gameobjects::allow_use( "none" );
    }
}

// Namespace koth/koth
// Params 1
// Checksum 0x1a6de11a, Offset: 0x4cb8
// Size: 0x4c
function enable_influencers( enabled )
{
    enableinfluencer( self.influencer_large, enabled );
    enableinfluencer( self.influencer_small, enabled );
}

// Namespace koth/koth
// Params 0
// Checksum 0x744c6ac6, Offset: 0x4d10
// Size: 0x8c
function createzonespawninfluencer()
{
    self.influencer_large = self influencers::create_influencer( "koth_large", self.gameobject.curorigin, 0 );
    self.influencer_small = influencers::create_influencer( "koth_small", self.gameobject.curorigin, 0 );
    self enable_influencers( 0 );
}

// Namespace koth/koth
// Params 1
// Checksum 0x30ec463c, Offset: 0x4da8
// Size: 0x114
function updatecapsperminute( lastownerteam )
{
    if ( !isdefined( self.capsperminute ) )
    {
        self.numcaps = 0;
        self.capsperminute = 0;
    }
    
    if ( !isdefined( lastownerteam ) || lastownerteam == "neutral" )
    {
        return;
    }
    
    self.numcaps++;
    minutespassed = globallogic_utils::gettimepassed() / 60000;
    
    if ( isplayer( self ) && isdefined( self.timeplayed[ "total" ] ) )
    {
        minutespassed = self.timeplayed[ "total" ] / 60;
    }
    
    self.capsperminute = self.numcaps / minutespassed;
    
    if ( self.capsperminute > self.numcaps )
    {
        self.capsperminute = self.numcaps;
    }
}

// Namespace koth/koth
// Params 1
// Checksum 0x9d4c2dde, Offset: 0x4ec8
// Size: 0x44, Type: bool
function isscoreboosting( player )
{
    if ( !level.rankedmatch )
    {
        return false;
    }
    
    if ( player.capsperminute > level.playercapturelpm )
    {
        return true;
    }
    
    return false;
}

