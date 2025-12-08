#using scripts\core_common\compass;
#using scripts\core_common\load_shared;
#using scripts\killstreaks\killstreaks_shared;

#namespace mp_kgb;

// Namespace mp_kgb/level_init
// Params 1, eflags: 0x40
// Checksum 0xae57c99c, Offset: 0xa0
// Size: 0x74
function event_handler[level_init] main( *eventstruct )
{
    killstreaks::function_257a5f13( "straferun", 40 );
    killstreaks::function_257a5f13( "helicopter_comlink", 75 );
    load::main();
    compass::setupminimap( "" );
}

