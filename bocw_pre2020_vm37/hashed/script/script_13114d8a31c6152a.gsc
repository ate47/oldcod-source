#using script_35ae72be7b4fec10;

#namespace namespace_c8e236da;

// Namespace namespace_c8e236da/namespace_c8e236da
// Params 1
// Checksum 0xb592a75f, Offset: 0x78
// Size: 0x124
function addprompt( var_e11b5b56 )
{
    if ( !isdefined( level.var_f9c1d7d5 ) )
    {
        level.var_f9c1d7d5 = [];
    }
    
    level.var_f9c1d7d5[ level.var_f9c1d7d5.size ] = var_e11b5b56;
    
    if ( !scripted_widgets::exists( #"hash_72cc4740fa4d3da3" ) )
    {
        scripted_widgets::create( #"hash_72cc4740fa4d3da3", #"hash_33da613c2715b7bb" );
        scripted_widgets::function_46df0bc7( #"hash_72cc4740fa4d3da3", 999 );
    }
    
    scripted_widgets::function_9ade1d9b( #"hash_72cc4740fa4d3da3", #"ishorizontal", 1 );
    scripted_widgets::function_f2a9266( #"hash_72cc4740fa4d3da3", level.var_f9c1d7d5.size, "ContentLine", var_e11b5b56 );
}

// Namespace namespace_c8e236da/namespace_c8e236da
// Params 2
// Checksum 0x7e87dd8, Offset: 0x1a8
// Size: 0x74
function clearprompt( var_88e62a80, var_6262df45 )
{
    if ( isdefined( var_6262df45 ) )
    {
        scripted_widgets::function_f2a9266( #"hash_72cc4740fa4d3da3", var_88e62a80, "ContentLine", var_6262df45 );
        return;
    }
    
    scripted_widgets::function_7239e030( #"hash_72cc4740fa4d3da3", var_88e62a80 );
}

// Namespace namespace_c8e236da/namespace_c8e236da
// Params 2
// Checksum 0x3f8d4cf5, Offset: 0x228
// Size: 0x84
function function_f7362969( var_a5a2c782, var_541423e6 = 1 )
{
    if ( scripted_widgets::exists( #"hash_72cc4740fa4d3da3" ) )
    {
        if ( var_541423e6 )
        {
            scripted_widgets::hide_widgets( var_a5a2c782, #"hash_72cc4740fa4d3da3" );
            return;
        }
        
        scripted_widgets::function_f96376c5( var_a5a2c782 );
    }
}

// Namespace namespace_c8e236da/namespace_c8e236da
// Params 0
// Checksum 0xd186db47, Offset: 0x2b8
// Size: 0x9c
function clearlist()
{
    if ( scripted_widgets::exists( #"hash_72cc4740fa4d3da3" ) )
    {
        if ( level.var_f9c1d7d5.size > 0 )
        {
            for ( i = 1; i < level.var_f9c1d7d5.size + 1 ; i++ )
            {
                scripted_widgets::function_f2a9266( #"hash_72cc4740fa4d3da3", i, "ContentLine", #"" );
            }
        }
    }
}

// Namespace namespace_c8e236da/namespace_c8e236da
// Params 0
// Checksum 0x269b12eb, Offset: 0x360
// Size: 0x64
function removelist()
{
    clearlist();
    
    if ( scripted_widgets::exists( #"hash_72cc4740fa4d3da3" ) )
    {
        level.var_f9c1d7d5 = undefined;
        scripted_widgets::remove( #"hash_72cc4740fa4d3da3" );
    }
}

