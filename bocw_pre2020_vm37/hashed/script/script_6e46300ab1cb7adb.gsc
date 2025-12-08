#using script_35ae72be7b4fec10;
#using script_3dc93ca9902a9cda;

#namespace namespace_a43d1663;

// Namespace namespace_a43d1663/namespace_a43d1663
// Params 2
// Checksum 0xcf759598, Offset: 0x98
// Size: 0x114
function init( var_4bf53b01 = #"", var_c18a5a8b = 5 )
{
    if ( scripted_widgets::exists( #"hash_2c29a54813fff877" ) )
    {
        scripted_widgets::remove( #"hash_2c29a54813fff877" );
    }
    
    scripted_widgets::create( #"hash_2c29a54813fff877", #"hash_4782a7f29b84b022" );
    scripted_widgets::function_9ade1d9b( #"hash_2c29a54813fff877", "text", var_4bf53b01 );
    scripted_widgets::function_9ade1d9b( #"hash_2c29a54813fff877", "time", var_c18a5a8b );
    level thread remove( var_c18a5a8b );
}

// Namespace namespace_a43d1663/namespace_a43d1663
// Params 1, eflags: 0x4
// Checksum 0xfffcfdc, Offset: 0x1b8
// Size: 0xbc
function private remove( var_67df10fb )
{
    self notify( "77e42bd6c3e88259" );
    self endon( "77e42bd6c3e88259" );
    
    if ( !isdefined( var_67df10fb ) )
    {
        var_67df10fb = 5;
    }
    
    if ( var_67df10fb >= float( function_60d95f53() ) / 1000 )
    {
        wait var_67df10fb;
    }
    
    if ( scripted_widgets::exists( #"hash_2c29a54813fff877" ) )
    {
        scripted_widgets::remove( #"hash_2c29a54813fff877" );
    }
}

