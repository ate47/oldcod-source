#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\zm_common\zm_perks;

#namespace zm_perk_quick_revive;

// Namespace zm_perk_quick_revive/zm_perk_quick_revive
// Params 0, eflags: 0x6
// Checksum 0x49e24c2b, Offset: 0xc8
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"zm_perk_quick_revive", &preinit, undefined, undefined, undefined );
}

// Namespace zm_perk_quick_revive/zm_perk_quick_revive
// Params 0, eflags: 0x4
// Checksum 0x6dcff14a, Offset: 0x110
// Size: 0x14
function private preinit()
{
    enable_quick_revive_perk_for_level();
}

// Namespace zm_perk_quick_revive/zm_perk_quick_revive
// Params 0
// Checksum 0x24ed3897, Offset: 0x130
// Size: 0x9c
function enable_quick_revive_perk_for_level()
{
    zm_perks::register_perk_clientfields( #"talent_quickrevive", &quick_revive_client_field_func, &quick_revive_callback_func );
    zm_perks::register_perk_effects( #"talent_quickrevive", "revive_light" );
    zm_perks::register_perk_init_thread( #"talent_quickrevive", &init_quick_revive );
}

// Namespace zm_perk_quick_revive/zm_perk_quick_revive
// Params 0
// Checksum 0x62c684be, Offset: 0x1d8
// Size: 0x3c
function init_quick_revive()
{
    if ( is_true( level.enable_magic ) )
    {
        level._effect[ #"revive_light" ] = "zombie/fx_perk_quick_revive_factory_zmb";
    }
}

// Namespace zm_perk_quick_revive/zm_perk_quick_revive
// Params 0
// Checksum 0x80f724d1, Offset: 0x220
// Size: 0x4
function quick_revive_client_field_func()
{
    
}

// Namespace zm_perk_quick_revive/zm_perk_quick_revive
// Params 0
// Checksum 0x80f724d1, Offset: 0x230
// Size: 0x4
function quick_revive_callback_func()
{
    
}

