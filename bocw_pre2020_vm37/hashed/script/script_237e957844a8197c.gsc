#using script_1b9f100b85b7e21d;
#using script_3dc93ca9902a9cda;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;

#namespace namespace_a789f8ae;

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 0
// Checksum 0xb36422f, Offset: 0x13a8
// Size: 0x114
function function_96b44444()
{
    level waittill( #"chyron_menu_closed" );
    level.player val::set( "rev_start", "freezecontrols_allowlook", 1 );
    level.player val::set( "rev_start", "low_ready", 1 );
    level scene::play( "scene_rev_1010_rde_intro", "intro" );
    level flag::set( "flag_intro_scene_ended" );
    level.player val::reset( "rev_start", "freezecontrols_allowlook" );
    level.player val::reset( "rev_start", "low_ready" );
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 1
// Checksum 0x2a6a0be, Offset: 0x14c8
// Size: 0x164
function function_716ff5d8( var_57ef78ed )
{
    a_enemies = spawner::simple_spawn( "2010_enemy" );
    a_ents[ #"enemy01" ] = a_enemies[ 0 ];
    a_ents[ #"enemy04" ] = a_enemies[ 1 ];
    
    if ( var_57ef78ed == "church" )
    {
        level thread scene::init( "scene_rev_2010_pla_rendezvous", a_ents );
        var_3bd815c8 = doors::get_doors( "church_exit_door" )[ 0 ];
        var_3bd815c8 doors::waittill_door_opened();
        level.player util::blend_movespeedscale_default( 1.5 );
        var_3bd815c8 doors::function_f35467ac();
        var_3bd815c8.c_door thread function_fbc17248();
    }
    
    level scene::play( "scene_rev_2010_pla_rendezvous", "Start", a_ents );
    level flag::set( "flg_rendezvous_scene_done" );
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 0
// Checksum 0x57ace376, Offset: 0x1638
// Size: 0x5c
function function_fbc17248()
{
    if ( is_true( self.var_c4c3fa39 ) )
    {
        snd::play( "evt_church_door_bash_open", self );
        return;
    }
    
    snd::play( "evt_church_door_open", self );
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 1
// Checksum 0x74ed7815, Offset: 0x16a0
// Size: 0x64
function wait_for_death( var_bc2b55eb )
{
    self endon( #"death" );
    self waittill( var_bc2b55eb + "_die" );
    self animation::stop();
    self kill();
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 0
// Checksum 0x1315fb1d, Offset: 0x1710
// Size: 0x84
function function_c68fb2ec()
{
    var_13fa77c6 = getent( "pillar_rpg_collapse_clip", "targetname" );
    wait 2.3;
    level scene::play( "p9_fxanim_gp_pillar_rpg_collapse_scene", "play" );
    wait 1;
    
    if ( isdefined( var_13fa77c6 ) )
    {
        var_13fa77c6 delete();
    }
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 0
// Checksum 0x3e8789be, Offset: 0x17a0
// Size: 0x44
function function_6f16e46d()
{
    level thread function_3499a2c7();
    level thread function_986b3cba( 7, 10 );
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 2
// Checksum 0xa078f2, Offset: 0x17f0
// Size: 0x1f4
function function_986b3cba( var_afde181b, var_82527dbb )
{
    level endon( #"1st_floor_cctv" );
    level thread scene::play( "scene_rev_3010_fir_split_off_breach", "adler_start" );
    level thread scene::play( "scene_rev_3010_fir_split_off_breach", "woods_start" );
    level thread scene::play( "scene_rev_3010_fir_split_off_breach", "mason_start" );
    level waittill( #"hash_6cd798a2f083a39a" );
    
    while ( !level flag::get( "flg_remove_adlers_team" ) )
    {
        wait randomfloatrange( var_afde181b, var_82527dbb );
        
        if ( !level flag::get( "flg_remove_adlers_team" ) )
        {
            level scene::play( "scene_rev_3010_fir_split_off_breach", "nag" );
            level thread scene::play( "scene_rev_3010_fir_split_off_breach", "loop" );
        }
    }
    
    level flag::wait_till( "flg_remove_adlers_team" );
    
    if ( isdefined( level.woods ) )
    {
        level.woods delete();
    }
    
    if ( isdefined( level.mason ) )
    {
        level.mason delete();
    }
    
    if ( isdefined( level.adler ) )
    {
        level.adler delete();
    }
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 0
// Checksum 0xa1afdfd, Offset: 0x19f0
// Size: 0x23c
function function_3a0e41ed()
{
    a_ents = [];
    level flag::wait_till( "play_scene_hands_up" );
    a_ents[ #"hash_86fe5b596d46e2f" ] = spawner::simple_spawn_single( getent( "vig_handsup_contra_spawner", "targetname" ) );
    a_ents[ #"hash_5dd01c989f26191b" ] = spawner::simple_spawn_single( getent( "vig_handsup_civ_spawner", "targetname" ) );
    a_ents[ #"hash_86fe5b596d46e2f" ] endon( #"death" );
    a_ents[ #"hash_5dd01c989f26191b" ] endon( #"death" );
    level scene::init( "scene_vig_0000_amb_execution_wall_handsup", a_ents );
    
    foreach ( guy in a_ents )
    {
        guy.health = 1;
    }
    
    a_ents[ #"hash_86fe5b596d46e2f" ] function_628aec92( "scene_vig_0000_amb_execution_wall_handsup" );
    a_ents[ #"hash_5dd01c989f26191b" ] function_628aec92( "scene_vig_0000_amb_execution_wall_handsup" );
    level scene::play( "scene_vig_0000_amb_execution_wall_handsup", "enter", a_ents );
    level scene::play( "scene_vig_0000_amb_execution_wall_handsup", "loop", a_ents );
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 0
// Checksum 0x84bca597, Offset: 0x1c38
// Size: 0x26c
function function_d13f90cb()
{
    a_ents = [];
    level flag::wait_till( "play_scene_civ_ground" );
    a_ents[ #"hash_86fe5b596d46e2f" ] = spawner::simple_spawn_single( getent( "vig_struggle_contra_spawner", "targetname" ) );
    a_ents[ #"hash_5dd01c989f26191b" ] = spawner::simple_spawn_single( getent( "vig_struggle_civ_spawner", "targetname" ) );
    a_ents[ #"hash_86fe5b596d46e2f" ] endon( #"death" );
    a_ents[ #"hash_5dd01c989f26191b" ] endon( #"death" );
    level scene::init( "scene_vig_0000_amb_struggle_ground", a_ents );
    
    foreach ( guy in a_ents )
    {
        guy.health = 1;
    }
    
    a_ents[ #"hash_86fe5b596d46e2f" ] function_628aec92( "scene_vig_0000_amb_struggle_ground" );
    a_ents[ #"hash_5dd01c989f26191b" ] function_628aec92( "scene_vig_0000_amb_struggle_ground" );
    level scene::play( "scene_vig_0000_amb_struggle_ground", "enter", a_ents );
    level thread scene::play( "scene_vig_0000_amb_struggle_ground", "loop", a_ents );
    wait 5;
    level scene::play( "scene_vig_0000_amb_struggle_ground", "exit", a_ents );
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 0
// Checksum 0x6e7121be, Offset: 0x1eb0
// Size: 0x16c
function function_cca11e21()
{
    var_b5ee4ca5 = getentarray( "surrender_scene_enemy_spawner", "targetname" );
    var_b98ae473 = getentarray( "surrender_scene_contra_spawner", "targetname" );
    a_ents = [];
    level flag::wait_till( "play_scene_civ_ground" );
    var_3d261bd8 = spawner::simple_spawn( var_b5ee4ca5 );
    var_8e714466 = spawner::simple_spawn( var_b98ae473 );
    a_ents[ #"ally01" ] = var_8e714466[ 0 ];
    a_ents[ #"hash_24f28f860161c125" ] = var_8e714466[ 1 ];
    a_ents[ #"enemy01" ] = var_3d261bd8[ 0 ];
    a_ents[ #"enemy02" ] = var_3d261bd8[ 1 ];
    level scene::init( "scene_rev_0000_ambient_surrender", a_ents );
    level scene::play( "scene_rev_0000_ambient_surrender", "start", a_ents );
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 0
// Checksum 0x7f6ba816, Offset: 0x2028
// Size: 0x2d4
function function_3499a2c7()
{
    a_ents = [];
    var_4a3daa0b = struct::get( "table_flip_look_at_org", "targetname" );
    s_scene = struct::get( "scene_table_flip" );
    s_scene scene::init( a_ents );
    
    while ( true )
    {
        within_fov = util::within_fov( level.player getplayercamerapos(), level.player getplayerangles(), var_4a3daa0b.origin, cos( 45 ) );
        var_19433220 = sighttracepassed( level.player getplayercamerapos(), var_4a3daa0b.origin, 0, undefined );
        var_265622ec = distance2d( level.player.origin, var_4a3daa0b.origin );
        
        if ( within_fov == 1 && var_19433220 == 1 || var_265622ec < 200 )
        {
            /#
                hms_util::print( "<dev string:x38>" );
            #/
            
            break;
        }
        
        waitframe( 1 );
    }
    
    a_ents[ #"enemy" ] = spawner::simple_spawn_single( getent( "vig_right_1_enemy_table_flip_spawner", "targetname" ) );
    a_ents[ #"enemy" ] endon( #"death" );
    level notify( #"hash_20b372100c1d49b2" );
    s_scene thread function_b1f33833( a_ents[ #"enemy" ] );
    s_scene scene::play( a_ents );
    var_e4bd6323 = getnode( "table_flip_node", "targetname" );
    a_ents[ #"enemy" ] ai::set_goal_node( var_e4bd6323 );
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 1
// Checksum 0x6937a520, Offset: 0x2308
// Size: 0xbc
function function_b1f33833( var_541d697 )
{
    var_541d697 endoncallback( &function_6ea46f39, #"death" );
    var_e189955e = self.scene_ents[ #"hash_363ff12eba02d468" ];
    var_e189955e waittill( #"flip" );
    snd::client_msg( "audio_table_flip" );
    physicsexplosionsphere( var_e189955e.origin + ( 0, -16, 32 ), 60, 0, 0.06 );
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 1
// Checksum 0x9ccbdeb0, Offset: 0x23d0
// Size: 0x44
function function_6ea46f39( *str_notify )
{
    s_scene = struct::get( "scene_table_flip" );
    s_scene scene::stop();
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 0
// Checksum 0xa268eb4, Offset: 0x2420
// Size: 0x1e4
function function_103e5f20()
{
    a_ents = [];
    a_ents[ #"enemy" ] = spawner::simple_spawn_single( getent( "vig_right_1_enemy_door_kick_spawner", "targetname" ) );
    a_ents[ #"enemy" ] endon( #"death" );
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
    
    cctv_guards = spawner::simple_spawn( "cctv_guards" );
    level scene::play( "cin_gen_aie_door_kick", a_ents );
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 0
// Checksum 0x22d852cf, Offset: 0x2610
// Size: 0x2cc
function function_8b3f291()
{
    a_ents = [];
    level flag::wait_till( "play_scene_civ_execute" );
    a_ents[ #"contra" ] = spawner::simple_spawn_single( getent( "vig_execute_contra_spawner", "targetname" ) );
    a_ents[ #"civilian" ] = spawner::simple_spawn_single( getent( "vig_execute_civ_spawner", "targetname" ) );
    a_ents[ #"contra" ] endon( #"death" );
    a_ents[ #"civilian" ] endon( #"death" );
    a_ents[ #"contra" ] function_628aec92( "scene_vig_0000_amb_surrender_to_execution" );
    a_ents[ #"civilian" ] function_628aec92( "scene_vig_0000_amb_surrender_to_execution" );
    
    foreach ( guy in a_ents )
    {
        guy.health = 1;
    }
    
    level scene::play( "scene_vig_0000_amb_surrender_to_execution", "surrender_enter", a_ents );
    level thread scene::play( "scene_vig_0000_amb_surrender_to_execution", "surrender_loop", a_ents );
    wait 1.733;
    level scene::play( "scene_vig_0000_amb_surrender_to_execution", "surrender_to_kick", a_ents );
    level thread scene::play( "scene_vig_0000_amb_surrender_to_execution", "kick_loop", a_ents );
    wait 1.8;
    level scene::play( "scene_vig_0000_amb_surrender_to_execution", "kick_to_execution", a_ents );
    level scene::play( "scene_vig_0000_amb_surrender_to_execution", "execute_loop", a_ents );
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 2
// Checksum 0x893f50cd, Offset: 0x28e8
// Size: 0xb2
function function_f08f3cb7( scenename, var_61210cb0 )
{
    while ( level scene::is_active( scenename ) && isalive( self ) )
    {
        wait 0.1;
    }
    
    level scene::stop( scenename );
    
    if ( isalive( var_61210cb0 ) && !isalive( self ) )
    {
        var_61210cb0.team = "axis";
    }
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 2
// Checksum 0xe71bfeae, Offset: 0x29a8
// Size: 0x94
function function_646785f0( scenename, var_c41afa4b )
{
    while ( level scene::is_active( scenename ) && isalive( self ) )
    {
        wait 0.1;
    }
    
    while ( isalive( var_c41afa4b ) )
    {
        wait 0.1;
    }
    
    level scene::stop( scenename );
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 1
// Checksum 0x2235386b, Offset: 0x2a48
// Size: 0x64
function function_628aec92( scenename )
{
    while ( level scene::is_active( scenename ) && isalive( self ) )
    {
        wait 0.1;
    }
    
    level scene::stop( scenename );
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 0
// Checksum 0x184aae8e, Offset: 0x2ab8
// Size: 0xac
function function_7d86c1d()
{
    level flag::wait_till( "flg_VIP_spotted_in_cctv" );
    level scene::init( "scene_rev_3050_fir_security_camera" );
    level thread scene::play( "scene_rev_3050_fir_security_camera", "play" );
    level flag::wait_till( "flg_cctv_finished" );
    level scene::stop( "scene_rev_3050_fir_security_camera", 1 );
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 0
// Checksum 0x901a0837, Offset: 0x2b70
// Size: 0x10c
function function_c1f6c87c()
{
    level endon( #"hash_4a17bb3c36a854c4" );
    level endon( #"flg_cctv_finished" );
    var_e534dcb = struct::get( "ai_alder_radio", "targetname" );
    level.park thread hms_util::dialogue( "vox_cp_cbcr_01400_park_thereholdit_f8" );
    level.park hms_util::dialogue( "vox_cp_cbcr_01400_park_adlerwehaveeyes_b8" );
    level.park hms_util::dialogue( "vox_cp_cbcr_01400_park_perseus_92" );
    var_e534dcb hms_util::dialogue( "vox_cp_cbcr_01400_adlr_where_3a", 1, "allies", "Adler" );
    level.park hms_util::dialogue( "vox_cp_cbcr_01400_park_2ndfloorroom27b_3d" );
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 0
// Checksum 0xed1db985, Offset: 0x2c88
// Size: 0x1f4
function function_c54af28a()
{
    s_scene = struct::get( "cctv_nuke_room_scene" );
    var_34d58d57 = getent( "clean_room_door", "targetname" );
    var_34d58d57 hide();
    level scene::init( "scene_rev_3050_fir_cam_nuke" );
    s_scene.scene_ents[ #"perseus" ] disableaimassist();
    s_scene.scene_ents[ #"guy01" ] setmodel( "c_t9_cub_civ_male_scientist_body1" );
    level flag::wait_till( "flg_VIP_spotted_in_cctv" );
    s_scene thread scene::play();
    s_scene.scene_ents[ #"perseus" ] detach( s_scene.scene_ents[ #"perseus" ].head );
    s_scene.scene_ents[ #"perseus" ] attach( "c_t9_cp_rus_hero_perseus_head1" );
    level thread function_c1f6c87c();
    level flag::wait_till( "flg_cctv_finished" );
    var_34d58d57 show();
    s_scene scene::stop( 1 );
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 0
// Checksum 0xb0f1ce9a, Offset: 0x2e88
// Size: 0xcc
function function_48e82918()
{
    level flag::wait_till( "flg_lobby_camera" );
    var_df21139a = struct::get( "lobby_phys_impulse", "targetname" );
    physicsexplosionsphere( var_df21139a.origin, 60, 0, 0.06 );
    var_35a13abc = spawner::simple_spawn( "lobby_camera_drone" );
    snd::play( "evt_cctv_group_fs", var_35a13abc );
    snd::play( "evt_cctv_group_gear", var_35a13abc );
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 0
// Checksum 0xc8c6974c, Offset: 0x2f60
// Size: 0x114
function function_fedf7c()
{
    level scene::init( "scene_rev_3050_fir_cam_dining_room" );
    level flag::wait_till( "play_scene_civ_ground" );
    level thread scene::play( "scene_rev_3050_fir_cam_dining_room" );
    level flag::set( "flg_in_dining_room" );
    wait randomfloatrange( 1, 2 );
    level.park hms_util::dialogue( "vox_cp_cbcr_01400_park_keeplooking_c6" );
    level thread function_7482b1ff();
    level flag::wait_till( "flg_cctv_finished" );
    level scene::stop( "scene_rev_3050_fir_cam_dining_room", 1 );
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 0
// Checksum 0xe05e9951, Offset: 0x3080
// Size: 0x11e
function function_7482b1ff()
{
    level endon( #"flg_VIP_spotted_in_cctv" );
    wait 5;
    var_ffbbfc35 = [];
    var_ffbbfc35[ 0 ] = hms_util::function_e1449992( level.park, "vox_cp_cbcr_01400_park_theresgottobeot_26" );
    var_ffbbfc35[ 1 ] = hms_util::function_e1449992( level.park, "vox_cp_cbcr_01400_park_tryanotherchann_77" );
    var_ffbbfc35[ 2 ] = hms_util::function_e1449992( level.park, "vox_cp_cbcr_01400_park_tryanotherfeed_32" );
    var_ffbbfc35[ 3 ] = hms_util::function_e1449992( level.park, "vox_cp_cbcr_01400_park_thatsnotit_9b" );
    var_ffbbfc35[ 4 ] = hms_util::function_e1449992( level.park, "vox_cp_cbcr_01400_park_changethechanne_ce" );
    
    while ( true )
    {
        hms_util::vo_knockout_manager( "cuban_change_feed_nags", var_ffbbfc35 );
        wait 5;
    }
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 0
// Checksum 0xf4543e77, Offset: 0x31a8
// Size: 0x19c
function function_604a3e80()
{
    level endon( #"flg_in_dining_room" );
    var_e534dcb = struct::get( "ai_alder_radio", "targetname" );
    
    if ( isdefined( level.adler ) )
    {
        level.adler animation::stop();
    }
    
    level scene::init( "scene_rev_3050_fir_cam_kitchen" );
    level flag::wait_till( "play_scene_civ_execute" );
    level thread scene::play( "scene_rev_3050_fir_cam_kitchen" );
    level flag::set( "flg_in_kitchen" );
    wait 0.75;
    level.park thread hms_util::dialogue( "vox_cp_cbcr_01400_park_adlertheresonem_84" );
    level waittill( #"hash_3cc679e60271f74d" );
    var_e534dcb hms_util::dialogue( "vox_cp_cbcr_01400_adlr_thanks_97", 1, "allies", "Alder" );
    level flag::wait_till( "flg_cctv_finished" );
    level scene::stop( "scene_rev_3050_fir_cam_kitchen", 1 );
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 1
// Checksum 0x2ee1c76d, Offset: 0x3350
// Size: 0x1ac
function function_c9b603f3( var_57ef78ed )
{
    level endon( #"hash_604e61bc28aebaeb" );
    actors[ #"door2" ] = getent( "cctv_exit_door_left", "targetname" );
    actors[ #"door1" ] = getent( "cctv_exit_door_right", "targetname" );
    e_clip = getent( "cctv_exit_door_left_clip", "targetname" );
    e_clip disconnectpaths();
    level thread function_39beb73c( actors );
    
    if ( var_57ef78ed == "floor_one" )
    {
        level waittill( #"hash_51b0d8debd24a46f" );
        level thread scene::play( "scene_rev_3040_fir_cctv_lazar", "enter" );
        level waittill( #"hash_14228b58001caf88" );
        level thread scene::play( "scene_rev_3040_fir_cctv_lazar", "lazar_loop" );
        return;
    }
    
    level thread scene::play( "scene_rev_3040_fir_cctv_lazar", "lazar_loop" );
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 1
// Checksum 0x31b2383f, Offset: 0x3508
// Size: 0xb4
function function_8d918610( var_57ef78ed )
{
    level endon( #"hash_604e61bc28aebaeb" );
    
    if ( var_57ef78ed == "floor_one" )
    {
        level waittill( #"hash_2217c60a57d6c9a3" );
        level scene::play( "scene_rev_3040_fir_cctv_lazar", "park_enter_45frames_after_lazar" );
    }
    
    level thread scene::play( "scene_rev_3040_fir_cctv_lazar", "park_loop" );
    level function_fd4c7e28();
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 1
// Checksum 0xe5bd6bc3, Offset: 0x35c8
// Size: 0x144
function function_39beb73c( actors )
{
    level flag::wait_till( "flg_cctv_int" );
    level notify( #"hash_604e61bc28aebaeb" );
    var_2cdf7dae = getaiteamarray( "axis" );
    
    foreach ( guy in var_2cdf7dae )
    {
        guy util::stop_magic_bullet_shield();
        guy deletedelay();
    }
    
    level flag::wait_till( "flg_cctv_finished" );
    level scene::play( "scene_rev_3040_fir_cctv_lazar", "exit", actors );
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 0
// Checksum 0xc68aa9ba, Offset: 0x3718
// Size: 0x98
function function_fd4c7e28()
{
    level endon( #"flg_VIP_spotted_in_cctv" );
    
    while ( true )
    {
        var_b621dade = "nag" + randomintrangeinclusive( 1, 3 );
        level scene::play( "scene_rev_3040_fir_cctv_lazar", var_b621dade );
        level scene::play( "scene_rev_3040_fir_cctv_lazar", "park_loop" );
    }
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 0
// Checksum 0xf6ee6664, Offset: 0x37b8
// Size: 0x64
function function_39f8bb19()
{
    level endon( #"flg_VIP_spotted_in_cctv" );
    level scene::play( "scene_rev_3040_fir_cctv_lazar", "enter" );
    level scene::play( "scene_rev_3040_fir_cctv_lazar", "lazar_loop" );
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 0
// Checksum 0xce0ee0d3, Offset: 0x3828
// Size: 0x1c
function function_dde2e307()
{
    hms_util::function_78c3826c( "scene_rev_3060_c4_gate" );
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 0
// Checksum 0x91468a2b, Offset: 0x3850
// Size: 0xa4
function function_78f15dd1()
{
    actors[ #"prop 1" ] = getent( "second_floor_stairway_door", "targetname" );
    level thread scene::init( "door_breach", actors );
    level flag::wait_till( "flg_door_breached_to_second_floor" );
    level scene::play( "door_breach", "init", actors );
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 1
// Checksum 0xb0bb36d5, Offset: 0x3900
// Size: 0x254
function function_e73fa40e( var_57ef78ed )
{
    a_ents[ #"door" ] = getent( "clean_room_door", "targetname" );
    level thread scene::init( "scene_rev_4010_nuke_room_lazar", a_ents );
    
    if ( var_57ef78ed != "2nd_floor" )
    {
        level flag::wait_till_all( array( "flg_player_nearing_vip_room_vo", "flg_vip_door_last_stand_enemies_dead" ) );
    }
    else
    {
        level flag::wait_till( "flg_player_nearing_vip_room_vo" );
    }
    
    level notify( #"hash_1c417066dc2e86a4" );
    level scene::play( "scene_rev_4010_nuke_room_lazar", "enter", a_ents );
    level thread scene::play( "scene_rev_4010_nuke_room_lazar", "loop", a_ents );
    level flag::wait_till( "play_nuke_room" );
    level.player util::function_749362d7( 1 );
    e_door_clip = getent( "nuke_room_door_clip", "targetname" );
    e_door_clip show();
    level thread scene::play( "scene_rev_4010_nuke_room_lazar", "close", a_ents );
    level flag::wait_till_all( [ "obj_photo_done", "flg_vo_in_nuke_room_complete" ] );
    e_door_clip delete();
    level thread scene::play_from_time( "scene_rev_4010_nuke_room_lazar", "exit", a_ents, 0.185897, 1, 1 );
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 1
// Checksum 0x953f56cc, Offset: 0x3b60
// Size: 0x364
function function_b91f9a58( var_57ef78ed )
{
    a_ents = [];
    a_ents[ #"park" ] = getent( "park", "targetname", 1 );
    a_ents[ #"scientist" ] = spawner::simple_spawn_single( getent( "vip_room_scientist_spawner", "targetname" ) );
    a_ents[ #"scientist" ] setmodel( "c_t9_cub_civ_male_scientist_body1" );
    level thread function_abdca9ef( a_ents );
    
    if ( var_57ef78ed != "2nd_floor" )
    {
        level flag::wait_till_all( array( "flg_player_nearing_vip_room_vo", "flg_vip_door_last_stand_enemies_dead" ) );
    }
    else
    {
        level flag::wait_till( "flg_player_nearing_vip_room_vo" );
    }
    
    level scene::play( "scene_rev_4010_nuke_room_lazar", "park_enter", a_ents );
    level thread scene::play( "scene_rev_4010_nuke_room_lazar", "park_enter_hold", a_ents );
    level flag::wait_till( "play_nuke_room" );
    level.park ai::poi_enable( 1, struct::get( "park_poi_start", "targetname" ) );
    level.park ai::set_behavior_attribute( "demeanor", "alert" );
    level.player util::function_749362d7( 1 );
    level scene::play( "scene_rev_4010_nuke_room_lazar", "park_enter2", a_ents );
    level.park lookatentity( level.player );
    
    if ( !level flag::get( "obj_photo_done" ) )
    {
        level function_f93bb53f();
    }
    
    level thread scene::play( "scene_rev_4010_nuke_room_lazar", "park_exit", a_ents );
    level thread function_fe6c4ca4();
    level.player util::function_749362d7( 0 );
    level waittill( #"flg_escape_bullets_start" );
    level thread scene::stop( "scene_rev_4010_nuke_room_lazar" );
    a_ents[ #"scientist" ] kill();
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 0, eflags: 0x4
// Checksum 0x6e9eba43, Offset: 0x3ed0
// Size: 0x7c
function private function_fe6c4ca4()
{
    s_scene = struct::get( "scene_rev_4010_nuke_room_lazar", "targetname" );
    var_207ec521 = s_scene.scene_ents[ #"prop 2" ];
    level waittill( #"hash_6c6472ced18e7153" );
    var_207ec521 hide();
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 0
// Checksum 0xb8b4dafe, Offset: 0x3f58
// Size: 0xac
function function_ad98871a()
{
    e_door_clip = getent( "nuke_room_door_clip", "targetname" );
    e_door_clip delete();
    a_ents[ #"door" ] = getent( "clean_room_door", "targetname" );
    level scene::skipto_end( "scene_rev_4010_nuke_room_lazar", "exit", a_ents, 1 );
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 1
// Checksum 0xc3570018, Offset: 0x4010
// Size: 0x34
function function_abdca9ef( a_ents )
{
    level thread scene::play( "scene_rev_4010_nuke_room", "body_loop", a_ents );
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 0
// Checksum 0xe8adf0f3, Offset: 0x4050
// Size: 0x138
function function_f93bb53f()
{
    level endon( #"hash_18231374474c1e10" );
    var_2f6b4bf5 = 0;
    level thread function_b3ef71a8();
    
    while ( !level flag::get( "obj_photo_done" ) )
    {
        if ( var_2f6b4bf5 == 0 )
        {
            level scene::play( "scene_rev_4010_nuke_room_lazar", "park_loop" );
            var_2f6b4bf5 = randomintrangeinclusive( 1, 2 );
            continue;
        }
        
        var_b621dade = "park_nag" + var_2f6b4bf5;
        level scene::play( "scene_rev_4010_nuke_room_lazar", var_b621dade );
        var_2f6b4bf5 = 0;
    }
    
    while ( !level flag::get( "flg_vo_in_nuke_room_complete" ) )
    {
        level scene::play( "scene_rev_4010_nuke_room_lazar", "park_loop" );
    }
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 0
// Checksum 0xde5e60f8, Offset: 0x4190
// Size: 0x84
function function_b3ef71a8()
{
    level endon( #"hash_18231374474c1e10" );
    
    while ( true )
    {
        if ( level flag::get( "obj_photo_done" ) && level flag::get( "flg_vo_in_nuke_room_complete" ) )
        {
            level notify( #"hash_18231374474c1e10" );
        }
        
        wait 0.1;
    }
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 0
// Checksum 0x4bede6f8, Offset: 0x4220
// Size: 0x488
function function_59320958()
{
    var_63802c77 = getent( "left_window_bullet_origin", "targetname" );
    var_79f11353 = getent( "right_window_bullet_origin", "targetname" );
    var_3cca49f5 = getent( "bullet_destination_1", "targetname" );
    var_2e72ad46 = getent( "bullet_destination_2", "targetname" );
    var_603a10d8 = getent( "bullet_destination_3", "targetname" );
    level flag::wait_till( "flg_escape_bullets_start" );
    level thread scene::play( "p9_fxanim_gp_hallway_glass_break_scene", "play" );
    magicbullet( getweapon( #"ar_accurate_t9" ), var_63802c77.origin, var_3cca49f5.origin );
    wait 0.2;
    magicbullet( getweapon( #"ar_accurate_t9" ), var_79f11353.origin, var_2e72ad46.origin );
    wait 0.1;
    magicbullet( getweapon( #"ar_accurate_t9" ), var_79f11353.origin, var_603a10d8.origin );
    wait 0.1;
    magicbullet( getweapon( #"ar_accurate_t9" ), var_79f11353.origin, var_2e72ad46.origin );
    wait 0.2;
    magicbullet( getweapon( #"ar_accurate_t9" ), var_63802c77.origin, var_3cca49f5.origin );
    wait 0.1;
    magicbullet( getweapon( #"ar_accurate_t9" ), var_79f11353.origin, var_603a10d8.origin );
    
    while ( !flag::get( "flg_escape_turn_off_window_bullets" ) )
    {
        magicbullet( getweapon( #"ar_accurate_t9" ), var_63802c77.origin, var_3cca49f5.origin );
        wait 0.2;
        magicbullet( getweapon( #"ar_accurate_t9" ), var_79f11353.origin, var_2e72ad46.origin );
        wait 0.1;
        magicbullet( getweapon( #"ar_accurate_t9" ), var_79f11353.origin, var_603a10d8.origin );
        wait 0.1;
        magicbullet( getweapon( #"ar_accurate_t9" ), var_79f11353.origin, var_2e72ad46.origin );
        wait 0.2;
        magicbullet( getweapon( #"ar_accurate_t9" ), var_63802c77.origin, var_3cca49f5.origin );
        wait 0.1;
        magicbullet( getweapon( #"ar_accurate_t9" ), var_79f11353.origin, var_603a10d8.origin );
    }
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 0
// Checksum 0x96cc7a6e, Offset: 0x46b0
// Size: 0x35c
function function_a1651470()
{
    var_cad35a6 = doors::get_doors( "escape_breach_door" );
    c_door = var_cad35a6[ 0 ].c_door;
    [[ c_door ]]->function_e7be6e76( 0, 1, 0, 0 );
    var_a2ac77ba = getentarray( "escape_front_right_civ_spawner", "targetname", 1 );
    var_a2ac77ba[ 1 ] thread civ_cower( "scene_rev_0000_ambient_cower13", 500 );
    var_a2ac77ba[ 2 ] thread civ_cower( "scene_rev_0000_ambient_cower14", 500 );
    a_ents = [];
    a_ents[ #"lazar" ] = getent( "lazar", "targetname", 1 );
    a_ents[ #"prop 1" ] = c_door.m_e_door;
    level scene::add_scene_func( "scene_rev_5010_esc_trapped_breach", &function_aecde30d, "breach_enter" );
    level scene::play( "scene_rev_5010_esc_trapped_breach", "breach_enter", a_ents );
    
    if ( ![[ c_door ]]->is_open() )
    {
        level.lazar thread hms_util::dialogue( "vox_cp_cbcr_01700_lazr_doorisjammed_3f" );
    }
    
    level flag::wait_till( "flg_escape_player_in_glass_hallway" );
    
    while ( !level flag::get( "flg_escape_door_open" ) )
    {
        level scene::play( "scene_rev_5010_esc_trapped_breach", "breach_loop", a_ents );
        level flag::set( "flg_lazar_in_position" );
    }
    
    var_d15c3251 = getnode( "node_post_door_kick", "targetname" );
    level.lazar thread spawner::go_to_node( var_d15c3251 );
    
    if ( !level flag::get( "flg_door_kicked" ) )
    {
        level flag::set( "flg_door_kicked" );
        level scene::play( "scene_rev_5010_esc_trapped_breach", "breach_exit", a_ents );
    }
    
    level.lazar waittill( #"goal" );
    wait 1.5;
    level flag::set( "flg_past_hallway" );
    level.lazar colors::enable();
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 1
// Checksum 0xbbb511d6, Offset: 0x4a18
// Size: 0x4c
function function_aecde30d( ents )
{
    c_door = ents[ #"prop 1" ].c_door;
    [[ c_door ]]->function_e7be6e76( 0, 0, 0, 0 );
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 4
// Checksum 0x679737aa, Offset: 0x4a70
// Size: 0x64
function function_8aab62a1( scene, var_3a51c5dc, loop_anim, ents )
{
    level scene::play( scene, var_3a51c5dc, ents );
    level scene::play( scene, loop_anim, ents );
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 0
// Checksum 0x2069ee72, Offset: 0x4ae0
// Size: 0x2c
function scene_rev_5030_rft_heliland()
{
    level scene::play( "scene_rev_5030_rft_heliland", "enter_player" );
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 1
// Checksum 0xb2bdb0e5, Offset: 0x4b18
// Size: 0x2f4
function function_ba3f106b( var_57ef78ed )
{
    if ( var_57ef78ed != "exfil" )
    {
        if ( isdefined( level.redshirt_1 ) )
        {
            var_4ab9f7af = struct::get( "redshirt_1_rooftop_struct" );
            level.redshirt_1 forceteleport( var_4ab9f7af.origin, var_4ab9f7af.angles );
            level.redshirt_1 colors::disable();
            level.redshirt_1.ignoreall = 1;
        }
        else
        {
            level hms_util::function_ee1d1df6( "redshirt_1", "Redshirt 1", "redshirt_1_rooftop_struct" );
            level.redshirt_1 colors::disable();
            level.redshirt_1.ignoreall = 1;
        }
        
        if ( isdefined( level.redshirt_2 ) )
        {
            var_657624 = struct::get( "redshirt_2_rooftop_struct" );
            level.redshirt_2 forceteleport( var_657624.origin, var_657624.angles );
            level.redshirt_2 colors::disable();
            level.redshirt_2.ignoreall = 1;
        }
        else
        {
            level hms_util::function_ee1d1df6( "redshirt_2", "Redshirt 2", "redshirt_2_rooftop_struct" );
            level.redshirt_2 colors::disable();
            level.redshirt_2.ignoreall = 1;
        }
    }
    
    if ( var_57ef78ed == "escape" )
    {
        flag::wait_till( "flg_escape_heli_flyby" );
    }
    
    if ( var_57ef78ed == "escape" || var_57ef78ed == "rooftop" )
    {
        level scene::init( "scene_rev_5040_rtp_balloon_release" );
        level flag::wait_till( "flg_regroup_with_team" );
        level scene::play( "scene_rev_5040_rtp_balloon_release", "main" );
    }
    
    level thread scene::play( "scene_rev_5040_rtp_balloon_release", "balloon_air_loop" );
    level flag::set( "flg_setup_skyhook_done" );
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 0
// Checksum 0x9ff85156, Offset: 0x4e18
// Size: 0x34
function function_fe8c8150()
{
    level thread function_617f5754();
    level thread function_1c03801f();
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 0
// Checksum 0x10a2847f, Offset: 0x4e58
// Size: 0xf6
function function_617f5754()
{
    level endon( #"hash_253be3e72f1d36e0" );
    level scene::play( "scene_rev_5045a_rtp_balloon_defend", "start" );
    level flag::set( "flg_park_skyhook_ready" );
    
    for ( i = 0; true ; i = 0 )
    {
        if ( i == 0 )
        {
            level scene::play( "scene_rev_5045a_rtp_balloon_defend", "idle_loop" );
            i = randomintrangeinclusive( 1, 4 );
            continue;
        }
        
        level scene::play( "scene_rev_5045a_rtp_balloon_defend", "nag" + i );
    }
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 0
// Checksum 0xe61854a9, Offset: 0x4f58
// Size: 0x84
function function_1c03801f()
{
    level endon( #"hash_253be3e72f1d36e0" );
    level scene::play( "scene_rev_5045b_rtp_balloon_defend", "start" );
    level flag::set( "flg_lazar_skyhook_ready" );
    level scene::play( "scene_rev_5045b_rtp_balloon_defend", "idle_loop" );
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 0
// Checksum 0x2d0b197, Offset: 0x4fe8
// Size: 0x2fc
function function_23334bfb()
{
    level.player val::set( #"hash_3de08cce7bf91456", "disable_weapons", 1 );
    level.player val::set( #"hash_3de08cce7bf91456", "freezecontrols_allowlook", 1 );
    wait 0.4;
    level notify( #"hash_253be3e72f1d36e0" );
    level scene::stop( "scene_rev_5045a_rtp_balloon_defend" );
    level scene::stop( "scene_rev_5045b_rtp_balloon_defend" );
    level scene::play( "scene_rev_5050_rtp_extract", "hookup_explosion" );
    level.player val::reset_all( #"hash_3de08cce7bf91456" );
    level flag::set( "flg_exfil_explosion_hit" );
    s_tag = struct::get( "tag_align_rev_skyhook" );
    var_60a25e22 = getcorpsearray( s_tag.origin, 256 );
    array::delete_all( var_60a25e22 );
    level.lazar detach( level.lazar.head );
    level.park detach( level.park.head );
    level.lazar attach( "c_t9_cp_usa_hero_lazar_head1_revolucion_infil_explosion" );
    level.park attach( "c_t9_cp_eng_hero_park_head_revolucion_infil_explosion" );
    level.lazar setmodel( "c_t9_cp_usa_hero_lazar_revolucion_infil_dirty_body" );
    level.park setmodel( "c_t9_cp_eng_hero_park_revolucion_infil_body_explosion" );
    level flag::set( "flg_choice_nags" );
    level scene::play( "scene_rev_5050_rtp_extract", "explosion_getup" );
    level scene::stop( "scene_rev_5040_rtp_balloon_release", 1 );
    level scene::play( "scene_rev_5050_rtp_extract", "choice_loop" );
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 0
// Checksum 0xe9c0f5f2, Offset: 0x52f0
// Size: 0x2c
function function_67b48edc()
{
    level scene::play( "scene_rev_5050_rtp_extract", "choose_park" );
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 0
// Checksum 0x95b91a5, Offset: 0x5328
// Size: 0x2c
function function_5bbd4049()
{
    level scene::play( "scene_rev_5050_rtp_extract", "choose_lazar" );
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 0
// Checksum 0x21a1c9ad, Offset: 0x5360
// Size: 0x2c
function function_d4b87197()
{
    level scene::play( "scene_rev_5050_rtp_extract", "choose_fail" );
}

// Namespace namespace_a789f8ae/namespace_594810e6
// Params 2
// Checksum 0xea6d0d5c, Offset: 0x5398
// Size: 0xec
function civ_cower( var_fa359e06, var_67b4e975 )
{
    self endon( #"death" );
    actors[ #"guy" ] = self;
    level thread scene::play( var_fa359e06, "cower_loop", actors );
    
    while ( !( level.player islookingat( self ) && distancesquared( level.player.origin, self.origin ) <= var_67b4e975 * var_67b4e975 ) )
    {
        wait 0.1;
    }
    
    level thread scene::play( var_fa359e06, "extreme_loop", actors );
}

