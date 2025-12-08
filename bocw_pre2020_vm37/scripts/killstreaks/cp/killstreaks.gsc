#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\cp\killstreakrules;
#using scripts\killstreaks\killstreaks_shared;

#namespace killstreaks;

// Namespace killstreaks/killstreaks
// Params 0, eflags: 0x6
// Checksum 0x70882211, Offset: 0x80
// Size: 0x44
function private autoexec __init__system__()
{
    system::register( #"killstreaks", &preinit, undefined, undefined, #"weapons" );
}

// Namespace killstreaks/killstreaks
// Params 0, eflags: 0x4
// Checksum 0x6e01c150, Offset: 0xd0
// Size: 0x34
function private preinit()
{
    init_shared();
    callback::on_start_gametype( &init );
}

// Namespace killstreaks/killstreaks
// Params 0
// Checksum 0xd1850b12, Offset: 0x110
// Size: 0xf4
function init()
{
    /#
        level.killstreak_init_start_time = getmillisecondsraw();
        thread debug_ricochet_protection();
    #/
    
    function_447e6858();
    callback::callback( #"hash_45f35669076bc317" );
    killstreakrules::init();
    
    /#
        level.killstreak_init_end_time = getmillisecondsraw();
        elapsed_time = level.killstreak_init_end_time - level.killstreak_init_start_time;
        println( "<dev string:x38>" + elapsed_time + "<dev string:x59>" );
        level thread killstreak_debug_think();
    #/
}

