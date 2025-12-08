#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\util_shared;

#namespace mp_tundra;

// Namespace mp_tundra/level_init
// Params 1, eflags: 0x40
// Checksum 0x77f50225, Offset: 0xa8
// Size: 0x12c
function event_handler[level_init] main( *eventstruct )
{
    setsaveddvar( #"enable_global_wind", 1 );
    setsaveddvar( #"wind_global_vector", "88 0 0" );
    setsaveddvar( #"wind_global_low_altitude", 0 );
    setsaveddvar( #"wind_global_hi_altitude", 10000 );
    setsaveddvar( #"wind_global_low_strength_percent", 100 );
    callback::on_gameplay_started( &on_gameplay_started );
    load::main();
    util::waitforclient( 0 );
    level thread function_c0895679();
}

// Namespace mp_tundra/mp_tundra
// Params 1
// Checksum 0xb76cbd73, Offset: 0x1e0
// Size: 0x34
function on_gameplay_started( *localclientnum )
{
    waitframe( 1 );
    util::function_8eb5d4b0( 3500, 2.5 );
}

// Namespace mp_tundra/mp_tundra
// Params 0
// Checksum 0x7f6b4475, Offset: 0x220
// Size: 0x18c
function function_c0895679()
{
    self notify( "1590fbb0eb1e80aa" );
    self endon( "1590fbb0eb1e80aa" );
    
    while ( true )
    {
        level waittill( #"hash_1dd09886b0c5cbb1" );
        a_players = getlocalplayers();
        
        foreach ( player in a_players )
        {
            player postfx::playpostfxbundle( #"hash_139bff4e9ef99e2d" );
        }
        
        level waittill( #"hash_6f2413de6002b1cd" );
        a_players = getlocalplayers();
        
        foreach ( player in a_players )
        {
            player postfx::stoppostfxbundle( #"hash_139bff4e9ef99e2d" );
        }
    }
}

