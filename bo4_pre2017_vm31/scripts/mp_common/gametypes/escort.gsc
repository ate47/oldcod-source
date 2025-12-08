#using scripts/core_common/ai/archetype_robot;
#using scripts/core_common/ai/archetype_utility;
#using scripts/core_common/ai/systems/blackboard;
#using scripts/core_common/ai/systems/gib;
#using scripts/core_common/ai_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/gameobjects_shared;
#using scripts/core_common/hostmigration_shared;
#using scripts/core_common/hud_util_shared;
#using scripts/core_common/influencers_shared;
#using scripts/core_common/lui_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/popups_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/spawning_shared;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/values_shared;
#using scripts/core_common/vehicleriders_shared;
#using scripts/core_common/weapons/heatseekingmissile;
#using scripts/core_common/weapons/weaponobjects;
#using scripts/mp_common/gametypes/ctf;
#using scripts/mp_common/gametypes/globallogic;
#using scripts/mp_common/gametypes/globallogic_audio;
#using scripts/mp_common/gametypes/globallogic_score;
#using scripts/mp_common/gametypes/globallogic_utils;
#using scripts/mp_common/gametypes/hostmigration;
#using scripts/mp_common/killstreaks/airsupport;
#using scripts/mp_common/killstreaks/killstreak_bundles;
#using scripts/mp_common/killstreaks/killstreaks;
#using scripts/mp_common/killstreaks/supplydrop;
#using scripts/mp_common/teams/teams;
#using scripts/mp_common/util;

#namespace escort;

// Namespace escort/escort
// Params 0, eflags: 0x2
// Checksum 0x853c50ce, Offset: 0x11f8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "escort", &__init__, undefined, undefined );
}

// Namespace escort/escort
// Params 0
// Checksum 0x669e75d8, Offset: 0x1238
// Size: 0x84
function __init__()
{
    clientfield::register( "actor", "robot_state", 1, 2, "int" );
    clientfield::register( "actor", "escort_robot_burn", 1, 1, "int" );
    callback::on_spawned( &on_player_spawned );
}

// Namespace escort/GameType_Init
// Params 1, eflags: 0x40
// Checksum 0x83f93c57, Offset: 0x12c8
// Size: 0x564
function event_handler[GameType_Init] main( eventstruct )
{
    globallogic::init();
    util::registertimelimit( 0, 1440 );
    util::registerroundscorelimit( 0, 2000 );
    util::registerscorelimit( 0, 5000 );
    util::registerroundlimit( 0, 12 );
    util::registerroundswitch( 0, 9 );
    util::registerroundwinlimit( 0, 10 );
    util::registernumlives( 0, 100 );
    level.boottime = getgametypesetting( "bootTime" );
    level.reboottime = getgametypesetting( "rebootTime" );
    level.rebootplayers = getgametypesetting( "rebootPlayers" );
    level.moveplayers = getgametypesetting( "movePlayers" );
    level.robotshield = getgametypesetting( "robotShield" );
    level.robotspeed = "run";
    
    switch ( getgametypesetting( "shutdownDamage" ) )
    {
        case 1:
            level.escortrobotkillstreakbundle = "escort_robot_low";
            break;
        case 2:
            level.escortrobotkillstreakbundle = "escort_robot";
            break;
        case 3:
            level.escortrobotkillstreakbundle = "escort_robot_high";
        case 0:
        default:
            level.shutdowndamage = 0;
            break;
    }
    
    if ( isdefined( level.escortrobotkillstreakbundle ) )
    {
        killstreak_bundles::register_killstreak_bundle( level.escortrobotkillstreakbundle );
        level.shutdowndamage = killstreak_bundles::get_max_health( level.escortrobotkillstreakbundle );
    }
    
    /#
        switch ( getdvarint( "<dev string:x28>", 1 ) )
        {
            case 1:
                level.robotspeed = "<dev string:x33>";
                break;
            case 2:
                level.robotspeed = "<dev string:x37>";
                break;
            case 0:
            default:
                level.robotspeed = "<dev string:x3e>";
                break;
        }
    #/
    
    globallogic_audio::set_leader_gametype_dialog( "startSafeguard", "hcStartSafeguard", "sfgStartAttack", "sfgStartDefend" );
    
    if ( !sessionmodeissystemlink() && !sessionmodeisonlinegame() && issplitscreen() )
    {
        globallogic::setvisiblescoreboardcolumns( "score", "kills", "escorts", "disables", "deaths" );
    }
    else
    {
        globallogic::setvisiblescoreboardcolumns( "score", "kills", "deaths", "escorts", "disables" );
    }
    
    level.teambased = 1;
    level.overrideteamscore = 1;
    level.scoreroundwinbased = 1;
    level.doubleovertime = 1;
    level.onprecachegametype = &onprecachegametype;
    level.onstartgametype = &onstartgametype;
    level.onspawnplayer = &onspawnplayer;
    level.onplayerkilled = &onplayerkilled;
    level.ontimelimit = &ontimelimit;
    level.onroundswitch = &onroundswitch;
    level.onendgame = &onendgame;
    level.shouldplayovertimeround = &shouldplayovertimeround;
    level.onroundendgame = &onroundendgame;
    gameobjects::register_allowed_gameobject( level.gametype );
    killstreak_bundles::register_killstreak_bundle( "escort_robot" );
}

// Namespace escort/escort
// Params 0
// Checksum 0x80f724d1, Offset: 0x1838
// Size: 0x4
function onprecachegametype()
{
    
}

// Namespace escort/escort
// Params 0
// Checksum 0xbc074078, Offset: 0x1848
// Size: 0x4bc
function onstartgametype()
{
    level.usestartspawns = 1;
    setclientnamemode( "auto_change" );
    globallogic_utils::switch_sides();
    util::setobjectivetext( game.attackers, &"OBJECTIVES_ESCORT_ATTACKER" );
    util::setobjectivetext( game.defenders, &"OBJECTIVES_ESCORT_DEFENDER" );
    util::setobjectivescoretext( game.attackers, &"OBJECTIVES_ESCORT_ATTACKER_SCORE" );
    util::setobjectivescoretext( game.defenders, &"OBJECTIVES_ESCORT_DEFENDER_SCORE" );
    util::setobjectivehinttext( game.attackers, &"OBJECTIVES_ESCORT_ATTACKER_HINT" );
    util::setobjectivehinttext( game.defenders, &"OBJECTIVES_ESCORT_DEFENDER_HINT" );
    
    if ( isdefined( game.overtime_round ) )
    {
        [[ level._setteamscore ]]( "allies", 0 );
        [[ level._setteamscore ]]( "axis", 0 );
        
        if ( isdefined( game.overtime_time_to_beat[ "escort" ] ) )
        {
            times = game.overtime_time_to_beat[ "escort" ] / 1000;
            timem = int( times ) / 60;
            util::registertimelimit( timem, timem );
        }
        
        if ( game.overtime_round == 1 )
        {
            level.ontimelimit = &function_944eb829;
            util::setobjectivehinttext( game.attackers, &"MP_ESCORT_OVERTIME_ROUND_1_ATTACKERS" );
            util::setobjectivehinttext( game.defenders, &"MP_ESCORT_OVERTIME_ROUND_1_DEFENDERS" );
        }
        else
        {
            level.ontimelimit = &function_ba513292;
            util::setobjectivehinttext( game.attackers, &"MP_ESCORT_OVERTIME_ROUND_2_TIE_ATTACKERS" );
            util::setobjectivehinttext( game.defenders, &"MP_ESCORT_OVERTIME_ROUND_2_TIE_DEFENDERS" );
        }
    }
    
    level.spawnmins = ( 0, 0, 0 );
    level.spawnmaxs = ( 0, 0, 0 );
    spawning::place_spawn_points( "mp_escort_spawn_attacker_start" );
    spawning::place_spawn_points( "mp_escort_spawn_defender_start" );
    spawning::add_start_spawn_points( "allies", "mp_escort_spawn_attacker_start" );
    spawning::add_start_spawn_points( "axis", "mp_escort_spawn_defender_start" );
    spawning::add_spawn_points( "allies", "mp_escort_spawn_attacker" );
    spawning::add_spawn_points( "axis", "mp_escort_spawn_defender" );
    spawning::add_fallback_spawnpoints( "allies", "mp_tdm_spawn" );
    spawning::add_fallback_spawnpoints( "axis", "mp_tdm_spawn" );
    spawning::updateallspawnpoints();
    spawning::update_fallback_spawnpoints();
    level.mapcenter = math::find_box_center( level.spawnmins, level.spawnmaxs );
    setmapcenter( level.mapcenter );
    spawnpoint = spawning::get_random_intermission_point();
    setdemointermissionpoint( spawnpoint.origin, spawnpoint.angles );
    level thread drop_robot();
}

// Namespace escort/escort
// Params 1
// Checksum 0x4c40cf9a, Offset: 0x1d10
// Size: 0x24
function onspawnplayer( predictedspawn )
{
    spawning::onspawnplayer( predictedspawn );
}

// Namespace escort/escort
// Params 9
// Checksum 0x7c13d6fe, Offset: 0x1d40
// Size: 0x194
function onplayerkilled( einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration )
{
    if ( !isdefined( attacker ) || attacker == self || !isplayer( attacker ) || attacker.team == self.team )
    {
        return;
    }
    
    if ( isdefined( attacker.escortingrobot ) && self.team == game.defenders && attacker.escortingrobot )
    {
        attacker recordgameevent( "attacking" );
        scoreevents::processscoreevent( "killed_defender", attacker );
        return;
    }
    
    if ( isdefined( self.escortingrobot ) && self.team == game.attackers && self.escortingrobot )
    {
        attacker recordgameevent( "defending" );
        scoreevents::processscoreevent( "killed_attacker", attacker );
    }
}

// Namespace escort/escort
// Params 0
// Checksum 0x72f835c4, Offset: 0x1ee0
// Size: 0x64
function ontimelimit()
{
    winner = game.defenders;
    globallogic_score::giveteamscoreforobjective_delaypostprocessing( winner, 1 );
    level thread globallogic::endgame( winner, game.strings[ "time_limit_reached" ] );
}

// Namespace escort/escort
// Params 0
// Checksum 0xe6d667c5, Offset: 0x1f50
// Size: 0x4c
function function_944eb829()
{
    winner = game.defenders;
    level thread globallogic::endgame( winner, game.strings[ "time_limit_reached" ] );
}

// Namespace escort/escort
// Params 0
// Checksum 0x7fcb4ce0, Offset: 0x1fa8
// Size: 0xb4
function function_ba513292()
{
    winner = game.defenders;
    var_44211b03 = game.overtime_first_winner[ "escort" ];
    
    if ( winner == var_44211b03 )
    {
        level thread globallogic::endgame( winner, game.strings[ "time_limit_reached" ] );
        return;
    }
    
    level thread globallogic::endgame( "tie", game.strings[ "time_limit_reached" ] );
}

// Namespace escort/escort
// Params 0
// Checksum 0x946b0b93, Offset: 0x2068
// Size: 0x1c
function onroundswitch()
{
    game.switchedsides = !game.switchedsides;
}

// Namespace escort/escort
// Params 1
// Checksum 0x1e73c329, Offset: 0x2090
// Size: 0x11c
function onendgame( winningteam )
{
    if ( isdefined( game.overtime_round ) )
    {
        if ( game.overtime_round == 1 )
        {
            game.overtime_first_winner[ "escort" ] = winningteam;
            
            if ( winningteam == game.defenders )
            {
                game.overtime_time_to_beat[ "escort" ] = undefined;
            }
            else
            {
                game.overtime_time_to_beat[ "escort" ] = globallogic_utils::gettimepassed();
            }
        }
        else
        {
            game.overtime_second_winner[ "escort" ] = winningteam;
            
            if ( isdefined( winningteam ) && winningteam != "tie" )
            {
                game.overtime_best_time[ "escort" ] = globallogic_utils::gettimepassed();
            }
        }
    }
    
    level.robot thread delete_on_endgame_sequence();
}

// Namespace escort/escort
// Params 0
// Checksum 0xe14cd5d3, Offset: 0x21b8
// Size: 0xbc, Type: bool
function shouldplayovertimeround()
{
    if ( isdefined( game.overtime_round ) )
    {
        if ( game.overtime_round == 1 || !level.gameended )
        {
            return true;
        }
        
        return false;
    }
    
    alliesroundswon = util::getroundswon( "allies" );
    axisroundswon = util::getroundswon( "axis" );
    
    if ( util::hitroundlimit() && alliesroundswon == axisroundswon )
    {
        return true;
    }
    
    return false;
}

// Namespace escort/escort
// Params 1
// Checksum 0x2197fff6, Offset: 0x2280
// Size: 0xea
function onroundendgame( winningteam )
{
    if ( isdefined( game.overtime_round ) )
    {
        foreach ( team in level.teams )
        {
            score = game.stat[ "roundswon" ][ team ];
            [[ level._setteamscore ]]( team, score );
        }
        
        return winningteam;
    }
    
    return globallogic::determineteamwinnerbyteamscore();
}

// Namespace escort/escort
// Params 0
// Checksum 0xe01b39a8, Offset: 0x2378
// Size: 0xe
function on_player_spawned()
{
    self.escortingrobot = undefined;
}

// Namespace escort/escort
// Params 0
// Checksum 0x3ba4b4ae, Offset: 0x2390
// Size: 0x904
function drop_robot()
{
    globallogic::waitforplayers();
    movetrigger = getent( "escort_robot_move_trig", "targetname" );
    patharray = get_robot_path_array();
    startdir = patharray[ 0 ] - movetrigger.origin;
    startangles = vectortoangles( startdir );
    drop_origin = movetrigger.origin;
    drop_height = isdefined( level.escort_drop_height ) ? level.escort_drop_height : supplydrop::getdropheight( drop_origin );
    heli_drop_goal = ( drop_origin[ 0 ], drop_origin[ 1 ], drop_height );
    goalpath = undefined;
    dropoffset = ( 0, -120, 0 );
    goalpath = supplydrop::supplydrophelistartpath_v2_setup( heli_drop_goal, dropoffset );
    supplydrop::supplydrophelistartpath_v2_part2_local( heli_drop_goal, goalpath, dropoffset );
    drop_direction = vectortoangles( ( heli_drop_goal[ 0 ], heli_drop_goal[ 1 ], 0 ) - ( goalpath.start[ 0 ], goalpath.start[ 1 ], 0 ) );
    chopper = spawnhelicopter( getplayers()[ 0 ], heli_drop_goal, ( 0, 0, 0 ), "combat_escort_robot_dropship", "" );
    chopper.maxhealth = 999999;
    chopper.health = 999999;
    chopper.spawntime = gettime();
    supplydropspeed = isdefined( level.escort_drop_speed ) ? level.escort_drop_speed : getdvarint( "scr_supplydropSpeedStarting", 1000 );
    supplydropaccel = isdefined( level.escort_drop_accel ) ? level.escort_drop_accel : getdvarint( "scr_supplydropAccelStarting", 1000 );
    chopper setspeed( supplydropspeed, supplydropaccel );
    maxpitch = getdvarint( "scr_supplydropMaxPitch", 25 );
    maxroll = getdvarint( "scr_supplydropMaxRoll", 45 );
    chopper setmaxpitchroll( 0, maxroll );
    spawnposition = ( 0, 0, 0 );
    spawnangles = ( 0, 0, 0 );
    level.robot = spawn_robot( spawnposition, spawnangles );
    level.robot.onground = undefined;
    level.robot.team = game.attackers;
    level.robot setforcenocull();
    level.robot vehicle::get_in( chopper, "driver", 1 );
    level.robot.dropundervehicleoriginoverride = 1;
    level.robot.targetangles = startangles;
    chopper vehicle::unload( "all" );
    level.robot playsound( "evt_safeguard_robot_land" );
    chopper thread drop_heli_leave();
    
    while ( level.robot flagsys::get( "in_vehicle" ) )
    {
        wait 1;
    }
    
    level.robot.patharray = patharray;
    level.robot.pathindex = 0;
    level.robot.victimsoundmod = "safeguard_robot";
    level.robot.goaljustblocked = 0;
    level.robot thread update_stop_position();
    level.robot thread watch_robot_damaged();
    level.robot thread wait_robot_moving();
    level.robot thread wait_robot_stopped();
    level.robot.spawn_influencer_friendly = level.robot influencers::create_entity_friendly_influencer( "escort_robot_attackers", game.attackers );
    
    /#
        debug_draw_robot_path();
        level thread debug_reset_robot_to_start();
    #/
    
    level.moveobject = setup_move_object( level.robot, "escort_robot_move_trig" );
    level.goalobject = setup_goal_object( level.robot, "escort_robot_goal_trig" );
    setup_reboot_object( level.robot, "escort_robot_reboot_trig" );
    
    if ( level.boottime )
    {
        level.robot clientfield::set( "robot_state", 2 );
        level.moveobject gameobjects::set_flags( 2 );
        level.robot setblackboardattribute( "_stance", "crouch" );
        level.robot ai::set_behavior_attribute( "rogue_control_speed", level.robotspeed );
        level.robot shutdown_robot();
    }
    else
    {
        objective_setprogress( level.moveobject.objectiveid, 1 );
        level.moveobject gameobjects::allow_use( "friendly" );
    }
    
    level.robot thread wait_robot_shutdown();
    level.robot thread wait_robot_reboot();
    
    while ( level.inprematchperiod )
    {
        waitframe( 1 );
    }
    
    level.robot.onground = 1;
    
    if ( level.boottime )
    {
        level.robot thread auto_reboot_robot( level.boottime );
        return;
    }
    
    if ( level.moveplayers == 0 )
    {
        level.robot move_robot();
    }
}

// Namespace escort/escort
// Params 0
// Checksum 0x2876d165, Offset: 0x2ca0
// Size: 0xec
function drop_heli_leave()
{
    chopper = self;
    wait 1;
    supplydropspeed = getdvarint( "scr_supplydropSpeedLeaving", 250 );
    supplydropaccel = getdvarint( "scr_supplydropAccelLeaving", 60 );
    chopper setspeed( supplydropspeed, supplydropaccel );
    goalpath = supplydrop::supplydropheliendpath_v2( chopper.origin );
    chopper airsupport::followpath( goalpath.path, undefined, 0 );
    chopper delete();
}

/#

    // Namespace escort/escort
    // Params 0
    // Checksum 0x82edc4e4, Offset: 0x2d98
    // Size: 0x1ca, Type: dev
    function debug_draw_robot_path()
    {
        if ( ( isdefined( getdvarint( "<dev string:x43>" ) ) ? getdvarint( "<dev string:x43>" ) : 0 ) == 0 )
        {
            return;
        }
        
        debug_duration = 999999999;
        pathnodes = level.robot.patharray;
        
        for ( i = 0; i < pathnodes.size - 1 ; i++ )
        {
            currnode = pathnodes[ i ];
            nextnode = pathnodes[ i + 1 ];
            util::debug_line( currnode, nextnode, ( 0, 0.9, 0 ), 0.9, 0, debug_duration );
        }
        
        foreach ( path in pathnodes )
        {
            util::debug_sphere( path, 6, ( 0, 0, 0.9 ), 0.9, debug_duration );
        }
    }

    // Namespace escort/escort
    // Params 1
    // Checksum 0xac23413d, Offset: 0x2f70
    // Size: 0x1c2, Type: dev
    function debug_draw_approximate_robot_path_to_goal( &goalpatharray )
    {
        if ( ( isdefined( getdvarint( "<dev string:x43>" ) ) ? getdvarint( "<dev string:x43>" ) : 0 ) == 0 )
        {
            return;
        }
        
        debug_duration = 60;
        pathnodes = goalpatharray;
        
        for ( i = 0; i < pathnodes.size - 1 ; i++ )
        {
            currnode = pathnodes[ i ];
            nextnode = pathnodes[ i + 1 ];
            util::debug_line( currnode, nextnode, ( 0.9, 0.9, 0 ), 0.9, 0, debug_duration );
        }
        
        foreach ( path in pathnodes )
        {
            util::debug_sphere( path, 3, ( 0, 0.5, 0.5 ), 0.9, debug_duration );
        }
    }

    // Namespace escort/escort
    // Params 1
    // Checksum 0x288e48ab, Offset: 0x3140
    // Size: 0xac, Type: dev
    function debug_draw_current_robot_goal( goal )
    {
        if ( ( isdefined( getdvarint( "<dev string:x43>" ) ) ? getdvarint( "<dev string:x43>" ) : 0 ) == 0 )
        {
            return;
        }
        
        if ( isdefined( goal ) )
        {
            debug_duration = 60;
            util::debug_sphere( goal, 8, ( 0, 0.9, 0 ), 0.9, debug_duration );
        }
    }

    // Namespace escort/escort
    // Params 1
    // Checksum 0x83fb74e6, Offset: 0x31f8
    // Size: 0xb4, Type: dev
    function debug_draw_find_immediate_goal( pathgoal )
    {
        if ( ( isdefined( getdvarint( "<dev string:x43>" ) ) ? getdvarint( "<dev string:x43>" ) : 0 ) == 0 )
        {
            return;
        }
        
        if ( isdefined( pathgoal ) )
        {
            debug_duration = 60;
            util::debug_sphere( pathgoal + ( 0, 0, 18 ), 6, ( 0.9, 0, 0 ), 0.9, debug_duration );
        }
    }

    // Namespace escort/escort
    // Params 1
    // Checksum 0x25d792, Offset: 0x32b8
    // Size: 0xb4, Type: dev
    function debug_draw_find_immediate_goal_override( immediategoal )
    {
        if ( ( isdefined( getdvarint( "<dev string:x43>" ) ) ? getdvarint( "<dev string:x43>" ) : 0 ) == 0 )
        {
            return;
        }
        
        if ( isdefined( immediategoal ) )
        {
            debug_duration = 60;
            util::debug_sphere( immediategoal + ( 0, 0, 18 ), 6, ( 0.9, 0, 0.9 ), 0.9, debug_duration );
        }
    }

    // Namespace escort/escort
    // Params 2
    // Checksum 0xd363ea20, Offset: 0x3378
    // Size: 0xfc, Type: dev
    function debug_draw_blocked_path_kill_radius( center, radius )
    {
        if ( ( isdefined( getdvarint( "<dev string:x43>" ) ) ? getdvarint( "<dev string:x43>" ) : 0 ) == 0 )
        {
            return;
        }
        
        if ( isdefined( center ) )
        {
            debug_duration = 200;
            circle( center + ( 0, 0, 2 ), radius, ( 0.9, 0, 0 ), 1, 1, debug_duration );
            circle( center + ( 0, 0, 4 ), radius, ( 0.9, 0, 0 ), 1, 1, debug_duration );
        }
    }

#/

// Namespace escort/escort
// Params 0
// Checksum 0xea8b7360, Offset: 0x3480
// Size: 0x88
function wait_robot_moving()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( "robot_moving" );
        self recordgameeventnonplayer( "robot_start" );
        self clientfield::set( "robot_state", 1 );
        level.moveobject gameobjects::set_flags( 1 );
    }
}

// Namespace escort/escort
// Params 0
// Checksum 0x5086021b, Offset: 0x3510
// Size: 0x98
function wait_robot_stopped()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( "robot_stopped" );
        
        if ( self.active )
        {
            self recordgameeventnonplayer( "robot_stop" );
            self clientfield::set( "robot_state", 0 );
            level.moveobject gameobjects::set_flags( 0 );
        }
    }
}

// Namespace escort/escort
// Params 0
// Checksum 0x84e7586a, Offset: 0x35b0
// Size: 0x198
function wait_robot_shutdown()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( "robot_shutdown" );
        level.moveobject gameobjects::allow_use( "none" );
        objective_setprogress( level.moveobject.objectiveid, -0.05 );
        self clientfield::set( "robot_state", 2 );
        level.moveobject gameobjects::set_flags( 2 );
        otherteam = util::getotherteam( self.team );
        globallogic_audio::leader_dialog( "sfgRobotDisabledAttacker", self.team, undefined, "robot" );
        globallogic_audio::leader_dialog( "sfgRobotDisabledDefender", otherteam, undefined, "robot" );
        globallogic_audio::play_2d_on_team( "mpl_safeguard_disabled_sting_friend", self.team );
        globallogic_audio::play_2d_on_team( "mpl_safeguard_disabled_sting_enemy", otherteam );
        self thread auto_reboot_robot( level.reboottime );
    }
}

// Namespace escort/escort
// Params 0
// Checksum 0xa80e3745, Offset: 0x3750
// Size: 0x1e8
function wait_robot_reboot()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( "robot_reboot" );
        self recordgameeventnonplayer( "robot_repair_complete" );
        level.moveobject gameobjects::allow_use( "friendly" );
        otherteam = util::getotherteam( self.team );
        globallogic_audio::leader_dialog( "sfgRobotRebootedAttacker", self.team, undefined, "robot" );
        globallogic_audio::leader_dialog( "sfgRobotRebootedDefender", otherteam, undefined, "robot" );
        globallogic_audio::play_2d_on_team( "mpl_safeguard_reboot_sting_friend", self.team );
        globallogic_audio::play_2d_on_team( "mpl_safeguard_reboot_sting_enemy", otherteam );
        objective_setprogress( level.moveobject.objectiveid, 1 );
        
        if ( level.moveplayers == 0 )
        {
            self move_robot();
            continue;
        }
        
        if ( level.moveobject.numtouching[ level.moveobject.ownerteam ] == 0 )
        {
            self clientfield::set( "robot_state", 0 );
            level.moveobject gameobjects::set_flags( 0 );
        }
    }
}

// Namespace escort/escort
// Params 1
// Checksum 0x6c38162, Offset: 0x3940
// Size: 0x25c
function auto_reboot_robot( time )
{
    self endon( #"robot_reboot" );
    self endon( #"game_ended" );
    shutdowntime = 0;
    
    while ( shutdowntime < time )
    {
        rate = 0;
        friendlycount = level.moveobject.numtouching[ level.moveobject.ownerteam ];
        
        if ( !level.rebootplayers )
        {
            rate = 0.05;
        }
        else if ( friendlycount > 0 )
        {
            rate = 0.05;
            
            if ( friendlycount > 1 )
            {
                bonusrate = ( friendlycount - 1 ) * 0.05 * 0;
                rate += bonusrate;
            }
        }
        
        if ( rate > 0 )
        {
            shutdowntime += rate;
            percent = min( 1, shutdowntime / time );
            objective_setprogress( level.moveobject.objectiveid, percent );
        }
        
        waitframe( 1 );
    }
    
    if ( level.rebootplayers > 0 )
    {
        foreach ( struct in level.moveobject.touchlist[ game.attackers ] )
        {
            scoreevents::processscoreevent( "escort_robot_reboot", struct.player );
        }
    }
    
    self thread reboot_robot();
}

// Namespace escort/escort
// Params 0
// Checksum 0x12b4604b, Offset: 0x3ba8
// Size: 0x170
function watch_robot_damaged()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( "robot_damaged" );
        percent = min( 1, self.shutdowndamage / level.shutdowndamage );
        objective_setprogress( level.moveobject.objectiveid, 1 - percent );
        health = level.shutdowndamage - self.shutdowndamage;
        lowhealth = killstreak_bundles::get_low_health( level.escortrobotkillstreakbundle );
        
        if ( !( isdefined( self.playeddamage ) && self.playeddamage ) && health <= lowhealth )
        {
            globallogic_audio::leader_dialog( "sfgRobotUnderFire", self.team, undefined, "robot" );
            self.playeddamage = 1;
            continue;
        }
        
        if ( health > lowhealth )
        {
            self.playeddamage = 0;
        }
    }
}

// Namespace escort/escort
// Params 0
// Checksum 0x5fb175d5, Offset: 0x3d20
// Size: 0x34
function delete_on_endgame_sequence()
{
    self endon( #"death" );
    level waittill( "endgame_sequence" );
    self delete();
}

// Namespace escort/escort
// Params 0
// Checksum 0xb91decec, Offset: 0x3d60
// Size: 0x13c
function get_robot_path_array()
{
    if ( isdefined( level.escortrobotpath ) )
    {
        println( "<dev string:x5f>" );
        return level.escortrobotpath;
    }
    
    println( "<dev string:x82>" );
    patharray = [];
    currnode = getnode( "escort_robot_path_start", "targetname" );
    patharray[ patharray.size ] = currnode.origin;
    
    while ( isdefined( currnode.target ) )
    {
        currnode = getnode( currnode.target, "targetname" );
        patharray[ patharray.size ] = currnode.origin;
    }
    
    if ( isdefined( level.update_escort_robot_path ) )
    {
        [[ level.update_escort_robot_path ]]( patharray );
    }
    
    return patharray;
}

/#

    // Namespace escort/escort
    // Params 2
    // Checksum 0x71bc618d, Offset: 0x3ea8
    // Size: 0xbc, Type: dev
    function calc_robot_path_length( robotorigin, patharray )
    {
        distance = 0;
        lastpoint = robotorigin;
        
        for ( i = 0; i < patharray.size ; i++ )
        {
            distance += distance( lastpoint, patharray[ i ] );
            lastpoint = patharray[ i ];
        }
        
        println( "<dev string:x96>" + distance );
    }

#/

// Namespace escort/escort
// Params 2
// Checksum 0x2d7197bc, Offset: 0x3f70
// Size: 0x438
function spawn_robot( position, angles )
{
    robot = spawnactor( "spawner_bo3_robot_grunt_assault_mp_escort", position, angles, "", 1 );
    robot ai::set_behavior_attribute( "rogue_allow_pregib", 0 );
    robot ai::set_behavior_attribute( "rogue_allow_predestruct", 0 );
    robot ai::set_behavior_attribute( "rogue_control", "forced_level_2" );
    robot ai::set_behavior_attribute( "rogue_control_speed", level.robotspeed );
    robot val::set( "escort_robot", "ignoreall", 1 );
    robot.allowdeath = 0;
    robot ai::set_behavior_attribute( "can_become_crawler", 0 );
    robot ai::set_behavior_attribute( "can_be_meleed", 0 );
    robot ai::set_behavior_attribute( "can_initiateaivsaimelee", 0 );
    robot ai::set_behavior_attribute( "traversals", "procedural" );
    aiutility::clearaioverridedamagecallbacks( robot );
    robot.active = 1;
    robot.canwalk = 1;
    robot.moving = 0;
    robot.shutdowndamage = 0;
    robot.propername = "";
    robot.ignoretriggerdamage = 1;
    robot.allowpain = 0;
    robot clientfield::set( "robot_mind_control", 0 );
    robot ai::set_behavior_attribute( "robot_lights", 3 );
    robot.pushable = 0;
    robot collidewithactors( 1 );
    robot pushplayer( 1 );
    robot setavoidancemask( "avoid none" );
    robot disableaimassist();
    robot setsteeringmode( "slow steering" );
    robot setblackboardattribute( "_robot_locomotion_type", "alt1" );
    
    if ( level.robotshield )
    {
        aiutility::attachriotshield( robot, getweapon( "riotshield" ), "wpn_t7_shield_riot_world_lh", "tag_stowed_back" );
    }
    
    robot asmsetanimationrate( 1.1 );
    
    if ( isdefined( level.shutdowndamage ) && level.shutdowndamage )
    {
        target_set( robot, ( 0, 0, 50 ) );
    }
    
    robot.overrideactordamage = &robot_damage;
    robot thread robot_move_chatter();
    robot.missiletargetmissdistance = 64;
    robot thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile();
    return robot;
}

// Namespace escort/escort
// Params 12
// Checksum 0x692bd454, Offset: 0x43b0
// Size: 0x724, Type: bool
function robot_damage( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex )
{
    if ( !( isdefined( self.onground ) && self.onground ) )
    {
        return false;
    }
    
    if ( level.shutdowndamage <= 0 || !self.active || eattacker.team == game.attackers )
    {
        return false;
    }
    
    level.usestartspawns = 0;
    weapon_damage = killstreak_bundles::get_weapon_damage( level.escortrobotkillstreakbundle, level.shutdowndamage, eattacker, weapon, smeansofdeath, idamage, idflags, undefined );
    
    if ( !isdefined( weapon_damage ) )
    {
        weapon_damage = idamage;
    }
    
    if ( !weapon_damage )
    {
        return false;
    }
    
    self.shutdowndamage += weapon_damage;
    self notify( #"robot_damaged" );
    
    if ( !isdefined( eattacker.damagerobot ) )
    {
        eattacker.damagerobot = 0;
    }
    
    eattacker.damagerobot += weapon_damage;
    
    if ( self.shutdowndamage >= level.shutdowndamage )
    {
        origin = ( 0, 0, 0 );
        
        if ( isplayer( eattacker ) )
        {
            level thread popups::displayteammessagetoall( &"MP_ESCORT_ROBOT_DISABLED", eattacker );
            level.robot recordgameeventnonplayer( "robot_disabled" );
            
            if ( distance2dsquared( self.origin, level.goalobject.trigger.origin ) < ( level.goalobject.trigger.radius + 50 ) * ( level.goalobject.trigger.radius + 50 ) )
            {
                scoreevents::processscoreevent( "escort_robot_disable_near_goal", eattacker );
            }
            else
            {
                scoreevents::processscoreevent( "escort_robot_disable", eattacker );
            }
            
            if ( isdefined( eattacker.pers[ "disables" ] ) )
            {
                eattacker.pers[ "disables" ]++;
                eattacker.disables = eattacker.pers[ "disables" ];
            }
            
            eattacker addplayerstatwithgametype( "DISABLES", 1 );
            eattacker recordgameevent( "return" );
            origin = eattacker.origin;
        }
        
        foreach ( player in level.players )
        {
            if ( player == eattacker || player.team == self.team || !isdefined( player.damagerobot ) )
            {
                continue;
            }
            
            damagepercent = player.damagerobot / level.shutdowndamage;
            
            if ( damagepercent >= 0.5 )
            {
                scoreevents::processscoreevent( "escort_robot_disable_assist_50", player );
            }
            else if ( damagepercent >= 0.25 )
            {
                scoreevents::processscoreevent( "escort_robot_disable_assist_25", player );
            }
            
            player.damagerobot = undefined;
        }
        
        bbprint( "mpobjective", "gametime %d objtype %s team %s playerx %d playery %d playerz %d", gettime(), "escort_shutdown", game.defenders, origin );
        self shutdown_robot();
        
        if ( isdefined( eattacker ) && eattacker != self && isdefined( weapon ) )
        {
            if ( weapon.name == "planemortar" )
            {
                if ( !isdefined( eattacker.planemortarbda ) )
                {
                    eattacker.planemortarbda = 0;
                }
                
                eattacker.planemortarbda++;
            }
            else if ( weapon.name == "dart" || weapon.name == "dart_turret" )
            {
                if ( !isdefined( eattacker.dartbda ) )
                {
                    eattacker.dartbda = 0;
                }
                
                eattacker.dartbda++;
            }
            else if ( weapon.name == "straferun_rockets" || weapon.name == "straferun_gun" )
            {
                if ( isdefined( eattacker.straferunbda ) )
                {
                    eattacker.straferunbda++;
                }
            }
            else if ( weapon.name == "remote_missile_missile" || weapon.name == "remote_missile_bomblet" )
            {
                if ( !isdefined( eattacker.remotemissilebda ) )
                {
                    eattacker.remotemissilebda = 0;
                }
                
                eattacker.remotemissilebda++;
            }
        }
    }
    
    self.health += 1;
    return true;
}

// Namespace escort/escort
// Params 12
// Checksum 0x36596151, Offset: 0x4ae0
// Size: 0x66, Type: bool
function robot_damage_none( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex )
{
    return false;
}

// Namespace escort/escort
// Params 0
// Checksum 0x1d2ca9dc, Offset: 0x4b50
// Size: 0x14c
function shutdown_robot()
{
    self.active = 0;
    self val::set( "escort_robot_shutdown", "ignoreme", 1 );
    self.canwalk = 0;
    self stop_robot();
    self notify( #"robot_shutdown" );
    
    if ( target_istarget( self ) )
    {
        target_remove( self );
    }
    
    if ( isdefined( self.riotshield ) )
    {
        self asmchangeanimmappingtable( 1 );
        self detach( self.riotshield.model, self.riotshield.tag );
        aiutility::attachriotshield( self, getweapon( "riotshield" ), "wpn_t7_shield_riot_world_lh", "tag_weapon_left" );
    }
    
    self ai::set_behavior_attribute( "shutdown", 1 );
}

// Namespace escort/escort
// Params 0
// Checksum 0x7c7258e1, Offset: 0x4ca8
// Size: 0x18c
function reboot_robot()
{
    self endon( #"robot_shutdown" );
    level endon( #"game_ended" );
    self.active = 1;
    self.shutdowndamage = 0;
    self val::reset( "escort_robot_shutdown", "ignoreme" );
    self notify( #"robot_reboot" );
    
    if ( isdefined( level.shutdowndamage ) && level.shutdowndamage )
    {
        target_set( self, ( 0, 0, 50 ) );
    }
    
    if ( isdefined( self.riotshield ) )
    {
        self asmchangeanimmappingtable( 0 );
        self detach( self.riotshield.model, self.riotshield.tag );
        aiutility::attachriotshield( self, getweapon( "riotshield" ), "wpn_t7_shield_riot_world_lh", "tag_stowed_back" );
    }
    
    self ai::set_behavior_attribute( "shutdown", 0 );
    wait getanimlength( "ai_robot_rogue_ctrl_crc_shutdown_2_alert" );
    self.canwalk = 1;
}

// Namespace escort/escort
// Params 0
// Checksum 0xd5624f19, Offset: 0x4e40
// Size: 0xc4
function move_robot()
{
    if ( self.active == 0 || self.moving || !isdefined( self.pathindex ) )
    {
        return;
    }
    
    if ( self check_blocked_goal_and_kill() )
    {
        return;
    }
    
    if ( gettime() < ( isdefined( self.blocked_wait_end_time ) ? self.blocked_wait_end_time : 0 ) )
    {
        return;
    }
    
    self notify( #"robot_moving" );
    self.moving = 1;
    self set_goal_to_point_on_path();
    self thread robot_wait_next_point();
}

// Namespace escort/escort
// Params 0
// Checksum 0x101d2df9, Offset: 0x4f10
// Size: 0x34
function get_current_goal()
{
    return isdefined( self.immediategoaloverride ) ? self.immediategoaloverride : self.patharray[ self.pathindex ];
}

// Namespace escort/escort
// Params 1
// Checksum 0x29ec92d2, Offset: 0x4f50
// Size: 0x110, Type: bool
function reached_closest_nav_mesh_goal_but_still_too_far_and_blocked( goalonnavmesh )
{
    if ( isdefined( self.immediategoaloverride ) )
    {
        return false;
    }
    
    distsqr = distancesquared( goalonnavmesh, self.origin );
    robotreachedclosestgoalonnavmesh = distsqr <= 24 * 24;
    
    if ( robotreachedclosestgoalonnavmesh )
    {
        closestgoalonnavmeshtoofarfrompathgoal = distancesquared( goalonnavmesh, self.patharray[ self.pathindex ] ) > 1 * 1;
        
        if ( closestgoalonnavmeshtoofarfrompathgoal )
        {
            robotisblockedfromgettingtopathgoal = self check_if_goal_is_blocked( self.origin, self.patharray[ self.pathindex ] );
            
            if ( robotisblockedfromgettingtopathgoal )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace escort/escort
// Params 0
// Checksum 0x9be09763, Offset: 0x5068
// Size: 0x1cc
function check_blocked_goal_and_kill()
{
    if ( !self.canwalk )
    {
        return 0;
    }
    
    if ( gettime() < ( isdefined( self.blocked_wait_end_time ) ? self.blocked_wait_end_time : 0 ) )
    {
        wait ( self.blocked_wait_end_time - gettime() ) / 1000;
    }
    
    goalonnavmesh = self get_closest_point_on_nav_mesh_for_current_goal();
    previousgoal = self.pathindex > 0 && !isdefined( self.immediategoaloverride ) ? self.patharray[ self.pathindex - 1 ] : self.origin;
    
    if ( self.goaljustblocked || self reached_closest_nav_mesh_goal_but_still_too_far_and_blocked( goalonnavmesh ) || self check_if_goal_is_blocked( previousgoal, goalonnavmesh ) )
    {
        self.goaljustblocked = 0;
        stillblocked = 1;
        killedsomething = self kill_anything_blocking_goal( goalonnavmesh );
        
        if ( killedsomething )
        {
            stillblocked = self check_if_goal_is_blocked( previousgoal, goalonnavmesh );
            
            if ( stillblocked )
            {
                self.blocked_wait_end_time = gettime() + 200;
                self stop_robot();
            }
        }
        else
        {
            self find_immediate_goal();
        }
        
        return stillblocked;
    }
    
    return 0;
}

// Namespace escort/escort
// Params 0
// Checksum 0x59e214c1, Offset: 0x5240
// Size: 0x11c
function find_immediate_goal()
{
    pathgoal = self.patharray[ self.pathindex ];
    currpos = self.origin;
    
    /#
        debug_draw_find_immediate_goal( pathgoal );
    #/
    
    for ( immediategoal = get_closest_point_on_nav_mesh( vectorlerp( currpos, pathgoal, 0.5 ) ); self check_if_goal_is_blocked( currpos, immediategoal ) ; immediategoal = get_closest_point_on_nav_mesh( vectorlerp( currpos, immediategoal, 0.5 ) ) )
    {
    }
    
    self.immediategoaloverride = immediategoal;
    
    /#
        debug_draw_find_immediate_goal_override( self.immediategoaloverride );
    #/
}

// Namespace escort/escort
// Params 2
// Checksum 0x7abbdffe, Offset: 0x5368
// Size: 0xc4
function check_if_goal_is_blocked( previousgoal, goal )
{
    approxpatharray = self calcapproximatepathtoposition( goal );
    distancetonextgoal = min( distance( self.origin, goal ), distance( previousgoal, goal ) );
    approxpathtoolong = is_path_distance_to_goal_too_long( approxpatharray, distancetonextgoal * 2.5 );
    return approxpathtoolong;
}

// Namespace escort/escort
// Params 1
// Checksum 0xf6808a0a, Offset: 0x5438
// Size: 0x12e
function watch_goal_becoming_blocked( goal )
{
    self notify( #"end_watch_goal_becoming_blocked_singleton" );
    self endon( #"end_watch_goal_becoming_blocked_singleton" );
    self endon( #"robot_stopped" );
    self endon( #"goal" );
    level endon( #"game_ended" );
    disttogoalsqr = 1e+09;
    
    while ( true )
    {
        wait 0.1;
        
        if ( isdefined( self.traversestartnode ) )
        {
            self waittill( "traverse_end" );
            continue;
        }
        
        if ( self asmistransdecrunning() )
        {
            continue;
        }
        
        if ( !self.canwalk )
        {
            continue;
        }
        
        newdisttogoalsqr = distancesquared( self.origin, goal );
        
        if ( newdisttogoalsqr < disttogoalsqr )
        {
            disttogoalsqr = newdisttogoalsqr;
            continue;
        }
        
        self.goaljustblocked = 1;
        self notify( #"goal_blocked" );
    }
}

// Namespace escort/escort
// Params 0
// Checksum 0xc1298108, Offset: 0x5570
// Size: 0x13c
function watch_becoming_blocked_at_goal()
{
    self notify( #"end_watch_becoming_blocked_at_goal" );
    self endon( #"end_watch_becoming_blocked_at_goal" );
    self endon( #"robot_stop" );
    level endon( #"game_ended" );
    
    while ( isdefined( self.traversestartnode ) )
    {
        self waittill( "traverse_end" );
    }
    
    self.watch_becoming_blocked_at_goal_established = 1;
    startpos = self.origin;
    atsameposcount = 0;
    iterationcount = 0;
    
    while ( self.moving )
    {
        wait 0.1;
        
        if ( distancesquared( startpos, self.origin ) < 1 )
        {
            atsameposcount++;
        }
        
        if ( atsameposcount >= 2 )
        {
            self.goaljustblocked = 1;
            self notify( #"goal_blocked" );
        }
        
        iterationcount++;
        
        if ( iterationcount >= 3 )
        {
            break;
        }
    }
    
    self.watch_becoming_blocked_at_goal_established = 0;
}

// Namespace escort/escort
// Params 0
// Checksum 0x21f77119, Offset: 0x56b8
// Size: 0x13a
function stop_robot()
{
    if ( !self.moving )
    {
        return;
    }
    
    if ( isdefined( self.traversestartnode ) )
    {
        self thread check_robot_on_travesal_end();
        return;
    }
    
    self.moving = 0;
    self.mostrecentclosestpathpointgoal = undefined;
    self.watch_becoming_blocked_at_goal_established = 0;
    velocity = self getvelocity();
    deltapos = velocity * 0.05;
    stopgoal = isdefined( getclosestpointonnavmesh( self.origin + deltapos, 48, 15 ) ) ? getclosestpointonnavmesh( self.origin + deltapos, 48, 15 ) : self.origin;
    self setgoal( stopgoal, 0 );
    self notify( #"robot_stopped" );
}

// Namespace escort/escort
// Params 0
// Checksum 0xeb6f4bba, Offset: 0x5800
// Size: 0xec
function check_robot_on_travesal_end()
{
    self notify( #"check_robot_on_travesal_end_singleton" );
    self endon( #"check_robot_on_travesal_end_singleton" );
    self endon( #"death" );
    self waittill( "traverse_end" );
    numowners = isdefined( level.moveobject.numtouching[ level.moveobject.ownerteam ] ) ? level.moveobject.numtouching[ level.moveobject.ownerteam ] : 0;
    
    if ( numowners < level.moveplayers )
    {
        self stop_robot();
        return;
    }
    
    self move_robot();
}

// Namespace escort/escort
// Params 0
// Checksum 0xfa9af009, Offset: 0x58f8
// Size: 0x68
function update_stop_position()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( "traverse_end" );
        
        if ( !self.moving )
        {
            self setgoal( self.origin, 1 );
        }
    }
}

// Namespace escort/escort
// Params 0
// Checksum 0x27a065b0, Offset: 0x5968
// Size: 0x280
function robot_wait_next_point()
{
    self endon( #"robot_stopped" );
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( "goal", "goal_blocked" );
        
        if ( !isdefined( self.watch_becoming_blocked_at_goal_established ) || self.watch_becoming_blocked_at_goal_established == 0 )
        {
            self thread watch_becoming_blocked_at_goal();
        }
        
        if ( distancesquared( self.origin, get_current_goal() ) < 24 * 24 )
        {
            self.pathindex += isdefined( self.immediategoaloverride ) ? 0 : 1;
            self.immediategoaloverride = undefined;
        }
        
        while ( self.pathindex < self.patharray.size && distancesquared( self.origin, self.patharray[ self.pathindex ] ) < ( 48 + 1 ) * ( 48 + 1 ) )
        {
            self.pathindex++;
        }
        
        if ( self.pathindex >= self.patharray.size )
        {
            self.pathindex = undefined;
            self stop_robot();
            return;
        }
        
        if ( self.pathindex + 1 >= self.patharray.size )
        {
            otherteam = util::getotherteam( self.team );
            globallogic_audio::leader_dialog( "sfgRobotCloseAttacker", self.team, undefined, "robot" );
            globallogic_audio::leader_dialog( "sfgRobotCloseDefender", otherteam, undefined, "robot" );
        }
        
        if ( self check_blocked_goal_and_kill() )
        {
            self stop_robot();
        }
        
        set_goal_to_point_on_path();
    }
}

// Namespace escort/escort
// Params 0
// Checksum 0x9201a4b4, Offset: 0x5bf0
// Size: 0x8e
function get_closest_point_on_nav_mesh_for_current_goal()
{
    immediategoal = get_current_goal();
    closestpathpoint = getclosestpointonnavmesh( immediategoal, 48, 15 );
    
    if ( !isdefined( closestpathpoint ) )
    {
        closestpathpoint = getclosestpointonnavmesh( immediategoal, 96, 15 );
    }
    
    return isdefined( closestpathpoint ) ? closestpathpoint : immediategoal;
}

// Namespace escort/escort
// Params 1
// Checksum 0xcbd6d029, Offset: 0x5c88
// Size: 0x118
function get_closest_point_on_nav_mesh( point )
{
    closestpathpoint = getclosestpointonnavmesh( point, 48, 15 );
    
    if ( !isdefined( closestpathpoint ) )
    {
        closestpathpoint = getclosestpointonnavmesh( point, 96, 15 );
    }
    
    if ( !isdefined( closestpathpoint ) )
    {
        itercount = 0;
        lowerpoint = point - ( 0, 0, 36 );
        
        while ( !isdefined( closestpathpoint ) && itercount < 5 )
        {
            closestpathpoint = getclosestpointonnavmesh( lowerpoint, 48, 15 );
            lowerpoint -= ( 0, 0, 36 );
            itercount++;
        }
    }
    
    return isdefined( closestpathpoint ) ? closestpathpoint : point;
}

// Namespace escort/escort
// Params 1
// Checksum 0xc2a53a33, Offset: 0x5da8
// Size: 0x154
function set_goal_to_point_on_path( recursioncount )
{
    if ( !isdefined( recursioncount ) )
    {
        recursioncount = 0;
    }
    
    self.goaljustblocked = 0;
    closestpathpoint = self get_closest_point_on_nav_mesh_for_current_goal();
    
    if ( isdefined( closestpathpoint ) )
    {
        if ( !isdefined( self.mostrecentclosestpathpointgoal ) || distancesquared( closestpathpoint, self.mostrecentclosestpathpointgoal ) > 1 )
        {
            self setgoal( closestpathpoint, 0, 24 );
            self thread watch_goal_becoming_blocked( closestpathpoint );
            self.mostrecentclosestpathpointgoal = closestpathpoint;
        }
    }
    else if ( recursioncount < 3 )
    {
        self find_immediate_goal();
        self set_goal_to_point_on_path( recursioncount + 1 );
    }
    else
    {
        self stop_robot();
    }
    
    /#
        debug_draw_current_robot_goal( closestpathpoint );
    #/
}

// Namespace escort/escort
// Params 2
// Checksum 0x6a914bbf, Offset: 0x5f08
// Size: 0xea, Type: bool
function is_path_distance_to_goal_too_long( &patharray, toolongthreshold )
{
    /#
        debug_draw_approximate_robot_path_to_goal( patharray );
    #/
    
    if ( toolongthreshold < 20 )
    {
        toolongthreshold = 20;
    }
    
    goaldistance = 0;
    lastindextocheck = patharray.size - 1;
    
    for ( i = 0; i < lastindextocheck ; i++ )
    {
        goaldistance += distance( patharray[ i ], patharray[ i + 1 ] );
        
        if ( goaldistance >= toolongthreshold )
        {
            return true;
        }
    }
    
    return false;
}

/#

    // Namespace escort/escort
    // Params 0
    // Checksum 0x2917f2e9, Offset: 0x6000
    // Size: 0x248, Type: dev
    function debug_reset_robot_to_start()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( ( isdefined( getdvarint( "<dev string:xab>" ) ) ? getdvarint( "<dev string:xab>" ) : 0 ) > 0 )
            {
                if ( isdefined( level.robot ) )
                {
                    pathindex = ( isdefined( getdvarint( "<dev string:xab>" ) ) ? getdvarint( "<dev string:xab>" ) : 0 ) - 1;
                    pathpoint = level.robot.patharray[ pathindex ];
                    robotangles = ( 0, 0, 0 );
                    
                    if ( pathindex < level.robot.patharray.size - 1 )
                    {
                        nextpoint = level.robot.patharray[ pathindex + 1 ];
                        robotangles = vectortoangles( nextpoint - pathpoint );
                    }
                    
                    level.robot forceteleport( pathpoint, robotangles );
                    level.robot.pathindex = pathindex;
                    level.robot.immediategoaloverride = undefined;
                    
                    while ( isdefined( self.traversestartnode ) )
                    {
                        waitframe( 1 );
                    }
                    
                    level.robot stop_robot();
                    level.robot setgoal( level.robot.origin, 0 );
                }
                
                setdvar( "<dev string:xab>", 0 );
            }
            
            wait 0.5;
        }
    }

#/

// Namespace escort/escort
// Params 0
// Checksum 0xcccfd439, Offset: 0x6250
// Size: 0x26c
function explode_robot()
{
    self clientfield::set( "escort_robot_burn", 1 );
    clientfield::set( "robot_mind_control_explosion", 1 );
    self thread wait_robot_corpse();
    
    if ( randomint( 100 ) >= 50 )
    {
        gibserverutils::gibleftarm( self );
    }
    else
    {
        gibserverutils::gibrightarm( self );
    }
    
    gibserverutils::giblegs( self );
    gibserverutils::gibhead( self );
    velocity = self getvelocity() * 0.125;
    self startragdoll();
    self launchragdoll( ( velocity[ 0 ] + randomfloatrange( -20, 20 ), velocity[ 1 ] + randomfloatrange( -20, 20 ), randomfloatrange( 60, 80 ) ), "j_mainroot" );
    playfxontag( "weapon/fx_c4_exp_metal", self, "tag_origin" );
    
    if ( target_istarget( self ) )
    {
        target_remove( self );
    }
    
    physicsexplosionsphere( self.origin, 200, 1, 1, 1, 1 );
    radiusdamage( self.origin, 200, 1, 1, undefined, "MOD_EXPLOSIVE" );
    playrumbleonposition( "grenade_rumble", self.origin );
}

// Namespace escort/escort
// Params 0
// Checksum 0xceb1c879, Offset: 0x64c8
// Size: 0x5c
function wait_robot_corpse()
{
    archetype = self.archetype;
    waitresult = self waittill( "actor_corpse" );
    waitresult.corpse clientfield::set( "escort_robot_burn", 1 );
}

// Namespace escort/escort
// Params 0
// Checksum 0x4c8a9dbc, Offset: 0x6530
// Size: 0x70
function robot_move_chatter()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( self.moving )
        {
            self playsoundontag( "vox_robot_chatter", "J_Head" );
        }
        
        wait randomfloatrange( 1.5, 2.5 );
    }
}

// Namespace escort/escort
// Params 2
// Checksum 0x63284119, Offset: 0x65a8
// Size: 0x22c
function setup_move_object( robot, triggername )
{
    trigger = getent( triggername, "targetname" );
    useobj = gameobjects::create_use_object( game.attackers, trigger, [], ( 0, 0, 0 ), &"escort_robot" );
    useobj gameobjects::set_objective_entity( robot );
    useobj gameobjects::allow_use( "none" );
    useobj gameobjects::set_visible_team( "any" );
    useobj gameobjects::set_use_time( 0 );
    trigger enablelinkto();
    trigger linkto( robot );
    useobj.onuse = &on_use_robot_move;
    useobj.onupdateuserate = &on_update_use_rate_robot_move;
    useobj.robot = robot;
    
    if ( isdefined( level.levelescortdisable ) )
    {
        if ( !isdefined( useobj.exclusions ) )
        {
            useobj.exclusions = [];
        }
        
        foreach ( trigger in level.levelescortdisable )
        {
            useobj.exclusions[ useobj.exclusions.size ] = trigger;
        }
    }
    
    return useobj;
}

// Namespace escort/escort
// Params 1
// Checksum 0x804a8178, Offset: 0x67e0
// Size: 0x9c
function on_use_robot_move( player )
{
    level.usestartspawns = 0;
    
    if ( self.robot.moving || !self.robot.active || self.numtouching[ self.ownerteam ] < level.moveplayers )
    {
        return;
    }
    
    self thread track_escorting_players();
    self.robot move_robot();
}

// Namespace escort/escort
// Params 3
// Checksum 0x7d15910f, Offset: 0x6888
// Size: 0x6c
function on_update_use_rate_robot_move( team, progress, change )
{
    numowners = self.numtouching[ self.ownerteam ];
    
    if ( numowners < level.moveplayers )
    {
        self.robot stop_robot();
    }
}

// Namespace escort/escort
// Params 0
// Checksum 0x66b61511, Offset: 0x6900
// Size: 0x10c
function track_escorting_players()
{
    level endon( #"game_ended" );
    self.robot endon( #"robot_stopped" );
    
    while ( true )
    {
        foreach ( touch in self.touchlist[ self.team ] )
        {
            if ( !( isdefined( touch.player.escortingrobot ) && touch.player.escortingrobot ) )
            {
                self thread track_escort_time( touch.player );
            }
        }
        
        waitframe( 1 );
    }
}

// Namespace escort/escort
// Params 1
// Checksum 0x7198bf84, Offset: 0x6a18
// Size: 0x244
function track_escort_time( player )
{
    level endon( #"game_ended" );
    player endon( #"death" );
    self.robot endon( #"robot_shutdown" );
    player.escortingrobot = 1;
    player recordgameevent( "player_escort_start" );
    self thread wait_escort_death( player );
    self thread wait_escort_shutdown( player );
    consecutiveescorts = 0;
    
    while ( true )
    {
        wait 1;
        touching = 0;
        
        foreach ( touch in self.touchlist[ self.team ] )
        {
            if ( touch.player == player )
            {
                touching = 1;
                break;
            }
        }
        
        if ( !touching )
        {
            break;
        }
        
        if ( isdefined( player.pers[ "escorts" ] ) )
        {
            player.pers[ "escorts" ]++;
            player.escorts = player.pers[ "escorts" ];
        }
        
        player addplayerstatwithgametype( "ESCORTS", 1 );
        consecutiveescorts++;
        
        if ( consecutiveescorts % 3 == 0 )
        {
            scoreevents::processscoreevent( "escort_robot_escort", player );
        }
    }
    
    player player_stop_escort();
}

// Namespace escort/escort
// Params 0
// Checksum 0xe1e65b77, Offset: 0x6c68
// Size: 0x3a
function player_stop_escort()
{
    self.escortingrobot = 0;
    self recordgameevent( "player_escort_stop" );
    self notify( #"escorting_stopped" );
}

// Namespace escort/escort
// Params 1
// Checksum 0xa9e3ab89, Offset: 0x6cb0
// Size: 0x54
function wait_escort_death( player )
{
    level endon( #"game_ended" );
    player endon( #"escorting_stopped" );
    player waittill( "death" );
    player thread player_stop_escort();
}

// Namespace escort/escort
// Params 1
// Checksum 0xe8c36776, Offset: 0x6d10
// Size: 0x54
function wait_escort_shutdown( player )
{
    level endon( #"game_ended" );
    player endon( #"escorting_stopped" );
    self.robot waittill( "robot_shutdown" );
    player thread player_stop_escort();
}

// Namespace escort/escort
// Params 2
// Checksum 0x75fd2db2, Offset: 0x6d70
// Size: 0x64
function setup_reboot_object( robot, triggername )
{
    trigger = getent( triggername, "targetname" );
    
    if ( isdefined( trigger ) )
    {
        trigger delete();
    }
}

// Namespace escort/escort
// Params 2
// Checksum 0xd80b045e, Offset: 0x6de0
// Size: 0x188
function setup_goal_object( robot, triggername )
{
    trigger = getent( triggername, "targetname" );
    useobj = gameobjects::create_use_object( game.defenders, trigger, [], ( 0, 0, 0 ), &"escort_goal" );
    useobj gameobjects::set_visible_team( "any" );
    useobj gameobjects::allow_use( "none" );
    useobj gameobjects::set_use_time( 0 );
    fwd = ( 0, 0, 1 );
    right = ( 0, -1, 0 );
    useobj.fx = spawnfx( "ui/fx_dom_marker_team_r120", trigger.origin, fwd, right );
    useobj.fx.team = game.defenders;
    triggerfx( useobj.fx, 0.001 );
    useobj thread watch_robot_enter( robot );
    return useobj;
}

// Namespace escort/escort
// Params 1
// Checksum 0x8d6c6ae3, Offset: 0x6f70
// Size: 0x2d0
function watch_robot_enter( robot )
{
    robot endon( #"death" );
    level endon( #"game_ended" );
    radiussq = self.trigger.radius * self.trigger.radius;
    
    while ( true )
    {
        if ( robot.moving === 1 && distance2dsquared( self.trigger.origin, robot.origin ) < radiussq )
        {
            level.moveplayers = 0;
            robot.overrideactordamage = &robot_damage_none;
            
            if ( target_istarget( self ) )
            {
                target_remove( self );
            }
            
            attackers = game.attackers;
            self.fx.team = attackers;
            
            foreach ( player in level.aliveplayers[ attackers ] )
            {
                if ( isdefined( player.escortingrobot ) && player.escortingrobot )
                {
                    scoreevents::processscoreevent( "escort_robot_escort_goal", player );
                }
            }
            
            level.robot recordgameeventnonplayer( "robot_reached_objective" );
            setgameendtime( 0 );
            robot val::set( "escort_robot", "ignoreme", 1 );
            robot thread explode_robot_after_wait( 1 );
            globallogic_score::giveteamscoreforobjective( attackers, 1 );
            level thread globallogic::endgame( attackers, game.strings[ attackers + "_mission_accomplished" ] );
            return;
        }
        
        waitframe( 1 );
    }
}

// Namespace escort/escort
// Params 1
// Checksum 0x39edb827, Offset: 0x7248
// Size: 0x44
function explode_robot_after_wait( wait_time )
{
    robot = self;
    wait wait_time;
    
    if ( isdefined( robot ) )
    {
        robot explode_robot();
    }
}

// Namespace escort/escort
// Params 1
// Checksum 0xb2f9f4c4, Offset: 0x7298
// Size: 0x44c
function kill_anything_blocking_goal( goal )
{
    self endon( #"end_kill_anything" );
    self.disablefinalkillcam = 1;
    dirtogoal = vectornormalize( goal - self.origin );
    atleastonedestroyed = 0;
    bestcandidate = undefined;
    bestcandidatedot = -1e+09;
    
    /#
        debug_draw_blocked_path_kill_radius( self.origin, 108 );
    #/
    
    entities = getdamageableentarray( self.origin, 108 );
    
    foreach ( entity in entities )
    {
        if ( isplayer( entity ) )
        {
            continue;
        }
        
        if ( entity == self )
        {
            continue;
        }
        
        if ( entity.classname == "grenade" )
        {
            continue;
        }
        
        if ( !isalive( entity ) )
        {
            continue;
        }
        
        entitydot = vectordot( dirtogoal, entity.origin - self.origin );
        
        if ( entitydot > bestcandidatedot )
        {
            bestcandidate = entity;
            bestcandidatedot = entitydot;
        }
    }
    
    if ( isdefined( bestcandidate ) )
    {
        entity = bestcandidate;
        
        if ( isdefined( entity.targetname ) )
        {
            if ( entity.targetname == "talon" )
            {
                entity notify( #"death" );
                return 1;
            }
        }
        
        if ( isdefined( entity.helitype ) && entity.helitype == "qrdrone" )
        {
            watcher = entity.owner weaponobjects::getweaponobjectwatcher( "qrdrone" );
            watcher thread weaponobjects::waitanddetonate( entity, 0, undefined );
            return 1;
        }
        
        if ( entity.classname == "auto_turret" )
        {
            if ( !isdefined( entity.damagedtodeath ) || !entity.damagedtodeath )
            {
                entity util::domaxdamage( self.origin + ( 0, 0, 1 ), self, self, 0, "MOD_CRUSH" );
            }
            
            return 1;
        }
        
        if ( !isdefined( entity.team ) || isvehicle( entity ) && entity.team != "neutral" )
        {
            entity kill();
            return 1;
        }
        
        entity dodamage( entity.health * 2, self.origin + ( 0, 0, 1 ), self, self, 0, "MOD_CRUSH" );
        atleastonedestroyed = 1;
    }
    
    atleastonedestroyed = atleastonedestroyed || self destroy_supply_crate_blocking_goal( dirtogoal );
    return atleastonedestroyed;
}

// Namespace escort/escort
// Params 1
// Checksum 0x6d04ab53, Offset: 0x76f0
// Size: 0x1e4, Type: bool
function destroy_supply_crate_blocking_goal( dirtogoal )
{
    crates = getentarray( "care_package", "script_noteworthy" );
    bestcrate = undefined;
    bestcrateedot = -1e+09;
    
    foreach ( crate in crates )
    {
        if ( distancesquared( crate.origin, self.origin ) > 108 * 108 )
        {
            continue;
        }
        
        cratedot = vectordot( dirtogoal, crate.origin - self.origin );
        
        if ( cratedot > bestcrateedot )
        {
            bestcrate = crate;
            bestcrateedot = cratedot;
        }
    }
    
    if ( isdefined( bestcrate ) )
    {
        playfx( level._supply_drop_explosion_fx, bestcrate.origin );
        playsoundatposition( "wpn_grenade_explode", bestcrate.origin );
        wait 0.1;
        bestcrate supplydrop::cratedelete();
        return true;
    }
    
    return false;
}

