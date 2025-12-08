#using script_3072532951b5b4ae;
#using script_58524f08c3081cbb;
#using script_5a85dd71c99e76a2;
#using script_5c325a0a637fdc2e;
#using script_6fad88ff3ed4ff7d;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\util;

#namespace namespace_8a404420;

// Namespace namespace_8a404420/namespace_6c2f4852
// Params 0
// Checksum 0x4e93b3d3, Offset: 0xc90
// Size: 0x2c4
function function_7eb604b9()
{
    scene::add_scene_func( "scene_yam_1010_hel_intro", &function_63264d28, "play" );
    scene::add_scene_func( "scene_yam_1010_hel_intro", &function_485aed5c, "takeoff" );
    level scene::init( "scene_yam_1010_hel_intro" );
    collision_r_heli = getent( "collision_r_heli", "targetname" );
    collision_l_heli = getent( "collision_l_heli", "targetname" );
    collision_f_heli = getent( "collision_f_heli", "targetname" );
    var_58d24ca9 = [];
    
    if ( !isdefined( var_58d24ca9 ) )
    {
        var_58d24ca9 = [];
    }
    else if ( !isarray( var_58d24ca9 ) )
    {
        var_58d24ca9 = array( var_58d24ca9 );
    }
    
    var_58d24ca9[ var_58d24ca9.size ] = collision_r_heli;
    
    if ( !isdefined( var_58d24ca9 ) )
    {
        var_58d24ca9 = [];
    }
    else if ( !isarray( var_58d24ca9 ) )
    {
        var_58d24ca9 = array( var_58d24ca9 );
    }
    
    var_58d24ca9[ var_58d24ca9.size ] = collision_l_heli;
    
    if ( !isdefined( var_58d24ca9 ) )
    {
        var_58d24ca9 = [];
    }
    else if ( !isarray( var_58d24ca9 ) )
    {
        var_58d24ca9 = array( var_58d24ca9 );
    }
    
    var_58d24ca9[ var_58d24ca9.size ] = collision_f_heli;
    level thread function_23320f08( 0, var_58d24ca9 );
    level flag::wait_till( "all_players_spawned" );
    level thread scene::play( "scene_yam_1010_hel_intro", "play" );
    level flag::wait_till( "flg_hel_intro_fly_away" );
    level thread scene::play( "scene_yam_1010_hel_intro", "takeoff" );
    level thread function_23320f08( 1, var_58d24ca9 );
}

// Namespace namespace_8a404420/namespace_6c2f4852
// Params 2
// Checksum 0x89504777, Offset: 0xf60
// Size: 0x144
function function_23320f08( b_condition, var_6c91f8cd )
{
    if ( b_condition )
    {
        foreach ( ent in var_6c91f8cd )
        {
            ent moveto( ent.origin + ( 0, 0, -400 ), 5 );
        }
        
        return;
    }
    
    var_6c91f8cd[ 0 ] moveto( ( -6796, -470, 3910 ), 5 );
    var_6c91f8cd[ 1 ] moveto( ( -6629, -397, 3909 ), 5 );
    var_6c91f8cd[ 2 ] moveto( ( -6840, -140, 3903 ), 5 );
}

// Namespace namespace_8a404420/namespace_6c2f4852
// Params 1
// Checksum 0x262f618, Offset: 0x10b0
// Size: 0x8c
function function_63264d28( a_ents )
{
    belikov = a_ents[ #"belikov" ];
    belikov.propername = #"hash_59ecd456f45762d4";
    belikov ai::gun_remove();
    level waittill( #"intro_dialog_done" );
    level flag::set( "flg_intro_dialog_done" );
}

// Namespace namespace_8a404420/namespace_6c2f4852
// Params 1
// Checksum 0xe91c5b94, Offset: 0x1148
// Size: 0x64
function function_485aed5c( a_ents )
{
    var_3793dd70 = a_ents[ #"belikov" ];
    var_3f59f311 = a_ents[ #"heli" ];
    var_3793dd70 linkto( var_3f59f311 );
}

// Namespace namespace_8a404420/namespace_6c2f4852
// Params 0
// Checksum 0x607d1cc4, Offset: 0x11b8
// Size: 0x164
function function_f21e84b4()
{
    level.var_d596a87f endon( #"death" );
    level flag::wait_till( "flg_zipline_intro_zipliner_cross" );
    
    if ( level.var_d596a87f namespace_77fd5d41::stealth_enemy_getbsmstate() == "Stealth_Idle" && !level flag::get( "flg_zipline_intro_engaging" ) )
    {
        level.var_d596a87f thread function_a973b3e9();
        level scene::play( "scene_yam_2020_zip_cliffside_alt", "start" );
        level.var_d596a87f notify( #"flg_zip_cliffside_alt_done" );
    }
    
    if ( level.var_d596a87f namespace_77fd5d41::stealth_enemy_getbsmstate() == "Stealth_Idle" && !level flag::get( "flg_zipline_intro_engaging" ) && level flag::get( "flg_zipline_intro_allow_stand_up" ) )
    {
        level thread scene::play( "scene_yam_2020_zip_cliffside_alt", "loop" );
    }
}

// Namespace namespace_8a404420/namespace_6c2f4852
// Params 0
// Checksum 0x85238b1e, Offset: 0x1328
// Size: 0x54
function function_a973b3e9()
{
    self endon( #"death" );
    self endon( #"flg_zip_cliffside_alt_done" );
    self waittill( #"stealth_combat" );
    level scene::stop( "scene_yam_2020_zip_cliffside_alt" );
}

// Namespace namespace_8a404420/namespace_6c2f4852
// Params 0
// Checksum 0xdf0b1a98, Offset: 0x1388
// Size: 0x12c
function function_6240e40f()
{
    level.var_a06bbe2a endon( #"death" );
    level flag::wait_till( "flg_zipline_intro_zipliner_cross" );
    
    if ( level.var_a06bbe2a namespace_77fd5d41::stealth_enemy_getbsmstate() == "Stealth_Idle" && !level flag::get( "flg_zipline_intro_engaging" ) )
    {
        level scene::play( "scene_yam_2020_zip_cliffside_alt_enemy2", "start2" );
    }
    
    if ( level.var_a06bbe2a namespace_77fd5d41::stealth_enemy_getbsmstate() == "Stealth_Idle" && !level flag::get( "flg_zipline_intro_engaging" ) && level flag::get( "flg_zipline_intro_allow_stand_up" ) )
    {
        level thread scene::play( "scene_yam_2020_zip_cliffside_alt_enemy2", "loop2" );
    }
}

// Namespace namespace_8a404420/namespace_6c2f4852
// Params 0
// Checksum 0x2dc1b54c, Offset: 0x14c0
// Size: 0x100
function function_517fe722()
{
    var_6976e02a = getent( "zipline_intro_bird_scare", "targetname" );
    a_s_birds = struct::get_array( var_6976e02a.target, "targetname" );
    level flag::wait_till( "flg_satcom_birds_trigger" );
    
    foreach ( s_bird in a_s_birds )
    {
        s_bird thread scene::play( "Shot 1" );
    }
}

// Namespace namespace_8a404420/namespace_6c2f4852
// Params 1
// Checksum 0x5124cb5, Offset: 0x15c8
// Size: 0x54
function function_d07cab65( woods )
{
    var_a5fa7867 = struct::get( "scene_zip_fall_woods_traverse", "targetname" );
    var_a5fa7867 scene::play( "play", woods );
}

// Namespace namespace_8a404420/namespace_6c2f4852
// Params 0
// Checksum 0xc6eb7943, Offset: 0x1628
// Size: 0x134
function function_85bd6953()
{
    level scene::function_27f5972e( "scene_4020_yam_zip_fall_player_fall_bundle" );
    level waittill( #"hash_3ede0d97e45af550" );
    level thread namespace_7468806b::function_e15849a0();
    level namespace_5d7a2dac::music( "5.11_fall" );
    level thread namespace_b73b9191::function_54b7084f( "f_zipline_fall_impact_scaffolding", undefined, 0.2 );
    level thread namespace_b73b9191::function_54b7084f( "f_zipline_fall_impact_ground", undefined, 0.6 );
    level thread function_f18a8efc();
    level scene::play( "scene_4020_yam_zip_fall_player_fall_bundle", "fall" );
    level notify( #"hash_7abd2158f9add682" );
    level scene::function_f81475ae( "scene_4020_yam_zip_fall_player_fall_bundle" );
}

// Namespace namespace_8a404420/namespace_6c2f4852
// Params 0
// Checksum 0xa30d7dd1, Offset: 0x1768
// Size: 0x19c
function function_f18a8efc()
{
    wait 7;
    var_f7a697d1 = struct::get( "railing_piece_01", "targetname" );
    createdynentandlaunch( "p9_fxanim_yam_4020_catwalk_piece_01", var_f7a697d1.origin, var_f7a697d1.angles, var_f7a697d1.origin, ( 0, 0, 0 ) );
    wait 0.1;
    var_49cd91d2 = struct::get( "railing_piece_02", "targetname" );
    createdynentandlaunch( "p9_fxanim_yam_4020_catwalk_piece_02", var_49cd91d2.origin, var_49cd91d2.angles, var_49cd91d2.origin, ( 0, 0, 0 ) );
    var_b3380801 = struct::get( "railing_piece_03", "targetname" );
    createdynentandlaunch( "p9_fxanim_yam_4020_catwalk_piece_03", var_b3380801.origin, var_b3380801.angles, var_b3380801.origin, ( 0, 0, 0 ) );
    var_7777091 = struct::get( "railing_piece_04", "targetname" );
    wait 0.2;
    createdynentandlaunch( "p9_fxanim_yam_4020_catwalk_piece_04", var_7777091.origin, var_7777091.angles, var_7777091.origin, ( 0, 0, 0 ) );
}

// Namespace namespace_8a404420/namespace_6c2f4852
// Params 0
// Checksum 0x5d68836a, Offset: 0x1910
// Size: 0x74
function function_6b1799c6()
{
    level waittill( #"hash_33253c64ecacc7d9" );
    trigger::use( "t_bc_zipline_fall_3", "targetname", level.player, 0 );
    level scene::play( "p9_fxanim_cp_yamantau_zipl_platform_fall_02_bundle", "play" );
}

// Namespace namespace_8a404420/namespace_6c2f4852
// Params 1, eflags: 0x4
// Checksum 0xfeaf2a0f, Offset: 0x1990
// Size: 0x5c
function private start_timer( *e_player )
{
    level endon( #"hash_7abd2158f9add682" );
    n_time = 0;
    
    while ( true )
    {
        wait 0.05;
        n_time += 0.05;
    }
}

// Namespace namespace_8a404420/namespace_6c2f4852
// Params 0
// Checksum 0xda2c4140, Offset: 0x19f8
// Size: 0xe0
function function_876b3ae7()
{
    var_8e4071be = doors::function_73f09315( "bunker_icicle_door", "targetname" );
    var_8e4071be waittill( #"door_opening" );
    
    if ( is_true( var_8e4071be.var_c4c3fa39 ) )
    {
        scene::init( "p9_fxanim_cp_yamantau_icicle_vignette_scene" );
        wait 1;
        scene::play_from_time( "p9_fxanim_cp_yamantau_icicle_vignette_scene", "play" );
        return;
    }
    
    scene::play_from_time( "p9_fxanim_cp_yamantau_icicle_vignette_scene", "play" );
    var_8e4071be.c_door waittill( #"door_fully_open" );
}

// Namespace namespace_8a404420/namespace_6c2f4852
// Params 0
// Checksum 0x56df7e9f, Offset: 0x1ae0
// Size: 0x39c
function function_94b72d13()
{
    level flag::wait_till( "flg_woods_regroup_callover_start" );
    
    if ( !level flag::get_any( array( "flg_bunker_ladder_reached", "flg_woods_regroup_look_at_woods" ) ) )
    {
        level thread scene::play_from_time( "scene_yam_6005_grp_ladder_walk_off", "Woods_callover_greet", undefined, 0.5, 0, 1 );
        level.ai_woods hms_util::dialogue( "vox_cp_ymnt_01900_wood_overhere_81" );
        level thread scene::play( "scene_yam_6005_grp_ladder_walk_off", "Woods_near_idle" );
        level flag::wait_till_any_timeout( 3, array( "flg_bunker_ladder_reached", "flg_woods_regroup_look_at_woods" ) );
        
        if ( !level flag::get_any( array( "flg_bunker_ladder_reached", "flg_woods_regroup_look_at_woods" ) ) )
        {
            level thread namespace_7468806b::function_117649d4();
            level thread scene::play( "scene_yam_6005_grp_ladder_walk_off", "Woods_near_idle" );
            level flag::wait_till_any_timeout( 3, array( "flg_bunker_ladder_reached", "flg_woods_regroup_look_at_woods" ) );
            
            if ( !level flag::get_any( array( "flg_bunker_ladder_reached", "flg_woods_regroup_look_at_woods" ) ) )
            {
                level thread namespace_7468806b::function_8f4e51f7();
                level thread scene::play( "scene_yam_6005_grp_ladder_walk_off", "Woods_near_idle" );
                level flag::wait_till_any_timeout( 3, array( "flg_bunker_ladder_reached", "flg_woods_regroup_look_at_woods" ) );
            }
        }
    }
    
    t_woods_bunker_ladder = getent( "t_woods_bunker_ladder", "targetname" );
    level flag::wait_till_any( array( "flg_bunker_ladder_reached", "flg_woods_regroup_look_at_woods" ) );
    namespace_7468806b::function_e7b6bd1f();
    
    if ( !level.player istouching( t_woods_bunker_ladder ) )
    {
        level thread scene::play( "scene_yam_6005_grp_ladder_walk_off", "Woods_near_idle" );
        wait 2;
        level flag::wait_till( "flg_bunker_ladder_reached" );
    }
    
    t_woods_bunker_ladder delete();
    level flag::set( "flg_woods_regroup_woods_exiting" );
    level scene::play( "scene_yam_6005_grp_ladder_walk_off", "Woods_walk_off" );
}

// Namespace namespace_8a404420/namespace_6c2f4852
// Params 0
// Checksum 0xad20b4b4, Offset: 0x1e88
// Size: 0x172
function scene_yam_6010_grp_enter_react()
{
    level flag::wait_till_any( array( "flg_bunker_office_entered", "flg_bunker_office_seen" ) );
    level scene::play( "scene_yam_6010_grp_enter_react", "woods_react_intro", array( level.ai_woods ) );
    level thread scene::play( "scene_yam_6010_grp_enter_react", "woods_table_idle", array( level.ai_woods ) );
    level flag::wait_till( "survey_equipment_completed" );
    level scene::stop( "scene_yam_6010_grp_enter_react" );
    var_ae4df8ef = getnode( "woods_office_exit", "targetname" );
    
    if ( !level flag::get( "flg_excavation_survey_room_exited" ) )
    {
        level.ai_woods setgoal( var_ae4df8ef );
        level.ai_woods.goalradius = 32;
    }
}

// Namespace namespace_8a404420/namespace_6c2f4852
// Params 0
// Checksum 0x32c1dc81, Offset: 0x2008
// Size: 0x184
function scene_yam_7010_exc_extraction()
{
    level scene::init( "scene_yam_7010_exc_extraction" );
    level thread scene::play( "scene_yam_7010_exc_extraction", "guy_loop" );
    level flag::wait_till( "flg_bunker_survey_interacted" );
    level waittill( #"hash_39fbe9dbd19f01ae" );
    level thread scene::play( "scene_yam_7010_exc_extraction", "crane_start" );
    level flag::wait_till( "flg_excavation_alpha_crane_rotate" );
    level thread scene::play( "scene_yam_7010_exc_extraction", "stage1" );
    level flag::wait_till( "flg_excavation_charlie_approach" );
    level thread scene::play( "scene_yam_7010_exc_extraction", "stage2" );
    level flag::wait_till( "flg_excavation_charlie_exit_approach" );
    level thread scene::play( "scene_yam_7010_exc_extraction", "stage3" );
}

// Namespace namespace_8a404420/namespace_6c2f4852
// Params 0
// Checksum 0xf7199088, Offset: 0x2198
// Size: 0xe4
function function_df4e7f42()
{
    level thread scene::play( "scene_yam_7010_exc_extraction", "guy_loop" );
    level thread scene::play( "scene_yam_7010_exc_extraction", "stage1" );
    level flag::wait_till( "flg_excavation_charlie_approach" );
    level thread scene::play( "scene_yam_7010_exc_extraction", "stage2" );
    level flag::wait_till( "flg_excavation_charlie_exit_approach" );
    level thread scene::play( "scene_yam_7010_exc_extraction", "stage3" );
}

// Namespace namespace_8a404420/namespace_6c2f4852
// Params 0
// Checksum 0x7bbced0c, Offset: 0x2288
// Size: 0x9c
function function_164734e9()
{
    level thread scene::play( "scene_yam_7010_exc_extraction", "guy_loop" );
    level thread scene::play( "scene_yam_7010_exc_extraction", "stage2" );
    level flag::wait_till( "flg_excavation_charlie_exit_approach" );
    level thread scene::play( "scene_yam_7010_exc_extraction", "stage3" );
}

// Namespace namespace_8a404420/namespace_6c2f4852
// Params 0
// Checksum 0xbee45608, Offset: 0x2330
// Size: 0x15c
function function_2468cb92()
{
    level.var_c9b20243 = 1;
    level scene::init( "scene_yam_7010_exc_truck_exit" );
    level thread scene::play( "scene_yam_7010_exc_scaffolding_smoking", "loop" );
    level thread scene::play( "scene_yam_7010_exc_scaffolding_observing", "loop" );
    level thread scene::play( "scene_yam_7010_exc_scaffolding_sitting", "loop" );
    level thread scene::play( "scene_yam_7010_exc_scaffolding_plans", "plans" );
    level thread scene::play( "scene_yam_7010_exc_scaffolding_rear", "break_idle" );
    level thread scene_yam_7010_exc_extraction();
    level flag::wait_till( "flg_bunker_office_entered" );
    level thread scene::play( "scene_yam_7010_exc_truck_exit", "truck_loop" );
}

// Namespace namespace_8a404420/namespace_6c2f4852
// Params 0
// Checksum 0x41280f13, Offset: 0x2498
// Size: 0xcc
function function_e6604e8b()
{
    level thread scene::play( "scene_yam_7010_exc_scaffolding_smoking", "loop" );
    level thread scene::play( "scene_yam_7010_exc_scaffolding_observing", "loop" );
    level thread scene::play( "scene_yam_7010_exc_scaffolding_sitting", "loop" );
    level thread scene::play( "scene_yam_7010_exc_scaffolding_plans", "plans" );
    level thread scene::play( "scene_yam_7010_exc_scaffolding_rear", "break_idle" );
}

// Namespace namespace_8a404420/namespace_6c2f4852
// Params 0
// Checksum 0x6e8d5ffe, Offset: 0x2570
// Size: 0xc4
function function_301a4927()
{
    level scene::stop( "scene_yam_7010_exc_truck_exit" );
    level thread scene::play( "scene_yam_7010_exc_truck_exit", "loading_enemy03" );
    level thread scene::play( "scene_yam_7010_exc_truck_exit", "loading_enemy04" );
    level scene::play( "scene_yam_7010_exc_truck_exit", "truck_enter" );
    level scene::play( "scene_yam_7010_exc_truck_exit", "truck_exit" );
}

// Namespace namespace_8a404420/namespace_6c2f4852
// Params 0
// Checksum 0x589daf3a, Offset: 0x2640
// Size: 0x10c
function function_879f456d()
{
    level.var_c9b20243 = 0;
    level scene::stop( "scene_yam_7010_exc_truck_exit" );
    level scene::delete_scene_spawned_ents( "scene_yam_7010_exc_scaffolding_smoking" );
    level scene::delete_scene_spawned_ents( "scene_yam_7010_exc_scaffolding_observing" );
    level scene::delete_scene_spawned_ents( "scene_yam_7010_exc_scaffolding_sitting" );
    level scene::delete_scene_spawned_ents( "scene_yam_7010_exc_truck_exit" );
    level scene::delete_scene_spawned_ents( "scene_yam_7010_exc_scaffolding_plans" );
    level scene::delete_scene_spawned_ents( "scene_yam_7010_exc_scaffolding_rear" );
    level thread scene::init( "scene_yam_7010_exc_scaffolding_plans" );
}

// Namespace namespace_8a404420/namespace_6c2f4852
// Params 0, eflags: 0x4
// Checksum 0x94819f0f, Offset: 0x2758
// Size: 0x136
function private function_bafa4855()
{
    self endon( #"death" );
    function_f05650bc( "scene_yam_7010_exc_scaffolding_rear", "break_idle" );
    function_f05650bc( "scene_yam_7010_exc_scaffolding_rear", "break_idle" );
    function_f05650bc( "scene_yam_7010_exc_scaffolding_rear", "back_to_work" );
    
    while ( level.var_c9b20243 )
    {
        var_689ecfec = randomint( 3 );
        
        switch ( var_689ecfec )
        {
            case 1:
                function_f05650bc( "scene_yam_7010_exc_scaffolding_rear", "move_boxes" );
                break;
            case 2:
                function_f05650bc( "scene_yam_7010_exc_scaffolding_rear", "move_boxes_fall" );
                break;
        }
    }
}

// Namespace namespace_8a404420/namespace_6c2f4852
// Params 2, eflags: 0x4
// Checksum 0x6fb6935d, Offset: 0x2898
// Size: 0x5a
function private function_f05650bc( str_scene, str_shot )
{
    n_wait_time = scene::function_8582657c( str_scene, str_shot );
    level thread scene::play( str_scene, str_shot );
    wait n_wait_time;
}

// Namespace namespace_8a404420/namespace_6c2f4852
// Params 0
// Checksum 0x72745529, Offset: 0x2900
// Size: 0x15c
function function_174832fd()
{
    level scene::play( "scene_yam_7030_exc_vert_descend", "woods_enter" );
    level thread scene::play( "scene_yam_7030_exc_vert_descend", "woods_loop" );
    level flag::wait_till( "flg_excavation_descent_started" );
    level.ai_woods animation::stop();
    level flag::wait_till( "flg_excavation_woods_descend_start" );
    level thread function_505de846();
    level scene::play( "scene_yam_7030_exc_vert_descend", "woods_exit" );
    
    if ( !level flag::get( "flg_woods_excavation_descend_skip" ) )
    {
        trigger::use( "tr_excavation_woods_post_descent", "targetname", level.player, 0 );
        level flag::set( "flg_excavation_woods_descend_done" );
    }
}

// Namespace namespace_8a404420/namespace_6c2f4852
// Params 0
// Checksum 0x2a68e774, Offset: 0x2a68
// Size: 0xfc
function function_505de846()
{
    level flag::wait_till_any( array( "flg_woods_excavation_descend_skip", "flg_excavation_woods_descend_done" ) );
    
    if ( !level flag::get( "flg_excavation_woods_descend_done" ) )
    {
        level scene::stop( "scene_yam_7030_exc_vert_descend" );
        level scene::play_from_time( "scene_yam_7030_exc_vert_descend", "woods_exit", undefined, 0.6, 1, 1 );
        trigger::use( "tr_excavation_woods_post_descent", "targetname", level.player, 0 );
        level flag::set( "flg_excavation_woods_descend_done" );
    }
}

// Namespace namespace_8a404420/namespace_6c2f4852
// Params 1
// Checksum 0xc7eb5fc2, Offset: 0x2b70
// Size: 0x18c
function scene_yam_7035_exc_vert_descend_guard( guy )
{
    b_loop = 1;
    
    if ( !level flag::get( "flg_excavation_alpha_greeters_alerted_early" ) )
    {
        level thread function_68e50e0e( b_loop, guy );
        level flag::wait_till_any( array( "flg_excav_player_descent_done", "flg_excavation_alpha_greeters_alerted_early" ) );
        
        if ( level flag::get( "flg_excav_player_descent_done" ) && !level flag::get( "flg_excavation_alpha_greeters_alerted_early" ) )
        {
            b_loop = 0;
            level scene::stop( "scene_yam_7035_exc_vert_descend_guard" );
            wait 0.5;
            level scene::play( "scene_yam_7035_exc_vert_descend_guard", "react", guy );
        }
        
        if ( !level flag::get( "flg_excav_player_descent_done" ) && level flag::get( "flg_excavation_alpha_greeters_alerted_early" ) )
        {
            b_loop = 0;
            level scene::stop( "scene_yam_7035_exc_vert_descend_guard" );
        }
    }
}

// Namespace namespace_8a404420/namespace_6c2f4852
// Params 2, eflags: 0x4
// Checksum 0x3f8f310b, Offset: 0x2d08
// Size: 0x60
function private function_68e50e0e( var_30467756, var_d24d6d5c )
{
    while ( var_30467756 )
    {
        level thread scene::play( "scene_yam_7035_exc_vert_descend_guard", "idle", var_d24d6d5c );
        level waittill( #"hash_6a2f90130e6b8ca4" );
    }
}

// Namespace namespace_8a404420/namespace_6c2f4852
// Params 0
// Checksum 0xd903aa87, Offset: 0x2d70
// Size: 0x74
function scene_yam_8001_srv_slide_approach()
{
    level scene::play( "scene_yam_8001_srv_slide_approach", "enter" );
    
    if ( !level flag::get( "flg_server_reveal_jump_start" ) )
    {
        level thread scene::play( "scene_yam_8001_srv_slide_approach", "loop" );
    }
}

// Namespace namespace_8a404420/namespace_6c2f4852
// Params 0
// Checksum 0x3d43855c, Offset: 0x2df0
// Size: 0x44
function function_6699b719()
{
    level thread namespace_7468806b::function_86c78d49();
    level scene::play( "scene_yam_8005_srv_slide_landing", "play" );
}

// Namespace namespace_8a404420/namespace_6c2f4852
// Params 0
// Checksum 0x20b75195, Offset: 0x2e40
// Size: 0x74
function function_e0069c97()
{
    level endon( #"flg_server_cable_attaching" );
    wait 0.1;
    level scene::play( "scene_yam_8010_sca_server_mount_attach", "woods_server_climb" );
    level thread scene::play( "scene_yam_8010_sca_server_mount_attach", "woods_server_idle" );
}

// Namespace namespace_8a404420/namespace_6c2f4852
// Params 0
// Checksum 0x1c31b7d, Offset: 0x2ec0
// Size: 0xbc
function function_a8eb3579()
{
    level flag::wait_till( "flg_server_cable_attaching" );
    level scene::stop( "scene_yam_8010_sca_server_mount_attach" );
    level thread scene::play( "p9_yamantau_server_cable_lift_bundle", "8010" );
    level scene::play( "scene_yam_8010_sca_server_mount_attach", "woods_server_descent", level.e_server_hook );
    level flag::set( "flg_server_cable_attached" );
}

// Namespace namespace_8a404420/namespace_6c2f4852
// Params 0
// Checksum 0xc660a2a1, Offset: 0x2f88
// Size: 0x2c
function scene_yam_9010_out_heli_outro()
{
    level thread scene::play( "scene_yam_9010_out_heli_outro", "outro_scene" );
}

