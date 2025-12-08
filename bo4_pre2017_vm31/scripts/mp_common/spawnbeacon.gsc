#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/gameobjects_shared;
#using scripts/core_common/influencers_shared;
#using scripts/core_common/killstreaks_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/weapon_utils;
#using scripts/mp_common/gametypes/globallogic_audio;
#using scripts/mp_common/killstreaks/killstreak_bundles;
#using scripts/mp_common/killstreaks/killstreakrules;
#using scripts/mp_common/killstreaks/killstreaks;
#using scripts/mp_common/killstreaks/placeables;
#using scripts/mp_common/userspawnselection;

#namespace spawn_beacon;

// Namespace spawn_beacon/spawnbeacon
// Params 0
// Checksum 0x69094c95, Offset: 0x898
// Size: 0x114
function init()
{
    level.spawnbeaconsettings = spawnstruct();
    level.spawnbeaconsettings.userspawnbeacons = [];
    level.spawnbeaconsettings.availablespawnlists = [];
    level.spawnbeaconsettings.objectivezones = [];
    level.spawnbeaconsettings.beaconweapon = getweapon( "spawnbeacon" );
    level.spawnbeaconsettings.audiothrottletracker = [];
    setupstrings();
    setupspawnlists();
    loadspawnbeaconsettings();
    setupcallbacks();
    setupfx();
    setupclientfields();
}

// Namespace spawn_beacon/spawnbeacon
// Params 2
// Checksum 0x209addbe, Offset: 0x9b8
// Size: 0xda
function playcommanderaudio( soundbank, team )
{
    if ( !isdefined( level.spawnbeaconsettings.audiothrottletracker[ soundbank ] ) )
    {
        level.spawnbeaconsettings.audiothrottletracker[ soundbank ] = 0;
    }
    
    lasttimeplayed = level.spawnbeaconsettings.audiothrottletracker[ soundbank ];
    
    if ( lasttimeplayed != 0 && gettime() < 5000 + lasttimeplayed )
    {
        return;
    }
    
    globallogic_audio::leader_dialog( soundbank, team, undefined, "spawnbeacon" );
    level.spawnbeaconsettings.audiothrottletracker[ soundbank ] = gettime();
}

// Namespace spawn_beacon/spawnbeacon
// Params 0
// Checksum 0xcc73df64, Offset: 0xaa0
// Size: 0x34
function setupclientfields()
{
    clientfield::register( "clientuimodel", "hudItems.spawnbeacon.cooldownPenalty", 1, 6, "int" );
}

// Namespace spawn_beacon/spawnbeacon
// Params 1
// Checksum 0x5c01c852, Offset: 0xae0
// Size: 0x34
function addprotectedzone( zone )
{
    array::add( level.spawnbeaconsettings.objectivezones, zone );
}

// Namespace spawn_beacon/spawnbeacon
// Params 1
// Checksum 0x3e0f969c, Offset: 0xb20
// Size: 0x34
function removeprotectedzone( zone )
{
    arrayremovevalue( level.spawnbeaconsettings.objectivezones, zone );
}

// Namespace spawn_beacon/spawnbeacon
// Params 0, eflags: 0x4
// Checksum 0xf0713b4e, Offset: 0xb60
// Size: 0x22
function private setupfx()
{
    level._effect[ "spawn_beacon_team_fx" ] = "light/fx8_light_gadget_spawn_beacon";
}

// Namespace spawn_beacon/spawnbeacon
// Params 0, eflags: 0x4
// Checksum 0x9f0c52ca, Offset: 0xb90
// Size: 0x42
function private setupstrings()
{
    game.strings[ "cannot_build_spawnbeacon" ] = &"SPAWNBEACON_CANNOT_BUILD";
    game.strings[ "cannot_build_nospawns" ] = &"SPAWNBEACON_CANNOT_BUILD_NO_SPAWNS";
}

// Namespace spawn_beacon/spawnbeacon
// Params 0, eflags: 0x4
// Checksum 0xd1b42d10, Offset: 0xbe0
// Size: 0x5e
function private setupspawnlists()
{
    for ( spawnlistidx = 0; spawnlistidx < 4 ; spawnlistidx++ )
    {
        array::add( level.spawnbeaconsettings.availablespawnlists, "spawnbeacon" + spawnlistidx );
    }
}

// Namespace spawn_beacon/spawnbeacon
// Params 0, eflags: 0x4
// Checksum 0xabb76ac0, Offset: 0xc48
// Size: 0x74
function private setupcallbacks()
{
    ability_player::register_gadget_activation_callbacks( 57, &gadget_spawnbeacon_on, &gadget_spawnbeacon_off );
    callback::on_player_killed_with_params( &on_player_killed );
    callback::on_spawned( &on_player_spawned );
}

// Namespace spawn_beacon/spawnbeacon
// Params 0, eflags: 0x4
// Checksum 0x43d6540f, Offset: 0xcc8
// Size: 0x3a8
function private loadspawnbeaconsettings()
{
    level.spawnbeaconsettings.beacons = [];
    level.spawnbeaconsettings.startinghealth = getgametypesetting( "spawnBeaconHealth" );
    collectionradiusmax = getgametypesetting( "spawnBeaconEffectMaximumRadius" );
    level.spawnbeaconsettings.spawnpointcollectionradius = collectionradiusmax * collectionradiusmax;
    collectionradiusmin = getgametypesetting( "spawnBeaconEffectMinimumRadius" );
    level.spawnbeaconsettings.spawnpointcollectionradiusmin = collectionradiusmin * collectionradiusmin;
    level.spawnbeaconsettings.maximumperuser = getgametypesetting( "spawnBeaconUserPlacementLimit" );
    level.spawnbeaconsettings.buildtime = getgametypesetting( "spawnBeaconBuildTime" ) * 1000;
    level.spawnbeaconsettings.rechargetime = getgametypesetting( "spawnBeaconRechargeTime" );
    level.spawnbeaconsettings.buildoffset = getgametypesetting( "spawnBeaconVisualOffsetFromPlayer" );
    level.spawnbeaconsettings.empmultiplier = getgametypesetting( "spawnBeaconDamageEMPMultiplier" );
    level.spawnbeaconsettings.bulletmultiplier = getgametypesetting( "spawnBeaconDamageBulletMultiplier" );
    level.spawnbeaconsettings.explosivemultiplier = getgametypesetting( "spawnBeaconDamageExplosiveMultiplier" );
    level.spawnbeaconsettings.tracesize = 16;
    level.spawnbeaconsettings.allowfriendlyfire = getgametypesetting( "spawnBeaconAllowFriendlyFireDamage" );
    level.spawnbeaconsettings.healthdeductionperspawn = getgametypesetting( "spawnBeaconHealthReductionPerSpawn" );
    level.spawnbeaconsettings.triggerradius = getgametypesetting( "spawnBeaconDeactivateTriggerRadius" );
    level.spawnbeaconsettings.triggerheight = 100;
    level.spawnbeaconsettings.deactivatetime = getgametypesetting( "spawnBeaconDeactivateTime" );
    level.spawnbeaconsettings.maxcooldownpenalty = getgametypesetting( "spawnBeaconDestroyedPenaltyMax" );
    level.spawnbeaconsettings.maxpower = 100;
    level.spawnbeaconsettings.spawnbeaconcanbedamaged = getgametypesetting( "spawnBeaconCanBeDamaged" );
    level.spawnbeaconsettings.destroyonteamchangeordisconnect = 1;
}

// Namespace spawn_beacon/spawnbeacon
// Params 0
// Checksum 0x1e40aad8, Offset: 0x1078
// Size: 0x5c
function on_player_spawned()
{
    player = self;
    spawnbeacon = player userspawnselection::getspawnbeaconplayerspawnedfrom();
    
    if ( !isdefined( spawnbeacon ) )
    {
        return;
    }
    
    player playerspawnedfromspawnbeacon( spawnbeacon );
}

// Namespace spawn_beacon/spawnbeacon
// Params 1
// Checksum 0xbef2ae8e, Offset: 0x10e0
// Size: 0xbc
function playerspawnedfromspawnbeacon( spawnbeacon )
{
    spawnbeacon.health -= level.spawnbeaconsettings.healthdeductionperspawn;
    spawnbeacon updatespawnbeaconhealth();
    
    if ( spawnbeacon.health <= 0 )
    {
        spawnbeacon destroyspawnbeacon( 1 );
    }
    
    if ( isdefined( spawnbeacon.owningplayer ) )
    {
        scoreevents::processscoreevent( "forward_spawn_assist", spawnbeacon.owningplayer );
    }
}

// Namespace spawn_beacon/spawnbeacon
// Params 0
// Checksum 0x5fb2e6fc, Offset: 0x11a8
// Size: 0x5a
function getnewspawnbeaconspawnlist()
{
    assert( level.spawnbeaconsettings.availablespawnlists.size > 0 );
    return array::pop( level.spawnbeaconsettings.availablespawnlists );
}

// Namespace spawn_beacon/spawnbeacon
// Params 1
// Checksum 0xfa291c75, Offset: 0x1210
// Size: 0x74
function freespawnbeaconspawnlist( spawnlistname )
{
    assert( !array::contains( level.spawnbeaconsettings.availablespawnlists, spawnlistname ) );
    array::push( level.spawnbeaconsettings.availablespawnlists, spawnlistname );
}

// Namespace spawn_beacon/spawnbeacon
// Params 2
// Checksum 0x8a8c3805, Offset: 0x1290
// Size: 0x84
function gadget_spawnbeacon_on( slot, weapon )
{
    player = self;
    assert( isplayer( player ) );
    player.isbuildingspawnbeacon = 1;
    thread buildspawnbeacon( slot, weapon, player );
}

// Namespace spawn_beacon/spawnbeacon
// Params 2
// Checksum 0x6d69c991, Offset: 0x1320
// Size: 0x34
function gadget_spawnbeacon_off( slot, weapon )
{
    player = self;
    player.isbuildingspawnbeacon = 0;
}

// Namespace spawn_beacon/spawnbeacon
// Params 1
// Checksum 0xa600b99, Offset: 0x1360
// Size: 0x94
function on_player_killed( s_params )
{
    if ( isdefined( self.spawnbeaconbuildprogressobjid ) )
    {
        deleteobjective( self.spawnbeaconbuildprogressobjid );
        self.spawnbeaconbuildprogressobjid = undefined;
    }
    
    if ( isdefined( self.isbuildingspawnbeacon ) && self.isbuildingspawnbeacon && isdefined( s_params.eattacker ) )
    {
        scoreevents::processscoreevent( "forward_spawn_stopped_activation", s_params.eattacker );
    }
}

// Namespace spawn_beacon/spawnbeacon
// Params 2
// Checksum 0xcb4cfed7, Offset: 0x1400
// Size: 0x150, Type: bool
function spawnbeaconbuildstarted( spawnbeacon, player )
{
    spawnbeaconspawns = getspawnbeaconspawns( spawnbeacon.origin );
    
    if ( spawnbeaconspawns.size == 0 )
    {
        return false;
    }
    
    spawnbeacon.progressobjectiveid = getobjectiveid();
    player.spawnbeaconbuildprogressobjid = spawnbeacon.progressobjectiveid;
    objective_add( spawnbeacon.progressobjectiveid, "active", spawnbeacon.origin, istring( "spawnbeacon_building" ) );
    objective_setprogress( spawnbeacon.progressobjectiveid, 0 );
    objective_visibleteams( spawnbeacon.progressobjectiveid, level.spawnsystem.ispawn_teammask[ "all" ] );
    player freezecontrolsallowlook( 1 );
    return true;
}

// Namespace spawn_beacon/spawnbeacon
// Params 3
// Checksum 0x6b3e6eff, Offset: 0x1558
// Size: 0x3c
function spawnbeaconbuildprogressupdated( spawnbeacon, player, prctbuilt )
{
    objective_setprogress( spawnbeacon.progressobjectiveid, prctbuilt );
}

// Namespace spawn_beacon/spawnbeacon
// Params 3
// Checksum 0x6d4df4e, Offset: 0x15a0
// Size: 0x64
function spawnbeaconbuildprogressfinished( spawnbeacon, player, success )
{
    deleteobjective( spawnbeacon.progressobjectiveid );
    player.spawnbeaconbuildprogressobjid = undefined;
    player freezecontrolsallowlook( 0 );
}

// Namespace spawn_beacon/spawnbeacon
// Params 0
// Checksum 0xdd697a52, Offset: 0x1610
// Size: 0x12
function getobjectiveid()
{
    return gameobjects::get_next_obj_id();
}

// Namespace spawn_beacon/spawnbeacon
// Params 1
// Checksum 0xae21c3a0, Offset: 0x1630
// Size: 0x3c
function deleteobjective( objectiveid )
{
    objective_delete( objectiveid );
    gameobjects::release_obj_id( objectiveid );
}

// Namespace spawn_beacon/spawnbeacon
// Params 0
// Checksum 0x8b07b1fb, Offset: 0x1678
// Size: 0x15c
function calculatecooldownpenalty()
{
    spawnbeacon = self;
    player = spawnbeacon.owningplayer;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( !player hasweapon( level.spawnbeaconsettings.beaconweapon ) )
    {
        return;
    }
    
    spawnbeaconslot = player gadgetgetslot( level.spawnbeaconsettings.beaconweapon );
    currentpower = player gadgetpowerget( spawnbeaconslot ) / 100;
    penalty = level.spawnbeaconsettings.maxcooldownpenalty - level.spawnbeaconsettings.maxcooldownpenalty * currentpower;
    player.spawnbeaconcooldownpenalty = int( penalty );
    player clientfield::set_player_uimodel( "hudItems.spawnbeacon.cooldownPenalty", player.spawnbeaconcooldownpenalty );
}

// Namespace spawn_beacon/spawnbeacon
// Params 1
// Checksum 0x76a79631, Offset: 0x17e0
// Size: 0x1a4
function destroyspawnbeacon( destroyedbyenemy )
{
    if ( isdefined( self.beacondisabled ) && self.beacondisabled )
    {
        return;
    }
    
    if ( level.spawnbeaconsettings.maxcooldownpenalty > 0 )
    {
        self calculatecooldownpenalty();
    }
    
    if ( destroyedbyenemy )
    {
        playcommanderaudio( "spawnBeaconDestroyedFriendly", self.team );
        playcommanderaudio( "spawnBeaconDestroyedEnemy", util::getotherteam( self.team ) );
    }
    
    deleteobjective( self.objectiveid );
    userspawnselection::removespawnbeacon( self.objectiveid );
    self.beacondisabled = 1;
    level.spawnbeaconsettings.beacons[ self.objectiveid ] = undefined;
    freespawnbeaconspawnlist( self.spawnlist );
    self clientfield::set( "enemyequip", 0 );
    
    if ( isdefined( self.disablegameobject ) )
    {
        self.disablegameobject gameobjects::destroy_object( 1, 1 );
    }
    
    self notify( #"beacon_removed" );
    self delete();
}

// Namespace spawn_beacon/spawnbeacon
// Params 1
// Checksum 0xb83b31bb, Offset: 0x1990
// Size: 0x184
function getspawnbeaconspawns( origin )
{
    spawnstoadd = [];
    
    foreach ( spawnpoint in level.allspawnpoints )
    {
        distsqr = distancesquared( origin, spawnpoint.origin );
        
        if ( distsqr > level.spawnbeaconsettings.spawnpointcollectionradius )
        {
            continue;
        }
        
        if ( distsqr < level.spawnbeaconsettings.spawnpointcollectionradiusmin )
        {
            continue;
        }
        
        if ( !isdefined( spawnpoint.enabled ) )
        {
            spawnpoint.enabled = -1;
        }
        
        if ( !isdefined( spawnstoadd ) )
        {
            spawnstoadd = [];
        }
        else if ( !isarray( spawnstoadd ) )
        {
            spawnstoadd = array( spawnstoadd );
        }
        
        spawnstoadd[ spawnstoadd.size ] = spawnpoint;
    }
    
    return spawnstoadd;
}

// Namespace spawn_beacon/spawnbeacon
// Params 1
// Checksum 0xbd4f1600, Offset: 0x1b20
// Size: 0x98, Type: bool
function createspawngroupforspawnbeacon( associatedspawnbeacon )
{
    spawnstoadd = getspawnbeaconspawns( associatedspawnbeacon.origin );
    
    if ( spawnstoadd.size == 0 )
    {
        return false;
    }
    
    associatedspawnbeacon.spawnlist = getnewspawnbeaconspawnlist();
    addspawnpoints( associatedspawnbeacon.team, spawnstoadd, associatedspawnbeacon.spawnlist );
    return true;
}

// Namespace spawn_beacon/spawnbeacon
// Params 1
// Checksum 0x5b854edd, Offset: 0x1bc0
// Size: 0x2d8
function rechargespawnbeacon( spawnbeacon )
{
    player = self;
    player endon( #"disconnect" );
    
    if ( !player hasweapon( level.spawnbeaconsettings.beaconweapon ) )
    {
        return;
    }
    
    spawnbeaconslot = player gadgetgetslot( level.spawnbeaconsettings.beaconweapon );
    spawnbeaconpower = self gadgetpowerget( spawnbeaconslot );
    lasttime = gettime();
    reachargerate = level.spawnbeaconsettings.maxpower / level.spawnbeaconsettings.rechargetime * 1000;
    
    while ( spawnbeaconpower < level.spawnbeaconsettings.maxpower )
    {
        waitframe( 1 );
        
        if ( !player hasweapon( level.spawnbeaconsettings.beaconweapon ) )
        {
            return;
        }
        
        spawnbeaconslot = player gadgetgetslot( level.spawnbeaconsettings.beaconweapon );
        currentgadgetpower = player gadgetpowerget( spawnbeaconslot );
        currenttime = gettime();
        timesincelast = currenttime - lasttime;
        lasttime = currenttime;
        newpower = timesincelast * reachargerate;
        spawnbeaconpower += newpower;
        self gadgetpowerset( spawnbeaconslot, spawnbeaconpower );
        
        if ( isdefined( player.spawnbeaconcooldownpenalty ) && player.spawnbeaconcooldownpenalty > 0 )
        {
            /#
                print( "SPAWN BEACON COOLDOWN PENALTY STARTED" );
            #/
            
            wait player.spawnbeaconcooldownpenalty;
            player.spawnbeaconcooldownpenalty = 0;
            player clientfield::set_player_uimodel( "hudItems.spawnbeacon.cooldownPenalty", player.spawnbeaconcooldownpenalty );
            lasttime = gettime();
            
            /#
                print( "SPAWN BEACON COOLDOWN PENALTY ENDED" );
            #/
        }
    }
}

// Namespace spawn_beacon/spawnbeacon
// Params 0
// Checksum 0xd021efc0, Offset: 0x1ea0
// Size: 0x6c
function updatespawnbeaconhealth()
{
    spawnbeacon = self;
    healthprct = spawnbeacon.health / level.spawnbeaconsettings.startinghealth;
    objective_setprogress( spawnbeacon.objectiveid, healthprct );
}

// Namespace spawn_beacon/spawnbeacon
// Params 0
// Checksum 0x157ffa13, Offset: 0x1f18
// Size: 0x314
function monitordamage()
{
    spawnbeacon = self;
    spawnbeacon endon( #"beacon_removed" );
    finalattacker = undefined;
    
    while ( spawnbeacon.health > 0 )
    {
        waitresult = spawnbeacon waittill( "damage" );
        weapon = waitresult.weapon;
        mod = waitresult.mod;
        amount = waitresult.amount;
        attacker = waitresult.attacker;
        damageapplied = waitresult.amount;
        spawnbeacon.health += amount;
        
        if ( !level.spawnbeaconsettings.allowfriendlyfire && attacker getteam() == spawnbeacon.team )
        {
            continue;
        }
        
        multiplier = weapon.isemp ? level.spawnbeaconsettings.empmultiplier : 0;
        
        if ( weapon_utils::isexplosivedamage( waitresult.mod ) )
        {
            multiplier += level.spawnbeaconsettings.explosivemultiplier;
        }
        
        if ( weapon_utils::isbulletdamage( waitresult.mod ) )
        {
            multiplier += level.spawnbeaconsettings.bulletmultiplier;
        }
        
        spawnbeacon.health = int( spawnbeacon.health - amount * multiplier );
        spawnbeacon updatespawnbeaconhealth();
        finalattacker = attacker;
        playcommanderaudio( "spawnBeaconUnderAttackFriendly", spawnbeacon.team );
    }
    
    destroyedbyenemy = 0;
    
    if ( isdefined( finalattacker ) && isplayer( finalattacker ) )
    {
        scoreevents::processscoreevent( "forward_spawn_deactivated", finalattacker );
        destroyedbyenemy = 1;
    }
    
    spawnbeacon thread destroyspawnbeacon( destroyedbyenemy );
}

// Namespace spawn_beacon/spawnbeacon
// Params 1
// Checksum 0x49ec866, Offset: 0x2238
// Size: 0x768
function placespawnbeacon( origin )
{
    player = self;
    
    if ( isdefined( level.spawnbeaconsettings.userspawnbeacons[ player.clientid ] ) && level.spawnbeaconsettings.userspawnbeacons[ player.clientid ].size >= level.spawnbeaconsettings.maximumperuser )
    {
        beacontoremove = array::pop_front( level.spawnbeaconsettings.userspawnbeacons[ player.clientid ] );
        
        if ( isdefined( beacontoremove ) )
        {
            beacontoremove destroyspawnbeacon( 0 );
        }
        else
        {
            level.spawnbeaconsettings.userspawnbeacons[ self.clientid ] = undefined;
        }
    }
    
    placedspawnbeacon = spawn( "script_model", origin );
    placedspawnbeacon setmodel( "p8_mp_gadget_spawn_beacon" );
    placedspawnbeacon setteam( player getteam() );
    placedspawnbeacon solid();
    placedspawnbeacon.owningplayer = player;
    placedspawnbeacon.objectiveid = getobjectiveid();
    objective_add( placedspawnbeacon.objectiveid, "active", placedspawnbeacon.origin, istring( "spawnbeacon_objective" ) );
    objective_setteam( placedspawnbeacon.objectiveid, placedspawnbeacon.team );
    objective_visibleteams( placedspawnbeacon.objectiveid, util::getteammask( player getteam() ) );
    objective_setprogress( placedspawnbeacon.objectiveid, 1 );
    createspawngroupforspawnbeacon( placedspawnbeacon );
    userspawnselection::registeravailablespawnbeacon( placedspawnbeacon.objectiveid, placedspawnbeacon );
    level.spawnbeaconsettings.beacons[ placedspawnbeacon.objectiveid ] = placedspawnbeacon;
    
    if ( !isdefined( level.spawnbeaconsettings.userspawnbeacons[ player.clientid ] ) )
    {
        level.spawnbeaconsettings.userspawnbeacons[ player.clientid ] = [];
    }
    
    array::push( level.spawnbeaconsettings.userspawnbeacons[ player.clientid ], placedspawnbeacon );
    placedfx = playfxontag( level._effect[ "spawn_beacon_team_fx" ], placedspawnbeacon, "tag_origin" );
    placedfx.team = placedspawnbeacon.team;
    placedspawnbeacon.health = level.spawnbeaconsettings.startinghealth;
    
    if ( level.spawnbeaconsettings.spawnbeaconcanbedamaged )
    {
        placedspawnbeacon setcandamage( 1 );
        placedspawnbeacon thread monitordamage();
    }
    
    scoreevents::processscoreevent( "forward_spawn_activated", player );
    placedspawnbeacon clientfield::set( "enemyequip", 1 );
    placedspawnbeacon.builttime = gettime();
    placedspawnbeacon playloopsound( "mpl_spawn_beacon_loop_npc" );
    playcommanderaudio( "spawnBeaconDeployedFriendly", player getteam() );
    playcommanderaudio( "spawnBeaconDeployedEnemy", util::getotherteam( player getteam() ) );
    
    if ( level.spawnbeaconsettings.deactivatetime > 0 )
    {
        usetrigger = spawn( "trigger_radius_use", origin, 0, level.spawnbeaconsettings.triggerradius, level.spawnbeaconsettings.triggerheight );
        usetrigger triggerignoreteam();
        usetrigger setvisibletoall();
        usetrigger setteamfortrigger( "none" );
        usetrigger setcursorhint( "HINT_NOICON" );
        placedspawnbeacon.disablegameobject = gameobjects::create_use_object( player getteam(), usetrigger, [], undefined, istring( "spawnbeacon_objective_disable" ) );
        placedspawnbeacon.disablegameobject gameobjects::set_use_hint_text( &"SPAWNBEACON_USE_TO_DISABLE" );
        placedspawnbeacon.disablegameobject gameobjects::set_visible_team( "enemy" );
        placedspawnbeacon.disablegameobject gameobjects::allow_use( "enemy" );
        placedspawnbeacon.disablegameobject gameobjects::set_use_time( level.spawnbeaconsettings.deactivatetime );
        placedspawnbeacon.disablegameobject.onuse = &onuseobject;
        placedspawnbeacon.disablegameobject.onbeginuse = &onbeginuse;
        placedspawnbeacon.disablegameobject.parentobj = placedspawnbeacon;
    }
    
    return placedspawnbeacon;
}

// Namespace spawn_beacon/spawnbeacon
// Params 1, eflags: 0x4
// Checksum 0xa8a05b2f, Offset: 0x29a8
// Size: 0x64
function private onbeginuse( player )
{
    playerteam = player getteam();
    playcommanderaudio( "spawnBeaconUnderAttackFriendly", util::getotherteam( playerteam ) );
}

// Namespace spawn_beacon/spawnbeacon
// Params 1, eflags: 0x4
// Checksum 0xa028dd9d, Offset: 0x2a18
// Size: 0x5c
function private onuseobject( player )
{
    spawnbeacon = self.parentobj;
    scoreevents::processscoreevent( "forward_spawn_deactivated", player );
    spawnbeacon thread destroyspawnbeacon( 1 );
}

// Namespace spawn_beacon/spawnbeacon
// Params 3
// Checksum 0x8bb8bdf8, Offset: 0x2a80
// Size: 0x5cc
function buildspawnbeacon( slot, weapon, player )
{
    forwardangles = anglestoforward( player getplayerangles() );
    beaconlocationraw = player.origin + ( forwardangles[ 0 ], forwardangles[ 1 ], 0 ) * level.spawnbeaconsettings.buildoffset;
    beacongroundlocation = util::ground_position( beaconlocationraw );
    trace_size = level.spawnbeaconsettings.tracesize;
    trace = physicstrace( player.origin, beacongroundlocation, ( trace_size * -1, trace_size * -1, 0 ), ( trace_size, trace_size, trace_size ), player );
    
    if ( trace[ "fraction" ] < 1 && trace[ "walkable" ] == 0 )
    {
        player iprintlnbold( game.strings[ "cannot_build_spawnbeacon" ] );
        return;
    }
    
    spawnbeaconspawns = getspawnbeaconspawns( beacongroundlocation );
    
    if ( spawnbeaconspawns.size == 0 )
    {
        player iprintlnbold( game.strings[ "cannot_build_nospawns" ] );
        return;
    }
    
    foreach ( protectedzone in level.spawnbeaconsettings.objectivezones )
    {
        if ( player istouchingswept( protectedzone ) )
        {
            player iprintlnbold( game.strings[ "cannot_build_spawnbeacon" ] );
            return;
        }
    }
    
    player freezecontrolsallowlook( 1 );
    player.isbuildingspawnbeacon = 1;
    spawnbeaconbuild = spawn( "script_model", beacongroundlocation );
    spawnbeaconbuild setmodel( "p8_mp_gadget_spawn_beacon_available" );
    progressobjectiveid = getobjectiveid();
    player.spawnbeaconbuildprogressobjid = progressobjectiveid;
    objective_add( progressobjectiveid, "active", beacongroundlocation, istring( "spawnbeacon_building" ) );
    objective_setprogress( progressobjectiveid, 0 );
    objective_visibleteams( progressobjectiveid, util::getteammask( player getteam() ) );
    starttime = gettime();
    
    for ( earlyexit = 0; gettime() - starttime < level.spawnbeaconsettings.buildtime && !earlyexit ; earlyexit = 1 )
    {
        waitframe( 1 );
        elapsedtime = gettime() - starttime;
        progress = elapsedtime / level.spawnbeaconsettings.buildtime;
        objective_setprogress( progressobjectiveid, progress );
        
        if ( !player.isbuildingspawnbeacon )
        {
            earlyexit = 1;
        }
        
        if ( !player fragbuttonpressed() )
        {
        }
    }
    
    if ( !earlyexit )
    {
        builtspawnbeacon = player placespawnbeacon( spawnbeaconbuild.origin );
        player gadgetdeactivate( slot, weapon );
        builtspawnbeacon.gadgetslot = slot;
        player gadgetpowerset( slot, 0 );
        player thread rechargespawnbeacon( builtspawnbeacon );
    }
    
    deleteobjective( progressobjectiveid );
    player.spawnbeaconbuildprogressobjid = undefined;
    player freezecontrolsallowlook( 0 );
    spawnbeaconbuild delete();
    player.isbuildingspawnbeacon = 0;
}

