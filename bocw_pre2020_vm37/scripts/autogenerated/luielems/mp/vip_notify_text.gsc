#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace vip_notify_text;

// Namespace vip_notify_text
// Method(s) 7 Total 14
class class_302a48fc : cluielem
{

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace namespace_302a48fc/vip_notify_text
    // Params 2
    // Checksum 0x47f71525, Offset: 0x2a8
    // Size: 0x3c
    function open( player, persistent = 0 )
    {
        cluielem::open_luielem( player, persistent );
    }

    // Namespace namespace_302a48fc/vip_notify_text
    // Params 1
    // Checksum 0x8182da9a, Offset: 0x2f0
    // Size: 0x24
    function close( player )
    {
        cluielem::close_luielem( player );
    }

    // Namespace namespace_302a48fc/vip_notify_text
    // Params 0
    // Checksum 0xfbff62c0, Offset: 0x230
    // Size: 0x6c
    function setup_clientfields()
    {
        cluielem::setup_clientfields( "vip_notify_text" );
        cluielem::function_dcb34c80( "string", "vipmessage", 1 );
        cluielem::add_clientfield( "alpha", 1, 8, "float" );
    }

    // Namespace namespace_302a48fc/vip_notify_text
    // Params 2
    // Checksum 0x82ef01b6, Offset: 0x370
    // Size: 0x44
    function set_alpha( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "alpha", value );
    }

    // Namespace namespace_302a48fc/vip_notify_text
    // Params 2
    // Checksum 0xbd9f3dae, Offset: 0x320
    // Size: 0x44
    function function_d01a102c( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "vipmessage", value );
    }

}

// Namespace vip_notify_text/vip_notify_text
// Params 0
// Checksum 0x8d56289f, Offset: 0xe0
// Size: 0x34
function register()
{
    elem = new class_302a48fc();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace vip_notify_text/vip_notify_text
// Params 2
// Checksum 0x17ff746, Offset: 0x120
// Size: 0x38
function open( player, persistent = 0 )
{
    [[ self ]]->open( player, persistent );
}

// Namespace vip_notify_text/vip_notify_text
// Params 1
// Checksum 0x1870d62a, Offset: 0x160
// Size: 0x1c
function close( player )
{
    [[ self ]]->close( player );
}

// Namespace vip_notify_text/vip_notify_text
// Params 1
// Checksum 0x4fad5457, Offset: 0x188
// Size: 0x1a
function is_open( player )
{
    return [[ self ]]->function_7bfd10e6( player );
}

// Namespace vip_notify_text/vip_notify_text
// Params 2
// Checksum 0x50838fb7, Offset: 0x1b0
// Size: 0x28
function function_d01a102c( player, value )
{
    [[ self ]]->function_d01a102c( player, value );
}

// Namespace vip_notify_text/vip_notify_text
// Params 2
// Checksum 0xdde4b4c2, Offset: 0x1e0
// Size: 0x28
function set_alpha( player, value )
{
    [[ self ]]->set_alpha( player, value );
}

