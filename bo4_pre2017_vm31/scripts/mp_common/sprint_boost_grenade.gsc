#using scripts/core_common/callbacks_shared;
#using scripts/core_common/challenges_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/weaponobjects;

#namespace sprint_boost_grenade;

// Namespace sprint_boost_grenade/sprint_boost_grenade
// Params 0, eflags: 0x2
// Checksum 0xa5af84f7, Offset: 0x248
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "sprint_boost_grenade", &__init__, undefined, undefined );
}

// Namespace sprint_boost_grenade/sprint_boost_grenade
// Params 0
// Checksum 0x3d941235, Offset: 0x288
// Size: 0x64
function __init__()
{
    level._effect[ "satchel_charge_enemy_light" ] = "weapon/fx_c4_light_orng";
    level._effect[ "satchel_charge_friendly_light" ] = "weapon/fx_c4_light_blue";
    callback::add_weapon_watcher( &create_grenade_watcher );
}

// Namespace sprint_boost_grenade/sprint_boost_grenade
// Params 0
// Checksum 0x8d569a53, Offset: 0x2f8
// Size: 0xb8
function create_grenade_watcher()
{
    watcher = self weaponobjects::createuseweaponobjectwatcher( "sprint_boost_grenade", self.team );
    watcher.watchforfire = 1;
    watcher.hackable = 1;
    watcher.hackertoolradius = level.equipmenthackertoolradius;
    watcher.hackertooltimems = level.equipmenthackertooltimems;
    watcher.headicon = 0;
    watcher.onspawn = &grenade_spawn;
}

// Namespace sprint_boost_grenade/sprint_boost_grenade
// Params 2
// Checksum 0x55c429ac, Offset: 0x3b8
// Size: 0x1a4
function grenade_spawn( watcher, owner )
{
    self endon( #"grenade_timeout" );
    self thread grenade_timeout( 10 );
    self thread weaponobjects::onspawnuseweaponobject( watcher, owner );
    radius = self.weapon.sprintboostradius;
    duration = self.weapon.sprintboostduration;
    
    if ( !( isdefined( self.previouslyhacked ) && self.previouslyhacked ) )
    {
        if ( isdefined( owner ) )
        {
            owner addweaponstat( self.weapon, "used", 1 );
            origin = owner.origin;
        }
        
        boost_on_throw = 1;
        detonated = 0;
        
        if ( !boost_on_throw )
        {
            waitresult = self waittill( "explode" );
            detonated = 1;
        }
        
        level thread apply_sprint_boost_to_players( owner, waitresult.position, radius, duration );
        
        if ( !detonated )
        {
            self detonate( owner );
        }
    }
}

// Namespace sprint_boost_grenade/sprint_boost_grenade
// Params 1
// Checksum 0x459fd79, Offset: 0x568
// Size: 0x5a
function grenade_timeout( timeout )
{
    self endon( #"death" );
    frames = int( timeout / 0.05 );
    waitframe( frames );
    self notify( #"grenade_timeout" );
}

// Namespace sprint_boost_grenade/sprint_boost_grenade
// Params 4
// Checksum 0x401fad62, Offset: 0x5d0
// Size: 0x192
function apply_sprint_boost_to_players( owner, origin, radius, duration )
{
    if ( !isdefined( owner ) )
    {
        return;
    }
    
    if ( !isdefined( owner.team ) )
    {
        return;
    }
    
    if ( !isdefined( origin ) )
    {
        return;
    }
    
    radiussq = ( isdefined( radius ) ? radius : 150 ) * ( isdefined( radius ) ? radius : 150 );
    
    foreach ( player in level.players )
    {
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        if ( player.team != owner.team )
        {
            continue;
        }
        
        if ( distancesquared( player.origin, origin ) > radiussq )
        {
            continue;
        }
        
        player thread apply_sprint_boost( duration );
    }
}

// Namespace sprint_boost_grenade/sprint_boost_grenade
// Params 1
// Checksum 0xbe431188, Offset: 0x770
// Size: 0xfc
function apply_sprint_boost( duration )
{
    player = self;
    player endon( #"death" );
    player endon( #"disconnect" );
    player notify( #"apply_sprint_boost_singleton" );
    player endon( #"apply_sprint_boost_singleton" );
    player setsprintboost( 1 );
    duration = math::clamp( isdefined( duration ) ? duration : 10, 1, 1200 );
    frames_to_wait = int( duration / 0.05 );
    waitframe( frames_to_wait );
    player setsprintboost( 0 );
}

