#using scripts\core_common\serverfield_shared;
#using scripts\core_common\system_shared;
#using scripts\cp_common\hint_tutorial;

#namespace namespace_9b5aa273;

// Namespace namespace_9b5aa273/namespace_9b5aa273
// Params 0, eflags: 0x6
// Checksum 0x329ea5f2, Offset: 0xa0
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"hash_2b0f887705d6f3e", &preinit, undefined, undefined, undefined );
}

// Namespace namespace_9b5aa273/namespace_9b5aa273
// Params 0, eflags: 0x4
// Checksum 0x4765948e, Offset: 0xe8
// Size: 0x3c
function private preinit()
{
    serverfield::register( "can_show_hold_breath_hint", 1, 1, "int", &function_b58b73b6 );
}

// Namespace namespace_9b5aa273/namespace_9b5aa273
// Params 2, eflags: 0x4
// Checksum 0xfe56cadd, Offset: 0x130
// Size: 0x84
function private function_b58b73b6( oldval, newval )
{
    if ( oldval == newval )
    {
        return;
    }
    
    if ( newval )
    {
        hint_tutorial::function_4c2d4fc4( #"hash_5b4b0dc5da9b211d", #"", 0, #"", 2 );
        return;
    }
    
    hint_tutorial::function_9f427d88( 0 );
}

// Namespace namespace_9b5aa273/event_6aa1189e
// Params 0, eflags: 0x40
// Checksum 0x24dba18d, Offset: 0x1c0
// Size: 0x44
function event_handler[event_6aa1189e] function_c6a7519f()
{
    player = self;
    player.var_35ee6252 = 1;
    setslowmotion( 1, 0.2, 0.5 );
}

// Namespace namespace_9b5aa273/event_822128d0
// Params 0, eflags: 0x40
// Checksum 0xbeaf6c07, Offset: 0x210
// Size: 0x64
function event_handler[event_822128d0] function_255956d5()
{
    player = self;
    
    if ( is_true( player.var_35ee6252 ) )
    {
        player.var_35ee6252 = undefined;
        setslowmotion( 0.2, 1, 0.1 );
    }
}

