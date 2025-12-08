#using scripts\core_common\lui_shared;

#namespace cp_chyron;

// Namespace cp_chyron
// Method(s) 12 Total 18
class ccp_chyron : cluielem
{

    // Namespace ccp_chyron/cp_chyron
    // Params 2
    // Checksum 0x6d8cab70, Offset: 0x7b8
    // Size: 0x30
    function function_6b7b6e4( localclientnum, value )
    {
        set_data( localclientnum, "line3", value );
    }

    // Namespace ccp_chyron/cp_chyron
    // Params 1
    // Checksum 0x113baaaa, Offset: 0x718
    // Size: 0x24
    function open( localclientnum )
    {
        cluielem::open( localclientnum );
    }

    // Namespace ccp_chyron/cp_chyron
    // Params 2
    // Checksum 0x62460789, Offset: 0x780
    // Size: 0x30
    function function_147e5271( localclientnum, value )
    {
        set_data( localclientnum, "line2", value );
    }

    // Namespace ccp_chyron/cp_chyron
    // Params 2
    // Checksum 0x988f0982, Offset: 0x828
    // Size: 0x30
    function function_2a377de3( localclientnum, value )
    {
        set_data( localclientnum, "line5", value );
    }

    // Namespace ccp_chyron/cp_chyron
    // Params 2
    // Checksum 0xfc26b4d3, Offset: 0x748
    // Size: 0x30
    function function_4b584028( localclientnum, value )
    {
        set_data( localclientnum, "line1", value );
    }

    // Namespace ccp_chyron/cp_chyron
    // Params 0
    // Checksum 0x7c9bca16, Offset: 0x5e0
    // Size: 0x1c
    function register_clientside()
    {
        cluielem::register_clientside( "cp_chyron" );
    }

    // Namespace ccp_chyron/cp_chyron
    // Params 2
    // Checksum 0x9a1441b6, Offset: 0x860
    // Size: 0x30
    function function_90bde5d3( localclientnum, value )
    {
        set_data( localclientnum, "index", value );
    }

    // Namespace ccp_chyron/cp_chyron
    // Params 6
    // Checksum 0x8ea029ce, Offset: 0x498
    // Size: 0x13c
    function setup_clientfields( *var_27185c26, *var_9da4cb62, *var_865fc474, *var_1909e1e7, *var_2ff7635c, var_eaf012fc )
    {
        cluielem::setup_clientfields( "cp_chyron" );
        cluielem::function_dcb34c80( "string", "line1", 1 );
        cluielem::function_dcb34c80( "string", "line2", 1 );
        cluielem::function_dcb34c80( "string", "line3", 1 );
        cluielem::function_dcb34c80( "string", "line4", 1 );
        cluielem::function_dcb34c80( "string", "line5", 1 );
        cluielem::add_clientfield( "index", 1, 4, "int", var_eaf012fc );
    }

    // Namespace ccp_chyron/cp_chyron
    // Params 2
    // Checksum 0x9dec820, Offset: 0x7f0
    // Size: 0x30
    function function_b7f01956( localclientnum, value )
    {
        set_data( localclientnum, "line4", value );
    }

    // Namespace ccp_chyron/cp_chyron
    // Params 1
    // Checksum 0xfff291fb, Offset: 0x608
    // Size: 0x108
    function function_fa582112( localclientnum )
    {
        cluielem::function_fa582112( localclientnum );
        set_data( localclientnum, "line1", #"" );
        set_data( localclientnum, "line2", #"" );
        set_data( localclientnum, "line3", #"" );
        set_data( localclientnum, "line4", #"" );
        set_data( localclientnum, "line5", #"" );
        set_data( localclientnum, "index", 0 );
    }

}

// Namespace cp_chyron/cp_chyron
// Params 6
// Checksum 0x445df0a5, Offset: 0xf0
// Size: 0x1a6
function register( var_27185c26, var_9da4cb62, var_865fc474, var_1909e1e7, var_2ff7635c, var_eaf012fc )
{
    elem = new ccp_chyron();
    [[ elem ]]->setup_clientfields( var_27185c26, var_9da4cb62, var_865fc474, var_1909e1e7, var_2ff7635c, var_eaf012fc );
    
    if ( !isdefined( level.var_ae746e8f ) )
    {
        level.var_ae746e8f = associativearray();
    }
    
    if ( !isdefined( level.var_ae746e8f[ #"cp_chyron" ] ) )
    {
        level.var_ae746e8f[ #"cp_chyron" ] = [];
    }
    
    if ( !isdefined( level.var_ae746e8f[ #"cp_chyron" ] ) )
    {
        level.var_ae746e8f[ #"cp_chyron" ] = [];
    }
    else if ( !isarray( level.var_ae746e8f[ #"cp_chyron" ] ) )
    {
        level.var_ae746e8f[ #"cp_chyron" ] = array( level.var_ae746e8f[ #"cp_chyron" ] );
    }
    
    level.var_ae746e8f[ #"cp_chyron" ][ level.var_ae746e8f[ #"cp_chyron" ].size ] = elem;
}

// Namespace cp_chyron/cp_chyron
// Params 0
// Checksum 0x18e2738d, Offset: 0x2a0
// Size: 0x34
function register_clientside()
{
    elem = new ccp_chyron();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace cp_chyron/cp_chyron
// Params 1
// Checksum 0xa81b1d99, Offset: 0x2e0
// Size: 0x1c
function open( player )
{
    [[ self ]]->open( player );
}

// Namespace cp_chyron/cp_chyron
// Params 1
// Checksum 0xea52e7de, Offset: 0x308
// Size: 0x1c
function close( player )
{
    [[ self ]]->close( player );
}

// Namespace cp_chyron/cp_chyron
// Params 1
// Checksum 0x1a6affa2, Offset: 0x330
// Size: 0x1a
function is_open( localclientnum )
{
    return [[ self ]]->is_open( localclientnum );
}

// Namespace cp_chyron/cp_chyron
// Params 2
// Checksum 0x43160df1, Offset: 0x358
// Size: 0x28
function function_4b584028( localclientnum, value )
{
    [[ self ]]->function_4b584028( localclientnum, value );
}

// Namespace cp_chyron/cp_chyron
// Params 2
// Checksum 0xa92eb959, Offset: 0x388
// Size: 0x28
function function_147e5271( localclientnum, value )
{
    [[ self ]]->function_147e5271( localclientnum, value );
}

// Namespace cp_chyron/cp_chyron
// Params 2
// Checksum 0x66b6b6c7, Offset: 0x3b8
// Size: 0x28
function function_6b7b6e4( localclientnum, value )
{
    [[ self ]]->function_6b7b6e4( localclientnum, value );
}

// Namespace cp_chyron/cp_chyron
// Params 2
// Checksum 0x3f8ae08, Offset: 0x3e8
// Size: 0x28
function function_b7f01956( localclientnum, value )
{
    [[ self ]]->function_b7f01956( localclientnum, value );
}

// Namespace cp_chyron/cp_chyron
// Params 2
// Checksum 0x6c4431e8, Offset: 0x418
// Size: 0x28
function function_2a377de3( localclientnum, value )
{
    [[ self ]]->function_2a377de3( localclientnum, value );
}

// Namespace cp_chyron/cp_chyron
// Params 2
// Checksum 0xe6c26835, Offset: 0x448
// Size: 0x28
function function_90bde5d3( localclientnum, value )
{
    [[ self ]]->function_90bde5d3( localclientnum, value );
}

