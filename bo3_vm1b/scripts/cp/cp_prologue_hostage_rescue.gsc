#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_eth_prologue;
#using scripts/cp/cp_mi_eth_prologue_accolades;
#using scripts/cp/cp_mi_eth_prologue_fx;
#using scripts/cp/cp_mi_eth_prologue_sound;
#using scripts/cp/cp_prologue_apc;
#using scripts/cp/cp_prologue_cyber_soldiers;
#using scripts/cp/cp_prologue_hangars;
#using scripts/cp/cp_prologue_util;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/doors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;

#namespace hostage_1;

// Namespace hostage_1
// Params 1
// Checksum 0xb1b453b3, Offset: 0x2250
// Size: 0xc2
function hostage_1_start( str_objective )
{
    hostage_1_precache();
    spawner::add_spawn_function_group( "fuel_tunnel_ai", "script_noteworthy", &cp_prologue_util::ai_idle_then_alert, "fuel_tunnel_alerted", 1024 );
    
    if ( !isdefined( level.ai_hendricks ) )
    {
        level.ai_hendricks = util::get_hero( "hendricks" );
        cp_mi_eth_prologue::init_hendricks( "skipto_hostage_1_hendricks" );
        skipto::teleport_ai( str_objective );
    }
    
    level.ai_hendricks.ignoreme = 1;
    level thread hostage_1_main();
}

// Namespace hostage_1
// Params 0
// Checksum 0xe0a57015, Offset: 0x2320
// Size: 0x32
function hostage_1_precache()
{
    level thread scene::init( "cin_pro_06_01_hostage_vign_rollgrenade" );
    level thread scene::init( "p7_fxanim_cp_prologue_underground_truck_explode_bundle" );
}

// Namespace hostage_1
// Params 0
// Checksum 0xe7df76dd, Offset: 0x2360
// Size: 0x152
function hostage_1_main()
{
    level thread cp_prologue_util::function_950d1c3b( 1 );
    level thread function_ca7de8e8();
    objectives::set( "cp_level_prologue_free_the_minister" );
    battlechatter::function_d9f49fba( 1 );
    cp_prologue_util::function_47a62798( 1 );
    level.ai_hendricks thread function_672c874();
    trigger::wait_till( "hendricks_rollgrenade" );
    array::thread_all( level.players, &watch_player_fire );
    level.ai_hendricks waittill( #"hash_ff2562ea" );
    level thread function_88ddc4d5();
    level flag::set( "fuel_tunnel_alerted" );
    level thread function_5d78fd66();
    level thread function_f41e9505();
    level thread cp_prologue_util::function_8f7b1e06( "t_fuel_tunnel_ai_fallback_controller", "info_fuel_tunnel_fallback_begin", "info_fuel_tunnel_fallback_end" );
    level waittill( #"hash_5d08c61e" );
    skipto::objective_completed( "skipto_hostage_1" );
}

// Namespace hostage_1
// Params 0
// Checksum 0x79d84cf, Offset: 0x24c0
// Size: 0x22
function function_5d78fd66()
{
    wait 1.5;
    level thread cp_prologue_util::function_a7eac508( "sp_fuel_tunnel_explosion_runners", undefined, 1024, undefined );
}

// Namespace hostage_1
// Params 0
// Checksum 0xe07c72b2, Offset: 0x24f0
// Size: 0x2da
function function_ca7de8e8()
{
    a_ai_enemies = getaiteamarray( "axis" );
    
    foreach ( ai_enemy in a_ai_enemies )
    {
        ai_enemy delete();
    }
    
    level thread function_b7afdf3a();
    level thread function_e14a508d();
    spawn_manager::enable( "sm_fuel_tunnel" );
    spawner::simple_spawn( "sp_fuel_depot_staging" );
    level thread spawn_machine_gunner();
    level thread function_ee3c7f46();
    level thread function_d9bab593( "t_fuel_tunnel_left_door", "fueltunnel_spawnclosetdoor_2", "sp_fuel_tunnel_left_door", "info_fuel_tunnel_left_door", "info_fuel_tunnel_fallback_end", 0 );
    level thread function_d9bab593( "t_fuel_tunnel_right_door", "fueltunnel_spawnclosetdoor_3", "sp_fuel_tunnel_right_door", "info_fuel_tunnel_right_door", "info_fuel_tunnel_fallback_end" );
    level thread cp_prologue_util::function_8f7b1e06( "t_fueling_bridge_attacker", "info_fueling_bridge_attacker", "info_grenade_truck_guys_fallback" );
    level thread function_12ac9114();
    level.ai_hendricks waittill( #"hash_ff2562ea" );
    level thread cp_prologue_util::function_e0fb6da9( "s_enemy_moveup_point_0", 100, 15, 1, 1, 6, "info_fuel_tunnel_fallback_end", "info_grenade_truck_guys_fallback" );
    level thread cp_prologue_util::function_e0fb6da9( "s_enemy_moveup_point_1", 100, 15, 1, 1, 6, "info_fuel_tunnel_fallback_end", "info_grenade_truck_guys_fallback" );
    level thread cp_prologue_util::function_e0fb6da9( "s_enemy_moveup_point_2", 100, 15, 1, 1, 6, "info_fuel_tunnel_fallback_end", "info_grenade_truck_guys_fallback" );
    level thread cp_prologue_util::function_e0fb6da9( "s_enemy_moveup_point_forklift", -76, 8, 1, 1, 8, "info_fuel_tunnel_fallback_end", "info_grenade_truck_guys_fallback" );
    level thread cp_prologue_util::function_e0fb6da9( "s_enemy_moveup_point_4", 100, 5, 1, 1, 2, "info_fuel_tunnel_fallback_end", "info_grenade_truck_guys_fallback" );
    level thread cp_prologue_util::function_e0fb6da9( "s_enemy_moveup_point_5", 100, 5, 1, 1, 2, "info_fuel_tunnel_fallback_end", "info_grenade_truck_guys_fallback" );
    level thread function_50d18609();
}

// Namespace hostage_1
// Params 0
// Checksum 0x5547ba66, Offset: 0x27d8
// Size: 0x32
function function_b7afdf3a()
{
    trigger::wait_till( "t_fueling_tunnel_alert_enemy" );
    level flag::set( "fuel_tunnel_alerted" );
}

// Namespace hostage_1
// Params 0
// Checksum 0x309954ad, Offset: 0x2818
// Size: 0x8f
function function_e14a508d()
{
    a_ents = getentarray( "sp_fueling_stairwell_intro_guys", "targetname" );
    
    for ( i = 0; i < a_ents.size ; i++ )
    {
        e_ent = a_ents[ i ] spawner::spawn();
        e_ent.overrideactordamage = &function_e93a75b6;
        e_ent.goalradius = 32;
    }
    
    level notify( #"hash_db677f8c" );
}

// Namespace hostage_1
// Params 13
// Checksum 0xd5cb66aa, Offset: 0x28b0
// Size: 0x95
function function_e93a75b6( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname )
{
    if ( isdefined( eattacker ) && !isplayer( eattacker ) )
    {
        idamage = self.health + 1;
    }
    
    return idamage;
}

// Namespace hostage_1
// Params 0
// Checksum 0x3047c738, Offset: 0x2950
// Size: 0xd2
function function_88ddc4d5()
{
    level scene::add_scene_func( "p7_fxanim_cp_prologue_underground_truck_explode_bundle", &function_70b550de );
    level thread scene::play( "p7_fxanim_cp_prologue_underground_truck_explode_bundle" );
    level clientfield::set( "fuel_depot_truck_explosion", 1 );
    orig_explosion = getent( "orig_fuel_tunnel_explosion", "targetname" );
    level.ai_hendricks radiusdamage( orig_explosion.origin, 300, 2001, 2000, undefined, "MOD_EXPLOSIVE" );
}

// Namespace hostage_1
// Params 1
// Checksum 0xe55cc21b, Offset: 0x2a30
// Size: 0x7a
function function_70b550de( a_ents )
{
    a_ents[ "underground_truck_explode" ] waittill( #"hash_5ec0d21e" );
    a_ents[ "underground_truck_explode" ] setmodel( "veh_t7_civ_truck_med_cargo_egypt_dead" );
    var_f33f812b = getent( "fuel_truck_faxnim_clip", "targetname" );
    var_f33f812b solid();
}

// Namespace hostage_1
// Params 0
// Checksum 0x886b97bc, Offset: 0x2ab8
// Size: 0x2a
function function_f41e9505()
{
    wait 0.5;
    level thread cp_prologue_util::function_8f7b1e06( undefined, "info_grenade_truck_guys", "info_grenade_truck_guys_fallback" );
}

// Namespace hostage_1
// Params 0
// Checksum 0xdd4aa9df, Offset: 0x2af0
// Size: 0x19a
function function_ee3c7f46()
{
    trigger::wait_till( "t_spawn_machine_gunner" );
    m_door_r = getent( "fueltunnel_spawnclosetdoor_1", "targetname" );
    m_door_r rotateto( m_door_r.angles + ( 0, -150, 0 ), 0.5 );
    m_door_r playsound( "evt_spawner_door_open" );
    var_8e7793a5 = getent( "info_fuel_tunnel_fallback_end", "targetname" );
    a_ai = getentarray( "sp_fuel_tunnel_upper_door", "targetname" );
    a_players = getplayers();
    
    if ( a_players.size == 1 )
    {
        n_num_to_spawn = 1;
    }
    else if ( a_players.size == 2 )
    {
        n_num_to_spawn = 2;
    }
    else
    {
        n_num_to_spawn = 5;
    }
    
    if ( n_num_to_spawn > a_ai.size )
    {
        n_num_to_spawn = a_ai.size;
    }
    
    for ( i = 0; i < n_num_to_spawn ; i++ )
    {
        e_ent = a_ai[ i ] spawner::spawn();
        e_ent thread cp_prologue_util::ai_wakamole( 1024, undefined );
        wait 0.5;
    }
    
    level thread function_3964d78d();
}

// Namespace hostage_1
// Params 0
// Checksum 0x7e98ba47, Offset: 0x2c98
// Size: 0x212
function function_3964d78d()
{
    e_volume = getent( "info_final_tunnel_attackers", "targetname" );
    ready = 0;
    
    while ( !ready )
    {
        if ( level.ai_hendricks istouching( e_volume ) )
        {
            ready = 1;
        }
        
        a_players = getplayers();
        
        for ( i = 0; i < a_players.size ; i++ )
        {
            if ( a_players[ i ] istouching( e_volume ) )
            {
                ready = 1;
            }
        }
        
        wait 0.05;
    }
    
    a_sp = getentarray( "sp_fuel_tunnel_stairs_attackers", "targetname" );
    
    for ( i = 0; i < a_sp.size ; i++ )
    {
        e_ent = a_sp[ i ] spawner::spawn();
        nd_target = getnode( e_ent.target, "targetname" );
        e_ent.goalradius = -116;
        e_ent setgoal( nd_target.origin );
    }
    
    while ( true )
    {
        num_touching = cp_prologue_util::function_609c412a( "info_fuel_tunnel_upper_door", 1 );
        
        if ( !num_touching )
        {
            break;
        }
        
        wait 0.05;
    }
    
    m_door_r = getent( "fueltunnel_spawnclosetdoor_1", "targetname" );
    m_door_r rotateto( m_door_r.angles - ( 0, -150, 0 ), 0.5 );
    m_door_r playsound( "evt_spawner_door_close" );
}

// Namespace hostage_1
// Params 0
// Checksum 0x256ec75c, Offset: 0x2eb8
// Size: 0x472
function function_672c874()
{
    self function_8b6e6abe();
    level flag::wait_till( "start_grenade_roll" );
    level thread scene::play( "cin_pro_06_01_hostage_vign_rollgrenade", level.ai_hendricks );
    level util::delay( 0.5, undefined, &trigger::use, "t_script_color_allies_r510" );
    level.ai_hendricks waittill( #"hash_ff2562ea" );
    level thread cp_prologue_util::function_2a0bc326( level.ai_hendricks.origin, 0.65, 1.2, 800, 4 );
    level.ai_hendricks ai::set_pacifist( 0 );
    level.ai_hendricks ai::set_ignoreme( 0 );
    level.ai_hendricks ai::set_ignoreall( 0 );
    s_struct = struct::get( "s_truck_explosion_origin", "targetname" );
    physicsexplosionsphere( s_struct.origin, -1, -2, 0.3, 25, 400 );
    wait 0.1;
    var_ff31c6f9 = getentarray( "truck_red_barrel", "script_noteworthy" );
    
    foreach ( piece in var_ff31c6f9 )
    {
        if ( isdefined( piece ) && piece.targetname == "destructible" )
        {
            piece dodamage( 5000, piece.origin, level.ai_hendricks );
        }
    }
    
    wait 0.3;
    var_7bb33476 = getnode( "nd_grenade_throw", "targetname" );
    setenablenode( var_7bb33476, 0 );
    trigger::use( "t_script_color_allies_r520" );
    cp_prologue_util::function_d1f1caad( "t_script_color_allies_r530" );
    cp_prologue_util::function_d1f1caad( "t_script_color_allies_r540" );
    scene::play( "cin_pro_06_01_hostage_vign_jumpdown" );
    self colors::enable();
    self setgoal( self.origin );
    wait 1;
    trigger::use( "t_script_color_allies_r550" );
    wait 1;
    self waittill( #"goal" );
    self.goalradius = 256;
    cp_prologue_util::function_d1f1caad( "t_script_color_allies_r560" );
    function_7a05bbf();
    
    if ( getplayers().size == 1 )
    {
        level notify( #"hash_bf9ccb51" );
    }
    
    e_volume = getent( "info_fuel_tunnel_fallback_end", "targetname" );
    
    while ( true )
    {
        a_ai = cp_prologue_util::function_68b8f4af( e_volume );
        
        if ( a_ai.size < 1 )
        {
            break;
        }
        
        wait 0.05;
    }
    
    e_trigger = getent( "t_script_color_allies_r580", "targetname" );
    
    if ( isdefined( e_trigger ) )
    {
        e_trigger notify( #"trigger" );
    }
    
    function_1ddfda41();
    nd_node = getnode( "nd_fueling_tunnel_exit", "targetname" );
    self setgoal( nd_node.origin );
    self.goalradius = 64;
    self util::waittill_notify_or_timeout( "goal", 15 );
    self thread function_c9d7d48a();
}

// Namespace hostage_1
// Params 0
// Checksum 0x46106392, Offset: 0x3338
// Size: 0x89
function function_7a05bbf()
{
    while ( true )
    {
        e_trigger = getent( "t_script_color_allies_r570", "targetname" );
        
        if ( !isdefined( e_trigger ) )
        {
            break;
        }
        
        num_touching = cp_prologue_util::function_609c412a( "info_fuel_tunnel_fallback_end", 0 );
        
        if ( num_touching <= 3 )
        {
            trigger::use( "t_script_color_allies_r570" );
            break;
        }
        
        wait 0.05;
    }
}

// Namespace hostage_1
// Params 0
// Checksum 0x4f5d0ecb, Offset: 0x33d0
// Size: 0x18f
function function_1ddfda41()
{
    e_volume = getent( "info_fueling_tunnel_balcony", "targetname" );
    a_enemy = cp_prologue_util::function_68b8f4af( e_volume );
    
    for ( i = 0; i < a_enemy.size ; i++ )
    {
        self getperfectinfo( a_enemy[ i ], 1 );
        a_enemy[ i ].overrideactordamage = &function_e93a75b6;
    }
    
    nd_node = getnode( "nd_fueling_tunnel_top_stairs", "targetname" );
    self setgoal( nd_node.origin );
    self.goalradius = 64;
    self waittill( #"goal" );
    
    while ( true )
    {
        a_enemy = cp_prologue_util::function_68b8f4af( e_volume );
        
        if ( a_enemy.size == 0 )
        {
            break;
        }
        
        wait 0.05;
    }
    
    for ( a_ai_enemy = getaiteamarray( "axis" ); a_ai_enemy.size > 0 ; a_ai_enemy = getaiteamarray( "axis" ) )
    {
        a_ai_enemy[ 0 ] ai::bloody_death();
        wait randomfloatrange( 0.666667, 1.33333 );
    }
}

// Namespace hostage_1
// Params 0
// Checksum 0x3eac2fee, Offset: 0x3568
// Size: 0x9a
function function_50d18609()
{
    level waittill( #"hash_bf9ccb51" );
    a_nodes = getnodearray( "nd_fueling_end", "targetname" );
    
    for ( i = 0; i < a_nodes.size ; i++ )
    {
        nd_node = a_nodes[ i ];
        setenablenode( nd_node, 0 );
    }
    
    wait 2;
    cp_prologue_util::function_8f7b1e06( undefined, "info_fuel_tunnel_fallback_end", "info_fueling_flush_out_volume" );
}

// Namespace hostage_1
// Params 0
// Checksum 0xde8e68bc, Offset: 0x3610
// Size: 0x19a
function function_8b6e6abe()
{
    level flag::wait_till( "hendricks_exit_cam_room" );
    wait 0.5;
    level thread hend_fuel_depot_otr_dialog();
    self ai::set_behavior_attribute( "can_melee", 0 );
    self colors::disable();
    nd_node = getnode( "nd_hendricks_attack_fueling_start_guys", "targetname" );
    self.perfectaim = 1;
    self.goalradius = 32;
    self ai::force_goal( nd_node );
    wait 1;
    a_enemy = spawner::get_ai_group_ai( "tunnel_1st_contact_guys" );
    
    foreach ( enemy in a_enemy )
    {
        if ( isdefined( enemy ) && isalive( enemy ) )
        {
            self ai::shoot_at_target( "shoot_until_target_dead", enemy );
        }
    }
    
    spawner::waittill_ai_group_cleared( "tunnel_1st_contact_guys" );
    self.perfectaim = 0;
    self.goalradius = 512;
    self ai::set_behavior_attribute( "can_melee", 1 );
    self colors::enable();
}

// Namespace hostage_1
// Params 0
// Checksum 0x896e4268, Offset: 0x37b8
// Size: 0x202
function function_c9d7d48a()
{
    e_volume = getent( "info_fueling_tunnel_exit_area", "targetname" );
    
    while ( true )
    {
        num_players = cp_prologue_util::num_players_touching_volume( e_volume );
        
        if ( num_players > 0 )
        {
            break;
        }
        
        wait 0.05;
    }
    
    level thread namespace_21b2c1f2::function_d4c52995();
    wait 0.15;
    level scene::add_scene_func( "cin_pro_06_02_hostage_vign_getminister_hendricks_airlock", &function_5729b9e7, "play" );
    level scene::play( "cin_pro_06_02_hostage_vign_getminister_hendricks_airlock" );
    n_node = getnode( "nd_hendricks_jail_setup", "targetname" );
    level.ai_hendricks setgoal( n_node, 1 );
    wait 0.5;
    level notify( #"hash_5d08c61e" );
    s_struct = struct::get( "s_close_security_door", "targetname" );
    
    while ( true )
    {
        v_forward = anglestoforward( s_struct.angles );
        v_dir = vectornormalize( s_struct.origin - level.ai_hendricks.origin );
        dp = vectordot( v_forward, v_dir );
        
        if ( dp < 0 )
        {
            break;
        }
        
        wait 0.1;
    }
    
    cp_prologue_util::wait_for_all_players_to_pass_struct( "s_close_security_door", undefined );
    level thread function_6ae70954( 0 );
}

// Namespace hostage_1
// Params 1
// Checksum 0x2ad2c70c, Offset: 0x39c8
// Size: 0x2a
function function_5729b9e7( a_ents )
{
    level waittill( #"hash_5729b9e7" );
    level function_6ae70954( 1 );
}

// Namespace hostage_1
// Params 1
// Checksum 0x3fea1112, Offset: 0x3a00
// Size: 0x19a
function function_6ae70954( open_door )
{
    exploder::exploder( "fx_exploder_door_vacuum" );
    m_door1 = getent( "holdingcells_entrydoor_1", "targetname" );
    m_door2 = getent( "holdingcells_entrydoor_2", "targetname" );
    
    if ( open_door )
    {
        exploder::exploder( "light_exploder_prison_door" );
        m_door1 movex( 64, 1, 0.1, 0.2 );
        m_door1 playsound( "evt_fueldepot_door_open" );
        wait 0.25;
        m_door2 movex( 64, 1, 0.1, 0.2 );
        m_door2 playsound( "evt_fueldepot_door_open" );
        return;
    }
    
    exploder::stop_exploder( "light_exploder_prison_door" );
    m_door2 movex( -64, 1, 0.1, 0.2 );
    m_door2 playsound( "evt_fueldepot_door_close" );
    wait 0.25;
    m_door1 movex( -64, 1, 0.1, 0.2 );
    m_door1 playsound( "evt_fueldepot_door_close" );
}

// Namespace hostage_1
// Params 0
// Checksum 0x528f73e4, Offset: 0x3ba8
// Size: 0x2a
function watch_player_fire()
{
    self endon( #"death" );
    self waittill( #"weapon_fired" );
    level flag::set( "fuel_tunnel_alerted" );
}

// Namespace hostage_1
// Params 0
// Checksum 0x58100691, Offset: 0x3be0
// Size: 0x62
function hend_fuel_depot_otr_dialog()
{
    trigger::wait_till( "t_spawn_machine_gunner" );
    wait 1;
    level.ai_hendricks dialog::say( "hend_gunner_up_top_0" );
    level waittill( #"hash_5d08c61e" );
    level.ai_hendricks dialog::say( "hend_cell_block_ahead_on_0" );
}

// Namespace hostage_1
// Params 0
// Checksum 0x2c743fe7, Offset: 0x3c50
// Size: 0x3c
function spawn_machine_gunner()
{
    trigger::wait_till( "t_spawn_machine_gunner" );
    e_gunner = spawner::simple_spawn_single( "fuel_tunnel_mg_guy" );
}

// Namespace hostage_1
// Params 6
// Checksum 0x9242ef5d, Offset: 0x3c98
// Size: 0x1e2
function function_d9bab593( str_trigger, str_door, str_spawners, var_137809d6, var_343b0267, var_bfba634f )
{
    if ( !isdefined( var_bfba634f ) )
    {
        var_bfba634f = 1;
    }
    
    e_trigger = getent( str_trigger, "targetname" );
    e_trigger waittill( #"trigger" );
    e_door = getent( str_door, "targetname" );
    e_door rotateto( e_door.angles + ( 0, -110, 0 ), 0.5 );
    e_door playsound( "evt_spawner_door_open" );
    e_goal_volume = getent( var_343b0267, "targetname" );
    a_ai = getentarray( str_spawners, "targetname" );
    
    for ( i = 0; i < a_ai.size ; i++ )
    {
        e_ent = a_ai[ i ] spawner::spawn();
        e_ent setgoal( e_goal_volume );
        wait 1.5;
    }
    
    if ( !var_bfba634f )
    {
        return;
    }
    
    wait 1;
    
    while ( true )
    {
        num_touching = cp_prologue_util::function_609c412a( var_137809d6, 1 );
        
        if ( !num_touching )
        {
            break;
        }
        
        wait 0.05;
    }
    
    e_door rotateto( e_door.angles + ( 0, 110, 0 ), 0.5 );
    e_door playsound( "evt_spawner_door_close" );
}

// Namespace hostage_1
// Params 0
// Checksum 0x59b2e14a, Offset: 0x3e88
// Size: 0x13a
function function_12ac9114()
{
    sp_enemy = getent( "sp_stair_runners", "targetname" );
    e_volume = getent( "info_fuel_tunnel_fallback_end", "targetname" );
    level thread function_6ae70954( 1 );
    level flag::wait_till( "fuel_tunnel_stair_runners_1" );
    ai_enemy = sp_enemy spawner::spawn();
    ai_enemy setgoal( e_volume );
    wait 1.5;
    ai_enemy = sp_enemy spawner::spawn();
    ai_enemy setgoal( e_volume );
    level flag::wait_till( "fuel_tunnel_stair_runners_2" );
    ai_enemy = sp_enemy spawner::spawn();
    ai_enemy setgoal( e_volume );
    wait 3;
    level thread function_6ae70954( 0 );
}

#namespace prison;

// Namespace prison
// Params 1
// Checksum 0x9218876b, Offset: 0x3fd0
// Size: 0x1ea
function prison_start( str_objective )
{
    prison_precache();
    
    if ( !isdefined( level.ai_hendricks ) )
    {
        level.ai_hendricks = util::get_hero( "hendricks" );
        cp_mi_eth_prologue::init_hendricks( "skipto_prison_hendricks" );
        skipto::teleport_ai( str_objective );
    }
    
    if ( !isdefined( level.ai_minister ) )
    {
        level.ai_minister = util::get_hero( "minister" );
        level.ai_minister.ignoreme = 1;
        level.ai_minister.ignoreall = 1;
        cp_mi_eth_prologue::init_minister( "skipto_prison_minister" );
        level.ai_minister.goalradius = 64;
    }
    
    if ( !isdefined( level.ai_khalil ) )
    {
        level.ai_khalil = util::get_hero( "khalil" );
        level.ai_khalil.ignoreme = 1;
        level.ai_khalil.ignoreall = 1;
        cp_mi_eth_prologue::init_khalil( "skipto_prison_khalil" );
        level.ai_khalil.goalradius = 64;
    }
    
    trigger::use( "t_prison_respawns_disable", "targetname", undefined, 0 );
    battlechatter::function_d9f49fba( 0 );
    cp_prologue_util::function_47a62798( 1 );
    level.ai_hendricks.pacifist = 0;
    level.ai_hendricks.ignoreme = 0;
    level flag::init( "khalil_door_breached" );
    level flag::init( "player_interrogation_breach" );
    level thread prison_main();
}

// Namespace prison
// Params 0
// Checksum 0xe9c07cd6, Offset: 0x41c8
// Size: 0x2
function prison_precache()
{
    
}

// Namespace prison
// Params 0
// Checksum 0x28bb7819, Offset: 0x41d8
// Size: 0x11a
function prison_main()
{
    level thread cp_prologue_util::function_950d1c3b( 1 );
    level thread function_b317c15f();
    level thread scene::init( "cin_pro_06_03_hostage_1st_khalil_intro_rescue" );
    security_desk::function_bfe70f02();
    level thread function_f50dec65();
    level thread function_771ca4c3();
    var_beb17601 = getent( "collision_observation_door", "targetname" );
    var_ddb80384 = getent( "observation_door", "targetname" );
    var_beb17601 linkto( var_ddb80384 );
    level thread function_ef1899fb();
    level.ai_hendricks thread hendricks_update();
    level thread function_15c51270();
    level thread prisoner_dialog();
}

// Namespace prison
// Params 0
// Checksum 0x948b9796, Offset: 0x4300
// Size: 0x52
function function_f50dec65()
{
    level thread util::set_streamer_hint( 3 );
    level waittill( #"hash_516cb5e4" );
    util::clear_streamer_hint();
    level thread util::set_streamer_hint( 4 );
    level waittill( #"hash_29445f62" );
    util::clear_streamer_hint();
}

// Namespace prison
// Params 0
// Checksum 0xff401cd3, Offset: 0x4360
// Size: 0x1ba
function function_771ca4c3()
{
    objectives::set( "cp_level_prologue_free_the_minister" );
    callback::on_ai_killed( &prologue_accolades::function_c58a9e36 );
    level flag::wait_till( "player_entered_observation" );
    objectives::complete( "cp_level_prologue_goto_minister_door" );
    level waittill( #"hash_a859aef4" );
    objectives::complete( "cp_level_prologue_free_the_minister" );
    savegame::checkpoint_save();
    level waittill( #"khalil_available" );
    trigger::use( "t_prison_respawns_enable", "targetname", undefined, 0 );
    s_pos = struct::get( "s_objective_khalil_cell", "targetname" );
    objectives::set( "cp_level_prologue_goto_khalil_door", s_pos );
    objectives::set( "cp_level_prologue_free_khalil" );
    level flag::wait_till( "khalil_door_breached" );
    objectives::complete( "cp_level_prologue_goto_minister_door" );
    objectives::complete( "cp_level_prologue_free_khalil" );
    callback::remove_on_ai_killed( &prologue_accolades::function_c58a9e36 );
    objectives::set( "cp_level_prologue_get_to_the_surface" );
    level waittill( #"hendricks_by_weapon_room" );
    level thread objectives::breadcrumb( "post_prison_breadcrumb_start" );
}

// Namespace prison
// Params 0
// Checksum 0x95cf0252, Offset: 0x4528
// Size: 0xa2
function hendricks_update()
{
    nd_node = getnode( "nd_hendricks_jail_setup", "targetname" );
    self setgoal( nd_node, 1 );
    self waittill( #"goal" );
    level flag::wait_till( "post_up_minister_breach" );
    level thread function_a1ad4aa7();
    self sethighdetail( 1 );
    function_a859aef4();
    self sethighdetail( 0 );
}

// Namespace prison
// Params 0
// Checksum 0x81b5a66f, Offset: 0x45d8
// Size: 0x42
function function_22b149da()
{
    level waittill( #"hash_5ea48ae9" );
    level thread namespace_21b2c1f2::function_1c0460dd();
    level waittill( #"hash_35308140" );
    level.ai_hendricks dialog::say( "hend_depot_ahead_will_be_0" );
}

// Namespace prison
// Params 0
// Checksum 0xed202469, Offset: 0x4628
// Size: 0x22
function function_f48bd4a7()
{
    level waittill( #"hash_1dd905ef" );
    exploder::exploder( "light_exploder_prison_exit" );
}

// Namespace prison
// Params 0
// Checksum 0xf9a7215, Offset: 0x4658
// Size: 0x18b
function function_a859aef4()
{
    trig_khalil_door = getent( "trig_use_khalil_door", "targetname" );
    trig_khalil_door triggerenable( 0 );
    level thread scene::play( "cin_pro_06_03_hostage_vign_breach_hendrickscover" );
    level flag::wait_till( "player_entered_observation" );
    level thread function_b8c0a930();
    
    if ( isdefined( level.bzm_prologuedialogue4callback ) )
    {
        level thread [[ level.bzm_prologuedialogue4callback ]]();
    }
    
    level flag::wait_till_any( array( "interrogation_finished", "player_breached_early" ) );
    level thread scene::play( "cin_pro_06_03_hostage_vign_breach" );
    level thread scene::play( "cin_pro_06_03_hostage_vign_breach_hend_min" );
    level notify( #"hash_a859aef4" );
    level.ai_minister.overrideactordamage = undefined;
    level waittill( #"khalil_available" );
    trig_khalil_door triggerenable( 1 );
    var_d86e08d0 = util::init_interactive_gameobject( trig_khalil_door, &"cp_prompt_enteralt_prologue_khalil_breach", &"CP_MI_ETH_PROLOGUE_DOOR_BREACH", &function_28af2208 );
    var_d86e08d0 thread gameobjects::hide_icon_distance_and_los( ( 1, 1, 1 ), 800, 0 );
    level notify( #"hash_bd4342ed" );
}

// Namespace prison
// Params 0
// Checksum 0x91f498a1, Offset: 0x47f0
// Size: 0x3a
function function_db5cf0d5()
{
    self endon( #"death" );
    level endon( #"player_breached_early" );
    level endon( #"interrogation_finished" );
    self waittill( #"weapon_fired" );
    level flag::set( "player_breached_early" );
}

// Namespace prison
// Params 0
// Checksum 0x4c92f50b, Offset: 0x4838
// Size: 0x22
function function_a1ad4aa7()
{
    level waittill( #"hash_5e84ced9" );
    level clientfield::set( "interrogate_physics", 1 );
}

// Namespace prison
// Params 1
// Checksum 0x77e9e1a8, Offset: 0x4868
// Size: 0x132
function function_28af2208( e_player )
{
    self gameobjects::disable_object();
    array::run_all( level.players, &util::set_low_ready, 1 );
    callback::on_spawned( &cp_mi_eth_prologue::function_4d4f1d4f );
    level thread function_2137acd9();
    level flag::set( "khalil_door_breached" );
    level thread scene::play( "cin_pro_06_03_hostage_1st_khalil_intro_player_rescue", e_player );
    level thread scene::play( "cin_pro_06_03_hostage_1st_khalil_intro_rescue" );
    level.ai_khalil sethighdetail( 1 );
    level thread function_22b149da();
    level thread function_f48bd4a7();
    level waittill( #"hendricks_by_weapon_room" );
    level.ai_khalil sethighdetail( 0 );
    level notify( #"hash_29445f62" );
    skipto::objective_completed( "skipto_prison" );
}

// Namespace prison
// Params 0
// Checksum 0xaaeae8c, Offset: 0x49a8
// Size: 0x6a
function function_2137acd9()
{
    wait 42;
    array::run_all( level.players, &util::set_low_ready, 0 );
    callback::remove_on_spawned( &cp_mi_eth_prologue::function_4d4f1d4f );
    level thread cp_prologue_util::base_alarm_goes_off();
    level thread function_fae1bd07();
}

// Namespace prison
// Params 0
// Checksum 0xcf6366e2, Offset: 0x4a20
// Size: 0x4a
function function_fae1bd07()
{
    playsoundatposition( "amb_walla_troops_1", ( 6175, -1548, -157 ) );
    wait 8;
    playsoundatposition( "amb_walla_troops_0", ( 6129, -1037, -266 ) );
}

// Namespace prison
// Params 0
// Checksum 0x4adf8c8f, Offset: 0x4a78
// Size: 0x22
function function_b8c0a930()
{
    level.ai_minister.overrideactordamage = &function_9b720436;
}

// Namespace prison
// Params 13
// Checksum 0xfc244b2a, Offset: 0x4aa8
// Size: 0x103
function function_9b720436( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname )
{
    if ( isdefined( eattacker ) && isplayer( eattacker ) )
    {
        if ( isdefined( weapon ) && ( idamage <= 1 || weapon.isemp ) )
        {
            idamage = 0;
        }
        
        if ( !isdefined( self.var_28e02422 ) )
        {
            self.var_28e02422 = 0;
        }
        
        self.var_28e02422 = self.var_28e02422 + idamage;
        
        if ( self.var_28e02422 >= self.maxhealth )
        {
            util::missionfailedwrapper_nodeath( &"CP_MI_ETH_PROLOGUE_MINISTER_SHOT", &"SCRIPT_MISSIONFAIL_WATCH_FIRE" );
        }
        else
        {
            idamage = 0;
        }
    }
    
    return idamage;
}

// Namespace prison
// Params 0
// Checksum 0xd8c3d51d, Offset: 0x4bb8
// Size: 0x92
function function_ef1899fb()
{
    var_130a032 = getent( "trig_use_minister_door", "targetname" );
    var_130a032 triggerenable( 1 );
    var_e0897b20 = util::init_interactive_gameobject( var_130a032, &"cp_prompt_enteralt_prologue_minister_breach", &"CP_MI_ETH_PROLOGUE_DOOR_BREACH", &function_b0c29b02 );
    var_e0897b20 thread gameobjects::hide_icon_distance_and_los( ( 1, 1, 1 ), 800, 0 );
}

// Namespace prison
// Params 1
// Checksum 0x24b67580, Offset: 0x4c58
// Size: 0x12a
function function_b0c29b02( e_player )
{
    self.trigger triggerenable( 0 );
    self gameobjects::disable_object();
    
    foreach ( var_12195048 in level.activeplayers )
    {
        var_12195048 util::set_low_ready( 1 );
        var_12195048 thread function_db5cf0d5();
    }
    
    callback::on_spawned( &cp_mi_eth_prologue::function_4d4f1d4f );
    level flag::set( "player_interrogation_breach" );
    level scene::play( "cin_pro_06_03_hostage_vign_breach_playerbreach", e_player );
    level notify( #"hash_516cb5e4" );
    level thread dialog::player_say( "plyr_interrogator_has_his_0", 3 );
    level thread function_813f55a8();
}

// Namespace prison
// Params 1
// Checksum 0x74d5a199, Offset: 0x4d90
// Size: 0x52
function function_f8d7f50a( a_ents )
{
    e_door = a_ents[ "observation_door" ];
    e_door setmodel( "p7_door_metal_security_02_rt_keypad" );
    level waittill( #"hash_18c83555" );
    e_door setmodel( "p7_door_metal_security_02_rt_keypad_damage" );
}

// Namespace prison
// Params 0
// Checksum 0xc705a328, Offset: 0x4df0
// Size: 0xca
function function_b317c15f()
{
    level scene::add_scene_func( "cin_pro_06_03_hostage_vign_breach_interrogation", &function_b8d7b823, "init" );
    level scene::init( "cin_pro_06_03_hostage_vign_breach_interrogation" );
    level waittill( #"hash_5c0ece37" );
    scene::add_scene_func( "cin_pro_06_03_hostage_vign_breach_guardloop", &function_53775c4d, "play" );
    level thread scene::play( "cin_pro_06_03_hostage_vign_breach_guardloop" );
    level scene::play( "cin_pro_06_03_hostage_vign_breach_interrogation" );
    level flag::set( "interrogation_finished" );
}

// Namespace prison
// Params 1
// Checksum 0xc3fe0c2a, Offset: 0x4ec8
// Size: 0x122
function function_b8d7b823( a_ents )
{
    a_ents[ "interrogator" ].cybercomtargetstatusoverride = 0;
    a_ents[ "interrogator" ] cybercom::cybercom_aioptout( "cybercom_fireflyswarm" );
    level waittill( #"ready_to_breach" );
    level.ai_hendricks dialog::say( "hend_on_my_mark_0" );
    wait 1;
    level.ai_hendricks thread dialog::say( "hend_three_two_go_0" );
    level thread namespace_21b2c1f2::function_2f85277b();
    wait 1;
    
    foreach ( e_player in level.activeplayers )
    {
        e_player util::set_low_ready( 0 );
    }
    
    callback::remove_on_spawned( &cp_mi_eth_prologue::function_4d4f1d4f );
}

// Namespace prison
// Params 1
// Checksum 0x8eee1f03, Offset: 0x4ff8
// Size: 0x83
function function_53775c4d( a_ents )
{
    foreach ( ai_guard in a_ents )
    {
        ai_guard.var_c54411a6 = 1;
        ai_guard.cybercomtargetstatusoverride = 0;
        ai_guard cybercom::cybercom_aioptout( "cybercom_fireflyswarm" );
    }
}

// Namespace prison
// Params 0
// Checksum 0xee474c55, Offset: 0x5088
// Size: 0xba
function function_813f55a8()
{
    trigger::wait_till( "trig_dam_int_room" );
    level thread cp_prologue_util::function_2a0bc326( level.ai_hendricks.origin, 0.3, 0.75, 5000, 10, "damage_heavy" );
    var_d3079b09 = getent( "int_room_sound_wall", "targetname" );
    var_d3079b09 delete();
    hidemiscmodels( "interrogation_glass_hologram" );
    exploder::exploder( "fx_exploder_glass_screen" );
}

// Namespace prison
// Params 0
// Checksum 0xf5780d6c, Offset: 0x5150
// Size: 0x52
function function_15c51270()
{
    level thread function_88b82e8a();
    level waittill( #"hash_a859aef4" );
    level thread function_b1d2594d();
    level flag::wait_till( "khalil_door_breached" );
    level thread namespace_21b2c1f2::function_fb4a2ce1();
}

// Namespace prison
// Params 0
// Checksum 0x5abfd218, Offset: 0x51b0
// Size: 0x2a
function function_88b82e8a()
{
    level endon( #"player_interrogation_breach" );
    wait 17;
    level.ai_hendricks dialog::say( "hend_that_exfil_won_t_wai_0" );
}

// Namespace prison
// Params 0
// Checksum 0x1a70cd69, Offset: 0x51e8
// Size: 0x52
function function_b1d2594d()
{
    level endon( #"khalil_door_breached" );
    level waittill( #"hash_bd4342ed" );
    wait 20;
    level.ai_hendricks dialog::say( "hend_sooner_we_get_khalil_0" );
    wait 15;
    level.ai_hendricks dialog::say( "hend_they_re_gonna_be_on_0" );
}

// Namespace prison
// Params 0
// Checksum 0x6edf640, Offset: 0x5248
// Size: 0x82
function prisoner_dialog()
{
    level thread cell_prisoner_message_update( "trig_volume_prisoner1_cell", "pris_please_please_help_0" );
    level thread cell_prisoner_message_update( "trig_volume_prisoner2_cell", "pris_get_us_out_of_here_0" );
    level thread cell_prisoner_message_update( "trig_volume_prisoner3_cell", "pris_don_t_leave_me_here_0" );
    level thread cell_prisoner_message_update( "trig_volume_prisoner4_cell", "pris_please_help_us_0" );
}

// Namespace prison
// Params 2
// Checksum 0x391ee0da, Offset: 0x52d8
// Size: 0x4a
function cell_prisoner_message_update( str_trigger, str_vo )
{
    level trigger::wait_till( str_trigger, "targetname", undefined, 0 );
    level.ai_hendricks dialog::say( str_vo );
}

#namespace security_desk;

// Namespace security_desk
// Params 1
// Checksum 0xab1a4b84, Offset: 0x5330
// Size: 0xda
function security_desk_start( str_objective )
{
    security_desk_precache();
    level.ai_hendricks ai::set_ignoreall( 0 );
    level.ai_minister ai::set_ignoreall( 0 );
    battlechatter::function_d9f49fba( 1 );
    cp_prologue_util::function_47a62798( 1 );
    spawner::add_spawn_function_group( "bridge_attacker", "script_noteworthy", &hangar::ai_think );
    level thread security_desk_main();
    trigger::wait_till( "t_start_lift_battle" );
    skipto::objective_completed( "skipto_security_desk" );
}

// Namespace security_desk
// Params 0
// Checksum 0xe9c07cd6, Offset: 0x5418
// Size: 0x2
function security_desk_precache()
{
    
}

// Namespace security_desk
// Params 0
// Checksum 0x796fef08, Offset: 0x5428
// Size: 0xaa
function security_desk_main()
{
    level thread cp_prologue_util::function_950d1c3b( 1 );
    level thread function_e6af47cb();
    level thread function_5e374f7a();
    trig_weapon_room_door = getent( "trig_open_weapons_room", "targetname" );
    trig_weapon_room_door triggerenable( 1 );
    level flag::wait_till( "open_weapons_room" );
    level thread namespace_21b2c1f2::function_6c35b4f3();
    level thread bioweapon_objective_handler();
}

// Namespace security_desk
// Params 0
// Checksum 0xa6dd6f3a, Offset: 0x54e0
// Size: 0x2a
function function_bfe70f02()
{
    if ( !isdefined( level.var_e5ed7cda ) )
    {
        scene::init( "cin_pro_07_01_securitydesk_vign_weapons_doorinit" );
        level.var_e5ed7cda = 1;
    }
}

// Namespace security_desk
// Params 0
// Checksum 0xa6a78bf5, Offset: 0x5518
// Size: 0x62
function function_5e374f7a()
{
    level flag::wait_till( "open_weapons_room" );
    level waittill( #"hash_ecefb6c8" );
    level thread function_4fd5aaec();
    wait 1;
    level thread function_bce54c0b();
    level thread function_36113d75();
    level thread function_680575de();
}

// Namespace security_desk
// Params 0
// Checksum 0x8257fd34, Offset: 0x5588
// Size: 0x201
function function_4fd5aaec()
{
    a_ai = getentarray( "sp_armory_lift_area_1st_attacker", "targetname" );
    
    for ( i = 0; i < a_ai.size ; i++ )
    {
        e_ent = a_ai[ i ] spawner::spawn();
        nd_node = getnode( e_ent.target, "targetname" );
        e_ent.goalradius = 64;
        e_ent setgoal( nd_node.origin );
        e_ent thread cp_prologue_util::ai_wakamole( 256, 1 );
    }
    
    e_volume = getent( "info_armory_enemy_pushup", "targetname" );
    a_ai = getentarray( "sp_armory_lift_area_attackers", "targetname" );
    
    for ( i = 0; i < a_ai.size ; i++ )
    {
        e_ent = a_ai[ i ] spawner::spawn();
        e_ent setgoal( e_volume );
        e_ent thread cp_prologue_util::ai_wakamole( 512, 1 );
    }
    
    e_volume = getent( "info_armory_wave2", "targetname" );
    a_ai = getentarray( "sp_armory_lift_area_attackers_part2", "targetname" );
    
    for ( i = 0; i < a_ai.size ; i++ )
    {
        e_ent = a_ai[ i ] spawner::spawn();
        e_ent setgoal( e_volume );
        e_ent thread cp_prologue_util::ai_wakamole( 512, 1 );
    }
}

// Namespace security_desk
// Params 0
// Checksum 0x184ea2be, Offset: 0x5798
// Size: 0x7a
function function_bce54c0b()
{
    a_spawners = getentarray( "sp_armory_walkway_attackers", "targetname" );
    
    for ( i = 0; i < a_spawners.size ; i++ )
    {
        e_ent = a_spawners[ i ] spawner::spawn();
        wait 1.5;
    }
    
    wait 3;
    level thread function_ad03757a();
}

// Namespace security_desk
// Params 0
// Checksum 0xe8839630, Offset: 0x5820
// Size: 0x92
function function_36113d75()
{
    level thread cp_prologue_util::function_e0fb6da9( "s_armory_moveup_start", -16, 7, 1, 1, 3, "info_armory_wave2", "info_armory_enemy_pushup" );
    level thread cp_prologue_util::function_e0fb6da9( "s_armory_moveup_point_left", -16, 4, 1, 1, 6, "info_armory_wave2", "info_armory_enemy_pushup" );
    level thread cp_prologue_util::function_e0fb6da9( "s_armory_moveup_point_right", -16, 4, 1, 1, 6, "info_armory_wave2", "info_armory_enemy_pushup" );
}

// Namespace security_desk
// Params 0
// Checksum 0x4eefc4cc, Offset: 0x58c0
// Size: 0xf2
function function_e6af47cb()
{
    level flag::wait_till( "open_weapons_room" );
    level.ai_hendricks setgoal( level.ai_hendricks.origin );
    level.ai_hendricks clearforcedgoal();
    level.ai_hendricks.goalradius = 64;
    level thread function_473b7de8();
    wait 2;
    trigger::use( "trig_armory_color" );
    cp_prologue_util::function_d1f1caad( "t_script_color_allies_r2010" );
    cp_prologue_util::function_d1f1caad( "t_script_color_allies_r2020" );
    cp_prologue_util::function_d1f1caad( "t_script_color_allies_r2030" );
    cp_prologue_util::function_d1f1caad( "t_script_color_allies_r2040" );
}

// Namespace security_desk
// Params 0
// Checksum 0xb51a58fa, Offset: 0x59c0
// Size: 0xf6
function function_473b7de8()
{
    while ( !scene::is_ready( "cin_pro_07_01_securitydesk_vign_weapons" ) )
    {
        wait 0.05;
    }
    
    scene::add_scene_func( "cin_pro_07_01_securitydesk_vign_weapons", &function_d4401b52 );
    scene::play( "cin_pro_07_01_securitydesk_vign_weapons" );
    level notify( #"hash_69db142c" );
    nd_node = getnode( "nd_khalil_armory_battle", "targetname" );
    level.ai_khalil.goalradius = 64;
    level.ai_khalil setgoal( nd_node.origin );
    level.ai_khalil waittill( #"goal" );
    level.ai_khalil.goalradius = 512;
}

// Namespace security_desk
// Params 1
// Checksum 0x78a9c0c5, Offset: 0x5ac0
// Size: 0xc2
function function_d4401b52( a_ents )
{
    level endon( #"security_desk_done" );
    level.ai_minister ai::gun_remove();
    level.ai_khalil ai::gun_remove();
    level.ai_minister waittill( #"weapon_swap" );
    a_ents[ "arak_m" ] hide();
    level.ai_minister ai::gun_recall();
    level.ai_khalil waittill( #"hash_2dc522e9" );
    a_ents[ "arak_k" ] hide();
    level.ai_khalil ai::gun_recall();
}

// Namespace security_desk
// Params 0
// Checksum 0x40d00e9f, Offset: 0x5b90
// Size: 0x9e
function function_ad03757a()
{
    wait 3;
    a_ai = spawner::get_ai_group_ai( "security_balcony" );
    
    if ( a_ai.size > 0 )
    {
        var_b5dd40c7 = array::random( a_ai );
        var_b5dd40c7 scene::play( "cin_pro_07_01_securitydesk_vign_dropdown", var_b5dd40c7 );
        
        if ( isalive( var_b5dd40c7 ) )
        {
            var_b5dd40c7 setgoal( var_b5dd40c7.origin );
            var_b5dd40c7.goalradius = 512;
        }
    }
}

// Namespace security_desk
// Params 0
// Checksum 0xf40f507f, Offset: 0x5c38
// Size: 0x89
function function_680575de()
{
    cp_prologue_util::function_520255e3( "t_armory_wave2", 5 );
    a_sp = getentarray( "sp_armory_wave2", "targetname" );
    
    for ( i = 0; i < a_sp.size ; i++ )
    {
        e_ent = a_sp[ i ] spawner::spawn();
        e_ent thread function_2fa59109();
    }
}

// Namespace security_desk
// Params 0
// Checksum 0xe14dcf62, Offset: 0x5cd0
// Size: 0x42
function function_2fa59109()
{
    e_volume = getent( "info_armory_wave2", "targetname" );
    self setgoal( e_volume );
}

// Namespace security_desk
// Params 0
// Checksum 0xa2e25c04, Offset: 0x5d20
// Size: 0x22
function need_weapon_message()
{
    level.ai_khalil thread dialog::say( "khal_i_need_to_get_my_wea_0" );
}

// Namespace security_desk
// Params 0
// Checksum 0xafdbcca4, Offset: 0x5d50
// Size: 0x42
function bioweapon_objective_handler()
{
    objectives::set( "cp_level_prologue_defend_khalil", level.ai_khalil );
    level waittill( #"hash_69db142c" );
    objectives::complete( "cp_level_prologue_defend_khalil" );
}

#namespace lift_escape;

// Namespace lift_escape
// Params 0
// Checksum 0x9aa4b3ee, Offset: 0x5da0
// Size: 0x52
function lift_escape_precache()
{
    level flag::init( "lift_arrived" );
    level flag::init( "crane_in_position" );
    level flag::init( "crane_dropped" );
    level.var_1dd14818 = 0;
}

// Namespace lift_escape
// Params 1
// Checksum 0x180edd31, Offset: 0x5e00
// Size: 0x2e2
function lift_escape_start( str_objective )
{
    lift_escape_precache();
    
    if ( !isdefined( level.ai_hendricks ) )
    {
        level.ai_hendricks = util::get_hero( "hendricks" );
        cp_mi_eth_prologue::init_hendricks();
        level.ai_hendricks.goalradius = 16;
        level.ai_minister = util::get_hero( "minister" );
        cp_mi_eth_prologue::init_minister();
        level.ai_minister ai::set_ignoreme( 1 );
        level.ai_khalil = util::get_hero( "khalil" );
        cp_mi_eth_prologue::init_khalil();
        level.ai_khalil ai::set_ignoreme( 1 );
        skipto::teleport_ai( str_objective );
    }
    
    callback::on_ai_killed( &prologue_accolades::function_cbaf37cd );
    t_regroup_lift = getent( "t_regroup_lift", "targetname" );
    t_regroup_lift triggerenable( 0 );
    trigger::use( "t_lift_respawns_disable" );
    exploder::stop_exploder( "light_exploder_prison_exit" );
    level.ai_hendricks ai::set_ignoreall( 0 );
    level.ai_minister ai::set_ignoreall( 0 );
    battlechatter::function_d9f49fba( 1 );
    cp_prologue_util::function_47a62798( 1 );
    level thread function_9793598c();
    level thread function_5517d018();
    level thread function_6fabe3da();
    level thread function_b17bd9c5();
    function_e97f7dba();
    t_regroup_lift = getent( "t_regroup_lift", "targetname" );
    t_regroup_lift triggerenable( 1 );
    trigger::use( "t_lift_respawns_enable" );
    level thread function_a3dbf6a2();
    level thread lift_escape_cleanup();
    level waittill( #"hash_b100689e" );
    callback::remove_on_ai_killed( &prologue_accolades::function_cbaf37cd );
    skipto::objective_completed( "skipto_lift_escape" );
}

// Namespace lift_escape
// Params 0
// Checksum 0x757b4eac, Offset: 0x60f0
// Size: 0x242
function function_9793598c()
{
    level thread function_b1017ede();
    level thread cp_prologue_util::function_e0fb6da9( "s_lift_enemy_moveup_point_1", -126, 10, 1, 2, 10, "v_lift_fallback", "info_lift_start_right_side" );
    level thread function_eeb1c74e();
    level thread function_30a5bc5();
    level thread function_c8950894();
    level thread function_a86c4e88();
    level thread cp_prologue_util::function_40e4b0cf( "sm_lift_start_left_side", "sp_lift_start_left_side", "info_lift_start_left_side" );
    
    if ( level.activeplayers.size > 1 )
    {
        level thread cp_prologue_util::function_40e4b0cf( "sm_lift_start_right_side", "sp_lift_start_right_side", "info_lift_start_right_side" );
    }
    else
    {
        spawn_manager::kill( "sm_lift_start_right_side" );
    }
    
    level thread function_8a1821e( "t_left_start_fallback", "info_left_start_fallback", "v_lift_fallback" );
    level thread function_8a1821e( "t_right_start_fallback", "info_lift_start_right_side", "v_lift_fallback" );
    level thread function_8949fadf();
    level thread function_51da5fc6();
    trigger::wait_till( "t_lift_reinforcements", undefined, undefined, 0 );
    a_spawners = getentarray( "sp_stairs_guy_wave2", "targetname" );
    
    foreach ( sp_spawner in a_spawners )
    {
        sp_spawner spawner::spawn();
    }
    
    level thread cp_prologue_util::function_40e4b0cf( "sm_lift_final_attackers", "sp_lift_final_attackers", "v_lift_fallback" );
    level thread function_93c4d161();
}

// Namespace lift_escape
// Params 0
// Checksum 0xf67e4a27, Offset: 0x6340
// Size: 0x1a5
function function_b1017ede()
{
    level endon( #"hash_631a1949" );
    a_players = getplayers();
    
    if ( a_players.size > 1 )
    {
        return;
    }
    
    start_time = gettime();
    var_c2798c63 = getent( "info_lift_players_camping", "targetname" );
    var_a9dae27c = getent( "info_lift_area_volume", "targetname" );
    
    while ( true )
    {
        e_player = getplayers()[ 0 ];
        time = gettime();
        
        if ( e_player istouching( var_c2798c63 ) )
        {
            dt = ( time - start_time ) / 1000;
            
            if ( dt > 15 )
            {
                var_f2c0d323 = 0;
                a_enemy = cp_prologue_util::function_68b8f4af( var_a9dae27c );
                
                for ( i = 0; i < a_enemy.size ; i++ )
                {
                    e_enemy = a_enemy[ i ];
                    
                    if ( !isdefined( e_enemy.var_4383fc69 ) )
                    {
                        e_enemy.var_4383fc69 = 1;
                        e_enemy.goalradius = -56;
                        e_enemy setgoal( e_player.origin );
                        start_time = time;
                        var_f2c0d323 = 1;
                        break;
                    }
                }
                
                if ( !var_f2c0d323 )
                {
                    return;
                }
            }
        }
        else
        {
            start_time = time;
        }
        
        wait 0.05;
    }
}

// Namespace lift_escape
// Params 0
// Checksum 0x4904e822, Offset: 0x64f0
// Size: 0x3a
function function_a86c4e88()
{
    cp_prologue_util::function_d1f1caad( "t_lift_intro_runners" );
    wait 10;
    level thread cp_prologue_util::function_a7eac508( "sp_lift_intro_rightside_backup", undefined, undefined, undefined );
}

// Namespace lift_escape
// Params 0
// Checksum 0x68b8c536, Offset: 0x6538
// Size: 0x1c9
function function_eeb1c74e()
{
    level flag::wait_till( "lift_arrived" );
    wait 10;
    var_91737097 = getent( "info_lift_area_volume", "targetname" );
    var_2320a476 = getent( "info_lift_start_area_volume", "targetname" );
    
    while ( true )
    {
        if ( isdefined( level.var_1f5f8798 ) && level.var_1f5f8798 )
        {
            return;
        }
        
        a_ai = getaiteamarray( "axis" );
        count = 0;
        
        for ( i = 0; i < a_ai.size ; i++ )
        {
            if ( a_ai[ i ] istouching( var_2320a476 ) )
            {
                count++;
            }
        }
        
        if ( count <= 2 )
        {
            break;
        }
        
        wait 0.05;
    }
    
    a_ai = getaiteamarray( "axis" );
    a_enemy = [];
    
    for ( i = 0; i < a_ai.size ; i++ )
    {
        e_ent = a_ai[ i ];
        
        if ( e_ent istouching( var_91737097 ) && !e_ent istouching( var_2320a476 ) )
        {
            a_enemy[ a_enemy.size ] = e_ent;
        }
    }
    
    count = a_enemy.size;
    
    if ( count > 3 )
    {
        count = 3;
    }
    
    for ( i = 0; i < count ; i++ )
    {
        e_ent = a_enemy[ i ];
        e_ent setgoal( var_2320a476 );
    }
}

// Namespace lift_escape
// Params 0
// Checksum 0xbb0fb040, Offset: 0x6710
// Size: 0x32
function function_30a5bc5()
{
    cp_prologue_util::function_d1f1caad( "t_lift_intro_runners" );
    level thread cp_prologue_util::function_a7eac508( "sp_lift_intro_runners", 64, 64, undefined );
}

// Namespace lift_escape
// Params 0
// Checksum 0x37d4722, Offset: 0x6750
// Size: 0x32
function function_c8950894()
{
    cp_prologue_util::function_d1f1caad( "t_intro_guys_on_bridge" );
    cp_prologue_util::function_73acb160( "sp_lift_stairs_intro_guys", undefined );
}

// Namespace lift_escape
// Params 0
// Checksum 0xe2259114, Offset: 0x6790
// Size: 0x192
function function_b17bd9c5()
{
    level.ai_hendricks.script_accuracy = 0.6;
    level.ai_minister.script_accuracy = 0.6;
    level.ai_khalil.script_accuracy = 0.6;
    level thread function_17d64396();
    trigger::use( "t_script_color_allies_r920" );
    trigger::wait_till( "t_script_color_allies_r950" );
    level flag::wait_till( "crane_in_position" );
    
    if ( !level flag::get( "crane_dropped" ) )
    {
        e_target = util::spawn_model( "tag_origin", struct::get( "s_destroy_pipes", "targetname" ).origin );
        e_target.health = 1000;
        level.ai_hendricks ai::shoot_at_target( "normal", e_target, "tag_origin", 3 );
        e_target delete();
        t_damage = getent( "crane_damage_trigger", "targetname" );
        
        if ( isdefined( t_damage ) )
        {
            t_damage useby( level.ai_hendricks );
        }
    }
}

// Namespace lift_escape
// Params 0
// Checksum 0x4541d9d2, Offset: 0x6930
// Size: 0x149
function function_e97f7dba()
{
    spawner::waittill_ai_group_cleared( "lift_area" );
    level thread namespace_21b2c1f2::function_49fef8f4();
    level thread function_d4734ff1();
    level thread function_6f04ae03();
    level.ai_hendricks thread send_hendricks_to_lift();
    level.ai_khalil thread function_f92b76b7();
    level.ai_minister thread function_c3ab179b();
    level flag::wait_till( "hendricks_in_lift" );
    level flag::wait_till( "minister_in_lift" );
    level flag::wait_till( "khalil_in_lift" );
    
    while ( !level scene::is_ready( "cin_pro_09_01_intro_1st_cybersoldiers_diaz_attack" ) || !level scene::is_ready( "cin_pro_09_01_intro_1st_cybersoldiers_maretti_attack" ) || !level scene::is_ready( "cin_pro_09_01_intro_1st_cybersoldiers_sarah_attack" ) || !level scene::is_ready( "cin_pro_09_01_intro_1st_cybersoldiers_taylor_attack" ) )
    {
        wait 0.05;
    }
}

// Namespace lift_escape
// Params 0
// Checksum 0x8ba7c4e1, Offset: 0x6a88
// Size: 0xd2
function function_17d64396()
{
    cp_prologue_util::function_d1f1caad( "entering_lift_fight" );
    start_time = gettime();
    
    while ( true )
    {
        time = gettime();
        dt = ( time - start_time ) / 1000;
        
        if ( dt > 10 )
        {
            num_touching = cp_prologue_util::function_609c412a( "info_lift_start_area_volume", 0 );
            
            if ( num_touching <= 2 )
            {
                break;
            }
        }
        
        wait 0.05;
    }
    
    e_trigger = getent( "t_script_color_allies_r930", "targetname" );
    
    if ( isdefined( e_trigger ) )
    {
        trigger::use( "t_script_color_allies_r930" );
    }
}

// Namespace lift_escape
// Params 3
// Checksum 0xfd168f2e, Offset: 0x6b68
// Size: 0x101
function function_8a1821e( str_trigger, var_fc9c675e, var_62ec3b42 )
{
    e_trigger = getent( str_trigger, "targetname" );
    
    if ( isdefined( e_trigger ) )
    {
        e_trigger waittill( #"trigger" );
    }
    
    var_cc6832b6 = getent( var_fc9c675e, "targetname" );
    var_97e01c0a = getent( var_62ec3b42, "targetname" );
    a_ai = getaiteamarray( "axis" );
    
    for ( i = 0; i < a_ai.size ; i++ )
    {
        e_ent = a_ai[ i ];
        
        if ( e_ent istouching( var_cc6832b6 ) )
        {
            e_ent setgoalvolume( var_97e01c0a );
        }
    }
}

// Namespace lift_escape
// Params 0
// Checksum 0xd18d2f5f, Offset: 0x6c78
// Size: 0x62
function function_d4734ff1()
{
    level thread scene::init( "cin_pro_09_01_intro_1st_cybersoldiers_diaz_attack" );
    level thread scene::init( "cin_pro_09_01_intro_1st_cybersoldiers_maretti_attack" );
    level thread scene::init( "cin_pro_09_01_intro_1st_cybersoldiers_sarah_attack" );
    level thread scene::init( "cin_pro_09_01_intro_1st_cybersoldiers_taylor_attack" );
}

// Namespace lift_escape
// Params 0
// Checksum 0x2e191f02, Offset: 0x6ce8
// Size: 0x2f6
function function_a3dbf6a2()
{
    trigger::wait_till( "t_lift_interior" );
    var_d39a9d5b = getent( "player_lift_clip", "targetname" );
    var_d39a9d5b movez( 124, 0.05 );
    level.var_5b3ac1ed = 1;
    level scene::add_scene_func( "cin_pro_09_01_intro_1st_cybersoldiers_elevator_ride", &intro_cyber_soldiers::function_679e7da9, "play" );
    level thread scene::play( "cin_pro_09_01_intro_1st_cybersoldiers_lift_pushbutton" );
    level.ai_minister.goalradius = 16;
    level.ai_minister.goalheight = 1600;
    level.ai_minister setgoal( level.ai_minister.origin );
    level.ai_khalil.goalradius = 16;
    level.ai_khalil.goalheight = 1600;
    level.ai_khalil setgoal( level.ai_khalil.origin );
    level notify( #"lift_is_moving" );
    level thread function_45ed0d4b( 0, 1.5 );
    level waittill( #"hash_9e4059e6" );
    level.e_lift = getent( "freight_lift", "targetname" );
    level.e_lift setmovingplatformenabled( 1 );
    level.e_lift playsound( "evt_freight_lift_start" );
    level.snd_lift = spawn( "script_origin", level.e_lift.origin );
    level.snd_lift linkto( level.e_lift );
    level.snd_lift playloopsound( "evt_freight_lift_loop" );
    level thread function_4d214c02( 1 );
    level thread function_e19320a1( 1 );
    level.e_lift thread scene::play( "cin_pro_09_01_intro_1st_cybersoldiers_elevator" );
    level.var_3dce3f88 movez( 270, 16.3 );
    level.var_3dce3f88 thread function_5bd223b0();
    wait 16.3 - 2;
    setdvar( "grenadeAllowRigidBodyPhysics", "1" );
    level notify( #"hash_b100689e" );
    level.var_b100689e = 1;
}

// Namespace lift_escape
// Params 0
// Checksum 0xdd88bf7b, Offset: 0x6fe8
// Size: 0xf1
function function_5bd223b0()
{
    self endon( #"death" );
    self waittill( #"movedone" );
    t_bottom = getent( "t_lift_interior", "targetname" );
    a_s_spots = struct::get_array( "lift_left_behind", "targetname" );
    
    for ( i = 0; i < level.activeplayers.size ; i++ )
    {
        player = level.activeplayers[ i ];
        
        if ( player istouching( t_bottom ) )
        {
            player setorigin( a_s_spots[ i ].origin );
            player setplayerangles( a_s_spots[ i ].angles );
        }
    }
}

// Namespace lift_escape
// Params 1
// Checksum 0x9103a032, Offset: 0x70e8
// Size: 0x12a
function function_e19320a1( n_delay )
{
    if ( !isdefined( n_delay ) )
    {
        n_delay = 0.05;
    }
    
    wait n_delay;
    exploder::stop_exploder( "light_exploder_lift_inside" );
    exploder::exploder( "light_exploder_lift_rising" );
    exploder::exploder( "light_exploder_igc_cybersoldier" );
    exploder::exploder( "fx_exploder_door_open_dust" );
    mdl_door_left = getent( "hangar_lift_door_left", "targetname" );
    mdl_door_right = getent( "hangar_lift_door_right", "targetname" );
    playsoundatposition( "evt_freight_lift_abovedoor", mdl_door_right.origin );
    mdl_door_left movey( 104, 5 );
    mdl_door_right movey( 104 * -1, 5 );
}

// Namespace lift_escape
// Params 1
// Checksum 0xfb0aba5b, Offset: 0x7220
// Size: 0x13d
function function_4d214c02( delay )
{
    wait delay;
    
    while ( !( isdefined( level.var_b100689e ) && level.var_b100689e ) )
    {
        foreach ( player in level.players )
        {
            player playrumbleonentity( "cp_prologue_rumble_lift" );
        }
        
        wait 0.5;
    }
    
    start_time = gettime();
    
    while ( true )
    {
        time = gettime();
        dt = ( time - start_time ) / 1000;
        
        if ( dt > 8 )
        {
            break;
        }
        
        foreach ( player in level.players )
        {
            player playrumbleonentity( "cp_prologue_rumble_lift" );
        }
        
        wait 0.5;
    }
}

// Namespace lift_escape
// Params 0
// Checksum 0x7f4e1c0a, Offset: 0x7368
// Size: 0x2a
function function_17ecef2()
{
    self.script_accuracy = 0.5;
    self.overrideactordamage = &function_10ffa58e;
}

// Namespace lift_escape
// Params 13
// Checksum 0xb0ca54ea, Offset: 0x73a0
// Size: 0xa2
function function_10ffa58e( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname )
{
    if ( self.health - idamage <= 0 )
    {
        if ( isdefined( eattacker ) && isplayer( eattacker ) )
        {
            eattacker notify( #"hash_38f375b6" );
        }
    }
    
    return idamage;
}

// Namespace lift_escape
// Params 0
// Checksum 0x48f86ffd, Offset: 0x7450
// Size: 0xc1
function lift_escape_cleanup()
{
    level waittill( #"hash_b100689e" );
    wait 2;
    
    if ( isdefined( level.str_guard_lift ) )
    {
        cp_mi_eth_prologue::deletegroupdelete( level.str_guard_lift );
    }
    
    if ( isdefined( level.str_guards_at_elevator ) )
    {
        cp_mi_eth_prologue::deletegroupdelete( level.str_guards_at_elevator );
    }
    
    level.ai_minister.goalheight = 80;
    level.ai_khalil.goalheight = 80;
    a_ai = getaiteamarray( "axis" );
    
    for ( i = 0; i < a_ai.size ; i++ )
    {
        a_ai[ i ] delete();
    }
}

// Namespace lift_escape
// Params 2
// Checksum 0xf243dd38, Offset: 0x7520
// Size: 0xb3
function cleanup( spawn_mgr_name, ai_groups_name )
{
    spawn_manager::kill( spawn_mgr_name );
    var_db932442 = spawner::get_ai_group_ai( ai_groups_name );
    
    foreach ( ai_dude in var_db932442 )
    {
        if ( isalive( ai_dude ) )
        {
            ai_dude delete();
        }
    }
}

// Namespace lift_escape
// Params 1
// Checksum 0x3ffe6aa7, Offset: 0x75e0
// Size: 0x6e
function get_to_lift_wait( str_s_target )
{
    s_target = struct::get( str_s_target, "targetname" );
    self.at_lift = undefined;
    self.goalradius = -128;
    self setgoalpos( s_target.origin );
    self waittill( #"goal" );
    self.at_lift = 1;
}

// Namespace lift_escape
// Params 0
// Checksum 0xcea8c160, Offset: 0x7658
// Size: 0x72
function send_hendricks_to_lift()
{
    self colors::disable();
    scene::add_scene_func( "cin_pro_09_01_intro_1st_cybersoldiers_elevator_ride_start_hendricks", &function_3703e000, "play" );
    level scene::play( "cin_pro_09_01_intro_1st_cybersoldiers_elevator_ride_start_hendricks" );
    level flag::set( "hendricks_in_lift" );
}

// Namespace lift_escape
// Params 0
// Checksum 0x1ba19f44, Offset: 0x76d8
// Size: 0x9a
function function_c3ab179b()
{
    self ai::set_behavior_attribute( "vignette_mode", "slow" );
    scene::add_scene_func( "cin_pro_09_01_intro_1st_cybersoldiers_elevator_ride_start_minister", &function_6d36e736, "play" );
    level scene::play( "cin_pro_09_01_intro_1st_cybersoldiers_elevator_ride_start_minister" );
    self setgoal( self.origin, 1 );
    level flag::set( "minister_in_lift" );
}

// Namespace lift_escape
// Params 0
// Checksum 0x271709f0, Offset: 0x7780
// Size: 0x9a
function function_f92b76b7()
{
    self ai::set_behavior_attribute( "vignette_mode", "slow" );
    scene::add_scene_func( "cin_pro_09_01_intro_1st_cybersoldiers_elevator_ride_start_khalil", &function_789cecd6, "play" );
    level scene::play( "cin_pro_09_01_intro_1st_cybersoldiers_elevator_ride_start_khalil" );
    self setgoal( self.origin, 1 );
    level flag::set( "khalil_in_lift" );
}

// Namespace lift_escape
// Params 1
// Checksum 0x2baeee5e, Offset: 0x7828
// Size: 0x2a
function function_3703e000( a_ents )
{
    level endon( #"hendricks_in_lift" );
    wait 6;
    level flag::set( "hendricks_in_lift" );
}

// Namespace lift_escape
// Params 1
// Checksum 0xccaa486e, Offset: 0x7860
// Size: 0x2a
function function_6d36e736( a_ents )
{
    level endon( #"minister_in_lift" );
    wait 4;
    level flag::set( "minister_in_lift" );
}

// Namespace lift_escape
// Params 1
// Checksum 0x8d5c727f, Offset: 0x7898
// Size: 0x32
function function_789cecd6( a_ents )
{
    level endon( #"khalil_in_lift" );
    wait 6.7;
    level flag::set( "khalil_in_lift" );
}

// Namespace lift_escape
// Params 0
// Checksum 0xc4cfd4a8, Offset: 0x78d8
// Size: 0x62
function function_8949fadf()
{
    e_trigger = getent( "t_lift_player_advances", "targetname" );
    
    if ( isdefined( e_trigger ) )
    {
        e_trigger waittill( #"trigger" );
    }
    
    level thread cp_prologue_util::function_a7eac508( "sp_lift_player_advances", 64, 64, undefined );
    level.var_1f5f8798 = 1;
}

// Namespace lift_escape
// Params 0
// Checksum 0x61f9b441, Offset: 0x7948
// Size: 0x3f2
function function_51da5fc6()
{
    level.e_lift = getent( "freight_lift", "targetname" );
    level.var_3dce3f88 = spawn( "script_model", level.e_lift.origin );
    level.e_lift linkto( level.var_3dce3f88 );
    level.e_lift setmovingplatformenabled( 1 );
    level.e_lift thread function_f2f20b35();
    exploder::exploder( "light_exploder_lift_inside" );
    function_dfbe3c61();
    a_spawners = getentarray( "sp_lift_reinforcements", "targetname" );
    
    for ( i = 0; i < a_spawners.size ; i++ )
    {
        a_spawners[ i ] spawner::add_spawn_function( &function_38a8e28b );
        a_spawners[ i ] spawner::spawn();
    }
    
    v_down = ( 0, 0, -1 );
    dist = 354;
    move_time = 5;
    v_lift_destination = level.e_lift.origin + v_down * dist;
    level.var_3dce3f88 moveto( v_lift_destination, move_time );
    level.e_lift = getent( "freight_lift", "targetname" );
    level.e_lift playsound( "evt_freight_lift_start" );
    snd_lift = spawn( "script_origin", level.e_lift.origin );
    snd_lift linkto( level.e_lift );
    snd_lift playloopsound( "evt_freight_lift_loop" );
    level.var_3dce3f88 waittill( #"movedone" );
    level.var_3dce3f88 scene::init( "cin_pro_08_01_liftescape_vign_lift_doorsopen", level.e_lift );
    snd_lift stoploopsound( 0.1 );
    setdvar( "grenadeAllowRigidBodyPhysics", "0" );
    open_time = 1.5;
    level thread function_45ed0d4b( 1, open_time );
    wait open_time + 0.1;
    nd_lift_traversal = getnode( "n_lift_entrance_begin3", "targetname" );
    linktraversal( nd_lift_traversal );
    level flag::set( "lift_arrived" );
    a_nodes = getnodearray( "nd_exit_lift", "targetname" );
    a_ai = getentarray( "sp_lift_reinforcements_ai", "targetname" );
    
    for ( i = 0; i < a_ai.size ; i++ )
    {
        a_ai[ i ] thread function_c6db42e4( a_nodes[ i ] );
    }
    
    wait 1;
    level.ai_hendricks dialog::say( "hend_spotted_more_reinfor_0" );
}

// Namespace lift_escape
// Params 1
// Checksum 0xc1de545c, Offset: 0x7d48
// Size: 0x56
function function_c6db42e4( nd_node )
{
    self endon( #"death" );
    self util::stop_magic_bullet_shield();
    self.goalradius = 64;
    self setgoal( nd_node.origin );
    self waittill( #"goal" );
    self.goalradius = 1024;
}

// Namespace lift_escape
// Params 0
// Checksum 0xb74db613, Offset: 0x7da8
// Size: 0x22
function function_38a8e28b()
{
    self.goalradius = 64;
    self.var_37b94263 = 1;
    self util::magic_bullet_shield();
}

// Namespace lift_escape
// Params 0
// Checksum 0x7016e846, Offset: 0x7dd8
// Size: 0x1a9
function function_93c4d161()
{
    e_volume = getent( "info_lift_start_area_volume", "targetname" );
    
    while ( true )
    {
        var_b9c84787 = getaiteamarray( "axis" );
        
        if ( var_b9c84787.size < 5 )
        {
            a_enemy = cp_prologue_util::function_68b8f4af( e_volume );
            
            if ( a_enemy.size < 3 )
            {
                break;
            }
        }
        
        wait 0.05;
    }
    
    var_d6bb42cf = getent( "v_lift_fallback", "targetname" );
    
    for ( i = 0; i < a_enemy.size ; i++ )
    {
        e_ai = a_enemy[ i ];
        e_ai setgoal( var_d6bb42cf );
    }
    
    var_d6bb42cf = getent( "info_lift_area_volume", "targetname" );
    
    while ( true )
    {
        a_enemy = cp_prologue_util::function_68b8f4af( e_volume );
        
        if ( a_enemy.size <= 1 )
        {
            break;
        }
        
        wait 0.05;
    }
    
    for ( i = 0; i < a_enemy.size ; i++ )
    {
        e_player = getplayers()[ 0 ];
        e_enemy = a_enemy[ i ];
        e_enemy.goalradius = -56;
        e_enemy setgoal( e_player );
    }
}

// Namespace lift_escape
// Params 0
// Checksum 0x12ce9f78, Offset: 0x7f90
// Size: 0xcf
function function_dfbe3c61()
{
    cp_prologue_util::function_d1f1caad( "entering_lift_fight" );
    start_time = gettime();
    
    while ( true )
    {
        time = gettime();
        dt = ( time - start_time ) / 1000;
        
        if ( dt > 20 )
        {
            e_trigger = getent( "t_lift_reinforcements", "targetname" );
            
            if ( !isdefined( e_trigger ) )
            {
                break;
            }
            
            num_touching = cp_prologue_util::function_609c412a( "info_lift_area_volume", 0 );
            
            if ( num_touching < 3 )
            {
                break;
            }
        }
        
        wait 0.05;
    }
    
    level notify( #"hash_631a1949" );
}

// Namespace lift_escape
// Params 0
// Checksum 0xe57ecda3, Offset: 0x8068
// Size: 0x252
function function_f2f20b35()
{
    probe_lift = getent( "probe_lift", "targetname" );
    probe_lift linkto( self );
    light_lift = getent( "light_lift", "targetname" );
    light_lift linkto( self );
    var_51875481 = getentarray( "light_lift_02", "targetname" );
    
    foreach ( light in var_51875481 )
    {
        light linkto( self );
    }
    
    var_51875481 = getentarray( "light_lift_03", "targetname" );
    
    foreach ( light in var_51875481 )
    {
        light linkto( self );
    }
    
    var_51875481 = getentarray( "light_lift_panel_anim01", "targetname" );
    
    foreach ( light in var_51875481 )
    {
        light linkto( self );
    }
    
    light_lift = getent( "light_lift_panel_anim02", "targetname" );
    light_lift linkto( self );
    level waittill( #"hash_a1a67fd8" );
    exploder::exploder( "light_lift_panel_green" );
}

// Namespace lift_escape
// Params 2
// Checksum 0xd962973e, Offset: 0x82c8
// Size: 0x25a
function function_45ed0d4b( open_door, move_time )
{
    var_507d66a5 = getent( "lift_door_top", "targetname" );
    var_3d3eb4dd = getent( "lift_door_bottom", "targetname" );
    v_up = ( 0, 0, 1 );
    move_amount = 100;
    
    if ( open_door )
    {
        if ( level.var_1dd14818 == 1 )
        {
            return;
        }
        
        v_dest = var_507d66a5.origin + v_up * move_amount;
        var_507d66a5 moveto( v_dest, move_time );
        v_dest = var_3d3eb4dd.origin + v_up * move_amount * -1;
        var_3d3eb4dd moveto( v_dest, move_time );
        level.var_1dd14818 = 1;
    }
    else
    {
        if ( level.var_1dd14818 == 0 )
        {
            return;
        }
        
        v_dest = var_507d66a5.origin + v_up * move_amount * -1;
        var_507d66a5 moveto( v_dest, move_time );
        v_dest = var_3d3eb4dd.origin + v_up * move_amount;
        var_3d3eb4dd moveto( v_dest, move_time );
        level.var_1dd14818 = 0;
    }
    
    var_3d3eb4dd playsound( "evt_freight_elev_door_start" );
    snd_door = spawn( "script_origin", var_3d3eb4dd.origin );
    snd_door linkto( var_3d3eb4dd );
    snd_door playloopsound( "evt_freight_elev_door_loop" );
    wait move_time;
    var_3d3eb4dd playsound( "evt_freight_elev_door_stop" );
    snd_door stoploopsound( 0.1 );
    
    if ( open_door )
    {
        level.var_3dce3f88 scene::play( "cin_pro_08_01_liftescape_vign_lift_doorsopen", level.e_lift );
        return;
    }
    
    level.var_3dce3f88 scene::play( "cin_pro_08_01_liftescape_vign_lift_doorsclose", level.e_lift );
}

// Namespace lift_escape
// Params 0
// Checksum 0x99565026, Offset: 0x8530
// Size: 0x2b2
function function_5517d018()
{
    e_trigger = getent( "crane_damage_trigger", "targetname" );
    e_trigger triggerenable( 0 );
    cp_prologue_util::function_d1f1caad( "t_intro_guys_on_bridge" );
    level thread scene::play( "p7_fxanim_cp_prologue_ceiling_underground_crane_bundle", "scriptbundlename" );
    level waittill( #"crane_in_position" );
    level flag::set( "crane_in_position" );
    e_trigger triggerenable( 1 );
    e_trigger waittill( #"trigger", e_who );
    e_trigger delete();
    level thread scene::play( "p7_fxanim_cp_prologue_ceiling_underground_crane_shot_bundle" );
    level waittill( #"hash_1cda5581" );
    level flag::set( "crane_dropped" );
    a_ai = getaiteamarray( "axis" );
    e_volume = getent( "info_crane_drop", "targetname" );
    
    for ( i = 0; i < a_ai.size ; i++ )
    {
        if ( isalive( a_ai[ i ] ) && a_ai[ i ] istouching( e_volume ) )
        {
            a_ai[ i ] kill();
            
            if ( isplayer( e_who ) )
            {
                prologue_accolades::function_d248b92b( e_who );
            }
        }
    }
    
    foreach ( player in level.players )
    {
        if ( player istouching( e_volume ) )
        {
            player dodamage( 500, e_volume.origin );
        }
    }
    
    e_volume delete();
    e_coll = getent( "lifttunnel_pipecollision", "targetname" );
    e_coll movez( -80, 0.05 );
}

// Namespace lift_escape
// Params 0
// Checksum 0xe737ee01, Offset: 0x87f0
// Size: 0x9a
function function_6fabe3da()
{
    trigger::wait_till( "entering_lift_fight" );
    level.ai_hendricks dialog::say( "hend_that_s_our_exit_car_0" );
    cp_prologue_util::function_520255e3( "t_lift_reinforcements", 60 );
    level.ai_hendricks dialog::say( "hend_elevator_s_right_the_0" );
    level waittill( #"lift_is_moving" );
    level thread namespace_21b2c1f2::function_9f50ebc2();
    level thread namespace_21b2c1f2::function_c4c71c7();
}

// Namespace lift_escape
// Params 0
// Checksum 0x62ce82d3, Offset: 0x8898
// Size: 0x4a
function function_6f04ae03()
{
    level endon( #"lift_is_moving" );
    level.ai_hendricks dialog::say( "hend_let_s_move_get_to_t_0" );
    wait 15;
    level.ai_hendricks dialog::say( "hend_keep_pushing_forward_0" );
}

