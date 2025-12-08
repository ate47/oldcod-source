#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace evidence_board_mission_preview;

// Namespace evidence_board_mission_preview
// Method(s) 12 Total 19
class class_fb1bfa12 : cluielem
{

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace namespace_fb1bfa12/evidence_board_mission_preview
    // Params 2
    // Checksum 0x6a2d1cbf, Offset: 0x508
    // Size: 0x3c
    function open( player, persistent = 0 )
    {
        cluielem::open_luielem( player, persistent );
    }

    // Namespace namespace_fb1bfa12/evidence_board_mission_preview
    // Params 2
    // Checksum 0x8e8e19b8, Offset: 0x6c0
    // Size: 0x44
    function function_10415bce( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "lvlDescriptionShort", value );
    }

    // Namespace namespace_fb1bfa12/evidence_board_mission_preview
    // Params 2
    // Checksum 0xad0f6caf, Offset: 0x710
    // Size: 0x44
    function function_275127c2( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "lvlDescriptionLong", value );
    }

    // Namespace namespace_fb1bfa12/evidence_board_mission_preview
    // Params 2
    // Checksum 0xd7efb20f, Offset: 0x760
    // Size: 0x44
    function function_3d5ae5d4( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "lvlProgress", value );
    }

    // Namespace namespace_fb1bfa12/evidence_board_mission_preview
    // Params 2
    // Checksum 0xa7076e0e, Offset: 0x5d0
    // Size: 0x44
    function function_57d3362b( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "activeState", value );
    }

    // Namespace namespace_fb1bfa12/evidence_board_mission_preview
    // Params 1
    // Checksum 0x6582b58e, Offset: 0x550
    // Size: 0x24
    function close( player )
    {
        cluielem::close_luielem( player );
    }

    // Namespace namespace_fb1bfa12/evidence_board_mission_preview
    // Params 0
    // Checksum 0x512558d3, Offset: 0x3c8
    // Size: 0x134
    function setup_clientfields()
    {
        cluielem::setup_clientfields( "evidence_board_mission_preview" );
        cluielem::add_clientfield( "entNum", 1, 10, "int" );
        cluielem::add_clientfield( "activeState", 1, 2, "int" );
        cluielem::add_clientfield( "lvlYear", 1, 11, "int" );
        cluielem::function_dcb34c80( "string", "lvlName", 1 );
        cluielem::function_dcb34c80( "string", "lvlDescriptionShort", 1 );
        cluielem::function_dcb34c80( "string", "lvlDescriptionLong", 1 );
        cluielem::add_clientfield( "lvlProgress", 1, 4, "float" );
    }

    // Namespace namespace_fb1bfa12/evidence_board_mission_preview
    // Params 2
    // Checksum 0xc3973f8c, Offset: 0x670
    // Size: 0x44
    function function_c063a71c( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "lvlName", value );
    }

    // Namespace namespace_fb1bfa12/evidence_board_mission_preview
    // Params 2
    // Checksum 0xa1a50c7c, Offset: 0x620
    // Size: 0x44
    function function_c2c6a8c3( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "lvlYear", value );
    }

    // Namespace namespace_fb1bfa12/evidence_board_mission_preview
    // Params 2
    // Checksum 0x2842f8b6, Offset: 0x580
    // Size: 0x44
    function set_entnum( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "entNum", value );
    }

}

// Namespace evidence_board_mission_preview/evidence_board_mission_preview
// Params 2
// Checksum 0x87edcddd, Offset: 0x148
// Size: 0x34
function function_326329cb( player, var_ba420c60 )
{
    function_c063a71c( player, var_ba420c60.levelname );
}

// Namespace evidence_board_mission_preview/evidence_board_mission_preview
// Params 0
// Checksum 0xb3c98954, Offset: 0x188
// Size: 0x34
function register()
{
    elem = new class_fb1bfa12();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace evidence_board_mission_preview/evidence_board_mission_preview
// Params 2
// Checksum 0x67f8ee46, Offset: 0x1c8
// Size: 0x38
function open( player, persistent = 0 )
{
    [[ self ]]->open( player, persistent );
}

// Namespace evidence_board_mission_preview/evidence_board_mission_preview
// Params 1
// Checksum 0x911b78ad, Offset: 0x208
// Size: 0x1c
function close( player )
{
    [[ self ]]->close( player );
}

// Namespace evidence_board_mission_preview/evidence_board_mission_preview
// Params 1
// Checksum 0xac98f743, Offset: 0x230
// Size: 0x1a
function is_open( player )
{
    return [[ self ]]->function_7bfd10e6( player );
}

// Namespace evidence_board_mission_preview/evidence_board_mission_preview
// Params 2
// Checksum 0xa49ae8ea, Offset: 0x258
// Size: 0x28
function set_entnum( player, value )
{
    [[ self ]]->set_entnum( player, value );
}

// Namespace evidence_board_mission_preview/evidence_board_mission_preview
// Params 2
// Checksum 0x80192a5a, Offset: 0x288
// Size: 0x28
function function_57d3362b( player, value )
{
    [[ self ]]->function_57d3362b( player, value );
}

// Namespace evidence_board_mission_preview/evidence_board_mission_preview
// Params 2
// Checksum 0xb1bdbb2a, Offset: 0x2b8
// Size: 0x28
function function_c2c6a8c3( player, value )
{
    [[ self ]]->function_c2c6a8c3( player, value );
}

// Namespace evidence_board_mission_preview/evidence_board_mission_preview
// Params 2
// Checksum 0xc9e80202, Offset: 0x2e8
// Size: 0x28
function function_c063a71c( player, value )
{
    [[ self ]]->function_c063a71c( player, value );
}

// Namespace evidence_board_mission_preview/evidence_board_mission_preview
// Params 2
// Checksum 0x9c1b6ec, Offset: 0x318
// Size: 0x28
function function_10415bce( player, value )
{
    [[ self ]]->function_10415bce( player, value );
}

// Namespace evidence_board_mission_preview/evidence_board_mission_preview
// Params 2
// Checksum 0x555a72f6, Offset: 0x348
// Size: 0x28
function function_275127c2( player, value )
{
    [[ self ]]->function_275127c2( player, value );
}

// Namespace evidence_board_mission_preview/evidence_board_mission_preview
// Params 2
// Checksum 0xb99ee556, Offset: 0x378
// Size: 0x28
function function_3d5ae5d4( player, value )
{
    [[ self ]]->function_3d5ae5d4( player, value );
}

