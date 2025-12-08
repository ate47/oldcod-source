#using scripts\core_common\lui_shared;

#namespace pip_menu;

// Namespace pip_menu
// Method(s) 10 Total 16
class class_70ee35b1 : cluielem
{

    // Namespace namespace_70ee35b1/pip_menu
    // Params 2
    // Checksum 0x8dafb6ac, Offset: 0x610
    // Size: 0x30
    function set_moviename( localclientnum, value )
    {
        set_data( localclientnum, "movieName", value );
    }

    // Namespace namespace_70ee35b1/pip_menu
    // Params 1
    // Checksum 0x90f899db, Offset: 0x5e0
    // Size: 0x24
    function open( localclientnum )
    {
        cluielem::open( localclientnum );
    }

    // Namespace namespace_70ee35b1/pip_menu
    // Params 2
    // Checksum 0x2b66d96, Offset: 0x6b8
    // Size: 0x30
    function set_additive( localclientnum, value )
    {
        set_data( localclientnum, "additive", value );
    }

    // Namespace namespace_70ee35b1/pip_menu
    // Params 0
    // Checksum 0xf51160f2, Offset: 0x510
    // Size: 0x1c
    function register_clientside()
    {
        cluielem::register_clientside( "pip_menu" );
    }

    // Namespace namespace_70ee35b1/pip_menu
    // Params 2
    // Checksum 0xfa21ae4d, Offset: 0x680
    // Size: 0x30
    function set_looping( localclientnum, value )
    {
        set_data( localclientnum, "looping", value );
    }

    // Namespace namespace_70ee35b1/pip_menu
    // Params 2
    // Checksum 0x87e3afc2, Offset: 0x648
    // Size: 0x30
    function set_showblackscreen( localclientnum, value )
    {
        set_data( localclientnum, "showBlackScreen", value );
    }

    // Namespace namespace_70ee35b1/pip_menu
    // Params 4
    // Checksum 0x619b485, Offset: 0x428
    // Size: 0xdc
    function setup_clientfields( *var_f7b454f9, var_d5b04ae3, var_e4decd0, var_e545d4b9 )
    {
        cluielem::setup_clientfields( "pip_menu" );
        cluielem::function_dcb34c80( "moviefile", "movieName", 1 );
        cluielem::add_clientfield( "showBlackScreen", 1, 1, "int", var_d5b04ae3 );
        cluielem::add_clientfield( "looping", 1, 1, "int", var_e4decd0 );
        cluielem::add_clientfield( "additive", 1, 1, "int", var_e545d4b9 );
    }

    // Namespace namespace_70ee35b1/pip_menu
    // Params 1
    // Checksum 0x6255212b, Offset: 0x538
    // Size: 0xa0
    function function_fa582112( localclientnum )
    {
        cluielem::function_fa582112( localclientnum );
        set_data( localclientnum, "movieName", #"" );
        set_data( localclientnum, "showBlackScreen", 0 );
        set_data( localclientnum, "looping", 0 );
        set_data( localclientnum, "additive", 0 );
    }

}

// Namespace pip_menu/pip_menu
// Params 4
// Checksum 0x981f0716, Offset: 0xf0
// Size: 0x196
function register( var_f7b454f9, var_d5b04ae3, var_e4decd0, var_e545d4b9 )
{
    elem = new class_70ee35b1();
    [[ elem ]]->setup_clientfields( var_f7b454f9, var_d5b04ae3, var_e4decd0, var_e545d4b9 );
    
    if ( !isdefined( level.var_ae746e8f ) )
    {
        level.var_ae746e8f = associativearray();
    }
    
    if ( !isdefined( level.var_ae746e8f[ #"pip_menu" ] ) )
    {
        level.var_ae746e8f[ #"pip_menu" ] = [];
    }
    
    if ( !isdefined( level.var_ae746e8f[ #"pip_menu" ] ) )
    {
        level.var_ae746e8f[ #"pip_menu" ] = [];
    }
    else if ( !isarray( level.var_ae746e8f[ #"pip_menu" ] ) )
    {
        level.var_ae746e8f[ #"pip_menu" ] = array( level.var_ae746e8f[ #"pip_menu" ] );
    }
    
    level.var_ae746e8f[ #"pip_menu" ][ level.var_ae746e8f[ #"pip_menu" ].size ] = elem;
}

// Namespace pip_menu/pip_menu
// Params 0
// Checksum 0xf04661af, Offset: 0x290
// Size: 0x34
function register_clientside()
{
    elem = new class_70ee35b1();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace pip_menu/pip_menu
// Params 1
// Checksum 0x2c06bbcc, Offset: 0x2d0
// Size: 0x1c
function open( player )
{
    [[ self ]]->open( player );
}

// Namespace pip_menu/pip_menu
// Params 1
// Checksum 0xfe370286, Offset: 0x2f8
// Size: 0x1c
function close( player )
{
    [[ self ]]->close( player );
}

// Namespace pip_menu/pip_menu
// Params 1
// Checksum 0x6153647b, Offset: 0x320
// Size: 0x1a
function is_open( localclientnum )
{
    return [[ self ]]->is_open( localclientnum );
}

// Namespace pip_menu/pip_menu
// Params 2
// Checksum 0xb361515b, Offset: 0x348
// Size: 0x28
function set_moviename( localclientnum, value )
{
    [[ self ]]->set_moviename( localclientnum, value );
}

// Namespace pip_menu/pip_menu
// Params 2
// Checksum 0x21f454f1, Offset: 0x378
// Size: 0x28
function set_showblackscreen( localclientnum, value )
{
    [[ self ]]->set_showblackscreen( localclientnum, value );
}

// Namespace pip_menu/pip_menu
// Params 2
// Checksum 0x3749aa07, Offset: 0x3a8
// Size: 0x28
function set_looping( localclientnum, value )
{
    [[ self ]]->set_looping( localclientnum, value );
}

// Namespace pip_menu/pip_menu
// Params 2
// Checksum 0x83b5c20c, Offset: 0x3d8
// Size: 0x28
function set_additive( localclientnum, value )
{
    [[ self ]]->set_additive( localclientnum, value );
}

