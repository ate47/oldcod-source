#using scripts\core_common\compass;
#using scripts\core_common\load_shared;

#namespace wz_ski_slopes;

// Namespace wz_ski_slopes/level_init
// Params 1, eflags: 0x40
// Checksum 0x644f374e, Offset: 0x78
// Size: 0x44
function event_handler[level_init] main( *eventstruct )
{
    load::main();
    level.var_29cfe9dd = 1;
    compass::setupminimap( "" );
}

