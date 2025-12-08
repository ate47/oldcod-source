#using scripts\core_common\rat_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\util;

#namespace rat;

/#

    // Namespace rat/rat
    // Params 0, eflags: 0x6
    // Checksum 0x6de931e1, Offset: 0x80
    // Size: 0x3c, Type: dev
    function private autoexec __init__system__()
    {
        system::register( #"rat", &preinit, undefined, undefined, undefined );
    }

    // Namespace rat/rat
    // Params 0, eflags: 0x4
    // Checksum 0xd9e6079b, Offset: 0xc8
    // Size: 0x42, Type: dev
    function private preinit()
    {
        init();
        level.rat.common.gethostplayer = &util::gethostplayer;
    }

#/
