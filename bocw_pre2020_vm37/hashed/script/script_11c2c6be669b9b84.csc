#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;

#namespace scripted_widgets;

// Namespace scripted_widgets/scripted_widgets
// Params 0, eflags: 0x6
// Checksum 0xe45ef2af, Offset: 0xf0
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"scripted_widgets", &preload, undefined, undefined, undefined );
}

// Namespace scripted_widgets/scripted_widgets
// Params 0, eflags: 0x4
// Checksum 0xbd0ec96, Offset: 0x138
// Size: 0x34
function private preload()
{
    callback::add_callback( #"on_player_spawned", &on_player_spawn );
}

// Namespace scripted_widgets/scripted_widgets
// Params 1
// Checksum 0xdf68c158, Offset: 0x178
// Size: 0x210
function on_player_spawn( *localclientnum )
{
    self endon( #"death" );
    inputs = [];
    inputs[ #"ui_confirm" ] = "confirm";
    inputs[ #"ui_cancel" ] = "cancel";
    inputs[ #"ui_alt1" ] = "alt1";
    inputs[ #"ui_alt2" ] = "alt2";
    inputs[ #"ui_navup" ] = "navup";
    inputs[ #"ui_navdown" ] = "navdown";
    inputs[ #"ui_navleft" ] = "navleft";
    inputs[ #"ui_navright" ] = "navright";
    inputs[ #"ui_prevtab" ] = "prevtab";
    inputs[ #"ui_nexttab" ] = "nexttab";
    inputs[ #"ui_backspace" ] = "backspace";
    
    foreach ( key, value in inputs )
    {
        self flag::clear( key );
    }
    
    while ( true )
    {
        waitresult = level waittill( #"ui_input" );
        self childthread flag::set_for_time( 0.05, waitresult.param1 );
    }
}

// Namespace scripted_widgets/scripted_widgets
// Params 0
// Checksum 0x83a303ea, Offset: 0x390
// Size: 0x22
function function_affb1af1()
{
    return self flag::get( #"ui_confirm" );
}

// Namespace scripted_widgets/scripted_widgets
// Params 0
// Checksum 0x619db138, Offset: 0x3c0
// Size: 0x22
function function_57fbd346()
{
    return self flag::get( #"ui_cancel" );
}

// Namespace scripted_widgets/scripted_widgets
// Params 0
// Checksum 0x4c4a193a, Offset: 0x3f0
// Size: 0x22
function function_e4d62f9a()
{
    return self flag::get( #"ui_alt1" );
}

// Namespace scripted_widgets/scripted_widgets
// Params 0
// Checksum 0x69e02a4c, Offset: 0x420
// Size: 0x22
function function_728aec47()
{
    return self flag::get( #"ui_alt2" );
}

// Namespace scripted_widgets/scripted_widgets
// Params 0
// Checksum 0x2a61febb, Offset: 0x450
// Size: 0x22
function function_aef1e8c3()
{
    return self flag::get( #"ui_navup" );
}

// Namespace scripted_widgets/scripted_widgets
// Params 0
// Checksum 0x90ecb785, Offset: 0x480
// Size: 0x22
function function_9975a94d()
{
    return self flag::get( #"ui_navdown" );
}

// Namespace scripted_widgets/scripted_widgets
// Params 0
// Checksum 0xe0a8cdad, Offset: 0x4b0
// Size: 0x22
function function_c2d8a326()
{
    return self flag::get( #"ui_navleft" );
}

// Namespace scripted_widgets/scripted_widgets
// Params 0
// Checksum 0x79930810, Offset: 0x4e0
// Size: 0x22
function function_3d680c10()
{
    return self flag::get( #"ui_navright" );
}

// Namespace scripted_widgets/scripted_widgets
// Params 0
// Checksum 0xa579c9fa, Offset: 0x510
// Size: 0x22
function function_d0beaa6e()
{
    return self flag::get( #"ui_prevtab" );
}

// Namespace scripted_widgets/scripted_widgets
// Params 0
// Checksum 0xf57715ab, Offset: 0x540
// Size: 0x22
function function_1e9035e9()
{
    return self flag::get( #"ui_nexttab" );
}

// Namespace scripted_widgets/scripted_widgets
// Params 0
// Checksum 0x5f7b2421, Offset: 0x570
// Size: 0x22
function function_57799116()
{
    return self flag::get( #"ui_backspace" );
}

