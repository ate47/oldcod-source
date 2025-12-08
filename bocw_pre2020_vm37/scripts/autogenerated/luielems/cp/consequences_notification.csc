#using scripts\core_common\lui_shared;

#namespace consequences_notification;

// Namespace consequences_notification
// Method(s) 8 Total 14
class class_c3742963 : cluielem
{

    // Namespace namespace_c3742963/consequences_notification
    // Params 1
    // Checksum 0xd0a5dab8, Offset: 0x4b0
    // Size: 0x24
    function open( localclientnum )
    {
        cluielem::open( localclientnum );
    }

    // Namespace namespace_c3742963/consequences_notification
    // Params 0
    // Checksum 0xa28d4dc2, Offset: 0x420
    // Size: 0x1c
    function register_clientside()
    {
        cluielem::register_clientside( "consequences_notification" );
    }

    // Namespace namespace_c3742963/consequences_notification
    // Params 2
    // Checksum 0xea6f3cf0, Offset: 0x398
    // Size: 0x7c
    function setup_clientfields( var_6ad1a3bb, var_b8233aa2 )
    {
        cluielem::setup_clientfields( "consequences_notification" );
        cluielem::add_clientfield( "visible", 1, 1, "int", var_6ad1a3bb );
        cluielem::add_clientfield( "content_index", 1, 4, "int", var_b8233aa2 );
    }

    // Namespace namespace_c3742963/consequences_notification
    // Params 2
    // Checksum 0x3430899a, Offset: 0x518
    // Size: 0x30
    function function_afdd9f65( localclientnum, value )
    {
        set_data( localclientnum, "content_index", value );
    }

    // Namespace namespace_c3742963/consequences_notification
    // Params 2
    // Checksum 0xe40418fb, Offset: 0x4e0
    // Size: 0x30
    function set_visible( localclientnum, value )
    {
        set_data( localclientnum, "visible", value );
    }

    // Namespace namespace_c3742963/consequences_notification
    // Params 1
    // Checksum 0xee5f944b, Offset: 0x448
    // Size: 0x5c
    function function_fa582112( localclientnum )
    {
        cluielem::function_fa582112( localclientnum );
        set_data( localclientnum, "visible", 0 );
        set_data( localclientnum, "content_index", 0 );
    }

}

// Namespace consequences_notification/consequences_notification
// Params 2
// Checksum 0xcecb0e52, Offset: 0xd8
// Size: 0x17e
function register( var_6ad1a3bb, var_b8233aa2 )
{
    elem = new class_c3742963();
    [[ elem ]]->setup_clientfields( var_6ad1a3bb, var_b8233aa2 );
    
    if ( !isdefined( level.var_ae746e8f ) )
    {
        level.var_ae746e8f = associativearray();
    }
    
    if ( !isdefined( level.var_ae746e8f[ #"consequences_notification" ] ) )
    {
        level.var_ae746e8f[ #"consequences_notification" ] = [];
    }
    
    if ( !isdefined( level.var_ae746e8f[ #"consequences_notification" ] ) )
    {
        level.var_ae746e8f[ #"consequences_notification" ] = [];
    }
    else if ( !isarray( level.var_ae746e8f[ #"consequences_notification" ] ) )
    {
        level.var_ae746e8f[ #"consequences_notification" ] = array( level.var_ae746e8f[ #"consequences_notification" ] );
    }
    
    level.var_ae746e8f[ #"consequences_notification" ][ level.var_ae746e8f[ #"consequences_notification" ].size ] = elem;
}

// Namespace consequences_notification/consequences_notification
// Params 0
// Checksum 0xaee7b544, Offset: 0x260
// Size: 0x34
function register_clientside()
{
    elem = new class_c3742963();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace consequences_notification/consequences_notification
// Params 1
// Checksum 0x19e6ac63, Offset: 0x2a0
// Size: 0x1c
function open( player )
{
    [[ self ]]->open( player );
}

// Namespace consequences_notification/consequences_notification
// Params 1
// Checksum 0x6bcdcf45, Offset: 0x2c8
// Size: 0x1c
function close( player )
{
    [[ self ]]->close( player );
}

// Namespace consequences_notification/consequences_notification
// Params 1
// Checksum 0x4973a5d3, Offset: 0x2f0
// Size: 0x1a
function is_open( localclientnum )
{
    return [[ self ]]->is_open( localclientnum );
}

// Namespace consequences_notification/consequences_notification
// Params 2
// Checksum 0x4220c172, Offset: 0x318
// Size: 0x28
function set_visible( localclientnum, value )
{
    [[ self ]]->set_visible( localclientnum, value );
}

// Namespace consequences_notification/consequences_notification
// Params 2
// Checksum 0xbc0bb9d6, Offset: 0x348
// Size: 0x28
function function_afdd9f65( localclientnum, value )
{
    [[ self ]]->function_afdd9f65( localclientnum, value );
}

