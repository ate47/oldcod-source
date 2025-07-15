#using scripts/cp/_ammo_cache;
#using scripts/cp/_collectibles;
#using scripts/cp/_elevator;
#using scripts/cp/_load;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/_vehicle_platform;
#using scripts/cp/cp_mi_cairo_lotus_anim;
#using scripts/cp/cp_mi_cairo_lotus_fx;
#using scripts/cp/cp_mi_cairo_lotus_sound;
#using scripts/cp/gametypes/_save;
#using scripts/cp/lotus_accolades;
#using scripts/cp/lotus_security_station;
#using scripts/cp/lotus_start_riot;
#using scripts/cp/lotus_util;
#using scripts/cp/voice/voice_lotus1;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/player_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace cp_mi_cairo_lotus;

// Namespace cp_mi_cairo_lotus
// Params 0
// Checksum 0x3c30d552, Offset: 0x690
// Size: 0x32
function setup_rex_starts()
{
    util::add_gametype( "coop" );
    util::add_gametype( "cpzm" );
}

// Namespace cp_mi_cairo_lotus
// Params 0
// Checksum 0x1346e04b, Offset: 0x6d0
// Size: 0xda
function function_70a1a72e()
{
    nd_traversal_floor = getnode( "start_mobile_0_top_across_128", "targetname" );
    linktraversal( nd_traversal_floor );
    unlinktraversal( nd_traversal_floor );
    nd_traversal_accross = getnode( "start_mobile_0_across_128", "targetname" );
    linktraversal( nd_traversal_accross );
    unlinktraversal( nd_traversal_accross );
    nd_traversal_side = getnode( "start_mobile_0_up_160", "targetname" );
    linktraversal( nd_traversal_side );
    unlinktraversal( nd_traversal_side );
}

// Namespace cp_mi_cairo_lotus
// Params 0
// Checksum 0x64252995, Offset: 0x7b8
// Size: 0x26a
function main()
{
    if ( sessionmodeiscampaignzombiesgame() && -1 )
    {
        setclearanceceiling( 34 );
    }
    else
    {
        setclearanceceiling( 23 );
    }
    
    function_70a1a72e();
    savegame::set_mission_name( "lotus" );
    
    if ( !sessionmodeiscampaignzombiesgame() )
    {
        level.overrideammodropteam3 = 1;
        callback::on_spawned( &on_player_spawned );
    }
    
    voice_lotus1::init_voice();
    util::init_streamer_hints( 3 );
    precache();
    init_clientfields();
    init_flags();
    setup_skiptos();
    function_e8474b63();
    collectibles::function_93523442( "p7_nc_cai_lot_05", 45, ( 0, -20, 0 ) );
    cp_mi_cairo_lotus_anim::main();
    cp_mi_cairo_lotus_fx::main();
    cp_mi_cairo_lotus_sound::main();
    lotus_start_riot::init();
    lotus_security_station::init();
    load::main();
    skipto::set_skip_safehouse();
    level thread lotus_util::function_d720c23e( "atrium_battle_a" );
    level thread lotus_util::function_d720c23e( "atrium_battle_b" );
    level thread lotus_util::function_d720c23e( "atrium_battle_c" );
    level thread lotus_util::function_d720c23e( "atrium_battle_d" );
    level thread lotus_util::function_d720c23e( "atrium_battle_e" );
    level thread lotus_util::function_d720c23e( "atrium_battle_f" );
    level thread lotus_util::function_d720c23e( "atrium_battle_g" );
    level.var_dc236bc8 = 1;
    level.var_6e1075a2 = 0;
    lotus_accolades::function_66df416f();
}

// Namespace cp_mi_cairo_lotus
// Params 0
// Checksum 0xe9c07cd6, Offset: 0xa30
// Size: 0x2
function precache()
{
    
}

// Namespace cp_mi_cairo_lotus
// Params 0
// Checksum 0xa58ffcc8, Offset: 0xa40
// Size: 0x62
function init_flags()
{
    level flag::init( "hendricks_breach_line_done" );
    level flag::init( "mobile_shop_vo_done" );
    level flag::init( "security_shop_unload" );
    level flag::init( "security_shop_stopped" );
}

// Namespace cp_mi_cairo_lotus
// Params 0
// Checksum 0x5304a72b, Offset: 0xab0
// Size: 0x1a
function function_e8474b63()
{
    level scene::init( "p7_fxanim_cp_lotus_monitors_atrium_fall_bundle" );
}

// Namespace cp_mi_cairo_lotus
// Params 0
// Checksum 0x1a846df0, Offset: 0xad8
// Size: 0x2aa
function init_clientfields()
{
    visionset_mgr::register_info( "visionset", "cp_raven_hallucination", 1, 100, 1, 1 );
    clientfield::register( "world", "hs_fxinit_vent", 1, 1, "int" );
    clientfield::register( "world", "hs_fxanim_vent", 1, 1, "int" );
    clientfield::register( "world", "swap_crowd_to_riot", 1, 1, "int" );
    clientfield::register( "world", "crowd_anims_off", 1, 1, "int" );
    clientfield::register( "scriptmover", "mobile_shop_fxanims", 1, 3, "int" );
    clientfield::register( "scriptmover", "raven_decal", 1, 1, "int" );
    clientfield::register( "toplayer", "snow_fog", 1, 1, "int" );
    clientfield::register( "toplayer", "postfx_futz", 1, 1, "counter" );
    clientfield::register( "toplayer", "postfx_ravens", 1, 1, "counter" );
    clientfield::register( "toplayer", "postfx_frozen_forest", 1, 1, "counter" );
    clientfield::register( "toplayer", "frost_post_fx", 1, 1, "int" );
    clientfield::register( "allplayers", "player_frost_breath", 1, 1, "int" );
    clientfield::register( "actor", "hendricks_frost_breath", 1, 1, "int" );
    clientfield::register( "toplayer", "pickup_hakim_rumble_loop", 1, 1, "int" );
    clientfield::register( "toplayer", "mobile_shop_rumble_loop", 1, 1, "int" );
    clientfield::register( "toplayer", "player_dust_fx", 1, 1, "int" );
}

// Namespace cp_mi_cairo_lotus
// Params 0
// Checksum 0x2a79f6a4, Offset: 0xd90
// Size: 0x252
function setup_skiptos()
{
    skipto::add( "plan_b", &lotus_start_riot::plan_b_main, undefined, &lotus_start_riot::plan_b_done );
    skipto::add( "start_the_riots", &lotus_start_riot::function_5fb7ec5, undefined, &lotus_start_riot::start_the_riots_done );
    skipto::function_d68e678e( "general_hakim", &lotus_start_riot::general_hakim_main, undefined, &lotus_start_riot::general_hakim_done );
    skipto::function_d68e678e( "apartments", &lotus_security_station::function_cd269efc, undefined, &lotus_security_station::apartments_done );
    skipto::function_d68e678e( "atrium_battle", &lotus_security_station::atrium_battle, undefined, &lotus_security_station::atrium_battle_done );
    skipto::function_d68e678e( "to_security_station", &lotus_security_station::to_security_station, undefined, &lotus_security_station::to_security_station_done );
    skipto::function_d68e678e( "hack_the_system", &lotus_security_station::hack_the_system_main, undefined, &lotus_security_station::hack_the_system_done );
    
    /#
        skipto::add_dev( "<dev string:x28>", &skipto_lotus_2 );
        skipto::add_dev( "<dev string:x3f>", &skipto_lotus_3 );
        skipto::add_dev( "<dev string:x56>", &function_50499b8 );
        skipto::add_dev( "<dev string:x68>", &function_770c08f3 );
        skipto::add_dev( "<dev string:x7a>", &function_51098e8a );
    #/
}

/#

    // Namespace cp_mi_cairo_lotus
    // Params 2
    // Checksum 0x9b23dcf, Offset: 0xff0
    // Size: 0x42, Type: dev
    function skipto_lotus_2( str_objective, b_starting )
    {
        switchmap_load( "<dev string:x8c>" );
        wait 0.05;
        switchmap_switch();
    }

    // Namespace cp_mi_cairo_lotus
    // Params 2
    // Checksum 0x6e9fac29, Offset: 0x1040
    // Size: 0x42, Type: dev
    function skipto_lotus_3( str_objective, b_starting )
    {
        switchmap_load( "<dev string:x9f>" );
        wait 0.05;
        switchmap_switch();
    }

    // Namespace cp_mi_cairo_lotus
    // Params 2
    // Checksum 0xdec1b2ec, Offset: 0x1090
    // Size: 0x2a, Type: dev
    function function_50499b8( str_objective, b_starting )
    {
        function_3330eab6( "<dev string:xb2>" );
    }

    // Namespace cp_mi_cairo_lotus
    // Params 2
    // Checksum 0x8a2691aa, Offset: 0x10c8
    // Size: 0x2a, Type: dev
    function function_770c08f3( str_objective, b_starting )
    {
        function_3330eab6( "<dev string:xda>" );
    }

    // Namespace cp_mi_cairo_lotus
    // Params 2
    // Checksum 0x523f9d86, Offset: 0x1100
    // Size: 0x2a, Type: dev
    function function_51098e8a( str_objective, b_starting )
    {
        function_3330eab6( "<dev string:x102>" );
    }

    // Namespace cp_mi_cairo_lotus
    // Params 1
    // Checksum 0x77eae6df, Offset: 0x1138
    // Size: 0x32, Type: dev
    function function_3330eab6( str_anim )
    {
        level flag::wait_till( "<dev string:x12a>" );
        scene::play( str_anim );
    }

#/

// Namespace cp_mi_cairo_lotus
// Params 0
// Checksum 0xe9c07cd6, Offset: 0x1178
// Size: 0x2
function on_player_spawned()
{
    
}

