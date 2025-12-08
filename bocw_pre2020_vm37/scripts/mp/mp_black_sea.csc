#using script_1e49ab90e3dd5bb8;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\util_shared;

#namespace mp_black_sea;

// Namespace mp_black_sea/level_init
// Params 1, eflags: 0x40
// Checksum 0x7a1bf1a6, Offset: 0x98
// Size: 0x16c
function event_handler[level_init] main( *eventstruct )
{
    level.var_d4865443 = blackseajetskideployprompt::register();
    setsaveddvar( #"enable_global_wind", 1 );
    setsaveddvar( #"wind_global_vector", "88 0 0" );
    setsaveddvar( #"wind_global_low_altitude", 0 );
    setsaveddvar( #"wind_global_hi_altitude", 10000 );
    setsaveddvar( #"wind_global_low_strength_percent", 100 );
    setsaveddvar( #"phys_ragdoll_buoyancy", 1 );
    callback::on_gameplay_started( &on_gameplay_started );
    load::main();
    level thread function_22faec66();
    util::waitforclient( 0 );
}

// Namespace mp_black_sea/mp_black_sea
// Params 1
// Checksum 0x6dd92ffb, Offset: 0x210
// Size: 0x70
function on_gameplay_started( *localclientnum )
{
    waitframe( 1 );
    util::function_8eb5d4b0( 3500, 2.5 );
    setdvar( #"phys_ragdoll_buoyancy", 1 );
    level notify( #"hash_3eb74ffb77c6b4b6" );
}

// Namespace mp_black_sea/mp_black_sea
// Params 0
// Checksum 0xeaefdfdc, Offset: 0x288
// Size: 0x174
function function_22faec66()
{
    level endon( #"hash_3eb74ffb77c6b4b6" );
    
    while ( true )
    {
        level waittill( #"hash_20397d5f66793917" );
        
        foreach ( player in getlocalplayers() )
        {
            player postfx::playpostfxbundle( #"hash_50d5d465e2b9b355" );
        }
        
        level waittill( #"hash_3acd8a1b1fe43b7b" );
        
        foreach ( player in getlocalplayers() )
        {
            player postfx::exitpostfxbundle( #"hash_50d5d465e2b9b355" );
        }
    }
}

