#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;

#namespace namespace_81522b3c;

// Namespace namespace_81522b3c/namespace_81522b3c
// Params 0
// Checksum 0x2ccbde88, Offset: 0xd0
// Size: 0x2c
function init()
{
    vehicle::add_vehicletype_callback( "bat", &function_9b3fe343 );
}

// Namespace namespace_81522b3c/namespace_81522b3c
// Params 1, eflags: 0x4
// Checksum 0x2046d184, Offset: 0x108
// Size: 0x74
function private function_9b3fe343( localclientnum )
{
    self mapshaderconstant( localclientnum, 0, "scriptVector2", 0.1 );
    
    if ( is_true( level.debug_keyline_zombies ) )
    {
    }
    
    util::playfxontag( localclientnum, #"hash_1cb1e3e527bd121c", self, "tag_eye" );
}

