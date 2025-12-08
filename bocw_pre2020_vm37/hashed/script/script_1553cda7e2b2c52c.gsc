#using scripts\core_common\lui_shared;

#namespace pitch_and_yaw_meters;

// Namespace pitch_and_yaw_meters
// Method(s) 5 Total 12
class class_98cc868d : cluielem
{

    // Namespace namespace_98cc868d/pitch_and_yaw_meters
    // Params 2
    // Checksum 0x2f54cbdb, Offset: 0x1c8
    // Size: 0x3c
    function open( player, persistent = 0 )
    {
        cluielem::open_luielem( player, persistent );
    }

    // Namespace namespace_98cc868d/pitch_and_yaw_meters
    // Params 1
    // Checksum 0x54cee9cc, Offset: 0x210
    // Size: 0x24
    function close( player )
    {
        cluielem::close_luielem( player );
    }

    // Namespace namespace_98cc868d/pitch_and_yaw_meters
    // Params 0
    // Checksum 0xff78d7cd, Offset: 0x1a0
    // Size: 0x1c
    function setup_clientfields()
    {
        cluielem::setup_clientfields( "pitch_and_yaw_meters" );
    }

}

// Namespace pitch_and_yaw_meters/pitch_and_yaw_meters
// Params 0
// Checksum 0xfb1d074c, Offset: 0xb0
// Size: 0x34
function register()
{
    elem = new class_98cc868d();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace pitch_and_yaw_meters/pitch_and_yaw_meters
// Params 2
// Checksum 0xcd520476, Offset: 0xf0
// Size: 0x38
function open( player, persistent = 0 )
{
    [[ self ]]->open( player, persistent );
}

// Namespace pitch_and_yaw_meters/pitch_and_yaw_meters
// Params 1
// Checksum 0x2ecba694, Offset: 0x130
// Size: 0x1c
function close( player )
{
    [[ self ]]->close( player );
}

// Namespace pitch_and_yaw_meters/pitch_and_yaw_meters
// Params 1
// Checksum 0x12f52bff, Offset: 0x158
// Size: 0x1a
function is_open( player )
{
    return [[ self ]]->function_7bfd10e6( player );
}

