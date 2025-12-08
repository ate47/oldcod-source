#using script_35ae72be7b4fec10;
#using script_4937c6974f43bb71;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace surveycam;

// Namespace surveycam/surveycam
// Params 0, eflags: 0x6
// Checksum 0x395c2446, Offset: 0x158
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"surveycam", &_preload, undefined, undefined, undefined );
}

// Namespace surveycam/surveycam
// Params 0, eflags: 0x4
// Checksum 0xd0d0db79, Offset: 0x1a0
// Size: 0x14
function private _preload()
{
    function_bc948200();
}

// Namespace surveycam/surveycam
// Params 0, eflags: 0x4
// Checksum 0x6b1d4be7, Offset: 0x1c0
// Size: 0x94
function private function_bc948200()
{
    clientfield::register( "toplayer", "surveycam_state", 1, 1, "int" );
    clientfield::register( "toplayer", "surveycam_min_focal_length", 1, 6, "int" );
    clientfield::register( "toplayer", "surveycam_max_focal_length", 1, 6, "int" );
}

// Namespace surveycam/surveycam
// Params 3
// Checksum 0xb2048678, Offset: 0x260
// Size: 0x214
function function_87b9c1ef( var_27169374 = 25, var_25c457e2 = 60, var_941e4516 = #"" )
{
    level.player = isdefined( level.player ) ? level.player : getplayers()[ 0 ];
    
    if ( !scripted_widgets::exists( #"hash_71351bf35e6d6353" ) )
    {
        scripted_widgets::create( #"hash_71351bf35e6d6353", #"surveycam" );
    }
    
    namespace_82bfe441::fade( 1, "FadeImmediate" );
    level.player clientfield::set_to_player( "surveycam_min_focal_length", var_27169374 );
    level.player clientfield::set_to_player( "surveycam_max_focal_length", var_25c457e2 );
    scripted_widgets::function_9ade1d9b( #"hash_71351bf35e6d6353", "position_string", var_941e4516 );
    scripted_widgets::function_9ade1d9b( #"hash_71351bf35e6d6353", "pitch", 0 );
    scripted_widgets::function_9ade1d9b( #"hash_71351bf35e6d6353", "yaw", 0 );
    scripted_widgets::function_9ade1d9b( #"hash_71351bf35e6d6353", "zoom", 1 );
    level.player clientfield::set_to_player( "surveycam_state", 1 );
}

// Namespace surveycam/surveycam
// Params 1
// Checksum 0x7abd2c93, Offset: 0x480
// Size: 0x15c
function function_56d93dca( var_67df10fb = 1 )
{
    self notify( "5e0d1e78edeb285b" );
    self endon( "5e0d1e78edeb285b" );
    
    if ( var_67df10fb >= float( function_60d95f53() ) / 1000 )
    {
        wait var_67df10fb;
    }
    
    if ( scripted_widgets::exists( #"hash_71351bf35e6d6353" ) )
    {
        scripted_widgets::function_9ade1d9b( #"hash_71351bf35e6d6353", "camera_fade_out_time", var_67df10fb );
    }
    
    if ( var_67df10fb > 0 )
    {
        wait 2;
    }
    
    if ( scripted_widgets::exists( #"hash_71351bf35e6d6353" ) )
    {
        scripted_widgets::remove( #"hash_71351bf35e6d6353" );
    }
    
    namespace_82bfe441::fade( 0, "FadeMedium" );
    level.player clientfield::set_to_player( "surveycam_state", 0 );
}

