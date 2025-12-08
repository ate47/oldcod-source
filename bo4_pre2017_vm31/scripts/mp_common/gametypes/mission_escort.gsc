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

#namespace mission_escort;

// Namespace mission_escort/mission_escort
// Params 1
// Checksum 0xa3f22325, Offset: 0xfa0
// Size: 0x42c
function init( settings_bundle )
{
    level.robotspeed = "walk";
    
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
    
    level.boottime = getgametypesetting( "bootTime" );
    level.reboottime = getgametypesetting( "rebootTime" );
    level.rebootplayers = getgametypesetting( "rebootPlayers" );
    level.moveplayers = getgametypesetting( "movePlayers" );
    
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
        globallogic::setvisiblescoreboardcolumns( "rolescore", "score", "kills", "escorts", "disables", "deaths" );
    }
    else
    {
        globallogic::setvisiblescoreboardcolumns( "rolescore", "score", "kills", "deaths", "escorts", "disables" );
    }
    
    level.teambased = 1;
    killstreak_bundles::register_killstreak_bundle( "escort_robot" );
    
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

// Namespace mission_escort/mission_escort
// Params 1
// Checksum 0x89755f0, Offset: 0x13d8
// Size: 0x44
function start( zone )
{
    setup_callbacks( zone );
    setup_objectives();
    function_e3faa4b2();
}

// Namespace mission_escort/mission_escort
// Params 1
// Checksum 0xe628977c, Offset: 0x1428
// Size: 0x58
function setup_callbacks( zone )
{
    zone.main_loop = &main_loop;
    zone.on_spawn_player = &on_player_spawned;
    zone.on_player_killed = &on_player_killed;
}

// Namespace mission_escort/mission_escort
// Params 0
// Checksum 0x64f37f79, Offset: 0x1488
// Size: 0x20a
function setup_objectives()
{
    util::setobjectivetext( game.attackers, &"OBJECTIVES_ESCORT_ATTACKERS" );
    util::setobjectivetext( game.defenders, &"OBJECTIVES_ESCORT_DEFENDERS" );
    
    foreach ( team in level.teams )
    {
        if ( level.splitscreen )
        {
            util::setobjectivescoretext( team, &"OBJECTIVES_ESCORT_ATTACKER" );
            continue;
        }
        
        util::setobjectivescoretext( team, &"OBJECTIVES_ESCORT_ATTACKER_SCORE" );
    }
    
    util::setobjectivehinttext( game.attackers, &"OBJECTIVES_ESCORT_ATTACKERS_HINT" );
    util::setobjectivehinttext( game.defenders, &"OBJECTIVES_ESCORT_DEFENDERS_HINT" );
    game.strings[ game.attackers + "_mission_win" ] = &"OBJECTIVES_MISSION_ESCORT_ATTACKER_WIN_HINT";
    game.strings[ game.attackers + "_mission_loss" ] = &"OBJECTIVES_MISSION_ATTACKER_LOSS_HINT";
    game.strings[ game.defenders + "_mission_win" ] = &"OBJECTIVES_MISSION_ESCORT_DEFENDER_WIN_HINT";
    game.strings[ game.defenders + "_mission_loss" ] = &"OBJECTIVES_MISSION_ESCORT_DEFENDER_LOSS_HINT";
}

// Namespace mission_escort/mission_escort
// Params 9
// Checksum 0x70f0b045, Offset: 0x16a0
// Size: 0x114
function on_player_killed( einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration )
{
    if ( !isdefined( attacker ) || attacker == self || !isplayer( attacker ) || attacker.team == self.team )
    {
        return;
    }
    
    if ( isdefined( self.var_b43e6c91 ) && self.var_b43e6c91 )
    {
        if ( self.team == game.attackers )
        {
            scoreevents::processscoreevent( "war_stopped_activation_vehicle", attacker );
            return;
        }
        
        scoreevents::processscoreevent( "war_vehicle_stopped_deactivation", attacker );
    }
}

// Namespace mission_escort/mission_escort
// Params 1
// Checksum 0xa6117239, Offset: 0x17c0
// Size: 0x18
function on_player_spawned( predictedspawn )
{
    self.var_b43e6c91 = 0;
}

// Namespace mission_escort/mission_escort
// Params 0
// Checksum 0xb82ded35, Offset: 0x17e0
// Size: 0x38c
function function_e3faa4b2()
{
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
    level.robot.var_2d727ac6 = calc_robot_path_length( patharray[ 0 ], patharray, 0 );
    objective_setprogress( level.moveobject.objectiveid, 1 );
    level.moveobject gameobjects::set_flags( 0 );
    level.robot.active = 0;
    level.robot.canmove = 0;
    level.robot stop_robot();
    level.robot thread auto_reboot_robot( level.boottime );
    level.robot thread function_164911c();
}

/#

    // Namespace mission_escort/mission_escort
    // Params 0
    // Checksum 0x7f7d73ba, Offset: 0x1b78
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

    // Namespace mission_escort/mission_escort
    // Params 1
    // Checksum 0xf1036ebb, Offset: 0x1d50
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

    // Namespace mission_escort/mission_escort
    // Params 1
    // Checksum 0x9cfb1c7, Offset: 0x1f20
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

    // Namespace mission_escort/mission_escort
    // Params 1
    // Checksum 0x3c06ff87, Offset: 0x1fd8
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

    // Namespace mission_escort/mission_escort
    // Params 1
    // Checksum 0xdccf4e16, Offset: 0x2098
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

    // Namespace mission_escort/mission_escort
    // Params 2
    // Checksum 0x5b740e1d, Offset: 0x2158
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

// Namespace mission_escort/mission_escort
// Params 0
// Checksum 0x56927c7e, Offset: 0x2260
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

// Namespace mission_escort/mission_escort
// Params 3
// Checksum 0x3a03ef7c, Offset: 0x23a8
// Size: 0xac
function calc_robot_path_length( robotorigin, patharray, currentindex )
{
    distance = 0;
    lastpoint = robotorigin;
    
    for ( i = currentindex; i < patharray.size ; i++ )
    {
        distance += distance( lastpoint, patharray[ i ] );
        lastpoint = patharray[ i ];
    }
    
    /#
    #/
    
    return distance;
}

// Namespace mission_escort/mission_escort
// Params 2
// Checksum 0xf58a0a18, Offset: 0x2460
// Size: 0x388
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

// Namespace mission_escort/mission_escort
// Params 0
// Checksum 0x8930e9fe, Offset: 0x27f0
// Size: 0xbc
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
    self set_goal_to_point_on_path();
    self thread robot_wait_next_point();
}

// Namespace mission_escort/mission_escort
// Params 12
// Checksum 0x2110330f, Offset: 0x28b8
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

// Namespace mission_escort/mission_escort
// Params 0
// Checksum 0x84381fbb, Offset: 0x2ee8
// Size: 0x1fc
function shutdown_robot()
{
    self.active = 0;
    self.canmove = 0;
    self val::set( "escort_robot_shutdown", "ignoreme", 1 );
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

// Namespace mission_escort/mission_escort
// Params 0
// Checksum 0x7d8526ac, Offset: 0x30f0
// Size: 0x34
function get_current_goal()
{
    return isdefined( self.immediategoaloverride ) ? self.immediategoaloverride : self.patharray[ self.pathindex ];
}

// Namespace mission_escort/mission_escort
// Params 1
// Checksum 0x1eede319, Offset: 0x3130
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

// Namespace mission_escort/mission_escort
// Params 0
// Checksum 0x4f0d3308, Offset: 0x3248
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

// Namespace mission_escort/mission_escort
// Params 0
// Checksum 0xf96ffd90, Offset: 0x3410
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

// Namespace mission_escort/mission_escort
// Params 2
// Checksum 0xadf8485a, Offset: 0x3538
// Size: 0xc4
function check_if_goal_is_blocked( previousgoal, goal )
{
    approxpatharray = self calcapproximatepathtoposition( goal );
    distancetonextgoal = min( distance( self.origin, goal ), distance( previousgoal, goal ) );
    approxpathtoolong = is_path_distance_to_goal_too_long( approxpatharray, distancetonextgoal * 2.5 );
    return approxpathtoolong;
}

// Namespace mission_escort/mission_escort
// Params 1
// Checksum 0xc490d927, Offset: 0x3608
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

// Namespace mission_escort/mission_escort
// Params 0
// Checksum 0x1639750b, Offset: 0x3740
// Size: 0x154
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
    
    while ( level.moveobject gameobjects::get_flags( 1 ) )
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

// Namespace mission_escort/mission_escort
// Params 0
// Checksum 0xc3935492, Offset: 0x38a0
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

// Namespace mission_escort/mission_escort
// Params 0
// Checksum 0xd8efb5ef, Offset: 0x3a08
// Size: 0x7c
function check_robot_on_travesal_end()
{
    self notify( #"check_robot_on_travesal_end_singleton" );
    self endon( #"check_robot_on_travesal_end_singleton" );
    self endon( #"death" );
    self waittill( "traverse_end" );
    
    if ( level.robot.active )
    {
        self move_robot();
        return;
    }
    
    self stop_robot();
}

// Namespace mission_escort/mission_escort
// Params 0
// Checksum 0x72b90d17, Offset: 0x3a90
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

// Namespace mission_escort/mission_escort
// Params 0
// Checksum 0xddc2e724, Offset: 0x3b18
// Size: 0x270
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
            self.pathindex = self.patharray.size - 1;
            self stop_robot();
            return;
        }
        
        if ( self.pathindex + 1 >= self.patharray.size )
        {
            globallogic_audio::leader_dialog( "sfgRobotCloseAttacker", game.attackers, undefined, "robot" );
            globallogic_audio::leader_dialog( "sfgRobotCloseDefender", game.defenders, undefined, "robot" );
        }
        
        if ( self check_blocked_goal_and_kill() )
        {
            self stop_robot();
        }
        
        set_goal_to_point_on_path();
    }
}

// Namespace mission_escort/mission_escort
// Params 0
// Checksum 0x3754b3cf, Offset: 0x3d90
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

// Namespace mission_escort/mission_escort
// Params 1
// Checksum 0x13b470e4, Offset: 0x3e28
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

// Namespace mission_escort/mission_escort
// Params 1
// Checksum 0xf5bfc338, Offset: 0x3f48
// Size: 0x174
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
        println( "<dev string:x96>" );
    }
    
    /#
        debug_draw_current_robot_goal( closestpathpoint );
    #/
}

// Namespace mission_escort/mission_escort
// Params 2
// Checksum 0xc46354ee, Offset: 0x40c8
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

    // Namespace mission_escort/mission_escort
    // Params 0
    // Checksum 0x159f34d8, Offset: 0x41c0
    // Size: 0x248, Type: dev
    function debug_reset_robot_to_start()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( ( isdefined( getdvarint( "<dev string:xa4>" ) ) ? getdvarint( "<dev string:xa4>" ) : 0 ) > 0 )
            {
                if ( isdefined( level.robot ) )
                {
                    pathindex = ( isdefined( getdvarint( "<dev string:xa4>" ) ) ? getdvarint( "<dev string:xa4>" ) : 0 ) - 1;
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
                
                setdvar( "<dev string:xa4>", 0 );
            }
            
            wait 0.5;
        }
    }

#/

// Namespace mission_escort/mission_escort
// Params 0
// Checksum 0xc99399f7, Offset: 0x4410
// Size: 0x1fc
function explode_robot()
{
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
    physicsexplosionsphere( self.origin, 200, 1, 1, 1, 1 );
    radiusdamage( self.origin, 200, 1, 1, undefined, "MOD_EXPLOSIVE" );
    playrumbleonposition( "grenade_rumble", self.origin );
}

// Namespace mission_escort/mission_escort
// Params 0
// Checksum 0x95bc6cf9, Offset: 0x4618
// Size: 0x36
function wait_robot_corpse()
{
    archetype = self.archetype;
    waitresult = self waittill( "actor_corpse" );
}

// Namespace mission_escort/mission_escort
// Params 0
// Checksum 0x8311d570, Offset: 0x4658
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

// Namespace mission_escort/mission_escort
// Params 2
// Checksum 0xb907684a, Offset: 0x46f8
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

// Namespace mission_escort/mission_escort
// Params 1, eflags: 0x4
// Checksum 0x4aab2fe8, Offset: 0x4970
// Size: 0x20
function private onbeginuse( player )
{
    player.var_b43e6c91 = 1;
}

// Namespace mission_escort/mission_escort
// Params 3, eflags: 0x4
// Checksum 0xfaba612, Offset: 0x4998
// Size: 0x2c
function private onenduse( team, player, result )
{
    player.var_b43e6c91 = 0;
}

// Namespace mission_escort/mission_escort
// Params 1
// Checksum 0x36fb4357, Offset: 0x49d0
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

// Namespace mission_escort/mission_escort
// Params 1
// Checksum 0x1d088b35, Offset: 0x4c58
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

// Namespace mission_escort/mission_escort
// Params 2
// Checksum 0x67f7f2e0, Offset: 0x4ce0
// Size: 0x1c8
function setup_goal_object( robot, triggername )
{
    trigger = getent( triggername, "targetname" );
    useobj = gameobjects::create_use_object( game.defenders, trigger, [], ( 0, 0, 0 ), &"war_escort_goal" );
    useobj gameobjects::set_visible_team( "any" );
    useobj gameobjects::allow_use( "none" );
    useobj gameobjects::set_use_time( 0 );
    fwd = ( 0, 0, 1 );
    right = ( 0, -1, 0 );
    useobj.fx = spawnfx( "ui/fx_dom_marker_team_r120", trigger.origin, fwd, right );
    useobj.fx.team = game.defenders;
    triggerfx( useobj.fx, 0.001 );
    objective_visibleteams( useobj.objectiveid, level.spawnsystem.ispawn_teammask[ game.defenders ] );
    useobj thread watch_robot_enter( robot );
    return useobj;
}

// Namespace mission_escort/mission_escort
// Params 0
// Checksum 0xdaf391e9, Offset: 0x4eb0
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

// Namespace mission_escort/mission_escort
// Params 1
// Checksum 0xca03942e, Offset: 0x4fc8
// Size: 0x22c
function track_escort_time( player )
{
    level endon( #"game_ended" );
    player endon( #"death" );
    self.robot endon( #"robot_shutdown" );
    player.escortingrobot = 1;
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

// Namespace mission_escort/mission_escort
// Params 0
// Checksum 0xdf356c65, Offset: 0x5200
// Size: 0x1e
function player_stop_escort()
{
    self.escortingrobot = 0;
    self notify( #"escorting_stopped" );
}

// Namespace mission_escort/mission_escort
// Params 1
// Checksum 0x1c00ed39, Offset: 0x5228
// Size: 0x54
function wait_escort_death( player )
{
    level endon( #"game_ended" );
    player endon( #"escorting_stopped" );
    player waittill( "death" );
    player thread player_stop_escort();
}

// Namespace mission_escort/mission_escort
// Params 1
// Checksum 0x1d49b6b4, Offset: 0x5288
// Size: 0x54
function wait_escort_shutdown( player )
{
    level endon( #"game_ended" );
    player endon( #"escorting_stopped" );
    self.robot waittill( "robot_shutdown" );
    player thread player_stop_escort();
}

// Namespace mission_escort/mission_escort
// Params 1
// Checksum 0x7d472d02, Offset: 0x52e8
// Size: 0x3c0
function watch_robot_enter( robot )
{
    robot endon( #"death" );
    level endon( #"game_ended" );
    radiussq = self.trigger.radius * self.trigger.radius;
    
    while ( true )
    {
        if ( level.moveobject gameobjects::get_flags( 1 ) )
        {
            distance = calc_robot_path_length( robot.origin, robot.patharray, robot.pathindex );
            
            if ( !( isdefined( level.var_e9a03050 ) && level.var_e9a03050 ) && distance <= level.var_b21ad92e )
            {
                level.var_e9a03050 = 1;
                globallogic_audio::leader_dialog( "warRobotNearOfs", game.attackers, undefined, "robot" );
                globallogic_audio::leader_dialog( "warRobotNearDef", game.defenders, undefined, "robot" );
            }
            
            clientfield::set_world_uimodel( "hudItems.war.robotCurrentDistance", int( distance - self.trigger.radius ) );
            clientfield::set_world_uimodel( "hudItems.war.currentZoneProgress", 1 - ( distance - self.trigger.radius ) / ( robot.var_2d727ac6 - self.trigger.radius ) );
            
            if ( distance2dsquared( self.trigger.origin, robot.origin ) < radiussq )
            {
                attackers = game.attackers;
                self.fx.team = attackers;
                
                foreach ( player in level.aliveplayers[ attackers ] )
                {
                    if ( isdefined( player.escortingrobot ) && player.escortingrobot )
                    {
                        scoreevents::processscoreevent( "escort_robot_escort_goal", player );
                    }
                }
                
                setgameendtime( 0 );
                robot val::set( "escort_robot", "ignoreme", 1 );
                robot thread explode_robot_after_wait( 1 );
                globallogic_score::giveteamscoreforobjective( attackers, 1 );
                level notify( #"mission_completed" );
                return;
            }
        }
        
        waitframe( 1 );
    }
}

// Namespace mission_escort/mission_escort
// Params 1
// Checksum 0xc5a8095f, Offset: 0x56b0
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

// Namespace mission_escort/mission_escort
// Params 1
// Checksum 0x9a879443, Offset: 0x5700
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

// Namespace mission_escort/mission_escort
// Params 1
// Checksum 0x367327b6, Offset: 0x5b58
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

// Namespace mission_escort/mission_escort
// Params 1
// Checksum 0xd5a45196, Offset: 0x5d48
// Size: 0x18c
function auto_reboot_robot( time )
{
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
    
    self thread reboot_robot();
}

// Namespace mission_escort/mission_escort
// Params 0
// Checksum 0xbfeab8b3, Offset: 0x5ee0
// Size: 0x274
function reboot_robot()
{
    self endon( #"robot_shutdown" );
    level endon( #"game_ended" );
    self.active = 1;
    self.shutdowndamage = 0;
    self val::reset( "escort_robot_shutdown", "ignoreme" );
    self recordgameeventnonplayer( "robot_repair_complete" );
    level.moveobject gameobjects::allow_use( "friendly" );
    globallogic_audio::leader_dialog( "sfgRobotRebootedAttacker", game.attackers, undefined, "robot" );
    globallogic_audio::leader_dialog( "sfgRobotRebootedDefender", game.defenders, undefined, "robot" );
    globallogic_audio::play_2d_on_team( "mpl_safeguard_reboot_sting_friend", game.attackers );
    globallogic_audio::play_2d_on_team( "mpl_safeguard_reboot_sting_enemy", game.defenders );
    objective_setprogress( level.moveobject.objectiveid, 1 );
    
    if ( level.moveplayers == 0 )
    {
        self move_robot();
    }
    else if ( level.moveobject.numtouching[ game.attackers ] == 0 )
    {
        level.moveobject gameobjects::set_flags( 0 );
    }
    
    if ( isdefined( level.shutdowndamage ) && level.shutdowndamage )
    {
        target_set( self, ( 0, 0, 50 ) );
    }
    
    self ai::set_behavior_attribute( "shutdown", 0 );
    wait getanimlength( "ai_robot_rogue_ctrl_crc_shutdown_2_alert" );
    self.canmove = 1;
}

// Namespace mission_escort/mission_escort
// Params 0
// Checksum 0x945d1b2e, Offset: 0x6160
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

// Namespace mission_escort/mission_escort
// Params 1
// Checksum 0x89f07ada, Offset: 0x6360
// Size: 0x94
function main_loop( zone )
{
    level endon( #"game_ended" );
    level endon( #"mission_ended" );
    thread globallogic::showobjectivenotificationuiforallplayers( &"mission_escort" );
    msg = level waittill( "mission_completed", "mission_timed_out" );
    
    if ( msg._notify === "mission_completed" )
    {
        level.war_mission_succeeded = 1;
    }
}

