#using scripts/core_common/callbacks_shared;
#using scripts/core_common/challenges_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/compass;
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
#using scripts/core_common/weapons/barrier_builder;
#using scripts/mp_common/challenges;
#using scripts/mp_common/gametypes/battlechatter;
#using scripts/mp_common/gametypes/globallogic;
#using scripts/mp_common/gametypes/globallogic_audio;
#using scripts/mp_common/gametypes/globallogic_score;
#using scripts/mp_common/gametypes/globallogic_tickets;
#using scripts/mp_common/gametypes/globallogic_utils;
#using scripts/mp_common/gametypes/hostmigration;
#using scripts/mp_common/gametypes/mission_ctf;
#using scripts/mp_common/gametypes/mission_escort;
#using scripts/mp_common/gametypes/mission_koth;
#using scripts/mp_common/gametypes/spawning;
#using scripts/mp_common/userspawnselection;
#using scripts/mp_common/util;

#namespace war;

// Namespace war/GameType_Init
// Params 1, eflags: 0x40
// Checksum 0x7b74d0a5, Offset: 0xc78
// Size: 0x50c
function event_handler[GameType_Init] main( eventstruct )
{
    globallogic::init();
    mission_koth::init( getscriptbundle( "mission_settings_koth" ) );
    
    if ( getdvarint( "bg_warmode_version" ) > 1 )
    {
        mission_ctf::init( getscriptbundle( "mission_settings_ctf" ) );
        mission_escort::init( getscriptbundle( "mission_settings_escort" ) );
    }
    
    level.war_total_zones = 3;
    util::registertimelimit( 0, 1440 );
    util::registerscorelimit( 0, 2000 );
    util::registernumlives( 0, 100 );
    util::registerroundswitch( 0, 9 );
    util::registerroundwinlimit( 0, 10 );
    globallogic::registerfriendlyfiredelay( level.gametype, 15, 0, 1440 );
    level.teambased = 1;
    level.doprematch = 1;
    level.overrideteamscore = 1;
    level.scoreroundwinbased = 0;
    level.onstartgametype = &on_start_gametype;
    level.onspawnplayer = &on_spawn_player;
    level.playerspawnedcb = &player_spawned_cb;
    level.onroundswitch = &on_round_switch;
    level.onplayerkilled = &on_player_killed;
    level.onendgame = &on_end_game;
    level.delayplayer = getgametypesetting( "delayPlayer" );
    level.randomzonespawn = getgametypesetting( "randomObjectiveLocations" );
    level.scoreperplayer = getgametypesetting( "scorePerPlayer" );
    level.timepauseswheninzone = getgametypesetting( "timePausesWhenInZone" );
    level.iconoffset = ( 0, 0, 32 );
    gameobjects::register_allowed_gameobject( level.gametype );
    
    if ( getdvarint( "bg_warmode_version" ) > 1 )
    {
        gameobjects::register_allowed_gameobject( "ctf" );
        gameobjects::register_allowed_gameobject( "escort" );
    }
    
    globallogic_audio::set_leader_gametype_dialog( "startWar", "hcStartWar", "warOrdersOfs", "warOrdersDef" );
    level.lastdialogtime = 0;
    level.zonespawnqueue = [];
    game.gatenameprefix = "gate";
    
    if ( !sessionmodeissystemlink() && !sessionmodeisonlinegame() && issplitscreen() )
    {
        globallogic::setvisiblescoreboardcolumns( "rolescore", "score", "kills", "deaths", "objtime", "defends" );
    }
    else
    {
        globallogic::setvisiblescoreboardcolumns( "rolescore", "score", "kills", "deaths", "objtime", "defends" );
    }
    
    tickets::reset_match_start( level.war_total_zones );
    level.get_tickets_as_time = &get_tickets_as_time;
    register_clientfields();
    thread watch_tickets();
    thread watch_stage_tickets();
    thread watch_ticket_deaths();
}

// Namespace war/war
// Params 0
// Checksum 0x7edc09fc, Offset: 0x1190
// Size: 0x22
function get_tickets_as_time()
{
    return tickets::get_tickets( game.attackers );
}

// Namespace war/GameType_Start
// Params 1, eflags: 0x40
// Checksum 0xf0bc2c09, Offset: 0x11c0
// Size: 0x24
function event_handler[GameType_Start] post_main( eventstruct )
{
    level thread perform_post_main();
}

// Namespace war/war
// Params 0
// Checksum 0x624afab, Offset: 0x11f0
// Size: 0x44
function perform_post_main()
{
    wait 0.5;
    update_team_scores();
    populate_clientfields();
    level thread watch_score_limits();
}

// Namespace war/war
// Params 0
// Checksum 0xad231a5e, Offset: 0x1240
// Size: 0x514
function register_clientfields()
{
    clientfield::register( "world", "warzone", 1, 5, "int" );
    clientfield::register( "world", "warzonestate", 1, 10, "int" );
    clientfield::register( "worlduimodel", "hudItems.war.team1.tickets", 1, 10, "int" );
    clientfield::register( "worlduimodel", "hudItems.war.team1.zone1", 1, 10, "int" );
    clientfield::register( "worlduimodel", "hudItems.war.team1.zone2", 1, 10, "int" );
    clientfield::register( "worlduimodel", "hudItems.war.team1.zone3", 1, 10, "int" );
    clientfield::register( "worlduimodel", "hudItems.war.team1.zone4", 1, 10, "int" );
    clientfield::register( "worlduimodel", "hudItems.war.team1.zone5", 1, 10, "int" );
    clientfield::register( "worlduimodel", "hudItems.war.team1.bonus", 1, 1, "int" );
    clientfield::register( "worlduimodel", "hudItems.war.team1.progress", 1, 3, "int" );
    clientfield::register( "worlduimodel", "hudItems.war.team2.tickets", 1, 10, "int" );
    clientfield::register( "worlduimodel", "hudItems.war.team2.zone1", 1, 10, "int" );
    clientfield::register( "worlduimodel", "hudItems.war.team2.zone2", 1, 10, "int" );
    clientfield::register( "worlduimodel", "hudItems.war.team2.zone3", 1, 10, "int" );
    clientfield::register( "worlduimodel", "hudItems.war.team2.zone4", 1, 10, "int" );
    clientfield::register( "worlduimodel", "hudItems.war.team2.zone5", 1, 10, "int" );
    clientfield::register( "worlduimodel", "hudItems.war.team2.bonus", 1, 1, "int" );
    clientfield::register( "worlduimodel", "hudItems.war.team2.progress", 1, 3, "int" );
    clientfield::register( "worlduimodel", "hudItems.war.attackingTeam", 1, 2, "int" );
    clientfield::register( "worlduimodel", "hudItems.war.currentZone", 1, 3, "int" );
    clientfield::register( "worlduimodel", "hudItems.war.currentZoneStartTime", 1, 10, "int" );
    clientfield::register( "worlduimodel", "hudItems.war.attackingDeaths", 1, 4, "counter" );
    clientfield::register( "worlduimodel", "hudItems.war.currentZoneProgress", 1, 8, "float" );
    clientfield::register( "worlduimodel", "hudItems.war.robotCurrentDistance", 1, 16, "int" );
    clientfield::register( "worlduimodel", "hudItems.war.batteryState1", 1, 3, "int" );
    clientfield::register( "worlduimodel", "hudItems.war.batteryState2", 1, 3, "int" );
    clientfield::register( "worlduimodel", "hudItems.missions.captureMultiplierStatus", 1, 2, "int" );
}

// Namespace war/war
// Params 0
// Checksum 0x99b0508, Offset: 0x1760
// Size: 0x16e
function populate_clientfields()
{
    wait 0.5;
    clientfield::set_world_uimodel( "hudItems.war.team1.progress", isdefined( game.stat[ "war.team1.progress" ] ) ? game.stat[ "war.team1.progress" ] : 0 );
    clientfield::set_world_uimodel( "hudItems.war.team2.progress", isdefined( game.stat[ "war.team2.progress" ] ) ? game.stat[ "war.team2.progress" ] : 0 );
    
    for ( i = 0; i < level.war_total_zones ; i++ )
    {
        zone = i + 1;
        clientfield::set_world_uimodel( "hudItems.war.team1.zone" + zone, tickets::get_stage_tickets( "allies", i ) );
        clientfield::set_world_uimodel( "hudItems.war.team2.zone" + zone, tickets::get_stage_tickets( "axis", i ) );
    }
}

// Namespace war/war
// Params 0
// Checksum 0x5dbbd876, Offset: 0x18d8
// Size: 0xc2
function update_team_scores()
{
    foreach ( team in level.teams )
    {
        teamtotaltickets = tickets::get_total_tickets( team, level.war_total_zones );
        [[ level._setteamscore ]]( team, teamtotaltickets );
    }
}

// Namespace war/war
// Params 0
// Checksum 0xe8eba8e5, Offset: 0x19a8
// Size: 0x41c
function watch_score_limits()
{
    level notify( #"watch_score_limits_singleton" );
    level endon( #"watch_score_limits_singleton" );
    level endon( #"game_ended" );
    
    while ( !isdefined( game.defenders ) )
    {
        wait 0.5;
    }
    
    defender_total_tickets = tickets::get_total_tickets( game.defenders, level.war_total_zones );
    
    while ( tickets::get_tickets( game.attackers ) == 0 )
    {
        wait 0.5;
    }
    
    zero_tickets_ends_game = 0;
    zero_tickets_ends_mission = 1;
    use_no_possible_win_logic = 0;
    mission_active = 1;
    
    while ( true )
    {
        /#
            if ( getdvarint( "scr_disable_war_score_limits", 0 ) > 0 )
            {
                return;
            }
        #/
        
        attacker_tickets = tickets::get_tickets( game.attackers );
        
        if ( !mission_active && attacker_tickets > 0 )
        {
            mission_active = 1;
        }
        
        if ( attacker_tickets == 0 && mission_active )
        {
            if ( zero_tickets_ends_game )
            {
                if ( game.roundsplayed == 0 )
                {
                    level thread globallogic::endgame( game.defenders, game.strings[ game.attackers + "_eliminated" ] );
                    return;
                }
                
                level thread globallogic::endgame( game.defenders, game.strings[ game.attackers + "_eliminated" ] );
                return;
            }
            
            if ( zero_tickets_ends_mission )
            {
                level notify( #"mission_timed_out" );
                mission_active = 0;
            }
        }
        
        if ( use_no_possible_win_logic && isdefined( game.roundsplayed ) && game.roundsplayed > 0 )
        {
            attacker_total_tickets = tickets::get_total_tickets( game.attackers, level.war_total_zones );
            attacker_total_possible_tickets = attacker_tickets + attacker_total_tickets;
            attacker_total_possible_tickets += tickets::get_stage_win_tickets( level.prevzoneindex );
            
            for ( i = level.prevzoneindex + 1; i < level.war_total_zones ; i++ )
            {
                attacker_total_possible_tickets += tickets::get_zone_start_tickets( i );
                attacker_total_possible_tickets += tickets::get_stage_win_tickets( i );
            }
            
            if ( attacker_total_possible_tickets < defender_total_tickets )
            {
                level thread globallogic::endgame( game.defenders, game.strings[ game.defenders + "_win" ] );
                return;
            }
            
            if ( attacker_total_tickets > defender_total_tickets )
            {
                level thread globallogic::endgame( game.attackers, game.strings[ game.attackers + "_win" ] );
                return;
            }
        }
        
        wait 0.5;
    }
}

// Namespace war/war
// Params 0
// Checksum 0x197c4dd2, Offset: 0x1dd0
// Size: 0xc8
function watch_tickets()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        waitresult = level waittill( "tickets_updated" );
        
        if ( waitresult.team == "allies" )
        {
            clientfield::set_world_uimodel( "hudItems.war.team1.tickets", waitresult.total_tickets );
            continue;
        }
        
        if ( waitresult.team == "axis" )
        {
            clientfield::set_world_uimodel( "hudItems.war.team2.tickets", waitresult.total_tickets );
        }
    }
}

// Namespace war/war
// Params 0
// Checksum 0x574289f6, Offset: 0x1ea0
// Size: 0xd0
function watch_stage_tickets()
{
    level notify( #"watch_stage_tickets_singleton" );
    level endon( #"watch_stage_tickets_singleton" );
    
    while ( true )
    {
        waitresult = level waittill( "tickets_stage_updated" );
        ui_team_name = waitresult.team == "allies" ? "hudItems.war.team1.zone" : "hudItems.war.team2.zone";
        clientfield::set_world_uimodel( ui_team_name + waitresult.zone_number + 1, waitresult.total_tickets );
        update_team_scores();
    }
}

// Namespace war/war
// Params 0
// Checksum 0x62fe2710, Offset: 0x1f78
// Size: 0xa0
function watch_ticket_deaths()
{
    level notify( #"watch_ticket_deaths_singleton" );
    level endon( #"watch_ticket_deaths_singleton" );
    
    while ( true )
    {
        waitresult = level waittill( "ticket_death" );
        
        if ( !isdefined( waitresult.team ) )
        {
            continue;
        }
        
        if ( waitresult.team == game.attackers )
        {
            level clientfield::increment_world_uimodel( "hudItems.war.attackingDeaths" );
        }
    }
}

// Namespace war/war
// Params 0, eflags: 0x4
// Checksum 0x48ca4621, Offset: 0x2020
// Size: 0x64
function private set_ui_team()
{
    wait 0.05;
    
    if ( game.attackers == "allies" )
    {
        clientfield::set_world_uimodel( "hudItems.war.attackingTeam", 1 );
        return;
    }
    
    clientfield::set_world_uimodel( "hudItems.war.attackingTeam", 2 );
}

// Namespace war/war
// Params 0
// Checksum 0xfee1a3d9, Offset: 0x2090
// Size: 0x354
function on_start_gametype()
{
    globallogic_utils::switch_sides();
    globallogic_score::resetteamscores();
    level.usestartspawns = 1;
    level.wartotalsecondsinzone = 0;
    level.wardialog = 1;
    game.strings[ "last_zone_captured" ] = &"MP_SCORE_LIMIT_REACHED";
    util::setobjectivetext( game.attackers, &"OBJECTIVES_WAR_ATTACKER" );
    util::setobjectivetext( game.defenders, &"OBJECTIVES_WAR_DEFENDER" );
    
    if ( level.splitscreen )
    {
        util::setobjectivescoretext( game.attackers, &"OBJECTIVES_WAR_ATTACKER" );
        util::setobjectivescoretext( game.defenders, &"OBJECTIVES_WAR_DEFENDER" );
    }
    else
    {
        util::setobjectivescoretext( game.attackers, &"OBJECTIVES_WAR_ATTACKER_SCORE" );
        util::setobjectivescoretext( game.defenders, &"OBJECTIVES_WAR_DEFENDER_SCORE" );
    }
    
    util::setobjectivehinttext( game.attackers, &"OBJECTIVES_WAR_ATTACKER_HINT" );
    util::setobjectivehinttext( game.defenders, &"OBJECTIVES_WAR_DEFENDER_HINT" );
    setclientnamemode( "auto_change" );
    influencers::create_map_placed_influencers();
    barrier_builder::setup_deployable_barriers();
    setup_zone_spawns( 0 );
    level.mapcenter = math::find_box_center( level.spawnmins, level.spawnmaxs );
    setmapcenter( level.mapcenter );
    spawnpoint = spawning::get_random_intermission_point();
    setdemointermissionpoint( spawnpoint.origin, spawnpoint.angles );
    level.spawn_all = spawning::get_spawnpoint_array( "mp_tdm_spawn" );
    
    if ( !level.spawn_all.size )
    {
        println( "^1No mp_tdm_spawn spawnpoints in level!" );
        callback::abort_level();
        return;
    }
    
    userspawnselection::supressspawnselectionmenuforallplayers();
    thread set_ui_team();
    thread setup_zones();
    update_gametype_dvars();
    thread run_zones();
}

// Namespace war/war
// Params 1
// Checksum 0x6685e473, Offset: 0x23f0
// Size: 0xf4
function open_zone_gate( zone_zero_based_index )
{
    gatetargetname = game.gatenameprefix + zone_zero_based_index;
    gateentity = getent( gatetargetname, "targetname" );
    
    if ( !isdefined( gateentity ) )
    {
        println( "Could not find gate with targetname " + gatetargetname );
        return;
    }
    
    neworigin = gateentity.origin - ( 0, 0, 500 );
    gateentity moveto( neworigin, 1 );
    println( "Lowering " + gatetargetname );
}

// Namespace war/war
// Params 0
// Checksum 0xf376e223, Offset: 0x24f0
// Size: 0x34
function pause_time()
{
    if ( level.timepauseswheninzone )
    {
        globallogic_utils::pausetimer();
        level.timerpaused = 1;
    }
}

// Namespace war/war
// Params 0
// Checksum 0x93cbe2bf, Offset: 0x2530
// Size: 0x44
function resume_time()
{
    if ( level.timepauseswheninzone )
    {
        globallogic_utils::resumetimerdiscardoverride( level.wartotalsecondsinzone * 1000 );
        level.timerpaused = 0;
    }
}

// Namespace war/war
// Params 0
// Checksum 0x586b61b7, Offset: 0x2580
// Size: 0x50
function update_gametype_dvars()
{
    level.playercapturelpm = getgametypesetting( "maxPlayerEventsPerMinute" );
    level.timepauseswheninzone = getgametypesetting( "timePausesWhenInZone" );
}

// Namespace war/war
// Params 2, eflags: 0x4
// Checksum 0x2107c5e5, Offset: 0x25d8
// Size: 0x16e
function private set_ui_zone_index( zone_index, advance_progress )
{
    if ( !isdefined( advance_progress ) )
    {
        advance_progress = 1;
    }
    
    if ( level.zones.size == zone_index )
    {
        clientfield::set_world_uimodel( "hudItems.war.currentZone", 0 );
        compass::setupminimapzone( 0 );
    }
    else
    {
        clientfield::set_world_uimodel( "hudItems.war.currentZone", zone_index + 1 );
        compass::setupminimapzone( zone_index + 1 );
    }
    
    clientfield::set_world_uimodel( "hudItems.war.currentZoneStartTime", int( level.time / 1000 ) );
    clientfield::set_world_uimodel( "hudItems.war.team1.progress", zone_index );
    game.stat[ "war.team1.progress" ] = zone_index;
    clientfield::set_world_uimodel( "hudItems.war.team2.progress", zone_index );
    game.stat[ "war.team2.progress" ] = zone_index;
}

// Namespace war/war
// Params 0, eflags: 0x4
// Checksum 0x400e9bda, Offset: 0x2750
// Size: 0xac
function private spawn_zone()
{
    zone = self;
    
    if ( !isdefined( zone ) )
    {
        return;
    }
    
    if ( isdefined( zone.start_mission ) )
    {
        [[ zone.start_mission ]]( zone );
    }
    
    setup_zone_spawns( zone.zone_index );
    set_ui_zone_index( zone.zone_index );
    open_zone_gate( zone.zone_index );
}

// Namespace war/war
// Params 1, eflags: 0x4
// Checksum 0xd7a3c526, Offset: 0x2808
// Size: 0x158
function private spawn_first_zone( delay )
{
    waitframe( 1 );
    level.zone = get_first_zone();
    level.zone spawn_zone();
    tickets::reset_tickets();
    zone_start_tickets = getgametypesetting( "ticketsGivenAtStageStart_0" );
    tickets::set_tickets( game.attackers, zone_start_tickets );
    
    if ( !isdefined( level.robot ) && getdvarint( "bg_warmode_version" ) > 1 )
    {
        trigger = getent( "escort_robot_move_trig", "targetname" );
        spawnposition = trigger.origin;
        spawnangles = ( 0, 0, 0 );
        level.robot = mission_escort::spawn_robot( spawnposition, spawnangles );
    }
}

// Namespace war/war
// Params 0, eflags: 0x4
// Checksum 0x594a44cd, Offset: 0x2968
// Size: 0x3c
function private spawn_next_zone()
{
    level.zone = get_next_zone();
    level.zone spawn_zone();
}

// Namespace war/war
// Params 3, eflags: 0x4
// Checksum 0x5792ccc5, Offset: 0x29b0
// Size: 0x94
function private show_stage_transition_ui( winningteam, winnersoutcometext, losersoutcometext )
{
    setmatchflag( "stage_ended", 1 );
    luinotifyevent( &"show_stage_completion_ui", 3, util::getteamenum( winningteam ), winnersoutcometext, losersoutcometext );
    wait 3;
    setmatchflag( "stage_ended", 0 );
}

// Namespace war/war
// Params 0
// Checksum 0x230982f7, Offset: 0x2a50
// Size: 0x5e0
function run_zones()
{
    while ( level.inprematchperiod )
    {
        waitframe( 1 );
    }
    
    spawn_first_zone();
    
    while ( true )
    {
        tickets::setup_mission_ticket_logic( game.attackers, level.prevzoneindex );
        level.war_mission_succeeded = 0;
        
        if ( is_last_zone( level.zone ) )
        {
            level.low_tickets_enabled = 1;
        }
        
        if ( isdefined( level.zone.main_loop ) )
        {
            [[ level.zone.main_loop ]]( level.zone );
        }
        
        if ( level.war_mission_succeeded === 1 )
        {
            winteam = game.attackers;
            defteam = game.defenders;
        }
        else
        {
            winteam = game.defenders;
            defteam = game.attackers;
        }
        
        tickets::set_tickets( winteam, 0 );
        tickets::set_tickets( defteam, 0 );
        tickets::award_stage_win( winteam, level.prevzoneindex );
        tickets::commit_tickets( winteam, level.prevzoneindex );
        populate_clientfields();
        show_stage_transition_ui( winteam, game.strings[ winteam + "_mission_win" ], game.strings[ defteam + "_mission_loss" ] );
        attacker_total_tickets = tickets::get_total_tickets( game.attackers, level.war_total_zones );
        defender_total_tickets = tickets::get_total_tickets( game.defenders, level.war_total_zones );
        win_count = int( level.zones.size / 2 ) + 1;
        play_all_rounds = getdvarint( "scr_play_all_rounds", 0 );
        
        if ( is_last_zone( level.zone ) )
        {
            update_team_scores();
            set_ui_zone_index( level.zones.size, level.war_mission_succeeded === 1 );
            
            if ( attacker_total_tickets > defender_total_tickets )
            {
                level thread globallogic::endgame( game.attackers, game.strings[ game.attackers + "_win" ] );
                return;
            }
            
            level thread globallogic::endgame( game.defenders, game.strings[ game.defenders + "_win" ] );
            return;
        }
        else if ( win_count && !play_all_rounds && attacker_total_tickets >= win_count )
        {
            update_team_scores();
            level thread globallogic::endgame( game.attackers, game.strings[ game.attackers + "_sweep" ] );
            return;
        }
        else if ( win_count && !play_all_rounds && defender_total_tickets >= win_count )
        {
            update_team_scores();
            level thread globallogic::endgame( game.defenders, game.strings[ game.defenders + "_sweep" ] );
            return;
        }
        else if ( !level.war_mission_succeeded )
        {
            defcompete = "warZ" + level.zone.zone_index + 1 + "CompleteDef";
            offail = "warZ" + level.zone.zone_index + 1 + "FailOfs";
            globallogic_audio::leader_dialog( offail, game.attackers, undefined, "objective" );
            globallogic_audio::leader_dialog( defcompete, game.defenders, undefined, "objective" );
        }
        
        if ( !level.gameended )
        {
            level notify( #"zone_reset" );
            spawn_next_zone();
        }
    }
}

// Namespace war/war
// Params 1
// Checksum 0x4518c4cd, Offset: 0x3038
// Size: 0xa4
function on_spawn_player( predictedspawn )
{
    while ( !isdefined( level.zone ) )
    {
        waitframe( 1 );
    }
    
    if ( level.usestartspawns && !level.ingraceperiod )
    {
        level.usestartspawns = 0;
    }
    
    if ( isdefined( level.zone.on_spawn_player ) )
    {
        [[ level.zone.on_spawn_player ]]( predictedspawn );
    }
    
    spawning::onspawnplayer( predictedspawn );
}

// Namespace war/war
// Params 0
// Checksum 0xda9f6850, Offset: 0x30e8
// Size: 0xe
function player_spawned_cb()
{
    self.lowermessageoverride = undefined;
}

// Namespace war/war
// Params 2
// Checksum 0x53c082bb, Offset: 0x3100
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
        println( "WAR: Missing script_index on zone at " + zone_a.origin );
        return true;
    }
    
    if ( isdefined( script_index_a ) && !isdefined( script_index_b ) )
    {
        println( "WAR: Missing script_index on zone at " + zone_b.origin );
        return false;
    }
    
    if ( script_index_a > script_index_b )
    {
        return true;
    }
    
    return false;
}

// Namespace war/war
// Params 0
// Checksum 0xd79621d4, Offset: 0x3218
// Size: 0x16e
function get_zone_array()
{
    zones = getentarray( "war_zone_center", "targetname" );
    
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

// Namespace war/war
// Params 1, eflags: 0x4
// Checksum 0x442619ff, Offset: 0x3390
// Size: 0x11c
function private setup_zone_spawns( zone_index )
{
    level.spawnmins = ( 0, 0, 0 );
    level.spawnmaxs = ( 0, 0, 0 );
    level.spawnsystem.sideswitching = 0;
    spawning::clear_spawn_points();
    zone_index += 1;
    spawning::add_spawn_points( game.attackers, "mp_war_spawn_attacker_zone_" + zone_index );
    spawning::add_spawn_points( game.defenders, "mp_war_spawn_defender_zone_" + zone_index );
    spawning::updateallspawnpoints();
    
    if ( level.usestartspawns )
    {
        spawning::add_start_spawn_points( game.attackers, "mp_war_spawn_attacker_zone_1_start" );
        spawning::add_start_spawn_points( game.defenders, "mp_war_spawn_defender_zone_1_start" );
    }
}

// Namespace war/war
// Params 0
// Checksum 0xb0213cc0, Offset: 0x34b8
// Size: 0x162, Type: bool
function setup_zones()
{
    zones = get_zone_array();
    level.zones = zones;
    level.zones[ 0 ].start_mission = &mission_koth::start;
    level.zones[ 1 ].start_mission = &mission_koth::start;
    level.zones[ 2 ].start_mission = &mission_koth::start;
    
    if ( getdvarint( "bg_warmode_version" ) > 1 )
    {
        level.zones[ 0 ].start_mission = &mission_koth::start;
        level.zones[ 1 ].start_mission = &mission_ctf::start;
        level.zones[ 2 ].start_mission = &mission_escort::start;
    }
    
    level.prevzone = undefined;
    level.prevzone2 = undefined;
    return true;
}

// Namespace war/war
// Params 1, eflags: 0x4
// Checksum 0x6af61057, Offset: 0x3628
// Size: 0x72, Type: bool
function private is_last_zone( zone )
{
    if ( !isdefined( level.zones ) )
    {
        return true;
    }
    
    if ( level.zones.size == 0 )
    {
        return true;
    }
    
    if ( level.zones[ level.zones.size - 1 ] == zone )
    {
        return true;
    }
    
    return false;
}

// Namespace war/war
// Params 0, eflags: 0x4
// Checksum 0x9449ad44, Offset: 0x36a8
// Size: 0x60
function private get_first_zone()
{
    zone = level.zones[ 0 ];
    level.prevzone2 = level.prevzone;
    level.prevzone = zone;
    level.prevzoneindex = 0;
    return zone;
}

// Namespace war/war
// Params 0, eflags: 0x4
// Checksum 0xb69fa1a9, Offset: 0x3710
// Size: 0x8c
function private get_next_zone()
{
    nextzoneindex = ( level.prevzoneindex + 1 ) % level.zones.size;
    zone = level.zones[ nextzoneindex ];
    level.prevzone2 = level.prevzone;
    level.prevzone = zone;
    level.prevzoneindex = nextzoneindex;
    return zone;
}

// Namespace war/war
// Params 0
// Checksum 0xb931c0f, Offset: 0x37a8
// Size: 0x2c
function on_round_switch()
{
    game.switchedsides = !game.switchedsides;
    userspawnselection::onroundchange();
}

// Namespace war/war
// Params 9
// Checksum 0x3312370b, Offset: 0x37e0
// Size: 0xec
function on_player_killed( einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration )
{
    if ( isdefined( level.forward_spawn_on_player_killed ) )
    {
        [[ level.forward_spawn_on_player_killed ]]( einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration );
    }
    
    if ( isdefined( level.zone.on_player_killed ) )
    {
        [[ level.zone.on_player_killed ]]( einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration );
    }
}

// Namespace war/war
// Params 1
// Checksum 0x8f07c354, Offset: 0x38d8
// Size: 0x96
function on_end_game( winningteam )
{
    for ( i = 0; i < level.zones.size ; i++ )
    {
        if ( isdefined( level.zones[ i ].gameobject ) )
        {
            level.zones[ i ].gameobject gameobjects::allow_use( "none" );
        }
    }
}

// Namespace war/war
// Params 0
// Checksum 0x80f724d1, Offset: 0x3978
// Size: 0x4
function create_zone_spawn_influencer()
{
    
}

