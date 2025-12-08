#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;

#namespace vehicles;

// Namespace vehicles/globallogic_vehicle
// Params 0, eflags: 0x6
// Checksum 0x1a058301, Offset: 0x78
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"globallogic_vehicle", &preinit, undefined, undefined, undefined );
}

// Namespace vehicles/globallogic_vehicle
// Params 0, eflags: 0x4
// Checksum 0x80f724d1, Offset: 0xc0
// Size: 0x4
function private preinit()
{
    
}

