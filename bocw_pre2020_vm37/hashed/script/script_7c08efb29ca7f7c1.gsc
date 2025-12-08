#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace stealth_meter_display;

// Namespace stealth_meter_display
// Method(s) 9 Total 16
class class_d4941e5e : cluielem
{

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace namespace_d4941e5e/stealth_meter_display
    // Params 2
    // Checksum 0x424ba4e9, Offset: 0x380
    // Size: 0x3c
    function open( player, persistent = 0 )
    {
        cluielem::open_luielem( player, persistent );
    }

    // Namespace namespace_d4941e5e/stealth_meter_display
    // Params 2
    // Checksum 0x94f0d524, Offset: 0x568
    // Size: 0x44
    function function_4d628707( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "awarenessState", value );
    }

    // Namespace namespace_d4941e5e/stealth_meter_display
    // Params 1
    // Checksum 0x375e4861, Offset: 0x3c8
    // Size: 0x24
    function close( player )
    {
        cluielem::close_luielem( player );
    }

    // Namespace namespace_d4941e5e/stealth_meter_display
    // Params 2
    // Checksum 0x4edaafd4, Offset: 0x5b8
    // Size: 0x44
    function function_7425637b( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "awarenessProgress", value );
    }

    // Namespace namespace_d4941e5e/stealth_meter_display
    // Params 0
    // Checksum 0xb1368035, Offset: 0x2b8
    // Size: 0xbc
    function setup_clientfields()
    {
        cluielem::setup_clientfields( "stealth_meter_display" );
        cluielem::add_clientfield( "_state", 1, 2, "int" );
        cluielem::add_clientfield( "entNum", 1, 10, "int" );
        cluielem::add_clientfield( "awarenessState", 1, 4, "int" );
        cluielem::add_clientfield( "awarenessProgress", 1, 4, "float" );
    }

    // Namespace namespace_d4941e5e/stealth_meter_display
    // Params 2
    // Checksum 0x4fe76eff, Offset: 0x518
    // Size: 0x44
    function set_entnum( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "entNum", value );
    }

    // Namespace namespace_d4941e5e/stealth_meter_display
    // Params 2
    // Checksum 0xd412351f, Offset: 0x3f8
    // Size: 0x114
    function set_state( player, state_name )
    {
        if ( #"defaultstate" == state_name )
        {
            player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "_state", 0 );
            return;
        }
        
        if ( #"hide" == state_name )
        {
            player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "_state", 1 );
            return;
        }
        
        if ( #"show" == state_name )
        {
            player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "_state", 2 );
            return;
        }
        
        assertmsg( "<dev string:x38>" );
    }

}

// Namespace stealth_meter_display/stealth_meter_display
// Params 0
// Checksum 0x8c9f97cf, Offset: 0x108
// Size: 0x34
function register()
{
    elem = new class_d4941e5e();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace stealth_meter_display/stealth_meter_display
// Params 2
// Checksum 0x2d020860, Offset: 0x148
// Size: 0x38
function open( player, persistent = 0 )
{
    [[ self ]]->open( player, persistent );
}

// Namespace stealth_meter_display/stealth_meter_display
// Params 1
// Checksum 0xfd201144, Offset: 0x188
// Size: 0x1c
function close( player )
{
    [[ self ]]->close( player );
}

// Namespace stealth_meter_display/stealth_meter_display
// Params 1
// Checksum 0xc0142567, Offset: 0x1b0
// Size: 0x1a
function is_open( player )
{
    return [[ self ]]->function_7bfd10e6( player );
}

// Namespace stealth_meter_display/stealth_meter_display
// Params 2
// Checksum 0x79874fca, Offset: 0x1d8
// Size: 0x28
function set_state( player, state_name )
{
    [[ self ]]->set_state( player, state_name );
}

// Namespace stealth_meter_display/stealth_meter_display
// Params 2
// Checksum 0x4cd0bf50, Offset: 0x208
// Size: 0x28
function set_entnum( player, value )
{
    [[ self ]]->set_entnum( player, value );
}

// Namespace stealth_meter_display/stealth_meter_display
// Params 2
// Checksum 0xf070a5a, Offset: 0x238
// Size: 0x28
function function_4d628707( player, value )
{
    [[ self ]]->function_4d628707( player, value );
}

// Namespace stealth_meter_display/stealth_meter_display
// Params 2
// Checksum 0x8078ab5e, Offset: 0x268
// Size: 0x28
function function_7425637b( player, value )
{
    [[ self ]]->function_7425637b( player, value );
}

