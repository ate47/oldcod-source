#using scripts/codescripts/struct;
#using scripts/cp/_ammo_cache;
#using scripts/cp/_collectibles;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_mobile_armory;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_squad_control;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_biodomes_accolades;
#using scripts/cp/cp_mi_sing_biodomes_cloudmountain;
#using scripts/cp/cp_mi_sing_biodomes_fighttothedome;
#using scripts/cp/cp_mi_sing_biodomes_fx;
#using scripts/cp/cp_mi_sing_biodomes_init_spawn;
#using scripts/cp/cp_mi_sing_biodomes_markets;
#using scripts/cp/cp_mi_sing_biodomes_sound;
#using scripts/cp/cp_mi_sing_biodomes_util;
#using scripts/cp/cp_mi_sing_biodomes_warehouse;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai/archetype_warlord_interface;
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
#using scripts/shared/hud_message_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/teamgather_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace cp_mi_sing_biodomes;

// Namespace cp_mi_sing_biodomes
// Params 0
// Checksum 0xd1faa027, Offset: 0x1258
// Size: 0x32
function setup_rex_starts()
{
    util::add_gametype( "coop" );
    util::add_gametype( "cpzm" );
}

// Namespace cp_mi_sing_biodomes
// Params 0
// Checksum 0x66eb4467, Offset: 0x1298
// Size: 0x1a2
function main()
{
    if ( sessionmodeiscampaignzombiesgame() && 0 )
    {
        setclearanceceiling( 34 );
    }
    else
    {
        setclearanceceiling( 106 );
    }
    
    savegame::set_mission_name( "biodomes" );
    util::init_streamer_hints( 2 );
    biodomes_accolades::function_4d39a2af();
    precache();
    clientfields_init();
    flag_init();
    level_init();
    cp_mi_sing_biodomes_fx::main();
    cp_mi_sing_biodomes_sound::main();
    cp_mi_sing_biodomes_markets::main();
    cp_mi_sing_biodomes_cloudmountain::main();
    cp_mi_sing_biodomes_fighttothedome::main();
    setup_skiptos();
    callback::on_connect( &on_player_connect );
    callback::on_spawned( &on_player_spawned );
    spawner::add_global_spawn_function( "axis", &on_actor_spawned );
    load::main();
    skipto::set_skip_safehouse();
}

// Namespace cp_mi_sing_biodomes
// Params 0
// Checksum 0x63b60011, Offset: 0x1448
// Size: 0x2e2
function setup_skiptos()
{
    skipto::add( "objective_igc", &objective_igc, undefined, &objective_igc_done );
    skipto::function_d68e678e( "objective_markets_start", &cp_mi_sing_biodomes_markets::objective_markets_start_init, undefined, &cp_mi_sing_biodomes_markets::objective_markets_start_done );
    skipto::function_d68e678e( "objective_markets_rpg", &cp_mi_sing_biodomes_markets::objective_markets_rpg_init, undefined, &cp_mi_sing_biodomes_markets::objective_markets_rpg_done );
    skipto::function_d68e678e( "objective_markets2_start", &cp_mi_sing_biodomes_markets::objective_markets2_start_init, undefined, &cp_mi_sing_biodomes_markets::objective_markets2_start_done );
    skipto::function_d68e678e( "objective_warehouse", &cp_mi_sing_biodomes_warehouse::objective_warehouse_init, undefined, &cp_mi_sing_biodomes_warehouse::objective_warehouse_done );
    skipto::function_d68e678e( "objective_cloudmountain", &cp_mi_sing_biodomes_cloudmountain::objective_cloudmountain_init, undefined, &cp_mi_sing_biodomes_cloudmountain::objective_cloudmountain_done );
    skipto::function_d68e678e( "objective_cloudmountain_level_2", &cp_mi_sing_biodomes_cloudmountain::function_8ce887a2, undefined, &cp_mi_sing_biodomes_cloudmountain::objective_cloudmountain_level_2_done );
    skipto::function_d68e678e( "objective_turret_hallway", &cp_mi_sing_biodomes_cloudmountain::objective_turret_hallway_init, undefined, &cp_mi_sing_biodomes_cloudmountain::objective_turret_hallway_done );
    skipto::function_d68e678e( "objective_xiulan_vignette", &cp_mi_sing_biodomes_cloudmountain::objective_xiulan_vignette_init, undefined, &cp_mi_sing_biodomes_cloudmountain::objective_xiulan_vignette_done );
    skipto::add( "objective_server_room_defend", &cp_mi_sing_biodomes_cloudmountain::objective_server_room_defend_init, undefined, &cp_mi_sing_biodomes_cloudmountain::objective_server_room_defend_done );
    skipto::function_d68e678e( "objective_fighttothedome", &cp_mi_sing_biodomes_fighttothedome::objective_fighttothedome_init, undefined, &cp_mi_sing_biodomes_fighttothedome::objective_fighttothedome_done );
    
    /#
        skipto::add_dev( "<dev string:x28>", &dev_bullet_scene_init );
        skipto::add_dev( "<dev string:x39>", &cp_mi_sing_biodomes_warehouse::dev_warehouse_door_init );
        skipto::add_dev( "<dev string:x4c>", &cp_mi_sing_biodomes_warehouse::dev_warehouse_door_without_robots_init );
    #/
}

// Namespace cp_mi_sing_biodomes
// Params 0
// Checksum 0x2a65aa07, Offset: 0x1738
// Size: 0x33
function precache()
{
    level._effect[ "ceiling_collapse" ] = "destruct/fx_dest_ceiling_collapse_biodomes";
    level._effect[ "smoke_grenade" ] = "explosions/fx_exp_grenade_smoke";
}

// Namespace cp_mi_sing_biodomes
// Params 0
// Checksum 0xc22135fd, Offset: 0x1778
// Size: 0x282
function clientfields_init()
{
    clientfield::register( "toplayer", "player_dust_fx", 1, 1, "int" );
    clientfield::register( "toplayer", "player_waterfall_pstfx", 1, 1, "int" );
    clientfield::register( "toplayer", "bullet_disconnect_pstfx", 1, 1, "int" );
    clientfield::register( "toplayer", "zipline_speed_blur", 1, 1, "int" );
    clientfield::register( "scriptmover", "waiter_blood_shader", 1, 1, "int" );
    clientfield::register( "world", "set_exposure_bank", 1, 1, "int" );
    clientfield::register( "world", "party_house_shutter", 1, 1, "int" );
    clientfield::register( "world", "party_house_destruction", 1, 1, "int" );
    clientfield::register( "world", "dome_glass_break", 1, 1, "int" );
    clientfield::register( "world", "warehouse_window_break", 1, 1, "int" );
    clientfield::register( "world", "control_room_window_break", 1, 1, "int" );
    clientfield::register( "toplayer", "server_extra_cam", 1, 5, "int" );
    clientfield::register( "toplayer", "server_interact_cam", 1, 3, "int" );
    clientfield::register( "world", "cloud_mountain_crows", 1, 2, "int" );
    clientfield::register( "world", "fighttothedome_exfil_rope", 1, 2, "int" );
    clientfield::register( "world", "fighttothedome_exfil_rope_sim_player", 1, 1, "int" );
}

// Namespace cp_mi_sing_biodomes
// Params 0
// Checksum 0xc24b203d, Offset: 0x1a08
// Size: 0x49a
function flag_init()
{
    level flag::init( "partyroom_igc_started" );
    level flag::init( "plan_b" );
    level flag::init( "dannyli_dead" );
    level flag::init( "gohbro_dead" );
    level flag::init( "bullet_start" );
    level flag::init( "bullet_over" );
    level flag::init( "party_scene_skipped" );
    level flag::init( "markets1_enemies_alert" );
    level flag::init( "hendricks_markets2_wallrun" );
    level flag::init( "hendricks_markets2_arch_throw" );
    level flag::init( "markets1_intro_dialogue_done" );
    level flag::init( "turret1" );
    level flag::init( "turret2" );
    level flag::init( "turret1_dead" );
    level flag::init( "turret2_dead" );
    level flag::init( "markets2_tower_destroyed" );
    level flag::init( "container_done" );
    level flag::init( "warehouse_intro_vo_started" );
    level flag::init( "warehouse_intro_vo_done" );
    level flag::init( "warehouse_warlord_friendly_goal" );
    level flag::init( "back_door_closed" );
    level flag::init( "warehouse_warlord" );
    level flag::init( "warehouse_warlord_dead" );
    level flag::init( "warehouse_warlord_retreated" );
    level flag::init( "back_door_opened" );
    level flag::init( "siegebot_damage_enabled" );
    level flag::init( "siegebot_alerted" );
    level flag::init( "warehouse_wasps" );
    level flag::init( "turret_hall_clear" );
    level flag::init( "hand_cut" );
    level flag::init( "elevator_light_on_server_room" );
    level flag::init( "elevator_light_on_cloudmountain" );
    level flag::init( "cloudmountain_flanker_disable" );
    level flag::init( "cloudmountain_left_cleared" );
    level flag::init( "cloudmountain_right_cleared" );
    level flag::init( "cloudmountain_siegebots_dead" );
    level flag::init( "cloudmountain_siegebots_skipped" );
    level flag::init( "cloudmountain_second_floor_vo" );
    level flag::init( "level_2_enemy_catwalk_spawned" );
    level flag::init( "cloudmountain_hunter_spawned" );
    level flag::init( "end_level_2_sniper_vo" );
    level flag::init( "cloudmountain_level_3_catwalk_vo" );
    level flag::init( "end_level_3_sniper_vo" );
    level flag::init( "window_broken" );
    level flag::init( "window_hooks" );
    level flag::init( "window_gone" );
    level flag::init( "server_room_failing" );
    level flag::init( "top_floor_breached" );
    level flag::init( "hendricks_on_dome" );
}

// Namespace cp_mi_sing_biodomes
// Params 0
// Checksum 0xaa1a3711, Offset: 0x1eb0
// Size: 0x1ea
function level_init()
{
    createthreatbiasgroup( "warlords" );
    createthreatbiasgroup( "heroes" );
    level.override_robot_damage = 1;
    getent( "back_door_look_trigger", "script_noteworthy" ) triggerenable( 0 );
    a_hide_ents = getentarray( "start_hidden", "script_noteworthy" );
    
    foreach ( ent in a_hide_ents )
    {
        ent hide();
    }
    
    a_destroyed_props = getentarray( "partyroom_destroyed", "targetname" );
    
    foreach ( prop in a_destroyed_props )
    {
        prop hide();
    }
    
    hidemiscmodels( "partyroom_destroyed" );
    a_trig_waterfalls = getentarray( "waterfall_triggers", "script_noteworthy" );
    array::thread_all( a_trig_waterfalls, &trig_waterfall_func );
    level thread add_turret1_action();
}

// Namespace cp_mi_sing_biodomes
// Params 0
// Checksum 0x16510ed1, Offset: 0x20a8
// Size: 0x12
function on_actor_spawned()
{
    self.b_keylined = 0;
    self.b_targeted = 0;
}

// Namespace cp_mi_sing_biodomes
// Params 0
// Checksum 0x3332b0b8, Offset: 0x20c8
// Size: 0x32
function on_player_connect()
{
    self.b_bled_out = 0;
    self thread monitor_player_bleed_out();
    self flag::init( "player_bullet_over" );
}

// Namespace cp_mi_sing_biodomes
// Params 0
// Checksum 0x40c2ef48, Offset: 0x2108
// Size: 0x10a
function on_player_spawned()
{
    if ( !getdvarint( "art_review", 0 ) )
    {
        if ( level.skipto_point == "objective_igc" || level.skipto_point == "dev_bullet_scene" )
        {
            if ( level flag::get( "bullet_start" ) )
            {
                self flag::set( "player_bullet_over" );
            }
        }
        else if ( level.skipto_point == "objective_markets2_start" )
        {
            level flag::set( "turret1_dead" );
        }
        else if ( level.skipto_point == "objective_warehouse" || level.skipto_point == "objective_cloudmountain" )
        {
            level flag::set( "turret1_dead" );
            level flag::set( "turret2_dead" );
        }
    }
    
    cp_mi_sing_biodomes_util::function_d28654c9();
}

// Namespace cp_mi_sing_biodomes
// Params 0
// Checksum 0xb21a07ba, Offset: 0x2220
// Size: 0x1e
function monitor_player_bleed_out()
{
    self endon( #"disconnect" );
    self waittill( #"bled_out" );
    self.b_bled_out = 1;
}

// Namespace cp_mi_sing_biodomes
// Params 2
// Checksum 0xca37930d, Offset: 0x2248
// Size: 0xd2
function function_cef897cf( str_objective, n_squad )
{
    if ( !isdefined( n_squad ) )
    {
        n_squad = 4;
    }
    
    var_85556b78 = [];
    
    for ( i = 0; i < n_squad ; i++ )
    {
        var_85556b78[ i ] = spawner::simple_spawn_single( "friendly_robot_control", undefined, undefined, undefined, undefined, undefined, undefined, 1 );
        var_85556b78[ i ].health = int( var_85556b78[ i ].health * 0.75 );
        var_85556b78[ i ].start_health = var_85556b78[ i ].health;
    }
    
    skipto::teleport_ai( str_objective, var_85556b78 );
    level thread squad_control::function_e56e9d7d( var_85556b78 );
}

// Namespace cp_mi_sing_biodomes
// Params 0
// Checksum 0x192fdba5, Offset: 0x2328
// Size: 0x3d
function trig_waterfall_func()
{
    self endon( #"death" );
    
    while ( true )
    {
        self trigger::wait_till();
        self.who thread play_waterfall( self );
    }
}

// Namespace cp_mi_sing_biodomes
// Params 1
// Checksum 0x94ebda48, Offset: 0x2370
// Size: 0x9a
function play_waterfall( t_waterfall )
{
    self endon( #"death" );
    t_waterfall setinvisibletoplayer( self );
    self clientfield::set_to_player( "player_waterfall_pstfx", 1 );
    
    while ( self istouching( t_waterfall ) )
    {
        n_delay = randomfloatrange( 0, 1 );
        wait n_delay;
    }
    
    t_waterfall setvisibletoplayer( self );
    self clientfield::set_to_player( "player_waterfall_pstfx", 0 );
}

// Namespace cp_mi_sing_biodomes
// Params 1
// Checksum 0x450db3a5, Offset: 0x2418
// Size: 0x53a
function igc_party( var_f45807af )
{
    if ( !isdefined( var_f45807af ) )
    {
        var_f45807af = 0;
    }
    
    load::function_73adcefc();
    level thread scene::add_scene_func( "cin_bio_02_04_gunplay_vign_stab_both", &party_over, "done" );
    level thread scene::add_scene_func( "cin_bio_01_01_party_1st_drinks", &function_df65aec6, "play" );
    level thread scene::add_scene_func( "cin_bio_01_01_party_1st_drinks", &function_b361ad8b, "skip_started" );
    level thread scene::init( "cin_bio_03_01_market_vign_engage" );
    level thread scene::init( "cin_bio_03_01_market_aie_weapons" );
    level thread scene::init( "cin_gen_aie_table_react" );
    
    if ( var_f45807af )
    {
        level scene::init( "cin_bio_02_04_gunplay_vign_stab_both" );
        s_table = struct::get( "skipto_intro_igc_table" );
        util::spawn_model( s_table.model, s_table.origin, s_table.angles );
        load::function_a2995f22();
    }
    else
    {
        level scene::init( "cin_bio_01_01_party_1st_drinks" );
        level scene::init( "cin_bio_01_01_party_1st_drinks_part2" );
        util::set_lighting_state( 1 );
        load::function_a2995f22();
        util::do_chyron_text( &"CP_MI_SING_BIODOMES_INTRO_LINE_1_FULL", &"CP_MI_SING_BIODOMES_INTRO_LINE_1_SHORT", &"CP_MI_SING_BIODOMES_INTRO_LINE_2_FULL", &"CP_MI_SING_BIODOMES_INTRO_LINE_2_SHORT", &"CP_MI_SING_BIODOMES_INTRO_LINE_3_FULL", &"CP_MI_SING_BIODOMES_INTRO_LINE_3_SHORT", &"CP_MI_SING_BIODOMES_INTRO_LINE_4_FULL", &"CP_MI_SING_BIODOMES_INTRO_LINE_4_SHORT", "", "", 9 );
    }
    
    level thread namespace_f1b4cbbc::function_f936f64e();
    function_484bc3aa( 1 );
    
    if ( var_f45807af )
    {
        level thread scene::skipto_end( "cin_bio_02_04_gunplay_vign_stab_both", undefined, undefined, 0.59, 1 );
    }
    else
    {
        if ( isdefined( level.bzm_biodialogue1callback ) )
        {
            level thread [[ level.bzm_biodialogue1callback ]]();
        }
        
        level thread function_8013ff12();
        level thread function_9cebd80e();
        level scene::play( "cin_bio_01_01_party_1st_drinks" );
    }
    
    foreach ( player in level.players )
    {
        player.ignoreme = 1;
    }
    
    if ( isdefined( level.bzm_biodialogue2callback ) )
    {
        level thread [[ level.bzm_biodialogue2callback ]]();
    }
    
    level flag::set( "bullet_start" );
    level flag::set( "bullet_over" );
    a_destroyed_props = getentarray( "partyroom_destroyed", "targetname" );
    
    foreach ( prop in a_destroyed_props )
    {
        prop show();
    }
    
    level clientfield::set( "party_house_destruction", 1 );
    showmiscmodels( "partyroom_destroyed" );
    
    if ( !var_f45807af )
    {
        level thread shoot_igc_guards();
    }
    
    exploder::exploder( "party_igc_bullets" );
    level thread function_e4f0cf99();
    level clientfield::set( "sndIGCsnapshot", 3 );
    level util::clientnotify( "no_party" );
    
    foreach ( player in level.players )
    {
        player allowcrouch( 1 );
        player allowprone( 1 );
    }
    
    while ( !scene::is_active( "cin_bio_02_04_gunplay_vign_stab_both" ) )
    {
        wait 0.05;
    }
    
    level notify( #"player_regain_control" );
    
    if ( !scene::is_skipping_in_progress() )
    {
        cp_mi_sing_biodomes_markets::spawn_markets1_enemies();
    }
}

// Namespace cp_mi_sing_biodomes
// Params 0
// Checksum 0x593e722c, Offset: 0x2960
// Size: 0x32
function function_8013ff12()
{
    level waittill( #"hash_15b19b21" );
    
    if ( !scene::is_skipping_in_progress() )
    {
        level scene::init( "cin_bio_02_04_gunplay_vign_stab_both" );
    }
}

// Namespace cp_mi_sing_biodomes
// Params 1
// Checksum 0xe628c535, Offset: 0x29a0
// Size: 0x1b2
function function_b361ad8b( a_ents )
{
    level flag::set( "party_scene_skipped" );
    level thread scene::add_scene_func( "cin_gen_aie_table_react", &cp_mi_sing_biodomes_markets::function_c7cb9a93, "done" );
    level thread scene::play( "cin_gen_aie_table_react" );
    level thread scene::play( "cin_bio_03_01_market_vign_engage" );
    level thread scene::play( "cin_bio_03_01_market_aie_weapons" );
    level thread scene::stop( "p7_fxanim_cp_biodomes_party_house_drinks_bundle" );
    level thread scene::stop( "cin_bio_01_01_party_1st_drinks_part2" );
    spawner::simple_spawn( "sp_markets1_friendly_robot_start" );
    spawn_manager::enable( "sm_markets1_combat0" );
    spawn_manager::enable( "sm_markets1_combat1" );
    level.turret_markets1 = spawner::simple_spawn_single( "turret_markets1" );
    level.turret_markets1 thread cp_mi_sing_biodomes_markets::function_70da4f9b();
    level thread cp_mi_sing_biodomes_markets::vo_markets1();
    level thread cp_mi_sing_biodomes_markets::function_b1e84c2();
    trigger::use( "trig_markets1_combat1" );
    wait 2;
    level flag::set( "markets1_enemies_alert" );
    level clientfield::set( "sndIGCsnapshot", 0 );
}

// Namespace cp_mi_sing_biodomes
// Params 0
// Checksum 0xfda2a56d, Offset: 0x2b60
// Size: 0x5a
function function_9cebd80e()
{
    level waittill( #"robot_overhead_throw_enemy" );
    
    if ( !scene::is_skipping_in_progress() )
    {
        level thread function_5cb44f79( "robot_graphic_kill", "robot_intro_robot", "robot_intro_guy" );
        level thread function_5cb44f79( "robot_overhead_throw_enemy" );
    }
}

// Namespace cp_mi_sing_biodomes
// Params 3
// Checksum 0x1e9fd9c8, Offset: 0x2bc8
// Size: 0x15a
function function_5cb44f79( var_d83ebd04, var_42c1bd32, var_ae7d184a )
{
    var_56af50be = [];
    ai_robot = spawner::simple_spawn_single( "markets1_robot_vign" );
    ai_robot squad_control::function_eb13b9c0();
    
    if ( isdefined( var_42c1bd32 ) )
    {
        var_56af50be[ var_42c1bd32 ] = ai_robot;
    }
    else
    {
        if ( !isdefined( var_56af50be ) )
        {
            var_56af50be = [];
        }
        else if ( !isarray( var_56af50be ) )
        {
            var_56af50be = array( var_56af50be );
        }
        
        var_56af50be[ var_56af50be.size ] = ai_robot;
    }
    
    ai_enemy = spawner::simple_spawn_single( "markets1_enemy_vign" );
    
    if ( isdefined( var_ae7d184a ) )
    {
        var_56af50be[ var_ae7d184a ] = ai_enemy;
    }
    else
    {
        if ( !isdefined( var_56af50be ) )
        {
            var_56af50be = [];
        }
        else if ( !isarray( var_56af50be ) )
        {
            var_56af50be = array( var_56af50be );
        }
        
        var_56af50be[ var_56af50be.size ] = ai_enemy;
    }
    
    s_align = struct::get( var_d83ebd04 );
    s_align scene::play( s_align.scriptbundlename, var_56af50be );
}

// Namespace cp_mi_sing_biodomes
// Params 0
// Checksum 0x6182542, Offset: 0x2d30
// Size: 0x32
function function_e4f0cf99()
{
    level waittill( #"hash_480f0793" );
    level clientfield::set( "party_house_shutter", 1 );
    util::set_lighting_state( 0 );
}

// Namespace cp_mi_sing_biodomes
// Params 1
// Checksum 0x6347ff9f, Offset: 0x2d70
// Size: 0x73
function function_484bc3aa( b_enable )
{
    foreach ( player in level.players )
    {
        player clientfield::set_to_player( "player_dust_fx", b_enable );
    }
}

// Namespace cp_mi_sing_biodomes
// Params 1
// Checksum 0xae10bfc5, Offset: 0x2df0
// Size: 0x72
function function_df65aec6( a_ents )
{
    level thread scene::play( "p7_fxanim_cp_biodomes_party_house_drinks_bundle" );
    level thread scene::play( "cin_bio_01_01_party_1st_drinks_part2" );
    var_ecc203c7 = a_ents[ "server" ];
    var_ecc203c7 waittill( #"stab" );
    var_ecc203c7 clientfield::set( "waiter_blood_shader", 1 );
}

// Namespace cp_mi_sing_biodomes
// Params 1
// Checksum 0xdac9715a, Offset: 0x2e70
// Size: 0xba
function party_over( scene )
{
    exploder::kill_exploder( "party_igc_bullets" );
    function_484bc3aa( 0 );
    
    foreach ( player in level.players )
    {
        player.ignoreme = 0;
    }
    
    level util::teleport_players_igc( "objective_markets_start" );
    function_c506a743( "objective_igc" );
}

// Namespace cp_mi_sing_biodomes
// Params 2
// Checksum 0xc3ba7dd7, Offset: 0x2f38
// Size: 0x18a
function function_c506a743( str_objective, n_squad )
{
    if ( !isdefined( n_squad ) )
    {
        n_squad = 4;
    }
    
    a_robot_spots = struct::get_array( "markets_combat_robot_squad_spawn" );
    a_ai_party_robots = [];
    a_ai_robots = [];
    
    for ( i = 0; i < 4 ; i++ )
    {
        a_ai_party_robots[ i ] = getent( "robot0" + i + 1, "animname" );
    }
    
    if ( n_squad > 4 )
    {
        for ( i = 0; i < n_squad ; i++ )
        {
            a_ai_robots[ i ] = spawner::simple_spawn_single( "friendly_robot_control" );
        }
    }
    
    a_squad = arraycombine( a_ai_party_robots, a_ai_robots, 0, 1 );
    
    foreach ( robot in a_squad )
    {
        robot.health = int( robot.health * 0.75 );
        robot.start_health = robot.health;
    }
    
    level squad_control::function_e56e9d7d( a_squad );
}

// Namespace cp_mi_sing_biodomes
// Params 0
// Checksum 0x7ee1fcbd, Offset: 0x30d0
// Size: 0x62
function add_turret1_action()
{
    level flag::wait_till( "turret1" );
    
    if ( isalive( level.turret_markets1 ) )
    {
        level thread squad_control::squad_control_task( level.turret_markets1 );
        level.turret_markets1 thread remove_turret_task_ondeath();
    }
}

// Namespace cp_mi_sing_biodomes
// Params 0
// Checksum 0x946b3bc3, Offset: 0x3140
// Size: 0x42
function remove_turret_task_ondeath()
{
    self waittill( #"death" );
    
    if ( isdefined( self ) )
    {
        if ( isinarray( level.a_robot_tasks, self ) )
        {
            arrayremovevalue( level.a_robot_tasks, self );
        }
    }
}

// Namespace cp_mi_sing_biodomes
// Params 2
// Checksum 0xe8cb4946, Offset: 0x3190
// Size: 0x7a
function objective_igc( str_objective, b_starting )
{
    cp_mi_sing_biodomes_util::objective_message( "objective_igc" );
    cp_mi_sing_biodomes_util::init_hendricks( str_objective );
    level thread cp_mi_sing_biodomes_util::function_753a859( str_objective );
    level thread igc_party();
    level waittill( #"end_igc" );
    level skipto::objective_completed( "objective_igc" );
}

// Namespace cp_mi_sing_biodomes
// Params 4
// Checksum 0xc3d349a7, Offset: 0x3218
// Size: 0x3f
function objective_igc_done( str_objective, b_starting, b_direct, player )
{
    cp_mi_sing_biodomes_util::objective_message( "objective_igc_done" );
    
    if ( b_starting )
    {
    }
}

// Namespace cp_mi_sing_biodomes
// Params 0
// Checksum 0xfba046bf, Offset: 0x3260
// Size: 0xc1
function shoot_igc_guards()
{
    a_source_spots = struct::get_array( "igc_extra_bullets" );
    
    for ( i = 1; i <= 5 ; i++ )
    {
        e_guard = getent( "guard0" + i, "animname", 1 );
        
        if ( isalive( e_guard ) )
        {
            v_source = array::random( a_source_spots ).origin;
            level thread kill_igc_guards( e_guard, v_source );
        }
    }
}

// Namespace cp_mi_sing_biodomes
// Params 2
// Checksum 0x35e8339a, Offset: 0x3330
// Size: 0x119
function kill_igc_guards( e_guard, v_source )
{
    var_f78ad07e = getweapon( "lmg_cqb" );
    v_dest = e_guard.origin + ( 0, 0, 48 );
    i = 0;
    
    while ( i <= 3.5 )
    {
        var_de810370 = randomintrange( -2, 2 );
        var_4837dd9 = randomintrange( -2, 2 );
        var_2a85f842 = randomintrange( -20, 20 );
        magicbullet( var_f78ad07e, v_source, v_dest + ( var_de810370, var_4837dd9, var_2a85f842 ) );
        wait 0.15;
        i += 0.15;
    }
}

// Namespace cp_mi_sing_biodomes
// Params 2
// Checksum 0xfa9e8342, Offset: 0x3458
// Size: 0x6a
function dev_bullet_scene_init( str_objective, b_starting )
{
    level thread igc_party( 1 );
    objectives::set( "cp_waypoint_breadcrumb", struct::get( "breadcrumb_markets1" ) );
    objectives::hide( "cp_waypoint_breadcrumb" );
}

