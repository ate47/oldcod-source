#using scripts\core_common\lui_shared;

#namespace bountyhunterbuy;

// Namespace bountyhunterbuy
// Method(s) 6 Total 12
class cbountyhunterbuy : cluielem
{

    // Namespace cbountyhunterbuy/bountyhunterbuy
    // Params 1
    // Checksum 0xa9bb4c19, Offset: 0x378
    // Size: 0x24
    function open( localclientnum )
    {
        cluielem::open( localclientnum );
    }

    // Namespace cbountyhunterbuy/bountyhunterbuy
    // Params 0
    // Checksum 0x6708f8a7, Offset: 0x320
    // Size: 0x1c
    function register_clientside()
    {
        cluielem::register_clientside( "BountyHunterBuy" );
    }

    // Namespace cbountyhunterbuy/bountyhunterbuy
    // Params 0
    // Checksum 0xa280c2a2, Offset: 0x2f8
    // Size: 0x1c
    function setup_clientfields()
    {
        cluielem::setup_clientfields( "BountyHunterBuy" );
    }

    // Namespace cbountyhunterbuy/bountyhunterbuy
    // Params 1
    // Checksum 0x249e87df, Offset: 0x348
    // Size: 0x24
    function function_fa582112( localclientnum )
    {
        cluielem::function_fa582112( localclientnum );
    }

}

// Namespace bountyhunterbuy/bountyhunterbuy
// Params 0
// Checksum 0xc2b36a7f, Offset: 0xa8
// Size: 0x16e
function register()
{
    elem = new cbountyhunterbuy();
    [[ elem ]]->setup_clientfields();
    
    if ( !isdefined( level.var_ae746e8f ) )
    {
        level.var_ae746e8f = associativearray();
    }
    
    if ( !isdefined( level.var_ae746e8f[ #"bountyhunterbuy" ] ) )
    {
        level.var_ae746e8f[ #"bountyhunterbuy" ] = [];
    }
    
    if ( !isdefined( level.var_ae746e8f[ #"bountyhunterbuy" ] ) )
    {
        level.var_ae746e8f[ #"bountyhunterbuy" ] = [];
    }
    else if ( !isarray( level.var_ae746e8f[ #"bountyhunterbuy" ] ) )
    {
        level.var_ae746e8f[ #"bountyhunterbuy" ] = array( level.var_ae746e8f[ #"bountyhunterbuy" ] );
    }
    
    level.var_ae746e8f[ #"bountyhunterbuy" ][ level.var_ae746e8f[ #"bountyhunterbuy" ].size ] = elem;
}

// Namespace bountyhunterbuy/bountyhunterbuy
// Params 0
// Checksum 0xf19f7839, Offset: 0x220
// Size: 0x34
function register_clientside()
{
    elem = new cbountyhunterbuy();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace bountyhunterbuy/bountyhunterbuy
// Params 1
// Checksum 0x27d04e0d, Offset: 0x260
// Size: 0x1c
function open( player )
{
    [[ self ]]->open( player );
}

// Namespace bountyhunterbuy/bountyhunterbuy
// Params 1
// Checksum 0x975e3655, Offset: 0x288
// Size: 0x1c
function close( player )
{
    [[ self ]]->close( player );
}

// Namespace bountyhunterbuy/bountyhunterbuy
// Params 1
// Checksum 0x9d9baf38, Offset: 0x2b0
// Size: 0x1a
function is_open( localclientnum )
{
    return [[ self ]]->is_open( localclientnum );
}

