#using scripts\core_common\lui_shared;

#namespace mp_laststand_client;

// Namespace mp_laststand_client
// Method(s) 8 Total 14
class cmp_laststand_client : cluielem
{

    // Namespace cmp_laststand_client/mp_laststand_client
    // Params 1
    // Checksum 0x5d94ecee, Offset: 0x4c8
    // Size: 0x24
    function open( localclientnum )
    {
        cluielem::open( localclientnum );
    }

    // Namespace cmp_laststand_client/mp_laststand_client
    // Params 0
    // Checksum 0xa28d4dc2, Offset: 0x428
    // Size: 0x1c
    function register_clientside()
    {
        cluielem::register_clientside( "mp_laststand_client" );
    }

    // Namespace cmp_laststand_client/mp_laststand_client
    // Params 2
    // Checksum 0xee35763d, Offset: 0x4f8
    // Size: 0x30
    function set_bleedout_progress( localclientnum, value )
    {
        set_data( localclientnum, "bleedout_progress", value );
    }

    // Namespace cmp_laststand_client/mp_laststand_client
    // Params 2
    // Checksum 0xcdf475f6, Offset: 0x3a0
    // Size: 0x7c
    function setup_clientfields( var_a9a4e140, var_e97e7153 )
    {
        cluielem::setup_clientfields( "mp_laststand_client" );
        cluielem::add_clientfield( "bleedout_progress", 1, 6, "float", var_a9a4e140 );
        cluielem::add_clientfield( "revive_progress", 1, 5, "float", var_e97e7153 );
    }

    // Namespace cmp_laststand_client/mp_laststand_client
    // Params 2
    // Checksum 0x9bc1b714, Offset: 0x530
    // Size: 0x30
    function set_revive_progress( localclientnum, value )
    {
        set_data( localclientnum, "revive_progress", value );
    }

    // Namespace cmp_laststand_client/mp_laststand_client
    // Params 1
    // Checksum 0xb2479dc5, Offset: 0x450
    // Size: 0x6c
    function function_fa582112( localclientnum )
    {
        cluielem::function_fa582112( localclientnum );
        set_data( localclientnum, "bleedout_progress", 0 );
        set_data( localclientnum, "revive_progress", 0 );
    }

}

// Namespace mp_laststand_client/mp_laststand_client
// Params 2
// Checksum 0x5304a0fc, Offset: 0xe0
// Size: 0x17e
function register( var_a9a4e140, var_e97e7153 )
{
    elem = new cmp_laststand_client();
    [[ elem ]]->setup_clientfields( var_a9a4e140, var_e97e7153 );
    
    if ( !isdefined( level.var_ae746e8f ) )
    {
        level.var_ae746e8f = associativearray();
    }
    
    if ( !isdefined( level.var_ae746e8f[ #"mp_laststand_client" ] ) )
    {
        level.var_ae746e8f[ #"mp_laststand_client" ] = [];
    }
    
    if ( !isdefined( level.var_ae746e8f[ #"mp_laststand_client" ] ) )
    {
        level.var_ae746e8f[ #"mp_laststand_client" ] = [];
    }
    else if ( !isarray( level.var_ae746e8f[ #"mp_laststand_client" ] ) )
    {
        level.var_ae746e8f[ #"mp_laststand_client" ] = array( level.var_ae746e8f[ #"mp_laststand_client" ] );
    }
    
    level.var_ae746e8f[ #"mp_laststand_client" ][ level.var_ae746e8f[ #"mp_laststand_client" ].size ] = elem;
}

// Namespace mp_laststand_client/mp_laststand_client
// Params 0
// Checksum 0xaa5fdd2c, Offset: 0x268
// Size: 0x34
function register_clientside()
{
    elem = new cmp_laststand_client();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace mp_laststand_client/mp_laststand_client
// Params 1
// Checksum 0x19e6ac63, Offset: 0x2a8
// Size: 0x1c
function open( player )
{
    [[ self ]]->open( player );
}

// Namespace mp_laststand_client/mp_laststand_client
// Params 1
// Checksum 0x6bcdcf45, Offset: 0x2d0
// Size: 0x1c
function close( player )
{
    [[ self ]]->close( player );
}

// Namespace mp_laststand_client/mp_laststand_client
// Params 1
// Checksum 0x4973a5d3, Offset: 0x2f8
// Size: 0x1a
function is_open( localclientnum )
{
    return [[ self ]]->is_open( localclientnum );
}

// Namespace mp_laststand_client/mp_laststand_client
// Params 2
// Checksum 0x4a5a7b11, Offset: 0x320
// Size: 0x28
function set_bleedout_progress( localclientnum, value )
{
    [[ self ]]->set_bleedout_progress( localclientnum, value );
}

// Namespace mp_laststand_client/mp_laststand_client
// Params 2
// Checksum 0x879f0859, Offset: 0x350
// Size: 0x28
function set_revive_progress( localclientnum, value )
{
    [[ self ]]->set_revive_progress( localclientnum, value );
}

