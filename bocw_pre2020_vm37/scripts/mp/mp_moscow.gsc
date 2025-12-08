#using script_67ce8e728d8f37ba;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\compass;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\scene_shared;
#using scripts\killstreaks\killstreaks_shared;

#namespace mp_moscow;

// Namespace mp_moscow/level_init
// Params 1, eflags: 0x40
// Checksum 0x4c67ee34, Offset: 0xd0
// Size: 0x84
function event_handler[level_init] main( *eventstruct )
{
    namespace_66d6aa44::function_3f3466c9();
    killstreaks::function_257a5f13( "straferun", 40 );
    killstreaks::function_257a5f13( "helicopter_comlink", 75 );
    load::main();
    compass::setupminimap( "" );
}

