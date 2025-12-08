#using scripts\core_common\callbacks_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\util_shared;

#namespace mp_satellite;

// Namespace mp_satellite/level_init
// Params 1, eflags: 0x40
// Checksum 0x3779dcb, Offset: 0x98
// Size: 0x12c
function event_handler[level_init] main( *eventstruct )
{
    setsaveddvar( #"enable_global_wind", 1 );
    setsaveddvar( #"wind_global_vector", "88 0 0" );
    setsaveddvar( #"wind_global_low_altitude", 0 );
    setsaveddvar( #"wind_global_hi_altitude", 10000 );
    setsaveddvar( #"wind_global_low_strength_percent", 100 );
    callback::on_gameplay_started( &on_gameplay_started );
    load::main();
    level thread function_e5a1065e();
    util::waitforclient( 0 );
}

// Namespace mp_satellite/mp_satellite
// Params 1
// Checksum 0xe4fd622, Offset: 0x1d0
// Size: 0x6c
function on_gameplay_started( *localclientnum )
{
    waitframe( 1 );
    util::function_8eb5d4b0( 3500, 2.5 );
    level notify( #"hash_6ce45f8471d15231" );
    level thread scene::play( #"hash_5657eeda4a6d163f" );
}

// Namespace mp_satellite/mp_satellite
// Params 0
// Checksum 0xdb653064, Offset: 0x248
// Size: 0x174
function function_e5a1065e()
{
    level endon( #"hash_6ce45f8471d15231" );
    
    while ( true )
    {
        level waittill( #"hash_67b3195af66ed4eb" );
        
        foreach ( player in getlocalplayers() )
        {
            player postfx::playpostfxbundle( #"hash_4a3eee8916342bd9" );
        }
        
        level waittill( #"hash_240db290be3c7f0f" );
        
        foreach ( player in getlocalplayers() )
        {
            player postfx::exitpostfxbundle( #"hash_4a3eee8916342bd9" );
        }
    }
}

