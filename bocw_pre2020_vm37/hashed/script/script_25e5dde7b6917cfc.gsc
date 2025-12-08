#using script_13209888df6eddf6;
#using script_1b9f100b85b7e21d;
#using script_25b0725f0d26dbf5;
#using script_26da9649903c629a;
#using script_32ff16d71b77016b;
#using script_3711e526ec2a3863;
#using script_3dc93ca9902a9cda;
#using script_3de47beee8436774;
#using script_4937c6974f43bb71;
#using script_4a5e7e929ab4ac21;
#using script_7a8ad4f66d2967a6;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicleriders_shared;
#using scripts\cp\cp_nam_armada_fx;
#using scripts\cp_common\dialog_tree;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hint_tutorial;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;

#namespace namespace_e871b49a;

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 2
// Checksum 0xd2c79725, Offset: 0x1d80
// Size: 0x6c4
function intro_flow( *var_d3440450, *var_50cc0d4f )
{
    level function_55d23d1e();
    level clientfield::set( "toggle_gameplay_character_visibility", 0 );
    a_ents = [];
    a_ents[ #"buddy" ] = level.buddy;
    a_ents[ #"pilot" ] = level.pilot;
    a_ents[ #"copilot" ] = level.copilot;
    a_ents[ #"hash_4972abe0166bbc73" ] = level.var_7466d419;
    level thread scene::init( #"hash_69b8e06afe12b8f9", a_ents );
    a_ents = [];
    a_ents[ #"vip" ] = level.vip;
    level thread scene::init( #"armada_intro", a_ents );
    level thread function_c9528d2b();
    level thread function_3f7b5c03();
    level flag::set( "flag_vo_intro_start" );
    level thread function_d7d6110f();
    level thread function_9180c609( "intro_ambient_runners_loopers", "flag_intro_player_vm_done", undefined, 5 );
    level thread function_e2df4629( "intro_drone_spawner_group_1", "flag_intro_player_vm_done", "intro_spawn_drone", 8 );
    level thread function_3a5d1f07( #"hash_23307f84986782ff", "idle", "exit", "flag_intro_crate_guys_go" );
    level thread function_3a5d1f07( #"hash_799d967f164f5092", "idle", "exit", "flag_intro_card_guys_go" );
    level util::delay( 0.25, undefined, &function_3a5d1f07, #"hash_18d1fb728f438332", "idle", "exit", "flag_intro_drinking_guys_1_go" );
    level util::delay( 1, undefined, &function_3a5d1f07, #"hash_132134e8d6335e7f", "idle", "exit", "flag_intro_drinking_guys_2_go" );
    level util::delay( 0.5, undefined, &function_48b95055 );
    level thread namespace_72b0499b::function_816f9a23();
    level thread function_4fa68c0a();
    level thread function_3705ef2f( "flag_intro_player_vm_done" );
    level thread intro_chinook_lift_off();
    level.player thread function_2549ca47();
    level.playerstartingweapon = level.player getcurrentweapon();
    level thread namespace_9a981837::pstfx_vignette();
    level util::delay( 0.25, undefined, &scene::init, #"hash_5cceffc35d2de027" );
    level util::delay( 0.35, undefined, &scene::init, #"hash_65c743e9446696f6" );
    level util::delay( 0.5, undefined, &function_3ffae7ac );
    snd::client_msg( #"hash_394162110e28e4d1" );
    a_ents = [];
    a_ents[ #"buddy" ] = level.buddy;
    a_ents[ #"pilot" ] = level.pilot;
    a_ents[ #"copilot" ] = level.copilot;
    a_ents[ #"hash_4972abe0166bbc73" ] = level.var_7466d419;
    level thread scene::play( #"hash_69b8e06afe12b8f9", "idle", a_ents );
    level thread function_d697a743();
    level flag::wait_till( "flag_intro_player_vm_done" );
    
    if ( getdvarint( #"hash_2bf6d0a7334fd086", 1 ) == 1 )
    {
        level util::delay( 0.5, undefined, &globallogic_ui::function_7bc0e4b9, 0 );
    }
    
    level util::delay( 2, undefined, &namespace_82bfe441::fade, 0, "FadeSlow" );
    level thread objectives::follow( "armada_obj_intro_follow_vip", level.vip, #"hash_33eb8fa6e913e996" );
    level flag::wait_till( "flag_intro_base_tent_leave" );
    level flag::set( "flag_intro_ambient_vehicles_start" );
    level flag::wait_till( "flag_intro_wave_take_off" );
    skipto::function_4e3ab877( "armada_intro" );
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 0
// Checksum 0xdda6ac22, Offset: 0x2450
// Size: 0x7c
function function_3ffae7ac()
{
    a_ents = [];
    
    if ( isdefined( level.gunner ) )
    {
        level.gunner ai::gun_remove();
        a_ents[ #"hash_2082d5270bdcf457" ] = level.gunner;
    }
    
    level scene::init( #"hash_3dd341991cbe55b0", a_ents );
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 0
// Checksum 0x3e614354, Offset: 0x24d8
// Size: 0xec
function function_2549ca47()
{
    self notify( "3de08f8c87227cce" );
    self endon( "3de08f8c87227cce" );
    self endon( #"death" );
    self waittill( #"hash_471925ec14b4374f" );
    self setviewclamp( 20, 20, 15, 15, 0, 0, 1 );
    self waittill( #"hash_76056e58357b2855" );
    self setviewclamp( 0, 0, 0, 0, 0, 1, 1 );
    self waittill( #"hash_1a277ed0faa745f7" );
    self setviewclamp( 15, 15, 15, 15, undefined, 0 );
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 2
// Checksum 0xc29d3ad4, Offset: 0x25d0
// Size: 0x18c
function function_efd3381d( var_a3ad3414, var_646aad9f = 1 )
{
    self endon( #"death" );
    self waittill( #"scene_done", #"intro_anim_done" );
    self.script_radius = 128;
    self.delete_on_path_end = 1;
    
    if ( !var_646aad9f || self.aitype === #"hash_4d52bea52bd00dbd" || self.aitype === #"hash_421500ac712b73b2" )
    {
        self ai::gun_remove();
    }
    
    self thread namespace_b7cfe907::delete_on_flag( "flag_intro_base_cleanup" );
    
    if ( isdefined( self.var_5ca26d2d ) && isdefined( self.var_b11e7fca ) )
    {
        var_5ca26d2d = self.var_5ca26d2d;
        var_c356b2bd = "armada_fake_uh1d_crew_pos_" + self.var_b11e7fca;
        level thread function_a8db30d2( var_c356b2bd, var_5ca26d2d, self );
        return;
    }
    
    if ( isdefined( var_a3ad3414 ) )
    {
        self thread spawner::go_to_node( getnode( var_a3ad3414, "script_noteworthy" ) );
    }
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 0
// Checksum 0x17a6575d, Offset: 0x2768
// Size: 0x66c
function function_d697a743()
{
    level endon( #"flag_intro_player_boarded_chopper" );
    a_ents = [];
    a_ents[ #"vip" ] = level.vip;
    var_ca59388a = struct::get( "scripted_node_airbase", "targetname" );
    level thread scene::play( #"armada_intro", "intro", a_ents );
    level flag::wait_till( "flag_intro_adler_first_walk_done" );
    waitframe( 1 );
    
    if ( level flag::get( "flag_intro_adler_walk_talk_pos_1" ) )
    {
        level flag::set( "flag_vo_gearup_walk" );
        level scene::play( #"armada_intro", "walk_01", a_ents );
    }
    else
    {
        level thread function_366b6210( "flag_intro_adler_walk_talk_pos_1", 12 );
        level scene::play( #"armada_intro", "idle_01_enter", a_ents );
        level flag::set( "flag_vo_intro_walk_and_talk_nags" );
        level thread scene::play( #"armada_intro", "idle_01", a_ents );
        level flag::wait_till( "flag_intro_adler_walk_talk_pos_1" );
        level flag::clear( "flag_vo_intro_walk_and_talk_nags" );
        level flag::set( "flag_vo_gearup_walk" );
        level scene::play( #"armada_intro", "idle_01_exit", a_ents );
    }
    
    level scene::play( #"armada_intro", "walk_02", a_ents );
    
    if ( level flag::get( "flag_intro_adler_walk_talk_pos_2" ) )
    {
        level flag::set( "flag_vo_gearup_walk_pt2" );
        level scene::play( #"armada_intro", "walk_02b", a_ents );
    }
    else
    {
        level thread function_366b6210( "flag_intro_adler_walk_talk_pos_2", 5 );
        level scene::play( #"armada_intro", "idle_02_enter", a_ents );
        level flag::set( "flag_vo_intro_walk_and_talk_nags" );
        level thread scene::play( #"armada_intro", "idle_02", a_ents );
        level flag::wait_till( "flag_intro_adler_walk_talk_pos_2" );
        level flag::clear( "flag_vo_intro_walk_and_talk_nags" );
        level flag::set( "flag_vo_gearup_walk_pt2" );
        level scene::play( #"armada_intro", "idle_02_exit", a_ents );
    }
    
    level scene::play( #"armada_intro", "walk_03", a_ents );
    
    if ( level flag::get( "flag_intro_adler_walk_talk_pos_3" ) )
    {
        level flag::set( "flag_vo_gearup_walk_pt3" );
        level scene::play( #"armada_intro", "walk_03b", a_ents );
    }
    else
    {
        level thread function_366b6210( "flag_intro_adler_walk_talk_pos_3", 5 );
        level scene::play( #"armada_intro", "idle_03_enter", a_ents );
        level flag::set( "flag_vo_intro_walk_and_talk_nags" );
        level thread scene::play( #"armada_intro", "idle_03", a_ents );
        level flag::wait_till( "flag_intro_adler_walk_talk_pos_3" );
        level flag::clear( "flag_vo_intro_walk_and_talk_nags" );
        level flag::set( "flag_vo_gearup_walk_pt3" );
        level scene::play( #"armada_intro", "idle_03_exit", a_ents );
    }
    
    level scene::play( #"armada_intro", "walk_04", a_ents );
    level scene::play( #"armada_intro", "idle_at_huey_enter", a_ents );
    level thread scene::play( #"armada_intro", "idle_at_huey", a_ents );
    level flag::set( "flag_intro_adler_at_chopper" );
    level thread function_366b6210( "flag_intro_adler_walk_talk_pos_4", 2.5 );
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 2
// Checksum 0x21a4d197, Offset: 0x2de0
// Size: 0x56
function function_366b6210( var_a4bff476, waittime )
{
    level endon( var_a4bff476 );
    wait waittime;
    
    while ( true )
    {
        level.player thread objectives_ui::show_objectives( 1 );
        wait 3;
    }
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 0
// Checksum 0x8df242f3, Offset: 0x2e40
// Size: 0xb4
function function_14f8a3e2()
{
    self endon( #"death", #"disconnect" );
    level flag::wait_till( "flag_intro_player_lower_weapon" );
    level.player disableweapons();
    level flag::wait_till( "flag_intro_adler_walk_talk_pos_4" );
    level.player switchtoweapon( level.playerstartingweapon );
    level.player enableweapons();
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 0
// Checksum 0xa9d03057, Offset: 0x2f00
// Size: 0xbc
function function_78bd4d2e()
{
    level endon( #"flag_intro_adler_walk_talk_pos_4" );
    a_ents = [];
    a_ents[ #"buddy" ] = level.buddy;
    a_ents[ #"hash_4972abe0166bbc73" ] = level.var_7466d419;
    level scene::play( #"hash_1e4547ef1f1d4686", "idleathuey_enter", a_ents );
    level thread scene::play( #"hash_1e4547ef1f1d4686", "idleathuey", a_ents );
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 0
// Checksum 0xad0ed48e, Offset: 0x2fc8
// Size: 0x14c
function function_c9528d2b()
{
    level thread scene::init( #"hash_546965da456bebee" );
    
    while ( !( isdefined( level.var_8a60c701 ) && isdefined( level.var_bca32b85 ) ) )
    {
        waitframe( 1 );
    }
    
    level.var_8a60c701 flag::wait_till_all( [ "flag_intro_crew_6_boarded", "flag_intro_crew_7_boarded", "flag_intro_crew_9_boarded", "flag_intro_crew_10_boarded" ] );
    level.var_bca32b85 flag::wait_till_all( [ "flag_intro_crew_6_boarded", "flag_intro_crew_7_boarded", "flag_intro_crew_9_boarded", "flag_intro_crew_10_boarded" ] );
    level flag::wait_till( "flag_intro_hueys_take_off" );
    level thread scene::play( #"hash_546965da456bebee" );
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 0
// Checksum 0x2f7ffe04, Offset: 0x3120
// Size: 0x314
function function_3f7b5c03()
{
    level thread scene::init( #"hash_7faf0cdd480159ac" );
    level thread scene::play( #"hash_3a861ae2553ea946", "idle" );
    level thread scene::play( #"hash_ed7556e18f2b31d", "init" );
    level thread scene::play( #"hash_641c6501310adb27", "Shot 1" );
    level flag::wait_till( "flag_intro_player_vm_done" );
    level thread scene::play( #"hash_7faf0cdd480159ac", "hover" );
    level thread scene::play( #"hash_2108e18b1a8b5de3" );
    level thread scene::play( #"hash_2108e08b1a8b5c30" );
    var_bd62ddf0 = "flag_intro_cobras_take_off";
    level thread function_eb674c04( var_bd62ddf0 );
    level flag::wait_till_any( [ var_bd62ddf0, "flag_intro_look_at_cobras" ] );
    level thread scene::play( #"hash_2108e28b1a8b5f96" );
    wait 0.2;
    level thread scene::stop( #"hash_36f8dd3415b89491", 1 );
    level thread scene::play( #"hash_7faf0cdd480159ac", "flyout" );
    wait 7.2;
    level thread scene::play( #"hash_3a861ae2553ea946", "gust" );
    wait 1;
    level thread scene::play( #"hash_ed7556e18f2b31d", "Shot 1" );
    wait 1;
    level thread scene::play( #"hash_641c6501310adb27", "Shot 2" );
    wait 3.5;
    level thread scene::stop( #"hash_3a861ae2553ea946", 1 );
    wait 2.8;
    level thread scene::stop( #"hash_641c6501310adb27", 1 );
    level thread scene::play( #"hash_2978a9b1c68ba898", "play" );
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 1
// Checksum 0xf73c5360, Offset: 0x3440
// Size: 0xa4
function function_eb674c04( var_bd62ddf0 )
{
    level endon( var_bd62ddf0 );
    level.player endon( #"death" );
    var_fddd8e7 = struct::get( "lookat_target_cobras", "targetname" );
    level.player util::waittill_player_looking_at( var_fddd8e7.origin, 90, 1, self );
    level flag::set( "flag_intro_look_at_cobras" );
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 4
// Checksum 0xd196040, Offset: 0x34f0
// Size: 0x5c
function function_3a5d1f07( scene, idle_shot, *exit_shot, *var_f2fdaafa )
{
    level scene::init( exit_shot );
    level thread scene::play( exit_shot, var_f2fdaafa );
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 4
// Checksum 0x3ff11d43, Offset: 0x3558
// Size: 0x324
function function_9180c609( var_21638290, start_flag, var_e69c8944, *start_delay = "intro_fake_runner_spawner" )
{
    spawner = getent( start_delay, "targetname" );
    start_structs = struct::get_array( start_flag, "targetname" );
    guys = [];
    
    foreach ( struct in start_structs )
    {
        guy = spawner spawner::spawn( 1, "", struct.origin, struct.angles );
        guy.delete_on_path_end = 1;
        guy.script_radius = 128;
        e_goal = getnode( struct.target, "targetname" );
        guy.var_e97a6587 = e_goal;
        
        if ( !isdefined( guys ) )
        {
            guys = [];
        }
        else if ( !isarray( guys ) )
        {
            guys = array( guys );
        }
        
        guys[ guys.size ] = guy;
    }
    
    if ( isdefined( var_e69c8944 ) )
    {
        level flag::wait_till_any( [ var_e69c8944, "flag_intro_base_cleanup" ] );
    }
    
    if ( !level flag::get( "flag_intro_base_cleanup" ) )
    {
        foreach ( guy in guys )
        {
            guy thread spawner::go_to_node( guy.var_e97a6587 );
            wait randomfloatrange( 0.15, 0.25 );
        }
        
        level flag::wait_till( "flag_intro_base_cleanup" );
    }
    
    function_1eaaceab( guys );
    array::delete_all( guys );
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 0
// Checksum 0x32505c7c, Offset: 0x3888
// Size: 0x204
function function_d7d6110f()
{
    level thread scene::play( #"hash_4e2911483e0977d1", "idle" );
    level thread scene::play( #"hash_50b717d4d81fd84", "idle" );
    level thread scene::play( #"hash_4c4767224f090a00", "idle" );
    level thread scene::play( #"hash_140385b56b0d72f6", "idle" );
    level thread scene::play( #"hash_5c50c9a83f5516ac", "idle" );
    level thread scene::play( #"hash_2e9f4f58613173d0", "idle" );
    level flag::wait_till( "flag_intro_base_cleanup" );
    level scene::stop( #"hash_50b717d4d81fd84", 1 );
    level scene::stop( #"hash_4c4767224f090a00", 1 );
    level scene::stop( #"hash_4e2911483e0977d1", 1 );
    level scene::stop( #"hash_140385b56b0d72f6", 1 );
    level scene::stop( #"hash_5c50c9a83f5516ac", 1 );
    level scene::stop( #"hash_2e9f4f58613173d0", 1 );
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 0
// Checksum 0x14361bd4, Offset: 0x3a98
// Size: 0x294
function function_48b95055()
{
    level endon( #"hash_34f048d2fedcfa3e" );
    level thread function_4ce9d8f6();
    level thread scene::play( #"hash_61e4263a57561de4", "idle_relax" );
    level flag::wait_till( "flag_intro_air_marshall_relax_to_ready" );
    level scene::play( #"hash_61e4263a57561de4", "relax_to_ready" );
    level thread scene::play( #"hash_61e4263a57561de4", "idle_ready" );
    level flag::wait_till( "flag_intro_air_marshall_ready_to_revup" );
    level scene::play( #"hash_61e4263a57561de4", "ready_to_revup" );
    level thread scene::play( #"hash_61e4263a57561de4", "idle_revup" );
    level flag::wait_till( "flag_intro_air_marshall_revup_to_liftoff" );
    level scene::play( #"hash_61e4263a57561de4", "revup_to_liftoff" );
    level thread scene::play( #"hash_61e4263a57561de4", "idle_liftoff" );
    level flag::wait_till( "flag_intro_hueys_take_off" );
    level scene::play( #"hash_61e4263a57561de4", "liftoff_to_turn" );
    level thread scene::play( #"hash_61e4263a57561de4", "idle_turn" );
    wait 5;
    level scene::play( #"hash_61e4263a57561de4", "signal_and_walk_left" );
    level thread scene::play( #"hash_61e4263a57561de4", "idle_relax_02" );
    level flag::set( "flag_intro_air_marhsall_first_column_complete" );
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 0
// Checksum 0x6930d040, Offset: 0x3d38
// Size: 0x1fc
function function_4ce9d8f6()
{
    level flag::wait_till( "flag_intro_air_marshall_tele" );
    
    if ( !flag::get( "flag_intro_air_marhsall_first_column_complete" ) )
    {
        level notify( #"hash_34f048d2fedcfa3e" );
    }
    
    level thread scene::play( #"hash_61e4263a57561de4", "idle_ready_02" );
    level flag::wait_till( "flag_intro_air_marshall_start_player_takeoff" );
    level scene::play( #"hash_61e4263a57561de4", "ready_to_revup_02" );
    level thread scene::play( #"hash_61e4263a57561de4", "idle_revup_02" );
    level.var_7466d419 setrotorspeed( 1 );
    wait 1;
    level scene::play( #"hash_61e4263a57561de4", "revup_to_liftoff_02" );
    level thread scene::play( #"hash_61e4263a57561de4", "idle_liftoff_02" );
    wait 5;
    level scene::play( #"hash_61e4263a57561de4", "liftoff_to_turn_02" );
    level thread scene::play( #"hash_61e4263a57561de4", "idle_turn_02" );
    level flag::wait_till( "flag_intro_base_cleanup" );
    level thread scene::stop( #"hash_61e4263a57561de4" );
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 0
// Checksum 0xc1241b6b, Offset: 0x3f40
// Size: 0x200
function function_4fa68c0a()
{
    var_efbe0740 = vehicle::simple_spawn( "intro_base_tent_convoy" );
    array::thread_all( var_efbe0740, &function_a515aac6 );
    var_50988c48 = getvehiclearray( "intro_lead_convoy_truck", "script_noteworthy" );
    var_576fb569 = getvehiclenodearray( "intro_ambient_vehicle_start_node", "targetname" );
    var_2c4dfb60 = array( "vehicle_t9_mil_us_truck_m35_canvas_cp", "veh_t9_mil_truck_jeep_cp", "vehicle_t9_mil_us_truck_m35_tanker_cp", "vehicle_t9_mil_us_truck_m35_cargo_cp" );
    str_notify = "spawn_new_intro_truck";
    var_efbe0740 = arraysortclosest( var_efbe0740, var_50988c48[ 0 ].origin );
    level flag::wait_till( "flag_vo_gearup_walk" );
    level thread function_7fabe565( str_notify, var_576fb569, var_2c4dfb60, 1 );
    
    foreach ( var_ff72be84 in var_efbe0740 )
    {
        var_ff72be84 thread vehicle::go_path();
        var_ff72be84 thread function_b4dd21d4( str_notify );
        wait randomfloatrange( 0.8, 1.2 );
    }
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 0
// Checksum 0xc971043, Offset: 0x4148
// Size: 0x154
function function_a515aac6()
{
    self vehicle::lights_on();
    self vehicle::toggle_force_driver_taillights( 1 );
    self vehicle::toggle_sounds( 1 );
    self vehicle::toggle_exhaust_fx( 1 );
    self thread namespace_b7cfe907::delete_on_flag( "flag_intro_base_cleanup" );
    self setcandamage( 0 );
    
    if ( isinarray( array( #"vehicle_t9_mil_us_truck_m35_canvas_cp", #"vehicle_t9_mil_us_truck_m35_cargo_cp", #"vehicle_t9_mil_us_truck_m35_tanker_cp" ), self.vehicletype ) )
    {
        self thread scene::play( #"hash_53f5d6c174b9f834" );
        return;
    }
    
    if ( self.vehicletype === #"veh_t9_mil_truck_jeep_cp" )
    {
        self thread scene::play( #"hash_1f2b5a32cea8e511" );
    }
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 3
// Checksum 0xab4a27ce, Offset: 0x42a8
// Size: 0x1b8
function function_1f117688( var_be221022, var_d393f80b, var_cb779250 )
{
    self endon( #"death" );
    level endon( #"flag_intro_base_cleanup" );
    
    while ( true )
    {
        self waittill( var_be221022 );
        util::wait_network_frame();
        var_32dbd0b4 = getvehiclenodearray( var_d393f80b, "targetname" );
        selected_node = array::random( var_32dbd0b4 );
        self vehicle::get_on_path( selected_node );
        
        if ( is_true( var_cb779250 ) )
        {
            if ( level flag::get( "flag_intro_truck_intersection_occupied" ) )
            {
                while ( true )
                {
                    self ghost();
                    level flag::wait_till_clear( "flag_intro_truck_intersection_occupied" );
                    wait randomfloatrange( 1, 2 );
                    
                    if ( !level flag::get( "flag_intro_truck_intersection_occupied" ) )
                    {
                        self show();
                        break;
                    }
                }
            }
        }
        
        self thread vehicle::go_path();
    }
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 1
// Checksum 0x1a990e47, Offset: 0x4468
// Size: 0x84
function function_b4dd21d4( str_notify )
{
    level endon( #"flag_intro_base_cleanup" );
    self endon( #"death" );
    self waittill( #"reached_end_node" );
    level notify( str_notify );
    self scene::stop( 1 );
    self deletedelay();
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 4
// Checksum 0x53d6afaa, Offset: 0x44f8
// Size: 0x188
function function_7fabe565( str_notify, var_576fb569, var_2c4dfb60, b_wait = 0 )
{
    level endon( #"flag_intro_base_cleanup" );
    
    while ( true )
    {
        level waittill( #"spawn_new_intro_truck" );
        nd_start = array::random( var_576fb569 );
        var_d240817d = array::random( var_2c4dfb60 );
        wait randomfloatrange( 1, 2 );
        
        if ( b_wait )
        {
            while ( level flag::get( "flag_intro_truck_intersection_occupied" ) )
            {
                waitframe( 1 );
            }
        }
        
        var_ff72be84 = vehicle::spawn( undefined, "intro_base_tent_convoy", var_d240817d, nd_start.origin, nd_start.angles );
        var_ff72be84 function_a515aac6();
        var_ff72be84 thread function_b4dd21d4( str_notify );
        var_ff72be84 thread vehicle::get_on_and_go_path( nd_start );
    }
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 0
// Checksum 0xc36925de, Offset: 0x4688
// Size: 0x13c
function intro_chinook_lift_off()
{
    chinook = vehicle::simple_spawn_single( "intro_chinook_lift_off" );
    chinook vehicle::toggle_tread_fx( 1 );
    chinook vehicle::toggle_exhaust_fx( 1 );
    chinook setrotorspeed( 0.3 );
    var_eb73902e = getvehiclenode( "intro_chinook_lift_off_node_start", "targetname" );
    level flag::wait_till( "flag_vo_gearup_walk" );
    chinook setrotorspeed( 1 );
    wait 1.8;
    chinook vehicle::set_goal_pos( var_eb73902e.origin, 1 );
    chinook waittill( #"goal" );
    chinook vehicle::get_on_and_go_path( var_eb73902e );
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 0
// Checksum 0x40ab7aa9, Offset: 0x47d0
// Size: 0x50c
function function_55d23d1e()
{
    scene::add_scene_func( #"hash_23307f84986782ff", &function_616d5fff, "init" );
    scene::add_scene_func( #"hash_799d967f164f5092", &function_67ac2154, "init" );
    scene::add_scene_func( #"hash_18d1fb728f438332", &function_50941fc1, "init" );
    scene::add_scene_func( #"hash_132134e8d6335e7f", &function_8479fc80, "init" );
    scene::add_scene_func( #"hash_7faf0cdd480159ac", &namespace_b7cfe907::function_a641ac8b, "init" );
    scene::add_scene_func( #"hash_546965da456bebee", &function_8f9d1155, "init" );
    scene::add_scene_func( #"hash_546965da456bebee", &namespace_b7cfe907::function_a641ac8b, "init" );
    scene::add_scene_func( #"hash_546965da456bebee", &function_c4b6673f, "done" );
    scene::add_scene_func( #"hash_5cceffc35d2de027", &namespace_b7cfe907::function_a641ac8b, "init" );
    scene::add_scene_func( #"hash_65c743e9446696f6", &function_ea6224e, "init" );
    scene::add_scene_func( #"hash_65c743e9446696f6", &namespace_b7cfe907::function_1eff410c, "init" );
    scene::add_scene_func( #"hash_3dd341991cbe55b0", &function_ea6224e, "init" );
    scene::add_scene_func( #"hash_3dd341991cbe55b0", &namespace_b7cfe907::function_1eff410c, "init" );
    scene::add_scene_func( #"hash_5cceffc35d2de027", &function_ea6224e, "gear_up_pt02" );
    scene::add_scene_func( #"hash_65c743e9446696f6", &function_b281d751, "gear_up_pt02" );
    scene::add_scene_func( #"hash_65c743e9446696f6", &namespace_b7cfe907::function_a641ac8b, "gear_up_pt02" );
    scene::add_scene_func( #"hash_3dd341991cbe55b0", &function_b281d751, "gear_up_pt02" );
    scene::add_scene_func( #"hash_3dd341991cbe55b0", &namespace_b7cfe907::function_a641ac8b, "gear_up_pt02" );
    scene::add_scene_func( #"hash_3dd341991cbe55b0", &function_d6d8b189, "approaching_firebase" );
    scene::add_scene_func( #"hash_3dd341991cbe55b0", &namespace_b7cfe907::function_a641ac8b, "approaching_firebase" );
    scene::add_scene_func( #"hash_3dd341991cbe55b0", &function_d6d8b189, "approaching_firebase_pt2" );
    scene::add_scene_func( #"hash_3dd341991cbe55b0", &namespace_b7cfe907::function_a641ac8b, "approaching_firebase_pt2" );
    scene::function_d8a83a50( #"hash_45e2dd5c24266fcf", &function_d4337a8d, "approaching_firebase" );
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 1
// Checksum 0xe37576f0, Offset: 0x4ce8
// Size: 0x1b0
function function_70c35833( a_ents )
{
    foreach ( index, ent in a_ents )
    {
        if ( !isdefined( ent ) )
        {
            continue;
        }
        
        if ( index === #"pilot1" )
        {
            ent ai::set_behavior_attribute( #"_civ_mode", "run" );
        }
        
        if ( index === #"pilot2" )
        {
            ent ai::set_behavior_attribute( #"_civ_mode", "run" );
        }
        
        if ( index === #"pilot1" || index === #"pilot2" || index === #"hash_4b43389515b6fa6f" || index === #"hash_4b43399515b6fc22" || index === #"hash_4b433a9515b6fdd5" || index === #"hash_4b43339515b6f1f0" )
        {
            ent thread function_efd3381d( "intro_guys_mid_node" );
        }
    }
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 1
// Checksum 0xc6d14e71, Offset: 0x4ea0
// Size: 0x54
function function_616d5fff( a_ents )
{
    while ( !isdefined( level.var_13d1eb5c ) )
    {
        waitframe( 1 );
    }
    
    function_d59527cd( a_ents, level.var_13d1eb5c, 6, 9, undefined, "climbin2" );
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 1
// Checksum 0x2e35a742, Offset: 0x4f00
// Size: 0x54
function function_67ac2154( a_ents )
{
    while ( !isdefined( level.var_13d1eb5c ) )
    {
        waitframe( 1 );
    }
    
    function_d59527cd( a_ents, level.var_13d1eb5c, 7, 10, undefined, "climbin" );
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 1
// Checksum 0xd377f355, Offset: 0x4f60
// Size: 0x54
function function_50941fc1( a_ents )
{
    while ( !isdefined( level.var_5844ec1 ) )
    {
        waitframe( 1 );
    }
    
    function_d59527cd( a_ents, level.var_5844ec1, 6, 9, undefined, "climbin2" );
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 1
// Checksum 0x82100df0, Offset: 0x4fc0
// Size: 0x54
function function_8479fc80( a_ents )
{
    while ( !isdefined( level.var_5844ec1 ) )
    {
        waitframe( 1 );
    }
    
    function_d59527cd( a_ents, level.var_5844ec1, 7, 10, undefined, "climbin" );
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 6
// Checksum 0x2af4cbc4, Offset: 0x5020
// Size: 0x178
function function_d59527cd( a_ents, var_5ca26d2d, var_6626615f, var_aea37254, var_3ee2df30, var_4ca17aad )
{
    var_a09218fc = var_5ca26d2d;
    
    foreach ( index, ent in a_ents )
    {
        if ( !isdefined( ent ) )
        {
            continue;
        }
        
        if ( ent.aitype === #"hash_262ebc4f609e2513" )
        {
            if ( index === #"actor 1" )
            {
                ent.var_b11e7fca = var_6626615f;
                
                if ( isdefined( var_3ee2df30 ) )
                {
                    ent.var_642dba7f = var_3ee2df30;
                }
            }
            else if ( index === #"actor 2" )
            {
                ent.var_b11e7fca = var_aea37254;
                
                if ( isdefined( var_4ca17aad ) )
                {
                    ent.var_642dba7f = var_4ca17aad;
                }
            }
            
            ent.var_5ca26d2d = var_a09218fc;
            ent thread function_efd3381d();
        }
    }
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 1
// Checksum 0x46ac93, Offset: 0x51a0
// Size: 0x210
function function_8f9d1155( a_ents )
{
    str_model = #"hash_262ebc4f609e2513";
    weapon = getweapon( #"hash_4ff481a4f55ed901" );
    var_129f138 = #"hash_4d52bea52bd00dbd";
    var_a61227dc = #"hash_421500ac712b73b2";
    
    foreach ( index, ent in a_ents )
    {
        if ( !isdefined( ent ) )
        {
            continue;
        }
        
        if ( index === #"vehicle 1" || index === #"vehicle 2" )
        {
            ent thread namespace_b7cfe907::function_9ac0bc90( [ 0, 1, 8 ] );
            var_38ff2460 = undefined;
            
            if ( index === #"vehicle 1" )
            {
                level.var_8a60c701 = ent;
                var_38ff2460 = 1;
            }
            else if ( index === #"vehicle 2" )
            {
                level.var_bca32b85 = ent;
                var_38ff2460 = 2;
            }
            
            level thread function_96315ae6( ent, "flag_intro_boarders_go", var_38ff2460 );
            continue;
        }
        
        ent thread namespace_b7cfe907::function_9ac0bc90();
    }
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 3
// Checksum 0x47ba0f4f, Offset: 0x53b8
// Size: 0x330
function function_96315ae6( chopper, var_f2fdaafa, var_38ff2460 )
{
    chopper endon( #"death" );
    var_4207a482 = "intro_fake_crew_boarder_spawner";
    var_ab9579c5 = "intro_fake_crew_spawn_loc";
    var_60fa7216 = "chopper_" + string( var_38ff2460 );
    var_c6bc9e5a = [];
    spawners = getspawnerarray( var_4207a482, "targetname" );
    spawn_locs = struct::get_array( var_ab9579c5, "targetname" );
    
    foreach ( loc in spawn_locs )
    {
        if ( !( isdefined( loc.script_int ) && isdefined( loc.script_noteworthy ) ) )
        {
            continue;
        }
        
        if ( loc.script_noteworthy != var_60fa7216 )
        {
            continue;
        }
        
        guy = spawners[ 0 ] spawner::spawn( 1, undefined, loc.origin, loc.angles );
        guy.var_b11e7fca = loc.script_int;
        
        if ( isdefined( loc.script_delay ) )
        {
            guy.var_cb83d143 = loc.script_delay;
        }
        
        if ( !isdefined( var_c6bc9e5a ) )
        {
            var_c6bc9e5a = [];
        }
        else if ( !isarray( var_c6bc9e5a ) )
        {
            var_c6bc9e5a = array( var_c6bc9e5a );
        }
        
        var_c6bc9e5a[ var_c6bc9e5a.size ] = guy;
    }
    
    level flag::wait_till( var_f2fdaafa );
    
    foreach ( guy in var_c6bc9e5a )
    {
        var_c356b2bd = "armada_fake_uh1d_crew_pos_" + guy.var_b11e7fca;
        
        if ( isdefined( guy.var_cb83d143 ) )
        {
            level util::delay( guy.var_cb83d143, undefined, &function_a8db30d2, var_c356b2bd, chopper, guy );
            continue;
        }
        
        level thread function_a8db30d2( var_c356b2bd, chopper, guy );
    }
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 3
// Checksum 0x43e0ecb4, Offset: 0x56f0
// Size: 0x24c
function function_a8db30d2( scene, chopper, var_45514840 )
{
    chopper endon( #"death" );
    var_45514840 endon( #"death" );
    pos = var_45514840.var_b11e7fca;
    var_f37b2ff0 = undefined;
    
    if ( isdefined( var_45514840.var_642dba7f ) )
    {
        var_1942660b = var_45514840.var_642dba7f;
        var_f37b2ff0 = var_1942660b;
    }
    else
    {
        var_8a4b462a = [ "climbin" ];
        
        if ( var_45514840.var_b11e7fca == 9 || var_45514840.var_b11e7fca == 10 )
        {
            if ( !isdefined( var_8a4b462a ) )
            {
                var_8a4b462a = [];
            }
            else if ( !isarray( var_8a4b462a ) )
            {
                var_8a4b462a = array( var_8a4b462a );
            }
            
            var_8a4b462a[ var_8a4b462a.size ] = "climbin2";
            
            if ( !isdefined( var_8a4b462a ) )
            {
                var_8a4b462a = [];
            }
            else if ( !isarray( var_8a4b462a ) )
            {
                var_8a4b462a = array( var_8a4b462a );
            }
            
            var_8a4b462a[ var_8a4b462a.size ] = "climbin_slow";
        }
        
        var_1942660b = array::random( var_8a4b462a );
    }
    
    chopper thread scene::play( scene, var_1942660b, var_45514840 );
    var_45514840 waittill( #"hash_3c8bef57ea1e5af" );
    chopper flag::set( "flag_intro_crew_" + var_45514840.var_b11e7fca + "_boarded" );
    chopper thread scene::stop( scene, 1 );
    chopper.var_2295c5e7 = 1;
    level thread namespace_b7cfe907::function_b50b1da4( chopper, pos, var_f37b2ff0 );
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 1
// Checksum 0x434d266e, Offset: 0x5948
// Size: 0x1c8
function function_c4b6673f( a_ents )
{
    foreach ( ent in a_ents )
    {
        if ( !is_true( ent.var_2295c5e7 ) )
        {
            return;
        }
        
        ent notify( #"hash_2ec2df211f113591" );
        
        foreach ( guy in ent.var_ad845fd6 )
        {
            if ( isdefined( guy ) )
            {
                guy delete();
            }
        }
        
        ent.var_2295c5e7 = 0;
    }
    
    waittillframeend();
    
    foreach ( ent in a_ents )
    {
        if ( isdefined( ent ) )
        {
            ent delete();
        }
    }
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 1
// Checksum 0x7578e406, Offset: 0x5b18
// Size: 0x3c4
function function_ea6224e( a_ents )
{
    foreach ( index, ent in a_ents )
    {
        if ( !isdefined( ent ) )
        {
            continue;
        }
        
        ent thread function_c25e80a9();
        
        if ( index === #"hash_505d54dd2b523ca3" && !isdefined( level.var_da19489d ) )
        {
            level.var_da19489d = ent;
            level.var_da19489d setrotorspeed( 0.23 );
        }
        
        if ( index === #"hash_4441cc1284fe31e6" && !isdefined( level.var_52874eb2 ) )
        {
            level.var_52874eb2 = ent;
            level.var_52874eb2 setrotorspeed( 0.28 );
        }
        
        if ( index === #"hash_25a9a83c7c596a02" || index === #"hash_25a9a73c7c59684f" || index === #"hash_25a9a63c7c59669c" || index === #"hash_25a9a53c7c5964e9" || index === #"hash_25a9a43c7c596336" || index === #"hash_25a9a33c7c596183" )
        {
            ent thread namespace_b7cfe907::function_80a8e837();
        }
        
        if ( index === #"hash_3c898b6644de1c74" || index === #"hash_3c898e6644de218d" || index === #"hash_3c898d6644de1fda" || index === #"hash_3c89886644de175b" || index === #"hash_3c89876644de15a8" )
        {
            ent thread namespace_b7cfe907::function_9ac0bc90( [ 0, 1 ] );
            ent thread function_e0c430cb();
            continue;
        }
        
        if ( index === #"hash_25d7fb931fa86afc" || index === #"hash_5f084b741ecc845c" )
        {
            ent thread namespace_b7cfe907::function_9ac0bc90( [ 0, 1 ] );
            continue;
        }
        
        if ( index === #"hash_7f1ef323fbb683c9" || index === #"hash_3cd20118e4cb9c68" )
        {
            ent thread namespace_b7cfe907::function_9ac0bc90( [ 0, 1 ] );
            
            if ( index === #"hash_7f1ef323fbb683c9" )
            {
                level.var_5844ec1 = ent;
                continue;
            }
            
            if ( index === #"hash_3cd20118e4cb9c68" )
            {
                level.var_13d1eb5c = ent;
            }
        }
    }
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 0
// Checksum 0xd0cf8806, Offset: 0x5ee8
// Size: 0x3c
function function_e0c430cb()
{
    level flag::wait_till( "flag_intro_base_cleanup" );
    self thread namespace_b7cfe907::function_a7574a48();
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 1
// Checksum 0xc6ec834e, Offset: 0x5f30
// Size: 0xf8
function function_d6d8b189( a_ents )
{
    foreach ( index, ent in a_ents )
    {
        if ( !isdefined( ent ) )
        {
            continue;
        }
        
        if ( index === #"hash_505d54dd2b523ca3" && !isdefined( level.var_da19489d ) )
        {
            level.var_da19489d = ent;
        }
        
        if ( index === #"hash_4441cc1284fe31e6" && !isdefined( level.var_52874eb2 ) )
        {
            level.var_52874eb2 = ent;
        }
    }
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 1
// Checksum 0x1449b29d, Offset: 0x6030
// Size: 0x1d8
function function_b281d751( a_ents )
{
    foreach ( index, ent in a_ents )
    {
        if ( !isdefined( ent ) )
        {
            continue;
        }
        
        if ( index === #"hash_505d54dd2b523ca3" && !isdefined( level.var_da19489d ) )
        {
            level.var_da19489d = ent;
        }
        
        if ( index === #"hash_4441cc1284fe31e6" && !isdefined( level.var_52874eb2 ) )
        {
            level.var_52874eb2 = ent;
        }
        
        if ( ent.vehicleclass === "helicopter" )
        {
            ent setrotorspeed( 1 );
        }
        
        ent thread function_c25e80a9();
        
        if ( index === #"hash_7f1ef323fbb683c9" || index === #"hash_3cd20118e4cb9c68" )
        {
            if ( is_true( ent.var_2295c5e7 ) )
            {
                ent namespace_b7cfe907::function_5677b6eb();
                ent thread namespace_b7cfe907::function_9ac0bc90( [ 0, 1 ] );
            }
        }
    }
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 0
// Checksum 0x6fe7b810, Offset: 0x6210
// Size: 0x8c
function function_c25e80a9()
{
    self notify( "41556dfbeec1067f" );
    self endon( "41556dfbeec1067f" );
    self endon( #"death" );
    self waittill( #"hash_2efc4fe6114d5b19" );
    
    if ( is_true( self.var_2295c5e7 ) )
    {
        self namespace_b7cfe907::function_5677b6eb();
    }
    
    self setinvisibletoall();
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 0
// Checksum 0x39df2b7b, Offset: 0x62a8
// Size: 0xac
function function_d4337a8d()
{
    level.player util::function_749362d7( 0 );
    level.player setmovespeedscale( 1 );
    level.player val::reset( "armada_intro", "allow_crouch" );
    level.player val::reset( "armada_intro", "allow_prone" );
    namespace_b7cfe907::function_d777fe61( 2 );
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 2
// Checksum 0x282d1b3e, Offset: 0x6360
// Size: 0x8ec
function function_50d6beb5( *var_d3440450, var_50cc0d4f )
{
    if ( var_50cc0d4f )
    {
        level function_55d23d1e();
        level clientfield::set( "toggle_gameplay_character_visibility", 0 );
        level thread function_4fa68c0a();
        level thread function_d7d6110f();
        level flag::set( "flag_intro_hueys_take_off" );
        level flag::set( "flag_intro_cobras_take_off" );
        level flag::set( "flag_intro_trucks_go" );
        level flag::set( "flag_intro_ambient_vehicles_start" );
        level flag::set( "flag_vo_intro_start" );
        level flag::set( "flag_intro_adler_at_chopper" );
        level flag::set( "flag_intro_boarders_go" );
        level flag::set( "flag_intro_player_vm_done" );
        level scene::init( #"hash_5cceffc35d2de027" );
        level scene::init( #"hash_65c743e9446696f6" );
        level function_3ffae7ac();
        a_ents = [];
        a_ents[ #"buddy" ] = level.buddy;
        a_ents[ #"pilot" ] = level.pilot;
        a_ents[ #"copilot" ] = level.copilot;
        a_ents[ #"hash_4972abe0166bbc73" ] = level.var_7466d419;
        level scene::init( #"hash_45e2dd5c24266fcf", a_ents );
        level thread function_6b21ec6d();
        level thread function_3705ef2f();
        level.player thread function_2549ca47();
        level thread function_c9528d2b();
        level thread function_3f7b5c03();
        level thread objectives::follow( "armada_obj_intro_follow_vip", level.vip, #"hash_33eb8fa6e913e996" );
    }
    
    level thread function_e2df4629( "intro_drone_spawner_group_2", undefined, "flyin_spawn_drone", 10 );
    level flag::wait_till( "flag_intro_adler_walk_talk_pos_4" );
    level flag::set( "flag_intro_player_boarded_chopper" );
    level notify( #"snd_emitter_stop" );
    level thread namespace_82bfe441::fade( 1, "FadeSlow" );
    level thread namespace_9a981837::function_7e002ff8();
    level flag::set( "flag_vo_gearup_reach_chopper" );
    level.player setmovespeedscale( 1 );
    objectives::complete( "armada_obj_intro_follow_vip", level.vip );
    level thread namespace_9a981837::function_121aeba5();
    level thread function_24cba40();
    a_ents = [];
    a_ents[ #"vip" ] = level.vip;
    a_ents[ #"buddy" ] = level.buddy;
    a_ents[ #"pilot" ] = level.pilot;
    a_ents[ #"copilot" ] = level.copilot;
    a_ents[ #"hash_4972abe0166bbc73" ] = level.var_7466d419;
    level scene::stop( #"armada_intro" );
    level scene::play( #"hash_45e2dd5c24266fcf", "idleathuey_exit", a_ents );
    level scene::play( #"hash_45e2dd5c24266fcf", "precheck", a_ents );
    a_ents = [];
    
    if ( isdefined( level.var_52874eb2 ) )
    {
        a_ents[ #"hash_4441cc1284fe31e6" ] = level.var_52874eb2;
    }
    
    if ( isdefined( level.var_da19489d ) )
    {
        a_ents[ #"hash_505d54dd2b523ca3" ] = level.var_da19489d;
    }
    
    level namespace_b7cfe907::function_166083c9( 0, struct::get( "spawn_vip_intro", "targetname" ) );
    
    if ( isdefined( level.gunner ) )
    {
        a_ents[ #"hash_2082d5270bdcf457" ] = level.gunner;
    }
    
    level thread scene::play( #"hash_3dd341991cbe55b0", "gear_up_pt02", a_ents );
    level thread scene::play( #"hash_5cceffc35d2de027", "gear_up_pt02" );
    level thread scene::play( #"hash_65c743e9446696f6", "gear_up_pt02" );
    a_ents = [];
    a_ents[ #"vip" ] = level.vip;
    a_ents[ #"buddy" ] = level.buddy;
    a_ents[ #"pilot" ] = level.pilot;
    a_ents[ #"copilot" ] = level.copilot;
    a_ents[ #"hash_4972abe0166bbc73" ] = level.var_7466d419;
    snd::client_msg( #"hash_391dd8e0fb7ccb35" );
    level scene::play( #"hash_45e2dd5c24266fcf", "gear_up_pt02", a_ents );
    level flag::set( "flag_intro_base_cleanup" );
    namespace_b7cfe907::function_1c2abcda();
    namespace_82bfe441::fade( 0, "FadeImmediate" );
    level thread function_72017ddf();
    level scene::stop( #"hash_45e2dd5c24266fcf" );
    namespace_b7cfe907::function_3af72756( level.var_7466d419, level.buddy, "crew" );
    level function_3d2235e0();
    next_obj = "armada_mortar_orbit";
    skipto::function_4e3ab877( "armada_flyin" );
    level skipto::function_51726ac8( [ next_obj ], 0, level.player );
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 0
// Checksum 0xfe6c4256, Offset: 0x6c58
// Size: 0x5c
function function_6b21ec6d()
{
    a_ents = [];
    a_ents[ #"vip" ] = level.vip;
    level thread scene::play( #"armada_intro", "idle_at_huey", a_ents );
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 0
// Checksum 0x9f766163, Offset: 0x6cc0
// Size: 0x544
function function_3d2235e0()
{
    scene::remove_scene_func( #"armada_intro", &function_70c35833, "init" );
    scene::remove_scene_func( #"hash_23307f84986782ff", &function_616d5fff, "init" );
    scene::remove_scene_func( #"hash_799d967f164f5092", &function_67ac2154, "init" );
    scene::remove_scene_func( #"hash_18d1fb728f438332", &function_50941fc1, "init" );
    scene::remove_scene_func( #"hash_132134e8d6335e7f", &function_8479fc80, "init" );
    scene::remove_scene_func( #"hash_7faf0cdd480159ac", &namespace_b7cfe907::function_a641ac8b, "init" );
    scene::remove_scene_func( #"hash_546965da456bebee", &function_8f9d1155, "init" );
    scene::remove_scene_func( #"hash_546965da456bebee", &namespace_b7cfe907::function_a641ac8b, "init" );
    scene::remove_scene_func( #"hash_546965da456bebee", &function_c4b6673f, "done" );
    scene::remove_scene_func( #"hash_5cceffc35d2de027", &namespace_b7cfe907::function_a641ac8b, "init" );
    scene::remove_scene_func( #"hash_65c743e9446696f6", &function_ea6224e, "init" );
    scene::remove_scene_func( #"hash_65c743e9446696f6", &namespace_b7cfe907::function_a641ac8b, "init" );
    scene::remove_scene_func( #"hash_3dd341991cbe55b0", &function_ea6224e, "init" );
    scene::remove_scene_func( #"hash_3dd341991cbe55b0", &namespace_b7cfe907::function_a641ac8b, "init" );
    scene::remove_scene_func( #"hash_5cceffc35d2de027", &function_ea6224e, "gear_up_pt02" );
    scene::remove_scene_func( #"hash_65c743e9446696f6", &function_b281d751, "gear_up_pt02" );
    scene::remove_scene_func( #"hash_65c743e9446696f6", &namespace_b7cfe907::function_a641ac8b, "gear_up_pt02" );
    scene::remove_scene_func( #"hash_3dd341991cbe55b0", &function_b281d751, "gear_up_pt02" );
    scene::remove_scene_func( #"hash_3dd341991cbe55b0", &namespace_b7cfe907::function_a641ac8b, "gear_up_pt02" );
    scene::remove_scene_func( #"hash_3dd341991cbe55b0", &function_d6d8b189, "approaching_firebase" );
    scene::remove_scene_func( #"hash_3dd341991cbe55b0", &namespace_b7cfe907::function_a641ac8b, "approaching_firebase" );
    scene::remove_scene_func( #"hash_3dd341991cbe55b0", &function_d6d8b189, "approaching_firebase_pt2" );
    scene::remove_scene_func( #"hash_3dd341991cbe55b0", &namespace_b7cfe907::function_a641ac8b, "approaching_firebase_pt2" );
    scene::remove_scene_func( #"hash_45e2dd5c24266fcf", &function_d4337a8d, "approaching_firebase" );
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 0
// Checksum 0x4efe1e2c, Offset: 0x7210
// Size: 0x64
function function_24cba40()
{
    level waittill( #"hash_1a97a982320ab27a" );
    snd::client_msg( #"hash_443b18ddc7cacdc4" );
    level util::screen_fade_out( 2, "black", "flyin_fade_out" );
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 0
// Checksum 0xff8a56d8, Offset: 0x7280
// Size: 0x44
function function_d3f013d7()
{
    music::setmusicstate( "death" );
    playsoundatposition( #"hash_12f61c9ed705c06b", ( 0, 0, 0 ) );
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 0
// Checksum 0x9f509768, Offset: 0x72d0
// Size: 0x84
function function_72017ddf()
{
    level.pilot ai::gun_remove();
    level.copilot ai::gun_remove();
    vehicle::get_in( level.pilot, level.var_7466d419, "driver" );
    vehicle::get_in( level.copilot, level.var_7466d419, "passenger1" );
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 4
// Checksum 0x20140506, Offset: 0x7360
// Size: 0x360
function function_e2df4629( var_4207a482, start_flag, var_887853be, max_drones )
{
    if ( isdefined( start_flag ) )
    {
        level flag::wait_till_any( [ start_flag, "flag_intro_base_cleanup" ] );
    }
    
    if ( !level flag::get( "flag_intro_base_cleanup" ) )
    {
        spawners = getspawnerarray( var_4207a482, "targetname" );
        drones = spawner::simple_spawn( spawners );
        
        foreach ( drone in drones )
        {
            drone namespace_4e75a347::function_cab4b520( "alert" );
        }
        
        while ( true )
        {
            s_waitresult = level waittill( var_887853be, #"flag_intro_base_cleanup" );
            
            if ( s_waitresult._notify == "flag_intro_base_cleanup" )
            {
                break;
            }
            
            level flag::wait_till_timeout( randomfloatrange( 0.25, 0.5 ), "flag_intro_base_cleanup" );
            
            if ( level flag::get( "flag_intro_base_cleanup" ) )
            {
                break;
            }
            
            arrayremovevalue( drones, undefined );
            
            if ( drones.size <= max_drones )
            {
                var_8d5facc = array::random( spawners );
                drone = spawner::simple_spawn_single( var_8d5facc );
                drone namespace_4e75a347::function_cab4b520( "alert" );
                
                if ( !isdefined( drones ) )
                {
                    drones = [];
                }
                else if ( !isarray( drones ) )
                {
                    drones = array( drones );
                }
                
                drones[ drones.size ] = drone;
                waittillframeend();
            }
        }
        
        foreach ( drone in drones )
        {
            if ( isdefined( drone ) )
            {
                drone delete();
            }
        }
    }
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 1
// Checksum 0xb8f33804, Offset: 0x76c8
// Size: 0x2b8
function function_3705ef2f( wait_flag )
{
    if ( isdefined( wait_flag ) )
    {
        level flag::wait_till_any( [ wait_flag, "flag_intro_base_cleanup" ] );
    }
    
    if ( !level flag::get( "flag_intro_base_cleanup" ) )
    {
        var_576fb569 = getvehiclenodearray( "intro_ambient_vehicle_outer_start_node", "targetname" );
        var_2c4dfb60 = array( "vehicle_t9_mil_us_truck_m35_canvas_cp", "vehicle_t9_mil_us_truck_m35_tanker_cp", "vehicle_t9_mil_us_truck_m35_cargo_cp" );
        str_notify = "spawn_new_outer_truck";
        var_efbe0740 = vehicle::simple_spawn( "flyin_leave_trucks" );
        
        foreach ( var_ff72be84 in var_efbe0740 )
        {
            var_ff72be84 setcandamage( 0 );
            var_ff72be84 thread namespace_b7cfe907::delete_on_flag( "flag_intro_base_cleanup" );
        }
        
        level flag::wait_till_any( [ "flag_intro_trucks_start", "flag_intro_base_cleanup" ] );
        
        if ( !level flag::get( "flag_intro_base_cleanup" ) )
        {
            level thread function_7fabe565( str_notify, var_576fb569, var_2c4dfb60, 0 );
            
            foreach ( var_ff72be84 in var_efbe0740 )
            {
                if ( isdefined( var_ff72be84 ) )
                {
                    var_ff72be84 thread function_b4dd21d4( str_notify );
                    var_ff72be84 thread vehicle::go_path();
                }
            }
        }
    }
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 2
// Checksum 0xff546193, Offset: 0x7988
// Size: 0x28c
function function_c81e0f3f( *var_d3440450, *var_50cc0d4f )
{
    var_a129a5ee = getent( "trigger_oob_firebase_to_branch", "targetname" );
    thread function_d97a8605();
    thread function_b53b7c30( 34 );
    a_ents = [];
    
    if ( isdefined( level.var_52874eb2 ) )
    {
        a_ents[ #"hash_4441cc1284fe31e6" ] = level.var_52874eb2;
    }
    
    if ( isdefined( level.var_da19489d ) )
    {
        a_ents[ #"hash_505d54dd2b523ca3" ] = level.var_da19489d;
    }
    
    level thread scene::play( #"hash_3dd341991cbe55b0", "approaching_firebase", a_ents );
    level thread scene::play( #"hash_48cd9e602ec868e7" );
    var_a129a5ee triggerenable( 0 );
    level flag::set( "flag_intro_base_cleanup" );
    a_ents = [];
    a_ents[ #"vip" ] = level.vip;
    a_ents[ #"buddy" ] = level.buddy;
    a_ents[ #"pilot" ] = level.pilot;
    a_ents[ #"copilot" ] = level.copilot;
    a_ents[ #"hash_4972abe0166bbc73" ] = level.var_7466d419;
    level.player util::delay( 5, undefined, &camerasetlookat, level.var_52874eb2 );
    level scene::play( #"hash_45e2dd5c24266fcf", "approaching_firebase", a_ents );
    namespace_b7cfe907::function_1c2abcda();
    skipto::function_4e3ab877( "armada_flyin_beach" );
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 1
// Checksum 0x15605387, Offset: 0x7c20
// Size: 0x6c
function function_b53b7c30( wait_time )
{
    setdvar( #"cg_viewvehicleinfluencegunner", ( 1, 1, 1 ) );
    wait wait_time;
    setdvar( #"cg_viewvehicleinfluencegunner", ( 0.1, 1, 0 ) );
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 0
// Checksum 0xa77f391b, Offset: 0x7c98
// Size: 0x13c
function function_d97a8605()
{
    level flag::wait_till( "flag_firebase_base_intro_exploders" );
    exploder::exploder( "firebase_intro_sequence_master" );
    
    /#
        iprintln( "<dev string:x38>" );
    #/
    
    exploder::exploder( "firebase_front_kill" );
    
    /#
        iprintln( "<dev string:x5f>" );
    #/
    
    level flag::wait_till( "flag_firebase_base_enemy_trucks_start" );
    vehicle::add_spawn_function_group( "firebase_arrival_spawner_enemey_road_truck", "targetname", &function_7e705caf );
    vehicle::simple_spawn_and_drive( "firebase_arrival_spawner_enemey_road_truck" );
    thread function_49aeb63a();
    level flag::wait_till( "flag_firebase_enemy_cliff_start" );
    thread function_20c273a1();
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 2
// Checksum 0xc7c052df, Offset: 0x7de0
// Size: 0x264
function function_67f53057( *var_d3440450, *var_50cc0d4f )
{
    level flag::wait_till( "flag_armada_player_chopper_spawned" );
    callback::on_player_damage( &namespace_b7cfe907::function_38a76cc5 );
    var_802ba9ea = struct::get( "obj_firebase", "targetname" );
    level thread objectives::goto( "armada_obj_intro_defend_firebase", var_802ba9ea, #"hash_19a45c5bffdb799b" );
    level objectives::function_67f87f80( "armada_obj_intro_defend_firebase", undefined, #"hash_6e75fb2a7203f21f" );
    thread function_ca46ecf9();
    a_ents = [];
    
    if ( isdefined( level.var_52874eb2 ) )
    {
        a_ents[ #"hash_4441cc1284fe31e6" ] = level.var_52874eb2;
    }
    
    if ( isdefined( level.var_da19489d ) )
    {
        a_ents[ #"hash_505d54dd2b523ca3" ] = level.var_da19489d;
    }
    
    level thread scene::play( #"hash_3dd341991cbe55b0", "approaching_firebase_pt2" );
    a_ents = [];
    a_ents[ #"vip" ] = level.vip;
    a_ents[ #"buddy" ] = level.buddy;
    a_ents[ #"hash_4972abe0166bbc73" ] = level.var_7466d419;
    level scene::play( #"hash_45e2dd5c24266fcf", "approaching_firebase_pt2", a_ents );
    namespace_b7cfe907::function_1c2abcda();
    level notify( #"hash_5785c9d099726172" );
    objectives::complete( "armada_obj_intro_defend_firebase", var_802ba9ea );
    skipto::function_4e3ab877( "armada_flyin_firebase" );
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 0
// Checksum 0x2af25fc0, Offset: 0x8050
// Size: 0x244
function function_ca46ecf9()
{
    level flag::wait_till( "flag_firebase_ally_cobra_entrance" );
    function_ddf0c097();
    level flag::wait_till( "flag_firebase_ally_littlebird_entrance" );
    thread function_f56d55e3();
    wait 1.5;
    level spawner::simple_spawn( "firebase_arrival_spawner_enemy_cliff_solider", &function_c66e98bf );
    level flag::wait_till( "flag_firebase_ally_bunker_start" );
    level flag::wait_till( "flag_firebase_ally_heli_entrance" );
    level thread function_188f0d9e();
    wait 2;
    thread function_1e3fa2b3();
    level flag::wait_till( "flag_firebase_enemy_cliff_to_trench_spawn" );
    level spawner::simple_spawn( "firebase_arrival_spawner_enemy_cliff_trench_transition", &function_8bad9c5d );
    level flag::wait_till( "flag_firebase_enemy_cliff_despawn" );
    wait 1.5;
    level flag::wait_till( "flag_firebase_enemy_trench" );
    level spawner::simple_spawn( "firebase_arrival_spawner_enemy_trench_solider", &function_267a1d12 );
    level spawner::simple_spawn( "firebase_arrival_spawner_ally_trench_solider", &function_e2697bde );
    thread function_fe25ebb();
    level flag::wait_till( "flag_firebase_trench_littlebird_spawn" );
    function_82bec60b();
    level flag::wait_till( "flag_firebase_approach_complete" );
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 0
// Checksum 0xe6b87e5e, Offset: 0x82a0
// Size: 0xa6
function function_535f1a04()
{
    level endon( #"hash_5785c9d099726172" );
    level.player endon( #"death" );
    level.var_7466d419 endon( #"death" );
    
    while ( true )
    {
        iprintlnbold( "Player health: " + level.player.health + " Chopper Health: " + level.var_7466d419.health );
        wait 1;
    }
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 0
// Checksum 0x39a476a4, Offset: 0x8350
// Size: 0x176
function function_49aeb63a()
{
    var_3744c167 = getentarray( "firebase_arrival_spawner_enemey_road_truck", "targetname" );
    level.var_4d1fc307 = [];
    
    foreach ( truck in var_3744c167 )
    {
        if ( isdefined( truck.script_noteworthy ) )
        {
            switch ( truck.script_noteworthy )
            {
                case #"hash_5f1c4271b44a354a":
                    thread function_5a9f70a0( "firebase_arrival_spawner_enemy_road_solider_truck_end_01", "firebase_arrival_road_enemy_truck_01_end" );
                    break;
                case #"hash_5f1c4171b44a3397":
                    thread function_5a9f70a0( "firebase_arrival_spawner_enemy_road_solider_truck_end_02", "firebase_arrival_road_enemy_truck_02_end" );
                    break;
                case #"hash_5f1c3f71b44a3031":
                    thread function_5a9f70a0( "firebase_arrival_spawner_enemy_road_solider_truck_end_04", "firebase_arrival_road_enemy_truck_04_end" );
                    break;
            }
        }
    }
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 2
// Checksum 0xbc3da05b, Offset: 0x84d0
// Size: 0x128
function function_5a9f70a0( spawner_name, script_notify )
{
    self waittill( script_notify );
    var_271de830 = level spawner::simple_spawn( spawner_name, &function_8c53017d );
    level flag::wait_till( "flag_firebase_road_enemy_despawn" );
    function_1eaaceab( var_271de830 );
    arrayremovevalue( var_271de830, undefined );
    
    foreach ( var_b66f958d in var_271de830 )
    {
        var_b66f958d delete();
    }
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 0
// Checksum 0xb051b924, Offset: 0x8600
// Size: 0xa4
function function_7e705caf()
{
    self endon( #"death" );
    waitframe( 1 );
    self.script_startinghealth = 8500;
    self.health = 8500;
    self.script_crashtypeoverride = "ground_vehicle_on_spline";
    waitframe( 1 );
    self.do_scripted_crash = 1;
    self thread function_abaeb1f1();
    level flag::wait_till( "flag_firebase_road_enemy_despawn" );
    self delete();
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 0
// Checksum 0x71d699d0, Offset: 0x86b0
// Size: 0x134
function function_abaeb1f1()
{
    self waittill( #"death" );
    weapon = getweapon( #"hash_513c26c6a751d20e" );
    min_distance = 62500;
    
    foreach ( var_956bb363 in level.var_4d1fc307 )
    {
        if ( isdefined( var_956bb363 ) )
        {
            distance = distancesquared( self.origin, var_956bb363.origin );
            
            if ( distance < min_distance )
            {
                var_956bb363 kill();
            }
        }
    }
    
    function_1eaaceab( level.var_4d1fc307 );
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 0
// Checksum 0x25ca9b3c, Offset: 0x87f0
// Size: 0x84
function function_8c53017d()
{
    level.var_4d1fc307[ level.var_4d1fc307.size ] = self;
    self.script_accuracy = 25;
    self setentitytarget( level.player, 1 );
    self.grenadeammo = 0;
    self endon( #"death" );
    self thread namespace_b7cfe907::delete_on_flag( "flag_firebase_road_enemy_despawn" );
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 0
// Checksum 0xfc3e1119, Offset: 0x8880
// Size: 0xc8
function function_ddf0c097()
{
    cobras = level vehicle::simple_spawn_and_drive( "firebase_arrival_spawner_ally_road_cobra" );
    
    foreach ( gunship in cobras )
    {
        gunship thread namespace_b7cfe907::function_53c06d6e();
        gunship function_60d50ea4();
    }
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 0
// Checksum 0x1ec0faeb, Offset: 0x8950
// Size: 0xe4
function function_c66e98bf()
{
    self.grenadeammo = 0;
    self.script_accuracy = 1000;
    self.ignoreall = 1;
    self endon( #"death" );
    self thread namespace_b7cfe907::delete_on_flag( "flag_firebase_enemy_cliff_despawn" );
    
    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "chopper_attacker" )
    {
        trigger = getent( self.var_23da1376, "targetname" );
        trigger waittill( #"trigger" );
        self.ignoreall = 0;
        self setentitytarget( level.player, 1 );
    }
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 0
// Checksum 0xe1bd4efe, Offset: 0x8a40
// Size: 0x2ac
function function_20c273a1()
{
    level endon( #"hash_5785c9d099726172" );
    level.var_bc8550ea = [];
    
    while ( !level flag::get( "flag_firebase_ally_bunker_start" ) )
    {
        arrayremovevalue( level.var_bc8550ea, undefined );
        var_d4b5c88e = getentarray( "firebase_arrival_spawner_enemy_cliff_solider_drone_group_1", "targetname" );
        var_715501ce = getentarray( "firebase_arrival_spawner_enemy_cliff_solider_drone_group_2", "targetname" );
        var_61ac62b5 = getentarray( "firebase_arrival_spawner_enemy_cliff_solider_drone_group_3", "targetname" );
        var_9df3db0b = getentarray( "firebase_arrival_spawner_enemy_cliff_solider_drone_group_4", "targetname" );
        var_8fac3e7c = getentarray( "firebase_arrival_spawner_enemy_cliff_solider_drone_group_5", "targetname" );
        spawn_delay = 2;
        group = level spawner::simple_spawn( var_d4b5c88e, &function_fccd2779 );
        level.var_3d50c11b[ level.var_bc8550ea.size ] = group;
        wait spawn_delay;
        group = level spawner::simple_spawn( var_715501ce, &function_fccd2779 );
        level.var_3d50c11b[ level.var_bc8550ea.size ] = group;
        wait spawn_delay;
        group = level spawner::simple_spawn( var_61ac62b5, &function_fccd2779 );
        level.var_3d50c11b[ level.var_bc8550ea.size ] = group;
        wait spawn_delay;
        group = level spawner::simple_spawn( var_9df3db0b, &function_fccd2779 );
        level.var_3d50c11b[ level.var_bc8550ea.size ] = group;
        wait spawn_delay;
        group = level spawner::simple_spawn( var_8fac3e7c, &function_fccd2779 );
        level.var_3d50c11b[ level.var_bc8550ea.size ] = group;
    }
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 0
// Checksum 0xd33ffc5f, Offset: 0x8cf8
// Size: 0xcc
function function_fccd2779()
{
    level.var_bc8550ea[ level.var_bc8550ea.size ] = self;
    var_8b0fd67e = randomfloatrange( 0.75, 1 );
    self.drone.moveplaybackrate = var_8b0fd67e;
    level flag::wait_till( "flag_firebase_enemy_cliff_despawn" );
    
    if ( isdefined( self ) && self.health > 0 )
    {
        self kill();
    }
    
    wait 1.4;
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 0
// Checksum 0x36671550, Offset: 0x8dd0
// Size: 0x1a6
function function_f56d55e3()
{
    spawner = level vehicle::simple_spawn_and_drive( "firebase_arrival_spawner_cliff_friendly_littlebird" );
    var_dd4aa81d = getent( "lb_01_target_01", "targetname" );
    var_af91cca8 = getent( "lb_02_target_01", "targetname" );
    
    foreach ( littlebirds in spawner )
    {
        littlebirds thread namespace_b7cfe907::function_53c06d6e();
        littlebirds function_60d50ea4();
        
        if ( isdefined( littlebirds.script_noteworthy ) )
        {
            switch ( littlebirds.script_noteworthy )
            {
                case #"hash_1c366d4d206df5a5":
                    littlebirds thread function_903f2e76( var_dd4aa81d, 2.5 );
                    break;
                case #"hash_1c366a4d206df08c":
                    littlebirds thread function_903f2e76( var_af91cca8, 2.5 );
                    break;
            }
        }
    }
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 2
// Checksum 0xc6560976, Offset: 0x8f80
// Size: 0xdc
function function_903f2e76( var_6003262d, fire_time )
{
    self endon( #"death" );
    self waittill( #"hash_688f3a473e5d0a38" );
    self turretsettarget( 1, var_6003262d );
    self turretsettarget( 2, var_6003262d );
    self thread vehicle_ai::fire_for_time( fire_time, 1, var_6003262d );
    self thread vehicle_ai::fire_for_time( fire_time, 2, var_6003262d );
    self turretcleartarget( 1 );
    self turretcleartarget( 2 );
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 0
// Checksum 0x7df27de6, Offset: 0x9068
// Size: 0x150
function function_fe25ebb()
{
    level endon( #"hash_5785c9d099726172" );
    level.var_4a9b655c = [];
    var_758c1be3 = 14;
    var_3c42c434 = randomfloatrange( 0.75, 1.5 );
    spawner::add_spawn_function_group( "firebase_arrival_spawner_enemy_trench_solider_drone", "targetname", &function_891263de );
    var_af1f5f1 = getspawnerarray( "firebase_arrival_spawner_enemy_trench_solider_drone", "targetname" );
    
    while ( !flag::get( "flag_firebase_trench_littlebird_spawn" ) )
    {
        function_1eaaceab( level.var_4a9b655c );
        
        if ( level.var_4a9b655c.size < var_758c1be3 )
        {
            var_e47bd9e8 = array::random( var_af1f5f1 );
            spawned_enemy = spawner::simple_spawn( var_e47bd9e8 );
        }
        
        wait var_3c42c434;
    }
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 0
// Checksum 0xa9239bf6, Offset: 0x91c0
// Size: 0x5c
function function_891263de()
{
    level.var_4a9b655c[ level.var_4a9b655c.size ] = self;
    self endon( #"death" );
    level waittill( #"hash_70ebdd9b5272c930" );
    wait 1;
    self delete();
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 0
// Checksum 0x424f7e58, Offset: 0x9228
// Size: 0x1b4
function function_267a1d12()
{
    self.grenadeammo = 0;
    self endon( #"death" );
    
    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "trench_chopper_attacker" )
    {
        self.script_accuracy = 125;
        trigger = getent( self.var_ff2b3d8a, "targetname" );
        trigger waittill( #"trigger" );
        self.ignoreall = 0;
        self setentitytarget( level.player, 1 );
    }
    else if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "trench_entrance" )
    {
        self setentitytarget( level.player, 1 );
        trigger = getent( self.var_ff2b3d8a, "targetname" );
        trigger waittill( #"trigger" );
        info_vol = getent( "info_vol_trench_enemy_position_02", "targetname" );
        wait 5.5;
        self setgoal( info_vol );
    }
    
    level waittill( #"gunship_02_road_rockets_complete" );
    self kill();
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 0
// Checksum 0x2f7a6b0b, Offset: 0x93e8
// Size: 0xc4
function function_8bad9c5d()
{
    self.grenadeammo = 0;
    self endon( #"death" );
    
    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "trench_runner" )
    {
        self.ignoreall = 1;
        self waittill( #"goal" );
        self.ignoreall = 0;
        self setentitytarget( level.player, 1 );
    }
    
    level waittill( #"gunship_02_road_rockets_complete" );
    wait 1;
    self kill();
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 0
// Checksum 0xce0913f7, Offset: 0x94b8
// Size: 0x94
function function_e2697bde()
{
    self.grenadeammo = 0;
    self.script_accuracy = 0.15;
    self util::magic_bullet_shield();
    self endon( #"death" );
    level flag::wait_till( "flag_firebase_approach_complete" );
    self util::stop_magic_bullet_shield();
    self delete();
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 0
// Checksum 0x40a1f8e1, Offset: 0x9558
// Size: 0xc0
function function_188f0d9e()
{
    var_b8a343ea = vehicle::simple_spawn_and_drive( "firebase_arrival_spawner_ally_trench_helicopter" );
    
    foreach ( chopper in var_b8a343ea )
    {
        chopper namespace_b7cfe907::function_53c06d6e();
        chopper function_60d50ea4();
    }
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 0
// Checksum 0xd1930579, Offset: 0x9620
// Size: 0x1fe
function function_82bec60b()
{
    spawner = level vehicle::simple_spawn_and_drive( "firebase_arrival_spawner_ally_trench_cobra" );
    t_gs01_t01 = getent( "t_gs01_t01", "targetname" );
    t_gs01_t02 = getent( "t_gs01_t02", "targetname" );
    t_gs02_t01 = getent( "t_gs02_t01", "targetname" );
    t_gs02_t02 = getent( "t_gs02_t02", "targetname" );
    
    foreach ( gunship in spawner )
    {
        gunship thread namespace_b7cfe907::function_53c06d6e();
        gunship function_60d50ea4();
        
        if ( isdefined( gunship.script_noteworthy ) )
        {
            switch ( gunship.script_noteworthy )
            {
                case #"hash_4b32ffd1558c840a":
                    gunship thread function_c4d91c06( t_gs02_t01, t_gs02_t02, t_gs01_t01, t_gs01_t02 );
                    break;
                case #"hash_4b32fed1558c8257":
                    gunship thread function_c4d91c06( t_gs02_t01, t_gs02_t02, t_gs01_t01, undefined, "gunship_02_road_rockets_complete" );
                    break;
            }
        }
    }
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 5
// Checksum 0x72ee4ca0, Offset: 0x9828
// Size: 0x16e
function function_c4d91c06( var_8bb4b3f5, var_81769f79, var_fff01c66, var_2e2ef8e3, level_notify )
{
    self endon( #"death" );
    
    if ( isdefined( var_8bb4b3f5 ) )
    {
        self waittill( #"hash_5eb7693ca5c5d7c" );
        self thread namespace_b7cfe907::function_f48ca525( var_8bb4b3f5, "tag_flash3" );
    }
    
    if ( isdefined( var_81769f79 ) )
    {
        self waittill( #"hash_5eb7993ca5c6295" );
        self thread namespace_b7cfe907::function_f48ca525( var_81769f79, "tag_flash4" );
    }
    
    if ( isdefined( var_fff01c66 ) )
    {
        self waittill( #"hash_5eb7893ca5c60e2" );
        self thread namespace_b7cfe907::function_f48ca525( var_fff01c66, "tag_flash3" );
    }
    
    if ( isdefined( var_2e2ef8e3 ) )
    {
        self waittill( #"hash_5eb7393ca5c5863" );
        self thread namespace_b7cfe907::function_f48ca525( var_2e2ef8e3, "tag_flash4" );
    }
    
    self thread namespace_b7cfe907::function_f48ca525( var_2e2ef8e3, "tag_flash4" );
    
    if ( isdefined( level_notify ) )
    {
        level notify( level_notify );
    }
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 0
// Checksum 0x1025a846, Offset: 0x99a0
// Size: 0xe4
function function_1e3fa2b3()
{
    var_b850426e = randomintrange( 8, 10 );
    exploder::exploder( "firebase_arrival_purple_smoke_01" );
    wait 7;
    exploder::exploder( "firebase_arrival_purple_smoke_02" );
    wait 4;
    wait 14;
    exploder::exploder_stop( "firebase_arrival_purple_smoke_01" );
    
    /#
        iprintln( "<dev string:x7b>" );
    #/
    
    wait 7;
    exploder::exploder_stop( "firebase_arrival_purple_smoke_02" );
    
    /#
        iprintln( "<dev string:xa6>" );
    #/
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 2
// Checksum 0x4e5fc44f, Offset: 0x9a90
// Size: 0x20c
function function_90b53888( *var_d3440450, *var_50cc0d4f )
{
    a_ents = [];
    
    if ( isdefined( level.var_52874eb2 ) )
    {
        a_ents[ #"hash_4441cc1284fe31e6" ] = level.var_52874eb2;
    }
    
    if ( isdefined( level.var_da19489d ) )
    {
        a_ents[ #"hash_505d54dd2b523ca3" ] = level.var_da19489d;
    }
    
    level thread scene::play( #"hash_685d9366db60f4e6", a_ents );
    a_ents = [];
    a_ents[ #"buddy" ] = level.buddy;
    a_ents[ #"hash_4972abe0166bbc73" ] = level.var_7466d419;
    level scene::play( #"hash_2b12d20bc56156e9", a_ents );
    level scene::play( #"hash_7eda5092580dbf92", a_ents );
    org = struct::get( "heli_spawn_fly_to_branch", "script_noteworthy" );
    level.var_7466d419.origin = org.origin;
    level.var_7466d419.angles = org.angles;
    
    if ( isdefined( level.weaponbasemeleeheld ) && level.player hasweapon( level.weaponbasemeleeheld ) )
    {
        level.player takeweapon( level.weaponbasemeleeheld );
    }
    
    flag::set( "flag_firebase_checkin_complete" );
    skipto::function_4e3ab877( "armada_firebase_checkin" );
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 1
// Checksum 0x9e5621c4, Offset: 0x9ca8
// Size: 0x4c
function function_4c73716e( *a_ents )
{
    level.pilot ai::gun_remove();
    level.copilot ai::gun_remove();
    namespace_b7cfe907::function_1c2abcda();
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 2
// Checksum 0x29be188f, Offset: 0x9d00
// Size: 0x49c
function function_55a3220( var_d3440450, var_50cc0d4f )
{
    org = struct::get( "heli_spawn_fly_to_branch", "script_noteworthy" );
    level.var_7466d419.origin = org.origin;
    level.var_7466d419.angles = org.angles;
    level.player setplayerangles( org.angles );
    callback::remove_on_player_damage( &namespace_b7cfe907::function_38a76cc5 );
    namespace_b7cfe907::function_d777fe61( 0 );
    var_a129a5ee = getent( "trigger_oob_firebase_to_branch", "targetname" );
    var_a129a5ee triggerenable( 1 );
    
    if ( !is_true( var_50cc0d4f ) )
    {
        if ( !isdefined( level.buddy ) )
        {
            thread namespace_b7cfe907::function_ed68628c( 1 );
        }
        
        if ( !isdefined( level.buddy.var_ec30f5da ) )
        {
            vehicle::get_in( level.buddy, level.var_7466d419, "crew" );
        }
        
        if ( is_true( level.buddy.gun_removed ) )
        {
            level.buddy ai::gun_recall();
        }
    }
    
    level thread function_548f49fd();
    level flag::clear( "flag_player_flying_ambience_kill" );
    level flag::set( "flag_player_flying_ambience_start" );
    level flag::clear( "flag_player_chopper_screenshake_active" );
    var_368e1037 = struct::get( "obj_fly_to_branch_checkpoint_01", "targetname" );
    var_9a89095b = struct::get( "obj_fly_to_branch_checkpoint_02", "targetname" );
    var_432ab03d = struct::get( "obj_fly_to_branch_reach", "targetname" );
    level objectives::goto( "armada_obj_fly_to_mortar", var_368e1037.origin, #"hash_4a4781bc1af428d0", 1 );
    level objectives::function_67f87f80( "armada_obj_fly_to_mortar", undefined, #"hash_106c2eff717a77c8" );
    level flag::wait_till( "flag_fly_to_branch_objective_01" );
    level thread objectives::update_position( "armada_obj_fly_to_mortar", var_9a89095b.origin );
    level flag::wait_till( "flag_fly_to_branch_objective_02" );
    level thread objectives::update_position( "armada_obj_fly_to_mortar", var_432ab03d.origin );
    level flag::wait_till( "flag_fly_to_branch_trigger_ally_heli" );
    level thread objectives::complete( "armada_obj_fly_to_mortar" );
    iprintlnbold( "Adler crash scene" );
    level flag::set( "flag_vo_flying_ally_down_react" );
    flag::set( "flag_vo_flying_ally_down_choice" );
    level skipto::function_4e3ab877( var_d3440450, 0 );
    level skipto::function_51726ac8( [ "armada_fly_to_branch_reached" ], 0, level.player );
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 0
// Checksum 0x90b10199, Offset: 0xa1a8
// Size: 0x364
function function_548f49fd()
{
    level.player endon( #"disconnect", #"death" );
    level.var_7466d419 endon( #"death", #"crashing" );
    level flag::init( "flag_fly_to_branch_player_moved_left_stick" );
    level flag::init( "flag_fly_to_branch_player_moved_right_stick" );
    level flag::init( "flag_fly_to_branch_player_moved_both_sticks" );
    level flag::init( "flag_fly_to_branch_player_used_height" );
    level thread function_e0598f16( "left_stick", "flag_fly_to_branch_player_moved_left_stick", "player_moved" );
    level thread function_e0598f16( "right_stick", "flag_fly_to_branch_player_moved_right_stick", "player_turned" );
    level thread function_e0598f16( "height", "flag_fly_to_branch_player_used_height", "player_used_height" );
    wait 1;
    
    if ( level flag::get( "flag_fly_to_branch_trigger_ally_heli" ) )
    {
        return;
    }
    
    if ( !level flag::get( "flag_fly_to_branch_player_moved_left_stick" ) || !level flag::get( "flag_fly_to_branch_player_moved_right_stick" ) )
    {
        hint_tutorial::function_4c2d4fc4( #"hash_a7ac2ae0aa75b62", #"hash_746bba5dae7f3eaf" );
        level thread function_8d3184fa( [ "flag_fly_to_branch_player_moved_left_stick", "flag_fly_to_branch_player_moved_right_stick" ], "flag_fly_to_branch_player_moved_both_sticks" );
        level flag::wait_till_any_timeout( 15, [ "flag_fly_to_branch_player_moved_both_sticks", "flag_fly_to_branch_trigger_ally_heli" ] );
        hint_tutorial::function_9f427d88( 5 );
    }
    
    wait 2;
    
    if ( !level flag::get( "flag_fly_to_branch_player_used_height" ) && !level flag::get( "flag_fly_to_branch_trigger_ally_heli" ) )
    {
        hint_tutorial::function_4c2d4fc4( #"hash_4d1a07a1e7f2e8f8", #"hash_746bba5dae7f3eaf" );
        level flag::wait_till_any_timeout( 15, [ "flag_fly_to_branch_player_used_height", "flag_fly_to_branch_trigger_ally_heli" ] );
        hint_tutorial::function_9f427d88( 2 );
    }
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 2
// Checksum 0x72458d0a, Offset: 0xa518
// Size: 0x44
function function_8d3184fa( var_3cc9b800, var_335a8dcc )
{
    level flag::wait_till_all( var_3cc9b800 );
    level flag::set( var_335a8dcc );
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 3
// Checksum 0x92032d1c, Offset: 0xa568
// Size: 0x1cc
function function_e0598f16( input, var_aff9d4d0, var_8c5bec46 )
{
    level.player endon( #"disconnect", #"death" );
    level.var_7466d419 endon( #"death", #"crashing" );
    
    if ( input == "left_stick" || input == "right_stick" )
    {
        if ( input == "left_stick" )
        {
            var_7d0e0dac = &orbit::function_b7ead280;
        }
        else if ( input == "right_stick" )
        {
            var_7d0e0dac = &orbit::function_5cf12924;
        }
        
        for ( var_2e35e6c1 = [[ var_7d0e0dac ]](); var_2e35e6c1[ 0 ] == 0 && var_2e35e6c1[ 1 ] == 0 ; var_2e35e6c1 = [[ var_7d0e0dac ]]() )
        {
            wait 0.05;
        }
    }
    else if ( input == "height" )
    {
        while ( !level.player attackbuttonpressed() && !level.player adsbuttonpressed() )
        {
            wait 0.05;
        }
    }
    
    level flag::set( var_aff9d4d0 );
    level.player notify( var_8c5bec46 );
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 2
// Checksum 0x2af6eaff, Offset: 0xa740
// Size: 0x28c
function function_216af582( *var_d3440450, *var_50cc0d4f )
{
    level flag::wait_till( "flag_armada_player_chopper_spawned" );
    namespace_b7cfe907::function_d777fe61( 0 );
    var_8bd1af86 = struct::get( "obj_branch_reached_mortar_choice", "targetname" );
    var_d62ba599 = struct::get( "obj_branch_reached_mortar_entrance", "targetname" );
    level objectives::goto( "armada_obj_fly_to_mortar", var_8bd1af86.origin, #"hash_4a4781bc1af428d0", 1 );
    level objectives::function_67f87f80( "armada_obj_fly_to_mortar", undefined, #"hash_106c2eff717a77c8" );
    level flag::wait_till( "flag_fly_to_branch_reached_mortar_choice" );
    level objectives::goto( "armada_obj_fly_to_mortar", var_d62ba599.origin, #"hash_4a4781bc1af428d0", 1 );
    next_obj = undefined;
    level flag::wait_till( "flag_mortar_start" );
    level flag::set( "flag_orbit_mortar_started" );
    level flag::set( "flag_vo_mortar_orbit_start" );
    next_obj = "armada_mortar_orbit";
    level thread armada_mortar::function_110866d( 1 );
    armada_mortar::function_bea0c0d7( 0 );
    level thread objectives::complete( "armada_obj_fly_to_mortar" );
    level skipto::function_4e3ab877( "armada_fly_to_branch_reached", 0 );
    level skipto::function_51726ac8( [ next_obj ], 0, level.player );
    snd::stop( level.var_4dcf3b93, 2 );
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 2
// Checksum 0xae6d127f, Offset: 0xa9d8
// Size: 0xdc
function function_6eb72af2( var_d3440450, *var_50cc0d4f )
{
    namespace_b7cfe907::function_d777fe61( 0 );
    level thread function_d428a291();
    level thread function_27fafffc();
    level flag::clear( "flag_player_flying_ambience_start" );
    level flag::set( "flag_player_flying_ambience_kill" );
    namespace_b7cfe907::function_9c308f91();
    trigger::wait_till( "trig_reached_firebase" );
    skipto::function_4e3ab877( var_50cc0d4f );
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 0
// Checksum 0x2aded38b, Offset: 0xaac0
// Size: 0x334
function function_d428a291()
{
    var_802ba9ea = struct::get( "obj_fly_3_return_01_m", "targetname" );
    level thread objectives::goto( "armada_obj_fly_to_firebase", var_802ba9ea, #"hash_5483ae2de22e69c8" );
    level flag::wait_till( "flag_obj_fly_3_return_01_m" );
    objectives::complete( "armada_obj_fly_to_firebase", var_802ba9ea );
    var_802ba9ea = struct::get( "obj_fly_3_return_02", "targetname" );
    level thread objectives::goto( "armada_obj_fly_to_firebase", var_802ba9ea, #"hash_5483ae2de22e69c8" );
    level flag::wait_till( "flag_obj_fly_3_return_02" );
    objectives::complete( "armada_obj_fly_to_firebase", var_802ba9ea );
    var_802ba9ea = struct::get( "obj_fly_3_return_03", "targetname" );
    level thread objectives::goto( "armada_obj_fly_to_firebase", var_802ba9ea, #"hash_5483ae2de22e69c8" );
    level flag::wait_till( "flag_obj_fly_3_return_03" );
    objectives::complete( "armada_obj_fly_to_firebase", var_802ba9ea );
    var_802ba9ea = struct::get( "obj_fly_3_return_04", "targetname" );
    level thread objectives::goto( "armada_obj_fly_to_firebase", var_802ba9ea, #"hash_5483ae2de22e69c8" );
    level flag::wait_till( "flag_obj_fly_3_return_04" );
    objectives::complete( "armada_obj_fly_to_firebase", var_802ba9ea );
    var_802ba9ea = struct::get( "obj_fly_3_return_05", "targetname" );
    level thread objectives::goto( "armada_obj_fly_to_firebase", var_802ba9ea, #"hash_5483ae2de22e69c8" );
    level flag::wait_till( "flag_obj_fly_3_return_05" );
    objectives::complete( "armada_obj_fly_to_firebase", var_802ba9ea );
    var_802ba9ea = struct::get( "obj_firebase", "targetname" );
    level thread objectives::goto( "armada_obj_fly_to_firebase", var_802ba9ea, #"hash_5483ae2de22e69c8" );
    trigger::wait_till( "trig_reached_firebase" );
    objectives::complete( "armada_obj_fly_to_firebase", var_802ba9ea );
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 0
// Checksum 0x80f724d1, Offset: 0xae00
// Size: 0x4
function function_27fafffc()
{
    
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 2
// Checksum 0x87a3982f, Offset: 0xae10
// Size: 0x7c
function function_78be51a6( var_d3440450, *var_50cc0d4f )
{
    level thread function_9137167f();
    level thread function_72cfe867();
    level flag::wait_till( "flag_obj_firebase_defend_complete" );
    wait 5;
    skipto::function_4e3ab877( var_50cc0d4f );
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 0
// Checksum 0x73a148e2, Offset: 0xae98
// Size: 0x2dc
function function_9137167f()
{
    /#
        iprintlnbold( "<dev string:xd1>" );
    #/
    
    var_db1c0995 = struct::get( "firebase_defend_obj_trench", "targetname" );
    var_a7dafa1d = struct::get( "firebase_defend_obj_cliff", "targetname" );
    var_61e6d791 = struct::get( "firebase_defend_obj_road", "targetname" );
    var_729580af = struct::get( "firebase_defend_obj_entrance", "targetname" );
    
    /#
        iprintlnbold( "<dev string:xed>" );
    #/
    
    level thread objectives::goto( "armada_obj_firebase_defend", var_db1c0995, #"hash_19a45c5bffdb799b" );
    wait 5;
    objectives::complete( "armada_obj_firebase_defend", var_db1c0995 );
    
    /#
        iprintlnbold( "<dev string:x101>" );
    #/
    
    level thread objectives::goto( "armada_obj_firebase_defend", var_a7dafa1d, #"hash_19a45c5bffdb799b" );
    wait 5;
    objectives::complete( "armada_obj_firebase_defend", var_a7dafa1d );
    
    /#
        iprintlnbold( "<dev string:x113>" );
    #/
    
    level thread objectives::goto( "armada_obj_firebase_defend", var_61e6d791, #"hash_19a45c5bffdb799b" );
    wait 5;
    objectives::complete( "armada_obj_firebase_defend", var_61e6d791 );
    
    /#
        iprintlnbold( "<dev string:x124>" );
    #/
    
    level thread objectives::goto( "armada_obj_firebase_defend", var_729580af, #"hash_19a45c5bffdb799b" );
    wait 5;
    objectives::complete( "armada_obj_firebase_defend", var_729580af );
    level flag::set( "flag_obj_firebase_defend_complete" );
    
    /#
        iprintlnbold( "<dev string:x138>" );
    #/
    
    objectives::complete( "armada_obj_firebase_defend", var_729580af );
}

// Namespace namespace_e871b49a/namespace_dbe8ebbb
// Params 0
// Checksum 0x80f724d1, Offset: 0xb180
// Size: 0x4
function function_72cfe867()
{
    
}

