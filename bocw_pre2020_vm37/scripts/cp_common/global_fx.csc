#using scripts\core_common\fx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;

#namespace global_fx;

// Namespace global_fx/global_fx
// Params 0, eflags: 0x6
// Checksum 0xbb4a8556, Offset: 0x78
// Size: 0x4c
function private autoexec __init__system__()
{
    system::register( #"global_fx", &preinit, &main, undefined, undefined );
}

// Namespace global_fx/global_fx
// Params 0, eflags: 0x4
// Checksum 0x80f724d1, Offset: 0xd0
// Size: 0x4
function private preinit()
{
    
}

// Namespace global_fx/global_fx
// Params 0
// Checksum 0xb330c12a, Offset: 0xe0
// Size: 0x14
function main()
{
    check_for_wind_override();
}

// Namespace global_fx/global_fx
// Params 0
// Checksum 0x32ffc891, Offset: 0x100
// Size: 0x28
function check_for_wind_override()
{
    if ( isdefined( level.custom_wind_callback ) )
    {
        level thread [[ level.custom_wind_callback ]]();
    }
}

