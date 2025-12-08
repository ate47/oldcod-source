#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\tracker_shared;
#using scripts\core_common\util_shared;

#namespace tracker;

// Namespace tracker/tracker
// Params 0, eflags: 0x6
// Checksum 0x208bf84c, Offset: 0x90
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"tracker", &preinit, undefined, undefined, undefined );
}

// Namespace tracker/tracker
// Params 0, eflags: 0x4
// Checksum 0x3f429e57, Offset: 0xd8
// Size: 0x14
function private preinit()
{
    init_shared();
}

