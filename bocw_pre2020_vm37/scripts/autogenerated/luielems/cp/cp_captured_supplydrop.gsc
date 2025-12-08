#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace cp_captured_supplydrop;

// Namespace cp_captured_supplydrop
// Method(s) 12 Total 19
class class_35ee22bc : cluielem
{

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace namespace_35ee22bc/cp_captured_supplydrop
    // Params 2
    // Checksum 0x8e16f151, Offset: 0x4b8
    // Size: 0x3c
    function open( player, persistent = 0 )
    {
        cluielem::open_luielem( player, persistent );
    }

    // Namespace namespace_35ee22bc/cp_captured_supplydrop
    // Params 2
    // Checksum 0x673572dc, Offset: 0x620
    // Size: 0x44
    function function_16715e9f( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "guardian_count", value );
    }

    // Namespace namespace_35ee22bc/cp_captured_supplydrop
    // Params 2
    // Checksum 0xf86721d0, Offset: 0x6c0
    // Size: 0x44
    function function_191323ee( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "raps_count", value );
    }

    // Namespace namespace_35ee22bc/cp_captured_supplydrop
    // Params 2
    // Checksum 0x740c72b6, Offset: 0x710
    // Size: 0x44
    function function_461034d2( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "selector_state", value );
    }

    // Namespace namespace_35ee22bc/cp_captured_supplydrop
    // Params 1
    // Checksum 0x4c70fa13, Offset: 0x500
    // Size: 0x24
    function close( player )
    {
        cluielem::close_luielem( player );
    }

    // Namespace namespace_35ee22bc/cp_captured_supplydrop
    // Params 2
    // Checksum 0xd28b9edf, Offset: 0x580
    // Size: 0x44
    function function_69d88480( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "wasp_count", value );
    }

    // Namespace namespace_35ee22bc/cp_captured_supplydrop
    // Params 0
    // Checksum 0xbd06f13a, Offset: 0x378
    // Size: 0x134
    function setup_clientfields()
    {
        cluielem::setup_clientfields( "cp_captured_supplydrop" );
        cluielem::add_clientfield( "micromissile_count", 1, 2, "int" );
        cluielem::add_clientfield( "wasp_count", 1, 2, "int" );
        cluielem::add_clientfield( "rcxd_count", 1, 2, "int" );
        cluielem::add_clientfield( "guardian_count", 1, 2, "int" );
        cluielem::add_clientfield( "robot_count", 1, 2, "int" );
        cluielem::add_clientfield( "raps_count", 1, 2, "int" );
        cluielem::add_clientfield( "selector_state", 1, 3, "int" );
    }

    // Namespace namespace_35ee22bc/cp_captured_supplydrop
    // Params 2
    // Checksum 0x4224437b, Offset: 0x670
    // Size: 0x44
    function function_de1ece9c( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "robot_count", value );
    }

    // Namespace namespace_35ee22bc/cp_captured_supplydrop
    // Params 2
    // Checksum 0x620d8cca, Offset: 0x5d0
    // Size: 0x44
    function function_ebe4fe7a( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "rcxd_count", value );
    }

    // Namespace namespace_35ee22bc/cp_captured_supplydrop
    // Params 2
    // Checksum 0x6e4b3682, Offset: 0x530
    // Size: 0x44
    function function_fdfe76bb( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "micromissile_count", value );
    }

}

// Namespace cp_captured_supplydrop/cp_captured_supplydrop
// Params 0
// Checksum 0x41f8df4f, Offset: 0x138
// Size: 0x34
function register()
{
    elem = new class_35ee22bc();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace cp_captured_supplydrop/cp_captured_supplydrop
// Params 2
// Checksum 0x2d020860, Offset: 0x178
// Size: 0x38
function open( player, persistent = 0 )
{
    [[ self ]]->open( player, persistent );
}

// Namespace cp_captured_supplydrop/cp_captured_supplydrop
// Params 1
// Checksum 0xfd201144, Offset: 0x1b8
// Size: 0x1c
function close( player )
{
    [[ self ]]->close( player );
}

// Namespace cp_captured_supplydrop/cp_captured_supplydrop
// Params 1
// Checksum 0xc0142567, Offset: 0x1e0
// Size: 0x1a
function is_open( player )
{
    return [[ self ]]->function_7bfd10e6( player );
}

// Namespace cp_captured_supplydrop/cp_captured_supplydrop
// Params 2
// Checksum 0x4f3a4cdf, Offset: 0x208
// Size: 0x28
function function_fdfe76bb( player, value )
{
    [[ self ]]->function_fdfe76bb( player, value );
}

// Namespace cp_captured_supplydrop/cp_captured_supplydrop
// Params 2
// Checksum 0xdf5265d2, Offset: 0x238
// Size: 0x28
function function_69d88480( player, value )
{
    [[ self ]]->function_69d88480( player, value );
}

// Namespace cp_captured_supplydrop/cp_captured_supplydrop
// Params 2
// Checksum 0x762c8610, Offset: 0x268
// Size: 0x28
function function_ebe4fe7a( player, value )
{
    [[ self ]]->function_ebe4fe7a( player, value );
}

// Namespace cp_captured_supplydrop/cp_captured_supplydrop
// Params 2
// Checksum 0x3abb2a9b, Offset: 0x298
// Size: 0x28
function function_16715e9f( player, value )
{
    [[ self ]]->function_16715e9f( player, value );
}

// Namespace cp_captured_supplydrop/cp_captured_supplydrop
// Params 2
// Checksum 0x5fc705b4, Offset: 0x2c8
// Size: 0x28
function function_de1ece9c( player, value )
{
    [[ self ]]->function_de1ece9c( player, value );
}

// Namespace cp_captured_supplydrop/cp_captured_supplydrop
// Params 2
// Checksum 0x3556e7d4, Offset: 0x2f8
// Size: 0x28
function function_191323ee( player, value )
{
    [[ self ]]->function_191323ee( player, value );
}

// Namespace cp_captured_supplydrop/cp_captured_supplydrop
// Params 2
// Checksum 0xe394d0fd, Offset: 0x328
// Size: 0x28
function function_461034d2( player, value )
{
    [[ self ]]->function_461034d2( player, value );
}

