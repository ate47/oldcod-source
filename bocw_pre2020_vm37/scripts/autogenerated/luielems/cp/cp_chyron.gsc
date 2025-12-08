#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace cp_chyron;

// Namespace cp_chyron
// Method(s) 11 Total 18
class ccp_chyron : cluielem
{

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace ccp_chyron/cp_chyron
    // Params 2
    // Checksum 0xec38b3a0, Offset: 0x538
    // Size: 0x44
    function function_6b7b6e4( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "line3", value );
    }

    // Namespace ccp_chyron/cp_chyron
    // Params 2
    // Checksum 0xfe61c728, Offset: 0x420
    // Size: 0x3c
    function open( player, persistent = 0 )
    {
        cluielem::open_luielem( player, persistent );
    }

    // Namespace ccp_chyron/cp_chyron
    // Params 2
    // Checksum 0x80a5fd2, Offset: 0x4e8
    // Size: 0x44
    function function_147e5271( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "line2", value );
    }

    // Namespace ccp_chyron/cp_chyron
    // Params 2
    // Checksum 0x43f12de2, Offset: 0x5d8
    // Size: 0x44
    function function_2a377de3( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "line5", value );
    }

    // Namespace ccp_chyron/cp_chyron
    // Params 2
    // Checksum 0x8dcea863, Offset: 0x498
    // Size: 0x44
    function function_4b584028( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "line1", value );
    }

    // Namespace ccp_chyron/cp_chyron
    // Params 1
    // Checksum 0x63579f6c, Offset: 0x468
    // Size: 0x24
    function close( player )
    {
        cluielem::close_luielem( player );
    }

    // Namespace ccp_chyron/cp_chyron
    // Params 2
    // Checksum 0xbd157c15, Offset: 0x628
    // Size: 0x44
    function function_90bde5d3( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "index", value );
    }

    // Namespace ccp_chyron/cp_chyron
    // Params 0
    // Checksum 0x6d71f177, Offset: 0x308
    // Size: 0x10c
    function setup_clientfields()
    {
        cluielem::setup_clientfields( "cp_chyron" );
        cluielem::function_dcb34c80( "string", "line1", 1 );
        cluielem::function_dcb34c80( "string", "line2", 1 );
        cluielem::function_dcb34c80( "string", "line3", 1 );
        cluielem::function_dcb34c80( "string", "line4", 1 );
        cluielem::function_dcb34c80( "string", "line5", 1 );
        cluielem::add_clientfield( "index", 1, 4, "int" );
    }

    // Namespace ccp_chyron/cp_chyron
    // Params 2
    // Checksum 0x3686246f, Offset: 0x588
    // Size: 0x44
    function function_b7f01956( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "line4", value );
    }

}

// Namespace cp_chyron/cp_chyron
// Params 0
// Checksum 0x171459b, Offset: 0xf8
// Size: 0x34
function register()
{
    elem = new ccp_chyron();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace cp_chyron/cp_chyron
// Params 2
// Checksum 0x2d020860, Offset: 0x138
// Size: 0x38
function open( player, persistent = 0 )
{
    [[ self ]]->open( player, persistent );
}

// Namespace cp_chyron/cp_chyron
// Params 1
// Checksum 0xfd201144, Offset: 0x178
// Size: 0x1c
function close( player )
{
    [[ self ]]->close( player );
}

// Namespace cp_chyron/cp_chyron
// Params 1
// Checksum 0xc0142567, Offset: 0x1a0
// Size: 0x1a
function is_open( player )
{
    return [[ self ]]->function_7bfd10e6( player );
}

// Namespace cp_chyron/cp_chyron
// Params 2
// Checksum 0x754460e2, Offset: 0x1c8
// Size: 0x28
function function_4b584028( player, value )
{
    [[ self ]]->function_4b584028( player, value );
}

// Namespace cp_chyron/cp_chyron
// Params 2
// Checksum 0xea8791f4, Offset: 0x1f8
// Size: 0x28
function function_147e5271( player, value )
{
    [[ self ]]->function_147e5271( player, value );
}

// Namespace cp_chyron/cp_chyron
// Params 2
// Checksum 0x619c62fa, Offset: 0x228
// Size: 0x28
function function_6b7b6e4( player, value )
{
    [[ self ]]->function_6b7b6e4( player, value );
}

// Namespace cp_chyron/cp_chyron
// Params 2
// Checksum 0x46554c2b, Offset: 0x258
// Size: 0x28
function function_b7f01956( player, value )
{
    [[ self ]]->function_b7f01956( player, value );
}

// Namespace cp_chyron/cp_chyron
// Params 2
// Checksum 0xa63d71d6, Offset: 0x288
// Size: 0x28
function function_2a377de3( player, value )
{
    [[ self ]]->function_2a377de3( player, value );
}

// Namespace cp_chyron/cp_chyron
// Params 2
// Checksum 0x1bb3a9b4, Offset: 0x2b8
// Size: 0x28
function function_90bde5d3( player, value )
{
    [[ self ]]->function_90bde5d3( player, value );
}

