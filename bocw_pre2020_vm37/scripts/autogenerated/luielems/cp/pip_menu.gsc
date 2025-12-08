#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace pip_menu;

// Namespace pip_menu
// Method(s) 9 Total 16
class class_70ee35b1 : cluielem
{

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace namespace_70ee35b1/pip_menu
    // Params 2
    // Checksum 0xe6b8e98f, Offset: 0x3e8
    // Size: 0x44
    function set_moviename( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "movieName", value );
    }

    // Namespace namespace_70ee35b1/pip_menu
    // Params 2
    // Checksum 0x27c86369, Offset: 0x370
    // Size: 0x3c
    function open( player, persistent = 0 )
    {
        cluielem::open_luielem( player, persistent );
    }

    // Namespace namespace_70ee35b1/pip_menu
    // Params 2
    // Checksum 0x1a0bc609, Offset: 0x4d8
    // Size: 0x44
    function set_additive( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "additive", value );
    }

    // Namespace namespace_70ee35b1/pip_menu
    // Params 1
    // Checksum 0x7c5917e5, Offset: 0x3b8
    // Size: 0x24
    function close( player )
    {
        cluielem::close_luielem( player );
    }

    // Namespace namespace_70ee35b1/pip_menu
    // Params 2
    // Checksum 0xd24e1467, Offset: 0x488
    // Size: 0x44
    function set_looping( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "looping", value );
    }

    // Namespace namespace_70ee35b1/pip_menu
    // Params 2
    // Checksum 0xbd749422, Offset: 0x438
    // Size: 0x44
    function set_showblackscreen( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "showBlackScreen", value );
    }

    // Namespace namespace_70ee35b1/pip_menu
    // Params 0
    // Checksum 0x108b606d, Offset: 0x2a8
    // Size: 0xbc
    function setup_clientfields()
    {
        cluielem::setup_clientfields( "pip_menu" );
        cluielem::function_dcb34c80( "moviefile", "movieName", 1 );
        cluielem::add_clientfield( "showBlackScreen", 1, 1, "int" );
        cluielem::add_clientfield( "looping", 1, 1, "int" );
        cluielem::add_clientfield( "additive", 1, 1, "int" );
    }

}

// Namespace pip_menu/pip_menu
// Params 0
// Checksum 0xc1cbefa7, Offset: 0xf8
// Size: 0x34
function register()
{
    elem = new class_70ee35b1();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace pip_menu/pip_menu
// Params 2
// Checksum 0x3a3edadf, Offset: 0x138
// Size: 0x38
function open( player, persistent = 0 )
{
    [[ self ]]->open( player, persistent );
}

// Namespace pip_menu/pip_menu
// Params 1
// Checksum 0xdd84b28a, Offset: 0x178
// Size: 0x1c
function close( player )
{
    [[ self ]]->close( player );
}

// Namespace pip_menu/pip_menu
// Params 1
// Checksum 0x800f7339, Offset: 0x1a0
// Size: 0x1a
function is_open( player )
{
    return [[ self ]]->function_7bfd10e6( player );
}

// Namespace pip_menu/pip_menu
// Params 2
// Checksum 0x5a30b5d4, Offset: 0x1c8
// Size: 0x28
function set_moviename( player, value )
{
    [[ self ]]->set_moviename( player, value );
}

// Namespace pip_menu/pip_menu
// Params 2
// Checksum 0x4f0f6e9d, Offset: 0x1f8
// Size: 0x28
function set_showblackscreen( player, value )
{
    [[ self ]]->set_showblackscreen( player, value );
}

// Namespace pip_menu/pip_menu
// Params 2
// Checksum 0x9a9dda6d, Offset: 0x228
// Size: 0x28
function set_looping( player, value )
{
    [[ self ]]->set_looping( player, value );
}

// Namespace pip_menu/pip_menu
// Params 2
// Checksum 0x301c4b08, Offset: 0x258
// Size: 0x28
function set_additive( player, value )
{
    [[ self ]]->set_additive( player, value );
}

