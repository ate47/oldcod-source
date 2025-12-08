#using scripts\core_common\lui_shared;

#namespace cp_hint_text;

// Namespace cp_hint_text
// Method(s) 10 Total 16
class class_ab111f2c : cluielem
{

    // Namespace namespace_ab111f2c/cp_hint_text
    // Params 1
    // Checksum 0xa29b8ca6, Offset: 0x5d0
    // Size: 0x24
    function open( localclientnum )
    {
        cluielem::open( localclientnum );
    }

    // Namespace namespace_ab111f2c/cp_hint_text
    // Params 1
    // Checksum 0xbf645e52, Offset: 0x6b0
    // Size: 0x6c
    function function_1c78fe1e( localclientnum )
    {
        current_val = get_data( localclientnum, "fadeout" );
        new_val = ( current_val + 1 ) % 2;
        set_data( localclientnum, "fadeout", new_val );
    }

    // Namespace namespace_ab111f2c/cp_hint_text
    // Params 0
    // Checksum 0xeb70b8a9, Offset: 0x500
    // Size: 0x1c
    function register_clientside()
    {
        cluielem::register_clientside( "cp_hint_text" );
    }

    // Namespace namespace_ab111f2c/cp_hint_text
    // Params 1
    // Checksum 0x3b9639a8, Offset: 0x638
    // Size: 0x6c
    function function_64d95cad( localclientnum )
    {
        current_val = get_data( localclientnum, "display_blink" );
        new_val = ( current_val + 1 ) % 2;
        set_data( localclientnum, "display_blink", new_val );
    }

    // Namespace namespace_ab111f2c/cp_hint_text
    // Params 4
    // Checksum 0x17338fdb, Offset: 0x418
    // Size: 0xdc
    function setup_clientfields( *var_4f361551, var_8f133ca4, var_b38e91b5, var_101d8535 )
    {
        cluielem::setup_clientfields( "cp_hint_text" );
        cluielem::function_dcb34c80( "string", "hint_text", 1 );
        cluielem::add_clientfield( "display_blink", 1, 1, "counter", var_8f133ca4 );
        cluielem::add_clientfield( "fadeout", 1, 1, "counter", var_b38e91b5 );
        cluielem::add_clientfield( "display_noblink", 1, 1, "counter", var_101d8535 );
    }

    // Namespace namespace_ab111f2c/cp_hint_text
    // Params 2
    // Checksum 0x8220ab21, Offset: 0x600
    // Size: 0x30
    function function_a16f86c1( localclientnum, value )
    {
        set_data( localclientnum, "hint_text", value );
    }

    // Namespace namespace_ab111f2c/cp_hint_text
    // Params 1
    // Checksum 0xd6b9a2fe, Offset: 0x728
    // Size: 0x6c
    function function_a981d6b6( localclientnum )
    {
        current_val = get_data( localclientnum, "display_noblink" );
        new_val = ( current_val + 1 ) % 2;
        set_data( localclientnum, "display_noblink", new_val );
    }

    // Namespace namespace_ab111f2c/cp_hint_text
    // Params 1
    // Checksum 0x8c26feff, Offset: 0x528
    // Size: 0xa0
    function function_fa582112( localclientnum )
    {
        cluielem::function_fa582112( localclientnum );
        set_data( localclientnum, "hint_text", #"" );
        set_data( localclientnum, "display_blink", 0 );
        set_data( localclientnum, "fadeout", 0 );
        set_data( localclientnum, "display_noblink", 0 );
    }

}

// Namespace cp_hint_text/cp_hint_text
// Params 4
// Checksum 0xd854e399, Offset: 0xf8
// Size: 0x196
function register( var_4f361551, var_8f133ca4, var_b38e91b5, var_101d8535 )
{
    elem = new class_ab111f2c();
    [[ elem ]]->setup_clientfields( var_4f361551, var_8f133ca4, var_b38e91b5, var_101d8535 );
    
    if ( !isdefined( level.var_ae746e8f ) )
    {
        level.var_ae746e8f = associativearray();
    }
    
    if ( !isdefined( level.var_ae746e8f[ #"cp_hint_text" ] ) )
    {
        level.var_ae746e8f[ #"cp_hint_text" ] = [];
    }
    
    if ( !isdefined( level.var_ae746e8f[ #"cp_hint_text" ] ) )
    {
        level.var_ae746e8f[ #"cp_hint_text" ] = [];
    }
    else if ( !isarray( level.var_ae746e8f[ #"cp_hint_text" ] ) )
    {
        level.var_ae746e8f[ #"cp_hint_text" ] = array( level.var_ae746e8f[ #"cp_hint_text" ] );
    }
    
    level.var_ae746e8f[ #"cp_hint_text" ][ level.var_ae746e8f[ #"cp_hint_text" ].size ] = elem;
}

// Namespace cp_hint_text/cp_hint_text
// Params 0
// Checksum 0xeb63a8d6, Offset: 0x298
// Size: 0x34
function register_clientside()
{
    elem = new class_ab111f2c();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace cp_hint_text/cp_hint_text
// Params 1
// Checksum 0x1c696df0, Offset: 0x2d8
// Size: 0x1c
function open( player )
{
    [[ self ]]->open( player );
}

// Namespace cp_hint_text/cp_hint_text
// Params 1
// Checksum 0x7c1d698e, Offset: 0x300
// Size: 0x1c
function close( player )
{
    [[ self ]]->close( player );
}

// Namespace cp_hint_text/cp_hint_text
// Params 1
// Checksum 0x37994dd3, Offset: 0x328
// Size: 0x1a
function is_open( localclientnum )
{
    return [[ self ]]->is_open( localclientnum );
}

// Namespace cp_hint_text/cp_hint_text
// Params 2
// Checksum 0x82da8d36, Offset: 0x350
// Size: 0x28
function function_a16f86c1( localclientnum, value )
{
    [[ self ]]->function_a16f86c1( localclientnum, value );
}

// Namespace cp_hint_text/cp_hint_text
// Params 1
// Checksum 0xe6ea326e, Offset: 0x380
// Size: 0x1c
function function_64d95cad( localclientnum )
{
    [[ self ]]->function_64d95cad( localclientnum );
}

// Namespace cp_hint_text/cp_hint_text
// Params 1
// Checksum 0xbf1f4ed, Offset: 0x3a8
// Size: 0x1c
function function_1c78fe1e( localclientnum )
{
    [[ self ]]->function_1c78fe1e( localclientnum );
}

// Namespace cp_hint_text/cp_hint_text
// Params 1
// Checksum 0x59bee81a, Offset: 0x3d0
// Size: 0x1c
function function_a981d6b6( localclientnum )
{
    [[ self ]]->function_a981d6b6( localclientnum );
}

