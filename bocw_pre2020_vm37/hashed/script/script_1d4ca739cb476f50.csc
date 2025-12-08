#using scripts\core_common\serverfield_shared;
#using scripts\core_common\system_shared;

#namespace minigame;

// Namespace minigame/namespace_435e13ec
// Params 0, eflags: 0x6
// Checksum 0xede1f144, Offset: 0xa0
// Size: 0x34
function private autoexec __init__system__()
{
    system::register( "minigames", &preinit, undefined, undefined, undefined );
}

// Namespace minigame/namespace_435e13ec
// Params 0, eflags: 0x4
// Checksum 0x248eb720, Offset: 0xe0
// Size: 0x2c
function private preinit()
{
    serverfield::register( "minigame_progress", 1, 3, "int" );
}

// Namespace minigame/namespace_435e13ec
// Params 2
// Checksum 0x1e1c71f9, Offset: 0x118
// Size: 0x84
function notify_progress( e_player, steps )
{
    assert( 8 - 1 >= steps );
    var_4b635559 = int( steps * ( 8 - 1 ) );
    e_player serverfield::set( "minigame_progress", var_4b635559 );
}

