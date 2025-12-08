#using script_279f3c5ed514db22;
#using script_4179c51fbbe7793b;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\util_shared;

#namespace cp_rus_siege;

// Namespace cp_rus_siege/level_init
// Params 1, eflags: 0x40
// Checksum 0x79617a79, Offset: 0x110
// Size: 0x124
function event_handler[level_init] main( *eventstruct )
{
    preload();
    setsaveddvar( #"enable_global_wind", 1 );
    setsaveddvar( #"wind_global_vector", "88 0 0" );
    setsaveddvar( #"wind_global_low_altitude", 0 );
    setsaveddvar( #"wind_global_hi_altitude", 10000 );
    setsaveddvar( #"wind_global_low_strength_percent", 100 );
    callback::on_localplayer_spawned( &on_gameplay_started );
    load::main();
    util::waitforclient( 0 );
}

// Namespace cp_rus_siege/cp_rus_siege
// Params 0
// Checksum 0xc95099f6, Offset: 0x240
// Size: 0x94
function preload()
{
    clientfield::register( "scriptmover", "play_radar_fx", 1, 1, "counter", &play_radar_fx, 0, 0 );
    clientfield::register( "scriptmover", "kill_radar_fx", 1, 1, "counter", &kill_radar_fx, 0, 0 );
}

// Namespace cp_rus_siege/cp_rus_siege
// Params 1
// Checksum 0x7eb85839, Offset: 0x2e0
// Size: 0x2c
function on_gameplay_started( *localclientnum )
{
    waitframe( 1 );
    util::function_8eb5d4b0( 3500, 1.8 );
}

// Namespace cp_rus_siege/cp_rus_siege
// Params 7
// Checksum 0x916a08d5, Offset: 0x318
// Size: 0x6a
function play_radar_fx( localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    self.radar_fx = function_239993de( bwastimejump, "maps/cp_rus_siege/fx9_glow_red_radar", self, "tag_origin" );
}

// Namespace cp_rus_siege/cp_rus_siege
// Params 7
// Checksum 0xa9954eef, Offset: 0x390
// Size: 0x5c
function kill_radar_fx( localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    killfx( bwastimejump, self.radar_fx );
}

