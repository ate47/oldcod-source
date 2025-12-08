#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace cp_newsroom;

// Namespace cp_newsroom
// Method(s) 17 Total 24
class class_52d58332 : cluielem
{

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace namespace_52d58332/cp_newsroom
    // Params 2
    // Checksum 0x994d850a, Offset: 0x6d8
    // Size: 0x3c
    function open( player, persistent = 0 )
    {
        cluielem::open_luielem( player, persistent );
    }

    // Namespace namespace_52d58332/cp_newsroom
    // Params 2
    // Checksum 0x2a0ee657, Offset: 0x840
    // Size: 0x44
    function function_41058a0f( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "sceneIndex", value );
    }

    // Namespace namespace_52d58332/cp_newsroom
    // Params 2
    // Checksum 0x8ea51116, Offset: 0x890
    // Size: 0x44
    function function_459cfc57( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "noble.generalNewsIndex", value );
    }

    // Namespace namespace_52d58332/cp_newsroom
    // Params 2
    // Checksum 0xa8994255, Offset: 0x930
    // Size: 0x44
    function function_469781eb( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "noble.offline", value );
    }

    // Namespace namespace_52d58332/cp_newsroom
    // Params 2
    // Checksum 0xc67db6ca, Offset: 0x7f0
    // Size: 0x44
    function function_52b2ec58( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "uns.offline", value );
    }

    // Namespace namespace_52d58332/cp_newsroom
    // Params 1
    // Checksum 0x64057ecf, Offset: 0x720
    // Size: 0x24
    function close( player )
    {
        cluielem::close_luielem( player );
    }

    // Namespace namespace_52d58332/cp_newsroom
    // Params 2
    // Checksum 0x8b5919c4, Offset: 0xa70
    // Size: 0x44
    function function_793d3466( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "torch.offline", value );
    }

    // Namespace namespace_52d58332/cp_newsroom
    // Params 0
    // Checksum 0xe9f9fc15, Offset: 0x4d0
    // Size: 0x1fc
    function setup_clientfields()
    {
        cluielem::setup_clientfields( "cp_newsroom" );
        cluielem::add_clientfield( "channel", 1, 2, "int" );
        cluielem::add_clientfield( "uns.generalNewsIndex", 1, 2, "int" );
        cluielem::add_clientfield( "uns.offline", 1, 1, "int" );
        cluielem::add_clientfield( "sceneIndex", 1, 2, "int" );
        cluielem::add_clientfield( "noble.generalNewsIndex", 1, 2, "int" );
        cluielem::add_clientfield( "noble.imageIndex", 1, 2, "int" );
        cluielem::add_clientfield( "noble.offline", 1, 1, "int" );
        cluielem::add_clientfield( "torch.followers", 1, 7, "int" );
        cluielem::add_clientfield( "torch.subscribers", 1, 7, "int" );
        cluielem::add_clientfield( "torch.donatorIndex", 1, 7, "int" );
        cluielem::add_clientfield( "torch.offline", 1, 1, "int" );
        cluielem::add_clientfield( "torch.breakingNewsAlert", 1, 1, "int" );
    }

    // Namespace namespace_52d58332/cp_newsroom
    // Params 2
    // Checksum 0xfe89559b, Offset: 0x8e0
    // Size: 0x44
    function function_a075150b( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "noble.imageIndex", value );
    }

    // Namespace namespace_52d58332/cp_newsroom
    // Params 2
    // Checksum 0xdec232c5, Offset: 0x7a0
    // Size: 0x44
    function function_a595ec12( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "uns.generalNewsIndex", value );
    }

    // Namespace namespace_52d58332/cp_newsroom
    // Params 2
    // Checksum 0xf002c428, Offset: 0xa20
    // Size: 0x44
    function function_aae350c7( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "torch.donatorIndex", value );
    }

    // Namespace namespace_52d58332/cp_newsroom
    // Params 2
    // Checksum 0x96251a4e, Offset: 0xac0
    // Size: 0x44
    function function_b117c344( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "torch.breakingNewsAlert", value );
    }

    // Namespace namespace_52d58332/cp_newsroom
    // Params 2
    // Checksum 0x980e8eff, Offset: 0x9d0
    // Size: 0x44
    function function_b6328fe2( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "torch.subscribers", value );
    }

    // Namespace namespace_52d58332/cp_newsroom
    // Params 2
    // Checksum 0x37f5ce5f, Offset: 0x750
    // Size: 0x44
    function function_df160ff1( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "channel", value );
    }

    // Namespace namespace_52d58332/cp_newsroom
    // Params 2
    // Checksum 0xdbb8565d, Offset: 0x980
    // Size: 0x44
    function function_e380be6c( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "torch.followers", value );
    }

}

// Namespace cp_newsroom/cp_newsroom
// Params 0
// Checksum 0xae1591a5, Offset: 0x1a0
// Size: 0x34
function register()
{
    elem = new class_52d58332();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace cp_newsroom/cp_newsroom
// Params 2
// Checksum 0x3a3edadf, Offset: 0x1e0
// Size: 0x38
function open( player, persistent = 0 )
{
    [[ self ]]->open( player, persistent );
}

// Namespace cp_newsroom/cp_newsroom
// Params 1
// Checksum 0xdd84b28a, Offset: 0x220
// Size: 0x1c
function close( player )
{
    [[ self ]]->close( player );
}

// Namespace cp_newsroom/cp_newsroom
// Params 1
// Checksum 0x800f7339, Offset: 0x248
// Size: 0x1a
function is_open( player )
{
    return [[ self ]]->function_7bfd10e6( player );
}

// Namespace cp_newsroom/cp_newsroom
// Params 2
// Checksum 0x1d688b71, Offset: 0x270
// Size: 0x28
function function_df160ff1( player, value )
{
    [[ self ]]->function_df160ff1( player, value );
}

// Namespace cp_newsroom/cp_newsroom
// Params 2
// Checksum 0x2bcc15ec, Offset: 0x2a0
// Size: 0x28
function function_a595ec12( player, value )
{
    [[ self ]]->function_a595ec12( player, value );
}

// Namespace cp_newsroom/cp_newsroom
// Params 2
// Checksum 0xc6eda9a3, Offset: 0x2d0
// Size: 0x28
function function_52b2ec58( player, value )
{
    [[ self ]]->function_52b2ec58( player, value );
}

// Namespace cp_newsroom/cp_newsroom
// Params 2
// Checksum 0x65c99ee, Offset: 0x300
// Size: 0x28
function function_41058a0f( player, value )
{
    [[ self ]]->function_41058a0f( player, value );
}

// Namespace cp_newsroom/cp_newsroom
// Params 2
// Checksum 0xe9975bbe, Offset: 0x330
// Size: 0x28
function function_459cfc57( player, value )
{
    [[ self ]]->function_459cfc57( player, value );
}

// Namespace cp_newsroom/cp_newsroom
// Params 2
// Checksum 0xa88ad932, Offset: 0x360
// Size: 0x28
function function_a075150b( player, value )
{
    [[ self ]]->function_a075150b( player, value );
}

// Namespace cp_newsroom/cp_newsroom
// Params 2
// Checksum 0xf18e641b, Offset: 0x390
// Size: 0x28
function function_469781eb( player, value )
{
    [[ self ]]->function_469781eb( player, value );
}

// Namespace cp_newsroom/cp_newsroom
// Params 2
// Checksum 0x8e949e22, Offset: 0x3c0
// Size: 0x28
function function_e380be6c( player, value )
{
    [[ self ]]->function_e380be6c( player, value );
}

// Namespace cp_newsroom/cp_newsroom
// Params 2
// Checksum 0x74f23b5, Offset: 0x3f0
// Size: 0x28
function function_b6328fe2( player, value )
{
    [[ self ]]->function_b6328fe2( player, value );
}

// Namespace cp_newsroom/cp_newsroom
// Params 2
// Checksum 0xae98c6f2, Offset: 0x420
// Size: 0x28
function function_aae350c7( player, value )
{
    [[ self ]]->function_aae350c7( player, value );
}

// Namespace cp_newsroom/cp_newsroom
// Params 2
// Checksum 0x55a18a81, Offset: 0x450
// Size: 0x28
function function_793d3466( player, value )
{
    [[ self ]]->function_793d3466( player, value );
}

// Namespace cp_newsroom/cp_newsroom
// Params 2
// Checksum 0x37d16e7f, Offset: 0x480
// Size: 0x28
function function_b117c344( player, value )
{
    [[ self ]]->function_b117c344( player, value );
}

