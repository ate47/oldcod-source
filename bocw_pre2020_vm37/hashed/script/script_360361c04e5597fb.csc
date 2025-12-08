#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;

#namespace namespace_7457b8d5;

// Namespace namespace_7457b8d5/namespace_7457b8d5
// Params 0
// Checksum 0xa6309978, Offset: 0xb8
// Size: 0x2c
function init()
{
    vehicle::add_vehicletype_callback( "spider", &function_2503e2a );
}

// Namespace namespace_7457b8d5/namespace_7457b8d5
// Params 1, eflags: 0x4
// Checksum 0x71198ee1, Offset: 0xf0
// Size: 0xc
function private function_2503e2a( *localclientnum )
{
    
}

