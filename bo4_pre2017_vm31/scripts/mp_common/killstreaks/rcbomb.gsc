#using scripts/core_common/array_shared;
#using scripts/core_common/audio_shared;
#using scripts/core_common/challenges_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/hostmigration_shared;
#using scripts/core_common/hud_shared;
#using scripts/core_common/killstreaks_shared;
#using scripts/core_common/oob;
#using scripts/core_common/popups_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/struct;
#using scripts/core_common/tweakables_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/vehicle_death_shared;
#using scripts/core_common/vehicle_shared;
#using scripts/core_common/weapons/flashgrenades;
#using scripts/core_common/weapons/weaponobjects;
#using scripts/mp_common/challenges;
#using scripts/mp_common/gametypes/globallogic_audio;
#using scripts/mp_common/gametypes/globallogic_utils;
#using scripts/mp_common/gametypes/hostmigration;
#using scripts/mp_common/gametypes/shellshock;
#using scripts/mp_common/killstreaks/emp;
#using scripts/mp_common/killstreaks/killstreak_bundles;
#using scripts/mp_common/killstreaks/killstreak_detect;
#using scripts/mp_common/killstreaks/killstreak_hacking;
#using scripts/mp_common/killstreaks/killstreakrules;
#using scripts/mp_common/killstreaks/killstreaks;
#using scripts/mp_common/killstreaks/remote_weapons;
#using scripts/mp_common/util;

#namespace rcbomb;

// Namespace rcbomb/rcbomb
// Params 0
// Checksum 0xf89a7245, Offset: 0x8a8
// Size: 0x1ec
function init()
{
    level._effect[ "rcbombexplosion" ] = "killstreaks/fx_rcxd_exp";
    killstreaks::register( "rcbomb", "rcbomb", "killstreak_rcbomb", "rcbomb_used", &activatercbomb );
    killstreaks::register_strings( "rcbomb", &"KILLSTREAK_EARNED_RCBOMB", &"KILLSTREAK_RCBOMB_NOT_AVAILABLE", &"KILLSTREAK_RCBOMB_INBOUND", undefined, &"KILLSTREAK_RCBOMB_HACKED", 0 );
    killstreaks::register_dialog( "rcbomb", "mpl_killstreak_rcbomb", "rcBombDialogBundle", undefined, "friendlyRcBomb", "enemyRcBomb", "enemyRcBombMultiple", "friendlyRcBombHacked", "enemyRcBombHacked", "requestRcBomb" );
    killstreaks::allow_assists( "rcbomb", 1 );
    killstreaks::register_alt_weapon( "rcbomb", "killstreak_remote" );
    killstreaks::register_alt_weapon( "rcbomb", "rcbomb_turret" );
    remote_weapons::registerremoteweapon( "rcbomb", &"", &startremotecontrol, &endremotecontrol, 0 );
    vehicle::add_main_callback( "rc_car_mp", &initrcbomb );
    clientfield::register( "vehicle", "rcbomb_stunned", 1, 1, "int" );
}

// Namespace rcbomb/rcbomb
// Params 0
// Checksum 0x7cc5b19, Offset: 0xaa0
// Size: 0x14c
function initrcbomb()
{
    rcbomb = self;
    rcbomb clientfield::set( "enemyvehicle", 1 );
    rcbomb.allowfriendlyfiredamageoverride = &rccarallowfriendlyfiredamage;
    rcbomb enableaimassist();
    rcbomb setdrawinfrared( 1 );
    rcbomb.delete_on_death = 1;
    rcbomb.death_enter_cb = &waitremotecontrol;
    rcbomb.disableremoteweaponswitch = 1;
    rcbomb.overridevehicledamage = &ondamage;
    rcbomb.overridevehiclekilled = &ondeath;
    rcbomb.watch_remote_weapon_death = 1;
    rcbomb.watch_remote_weapon_death_duration = 0.3;
    
    if ( issentient( rcbomb ) == 0 )
    {
        rcbomb makesentient();
    }
}

// Namespace rcbomb/rcbomb
// Params 0
// Checksum 0x23b01053, Offset: 0xbf8
// Size: 0xc2
function waitremotecontrol()
{
    remote_controlled = isdefined( self.controlled ) && ( isdefined( self.control_initiated ) && self.control_initiated || self.controlled );
    
    if ( remote_controlled )
    {
        notifystring = self waittill( "remote_weapon_end", "rcbomb_shutdown" );
        
        if ( notifystring._notify == "remote_weapon_end" )
        {
            self waittill( "rcbomb_shutdown" );
        }
        else
        {
            self waittill( "remote_weapon_end" );
        }
        
        return;
    }
    
    self waittill( "rcbomb_shutdown" );
}

// Namespace rcbomb/rcbomb
// Params 1
// Checksum 0x2432dee6, Offset: 0xcc8
// Size: 0x6c
function togglelightsonaftertime( time )
{
    self notify( #"togglelightsonaftertime_singleton" );
    self endon( #"togglelightsonaftertime_singleton" );
    rcbomb = self;
    rcbomb endon( #"death" );
    wait time;
    rcbomb clientfield::set( "toggle_lights", 0 );
}

// Namespace rcbomb/rcbomb
// Params 1
// Checksum 0x27482b69, Offset: 0xd40
// Size: 0xb4
function hackedprefunction( hacker )
{
    rcbomb = self;
    rcbomb clientfield::set( "toggle_lights", 1 );
    rcbomb.owner unlink();
    rcbomb clientfield::set( "vehicletransition", 0 );
    rcbomb.owner killstreaks::clear_using_remote();
    rcbomb makevehicleunusable();
}

// Namespace rcbomb/rcbomb
// Params 1
// Checksum 0xaab557a4, Offset: 0xe00
// Size: 0x94
function hackedpostfunction( hacker )
{
    rcbomb = self;
    hacker remote_weapons::useremoteweapon( rcbomb, "rcbomb", 1, 0 );
    rcbomb makevehicleunusable();
    hacker killstreaks::set_killstreak_delay_killcam( "rcbomb" );
    hacker killstreak_hacking::set_vehicle_drivable_time_starting_now( rcbomb );
}

// Namespace rcbomb/rcbomb
// Params 2
// Checksum 0x332d0546, Offset: 0xea0
// Size: 0x3c
function configureteampost( owner, ishacked )
{
    rcbomb = self;
    rcbomb thread watchownergameevents();
}

// Namespace rcbomb/rcbomb
// Params 1
// Checksum 0xdc3dfb6d, Offset: 0xee8
// Size: 0x4d0, Type: bool
function activatercbomb( hardpointtype )
{
    assert( isplayer( self ) );
    player = self;
    
    if ( !player killstreakrules::iskillstreakallowed( hardpointtype, player.team ) )
    {
        return false;
    }
    
    if ( player usebuttonpressed() )
    {
        return false;
    }
    
    placement = calculatespawnorigin( self.origin, self.angles );
    
    if ( !isdefined( placement ) || !self isonground() || self util::isusingremote() || killstreaks::is_interacting_with_object() || self oob::istouchinganyoobtrigger() )
    {
        self iprintlnbold( &"KILLSTREAK_RCBOMB_NOT_PLACEABLE" );
        return false;
    }
    
    killstreak_id = player killstreakrules::killstreakstart( "rcbomb", player.team, 0, 1 );
    
    if ( killstreak_id == -1 )
    {
        return false;
    }
    
    rcbomb = spawnvehicle( "rc_car_mp", placement.origin, placement.angles, "rcbomb" );
    rcbomb killstreaks::configure_team( "rcbomb", killstreak_id, player, "small_vehicle", undefined, &configureteampost );
    rcbomb killstreak_hacking::enable_hacking( "rcbomb", &hackedprefunction, &hackedpostfunction );
    rcbomb.damagetaken = 0;
    rcbomb.abandoned = 0;
    rcbomb.killstreak_id = killstreak_id;
    rcbomb.activatingkillstreak = 1;
    rcbomb setinvisibletoall();
    rcbomb thread watchshutdown();
    rcbomb.health = killstreak_bundles::get_max_health( hardpointtype );
    rcbomb.maxhealth = killstreak_bundles::get_max_health( hardpointtype );
    rcbomb.hackedhealth = killstreak_bundles::get_hacked_health( hardpointtype );
    rcbomb.hackedhealthupdatecallback = &rcbomb_hacked_health_update;
    rcbomb.ignore_vehicle_underneath_splash_scalar = 1;
    self thread killstreaks::play_killstreak_start_dialog( "rcbomb", self.team, killstreak_id );
    self addweaponstat( getweapon( "rcbomb" ), "used", 1 );
    remote_weapons::useremoteweapon( rcbomb, "rcbomb", 1, 0 );
    
    if ( isdefined( player.laststand ) && ( !isdefined( player ) || !isalive( player ) || player.laststand ) || player isempjammed() )
    {
        if ( isdefined( rcbomb ) )
        {
            rcbomb notify( #"remote_weapon_shutdown" );
            rcbomb notify( #"rcbomb_shutdown" );
        }
        
        return false;
    }
    
    rcbomb setvisibletoall();
    rcbomb.activatingkillstreak = 0;
    target_set( rcbomb );
    rcbomb thread watchgameended();
    return true;
}

// Namespace rcbomb/rcbomb
// Params 1
// Checksum 0x8fab13ad, Offset: 0x13c0
// Size: 0x58
function rcbomb_hacked_health_update( hacker )
{
    rcbomb = self;
    
    if ( rcbomb.health > rcbomb.hackedhealth )
    {
        rcbomb.health = rcbomb.hackedhealth;
    }
}

// Namespace rcbomb/rcbomb
// Params 1
// Checksum 0xccd3c42a, Offset: 0x1420
// Size: 0xf4
function startremotecontrol( rcbomb )
{
    player = self;
    rcbomb usevehicle( player, 0 );
    rcbomb clientfield::set( "vehicletransition", 1 );
    rcbomb thread audio::sndupdatevehiclecontext( 1 );
    rcbomb thread watchtimeout();
    rcbomb thread watchdetonation();
    rcbomb thread watchhurttriggers();
    rcbomb thread watchwater();
    player vehicle::set_vehicle_drivable_time_starting_now( 40000 );
}

// Namespace rcbomb/rcbomb
// Params 2
// Checksum 0x861a525b, Offset: 0x1520
// Size: 0x6c
function endremotecontrol( rcbomb, exitrequestedbyowner )
{
    if ( exitrequestedbyowner == 0 )
    {
        rcbomb notify( #"rcbomb_shutdown" );
        rcbomb thread audio::sndupdatevehiclecontext( 0 );
    }
    
    rcbomb clientfield::set( "vehicletransition", 0 );
}

// Namespace rcbomb/rcbomb
// Params 0
// Checksum 0x85fd5e3a, Offset: 0x1598
// Size: 0x70
function watchdetonation()
{
    rcbomb = self;
    rcbomb endon( #"rcbomb_shutdown" );
    rcbomb endon( #"death" );
    
    while ( !rcbomb.owner attackbuttonpressed() )
    {
        waitframe( 1 );
    }
    
    rcbomb notify( #"rcbomb_shutdown" );
}

// Namespace rcbomb/rcbomb
// Params 0
// Checksum 0xeffd2a02, Offset: 0x1610
// Size: 0xda
function watchwater()
{
    self endon( #"rcbomb_shutdown" );
    
    for ( inwater = 0; !inwater ; inwater = trace[ "fraction" ] < 1 )
    {
        wait 0.5;
        trace = physicstrace( self.origin + ( 0, 0, 10 ), self.origin + ( 0, 0, 6 ), ( -2, -2, -2 ), ( 2, 2, 2 ), self, 4 );
    }
    
    self.abandoned = 1;
    self notify( #"rcbomb_shutdown" );
}

// Namespace rcbomb/rcbomb
// Params 0
// Checksum 0x8481dfec, Offset: 0x16f8
// Size: 0x8c
function watchownergameevents()
{
    self notify( #"watchownergameevents_singleton" );
    self endon( #"watchownergameevents_singleton" );
    rcbomb = self;
    rcbomb endon( #"rcbomb_shutdown" );
    rcbomb.owner waittill( "joined_team", "disconnect", "joined_spectators" );
    rcbomb.abandoned = 1;
    rcbomb notify( #"rcbomb_shutdown" );
}

// Namespace rcbomb/rcbomb
// Params 0
// Checksum 0xbde96749, Offset: 0x1790
// Size: 0x4c
function watchtimeout()
{
    rcbomb = self;
    rcbomb thread killstreaks::waitfortimeout( "rcbomb", 40000, &rc_shutdown, "rcbomb_shutdown" );
}

// Namespace rcbomb/rcbomb
// Params 0
// Checksum 0x3f4ec77b, Offset: 0x17e8
// Size: 0x24
function rc_shutdown()
{
    rcbomb = self;
    rcbomb notify( #"rcbomb_shutdown" );
}

// Namespace rcbomb/rcbomb
// Params 0
// Checksum 0x2a0ce666, Offset: 0x1818
// Size: 0x14c
function watchshutdown()
{
    rcbomb = self;
    rcbomb endon( #"death" );
    rcbomb waittill( "rcbomb_shutdown" );
    
    if ( isdefined( rcbomb.activatingkillstreak ) && rcbomb.activatingkillstreak )
    {
        killstreakrules::killstreakstop( "rcbomb", rcbomb.originalteam, rcbomb.killstreak_id );
        rcbomb notify( #"rcbomb_shutdown" );
        rcbomb delete();
        return;
    }
    
    attacker = isdefined( rcbomb.owner ) ? rcbomb.owner : undefined;
    rcbomb dodamage( rcbomb.health + 1, rcbomb.origin + ( 0, 0, 10 ), attacker, attacker, "none", "MOD_EXPLOSIVE", 0 );
}

// Namespace rcbomb/rcbomb
// Params 0
// Checksum 0x7101eec8, Offset: 0x1970
// Size: 0xc4
function watchhurttriggers()
{
    rcbomb = self;
    rcbomb endon( #"rcbomb_shutdown" );
    
    while ( true )
    {
        waitresult = rcbomb waittill( "touch" );
        ent = waitresult.entity;
        
        if ( ent.classname == "trigger_hurt" || isdefined( ent.classname ) && ent.classname == "trigger_out_of_bounds" )
        {
            rcbomb notify( #"rcbomb_shutdown" );
        }
    }
}

// Namespace rcbomb/rcbomb
// Params 15
// Checksum 0x50ad9cf9, Offset: 0x1a40
// Size: 0x1da
function ondamage( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal )
{
    if ( self.activatingkillstreak )
    {
        return 0;
    }
    
    if ( !isdefined( eattacker ) || eattacker != self.owner )
    {
        idamage = killstreaks::ondamageperweapon( "rcbomb", eattacker, idamage, idflags, smeansofdeath, weapon, self.maxhealth, undefined, self.maxhealth * 0.4, undefined, 0, undefined, 1, 1 );
    }
    
    if ( isdefined( eattacker ) && isdefined( eattacker.team ) && eattacker.team != self.team )
    {
        if ( weapon.isemp )
        {
            self.damage_on_death = 0;
            self.died_by_emp = 1;
            idamage = self.health + 1;
        }
    }
    
    if ( weapon.name == "satchel_charge" && smeansofdeath == "MOD_EXPLOSIVE" )
    {
        idamage = self.health + 1;
    }
    
    return idamage;
}

// Namespace rcbomb/rcbomb
// Params 8
// Checksum 0xfa849017, Offset: 0x1c28
// Size: 0x1e4
function ondeath( einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime )
{
    rcbomb = self;
    player = rcbomb.owner;
    player endon( #"disconnect" );
    player endon( #"joined_team" );
    player endon( #"joined_spectators" );
    killstreakrules::killstreakstop( "rcbomb", rcbomb.originalteam, rcbomb.killstreak_id );
    rcbomb clientfield::set( "enemyvehicle", 0 );
    rcbomb explode( eattacker, weapon );
    hide_after_wait_time = rcbomb.died_by_emp === 1 ? 0.2 : 0.1;
    
    if ( isdefined( player ) )
    {
        player util::freeze_player_controls( 1 );
        rcbomb thread hideafterwait( hide_after_wait_time );
        wait 0.2;
        player util::freeze_player_controls( 0 );
    }
    else
    {
        rcbomb thread hideafterwait( hide_after_wait_time );
    }
    
    if ( isdefined( rcbomb ) )
    {
        rcbomb notify( #"rcbomb_shutdown" );
    }
}

// Namespace rcbomb/rcbomb
// Params 0
// Checksum 0x98802ab9, Offset: 0x1e18
// Size: 0x6c
function watchgameended()
{
    rcbomb = self;
    rcbomb endon( #"death" );
    level waittill( "game_ended" );
    rcbomb.abandoned = 1;
    rcbomb.selfdestruct = 1;
    rcbomb notify( #"rcbomb_shutdown" );
}

// Namespace rcbomb/rcbomb
// Params 1
// Checksum 0x45e081c, Offset: 0x1e90
// Size: 0x34
function hideafterwait( waittime )
{
    self endon( #"death" );
    wait waittime;
    self setinvisibletoall();
}

// Namespace rcbomb/rcbomb
// Params 2
// Checksum 0x97af6baf, Offset: 0x1ed0
// Size: 0x2ec
function explode( attacker, weapon )
{
    self endon( #"death" );
    owner = self.owner;
    
    if ( !isdefined( attacker ) && isdefined( self.owner ) )
    {
        attacker = self.owner;
    }
    
    self vehicle_death::death_fx();
    self thread vehicle_death::death_radius_damage();
    self thread vehicle_death::set_death_model( self.deathmodel, self.modelswapdelay );
    self vehicle::toggle_tread_fx( 0 );
    self vehicle::toggle_exhaust_fx( 0 );
    self vehicle::toggle_sounds( 0 );
    self vehicle::lights_off();
    self playrumbleonentity( "rcbomb_explosion" );
    
    if ( !self.abandoned && attacker != self.owner && isplayer( attacker ) )
    {
        attacker challenges::destroyrcbomb( weapon );
        
        if ( self.owner util::isenemyplayer( attacker ) )
        {
            scoreevents::processscoreevent( "destroyed_hover_rcxd", attacker, self.owner, weapon );
            luinotifyevent( &"player_callout", 2, &"KILLSTREAK_DESTROYED_RCBOMB", attacker.entnum );
            
            if ( isdefined( weapon ) && weapon.isvalid )
            {
                weaponstatname = "destroyed";
                level.globalkillstreaksdestroyed++;
                weapon_rcbomb = getweapon( "rcbomb" );
                attacker addweaponstat( weapon_rcbomb, "destroyed", 1 );
                attacker addweaponstat( weapon, "destroyed_controlled_killstreak", 1 );
            }
            
            self killstreaks::play_destroyed_dialog_on_owner( "rcbomb", self.killstreak_id );
        }
    }
}

// Namespace rcbomb/rcbomb
// Params 4
// Checksum 0xeec6d14d, Offset: 0x21c8
// Size: 0x76, Type: bool
function rccarallowfriendlyfiredamage( einflictor, eattacker, smeansofdeath, weapon )
{
    if ( isdefined( eattacker ) && eattacker == self.owner )
    {
        return true;
    }
    
    if ( isdefined( einflictor ) && einflictor islinkedto( self ) )
    {
        return true;
    }
    
    return false;
}

// Namespace rcbomb/rcbomb
// Params 0
// Checksum 0x38b3a746, Offset: 0x2248
// Size: 0x6a
function getplacementstartheight()
{
    startheight = 50;
    
    switch ( self getstance() )
    {
        case #"crouch":
            startheight = 30;
            break;
        case #"prone":
            startheight = 15;
            break;
    }
    
    return startheight;
}

// Namespace rcbomb/rcbomb
// Params 2
// Checksum 0xafdd0967, Offset: 0x22c0
// Size: 0x4ca
function calculatespawnorigin( origin, angles )
{
    startheight = getplacementstartheight();
    mins = ( -5, -5, 0 );
    maxs = ( 5, 5, 10 );
    startpoints = [];
    startangles = [];
    wheelcounts = [];
    testcheck = [];
    largestcount = 0;
    largestcountindex = 0;
    testangles = [];
    testangles[ 0 ] = ( 0, 0, 0 );
    testangles[ 1 ] = ( 0, 20, 0 );
    testangles[ 2 ] = ( 0, -20, 0 );
    testangles[ 3 ] = ( 0, 45, 0 );
    testangles[ 4 ] = ( 0, -45, 0 );
    heightoffset = 5;
    
    for ( i = 0; i < testangles.size ; i++ )
    {
        testcheck[ i ] = 0;
        startangles[ i ] = ( 0, angles[ 1 ], 0 );
        startpoint = origin + vectorscale( anglestoforward( startangles[ i ] + testangles[ i ] ), 70 );
        endpoint = startpoint - ( 0, 0, 100 );
        startpoint += ( 0, 0, startheight );
        mask = 1 | 2;
        trace = physicstrace( startpoint, endpoint, mins, maxs, self, mask );
        
        if ( isdefined( trace[ "entity" ] ) && isplayer( trace[ "entity" ] ) )
        {
            wheelcounts[ i ] = 0;
            continue;
        }
        
        startpoints[ i ] = trace[ "position" ] + ( 0, 0, heightoffset );
        wheelcounts[ i ] = testwheellocations( startpoints[ i ], startangles[ i ], heightoffset );
        
        if ( positionwouldtelefrag( startpoints[ i ] ) )
        {
            continue;
        }
        
        if ( largestcount < wheelcounts[ i ] )
        {
            largestcount = wheelcounts[ i ];
            largestcountindex = i;
        }
        
        if ( wheelcounts[ i ] >= 3 )
        {
            testcheck[ i ] = 1;
            
            if ( testspawnorigin( startpoints[ i ], startangles[ i ] ) )
            {
                placement = spawnstruct();
                placement.origin = startpoints[ i ];
                placement.angles = startangles[ i ];
                return placement;
            }
        }
    }
    
    for ( i = 0; i < testangles.size ; i++ )
    {
        if ( !testcheck[ i ] )
        {
            if ( wheelcounts[ i ] >= 2 )
            {
                if ( testspawnorigin( startpoints[ i ], startangles[ i ] ) )
                {
                    placement = spawnstruct();
                    placement.origin = startpoints[ i ];
                    placement.angles = startangles[ i ];
                    return placement;
                }
            }
        }
    }
    
    return undefined;
}

// Namespace rcbomb/rcbomb
// Params 3
// Checksum 0x9b03edbf, Offset: 0x2798
// Size: 0x202
function testwheellocations( origin, angles, heightoffset )
{
    forward = 13;
    side = 10;
    wheels = [];
    wheels[ 0 ] = ( forward, side, 0 );
    wheels[ 1 ] = ( forward, -1 * side, 0 );
    wheels[ 2 ] = ( -1 * forward, -1 * side, 0 );
    wheels[ 3 ] = ( -1 * forward, side, 0 );
    height = 5;
    touchcount = 0;
    yawangles = ( 0, angles[ 1 ], 0 );
    
    for ( i = 0; i < 4 ; i++ )
    {
        wheel = rotatepoint( wheels[ i ], yawangles );
        startpoint = origin + wheel;
        endpoint = startpoint + ( 0, 0, -1 * height - heightoffset );
        startpoint += ( 0, 0, height - heightoffset );
        trace = bullettrace( startpoint, endpoint, 0, self );
        
        if ( trace[ "fraction" ] < 1 )
        {
            touchcount++;
        }
    }
    
    return touchcount;
}

// Namespace rcbomb/rcbomb
// Params 2
// Checksum 0x7bcc542f, Offset: 0x29a8
// Size: 0x22e, Type: bool
function testspawnorigin( origin, angles )
{
    liftedorigin = origin + ( 0, 0, 5 );
    size = 12;
    height = 15;
    mins = ( -1 * size, -1 * size, 0 );
    maxs = ( size, size, height );
    absmins = liftedorigin + mins;
    absmaxs = liftedorigin + maxs;
    
    if ( boundswouldtelefrag( absmins, absmaxs ) )
    {
        return false;
    }
    
    startheight = getplacementstartheight();
    mask = 1 | 2 | 4;
    trace = physicstrace( liftedorigin, origin + ( 0, 0, 1 ), mins, maxs, self, mask );
    
    if ( trace[ "fraction" ] < 1 )
    {
        return false;
    }
    
    size = 2.5;
    height = size * 2;
    mins = ( -1 * size, -1 * size, 0 );
    maxs = ( size, size, height );
    sweeptrace = physicstrace( self.origin + ( 0, 0, startheight ), liftedorigin, mins, maxs, self, mask );
    
    if ( sweeptrace[ "fraction" ] < 1 )
    {
        return false;
    }
    
    return true;
}

