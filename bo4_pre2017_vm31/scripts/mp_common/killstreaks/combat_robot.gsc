#using scripts/core_common/ai/archetype_utility;
#using scripts/core_common/ai/systems/blackboard;
#using scripts/core_common/ai/systems/gib;
#using scripts/core_common/ai_puppeteer_shared;
#using scripts/core_common/ai_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/challenges_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/entityheadicons_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/killstreaks_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/struct;
#using scripts/core_common/util_shared;
#using scripts/core_common/vehicleriders_shared;
#using scripts/core_common/weapons/heatseekingmissile;
#using scripts/mp_common/challenges;
#using scripts/mp_common/gametypes/globallogic_audio;
#using scripts/mp_common/killstreaks/killstreak_bundles;
#using scripts/mp_common/killstreaks/killstreak_detect;
#using scripts/mp_common/killstreaks/killstreak_hacking;
#using scripts/mp_common/killstreaks/killstreakrules;
#using scripts/mp_common/killstreaks/killstreaks;
#using scripts/mp_common/killstreaks/supplydrop;

#namespace combat_robot;

// Namespace combat_robot/combat_robot
// Params 0
// Checksum 0x175c10d7, Offset: 0xad8
// Size: 0x17c
function init()
{
    killstreaks::register( "combat_robot", "combat_robot_marker", "killstreak_" + "combat_robot", "combat_robot" + "_used", &activatecombatrobot, undefined, 1 );
    killstreaks::register_alt_weapon( "combat_robot", "lmg_light_robot" );
    killstreaks::register_strings( "combat_robot", &"KILLSTREAK_COMBAT_ROBOT_EARNED", &"KILLSTREAK_COMBAT_ROBOT_NOT_AVAILABLE", &"KILLSTREAK_COMBAT_ROBOT_INBOUND", undefined, &"KILLSTREAK_COMBAT_ROBOT_HACKED" );
    killstreaks::register_dialog( "combat_robot", "mpl_killstreak_combat_robot", "combatRobotDialogBundle", "combatRobotPilotDialogBundle", "friendlyCombatRobot", "enemyCombatRobot", "enemyCombatRobotMultiple", "friendlyCombatRobotHacked", "enemyCombatRobotHacked", "requestCombatRobot", "threatCombatRobot" );
    level.killstreaks[ "inventory_combat_robot" ].threatonkill = 1;
    level.killstreaks[ "combat_robot" ].threatonkill = 1;
    level thread _cleanuprobotcorpses();
}

// Namespace combat_robot/combat_robot
// Params 1, eflags: 0x4
// Checksum 0x20b22768, Offset: 0xc60
// Size: 0x2a
function private _calculateprojectedguardposition( player )
{
    return getclosestpointonnavmesh( player.origin, 48 );
}

// Namespace combat_robot/combat_robot
// Params 1, eflags: 0x4
// Checksum 0xe5e6be94, Offset: 0xc98
// Size: 0x6a
function private _calculaterobotspawnposition( player )
{
    desiredspawnposition = anglestoforward( player.angles ) * 72 + player.origin;
    return getclosestpointonnavmesh( desiredspawnposition, 48 );
}

// Namespace combat_robot/combat_robot
// Params 0, eflags: 0x4
// Checksum 0xf69c47fb, Offset: 0xd10
// Size: 0x17c
function private _cleanuprobotcorpses()
{
    corpsedeletetime = 15000;
    
    while ( true )
    {
        deletecorpses = [];
        
        foreach ( corpse in getcorpsearray() )
        {
            if ( isdefined( corpse.birthtime ) && isdefined( corpse.archetype ) && corpse.archetype == "robot" && corpse.birthtime + corpsedeletetime < gettime() )
            {
                deletecorpses[ deletecorpses.size ] = corpse;
            }
        }
        
        for ( index = 0; index < deletecorpses.size ; index++ )
        {
            deletecorpses[ index ] delete();
        }
        
        wait corpsedeletetime / 1000 / 2;
    }
}

// Namespace combat_robot/combat_robot
// Params 2
// Checksum 0xaa245af4, Offset: 0xe98
// Size: 0x21c
function configureteampost( player, ishacked )
{
    robot = self;
    robot.propername = "";
    robot.ignoretriggerdamage = 1;
    robot.empshutdowntime = 750;
    robot.minwalkdistance = 60;
    robot.supersprintdistance = 180;
    robot.robotrusherminradius = 64;
    robot.robotrushermaxradius = 120;
    robot.allowcollidewithactors = 0;
    robot.chargemeleedistance = 0;
    robot.fovcosine = 0;
    robot.fovcosinebusy = 0;
    robot.maxsightdistsqrd = 2000 * 2000;
    robot setblackboardattribute( "_robot_mode", "combat" );
    robot.gib_state = 0 | 8 & 512 - 1;
    robot clientfield::set( "gib_state", robot.gib_state );
    _configurerobotteam( robot, player, ishacked );
    robot ai::set_behavior_attribute( "can_become_crawler", 0 );
    robot ai::set_behavior_attribute( "can_be_meleed", 0 );
    robot ai::set_behavior_attribute( "can_initiateaivsaimelee", 0 );
    robot ai::set_behavior_attribute( "supports_super_sprint", 1 );
}

// Namespace combat_robot/combat_robot
// Params 3, eflags: 0x4
// Checksum 0xd35f8471, Offset: 0x10c0
// Size: 0x104
function private _configurerobotteam( robot, player, ishacked )
{
    if ( ishacked )
    {
        lightsstate = 3;
    }
    else
    {
        lightsstate = 0;
    }
    
    robot ai::set_behavior_attribute( "robot_lights", lightsstate );
    robot thread watchcombatrobotownerdisconnect( player );
    
    if ( !isdefined( robot.objective ) )
    {
        robot.objective = getequipmentheadobjective( getweapon( "combat_robot_marker" ) );
    }
    
    if ( false )
    {
        robot thread _watchmodeswap( robot, player );
    }
    
    robot thread _underwater( robot );
}

// Namespace combat_robot/combat_robot
// Params 2, eflags: 0x4
// Checksum 0x99b4692e, Offset: 0x11d0
// Size: 0xa8
function private _createguardmarker( robot, position )
{
    owner = robot.owner;
    guardmarker = spawn( "script_model", ( 0, 0, 0 ) );
    guardmarker.origin = position;
    guardmarker entityheadicons::setentityheadicon( owner.pers[ "team" ], owner, undefined, &"airdrop_combatrobot" );
    return guardmarker;
}

// Namespace combat_robot/combat_robot
// Params 1, eflags: 0x4
// Checksum 0xd5199060, Offset: 0x1280
// Size: 0x3c
function private _destroyguardmarker( robot )
{
    if ( isdefined( robot.guardmarker ) )
    {
        robot.guardmarker delete();
    }
}

// Namespace combat_robot/combat_robot
// Params 1, eflags: 0x4
// Checksum 0x1fe6fcfb, Offset: 0x12c8
// Size: 0xa8
function private _underwater( robot )
{
    robot endon( #"death" );
    
    while ( true )
    {
        if ( robot.origin[ 2 ] + 36 <= getwaterheight( robot.origin ) )
        {
            robot asmsetanimationrate( 0.85 );
        }
        else
        {
            robot asmsetanimationrate( 1 );
        }
        
        wait 0.1;
    }
}

// Namespace combat_robot/combat_robot
// Params 1, eflags: 0x4
// Checksum 0x4e12b9a2, Offset: 0x1378
// Size: 0x20e
function private _escort( robot )
{
    robot endon( #"death" );
    robot.escorting = 1;
    robot.guarding = 0;
    _destroyguardmarker( robot );
    
    while ( robot.escorting )
    {
        attackingenemy = 0;
        
        if ( isdefined( robot.enemy ) && isalive( robot.enemy ) )
        {
            if ( robot lastknowntime( robot.enemy ) + 10000 >= gettime() )
            {
                robot ai::set_behavior_attribute( "move_mode", "rusher" );
                attackingenemy = 1;
            }
            else
            {
                robot clearenemy();
            }
        }
        
        if ( !attackingenemy && isdefined( robot.owner ) && isalive( robot.owner ) )
        {
            lookaheadtime = 1;
            predicitedposition = robot.owner.origin + vectorscale( robot.owner getvelocity(), lookaheadtime );
            robot ai::set_behavior_attribute( "escort_position", predicitedposition );
            robot ai::set_behavior_attribute( "move_mode", "escort" );
        }
        
        wait 1;
    }
}

// Namespace combat_robot/combat_robot
// Params 2, eflags: 0x4
// Checksum 0x63d75f2b, Offset: 0x1590
// Size: 0x6c
function private _ignoreunattackableenemy( robot, enemy )
{
    robot endon( #"death" );
    robot setignoreent( enemy, 1 );
    wait 5;
    robot setignoreent( enemy, 0 );
}

// Namespace combat_robot/combat_robot
// Params 2, eflags: 0x4
// Checksum 0x4dde9b98, Offset: 0x1608
// Size: 0x1b6
function private _guardposition( robot, position )
{
    robot endon( #"death" );
    robot.goalradius = 1000;
    robot setgoal( position );
    robot.escorting = 0;
    robot.guarding = 1;
    _destroyguardmarker( robot );
    robot.guardmarker = _createguardmarker( robot, position );
    
    while ( robot.guarding )
    {
        attackingenemy = 0;
        
        if ( isdefined( robot.enemy ) && isalive( robot.enemy ) )
        {
            if ( robot lastknowntime( robot.enemy ) + 10000 >= gettime() )
            {
                robot ai::set_behavior_attribute( "move_mode", "rusher" );
                attackingenemy = 1;
            }
            else
            {
                robot clearenemy();
            }
        }
        
        if ( !attackingenemy )
        {
            robot ai::set_behavior_attribute( "move_mode", "guard" );
        }
        
        wait 1;
    }
}

// Namespace combat_robot/combat_robot
// Params 2
// Checksum 0x799de37d, Offset: 0x17c8
// Size: 0x3fe
function _watchmodeswap( robot, player )
{
    robot endon( #"death" );
    
    for ( nextswitchtime = gettime(); true ; nextswitchtime = gettime() + 1000 )
    {
        waitframe( 1 );
        
        if ( !isdefined( robot.usetrigger ) )
        {
            continue;
        }
        
        robot.usetrigger waittill( "trigger" );
        
        if ( nextswitchtime <= gettime() && isalive( player ) )
        {
            if ( isdefined( robot.guarding ) && robot.guarding )
            {
                robot.guarding = 0;
                robot.escorting = 1;
                player playsoundtoplayer( "uin_mp_combat_bot_escort", player );
                robot thread _escort( robot );
                
                if ( isdefined( robot.usetrigger ) )
                {
                    robot.usetrigger sethintstring( &"KILLSTREAK_COMBAT_ROBOT_GUARD_HINT" );
                }
                
                if ( isdefined( robot.markerfxhandle ) )
                {
                    robot.markerfxhandle delete();
                }
            }
            else
            {
                navguardposition = _calculateprojectedguardposition( player );
                
                if ( isdefined( navguardposition ) )
                {
                    robot.guarding = 1;
                    robot.escorting = 0;
                    player playsoundtoplayer( "uin_mp_combat_bot_guard", player );
                    robot thread _guardposition( robot, navguardposition );
                    
                    if ( isdefined( robot.usetrigger ) )
                    {
                        robot.usetrigger sethintstring( &"KILLSTREAK_COMBAT_ROBOT_ESCORT_HINT" );
                    }
                    
                    if ( isdefined( robot.markerfxhandle ) )
                    {
                        robot.markerfxhandle delete();
                    }
                    
                    params = level.killstreakbundle[ "combat_robot" ];
                    
                    if ( isdefined( params.kscombatrobotpatrolfx ) )
                    {
                        point = player.origin;
                        
                        if ( !isdefined( point ) )
                        {
                            point = navguardposition;
                        }
                        
                        robot.markerfxhandle = spawnfx( params.kscombatrobotpatrolfx, point + ( 0, 0, 3 ), ( 0, 0, 1 ), ( 1, 0, 0 ) );
                        robot.markerfxhandle.team = player.team;
                        triggerfx( robot.markerfxhandle );
                        robot.markerfxhandle setinvisibletoall();
                        robot.markerfxhandle setvisibletoplayer( player );
                    }
                }
                else
                {
                    player iprintlnbold( &"KILLSTREAK_COMBAT_ROBOT_PATROL_FAIL" );
                }
            }
            
            robot notify( #"bhtn_action_notify", { #action:"modeSwap" } );
        }
    }
}

// Namespace combat_robot/combat_robot
// Params 1
// Checksum 0xff95d493, Offset: 0x1bd0
// Size: 0x368
function activatecombatrobot( killstreak )
{
    player = self;
    team = self.team;
    
    if ( !self supplydrop::issupplydropgrenadeallowed( killstreak ) )
    {
        return 0;
    }
    
    killstreak_id = self killstreakrules::killstreakstart( killstreak, team, 0, 0 );
    
    if ( killstreak_id == -1 )
    {
        return 0;
    }
    
    context = spawnstruct();
    context.prolog = &prolog;
    context.epilog = &epilog;
    context.hasflares = 1;
    context.radius = level.killstreakcorebundle.ksairdroprobotradius;
    context.dist_from_boundary = 18;
    context.max_dist_from_location = 4;
    context.perform_physics_trace = 1;
    context.drop_from_goal_distance2d = 96;
    context.islocationgood = &supplydrop::islocationgood;
    context.objective = &"airdrop_combatrobot";
    context.killstreakref = killstreak;
    context.validlocationsound = level.killstreakcorebundle.ksvalidcombatrobotlocationsound;
    context.vehiclename = "combat_robot_dropship";
    context.killstreak_id = killstreak_id;
    context.tracemask = 1 | 4;
    context.dropoffset = ( 0, -120, 0 );
    result = self supplydrop::usesupplydropmarker( killstreak_id, context );
    
    if ( !isdefined( result ) || !result )
    {
        killstreakrules::killstreakstop( killstreak, team, killstreak_id );
        self.pers[ "lpSystem" ].tokens++;
        self clientfield::set_player_uimodel( "hudItems.lplevel.unlockTokens", self.pers[ "lpSystem" ].tokens );
        return 0;
    }
    
    self killstreaks::play_killstreak_start_dialog( "combat_robot", self.team, killstreak_id );
    self killstreakrules::displaykillstreakstartteammessagetoall( "combat_robot" );
    self addweaponstat( getweapon( "combat_robot_marker" ), "used", 1 );
    return result;
}

// Namespace combat_robot/combat_robot
// Params 0
// Checksum 0x13d7dac1, Offset: 0x1f40
// Size: 0x76
function dropkillthread()
{
    robot = self;
    robot endon( #"death" );
    robot endon( #"combat_robot_land" );
    
    while ( true )
    {
        robot supplydrop::is_touching_crate();
        robot supplydrop::is_clone_touching_crate();
        waitframe( 1 );
    }
}

// Namespace combat_robot/combat_robot
// Params 1
// Checksum 0x8faf1a52, Offset: 0x1fc0
// Size: 0xe4
function watchhelicopterdeath( context )
{
    helicopter = self;
    helicopter waittill( "death" );
    callback::callback( #"hash_acb66515" );
    
    if ( isdefined( context.marker ) )
    {
        context.marker delete();
        context.marker = undefined;
        
        if ( isdefined( context.markerfxhandle ) )
        {
            context.markerfxhandle delete();
            context.markerfxhandle = undefined;
        }
        
        supplydrop::deldroplocation( context.killstreak_id );
    }
}

// Namespace combat_robot/combat_robot
// Params 1
// Checksum 0x4c90afeb, Offset: 0x20b0
// Size: 0x4d8
function prolog( context )
{
    helicopter = self;
    player = helicopter.owner;
    spawnposition = ( 0, 0, 0 );
    spawnangles = ( 0, 0, 0 );
    combatrobot = spawnactor( "spawner_bo3_robot_grunt_assault_mp", spawnposition, spawnangles, "", 1 );
    combatrobot.missiletrackdamage = 0;
    combatrobot killstreaks::configure_team( "combat_robot", context.killstreak_id, player, "small_vehicle", undefined, &configureteampost );
    combatrobot killstreak_hacking::enable_hacking( "combat_robot", undefined, &hackedcallbackpost );
    combatrobot thread _escort( combatrobot );
    combatrobot thread watchcombatrobothelicopterhacked( helicopter );
    combatrobot thread watchcombatrobotshutdown();
    combatrobot thread watchcombatrobotdeath();
    combatrobot thread killstreaks::waitfortimeout( "combat_robot", 45000, &oncombatrobottimeout, "combat_robot_shutdown" );
    combatrobot thread sndwatchcombatrobotvoxnotifies();
    helicopter thread watchhelicopterdeath( context );
    helicopter.unloadtimeout = 6;
    killstreak_detect::killstreaktargetset( combatrobot, ( 0, 0, 50 ) );
    combatrobot.maxhealth = combatrobot.health;
    tablehealth = killstreak_bundles::get_max_health( "combat_robot" );
    
    if ( isdefined( tablehealth ) )
    {
        combatrobot.maxhealth = tablehealth;
    }
    
    combatrobot.health = combatrobot.maxhealth;
    combatrobot.treat_owner_damage_as_friendly_fire = 1;
    combatrobot.ignore_team_kills = 1;
    combatrobot.remotemissiledamage = combatrobot.maxhealth + 1;
    combatrobot.rocketdamage = combatrobot.maxhealth / 2 + 1;
    combatrobot thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile( "death" );
    combatrobot clientfield::set( "enemyvehicle", 1 );
    combatrobot.soundmod = "drone_land";
    aiutility::addaioverridedamagecallback( combatrobot, &combatrobotdamageoverride );
    combatrobot vehicle::get_in( helicopter, "driver", 1 );
    combatrobot.overridedropposition = player.markerposition;
    combatrobot thread watchcombatrobotlanding();
    combatrobot thread sndwatchexit();
    combatrobot thread sndwatchlanding();
    combatrobot thread sndwatchactivate();
    
    foreach ( player in level.players )
    {
        combatrobot respectnottargetedbyrobotperk( player );
    }
    
    callback::on_spawned( &respectnottargetedbyrobotperk, combatrobot );
    context.robot = combatrobot;
}

// Namespace combat_robot/combat_robot
// Params 1
// Checksum 0xd17bf664, Offset: 0x2590
// Size: 0x54
function respectnottargetedbyrobotperk( player )
{
    combatrobot = self;
    combatrobot setignoreent( player, player hasperk( "specialty_nottargetedbyrobot" ) );
}

// Namespace combat_robot/combat_robot
// Params 1
// Checksum 0x19ee9747, Offset: 0x25f0
// Size: 0xf4
function epilog( context )
{
    helicopter = self;
    context.robot thread dropkillthread();
    context.robot.starttime = gettime() + 750;
    thread cleanupthread( context );
    
    /#
        debug_delay_robot_deploy();
    #/
    
    helicopter waitthensetdeleteafterdestructionwaittime( 0.8, ( isdefined( self.unloadtimeout ) ? self.unloadtimeout : 0 ) + 0.1 );
    helicopter vehicle::unload( "all", undefined, 1, 0.8 );
}

/#

    // Namespace combat_robot/combat_robot
    // Params 0
    // Checksum 0x324e64f0, Offset: 0x26f0
    // Size: 0x90, Type: dev
    function debug_delay_robot_deploy()
    {
        seconds_to_wait = getdvarint( "scr_combat_robot_wait_to_deploy", 0 );
        
        while ( seconds_to_wait > 0 )
        {
            iprintlnbold( "Remaining time: " + seconds_to_wait );
            wait 1;
            seconds_to_wait--;
            
            if ( seconds_to_wait == 0 )
            {
                iprintlnbold( "Jump!!" );
            }
        }
    }

#/

// Namespace combat_robot/combat_robot
// Params 2
// Checksum 0xcecc2bcb, Offset: 0x2788
// Size: 0x30
function waitthensetdeleteafterdestructionwaittime( set_wait_time, delete_after_destruction_wait_time )
{
    wait set_wait_time;
    
    if ( isdefined( self ) )
    {
        self.delete_after_destruction_wait_time = delete_after_destruction_wait_time;
    }
}

// Namespace combat_robot/combat_robot
// Params 1
// Checksum 0x5b7e67fa, Offset: 0x27c0
// Size: 0x54
function hackedcallbackpost( hacker )
{
    robot = self;
    robot clearenemy();
    
    if ( false )
    {
        robot setupcombatrobothinttrigger( hacker );
    }
}

// Namespace combat_robot/combat_robot
// Params 1
// Checksum 0xfe28e140, Offset: 0x2820
// Size: 0xc0
function watchcombatrobothelicopterhacked( helicopter )
{
    robot = self;
    robot endon( #"death" );
    robot endon( #"killstreak_hacked" );
    robot endon( #"combat_robot_land" );
    helicopter endon( #"death" );
    waitresult = helicopter waittill( "killstreak_hacked" );
    
    if ( robot flagsys::get( "in_vehicle" ) == 0 )
    {
        return;
    }
    
    robot [[ robot.killstreak_hackedcallback ]]( waitresult.hacker );
}

// Namespace combat_robot/combat_robot
// Params 1
// Checksum 0xf8890b43, Offset: 0x28e8
// Size: 0x114
function cleanupthread( context )
{
    robot = context.robot;
    
    while ( isdefined( robot ) && isdefined( context.marker ) && robot flagsys::get( "in_vehicle" ) )
    {
        wait 1;
    }
    
    if ( isdefined( context.marker ) )
    {
        context.marker delete();
        context.marker = undefined;
        
        if ( isdefined( context.markerfxhandle ) )
        {
            context.markerfxhandle delete();
            context.markerfxhandle = undefined;
        }
        
        supplydrop::deldroplocation( context.killstreak_id );
    }
}

// Namespace combat_robot/combat_robot
// Params 0
// Checksum 0xe0a72893, Offset: 0x2a08
// Size: 0x1dc
function watchcombatrobotdeath()
{
    combatrobot = self;
    combatrobot endon( #"combat_robot_shutdown" );
    callback::remove_on_spawned( &respectnottargetedbyrobotperk, combatrobot );
    waitresult = combatrobot waittill( "death" );
    attacker = waitresult.attacker;
    weapon = waitresult.weapon;
    attacker = self [[ level.figure_out_attacker ]]( attacker );
    
    if ( !isdefined( combatrobot.owner ) || isdefined( attacker ) && isplayer( attacker ) && combatrobot.owner util::isenemyplayer( attacker ) )
    {
        attacker challenges::destroyscorestreak( weapon, 0, 1 );
        attacker challenges::destroynonairscorestreak_poststatslock( weapon );
        scoreevents::processscoreevent( "destroyed_combat_robot", attacker, combatrobot.owner, weapon );
        luinotifyevent( &"player_callout", 2, &"KILLSTREAK_DESTROYED_COMBAT_ROBOT", attacker.entnum );
    }
    
    combatrobot killstreaks::play_destroyed_dialog_on_owner( "combat_robot", combatrobot.killstreak_id );
    combatrobot notify( #"combat_robot_shutdown" );
}

// Namespace combat_robot/combat_robot
// Params 0
// Checksum 0xa920a82a, Offset: 0x2bf0
// Size: 0x128
function watchcombatrobotlanding()
{
    robot = self;
    robot endon( #"death" );
    robot endon( #"combat_robot_shutdown" );
    
    while ( robot flagsys::get( "in_vehicle" ) )
    {
        wait 1;
    }
    
    robot notify( #"combat_robot_land" );
    robot.ignoretriggerdamage = 0;
    
    while ( isdefined( robot.traversestartnode ) )
    {
        robot waittill( "traverse_end" );
    }
    
    v_on_navmesh = getclosestpointonnavmesh( robot.origin, 50, 20 );
    
    if ( isdefined( v_on_navmesh ) )
    {
        if ( false )
        {
            player = robot.owner;
            robot setupcombatrobothinttrigger( player );
        }
        
        return;
    }
    
    robot notify( #"combat_robot_shutdown" );
}

// Namespace combat_robot/combat_robot
// Params 1
// Checksum 0x94c2a182, Offset: 0x2d20
// Size: 0x1dc
function setupcombatrobothinttrigger( player )
{
    robot = self;
    
    if ( isdefined( robot.usetrigger ) )
    {
        robot.usetrigger delete();
    }
    
    robot.usetrigger = spawn( "trigger_radius_use", player.origin, 0, 32, 32 );
    robot.usetrigger enablelinkto();
    robot.usetrigger linkto( player );
    robot.usetrigger sethintlowpriority( 1 );
    robot.usetrigger setcursorhint( "HINT_NOICON" );
    robot.usetrigger sethintstring( &"KILLSTREAK_COMBAT_ROBOT_GUARD_HINT" );
    robot.usetrigger setteamfortrigger( player.team );
    robot.usetrigger.team = player.team;
    player clientclaimtrigger( robot.usetrigger );
    player.remotecontroltrigger = robot.usetrigger;
    robot.usetrigger.claimedby = player;
}

// Namespace combat_robot/combat_robot
// Params 1
// Checksum 0x3b215cdf, Offset: 0x2f08
// Size: 0x7c
function watchcombatrobotownerdisconnect( player )
{
    combatrobot = self;
    combatrobot notify( #"watchcombatrobotownerdisconnect_singleton" );
    combatrobot endon( #"watchcombatrobotownerdisconnect_singleton" );
    combatrobot endon( #"combat_robot_shutdown" );
    player waittill( "joined_team", "disconnect", "joined_spectators" );
    combatrobot notify( #"combat_robot_shutdown" );
}

// Namespace combat_robot/combat_robot
// Params 0, eflags: 0x4
// Checksum 0x3e0e6abc, Offset: 0x2f90
// Size: 0x5c
function private _corpsewatcher()
{
    archetype = self.archetype;
    waitresult = self waittill( "actor_corpse" );
    waitresult.corpse clientfield::set( "arch_actor_fire_fx", 3 );
}

// Namespace combat_robot/combat_robot
// Params 1, eflags: 0x4
// Checksum 0xc3d37426, Offset: 0x2ff8
// Size: 0x1ac
function private _exploderobot( combatrobot )
{
    combatrobot clientfield::set( "arch_actor_fire_fx", 1 );
    clientfield::set( "robot_mind_control_explosion", 1 );
    combatrobot thread _corpsewatcher();
    
    if ( randomint( 100 ) >= 50 )
    {
        gibserverutils::gibleftarm( combatrobot );
    }
    else
    {
        gibserverutils::gibrightarm( combatrobot );
    }
    
    gibserverutils::giblegs( combatrobot );
    gibserverutils::gibhead( combatrobot );
    velocity = combatrobot getvelocity() * 0.125;
    combatrobot startragdoll();
    combatrobot launchragdoll( ( velocity[ 0 ] + randomfloatrange( -20, 20 ), velocity[ 1 ] + randomfloatrange( -20, 20 ), randomfloatrange( 60, 80 ) ), "j_mainroot" );
}

// Namespace combat_robot/combat_robot
// Params 0
// Checksum 0xe8fdb5f, Offset: 0x31b0
// Size: 0x304
function oncombatrobottimeout()
{
    combatrobot = self;
    combatrobot killstreaks::play_pilot_dialog_on_owner( "timeout", "combat_robot" );
    combatrobot ai::set_behavior_attribute( "shutdown", 1 );
    wait randomfloatrange( 3, 4.5 );
    _exploderobot( combatrobot );
    params = level.killstreakbundle[ "combat_robot" ];
    
    if ( isdefined( params.ksexplosionfx ) )
    {
        playfxontag( params.ksexplosionfx, combatrobot, "tag_origin" );
    }
    
    target_remove( combatrobot );
    
    if ( !isdefined( params.ksexplosionouterradius ) )
    {
        params.ksexplosionouterradius = 200;
    }
    
    if ( !isdefined( params.ksexplosioninnerradius ) )
    {
        params.ksexplosioninnerradius = 1;
    }
    
    if ( !isdefined( params.ksexplosionouterdamage ) )
    {
        params.ksexplosionouterdamage = 25;
    }
    
    if ( !isdefined( params.ksexplosioninnerdamage ) )
    {
        params.ksexplosioninnerdamage = 350;
    }
    
    if ( !isdefined( params.ksexplosionmagnitude ) )
    {
        params.ksexplosionmagnitude = 1;
    }
    
    physicsexplosionsphere( combatrobot.origin, params.ksexplosionouterradius, params.ksexplosioninnerradius, params.ksexplosionmagnitude, params.ksexplosionouterdamage, params.ksexplosioninnerdamage );
    
    if ( isdefined( combatrobot.owner ) )
    {
        radiusdamage( combatrobot.origin, params.ksexplosionouterradius, params.ksexplosioninnerdamage, params.ksexplosionouterdamage, combatrobot.owner, "MOD_EXPLOSIVE", getweapon( "combat_robot_marker" ) );
        
        if ( isdefined( params.ksexplosionrumble ) )
        {
            combatrobot.owner playrumbleonentity( params.ksexplosionrumble );
        }
    }
    
    wait 0.2;
    combatrobot notify( #"combat_robot_shutdown" );
}

// Namespace combat_robot/combat_robot
// Params 0
// Checksum 0x3ccd769, Offset: 0x34c0
// Size: 0x1a4
function watchcombatrobotshutdown()
{
    combatrobot = self;
    combatrobotteam = combatrobot.originalteam;
    combatrobotkillstreakid = combatrobot.killstreak_id;
    combatrobot waittill( "combat_robot_shutdown" );
    combatrobot playsound( "evt_combat_bot_mech_fail_explode" );
    
    if ( isdefined( combatrobot.usetrigger ) )
    {
        combatrobot.usetrigger delete();
    }
    
    if ( isdefined( combatrobot.markerfxhandle ) )
    {
        combatrobot.markerfxhandle delete();
    }
    
    _destroyguardmarker( combatrobot );
    killstreakrules::killstreakstop( "combat_robot", combatrobotteam, combatrobotkillstreakid );
    
    if ( isdefined( combatrobot ) )
    {
        if ( target_istarget( combatrobot ) )
        {
            target_remove( combatrobot );
        }
        
        if ( !level.gameended )
        {
            if ( combatrobot flagsys::get( "in_vehicle" ) )
            {
                combatrobot unlink();
            }
            
            combatrobot kill();
        }
    }
}

// Namespace combat_robot/combat_robot
// Params 0
// Checksum 0x5adccddd, Offset: 0x3670
// Size: 0x110
function sndwatchcombatrobotvoxnotifies()
{
    combatrobot = self;
    combatrobot endon( #"combat_robot_shutdown" );
    combatrobot endon( #"death" );
    combatrobot playsoundontag( "vox_robot_chatter", "j_head" );
    
    while ( true )
    {
        soundalias = undefined;
        waitresult = combatrobot waittill( "bhtn_action_notify" );
        
        switch ( waitresult.action )
        {
            case #"attack_kill":
            case #"attack_melee":
            case #"charge":
            case #"modeSwap":
                soundalias = "vox_robot_chatter";
                break;
        }
        
        if ( isdefined( soundalias ) )
        {
            combatrobot playsoundontag( soundalias, "j_head" );
            wait 1.2;
        }
    }
}

// Namespace combat_robot/combat_robot
// Params 0
// Checksum 0x9e8eb376, Offset: 0x3788
// Size: 0x64
function sndwatchexit()
{
    combatrobot = self;
    combatrobot endon( #"combat_robot_shutdown" );
    combatrobot endon( #"death" );
    combatrobot waittill( "exiting_vehicle" );
    combatrobot playsound( "veh_vtol_supply_robot_launch" );
}

// Namespace combat_robot/combat_robot
// Params 0
// Checksum 0x31934b7d, Offset: 0x37f8
// Size: 0xa4
function sndwatchlanding()
{
    combatrobot = self;
    combatrobot endon( #"combat_robot_shutdown" );
    combatrobot endon( #"death" );
    waitresult = combatrobot waittill( "falling" );
    wait_time = waitresult.fall_time - 0.5;
    
    if ( wait_time > 0 )
    {
        wait wait_time;
    }
    
    combatrobot playsound( "veh_vtol_supply_robot_land" );
}

// Namespace combat_robot/combat_robot
// Params 0
// Checksum 0x929a830c, Offset: 0x38a8
// Size: 0x6c
function sndwatchactivate()
{
    combatrobot = self;
    combatrobot endon( #"combat_robot_shutdown" );
    combatrobot endon( #"death" );
    combatrobot waittill( "landing" );
    wait 0.1;
    combatrobot playsound( "veh_vtol_supply_robot_activate" );
}

// Namespace combat_robot/combat_robot
// Params 12
// Checksum 0x70a2ebc7, Offset: 0x3920
// Size: 0x1a8
function combatrobotdamageoverride( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex )
{
    combatrobot = self;
    
    if ( combatrobot flagsys::get( "in_vehicle" ) && smeansofdeath == "MOD_TRIGGER_HURT" )
    {
        idamage = 0;
    }
    else
    {
        idamage = killstreaks::ondamageperweapon( "combat_robot", eattacker, idamage, idflags, smeansofdeath, weapon, self.maxhealth, undefined, self.maxhealth * 0.4, undefined, 0, undefined, 1, 1 );
    }
    
    combatrobot.missiletrackdamage += idamage;
    
    if ( idamage > 0 && isdefined( eattacker ) )
    {
        if ( isplayer( eattacker ) )
        {
            if ( isdefined( combatrobot.owner ) )
            {
                challenges::combat_robot_damage( eattacker, combatrobot.owner );
            }
        }
    }
    
    return idamage;
}

