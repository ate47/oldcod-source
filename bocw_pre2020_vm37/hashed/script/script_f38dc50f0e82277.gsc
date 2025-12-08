#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace doa_banner;

// Namespace doa_banner/doa_banner
// Params 0
// Checksum 0x902177f1, Offset: 0xd0
// Size: 0x34
function init()
{
    clientfield::register( "world", "banner_event", 1, 6, "int" );
}

// Namespace doa_banner/doa_banner
// Params 1
// Checksum 0xa5451b96, Offset: 0x110
// Size: 0x6c
function function_7a0e5387( event = 63 )
{
    level clientfield::set( "banner_event", 0 );
    util::wait_network_frame();
    level clientfield::set( "banner_event", event );
}

