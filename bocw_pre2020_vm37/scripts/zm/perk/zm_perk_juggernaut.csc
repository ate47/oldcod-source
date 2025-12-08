#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\zm_common\zm_perks;

#namespace zm_perk_juggernaut;

// Namespace zm_perk_juggernaut/zm_perk_juggernaut
// Params 0, eflags: 0x6
// Checksum 0x692aeb4e, Offset: 0xc8
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"zm_perk_juggernaut", &preinit, undefined, undefined, undefined );
}

// Namespace zm_perk_juggernaut/zm_perk_juggernaut
// Params 0, eflags: 0x4
// Checksum 0x538fe009, Offset: 0x110
// Size: 0x9c
function private preinit()
{
    zm_perks::register_perk_clientfields( #"hash_47d7a8105237c88", &function_2d2b95b0, &function_6c832af6 );
    zm_perks::register_perk_effects( #"hash_47d7a8105237c88", "jugger_light" );
    zm_perks::register_perk_init_thread( #"hash_47d7a8105237c88", &init_juggernaut );
}

// Namespace zm_perk_juggernaut/zm_perk_juggernaut
// Params 0
// Checksum 0xa578f3, Offset: 0x1b8
// Size: 0x3c
function init_juggernaut()
{
    if ( is_true( level.enable_magic ) )
    {
        level._effect[ #"jugger_light" ] = "zombie/fx_perk_juggernaut_factory_zmb";
    }
}

// Namespace zm_perk_juggernaut/zm_perk_juggernaut
// Params 0
// Checksum 0x80f724d1, Offset: 0x200
// Size: 0x4
function function_2d2b95b0()
{
    
}

// Namespace zm_perk_juggernaut/zm_perk_juggernaut
// Params 0
// Checksum 0x80f724d1, Offset: 0x210
// Size: 0x4
function function_6c832af6()
{
    
}

