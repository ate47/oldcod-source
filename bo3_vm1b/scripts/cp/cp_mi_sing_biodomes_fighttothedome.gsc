#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_biodomes_accolades;
#using scripts/cp/cp_mi_sing_biodomes_cloudmountain;
#using scripts/cp/cp_mi_sing_biodomes_sound;
#using scripts/cp/cp_mi_sing_biodomes_util;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicles/_hunter;

#namespace cp_mi_sing_biodomes_fighttothedome;

// Namespace cp_mi_sing_biodomes_fighttothedome
// Params 0
// Checksum 0xe9c07cd6, Offset: 0x800
// Size: 0x2
function main()
{
    
}

// Namespace cp_mi_sing_biodomes_fighttothedome
// Params 2
// Checksum 0xea425da2, Offset: 0x810
// Size: 0x3c2
function objective_fighttothedome_init( str_objective, b_starting )
{
    cp_mi_sing_biodomes_util::objective_message( "objective_fighttothedome_init" );
    level notify( #"hash_a425069a" );
    
    if ( b_starting )
    {
        load::function_73adcefc();
        cp_mi_sing_biodomes_cloudmountain::disable_cloudmountain_triggers();
        spawner::add_spawn_function_group( "sp_server_room_background", "targetname", &function_76c56ee1 );
        spawn_manager::enable( "sm_server_room_background" );
        level thread scene::skipto_end( "p7_fxanim_cp_biodomes_server_room_window_break_01_bundle" );
        var_777355da = getentarray( "hallway_turret", "script_noteworthy" );
        a_turrets = spawner::simple_spawn( var_777355da );
        array::run_all( a_turrets, &kill );
        e_clip = getent( "turret_hallway_door_ai_clip", "targetname" );
        e_clip delete();
        level cp_mi_sing_biodomes_cloudmountain::function_a78ec4a();
        var_a63c572e = getent( "server_window", "targetname" );
        
        if ( isdefined( var_a63c572e ) )
        {
            var_a63c572e delete();
        }
        
        level thread cp_mi_sing_biodomes_util::function_753a859( str_objective );
        exploder::exploder( "vtol_svrrm_window_break1" );
        exploder::exploder( "vtol_svrrm_window_break2" );
        level flag::wait_till( "all_players_spawned" );
        level thread namespace_f1b4cbbc::function_46333a8a();
        cp_mi_sing_biodomes_util::init_hendricks( str_objective );
        load::function_a2995f22();
    }
    
    level.ai_hendricks.ignoreall = 0;
    level.ai_hendricks ai::set_ignoreme( 0 );
    level thread function_e6379a2( b_starting );
    e_clip = getent( "control_room_ai_clip", "targetname" );
    e_clip delete();
    level.ai_hendricks thread check_for_death();
    vh_vtol = vehicle::simple_spawn_single_and_drive( "fight_dome_escape_vtol" );
    vh_vtol util::magic_bullet_shield();
    level thread function_868ce0d5( vh_vtol );
    vh_vtol waittill( #"reached_end_node" );
    vh_vtol clearvehgoalpos();
    level thread scene::init( "cin_bio_11_03_fightdome_1st_escape", vh_vtol );
    level thread scene::add_scene_func( "cin_bio_11_03_fightdome_1st_escape", &function_c4de5eee, "play" );
    level thread scene::add_scene_func( "cin_bio_11_03_fightdome_1st_escape", &end_fade_out, "skip_started" );
    level thread scene::init( "p7_fxanim_cp_biodomes_rope_sim_hendricks_bundle" );
    level thread function_646d5121();
    spawn_manager::enable( "sm_supertree_background_retreat" );
}

// Namespace cp_mi_sing_biodomes_fighttothedome
// Params 1
// Checksum 0x2d41dc8a, Offset: 0xbe0
// Size: 0x82
function end_fade_out( a_ents )
{
    foreach ( player in level.activeplayers )
    {
        player setlowready( 1 );
    }
    
    util::screen_fade_out( 0, "black" );
}

// Namespace cp_mi_sing_biodomes_fighttothedome
// Params 1
// Checksum 0x3b874df6, Offset: 0xc70
// Size: 0x5a
function function_e6379a2( b_starting )
{
    if ( !b_starting )
    {
        level scene::play( "cin_bio_10_01_serverroom_vign_hack_loop" );
    }
    
    level cp_mi_sing_biodomes_cloudmountain::hendricks_server_control_room_door_open( 1 );
    level thread function_3d342090();
    level scene::play( "cin_bio_11_03_fightdome_1st_escape_approach" );
}

// Namespace cp_mi_sing_biodomes_fighttothedome
// Params 0
// Checksum 0x7675c848, Offset: 0xcd8
// Size: 0x3a
function function_76c56ee1()
{
    level waittill( #"hash_d38fe5be" );
    wait 9;
    self ai::set_ignoreall( 0 );
    self settargetentity( level.ai_hendricks );
}

// Namespace cp_mi_sing_biodomes_fighttothedome
// Params 1
// Checksum 0x84f8ebd2, Offset: 0xd20
// Size: 0x3a
function function_868ce0d5( vh_vtol )
{
    level dialog::remote( "kane_i_m_gonna_some_need_0" );
    vh_vtol dialog::say( "vtlp_bird_on_approach_for_0" );
}

// Namespace cp_mi_sing_biodomes_fighttothedome
// Params 0
// Checksum 0x420d338e, Offset: 0xd68
// Size: 0x162
function function_646d5121()
{
    level clientfield::set( "fighttothedome_exfil_rope", 1 );
    wait 1;
    level notify( #"hash_d38fe5be" );
    var_7724dd66 = getent( "trig_rope_rescue", "targetname" );
    var_7724dd66 show();
    
    if ( isdefined( level.bzm_biodialogue4callback ) )
    {
        level thread [[ level.bzm_biodialogue4callback ]]();
    }
    
    var_9bdb9113 = util::init_interactive_gameobject( var_7724dd66, &"cp_level_biodomes_exfil", &"CP_MI_SING_BIODOMES_ZIPLINE_USE", &function_2ed72358 );
    level waittill( #"hash_a384e425" );
    level clientfield::set( "fighttothedome_exfil_rope", 2 );
    
    if ( isdefined( level.bzm_biodialogue5callback ) )
    {
        level thread [[ level.bzm_biodialogue5callback ]]();
    }
    
    level thread function_f68b9e51();
    level thread function_df8adf84( "hendricks" );
    level thread function_df8adf84( "player" );
    level waittill( #"hash_ebe76425" );
    level clientfield::set( "sndIGCsnapshot", 4 );
    skipto::objective_completed( "objective_fighttothedome" );
}

// Namespace cp_mi_sing_biodomes_fighttothedome
// Params 1
// Checksum 0x4dc14c9b, Offset: 0xed8
// Size: 0x62
function function_df8adf84( var_9200d3f9 )
{
    var_b08086a1 = getent( "glass_crack_" + var_9200d3f9, "targetname" );
    var_b08086a1 hide();
    level waittill( var_9200d3f9 + "_crack_glass" );
    var_b08086a1 show();
}

// Namespace cp_mi_sing_biodomes_fighttothedome
// Params 0
// Checksum 0xc06bd1a6, Offset: 0xf48
// Size: 0xf9
function function_f68b9e51()
{
    for ( n_times = 0; n_times < 2 ; n_times++ )
    {
        level waittill( #"hash_36f8cd21" );
        
        foreach ( player in level.players )
        {
            player clientfield::set_to_player( "zipline_speed_blur", 1 );
        }
        
        level waittill( #"hash_99beb75c" );
        
        foreach ( player in level.players )
        {
            player clientfield::set_to_player( "zipline_speed_blur", 0 );
        }
    }
}

// Namespace cp_mi_sing_biodomes_fighttothedome
// Params 1
// Checksum 0x1347cf00, Offset: 0x1050
// Size: 0xca
function function_2ed72358( var_8df23e0a )
{
    foreach ( player in level.players )
    {
        player clientfield::set_to_player( "server_extra_cam", 0 );
        player enableinvulnerability();
    }
    
    self gameobjects::disable_object();
    objectives::complete( "cp_level_biodomes_exfil" );
    level notify( #"hash_a384e425" );
    level thread scene::play( "cin_bio_11_03_fightdome_1st_escape", var_8df23e0a );
}

// Namespace cp_mi_sing_biodomes_fighttothedome
// Params 1
// Checksum 0x4c5d85e7, Offset: 0x1128
// Size: 0x6a
function function_c4de5eee( a_ents )
{
    level thread scene::play( "p7_fxanim_cp_biodomes_rope_sim_hendricks_bundle" );
    var_7a94ab35 = getent( "rope_sim_hendricks", "targetname" );
    var_7a94ab35 waittill( #"hash_34bf0af6" );
    level clientfield::set( "fighttothedome_exfil_rope_sim_player", 1 );
}

// Namespace cp_mi_sing_biodomes_fighttothedome
// Params 0
// Checksum 0x4a8a84f1, Offset: 0x11a0
// Size: 0x62
function check_for_death()
{
    level endon( #"hash_a384e425" );
    util::unmake_hero( "hendricks" );
    self.overrideactordamage = &function_daf71f6;
    self waittill( #"death" );
    util::missionfailedwrapper_nodeath( &"CP_MI_SING_BIODOMES_HENDRICKS_KILLED", &"CP_MI_SING_BIODOMES_HENDRICKS_KILLED_HINT" );
}

// Namespace cp_mi_sing_biodomes_fighttothedome
// Params 12
// Checksum 0x155b13af, Offset: 0x1210
// Size: 0xa1
function function_daf71f6( e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, w_weapon, v_point, v_dir, str_hit_loc, n_model_index, psoffsettime, str_bone_name )
{
    var_6c3c4545 = getweapon( "hunter_rocket_turret" );
    
    if ( w_weapon === var_6c3c4545 )
    {
        n_damage = self.health;
    }
    else
    {
        n_damage = 0;
    }
    
    return n_damage;
}

// Namespace cp_mi_sing_biodomes_fighttothedome
// Params 4
// Checksum 0x72729022, Offset: 0x12c0
// Size: 0x4a
function objective_fighttothedome_done( str_objective, b_starting, b_direct, player )
{
    biodomes_accolades::function_ed573577();
    cp_mi_sing_biodomes_util::objective_message( "objective_fighttothedome_done" );
}

// Namespace cp_mi_sing_biodomes_fighttothedome
// Params 0
// Checksum 0xe9a5cf40, Offset: 0x1318
// Size: 0x1a
function function_3d342090()
{
    wait 1;
    level thread cp_mi_sing_biodomes_cloudmountain::hendricks_server_control_room_door_open( 0 );
}

