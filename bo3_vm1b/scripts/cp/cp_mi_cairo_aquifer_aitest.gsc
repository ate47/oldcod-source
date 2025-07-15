#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_aquifer_objectives;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicles/_quadtank;

#namespace cp_mi_cairo_aquifer_aitest;

// Namespace cp_mi_cairo_aquifer_aitest
// Params 0
// Checksum 0xe515836c, Offset: 0x12f0
// Size: 0x34a
function init()
{
    if ( !level flag::exists( "inside_aquifer" ) )
    {
        level flag::init( "inside_aquifer" );
    }
    
    level flag::init( "aquifer_zone02_combat_start" );
    level flag::init( "aquifer_zone03_combat_start" );
    level flag::init( "flag_force_off_dust" );
    level flag::init( "flag_post_vtol_intro" );
    level flag::init( "exterior_hack_trig_left_1_finished" );
    level flag::init( "exterior_hack_trig_right_1_finished" );
    level flag::init( "hack_zone02_1_finished" );
    level flag::init( "hack_zone02_2_finished" );
    level flag::init( "hack_zone03_1_finished" );
    level flag::init( "hack_zone03_2_finished" );
    level flag::init( "flag_aqu_save_state" );
    level flag::init( "exterior_hack_trig_left_1_started" );
    level flag::init( "exterior_hack_trig_right_1_started" );
    level flag::init( "hack_zone02_1_started" );
    level flag::init( "hack_zone02_2_started" );
    level flag::init( "hack_zone03_1_started" );
    level flag::init( "hack_zone03_2_started" );
    level flag::init( "hack_zone02_3_started" );
    level flag::init( "hack_zone02_3_finished" );
    level flag::init( "hack_zone02_4_started" );
    level flag::init( "hack_zone02_4_finished" );
    level flag::init( "hack_zone02_5_started" );
    level flag::init( "hack_zone02_5_finished" );
    level flag::init( "hack_zone02_6_started" );
    level flag::init( "hack_zone02_6_finished" );
    level flag::init( "flag_kayne_vulnerable" );
    level flag::init( "kayne_starts_overload" );
    level flag::init( "flag_wave2_port" );
    level flag::init( "flag_wave2_residential" );
    level flag::init( "flag_player_left_tower_done" );
    level flag::init( "flag_player_right_tower_done" );
    level flag::init( "flag_player_started_left_tower" );
    level flag::init( "flag_player_started_right_tower" );
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 0
// Checksum 0xcd605cfd, Offset: 0x1648
// Size: 0x22
function function_82230f12()
{
    thread handler_hack_spawns();
    thread handle_cleaning_up_of_enemies();
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 0
// Checksum 0x35f1bd6e, Offset: 0x1678
// Size: 0x42
function function_25dcb860()
{
    thread zone_ai_spawns( "start_spawning_zone01_enemies", "spawn_manager_zone01", "spawn_manager_zone01b", "destroy_defenses_completed", "hack_terminal_right_completed", "aquifer_zone03_combat_start" );
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 6
// Checksum 0xfc036c99, Offset: 0x16c8
// Size: 0x212
function zone_ai_spawns( trig, sm, var_470f86b1, flag_til_kill, var_a6b912d3, flag_enable )
{
    tr = getent( trig, "targetname" );
    tr waittill( #"trigger" );
    spawner::add_global_spawn_function( "axis", &function_18de558f );
    spawn_manager::enable( sm );
    spawn_manager::enable( var_470f86b1 );
    vehicle::add_spawn_function( "zone01_hunter", &function_8273bb26 );
    var_17644d42 = getent( "zone01_hunter", "targetname" );
    veh = vehicle::_vehicle_spawn( var_17644d42 );
    spawners = getentarray( "dummy_runners_01", "targetname" );
    
    foreach ( s in spawners )
    {
        s thread function_59a7e387();
    }
    
    level flag::wait_till( flag_til_kill );
    spawn_manager::disable( sm );
    spawn_manager::disable( var_470f86b1 );
    spawner::remove_global_spawn_function( "axis", &function_18de558f );
    level flag::wait_till( var_a6b912d3 );
    
    if ( isdefined( flag_enable ) )
    {
        level flag::set( flag_enable );
    }
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 0
// Checksum 0xb4174e6, Offset: 0x18e8
// Size: 0xa
function function_18de558f()
{
    self.dontdropweapon = 1;
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 0
// Checksum 0x4ce55f66, Offset: 0x1900
// Size: 0xc3
function function_8273bb26()
{
    self endon( #"death" );
    self endon( #"deleted" );
    level flag::wait_till( "destroy_defenses_completed" );
    self ai::set_ignoreall( 1 );
    self.goalradius = 32;
    zone01_hunter_goal = getent( "zone01_hunter_goal", "targetname" );
    zone01_hunter_goal.radius = 32;
    self setneargoalnotifydist( 32 );
    self setvehgoalpos( zone01_hunter_goal.origin, 1 );
    self waittill( #"goal" );
    self delete();
    self notify( #"deleted" );
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 0
// Checksum 0xcf6b0448, Offset: 0x19d0
// Size: 0x59
function function_59a7e387()
{
    level endon( #"hash_4af9ae51" );
    
    while ( true )
    {
        soldier = self spawner::spawn();
        
        if ( isdefined( soldier ) )
        {
            soldier waittill( #"death" );
        }
        else
        {
            wait 0.05;
        }
        
        self.count = 1;
        wait 3;
    }
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 0
// Checksum 0x35cb8eb8, Offset: 0x1a38
// Size: 0x32
function handler_hack_spawns()
{
    thread function_f0eb736e();
    thread function_16f0ef2b();
    thread function_44f51c2d();
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 1
// Checksum 0x298b115, Offset: 0x1a78
// Size: 0x24a
function handler_egyptian_defend_scenario( completed_flag )
{
    sm = "spawn_manager_egyptian_defend1";
    var_ad81c50c = "spawn_manager_hack_zone03_1";
    array::thread_all( getentarray( "egyptian_spawner_01", "targetname" ), &spawner::add_spawn_function, &function_2f71981c );
    callback::on_ai_damage( &function_40cfc8f4 );
    thread function_5433cddd();
    spawner::add_global_spawn_function( "axis", &function_18de558f );
    wait 3;
    thread function_caae752c();
    util::set_streamer_hint( 5 );
    spawn_manager::enable( sm );
    spawn_manager::enable( var_ad81c50c );
    level flag::wait_till( completed_flag );
    spawn_manager::disable( sm );
    spawn_manager::disable( var_ad81c50c );
    callback::remove_on_ai_damage( &function_40cfc8f4 );
    level flag::set( "hack_zone03_1_finished" );
    wait 5;
    arrcomb = spawn_manager::get_ai( sm );
    var_7c0a3add = spawn_manager::get_ai( var_ad81c50c );
    arrcomb = arraycombine( arrcomb, var_7c0a3add, 0, 0 );
    arrcomb = arraycombine( arrcomb, level.quad_tank_objectives, 0, 0 );
    spawner::remove_global_spawn_function( "axis", &function_18de558f );
    level waittill( #"hash_476bcf62" );
    level flag::set( "flag_force_off_dust" );
    wait 3;
    array::thread_all( arrcomb, &delete_me );
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 0
// Checksum 0xa41803d2, Offset: 0x1cd0
// Size: 0x1a
function delete_me()
{
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 0
// Checksum 0xf96ba5a1, Offset: 0x1cf8
// Size: 0x92
function function_5433cddd()
{
    t = getent( "egyptian_defend_reached_trig", "targetname" );
    
    if ( isdefined( t ) )
    {
        t triggerenable( 1 );
    }
    
    wait 20;
    
    if ( !level flag::get( "egyptian_defend_reached" ) )
    {
        level flag::set( "egyptian_defend_reached" );
    }
    
    if ( isdefined( t ) )
    {
        t triggerenable( 0 );
    }
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 1
// Checksum 0x316fdca6, Offset: 0x1d98
// Size: 0x1e2
function function_40cfc8f4( params )
{
    if ( !level flag::get( "egyptian_defend_reached" ) && isplayer( params.eattacker ) )
    {
        level flag::set( "egyptian_defend_reached" );
    }
    else if ( !level flag::get( "egyptian_defend_reached" ) && !isplayer( params.eattacker ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_27aeb908 ) )
    {
        level.var_27aeb908 = 0;
        level.var_ff73cf2d = 0;
        level.var_103b592a = 0;
    }
    
    if ( isplayer( params.eattacker ) && isdefined( self.targetname ) && self.targetname == "egyptian_spawner_01_ai" )
    {
        level.var_27aeb908 += params.idamage;
        function_ccf5af95();
    }
    
    if ( isplayer( params.eattacker ) && isdefined( self.team ) && self.team == "axis" )
    {
        level.var_103b592a = 0;
    }
    
    if ( isdefined( params.eattacker ) && params.eattacker.team == "axis" && isdefined( self.targetname ) && self.targetname == "egyptian_spawner_01_ai" )
    {
        level.var_103b592a += 1;
        
        if ( level.var_103b592a >= 7 )
        {
            util::missionfailedwrapper_nodeath( &"CP_MI_CAIRO_AQUIFER_KHALILKILLED", &"CP_MI_CAIRO_AQUIFER_EGYPT_FAIL" );
        }
    }
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 0
// Checksum 0x8389c98a, Offset: 0x1f88
// Size: 0x9a
function function_ccf5af95()
{
    if ( !isdefined( level.var_26ee895f ) )
    {
        level.var_26ee895f = 1;
        level.var_70c85b56 = [];
        array::add( level.var_70c85b56, "khal_friendly_fire_frien_0" );
        array::add( level.var_70c85b56, "khal_watch_your_fire_you_0" );
    }
    
    if ( level.var_27aeb908 > level.var_26ee895f * 850 )
    {
        level thread dialog::remote( level.var_70c85b56[ level.var_26ee895f % 2 ] );
        level.var_26ee895f++;
    }
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 0
// Checksum 0xe9c07cd6, Offset: 0x2030
// Size: 0x2
function function_caae752c()
{
    
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 0
// Checksum 0xf46610b, Offset: 0x2040
// Size: 0x1a
function function_2f71981c()
{
    self util::magic_bullet_shield();
    self.dontdropweapon = 1;
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 0
// Checksum 0x6edc7d44, Offset: 0x2068
// Size: 0x1ca
function function_f0eb736e()
{
    thread function_bd9f11ed();
    thread function_254b71e5();
    vehicle::add_spawn_function( "port_vtol1", &function_6c135aa8 );
    vehicle::add_spawn_function( "port_vtol2", &function_6c135aa8 );
    vehicle::add_spawn_function( "defend_1_2_hunter_1", &function_1c36248b );
    vehicle::add_spawn_function( "defend_1_2_hunter_2", &function_1c36248b );
    var_4208e495 = getent( "defend_1_2_hunter_1", "targetname" );
    var_680b5efe = getent( "defend_1_2_hunter_2", "targetname" );
    var_f3ed94cd = "spawn_manager_hack_zone01_2_wave1";
    var_19f00f36 = "spawn_manager_hack_zone01_2_wave2";
    var_3ff2899f = "spawn_manager_hack_zone01_2_wave3";
    var_5d8f4916 = "trig_veh_hack1_2a";
    var_378ccead = "trig_veh_hack1_2b";
    thread function_e8e3d4b4( "port", "destroy_defenses_completed", "exterior_hack_trig_left_1", "exterior_hack_trig_left_1_started", "exterior_hack_trig_left_1_finished", var_5d8f4916, var_378ccead, var_4208e495, var_680b5efe, var_f3ed94cd, var_19f00f36, var_3ff2899f, "exterior_hack_trig_left_1_finished", "pre_hack_01_2_volume", "aquifer_zone_1_left", "left_pad_volume" );
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 0
// Checksum 0x614d0308, Offset: 0x2240
// Size: 0x1ba
function function_16f0ef2b()
{
    thread function_e3a18c56();
    vehicle::add_spawn_function( "res_vtol1", &function_6c135aa8 );
    vehicle::add_spawn_function( "res_vtol2", &function_6c135aa8 );
    vehicle::add_spawn_function( "defend_1_1_hunter_1", &function_1c36248b );
    vehicle::add_spawn_function( "defend_1_1_hunter_1", &function_1c36248b );
    var_6a43b028 = getent( "defend_1_1_hunter_1", "targetname" );
    var_dc4b1f63 = getent( "defend_1_1_hunter_2", "targetname" );
    var_9a9ac320 = "spawn_manager_hack_zone01_1_wave1";
    var_ca2325b = "spawn_manager_hack_zone01_1_wave2";
    var_e69fb7f2 = "spawn_manager_hack_zone01_1_wave3";
    var_5d8f4916 = "trig_veh_hack1_1a";
    var_378ccead = "trig_veh_hack1_1b";
    thread function_e8e3d4b4( "residential", "destroy_defenses_completed", "exterior_hack_trig_right_1", "exterior_hack_trig_right_1_started", "exterior_hack_trig_right_1_finished", var_5d8f4916, var_378ccead, var_6a43b028, var_dc4b1f63, var_9a9ac320, var_ca2325b, var_e69fb7f2, "exterior_hack_trig_right_1_finished", "hack_01_1_volume", "aquifer_zone_1_right", "right_pad_volume" );
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 0
// Checksum 0xa9394760, Offset: 0x2408
// Size: 0x1a
function function_254b71e5()
{
    level flag::wait_till( "flag_port_land_enemy_shift1" );
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 0
// Checksum 0xe6af6fcb, Offset: 0x2430
// Size: 0x12
function function_6c135aa8()
{
    target_set( self );
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 16
// Checksum 0x5f81b9a9, Offset: 0x2450
// Size: 0x23a
function function_e8e3d4b4( zone, flag, hack_trig, flag_hack_started, var_57b589ae, var_1543d260, var_874b419b, var_82491bec, var_f4508b27, var_35a5f3d4, var_a7ad630f, var_81aae8a6, completed_flag, var_2b2ece93, var_735cecc8, var_7b82a236 )
{
    level flag::wait_till( flag );
    hacking_trig = getent( hack_trig, "targetname" );
    hacking_trig triggerenable( 1 );
    var_ee69678 = getent( var_2b2ece93, "targetname" );
    var_2d7c1aa2 = getent( var_735cecc8, "targetname" );
    guys = getaiteamarray( "axis" );
    
    foreach ( guy in guys )
    {
        if ( isdefined( guy ) )
        {
            if ( guy istouching( var_2d7c1aa2 ) )
            {
                thread function_3b8a6405( guy, var_ee69678 );
            }
        }
    }
    
    level flag::wait_till( flag_hack_started );
    thread function_1a2672d9( zone );
    thread function_346a6ba8( zone, hacking_trig, var_1543d260, var_874b419b, var_82491bec, var_f4508b27, var_35a5f3d4, var_a7ad630f, var_81aae8a6 );
    level flag::wait_till( var_57b589ae );
    
    if ( zone == "port" )
    {
        level notify( #"hash_c8354b43" );
    }
    
    if ( zone == "residential" )
    {
        level notify( #"hash_952639a0" );
    }
    
    thread function_ecb1c055( var_735cecc8, var_7b82a236 );
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 1
// Checksum 0x5d88b44b, Offset: 0x2698
// Size: 0x612
function function_1a2672d9( zone )
{
    if ( zone == "port" )
    {
        org = getent( "kayne_hacking_left", "targetname" );
        wait 30;
        exploder::exploder( "hack01_stage01" );
        org playloopsound( "evt_tower_sparks_lyr_01" );
        wait 10;
        exploder::exploder( "hack01_stage02" );
        org playloopsound( "evt_tower_sparks_lyr_02" );
        wait 10;
        exploder::exploder( "hack01_stage03" );
        org playloopsound( "evt_tower_sparks_lyr_03" );
        wait 10;
        exploder::exploder( "hack01_stage04" );
        org playloopsound( "evt_tower_sparks_lyr_04" );
        playsoundatposition( "evt_tower_overload", org.origin );
        wait 10;
        exploder::exploder( "hack01_stage05" );
        
        foreach ( player in level.players )
        {
            playsoundatposition( "evt_exp_electrical", org.origin );
            player playrumbleonentity( "tank_damage_heavy_mp" );
            earthquake( 0.35, 0.5, player.origin, 325 );
        }
        
        wait 5;
        
        foreach ( player in level.players )
        {
            playsoundatposition( "evt_exp_electrical", org.origin );
            player playrumbleonentity( "tank_damage_heavy_mp" );
            earthquake( 0.75, 0.7, player.origin, 325 );
        }
        
        org stoploopsound( 0.1 );
        exploder::exploder_stop( "hack01_stage01" );
        exploder::exploder_stop( "hack01_stage02" );
        exploder::exploder_stop( "hack01_stage03" );
        exploder::exploder_stop( "hack01_stage04" );
    }
    
    if ( zone == "residential" )
    {
        org = getent( "kayne_hacking_right", "targetname" );
        wait 30;
        exploder::exploder( "hack02_stage01" );
        org playloopsound( "evt_tower_sparks_lyr_01" );
        wait 10;
        exploder::exploder( "hack02_stage02" );
        org playloopsound( "evt_tower_sparks_lyr_02" );
        wait 10;
        exploder::exploder( "hack02_stage03" );
        org playloopsound( "evt_tower_sparks_lyr_03" );
        wait 10;
        exploder::exploder( "hack02_stage04" );
        org playloopsound( "evt_tower_sparks_lyr_04" );
        playsoundatposition( "evt_tower_overload", org.origin );
        wait 10;
        exploder::exploder( "hack02_stage05" );
        
        foreach ( player in level.players )
        {
            playsoundatposition( "evt_exp_electrical", org.origin );
            player playrumbleonentity( "tank_damage_heavy_mp" );
            earthquake( 0.45, 0.5, player.origin, 325 );
        }
        
        wait 5;
        
        foreach ( player in level.players )
        {
            playsoundatposition( "evt_exp_electrical", org.origin );
            player playrumbleonentity( "tank_damage_heavy_mp" );
            earthquake( 0.8, 1, player.origin, 400 );
        }
        
        org stoploopsound( 0.1 );
        exploder::exploder_stop( "hack02_stage01" );
        exploder::exploder_stop( "hack02_stage02" );
        exploder::exploder_stop( "hack02_stage03" );
        exploder::exploder_stop( "hack02_stage04" );
    }
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 9
// Checksum 0x9a1f9857, Offset: 0x2cb8
// Size: 0x629
function function_346a6ba8( zone, hacking_trig, var_1543d260, var_874b419b, var_82491bec, var_f4508b27, var_35a5f3d4, var_a7ad630f, var_81aae8a6 )
{
    level endon( #"hash_2ba72bcb" );
    
    if ( zone == "residential" )
    {
        level notify( #"notify_defend_hack2_started" );
        thread function_c8bb3155( "vol_res_defend_kayne", "exterior_hack_trig_right_1_finished" );
    }
    
    if ( zone == "port" )
    {
        level notify( #"notify_defend_hack1_started" );
        thread function_c8bb3155( "vol_port_defend_kayne", "exterior_hack_trig_left_1_finished" );
    }
    
    if ( isdefined( level.kayne ) )
    {
        level.kayne ai::set_ignoreall( 1 );
    }
    
    while ( true )
    {
        wait 1;
        
        if ( isdefined( hacking_trig ) && isdefined( hacking_trig.var_a220f04a ) && hacking_trig.var_a220f04a > 1 )
        {
            if ( isdefined( level.kayne ) && isalive( level.kayne ) && level.var_260a842b == 1 )
            {
                savegame::checkpoint_save();
                thread function_810caddd();
            }
            
            spawn_manager::enable( var_35a5f3d4 );
            wait 4;
            
            if ( zone == "residential" )
            {
                level.kayne thread dialog::say( "kane_multiple_contacts_r_0" );
            }
            
            if ( zone == "port" )
            {
                level.kayne thread dialog::say( "kane_more_enemies_coming_0" );
            }
            
            trigger::use( var_1543d260, "targetname" );
            
            if ( isdefined( var_82491bec ) && level.players.size > 1 && function_a6748659() )
            {
                veh = vehicle::_vehicle_spawn( var_82491bec );
                veh thread vehicle::get_on_and_go_path( veh.target );
            }
            
            break;
        }
        
        wait 0.25;
    }
    
    while ( true )
    {
        wait 1;
        
        if ( isdefined( hacking_trig ) && isdefined( hacking_trig.var_a220f04a ) && hacking_trig.var_a220f04a > 30 )
        {
            if ( zone == "port" )
            {
                level.kayne dialog::say( "kane_more_ground_troops_1" );
                level.kayne dialog::say( "kane_watch_my_six_0" );
            }
            
            wait 3;
            
            if ( zone == "port" )
            {
                thread function_ced14faf();
            }
            
            if ( zone == "residential" )
            {
                thread function_78d6fd02();
            }
            
            break;
        }
        
        wait 0.25;
    }
    
    while ( true )
    {
        if ( isdefined( hacking_trig ) && isdefined( hacking_trig.var_a220f04a ) && hacking_trig.var_a220f04a > 50 )
        {
            level notify( #"hash_213353eb" );
            
            if ( zone == "residential" )
            {
                level.kayne dialog::say( "kane_good_job_keep_watch_1" );
            }
            
            if ( zone == "port" )
            {
                level.kayne dialog::say( "kane_i_m_halfway_there_k_1" );
            }
            
            spawn_manager::enable( var_a7ad630f );
            
            if ( isdefined( level.kayne ) && isalive( level.kayne ) && level.var_260a842b == 1 )
            {
                savegame::checkpoint_save();
                thread function_810caddd();
            }
            
            trigger::use( var_874b419b, "targetname" );
            
            if ( isdefined( var_f4508b27 ) && level.players.size > 2 && function_a6748659() && !isdefined( var_82491bec ) )
            {
                veh = vehicle::_vehicle_spawn( var_f4508b27 );
                veh thread vehicle::get_on_and_go_path( veh.target );
                level.kayne dialog::say( "kane_watch_out_for_drones_1" );
            }
            
            wait 3;
            
            if ( zone == "residential" )
            {
                level.kayne dialog::say( "kane_tangos_above_us_dea_0" );
            }
            
            if ( zone == "port" )
            {
                level dialog::remote( "hend_look_out_they_re_dr_0" );
            }
            
            break;
        }
        
        wait 0.25;
    }
    
    while ( true )
    {
        if ( isdefined( hacking_trig ) && isdefined( hacking_trig.var_a220f04a ) && hacking_trig.var_a220f04a > 65 )
        {
            if ( zone == "residential" )
            {
                level.kayne dialog::say( "kane_getting_close_1" );
            }
            
            if ( zone == "port" )
            {
                level.kayne dialog::say( "kane_almost_there_1" );
            }
            
            spawn_manager::enable( var_81aae8a6 );
            wait 2;
            
            if ( zone == "residential" )
            {
                level.kayne dialog::say( "kane_watch_out_for_drones_1" );
            }
            
            break;
        }
        
        wait 0.25;
    }
    
    while ( true )
    {
        if ( isdefined( hacking_trig ) && isdefined( hacking_trig.var_a220f04a ) && hacking_trig.var_a220f04a > 85 )
        {
            if ( zone == "residential" )
            {
                level.kayne dialog::say( "kane_nearly_done_1" );
            }
            
            if ( zone == "port" )
            {
                level.kayne dialog::say( "kane_just_a_little_more_1" );
            }
            
            break;
        }
        
        wait 0.25;
    }
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 0
// Checksum 0xba04d3c7, Offset: 0x32f0
// Size: 0x32
function function_810caddd()
{
    level flag::set( "flag_aqu_save_state" );
    wait 5;
    level flag::clear( "flag_aqu_save_state" );
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 0
// Checksum 0x37179c06, Offset: 0x3330
// Size: 0xea
function function_1c36248b()
{
    self endon( #"death" );
    self setthreatbiasgroup( "defend_hunters" );
    self.var_d3f57f67 = 1;
    setignoremegroup( "players_ground", "defend_hunters" );
    
    while ( function_a6748659() )
    {
        wait 0.5;
    }
    
    self ai::set_ignoreall( 1 );
    goalent = getent( "zone01_hunter_goal", "targetname" );
    self setneargoalnotifydist( 32 );
    self setvehgoalpos( goalent.origin, 1 );
    self waittill( #"goal" );
    self delete();
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 0
// Checksum 0x51b943f0, Offset: 0x3428
// Size: 0x6a, Type: bool
function function_a6748659()
{
    foreach ( player in level.activeplayers )
    {
        if ( player aquifer_obj::player_in_vtol() )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 2
// Checksum 0x76638e12, Offset: 0x34a0
// Size: 0x1a5
function function_c8bb3155( vol, flag )
{
    level endon( #"hacking_complete" );
    var_368eea5 = getent( vol, "targetname" );
    thread function_5d498f22();
    var_e015a244 = 0;
    var_ac95a522 = 0;
    level.var_260a842b = 0;
    
    while ( !flag::get( flag ) )
    {
        if ( !isalive( level.kayne ) )
        {
            return;
        }
        
        if ( util::any_player_is_touching( var_368eea5, "allies" ) )
        {
            var_ac95a522 = 0;
            level flag::clear( "flag_kayne_vulnerable" );
            
            if ( !var_e015a244 )
            {
                level.kayne util::magic_bullet_shield();
                level notify( #"hash_78a213c8" );
                var_e015a244 = 1;
                level.var_260a842b = 1;
            }
        }
        else if ( !util::any_player_is_touching( var_368eea5, "allies" ) )
        {
            while ( flag::get( "flag_aqu_save_state" ) )
            {
                wait 0.25;
            }
            
            var_e015a244 = 0;
            
            if ( !var_ac95a522 )
            {
                level.kayne thread function_f5a137d2();
                level.kayne setthreatbiasgroup( "players_vtol" );
                var_ac95a522 = 1;
                level.var_260a842b = 0;
            }
            
            level flag::set( "flag_kayne_vulnerable" );
        }
        
        wait 0.5;
    }
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 0
// Checksum 0x1766756b, Offset: 0x3650
// Size: 0xa2
function function_f5a137d2()
{
    level endon( #"hash_78a213c8" );
    level endon( #"hacking_complete" );
    level.kayne util::stop_magic_bullet_shield();
    level.kayne.health = 999999;
    
    for ( hit_count = 0; hit_count < 5 ; hit_count++ )
    {
        self waittill( #"damage" );
    }
    
    level notify( #"hash_2ba72bcb" );
    level.kayne ai::bloody_death();
    util::missionfailedwrapper_nodeath( &"CP_MI_CAIRO_AQUIFER_KANEKILLED", &"CP_MI_CAIRO_AQUIFER_PROTECT_FAIL" );
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 0
// Checksum 0x93c29b91, Offset: 0x3700
// Size: 0xc5
function function_5d498f22()
{
    level endon( #"hacking_complete" );
    level endon( #"hash_2ba72bcb" );
    var_687c3dc4 = 0;
    vo_array = [];
    vo_array[ vo_array.size ] = "kane_what_the_hell_are_yo_1";
    vo_array[ vo_array.size ] = "kane_where_are_you_going_1";
    vo_array[ vo_array.size ] = "kane_hey_watch_my_six_0";
    
    while ( true )
    {
        while ( level flag::get( "flag_kayne_vulnerable" ) )
        {
            wait 1;
            var_69e9781d = array::random( vo_array );
            level.kayne dialog::say( var_69e9781d );
            
            if ( !var_687c3dc4 )
            {
                level notify( #"hash_67e6e842" );
            }
            
            var_687c3dc4 = 1;
            wait 3;
        }
        
        wait 0.75;
    }
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 0
// Checksum 0x40e616c4, Offset: 0x37d0
// Size: 0xeb
function function_ced14faf()
{
    var_2d7c1aa2 = getent( "hack_01_2_volume", "targetname" );
    var_5bb53a30 = getent( "pre_hack_01_2_volume", "targetname" );
    guys = getaiteamarray( "axis" );
    
    foreach ( guy in guys )
    {
        if ( guy istouching( var_2d7c1aa2 ) )
        {
            thread function_3b8a6405( guy, var_5bb53a30 );
        }
    }
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 0
// Checksum 0xf052531, Offset: 0x38c8
// Size: 0xeb
function function_78d6fd02()
{
    var_2d7c1aa2 = getent( "hack_01_1_volume", "targetname" );
    var_5bb53a30 = getent( "hack_01_1_volume2", "targetname" );
    guys = getaiteamarray( "axis" );
    
    foreach ( guy in guys )
    {
        if ( guy istouching( var_2d7c1aa2 ) )
        {
            thread function_3b8a6405( guy, var_5bb53a30 );
        }
    }
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 3
// Checksum 0x9bffdd61, Offset: 0x39c0
// Size: 0x12b
function function_ecb1c055( from_vol, var_5bb53a30, var_64f17a00 )
{
    var_2d7c1aa2 = getent( from_vol, "targetname" );
    a_vol = getent( var_5bb53a30, "targetname" );
    guys = getaiteamarray( "axis" );
    
    foreach ( guy in guys )
    {
        if ( guy istouching( var_2d7c1aa2 ) )
        {
            if ( isalive( guy ) )
            {
                thread function_3b8a6405( guy, a_vol );
                
                if ( isdefined( var_64f17a00 ) && var_64f17a00 == 1 )
                {
                    thread function_10e80b01( guy, 2 );
                }
            }
        }
    }
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 2
// Checksum 0x9c2d2180, Offset: 0x3af8
// Size: 0x42
function function_10e80b01( guy, delay )
{
    wait delay;
    
    if ( isalive( guy ) )
    {
        guy delete();
    }
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 7
// Checksum 0x3d923e59, Offset: 0x3b48
// Size: 0x353
function function_1ce3cac0( flag, flag_hack_started, hack_trig, spawnman, completed_flag, var_b96b1ea0, var_1acd98f5 )
{
    level flag::wait_till( flag );
    hacking_trig = getent( hack_trig, "targetname" );
    hacking_trig triggerenable( 1 );
    spawn_manager::enable( spawnman );
    level flag::wait_till( completed_flag );
    spawn_manager::disable( spawnman );
    vol = undefined;
    
    if ( isdefined( var_b96b1ea0 ) )
    {
        vol = getent( var_b96b1ea0, "targetname" );
    }
    
    if ( isdefined( vol ) )
    {
        leftovers = spawn_manager::get_ai( spawnman );
        
        foreach ( dude in leftovers )
        {
            dude clearentitytarget();
            dude cleargoalvolume();
            dude clearforcedgoal();
            thread function_3b8a6405( dude, vol );
        }
    }
    
    if ( isdefined( level.var_6657ee03 ) && isdefined( var_1acd98f5 ) )
    {
        if ( var_1acd98f5 == "volume_egyptian_zone02_4" )
        {
            ts = struct::get_array( "egyptian_defenders_tele", "targetname" );
            var_71dd83fd = 0;
            
            foreach ( guy in level.var_6657ee03 )
            {
                tries = 0;
                
                while ( tries < 20 )
                {
                    if ( isalive( guy ) )
                    {
                        if ( guy teleport( ts[ var_71dd83fd ].origin, ts[ var_71dd83fd ].angles ) )
                        {
                            break;
                        }
                    }
                    
                    tries++;
                    wait 0.05;
                }
                
                var_71dd83fd++;
            }
        }
        
        vol = getent( var_1acd98f5, "targetname" );
        
        if ( isdefined( vol ) )
        {
            foreach ( dude in level.var_6657ee03 )
            {
                if ( isalive( dude ) )
                {
                    dude clearentitytarget();
                    dude cleargoalvolume();
                    dude clearforcedgoal();
                    thread function_3b8a6405( dude, vol );
                }
            }
        }
    }
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 1
// Checksum 0xed50ccc9, Offset: 0x3ea8
// Size: 0x5a
function function_34ad69d9( trig )
{
    t = getent( trig, "targetname" );
    t waittill( #"trigger" );
    
    if ( isdefined( t.script_flag_set ) )
    {
        level flag::set( t.script_flag_set );
    }
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 0
// Checksum 0x5af2fe43, Offset: 0x3f10
// Size: 0xba
function function_ada56725()
{
    struct = getent( "kayne_hacking_right", "targetname" );
    trig = getent( "right_hack_use_trig", "targetname" );
    trig waittill( #"hash_ece70538", activator );
    
    if ( isdefined( level.bzm_aquiferdialogue1_4_1callback ) )
    {
        level thread [[ level.bzm_aquiferdialogue1_4_1callback ]]();
    }
    
    struct scene::play( "cin_aqu_01_20_towerright_1st_panelrip", activator );
    level flag::set( "flag_player_right_tower_done" );
    thread function_ad2882a8();
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 0
// Checksum 0xf4db833a, Offset: 0x3fd8
// Size: 0x1ab
function function_ad2882a8()
{
    level endon( #"hash_2ba72bcb" );
    struct = getent( "kayne_hacking_right", "targetname" );
    struct scene::play( "cin_aqu_01_20_towerright_vign_overload_enter", level.kayne );
    level notify( #"hash_571aa0aa" );
    struct thread scene::play( "cin_aqu_01_20_towerright_vign_overload_main", level.kayne );
    level flag::wait_till( "exterior_hack_trig_right_1_finished" );
    level flag::clear( "kayne_starts_overload" );
    struct thread scene::play( "cin_aqu_01_20_towerright_vign_overload_exit", level.kayne );
    
    if ( !level flag::get( "exterior_hack_trig_left_1_finished" ) )
    {
        level.kayne dialog::say( "kane_comms_down_let_s_ge_0" );
        level thread function_36a1fd93();
    }
    
    if ( isdefined( level.kayne ) && isalive( level.kayne ) && !flag::get( "flag_kayne_vulnerable" ) )
    {
        wait 0.05;
        level.kayne util::magic_bullet_shield();
        savegame::checkpoint_save();
    }
    
    wait 0.25;
    
    if ( isdefined( level.kayne ) )
    {
        level.kayne ai::set_ignoreall( 0 );
    }
    
    level notify( #"hacking_complete" );
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 0
// Checksum 0x168fd2b4, Offset: 0x4190
// Size: 0x3a
function function_36a1fd93()
{
    level dialog::remote( "hend_we_ve_got_more_quad_0", 1 );
    level dialog::remote( "kane_on_our_way_0", 0.25 );
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 0
// Checksum 0x90ce5a69, Offset: 0x41d8
// Size: 0xaa
function function_f9e22dfc()
{
    struct = getent( "kayne_hacking_left", "targetname" );
    trig = getent( "left_hack_use_trig", "targetname" );
    trig waittill( #"hash_ece70538", activator );
    struct scene::play( "cin_aqu_01_20_towerleft_1st_panelrip", activator );
    level flag::set( "flag_player_left_tower_done" );
    thread function_9b151b9b();
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 0
// Checksum 0xecb4489d, Offset: 0x4290
// Size: 0x1ab
function function_9b151b9b()
{
    level endon( #"hash_2ba72bcb" );
    struct = getent( "kayne_hacking_left", "targetname" );
    struct scene::play( "cin_aqu_01_20_towerleft_vign_overload_enter", level.kayne );
    level notify( #"hash_571aa0aa" );
    struct thread scene::play( "cin_aqu_01_20_towerleft_vign_overload_main", level.kayne );
    level flag::wait_till( "exterior_hack_trig_left_1_finished" );
    level flag::clear( "kayne_starts_overload" );
    struct thread scene::play( "cin_aqu_01_20_towerleft_vign_overload_exit", level.kayne );
    
    if ( !level flag::get( "exterior_hack_trig_right_1_finished" ) )
    {
        level.kayne dialog::say( "kane_enemy_comms_cut_we_0" );
        level thread function_36a1fd93();
    }
    
    if ( isdefined( level.kayne ) && isalive( level.kayne ) && !flag::get( "flag_kayne_vulnerable" ) )
    {
        wait 0.05;
        level.kayne util::magic_bullet_shield();
        savegame::checkpoint_save();
    }
    
    wait 0.25;
    
    if ( isdefined( level.kayne ) )
    {
        level.kayne ai::set_ignoreall( 0 );
    }
    
    level notify( #"hacking_complete" );
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 0
// Checksum 0xf0402fab, Offset: 0x4448
// Size: 0xb2
function function_bd9f11ed()
{
    thread function_66aabab2( "notify_defend_hack1_started", "flag_kayne_at_hack1" );
    thread function_f9e22dfc();
    thread function_f250176e();
    landing_zone = -1;
    
    while ( landing_zone != 1 )
    {
        level waittill( #"vtol_landed", player, landing_zone );
    }
    
    level.kayne = aquifer_obj::function_30343b22( "kayne_hack1" );
    wait 1;
    level flag::wait_till( "finished_first_landing_vo" );
    thread function_f83cec9b();
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 0
// Checksum 0x9336e0e3, Offset: 0x4508
// Size: 0x112
function function_f250176e()
{
    level flag::wait_till( "exterior_hack_trig_left_1_started" );
    level notify( #"hash_79051ffd" );
    level.kayne dialog::say( "kane_this_will_take_some_0", 1 );
    level.kayne dialog::say( "kane_spread_out_don_t_ge_0", 4 );
    wait 1;
    level flag::wait_till( "exterior_hack_trig_left_1_finished" );
    wait 1;
    spawn_manager::enable( "spawn_manager_takeoff_port" );
    trigger::use( "kayne_colors_left_takeoff", "targetname" );
    wait 1;
    landing_zone = -1;
    
    while ( landing_zone != 1 )
    {
        level waittill( #"vtol_takeoff", player, landing_zone );
    }
    
    if ( isdefined( level.kayne ) && level.var_1226dab0 == 0 )
    {
        level.kayne delete();
    }
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 0
// Checksum 0x16546e9f, Offset: 0x4628
// Size: 0x4a
function function_f83cec9b()
{
    level endon( #"hash_79051ffd" );
    wait 5;
    level.kayne dialog::say( "kane_cover_to_cover_up_t_0" );
    wait 3;
    level.kayne dialog::say( "kane_clean_up_remaining_t_0" );
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 0
// Checksum 0x23118a89, Offset: 0x4680
// Size: 0xb2
function function_e3a18c56()
{
    thread function_66aabab2( "notify_defend_hack2_started", "flag_kayne_at_hack2" );
    thread function_ada56725();
    thread function_932a5979();
    landing_zone = -1;
    
    while ( landing_zone != 2 )
    {
        level waittill( #"vtol_landed", player, landing_zone );
    }
    
    level.kayne = aquifer_obj::function_30343b22( "kayne_hack2" );
    wait 1;
    level flag::wait_till( "finished_first_landing_vo" );
    thread function_db00cade();
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 0
// Checksum 0xf6dce63c, Offset: 0x4740
// Size: 0x6a
function function_db00cade()
{
    level endon( #"hash_bd6f4584" );
    wait 3;
    level.kayne dialog::say( "kane_push_forward_0" );
    wait 5;
    level.kayne dialog::say( "kane_get_moving_i_ll_cov_0" );
    wait 8;
    level.kayne dialog::say( "kane_the_array_is_just_up_0" );
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 0
// Checksum 0x65837923, Offset: 0x47b8
// Size: 0xea
function function_932a5979()
{
    level flag::wait_till( "exterior_hack_trig_right_1_started" );
    level notify( #"hash_bd6f4584" );
    level.kayne dialog::say( "kane_i_can_take_it_from_h_0", 1 );
    level flag::wait_till( "exterior_hack_trig_right_1_finished" );
    wait 1;
    spawn_manager::enable( "spawn_manager_takeoff_residential" );
    trigger::use( "kayne_colors_right_takeoff", "targetname" );
    landing_zone = -1;
    
    while ( landing_zone != 2 )
    {
        level waittill( #"vtol_takeoff", player, landing_zone );
    }
    
    if ( isdefined( level.kayne ) && level.var_1226dab0 == 0 )
    {
        level.kayne delete();
    }
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 0
// Checksum 0xee4989d5, Offset: 0x48b0
// Size: 0x52
function function_44f51c2d()
{
    level flag::wait_till_all( array( "exterior_hack_trig_right_1_finished", "exterior_hack_trig_left_1_finished" ) );
    level.kayne dialog::say( "kane_mission_complete_le_0", 2 );
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 2
// Checksum 0x35061d52, Offset: 0x4910
// Size: 0x209
function function_66aabab2( var_b031addf, flag )
{
    level endon( var_b031addf );
    level flag::wait_till( flag );
    
    if ( !isdefined( level.var_518d7942 ) )
    {
        level.var_518d7942 = [];
        
        if ( !isdefined( level.var_518d7942 ) )
        {
            level.var_518d7942 = [];
        }
        else if ( !isarray( level.var_518d7942 ) )
        {
            level.var_518d7942 = array( level.var_518d7942 );
        }
        
        level.var_518d7942[ level.var_518d7942.size ] = "kane_boot_up_the_array_0";
        
        if ( !isdefined( level.var_518d7942 ) )
        {
            level.var_518d7942 = [];
        }
        else if ( !isarray( level.var_518d7942 ) )
        {
            level.var_518d7942 = array( level.var_518d7942 );
        }
        
        level.var_518d7942[ level.var_518d7942.size ] = "kane_start_the_process_0";
        
        if ( !isdefined( level.var_518d7942 ) )
        {
            level.var_518d7942 = [];
        }
        else if ( !isarray( level.var_518d7942 ) )
        {
            level.var_518d7942 = array( level.var_518d7942 );
        }
        
        level.var_518d7942[ level.var_518d7942.size ] = "kane_start_the_overload_p_0";
    }
    
    var_364c5984 = array( 1, 8, 15 );
    a_str_nags = arraycopy( level.var_518d7942 );
    
    for ( x = 0; x < a_str_nags.size ; x++ )
    {
        wait var_364c5984[ x ];
        array::remove_index( level.var_518d7942, x );
        level.kayne dialog::say( a_str_nags[ x ] );
    }
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 2
// Checksum 0xe5fe6107, Offset: 0x4b28
// Size: 0x82
function function_3b8a6405( dude, vol )
{
    dude endon( #"death" );
    dude clearentitytarget();
    dude cleargoalvolume();
    dude clearforcedgoal();
    dude ai::set_ignoreall( 1 );
    wait 0.05;
    dude setgoalvolume( vol );
    dude ai::set_ignoreall( 0 );
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 0
// Checksum 0xc4d10131, Offset: 0x4bb8
// Size: 0x7a
function handle_cleaning_up_of_enemies()
{
    thread function_f065e00e();
    thread function_790839b7();
    thread function_d123f7f2();
    thread function_36f5a1f4();
    thread function_4e5e42a9();
    thread function_5bda03b6();
    level flag::wait_till( "flag_egyptian_hacking_completed" );
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 0
// Checksum 0xd0545f32, Offset: 0x4c40
// Size: 0x52
function function_f065e00e()
{
    level flag::wait_till( "destroy_defenses_completed" );
    guys = spawner::get_ai_group_ai( "dummy_runners_01" );
    
    if ( isdefined( guys ) )
    {
        thread kill_guys( guys );
    }
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 0
// Checksum 0x24ee7eaf, Offset: 0x4ca0
// Size: 0x3a
function function_2d0258ff()
{
    var_b56f2b95 = spawner::get_ai_group_ai( "zone01_rpgs" );
    
    if ( isdefined( var_b56f2b95 ) )
    {
        thread kill_guys( var_b56f2b95 );
    }
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 0
// Checksum 0x7430a1b5, Offset: 0x4ce8
// Size: 0x5a
function function_790839b7()
{
    landing_zone = -1;
    
    while ( landing_zone != 1 )
    {
        level waittill( #"vtol_landed", player, landing_zone );
    }
    
    guys1 = spawn_manager::get_ai( "spawn_manager_zone01b" );
    thread kill_guys( guys1 );
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 0
// Checksum 0x6baff04e, Offset: 0x4d50
// Size: 0x5a
function function_d123f7f2()
{
    landing_zone = -1;
    
    while ( landing_zone != 2 )
    {
        level waittill( #"vtol_landed", player, landing_zone );
    }
    
    guys1 = spawn_manager::get_ai( "spawn_manager_zone01" );
    thread kill_guys( guys1 );
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 0
// Checksum 0xde1f046, Offset: 0x4db8
// Size: 0x142
function function_4e5e42a9()
{
    level flag::wait_till( "hack_terminal_left_completed" );
    level waittill( #"vtol_takeoff" );
    guys1 = spawn_manager::get_ai( "spawn_manager_zone01" );
    thread kill_guys( guys1 );
    guys2 = spawn_manager::get_ai( "spawn_manager_hack_zone01_2_wave1" );
    thread kill_guys( guys2 );
    guys3 = spawn_manager::get_ai( "spawn_manager_hack_zone01_2_wave2" );
    thread kill_guys( guys3 );
    guys4 = spawn_manager::get_ai( "spawn_manager_hack_zone01_2_wave3" );
    thread kill_guys( guys4 );
    guys5 = spawn_manager::get_ai( "spawn_manager_land_port" );
    thread kill_guys( guys5 );
    guys6 = spawn_manager::get_ai( "spawn_manager_takeoff_port" );
    thread kill_guys( guys6 );
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 0
// Checksum 0x71b02573, Offset: 0x4f08
// Size: 0x142
function function_36f5a1f4()
{
    level flag::wait_till( "hack_terminal_right_completed" );
    level waittill( #"vtol_takeoff" );
    guys1 = spawn_manager::get_ai( "spawn_manager_zone01b" );
    thread kill_guys( guys1 );
    guys2 = spawn_manager::get_ai( "spawn_manager_hack_zone01_1_wave1" );
    thread kill_guys( guys2 );
    guys3 = spawn_manager::get_ai( "spawn_manager_hack_zone01_1_wave2" );
    thread kill_guys( guys3 );
    guys4 = spawn_manager::get_ai( "spawn_manager_hack_zone01_1_wave3" );
    thread kill_guys( guys4 );
    guys5 = spawn_manager::get_ai( "spawn_manager_land_residential" );
    thread kill_guys( guys5 );
    guys6 = spawn_manager::get_ai( "spawn_manager_takeoff_residential" );
    thread kill_guys( guys6 );
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 0
// Checksum 0xce391e06, Offset: 0x5058
// Size: 0x219
function function_5bda03b6()
{
    level flag::wait_till_all( array( "hack_terminal_right_completed", "hack_terminal_left_completed" ) );
    level waittill( #"vtol_takeoff" );
    guys1 = spawn_manager::get_ai( "spawn_manager_zone01" );
    thread kill_guys( guys1 );
    guys2 = spawn_manager::get_ai( "spawn_manager_zone01" );
    thread kill_guys( guys2 );
    guys3 = spawn_manager::get_ai( "spawn_manager_hack_zone01_1_wave1" );
    thread kill_guys( guys3 );
    guys4 = spawn_manager::get_ai( "spawn_manager_hack_zone01_1_wave2" );
    thread kill_guys( guys4 );
    guys5 = spawn_manager::get_ai( "spawn_manager_hack_zone01_1_wave3" );
    thread kill_guys( guys5 );
    guys6 = spawn_manager::get_ai( "spawn_manager_hack_zone01_2_wave1" );
    thread kill_guys( guys6 );
    var_2e7e5acc = spawn_manager::get_ai( "spawn_manager_hack_zone01_2_wave2" );
    thread kill_guys( var_2e7e5acc );
    var_d8680d1b = spawn_manager::get_ai( "spawn_manager_hack_zone01_2_wave3" );
    thread kill_guys( var_d8680d1b );
    var_62fd3a = 4;
    
    for ( i = 1; i <= var_62fd3a ; i++ )
    {
        var_1560b77d = spawner::get_ai_group_ai( "enemy_vtol_riders_" + i );
        thread kill_guys( var_1560b77d );
    }
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 1
// Checksum 0xfbfe5279, Offset: 0x5280
// Size: 0x73
function kill_guys( guys )
{
    wait 10;
    
    if ( isdefined( guys ) )
    {
        foreach ( guy in guys )
        {
            if ( isdefined( guy ) )
            {
                guy kill();
            }
        }
    }
}

// Namespace cp_mi_cairo_aquifer_aitest
// Params 3
// Checksum 0x20cf5262, Offset: 0x5300
// Size: 0x163
function clean_up_zone_spawns( zonenum, wait_flag, waves )
{
    level flag::wait_till( wait_flag );
    tot = 2;
    z = 1;
    
    if ( zonenum == 2 )
    {
        tot = 6;
        z = 4;
    }
    
    guys = [];
    guys = spawn_manager::get_ai( "spawn_manager_zone0" + zonenum );
    
    while ( z <= tot )
    {
        sm = "spawn_manager_hack_zone0" + zonenum + "_" + z;
        guys = arraycombine( guys, spawn_manager::get_ai( sm ), 0, 0 );
        spawn_manager::kill( sm );
        z++;
    }
    
    spawn_manager::kill( "spawn_manager_zone0" + zonenum, 1 );
    wait 10;
    
    foreach ( guy in guys )
    {
        if ( isdefined( guy ) )
        {
            guy delete();
        }
    }
}

