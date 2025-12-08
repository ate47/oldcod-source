#using scripts\core_common\lui_shared;

#namespace evidence_board_mission_preview;

// Namespace evidence_board_mission_preview
// Method(s) 13 Total 19
class class_fb1bfa12 : cluielem
{

    // Namespace namespace_fb1bfa12/evidence_board_mission_preview
    // Params 1
    // Checksum 0x3be64c1f, Offset: 0x7e8
    // Size: 0x24
    function open( localclientnum )
    {
        cluielem::open( localclientnum );
    }

    // Namespace namespace_fb1bfa12/evidence_board_mission_preview
    // Params 2
    // Checksum 0xdea24e59, Offset: 0x8f8
    // Size: 0x30
    function function_10415bce( localclientnum, value )
    {
        set_data( localclientnum, "lvlDescriptionShort", value );
    }

    // Namespace namespace_fb1bfa12/evidence_board_mission_preview
    // Params 2
    // Checksum 0xeaa68958, Offset: 0x930
    // Size: 0x30
    function function_275127c2( localclientnum, value )
    {
        set_data( localclientnum, "lvlDescriptionLong", value );
    }

    // Namespace namespace_fb1bfa12/evidence_board_mission_preview
    // Params 2
    // Checksum 0xec20c940, Offset: 0x968
    // Size: 0x30
    function function_3d5ae5d4( localclientnum, value )
    {
        set_data( localclientnum, "lvlProgress", value );
    }

    // Namespace namespace_fb1bfa12/evidence_board_mission_preview
    // Params 2
    // Checksum 0xec2bf88f, Offset: 0x850
    // Size: 0x30
    function function_57d3362b( localclientnum, value )
    {
        set_data( localclientnum, "activeState", value );
    }

    // Namespace namespace_fb1bfa12/evidence_board_mission_preview
    // Params 0
    // Checksum 0x80b23af0, Offset: 0x6a0
    // Size: 0x1c
    function register_clientside()
    {
        cluielem::register_clientside( "evidence_board_mission_preview" );
    }

    // Namespace namespace_fb1bfa12/evidence_board_mission_preview
    // Params 7
    // Checksum 0x500f81d8, Offset: 0x528
    // Size: 0x16c
    function setup_clientfields( var_5a7b4b38, var_ce679737, var_21c9fb3e, *var_370e913b, *var_4682a952, *var_72328549, var_8c8b5d16 )
    {
        cluielem::setup_clientfields( "evidence_board_mission_preview" );
        cluielem::add_clientfield( "entNum", 1, 10, "int", var_370e913b );
        cluielem::add_clientfield( "activeState", 1, 2, "int", var_4682a952 );
        cluielem::add_clientfield( "lvlYear", 1, 11, "int", var_72328549 );
        cluielem::function_dcb34c80( "string", "lvlName", 1 );
        cluielem::function_dcb34c80( "string", "lvlDescriptionShort", 1 );
        cluielem::function_dcb34c80( "string", "lvlDescriptionLong", 1 );
        cluielem::add_clientfield( "lvlProgress", 1, 4, "float", var_8c8b5d16 );
    }

    // Namespace namespace_fb1bfa12/evidence_board_mission_preview
    // Params 2
    // Checksum 0x5e2e5a26, Offset: 0x8c0
    // Size: 0x30
    function function_c063a71c( localclientnum, value )
    {
        set_data( localclientnum, "lvlName", value );
    }

    // Namespace namespace_fb1bfa12/evidence_board_mission_preview
    // Params 2
    // Checksum 0xedd75c5a, Offset: 0x888
    // Size: 0x30
    function function_c2c6a8c3( localclientnum, value )
    {
        set_data( localclientnum, "lvlYear", value );
    }

    // Namespace namespace_fb1bfa12/evidence_board_mission_preview
    // Params 2
    // Checksum 0x8af32970, Offset: 0x818
    // Size: 0x30
    function set_entnum( localclientnum, value )
    {
        set_data( localclientnum, "entNum", value );
    }

    // Namespace namespace_fb1bfa12/evidence_board_mission_preview
    // Params 1
    // Checksum 0xce2310e3, Offset: 0x6c8
    // Size: 0x118
    function function_fa582112( localclientnum )
    {
        cluielem::function_fa582112( localclientnum );
        set_data( localclientnum, "entNum", 0 );
        set_data( localclientnum, "activeState", 0 );
        set_data( localclientnum, "lvlYear", 0 );
        set_data( localclientnum, "lvlName", #"" );
        set_data( localclientnum, "lvlDescriptionShort", #"" );
        set_data( localclientnum, "lvlDescriptionLong", #"" );
        set_data( localclientnum, "lvlProgress", 0 );
    }

}

// Namespace evidence_board_mission_preview/evidence_board_mission_preview
// Params 7
// Checksum 0xc857e56, Offset: 0x140
// Size: 0x1b6
function register( var_5a7b4b38, var_ce679737, var_21c9fb3e, var_370e913b, var_4682a952, var_72328549, var_8c8b5d16 )
{
    elem = new class_fb1bfa12();
    [[ elem ]]->setup_clientfields( var_5a7b4b38, var_ce679737, var_21c9fb3e, var_370e913b, var_4682a952, var_72328549, var_8c8b5d16 );
    
    if ( !isdefined( level.var_ae746e8f ) )
    {
        level.var_ae746e8f = associativearray();
    }
    
    if ( !isdefined( level.var_ae746e8f[ #"evidence_board_mission_preview" ] ) )
    {
        level.var_ae746e8f[ #"evidence_board_mission_preview" ] = [];
    }
    
    if ( !isdefined( level.var_ae746e8f[ #"evidence_board_mission_preview" ] ) )
    {
        level.var_ae746e8f[ #"evidence_board_mission_preview" ] = [];
    }
    else if ( !isarray( level.var_ae746e8f[ #"evidence_board_mission_preview" ] ) )
    {
        level.var_ae746e8f[ #"evidence_board_mission_preview" ] = array( level.var_ae746e8f[ #"evidence_board_mission_preview" ] );
    }
    
    level.var_ae746e8f[ #"evidence_board_mission_preview" ][ level.var_ae746e8f[ #"evidence_board_mission_preview" ].size ] = elem;
}

// Namespace evidence_board_mission_preview/evidence_board_mission_preview
// Params 0
// Checksum 0x8e96445e, Offset: 0x300
// Size: 0x34
function register_clientside()
{
    elem = new class_fb1bfa12();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace evidence_board_mission_preview/evidence_board_mission_preview
// Params 1
// Checksum 0xf4194a2, Offset: 0x340
// Size: 0x1c
function open( player )
{
    [[ self ]]->open( player );
}

// Namespace evidence_board_mission_preview/evidence_board_mission_preview
// Params 1
// Checksum 0x4fd7831d, Offset: 0x368
// Size: 0x1c
function close( player )
{
    [[ self ]]->close( player );
}

// Namespace evidence_board_mission_preview/evidence_board_mission_preview
// Params 1
// Checksum 0xb7dff865, Offset: 0x390
// Size: 0x1a
function is_open( localclientnum )
{
    return [[ self ]]->is_open( localclientnum );
}

// Namespace evidence_board_mission_preview/evidence_board_mission_preview
// Params 2
// Checksum 0xef918d11, Offset: 0x3b8
// Size: 0x28
function set_entnum( localclientnum, value )
{
    [[ self ]]->set_entnum( localclientnum, value );
}

// Namespace evidence_board_mission_preview/evidence_board_mission_preview
// Params 2
// Checksum 0xa65873ca, Offset: 0x3e8
// Size: 0x28
function function_57d3362b( localclientnum, value )
{
    [[ self ]]->function_57d3362b( localclientnum, value );
}

// Namespace evidence_board_mission_preview/evidence_board_mission_preview
// Params 2
// Checksum 0x2fd24f62, Offset: 0x418
// Size: 0x28
function function_c2c6a8c3( localclientnum, value )
{
    [[ self ]]->function_c2c6a8c3( localclientnum, value );
}

// Namespace evidence_board_mission_preview/evidence_board_mission_preview
// Params 2
// Checksum 0xd8dbad46, Offset: 0x448
// Size: 0x28
function function_c063a71c( localclientnum, value )
{
    [[ self ]]->function_c063a71c( localclientnum, value );
}

// Namespace evidence_board_mission_preview/evidence_board_mission_preview
// Params 2
// Checksum 0x6ccf8b85, Offset: 0x478
// Size: 0x28
function function_10415bce( localclientnum, value )
{
    [[ self ]]->function_10415bce( localclientnum, value );
}

// Namespace evidence_board_mission_preview/evidence_board_mission_preview
// Params 2
// Checksum 0xadf028ea, Offset: 0x4a8
// Size: 0x28
function function_275127c2( localclientnum, value )
{
    [[ self ]]->function_275127c2( localclientnum, value );
}

// Namespace evidence_board_mission_preview/evidence_board_mission_preview
// Params 2
// Checksum 0x80f35ff4, Offset: 0x4d8
// Size: 0x28
function function_3d5ae5d4( localclientnum, value )
{
    [[ self ]]->function_3d5ae5d4( localclientnum, value );
}

