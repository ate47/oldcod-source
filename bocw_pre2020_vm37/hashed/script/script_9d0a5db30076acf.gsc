#using script_35ae72be7b4fec10;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace namespace_4ea0b0e1;

// Namespace namespace_4ea0b0e1/namespace_4ea0b0e1
// Params 0, eflags: 0x6
// Checksum 0x7cf8a189, Offset: 0xd8
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"hash_3092c343f49326ae", &_preload, undefined, undefined, undefined );
}

// Namespace namespace_4ea0b0e1/namespace_4ea0b0e1
// Params 0, eflags: 0x4
// Checksum 0xe3099274, Offset: 0x120
// Size: 0x44
function private _preload()
{
    function_bc948200();
    callback::add_callback( #"oob_toggle", &function_83c9fd20 );
}

// Namespace namespace_4ea0b0e1/namespace_4ea0b0e1
// Params 0, eflags: 0x4
// Checksum 0x84606ce2, Offset: 0x170
// Size: 0x34
function private function_bc948200()
{
    clientfield::register( "toplayer", "return_to_combat_postfx", 1, 1, "int" );
}

// Namespace namespace_4ea0b0e1/namespace_4ea0b0e1
// Params 1, eflags: 0x4
// Checksum 0x4224da0, Offset: 0x1b0
// Size: 0x94
function private function_83c9fd20( params )
{
    var_21a143e = params.countdowntime;
    player = getplayers()[ 0 ];
    
    if ( var_21a143e > 0 )
    {
        level notify( #"hash_722cff0020f34cd4" );
        set( var_21a143e * 0.001 );
        return;
    }
    
    level thread close();
}

// Namespace namespace_4ea0b0e1/namespace_4ea0b0e1
// Params 2, eflags: 0x4
// Checksum 0x8c9f5a4f, Offset: 0x250
// Size: 0x14c
function private set( var_5b36f17f, var_6a374e41 )
{
    level.player = isdefined( level.player ) ? level.player : getplayers()[ 0 ];
    
    if ( !scripted_widgets::exists( #"hash_1a9d78f69978a1f3" ) )
    {
        scripted_widgets::create( #"hash_1a9d78f69978a1f3", #"hash_41ca08e341520d88" );
    }
    
    if ( !isdefined( var_5b36f17f ) )
    {
        var_5b36f17f = 0;
    }
    
    if ( !isdefined( var_6a374e41 ) )
    {
        var_6a374e41 = #"hash_623eff21ed033aec";
    }
    
    scripted_widgets::function_9ade1d9b( #"hash_1a9d78f69978a1f3", "time", var_5b36f17f );
    scripted_widgets::function_9ade1d9b( #"hash_1a9d78f69978a1f3", "text", var_6a374e41 );
    level.player clientfield::set_to_player( "return_to_combat_postfx", 1 );
}

// Namespace namespace_4ea0b0e1/namespace_4ea0b0e1
// Params 1, eflags: 0x4
// Checksum 0xc69b7425, Offset: 0x3a8
// Size: 0xec
function private close( var_67df10fb = 1 )
{
    self notify( "5bbf1d550b1ef164" );
    self endon( "5bbf1d550b1ef164" );
    level endon( #"hash_722cff0020f34cd4" );
    
    if ( var_67df10fb >= float( function_60d95f53() ) / 1000 )
    {
        wait var_67df10fb;
    }
    
    if ( scripted_widgets::exists( #"hash_1a9d78f69978a1f3" ) )
    {
        scripted_widgets::remove( #"hash_1a9d78f69978a1f3" );
    }
    
    level.player clientfield::set_to_player( "return_to_combat_postfx", 0 );
}

