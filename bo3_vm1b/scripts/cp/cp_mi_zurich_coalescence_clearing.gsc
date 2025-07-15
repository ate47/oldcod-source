#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_zurich_coalescence_outro;
#using scripts/cp/cp_mi_zurich_coalescence_sound;
#using scripts/cp/cp_mi_zurich_coalescence_util;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai/archetype_locomotion_utility;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/player_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace zurich_clearing;

// Namespace zurich_clearing
// Params 0
// Checksum 0x8e5f350, Offset: 0xc20
// Size: 0xdb
function main()
{
    init_clientfields();
    scene::add_scene_func( "cin_zur_10_01_kruger_3rd_questioned_sh010", &function_7685bfc5, "play" );
    scene::add_scene_func( "cin_zur_10_01_kruger_3rd_questioned_sh010", &function_8eb661fa, "skip_started" );
    scene::add_scene_func( "p7_fxanim_cp_zurich_rock_slide_bundle", &zurich_util::function_9f90bc0f, "done", "clearing_path_selected" );
    level._effect[ "krueger_body_fx" ] = "player/fx_ai_marker_body_kreuger";
    level._effect[ "krueger_beam_fx" ] = "light/fx_beam_marker_kreuger";
}

// Namespace zurich_clearing
// Params 0
// Checksum 0xbe9f9816, Offset: 0xd08
// Size: 0x9a
function init_clientfields()
{
    var_c0e9f8c3 = getminbitcountfornum( 5 );
    clientfield::register( "world", "zurich_waterfall_bodies", 1, 1, "int" );
    clientfield::register( "world", "clearing_vinewall_init", 1, var_c0e9f8c3, "int" );
    clientfield::register( "world", "clearing_vinewall_open", 1, var_c0e9f8c3, "int" );
}

// Namespace zurich_clearing
// Params 2
// Checksum 0x12700e8b, Offset: 0xdb0
// Size: 0x142
function skipto_start( str_objective, b_starting )
{
    level zurich_util::enable_surreal_ai_fx( 1, 0.5 );
    spawner::add_spawn_function_group( "raven_enemies_clearing_start", "script_aigroup", &function_a1a182e );
    level flag::wait_till( "all_players_spawned" );
    skipto::teleport_players( str_objective, 0 );
    array::thread_all( level.activeplayers, &util::player_frost_breath, 1 );
    level zurich_util::player_weather( 1, "reverse_snow" );
    
    if ( b_starting )
    {
        util::set_streamer_hint( 3 );
        level util::screen_fade_out( 0, "white" );
    }
    
    level clientfield::set( "zurich_waterfall_bodies", 1 );
    level clientfield::set( "clearing_vinewall_init", 5 );
    level thread function_a3f52108( str_objective );
    level thread namespace_67110270::function_82e83534();
}

// Namespace zurich_clearing
// Params 4
// Checksum 0x6ab3c7d3, Offset: 0xf00
// Size: 0x22
function skipto_start_done( str_objective, b_starting, b_direct, player )
{
    
}

// Namespace zurich_clearing
// Params 1
// Checksum 0x67f06c2b, Offset: 0xf30
// Size: 0x92
function function_a3f52108( str_objective )
{
    array::thread_all( level.players, &function_32cf3cd );
    var_4ccf970 = thread zurich_util::function_a00fa665( str_objective );
    level thread function_e8e4006f();
    level thread function_8727b592();
    level thread function_6a2abd6d();
    level flag::set( "flag_clearing_start" );
}

// Namespace zurich_clearing
// Params 0
// Checksum 0x9e7743dc, Offset: 0xfd0
// Size: 0x3a
function function_a1a182e()
{
    self.var_5e7a3967 = 1;
    self setgoalvolume( getent( "clearing_start_defend_volume", "targetname" ) );
}

// Namespace zurich_clearing
// Params 0
// Checksum 0x9fdb88b3, Offset: 0x1018
// Size: 0x5a
function function_6a2abd6d()
{
    trigger::wait_till( "trig_clearing_enemy_cleanup" );
    array::run_all( getaiarray( "clearing_start_enemies", "script_noteworthy" ), &delete );
}

// Namespace zurich_clearing
// Params 0
// Checksum 0x25141de3, Offset: 0x1080
// Size: 0x6a
function function_8727b592()
{
    level endon( #"hash_c83e0fe0" );
    spawn_manager::wait_till_cleared( "sm_clearing_enemy_spawn" );
    objectives::breadcrumb( "clearing_start_breadcrumb_trig" );
    spawn_manager::wait_till_cleared( "sm_clearing_hill" );
    objectives::breadcrumb( "clearing_hill_breadcrumb_trig" );
}

// Namespace zurich_clearing
// Params 0
// Checksum 0x1bc1d6b7, Offset: 0x10f8
// Size: 0x112
function function_e8e4006f()
{
    scene::add_scene_func( "cin_zur_09_02_standoff_1st_forest", &function_5b75f492, "done" );
    scene::add_scene_func( "cin_zur_09_02_standoff_1st_forest", &function_cf93f22a, "play" );
    level scene::init( "cin_zur_09_02_standoff_1st_forest" );
    scene::add_scene_func( "p7_fxanim_cp_zurich_tree_krueger_split_rt_bundle", &function_7d18154f, "init" );
    level scene::init( "p7_fxanim_cp_zurich_tree_krueger_split_rt_bundle" );
    wait 3;
    level thread util::screen_fade_in( 2, "white" );
    
    if ( isdefined( level.bzm_zurichdialogue4callback ) )
    {
        level thread [[ level.bzm_zurichdialogue4callback ]]();
    }
    
    level thread scene::play( "cin_zur_09_02_standoff_1st_forest" );
}

// Namespace zurich_clearing
// Params 1
// Checksum 0xdb595203, Offset: 0x1218
// Size: 0x122
function function_cf93f22a( a_ents )
{
    self thread function_4ac14422( a_ents );
    a_ents[ "corvus" ] ghost();
    a_ents[ "corvus" ] waittill( #"hash_be812a65" );
    a_ents[ "corvus" ] clientfield::set( "raven_ai_rez", 1 );
    wait 0.5;
    a_ents[ "corvus" ] show();
    a_ents[ "corvus" ] clientfield::set( "corvus_body_fx", 1 );
    a_ents[ "corvus" ] waittill( #"hash_4cfd02d9" );
    a_ents[ "corvus" ] clientfield::set( "raven_ai_rez", 0 );
    a_ents[ "corvus" ] clientfield::set( "corvus_body_fx", 0 );
    a_ents[ "corvus" ] ghost();
}

// Namespace zurich_clearing
// Params 0
// Checksum 0x60737d23, Offset: 0x1348
// Size: 0x15a
function function_44dc9752()
{
    scene::add_scene_func( "cin_zur_09_02_standoff_3rd_forest_part2_sh010", &function_eb4d9424, "play" );
    scene::add_scene_func( "cin_zur_09_02_standoff_3rd_forest_part2_sh010", &zurich_util::function_f3e247d6, "init" );
    level scene::init( "p7_fxanim_cp_zurich_rock_slide_bundle" );
    t_waterfall = trigger::wait_till( "t_waterfall_igc" );
    
    if ( isdefined( level.bzm_zurichdialogue4_1callback ) )
    {
        level thread [[ level.bzm_zurichdialogue4_1callback ]]();
    }
    
    level scene::play( "cin_zur_09_02_standoff_3rd_forest_part2_sh010", t_waterfall.who );
    level util::teleport_players_igc( "clearing_waterfall_igc_end" );
    util::clear_streamer_hint();
    util::set_streamer_hint( 5 );
    level waittill( #"hash_4e38f7bd" );
    scene::add_scene_func( "cin_zur_10_01_kruger_3rd_questioned_sh010", &zurich_util::function_f3e247d6, "init" );
    level scene::init( "cin_zur_10_01_kruger_3rd_questioned_sh010" );
}

// Namespace zurich_clearing
// Params 1
// Checksum 0x5b50e4dc, Offset: 0x14b0
// Size: 0x82
function function_eb4d9424( a_ents )
{
    var_f91fd6fe = a_ents[ "kruger" ];
    var_f91fd6fe waittill( #"hash_b172f51e" );
    playfxontag( level._effect[ "krueger_body_fx" ], var_f91fd6fe, "j_spine4" );
    level waittill( #"hash_89688662" );
    playfxontag( level._effect[ "krueger_beam_fx" ], var_f91fd6fe, "tag_origin" );
}

// Namespace zurich_clearing
// Params 1
// Checksum 0xc3ae8af4, Offset: 0x1540
// Size: 0xeb
function function_5b75f492( a_ents )
{
    level util::teleport_players_igc( "clearing_start_intro_end" );
    util::clear_streamer_hint();
    savegame::checkpoint_save();
    level scene::init( "cin_zur_09_02_standoff_3rd_forest_part2_sh010" );
    level thread function_e0b4badc();
    level thread function_44dc9752();
    util::wait_network_frame();
    
    foreach ( player in level.players )
    {
        player player::switch_to_primary_weapon( 1 );
    }
}

// Namespace zurich_clearing
// Params 0
// Checksum 0x3cf240be, Offset: 0x1638
// Size: 0x8a
function function_e0b4badc()
{
    spawn_manager::enable( "sm_clearing_enemy_spawn" );
    spawn_manager::wait_till_complete( "sm_clearing_enemy_spawn" );
    level scene::play( "cin_zur_09_01_standoff_vign_charge", spawn_manager::get_ai( "sm_clearing_enemy_spawn" ) );
    spawn_manager::wait_till_cleared( "sm_clearing_enemy_spawn" );
    savegame::checkpoint_save();
}

// Namespace zurich_clearing
// Params 0
// Checksum 0x381fa268, Offset: 0x16d0
// Size: 0x9b
function function_32cf3cd()
{
    a_w_weapons = self getweaponslist();
    
    foreach ( w_weapon in a_w_weapons )
    {
        self givemaxammo( w_weapon );
        self setweaponammoclip( w_weapon, w_weapon.clipsize );
    }
}

// Namespace zurich_clearing
// Params 2
// Checksum 0xaadfab46, Offset: 0x1778
// Size: 0x212
function skipto_waterfall( str_objective, b_starting )
{
    spawner::add_spawn_function_group( "spawn_manager_waterfall_guy", "targetname", &function_2afd205d );
    
    if ( b_starting )
    {
        load::function_73adcefc();
        level scene::init( "cin_zur_09_02_standoff_3rd_forest_part2_sh010" );
        zurich_util::enable_surreal_ai_fx( 1, 0.5 );
        var_4ccf970 = zurich_util::function_a00fa665( "clearing_start" );
        level zurich_util::player_weather( 1, "reverse_snow" );
        level thread function_6a2abd6d();
        level clientfield::set( "zurich_waterfall_bodies", 1 );
        level clientfield::set( "clearing_vinewall_init", 5 );
        level scene::init( "p7_fxanim_cp_zurich_rock_slide_bundle" );
        scene::add_scene_func( "p7_fxanim_cp_zurich_tree_krueger_split_rt_bundle", &function_7d18154f, "init" );
        level scene::init( "p7_fxanim_cp_zurich_tree_krueger_split_rt_bundle" );
        load::function_a2995f22();
        skipto::teleport_players( str_objective, 0 );
        array::thread_all( level.activeplayers, &util::player_frost_breath, 1 );
        level function_44dc9752();
    }
    
    level thread function_83fcefa6();
    array::thread_all( level.activeplayers, &zurich_util::function_39af75ef, "clearing_path_selected" );
    level thread function_6c92c263( 1 );
}

// Namespace zurich_clearing
// Params 4
// Checksum 0x149024eb, Offset: 0x1998
// Size: 0x22
function skipto_waterfall_done( str_objective, b_starting, b_direct, player )
{
    
}

// Namespace zurich_clearing
// Params 0
// Checksum 0x82d8334a, Offset: 0x19c8
// Size: 0x10a
function function_83fcefa6()
{
    array::run_all( level.activeplayers, &playrumbleonentity, "cp_infection_hideout_stretch" );
    playsoundatposition( "evt_waterfall_rumble", ( 0, 0, 0 ) );
    objectives::breadcrumb( "trig_clearing_waterfall_breadcrumb" );
    trigger::wait_till( "trig_clearing_waterfall_breadcrumb" );
    
    if ( isdefined( level.bzm_zurichdialogue6callback ) )
    {
        level thread [[ level.bzm_zurichdialogue6callback ]]();
    }
    
    level thread scene::play( "p7_fxanim_cp_zurich_rock_slide_bundle" );
    objectives::breadcrumb( "trig_clearing_waterfall_pool_breadcrumb" );
    trigger::wait_till( "trig_clearing_waterfall_pool_breadcrumb" );
    savegame::checkpoint_save();
    level thread function_cd8360f3();
    level thread function_eae5713();
}

// Namespace zurich_clearing
// Params 0
// Checksum 0xd387aa9b, Offset: 0x1ae0
// Size: 0x62
function function_cd8360f3()
{
    spawn_manager::enable( "spawn_manager_waterfall_enemies" );
    spawn_manager::wait_till_cleared( "spawn_manager_waterfall_enemies" );
    
    if ( isdefined( level.bzmutil_waitforallzombiestodie ) )
    {
        [[ level.bzmutil_waitforallzombiestodie ]]();
    }
    
    level flag::set( "flag_enable_waterfall_vine_burn" );
}

// Namespace zurich_clearing
// Params 0
// Checksum 0x8a806ee1, Offset: 0x1b50
// Size: 0x32
function function_2afd205d()
{
    self setgoalvolume( getent( "waterfall_defend_volume", "targetname" ) );
}

// Namespace zurich_clearing
// Params 2
// Checksum 0xe30f3631, Offset: 0x1b90
// Size: 0x1aa
function skipto_path_choice( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        zurich_util::enable_surreal_ai_fx( 1, 0.5 );
        level thread zurich_util::function_11b424e5( 1 );
        var_4ccf970 = zurich_util::function_a00fa665( "clearing_start" );
        array::thread_all( level.activeplayers, &util::player_frost_breath, 1 );
        level zurich_util::player_weather( 1, "reverse_snow" );
        level clientfield::set( "zurich_waterfall_bodies", 1 );
        level clientfield::set( "clearing_vinewall_init", 5 );
        scene::add_scene_func( "cin_zur_10_01_kruger_3rd_questioned_sh010", &zurich_util::function_f3e247d6, "init" );
        level scene::init( "cin_zur_10_01_kruger_3rd_questioned_sh010" );
        level scene::init( "p7_fxanim_cp_zurich_tree_krueger_split_rt_bundle" );
        util::set_streamer_hint( 5 );
        load::function_a2995f22();
        skipto::teleport_players( str_objective, 0 );
        
        if ( isdefined( level.bzm_zurichdialogue7callback ) )
        {
            level thread [[ level.bzm_zurichdialogue7callback ]]();
        }
    }
    
    util::wait_network_frame();
    level thread function_eadc4ffc();
}

// Namespace zurich_clearing
// Params 0
// Checksum 0xe9db2e0a, Offset: 0x1d48
// Size: 0x1ba
function function_eadc4ffc()
{
    a_hostile_ai = getaiteamarray( "axis" );
    
    foreach ( ai in a_hostile_ai )
    {
        ai delete();
    }
    
    scene::add_scene_func( "cin_zur_11_01_paths_1st_still_chance", &function_36f7aa25, "play" );
    scene::add_scene_func( "cin_zur_11_01_paths_1st_still_chance", &function_bf68487, "done" );
    level.ai_taylor = util::get_hero( "taylor_hero" );
    level.ai_taylor ghost();
    level thread scene::init( "cin_zur_11_01_paths_1st_still_chance", level.ai_taylor );
    level thread namespace_67110270::function_71271388();
    level thread scene::play( "p7_fxanim_cp_zurich_tree_krueger_split_rt_bundle" );
    level scene::play( "cin_zur_10_01_kruger_3rd_questioned_sh010" );
    level thread function_6c92c263( 0 );
    level zurich_util::player_weather( 0 );
    wait 1;
    level zurich_util::player_weather( 1, "red_rain" );
}

// Namespace zurich_clearing
// Params 1
// Checksum 0x58b5875c, Offset: 0x1f10
// Size: 0x152
function function_7d18154f( a_ents )
{
    var_332eaff4 = a_ents[ "krueger_tree_lt" ];
    var_f069ba56 = a_ents[ "krueger_tree_rt" ];
    var_332eaff4 hidepart( "arm_lt_side_jnt" );
    var_332eaff4 hidepart( "arm_blood_fx_lt_jnt" );
    var_332eaff4 hidepart( "elbow_lt_side_jnt" );
    var_332eaff4 hidepart( "leg_lt_side_jnt" );
    var_332eaff4 hidepart( "knee_lt_side_jnt" );
    var_332eaff4 hidepart( "leg_blood_fx_lt_jnt" );
    var_f069ba56 hidepart( "arm_rt_side_jnt" );
    var_f069ba56 hidepart( "arm_blood_fx_rt_jnt" );
    var_f069ba56 hidepart( "elbow_rt_side_jnt" );
    var_f069ba56 hidepart( "leg_rt_side_jnt" );
    var_f069ba56 hidepart( "knee_rt_side_jnt" );
    var_f069ba56 hidepart( "leg_blood_fx_rt_jnt" );
}

// Namespace zurich_clearing
// Params 1
// Checksum 0xfb43c4fd, Offset: 0x2070
// Size: 0x3a
function function_7685bfc5( a_ents )
{
    var_c9b7e4eb = a_ents[ "krueger" ];
    level waittill( #"hash_4fa207a0" );
    var_c9b7e4eb ghost();
}

// Namespace zurich_clearing
// Params 1
// Checksum 0xa8856ce0, Offset: 0x20b8
// Size: 0x22
function function_8eb661fa( a_ents )
{
    level scene::stop( "p7_fxanim_cp_zurich_tree_krueger_split_rt_bundle" );
}

// Namespace zurich_clearing
// Params 1
// Checksum 0x963d1695, Offset: 0x20e8
// Size: 0x3a
function function_36f7aa25( a_ents )
{
    level.ai_taylor show();
    level.ai_taylor thread zurich_util::function_fe5160df( 1 );
}

// Namespace zurich_clearing
// Params 1
// Checksum 0xb64d5e0d, Offset: 0x2130
// Size: 0x5a
function function_bf68487( a_ents )
{
    level util::teleport_players_igc( "clearing_kruger_igc_exit" );
    util::clear_streamer_hint();
    savegame::checkpoint_save();
    level thread function_75ab0e6a( "clearing_hub" );
}

// Namespace zurich_clearing
// Params 0
// Checksum 0xaca8a79e, Offset: 0x2198
// Size: 0x153
function function_eae5713()
{
    scene::add_scene_func( "cin_zur_09_01_standoff_vign_far_as_i_go", &function_4ac14422, "play" );
    var_ce37baf2 = getent( "trig_waterfall_burn", "targetname" );
    var_9d50b546 = getent( "clip_burn_vine_01", "targetname" );
    var_ce37baf2 setinvisibletoall();
    level flag::wait_till( "flag_enable_waterfall_vine_burn" );
    var_ce37baf2 setvisibletoall();
    level thread function_51277233();
    var_ce37baf2 zurich_util::function_f3bcbbb1();
    
    if ( isdefined( level.bzm_zurichdialogue7callback ) )
    {
        level thread [[ level.bzm_zurichdialogue7callback ]]();
    }
    
    level scene::play( "cin_zur_09_01_standoff_vign_far_as_i_go", var_ce37baf2.e_player );
    level util::teleport_players_igc( "waterfall_vinewall_igc_end" );
    level thread zurich_util::function_11b424e5( 1 );
    var_9d50b546 notsolid();
    level notify( #"hash_87560491" );
}

// Namespace zurich_clearing
// Params 0
// Checksum 0x55dd7a8, Offset: 0x22f8
// Size: 0x22
function function_51277233()
{
    level waittill( #"hash_3f802798" );
    level clientfield::set( "clearing_vinewall_open", 1 );
}

// Namespace zurich_clearing
// Params 1
// Checksum 0xe51b05b3, Offset: 0x2328
// Size: 0xb2
function function_6c92c263( b_hide )
{
    var_ecf05dd0 = getent( "waterfall_vine_path_blocker", "targetname" );
    var_9d50b546 = getent( "clip_burn_vine_01", "targetname" );
    
    if ( b_hide )
    {
        var_ecf05dd0 hide();
        return;
    }
    
    var_ecf05dd0 show();
    level clientfield::set( "clearing_vinewall_init", 1 );
    var_9d50b546 solid();
}

// Namespace zurich_clearing
// Params 1
// Checksum 0xfbb75003, Offset: 0x23e8
// Size: 0xa2
function function_4ac14422( a_ents )
{
    var_2e3b8e7e = a_ents[ "hendricks" ];
    var_2e3b8e7e ghost();
    wait 1;
    var_2e3b8e7e clientfield::set( "raven_ai_rez", 1 );
    wait 0.5;
    var_2e3b8e7e show();
    var_2e3b8e7e waittill( #"hash_36dcb014" );
    var_2e3b8e7e clientfield::set( "raven_ai_rez", 0 );
    wait 0.5;
    var_2e3b8e7e ghost();
}

// Namespace zurich_clearing
// Params 2
// Checksum 0x29d4cd64, Offset: 0x2498
// Size: 0x23a
function function_75ab0e6a( str_objective, var_7c092e3a )
{
    if ( !isdefined( var_7c092e3a ) )
    {
        var_7c092e3a = 0;
    }
    
    level endon( #"clearing_path_selected" );
    s_start_pos = struct::get( str_objective + "_taylor_start", "targetname" );
    var_8a1e3703 = 0;
    
    if ( !isdefined( level.ai_taylor ) )
    {
        var_8a1e3703 = 1;
        level function_6aede49e( str_objective );
        level.ai_taylor forceteleport( s_start_pos.origin, s_start_pos.angles );
        level.ai_taylor ai::set_ignoreme( 1 );
        level.ai_taylor ai::set_ignoreall( 1 );
        level.ai_taylor ghost();
    }
    
    level.ai_taylor sethighdetail( 1 );
    level.ai_taylor thread function_aea8cd9b();
    
    if ( var_7c092e3a > 0 )
    {
        wait var_7c092e3a;
    }
    
    if ( isdefined( s_start_pos.target ) )
    {
        nd_goal = getnode( s_start_pos.target, "targetname" );
        level.ai_taylor ai::set_behavior_attribute( "forceTacticalWalk", 1 );
        level.ai_taylor ai::set_ignoreall( 1 );
        level.ai_taylor setgoal( nd_goal, 1 );
    }
    
    if ( var_8a1e3703 )
    {
        wait 1;
        level.ai_taylor clientfield::set( "hero_spawn_fx", 1 );
        wait 0.5;
        level.ai_taylor ai::set_ignoreme( 0 );
        level.ai_taylor ai::set_ignoreall( 0 );
        level.ai_taylor show();
    }
    
    wait 3;
    level.ai_taylor sethighdetail( 0 );
}

// Namespace zurich_clearing
// Params 1
// Checksum 0x580f5794, Offset: 0x26e0
// Size: 0x42
function function_6aede49e( str_objective )
{
    level.ai_taylor = util::get_hero( "taylor_hero" );
    level.ai_taylor thread zurich_util::function_fe5160df( 1 );
}

// Namespace zurich_clearing
// Params 0
// Checksum 0x7154d93d, Offset: 0x2730
// Size: 0x52
function function_aea8cd9b()
{
    level waittill( #"clearing_path_selected" );
    self clientfield::set( "hero_spawn_fx", 0 );
    wait 0.5;
    self util::unmake_hero( "taylor_hero" );
    self util::self_delete();
}

// Namespace zurich_clearing
// Params 0
// Checksum 0xcf644bf8, Offset: 0x2790
// Size: 0xba
function function_f1073c0f()
{
    level dialog::remote( "dcor_you_know_where_it_al_0", 1, "NO_DNI" );
    level dialog::remote( "dcor_when_we_trained_we_0", 1, "NO_DNI" );
    level dialog::remote( "dcor_they_put_a_big_fat_s_0", 1, "NO_DNI" );
    level dialog::remote( "dcor_how_could_we_know_wh_0", 1, "NO_DNI" );
    level flag::set( "flag_diaz_first_path_complete_vo_done" );
}

// Namespace zurich_clearing
// Params 0
// Checksum 0x732d13c3, Offset: 0x2858
// Size: 0x5a
function function_65667fec()
{
    wait 2;
    self dialog::say( "tayr_the_frozen_forest_wa_0", 1 );
    level dialog::remote( "hcor_this_isn_t_the_froze_0", 1, "NO_DNI" );
    savegame::checkpoint_save();
}

// Namespace zurich_clearing
// Params 2
// Checksum 0x419e7ffd, Offset: 0x28c0
// Size: 0x272
function function_1270c207( str_objective, b_starting )
{
    if ( str_objective == "clearing_hub_2" || str_objective == "clearing_hub_3" || b_starting )
    {
        load::function_73adcefc();
        level thread scene::skipto_end( "p7_fxanim_cp_zurich_tree_krueger_split_rt_bundle" );
        level clientfield::set( "zurich_waterfall_bodies", 1 );
        level clientfield::set( "clearing_vinewall_init", 5 );
        var_4ccf970 = zurich_util::function_a00fa665( str_objective );
        
        if ( !b_starting )
        {
            level.var_75ba074a = undefined;
        }
        
        load::function_a2995f22( isdefined( b_starting ) && b_starting ? 2 : 0 );
        skipto::teleport_players( str_objective, 0 );
        level zurich_util::player_weather( 1, "red_rain" );
        array::thread_all( level.activeplayers, &util::player_frost_breath, 1 );
        level thread zurich_util::function_11b424e5( 1 );
        
        if ( !b_starting )
        {
            wait 1;
            level util::streamer_wait();
            
            foreach ( player in level.players )
            {
                player.dont_show_hud = undefined;
                player util::delay( 0.3, undefined, &util::show_hud, 1 );
            }
            
            level thread util::screen_fade_in( 2, "black" );
        }
        
        level thread function_75ab0e6a( str_objective, level.var_75ba074a );
        
        if ( str_objective === "clearing_hub_2" )
        {
            level thread function_f1073c0f();
        }
        
        if ( str_objective === "clearing_hub_3" )
        {
            while ( !isdefined( level.ai_taylor ) )
            {
                util::wait_network_frame();
            }
            
            level.ai_taylor function_65667fec();
        }
    }
    
    level thread namespace_67110270::function_82e83534();
    level thread function_c998741b( str_objective );
}

// Namespace zurich_clearing
// Params 4
// Checksum 0xdc870431, Offset: 0x2b40
// Size: 0x4a
function function_44c2b6a( str_objective, b_starting, b_direct, player )
{
    level function_82fb3fff();
    level thread zurich_util::function_4a00a473( "clearing_hub" );
}

// Namespace zurich_clearing
// Params 4
// Checksum 0xf013d432, Offset: 0x2b98
// Size: 0x32
function function_600acf3f( str_objective, b_starting, b_direct, player )
{
    level function_82fb3fff();
}

// Namespace zurich_clearing
// Params 4
// Checksum 0x3dafd0bf, Offset: 0x2bd8
// Size: 0x4a
function function_b42e7a80( str_objective, b_starting, b_direct, player )
{
    level function_82fb3fff();
    level thread zurich_util::function_4a00a473( "clearing_hub_3" );
}

// Namespace zurich_clearing
// Params 0
// Checksum 0x20d19007, Offset: 0x2c30
// Size: 0x5a
function function_82fb3fff()
{
    level zurich_util::player_weather( 0 );
    level clientfield::set( "zurich_waterfall_bodies", 0 );
    level clientfield::set( "clearing_vinewall_init", 0 );
    level clientfield::set( "clearing_vinewall_open", 0 );
}

// Namespace zurich_clearing
// Params 1
// Checksum 0x8c513f0, Offset: 0x2c98
// Size: 0x38a
function function_c998741b( str_objective )
{
    var_89060212 = getentarray( "trig_vine_doors", "script_noteworthy" );
    array::run_all( var_89060212, &setinvisibletoall );
    
    switch ( str_objective )
    {
        case "clearing_hub":
            var_3e0e2df1 = "zurich";
            n_fxanim = 4;
            break;
        case "clearing_hub_2":
            var_3e0e2df1 = "cairo";
            n_fxanim = 3;
            break;
        default:
            var_3e0e2df1 = "sing";
            level clientfield::set( "clearing_hide_lotus_tower", 1 );
            n_fxanim = 2;
            break;
    }
    
    var_7edb74a6 = getent( "unburnable_vine_" + var_3e0e2df1, "targetname" );
    var_9d50b546 = getent( "clip_burn_vine_" + var_3e0e2df1, "targetname" );
    var_7edb74a6 hide();
    var_ce37baf2 = getent( "trig_vine_damage_" + var_3e0e2df1, "targetname" );
    var_ce37baf2 setvisibletoall();
    var_ce37baf2.var_afacae68 = 0;
    var_ce37baf2 function_860aaa8a( var_9d50b546 );
    array::thread_all( level.activeplayers, &util::freeze_player_controls, 1 );
    level clientfield::set( "clearing_vinewall_open", n_fxanim );
    wait 0.5;
    array::thread_all( level.players, &clientfield::increment_to_player, "postfx_transition" );
    playsoundatposition( "evt_clearing_trans_out", ( 0, 0, 0 ) );
    wait 1;
    level util::screen_fade_out( 1, "black" );
    
    foreach ( player in level.players )
    {
        player util::show_hud( 0 );
    }
    
    switch ( str_objective )
    {
        case "clearing_hub":
            level scene::init( "cin_zur_12_01_root_1st_mirror_01" );
            break;
        case "clearing_hub_2":
            level scene::init( "cin_zur_14_01_cairo_root_1st_fall" );
            break;
        default:
            util::set_streamer_hint( 8 );
            break;
    }
    
    level util::streamer_wait();
    array::thread_all( level.activeplayers, &util::freeze_player_controls, 0 );
    level thread zurich_util::function_11b424e5( 0 );
    level notify( #"clearing_path_selected" );
    skipto::objective_completed( str_objective );
    var_7edb74a6 show();
}

// Namespace zurich_clearing
// Params 1
// Checksum 0x604b43b9, Offset: 0x3030
// Size: 0x22
function function_860aaa8a( var_9d50b546 )
{
    self zurich_util::function_30a6b901( 0, var_9d50b546 );
    self.var_afacae68 = 1;
}

