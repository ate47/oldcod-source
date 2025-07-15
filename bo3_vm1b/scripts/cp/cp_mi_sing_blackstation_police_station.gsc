#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_laststand;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_blackstation;
#using scripts/cp/cp_mi_sing_blackstation_accolades;
#using scripts/cp/cp_mi_sing_blackstation_cross_debris;
#using scripts/cp/cp_mi_sing_blackstation_sound;
#using scripts/cp/cp_mi_sing_blackstation_utility;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/cybercom/_cybercom_gadget_firefly;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai/archetype_warlord_interface;
#using scripts/shared/ai/phalanx;
#using scripts/shared/ai_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicleriders_shared;

#namespace cp_mi_sing_blackstation_police_station;

// Namespace cp_mi_sing_blackstation_police_station
// Params 2
// Checksum 0xcf7dc62a, Offset: 0x10d8
// Size: 0xf2
function objective_police_station_init( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        blackstation_utility::init_hendricks( "objective_police_station" );
        level function_a7bb8a82();
        load::function_a2995f22();
    }
    
    level thread blackstation_utility::player_rain_intensity( "light_ne" );
    level thread scene::init( "p7_fxanim_cp_blackstation_police_station_ceiling_tiles_bundle" );
    array::thread_all( level.activeplayers, &clientfield::set_to_player, "toggle_rain_sprite", 1 );
    streamerrequest( "set", "cp_mi_sing_blackstation_objective_kane_intro" );
    police_station_main();
}

// Namespace cp_mi_sing_blackstation_police_station
// Params 4
// Checksum 0x42a32918, Offset: 0x11d8
// Size: 0x9a
function objective_police_station_done( str_objective, b_starting, b_direct, player )
{
    level scene::init( "p7_fxanim_cp_blackstation_apartment_collapse_bundle" );
    objectives::set( "cp_level_blackstation_goto_comm_relay" );
    objectives::hide( "cp_level_blackstation_goto_comm_relay" );
    objectives::hide( "cp_level_blackstation_qzone" );
    showmiscmodels( "collapse_frogger_water" );
}

// Namespace cp_mi_sing_blackstation_police_station
// Params 0
// Checksum 0x47af69e2, Offset: 0x1280
// Size: 0x1f2
function police_station_main()
{
    level.ai_hendricks thread function_7f3763ee();
    level.var_d1cabfc = 0;
    level thread cybercore_takedown();
    level thread function_2397a7b2();
    level thread function_1932762c();
    level thread function_e2038b3();
    level thread function_d87a714f();
    level thread police_station_waypoints();
    level thread worklight_setup();
    level thread kane_intro_check();
    level thread spawn_management();
    level thread function_d7f282ac();
    level thread blackstation_utility::police_station_corpses();
    level thread function_e27b9e3c();
    level thread cellblock_enemy_spawn();
    level thread function_f6f7ab3d();
    level thread function_969d668a();
    level thread function_37170d4a();
    level thread blackstation_accolades::function_26aa602b();
    
    foreach ( player in level.activeplayers )
    {
        player thread function_5723cc6();
        player thread blackstation_utility::function_d870e0( "trig_police_station_lobby_in_position" );
        player thread blackstation_utility::function_d870e0( "trig_spawn_upstairs_intro" );
    }
    
    spawner::add_spawn_function_group( "police_station_warlord", "script_noteworthy", &function_b45ce54a );
}

// Namespace cp_mi_sing_blackstation_police_station
// Params 0
// Checksum 0xb32d90e2, Offset: 0x1480
// Size: 0x4a
function function_5723cc6()
{
    self endon( #"death" );
    level endon( #"flag_lobby_engaged" );
    level flag::wait_till( "flag_waypoint_police_station01" );
    self waittill( #"weapon_fired" );
    level flag::set( "flag_lobby_engaged" );
}

// Namespace cp_mi_sing_blackstation_police_station
// Params 0
// Checksum 0x1df3e1ee, Offset: 0x14d8
// Size: 0x52
function function_969d668a()
{
    level flag::wait_till( "flag_waypoint_police_station03" );
    battlechatter::function_d9f49fba( 0 );
    level flag::wait_till( "flag_kane_intro_complete" );
    battlechatter::function_d9f49fba( 1 );
}

// Namespace cp_mi_sing_blackstation_police_station
// Params 0
// Checksum 0x3bf5b222, Offset: 0x1538
// Size: 0x32
function police_station_waypoints()
{
    level flag::wait_till( "flag_enter_police_station" );
    level thread objectives::breadcrumb( "police_station_breadcrumb" );
}

// Namespace cp_mi_sing_blackstation_police_station
// Params 0
// Checksum 0x87cd4436, Offset: 0x1578
// Size: 0x7a
function function_2397a7b2()
{
    trigger::wait_till( "trig_police__station_group03", undefined, undefined, 0 );
    var_56b381f2 = getent( "police_station_warlord", "targetname" );
    playrumbleonposition( "cp_blackstation_rumble_breach", var_56b381f2.origin );
    playsoundatposition( "evt_kane_explosion", ( 0, 0, 0 ) );
}

// Namespace cp_mi_sing_blackstation_police_station
// Params 0
// Checksum 0x423bdea3, Offset: 0x1600
// Size: 0x132
function function_1932762c()
{
    level flag::wait_till( "flag_lobby_setup" );
    level thread namespace_4297372::function_bed0eaad();
    level flag::wait_till( "flag_police_station_hendricks_cqb" );
    
    if ( !level flag::get( "flag_lobby_engaged" ) )
    {
        level.ai_hendricks thread dialog::say( "hend_quiet_0" );
    }
    
    level flag::wait_till( "vo_hendricks_first" );
    level.ai_hendricks dialog::say( "hend_moving_to_first_floo_0" );
    trigger::wait_till( "hend_moving_to_second", undefined, undefined, 0 );
    level.ai_hendricks dialog::say( "hend_moving_to_second_flo_0" );
    trigger::wait_till( "hend_moving_to_third", undefined, undefined, 0 );
    level.ai_hendricks dialog::say( "hend_moving_to_third_floo_0" );
    level thread namespace_4297372::function_973b77f9();
}

// Namespace cp_mi_sing_blackstation_police_station
// Params 0
// Checksum 0xbdef6966, Offset: 0x1740
// Size: 0xcb
function function_e2038b3()
{
    level endon( #"flag_waypoint_police_station03" );
    level flag::wait_till( "ps_enter_vo" );
    level.ai_hendricks dialog::say( "hend_hostiles_above_and_0" );
    level flag::wait_till( "ps_upstairs_intro" );
    
    if ( !flag::get( "flag_police_station_defend" ) )
    {
        level.ai_hendricks dialog::say( "hend_top_floor_0", 1 );
    }
    
    level flag::wait_till( "flag_police_station_defend" );
    
    while ( getaiteamarray( "axis" ).size )
    {
        wait 1;
    }
}

// Namespace cp_mi_sing_blackstation_police_station
// Params 0
// Checksum 0x7efb6325, Offset: 0x1818
// Size: 0x62
function function_d87a714f()
{
    trigger::wait_till( "trigger_riot" );
    level.ai_hendricks dialog::say( "hend_bastards_have_riot_s_0", 1 );
    level.ai_hendricks dialog::say( "hend_hit_em_with_some_fr_0", 0.5 );
}

// Namespace cp_mi_sing_blackstation_police_station
// Params 0
// Checksum 0x52ad7240, Offset: 0x1888
// Size: 0x62
function function_a7bb8a82()
{
    spawner::simple_spawn( "police_station_exterior_group", &lobby_ai_behavior );
    spawner::simple_spawn( "police_station_exterior_robot", &lobby_ai_behavior );
    level spawn_lobby_turrets();
}

// Namespace cp_mi_sing_blackstation_police_station
// Params 0
// Checksum 0x5edf7ec0, Offset: 0x18f8
// Size: 0x372
function cybercore_takedown()
{
    level flag::wait_till( "flag_lobby_setup" );
    level.ai_hendricks ai::set_ignoreall( 1 );
    level.ai_hendricks ai::set_ignoreme( 1 );
    level flag::wait_till( "flag_police_station_hendricks_cqb" );
    
    if ( !level flag::get( "flag_lobby_engaged" ) )
    {
        level.ai_hendricks dialog::say( "hend_i_see_you_beat_h_0", 0.5 );
        is_turret_enemy_marked = 0;
        
        for ( i = 0; i < level.players.size ; i++ )
        {
            if ( !is_turret_enemy_marked )
            {
                foreach ( ai_enemy in level.a_lobby_ai )
                {
                    if ( isalive( ai_enemy ) && ai_enemy.script_noteworthy === "police_station_gunner_target_01" )
                    {
                        ai_enemy thread function_bd78d653();
                        ai_enemy clientfield::set( "kill_target_keyline", level.players[ i ] getentitynumber() + 1 );
                        a_remove_enemy = [];
                        array::add( a_remove_enemy, ai_enemy );
                        level.a_lobby_ai = array::exclude( level.a_lobby_ai, a_remove_enemy );
                        is_turret_enemy_marked = 1;
                    }
                }
                
                continue;
            }
            
            if ( isdefined( level.a_lobby_ai[ i ] ) && level.a_lobby_ai[ i ].script_noteworthy != "police_station_gunner_target_02" )
            {
                level.a_lobby_ai[ i ] clientfield::set( "kill_target_keyline", level.players[ i ] getentitynumber() + 1 );
                arrayremoveindex( level.a_lobby_ai, i, 1 );
            }
        }
        
        level flag::set( "flag_lobby_ready_to_engage" );
        level flag::wait_till_timeout( 2, "flag_lobby_engaged" );
        wait 0.5;
        level.ai_hendricks ai::set_ignoreall( 0 );
        level.ai_hendricks ai::set_ignoreme( 0 );
    }
    else
    {
        level.ai_hendricks ai::set_ignoreall( 0 );
        level.ai_hendricks ai::set_ignoreme( 0 );
        level.ai_hendricks dialog::say( "hend_they_re_onto_us_se_0" );
    }
    
    level flag::wait_till( "hendricks_subway_exit" );
    level.ai_hendricks function_cbbb2fea();
    spawner::waittill_ai_group_count( "lobby_enemies", 5 );
    level flag::set( "approach_ps_entrance" );
}

// Namespace cp_mi_sing_blackstation_police_station
// Params 0
// Checksum 0xaf12207f, Offset: 0x1c78
// Size: 0x4a
function function_693c6a46()
{
    self waittill( #"death" );
    level.var_d1cabfc++;
    
    if ( level.var_d1cabfc > 2 )
    {
        level flag::set( "approach_ps_entrance" );
        wait 1;
        level flag::set( "flag_enter_police_station" );
    }
}

// Namespace cp_mi_sing_blackstation_police_station
// Params 0
// Checksum 0x1ce7bc50, Offset: 0x1cd0
// Size: 0x3d
function function_2c3b5e41()
{
    self endon( #"death" );
    
    while ( true )
    {
        level waittill( #"cybercom_swarm_released", swarm );
        self setignoreent( swarm, 1 );
    }
}

// Namespace cp_mi_sing_blackstation_police_station
// Params 0
// Checksum 0x4cb38125, Offset: 0x1d18
// Size: 0x11a
function function_7f3763ee()
{
    level.ai_hendricks ai::set_behavior_attribute( "cqb", 1 );
    level flag::wait_till( "approach_ps_entrance" );
    trigger::use( "triggercolor_ps_entrance" );
    level flag::wait_till( "flag_enter_police_station" );
    level.ai_hendricks ai::set_behavior_attribute( "cqb", 0 );
    level flag::wait_till( "police_station_enter" );
    trigger::use( "trig_hendricks_move_into_police_station", undefined, undefined, 0 );
    level flag::wait_till( "ps_regroup" );
    trigger::use( "triggercolor_regroup" );
    trigger::wait_till( "trigger_riot" );
    spawn_manager::enable( "police_station_group03_sm" );
}

// Namespace cp_mi_sing_blackstation_police_station
// Params 0
// Checksum 0x8e1c7f0d, Offset: 0x1e40
// Size: 0x11a
function function_cbbb2fea()
{
    ai_target = getent( "police_station_gunner_target_02", "script_noteworthy", 1 );
    
    if ( isalive( ai_target ) )
    {
        e_target = ai_target;
    }
    else
    {
        foreach ( ai_enemy in level.a_lobby_ai )
        {
            if ( isalive( ai_enemy ) )
            {
                e_target = ai_enemy;
                break;
            }
        }
    }
    
    self blackstation_utility::function_4f96504c( e_target );
    
    if ( isalive( e_target ) )
    {
        self cybercom::function_d240e350( "cybercom_fireflyswarm", e_target, 0, 1 );
    }
    
    level.ai_hendricks ai::set_ignoreall( 0 );
}

// Namespace cp_mi_sing_blackstation_police_station
// Params 0
// Checksum 0x88ab02a9, Offset: 0x1f68
// Size: 0x32
function function_bd78d653()
{
    level endon( #"hash_d9295e03" );
    self waittill( #"death" );
    wait 0.5;
    level dialog::player_say( "plyr_kill_confirmed_0" );
}

// Namespace cp_mi_sing_blackstation_police_station
// Params 0
// Checksum 0xa2f119c0, Offset: 0x1fa8
// Size: 0xd3
function function_e27b9e3c()
{
    level flag::wait_till( "ps_upstairs_intro" );
    a_ai_enemies = getaiteamarray( "axis" );
    a_ai_enemies = arraysortclosest( a_ai_enemies, level.ai_hendricks.origin );
    
    for ( i = 0; i < a_ai_enemies.size ; i++ )
    {
        if ( isalive( a_ai_enemies[ i ] ) )
        {
            level.ai_hendricks thread blackstation_utility::function_4f96504c( a_ai_enemies[ i ] );
            level.ai_hendricks cybercom::function_d240e350( "cybercom_fireflyswarm", a_ai_enemies[ i ], 0, 1 );
            break;
        }
    }
}

// Namespace cp_mi_sing_blackstation_police_station
// Params 0
// Checksum 0xd3fa0d95, Offset: 0x2088
// Size: 0x82
function lobby_patroller()
{
    self endon( #"death" );
    self ai::patrol( getnode( "lobby_patrol_start_point", "targetname" ) );
    level flag::wait_till( "flag_lobby_engaged" );
    self setgoalvolume( getent( "lobby_defend_volume_01", "targetname" ) );
}

// Namespace cp_mi_sing_blackstation_police_station
// Params 0
// Checksum 0x9f6d0867, Offset: 0x2118
// Size: 0x91
function spawn_lobby_turrets()
{
    spawner::add_spawn_function_group( "turret_gunner", "targetname", &turret_gunner_think );
    
    for ( i = 1; i < 3 ; i++ )
    {
        vh_turret = vehicle::simple_spawn_single( "veh_turret_0" + i );
        vh_turret vehicle::lights_off();
        vh_turret thread turret_think();
    }
}

// Namespace cp_mi_sing_blackstation_police_station
// Params 1
// Checksum 0x7f409cb2, Offset: 0x21b8
// Size: 0x92
function turret_gunner_think( vh_turret )
{
    self endon( #"death" );
    self ai::set_ignoreme( 1 );
    self ai::set_ignoreall( 1 );
    array::add( level.a_lobby_ai, self );
    self thread function_dbf996a();
    level flag::wait_till( "flag_lobby_engaged" );
    self ai::set_ignoreme( 0 );
    self ai::set_ignoreall( 0 );
}

// Namespace cp_mi_sing_blackstation_police_station
// Params 0
// Checksum 0x9b34e9ee, Offset: 0x2258
// Size: 0x72
function turret_think()
{
    self endon( #"death" );
    level flag::wait_till( "flag_lobby_engaged" );
    wait 2;
    ai_gunner = self vehicle::get_rider( "gunner1" );
    
    if ( isdefined( ai_gunner ) && isalive( ai_gunner ) )
    {
        self turret::enable( 1, 1 );
    }
}

// Namespace cp_mi_sing_blackstation_police_station
// Params 0
// Checksum 0xd1ee55ea, Offset: 0x22d8
// Size: 0x262
function lobby_ai_behavior()
{
    self endon( #"death" );
    self thread proximity_detection_lobby();
    self thread function_dbf996a();
    
    if ( self.targetname == "police_station_exterior_robot_ai" )
    {
        self thread function_693c6a46();
        self thread function_2c3b5e41();
    }
    
    self ai::set_ignoreall( 1 );
    self ai::set_ignoreme( 1 );
    level clientfield::set( "sndStationWalla", 1 );
    array::add( level.a_lobby_ai, self );
    
    if ( self.script_noteworthy === "lobby_patrol" )
    {
        self thread lobby_patroller();
    }
    
    level flag::wait_till( "flag_lobby_engaged" );
    level clientfield::set( "sndStationWalla", 0 );
    self.maxsightdistsqrd = self.var_98207841;
    self ai::set_ignoreme( 0 );
    self.goalradius = 2048;
    
    if ( self.targetname == "police_station_exterior_robot_ai" )
    {
        self ai::set_ignoreall( 0 );
        self ai::set_behavior_attribute( "move_mode", "rusher" );
    }
    else
    {
        wait randomfloatrange( 0.3, 1.3 );
        self ai::set_ignoreall( 0 );
    }
    
    spawner::waittill_ai_group_count( "lobby_enemies", 9 );
    
    if ( self.script_noteworthy === "lobby_group_01" )
    {
        wait randomint( 2 );
        self setgoalvolume( getent( "lobby_defend_volume_01", "targetname" ) );
        return;
    }
    
    if ( self.script_noteworthy === "lobby_group_02" )
    {
        wait randomint( 2 );
        self setgoalvolume( getent( "lobby_defend_volume_02", "targetname" ) );
    }
}

// Namespace cp_mi_sing_blackstation_police_station
// Params 0
// Checksum 0xaa63b480, Offset: 0x2548
// Size: 0xbd
function proximity_detection_lobby()
{
    self endon( #"death" );
    level endon( #"flag_lobby_engaged" );
    self.var_98207841 = self.maxsightdistsqrd;
    self.maxsightdistsqrd = 160000;
    
    while ( true )
    {
        foreach ( player in level.activeplayers )
        {
            if ( self cansee( player ) )
            {
                level flag::set( "flag_lobby_engaged" );
            }
        }
        
        wait 0.3;
    }
}

// Namespace cp_mi_sing_blackstation_police_station
// Params 0
// Checksum 0xfef6269, Offset: 0x2610
// Size: 0x5a
function function_dbf996a()
{
    self util::waittill_any( "damage", "bulletwhizby", "grenadedanger", "enemy", "projectile_impact", "cybercom_action" );
    level flag::set( "flag_lobby_engaged" );
}

// Namespace cp_mi_sing_blackstation_police_station
// Params 0
// Checksum 0x159c71cd, Offset: 0x2678
// Size: 0x142
function kane_intro_check()
{
    trigger::wait_till( "trig_kane_intro" );
    level clientfield::set( "flotsam", 0 );
    
    foreach ( player in level.players )
    {
        if ( player laststand::player_is_in_laststand() )
        {
            player laststand::auto_revive( player );
        }
    }
    
    a_hostile_ai = getaiteamarray( "axis" );
    
    foreach ( ai in a_hostile_ai )
    {
        ai delete();
    }
    
    skipto::objective_completed( "objective_police_station" );
}

// Namespace cp_mi_sing_blackstation_police_station
// Params 0
// Checksum 0xfc8c5fa2, Offset: 0x27c8
// Size: 0xe1
function worklight_setup()
{
    a_lights = getentarray( "script_worklight", "targetname" );
    
    for ( i = 0; i < a_lights.size ; i++ )
    {
        a_lights[ i ] fx::play( "worklight", a_lights[ i ].origin, a_lights[ i ].angles, "fx_stop", 1, "tag_origin" );
        a_lights[ i ] fx::play( "worklight_rays", a_lights[ i ].origin, a_lights[ i ].angles, "fx_stop", 1, "tag_origin" );
        a_lights[ i ] thread worklight_destruction();
    }
}

// Namespace cp_mi_sing_blackstation_police_station
// Params 0
// Checksum 0x5d4b5dfb, Offset: 0x28b8
// Size: 0x6b
function worklight_destruction()
{
    t_damage = getent( self.target, "targetname" );
    
    if ( isdefined( t_damage ) )
    {
        t_damage trigger::wait_till();
    }
    
    level thread scene::play( t_damage.target, "targetname" );
    self notify( #"fx_stop" );
}

// Namespace cp_mi_sing_blackstation_police_station
// Params 0
// Checksum 0x1f09759f, Offset: 0x2930
// Size: 0xda
function function_d7f282ac()
{
    spawner::add_spawn_function_group( "police_groundfloor01", "targetname", &function_5eb730ee );
    spawner::add_spawn_function_group( "police_upstairs01", "targetname", &function_5eb730ee );
    spawner::add_spawn_function_group( "police_station_group03", "targetname", &function_5eb730ee );
    trigger::wait_till( "trigger_police_interior" );
    spawn_manager::enable( "police_groundfloor01_sm" );
    spawn_manager::enable( "police_station_group01_sm" );
}

// Namespace cp_mi_sing_blackstation_police_station
// Params 0
// Checksum 0x9c631e08, Offset: 0x2a18
// Size: 0x2a
function function_5eb730ee()
{
    self endon( #"death" );
    self.goalradius = 32;
    self waittill( #"goal" );
    self.goalradius = 700;
}

// Namespace cp_mi_sing_blackstation_police_station
// Params 0
// Checksum 0xf9802112, Offset: 0x2a50
// Size: 0x7a
function spawn_management()
{
    level flag::wait_till( "ps_enter_vo" );
    spawn_manager::enable( "police_upstairs01_sm", 1 );
    level trigger::wait_till( "trig_spawn_upstairs_intro", undefined, undefined, 0 );
    
    if ( !flag::get( "flag_police_station_defend" ) )
    {
        spawner::simple_spawn( "police_upstairs02" );
    }
}

// Namespace cp_mi_sing_blackstation_police_station
// Params 0
// Checksum 0x159514c5, Offset: 0x2ad8
// Size: 0xd2
function function_b45ce54a()
{
    a_warlord_nodes = getnodearray( "warlord_node", "script_noteworthy" );
    
    foreach ( node in a_warlord_nodes )
    {
        self warlordinterface::addpreferedpoint( node.origin, 5000, 10000 );
    }
    
    warlord_node = getnode( "warlord_police_station_node", "targetname" );
    
    if ( isdefined( warlord_node ) )
    {
        self setgoal( warlord_node );
    }
}

// Namespace cp_mi_sing_blackstation_police_station
// Params 0
// Checksum 0xff98b9dd, Offset: 0x2bb8
// Size: 0x11a
function cellblock_enemy_spawn()
{
    flag::wait_till( "flag_enter_cell_block" );
    e_trigger = trigger::wait_till( "trig_cellblock_ambush" );
    
    if ( e_trigger.who == level.ai_hendricks )
    {
        sp_ambush_enemy = getent( "cellblock_ambush_spawn_01", "targetname" );
        ai_ambush_enemy = sp_ambush_enemy spawner::spawn( 1 );
        ai_ambush_enemy cellblock_enemy_scene();
    }
    else
    {
        sp_ambush_enemy = getent( "cellblock_ambush_spawn_02", "targetname" );
        ai_ambush_enemy = sp_ambush_enemy spawner::spawn( 1 );
    }
    
    if ( !level flag::get( "exit_cellblock" ) )
    {
        trigger::use( "triger_hendricks_b7_cell_block_move", "targetname" );
    }
}

// Namespace cp_mi_sing_blackstation_police_station
// Params 0
// Checksum 0x1519706d, Offset: 0x2ce0
// Size: 0xc2
function cellblock_enemy_scene()
{
    self endon( #"death" );
    level.ai_hendricks ai::set_ignoreall( 1 );
    self ai::set_ignoreall( 1 );
    self setgoal( self.origin, 1 );
    level.ai_hendricks colors::disable();
    self.animname = "patroller";
    level scene::add_scene_func( "cin_bla_09_02_policestation_vign_ambush", &function_878db82b, "done" );
    level.ai_hendricks scene::play( "cin_bla_09_02_policestation_vign_ambush" );
}

// Namespace cp_mi_sing_blackstation_police_station
// Params 1
// Checksum 0xc029ba29, Offset: 0x2db0
// Size: 0x3a
function function_878db82b( a_ents )
{
    level.ai_hendricks ai::set_ignoreall( 0 );
    level.ai_hendricks colors::enable();
}

// Namespace cp_mi_sing_blackstation_police_station
// Params 0
// Checksum 0x7e44b2a9, Offset: 0x2df8
// Size: 0x1ca
function function_f6f7ab3d()
{
    trigger::wait_till( "trigger_phalanx" );
    
    switch ( level.players.size )
    {
        case 2:
            var_e64a5de5 = 3;
            break;
        case 3:
            var_e64a5de5 = 4;
            break;
        case 4:
            var_e64a5de5 = 5;
            break;
        default:
            var_e64a5de5 = 2;
            break;
    }
    
    v_start = struct::get( "cell_phalanx_start" ).origin;
    v_end = struct::get( "cell_phalanx_end" ).origin;
    var_f835ddae = getent( "police_station_phalanx", "targetname" );
    phalanx = new phalanx();
    [[ phalanx ]]->initialize( "phanalx_wedge", v_start, v_end, 2, var_e64a5de5, var_f835ddae, var_f835ddae );
    var_ace28dfc = arraycombine( phalanx.sentienttiers_[ "phalanx_tier1" ], phalanx.sentienttiers_[ "phalanx_tier2" ], 0, 0 );
    level thread blackstation_accolades::function_92e8d6d8( var_ace28dfc );
    a_ai = getaiteamarray( "axis" );
    array::wait_till( a_ai, "death" );
    trigger::use( "police_riotshield_color", undefined, undefined, 0 );
}

// Namespace cp_mi_sing_blackstation_police_station
// Params 0
// Checksum 0x1746cb87, Offset: 0x2fd0
// Size: 0x42
function function_37170d4a()
{
    trigger::wait_till( "trigger_cell_guard" );
    spawner::simple_spawn( "cell_guard", &function_1fb3b8c9 );
}

// Namespace cp_mi_sing_blackstation_police_station
// Params 0
// Checksum 0xc9326d74, Offset: 0x3020
// Size: 0x92
function function_1fb3b8c9()
{
    self endon( #"death" );
    self.goalradius = 32;
    level flag::wait_till( "exit_cellblock" );
    wait randomfloatrange( 1, 2.5 );
    self.goalradius = 2048;
    
    if ( level.activeplayers.size )
    {
        self setgoal( level.activeplayers[ randomint( level.activeplayers.size ) ] );
    }
}

// Namespace cp_mi_sing_blackstation_police_station
// Params 2
// Checksum 0x5e3629e, Offset: 0x30c0
// Size: 0xe2
function objective_kane_intro_init( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        level thread blackstation_utility::police_station_corpses();
        blackstation_utility::init_hendricks( "objective_kane_intro" );
        level scene::init( "cin_bla_10_01_kaneintro_3rd_sh010" );
        load::function_a2995f22();
    }
    
    level thread blackstation_utility::player_rain_intensity( "none" );
    level thread kane_intro_igc();
    level flag::wait_till( "flag_kane_intro_complete" );
    level thread namespace_4297372::function_6c35b4f3();
    skipto::objective_completed( "objective_kane_intro" );
}

// Namespace cp_mi_sing_blackstation_police_station
// Params 4
// Checksum 0xb305962c, Offset: 0x31b0
// Size: 0x17a
function objective_kane_intro_done( str_objective, b_starting, b_direct, player )
{
    objectives::set( "cp_level_blackstation_goto_relay" );
    e_floating_trash = getentarray( "floating_trash", "targetname" );
    array::thread_all( e_floating_trash, &util::self_delete );
    e_floating_bodies = arraycombine( getentarray( "subway_corpse_2", "targetname" ), getentarray( "subway_corpse_3", "targetname" ), 1, 0 );
    e_floating_bodies = arraycombine( e_floating_bodies, getentarray( "subway_corpse_floating", "targetname" ), 1, 0 );
    array::thread_all( e_floating_bodies, &util::self_delete );
    array::thread_all( getentarray( "trigger_current", "targetname" ), &blackstation_utility::function_76b75dc7, "blackstation_exterior_engaged" );
}

// Namespace cp_mi_sing_blackstation_police_station
// Params 0
// Checksum 0x647f715, Offset: 0x3338
// Size: 0x11a
function kane_intro_igc()
{
    foreach ( player in level.activeplayers )
    {
        player thread blackstation_utility::function_ed7faf05();
    }
    
    objectives::set( "cp_level_blackstation_comm_relay" );
    
    if ( isdefined( level.bzm_blackstationdialogue4callback ) )
    {
        level thread [[ level.bzm_blackstationdialogue4callback ]]();
    }
    
    level thread namespace_4297372::function_5b1a53ea();
    level scene::add_scene_func( "cin_bla_10_01_kaneintro_3rd_sh190", &function_80a596c6, "play" );
    level scene::add_scene_func( "cin_bla_10_01_kaneintro_3rd_sh190", &function_7a574065, "done" );
    level scene::play( "cin_bla_10_01_kaneintro_3rd_sh010" );
}

// Namespace cp_mi_sing_blackstation_police_station
// Params 1
// Checksum 0xfa952974, Offset: 0x3460
// Size: 0xe2
function function_80a596c6( a_ents )
{
    level.ai_hendricks ai::set_behavior_attribute( "vignette_mode", "slow" );
    level.ai_hendricks setgoal( getnode( "hendricks_node_kane_intro_end", "targetname" ), 1 );
    
    if ( !scene::is_skipping_in_progress() )
    {
        wait 1;
        level.ai_hendricks ai::gun_remove();
        level thread scene::play( "cin_bla_10_01_kaneintro_end_idle" );
        wait 1;
        level.ai_hendricks ai::gun_recall();
        return;
    }
    
    level thread scene::play( "cin_bla_10_01_kaneintro_end_idle" );
}

// Namespace cp_mi_sing_blackstation_police_station
// Params 1
// Checksum 0xed1b1a12, Offset: 0x3550
// Size: 0xb2
function function_7a574065( a_ents )
{
    level flag::set( "flag_kane_intro_complete" );
    level flag::set( "flag_intro_dialog_ended" );
    wait 0.3;
    level.ai_hendricks clearforcedgoal();
    trigger::use( "trig_hendricks_comm_b0", "targetname" );
    level.ai_hendricks ai::set_behavior_attribute( "vignette_mode", "off" );
    util::clear_streamer_hint();
}

