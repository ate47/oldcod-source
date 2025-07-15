#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_vengeance_accolades;
#using scripts/cp/cp_mi_sing_vengeance_dogleg_1;
#using scripts/cp/cp_mi_sing_vengeance_sound;
#using scripts/cp/cp_mi_sing_vengeance_util;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_dev;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/stealth;
#using scripts/shared/stealth_aware;
#using scripts/shared/stealth_status;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;

#namespace vengeance_killing_streets;

// Namespace vengeance_killing_streets
// Params 2
// Checksum 0xd7a4db69, Offset: 0x17e8
// Size: 0x162
function skipto_killing_streets_init( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        vengeance_util::skipto_baseline( str_objective, b_starting );
        vengeance_util::init_hero( "hendricks", str_objective );
        level thread vengeance_util::function_e3420328( "killing_streets_ambient_anims", "dogleg_1_begin" );
        objectives::set( "cp_level_vengeance_rescue_kane" );
        objectives::set( "cp_level_vengeance_go_to_safehouse" );
        level thread function_9736d8c9();
        level thread setup_killing_streets_intro_patroller_spawners();
        load::function_a2995f22();
        videostop( "cp_vengeance_env_sign_dancer01" );
        wait 0.05;
        level thread vengeance_util::function_ab876b5a( "cp_vengeance_env_sign_dancer01", "strip_video_start", "strip_video_end" );
        wait 0.05;
        level notify( #"strip_video_start" );
    }
    
    vengeance_util::function_4e8207e9( "killing_streets" );
    thread cp_mi_sing_vengeance_sound::function_749aad88();
    killing_streets_main( str_objective );
}

// Namespace vengeance_killing_streets
// Params 1
// Checksum 0x8d56deb8, Offset: 0x1958
// Size: 0x1ca
function killing_streets_main( str_objective )
{
    level flag::set( "killing_streets_begin" );
    exploder::exploder( "killing_streets_butcher_fx" );
    spawner::add_spawn_function_group( "killing_streets_civilian_spawners", "script_noteworthy", &setup_killing_streets_civilian );
    level.ai_hendricks thread setup_killing_streets_alley_hendricks();
    level.ai_hendricks thread setup_killing_streets_alley_hendricks_stealth_broken();
    level thread function_4b7aea65();
    level thread function_ef12791();
    level.lineup_kill_doors_scripted_node = struct::get( "lineup_kill_doors_scripted_node", "targetname" );
    level.lineup_kill_scripted_node = struct::get( "lineup_kill_scripted_node", "targetname" );
    level.lineup_kill_doors_scripted_node thread scene::init( "cin_ven_03_20_storelineup_vign_start_doors_only" );
    level.lineup_kill_doors_scripted_node thread scene::init( "cin_ven_03_20_storelineup_vign_exit" );
    level.dogleg_1_intro_org = struct::get( "dogleg_1_intro_org" );
    level.dogleg_1_intro_org scene::init( "cin_ven_04_10_cafedoor_1st_sh010" );
    level thread function_71a7056();
    level thread function_999f0273();
    level thread function_9f0122b9();
    level thread function_28fa297f();
}

// Namespace vengeance_killing_streets
// Params 0
// Checksum 0x8a87f7c9, Offset: 0x1b30
// Size: 0x1e2
function setup_killing_streets_alley_hendricks()
{
    level endon( #"stealth_combat" );
    level endon( #"stealth_alert" );
    level endon( #"killing_streets_intro_patroller_spawners_cleared" );
    self endon( #"death" );
    self.holdfire = 1;
    self.ignoreall = 0;
    self.ignoreme = 1;
    self colors::disable();
    self ai::set_behavior_attribute( "cqb", 1 );
    self.goalradius = 32;
    self battlechatter::function_d9f49fba( 0 );
    node = getnode( "killing_streets_hendricks_node_03", "targetname" );
    self setgoal( node, 1, 16 );
    
    if ( !level flag::get( "move_killing_streets_hendricks_node_05" ) )
    {
        level flag::wait_till( "move_killing_streets_hendricks_node_05" );
    }
    
    node = getnode( "killing_streets_hendricks_node_05", "targetname" );
    self setgoal( node, 1, 16 );
    
    if ( !level flag::get( "move_killing_streets_hendricks_node_10" ) || !level flag::get( "killing_streets_civilian_sniped" ) )
    {
        level flag::wait_till_all( array( "move_killing_streets_hendricks_node_10", "killing_streets_civilian_sniped" ) );
    }
    
    node = getnode( "killing_streets_hendricks_node_10", "targetname" );
    self setgoal( node, 1, 16 );
    self waittill( #"goal" );
    wait 7;
    level flag::set( "hendricks_break_ally_stealth" );
}

// Namespace vengeance_killing_streets
// Params 0
// Checksum 0x837b955f, Offset: 0x1d20
// Size: 0x172
function setup_killing_streets_alley_hendricks_stealth_broken()
{
    level flag::wait_till_any( array( "stealth_alert", "stealth_combat", "killing_streets_intro_patroller_spawners_cleared", "cin_ven_03_15_killingstreets_vign_done", "hendricks_break_ally_stealth" ) );
    self.var_df53bc6 = self.script_accuracy;
    self.script_accuracy = 0.1;
    self.ignoreme = 0;
    self.holdfire = 0;
    self ai::set_behavior_attribute( "cqb", 0 );
    self colors::enable();
    level flag::wait_till( "killing_streets_intro_patroller_spawners_cleared" );
    level flag::clear( "stealth_discovered" );
    self colors::disable();
    self.ignoreme = 1;
    self.ignoreall = 1;
    self.holdfire = 1;
    self battlechatter::function_d9f49fba( 0 );
    self.script_accuracy = self.var_df53bc6;
    self ai::set_behavior_attribute( "cqb", 1 );
    self ai::set_behavior_attribute( "sprint", 0 );
    stealth::reset();
    wait 0.05;
    self thread setup_killing_streets_lineup_hendricks();
}

// Namespace vengeance_killing_streets
// Params 0
// Checksum 0x9a5ceb84, Offset: 0x1ea0
// Size: 0x1da
function function_9736d8c9()
{
    killing_streets_intro_patroller_spawners = spawner::simple_spawn( "killing_streets_intro_sniper_spawner", &vengeance_util::setup_patroller );
    level.var_abd93cb3 = killing_streets_intro_patroller_spawners[ 0 ];
    level.var_abd93cb3 thread function_68661375();
    vengeance_accolades::function_9bba5da();
    scene::add_scene_func( "cin_ven_03_15_killingstreets_vign_snipershot", &killing_streets_civilian_sniped, "done" );
    var_bba8f947 = struct::get( "lineup_kill_doors_scripted_node" );
    var_bba8f947 thread scene::init( "cin_ven_03_15_killingstreets_vign_snipershot" );
    level flag::wait_till( "start_killing_streets_sniper_shoots_civilian" );
    playsoundatposition( "mus_alley_stinger", ( 0, 0, 0 ) );
    util::clientnotify( "sndLRstart" );
    var_bba8f947 thread scene::play( "cin_ven_03_15_killingstreets_vign_snipershot" );
    thread cp_mi_sing_vengeance_sound::function_68da61d9();
    wait 0.1;
    
    while ( true )
    {
        guy = getent( "killing_streets_alley_civ_a_ai", "targetname" );
        
        if ( isdefined( guy ) )
        {
            break;
        }
        
        wait 0.05;
    }
    
    guy.perfectaim = 1;
    guy laseron();
    guy endon( #"death" );
    guy waittill( #"sniper_fire" );
    level.var_abd93cb3 notify( #"hash_55f87e20" );
    guy animation::fire_weapon();
}

// Namespace vengeance_killing_streets
// Params 1
// Checksum 0x501668b9, Offset: 0x2088
// Size: 0x22
function killing_streets_civilian_sniped( a_ents )
{
    level flag::set( "killing_streets_civilian_sniped" );
}

// Namespace vengeance_killing_streets
// Params 0
// Checksum 0x8ce74b22, Offset: 0x20b8
// Size: 0x60a
function setup_killing_streets_lineup_hendricks()
{
    level endon( #"killing_streets_lineup_patrollers_alerted" );
    self endon( #"death" );
    self thread setup_killing_streets_lineup_hendricks_stealth_broken();
    level flag::set( "move_hendricks_to_meat_market" );
    hendricks_open_alley_door_01_gather_org = struct::get( "hendricks_open_alley_door_01_gather_org" );
    objectives::set( "cp_waypoint_breadcrumb", hendricks_open_alley_door_01_gather_org );
    e_node = getnode( "hendricks_pre_butcher_node", "targetname" );
    self setgoal( e_node, 1 );
    self waittill( #"goal" );
    self ai::set_behavior_attribute( "cqb", 0 );
    self ai::set_behavior_attribute( "forceTacticalWalk", 1 );
    e_node = getnode( "hendricks_pre_butcher_node_2", "targetname" );
    self setgoal( e_node, 1 );
    self waittill( #"goal" );
    level.lineup_kill_scripted_node scene::init( "cin_ven_03_20_storelineup_vign_start_hendricks_only" );
    level flag::set( "enable_hendricks_open_alley_door_01" );
    self waittill( #"reach_done" );
    level thread function_96d0d9ff();
    level flag::wait_till( "start_hendricks_open_alley_door_01" );
    
    if ( isdefined( level.bzm_vengeancedialogue3_1callback ) )
    {
        level thread [[ level.bzm_vengeancedialogue3_1callback ]]();
    }
    
    savegame::checkpoint_save();
    objectives::complete( "cp_waypoint_breadcrumb", hendricks_open_alley_door_01_gather_org );
    objectives::hide( "cp_level_vengeance_go_to_safehouse" );
    self ai::set_behavior_attribute( "forceTacticalWalk", 0 );
    self ai::set_behavior_attribute( "cqb", 1 );
    level thread killing_streets_robots();
    spawner::add_spawn_function_group( "killing_streets_lineup_patroller_spawners", "script_noteworthy", &setup_killing_streets_lineup_patroller_spawners );
    spawner::add_spawn_function_group( "killing_streets_lineup_civilian_spawners", "script_noteworthy", &setup_killing_streets_civilian_lineup );
    storelineup_door1_clip = getent( "storelineup_door1_clip", "targetname" );
    storelineup_door1_clip thread storelineup_door1_clip();
    level thread lineup_kill_scene_manager();
    level thread lineup_kill_scene_stopper();
    level waittill( #"cin_ven_03_20_storelineup_vign_start_done" );
    
    if ( !level flag::get( "move_killing_streets_hendricks_node_30" ) )
    {
        level flag::wait_till( "move_killing_streets_hendricks_node_30" );
    }
    
    level flag::set( "hendricks_says_stay_down" );
    level.lineup_kill_scripted_node scene::play( "cin_ven_03_20_storelineup_vign_move1" );
    
    if ( !level flag::get( "move_killing_streets_hendricks_node_35" ) )
    {
        level flag::wait_till( "move_killing_streets_hendricks_node_35" );
    }
    
    level.lineup_kill_scripted_node scene::play( "cin_ven_03_20_storelineup_vign_move2" );
    
    if ( !level flag::get( "move_killing_streets_hendricks_node_40" ) && !level flag::get( "cin_ven_03_20_storelineup_vign_fire_done" ) )
    {
        level flag::wait_till_all( array( "move_killing_streets_hendricks_node_40", "cin_ven_03_20_storelineup_vign_fire_done" ) );
    }
    
    level.lineup_kill_scripted_node scene::play( "cin_ven_03_20_storelineup_vign_move3" );
    level flag::set( "enable_hendricks_open_alley_door_02" );
    
    if ( !level flag::get( "start_hendricks_open_alley_door_02" ) )
    {
        level flag::wait_till( "start_hendricks_open_alley_door_02" );
    }
    
    savegame::checkpoint_save();
    storelineup_door3_clip = getent( "storelineup_door3_clip", "targetname" );
    
    if ( isdefined( storelineup_door3_clip ) )
    {
        storelineup_door3_clip thread storelineup_door3_clip();
    }
    
    level.lineup_kill_doors_scripted_node thread scene::play( "cin_ven_03_20_storelineup_vign_exit" );
    wait 0.5;
    self clearforcedgoal();
    node = getnode( "killing_streets_hendricks_node_55", "targetname" );
    self setgoal( node, 1, 16 );
    level waittill( #"hash_2b5b2f5d" );
    level flag::set( "hendricks_cleared_meat_market_door" );
    level flag::wait_till( "move_killing_streets_hendricks_node_57" );
    node = getnode( "killing_streets_hendricks_node_57", "targetname" );
    self setgoal( node, 1, 16 );
    level flag::wait_till( "clear_killing_streets_breadcrumb_07" );
    level.ai_hendricks thread function_2adde689();
    node = getnode( "killing_streets_hendricks_node_60", "targetname" );
    self setgoal( node, 1, 16 );
}

// Namespace vengeance_killing_streets
// Params 0
// Checksum 0xf3b19049, Offset: 0x26d0
// Size: 0x2ca
function setup_killing_streets_lineup_hendricks_stealth_broken()
{
    level flag::wait_till( "killing_streets_lineup_patrollers_alerted" );
    wait 0.05;
    self stopanimscripted();
    self.ignoreme = 0;
    self.ignoreall = 0;
    self.holdfire = 0;
    self battlechatter::function_d9f49fba( 1 );
    self ai::set_behavior_attribute( "forceTacticalWalk", 0 );
    self colors::enable();
    level flag::wait_till_all( array( "killing_streets_lineup_patroller_spawners_cleared", "killing_streets_robots_cleared" ) );
    level flag::clear( "stealth_discovered" );
    self.ignoreme = 1;
    self.holdfire = 1;
    self battlechatter::function_d9f49fba( 0 );
    self ai::set_behavior_attribute( "cqb", 1 );
    self colors::disable();
    storelineup_door3_clip = getent( "storelineup_door3_clip", "targetname" );
    
    if ( isdefined( storelineup_door3_clip ) )
    {
        storelineup_door3_clip thread storelineup_door3_clip();
    }
    
    if ( !level flag::get( "hendricks_cleared_meat_market_door" ) )
    {
        level.lineup_kill_doors_scripted_node thread scene::play( "cin_ven_03_20_storelineup_vign_exit_reach" );
        self waittill( #"reach_done" );
        wait 0.5;
    }
    
    self clearforcedgoal();
    node = getnode( "killing_streets_hendricks_node_55", "targetname" );
    self setgoal( node, 1, 16 );
    
    if ( !level flag::get( "hendricks_cleared_meat_market_door" ) )
    {
        level waittill( #"hash_2b5b2f5d" );
    }
    
    level flag::wait_till( "move_killing_streets_hendricks_node_57" );
    node = getnode( "killing_streets_hendricks_node_57", "targetname" );
    self setgoal( node, 1, 16 );
    level flag::wait_till( "clear_killing_streets_breadcrumb_07" );
    level.ai_hendricks thread function_2adde689();
    node = getnode( "killing_streets_hendricks_node_60", "targetname" );
    self setgoal( node, 1, 16 );
}

// Namespace vengeance_killing_streets
// Params 0
// Checksum 0x49d460f5, Offset: 0x29a8
// Size: 0x82
function function_2adde689()
{
    self endon( #"death" );
    self ai::set_behavior_attribute( "vignette_mode", "fast" );
    self ai::set_behavior_attribute( "coverIdleOnly", 1 );
    level waittill( #"hash_f1a04aa0" );
    self ai::set_behavior_attribute( "vignette_mode", "off" );
    self ai::set_behavior_attribute( "coverIdleOnly", 0 );
}

// Namespace vengeance_killing_streets
// Params 0
// Checksum 0xf3a1958a, Offset: 0x2a38
// Size: 0x63
function function_96d0d9ff()
{
    foreach ( e_player in level.activeplayers )
    {
        e_player thread function_a39cd1bb();
    }
}

// Namespace vengeance_killing_streets
// Params 0
// Checksum 0xc7c47ec8, Offset: 0x2aa8
// Size: 0xc5
function function_a39cd1bb()
{
    level endon( #"killing_streets_lineup_patrollers_alerted" );
    level endon( #"hash_f1a04aa0" );
    self endon( #"disconnect" );
    a_vol = getentarray( "killing_streets_outside", "targetname" );
    
    while ( true )
    {
        foreach ( e_vol in a_vol )
        {
            if ( self istouching( e_vol ) )
            {
                self.ignoreme = 1;
                continue;
            }
            
            self.ignoreme = 0;
        }
        
        wait 0.05;
    }
}

// Namespace vengeance_killing_streets
// Params 0
// Checksum 0xdfa75be3, Offset: 0x2b78
// Size: 0x2d3
function lineup_kill_scene_manager()
{
    level endon( #"killing_streets_lineup_patrollers_alerted" );
    level thread function_fd81381e( "execution_blood_spray_lt", "lineup_civ_1_killed", "lineup_kill_decal_lt_window_broken" );
    level thread function_fd81381e( "execution_blood_spray_rt", "lineup_civ_2_killed", "lineup_kill_decal_rt_window_broken" );
    level thread function_d864c642();
    level.lineup_kill_scripted_node thread scene::init( "cin_ven_03_20_storelineup_vign_fire" );
    level.lineup_kill_doors_scripted_node thread scene::play( "cin_ven_03_20_storelineup_vign_start_doors_only" );
    level.lineup_kill_scripted_node scene::play( "cin_ven_03_20_storelineup_vign_start_hendricks_only" );
    level notify( #"cin_ven_03_20_storelineup_vign_start_done" );
    level flag::wait_till( "start_lineup_kill_execution" );
    level.lineup_kill_scripted_node scene::play( "cin_ven_03_20_storelineup_vign_fire" );
    level flag::set( "cin_ven_03_20_storelineup_vign_fire_done" );
    node = getnode( "killing_streets_lineup_patroller_spawners_exit_node", "targetname" );
    guys = getentarray( "killing_streets_robots", "script_noteworthy", 1 );
    
    foreach ( guy in guys )
    {
        if ( isdefined( guy ) && isalive( guy ) )
        {
            if ( isdefined( guy.script_delay ) )
            {
                guy thread util::_delay( guy.script_delay, undefined, &vengeance_util::delete_ai_at_path_end, node, undefined, 1, 1024 );
                continue;
            }
            
            guy thread vengeance_util::delete_ai_at_path_end( node, undefined, 1, 1024 );
        }
    }
    
    wait 15;
    guys = getentarray( "killing_streets_lineup_patroller_spawners", "script_noteworthy", 1 );
    
    foreach ( guy in guys )
    {
        if ( isdefined( guy ) && isalive( guy ) )
        {
            guy thread vengeance_util::delete_ai_at_path_end( node, undefined, 1, 1024 );
        }
    }
}

// Namespace vengeance_killing_streets
// Params 3
// Checksum 0x6f69f6d3, Offset: 0x2e58
// Size: 0xb2
function function_fd81381e( var_210e7715, var_a9d6b8b7, var_734ef62a )
{
    var_f644fb29 = getent( var_210e7715, "targetname" );
    var_f644fb29 clientfield::set( "normal_hide", 1 );
    var_f644fb29 notsolid();
    level waittill( var_a9d6b8b7 );
    
    if ( !level flag::get( var_734ef62a ) )
    {
        var_f644fb29 clientfield::set( "mature_hide", 1 );
    }
    
    level flag::wait_till( var_734ef62a );
    var_f644fb29 delete();
}

// Namespace vengeance_killing_streets
// Params 0
// Checksum 0xb1f12c6d, Offset: 0x2f18
// Size: 0x72
function function_d864c642()
{
    level flag::wait_till_any( array( "killing_streets_lineup_patrollers_alerted", "lineup_kill_window_broken" ) );
    storelineup_window_clip = getent( "storelineup_window_clip", "targetname" );
    
    if ( isdefined( storelineup_window_clip ) )
    {
        storelineup_window_clip delete();
    }
}

// Namespace vengeance_killing_streets
// Params 0
// Checksum 0x159f9c5c, Offset: 0x2f98
// Size: 0x32
function lineup_kill_scene_stopper()
{
    level flag::wait_till( "killing_streets_lineup_patrollers_alerted" );
    level.lineup_kill_scripted_node scene::stop();
}

// Namespace vengeance_killing_streets
// Params 0
// Checksum 0xb14e10ff, Offset: 0x2fd8
// Size: 0x42
function storelineup_door1_clip()
{
    wait 2;
    self notsolid();
    self connectpaths();
    wait 1;
    self delete();
}

// Namespace vengeance_killing_streets
// Params 0
// Checksum 0xc84632b1, Offset: 0x3028
// Size: 0x2a
function storelineup_door3_clip()
{
    wait 0.75;
    self notsolid();
    self connectpaths();
}

// Namespace vengeance_killing_streets
// Params 0
// Checksum 0x3e1a6220, Offset: 0x3060
// Size: 0x13a
function setup_killing_streets_intro_patroller_spawners()
{
    spawner::add_spawn_function_group( "killing_streets_intro_patroller_spawners", "script_noteworthy", &function_a45594e6 );
    var_6a07eb6c = [];
    var_6a07eb6c[ 0 ] = "killing_streets_alley_civ_b";
    var_6a07eb6c[ 1 ] = "killing_streets_alley_rope";
    scene::add_scene_func( "cin_ven_03_15_killingstreets_vign", &vengeance_util::function_65a61b78, "play", var_6a07eb6c );
    scene::add_scene_func( "cin_ven_03_15_killingstreets_vign_loop", &vengeance_util::function_65a61b78, "play", var_6a07eb6c );
    var_a9e0b15b = struct::get( "lineup_kill_doors_scripted_node" );
    var_a9e0b15b scene::init( "cin_ven_03_15_killingstreets_vign" );
    
    if ( !level flag::get( "move_killing_streets_hendricks_node_15" ) )
    {
        level flag::wait_till( "move_killing_streets_hendricks_node_15" );
    }
    
    var_a9e0b15b scene::play( "cin_ven_03_15_killingstreets_vign" );
}

// Namespace vengeance_killing_streets
// Params 0
// Checksum 0x160312a9, Offset: 0x31a8
// Size: 0x18f
function function_a45594e6()
{
    self endon( #"death" );
    self ai::set_ignoreme( 1 );
    self ai::set_ignoreall( 1 );
    setdvar( "ai_awarenessEnabled", 0 );
    self thread function_53a6540a();
    
    if ( !level flag::get( "move_killing_streets_hendricks_node_15" ) )
    {
        level flag::wait_till( "move_killing_streets_hendricks_node_15" );
    }
    
    self ai::set_ignoreall( 0 );
    setdvar( "ai_awarenessEnabled", 1 );
    
    while ( true )
    {
        eventname = self util::waittill_any_return( "killing_streets_intro_alerted", "scene_done", "done_shooting_civilian" );
        
        if ( eventname == "done_shooting_civilian" )
        {
            self ai::set_ignoreme( 0 );
            continue;
        }
        
        level flag::set( "cin_ven_03_15_killingstreets_vign_done" );
        killing_streets_enemy_gv = getent( "killing_streets_enemy_gv", "targetname" );
        
        if ( isdefined( killing_streets_enemy_gv ) )
        {
            if ( isdefined( self.killing_streets_intro_alerted ) && self.killing_streets_intro_alerted )
            {
                self waittill( #"hash_45b11ba2" );
                self.killing_streets_intro_alerted = undefined;
            }
            
            wait 0.05;
            self setgoal( killing_streets_enemy_gv );
        }
        
        return;
    }
}

// Namespace vengeance_killing_streets
// Params 0
// Checksum 0xaf89d03d, Offset: 0x3340
// Size: 0x52
function function_68661375()
{
    self endon( #"death" );
    self ai::set_ignoreme( 1 );
    self ai::set_ignoreall( 1 );
    self waittill( #"hash_55f87e20" );
    self ai::set_ignoreme( 0 );
    self ai::set_ignoreall( 0 );
}

// Namespace vengeance_killing_streets
// Params 0
// Checksum 0xb4e3e5b2, Offset: 0x33a0
// Size: 0x8f
function function_53a6540a()
{
    self endon( #"death" );
    self waittill( #"alert" );
    self notify( #"killing_streets_intro_alerted" );
    level.var_abd93cb3 notify( #"hash_55f87e20" );
    level.var_abd93cb3 stealth::stop();
    
    if ( isdefined( self.script_parameters ) )
    {
        self stealth::stop();
        self.killing_streets_intro_alerted = 1;
        self scene::play( self.script_parameters );
        self waittill( #"scene_done" );
        self notify( #"hash_45b11ba2" );
    }
}

// Namespace vengeance_killing_streets
// Params 0
// Checksum 0xaad210c3, Offset: 0x3438
// Size: 0xe2
function setup_killing_streets_civilian()
{
    self endon( #"death" );
    self.team = "allies";
    self ai::set_ignoreme( 1 );
    self ai::set_ignoreall( 1 );
    self.health = 1;
    
    if ( self.targetname == "killing_streets_alley_civ_a_ai" )
    {
        self.civilian = 1;
        self ai::set_behavior_attribute( "panic", 0 );
    }
    
    if ( isdefined( self.target ) )
    {
        node = getnode( self.target, "targetname" );
        self thread ai::force_goal( node, node.radius );
    }
    
    level waittill( #"killing_streets_end" );
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace vengeance_killing_streets
// Params 0
// Checksum 0xe6207760, Offset: 0x3528
// Size: 0xaa
function setup_killing_streets_civilian_lineup()
{
    self endon( #"death" );
    self.team = "allies";
    self.civilian = 1;
    self ai::set_ignoreme( 1 );
    self ai::set_behavior_attribute( "panic", 0 );
    self thread function_cfede1cf();
    level flag::wait_till( "killing_streets_lineup_patrollers_alerted" );
    self stopanimscripted();
    self ai::set_ignoreme( 0 );
    self ai::set_behavior_attribute( "panic", 1 );
}

// Namespace vengeance_killing_streets
// Params 0
// Checksum 0xceb065b6, Offset: 0x35e0
// Size: 0x42
function function_cfede1cf()
{
    self endon( #"death" );
    self waittill( #"kill_me" );
    self.takedamage = 1;
    self.skipdeath = 1;
    self.allowdeath = 1;
    self kill();
}

// Namespace vengeance_killing_streets
// Params 0
// Checksum 0x2f4a6ca4, Offset: 0x3630
// Size: 0x9a
function setup_killing_streets_lineup_patroller_spawners()
{
    self endon( #"death" );
    self ai::set_ignoreme( 1 );
    self util::waittill_any( "damage", "alert" );
    self ai::set_ignoreme( 0 );
    level flag::set( "killing_streets_lineup_patrollers_alerted" );
    util::clientnotify( "sndLRstop" );
    level thread namespace_9fd035::function_6c2fa1d0();
    self stopanimscripted();
}

// Namespace vengeance_killing_streets
// Params 0
// Checksum 0x26981396, Offset: 0x36d8
// Size: 0x2c
function killing_streets_robots()
{
    killing_streets_robots = spawner::simple_spawn( "killing_streets_robots", undefined, undefined, undefined, undefined, undefined, undefined, 1 );
}

// Namespace vengeance_killing_streets
// Params 4
// Checksum 0x921bafc9, Offset: 0x3710
// Size: 0x542
function skipto_killing_streets_done( str_objective, b_starting, b_direct, player )
{
    level flag::set( "killing_streets_end" );
    level cleanup_killing_streets();
    
    foreach ( player in level.activeplayers )
    {
        player clientfield::set_to_player( "play_client_igc", 2 );
    }
    
    vengeance_util::function_e00864bd( "dogleg_1_umbra_gate", 1, "dogleg_1_gate" );
    level struct::delete_script_bundle( "scene", "cin_ven_02_20_synckill_vign" );
    level struct::delete_script_bundle( "scene", "cin_ven_02_30_masterbedroom_vign" );
    level struct::delete_script_bundle( "scene", "cin_ven_hanging_body_loop_vign_civ03" );
    level struct::delete_script_bundle( "scene", "cin_ven_hanging_body_loop_vign_civ06" );
    level struct::delete_script_bundle( "scene", "cin_ven_hanging_body_loop_vign_civ08" );
    level struct::delete_script_bundle( "scene", "cin_ven_03_10_takedown_intro_1st" );
    level struct::delete_script_bundle( "scene", "cin_ven_03_10_takedown_intro_1st_props" );
    level struct::delete_script_bundle( "scene", "cin_ven_03_10_takedown_1st" );
    level struct::delete_script_bundle( "scene", "cin_ven_03_10_takedown_1st_props" );
    level struct::delete_script_bundle( "scene", "cin_ven_03_10_takedown_intro_1st_test" );
    level struct::delete_script_bundle( "scene", "cin_ven_01_02_rooftop_1st_overlook" );
    level struct::delete_script_bundle( "scene", "cin_ven_03_10_takedown_1st_hendricks" );
    level struct::delete_script_bundle( "scene", "cin_ven_03_11_gate_convo_vign" );
    level struct::delete_script_bundle( "scene", "cin_ven_03_15_killingstreets_vign_snipershot" );
    level struct::delete_script_bundle( "scene", "cin_ven_03_15_killingstreets_vign" );
    level struct::delete_script_bundle( "scene", "cin_ven_03_15_killingstreets_vign_loop" );
    level struct::delete_script_bundle( "scene", "cin_ven_03_15_killingstreets_vign_react_enemy_a" );
    level struct::delete_script_bundle( "scene", "cin_ven_03_15_killingstreets_vign_react_enemy_b" );
    level struct::delete_script_bundle( "scene", "cin_ven_03_15_killingstreets_vign_react_enemy_c" );
    level struct::delete_script_bundle( "scene", "cin_ven_03_15_killingstreets_vign_react_enemy_d" );
    level struct::delete_script_bundle( "scene", "cin_ven_03_20_storelineup_vign_start_hendricks_only" );
    level struct::delete_script_bundle( "scene", "cin_ven_03_20_storelineup_vign_move1" );
    level struct::delete_script_bundle( "scene", "cin_ven_03_20_storelineup_vign_move2" );
    level struct::delete_script_bundle( "scene", "cin_ven_03_20_storelineup_vign_move3" );
    level struct::delete_script_bundle( "scene", "cin_ven_03_20_storelineup_vign_fire" );
    level struct::delete_script_bundle( "scene", "cin_ven_03_20_storelineup_vign_loop" );
    level struct::delete_script_bundle( "scene", "cin_gen_f_floor_onfront_armdown_legstraight_deathpose_civ_sing" );
    level struct::delete_script_bundle( "scene", "cin_gen_m_floor_armup_legaskew_onfront_faceright_deathpose_civ_sing" );
    level struct::delete_script_bundle( "scene", "cin_gen_f_floor_onfront_armup_legstraight_deathpose_civ_sing" );
    level struct::delete_script_bundle( "scene", "cin_gen_f_floor_onleftside_armcurled_legcurled_deathpose_civ_sing" );
    level struct::delete_script_bundle( "scene", "cin_gen_m_wall_headonly_leanleft_deathpose_civ_sing" );
    level struct::delete_script_bundle( "scene", "cin_gen_m_floor_armstomach_onback_deathpose_civ_sing" );
    level struct::delete_script_bundle( "scene", "cin_gen_f_floor_onback_armup_legcurled_deathpose_civ_sing" );
    level struct::delete_script_bundle( "scene", "cin_gen_m_floor_armstretched_onrightside_deathpose_civ_sing" );
    level struct::delete_script_bundle( "scene", "cin_gen_m_armover_onrightside_deathpose_civ_sing" );
    vengeance_util::function_4e8207e9( "killing_streets", 0 );
}

// Namespace vengeance_killing_streets
// Params 0
// Checksum 0x9414bde7, Offset: 0x3c60
// Size: 0xc2
function cleanup_killing_streets()
{
    array::thread_all( getentarray( "killing_streets_lineup_patroller_spawners", "script_noteworthy" ), &util::self_delete );
    array::thread_all( getentarray( "killing_streets_robots", "targetname" ), &util::self_delete );
    exploder::exploder_stop( "killing_streets_butcher_fx" );
    level notify( #"strip_video_end" );
    wait 0.05;
    level notify( #"hash_92bd0e81" );
    vengeance_accolades::function_3229ece4();
}

// Namespace vengeance_killing_streets
// Params 0
// Checksum 0x486a33ef, Offset: 0x3d30
// Size: 0x26a
function function_ef12791()
{
    level waittill( #"hash_2b5b2f5d" );
    dogleg_1_intro_goto_obj_org = struct::get( "dogleg_1_intro_goto_obj_org", "targetname" );
    objectives::show( "cp_level_vengeance_go_to_safehouse" );
    objectives::set( "cp_waypoint_breadcrumb", dogleg_1_intro_goto_obj_org );
    dogleg_1_intro_trigger = getent( "dogleg_1_intro_trigger", "script_noteworthy" );
    dogleg_1_intro_trigger triggerenable( 0 );
    level thread util::set_streamer_hint( 3 );
    msg = level util::waittill_any_return( "dogleg_1_intro_goto_trigger_touched", "stealth_discovered" );
    
    if ( msg == "stealth_discovered" )
    {
        objectives::hide( "cp_waypoint_breadcrumb" );
        
        if ( level flag::get( "stealth_discovered" ) )
        {
            level flag::wait_till_clear( "stealth_discovered" );
        }
        
        objectives::show( "cp_waypoint_breadcrumb" );
        level flag::wait_till( "dogleg_1_intro_goto_trigger_touched" );
    }
    
    objectives::complete( "cp_waypoint_breadcrumb", dogleg_1_intro_goto_obj_org );
    objectives::hide( "cp_level_vengeance_go_to_safehouse" );
    dogleg_1_intro_trigger triggerenable( 1 );
    e_door_use_object = util::init_interactive_gameobject( dogleg_1_intro_trigger, &"cp_prompt_enter_ven_door", &"CP_MI_SING_VENGEANCE_HINT_OPEN", &function_88762207 );
    objectives::set( "cp_level_vengeance_open_dogleg_1_menu" );
    level thread vengeance_util::stealth_combat_toggle_trigger_and_objective( dogleg_1_intro_trigger, undefined, "cp_level_vengeance_open_dogleg_1_menu", "start_dogleg_1_intro", undefined, e_door_use_object );
    level waittill( #"hash_f1a04aa0" );
    e_door_use_object gameobjects::disable_object();
    objectives::hide( "cp_level_vengeance_open_dogleg_1_menu" );
    wait 0.1;
    skipto::objective_completed( "killing_streets" );
}

// Namespace vengeance_killing_streets
// Params 1
// Checksum 0xf70952b3, Offset: 0x3fa8
// Size: 0x1e
function function_88762207( e_player )
{
    level notify( #"hash_f1a04aa0" );
    level.var_4c62d05f = e_player;
}

// Namespace vengeance_killing_streets
// Params 0
// Checksum 0xfb7808a0, Offset: 0x3fd0
// Size: 0x152
function function_4b7aea65()
{
    wait 0.05;
    level.var_29304913 = struct::get( "killing_streets_breadcrumb_01" );
    objectives::set( "cp_waypoint_breadcrumb", level.var_29304913 );
    level flag::wait_till( "move_killing_streets_hendricks_node_05" );
    objectives::complete( "cp_waypoint_breadcrumb", level.var_29304913 );
    level flag::wait_till( "start_hendricks_open_alley_door_01" );
    level thread function_ff499dd5();
    level flag::wait_till( "hendricks_cleared_meat_market_door" );
    
    if ( !flag::get( "clear_killing_streets_breadcrumb_06" ) )
    {
        level.var_29304913 = struct::get( "killing_streets_breadcrumb_06" );
        objectives::set( "cp_waypoint_breadcrumb", level.var_29304913 );
        level flag::wait_till( "clear_killing_streets_breadcrumb_06" );
        objectives::complete( "cp_waypoint_breadcrumb", level.var_29304913 );
    }
}

// Namespace vengeance_killing_streets
// Params 0
// Checksum 0x3e659a06, Offset: 0x4130
// Size: 0x9a
function function_ff499dd5()
{
    level endon( #"start_hendricks_open_alley_door_02" );
    wait 20;
    
    if ( !flag::get( "clear_killing_streets_breadcrumb_04" ) )
    {
        level.var_29304913 = struct::get( "killing_streets_breadcrumb_04" );
        objectives::set( "cp_waypoint_breadcrumb", level.var_29304913 );
        level flag::wait_till( "clear_killing_streets_breadcrumb_04" );
        objectives::complete( "cp_waypoint_breadcrumb", level.var_29304913 );
    }
}

// Namespace vengeance_killing_streets
// Params 0
// Checksum 0x5e202da6, Offset: 0x41d8
// Size: 0x182
function function_71a7056()
{
    level flag::wait_till( "start_killing_streets_sniper_shoots_civilian" );
    wait 1.5;
    level.ai_hendricks vengeance_util::function_5fbec645( "hend_shit_weapons_ready_0" );
    
    if ( !level flag::get( "move_killing_streets_hendricks_node_15" ) )
    {
        level flag::wait_till( "move_killing_streets_hendricks_node_15" );
        level.ai_hendricks vengeance_util::function_5fbec645( "hend_contact_1" );
    }
    
    level flag::wait_till_any( array( "stealth_alert", "stealth_combat", "killing_streets_intro_patroller_spawners_cleared", "cin_ven_03_15_killingstreets_vign_done", "hendricks_break_ally_stealth" ) );
    level.ai_hendricks vengeance_util::function_5fbec645( "hend_weapons_free_0" );
    wait 0.5;
    level.ai_hendricks battlechatter::function_d9f49fba( 1 );
    level flag::wait_till( "move_hendricks_to_meat_market" );
    wait 1.75;
    level.ai_hendricks vengeance_util::function_5fbec645( "hend_what_the_fuck_is_wro_0" );
    wait 0.5;
    level.ai_hendricks vengeance_util::function_5fbec645( "hend_no_mission_is_worth_0" );
}

// Namespace vengeance_killing_streets
// Params 0
// Checksum 0xc989ac5a, Offset: 0x4368
// Size: 0x3a
function function_999f0273()
{
    level flag::wait_till( "hendricks_says_stay_down" );
    level.ai_hendricks vengeance_util::function_5fbec645( "hend_stay_down_1" );
}

// Namespace vengeance_killing_streets
// Params 0
// Checksum 0xd8288f94, Offset: 0x43b0
// Size: 0x6b
function function_9f0122b9()
{
    foreach ( player in level.activeplayers )
    {
        player clientfield::set_to_player( "play_client_igc", 1 );
    }
}

// Namespace vengeance_killing_streets
// Params 0
// Checksum 0x10ad79b5, Offset: 0x4428
// Size: 0xea
function function_28fa297f()
{
    lineup_kill_exit_door = getent( "lineup_kill_exit_door", "targetname" );
    
    if ( isdefined( lineup_kill_exit_door ) )
    {
        lineup_kill_exit_door hide();
        lineup_kill_exit_door notsolid();
    }
    
    lineup_kill_exit_door_clip = getent( "lineup_kill_exit_door_clip", "targetname" );
    
    if ( isdefined( lineup_kill_exit_door_clip ) )
    {
        lineup_kill_exit_door_clip notsolid();
        wait 0.1;
        lineup_kill_exit_door_clip connectpaths();
        level flag::wait_till( "killing_streets_end" );
        lineup_kill_exit_door_clip solid();
        wait 0.1;
        lineup_kill_exit_door_clip disconnectpaths();
    }
}

