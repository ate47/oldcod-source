#using script_4cf7b14ad21db4a0;
#using scripts\core_common\load_shared;
#using scripts\core_common\util_shared;

#namespace cp_sidemission_tundra;

// Namespace cp_sidemission_tundra/level_init
// Params 1, eflags: 0x40
// Checksum 0x3d952f4d, Offset: 0x88
// Size: 0xf4
function event_handler[level_init] main( *eventstruct )
{
    setsaveddvar( #"enable_global_wind", 1 );
    setsaveddvar( #"wind_global_vector", "88 0 0" );
    setsaveddvar( #"wind_global_low_altitude", 0 );
    setsaveddvar( #"wind_global_hi_altitude", 10000 );
    setsaveddvar( #"wind_global_low_strength_percent", 100 );
    load::main();
    util::waitforclient( 0 );
}

