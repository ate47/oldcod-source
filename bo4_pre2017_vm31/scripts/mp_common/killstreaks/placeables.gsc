#using scripts/core_common/clientfield_shared;
#using scripts/core_common/killstreaks_shared;
#using scripts/core_common/oob;
#using scripts/core_common/struct;
#using scripts/core_common/util_shared;
#using scripts/mp_common/killstreaks/killstreak_detect;
#using scripts/mp_common/killstreaks/killstreaks;
#using scripts/mp_common/util;

#namespace placeables;

// Namespace placeables/placeables
// Params 19
// Checksum 0xfb6eab2a, Offset: 0x2c8
// Size: 0x5c8
function spawnplaceable( killstreakref, killstreakid, onplacecallback, oncancelcallback, onmovecallback, onshutdowncallback, ondeathcallback, onempcallback, model, validmodel, invalidmodel, spawnsvehicle, pickupstring, timeout, health, empdamage, placehintstring, invalidlocationhintstring, placeimmediately )
{
    if ( !isdefined( placeimmediately ) )
    {
        placeimmediately = 0;
    }
    
    player = self;
    self killstreaks::switch_to_last_non_killstreak_weapon();
    placeable = spawn( "script_model", player.origin );
    placeable.cancelable = 1;
    placeable.held = 0;
    placeable.validmodel = validmodel;
    placeable.invalidmodel = invalidmodel;
    placeable.killstreakid = killstreakid;
    placeable.killstreakref = killstreakref;
    placeable.oncancel = oncancelcallback;
    placeable.onemp = onempcallback;
    placeable.onmove = onmovecallback;
    placeable.onplace = onplacecallback;
    placeable.onshutdown = onshutdowncallback;
    placeable.ondeath = ondeathcallback;
    placeable.owner = player;
    placeable.originalowner = player;
    placeable.ownerentnum = player.entnum;
    placeable.originalownerentnum = player.entnum;
    placeable.pickupstring = pickupstring;
    placeable.placedmodel = model;
    placeable.spawnsvehicle = spawnsvehicle;
    placeable.originalteam = player.team;
    placeable.timedout = 0;
    placeable.timeout = timeout;
    placeable.timeoutstarted = 0;
    placeable.angles = ( 0, player.angles[ 1 ], 0 );
    placeable.placehintstring = placehintstring;
    placeable.invalidlocationhintstring = invalidlocationhintstring;
    placeable.placeimmediately = placeimmediately;
    
    if ( !isdefined( placeable.placehintstring ) )
    {
        placeable.placehintstring = "";
    }
    
    if ( !isdefined( placeable.invalidlocationhintstring ) )
    {
        placeable.invalidlocationhintstring = "";
    }
    
    placeable notsolid();
    
    if ( isdefined( placeable.vehicle ) )
    {
        placeable.vehicle notsolid();
    }
    
    placeable.othermodel = spawn( "script_model", player.origin );
    placeable.othermodel setmodel( placeable.placedmodel );
    placeable.othermodel setinvisibletoplayer( player );
    placeable.othermodel notsolid();
    placeable.othermodel clientfield::set( "enemyvehicle", 1 );
    placeable killstreaks::configure_team( killstreakref, killstreakid, player );
    
    if ( isdefined( health ) && health > 0 )
    {
        placeable.health = health;
        placeable setcandamage( 0 );
        placeable thread killstreaks::monitordamage( killstreakref, health, &ondeath, 0, undefined, empdamage, &onemp, 1 );
    }
    
    player thread carryplaceable( placeable );
    level thread cancelongameend( placeable );
    player thread shutdownoncancelevent( placeable );
    player thread cancelonplayerdisconnect( placeable );
    placeable thread watchownergameevents();
    return placeable;
}

// Namespace placeables/placeables
// Params 3
// Checksum 0xd8117352, Offset: 0x898
// Size: 0x68
function updateplacementmodels( model, validmodel, invalidmodel )
{
    placeable = self;
    placeable.placedmodel = model;
    placeable.validmodel = validmodel;
    placeable.invalidmodel = invalidmodel;
}

// Namespace placeables/placeables
// Params 1
// Checksum 0xc93aa118, Offset: 0x908
// Size: 0x194
function carryplaceable( placeable )
{
    player = self;
    placeable show();
    placeable notsolid();
    
    if ( isdefined( placeable.vehicle ) )
    {
        placeable.vehicle notsolid();
    }
    
    if ( isdefined( placeable.othermodel ) )
    {
        placeable thread util::ghost_wait_show_to_player( player, 0.05, "abort_ghost_wait_show" );
        placeable.othermodel thread util::ghost_wait_show_to_others( player, 0.05, "abort_ghost_wait_show" );
        placeable.othermodel notsolid();
    }
    
    placeable.held = 1;
    player.holding_placeable = placeable;
    player carryturret( placeable, ( 40, 0, 0 ), ( 0, 0, 0 ) );
    player util::_disableweapon();
    player thread watchplacement( placeable );
}

// Namespace placeables/placeables
// Params 0
// Checksum 0x8b3ca4b8, Offset: 0xaa8
// Size: 0x10e, Type: bool
function innoplacementtrigger()
{
    placeable = self;
    
    if ( isdefined( level.noturretplacementtriggers ) )
    {
        for ( i = 0; i < level.noturretplacementtriggers.size ; i++ )
        {
            if ( placeable istouching( level.noturretplacementtriggers[ i ] ) )
            {
                return true;
            }
        }
    }
    
    if ( isdefined( level.fatal_triggers ) )
    {
        for ( i = 0; i < level.fatal_triggers.size ; i++ )
        {
            if ( placeable istouching( level.fatal_triggers[ i ] ) )
            {
                return true;
            }
        }
    }
    
    if ( placeable oob::istouchinganyoobtrigger() )
    {
        return true;
    }
    
    return false;
}

// Namespace placeables/placeables
// Params 1
// Checksum 0x67be2d26, Offset: 0xbc0
// Size: 0x180
function waitforplaceabletobebuilt( player )
{
    placeable = self;
    buildlength = placeable.buildtime * 1000;
    
    if ( isdefined( placeable.buildstartedfunc ) )
    {
        if ( ![[ placeable.buildstartedfunc ]]( placeable, player ) )
        {
            return 0;
        }
    }
    
    starttime = gettime();
    endtime = starttime + buildlength;
    finishedbuilding = 1;
    
    while ( gettime() < endtime )
    {
        if ( !player attackbuttonpressed() )
        {
            finishedbuilding = 0;
            break;
        }
        
        if ( isdefined( placeable.buildprogressfunc ) )
        {
            [[ placeable.buildprogressfunc ]]( placeable, player, ( gettime() - starttime ) / buildlength );
        }
        
        waitframe( 1 );
    }
    
    finished = player attackbuttonpressed();
    
    if ( isdefined( placeable.buildfinishedfunc ) )
    {
        [[ placeable.buildfinishedfunc ]]( placeable, player, finishedbuilding );
    }
    
    return finishedbuilding;
}

// Namespace placeables/placeables
// Params 1
// Checksum 0x8e715a65, Offset: 0xd48
// Size: 0x836
function watchplacement( placeable )
{
    player = self;
    player endon( #"disconnect" );
    player endon( #"death" );
    placeable endon( #"placed" );
    placeable endon( #"cancelled" );
    player thread watchcarrycancelevents( placeable );
    lastattempt = -1;
    placeable.canbeplaced = 0;
    waitingforattackbuttonrelease = 1;
    
    while ( true )
    {
        placement = player canplayerplaceturret();
        placeable.origin = placement[ "origin" ];
        placeable.angles = placement[ "angles" ];
        placeable.canbeplaced = placement[ "result" ] && !placeable innoplacementtrigger();
        
        if ( player.laststand === 1 )
        {
            placeable.canbeplaced = 0;
        }
        
        if ( isdefined( placeable.othermodel ) )
        {
            placeable.othermodel.origin = placement[ "origin" ];
            placeable.othermodel.angles = placement[ "angles" ];
        }
        
        if ( placeable.canbeplaced != lastattempt )
        {
            if ( placeable.canbeplaced )
            {
                placeable setmodel( placeable.validmodel );
                player sethintstring( istring( placeable.placehintstring ) );
            }
            else
            {
                placeable setmodel( placeable.invalidmodel );
                player sethintstring( istring( placeable.invalidlocationhintstring ) );
            }
            
            lastattempt = placeable.canbeplaced;
        }
        
        while ( waitingforattackbuttonrelease && !player attackbuttonpressed() )
        {
            waitingforattackbuttonrelease = 0;
        }
        
        if ( !waitingforattackbuttonrelease && placeable.canbeplaced && player attackbuttonpressed() || placeable.placeimmediately )
        {
            buildallowed = 1;
            
            if ( isdefined( placeable.buildtime ) && placeable.buildtime > 0 )
            {
                player sethintstring( istring( placeable.buildinghintstring ) );
                finishedbuilding = placeable waitforplaceabletobebuilt( player );
                
                if ( !finishedbuilding )
                {
                    buildallowed = 0;
                    player sethintstring( istring( placeable.placehintstring ) );
                }
            }
            
            if ( placement[ "result" ] && buildallowed )
            {
                placeable.origin = placement[ "origin" ];
                placeable.angles = placement[ "angles" ];
                player sethintstring( "" );
                player stopcarryturret( placeable );
                
                if ( !player util::isweaponenabled() )
                {
                    player util::_enableweapon();
                }
                
                placeable.held = 0;
                player.holding_placeable = undefined;
                placeable.cancelable = 0;
                
                if ( isdefined( placeable.health ) && placeable.health )
                {
                    placeable setcandamage( 1 );
                    placeable solid();
                }
                
                if ( isdefined( placeable.vehicle ) )
                {
                    placeable.vehicle setcandamage( 1 );
                    placeable.vehicle solid();
                }
                
                if ( isdefined( placeable.placedmodel ) && !placeable.spawnsvehicle )
                {
                    placeable setmodel( placeable.placedmodel );
                }
                else
                {
                    placeable notify( #"abort_ghost_wait_show" );
                    placeable.abort_ghost_wait_show_to_player = 1;
                    placeable.abort_ghost_wait_show_to_others = 1;
                    placeable ghost();
                    
                    if ( isdefined( placeable.othermodel ) )
                    {
                        placeable.othermodel notify( #"abort_ghost_wait_show" );
                        placeable.othermodel.abort_ghost_wait_show_to_player = 1;
                        placeable.othermodel.abort_ghost_wait_show_to_others = 1;
                        placeable.othermodel ghost();
                    }
                }
                
                if ( isdefined( placeable.timeout ) )
                {
                    if ( !placeable.timeoutstarted )
                    {
                        placeable.timeoutstarted = 1;
                        placeable thread killstreaks::waitfortimeout( placeable.killstreakref, placeable.timeout, &ontimeout, "death", "cancelled" );
                    }
                    else if ( placeable.timedout )
                    {
                        placeable thread killstreaks::waitfortimeout( placeable.killstreakref, 5000, &ontimeout, "cancelled" );
                    }
                }
                
                if ( isdefined( placeable.onplace ) )
                {
                    player [[ placeable.onplace ]]( placeable );
                    
                    if ( isdefined( placeable.onmove ) && !placeable.timedout )
                    {
                        spawnmovetrigger( placeable, player );
                    }
                }
                
                placeable notify( #"placed" );
            }
        }
        
        if ( placeable.cancelable && player actionslotfourbuttonpressed() )
        {
            placeable notify( #"cancelled" );
        }
        
        waitframe( 1 );
    }
}

// Namespace placeables/placeables
// Params 1
// Checksum 0xa08ec794, Offset: 0x1588
// Size: 0xac
function watchcarrycancelevents( placeable )
{
    player = self;
    assert( isplayer( player ) );
    placeable endon( #"cancelled" );
    placeable endon( #"placed" );
    player waittill( "death", "emp_jammed", "emp_grenaded", "disconnect", "joined_team" );
    placeable notify( #"cancelled" );
}

// Namespace placeables/placeables
// Params 0
// Checksum 0x4d58ce36, Offset: 0x1640
// Size: 0x94
function ontimeout()
{
    placeable = self;
    
    if ( isdefined( placeable.held ) && placeable.held )
    {
        placeable.timedout = 1;
        return;
    }
    
    placeable notify( #"delete_placeable_trigger" );
    placeable thread killstreaks::waitfortimeout( placeable.killstreakref, 5000, &forceshutdown, "cancelled" );
}

// Namespace placeables/placeables
// Params 2
// Checksum 0xc5fc7d68, Offset: 0x16e0
// Size: 0x64
function ondeath( attacker, weapon )
{
    placeable = self;
    
    if ( isdefined( placeable.ondeath ) )
    {
        [[ placeable.ondeath ]]( attacker, weapon );
    }
    
    placeable notify( #"cancelled" );
}

// Namespace placeables/placeables
// Params 1
// Checksum 0x973934a9, Offset: 0x1750
// Size: 0x4c
function onemp( attacker )
{
    placeable = self;
    
    if ( isdefined( placeable.onemp ) )
    {
        placeable [[ placeable.onemp ]]( attacker );
    }
}

// Namespace placeables/placeables
// Params 1
// Checksum 0x8cfe71e9, Offset: 0x17a8
// Size: 0x9c
function cancelonplayerdisconnect( placeable )
{
    placeable endon( #"hacked" );
    player = self;
    assert( isplayer( player ) );
    placeable endon( #"cancelled" );
    placeable endon( #"death" );
    player waittill( "disconnect", "joined_team" );
    placeable notify( #"cancelled" );
}

// Namespace placeables/placeables
// Params 1
// Checksum 0x3b194d26, Offset: 0x1850
// Size: 0x4c
function cancelongameend( placeable )
{
    placeable endon( #"cancelled" );
    placeable endon( #"death" );
    level waittill( "game_ended" );
    placeable notify( #"cancelled" );
}

// Namespace placeables/placeables
// Params 2
// Checksum 0x71a59748, Offset: 0x18a8
// Size: 0x13c
function spawnmovetrigger( placeable, player )
{
    pos = placeable.origin + ( 0, 0, 15 );
    placeable.pickuptrigger = spawn( "trigger_radius_use", pos );
    placeable.pickuptrigger setcursorhint( "HINT_NOICON", placeable );
    placeable.pickuptrigger sethintstring( placeable.pickupstring );
    placeable.pickuptrigger setteamfortrigger( player.team );
    player clientclaimtrigger( placeable.pickuptrigger );
    placeable thread watchpickup( player );
    placeable.pickuptrigger thread watchmovetriggershutdown( placeable );
}

// Namespace placeables/placeables
// Params 1
// Checksum 0x51c211da, Offset: 0x19f0
// Size: 0x6c
function watchmovetriggershutdown( placeable )
{
    trigger = self;
    placeable waittill( "cancelled", "picked_up", "death", "delete_placeable_trigger", "hacker_delete_placeable_trigger" );
    placeable.pickuptrigger delete();
}

// Namespace placeables/placeables
// Params 1
// Checksum 0x9530e922, Offset: 0x1a68
// Size: 0x362
function watchpickup( player )
{
    placeable = self;
    placeable endon( #"death" );
    placeable endon( #"cancelled" );
    assert( isdefined( placeable.pickuptrigger ) );
    trigger = placeable.pickuptrigger;
    
    while ( true )
    {
        waitresult = trigger waittill( "trigger" );
        player = waitresult.activator;
        
        if ( !isalive( player ) )
        {
            continue;
        }
        
        if ( player isusingoffhand() )
        {
            continue;
        }
        
        if ( !player isonground() )
        {
            continue;
        }
        
        if ( isdefined( placeable.vehicle ) && placeable.vehicle.control_initiated === 1 )
        {
            continue;
        }
        
        if ( isdefined( player.carryobject ) && player.carryobject.disallowplaceablepickup === 1 )
        {
            continue;
        }
        
        if ( isdefined( trigger.triggerteam ) && player.team != trigger.triggerteam )
        {
            continue;
        }
        
        if ( isdefined( trigger.claimedby ) && player != trigger.claimedby )
        {
            continue;
        }
        
        if ( player usebuttonpressed() && !player.throwinggrenade && !player meleebuttonpressed() && !player attackbuttonpressed() && !( isdefined( player.isplanting ) && player.isplanting ) && !( isdefined( player.isdefusing ) && player.isdefusing ) && !player isremotecontrolling() && !isdefined( player.holding_placeable ) )
        {
            placeable notify( #"picked_up" );
            placeable.held = 1;
            placeable setcandamage( 0 );
            assert( isdefined( placeable.onmove ) );
            player [[ placeable.onmove ]]( placeable );
            player thread carryplaceable( placeable );
            return;
        }
    }
}

// Namespace placeables/placeables
// Params 0
// Checksum 0x1f684194, Offset: 0x1dd8
// Size: 0x34
function forceshutdown()
{
    placeable = self;
    placeable.cancelable = 0;
    placeable notify( #"cancelled" );
}

// Namespace placeables/placeables
// Params 0
// Checksum 0xe2bcb297, Offset: 0x1e18
// Size: 0x9c
function watchownergameevents()
{
    self notify( #"watchownergameevents_singleton" );
    self endon( #"watchownergameevents_singleton" );
    placeable = self;
    placeable endon( #"cancelled" );
    placeable.owner waittill( "joined_team", "disconnect", "joined_spectators" );
    
    if ( isdefined( placeable ) )
    {
        placeable.abandoned = 1;
        placeable forceshutdown();
    }
}

// Namespace placeables/placeables
// Params 1
// Checksum 0xc033b364, Offset: 0x1ec0
// Size: 0x254
function shutdownoncancelevent( placeable )
{
    placeable endon( #"hacked" );
    player = self;
    assert( isplayer( player ) );
    placeable waittill( "cancelled", "death" );
    
    if ( isdefined( player ) && isdefined( placeable ) && placeable.held === 1 )
    {
        player sethintstring( "" );
        player stopcarryturret( placeable );
        
        if ( !player util::isweaponenabled() )
        {
            player util::_enableweapon();
        }
    }
    
    if ( isdefined( placeable ) )
    {
        if ( placeable.cancelable )
        {
            if ( isdefined( placeable.oncancel ) )
            {
                [[ placeable.oncancel ]]( placeable );
            }
        }
        else if ( isdefined( placeable.onshutdown ) )
        {
            [[ placeable.onshutdown ]]( placeable );
        }
        
        if ( isdefined( placeable ) )
        {
            if ( isdefined( placeable.vehicle ) )
            {
                vehicle_to_kill = placeable.vehicle;
                vehicle_to_kill.selfdestruct = 1;
                vehicle_to_kill kill();
                placeable.vehicle = undefined;
                placeable.othermodel delete();
                placeable delete();
                return;
            }
            
            placeable.othermodel delete();
            placeable delete();
        }
    }
}

// Namespace placeables/placeables
// Params 5
// Checksum 0xf74c6067, Offset: 0x2120
// Size: 0xa0
function setbuildable( buildtime, buildstartfunction, buildprogressupdatedfunction, buildfinishedfunction, buildingstring )
{
    placeable = self;
    placeable.buildtime = buildtime;
    placeable.buildstartedfunc = buildstartfunction;
    placeable.buildprogressfunc = buildprogressupdatedfunction;
    placeable.buildfinishedfunc = buildfinishedfunction;
    placeable.buildinghintstring = buildingstring;
}

