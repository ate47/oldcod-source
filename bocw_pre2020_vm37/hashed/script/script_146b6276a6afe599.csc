#using scripts\core_common\lui_shared;

#namespace cp_newsroom;

// Namespace cp_newsroom
// Method(s) 18 Total 24
class class_52d58332 : cluielem
{

    // Namespace namespace_52d58332/cp_newsroom
    // Params 1
    // Checksum 0xde30c0cc, Offset: 0xab0
    // Size: 0x24
    function open( localclientnum )
    {
        cluielem::open( localclientnum );
    }

    // Namespace namespace_52d58332/cp_newsroom
    // Params 2
    // Checksum 0x91f053d4, Offset: 0xb88
    // Size: 0x30
    function function_41058a0f( localclientnum, value )
    {
        set_data( localclientnum, "sceneIndex", value );
    }

    // Namespace namespace_52d58332/cp_newsroom
    // Params 2
    // Checksum 0xf070a5f1, Offset: 0xbc0
    // Size: 0x30
    function function_459cfc57( localclientnum, value )
    {
        set_data( localclientnum, "noble.generalNewsIndex", value );
    }

    // Namespace namespace_52d58332/cp_newsroom
    // Params 2
    // Checksum 0x5b72126a, Offset: 0xc30
    // Size: 0x30
    function function_469781eb( localclientnum, value )
    {
        set_data( localclientnum, "noble.offline", value );
    }

    // Namespace namespace_52d58332/cp_newsroom
    // Params 2
    // Checksum 0x41008c01, Offset: 0xb50
    // Size: 0x30
    function function_52b2ec58( localclientnum, value )
    {
        set_data( localclientnum, "uns.offline", value );
    }

    // Namespace namespace_52d58332/cp_newsroom
    // Params 0
    // Checksum 0x6e1c4512, Offset: 0x908
    // Size: 0x1c
    function register_clientside()
    {
        cluielem::register_clientside( "cp_newsroom" );
    }

    // Namespace namespace_52d58332/cp_newsroom
    // Params 2
    // Checksum 0x113bf19, Offset: 0xd10
    // Size: 0x30
    function function_793d3466( localclientnum, value )
    {
        set_data( localclientnum, "torch.offline", value );
    }

    // Namespace namespace_52d58332/cp_newsroom
    // Params 12
    // Checksum 0x8d8d39ab, Offset: 0x6a0
    // Size: 0x25c
    function setup_clientfields( var_18818901, var_26df9dbf, var_cff0635, var_864dd818, var_893e6e8a, var_beaa7a02, var_67bd323f, var_24d68a31, var_7c10bc1a, var_7f23d12c, var_db60a6e7, var_aa351a69 )
    {
        cluielem::setup_clientfields( "cp_newsroom" );
        cluielem::add_clientfield( "channel", 1, 2, "int", var_18818901 );
        cluielem::add_clientfield( "uns.generalNewsIndex", 1, 2, "int", var_26df9dbf );
        cluielem::add_clientfield( "uns.offline", 1, 1, "int", var_cff0635 );
        cluielem::add_clientfield( "sceneIndex", 1, 2, "int", var_864dd818 );
        cluielem::add_clientfield( "noble.generalNewsIndex", 1, 2, "int", var_893e6e8a );
        cluielem::add_clientfield( "noble.imageIndex", 1, 2, "int", var_beaa7a02 );
        cluielem::add_clientfield( "noble.offline", 1, 1, "int", var_67bd323f );
        cluielem::add_clientfield( "torch.followers", 1, 7, "int", var_24d68a31 );
        cluielem::add_clientfield( "torch.subscribers", 1, 7, "int", var_7c10bc1a );
        cluielem::add_clientfield( "torch.donatorIndex", 1, 7, "int", var_7f23d12c );
        cluielem::add_clientfield( "torch.offline", 1, 1, "int", var_db60a6e7 );
        cluielem::add_clientfield( "torch.breakingNewsAlert", 1, 1, "int", var_aa351a69 );
    }

    // Namespace namespace_52d58332/cp_newsroom
    // Params 2
    // Checksum 0xd294ae0c, Offset: 0xbf8
    // Size: 0x30
    function function_a075150b( localclientnum, value )
    {
        set_data( localclientnum, "noble.imageIndex", value );
    }

    // Namespace namespace_52d58332/cp_newsroom
    // Params 2
    // Checksum 0xd82c7d38, Offset: 0xb18
    // Size: 0x30
    function function_a595ec12( localclientnum, value )
    {
        set_data( localclientnum, "uns.generalNewsIndex", value );
    }

    // Namespace namespace_52d58332/cp_newsroom
    // Params 2
    // Checksum 0x5a4791c1, Offset: 0xcd8
    // Size: 0x30
    function function_aae350c7( localclientnum, value )
    {
        set_data( localclientnum, "torch.donatorIndex", value );
    }

    // Namespace namespace_52d58332/cp_newsroom
    // Params 2
    // Checksum 0x167571b4, Offset: 0xd48
    // Size: 0x30
    function function_b117c344( localclientnum, value )
    {
        set_data( localclientnum, "torch.breakingNewsAlert", value );
    }

    // Namespace namespace_52d58332/cp_newsroom
    // Params 2
    // Checksum 0xb8cbcbc6, Offset: 0xca0
    // Size: 0x30
    function function_b6328fe2( localclientnum, value )
    {
        set_data( localclientnum, "torch.subscribers", value );
    }

    // Namespace namespace_52d58332/cp_newsroom
    // Params 2
    // Checksum 0x81d4e134, Offset: 0xae0
    // Size: 0x30
    function function_df160ff1( localclientnum, value )
    {
        set_data( localclientnum, "channel", value );
    }

    // Namespace namespace_52d58332/cp_newsroom
    // Params 2
    // Checksum 0xb0365333, Offset: 0xc68
    // Size: 0x30
    function function_e380be6c( localclientnum, value )
    {
        set_data( localclientnum, "torch.followers", value );
    }

    // Namespace namespace_52d58332/cp_newsroom
    // Params 1
    // Checksum 0x506dc498, Offset: 0x930
    // Size: 0x174
    function function_fa582112( localclientnum )
    {
        cluielem::function_fa582112( localclientnum );
        set_data( localclientnum, "channel", 0 );
        set_data( localclientnum, "uns.generalNewsIndex", 0 );
        set_data( localclientnum, "uns.offline", 0 );
        set_data( localclientnum, "sceneIndex", 0 );
        set_data( localclientnum, "noble.generalNewsIndex", 0 );
        set_data( localclientnum, "noble.imageIndex", 0 );
        set_data( localclientnum, "noble.offline", 0 );
        set_data( localclientnum, "torch.followers", 0 );
        set_data( localclientnum, "torch.subscribers", 0 );
        set_data( localclientnum, "torch.donatorIndex", 0 );
        set_data( localclientnum, "torch.offline", 0 );
        set_data( localclientnum, "torch.breakingNewsAlert", 0 );
    }

}

// Namespace cp_newsroom/cp_newsroom
// Params 12
// Checksum 0x515bffcf, Offset: 0x198
// Size: 0x1e6
function register( var_18818901, var_26df9dbf, var_cff0635, var_864dd818, var_893e6e8a, var_beaa7a02, var_67bd323f, var_24d68a31, var_7c10bc1a, var_7f23d12c, var_db60a6e7, var_aa351a69 )
{
    elem = new class_52d58332();
    [[ elem ]]->setup_clientfields( var_18818901, var_26df9dbf, var_cff0635, var_864dd818, var_893e6e8a, var_beaa7a02, var_67bd323f, var_24d68a31, var_7c10bc1a, var_7f23d12c, var_db60a6e7, var_aa351a69 );
    
    if ( !isdefined( level.var_ae746e8f ) )
    {
        level.var_ae746e8f = associativearray();
    }
    
    if ( !isdefined( level.var_ae746e8f[ #"cp_newsroom" ] ) )
    {
        level.var_ae746e8f[ #"cp_newsroom" ] = [];
    }
    
    if ( !isdefined( level.var_ae746e8f[ #"cp_newsroom" ] ) )
    {
        level.var_ae746e8f[ #"cp_newsroom" ] = [];
    }
    else if ( !isarray( level.var_ae746e8f[ #"cp_newsroom" ] ) )
    {
        level.var_ae746e8f[ #"cp_newsroom" ] = array( level.var_ae746e8f[ #"cp_newsroom" ] );
    }
    
    level.var_ae746e8f[ #"cp_newsroom" ][ level.var_ae746e8f[ #"cp_newsroom" ].size ] = elem;
}

// Namespace cp_newsroom/cp_newsroom
// Params 0
// Checksum 0xb8d30c74, Offset: 0x388
// Size: 0x34
function register_clientside()
{
    elem = new class_52d58332();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace cp_newsroom/cp_newsroom
// Params 1
// Checksum 0x3d60b63a, Offset: 0x3c8
// Size: 0x1c
function open( player )
{
    [[ self ]]->open( player );
}

// Namespace cp_newsroom/cp_newsroom
// Params 1
// Checksum 0x89b4768f, Offset: 0x3f0
// Size: 0x1c
function close( player )
{
    [[ self ]]->close( player );
}

// Namespace cp_newsroom/cp_newsroom
// Params 1
// Checksum 0xa2c255c2, Offset: 0x418
// Size: 0x1a
function is_open( localclientnum )
{
    return [[ self ]]->is_open( localclientnum );
}

// Namespace cp_newsroom/cp_newsroom
// Params 2
// Checksum 0xc9e5c664, Offset: 0x440
// Size: 0x28
function function_df160ff1( localclientnum, value )
{
    [[ self ]]->function_df160ff1( localclientnum, value );
}

// Namespace cp_newsroom/cp_newsroom
// Params 2
// Checksum 0xfa76b3e, Offset: 0x470
// Size: 0x28
function function_a595ec12( localclientnum, value )
{
    [[ self ]]->function_a595ec12( localclientnum, value );
}

// Namespace cp_newsroom/cp_newsroom
// Params 2
// Checksum 0x109649be, Offset: 0x4a0
// Size: 0x28
function function_52b2ec58( localclientnum, value )
{
    [[ self ]]->function_52b2ec58( localclientnum, value );
}

// Namespace cp_newsroom/cp_newsroom
// Params 2
// Checksum 0x12ce7876, Offset: 0x4d0
// Size: 0x28
function function_41058a0f( localclientnum, value )
{
    [[ self ]]->function_41058a0f( localclientnum, value );
}

// Namespace cp_newsroom/cp_newsroom
// Params 2
// Checksum 0x4bd784d0, Offset: 0x500
// Size: 0x28
function function_459cfc57( localclientnum, value )
{
    [[ self ]]->function_459cfc57( localclientnum, value );
}

// Namespace cp_newsroom/cp_newsroom
// Params 2
// Checksum 0x7664720f, Offset: 0x530
// Size: 0x28
function function_a075150b( localclientnum, value )
{
    [[ self ]]->function_a075150b( localclientnum, value );
}

// Namespace cp_newsroom/cp_newsroom
// Params 2
// Checksum 0xc3fe873f, Offset: 0x560
// Size: 0x28
function function_469781eb( localclientnum, value )
{
    [[ self ]]->function_469781eb( localclientnum, value );
}

// Namespace cp_newsroom/cp_newsroom
// Params 2
// Checksum 0x557b28db, Offset: 0x590
// Size: 0x28
function function_e380be6c( localclientnum, value )
{
    [[ self ]]->function_e380be6c( localclientnum, value );
}

// Namespace cp_newsroom/cp_newsroom
// Params 2
// Checksum 0xa4df93eb, Offset: 0x5c0
// Size: 0x28
function function_b6328fe2( localclientnum, value )
{
    [[ self ]]->function_b6328fe2( localclientnum, value );
}

// Namespace cp_newsroom/cp_newsroom
// Params 2
// Checksum 0xddc3f68c, Offset: 0x5f0
// Size: 0x28
function function_aae350c7( localclientnum, value )
{
    [[ self ]]->function_aae350c7( localclientnum, value );
}

// Namespace cp_newsroom/cp_newsroom
// Params 2
// Checksum 0xf70a6155, Offset: 0x620
// Size: 0x28
function function_793d3466( localclientnum, value )
{
    [[ self ]]->function_793d3466( localclientnum, value );
}

// Namespace cp_newsroom/cp_newsroom
// Params 2
// Checksum 0x740baca7, Offset: 0x650
// Size: 0x28
function function_b117c344( localclientnum, value )
{
    [[ self ]]->function_b117c344( localclientnum, value );
}

