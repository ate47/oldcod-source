#using script_1b2f6ef7778cf920;
#using script_6872cf0845191c15;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\serverfield_shared;
#using scripts\core_common\util_shared;

#namespace wz_doa;

// Namespace wz_doa/level_init
// Params 1, eflags: 0x40
// Checksum 0x373967a5, Offset: 0xb0
// Size: 0x6c
function event_handler[level_init] main( *eventstruct )
{
    function_1001f0ac();
    assert( isdefined( level.var_f18a6bd6 ), "<dev string:x38>" );
    load::main();
    util::waitforclient( 0 );
}

// Namespace wz_doa/wz_doa
// Params 0
// Checksum 0x326b25dc, Offset: 0x128
// Size: 0x154
function function_1001f0ac()
{
    level.var_e45a8859 = &function_647a2b33;
    level.default_mapping = "zombietron";
    setsaveddvar( #"ik_enable_ai_terrain", 0 );
    setsaveddvar( #"enable_global_wind", 1 );
    setsaveddvar( #"wind_global_vector", "88 0 0" );
    setsaveddvar( #"wind_global_low_altitude", 0 );
    setsaveddvar( #"wind_global_hi_altitude", 10000 );
    setsaveddvar( #"wind_global_low_strength_percent", 100 );
    setsaveddvar( #"hash_7703523dd1279500", 1 );
    setsaveddvar( #"hash_120a4a43c03905a4", 0 );
}

// Namespace wz_doa/wz_doa
// Params 0
// Checksum 0x51ca159b, Offset: 0x288
// Size: 0x6, Type: bool
function function_647a2b33()
{
    return false;
}

