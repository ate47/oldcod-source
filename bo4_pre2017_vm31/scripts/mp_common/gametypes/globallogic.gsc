#using scripts/core_common/array_shared;
#using scripts/core_common/bb_shared;
#using scripts/core_common/bots/bot;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/challenges_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/damagefeedback_shared;
#using scripts/core_common/demo_shared;
#using scripts/core_common/gameobjects_shared;
#using scripts/core_common/globallogic/globallogic_shared;
#using scripts/core_common/hostmigration_shared;
#using scripts/core_common/hud_message_shared;
#using scripts/core_common/hud_shared;
#using scripts/core_common/hud_util_shared;
#using scripts/core_common/killcam_shared;
#using scripts/core_common/lui_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/music_shared;
#using scripts/core_common/persistence_shared;
#using scripts/core_common/player_shared;
#using scripts/core_common/rank_shared;
#using scripts/core_common/simple_hostmigration;
#using scripts/core_common/spawning_shared;
#using scripts/core_common/spectating;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/tweakables_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/visionset_mgr_shared;
#using scripts/core_common/weapons/barrier_builder;
#using scripts/core_common/weapons/hive_gun;
#using scripts/core_common/weapons/weapon_utils;
#using scripts/core_common/weapons/weapons;
#using scripts/mp_common/arena;
#using scripts/mp_common/behavior_tracker;
#using scripts/mp_common/bots/mp_bot;
#using scripts/mp_common/challenges;
#using scripts/mp_common/draft;
#using scripts/mp_common/forward_spawn;
#using scripts/mp_common/gameadvertisement;
#using scripts/mp_common/gamerep;
#using scripts/mp_common/gametypes/battlechatter;
#using scripts/mp_common/gametypes/clientids;
#using scripts/mp_common/gametypes/deathicons;
#using scripts/mp_common/gametypes/dev;
#using scripts/mp_common/gametypes/dogtags;
#using scripts/mp_common/gametypes/friendicons;
#using scripts/mp_common/gametypes/globallogic_audio;
#using scripts/mp_common/gametypes/globallogic_defaults;
#using scripts/mp_common/gametypes/globallogic_player;
#using scripts/mp_common/gametypes/globallogic_score;
#using scripts/mp_common/gametypes/globallogic_spawn;
#using scripts/mp_common/gametypes/globallogic_ui;
#using scripts/mp_common/gametypes/globallogic_utils;
#using scripts/mp_common/gametypes/healthoverlay;
#using scripts/mp_common/gametypes/hostmigration;
#using scripts/mp_common/gametypes/hud_message;
#using scripts/mp_common/gametypes/loadout;
#using scripts/mp_common/gametypes/menus;
#using scripts/mp_common/gametypes/serversettings;
#using scripts/mp_common/gametypes/shellshock;
#using scripts/mp_common/gametypes/weapon_utils;
#using scripts/mp_common/gametypes/weapons;
#using scripts/mp_common/killstreaks/dogs;
#using scripts/mp_common/killstreaks/killstreaks;
#using scripts/mp_common/rat;
#using scripts/mp_common/teams/teams;
#using scripts/mp_common/userspawnselection;
#using scripts/mp_common/util;

#namespace globallogic;

// Namespace globallogic/globallogic
// Params 0, eflags: 0x2
// Checksum 0x78671b2a, Offset: 0x23f8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "globallogic", &__init__, undefined, "visionset_mgr" );
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0x8f4c5f2a, Offset: 0x2438
// Size: 0x98
function __init__()
{
    if ( !isdefined( level.vsmgr_prio_visionset_mpintro ) )
    {
        level.vsmgr_prio_visionset_mpintro = 5;
    }
    
    visionset_mgr::register_info( "visionset", "mpintro", 1, level.vsmgr_prio_visionset_mpintro, 31, 0, &visionset_mgr::ramp_in_out_thread, 0 );
    level.host_migration_activate_visionset_func = &mpintro_visionset_activate_func;
    level.host_migration_deactivate_visionset_func = &mpintro_visionset_deactivate_func;
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0x212dc08e, Offset: 0x24d8
// Size: 0xd00
function init()
{
    level.splitscreen = issplitscreen();
    level.xenon = getdvarstring( "xenonGame" ) == "true";
    level.ps3 = getdvarstring( "ps3Game" ) == "true";
    level.wiiu = getdvarstring( "wiiuGame" ) == "true";
    level.orbis = getdvarstring( "orbisGame" ) == "true";
    level.durango = getdvarstring( "durangoGame" ) == "true";
    level.onlinegame = sessionmodeisonlinegame();
    level.systemlink = sessionmodeissystemlink();
    level.console = level.xenon || level.ps3 || level.wiiu || level.orbis || level.durango;
    level.rankedmatch = gamemodeisusingxp();
    level.leaguematch = 0;
    level.custommatch = gamemodeismode( 1 );
    level.arenamatch = gamemodeisarena();
    level.mpcustommatch = level.custommatch;
    level.contractsenabled = !getgametypesetting( "disableContracts" );
    level.contractsenabled = 0;
    level.disablevehicleburndamage = 1;
    
    /#
        if ( getdvarint( "<dev string:x28>" ) == 1 )
        {
            level.rankedmatch = 1;
        }
    #/
    
    level.script = tolower( getdvarstring( "mapname" ) );
    level.gametype = tolower( getdvarstring( "g_gametype" ) );
    level.teambased = 0;
    level.teamcount = getgametypesetting( "teamCount" );
    level.multiteam = level.teamcount > 2;
    level.teams = [];
    level.teamindex = [];
    teamcount = level.teamcount;
    
    if ( level.teamcount == 1 )
    {
        teamcount = 18;
        level.teams[ "free" ] = "free";
    }
    
    level.teams[ "allies" ] = "allies";
    level.teams[ "axis" ] = "axis";
    level.teamindex[ "neutral" ] = 0;
    level.teamindex[ "allies" ] = 1;
    level.teamindex[ "axis" ] = 2;
    
    for ( teamindex = 3; teamindex <= teamcount ; teamindex++ )
    {
        level.teams[ "team" + teamindex ] = "team" + teamindex;
        level.teamindex[ "team" + teamindex ] = teamindex;
    }
    
    level.overrideteamscore = 0;
    level.overrideplayerscore = 0;
    level.displayhalftimetext = 0;
    level.displayroundendtext = 1;
    level.clampscorelimit = 1;
    level.endgameonscorelimit = 1;
    level.endgameontimelimit = 1;
    level.scoreroundwinbased = 0;
    level.resetplayerscoreeveryround = 0;
    level.doendgamescoreboard = 1;
    level.gameforfeited = 0;
    level.forceautoassign = 0;
    level.halftimetype = "halftime";
    level.halftimesubcaption = &"MP_SWITCHING_SIDES_CAPS";
    level.laststatustime = 0;
    level.waswinning = [];
    level.lastslowprocessframe = 0;
    level.placement = [];
    
    foreach ( team in level.teams )
    {
        level.placement[ team ] = [];
    }
    
    level.placement[ "all" ] = [];
    level.postroundtime = 7;
    level.inovertime = 0;
    level.defaultoffenseradius = 560;
    level.defaultoffenseradiussq = level.defaultoffenseradius * level.defaultoffenseradius;
    level.dropteam = getdvarint( "sv_maxclients" );
    level.infinalkillcam = 0;
    level.new_health_model = getdvarint( "new_health_model", 1 ) > 0;
    globallogic_ui::init();
    registerdvars();
    loadout::initperkdvars();
    level.oldschool = getgametypesetting( "oldschoolMode" );
    precache_mp_leaderboards();
    
    if ( !isdefined( game.tiebreaker ) )
    {
        game.tiebreaker = 0;
    }
    
    if ( !isdefined( game.stat ) )
    {
        game.stat = [];
    }
    
    thread gameadvertisement::init();
    thread gamerep::init();
    level.disablechallenges = 0;
    
    if ( level.leaguematch || getdvarint( "scr_disableChallenges" ) > 0 )
    {
        level.disablechallenges = 1;
    }
    
    level.disablestattracking = getdvarint( "scr_disableStatTracking" ) > 0;
    forward_spawn::setleaderaudiofunction( &globallogic_audio::leader_dialog );
    setup_callbacks();
    clientfield::register( "playercorpse", "firefly_effect", 1, 2, "int" );
    clientfield::register( "playercorpse", "annihilate_effect", 1, 1, "int" );
    clientfield::register( "playercorpse", "pineapplegun_effect", 1, 1, "int" );
    clientfield::register( "actor", "annihilate_effect", 1, 1, "int" );
    clientfield::register( "actor", "pineapplegun_effect", 1, 1, "int" );
    clientfield::register( "world", "game_ended", 1, 1, "int" );
    clientfield::register( "world", "post_game", 1, 1, "int" );
    clientfield::register( "world", "displayTop3Players", 1, 1, "int" );
    clientfield::register( "world", "triggerScoreboardCamera", 1, 1, "int" );
    clientfield::register( "clientuimodel", "hudItems.hideOutcomeUI", 1, 1, "int" );
    clientfield::register( "clientuimodel", "hudItems.remoteKillstreakActivated", 1, 1, "int" );
    clientfield::register( "world", "playTop0Gesture", 1000, 3, "int" );
    clientfield::register( "world", "playTop1Gesture", 1000, 3, "int" );
    clientfield::register( "world", "playTop2Gesture", 1000, 3, "int" );
    clientfield::register( "clientuimodel", "hudItems.captureCrateState", 5000, 2, "int" );
    clientfield::register( "clientuimodel", "hudItems.captureCrateTotalTime", 5000, 13, "int" );
    clientfield::register( "worlduimodel", "hudItems.alliesRoundsWon", 1, 4, "int" );
    clientfield::register( "worlduimodel", "hudItems.axisRoundsWon", 1, 4, "int" );
    clientfield::register( "worlduimodel", "hudItems.alliesLivesCount", 1, 8, "int" );
    clientfield::register( "worlduimodel", "hudItems.axisLivesCount", 1, 8, "int" );
    level thread setroundswonuimodels();
    level.figure_out_attacker = &globallogic_player::figure_out_attacker;
    level.figure_out_friendly_fire = &globallogic_player::figure_out_friendly_fire;
    level.get_base_weapon_param = &weapon_utils::getbaseweaponparam;
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0x183fe4ba, Offset: 0x31e0
// Size: 0x1bc
function registerdvars()
{
    if ( getdvarstring( "ui_guncycle" ) == "" )
    {
        setdvar( "ui_guncycle", 0 );
    }
    
    if ( getdvarstring( "ui_weapon_tiers" ) == "" )
    {
        setdvar( "ui_weapon_tiers", 0 );
    }
    
    setdvar( "ui_text_endreason", "" );
    setmatchflag( "bomb_timer", 0 );
    
    if ( getdvarstring( "scr_vehicle_damage_scalar" ) == "" )
    {
        setdvar( "scr_vehicle_damage_scalar", "1" );
    }
    
    level.vehicledamagescalar = getdvarfloat( "scr_vehicle_damage_scalar" );
    level.fire_audio_repeat_duration = getdvarint( "fire_audio_repeat_duration" );
    level.fire_audio_random_max_duration = getdvarint( "fire_audio_random_max_duration" );
    setdvar( "g_customTeamName_Allies", "" );
    setdvar( "g_customTeamName_Axis", "" );
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0xdea4278f, Offset: 0x33a8
// Size: 0xcc
function setroundswonuimodels()
{
    waitframe( 1 );
    alliesroundswon = 0;
    axisroundswon = 0;
    
    if ( isdefined( game.stat[ "roundswon" ] ) )
    {
        alliesroundswon = game.stat[ "roundswon" ][ "allies" ];
        axisroundswon = game.stat[ "roundswon" ][ "axis" ];
    }
    
    clientfield::set_world_uimodel( "hudItems.alliesRoundsWon", alliesroundswon );
    clientfield::set_world_uimodel( "hudItems.axisRoundsWon", axisroundswon );
}

// Namespace globallogic/globallogic
// Params 10
// Checksum 0x78e6f5af, Offset: 0x3480
// Size: 0x54
function blank( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10 )
{
    
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0x526a5c56, Offset: 0x34e0
// Size: 0x50c
function setup_callbacks()
{
    level.spawnplayer = &globallogic_spawn::spawnplayer;
    level.spawnplayerprediction = &globallogic_spawn::spawnplayerprediction;
    level.spawnclient = &globallogic_spawn::spawnclient;
    level.spawnspectator = &globallogic_spawn::spawnspectator;
    level.spawnintermission = &globallogic_spawn::spawnintermission;
    level.scoreongiveplayerscore = &globallogic_score::giveplayerscore;
    level.onplayerscore = &globallogic_score::default_onplayerscore;
    level.onteamscore = &globallogic_score::default_onteamscore;
    level.var_8da5706a = &globallogic_score::function_86cd0629;
    level.wavespawntimer = &wavespawntimer;
    level.spawnmessage = &globallogic_spawn::default_spawnmessage;
    level.onspawnplayer = &blank;
    level.onspawnplayer = &spawning::onspawnplayer;
    level.onspawnspectator = &globallogic_defaults::default_onspawnspectator;
    level.onspawnintermission = &globallogic_defaults::default_onspawnintermission;
    level.onrespawndelay = &blank;
    level.onforfeit = &globallogic_defaults::default_onforfeit;
    level.ontimelimit = &globallogic_defaults::default_ontimelimit;
    level.onscorelimit = &globallogic_defaults::default_onscorelimit;
    level.onroundscorelimit = &globallogic_defaults::default_onroundscorelimit;
    level.onalivecountchange = &globallogic_defaults::default_onalivecountchange;
    level.ondeadevent = undefined;
    level.ononeleftevent = &globallogic_defaults::default_ononeleftevent;
    level.giveteamscore = &globallogic_score::giveteamscore;
    level.onlastteamaliveevent = &globallogic_defaults::function_45c10f52;
    level.gettimepassed = &globallogic_utils::gettimepassed;
    level.gettimelimit = &globallogic_defaults::default_gettimelimit;
    level.getteamkillpenalty = &globallogic_defaults::default_getteamkillpenalty;
    level.getteamkillscore = &globallogic_defaults::default_getteamkillscore;
    level.iskillboosting = &globallogic_score::default_iskillboosting;
    level._setteamscore = &globallogic_score::_setteamscore;
    level._setplayerscore = &globallogic_score::_setplayerscore;
    level.var_dd07aaa3 = &globallogic_score::function_dd07aaa3;
    level._getteamscore = &globallogic_score::_getteamscore;
    level._getplayerscore = &globallogic_score::_getplayerscore;
    level.var_5468045f = &globallogic_score::function_5468045f;
    level.resetplayerscorestreaks = &globallogic_score::resetplayerscorechainandmomentum;
    level.onprecachegametype = &blank;
    level.onstartgametype = &blank;
    level.onplayerconnect = &blank;
    level.onplayerdisconnect = &blank;
    level.onplayerdamage = &blank;
    level.onplayerkilled = &blank;
    level.onplayerkilledextraunthreadedcbs = [];
    level.onteamoutcomenotify = &hud_message::teamoutcomenotify;
    level.onoutcomenotify = &hud_message::outcomenotify;
    level.var_d6911678 = &hud_message::function_d6911678;
    level.onendgame = &blank;
    level.onroundendgame = &globallogic_defaults::default_onroundendgame;
    level.determinewinner = &globallogic_defaults::function_417075b7;
    level.onmedalawarded = &blank;
    level.dogmanagerongetdogs = &dogs::dog_manager_get_dogs;
    callback::on_joined_team( &globallogic_player::on_joined_team );
    globallogic_ui::setupcallbacks();
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0x63e69c83, Offset: 0x39f8
// Size: 0xec
function precache_mp_friend_leaderboards()
{
    hardcoremode = getgametypesetting( "hardcoreMode" );
    
    if ( !isdefined( hardcoremode ) )
    {
        hardcoremode = 0;
    }
    
    arenamode = isarenamode();
    postfix = "";
    
    if ( hardcoremode )
    {
        postfix = "_HC";
    }
    else if ( arenamode )
    {
        postfix = "_ARENA";
    }
    
    friendleaderboarda = "LB_MP_FRIEND_A" + postfix;
    friendleaderboardb = " LB_MP_FRIEND_B" + postfix;
    precacheleaderboards( friendleaderboarda + friendleaderboardb );
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0xe3f6eb26, Offset: 0x3af0
// Size: 0x104
function precache_mp_anticheat_leaderboards()
{
    hardcoremode = getgametypesetting( "hardcoreMode" );
    
    if ( !isdefined( hardcoremode ) )
    {
        hardcoremode = 0;
    }
    
    arenamode = isarenamode();
    postfix = "";
    
    if ( hardcoremode )
    {
        postfix = "_HC";
    }
    else if ( arenamode )
    {
        postfix = "_ARENA";
    }
    
    anticheatleaderboard = "LB_MP_ANTICHEAT_" + level.gametype + postfix;
    
    if ( level.gametype != "fr" )
    {
        anticheatleaderboard += " LB_MP_ANTICHEAT_GLOBAL";
    }
    
    precacheleaderboards( anticheatleaderboard );
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0xfc7159b2, Offset: 0x3c00
// Size: 0x224
function precache_mp_public_leaderboards()
{
    mapname = getdvarstring( "mapname" );
    hardcoremode = getgametypesetting( "hardcoreMode" );
    
    if ( !isdefined( hardcoremode ) )
    {
        hardcoremode = 0;
    }
    
    arenamode = isarenamode();
    freerunmode = level.gametype == "fr";
    postfix = "";
    
    if ( freerunmode )
    {
        frleaderboard = " LB_MP_GM_FR_" + getsubstr( mapname, 3, mapname.size );
        precacheleaderboards( frleaderboard );
        return;
    }
    else if ( hardcoremode )
    {
        postfix = "_HC";
    }
    else if ( arenamode )
    {
        postfix = "_ARENA";
    }
    
    careerleaderboard = " LB_MP_GB_SCORE" + postfix;
    prestigelb = " LB_MP_GB_XPPRESTIGE";
    gamemodeleaderboard = "LB_MP_GM_" + level.gametype + postfix;
    arenaleaderboard = "";
    
    if ( gamemodeismode( 6 ) )
    {
        arenaslot = arenagetslot();
        arenaleaderboard = " LB_MP_ARENA_MASTERS_0" + arenaslot;
    }
    
    precacheleaderboards( gamemodeleaderboard + careerleaderboard + prestigelb + arenaleaderboard );
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0x4045e281, Offset: 0x3e30
// Size: 0x44
function precache_mp_custom_leaderboards()
{
    customleaderboards = "LB_MP_CG_" + level.gametype;
    precacheleaderboards( "LB_MP_CG_GENERAL " + customleaderboards );
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0x8a2aee97, Offset: 0x3e80
// Size: 0x8c
function precache_mp_leaderboards()
{
    if ( bot::is_bot_ranked_match() )
    {
        return;
    }
    
    if ( level.rankedmatch || level.gametype == "fr" )
    {
        precache_mp_public_leaderboards();
        precache_mp_friend_leaderboards();
        precache_mp_anticheat_leaderboards();
        return;
    }
    
    precache_mp_custom_leaderboards();
}

// Namespace globallogic/globallogic
// Params 6
// Checksum 0xdf73699a, Offset: 0x3f18
// Size: 0xd4
function setvisiblescoreboardcolumns( col1, col2, col3, col4, col5, col6 )
{
    if ( !isdefined( col6 ) )
    {
        col6 = "";
    }
    
    if ( !level.rankedmatch )
    {
        setscoreboardcolumns( col1, col2, col3, col4, col5, col6, "sbtimeplayed", "shotshit", "shotsmissed", "victory" );
        return;
    }
    
    setscoreboardcolumns( col1, col2, col3, col4, col5, col6 );
}

// Namespace globallogic/globallogic
// Params 4
// Checksum 0xcb1a1e67, Offset: 0x3ff8
// Size: 0x114
function compareteambygamestat( gamestat, teama, teamb, previous_winner_score )
{
    winner = undefined;
    
    if ( teama == "tie" )
    {
        winner = "tie";
        
        if ( previous_winner_score < game.stat[ gamestat ][ teamb ] )
        {
            winner = teamb;
        }
    }
    else if ( game.stat[ gamestat ][ teama ] == game.stat[ gamestat ][ teamb ] )
    {
        winner = "tie";
    }
    else if ( game.stat[ gamestat ][ teamb ] > game.stat[ gamestat ][ teama ] )
    {
        winner = teamb;
    }
    else
    {
        winner = teama;
    }
    
    return winner;
}

// Namespace globallogic/globallogic
// Params 1
// Checksum 0xdc790517, Offset: 0x4118
// Size: 0xfa
function determineteamwinnerbygamestat( gamestat )
{
    teamkeys = getarraykeys( level.teams );
    winner = teamkeys[ 0 ];
    previous_winner_score = game.stat[ gamestat ][ winner ];
    
    for ( teamindex = 1; teamindex < teamkeys.size ; teamindex++ )
    {
        winner = compareteambygamestat( gamestat, winner, teamkeys[ teamindex ], previous_winner_score );
        
        if ( winner != "tie" )
        {
            previous_winner_score = game.stat[ gamestat ][ winner ];
        }
    }
    
    return winner;
}

// Namespace globallogic/globallogic
// Params 3
// Checksum 0x9b287d4d, Offset: 0x4220
// Size: 0xf6
function compareteambyteamscore( teama, teamb, previous_winner_score )
{
    winner = undefined;
    teambscore = [[ level._getteamscore ]]( teamb );
    
    if ( teama == "tie" )
    {
        winner = "tie";
        
        if ( previous_winner_score < teambscore )
        {
            winner = teamb;
        }
        
        return winner;
    }
    
    teamascore = [[ level._getteamscore ]]( teama );
    
    if ( teambscore == teamascore )
    {
        winner = "tie";
    }
    else if ( teambscore > teamascore )
    {
        winner = teamb;
    }
    else
    {
        winner = teama;
    }
    
    return winner;
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0x36778cdc, Offset: 0x4320
// Size: 0xea
function determineteamwinnerbyteamscore()
{
    teamkeys = getarraykeys( level.teams );
    winner = teamkeys[ 0 ];
    previous_winner_score = [[ level._getteamscore ]]( winner );
    
    for ( teamindex = 1; teamindex < teamkeys.size ; teamindex++ )
    {
        winner = compareteambyteamscore( winner, teamkeys[ teamindex ], previous_winner_score );
        
        if ( winner != "tie" )
        {
            previous_winner_score = [[ level._getteamscore ]]( winner );
        }
    }
    
    return winner;
}

// Namespace globallogic/globallogic
// Params 1
// Checksum 0x43f82a09, Offset: 0x4418
// Size: 0x1c4
function forceend( hostsucks )
{
    if ( !isdefined( hostsucks ) )
    {
        hostsucks = 0;
    }
    
    if ( level.hostforcedend || level.forcedend )
    {
        return;
    }
    
    winner = undefined;
    
    if ( level.teambased )
    {
        winner = determineteamwinnerbygamestat( "teamScores" );
        globallogic_utils::logteamwinstring( "host ended game", winner );
    }
    else
    {
        winner = globallogic_score::gethighestscoringplayer();
        
        /#
            if ( isdefined( winner ) )
            {
                print( "<dev string:x3d>" + winner.name );
            }
            else
            {
                print( "<dev string:x54>" );
            }
        #/
    }
    
    level.forcedend = 1;
    level.hostforcedend = 1;
    
    if ( hostsucks )
    {
        endstring = &"MP_HOST_SUCKS";
    }
    else if ( level.splitscreen )
    {
        endstring = &"MP_ENDED_GAME";
    }
    else
    {
        endstring = &"MP_HOST_ENDED_GAME";
    }
    
    setmatchflag( "disableIngameMenu", 1 );
    setdvar( "ui_text_endreason", endstring );
    thread endgame( winner, endstring );
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0xfd4b30aa, Offset: 0x45e8
// Size: 0x164
function killserverpc()
{
    if ( level.hostforcedend || level.forcedend )
    {
        return;
    }
    
    winner = undefined;
    
    if ( level.teambased )
    {
        winner = determineteamwinnerbygamestat( "teamScores" );
        globallogic_utils::logteamwinstring( "host ended game", winner );
    }
    else
    {
        winner = globallogic_score::gethighestscoringplayer();
        
        /#
            if ( isdefined( winner ) )
            {
                print( "<dev string:x3d>" + winner.name );
            }
            else
            {
                print( "<dev string:x54>" );
            }
        #/
    }
    
    level.forcedend = 1;
    level.hostforcedend = 1;
    level.killserver = 1;
    endstring = &"MP_HOST_ENDED_GAME";
    println( "<dev string:x69>" );
    thread endgame( winner, endstring );
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0x2906b6f4, Offset: 0x4758
// Size: 0xbe, Type: bool
function atleasttwoteams()
{
    valid_count = 0;
    
    foreach ( team in level.teams )
    {
        if ( level.playercount[ team ] != 0 )
        {
            valid_count++;
        }
    }
    
    if ( valid_count < 2 )
    {
        return false;
    }
    
    return true;
}

// Namespace globallogic/globallogic
// Params 1
// Checksum 0xd5fd6e93, Offset: 0x4820
// Size: 0x62, Type: bool
function checkifteamforfeits( team )
{
    if ( !game.everexisted[ team ] )
    {
        return false;
    }
    
    if ( level.playercount[ team ] < 1 && util::totalplayercount() > 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0xf04a54b6, Offset: 0x4890
// Size: 0x140, Type: bool
function function_c64c7a91()
{
    var_4dfb2196 = 0;
    var_9c3f07a7 = undefined;
    
    foreach ( team in level.teams )
    {
        if ( checkifteamforfeits( team ) )
        {
            var_4dfb2196++;
            
            if ( !level.multiteam )
            {
                thread [[ level.onforfeit ]]( team );
                return true;
            }
            
            continue;
        }
        
        var_9c3f07a7 = team;
    }
    
    if ( level.multiteam && var_4dfb2196 == level.teams.size - 1 )
    {
        thread [[ level.onforfeit ]]( var_9c3f07a7 );
        return true;
    }
    
    return false;
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0x8346b5cf, Offset: 0x49d8
// Size: 0xa6
function dospawnqueueupdates()
{
    foreach ( team in level.teams )
    {
        if ( level.spawnqueuemodified[ team ] )
        {
            [[ level.onalivecountchange ]]( team );
        }
    }
}

// Namespace globallogic/globallogic
// Params 1
// Checksum 0xfecf026b, Offset: 0x4a88
// Size: 0x4a, Type: bool
function isteamalldead( team )
{
    return level.everexisted[ team ] && !level.alivecount[ team ] && !level.playerlives[ team ];
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0x7f96bbab, Offset: 0x4ae0
// Size: 0x9c, Type: bool
function areallteamsdead()
{
    foreach ( team in level.teams )
    {
        if ( !isteamalldead( team ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0x3c509f81, Offset: 0x4b88
// Size: 0x10e
function function_4f9a4c7f()
{
    count = 0;
    var_42bbdeba = 0;
    aliveteam = undefined;
    
    foreach ( team in level.teams )
    {
        if ( level.everexisted[ team ] )
        {
            if ( !isteamalldead( team ) )
            {
                aliveteam = team;
                count++;
            }
            
            var_42bbdeba++;
        }
    }
    
    if ( var_42bbdeba > 1 && count == 1 )
    {
        return aliveteam;
    }
    
    return undefined;
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0xa51223b0, Offset: 0x4ca0
// Size: 0x1bc, Type: bool
function dodeadeventupdates()
{
    if ( level.teambased )
    {
        if ( areallteamsdead() )
        {
            [[ level.ondeadevent ]]( "all" );
            return true;
        }
        
        if ( !isdefined( level.ondeadevent ) )
        {
            var_718021e5 = function_4f9a4c7f();
            
            if ( isdefined( var_718021e5 ) )
            {
                [[ level.onlastteamaliveevent ]]( var_718021e5 );
                return true;
            }
        }
        else
        {
            foreach ( team in level.teams )
            {
                if ( isteamalldead( team ) )
                {
                    [[ level.ondeadevent ]]( team );
                    return true;
                }
            }
        }
    }
    else if ( totalalivecount() == 0 && totalplayerlives() == 0 && level.maxplayercount > 1 )
    {
        [[ level.ondeadevent ]]( "all" );
        return true;
    }
    
    return false;
}

// Namespace globallogic/globallogic
// Params 1
// Checksum 0x9ae01b89, Offset: 0x4e68
// Size: 0x5a, Type: bool
function isonlyoneleftaliveonteam( team )
{
    return level.lastalivecount[ team ] > 1 && level.alivecount[ team ] == 1 && level.playerlives[ team ] == 1;
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0x223e28a6, Offset: 0x4ed0
// Size: 0x12c, Type: bool
function doonelefteventupdates()
{
    if ( level.teambased )
    {
        foreach ( team in level.teams )
        {
            if ( isonlyoneleftaliveonteam( team ) )
            {
                [[ level.ononeleftevent ]]( team );
                return true;
            }
        }
    }
    else if ( totalalivecount() == 1 && totalplayerlives() == 1 && level.maxplayercount > 1 )
    {
        [[ level.ononeleftevent ]]( "all" );
        return true;
    }
    
    return false;
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0x1e773f22, Offset: 0x5008
// Size: 0x220
function updategameevents()
{
    /#
        if ( getdvarint( "<dev string:x83>" ) == 1 )
        {
            return;
        }
    #/
    
    if ( ( level.rankedmatch || level.wagermatch || level.leaguematch ) && !level.ingraceperiod )
    {
        if ( level.teambased )
        {
            if ( !level.gameforfeited )
            {
                if ( game.state == "playing" && function_c64c7a91() )
                {
                    return;
                }
            }
            else if ( atleasttwoteams() )
            {
                level.gameforfeited = 0;
                level notify( #"hash_577494dc" );
            }
        }
        else if ( !level.gameforfeited )
        {
            if ( util::totalplayercount() == 1 && level.maxplayercount > 1 )
            {
                thread [[ level.onforfeit ]]();
                return;
            }
        }
        else if ( util::totalplayercount() > 1 )
        {
            level.gameforfeited = 0;
            level notify( #"hash_577494dc" );
        }
    }
    
    if ( !level.playerqueuedrespawn && !level.numlives && !level.inovertime )
    {
        return;
    }
    
    if ( level.ingraceperiod )
    {
        return;
    }
    
    if ( level.playerqueuedrespawn )
    {
        dospawnqueueupdates();
    }
    
    if ( dodeadeventupdates() )
    {
        return;
    }
    
    if ( doonelefteventupdates() )
    {
        return;
    }
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0xba7ea107, Offset: 0x5230
// Size: 0x80
function mpintro_visionset_ramp_hold_func()
{
    level endon( #"mpintro_ramp_out_notify" );
    
    while ( true )
    {
        for ( player_index = 0; player_index < level.players.size ; player_index++ )
        {
            self visionset_mgr::set_state_active( level.players[ player_index ], 1 );
        }
        
        waitframe( 1 );
    }
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0x8e08c360, Offset: 0x52b8
// Size: 0x3c
function mpintro_visionset_activate_func()
{
    visionset_mgr::activate( "visionset", "mpintro", undefined, 0, &mpintro_visionset_ramp_hold_func, 2 );
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0xa0cfdff3, Offset: 0x5300
// Size: 0x14
function mpintro_visionset_deactivate_func()
{
    level notify( #"mpintro_ramp_out_notify" );
}

// Namespace globallogic/globallogic
// Params 2
// Checksum 0x346e88cc, Offset: 0x5320
// Size: 0x13a
function showobjectivenotificationuiforallplayers( missiontype, delay )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( delay ) )
    {
        delay = 2;
    }
    
    wait delay;
    
    foreach ( player in level.players )
    {
        team = player.pers[ "team" ];
        hintmessage = util::getobjectivehinttext( team );
        
        if ( isdefined( hintmessage ) )
        {
            player luinotifyevent( &"show_gametype_objective_hint", 3, hintmessage, missiontype, team == game.attackers );
        }
    }
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0xb62bf508, Offset: 0x5468
// Size: 0x29c
function matchstarttimer()
{
    mpintro_visionset_activate_func();
    level thread sndsetmatchsnapshot( 1 );
    waitforplayers();
    counttime = int( level.prematchperiod );
    
    if ( counttime >= 2 )
    {
        while ( counttime > 0 && !level.gameended )
        {
            luinotifyevent( &"create_prematch_timer", 1, gettime() + counttime * 1000 );
            
            if ( counttime == 2 )
            {
                mpintro_visionset_deactivate_func();
            }
            
            if ( counttime == 3 )
            {
                level thread sndsetmatchsnapshot( 0 );
                
                foreach ( player in level.players )
                {
                    if ( player.hasspawned || player.pers[ "team" ] == "spectator" )
                    {
                        player globallogic_audio::set_music_on_player( "spawnPreRise" );
                    }
                }
            }
            
            counttime--;
            
            foreach ( player in level.players )
            {
                player playlocalsound( "uin_start_count_down" );
            }
            
            wait 1;
        }
        
        luinotifyevent( &"prematch_timer_ended", 0 );
        return;
    }
    
    mpintro_visionset_deactivate_func();
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0xdd9a4f62, Offset: 0x5710
// Size: 0x34
function function_ef3ff29e()
{
    level waittill( "game_ended" );
    level clientfield::set( "gameplay_started", 0 );
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0x234ad5c6, Offset: 0x5750
// Size: 0x34
function matchstarttimerskip()
{
    visionsetnaked( getdvarstring( "mapname" ), 0 );
}

// Namespace globallogic/globallogic
// Params 1
// Checksum 0x72b0dcb6, Offset: 0x5790
// Size: 0x34
function sndsetmatchsnapshot( num )
{
    waitframe( 1 );
    level clientfield::set( "sndMatchSnapshot", num );
}

// Namespace globallogic/globallogic
// Params 2
// Checksum 0x9b2fc233, Offset: 0x57d0
// Size: 0x8a
function notifyteamwavespawn( team, time )
{
    if ( time - level.lastwave[ team ] > level.wavedelay[ team ] * 1000 )
    {
        level notify( "wave_respawn_" + team );
        level.lastwave[ team ] = time;
        level.waveplayerspawnindex[ team ] = 0;
    }
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0xb36e64e9, Offset: 0x5868
// Size: 0xd4
function wavespawntimer()
{
    level endon( #"game_ended" );
    
    while ( game.state == "playing" )
    {
        time = gettime();
        
        foreach ( team in level.teams )
        {
            notifyteamwavespawn( team, time );
        }
        
        waitframe( 1 );
    }
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0xd5027acc, Offset: 0x5948
// Size: 0xa2, Type: bool
function hostidledout()
{
    hostplayer = util::gethostplayer();
    
    /#
        if ( getdvarint( "<dev string:x99>" ) == 1 || getdvarint( "<dev string:x83>" ) == 1 )
        {
            return false;
        }
    #/
    
    if ( isdefined( hostplayer ) && !hostplayer.hasspawned && !isdefined( hostplayer.selectedclass ) )
    {
        return true;
    }
    
    return false;
}

// Namespace globallogic/globallogic
// Params 3
// Checksum 0xeff4e241, Offset: 0x59f8
// Size: 0x54
function incrementmatchcompletionstat( gamemode, playedorhosted, stat )
{
    self adddstat( "gameHistory", gamemode, "modeHistory", playedorhosted, stat, 1 );
}

// Namespace globallogic/globallogic
// Params 3
// Checksum 0xf497876b, Offset: 0x5a58
// Size: 0x54
function setmatchcompletionstat( gamemode, playedorhosted, stat )
{
    self setdstat( "gameHistory", gamemode, "modeHistory", playedorhosted, stat, 1 );
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0xc0e78206, Offset: 0x5ab8
// Size: 0x17a
function getteamscoreratio()
{
    playerteam = self.pers[ "team" ];
    score = getteamscore( playerteam );
    otherteamscore = 0;
    
    foreach ( team in level.teams )
    {
        if ( team == playerteam )
        {
            continue;
        }
        
        otherteamscore += getteamscore( team );
    }
    
    if ( level.teams.size > 1 )
    {
        otherteamscore /= level.teams.size - 1;
    }
    
    if ( otherteamscore != 0 )
    {
        return ( float( score ) / float( otherteamscore ) );
    }
    
    return score;
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0x853e390b, Offset: 0x5c40
// Size: 0x96
function gethighestscore()
{
    highestscore = -999999999;
    
    for ( index = 0; index < level.players.size ; index++ )
    {
        player = level.players[ index ];
        
        if ( player.score > highestscore )
        {
            highestscore = player.score;
        }
    }
    
    return highestscore;
}

// Namespace globallogic/globallogic
// Params 1
// Checksum 0x55025e22, Offset: 0x5ce0
// Size: 0xba
function getnexthighestscore( score )
{
    highestscore = -999999999;
    
    for ( index = 0; index < level.players.size ; index++ )
    {
        player = level.players[ index ];
        
        if ( player.score >= score )
        {
            continue;
        }
        
        if ( player.score > highestscore )
        {
            highestscore = player.score;
        }
    }
    
    return highestscore;
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0x749bd682, Offset: 0x5da8
// Size: 0x3b4
function recordplaystyleinformation()
{
    avgkilldistance = 0;
    percenttimemoving = 0;
    avgspeedofplayerwhenmoving = 0;
    totalkilldistances = float( self.pers[ "kill_distances" ] );
    numkilldistanceentries = float( self.pers[ "num_kill_distance_entries" ] );
    timeplayedmoving = float( self.pers[ "time_played_moving" ] );
    timeplayedalive = float( self.pers[ "time_played_alive" ] );
    totalspeedswhenmoving = float( self.pers[ "total_speeds_when_moving" ] );
    numspeedswhenmovingentries = float( self.pers[ "num_speeds_when_moving_entries" ] );
    totaldistancetravelled = float( self.pers[ "total_distance_travelled" ] );
    movementupdatecount = float( self.pers[ "movement_Update_Count" ] );
    
    if ( numkilldistanceentries > 0 )
    {
        avgkilldistance = totalkilldistances / numkilldistanceentries;
    }
    
    movementupdatedenom = int( movementupdatecount / 5 );
    
    if ( movementupdatedenom > 0 )
    {
        percenttimemoving = numspeedswhenmovingentries / movementupdatedenom * 100;
    }
    
    if ( numspeedswhenmovingentries > 0 )
    {
        avgspeedofplayerwhenmoving = totalspeedswhenmoving / numspeedswhenmovingentries;
    }
    
    recordplayerstats( self, "totalKillDistances", totalkilldistances );
    recordplayerstats( self, "numKillDistanceEntries", numkilldistanceentries );
    recordplayerstats( self, "timePlayedMoving", timeplayedmoving );
    recordplayerstats( self, "timePlayedAlive", timeplayedalive );
    recordplayerstats( self, "totalSpeedsWhenMoving", totalspeedswhenmoving );
    recordplayerstats( self, "numSpeedsWhenMovingEntries", numspeedswhenmovingentries );
    recordplayerstats( self, "averageKillDistance", avgkilldistance );
    recordplayerstats( self, "percentageOfTimeMoving", percenttimemoving );
    recordplayerstats( self, "averageSpeedDuringMatch", avgspeedofplayerwhenmoving );
    recordplayerstats( self, "totalDistanceTravelled", totaldistancetravelled );
    bbprint( "mpplaystyles", "averageKillDistance %f percentageOfTimeMoving %f averageSpeedDuringMatch %f", avgkilldistance, percenttimemoving, avgspeedofplayerwhenmoving );
}

// Namespace globallogic/globallogic
// Params 1
// Checksum 0x35f3de31, Offset: 0x6168
// Size: 0x98
function getplayerbyname( name )
{
    for ( index = 0; index < level.players.size ; index++ )
    {
        player = level.players[ index ];
        
        if ( player isbot() )
        {
            continue;
        }
        
        if ( player.name == name )
        {
            return player;
        }
    }
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0x8cc81489, Offset: 0x6208
// Size: 0x726
function sendafteractionreport()
{
    /#
        if ( getdvarint( "<dev string:x99>" ) == 1 )
        {
            return;
        }
    #/
    
    for ( index = 0; index < level.players.size ; index++ )
    {
        player = level.players[ index ];
        
        if ( player isbot() )
        {
            continue;
        }
        
        nemesis = player.pers[ "nemesis_name" ];
        
        if ( !isdefined( player.pers[ "killed_players" ][ nemesis ] ) )
        {
            player.pers[ "killed_players" ][ nemesis ] = 0;
        }
        
        if ( !isdefined( player.pers[ "killed_by" ][ nemesis ] ) )
        {
            player.pers[ "killed_by" ][ nemesis ] = 0;
        }
        
        spread = player.kills - player.deaths;
        
        if ( player.pers[ "cur_kill_streak" ] > player.pers[ "best_kill_streak" ] )
        {
            player.pers[ "best_kill_streak" ] = player.pers[ "cur_kill_streak" ];
        }
        
        if ( level.rankedmatch || level.leaguematch )
        {
            player persistence::set_after_action_report_stat( "privateMatch", 0 );
        }
        else
        {
            player persistence::set_after_action_report_stat( "privateMatch", 1 );
        }
        
        player setnemesisxuid( player.pers[ "nemesis_xuid" ] );
        player persistence::set_after_action_report_stat( "nemesisName", nemesis );
        player persistence::set_after_action_report_stat( "nemesisRank", player.pers[ "nemesis_rank" ] );
        player persistence::set_after_action_report_stat( "nemesisRankIcon", player.pers[ "nemesis_rankIcon" ] );
        player persistence::set_after_action_report_stat( "nemesisKills", player.pers[ "killed_players" ][ nemesis ] );
        player persistence::set_after_action_report_stat( "nemesisKilledBy", player.pers[ "killed_by" ][ nemesis ] );
        nemesisplayerent = getplayerbyname( nemesis );
        
        if ( isdefined( nemesisplayerent ) )
        {
            player persistence::set_after_action_report_stat( "nemesisHeroIndex", nemesisplayerent getcharacterbodytype() );
        }
        
        player persistence::set_after_action_report_stat( "bestKillstreak", player.pers[ "best_kill_streak" ] );
        player persistence::set_after_action_report_stat( "kills", player.kills );
        player persistence::set_after_action_report_stat( "deaths", player.deaths );
        player persistence::set_after_action_report_stat( "headshots", player.headshots );
        player persistence::set_after_action_report_stat( "score", player.score );
        player persistence::set_after_action_report_stat( "xpEarned", int( player.pers[ "summary" ][ "xp" ] ) );
        player persistence::set_after_action_report_stat( "cpEarned", int( player.pers[ "summary" ][ "codpoints" ] ) );
        player persistence::set_after_action_report_stat( "miscBonus", int( player.pers[ "summary" ][ "challenge" ] + player.pers[ "summary" ][ "misc" ] ) );
        player persistence::set_after_action_report_stat( "matchBonus", int( player.pers[ "summary" ][ "match" ] ) );
        player persistence::set_after_action_report_stat( "demoFileID", getdemofileid() );
        player persistence::set_after_action_report_stat( "team", teams::getteamindex( player.team ) );
        alliesscore = globallogic_score::_getteamscore( "allies" );
        
        if ( isdefined( alliesscore ) )
        {
            player persistence::set_after_action_report_stat( "alliesScore", alliesscore );
        }
        
        axisscore = globallogic_score::_getteamscore( "axis" );
        
        if ( isdefined( axisscore ) )
        {
            player persistence::set_after_action_report_stat( "axisScore", axisscore );
        }
        
        player persistence::set_after_action_report_stat( "gameTypeRef", level.gametype );
        player persistence::set_after_action_report_stat( "mapname", getdvarstring( "ui_mapname" ) );
    }
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0x612dd377, Offset: 0x6938
// Size: 0x544
function updateandfinalizematchrecord()
{
    /#
        if ( getdvarint( "<dev string:x99>" ) == 1 )
        {
            return;
        }
    #/
    
    for ( index = 0; index < level.players.size ; index++ )
    {
        player = level.players[ index ];
        player globallogic_player::record_special_move_data_for_life( undefined );
        
        if ( player isbot() )
        {
            continue;
        }
        
        player globallogic_player::record_global_mp_stats_for_player_at_match_end();
        nemesis = player.pers[ "nemesis_name" ];
        
        if ( !isdefined( player.pers[ "killed_players" ][ nemesis ] ) )
        {
            player.pers[ "killed_players" ][ nemesis ] = 0;
        }
        
        if ( !isdefined( player.pers[ "killed_by" ][ nemesis ] ) )
        {
            player.pers[ "killed_by" ][ nemesis ] = 0;
        }
        
        spread = player.kills - player.deaths;
        
        if ( player.pers[ "cur_kill_streak" ] > player.pers[ "best_kill_streak" ] )
        {
            player.pers[ "best_kill_streak" ] = player.pers[ "cur_kill_streak" ];
        }
        
        if ( level.onlinegame )
        {
            teamscoreratio = player getteamscoreratio();
            scoreboardposition = getplacementforplayer( player );
            
            if ( scoreboardposition < 0 )
            {
                scoreboardposition = level.players.size;
            }
            
            player gamehistoryfinishmatch( 4, player.kills, player.deaths, player.score, scoreboardposition, teamscoreratio );
            placement = level.placement[ "all" ];
            
            for ( otherplayerindex = 0; otherplayerindex < placement.size ; otherplayerindex++ )
            {
                if ( level.placement[ "all" ][ otherplayerindex ] == player )
                {
                    recordplayerstats( player, "position", otherplayerindex );
                }
            }
            
            if ( isdefined( player.pers[ "matchesPlayedStatsTracked" ] ) )
            {
                gamemode = util::getcurrentgamemode();
                player incrementmatchcompletionstat( gamemode, "played", "completed" );
                
                if ( isdefined( player.pers[ "matchesHostedStatsTracked" ] ) )
                {
                    player incrementmatchcompletionstat( gamemode, "hosted", "completed" );
                    player.pers[ "matchesHostedStatsTracked" ] = undefined;
                }
                
                player.pers[ "matchesPlayedStatsTracked" ] = undefined;
            }
            
            recordplayerstats( player, "highestKillStreak", player.pers[ "best_kill_streak" ] );
            recordplayerstats( player, "numUavCalled", player killstreaks::get_killstreak_usage( "uav_used" ) );
            recordplayerstats( player, "numDogsCalleD", player killstreaks::get_killstreak_usage( "dogs_used" ) );
            recordplayerstats( player, "numDogsKills", player.pers[ "dog_kills" ] );
            player recordplaystyleinformation();
            recordplayermatchend( player );
            recordplayerstats( player, "presentAtEnd", 1 );
        }
    }
    
    finalizematchrecord();
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0x54e6b3f2, Offset: 0x6e88
// Size: 0x1d2
function gamehistoryplayerkicked()
{
    teamscoreratio = self getteamscoreratio();
    scoreboardposition = getplacementforplayer( self );
    
    if ( scoreboardposition < 0 )
    {
        scoreboardposition = level.players.size;
    }
    
    /#
        assert( isdefined( self.kills ) );
        assert( isdefined( self.deaths ) );
        assert( isdefined( self.score ) );
        assert( isdefined( scoreboardposition ) );
        assert( isdefined( teamscoreratio ) );
    #/
    
    self gamehistoryfinishmatch( 2, self.kills, self.deaths, self.score, scoreboardposition, teamscoreratio );
    
    if ( isdefined( self.pers[ "matchesPlayedStatsTracked" ] ) )
    {
        gamemode = util::getcurrentgamemode();
        self incrementmatchcompletionstat( gamemode, "played", "kicked" );
        self.pers[ "matchesPlayedStatsTracked" ] = undefined;
    }
    
    uploadstats( self );
    wait 1;
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0x62b29c66, Offset: 0x7068
// Size: 0x19c
function gamehistoryplayerquit()
{
    teamscoreratio = self getteamscoreratio();
    scoreboardposition = getplacementforplayer( self );
    
    if ( scoreboardposition < 0 )
    {
        scoreboardposition = level.players.size;
    }
    
    self gamehistoryfinishmatch( 3, self.kills, self.deaths, self.score, scoreboardposition, teamscoreratio );
    
    if ( isdefined( self.pers[ "matchesPlayedStatsTracked" ] ) )
    {
        gamemode = util::getcurrentgamemode();
        self incrementmatchcompletionstat( gamemode, "played", "quit" );
        
        if ( isdefined( self.pers[ "matchesHostedStatsTracked" ] ) )
        {
            self incrementmatchcompletionstat( gamemode, "hosted", "quit" );
            self.pers[ "matchesHostedStatsTracked" ] = undefined;
        }
        
        self.pers[ "matchesPlayedStatsTracked" ] = undefined;
    }
    
    uploadstats( self );
    
    if ( !self ishost() )
    {
        wait 1;
    }
}

// Namespace globallogic/globallogic
// Params 2
// Checksum 0x72cf8eaf, Offset: 0x7210
// Size: 0x2ec
function displayroundend( winner, endreasontext )
{
    if ( level.displayroundendtext )
    {
        if ( level.teambased )
        {
            if ( winner == "tie" )
            {
                demo::function_e2be394( "round_result", level.teamindex[ "neutral" ], level.teamindex[ "neutral" ] );
            }
            else
            {
                demo::function_e2be394( "round_result", level.teamindex[ winner ], level.teamindex[ "neutral" ] );
            }
        }
        
        setmatchflag( "cg_drawSpectatorMessages", 0 );
        players = level.players;
        
        for ( index = 0; index < players.size ; index++ )
        {
            player = players[ index ];
            
            if ( !util::waslastround() )
            {
                player notify( #"round_ended" );
            }
            
            if ( !isdefined( player.pers[ "team" ] ) )
            {
                player [[ level.spawnintermission ]]( 1 );
                continue;
            }
            
            if ( level.teambased )
            {
                player thread [[ level.onteamoutcomenotify ]]( winner, "roundend", endreasontext );
                player globallogic_audio::set_music_on_player( "roundEnd" );
            }
            else
            {
                player thread [[ level.onoutcomenotify ]]( winner, 1, endreasontext );
                player globallogic_audio::set_music_on_player( "roundEnd" );
            }
            
            player setclientuivisibilityflag( "hud_visible", 0 );
            player setclientuivisibilityflag( "g_compassShowEnemies", 0 );
        }
    }
    
    if ( util::waslastround() )
    {
        roundendwait( level.roundenddelay, 0 );
        return;
    }
    
    thread globallogic_audio::announce_round_winner( winner, level.roundenddelay / 4 );
    roundendwait( level.roundenddelay, 1 );
}

// Namespace globallogic/globallogic
// Params 2
// Checksum 0xe41ff8e7, Offset: 0x7508
// Size: 0x2bc
function displayroundswitch( winner, endreasontext )
{
    switchtype = level.halftimetype;
    level thread globallogic_audio::set_music_global( "roundSwitch" );
    
    if ( switchtype == "halftime" )
    {
        if ( isdefined( level.nextroundisovertime ) && level.nextroundisovertime )
        {
            switchtype = "overtime";
        }
        else if ( level.roundlimit )
        {
            if ( game.roundsplayed * 2 == level.roundlimit )
            {
                switchtype = "halftime";
            }
            else
            {
                switchtype = "intermission";
            }
        }
        else if ( level.scorelimit )
        {
            if ( isdefined( level.roundswitch ) && level.roundswitch == 1 )
            {
                switchtype = "intermission";
            }
            else if ( game.roundsplayed == level.scorelimit - 1 )
            {
                switchtype = "halftime";
            }
            else
            {
                switchtype = "intermission";
            }
        }
        else
        {
            switchtype = "intermission";
        }
    }
    
    leaderdialog = globallogic_audio::get_round_switch_dialog( switchtype );
    setmatchtalkflag( "EveryoneHearsEveryone", 1 );
    players = level.players;
    
    for ( index = 0; index < players.size ; index++ )
    {
        player = players[ index ];
        
        if ( !isdefined( player.pers[ "team" ] ) )
        {
            player [[ level.spawnintermission ]]( 1 );
            continue;
        }
        
        player globallogic_audio::leader_dialog_on_player( leaderdialog );
        player thread [[ level.onteamoutcomenotify ]]( winner, switchtype, level.halftimesubcaption );
        player setclientuivisibilityflag( "hud_visible", 0 );
    }
    
    roundendwait( level.halftimeroundenddelay, 0 );
}

// Namespace globallogic/globallogic
// Params 2
// Checksum 0x87db7ef5, Offset: 0x77d0
// Size: 0x59c
function displaygameend( winner, endreasontext )
{
    setmatchtalkflag( "EveryoneHearsEveryone", 1 );
    setmatchflag( "cg_drawSpectatorMessages", 0 );
    level thread sndsetmatchsnapshot( 2 );
    util::setclientsysstate( "levelNotify", "streamFKsl" );
    
    if ( level.teambased )
    {
        if ( winner == "tie" )
        {
            demo::function_e2be394( "game_result", level.teamindex[ "neutral" ], level.teamindex[ "neutral" ] );
        }
        else
        {
            demo::function_e2be394( "game_result", level.teamindex[ winner ], level.teamindex[ "neutral" ] );
        }
    }
    
    players = level.players;
    
    for ( index = 0; index < players.size ; index++ )
    {
        player = players[ index ];
        
        if ( !isdefined( player.pers[ "team" ] ) )
        {
            player [[ level.spawnintermission ]]( 1 );
            continue;
        }
        
        if ( level.teambased )
        {
            player thread [[ level.onteamoutcomenotify ]]( winner, "gameend", endreasontext );
        }
        else
        {
            if ( !( isdefined( level.freerun ) && level.freerun ) )
            {
                player thread [[ level.onoutcomenotify ]]( winner, 0, endreasontext );
            }
            
            if ( isdefined( level.freerun ) && level.freerun )
            {
                player globallogic_audio::set_music_on_player( "mp_freerun_gameover" );
            }
            else if ( isdefined( winner ) && player == winner )
            {
                player globallogic_audio::set_music_on_player( "matchWin" );
            }
            else if ( !level.splitscreen )
            {
                player globallogic_audio::set_music_on_player( "matchLose" );
            }
        }
        
        player setclientuivisibilityflag( "hud_visible", 0 );
        player setclientuivisibilityflag( "g_compassShowEnemies", 0 );
    }
    
    thread globallogic_audio::announce_game_winner( winner );
    
    if ( level.teambased )
    {
        players = level.players;
        
        for ( index = 0; index < players.size ; index++ )
        {
            player = players[ index ];
            team = player.pers[ "team" ];
            
            if ( level.splitscreen )
            {
                if ( isdefined( level.freerun ) && level.freerun )
                {
                    player globallogic_audio::set_music_on_player( "mp_freerun_gameover" );
                }
                else if ( winner == "tie" )
                {
                    player globallogic_audio::set_music_on_player( "matchDraw" );
                }
                else if ( winner == team )
                {
                    player globallogic_audio::set_music_on_player( "matchWin" );
                }
                else
                {
                    player globallogic_audio::set_music_on_player( "matchLose" );
                }
                
                continue;
            }
            
            if ( isdefined( level.freerun ) && level.freerun )
            {
                player globallogic_audio::set_music_on_player( "mp_freerun_gameover" );
                continue;
            }
            
            if ( winner == "tie" )
            {
                player globallogic_audio::set_music_on_player( "matchDraw" );
                continue;
            }
            
            if ( winner == team )
            {
                player globallogic_audio::set_music_on_player( "matchWin" );
                continue;
            }
            
            player globallogic_audio::set_music_on_player( "matchLose" );
        }
    }
    
    bbprint( "global_session_epilogs", "reason %s", endreasontext );
    bbprint( "mpmatchfacts", "gametime %d winner %s killstreakcount %d", gettime(), winner, level.globalkillstreakscalled );
    roundendwait( level.postroundtime, 1 );
}

// Namespace globallogic/globallogic
// Params 1
// Checksum 0x1467e1f2, Offset: 0x7d78
// Size: 0x6e
function function_efd70c10( result )
{
    players = level.players;
    
    for ( index = 0; index < players.size ; index++ )
    {
        globallogic_player::function_c92849fa( players[ index ], result );
    }
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0x4ab05208, Offset: 0x7df0
// Size: 0x110
function getendreasontext()
{
    if ( isdefined( level.endreasontext ) )
    {
        return level.endreasontext;
    }
    
    if ( util::hitroundlimit() || util::hitroundwinlimit() )
    {
        return game.strings[ "round_limit_reached" ];
    }
    else if ( util::hitscorelimit() )
    {
        return game.strings[ "score_limit_reached" ];
    }
    else if ( util::hitroundscorelimit() )
    {
        return game.strings[ "round_score_limit_reached" ];
    }
    
    if ( level.forcedend )
    {
        if ( level.hostforcedend )
        {
            return &"MP_HOST_ENDED_GAME";
        }
        else
        {
            return &"MP_ENDED_GAME";
        }
    }
    
    return game.strings[ "time_limit_reached" ];
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0x71e7c61, Offset: 0x7f08
// Size: 0x6e
function resetoutcomeforallplayers()
{
    players = level.players;
    
    for ( index = 0; index < players.size ; index++ )
    {
        player = players[ index ];
        player notify( #"reset_outcome" );
    }
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0xacfa4e7f, Offset: 0x7f80
// Size: 0x7e
function function_eac9a653()
{
    players = level.players;
    
    for ( index = 0; index < players.size ; index++ )
    {
        player = players[ index ];
        player clientfield::set_player_uimodel( "hudItems.hideOutcomeUI", 1 );
    }
}

// Namespace globallogic/globallogic
// Params 2
// Checksum 0xd3ffc93, Offset: 0x8008
// Size: 0x35c, Type: bool
function function_26850b50( winner, endreasontext )
{
    if ( !util::isoneround() )
    {
        displayroundend( winner, endreasontext );
        globallogic_utils::executepostroundevents( winner, endreasontext );
        
        if ( !util::waslastround() )
        {
            if ( checkroundswitch() )
            {
                if ( level.scoreroundwinbased )
                {
                    foreach ( team in level.teams )
                    {
                        [[ level._setteamscore ]]( team, game.stat[ "roundswon" ][ team ] );
                    }
                }
                
                if ( !( isdefined( level.var_b2e6979d ) && level.var_b2e6979d ) )
                {
                    displayroundswitch( winner, endreasontext );
                }
            }
            
            if ( isdefined( level.nextroundisovertime ) && level.nextroundisovertime )
            {
                if ( !isdefined( game.overtime_round ) )
                {
                    game.overtime_round = 1;
                }
                else
                {
                    game.overtime_round++;
                }
            }
            
            setmatchtalkflag( "DeadChatWithDead", level.voip.deadchatwithdead );
            setmatchtalkflag( "DeadChatWithTeam", level.voip.deadchatwithteam );
            setmatchtalkflag( "DeadHearTeamLiving", level.voip.deadhearteamliving );
            setmatchtalkflag( "DeadHearAllLiving", level.voip.deadhearallliving );
            setmatchtalkflag( "EveryoneHearsEveryone", level.voip.everyonehearseveryone );
            setmatchtalkflag( "DeadHearKiller", level.voip.deadhearkiller );
            setmatchtalkflag( "KillersHearVictim", level.voip.killershearvictim );
            game.state = "playing";
            map_restart( 1 );
            function_eac9a653();
            return true;
        }
    }
    
    return false;
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0x42ce251e, Offset: 0x8370
// Size: 0x382
function function_fe2db310()
{
    if ( level.rankedmatch )
    {
        placement = level.placement[ "all" ];
        topthreeplayers = min( 3, placement.size );
        
        for ( index = 0; index < topthreeplayers ; index++ )
        {
            if ( level.placement[ "all" ][ index ].score )
            {
                if ( !index )
                {
                    level.placement[ "all" ][ index ] addplayerstatwithgametype( "TOPPLAYER", 1 );
                    level.placement[ "all" ][ index ] notify( #"topplayer" );
                }
                else
                {
                    level.placement[ "all" ][ index ] notify( #"hash_654bc6be" );
                }
                
                level.placement[ "all" ][ index ] addplayerstatwithgametype( "TOP3", 1 );
                level.placement[ "all" ][ index ] addplayerstat( "TOP3ANY", 1 );
                
                if ( level.hardcoremode )
                {
                    level.placement[ "all" ][ index ] addplayerstat( "TOP3ANY_HC", 1 );
                }
                
                if ( level.multiteam )
                {
                    level.placement[ "all" ][ index ] addplayerstat( "TOP3ANY_MULTITEAM", 1 );
                }
                
                level.placement[ "all" ][ index ] notify( #"top3" );
            }
        }
        
        for ( index = 3; index < placement.size ; index++ )
        {
            level.placement[ "all" ][ index ] notify( #"hash_1fc5ff08" );
            level.placement[ "all" ][ index ] notify( #"hash_654bc6be" );
        }
        
        if ( level.teambased )
        {
            foreach ( team in level.teams )
            {
                function_cc3ae2fc( team );
            }
        }
    }
}

// Namespace globallogic/globallogic
// Params 1
// Checksum 0x355465b8, Offset: 0x8700
// Size: 0x186
function function_cc3ae2fc( team )
{
    var_f43a8455 = level.placement[ team ];
    var_d73408dd = min( 3, var_f43a8455.size );
    
    if ( var_f43a8455.size < 5 )
    {
        return;
    }
    
    for ( index = 0; index < var_d73408dd ; index++ )
    {
        if ( var_f43a8455[ index ].score )
        {
            var_f43a8455[ index ] addplayerstat( "TOP3TEAM", 1 );
            var_f43a8455[ index ] addplayerstat( "TOP3ANY", 1 );
            
            if ( level.hardcoremode )
            {
                var_f43a8455[ index ] addplayerstat( "TOP3ANY_HC", 1 );
            }
            
            if ( level.multiteam )
            {
                var_f43a8455[ index ] addplayerstat( "TOP3ANY_MULTITEAM", 1 );
            }
            
            var_f43a8455[ index ] addplayerstatwithgametype( "TOP3TEAM", 1 );
        }
    }
}

// Namespace globallogic/globallogic
// Params 1
// Checksum 0x5545bc05, Offset: 0x8890
// Size: 0x68
function function_db16a372( winner )
{
    if ( !isdefined( winner ) )
    {
        return "tie";
    }
    
    if ( isentity( winner ) )
    {
        return ( isdefined( winner.team ) ? winner.team : "none" );
    }
    
    return winner;
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0x336aab82, Offset: 0x8900
// Size: 0x86
function getroundlength()
{
    if ( !level.timelimit || level.forcedend )
    {
        gamelength = globallogic_utils::gettimepassed() / 1000;
        gamelength = min( gamelength, 1200 );
    }
    else
    {
        gamelength = level.timelimit * 60;
    }
    
    return gamelength;
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0x80a43b08, Offset: 0x8990
// Size: 0x52c
function function_cbd5605a()
{
    if ( !getdvarint( "loot_enabled" ) )
    {
        return;
    }
    
    var_bd5aeea2 = game.playabletimepassed / 1000;
    timeplayed = self gettotaltimeplayed( var_bd5aeea2 );
    var_eddf01d9 = 0;
    
    if ( self.pers[ "participation" ] >= 1 )
    {
        var_ffe3ec55 = int( getdvarint( "loot_cryptokeyCost", 100 ) );
        var_b7c108f6 = int( getdvarint( "loot_earnTime", 267 ) );
        var_8a953dea = int( getdvarint( "loot_earnPlayThreshold", 10 ) );
        var_730f8a63 = int( getdvarint( "loot_earnMax", 10000 ) );
        var_f3830871 = int( getdvarint( "loot_earnMin", 0 ) );
        var_da64c2d4 = int( getdvarint( "loot_winBonusPercent", 30 ) );
        
        if ( var_bd5aeea2 > 0 && timeplayed > var_8a953dea )
        {
            if ( level.arenamatch )
            {
                draftenabled = getgametypesetting( "pregameDraftEnabled" ) == 1;
                voteenabled = getgametypesetting( "pregameItemVoteEnabled" ) == 1;
                
                if ( draftenabled && voteenabled )
                {
                    var_8e67772e = getdvarint( "arena_minPregameCryptoSeconds", 0 );
                    var_20ef98d0 = getdvarint( "arena_maxPregameCryptoSeconds", 0 );
                    
                    if ( var_20ef98d0 > 0 && var_8e67772e >= 0 && var_8e67772e <= var_20ef98d0 )
                    {
                        bonustime = randomintrange( var_8e67772e, var_20ef98d0 );
                        timeplayed += bonustime;
                    }
                }
            }
            
            lootxpscale = timeplayed / var_b7c108f6;
            var_eddf01d9 = var_ffe3ec55 * lootxpscale;
            
            if ( isdefined( self.lootxpmultiplier ) && self.lootxpmultiplier == 1 )
            {
                var_eddf01d9 += var_eddf01d9 * var_da64c2d4 / 100;
            }
            
            var_eddf01d9 *= math::clamp( getdvarfloat( "lootxp_multiplier", 1 ), 0, 4 );
            var_eddf01d9 = int( var_eddf01d9 );
            
            if ( var_eddf01d9 > var_730f8a63 )
            {
                var_eddf01d9 = var_730f8a63;
            }
            else if ( var_eddf01d9 < var_f3830871 )
            {
                var_eddf01d9 = var_f3830871;
            }
            
            var_8faf2ed5 = self awardotherlootxp();
            var_eddf01d9 += var_8faf2ed5;
            
            if ( var_eddf01d9 > 0 )
            {
                self reportlootreward( 1, var_eddf01d9 );
            }
            
            if ( var_8faf2ed5 > 0 )
            {
                level thread waitanduploadstats( self, getdvarfloat( "src_other_lootxp_uploadstat_waittime", 1 ) );
            }
        }
    }
    
    self setaarstat( "lootXpEarned", var_eddf01d9 );
    recordplayerstats( self, "lootXpEarned", var_eddf01d9 );
    recordplayerstats( self, "lootTimePlayed", timeplayed );
}

// Namespace globallogic/globallogic
// Params 2
// Checksum 0x21ab8813, Offset: 0x8ec8
// Size: 0x4c
function waitanduploadstats( player, waittime )
{
    wait waittime;
    
    if ( isplayer( player ) )
    {
        uploadstats( player );
    }
}

// Namespace globallogic/globallogic
// Params 1
// Checksum 0xc134bf62, Offset: 0x8f20
// Size: 0xb6
function registerotherlootxpawards( func )
{
    if ( !isdefined( level.awardotherlootxpfunctions ) )
    {
        level.awardotherlootxpfunctions = [];
    }
    
    if ( !isdefined( level.awardotherlootxpfunctions ) )
    {
        level.awardotherlootxpfunctions = [];
    }
    else if ( !isarray( level.awardotherlootxpfunctions ) )
    {
        level.awardotherlootxpfunctions = array( level.awardotherlootxpfunctions );
    }
    
    level.awardotherlootxpfunctions[ level.awardotherlootxpfunctions.size ] = func;
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0x3946c0a1, Offset: 0x8fe0
// Size: 0xf4
function awardotherlootxp()
{
    player = self;
    
    if ( !isdefined( level.awardotherlootxpfunctions ) )
    {
        return 0;
    }
    
    if ( !isplayer( player ) )
    {
        return 0;
    }
    
    lootxp = 0;
    
    foreach ( func in level.awardotherlootxpfunctions )
    {
        if ( !isdefined( func ) )
        {
            continue;
        }
        
        lootxp += player [[ func ]]();
    }
    
    return lootxp;
}

// Namespace globallogic/globallogic
// Params 2
// Checksum 0xa0d24250, Offset: 0x90e0
// Size: 0xcc4
function endgame( winner, endreasontext )
{
    if ( game.state == "postgame" || level.gameended )
    {
        return;
    }
    
    if ( isdefined( level.onendgame ) )
    {
        [[ level.onendgame ]]( winner );
    }
    
    if ( !isdefined( level.disableoutrovisionset ) || level.disableoutrovisionset == 0 )
    {
        visionsetnaked( "mpOutro", 2 );
    }
    
    setmatchflag( "cg_drawSpectatorMessages", 0 );
    setmatchflag( "game_ended", 1 );
    game.state = "postgame";
    level.gameendtime = gettime();
    level.gameended = 1;
    setdvar( "g_gameEnded", 1 );
    level.ingraceperiod = 0;
    level notify( #"game_ended" );
    level clientfield::set( "game_ended", 1 );
    globallogic_audio::flush_dialog();
    
    foreach ( team in level.teams )
    {
        game.lastroundscore[ team ] = getteamscore( team );
    }
    
    if ( util::isroundbased() )
    {
        matchrecordroundend();
    }
    
    winning_team = function_db16a372( winner );
    
    if ( isdefined( game.overtime_round ) && isdefined( game.stat[ "overtimeroundswon" ][ winning_team ] ) )
    {
        game.stat[ "overtimeroundswon" ][ winning_team ]++;
    }
    
    if ( !isdefined( game.overtime_round ) || util::waslastround() )
    {
        game.roundsplayed++;
        game.roundwinner[ game.roundsplayed ] = winner;
        
        if ( isdefined( game.stat[ "roundswon" ][ winning_team ] ) )
        {
            game.stat[ "roundswon" ][ winning_team ]++;
        }
    }
    
    if ( isdefined( winner ) && isdefined( level.teams[ winning_team ] ) )
    {
        level.finalkillcam_winner = winner;
    }
    else
    {
        level.finalkillcam_winner = "none";
    }
    
    level.finalkillcam_winnerpicked = 1;
    setgameendtime( 0 );
    updateplacement();
    updaterankedmatch( winner );
    players = level.players;
    newtime = gettime();
    roundlength = getroundlength();
    setmatchtalkflag( "EveryoneHearsEveryone", 1 );
    bbgameover = 0;
    
    if ( util::isoneround() || util::waslastround() )
    {
        bbgameover = 1;
    }
    
    surveyid = 0;
    
    if ( randomfloat( 1 ) <= getdvarfloat( "survey_chance" ) )
    {
        surveyid = randomintrange( 1, getdvarint( "survey_count" ) + 1 );
    }
    
    for ( index = 0; index < players.size ; index++ )
    {
        player = players[ index ];
        player globallogic_player::freezeplayerforroundend();
        player thread roundenddof( 4 );
        player globallogic_ui::freegameplayhudelems();
        player.pers[ "lastroundscore" ] = player.pointstowin;
        player weapons::update_timings( newtime );
        
        if ( bbgameover )
        {
            player behaviortracker::finalize();
        }
        
        player bbplayermatchend( roundlength, endreasontext, bbgameover );
        player.pers[ "totalTimePlayed" ] = player.pers[ "totalTimePlayed" ] + player.timeplayed[ "total" ];
        
        if ( bbgameover )
        {
            if ( level.leaguematch )
            {
                player setaarstat( "lobbyPopup", "leaguesummary" );
            }
            else
            {
                player setaarstat( "lobbyPopup", "summary" );
            }
        }
        
        player setaarstat( "surveyId", surveyid );
        player setaarstat( "hardcore", level.hardcoremode );
    }
    
    if ( level.infinalkillcam )
    {
    }
    
    gamerep::gamerepupdateinformationforround();
    thread challenges::roundend( winner );
    game_winner = winner;
    
    if ( !util::isoneround() )
    {
        game_winner = [[ level.determinewinner ]]( winner );
    }
    
    function_2887d110( game_winner );
    
    if ( function_26850b50( winner, endreasontext ) )
    {
        return;
    }
    
    if ( !util::isoneround() )
    {
        if ( isdefined( level.onroundendgame ) )
        {
            winner = [[ level.onroundendgame ]]( winner );
        }
        
        endreasontext = getendreasontext();
    }
    
    globallogic_score::updatewinlossstats( winner );
    
    if ( level.rankedmatch || level.arenamatch )
    {
        thread function_db2dd5c9( 3, players );
    }
    
    if ( level.arenamatch )
    {
        arena::match_end( winner );
    }
    
    result = "";
    
    if ( level.teambased )
    {
        if ( winner == "tie" )
        {
            result = "draw";
        }
        else
        {
            result = winner;
        }
    }
    else if ( !isdefined( winner ) )
    {
        result = "draw";
    }
    else
    {
        result = winner.team;
    }
    
    recordgameresult( result );
    players = level.players;
    
    for ( index = 0; index < players.size ; index++ )
    {
        player = players[ index ];
        player globallogic_player::record_misc_player_stats();
    }
    
    skillupdate( winner, level.teambased );
    function_fe2db310();
    thread challenges::gameend( winner );
    updateandfinalizematchrecord();
    stopdemorecording();
    function_efd70c10( result );
    level.finalgameend = 1;
    
    if ( !isdefined( level.skipgameend ) || !level.skipgameend )
    {
        displaygameend( winner, endreasontext );
    }
    
    level.finalgameend = undefined;
    
    if ( util::isoneround() )
    {
        globallogic_utils::executepostroundevents();
    }
    
    level.intermission = 1;
    gamerep::gamerepanalyzeandreport();
    util::setclientsysstate( "levelNotify", "fkcs" );
    
    if ( persistence::function_d1b7628a() )
    {
        thread sendafteractionreport();
    }
    
    setmatchtalkflag( "EveryoneHearsEveryone", 1 );
    players = level.players;
    
    for ( index = 0; index < players.size ; index++ )
    {
        player = players[ index ];
        player notify( #"reset_outcome" );
        player thread [[ level.spawnintermission ]]( 0, level.usexcamsforendgame );
        player setclientuivisibilityflag( "hud_visible", 1 );
    }
    
    level clientfield::set( "post_game", 1 );
    function_c33296a0();
    
    if ( isdefined( level.var_a59e087e ) )
    {
        level thread [[ level.var_a59e087e ]]();
    }
    
    level notify( #"sfade" );
    
    /#
        print( "<dev string:xb0>" );
    #/
    
    if ( !isdefined( level.skipgameend ) || !level.skipgameend )
    {
        wait 5;
    }
    
    if ( isdefined( level.end_game_video ) )
    {
        level thread lui::play_movie( level.end_game_video.name, "fullscreen", 1 );
        wait level.end_game_video.duration + 4.5;
    }
    
    exit_level();
}

// Namespace globallogic/globallogic
// Params 2
// Checksum 0x6060934c, Offset: 0x9db0
// Size: 0xaa
function function_db2dd5c9( delay, players )
{
    wait delay;
    
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player function_cbd5605a();
    }
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0xba62ed43, Offset: 0x9e68
// Size: 0x3c
function exit_level()
{
    if ( level.exitlevel )
    {
        return;
    }
    
    level.exitlevel = 1;
    exitlevel( 0 );
}

// Namespace globallogic/globallogic
// Params 1
// Checksum 0xe962ca8b, Offset: 0x9eb0
// Size: 0x2b6
function function_2887d110( winner )
{
    topscorers = [];
    winning_team = function_db16a372( winner );
    
    if ( level.teambased && isdefined( winner ) && isdefined( level.placement[ winning_team ] ) )
    {
        topscorers = level.placement[ winning_team ];
    }
    else
    {
        topscorers = level.placement[ "all" ];
    }
    
    if ( topscorers.size )
    {
        level.var_62e3c90e = 1;
    }
    else
    {
        level.var_62e3c90e = 0;
    }
    
    cleartopscorers();
    
    for ( i = 0; i < 3 && i < topscorers.size ; i++ )
    {
        player = topscorers[ i ];
        player thread function_4d13985c( i );
        showcase_weapon = player weapons::showcaseweapon_get();
        tauntindex = player getplayerselectedtaunt( 0 );
        var_9c447b0a = player getplayerselectedgesture( 0 );
        var_5a633109 = player getplayerselectedgesture( 1 );
        var_2ead7a10 = player getplayerselectedgesture( 2 );
        
        if ( !isdefined( showcase_weapon ) )
        {
            settopscorer( i, player, tauntindex, var_9c447b0a, var_5a633109, var_2ead7a10, getweapon( "ar_standard" ) );
            continue;
        }
        
        settopscorer( i, player, tauntindex, var_9c447b0a, var_5a633109, var_2ead7a10, showcase_weapon[ "weapon" ], showcase_weapon[ "options" ], showcase_weapon[ "acvi" ] );
    }
}

// Namespace globallogic/globallogic
// Params 1
// Checksum 0x48e80ca6, Offset: 0xa170
// Size: 0x116
function function_4d13985c( var_c55b8047 )
{
    self endon( #"disconnect" );
    fieldname = "playTop" + var_c55b8047 + "Gesture";
    level clientfield::set( fieldname, 7 );
    waitframe( 1 );
    
    while ( true )
    {
        if ( self actionslotonebuttonpressed() )
        {
            self function_af10dfb7( fieldname, 0 );
        }
        else if ( self actionslotthreebuttonpressed() )
        {
            self function_af10dfb7( fieldname, 1 );
        }
        else if ( self actionslotfourbuttonpressed() )
        {
            self function_af10dfb7( fieldname, 2 );
        }
        
        waitframe( 1 );
    }
}

// Namespace globallogic/globallogic
// Params 2
// Checksum 0x9f7ddc01, Offset: 0xa290
// Size: 0x74
function function_af10dfb7( fieldname, gesturetype )
{
    self notify( #"hash_af10dfb7" );
    self endon( #"hash_af10dfb7" );
    level clientfield::set( fieldname, gesturetype );
    waitframe( 1 );
    level clientfield::set( fieldname, 7 );
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0x2a946ee, Offset: 0xa310
// Size: 0x1cc
function function_c33296a0()
{
    level notify( #"endgame_sequence" );
    var_217bfdf = getdvarint( "sv_mapSwitchPreloadFrontend", 0 );
    
    if ( level.var_62e3c90e && isdefined( struct::get( "endgame_top_players_struct", "targetname" ) ) )
    {
        setmatchflag( "enable_popups", 1 );
        clearplayercorpses();
        level thread sndsetmatchsnapshot( 3 );
        level thread globallogic_audio::set_music_global( "endmatch" );
        level clientfield::set( "displayTop3Players", 1 );
        
        if ( var_217bfdf )
        {
            switchmap_preload( "core_frontend" );
        }
        
        /#
            while ( getdvarint( "<dev string:xbb>", 0 ) )
            {
                waitframe( 1 );
            }
        #/
        
        wait 15;
        level clientfield::set( "triggerScoreboardCamera", 1 );
        wait 5;
        setmatchflag( "enable_popups", 0 );
        return;
    }
    
    if ( level.doendgamescoreboard )
    {
        if ( var_217bfdf )
        {
            switchmap_preload( "core_frontend" );
        }
        
        luinotifyevent( &"force_scoreboard", 0 );
    }
}

// Namespace globallogic/globallogic
// Params 1
// Checksum 0x16a4a54, Offset: 0xa4e8
// Size: 0x66
function gettotaltimeplayed( maxlength )
{
    totaltimeplayed = 0;
    
    if ( isdefined( self.pers[ "totalTimePlayed" ] ) )
    {
        totaltimeplayed = self.pers[ "totalTimePlayed" ];
        
        if ( totaltimeplayed > maxlength )
        {
            totaltimeplayed = maxlength;
        }
    }
    
    return totaltimeplayed;
}

// Namespace globallogic/globallogic
// Params 1
// Checksum 0x1c72b4d1, Offset: 0xa558
// Size: 0x76
function getroundtimeplayed( roundlength )
{
    totaltimeplayed = 0;
    
    if ( isdefined( self.timeplayed ) && isdefined( self.timeplayed[ "total" ] ) )
    {
        totaltimeplayed = self.timeplayed[ "total" ];
        
        if ( totaltimeplayed > roundlength )
        {
            totaltimeplayed = roundlength;
        }
    }
    
    return totaltimeplayed;
}

// Namespace globallogic/globallogic
// Params 3
// Checksum 0x3da20748, Offset: 0xa5d8
// Size: 0xec
function bbplayermatchend( gamelength, endreasonstring, gameover )
{
    playerrank = getplacementforplayer( self );
    totaltimeplayed = self getroundtimeplayed( gamelength );
    xuid = self getxuid();
    bbprint( "mpplayermatchfacts", "score %d momentum %d endreason %s sessionrank %d playtime %d xuid %s gameover %d team %s", self.pers[ "score" ], self.pers[ "momentum" ], endreasonstring, playerrank, totaltimeplayed, xuid, gameover, self.pers[ "team" ] );
}

// Namespace globallogic/globallogic
// Params 2
// Checksum 0x70eec633, Offset: 0xa6d0
// Size: 0x1b8
function roundendwait( defaultdelay, matchbonus )
{
    notifiesdone = 0;
    
    while ( !notifiesdone )
    {
        players = level.players;
        notifiesdone = 1;
        
        for ( index = 0; index < players.size ; index++ )
        {
            if ( !isdefined( players[ index ].var_decbf609 ) || !players[ index ].var_decbf609 )
            {
                continue;
            }
            
            notifiesdone = 0;
        }
        
        wait 0.5;
    }
    
    if ( !matchbonus )
    {
        wait defaultdelay;
        level notify( #"round_end_done" );
        return;
    }
    
    wait defaultdelay / 2;
    level notify( #"give_match_bonus" );
    wait defaultdelay / 2;
    notifiesdone = 0;
    
    while ( !notifiesdone )
    {
        players = level.players;
        notifiesdone = 1;
        
        for ( index = 0; index < players.size ; index++ )
        {
            if ( !isdefined( players[ index ].var_decbf609 ) || !players[ index ].var_decbf609 )
            {
                continue;
            }
            
            notifiesdone = 0;
        }
        
        wait 0.5;
    }
    
    level notify( #"round_end_done" );
}

// Namespace globallogic/globallogic
// Params 1
// Checksum 0x7302821c, Offset: 0xa890
// Size: 0x3c
function roundenddof( time )
{
    self setdepthoffield( 0, 128, 512, 4000, 6, 1.8 );
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0x7c25aa30, Offset: 0xa8d8
// Size: 0x1c4
function checktimelimit()
{
    if ( isdefined( level.timelimitoverride ) && level.timelimitoverride )
    {
        return;
    }
    
    if ( game.state != "playing" )
    {
        setgameendtime( 0 );
        return;
    }
    
    if ( level.timelimit <= 0 )
    {
        setgameendtime( 0 );
        return;
    }
    
    if ( level.inprematchperiod )
    {
        setgameendtime( 0 );
        return;
    }
    
    if ( isdefined( level.timerpaused ) && level.timerpaused )
    {
        timeremaining = globallogic_utils::gettimeremaining();
        setgameendtime( int( timeremaining ) * -1 );
        return;
    }
    
    if ( level.timerstopped )
    {
        setgameendtime( 0 );
        return;
    }
    
    if ( !isdefined( level.starttime ) )
    {
        return;
    }
    
    timeleft = globallogic_utils::gettimeremaining();
    setgameendtime( gettime() + int( timeleft ) );
    
    if ( timeleft > 0 )
    {
        return;
    }
    
    [[ level.ontimelimit ]]();
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0xfc3111f8, Offset: 0xaaa8
// Size: 0xb4
function checkscorelimit()
{
    if ( game.state != "playing" )
    {
        return 0;
    }
    
    if ( level.scorelimit <= 0 )
    {
        return 0;
    }
    
    if ( level.teambased )
    {
        if ( !util::any_team_hit_score_limit() )
        {
            return 0;
        }
    }
    else
    {
        if ( !isplayer( self ) )
        {
            return 0;
        }
        
        if ( self.pointstowin < level.scorelimit )
        {
            return 0;
        }
    }
    
    [[ level.onscorelimit ]]();
}

// Namespace globallogic/globallogic
// Params 1
// Checksum 0x1f11b353, Offset: 0xab68
// Size: 0x84
function checksuddendeathscorelimit( team )
{
    if ( game.state != "playing" )
    {
        return 0;
    }
    
    if ( level.roundscorelimit <= 0 )
    {
        return 0;
    }
    
    if ( level.teambased )
    {
        if ( !game.teamsuddendeath[ team ] )
        {
            return 0;
        }
    }
    else
    {
        return 0;
    }
    
    [[ level.onscorelimit ]]();
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0xd2499c15, Offset: 0xabf8
// Size: 0xcc
function checkroundscorelimit()
{
    if ( game.state != "playing" )
    {
        return 0;
    }
    
    if ( level.roundscorelimit <= 0 )
    {
        return 0;
    }
    
    if ( level.teambased )
    {
        if ( !util::any_team_hit_round_score_limit() )
        {
            return 0;
        }
    }
    else
    {
        if ( !isplayer( self ) )
        {
            return 0;
        }
        
        roundscorelimit = util::get_current_round_score_limit();
        
        if ( self.pointstowin < roundscorelimit )
        {
            return 0;
        }
    }
    
    [[ level.onroundscorelimit ]]();
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0x3a9a99f6, Offset: 0xacd0
// Size: 0x2bc
function updategametypedvars()
{
    level endon( #"game_ended" );
    
    while ( game.state == "playing" )
    {
        roundlimit = math::clamp( getgametypesetting( "roundLimit" ), level.roundlimitmin, level.roundlimitmax );
        
        if ( roundlimit != level.roundlimit )
        {
            level.roundlimit = roundlimit;
            level notify( #"update_roundlimit" );
        }
        
        timelimit = [[ level.gettimelimit ]]();
        
        if ( timelimit != level.timelimit )
        {
            level.timelimit = timelimit;
            setdvar( "ui_timelimit", level.timelimit );
            level notify( #"update_timelimit" );
        }
        
        thread checktimelimit();
        scorelimit = math::clamp( getgametypesetting( "scoreLimit" ), level.scorelimitmin, level.scorelimitmax );
        
        if ( scorelimit != level.scorelimit )
        {
            level.scorelimit = scorelimit;
            setdvar( "ui_scorelimit", level.scorelimit );
            level notify( #"update_scorelimit" );
        }
        
        thread checkscorelimit();
        roundscorelimit = math::clamp( getgametypesetting( "roundScoreLimit" ), level.roundscorelimitmin, level.roundscorelimitmax );
        
        if ( roundscorelimit != level.roundscorelimit )
        {
            level.roundscorelimit = roundscorelimit;
            level notify( #"hash_367397c0" );
        }
        
        thread checkroundscorelimit();
        
        if ( isdefined( level.starttime ) )
        {
            if ( globallogic_utils::gettimeremaining() < 30000 )
            {
                wait 0.1;
                continue;
            }
        }
        
        wait 0.25;
    }
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0xe809e08e, Offset: 0xaf98
// Size: 0x1fa
function removedisconnectedplayerfromplacement()
{
    offset = 0;
    numplayers = level.placement[ "all" ].size;
    found = 0;
    
    for ( i = 0; i < numplayers ; i++ )
    {
        if ( level.placement[ "all" ][ i ] == self )
        {
            found = 1;
        }
        
        if ( found )
        {
            level.placement[ "all" ][ i ] = level.placement[ "all" ][ i + 1 ];
        }
    }
    
    if ( !found )
    {
        return;
    }
    
    level.placement[ "all" ][ numplayers - 1 ] = undefined;
    assert( level.placement[ "<dev string:xce>" ].size == numplayers - 1 );
    
    /#
        globallogic_utils::assertproperplacement();
    #/
    
    updateteamplacement();
    
    if ( level.teambased )
    {
        return;
    }
    
    numplayers = level.placement[ "all" ].size;
    
    for ( i = 0; i < numplayers ; i++ )
    {
        player = level.placement[ "all" ][ i ];
        player notify( #"update_outcome" );
    }
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0xf28c7e56, Offset: 0xb1a0
// Size: 0x40c
function updateplacement()
{
    if ( !level.players.size )
    {
        return;
    }
    
    level.placement[ "all" ] = [];
    
    foreach ( player in level.players )
    {
        if ( !level.teambased || isdefined( level.teams[ player.team ] ) )
        {
            level.placement[ "all" ][ level.placement[ "all" ].size ] = player;
        }
    }
    
    placementall = level.placement[ "all" ];
    
    if ( level.teambased )
    {
        for ( i = 1; i < placementall.size ; i++ )
        {
            player = placementall[ i ];
            playerscore = player.score;
            
            for ( j = i - 1; playerscore == placementall[ j ].score && ( playerscore > placementall[ j ].score || j >= 0 && player.deaths < placementall[ j ].deaths ) ; j-- )
            {
                placementall[ j + 1 ] = placementall[ j ];
            }
            
            placementall[ j + 1 ] = player;
        }
    }
    else
    {
        for ( i = 1; i < placementall.size ; i++ )
        {
            player = placementall[ i ];
            playerscore = player.pointstowin;
            
            for ( j = i - 1; playerscore == placementall[ j ].pointstowin && player.deaths == placementall[ j ].deaths && ( playerscore == placementall[ j ].pointstowin && ( playerscore > placementall[ j ].pointstowin || player.deaths < placementall[ j ].deaths ) || j >= 0 && player.lastkilltime > placementall[ j ].lastkilltime ) ; j-- )
            {
                placementall[ j + 1 ] = placementall[ j ];
            }
            
            placementall[ j + 1 ] = player;
        }
    }
    
    level.placement[ "all" ] = placementall;
    
    /#
        globallogic_utils::assertproperplacement();
    #/
    
    updateteamplacement();
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0xf66f5d61, Offset: 0xb5b8
// Size: 0x1e8
function updateteamplacement()
{
    foreach ( team in level.teams )
    {
        placement[ team ] = [];
    }
    
    placement[ "spectator" ] = [];
    
    if ( !level.teambased )
    {
        return;
    }
    
    placementall = level.placement[ "all" ];
    placementallsize = placementall.size;
    
    for ( i = 0; i < placementallsize ; i++ )
    {
        player = placementall[ i ];
        team = player.pers[ "team" ];
        placement[ team ][ placement[ team ].size ] = player;
    }
    
    foreach ( team in level.teams )
    {
        level.placement[ team ] = placement[ team ];
    }
}

// Namespace globallogic/globallogic
// Params 1
// Checksum 0xc207caa7, Offset: 0xb7a8
// Size: 0xba
function getplacementforplayer( player )
{
    updateplacement();
    playerrank = -1;
    placement = level.placement[ "all" ];
    
    for ( placementindex = 0; placementindex < placement.size ; placementindex++ )
    {
        if ( level.placement[ "all" ][ placementindex ] == player )
        {
            playerrank = placementindex + 1;
            break;
        }
    }
    
    return playerrank;
}

// Namespace globallogic/globallogic
// Params 1
// Checksum 0xa38a60c1, Offset: 0xb870
// Size: 0x27c
function istopscoringplayer( player )
{
    topscoringplayer = 0;
    updateplacement();
    assert( level.placement[ "<dev string:xce>" ].size > 0 );
    
    if ( level.placement[ "all" ].size == 0 )
    {
        return 0;
    }
    
    if ( level.teambased )
    {
        topscore = level.placement[ "all" ][ 0 ].score;
        
        for ( index = 0; index < level.placement[ "all" ].size ; index++ )
        {
            if ( level.placement[ "all" ][ index ].score == 0 )
            {
                break;
            }
            
            if ( topscore > level.placement[ "all" ][ index ].score )
            {
                break;
            }
            
            if ( player == level.placement[ "all" ][ index ] )
            {
                topscoringplayer = 1;
                break;
            }
        }
    }
    else
    {
        topscore = level.placement[ "all" ][ 0 ].pointstowin;
        
        for ( index = 0; index < level.placement[ "all" ].size ; index++ )
        {
            if ( level.placement[ "all" ][ index ].pointstowin == 0 )
            {
                break;
            }
            
            if ( topscore > level.placement[ "all" ][ index ].pointstowin )
            {
                break;
            }
            
            if ( player == level.placement[ "all" ][ index ] )
            {
                topscoringplayer = 1;
                break;
            }
        }
    }
    
    return topscoringplayer;
}

// Namespace globallogic/globallogic
// Params 1
// Checksum 0x666395b8, Offset: 0xbaf8
// Size: 0x1c6
function sortdeadplayers( team )
{
    if ( !level.playerqueuedrespawn )
    {
        return;
    }
    
    for ( i = 1; i < level.deadplayers[ team ].size ; i++ )
    {
        player = level.deadplayers[ team ][ i ];
        
        for ( j = i - 1; j >= 0 && player.deathtime < level.deadplayers[ team ][ j ].deathtime ; j-- )
        {
            level.deadplayers[ team ][ j + 1 ] = level.deadplayers[ team ][ j ];
        }
        
        level.deadplayers[ team ][ j + 1 ] = player;
    }
    
    for ( i = 0; i < level.deadplayers[ team ].size ; i++ )
    {
        if ( level.deadplayers[ team ][ i ].spawnqueueindex != i )
        {
            level.spawnqueuemodified[ team ] = 1;
        }
        
        level.deadplayers[ team ][ i ].spawnqueueindex = i;
    }
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0x5e6e8652, Offset: 0xbcc8
// Size: 0xaa
function totalalivecount()
{
    count = 0;
    
    foreach ( team in level.teams )
    {
        count += level.alivecount[ team ];
    }
    
    return count;
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0x68db086f, Offset: 0xbd80
// Size: 0xaa
function totalplayerlives()
{
    count = 0;
    
    foreach ( team in level.teams )
    {
        count += level.playerlives[ team ];
    }
    
    return count;
}

// Namespace globallogic/globallogic
// Params 1
// Checksum 0xc09a898c, Offset: 0xbe38
// Size: 0x10c
function initteamvariables( team )
{
    if ( !isdefined( level.alivecount ) )
    {
        level.alivecount = [];
    }
    
    level.alivecount[ team ] = 0;
    level.lastalivecount[ team ] = 0;
    
    if ( !isdefined( game.everexisted ) )
    {
        game.everexisted = [];
    }
    
    if ( !isdefined( game.everexisted[ team ] ) )
    {
        game.everexisted[ team ] = 0;
    }
    
    level.everexisted[ team ] = 0;
    level.wavedelay[ team ] = 0;
    level.lastwave[ team ] = 0;
    level.waveplayerspawnindex[ team ] = 0;
    resetteamvariables( team );
}

// Namespace globallogic/globallogic
// Params 1
// Checksum 0xb9861dbd, Offset: 0xbf50
// Size: 0xe6
function resetteamvariables( team )
{
    level.playercount[ team ] = 0;
    level.botscount[ team ] = 0;
    level.lastalivecount[ team ] = level.alivecount[ team ];
    level.alivecount[ team ] = 0;
    level.playerlives[ team ] = 0;
    level.aliveplayers[ team ] = [];
    level.spawningplayers[ team ] = [];
    level.deadplayers[ team ] = [];
    level.squads[ team ] = [];
    level.spawnqueuemodified[ team ] = 0;
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0xf6208ac3, Offset: 0xc040
// Size: 0x584
function updateteamstatus()
{
    level notify( #"updating_team_status" );
    level endon( #"updating_team_status" );
    level endon( #"game_ended" );
    waittillframeend();
    wait 0;
    
    if ( game.state == "postgame" )
    {
        return;
    }
    
    resettimeout();
    
    foreach ( team in level.teams )
    {
        resetteamvariables( team );
    }
    
    if ( !level.teambased )
    {
        resetteamvariables( "free" );
    }
    
    level.activeplayers = [];
    players = level.players;
    
    for ( i = 0; i < players.size ; i++ )
    {
        player = players[ i ];
        
        if ( !isdefined( player ) && level.splitscreen )
        {
            continue;
        }
        
        if ( level.teambased || player.team == "spectator" )
        {
            team = player.team;
        }
        else
        {
            team = "free";
        }
        
        playerclass = player.curclass;
        
        if ( isdefined( playerclass ) && team != "spectator" && playerclass != "" )
        {
            level.playercount[ team ]++;
            
            if ( player isbot() )
            {
                level.botscount[ team ]++;
            }
            
            not_quite_dead = 0;
            
            if ( isdefined( player.overrideplayerdeadstatus ) )
            {
                not_quite_dead = player [[ player.overrideplayerdeadstatus ]]();
            }
            
            if ( player.sessionstate == "playing" )
            {
                level.alivecount[ team ]++;
                level.playerlives[ team ]++;
                player.spawnqueueindex = -1;
                
                if ( isalive( player ) )
                {
                    level.aliveplayers[ team ][ level.aliveplayers[ team ].size ] = player;
                    level.activeplayers[ level.activeplayers.size ] = player;
                }
                else
                {
                    level.deadplayers[ team ][ level.deadplayers[ team ].size ] = player;
                }
                
                continue;
            }
            
            if ( not_quite_dead )
            {
                level.alivecount[ team ]++;
                level.playerlives[ team ]++;
                level.aliveplayers[ team ][ level.aliveplayers[ team ].size ] = player;
                continue;
            }
            
            level.deadplayers[ team ][ level.deadplayers[ team ].size ] = player;
            
            if ( player globallogic_spawn::mayspawn() )
            {
                level.playerlives[ team ]++;
            }
        }
    }
    
    totalalive = totalalivecount();
    
    if ( totalalive > level.maxplayercount )
    {
        level.maxplayercount = totalalive;
    }
    
    foreach ( team in level.teams )
    {
        if ( level.alivecount[ team ] )
        {
            game.everexisted[ team ] = 1;
            level.everexisted[ team ] = 1;
        }
        
        sortdeadplayers( team );
    }
    
    level updategameevents();
}

// Namespace globallogic/globallogic
// Params 1
// Checksum 0x7d226ad2, Offset: 0xc5d0
// Size: 0x3dc
function updatealivetimes( team )
{
    level.alivetimesaverage[ team ] = 0;
    
    if ( game.state == "postgame" )
    {
        return;
    }
    
    total_player_count = 0;
    average_player_spawn_time = 0;
    total_value_count = 0;
    
    foreach ( player in level.aliveplayers[ team ] )
    {
        average_time = 0;
        count = 0;
        
        foreach ( time in player.alivetimes )
        {
            if ( time != 0 )
            {
                average_time += time;
                count++;
            }
        }
        
        if ( count )
        {
            total_value_count += count;
            average_player_spawn_time += average_time / count;
            total_player_count++;
        }
    }
    
    foreach ( player in level.deadplayers[ team ] )
    {
        average_time = 0;
        count = 0;
        
        foreach ( time in player.alivetimes )
        {
            if ( time != 0 )
            {
                average_time += time;
                count++;
            }
        }
        
        if ( count )
        {
            total_value_count += count;
            average_player_spawn_time += average_time / count;
            total_player_count++;
        }
    }
    
    if ( total_player_count == 0 || total_value_count < 3 )
    {
        level.alivetimesaverage[ team ] = 0;
        return;
    }
    
    level.alivetimesaverage[ team ] = average_player_spawn_time / total_player_count;
    
    /#
        if ( getdvarint( "<dev string:xd2>" ) )
        {
            iprintln( "<dev string:xe4>" + level.alivetimesaverage[ "<dev string:xfa>" ] + "<dev string:x101>" + level.alivetimesaverage[ "<dev string:x109>" ] );
        }
    #/
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0x576655ba, Offset: 0xc9b8
// Size: 0x92
function updateallalivetimes()
{
    foreach ( team in level.teams )
    {
        updatealivetimes( team );
    }
}

// Namespace globallogic/globallogic
// Params 1
// Checksum 0x3c06a8d3, Offset: 0xca58
// Size: 0xc8
function checkteamscorelimitsoon( team )
{
    assert( isdefined( team ) );
    
    if ( level.scorelimit <= 0 )
    {
        return;
    }
    
    if ( !level.teambased )
    {
        return;
    }
    
    if ( globallogic_utils::gettimepassed() < 60000 )
    {
        return;
    }
    
    timeleft = globallogic_utils::getestimatedtimeuntilscorelimit( team );
    
    if ( timeleft < 1 )
    {
        level notify( #"match_ending_soon", { #event:"score" } );
    }
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0x62eb36f6, Offset: 0xcb28
// Size: 0xc0
function checkplayerscorelimitsoon()
{
    assert( isplayer( self ) );
    
    if ( level.scorelimit <= 0 )
    {
        return;
    }
    
    if ( level.teambased )
    {
        return;
    }
    
    if ( globallogic_utils::gettimepassed() < 60000 )
    {
        return;
    }
    
    timeleft = globallogic_utils::getestimatedtimeuntilscorelimit( undefined );
    
    if ( timeleft < 1 )
    {
        level notify( #"match_ending_soon", { #event:"score" } );
    }
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0x4f51e42, Offset: 0xcbf0
// Size: 0x418
function timelimitclock()
{
    level endon( #"game_ended" );
    waitframe( 1 );
    clockobject = spawn( "script_origin", ( 0, 0, 0 ) );
    
    while ( game.state == "playing" )
    {
        using_tickets_as_time = level.timelimit == 0 && isdefined( level.low_tickets_enabled ) && isdefined( level.get_tickets_as_time );
        
        if ( level.timelimit || !level.timerstopped && level.low_ticket_count === 1 )
        {
            if ( using_tickets_as_time )
            {
                timeleftint = [[ level.get_tickets_as_time ]]();
            }
            else
            {
                timeleft = globallogic_utils::gettimeremaining() / 1000;
                timeleftint = int( timeleft + 0.5 );
            }
            
            if ( timeleftint == 601 )
            {
                util::clientnotify( "notify_10" );
            }
            
            if ( timeleftint == 301 )
            {
                util::clientnotify( "notify_5" );
            }
            
            if ( timeleftint == 60 )
            {
                util::clientnotify( "notify_1" );
            }
            
            if ( timeleftint == 12 )
            {
                util::clientnotify( "notify_count" );
            }
            
            if ( timeleftint >= 40 && timeleftint <= 60 )
            {
                level notify( #"match_ending_soon", "time" );
            }
            
            if ( timeleftint >= 30 && timeleftint <= 40 )
            {
                level notify( #"match_ending_pretty_soon", "time" );
            }
            
            if ( timeleftint <= 32 )
            {
                level notify( #"match_ending_vox" );
            }
            
            if ( level.low_ticket_count === 1 && ( timeleftint <= 30 && ( timeleftint <= 10 || timeleftint % 2 == 0 ) || timeleftint % 2 == 0 ) || level.very_low_ticket_count === 1 )
            {
                level notify( #"match_ending_very_soon", "time" );
                
                if ( timeleftint == 0 )
                {
                    break;
                }
                
                clockobject playsound( "mpl_ui_timer_countdown" );
            }
            
            if ( !using_tickets_as_time )
            {
                if ( timeleft - floor( timeleft ) >= 0.05 )
                {
                    wait timeleft - floor( timeleft );
                }
            }
        }
        
        if ( using_tickets_as_time && !level.timerstopped )
        {
            timeleftint = [[ level.get_tickets_as_time ]]();
            
            if ( timeleftint <= 0 )
            {
                wait 1;
            }
            else
            {
                oldtimeleftint = timeleftint;
                
                while ( !level.timerstopped && oldtimeleftint == timeleftint && timeleftint > 0 )
                {
                    waitframe( 1 );
                    timeleftint = [[ level.get_tickets_as_time ]]();
                }
            }
            
            continue;
        }
        
        wait 1;
    }
}

// Namespace globallogic/globallogic
// Params 1
// Checksum 0x67759b2a, Offset: 0xd010
// Size: 0xb0
function timelimitclock_intermission( waittime )
{
    setgameendtime( gettime() + int( waittime * 1000 ) );
    clockobject = spawn( "script_origin", ( 0, 0, 0 ) );
    
    if ( waittime >= 10 )
    {
        wait waittime - 10;
    }
    
    for ( ;; )
    {
        clockobject playsound( "mpl_ui_timer_countdown" );
        wait 1;
    }
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0x770e1ee, Offset: 0xd0c8
// Size: 0xbc
function recordbreadcrumbdata()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        for ( i = 0; i < level.players.size ; i++ )
        {
            player = level.players[ i ];
            
            if ( isalive( player ) )
            {
                recordbreadcrumbdataforplayer( player, player.lastshotby );
            }
        }
        
        wait 2;
    }
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0x7fee360, Offset: 0xd190
// Size: 0x304
function startgame()
{
    thread globallogic_utils::gametimer();
    level.timerstopped = 0;
    level.playabletimerstopped = 0;
    setmatchtalkflag( "DeadChatWithDead", level.voip.deadchatwithdead );
    setmatchtalkflag( "DeadChatWithTeam", level.voip.deadchatwithteam );
    setmatchtalkflag( "DeadHearTeamLiving", level.voip.deadhearteamliving );
    setmatchtalkflag( "DeadHearAllLiving", level.voip.deadhearallliving );
    setmatchtalkflag( "EveryoneHearsEveryone", level.voip.everyonehearseveryone );
    setmatchtalkflag( "DeadHearKiller", level.voip.deadhearkiller );
    setmatchtalkflag( "KillersHearVictim", level.voip.killershearvictim );
    cleartopscorers();
    
    if ( isdefined( level.custom_prematch_period ) )
    {
        [[ level.custom_prematch_period ]]();
    }
    else
    {
        prematchperiod();
    }
    
    level notify( #"prematch_over" );
    level.prematch_over = 1;
    level clientfield::set( "gameplay_started", 1 );
    thread function_ef3ff29e();
    thread timelimitclock();
    thread graceperiod();
    thread watchmatchendingsoon();
    thread globallogic_audio::announcercontroller();
    thread globallogic_audio::sndmusicfunctions();
    thread recordbreadcrumbdata();
    
    if ( util::isroundbased() )
    {
        if ( util::getroundsplayed() == 0 )
        {
            recordmatchbegin();
        }
        
        matchrecordroundstart();
        
        if ( isdefined( game.overtime_round ) )
        {
            matchrecordovertimeround();
        }
        
        return;
    }
    
    recordmatchbegin();
}

// Namespace globallogic/globallogic
// Params 1
// Checksum 0x93757c2f, Offset: 0xd4a0
// Size: 0xf8, Type: bool
function isprematchrequirementconditionmet( activeteamcount )
{
    if ( level.prematchrequirement == 0 )
    {
        return true;
    }
    
    if ( level.teambased )
    {
        if ( activeteamcount.size <= 1 )
        {
            return false;
        }
        
        foreach ( teamcount in activeteamcount )
        {
            if ( teamcount != level.prematchrequirement )
            {
                return false;
            }
        }
    }
    else if ( activeteamcount[ "free" ] != level.prematchrequirement )
    {
        return false;
    }
    
    return true;
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0x85686beb, Offset: 0xd5a0
// Size: 0x3e2
function waitforplayers()
{
    level endon( #"game_ended" );
    starttime = gettime();
    playerready = 0;
    activeplayercount = 0;
    accepttestclient = 0;
    activeteamcount = [];
    player_ready = [];
    
    while ( !playerready || activeplayercount == 0 || !isprematchrequirementconditionmet( activeteamcount ) )
    {
        activeplayercount = 0;
        
        if ( level.teambased )
        {
            foreach ( team in level.teams )
            {
                activeteamcount[ team ] = 0;
            }
        }
        else
        {
            activeteamcount[ "free" ] = 0;
        }
        
        temp_player_ready = [];
        
        foreach ( player in level.players )
        {
            if ( player istestclient() && accepttestclient == 0 )
            {
                continue;
            }
            
            if ( player.team != "spectator" )
            {
                activeplayercount++;
                player_num = player getentitynumber();
                
                if ( isdefined( player_ready[ player_num ] ) )
                {
                    temp_player_ready[ player_num ] = player_ready[ player_num ];
                }
                else
                {
                    temp_player_ready[ player_num ] = gettime();
                }
                
                if ( temp_player_ready[ player_num ] + 5000 < gettime() || player isstreamerready( -1, 1 ) )
                {
                    if ( level.teambased )
                    {
                        activeteamcount[ player.team ]++;
                    }
                    else
                    {
                        activeteamcount[ "free" ]++;
                    }
                }
            }
            
            if ( player isstreamerready( -1, 1 ) )
            {
                if ( playerready == 0 )
                {
                    level notify( #"first_player_ready", { #player:player } );
                }
                
                playerready = 1;
            }
        }
        
        player_read = temp_player_ready;
        waitframe( 1 );
        
        if ( gettime() - starttime > 20000 )
        {
            if ( level.rankedmatch == 0 && level.arenamatch == 0 )
            {
                accepttestclient = 1;
            }
        }
        
        if ( level.rankedmatch && gettime() - starttime > 120000 )
        {
            exit_level();
            
            while ( true )
            {
                wait 10;
            }
        }
    }
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0x1f154b09, Offset: 0xd990
// Size: 0x44
function prematchwaitingforplayers()
{
    if ( level.prematchrequirement != 0 )
    {
        level waittill( "first_player_ready" );
        luinotifyevent( &"prematch_waiting_for_players" );
    }
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0xe6386c2a, Offset: 0xd9e0
// Size: 0x1ba
function prematchperiod()
{
    setmatchflag( "hud_hardcore", level.hardcoremode );
    level endon( #"game_ended" );
    globallogic_audio::sndmusicsetrandomizer();
    
    if ( draft::is_draft_this_round() )
    {
        level thread draft::start();
        level waittill( "draft_complete" );
        return;
    }
    
    if ( level.prematchperiod > 0 )
    {
        thread matchstarttimer();
        thread prematchwaitingforplayers();
        waitforplayers();
        wait level.prematchperiod;
    }
    else
    {
        matchstarttimerskip();
        waitframe( 1 );
    }
    
    level.inprematchperiod = 0;
    level thread sndsetmatchsnapshot( 0 );
    
    for ( index = 0; index < level.players.size ; index++ )
    {
        level.players[ index ] util::freeze_player_controls( 0 );
        level.players[ index ] enableweapons();
    }
    
    if ( game.state != "playing" )
    {
        return;
    }
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0x8f27b590, Offset: 0xdba8
// Size: 0x17c
function graceperiod()
{
    level endon( #"game_ended" );
    
    if ( isdefined( level.graceperiodfunc ) )
    {
        [[ level.graceperiodfunc ]]();
    }
    else
    {
        wait level.graceperiod;
    }
    
    level notify( #"grace_period_ending" );
    waitframe( 1 );
    level.ingraceperiod = 0;
    
    if ( game.state != "playing" )
    {
        return;
    }
    
    if ( level.numlives )
    {
        players = level.players;
        
        for ( i = 0; i < players.size ; i++ )
        {
            player = players[ i ];
            
            if ( !player.hasspawned && player.sessionteam != "spectator" && !isalive( player ) )
            {
                player.statusicon = "hud_status_dead";
            }
        }
    }
    
    level thread updateteamstatus();
    level thread updateallalivetimes();
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0xb92253b3, Offset: 0xdd30
// Size: 0x4c
function watchmatchendingsoon()
{
    setdvar( "xblive_matchEndingSoon", 0 );
    level waittill( "match_ending_soon" );
    setdvar( "xblive_matchEndingSoon", 1 );
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0xa8f257e7, Offset: 0xdd88
// Size: 0x96, Type: bool
function anyteamhaswavedelay()
{
    foreach ( team in level.teams )
    {
        if ( level.wavedelay[ team ] )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0x248eed01, Offset: 0xde28
// Size: 0xac
function setteamlivesuimodels()
{
    waitframe( 1 );
    allieslivescount = 0;
    axislivescount = 0;
    
    if ( isdefined( game.lives ) )
    {
        allieslivescount = game.lives[ "allies" ];
        axislivescount = game.lives[ "axis" ];
    }
    
    clientfield::set_world_uimodel( "hudItems.alliesLivesCount", allieslivescount );
    clientfield::set_world_uimodel( "hudItems.axisLivesCount", axislivescount );
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0xcb54ab79, Offset: 0xdee0
// Size: 0x1ca4
function callback_startgametype()
{
    level.prematchrequirement = 0;
    level.prematchperiod = 0;
    level.intermission = 0;
    setmatchflag( "cg_drawSpectatorMessages", 1 );
    setmatchflag( "game_ended", 0 );
    
    if ( !isdefined( game.gamestarted ) )
    {
        if ( !isdefined( game.allies ) )
        {
            game.allies = "seals";
        }
        
        if ( !isdefined( game.axis ) )
        {
            game.axis = "pmc";
        }
        
        if ( !isdefined( game.attackers ) )
        {
            game.attackers = "allies";
        }
        
        if ( !isdefined( game.defenders ) )
        {
            game.defenders = "axis";
        }
        
        assert( game.attackers != game.defenders );
        
        foreach ( team in level.teams )
        {
            if ( !isdefined( game.team ) )
            {
                game.team = "pmc";
            }
        }
        
        if ( !isdefined( game.state ) )
        {
            game.state = "playing";
        }
        
        setdvar( "cg_thirdPersonAngle", 354 );
        game.strings[ "press_to_spawn" ] = &"PLATFORM_PRESS_TO_SPAWN";
        
        if ( level.teambased )
        {
            game.strings[ "waiting_for_teams" ] = &"MP_WAITING_FOR_TEAMS";
            game.strings[ "opponent_forfeiting_in" ] = &"MP_OPPONENT_FORFEITING_IN";
        }
        else
        {
            game.strings[ "waiting_for_teams" ] = &"MP_WAITING_FOR_PLAYERS";
            game.strings[ "opponent_forfeiting_in" ] = &"MP_OPPONENT_FORFEITING_IN";
        }
        
        game.strings[ "match_starting_in" ] = &"MP_MATCH_STARTING_IN";
        game.strings[ "spawn_next_round" ] = &"MP_SPAWN_NEXT_ROUND";
        game.strings[ "waiting_to_spawn" ] = &"MP_WAITING_TO_SPAWN";
        game.strings[ "waiting_to_spawn_ss" ] = &"MP_WAITING_TO_SPAWN_SS";
        game.strings[ "you_will_spawn" ] = &"MP_YOU_WILL_RESPAWN";
        game.strings[ "match_starting" ] = &"MP_MATCH_STARTING";
        game.strings[ "change_class" ] = &"MP_CHANGE_CLASS_NEXT_SPAWN";
        game.strings[ "item_on_respawn" ] = &"MP_ITEM_ON_RESPAWN";
        game.strings[ "last_stand" ] = &"MPUI_LAST_STAND";
        game.strings[ "cowards_way" ] = &"PLATFORM_COWARDS_WAY_OUT";
        game.strings[ "tie" ] = &"MP_MATCH_TIE";
        game.strings[ "round_draw" ] = &"MP_ROUND_DRAW";
        game.strings[ "enemies_eliminated" ] = &"MP_ENEMIES_ELIMINATED";
        game.strings[ "score_limit_reached" ] = &"MP_SCORE_LIMIT_REACHED";
        game.strings[ "round_score_limit_reached" ] = &"MP_SCORE_LIMIT_REACHED";
        game.strings[ "round_limit_reached" ] = &"MP_ROUND_LIMIT_REACHED";
        game.strings[ "time_limit_reached" ] = &"MP_TIME_LIMIT_REACHED";
        game.strings[ "players_forfeited" ] = &"MP_PLAYERS_FORFEITED";
        game.strings[ "other_teams_forfeited" ] = &"MP_OTHER_TEAMS_FORFEITED";
        [[ level.onprecachegametype ]]();
        game.gamestarted = 1;
        game.totalkills = 0;
        
        foreach ( team in level.teams )
        {
            if ( !isdefined( game.migratedhost ) )
            {
                game.stat[ "teamScores" ][ team ] = 0;
            }
            
            game.teamsuddendeath[ team ] = 0;
            game.totalkillsteam[ team ] = 0;
        }
        
        level.prematchrequirement = getgametypesetting( "prematchRequirement" );
        level.prematchperiod = getgametypesetting( "prematchperiod" );
        
        /#
            prematchperiodoverride = getdvarint( "<dev string:x10e>", -1 );
            
            if ( prematchperiodoverride >= 0 )
            {
                level.prematchperiod = prematchperiodoverride;
            }
        #/
        
        if ( getdvarint( "xblive_clanmatch" ) != 0 )
        {
            foreach ( team in level.teams )
            {
                game.icons[ team ] = "composite_emblem_team_axis";
            }
            
            game.icons[ "allies" ] = "composite_emblem_team_allies";
            game.icons[ "axis" ] = "composite_emblem_team_axis";
        }
    }
    else
    {
        if ( !level.splitscreen )
        {
            level.prematchperiod = getgametypesetting( "preroundperiod" );
        }
        
        /#
            preroundperiodoverride = getdvarint( "<dev string:x125>", -1 );
            
            if ( preroundperiodoverride >= 0 )
            {
                level.prematchperiod = preroundperiodoverride;
            }
        #/
    }
    
    if ( !isdefined( game.timepassed ) )
    {
        game.timepassed = 0;
    }
    
    if ( !isdefined( game.playabletimepassed ) )
    {
        game.playabletimepassed = 0;
    }
    
    if ( !isdefined( game.roundsplayed ) )
    {
        game.roundsplayed = 0;
    }
    
    setroundsplayed( game.roundsplayed );
    
    if ( isdefined( game.overtime_round ) )
    {
        setroundsplayed( game.roundsplayed + game.overtime_round - 1 );
        setmatchflag( "overtime", 1 );
    }
    else
    {
        setmatchflag( "overtime", 0 );
    }
    
    if ( !isdefined( game.roundwinner ) )
    {
        game.roundwinner = [];
    }
    
    if ( !isdefined( game.lastroundscore ) )
    {
        game.lastroundscore = [];
    }
    
    if ( !isdefined( game.stat[ "roundswon" ] ) )
    {
        game.stat[ "roundswon" ] = [];
    }
    
    if ( !isdefined( game.stat[ "roundswon" ][ "tie" ] ) )
    {
        game.stat[ "roundswon" ][ "tie" ] = 0;
    }
    
    if ( !isdefined( game.stat[ "overtimeroundswon" ] ) )
    {
        game.stat[ "overtimeroundswon" ] = [];
    }
    
    if ( !isdefined( game.stat[ "overtimeroundswon" ][ "tie" ] ) )
    {
        game.stat[ "overtimeroundswon" ][ "tie" ] = 0;
    }
    
    foreach ( team in level.teams )
    {
        if ( !isdefined( game.stat[ "roundswon" ][ team ] ) )
        {
            game.stat[ "roundswon" ][ team ] = 0;
        }
        
        if ( !isdefined( game.stat[ "overtimeroundswon" ][ team ] ) )
        {
            game.stat[ "overtimeroundswon" ][ team ] = 0;
        }
        
        level.teamspawnpoints[ team ] = [];
        level.spawn_point_team_class_names[ team ] = [];
    }
    
    level.skipvote = 0;
    level.gameended = 0;
    level.exitlevel = 0;
    setdvar( "g_gameEnded", 0 );
    level.objidstart = 0;
    level.forcedend = 0;
    level.hostforcedend = 0;
    level.hardcoremode = getgametypesetting( "hardcoreMode" );
    
    if ( level.hardcoremode )
    {
        /#
            print( "<dev string:x13c>" );
        #/
        
        if ( !isdefined( level.friendlyfiredelaytime ) )
        {
            level.friendlyfiredelaytime = 0;
        }
    }
    
    if ( getdvarstring( "scr_max_rank" ) == "" )
    {
        setdvar( "scr_max_rank", "0" );
    }
    
    level.rankcap = getdvarint( "scr_max_rank" );
    
    if ( getdvarstring( "scr_min_prestige" ) == "" )
    {
        setdvar( "scr_min_prestige", "0" );
    }
    
    level.minprestige = getdvarint( "scr_min_prestige" );
    level.usestartspawns = 1;
    level.alwaysusestartspawns = 0;
    level.usexcamsforendgame = 1;
    level.cumulativeroundscores = getgametypesetting( "cumulativeRoundScores" );
    level.allowhitmarkers = getgametypesetting( "allowhitmarkers" );
    level.playerqueuedrespawn = getgametypesetting( "playerQueuedRespawn" );
    level.playerforcerespawn = getgametypesetting( "playerForceRespawn" );
    level.roundstartexplosivedelay = getgametypesetting( "roundStartExplosiveDelay" );
    level.roundstartkillstreakdelay = getgametypesetting( "roundStartKillstreakDelay" );
    level.perksenabled = getgametypesetting( "perksEnabled" );
    level.disableattachments = getgametypesetting( "disableAttachments" );
    level.disabletacinsert = getgametypesetting( "disableTacInsert" );
    level.disablecac = getgametypesetting( "disableCAC" );
    level.disableclassselection = getgametypesetting( "disableClassSelection" );
    level.disableweapondrop = getgametypesetting( "disableweapondrop" );
    level.onlyheadshots = getgametypesetting( "onlyHeadshots" );
    level.minimumallowedteamkills = getgametypesetting( "teamKillPunishCount" ) - 1;
    level.teamkillreducedpenalty = getgametypesetting( "teamKillReducedPenalty" );
    level.teamkillpointloss = getgametypesetting( "teamKillPointLoss" );
    level.teamkillspawndelay = getgametypesetting( "teamKillSpawnDelay" );
    level.deathpointloss = getgametypesetting( "deathPointLoss" );
    level.leaderbonus = getgametypesetting( "leaderBonus" );
    level.forceradar = getgametypesetting( "forceRadar" );
    level.playersprinttime = getgametypesetting( "playerSprintTime" );
    level.bulletdamagescalar = getgametypesetting( "bulletDamageScalar" );
    level.playermaxhealth = getgametypesetting( "playerMaxHealth" );
    level.playerhealthregentime = getgametypesetting( "playerHealthRegenTime" );
    level.scoreresetondeath = getgametypesetting( "scoreResetOnDeath" );
    level.playerrespawndelay = getgametypesetting( "playerRespawnDelay" );
    level.playerincrementalrespawndelay = getgametypesetting( "incrementalSpawnDelay" );
    level.playerobjectiveheldrespawndelay = getgametypesetting( "playerObjectiveHeldRespawnDelay" );
    level.waverespawndelay = getgametypesetting( "waveRespawnDelay" );
    level.suicidespawndelay = getgametypesetting( "spawnsuicidepenalty" );
    level.teamkilledspawndelay = getgametypesetting( "spawnteamkilledpenalty" );
    level.maxsuicidesbeforekick = getgametypesetting( "maxsuicidesbeforekick" );
    level.spectatetype = getgametypesetting( "spectateType" );
    level.voip = spawnstruct();
    level.voip.deadchatwithdead = getgametypesetting( "voipDeadChatWithDead" );
    level.voip.deadchatwithteam = getgametypesetting( "voipDeadChatWithTeam" );
    level.voip.deadhearallliving = getgametypesetting( "voipDeadHearAllLiving" );
    level.voip.deadhearteamliving = getgametypesetting( "voipDeadHearTeamLiving" );
    level.voip.everyonehearseveryone = getgametypesetting( "voipEveryoneHearsEveryone" );
    level.voip.deadhearkiller = getgametypesetting( "voipDeadHearKiller" );
    level.voip.killershearvictim = getgametypesetting( "voipKillersHearVictim" );
    level.droppedtagrespawn = getgametypesetting( "droppedTagRespawn" );
    
    if ( isdefined( level.droppedtagrespawn ) && level.droppedtagrespawn )
    {
        dogtags::init();
    }
    
    gameobjects::main();
    callback::callback( #"hash_cc62acca" );
    thread hud_message::init();
    
    foreach ( team in level.teams )
    {
        initteamvariables( team );
    }
    
    if ( !level.teambased )
    {
        initteamvariables( "free" );
    }
    
    level.maxplayercount = 0;
    level.activeplayers = [];
    level.alivetimemaxcount = 3;
    level.alivetimesaverage = [];
    
    foreach ( team in level.teams )
    {
        level.alivetimesaverage[ team ] = 0;
    }
    
    if ( !isdefined( level.livesdonotreset ) || !level.livesdonotreset )
    {
        foreach ( team in level.teams )
        {
            game.lives[ team ] = level.numteamlives;
        }
        
        level thread setteamlivesuimodels();
    }
    
    level.allowannouncer = getgametypesetting( "allowAnnouncer" );
    
    if ( !isdefined( level.timelimit ) )
    {
        util::registertimelimit( 1, 1440 );
    }
    
    if ( !isdefined( level.scorelimit ) )
    {
        util::registerscorelimit( 1, 500 );
    }
    
    if ( !isdefined( level.roundscorelimit ) )
    {
        util::registerroundscorelimit( 0, 500 );
    }
    
    if ( !isdefined( level.roundlimit ) )
    {
        util::registerroundlimit( 0, 10 );
    }
    
    if ( !isdefined( level.roundwinlimit ) )
    {
        util::registerroundwinlimit( 0, 10 );
    }
    
    globallogic_utils::registerpostroundevent( &userspawnselection::closespawnselectionmenuforallplayers );
    globallogic_utils::registerpostroundevent( &killcam::post_round_final_killcam );
    wavedelay = level.waverespawndelay;
    
    if ( wavedelay )
    {
        foreach ( team in level.teams )
        {
            level.wavedelay[ team ] = wavedelay;
            level.lastwave[ team ] = 0;
        }
        
        level thread [[ level.wavespawntimer ]]();
    }
    
    level.inprematchperiod = 1;
    
    if ( level.prematchperiod > 2 && level.rankedmatch )
    {
        level.prematchperiod += randomfloat( 4 ) - 2;
    }
    
    if ( level.numlives || anyteamhaswavedelay() || level.playerqueuedrespawn )
    {
        level.graceperiod = 15;
    }
    else
    {
        level.graceperiod = 5;
    }
    
    level.ingraceperiod = 1;
    level.roundenddelay = 5;
    level.halftimeroundenddelay = 3;
    globallogic_score::updateallteamscores();
    level.killstreaksenabled = 1;
    level.missilelockplayspacecheckenabled = 1;
    level.missilelockplayspacecheckextraradius = 5000;
    
    if ( getdvarstring( "scr_game_rankenabled" ) == "" )
    {
        setdvar( "scr_game_rankenabled", 1 );
    }
    
    level.rankenabled = getdvarint( "scr_game_rankenabled" );
    
    if ( getdvarstring( "scr_game_medalsenabled" ) == "" )
    {
        setdvar( "scr_game_medalsenabled", 1 );
    }
    
    level.medalsenabled = getdvarint( "scr_game_medalsenabled" );
    
    if ( level.hardcoremode && level.rankedmatch && getdvarstring( "scr_game_friendlyFireDelay" ) == "" )
    {
        setdvar( "scr_game_friendlyFireDelay", 1 );
    }
    
    level.friendlyfiredelay = getdvarint( "scr_game_friendlyFireDelay" );
    [[ level.onstartgametype ]]();
    barrier_builder::setup_deployable_barriers();
    forward_spawn::initialize();
    
    if ( getdvarint( "custom_killstreak_mode" ) == 1 )
    {
        level.killstreaksenabled = 0;
    }
    
    level thread killcam::do_final_killcam();
    thread startgame();
    level thread updategametypedvars();
    level thread simple_hostmigration::updatehostmigrationdata();
    
    /#
        if ( getdvarint( "<dev string:x99>" ) == 1 )
        {
            level.skipgameend = 1;
            level.roundlimit = 1;
            wait 1;
            thread forceend( 0 );
        }
        
        if ( getdvarint( "<dev string:x83>" ) == 1 )
        {
            thread forcedebughostmigration();
        }
    #/
}

/#

    // Namespace globallogic/globallogic
    // Params 0
    // Checksum 0x1368399c, Offset: 0xfb90
    // Size: 0x50, Type: dev
    function forcedebughostmigration()
    {
        while ( true )
        {
            hostmigration::waittillhostmigrationdone();
            wait 60;
            starthostmigration();
            hostmigration::waittillhostmigrationdone();
        }
    }

#/

// Namespace globallogic/globallogic
// Params 4
// Checksum 0xbe73b64c, Offset: 0xfbe8
// Size: 0x110
function registerfriendlyfiredelay( dvarstring, defaultvalue, minvalue, maxvalue )
{
    dvarstring = "scr_" + dvarstring + "_friendlyFireDelayTime";
    
    if ( getdvarstring( dvarstring ) == "" )
    {
        setdvar( dvarstring, defaultvalue );
    }
    
    if ( getdvarint( dvarstring ) > maxvalue )
    {
        setdvar( dvarstring, maxvalue );
    }
    else if ( getdvarint( dvarstring ) < minvalue )
    {
        setdvar( dvarstring, minvalue );
    }
    
    level.friendlyfiredelaytime = getdvarint( dvarstring );
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0xb882d993, Offset: 0xfd00
// Size: 0xa0, Type: bool
function checkroundswitch()
{
    if ( !isdefined( level.roundswitch ) || !level.roundswitch )
    {
        return false;
    }
    
    if ( !isdefined( level.onroundswitch ) )
    {
        return false;
    }
    
    assert( game.roundsplayed > 0 );
    
    if ( game.roundsplayed % level.roundswitch == 0 )
    {
        [[ level.onroundswitch ]]();
        return true;
    }
    
    return false;
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0xd964c986, Offset: 0xfda8
// Size: 0x4c
function listenforgameend()
{
    self waittill( "host_sucks_end_game" );
    level.skipvote = 1;
    
    if ( !level.gameended )
    {
        level thread forceend( 1 );
    }
}

// Namespace globallogic/globallogic
// Params 1
// Checksum 0xab668a4e, Offset: 0xfe00
// Size: 0x12c
function getkillstreaks( player )
{
    for ( killstreaknum = 0; killstreaknum < level.maxkillstreaks ; killstreaknum++ )
    {
        killstreak[ killstreaknum ] = "killstreak_null";
    }
    
    if ( isplayer( player ) && level.disableclassselection != 1 && !player isbot() && isdefined( player.killstreak ) )
    {
        currentkillstreak = 0;
        
        for ( killstreaknum = 0; killstreaknum < level.maxkillstreaks ; killstreaknum++ )
        {
            if ( isdefined( player.killstreak[ killstreaknum ] ) )
            {
                killstreak[ currentkillstreak ] = player.killstreak[ killstreaknum ];
                currentkillstreak++;
            }
        }
    }
    
    return killstreak;
}

// Namespace globallogic/globallogic
// Params 1
// Checksum 0x3e45f352, Offset: 0xff38
// Size: 0x74
function updaterankedmatch( winner )
{
    if ( level.rankedmatch )
    {
        if ( hostidledout() )
        {
            level.hostforcedend = 1;
            
            /#
                print( "<dev string:x150>" );
            #/
        }
    }
    
    globallogic_score::updatematchbonusscores( winner );
}

// Namespace globallogic/globallogic
// Params 2
// Checksum 0xf49cc23e, Offset: 0xffb8
// Size: 0x124
function annihilatorgunplayerkilleffect( attacker, weapon )
{
    if ( weapon.fusetime != 0 )
    {
        wait weapon.fusetime * 0.001;
    }
    else
    {
        wait 0.45;
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self playsoundtoplayer( "evt_annihilation", attacker );
    self playsoundtoallbutplayer( "evt_annihilation_npc", attacker );
    codesetclientfield( self, "annihilate_effect", 1 );
    self shake_and_rumble( 0, 0.3, 0.75, 1 );
    wait 0.1;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self notsolid();
    self ghost();
}

// Namespace globallogic/globallogic
// Params 2
// Checksum 0x9f0677ad, Offset: 0x100e8
// Size: 0x15c
function annihilatorgunactorkilleffect( attacker, weapon )
{
    waitresult = self waittill( "actor_corpse" );
    body = waitresult.corpse;
    
    if ( weapon.fusetime != 0 )
    {
        wait weapon.fusetime * 0.001;
    }
    else
    {
        wait 0.45;
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self playsoundtoplayer( "evt_annihilation", attacker );
    self playsoundtoallbutplayer( "evt_annihilation_npc", attacker );
    
    if ( !isdefined( body ) )
    {
        return;
    }
    
    codesetclientfield( body, "annihilate_effect", 1 );
    body shake_and_rumble( 0, 0.6, 0.2, 1 );
    body notsolid();
    body ghost();
}

// Namespace globallogic/globallogic
// Params 1
// Checksum 0xe2730cc1, Offset: 0x10250
// Size: 0xcc
function pineapplegunplayerkilleffect( attacker )
{
    wait 0.1;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    playsoundatposition( "evt_annihilation_npc", self.origin );
    codesetclientfield( self, "pineapplegun_effect", 1 );
    self shake_and_rumble( 0, 0.3, 0.35, 1 );
    wait 0.1;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self notsolid();
    self ghost();
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0x51f4adb2, Offset: 0x10328
// Size: 0xb4
function bowplayerkilleffect()
{
    waitframe( 1 );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    playsoundatposition( "evt_annihilation_npc", self.origin );
    codesetclientfield( self, "annihilate_effect", 1 );
    self shake_and_rumble( 0, 0.3, 0.35, 1 );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self notsolid();
    self ghost();
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0x9f05d48b, Offset: 0x103e8
// Size: 0xfc
function pineapplegunactorkilleffect()
{
    waitresult = self waittill( "actor_corpse" );
    body = waitresult.corpse;
    wait 0.75;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    playsoundatposition( "evt_annihilation_npc", self.origin );
    
    if ( !isdefined( body ) )
    {
        return;
    }
    
    codesetclientfield( body, "pineapplegun_effect", 1 );
    body shake_and_rumble( 0, 0.3, 0.75, 1 );
    body notsolid();
    body ghost();
}

// Namespace globallogic/globallogic
// Params 4
// Checksum 0xc9b30b8c, Offset: 0x104f0
// Size: 0xf6
function shake_and_rumble( n_delay, shake_size, shake_time, rumble_num )
{
    if ( isdefined( n_delay ) && n_delay > 0 )
    {
        wait n_delay;
    }
    
    nmagnitude = shake_size;
    nduration = shake_time;
    nradius = 500;
    v_pos = self.origin;
    earthquake( nmagnitude, nduration, v_pos, nradius );
    
    for ( i = 0; i < rumble_num ; i++ )
    {
        self playrumbleonentity( "damage_heavy" );
        wait 0.1;
    }
}

// Namespace globallogic/globallogic
// Params 8
// Checksum 0x23b5c20d, Offset: 0x105f0
// Size: 0xa4
function doweaponspecifickilleffects( einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime )
{
    if ( weapon.name == "hero_pineapplegun" && isplayer( attacker ) && smeansofdeath == "MOD_GRENADE" )
    {
        attacker playlocalsound( "wpn_pineapple_grenade_explode_flesh_2D" );
    }
}

// Namespace globallogic/globallogic
// Params 9
// Checksum 0xfd1793e7, Offset: 0x106a0
// Size: 0x1d4
function doweaponspecificcorpseeffects( body, einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime )
{
    if ( smeansofdeath == "MOD_IMPACT" || weapon.doannihilate && isplayer( attacker ) && smeansofdeath == "MOD_GRENADE" )
    {
        if ( isactor( body ) )
        {
            body thread annihilatorgunactorkilleffect( attacker, weapon );
        }
        else
        {
            body thread annihilatorgunplayerkilleffect( attacker, weapon );
        }
        
        return;
    }
    
    if ( smeansofdeath == "MOD_BURNED" )
    {
        if ( !isactor( body ) )
        {
            body thread burncorpse();
        }
        
        return;
    }
    
    if ( weapon.isheavyweapon && isplayer( attacker ) )
    {
        if ( weapon.name == "hero_firefly_swarm" )
        {
            value = randomint( 2 ) + 1;
            
            if ( !isactor( body ) )
            {
                codesetclientfield( body, "firefly_effect", value );
            }
        }
    }
}

// Namespace globallogic/globallogic
// Params 0
// Checksum 0x9452e225, Offset: 0x10880
// Size: 0x5c
function burncorpse()
{
    self endon( #"death" );
    codesetclientfield( self, "burned_effect", 1 );
    wait 3;
    codesetclientfield( self, "burned_effect", 0 );
}

