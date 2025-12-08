#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace cp_hint_text;

// Namespace cp_hint_text
// Method(s) 9 Total 16
class class_ab111f2c : cluielem
{

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace namespace_ab111f2c/cp_hint_text
    // Params 2
    // Checksum 0x407cc37d, Offset: 0x360
    // Size: 0x3c
    function open( player, persistent = 0 )
    {
        cluielem::open_luielem( player, persistent );
    }

    // Namespace namespace_ab111f2c/cp_hint_text
    // Params 1
    // Checksum 0x72ede0e7, Offset: 0x470
    // Size: 0x3c
    function function_1c78fe1e( player )
    {
        player clientfield::function_bb878fc3( var_d5213cbb, var_bf9c8c95, "fadeout" );
    }

    // Namespace namespace_ab111f2c/cp_hint_text
    // Params 1
    // Checksum 0x1f739d0f, Offset: 0x3a8
    // Size: 0x24
    function close( player )
    {
        cluielem::close_luielem( player );
    }

    // Namespace namespace_ab111f2c/cp_hint_text
    // Params 1
    // Checksum 0xbba5dc27, Offset: 0x428
    // Size: 0x3c
    function function_64d95cad( player )
    {
        player clientfield::function_bb878fc3( var_d5213cbb, var_bf9c8c95, "display_blink" );
    }

    // Namespace namespace_ab111f2c/cp_hint_text
    // Params 0
    // Checksum 0x97c62adf, Offset: 0x298
    // Size: 0xbc
    function setup_clientfields()
    {
        cluielem::setup_clientfields( "cp_hint_text" );
        cluielem::function_dcb34c80( "string", "hint_text", 1 );
        cluielem::add_clientfield( "display_blink", 1, 1, "counter" );
        cluielem::add_clientfield( "fadeout", 1, 1, "counter" );
        cluielem::add_clientfield( "display_noblink", 1, 1, "counter" );
    }

    // Namespace namespace_ab111f2c/cp_hint_text
    // Params 2
    // Checksum 0x99735a4b, Offset: 0x3d8
    // Size: 0x44
    function function_a16f86c1( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "hint_text", value );
    }

    // Namespace namespace_ab111f2c/cp_hint_text
    // Params 1
    // Checksum 0xb0078c3f, Offset: 0x4b8
    // Size: 0x3c
    function function_a981d6b6( player )
    {
        player clientfield::function_bb878fc3( var_d5213cbb, var_bf9c8c95, "display_noblink" );
    }

}

// Namespace cp_hint_text/cp_hint_text
// Params 0
// Checksum 0xd028ca9f, Offset: 0x100
// Size: 0x34
function register()
{
    elem = new class_ab111f2c();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace cp_hint_text/cp_hint_text
// Params 2
// Checksum 0xca2e1c40, Offset: 0x140
// Size: 0x38
function open( player, persistent = 0 )
{
    [[ self ]]->open( player, persistent );
}

// Namespace cp_hint_text/cp_hint_text
// Params 1
// Checksum 0x7c7778f0, Offset: 0x180
// Size: 0x1c
function close( player )
{
    [[ self ]]->close( player );
}

// Namespace cp_hint_text/cp_hint_text
// Params 1
// Checksum 0xa2ef2991, Offset: 0x1a8
// Size: 0x1a
function is_open( player )
{
    return [[ self ]]->function_7bfd10e6( player );
}

// Namespace cp_hint_text/cp_hint_text
// Params 2
// Checksum 0xca9752b6, Offset: 0x1d0
// Size: 0x28
function function_a16f86c1( player, value )
{
    [[ self ]]->function_a16f86c1( player, value );
}

// Namespace cp_hint_text/cp_hint_text
// Params 1
// Checksum 0xc54b84b, Offset: 0x200
// Size: 0x1c
function function_64d95cad( player )
{
    [[ self ]]->function_64d95cad( player );
}

// Namespace cp_hint_text/cp_hint_text
// Params 1
// Checksum 0xf1a459b, Offset: 0x228
// Size: 0x1c
function function_1c78fe1e( player )
{
    [[ self ]]->function_1c78fe1e( player );
}

// Namespace cp_hint_text/cp_hint_text
// Params 1
// Checksum 0xcf668efa, Offset: 0x250
// Size: 0x1c
function function_a981d6b6( player )
{
    [[ self ]]->function_a981d6b6( player );
}

