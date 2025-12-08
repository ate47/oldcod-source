#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace mp_laststand_client;

// Namespace mp_laststand_client
// Method(s) 7 Total 14
class cmp_laststand_client : cluielem
{

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace cmp_laststand_client/mp_laststand_client
    // Params 2
    // Checksum 0x8df90c28, Offset: 0x2b0
    // Size: 0x3c
    function open( player, persistent = 0 )
    {
        cluielem::open_luielem( player, persistent );
    }

    // Namespace cmp_laststand_client/mp_laststand_client
    // Params 1
    // Checksum 0xb29724f8, Offset: 0x2f8
    // Size: 0x24
    function close( player )
    {
        cluielem::close_luielem( player );
    }

    // Namespace cmp_laststand_client/mp_laststand_client
    // Params 2
    // Checksum 0x34355d96, Offset: 0x328
    // Size: 0x44
    function set_bleedout_progress( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "bleedout_progress", value );
    }

    // Namespace cmp_laststand_client/mp_laststand_client
    // Params 0
    // Checksum 0x6bea4904, Offset: 0x238
    // Size: 0x6c
    function setup_clientfields()
    {
        cluielem::setup_clientfields( "mp_laststand_client" );
        cluielem::add_clientfield( "bleedout_progress", 1, 6, "float" );
        cluielem::add_clientfield( "revive_progress", 1, 5, "float" );
    }

    // Namespace cmp_laststand_client/mp_laststand_client
    // Params 2
    // Checksum 0x6aaf9e9a, Offset: 0x378
    // Size: 0x44
    function set_revive_progress( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "revive_progress", value );
    }

}

// Namespace mp_laststand_client/mp_laststand_client
// Params 0
// Checksum 0xef521369, Offset: 0xe8
// Size: 0x34
function register()
{
    elem = new cmp_laststand_client();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace mp_laststand_client/mp_laststand_client
// Params 2
// Checksum 0xcd520476, Offset: 0x128
// Size: 0x38
function open( player, persistent = 0 )
{
    [[ self ]]->open( player, persistent );
}

// Namespace mp_laststand_client/mp_laststand_client
// Params 1
// Checksum 0x2ecba694, Offset: 0x168
// Size: 0x1c
function close( player )
{
    [[ self ]]->close( player );
}

// Namespace mp_laststand_client/mp_laststand_client
// Params 1
// Checksum 0x12f52bff, Offset: 0x190
// Size: 0x1a
function is_open( player )
{
    return [[ self ]]->function_7bfd10e6( player );
}

// Namespace mp_laststand_client/mp_laststand_client
// Params 2
// Checksum 0x81ab28aa, Offset: 0x1b8
// Size: 0x28
function set_bleedout_progress( player, value )
{
    [[ self ]]->set_bleedout_progress( player, value );
}

// Namespace mp_laststand_client/mp_laststand_client
// Params 2
// Checksum 0x5bf20a30, Offset: 0x1e8
// Size: 0x28
function set_revive_progress( player, value )
{
    [[ self ]]->set_revive_progress( player, value );
}

