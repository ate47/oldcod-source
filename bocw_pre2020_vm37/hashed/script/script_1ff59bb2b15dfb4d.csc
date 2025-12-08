#using scripts\core_common\lui_shared;

#namespace stealth_meter_display;

// Namespace stealth_meter_display
// Method(s) 10 Total 16
class class_d4941e5e : cluielem
{

    // Namespace namespace_d4941e5e/stealth_meter_display
    // Params 1
    // Checksum 0xe8bac690, Offset: 0x5e0
    // Size: 0x24
    function open( localclientnum )
    {
        cluielem::open( localclientnum );
    }

    // Namespace namespace_d4941e5e/stealth_meter_display
    // Params 2
    // Checksum 0x39ae998e, Offset: 0x738
    // Size: 0x30
    function function_4d628707( localclientnum, value )
    {
        set_data( localclientnum, "awarenessState", value );
    }

    // Namespace namespace_d4941e5e/stealth_meter_display
    // Params 0
    // Checksum 0x6b2edf44, Offset: 0x510
    // Size: 0x1c
    function register_clientside()
    {
        cluielem::register_clientside( "stealth_meter_display" );
    }

    // Namespace namespace_d4941e5e/stealth_meter_display
    // Params 2
    // Checksum 0x872937e, Offset: 0x770
    // Size: 0x30
    function function_7425637b( localclientnum, value )
    {
        set_data( localclientnum, "awarenessProgress", value );
    }

    // Namespace namespace_d4941e5e/stealth_meter_display
    // Params 3
    // Checksum 0x534fda6a, Offset: 0x430
    // Size: 0xd4
    function setup_clientfields( var_5a7b4b38, var_579b061b, var_f10a04a3 )
    {
        cluielem::setup_clientfields( "stealth_meter_display" );
        cluielem::add_clientfield( "_state", 1, 2, "int" );
        cluielem::add_clientfield( "entNum", 1, 10, "int", var_5a7b4b38 );
        cluielem::add_clientfield( "awarenessState", 1, 4, "int", var_579b061b );
        cluielem::add_clientfield( "awarenessProgress", 1, 4, "float", var_f10a04a3 );
    }

    // Namespace namespace_d4941e5e/stealth_meter_display
    // Params 2
    // Checksum 0x90158287, Offset: 0x700
    // Size: 0x30
    function set_entnum( localclientnum, value )
    {
        set_data( localclientnum, "entNum", value );
    }

    // Namespace namespace_d4941e5e/stealth_meter_display
    // Params 2
    // Checksum 0x9af6807f, Offset: 0x610
    // Size: 0xe4
    function set_state( localclientnum, state_name )
    {
        if ( #"defaultstate" == state_name )
        {
            set_data( localclientnum, "_state", 0 );
            return;
        }
        
        if ( #"hide" == state_name )
        {
            set_data( localclientnum, "_state", 1 );
            return;
        }
        
        if ( #"show" == state_name )
        {
            set_data( localclientnum, "_state", 2 );
            return;
        }
        
        assertmsg( "<dev string:x38>" );
    }

    // Namespace namespace_d4941e5e/stealth_meter_display
    // Params 1
    // Checksum 0x6214bff7, Offset: 0x538
    // Size: 0xa0
    function function_fa582112( localclientnum )
    {
        cluielem::function_fa582112( localclientnum );
        set_state( localclientnum, #"defaultstate" );
        set_data( localclientnum, "entNum", 0 );
        set_data( localclientnum, "awarenessState", 0 );
        set_data( localclientnum, "awarenessProgress", 0 );
    }

}

// Namespace stealth_meter_display/stealth_meter_display
// Params 3
// Checksum 0x1ce57a01, Offset: 0x100
// Size: 0x18e
function register( var_5a7b4b38, var_579b061b, var_f10a04a3 )
{
    elem = new class_d4941e5e();
    [[ elem ]]->setup_clientfields( var_5a7b4b38, var_579b061b, var_f10a04a3 );
    
    if ( !isdefined( level.var_ae746e8f ) )
    {
        level.var_ae746e8f = associativearray();
    }
    
    if ( !isdefined( level.var_ae746e8f[ #"stealth_meter_display" ] ) )
    {
        level.var_ae746e8f[ #"stealth_meter_display" ] = [];
    }
    
    if ( !isdefined( level.var_ae746e8f[ #"stealth_meter_display" ] ) )
    {
        level.var_ae746e8f[ #"stealth_meter_display" ] = [];
    }
    else if ( !isarray( level.var_ae746e8f[ #"stealth_meter_display" ] ) )
    {
        level.var_ae746e8f[ #"stealth_meter_display" ] = array( level.var_ae746e8f[ #"stealth_meter_display" ] );
    }
    
    level.var_ae746e8f[ #"stealth_meter_display" ][ level.var_ae746e8f[ #"stealth_meter_display" ].size ] = elem;
}

// Namespace stealth_meter_display/stealth_meter_display
// Params 0
// Checksum 0xb5564d5a, Offset: 0x298
// Size: 0x34
function register_clientside()
{
    elem = new class_d4941e5e();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace stealth_meter_display/stealth_meter_display
// Params 1
// Checksum 0x395354d9, Offset: 0x2d8
// Size: 0x1c
function open( player )
{
    [[ self ]]->open( player );
}

// Namespace stealth_meter_display/stealth_meter_display
// Params 1
// Checksum 0xfc4683e5, Offset: 0x300
// Size: 0x1c
function close( player )
{
    [[ self ]]->close( player );
}

// Namespace stealth_meter_display/stealth_meter_display
// Params 1
// Checksum 0x36c15cfa, Offset: 0x328
// Size: 0x1a
function is_open( localclientnum )
{
    return [[ self ]]->is_open( localclientnum );
}

// Namespace stealth_meter_display/stealth_meter_display
// Params 2
// Checksum 0xa52ac854, Offset: 0x350
// Size: 0x28
function set_state( localclientnum, state_name )
{
    [[ self ]]->set_state( localclientnum, state_name );
}

// Namespace stealth_meter_display/stealth_meter_display
// Params 2
// Checksum 0xd5716a9, Offset: 0x380
// Size: 0x28
function set_entnum( localclientnum, value )
{
    [[ self ]]->set_entnum( localclientnum, value );
}

// Namespace stealth_meter_display/stealth_meter_display
// Params 2
// Checksum 0xcea55b3a, Offset: 0x3b0
// Size: 0x28
function function_4d628707( localclientnum, value )
{
    [[ self ]]->function_4d628707( localclientnum, value );
}

// Namespace stealth_meter_display/stealth_meter_display
// Params 2
// Checksum 0x4894a1ad, Offset: 0x3e0
// Size: 0x28
function function_7425637b( localclientnum, value )
{
    [[ self ]]->function_7425637b( localclientnum, value );
}

