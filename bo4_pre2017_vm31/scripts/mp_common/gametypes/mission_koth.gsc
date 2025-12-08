#using scripts/core_common/callbacks_shared;
#using scripts/core_common/challenges_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/demo_shared;
#using scripts/core_common/gameobjects_shared;
#using scripts/core_common/hostmigration_shared;
#using scripts/core_common/influencers_shared;
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
#using scripts/mp_common/util;

#namespace mission_koth;

// Namespace mission_koth/mission_koth
// Params 1
// Checksum 0xb0430ea9, Offset: 0x8d0
// Size: 0x198
function init( settings_bundle )
{
    game.objective_gained_sound = "mpl_flagcapture_sting_friend";
    game.objective_lost_sound = "mpl_flagcapture_sting_enemy";
    game.objective_contested_sound = "mpl_flagreturn_sting";
    level.warstarttime = 0;
    level.zonespawntime = getgametypesetting( "objectiveSpawnTime" );
    level.capturetime = getgametypesetting( "captureTime" );
    level.destroytime = getgametypesetting( "destroyTime" );
    callback::on_connect( &on_player_connect );
    level.audiocues = [];
    
    if ( isdefined( settings_bundle ) )
    {
        level.mission_bundle = settings_bundle;
    }
    else
    {
        level.mission_bundle = getscriptbundle( "mission_settings_core" );
    }
    
    level.audioplaybackthrottle = int( level.mission_bundle.msaudioplaybackthrottle );
    
    if ( !isdefined( level.audioplaybackthrottle ) )
    {
        level.audioplaybackthrottle = 5000;
    }
}

// Namespace mission_koth/mission_koth
// Params 1
// Checksum 0x5829dc05, Offset: 0xa70
// Size: 0xa0
function get_player_userate( use_object )
{
    use_rate_multiplier = 1;
    
    if ( isdefined( self.playerrole ) )
    {
        if ( self.team == game.attackers )
        {
            use_rate_multiplier = self.playerrole.attackercapturemultiplier;
        }
        else if ( self.team == game.defenders )
        {
            use_rate_multiplier = self.playerrole.defenddecaymultiplier;
        }
    }
    
    return use_rate_multiplier;
}

// Namespace mission_koth/mission_koth
// Params 0
// Checksum 0x7d43a6c2, Offset: 0xb18
// Size: 0x24
function on_player_connect()
{
    self gameobjects::setplayergametypeuseratecallback( &get_player_userate );
}

// Namespace mission_koth/mission_koth
// Params 1
// Checksum 0xbe1ea7e3, Offset: 0xb48
// Size: 0x49c
function start( zone )
{
    trigs = getentarray( "war_zone_trigger", "targetname" );
    errored = 0;
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
            return;
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
    
    objective_name = istring( "warzone" );
    zone.gameobject = gameobjects::create_use_object( game.defenders, zone.trig, visuals, ( 0, 0, 0 ), objective_name );
    zone.gameobject gameobjects::set_objective_entity( zone );
    zone.gameobject gameobjects::disable_object();
    zone.gameobject gameobjects::set_model_visibility( 0 );
    zone.gameobject.owningzone = zone;
    zone.trig.useobj = zone.gameobject;
    zone.trig.var_f52dc901 = 1;
    zone.gameobject.lastteamtoownzone = "neutral";
    zone.scores = [];
    
    foreach ( team in level.teams )
    {
        zone.scores[ team ] = 0;
    }
    
    zone setup_zone_exclusions();
    
    if ( globallogic_utils::print_map_errors() )
    {
        return 0;
    }
    
    setup_callbacks( zone );
    setup_objectives();
}

// Namespace mission_koth/mission_koth
// Params 1
// Checksum 0xc8767c95, Offset: 0xff0
// Size: 0x50
function setup_callbacks( zone )
{
    zone.main_loop = &main_loop;
    zone.on_spawn_player = undefined;
    zone.on_player_killed = &on_player_killed;
}

// Namespace mission_koth/mission_koth
// Params 1
// Checksum 0x58b574d6, Offset: 0x1048
// Size: 0xd8
function update_objective_hint_message( message )
{
    gametype = getdvarstring( "g_gametype" );
    
    if ( gametype != "koth" )
    {
        return;
    }
    
    foreach ( team in level.teams )
    {
        game.strings[ "objective_hint_" + team ] = message;
    }
}

// Namespace mission_koth/mission_koth
// Params 0
// Checksum 0x371e1883, Offset: 0x1128
// Size: 0x212
function setup_objectives()
{
    level.objectivehintpreparezone = &"MP_CONTROL_KOTH";
    level.objectivehintcapturezone = &"MP_CAPTURE_KOTH";
    level.objectivehintdefendhq = &"MP_DEFEND_KOTH";
    
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
    
    if ( level.zonespawntime )
    {
        update_objective_hint_message( level.objectivehintpreparezone );
    }
    else
    {
        update_objective_hint_message( level.objectivehintcapturezone );
    }
    
    game.strings[ game.attackers + "_mission_win" ] = &"OBJECTIVES_MISSION_KOTH_ATTACKER_WIN_HINT";
    game.strings[ game.attackers + "_mission_loss" ] = &"OBJECTIVES_MISSION_ATTACKER_LOSS_HINT";
    game.strings[ game.defenders + "_mission_win" ] = &"OBJECTIVES_MISSION_KOTH_DEFENDER_WIN_HINT";
    game.strings[ game.defenders + "_mission_loss" ] = &"OBJECTIVES_MISSION_KOTH_DEFENDER_LOSS_HINT";
}

// Namespace mission_koth/mission_koth
// Params 1
// Checksum 0x59a4c9ec, Offset: 0x1348
// Size: 0x74
function toggle_zone_effects( enabled )
{
    index = 0;
    
    if ( enabled )
    {
        index = self.script_index;
    }
    
    level clientfield::set( "warzone", index );
    level clientfield::set( "warzonestate", 0 );
}

// Namespace mission_koth/mission_koth
// Params 1
// Checksum 0xbdc6ce7f, Offset: 0x13c8
// Size: 0x4c4
function main_loop( zone )
{
    level endon( #"game_ended" );
    level endon( #"mission_ended" );
    setbombtimer( "A", 0 );
    setmatchflag( "bomb_timer_a", 0 );
    thread hide_timer_on_game_end();
    sound::play_on_players( "mp_suitcase_pickup" );
    zone.gameobject gameobjects::set_model_visibility( 1 );
    
    if ( level.zonespawntime )
    {
        zone.gameobject gameobjects::set_visible_team( "any" );
        zone.gameobject gameobjects::set_flags( 1 );
        update_objective_hint_message( level.objectivehintpreparezone );
        setmatchflag( "bomb_timer_a", 1 );
        setbombtimer( "A", int( gettime() + 1000 + level.zonespawntime * 1000 ) );
        wait level.zonespawntime;
        zone.gameobject gameobjects::set_flags( 0 );
    }
    
    setmatchflag( "bomb_timer_a", 0 );
    waittillframeend();
    update_objective_hint_message( level.objectivehintcapturezone );
    sound::play_on_players( "mpl_hq_cap_us" );
    zone.gameobject gameobjects::enable_object();
    objective_onentity( zone.gameobject.objectiveid, zone.objectiveanchor );
    zone.gameobject.capturecount = 0;
    thread globallogic::showobjectivenotificationuiforallplayers( &"mission_koth", 7 );
    capture_loop( zone );
    ownerteam = zone.gameobject gameobjects::get_owner_team();
    
    if ( zone.gameobject.capturecount == 1 )
    {
        touchlist = [];
        touchkeys = getarraykeys( zone.gameobject.touchlist[ ownerteam ] );
        
        for ( i = 0; i < touchkeys.size ; i++ )
        {
            touchlist[ touchkeys[ i ] ] = zone.gameobject.touchlist[ ownerteam ][ touchkeys[ i ] ];
        }
        
        thread give_held_credit( touchlist );
    }
    
    zone.gameobject.lastcaptureteam = undefined;
    zone.gameobject gameobjects::disable_object();
    zone.gameobject gameobjects::allow_use( "none" );
    zone.gameobject gameobjects::set_owner_team( "neutral" );
    zone.gameobject gameobjects::set_model_visibility( 0 );
    zone.gameobject gameobjects::must_maintain_claim( 0 );
    zone.gameobject.decayprogress = 1;
    zone toggle_zone_effects( 0 );
    setmatchflag( "bomb_timer_a", 0 );
}

// Namespace mission_koth/mission_koth
// Params 1
// Checksum 0x37d696ed, Offset: 0x1898
// Size: 0x2fc
function capture_loop( zone )
{
    level endon( #"game_ended" );
    level endon( #"zone_moved" );
    level.warstarttime = gettime();
    zone.gameobject gameobjects::allow_use( "enemy" );
    zone.gameobject gameobjects::set_use_time( level.capturetime );
    zone.gameobject gameobjects::set_use_text( &"MP_CAPTURING_OBJECTIVE" );
    numtouching = zone.gameobject get_num_touching();
    zone.gameobject gameobjects::set_visible_team( "any" );
    zone.gameobject gameobjects::set_model_visibility( 1 );
    zone.gameobject gameobjects::must_maintain_claim( 0 );
    zone.gameobject gameobjects::can_contest_claim( 1 );
    zone.gameobject.decayprogress = 1;
    zone.gameobject gameobjects::set_decay_time( level.capturetime );
    zone.gameobject.onuse = &on_zone_capture;
    zone.gameobject.onbeginuse = &on_begin_use;
    zone.gameobject.onenduse = &on_end_use;
    zone.gameobject.ontouchuse = &on_touch_use;
    zone.gameobject.onendtouchuse = &on_end_touch_use;
    zone.gameobject.onresumeuse = &on_touch_use;
    zone.gameobject.onuseupdate = &on_use_update;
    zone.gameobject.ondecaycomplete = &on_decay_complete;
    zone.gameobject.stage = 1;
    zone toggle_zone_effects( 1 );
    level waittill( "zone_captured", "zone_destroyed", "mission_timed_out" );
}

// Namespace mission_koth/mission_koth
// Params 0, eflags: 0x4
// Checksum 0x8114e3f, Offset: 0x1ba0
// Size: 0xa6
function private get_num_touching()
{
    numtouching = 0;
    
    foreach ( team in level.teams )
    {
        numtouching += self.numtouching[ team ];
    }
    
    return numtouching;
}

// Namespace mission_koth/mission_koth
// Params 0, eflags: 0x4
// Checksum 0xd3c635c4, Offset: 0x1c50
// Size: 0x4c
function private hide_timer_on_game_end()
{
    level notify( #"hide_timer_on_game_end" );
    level endon( #"hide_timer_on_game_end" );
    level waittill( "game_ended" );
    setmatchflag( "bomb_timer_a", 0 );
}

// Namespace mission_koth/mission_koth
// Params 2, eflags: 0x4
// Checksum 0x34ce72cc, Offset: 0x1ca8
// Size: 0xa2
function private give_held_credit( touchlist, team )
{
    wait 0.05;
    util::waittillslowprocessallowed();
    players = getarraykeys( touchlist );
    
    for ( i = 0; i < players.size ; i++ )
    {
        player = touchlist[ players[ i ] ].player;
    }
}

// Namespace mission_koth/mission_koth
// Params 1, eflags: 0x4
// Checksum 0x2b9933c0, Offset: 0x1d58
// Size: 0x68
function private checkifshouldupdateattackerstatusplayback( player )
{
    if ( player.team != game.attackers )
    {
        return;
    }
    
    if ( !isdefined( self.lastteamtoownzone ) )
    {
        return;
    }
    
    if ( self.lastteamtoownzone == player.team )
    {
        return;
    }
    
    self.needsattackerstatusplayback = 1;
}

// Namespace mission_koth/mission_koth
// Params 1, eflags: 0x4
// Checksum 0x5af3c06, Offset: 0x1dc8
// Size: 0x68
function private checkifshouldupdatedefenderstatusplayback( player )
{
    if ( player.team != game.defenders )
    {
        return;
    }
    
    if ( isdefined( self.lastteamtoownzone ) && self.lastteamtoownzone == player.team )
    {
        return;
    }
    
    self.needsdefenderstatusplayback = 1;
}

// Namespace mission_koth/mission_koth
// Params 1, eflags: 0x4
// Checksum 0x5a52c5bb, Offset: 0x1e38
// Size: 0x3c
function private checkifshouldupdatestatusplayback( player )
{
    checkifshouldupdateattackerstatusplayback( player );
    checkifshouldupdatedefenderstatusplayback( player );
}

// Namespace mission_koth/mission_koth
// Params 1, eflags: 0x4
// Checksum 0x75295ae2, Offset: 0x1e80
// Size: 0x54
function private on_touch_use( player )
{
    player thread player_use_loop( self );
    self checkifshouldupdatestatusplayback( player );
    self update_team_client_field();
}

// Namespace mission_koth/mission_koth
// Params 1, eflags: 0x4
// Checksum 0xba287beb, Offset: 0x1ee0
// Size: 0x34
function private on_end_touch_use( player )
{
    player notify( #"hash_5d0b5b90" );
    self update_team_client_field();
}

// Namespace mission_koth/mission_koth
// Params 3, eflags: 0x4
// Checksum 0x6ad1ca7a, Offset: 0x1f20
// Size: 0x44
function private on_end_use( team, player, success )
{
    player notify( #"event_ended" );
    self update_team_client_field();
}

// Namespace mission_koth/mission_koth
// Params 2, eflags: 0x4
// Checksum 0x9ba8f98a, Offset: 0x1f70
// Size: 0x94
function private play_objective_audio( audiocue, team )
{
    if ( isdefined( level.audiocues[ audiocue ] ) )
    {
        if ( level.audiocues[ audiocue ] + level.audioplaybackthrottle > gettime() )
        {
            return;
        }
    }
    
    level.audiocues[ audiocue ] = gettime();
    thread globallogic_audio::leader_dialog( audiocue, team, undefined, "gamemode_objective", undefined, "kothActiveDialogBuffer" );
}

// Namespace mission_koth/mission_koth
// Params 2, eflags: 0x4
// Checksum 0x4cf5b2d7, Offset: 0x2010
// Size: 0x1ea
function private process_zone_capture_audio( zone, capture_team )
{
    foreach ( team in level.teams )
    {
        if ( team == capture_team )
        {
            if ( isdefined( level.wardialog ) && level.wardialog )
            {
                soundkey = "warZ" + zone.zone_index + 1 + "CompleteOfs";
                play_objective_audio( soundkey, team );
            }
            else
            {
                play_objective_audio( "kothSecured", team );
            }
            
            thread sound::play_on_players( game.objective_gained_sound, team );
            continue;
        }
        
        if ( isdefined( level.wardialog ) && level.wardialog )
        {
            soundkey = "warZ" + zone.zone_index + 1 + "FailDef";
            play_objective_audio( soundkey, team );
        }
        else
        {
            play_objective_audio( "kothLost", team );
        }
        
        thread sound::play_on_players( game.objective_lost_sound, team );
    }
}

// Namespace mission_koth/mission_koth
// Params 1, eflags: 0x4
// Checksum 0x2cd59f91, Offset: 0x2208
// Size: 0x388
function private on_zone_capture( player )
{
    capture_team = player.pers[ "team" ];
    capturetime = gettime();
    
    /#
        print( "<dev string:x28>" );
    #/
    
    string = &"MP_KOTH_CAPTURED_BY";
    
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
    
    level.warcapteam = capture_team;
    level.war_mission_succeeded = 1;
    self gameobjects::set_owner_team( capture_team );
    
    foreach ( team in level.teams )
    {
        if ( team == capture_team )
        {
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
    }
    
    process_zone_capture_audio( self.owningzone, capture_team );
    self thread award_capture_points( capture_team, self.lastcaptureteam );
    self.capturecount++;
    self.lastcaptureteam = capture_team;
    self gameobjects::must_maintain_claim( 1 );
    self update_team_client_field();
    player recordgameevent( "hardpoint_captured" );
    level notify( #"zone_captured" );
    level notify( "zone_captured" + capture_team );
    player notify( #"event_ended" );
}

// Namespace mission_koth/mission_koth
// Params 5, eflags: 0x4
// Checksum 0xbbeb0344, Offset: 0x2598
// Size: 0x296
function private give_capture_credit( touchlist, string, capturetime, capture_team, lastcaptureteam )
{
    wait 0.05;
    util::waittillslowprocessallowed();
    players = getarraykeys( touchlist );
    
    for ( i = 0; i < players.size ; i++ )
    {
        player = touchlist[ players[ i ] ].player;
        player update_caps_per_minute( lastcaptureteam );
        
        if ( !is_score_boosting( player ) )
        {
            player challenges::capturedobjective( capturetime, self.trigger );
            
            if ( level.warstarttime + 3000 > capturetime && level.warcapteam == capture_team )
            {
            }
            
            scoreevents::processscoreevent( "war_captured_zone", player );
            player recordgameevent( "capture" );
            level thread popups::displayteammessagetoall( string, player );
            
            if ( isdefined( player.pers[ "captures" ] ) )
            {
                player.pers[ "captures" ]++;
                player.captures = player.pers[ "captures" ];
            }
            
            if ( level.warstarttime + 500 > capturetime )
            {
                player challenges::immediatecapture();
            }
            
            demo::bookmark( "event", gettime(), player );
            player addplayerstatwithgametype( "CAPTURES", 1 );
            continue;
        }
        
        /#
            player iprintlnbold( "<dev string:x36>" );
        #/
    }
}

// Namespace mission_koth/mission_koth
// Params 1, eflags: 0x4
// Checksum 0xb1165779, Offset: 0x2838
// Size: 0x5a, Type: bool
function private is_zone_contested( zone )
{
    if ( zone.touchlist[ game.attackers ].size > 0 && zone.touchlist[ game.defenders ].size > 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace mission_koth/mission_koth
// Params 2
// Checksum 0xed618677, Offset: 0x28a0
// Size: 0x24e
function award_capture_points( team, lastcaptureteam )
{
    level endon( #"game_ended" );
    level endon( #"mission_ended" );
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
        
        if ( !is_zone_contested( self ) )
        {
            if ( level.scoreperplayer )
            {
                score = self.numtouching[ team ];
            }
            
            globallogic_score::giveteamscoreforobjective( team, score );
            level.wartotalsecondsinzone++;
            
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

// Namespace mission_koth/mission_koth
// Params 9
// Checksum 0x72a225cc, Offset: 0x2af8
// Size: 0x26c
function on_player_killed( einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration )
{
    if ( level.capturetime && !self.touchtriggers.size && ( !isplayer( attacker ) || !attacker.touchtriggers.size ) || attacker.pers[ "team" ] == self.pers[ "team" ] )
    {
        return;
    }
    
    medalgiven = 0;
    scoreeventprocessed = 0;
    ownerteam = undefined;
    zone = level.zone;
    
    if ( level.capturetime == 0 )
    {
        if ( !isdefined( zone ) )
        {
            return;
        }
        
        ownerteam = zone.gameobject.ownerteam;
        
        if ( !isdefined( ownerteam ) || ownerteam == "neutral" )
        {
            return;
        }
    }
    
    if ( level.capturetime == 0 && ( self.touchtriggers.size || self istouching( zone.trig ) ) )
    {
        if ( self.team == game.attackers && attacker.team == game.defenders )
        {
            scoreevents::processscoreevent( "war_killed_attacker_in_zone", attacker, undefined, weapon );
        }
        
        if ( self.team == game.defenders && attacker.team == game.attackers )
        {
            scoreevents::processscoreevent( "war_killed_defender_in_zone", attacker, undefined, weapon );
        }
    }
}

// Namespace mission_koth/mission_koth
// Params 0
// Checksum 0x787fa3f8, Offset: 0x2d70
// Size: 0x148
function kill_while_contesting()
{
    self notify( #"kill_while_contesting" );
    self endon( #"kill_while_contesting" );
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

// Namespace mission_koth/mission_koth
// Params 0
// Checksum 0xf08ef359, Offset: 0x2ec0
// Size: 0x1fc
function setup_zone_exclusions()
{
    if ( !isdefined( level.levelwardisable ) )
    {
        return;
    }
    
    foreach ( nullzone in level.levelwardisable )
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
        
        if ( isdefined( foundzone ) && foundzone == self )
        {
            if ( !isdefined( foundzone.gameobject.exclusions ) )
            {
                foundzone.gameobject.exclusions = [];
            }
            
            foundzone.gameobject.exclusions[ foundzone.gameobject.exclusions.size ] = nullzone;
        }
    }
}

// Namespace mission_koth/mission_koth
// Params 1
// Checksum 0xfe418a40, Offset: 0x30c8
// Size: 0x358
function player_use_loop( gameobject )
{
    self notify( #"hash_8491e4e5" );
    self endon( #"hash_8491e4e5" );
    player = self;
    player endon( #"hash_5d0b5b90" );
    player endon( #"event_ended" );
    player endon( #"death" );
    
    if ( !isdefined( player.playerrole ) )
    {
        return;
    }
    
    fast_capture_threshold = 1.5;
    fast_decay_threshold = 1;
    attacker_capture_multiplier = isdefined( player.playerrole.attackercapturemultiplier ) ? player.playerrole.attackercapturemultiplier : 1;
    defend_decay_multiplier = isdefined( player.playerrole.defenddecaymultiplier ) ? player.playerrole.defenddecaymultiplier : 1;
    
    if ( attacker_capture_multiplier <= fast_capture_threshold && defend_decay_multiplier <= fast_decay_threshold )
    {
        return;
    }
    
    while ( true )
    {
        while ( isdefined( gameobject.userate ) && ( !isdefined( gameobject.userate ) || gameobject.userate == 0 ) || gameobject.claimteam == "none" )
        {
            wait 0.2;
        }
        
        any_capture_progress = 0;
        any_decay_progress = 0;
        measure_progress_end_time = level.time + 5000;
        
        while ( level.time < measure_progress_end_time )
        {
            prev_progress = gameobject.curprogress;
            wait 1;
            
            if ( gameobject.curprogress > prev_progress )
            {
                any_capture_progress = 1;
                continue;
            }
            
            if ( gameobject.curprogress < prev_progress )
            {
                any_decay_progress = 1;
            }
        }
        
        if ( isdefined( gameobject.userate ) && gameobject.userate != 0 && gameobject.claimteam != "none" )
        {
            if ( any_capture_progress && player.pers[ "team" ] == game.attackers && attacker_capture_multiplier > fast_capture_threshold )
            {
                scoreevents::processscoreevent( "fast_capture_progress", player );
                continue;
            }
            
            if ( any_decay_progress && defend_decay_multiplier > fast_decay_threshold )
            {
                scoreevents::processscoreevent( "fast_decay_progress", player );
            }
        }
    }
}

// Namespace mission_koth/mission_koth
// Params 1, eflags: 0x4
// Checksum 0xb749b20f, Offset: 0x3428
// Size: 0xdc
function private on_begin_use( player )
{
    ownerteam = self gameobjects::get_owner_team();
    
    if ( ownerteam == "neutral" )
    {
        player thread battlechatter::gametype_specific_battle_chatter( "hq_protect", player.pers[ "team" ] );
    }
    else
    {
        player thread battlechatter::gametype_specific_battle_chatter( "hq_attack", player.pers[ "team" ] );
    }
    
    self checkifshouldupdatestatusplayback( player );
    self update_team_client_field();
}

// Namespace mission_koth/mission_koth
// Params 1, eflags: 0x4
// Checksum 0xc1da67ad, Offset: 0x3510
// Size: 0x9a, Type: bool
function private isuserateelevated( touchlist )
{
    foreach ( touchinfo in touchlist )
    {
        if ( touchinfo.userate > 1 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace mission_koth/mission_koth
// Params 2, eflags: 0x4
// Checksum 0x7c472029, Offset: 0x35b8
// Size: 0xb2, Type: bool
function private isplayerinzonewithrole( touchlist, roletype )
{
    foreach ( touchinfo in touchlist )
    {
        if ( touchinfo.player.playerrole.rolename == roletype )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace mission_koth/mission_koth
// Params 1, eflags: 0x4
// Checksum 0xb6a6ac93, Offset: 0x3678
// Size: 0x1b4
function private update_team_userate_clientfield( zone )
{
    if ( is_zone_contested( zone ) )
    {
        clientfield::set_world_uimodel( "hudItems.missions.captureMultiplierStatus", 0 );
        zone.lastteamtoownzone = "contested";
        return;
    }
    
    if ( zone.touchlist[ game.attackers ].size > 0 )
    {
        if ( isplayerinzonewithrole( zone.touchlist[ game.attackers ], "objective" ) )
        {
            clientfield::set_world_uimodel( "hudItems.missions.captureMultiplierStatus", 1 );
        }
        
        zone.lastteamtoownzone = game.attackers;
        return;
    }
    
    if ( zone.touchlist[ game.defenders ].size > 0 && zone.curprogress > 0 )
    {
        if ( isplayerinzonewithrole( zone.touchlist[ game.defenders ], "objective" ) )
        {
            clientfield::set_world_uimodel( "hudItems.missions.captureMultiplierStatus", 2 );
        }
        
        zone.lastteamtoownzone = game.defenders;
        return;
    }
    
    clientfield::set_world_uimodel( "hudItems.missions.captureMultiplierStatus", 0 );
}

// Namespace mission_koth/mission_koth
// Params 0, eflags: 0x4
// Checksum 0x75629370, Offset: 0x3838
// Size: 0x22c
function private update_team_client_field()
{
    ownerteam = self gameobjects::get_owner_team();
    
    if ( is_zone_contested( self ) )
    {
        level clientfield::set( "warzonestate", 3 );
        self gameobjects::set_flags( 0 );
    }
    else if ( self.claimteam != "none" && self.numtouching[ self.claimteam ] > 0 )
    {
        if ( self.claimteam == "allies" )
        {
            level clientfield::set( "warzonestate", 1 );
            self gameobjects::set_flags( 1 );
        }
        else
        {
            level clientfield::set( "warzonestate", 2 );
            self gameobjects::set_flags( 0 );
        }
    }
    else if ( self.numtouching[ ownerteam ] )
    {
        if ( ownerteam == "allies" )
        {
            level clientfield::set( "warzonestate", 1 );
            self gameobjects::set_flags( 1 );
        }
        else
        {
            level clientfield::set( "warzonestate", 2 );
            self gameobjects::set_flags( 0 );
        }
    }
    else
    {
        level clientfield::set( "warzonestate", 0 );
        self gameobjects::set_flags( 0 );
    }
    
    update_team_userate_clientfield( self );
}

// Namespace mission_koth/mission_koth
// Params 1
// Checksum 0xd1fa808e, Offset: 0x3a70
// Size: 0x114
function update_caps_per_minute( lastownerteam )
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

// Namespace mission_koth/mission_koth
// Params 1
// Checksum 0xe5783839, Offset: 0x3b90
// Size: 0x44, Type: bool
function is_score_boosting( player )
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

// Namespace mission_koth/mission_koth
// Params 0
// Checksum 0x6f71fc20, Offset: 0x3be0
// Size: 0x34
function on_decay_complete()
{
    clientfield::set_world_uimodel( "hudItems.missions.captureMultiplierStatus", 0 );
    self gameobjects::set_flags( 0 );
}

// Namespace mission_koth/mission_koth
// Params 0
// Checksum 0x23de35f5, Offset: 0x3c20
// Size: 0xde
function score_capture_progress()
{
    trig = self.owningzone.trig;
    players = getplayers();
    
    for ( i = 0; i < players.size ; i++ )
    {
        player = players[ i ];
        
        if ( player.team == game.attackers && player istouching( trig ) )
        {
            scoreevents::processscoreevent( "war_capture_progress", player );
        }
    }
}

// Namespace mission_koth/mission_koth
// Params 3
// Checksum 0xc1719abc, Offset: 0x3d08
// Size: 0x29c
function on_use_update( team, progress, change )
{
    if ( progress >= 0.666667 )
    {
        self.decayprogressmin = int( 0.666667 * self.usetime );
        
        if ( self.stage == 2 )
        {
            score_capture_progress();
            self.stage = 3;
        }
    }
    else if ( progress >= 0.333333 )
    {
        self.decayprogressmin = int( 0.333333 * self.usetime );
        
        if ( self.stage == 1 )
        {
            score_capture_progress();
            self.stage = 2;
        }
    }
    
    if ( progress > 0.05 )
    {
        if ( change > 0 && isdefined( self.needsattackerstatusplayback ) && self.needsattackerstatusplayback )
        {
            play_objective_audio( "warCapturingOfs", game.attackers );
            play_objective_audio( "warCapturingDef", game.defenders );
            self.needsattackerstatusplayback = 0;
        }
        else if ( change < 0 && isdefined( self.needsdefenderstatusplayback ) && self.needsdefenderstatusplayback )
        {
            play_objective_audio( "warLosingProgressOfs", game.attackers );
            play_objective_audio( "warLosingProgressDef", game.defenders );
            self.needsdefenderstatusplayback = 0;
        }
    }
    
    if ( progress == 0.333333 || isdefined( self.decayprogressmin ) && change == 0 && progress == 0.666667 )
    {
        if ( clientfield::get_world_uimodel( "hudItems.missions.captureMultiplierStatus" ) != 0 )
        {
            clientfield::set_world_uimodel( "hudItems.missions.captureMultiplierStatus", 0 );
        }
    }
}

