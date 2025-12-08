#using script_2d443451ce681a;
#using script_30cfffd6b7b2b212;
#using script_3890e6e179f6ed13;
#using script_3dc93ca9902a9cda;
#using script_67332a4d085a140a;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicleriders_shared;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;

#namespace namespace_9c42e5f3;

// Namespace namespace_9c42e5f3/namespace_c6b8d870
// Params 1
// Checksum 0xaf81606f, Offset: 0x330
// Size: 0xc4
function starting( *var_d3440450 )
{
    level thread scene::init_streamer( "scene_tkd_hit1_intro_fly_in", getplayers() );
    level thread scene::init_streamer( "scene_tkd_hit1_intro_fly_in_trucks", getplayers() );
    level.var_aece851d = [];
    flag::set( "heli_door_opening" );
    namespace_42da7c51::function_ed760ecb( "woods" );
    level thread namespace_61150688::function_bff4c800();
}

// Namespace namespace_9c42e5f3/namespace_c6b8d870
// Params 2
// Checksum 0x1cc4f67c, Offset: 0x400
// Size: 0xa4
function main( var_d3440450, *var_50cc0d4f )
{
    level flag::set( "flag_convoy_assault_started" );
    level.var_33621ea7 = 0;
    thread function_a7dc18f3();
    thread namespace_61150688::function_e04b45ab();
    level flag::wait_till( "heli_convoy_aslt_complete" );
    
    if ( isdefined( var_50cc0d4f ) )
    {
        skipto::function_4e3ab877( var_50cc0d4f );
    }
}

// Namespace namespace_9c42e5f3/namespace_c6b8d870
// Params 4
// Checksum 0xaea242c2, Offset: 0x4b0
// Size: 0x5c
function cleanup( *name, starting, *direct, *player )
{
    if ( player )
    {
        level flag::set( "heli_convoy_aslt_complete" );
        thread namespace_61150688::function_e04b45ab();
    }
}

// Namespace namespace_9c42e5f3/namespace_c6b8d870
// Params 0
// Checksum 0xbc3fa2a, Offset: 0x518
// Size: 0x310
function function_46693791()
{
    driver = getent( "driver_woods_kills", "script_parameters", 1 );
    level flag::wait_till( "heli_intro_path_ally" );
    level.woods thread spawner::go_to_node( getnode( "woods_landing_node", "targetname" ) );
    level.woods.ignoreall = 1;
    level.woods.ignoreme = 1;
    level.var_aece851d[ level.var_aece851d.size ] = level.woods;
    flag::set( "woods_gogo" );
    
    if ( isdefined( driver ) )
    {
        driver ai::bloody_death( 0.2 );
    }
    
    wait 1.2;
    level.woods.ignoreall = 0;
    wait 1;
    objectives::follow( "woods_hit1", level.woods );
    level.var_95a74232 = 1;
    aiarray = getaiarray( "intro_enemy_truck_guys", "script_noteworthy" );
    level thread namespace_42da7c51::function_d6fedf97( aiarray, int( ceil( aiarray.size * 0.75 ) ), "convoy_retreat" );
    level thread function_67924661( aiarray );
    level flag::wait_till( "convoy_retreat" );
    level thread savegame::checkpoint_save();
    
    foreach ( ai in aiarray )
    {
        if ( isdefined( ai ) && isalive( ai ) )
        {
            ai thread namespace_42da7c51::function_603d935( "vol_gas_station_all" );
            ai thread ai::bloody_death( randomintrange( 8, 12 ) );
        }
    }
}

// Namespace namespace_9c42e5f3/namespace_c6b8d870
// Params 1
// Checksum 0xae53af26, Offset: 0x830
// Size: 0x242
function function_67924661( aiarray )
{
    driver = getent( "driver_woods_kills", "script_parameters", 1 );
    
    foreach ( guy in aiarray )
    {
        guy.ignoreall = 1;
        guy.ignoreme = 1;
        
        if ( !isdefined( driver ) )
        {
            if ( isdefined( guy.script_parameters ) && guy.script_parameters == "intro_driver_assassinate" )
            {
                driver = guy;
            }
        }
    }
    
    wait 0.2;
    
    foreach ( guy in aiarray )
    {
        if ( isdefined( guy ) )
        {
            guy.ignoreme = 0;
        }
    }
    
    level.woods.ignoreall = 0;
    level.woods.ignoreme = 0;
    
    foreach ( guy in aiarray )
    {
        if ( isdefined( guy ) )
        {
            if ( !( isdefined( guy.script_parameters ) && guy.script_parameters == "squirter" ) )
            {
                guy.ignoreall = 0;
            }
        }
    }
}

// Namespace namespace_9c42e5f3/namespace_c6b8d870
// Params 0
// Checksum 0xda2ab1a5, Offset: 0xa80
// Size: 0xc4
function function_a7dc18f3()
{
    aiarray = array();
    level flag::set( "intro_heli_lights_on" );
    thread function_46693791();
    level flag::wait_till( "intro_takeout_target" );
    dialogue::radio( "vox_cp_tdwn_01300_chp1_notsureithought_5a" );
    level flag::set( "truck_bustout_unload" );
    level flag::set( "heli_convoy_aslt_complete" );
}

