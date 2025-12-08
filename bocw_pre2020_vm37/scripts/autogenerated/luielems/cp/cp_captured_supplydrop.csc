#using scripts\core_common\lui_shared;

#namespace cp_captured_supplydrop;

// Namespace cp_captured_supplydrop
// Method(s) 13 Total 19
class class_35ee22bc : cluielem
{

    // Namespace namespace_35ee22bc/cp_captured_supplydrop
    // Params 1
    // Checksum 0xbe9bc03c, Offset: 0x7a8
    // Size: 0x24
    function open( localclientnum )
    {
        cluielem::open( localclientnum );
    }

    // Namespace namespace_35ee22bc/cp_captured_supplydrop
    // Params 2
    // Checksum 0x945e3dbd, Offset: 0x880
    // Size: 0x30
    function function_16715e9f( localclientnum, value )
    {
        set_data( localclientnum, "guardian_count", value );
    }

    // Namespace namespace_35ee22bc/cp_captured_supplydrop
    // Params 2
    // Checksum 0x7e62c3f0, Offset: 0x8f0
    // Size: 0x30
    function function_191323ee( localclientnum, value )
    {
        set_data( localclientnum, "raps_count", value );
    }

    // Namespace namespace_35ee22bc/cp_captured_supplydrop
    // Params 2
    // Checksum 0x18090eb8, Offset: 0x928
    // Size: 0x30
    function function_461034d2( localclientnum, value )
    {
        set_data( localclientnum, "selector_state", value );
    }

    // Namespace namespace_35ee22bc/cp_captured_supplydrop
    // Params 0
    // Checksum 0x39c52b5b, Offset: 0x690
    // Size: 0x1c
    function register_clientside()
    {
        cluielem::register_clientside( "cp_captured_supplydrop" );
    }

    // Namespace namespace_35ee22bc/cp_captured_supplydrop
    // Params 2
    // Checksum 0x556faae5, Offset: 0x810
    // Size: 0x30
    function function_69d88480( localclientnum, value )
    {
        set_data( localclientnum, "wasp_count", value );
    }

    // Namespace namespace_35ee22bc/cp_captured_supplydrop
    // Params 7
    // Checksum 0x31c6b1f1, Offset: 0x518
    // Size: 0x16c
    function setup_clientfields( var_e4f88108, var_a5022382, var_cad0ba31, var_dc5e3aea, var_efc8a38a, var_28bdc188, var_61794ad8 )
    {
        cluielem::setup_clientfields( "cp_captured_supplydrop" );
        cluielem::add_clientfield( "micromissile_count", 1, 2, "int", var_e4f88108 );
        cluielem::add_clientfield( "wasp_count", 1, 2, "int", var_a5022382 );
        cluielem::add_clientfield( "rcxd_count", 1, 2, "int", var_cad0ba31 );
        cluielem::add_clientfield( "guardian_count", 1, 2, "int", var_dc5e3aea );
        cluielem::add_clientfield( "robot_count", 1, 2, "int", var_efc8a38a );
        cluielem::add_clientfield( "raps_count", 1, 2, "int", var_28bdc188 );
        cluielem::add_clientfield( "selector_state", 1, 3, "int", var_61794ad8 );
    }

    // Namespace namespace_35ee22bc/cp_captured_supplydrop
    // Params 2
    // Checksum 0x60dac5de, Offset: 0x8b8
    // Size: 0x30
    function function_de1ece9c( localclientnum, value )
    {
        set_data( localclientnum, "robot_count", value );
    }

    // Namespace namespace_35ee22bc/cp_captured_supplydrop
    // Params 2
    // Checksum 0x2cf1e470, Offset: 0x848
    // Size: 0x30
    function function_ebe4fe7a( localclientnum, value )
    {
        set_data( localclientnum, "rcxd_count", value );
    }

    // Namespace namespace_35ee22bc/cp_captured_supplydrop
    // Params 1
    // Checksum 0x2891a362, Offset: 0x6b8
    // Size: 0xe8
    function function_fa582112( localclientnum )
    {
        cluielem::function_fa582112( localclientnum );
        set_data( localclientnum, "micromissile_count", 0 );
        set_data( localclientnum, "wasp_count", 0 );
        set_data( localclientnum, "rcxd_count", 0 );
        set_data( localclientnum, "guardian_count", 0 );
        set_data( localclientnum, "robot_count", 0 );
        set_data( localclientnum, "raps_count", 0 );
        set_data( localclientnum, "selector_state", 0 );
    }

    // Namespace namespace_35ee22bc/cp_captured_supplydrop
    // Params 2
    // Checksum 0xdcf23943, Offset: 0x7d8
    // Size: 0x30
    function function_fdfe76bb( localclientnum, value )
    {
        set_data( localclientnum, "micromissile_count", value );
    }

}

// Namespace cp_captured_supplydrop/cp_captured_supplydrop
// Params 7
// Checksum 0x6b809d5f, Offset: 0x130
// Size: 0x1b6
function register( var_e4f88108, var_a5022382, var_cad0ba31, var_dc5e3aea, var_efc8a38a, var_28bdc188, var_61794ad8 )
{
    elem = new class_35ee22bc();
    [[ elem ]]->setup_clientfields( var_e4f88108, var_a5022382, var_cad0ba31, var_dc5e3aea, var_efc8a38a, var_28bdc188, var_61794ad8 );
    
    if ( !isdefined( level.var_ae746e8f ) )
    {
        level.var_ae746e8f = associativearray();
    }
    
    if ( !isdefined( level.var_ae746e8f[ #"cp_captured_supplydrop" ] ) )
    {
        level.var_ae746e8f[ #"cp_captured_supplydrop" ] = [];
    }
    
    if ( !isdefined( level.var_ae746e8f[ #"cp_captured_supplydrop" ] ) )
    {
        level.var_ae746e8f[ #"cp_captured_supplydrop" ] = [];
    }
    else if ( !isarray( level.var_ae746e8f[ #"cp_captured_supplydrop" ] ) )
    {
        level.var_ae746e8f[ #"cp_captured_supplydrop" ] = array( level.var_ae746e8f[ #"cp_captured_supplydrop" ] );
    }
    
    level.var_ae746e8f[ #"cp_captured_supplydrop" ][ level.var_ae746e8f[ #"cp_captured_supplydrop" ].size ] = elem;
}

// Namespace cp_captured_supplydrop/cp_captured_supplydrop
// Params 0
// Checksum 0xa65b00e4, Offset: 0x2f0
// Size: 0x34
function register_clientside()
{
    elem = new class_35ee22bc();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace cp_captured_supplydrop/cp_captured_supplydrop
// Params 1
// Checksum 0xf997ee5a, Offset: 0x330
// Size: 0x1c
function open( player )
{
    [[ self ]]->open( player );
}

// Namespace cp_captured_supplydrop/cp_captured_supplydrop
// Params 1
// Checksum 0xfe936882, Offset: 0x358
// Size: 0x1c
function close( player )
{
    [[ self ]]->close( player );
}

// Namespace cp_captured_supplydrop/cp_captured_supplydrop
// Params 1
// Checksum 0x2ad93c7f, Offset: 0x380
// Size: 0x1a
function is_open( localclientnum )
{
    return [[ self ]]->is_open( localclientnum );
}

// Namespace cp_captured_supplydrop/cp_captured_supplydrop
// Params 2
// Checksum 0x931d41da, Offset: 0x3a8
// Size: 0x28
function function_fdfe76bb( localclientnum, value )
{
    [[ self ]]->function_fdfe76bb( localclientnum, value );
}

// Namespace cp_captured_supplydrop/cp_captured_supplydrop
// Params 2
// Checksum 0x50e96b85, Offset: 0x3d8
// Size: 0x28
function function_69d88480( localclientnum, value )
{
    [[ self ]]->function_69d88480( localclientnum, value );
}

// Namespace cp_captured_supplydrop/cp_captured_supplydrop
// Params 2
// Checksum 0xb788727e, Offset: 0x408
// Size: 0x28
function function_ebe4fe7a( localclientnum, value )
{
    [[ self ]]->function_ebe4fe7a( localclientnum, value );
}

// Namespace cp_captured_supplydrop/cp_captured_supplydrop
// Params 2
// Checksum 0xb392ea92, Offset: 0x438
// Size: 0x28
function function_16715e9f( localclientnum, value )
{
    [[ self ]]->function_16715e9f( localclientnum, value );
}

// Namespace cp_captured_supplydrop/cp_captured_supplydrop
// Params 2
// Checksum 0xefcc8b63, Offset: 0x468
// Size: 0x28
function function_de1ece9c( localclientnum, value )
{
    [[ self ]]->function_de1ece9c( localclientnum, value );
}

// Namespace cp_captured_supplydrop/cp_captured_supplydrop
// Params 2
// Checksum 0x83c9a280, Offset: 0x498
// Size: 0x28
function function_191323ee( localclientnum, value )
{
    [[ self ]]->function_191323ee( localclientnum, value );
}

// Namespace cp_captured_supplydrop/cp_captured_supplydrop
// Params 2
// Checksum 0xe982a08a, Offset: 0x4c8
// Size: 0x28
function function_461034d2( localclientnum, value )
{
    [[ self ]]->function_461034d2( localclientnum, value );
}

