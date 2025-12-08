#using scripts/core_common/abilities/gadgets/gadget_resurrect;
#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/gameobjects_shared;
#using scripts/core_common/influencers_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/spawning_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/tacticalinsertion;
#using scripts/mp_common/userspawnselection;

#namespace forward_spawn;

// Namespace forward_spawn/forward_spawn
// Params 0, eflags: 0x2
// Checksum 0x8aaa86ac, Offset: 0x798
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "forward_spawn", &__init__, undefined, undefined );
}

// Namespace forward_spawn/forward_spawn
// Params 0
// Checksum 0xb6b004cf, Offset: 0x7d8
// Size: 0x1ec
function __init__()
{
    clientfield::register( "worlduimodel", "hudItems.war.forwardSpawnStatus", 1, 2, "int" );
    
    if ( !isdefined( level.forwardspawnsettings ) )
    {
        level.forwardspawnsettings = spawnstruct();
    }
    
    level.forward_spawns = [];
    level.forwardspawnsettings.isenabled = getgametypesetting( "forwardSpawnEnabled" ) && userspawnselection::isspawnselectenabled();
    
    if ( !level.forwardspawnsettings.isenabled )
    {
        return;
    }
    
    fillgamesettings();
    level.forward_spawn_on_player_killed = &on_player_killed;
    level.forwardspawnsettings.baseactivationtime = 5;
    level.forwardspawnsettings.basedeactivationtime = 5;
    level._effect[ "forward_spawn_explosion" ] = "explosions/fx_exp_bomb_demo_mp";
    game.strings[ "requires_support_player" ] = &"MENU_REQUIRES_SUPPORT_PLAYER";
    game.strings[ "forward_spawn_used" ] = &"MENU_FORWARD_SPAWN_USED";
    level.forwardspawnsettings.timetoshownonsupportmessage = 2000;
    callback::on_disconnect( &on_player_disconnect );
    callback::on_spawned( &on_player_spawned );
}

// Namespace forward_spawn/forward_spawn
// Params 0, eflags: 0x4
// Checksum 0xb23112c1, Offset: 0x9d0
// Size: 0x180
function private fillgamesettings()
{
    level.forwardspawnsettings.baseactivationtime = getgametypesetting( "forwardSpawnDefaultBuildTime" );
    level.forwardspawnsettings.basedeactivationtime = getgametypesetting( "forwardSpawnDefaultDisableTime" );
    level.forwardspawnsettings.fastusemultiplier = getgametypesetting( "forwardSpawnFastUseMultiplier" );
    level.forwardspawnsettings.forwardspawntakesdamage = getgametypesetting( "forwardSpawnTakesDamage" );
    level.forwardspawnsettings.forwardspawnhealth = getgametypesetting( "forwardSpawnHealth" );
    level.forwardspawnsettings.useproximityactivate = getgametypesetting( "forwardSpawnProximityActivate" );
    level.forwardspawnsettings.proximityradius = getgametypesetting( "forwardSpawnProximityRadius" );
    level.forwardspawnsettings.isneutral = getgametypesetting( "forwardSpawnIsNeutral" );
}

// Namespace forward_spawn/forward_spawn
// Params 1
// Checksum 0xdda5ddb9, Offset: 0xb58
// Size: 0x50
function setleaderaudiofunction( audiofuncptr )
{
    if ( !isdefined( level.forwardspawnsettings ) )
    {
        level.forwardspawnsettings = spawnstruct();
    }
    
    level.forwardspawnsettings.audioplaybackfunc = audiofuncptr;
}

// Namespace forward_spawn/forward_spawn
// Params 0
// Checksum 0x6943eb26, Offset: 0xbb0
// Size: 0xca
function initialize()
{
    if ( !level.forwardspawnsettings.isenabled )
    {
        return;
    }
    
    setupforwardspawnsinlevel();
    
    if ( isdefined( level.forward_spawns ) )
    {
        foreach ( forwardspawn in level.forward_spawns )
        {
            forwardspawn setupforwardspawnforactivation();
        }
    }
}

// Namespace forward_spawn/forward_spawn
// Params 0
// Checksum 0xced7ab62, Offset: 0xc88
// Size: 0x124
function on_player_spawned()
{
    self.activatingforwardspawn = 0;
    self.deactivatingforwardspawn = 0;
    lastselectedspawngroup = self userspawnselection::getlastchosenspawngroupforplayer();
    
    if ( isdefined( lastselectedspawngroup.isforwardspawn ) && isdefined( lastselectedspawngroup ) && lastselectedspawngroup.isforwardspawn )
    {
        activator = getforwardspawnactivatedby();
        forwardspawnteam = getactiveforwardspawnteam();
        
        if ( isdefined( activator ) && self != activator && forwardspawnteam === self.pers[ "team" ] )
        {
            scoreevents::processscoreevent( "forward_spawn_assist", activator );
            self iprintlnbold( game.strings[ "forward_spawn_used" ] );
        }
    }
}

// Namespace forward_spawn/forward_spawn
// Params 9
// Checksum 0x33a33a19, Offset: 0xdb8
// Size: 0x1ac
function on_player_killed( einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration )
{
    if ( !isplayer( attacker ) )
    {
        return;
    }
    
    victim = self;
    
    if ( isdefined( victim.activatingforwardspawn ) && victim.activatingforwardspawn )
    {
        scoreevents::processscoreevent( "forward_spawn_stopped_activation", attacker, victim, weapon );
    }
    else if ( isdefined( victim.deactivatingforwardspawn ) && victim.deactivatingforwardspawn )
    {
        scoreevents::processscoreevent( "forward_spawn_stopped_deactivation", attacker, victim, weapon );
    }
    
    if ( attacker istouchingforwardspawntrigger() || victim istouchingforwardspawntrigger() )
    {
        if ( attacker areforwardspawnsfriendly() )
        {
            scoreevents::processscoreevent( "forward_spawn_defend", attacker, victim, weapon );
            return;
        }
        
        scoreevents::processscoreevent( "forward_spawn_deny", attacker, victim, weapon );
    }
}

// Namespace forward_spawn/forward_spawn
// Params 0
// Checksum 0xd2549f57, Offset: 0xf70
// Size: 0xbc, Type: bool
function areforwardspawnsfriendly()
{
    foreach ( forward_spawn in level.forward_spawns )
    {
        interactingteam = self.pers[ "team" ];
        
        if ( forward_spawn gameobjects::is_friendly_team( interactingteam ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace forward_spawn/forward_spawn
// Params 0
// Checksum 0x62cad726, Offset: 0x1038
// Size: 0xbc, Type: bool
function istouchingforwardspawntrigger()
{
    if ( !isdefined( level.forward_spawns ) )
    {
        return false;
    }
    
    foreach ( forward_spawn in level.forward_spawns )
    {
        if ( self istouching( forward_spawn.nonsupporttrigger ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace forward_spawn/forward_spawn
// Params 1
// Checksum 0x6c108cc9, Offset: 0x1100
// Size: 0x54
function populatespawnlistcallback( &spawnlistarray )
{
    activeforwardspawn = getactiveforwardspawn();
    
    if ( isdefined( activeforwardspawn ) )
    {
        array::add( spawnlistarray, activeforwardspawn.spawnlistname );
    }
}

// Namespace forward_spawn/forward_spawn
// Params 0
// Checksum 0x9cda5731, Offset: 0x1160
// Size: 0xc4
function setupforwardspawnsinlevel()
{
    forwardspawns = getentarray( "forward_spawn_controller", "classname" );
    
    foreach ( forwardspawn in forwardspawns )
    {
        setupforwardspawn( forwardspawn );
    }
    
    setup_forwardspawn_waits();
}

// Namespace forward_spawn/forward_spawn
// Params 1
// Checksum 0xaabcdab8, Offset: 0x1230
// Size: 0x84
function disableforwardspawn( forward_spawn_name )
{
    if ( !isdefined( level.forward_spawns[ forward_spawn_name ] ) )
    {
        println( "disableForwardSpawn():: Tried to disable unknown forward spawn '" + forward_spawn_name + "'" );
        return;
    }
    
    forwardspawn = level.forward_spawns[ forward_spawn_name ];
    forwardspawn disable();
}

// Namespace forward_spawn/forward_spawn
// Params 0
// Checksum 0x9ff85c55, Offset: 0x12c0
// Size: 0x92
function disableall()
{
    foreach ( forwardspawn in level.forward_spawns )
    {
        forwardspawn disable();
    }
}

// Namespace forward_spawn/forward_spawn
// Params 0
// Checksum 0x33be7829, Offset: 0x1360
// Size: 0x20, Type: bool
function doeslevelcontainforwardspawns()
{
    if ( level.forward_spawns.size == 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace forward_spawn/forward_spawn
// Params 0
// Checksum 0x59e165c2, Offset: 0x1388
// Size: 0x16
function getactiveforwardspawn()
{
    return level.forwardspawnsettings.activeforwardspawn;
}

// Namespace forward_spawn/forward_spawn
// Params 0
// Checksum 0xd64a03ac, Offset: 0x13a8
// Size: 0x20, Type: bool
function isforwardspawnactive()
{
    if ( isdefined( getactiveforwardspawn() ) )
    {
        return true;
    }
    
    return false;
}

// Namespace forward_spawn/forward_spawn
// Params 0
// Checksum 0xc32295a8, Offset: 0x13d0
// Size: 0x52
function getforwardspawnactivatedby()
{
    if ( !isforwardspawnactive() )
    {
        return undefined;
    }
    
    activeforwardspawn = getactiveforwardspawn();
    
    if ( !isdefined( activeforwardspawn ) )
    {
        return undefined;
    }
    
    return activeforwardspawn.activatedby;
}

// Namespace forward_spawn/forward_spawn
// Params 0
// Checksum 0x8b1f2e96, Offset: 0x1430
// Size: 0x52
function getactiveforwardspawnteam()
{
    if ( !isforwardspawnactive() )
    {
        return undefined;
    }
    
    activeforwardspawn = getactiveforwardspawn();
    
    if ( !isdefined( activeforwardspawn ) )
    {
        return undefined;
    }
    
    return activeforwardspawn.team;
}

// Namespace forward_spawn/forward_spawn
// Params 1, eflags: 0x4
// Checksum 0xe95fefa9, Offset: 0x1490
// Size: 0x68
function private getteamname( raw_team_str )
{
    returnstr = raw_team_str;
    
    if ( raw_team_str == "attackers" )
    {
        returnstr = game.attackers;
    }
    else if ( raw_team_str == "defenders" )
    {
        returnstr = game.defenders;
    }
    
    return returnstr;
}

// Namespace forward_spawn/forward_spawn
// Params 0, eflags: 0x4
// Checksum 0xbc9dc7f5, Offset: 0x1500
// Size: 0x2c
function private getforwardspawnvisual()
{
    if ( self.visuals.size == 1 )
    {
        return self.visuals[ 0 ];
    }
    
    return undefined;
}

// Namespace forward_spawn/forward_spawn
// Params 0, eflags: 0x4
// Checksum 0xfc3a2d50, Offset: 0x1538
// Size: 0x128
function private watchforwardspawnfordeath()
{
    self endon( #"forward_spawn_disabled" );
    level endon( #"game_ended" );
    forwardspawnscriptmodel = self getforwardspawnvisual();
    forwardspawnscriptmodel.takedamage = 1;
    forwardspawnscriptmodel.health = level.forwardspawnsettings.forwardspawnhealth;
    
    while ( true )
    {
        forwardspawnscriptmodel waittill( "death" );
        println( "Forward Spawn killed!" );
        explosioneffect = spawnfx( level._effect[ "forward_spawn_explosion" ], self.origin + ( 0, 0, 50 ) );
        triggerfx( explosioneffect );
        self disable();
    }
}

// Namespace forward_spawn/forward_spawn
// Params 1
// Checksum 0x5419d495, Offset: 0x1668
// Size: 0x4e, Type: bool
function canplayerinteractwithforwardspawn( player )
{
    if ( isdefined( player.specialty ) && array::contains( player.specialty, "specialty_forwardspawninteract" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace forward_spawn/forward_spawn
// Params 0, eflags: 0x4
// Checksum 0x68f689c9, Offset: 0x16c0
// Size: 0x178
function private watchnonsupporttrigger()
{
    level endon( #"game_ended" );
    self endon( #"forward_spawn_disabled" );
    
    while ( true )
    {
        waitresult = self.nonsupporttrigger waittill( "trigger" );
        player = waitresult.activator;
        
        if ( canplayerinteractwithforwardspawn( player ) )
        {
            continue;
        }
        
        if ( isdefined( player.requiressupportplayeruishowntime ) )
        {
            timetonextshow = player.requiressupportplayeruishowntime + level.forwardspawnsettings.timetoshownonsupportmessage;
            
            if ( timetonextshow > gettime() )
            {
                continue;
            }
        }
        
        if ( player.team == self.team )
        {
            if ( isdefined( self.forwardspawnactive ) && self.forwardspawnactive )
            {
                continue;
            }
        }
        else if ( !( isdefined( self.forwardspawnactive ) && self.forwardspawnactive ) )
        {
            continue;
        }
        
        player.requiressupportplayeruishowntime = gettime();
        player iprintlnbold( game.strings[ "requires_support_player" ] );
    }
}

// Namespace forward_spawn/forward_spawn
// Params 0, eflags: 0x4
// Checksum 0xdc50ba92, Offset: 0x1840
// Size: 0x11a
function private disable()
{
    self setforwardspawndeactived( self.team );
    self gameobjects::allow_use( "none" );
    self gameobjects::set_visible_team( "none" );
    objective_setstate( self.nonsupport_objectiveid, "invisible" );
    
    foreach ( visual in self.visuals )
    {
        visual.team = "free";
    }
    
    self notify( #"forward_spawn_disabled" );
}

// Namespace forward_spawn/forward_spawn
// Params 0, eflags: 0x4
// Checksum 0x111fa35e, Offset: 0x1968
// Size: 0xf4
function private setupforwardspawnfordeactivation()
{
    self gameobjects::allow_use( "enemy" );
    self gameobjects::set_use_time( level.forwardspawnsettings.basedeactivationtime );
    self gameobjects::set_use_text( &"MP_DISABLING_FORWARD_SPAWN" );
    
    if ( level.forwardspawnsettings.useproximityactivate )
    {
        self gameobjects::set_use_hint_text( &"PLATFORM_DEACTIVATE_FORWARD_SPAWN_PROX" );
    }
    else
    {
        self gameobjects::set_use_hint_text( &"PLATFORM_DEACTIVATE_FORWARD_SPAWN" );
    }
    
    self gameobjects::set_visible_team( "any" );
    self gameobjects::clear_progress();
}

// Namespace forward_spawn/forward_spawn
// Params 0, eflags: 0x4
// Checksum 0x18e0835b, Offset: 0x1a68
// Size: 0x1c4
function private setupforwardspawnforactivation()
{
    if ( level.forwardspawnsettings.isneutral )
    {
        self gameobjects::allow_use( "any" );
    }
    else
    {
        self gameobjects::allow_use( "friendly" );
    }
    
    self gameobjects::set_use_time( level.forwardspawnsettings.baseactivationtime );
    self gameobjects::set_use_text( &"MP_ACTIVATING_FORWARD_SPAWN" );
    
    if ( level.forwardspawnsettings.useproximityactivate )
    {
        self gameobjects::set_use_hint_text( &"PLATFORM_ACTIVATE_FORWARD_SPAWN_PROX" );
    }
    else
    {
        self gameobjects::set_use_hint_text( &"PLATFORM_ACTIVATE_FORWARD_SPAWN" );
    }
    
    self gameobjects::set_visible_team( "any" );
    objective_setteam( self.nonsupport_objectiveid, self.team );
    objective_visibleteams( self.nonsupport_objectiveid, level.spawnsystem.ispawn_teammask[ "all" ] );
    objective_setstate( self.nonsupport_objectiveid, "active" );
    
    if ( isdefined( self.nonsupporttrigger ) )
    {
        self thread watchnonsupporttrigger();
    }
    
    self gameobjects::clear_progress();
}

// Namespace forward_spawn/forward_spawn
// Params 2, eflags: 0x4
// Checksum 0x3af0c51a, Offset: 0x1c38
// Size: 0x1c4
function private setforwardspawnactive( team, activatedby )
{
    if ( !userspawnselection::isspawnselectenabled() )
    {
        return;
    }
    else
    {
        self changespawnstate( 1, team );
    }
    
    self gameobjects::set_flags( 1 );
    objective_setgamemodeflags( self.nonsupport_objectiveid, 1 );
    self setteam( team );
    self gameobjects::set_owner_team( team );
    self setupforwardspawnfordeactivation();
    objective_setteam( self.nonsupport_objectiveid, team );
    objective_setprogress( self.nonsupport_objectiveid, 1 );
    self.forwardspawnactive = 1;
    level.forwardspawnsettings.activeforwardspawn = self;
    
    if ( level.forwardspawnsettings.forwardspawntakesdamage == 1 )
    {
        self thread watchforwardspawnfordeath();
    }
    
    self.activatedby = activatedby;
    
    if ( isdefined( activatedby ) )
    {
        scoreevents::processscoreevent( "forward_spawn_activated", activatedby );
    }
    
    level notify( #"forward_spawn_activated", { #spawn_ent:self, #activator:activatedby } );
}

// Namespace forward_spawn/forward_spawn
// Params 2, eflags: 0x4
// Checksum 0x82be5584, Offset: 0x1e08
// Size: 0x1ac
function private setforwardspawndeactived( team, deactivatedby )
{
    if ( !isdefined( self.forwardspawnactive ) || !self.forwardspawnactive )
    {
        return;
    }
    
    if ( !userspawnselection::isspawnselectenabled() )
    {
        return;
    }
    else
    {
        self changespawnstate( 0, team );
    }
    
    self gameobjects::set_flags( 0 );
    objective_setgamemodeflags( self.nonsupport_objectiveid, 0 );
    self setupforwardspawnforactivation();
    
    if ( isdefined( self.returntoneutral ) && self.returntoneutral )
    {
        self setteam( "neutral" );
        objective_setteam( self.nonsupport_objectiveid, "neutral" );
        objective_setprogress( self.nonsupport_objectiveid, 0 );
    }
    
    self.forwardspawnactive = 0;
    self.activatedby = undefined;
    level.forwardspawnsettings.activeforwardspawn = undefined;
    
    if ( isdefined( deactivatedby ) )
    {
        scoreevents::processscoreevent( "forward_spawn_deactivated", deactivatedby );
    }
    
    level notify( #"forward_spawn_deactivated", { #spawn_ent:self, #activator:deactivatedby } );
}

// Namespace forward_spawn/forward_spawn
// Params 1, eflags: 0x4
// Checksum 0x770d3f67, Offset: 0x1fc0
// Size: 0x52
function private getuseratemultipliercallback( touching_player )
{
    if ( array::contains( touching_player.specialty, "specialty_forwardspawnfastinteract" ) )
    {
        return level.forwardspawnsettings.fastusemultiplier;
    }
    
    return 1;
}

// Namespace forward_spawn/forward_spawn
// Params 1, eflags: 0x4
// Checksum 0x1877ac76, Offset: 0x2020
// Size: 0x678
function private setupforwardspawn( forward_spawner_ent )
{
    visuals = getentarray( forward_spawner_ent.targetname + "_visual", "targetname" );
    clipbrushes = getentarray( forward_spawner_ent.targetname + "_clip", "targetname" );
    enabletrigger = undefined;
    usetrigfromradiant = getent( forward_spawner_ent.targetname + "_trig", "targetname" );
    
    if ( level.forwardspawnsettings.useproximityactivate )
    {
        arbitrarytriggerheight = 80;
        enabletrigger = spawn( "trigger_radius", usetrigfromradiant.origin, 0, level.forwardspawnsettings.proximityradius, arbitrarytriggerheight );
    }
    else
    {
        enabletrigger = usetrigfromradiant;
    }
    
    enabletrigger triggerignoreteam();
    enabletrigger setvisibletoall();
    enabletrigger setteamfortrigger( "none" );
    enabletrigger usetriggerrequirelookat();
    enabletrigger setcursorhint( "HINT_NOICON" );
    objectivestr = istring( forward_spawner_ent.script_objective );
    owningteam = undefined;
    
    if ( level.forwardspawnsettings.isneutral )
    {
        owningteam = "neutral";
    }
    else
    {
        owningteam = getteamname( forward_spawner_ent.script_team );
    }
    
    forwardspawngo = gameobjects::create_use_object( owningteam, enabletrigger, visuals, ( 0, 0, 0 ), objectivestr, 1, 1 );
    
    if ( owningteam == "neutral" )
    {
        forwardspawngo.returntoneutral = 1;
        forwardspawngo gameobjects::set_owner_team( owningteam );
    }
    
    forwardspawngo.onbeginuse = &onbeginuse;
    forwardspawngo.onenduse = &onenduse;
    forwardspawngo.onuse = &onuseobject;
    forwardspawngo.oncantuse = &oncantuse;
    forwardspawngo gameobjects::set_use_multiplier_callback( &getuseratemultipliercallback );
    forwardspawngo.spawn_name = forward_spawner_ent.groupname;
    forwardspawngo.spawnlistname = forward_spawner_ent.script_noteworthy;
    forwardspawngo.disableafteractivate = isdefined( forward_spawner_ent.spawnflags ) && ( forward_spawner_ent.spawnflags & 2 ) == 2;
    forwardspawngo.objectivename = forward_spawner_ent.script_objective;
    forwardspawngo.spawngroupname = forward_spawner_ent.script_noteworthy;
    forwardspawngo.forwardspawnactive = 0;
    
    if ( level.forwardspawnsettings.forwardspawntakesdamage == 0 )
    {
        foreach ( visual in forwardspawngo.visuals )
        {
            visual.team = "free";
        }
    }
    
    spawns = struct::get_array( forwardspawngo.spawn_name, "targetname" );
    
    if ( !isdefined( spawns ) )
    {
        println( "Forward spawns " + forwardspawngo.spawn_name + " with no matching spawns!" );
        return;
    }
    
    if ( !userspawnselection::isspawnselectenabled() )
    {
        return;
    }
    
    level.forward_spawns[ forwardspawngo.spawn_name ] = forwardspawngo;
    
    if ( isdefined( forward_spawner_ent.spawnflags ) && ( forward_spawner_ent.spawnflags & 1 ) == 1 )
    {
        forwardspawngo setupforwardspawnforactivation();
    }
    
    forwardspawngo.nonsupport_objectiveid = gameobjects::get_next_obj_id();
    objective_add( forwardspawngo.nonsupport_objectiveid, "invisible", forwardspawngo.origin, istring( "forward_spawn_nonsupport" ) );
    objective_setteam( forwardspawngo.nonsupport_objectiveid, owningteam );
    forwardspawngo.nonsupporttrigger = getent( forward_spawner_ent.targetname + "_nonsupport_trig", "targetname" );
}

// Namespace forward_spawn/forward_spawn
// Params 1, eflags: 0x4
// Checksum 0xde4c75a8, Offset: 0x26a0
// Size: 0x64
function private onbeginuse( player )
{
    interactingteam = player.pers[ "team" ];
    
    if ( !self.forwardspawnactive )
    {
        player.activatingforwardspawn = 1;
        return;
    }
    
    player.deactivatingforwardspawn = 1;
}

// Namespace forward_spawn/forward_spawn
// Params 3, eflags: 0x4
// Checksum 0x41db3c15, Offset: 0x2710
// Size: 0x70
function private onenduse( team, player, result )
{
    interactingteam = player.pers[ "team" ];
    
    if ( !self.forwardspawnactive )
    {
        player.activatingforwardspawn = 0;
        return;
    }
    
    player.deactivatingforwardspawn = 0;
}

// Namespace forward_spawn/forward_spawn
// Params 1, eflags: 0x4
// Checksum 0xb06e25ef, Offset: 0x2788
// Size: 0xdc
function private onuseobject( player )
{
    if ( !self.forwardspawnactive )
    {
        self setforwardspawnactive( player.pers[ "team" ], player );
        return;
    }
    
    if ( !self.disableafteractivate )
    {
        self setforwardspawndeactived( player.pers[ "team" ], player );
        
        if ( level.forwardspawnsettings.isneutral )
        {
            self setforwardspawnactive( player.pers[ "team" ], player );
        }
        
        return;
    }
    
    self disable();
}

// Namespace forward_spawn/forward_spawn
// Params 1, eflags: 0x4
// Checksum 0x86f4806d, Offset: 0x2870
// Size: 0xc
function private oncantuse( player )
{
    
}

// Namespace forward_spawn/forward_spawn
// Params 0, eflags: 0x4
// Checksum 0x55932b1c, Offset: 0x2888
// Size: 0xc0
function private on_player_disconnect()
{
    if ( !isforwardspawnactive() )
    {
        return;
    }
    
    foreach ( forwardspawn in level.forward_spawns )
    {
        if ( isdefined( forwardspawn.activatedby ) && forwardspawn.activatedby == self )
        {
            forwardspawn.activatedby = undefined;
        }
    }
}

// Namespace forward_spawn/forward_spawn
// Params 2, eflags: 0x4
// Checksum 0x8b0ba6d5, Offset: 0x2950
// Size: 0x1e2
function private changespawnstate( ison, team )
{
    spawngroups = userspawnselection::getspawngroupwithscriptnoteworthy( self.spawngroupname );
    
    if ( !isdefined( spawngroups ) )
    {
        /#
            print( "Cannot find spawn group named " + self.spawnlistname + "\n" );
        #/
    }
    
    foreach ( spawngroup in spawngroups )
    {
        if ( !spawngroup.isforwardspawn )
        {
            continue;
        }
        
        if ( level.useteamspecificforwardspawns )
        {
            correctedteam = userspawnselection::getteamname( spawngroup.script_team );
            
            if ( correctedteam != team )
            {
                spawngroup userspawnselection::changeusability( 0 );
                continue;
            }
        }
        
        spawngroup userspawnselection::changeusability( ison );
        
        if ( level.forwardspawnsettings.isneutral && !level.useteamspecificforwardspawns )
        {
            if ( ison )
            {
                spawngroup userspawnselection::changeteam( team );
                continue;
            }
            
            spawngroup userspawnselection::changeteam( "neutral" );
        }
    }
}

// Namespace forward_spawn/forward_spawn
// Params 0, eflags: 0x4
// Checksum 0x50f58444, Offset: 0x2b40
// Size: 0x178
function private handleforwardspawnactivated()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        waitresult = level waittill( "forward_spawn_activated" );
        forwardspawnent = waitresult.spawn_ent;
        player = waitresult.activator;
        offenceteam = player.pers[ "team" ];
        defenceteam = util::getotherteam( offenceteam );
        
        if ( isdefined( level.forwardspawnsettings.audioplaybackfunc ) )
        {
            [[ level.forwardspawnsettings.audioplaybackfunc ]]( "warSpawnOnlineOfs", offenceteam, undefined, forwardspawnent.objectivename );
            [[ level.forwardspawnsettings.audioplaybackfunc ]]( "warSpawnOnlineDef", defenceteam, undefined, forwardspawnent.objectivename );
        }
        
        teamclientfield = userspawnselection::getteamclientfieldvalue( offenceteam );
        clientfield::set_world_uimodel( "hudItems.war.forwardSpawnStatus", teamclientfield );
    }
}

// Namespace forward_spawn/forward_spawn
// Params 0, eflags: 0x4
// Checksum 0x2fe50c8d, Offset: 0x2cc0
// Size: 0x160
function private handleforwardspawndeactivated()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        waitresult = level waittill( "forward_spawn_deactivated" );
        forwardspawnent = waitresult.spawn_ent;
        player = waitresult.activator;
        
        if ( isdefined( player ) )
        {
            defenceteam = player.pers[ "team" ];
            offenceteam = util::getotherteam( defenceteam );
            
            if ( isdefined( level.forwardspawnsettings.audioplaybackfunc ) )
            {
                [[ level.forwardspawnsettings.audioplaybackfunc ]]( "warSpawnOfflineOfs", offenceteam, undefined, forwardspawnent.objectivename );
                [[ level.forwardspawnsettings.audioplaybackfunc ]]( "warSpawnOfflineDef", defenceteam, undefined, forwardspawnent.objectivename );
            }
        }
        
        clientfield::set_world_uimodel( "hudItems.war.forwardSpawnStatus", 0 );
    }
}

// Namespace forward_spawn/forward_spawn
// Params 0
// Checksum 0x9db41437, Offset: 0x2e28
// Size: 0x24
function setup_forwardspawn_waits()
{
    thread handleforwardspawnactivated();
    thread handleforwardspawndeactivated();
}

