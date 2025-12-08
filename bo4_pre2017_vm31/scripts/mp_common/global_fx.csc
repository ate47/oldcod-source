#using scripts/core_common/fx_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;

#namespace global_fx;

// Namespace global_fx/global_fx
// Params 0, eflags: 0x2
// Checksum 0xf00cb5cd, Offset: 0x168
// Size: 0x3c
function autoexec __init__sytem__()
{
    system::register( "global_fx", &__init__, &main, undefined );
}

// Namespace global_fx/global_fx
// Params 0
// Checksum 0xe82234e0, Offset: 0x1b0
// Size: 0x14
function __init__()
{
    wind_initial_setting();
}

// Namespace global_fx/global_fx
// Params 0
// Checksum 0x202d3fcf, Offset: 0x1d0
// Size: 0x14
function main()
{
    check_for_wind_override();
}

// Namespace global_fx/global_fx
// Params 0
// Checksum 0x6592700, Offset: 0x1f0
// Size: 0x94
function wind_initial_setting()
{
    setsaveddvar( "enable_global_wind", 0 );
    setsaveddvar( "wind_global_vector", "0 0 0" );
    setsaveddvar( "wind_global_low_altitude", 0 );
    setsaveddvar( "wind_global_hi_altitude", 10000 );
    setsaveddvar( "wind_global_low_strength_percent", 0.5 );
}

// Namespace global_fx/global_fx
// Params 0
// Checksum 0xf623b07c, Offset: 0x290
// Size: 0x2c
function check_for_wind_override()
{
    if ( isdefined( level.custom_wind_callback ) )
    {
        level thread [[ level.custom_wind_callback ]]();
    }
}

