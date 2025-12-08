#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_powerups;

#namespace zm_powerup_double_points;

// Namespace zm_powerup_double_points/zm_powerup_double_points
// Params 0, eflags: 0x6
// Checksum 0x99fcc3e9, Offset: 0xa8
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"zm_powerup_double_points", &preinit, undefined, undefined, undefined );
}

// Namespace zm_powerup_double_points/zm_powerup_double_points
// Params 0, eflags: 0x4
// Checksum 0x4c633854, Offset: 0xf0
// Size: 0x4c
function private preinit()
{
    zm_powerups::include_zombie_powerup( "double_points" );
    
    if ( zm_powerups::function_cc33adc8() )
    {
        zm_powerups::add_zombie_powerup( "double_points", "powerup_double_points" );
    }
}

