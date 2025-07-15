#using scripts/codescripts/struct;
#using scripts/cp/_collectibles;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_infection2_sound;
#using scripts/cp/cp_mi_cairo_infection_accolades;
#using scripts/cp/cp_mi_cairo_infection_church;
#using scripts/cp/cp_mi_cairo_infection_util;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/cp/gametypes/coop;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;

#namespace village_surreal;

// Namespace village_surreal
// Params 0, eflags: 0x2
// Checksum 0x928ebd9b, Offset: 0x10a0
// Size: 0x2a
function autoexec __init__sytem__()
{
    system::register( "infection_village_surreal", &__init__, undefined, undefined );
}

// Namespace village_surreal
// Params 0
// Checksum 0x1457cd59, Offset: 0x10d8
// Size: 0x42
function __init__()
{
    setup_scene_callbacks();
    spawner::add_spawn_function_group( "sp_tiger_tank_fold", "targetname", &spawn_func_tiger_tank );
}

// Namespace village_surreal
// Params 0
// Checksum 0x21a685c9, Offset: 0x1128
// Size: 0x11a
function init_client_field_callback_funcs()
{
    clientfield::register( "world", "infection_fold_debris_1", 1, 1, "counter" );
    clientfield::register( "world", "infection_fold_debris_2", 1, 1, "int" );
    clientfield::register( "world", "infection_fold_debris_3", 1, 1, "int" );
    clientfield::register( "world", "infection_fold_debris_4", 1, 1, "int" );
    clientfield::register( "world", "light_church_ext_window", 1, 1, "int" );
    clientfield::register( "world", "light_church_int_all", 1, 1, "int" );
    clientfield::register( "world", "dynent_catcher", 1, 1, "int" );
}

// Namespace village_surreal
// Params 4
// Checksum 0xfd62762c, Offset: 0x1250
// Size: 0x2b
function cleanup( str_objective, b_starting, b_direct, player )
{
    level notify( #"end_salm_fold_dialog" );
}

// Namespace village_surreal
// Params 0
// Checksum 0xbad59ff0, Offset: 0x1288
// Size: 0x32
function function_a1dc825e()
{
    spawn_tank();
    setup_spawners();
    init_time_rewind_destruction();
}

// Namespace village_surreal
// Params 2
// Checksum 0xdd127332, Offset: 0x12c8
// Size: 0x442
function main( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        level util::set_streamer_hint( 11 );
        spawn_tank();
        setup_spawners();
        init_time_rewind_destruction();
        level thread scene::init( "cin_inf_11_02_fold_1st_airlock" );
    }
    
    infection_util::function_67137b13();
    collectibles::function_93523442( "p7_nc_cai_inf_06", 300, ( 0, 0, 0 ) );
    level.tank_activated = 0;
    level.church_mg_support_activated = 0;
    level thread monitor_t_bank_retreat();
    level thread monitor_t_foy_guys_0_and_1_retreat_2();
    level thread monitor_t_sm_fold_guys_4();
    level thread monitor_s_church_lookat();
    level thread monitor_t_church_lookat();
    level thread monitor_t_tank_retreat_1();
    level thread monitor_t_tank_retreat_2();
    level thread monitor_t_tank_retreat_3();
    level thread monitor_t_tank_retreat_4();
    level thread monitor_t_infection_fold_debris_2();
    level thread monitor_t_infection_fold_debris_3();
    level thread monitor_t_infection_fold_debris_4();
    level thread monitor_t_foy_guys_0_and_1_retreat();
    level thread monitor_t_cemetery_retreat();
    level thread infection_util::monitor_spawner_and_trigger_reinforcement( "sm_fold_guys_1", "sm_fold_guys_tank", "t_sm_fold_guys_1_reinforce", 5, 2 );
    altered_gravity_enable( 1 );
    church::init_church();
    
    if ( isdefined( level.bzm_infectiondialogue12callback ) )
    {
        level thread [[ level.bzm_infectiondialogue12callback ]]();
    }
    
    if ( !sessionmodeiscampaignzombiesgame() )
    {
        spawn_fold_turret_01();
        level thread monitor_t_fold_turret_01_enable();
    }
    
    level clientfield::set( "dynent_catcher", 1 );
    
    if ( b_starting )
    {
        load::function_a2995f22();
    }
    
    array::thread_all( level.players, &infection_util::player_enter_cinematic );
    level thread namespace_bed101ee::function_b00d2653();
    
    if ( !b_starting )
    {
        level.ai_sarah = util::get_hero( "sarah" );
        level.ai_sarah clientfield::set( "sarah_body_light", 0 );
    }
    else
    {
        objectives::set( "cp_level_infection_follow_sarah" );
    }
    
    level thread util::screen_fade_in( 2, "white", "foy_white" );
    level scene::play( "cin_inf_11_02_fold_1st_airlock" );
    level thread infection_util::function_3fe1f72( "t_sarah_fold_objective_", 0, &function_75ddceb0 );
    util::teleport_players_igc( str_objective );
    wait 1.25;
    array::thread_all( level.players, &infection_util::player_leave_cinematic );
    streamerrequest( "clear", "cin_inf_11_02_fold_1st_airlock" );
    level thread util::clear_streamer_hint();
    level thread monitor_t_tank();
    level thread monitor_s_tank_lookat();
    level thread spawn_first_attack_wave();
    level thread function_e6ee1935();
    battlechatter::function_d9f49fba( 1 );
    infection_util::turn_on_snow_fx_for_all_players( 3 );
    level thread function_20f82ee2();
    wait_for_players_to_enter_church();
}

// Namespace village_surreal
// Params 0
// Checksum 0xe3c820da, Offset: 0x1718
// Size: 0x52
function function_633271eb()
{
    level thread infection_util::function_f6d49772( "t_salm_i_am_increasingly_co_1", "salm_i_am_increasingly_co_1", "end_salm_fold_dialog" );
    level thread infection_util::function_f6d49772( "t_salm_in_the_wake_of_recen_1", "salm_in_the_wake_of_recen_1", "end_salm_fold_dialog" );
}

// Namespace village_surreal
// Params 0
// Checksum 0x50b87a94, Offset: 0x1778
// Size: 0x5e
function spawn_fold_turret_01()
{
    level.ai_fold_turret_01 = new cfoyturret();
    vh_turret_01 = vehicle::simple_spawn_single( "sp_fold_turret_01" );
    [[ level.ai_fold_turret_01 ]]->turret_setup( vh_turret_01, "sp_fold_turret_01_gunner", "t_fold_turret_01_gunner" );
}

// Namespace village_surreal
// Params 0
// Checksum 0x958c91fb, Offset: 0x17e0
// Size: 0x2a
function monitor_t_fold_turret_01_enable()
{
    trigger::wait_till( "t_fold_turret_01_enable" );
    [[ level.ai_fold_turret_01 ]]->gunner_start_think();
}

// Namespace village_surreal
// Params 0
// Checksum 0xce1fa391, Offset: 0x1818
// Size: 0x32a
function init_time_rewind_destruction()
{
    level.a_m_bank_explode = getentarray( "m_bank_explode", "targetname" );
    infection_util::models_ghost( level.a_m_bank_explode );
    level.a_m_fountain_explode = getentarray( "m_fountain_explode", "targetname" );
    infection_util::models_ghost( level.a_m_fountain_explode );
    level.var_78620d04 = getentarray( "m_reverse_sniper_building", "targetname" );
    infection_util::models_ghost( level.var_78620d04 );
    level.var_f3637081 = getentarray( "m_reverse_boarding_house", "targetname" );
    infection_util::models_ghost( level.var_f3637081 );
    scene::add_scene_func( "p7_fxanim_cp_infection_bank_explode_bundle", &callback_show_m_bank_explode, "done" );
    scene::add_scene_func( "p7_fxanim_cp_infection_fountain_explode_bundle", &callback_show_m_fountain_explode, "done" );
    scene::add_scene_func( "p7_fxanim_cp_infection_reverse_sniper_building_01_bundle", &function_ba41bc6a, "done" );
    scene::add_scene_func( "p7_fxanim_cp_infection_reverse_boarding_house_bundle", &function_6096a6cf, "done" );
    infection_util::play_scene_on_view_and_radius( "p7_fxanim_cp_infection_fountain_explode_bundle", "s_infection_fountain_explode_bundle", "t_infection_fountain_explode_bundle_inner", "t_infection_fountain_explode_bundle_outter" );
    infection_util::play_scene_on_view_and_radius( "p7_fxanim_cp_infection_reverse_wall_02_bundle", "s_infection_reverse_wall_02_bundle", "t_infection_reverse_wall_02_bundle_inner", "t_infection_reverse_wall_02_bundle_outter" );
    infection_util::play_scene_on_view_and_radius( "p7_fxanim_cp_infection_reverse_sniper_building_01_bundle", "s_infection_reverse_sniper_building_01_bundle", "t_infection_reverse_sniper_building_01_bundle_inner", "t_infection_reverse_sniper_building_01_bundle_outter" );
    infection_util::play_scene_on_view_and_radius( "p7_fxanim_cp_infection_reverse_boarding_house_bundle", "s_infection_reverse_boarding_house_bundle", "t_infection_reverse_boarding_house_bundle_inner", "t_infection_reverse_boarding_house_bundle_outter" );
    infection_util::play_scene_on_view_and_radius( "p7_fxanim_cp_infection_tombstone_reverse_01_bundle", "s_infection_tombstone_reverse_01_bundle", "t_infection_tombstone_reverse_01_bundle_inner", "t_infection_tombstone_reverse_01_bundle_outter" );
    infection_util::play_scene_on_view_and_radius( "p7_fxanim_cp_infection_tombstone_reverse_02_bundle", "s_infection_tombstone_reverse_02_bundle", "t_infection_tombstone_reverse_02_bundle_inner", "t_infection_tombstone_reverse_02_bundle_outter" );
    infection_util::play_scene_on_view_and_radius( "p7_fxanim_cp_infection_tombstone_reverse_03_bundle", "s_infection_tombstone_reverse_03_bundle", "t_infection_tombstone_reverse_03_bundle_inner", "t_infection_tombstone_reverse_03_bundle_outter" );
    level scene::init( "p7_fxanim_cp_infection_tank_wall_break_bundle" );
}

// Namespace village_surreal
// Params 1
// Checksum 0x9f424e, Offset: 0x1b50
// Size: 0x22
function callback_show_m_bank_explode( a_ents )
{
    infection_util::models_show( level.a_m_bank_explode );
}

// Namespace village_surreal
// Params 1
// Checksum 0xf16041ab, Offset: 0x1b80
// Size: 0x22
function callback_show_m_fountain_explode( a_ents )
{
    infection_util::models_show( level.a_m_fountain_explode );
}

// Namespace village_surreal
// Params 1
// Checksum 0xf87e95e5, Offset: 0x1bb0
// Size: 0x22
function function_ba41bc6a( a_ents )
{
    infection_util::models_show( level.var_78620d04 );
}

// Namespace village_surreal
// Params 1
// Checksum 0x6f941e46, Offset: 0x1be0
// Size: 0x22
function function_6096a6cf( a_ents )
{
    infection_util::models_show( level.var_f3637081 );
}

// Namespace village_surreal
// Params 0
// Checksum 0x951bf42a, Offset: 0x1c10
// Size: 0x1b2
function setup_scene_callbacks()
{
    scene::add_scene_func( "cin_inf_10_02_bastogne_vign_reversefall2floor_suppressor", &callback_reversefall2floor_suppressor, "play" );
    scene::add_scene_func( "cin_inf_10_02_bastogne_vign_reversemortar2floor_sniper", &infection_util::scene_callback_reverse_time_play_foy, "play" );
    scene::add_scene_func( "cin_inf_10_02_foy_aie_reverseshot_1_suppressor", &infection_util::scene_callback_reverse_time_play_foy, "play" );
    scene::add_scene_func( "cin_inf_10_02_foy_aie_reverseshot_5_sniper", &infection_util::scene_callback_reverse_time_play_foy, "play" );
    scene::add_scene_func( "cin_inf_11_03_fold_vign_reverse_sniper", &infection_util::scene_callback_reverse_time_play_foy, "play" );
    scene::add_scene_func( "cin_inf_11_02_fold_1st_airlock", &infection_util::function_23e59afd, "play" );
    scene::add_scene_func( "cin_inf_11_02_fold_1st_airlock", &infection_util::function_e2eba6da, "done" );
    scene::add_scene_func( "cin_inf_11_02_fold_1st_airlock", &function_3824b768, "play" );
    scene::add_scene_func( "cin_inf_11_02_fold_1st_airlock", &function_a8d640c7, "done" );
}

// Namespace village_surreal
// Params 1
// Checksum 0x46202f85, Offset: 0x1dd0
// Size: 0x22
function function_3824b768( a_ents )
{
    level clientfield::increment( "infection_fold_debris_1", 1 );
}

// Namespace village_surreal
// Params 1
// Checksum 0xb63a753c, Offset: 0x1e00
// Size: 0x22
function function_a8d640c7( a_ents )
{
    level thread scene::play( "p7_fxanim_cp_infection_bank_explode_bundle" );
}

// Namespace village_surreal
// Params 1
// Checksum 0x7519e398, Offset: 0x1e30
// Size: 0xbb
function callback_reversefall2floor_suppressor( a_ents )
{
    e_volume = getent( "t_sp_fold_guys_2_ai", "targetname" );
    
    foreach ( ent in a_ents )
    {
        if ( isactor( ent ) )
        {
            ent infection_util::reverse_time_set_on_ai( 0 );
            ent thread infection_util::set_ai_goto_volume( e_volume );
        }
    }
}

// Namespace village_surreal
// Params 0
// Checksum 0x7242e0fd, Offset: 0x1ef8
// Size: 0x3a
function spawn_first_attack_wave()
{
    spawn_manager::enable( "sm_fold_guys_0" );
    wait 5.5;
    spawn_manager::enable( "sm_fold_guys_1" );
}

// Namespace village_surreal
// Params 1
// Checksum 0xcc771e8c, Offset: 0x1f40
// Size: 0x5a
function altered_gravity_enable( b_enable )
{
    if ( b_enable )
    {
        setdvar( "phys_gravity_dir", ( 0, 1, -0.35 ) );
        level.var_74bd7d24 = 1;
        return;
    }
    
    setdvar( "phys_gravity_dir", ( 0, 0, 1 ) );
    level.var_74bd7d24 = 0;
}

// Namespace village_surreal
// Params 0
// Checksum 0xd280170e, Offset: 0x1fa8
// Size: 0x52
function setup_spawners()
{
    spawner::add_global_spawn_function( "axis", &infection_util::function_2f6bf570 );
    infection_util::enable_exploding_deaths( 1, 5 );
    infection_util::setup_reverse_time_arrivals( "fold_reverse_anims" );
}

// Namespace village_surreal
// Params 0
// Checksum 0xac00deb7, Offset: 0x2008
// Size: 0x8a
function spawn_func_tiger_tank()
{
    level.ai_tiger_tank = new ctigertank();
    [[ level.ai_tiger_tank ]]->tiger_tank_setup( self, "sp_tank_gunner", "" );
    [[ level.ai_tiger_tank ]]->disable_sfx( 1 );
    self util::set_rogue_controlled();
    self cybercom::cybercom_aioptout( "cybercom_surge" );
    infection_accolades::function_7356f9fd();
}

// Namespace village_surreal
// Params 0
// Checksum 0x54e64f68, Offset: 0x20a0
// Size: 0x112
function wait_for_players_to_enter_church()
{
    trigger::wait_till( "t_church_interior" );
    s_foy_gather_point_church = struct::get( "s_foy_gather_point_church", "targetname" );
    objectives::complete( "cp_level_infection_gather_church", s_foy_gather_point_church );
    level thread namespace_bed101ee::function_973b77f9();
    
    if ( isdefined( level.ai_tiger_tank ) )
    {
        [[ level.ai_tiger_tank ]]->delete_ai();
    }
    
    altered_gravity_enable( 0 );
    infection_util::turn_off_snow_fx_for_all_players();
    infection_util::enable_exploding_deaths( 1, 0 );
    spawner::remove_global_spawn_function( "axis", &infection_util::function_2f6bf570 );
    level clientfield::set( "dynent_catcher", 0 );
    level thread skipto::objective_completed( "village_inception" );
}

// Namespace village_surreal
// Params 0
// Checksum 0xd92bfc36, Offset: 0x21c0
// Size: 0x2a
function vo_intro_tiger_tank()
{
    wait 1;
    level dialog::remote( "hall_the_german_tiger_tan_0", 1, "NO_DNI" );
}

// Namespace village_surreal
// Params 0
// Checksum 0xa863cfa8, Offset: 0x21f8
// Size: 0x1a
function spawn_tank()
{
    spawner::simple_spawn_single( "sp_tiger_tank_fold" );
}

// Namespace village_surreal
// Params 0
// Checksum 0xd2e25910, Offset: 0x2220
// Size: 0x1c2
function activate_tank()
{
    if ( !level.tank_activated )
    {
        array::thread_all( level.activeplayers, &coop::function_e9f7384d );
        level.tank_activated = 1;
        t_sarah = getent( "t_sarah_fold_objective_1", "targetname" );
        
        if ( isdefined( t_sarah ) )
        {
            trigger::use( "t_sarah_fold_objective_1" );
        }
        
        level thread vo_intro_tiger_tank();
        nd_start = getvehiclenode( "nd_tank_path", "targetname" );
        level thread scene::play( "p7_fxanim_cp_infection_tank_wall_break_bundle" );
        [[ level.ai_tiger_tank ]]->disable_sfx( 0 );
        level.ai_tiger_tank.m_vehicle thread vehicle::get_on_and_go_path( nd_start );
        level.ai_tiger_tank.m_vehicle thread vehicle_rumble();
        
        foreach ( player in level.players )
        {
            earthquake( 0.22, 3.5, player.origin, -106 );
        }
        
        wait 3.5;
        [[ level.ai_tiger_tank ]]->start_think();
        level thread monitor_t_tank_destory();
    }
}

// Namespace village_surreal
// Params 0
// Checksum 0x7ad112b7, Offset: 0x23f0
// Size: 0x59
function vehicle_rumble()
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( abs( self getspeedmph() ) < 10 )
        {
            self playrumbleonentity( "tank_rumble" );
        }
        
        wait 1;
    }
}

// Namespace village_surreal
// Params 0
// Checksum 0xc6659e66, Offset: 0x2458
// Size: 0x42
function monitor_t_tank_destory()
{
    while ( isalive( level.ai_tiger_tank.m_vehicle ) )
    {
        wait 0.1;
    }
    
    wait 3;
    activate_sm_fold_guys_4();
}

// Namespace village_surreal
// Params 0
// Checksum 0x34475807, Offset: 0x24a8
// Size: 0x32
function monitor_t_tank_retreat_1()
{
    level endon( #"tiger_tank_first_retreat" );
    trigger::wait_till( "t_tank_retreat_1" );
    [[ level.ai_tiger_tank ]]->retreat_override();
}

// Namespace village_surreal
// Params 0
// Checksum 0x1b578b6, Offset: 0x24e8
// Size: 0x2a
function monitor_t_tank_retreat_2()
{
    trigger::wait_till( "t_tank_retreat_2" );
    [[ level.ai_tiger_tank ]]->retreat_override();
}

// Namespace village_surreal
// Params 0
// Checksum 0xf307af67, Offset: 0x2520
// Size: 0x32
function monitor_t_tank_retreat_3()
{
    level endon( #"tiger_tank_first_retreat" );
    trigger::wait_till( "t_tank_retreat_3" );
    [[ level.ai_tiger_tank ]]->retreat_override();
}

// Namespace village_surreal
// Params 0
// Checksum 0x334b1895, Offset: 0x2560
// Size: 0x2a
function monitor_t_tank_retreat_4()
{
    trigger::wait_till( "t_tank_retreat_4" );
    [[ level.ai_tiger_tank ]]->retreat_override();
}

// Namespace village_surreal
// Params 0
// Checksum 0x998a10fc, Offset: 0x2598
// Size: 0x6a
function monitor_s_tank_lookat()
{
    self endon( #"monitor_t_tank" );
    array::spread_all( level.players, &infection_util::lookingatstructdurationcheck, "s_tank_lookat", 2, "lookat_tank" );
    level waittill( #"lookat_tank" );
    level notify( #"monitor_s_tank_lookat" );
    activate_tank();
}

// Namespace village_surreal
// Params 0
// Checksum 0xa6f3c37d, Offset: 0x2610
// Size: 0x52
function monitor_s_church_lookat()
{
    array::spread_all( level.players, &infection_util::lookingatstructdurationcheck, "s_church_lookat", 2, "lookat_church", 2600 );
    level waittill( #"lookat_church" );
    activate_church_mg_support();
}

// Namespace village_surreal
// Params 0
// Checksum 0x68d56974, Offset: 0x2670
// Size: 0x2a
function monitor_t_church_lookat()
{
    trigger::wait_till( "t_church_lookat" );
    activate_church_mg_support();
}

// Namespace village_surreal
// Params 0
// Checksum 0xd92106f0, Offset: 0x26a8
// Size: 0x42
function activate_church_mg_support()
{
    if ( !level.church_mg_support_activated )
    {
        level.church_mg_support_activated = 1;
        spawner::simple_spawn_single( "sp_chruch_mg_01" );
        spawner::simple_spawn_single( "sp_chruch_mg_02" );
    }
}

// Namespace village_surreal
// Params 0
// Checksum 0xb5c8d5d6, Offset: 0x26f8
// Size: 0x3a
function monitor_t_tank()
{
    self endon( #"monitor_s_tank_lookat" );
    trigger::wait_till( "t_tank" );
    level notify( #"monitor_t_tank" );
    activate_tank();
}

// Namespace village_surreal
// Params 0
// Checksum 0x20984d91, Offset: 0x2740
// Size: 0x9a
function monitor_t_cemetery_retreat()
{
    trigger::wait_till( "t_cemetery_retreat" );
    level thread infection_util::set_ai_goal_volume( "sp_fold_guys_tank_ai", "t_sp_fold_guys_3_ai" );
    level thread infection_util::set_ai_goal_volume( "sp_fold_guys_2_ai", "t_sp_fold_guys_3_ai" );
    level thread infection_util::retreat_if_in_volume( "t_foy_guys_0_and_1_retreat_goal_2", "t_sp_fold_guys_3_ai" );
    level thread infection_util::retreat_if_in_volume( "t_sp_fold_guys_2_ai", "t_sp_fold_guys_3_ai" );
}

// Namespace village_surreal
// Params 0
// Checksum 0xd7b83509, Offset: 0x27e8
// Size: 0x32
function monitor_t_infection_fold_debris_2()
{
    trigger::wait_till( "t_infection_fold_debris_2" );
    level clientfield::set( "infection_fold_debris_2", 1 );
}

// Namespace village_surreal
// Params 0
// Checksum 0xcf0f6f2e, Offset: 0x2828
// Size: 0x32
function monitor_t_infection_fold_debris_3()
{
    trigger::wait_till( "t_infection_fold_debris_3" );
    level clientfield::set( "infection_fold_debris_3", 1 );
}

// Namespace village_surreal
// Params 0
// Checksum 0x9b9a267, Offset: 0x2868
// Size: 0x32
function monitor_t_infection_fold_debris_4()
{
    trigger::wait_till( "t_infection_fold_debris_4" );
    level clientfield::set( "infection_fold_debris_4", 1 );
}

// Namespace village_surreal
// Params 0
// Checksum 0xa0a78a46, Offset: 0x28a8
// Size: 0x3a
function monitor_t_bank_retreat()
{
    trigger::wait_till( "t_bank_retreat" );
    level thread infection_util::retreat_if_in_volume( "t_bank", "t_foy_guys_0_and_1_retreat_goal" );
}

// Namespace village_surreal
// Params 0
// Checksum 0xcc504a08, Offset: 0x28f0
// Size: 0x82
function monitor_t_foy_guys_0_and_1_retreat()
{
    trigger::wait_till( "t_foy_guys_0_and_1_retreat" );
    level thread infection_util::set_ai_goal_volume( "sp_fold_guys_0_ai", "t_foy_guys_0_and_1_retreat_goal" );
    level thread infection_util::set_ai_goal_volume( "sp_fold_guys_1_ai", "t_foy_guys_0_and_1_retreat_goal" );
    wait 5.5;
    level thread infection_util::set_ai_goal_volume( "sp_fold_guys_1_ai", "t_foy_guys_0_and_1_retreat_goal" );
}

// Namespace village_surreal
// Params 0
// Checksum 0xb44c1441, Offset: 0x2980
// Size: 0x3a
function monitor_t_foy_guys_0_and_1_retreat_2()
{
    trigger::wait_till( "t_foy_guys_0_and_1_retreat_2" );
    level thread infection_util::retreat_if_in_volume( "t_foy_guys_0_and_1_retreat_goal", "t_foy_guys_0_and_1_retreat_goal_2" );
}

// Namespace village_surreal
// Params 0
// Checksum 0x799d114a, Offset: 0x29c8
// Size: 0x2a
function monitor_t_sm_fold_guys_4()
{
    trigger::wait_till( "t_sm_fold_guys_4" );
    activate_sm_fold_guys_4();
}

// Namespace village_surreal
// Params 0
// Checksum 0xd269888a, Offset: 0x2a00
// Size: 0x32
function activate_sm_fold_guys_4()
{
    if ( !spawn_manager::is_enabled( "sm_fold_guys_4" ) )
    {
        spawn_manager::enable( "sm_fold_guys_4" );
    }
}

// Namespace village_surreal
// Params 1
// Checksum 0x234a6a6e, Offset: 0x2a40
// Size: 0x6b
function scene_callback_foy_sarah_init( a_ents )
{
    foreach ( ent in a_ents )
    {
        ent ai::set_ignoreme( 1 );
    }
}

// Namespace village_surreal
// Params 0
// Checksum 0x756d229f, Offset: 0x2ab8
// Size: 0x3a
function function_75ddceb0()
{
    self endon( #"death" );
    level notify( #"hash_75ddceb0" );
    self util::unmake_hero( "sarah" );
    self util::self_delete();
}

// Namespace village_surreal
// Params 0
// Checksum 0x59fba61e, Offset: 0x2b00
// Size: 0xda
function function_e6ee1935()
{
    level waittill( #"hash_75ddceb0" );
    util::wait_network_frame();
    level clientfield::set( "light_church_ext_window", 1 );
    level.ai_sarah = util::get_hero( "sarah" );
    level.ai_sarah clientfield::set( "sarah_body_light", 1 );
    level.ai_sarah thread scene::play( "cin_inf_11_04_fold_vign_walk_end", level.ai_sarah );
    s_foy_gather_point_church = struct::get( "s_foy_gather_point_church", "targetname" );
    objectives::set( "cp_level_infection_gather_church", s_foy_gather_point_church );
}

// Namespace village_surreal
// Params 0
// Checksum 0x7c537a66, Offset: 0x2be8
// Size: 0x2a
function function_20f82ee2()
{
    trigger::wait_till( "t_cemetery_retreat" );
    savegame::checkpoint_save();
}

