#using script_2d443451ce681a;
#using script_30cfffd6b7b2b212;
#using script_3dc93ca9902a9cda;
#using script_67332a4d085a140a;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\colors_shared;
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
#using scripts\cp_common\spawn_manager;
#using scripts\cp_common\util;

#namespace namespace_fe8e156a;

// Namespace namespace_fe8e156a/namespace_608aa918
// Params 1
// Checksum 0x76b0f1b2, Offset: 0x708
// Size: 0x164
function starting( *var_d3440450 )
{
    namespace_42da7c51::function_ed760ecb( "woods" );
    level.var_9a3944f4 = ai::array_spawn( "exfil_heli" )[ 0 ];
    level.var_9a3944f4 thread namespace_42da7c51::function_fbb0d73f();
    level thread namespace_42da7c51::heli_light( level.var_9a3944f4, "ally_heli_spot_light_bustout", "tag_fx_running_light_front_side_left_01", ( -20, 12, 0 ), level.var_9a3944f4, 0, 1 );
    level.var_9a3944f4 thread namespace_42da7c51::function_3cebcd1b();
    level.var_9a3944f4 util::delay_notify( 0.2, "lights_on" );
    callback::on_player_damage( &function_aa3c5fab );
    level.var_7c11765c = 0;
    level.last_player_attacker = level;
    level flag::set( #"hash_5601fb6019314f30" );
    level thread function_d192fdd4();
}

// Namespace namespace_fe8e156a/namespace_608aa918
// Params 2
// Checksum 0x6a601251, Offset: 0x878
// Size: 0x194
function main( var_d3440450, *var_50cc0d4f )
{
    if ( isdefined( level.var_9a3944f4 ) )
    {
        thread heli_logic();
    }
    
    level thread function_978c193();
    level thread function_3a20dd4c();
    level flag::wait_till( "parking_lot_combat_complete" );
    level thread function_1fcf893b();
    level thread function_ead2bec4( "player_runaway", "truck_riders", "script_aigroup" );
    level thread trailer_park_combat();
    level flag::wait_till( "trailer_park_combat_complete" );
    level thread function_848ad996();
    level flag::wait_till( "gas_station_escape_complete" );
    
    if ( isdefined( var_50cc0d4f ) )
    {
        skipto::function_4e3ab877( var_50cc0d4f );
    }
    
    level util::screen_fade_out( 1.5 );
    skipto::function_1c2dfc20( "cp_ger_hub" );
}

// Namespace namespace_fe8e156a/namespace_608aa918
// Params 4
// Checksum 0x1950e8ee, Offset: 0xa18
// Size: 0x24
function cleanup( *name, *starting, *direct, *player )
{
    
}

// Namespace namespace_fe8e156a/namespace_608aa918
// Params 0
// Checksum 0xa671b860, Offset: 0xa48
// Size: 0xc4
function function_d192fdd4()
{
    ai = spawner::simple_spawn_single( "aldrich_spawner" );
    ai setteam( #"axis" );
    ai.health = 1;
    ai.var_c681e4c1 = 1;
    ai.skipdeath = 1;
    level thread scene::play( "aib_engineer_injured_guy_wounded", [ ai ] );
    ai setcandamage( 1 );
    ai ai::bloody_death();
}

// Namespace namespace_fe8e156a/namespace_608aa918
// Params 0
// Checksum 0x47539af5, Offset: 0xb18
// Size: 0x24c
function function_3a20dd4c()
{
    trucks = vehicle::simple_spawn_and_drive( "parking_lot_truck" );
    
    foreach ( truck in trucks )
    {
        truck vehicle::lights_on();
    }
    
    level flag::set( "parking_lot_truck" );
    level thread namespace_61150688::function_2db60235();
    waitframe( 3 );
    parking_lot_baddies = function_f0f342d5( trucks );
    var_940889f4 = getaiarray( "parking_lot_truck_riders_2", "script_aigroup" );
    
    foreach ( agent in var_940889f4 )
    {
        agent ai::set_goal( "vol_outer_parking_lot", "targetname" );
    }
    
    level thread function_3c2366a7( parking_lot_baddies, 4, "woods_end_of_parking_lot", "woods_objective_up" );
    level thread function_ed60fe85( parking_lot_baddies, "speedrunning_check", "woods_objective_up" );
    level flag::wait_till( "woods_objective_up" );
    function_9c431ddc( parking_lot_baddies, 2, "parking_lot_combat_complete" );
}

// Namespace namespace_fe8e156a/namespace_608aa918
// Params 4
// Checksum 0x11180fe6, Offset: 0xd70
// Size: 0x10c
function function_3c2366a7( array, num, targetname, flag )
{
    if ( array.size <= 0 )
    {
        return;
    }
    
    level ai::waittill_dead_or_dying( array, array.size - num );
    level objectives::follow( "woods_exfil", level.woods );
    level flag::set( flag );
    front_guys = getaiarray( "front_guys", "script_aigroup" );
    
    if ( isdefined( level.woods ) )
    {
        level.woods ai::set_goal_node( getnode( targetname, "targetname" ) );
    }
}

// Namespace namespace_fe8e156a/namespace_608aa918
// Params 3
// Checksum 0x733ac003, Offset: 0xe88
// Size: 0x140
function function_ed60fe85( array, flag, var_7e81cdfd )
{
    level flag::wait_till( flag );
    
    if ( level flag::get( var_7e81cdfd ) )
    {
        return;
    }
    
    foreach ( agent in array )
    {
        if ( isdefined( agent ) && isalive( agent ) && isdefined( getplayers()[ 0 ] ) )
        {
            agent.goalradius = 256;
            agent.ignoresuppression = 1;
            agent ai::set_goal_ent( getplayers()[ 0 ] );
        }
    }
}

// Namespace namespace_fe8e156a/namespace_608aa918
// Params 4
// Checksum 0xe114ec1b, Offset: 0xfd0
// Size: 0x19c
function function_9c431ddc( array, var_6ab9c420, flag, rush = 1 )
{
    if ( array.size <= 0 )
    {
        return;
    }
    
    level ai::waittill_dead_or_dying( array, array.size - var_6ab9c420 );
    
    if ( rush )
    {
        foreach ( agent in array )
        {
            if ( isdefined( agent ) && isalive( agent ) && isdefined( getplayers()[ 0 ] ) )
            {
                agent.goalradius = 256;
                agent ai::set_goal_ent( getplayers()[ 0 ] );
            }
        }
    }
    
    if ( rush )
    {
        level ai::waittill_dead_or_dying( array );
    }
    
    level flag::set( flag );
}

// Namespace namespace_fe8e156a/namespace_608aa918
// Params 0
// Checksum 0xc2f2c73d, Offset: 0x1178
// Size: 0x13c
function function_1fcf893b()
{
    level thread savegame::checkpoint_save();
    level flag::wait_till( "truck_spawn" );
    truck_convoy = vehicle::simple_spawn_and_drive( "truck_convoy" );
    
    foreach ( truck in truck_convoy )
    {
        truck vehicle::lights_on();
    }
    
    if ( isdefined( level.woods ) )
    {
        level.woods ai::force_goal( getnode( "woods_run_trailer_park", "targetname" ), 0, "goal", 1, 1 );
    }
}

// Namespace namespace_fe8e156a/namespace_608aa918
// Params 1
// Checksum 0x2a12ace6, Offset: 0x12c0
// Size: 0x11e
function function_f0f342d5( vehicle_array )
{
    var_bb75350d = [];
    
    foreach ( vehicle in vehicle_array )
    {
        riders = vehicle vehicle::function_86c7bebb();
        
        foreach ( rider in riders )
        {
            var_bb75350d[ var_bb75350d.size ] = rider;
        }
    }
    
    return var_bb75350d;
}

// Namespace namespace_fe8e156a/namespace_608aa918
// Params 3
// Checksum 0x7ff9ccf6, Offset: 0x13e8
// Size: 0x18a
function function_ead2bec4( flag, value, key = "targetname" )
{
    flag_set = 0;
    first_time = 1;
    
    while ( true )
    {
        if ( level flag::get( flag ) != flag_set )
        {
            truck_riders = getaiarray( value, key );
            
            foreach ( agent in truck_riders )
            {
                if ( isdefined( agent ) && isalive( agent ) )
                {
                    agent.perfectaim = !flag_set;
                }
            }
            
            flag_set = !flag_set;
            
            if ( first_time )
            {
                iprintlnbold( "Woods: Mason, where the fuck are you going?" );
                first_time = 0;
            }
        }
        
        if ( level flag::get( "gas_station_escape_complete" ) )
        {
            return;
        }
        
        waitframe( 1 );
    }
}

// Namespace namespace_fe8e156a/namespace_608aa918
// Params 0
// Checksum 0xe776a8a2, Offset: 0x1580
// Size: 0x524
function trailer_park_combat()
{
    level flag::wait_till( "trailer_park_combat" );
    level flag::set( "heli_going_to_gas_station" );
    level objectives::remove( "woods_exfil", level.woods );
    level objectives::function_4eb5c04a( "exfil", struct::get( "exfil_location", "targetname" ).origin );
    objectives::function_67f87f80( "exfil", undefined, #"hash_7cbf5630c9cd76d7" );
    
    if ( isdefined( level.var_664fd741 ) )
    {
        level.woods ai::set_goal( "vol_woods_goal_outer" );
        level.woods.ignoresuppression = 0;
    }
    
    var_cd3acbe7 = ai::array_spawn( "tp_escape_wave_1" );
    
    foreach ( agent in var_cd3acbe7 )
    {
        if ( isdefined( agent.var_9566b01a ) )
        {
            agent ai::set_goal_node( getnode( "tp_escape_" + agent.script_noteworthy, "targetname" ) );
        }
    }
    
    level thread function_9c431ddc( var_cd3acbe7, 2, "tp_escape_wave_2", 0 );
    level flag::wait_till( "tp_escape_wave_2" );
    
    if ( isdefined( level.woods ) )
    {
        level.woods ai::set_goal( "vol_woods_goal_inner" );
        level.woods.ignoresuppression = 0;
    }
    
    var_15f6dd6a = ai::array_spawn( "tp_escape_wave_2" );
    
    foreach ( agent in var_15f6dd6a )
    {
        if ( isdefined( agent.script_noteworthy ) )
        {
            agent ai::set_goal_node( getnode( "tp_escape_" + agent.script_noteworthy, "targetname" ) );
        }
    }
    
    var_e57ef698 = arraycombine( var_cd3acbe7, var_15f6dd6a );
    level thread function_9c431ddc( var_e57ef698, 3, "trailer_tops_clear" );
    level flag::wait_till( "trailer_tops_clear" );
    
    if ( isdefined( level.woods ) )
    {
        level.woods.ignoresuppression = 1;
        level.woods.grenadeawareness = 0;
        level.woods val::set( #"ai_forcegoal", "ignoreme", 1 );
        level.woods.fixednode = 1;
        level.woods.goalradius = 32;
        level.woods colors::disable();
        level.woods ai::force_goal( getnode( "woods_top_of_trailers", "targetname" ), 0 );
        level.woods ai::set_goal_node( getnode( "woods_wait_jump", "targetname" ) );
    }
    
    spawn_manager::enable( "spawn_manager_tension_enemies" );
    level thread function_d38f3cd1( "tension_enemies", "script_aigroup" );
}

// Namespace namespace_fe8e156a/namespace_608aa918
// Params 2
// Checksum 0xa7d1bbba, Offset: 0x1ab0
// Size: 0x148
function function_d38f3cd1( value, key = "targetname" )
{
    level flag::wait_till( "fell_off_trailers" );
    spawn_manager::disable( "spawn_manager_tension_enemies" );
    enemies = getaiarray( value, key );
    
    foreach ( agent in enemies )
    {
        if ( isdefined( agent ) && isalive( agent ) )
        {
            agent.goalradius = 256;
            agent ai::set_goal_ent( getplayers()[ 0 ] );
        }
    }
}

// Namespace namespace_fe8e156a/namespace_608aa918
// Params 0
// Checksum 0xb004607e, Offset: 0x1c00
// Size: 0x24
function function_848ad996()
{
    level flag::set( "gas_station_escape_complete" );
}

// Namespace namespace_fe8e156a/namespace_608aa918
// Params 0
// Checksum 0x405a164c, Offset: 0x1c30
// Size: 0x64
function heli_logic()
{
    if ( !isdefined( level.var_9a3944f4 ) )
    {
        return;
    }
    
    level.var_33621ea7 = 1;
    level flag::wait_till( "woods_move_out" );
    level.var_9a3944f4 vehicle::get_on_and_go_path( "heli_parking_lot_path" );
}

// Namespace namespace_fe8e156a/namespace_608aa918
// Params 1
// Checksum 0xb439f70b, Offset: 0x1ca0
// Size: 0x14c
function function_aa3c5fab( params )
{
    if ( !isdefined( level.var_9a3944f4 ) )
    {
        return;
    }
    
    level.var_9a3944f4.forward_scalar = 1;
    attacker = params.eattacker;
    
    if ( isdefined( attacker ) && isai( attacker ) )
    {
        if ( attacker.targetname === "truck_riders" )
        {
            return;
        }
        
        if ( attacker == level.last_player_attacker )
        {
            level.var_9a3944f4 thread namespace_42da7c51::function_cbe25a41( attacker, "tag_searchlight_fx", 1 );
            level.var_7c11765c = gettime();
            return;
        }
        
        if ( level.var_7c11765c < gettime() - 3000 || !isalive( level.last_player_attacker ) )
        {
            level.var_7c11765c = gettime();
            level.last_player_attacker = attacker;
            level.var_9a3944f4 thread namespace_42da7c51::function_cbe25a41( attacker, "tag_searchlight_fx", 1 );
        }
    }
}

// Namespace namespace_fe8e156a/namespace_608aa918
// Params 0
// Checksum 0xf8ab3b9c, Offset: 0x1df8
// Size: 0x19c
function function_978c193()
{
    level flag::wait_till( "parking_lot_truck" );
    wait randomfloatrange( 1, 2 );
    iprintlnbold( "Woods: Shit, Mason! We've got some company!" );
    level flag::wait_till( "woods_objective_up" );
    wait randomfloatrange( 1, 2 );
    iprintlnbold( "Woods: We gotta move! Let's get to the helicopter!" );
    level flag::wait_till( "truck_spawn" );
    iprintlnbold( "Heli Pilot: They're sending in more trucks. Exfil's getting too hot." );
    wait 4;
    iprintlnbold( "Woods: Shit, go right! Go right!" );
    level flag::wait_till( "heli_going_to_gas_station" );
    iprintlnbold( "Heli Pilot: Highway's being surrounded." );
    iprintlnbold( "Moving exfil location to the top of the gas station." );
    iprintlnbold( "Try and get up there fast" );
    level flag::wait_till( "trailer_tops_clear" );
    iprintlnbold( "Woods: Mason, let's go! Get up on the trailers!" );
}

// Namespace namespace_fe8e156a/namespace_608aa918
// Params 3
// Checksum 0xbbb8ba9e, Offset: 0x1fa0
// Size: 0x224
function function_3f06810a( aigroup, var_9fe12ee0, targetname )
{
    var_5f4052dd = getaiarray( aigroup, "script_aigroup" );
    
    foreach ( agent in var_5f4052dd )
    {
        agent.goalradius = 1500;
        agent ai::set_goal_ent( getplayers()[ 0 ] );
    }
    
    level flag::wait_till( var_9fe12ee0 );
    
    foreach ( agent in var_5f4052dd )
    {
        if ( isdefined( agent ) && isalive( agent ) )
        {
            agent.goalradius = 256;
            
            if ( isdefined( targetname ) )
            {
                agent ai::force_goal( getent( targetname, "targetname" ) );
                continue;
            }
            
            agent ai::force_goal( getplayers()[ 0 ] );
        }
    }
    
    level flag::set( "balcony_complete" );
}

// Namespace namespace_fe8e156a/namespace_608aa918
// Params 1
// Checksum 0x7f87b5bf, Offset: 0x21d0
// Size: 0xc4
function function_bdf7e651( seconds )
{
    wait seconds;
    
    if ( flag::get( "right_staircase_approach" ) || flag::get( "left_staircase_approach" ) || flag::get( "balcony_complete" ) )
    {
        return;
    }
    
    level flag::set( "right_staircase_approach" );
    level flag::set( "left_staircase_approach" );
    level flag::set( "balcony_complete" );
}

