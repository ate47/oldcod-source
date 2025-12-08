#using scripts\core_common\lui_shared;

#namespace cp_killcam;

// Namespace cp_killcam
// Method(s) 6 Total 12
class class_a5d10b03 : cluielem
{

    // Namespace namespace_a5d10b03/cp_killcam
    // Params 1
    // Checksum 0xfa8b05b4, Offset: 0x378
    // Size: 0x24
    function open( localclientnum )
    {
        cluielem::open( localclientnum );
    }

    // Namespace namespace_a5d10b03/cp_killcam
    // Params 0
    // Checksum 0x96fee3b4, Offset: 0x320
    // Size: 0x1c
    function register_clientside()
    {
        cluielem::register_clientside( "cp_killcam" );
    }

    // Namespace namespace_a5d10b03/cp_killcam
    // Params 0
    // Checksum 0x90742a4, Offset: 0x2f8
    // Size: 0x1c
    function setup_clientfields()
    {
        cluielem::setup_clientfields( "cp_killcam" );
    }

    // Namespace namespace_a5d10b03/cp_killcam
    // Params 1
    // Checksum 0xd3d5e8f6, Offset: 0x348
    // Size: 0x24
    function function_fa582112( localclientnum )
    {
        cluielem::function_fa582112( localclientnum );
    }

}

// Namespace cp_killcam/cp_killcam
// Params 0
// Checksum 0xe6af9ebd, Offset: 0xa8
// Size: 0x16e
function register()
{
    elem = new class_a5d10b03();
    [[ elem ]]->setup_clientfields();
    
    if ( !isdefined( level.var_ae746e8f ) )
    {
        level.var_ae746e8f = associativearray();
    }
    
    if ( !isdefined( level.var_ae746e8f[ #"cp_killcam" ] ) )
    {
        level.var_ae746e8f[ #"cp_killcam" ] = [];
    }
    
    if ( !isdefined( level.var_ae746e8f[ #"cp_killcam" ] ) )
    {
        level.var_ae746e8f[ #"cp_killcam" ] = [];
    }
    else if ( !isarray( level.var_ae746e8f[ #"cp_killcam" ] ) )
    {
        level.var_ae746e8f[ #"cp_killcam" ] = array( level.var_ae746e8f[ #"cp_killcam" ] );
    }
    
    level.var_ae746e8f[ #"cp_killcam" ][ level.var_ae746e8f[ #"cp_killcam" ].size ] = elem;
}

// Namespace cp_killcam/cp_killcam
// Params 0
// Checksum 0x67365334, Offset: 0x220
// Size: 0x34
function register_clientside()
{
    elem = new class_a5d10b03();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace cp_killcam/cp_killcam
// Params 1
// Checksum 0xf8846315, Offset: 0x260
// Size: 0x1c
function open( player )
{
    [[ self ]]->open( player );
}

// Namespace cp_killcam/cp_killcam
// Params 1
// Checksum 0x94a56ca8, Offset: 0x288
// Size: 0x1c
function close( player )
{
    [[ self ]]->close( player );
}

// Namespace cp_killcam/cp_killcam
// Params 1
// Checksum 0xd2c7ddc1, Offset: 0x2b0
// Size: 0x1a
function is_open( localclientnum )
{
    return [[ self ]]->is_open( localclientnum );
}

