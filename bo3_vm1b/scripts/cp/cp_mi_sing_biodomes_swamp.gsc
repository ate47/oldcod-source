#using scripts/codescripts/struct;
#using scripts/cp/_debug;
#using scripts/cp/_dialog;
#using scripts/cp/_hazard;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_biodomes2_sound;
#using scripts/cp/cp_mi_sing_biodomes_accolades;
#using scripts/cp/cp_mi_sing_biodomes_supertrees;
#using scripts/cp/cp_mi_sing_biodomes_util;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/hud_message_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/teamgather_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicleriders_shared;

#namespace cp_mi_sing_biodomes_swamp;

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x1fd1910b, Offset: 0x1f88
// Size: 0x52
function main()
{
    function_80f24610();
    spawner::add_spawn_function_group( "attacking_wasp", "script_noteworthy", &function_2297c05c );
    setup_scenes();
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0xa6aa4ed7, Offset: 0x1fe8
// Size: 0x62
function setup_scenes()
{
    scene::add_scene_func( "cin_bio_15_02_player_vign_ontoboat_portnear", &scene_player_onto_boat_play, "play" );
    scene::add_scene_func( "cin_bio_15_02_player_vign_ontoboat_starboardnear", &scene_player_onto_boat_play, "play" );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x9fddfa6, Offset: 0x2058
// Size: 0x10a
function function_80f24610()
{
    level.var_c141dfcb = [];
    level.var_de54cf10 = 0;
    level.var_242afa66 = 0;
    level.var_197b567a = 0;
    level.a_t_boats = [];
    level.a_t_boats[ "boat1_seat1" ] = getent( "trigger_boat_1_seat1", "targetname" );
    level.a_t_boats[ "boat1_seat2" ] = getent( "trigger_boat_1_seat2", "targetname" );
    level.a_t_boats[ "boat2_seat1" ] = getent( "trigger_boat_2_seat1", "targetname" );
    level.a_t_boats[ "boat2_seat2" ] = getent( "trigger_boat_2_seat2", "targetname" );
    biodomes_accolades::function_b5aa3655();
    biodomes_accolades::function_10fc44d8();
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 2
// Checksum 0xde9cb586, Offset: 0x2170
// Size: 0x442
function objective_swamps_init( str_objective, b_starting )
{
    cp_mi_sing_biodomes_util::objective_message( "objective_swamps_init" );
    exploder::exploder( "fx_expl_swamp_swim" );
    exploder::exploder( "fx_expl_swamp_rail" );
    exploder::stop_exploder( "fx_expl_supertree_collapse" );
    exploder::stop_exploder( "fx_expl_lowerplatform_supertree" );
    exploder::stop_exploder( "fx_expl_fire_boat_explode" );
    level thread function_2ebccf5();
    
    if ( b_starting )
    {
        load::function_73adcefc();
        level.ai_hendricks = util::get_hero( "hendricks" );
        cp_mi_sing_biodomes_util::init_hendricks( str_objective );
        level.ai_hendricks thread function_dd9ded92();
        level flag::set( "player_dive_done" );
        level flag::set( "hendricks_dive" );
        level flag::set( "player_reached_bottom_finaltree" );
        level flag::set( "player_reached_top_finaltree" );
        level flag::set( "any_player_reached_bottom_finaltree" );
        level flag::set( "hendricks_played_supertree_takedown" );
        level thread function_b52b6eac();
        array::thread_all( level.players, &function_39af75ef, "boats_go" );
        var_57a51f3c = getent( "vista_water", "targetname" );
        var_57a51f3c delete();
        load::function_a2995f22();
    }
    
    if ( level.var_adcba170 !== 1 )
    {
        objectives::set( "cp_level_biodomes_jump_from_supertree" );
        objectives::complete( "cp_level_biodomes_jump_from_supertree" );
        level.var_adcba170 = 1;
    }
    
    level thread vo_swamp();
    objectives::set( "cp_level_biodomes_dock_hendricks", struct::get( "dock_waypoint" ) );
    
    foreach ( player in level.activeplayers )
    {
        player util::show_hint_text( &"COOP_SWIM_INSTRUCTIONS" );
    }
    
    trigger::wait_till( "t_player_dock" );
    objectives::complete( "cp_level_biodomes_dock_hendricks" );
    objectives::set( "cp_level_biodomes_secure_the_dock" );
    level waittill( #"hash_691476e5" );
    objectives::complete( "cp_level_biodomes_secure_the_dock" );
    
    if ( level.players.size == 1 )
    {
        objectives::set( "cp_level_biodomes_escape", struct::get( "airboat_waypoint_solo" ) );
        function_310b4b12( 0, 0, level.players.size );
        level thread function_1f65dbfc();
    }
    else
    {
        objectives::set( "cp_level_biodomes_escape", struct::get( "airboat_waypoint" ) );
        function_310b4b12( 0, 0 );
    }
    
    if ( level.players.size > 2 )
    {
        function_310b4b12( 1, 0 );
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0xeee14ac6, Offset: 0x25c0
// Size: 0x8a
function function_1f65dbfc()
{
    while ( level.players.size == 1 )
    {
        wait 0.05;
    }
    
    objectives::set( "cp_level_biodomes_escape", struct::get( "airboat_waypoint" ) );
    objectives::complete( "cp_level_biodomes_escape", struct::get( "airboat_waypoint_solo" ) );
    function_310b4b12( 0, 0 );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 2
// Checksum 0x64f98d1, Offset: 0x2658
// Size: 0x172
function dev_swamp_rail_init( str_objective, b_starting )
{
    level.b_debug = 1;
    setdvar( "phys_buoyancy", 1 );
    setdvar( "cg_viewVehicleInfluenceGunner_mode", 1 );
    cp_mi_sing_biodomes_util::objective_message( "objective_swamps_init" );
    objectives::set( "cp_level_biodomes_escape", struct::get( "airboat_waypoint" ) );
    cp_mi_sing_biodomes_util::init_hendricks( str_objective );
    level flag::set( "hendricks_dive" );
    function_d343057f( 1 );
    level thread function_2ebccf5();
    level.ai_hendricks thread hendricks_board();
    function_310b4b12( 0, 0 );
    function_310b4b12( 1, 0 );
    var_57a51f3c = getent( "vista_water", "targetname" );
    var_57a51f3c delete();
    trigger::wait_till( "dev_trig_checkpoint" );
    savegame::checkpoint_save();
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0xb313e5b2, Offset: 0x27d8
// Size: 0x7a
function function_b52b6eac()
{
    setdvar( "phys_buoyancy", 1 );
    setdvar( "cg_viewVehicleInfluenceGunner_mode", 1 );
    level thread function_5c8dbd1b();
    level thread function_d343057f();
    level thread function_1d4f0199();
    hidemiscmodels( "fxanim_supertree" );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0xfdc05262, Offset: 0x2860
// Size: 0x402
function function_2ebccf5()
{
    level.vehicle_main_callback[ "hunter" ] = &hunter_callback;
    exploder::exploder( "grd_twr_01" );
    exploder::exploder( "grd_twr_02" );
    exploder::exploder( "grd_twr_03" );
    exploder::exploder( "grd_twr_04" );
    function_36e4a4e3( "tall_grass_boat" );
    function_35a6217a( "guard_tower_1", &function_963be5f4 );
    function_35a6217a( "guard_tower_2", &function_a59a792b );
    function_35a6217a( "guard_tower_3", &function_2f957a8e );
    function_35a6217a( "guard_tower_4", &function_a101398d );
    function_3f50cfab( 1 );
    level scene::init( "p7_fxanim_cp_biodomes_sky_bridge_bundle" );
    level thread player_protection();
    level thread airboat_rumbler();
    level thread hunter_fuel_truck();
    level thread function_fc1824d4();
    level thread function_4195b656();
    level thread function_d0b5b3de();
    level thread function_22ebbed();
    level thread function_12ca763f();
    level thread function_beedc0e7();
    level thread boat_scrape();
    level thread function_28313656();
    level thread function_2eee0c9c();
    level thread function_a903f6c1();
    level thread function_eff4afac();
    level thread function_9dd4818b();
    level thread function_95d3fd43();
    level thread function_c4fa2d2a();
    level thread function_72c5c9fd();
    level thread function_d8a75b5f();
    level thread function_dffe67b3();
    level thread function_d54492e();
    level thread function_2b6be7f7();
    level thread function_7f6a680f();
    level thread function_6111ddb4();
    level thread destroy_ferriswheel();
    level thread function_97247f7c();
    level thread function_81aca4ee();
    level thread function_452c817b();
    level thread function_9051a477();
    level thread function_c211eb0f();
    level thread function_5d6e5b81();
    level thread function_e2a7176();
    level thread function_70d3e476();
    level thread outpost_crash();
    level thread function_dacdabc9();
    level thread function_e5f905bd();
    level thread function_400cc8f4();
    level thread function_7fea5e8b();
    level thread function_daab7239();
    level thread function_ca115f5b();
    level thread function_2b558db7();
    level thread function_d665973f();
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x82119c69, Offset: 0x2c70
// Size: 0x8b
function function_df945144()
{
    var_60b2e0dc = getentarray( "t_hendricks_boat_anim", "targetname" );
    
    foreach ( t_hendricks_boat_anim in var_60b2e0dc )
    {
        t_hendricks_boat_anim thread function_e46e9d15();
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x52493da8, Offset: 0x2d08
// Size: 0x155
function function_e46e9d15()
{
    while ( true )
    {
        self trigger::wait_till();
        
        if ( self.who == level.ai_hendricks )
        {
            switch ( self.script_noteworthy )
            {
                case "left":
                    level thread scene::init( "cin_bio_15_03_waterpark_vign_lean_left" );
                    break;
                case "left_exit":
                    level scene::play( "cin_bio_15_03_waterpark_vign_lean_left" );
                    level thread scene::play( "cin_bio_15_03_waterpark_vign_lean_center" );
                    break;
                case "right":
                    level thread scene::init( "cin_bio_15_03_waterpark_vign_lean_right" );
                    break;
                case "right_exit":
                    level scene::play( "cin_bio_15_03_waterpark_vign_lean_right" );
                    level thread scene::play( "cin_bio_15_03_waterpark_vign_lean_center" );
                    break;
                case "shoot":
                    level thread scene::init( "cin_bio_15_03_waterpark_vign_shoot" );
                    break;
                default:
                    level scene::play( "cin_bio_15_03_waterpark_vign_shoot" );
                    level thread scene::play( "cin_bio_15_03_waterpark_vign_lean_center" );
                    break;
            }
            
            break;
        }
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0xa74e9577, Offset: 0x2e68
// Size: 0xc5
function function_5c8dbd1b()
{
    level endon( #"boats_ready_to_depart" );
    t_murky_water = getent( "t_murky_water", "targetname" );
    
    while ( true )
    {
        foreach ( player in level.activeplayers )
        {
            if ( player istouching( t_murky_water ) )
            {
                player.ignoreme = 1;
                continue;
            }
            
            player.ignoreme = 0;
        }
        
        wait 0.3;
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0xdce5561a, Offset: 0x2f38
// Size: 0x8b
function function_e5f905bd()
{
    t_city_land = getent( "trigger_store_crash", "targetname" );
    
    foreach ( player in level.activeplayers )
    {
        player thread jump_land_city( t_city_land );
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0xc6c813ae, Offset: 0x2fd0
// Size: 0xaa
function function_7f6a680f()
{
    trigger::wait_till( "t_stop_swamp_fire" );
    exploder::stop_exploder( "fx_expl_swamp_fire_tanker" );
    exploder::stop_exploder( "fx_expl_fire_prehunter_supertree" );
    exploder::stop_exploder( "fx_expl_fire_posthunter_supertree" );
    exploder::stop_exploder( "fx_expl_fire_arrivetop_supertree" );
    exploder::stop_exploder( "fx_expl_fire_deathtop_supertree" );
    exploder::stop_exploder( "fx_expl_fire_descendlast_supertree" );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1
// Checksum 0x24b6ddf0, Offset: 0x3088
// Size: 0xbb
function function_3f50cfab( b_hide )
{
    if ( !isdefined( b_hide ) )
    {
        b_hide = 1;
    }
    
    var_8cc31d7a = getentarray( "ferris_wheel_debris", "targetname" );
    
    foreach ( mdl in var_8cc31d7a )
    {
        if ( b_hide == 1 )
        {
            mdl hide();
            continue;
        }
        
        mdl show();
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1
// Checksum 0x1ed1453e, Offset: 0x3150
// Size: 0x1a
function function_d2e5a108( a_ents )
{
    function_3f50cfab( 0 );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x41859085, Offset: 0x3178
// Size: 0x123
function destroy_ferriswheel()
{
    trigger::wait_till( "trigger_ferriswheel_collapse" );
    scene::add_scene_func( "p7_fxanim_cp_biodomes_ferris_wheel_bundle", &function_d2e5a108, "done" );
    level thread scene::play( "p7_fxanim_cp_biodomes_ferris_wheel_bundle" );
    level waittill( #"hash_55a06ec6" );
    s_ferris_wheel_rumble = struct::get( "s_ferris_wheel_rumble", "targetname" );
    playrumbleonposition( "cp_biodomes_ferris_wheel_rumble", s_ferris_wheel_rumble.origin );
    
    foreach ( player in level.activeplayers )
    {
        player dodamage( 71, s_ferris_wheel_rumble.origin );
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 4
// Checksum 0x70a00bc0, Offset: 0x32a8
// Size: 0x62
function objective_swamps_done( str_objective, b_starting, b_direct, player )
{
    cp_mi_sing_biodomes_util::objective_message( "objective_swamps_done" );
    biodomes_accolades::function_a057c38f();
    objectives::complete( "cp_level_biodomes_extract" );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1
// Checksum 0x1a1fd294, Offset: 0x3318
// Size: 0x32
function underwater_explosion( s_target )
{
    self waittill( #"death" );
    fx::play( "depth_charge", s_target.origin );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1
// Checksum 0x538c5af4, Offset: 0x3358
// Size: 0x1e2
function function_d343057f( b_debug )
{
    if ( !isdefined( b_debug ) )
    {
        b_debug = 0;
    }
    
    level.var_c141dfcb[ 0 ] = airboat_spawn( "airboat_1" );
    level.var_c141dfcb[ 1 ] = airboat_spawn( "airboat_2" );
    level thread check_player_boarding( b_debug );
    level thread airboat_jump_land();
    level thread function_3bb88e47();
    level thread function_381c90d7();
    function_312d4b85();
    level.var_c141dfcb[ 0 ] thread igc_end();
    
    if ( level.players.size <= 2 && b_debug == 0 )
    {
        function_c98db861( 1 );
    }
    
    level.var_78a73398 = [];
    
    for ( i = 0; i < 2 ; i++ )
    {
        level.var_78a73398[ i ] = util::spawn_model( "tag_origin", level.var_c141dfcb[ i ].origin, level.var_c141dfcb[ i ].angles );
        level.var_78a73398[ i ] linkto( level.var_c141dfcb[ i ], "tag_origin", ( 350, 0, 30 ) );
        level.var_78a73398[ i ].team = "allies";
        level.var_78a73398[ i ].health = 10000;
        level.var_78a73398[ i ].takedamage = 0;
    }
    
    level flag::set( "boats_init" );
    
    /#
        level thread function_73defa42();
    #/
}

/#

    // Namespace cp_mi_sing_biodomes_swamp
    // Params 0
    // Checksum 0x4d8a69c4, Offset: 0x3548
    // Size: 0x85, Type: dev
    function function_73defa42()
    {
        while ( true )
        {
            foreach ( mdl_target in level.var_78a73398 )
            {
                debug::drawarrow( mdl_target.origin, mdl_target.angles );
            }
            
            wait 0.05;
        }
    }

#/

// Namespace cp_mi_sing_biodomes_swamp
// Params 1
// Checksum 0x8d8c24c2, Offset: 0x35d8
// Size: 0x17a
function function_c98db861( b_hide )
{
    var_ec8cfe95 = getent( "boat_bottom_clip_02", "targetname" );
    
    if ( b_hide == 1 )
    {
        if ( level.var_de54cf10 == 0 )
        {
            var_ec8cfe95 notsolid();
            level.var_c141dfcb[ 1 ] notsolid();
            level.var_c141dfcb[ 1 ] ghost();
            level.var_c141dfcb[ 1 ] makevehicleunusable();
            level.var_c141dfcb[ 1 ] clientfield::set( "boat_disable_sfx", 1 );
            function_310b4b12( 1, 1 );
            level.var_de54cf10 = 1;
        }
        
        return;
    }
    
    if ( level.var_de54cf10 == 1 )
    {
        var_ec8cfe95 solid();
        level.var_c141dfcb[ 1 ] solid();
        level.var_c141dfcb[ 1 ] show();
        level.var_c141dfcb[ 1 ] makevehicleusable();
        level.var_c141dfcb[ 1 ] clientfield::set( "boat_disable_sfx", 0 );
        function_310b4b12( 1, 0 );
        level.var_de54cf10 = 0;
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1
// Checksum 0x7717098e, Offset: 0x3760
// Size: 0xca
function function_e5108e73( b_hide )
{
    if ( b_hide == 1 )
    {
        if ( level.var_de54cf10 == 0 )
        {
            level.var_c141dfcb[ 1 ] ghost();
            level.var_c141dfcb[ 1 ] clientfield::set( "boat_disable_sfx", 1 );
            level.var_de54cf10 = 1;
        }
        
        return;
    }
    
    if ( level.var_de54cf10 == 1 )
    {
        level.var_c141dfcb[ 1 ] show();
        level.var_c141dfcb[ 1 ] clientfield::set( "boat_disable_sfx", 0 );
        
        if ( level.var_242afa66 == 0 )
        {
        }
        
        if ( level.var_197b567a == 1 )
        {
        }
        
        level.var_de54cf10 = 0;
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 2
// Checksum 0x77b90ecf, Offset: 0x3838
// Size: 0x8c
function airboat_spawn( var_be93bd02, e_boat )
{
    e_boat = vehicle::simple_spawn_single( var_be93bd02 );
    e_boat setcandamage( 0 );
    e_boat makevehicleusable();
    e_boat thread airboat_depart();
    e_boat setseatoccupied( 1, 1 );
    e_boat setseatoccupied( 2, 1 );
    return e_boat;
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0xe4ceb8d7, Offset: 0x38d0
// Size: 0xe3
function function_3bb88e47()
{
    v_offset = ( 0, 0, 0 );
    
    foreach ( t_boat in level.a_t_boats )
    {
        t_boat show();
        t_boat.e_use_object = util::init_interactive_gameobject( t_boat, &"cp_prompt_entervehicle_biodomes_boat", &"CP_MI_SING_BIODOMES_AIRBOAT", &function_5e1bcb15 );
        t_boat.e_use_object thread gameobjects::hide_icon_distance_and_los( ( 1, 1, 1 ), 600, 0 );
        t_boat.e_use_object gameobjects::disable_object();
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1
// Checksum 0xccaff1b4, Offset: 0x39c0
// Size: 0x271
function function_5e1bcb15( e_player )
{
    switch ( self.trigger.targetname )
    {
        case "trigger_boat_1_seat1":
            level.var_c141dfcb[ 0 ] setseatoccupied( 1, 0 );
            self gameobjects::disable_object();
            e_player.var_462738ee = level.var_c141dfcb[ 0 ].script_int;
            e_player.n_seat = 1;
            e_player thread player_boards_boat( level.var_c141dfcb[ 0 ] );
            e_player thread function_b7a3f7a0( 1, self );
            break;
        case "trigger_boat_1_seat2":
            level.var_c141dfcb[ 0 ] setseatoccupied( 2, 0 );
            e_player.var_462738ee = level.var_c141dfcb[ 0 ].script_int;
            e_player.n_seat = 2;
            e_player thread player_boards_boat( level.var_c141dfcb[ 0 ] );
            self gameobjects::disable_object();
            e_player thread function_b7a3f7a0( 2, self );
            break;
        case "trigger_boat_2_seat1":
            level.var_c141dfcb[ 1 ] setseatoccupied( 1, 0 );
            e_player.var_462738ee = level.var_c141dfcb[ 1 ].script_int;
            e_player.n_seat = 1;
            e_player thread player_boards_boat( level.var_c141dfcb[ 1 ] );
            self gameobjects::disable_object();
            e_player thread function_b7a3f7a0( 1, self );
            break;
        case "trigger_boat_2_seat2":
            level.var_c141dfcb[ 1 ] setseatoccupied( 2, 0 );
            e_player.var_462738ee = level.var_c141dfcb[ 1 ].script_int;
            e_player.n_seat = 2;
            e_player thread player_boards_boat( level.var_c141dfcb[ 1 ] );
            self gameobjects::disable_object();
            e_player thread function_b7a3f7a0( 1, self );
            break;
        default:
            break;
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 2
// Checksum 0x4c1f6b71, Offset: 0x3c40
// Size: 0x8a
function function_b7a3f7a0( n_seat, e_gameobject )
{
    self endon( #"death" );
    level endon( #"boats_go" );
    util::wait_network_frame();
    self waittill( #"exit_vehicle", vh_boat );
    self.overrideplayerdamage = undefined;
    vh_boat setseatoccupied( n_seat, 1 );
    e_gameobject gameobjects::enable_object();
    level flag::clear( "all_players_on_boats" );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x576a8110, Offset: 0x3cd8
// Size: 0x93
function function_381c90d7()
{
    level flag::wait_till( "boats_go" );
    
    foreach ( t_boat in level.a_t_boats )
    {
        t_boat.e_use_object gameobjects::destroy_object();
        t_boat delete();
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 3
// Checksum 0x29d970da, Offset: 0x3d78
// Size: 0xc1
function function_310b4b12( var_62f1cf67, b_hide, var_52c8d3d6 )
{
    if ( !isdefined( var_52c8d3d6 ) )
    {
        var_52c8d3d6 = 2;
    }
    
    var_462738ee = var_62f1cf67 + 1;
    
    for ( i = 1; i <= var_52c8d3d6 ; i++ )
    {
        if ( b_hide )
        {
            level.a_t_boats[ "boat" + var_462738ee + "_seat" + i ].e_use_object gameobjects::disable_object();
            continue;
        }
        
        level.a_t_boats[ "boat" + var_462738ee + "_seat" + i ].e_use_object gameobjects::enable_object();
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x8a09ffb, Offset: 0x3e48
// Size: 0x8b
function airboat_rumbler()
{
    a_t_rumble = getentarray( "trigger_boat_rumble", "targetname" );
    
    foreach ( t_rumble in a_t_rumble )
    {
        t_rumble thread rumble_airboat_passengers();
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0xec80b8a4, Offset: 0x3ee0
// Size: 0xbd
function rumble_airboat_passengers()
{
    level endon( #"ride_over" );
    
    while ( true )
    {
        self waittill( #"trigger", player );
        
        if ( isplayer( player ) )
        {
            player playrumbleonentity( "cp_biodomes_airboat_start_rumble" );
            player clientfield::increment_to_player( "sound_evt_boat_rattle" );
            wait 0.3;
            
            while ( player istouching( self ) )
            {
                player playrumbleonentity( "cp_biodomes_airboat_rumble" );
                wait 0.1;
            }
            
            player playrumbleonentity( "cp_biodomes_airboat_stop_rumble" );
        }
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x49e7d874, Offset: 0x3fa8
// Size: 0xf5
function boat_scrape()
{
    t_boat = getent( "trigger_boat_scrape", "targetname" );
    t_boat waittill( #"trigger" );
    level.var_c141dfcb[ 1 ] clientfield::increment( "sound_evt_boat_scrape_impact" );
    
    while ( level.var_c141dfcb[ 1 ] istouching( t_boat ) )
    {
        v_forward = level.var_c141dfcb[ 1 ].origin + anglestoforward( level.var_c141dfcb[ 1 ].angles ) * -106;
        v_pos = level.var_c141dfcb[ 1 ].origin + v_forward;
        
        if ( level.var_de54cf10 == 0 )
        {
            fx::play( "boat_sparks", v_forward );
        }
        
        wait 0.1;
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x8ecb2872, Offset: 0x40a8
// Size: 0x202
function force_player_onboard()
{
    a_riders1 = [];
    a_riders1 = level.var_c141dfcb[ 0 ] getvehoccupants();
    a_riders2 = [];
    a_riders2 = level.var_c141dfcb[ 1 ] getvehoccupants();
    
    if ( !a_riders1.size )
    {
        level.var_c141dfcb[ 0 ] setseatoccupied( 1, 0 );
        level.var_c141dfcb[ 0 ] usevehicle( self, 1 );
        return;
    }
    
    if ( a_riders1.size < 2 )
    {
        n_seat = level.var_c141dfcb[ 0 ] getoccupantseat( a_riders1[ 0 ] );
        
        if ( n_seat == 1 )
        {
            level.var_c141dfcb[ 0 ] setseatoccupied( 2, 0 );
            level.var_c141dfcb[ 0 ] usevehicle( self, 2 );
        }
        else
        {
            level.var_c141dfcb[ 0 ] setseatoccupied( 1, 0 );
            level.var_c141dfcb[ 0 ] usevehicle( self, 1 );
        }
        
        return;
    }
    
    if ( !a_riders2.size )
    {
        level.var_c141dfcb[ 1 ] setseatoccupied( 1, 0 );
        level.var_c141dfcb[ 1 ] usevehicle( self, 1 );
        return;
    }
    
    n_seat = level.var_c141dfcb[ 1 ] getoccupantseat( a_riders2[ 0 ] );
    
    if ( n_seat == 1 )
    {
        level.var_c141dfcb[ 1 ] setseatoccupied( 2, 0 );
        level.var_c141dfcb[ 1 ] usevehicle( self, 2 );
        return;
    }
    
    level.var_c141dfcb[ 1 ] setseatoccupied( 1, 0 );
    level.var_c141dfcb[ 1 ] usevehicle( self, 1 );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 5
// Checksum 0xd5c2a9a1, Offset: 0x42b8
// Size: 0xca
function function_ef3ef43d( var_ce657c90, str_end_flag, str_anim, str_trigger, n_delay )
{
    if ( !isdefined( n_delay ) )
    {
        n_delay = 0;
    }
    
    level flag::wait_till( var_ce657c90 );
    level thread scene::init( str_anim );
    trigger::wait_till( str_trigger );
    
    if ( n_delay > 0 )
    {
        wait n_delay;
    }
    
    level scene::play( str_anim );
    level flag::set( str_end_flag );
    t_cleanup = getent( str_trigger, "targetname" );
    t_cleanup delete();
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0xba652c7e, Offset: 0x4390
// Size: 0x92
function function_dd9ded92()
{
    self notify( #"stop_following" );
    self ai::set_ignoreme( 1 );
    self ai::set_ignoreall( 1 );
    level scene::init( "cin_bio_15_01_waterpark_swim" );
    level flag::wait_till( "player_dive_done" );
    level scene::play( "cin_bio_15_01_waterpark_swim" );
    self function_eb8032ff();
    self hendricks_board();
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0xb0935c97, Offset: 0x4430
// Size: 0x5a
function hendricks_board()
{
    level endon( #"hendricks_onboard" );
    level notify( #"hash_691476e5" );
    s_board = struct::get( "hendricks_board" );
    self function_12803ed9( s_board, 3 );
    self thread hendricks_geton_boat();
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x244f9720, Offset: 0x4498
// Size: 0x177
function function_eb8032ff()
{
    self clearforcedgoal();
    self ai::set_ignoreme( 0 );
    self ai::set_ignoreall( 0 );
    level notify( #"hendricks_on_dock" );
    level flag::set( "dock_enemies_take_cover" );
    
    if ( level flag::get( "all_players_on_boats" ) )
    {
        return;
    }
    
    level endon( #"all_players_on_boats" );
    nd_dock_hendricks = getnode( "nd_dock_hendricks", "targetname" );
    self.goalradius = 16;
    self setgoal( nd_dock_hendricks );
    level flag::wait_till( "dock_enemies_retreat" );
    nd_dock_hendricks = getnode( "nd_dock_hendricks_2", "targetname" );
    self setgoal( nd_dock_hendricks );
    
    while ( true )
    {
        var_d61030ed = getaiarray( "dock_guard_ai", "targetname" );
        var_291a362b = getaiarray( "water_guard_ai", "targetname" );
        
        if ( var_d61030ed.size + var_291a362b.size == 0 )
        {
            break;
        }
        
        wait 1;
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 2
// Checksum 0x92c8191e, Offset: 0x4618
// Size: 0x1da
function function_12803ed9( s_goal, n_timeout )
{
    self ai::set_ignoreall( 1 );
    self.goalradius = 4;
    self setgoal( s_goal.origin, 1 );
    self endon( #"goal" );
    wait n_timeout;
    level flag::wait_till( "all_players_on_boats" );
    var_8c9eabdb = 1;
    
    while ( var_8c9eabdb )
    {
        var_8c9eabdb = 0;
        
        foreach ( player in level.players )
        {
            e_linked = player getlinkedent();
            
            if ( isdefined( e_linked ) )
            {
                n_seat = e_linked getoccupantseat( player );
                var_38340604 = e_linked getseatfiringangles( n_seat );
                var_28ec750e = vectornormalize( var_38340604 );
                var_f2311802 = player geteye();
                var_d35bd1db = vectornormalize( self.origin - var_f2311802 );
                
                if ( vectordot( var_28ec750e, var_d35bd1db ) < 0.7 )
                {
                    var_8c9eabdb = 1;
                }
            }
        }
        
        wait 0.1;
    }
    
    wait 1;
    self forceteleport( s_goal.origin, s_goal.angles );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x9b4ed0b3, Offset: 0x4800
// Size: 0xfa
function hendricks_geton_boat()
{
    self ai::set_ignoreme( 1 );
    self.takedamage = 0;
    self clearforcedgoal();
    level scene::init( "cin_bio_15_02_hendricks_vign_ontoboat" );
    level flag::set( "hendricks_boat_waiting" );
    level thread function_23901dfa();
    level flag::wait_till( "boats_ready_to_depart" );
    
    if ( isdefined( level.bzm_biodialogue5_4callback ) )
    {
        level thread [[ level.bzm_biodialogue5_4callback ]]();
    }
    
    level scene::play( "cin_bio_15_02_hendricks_vign_ontoboat" );
    self linkto( level.var_c141dfcb[ 0 ] );
    level flag::set( "hendricks_onboard" );
    level scene::play( "cin_bio_15_03_waterpark_vign_lean_center" );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x54bf4b2a, Offset: 0x4908
// Size: 0x112
function function_85800b08()
{
    if ( level flag::get( "boats_init" ) )
    {
        var_b0fe27c9 = level.var_c141dfcb[ 0 ] getvehoccupants();
        var_1cc0c750 = level.var_c141dfcb[ 1 ] getvehoccupants();
        
        if ( var_b0fe27c9.size == 1 || level.skipto_point == "dev_swamp_rail" && level.activeplayers.size == 1 && ( level.activeplayers.size == 4 && ( level.activeplayers.size == 3 && ( level.activeplayers.size == 2 && ( level.activeplayers.size == 1 && var_b0fe27c9.size == 1 || var_b0fe27c9.size == 2 ) || var_b0fe27c9.size + var_1cc0c750.size == 3 ) || var_b0fe27c9.size + var_1cc0c750.size == 4 ) || var_1cc0c750.size == 1 ) )
        {
            level flag::set( "all_players_on_boats" );
        }
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0xfb661746, Offset: 0x4a28
// Size: 0x93
function function_7c14c2de()
{
    n_boarded = 0;
    
    foreach ( player in level.activeplayers )
    {
        if ( player flag::exists( "player_on_boat" ) )
        {
            if ( player flag::get( "player_on_boat" ) )
            {
                n_boarded++;
            }
        }
    }
    
    return n_boarded;
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x689553e3, Offset: 0x4ac8
// Size: 0x1bd
function player_onto_boat_tracking()
{
    self endon( #"death" );
    level endon( #"boat_rail_begin" );
    
    while ( true )
    {
        if ( self flag::get( "player_on_boat" ) )
        {
            e_vehicle = self getvehicleoccupied();
            
            if ( e_vehicle === level.var_c141dfcb[ 0 ] || e_vehicle === level.var_c141dfcb[ 1 ] )
            {
                if ( level flag::get( "all_players_on_boats" ) )
                {
                    level.var_c141dfcb[ 0 ] makevehicleunusable();
                    level.var_c141dfcb[ 1 ] makevehicleunusable();
                }
            }
        }
        else if ( !self isinvehicle() && self flag::get( "player_on_boat" ) )
        {
            self flag::clear( "player_on_boat" );
        }
        
        if ( e_vehicle === level.var_c141dfcb[ 0 ] || e_vehicle === level.var_c141dfcb[ 1 ] )
        {
            if ( level flag::get( "all_players_on_boats" ) && level flag::get( "hendricks_boat_waiting" ) )
            {
                level.var_c141dfcb[ 0 ] makevehicleunusable();
                level.var_c141dfcb[ 1 ] makevehicleunusable();
                
                while ( level.activeplayers.size != function_7c14c2de() )
                {
                    wait 0.05;
                }
                
                level flag::set( "boats_ready_to_depart" );
            }
        }
        
        wait 0.05;
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1
// Checksum 0x5d3e079, Offset: 0x4c90
// Size: 0xe2
function player_boards_boat( vh_boat )
{
    self endon( #"death" );
    n_seat = self.n_seat;
    self thread reserve_seat_during_boat_anim( vh_boat, n_seat );
    
    if ( n_seat == 1 )
    {
        vh_boat scene::play( "cin_bio_15_02_player_vign_ontoboat_portnear", self );
    }
    else
    {
        vh_boat scene::play( "cin_bio_15_02_player_vign_ontoboat_starboardnear", self );
    }
    
    self.overrideplayerdamage = &function_654111e3;
    vh_boat setseatoccupied( n_seat, 0 );
    vh_boat usevehicle( self, n_seat );
    self flag::set( "player_on_boat" );
    function_85800b08();
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 13
// Checksum 0x3ebc2010, Offset: 0x4d80
// Size: 0x8b
function function_654111e3( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, iboneindex, vsurfacenormal )
{
    if ( weapon == getweapon( "turret_mil_boat_mg" ) )
    {
        idamage = 0;
    }
    
    return idamage;
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1
// Checksum 0xdf45e567, Offset: 0x4e18
// Size: 0x1d
function scene_player_onto_boat_play( a_ents )
{
    a_ents[ "player 1" ] notify( #"started_boat_anim" );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 2
// Checksum 0x1e13c118, Offset: 0x4e40
// Size: 0x32
function reserve_seat_during_boat_anim( e_boat, n_seat )
{
    self waittill( #"started_boat_anim" );
    e_boat setseatoccupied( n_seat, 1 );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1
// Checksum 0x4864ca22, Offset: 0x4e80
// Size: 0x125
function check_player_boarding( b_debug )
{
    while ( true )
    {
        n_boarded = function_7c14c2de();
        
        if ( level.activeplayers.size > 0 )
        {
            if ( b_debug == 1 && ( n_boarded == level.activeplayers.size || n_boarded == 1 ) && level flag::get( "hendricks_onboard" ) )
            {
                level flag::set( "boats_go" );
                function_df945144();
                t_swamp_oob = getent( "t_swamp_oob", "targetname" );
                t_swamp_oob delete();
                objectives::set( "cp_level_biodomes_extract" );
                break;
            }
            else if ( level flag::get( "boats_go" ) )
            {
                level flag::clear( "boats_go" );
            }
        }
        
        wait 0.05;
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0xc9adba0a, Offset: 0x4fb0
// Size: 0x21f
function airboat_depart()
{
    level flag::wait_till( "hendricks_onboard" );
    level flag::wait_till( "boats_go" );
    battlechatter::function_d9f49fba( 0 );
    self clientfield::increment( "sound_veh_airboat_start" );
    level thread namespace_76133733::function_11139d81();
    self.nd_start = getvehiclenode( self.target, "targetname" );
    hidemiscmodels( "fxanim_fish" );
    level scene::stop( "cin_bio_15_03_waterpark_vign_lean_center" );
    level thread scene::play( "cin_bio_15_03_waterpark_vign_lean_center" );
    self thread vehicle::get_on_and_go_path( self.nd_start );
    function_c5f21db5();
    wait 3;
    level.var_c141dfcb[ 0 ] setmodel( "veh_t7_mil_boat_fan_54i_wet" );
    level.var_c141dfcb[ 1 ] setmodel( "veh_t7_mil_boat_fan_54i_wet" );
    self trigger::wait_till( "t_grass_fx_on" );
    
    if ( self.targetname == "airboat_2_vh" )
    {
        level.var_197b567a = 1;
    }
    
    if ( self.targetname == "airboat_2_vh" )
    {
        if ( level.var_de54cf10 == 0 )
        {
            self fx::play( "boat_grass", undefined, undefined, "remove_boat_grass", 1, "tag_origin_animate" );
        }
    }
    else
    {
        self fx::play( "boat_grass", undefined, undefined, "remove_boat_grass", 1, "tag_origin_animate" );
    }
    
    self trigger::wait_till( "t_grass_fx_off" );
    
    if ( self.targetname == "airboat_2_vh" )
    {
        level.var_197b567a = 0;
    }
    
    self notify( #"remove_boat_grass" );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0xe2c0c87e, Offset: 0x51d8
// Size: 0x83
function player_protection()
{
    level flag::wait_till( "boats_go" );
    
    foreach ( player in level.players )
    {
        player.overrideplayerdamage = &callback_player_damage_onboat;
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 13
// Checksum 0x50245edb, Offset: 0x5268
// Size: 0x71
function callback_player_damage_onboat( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, iboneindex, vsurfacenormal )
{
    idamage = 1;
    return idamage;
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x2afc4a79, Offset: 0x52e8
// Size: 0x213
function airboat_jump_land()
{
    a_t_start = getentarray( "trigger_ramp_start", "targetname" );
    a_t_takeoff = getentarray( "trigger_ramp_end", "targetname" );
    a_t_land = getentarray( "trigger_ramp_land", "targetname" );
    
    foreach ( t_start in a_t_start )
    {
        t_start thread boat_ramp_start( level.var_c141dfcb[ 0 ] );
        t_start thread boat_ramp_start( level.var_c141dfcb[ 1 ] );
    }
    
    foreach ( t_takeoff in a_t_takeoff )
    {
        t_takeoff thread boat_ramp_takeoff( level.var_c141dfcb[ 0 ] );
        t_takeoff thread boat_ramp_takeoff( level.var_c141dfcb[ 1 ] );
    }
    
    foreach ( t_land in a_t_land )
    {
        t_land thread boat_ramp_land( level.var_c141dfcb[ 0 ] );
        t_land thread boat_ramp_land( level.var_c141dfcb[ 1 ] );
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1
// Checksum 0x17ce32d, Offset: 0x5508
// Size: 0x91
function boat_ramp_start( vh_boat )
{
    level endon( #"ride_over" );
    
    while ( true )
    {
        self waittill( #"trigger", e_trigger );
        
        if ( e_trigger == vh_boat )
        {
            vh_boat clientfield::increment( "sound_veh_airboat_ramp_hit" );
            vh_boat clientfield::increment( "sound_veh_airboat_jump" );
            vh_boat notify( #"remove_boat_trail" );
            
            if ( vh_boat.targetname == "airboat_2_vh" )
            {
                level.var_242afa66 = 1;
            }
            
            break;
        }
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1
// Checksum 0x2c3b53e5, Offset: 0x55a8
// Size: 0x51
function boat_ramp_takeoff( vh_boat )
{
    level endon( #"ride_over" );
    
    while ( true )
    {
        self waittill( #"trigger", e_trigger );
        
        if ( e_trigger == vh_boat )
        {
            vh_boat clientfield::increment( "sound_veh_airboat_jump_air" );
            break;
        }
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1
// Checksum 0x8aa8c801, Offset: 0x5608
// Size: 0xe1
function boat_ramp_land( vh_boat )
{
    level endon( #"ride_over" );
    
    while ( true )
    {
        self waittill( #"trigger", e_trigger );
        
        if ( e_trigger == vh_boat )
        {
            vh_boat clientfield::increment( "sound_veh_airboat_land" );
            
            if ( vh_boat.targetname == "airboat_2_vh" )
            {
                if ( level.var_de54cf10 == 0 )
                {
                    vh_boat fx::play( "boat_land_splash", undefined, undefined, 4, 1, "tag_origin_animate" );
                }
            }
            else
            {
                vh_boat fx::play( "boat_land_splash", undefined, undefined, 4, 1, "tag_origin_animate" );
            }
            
            if ( vh_boat.targetname == "airboat_2_vh" )
            {
                level.var_242afa66 = 0;
            }
            
            break;
        }
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 6
// Checksum 0x2688d747, Offset: 0x56f8
// Size: 0x203
function function_af6241e9( var_9eb6bd2f, var_4b32b0cc, var_be93bd02, str_notify, n_wave, var_f1faa031 )
{
    if ( !isdefined( str_notify ) )
    {
        str_notify = undefined;
    }
    
    if ( !isdefined( n_wave ) )
    {
        n_wave = 1;
    }
    
    if ( !isdefined( var_f1faa031 ) )
    {
        var_f1faa031 = 0;
    }
    
    trigger::wait_till( var_9eb6bd2f );
    
    if ( isdefined( str_notify ) )
    {
        level notify( str_notify );
    }
    
    a_nd_starts = getvehiclenodearray( var_4b32b0cc, "targetname" );
    n_path = a_nd_starts.size;
    a_vh_wasps = [];
    
    for ( j = 0; j < n_wave ; j++ )
    {
        for ( i = 0; i < n_path ; i++ )
        {
            var_b94e7fe0 = j * n_path + i;
            
            if ( !isdefined( a_vh_wasps ) )
            {
                a_vh_wasps = [];
            }
            else if ( !isarray( a_vh_wasps ) )
            {
                a_vh_wasps = array( a_vh_wasps );
            }
            
            a_vh_wasps[ a_vh_wasps.size ] = spawner::simple_spawn_single( var_be93bd02 );
            a_vh_wasps[ var_b94e7fe0 ] setforcenocull();
            
            if ( var_4b32b0cc == "nd_wheel_wasp_start" && var_b94e7fe0 == 1 )
            {
                a_vh_wasps[ 1 ] playsound( "evt_wasp_group_wheel_flyby" );
            }
            
            if ( var_4b32b0cc == "nd_bridge_wasp_start" && var_b94e7fe0 == 1 )
            {
                a_vh_wasps[ 1 ] playsound( "evt_wasp_group_bridge_flyby" );
            }
            
            wait 0.05;
            a_vh_wasps[ var_b94e7fe0 ] vehicle_ai::start_scripted();
            a_vh_wasps[ var_b94e7fe0 ] thread function_38257688();
            a_vh_wasps[ var_b94e7fe0 ] thread vehicle::get_on_and_go_path( a_nd_starts[ i ] );
        }
        
        wait var_f1faa031;
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0xe68e8f9d, Offset: 0x5908
// Size: 0x52
function function_38257688()
{
    self endon( #"death" );
    self waittill( #"reached_end_node" );
    self vehicle_ai::stop_scripted( "combat" );
    wait randomfloatrange( 0, 0.25 );
    self delete();
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x7c88c178, Offset: 0x5968
// Size: 0x2a
function function_12ca763f()
{
    function_af6241e9( "t_bridge_wasps", "nd_bridge_wasp_start", "sp_bridge_wasp", undefined, 2, 1 );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x56890da5, Offset: 0x59a0
// Size: 0x2a
function function_2eee0c9c()
{
    function_af6241e9( "t_bridge_wasps_2", "nd_bridge_wasp_2_start", "sp_bridge_wasp_2", undefined, 1, 0 );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x83a64c40, Offset: 0x59d8
// Size: 0x32
function function_beedc0e7()
{
    function_af6241e9( "t_wheel_wasps", "nd_wheel_wasp_start", "sp_wheel_wasp", "wheel_attack" );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x97044ef5, Offset: 0x5a18
// Size: 0x32
function function_6111ddb4()
{
    function_af6241e9( "t_wheel_wasps_2", "nd_wheel_wasp_2_start", "sp_wheel_wasp_2", undefined, 2, 1.5 );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x2c7d004f, Offset: 0x5a58
// Size: 0x32
function function_97247f7c()
{
    function_af6241e9( "t_plane_wasps", "nd_plane_wasp_start", "sp_plane_wasp", undefined, 3, 1.25 );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x547889bc, Offset: 0x5a98
// Size: 0x2a
function function_81aca4ee()
{
    function_af6241e9( "t_fuselage_wasps", "nd_fuselage_wasp_start", "sp_fuselage_wasp", undefined, 1, 0 );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0xd7d34d85, Offset: 0x5ad0
// Size: 0x72
function function_1d4f0199()
{
    spawner::simple_spawn( "water_guard", &water_guard_logic );
    level util::waittill_either( "hendricks_on_dock", "dock_enemies_take_cover" );
    spawner::simple_spawn( "dock_guard", &dock_guard_logic );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0xe4f6fa86, Offset: 0x5b50
// Size: 0x4a
function dock_guard_logic()
{
    self endon( #"death" );
    e_goal_volume = getent( "dock_retreat", "targetname" );
    self setgoal( e_goal_volume, 1 );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x82fb7ecd, Offset: 0x5ba8
// Size: 0x13a
function water_guard_logic()
{
    self endon( #"death" );
    self.n_goalradius_old = self.goalradius;
    self.goalradius = 16;
    self thread function_2c27934b();
    self thread function_9a7ec3e7();
    level flag::wait_till( "dock_enemies_take_cover" );
    wait randomfloatrange( 0.15, 0.95 );
    self.goalradius = self.n_goalradius_old;
    e_goal_volume = getent( "dock_goal_volume", "targetname" );
    self setgoal( e_goal_volume, 1 );
    level flag::wait_till( "dock_enemies_retreat" );
    e_goal_volume = getent( "dock_retreat", "targetname" );
    self setgoal( e_goal_volume, 1 );
    wait 5;
    trigger::use( "trig_dock_playerspawns", "targetname" );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x952a4c38, Offset: 0x5cf0
// Size: 0x8d
function function_9a7ec3e7()
{
    self endon( #"death" );
    level endon( #"dock_enemies_take_cover" );
    var_3b7123fc = getent( "t_player_dock", "targetname" );
    
    while ( true )
    {
        self waittill( #"damage", n_damage, e_attacker );
        
        if ( e_attacker istouching( var_3b7123fc ) )
        {
            level flag::set( "dock_enemies_take_cover" );
        }
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1
// Checksum 0xd1ba022e, Offset: 0x5d88
// Size: 0xca
function cleanup_guard( var_9eb6bd2f )
{
    self endon( #"death" );
    self.goalradius = 16;
    
    if ( self.script_string === "rocket_guard_boat_1" )
    {
        self thread ai::shoot_at_target( "shoot_until_target_dead", level.var_78a73398[ 0 ] );
    }
    else if ( self.script_string === "rocket_guard_boat_2" )
    {
        self thread ai::shoot_at_target( "shoot_until_target_dead", level.var_78a73398[ 1 ] );
    }
    
    trigger::wait_till( var_9eb6bd2f );
    wait randomfloatrange( 0.1, 0.15 );
    self delete();
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0xa0278ec8, Offset: 0x5e60
// Size: 0x82
function vo_swamp()
{
    level dialog::remote( "kane_stay_with_it_beat_0", 3 );
    level waittill( #"hash_691476e5" );
    battlechatter::function_d9f49fba( 0 );
    level.ai_hendricks dialog::say( "hend_kane_we_re_commande_0" );
    level dialog::remote( "kane_copy_that_overwatch_0", 1.2 );
    battlechatter::function_d9f49fba( 1 );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x7ef8b977, Offset: 0x5ef0
// Size: 0x22
function function_5441f2aa()
{
    level dialog::player_say( "plyr_you_better_drive_fas_0", 0.3 );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x968c923e, Offset: 0x5f20
// Size: 0x5a
function function_7fea5e8b()
{
    trigger::wait_till( "t_vo_hend_kane_that_ferris_wh_0" );
    level.ai_hendricks dialog::say( "hend_kane_that_ferris_wh_0" );
    level dialog::remote( "kane_on_it_hang_on_0", 0.6 );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0xc9f72300, Offset: 0x5f88
// Size: 0x3a
function function_ca115f5b()
{
    trigger::wait_till( "t_vo_hend_go_right_0" );
    level.ai_hendricks dialog::say( "hend_go_right_0" );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0xf64fabeb, Offset: 0x5fd0
// Size: 0x3a
function function_daab7239()
{
    trigger::wait_till( "t_vo_hend_go_left_go_left_0" );
    level.ai_hendricks dialog::say( "hend_go_left_go_left_0" );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0xcec1a9a9, Offset: 0x6018
// Size: 0x3a
function function_2b558db7()
{
    trigger::wait_till( "t_vo_hend_left_left_left_le_0" );
    level.ai_hendricks dialog::say( "hend_left_left_left_le_0" );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x8e908966, Offset: 0x6060
// Size: 0x32
function function_d665973f()
{
    trigger::wait_till( "t_vo_kane_hey_do_you_wanna_dr_0" );
    level dialog::remote( "kane_hey_do_you_wanna_dr_0" );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x828830a5, Offset: 0x60a0
// Size: 0x99
function function_23901dfa()
{
    level endon( #"boats_ready_to_depart" );
    level flag::wait_till( "hendricks_boat_waiting" );
    wait 10;
    a_vo = array( "hend_let_s_go_get_on_a_t_0", "hend_what_are_you_waiting_5", "hend_get_on_the_turret_w_0" );
    
    for ( i = 0; i < a_vo.size ; i++ )
    {
        level.ai_hendricks dialog::say( a_vo[ i ] );
        wait randomfloatrange( 10, 15 );
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 3
// Checksum 0xbb6c51bb, Offset: 0x6148
// Size: 0xaa
function function_fc2f856( var_d48a5688, str_vehicle, str_cleanup )
{
    vehicle::add_spawn_function( str_vehicle, &function_c37f005a, str_cleanup );
    var_77f2b279 = vehicle::simple_spawn_single( str_vehicle );
    var_77f2b279 vehicle::lights_off();
    e_gunner = spawner::simple_spawn_single( var_d48a5688, &function_c59c5367, str_cleanup );
    e_gunner vehicle::get_in( var_77f2b279, "gunner1", 1 );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1
// Checksum 0xc4a7ff7d, Offset: 0x6200
// Size: 0x32
function function_c59c5367( var_9eb6bd2f )
{
    self endon( #"death" );
    trigger::wait_till( var_9eb6bd2f );
    self delete();
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1
// Checksum 0x672fd92a, Offset: 0x6240
// Size: 0x7a
function function_c37f005a( var_9eb6bd2f )
{
    self endon( #"death" );
    
    if ( isdefined( self.target ) )
    {
        self.nd_start = getvehiclenode( self.target, "targetname" );
        self thread vehicle::get_on_and_go_path( self.nd_start );
    }
    
    trigger::wait_till( var_9eb6bd2f );
    self delete();
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x3f38c273, Offset: 0x62c8
// Size: 0x7a
function function_12771210()
{
    level thread function_fc2f856( "sp_tech_gunner", "sp_tech_outpost_1_1", "t_cleanup_tech_outpost_1" );
    level thread function_fc2f856( "sp_tech_gunner", "sp_tech_outpost_1_2", "t_cleanup_tech_outpost_1" );
    level thread function_fc2f856( "sp_tech_gunner", "sp_tech_outpost_1_3", "t_cleanup_tech_outpost_1" );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x1b0f1e89, Offset: 0x6350
// Size: 0x42
function function_22ebbed()
{
    trigger::wait_till( "t_tech_bridge_1" );
    level thread function_fc2f856( "sp_tech_gunner", "sp_tech_bridge_1", "t_cleanup_tech_bridge_1" );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x805b2000, Offset: 0x63a0
// Size: 0x42
function function_28313656()
{
    trigger::wait_till( "t_tech_bridge_2" );
    level thread function_fc2f856( "sp_tech_gunner", "sp_tech_bridge_2", "t_cleanup_tech_bridge_2" );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x816ccc5b, Offset: 0x63f0
// Size: 0x42
function function_a903f6c1()
{
    trigger::wait_till( "t_guard_tower_1_tech" );
    level thread function_fc2f856( "sp_tech_gunner", "sp_guard_tower_1_tech", "t_cleanup_guard_tower_1_tech" );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0xd02761e4, Offset: 0x6440
// Size: 0x42
function function_eff4afac()
{
    trigger::wait_till( "t_guard_tower_2_tech" );
    level thread function_fc2f856( "sp_tech_gunner", "sp_guard_tower_2_tech", "t_cleanup_guard_tower_2_tech" );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x97577ce9, Offset: 0x6490
// Size: 0x42
function function_9dd4818b()
{
    trigger::wait_till( "t_guard_tower_3_tech" );
    level thread function_fc2f856( "sp_tech_gunner", "sp_guard_tower_3_tech", "t_cleanup_guard_tower_3_tech" );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x595ca998, Offset: 0x64e0
// Size: 0x4a
function function_95d3fd43()
{
    trigger::wait_till( "t_guard_tower_1_spawn" );
    spawner::simple_spawn( "sp_guard_tower_1", &cleanup_guard, "t_cleanup_guard_tower_1" );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0xdeff352d, Offset: 0x6538
// Size: 0x4a
function function_c4fa2d2a()
{
    trigger::wait_till( "t_guard_tower_2_spawn" );
    spawner::simple_spawn( "sp_guard_tower_2", &cleanup_guard, "t_cleanup_guard_tower_2" );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x232cd0ce, Offset: 0x6590
// Size: 0x4a
function function_72c5c9fd()
{
    trigger::wait_till( "t_guard_tower_3_spawn" );
    spawner::simple_spawn( "sp_guard_tower_3", &cleanup_guard, "t_cleanup_guard_tower_3" );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x53a4e33d, Offset: 0x65e8
// Size: 0x5a
function function_4195b656()
{
    trigger::wait_till( "t_outpost_1_guards" );
    level thread function_12771210();
    spawner::simple_spawn( "outpost_1_guard", &cleanup_guard, "t_cleanup_outpost_1_guard" );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0xfe9021b5, Offset: 0x6650
// Size: 0x4a
function function_c211eb0f()
{
    trigger::wait_till( "t_outpost_2_guards" );
    spawner::simple_spawn( "outpost_2_guard", &cleanup_guard, "t_cleanup_outpost_2_guard" );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x15e2d442, Offset: 0x66a8
// Size: 0x4a
function function_d8a75b5f()
{
    trigger::wait_till( "t_building_roof_guards" );
    spawner::simple_spawn( "building_roof_guard", &cleanup_guard, "t_cleanup_building_roof_guards" );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0xe0cafe01, Offset: 0x6700
// Size: 0x62
function function_dffe67b3()
{
    trigger::wait_till( "t_building_roof_guards_ragdoll" );
    start_ragdoll( "building_roof_guard", ( randomintrange( -10, 10 ), randomintrange( -10, 10 ), randomintrange( 0, 10 ) ) );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0xbd8e13e3, Offset: 0x6770
// Size: 0x4a
function function_452c817b()
{
    trigger::wait_till( "t_guard_plane" );
    spawner::simple_spawn( "sp_guard_plane", &cleanup_guard, "t_cleanup_guard_plane" );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0xf727a4af, Offset: 0x67c8
// Size: 0x62
function function_5d6e5b81()
{
    trigger::wait_till( "t_outpost_2_guard_lower_a_ragdoll" );
    start_ragdoll( "outpost_2_guard_lower_a", ( randomintrange( -10, 10 ), randomintrange( -10, 10 ), randomintrange( 0, 10 ) ) );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0xae2a63fd, Offset: 0x6838
// Size: 0x62
function function_e2a7176()
{
    trigger::wait_till( "t_outpost_2_guard_lower_b_ragdoll" );
    start_ragdoll( "outpost_2_guard_lower_b", ( randomintrange( -10, 10 ), randomintrange( -10, 10 ), randomintrange( 0, 10 ) ) );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x7dfe635f, Offset: 0x68a8
// Size: 0x62
function function_70d3e476()
{
    trigger::wait_till( "t_outpost_2_guard_upper_ragdoll" );
    start_ragdoll( "outpost_2_guard_upper", ( randomintrange( -10, 10 ), randomintrange( -10, 10 ), randomintrange( 0, 10 ) ) );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x162ccbb1, Offset: 0x6918
// Size: 0x92
function function_fc1824d4()
{
    level thread function_f0265b78( "t_outpost_01_s01", "p7_fxanim_cp_biodomes_outpost_01_s01_bundle", &function_ba87a724 );
    level thread function_f0265b78( "t_outpost_01_s02", "p7_fxanim_cp_biodomes_outpost_01_s02_bundle", &function_14648c5b );
    level thread function_f0265b78( "t_outpost_01_s03", "p7_fxanim_cp_biodomes_outpost_01_s03_bundle", &function_1632053e );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0xe82cd187, Offset: 0x69b8
// Size: 0x32
function function_9051a477()
{
    level thread function_f0265b78( "t_outpost_02", "p7_fxanim_cp_biodomes_outpost_01_s04_bundle", &function_444a6a70 );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 3
// Checksum 0xbacb8097, Offset: 0x69f8
// Size: 0x101
function function_f0265b78( str_damage_trigger, str_fx_anim, var_65f020d3 )
{
    if ( !isdefined( var_65f020d3 ) )
    {
        var_65f020d3 = undefined;
    }
    
    t_damage = getent( str_damage_trigger, "targetname" );
    
    if ( isdefined( var_65f020d3 ) )
    {
        scene::add_scene_func( str_fx_anim, var_65f020d3, "play" );
    }
    
    while ( true )
    {
        t_damage waittill( #"damage", damage, attacker, direction, point, type, tagname, modelname, partname, weapon );
        
        if ( isplayer( attacker ) )
        {
            level thread scene::play( str_fx_anim );
            break;
        }
        
        wait 0.1;
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1
// Checksum 0xaf2db427, Offset: 0x6b08
// Size: 0x22
function function_963be5f4( a_ents )
{
    function_5bd584eb( "tower_guard_1" );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1
// Checksum 0xcbbb330b, Offset: 0x6b38
// Size: 0x3a
function function_a59a792b( a_ents )
{
    function_5bd584eb( "tower_guard_2" );
    exploder::stop_exploder( "grd_twr_02" );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1
// Checksum 0x2ed31f08, Offset: 0x6b80
// Size: 0x3a
function function_2f957a8e( a_ents )
{
    function_5bd584eb( "tower_guard_3" );
    exploder::stop_exploder( "grd_twr_03" );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1
// Checksum 0xb0b5acdc, Offset: 0x6bc8
// Size: 0x3a
function function_a101398d( a_ents )
{
    function_5bd584eb( "tower_guard_4" );
    exploder::stop_exploder( "grd_twr_01" );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1
// Checksum 0x46770581, Offset: 0x6c10
// Size: 0x22
function function_ba87a724( a_ents )
{
    function_5bd584eb( "outpost_guard_s1" );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1
// Checksum 0x4a363b58, Offset: 0x6c40
// Size: 0x22
function function_14648c5b( a_ents )
{
    function_5bd584eb( "outpost_guard_s2" );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1
// Checksum 0x262572cb, Offset: 0x6c70
// Size: 0x22
function function_1632053e( a_ents )
{
    function_5bd584eb( "outpost_guard_s3" );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1
// Checksum 0xf351dad7, Offset: 0x6ca0
// Size: 0x4a
function function_444a6a70( a_ents )
{
    function_5bd584eb( "tower_2_guard" );
    exploder::stop_exploder( "grd_twr_04" );
    biodomes_accolades::function_b5cf7b68();
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 2
// Checksum 0xb9c4f8dd, Offset: 0x6cf8
// Size: 0xbb
function start_ragdoll( str_ai_name, v_force )
{
    a_ai = getentarray( str_ai_name, "script_noteworthy", 1 );
    
    foreach ( ai in a_ai )
    {
        if ( isalive( ai ) )
        {
            ai startragdoll();
            ai launchragdoll( v_force );
        }
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1
// Checksum 0xde5a5801, Offset: 0x6dc0
// Size: 0x129
function function_5bd584eb( str_ai_name )
{
    a_ai = getentarray( str_ai_name, "script_noteworthy", 1 );
    
    foreach ( ai in a_ai )
    {
        if ( isalive( ai ) )
        {
            n_animation = randomintrange( 1, 4 );
            
            switch ( n_animation )
            {
                case 1:
                    ai thread scene::play( "cin_gen_xplode_death_1", ai );
                    break;
                case 2:
                    ai thread scene::play( "cin_gen_xplode_death_2", ai );
                    break;
                case 3:
                    ai thread scene::play( "cin_gen_xplode_death_3", ai );
                    break;
                default:
                    break;
            }
        }
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0xb307a397, Offset: 0x6ef8
// Size: 0x141
function function_2c27934b()
{
    self endon( #"death" );
    level endon( #"hendricks_on_dock" );
    a_s_targets = struct::get_array( "s_murky_water_target", "targetname" );
    e_target = spawn( "script_model", ( 0, 0, 0 ) );
    e_target setmodel( "tag_origin" );
    e_target.health = 1000;
    e_target.takedamage = 0;
    
    while ( true )
    {
        if ( !isdefined( self.enemy ) )
        {
            n_target_index = randomint( a_s_targets.size );
            n_duration = randomfloatrange( 0.5, 1.5 );
            e_target.origin = a_s_targets[ n_target_index ].origin;
            self thread ai::shoot_at_target( "normal", e_target, "tag_origin", n_duration );
            wait n_duration;
            wait randomfloatrange( 0.2, 0.8 );
            continue;
        }
        
        wait 0.1;
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x749b0a67, Offset: 0x7048
// Size: 0xb4
function function_d0b5b3de()
{
    trigger::wait_till( "trig_swamp_rail_rpg_warning" );
    weapon = getweapon( "smaw" );
    var_11fd5f3f = struct::get( "swamp_rail_rpg_warning_launch", "targetname" );
    var_6beedec9 = struct::get( "swamp_rail_rpg_warning_target", "targetname" );
    e_rocket = magicbullet( weapon, var_11fd5f3f.origin, var_6beedec9.origin );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0xbfe5fd4b, Offset: 0x7108
// Size: 0x1da
function hunter_callback()
{
    self endon( #"death" );
    target_set( self, ( 0, 0, 0 ) );
    self useanimtree( $generic );
    self.health = self.healthdefault;
    self vehicle::friendly_fire_shield();
    self.takedamage = 0;
    self enableaimassist();
    self setneargoalnotifydist( 50 );
    self sethoverparams( 15, 100, 40 );
    self.flyheight = getdvarfloat( "g_quadrotorFlyHeight" );
    self.fovcosine = 0;
    self.fovcosinebusy = 0.574;
    self.vehaircraftcollisionenabled = 1;
    self.original_vehicle_type = self.vehicletype;
    self.settings = struct::get_script_bundle( "vehiclecustomsettings", self.scriptbundlesettings );
    self.goalradius = 300;
    self.goalheight = 512;
    self hunter_inittagarrays();
    self.overridevehicledamage = &huntercallback_vehicledamage;
    self thread vehicle_ai::nudge_collision();
    self turret::_init_turret( 1 );
    self turret::_init_turret( 2 );
    self turret::set_burst_parameters( 1, 2, 1, 2, 1 );
    self turret::set_burst_parameters( 1, 2, 1, 2, 2 );
    self turret::set_target_flags( 3, 1 );
    self turret::set_target_flags( 3, 2 );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 15
// Checksum 0xc2fba404, Offset: 0x72f0
// Size: 0xa6
function huntercallback_vehicledamage( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal )
{
    damagelevelchanged = vehicle::update_damage_fx_level( self.health, idamage, self.healthdefault );
    return idamage;
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x30cf3a30, Offset: 0x73a0
// Size: 0xdb
function hunter_inittagarrays()
{
    self.missiletags = [];
    
    if ( !isdefined( self.missiletags ) )
    {
        self.missiletags = [];
    }
    else if ( !isarray( self.missiletags ) )
    {
        self.missiletags = array( self.missiletags );
    }
    
    self.missiletags[ self.missiletags.size ] = "tag_rocket1";
    
    if ( !isdefined( self.missiletags ) )
    {
        self.missiletags = [];
    }
    else if ( !isarray( self.missiletags ) )
    {
        self.missiletags = array( self.missiletags );
    }
    
    self.missiletags[ self.missiletags.size ] = "tag_rocket2";
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x1a5e18c5, Offset: 0x7488
// Size: 0xd7
function hunter_fuel_truck()
{
    level flag::wait_till( "boats_ready_to_depart" );
    level flag::set( "boat_rail_begin" );
    objectives::complete( "cp_level_biodomes_escape" );
    vh_hunter = spawner::simple_spawn_single( "sp_hunter_fuel_truck", &function_fb738343 );
    
    foreach ( player in level.players )
    {
        player.var_32218fc7 = 1;
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0xea3c6a25, Offset: 0x7568
// Size: 0x3c
function function_d54492e()
{
    level waittill( #"wheel_attack" );
    vh_hunter = spawner::simple_spawn_single( "sp_hunter_wheel_attack", &function_243196a7 );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0xfdce8238, Offset: 0x75b0
// Size: 0x4c
function function_2b6be7f7()
{
    trigger::wait_till( "t_hunter_water_explosion" );
    vh_hunter = spawner::simple_spawn_single( "sp_hunter_water_explosion", &function_ce0e4988 );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0xb845814b, Offset: 0x7608
// Size: 0x4c
function function_dacdabc9()
{
    trigger::wait_till( "t_hunter_final_pursuit" );
    vh_hunter = spawner::simple_spawn_single( "sp_hunter_final_pursuit", &function_e0476b5e );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x938bb790, Offset: 0x7660
// Size: 0xc2
function function_fb738343()
{
    self endon( #"death" );
    self setforcenocull();
    nd_start = getvehiclenode( self.target, "targetname" );
    self thread vehicle::get_on_and_go_path( nd_start );
    self waittill( #"fuel_truck_missile" );
    level thread function_5441f2aa();
    self function_bb5ef028( "fuel_truck_missile", &function_1393a04d );
    self waittill( #"hunter_stop" );
    self setspeedimmediate( 0 );
    self delete();
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x5d2ee6af, Offset: 0x7730
// Size: 0x152
function function_243196a7()
{
    self endon( #"death" );
    self setforcenocull();
    nd_start = getvehiclenode( self.target, "targetname" );
    self thread vehicle::get_on_and_go_path( nd_start );
    self waittill( #"hash_36d05dc6" );
    wait 0.1;
    self function_bb5ef028( "so_ferris_wheel_missiles_1", &function_3cbc42d6 );
    wait 0.15;
    self function_bb5ef028( "so_ferris_wheel_missiles_1", &function_3cbc42d6 );
    wait 0.15;
    self function_bb5ef028( "so_ferris_wheel_missiles_2", &function_3cbc42d6 );
    wait 0.15;
    self function_bb5ef028( "so_ferris_wheel_missiles_3", &function_3cbc42d6 );
    wait 0.15;
    self waittill( #"hunter_stop" );
    self setspeedimmediate( 0 );
    self delete();
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0xece27d3d, Offset: 0x7890
// Size: 0x112
function function_ce0e4988()
{
    self endon( #"death" );
    self setforcenocull();
    nd_start = getvehiclenode( self.target, "targetname" );
    self thread vehicle::get_on_and_go_path( nd_start );
    self waittill( #"hash_48964163" );
    self function_bb5ef028( "so_swamp_water_explosion_1", &function_8bc51e36 );
    self waittill( #"hash_d68ed228" );
    self function_bb5ef028( "so_swamp_water_explosion_2", &function_8bc51e36 );
    self waittill( #"hash_fc914c91" );
    self function_bb5ef028( "so_swamp_water_explosion_3", &function_8bc51e36 );
    self waittill( #"hunter_stop" );
    self setspeedimmediate( 0 );
    self delete();
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 2
// Checksum 0x1a3a417f, Offset: 0x79b0
// Size: 0x92
function function_bb5ef028( str_target_name, var_5d4391a4 )
{
    e_target = getentarray( str_target_name, "targetname" );
    self setturrettargetent( e_target[ 0 ] );
    self thread hunter_fire_missile( 0, e_target[ 0 ], undefined, 0, 0 );
    e_missile = self thread hunter_fire_missile( 1, e_target[ 1 ], undefined, 0, 0 );
    e_missile thread [[ var_5d4391a4 ]]( e_target[ 0 ], str_target_name );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x3fc6d98, Offset: 0x7a50
// Size: 0x13a
function function_e0476b5e()
{
    self endon( #"death" );
    self setforcenocull();
    nd_start = getvehiclenode( self.target, "targetname" );
    self thread vehicle::get_on_and_go_path( nd_start );
    self waittill( #"hash_5e08d59e" );
    self function_bb5ef028( "so_swamp_final_water_explosion_1", &function_8bc51e36 );
    self function_bb5ef028( "so_swamp_final_water_explosion_1_b", &function_8bc51e36 );
    self waittill( #"hash_38065b35" );
    self function_bb5ef028( "so_swamp_final_water_explosion_2", &function_8bc51e36 );
    self waittill( #"hash_1203e0cc" );
    self function_bb5ef028( "so_swamp_final_water_explosion_3", &function_8bc51e36 );
    self waittill( #"hunter_stop" );
    self setspeedimmediate( 0 );
    self delete();
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 5
// Checksum 0x555b726f, Offset: 0x7b98
// Size: 0x127
function hunter_fire_missile( launcher_index, target, offset, blinklights, waittimeafterblinklights )
{
    self endon( #"death" );
    
    if ( !isdefined( offset ) )
    {
        offset = ( 0, 0, -10 );
    }
    
    spawntag = self.missiletags[ launcher_index ];
    origin = self gettagorigin( spawntag );
    angles = self gettagangles( spawntag );
    forward = anglestoforward( angles );
    up = anglestoup( angles );
    
    if ( isdefined( spawntag ) )
    {
        weapon = getweapon( "hunter_rocket_turret_biodomes_cinematic" );
        missile = magicbullet( weapon, origin, target.origin, self, target, offset );
        return missile;
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 2
// Checksum 0xc878946c, Offset: 0x7cc8
// Size: 0x6a
function function_1393a04d( e_target, var_deb1fb4d )
{
    self waittill( #"death" );
    level thread scene::play( "p7_fxanim_cp_biodomes_swamp_tanker_bundle" );
    playrumbleonposition( "cp_biodomes_fuel_truck_rumble", e_target.origin );
    level flag::set( "swamp_tanker_exploded" );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 2
// Checksum 0x5df3de77, Offset: 0x7d40
// Size: 0x32
function function_8bc51e36( e_target, var_deb1fb4d )
{
    self waittill( #"death" );
    function_74d7b8e4( var_deb1fb4d, "explosions/fx_exp_rocket_water_lg" );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 2
// Checksum 0xfc8d61c8, Offset: 0x7d80
// Size: 0x32
function function_3cbc42d6( e_target, var_deb1fb4d )
{
    self waittill( #"death" );
    function_74d7b8e4( var_deb1fb4d, "explosions/fx_vexp_hunter_death" );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 2
// Checksum 0x72db4a10, Offset: 0x7dc0
// Size: 0x32
function function_36910f4( e_target, var_deb1fb4d )
{
    self waittill( #"death" );
    function_74d7b8e4( var_deb1fb4d, "explosions/fx_exp_impact_ferriswheel_biodomes" );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 2
// Checksum 0x9cb55574, Offset: 0x7e00
// Size: 0x89
function function_74d7b8e4( var_deb1fb4d, str_fx_name )
{
    a_ent = getentarray( var_deb1fb4d, "targetname" );
    
    for ( i = 0; i < a_ent.size ; i++ )
    {
        playfx( str_fx_name, a_ent[ i ].origin, anglestoforward( a_ent[ i ].angles ), ( 0, 0, 1 ) );
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0xf123072b, Offset: 0x7e98
// Size: 0x125
function function_2297c05c()
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( isdefined( self.enemy ) && self vehcansee( self.enemy ) )
        {
            if ( randomfloatrange( 0, 1 ) < 0.45 )
            {
                if ( distancesquared( self.enemy.origin, self.origin ) < 0.5 * ( self.settings.engagementdistmin + self.settings.engagementdistmax ) * 3 * 0.5 * ( self.settings.engagementdistmin + self.settings.engagementdistmax ) * 3 )
                {
                    self setturrettargetent( self.enemy );
                    self vehicle_ai::fire_for_time( randomfloatrange( 0.2, 0.4 ) );
                }
            }
        }
        
        wait 0.45;
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0xd91971ae, Offset: 0x7fc8
// Size: 0xfa
function outpost_crash()
{
    trigger::wait_till( "trigger_outpost" );
    a_mdl_clips = getentarray( "outpost_clips", "script_noteworthy" );
    
    foreach ( clip in a_mdl_clips )
    {
        clip delete();
    }
    
    mdl_outpost = getent( "outpost_crash", "targetname" );
    
    if ( isdefined( mdl_outpost ) )
    {
        mdl_outpost delete();
    }
    
    level thread scene::play( "p7_fxanim_cp_biodomes_outpost_boat_crash_bundle" );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1
// Checksum 0x176a9c2e, Offset: 0x80d0
// Size: 0x4a
function jump_land_city( t_land )
{
    self endon( #"disconnect" );
    t_land waittill( #"trigger" );
    self playrumbleonentity( "cp_biodomes_jump_land_rumble" );
    self clientfield::increment_to_player( "sound_evt_boat_rattle" );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1
// Checksum 0x34a6334c, Offset: 0x8128
// Size: 0xfb
function function_aa88dfc2( a_ents )
{
    if ( level.activeplayers.size < 3 && !( isdefined( level.b_debug ) && level.b_debug ) )
    {
        a_ents[ "boat2" ] hide();
    }
    
    foreach ( player in level.players )
    {
        var_a44e19db = "boat" + player.var_462738ee;
        str_scene = function_6150ee85( var_a44e19db, player.n_seat );
        
        if ( isdefined( str_scene ) )
        {
            level thread scene::play( str_scene, player );
        }
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 2
// Checksum 0x8f7764a6, Offset: 0x8230
// Size: 0xba
function function_6150ee85( var_a44e19db, n_seat )
{
    str_scene = undefined;
    
    if ( var_a44e19db == "boat1" && n_seat == 1 )
    {
        str_scene = "cin_bio_16_01_slide_1st_slammed_p1";
    }
    else if ( var_a44e19db == "boat1" && n_seat == 2 )
    {
        str_scene = "cin_bio_16_01_slide_1st_slammed_p3";
    }
    else if ( var_a44e19db == "boat2" && n_seat == 1 )
    {
        str_scene = "cin_bio_16_01_slide_1st_slammed_p2";
    }
    else if ( var_a44e19db == "boat2" && n_seat == 2 )
    {
        str_scene = "cin_bio_16_01_slide_1st_slammed_p4";
    }
    
    return str_scene;
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x46157eef, Offset: 0x82f8
// Size: 0x2b2
function igc_end()
{
    a_boat_models = [];
    
    for ( i = 0; i < 2 ; i++ )
    {
        var_841b0143 = util::spawn_model( "veh_t7_mil_boat_fan_54i_wet" );
        var_841b0143 hide();
        
        if ( !isdefined( a_boat_models ) )
        {
            a_boat_models = [];
        }
        else if ( !isarray( a_boat_models ) )
        {
            a_boat_models = array( a_boat_models );
        }
        
        a_boat_models[ a_boat_models.size ] = var_841b0143;
        wait 0.05;
    }
    
    self waittill( #"play_end_igc" );
    level thread audio::unlockfrontendmusic( "mus_biodomes_battle_intro" );
    level thread mission_over();
    level.ai_hendricks delete();
    level.ai_hendricks = undefined;
    a_scene_ents = [];
    a_scene_ents[ "boat1" ] = a_boat_models[ 0 ];
    a_scene_ents[ "boat1" ] show();
    
    if ( level.var_c141dfcb.size > 1 )
    {
        a_scene_ents[ "boat2" ] = a_boat_models[ 1 ];
        a_scene_ents[ "boat2" ] show();
    }
    
    foreach ( player in level.activeplayers )
    {
        if ( isdefined( player.usingvehicle ) && player.usingvehicle && isdefined( player.viewlockedentity ) )
        {
            player.viewlockedentity usevehicle( player, 0 );
        }
    }
    
    thread function_7e40793c();
    level scene::stop( "cin_bio_15_03_waterpark_vign_lean_center" );
    
    if ( isdefined( level.bzm_biodialogue6callback ) )
    {
        level thread [[ level.bzm_biodialogue6callback ]]();
    }
    
    level thread namespace_76133733::function_a6bf2d53();
    level scene::add_scene_func( "cin_bio_16_01_slide_1st_slammed", &function_aa88dfc2, "play" );
    level thread scene::play( "cin_bio_16_01_slide_1st_slammed", a_scene_ents );
    level thread scene::play( "p7_fxanim_cp_biodomes_sky_bridge_bundle" );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x5cb4ff3f, Offset: 0x85b8
// Size: 0xdb
function function_7e40793c()
{
    foreach ( vh_boat in level.var_c141dfcb )
    {
        if ( isdefined( vh_boat ) )
        {
            vh_boat ghost();
            vh_boat notsolid();
        }
    }
    
    wait 1;
    
    foreach ( vh_boat in level.var_c141dfcb )
    {
        if ( isdefined( vh_boat ) )
        {
            vh_boat delete();
        }
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1
// Checksum 0xefc53d38, Offset: 0x86a0
// Size: 0x71
function function_863f4586( a_ents )
{
    if ( isdefined( a_ents[ "sp_hunter_sky_bridge" ] ) )
    {
        wait 0.5;
        
        for ( i = 0; i < 3 ; i++ )
        {
            a_ents[ "sp_hunter_sky_bridge" ] function_bb5ef028( "so_sky_bridge_missiles_1", &function_36910f4 );
            wait 0.5;
        }
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x4528a8e8, Offset: 0x8720
// Size: 0x7a
function mission_over()
{
    biodomes_accolades::function_ed573577();
    level waittill( #"notetrack_fadeout" );
    setdvar( "phys_buoyancy", 0 );
    setdvar( "cg_viewVehicleInfluenceGunner_mode", 0 );
    util::screen_fade_out( 1 );
    wait 0.5;
    skipto::objective_completed( "objective_swamps" );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1
// Checksum 0x4546e743, Offset: 0x87a8
// Size: 0x4a
function function_36e4a4e3( str_group )
{
    a_scene_bundles = struct::get_array( str_group, "targetname" );
    level thread array::spread_all( a_scene_bundles, &function_ea7f9b48 );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x70483281, Offset: 0x8800
// Size: 0xe9
function function_ea7f9b48()
{
    scene::init( self.scriptbundlename );
    
    if ( !isdefined( self.radius ) )
    {
        self.radius = 448;
    }
    
    if ( !isdefined( self.height ) )
    {
        self.height = 400;
    }
    
    t_start = create_trigger_radius( self.origin, self.radius, self.height );
    
    while ( true )
    {
        t_start waittill( #"trigger", e_boat );
        
        if ( e_boat.targetname == "airboat_2_vh" && level.var_de54cf10 )
        {
            continue;
        }
        
        scene::play( self.scriptbundlename );
        t_start delete();
        break;
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 2
// Checksum 0x1a592a95, Offset: 0x88f8
// Size: 0x52
function function_35a6217a( str_name, var_65f020d3 )
{
    if ( !isdefined( var_65f020d3 ) )
    {
        var_65f020d3 = undefined;
    }
    
    var_461bd72d = struct::get( str_name, "targetname" );
    var_461bd72d thread function_81e1861d( var_65f020d3 );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1
// Checksum 0x603b6719, Offset: 0x8958
// Size: 0x121
function function_81e1861d( var_65f020d3 )
{
    scene::init( self.scriptbundlename );
    t_damage = getent( "t_" + self.targetname + "_damage", "targetname" );
    
    while ( true )
    {
        t_damage waittill( #"damage", damage, attacker, direction, point, type, tagname, modelname, partname, weapon );
        
        if ( isplayer( attacker ) )
        {
            if ( isdefined( var_65f020d3 ) )
            {
                level thread [[ var_65f020d3 ]]();
            }
            
            scene::play( self.scriptbundlename );
            biodomes_accolades::function_b5cf7b68();
            break;
        }
        
        wait 0.1;
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 5
// Checksum 0xf635e4e7, Offset: 0x8a88
// Size: 0x13c
function create_trigger_radius( v_position, n_radius, n_height, n_spawn_flags, str_trigger_type )
{
    if ( !isdefined( n_spawn_flags ) )
    {
        n_spawn_flags = 0;
    }
    
    if ( !isdefined( str_trigger_type ) )
    {
        str_trigger_type = "trigger_radius";
    }
    
    assert( isdefined( v_position ), "<dev string:x28>" );
    assert( isdefined( n_radius ), "<dev string:x5e>" );
    assert( isdefined( n_height ), "<dev string:x92>" );
    t_use = spawn( str_trigger_type, v_position, getvehicletriggerflags(), n_radius, n_height );
    t_use triggerignoreteam();
    t_use setvisibletoall();
    t_use setteamfortrigger( "none" );
    t_use usetriggerrequirelookat();
    
    if ( str_trigger_type == "trigger_radius_use" )
    {
        t_use setcursorhint( "HINT_NOICON" );
    }
    
    return t_use;
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1
// Checksum 0x60b5e73f, Offset: 0x8bd0
// Size: 0x3a
function function_1f3c3c34( str_group )
{
    scene::init( self.scriptbundlename );
    level waittill( str_group );
    scene::play( self.scriptbundlename );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1
// Checksum 0xaabffe02, Offset: 0x8c18
// Size: 0xed
function function_39af75ef( str_endon )
{
    self endon( #"disconnect" );
    self endon( #"death" );
    
    while ( true )
    {
        if ( self isplayerunderwater() && !( isdefined( self.is_underwater ) && self.is_underwater ) )
        {
            self.is_underwater = 1;
            self thread clientfield::set_to_player( "set_underwater_fx", 1 );
            self thread hazard::function_e9b126ef();
        }
        else if ( isdefined( self.is_underwater ) && !self isplayerunderwater() && self.is_underwater )
        {
            self.is_underwater = undefined;
            self thread clientfield::set_to_player( "set_underwater_fx", 0 );
            self thread hazard::function_60455f28( "o2" );
        }
        
        wait 0.05;
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x3e5aab18, Offset: 0x8d10
// Size: 0x3a
function function_400cc8f4()
{
    trigger::wait_till( "trig_hide_dock_fxanims", "targetname" );
    hidemiscmodels( "fxanim_swamp01" );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x96388784, Offset: 0x8d58
// Size: 0x6a
function function_312d4b85()
{
    level.var_c141dfcb[ 0 ] vehicle::toggle_ambient_anim_group( 1, 1 );
    level.var_c141dfcb[ 1 ] vehicle::toggle_ambient_anim_group( 1, 1 );
    level.var_c141dfcb[ 0 ] vehicle::toggle_ambient_anim_group( 2, 0 );
    level.var_c141dfcb[ 1 ] vehicle::toggle_ambient_anim_group( 2, 0 );
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0
// Checksum 0x1d241904, Offset: 0x8dd0
// Size: 0x6a
function function_c5f21db5()
{
    level.var_c141dfcb[ 0 ] vehicle::toggle_ambient_anim_group( 1, 0 );
    level.var_c141dfcb[ 1 ] vehicle::toggle_ambient_anim_group( 1, 0 );
    level.var_c141dfcb[ 0 ] vehicle::toggle_ambient_anim_group( 2, 1 );
    level.var_c141dfcb[ 1 ] vehicle::toggle_ambient_anim_group( 2, 1 );
}

