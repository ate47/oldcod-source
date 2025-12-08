#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\gametypes\globallogic_ui;

#namespace scripted_widgets;

// Namespace scripted_widgets/scripted_widgets
// Params 0, eflags: 0x6
// Checksum 0x88bc1711, Offset: 0x4a0
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"scripted_widgets", &preload, undefined, undefined, undefined );
}

// Namespace scripted_widgets/scripted_widgets
// Params 0, eflags: 0x4
// Checksum 0x9beb54c1, Offset: 0x4e8
// Size: 0x31c
function private preload()
{
    level.scripted_widgets = spawnstruct();
    level.scripted_widgets.active = [];
    level.scripted_widgets.hidden = [];
    level.scripted_widgets.var_db65bf2f = [];
    level.scripted_widgets.inputs = [];
    level.scripted_widgets.inputs[ #"ui_confirm" ] = "confirm";
    level.scripted_widgets.inputs[ #"ui_cancel" ] = "cancel";
    level.scripted_widgets.inputs[ #"ui_alt1" ] = "alt1";
    level.scripted_widgets.inputs[ #"ui_alt2" ] = "alt2";
    level.scripted_widgets.inputs[ #"ui_navup" ] = "navup";
    level.scripted_widgets.inputs[ #"ui_navdown" ] = "navdown";
    level.scripted_widgets.inputs[ #"ui_navleft" ] = "navleft";
    level.scripted_widgets.inputs[ #"ui_navright" ] = "navright";
    level.scripted_widgets.inputs[ #"ui_prevtab" ] = "prevtab";
    level.scripted_widgets.inputs[ #"ui_nexttab" ] = "nexttab";
    level.scripted_widgets.inputs[ #"ui_backspace" ] = "backspace";
    level.scripted_widgets.var_ebb98e0b = [];
    
    foreach ( key, value in level.scripted_widgets.inputs )
    {
        level.scripted_widgets.var_ebb98e0b[ key ] = [];
        thread globallogic_ui::function_9ed5232e( "ScriptedWidgetData.blockGameInput." + value, 0 );
    }
    
    callback::add_callback( #"on_player_spawned", &on_player_spawn );
}

// Namespace scripted_widgets/scripted_widgets
// Params 0
// Checksum 0xf9726adf, Offset: 0x810
// Size: 0x150
function on_player_spawn()
{
    self endon( #"death" );
    
    foreach ( key, value in level.scripted_widgets.inputs )
    {
        self flag::clear( key );
    }
    
    while ( true )
    {
        waitresult = self waittill( #"menuresponse" );
        menu = waitresult.menu;
        
        if ( menu == "ScriptedHudWidgetMenu" )
        {
            self childthread flag::set_for_time( float( function_60d95f53() ) / 1000 * 2, waitresult.response );
        }
    }
}

// Namespace scripted_widgets/scripted_widgets
// Params 0
// Checksum 0x9c68083d, Offset: 0x968
// Size: 0x22
function function_affb1af1()
{
    return self flag::get( #"ui_confirm" );
}

// Namespace scripted_widgets/scripted_widgets
// Params 0
// Checksum 0x9f518c1e, Offset: 0x998
// Size: 0x22
function function_57fbd346()
{
    return self flag::get( #"ui_cancel" );
}

// Namespace scripted_widgets/scripted_widgets
// Params 0
// Checksum 0x5528feab, Offset: 0x9c8
// Size: 0x22
function function_e4d62f9a()
{
    return self flag::get( #"ui_alt1" );
}

// Namespace scripted_widgets/scripted_widgets
// Params 0
// Checksum 0xff8f4967, Offset: 0x9f8
// Size: 0x22
function function_728aec47()
{
    return self flag::get( #"ui_alt2" );
}

// Namespace scripted_widgets/scripted_widgets
// Params 0
// Checksum 0xb0aef25a, Offset: 0xa28
// Size: 0x22
function function_aef1e8c3()
{
    return self flag::get( #"ui_navup" );
}

// Namespace scripted_widgets/scripted_widgets
// Params 0
// Checksum 0x614ea93b, Offset: 0xa58
// Size: 0x22
function function_9975a94d()
{
    return self flag::get( #"ui_navdown" );
}

// Namespace scripted_widgets/scripted_widgets
// Params 0
// Checksum 0xb8f3acb5, Offset: 0xa88
// Size: 0x22
function function_c2d8a326()
{
    return self flag::get( #"ui_navleft" );
}

// Namespace scripted_widgets/scripted_widgets
// Params 0
// Checksum 0x523477d2, Offset: 0xab8
// Size: 0x22
function function_3d680c10()
{
    return self flag::get( #"ui_navright" );
}

// Namespace scripted_widgets/scripted_widgets
// Params 0
// Checksum 0x65551218, Offset: 0xae8
// Size: 0x22
function function_d0beaa6e()
{
    return self flag::get( #"ui_prevtab" );
}

// Namespace scripted_widgets/scripted_widgets
// Params 0
// Checksum 0x88c7f33, Offset: 0xb18
// Size: 0x22
function function_1e9035e9()
{
    return self flag::get( #"ui_nexttab" );
}

// Namespace scripted_widgets/scripted_widgets
// Params 0
// Checksum 0x1ba7f740, Offset: 0xb48
// Size: 0x22
function function_57799116()
{
    return self flag::get( #"ui_backspace" );
}

// Namespace scripted_widgets/scripted_widgets
// Params 11
// Checksum 0x3ab49055, Offset: 0xb78
// Size: 0x408
function create_waypoint( uid = "waypoint", ent, image, text, offset, tag, var_7bd05154 = 1, var_754bedbb = 1, clamp = 1, var_577a0c84 = 0, progress )
{
    uid = string( uid ) + ent getentitynumber();
    widget_type = #"hash_14992af6bd994ba2";
    
    if ( isdefined( progress ) )
    {
        widget_type = #"hash_266631c3a5d0ffdb";
    }
    
    create( uid, widget_type );
    clear_flags( uid );
    
    if ( isdefined( ent ) )
    {
        set_ent( uid, ent );
    }
    
    if ( isdefined( image ) )
    {
        function_309bf7c2( uid, image );
    }
    
    if ( isdefined( text ) )
    {
        set_text( uid, text );
        set_flags( uid, 1 );
    }
    
    if ( !isdefined( offset ) )
    {
        offset = ( 0, 0, 0 );
    }
    
    if ( isdefined( tag ) )
    {
        origin = ent.origin;
        
        if ( isentity( ent ) && is_true( var_754bedbb ) )
        {
            origin += rotatepoint( ent getboundsmidpoint(), ent.angles );
        }
        
        offset = offset + ent gettagorigin( tag ) - origin;
    }
    
    if ( offset[ 0 ] != 0 )
    {
        function_4d9fbc9d( uid, offset[ 0 ] );
    }
    
    if ( offset[ 1 ] != 0 )
    {
        function_52dbc715( uid, offset[ 1 ] );
    }
    
    if ( offset[ 2 ] != 0 )
    {
        function_60856268( uid, offset[ 2 ] );
    }
    
    if ( is_true( clamp ) )
    {
        function_4ef79fca( uid, clamp );
    }
    
    if ( is_true( var_577a0c84 ) )
    {
        function_eb16868b( uid, var_577a0c84 );
    }
    
    if ( isdefined( progress ) )
    {
        function_b1e6d7a8( uid, progress );
    }
    
    function_e648abd8( uid, var_754bedbb );
    function_9c3ced73( uid, var_7bd05154 );
    set_state( uid, 0 );
    ent function_89bba41b( uid, "offset", { #offset:offset } );
    ent thread function_9718880e( uid );
    return uid;
}

// Namespace scripted_widgets/scripted_widgets
// Params 2
// Checksum 0x724f61f4, Offset: 0xf88
// Size: 0xb4
function create( uid, widget_name )
{
    level.scripted_widgets.active[ uid ] = gettime();
    function_3efa2f37( uid, "widgetName", widget_name );
    function_3efa2f37( uid, "uid", uid );
    thread function_4e406a1a();
    
    if ( should_hide( uid ) )
    {
        function_3efa2f37( uid, "hide", 1 );
    }
}

// Namespace scripted_widgets/scripted_widgets
// Params 1
// Checksum 0x3273e1e7, Offset: 0x1048
// Size: 0xe4
function remove( uid )
{
    arrayremoveindex( level.scripted_widgets.active, uid, 1 );
    function_3abc637f( uid );
    level notify( "delete_widget_" + uid );
    function_3efa2f37( uid, "widgetName", #"" );
    thread function_4e406a1a();
    thread function_1b4bdb02( uid );
    globallogic_ui::function_2ec075a9( "ScriptedWidgetData.widgetModels" + "." + uid, 1 );
}

// Namespace scripted_widgets/scripted_widgets
// Params 0
// Checksum 0xdb7f9b34, Offset: 0x1138
// Size: 0x54
function remove_all()
{
    level.scripted_widgets.active = [];
    level.scripted_widgets.var_2361e57e = [];
    level notify( #"hash_64a3b02565bdf75f" );
    thread function_4e406a1a( 1 );
}

// Namespace scripted_widgets/scripted_widgets
// Params 1
// Checksum 0xd073be8d, Offset: 0x1198
// Size: 0x26, Type: bool
function exists( uid )
{
    return isdefined( level.scripted_widgets.active[ uid ] );
}

// Namespace scripted_widgets/scripted_widgets
// Params 3
// Checksum 0xa526c523, Offset: 0x11c8
// Size: 0x138
function function_24e5fa63( uid, inputs, block = 1 )
{
    if ( !isdefined( inputs ) )
    {
        inputs = [];
    }
    else if ( !isarray( inputs ) )
    {
        inputs = array( inputs );
    }
    
    foreach ( input in inputs )
    {
        if ( isdefined( level.scripted_widgets.var_ebb98e0b[ input ] ) )
        {
            if ( block )
            {
                function_78f03fef( uid, input );
                continue;
            }
            
            function_1b4bdb02( uid, input );
        }
    }
}

// Namespace scripted_widgets/scripted_widgets
// Params 2
// Checksum 0xb66d7847, Offset: 0x1308
// Size: 0x74
function function_e544f756( uid, block = 1 )
{
    if ( block )
    {
        function_78f03fef( uid, #"ui_confirm" );
        return;
    }
    
    function_1b4bdb02( uid, #"ui_confirm" );
}

// Namespace scripted_widgets/scripted_widgets
// Params 2
// Checksum 0xeca064c3, Offset: 0x1388
// Size: 0x74
function function_29703592( uid, block = 1 )
{
    if ( block )
    {
        function_78f03fef( uid, #"ui_cancel" );
        return;
    }
    
    function_1b4bdb02( uid, #"ui_cancel" );
}

// Namespace scripted_widgets/scripted_widgets
// Params 2
// Checksum 0x1947f285, Offset: 0x1408
// Size: 0x74
function function_61d5ed40( uid, block = 1 )
{
    if ( block )
    {
        function_78f03fef( uid, #"ui_alt1" );
        return;
    }
    
    function_1b4bdb02( uid, #"ui_alt1" );
}

// Namespace scripted_widgets/scripted_widgets
// Params 2
// Checksum 0xe8bee029, Offset: 0x1488
// Size: 0x74
function function_503549ff( uid, block = 1 )
{
    if ( block )
    {
        function_78f03fef( uid, #"ui_alt2" );
        return;
    }
    
    function_1b4bdb02( uid, #"ui_alt2" );
}

// Namespace scripted_widgets/scripted_widgets
// Params 2
// Checksum 0xab3296b4, Offset: 0x1508
// Size: 0x74
function function_a9d2152c( uid, block = 1 )
{
    if ( block )
    {
        function_78f03fef( uid, #"ui_navup" );
        return;
    }
    
    function_1b4bdb02( uid, #"ui_navup" );
}

// Namespace scripted_widgets/scripted_widgets
// Params 2
// Checksum 0x8e2dcd58, Offset: 0x1588
// Size: 0x74
function function_cd99f2ab( uid, block = 1 )
{
    if ( block )
    {
        function_78f03fef( uid, #"ui_navdown" );
        return;
    }
    
    function_1b4bdb02( uid, #"ui_navdown" );
}

// Namespace scripted_widgets/scripted_widgets
// Params 2
// Checksum 0x2762eeee, Offset: 0x1608
// Size: 0x74
function function_46abc17c( uid, block = 1 )
{
    if ( block )
    {
        function_78f03fef( uid, #"ui_navleft" );
        return;
    }
    
    function_1b4bdb02( uid, #"ui_navleft" );
}

// Namespace scripted_widgets/scripted_widgets
// Params 2
// Checksum 0x44b6b9f9, Offset: 0x1688
// Size: 0x74
function function_1eca647( uid, block = 1 )
{
    if ( block )
    {
        function_78f03fef( uid, #"ui_navright" );
        return;
    }
    
    function_1b4bdb02( uid, #"ui_navright" );
}

// Namespace scripted_widgets/scripted_widgets
// Params 2
// Checksum 0x98669664, Offset: 0x1708
// Size: 0x74
function function_37cc0f71( uid, block = 1 )
{
    if ( block )
    {
        function_78f03fef( uid, #"ui_prevtab" );
        return;
    }
    
    function_1b4bdb02( uid, #"ui_prevtab" );
}

// Namespace scripted_widgets/scripted_widgets
// Params 2
// Checksum 0x51db54c0, Offset: 0x1788
// Size: 0x74
function function_b2bd6ae9( uid, block = 1 )
{
    if ( block )
    {
        function_78f03fef( uid, #"ui_nexttab" );
        return;
    }
    
    function_1b4bdb02( uid, #"ui_nexttab" );
}

// Namespace scripted_widgets/scripted_widgets
// Params 2
// Checksum 0x9a60d315, Offset: 0x1808
// Size: 0x44
function set_x( uid, x )
{
    function_3efa2f37( uid, "x", float( x ) );
}

// Namespace scripted_widgets/scripted_widgets
// Params 2
// Checksum 0xddc69b4d, Offset: 0x1858
// Size: 0x44
function set_y( uid, y )
{
    function_3efa2f37( uid, "y", float( y ) );
}

// Namespace scripted_widgets/scripted_widgets
// Params 2
// Checksum 0x90b6b7ea, Offset: 0x18a8
// Size: 0x44
function set_width( uid, width )
{
    function_3efa2f37( uid, "width", float( width ) );
}

// Namespace scripted_widgets/scripted_widgets
// Params 2
// Checksum 0xf6a714c6, Offset: 0x18f8
// Size: 0x44
function set_height( uid, height )
{
    function_3efa2f37( uid, "height", float( height ) );
}

// Namespace scripted_widgets/scripted_widgets
// Params 2
// Checksum 0xbc97ca91, Offset: 0x1948
// Size: 0x34
function function_33b3b950( uid, var_b83b583 )
{
    function_3efa2f37( uid, "ui3dWindow", var_b83b583 );
}

// Namespace scripted_widgets/scripted_widgets
// Params 2
// Checksum 0xd1fe9c04, Offset: 0x1988
// Size: 0x44
function set_alpha( uid, alpha )
{
    function_3efa2f37( uid, "alpha", float( alpha ) );
}

// Namespace scripted_widgets/scripted_widgets
// Params 2
// Checksum 0x9ac6a128, Offset: 0x19d8
// Size: 0x148
function hide_widgets( var_a5a2c782, uids )
{
    if ( !isdefined( uids ) )
    {
        uids = [];
    }
    else if ( !isarray( uids ) )
    {
        uids = array( uids );
    }
    
    if ( !isdefined( level.scripted_widgets.hidden[ var_a5a2c782 ] ) )
    {
        level.scripted_widgets.hidden[ var_a5a2c782 ] = [];
    }
    
    foreach ( uid in uids )
    {
        level.scripted_widgets.hidden[ var_a5a2c782 ][ uid ] = uid;
        
        if ( exists( uid ) )
        {
            function_3efa2f37( uid, "hide", 1 );
        }
    }
}

// Namespace scripted_widgets/scripted_widgets
// Params 1
// Checksum 0xb5326b75, Offset: 0x1b28
// Size: 0x138
function function_f96376c5( var_a5a2c782 )
{
    if ( isdefined( level.scripted_widgets.hidden[ var_a5a2c782 ] ) )
    {
        uids = level.scripted_widgets.hidden[ var_a5a2c782 ];
        arrayremoveindex( level.scripted_widgets.hidden, var_a5a2c782, 1 );
        
        foreach ( uid in uids )
        {
            if ( exists( uid ) && !should_hide( uid ) )
            {
                function_3efa2f37( uid, "hide", 0 );
            }
        }
    }
}

// Namespace scripted_widgets/scripted_widgets
// Params 2
// Checksum 0x19190306, Offset: 0x1c68
// Size: 0x250
function function_28027c42( var_d4d3e35d, uids )
{
    if ( !isdefined( uids ) )
    {
        uids = [];
    }
    else if ( !isarray( uids ) )
    {
        uids = array( uids );
    }
    
    if ( !isdefined( level.scripted_widgets.var_db65bf2f[ var_d4d3e35d ] ) )
    {
        level.scripted_widgets.var_db65bf2f[ var_d4d3e35d ] = {};
    }
    
    if ( !isdefined( level.scripted_widgets.var_db65bf2f[ var_d4d3e35d ].uids ) )
    {
        level.scripted_widgets.var_db65bf2f[ var_d4d3e35d ].uids = [];
    }
    
    foreach ( uid in uids )
    {
        level.scripted_widgets.var_db65bf2f[ var_d4d3e35d ].uids[ uid ] = uid;
    }
    
    level.scripted_widgets.var_db65bf2f[ var_d4d3e35d ].active = 1;
    
    foreach ( uid, time in level.scripted_widgets.active )
    {
        if ( should_hide( uid ) )
        {
            function_3efa2f37( uid, "hide", 1 );
            continue;
        }
        
        function_3efa2f37( uid, "hide", 0 );
    }
}

// Namespace scripted_widgets/scripted_widgets
// Params 2
// Checksum 0x89d4459c, Offset: 0x1ec0
// Size: 0x20c
function function_d3c3e5c3( uid, var_8e8cbb71 )
{
    if ( !isdefined( var_8e8cbb71 ) )
    {
        var_8e8cbb71 = [];
    }
    else if ( !isarray( var_8e8cbb71 ) )
    {
        var_8e8cbb71 = array( var_8e8cbb71 );
    }
    
    any_active = 0;
    
    foreach ( var_d4d3e35d in var_8e8cbb71 )
    {
        if ( !isdefined( level.scripted_widgets.var_db65bf2f[ var_d4d3e35d ] ) )
        {
            level.scripted_widgets.var_db65bf2f[ var_d4d3e35d ] = {};
        }
        
        if ( !isdefined( level.scripted_widgets.var_db65bf2f[ var_d4d3e35d ].uids ) )
        {
            level.scripted_widgets.var_db65bf2f[ var_d4d3e35d ].uids = [];
        }
        
        level.scripted_widgets.var_db65bf2f[ var_d4d3e35d ].uids[ uid ] = uid;
        any_active = any_active || is_true( level.scripted_widgets.var_db65bf2f[ var_d4d3e35d ].active );
    }
    
    if ( any_active )
    {
        if ( should_hide( uid ) )
        {
            function_3efa2f37( uid, "hide", 1 );
            return;
        }
        
        function_3efa2f37( uid, "hide", 0 );
    }
}

// Namespace scripted_widgets/scripted_widgets
// Params 2
// Checksum 0x93fd3f8, Offset: 0x20d8
// Size: 0x264
function function_3abc637f( uid, var_d4d3e35d )
{
    if ( isdefined( var_d4d3e35d ) )
    {
        if ( isdefined( level.scripted_widgets.var_db65bf2f[ var_d4d3e35d ] ) )
        {
            arrayremoveindex( level.scripted_widgets.var_db65bf2f[ var_d4d3e35d ].uids, uid, 1 );
            
            if ( !is_true( level.scripted_widgets.var_db65bf2f[ var_d4d3e35d ].active ) && level.scripted_widgets.var_db65bf2f[ var_d4d3e35d ].uids.size == 0 )
            {
                arrayremoveindex( level.scripted_widgets.var_db65bf2f, var_d4d3e35d, 1 );
            }
        }
    }
    else
    {
        foreach ( ref, exceptions in level.scripted_widgets.var_db65bf2f )
        {
            arrayremoveindex( exceptions.uids, uid, 1 );
            
            if ( !is_true( exceptions.active ) && exceptions.uids.size == 0 )
            {
                arrayremoveindex( level.scripted_widgets.var_db65bf2f, ref, 1 );
            }
        }
    }
    
    if ( isdefined( level.scripted_widgets.active[ uid ] ) )
    {
        if ( should_hide( uid ) )
        {
            function_3efa2f37( uid, "hide", 1 );
            return;
        }
        
        function_3efa2f37( uid, "hide", 0 );
    }
}

// Namespace scripted_widgets/scripted_widgets
// Params 1
// Checksum 0xc93c714b, Offset: 0x2348
// Size: 0x118
function function_4279fd02( var_d4d3e35d )
{
    if ( isdefined( level.scripted_widgets.var_db65bf2f[ var_d4d3e35d ] ) )
    {
        level.scripted_widgets.var_db65bf2f[ var_d4d3e35d ].active = 0;
        
        foreach ( uid, time in level.scripted_widgets.active )
        {
            if ( should_hide( uid ) )
            {
                function_3efa2f37( uid, "hide", 1 );
                continue;
            }
            
            function_3efa2f37( uid, "hide", 0 );
        }
    }
}

// Namespace scripted_widgets/scripted_widgets
// Params 1
// Checksum 0x899f4492, Offset: 0x2468
// Size: 0x176
function should_hide( uid )
{
    foreach ( uids in level.scripted_widgets.hidden )
    {
        if ( isdefined( uids[ uid ] ) )
        {
            return 1;
        }
    }
    
    var_bbf85716 = 0;
    
    if ( level.scripted_widgets.var_db65bf2f.size > 0 )
    {
        foreach ( var_7db9f8e9 in level.scripted_widgets.var_db65bf2f )
        {
            if ( is_true( var_7db9f8e9.active ) )
            {
                var_bbf85716 = 1;
                
                if ( isdefined( var_7db9f8e9.uids[ uid ] ) )
                {
                    return 0;
                }
            }
        }
    }
    
    return var_bbf85716;
}

// Namespace scripted_widgets/scripted_widgets
// Params 2
// Checksum 0x150d02f1, Offset: 0x25e8
// Size: 0x34
function set_focus( uid, focus )
{
    function_3efa2f37( uid, "focus", focus );
}

// Namespace scripted_widgets/scripted_widgets
// Params 2
// Checksum 0x6a6ccd8a, Offset: 0x2628
// Size: 0x34
function function_46df0bc7( uid, priority )
{
    function_3efa2f37( uid, "priority", priority );
}

// Namespace scripted_widgets/scripted_widgets
// Params 2
// Checksum 0xbd004190, Offset: 0x2668
// Size: 0x44
function set_scale( uid, scale )
{
    function_3efa2f37( uid, "scale", float( scale ) );
}

// Namespace scripted_widgets/scripted_widgets
// Params 2
// Checksum 0x9b961fcd, Offset: 0x26b8
// Size: 0x34
function set_text( uid, text )
{
    function_3efa2f37( uid, "text", text );
}

// Namespace scripted_widgets/scripted_widgets
// Params 2
// Checksum 0xdddfd026, Offset: 0x26f8
// Size: 0x34
function function_e11447eb( uid, button_text )
{
    function_3efa2f37( uid, "button_text", button_text );
}

// Namespace scripted_widgets/scripted_widgets
// Params 2
// Checksum 0x1c84a5bc, Offset: 0x2738
// Size: 0x34
function function_309bf7c2( uid, image )
{
    function_3efa2f37( uid, "image", image );
}

// Namespace scripted_widgets/scripted_widgets
// Params 4
// Checksum 0x6840b75f, Offset: 0x2778
// Size: 0x64
function set_color( uid, red, green, blue )
{
    function_3efa2f37( uid, "color", red + " " + green + " " + blue );
}

// Namespace scripted_widgets/scripted_widgets
// Params 2
// Checksum 0x66c30cf3, Offset: 0x27e8
// Size: 0x44
function set_time( uid, time )
{
    function_3efa2f37( uid, "time", float( time ) );
}

// Namespace scripted_widgets/scripted_widgets
// Params 3
// Checksum 0x5fab85d4, Offset: 0x2838
// Size: 0x13c
function set_timer( uid, time, countdown = 1 )
{
    time = int( time * 1000 );
    
    if ( countdown )
    {
        function_89bba41b( uid, "timer", { #time:time, #goal_time:0 } );
    }
    else
    {
        start_time = 0;
        var_f2f8de51 = function_8db2364c( uid, "timer" );
        
        if ( isdefined( var_f2f8de51 ) )
        {
            start_time = var_f2f8de51.time;
        }
        
        function_89bba41b( uid, "timer", { #time:start_time, #goal_time:time } );
    }
    
    thread update_timer( uid );
}

// Namespace scripted_widgets/scripted_widgets
// Params 1
// Checksum 0xbcb6877f, Offset: 0x2980
// Size: 0x4a
function pause_timer( uid )
{
    var_f2f8de51 = function_8db2364c( uid, "timer" );
    
    if ( isdefined( var_f2f8de51 ) )
    {
        var_f2f8de51.paused = 1;
    }
}

// Namespace scripted_widgets/scripted_widgets
// Params 1
// Checksum 0x1c693784, Offset: 0x29d8
// Size: 0x4a
function function_f3dcb134( uid )
{
    var_f2f8de51 = function_8db2364c( uid, "timer" );
    
    if ( isdefined( var_f2f8de51 ) )
    {
        var_f2f8de51.paused = 0;
    }
}

// Namespace scripted_widgets/scripted_widgets
// Params 1
// Checksum 0x903ffc60, Offset: 0x2a30
// Size: 0x44
function clear_timer( uid )
{
    function_4ac40e40( uid, "timer" );
    clear_flags( uid, 3 );
}

// Namespace scripted_widgets/scripted_widgets
// Params 1, eflags: 0x4
// Checksum 0x3eccffe3, Offset: 0x2a80
// Size: 0x19c
function private update_timer( uid )
{
    level notify( "update_timer_" + uid );
    level endon( "update_timer_" + uid, "delete_widget_" + uid, "scripted_widget_data_removed_timer_" + uid, #"hash_64a3b02565bdf75f" );
    set_flags( uid, 3 );
    
    while ( true )
    {
        timer = function_8db2364c( uid, "timer" );
        set_time( uid, timer.time );
        
        if ( !is_true( timer.paused ) )
        {
            if ( timer.goal_time == 0 )
            {
                timer.time = int( max( timer.time - function_60d95f53(), timer.goal_time ) );
            }
            else
            {
                timer.time = int( min( timer.time + function_60d95f53(), timer.goal_time ) );
            }
        }
        
        waitframe( 1 );
    }
}

// Namespace scripted_widgets/scripted_widgets
// Params 2
// Checksum 0x7fbbfe09, Offset: 0x2c28
// Size: 0x34
function set_distance( uid, distance )
{
    function_3efa2f37( uid, "distance", distance );
}

// Namespace scripted_widgets/scripted_widgets
// Params 3
// Checksum 0x7d3b6ca3, Offset: 0x2c68
// Size: 0x84
function function_283c7712( uid, ent, var_7c7535b4 = 0.0254 )
{
    function_89bba41b( uid, "distance", { #ent:ent, #var_7c7535b4:var_7c7535b4 } );
    thread function_c6d1cf1f( uid );
}

// Namespace scripted_widgets/scripted_widgets
// Params 1
// Checksum 0x9bba1154, Offset: 0x2cf8
// Size: 0x44
function function_8a843e00( uid )
{
    function_4ac40e40( uid, "distance" );
    clear_flags( uid, 2 );
}

// Namespace scripted_widgets/scripted_widgets
// Params 1, eflags: 0x4
// Checksum 0x62e7edd, Offset: 0x2d48
// Size: 0x22e
function private function_c6d1cf1f( uid )
{
    level notify( "update_distance_" + uid );
    level endon( "update_distance_" + uid, "delete_widget_" + uid, "scripted_widget_data_removed_distance_" + uid, #"hash_64a3b02565bdf75f" );
    player = getplayers()[ 0 ];
    player endon( #"death" );
    set_flags( uid, 2 );
    offset = self function_8db2364c( uid, "offset" );
    
    if ( isdefined( offset ) )
    {
        offset = offset.offset;
    }
    
    while ( true )
    {
        var_9941a398 = function_8db2364c( uid, "distance" );
        ent = var_9941a398.ent;
        var_7f3f225e = player getplayercamerapos();
        ent_pos = ent.origin;
        
        if ( isentity( ent ) )
        {
            ent_pos += rotatepoint( ent getboundsmidpoint(), ent.angles );
        }
        
        if ( isdefined( offset ) )
        {
            ent_pos += rotatepoint( offset, ent.angles );
        }
        
        dist = distance( var_7f3f225e, ent_pos ) * var_9941a398.var_7c7535b4;
        set_distance( uid, dist );
        waitframe( 1 );
    }
}

// Namespace scripted_widgets/scripted_widgets
// Params 3
// Checksum 0xdffd6b3, Offset: 0x2f80
// Size: 0x4c
function set_count( uid, count, var_80d5359e = 0 )
{
    function_3efa2f37( uid, "count", count, var_80d5359e );
}

// Namespace scripted_widgets/scripted_widgets
// Params 3
// Checksum 0xafa0b37a, Offset: 0x2fd8
// Size: 0x5c
function function_b1e6d7a8( uid, fraction, var_80d5359e = 0 )
{
    function_3efa2f37( uid, "fraction", float( fraction ), var_80d5359e );
}

// Namespace scripted_widgets/scripted_widgets
// Params 2
// Checksum 0x9c979145, Offset: 0x3040
// Size: 0x34
function set_state( uid, state )
{
    function_3efa2f37( uid, "state", state );
}

// Namespace scripted_widgets/scripted_widgets
// Params 2
// Checksum 0xf52943ee, Offset: 0x3080
// Size: 0x34
function function_f942c3ed( uid, clip )
{
    function_3efa2f37( uid, "clip", clip );
}

// Namespace scripted_widgets/scripted_widgets
// Params 3
// Checksum 0xad8b63ae, Offset: 0x30c0
// Size: 0x8c
function set_flags( uid, flags, var_10e09b46 = 0 )
{
    var_b89f8baa = function_82e355ff( uid, "flags" );
    var_c2e076fc = function_bfbe6ac6( flags, var_b89f8baa, var_10e09b46 );
    function_3efa2f37( uid, "flags", var_c2e076fc );
}

// Namespace scripted_widgets/scripted_widgets
// Params 3
// Checksum 0x4e1e1a94, Offset: 0x3158
// Size: 0xb4
function clear_flags( uid, flags, var_10e09b46 = 0 )
{
    var_b89f8baa = isdefined( function_82e355ff( uid, "flags" ) ) ? function_82e355ff( uid, "flags" ) : 0;
    var_c2e076fc = function_1a20b94a( flags, var_b89f8baa, var_10e09b46 );
    function_3efa2f37( uid, "flags", var_c2e076fc );
}

// Namespace scripted_widgets/scripted_widgets
// Params 7
// Checksum 0x384852cb, Offset: 0x3218
// Size: 0x74
function set_data( uid, name, value, var_80d5359e, var_1f7d0ca0, var_7b030046, var_2226bd51 )
{
    function_3efa2f37( uid, "data" + "." + name, value, var_80d5359e, var_1f7d0ca0, var_7b030046, var_2226bd51 );
}

// Namespace scripted_widgets/scripted_widgets
// Params 2
// Checksum 0xea05184c, Offset: 0x3298
// Size: 0x44
function get_data( uid, name )
{
    function_80157d8( uid, "data" + "." + name );
}

// Namespace scripted_widgets/scripted_widgets
// Params 3
// Checksum 0xc79a5472, Offset: 0x32e8
// Size: 0x64
function clear_data( uid, name, var_c15ae58d )
{
    globallogic_ui::function_2ec075a9( "ScriptedWidgetData.widgetModels" + "." + uid + "." + "data" + "." + name, var_c15ae58d );
}

// Namespace scripted_widgets/scripted_widgets
// Params 7
// Checksum 0x491fd967, Offset: 0x3358
// Size: 0x5c
function function_9ade1d9b( uid, name, value, var_80d5359e, var_1f7d0ca0, var_7b030046, var_2226bd51 )
{
    function_3efa2f37( uid, name, value, var_80d5359e, var_1f7d0ca0, var_7b030046, var_2226bd51 );
}

// Namespace scripted_widgets/scripted_widgets
// Params 2
// Checksum 0x7fb71898, Offset: 0x33c0
// Size: 0x2a
function function_f7c4c669( uid, name )
{
    return function_80157d8( uid, name );
}

// Namespace scripted_widgets/scripted_widgets
// Params 3
// Checksum 0x7166a2f3, Offset: 0x33f8
// Size: 0x54
function function_43525bc6( uid, name, var_c15ae58d )
{
    globallogic_ui::function_2ec075a9( "ScriptedWidgetData.widgetModels" + "." + uid + "." + name, var_c15ae58d );
}

// Namespace scripted_widgets/scripted_widgets
// Params 2
// Checksum 0x331e9dcb, Offset: 0x3458
// Size: 0x54
function function_330981ed( uid, list_name = "list" )
{
    function_3efa2f37( uid, list_name );
    thread function_57d676db( uid, list_name );
}

// Namespace scripted_widgets/scripted_widgets
// Params 6
// Checksum 0xe0a440b9, Offset: 0x34b8
// Size: 0x114
function function_f2a9266( uid, index, name, value, list_name = "list", force )
{
    if ( !isdefined( function_80157d8( uid, list_name + "." + index ) ) )
    {
        function_3efa2f37( uid, list_name + "." + index + "." + "listIndex", index, undefined, undefined, undefined, undefined, list_name );
    }
    
    function_3efa2f37( uid, list_name + "." + index + "." + name, value, force, undefined, undefined, undefined, list_name );
    thread function_57d676db( uid, list_name );
}

// Namespace scripted_widgets/scripted_widgets
// Params 4
// Checksum 0x3e97bd11, Offset: 0x35d8
// Size: 0x6a
function function_ce8141d4( uid, index, name, list_name = "list" )
{
    return function_82e355ff( uid, list_name + "." + index + "." + name );
}

// Namespace scripted_widgets/scripted_widgets
// Params 6
// Checksum 0xbbc5dccc, Offset: 0x3650
// Size: 0x19c
function function_9bc1d2f1( uid, index, flags, var_10e09b46 = 0, model_name = "flags", list_name = "list" )
{
    if ( !isdefined( function_80157d8( uid, list_name + "." + index ) ) )
    {
        function_3efa2f37( uid, list_name + "." + index + "." + "listIndex", index, undefined, undefined, undefined, undefined, list_name );
    }
    
    var_b89f8baa = function_82e355ff( uid, list_name + "." + index + "." + model_name );
    var_c2e076fc = function_bfbe6ac6( flags, var_b89f8baa, var_10e09b46 );
    function_3efa2f37( uid, list_name + "." + index + "." + model_name, var_c2e076fc, undefined, undefined, undefined, undefined, list_name );
    thread function_57d676db( uid, list_name );
}

// Namespace scripted_widgets/scripted_widgets
// Params 6
// Checksum 0x772bf8a2, Offset: 0x37f8
// Size: 0x19c
function function_e8c19a33( uid, index, flags, var_10e09b46 = 0, model_name = "flags", list_name = "list" )
{
    if ( !isdefined( function_80157d8( uid, list_name + "." + index ) ) )
    {
        function_3efa2f37( uid, list_name + "." + index + "." + "listIndex", index, undefined, undefined, undefined, undefined, list_name );
    }
    
    var_b89f8baa = function_82e355ff( uid, list_name + "." + index + "." + model_name );
    var_c2e076fc = function_1a20b94a( flags, var_b89f8baa, var_10e09b46 );
    function_3efa2f37( uid, list_name + "." + index + "." + model_name, var_c2e076fc, undefined, undefined, undefined, undefined, list_name );
    thread function_57d676db( uid, list_name );
}

// Namespace scripted_widgets/scripted_widgets
// Params 3
// Checksum 0x517504d5, Offset: 0x39a0
// Size: 0x84
function function_7239e030( uid, index, list_name = "list" )
{
    if ( globallogic_ui::function_6db5e620( "ScriptedWidgetData.widgetModels" + "." + uid + "." + list_name, index ) )
    {
        thread function_57d676db( uid, list_name );
    }
}

// Namespace scripted_widgets/scripted_widgets
// Params 3
// Checksum 0x2ed09657, Offset: 0x3a30
// Size: 0x54, Type: bool
function function_cd59371c( uid, index, list_name = "list" )
{
    return isdefined( function_80157d8( uid, list_name + "." + index ) );
}

// Namespace scripted_widgets/scripted_widgets
// Params 2
// Checksum 0xa4540a7d, Offset: 0x3a90
// Size: 0x154
function set_ent( uid, ent )
{
    if ( isstruct( ent ) || ent.classname === "script_origin" )
    {
        function_3efa2f37( uid, "entNum", worldentnumber() );
        
        if ( isdefined( self.origin ) )
        {
            function_4d9fbc9d( uid, ent.origin[ 0 ] );
            function_52dbc715( uid, ent.origin[ 1 ] );
            function_60856268( uid, ent.origin[ 2 ] );
            function_9c3ced73( uid, 1 );
        }
        
        return;
    }
    
    function_3efa2f37( uid, "entNum", ent getentitynumber() );
    ent thread delete_on_death( uid );
}

// Namespace scripted_widgets/scripted_widgets
// Params 2
// Checksum 0xc40eae16, Offset: 0x3bf0
// Size: 0x34
function function_4d9fbc9d( uid, x_offset )
{
    function_3efa2f37( uid, "xOffset", x_offset );
}

// Namespace scripted_widgets/scripted_widgets
// Params 2
// Checksum 0xf5f5be78, Offset: 0x3c30
// Size: 0x34
function function_52dbc715( uid, y_offset )
{
    function_3efa2f37( uid, "yOffset", y_offset );
}

// Namespace scripted_widgets/scripted_widgets
// Params 2
// Checksum 0xcb7e4171, Offset: 0x3c70
// Size: 0x34
function function_60856268( uid, z_offset )
{
    function_3efa2f37( uid, "zOffset", z_offset );
}

// Namespace scripted_widgets/scripted_widgets
// Params 2
// Checksum 0x20710adf, Offset: 0x3cb0
// Size: 0x34
function function_4ef79fca( uid, clamp )
{
    function_3efa2f37( uid, "clamp", clamp );
}

// Namespace scripted_widgets/scripted_widgets
// Params 2
// Checksum 0x3a8134cb, Offset: 0x3cf0
// Size: 0x34
function function_eb16868b( uid, var_9524359a )
{
    function_3efa2f37( uid, "distanceScale", var_9524359a );
}

// Namespace scripted_widgets/scripted_widgets
// Params 2
// Checksum 0x8c6a1f15, Offset: 0x3d30
// Size: 0x34
function function_e648abd8( uid, var_754bedbb )
{
    function_3efa2f37( uid, "useMidpoint", var_754bedbb );
}

// Namespace scripted_widgets/scripted_widgets
// Params 2
// Checksum 0xfc1c52f6, Offset: 0x3d70
// Size: 0x34
function function_9c3ced73( uid, var_7bd05154 )
{
    function_3efa2f37( uid, "useLocalOffset", var_7bd05154 );
}

// Namespace scripted_widgets/scripted_widgets
// Params 5
// Checksum 0x9de8002e, Offset: 0x3db0
// Size: 0xd4
function function_fdb73881( uid, close_dist = 500, far_dist = 1000, var_bc8ff11 = 1, var_6d219ab3 = 0 )
{
    function_89bba41b( uid, "fade_dist", { #close_dist:close_dist, #far_dist:far_dist, #var_bc8ff11:var_bc8ff11, #var_6d219ab3:var_6d219ab3 } );
}

// Namespace scripted_widgets/scripted_widgets
// Params 6
// Checksum 0xb9ff2fa9, Offset: 0x3e90
// Size: 0xe4
function function_c3fbdd4( uid, far_dist = 393.7, var_3a142f52 = 0, var_d7e44381 = 1, var_e23f7d1e = 2, var_1f1b932b )
{
    function_89bba41b( uid, "dist_states", { #far_dist:far_dist, #var_3a142f52:var_3a142f52, #var_d7e44381:var_d7e44381, #var_e23f7d1e:var_e23f7d1e, #var_1f1b932b:var_1f1b932b } );
}

// Namespace scripted_widgets/scripted_widgets
// Params 3
// Checksum 0xef39ad1d, Offset: 0x3f80
// Size: 0x8c
function function_d3533603( uid, enable, ignore_ent )
{
    if ( enable )
    {
        function_89bba41b( uid, "occlusion", { #ignore_ent:ignore_ent } );
        return;
    }
    
    function_4ac40e40( uid, "occlusion" );
    clear_flags( uid, 0 );
}

// Namespace scripted_widgets/scripted_widgets
// Params 1, eflags: 0x4
// Checksum 0x4b431017, Offset: 0x4018
// Size: 0x48e
function private function_9718880e( uid )
{
    level endon( "delete_widget_" + uid, #"hash_64a3b02565bdf75f" );
    level waittill( "scripted_widget_data_set_" + uid );
    player = getplayers()[ 0 ];
    offset = function_8db2364c( uid, "offset" ).offset;
    
    while ( isdefined( player ) )
    {
        dist = undefined;
        alpha = undefined;
        fade_dist = function_8db2364c( uid, "fade_dist" );
        occlusion = function_8db2364c( uid, "occlusion" );
        dist_states = function_8db2364c( uid, "dist_states" );
        var_7f3f225e = player getplayercamerapos();
        ent_pos = self.origin;
        
        if ( isentity( self ) )
        {
            ent_pos += rotatepoint( self getboundsmidpoint(), self.angles );
        }
        
        if ( offset != ( 0, 0, 0 ) )
        {
            ent_pos += rotatepoint( offset, self.angles );
        }
        
        if ( isdefined( fade_dist ) )
        {
            if ( !isdefined( dist ) )
            {
                dist = distance( var_7f3f225e, ent_pos );
            }
            
            alpha = lerpfloat( fade_dist.var_bc8ff11, fade_dist.var_6d219ab3, lerpfloat( 0, 1, ( dist - fade_dist.close_dist ) / ( fade_dist.far_dist - fade_dist.close_dist ) ) );
        }
        
        if ( isdefined( dist_states ) )
        {
            if ( !isdefined( dist ) )
            {
                dist = distance( var_7f3f225e, ent_pos );
            }
            
            if ( dist > dist_states.far_dist )
            {
                set_state( uid, dist_states.var_3a142f52 );
            }
            else if ( !is_true( function_82e355ff( uid, "clamped" ) ) )
            {
                focused = 0;
                
                if ( isdefined( dist_states.var_1f1b932b ) )
                {
                    player_dir = anglestoforward( player getplayerangles() );
                    var_52be356a = vectornormalize( ent_pos - var_7f3f225e );
                    
                    if ( vectordot( player_dir, var_52be356a ) >= dist_states.var_1f1b932b )
                    {
                        set_state( uid, dist_states.var_e23f7d1e );
                        focused = 1;
                    }
                }
                
                if ( !focused )
                {
                    set_state( uid, dist_states.var_d7e44381 );
                }
            }
        }
        
        if ( isdefined( occlusion ) && ( !isdefined( alpha ) || alpha > 0 ) )
        {
            if ( !sighttracepassed( ent_pos, var_7f3f225e, 0, self, occlusion.ignore_ent ) )
            {
                set_flags( uid, 0 );
            }
            else
            {
                clear_flags( uid, 0 );
            }
        }
        else if ( isdefined( alpha ) )
        {
            set_alpha( uid, alpha );
        }
        
        waitframe( 1 );
    }
}

// Namespace scripted_widgets/scripted_widgets
// Params 3, eflags: 0x4
// Checksum 0xa72df543, Offset: 0x44b0
// Size: 0xa4
function private function_89bba41b( uid, key, data )
{
    if ( !isdefined( level.var_2e036148 ) )
    {
        level.var_2e036148 = [];
    }
    
    if ( !isdefined( level.var_2e036148[ uid ] ) )
    {
        level.var_2e036148[ uid ] = [];
    }
    
    level.var_2e036148[ uid ][ key ] = data;
    level notify( "scripted_widget_data_set_" + uid );
    level thread function_dc5c6710( uid );
}

// Namespace scripted_widgets/scripted_widgets
// Params 2, eflags: 0x4
// Checksum 0x6b7ec50d, Offset: 0x4560
// Size: 0x6e
function private function_8db2364c( uid, var_14d09bc7 )
{
    assert( isdefined( level.var_2e036148 ) && isdefined( level.var_2e036148[ uid ] ), "<dev string:x38>" + uid );
    return level.var_2e036148[ uid ][ var_14d09bc7 ];
}

// Namespace scripted_widgets/scripted_widgets
// Params 2, eflags: 0x4
// Checksum 0x95bc2811, Offset: 0x45d8
// Size: 0x92
function private function_4ac40e40( uid, var_14d09bc7 )
{
    assert( isdefined( level.var_2e036148 ) && isdefined( level.var_2e036148[ uid ] ), "<dev string:x79>" + uid );
    level notify( "scripted_widget_data_removed_" + var_14d09bc7 + "_" + uid );
    level.var_2e036148[ uid ][ var_14d09bc7 ] = undefined;
}

// Namespace scripted_widgets/scripted_widgets
// Params 8, eflags: 0x4
// Checksum 0xb1fb240b, Offset: 0x4678
// Size: 0x1c4
function private function_3efa2f37( uid, model, value, var_80d5359e, var_1f7d0ca0, var_7b030046, var_2226bd51, list_name )
{
    if ( model != "widgetName" )
    {
        if ( !exists( uid ) )
        {
            if ( !level flag::get( "restoring_ui_models" ) )
            {
                assertmsg( "<dev string:xbd>" + model + "<dev string:xe9>" + uid + "<dev string:xf2>" );
            }
            
            return;
        }
    }
    
    if ( isdefined( level.scripted_widgets.active[ uid ] ) && gettime() > level.scripted_widgets.active[ uid ] && !isdefined( function_80157d8( uid, model ) ) && ( !isdefined( list_name ) || !isdefined( function_80157d8( uid, list_name + "Update" ) ) ) )
    {
        thread function_2b815b7( uid );
    }
    
    globallogic_ui::function_9ed5232e( "ScriptedWidgetData.widgetModels" + "." + uid + "." + model, value, undefined, var_80d5359e, var_1f7d0ca0, var_7b030046, var_2226bd51 );
}

// Namespace scripted_widgets/scripted_widgets
// Params 2
// Checksum 0xd5cfd0bf, Offset: 0x4848
// Size: 0x4a
function function_82e355ff( uid, model )
{
    return globallogic_ui::function_f053dcd4( "ScriptedWidgetData.widgetModels" + "." + uid + "." + model );
}

// Namespace scripted_widgets/scripted_widgets
// Params 2, eflags: 0x4
// Checksum 0x419dad78, Offset: 0x48a0
// Size: 0x4a
function private function_80157d8( uid, model )
{
    return globallogic_ui::function_5b3d23d5( "ScriptedWidgetData.widgetModels" + "." + uid + "." + model );
}

// Namespace scripted_widgets/scripted_widgets
// Params 1, eflags: 0x4
// Checksum 0x45fab222, Offset: 0x48f8
// Size: 0x6c
function private function_4e406a1a( reset = 0 )
{
    while ( !isdefined( globallogic_ui::function_5b3d23d5( "ScriptedWidgetData.update", 0 ) ) )
    {
        waitframe( 1 );
    }
    
    globallogic_ui::function_9ed5232e( "ScriptedWidgetData.update", !reset, 0, 1, undefined, undefined, 1 );
}

// Namespace scripted_widgets/scripted_widgets
// Params 1, eflags: 0x4
// Checksum 0xfad5dd5e, Offset: 0x4970
// Size: 0x84
function private function_2b815b7( uid )
{
    level notify( "update_widget_subscriptions_" + uid );
    level endon( "update_widget_subscriptions_" + uid );
    globallogic_ui::function_9ed5232e( "ScriptedWidgetData.widgetModels" + "." + uid + "." + "update_subscriptions", 1, undefined, 1, 0, 0, 1 );
}

// Namespace scripted_widgets/scripted_widgets
// Params 2, eflags: 0x4
// Checksum 0x71396ff6, Offset: 0x4a00
// Size: 0x84
function private function_57d676db( uid, list_name )
{
    if ( exists( uid ) )
    {
        globallogic_ui::function_9ed5232e( "ScriptedWidgetData.widgetModels" + "." + uid + "." + list_name + "Update", 1, 0, 1, undefined, undefined, 1 );
    }
}

// Namespace scripted_widgets/scripted_widgets
// Params 1, eflags: 0x4
// Checksum 0xd5e5fc0, Offset: 0x4a90
// Size: 0x78
function private function_dc5c6710( uid )
{
    self notify( "cleanup_widget_data_" + uid );
    self endon( "cleanup_widget_data_" + uid );
    level waittill( "delete_widget_" + uid, #"hash_64a3b02565bdf75f" );
    
    if ( isdefined( self.var_2e036148 ) )
    {
        self.var_2e036148[ uid ] = undefined;
    }
}

// Namespace scripted_widgets/scripted_widgets
// Params 1
// Checksum 0x47f0fc1, Offset: 0x4b10
// Size: 0x7c
function delete_on_death( uid )
{
    self notify( "delete_on_death_" + uid );
    self endon( "delete_on_death_" + uid );
    level endon( "delete_widget_" + uid, #"hash_64a3b02565bdf75f" );
    self waittill( #"death" );
    thread remove( uid );
}

// Namespace scripted_widgets/scripted_widgets
// Params 3, eflags: 0x4
// Checksum 0x8ea1c05e, Offset: 0x4b98
// Size: 0x122
function private function_bfbe6ac6( flags, var_b89f8baa, var_10e09b46 = 0 )
{
    var_c2e076fc = flags;
    
    if ( !var_10e09b46 )
    {
        if ( !isdefined( flags ) )
        {
            flags = [];
        }
        else if ( !isarray( flags ) )
        {
            flags = array( flags );
        }
        
        var_c2e076fc = 0;
        
        foreach ( flag in flags )
        {
            var_c2e076fc |= 1 << flag;
        }
    }
    
    if ( isdefined( var_b89f8baa ) )
    {
        var_c2e076fc |= var_b89f8baa;
    }
    
    return var_c2e076fc;
}

// Namespace scripted_widgets/scripted_widgets
// Params 3, eflags: 0x4
// Checksum 0xd5e6c855, Offset: 0x4cc8
// Size: 0x124
function private function_1a20b94a( flags, var_b89f8baa = 0, var_10e09b46 = 0 )
{
    var_c2e076fc = var_b89f8baa;
    
    if ( !var_10e09b46 )
    {
        if ( !isdefined( flags ) )
        {
            flags = [];
        }
        else if ( !isarray( flags ) )
        {
            flags = array( flags );
        }
        
        foreach ( flag in flags )
        {
            var_c2e076fc &= ~( 1 << flag );
        }
    }
    else
    {
        var_c2e076fc &= ~flags;
    }
    
    return var_c2e076fc;
}

// Namespace scripted_widgets/scripted_widgets
// Params 9
// Checksum 0x8e6a119a, Offset: 0x4df8
// Size: 0x456
function function_e13a1a9c( grid_size, var_39359c1e, var_92c0faf8, cancel_callback, var_942056ea, var_daf05886, var_bd8024b5, var_26759105, var_1da0c034 )
{
    player = self;
    assert( isplayer( player ) );
    assert( isarray( grid_size ) && grid_size.size == 2 );
    assert( !isdefined( var_1da0c034 ) || isarray( var_1da0c034 ) && var_1da0c034.size == 2 );
    
    if ( isdefined( var_daf05886 ) )
    {
        level endon( var_daf05886 );
    }
    
    if ( isdefined( var_bd8024b5 ) )
    {
        player endon( var_bd8024b5 );
    }
    
    var_bc6e33ce = [ 0, 0 ];
    var_dd82beda = [ 0, 0 ];
    var_768a0348 = [ -1, -1 ];
    new_indices = isdefined( var_1da0c034 ) ? var_1da0c034 : [ 0, 0 ];
    player function_2947fddf( var_768a0348, new_indices, grid_size, var_39359c1e, var_942056ea );
    
    while ( true )
    {
        if ( isdefined( var_92c0faf8 ) && self function_affb1af1() )
        {
            var_75843d9b = player [[ var_92c0faf8 ]]( var_768a0348, var_942056ea );
            
            if ( is_true( var_75843d9b ) )
            {
                break;
            }
        }
        
        if ( isdefined( cancel_callback ) && self function_57fbd346() )
        {
            player [[ cancel_callback ]]( var_942056ea );
            break;
        }
        
        var_e73a18ff = player getnormalizedmovement();
        
        for ( var_ea37ba57 = 0; var_ea37ba57 < 2 ; var_ea37ba57++ )
        {
            new_indices[ var_ea37ba57 ] = var_768a0348[ var_ea37ba57 ];
            var_edeb0521 = util::function_b5338ccb( var_e73a18ff[ var_ea37ba57 ], 0.2 );
            
            if ( var_ea37ba57 == 0 )
            {
                var_edeb0521 *= -1;
            }
            
            var_8d765541 = 0;
            
            if ( var_edeb0521 == 0 )
            {
                var_8d765541 = function_ec6ae51a( var_ea37ba57 );
            }
            else if ( var_edeb0521 > 0 )
            {
                var_8d765541 = 1;
            }
            else
            {
                var_8d765541 = -1;
            }
            
            if ( var_8d765541 == 0 )
            {
                var_dd82beda[ var_ea37ba57 ] = 0;
                continue;
            }
            
            var_691ec9a7 = var_dd82beda[ var_ea37ba57 ] != var_8d765541;
            var_3e9543e8 = !var_691ec9a7 && gettime() - var_bc6e33ce[ var_ea37ba57 ] > 250;
            
            if ( var_691ec9a7 || var_3e9543e8 )
            {
                var_bc6e33ce[ var_ea37ba57 ] = gettime();
                var_dd82beda[ var_ea37ba57 ] = var_8d765541;
                new_indices[ var_ea37ba57 ] = var_768a0348[ var_ea37ba57 ] + var_8d765541;
                new_indices[ var_ea37ba57 ] = function_d43d9448( new_indices[ var_ea37ba57 ], grid_size[ var_ea37ba57 ], var_26759105 );
            }
        }
        
        player function_2947fddf( var_768a0348, new_indices, grid_size, var_39359c1e, var_942056ea, var_26759105 );
        waitframe( 1 );
    }
}

// Namespace scripted_widgets/scripted_widgets
// Params 3, eflags: 0x4
// Checksum 0xa92779ac, Offset: 0x5258
// Size: 0xa6
function private function_d43d9448( index, list_size, var_26759105 )
{
    min = 0;
    max = list_size - 1;
    
    if ( is_true( var_26759105 ) )
    {
        if ( index < min )
        {
            index = max;
        }
        else if ( index > max )
        {
            index = min;
        }
    }
    else if ( index < min )
    {
        index = min;
    }
    else if ( index > max )
    {
        index = max;
    }
    
    return index;
}

// Namespace scripted_widgets/scripted_widgets
// Params 6, eflags: 0x4
// Checksum 0xe63bb94e, Offset: 0x5308
// Size: 0xec
function private function_2947fddf( &var_768a0348, new_indices, grid_size, callback, var_942056ea, var_26759105 )
{
    player = self;
    
    if ( new_indices[ 0 ] != var_768a0348[ 0 ] || new_indices[ 1 ] != var_768a0348[ 1 ] )
    {
        var_14639e4f = player [[ callback ]]( var_768a0348, new_indices, var_942056ea );
        
        for ( var_ea37ba57 = 0; var_ea37ba57 < 2 ; var_ea37ba57++ )
        {
            var_768a0348[ var_ea37ba57 ] = new_indices[ var_ea37ba57 ];
            
            if ( isdefined( var_14639e4f ) )
            {
                var_768a0348[ var_ea37ba57 ] = function_d43d9448( var_14639e4f[ var_ea37ba57 ], grid_size[ var_ea37ba57 ], var_26759105 );
            }
        }
    }
}

// Namespace scripted_widgets/scripted_widgets
// Params 1, eflags: 0x4
// Checksum 0x1b3e2b5c, Offset: 0x5400
// Size: 0x124
function private function_ec6ae51a( var_ea37ba57 )
{
    player = self;
    var_8d765541 = 0;
    
    if ( var_ea37ba57 == 0 )
    {
        if ( function_aef1e8c3() || player forwardbuttonpressed() )
        {
            var_8d765541 = -1;
        }
        else if ( function_9975a94d() || player backbuttonpressed() )
        {
            var_8d765541 = 1;
        }
    }
    else if ( var_ea37ba57 == 1 )
    {
        if ( function_3d680c10() || player rightbuttonpressed() )
        {
            var_8d765541 = 1;
        }
        else if ( function_c2d8a326() || player leftbuttonpressed() )
        {
            var_8d765541 = -1;
        }
    }
    
    return var_8d765541;
}

// Namespace scripted_widgets/scripted_widgets
// Params 2, eflags: 0x4
// Checksum 0xb6690bda, Offset: 0x5530
// Size: 0x94
function private function_78f03fef( uid, input )
{
    var_2361e57e = level.scripted_widgets.var_ebb98e0b[ input ];
    
    if ( !isinarray( var_2361e57e, uid ) )
    {
        var_2361e57e[ var_2361e57e.size ] = uid;
        globallogic_ui::function_9ed5232e( "ScriptedWidgetData.blockGameInput." + level.scripted_widgets.inputs[ input ], 1 );
    }
}

// Namespace scripted_widgets/scripted_widgets
// Params 2, eflags: 0x4
// Checksum 0x2a9e9ac0, Offset: 0x55d0
// Size: 0x190
function private function_1b4bdb02( uid, inputs )
{
    if ( isdefined( inputs ) )
    {
        if ( !isdefined( inputs ) )
        {
            inputs = [];
        }
        else if ( !isarray( inputs ) )
        {
            inputs = array( inputs );
        }
    }
    else
    {
        inputs = getarraykeys( level.scripted_widgets.inputs );
    }
    
    var_ebb98e0b = level.scripted_widgets.var_ebb98e0b;
    
    foreach ( input in inputs )
    {
        var_ef0e4b33 = var_ebb98e0b[ input ].size;
        arrayremovevalue( var_ebb98e0b[ input ], uid, 1 );
        
        if ( var_ef0e4b33 && var_ebb98e0b[ input ].size == 0 )
        {
            globallogic_ui::function_9ed5232e( "ScriptedWidgetData.blockGameInput." + level.scripted_widgets.inputs[ input ], 0 );
        }
    }
}

