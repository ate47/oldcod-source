#using scripts\core_common\lui_shared;

#namespace mobile_armory_loadout;

// Namespace mobile_armory_loadout
// Method(s) 5 Total 12
class class_8019ebdc : cluielem
{

    // Namespace namespace_8019ebdc/mobile_armory_loadout
    // Params 2
    // Checksum 0x5f686f5, Offset: 0x1c8
    // Size: 0x3c
    function open( player, persistent = 0 )
    {
        cluielem::open_luielem( player, persistent );
    }

    // Namespace namespace_8019ebdc/mobile_armory_loadout
    // Params 1
    // Checksum 0xdae0f462, Offset: 0x210
    // Size: 0x24
    function close( player )
    {
        cluielem::close_luielem( player );
    }

    // Namespace namespace_8019ebdc/mobile_armory_loadout
    // Params 0
    // Checksum 0x1e630823, Offset: 0x1a0
    // Size: 0x1c
    function setup_clientfields()
    {
        cluielem::setup_clientfields( "mobile_armory_loadout" );
    }

}

// Namespace mobile_armory_loadout/mobile_armory_loadout
// Params 0
// Checksum 0x71bc07d6, Offset: 0xb0
// Size: 0x34
function register()
{
    elem = new class_8019ebdc();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace mobile_armory_loadout/mobile_armory_loadout
// Params 2
// Checksum 0xca2e1c40, Offset: 0xf0
// Size: 0x38
function open( player, persistent = 0 )
{
    [[ self ]]->open( player, persistent );
}

// Namespace mobile_armory_loadout/mobile_armory_loadout
// Params 1
// Checksum 0x7c7778f0, Offset: 0x130
// Size: 0x1c
function close( player )
{
    [[ self ]]->close( player );
}

// Namespace mobile_armory_loadout/mobile_armory_loadout
// Params 1
// Checksum 0xa2ef2991, Offset: 0x158
// Size: 0x1a
function is_open( player )
{
    return [[ self ]]->function_7bfd10e6( player );
}

