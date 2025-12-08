#using script_2d443451ce681a;
#using script_31e9b35aaacbbd93;
#using script_3dc93ca9902a9cda;
#using script_61cfc2ab8e60625;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp\cp_takedown;
#using scripts\cp\cp_takedown_raid_bar;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\ui\prompts;
#using scripts\cp_common\util;

#namespace namespace_c9f7b6af;

// Namespace namespace_c9f7b6af/namespace_414c4954
// Params 1
// Checksum 0xc85b0c9d, Offset: 0x390
// Size: 0x334
function starting( *var_d3440450 )
{
    player = getplayers()[ 0 ];
    player thread fx::function_82104e32( 3, 3 );
    player setmovespeedscale( 0.3 );
    var_8a3bb97c = getspawnerarray( "raid_adler", "targetname" );
    var_8a3bb97c[ 0 ] spawner::add_spawn_function( &namespace_b100dd86::function_9109a1fe );
    woods_spawner = getspawnerarray( "raid_woods", "targetname" );
    woods_spawner[ 0 ] spawner::add_spawn_function( &namespace_b100dd86::function_87d56d50 );
    level.var_efac709f = getent( "player_breach_clip", "targetname" );
    level.var_efac709f disconnectpaths();
    level.adler = var_8a3bb97c[ 0 ] spawner::spawn( 1 );
    level.woods = woods_spawner[ 0 ] spawner::spawn( 1 );
    var_fcbd93e0 = struct::get( "raid_approach_adler", "targetname" );
    var_1100faeb = struct::get( "raid_approach_woods", "targetname" );
    level.adler forceteleport( var_fcbd93e0.origin, var_fcbd93e0.angles );
    level.woods forceteleport( var_1100faeb.origin, var_1100faeb.angles );
    level thread tkdn_raid_bar::function_68461db2();
    level notify( #"hash_4aade1e09ed49814" );
    level notify( #"hash_41a9df66948f9e8a" );
    player clientfield::set_to_player( "lerp_fov", 2 );
    var_b7ec8c4b = getent( "bar_door_clip", "targetname" );
    var_b7ec8c4b delete();
    level thread tkdn_raid_bar::function_d8e3ce93();
    
    if ( isdefined( level.var_d7d201ba ) )
    {
        player flag::set( level.var_d7d201ba );
    }
}

// Namespace namespace_c9f7b6af/namespace_414c4954
// Params 2
// Checksum 0x4699635d, Offset: 0x6d0
// Size: 0x4ac
function main( var_d3440450, *var_50cc0d4f )
{
    thread namespace_a052577e::function_2032c91c();
    player = getplayers()[ 0 ];
    var_4f2ba130 = player getweaponslistprimaries();
    
    foreach ( e_w in var_4f2ba130 )
    {
        player takeweapon( e_w );
    }
    
    player util::blend_movespeedscale( 0.3, 0.5 );
    level thread globallogic_ui::function_7bc0e4b9( 0, 0 );
    level.raid_car = getent( "raid_car", "targetname" );
    level scene::init( "scene_tkd_hit2_alley_civilians" );
    level thread scene::play( "scene_tkd_hit2_intro_bar_v2", "Adler_part_3", [ level.raid_car ] );
    thread namespace_a052577e::function_6591463();
    level waittill( #"hash_466d92987a2101aa" );
    level thread function_4bc3dba();
    level util::waittill_multiple( "woods_gearup_done", "adler_gearup_done" );
    level flag::wait_till( "flag_move_on_to_alley" );
    level thread savegame::function_7790f03( 1 );
    level notify( #"hash_5c41a54cd623966e" );
    alley_clip = getent( "alley_clip", "targetname" );
    alley_clip delete();
    player val::reset( #"bar", "allow_sprint" );
    level thread function_b7d7ba47();
    level thread function_709cb1b3();
    level thread tkdn::function_7ea0ce5f();
    player util::blend_movespeedscale( 0.45, 2 );
    namespace_a052577e::function_b26ed576();
    level thread scene::init_streamer( #"scene_tkd_hit2_bar_alley", getplayers() );
    level thread scene::init( "scene_tkd_hit2_bar_alley" );
    level thread scene::init( "scene_tkd_hit2_adler_alley" );
    level thread scene::play( "scene_tkd_hit2_bar_alley", "Alley" );
    level thread scene::play( "scene_tkd_hit2_adler_alley", "Alley" );
    level waittill( #"hash_4dcb7132963ee03d" );
    thread namespace_a052577e::function_11062617();
    level flag::wait_till( "flag_setup_apartment_combat" );
    level thread savegame::function_7790f03( 1 );
    level thread scene::play( "scene_tkd_hit2_adler_alley", "Yard" );
    
    if ( isdefined( var_50cc0d4f ) )
    {
        skipto::function_4e3ab877( var_50cc0d4f );
    }
}

// Namespace namespace_c9f7b6af/namespace_414c4954
// Params 1
// Checksum 0x5213c84d, Offset: 0xb88
// Size: 0xb4
function function_37ddf68b( a_ents )
{
    door = a_ents[ #"yard_gate" ];
    var_b7ec8c4b = getent( "yard_gate_clip", "targetname" );
    org = getent( "yard_gate_org", "targetname" );
    var_b7ec8c4b linkto( org );
    org linkto( door, "tag_origin" );
}

// Namespace namespace_c9f7b6af/namespace_414c4954
// Params 0
// Checksum 0xd64ddb89, Offset: 0xc48
// Size: 0x4c
function function_4bc3dba()
{
    level flag::wait_till( "flag_close_bar_door" );
    level thread scene::play( "scene_tkd_hit2_intro_bar_v2", "Bar_Door_Close" );
}

// Namespace namespace_c9f7b6af/namespace_414c4954
// Params 0
// Checksum 0xa0e28be5, Offset: 0xca0
// Size: 0x4c
function function_b7d7ba47()
{
    level flag::wait_till( "flag_window_guy" );
    level scene::play( "scene_tkd_hit2_alley_civilians", "window_civilian" );
}

// Namespace namespace_c9f7b6af/namespace_414c4954
// Params 0
// Checksum 0x50f5646e, Offset: 0xcf8
// Size: 0x9c
function function_709cb1b3()
{
    player = getplayers()[ 0 ];
    level flag::wait_till( "flag_window_guy" );
    level thread scene::play( "scene_tkd_hit2_alley_civilians", "drug_waiting" );
    wait 1.5;
    level thread scene::play( "scene_tkd_hit2_alley_civilians", "drug_deal" );
}

// Namespace namespace_c9f7b6af/namespace_414c4954
// Params 4
// Checksum 0x832a56e9, Offset: 0xda0
// Size: 0x24
function cleanup( *name, *starting, *direct, *player )
{
    
}

// Namespace namespace_c9f7b6af/namespace_414c4954
// Params 0
// Checksum 0x105dd052, Offset: 0xdd0
// Size: 0x24
function init_flags()
{
    level flag::init( "raid_approach_complete" );
}

// Namespace namespace_c9f7b6af/namespace_414c4954
// Params 0
// Checksum 0x80f724d1, Offset: 0xe00
// Size: 0x4
function init_clientfields()
{
    
}

// Namespace namespace_c9f7b6af/namespace_414c4954
// Params 0
// Checksum 0x80f724d1, Offset: 0xe10
// Size: 0x4
function function_22b7fffd()
{
    
}

