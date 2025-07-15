#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_infection2_sound;
#using scripts/cp/cp_mi_cairo_infection_accolades;
#using scripts/cp/cp_mi_cairo_infection_murders;
#using scripts/cp/cp_mi_cairo_infection_util;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/gametypes/_spawnlogic;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace forest_surreal;

// Namespace forest_surreal
// Params 4
// Checksum 0xc8ed4f2c, Offset: 0x15b0
// Size: 0x7a
function cleanup( str_objective, b_starting, b_direct, player )
{
    infection_accolades::function_ecd2ed4();
    var_ce40c475 = getentarray( "world_falls_away_chasm", "targetname" );
    array::run_all( var_ce40c475, &show );
}

// Namespace forest_surreal
// Params 2
// Checksum 0x78b36892, Offset: 0x1638
// Size: 0x252
function main( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        objectives::set( "cp_level_infection_follow_sarah" );
        infection_util::function_cbc167();
        level.ai_sarah = util::get_hero( "sarah" );
        level.ai_sarah clientfield::set( "sarah_objective_light", 1 );
    }
    
    setup_spawners();
    
    if ( true )
    {
        infection_util::setup_reverse_time_arrivals( "world_falls_away_reverse_anim" );
    }
    
    setup_world_falls_away();
    setup_player_falling_deaths();
    level thread intro_guys();
    level thread ai_middle_path_spawners();
    level thread runners_before_pit();
    level thread forest_surreal_cleanup_thread();
    level thread hanging_on_ledge_dudes();
    level thread function_e8d77ec8();
    
    if ( b_starting )
    {
        load::function_a2995f22();
        level thread infection_util::function_3fe1f72( "t_sarah_bastogne_objective_", 8, &sarah_waits_at_ravine );
        infection_util::turn_on_snow_fx_for_all_players();
    }
    
    level thread transition_to_night();
    level thread turn_off_snow();
    level thread fancy_falling_pieces_at_start();
    
    if ( true )
    {
        level thread wfa_falling_platform_guys();
    }
    
    if ( false )
    {
        e_player = getplayers()[ 0 ];
        e_player.ignoreme = 1;
    }
    
    e_trigger = getent( "forest_surreal_skipto_complete", "targetname" );
    e_trigger waittill( #"trigger" );
    level notify( #"forest_surreal_complete" );
    level thread skipto::objective_completed( str_objective );
}

// Namespace forest_surreal
// Params 0
// Checksum 0xac1362a9, Offset: 0x1898
// Size: 0xd2
function function_633271eb()
{
    level thread infection_util::function_f6d49772( "t_salm_from_the_trials_unde_1", "salm_from_the_trials_unde_1", "end_salm_forest_dialog" );
    level thread infection_util::function_f6d49772( "t_salm_for_the_safety_of_my_1", "salm_for_the_safety_of_my_1", "end_salm_forest_dialog" );
    level thread infection_util::function_f6d49772( "t_salm_my_presentation_to_t_1", "salm_my_presentation_to_t_1", "end_salm_forest_dialog" );
    level thread infection_util::function_f6d49772( "t_salm_subject_e_38_crimi_1", "salm_subject_e_38_crimi_1", "end_salm_forest_dialog" );
    level waittill( #"hash_1b6ae018" );
    level thread infection_util::function_f6d49772( "t_salm_at_the_time_of_his_a_1", "salm_at_the_time_of_his_a_1", "end_salm_forest_dialog" );
}

// Namespace forest_surreal
// Params 0
// Checksum 0xe4a70d08, Offset: 0x1978
// Size: 0x1a
function turn_off_snow()
{
    wait 0.2;
    infection_util::turn_off_snow_fx_for_all_players();
}

// Namespace forest_surreal
// Params 1
// Checksum 0x306f4790, Offset: 0x19a0
// Size: 0x4a
function delete_not_seen( dist )
{
    self endon( #"death" );
    
    while ( self infection_util::player_can_see_me( dist ) )
    {
        wait 0.1;
    }
    
    if ( isdefined( self ) )
    {
        self infection_util::function_5e78ab8c();
    }
}

// Namespace forest_surreal
// Params 2
// Checksum 0x82b4695, Offset: 0x19f8
// Size: 0x3a
function dev_black_station_intro( str_objective, b_starting )
{
    wait_for_player_to_enter_black_station();
    level thread blackstation_murders::murders_main( "black_station", 0 );
}

// Namespace forest_surreal
// Params 4
// Checksum 0x2dbcda6, Offset: 0x1a40
// Size: 0x22
function dev_black_station_cleanup( str_objective, b_starting, b_direct, player )
{
    
}

// Namespace forest_surreal
// Params 2
// Checksum 0xf5e76ff, Offset: 0x1a70
// Size: 0x232
function forest_wolves( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
    }
    
    setup_scenes();
    level thread forest_wolves_cleanup_thread();
    level thread function_e9f75cf5();
    wait 0.1;
    
    if ( false )
    {
        e_player = getplayers()[ 0 ];
        e_player.ignoreme = 1;
    }
    
    if ( !isdefined( level.world_falls_away_setup ) )
    {
        level thread setup_world_falls_away();
    }
    
    if ( true )
    {
        level thread infection_util::setup_reverse_time_arrivals( "world_falls_away_wolf_reverse_anim" );
    }
    
    infection_accolades::function_341d8f7a();
    infection_accolades::function_8c0b0cd0();
    infection_accolades::function_aea367c1();
    
    if ( b_starting )
    {
        var_7d116593 = struct::get( "s_forest_wolves_lighting_hint", "targetname" );
        infection_util::function_7aca917c( var_7d116593.origin );
        objectives::set( "cp_level_infection_follow_sarah" );
        level.ai_sarah = util::get_hero( "sarah" );
        setup_spawners();
        setup_player_falling_deaths();
        level thread namespace_bed101ee::function_daeb8be9();
        load::function_a2995f22();
        level.ai_sarah clientfield::set( "sarah_objective_light", 1 );
        level thread infection_util::function_3fe1f72( "t_sarah_bastogne_objective_", 13, &sarah_waits_at_ravine );
    }
    
    level thread function_4e7bce99();
    wolves_attack();
    chasm_opens();
    level thread skipto::objective_completed( str_objective );
}

// Namespace forest_surreal
// Params 4
// Checksum 0xa33f90a0, Offset: 0x1cb0
// Size: 0x22
function forest_wolves_cleanup( str_objective, b_starting, b_direct, player )
{
    
}

// Namespace forest_surreal
// Params 0
// Checksum 0x8acb3550, Offset: 0x1ce0
// Size: 0x32
function function_e9f75cf5()
{
    trigger::wait_till( "t_plrf_sarah_who_was_tha_0" );
    level dialog::player_say( "plyr_sarah_who_was_tha_0" );
}

// Namespace forest_surreal
// Params 2
// Checksum 0x47500524, Offset: 0x1d20
// Size: 0x72
function forest_sky_bridge( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        load::function_a2995f22();
        function_7519eaff();
    }
    
    function_42297537();
    level notify( #"hash_5d80c772" );
    level thread skipto::objective_completed( str_objective );
}

// Namespace forest_surreal
// Params 4
// Checksum 0xfbdd2371, Offset: 0x1da0
// Size: 0x22
function function_dd270bfd( str_objective, b_starting, b_direct, player )
{
    
}

// Namespace forest_surreal
// Params 0
// Checksum 0x7e73818f, Offset: 0x1dd0
// Size: 0x32
function function_42297537()
{
    trigger::wait_till( "t_cross_sky_bridge" );
    objectives::complete( "cp_level_infection_cross_chasm" );
}

// Namespace forest_surreal
// Params 0
// Checksum 0xa815c184, Offset: 0x1e10
// Size: 0x16a
function function_7519eaff()
{
    level util::clientnotify( "chasm_wind" );
    blackstation_murders::function_d7cb3668();
    playsoundatposition( "evt_pullapart_world", ( 0, 0, 0 ) );
    objectives::set( "cp_level_infection_follow_sarah" );
    setup_player_falling_deaths();
    level thread namespace_bed101ee::function_daeb8be9();
    a_chasm = getentarray( "world_falls_away_chasm", "targetname" );
    
    for ( i = 0; i < a_chasm.size ; i++ )
    {
        str_name = a_chasm[ i ].target;
        
        if ( isdefined( str_name ) )
        {
            s_struct = struct::get( str_name, "targetname" );
            a_chasm[ i ].origin = s_struct.origin;
        }
    }
    
    level thread chasm_opens_effects( 1 );
    exploder::exploder( "light_wfa_end" );
    a_chasm[ 0 ] playloopsound( "evt_pullapart_world_looper", 3 );
    level thread players_enter_cave();
}

// Namespace forest_surreal
// Params 2
// Checksum 0x12d7cc78, Offset: 0x1f88
// Size: 0x92
function forest_tunnel( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        function_7519eaff();
        objectives::complete( "cp_level_infection_cross_chasm" );
        load::function_a2995f22();
    }
    else
    {
        level thread blackstation_murders::function_d7cb3668();
    }
    
    wait_for_player_to_enter_black_station();
    level thread skipto::objective_completed( str_objective );
}

// Namespace forest_surreal
// Params 4
// Checksum 0x570b524e, Offset: 0x2028
// Size: 0x82
function function_de606506( str_objective, b_starting, b_direct, player )
{
    exploder::exploder_stop( "lgt_forest_tunnel_02" );
    exploder::exploder_stop( "lgt_forest_tunnel_03" );
    exploder::exploder_stop( "lgt_forest_tunnel_04" );
    exploder::exploder_stop( "lgt_forest_tunnel_05" );
}

// Namespace forest_surreal
// Params 0
// Checksum 0x3492dd5d, Offset: 0x20b8
// Size: 0x109
function transition_to_night()
{
    level thread vo_transition_night();
    level thread lui::screen_flash( 0.1, 1, 1, 0.3, "white" );
    s_sound_origin = struct::get( "world_falls_away_start_struct", "targetname" );
    playsoundatposition( "evt_night_transition", s_sound_origin.origin );
    level thread namespace_bed101ee::function_daeb8be9();
    s_struct = struct::get( "s_night_transition", "targetname" );
    
    for ( count = 0; count < 20 ; count++ )
    {
        playrumbleonposition( "cp_infection_world_falls_break_rumble", s_struct.origin );
        util::wait_network_frame();
    }
}

// Namespace forest_surreal
// Params 0
// Checksum 0xdc285050, Offset: 0x21d0
// Size: 0xc2
function setup_scenes()
{
    scene::add_scene_func( "cin_inf_07_03_worldfallsaway_vign_pain", &vo_worldfallsaway_vign, "play" );
    scene::add_scene_func( "cin_inf_07_03_worldfallsaway_vign_pain", &infection_util::callback_scene_objective_light_enable, "init" );
    scene::add_scene_func( "cin_inf_07_03_worldfallsaway_vign_pain", &infection_util::callback_scene_objective_light_disable_no_delete, "play" );
    scene::add_scene_func( "cin_inf_07_02_worldfallsaway_vign_direwolves_eating", &scene_callback_dude_getting_eaten, "init" );
}

// Namespace forest_surreal
// Params 0
// Checksum 0xe639e2cf, Offset: 0x22a0
// Size: 0xa2
function setup_spawners()
{
    infection_util::enable_exploding_deaths( 1 );
    spawner::add_spawn_function_group( "sm_bastogne_hill_guys_1", "targetname", &world_falls_away_ai_spawn_fn );
    spawner::add_spawn_function_group( "world_falls_away_intro_guys", "targetname", &world_falls_away_ai_spawn_fn );
    spawner::add_spawn_function_group( "wolf", "script_noteworthy", &spawn_func_wolf );
}

// Namespace forest_surreal
// Params 0
// Checksum 0xfb008339, Offset: 0x2350
// Size: 0x8b
function setup_player_falling_deaths()
{
    a_triggers = getentarray( "falling_death", "targetname" );
    
    foreach ( trigger in a_triggers )
    {
        trigger thread falling_death_think();
    }
}

// Namespace forest_surreal
// Params 0
// Checksum 0x724da06f, Offset: 0x23e8
// Size: 0x6d
function falling_death_think()
{
    while ( true )
    {
        self waittill( #"trigger", who );
        
        if ( isplayer( who ) && !( isdefined( who.is_falling_to_death ) && who.is_falling_to_death ) )
        {
            who thread player_falls_to_death();
        }
        
        util::wait_network_frame();
    }
}

// Namespace forest_surreal
// Params 0
// Checksum 0x65cd597, Offset: 0x2460
// Size: 0x72
function player_falls_to_death()
{
    self endon( #"death" );
    self.is_falling_to_death = 1;
    wait 1;
    self move_player_to_respawn_point();
    self.is_falling_to_death = 0;
    self dodamage( self.health / 10, self.origin );
    
    if ( self.health < 1 )
    {
        self.health = 1;
    }
}

// Namespace forest_surreal
// Params 0
// Checksum 0xab54c73b, Offset: 0x24e0
// Size: 0x282
function move_player_to_respawn_point()
{
    self endon( #"death" );
    str_skipto = level.skipto_point;
    a_respawn_points = spawnlogic::get_spawnpoint_array( "cp_coop_respawn" );
    a_respawn_points_filtered = skipto::filter_player_spawnpoints( self, a_respawn_points, str_skipto );
    assert( a_respawn_points_filtered.size, "<dev string:x28>" );
    var_4bd163fe = arraygetclosest( self.origin, a_respawn_points_filtered );
    
    if ( positionwouldtelefrag( var_4bd163fe.origin ) )
    {
        foreach ( s_point in a_respawn_points_filtered )
        {
            if ( s_point !== var_4bd163fe )
            {
                var_4bd163fe = s_point;
                break;
            }
        }
    }
    
    self.is_falling_to_death = 1;
    self enableinvulnerability();
    self setinvisibletoall();
    self util::freeze_player_controls( 1 );
    self.ignoreme = 1;
    self clientfield::increment_to_player( "postfx_igc" );
    util::wait_network_frame();
    self setorigin( var_4bd163fe.origin );
    self setplayerangles( var_4bd163fe.angles );
    
    if ( sessionmodeiscampaignzombiesgame() )
    {
        if ( isdefined( level.bzm_waitforstreamerortimeout ) )
        {
            [[ level.bzm_waitforstreamerortimeout ]]( self, 4 );
        }
    }
    else
    {
        self util::streamer_wait();
    }
    
    self setvisibletoall();
    self clientfield::set( "player_spawn_fx", 1 );
    self util::delay( 0.5, "death", &clientfield::set, "player_spawn_fx", 0 );
    wait 1.5;
    self util::freeze_player_controls( 0 );
    wait 2;
    self disableinvulnerability();
    self.ignoreme = 0;
    self.is_falling_to_death = 0;
}

// Namespace forest_surreal
// Params 0
// Checksum 0x31d6964b, Offset: 0x2770
// Size: 0x52
function setup_world_falls_away()
{
    level.world_falls_away_setup = 1;
    a_pieces = getentarray( "bastogne_world_falls_away", "script_noteworthy" );
    level thread array::thread_all( a_pieces, &fall_away_piece_think );
}

// Namespace forest_surreal
// Params 0
// Checksum 0x8601e303, Offset: 0x27d0
// Size: 0x202
function fall_away_piece_think()
{
    if ( self.classname == "script_model" )
    {
        str_debug = self.model;
    }
    else
    {
        str_debug = self.origin;
    }
    
    if ( !isdefined( self.target ) )
    {
        return;
    }
    
    s_struct = struct::get( self.target, "targetname" );
    
    if ( !isdefined( s_struct ) )
    {
        return;
    }
    
    s_struct.moving_platform = self;
    self.var_efe20130 = 0;
    v_pos = s_struct.origin;
    radius = 1260;
    
    if ( isdefined( s_struct.radius ) )
    {
        radius = s_struct.radius;
    }
    
    level thread fall_away_piece_trigger( s_struct, radius );
    level waittill( s_struct.script_string );
    
    if ( isdefined( self.script_string ) && self.script_string == "moving_platform" )
    {
        self.moving_platform_piece = 1;
        self setmovingplatformenabled( 1 );
    }
    else
    {
        self.moving_platform_piece = 0;
    }
    
    v_rumble_origin = s_struct.origin;
    self piece_rising_effects();
    time = randomfloatrange( 0.5, 1 );
    self thread play_fall_away_piece_rumble( "cp_infection_world_falls_break_rumble", time, 1 );
    self playsound( "evt_small_flyaway_rumble" );
    
    if ( self.moving_platform_piece == 0 )
    {
        wait time;
    }
    
    self fallaway_piece_rising_rumble( v_rumble_origin, self.moving_platform_piece, undefined );
    self fallaway_piece_moves_up();
    wait 1;
    self fallaway_piece_falls( v_rumble_origin );
    self delete();
}

// Namespace forest_surreal
// Params 0
// Checksum 0x9348421, Offset: 0x29e0
// Size: 0xb4
function fallaway_piece_moves_up()
{
    self.var_efe20130 = 1;
    self.moveup_dist = 80;
    self.moveup_time = 1.7;
    self.moveup_accel = 0.8;
    
    if ( randomint( 100 ) > 60 )
    {
        self.moveup_dist = self.moveup_dist + randomintrange( 20, 50 );
    }
    
    self notify( #"starting_move_up" );
    wait 0.05;
    self movez( self.moveup_dist, self.moveup_time, self.moveup_accel, self.moveup_accel );
    self waittill( #"movedone" );
}

// Namespace forest_surreal
// Params 1
// Checksum 0x38db7e99, Offset: 0x2aa0
// Size: 0x14c
function fallaway_piece_falls( v_pos )
{
    self notify( #"fall_starting" );
    rumble_time = randomfloatrange( 1.2, 2.5 );
    self thread play_fall_away_piece_rumble( "cp_infection_world_falls_away_rumble", rumble_time, 1 );
    quake_size = 0.28;
    quake_time = rumble_time;
    quake_radius = 1850;
    earthquake( quake_size, quake_time, v_pos, quake_radius );
    playsoundatposition( "evt_small_flyaway_go", v_pos );
    falling_piece_exploder_effect( self.model );
    
    if ( self.moving_platform_piece )
    {
        self movez( -3000, 5.5, 2 );
    }
    else
    {
        self movez( -3000, 5.5, 2 );
    }
    
    self waittill( #"movedone" );
}

// Namespace forest_surreal
// Params 3
// Checksum 0xcb9202e2, Offset: 0x2bf8
// Size: 0x10a
function fallaway_piece_rising_rumble( v_rumble_origin, moving_platform_piece, rumble )
{
    quake_size = 0.28;
    quake_time = randomfloatrange( 0.5, 1.5 );
    quake_radius = 1850;
    
    if ( moving_platform_piece )
    {
        quake_time = 1;
    }
    
    if ( isdefined( rumble ) )
    {
        if ( self == level )
        {
            var_b2dab111 = util::spawn_model( "tag_origin", v_rumble_origin );
            var_b2dab111.script_objective = "forest_wolves";
            util::wait_network_frame();
            var_b2dab111 thread fallaway_piece_rumble();
        }
        else
        {
            self thread fallaway_piece_rumble();
        }
    }
    
    earthquake( quake_size, quake_time, v_rumble_origin, quake_radius );
    wait quake_time;
    playsoundatposition( "evt_small_flyaway_start", v_rumble_origin );
}

// Namespace forest_surreal
// Params 0
// Checksum 0xefb9853b, Offset: 0x2d10
// Size: 0x91
function fallaway_piece_rumble()
{
    self endon( #"death" );
    
    for ( count = 0; count < 10 ; count++ )
    {
        self clientfield::increment( "cp_infection_world_falls_break_rumble", 1 );
        util::wait_network_frame();
    }
    
    wait 1;
    
    for ( count = 0; count < 20 ; count++ )
    {
        self clientfield::increment( "cp_infection_world_falls_break_rumble", 1 );
        util::wait_network_frame();
    }
}

// Namespace forest_surreal
// Params 0
// Checksum 0x95286ca2, Offset: 0x2db0
// Size: 0x79
function falling_piece_skirt_effect()
{
    str_name = self.model + "_skirt";
    a_skirts = getentarray( str_name, "targetname" );
    
    if ( isdefined( a_skirts ) )
    {
        for ( i = 0; i < a_skirts.size ; i++ )
        {
            a_skirts[ i ] thread skirt_piece_update( self );
        }
    }
}

// Namespace forest_surreal
// Params 1
// Checksum 0xe83348b1, Offset: 0x2e38
// Size: 0x1a
function skirt_piece_update( e_parent_model )
{
    self delete();
}

// Namespace forest_surreal
// Params 1
// Checksum 0x923aa9c6, Offset: 0x2e60
// Size: 0x18a
function falling_piece_exploder_effect( str_model_name )
{
    size = str_model_name.size;
    str_exploder_id = str_model_name[ size - 3 ] + str_model_name[ size - 2 ] + str_model_name[ size - 1 ];
    str_name = "light_wfa_" + str_exploder_id;
    a_exploder_names = [];
    a_exploder_names[ a_exploder_names.size ] = "light_wfa_003";
    a_exploder_names[ a_exploder_names.size ] = "light_wfa_017";
    a_exploder_names[ a_exploder_names.size ] = "light_wfa_028";
    a_exploder_names[ a_exploder_names.size ] = "light_wfa_034";
    a_exploder_names[ a_exploder_names.size ] = "light_wfa_049";
    a_exploder_names[ a_exploder_names.size ] = "light_wfa_060";
    a_exploder_names[ a_exploder_names.size ] = "light_wfa_069";
    a_exploder_names[ a_exploder_names.size ] = "light_wfa_080";
    a_exploder_names[ a_exploder_names.size ] = "light_wfa_088";
    a_exploder_names[ a_exploder_names.size ] = "light_wfa_092";
    a_exploder_names[ a_exploder_names.size ] = "light_wfa_100";
    a_exploder_names[ a_exploder_names.size ] = "light_wfa_106";
    a_exploder_names[ a_exploder_names.size ] = "light_wfa_125";
    a_exploder_names[ a_exploder_names.size ] = "light_wfa_133";
    a_exploder_names[ a_exploder_names.size ] = "light_wfa_135";
    a_exploder_names[ a_exploder_names.size ] = "light_wfa_136";
    a_exploder_names[ a_exploder_names.size ] = "light_wfa_138";
    a_exploder_names[ a_exploder_names.size ] = "light_wfa_143";
    found = 0;
    
    for ( i = 0; i < a_exploder_names.size ; i++ )
    {
        if ( str_name == a_exploder_names[ i ] )
        {
            found = 1;
            break;
        }
    }
    
    if ( found )
    {
        exploder::exploder( str_name );
    }
}

// Namespace forest_surreal
// Params 0
// Checksum 0xf620e29c, Offset: 0x2ff8
// Size: 0x7a
function piece_rising_effects()
{
    self thread falling_piece_skirt_effect();
    self clientfield::increment( "wfa_steam_sound", 1 );
    str_identifier = getsubstr( self.model, 20, self.model.size );
    str_exploder = "forest_surreal_groundfall_steam_" + str_identifier;
    exploder::exploder( str_exploder );
}

// Namespace forest_surreal
// Params 3
// Checksum 0x65c9565d, Offset: 0x3080
// Size: 0x4b
function play_fall_away_piece_rumble( str_name, n_loops, n_wait )
{
    for ( i = 0; i < n_loops ; i++ )
    {
        self clientfield::increment( str_name, 1 );
        wait n_wait;
    }
}

// Namespace forest_surreal
// Params 2
// Checksum 0x8c21d4b6, Offset: 0x30d8
// Size: 0xf5
function fall_away_piece_trigger( s_struct, radius )
{
    level endon( #"hash_62ab67ff" );
    wait 0.1;
    
    if ( isdefined( s_struct.active ) )
    {
        return;
    }
    
    s_struct.active = 1;
    
    while ( true )
    {
        if ( isdefined( s_struct.triggered ) )
        {
            return;
        }
        
        a_players = getplayers();
        
        for ( i = 0; i < a_players.size ; i++ )
        {
            e_player = a_players[ i ];
            dist = distance2d( s_struct.origin, e_player.origin );
            
            if ( dist < radius )
            {
                level notify( s_struct.script_string );
                s_struct.triggered = 1;
                return;
            }
        }
        
        wait 0.5;
    }
}

// Namespace forest_surreal
// Params 0
// Checksum 0x1b9a632e, Offset: 0x31d8
// Size: 0x162
function function_b090c84d()
{
    trigger::wait_till( "t_lgt_forest_tunnel_02", "targetname" );
    exploder::exploder( "lgt_forest_tunnel_02" );
    playsoundatposition( "evt_tunnel_lights_on_01", ( 2813, -589, -605 ) );
    trigger::wait_till( "t_lgt_forest_tunnel_03", "targetname" );
    exploder::exploder( "lgt_forest_tunnel_03" );
    playsoundatposition( "evt_tunnel_lights_on_02", ( 3030, -493, -636 ) );
    trigger::wait_till( "t_lgt_forest_tunnel_04", "targetname" );
    exploder::exploder( "lgt_forest_tunnel_04" );
    playsoundatposition( "evt_tunnel_lights_on_03", ( 3651, -641, -620 ) );
    trigger::wait_till( "t_lgt_forest_tunnel_05", "targetname" );
    exploder::exploder( "lgt_forest_tunnel_05" );
    playsoundatposition( "evt_tunnel_lights_on_04", ( 3489, -1158, -657 ) );
}

// Namespace forest_surreal
// Params 0
// Checksum 0xe60c9938, Offset: 0x3348
// Size: 0xba
function players_enter_cave()
{
    level thread scene::play( "p7_fxanim_gp_wire_thick_01_bundle" );
    exploder::exploder( "lgt_forest_tunnel_01" );
    trigger::wait_till( "cave_entrance", "targetname" );
    playsoundatposition( "evt_tunnel_lights_on_01", ( 2438, 63, -644 ) );
    objectives::complete( "cp_waypoint_breadcrumb" );
    level thread function_b090c84d();
    level waittill( #"hash_5d80c772" );
    scene::stop( "p7_fxanim_gp_wire_thick_01_bundle" );
}

// Namespace forest_surreal
// Params 0
// Checksum 0x7b94887f, Offset: 0x3410
// Size: 0x92
function vo_transition_night()
{
    level dialog::player_say( "plyr_why_are_we_here_sar_0", 1 );
    infection_util::function_637cd603();
    level dialog::remote( "hall_don_t_you_know_0", 1, "NO_DNI" );
    infection_util::function_637cd603();
    level dialog::remote( "hall_so_much_suffering_s_0", 1, "NO_DNI" );
}

// Namespace forest_surreal
// Params 0
// Checksum 0x67aa027, Offset: 0x34b0
// Size: 0x62
function vo_transition_wolves()
{
    level waittill( #"hash_973240bd" );
    level dialog::player_say( "plyr_what_the_hell_2", 0.5 );
    infection_util::function_637cd603();
    level dialog::remote( "hall_the_dire_wolves_a_0", 0, "NO_DNI" );
}

// Namespace forest_surreal
// Params 0
// Checksum 0xb38d09c9, Offset: 0x3520
// Size: 0x6a
function function_4e7bce99()
{
    level endon( #"hash_fcccf4c9" );
    trigger::wait_till( "t_ending_dogs" );
    level dialog::say( "corv_listen_only_to_the_s_0" );
    level dialog::say( "corv_let_your_mind_relax_0" );
    level dialog::say( "corv_imagine_yourself_in_0" );
}

// Namespace forest_surreal
// Params 1
// Checksum 0x5f6274e8, Offset: 0x3598
// Size: 0x6f
function vo_worldfallsaway_vign( a_ents )
{
    e_sarah = a_ents[ "sarah" ];
    e_sarah setteam( "allies" );
    e_player = infection_util::get_closest_player_to_position( a_ents[ "sarah" ].origin );
    e_sarah waittill( #"move_mountain" );
    level notify( #"move_mountain" );
}

// Namespace forest_surreal
// Params 0
// Checksum 0x3afad367, Offset: 0x3610
// Size: 0xa9
function runners_before_pit()
{
    e_trigger = getent( "t_runner_before_pit", "targetname" );
    e_trigger waittill( #"trigger" );
    a_guys = getentarray( "sp_runner_before_pit", "targetname" );
    
    for ( i = 0; i < a_guys.size ; i++ )
    {
        spawner::simple_spawn_single( a_guys[ i ], &ent_run_to_goal, 0 );
        util::wait_network_frame();
    }
}

// Namespace forest_surreal
// Params 1
// Checksum 0x1abbb485, Offset: 0x36c8
// Size: 0x42
function ent_run_to_goal( hold_position )
{
    self endon( #"death" );
    self.goalradius = 94;
    self waittill( #"goal" );
    
    if ( !( isdefined( hold_position ) && hold_position ) )
    {
        self.goalradius = 1024;
    }
}

// Namespace forest_surreal
// Params 0
// Checksum 0xc0552460, Offset: 0x3718
// Size: 0x52
function world_falls_away_ai_spawn_fn()
{
    if ( isdefined( self.script_noteworthy ) && self.script_string == "fall_to_death" )
    {
        self.ignoreall = 1;
        self.goalradius = 64;
        debug_line( self );
        return;
    }
    
    self thread infection_util::set_goal_on_spawn();
}

// Namespace forest_surreal
// Params 0
// Checksum 0xb8a1cc24, Offset: 0x3778
// Size: 0xea
function wolves_attack()
{
    level.wolf_sprint_min_dist = 400;
    level.wolf_sprint_max_dist = 1000;
    level thread dogs_ignore_playeroverride();
    e_trigger = getent( "wolves_attack_in_trench", "targetname" );
    e_trigger waittill( #"trigger" );
    level notify( #"wolves_start_attacking" );
    level thread vo_transition_wolves();
    level thread dog_eyecandy();
    level thread intro_wolf_animations();
    level thread wolf_intro_music();
    level thread dogs_left_side();
    level thread dogs_right_side();
    level thread ending_dogs_left();
    level thread ending_dogs_right();
}

// Namespace forest_surreal
// Params 0
// Checksum 0xfe7c8e6a, Offset: 0x3870
// Size: 0x4a
function intro_wolf_animations()
{
    level thread scene::play( "cin_inf_07_02_worldfallsaway_vign_direwolf_entrance" );
    level thread scene::play( "cin_inf_07_02_worldfallsaway_vign_direwolf_entrance_bunker" );
    level thread scene::init( "dude_getting_eaten_in_trench" );
}

// Namespace forest_surreal
// Params 1
// Checksum 0x57a14739, Offset: 0x38c8
// Size: 0x142
function scene_callback_dude_getting_eaten( a_ents )
{
    e_soldier = a_ents[ "dude_getting_eaten" ];
    e_soldier.ignoreme = 1;
    e_soldier cybercom::cybercom_aioptout( "cybercom_fireflyswarm" );
    looping = 1;
    
    while ( looping )
    {
        a_players = getplayers();
        
        for ( i = 0; i < a_players.size ; i++ )
        {
            dist = distance( self.origin, a_players[ i ].origin );
            
            if ( dist < 600 )
            {
                looping = 0;
                break;
            }
        }
        
        e_wolf1 = a_ents[ "intro_wolf_eating_1" ];
        e_wolf2 = a_ents[ "intro_wolf_eating_2" ];
        
        if ( !isalive( e_wolf1 ) || !isalive( e_wolf2 ) )
        {
            looping = 0;
            break;
        }
        
        wait 0.05;
    }
    
    level thread scene::play( self.targetname );
}

// Namespace forest_surreal
// Params 0
// Checksum 0xdef677bb, Offset: 0x3a18
// Size: 0xab
function wolf_intro_music()
{
    s_howl = struct::get_array( "wolf_intro_howl_struct", "targetname" );
    level notify( #"hash_973240bd" );
    
    foreach ( struct in s_howl )
    {
        playsoundatposition( "aml_dire_wolf_howl", struct.origin );
        wait 0.25;
    }
}

// Namespace forest_surreal
// Params 0
// Checksum 0xd40707f3, Offset: 0x3ad0
// Size: 0x82
function dogs_approaching_trench()
{
    a_spawners = getentarray( "trench_dogs_coop", "targetname" );
    
    for ( i = 0; i < a_spawners.size ; i++ )
    {
        spawner::simple_spawn_single( a_spawners[ i ] );
        util::wait_network_frame();
    }
    
    spawn_manager::enable( "sm_trench_dogs_wave2" );
}

// Namespace forest_surreal
// Params 0
// Checksum 0x3d6c52f, Offset: 0x3b60
// Size: 0x4a
function dogs_left_side()
{
    e_trigger = getent( "t_jumping_dogs_after_trench", "targetname" );
    e_trigger waittill( #"trigger" );
    spawn_manager::enable( "sm_dogs_left_side" );
}

// Namespace forest_surreal
// Params 0
// Checksum 0x8afa454d, Offset: 0x3bb8
// Size: 0x4a
function dogs_right_side()
{
    e_trigger = getent( "t_jumping_dogs_after_trench", "targetname" );
    e_trigger waittill( #"trigger" );
    spawn_manager::enable( "sm_dogs_right_side" );
}

// Namespace forest_surreal
// Params 0
// Checksum 0x709181a6, Offset: 0x3c10
// Size: 0xea
function ending_dogs_left()
{
    level endon( #"world_falls_away_ravine_start" );
    level thread catch_ending_trigger();
    level thread catch_ending_spawners_complete();
    
    while ( true )
    {
        if ( isdefined( level.ending_trigger ) && level.ending_trigger && isdefined( level.spawners_complete_time ) )
        {
            break;
        }
        
        wait 0.05;
    }
    
    while ( true )
    {
        time = gettime();
        dt = ( time - level.spawners_complete_time ) / 1000;
        
        if ( dt > 5 )
        {
            break;
        }
        
        wait 0.05;
    }
    
    level notify( #"spawning_ending_dogs" );
    level notify( #"spawn_ending_dogs" );
    level.wolf_sprint_min_dist = -6;
    level.wolf_sprint_max_dist = 600;
    spawn_manager::enable( "sm_ending_dogs_left" );
}

// Namespace forest_surreal
// Params 0
// Checksum 0x90c95a64, Offset: 0x3d08
// Size: 0x2a
function ending_dogs_right()
{
    level endon( #"world_falls_away_ravine_start" );
    level waittill( #"spawn_ending_dogs" );
    spawn_manager::enable( "sm_ending_dogs_right" );
}

// Namespace forest_surreal
// Params 0
// Checksum 0x4794175e, Offset: 0x3d40
// Size: 0x3e
function catch_ending_trigger()
{
    e_trigger = getent( "t_ending_dogs", "targetname" );
    e_trigger waittill( #"trigger" );
    level.ending_trigger = 1;
}

// Namespace forest_surreal
// Params 0
// Checksum 0xc27ef0f1, Offset: 0x3d88
// Size: 0x165
function catch_ending_spawners_complete()
{
    s_struct = struct::get( "s_turn_off_eyecandy_wolves", "targetname" );
    v_forward = anglestoforward( s_struct.angles );
    
    while ( true )
    {
        if ( spawn_manager::is_complete( "sm_dogs_left_side" ) && spawn_manager::is_complete( "sm_dogs_right_side" ) )
        {
            if ( !isdefined( level.spawners_complete_time ) )
            {
                level.spawners_complete_time = gettime();
            }
            
            a_players = getplayers();
            num_players_passed = 0;
            
            for ( i = 0; i < a_players.size ; i++ )
            {
                e_player = a_players[ i ];
                v_dir = e_player.origin - s_struct.origin;
                v_dir = vectornormalize( v_dir );
                dp = vectordot( v_dir, v_forward );
                
                if ( dp > 0.2 )
                {
                    num_players_passed++;
                }
            }
            
            if ( num_players_passed == a_players.size )
            {
                break;
            }
        }
        
        wait 0.05;
    }
}

// Namespace forest_surreal
// Params 0
// Checksum 0x5624100e, Offset: 0x3ef8
// Size: 0x142
function spawn_func_wolf()
{
    self endon( #"death" );
    
    if ( !isdefined( level.wolf_sprint_min_dist ) )
    {
        return;
    }
    
    self.overrideactordamage = &callback_wolf_damage;
    
    if ( !( isdefined( self.script_noteworthy ) && self.script_noteworthy == "no_audio" ) )
    {
        playsoundatposition( "aml_dire_wolf_howl", self.origin );
        self thread infection_util::zmbaivox_notifyconvert();
    }
    
    initial_delay = 0;
    
    if ( isdefined( self.script_string ) && self.script_string == "sprinter" )
    {
        self ai::set_behavior_attribute( "sprint", 1 );
        return;
    }
    
    if ( isdefined( self.script_string ) && self.script_string == "stalker" )
    {
        initial_delay = randomintrange( 6, 12 );
    }
    
    dist = randomintrange( level.wolf_sprint_min_dist, level.wolf_sprint_max_dist );
    
    if ( isdefined( self.script_float ) )
    {
        dist = self.script_float;
    }
    
    self thread wolf_sprint_check( initial_delay, dist );
}

// Namespace forest_surreal
// Params 12
// Checksum 0x9b6c37db, Offset: 0x4048
// Size: 0x83
function callback_wolf_damage( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, modelindex, psoffsettime, bonename )
{
    if ( isdefined( eattacker ) && !isplayer( eattacker ) )
    {
        idamage = 0;
    }
    
    return idamage;
}

// Namespace forest_surreal
// Params 2
// Checksum 0x256d8163, Offset: 0x40d8
// Size: 0xa3
function wolf_sprint_check( initial_delay, sprint_dist )
{
    self endon( #"death" );
    self endon( #"kill_sprint_check" );
    
    if ( isdefined( initial_delay ) )
    {
        wait initial_delay;
    }
    
    while ( true )
    {
        dist = dist_to_players( self.origin );
        
        if ( dist < sprint_dist )
        {
            self ai::set_behavior_attribute( "sprint", 1 );
            return;
        }
        
        delay = randomfloatrange( 0, 1 );
        wait delay;
    }
}

// Namespace forest_surreal
// Params 0
// Checksum 0x70db951b, Offset: 0x4188
// Size: 0xb1
function dog_meat_guys()
{
    level.num_trench_guys_killed = 0;
    a_guys = getentarray( "sp_enemy_trench", "targetname" );
    
    for ( i = 0; i < a_guys.size ; i++ )
    {
        e_ent = spawner::simple_spawn_single( a_guys[ i ] );
        e_ent.name = "";
        e_ent thread ent_run_to_goal( 1 );
        e_ent thread count_trench_guy_deaths();
        e_ent.goalradius = 64;
        util::wait_network_frame();
    }
}

// Namespace forest_surreal
// Params 0
// Checksum 0xfe76853b, Offset: 0x4248
// Size: 0x12
function count_trench_guy_deaths()
{
    self waittill( #"death" );
    level.num_trench_guys_killed++;
}

// Namespace forest_surreal
// Params 1
// Checksum 0xa8c1b949, Offset: 0x4268
// Size: 0x8b
function dist_to_players( pos )
{
    closest = 999999;
    a_players = getplayers();
    
    for ( i = 0; i < a_players.size ; i++ )
    {
        dist = distance( a_players[ i ].origin, pos );
        
        if ( dist < closest )
        {
            closest = dist;
        }
    }
    
    return closest;
}

// Namespace forest_surreal
// Params 1
// Checksum 0x7ed2b5ce, Offset: 0x4300
// Size: 0x12b
function looking_at_players_angle( ignore_z )
{
    best_dp = 1000;
    v_pos = self.origin;
    v_forward = vectornormalize( anglestoforward( self.angles ) );
    
    if ( ignore_z )
    {
        v_pos = ( v_pos[ 0 ], v_pos[ 1 ], 0 );
    }
    
    a_players = getplayers();
    
    for ( i = 0; i < a_players.size ; i++ )
    {
        player_origin = a_players[ i ].origin;
        
        if ( ignore_z )
        {
            player_origin = ( player_origin[ 0 ], player_origin[ 1 ], 0 );
        }
        
        v_dir = vectornormalize( player_origin - v_pos );
        dp = vectordot( v_forward, v_dir );
        
        if ( dp < best_dp )
        {
            best_dp = dp;
        }
    }
    
    return best_dp;
}

// Namespace forest_surreal
// Params 0
// Checksum 0x911c6b01, Offset: 0x4438
// Size: 0x42
function dog_eyecandy()
{
    start_pos = struct::get_array( "dog_eyecandy_startpath" );
    array::thread_all( start_pos, &dog_follow_nodes_eyecandy );
}

// Namespace forest_surreal
// Params 0
// Checksum 0xf5e537ce, Offset: 0x4488
// Size: 0xd3
function dog_follow_nodes_eyecandy()
{
    level endon( #"world_falls_away_ravine_start" );
    level endon( #"ending_dogs_starting" );
    level endon( #"spawning_ending_dogs" );
    
    while ( true )
    {
        dog_spawner = getent( "sp_eyecandy_wolf", "targetname" );
        wolf = spawner::simple_spawn_single( dog_spawner );
        wolf thread wolf_drone_path( self );
        
        if ( isdefined( self.script_vector ) )
        {
            delay = randomfloatrange( self.script_vector[ 0 ], self.script_vector[ 1 ] );
        }
        else
        {
            delay = randomfloatrange( 53, 55 );
        }
        
        wait delay;
    }
}

// Namespace forest_surreal
// Params 1
// Checksum 0xfa2fb536, Offset: 0x4568
// Size: 0x172
function wolf_drone_path( s_path )
{
    self endon( #"death" );
    
    if ( !isdefined( level.dog_delay ) )
    {
        level.dog_delay = 0;
    }
    
    self notify( #"kill_sprint_check" );
    self thread wolf_start_running( level.dog_delay, 15 );
    level.dog_delay += 1;
    
    if ( level.dog_delay > 6 )
    {
        level.dog_delay = 0;
    }
    
    self.goalradius = 32;
    self ai::set_ignoreall( 1 );
    self ai::set_ignoreme( 1 );
    
    while ( true )
    {
        if ( !s_path infection_util::player_can_see_me( 50 ) )
        {
            break;
        }
        
        wait 0.25;
    }
    
    self forceteleport( s_path.origin, s_path.angles );
    next_pos = s_path;
    
    while ( true )
    {
        if ( isdefined( next_pos.target ) )
        {
            next_pos = struct::get( next_pos.target, "targetname" );
        }
        else
        {
            break;
        }
        
        self setgoalpos( next_pos.origin, 1, 32 );
        self waittill( #"goal" );
    }
    
    self delete();
}

// Namespace forest_surreal
// Params 2
// Checksum 0xb3bef290, Offset: 0x46e8
// Size: 0x92
function wolf_start_running( delay, kill_time )
{
    self endon( #"death" );
    start_time = gettime();
    wait delay;
    self ai::set_behavior_attribute( "sprint", 1 );
    
    while ( true )
    {
        time = gettime();
        dt = ( time - start_time ) / 1000;
        
        if ( dt > kill_time )
        {
            break;
        }
        
        wait 0.1;
    }
    
    self delete();
}

// Namespace forest_surreal
// Params 0
// Checksum 0x7fd5884f, Offset: 0x4788
// Size: 0x1a
function dogs_ignore_playeroverride()
{
    level.is_player_valid_override = &is_player_valid_dog_target;
}

// Namespace forest_surreal
// Params 1
// Checksum 0x397d4a21, Offset: 0x47b0
// Size: 0x36, Type: bool
function is_player_valid_dog_target( player )
{
    a_spawners = getentarray( "sp_enemy_trench", "targetname" );
    return true;
}

// Namespace forest_surreal
// Params 0
// Checksum 0x6aff9516, Offset: 0x47f0
// Size: 0x11a
function sarah_waits_at_ravine()
{
    objectives::set( "cp_level_infection_gather_ravine", self );
    self thread scene::init( "cin_inf_07_03_worldfallsaway_vign_pain", self );
    level notify( #"sarah_waits_at_ravine" );
    trigger::wait_till( "world_falls_away_ravine_start" );
    level notify( #"hash_fcccf4c9" );
    
    if ( isdefined( level.bzm_infectiondialogue8_1callback ) )
    {
        level thread [[ level.bzm_infectiondialogue8_1callback ]]();
    }
    
    objectives::complete( "cp_level_infection_gather_ravine", self );
    self thread scene::play( "cin_inf_07_03_worldfallsaway_vign_pain", self );
    infection_accolades::function_a2179c84();
    infection_accolades::function_74b401d8();
    infection_accolades::function_b3cf52bf();
    level waittill( #"ravine_seen_fade" );
    self thread infection_util::actor_camo( 1 );
    self.var_5d21e1c9 = 0;
    self waittill( #"scene_done" );
    self delete();
    level.sarah_ravine_anim_complete = 1;
}

// Namespace forest_surreal
// Params 0
// Checksum 0xe2289a53, Offset: 0x4918
// Size: 0x7a
function chasm_opens()
{
    level flag::init( "chasm_open" );
    level waittill( #"sarah_waits_at_ravine" );
    
    if ( isdefined( level.bzmutil_waitforallzombiestodie ) )
    {
        [[ level.bzmutil_waitforallzombiestodie ]]();
    }
    
    trigger::wait_till( "world_falls_away_ravine_start" );
    level notify( #"world_falls_away_ravine_start" );
    level thread kill_off_wolves();
    chasm_movement_start();
}

// Namespace forest_surreal
// Params 0
// Checksum 0xf499cfdc, Offset: 0x49a0
// Size: 0x1e2
function chasm_movement_start()
{
    level waittill( #"move_mountain" );
    level thread chasm_opens_effects();
    level util::clientnotify( "chasm_wind" );
    playsoundatposition( "evt_pullapart_world", ( 0, 0, 0 ) );
    level thread chasm_rumble_start();
    exploder::exploder( "light_wfa_end" );
    a_chasm = getentarray( "world_falls_away_chasm", "targetname" );
    assert( isdefined( a_chasm ), "<dev string:x5e>" );
    level thread move_cave_blocker( 12, 5, 5 );
    
    for ( i = 0; i < a_chasm.size ; i++ )
    {
        str_name = a_chasm[ i ].target;
        
        if ( isdefined( str_name ) )
        {
            s_struct = struct::get( str_name, "targetname" );
            target_position = s_struct.origin;
            a_chasm[ i ] setmovingplatformenabled( 1 );
            a_chasm[ i ] moveto( target_position, 12, 5, 5 );
        }
    }
    
    a_chasm[ 0 ] waittill( #"movedone" );
    a_chasm[ 0 ] playloopsound( "evt_pullapart_world_looper", 3 );
    level thread players_enter_cave();
    level flag::set( "chasm_open" );
}

// Namespace forest_surreal
// Params 0
// Checksum 0x2311a04b, Offset: 0x4b90
// Size: 0x1aa
function chasm_rumble_start()
{
    s_earthquake = struct::get( "chasm_earthquake_start_struct", "targetname" );
    assert( isdefined( s_earthquake ), "<dev string:x87>" );
    a_chasm = getentarray( "world_falls_away_chasm", "targetname" );
    assert( isdefined( a_chasm ), "<dev string:xbe>" );
    e_chasm = a_chasm[ 0 ];
    e_temp = spawn( "script_origin", s_earthquake.origin );
    e_temp linkto( e_chasm );
    
    while ( !level flag::get( "chasm_open" ) )
    {
        earthquake( 0.18, 0.05 * 4, e_temp.origin, 3000 );
        infection_util::slow_nearby_players( e_temp, 3000, 2 );
        playrumbleonposition( "cp_infection_world_falls_break_rumble", e_temp.origin );
        wait 0.05;
    }
    
    earthquake( 0.25, 2, e_temp.origin, 3000 );
    e_temp delete();
}

// Namespace forest_surreal
// Params 3
// Checksum 0xc8d4b711, Offset: 0x4d48
// Size: 0xaa
function move_cave_blocker( move_time, accel_time, decel_time )
{
    e_ent = getent( "world_falls_away_chasm_blocker", "targetname" );
    s_struct = struct::get( e_ent.target, "targetname" );
    e_ent moveto( s_struct.origin, move_time, accel_time, decel_time );
    e_ent waittill( #"movedone" );
    e_ent delete();
}

// Namespace forest_surreal
// Params 1
// Checksum 0x50ced728, Offset: 0x4e00
// Size: 0x3da
function chasm_opens_effects( b_skip )
{
    if ( !isdefined( b_skip ) )
    {
        b_skip = 0;
    }
    
    scene::add_scene_func( "p7_fxanim_cp_infection_rock_mountain_bundle", &fxanim_ravine_moving_rocks_callback, "play" );
    
    if ( b_skip )
    {
        level scene::skipto_end( "p7_fxanim_cp_infection_rock_mountain_bundle" );
        level scene::skipto_end( "p7_fxanim_cp_infection_rock_bridge_floaters_bundle" );
        level scene::skipto_end( "p7_fxanim_cp_infection_rock_bridge_p1_bundle" );
        level scene::skipto_end( "p7_fxanim_cp_infection_rock_bridge_p2_bundle" );
        level scene::skipto_end( "p7_fxanim_cp_infection_rock_bridge_p3_bundle" );
        exploder::exploder( "worldfallsaway_cave_separating" );
        loop_snd_ent = spawn( "script_origin", ( 938, -123, -648 ) );
        loop_snd_ent playloopsound( "evt_rock_bridge_loop", 0.5 );
    }
    else
    {
        level thread scene::play( "p7_fxanim_cp_infection_rock_mountain_bundle" );
        level thread scene::play( "p7_fxanim_cp_infection_rock_bridge_floaters_bundle" );
        exploder::exploder( "worldfallsaway_cave_separating" );
        level thread scene::play( "p7_fxanim_cp_infection_rock_bridge_p1_bundle" );
        level thread scene::play( "p7_fxanim_cp_infection_rock_bridge_p2_bundle" );
        scene::play( "p7_fxanim_cp_infection_rock_bridge_p3_bundle" );
        loop_snd_ent = spawn( "script_origin", ( 938, -123, -648 ) );
        loop_snd_ent playloopsound( "evt_rock_bridge_loop", 0.5 );
        wait 0.5;
    }
    
    objectives::set( "cp_level_infection_cross_chasm" );
    level thread objectives::breadcrumb( "cave_entrance" );
    var_c1b53c54 = getentarray( "chasm_entrance_player_clip", "targetname" );
    array::run_all( var_c1b53c54, &delete );
    
    foreach ( player in level.players )
    {
        player thread function_baefbe37();
    }
    
    infection_util::wait_for_all_players_to_pass_struct( "s_ravine_drop_marker_p3" );
    level notify( #"hash_7303e8be" );
    level notify( #"end_salm_forest_dialog" );
    level thread scene::play( "p7_fxanim_cp_infection_rock_bridge_p3_end_bundle" );
    level thread function_43a1f475( "rock_bridge_p3" );
    wait 0.5;
    level thread scene::play( "p7_fxanim_cp_infection_rock_bridge_p2_end_bundle" );
    level thread function_43a1f475( "rock_bridge_p2" );
    wait 0.5;
    level thread scene::play( "p7_fxanim_cp_infection_rock_bridge_p1_end_bundle" );
    level thread function_43a1f475( "rock_bridge_p1" );
    loop_snd_ent stoploopsound( 0.5 );
    loop_snd_ent delete();
    level waittill( #"hash_5d80c772" );
    level thread scene::stop( "p7_fxanim_cp_infection_rock_bridge_floaters_bundle" );
}

// Namespace forest_surreal
// Params 1
// Checksum 0x4feb2ad2, Offset: 0x51e8
// Size: 0x10a
function function_43a1f475( str_rock )
{
    mdl_rock = getent( str_rock, "targetname" );
    var_9636be2f = getentarray( str_rock + "_clip", "targetname" );
    var_7b12f4c7 = strtok( str_rock, "rock_bridge_p" );
    var_8f915eab = "platform_" + var_7b12f4c7[ 0 ] + "_jnt";
    array::run_all( var_9636be2f, &linkto, mdl_rock, var_8f915eab );
    
    if ( isdefined( mdl_rock._o_scene ) )
    {
        mdl_rock._o_scene._e_root util::waittill_notify_or_timeout( "scene_done", 10 );
    }
    
    array::run_all( var_9636be2f, &delete );
}

// Namespace forest_surreal
// Params 0
// Checksum 0xcf1548b3, Offset: 0x5300
// Size: 0x95
function function_baefbe37()
{
    self endon( #"death" );
    level endon( #"hash_7303e8be" );
    s_destination = struct::get( "s_cave_entrance", "targetname" );
    
    while ( true )
    {
        wait 3;
        
        if ( !self infection_util::lookingatstructdurationonly( s_destination, 0.1 ) )
        {
            level thread objectives::show( "cp_waypoint_breadcrumb", self );
            continue;
        }
        
        level thread objectives::hide( "cp_waypoint_breadcrumb", self );
    }
}

// Namespace forest_surreal
// Params 1
// Checksum 0x3437e70, Offset: 0x53a0
// Size: 0x5a
function fxanim_ravine_moving_rocks_callback( a_ents )
{
    e_effect = a_ents[ "rock_mountain" ];
    e_rock = getent( "final_position_3", "target" );
    e_effect linkto( e_rock );
}

// Namespace forest_surreal
// Params 0
// Checksum 0xcf7b947f, Offset: 0x5408
// Size: 0xb1
function kill_off_wolves()
{
    if ( !spawn_manager::is_complete( "sm_ending_dogs_left" ) )
    {
        spawn_manager::disable( "sm_ending_dogs_left" );
    }
    
    if ( !spawn_manager::is_complete( "sm_ending_dogs_right" ) )
    {
        spawn_manager::disable( "sm_ending_dogs_right" );
    }
    
    a_ai = getaiteamarray( "team3" );
    
    for ( i = 0; i < a_ai.size ; i++ )
    {
        a_ai[ i ] kill();
    }
}

// Namespace forest_surreal
// Params 0
// Checksum 0xd08199b8, Offset: 0x54c8
// Size: 0xa2
function wait_for_player_to_enter_black_station()
{
    trigger = getent( "black_station_start_trigger", "targetname" );
    trigger waittill( #"trigger", who );
    util::screen_fade_out( 1, "black" );
    level notify( #"end_salm_forest_dialog" );
    level notify( #"level_complete_cleanup" );
    a_chasm = getentarray( "world_falls_away_chasm", "targetname" );
    a_chasm[ 0 ] stoploopsound( 5 );
}

// Namespace forest_surreal
// Params 0
// Checksum 0xa78e0883, Offset: 0x5578
// Size: 0x82
function wfa_falling_platform_guys()
{
    level thread world_falls_away_falling_guys( "t_world_falls_away_intro", "world_falls_away_intro_falling_guys" );
    level thread world_falls_away_falling_guys( "sm_world_falls_away_middle", "world_falls_away_middle_falling_guys" );
    level thread world_falls_away_falling_guys( "t_left_side_fallers_1", "world_falls_away_left_1_falling_guys" );
    level thread world_falls_away_falling_guys( "t_left_side_fallers_1", "wfa_middle_path_falling_guys" );
}

// Namespace forest_surreal
// Params 2
// Checksum 0x7035fd27, Offset: 0x5608
// Size: 0x141
function world_falls_away_falling_guys( str_trigger, str_spawners )
{
    e_trigger = getent( str_trigger, "targetname" );
    
    if ( isdefined( e_trigger ) )
    {
        e_trigger waittill( #"trigger" );
        a_spawners = getentarray( str_spawners, "targetname" );
        
        for ( i = 0; i < a_spawners.size ; i++ )
        {
            s_struct = struct::get( a_spawners[ i ].script_string, "script_noteworthy" );
            e_falling_piece = s_struct.moving_platform;
            
            if ( isdefined( e_falling_piece ) && !e_falling_piece.var_efe20130 )
            {
                e_ent = spawner::simple_spawn_single( a_spawners[ i ], &fall_from_rock_guy );
                infection_util::cleanup_group_add( e_ent, "FALLING_GUYS" );
                util::wait_network_frame();
                continue;
            }
            
            /#
                iprintlnbold( "<dev string:xe9>" );
            #/
        }
    }
}

// Namespace forest_surreal
// Params 0
// Checksum 0xc1099c67, Offset: 0x5758
// Size: 0x1e2
function fall_from_rock_guy()
{
    self endon( #"death" );
    
    if ( isdefined( self.radius ) )
    {
        self.goalradius = self.radius;
    }
    
    if ( isdefined( self.script_noteworthy ) && issubstr( self.script_noteworthy, "cin_" ) )
    {
        self.goalradius = 64;
        custom_fall_anim = self.script_noteworthy;
    }
    
    if ( isdefined( self.target ) )
    {
        self thread goto_target_faller();
    }
    
    s_struct = struct::get( self.script_string, "script_noteworthy" );
    e_falling_piece = s_struct.moving_platform;
    
    if ( isdefined( e_falling_piece ) )
    {
        e_falling_piece waittill( #"starting_move_up" );
        self.ignoreall = 1;
        wait e_falling_piece.moveup_time;
        
        if ( true )
        {
            if ( isdefined( custom_fall_anim ) )
            {
                wait 0.2;
                self thread scene::play( custom_fall_anim, self );
                wait 1.2;
                self kill();
                return;
            }
        }
        
        str_wobble_anim = get_wobble_animation();
        
        if ( true )
        {
            self thread scene::play( str_wobble_anim, self );
        }
        
        e_falling_piece waittill( #"fall_starting" );
        
        if ( true )
        {
            self scene::stop( str_wobble_anim );
        }
        
        if ( true )
        {
            if ( !isdefined( level.vign_fall_anim_index ) )
            {
                init_vign_fall_anims();
            }
            
            str_anim = get_vign_fall_anim();
            scene::play( str_anim, self );
        }
        else
        {
            wait 5;
        }
    }
    
    self delete();
}

// Namespace forest_surreal
// Params 0
// Checksum 0x5107ee9d, Offset: 0x5948
// Size: 0xd4
function get_wobble_animation()
{
    if ( !isdefined( level.wobble_anim_index ) )
    {
        level.wobble_anim_index = 0;
    }
    
    switch ( level.wobble_anim_index )
    {
        case 0:
            str_animation = "cin_gen_vign_offbalance_a";
            break;
        case 1:
            str_animation = "cin_gen_vign_offbalance_b";
            break;
        case 2:
            str_animation = "cin_gen_vign_offbalance";
            break;
        case 3:
            str_animation = "cin_gen_vign_offbalance_left";
            break;
        case 4:
            str_animation = "cin_gen_vign_offbalance_right";
            break;
        case 5:
        default:
            str_animation = "cin_gen_vign_offbalance_center";
            break;
    }
    
    level.wobble_anim_index++;
    
    if ( level.wobble_anim_index > 1 )
    {
        level.wobble_anim_index = 0;
    }
    
    return str_animation;
}

// Namespace forest_surreal
// Params 0
// Checksum 0xfcdbaf8d, Offset: 0x5a28
// Size: 0x20
function goto_target_faller()
{
    self endon( #"death" );
    self.goalradius = 64;
    self waittill( #"goal" );
}

// Namespace forest_surreal
// Params 0
// Checksum 0x43ea3bfb, Offset: 0x5a50
// Size: 0xe3
function init_vign_fall_anims()
{
    level.vign_anim_index = 0;
    level.a_vign_fall_anims = [];
    
    if ( !isdefined( level.a_vign_fall_anims ) )
    {
        level.a_vign_fall_anims = [];
    }
    else if ( !isarray( level.a_vign_fall_anims ) )
    {
        level.a_vign_fall_anims = array( level.a_vign_fall_anims );
    }
    
    level.a_vign_fall_anims[ level.a_vign_fall_anims.size ] = "cin_gen_vign_fall_left";
    
    if ( !isdefined( level.a_vign_fall_anims ) )
    {
        level.a_vign_fall_anims = [];
    }
    else if ( !isarray( level.a_vign_fall_anims ) )
    {
        level.a_vign_fall_anims = array( level.a_vign_fall_anims );
    }
    
    level.a_vign_fall_anims[ level.a_vign_fall_anims.size ] = "cin_gen_vign_fall_right";
}

// Namespace forest_surreal
// Params 0
// Checksum 0xcee40efd, Offset: 0x5b40
// Size: 0x44
function get_vign_fall_anim()
{
    str_anim = level.a_vign_fall_anims[ level.vign_anim_index ];
    level.vign_anim_index++;
    
    if ( level.vign_anim_index >= level.a_vign_fall_anims.size )
    {
        level.vign_anim_index = 0;
    }
    
    return str_anim;
}

// Namespace forest_surreal
// Params 0
// Checksum 0x5fd38942, Offset: 0x5b90
// Size: 0x4a
function intro_guys()
{
    e_trigger = getent( "t_move_1st_falling_guys", "targetname" );
    e_trigger waittill( #"trigger" );
    spawn_manager::enable( "sm_world_falls_away_intro" );
}

// Namespace forest_surreal
// Params 0
// Checksum 0xa51dd54a, Offset: 0x5be8
// Size: 0x5a
function intro_guy_goto_node()
{
    self endon( #"death" );
    
    if ( isdefined( self.script_noteworthy ) )
    {
        self.goalradius = 48;
        n_node = getnode( self.script_noteworthy, "targetname" );
        self setgoal( n_node.origin );
    }
}

// Namespace forest_surreal
// Params 0
// Checksum 0xda5742a6, Offset: 0x5c50
// Size: 0x4a
function ai_middle_path_spawners()
{
    e_trigger = getent( "t_wfa_middle_path", "targetname" );
    e_trigger waittill( #"trigger" );
    spawn_manager::enable( "sm_wfa_middle_path" );
}

// Namespace forest_surreal
// Params 0
// Checksum 0x5659dc8c, Offset: 0x5ca8
// Size: 0x162
function fancy_falling_pieces_at_start()
{
    str_bundle_1 = "p7_fxanim_cp_infection_world_falling_116_bundle";
    str_bundle_2 = "p7_fxanim_cp_infection_world_falling_117_bundle";
    str_bundle_3 = "p7_fxanim_cp_infection_world_falling_132_bundle";
    level thread scene::init( str_bundle_1 );
    util::wait_network_frame();
    level thread scene::init( str_bundle_2 );
    util::wait_network_frame();
    level thread scene::init( str_bundle_3 );
    e_trigger = getent( "t_fancy_falling_pieces_at_start", "targetname" );
    e_trigger waittill( #"trigger" );
    s_struct = struct::get( "s_fancy_falling_pieces_at_start", "targetname" );
    v_rumble_origin = s_struct.origin;
    level thread fallaway_piece_rising_rumble( v_rumble_origin, 0, 1 );
    
    if ( isdefined( level.bzm_infectiondialogue8callback ) )
    {
        level thread [[ level.bzm_infectiondialogue8callback ]]();
    }
    
    level thread scene::play( str_bundle_1 );
    wait 0.75;
    level thread scene::play( str_bundle_2 );
    wait 1.25;
    level thread scene::play( str_bundle_3 );
}

// Namespace forest_surreal
// Params 0
// Checksum 0x3759398, Offset: 0x5e18
// Size: 0x32
function forest_surreal_cleanup_thread()
{
    cleanup_bastogne_ai();
    level waittill( #"wolves_start_attacking" );
    infection_util::cleanup_group_kill( "FALLING_GUYS", 1 );
}

// Namespace forest_surreal
// Params 0
// Checksum 0x310baeb, Offset: 0x5e58
// Size: 0x2a
function forest_wolves_cleanup_thread()
{
    level thread cleanup_soldiers_in_forest_surreal();
    level waittill( #"level_complete_cleanup" );
    level thread level_complete_cleanup();
}

// Namespace forest_surreal
// Params 0
// Checksum 0x8457b341, Offset: 0x5e90
// Size: 0x18b
function cleanup_bastogne_ai()
{
    colors::kill_color_replacements();
    a_allies = getaiteamarray( "allies" );
    
    foreach ( ai in a_allies )
    {
        if ( isdefined( ai.targetname ) )
        {
            if ( issubstr( ai.targetname, "friendly_guys_bastogne_" ) )
            {
                ai thread delete_not_seen( 512 );
            }
        }
    }
    
    a_axis = getaiteamarray( "axis" );
    
    foreach ( ai in a_axis )
    {
        if ( isdefined( ai.targetname ) )
        {
            if ( issubstr( ai.targetname, "reverse_anim_" ) || issubstr( ai.targetname, "sm_bastogne_reinforcements_" ) )
            {
                ai thread delete_not_seen( 1024 );
            }
        }
    }
}

// Namespace forest_surreal
// Params 0
// Checksum 0x6701f559, Offset: 0x6028
// Size: 0x1d9
function cleanup_soldiers_in_forest_surreal()
{
    a_ai = getaiteamarray( "axis" );
    
    if ( isdefined( a_ai ) )
    {
        if ( a_ai.size > 0 )
        {
            a_sorted_ai = infection_util::ent_array_distance_from_players( a_ai );
            num_to_kill = a_sorted_ai.size - 0;
            
            for ( i = 0; i < num_to_kill ; i++ )
            {
                n_index = a_sorted_ai.size - 1 - i;
                a_sorted_ai[ n_index ] util::stop_magic_bullet_shield();
                a_sorted_ai[ n_index ] thread delete_not_seen( 512 );
            }
        }
    }
    
    e_info_volume = getent( "world_falls_apart_soldier_kill_volume", "targetname" );
    a_ai = getaiteamarray( "axis" );
    
    if ( isdefined( a_ai ) )
    {
        for ( i = 0; i < a_ai.size ; i++ )
        {
            if ( a_ai[ i ] istouching( e_info_volume ) )
            {
                a_ai[ i ].ignoreme = 1;
            }
        }
    }
    
    e_trigger = getent( "t_jumping_dogs_after_trench", "targetname" );
    e_trigger waittill( #"trigger" );
    a_ai = getaiteamarray( "axis" );
    
    if ( isdefined( a_ai ) )
    {
        for ( i = 0; i < a_ai.size ; i++ )
        {
            if ( a_ai[ i ] istouching( e_info_volume ) )
            {
                a_ai[ i ] thread delete_not_seen( 512 );
            }
        }
    }
}

// Namespace forest_surreal
// Params 0
// Checksum 0xa77fd673, Offset: 0x6210
// Size: 0x52
function level_complete_cleanup()
{
    infection_util::enable_exploding_deaths( 0 );
    infection_util::turn_off_snow_fx_for_all_players();
    infection_util::delete_all_ai();
    infection_util::delete_ents_if_defined( "reverse_anim_trigger", "script_noteworthy" );
}

// Namespace forest_surreal
// Params 0
// Checksum 0xe3ef5dd1, Offset: 0x6270
// Size: 0x7a
function hanging_on_ledge_dudes()
{
    scene::add_scene_func( "cin_gen_vign_fall_fall", &guy_hanging_from_rock_callback, "play" );
    a_scene_bundles = struct::get_array( "hanging_on_ledge_dude", "targetname" );
    level thread array::spread_all( a_scene_bundles, &update_hanging_dude );
}

// Namespace forest_surreal
// Params 0
// Checksum 0x752fc70c, Offset: 0x62f8
// Size: 0x52
function update_hanging_dude()
{
    level endon( #"wolves_start_attacking" );
    level waittill( self.script_string );
    buffer_time = 2;
    wait 2.7 + buffer_time;
    
    if ( isdefined( self.script_delay ) )
    {
        wait self.script_delay;
    }
    
    self scene::play();
}

// Namespace forest_surreal
// Params 0
// Checksum 0xee9e5d9e, Offset: 0x6358
// Size: 0x4a
function function_e8d77ec8()
{
    a_scene_bundles = struct::get_array( "hanging_on_ledge_dude_background", "targetname" );
    level thread array::spread_all( a_scene_bundles, &function_7daee669 );
}

// Namespace forest_surreal
// Params 0
// Checksum 0x78b42eeb, Offset: 0x63b0
// Size: 0x6a
function function_7daee669()
{
    level endon( #"wolves_start_attacking" );
    var_fcf5da5e = getent( self.target, "targetname" );
    var_fcf5da5e waittill( #"trigger", player );
    
    if ( isdefined( self.script_delay ) )
    {
        wait self.script_delay;
    }
    
    self scene::play();
}

// Namespace forest_surreal
// Params 1
// Checksum 0x23ecfdfc, Offset: 0x6428
// Size: 0xa
function guy_hanging_from_rock_callback( a_ents )
{
    
}

// Namespace forest_surreal
// Params 1
// Checksum 0xc8228f2d, Offset: 0x6440
// Size: 0x75
function debug_line( e_ent )
{
    e_ent endon( #"death" );
    
    while ( true )
    {
        v_start = e_ent.origin;
        v_end = v_start + ( 0, 0, 1000 );
        v_col = ( 1, 1, 1 );
        
        /#
            line( v_start, v_end, v_col );
        #/
        
        wait 0.1;
    }
}

