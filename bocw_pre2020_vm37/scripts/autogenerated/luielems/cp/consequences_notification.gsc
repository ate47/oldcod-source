#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace consequences_notification;

// Namespace consequences_notification
// Method(s) 7 Total 14
class class_c3742963 : cluielem
{

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace namespace_c3742963/consequences_notification
    // Params 2
    // Checksum 0xa82881d4, Offset: 0x590
    // Size: 0x3c
    function open( player, persistent = 0 )
    {
        cluielem::open_luielem( player, persistent );
    }

    // Namespace namespace_c3742963/consequences_notification
    // Params 1
    // Checksum 0x4b589ee5, Offset: 0x5d8
    // Size: 0x24
    function close( player )
    {
        cluielem::close_luielem( player );
    }

    // Namespace namespace_c3742963/consequences_notification
    // Params 0
    // Checksum 0xbe837536, Offset: 0x518
    // Size: 0x6c
    function setup_clientfields()
    {
        cluielem::setup_clientfields( "consequences_notification" );
        cluielem::add_clientfield( "visible", 1, 1, "int" );
        cluielem::add_clientfield( "content_index", 1, 4, "int" );
    }

    // Namespace namespace_c3742963/consequences_notification
    // Params 2
    // Checksum 0xb9d124e1, Offset: 0x658
    // Size: 0x44
    function function_afdd9f65( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "content_index", value );
    }

    // Namespace namespace_c3742963/consequences_notification
    // Params 2
    // Checksum 0x8809e2ca, Offset: 0x608
    // Size: 0x44
    function set_visible( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "visible", value );
    }

}

// Namespace consequences_notification/consequences_notification
// Params 2
// Checksum 0x7b215d3e, Offset: 0xe0
// Size: 0x64
function function_aa7a37a1( player, index )
{
    if ( ![[ self ]]->function_7bfd10e6( player ) )
    {
        [[ self ]]->open( player );
    }
    
    [[ self ]]->function_afdd9f65( player, index );
    [[ self ]]->set_visible( player, 1 );
}

// Namespace consequences_notification/consequences_notification
// Params 2
// Checksum 0x9ca8160b, Offset: 0x150
// Size: 0x88
function function_78a5981a( player, ref )
{
    if ( ![[ self ]]->function_7bfd10e6( player ) )
    {
        [[ self ]]->open( player );
    }
    
    var_445570c4 = [[ self ]]->function_cd2efd2d( player, ref );
    
    if ( var_445570c4 )
    {
        [[ self ]]->set_visible( player, 1 );
        return;
    }
    
    [[ self ]]->close( player );
}

// Namespace consequences_notification/consequences_notification
// Params 1
// Checksum 0xc57664a4, Offset: 0x1e0
// Size: 0x44
function function_d27ad9da( player )
{
    if ( [[ self ]]->function_7bfd10e6( player ) )
    {
        [[ self ]]->set_visible( player, 0 );
        [[ self ]]->close( player );
    }
}

// Namespace consequences_notification/consequences_notification
// Params 2
// Checksum 0x2abfcc7c, Offset: 0x230
// Size: 0x10c, Type: bool
function function_cd2efd2d( player, ref )
{
    field = getmapfields();
    
    if ( isdefined( field ) && isdefined( field.var_2f3c2756 ) )
    {
        index = 0;
        var_b7c59076 = getscriptbundlelist( field.var_2f3c2756 );
        
        foreach ( var_773e2a17 in var_b7c59076 )
        {
            if ( var_773e2a17 == ref )
            {
                [[ self ]]->function_afdd9f65( player, index );
                return true;
            }
            
            index++;
        }
    }
    
    return false;
}

// Namespace consequences_notification/consequences_notification
// Params 1
// Checksum 0xf04ed33e, Offset: 0x348
// Size: 0x78
function function_d9ee11d6( *player )
{
    field = getmapfields();
    
    if ( isdefined( field ) && isdefined( field.var_2f3c2756 ) )
    {
        var_b7c59076 = getscriptbundlelist( field.var_2f3c2756 );
        
        if ( isdefined( var_b7c59076 ) )
        {
            return var_b7c59076.size;
        }
    }
    
    return undefined;
}

// Namespace consequences_notification/consequences_notification
// Params 0
// Checksum 0x47dd7fdd, Offset: 0x3c8
// Size: 0x34
function register()
{
    elem = new class_c3742963();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace consequences_notification/consequences_notification
// Params 2
// Checksum 0x7dc6c73a, Offset: 0x408
// Size: 0x38
function open( player, persistent = 0 )
{
    [[ self ]]->open( player, persistent );
}

// Namespace consequences_notification/consequences_notification
// Params 1
// Checksum 0x8c45bca4, Offset: 0x448
// Size: 0x1c
function close( player )
{
    [[ self ]]->close( player );
}

// Namespace consequences_notification/consequences_notification
// Params 1
// Checksum 0x1d78dd38, Offset: 0x470
// Size: 0x1a
function is_open( player )
{
    return [[ self ]]->function_7bfd10e6( player );
}

// Namespace consequences_notification/consequences_notification
// Params 2
// Checksum 0x594d9262, Offset: 0x498
// Size: 0x28
function set_visible( player, value )
{
    [[ self ]]->set_visible( player, value );
}

// Namespace consequences_notification/consequences_notification
// Params 2
// Checksum 0x5d08f8a3, Offset: 0x4c8
// Size: 0x28
function function_afdd9f65( player, value )
{
    [[ self ]]->function_afdd9f65( player, value );
}

