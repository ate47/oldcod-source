#using script_340a2e805e35f7a2;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\item_world_util;
#using scripts\core_common\struct;

#namespace item_spawn_group;

// Namespace item_spawn_group/item_spawn_groups
// Params 2
// Checksum 0xbe3a5aa8, Offset: 0x80
// Size: 0xb4
function setup( seedvalue, reset = 1 )
{
    if ( !item_world_util::use_item_spawns() )
    {
        return;
    }
    
    function_1f4464c0( seedvalue );
    println( "<dev string:x38>" + seedvalue );
    
    if ( reset )
    {
        level callback::callback( #"hash_11bd48298bde44a4", undefined );
    }
    
    namespace_65181344::setup_groups( reset );
}

