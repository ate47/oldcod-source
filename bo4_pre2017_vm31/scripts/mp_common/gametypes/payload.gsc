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

#namespace payload;

// Namespace payload/GameType_Init
// Params 1, eflags: 0x40
// Checksum 0x74f78fa, Offset: 0x1020
// Size: 0x694
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
    register_clientfields();
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
    
    callback::on_spawned( &on_player_spawned );
    
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
    gameobjects::register_allowed_gameobject( "escort" );
    killstreak_bundles::register_killstreak_bundle( "escort_robot" );
    settings_bundle = getscriptbundle( "mission_settings_escort" );
    
    if ( isdefined( settings_bundle ) )
    {
        level.mission_bundle = settings_bundle;
    }
    else
    {
        level.mission_bundle = getscriptbundle( "mission_settings_core" );
    }
    
    level.anim_rate = float( level.mission_bundle.msarate );
    
    if ( !isdefined( level.anim_rate ) )
    {
        level.anim_rate = 1.1;
    }
    
    level.var_b21ad92e = 1000;
    level.var_e9a03050 = 0;
}

// Namespace payload/payload
// Params 0
// Checksum 0x510358d4, Offset: 0x16c0
// Size: 0x64
function register_clientfields()
{
    clientfield::register( "actor", "robot_state", 1, 2, "int" );
    clientfield::register( "actor", "escort_robot_burn", 1, 1, "int" );
}

// Namespace payload/payload
// Params 0
// Checksum 0x80f724d1, Offset: 0x1730
// Size: 0x4
function onprecachegametype()
{
    
}

// Namespace payload/payload
// Params 0
// Checksum 0xe9f472f5, Offset: 0x1740
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
    level thread function_e3faa4b2();
}

// Namespace payload/payload
// Params 0
// Checksum 0x4ad6100f, Offset: 0x1c08
// Size: 0x394
function function_e3faa4b2()
{
    globallogic::waitforplayers();
    
    if ( !isdefined( level.robot ) )
    {
        trigger = getent( "escort_robot_move_trig", "targetname" );
        spawnposition = trigger.origin;
        spawnangles = ( 0, 0, 0 );
        level.robot = spawn_robot( spawnposition, spawnangles );
    }
    
    patharray = get_robot_path_array();
    level.robot.team = game.attackers;
    level.robot setforcenocull();
    level.robot playsound( "evt_safeguard_robot_land" );
    level.robot.patharray = patharray;
    level.robot.pathindex = 0;
    level.robot.victimsoundmod = "safeguard_robot";
    level.robot.goaljustblocked = 0;
    level.robot thread update_stop_position();
    level.robot.spawn_influencer_friendly = level.robot influencers::create_entity_friendly_influencer( "escort_robot_attackers", game.attackers );
    
    /#
        debug_draw_robot_path();
        level thread debug_reset_robot_to_start();
    #/
    
    level.moveobject = setup_move_object( level.robot, "escort_robot_move_trig" );
    level.goalobject = setup_goal_object( level.robot, "escort_robot_goal_trig" );
    level.robot.var_2d727ac6 = calc_robot_path_length( patharray[ 0 ], patharray );
    objective_setprogress( level.moveobject.objectiveid, 1 );
    level.moveobject gameobjects::set_flags( 0 );
    level.robot.active = 0;
    level.robot.canmove = 0;
    level.robot stop_robot();
    level.robot thread auto_reboot_robot( level.boottime );
    level.robot thread function_164911c();
}

// Namespace payload/payload
// Params 1
// Checksum 0x2125e6e, Offset: 0x1fa8
// Size: 0x24
function onspawnplayer( predictedspawn )
{
    spawning::onspawnplayer( predictedspawn );
}

// Namespace payload/payload
// Params 9
// Checksum 0x3863a09c, Offset: 0x1fd8
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

// Namespace payload/payload
// Params 0
// Checksum 0x507740b6, Offset: 0x2178
// Size: 0x64
function ontimelimit()
{
    winner = game.defenders;
    globallogic_score::giveteamscoreforobjective_delaypostprocessing( winner, 1 );
    level thread globallogic::endgame( winner, game.strings[ "time_limit_reached" ] );
}

// Namespace payload/payload
// Params 0
// Checksum 0x93498982, Offset: 0x21e8
// Size: 0x4c
function function_944eb829()
{
    winner = game.defenders;
    level thread globallogic::endgame( winner, game.strings[ "time_limit_reached" ] );
}

// Namespace payload/payload
// Params 0
// Checksum 0xa55a948, Offset: 0x2240
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

// Namespace payload/payload
// Params 0
// Checksum 0xe72ffa21, Offset: 0x2300
// Size: 0x1c
function onroundswitch()
{
    game.switchedsides = !game.switchedsides;
}

// Namespace payload/payload
// Params 1
// Checksum 0xb46d04d9, Offset: 0x2328
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

// Namespace payload/payload
// Params 0
// Checksum 0xa7c1c2ec, Offset: 0x2450
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

// Namespace payload/payload
// Params 1
// Checksum 0x1f7cf887, Offset: 0x2518
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

// Namespace payload/payload
// Params 0
// Checksum 0xfd330f63, Offset: 0x2610
// Size: 0x1c
function on_player_spawned()
{
    self.escortingrobot = undefined;
    self.var_b43e6c91 = 0;
}

/#

    // Namespace payload/payload
    // Params 0
    // Checksum 0xffa0af50, Offset: 0x2638
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

    // Namespace payload/payload
    // Params 1
    // Checksum 0x1edf7f8b, Offset: 0x2810
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

    // Namespace payload/payload
    // Params 1
    // Checksum 0x3428acd1, Offset: 0x29e0
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

    // Namespace payload/payload
    // Params 1
    // Checksum 0xded21012, Offset: 0x2a98
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

    // Namespace payload/payload
    // Params 1
    // Checksum 0xd8e73eb2, Offset: 0x2b58
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

    // Namespace payload/payload
    // Params 2
    // Checksum 0xe94ab898, Offset: 0x2c18
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

// Namespace payload/payload
// Params 1
// Checksum 0x6bed2777, Offset: 0x2d20
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

// Namespace payload/payload
// Params 0
// Checksum 0xdca1547d, Offset: 0x2f88
// Size: 0x34
function delete_on_endgame_sequence()
{
    self endon( #"death" );
    level waittill( "endgame_sequence" );
    self delete();
}

// Namespace payload/payload
// Params 0
// Checksum 0x8f98a41e, Offset: 0x2fc8
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

// Namespace payload/payload
// Params 2
// Checksum 0xa5c47380, Offset: 0x3110
// Size: 0xbc
function calc_robot_path_length( robotorigin, patharray )
{
    /#
        distance = 0;
        lastpoint = robotorigin;
        
        for ( i = 0; i < patharray.size ; i++ )
        {
            distance += distance( lastpoint, patharray[ i ] );
            lastpoint = patharray[ i ];
        }
        
        println( "<dev string:x96>" + distance );
    #/
}

// Namespace payload/payload
// Params 2
// Checksum 0x38e9f242, Offset: 0x31d8
// Size: 0x388
function spawn_robot( position, angles )
{
    robot = spawnactor( "spawner_bo3_robot_grunt_assault_mp_escort", position, angles, "", 1 );
    robot ai::set_behavior_attribute( "rogue_allow_pregib", 0 );
    robot ai::set_behavior_attribute( "rogue_allow_predestruct", 0 );
    robot ai::set_behavior_attribute( "rogue_control", "forced_level_2" );
    robot ai::set_behavior_attribute( "rogue_control_speed", level.robotspeed );
    robot val::set( "payload_robot", "ignoreall", 1 );
    robot.allowdeath = 0;
    robot ai::set_behavior_attribute( "can_become_crawler", 0 );
    robot ai::set_behavior_attribute( "can_be_meleed", 0 );
    robot ai::set_behavior_attribute( "can_initiateaivsaimelee", 0 );
    robot ai::set_behavior_attribute( "traversals", "procedural" );
    aiutility::clearaioverridedamagecallbacks( robot );
    robot.canwalk = 1;
    robot.shutdowndamage = 0;
    robot.propername = "";
    robot.ignoretriggerdamage = 1;
    robot.allowpain = 0;
    robot ai::set_behavior_attribute( "robot_lights", 3 );
    robot.pushable = 0;
    robot collidewithactors( 1 );
    robot pushplayer( 1 );
    robot setavoidancemask( "avoid none" );
    robot disableaimassist();
    robot setsteeringmode( "slow steering" );
    robot setblackboardattribute( "_robot_locomotion_type", "alt1" );
    robot asmsetanimationrate( level.anim_rate );
    
    if ( isdefined( level.shutdowndamage ) && level.shutdowndamage )
    {
        target_set( robot, ( 0, 0, 50 ) );
    }
    
    robot.overrideactordamage = &robot_damage;
    robot thread robot_move_chatter();
    return robot;
}

// Namespace payload/payload
// Params 12
// Checksum 0x1c69acde, Offset: 0x3568
// Size: 0x624, Type: bool
function robot_damage( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex )
{
    if ( level.shutdowndamage <= 0 || !isdefined( self.active ) || !self.active || eattacker.team == game.attackers )
    {
        return false;
    }
    
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
    
    if ( !isdefined( eattacker.damagerobot ) )
    {
        eattacker.damagerobot = 0;
    }
    
    eattacker.damagerobot += weapon_damage;
    percent = min( 1, self.shutdowndamage / level.shutdowndamage );
    objective_setprogress( level.moveobject.objectiveid, 1 - percent );
    health = level.shutdowndamage - self.shutdowndamage;
    lowhealth = killstreak_bundles::get_low_health( level.escortrobotkillstreakbundle );
    
    if ( !( isdefined( self.playeddamage ) && self.playeddamage ) && health <= lowhealth )
    {
        globallogic_audio::leader_dialog( "sfgRobotUnderFire", game.attackers, undefined, "robot" );
        self.playeddamage = 1;
    }
    else if ( health > lowhealth )
    {
        self.playeddamage = 0;
    }
    
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
            origin = eattacker.origin;
        }
        
        foreach ( player in level.players )
        {
            if ( player == eattacker || player.team == game.attackers || !isdefined( player.damagerobot ) )
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
        
        self shutdown_robot();
    }
    
    self.health += 1;
    return true;
}

// Namespace payload/payload
// Params 12
// Checksum 0xd37cd8db, Offset: 0x3b98
// Size: 0x66, Type: bool
function robot_damage_none( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex )
{
    return false;
}

// Namespace payload/payload
// Params 0
// Checksum 0x6d5dc281, Offset: 0x3c08
// Size: 0x1fc
function shutdown_robot()
{
    self.active = 0;
    self.canmove = 0;
    self val::set( "payload_robot_shutdown", "ignoreme", 1 );
    self stop_robot();
    self notify( #"robot_shutdown" );
    level.moveobject gameobjects::allow_use( "none" );
    objective_setprogress( level.moveobject.objectiveid, -0.05 );
    level.moveobject gameobjects::set_flags( 2 );
    globallogic_audio::leader_dialog( "warRobotDisableOfsV2", game.attackers, undefined, "robot" );
    globallogic_audio::leader_dialog( "warRobotDisableDefV2", game.defenders, undefined, "robot" );
    globallogic_audio::play_2d_on_team( "mpl_safeguard_disabled_sting_friend", game.attackers );
    globallogic_audio::play_2d_on_team( "mpl_safeguard_disabled_sting_enemy", game.defenders );
    
    if ( target_istarget( self ) )
    {
        target_remove( self );
    }
    
    self ai::set_behavior_attribute( "shutdown", 1 );
    self thread auto_reboot_robot( level.reboottime );
}

// Namespace payload/payload
// Params 0
// Checksum 0x4e667eda, Offset: 0x3e10
// Size: 0x18c
function reboot_robot()
{
    self endon( #"robot_shutdown" );
    level endon( #"game_ended" );
    self.active = 1;
    self.shutdowndamage = 0;
    self val::reset( "payload_robot_shutdown", "ignoreme" );
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
    self.canmove = 1;
}

// Namespace payload/payload
// Params 0
// Checksum 0x5f07d52a, Offset: 0x3fa8
// Size: 0xcc
function move_robot()
{
    if ( level.moveobject gameobjects::get_flags( 1 ) )
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
    
    level.moveobject gameobjects::set_flags( 1 );
    self.moving = 1;
    self set_goal_to_point_on_path();
    self thread robot_wait_next_point();
}

// Namespace payload/payload
// Params 0
// Checksum 0xb1919793, Offset: 0x4080
// Size: 0x34
function get_current_goal()
{
    return isdefined( self.immediategoaloverride ) ? self.immediategoaloverride : self.patharray[ self.pathindex ];
}

// Namespace payload/payload
// Params 1
// Checksum 0x132574d4, Offset: 0x40c0
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

// Namespace payload/payload
// Params 0
// Checksum 0x9520d4a9, Offset: 0x41d8
// Size: 0x1bc
function check_blocked_goal_and_kill()
{
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

// Namespace payload/payload
// Params 0
// Checksum 0x64da41ca, Offset: 0x43a0
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

// Namespace payload/payload
// Params 2
// Checksum 0x42caf0ef, Offset: 0x44c8
// Size: 0xc4
function check_if_goal_is_blocked( previousgoal, goal )
{
    approxpatharray = self calcapproximatepathtoposition( goal );
    distancetonextgoal = min( distance( self.origin, goal ), distance( previousgoal, goal ) );
    approxpathtoolong = is_path_distance_to_goal_too_long( approxpatharray, distancetonextgoal * 2.5 );
    return approxpathtoolong;
}

// Namespace payload/payload
// Params 1
// Checksum 0x956a161, Offset: 0x4598
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
        
        if ( !self.canmove )
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

// Namespace payload/payload
// Params 0
// Checksum 0x1b1adf90, Offset: 0x46d0
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

// Namespace payload/payload
// Params 0
// Checksum 0xf3f6fd54, Offset: 0x4818
// Size: 0x15a
function stop_robot()
{
    if ( !level.moveobject gameobjects::get_flags( 1 ) )
    {
        return;
    }
    
    if ( isdefined( self.traversestartnode ) )
    {
        self thread check_robot_on_travesal_end();
        return;
    }
    
    self.mostrecentclosestpathpointgoal = undefined;
    self.watch_becoming_blocked_at_goal_established = 0;
    velocity = self getvelocity();
    deltapos = velocity * 0.05;
    stopgoal = isdefined( getclosestpointonnavmesh( self.origin + deltapos, 48, 15 ) ) ? getclosestpointonnavmesh( self.origin + deltapos, 48, 15 ) : self.origin;
    self setgoal( stopgoal, 0 );
    level.moveobject gameobjects::set_flags( 0 );
    self notify( #"robot_stopped" );
}

// Namespace payload/payload
// Params 0
// Checksum 0xde86c758, Offset: 0x4980
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

// Namespace payload/payload
// Params 0
// Checksum 0x217c207a, Offset: 0x4a78
// Size: 0x80
function update_stop_position()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( "traverse_end" );
        
        if ( !level.moveobject gameobjects::get_flags( 1 ) )
        {
            self setgoal( self.origin, 1 );
        }
    }
}

// Namespace payload/payload
// Params 0
// Checksum 0xd59e6771, Offset: 0x4b00
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

// Namespace payload/payload
// Params 0
// Checksum 0x2fef9f37, Offset: 0x4d88
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

// Namespace payload/payload
// Params 1
// Checksum 0xf406c13b, Offset: 0x4e20
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

// Namespace payload/payload
// Params 1
// Checksum 0x76db1dfd, Offset: 0x4f40
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

// Namespace payload/payload
// Params 2
// Checksum 0x8c4317b9, Offset: 0x50a0
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

    // Namespace payload/payload
    // Params 0
    // Checksum 0xb8a2904d, Offset: 0x5198
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

// Namespace payload/payload
// Params 0
// Checksum 0x4252e3ed, Offset: 0x53e8
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

// Namespace payload/payload
// Params 0
// Checksum 0xb2bc2060, Offset: 0x5660
// Size: 0x5c
function wait_robot_corpse()
{
    archetype = self.archetype;
    waitresult = self waittill( "actor_corpse" );
    waitresult.corpse clientfield::set( "escort_robot_burn", 1 );
}

// Namespace payload/payload
// Params 0
// Checksum 0xed02c79, Offset: 0x56c8
// Size: 0x98
function robot_move_chatter()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( isdefined( level.moveobject ) && level.moveobject gameobjects::get_flags( 1 ) )
        {
            self playsoundontag( "vox_robot_chatter", "J_Head" );
        }
        
        wait randomfloatrange( 1.5, 2.5 );
    }
}

// Namespace payload/payload
// Params 2
// Checksum 0xacfe0a62, Offset: 0x5768
// Size: 0x270
function setup_move_object( robot, triggername )
{
    trigger = getent( triggername, "targetname" );
    useobj = gameobjects::create_use_object( game.attackers, trigger, [], ( 0, 0, 0 ), &"escort_robot" );
    useobj.bundle = getscriptbundle( "gameobject_escort_robot" );
    useobj gameobjects::set_objective_entity( robot );
    useobj gameobjects::set_visible_team( "any" );
    useobj gameobjects::set_use_time( 0 );
    useobj gameobjects::allow_use( "friendly" );
    trigger enablelinkto();
    trigger linkto( robot );
    useobj.onuse = &function_b90901c2;
    useobj.robot = robot;
    useobj.onbeginuse = &onbeginuse;
    useobj.onenduse = &onenduse;
    
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

// Namespace payload/payload
// Params 1, eflags: 0x4
// Checksum 0xdf7e7257, Offset: 0x59e0
// Size: 0x20
function private onbeginuse( player )
{
    player.var_b43e6c91 = 1;
}

// Namespace payload/payload
// Params 3, eflags: 0x4
// Checksum 0xf5fa7b29, Offset: 0x5a08
// Size: 0x2c
function private onenduse( team, player, result )
{
    player.var_b43e6c91 = 0;
}

// Namespace payload/payload
// Params 1
// Checksum 0x70b29418, Offset: 0x5a40
// Size: 0x27c
function onuse( player )
{
    if ( level.robot.active )
    {
        level.robot.active = 0;
        level.robot stop_robot();
        level.moveobject gameobjects::set_use_text( &"MP_ACTIVATING_ROBOT" );
        level.moveobject gameobjects::set_use_hint_text( &"PLATFORM_ACTIVATE_ROBOT" );
        level.moveobject gameobjects::allow_use( "friendly" );
        scoreevents::processscoreevent( "war_vehicle_deactivation", player );
        globallogic_audio::leader_dialog( "warRobotDisableOfsV2", game.attackers, undefined, "robot" );
        globallogic_audio::leader_dialog( "warRobotDisableDefV2", game.defenders, undefined, "robot" );
        return;
    }
    
    level.robot.active = 1;
    level.robot move_robot();
    level.moveobject gameobjects::set_use_text( &"MP_DEACTIVATING_ROBOT" );
    level.moveobject gameobjects::set_use_hint_text( &"PLATFORM_DEACTIVATE_ROBOT" );
    level.moveobject gameobjects::allow_use( "enemy" );
    scoreevents::processscoreevent( "war_activation_vehicle", player );
    globallogic_audio::leader_dialog( "warRobotEnabledOfs", game.attackers, undefined, "robot" );
    globallogic_audio::leader_dialog( "warRobotEnabledDef", game.defenders, undefined, "robot" );
}

// Namespace payload/payload
// Params 1
// Checksum 0x6c750e69, Offset: 0x5cc8
// Size: 0x7c
function function_b90901c2( player )
{
    if ( level.robot.canmove )
    {
        level.moveobject gameobjects::set_flags( 0 );
        self thread track_escorting_players();
        level.robot move_robot();
    }
}

// Namespace payload/payload
// Params 0
// Checksum 0xd21c128, Offset: 0x5d50
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

// Namespace payload/payload
// Params 1
// Checksum 0xe84184c7, Offset: 0x5e68
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

// Namespace payload/payload
// Params 0
// Checksum 0xc1a16485, Offset: 0x60b8
// Size: 0x3a
function player_stop_escort()
{
    self.escortingrobot = 0;
    self recordgameevent( "player_escort_stop" );
    self notify( #"escorting_stopped" );
}

// Namespace payload/payload
// Params 1
// Checksum 0x79780b67, Offset: 0x6100
// Size: 0x54
function wait_escort_death( player )
{
    level endon( #"game_ended" );
    player endon( #"escorting_stopped" );
    player waittill( "death" );
    player thread player_stop_escort();
}

// Namespace payload/payload
// Params 1
// Checksum 0xac39b19f, Offset: 0x6160
// Size: 0x54
function wait_escort_shutdown( player )
{
    level endon( #"game_ended" );
    player endon( #"escorting_stopped" );
    self.robot waittill( "robot_shutdown" );
    player thread player_stop_escort();
}

// Namespace payload/payload
// Params 2
// Checksum 0xe8d0314e, Offset: 0x61c0
// Size: 0x64
function setup_reboot_object( robot, triggername )
{
    trigger = getent( triggername, "targetname" );
    
    if ( isdefined( trigger ) )
    {
        trigger delete();
    }
}

// Namespace payload/payload
// Params 2
// Checksum 0x9d9d9080, Offset: 0x6230
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

// Namespace payload/payload
// Params 1
// Checksum 0x8e8bf743, Offset: 0x63c0
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
            robot val::set( "payload_robot", "ignoreme", 1 );
            robot thread explode_robot_after_wait( 1 );
            globallogic_score::giveteamscoreforobjective( attackers, 1 );
            level thread globallogic::endgame( attackers, game.strings[ attackers + "_mission_accomplished" ] );
            return;
        }
        
        waitframe( 1 );
    }
}

// Namespace payload/payload
// Params 1
// Checksum 0xc060ee86, Offset: 0x6698
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

// Namespace payload/payload
// Params 1
// Checksum 0x24ec4b8f, Offset: 0x66e8
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

// Namespace payload/payload
// Params 1
// Checksum 0x6c81c8cd, Offset: 0x6b40
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

// Namespace payload/payload
// Params 0
// Checksum 0xf6c2183f, Offset: 0x6d30
// Size: 0x1f4
function function_164911c()
{
    level endon( #"game_ended" );
    level endon( #"mission_ended" );
    level endon( #"mission_completed" );
    robot = level.robot;
    prev_origin = robot.origin;
    
    while ( true )
    {
        dist2 = distancesquared( prev_origin, robot.origin );
        var_7a0f29 = isdefined( level.moveobject.numtouching[ game.attackers ] ) ? level.moveobject.numtouching[ game.attackers ] : 0;
        shouldmove = var_7a0f29 >= level.moveplayers;
        
        if ( robot.canmove && shouldmove && dist2 < 0.001 && ( isdefined( self.blocked_wait_end_time ) ? self.blocked_wait_end_time : 0 ) < gettime() )
        {
            level.moveobject gameobjects::set_flags( 0 );
            robot move_robot();
        }
        
        if ( robot.canmove && !shouldmove )
        {
            stop_robot();
        }
        
        prev_origin = robot.origin;
        wait 0.3;
    }
}

