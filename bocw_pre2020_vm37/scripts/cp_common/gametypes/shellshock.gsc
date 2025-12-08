#using scripts\core_common\callbacks_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\util;

#namespace shellshock;

// Namespace shellshock/shellshock
// Params 0, eflags: 0x6
// Checksum 0x2342191b, Offset: 0x100
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"shellshock", &preinit, undefined, undefined, undefined );
}

// Namespace shellshock/shellshock
// Params 0, eflags: 0x4
// Checksum 0xf069faed, Offset: 0x148
// Size: 0x3c
function private preinit()
{
    callback::on_start_gametype( &init );
    level.shellshockonplayerdamage = &on_damage;
}

// Namespace shellshock/shellshock
// Params 0
// Checksum 0x80f724d1, Offset: 0x190
// Size: 0x4
function init()
{
    
}

// Namespace shellshock/shellshock
// Params 5
// Checksum 0xcaf3f723, Offset: 0x1a0
// Size: 0xec
function on_damage( *eattacker, *einflictor, *weapon, smeansofdeath, idamage )
{
    if ( self util::isflashbanged() )
    {
        return;
    }
    
    if ( smeansofdeath == "MOD_EXPLOSIVE" || smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_PROJECTILE_SPLASH" )
    {
        if ( idamage > 10 )
        {
            if ( self util::mayapplyscreeneffect() )
            {
                self shellshock( #"frag_grenade_mp", 0.5 );
            }
        }
    }
}

// Namespace shellshock/shellshock
// Params 0
// Checksum 0xea34f889, Offset: 0x298
// Size: 0x2e
function end_on_death()
{
    self waittill( #"death" );
    waittillframeend();
    self notify( #"end_explode" );
}

// Namespace shellshock/shellshock
// Params 1
// Checksum 0x609aa716, Offset: 0x2d0
// Size: 0x36
function end_on_timer( timer )
{
    self endon( #"disconnect" );
    wait timer;
    self notify( #"end_on_timer" );
}

// Namespace shellshock/shellshock
// Params 1
// Checksum 0x85a3b7e9, Offset: 0x310
// Size: 0x54
function rcbomb_earthquake( position )
{
    playrumbleonposition( "grenade_rumble", position );
    earthquake( 0.5, 0.5, self.origin, 512 );
}

