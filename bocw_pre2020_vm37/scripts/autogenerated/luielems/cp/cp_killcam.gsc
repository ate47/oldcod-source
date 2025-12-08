#using scripts\core_common\lui_shared;

#namespace cp_killcam;

// Namespace cp_killcam
// Method(s) 5 Total 12
class class_a5d10b03 : cluielem
{

    // Namespace namespace_a5d10b03/cp_killcam
    // Params 2
    // Checksum 0xef40e1bb, Offset: 0x1c0
    // Size: 0x3c
    function open( player, persistent = 0 )
    {
        cluielem::open_luielem( player, persistent );
    }

    // Namespace namespace_a5d10b03/cp_killcam
    // Params 1
    // Checksum 0x8af39177, Offset: 0x208
    // Size: 0x24
    function close( player )
    {
        cluielem::close_luielem( player );
    }

    // Namespace namespace_a5d10b03/cp_killcam
    // Params 0
    // Checksum 0x71262ec8, Offset: 0x198
    // Size: 0x1c
    function setup_clientfields()
    {
        cluielem::setup_clientfields( "cp_killcam" );
    }

}

// Namespace cp_killcam/cp_killcam
// Params 0
// Checksum 0x58ad26e6, Offset: 0xa8
// Size: 0x34
function register()
{
    elem = new class_a5d10b03();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace cp_killcam/cp_killcam
// Params 2
// Checksum 0x35a9b000, Offset: 0xe8
// Size: 0x38
function open( player, persistent = 0 )
{
    [[ self ]]->open( player, persistent );
}

// Namespace cp_killcam/cp_killcam
// Params 1
// Checksum 0x8ae26129, Offset: 0x128
// Size: 0x1c
function close( player )
{
    [[ self ]]->close( player );
}

// Namespace cp_killcam/cp_killcam
// Params 1
// Checksum 0x7830f9a3, Offset: 0x150
// Size: 0x1a
function is_open( player )
{
    return [[ self ]]->function_7bfd10e6( player );
}

