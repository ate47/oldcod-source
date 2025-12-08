#using scripts\core_common\lui_shared;

#namespace mp_prop_controls;

// Namespace mp_prop_controls
// Method(s) 5 Total 12
class cmp_prop_controls : cluielem
{

    // Namespace cmp_prop_controls/mp_prop_controls
    // Params 2
    // Checksum 0x115211ac, Offset: 0x1c8
    // Size: 0x3c
    function open( player, persistent = 0 )
    {
        cluielem::open_luielem( player, persistent );
    }

    // Namespace cmp_prop_controls/mp_prop_controls
    // Params 1
    // Checksum 0x6ab51c1d, Offset: 0x210
    // Size: 0x24
    function close( player )
    {
        cluielem::close_luielem( player );
    }

    // Namespace cmp_prop_controls/mp_prop_controls
    // Params 0
    // Checksum 0x874a74cc, Offset: 0x1a0
    // Size: 0x1c
    function setup_clientfields()
    {
        cluielem::setup_clientfields( "mp_prop_controls" );
    }

}

// Namespace mp_prop_controls/mp_prop_controls
// Params 0
// Checksum 0xe575ef9a, Offset: 0xb0
// Size: 0x34
function register()
{
    elem = new cmp_prop_controls();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace mp_prop_controls/mp_prop_controls
// Params 2
// Checksum 0x2d020860, Offset: 0xf0
// Size: 0x38
function open( player, persistent = 0 )
{
    [[ self ]]->open( player, persistent );
}

// Namespace mp_prop_controls/mp_prop_controls
// Params 1
// Checksum 0xfd201144, Offset: 0x130
// Size: 0x1c
function close( player )
{
    [[ self ]]->close( player );
}

// Namespace mp_prop_controls/mp_prop_controls
// Params 1
// Checksum 0xc0142567, Offset: 0x158
// Size: 0x1a
function is_open( player )
{
    return [[ self ]]->function_7bfd10e6( player );
}

