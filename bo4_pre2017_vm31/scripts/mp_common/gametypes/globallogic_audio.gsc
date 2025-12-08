#using scripts/core_common/audio_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/music_shared;
#using scripts/core_common/sound_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/mp_common/gametypes/battlechatter;
#using scripts/mp_common/gametypes/globallogic_audio;
#using scripts/mp_common/gametypes/globallogic_utils;
#using scripts/mp_common/util;

#namespace globallogic_audio;

// Namespace globallogic_audio/globallogic_audio
// Params 0, eflags: 0x2
// Checksum 0x28c9fa2, Offset: 0xec8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "globallogic_audio", &__init__, undefined, undefined );
}

// Namespace globallogic_audio/globallogic_audio
// Params 0
// Checksum 0xa1587f13, Offset: 0xf08
// Size: 0x70
function __init__()
{
    callback::on_start_gametype( &init );
    level.playleaderdialogonplayer = &leader_dialog_on_player;
    level.playequipmentdestroyedonplayer = &play_equipment_destroyed_on_player;
    level.playequipmenthackedonplayer = &play_equipment_hacked_on_player;
}

// Namespace globallogic_audio/globallogic_audio
// Params 0
// Checksum 0xa26e07c6, Offset: 0xf80
// Size: 0x6b2
function init()
{
    game.music[ "defeat" ] = "mus_defeat";
    game.music[ "victory_spectator" ] = "mus_defeat";
    game.music[ "winning" ] = "mus_time_running_out_winning";
    game.music[ "losing" ] = "mus_time_running_out_losing";
    game.music[ "match_end" ] = "mus_match_end";
    game.music[ "victory_tie" ] = "mus_defeat";
    game.music[ "spawn_short" ] = "SPAWN_SHORT";
    game.music[ "suspense" ] = [];
    game.music[ "suspense" ][ game.music[ "suspense" ].size ] = "mus_suspense_01";
    game.music[ "suspense" ][ game.music[ "suspense" ].size ] = "mus_suspense_02";
    game.music[ "suspense" ][ game.music[ "suspense" ].size ] = "mus_suspense_03";
    game.music[ "suspense" ][ game.music[ "suspense" ].size ] = "mus_suspense_04";
    game.music[ "suspense" ][ game.music[ "suspense" ].size ] = "mus_suspense_05";
    game.music[ "suspense" ][ game.music[ "suspense" ].size ] = "mus_suspense_06";
    level thread function_de3b188d();
    level.multipledialogkeys = [];
    level.multipledialogkeys[ "enemyAiTank" ] = "enemyAiTankMultiple";
    level.multipledialogkeys[ "enemySupplyDrop" ] = "enemySupplyDropMultiple";
    level.multipledialogkeys[ "enemyCombatRobot" ] = "enemyCombatRobotMultiple";
    level.multipledialogkeys[ "enemyCounterUav" ] = "enemyCounterUavMultiple";
    level.multipledialogkeys[ "enemyDart" ] = "enemyDartMultiple";
    level.multipledialogkeys[ "enemyEmp" ] = "enemyEmpMultiple";
    level.multipledialogkeys[ "enemySentinel" ] = "enemySentinelMultiple";
    level.multipledialogkeys[ "enemyMicrowaveTurret" ] = "enemyMicrowaveTurretMultiple";
    level.multipledialogkeys[ "enemyRcBomb" ] = "enemyRcBombMultiple";
    level.multipledialogkeys[ "enemyPlaneMortar" ] = "enemyPlaneMortarMultiple";
    level.multipledialogkeys[ "enemyHelicopterGunner" ] = "enemyHelicopterGunnerMultiple";
    level.multipledialogkeys[ "enemyRaps" ] = "enemyRapsMultiple";
    level.multipledialogkeys[ "enemyDroneStrike" ] = "enemyDroneStrikeMultiple";
    level.multipledialogkeys[ "enemyTurret" ] = "enemyTurretMultiple";
    level.multipledialogkeys[ "enemyHelicopter" ] = "enemyHelicopterMultiple";
    level.multipledialogkeys[ "enemyUav" ] = "enemyUavMultiple";
    level.multipledialogkeys[ "enemySatellite" ] = "enemySatelliteMultiple";
    level.multipledialogkeys[ "friendlyAiTank" ] = "";
    level.multipledialogkeys[ "friendlySupplyDrop" ] = "";
    level.multipledialogkeys[ "friendlyCombatRobot" ] = "";
    level.multipledialogkeys[ "friendlyCounterUav" ] = "";
    level.multipledialogkeys[ "friendlyDart" ] = "";
    level.multipledialogkeys[ "friendlyEmp" ] = "";
    level.multipledialogkeys[ "friendlySentinel" ] = "";
    level.multipledialogkeys[ "friendlyMicrowaveTurret" ] = "";
    level.multipledialogkeys[ "friendlyRcBomb" ] = "";
    level.multipledialogkeys[ "friendlyPlaneMortar" ] = "";
    level.multipledialogkeys[ "friendlyHelicopterGunner" ] = "";
    level.multipledialogkeys[ "friendlyRaps" ] = "";
    level.multipledialogkeys[ "friendlyDroneStrike" ] = "";
    level.multipledialogkeys[ "friendlyTurret" ] = "";
    level.multipledialogkeys[ "friendlyHelicopter" ] = "";
    level.multipledialogkeys[ "friendlyUav" ] = "";
    level.multipledialogkeys[ "friendlySatellite" ] = "";
}

// Namespace globallogic_audio/globallogic_audio
// Params 4
// Checksum 0xa407bd73, Offset: 0x1640
// Size: 0xa0
function set_leader_gametype_dialog( startgamedialogkey, starthcgamedialogkey, offenseorderdialogkey, defenseorderdialogkey )
{
    level.leaderdialog = spawnstruct();
    level.leaderdialog.startgamedialog = startgamedialogkey;
    level.leaderdialog.starthcgamedialog = starthcgamedialogkey;
    level.leaderdialog.offenseorderdialog = offenseorderdialogkey;
    level.leaderdialog.defenseorderdialog = defenseorderdialogkey;
}

// Namespace globallogic_audio/globallogic_audio
// Params 2
// Checksum 0x1961ea7b, Offset: 0x16e8
// Size: 0x16c
function announce_round_winner( winner, delay )
{
    if ( delay > 0 )
    {
        wait delay;
    }
    
    if ( !isdefined( winner ) || isplayer( winner ) )
    {
        return;
    }
    
    if ( isdefined( level.teams[ winner ] ) )
    {
        leader_dialog( "roundEncourageWon", winner );
        leader_dialog_for_other_teams( "roundEncourageLost", winner );
        return;
    }
    
    foreach ( team in level.teams )
    {
        thread sound::play_on_players( "mus_round_draw" + "_" + level.teampostfix[ team ] );
    }
    
    leader_dialog( "roundDraw" );
}

// Namespace globallogic_audio/globallogic_audio
// Params 1
// Checksum 0x871f1331, Offset: 0x1860
// Size: 0xf4
function announce_game_winner( winner )
{
    if ( level.gametype == "fr" )
    {
        return;
    }
    
    wait battlechatter::mpdialog_value( "announceWinnerDelay", 0 );
    
    if ( level.teambased )
    {
        if ( isdefined( level.teams[ winner ] ) )
        {
            leader_dialog( "gameWon", winner );
            leader_dialog_for_other_teams( "gameLost", winner );
        }
        else
        {
            leader_dialog( "gameDraw" );
        }
        
        wait battlechatter::mpdialog_value( "commanderDialogBuffer", 0 );
    }
    
    battlechatter::game_end_vox( winner );
}

// Namespace globallogic_audio/globallogic_audio
// Params 0
// Checksum 0x55bb81de, Offset: 0x1960
// Size: 0x92
function flush_dialog()
{
    foreach ( player in level.players )
    {
        player flush_dialog_on_player();
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 0
// Checksum 0xe7a68ab5, Offset: 0x1a00
// Size: 0x42
function flush_dialog_on_player()
{
    self.leaderdialogqueue = [];
    self.currentleaderdialog = undefined;
    self.killstreakdialogqueue = [];
    self.scorestreakdialogplaying = 0;
    self notify( #"flush_dialog" );
}

// Namespace globallogic_audio/globallogic_audio
// Params 1
// Checksum 0x2356ea3f, Offset: 0x1a50
// Size: 0x8e
function flush_killstreak_dialog_on_player( killstreakid )
{
    if ( !isdefined( killstreakid ) )
    {
        return;
    }
    
    for ( i = self.killstreakdialogqueue.size - 1; i >= 0 ; i-- )
    {
        if ( killstreakid === self.killstreakdialogqueue[ i ].killstreakid )
        {
            arrayremoveindex( self.killstreakdialogqueue, i );
        }
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 3
// Checksum 0x4e44e31a, Offset: 0x1ae8
// Size: 0x13e
function killstreak_dialog_queued( dialogkey, killstreaktype, killstreakid )
{
    if ( !isdefined( dialogkey ) || !isdefined( killstreaktype ) )
    {
        return;
    }
    
    if ( isdefined( self.currentkillstreakdialog ) )
    {
        if ( dialogkey === self.currentkillstreakdialog.dialogkey && killstreaktype === self.currentkillstreakdialog.killstreaktype && killstreakid === self.currentkillstreakdialog.killstreakid )
        {
            return 1;
        }
    }
    
    for ( i = 0; i < self.killstreakdialogqueue.size ; i++ )
    {
        if ( dialogkey === self.killstreakdialogqueue[ i ].dialogkey && killstreaktype === self.killstreakdialogqueue[ i ].killstreaktype && killstreaktype === self.killstreakdialogqueue[ i ].killstreaktype )
        {
            return 1;
        }
    }
    
    return 0;
}

// Namespace globallogic_audio/globallogic_audio
// Params 1
// Checksum 0x446addd8, Offset: 0x1c30
// Size: 0x9a
function flush_objective_dialog( objectivekey )
{
    foreach ( player in level.players )
    {
        player flush_objective_dialog_on_player( objectivekey );
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 1
// Checksum 0x7e24468a, Offset: 0x1cd8
// Size: 0x92
function flush_objective_dialog_on_player( objectivekey )
{
    if ( !isdefined( objectivekey ) )
    {
        return;
    }
    
    for ( i = self.leaderdialogqueue.size - 1; i >= 0 ; i-- )
    {
        if ( objectivekey === self.leaderdialogqueue[ i ].objectivekey )
        {
            arrayremoveindex( self.leaderdialogqueue, i );
            break;
        }
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 1
// Checksum 0x92bbc161, Offset: 0x1d78
// Size: 0x9a
function flush_leader_dialog_key( dialogkey )
{
    foreach ( player in level.players )
    {
        player flush_leader_dialog_key_on_player( dialogkey );
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 1
// Checksum 0x692398f8, Offset: 0x1e20
// Size: 0x8e
function flush_leader_dialog_key_on_player( dialogkey )
{
    if ( !isdefined( dialogkey ) )
    {
        return;
    }
    
    for ( i = self.leaderdialogqueue.size - 1; i >= 0 ; i-- )
    {
        if ( dialogkey === self.leaderdialogqueue[ i ].dialogkey )
        {
            arrayremoveindex( self.leaderdialogqueue, i );
        }
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 3
// Checksum 0xdacdd6d5, Offset: 0x1eb8
// Size: 0x3c
function play_taacom_dialog( dialogkey, killstreaktype, killstreakid )
{
    self killstreak_dialog_on_player( dialogkey, killstreaktype, killstreakid );
}

// Namespace globallogic_audio/globallogic_audio
// Params 4
// Checksum 0x49fffef4, Offset: 0x1f00
// Size: 0x154
function killstreak_dialog_on_player( dialogkey, killstreaktype, killstreakid, pilotindex )
{
    if ( !isdefined( dialogkey ) )
    {
        return;
    }
    
    if ( !level.allowannouncer )
    {
        return;
    }
    
    if ( level.gameended )
    {
        return;
    }
    
    newdialog = spawnstruct();
    newdialog.dialogkey = dialogkey;
    newdialog.killstreaktype = killstreaktype;
    newdialog.pilotindex = pilotindex;
    newdialog.killstreakid = killstreakid;
    self.killstreakdialogqueue[ self.killstreakdialogqueue.size ] = newdialog;
    
    if ( self.killstreakdialogqueue.size > 1 || isdefined( self.currentkillstreakdialog ) )
    {
        return;
    }
    
    if ( self.playingdialog === 1 && dialogkey == "arrive" )
    {
        self thread wait_for_player_dialog();
        return;
    }
    
    self thread play_next_killstreak_dialog();
}

// Namespace globallogic_audio/globallogic_audio
// Params 0
// Checksum 0x58900ce4, Offset: 0x2060
// Size: 0x5c
function wait_for_player_dialog()
{
    self endon( #"disconnect" );
    self endon( #"flush_dialog" );
    level endon( #"game_ended" );
    
    while ( self.playingdialog )
    {
        wait 0.5;
    }
    
    self thread play_next_killstreak_dialog();
}

// Namespace globallogic_audio/globallogic_audio
// Params 0
// Checksum 0x836b43a4, Offset: 0x20c8
// Size: 0x30c
function play_next_killstreak_dialog()
{
    self endon( #"disconnect" );
    self endon( #"flush_dialog" );
    level endon( #"game_ended" );
    
    if ( self.killstreakdialogqueue.size == 0 )
    {
        self.currentkillstreakdialog = undefined;
        return;
    }
    
    nextdialog = self.killstreakdialogqueue[ 0 ];
    arrayremoveindex( self.killstreakdialogqueue, 0 );
    
    if ( isdefined( self.pers[ "mptaacom" ] ) )
    {
        taacombundle = struct::get_script_bundle( "mpdialog_taacom", self.pers[ "mptaacom" ] );
    }
    
    if ( isdefined( taacombundle ) )
    {
        if ( isdefined( nextdialog.killstreaktype ) )
        {
            if ( isdefined( nextdialog.pilotindex ) )
            {
                pilotarray = taacombundle.pilotbundles[ nextdialog.killstreaktype ];
                
                if ( isdefined( pilotarray ) && nextdialog.pilotindex < pilotarray.size )
                {
                    killstreakbundle = struct::get_script_bundle( "mpdialog_scorestreak", pilotarray[ nextdialog.pilotindex ] );
                    
                    if ( isdefined( killstreakbundle ) )
                    {
                        dialogalias = get_dialog_bundle_alias( killstreakbundle, nextdialog.dialogkey );
                    }
                }
            }
            else if ( isdefined( level.killstreaks[ nextdialog.killstreaktype ] ) )
            {
                bundlename = level.killstreaks[ nextdialog.killstreaktype ].( level.killstreaks[ nextdialog.killstreaktype ].taacomdialogbundlekey );
                
                if ( isdefined( bundlename ) )
                {
                    killstreakbundle = struct::get_script_bundle( "mpdialog_scorestreak", bundlename );
                    
                    if ( isdefined( killstreakbundle ) )
                    {
                        dialogalias = self get_dialog_bundle_alias( killstreakbundle, nextdialog.dialogkey );
                    }
                }
            }
        }
        else
        {
            dialogalias = self get_dialog_bundle_alias( taacombundle, nextdialog.dialogkey );
        }
    }
    
    if ( !isdefined( dialogalias ) )
    {
        self play_next_killstreak_dialog();
        return;
    }
    
    self playlocalsound( dialogalias );
    self.currentkillstreakdialog = nextdialog;
    self thread wait_next_killstreak_dialog();
}

// Namespace globallogic_audio/globallogic_audio
// Params 0
// Checksum 0x57f81628, Offset: 0x23e0
// Size: 0x5c
function wait_next_killstreak_dialog()
{
    self endon( #"disconnect" );
    self endon( #"flush_dialog" );
    level endon( #"game_ended" );
    wait battlechatter::mpdialog_value( "killstreakDialogBuffer", 0 );
    self thread play_next_killstreak_dialog();
}

// Namespace globallogic_audio/globallogic_audio
// Params 5
// Checksum 0x72f8a951, Offset: 0x2448
// Size: 0xfa
function leader_dialog_for_other_teams( dialogkey, skipteam, objectivekey, killstreakid, dialogbufferkey )
{
    assert( isdefined( skipteam ) );
    
    foreach ( team in level.teams )
    {
        if ( team != skipteam )
        {
            leader_dialog( dialogkey, team, undefined, objectivekey, killstreakid, dialogbufferkey );
        }
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 6
// Checksum 0x8ffec32, Offset: 0x2550
// Size: 0x172
function leader_dialog( dialogkey, team, excludelist, objectivekey, killstreakid, dialogbufferkey )
{
    assert( isdefined( level.players ) );
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player.pers[ "team" ] ) )
        {
            continue;
        }
        
        if ( isdefined( team ) && team != player.pers[ "team" ] )
        {
            continue;
        }
        
        if ( isdefined( excludelist ) && globallogic_utils::isexcluded( player, excludelist ) )
        {
            continue;
        }
        
        player leader_dialog_on_player( dialogkey, objectivekey, killstreakid, dialogbufferkey );
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 5
// Checksum 0x11e3b565, Offset: 0x26d0
// Size: 0x43c
function leader_dialog_on_player( dialogkey, objectivekey, killstreakid, dialogbufferkey, introdialog )
{
    if ( !isdefined( dialogkey ) )
    {
        return;
    }
    
    if ( !level.allowannouncer )
    {
        return;
    }
    
    if ( isdefined( level.var_4cd7bf5d ) && level.var_4cd7bf5d )
    {
        return;
    }
    
    if ( !( isdefined( self.playleaderdialog ) && self.playleaderdialog ) && !( isdefined( introdialog ) && introdialog ) )
    {
        return;
    }
    
    self flush_objective_dialog_on_player( objectivekey );
    
    if ( self.leaderdialogqueue.size == 0 && isdefined( self.currentleaderdialog ) && isdefined( objectivekey ) && self.currentleaderdialog.objectivekey === objectivekey && self.currentleaderdialog.dialogkey == dialogkey )
    {
        return;
    }
    
    if ( isdefined( killstreakid ) )
    {
        foreach ( item in self.leaderdialogqueue )
        {
            if ( item.dialogkey == dialogkey )
            {
                item.killstreakids[ item.killstreakids.size ] = killstreakid;
                return;
            }
        }
        
        if ( self.leaderdialogqueue.size == 0 && isdefined( self.currentleaderdialog ) && self.currentleaderdialog.dialogkey == dialogkey )
        {
            if ( self.currentleaderdialog.playmultiple === 1 )
            {
                return;
            }
            
            playmultiple = 1;
        }
    }
    
    newitem = spawnstruct();
    newitem.priority = dialogkey_priority( dialogkey );
    newitem.dialogkey = dialogkey;
    newitem.multipledialogkey = level.multipledialogkeys[ dialogkey ];
    newitem.playmultiple = playmultiple;
    newitem.objectivekey = objectivekey;
    
    if ( isdefined( killstreakid ) )
    {
        newitem.killstreakids = [];
        newitem.killstreakids[ 0 ] = killstreakid;
    }
    
    newitem.dialogbufferkey = dialogbufferkey;
    iteminserted = 0;
    
    if ( isdefined( newitem.priority ) )
    {
        for ( i = 0; i < self.leaderdialogqueue.size ; i++ )
        {
            if ( isdefined( self.leaderdialogqueue[ i ].priority ) && self.leaderdialogqueue[ i ].priority <= newitem.priority )
            {
                continue;
            }
            
            arrayinsert( self.leaderdialogqueue, newitem, i );
            iteminserted = 1;
            break;
        }
    }
    
    if ( !iteminserted )
    {
        self.leaderdialogqueue[ self.leaderdialogqueue.size ] = newitem;
    }
    
    if ( isdefined( self.currentleaderdialog ) )
    {
        return;
    }
    
    self thread play_next_leader_dialog();
}

// Namespace globallogic_audio/globallogic_audio
// Params 0
// Checksum 0x51b20cbc, Offset: 0x2b18
// Size: 0x2a4
function play_next_leader_dialog()
{
    self endon( #"disconnect" );
    self endon( #"flush_dialog" );
    level endon( #"game_ended" );
    
    if ( self.leaderdialogqueue.size == 0 )
    {
        self.currentleaderdialog = undefined;
        return;
    }
    
    nextdialog = self.leaderdialogqueue[ 0 ];
    arrayremoveindex( self.leaderdialogqueue, 0 );
    dialogkey = nextdialog.dialogkey;
    
    if ( isdefined( nextdialog.killstreakids ) )
    {
        triggeredcount = 0;
        
        foreach ( killstreakid in nextdialog.killstreakids )
        {
            if ( isdefined( level.killstreaks_triggered[ killstreakid ] ) )
            {
                triggeredcount++;
            }
        }
        
        if ( triggeredcount == 0 )
        {
            self thread play_next_leader_dialog();
            return;
        }
        else if ( triggeredcount > 1 || nextdialog.playmultiple === 1 )
        {
            if ( isdefined( level.multipledialogkeys[ dialogkey ] ) )
            {
                dialogkey = level.multipledialogkeys[ dialogkey ];
            }
        }
    }
    
    dialogalias = self get_commander_dialog_alias( dialogkey );
    
    if ( !isdefined( dialogalias ) )
    {
        self thread play_next_leader_dialog();
        return;
    }
    
    self playlocalsound( dialogalias );
    nextdialog.playtime = gettime();
    self.currentleaderdialog = nextdialog;
    dialogbuffer = battlechatter::mpdialog_value( nextdialog.dialogbufferkey, battlechatter::mpdialog_value( "commanderDialogBuffer", 0 ) );
    self thread wait_next_leader_dialog( dialogbuffer );
}

// Namespace globallogic_audio/globallogic_audio
// Params 1
// Checksum 0xb9950264, Offset: 0x2dc8
// Size: 0x4c
function wait_next_leader_dialog( dialogbuffer )
{
    self endon( #"disconnect" );
    self endon( #"flush_dialog" );
    level endon( #"game_ended" );
    wait dialogbuffer;
    self thread play_next_leader_dialog();
}

// Namespace globallogic_audio/globallogic_audio
// Params 1
// Checksum 0xe75e6dc9, Offset: 0x2e20
// Size: 0x378
function dialogkey_priority( dialogkey )
{
    switch ( dialogkey )
    {
        case #"enemyrapsmultiple":
        case #"enemyrcbomb":
        case #"enemyrcbombmultiple":
        case #"enemyremotemissile":
        case #"enemyremotemissilemultiple":
        case #"enemyaitank":
        case #"enemyaitankmultiple":
        case #"enemycombatrobot":
        case #"enemycombatrobotmultiple":
        case #"enemydart":
        case #"enemydartmultiple":
        case #"enemydronestrike":
        case #"enemydronestrikemultiple":
        case #"enemySentinel":
        case #"enemyhelicopter":
        case #"enemyhelicoptergunner":
        case #"enemyhelicoptergunnermultiple":
        case #"enemyhelicoptermultiple":
        case #"enemymicrowaveturret":
        case #"enemymicrowaveturretmultiple":
        case #"enemyplanemortar":
        case #"enemyplanemortarmultiple":
        case #"enemyplanemortarused":
        case #"enemyraps":
        case #"enemySentinelMultiple":
        case #"enemyturret":
        case #"enemyturretmultiple":
            return 1;
        case #"gameleadlost":
        case #"gameleadtaken":
        case #"gamelosing":
        case #"gamewinning":
        case #"neardrawing":
        case #"nearlosing":
        case #"nearwinning":
        case #"roundencouragelastplayer":
            return 1;
        case #"ctffriendlyflagreturned":
        case #"ctffriendlyflagtaken":
        case #"domenemyhasb":
        case #"domenemyhasc":
        case #"domenemysecureda":
        case #"domenemysecuredb":
        case #"domenemysecuredc":
        case #"domenemysecuringa":
        case #"domenemysecuringb":
        case #"domenemysecuringc":
        case #"domfriendlysecureda":
        case #"domfriendlysecuredall":
        case #"domfriendlysecuredb":
        case #"domfriendlysecuredc":
        case #"domfriendlysecuringa":
        case #"domfriendlysecuringb":
        case #"domfriendlysecuringc":
        case #"domenemyhasa":
        case #"bombdefused":
        case #"bombenemytaken":
        case #"bombfriendlydropped":
        case #"bombfriendlytaken":
        case #"bombplanted":
        case #"ctfenemyflagcaptured":
        case #"ctfenemyflagdropped":
        case #"hubmoved":
        case #"huboffline":
        case #"hubonline":
        case #"hubsmoved":
        case #"hubsoffline":
        case #"hubsonline":
        case #"kothcaptured":
        case #"kothcontested":
        case #"kothlocated":
        case #"kothlost":
        case #"kothonline":
        case #"kothsecured":
        case #"ctfenemyflagreturned":
        case #"ctfenemyflagtaken":
        case #"ctffriendlyflagcaptured":
        case #"ctffriendlyflagdropped":
        case #"sfgrobotcloseattacker":
        case #"sfgrobotclosedefender":
        case #"sfgrobotdisabledattacker":
        case #"sfgrobotdisableddefender":
        case #"sfgrobotneedreboot":
        case #"sfgrobotrebootedattacker":
        case #"sfgrobotrebooteddefender":
        case #"sfgrobotrebootedtowattacker":
        case #"sfgrobotrebootedtowdefender":
        case #"sfgrobotunderfire":
        case #"sfgrobotunderfireneutral":
        case #"sfgstartattack":
        case #"sfgstartdefend":
        case #"sfgstarthrattack":
        case #"sfgstarthrdefend":
        case #"sfgstarttow":
        case #"sfgtheyreturn":
        case #"sfgwereturn":
        case #"uplorders":
        case #"uplreset":
        case #"upltheydrop":
        case #"upltheytake":
        case #"upltheyuplink":
        case #"upltheyuplinkremote":
        case #"upltransferred":
        case #"uplwedrop":
        case #"uplwetake":
        case #"uplweuplink":
        case #"uplweuplinkremote":
            return 1;
    }
    
    return undefined;
}

// Namespace globallogic_audio/globallogic_audio
// Params 0
// Checksum 0x9c4d2b13, Offset: 0x31a0
// Size: 0x24
function play_equipment_destroyed_on_player()
{
    self play_taacom_dialog( "equipmentDestroyed" );
}

// Namespace globallogic_audio/globallogic_audio
// Params 0
// Checksum 0xa09513d3, Offset: 0x31d0
// Size: 0x24
function play_equipment_hacked_on_player()
{
    self play_taacom_dialog( "equipmentHacked" );
}

// Namespace globallogic_audio/globallogic_audio
// Params 1
// Checksum 0x478b155e, Offset: 0x3200
// Size: 0x72
function get_commander_dialog_alias( dialogkey )
{
    if ( !isdefined( self.pers[ "mpcommander" ] ) )
    {
        return undefined;
    }
    
    commanderbundle = struct::get_script_bundle( "mpdialog_commander", self.pers[ "mpcommander" ] );
    return get_dialog_bundle_alias( commanderbundle, dialogkey );
}

// Namespace globallogic_audio/globallogic_audio
// Params 2
// Checksum 0xf8b3400b, Offset: 0x3280
// Size: 0x96
function get_dialog_bundle_alias( dialogbundle, dialogkey )
{
    if ( !isdefined( dialogbundle ) || !isdefined( dialogkey ) )
    {
        return undefined;
    }
    
    dialogalias = dialogbundle.( dialogkey );
    
    if ( !isdefined( dialogalias ) )
    {
        return;
    }
    
    voiceprefix = dialogbundle.( "voiceprefix" );
    
    if ( isdefined( voiceprefix ) )
    {
        dialogalias = voiceprefix + dialogalias;
    }
    
    return dialogalias;
}

// Namespace globallogic_audio/globallogic_audio
// Params 1
// Checksum 0xb3f3e333, Offset: 0x3320
// Size: 0xe2, Type: bool
function is_team_winning( checkteam )
{
    score = game.stat[ "teamScores" ][ checkteam ];
    
    foreach ( team in level.teams )
    {
        if ( team != checkteam )
        {
            if ( game.stat[ "teamScores" ][ team ] >= score )
            {
                return false;
            }
        }
    }
    
    return true;
}

// Namespace globallogic_audio/globallogic_audio
// Params 0
// Checksum 0xbcbc35bb, Offset: 0x3410
// Size: 0xda, Type: bool
function announce_team_is_winning()
{
    foreach ( team in level.teams )
    {
        if ( is_team_winning( team ) )
        {
            leader_dialog( "gameWinning", team );
            leader_dialog_for_other_teams( "gameLosing", team );
            return true;
        }
    }
    
    return false;
}

// Namespace globallogic_audio/globallogic_audio
// Params 2
// Checksum 0x6f7d6850, Offset: 0x34f8
// Size: 0xe6
function play_2d_on_team( alias, team )
{
    assert( isdefined( level.players ) );
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        player = level.players[ i ];
        
        if ( isdefined( player.pers[ "team" ] ) && player.pers[ "team" ] == team )
        {
            player playlocalsound( alias );
        }
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 1
// Checksum 0xbfb69830, Offset: 0x35e8
// Size: 0x2e
function get_round_switch_dialog( switchtype )
{
    switch ( switchtype )
    {
        case #"halftime":
            return "roundHalftime";
        case #"overtime":
            return "roundOvertime";
        default:
            return "roundSwitchSides";
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 0
// Checksum 0xd0ef8a19, Offset: 0x3640
// Size: 0x64
function function_de3b188d()
{
    level waittill( "game_ended" );
    level util::clientnotify( "pm" );
    level waittill( "sfade" );
    level util::clientnotify( "pmf" );
}

// Namespace globallogic_audio/globallogic_audio
// Params 0
// Checksum 0x6ba3a55c, Offset: 0x36b0
// Size: 0x164
function announcercontroller()
{
    level endon( #"game_ended" );
    level waittill( "match_ending_soon" );
    
    if ( util::islastround() || util::isoneround() )
    {
        if ( level.teambased )
        {
            if ( !announce_team_is_winning() )
            {
                leader_dialog( "min_draw" );
            }
        }
        
        level waittill( "match_ending_very_soon" );
        
        foreach ( team in level.teams )
        {
            leader_dialog( "roundTimeWarning", team, undefined, undefined );
        }
        
        return;
    }
    
    level waittill( "match_ending_vox" );
    leader_dialog( "roundTimeWarning" );
}

// Namespace globallogic_audio/globallogic_audio
// Params 0
// Checksum 0x5aec4732, Offset: 0x3820
// Size: 0x64
function sndmusicfunctions()
{
    level thread sndmusictimesout();
    level thread sndmusichalfway();
    level thread sndmusictimelimitwatcher();
    level thread sndmusicunlock();
}

// Namespace globallogic_audio/globallogic_audio
// Params 0
// Checksum 0xfca7d448, Offset: 0x3890
// Size: 0xc8
function sndmusicsetrandomizer()
{
    if ( game.roundsplayed == 0 )
    {
        game.musicset = randomintrange( 1, 8 );
        
        if ( game.musicset <= 9 )
        {
            game.musicset = "0" + game.musicset;
        }
        
        game.musicset = "_" + game.musicset;
        
        if ( isdefined( level.freerun ) && level.freerun )
        {
            game.musicset = "";
        }
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 0
// Checksum 0x92d6dd10, Offset: 0x3960
// Size: 0xdc
function sndmusicunlock()
{
    level waittill( "game_ended" );
    unlockname = undefined;
    
    switch ( game.musicset )
    {
        case #"_01":
            unlockname = "mus_dystopia_intro";
            break;
        case #"_02":
            unlockname = "mus_filter_intro";
            break;
        case #"_03":
            unlockname = "mus_immersion_intro";
            break;
        case #"_04":
            unlockname = "mus_ruin_intro";
            break;
        case #"_05":
            unlockname = "mus_cod_bites_intro";
            break;
    }
    
    if ( isdefined( unlockname ) )
    {
        level thread audio::unlockfrontendmusic( unlockname );
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 0
// Checksum 0xb93620ba, Offset: 0x3a48
// Size: 0x9c
function sndmusictimesout()
{
    level endon( #"game_ended" );
    level endon( #"musicendingoverride" );
    level waittill( "match_ending_very_soon" );
    
    if ( isdefined( level.gametype ) && level.gametype == "sd" )
    {
        level thread set_music_on_team( "timeOutQuiet" );
        return;
    }
    
    level thread set_music_on_team( "timeOut" );
}

// Namespace globallogic_audio/globallogic_audio
// Params 0
// Checksum 0x130936d5, Offset: 0x3af0
// Size: 0x64
function sndmusichalfway()
{
    level endon( #"game_ended" );
    level endon( #"match_ending_soon" );
    level endon( #"match_ending_very_soon" );
    level waittill( "sndMusicHalfway" );
    level thread set_music_on_team( "underscore" );
}

// Namespace globallogic_audio/globallogic_audio
// Params 0
// Checksum 0xa7880be4, Offset: 0x3b60
// Size: 0xe8
function sndmusictimelimitwatcher()
{
    level endon( #"game_ended" );
    level endon( #"match_ending_soon" );
    level endon( #"match_ending_very_soon" );
    level endon( #"sndmusichalfway" );
    
    if ( !isdefined( level.timelimit ) || level.timelimit == 0 )
    {
        return;
    }
    
    halfway = level.timelimit * 60 * 0.5;
    
    while ( true )
    {
        timeleft = globallogic_utils::gettimeremaining() / 1000;
        
        if ( timeleft <= halfway )
        {
            level notify( #"sndmusichalfway" );
            return;
        }
        
        wait 2;
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 5
// Checksum 0xf97a89e5, Offset: 0x3c50
// Size: 0x1b2
function set_music_on_team( state, team, wait_time, save_state, return_state )
{
    if ( !isdefined( team ) )
    {
        team = "both";
    }
    
    if ( !isdefined( wait_time ) )
    {
        wait_time = 0;
    }
    
    if ( !isdefined( save_state ) )
    {
        save_state = 0;
    }
    
    if ( !isdefined( return_state ) )
    {
        return_state = 0;
    }
    
    assert( isdefined( level.players ) );
    
    foreach ( player in level.players )
    {
        if ( team == "both" )
        {
            player thread set_music_on_player( state, wait_time, save_state, return_state );
            continue;
        }
        
        if ( isdefined( player.pers[ "team" ] ) && player.pers[ "team" ] == team )
        {
            player thread set_music_on_player( state, wait_time, save_state, return_state );
        }
    }
}

// Namespace globallogic_audio/globallogic_audio
// Params 4
// Checksum 0xc073f9c4, Offset: 0x3e10
// Size: 0xfc
function set_music_on_player( state, wait_time, save_state, return_state )
{
    if ( !isdefined( wait_time ) )
    {
        wait_time = 0;
    }
    
    if ( !isdefined( save_state ) )
    {
        save_state = 0;
    }
    
    if ( !isdefined( return_state ) )
    {
        return_state = 0;
    }
    
    self endon( #"disconnect" );
    assert( isplayer( self ) );
    
    if ( isdefined( level.var_4cd7bf5d ) && level.var_4cd7bf5d )
    {
        return;
    }
    
    if ( !isdefined( state ) )
    {
        return;
    }
    
    if ( !isdefined( game.musicset ) )
    {
        return;
    }
    
    music::setmusicstate( state + game.musicset, self );
}

// Namespace globallogic_audio/globallogic_audio
// Params 4
// Checksum 0x884a2a72, Offset: 0x3f18
// Size: 0xbc
function set_music_global( state, wait_time, save_state, return_state )
{
    if ( !isdefined( wait_time ) )
    {
        wait_time = 0;
    }
    
    if ( !isdefined( save_state ) )
    {
        save_state = 0;
    }
    
    if ( !isdefined( return_state ) )
    {
        return_state = 0;
    }
    
    if ( isdefined( level.var_4cd7bf5d ) && level.var_4cd7bf5d )
    {
        return;
    }
    
    if ( !isdefined( state ) )
    {
        return;
    }
    
    if ( !isdefined( game.musicset ) )
    {
        return;
    }
    
    music::setmusicstate( state + game.musicset );
}

