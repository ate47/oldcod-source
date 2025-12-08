#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace mp_prop_timer;

// Namespace mp_prop_timer
// Method(s) 7 Total 14
class cmp_prop_timer : cluielem
{

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace cmp_prop_timer/mp_prop_timer
    // Params 2
    // Checksum 0x66d28289, Offset: 0x298
    // Size: 0x3c
    function open( player, persistent = 0 )
    {
        cluielem::open_luielem( player, persistent );
    }

    // Namespace cmp_prop_timer/mp_prop_timer
    // Params 2
    // Checksum 0xda8e468a, Offset: 0x360
    // Size: 0x44
    function set_isprop( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "isProp", value );
    }

    // Namespace cmp_prop_timer/mp_prop_timer
    // Params 1
    // Checksum 0x8aab6f75, Offset: 0x2e0
    // Size: 0x24
    function close( player )
    {
        cluielem::close_luielem( player );
    }

    // Namespace cmp_prop_timer/mp_prop_timer
    // Params 0
    // Checksum 0xf35d4743, Offset: 0x220
    // Size: 0x6c
    function setup_clientfields()
    {
        cluielem::setup_clientfields( "mp_prop_timer" );
        cluielem::add_clientfield( "timeRemaining", 1, 5, "int", 0 );
        cluielem::add_clientfield( "isProp", 1, 1, "int" );
    }

    // Namespace cmp_prop_timer/mp_prop_timer
    // Params 2
    // Checksum 0xee24c082, Offset: 0x310
    // Size: 0x44
    function set_timeremaining( player, value )
    {
        player clientfield::function_9bf78ef8( var_d5213cbb, var_bf9c8c95, "timeRemaining", value );
    }

}

// Namespace mp_prop_timer/mp_prop_timer
// Params 0
// Checksum 0xab6d365, Offset: 0xd0
// Size: 0x34
function register()
{
    elem = new cmp_prop_timer();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace mp_prop_timer/mp_prop_timer
// Params 2
// Checksum 0xf9df25c3, Offset: 0x110
// Size: 0x38
function open( player, persistent = 0 )
{
    [[ self ]]->open( player, persistent );
}

// Namespace mp_prop_timer/mp_prop_timer
// Params 1
// Checksum 0x94bac228, Offset: 0x150
// Size: 0x1c
function close( player )
{
    [[ self ]]->close( player );
}

// Namespace mp_prop_timer/mp_prop_timer
// Params 1
// Checksum 0x2ab077a3, Offset: 0x178
// Size: 0x1a
function is_open( player )
{
    return [[ self ]]->function_7bfd10e6( player );
}

// Namespace mp_prop_timer/mp_prop_timer
// Params 2
// Checksum 0x63affb6d, Offset: 0x1a0
// Size: 0x28
function set_timeremaining( player, value )
{
    [[ self ]]->set_timeremaining( player, value );
}

// Namespace mp_prop_timer/mp_prop_timer
// Params 2
// Checksum 0x9c37ead4, Offset: 0x1d0
// Size: 0x28
function set_isprop( player, value )
{
    [[ self ]]->set_isprop( player, value );
}

