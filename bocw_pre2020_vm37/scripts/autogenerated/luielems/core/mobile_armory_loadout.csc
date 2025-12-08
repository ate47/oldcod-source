#using scripts\core_common\lui_shared;

#namespace mobile_armory_loadout;

// Namespace mobile_armory_loadout
// Method(s) 6 Total 12
class class_8019ebdc : cluielem
{

    // Namespace namespace_8019ebdc/mobile_armory_loadout
    // Params 1
    // Checksum 0xc7741028, Offset: 0x380
    // Size: 0x24
    function open( localclientnum )
    {
        cluielem::open( localclientnum );
    }

    // Namespace namespace_8019ebdc/mobile_armory_loadout
    // Params 0
    // Checksum 0x24a8cf25, Offset: 0x328
    // Size: 0x1c
    function register_clientside()
    {
        cluielem::register_clientside( "mobile_armory_loadout" );
    }

    // Namespace namespace_8019ebdc/mobile_armory_loadout
    // Params 0
    // Checksum 0x3b463985, Offset: 0x300
    // Size: 0x1c
    function setup_clientfields()
    {
        cluielem::setup_clientfields( "mobile_armory_loadout" );
    }

    // Namespace namespace_8019ebdc/mobile_armory_loadout
    // Params 1
    // Checksum 0x2bf5276e, Offset: 0x350
    // Size: 0x24
    function function_fa582112( localclientnum )
    {
        cluielem::function_fa582112( localclientnum );
    }

}

// Namespace mobile_armory_loadout/mobile_armory_loadout
// Params 0
// Checksum 0xe7bb0e6, Offset: 0xb0
// Size: 0x16e
function register()
{
    elem = new class_8019ebdc();
    [[ elem ]]->setup_clientfields();
    
    if ( !isdefined( level.var_ae746e8f ) )
    {
        level.var_ae746e8f = associativearray();
    }
    
    if ( !isdefined( level.var_ae746e8f[ #"mobile_armory_loadout" ] ) )
    {
        level.var_ae746e8f[ #"mobile_armory_loadout" ] = [];
    }
    
    if ( !isdefined( level.var_ae746e8f[ #"mobile_armory_loadout" ] ) )
    {
        level.var_ae746e8f[ #"mobile_armory_loadout" ] = [];
    }
    else if ( !isarray( level.var_ae746e8f[ #"mobile_armory_loadout" ] ) )
    {
        level.var_ae746e8f[ #"mobile_armory_loadout" ] = array( level.var_ae746e8f[ #"mobile_armory_loadout" ] );
    }
    
    level.var_ae746e8f[ #"mobile_armory_loadout" ][ level.var_ae746e8f[ #"mobile_armory_loadout" ].size ] = elem;
}

// Namespace mobile_armory_loadout/mobile_armory_loadout
// Params 0
// Checksum 0xcaa430e6, Offset: 0x228
// Size: 0x34
function register_clientside()
{
    elem = new class_8019ebdc();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace mobile_armory_loadout/mobile_armory_loadout
// Params 1
// Checksum 0x1d3f70a7, Offset: 0x268
// Size: 0x1c
function open( player )
{
    [[ self ]]->open( player );
}

// Namespace mobile_armory_loadout/mobile_armory_loadout
// Params 1
// Checksum 0xe9546b3a, Offset: 0x290
// Size: 0x1c
function close( player )
{
    [[ self ]]->close( player );
}

// Namespace mobile_armory_loadout/mobile_armory_loadout
// Params 1
// Checksum 0x479469de, Offset: 0x2b8
// Size: 0x1a
function is_open( localclientnum )
{
    return [[ self ]]->is_open( localclientnum );
}

