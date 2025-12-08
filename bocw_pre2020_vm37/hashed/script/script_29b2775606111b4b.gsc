#using script_1fd2c6e5fc8cb1c3;
#using script_2d443451ce681a;
#using script_4ec222619bffcfd1;
#using script_7901e9dc8618be8a;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;

#namespace kgb_aslt_vault_approach;

// Namespace kgb_aslt_vault_approach/namespace_7fbf03f6
// Params 1
// Checksum 0x1cc04221, Offset: 0x488
// Size: 0xc
function starting( *var_d3440450 )
{
    
}

// Namespace kgb_aslt_vault_approach/namespace_7fbf03f6
// Params 2
// Checksum 0x7d156c62, Offset: 0x4a0
// Size: 0x214
function main( var_d3440450, var_50cc0d4f )
{
    level flag::set( "aslt_vault_approach_begin" );
    
    if ( is_true( var_50cc0d4f ) )
    {
        level.adler = namespace_e77bf565::adler_spawn( var_d3440450 );
        level.adler namespace_e77bf565::function_5770c74( "assault" );
        level thread scene::skipto_end_noai( "scene_kgb_door_kick", "Last_Frame", undefined, 1 );
        level thread scene::init( "scene_kgb_utility_room_adler" );
        level thread scene::init( "scene_kgb_utility_room_player" );
        level thread namespace_bed29d94::function_a0d18564();
    }
    
    namespace_353d803e::music( "11.0_sabotage" );
    spawner::add_spawn_function_group( "vault_guards", "script_noteworthy", &function_e38e5c6e );
    level thread namespace_e77bf565::function_7feb07bb( var_d3440450, var_50cc0d4f );
    level thread function_b735db01();
    level thread scene::init( "scene_kgb_open_vault" );
    level thread scene::init( "scene_kgb_door_shoulder" );
    level flag::wait_till( "aslt_vault_approach_complete" );
    
    if ( isdefined( var_d3440450 ) )
    {
        skipto::function_4e3ab877( var_d3440450 );
    }
}

// Namespace kgb_aslt_vault_approach/namespace_7fbf03f6
// Params 4
// Checksum 0xc57885b4, Offset: 0x6c0
// Size: 0x24
function cleanup( *name, *starting, *direct, *player )
{
    
}

// Namespace kgb_aslt_vault_approach/namespace_7fbf03f6
// Params 0
// Checksum 0xa8565b55, Offset: 0x6f0
// Size: 0x84
function init_flags()
{
    level flag::init( "aslt_vault_approach_begin" );
    level flag::init( "aslt_vault_approach_complete" );
    level flag::init( "player_planted_gas" );
    level flag::init( "vault_approach_runners_dead" );
}

// Namespace kgb_aslt_vault_approach/namespace_7fbf03f6
// Params 0
// Checksum 0x80f724d1, Offset: 0x780
// Size: 0x4
function init_clientfields()
{
    
}

// Namespace kgb_aslt_vault_approach/namespace_7fbf03f6
// Params 0
// Checksum 0x93258b87, Offset: 0x790
// Size: 0x2c
function function_22b7fffd()
{
    animation::add_notetrack_func( "kgb_aslt_vault_approach::vault_approach_runners", &vault_approach_runners );
}

// Namespace kgb_aslt_vault_approach/namespace_7fbf03f6
// Params 0
// Checksum 0xccd82f80, Offset: 0x7c8
// Size: 0x1cc
function function_3dacefac()
{
    assault_plant_gas_org = struct::get( "assault_plant_gas_org", "targetname" );
    tag = spawn( "script_model", assault_plant_gas_org.origin );
    tag setmodel( "tag_origin" );
    tag util::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), #"hash_3047884ddd4a1374" );
    level thread function_a133f1c5();
    tag waittill( #"trigger" );
    level notify( #"hash_f7174846bbb8709" );
    tag util::remove_cursor_hint();
    player = getplayers()[ 0 ];
    player val::set( #"scene_kgb_utility_room_player", "disable_weapons", 1 );
    scene::play( "scene_kgb_utility_room_player" );
    player val::reset( #"scene_kgb_utility_room_player", "disable_weapons" );
    level thread savegame::checkpoint_save();
    level flag::set( "player_planted_gas" );
}

// Namespace kgb_aslt_vault_approach/namespace_7fbf03f6
// Params 0
// Checksum 0x7fa5e3, Offset: 0x9a0
// Size: 0x1f4
function function_b735db01()
{
    level.adler thread dialogue::queue( "vox_cp_rkgb_03500_adlr_ifourexfilgetsm_bf" );
    level thread function_3dacefac();
    level.adler colors::disable();
    level scene::play( "scene_kgb_utility_room_adler", "Intro" );
    level thread scene::play( "scene_kgb_utility_room_adler", "Loop" );
    level flag::set( "adler_at_vault_approach" );
    level flag::wait_till( "player_planted_gas" );
    level.adler dialogue::queue( "vox_cp_rkgb_03500_adlr_goodletsgettoth_a8" );
    namespace_353d803e::music( "11.3_combat2" );
    level flag::wait_till( "vault_approach_move_00" );
    level scene::play( "scene_kgb_utility_room_adler", "Outro" );
    level.adler colors::set_force_color( "g" );
    level.adler colors::enable();
    level flag::wait_till( "vault_approach_move_20" );
    level thread savegame::checkpoint_save();
    level.adler dialogue::queue( "vox_cp_rkgb_03600_adlr_werealmosttothe_1c" );
}

// Namespace kgb_aslt_vault_approach/namespace_7fbf03f6
// Params 0
// Checksum 0xb7c39bf0, Offset: 0xba0
// Size: 0x114
function function_a133f1c5()
{
    level endon( #"hash_f7174846bbb8709" );
    player = getplayers()[ 0 ];
    player endon( #"death" );
    var_a133f1c5 = [];
    var_a133f1c5[ var_a133f1c5.size ] = "vox_cp_rkgb_03500_adlr_hurryupandsetth_c8";
    var_a133f1c5[ var_a133f1c5.size ] = "vox_cp_rkgb_03500_adlr_clockstickingbe_65";
    var_a133f1c5[ var_a133f1c5.size ] = "vox_cp_rkgb_03500_adlr_getthegasreadyw_fe";
    wait 10;
    i = 0;
    
    while ( true )
    {
        player thread objectives_ui::show_objectives();
        level.adler dialogue::queue( "" + var_a133f1c5[ i ] );
        i++;
        
        if ( i + 1 > var_a133f1c5.size )
        {
            i = 0;
        }
        
        wait 10;
    }
}

// Namespace kgb_aslt_vault_approach/namespace_7fbf03f6
// Params 1
// Checksum 0x66a82f3e, Offset: 0xcc0
// Size: 0x64
function vault_approach_runners( *params )
{
    enemies = spawner::simple_spawn( "vault_approach_runners" );
    ai::waittill_dead_or_dying( enemies );
    level flag::set( "vault_approach_runners_dead" );
}

// Namespace kgb_aslt_vault_approach/namespace_7fbf03f6
// Params 0
// Checksum 0x344657b1, Offset: 0xd30
// Size: 0x12
function function_e38e5c6e()
{
    self.ignoresuppression = 1;
}

