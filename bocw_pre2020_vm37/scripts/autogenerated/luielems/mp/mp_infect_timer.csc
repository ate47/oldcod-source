#using scripts\core_common\lui_shared;

#namespace mp_infect_timer;

// Namespace mp_infect_timer
// Method(s) 7 Total 13
class cmp_infect_timer : cluielem
{

    // Namespace cmp_infect_timer/mp_infect_timer
    // Params 1
    // Checksum 0x241273f0, Offset: 0x420
    // Size: 0x24
    function open( localclientnum )
    {
        cluielem::open( localclientnum );
    }

    // Namespace cmp_infect_timer/mp_infect_timer
    // Params 0
    // Checksum 0x4a4c063c, Offset: 0x3b0
    // Size: 0x1c
    function register_clientside()
    {
        cluielem::register_clientside( "mp_infect_timer" );
    }

    // Namespace cmp_infect_timer/mp_infect_timer
    // Params 2
    // Checksum 0x52189eb5, Offset: 0x450
    // Size: 0x30
    function function_8c8674a4( localclientnum, value )
    {
        set_data( localclientnum, "infectionTimeRemaining", value );
    }

    // Namespace cmp_infect_timer/mp_infect_timer
    // Params 1
    // Checksum 0x663df30f, Offset: 0x358
    // Size: 0x4c
    function setup_clientfields( var_7682811d )
    {
        cluielem::setup_clientfields( "mp_infect_timer" );
        cluielem::add_clientfield( "infectionTimeRemaining", 1, 4, "int", var_7682811d );
    }

    // Namespace cmp_infect_timer/mp_infect_timer
    // Params 1
    // Checksum 0xb08a3b09, Offset: 0x3d8
    // Size: 0x40
    function function_fa582112( localclientnum )
    {
        cluielem::function_fa582112( localclientnum );
        set_data( localclientnum, "infectionTimeRemaining", 0 );
    }

}

// Namespace mp_infect_timer/mp_infect_timer
// Params 1
// Checksum 0xe45e74a5, Offset: 0xd0
// Size: 0x176
function register( var_7682811d )
{
    elem = new cmp_infect_timer();
    [[ elem ]]->setup_clientfields( var_7682811d );
    
    if ( !isdefined( level.var_ae746e8f ) )
    {
        level.var_ae746e8f = associativearray();
    }
    
    if ( !isdefined( level.var_ae746e8f[ #"mp_infect_timer" ] ) )
    {
        level.var_ae746e8f[ #"mp_infect_timer" ] = [];
    }
    
    if ( !isdefined( level.var_ae746e8f[ #"mp_infect_timer" ] ) )
    {
        level.var_ae746e8f[ #"mp_infect_timer" ] = [];
    }
    else if ( !isarray( level.var_ae746e8f[ #"mp_infect_timer" ] ) )
    {
        level.var_ae746e8f[ #"mp_infect_timer" ] = array( level.var_ae746e8f[ #"mp_infect_timer" ] );
    }
    
    level.var_ae746e8f[ #"mp_infect_timer" ][ level.var_ae746e8f[ #"mp_infect_timer" ].size ] = elem;
}

// Namespace mp_infect_timer/mp_infect_timer
// Params 0
// Checksum 0x5ce42c5a, Offset: 0x250
// Size: 0x34
function register_clientside()
{
    elem = new cmp_infect_timer();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace mp_infect_timer/mp_infect_timer
// Params 1
// Checksum 0xd1e34ca3, Offset: 0x290
// Size: 0x1c
function open( player )
{
    [[ self ]]->open( player );
}

// Namespace mp_infect_timer/mp_infect_timer
// Params 1
// Checksum 0x76ef91aa, Offset: 0x2b8
// Size: 0x1c
function close( player )
{
    [[ self ]]->close( player );
}

// Namespace mp_infect_timer/mp_infect_timer
// Params 1
// Checksum 0x73ce4cb5, Offset: 0x2e0
// Size: 0x1a
function is_open( localclientnum )
{
    return [[ self ]]->is_open( localclientnum );
}

// Namespace mp_infect_timer/mp_infect_timer
// Params 2
// Checksum 0x667f702e, Offset: 0x308
// Size: 0x28
function function_8c8674a4( localclientnum, value )
{
    [[ self ]]->function_8c8674a4( localclientnum, value );
}

