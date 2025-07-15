#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_elevator;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_lotus2_sound;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/cp/lotus_accolades;
#using scripts/cp/lotus_util;
#using scripts/shared/ai/phalanx;
#using scripts/shared/ai/robot_phalanx;
#using scripts/shared/ai_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;

#namespace lotus_detention_center;

// Namespace lotus_detention_center
// Params 2
// Checksum 0x7174a4d7, Offset: 0x1f20
// Size: 0x6a2
function vtol_hallway_main( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        level.ai_hendricks = util::get_hero( "hendricks" );
        level scene::init( "vtol_hallway_ravens", "targetname" );
        scene::skipto_end( "p7_fxanim_cp_lotus_security_station_door_bundle" );
        scene::skipto_end( "p7_fxanim_cp_lotus_monitor_security_bundle" );
        scene::skipto_end_noai( "cin_lot_04_09_security_1st_kickgrate" );
        var_2820f5e9 = getentarray( "security_door_intact", "targetname" );
        array::run_all( var_2820f5e9, &delete );
        level flag::wait_till( "all_players_spawned" );
        skipto::teleport_ai( str_objective );
        level thread function_80318e87();
        lotus_util::function_e58f5689();
        level thread scene::play( "to_detention_center1_initial_bodies", "targetname" );
        load::function_a2995f22();
    }
    
    level.ai_hendricks ai::set_behavior_attribute( "useGrenades", 0 );
    level thread lotus_util::function_e577c596( "vtol_hallway_ravens", getent( "trig_vtol_hallway_ravens", "targetname" ), "vtol_hallway_raven_decals", "cp_lotus_projection_ravengrafitti3" );
    
    if ( sessionmodeiscampaignzombiesgame() )
    {
        thread function_383b165b();
    }
    
    level lotus_util::function_484bc3aa( 0 );
    battlechatter::function_d9f49fba( 0 );
    spawner::add_spawn_function_group( "zipline_guy", "script_noteworthy", &util::magic_bullet_shield );
    spawner::add_spawn_function_group( "zipline_guy", "script_noteworthy", &ai::set_behavior_attribute, "useGrenades", 0 );
    spawner::add_spawn_function_group( "zipline_victims", "targetname", &function_cba3d0d4 );
    spawner::add_spawn_function_group( "vtol_hallway_enemy", "script_noteworthy", &function_f2e34115 );
    spawner::add_spawn_function_group( "vtol_shooting_victim", "targetname", &function_f2e34115 );
    spawner::add_spawn_function_group( "vtol_shooting_victim_robot", "targetname", &function_f2e34115 );
    spawner::add_spawn_function_group( "landing_area_ally_victim", "targetname", &function_959c5937 );
    vehicle::add_spawn_function( "detention_center_vtol", &detention_center_vtol );
    vehicle::add_spawn_function( "lotus_vtol_hallway_destruction_vtol", &function_d3a1377e );
    t_vtol_hallway_door = getent( "vtol_hallway_open_door", "targetname" );
    t_vtol_hallway_door triggerenable( 0 );
    level flag::set( "prometheus_otr_cleared" );
    level thread vtol_hallway_objectives( b_starting );
    level.ai_hendricks ai::set_goal( "hendricks_door_node", "targetname", 1 );
    level.ai_hendricks thread function_ec8c4d64();
    spawn_manager::enable( "sm_vtol_shooting_victims" );
    spawn_manager::enable( "sm_vtol_hallway_robot_spawns" );
    level flag::wait_till( "hendricks_reached_vtol_hallway_door" );
    level thread function_bad9594a();
    t_vtol_hallway_door = getent( "vtol_hallway_open_door", "targetname" );
    t_vtol_hallway_door triggerenable( 1 );
    t_vtol_hallway_door waittill( #"trigger" );
    level thread vtol_zipline();
    level.ai_hendricks thread dialog::say( "hend_friendlys_repelling_0", 2.4 );
    level waittill( #"hash_8c18560c" );
    level flag::set( "zipline_done" );
    
    if ( !sessionmodeiscampaignzombiesgame() )
    {
        function_383b165b();
    }
    
    trigger::use( "hendricks_shooting_starts_color_trigger" );
    level.ai_hendricks ai::set_behavior_attribute( "coverIdleOnly", 0 );
    level waittill( #"hash_facd74a1" );
    level thread scene::play( "p7_fxanim_cp_lotus_vtol_hallway_destruction_01_bundle" );
    vehicle::simple_spawn_single( "lotus_vtol_hallway_destruction_vtol", 1 );
    level thread function_613df5d9( 13.3 );
    var_4c24b478 = getentarray( "ammo_cache", "script_noteworthy" );
    
    foreach ( e_ammo_cache in var_4c24b478 )
    {
        e_ammo_cache.gameobject gameobjects::hide_waypoint();
    }
    
    function_2143f8c4();
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0x570cf431, Offset: 0x25d0
// Size: 0x52
function function_bad9594a()
{
    playsoundatposition( "evt_vtolhallway_walla", ( -5564, 2906, 4158 ) );
    level waittill( #"hash_e54c697" );
    playsoundatposition( "evt_vtolhallway_walla_death", ( -5564, 2906, 4158 ) );
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0x88e6b0cf, Offset: 0x2630
// Size: 0x42
function function_ec8c4d64()
{
    level endon( #"hash_1e0c171f" );
    level.ai_hendricks ai::set_ignoreall( 1 );
    self waittill( #"goal" );
    self ai::set_behavior_attribute( "coverIdleOnly", 1 );
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0xe8658af2, Offset: 0x2680
// Size: 0xab
function function_383b165b()
{
    mdl_door_left = getent( "vtol_hallway_door_left", "targetname" );
    mdl_door_right = getent( "vtol_hallway_door_right", "targetname" );
    mdl_door_left movey( 100, 1 );
    mdl_door_right movey( -100, 1 );
    mdl_door_right waittill( #"movedone" );
    level.ai_hendricks ai::set_ignoreall( 0 );
    level notify( #"hash_1e0c171f" );
}

// Namespace lotus_detention_center
// Params 1
// Checksum 0x27781d67, Offset: 0x2738
// Size: 0xd2
function function_80318e87( b_wait_for_flag )
{
    if ( !isdefined( b_wait_for_flag ) )
    {
        b_wait_for_flag = 0;
    }
    
    level thread scene::init( "p7_fxanim_cp_lotus_vtol_hallway_flyby_bundle" );
    
    if ( b_wait_for_flag )
    {
        flag::wait_till( "security_station_breach_ai_cleared" );
    }
    
    level thread function_9e1bef17();
    trigger::wait_till( "vtol_fly_by" );
    playsoundatposition( "evt_vtolhallway_flyby", ( -7235, 3447, 4079 ) );
    level scene::add_scene_func( "p7_fxanim_cp_lotus_vtol_hallway_flyby_bundle", &function_bb4e63f9, "play" );
    level thread scene::play( "p7_fxanim_cp_lotus_vtol_hallway_flyby_bundle" );
}

// Namespace lotus_detention_center
// Params 1
// Checksum 0x87ad8d5e, Offset: 0x2818
// Size: 0x73
function function_bb4e63f9( a_ents )
{
    foreach ( player in level.players )
    {
        player playrumbleonentity( "cp_lotus_rumble_vtol_hallway_flyby" );
    }
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0x36a87aa5, Offset: 0x2898
// Size: 0x3a
function function_9e1bef17()
{
    level dialog::remote( "kane_lieutenant_khalil_d_0" );
    level dialog::remote( "khal_confirmed_air_suppo_0", 0.5 );
}

// Namespace lotus_detention_center
// Params 1
// Checksum 0xee74f9b9, Offset: 0x28e0
// Size: 0x3a
function vtol_hallway_objectives( b_starting )
{
    if ( b_starting )
    {
        objectives::set( "cp_level_lotus_go_to_taylor_prison_cell" );
    }
    
    objectives::breadcrumb( "vtol_hallway_obj_breadcrumb" );
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0x3fc715fc, Offset: 0x2928
// Size: 0x17a
function vtol_zipline()
{
    level thread vtol_zipline_break_glass();
    level scene::init( "cin_lot_07_02_detcenter_vign_zipline" );
    level waittill( #"zipline_ready" );
    spawn_manager::enable( "sm_vtol_hallway_innocent_runners" );
    spawn_manager::enable( "sm_zipline_victims" );
    level thread kill_enemies_helper();
    trigger::use( "zipline_guys_start_color_trigger" );
    level thread scene::play( "cin_lot_07_02_detcenter_vign_zipline" );
    level waittill( #"hash_facd74a1" );
    e_scene_vtol = getent( "zipline_vtol", "targetname" );
    v_angles = e_scene_vtol.angles;
    e_scene_vtol stopanimscripted();
    wait 0.05;
    e_scene_vtol animation::play( "v_lot_07_02_detcenter_vign_zipline_vtol_depart", struct::get( "align_event_7_2_zipline" ), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 0 );
    e_scene_vtol.angles = v_angles;
    e_scene_vtol movez( 4500, 4 );
    e_scene_vtol waittill( #"movedone" );
    e_scene_vtol delete();
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0x5ae87db3, Offset: 0x2ab0
// Size: 0x6a
function function_cba3d0d4()
{
    self.grenadeammo = 0;
    a_targets = getaiarray( "vtol_hallway_innocent_runners", "targetname" );
    e_target = array::random( a_targets );
    
    if ( isdefined( e_target ) )
    {
        self ai::shoot_at_target( "shoot_until_target_dead", e_target );
    }
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0xdef0ea1b, Offset: 0x2b28
// Size: 0x52
function vtol_zipline_break_glass()
{
    s_break = struct::get( "vtol_zipline_break_glass_struct" );
    level waittill( #"glass_break_zipline_07_02" );
    glassradiusdamage( s_break.origin, -56, 1000, 1000 );
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0x18ecd5ff, Offset: 0x2b88
// Size: 0xc3
function kill_enemies_helper()
{
    level waittill( #"hash_8c18560c" );
    var_c4b22a77 = getaiarray( "zipline_victims", "targetname" );
    var_c033ff4 = getaiarray( "zipline_guy", "targetname" );
    
    foreach ( n_index, var_5eade0e9 in var_c033ff4 )
    {
        var_5eade0e9 thread ai::shoot_at_target( "shoot_until_target_dead", var_c4b22a77[ n_index ] );
    }
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0x55faef90, Offset: 0x2c58
// Size: 0x1a
function detention_center_vtol()
{
    self turret::set_ignore_line_of_sight( 1, 0 );
    level.vh_shooting_vtol = self;
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0x513690c, Offset: 0x2c80
// Size: 0x3a
function function_d3a1377e()
{
    level.var_c35e5e91 = self;
    level.var_c35e5e91 turret::set_max_target_distance( 0.1, 0 );
    level.var_c35e5e91.allowdeath = 0;
}

// Namespace lotus_detention_center
// Params 1
// Checksum 0xe8e312c9, Offset: 0x2cc8
// Size: 0x4fa
function function_613df5d9( var_9597a744 )
{
    wait 2.66;
    n_shoot_time = 0;
    var_9cb86044 = 0;
    s_turret = level.var_c35e5e91.a_turrets[ 0 ];
    s_turret flag::set( "turret manual" );
    level.var_c35e5e91 thread turret::fire_for_time( var_9597a744, 0 );
    level util::clientnotify( "sndDSTR" );
    level thread battlechatter::function_d9f49fba( 0 );
    level thread function_f37f019c();
    level thread function_facc6349( 4 );
    level thread function_1e3790ff( 2 );
    level thread function_5d7e677d( 4 );
    level thread function_7126ab6f( "allies_move_up" );
    wait 2.4;
    n_shoot_time = 2.4;
    var_6356aeef = ( var_9597a744 - 2.4 ) / 13;
    
    while ( n_shoot_time < var_9597a744 )
    {
        n_index = int( ( n_shoot_time - 2.4 ) / var_6356aeef ) + 1;
        n_index = math::clamp( n_index, 1, 13 );
        var_e4b1b0d6 = n_index < 10 ? "vtol_shooting_area0" : "vtol_shooting_area";
        var_5003a2bd = getent( var_e4b1b0d6 + n_index, "targetname" );
        a_ai = [];
        a_ai = getaiteamarray( "axis" );
        a_e_vtol_shooting_aoe_victims = array::filter( a_ai, 0, &filter_istouching, var_5003a2bd );
        
        foreach ( ai_victim in a_e_vtol_shooting_aoe_victims )
        {
            if ( isalive( ai_victim ) )
            {
                if ( isdefined( ai_victim.magic_bullet_shield ) && ai_victim.magic_bullet_shield )
                {
                    ai_victim util::stop_magic_bullet_shield();
                }
                
                if ( !isdefined( ai_victim.var_968edb1e ) )
                {
                    ai_victim.var_968edb1e = 1;
                    ai_victim thread function_8f8d0072();
                }
            }
        }
        
        var_93abd77c = array::filter( level.players, 0, &filter_istouching, var_5003a2bd );
        
        foreach ( player in var_93abd77c )
        {
            player dodamage( player.health, player.origin, undefined, undefined, undefined, "MOD_EXPLOSIVE" );
        }
        
        var_446ac0ad = n_index - 1;
        var_446ac0ad = math::clamp( var_446ac0ad, 1, 13 - 1 );
        var_ade4e252 = function_dbfa70cf( var_446ac0ad );
        var_a8364a58 = array::filter( level.players, 0, &filter_istouching, var_ade4e252 );
        
        foreach ( player in var_a8364a58 )
        {
            earthquake( 1, 0.1, player.origin, 32, player );
            player playrumbleonentity( "slide_loop" );
        }
        
        wait 0.1;
        n_shoot_time += 0.1;
    }
    
    level thread battlechatter::function_d9f49fba( 1 );
    level util::clientnotify( "sndDSTRe" );
    level thread lotus2_sound::function_51e72857();
    level.var_c35e5e91 util::stop_magic_bullet_shield();
    level.var_c35e5e91 thread turret::stop( 0 );
    function_76bada8a( 1 );
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0xf62ba92a, Offset: 0x31d0
// Size: 0xa2
function function_8f8d0072()
{
    wait randomfloatrange( 0, 0.4 );
    str_damage_mod = randomint( 100 ) < 25 ? "MOD_GRENADE_SPLASH" : "MOD_UNKNOWN";
    self playsound( "evt_vtolhallway_dstr_bullet_imp_enemy" );
    self dodamage( self.health, self.origin, undefined, undefined, undefined, str_damage_mod );
    physicsexplosionsphere( self.origin, 32, 16, 100 );
}

// Namespace lotus_detention_center
// Params 2
// Checksum 0x547aeed9, Offset: 0x3280
// Size: 0xa2, Type: bool
function filter_istouching( e_entity, var_8c2d8a7f )
{
    if ( !isarray( var_8c2d8a7f ) )
    {
        var_8c2d8a7f = array( var_8c2d8a7f );
    }
    
    foreach ( e_volume in var_8c2d8a7f )
    {
        if ( e_entity istouching( e_volume ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace lotus_detention_center
// Params 1
// Checksum 0x41e43b5f, Offset: 0x3330
// Size: 0xd1
function function_dbfa70cf( var_65346df )
{
    var_46fcd4c = [];
    
    for ( var_f852a368 = 2; var_65346df > 0 && var_f852a368 > 0 ; var_f852a368-- )
    {
        var_84f20f7 = var_65346df < 10 ? "vtol_shooting_area0" : "vtol_shooting_area";
        var_e318ffa6 = getent( var_84f20f7 + var_65346df, "targetname" );
        
        if ( !isdefined( var_46fcd4c ) )
        {
            var_46fcd4c = [];
        }
        else if ( !isarray( var_46fcd4c ) )
        {
            var_46fcd4c = array( var_46fcd4c );
        }
        
        var_46fcd4c[ var_46fcd4c.size ] = var_e318ffa6;
        var_65346df--;
    }
    
    return var_46fcd4c;
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0xa135219d, Offset: 0x3410
// Size: 0x81
function function_f37f019c()
{
    for ( var_3b86078d = 1; var_3b86078d <= 4 ; var_3b86078d++ )
    {
        s_break = struct::get( "vtol_hallway_break_glass_struct0" + var_3b86078d, "targetname" );
        glassradiusdamage( s_break.origin, -56, 1000, 1000 );
        wait 3.3;
    }
}

// Namespace lotus_detention_center
// Params 1
// Checksum 0xe605c683, Offset: 0x34a0
// Size: 0x3a
function function_7126ab6f( str_notify )
{
    level waittill( str_notify );
    function_76bada8a( 0 );
    trigger::use( "hendricks_exit_vtol_hallway_color_trigger" );
}

// Namespace lotus_detention_center
// Params 1
// Checksum 0x8adb9364, Offset: 0x34e8
// Size: 0x3a
function function_1e3790ff( n_delay )
{
    wait n_delay;
    spawn_manager::kill( "sm_vtol_shooting_victims", 1 );
    spawn_manager::kill( "sm_vtol_hallway_robot_spawns", 1 );
}

// Namespace lotus_detention_center
// Params 1
// Checksum 0x13bedd89, Offset: 0x3530
// Size: 0x72
function function_76bada8a( b_value )
{
    level.ai_hendricks ai::set_behavior_attribute( "sprint", b_value );
    array::thread_all( getentarray( "zipline_guy", "script_noteworthy", 1 ), &ai::set_behavior_attribute, "sprint", b_value );
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0xf9f921de, Offset: 0x35b0
// Size: 0x4a
function function_f2e34115()
{
    self endon( #"death" );
    self ai::set_ignoreall( 1 );
    self.grenadeammo = 0;
    level flag::wait_till( "zipline_done" );
    self ai::set_ignoreall( 0 );
}

// Namespace lotus_detention_center
// Params 1
// Checksum 0x81efb3e0, Offset: 0x3608
// Size: 0x6a
function function_facc6349( n_max_delay )
{
    trigger::wait_or_timeout( n_max_delay, "supplemental_vtol_hallway_victims" );
    var_a08b9452 = getentarray( "supplemental_vtol_hallway_victim", "script_noteworthy" );
    spawner::simple_spawn( var_a08b9452, &function_f2e34115 );
}

// Namespace lotus_detention_center
// Params 1
// Checksum 0xea5e9c23, Offset: 0x3680
// Size: 0x22
function function_5d7e677d( n_delay )
{
    wait n_delay;
    spawn_manager::enable( "sm_vtol_hallway_final_spawns" );
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0x33f29672, Offset: 0x36b0
// Size: 0x213
function function_959c5937()
{
    var_98a5836 = getentarray( "landing_area_ally_victim_ai", "targetname" );
    var_94607bce = var_98a5836.size - 1;
    var_7a9b47b6 = var_94607bce > 1 ? randomfloatrange( -0.5, 0.5 ) * var_94607bce + var_94607bce : 2.5;
    self util::magic_bullet_shield();
    self.grenadeammo = 0;
    level waittill( #"hash_bb05f4d0" );
    trigger::wait_or_timeout( var_7a9b47b6, "kill_landing_area_allies", "targetname" );
    self util::stop_magic_bullet_shield();
    self.health = 1;
    var_d320e401 = struct::get_array( "landing_area_magic_bullet_source", "targetname" );
    a_ai_enemies = getaiteamarray( "axis" );
    weapon = getweapon( "lmg_light" );
    v_target_origin = self.origin + ( 0, 0, 32 );
    
    foreach ( var_6757c7e1 in var_d320e401 )
    {
        var_4b9c2228 = randomintrange( 1, 5 );
        
        do
        {
            magicbullet( weapon, var_6757c7e1.origin, v_target_origin );
            wait randomfloatrange( 0, 0.1 );
            var_4b9c2228--;
        }
        while ( var_4b9c2228 > 0 );
        
        wait randomfloatrange( 0, 0.2 );
    }
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0x4beed465, Offset: 0x38d0
// Size: 0x9a
function function_2143f8c4()
{
    level scene::init( "cin_merch_interior_lower", "targetname" );
    level flag::wait_till_all( array( "sm_sm_vtol_hallway_final_spawns01_cleared", "sm_sm_vtol_hallway_final_spawns02_cleared" ) );
    level notify( #"hash_c243f1de" );
    
    if ( isdefined( level.bzmutil_waitforallzombiestodie ) )
    {
        [[ level.bzmutil_waitforallzombiestodie ]]();
    }
    
    level thread function_29458b95();
    skipto::objective_completed( "vtol_hallway" );
}

// Namespace lotus_detention_center
// Params 4
// Checksum 0xf190b073, Offset: 0x3978
// Size: 0x72
function vtol_hallway_done( str_objective, b_starting, b_direct, player )
{
    level thread util::delay( 1, undefined, &lotus_util::function_6fc3995f );
    getent( "pursuit_oob", "targetname" ) triggerenable( 0 );
}

// Namespace lotus_detention_center
// Params 2
// Checksum 0x79c6403f, Offset: 0x39f8
// Size: 0x36a
function mobile_shop_ride2_main( str_objective, b_starting )
{
    level.var_f2bcf341 = struct::get( "cin_merch_interior_lower", "targetname" );
    level.var_38d7d98e = struct::get( "cin_merch_interior_upper", "targetname" );
    level thread function_97787d8d( "open" );
    battlechatter::function_d9f49fba( 0 );
    
    if ( sessionmodeiscampaignzombiesgame() )
    {
        level thread open_police_station();
    }
    
    if ( b_starting )
    {
        load::function_73adcefc();
        level scene::init( "cin_merch_interior_lower", "targetname" );
        level scene::init( "mobile_shop2_ravens", "targetname" );
        level scene::skipto_end( "p7_fxanim_cp_lotus_vtol_hallway_destruction_01_bundle" );
        level flag::wait_till( "all_players_spawned" );
        level.ai_hendricks = util::get_hero( "hendricks" );
        skipto::teleport_ai( str_objective );
        level.ai_hendricks setgoal( level.ai_hendricks.origin, 1 );
        load::function_a2995f22();
        level thread function_29458b95( b_starting );
    }
    else
    {
        level scene::init( "mobile_shop2_ravens", "targetname" );
    }
    
    level lotus_util::function_484bc3aa( 1 );
    var_4c24b478 = getentarray( "ammo_cache", "script_noteworthy" );
    
    foreach ( e_ammo_cache in var_4c24b478 )
    {
        e_ammo_cache.gameobject gameobjects::show_waypoint();
    }
    
    level thread objectives::breadcrumb( "breadcrumb_mobile_ride_2" );
    flag::wait_till( "long_mobile_shop_start" );
    level scene::init( "p7_fxanim_cp_lotus_mobile_shops_merch_rpg_hit_bundle" );
    objectives::complete( "cp_level_lotus_go_to_taylor_prison_cell" );
    objectives::set( "cp_level_lotus_go_to_taylor_holding_room" );
    level waittill( #"hash_a6da966f" );
    level.var_f2bcf341 scene::stop();
    level.var_38d7d98e thread scene::play();
    function_c92f487e();
    level thread function_9a0b8bc1();
    trigger::wait_till( "mobile_shop_ride2_done" );
    skipto::objective_completed( "mobile_shop_ride2" );
}

// Namespace lotus_detention_center
// Params 1
// Checksum 0x4b93cf24, Offset: 0x3d70
// Size: 0x44a
function function_29458b95( b_starting )
{
    if ( !isdefined( b_starting ) )
    {
        b_starting = 0;
    }
    
    battlechatter::function_d9f49fba( 0 );
    
    if ( !b_starting )
    {
        level.ai_hendricks thread function_edd237d9();
    }
    
    level thread lotus2_sound::function_614dc783();
    level.ai_hendricks dialog::say( "hend_okay_kane_enough_0" );
    level dialog::remote( "kane_take_that_shop_up_to_0" );
    level thread function_aa17eb00();
    level flag::set( "mobile_shop_ride_ready" );
    level thread function_c24a19de();
    level flag::wait_till( "long_mobile_shop_start" );
    
    if ( isdefined( level.bzm_lotusdialogue11callback ) )
    {
        level thread [[ level.bzm_lotusdialogue11callback ]]();
    }
    
    e_playerclip = getent( "mobile_ride_2_playerclip", "targetname" );
    e_playerclip moveto( e_playerclip.origin + ( 0, 0, 100 ), 0.05 );
    level clientfield::set( "vtol_hallway_destruction_cleanup", 1 );
    var_d26fd6e5 = getent( "lotus_vtol_hallway_destruction01", "targetname" );
    var_d26fd6e5 delete();
    level.ai_hendricks ai::set_ignoreall( 1 );
    level thread scene::play( "cin_lot_07_05_detcenter_vign_observation", level.ai_hendricks );
    trigger::wait_till( "hendricks_in_mobile_shop_2", "targetname", level.ai_hendricks );
    level thread function_97787d8d( "close" );
    wait 1.5;
    level thread lotus_util::function_e577c596( "mobile_shop2_ravens", undefined, "raven_decal_mobile_shop2", "cp_lotus_projection_ravengrafitti1" );
    level.ai_hendricks ai::set_ignoreall( 0 );
    sndent = spawn( "script_origin", ( 0, 0, 0 ) );
    sndent playsound( "veh_mobile_shop_ride_start" );
    sndent playloopsound( "veh_mobile_shop_ride_loop" );
    
    foreach ( player in level.activeplayers )
    {
        player playrumbleonentity( "cp_lotus_rumble_mobile_shop_ride_2" );
    }
    
    level thread scene::play( "cin_merch_interior_lower", "targetname" );
    level waittill( #"hash_4e6f08ff" );
    
    foreach ( player in level.activeplayers )
    {
        player playrumbleonentity( "explosion_generic_no_broadcast" );
    }
    
    level notify( #"hash_a6da966f" );
    sndent stoploopsound( 0.3 );
    sndent delete();
    wait 0.3;
    
    foreach ( player in level.players )
    {
        player playrumbleonentity( "explosion_generic_no_broadcast" );
    }
    
    trigger::use( "bridge_battle_more_enemies_here", "script_flag_set" );
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0x6e762f21, Offset: 0x41c8
// Size: 0xeb
function function_c24a19de()
{
    foreach ( player in level.activeplayers )
    {
        if ( isdefined( player.cybercom.var_46a37937 ) )
        {
            foreach ( ai_robot in player.cybercom.var_46a37937 )
            {
                if ( isalive( ai_robot ) )
                {
                    ai_robot kill();
                }
            }
        }
    }
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0xc8a33ff7, Offset: 0x42c0
// Size: 0x42
function function_edd237d9()
{
    nd_goto = getnode( "hendricks_preshop_node", "targetname" );
    self setgoal( nd_goto, 1 );
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0x7ffc4e3f, Offset: 0x4310
// Size: 0x18a
function function_c92f487e()
{
    var_bd1043f3 = struct::get( "mobile_shop_ride_lower" ).origin;
    var_fd7210d4 = struct::get( "mobile_shop_ride_upper" ).origin;
    var_44f2aa45 = var_fd7210d4 - var_bd1043f3;
    level.ai_hendricks forceteleport( level.ai_hendricks.origin + var_44f2aa45, level.ai_hendricks.angles );
    level thread scene::play( "cin_lot_07_05_detcenter_vign_mantle" );
    
    foreach ( player in level.activeplayers )
    {
        player setorigin( player.origin + var_44f2aa45 );
    }
    
    if ( isdefined( level.var_b55b2c5f ) )
    {
        level.var_b55b2c5f scene::stop();
    }
    
    level.var_bd992b54 = struct::get( "cin_merch_exterior_upper", "targetname" );
    
    if ( isdefined( level.var_bd992b54 ) )
    {
        level.var_bd992b54 scene::play();
    }
}

// Namespace lotus_detention_center
// Params 1
// Checksum 0x192f2967, Offset: 0x44a8
// Size: 0x1ba
function function_97787d8d( var_7f0b037 )
{
    if ( !isdefined( var_7f0b037 ) )
    {
        var_7f0b037 = "open";
    }
    
    var_5b3fe023 = getent( "mobile_door_left", "targetname" );
    var_d758a83d = getent( "mobile_door_right", "targetname" );
    var_50de9d38 = 100;
    
    if ( isdefined( var_5b3fe023 ) && isdefined( var_d758a83d ) )
    {
        if ( var_7f0b037 === "open" )
        {
            var_5b3fe023 moveto( var_5b3fe023.origin + ( var_50de9d38 * -1, 0, 0 ), 2, 0.1, 0.1 );
            var_d758a83d moveto( var_d758a83d.origin + ( var_50de9d38, 0, 0 ), 2, 0.1, 0.1 );
            var_5b3fe023 playsound( "evt_mobile_shop_doors_open" );
        }
        else
        {
            var_5b3fe023 moveto( var_5b3fe023.origin + ( var_50de9d38, 0, 0 ), 1, 0.1, 0.1 );
            var_d758a83d moveto( var_d758a83d.origin + ( var_50de9d38 * -1, 0, 0 ), 1, 0.1, 0.1 );
            var_5b3fe023 playsound( "evt_mobile_shop_doors_close" );
        }
        
        return;
    }
    
    /#
        iprintlnbold( "<dev string:x28>" );
    #/
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0x9ad47431, Offset: 0x4670
// Size: 0x332
function function_9a0b8bc1()
{
    foreach ( player in level.players )
    {
        player clientfield::set_to_player( "frost_post_fx", 0 );
    }
    
    e_hatch = getent( "mobile_shop_hatchdoor", "targetname" );
    e_hatch playsound( "wpn_rocket_explode_mobile_shop" );
    self thread fx::play( "mobile_shop_fall_explosion", e_hatch.origin, ( 0, 0, 0 ) );
    wait 0.3;
    self thread fx::play( "mobile_shop_fall_explosion", e_hatch.origin - ( 0, 200, 0 ), ( 0, 0, 0 ) );
    level thread scene::play( "p7_fxanim_cp_lotus_mobile_shops_merch_rpg_hit_bundle" );
    earthquake( 0.85, 1.75, e_hatch.origin, 1200 );
    array::run_all( level.players, &playrumbleonentity, "damage_heavy" );
    objectives::set( "cp_waypoint_breadcrumb", struct::get( "mobile_shop_ride2_last_objective" ) );
    level notify( #"hash_e0df7237" );
    level thread scene::play( "cin_lot_07_05_detcenter_vign_mantle_hatch" );
    var_72a1d37e = spawner::simple_spawn_single( "mobile_ride_2_end_rocketrobot" );
    var_72a1d37e ai::set_ignoreall( 1 );
    var_72a1d37e setgoal( var_72a1d37e.origin, 1 );
    var_72a1d37e.goalradius = 64;
    wait 3;
    s_target = struct::get( "rocketshooter_target" );
    mdl_target = util::spawn_model( "tag_origin", s_target.origin + ( 0, 0, 80 ), s_target.angles );
    mdl_target.health = 9999;
    mdl_target.allowdeath = 0;
    var_72a1d37e thread ai::shoot_at_target( "normal", mdl_target, "tag_origin", 16 );
    var_72a1d37e util::waittill_any_timeout( 16, "damage", "death" );
    
    if ( isalive( var_72a1d37e ) )
    {
        var_72a1d37e.attackeraccuracy = 1;
        var_72a1d37e ai::set_ignoreall( 0 );
    }
    
    mdl_target delete();
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0x4896d56a, Offset: 0x49b0
// Size: 0x10a
function function_aa17eb00()
{
    level dialog::remote( "kane_it_s_routed_to_the_d_0" );
    level flag::wait_till( "long_mobile_shop_start" );
    level dialog::remote( "kane_watch_hendricks_he_0", 0.5 );
    level thread dialog::player_say( "plyr_copy_that_0" );
    level waittill( #"hash_e0df7237" );
    level thread lotus2_sound::function_8ca46216();
    level.ai_hendricks dialog::say( "hend_rpg_0", 0.5 );
    wait 2;
    level dialog::player_say( "plyr_looks_like_this_is_o_0" );
    
    if ( !level flag::get( "trig_player_out_of_mobile_shop_ride_2" ) )
    {
        level dialog::remote( "kane_you_re_just_shy_of_t_0" );
    }
    
    level flag::set( "mobile_shop_2_vo_done" );
}

// Namespace lotus_detention_center
// Params 4
// Checksum 0xdf11aa68, Offset: 0x4ac8
// Size: 0x72
function mobile_shop_ride2_done( str_objective, b_starting, b_direct, player )
{
    if ( b_starting )
    {
        objectives::complete( "cp_level_lotus_go_to_taylor_prison_cell" );
        objectives::set( "cp_level_lotus_go_to_taylor_holding_room" );
    }
    
    level thread scene::init( "to_security_station_mobile_shop_fall", "targetname" );
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0x13a2647f, Offset: 0x4b48
// Size: 0x4a
function remove_gates_for_spawning()
{
    mdl_gate = getent( "hallway_gate_06", "targetname" );
    mdl_gate connectpaths();
    mdl_gate delete();
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0xa8fb34e3, Offset: 0x4ba0
// Size: 0x1e5
function auto_delete()
{
    self endon( #"death" );
    self notify( #"__auto_delete__" );
    self endon( #"__auto_delete__" );
    level flag::wait_till( "all_players_spawned" );
    n_test_count = 0;
    wait 5;
    
    while ( true )
    {
        wait randomfloatrange( 0.666667, 1.33333 );
        n_tests_passed = 0;
        
        foreach ( player in level.players )
        {
            b_in_front = 0;
            b_can_see = 0;
            v_eye = player geteye();
            v_facing = anglestoforward( player getplayerangles() );
            v_to_ent = vectornormalize( self.origin - v_eye );
            n_dot = vectordot( v_facing, v_to_ent );
            
            if ( n_dot > 0.67 )
            {
                b_in_front = 1;
            }
            else
            {
                b_can_see = self sightconetrace( v_eye, player );
            }
            
            if ( !b_can_see && !b_in_front )
            {
                n_tests_passed++;
            }
        }
        
        if ( n_tests_passed == level.players.size )
        {
            n_test_count++;
            
            if ( n_test_count < 5 )
            {
                continue;
            }
            
            self notify( #"_disable_reinforcement" );
            self delete();
            continue;
        }
        
        n_test_count = 0;
    }
}

// Namespace lotus_detention_center
// Params 2
// Checksum 0x40374977, Offset: 0x4d90
// Size: 0x20a
function bridge_battle_main( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        level.ai_hendricks = util::get_hero( "hendricks" );
        trigger::use( "trig_bridge_battle_initial_spawns" );
        skipto::teleport_ai( str_objective );
        load::function_a2995f22();
    }
    
    level lotus_util::function_484bc3aa( 1 );
    level thread lotus_util::its_raining_men();
    level thread function_e1c21e07();
    level thread function_1143b3b4();
    level thread function_2c257bff();
    level thread friendly_sacrifice();
    level thread function_10a2b6f2();
    level thread dc3_slide();
    level thread open_police_station( 1 );
    level thread dc3_rollunder();
    level thread transition_to_dc4();
    level thread lotus_util::function_14be4cad( 1 );
    level thread function_32049a32( b_starting );
    level thread function_44dd1b45();
    level thread function_94f75664();
    sp_enemy = getent( "dc4_enemy_sponge", "script_noteworthy" );
    sp_enemy spawner::add_spawn_function( &dc4_enemy_sponge );
    level thread scene::play( "bridge_battle_falling_shop1", "targetname" );
    level flag::wait_till( "bridge_battle_done" );
    skipto::objective_completed( "bridge_battle" );
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0x5d11bf60, Offset: 0x4fa8
// Size: 0xc3
function function_94f75664()
{
    level flag::wait_till( "player_crossed_bridge" );
    var_9008f0c7 = getent( "bridge_battle_across_gv", "targetname" );
    a_enemies = spawner::get_ai_group_ai( "bridge_end_enemies" );
    
    foreach ( enemy in a_enemies )
    {
        enemy setgoal( var_9008f0c7 );
    }
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0xd4682e5e, Offset: 0x5078
// Size: 0x3a
function function_e1c21e07()
{
    level endon( #"bridge_battle_done" );
    level thread function_c928a4b5( "bridge_end_enemies" );
    level thread function_c928a4b5( "police_station_enemies" );
}

// Namespace lotus_detention_center
// Params 1
// Checksum 0x549c44f9, Offset: 0x50c0
// Size: 0x32
function function_c928a4b5( str_ai_group )
{
    level endon( #"bridge_battle_done" );
    spawner::waittill_ai_group_cleared( str_ai_group );
    savegame::checkpoint_save();
}

// Namespace lotus_detention_center
// Params 1
// Checksum 0xe4a387d8, Offset: 0x5100
// Size: 0xda
function function_32049a32( b_starting )
{
    battlechatter::function_d9f49fba( 0 );
    
    if ( !b_starting )
    {
        level flag::wait_till( "mobile_shop_2_vo_done" );
    }
    
    dialog::remote( "kane_follow_the_marker_0", 1 );
    dialog::player_say( "plyr_copy_that_kane_0", 0.25 );
    battlechatter::function_d9f49fba( 1 );
    flag::wait_till( "bridge_battle_police_station_opened" );
    battlechatter::function_d9f49fba( 0 );
    level.ai_hendricks dialog::say( "hend_raps_comin_in_hot_0", 0.5 );
    battlechatter::function_d9f49fba( 1 );
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0xd74c8a23, Offset: 0x51e8
// Size: 0x1d2
function function_44dd1b45()
{
    spawner::waittill_ai_group_amount_killed( "bb_start_enemies", 2 );
    var_67ac5172 = getent( "cult_center_door_left", "targetname" );
    var_43ecc01c = getent( "cult_center_door_right", "targetname" );
    var_46f41a3b = 100;
    var_7d6af5ea = 1;
    var_67ac5172 moveto( var_67ac5172.origin + ( 0, var_46f41a3b, 0 ), var_7d6af5ea, 0.1, 0.1 );
    var_43ecc01c moveto( var_43ecc01c.origin + ( 0, var_46f41a3b * -1, 0 ), var_7d6af5ea, 0.1, 0.1 );
    wait var_7d6af5ea;
    spawn_manager::enable( "bb_nolull_spawn_manager" );
    
    /#
        iprintlnbold( "<dev string:x60>" );
    #/
    
    level flag::wait_till( "player_crossed_bridge" );
    spawn_manager::disable( "bb_nolull_spawn_manager" );
    var_67ac5172 moveto( var_67ac5172.origin + ( 0, var_46f41a3b * -1, 0 ), var_7d6af5ea, 0.1, 0.1 );
    var_43ecc01c moveto( var_43ecc01c.origin + ( 0, var_46f41a3b, 0 ), var_7d6af5ea, 0.1, 0.1 );
    
    /#
        iprintlnbold( "<dev string:x81>" );
    #/
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0xd7f9e0f3, Offset: 0x53c8
// Size: 0x1a
function function_1143b3b4()
{
    objectives::breadcrumb( "bridge_battle_breadcrumb01" );
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0xddc0f47d, Offset: 0x53f0
// Size: 0xd2
function function_2c257bff()
{
    var_8cc44767 = getnode( "cover_endbridge_trashbin", "targetname" );
    setenablenode( var_8cc44767, 0 );
    flag::wait_till( "flag_coverpush_endbridge" );
    function_f423b892( "coverpush_endbridge_pos", "coverpush_endbridge_enemy", "coverpush_endbridge_bin" );
    setenablenode( var_8cc44767, 1 );
    flag::wait_till( "bridge_battle_police_station_opened" );
    function_f423b892( "coverpush_pos2", "coverpush_enemy2", "coverpush_trash_bin2" );
}

// Namespace lotus_detention_center
// Params 3
// Checksum 0x294582ef, Offset: 0x54d0
// Size: 0x11a
function function_f423b892( str_position, var_7fadc70c, var_e7daaecc )
{
    var_a6ebc7b = getent( var_e7daaecc, "targetname" );
    var_f43c5188 = getent( var_e7daaecc + "_col", "targetname" );
    var_f43c5188 linkto( var_a6ebc7b );
    struct_pos = struct::get( str_position, "targetname" );
    var_b429251f = spawner::simple_spawn_single( var_7fadc70c );
    struct_pos scene::init( "cin_gen_aie_push_cover_sideways_no_dynpath", array( var_b429251f, var_a6ebc7b ) );
    struct_pos scene::play( "cin_gen_aie_push_cover_sideways_no_dynpath" );
    var_f43c5188 unlink();
    var_f43c5188 disconnectpaths( 0, 0 );
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0x3a76043c, Offset: 0x55f8
// Size: 0x1a2
function function_10a2b6f2()
{
    level thread function_e90c24f8();
    flag::wait_till( "flag_grand_entrances" );
    
    /#
        iprintlnbold( "<dev string:xbe>" );
    #/
    
    spawner::add_spawn_function_group( "robo_entrant01", "targetname", &function_87c91b1b );
    spawner::add_spawn_function_group( "robo_entrant02", "targetname", &function_87c91b1b );
    spawner::add_spawn_function_group( "robo_entrant03", "targetname", &function_87c91b1b );
    spawner::add_spawn_function_group( "robo_entrant04", "targetname", &function_87c91b1b );
    level thread lotus_util::function_99514074( "robo_entrance01", "robo_entrant01" );
    wait 0.75;
    level thread lotus_util::function_99514074( "robo_entrance02", "robo_entrant02" );
    wait 1.5;
    level thread lotus_util::function_99514074( "robo_entrance04", "robo_entrant04" );
    wait 1.5;
    level thread lotus_util::function_99514074( "robo_entrance03", "robo_entrant03" );
    wait 1.5;
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0x3130450b, Offset: 0x57a8
// Size: 0x52
function function_e90c24f8()
{
    level endon( #"flag_grand_entrances" );
    level flag::wait_till( "player_crossed_bridge" );
    spawner::waittill_ai_group_count( "bridge_end_enemies", 3 );
    level flag::set( "flag_grand_entrances" );
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0x39db6dc1, Offset: 0x5808
// Size: 0x42
function function_87c91b1b()
{
    volume = getent( "bridge_battle_ge_gv", "targetname" );
    self setgoal( volume );
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0x75dced8b, Offset: 0x5858
// Size: 0x52
function transition_to_dc4()
{
    a_flags = array( "wall_run_enemies_cleared", "bridge_battle_done" );
    level flag::wait_till_any( a_flags );
    level thread function_e7a8c6b();
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0x2ca9f29e, Offset: 0x58b8
// Size: 0x122
function friendly_sacrifice()
{
    ai_friendly = spawner::simple_spawn_single( "dc3_friendly_scarifice" );
    util::magic_bullet_shield( ai_friendly );
    level flag::wait_till( "friendly_sacrifice" );
    nd_sacrifice = getnode( "scarifice_goal", "targetname" );
    ai_friendly thread ai::force_goal( nd_sacrifice, 64, undefined, undefined, undefined, undefined );
    ai_friendly ai::set_ignoreall( 1 );
    trigger::wait_till( "trig_sacrifice_death" );
    ai_friendly ai::set_ignoreall( 0 );
    util::stop_magic_bullet_shield( ai_friendly );
    a_enemies = getaiteamarray( "axis" );
    array::thread_all( a_enemies, &ai::shoot_at_target, "kill_within_time", ai_friendly, undefined, 0.05 );
}

// Namespace lotus_detention_center
// Params 1
// Checksum 0x40e95829, Offset: 0x59e8
// Size: 0x183
function open_police_station( b_trigger_wait )
{
    if ( !( isdefined( level.var_38c1711f ) && level.var_38c1711f ) )
    {
        level.var_38c1711f = 1;
        var_a7b48bf5 = getent( "police_door_01", "targetname" );
        var_a7b48bf5 moveto( var_a7b48bf5.origin + ( 0, 0, -144 ), 3 );
        var_cdb7065e = getent( "police_door_02", "targetname" );
        var_cdb7065e moveto( var_cdb7065e.origin + ( 0, 0, -144 ), 3 );
    }
    
    if ( isdefined( b_trigger_wait ) && b_trigger_wait )
    {
        trigger::wait_till( "trig_kill_sniper" );
        a_snipers = getaiarray( "dc3_police_sniper", "script_noteworthy" );
        
        foreach ( ai_sniper in a_snipers )
        {
            level.ai_hendricks ai::shoot_at_target( "kill_within_time", ai_sniper, undefined, 0.05 );
        }
    }
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0x50b59eec, Offset: 0x5b78
// Size: 0xaa
function dc3_rollunder()
{
    trigger::wait_till( "trig_rollunder" );
    level thread closing_rollunder_door();
    ai_rollunder = spawner::simple_spawn_single( "rollunder_smg" );
    level scene::play( "detention_center3_rollunder", "targetname", ai_rollunder );
    volume = getent( "bridge_battle_ge_gv", "targetname" );
    ai_rollunder setgoal( volume );
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0x831e59cf, Offset: 0x5c30
// Size: 0x9a
function dc3_slide()
{
    trigger::wait_till( "trig_slide" );
    ai_slide = spawner::simple_spawn_single( "slide_smg" );
    level scene::play( "detention_center3_slide", "targetname", ai_slide );
    volume = getent( "bridge_battle_ge_gv", "targetname" );
    ai_slide setgoal( volume );
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0xba4ce462, Offset: 0x5cd8
// Size: 0x72
function closing_rollunder_door()
{
    mdl_door = getent( "spawn_door7_5_1", "targetname" );
    mdl_door moveto( mdl_door.origin + ( 0, 0, -136 ), 6 );
    mdl_door waittill( #"movedone" );
    mdl_door disconnectpaths();
}

// Namespace lotus_detention_center
// Params 4
// Checksum 0x83f603e, Offset: 0x5d58
// Size: 0x8a
function bridge_battle_done( str_objective, b_starting, b_direct, player )
{
    s_glass_squib = struct::get( "s_glass_squib", "targetname" );
    
    if ( isdefined( s_glass_squib ) )
    {
        /#
            iprintlnbold( "<dev string:xd8>" );
        #/
        
        glassradiusdamage( s_glass_squib.origin, -106, 50, 50 );
    }
}

// Namespace lotus_detention_center
// Params 2
// Checksum 0x292890e3, Offset: 0x5df0
// Size: 0x30a
function up_to_detention_center_main( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        level.ai_hendricks = util::get_hero( "hendricks" );
        skipto::teleport_ai( str_objective );
        sp_enemy = getent( "dc4_enemy_sponge", "script_noteworthy" );
        sp_enemy spawner::add_spawn_function( &dc4_enemy_sponge );
        level thread open_police_station();
        level thread closing_rollunder_door();
        level thread function_e7a8c6b();
        level thread lotus_util::its_raining_men();
        level thread lotus_util::function_14be4cad();
        load::function_a2995f22();
        level lotus_util::function_484bc3aa( 1 );
    }
    
    level infirmary_glass_triggers();
    lotus_util::function_fe64b86b( "falling_nrc", struct::get( "wallrun_corpse1" ), 0 );
    level thread dc4_friendly_sacrifice();
    level thread dc4_fleeing_enemy();
    level thread dc4_jump_out();
    level thread function_dcd3f360();
    level thread dc4_upper_gate();
    level thread function_3604a049();
    level thread function_2ff2c34();
    level thread function_4753f046();
    level thread function_cb2b9cbf();
    spawner::add_spawn_function_group( "siegebot_hospital", "script_noteworthy", &function_fd8c0654 );
    spawner::add_spawn_function_group( "siegebot_hospital", "script_noteworthy", &function_dce6e561 );
    level flag::init( "hospital_door_up" );
    level flag::init( "dc4_dead_siegebots" );
    
    foreach ( player in level.players )
    {
        player clientfield::set_to_player( "siegebot_fans", 1 );
    }
    
    level flag::wait_till( "up_to_detention_center_done" );
    skipto::objective_completed( "up_to_detention_center" );
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0x95f9b657, Offset: 0x6108
// Size: 0x8b
function infirmary_glass_triggers()
{
    var_b6a97ee5 = getentarray( "infirmary_glass_triggers", "script_noteworthy" );
    
    foreach ( t_glass in var_b6a97ee5 )
    {
        t_glass thread function_aa11d0bb();
    }
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0x65639136, Offset: 0x61a0
// Size: 0x52
function function_aa11d0bb()
{
    self trigger::wait_till();
    var_25cdefbd = struct::get( self.target );
    glassradiusdamage( var_25cdefbd.origin, 20, -56, -56 );
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0xc677df8f, Offset: 0x6200
// Size: 0xab
function function_2ff2c34()
{
    level endon( #"up_to_detention_center_done" );
    trigger::wait_till( "use_up_to_detention_center_triggers" );
    a_triggers = getentarray( "up_to_detention_center_triggers", "script_noteworthy" );
    
    foreach ( trigger in a_triggers )
    {
        trigger trigger::use( undefined, undefined, undefined, 0 );
    }
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0xf3e165f9, Offset: 0x62b8
// Size: 0xea
function function_3604a049()
{
    v_start = struct::get( "s_dc_phalanx_start" ).origin;
    v_end = struct::get( "s_dc_phalanx_end" ).origin;
    var_f835ddae = getent( "sp_dc_phalanx", "targetname" );
    var_de3c864 = new phalanx();
    [[ var_de3c864 ]]->initialize( "phalanx_reverse_wedge", v_start, v_end, 2, 5, var_f835ddae, var_f835ddae );
    level flag::wait_till( "dc4_dead_siegebots" );
    var_de3c864 phalanx::scatterphalanx();
    var_f835ddae delete();
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0xaa52ad7f, Offset: 0x63b0
// Size: 0x5a
function function_dce6e561()
{
    if ( !isdefined( level.var_922b7c07 ) )
    {
        level.var_922b7c07 = 0;
    }
    
    level.var_922b7c07++;
    level endon( #"dc4_dead_siegebots" );
    self waittill( #"death" );
    level.var_922b7c07--;
    
    if ( level.var_922b7c07 <= 0 )
    {
        level flag::set( "dc4_dead_siegebots" );
    }
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0x7dd20fa9, Offset: 0x6418
// Size: 0x3a
function function_fd8c0654()
{
    self vehicle_ai::start_scripted();
    level flag::wait_till( "hospital_door_up" );
    self vehicle_ai::stop_scripted();
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0x3f7e5d17, Offset: 0x6460
// Size: 0x6a
function function_cb2b9cbf()
{
    level endon( #"up_to_detention_center_done" );
    battlechatter::function_d9f49fba( 0 );
    flag::wait_till( "start_up_to_detention_center" );
    battlechatter::function_d9f49fba( 1 );
    flag::wait_till( "trig_spawn_detention_center_kicked_guy" );
    battlechatter::function_d9f49fba( 0 );
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0x32a0c651, Offset: 0x64d8
// Size: 0x1a
function function_4753f046()
{
    objectives::breadcrumb( "up_to_detention_center_breadcrumb01" );
}

// Namespace lotus_detention_center
// Params 4
// Checksum 0x3ecbe0c5, Offset: 0x6500
// Size: 0x3a
function up_to_detention_center_done( str_objective, b_starting, b_direct, player )
{
    objectives::complete( "cp_level_lotus_go_to_taylor_prison_cell" );
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0xa128e047, Offset: 0x6548
// Size: 0x92
function function_39a310be()
{
    flag::wait_till( "spawn_doomed_rapper" );
    var_d031ee03 = spawner::simple_spawn_single( "doomed_rapper" );
    var_d031ee03.overrideactordamage = &function_f0ce2a2f;
    flag::wait_till( "rapper_is_doomed" );
    
    if ( isalive( var_d031ee03 ) )
    {
        var_d031ee03 function_5c93563b();
    }
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0x9faf9366, Offset: 0x65e8
// Size: 0x132
function function_5c93563b()
{
    self endon( #"death" );
    var_29839a5c = getnode( "doomed_rapper_pos", "targetname" );
    self ai::force_goal( var_29839a5c.origin, 5, 1, undefined, undefined, 1 );
    
    while ( distance2d( self.origin, var_29839a5c.origin ) > 100 )
    {
        wait 1;
    }
    
    ai_raps = spawner::simple_spawn_single( "raps_doomer" );
    ai_raps setspeed( 19 );
    
    foreach ( var_5c4b8c35 in level.players )
    {
        self setignoreent( var_5c4b8c35, 1 );
    }
    
    ai_raps setentitytarget( self );
    self thread function_b80c1b50( ai_raps );
}

// Namespace lotus_detention_center
// Params 12
// Checksum 0x3060b8f2, Offset: 0x6728
// Size: 0x8d
function function_f0ce2a2f( e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, n_model_index, psoffsettime, str_bone_name )
{
    if ( e_inflictor.archetype === "raps" )
    {
        n_damage = self.health;
    }
    else
    {
        n_damage = 0;
    }
    
    return n_damage;
}

// Namespace lotus_detention_center
// Params 1
// Checksum 0x43ccbf51, Offset: 0x67c0
// Size: 0x112
function function_b80c1b50( ai_raps )
{
    if ( isdefined( ai_raps ) && ai_raps.archetype === "raps" )
    {
        self waittill( #"death", idamage, smeansofdeath, weapon, shitloc, vdir );
        
        if ( isdefined( ai_raps ) )
        {
            v_dir = anglestoforward( ai_raps.angles ) + anglestoup( ai_raps.angles ) * 0.5;
            v_dir *= 64;
            self startragdoll();
            self launchragdoll( ( v_dir[ 0 ], v_dir[ 1 ], v_dir[ 2 ] + 32 ) );
            
            if ( isalive( ai_raps ) )
            {
                ai_raps kill();
            }
        }
    }
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0xeedc09c7, Offset: 0x68e0
// Size: 0xaa
function dc4_jump_out()
{
    ai_enemy = spawner::simple_spawn_single( "dc4_jump_out" );
    ai_enemy ai::set_ignoreall( 1 );
    trigger::wait_till( "trig_fleeing_enemy" );
    
    if ( isdefined( ai_enemy ) )
    {
        ai_enemy ai::set_ignoreall( 0 );
        nd_jump_out = getnode( "jump_out_dest", "targetname" );
        ai_enemy setgoal( nd_jump_out, 0, 64 );
    }
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0xddabc214, Offset: 0x6998
// Size: 0x282
function function_e7a8c6b()
{
    if ( flag::get( "wall_run_enemies_cleared" ) )
    {
        var_ad0cc537 = struct::get( "hendricks_uptodc_wallrun_waitpos", "targetname" );
        level.ai_hendricks setgoal( var_ad0cc537.origin, 1 );
        
        if ( level flag::get( "all_players_spawned" ) )
        {
            var_72bda784 = distance2d( level.players[ 0 ].origin, level.ai_hendricks.origin );
            var_cf29ba8c = 300;
            
            while ( var_72bda784 > var_cf29ba8c )
            {
                /#
                #/
                
                wait 0.5;
                var_72bda784 = distance2d( level.players[ 0 ].origin, level.ai_hendricks.origin );
            }
        }
        else
        {
            level flag::wait_till( "all_players_spawned" );
        }
    }
    
    util::delay( randomfloatrange( 2, 4 ), undefined, &lotus_util::function_fe64b86b, "falling_nrc", struct::get( "wallrun_corpse2" ), 0 );
    level thread scene::play( "to_security_station_mobile_shop_fall", "targetname" );
    level thread scene::play( "cin_lot_07_05_detcenter_vign_wallrun_hendricks" );
    level.ai_hendricks waittill( #"goal" );
    util::delay( randomfloat( 2 ), undefined, &lotus_util::function_fe64b86b, "falling_nrc", struct::get( "wallrun_corpse3" ), 0 );
    t_up_to_detention = getent( "trig_dc4_hendricks", "targetname" );
    
    if ( isdefined( t_up_to_detention ) )
    {
        t_up_to_detention trigger::use();
    }
    
    lotus_util::function_fe64b86b( "falling_nrc", struct::get( "wallrun_corpse3" ), 0 );
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0x52de59f5, Offset: 0x6c28
// Size: 0x1a
function dc4_enemy_sponge()
{
    self.overrideactordamage = &dc4_enemy_sponge_override;
}

// Namespace lotus_detention_center
// Params 12
// Checksum 0xd0a7f4f6, Offset: 0x6c50
// Size: 0x7b
function dc4_enemy_sponge_override( e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, weapon, v_point, v_dir, str_hit_loc, psoffsettime, boneindex, n_model_index )
{
    if ( !isplayer( e_attacker ) )
    {
        n_damage = 0;
    }
    
    return n_damage;
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0x44c5775d, Offset: 0x6cd8
// Size: 0x152
function dc4_friendly_sacrifice()
{
    ai_friendly = spawner::simple_spawn_single( "dc4_friendly_sacrifice" );
    ai_friendly.overrideactordamage = &dc4_friendly_damage_override;
    ai_friendly ai::set_ignoreme( 1 );
    var_9999ca8a = spawner::simple_spawn_single( "dc4_deadly_rap", &function_ca258604 );
    level scene::init( "cin_lot_07_05_detcenter_vign_rapsdeath", array( var_9999ca8a, ai_friendly ) );
    flag::wait_till( "dc4_friendly_sacrifice" );
    level thread scene::skipto_end( "cin_lot_07_05_detcenter_vign_rapsdeath", undefined, undefined, 0.4 );
    ai_shooter = spawner::simple_spawn_single( "rapsdeath_shooter" );
    
    if ( isalive( ai_friendly ) )
    {
        ai_shooter thread ai::shoot_at_target( "normal", ai_friendly, undefined, 2 );
    }
    
    trigger::use( "trig_hendricks_r01utd", "targetname" );
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0xad7248bd, Offset: 0x6e38
// Size: 0x62
function function_ca258604()
{
    var_9999ca8a = self;
    var_9999ca8a ai::set_ignoreall( 1 );
    util::magic_bullet_shield( var_9999ca8a );
    level waittill( #"hash_c1151572" );
    var_9999ca8a ai::set_ignoreall( 0 );
    util::stop_magic_bullet_shield( var_9999ca8a );
}

// Namespace lotus_detention_center
// Params 12
// Checksum 0xa533c7d9, Offset: 0x6ea8
// Size: 0x93
function dc4_friendly_damage_override( e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, weapon, v_point, v_dir, str_hit_loc, psoffsettime, boneindex, n_model_index )
{
    if ( isdefined( e_attacker.archetype ) && e_attacker.archetype == "raps" )
    {
        n_damage = 100;
    }
    else
    {
        n_damage = 0;
    }
    
    return n_damage;
}

// Namespace lotus_detention_center
// Params 1
// Checksum 0xb62cc923, Offset: 0x6f48
// Size: 0x7d
function rap_proximity_explosion( ai_friendly )
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( isdefined( ai_friendly ) )
        {
            n_dist_2d_sq = distance2dsquared( ai_friendly.origin, self.origin );
            
            if ( n_dist_2d_sq < 4096 )
            {
                self dodamage( self.health, self.origin );
            }
        }
        
        wait 0.05;
    }
}

// Namespace lotus_detention_center
// Params 15
// Checksum 0x7579060c, Offset: 0x6fd0
// Size: 0xc3
function rap_damage_override( e_inflictor, e_attacker, n_damage, n_idflags, str_means_of_death, weapon, v_point, v_dir, str_hit_loc, v_damage_origin, n_psoffsettime, b_damage_from_underneath, n_model_index, str_part_name, v_surface_normal )
{
    if ( isdefined( str_means_of_death ) && str_means_of_death == "MOD_UNKNOWN" )
    {
        n_damage = n_damage;
    }
    else if ( isplayer( e_attacker ) )
    {
        n_damage *= 0.09;
    }
    else
    {
        n_damage = 0;
    }
    
    return n_damage;
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0x563e1904, Offset: 0x70a0
// Size: 0xd2
function dc4_fleeing_enemy()
{
    trigger::wait_till( "trig_fleeing_enemy" );
    ai_enemy = spawner::simple_spawn_single( "dc4_fleeing_enemy" );
    ai_enemy endon( #"death" );
    nd_fleeing = getnode( "fleeing_enemy_path", "targetname" );
    ai_enemy ai::force_goal( nd_fleeing, 64, 0, undefined, undefined, 1 );
    ai_enemy waittill( #"goal" );
    nd_fleeing = getnode( "fleeing_enemy_node", "targetname" );
    ai_enemy ai::force_goal( nd_fleeing, 64, 0, undefined, undefined, 1 );
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0xabef1972, Offset: 0x7180
// Size: 0x17a
function function_dcd3f360()
{
    mdl_door = getent( "spawn_door7_5_2", "targetname" );
    mdl_door moveto( mdl_door.origin - ( 0, 0, -112 ), 0.1 );
    trigger::wait_till( "trig_dc4_door" );
    level exploder::exploder( "fx_interior_sentry_reveal" );
    mdl_door = getent( "spawn_door7_5_2", "targetname" );
    mdl_door moveto( mdl_door.origin + ( 0, 0, 12 ), 1 );
    mdl_door waittill( #"movedone" );
    mdl_door playsound( "evt_siegebot_door_buzz" );
    wait 1.25;
    mdl_door playsound( "evt_siegebot_door" );
    mdl_door moveto( mdl_door.origin + ( 0, 0, -112 - 12 ), 3 );
    mdl_door waittill( #"movedone" );
    level flag::set( "hospital_door_up" );
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0xb830812b, Offset: 0x7308
// Size: 0x102
function dc4_upper_gate()
{
    mdl_door = getent( "hosp_hall_gate_10", "targetname" );
    
    if ( isdefined( mdl_door ) )
    {
        mdl_door moveto( mdl_door.origin + ( 0, 0, 145 ), 1 );
    }
    
    var_50de9d38 = 100;
    mdl_door_left = getent( "hosp_hall_gate_10_L", "targetname" );
    mdl_door_left moveto( mdl_door_left.origin + ( 0, var_50de9d38 * -1, 0 ), 1 );
    mdl_door_right = getent( "hosp_hall_gate_10_R", "targetname" );
    mdl_door_right moveto( mdl_door_right.origin + ( 0, var_50de9d38, 0 ), 1 );
}

// Namespace lotus_detention_center
// Params 2
// Checksum 0xa8588b53, Offset: 0x7418
// Size: 0x46a
function detention_center_main( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        level.ai_hendricks = util::get_hero( "hendricks" );
        skipto::teleport_ai( str_objective );
        load::function_a2995f22();
        level lotus_util::function_484bc3aa( 1 );
    }
    
    lotus_util::function_3b6587d6( 0, "lotus2_standdown_igc_umbra_gate" );
    lotus_accolades::function_a2c4c634();
    var_d6cea0d7 = getent( "trig_kick_door", "targetname" );
    
    if ( isdefined( var_d6cea0d7 ) )
    {
        var_d6cea0d7 triggerenable( 0 );
    }
    
    level thread function_3699620f();
    level thread function_896c40b9();
    level thread function_ab3d9328();
    mdl_door_left = getent( "det_door_prometheus_01_L", "targetname" );
    mdl_door_right = getent( "det_door_prometheus_01_R", "targetname" );
    mdl_door_left moveto( mdl_door_left.origin + ( 0, 54, 0 ), 1, 0.25, 0.25 );
    mdl_door_right moveto( mdl_door_right.origin + ( 0, -54, 0 ), 1, 0.25, 0.25 );
    battlechatter::function_d9f49fba( 0 );
    level thread function_14273be5();
    level thread detention_center_fallback( "dc_fallback_0" );
    level thread detention_center_fallback( "dc_fallback_1" );
    level thread detention_center_fallback( "dc_fallback_2" );
    level thread detention_center_force_stairs();
    level thread detention_center_pamws();
    level thread detention_center_phalanx();
    level thread function_fefb4f44();
    wait 1;
    level thread function_19cafdb6();
    level notify( #"raining_men" );
    var_c77d7d8e = getent( "trig_go_hendricks_after_kick", "targetname" );
    
    if ( isdefined( var_c77d7d8e ) )
    {
        var_c77d7d8e trigger::use();
    }
    
    e_door_clip = getent( "detention_center_door_clip", "targetname" );
    e_door_clip notsolid();
    trigger::wait_till( "trig_all_players_at_stand_down", "targetname", level.ai_hendricks );
    
    foreach ( player in level.players )
    {
        player clientfield::set_to_player( "siegebot_fans", 0 );
    }
    
    e_door_clip solid();
    mdl_door_left moveto( mdl_door_left.origin + ( 0, -54, 0 ), 1, 0.25, 0.25 );
    mdl_door_right moveto( mdl_door_right.origin + ( 0, 54, 0 ), 1, 0.25, 0.25 );
    level scene::init( "cin_lot_08_01_standdown_sh010" );
    skipto::objective_completed( "detention_center" );
    level notify( #"detention_center_done" );
    level.ai_hendricks colors::enable();
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0xc9a60be3, Offset: 0x7890
// Size: 0xca
function function_14273be5()
{
    level endon( #"detention_center_done" );
    level flag::wait_till( "players_made_it_to_stand_down" );
    level.ai_hendricks colors::disable();
    level.ai_hendricks ai::set_behavior_attribute( "sprint", 1 );
    level.ai_hendricks setgoal( getnode( "hendricks_stand_down_door_node", "targetname" ), 0, 32 );
    level.ai_hendricks.allowbattlechatter[ "bc" ] = 0;
    level.ai_hendricks ai::set_behavior_attribute( "coverIdleOnly", 1 );
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0x77740028, Offset: 0x7968
// Size: 0x3a
function function_3699620f()
{
    battlechatter::function_d9f49fba( 0 );
    flag::wait_till( "start_detention_center_action" );
    battlechatter::function_d9f49fba( 1 );
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0x8278f44e, Offset: 0x79b0
// Size: 0x52
function function_896c40b9()
{
    level endon( #"detention_center_done" );
    level thread function_ca30eede( "aigroup_detention_center" );
    level thread function_c928a4b5( "dc_wave_1" );
    level thread function_c928a4b5( "dc_wave_2" );
}

// Namespace lotus_detention_center
// Params 1
// Checksum 0xe509d008, Offset: 0x7a10
// Size: 0x32
function function_ca30eede( str_ai_group )
{
    level endon( #"detention_center_done" );
    spawner::waittill_ai_group_cleared( str_ai_group );
    savegame::checkpoint_save();
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0x980adfa, Offset: 0x7a50
// Size: 0x13a
function function_ab3d9328()
{
    battlechatter::function_d9f49fba( 0 );
    level dialog::remote( "kane_entrance_is_ahead_on_0", 0.75 );
    flag::wait_till( "entering_detention_center" );
    level thread util::set_streamer_hint( 2, 1 );
    level dialog::remote( "kane_reinforcements_have_0" );
    level.ai_hendricks dialog::say( "hend_tell_us_something_we_0", 0.25 );
    battlechatter::function_d9f49fba( 1 );
    flag::wait_till( "flag_nrc_hounds_moving_in" );
    level dialog::remote( "kane_taylor_s_secured_the_0", 0.25 );
    level dialog::remote( "kane_hang_tight_few_more_0", 3 );
    level dialog::remote( "kane_access_restored_0", 3 );
    level dialog::player_say( "plyr_copy_that_kane_we_0", 0.5 );
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0x563b7d5c, Offset: 0x7b98
// Size: 0x62
function function_fefb4f44()
{
    var_87248a54 = getent( "trig_end_enemies", "targetname" );
    var_87248a54 endon( #"trigger" );
    spawner::waittill_ai_group_cleared( "dc_wave_1" );
    trigger::use( "trig_end_enemies" );
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0x3535bba, Offset: 0x7c08
// Size: 0x1a
function function_19cafdb6()
{
    objectives::breadcrumb( "detention_center_breadcrumb01" );
}

// Namespace lotus_detention_center
// Params 1
// Checksum 0xd9d5fe0, Offset: 0x7c30
// Size: 0xe3
function detention_center_fallback( str_trigger )
{
    t_fallback = getent( str_trigger, "targetname" );
    t_fallback waittill( #"trigger" );
    e_goal_volume = getent( t_fallback.target, "targetname" );
    a_enemies = getaiarray( "dc_bottom", "script_noteworthy" );
    
    foreach ( ai_enemy in a_enemies )
    {
        ai_enemy setgoal( e_goal_volume, 1 );
    }
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0x8e42fe87, Offset: 0x7d20
// Size: 0x62
function detention_center_force_stairs()
{
    trigger::wait_till( "trig_dc_pamws_enemies" );
    wait 2;
    mdl_clip = getent( "dc_stair_2_monster_clip", "targetname" );
    mdl_clip connectpaths();
    mdl_clip delete();
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0x23be5b5a, Offset: 0x7d90
// Size: 0xba
function detention_center_pamws()
{
    trigger::wait_till( "trig_dc_pamws" );
    mdl_door_left = getent( "detention_security_door_01_L", "targetname" );
    mdl_door_right = getent( "detention_security_door_01_R", "targetname" );
    mdl_door_left moveto( mdl_door_left.origin + ( -100, 0, 0 ), 3 );
    mdl_door_right moveto( mdl_door_right.origin + ( 100, 0, 0 ), 3 );
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0xbfa94ff4, Offset: 0x7e58
// Size: 0x112
function detention_center_phalanx()
{
    trigger::wait_till( "trig_dc_phalanx" );
    v_start = struct::get( "dc_phalanx_wedge_start" ).origin;
    v_end = struct::get( "dc_phalanx_wedge_end" ).origin;
    n_phalanx = 3;
    
    if ( level.players.size > 2 )
    {
        n_phalanx = 5;
    }
    
    var_7947347f = getent( "phalanx_spawner_01", "targetname", 0 );
    var_73fc544 = getent( "phalanx_spawner_02", "targetname", 0 );
    phalanx_left = new robotphalanx();
    [[ phalanx_left ]]->initialize( "phanalx_wedge", v_start, v_end, 1, n_phalanx, var_7947347f, var_73fc544 );
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0x57e3f1e8, Offset: 0x7f78
// Size: 0xaa
function detention_center_control_panel_guy()
{
    self endon( #"death" );
    self.goalradius = 16;
    self waittill( #"goal" );
    wait 1;
    e_detention_center_robot_door = getent( "detention_security_door_01", "targetname" );
    e_detention_center_robot_door moveto( e_detention_center_robot_door getorigin() - ( 0, 0, 128 ), 1 );
    e_detention_center_robot_door connectpaths();
    spawn_manager::enable( "sm_detention_center_control_panel_cobra" );
}

// Namespace lotus_detention_center
// Params 4
// Checksum 0x7f31a515, Offset: 0x8030
// Size: 0x6a
function detention_center_done( str_objective, b_starting, b_direct, player )
{
    objectives::complete( "cp_level_lotus_go_to_taylor_holding_room" );
    level util::clientnotify( "riot_on" );
    level scene::init( "p7_fxanim_cp_lotus_interrogation_room_glass_bundle" );
}

// Namespace lotus_detention_center
// Params 0
// Checksum 0x3374b15f, Offset: 0x80a8
// Size: 0x32
function init()
{
    spawner::add_spawn_function_group( "auto_delete", "script_string", &auto_delete );
}

