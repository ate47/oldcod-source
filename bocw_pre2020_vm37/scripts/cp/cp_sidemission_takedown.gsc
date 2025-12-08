#using script_122afd04d0de2423;
#using script_15a7051a4ff0cf46;
#using script_30cfffd6b7b2b212;
#using script_31e02d627cf2fc9d;
#using script_3890e6e179f6ed13;
#using script_52e44090bd3b849d;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\ammo_resupply_crate;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;

#namespace namespace_3da2ad62;

// Namespace namespace_3da2ad62/level_init
// Params 1, eflags: 0x40
// Checksum 0x113fdc46, Offset: 0x1e8
// Size: 0x9c
function event_handler[level_init] main( *eventstruct )
{
    init_clientfields();
    function_37dfd679();
    load::main();
    init_callbacks();
    level.player = getplayers()[ 0 ];
    setdvar( #"compassmaxrange", "2100" );
}

// Namespace namespace_3da2ad62/cp_sidemission_takedown
// Params 0
// Checksum 0x8f2c1d6, Offset: 0x290
// Size: 0x1e4
function function_37dfd679()
{
    skipto::function_eb91535d( "tkdn_heli_intro", &namespace_347b95ee::main, &namespace_347b95ee::starting, "Chaos: Heli", &namespace_347b95ee::cleanup );
    skipto::function_eb91535d( "tkdn_heli_convoy_aslt", &namespace_9c42e5f3::main, &namespace_9c42e5f3::starting, "Chaos: Convoy Assault", &namespace_9c42e5f3::cleanup );
    skipto::function_eb91535d( "tkdn_heli_trailer_park", &namespace_1ca393d1::main, &namespace_1ca393d1::starting, "Chaos: Trailer Park", &namespace_1ca393d1::cleanup );
    skipto::function_eb91535d( "tkdn_heli_hotel_parking_lot", &namespace_f464d565::function_b474f6be, &namespace_f464d565::function_dbf2a80e, "Chaos: Hotel Parking Lot", &namespace_f464d565::function_a81c2225 );
    skipto::function_eb91535d( "tkdn_heli_hotel_breach", &namespace_f464d565::main, &namespace_f464d565::starting, "Chaos: Hotel Breach", &namespace_f464d565::cleanup );
    skipto::function_eb91535d( "tkdn_heli_exfil", &namespace_fe8e156a::main, &namespace_fe8e156a::starting, "Chaos: Exfil", &namespace_fe8e156a::cleanup );
}

// Namespace namespace_3da2ad62/cp_sidemission_takedown
// Params 0
// Checksum 0x47925deb, Offset: 0x480
// Size: 0x24
function init_clientfields()
{
    namespace_347b95ee::init_clientfields();
    namespace_42da7c51::init_clientfields();
}

// Namespace namespace_3da2ad62/cp_sidemission_takedown
// Params 0
// Checksum 0x1d634f0e, Offset: 0x4b0
// Size: 0x44
function init_callbacks()
{
    callback::on_spawned( &function_8106e2e1 );
    callback::on_connect( &function_5507f3ad );
}

// Namespace namespace_3da2ad62/cp_sidemission_takedown
// Params 0
// Checksum 0x80f724d1, Offset: 0x500
// Size: 0x4
function function_5507f3ad()
{
    
}

// Namespace namespace_3da2ad62/cp_sidemission_takedown
// Params 0
// Checksum 0xb0657961, Offset: 0x510
// Size: 0x102
function function_8106e2e1()
{
    self setcharacterbodytype( 1 );
    self setcharacteroutfit( 2 );
    thread namespace_42da7c51::setup_objectives( level.var_28c22d88[ 0 ] );
    knife = getweapon( #"knife_held" );
    
    if ( self hasweapon( knife, 1 ) )
    {
        self takeweapon( knife, 1 );
    }
    
    switch ( level.var_28c22d88[ 0 ] )
    {
        default:
            namespace_42da7c51::function_6154e4c2();
            break;
    }
}

