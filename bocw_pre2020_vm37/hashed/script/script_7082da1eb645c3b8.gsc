#using script_155b17ff7c8b315c;
#using script_4134e1e2e7684c4c;
#using script_446752c03c555e16;
#using script_57d05cf093ffba5c;
#using script_77d064824b2c820c;
#using script_97b74052c477c23;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp_common\dialog_tree;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;

#namespace namespace_be0b7a4;

// Namespace namespace_be0b7a4/namespace_b240b9c7
// Params 1
// Checksum 0x774ba7cc, Offset: 0xf60
// Size: 0x7c
function function_cc475eed( *str_objective )
{
    namespace_fc3e8cb::function_2987fd4c( "s_teleport_woods_elevator", 0, 0 );
    level thread namespace_fc3e8cb::function_869f213d();
    level flag::set( "flg_elevator_all_enemies_dead" );
    level thread namespace_fc3e8cb::elevator_descend( 1 );
}

// Namespace namespace_be0b7a4/namespace_b240b9c7
// Params 2
// Checksum 0x37617219, Offset: 0xfe8
// Size: 0x124
function elevator_main( str_objective, *var_50cc0d4f )
{
    /#
        namespace_fc3e8cb::function_44a6fc04( var_50cc0d4f );
    #/
    
    level thread function_2023f5();
    level thread function_48a28239();
    level thread namespace_4bd68414::function_da4cb613();
    level thread function_c73d21cc();
    level thread function_fa117b21();
    level thread namespace_fc3e8cb::function_bd7f6a68();
    level thread function_46490d4e();
    doors::function_f35467ac( "e_terminal_entrance_door" );
    level flag::wait_till( "flg_elevator_end" );
    skipto::function_4e3ab877( var_50cc0d4f );
}

// Namespace namespace_be0b7a4/namespace_b240b9c7
// Params 4
// Checksum 0xb52f43f8, Offset: 0x1118
// Size: 0x114
function function_987cb73( *str_objective, var_50cc0d4f, *var_aa1a6455, *player )
{
    if ( player )
    {
        function_46490d4e( 1 );
    }
    
    if ( isdefined( level.var_28f2e8d6 ) )
    {
        foreach ( emitter in level.var_28f2e8d6 )
        {
            if ( isarray( emitter ) )
            {
                array::notify_all( emitter, "snd_emitter_stop" );
                continue;
            }
            
            emitter notify( #"snd_emitter_stop" );
        }
    }
}

// Namespace namespace_be0b7a4/namespace_b240b9c7
// Params 0
// Checksum 0x435c4f6f, Offset: 0x1238
// Size: 0x26c
function function_2023f5()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    
    if ( level flag::get( "flg_elevator_player_interact" ) == 0 )
    {
        s_obj_elevator_interact = struct::get( "s_obj_elevator_interact", "targetname" );
        
        if ( !isdefined( objectives::function_285e460( "obj_elevator_interact" ) ) )
        {
            objectives::function_4eb5c04a( "obj_elevator_interact", s_obj_elevator_interact.origin, #"hash_233d6343fbeb9550" );
        }
        else
        {
            objectives::update_position( "obj_elevator_interact", s_obj_elevator_interact.origin );
            objectives::convert( #"obj_elevator_interact", #"hash_6d05b1cec06f98c" );
        }
        
        id = objectives::function_285e460( "obj_elevator_interact" );
        thread objectives_ui::function_f3ac479c( id );
        level.player thread objectives_ui::show_objectives();
        level flag::wait_till( "flg_elevator_player_interact" );
        objectives::complete( "obj_elevator_interact" );
    }
    
    level flag::wait_till( "flg_control_tower_elevator_at_top" );
    var_d248d2d4 = struct::get( "s_obj_elevator_enter_command_center", "targetname" );
    objectives::goto( "obj_elevator_enter_command_center", var_d248d2d4.origin, #"hash_4a3bd5687b30613a" );
    level flag::wait_till( "flg_elevator_end" );
    objectives::complete( "obj_elevator_enter_command_center" );
}

// Namespace namespace_be0b7a4/namespace_b240b9c7
// Params 0
// Checksum 0xb25c2771, Offset: 0x14b0
// Size: 0x694
function function_c73d21cc()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    var_d5535d9a = getvehiclearray( "control_tower_elevator", "targetname" )[ 0 ];
    var_6f5ab79e = getnode( "nd_woods_elevator_exposed", "targetname" );
    var_63d2d7ec = level flag::wait_till_any( [ "flg_elevator_all_enemies_dead", "flg_elevator_player_interact" ] );
    level.woods colors::disable();
    level.woods clearenemy();
    level.woods val::set( #"woods_elevator", "ignoreall", 1 );
    level.woods val::set( #"woods_elevator", "ignoreme", 1 );
    level.woods ai::set_behavior_attribute( "vignette_mode", "fast" );
    level.woods.battlechatterallowed = 0;
    
    if ( var_63d2d7ec._notify === #"flg_elevator_all_enemies_dead" )
    {
        level thread namespace_4bd68414::function_ffca973f();
        level thread function_204f03cb();
        level flag::wait_till( "flg_elevator_player_interact" );
        level scene::stop( "scene_amk_5050_woods_elevator" );
        level.woods lookatentity();
    }
    
    level.woods forceteleport( var_6f5ab79e.origin + ( 0, 0, 5 ), var_6f5ab79e.angles );
    waitframe( 1 );
    level.woods linkto( var_d5535d9a );
    level flag::set( "flg_control_tower_woods_on_elevator" );
    s_elevator_woods_poi = struct::get( "s_elevator_woods_poi", "targetname" );
    level.woods ai::poi_enable( 1, s_elevator_woods_poi, 0 );
    level thread namespace_4bd68414::function_55a0cc3d();
    level thread scene::play( "scene_amk_5050_woods_elevator", "exit" );
    level flag::wait_till( "flg_control_tower_elevator_near_top" );
    level thread namespace_fc3e8cb::function_5c5b6ea7( "nd_woods_elevator_cover" );
    snd::client_msg( "flg_control_tower_elevator_at_top" );
    level flag::wait_till( "flg_control_tower_elevator_at_top" );
    level thread namespace_4bd68414::function_13e6b28c();
    level.woods ai::set_behavior_attribute( "demeanor", "combat" );
    level.woods.battlechatterallowed = 1;
    level.woods unlink();
    level.woods val::set( #"woods_elevator", "ignoreall", 0 );
    level.woods val::set( #"woods_elevator", "ignoreme", 0 );
    level.woods ai::poi_enable( 0 );
    level namespace_fc3e8cb::function_5c5b6ea7( "nd_command_center_woods_start" );
    level.woods function_9ae1c50();
    level.woods ai::set_behavior_attribute( "vignette_mode", "off" );
    level flag::wait_till( "flg_terminal_leave_elevator" );
    level.woods clearforcedgoal();
    level.woods colors::set_force_color( "blue" );
    level flag::wait_till( "flg_elevator_top_enemies_dead" );
    level.woods function_678d90a1( 0.001001 );
    level.woods colors::disable();
    level.woods ai::set_behavior_attribute( "disablelean", 1 );
    level.woods ai::set_behavior_attribute( "vignette_mode", "fast" );
    level.woods.battlechatterallowed = 0;
    level namespace_fc3e8cb::function_5c5b6ea7( "nd_command_center_woods_end" );
    level thread namespace_4bd68414::function_24aa0543();
    level.woods function_94575fdf();
}

// Namespace namespace_be0b7a4/namespace_b240b9c7
// Params 0
// Checksum 0x956fe70f, Offset: 0x1b50
// Size: 0xa4
function function_204f03cb()
{
    level endon( #"flg_elevator_player_interact" );
    level scene::play( "scene_amk_5050_woods_elevator", "enter" );
    level thread scene::play( "scene_amk_5050_woods_elevator", "idle" );
    level.woods lookatentity( level.player );
    level flag::set( "flg_control_tower_woods_on_elevator" );
}

// Namespace namespace_be0b7a4/namespace_b240b9c7
// Params 0
// Checksum 0x5bded2c, Offset: 0x1c00
// Size: 0x300
function function_fa117b21()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level flag::wait_till( "flg_elevator_player_interact" );
    println( "<dev string:x38>" );
    var_78d2e059 = spawner::simple_spawn( "ai_enemy_elevator_top", &function_fef9a6fd );
    level thread namespace_fc3e8cb::function_85939627( var_78d2e059, "flg_elevator_top_enemies_one_dead", 1 );
    level thread namespace_fc3e8cb::function_940ffdb0( "flg_elevator_fallback", var_78d2e059, "vol_elevator_back" );
    level flag::wait_till( "flg_control_tower_elevator_at_top" );
    level flag::wait_till_any_timeout( 10, [ "flg_terminal_approaching_command_center", "flg_elevator_top_enemies_one_dead" ] );
    level thread function_51c78e84();
    var_3065736e = spawner::simple_spawn( "ai_enemy_elevator_top_wave_2", &function_fef9a6fd );
    level thread namespace_fc3e8cb::function_85939627( var_3065736e, "flg_elevator_top_wave_2_enemies_one_dead", 1 );
    var_720cf56 = arraycombine( var_78d2e059, var_3065736e );
    level thread namespace_fc3e8cb::function_85939627( var_720cf56, "flg_elevator_top_enemies_dead", var_720cf56.size );
    level flag::wait_till_all( [ "flg_elevator_top_enemies_one_dead", "flg_elevator_top_wave_2_enemies_one_dead" ] );
    function_1eaaceab( var_3065736e );
    
    foreach ( ai in var_3065736e )
    {
        ai.favoriteenemy = level.player;
        ai setgoal( level.player );
    }
}

// Namespace namespace_be0b7a4/namespace_b240b9c7
// Params 0
// Checksum 0x45d9c85e, Offset: 0x1f08
// Size: 0x174
function function_51c78e84()
{
    e_terminal_entrance_door = getent( "e_terminal_entrance_door", "targetname" );
    e_terminal_entrance_door_clip = getent( "e_terminal_entrance_door_clip", "targetname" );
    e_terminal_entrance_door_org = getent( "e_terminal_entrance_door_org", "targetname" );
    e_terminal_entrance_door linkto( e_terminal_entrance_door_org );
    e_terminal_entrance_door_clip linkto( e_terminal_entrance_door_org );
    e_terminal_entrance_door_clip disconnectpaths();
    var_9d14bbbd = ( e_terminal_entrance_door_org.angles[ 0 ], e_terminal_entrance_door_org.angles[ 1 ] - 150, e_terminal_entrance_door_org.angles[ 2 ] );
    e_terminal_entrance_door_org rotateto( var_9d14bbbd, 0.5, 0.1, 0.2 );
    e_terminal_entrance_door flag::set( "door_open" );
    snd::client_targetname( e_terminal_entrance_door_org, "evt_ai_open_terminal_door_audio" );
}

// Namespace namespace_be0b7a4/namespace_b240b9c7
// Params 0
// Checksum 0x372c79ad, Offset: 0x2088
// Size: 0x1e4
function function_74ebff30()
{
    e_terminal_entrance_door = getent( "e_terminal_entrance_door", "targetname" );
    e_terminal_entrance_door_clip = getent( "e_terminal_entrance_door_clip", "targetname" );
    e_terminal_entrance_door_org = getent( "e_terminal_entrance_door_org", "targetname" );
    
    if ( e_terminal_entrance_door flag::get( "door_open" ) == 1 )
    {
        e_terminal_entrance_door linkto( e_terminal_entrance_door_org );
        e_terminal_entrance_door_clip linkto( e_terminal_entrance_door_org );
        e_terminal_entrance_door_clip disconnectpaths();
        var_cba21548 = ( e_terminal_entrance_door_org.angles[ 0 ], e_terminal_entrance_door_org.angles[ 1 ] + 150, e_terminal_entrance_door_org.angles[ 2 ] );
        e_terminal_entrance_door_org rotateto( var_cba21548, 0.5, 0.1, 0.2 );
        e_terminal_entrance_door flag::clear( "door_open" );
    }
    
    level flag::wait_till( "flg_facades_start" );
    e_terminal_entrance_door delete();
    e_terminal_entrance_door_org delete();
    e_terminal_entrance_door_clip delete();
}

// Namespace namespace_be0b7a4/namespace_b240b9c7
// Params 0
// Checksum 0xff01ab7d, Offset: 0x2278
// Size: 0x11c
function function_fef9a6fd()
{
    self endon( #"death" );
    self.grenadeammo = 0;
    self ai::set_pacifist( 1 );
    
    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "ai_enemy_elevator_top_booth" )
    {
        level flag::wait_till( "flg_control_tower_elevator_at_top" );
        self ai::set_pacifist( 0 );
        self waittill( #"damage" );
        level flag::set( "flg_elevator_top_enemies_take_damage" );
        return;
    }
    
    level flag::wait_till_any_timeout( 10, [ "flg_terminal_leave_elevator", "flg_elevator_top_enemies_one_dead" ] );
    self ai::set_pacifist( 0 );
}

// Namespace namespace_be0b7a4/namespace_b240b9c7
// Params 1, eflags: 0x4
// Checksum 0x8930d1d6, Offset: 0x23a0
// Size: 0x19c
function private function_46490d4e( var_e563178a = 0 )
{
    if ( !var_e563178a )
    {
        level flag::wait_till( "flg_terminal_scenes_init" );
    }
    
    level scene::init( "scene_amk_6010_tml_server" );
    a_scene_ents = [];
    var_7399a89a = doors::get_doors( "e_terminal_exit_door_animated", "targetname" );
    
    foreach ( door in var_7399a89a )
    {
        if ( door.script_noteworthy === "left_door" )
        {
            a_scene_ents[ #"left_door" ] = door.c_door.m_e_door;
            continue;
        }
        
        if ( door.script_noteworthy === "right_door" )
        {
            a_scene_ents[ #"right_door" ] = door.c_door.m_e_door;
        }
    }
    
    level scene::init( "scene_amk_6010_tml_computer", a_scene_ents );
}

// Namespace namespace_be0b7a4/namespace_b240b9c7
// Params 0
// Checksum 0x80cab652, Offset: 0x2548
// Size: 0xb4
function function_48a28239()
{
    level flag::wait_till( "flg_elevator_player_interact" );
    e_elevator_front_clip = getent( "e_elevator_front_clip", "targetname" );
    e_elevator_front_clip movez( 1024, 0.2, 0.05, 0.05 );
    level flag::wait_till( "flg_control_tower_elevator_at_top" );
    e_elevator_front_clip deletedelay();
}

// Namespace namespace_be0b7a4/namespace_b240b9c7
// Params 1
// Checksum 0xced81f1b, Offset: 0x2608
// Size: 0x2c
function function_4254583f( *str_objective )
{
    namespace_fc3e8cb::function_2987fd4c( "s_teleport_woods_terminal", 0, 0 );
}

// Namespace namespace_be0b7a4/namespace_b240b9c7
// Params 2
// Checksum 0xf126cd58, Offset: 0x2640
// Size: 0xdc
function function_da9636d5( str_objective, *var_50cc0d4f )
{
    /#
        namespace_fc3e8cb::function_44a6fc04( var_50cc0d4f );
    #/
    
    level thread function_2f099c26();
    clientfield::set( "cull_courtyard", 1 );
    level thread function_fb9fa5af();
    level thread function_37b57088();
    function_b53a12d0();
    level flag::wait_till( "flg_terminal_end" );
    skipto::function_4e3ab877( var_50cc0d4f );
}

// Namespace namespace_be0b7a4/namespace_b240b9c7
// Params 4
// Checksum 0xf3e8cafd, Offset: 0x2728
// Size: 0x1bc
function function_207b0552( *str_objective, var_50cc0d4f, *var_aa1a6455, *player )
{
    clientfield::set( "cull_courtyard", 1 );
    var_5c5d4c59 = getactorteamarray( "axis" );
    
    foreach ( var_78198c24 in var_5c5d4c59 )
    {
        if ( var_78198c24.allowdeath !== 0 )
        {
            var_78198c24 delete();
            continue;
        }
        
        var_78198c24 val::set( #"hash_179d084bd3674a52", "allowdeath", 1 );
        var_78198c24 delete();
    }
    
    level thread namespace_f6d09d1a::function_7b9feaa3( "lgtexp_motorpool_closed_state", 1, "flg_motor_pool_giant_doors_closed" );
    level thread namespace_f6d09d1a::function_7b9feaa3( "lgtexp_motorpool_open_state", 1, "flg_motor_pool_giant_doors_closed" );
    
    if ( player == 1 )
    {
        level flag::set( "flg_terminal_end" );
    }
}

// Namespace namespace_be0b7a4/namespace_b240b9c7
// Params 0
// Checksum 0x6b22777b, Offset: 0x28f0
// Size: 0x124
function function_2f099c26()
{
    s_obj_computer_terminal = struct::get( "s_obj_computer_terminal", "targetname" );
    objectives::goto( "obj_terminal_interact", s_obj_computer_terminal.origin, #"hash_27548d1d10470e72" );
    level flag::wait_till( "flg_terminal_player_exit" );
    objectives::complete( "obj_terminal_interact" );
    var_d248d2d4 = struct::get( "s_obj_terminal_exit_command_center", "targetname" );
    objectives::goto( "obj_elevator_command_center", var_d248d2d4.origin, #"hash_6a71e12841ece51e" );
    level flag::wait_till( "flg_terminal_end" );
    objectives::complete( "obj_elevator_command_center" );
}

// Namespace namespace_be0b7a4/namespace_b240b9c7
// Params 0
// Checksum 0xdc6febb8, Offset: 0x2a20
// Size: 0x1a4
function function_fb9fa5af()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level.woods ai::set_behavior_attribute( "disablepeek", 1 );
    level.woods ai::set_behavior_attribute( "vignette_mode", "fast" );
    level.woods.battlechatterallowed = 0;
    level thread namespace_fc3e8cb::function_5c5b6ea7( "nd_terminal_woods_start" );
    level flag::wait_till( "flg_terminal_start" );
    level namespace_2977687d::scene_amk_6010_tml_computer();
    level.woods flag::set( "flg_terminal_woods_open_door" );
    level thread namespace_fc3e8cb::function_5c5b6ea7( "nd_observation_woods_start" );
    level.woods ai::set_behavior_attribute( "demeanor", "combat" );
    level.woods ai::set_behavior_attribute( "vignette_mode", "off" );
    level.woods ai::function_3a5e9945( 1 );
}

// Namespace namespace_be0b7a4/namespace_b240b9c7
// Params 0
// Checksum 0xbc587ad0, Offset: 0x2bd0
// Size: 0x3ec
function function_b53a12d0()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    namespace_6f1d35e1::function_b2911127( 0 );
    wait 0.5;
    namespace_6f1d35e1::function_eea42dd9( #"hash_57b485a113a18d3" );
    namespace_6f1d35e1::function_5d2e6f6a( 1 );
    s_computer_terminal_interact = struct::get( "s_computer_terminal_interact", "targetname" );
    var_fc55b8bc = util::spawn_model( "tag_origin", s_computer_terminal_interact.origin, s_computer_terminal_interact.angles );
    var_fc55b8bc util::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), #"hash_77965c9740b1082d", 58 );
    var_fc55b8bc waittill( #"trigger" );
    level flag::set( "flg_terminal_player_interact" );
    var_fc55b8bc util::delay( 0.2, undefined, &util::remove_cursor_hint );
    level.player val::set( #"hash_5d32f7a7c6c1503c", "disable_weapons", 1 );
    level.player val::set( #"hash_5d32f7a7c6c1503c", "freezecontrols_allowlook", 1 );
    wait 0.5;
    var_b0ab3865 = struct::get_array( "terminal_hack_enter_test_org", "targetname" );
    var_6ed40c7f = arraysortclosest( var_b0ab3865, level.player.origin )[ 0 ];
    str_dir = var_6ed40c7f.script_noteworthy;
    
    if ( str_dir == "right" )
    {
        level scene::play( #"hash_784633e475f51557", "player_right_enter" );
    }
    else
    {
        level scene::play( #"hash_784633e475f51557", "player_left_enter" );
    }
    
    level.player val::reset_all( #"hash_5d32f7a7c6c1503c" );
    level thread scene::play( #"hash_784633e475f51557", "player_loop" );
    
    if ( !isdefined( level.var_32fb1de5 ) )
    {
        level.var_32fb1de5 = spawn( "script_origin", s_computer_terminal_interact.origin );
        level.var_32fb1de5.team = "axis";
        level.var_32fb1de5.name = "Computer";
        level thread namespace_4bd68414::function_e85255c2();
    }
    
    animation::add_notetrack_func( "amerika_control_tower::terminal_exit", &function_2d735bd7 );
    function_55a75785();
}

// Namespace namespace_be0b7a4/namespace_b240b9c7
// Params 0
// Checksum 0xebe1ad0b, Offset: 0x2fc8
// Size: 0x3c4
function function_55a75785()
{
    level.var_d1b1f86c = dialog_tree::new_tree( undefined, undefined, 1 );
    level.var_d1b1f86c dialog_tree::add_option( #"hash_597b79d7afed1a13", undefined, undefined, undefined, 1, "flg_terminal_tapes_trigger", "forever", &function_b864e340 );
    level.var_d1b1f86c dialog_tree::add_option( #"hash_78a92d25ee4249e2", undefined, undefined, undefined, 1, "flg_terminal_tapes_trigger", "forever", &function_349b458d );
    level.var_d1b1f86c dialog_tree::add_option( #"hash_21c9f7e87c332a1f", undefined, undefined, undefined, 1, "flg_terminal_tapes_trigger", "forever", &function_ac774391 );
    level.var_32087fb9 = dialog_tree::new_tree( undefined, undefined, 1 );
    level.var_32087fb9 dialog_tree::add_option( #"hash_841d08607115dbf", undefined, undefined, undefined, 1, undefined, "forever", &function_4eff952 );
    level.var_7688ff49 = dialog_tree::new_tree( undefined, undefined, 1 );
    level.var_7688ff49 dialog_tree::add_option( #"hash_59cbd736387031cd", undefined, undefined, undefined, undefined, undefined, "forever", &function_690804b8, 1 );
    level.var_7688ff49 dialog_tree::add_option( #"hash_59cbd43638702cb4", undefined, undefined, undefined, undefined, undefined, "forever", &function_690804b8, 2 );
    level.var_7688ff49 dialog_tree::add_option( #"hash_51070678b1416ec5", undefined, undefined, undefined, 1, undefined, "forever", &function_3def2ceb );
    level.var_716e0a3a = dialog_tree::new_tree( undefined, undefined, 1 );
    level.var_716e0a3a dialog_tree::add_option( #"hash_7116863a591a1890", undefined, undefined, undefined, 0, undefined, "forever" );
    level.var_716e0a3a dialog_tree::add_option( #"hash_7116863a591a1890", undefined, undefined, undefined, 0, undefined, "forever" );
    level.var_716e0a3a dialog_tree::add_option( #"hash_7116863a591a1890", undefined, undefined, undefined, 0, undefined, "forever" );
    level.var_1188cc49 = dialog_tree::new_tree( undefined, undefined, 1 );
    level.var_1188cc49 dialog_tree::add_option( #"hash_12aba2b48db7771", undefined, undefined, undefined, 1, undefined, "forever", &function_21b97d8e );
    function_eedcd240();
}

// Namespace namespace_be0b7a4/namespace_b240b9c7
// Params 0
// Checksum 0xe608fe11, Offset: 0x3398
// Size: 0x64
function function_eedcd240()
{
    wait 1;
    namespace_6f1d35e1::function_5d2e6f6a( 2 );
    wait 1;
    namespace_6f1d35e1::function_5d2e6f6a( 3 );
    wait 1;
    level.var_d1b1f86c thread dialog_tree::run();
}

// Namespace namespace_be0b7a4/namespace_b240b9c7
// Params 1
// Checksum 0x9643ff5c, Offset: 0x3408
// Size: 0x8c
function function_2d735bd7( *params )
{
    level.var_716e0a3a dialog_tree::function_a6a75a20();
    
    /#
        iprintlnbold( "<dev string:x56>" );
    #/
    
    scene::play( #"hash_784633e475f51557", "player_exit" );
    level flag::set( "flg_terminal_player_exit" );
}

// Namespace namespace_be0b7a4/namespace_b240b9c7
// Params 0
// Checksum 0xe244c059, Offset: 0x34a0
// Size: 0x74
function function_37b57088()
{
    doors::function_f35467ac( "e_terminal_exit_door_animated" );
    level flag::wait_till( "flg_terminal_player_interact" );
    level thread function_74ebff30();
    level flag::wait_till( "flg_observation_on_catwalk" );
}

// Namespace namespace_be0b7a4/namespace_b240b9c7
// Params 0
// Checksum 0x40840e2e, Offset: 0x3520
// Size: 0x54
function function_b864e340()
{
    wait 0.5;
    namespace_6f1d35e1::function_5d2e6f6a( 5 );
    level namespace_4bd68414::function_51448d9f();
    level.var_1188cc49 thread dialog_tree::run();
}

// Namespace namespace_be0b7a4/namespace_b240b9c7
// Params 0
// Checksum 0x4d4178a2, Offset: 0x3580
// Size: 0x54
function function_349b458d()
{
    wait 0.5;
    namespace_6f1d35e1::function_5d2e6f6a( 4 );
    level namespace_4bd68414::function_892d5a11();
    level.var_1188cc49 thread dialog_tree::run();
}

// Namespace namespace_be0b7a4/namespace_b240b9c7
// Params 0
// Checksum 0x534abb36, Offset: 0x35e0
// Size: 0x3c
function function_21b97d8e()
{
    wait 0.5;
    namespace_6f1d35e1::function_5d2e6f6a( 3 );
    level.var_d1b1f86c thread dialog_tree::run();
}

// Namespace namespace_be0b7a4/namespace_b240b9c7
// Params 0
// Checksum 0xd003dbcf, Offset: 0x3628
// Size: 0xec
function function_ac774391()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    namespace_6f1d35e1::function_5d2e6f6a( 6 );
    level thread namespace_4bd68414::function_e79f4ae2();
    wait 1.75;
    namespace_6f1d35e1::function_5d2e6f6a( 7 );
    level flag::set( #"hash_10227bcd8df77658" );
    level.woods flag::wait_till( #"hash_6f89d7a5b3a15589" );
    level.var_32087fb9 thread dialog_tree::run();
}

// Namespace namespace_be0b7a4/namespace_b240b9c7
// Params 0
// Checksum 0x2238837a, Offset: 0x3720
// Size: 0x34
function function_4eff952()
{
    level namespace_4bd68414::function_692fbedf();
    level thread function_6168629();
}

// Namespace namespace_be0b7a4/namespace_b240b9c7
// Params 0
// Checksum 0x2b7d20de, Offset: 0x3760
// Size: 0xf4
function function_6168629()
{
    level function_ea2e6360();
    wait 0.25;
    namespace_6f1d35e1::function_5d2e6f6a( 8 );
    wait 1.5;
    namespace_6f1d35e1::function_5d2e6f6a( 9 );
    wait 1.5;
    namespace_6f1d35e1::function_5d2e6f6a( 10 );
    wait 3;
    namespace_6f1d35e1::function_5d2e6f6a( 14 );
    wait 2;
    namespace_6f1d35e1::function_5d2e6f6a( 12 );
    level flag::set( "flg_greenlight_intel_found" );
    level.var_7688ff49 thread dialog_tree::run();
}

// Namespace namespace_be0b7a4/namespace_b240b9c7
// Params 1
// Checksum 0x95b4fe54, Offset: 0x3860
// Size: 0xcc
function function_690804b8( var_237f80b0 )
{
    namespace_6f1d35e1::function_5d2e6f6a( 15 );
    
    switch ( var_237f80b0 )
    {
        case 1:
            namespace_4bd68414::function_f0072474();
            break;
        case 2:
            namespace_4bd68414::function_29b017c5();
            break;
        default:
            /#
                hms_util::print( "<dev string:x65>" );
            #/
            
            break;
    }
    
    namespace_6f1d35e1::function_5d2e6f6a( 12 );
}

// Namespace namespace_be0b7a4/namespace_b240b9c7
// Params 0
// Checksum 0x60969004, Offset: 0x3938
// Size: 0x84
function function_3def2ceb()
{
    level flag::set( "flg_greenlight_intel_printed" );
    namespace_6f1d35e1::function_5d2e6f6a( 16 );
    level waittill( #"hash_40f87ebb2800cdc6" );
    level thread function_cd9b75f7();
    namespace_6f1d35e1::function_5d2e6f6a( 11 );
}

// Namespace namespace_be0b7a4/namespace_b240b9c7
// Params 0
// Checksum 0x9ebe3df8, Offset: 0x39c8
// Size: 0x438
function function_ea2e6360()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    var_8c309123[ #"note" ] = getent( "terminal_hint_sticky_note", "targetname" );
    var_8c309123[ #"note" ].offset = ( 0, 0, 2 );
    var_8c309123[ #"postcard" ] = getent( "terminal_hint_postcard", "targetname" );
    var_8c309123[ #"postcard" ].offset = ( 1, 0, 3 );
    var_8c309123[ #"poster" ] = getent( "terminal_hint_poster", "targetname" );
    var_8c309123[ #"poster" ].offset = ( 0, 0, 0 );
    var_8c309123[ #"note" ] util::create_cursor_hint( "tag_origin", var_8c309123[ #"note" ].offset, #"hash_23c6c63a28d6b1bc", 100, undefined, &hint_use, undefined, 100, 30, 0, 1, undefined, &function_add2e8e8 );
    var_8c309123[ #"postcard" ] util::create_cursor_hint( "tag_origin", var_8c309123[ #"postcard" ].offset, #"hash_2d2c88f338114b60", 100, undefined, &hint_use, undefined, 100, 40, 0, 1, undefined, &function_add2e8e8 );
    var_8c309123[ #"poster" ] util::create_cursor_hint( "tag_origin", var_8c309123[ #"poster" ].offset, #"hash_4e1a9c0154d891fd", 200, undefined, &hint_use, undefined, 200, 15, 0, 1, undefined, &function_add2e8e8 );
    
    while ( true )
    {
        waitresult = level.player waittill( #"terminal_hint_sticky_note", #"terminal_hint_postcard", #"terminal_hint_poster" );
        
        if ( waitresult._notify == #"terminal_hint_poster" )
        {
            break;
        }
        
        wait 0.25;
        namespace_6f1d35e1::function_5d2e6f6a( 8 );
        wait 1.5;
        namespace_6f1d35e1::function_5d2e6f6a( 11 );
        level namespace_4bd68414::function_58edca49();
        wait 0.5;
        level thread namespace_4bd68414::terminal_greenlight_wrong_password_dialogue();
    }
    
    foreach ( object in var_8c309123 )
    {
        object util::remove_cursor_hint();
    }
}

// Namespace namespace_be0b7a4/namespace_b240b9c7
// Params 1
// Checksum 0x1daeccfe, Offset: 0x3e08
// Size: 0xb2, Type: bool
function function_add2e8e8( s_info )
{
    assert( isdefined( self.offset ) );
    return util::within_fov( s_info.player getplayercamerapos(), s_info.player getplayerangles(), self.origin + self.offset, cos( self.var_3e95b88f.prompts[ #"use" ].var_5e83875a ) );
}

// Namespace namespace_be0b7a4/namespace_b240b9c7
// Params 1
// Checksum 0x6fde0507, Offset: 0x3ec8
// Size: 0x20
function hint_use( *s_info )
{
    level.player notify( self.targetname );
}

// Namespace namespace_be0b7a4/namespace_b240b9c7
// Params 0
// Checksum 0xd3b144d4, Offset: 0x3ef0
// Size: 0x124
function function_cd9b75f7()
{
    level.player endon( #"death" );
    level.var_716e0a3a thread dialog_tree::run();
    level thread namespace_f6d09d1a::function_7b9feaa3( "lgtexp_terminal_room", 1 );
    level thread namespace_f6d09d1a::function_7b9feaa3( "lgtexp_motorpool_vista", 1 );
    level thread namespace_f6d09d1a::function_7b9feaa3( "lgtexp_perf_townsquare_keys", 0 );
    level util::delay( 1.5, undefined, &namespace_4bd68414::function_fe1cd4ee );
    
    while ( !level flag::get( "flg_observation_end" ) )
    {
        wait 5;
        level thread namespace_4bd68414::function_defae9e0();
    }
    
    level.var_32fb1de5 deletedelay();
}

// Namespace namespace_be0b7a4/namespace_b240b9c7
// Params 1
// Checksum 0xff28124c, Offset: 0x4020
// Size: 0x4c
function function_170cfeb3( *str_objective )
{
    level thread namespace_f6d09d1a::function_7b9feaa3( "lgtexp_motorpool_vista", 1 );
    namespace_fc3e8cb::function_2987fd4c( "s_teleport_woods_observation", 0, 0 );
}

// Namespace namespace_be0b7a4/namespace_b240b9c7
// Params 2
// Checksum 0x3728849a, Offset: 0x4078
// Size: 0x1ac
function function_7ff0a4d3( str_objective, *var_50cc0d4f )
{
    /#
        namespace_fc3e8cb::function_44a6fc04( var_50cc0d4f );
    #/
    
    level thread function_31224772();
    level thread function_3005c939();
    level thread namespace_4c1dd357::function_725c2118();
    level thread function_401d9737();
    level thread function_983decfe();
    level.vh_town_square_apc = hms_util::function_a3bb1e9c( "vh_town_square_apc", "suspend", 0 );
    level.vh_town_square_apc thread hms_util::function_7b8ccc06();
    level.vh_town_square_apc thread hms_util::function_ca8302de();
    nd_vh_town_square_apc_observation_start = getvehiclenode( "nd_vh_town_square_apc_observation_start", "targetname" );
    level.vh_town_square_apc thread vehicle::get_on_and_go_path( nd_vh_town_square_apc_observation_start );
    level thread function_55e6229f();
    level thread function_bea61ad6();
    level flag::wait_till( "flg_observation_end" );
    skipto::function_4e3ab877( var_50cc0d4f );
}

// Namespace namespace_be0b7a4/namespace_b240b9c7
// Params 4
// Checksum 0xbdfd63b, Offset: 0x4230
// Size: 0x4c
function function_123e9b38( *str_objective, var_50cc0d4f, *var_aa1a6455, *player )
{
    if ( player == 0 )
    {
        level thread namespace_f6d09d1a::function_7b9feaa3( "lgtexp_motorpool_vista", 0 );
    }
}

// Namespace namespace_be0b7a4/namespace_b240b9c7
// Params 0
// Checksum 0xabebcce0, Offset: 0x4288
// Size: 0x34
function function_31224772()
{
    objectives::follow( "obj_observation_follow_woods", level.woods, #"hash_6783da2c53b544a4" );
}

// Namespace namespace_be0b7a4/namespace_b240b9c7
// Params 0
// Checksum 0x54780734, Offset: 0x42c8
// Size: 0x40c
function function_3005c939()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level thread namespace_4bd68414::function_1a1db78c();
    level.woods ai::function_3a5e9945( 1 );
    level.woods val::set( #"hash_7f4af3d9057acdb8", "ignoreme", 1 );
    level.woods val::set( #"hash_7f4af3d9057acdb8", "ignoreall", 1 );
    level.woods ai::set_behavior_attribute( "vignette_mode", "fast" );
    level.woods ai::set_behavior_attribute( "disablepeek", 1 );
    level.woods ai::set_behavior_attribute( "disablelean", 1 );
    level.woods.battlechatterallowed = 0;
    var_a44d987e = getnode( "nd_observation_woods_approaching_stairs", "targetname" );
    level.woods thread hms_util::function_2f50100e( "stay_ahead", var_a44d987e.origin, "end_woods_observation_follow1" );
    level.player util::blend_movespeedscale( 0.95, 1 );
    level thread namespace_fc3e8cb::function_5c5b6ea7( "nd_observation_woods_approaching_catwalk" );
    level flag::wait_till( "flg_terminal_end" );
    level thread namespace_4bd68414::function_3fd7a46f();
    level namespace_fc3e8cb::function_92dea087( "flg_observation_approaching_catwalk", "flg_observation_approaching_window" );
    level thread namespace_fc3e8cb::function_5c5b6ea7( "nd_observation_woods_approaching_stairs" );
    level flag::wait_till( "flg_observation_on_catwalk" );
    level.woods notify( #"end_woods_observation_follow1" );
    var_928274e8 = getnode( "nd_observation_woods_end", "targetname" );
    level.woods thread hms_util::function_2f50100e( "stay_ahead", var_928274e8.origin, "end_woods_observation_follow2" );
    level thread namespace_fc3e8cb::function_5c5b6ea7( "nd_observation_woods_on_stairs" );
    level namespace_fc3e8cb::function_92dea087( "flg_observation_on_stairs", "flg_observation_approaching_stairs" );
    level thread namespace_fc3e8cb::function_5c5b6ea7( "nd_observation_woods_end" );
    level flag::wait_till( "flg_observation_end" );
    level.woods notify( #"end_woods_observation_follow2" );
    level.woods ai::function_3a5e9945( 0 );
    level.woods val::set( #"hash_7f4af3d9057acdb8", "ignoreme", 0 );
}

// Namespace namespace_be0b7a4/namespace_b240b9c7
// Params 0
// Checksum 0xcbc70e69, Offset: 0x46e0
// Size: 0x64
function function_89276f35()
{
    level endon( #"flg_observation_dropdown" );
    
    if ( level flag::get( "flg_observation_dropdown" ) == 1 )
    {
        return;
    }
    
    level namespace_fc3e8cb::function_92dea087( "flg_observation_approaching_stairs", "flg_observation_on_catwalk" );
}

// Namespace namespace_be0b7a4/namespace_b240b9c7
// Params 0
// Checksum 0x8ed026c5, Offset: 0x4750
// Size: 0x94
function function_6139bb2e()
{
    level endon( #"flg_observation_approaching_window" );
    
    if ( level flag::get( "flg_observation_approaching_window" ) == 1 )
    {
        return;
    }
    
    level namespace_fc3e8cb::function_5c5b6ea7( "nd_observation_woods_at_window" );
    level.woods lookatentity( level.vh_town_square_apc );
    level thread namespace_4bd68414::function_e4526cf7();
}

// Namespace namespace_be0b7a4/namespace_b240b9c7
// Params 0
// Checksum 0x2fe89175, Offset: 0x47f0
// Size: 0x450
function function_55e6229f()
{
    level thread scene::init( "observation_window_rappel_scene_01", "targetname" );
    level thread scene::init( "observation_window_rappel_scene_02", "targetname" );
    level thread scene::init( "observation_window_rappel_scene_03", "targetname" );
    level flag::wait_till( "flg_observation_approaching_window" );
    level thread scene::play( "observation_window_rappel_scene_01", "targetname" );
    level thread namespace_fc3e8cb::function_fa5905d0( "s_observation_heli_lights_01" );
    wait randomfloatrange( 0.5, 1.5 );
    level thread scene::play( "observation_window_rappel_scene_02", "targetname" );
    level thread namespace_fc3e8cb::function_fa5905d0( "s_observation_heli_lights_02" );
    wait randomfloatrange( 0.5, 1.5 );
    level thread scene::play( "observation_window_rappel_scene_03", "targetname" );
    level thread namespace_fc3e8cb::function_fa5905d0( "s_observation_heli_lights_03" );
    var_f1f393cc = [];
    var_905125ff = getaiarray( "ai_observation_rappel_group_01", "targetname" );
    var_f1f393cc = arraycombine( var_f1f393cc, var_905125ff );
    var_d8e43724 = getaiarray( "ai_observation_rappel_group_02", "targetname" );
    var_f1f393cc = arraycombine( var_f1f393cc, var_d8e43724 );
    var_f3966c88 = getaiarray( "ai_observation_rappel_group_03", "targetname" );
    var_f1f393cc = arraycombine( var_f1f393cc, var_f3966c88 );
    level flag::wait_till( "flg_observation_approaching_stairs" );
    function_1eaaceab( var_f1f393cc );
    
    if ( var_f1f393cc.size > 0 )
    {
        foreach ( ai in var_f1f393cc )
        {
            if ( isalive( ai ) && ai.allowdeath !== 0 )
            {
                ai delete();
            }
        }
    }
    
    level flag::wait_till( "flg_facades_corridor_enter" );
    function_1eaaceab( var_f1f393cc );
    
    if ( var_f1f393cc.size > 0 )
    {
        foreach ( ai in var_f1f393cc )
        {
            if ( isalive( ai ) && ai.allowdeath !== 0 )
            {
                ai delete();
            }
        }
    }
}

// Namespace namespace_be0b7a4/namespace_b240b9c7
// Params 0
// Checksum 0x228a97b5, Offset: 0x4c48
// Size: 0xfc
function function_bea61ad6()
{
    level flag::wait_till( "flg_observation_approaching_window" );
    
    while ( level flag::get( "flg_observation_approaching_catwalk" ) == 0 )
    {
        if ( isdefined( level.vh_town_square_apc ) )
        {
            var_e88b5bd1 = util::within_fov( level.player getplayercamerapos(), level.player getplayerangles(), level.vh_town_square_apc.origin, 0.707107 );
            
            if ( var_e88b5bd1 == 1 )
            {
                break;
            }
        }
        
        wait 0.1;
    }
    
    level flag::set( "flg_observation_apc_los" );
}

// Namespace namespace_be0b7a4/namespace_b240b9c7
// Params 0
// Checksum 0x42eb6dca, Offset: 0x4d50
// Size: 0xa4
function function_401d9737()
{
    level thread namespace_fc3e8cb::function_1c62d05e( "ai_enemy_observation_far_drone", "flg_facades_start", 1, 4, 6, 0, "flg_observation_spawn_snipers" );
    level flag::wait_till( "flg_observation_approaching_stairs" );
    level thread namespace_fc3e8cb::function_1c62d05e( "ai_enemy_observation_near_drone", "flg_facades_start", 1, 1, 2, 0, "flg_observation_spawn_snipers" );
}

// Namespace namespace_be0b7a4/namespace_b240b9c7
// Params 0
// Checksum 0x23f182cc, Offset: 0x4e00
// Size: 0x84
function function_983decfe()
{
    level endon( #"flg_facades_start" );
    level flag::wait_till( "flg_observation_spawn_snipers" );
    var_15b931de = spawner::simple_spawn( "ai_enemy_observation_sniper", &function_550b8a92 );
    level thread namespace_fc3e8cb::function_18e5080e( "flg_helipad_end", var_15b931de );
}

// Namespace namespace_be0b7a4/namespace_b240b9c7
// Params 0
// Checksum 0xcb1ce24a, Offset: 0x4e90
// Size: 0x2e
function function_550b8a92()
{
    self getenemyinfo( level.player );
    self.grenadeammo = 0;
}

