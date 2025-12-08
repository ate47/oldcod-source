#using scripts/core_common/callbacks_shared;
#using scripts/core_common/challenges_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/damagefeedback_shared;
#using scripts/core_common/demo_shared;
#using scripts/core_common/gameobjects_shared;
#using scripts/core_common/hud_message_shared;
#using scripts/core_common/hud_util_shared;
#using scripts/core_common/influencers_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/popups_shared;
#using scripts/core_common/rank_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/sound_shared;
#using scripts/core_common/spawning_shared;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/mp_common/challenges;
#using scripts/mp_common/gametypes/globallogic;
#using scripts/mp_common/gametypes/globallogic_audio;
#using scripts/mp_common/gametypes/globallogic_defaults;
#using scripts/mp_common/gametypes/globallogic_score;
#using scripts/mp_common/gametypes/globallogic_spawn;
#using scripts/mp_common/gametypes/globallogic_utils;
#using scripts/mp_common/gametypes/hud_message;
#using scripts/mp_common/teams/teams;
#using scripts/mp_common/userspawnselection;
#using scripts/mp_common/util;

#namespace infil;

// Namespace infil/infil
// Params 0
// Checksum 0x80f724d1, Offset: 0xe30
// Size: 0x4
function __init__()
{
    
}

// Namespace infil/GameType_Init
// Params 1, eflags: 0x40
// Checksum 0x7f83395b, Offset: 0xe40
// Size: 0x58c
function event_handler[GameType_Init] main( eventstruct )
{
    globallogic::init();
    util::registertimelimit( 0, 1440 );
    util::registerroundlimit( 0, 10 );
    util::registerroundwinlimit( 0, 10 );
    util::registerroundscorelimit( 0, 5000 );
    util::registerroundswitch( 0, 9 );
    util::registernumlives( 0, 100 );
    util::registerscorelimit( 0, 5000 );
    level.scoreroundwinbased = getgametypesetting( "cumulativeRoundScores" ) == 0;
    level.flagcapturecondition = getgametypesetting( "flagCaptureCondition" );
    level.doubleovertime = 1;
    level.timepauseswheninzone = getgametypesetting( "timePausesWhenInZone" );
    level.objectivehealth = getgametypesetting( "objectiveHealth" );
    level.pickuptime = getgametypesetting( "pickupTime" );
    level.deposittime = getgametypesetting( "depositTime" );
    globallogic::registerfriendlyfiredelay( level.gametype, 15, 0, 1440 );
    
    if ( getdvarstring( "scr_ctf_spawnPointFacingAngle" ) == "" )
    {
        setdvar( "scr_ctf_spawnPointFacingAngle", "0" );
    }
    
    level.var_b2e6979d = 1;
    level.teambased = 1;
    level.overrideteamscore = 1;
    level.onstartgametype = &onstartgametype;
    level.onspawnplayer = &onspawnplayer;
    level.onprecachegametype = &onprecachegametype;
    level.onplayerkilled = &on_player_killed;
    level.onroundswitch = &onroundswitch;
    level.onroundendgame = &onroundendgame;
    level.getteamkillpenalty = &ctf_getteamkillpenalty;
    level.getteamkillscore = &ctf_getteamkillscore;
    level.var_d6911678 = &function_d6911678;
    level.ctfreturnflag = &returnflag;
    level.ontimelimit = &on_time_limit;
    globallogic_spawn::addsupportedspawnpointtype( 256 );
    gameobjects::register_allowed_gameobject( level.gametype );
    
    if ( !isdefined( game.ctf_teamscore_cache ) )
    {
        game.ctf_teamscore_cache[ "allies" ] = 0;
        game.ctf_teamscore_cache[ "axis" ] = 0;
    }
    
    globallogic_audio::set_leader_gametype_dialog( "startCtf", "hcStartCtf", "objCapture", "objCapture" );
    
    if ( !sessionmodeissystemlink() && !sessionmodeisonlinegame() && issplitscreen() )
    {
        globallogic::setvisiblescoreboardcolumns( "score", "kills", "captures", "returns", "deaths" );
    }
    else
    {
        globallogic::setvisiblescoreboardcolumns( "score", "kills", "deaths", "captures", "returns" );
    }
    
    level.var_737e8332 = 0;
    level.var_3f91aaa9 = getgametypesetting( "capturesPerReturnSite" );
    clientfield::register( "worlduimodel", "hudItems.war.batteryState1", 1, 3, "int" );
    clientfield::register( "worlduimodel", "hudItems.war.batteryState2", 1, 3, "int" );
    clientfield::register( "worlduimodel", "hudItems.war.attackingTeam", 1, 2, "int" );
}

// Namespace infil/infil
// Params 0
// Checksum 0xcbc6569e, Offset: 0x13d8
// Size: 0x4a
function onprecachegametype()
{
    game.flag_dropped_sound = "mp_war_objective_lost";
    game.flag_recovered_sound = "mp_war_objective_taken";
    game.strings[ "score_limit_reached" ] = &"MP_CAP_LIMIT_REACHED";
}

// Namespace infil/infil
// Params 0
// Checksum 0x7240e185, Offset: 0x1430
// Size: 0x3e4
function onstartgametype()
{
    level.usestartspawns = 1;
    globallogic_utils::switch_sides();
    
    /#
        setdebugsideswitch( game.switchedsides );
    #/
    
    setclientnamemode( "auto_change" );
    level.var_737e8332 = 0;
    globallogic_score::resetteamscores();
    util::setobjectivetext( "allies", &"OBJECTIVES_CTF" );
    util::setobjectivetext( "axis", &"OBJECTIVES_CTF" );
    
    if ( level.splitscreen )
    {
        util::setobjectivescoretext( "allies", &"OBJECTIVES_CTF" );
        util::setobjectivescoretext( "axis", &"OBJECTIVES_CTF" );
    }
    else
    {
        util::setobjectivescoretext( "allies", &"OBJECTIVES_CTF_SCORE" );
        util::setobjectivescoretext( "axis", &"OBJECTIVES_CTF_SCORE" );
    }
    
    util::setobjectivehinttext( "allies", &"OBJECTIVES_CTF_HINT" );
    util::setobjectivehinttext( "axis", &"OBJECTIVES_CTF_HINT" );
    influencers::create_map_placed_influencers();
    level.spawnsystem.sideswitching = 0;
    spawning::clear_spawn_points();
    level.spawnmins = ( 0, 0, 0 );
    level.spawnmaxs = ( 0, 0, 0 );
    spawning::place_spawn_points( "mp_war_spawn_attacker_zone_1_start" );
    spawning::place_spawn_points( "mp_war_spawn_defender_zone_1_start" );
    spawning::add_spawn_points( game.attackers, "mp_strong_spawn_attacker_region_1" );
    spawning::add_spawn_points( game.defenders, "mp_strong_spawn_defender_region_1" );
    spawning::add_fallback_spawnpoints( "allies", "mp_tdm_spawn" );
    spawning::add_fallback_spawnpoints( "axis", "mp_tdm_spawn" );
    spawning::updateallspawnpoints();
    spawning::update_fallback_spawnpoints();
    globallogic_spawn::addspawns();
    level.mapcenter = math::find_box_center( level.spawnmins, level.spawnmaxs );
    setmapcenter( level.mapcenter );
    spawnpoint = spawning::get_random_intermission_point();
    setdemointermissionpoint( spawnpoint.origin, spawnpoint.angles );
    spawning::add_start_spawn_points( game.attackers, "mp_war_spawn_attacker_zone_1_start" );
    spawning::add_start_spawn_points( game.defenders, "mp_war_spawn_defender_zone_1_start" );
    thread updategametypedvars();
    thread ctf();
}

// Namespace infil/infil
// Params 1
// Checksum 0xc792ca6d, Offset: 0x1820
// Size: 0xb4
function minutesandsecondsstring( milliseconds )
{
    minutes = floor( milliseconds / 60000 );
    milliseconds -= minutes * 60000;
    seconds = floor( milliseconds / 1000 );
    
    if ( seconds < 10 )
    {
        return ( minutes + ":0" + seconds );
    }
    
    return minutes + ":" + seconds;
}

// Namespace infil/infil
// Params 1
// Checksum 0x872f3958, Offset: 0x18e0
// Size: 0x11c
function function_d6911678( team )
{
    if ( isdefined( game.overtime_second_winner[ "ctf" ] ) && game.overtime_second_winner[ "ctf" ] == team )
    {
        self settext( minutesandsecondsstring( game.overtime_best_time[ "ctf" ] ) );
        return;
    }
    
    if ( isdefined( game.overtime_first_winner[ "ctf" ] ) && game.overtime_first_winner[ "ctf" ] == team )
    {
        self settext( minutesandsecondsstring( game.overtime_time_to_beat[ "ctf" ] ) );
        return;
    }
    
    self settext( &"" );
}

// Namespace infil/infil
// Params 0
// Checksum 0x51b0d491, Offset: 0x1a08
// Size: 0x2c
function onroundswitch()
{
    game.switchedsides = !game.switchedsides;
    userspawnselection::onroundchange();
}

// Namespace infil/infil
// Params 1
// Checksum 0xc5f9044b, Offset: 0x1a40
// Size: 0x6c
function onroundendgame( winningteam )
{
    if ( level.scoreroundwinbased )
    {
        globallogic_score::updateteamscorebyroundswon();
        winner = globallogic::determineteamwinnerbygamestat( "roundswon" );
    }
    else
    {
        winner = globallogic::determineteamwinnerbyteamscore();
    }
    
    return winner;
}

// Namespace infil/infil
// Params 0
// Checksum 0xb2a19208, Offset: 0x1ab8
// Size: 0x54
function on_time_limit()
{
    globallogic_score::giveteamscoreforobjective( game.defenders, 1 );
    thread globallogic::endgame( game.defenders, game.strings[ "time_limit_reached" ] );
}

// Namespace infil/infil
// Params 1
// Checksum 0xe30dee1b, Offset: 0x1b18
// Size: 0x8c
function onspawnplayer( predictedspawn )
{
    if ( level.usestartspawns && !level.ingraceperiod )
    {
        level.usestartspawns = 0;
    }
    
    self.isflagcarrier = 0;
    self.flagcarried = undefined;
    self clientfield::set( "ctf_flag_carrier", 0 );
    spawning::onspawnplayer( predictedspawn );
}

// Namespace infil/infil
// Params 0
// Checksum 0x5315e5ce, Offset: 0x1bb0
// Size: 0x1b4
function updategametypedvars()
{
    level.flagcapturetime = getgametypesetting( "captureTime" );
    level.flagtouchreturntime = getgametypesetting( "defuseTime" );
    level.idleflagreturntime = getgametypesetting( "idleFlagResetTime" );
    level.flagrespawntime = getgametypesetting( "flagRespawnTime" );
    level.enemycarriervisible = getgametypesetting( "enemyCarrierVisible" );
    level.roundlimit = getgametypesetting( "roundLimit" );
    level.cumulativeroundscores = getgametypesetting( "cumulativeRoundScores" );
    level.teamkillpenaltymultiplier = getgametypesetting( "teamKillPenalty" );
    level.teamkillscoremultiplier = getgametypesetting( "teamKillScore" );
    
    if ( level.flagtouchreturntime >= 0 && level.flagtouchreturntime != 63 )
    {
        level.touchreturn = 1;
        return;
    }
    
    level.touchreturn = 0;
}

// Namespace infil/infil
// Params 2
// Checksum 0x67e8de40, Offset: 0x1d70
// Size: 0x71e
function function_20447f2f( trigger, objective_name )
{
    visuals = function_64054d25( trigger );
    entityteam = game.attackers;
    visuals[ 0 ] setmodel( "wpn_t7_prp_unobtainium_box_small" );
    visuals[ 0 ] setteam( entityteam );
    var_2e165dbb = gameobjects::create_carry_object( entityteam, trigger, visuals, ( 0, 0, 0 ), objective_name );
    var_2e165dbb.bundle = getscriptbundle( "gameobject_infiltration_object" );
    
    switch ( getgametypesetting( "carrierMoveSpeed" ) )
    {
        case 1:
            level.carriermovespeed = [ "prc_mp_slayer":var_2e165dbb.bundle.slayer_carrier_speed_slow, "prc_mp_objective":var_2e165dbb.bundle.objective_carrier_speed_slow, "prc_mp_support":var_2e165dbb.bundle.support_carrier_speed_slow ];
            break;
        case 2:
            level.carriermovespeed = [ "prc_mp_slayer":var_2e165dbb.bundle.slayer_carrier_speed_normal, "prc_mp_objective":var_2e165dbb.bundle.objective_carrier_speed_normal, "prc_mp_support":var_2e165dbb.bundle.support_carrier_speed_normal ];
            break;
        case 3:
            level.carriermovespeed = [ "prc_mp_slayer":var_2e165dbb.bundle.slayer_carrier_speed_fast, "prc_mp_objective":var_2e165dbb.bundle.objective_carrier_speed_fast, "prc_mp_support":var_2e165dbb.bundle.support_carrier_speed_fast ];
            break;
        default:
            level.carriermovespeed = [ "prc_mp_slayer":1, "prc_mp_objective":1, "prc_mp_support":1 ];
            break;
    }
    
    if ( !isdefined( var_2e165dbb.bundle.n_trigger_use_time ) )
    {
        var_2e165dbb.bundle.n_trigger_use_time = 3;
    }
    
    var_2e165dbb gameobjects::set_use_time( var_2e165dbb.bundle.n_trigger_use_time );
    var_2e165dbb gameobjects::set_team_use_time( "friendly", level.flagtouchreturntime );
    var_2e165dbb gameobjects::set_team_use_time( "enemy", level.flagcapturetime );
    var_2e165dbb gameobjects::set_objective_entity( visuals[ 0 ] );
    var_2e165dbb gameobjects::set_use_hint_text( &"PLATFORM_INFILTRATION_OBJECT" );
    trigger setcursorhint( "HINT_ACTIVATE" );
    var_2e165dbb gameobjects::allow_carry( "friendly" );
    var_2e165dbb gameobjects::set_visible_team( "any" );
    var_2e165dbb gameobjects::set_visible_carrier_model( teams::get_flag_carry_model( entityteam ) );
    var_2e165dbb gameobjects::set_2d_icon( "friendly", level.icondefend2d );
    var_2e165dbb gameobjects::set_3d_icon( "friendly", level.icondefend3d );
    var_2e165dbb gameobjects::set_2d_icon( "enemy", level.iconcapture2d );
    var_2e165dbb gameobjects::set_3d_icon( "enemy", level.iconcapture3d );
    var_2e165dbb.var_6f180198 = &function_2e75f0e;
    
    if ( isdefined( level.objectivehealth ) && level.objectivehealth > 0 )
    {
        visuals[ 0 ].gameobject = var_2e165dbb;
        visuals[ 0 ] setcandamage( 1 );
        visuals[ 0 ].maxhealth = 20000;
        visuals[ 0 ].minhealth = visuals[ 0 ].maxhealth - level.objectivehealth;
        visuals[ 0 ].health = visuals[ 0 ].maxhealth;
        objective_setprogress( var_2e165dbb.objectiveid, 1 );
        visuals[ 0 ] thread function_ede8a483();
    }
    
    if ( level.enemycarriervisible == 2 )
    {
        var_2e165dbb.objidpingfriendly = 1;
    }
    
    var_2e165dbb.allowweapons = 0;
    var_2e165dbb.droponusebutton = 1;
    var_2e165dbb.droponusehasdelay = 1;
    var_2e165dbb.onpickup = &onpickup;
    var_2e165dbb.onpickupfailed = &onpickup;
    var_2e165dbb.ondrop = &ondrop;
    var_2e165dbb.onreset = &onreset;
    var_2e165dbb gameobjects::set_use_time( level.pickuptime );
    
    if ( level.idleflagreturntime > 0 )
    {
        var_2e165dbb.autoresettime = level.idleflagreturntime;
    }
    else
    {
        var_2e165dbb.autoresettime = undefined;
    }
    
    return var_2e165dbb;
}

// Namespace infil/infil
// Params 1
// Checksum 0xfbf9ccc1, Offset: 0x2498
// Size: 0x1e8
function createflagzone( trigger )
{
    visuals = function_64054d25( trigger );
    entityteam = game.defenders;
    flagzone = gameobjects::create_use_object( entityteam, trigger, visuals, ( 0, 0, 0 ), &"infil_deposit" );
    flagzone gameobjects::allow_use( "enemy" );
    flagzone gameobjects::set_use_time( level.deposittime );
    flagzone gameobjects::set_use_text( &"MP_CAPTURING_FLAG" );
    flagzone gameobjects::set_visible_team( "any" );
    flagzone gameobjects::set_model_visibility( 0 );
    flagzone gameobjects::set_use_hint_text( &"PLATFORM_INFILTRATION_OBJECT" );
    trigger setcursorhint( "HINT_ACTIVATE" );
    enemyteam = util::getotherteam( entityteam );
    flagzone gameobjects::set_key_object( level.var_f80ec83e );
    flagzone.onuse = &oncapture;
    flagzone createflagspawninfluencer( entityteam );
    flagzone.var_9a048e13 = 0;
    return flagzone;
}

// Namespace infil/infil
// Params 2
// Checksum 0x52405620, Offset: 0x2688
// Size: 0xbc
function createflaghint( team, origin )
{
    radius = 128;
    height = 64;
    trigger = spawn( "trigger_radius", origin, 0, radius, height );
    trigger sethintstring( &"MP_CTF_CANT_CAPTURE_FLAG" );
    trigger setcursorhint( "HINT_NOICON" );
    trigger.original_origin = origin;
    return trigger;
}

// Namespace infil/infil
// Params 1
// Checksum 0x471b5075, Offset: 0x2750
// Size: 0x198
function function_64054d25( trigger )
{
    visuals = [];
    
    if ( isdefined( trigger ) && isdefined( trigger.target ) )
    {
        targets = getentarray( trigger.target, "targetname" );
        
        if ( targets.size > 0 )
        {
            best_dist2 = distancesquared( targets[ 0 ].origin, trigger.origin );
            visuals[ 0 ] = targets[ 0 ];
            
            foreach ( obj in targets )
            {
                if ( isdefined( obj ) )
                {
                    dist2 = distancesquared( obj.origin, trigger.origin );
                    
                    if ( dist2 < best_dist2 )
                    {
                        best_dist2 = dist2;
                        visuals[ 0 ] = obj;
                    }
                }
            }
        }
    }
    
    return visuals;
}

// Namespace infil/infil
// Params 0
// Checksum 0x9cd21714, Offset: 0x28f0
// Size: 0x35c
function ctf()
{
    wait 0.5;
    set_ui_team();
    level.flags = [];
    level.teamflags = [];
    level.flagzones = [];
    level.teamflagzones = [];
    var_fe1e1c13 = getentarray( "infil_pickup_trigger", "targetname" );
    
    if ( !isdefined( var_fe1e1c13 ) )
    {
        /#
            util::error( "<dev string:x28>" );
        #/
        
        return;
    }
    
    level.var_f80ec83e = [];
    
    for ( index = 0; index < var_fe1e1c13.size ; index++ )
    {
        trigger = var_fe1e1c13[ index ];
        objectivestr = istring( "infil_pickup_" + index + 1 );
        var_2e165dbb = function_20447f2f( trigger, objectivestr );
        var_2e165dbb.objindex = index + 1;
        clientfield::set_world_uimodel( "hudItems.war.batteryState" + var_2e165dbb.objindex, 0 );
        team = var_2e165dbb gameobjects::get_owner_team();
        level.var_f80ec83e[ level.var_f80ec83e.size ] = var_2e165dbb;
    }
    
    var_8c485d0d = getentarray( "infil_deposit_trigger", "targetname" );
    
    if ( !isdefined( var_8c485d0d ) )
    {
        /#
            util::error( "<dev string:x69>" );
        #/
        
        return;
    }
    
    for ( index = 0; index < var_8c485d0d.size ; index++ )
    {
        trigger = var_8c485d0d[ index ];
        flagzone = createflagzone( trigger );
        team = flagzone gameobjects::get_owner_team();
        level.flagzones[ level.flagzones.size ] = flagzone;
        level.teamflagzones[ team ] = flagzone;
        facing_angle = getdvarint( "scr_ctf_spawnPointFacingAngle" );
        setspawnpointsbaseweight( util::getotherteamsmask( team ), trigger.origin, facing_angle, level.spawnsystem.objective_facing_bonus );
    }
    
    function_2c0ba61c();
}

// Namespace infil/infil
// Params 0
// Checksum 0xb46c13ee, Offset: 0x2c58
// Size: 0x74
function ctf_icon_hide()
{
    level waittill( "game_ended" );
    level.teamflags[ "allies" ] gameobjects::set_visible_team( "none" );
    level.teamflags[ "axis" ] gameobjects::set_visible_team( "none" );
}

// Namespace infil/infil
// Params 0
// Checksum 0xdb4bc721, Offset: 0x2cd8
// Size: 0xae
function removeinfluencers()
{
    if ( isdefined( self.spawn_influencer_enemy_carrier ) )
    {
        self influencers::remove_influencer( self.spawn_influencer_enemy_carrier );
        self.spawn_influencer_enemy_carrier = undefined;
    }
    
    if ( isdefined( self.spawn_influencer_friendly_carrier ) )
    {
        self influencers::remove_influencer( self.spawn_influencer_friendly_carrier );
        self.spawn_influencer_friendly_carrier = undefined;
    }
    
    if ( isdefined( self.spawn_influencer_dropped ) )
    {
        self.trigger influencers::remove_influencer( self.spawn_influencer_dropped );
        self.spawn_influencer_dropped = undefined;
    }
}

// Namespace infil/infil
// Params 1
// Checksum 0xb910d83e, Offset: 0x2d90
// Size: 0x514
function ondrop( player )
{
    resume_time();
    origin = ( 0, 0, 0 );
    
    if ( isdefined( player ) )
    {
        player clientfield::set( "ctf_flag_carrier", 0 );
        origin = player.origin;
    }
    
    team = self gameobjects::get_owner_team();
    otherteam = util::getotherteam( team );
    bbprint( "mpobjective", "gametime %d objtype %s team %s playerx %d playery %d playerz %d", gettime(), "ctf_flagdropped", team, origin );
    
    if ( isdefined( player ) )
    {
        util::printandsoundoneveryone( team, undefined, &"", undefined, "mp_war_objective_lost" );
        level thread popups::displayteammessagetoteam( &"MP_FRIENDLY_FLAG_DROPPED", player, team );
        level thread popups::displayteammessagetoteam( &"MP_ENEMY_FLAG_DROPPED", player, otherteam );
    }
    else
    {
        util::printandsoundoneveryone( team, undefined, &"", undefined, "mp_war_objective_lost" );
    }
    
    globallogic_audio::leader_dialog( "warCellDropOfs", team, undefined, "ctf_battery" );
    globallogic_audio::leader_dialog( "warCellDropDef", otherteam, undefined, "ctf_battery_enemy" );
    
    if ( isdefined( player ) )
    {
        player playlocalsound( "mpl_flag_drop_plr" );
    }
    
    if ( isdefined( level.objectivehealth ) && level.objectivehealth > 0 )
    {
        self gameobjects::set_flags( 1 );
    }
    else
    {
        self gameobjects::set_flags( 2 );
    }
    
    globallogic_audio::play_2d_on_team( "mpl_flagdrop_sting_friend", otherteam );
    globallogic_audio::play_2d_on_team( "mpl_flagdrop_sting_enemy", team );
    self gameobjects::set_3d_icon( "friendly", level.icondropped3d );
    self gameobjects::set_2d_icon( "friendly", level.icondropped2d );
    self gameobjects::set_visible_team( "any" );
    self gameobjects::set_3d_icon( "enemy", level.iconcapture3d );
    self gameobjects::set_2d_icon( "enemy", level.iconcapture2d );
    thread sound::play_on_players( game.flag_dropped_sound, game.attackers );
    self thread function_2afd3059( level.idleflagreturntime );
    
    if ( isdefined( player ) )
    {
        player removeinfluencers();
    }
    
    ss = level.spawnsystem;
    player_team_mask = util::getteammask( otherteam );
    enemy_team_mask = util::getteammask( team );
    
    if ( isdefined( player ) )
    {
        var_fea0b904 = player.origin;
    }
    else
    {
        var_fea0b904 = self.curorigin;
    }
    
    self.spawn_influencer_dropped = self.trigger influencers::create_entity_influencer( "ctf_flag_dropped", player_team_mask | enemy_team_mask );
    setinfluencertimeout( self.spawn_influencer_dropped, level.idleflagreturntime );
    clientfield::set_world_uimodel( "hudItems.war.batteryState" + self.objindex, 3 );
    self function_2ac9a02d();
    player setmovespeedscale( player.var_4436a5ce );
}

// Namespace infil/infil
// Params 1
// Checksum 0x9289ddc3, Offset: 0x32b0
// Size: 0x50, Type: bool
function function_2e75f0e( player )
{
    gameobject = self;
    
    if ( isdefined( player.carryobject ) && player.carryobject != gameobject )
    {
        return false;
    }
    
    return true;
}

// Namespace infil/infil
// Params 1
// Checksum 0x2344acf7, Offset: 0x3308
// Size: 0x5bc
function onpickup( player )
{
    pause_time();
    carrierkilledby = self.carrierkilledby;
    self.carrierkilledby = undefined;
    
    if ( isdefined( self.spawn_influencer_dropped ) )
    {
        self.trigger influencers::remove_influencer( self.spawn_influencer_dropped );
        self.spawn_influencer_dropped = undefined;
    }
    
    player addplayerstatwithgametype( "PICKUPS", 1 );
    self removeinfluencers();
    team = self gameobjects::get_owner_team();
    otherteam = util::getotherteam( team );
    self function_34d1619d();
    bbprint( "mpobjective", "gametime %d objtype %s team %s playerx %d playery %d playerz %d", gettime(), "ctf_flagpickup", team, player.origin );
    player recordgameevent( "pickup" );
    demo::bookmark( "event", gettime(), player );
    util::printandsoundoneveryone( otherteam, undefined, &"", undefined, "mp_obj_taken", "mp_enemy_obj_taken" );
    level thread popups::displayteammessagetoteam( &"MP_FRIENDLY_FLAG_TAKEN", player, team );
    level thread popups::displayteammessagetoteam( &"MP_ENEMY_FLAG_TAKEN", player, otherteam );
    characterindex = player getspecialistindex();
    playerrole = getplayerrolecategory( characterindex, currentsessionmode() );
    player.var_4436a5ce = player getmovespeedscale();
    player setmovespeedscale( player.var_4436a5ce * level.carriermovespeed[ playerrole ] );
    player.isflagcarrier = 1;
    player.flagcarried = self;
    player playlocalsound( "mpl_flag_pickup_plr" );
    player clientfield::set( "ctf_flag_carrier", 1 );
    self gameobjects::set_flags( 0 );
    globallogic_audio::play_2d_on_team( "mpl_flagget_sting_friend", otherteam );
    globallogic_audio::play_2d_on_team( "mpl_flagget_sting_enemy", team );
    globallogic_audio::leader_dialog( "warCellPickupOfs", game.attackers, undefined, "ctf_battery" );
    globallogic_audio::leader_dialog( "warCellPickupDef", game.defenders, undefined, "ctf_battery" );
    
    if ( level.enemycarriervisible )
    {
        self gameobjects::set_visible_team( "any" );
    }
    else
    {
        self gameobjects::set_visible_team( "enemy" );
    }
    
    self gameobjects::set_2d_icon( "friendly", level.iconkill2d );
    self gameobjects::set_3d_icon( "friendly", level.iconkill3d );
    self gameobjects::set_2d_icon( "enemy", level.iconescort2d );
    self gameobjects::set_3d_icon( "enemy", level.iconescort3d );
    player resetflashback();
    ss = level.spawnsystem;
    player_team_mask = util::getteammask( otherteam );
    enemy_team_mask = util::getteammask( team );
    player.spawn_influencer_friendly_carrier = player influencers::create_entity_influencer( "ctf_carrier_friendly", player_team_mask );
    player.spawn_influencer_enemy_carrier = player influencers::create_entity_influencer( "ctf_carrier_enemy", enemy_team_mask );
    self function_e8f85bce( player );
    clientfield::set_world_uimodel( "hudItems.war.batteryState" + self.objindex, 2 );
}

// Namespace infil/infil
// Params 1
// Checksum 0xdf65c806, Offset: 0x38d0
// Size: 0x9a
function function_e8f85bce( player )
{
    foreach ( flag_zone in level.flagzones )
    {
        flag_zone gameobjects::set_flags( 1 );
    }
}

// Namespace infil/infil
// Params 0
// Checksum 0xaa691517, Offset: 0x3978
// Size: 0x142
function function_2ac9a02d()
{
    foreach ( flag_zone in level.flagzones )
    {
        flag_zone gameobjects::set_flags( 0 );
    }
    
    foreach ( var_2e165dbb in level.var_f80ec83e )
    {
        if ( isdefined( var_2e165dbb gameobjects::get_carrier() ) )
        {
            function_e8f85bce( var_2e165dbb.carrier );
        }
    }
}

// Namespace infil/infil
// Params 0
// Checksum 0xc087c847, Offset: 0x3ac8
// Size: 0x224
function returnflag()
{
    team = self gameobjects::get_owner_team();
    otherteam = util::getotherteam( team );
    globallogic_audio::play_2d_on_team( "mpl_flagreturn_sting", team );
    globallogic_audio::play_2d_on_team( "mpl_flagreturn_sting", otherteam );
    level.teamflagzones[ otherteam ] gameobjects::allow_use( "friendly" );
    level.teamflagzones[ otherteam ] gameobjects::set_visible_team( "friendly" );
    self gameobjects::return_home();
    self gameobjects::set_visible_team( "any" );
    self gameobjects::set_3d_icon( "friendly", level.icondefend3d );
    self gameobjects::set_2d_icon( "friendly", level.icondefend2d );
    self gameobjects::set_3d_icon( "enemy", level.iconcapture3d );
    self gameobjects::set_2d_icon( "enemy", level.iconcapture2d );
    globallogic_audio::leader_dialog( "warCellDestroyOfs", team, undefined, "ctf_battery" );
    globallogic_audio::leader_dialog( "warCellDestroyDef", otherteam, undefined, "ctf_battery_enemy" );
    self function_2ac9a02d();
}

// Namespace infil/infil
// Params 1
// Checksum 0x2d98cb71, Offset: 0x3cf8
// Size: 0x564
function oncapture( player )
{
    resume_time();
    team = player.pers[ "team" ];
    enemyteam = util::getotherteam( team );
    time = gettime();
    
    if ( !isdefined( player.carryobject ) )
    {
        return;
    }
    
    util::printandsoundoneveryone( team, undefined, &"", undefined, "mp_obj_captured", "mp_enemy_obj_captured" );
    bbprint( "mpobjective", "gametime %d objtype %s team %s playerx %d playery %d playerz %d", time, "ctf_flagcapture", enemyteam, player.origin );
    game.challenge[ team ][ "capturedFlag" ] = 1;
    
    if ( isdefined( player.pers[ "captures" ] ) )
    {
        player.pers[ "captures" ]++;
        player.captures = player.pers[ "captures" ];
    }
    
    demo::bookmark( "event", gettime(), player );
    player addplayerstatwithgametype( "CAPTURES", 1 );
    level thread popups::displayteammessagetoteam( &"MP_ENEMY_FLAG_CAPTURED", player, team );
    level thread popups::displayteammessagetoteam( &"MP_FRIENDLY_FLAG_CAPTURED", player, enemyteam );
    globallogic_audio::play_2d_on_team( "mpl_flagcapture_sting_enemy", enemyteam );
    globallogic_audio::play_2d_on_team( "mpl_flagcapture_sting_friend", team );
    player giveflagcapturexp( player );
    var_2e165dbb = player.carryobject;
    player challenges::capturedobjective( time, var_2e165dbb.trigger );
    self.var_9a048e13++;
    var_2e165dbb.dontannouncereturn = 1;
    var_2e165dbb gameobjects::return_home();
    var_2e165dbb.dontannouncereturn = undefined;
    var_2e165dbb gameobjects::allow_use( "none" );
    var_2e165dbb gameobjects::allow_carry( "none" );
    var_2e165dbb gameobjects::set_visible_team( "none" );
    var_2e165dbb gameobjects::set_model_visibility( 0 );
    
    if ( level.var_3f91aaa9 == self.var_9a048e13 )
    {
        self gameobjects::allow_use( "none" );
        self gameobjects::set_visible_team( "none" );
    }
    
    if ( level.var_737e8332 == 0 )
    {
        globallogic_audio::leader_dialog( "warCellDeliveredOfs", team, undefined, "ctf_flag_enemy" );
        globallogic_audio::leader_dialog( "warCellDeliveredDef", enemyteam, undefined, "ctf_flag" );
    }
    
    player.isflagcarrier = 0;
    player.flagcarried = undefined;
    player clientfield::set( "ctf_flag_carrier", 0 );
    
    if ( level.var_737e8332 == 1 )
    {
        globallogic_score::giveteamscoreforobjective( game.attackers, 1 );
        level thread globallogic::endgame( game.attackers, game.strings[ game.attackers + "_win" ] );
    }
    
    var_2e165dbb removeinfluencers();
    player removeinfluencers();
    clientfield::set_world_uimodel( "hudItems.war.batteryState" + var_2e165dbb.objindex, 1 );
    self function_2ac9a02d();
    level.var_737e8332++;
    player setmovespeedscale( player.var_4436a5ce );
}

// Namespace infil/infil
// Params 1
// Checksum 0x97476512, Offset: 0x4268
// Size: 0x4c
function giveflagcapturexp( player )
{
    scoreevents::processscoreevent( "infil_object_delivered", player );
    player recordgameevent( "capture" );
}

// Namespace infil/infil
// Params 0, eflags: 0x4
// Checksum 0x60a58f60, Offset: 0x42c0
// Size: 0x5c
function private set_ui_team()
{
    if ( game.attackers == "allies" )
    {
        clientfield::set_world_uimodel( "hudItems.war.attackingTeam", 1 );
        return;
    }
    
    clientfield::set_world_uimodel( "hudItems.war.attackingTeam", 2 );
}

// Namespace infil/infil
// Params 0
// Checksum 0x429e9761, Offset: 0x4328
// Size: 0x16c
function onreset()
{
    team = self gameobjects::get_owner_team();
    self gameobjects::set_visible_team( "any" );
    self gameobjects::set_3d_icon( "friendly", level.icondefend3d );
    self gameobjects::set_2d_icon( "friendly", level.icondefend2d );
    self gameobjects::set_3d_icon( "enemy", level.iconcapture3d );
    self gameobjects::set_2d_icon( "enemy", level.iconcapture2d );
    self gameobjects::set_flags( 0 );
    self function_34d1619d();
    self removeinfluencers();
    self function_2ac9a02d();
    clientfield::set_world_uimodel( "hudItems.war.batteryState" + self.objindex, 0 );
}

// Namespace infil/infil
// Params 9
// Checksum 0xc6c7361f, Offset: 0x44a0
// Size: 0x604
function on_player_killed( einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration )
{
    if ( isdefined( attacker ) && isplayer( attacker ) )
    {
        for ( index = 0; index < level.var_f80ec83e.size ; index++ )
        {
            flagteam = "invalidTeam";
            inflagradius = 0;
            defendedflag = 0;
            offendedflag = 0;
            flagcarrier = level.var_f80ec83e[ index ].carrier;
            
            if ( isdefined( flagcarrier ) )
            {
                if ( isplayer( attacker ) && attacker.pers[ "team" ] != self.pers[ "team" ] )
                {
                    if ( isdefined( level.var_f80ec83e[ index ].carrier.attackerdata ) )
                    {
                        if ( level.var_f80ec83e[ index ].carrier != attacker )
                        {
                            if ( isdefined( level.var_f80ec83e[ index ].carrier.attackerdata[ self.clientid ] ) )
                            {
                                scoreevents::processscoreevent( "infil_object_carrier_rescue", attacker, undefined, weapon );
                            }
                        }
                    }
                }
                
                if ( isdefined( attacker.isflagcarrier ) && attacker !== self && attacker.isflagcarrier )
                {
                    scoreevents::processscoreevent( "infil_object_carry_kill", attacker, undefined, weapon );
                }
            }
        }
        
        if ( isdefined( self.isflagcarrier ) && attacker !== self && self.isflagcarrier )
        {
            scoreevents::processscoreevent( "infil_object_carrier_kill", attacker, undefined, weapon );
        }
        
        victim = self;
        
        foreach ( flag_zone in level.flagzones )
        {
            if ( isdefined( attacker.team ) && attacker != victim && isdefined( victim.team ) )
            {
                dist_to_zone_origin = distance2dsquared( attacker.origin, flag_zone.origin );
                victim_dist_to_zone_origin = distance2dsquared( victim.origin, flag_zone.origin );
                
                if ( victim_dist_to_zone_origin < level.defaultoffenseradiussq || dist_to_zone_origin < level.defaultoffenseradiussq )
                {
                    if ( victim.team == flag_zone.team )
                    {
                        attacker thread challenges::killedbasedefender( flag_zone.trigger );
                        continue;
                    }
                    
                    attacker thread challenges::killedbaseoffender( flag_zone.trigger, weapon );
                }
            }
        }
    }
    
    if ( !isdefined( self.isflagcarrier ) || !self.isflagcarrier )
    {
        return;
    }
    
    if ( isdefined( attacker ) && isplayer( attacker ) && attacker.pers[ "team" ] != self.pers[ "team" ] )
    {
        if ( isdefined( self.flagcarried ) )
        {
            for ( index = 0; index < level.var_f80ec83e.size ; index++ )
            {
                currentflag = level.var_f80ec83e[ index ];
                
                if ( currentflag.ownerteam == self.team )
                {
                    if ( currentflag.curorigin == currentflag.trigger.baseorigin )
                    {
                        dist = distance2dsquared( self.origin, currentflag.curorigin );
                        
                        if ( dist < level.defaultoffenseradiussq )
                        {
                            self.flagcarried.carrierkilledby = attacker;
                            break;
                        }
                    }
                }
            }
        }
        
        attacker recordgameevent( "kill_carrier" );
        self recordkillmodifier( "carrying" );
    }
}

// Namespace infil/infil
// Params 0
// Checksum 0x21ed80b7, Offset: 0x4ab0
// Size: 0x474
function function_2c0ba61c()
{
    level.var_5d0c9f44 = [];
    level.var_5d0c9f44[ "allies" ][ "axis" ] = hud::createservertimer( "objective", 1.4, "allies" );
    level.var_5d0c9f44[ "allies" ][ "axis" ] hud::setpoint( "TOPRIGHT", "TOPRIGHT", 0, 0 );
    level.var_5d0c9f44[ "allies" ][ "axis" ].label = &"MP_ENEMY_FLAG_RETURNING_IN";
    level.var_5d0c9f44[ "allies" ][ "axis" ].alpha = 0;
    level.var_5d0c9f44[ "allies" ][ "axis" ].archived = 0;
    level.var_5d0c9f44[ "allies" ][ "allies" ] = hud::createservertimer( "objective", 1.4, "allies" );
    level.var_5d0c9f44[ "allies" ][ "allies" ] hud::setpoint( "TOPRIGHT", "TOPRIGHT", 0, 20 );
    level.var_5d0c9f44[ "allies" ][ "allies" ].label = &"MP_YOUR_FLAG_RETURNING_IN";
    level.var_5d0c9f44[ "allies" ][ "allies" ].alpha = 0;
    level.var_5d0c9f44[ "allies" ][ "allies" ].archived = 0;
    level.var_5d0c9f44[ "axis" ][ "allies" ] = hud::createservertimer( "objective", 1.4, "axis" );
    level.var_5d0c9f44[ "axis" ][ "allies" ] hud::setpoint( "TOPRIGHT", "TOPRIGHT", 0, 0 );
    level.var_5d0c9f44[ "axis" ][ "allies" ].label = &"MP_ENEMY_FLAG_RETURNING_IN";
    level.var_5d0c9f44[ "axis" ][ "allies" ].alpha = 0;
    level.var_5d0c9f44[ "axis" ][ "allies" ].archived = 0;
    level.var_5d0c9f44[ "axis" ][ "axis" ] = hud::createservertimer( "objective", 1.4, "axis" );
    level.var_5d0c9f44[ "axis" ][ "axis" ] hud::setpoint( "TOPRIGHT", "TOPRIGHT", 0, 20 );
    level.var_5d0c9f44[ "axis" ][ "axis" ].label = &"MP_YOUR_FLAG_RETURNING_IN";
    level.var_5d0c9f44[ "axis" ][ "axis" ].alpha = 0;
    level.var_5d0c9f44[ "axis" ][ "axis" ].archived = 0;
}

// Namespace infil/infil
// Params 1
// Checksum 0x8f950f71, Offset: 0x4f30
// Size: 0xa8
function function_2afd3059( time )
{
    if ( level.touchreturn || level.idleflagreturntime == 0 )
    {
        return;
    }
    
    self notify( #"hash_2afd3059" );
    self endon( #"hash_2afd3059" );
    result = function_5badced4( time );
    self removeinfluencers();
    self function_34d1619d();
    
    if ( !isdefined( result ) )
    {
        return;
    }
}

// Namespace infil/infil
// Params 1
// Checksum 0x4cdaf9fe, Offset: 0x4fe0
// Size: 0x192, Type: bool
function function_5badced4( time )
{
    self endon( #"picked_up" );
    level endon( #"game_ended" );
    ownerteam = self gameobjects::get_owner_team();
    assert( !level.var_5d0c9f44[ "<dev string:xac>" ][ ownerteam ].alpha );
    level.var_5d0c9f44[ "axis" ][ ownerteam ].alpha = 1;
    level.var_5d0c9f44[ "axis" ][ ownerteam ] settimer( time );
    assert( !level.var_5d0c9f44[ "<dev string:xb1>" ][ ownerteam ].alpha );
    level.var_5d0c9f44[ "allies" ][ ownerteam ].alpha = 1;
    level.var_5d0c9f44[ "allies" ][ ownerteam ] settimer( time );
    
    if ( time <= 0 )
    {
        return false;
    }
    else
    {
        wait time;
    }
    
    return true;
}

// Namespace infil/infil
// Params 0
// Checksum 0xd933a294, Offset: 0x5180
// Size: 0x78
function function_34d1619d()
{
    ownerteam = self gameobjects::get_owner_team();
    level.var_5d0c9f44[ "allies" ][ ownerteam ].alpha = 0;
    level.var_5d0c9f44[ "axis" ][ ownerteam ].alpha = 0;
}

// Namespace infil/infil
// Params 1
// Checksum 0xd95e6de7, Offset: 0x5200
// Size: 0xe4
function createflagspawninfluencer( entityteam )
{
    otherteam = util::getotherteam( entityteam );
    team_mask = util::getteammask( entityteam );
    other_team_mask = util::getteammask( otherteam );
    self.spawn_influencer_friendly = self influencers::create_influencer( "ctf_base_friendly", self.trigger.origin, team_mask );
    self.spawn_influencer_enemy = self influencers::create_influencer( "ctf_base_friendly", self.trigger.origin, other_team_mask );
}

// Namespace infil/infil
// Params 4
// Checksum 0x9bbed4a6, Offset: 0x52f0
// Size: 0x8a
function ctf_getteamkillpenalty( einflictor, attacker, smeansofdeath, weapon )
{
    teamkill_penalty = globallogic_defaults::default_getteamkillpenalty( einflictor, attacker, smeansofdeath, weapon );
    
    if ( isdefined( self.isflagcarrier ) && self.isflagcarrier )
    {
        teamkill_penalty *= level.teamkillpenaltymultiplier;
    }
    
    return teamkill_penalty;
}

// Namespace infil/infil
// Params 4
// Checksum 0xcf393a60, Offset: 0x5388
// Size: 0x9a
function ctf_getteamkillscore( einflictor, attacker, smeansofdeath, weapon )
{
    teamkill_score = attacker rank::getscoreinfovalue( "kill" );
    
    if ( isdefined( self.isflagcarrier ) && self.isflagcarrier )
    {
        teamkill_score *= level.teamkillscoremultiplier;
    }
    
    return int( teamkill_score );
}

// Namespace infil/infil
// Params 0
// Checksum 0x538ffe26, Offset: 0x5430
// Size: 0x4c8
function function_ede8a483()
{
    self endon( #"death" );
    self endon( #"delete" );
    
    while ( true )
    {
        waitresult = self waittill( "damage" );
        attacker = waitresult.attacker;
        weapon = waitresult.weapon;
        
        if ( !self.gameobject gameobjects::is_object_away_from_home() )
        {
            self.health = self.maxhealth;
            
            foreach ( player in level.players )
            {
                player.var_61edcaa2 = undefined;
            }
            
            continue;
        }
        
        if ( !isdefined( attacker.var_61edcaa2 ) )
        {
            attacker.var_61edcaa2 = 0;
        }
        
        attacker.var_61edcaa2 += waitresult.amount;
        
        if ( level.teambased && self.gameobject.ownerteam != attacker.team )
        {
            if ( damagefeedback::dodamagefeedback( weapon, attacker ) )
            {
                attacker damagefeedback::update();
            }
        }
        
        if ( isdefined( attacker.team ) && game.defenders == attacker.team )
        {
            if ( self.health <= self.minhealth )
            {
                self.health = self.maxhealth;
                self.gameobject gameobjects::return_home();
                globallogic_audio::leader_dialog( "warCellDestroyOfs", game.attackers, undefined, "ctf_battery" );
                globallogic_audio::leader_dialog( "warCellDestroyDef", game.defenders, undefined, "ctf_battery_enemy" );
                scoreevents::processscoreevent( "infil_object_destroyed", attacker );
                clientfield::set_world_uimodel( "hudItems.war.batteryState" + self.gameobject.objindex, 0 );
                
                foreach ( player in level.players )
                {
                    if ( player == attacker || player.team == game.attackers || !isdefined( player.var_61edcaa2 ) )
                    {
                        continue;
                    }
                    
                    shutdowndamage = self.maxhealth - self.minhealth;
                    damagepercent = player.var_61edcaa2 / shutdowndamage;
                    
                    if ( damagepercent >= 0.2 )
                    {
                        scoreevents::processscoreevent( "infil_object_destroy_assist", player );
                    }
                    
                    player.var_61edcaa2 = undefined;
                }
            }
        }
        
        delta = self.health - self.minhealth;
        max_delta = self.maxhealth - self.minhealth;
        percent = min( 1, delta / max_delta );
        objective_setprogress( self.gameobject.objectiveid, percent );
    }
}

// Namespace infil/infil
// Params 0
// Checksum 0x260ad710, Offset: 0x5900
// Size: 0x24
function pause_time()
{
    if ( level.timepauseswheninzone )
    {
        globallogic_utils::pausetimer();
    }
}

// Namespace infil/infil
// Params 0
// Checksum 0x6bdb4a5f, Offset: 0x5930
// Size: 0x24
function resume_time()
{
    if ( level.timepauseswheninzone )
    {
        globallogic_utils::resumetimer();
    }
}

