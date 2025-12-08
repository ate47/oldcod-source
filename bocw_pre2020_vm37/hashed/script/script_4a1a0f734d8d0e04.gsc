#using script_1b9f100b85b7e21d;
#using script_237e957844a8197c;
#using script_6bb8615992324ccf;
#using script_7728aa611ab72ad9;
#using script_7cc5fb39b97494c4;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lockpick;
#using scripts\core_common\lui_shared;
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
#using scripts\cp\cp_nic_revolucion;
#using scripts\cp_common\breadcrumbs;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;

#namespace namespace_63e55f9b;

// Namespace namespace_63e55f9b/namespace_63e55f9b
// Params 1
// Checksum 0xcc164ca0, Offset: 0xf28
// Size: 0x11c
function start( *str_objective )
{
    level hms_util::function_ee1d1df6( "park", "Park", "park_floor_one_struct", "floor_one_park_initial_color" );
    level hms_util::function_ee1d1df6( "lazar", "Lazar", "lazar_floor_one_struct" );
    level hms_util::function_ee1d1df6( "adler", "Adler", "woods_floor_one_struct", undefined, undefined, level.var_4cdd9d45 );
    level hms_util::function_ee1d1df6( "mason", "Mason", "mason_floor_one_struct", undefined, undefined, level.var_7b391e49 );
    level hms_util::function_ee1d1df6( "woods", "Woods", "adler_floor_one_struct", undefined, undefined, level.var_bb9beed5 );
}

// Namespace namespace_63e55f9b/namespace_63e55f9b
// Params 2
// Checksum 0x557776e5, Offset: 0x1050
// Size: 0x75c
function main( *str_objective, *var_50cc0d4f )
{
    /#
        hms_util::print( "<dev string:x38>" );
    #/
    
    level.var_34c0ce7a = spawnstruct();
    level thread namespace_a789f8ae::function_6f16e46d();
    level thread namespace_a789f8ae::function_c9b603f3( "floor_one" );
    level thread namespace_a789f8ae::function_8d918610( "floor_one" );
    hms_util::function_eaa0342e( "floor_one_containment_warnings", "floor_one_containment_fails" );
    level thread function_efdab146();
    level thread function_1a77e8e2( "trig_floor_one_vignette", "floor_one_drive_by" );
    level thread function_4becb74d( "trig_cctv_vignette" );
    level thread function_d7a2bda8();
    level thread function_8269cbf();
    level thread function_fc9b8c7e();
    level thread function_67c96902();
    level thread function_d184f2a7();
    level thread function_c8f482ed();
    level function_bf23ef25();
    level thread function_82b2bc5e();
    savegame::checkpoint_save();
    
    if ( isdefined( level.lazar ) )
    {
        level.lazar ai::set_behavior_attribute( "demeanor", "combat" );
    }
    
    level flag::set( "flg_red_shirts_split" );
    
    if ( isdefined( level.woods ) )
    {
        level.woods colors::disable();
        level.woods.goalradius = 8;
        level.woods ai::set_behavior_attribute( "demeanor", "combat" );
        level.woods val::set( #"squad_2", "ignoreall", 1 );
        level.woods val::set( #"squad_2", "ignoreme", 1 );
    }
    
    if ( isdefined( level.mason ) )
    {
        level.mason colors::disable();
        level.mason.goalradius = 8;
        level.mason ai::set_behavior_attribute( "demeanor", "combat" );
        level.mason val::set( #"squad_2", "ignoreall", 1 );
        level.mason val::set( #"squad_2", "ignoreme", 1 );
    }
    
    if ( isdefined( level.adler ) )
    {
        level.adler colors::disable();
        level.adler.goalradius = 8;
        level.adler ai::set_behavior_attribute( "demeanor", "combat" );
        level.adler val::set( #"squad_2", "ignoreall", 1 );
        level.adler val::set( #"squad_2", "ignoreme", 1 );
    }
    
    if ( isdefined( level.redshirt_1 ) )
    {
        level.redshirt_1 colors::disable();
        var_6447d3b = getnode( "redshirt_1_floor_one_lobby_node", "targetname" );
        level.redshirt_1 setgoal( var_6447d3b );
        level.redshirt_1.goalradius = 8;
    }
    
    if ( isdefined( level.redshirt_2 ) )
    {
        level.redshirt_2 colors::disable();
        var_a66ed9fb = getnode( "redshirt_2_floor_one_lobby_node", "targetname" );
        level.redshirt_2 setgoal( var_a66ed9fb );
        level.redshirt_2.goalradius = 8;
    }
    
    if ( isdefined( level.redshirt_3 ) )
    {
        level.redshirt_3 colors::disable();
        var_5a731fbc = getnode( "redshirt_3_floor_one_lobby_node", "targetname" );
        level.redshirt_3 setgoal( var_5a731fbc );
        level.redshirt_3.goalradius = 8;
    }
    
    cctv_entrance_door_clip = getent( "cctv_entrance_door_clip", "targetname" );
    cctv_entrance_door_clip hide();
    cctv_entrance_door_clip notsolid();
    level flag::wait_till( "flg_delete_redshirts" );
    
    if ( isdefined( level.redshirt_1 ) )
    {
        level.redshirt_1 deletedelay();
    }
    
    if ( isdefined( level.redshirt_2 ) )
    {
        level.redshirt_2 deletedelay();
    }
    
    if ( isdefined( level.redshirt_3 ) )
    {
        level.redshirt_3 deletedelay();
    }
}

// Namespace namespace_63e55f9b/namespace_63e55f9b
// Params 4
// Checksum 0xda35732a, Offset: 0x17b8
// Size: 0x58
function cleanup( *str_objective, *var_50cc0d4f, *var_aa1a6455, *player )
{
    /#
        hms_util::print( "<dev string:x4e>" );
    #/
    
    level notify( #"hash_2fb605a6c7053f96" );
}

// Namespace namespace_63e55f9b/namespace_63e55f9b
// Params 0
// Checksum 0x13660477, Offset: 0x1818
// Size: 0xbc
function function_d7a2bda8()
{
    objectives::scripted( "obj_goto_security_room", undefined, #"hash_64b4beed7c03f4a2" );
    level breadcrumb::function_61037c6c( "bc_first_floor_objective" );
    level flag::wait_till( "flg_security_room_entered" );
    level breadcrumb::function_e261021e( "bc_first_floor_objective" );
    objectives::complete( "obj_goto_security_room" );
    skipto::function_4e3ab877( "1st_floor" );
}

// Namespace namespace_63e55f9b/namespace_63e55f9b
// Params 0
// Checksum 0x3b2fb9f6, Offset: 0x18e0
// Size: 0xa6
function function_67c96902()
{
    doors::open( "side_room_doors", "targetname" );
    flag::wait_till( "flg_right_courtyard_initial_spawn" );
    var_dc8e763c = spawner::simple_spawn_single( "fleeing_civ_mine_intro" );
    var_dc8e763c function_b441e79f();
    var_17df6d19 = spawner::simple_spawn( "fleeing_civ_lower_courtyard", &function_a2f76a8e );
}

// Namespace namespace_63e55f9b/namespace_63e55f9b
// Params 0
// Checksum 0x359903be, Offset: 0x1990
// Size: 0x224
function function_b441e79f()
{
    self endon( #"death" );
    self setgoal( self.origin );
    self val::set( #"fleeing_civ", "ignoreall", 1 );
    
    while ( true )
    {
        within_fov = util::within_fov( level.player getplayercamerapos(), level.player getplayerangles(), self geteye(), cos( 35 ) );
        var_19433220 = sighttracepassed( level.player getplayercamerapos(), self geteye(), 0, undefined );
        
        if ( within_fov == 1 && var_19433220 == 1 )
        {
            /#
                hms_util::print( "<dev string:x62>" );
            #/
            
            break;
        }
        
        waitframe( 1 );
    }
    
    self ai::set_behavior_attribute( #"_civ_mode", "run" );
    self thread spawner::go_to_struct( struct::get( "mine_civ_goal", "targetname" ) );
    self waittill( #"reached_path_end" );
    radiusdamage( self.origin, 150, 5, 1 );
    wait 1;
    savegame::checkpoint_save();
}

// Namespace namespace_63e55f9b/namespace_63e55f9b
// Params 0
// Checksum 0xf85dbf1b, Offset: 0x1bc0
// Size: 0x6c
function function_a2f76a8e()
{
    self endon( #"death" );
    self ai::set_behavior_attribute( #"_civ_mode", "run" );
    self waittill( #"reached_path_end" );
    self deletedelay();
}

// Namespace namespace_63e55f9b/namespace_63e55f9b
// Params 0
// Checksum 0x49434400, Offset: 0x1c38
// Size: 0xa4
function function_bf23ef25()
{
    namespace_307260b8::function_2b6287f4( "gazebo_color_group" );
    level.lazar setdesiredspeed( "shuffle" );
    level.park setdesiredspeed( "shuffle" );
    wait 1;
    var_5a14aaf0 = spawner::simple_spawn( "right_courtyard_exit_enemies" );
    level flag::set( "flg_ambush_spawned" );
}

// Namespace namespace_63e55f9b/namespace_63e55f9b
// Params 0
// Checksum 0xa063fae6, Offset: 0x1ce8
// Size: 0x13c
function function_fc9b8c7e()
{
    t_spawn = getent( "right_1_enemy_trigger", "targetname" );
    t_spawn waittill( #"trigger" );
    level.park.grenadeammo = 5;
    level.lazar.grenadeammo = 5;
    level.park.script_accuracy = 0.3;
    level.lazar.script_accuracy = 0.3;
    level waittill( #"hash_20b372100c1d49b2" );
    wait 0.25;
    var_12576417 = spawner::simple_spawn( "courtyard_exit_spawner" );
    ai::waittill_dead_or_dying( var_12576417, 1, 15 );
    level flag::set( "flg_banter_vo" );
    array::thread_all( var_12576417, &function_f46ca8fb );
}

// Namespace namespace_63e55f9b/namespace_63e55f9b
// Params 0
// Checksum 0xf85d9dfa, Offset: 0x1e30
// Size: 0x2c
function function_12deeb75()
{
    self ai::set_behavior_attribute( "demeanor", "cqb" );
}

// Namespace namespace_63e55f9b/namespace_63e55f9b
// Params 0
// Checksum 0xd171515a, Offset: 0x1e68
// Size: 0x74
function function_eac97f7a()
{
    self endon( #"death" );
    self waittill( #"damage", #"bulletwhizby" );
    wait randomfloatrange( 0.5, 1.5 );
    self function_f46ca8fb( 250 );
}

// Namespace namespace_63e55f9b/namespace_63e55f9b
// Params 0
// Checksum 0x73349419, Offset: 0x1ee8
// Size: 0x1ec
function function_c1ed8300()
{
    level.player endon( #"death" );
    level flag::wait_till( "flg_right_courtyard_initial_spawn" );
    savegame::checkpoint_save();
    var_864dbd75 = spawner::simple_spawn( "right_courtyard_initial_enemies" );
    t_spawn = getent( "first_floor_allies_trigger", "targetname" );
    t_spawn waittill( #"trigger" );
    var_727580f3 = spawner::simple_spawn( "right_courtyard_enemy_spawner" );
    var_425b2d39 = arraycombine( var_864dbd75, var_727580f3 );
    ai::waittill_dead_or_dying( var_425b2d39, 3, 45 );
    function_1eaaceab( var_425b2d39 );
    var_425b2d39 = arraysortclosest( var_425b2d39, level.player.origin );
    
    for ( i = 0; i < var_425b2d39.size ; i++ )
    {
        if ( i <= 2 )
        {
            var_425b2d39[ i ] thread function_f46ca8fb();
            continue;
        }
        
        var_425b2d39[ i ] thread function_1bdb683( "courtyard_fountain_fallback" );
    }
    
    util::delay( 7.5, undefined, &trigger::use, "gazebo_color_group" );
}

// Namespace namespace_63e55f9b/namespace_63e55f9b
// Params 2
// Checksum 0x94ee75ba, Offset: 0x20e0
// Size: 0x94
function function_f46ca8fb( var_4b433742 = 500, var_97055d22 = 1 )
{
    self endon( #"death" );
    
    if ( var_97055d22 )
    {
        wait randomfloatrange( 0.5, 2.5 );
    }
    
    self setgoal( level.player, 0, var_4b433742 );
}

// Namespace namespace_63e55f9b/namespace_63e55f9b
// Params 3
// Checksum 0x4f6a45f2, Offset: 0x2180
// Size: 0xe4
function function_1bdb683( var_9608b240, min_delay = 2.5, max_delay = 5 )
{
    self endon( #"death" );
    wait randomfloatrange( min_delay, max_delay );
    self ai::set_pacifist( 1 );
    self ai::set_goal( var_9608b240, "targetname", 1 );
    self waittilltimeout( 3, #"goal" );
    self ai::set_pacifist( 0 );
}

// Namespace namespace_63e55f9b/namespace_63e55f9b
// Params 0
// Checksum 0x854da6a9, Offset: 0x2270
// Size: 0x16e
function function_1eb3b7ac()
{
    level endon( #"hash_50cbe4c0247f66ca" );
    var_4a3daa0b = struct::get( "balcony_drone_look_at", "targetname" );
    
    while ( true )
    {
        within_fov = util::within_fov( level.player getplayercamerapos(), level.player getplayerangles(), var_4a3daa0b.origin, cos( 35 ) );
        var_19433220 = sighttracepassed( level.player getplayercamerapos(), var_4a3daa0b.origin, 0, undefined );
        
        if ( within_fov == 1 && var_19433220 == 1 )
        {
            /#
                hms_util::print( "<dev string:x71>" );
            #/
            
            break;
        }
        
        waitframe( 1 );
    }
    
    var_44756054 = spawner::simple_spawn( "courtyard_balcony_drone" );
}

// Namespace namespace_63e55f9b/namespace_63e55f9b
// Params 0
// Checksum 0x32ef1be6, Offset: 0x23e8
// Size: 0x4e
function function_d184f2a7()
{
    namespace_307260b8::function_2b6287f4( "panic_room_encounter_trig" );
    var_3665bea = spawner::simple_spawn( "panic_room_encounter_enemies", &function_eac97f7a );
}

// Namespace namespace_63e55f9b/namespace_63e55f9b
// Params 0
// Checksum 0xa7b630c4, Offset: 0x2440
// Size: 0x35c
function function_c8f482ed()
{
    namespace_307260b8::function_2b6287f4( "panic_room_encounter_trig" );
    var_c228b588 = spawner::simple_spawn_single( "panic_room_guard" );
    var_c228b588.grenadeammo = 0;
    var_b543969b = struct::get( "panic_room_lookat", "targetname" );
    
    while ( true )
    {
        within_fov = util::within_fov( level.player getplayercamerapos(), level.player getplayerangles(), var_b543969b.origin, cos( 35 ) );
        var_19433220 = sighttracepassed( level.player getplayercamerapos(), var_b543969b.origin, 0, undefined );
        
        if ( within_fov == 1 && var_19433220 == 1 )
        {
            /#
                hms_util::print( "<dev string:x88>" );
            #/
            
            break;
        }
        
        waitframe( 1 );
    }
    
    var_fc6c4527 = getent( "panic_room_door", "targetname" );
    var_3b7aad05 = struct::get( "panic_room_door_moveto_closed", "targetname" );
    var_fc6c4527 moveto( var_3b7aad05.origin, 3.5 );
    var_50f5aa55 = struct::get( "panic_room_interact", "targetname" );
    var_35c66d32 = util::spawn_model( "tag_origin", var_50f5aa55.origin, var_50f5aa55.angles );
    var_35c66d32 util::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), #"hash_77f2f4b5474df6a1", 64 );
    var_35c66d32 waittill( #"trigger" );
    var_72b63413 = struct::get( "panic_room_door_moveto_open", "targetname" );
    var_fc6c4527 moveto( var_72b63413.origin, 3.5 );
    wait 1.5;
    
    if ( isalive( var_c228b588 ) )
    {
        var_c228b588 setgoal( level.player, 1, 200 );
        var_c228b588 hms_util::dialogue( "vox_cp_cbcr_01200_csm2_ididntsignupfor_ad" );
    }
}

// Namespace namespace_63e55f9b/namespace_63e55f9b
// Params 0
// Checksum 0xe55ec5cc, Offset: 0x27a8
// Size: 0xf4
function function_575c09a3()
{
    self endon( #"death" );
    rev_sniper_origin = struct::get( "rev_sniper_origin", "targetname" );
    
    if ( isdefined( self.script_noteworthy ) )
    {
        wait 2.5;
        eye_pos = self geteye();
        
        if ( !level flag::get( "flag_contras_sniped" ) )
        {
            magicbullet( getweapon( "lmg_accurate_t9" ), rev_sniper_origin.origin, eye_pos );
            level flag::set( "flag_contras_sniped" );
        }
    }
}

// Namespace namespace_63e55f9b/namespace_63e55f9b
// Params 0
// Checksum 0xbe95afab, Offset: 0x28a8
// Size: 0x600
function function_82b2bc5e()
{
    namespace_307260b8::function_2b6287f4( "spawn_balcony_rpg_enemy" );
    level.lazar setdesiredspeed( "jog" );
    level.park setdesiredspeed( "jog" );
    level flag::set( "flg_rpg_scripted" );
    var_cd37abff = spawner::simple_spawn( "floor_two_balcony_rpg", &function_d210173f, "balcony_rpg_inital_pos", "balcony_rpg_target", "balcony_rpg_volume", "flg_balcony_rpg_fire" );
    var_decc34ff = spawner::simple_spawn( "left_courtyard_balcony_enemies" );
    var_a94b43b3 = arraycombine( var_decc34ff, var_cd37abff );
    level notify( #"hash_50cbe4c0247f66ca" );
    level thread function_a02e8212( var_a94b43b3 );
    level thread function_25e8f9d6();
    level flag::wait_till( "flg_first_floor_2nd_courtyard_reinforcements" );
    level notify( #"hash_4f2daaca49b239c4" );
    var_bb9fa614 = spawner::simple_spawn( "left_courtyard_enemy_spawner" );
    var_34a2caa8 = spawner::simple_spawn( "left_3_enemy_spawner" );
    level thread function_2b154e4a( var_34a2caa8, 2 );
    level flag::wait_till( "flg_first_floor_reinforce_cctv_door" );
    id = objectives::function_285e460( "obj_goto_security_room" );
    thread objectives_ui::function_f3ac479c( id );
    level.player thread objectives_ui::show_objectives();
    var_62a189d1 = spawner::simple_spawn( "left_courtyard_reinforce_door_spawner", &function_f46ca8fb, 250, 0 );
    var_a94b43b3 = arraycombine( var_a94b43b3, var_62a189d1 );
    level flag::wait_till( "flg_vig_first_floor_door_kick" );
    var_4a3daa0b = struct::get( "first_floor_cctv_door_look_at", "targetname" );
    
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
    
    function_1eaaceab( var_a94b43b3 );
    
    foreach ( ai in var_a94b43b3 )
    {
        ai delete();
    }
    
    var_7bacf73f = level spawner::simple_spawn( "cctv_guards" );
    a_actors = [];
    a_actors[ #"actor 1" ] = var_7bacf73f[ 0 ];
    a_actors[ #"actor 2" ] = var_7bacf73f[ 1 ];
    a_actors[ #"actor 1" ] thread function_c4edad62();
    a_actors[ #"actor 2" ] thread function_34c5b067();
    level thread scene::play( "cctv_door_kick_scene", "targetname", a_actors );
    a_actors[ #"actor 1" ] waittill( #"hash_553184e6c2383c0d" );
    doors::open( "cctv_entrance_door_01", "targetname", a_actors[ #"actor 1" ] );
    thread function_40626d6c();
    ai::waittill_dead_or_dying( var_7bacf73f, var_7bacf73f.size );
    wait 0.2;
    trigger::use( "allies_enter_cctv_room", "targetname" );
    level notify( #"hash_2217c60a57d6c9a3" );
}

// Namespace namespace_63e55f9b/namespace_63e55f9b
// Params 1
// Checksum 0x63dd8be0, Offset: 0x2eb0
// Size: 0x5c
function function_a02e8212( a_ai_enemies )
{
    level endon( #"hash_4f2daaca49b239c4" );
    ai::waittill_dead_or_dying( a_ai_enemies, 2 );
    wait 1.5;
    flag::set( "flg_first_floor_2nd_courtyard_reinforcements" );
}

// Namespace namespace_63e55f9b/namespace_63e55f9b
// Params 0
// Checksum 0xc501163a, Offset: 0x2f18
// Size: 0x4c
function function_25e8f9d6()
{
    level endon( #"hash_4f2daaca49b239c4" );
    namespace_307260b8::function_2b6287f4( "left_courtyard_fight_trigger" );
    flag::set( "flg_first_floor_2nd_courtyard_reinforcements" );
}

// Namespace namespace_63e55f9b/namespace_63e55f9b
// Params 0
// Checksum 0x9397b0b6, Offset: 0x2f70
// Size: 0xac
function function_40626d6c()
{
    posent = getent( "cctv_soldier_slide_phys_loc", "targetname" );
    var_39cfa734 = getent( "cctv_soldier_slide_phys_loc_2", "targetname" );
    physicsexplosionsphere( posent.origin, 90, 0, 0.16 );
    wait 1;
    physicsexplosionsphere( var_39cfa734.origin, 90, 0, 0.16 );
}

// Namespace namespace_63e55f9b/namespace_63e55f9b
// Params 4
// Checksum 0x8c1fc3be, Offset: 0x3028
// Size: 0x1b4
function function_d210173f( var_3c97f36d, var_5442a320, var_f4145afc, var_695971f7 )
{
    self endon( #"death" );
    self setdesiredspeed( "sprint" );
    self val::set( #"hash_722c2bad015d62bc", "ignoreall", 1 );
    self spawner::go_to_struct( struct::get( var_3c97f36d, "targetname" ) );
    self waittill( #"goal" );
    
    if ( isdefined( var_695971f7 ) )
    {
        level flag::wait_till( var_695971f7 );
    }
    
    self thread ai::shoot_at_target( "normal", getent( var_5442a320, "targetname" ), "tag_origin", 10, 100, 1 );
    self waittill( #"shoot" );
    self ai::stop_shoot_at_target();
    self setgoal( getent( var_f4145afc, "targetname" ), 1 );
    self val::set( #"hash_722c2bad015d62bc", "ignoreall", 0 );
}

// Namespace namespace_63e55f9b/namespace_63e55f9b
// Params 0
// Checksum 0x95bf11aa, Offset: 0x31e8
// Size: 0x8c
function function_c4edad62()
{
    self endon( #"death" );
    self waittill( #"hash_542161c43bda2568" );
    var_c0a56818 = getnode( "post_door_kick_goal_node", "targetname" );
    self setgoal( var_c0a56818 );
    self getenemyinfo( level.player );
}

// Namespace namespace_63e55f9b/namespace_63e55f9b
// Params 0
// Checksum 0xb41e4314, Offset: 0x3280
// Size: 0x54
function function_34c5b067()
{
    self endon( #"death" );
    self waittill( #"hash_542161c43bda2568" );
    self setgoal( level.player, 1, 150 );
}

// Namespace namespace_63e55f9b/namespace_63e55f9b
// Params 2
// Checksum 0x9592669b, Offset: 0x32e0
// Size: 0x64
function function_2b154e4a( ai_array, killcount )
{
    ai::waittill_dead_or_dying( ai_array, killcount );
    function_1eaaceab( ai_array );
    array::thread_all( ai_array, &function_f46ca8fb );
}

// Namespace namespace_63e55f9b/namespace_63e55f9b
// Params 0
// Checksum 0x879dbef6, Offset: 0x3350
// Size: 0x21a
function function_2bea1e33()
{
    level.player endon( #"death" );
    level flag::wait_till( "flg_vo_scientist_floor_1" );
    var_4a3daa0b = struct::get( "floor_one_dead_bodies", "targetname" );
    
    while ( true )
    {
        within_fov = util::within_fov( level.player getplayercamerapos(), level.player getplayerangles(), var_4a3daa0b.origin, cos( 45 ) );
        
        if ( within_fov == 1 )
        {
            break;
        }
        
        waitframe( 1 );
    }
    
    var_16bf64d2 = randomintrangeinclusive( 0, 1 );
    
    switch ( var_16bf64d2 )
    {
        case 0:
            level.park hms_util::dialogue( "vox_cp_cbcr_02400_park_thatbloodisfres_23" );
            level.lazar hms_util::dialogue( "vox_cp_cbcr_02400_lazr_wedidntshootthe_33" );
            level.park hms_util::dialogue( "vox_cp_cbcr_02400_park_nosomeonestryin_3b" );
            break;
        case 1:
            level.lazar hms_util::dialogue( "vox_cp_cbcr_02400_lazr_whatdthesepoorb_b2" );
            level.park hms_util::dialogue( "vox_cp_cbcr_02400_park_theyfinishedthe_c9" );
            level.lazar hms_util::dialogue( "vox_cp_cbcr_02400_lazr_hellofareward_ce" );
            break;
    }
}

// Namespace namespace_63e55f9b/namespace_63e55f9b
// Params 0
// Checksum 0xc63d0972, Offset: 0x3578
// Size: 0x28c
function function_8269cbf()
{
    level.player endon( #"death" );
    level thread function_da0bfdde();
    level flag::wait_till( "flag_woods_first_floor_intro_vo" );
    level.adler hms_util::dialogue( "vox_cp_cbcr_01300_adlr_parktakeyourtea_3d" );
    level.adler hms_util::dialogue( "vox_cp_cbcr_01300_park_copy_c9" );
    wait 0.25;
    level.park hms_util::dialogue( "vox_cp_cbcr_01300_park_thereareclosedc_9b" );
    level.park hms_util::dialogue( "vox_cp_cbcr_01300_park_wecouldusethemt_22" );
    level.lazar hms_util::dialogue( "vox_cp_cbcr_01300_lazr_mmmmsmartandbea_69" );
    level thread function_2bea1e33();
    level flag::wait_till( "flg_banter_vo" );
    var_18f35bb2 = struct::get( "first_floor_woods_vo", "targetname" );
    var_ab0186f6 = spawner::get_ai_group_ai( "table_room_guys" );
    ai::waittill_dead( var_ab0186f6, 0 );
    wait randomfloatrange( 4, 6 );
    level.park hms_util::dialogue( "vox_cp_cbcr_02400_park_itsquietallofas_13" );
    level.park hms_util::dialogue( "vox_cp_cbcr_02400_park_staysharp_0d" );
    level flag::wait_till( "flg_ambush_spawned" );
    level.park hms_util::dialogue( "vox_cp_cbcr_02400_park_ambush_81" );
    level.lazar hms_util::dialogue( "vox_cp_cbcr_02400_lazr_getdown_19" );
    level flag::wait_till( "flg_rpg_scripted" );
    level.park hms_util::dialogue( "vox_cp_cbcr_02400_park_rpgonthebalcony_71" );
}

// Namespace namespace_63e55f9b/namespace_63e55f9b
// Params 0
// Checksum 0xa00bf6ff, Offset: 0x3810
// Size: 0x13c
function function_da0bfdde()
{
    level.player endon( #"death" );
    var_81f9e5e = getentarray( "t_searching", "targetname" );
    var_f5488cfa = array( "vox_cp_cbcr_01300_park_thecameracontro_06", "vox_cp_cbcr_01300_park_thisisntit_9c", "vox_cp_cbcr_01300_park_keeplooking_c6", "vox_cp_cbcr_01300_park_shitwhereisthat_ca" );
    
    while ( !flag::get( "flg_cctv_vo_wonder_cables" ) )
    {
        foreach ( trig in var_81f9e5e )
        {
            trig waittill( #"trigger" );
            level thread function_8880c1e3( var_f5488cfa );
        }
        
        wait 0.1;
    }
}

// Namespace namespace_63e55f9b/namespace_63e55f9b
// Params 1
// Checksum 0x558df0fd, Offset: 0x3958
// Size: 0x64
function function_8880c1e3( var_305d3956 )
{
    var_16bf64d2 = randomintrangeinclusive( 0, 3 );
    level.park hms_util::dialogue( var_305d3956[ var_16bf64d2 ] );
    array::remove_index( var_305d3956, var_16bf64d2 );
}

// Namespace namespace_63e55f9b/namespace_63e55f9b
// Params 0
// Checksum 0x66f49534, Offset: 0x39c8
// Size: 0x7c
function function_efdab146()
{
    var_aa87baf1 = getent( "pallet_destruction_trigger", "targetname" );
    var_aa87baf1 trigger::wait_till();
    scene::play_from_time( "p9_fxanim_cp_revolucion_pallet_destruction_bundle", "play" );
    scene::function_f81475ae( "p9_fxanim_cp_revolucion_pallet_destruction_bundle" );
}

// Namespace namespace_63e55f9b/namespace_63e55f9b
// Params 2
// Checksum 0x442140ef, Offset: 0x3a50
// Size: 0x8e
function function_1a77e8e2( t_trig, var_c68d51a8 )
{
    level.player endon( #"death" );
    var_9e332b5a = getent( t_trig, "targetname" );
    var_9e332b5a waittill( #"trigger" );
    veh = vehicle::simple_spawn_and_drive( var_c68d51a8 );
}

// Namespace namespace_63e55f9b/namespace_63e55f9b
// Params 1
// Checksum 0x5b206b0a, Offset: 0x3ae8
// Size: 0x27e
function function_4becb74d( t_trig )
{
    level.player endon( #"death" );
    var_1aaaab19 = getent( t_trig, "targetname" );
    var_1c12e0b4 = struct::get( "vol_goal" );
    var_1aaaab19 waittill( #"trigger" );
    var_d293bb3b = randomintrangeinclusive( 0, 2 );
    wait randomfloatrange( 0.25, 1.25 );
    
    switch ( var_d293bb3b )
    {
        case 0:
            veh = vehicle::simple_spawn_and_drive( "cctv_drive_loop" );
            break;
        case 1:
            veh = vehicle::simple_spawn_and_drive( "cctv_drive_loop_2" );
            wait randomfloatrange( 0.25, 1.25 );
            var_c26707f = vehicle::simple_spawn_and_drive( "cctv_drive_loop_2_2" );
            break;
        case 2:
            wait randomfloatrange( 0.25, 1.25 );
            veh = vehicle::simple_spawn_and_drive( "cctv_drive_drop_off" );
            wait randomfloatrange( 0.25, 1.25 );
            var_c26707f = vehicle::simple_spawn_and_drive( "cctv_drive_drop_off_2" );
            wait randomfloatrange( 0.25, 1.25 );
            var_8c12f056 = vehicle::simple_spawn_and_drive( "cctv_drive_drop_off_3" );
            break;
    }
    
    wait randomfloatrange( 2, 4.25 );
    a_ai = spawner::simple_spawn( "drone_runner_guys" );
}

