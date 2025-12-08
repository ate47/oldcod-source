#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\zm_common\zm_perks;

#namespace zm_perk_sleight_of_hand;

// Namespace zm_perk_sleight_of_hand/zm_perk_sleight_of_hand
// Params 0, eflags: 0x6
// Checksum 0x88b28b55, Offset: 0xc8
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"zm_perk_sleight_of_hand", &preinit, undefined, undefined, undefined );
}

// Namespace zm_perk_sleight_of_hand/zm_perk_sleight_of_hand
// Params 0, eflags: 0x4
// Checksum 0xcc20b81f, Offset: 0x110
// Size: 0x14
function private preinit()
{
    function_a8fdd433();
}

// Namespace zm_perk_sleight_of_hand/zm_perk_sleight_of_hand
// Params 0
// Checksum 0xc24b8730, Offset: 0x130
// Size: 0x9c
function function_a8fdd433()
{
    zm_perks::register_perk_clientfields( #"talent_speedcola", &function_38dda839, &function_3bdb96bc );
    zm_perks::register_perk_effects( #"talent_speedcola", "sleight_light" );
    zm_perks::register_perk_init_thread( #"talent_speedcola", &function_7d2154f5 );
}

// Namespace zm_perk_sleight_of_hand/zm_perk_sleight_of_hand
// Params 0
// Checksum 0xe342784c, Offset: 0x1d8
// Size: 0x3c
function function_7d2154f5()
{
    if ( is_true( level.enable_magic ) )
    {
        level._effect[ #"sleight_light" ] = "zombie/fx_perk_sleight_of_hand_factory_zmb";
    }
}

// Namespace zm_perk_sleight_of_hand/zm_perk_sleight_of_hand
// Params 0
// Checksum 0x80f724d1, Offset: 0x220
// Size: 0x4
function function_38dda839()
{
    
}

// Namespace zm_perk_sleight_of_hand/zm_perk_sleight_of_hand
// Params 0
// Checksum 0x80f724d1, Offset: 0x230
// Size: 0x4
function function_3bdb96bc()
{
    
}

