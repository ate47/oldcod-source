#using scripts\core_common\lui_shared;

#namespace mp_prop_controls;

// Namespace mp_prop_controls
// Method(s) 6 Total 12
class cmp_prop_controls : cluielem
{

    // Namespace cmp_prop_controls/mp_prop_controls
    // Params 1
    // Checksum 0x3bd71dd2, Offset: 0x380
    // Size: 0x24
    function open( localclientnum )
    {
        cluielem::open( localclientnum );
    }

    // Namespace cmp_prop_controls/mp_prop_controls
    // Params 0
    // Checksum 0xe8649f02, Offset: 0x328
    // Size: 0x1c
    function register_clientside()
    {
        cluielem::register_clientside( "mp_prop_controls" );
    }

    // Namespace cmp_prop_controls/mp_prop_controls
    // Params 0
    // Checksum 0xd1d40ff, Offset: 0x300
    // Size: 0x1c
    function setup_clientfields()
    {
        cluielem::setup_clientfields( "mp_prop_controls" );
    }

    // Namespace cmp_prop_controls/mp_prop_controls
    // Params 1
    // Checksum 0x6c127a80, Offset: 0x350
    // Size: 0x24
    function function_fa582112( localclientnum )
    {
        cluielem::function_fa582112( localclientnum );
    }

}

// Namespace mp_prop_controls/mp_prop_controls
// Params 0
// Checksum 0x685ae162, Offset: 0xb0
// Size: 0x16e
function register()
{
    elem = new cmp_prop_controls();
    [[ elem ]]->setup_clientfields();
    
    if ( !isdefined( level.var_ae746e8f ) )
    {
        level.var_ae746e8f = associativearray();
    }
    
    if ( !isdefined( level.var_ae746e8f[ #"mp_prop_controls" ] ) )
    {
        level.var_ae746e8f[ #"mp_prop_controls" ] = [];
    }
    
    if ( !isdefined( level.var_ae746e8f[ #"mp_prop_controls" ] ) )
    {
        level.var_ae746e8f[ #"mp_prop_controls" ] = [];
    }
    else if ( !isarray( level.var_ae746e8f[ #"mp_prop_controls" ] ) )
    {
        level.var_ae746e8f[ #"mp_prop_controls" ] = array( level.var_ae746e8f[ #"mp_prop_controls" ] );
    }
    
    level.var_ae746e8f[ #"mp_prop_controls" ][ level.var_ae746e8f[ #"mp_prop_controls" ].size ] = elem;
}

// Namespace mp_prop_controls/mp_prop_controls
// Params 0
// Checksum 0x1f49d65c, Offset: 0x228
// Size: 0x34
function register_clientside()
{
    elem = new cmp_prop_controls();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace mp_prop_controls/mp_prop_controls
// Params 1
// Checksum 0xb3af6fee, Offset: 0x268
// Size: 0x1c
function open( player )
{
    [[ self ]]->open( player );
}

// Namespace mp_prop_controls/mp_prop_controls
// Params 1
// Checksum 0x978e69d, Offset: 0x290
// Size: 0x1c
function close( player )
{
    [[ self ]]->close( player );
}

// Namespace mp_prop_controls/mp_prop_controls
// Params 1
// Checksum 0x6f3b3860, Offset: 0x2b8
// Size: 0x1a
function is_open( localclientnum )
{
    return [[ self ]]->is_open( localclientnum );
}

