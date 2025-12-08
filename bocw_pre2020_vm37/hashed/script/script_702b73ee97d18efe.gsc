#using scripts\core_common\lui_shared;

#namespace bountyhunterbuy;

// Namespace bountyhunterbuy
// Method(s) 5 Total 12
class cbountyhunterbuy : cluielem
{

    // Namespace cbountyhunterbuy/bountyhunterbuy
    // Params 2
    // Checksum 0x274d5ecf, Offset: 0x1c0
    // Size: 0x3c
    function open( player, persistent = 0 )
    {
        cluielem::open_luielem( player, persistent );
    }

    // Namespace cbountyhunterbuy/bountyhunterbuy
    // Params 1
    // Checksum 0xbf3dc37, Offset: 0x208
    // Size: 0x24
    function close( player )
    {
        cluielem::close_luielem( player );
    }

    // Namespace cbountyhunterbuy/bountyhunterbuy
    // Params 0
    // Checksum 0xdfd5ea4a, Offset: 0x198
    // Size: 0x1c
    function setup_clientfields()
    {
        cluielem::setup_clientfields( "BountyHunterBuy" );
    }

}

// Namespace bountyhunterbuy/bountyhunterbuy
// Params 0
// Checksum 0x8ee3b75a, Offset: 0xa8
// Size: 0x34
function register()
{
    elem = new cbountyhunterbuy();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace bountyhunterbuy/bountyhunterbuy
// Params 2
// Checksum 0xf9df25c3, Offset: 0xe8
// Size: 0x38
function open( player, persistent = 0 )
{
    [[ self ]]->open( player, persistent );
}

// Namespace bountyhunterbuy/bountyhunterbuy
// Params 1
// Checksum 0x94bac228, Offset: 0x128
// Size: 0x1c
function close( player )
{
    [[ self ]]->close( player );
}

// Namespace bountyhunterbuy/bountyhunterbuy
// Params 1
// Checksum 0x2ab077a3, Offset: 0x150
// Size: 0x1a
function is_open( player )
{
    return [[ self ]]->function_7bfd10e6( player );
}

