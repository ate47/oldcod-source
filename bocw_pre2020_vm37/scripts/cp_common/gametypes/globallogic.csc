#using scripts\core_common\system_shared;
#using scripts\core_common\visionset_mgr_shared;

#namespace globallogic;

// Namespace globallogic/globallogic
// Params 0, eflags: 0x6
// Checksum 0xcee18d5, Offset: 0x98
// Size: 0x44
function private autoexec __init__system__()
{
    system::register( #"globallogic", &preinit, undefined, undefined, #"visionset_mgr" );
}

// Namespace globallogic/globallogic
// Params 0, eflags: 0x4
// Checksum 0x34f791a7, Offset: 0xe8
// Size: 0x60
function private preinit()
{
    visionset_mgr::register_visionset_info( "crithealth", 1, 25, undefined, "critical_health" );
    level.new_health_model = getdvarint( #"new_health_model", 1 ) > 0;
}

