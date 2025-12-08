#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/mp_common/util;

#namespace shellshock;

// Namespace shellshock/shellshock
// Params 0, eflags: 0x2
// Checksum 0xc554074c, Offset: 0x200
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "shellshock", &__init__, undefined, undefined );
}

// Namespace shellshock/shellshock
// Params 0
// Checksum 0xbfd7eca0, Offset: 0x240
// Size: 0x40
function __init__()
{
    callback::on_start_gametype( &init );
    level.shellshockonplayerdamage = &on_damage;
}

// Namespace shellshock/shellshock
// Params 0
// Checksum 0x80f724d1, Offset: 0x288
// Size: 0x4
function init()
{
    
}

// Namespace shellshock/shellshock
// Params 3
// Checksum 0x855f0ce9, Offset: 0x298
// Size: 0x1b4
function on_damage( cause, damage, weapon )
{
    if ( self util::isflashbanged() )
    {
        return;
    }
    
    if ( self.health <= 0 )
    {
        self clientfield::set_to_player( "sndMelee", 0 );
    }
    
    if ( cause == "MOD_EXPLOSIVE" || cause == "MOD_GRENADE" || cause == "MOD_GRENADE_SPLASH" || cause == "MOD_PROJECTILE" || cause == "MOD_PROJECTILE_SPLASH" )
    {
        if ( weapon.explosionradius == 0 )
        {
            return;
        }
        
        time = 0;
        
        if ( damage >= 90 )
        {
            time = 4;
        }
        else if ( damage >= 50 )
        {
            time = 3;
        }
        else if ( damage >= 25 )
        {
            time = 2;
        }
        else if ( damage > 10 )
        {
            time = 2;
        }
        
        if ( time )
        {
            if ( self util::mayapplyscreeneffect() && self hasperk( "specialty_flakjacket" ) == 0 )
            {
                self shellshock( "frag_grenade_mp", 0.5 );
            }
        }
    }
}

// Namespace shellshock/shellshock
// Params 0
// Checksum 0x687729da, Offset: 0x458
// Size: 0x22
function end_on_death()
{
    self waittill( "death" );
    waittillframeend();
    self notify( #"end_explode" );
}

// Namespace shellshock/shellshock
// Params 1
// Checksum 0x21f7f40d, Offset: 0x488
// Size: 0x2a
function end_on_timer( timer )
{
    self endon( #"disconnect" );
    wait timer;
    self notify( #"end_on_timer" );
}

// Namespace shellshock/shellshock
// Params 1
// Checksum 0xfc84177, Offset: 0x4c0
// Size: 0x5c
function rcbomb_earthquake( position )
{
    playrumbleonposition( "grenade_rumble", position );
    earthquake( 0.5, 0.5, self.origin, 512 );
}

// Namespace shellshock/shellshock
// Params 0
// Checksum 0xc6b9a961, Offset: 0x528
// Size: 0x42
function reset_meleesnd()
{
    self endon( #"death" );
    wait 6;
    self clientfield::set_to_player( "sndMelee", 0 );
    self notify( #"snd_melee_end" );
}

