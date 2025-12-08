#using script_1e11da73f221dacf;
#using script_237e957844a8197c;
#using script_4a1a0f734d8d0e04;
#using script_7728aa611ab72ad9;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicleriders_shared;
#using scripts\cp_common\breadcrumbs;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;

#namespace namespace_9162cd57;

// Namespace namespace_9162cd57/namespace_9162cd57
// Params 1
// Checksum 0xf5934ec9, Offset: 0xbf0
// Size: 0xf4
function start( *str_objective )
{
    level hms_util::function_ee1d1df6( "park", "Park", "park_floor_two_struct", "floor_two_allies_initial_color_trig" );
    level hms_util::function_ee1d1df6( "lazar", "Lazar", "lazar_floor_two_struct" );
    door_blocker = getent( "second_floor_stairway_door", "targetname" );
    var_cee57de3 = getent( "second_floor_stairway_door_clip", "targetname" );
    door_blocker delete();
    var_cee57de3 delete();
}

// Namespace namespace_9162cd57/namespace_9162cd57
// Params 2
// Checksum 0x287cc022, Offset: 0xcf0
// Size: 0x104
function main( *str_objective, *var_50cc0d4f )
{
    /#
        hms_util::print( "<dev string:x38>" );
    #/
    
    level.var_9b05d82d = spawnstruct();
    hms_util::function_eaa0342e( "floor_two_containment_warnings", "floor_two_containment_fails" );
    level thread function_acf07bae();
    level thread function_74774e71();
    level thread function_cd60a984();
    level thread namespace_a789f8ae::function_e73fa40e( "2nd_floor" );
    level thread namespace_a789f8ae::function_b91f9a58( "2nd_floor" );
    savegame::checkpoint_save();
}

// Namespace namespace_9162cd57/namespace_9162cd57
// Params 4
// Checksum 0x5ca81c67, Offset: 0xe00
// Size: 0x58
function cleanup( *str_objective, *var_50cc0d4f, *var_aa1a6455, *player )
{
    /#
        hms_util::print( "<dev string:x4e>" );
    #/
    
    level notify( #"hash_24b259ee7a18193a" );
}

// Namespace namespace_9162cd57/namespace_9162cd57
// Params 0
// Checksum 0x6b28f49a, Offset: 0xe60
// Size: 0xa4
function function_b0ba87a4()
{
    self endon( #"death" );
    self waittill( #"trigger" );
    e_blocker = getent( "nuke_door_blocker", "targetname" );
    e_blocker show();
    level flag::wait_till( "obj_photo_done" );
    e_blocker hide();
}

// Namespace namespace_9162cd57/namespace_9162cd57
// Params 2
// Checksum 0xd5a09b78, Offset: 0xf10
// Size: 0x54
function function_949d7906( var_5a04e6d6, var_b9f33580 )
{
    self ai::set_behavior_attribute( "disablepeek", var_5a04e6d6 );
    self ai::set_behavior_attribute( "disablelean", var_b9f33580 );
}

// Namespace namespace_9162cd57/namespace_9162cd57
// Params 0
// Checksum 0x19fd6bc9, Offset: 0xf70
// Size: 0x20c
function function_acf07bae()
{
    objectives::scripted( "obj_goto_bomb", undefined, #"hash_110b2d9474b5420f" );
    level breadcrumb::function_61037c6c( "bc_second_floor_objective" );
    level flag::wait_till_all( array( "flg_vip_door_last_stand_enemies_dead", "flg_floor_two_end" ) );
    var_4a3daa0b = struct::get( "nuke_room_door_look_at", "targetname" );
    
    while ( true )
    {
        within_fov = util::within_fov( level.player getplayercamerapos(), level.player getplayerangles(), var_4a3daa0b.origin, cos( 35 ) );
        var_19433220 = sighttracepassed( level.player getplayercamerapos(), var_4a3daa0b.origin, 0, undefined );
        
        if ( within_fov == 1 && var_19433220 == 1 )
        {
            break;
        }
        
        waitframe( 1 );
    }
    
    level breadcrumb::function_e261021e( "bc_second_floor_objective" );
    level flag::wait_till( "flg_pre_nuke_room_vo_complete" );
    objectives::complete( "obj_goto_bomb" );
    level notify( #"hash_2e47b50259ab3bec" );
    skipto::function_4e3ab877( "2nd_floor" );
}

// Namespace namespace_9162cd57/namespace_9162cd57
// Params 0
// Checksum 0x8388d2b8, Offset: 0x1188
// Size: 0x4c
function function_dd58d582()
{
    level.player endon( #"death" );
    level endon( #"2nd_floor" );
    level flag::wait_till( "flg_snipers_dead" );
}

// Namespace namespace_9162cd57/namespace_9162cd57
// Params 0
// Checksum 0x5fd0011d, Offset: 0x11e0
// Size: 0x13c
function function_98d37226()
{
    level.player endon( #"death" );
    level endon( #"2nd_floor" );
    var_64186d96 = struct::get( "scientist_kill_spot", "targetname" );
    level flag::wait_till( "flg_civs_in_motion" );
    level.var_e1e13696 thread hms_util::dialogue( "vox_cp_cbcr_02200_sci_pleaseno_79", 0, "allies", "Scientist 2" );
    level flag::wait_till( "flg_scientist_sniped" );
    var_64186d96 thread hms_util::dialogue( "vox_cp_cbcr_02200_sci_agggh_ff", 1, "allies", "Scientist 2" );
    wait randomfloatrange( 0.5, 1 );
    level.park hms_util::dialogue( "vox_cp_cbcr_02200_park_snipersontheroo_a2" );
}

// Namespace namespace_9162cd57/namespace_9162cd57
// Params 0
// Checksum 0x7feaea10, Offset: 0x1328
// Size: 0x1ec
function function_74774e71()
{
    level.player endon( #"death" );
    var_e534dcb = struct::get( "ai_alder_radio", "targetname" );
    wait 1.75;
    level.park hms_util::dialogue( "vox_cp_cbcr_02300_park_adlerweremoving_f5" );
    var_e534dcb hms_util::dialogue( "vox_cp_cbcr_02200_adlr_werepinneddownm_81", 1, "allies", "adler" );
    level thread function_98d37226();
    level thread function_dd58d582();
    level flag::wait_till( "flg_spotted_mg" );
    
    if ( isalive( level.var_fcdd86d8 ) )
    {
        level.lazar hms_util::dialogue( "vox_cp_cbcr_02400_lazr_theyrereallyhun_99" );
        level.park hms_util::dialogue( "vox_cp_cbcr_02400_park_takeoutthatheav_e0" );
    }
    
    level flag::wait_till( "flg_vip_door_last_stand_enemies_dead" );
    level.park hms_util::dialogue( "vox_cp_cbcr_01500_park_27badlerweregoi_54" );
    level.park hms_util::dialogue( "vox_cp_cbcr_01500_park_lazarmanthedoor_e5" );
    level.lazar thread hms_util::dialogue( "vox_cp_cbcr_01500_lazr_anythingforyoul_f7", undefined );
    level flag::set( "flg_pre_nuke_room_vo_complete" );
}

// Namespace namespace_9162cd57/namespace_9162cd57
// Params 0
// Checksum 0xb7810abc, Offset: 0x1520
// Size: 0x22c
function function_400f93ba()
{
    level.player endon( #"death" );
    namespace_307260b8::function_2b6287f4( "2nd_floor_office_ambush_trigger" );
    var_b002bd9b = spawner::simple_spawn( "2nd_floor_office_ambushers", &function_687b1b14 );
    var_408c4a10 = spawner::simple_spawn_single( "2nd_floor_office_ambushers_slide", &function_687b1b14 );
    trigger::use( "set_conference_color" );
    
    foreach ( ai in var_b002bd9b )
    {
        ai ai::set_behavior_attribute( #"demeanor", "cqb" );
    }
    
    a_scene_ents[ #"soldier" ] = var_408c4a10;
    var_408c4a10 val::set( #"ai_forcegoal", "ignoreall", 1 );
    var_7820eb66 = struct::get( "scene_soldier_slide", "targetname" );
    thread function_cda1622();
    var_7820eb66 scene::play( a_scene_ents );
    spawner::waittill_ai_group_ai_count( "2nd_floor_office_shotgunners", 1 );
    spawner::simple_spawn( "2nd_floor_office_reinforcements", &function_687b1b14 );
}

// Namespace namespace_9162cd57/namespace_9162cd57
// Params 0
// Checksum 0x61376cd5, Offset: 0x1758
// Size: 0x5c
function function_cda1622()
{
    wait 3;
    var_a08ef2a1 = getent( "parkour_physics_impulse", "targetname" );
    physicsexplosionsphere( var_a08ef2a1.origin, 210, 0, 0.56 );
}

// Namespace namespace_9162cd57/namespace_9162cd57
// Params 0
// Checksum 0xe0c327d7, Offset: 0x17c0
// Size: 0x4e
function function_2e8424c5()
{
    namespace_307260b8::function_2b6287f4( "trig_special_encounter_guy" );
    var_61a91f6f = spawner::simple_spawn_single( "2nd_floor_peek_through", &function_687b1b14 );
}

// Namespace namespace_9162cd57/namespace_9162cd57
// Params 0
// Checksum 0xbe03185f, Offset: 0x1818
// Size: 0x1a0
function function_18580559()
{
    var_ccb58619 = getaiarray( "2nd_floor_right_main_hall", "targetname" );
    var_5a9ddf12 = getaiarray( "2nd_floor_right_main_hall_reinforcements", "targetname" );
    var_628e7cf5 = arraycombine( var_ccb58619, var_5a9ddf12 );
    level flag::wait_till( "flg_axis_retreat_2" );
    var_5a7199e6 = getaiarray( "vip_area_last_stand_guards", "targetname" );
    var_fa9ba784 = getaiarray( "vip_area_last_stand_guards_reinforcements", "targetname" );
    var_4e346220 = arraycombine( var_ccb58619, var_5a9ddf12 );
    
    foreach ( guy in var_4e346220 )
    {
        if ( isdefined( guy ) )
        {
            guy thread namespace_f7efe8a3::function_1bdb683( "fallback_2", 0.1, 1 );
        }
    }
}

// Namespace namespace_9162cd57/namespace_9162cd57
// Params 0
// Checksum 0xc8b78d79, Offset: 0x19c0
// Size: 0x8c
function function_7a1d5f84()
{
    var_8a693ebe = getent( "t_gate_guys_color", "targetname" );
    
    if ( isalive( self ) )
    {
        self thread namespace_f7efe8a3::function_1bdb683( "gate_enemy_retreat", 0, 0.5 );
    }
    
    if ( isdefined( var_8a693ebe ) )
    {
        var_8a693ebe trigger::use();
    }
}

// Namespace namespace_9162cd57/namespace_9162cd57
// Params 0
// Checksum 0x9b3a6cb, Offset: 0x1a58
// Size: 0x41c
function function_e2d61fd0()
{
    level.player endon( #"death" );
    var_d8320f70 = struct::get( "rooftop_sniper_intro", "targetname" );
    var_4a3daa0b = struct::get( "scientist_lookat", "targetname" );
    t_spawner = getent( "trig_spawn_scientist", "targetname" );
    
    while ( true )
    {
        within_fov = util::within_fov( level.player getplayercamerapos(), level.player getplayerangles(), var_4a3daa0b.origin, cos( 65 ) );
        var_19433220 = sighttracepassed( level.player getplayercamerapos(), var_4a3daa0b.origin, 0, undefined );
        
        if ( within_fov == 1 && var_19433220 == 1 && level.player istouching( t_spawner ) )
        {
            break;
        }
        
        waitframe( 1 );
    }
    
    var_4a6bcfce = spawner::simple_spawn_single( "rooftop_sniper_killer", &function_687b1b14 );
    var_6ad55ca3 = spawner::simple_spawn_single( "2nd_floor_rooftop_snipers", &function_687b1b14 );
    var_e4a88c19 = spawner::simple_spawn_single( "2nd_floor_sniper_scaffold", &function_687b1b14 );
    
    if ( !isdefined( var_6ad55ca3 ) )
    {
        var_6ad55ca3 = [];
    }
    else if ( !isarray( var_6ad55ca3 ) )
    {
        var_6ad55ca3 = array( var_6ad55ca3 );
    }
    
    var_6ad55ca3[ var_6ad55ca3.size ] = var_4a6bcfce;
    
    if ( !isdefined( var_6ad55ca3 ) )
    {
        var_6ad55ca3 = [];
    }
    else if ( !isarray( var_6ad55ca3 ) )
    {
        var_6ad55ca3 = array( var_6ad55ca3 );
    }
    
    var_6ad55ca3[ var_6ad55ca3.size ] = var_e4a88c19;
    level.var_e1e13696 = spawner::simple_spawn_single( "scientist_guy_killed", &function_687b1b14 );
    level.var_e1e13696.health = 1;
    level.var_b1595f41 = spawner::simple_spawn_single( "scientist_guy_lived", &function_687b1b14 );
    level.var_b1595f41.health = 1;
    var_4a6bcfce thread spawner::go_to_node( var_d8320f70 );
    level.var_e1e13696 thread function_4a631484( var_4a6bcfce );
    level.var_b1595f41 thread function_225b3079();
    level flag::set( "flg_civs_in_motion" );
    level thread function_b8cb638d( var_6ad55ca3 );
    ai::waittill_dead_or_dying( var_6ad55ca3 );
    level flag::set( "flg_snipers_dead" );
}

// Namespace namespace_9162cd57/namespace_9162cd57
// Params 2
// Checksum 0xdf5399cf, Offset: 0x1e80
// Size: 0x74
function function_b9fa18dc( n_time, str_flag )
{
    level.player endon( #"death" );
    wait n_time;
    
    /#
        hms_util::print( "<dev string:x62>" + str_flag );
    #/
    
    level flag::set( str_flag );
}

// Namespace namespace_9162cd57/namespace_9162cd57
// Params 1
// Checksum 0xd9ac453c, Offset: 0x1f00
// Size: 0x13e
function function_b8cb638d( ai )
{
    level endon( #"flg_snipers_dead" );
    var_165eacc0 = 0.2;
    var_273d568b = 10;
    wait 5;
    
    while ( ai.size > 0 && var_165eacc0 < 100 )
    {
        foreach ( guy in ai )
        {
            if ( isalive( guy ) )
            {
                guy.script_accuracy += var_165eacc0;
                var_165eacc0 += 0.2;
                
                /#
                    hms_util::print( guy.script_accuracy );
                #/
                
                wait var_273d568b;
                var_273d568b--;
            }
        }
    }
}

// Namespace namespace_9162cd57/namespace_9162cd57
// Params 1
// Checksum 0x2d5ba4d4, Offset: 0x2048
// Size: 0x1a4
function function_4a631484( ai_sniper )
{
    self endon( #"death" );
    var_859633df = struct::get( "civ_path1", "targetname" );
    var_a9eb1838 = struct::get( "civ_path_saved", "targetname" );
    self ai::set_behavior_attribute( #"_civ_mode", "run" );
    self thread spawner::go_to_node( var_859633df );
    self waittill( #"goal" );
    
    if ( isalive( ai_sniper ) )
    {
        var_10507c40 = self geteye();
        magicbullet( ai_sniper.weapon, ai_sniper gettagorigin( "tag_flash" ), var_10507c40, ai_sniper );
        level flag::set( "flg_scientist_sniped" );
        self startragdoll();
        self kill();
        return;
    }
    
    self thread spawner::go_to_node( var_a9eb1838 );
}

// Namespace namespace_9162cd57/namespace_9162cd57
// Params 0
// Checksum 0x7772c165, Offset: 0x21f8
// Size: 0x194
function function_225b3079()
{
    self endon( #"death" );
    var_9750d754 = struct::get( "civ_path2", "targetname" );
    var_976c732e = struct::get( "civ_path2_change", "targetname" );
    var_f97b3291 = struct::get( "civ_path2_retreat", "targetname" );
    self ai::set_behavior_attribute( #"_civ_mode", "run" );
    self thread spawner::go_to_node( var_9750d754 );
    s_notify = level flag::wait_till_any( [ "flg_scientist_sniped", "flg_snipers_dead" ] );
    
    if ( s_notify._notify == "flg_scientist_sniped" )
    {
        self spawner::function_461ce3e9();
        self thread spawner::go_to_node( var_976c732e );
        level flag::wait_till( "flg_snipers_dead" );
        self thread spawner::go_to_node( var_f97b3291 );
    }
}

// Namespace namespace_9162cd57/namespace_9162cd57
// Params 0
// Checksum 0x86529627, Offset: 0x2398
// Size: 0x61c
function function_cd60a984()
{
    level.park colors::enable();
    level.lazar colors::enable();
    level thread function_18580559();
    namespace_307260b8::function_2b6287f4( "2nd_floor_gate_enemy_trig" );
    var_31091b0f = spawner::simple_spawn( "2nd_floor_gate_spawner", &function_687b1b14 );
    level thread function_dda2c76e( var_31091b0f );
    array::thread_all( var_31091b0f, &function_165eaaa );
    namespace_307260b8::function_2b6287f4( "2nd_floor_gate_retreat" );
    
    foreach ( guy in var_31091b0f )
    {
        guy thread function_7a1d5f84();
    }
    
    level thread function_400f93ba();
    level thread function_2e8424c5();
    level flag::wait_till( "flg_ready_snipers" );
    level thread function_e2d61fd0();
    savegame::checkpoint_save();
    level thread function_b9fa18dc( 15, "flg_no_snipers_dead" );
    level flag::wait_till_any( array( "flg_main_hall_guys", "flg_snipers_dead", "flg_no_snipers_dead" ) );
    var_9606fd42 = spawner::simple_spawn( "2nd_floor_right_main_hall", &function_687b1b14 );
    array::thread_all( var_9606fd42, &function_165eaaa );
    array::thread_all( var_9606fd42, &function_949d7906, 1, 1 );
    trigger::use( "post_sniper_colors" );
    namespace_307260b8::function_2b6287f4( "2nd_floor_hallway_reinforcements_trigger" );
    var_9606fd42 = spawner::simple_spawn( "2nd_floor_right_main_hall_reinforcements", &function_687b1b14 );
    trigger::use( "2nd_reinforcements" );
    level thread function_d1cabeee();
    level thread function_c7c21ff9();
    namespace_307260b8::function_2b6287f4( "vip_last_stand_trigger" );
    var_8f235119 = spawner::simple_spawn( "vip_area_last_stand_guards", &function_687b1b14 );
    namespace_307260b8::function_2b6287f4( "vip_last_stand_trigger_reinforcements" );
    var_c7d1f560 = spawner::simple_spawn( "vip_area_last_stand_guards_reinforcements", &function_687b1b14 );
    array::thread_all( var_c7d1f560, &function_165eaaa );
    var_62cf72f4 = arraycombine( var_c7d1f560, var_8f235119 );
    level.park.var_24f6e6a6 = 100;
    level.lazar.var_24f6e6a6 = 100;
    ai::waittill_dead_or_dying( var_62cf72f4 );
    level flag::set( "flg_vip_door_last_stand_enemies_dead" );
    node = getnode( "n_park_nuke_room_door", "targetname" );
    var_4aec9f2c = getnode( "n_lazar_nuke_room_door", "targetname" );
    
    if ( isdefined( level.park ) && isdefined( level.lazar ) )
    {
        /#
            hms_util::print( "<dev string:x74>" );
        #/
        
        level.park setdesiredspeed( "sprint" );
        level.lazar setdesiredspeed( "sprint" );
        level.park setgoal( node );
        level.park ai::set_behavior_attribute( "disablepeek", 1 );
        level.park ai::set_behavior_attribute( "disablelean", 1 );
        level.lazar colors::disable();
        level.park colors::disable();
        level.lazar setgoal( var_4aec9f2c );
    }
    
    savegame::checkpoint_save();
}

// Namespace namespace_9162cd57/namespace_9162cd57
// Params 0
// Checksum 0xca44fab, Offset: 0x29c0
// Size: 0xfc
function function_c7c21ff9()
{
    level.player endon( #"death" );
    var_5b23cbdd = getent( "vip_last_stand_trigger", "targetname" );
    var_2c3b91fc = struct::get_array( "turret_points" );
    e_turret = getent( "mg_nest_2nd_floor", "targetname" );
    var_5deea171 = namespace_307260b8::function_516b7ec( "2nd_floor_turret_gunner", "2nd_floor_support_turret" );
    var_5b23cbdd waittill( #"trigger" );
    n_shots = 5;
    e_turret turret::enable( 0, 1, undefined );
}

// Namespace namespace_9162cd57/namespace_9162cd57
// Params 0
// Checksum 0x452b21ce, Offset: 0x2ac8
// Size: 0x6c
function function_8604d848()
{
    var_1623c030 = getent( "vip_guards_flank_encounter_trigger", "targetname" );
    
    if ( isdefined( var_1623c030 ) )
    {
        var_1623c030 delete();
        
        /#
            hms_util::print( "<dev string:x8b>" );
        #/
    }
}

// Namespace namespace_9162cd57/namespace_9162cd57
// Params 0
// Checksum 0x41bb3406, Offset: 0x2b40
// Size: 0xfe
function function_d1cabeee()
{
    level.player endon( #"death" );
    level endoncallback( &function_8604d848, #"hash_4c719d73886d1dee" );
    var_1623c030 = getent( "vip_guards_flank_encounter_trigger", "targetname" );
    
    if ( isdefined( var_1623c030 ) && isalive( level.var_fcdd86d8 ) )
    {
        var_1623c030 waittill( #"trigger" );
        
        /#
            hms_util::print( "<dev string:xae>" );
        #/
        
        var_cdad6c18 = spawner::simple_spawn( "vip_area_last_stand_guards_optional", &function_687b1b14 );
    }
}

// Namespace namespace_9162cd57/namespace_9162cd57
// Params 4
// Checksum 0x45ab94e, Offset: 0x2c48
// Size: 0x118
function function_803c0cb( var_5d361b57, var_6d6e8577, var_f5d1b9c4, var_5207b7a8 )
{
    spawner::waittill_ai_group_ai_count( var_5d361b57, var_6d6e8577 );
    var_dfcedc81 = spawner::get_ai_group_ai( var_5d361b57 );
    
    foreach ( ai in var_dfcedc81 )
    {
        if ( isalive( ai ) )
        {
            ai ai::set_behavior_attribute( var_5207b7a8, 1 );
            ai ai::force_goal( var_f5d1b9c4 );
        }
    }
}

// Namespace namespace_9162cd57/namespace_9162cd57
// Params 1
// Checksum 0x96aeb15c, Offset: 0x2d68
// Size: 0x140
function function_f4e023d2( a_ai_enemies )
{
    level.player endon( #"death" );
    var_1eea432a = getent( "player_hangback_trig", "targetname" );
    var_b4725f7b = getent( "vip_room_volume", "targetname" );
    
    while ( a_ai_enemies.size > 0 && isdefined( var_1eea432a ) )
    {
        if ( level.player istouching( var_1eea432a ) )
        {
            level thread function_803c0cb( "vip_area_guards", 3, level.player.origin, "sprint" );
        }
        else if ( !level.player istouching( var_1eea432a ) )
        {
            level thread function_803c0cb( "vip_area_guards", 3, var_b4725f7b, "sprint" );
        }
        
        wait 0.25;
    }
}

// Namespace namespace_9162cd57/namespace_9162cd57
// Params 0
// Checksum 0x69940499, Offset: 0x2eb0
// Size: 0x24
function function_165eaaa()
{
    self ai::set_behavior_attribute( "sprint", 1 );
}

// Namespace namespace_9162cd57/namespace_9162cd57
// Params 0
// Checksum 0x997fea18, Offset: 0x2ee0
// Size: 0x44
function function_687b1b14()
{
    self endon( #"death" );
    level waittill( #"hash_2e47b50259ab3bec" );
    self delete();
}

// Namespace namespace_9162cd57/namespace_9162cd57
// Params 2
// Checksum 0x697e6bc0, Offset: 0x2f30
// Size: 0x70
function function_5e5f8f2( ai_rider, var_9114191 )
{
    ai_rider waittill( #"death" );
    self vehicle::kill_rider( ai_rider );
    self turretcleartarget( var_9114191 );
    self notify( "turret_disabled" + var_9114191 );
}

// Namespace namespace_9162cd57/namespace_9162cd57
// Params 1
// Checksum 0x4cdac911, Offset: 0x2fa8
// Size: 0x114
function function_dda2c76e( var_bf6c8bb9 )
{
    level endon( #"death" );
    var_a274dfb9 = array::random( var_bf6c8bb9 );
    var_879729fe = array::random( var_bf6c8bb9 );
    
    while ( isdefined( var_a274dfb9 ) && isdefined( var_879729fe ) )
    {
        var_a274dfb9 hms_util::dialogue( "vox_cp_cbcr_01500_csm1_thelabkeepthema_7b" );
        var_879729fe hms_util::dialogue( "vox_cp_cbcr_01500_csm2_protectthelab_b2" );
        wait randomfloatrange( 0.5, 1.25 );
        var_a274dfb9 hms_util::dialogue( "vox_cp_cbcr_01500_csm1_ifwedonotstopth_4e" );
        var_879729fe hms_util::dialogue( "vox_cp_cbcr_01500_csm2_theresonlythree_75" );
        break;
    }
}

