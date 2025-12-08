#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;

#namespace zm_perk_sleight_of_hand;

// Namespace zm_perk_sleight_of_hand/zm_perk_sleight_of_hand
// Params 0, eflags: 0x6
// Checksum 0x872811b7, Offset: 0x180
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"zm_perk_sleight_of_hand", &preinit, undefined, undefined, undefined );
}

// Namespace zm_perk_sleight_of_hand/zm_perk_sleight_of_hand
// Params 0, eflags: 0x4
// Checksum 0x7f190e8f, Offset: 0x1c8
// Size: 0x14
function private preinit()
{
    function_a8fdd433();
}

// Namespace zm_perk_sleight_of_hand/zm_perk_sleight_of_hand
// Params 0
// Checksum 0x31255152, Offset: 0x1e8
// Size: 0x13c
function function_a8fdd433()
{
    zm_perks::register_perk_basic_info( #"talent_speedcola", #"perk_sleight_of_hand", 3000, #"hash_1fe685096c4f7bd2", getweapon( "zombie_perk_bottle_sleight" ), undefined, #"zmperksspeed" );
    zm_perks::register_perk_precache_func( #"talent_speedcola", &function_2ae165ac );
    zm_perks::register_perk_clientfields( #"talent_speedcola", &function_dbaed146, &function_c6ce3670 );
    zm_perks::register_perk_machine( #"talent_speedcola", &function_e5c86da9 );
    zm_perks::register_perk_host_migration_params( #"talent_speedcola", "vending_sleight", "sleight_light" );
}

// Namespace zm_perk_sleight_of_hand/zm_perk_sleight_of_hand
// Params 0
// Checksum 0x19e19d3d, Offset: 0x330
// Size: 0xf6
function function_2ae165ac()
{
    if ( isdefined( level.var_f3775b53 ) )
    {
        [[ level.var_f3775b53 ]]();
        return;
    }
    
    level._effect[ #"sleight_light" ] = "zombie/fx_perk_sleight_of_hand_factory_zmb";
    level.machine_assets[ #"talent_speedcola" ] = spawnstruct();
    level.machine_assets[ #"talent_speedcola" ].weapon = getweapon( "zombie_perk_bottle_sleight" );
    level.machine_assets[ #"talent_speedcola" ].off_model = "p7_zm_vending_sleight";
    level.machine_assets[ #"talent_speedcola" ].on_model = "p7_zm_vending_sleight";
}

// Namespace zm_perk_sleight_of_hand/zm_perk_sleight_of_hand
// Params 0
// Checksum 0x80f724d1, Offset: 0x430
// Size: 0x4
function function_dbaed146()
{
    
}

// Namespace zm_perk_sleight_of_hand/zm_perk_sleight_of_hand
// Params 1
// Checksum 0x906fcabf, Offset: 0x440
// Size: 0xc
function function_c6ce3670( *state )
{
    
}

// Namespace zm_perk_sleight_of_hand/zm_perk_sleight_of_hand
// Params 4
// Checksum 0xf7899071, Offset: 0x458
// Size: 0x9a
function function_e5c86da9( use_trigger, perk_machine, bump_trigger, *collision )
{
    perk_machine.script_sound = "mus_perks_speed_jingle";
    perk_machine.script_string = "speedcola_perk";
    perk_machine.script_label = "mus_perks_speed_sting";
    perk_machine.target = "vending_sleight";
    bump_trigger.script_string = "speedcola_perk";
    bump_trigger.targetname = "vending_sleight";
    
    if ( isdefined( collision ) )
    {
        collision.script_string = "speedcola_perk";
    }
}

