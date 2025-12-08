#using script_1b1542e0727c572a;
#using script_1d21191fa6d656cf;
#using script_2ef0cf51653aaada;
#using script_2f4f71f95573b891;
#using script_372b72db713e7946;
#using script_3b2905ec05ed796;
#using script_41e8adffbda93483;
#using script_498cf7685befe7bf;
#using script_4d27f7166781c70b;
#using script_523a88e0a98bed6f;
#using script_589f7fc6e210aea7;
#using script_65328041a4d0067f;
#using script_77f51076c7c89596;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\struct;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;

#namespace cp_rus_siege;

// Namespace cp_rus_siege/level_init
// Params 1, eflags: 0x40
// Checksum 0xb2602d80, Offset: 0x2a0
// Size: 0x18e
function event_handler[level_init] main( *eventstruct )
{
    preload();
    function_37dfd679();
    load::main();
    profilestart();
    
    /#
        level.disablestattracking = 1;
    #/
    
    level.var_9c4a751d = 1;
    setdvar( #"compassmaxrange", "2100" );
    callback::on_spawned( &namespace_534279a::function_6e9256df );
    hms_util::function_2f3616f8();
    level thread namespace_9e5ef376::blocker_init();
    level thread namespace_534279a::function_ce0f72f4();
    level thread namespace_604e2e22::function_1e2a0690( "aa_parapet", "parapet_aa_gunner", "scene_sge_0000_ambient_aa_gun_graveyard" );
    level thread namespace_604e2e22::function_b9170a35( "aa_north" );
    level thread namespace_604e2e22::function_b9170a35( "aa_west" );
    
    /#
        level thread hms_util::function_32397759();
        level thread hms_util::function_5056f90d();
    #/
    
    profilestop();
}

// Namespace cp_rus_siege/cp_rus_siege
// Params 0
// Checksum 0x75e95e98, Offset: 0x438
// Size: 0x64
function preload()
{
    clientfield::register( "scriptmover", "play_radar_fx", 1, 1, "counter" );
    clientfield::register( "scriptmover", "kill_radar_fx", 1, 1, "counter" );
}

// Namespace cp_rus_siege/cp_rus_siege
// Params 0
// Checksum 0x595a8986, Offset: 0x4a8
// Size: 0x494
function function_37dfd679()
{
    skipto::function_eb91535d( "infil", &namespace_ce17746::main, &namespace_ce17746::starting, "Infil", &namespace_ce17746::cleanup, "siege_town_vista" );
    skipto::function_eb91535d( "emp_flash", &namespace_b11c1856::main, &namespace_b11c1856::starting, "EMP", &namespace_b11c1856::cleanup, [ "siege_town_approach", "siege_monastery" ] );
    skipto::function_eb91535d( "courtyard", &namespace_9e5ef376::function_802a0aed, &namespace_9e5ef376::function_abfa576, "Courtyard", &namespace_9e5ef376::function_77335d30, "siege_monastery" );
    skipto::function_eb91535d( "catacombs", &namespace_c34cd176::function_41e4735f, &namespace_c34cd176::function_25a6167c, "Catacombs", &namespace_c34cd176::function_fa1a97a3, "siege_monastery" );
    skipto::function_eb91535d( "graveyard", &namespace_9940c067::function_8b10d19c, &namespace_9940c067::function_d7e02379, "Graveyard", &namespace_9940c067::function_cdf0a865, "siege_monastery" );
    skipto::function_eb91535d( "outro", &namespace_9e5ef376::outro_main, &namespace_9e5ef376::function_4b8cec86, "Outro", &namespace_9e5ef376::outro_cleanup, "siege_monastery" );
    skipto::function_eb91535d( "loose_ends", &namespace_ef60e103::function_2435d3e, &namespace_ef60e103::function_7ab616c1, "Loose Ends", &namespace_ef60e103::function_8f77588 );
    
    /#
        level.var_965c6227[ #"infil" ] = [ "<dev string:x38>", "<dev string:x41>", "<dev string:x4c>", "<dev string:x56>" ];
        level.var_965c6227[ #"emp_flash" ] = [ "<dev string:x62>", "<dev string:x41>", "<dev string:x69>", "<dev string:x56>" ];
        level.var_965c6227[ #"courtyard" ] = [ "<dev string:x72>", "<dev string:x7f>", "<dev string:x4c>", "<dev string:x56>" ];
        level.var_965c6227[ #"hash_290c103dfab4ef4f" ] = [ "<dev string:x89>", "<dev string:x7f>", "<dev string:x97>", "<dev string:x56>" ];
        level.var_965c6227[ #"outro" ] = [ "<dev string:x9f>", "<dev string:x7f>", "<dev string:x69>", "<dev string:x56>" ];
        level.var_965c6227[ #"hash_9ed59b801f5827f" ] = [ "<dev string:xa8>", "<dev string:x7f>", "<dev string:x69>", "<dev string:x56>" ];
    #/
}

// Namespace cp_rus_siege/cp_rus_siege
// Params 0
// Checksum 0xd3180b3f, Offset: 0x948
// Size: 0x24
function play_radar_fx()
{
    self clientfield::increment( "play_radar_fx" );
}

// Namespace cp_rus_siege/cp_rus_siege
// Params 0
// Checksum 0x422034bd, Offset: 0x978
// Size: 0x24
function kill_radar_fx()
{
    self clientfield::increment( "kill_radar_fx" );
}

