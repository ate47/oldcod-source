#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_lotus2_sound;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/cp/lotus_util;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace lotus_pursuit;

// Namespace lotus_pursuit
// Params 2
// Checksum 0xd50098ac, Offset: 0xe50
// Size: 0x2ea
function stand_down_main( str_objective, b_starting )
{
    var_d6cea0d7 = getent( "trig_kick_door", "targetname" );
    var_d6cea0d7 triggerenable( 0 );
    battlechatter::function_d9f49fba( 0 );
    
    if ( b_starting )
    {
        load::function_73adcefc();
        level.ai_hendricks = util::get_hero( "hendricks" );
        level.ai_hendricks.allowbattlechatter[ "bc" ] = 0;
        skipto::teleport_ai( str_objective );
        level.ai_hendricks colors::disable();
        level.ai_hendricks setgoal( getnode( "hendricks_stand_down_door_node", "targetname" ), 0, 32 );
        level.ai_hendricks ai::set_behavior_attribute( "coverIdleOnly", 1 );
        a_delete = getentarray( "aigroup_detention_center", "script_aigroup" );
        array::delete_all( a_delete );
        level util::set_streamer_hint( 2, 1 );
        level scene::init( "cin_lot_08_01_standdown_sh010" );
        load::function_a2995f22();
        level lotus_util::function_484bc3aa( 1 );
    }
    
    level.ai_hendricks ai::set_ignoreall( 1 );
    level.ai_hendricks ai::set_ignoreme( 1 );
    level.ai_hendricks setgoal( level.ai_hendricks.origin, 1 );
    level dialog::remote( "kane_taylor_s_through_tha_0", 0.25 );
    a_enemies = getaiteamarray( "axis" );
    array::run_all( a_enemies, &delete );
    level thread lotus2_sound::function_a3388bcf();
    var_d6cea0d7 triggerenable( 1 );
    util::init_interactive_gameobject( var_d6cea0d7, &"cp_level_lotus_stand_down_door", &"CP_MI_CAIRO_LOTUS_BREACH", &function_8019e0e5 );
    level thread scene::play( "pursuit_initial_bodies" );
    level thread function_e3e58995();
}

// Namespace lotus_pursuit
// Params 0
// Checksum 0x1bd1b9d5, Offset: 0x1148
// Size: 0x92
function function_e3e58995()
{
    level endon( #"hash_e93df84" );
    wait 5;
    var_a6225d0e = arraygetclosest( level.ai_hendricks.origin, level.players );
    
    if ( distancesquared( var_a6225d0e.origin, level.ai_hendricks.origin ) > 122500 )
    {
        level.ai_hendricks thread dialog::say( "hend_c_mon_post_on_me_l_0", 0.25 );
    }
}

// Namespace lotus_pursuit
// Params 1
// Checksum 0xe880a6e4, Offset: 0x11e8
// Size: 0x35a
function function_8019e0e5( e_player )
{
    self gameobjects::disable_object();
    level notify( #"hash_e93df84" );
    lotus_util::function_3b6587d6( 1, "lotus2_standdown_igc_umbra_gate" );
    level.ai_hendricks ai::set_ignoreall( 0 );
    level.ai_hendricks ai::set_ignoreme( 0 );
    level thread lotus2_sound::function_973b77f9();
    level clientfield::set( "sndIGCsnapshot", 1 );
    objectives::complete( "cp_level_lotus_stand_down_door" );
    spawner::add_spawn_function_ai_group( "standdown_robos", &function_623dfa9f );
    scene::add_scene_func( "cin_lot_08_01_standdown_sh010", &stand_down_setup );
    scene::add_scene_func( "cin_lot_08_01_standdown_sh100", &function_50ac7315 );
    scene::add_scene_func( "cin_lot_08_01_standdown_sh230", &function_1faa71ce );
    scene::add_scene_func( "cin_lot_08_01_standdown_sh270", &function_6a59f8cb );
    scene::add_scene_func( "cin_lot_08_01_standdown_sh280", &function_e26078a4, "done" );
    scene::add_scene_func( "cin_gen_hendricksmoment_riphead_robot", &function_b58d1d50 );
    
    if ( isdefined( level.bzm_lotusdialogue4callback ) )
    {
        level thread [[ level.bzm_lotusdialogue4callback ]]();
    }
    
    level util::streamer_wait( undefined, 1, 10 );
    level scene::play( "cin_lot_08_01_standdown_sh010", e_player );
    e_glass = scene::get_existing_ent( "interrogation_room_glass" );
    level thread function_5c1f1535( e_glass );
    s_goal = struct::get( "pursuit_ai" );
    level.ai_hendricks setgoal( s_goal.origin, 0, 64 );
    level thread function_4869f17d();
    level waittill( #"hash_fa07455a" );
    e_glass show();
    util::clear_streamer_hint();
    remove_prometheus_window_clip();
    
    foreach ( player in level.players )
    {
        player util::set_low_ready( 0 );
    }
    
    skipto::objective_completed( "stand_down" );
    self gameobjects::destroy_object( 1 );
}

// Namespace lotus_pursuit
// Params 1
// Checksum 0x70ec90e0, Offset: 0x1550
// Size: 0xa2
function function_5c1f1535( e_glass )
{
    level endon( #"hash_fa07455a" );
    level waittill( #"hash_3678706d" );
    e_glass hide();
    level waittill( #"hash_da20ef20" );
    e_glass show();
    level waittill( #"hash_de5f95bf" );
    e_glass hide();
    level waittill( #"hash_130e1922" );
    e_glass show();
    level waittill( #"hash_906aafb6" );
    e_glass hide();
    level waittill( #"hash_90c52573" );
    e_glass show();
}

// Namespace lotus_pursuit
// Params 1
// Checksum 0x10cb366a, Offset: 0x1600
// Size: 0xd2
function function_b58d1d50( a_ents )
{
    level endon( #"pursuit_done" );
    ai_robot = a_ents[ "riphead_robot" ];
    level util::waittill_notify_or_timeout( "robot_head_off", 3 );
    
    if ( isdefined( ai_robot ) )
    {
        ai_robot util::stop_magic_bullet_shield();
        gibserverutils::gibhead( ai_robot );
    }
    
    t_continue_hendricks = getent( "continue_hendricks", "targetname" );
    
    if ( isdefined( t_continue_hendricks ) )
    {
        level.ai_hendricks colors::enable();
        trigger::use( "continue_hendricks", "targetname" );
    }
}

// Namespace lotus_pursuit
// Params 0
// Checksum 0xbc5587b5, Offset: 0x16e0
// Size: 0xa2
function wait_for_standdown_robos_deaths()
{
    spawner::waittill_ai_group_cleared( "standdown_robos" );
    level thread function_88486511();
    level.ai_hendricks ai::set_ignoreall( 0 );
    level.ai_hendricks colors::enable();
    level clientfield::set( "sndIGCsnapshot", 0 );
    level thread function_6678da67();
    level thread function_ae2d3f70();
    level thread function_c8e59dae();
}

// Namespace lotus_pursuit
// Params 0
// Checksum 0xfb6342d2, Offset: 0x1790
// Size: 0x1a
function function_c8e59dae()
{
    objectives::breadcrumb( "pursuit_breadcrumb01" );
}

// Namespace lotus_pursuit
// Params 0
// Checksum 0x64ff0994, Offset: 0x17b8
// Size: 0xb2
function function_88486511()
{
    level endon( #"pursuit_done" );
    savegame::checkpoint_save();
    level thread function_fc2eabb1( "nearside_enemies" );
    level thread function_fc2eabb1( "farside_enemies" );
    flag::wait_till( "lotus_snow_1" );
    
    while ( !flag::get( "farside_enemies_dead" ) && !flag::get( "farside_enemies_dead" ) )
    {
        wait 0.25;
    }
    
    savegame::checkpoint_save();
}

// Namespace lotus_pursuit
// Params 1
// Checksum 0xfeaf8b47, Offset: 0x1878
// Size: 0x6a
function function_fc2eabb1( str_ai_group )
{
    level endon( #"pursuit_done" );
    var_df8970d = str_ai_group + "_dead";
    flag::init( var_df8970d );
    spawner::waittill_ai_group_cleared( str_ai_group );
    savegame::checkpoint_save();
    flag::set( var_df8970d );
}

// Namespace lotus_pursuit
// Params 1
// Checksum 0x52d2c5d, Offset: 0x18f0
// Size: 0x82
function stand_down_setup( a_ents )
{
    foreach ( player in level.players )
    {
        player util::set_low_ready( 1 );
    }
    
    level.ai_hendricks ai::set_ignoreall( 1 );
}

// Namespace lotus_pursuit
// Params 1
// Checksum 0x587fc888, Offset: 0x1980
// Size: 0x52
function function_50ac7315( a_ents )
{
    a_ents[ "standdown_robot01" ] thread function_8bff8df9();
    a_ents[ "standdown_robot02" ] thread function_8bff8df9();
    a_ents[ "standdown_robot03" ] thread function_8bff8df9();
}

// Namespace lotus_pursuit
// Params 0
// Checksum 0xaa1feba8, Offset: 0x19e0
// Size: 0x2a
function function_8bff8df9()
{
    self waittill( #"hash_e5b0f8fa" );
    self ai::set_behavior_attribute( "rogue_control", "forced_level_1" );
}

// Namespace lotus_pursuit
// Params 1
// Checksum 0xa300910e, Offset: 0x1a18
// Size: 0x4a
function function_6a59f8cb( a_ents )
{
    var_51ffb7a3 = struct::get( "standdown_explode_here", "targetname" );
    level thread scene::play( "p7_fxanim_cp_lotus_interrogation_room_glass_bundle" );
}

// Namespace lotus_pursuit
// Params 1
// Checksum 0x1a676405, Offset: 0x1a70
// Size: 0x6a
function function_9ab22ea( var_3ad5e8e )
{
    ai_robot = getent( var_3ad5e8e, "targetname" );
    
    if ( isdefined( ai_robot ) )
    {
        ai_robot ai::set_behavior_attribute( "rogue_control", "forced_level_3" );
        ai_robot ai::set_behavior_attribute( "rogue_force_explosion", 1 );
    }
}

// Namespace lotus_pursuit
// Params 1
// Checksum 0x7f2da8c5, Offset: 0x1ae8
// Size: 0x3ba
function function_e26078a4( a_ents )
{
    e_taylor = scene::get_existing_ent( "prometheus" );
    
    if ( isdefined( e_taylor ) )
    {
        e_taylor delete();
    }
    
    level util::teleport_players_igc( "pursuit" );
    
    foreach ( player in level.players )
    {
        player util::set_low_ready( 0 );
    }
    
    level thread lotus2_sound::function_c954e9a2();
    
    foreach ( ai_in_scene in a_ents )
    {
        if ( isdefined( ai_in_scene ) )
        {
            if ( ai_in_scene.archetype === "robot" )
            {
                if ( ai_in_scene.animname === "standdown_robot01" )
                {
                    ai_in_scene ai::set_behavior_attribute( "rogue_control", "forced_level_2" );
                    ai_in_scene util::magic_bullet_shield();
                    continue;
                }
                
                ai_in_scene ai::set_behavior_attribute( "rogue_control", "forced_level_2" );
            }
        }
    }
    
    var_3a462080 = a_ents[ "standdown_robot02" ];
    var_60489ae9 = a_ents[ "standdown_robot03" ];
    
    if ( isalive( var_3a462080 ) )
    {
        var_3a462080.nocybercom = 0;
    }
    
    if ( isalive( var_60489ae9 ) )
    {
        var_60489ae9.nocybercom = 0;
    }
    
    a_actors = array( level.ai_hendricks, a_ents[ "standdown_robot01" ] );
    s_scene = struct::get( "cin_hendricks_beheads_robot_00" );
    s_scene.origin = a_ents[ "standdown_robot01" ].origin;
    s_scene.angles = a_ents[ "standdown_robot01" ].angles + ( 0, -7, 0 );
    level thread scene::play( "cin_hendricks_beheads_robot_00", "targetname", a_actors );
    wait 2;
    
    foreach ( ai_in_scene in a_ents )
    {
        if ( isdefined( ai_in_scene ) )
        {
            ai_in_scene ai::set_ignoreall( 0 );
        }
    }
    
    if ( isalive( var_60489ae9 ) )
    {
        level.ai_hendricks setignoreent( var_60489ae9, 1 );
        var_60489ae9 setignoreent( level.ai_hendricks, 1 );
    }
    
    wait 3;
    
    if ( isalive( var_60489ae9 ) )
    {
        var_60489ae9 ai::set_ignoreme( 0 );
        var_60489ae9 setignoreent( level.ai_hendricks, 0 );
    }
    
    wait_for_standdown_robos_deaths();
    function_d8fb6400();
}

// Namespace lotus_pursuit
// Params 0
// Checksum 0x9fbc9dde, Offset: 0x1eb0
// Size: 0x42
function remove_prometheus_window_clip()
{
    e_prometheus_window = getent( "prometheus_window", "targetname" );
    
    if ( isdefined( e_prometheus_window ) )
    {
        e_prometheus_window delete();
    }
}

// Namespace lotus_pursuit
// Params 4
// Checksum 0xb11b24f3, Offset: 0x1f00
// Size: 0xba
function stand_down_done( str_objective, b_starting, b_direct, player )
{
    if ( b_starting )
    {
        objectives::complete( "cp_level_lotus_stand_down_door" );
    }
    
    var_f223b5db = getent( "trig_bb_pursuit_out_of_bounds", "targetname" );
    
    if ( isdefined( var_f223b5db ) )
    {
        var_f223b5db delete();
    }
    
    var_c330bf06 = getent( "clip_bb_pursuit_out_of_bounds", "targetname" );
    
    if ( isdefined( var_c330bf06 ) )
    {
        var_c330bf06 delete();
    }
}

// Namespace lotus_pursuit
// Params 1
// Checksum 0xc7ec1616, Offset: 0x1fc8
// Size: 0x6a
function function_623dfa9f( var_38465df1 )
{
    if ( !isdefined( var_38465df1 ) )
    {
        var_38465df1 = 0;
    }
    
    self ai::set_ignoreall( 1 );
    self.nocybercom = 1;
    self ai::set_behavior_attribute( "rogue_allow_pregib", 0 );
    
    if ( var_38465df1 )
    {
        self ai::set_behavior_attribute( "rogue_control", "forced_level_1" );
    }
}

// Namespace lotus_pursuit
// Params 2
// Checksum 0x38253a48, Offset: 0x2040
// Size: 0x592
function main( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        level.ai_hendricks = util::get_hero( "hendricks" );
        level.ai_hendricks.allowbattlechatter[ "bc" ] = 0;
        skipto::teleport_ai( str_objective );
        level.ai_hendricks.goalradius = 64;
        level thread scene::play( "pursuit_initial_bodies" );
        util::set_streamer_hint( 2, 1 );
        var_331a6d52 = getent( "standdown_door_far_lt", "targetname" );
        var_fbdd5570 = getent( "standdown_door_far_rt", "targetname" );
        var_331a6d52 moveto( var_331a6d52.origin - ( 300, 0, 0 ), 1, 0.1, 0.1 );
        var_fbdd5570 moveto( var_fbdd5570.origin + ( 300, 0, 0 ), 1, 0.1, 0.1 );
        scene::add_scene_func( "cin_lot_08_01_standdown_sh230", &function_1faa71ce );
        scene::add_scene_func( "cin_lot_08_01_standdown_sh270", &function_6a59f8cb );
        scene::add_scene_func( "cin_lot_08_01_standdown_sh280", &function_e26078a4, "done" );
        scene::add_scene_func( "cin_gen_hendricksmoment_riphead_robot", &function_b58d1d50 );
        spawner::add_spawn_function_ai_group( "standdown_robos", &function_623dfa9f, 1 );
        level.ai_hendricks ai::set_ignoreall( 1 );
        load::function_a2995f22();
        level thread function_4869f17d();
        level thread scene::play( "cin_lot_08_01_standdown_sh230" );
        remove_prometheus_window_clip();
        level thread lotus_util::function_14be4cad( 1 );
        util::clear_streamer_hint();
        level lotus_util::function_484bc3aa( 1 );
        level thread lotus2_sound::function_c954e9a2();
    }
    
    level.ai_hendricks ai::set_behavior_attribute( "coverIdleOnly", 0 );
    level thread lotus_util::its_raining_men();
    level thread function_3bb6dd7c();
    getent( "pursuit_oob", "targetname" ) triggerenable( 1 );
    level.ai_hendricks ai::set_behavior_attribute( "cqb", 1 );
    level thread function_742bcaff();
    
    if ( !flag::exists( "prometheus_spawned" ) )
    {
        flag::init( "prometheus_spawned" );
    }
    
    lotus_util::spawn_funcs_generic_rogue_control();
    spawner::add_spawn_function_group( "pursuit_robot_level_2_a", "script_noteworthy", &function_89bac1be, 0 );
    spawner::add_spawn_function_group( "pursuit_robot_level_2_b", "script_noteworthy", &function_89bac1be, 1 );
    spawner::add_spawn_function_group( "pursuit_robot_level_2_b", "script_noteworthy", &pursuit_set_b_logic );
    spawner::add_spawn_function_group( "pursuit_robot_ambient", "script_noteworthy", &pursuit_ambient_robot );
    spawner::add_spawn_function_group( "pursuit_human_ambient", "script_noteworthy", &function_b6be1e52 );
    spawner::add_spawn_function_group( "pursuit_human_b", "script_noteworthy", &pursuit_set_b_logic );
    mdl_clip = getent( "pursuit_wall_clip", "targetname" );
    mdl_clip moveto( mdl_clip.origin + ( 0, 0, -192 ), 2 );
    level flag::wait_till( "flag_delete_pursuit_wall_clip" );
    mdl_clip delete();
    level thread function_dfd4fce3();
    trigger::wait_till( "pursuit_done" );
    skipto::objective_completed( "pursuit" );
}

// Namespace lotus_pursuit
// Params 0
// Checksum 0x87702e62, Offset: 0x25e0
// Size: 0x23b
function function_3bb6dd7c()
{
    trigger::wait_till( "trig_snow_fog_begin_pursuit" );
    
    if ( isdefined( level.bzm_lotusdialogue14callback ) )
    {
        level thread [[ level.bzm_lotusdialogue14callback ]]();
    }
    
    exploder::exploder( "fx_interior_snow_1" );
    level scene::remove_scene_func( "cin_gen_traversal_raven_fly_away", &lotus_util::function_e547724d, "init" );
    level scene::remove_scene_func( "cin_gen_traversal_raven_fly_away", &lotus_util::function_86b1cd8a );
    level thread lotus_util::function_cf37ec3();
    var_222d6912 = getentarray( "lotus_snow_pile", "targetname" );
    
    foreach ( mdl_pile in var_222d6912 )
    {
        mdl_pile movez( 72, 15 );
    }
    
    lotus_util::function_78805698( "pursuit" );
    trigger::wait_till( "trig_snow_fog_end_pursuit" );
    
    foreach ( player in level.players )
    {
        player clientfield::increment_to_player( "hide_pursuit_decals" );
    }
    
    foreach ( mdl_pile in var_222d6912 )
    {
        mdl_pile delete();
    }
}

// Namespace lotus_pursuit
// Params 0
// Checksum 0x9075b247, Offset: 0x2828
// Size: 0x71
function function_dfd4fce3()
{
    level endon( #"hash_b2f27e0e" );
    e_fan = getent( "ceiling_fan", "targetname" );
    
    while ( isdefined( e_fan ) )
    {
        e_fan rotateto( e_fan.angles + ( 0, -180, 0 ), 3 );
        e_fan waittill( #"rotatedone" );
    }
}

// Namespace lotus_pursuit
// Params 0
// Checksum 0x45bcd5d4, Offset: 0x28a8
// Size: 0xa1
function function_742bcaff()
{
    self endon( #"pursuit_done" );
    e_fan = getent( "wall_run_ventilation_fan", "targetname" );
    assert( isdefined( e_fan ), "<dev string:x28>" );
    e_fan setscale( e_fan.script_int );
    
    while ( true )
    {
        e_fan rotateto( e_fan.angles + ( 180, 0, 0 ), 3 );
        wait 3;
    }
}

// Namespace lotus_pursuit
// Params 1
// Checksum 0x41115841, Offset: 0x2958
// Size: 0x5a
function function_1faa71ce( a_ents )
{
    if ( !scene::is_skipping_in_progress() )
    {
        dialog::remote( "kane_robots_compromised_0", 0.5 );
        level.ai_hendricks dialog::say( "hend_they_re_gonna_detona_0", 1 );
    }
}

// Namespace lotus_pursuit
// Params 0
// Checksum 0xa1072fae, Offset: 0x29c0
// Size: 0x9b
function function_b5ca2beb()
{
    var_222d6912 = getentarray( "lotus_snow_pile", "targetname" );
    
    foreach ( mdl_pile in var_222d6912 )
    {
        mdl_pile movez( 72, 15 );
    }
}

// Namespace lotus_pursuit
// Params 0
// Checksum 0xed4fce48, Offset: 0x2a68
// Size: 0x3a
function function_6678da67()
{
    battlechatter::function_d9f49fba( 1 );
    flag::wait_till( "lotus_snow_stop" );
    battlechatter::function_d9f49fba( 0 );
}

// Namespace lotus_pursuit
// Params 0
// Checksum 0x30eaa264, Offset: 0x2ab0
// Size: 0x1b2
function function_d8fb6400()
{
    level dialog::remote( "kane_nrc_robotics_have_go_0", 0.25 );
    level dialog::player_say( "plyr_how_can_he_be_doing_0", 1 );
    wait 0.25;
    level flag::wait_till( "flag_player_crossing_bridge" );
    level.ai_hendricks dialog::say( "hend_where_the_hell_does_0" );
    level dialog::remote( "tayr_you_know_what_you_sa_0", 1 );
    level dialog::player_say( "plyr_where_where_are_we_0", 0.5 );
    wait 0.5;
    level flag::wait_till_any_timeout( 5, array( "in_a_frozen_forest" ) );
    level dialog::remote( "tayr_imagine_yourself_in_0" );
    level dialog::player_say( "plyr_taylor_this_isn_t_0", 1 );
    level flag::wait_till( "lotus_snow_stop" );
    level thread lui::prime_movie( "cp_lotus2_pip_skybridgedispatch" );
    level dialog::player_say( "plyr_kane_where_is_he_0", 1 );
    level thread lui::play_movie( "cp_lotus2_pip_skybridgedispatch", "pip" );
    objectives::set( "cp_level_lotus_go_to_skybridge" );
    level dialog::remote( "kane_target_spotted_cro_0", 0.5 );
}

// Namespace lotus_pursuit
// Params 1
// Checksum 0x4cb18575, Offset: 0x2c70
// Size: 0x82
function function_89bac1be( b_sprint )
{
    if ( !isdefined( b_sprint ) )
    {
        b_sprint = 0;
    }
    
    self endon( #"death" );
    self.overrideactordamage = &function_5a616058;
    self.goalradius = 512;
    
    if ( b_sprint )
    {
        self ai::set_behavior_attribute( "rogue_control_speed", "sprint" );
    }
    
    self ai::set_behavior_attribute( "rogue_control", "level_2" );
}

// Namespace lotus_pursuit
// Params 0
// Checksum 0xa7b2add0, Offset: 0x2d00
// Size: 0x3a
function function_b6be1e52()
{
    self endon( #"death" );
    self setnormalhealth( 0.5 );
    self ai::set_behavior_attribute( "can_initiateaivsaimelee", 0 );
}

// Namespace lotus_pursuit
// Params 0
// Checksum 0xaef6f701, Offset: 0x2d48
// Size: 0xf2
function pursuit_ambient_robot()
{
    self endon( #"death" );
    self.overrideactordamage = &function_9e5ba8ea;
    self ai::set_behavior_attribute( "can_initiateaivsaimelee", 1 );
    self ai::set_behavior_attribute( "rogue_control", "forced_level_2" );
    spawner::waittill_ai_group_cleared( "pursuit_human_ambient" );
    nd_destination = getnode( self.target, "targetname" );
    self ai::set_behavior_attribute( "rogue_control_force_goal", nd_destination.origin );
    self ai::set_ignoreall( 1 );
    self ai::set_ignoreme( 1 );
    self waittill( #"goal" );
    self delete();
}

// Namespace lotus_pursuit
// Params 0
// Checksum 0xb20876df, Offset: 0x2e48
// Size: 0x72
function pursuit_set_b_logic()
{
    self endon( #"death" );
    
    if ( self.archetype == "human" )
    {
        self ai::set_behavior_attribute( "can_initiateaivsaimelee", 0 );
    }
    
    level flag::wait_till( "end_set_b_fight" );
    
    if ( !isdefined( self.b_in_animation ) )
    {
        self.b_end_fight = 1;
        self cleargoalvolume();
    }
}

// Namespace lotus_pursuit
// Params 12
// Checksum 0xe2289ab9, Offset: 0x2ec8
// Size: 0xab
function pursuit_set_b_damage_override( e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, n_model_index, psoffsettime, str_bone_name )
{
    if ( self.b_end_fight === 1 && self.archetype == "human" )
    {
        n_damage = self.health;
    }
    else if ( !isplayer( e_attacker ) )
    {
        n_damage = 0;
    }
    
    return n_damage;
}

// Namespace lotus_pursuit
// Params 12
// Checksum 0x7622141f, Offset: 0x2f80
// Size: 0x7b
function function_9e5ba8ea( e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, n_model_index, psoffsettime, str_bone_name )
{
    if ( !isplayer( e_attacker ) )
    {
        n_damage = 0;
    }
    
    return n_damage;
}

// Namespace lotus_pursuit
// Params 12
// Checksum 0x7336b919, Offset: 0x3008
// Size: 0x87
function function_5a616058( e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, n_model_index, psoffsettime, str_bone_name )
{
    if ( !isplayer( e_attacker ) && e_attacker !== level.ai_hendricks )
    {
        n_damage = 0;
    }
    
    return n_damage;
}

// Namespace lotus_pursuit
// Params 0
// Checksum 0xcd39cb6e, Offset: 0x3098
// Size: 0x44a
function function_4869f17d()
{
    if ( sessionmodeiscampaignzombiesgame() )
    {
        spawn_manager::enable( "pursuit_upstairs_robots_spawn_manager" );
        return;
    }
    
    level waittill( #"hash_90c52573" );
    level thread lotus_util::function_df89b05b( "pursuit_choke_throw_00", "forced_level_2", "do_pursuit_choke_throw_00", undefined, "pursuit_done" );
    level thread function_80f43be0();
    level thread lotus_util::function_df89b05b( "pursuit_rvh_init_01", "forced_level_2", "nearside_rvh_go", randomfloatrange( 1, 2 ), "pursuit_done" );
    wait 0.25;
    level thread lotus_util::function_df89b05b( "pursuit_rvh_init_02", "forced_level_2", "nearside_rvh_go", randomfloatrange( 2, 3 ), "pursuit_done" );
    level thread lotus_util::function_df89b05b( "cin_rvh_smashface", "forced_level_2", "nearside_rvh_go", 2, "pursuit_done" );
    
    if ( level.players.size > 2 )
    {
        level thread lotus_util::function_df89b05b( "pursuit_rvh_init_03", "forced_level_1", "nearside_rvh_go", randomfloatrange( 3, 4 ), "pursuit_done" );
        wait 0.25;
    }
    
    level thread lotus_util::function_df89b05b( "pursuit_rvh_init_04", "forced_level_1", "nearside_rvh_go", randomfloatrange( 4, 5 ), "pursuit_done" );
    wait 0.25;
    level thread lotus_util::function_df89b05b( "pursuit_rvh_init_05", "forced_level_1", "nearside_rvh_go", randomfloatrange( 5, 6 ), "pursuit_done" );
    wait 0.25;
    level thread lotus_util::function_df89b05b( "pursuit_rvh_init_06", "forced_level_1", "farside_rvh_go", randomfloatrange( 1, 2 ), "pursuit_done" );
    wait 0.25;
    level thread lotus_util::function_df89b05b( "pursuit_rvh_init_07", "forced_level_2", "farside_rvh_go", randomfloatrange( 2, 3 ), "pursuit_done" );
    flag::wait_till( "play_farside_overthrow" );
    ai_robot = spawner::simple_spawn_single( "pursuit_overthrow_1b_robot", &function_89bac1be, 1 );
    level thread lotus_util::function_c92cb5b( "cin_death_by_robot_throw01", "pursuit_overthrow_1b_robot", "pursuit_human_b" );
    level thread lotus_util::function_df89b05b( "lotus_snow_rvh_01", "forced_level_2", "do_lotus_snow_vignettes", 0, "pursuit_done" );
    wait 0.25;
    
    if ( level.players.size > 2 )
    {
        level thread lotus_util::function_df89b05b( "lotus_snow_rvh_02", "forced_level_2", "do_lotus_snow_vignettes", 4, "pursuit_done" );
    }
    
    wait 0.25;
    level thread lotus_util::function_df89b05b( "cin_rvh_facesmash_02", "forced_level_3", "lotus_snow_rvh_go", 0.5, "pursuit_done" );
    level thread lotus_util::function_df89b05b( "cin_rvh_uppercut", "forced_level_1", "cin_rvh_uppercut_go", 1, "pursuit_done" );
    level flag::wait_till( "do_lotus_snow_vignettes" );
    wait 5;
    spawn_manager::enable( "pursuit_upstairs_robots_spawn_manager" );
    level thread lotus_util::function_df89b05b( "pursuit_choke_throw_stairs", "forced_level_1", "lotus_snow_2", 1 );
}

// Namespace lotus_pursuit
// Params 0
// Checksum 0x6ae84d34, Offset: 0x34f0
// Size: 0x32
function function_ae2d3f70()
{
    flag::wait_till( "do_first_vignette" );
    spawn_manager::enable( "sm_pursuit_interference_robots" );
}

// Namespace lotus_pursuit
// Params 0
// Checksum 0xa1821d70, Offset: 0x3530
// Size: 0x14a
function function_80f43be0()
{
    level flag::wait_till( "do_first_vignette" );
    ai_human = spawner::simple_spawn_single( "pursuit_overthrow_01_human" );
    ai_human ai::set_ignoreme( 1 );
    ai_human setgoal( ai_human.origin, 1 );
    ai_human.health = -6;
    ai_robot = spawner::simple_spawn_single( "pursuit_overthrow_01_robot_sky", &function_89bac1be, 1 );
    ai_robot ai::set_ignoreme( 1 );
    ai_robot ai::set_ignoreall( 1 );
    level lotus_util::function_c92cb5b( "cin_death_by_robot_throw00", "pursuit_overthrow_01_robot_sky", "pursuit_overthrow_01_human" );
    
    if ( isalive( ai_robot ) )
    {
        var_fc02d77b = arraygetclosest( ai_robot.origin, level.players );
        ai_robot settargetentity( var_fc02d77b );
    }
}

// Namespace lotus_pursuit
// Params 4
// Checksum 0xc3e223ae, Offset: 0x3688
// Size: 0x5b
function pursuit_done( str_objective, b_starting, b_direct, player )
{
    if ( b_starting )
    {
        objectives::set( "cp_level_lotus_go_to_skybridge" );
    }
    
    lotus_util::function_3b6587d6( 0, "lotus1_industrial_zone_umbra_gate" );
    level notify( #"raining_men" );
}

