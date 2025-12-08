#using script_35ae72be7b4fec10;
#using script_4937c6974f43bb71;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace cctv;

// Namespace cctv/cctv
// Params 0, eflags: 0x6
// Checksum 0xe305706f, Offset: 0x180
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"cctv", &_preload, undefined, undefined, undefined );
}

// Namespace cctv/cctv
// Params 0, eflags: 0x4
// Checksum 0xe342774b, Offset: 0x1c8
// Size: 0x14
function private _preload()
{
    function_bc948200();
}

// Namespace cctv/cctv
// Params 0, eflags: 0x4
// Checksum 0x7f72b243, Offset: 0x1e8
// Size: 0x94
function private function_bc948200()
{
    clientfield::register( "toplayer", "cctv_postfx", 1, 1, "int" );
    clientfield::register( "toplayer", "cull_outside_nuke_room", 1, 1, "int" );
    clientfield::register( "toplayer", "preload_nukeroom_tarp_material", 1, 1, "int" );
}

// Namespace cctv/cctv
// Params 5
// Checksum 0x8043f79f, Offset: 0x288
// Size: 0x25c
function function_c238a64a( var_d7eb0053, var_cfa5cedf, var_de721607, var_1aebd615, var_dd3b452 )
{
    level.player clientfield::set_to_player( "preload_nukeroom_tarp_material", 1 );
    level.player = isdefined( level.player ) ? level.player : getplayers()[ 0 ];
    
    if ( !scripted_widgets::exists( #"hash_48087cf592ac15d8" ) )
    {
        scripted_widgets::create( #"hash_48087cf592ac15d8", #"cctv" );
    }
    
    namespace_82bfe441::fade( 1, "FadeImmediate" );
    
    if ( !isdefined( var_d7eb0053 ) )
    {
        var_d7eb0053 = #"";
    }
    
    if ( !isdefined( var_cfa5cedf ) )
    {
        var_cfa5cedf = #"";
    }
    
    if ( !isdefined( var_de721607 ) )
    {
        var_de721607 = #"";
    }
    
    if ( !isdefined( var_1aebd615 ) )
    {
        var_1aebd615 = 0;
    }
    
    if ( !isdefined( var_dd3b452 ) )
    {
        var_dd3b452 = 1;
    }
    
    scripted_widgets::function_9ade1d9b( #"hash_48087cf592ac15d8", "camera_name", var_d7eb0053 );
    scripted_widgets::function_9ade1d9b( #"hash_48087cf592ac15d8", "camera_location", var_cfa5cedf );
    scripted_widgets::function_9ade1d9b( #"hash_48087cf592ac15d8", "camera_date", var_de721607 );
    scripted_widgets::function_9ade1d9b( #"hash_48087cf592ac15d8", "camera_timer_start", var_1aebd615 );
    scripted_widgets::function_9ade1d9b( #"hash_48087cf592ac15d8", "camera_zoom", var_dd3b452 );
    level.player clientfield::set_to_player( "cctv_postfx", 1 );
}

// Namespace cctv/cctv
// Params 2
// Checksum 0xdd363051, Offset: 0x4f0
// Size: 0x9c
function function_bd2b7003( var_6acccd9c = #"", var_7a6d5da7 = #"" )
{
    scripted_widgets::function_9ade1d9b( #"hash_48087cf592ac15d8", "camera_name", var_6acccd9c );
    scripted_widgets::function_9ade1d9b( #"hash_48087cf592ac15d8", "camera_location", var_7a6d5da7 );
}

// Namespace cctv/cctv
// Params 2
// Checksum 0x96b17218, Offset: 0x598
// Size: 0x8c
function function_6e6cbceb( var_862f0a8a = #"", var_d3e70c7c = 0 )
{
    scripted_widgets::function_9ade1d9b( #"hash_48087cf592ac15d8", "camera_date", var_862f0a8a );
    scripted_widgets::function_9ade1d9b( #"hash_48087cf592ac15d8", "camera_timer_start", var_d3e70c7c );
}

// Namespace cctv/cctv
// Params 1
// Checksum 0x54e99190, Offset: 0x630
// Size: 0x34
function function_b0adb9ba( var_5bb68104 )
{
    scripted_widgets::function_9ade1d9b( #"hash_48087cf592ac15d8", "camera_zoom", var_5bb68104 );
}

// Namespace cctv/cctv
// Params 1
// Checksum 0xc10f15fa, Offset: 0x670
// Size: 0x19c
function function_173bb173( var_67df10fb = 1 )
{
    self notify( "1fab2ed31848d7d8" );
    self endon( "1fab2ed31848d7d8" );
    
    if ( var_67df10fb >= float( function_60d95f53() ) / 1000 )
    {
        wait var_67df10fb;
    }
    
    if ( scripted_widgets::exists( #"hash_48087cf592ac15d8" ) )
    {
        scripted_widgets::function_9ade1d9b( #"hash_48087cf592ac15d8", "camera_fade_out_time", var_67df10fb );
    }
    
    if ( var_67df10fb > 0 )
    {
        wait 2;
    }
    
    if ( scripted_widgets::exists( #"hash_48087cf592ac15d8" ) )
    {
        scripted_widgets::remove( #"hash_48087cf592ac15d8" );
    }
    
    namespace_82bfe441::fade( 0, "FadeMedium" );
    level.player clientfield::set_to_player( "cctv_postfx", 0 );
    level.player clientfield::set_to_player( "cull_outside_nuke_room", 0 );
    level.player clientfield::set_to_player( "preload_nukeroom_tarp_material", 0 );
}

