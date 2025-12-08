#using script_3defbd925a406475;
#using scripts\core_common\load_shared;
#using scripts\core_common\util_shared;

#namespace cp_ger_hub;

// Namespace cp_ger_hub/level_init
// Params 1, eflags: 0x40
// Checksum 0xdce6a4c6, Offset: 0x78
// Size: 0x44
function event_handler[level_init] main( *eventstruct )
{
    namespace_fa9f53a2::main();
    load::main();
    util::waitforclient( 0 );
}

