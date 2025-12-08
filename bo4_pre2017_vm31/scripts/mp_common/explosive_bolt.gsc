#using scripts/core_common/callbacks_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/weapons;
#using scripts/mp_common/util;

#namespace explosive_bolt;

// Namespace explosive_bolt/explosive_bolt
// Params 0, eflags: 0x2
// Checksum 0xcbbe7963, Offset: 0x170
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "explosive_bolt", &__init__, undefined, undefined );
}

// Namespace explosive_bolt/explosive_bolt
// Params 0
// Checksum 0x6346a32e, Offset: 0x1b0
// Size: 0x24
function __init__()
{
    callback::on_spawned( &on_player_spawned );
}

// Namespace explosive_bolt/explosive_bolt
// Params 0
// Checksum 0xd9f8a6fc, Offset: 0x1e0
// Size: 0x1c
function on_player_spawned()
{
    self thread begin_other_grenade_tracking();
}

// Namespace explosive_bolt/explosive_bolt
// Params 0
// Checksum 0x824c5b1e, Offset: 0x208
// Size: 0x160
function begin_other_grenade_tracking()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self notify( #"bolttrackingstart" );
    self endon( #"bolttrackingstart" );
    weapon_bolt = getweapon( "explosive_bolt" );
    
    for ( ;; )
    {
        waitresult = self waittill( "grenade_fire" );
        grenade = waitresult.projectile;
        weapon = waitresult.weapon;
        
        if ( grenade util::ishacked() )
        {
            continue;
        }
        
        if ( weapon == weapon_bolt )
        {
            grenade.ownerweaponatlaunch = self.currentweapon;
            grenade.owneradsatlaunch = self playerads() == 1 ? 1 : 0;
            grenade thread function_c0dabb0c( self );
            grenade thread weapons::check_stuck_to_player( 1, 0, weapon );
        }
    }
}

// Namespace explosive_bolt/explosive_bolt
// Params 1
// Checksum 0x2abe99d7, Offset: 0x370
// Size: 0xc
function function_c0dabb0c( owner )
{
    
}

