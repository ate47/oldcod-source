#using script_1fd2c6e5fc8cb1c3;
#using script_44aef2868ad2e317;
#using script_47734f62e0b3b388;
#using script_4ec222619bffcfd1;
#using script_5513c8efed5ff300;
#using script_779f525443585713;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\corpse;
#using scripts\core_common\stealth\enemy;
#using scripts\core_common\stealth\threat_sight;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\dialog_tree;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\skipto;
#using scripts\cp_common\ui\ent_name;
#using scripts\cp_common\util;

#namespace kgb_ins_rv;

// Namespace kgb_ins_rv/namespace_2de23526
// Params 1
// Checksum 0x66afb496, Offset: 0xa38
// Size: 0x4c
function starting( *var_d3440450 )
{
    level thread scene::init( "scene_kgb_poison_tea" );
    level thread scene::init( "scene_kgb_elevator_holdup" );
}

// Namespace kgb_ins_rv/namespace_2de23526
// Params 2
// Checksum 0xec1dda9e, Offset: 0xa90
// Size: 0x164
function main( var_d3440450, var_50cc0d4f )
{
    level thread function_9987ec40();
    level scene::add_scene_func( "scene_kgb_walkup_charkov", &function_ec6bb2ec );
    level thread function_57279bf6();
    
    if ( is_true( var_50cc0d4f ) )
    {
        kgb_ins_prepare::function_52f0fcb3();
        kgb_ins_prepare::function_84d00884();
        level thread namespace_99e99ffa::function_99e99ffa( var_d3440450 );
        level thread namespace_e77bf565::function_ada6d016();
        level thread kgb_ins_prepare::function_799b3854();
        level thread function_1f4d29f8();
    }
    
    level flag::wait_till( "ins_rv_complete" );
    level thread namespace_e77bf565::function_8191bcdc();
    
    if ( isdefined( var_d3440450 ) )
    {
        skipto::function_4e3ab877( var_d3440450 );
    }
}

// Namespace kgb_ins_rv/namespace_2de23526
// Params 4
// Checksum 0x8fe226d7, Offset: 0xc00
// Size: 0x24
function cleanup( *name, *starting, *direct, *player )
{
    
}

// Namespace kgb_ins_rv/namespace_2de23526
// Params 0
// Checksum 0x4567bca4, Offset: 0xc30
// Size: 0x204
function init_flags()
{
    level flag::init( "ins_rv_complete" );
    level flag::init( "flag_player_swap" );
    level flag::init( "flag_player_swap_complete" );
    level flag::init( "flag_takedown_success" );
    level flag::init( "flag_elevator_activated" );
    level flag::init( "remove_takedown_prompt" );
    level flag::init( "remove_clothing_prompt" );
    level flag::init( "flag_prep_elevator" );
    level flag::init( "flag_checkpoint_done" );
    level flag::init( "flag_player_bag" );
    level flag::init( "flag_player_passed_checkpoint" );
    level flag::init( "flag_start_rv_bread" );
    level flag::init( "flag_gate_pass" );
    level flag::init( "checkpoint_crossed" );
    level flag::init( "flag_door_picked" );
    level flag::init( "flag_fake_touch" );
}

// Namespace kgb_ins_rv/namespace_2de23526
// Params 0
// Checksum 0x80f724d1, Offset: 0xe40
// Size: 0x4
function init_clientfields()
{
    
}

// Namespace kgb_ins_rv/namespace_2de23526
// Params 0
// Checksum 0xefc5c553, Offset: 0xe50
// Size: 0x34
function function_22b7fffd()
{
    spawner::add_spawn_function_group( "prison_guys", "script_noteworthy", &function_c1e43496 );
}

// Namespace kgb_ins_rv/namespace_2de23526
// Params 0
// Checksum 0x12de9551, Offset: 0xe90
// Size: 0x21c
function function_20d719f6()
{
    var_b81aabcb = struct::get( "rv_bread_2", "targetname" );
    var_a9f00f76 = struct::get( "rv_bread_3", "targetname" );
    var_1accf12e = struct::get( "rv_bread_4", "targetname" );
    var_c8754a3 = struct::get( "struct_player_swap", "targetname" );
    level flag::set( "flag_start_rv_bread" );
    level flag::wait_till_any( [ "flag_rv_bread_1", "flag_rv_bread_3", "flag_open_basement" ] );
    objectives::update_position( "obj_swap", var_b81aabcb.origin );
    level flag::wait_till_any( [ "flag_rv_bread_2", "flag_rv_bread_3" ] );
    objectives::update_position( "obj_swap", var_a9f00f76.origin );
    level flag::wait_till_any( [ "flag_rv_bread_3", "flag_rv_bread_4" ] );
    objectives::update_position( "obj_swap", var_1accf12e.origin );
    level flag::wait_till( "flag_rv_bread_4" );
    objectives::update_position( "obj_swap", var_c8754a3.origin );
}

// Namespace kgb_ins_rv/namespace_2de23526
// Params 0
// Checksum 0x1981368d, Offset: 0x10b8
// Size: 0x124
function function_1f4d29f8()
{
    wait 1;
    var_53aae2e9 = struct::get( "rv_bread_1", "targetname" );
    objectives::function_4eb5c04a( #"obj_swap", var_53aae2e9.origin, #"hash_4e76340f1479c31a" );
    level thread function_20d719f6();
    level flag::wait_till( "flag_player_swap" );
    namespace_e77bf565::function_c4de67de();
    objectives::complete( #"obj_swap" );
    namespace_353d803e::music( "deactivate_6.0_basement" );
    level flag::wait_till( "flag_player_swap_complete" );
    level thread function_eb4677fe();
}

// Namespace kgb_ins_rv/namespace_2de23526
// Params 0
// Checksum 0xe2d19d42, Offset: 0x11e8
// Size: 0x21c
function function_eb4677fe()
{
    location = struct::get( "struct_elevator_activate", "targetname" );
    objectives::follow( #"hash_7013ad55135deb2e", [ level.adler ], #"hash_440a805ccf9d5df8", 0 );
    level flag::wait_till( "flag_aslt_entry_prompt_door" );
    objectives::hide( #"hash_7013ad55135deb2e", [ level.adler ] );
    spot = struct::get( "checkpoint_interact" );
    objectives::function_4eb5c04a( #"hash_418d7e86c7441a8b", spot.origin + ( 0, 0, 8 ), undefined, 0, 1 );
    objectives_ui::function_49dec5b( #"hash_418d7e86c7441a8b", undefined, #"hash_1b2da47a0dd85d2d" );
    level flag::wait_till( "flag_aslt_entry_door" );
    objectives::remove( #"hash_418d7e86c7441a8b" );
    objectives::show( #"hash_7013ad55135deb2e", [ level.adler ] );
    level flag::wait_till( "team_in_elevator" );
    objectives::complete( #"hash_7013ad55135deb2e" );
}

// Namespace kgb_ins_rv/namespace_2de23526
// Params 0
// Checksum 0x4a0084d7, Offset: 0x1410
// Size: 0xbc
function function_165e5918()
{
    level endon( #"hash_43fb421b5c84be9d" );
    var_2757e05d = [ "vox_cp_rkgb_02000_blkv_adleriswaitingo_9d", "vox_cp_rkgb_02000_blkv_mykeycardtaskis_5b" ];
    var_67f23465 = 25;
    
    for ( count = 0; !level flag::get( "flag_player_swap" ) ; count++ )
    {
        wait var_67f23465 + count * 5;
        level.players[ 0 ] thread objectives_ui::show_objectives();
    }
}

// Namespace kgb_ins_rv/namespace_2de23526
// Params 0
// Checksum 0x4321ad9c, Offset: 0x14d8
// Size: 0x5c
function function_9987ec40()
{
    level thread function_a459deb9();
    level flag::wait_till( "flag_checkpoint_done" );
    level flag::set( "ins_rv_complete" );
}

// Namespace kgb_ins_rv/namespace_2de23526
// Params 0
// Checksum 0x147db63c, Offset: 0x1540
// Size: 0x64
function function_57279bf6()
{
    level thread scene::init( "scene_kgb_prisoner_vignette" );
    level flag::wait_till( "flag_prison_scene" );
    level thread scene::play( "scene_kgb_prisoner_vignette" );
}

// Namespace kgb_ins_rv/namespace_2de23526
// Params 1
// Checksum 0x180b04a4, Offset: 0x15b0
// Size: 0x2a
function function_32137f1e( *prompt )
{
    return level flag::get( "flag_allow_boiler_door" );
}

// Namespace kgb_ins_rv/namespace_2de23526
// Params 0
// Checksum 0x967c9bca, Offset: 0x15e8
// Size: 0x89c
function function_a459deb9()
{
    player = getplayers()[ 0 ];
    level thread scene::init( "scene_kgb_acquire_disguises_props" );
    struct = struct::get( "struct_swap_door_handle", "targetname" );
    tag = spawn( "script_model", struct.origin );
    tag setmodel( "tag_origin" );
    tag util::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), #"hash_1b2da47a0dd85d2d", 32, 0.25, undefined, undefined, undefined, undefined, undefined, undefined, undefined, &function_32137f1e );
    tag waittill( #"trigger" );
    level.belikov = namespace_e77bf565::function_e4660071( undefined );
    level.belikov.ignoreme = 1;
    level.belikov.ignoreall = 1;
    level.belikov util::stop_magic_bullet_shield();
    level.adler = namespace_e77bf565::adler_spawn( "kgb_ins_rv" );
    level.adler.ignoreme = 1;
    level.adler.ignoreall = 1;
    level.adler namespace_e77bf565::function_5770c74( "civ" );
    doorclip = getent( "basement_door_clip", "targetname" );
    doorclip notsolid();
    player setmovespeedscale( 0.5 );
    level notify( #"hash_43fb421b5c84be9d" );
    tag delete();
    level flag::set( "flag_player_swap" );
    player.ignoreme = 1;
    player.ignoreall = 1;
    player notify( #"show_itin" );
    var_4f2ba130 = level.players[ 0 ] getweaponslistprimaries();
    
    foreach ( e_w in var_4f2ba130 )
    {
        player takeweapon( e_w );
    }
    
    var_2501edf5 = getweapon( #"hash_2e69a5838b2f3ca3" );
    player giveweapon( var_2501edf5 );
    player switchtoweapon( var_2501edf5 );
    level thread function_4105690c();
    level notify( #"hash_2b4c93f5ce723277" );
    function_ea00197c();
    level notify( #"hash_58a05e82d72c9b91" );
    level thread function_4a8d44b7();
    level thread function_7c1c5aff( "Fail", 0 );
    util::delay_notify( 6.5, "takedown_logic_cleanup" );
    level waittill( #"takedown_done" );
    level thread scene::play( "scene_kgb_acquire_disguises_inside", "Insideman_Exit" );
    level thread scene::play( "scene_kgb_acquire_disguises_props", "Insideman_Exit" );
    level function_484bfb02();
    level thread scene::stop( "scene_kgb_acquire_disguises_props", 1 );
    waitframe( 1 );
    level thread scene::init( "scene_kgb_walkup_adler" );
    level thread scene::init( "scene_kgb_acquire_disguises_props" );
    clip = getent( "prison_door_clip", "targetname" );
    clip solid();
    doorclip = getent( "basement_door_clip", "targetname" );
    doorclip solid();
    level notify( #"hash_1f303ec0c8e6bc2b" );
    level thread function_203098f4();
    level.adler namespace_e77bf565::function_5770c74();
    level thread scene::play( "scene_kgb_acquire_disguises_player", "Outro" );
    level thread scene::play( "scene_kgb_acquire_disguises_bag", "Outro" );
    level scene::play( "scene_kgb_acquire_disguises_actors", "Outro" );
    level flag::set( "flag_player_swap_complete" );
    level thread function_1e56b6d7();
    level thread scene::play( "scene_kgb_walkup_gate_guard", "Shot 1" );
    level scene::play( "scene_kgb_walkup_adler", "Shot 1", [ level.adler ] );
    level thread scene::play( "scene_kgb_walkup_adler", "Shot 2", [ level.adler ] );
    level flag::wait_till( "flag_aslt_upstairs" );
    level flag::set( "flag_prep_elevator" );
    level thread kgb_aslt_entry::function_272c06e0();
    level thread scene::play( "scene_kgb_walkup_gate_guard", "Shot 2" );
    thread namespace_353d803e::function_1ef37bcf();
    namespace_353d803e::music( "8.2_cello_stingers_1" );
    wait 0.5;
    clip notsolid();
    level thread scene::play( "scene_kgb_walkup_adler", "Shot 3", [ level.adler ] );
    level flag::set( "flag_checkpoint_done" );
    level thread function_f59868de();
}

// Namespace kgb_ins_rv/namespace_2de23526
// Params 0
// Checksum 0x1513c101, Offset: 0x1e90
// Size: 0x24
function function_f59868de()
{
    wait 15;
    level flag::set( "flag_aslt_entry_prompt_door" );
}

// Namespace kgb_ins_rv/namespace_2de23526
// Params 1
// Checksum 0x78a24bed, Offset: 0x1ec0
// Size: 0x2a4
function function_7f604b6c( a_ents )
{
    var_6c8e469b = a_ents[ #"guard1" ];
    var_56c10933 = a_ents[ #"guard2" ];
    var_4040d2b7 = "c_t9_cp_rus_kgb_hq_officer_nude_body1";
    var_732d50b1 = "c_t9_rus_kgb_guard_head02_b_nohat";
    var_56c10933 detach( var_56c10933.head );
    waitframe( 1 );
    var_56c10933 attach( "c_t9_rus_kgb_officer_head01" );
    level thread function_62724642();
    var_6c8e469b thread function_f5422572();
    var_56c10933 thread function_f5422572();
    var_dd7544b0 = getplayers()[ 0 ] namespace_70eba6e6::function_33bf99f8();
    
    if ( var_dd7544b0 == 2 )
    {
        var_6c8e469b setmodel( "c_t9_ger_civ_female_urban_06_body" );
        var_6c8e469b detach( var_6c8e469b.head );
        waitframe( 1 );
        var_6c8e469b attach( "c_t9_ger_civ_female_head01" );
        var_4040d2b7 = "c_t9_base_female_nude_arms1";
        var_732d50b1 = "c_t9_ger_civ_female_head01";
    }
    
    level waittill( #"hash_1f303ec0c8e6bc2b" );
    var_56c10933 setmodel( "c_t9_cp_rus_kgb_hq_officer_nude_body1" );
    var_56c10933 detach( var_56c10933.head );
    var_6c8e469b setmodel( var_4040d2b7 );
    
    if ( var_dd7544b0 != 2 )
    {
        var_6c8e469b detach( var_6c8e469b.head );
    }
    
    waitframe( 1 );
    
    if ( var_dd7544b0 != 2 )
    {
        var_6c8e469b attach( var_732d50b1 );
    }
    
    var_56c10933 attach( "c_t9_rus_kgb_guard_head01_nohat" );
}

// Namespace kgb_ins_rv/namespace_2de23526
// Params 0
// Checksum 0xfcb20b60, Offset: 0x2170
// Size: 0xa6
function function_f5422572()
{
    guy = self;
    player = getplayers()[ 0 ];
    
    while ( !level flag::get( "remove_takedown_prompt" ) )
    {
        if ( guy function_7f7143e4( player, 1 ) && !level.var_2f043e81 )
        {
            level flag::set( "flag_player_caught" );
        }
        
        waitframe( 1 );
    }
}

// Namespace kgb_ins_rv/namespace_2de23526
// Params 0
// Checksum 0x293e4848, Offset: 0x2220
// Size: 0x8c
function function_62724642()
{
    level endon( #"takedown_logic_cleanup" );
    level flag::wait_till( "flag_player_caught" );
    
    if ( level flag::get( "flag_takedown_success" ) )
    {
        return;
    }
    
    util::missionfailedwrapper( #"hash_550c07dd465d6af7", #"hash_279386ca165e2a02" );
}

// Namespace kgb_ins_rv/namespace_2de23526
// Params 0
// Checksum 0x2221b35, Offset: 0x22b8
// Size: 0x114
function function_ea00197c()
{
    level scene::add_scene_func( "scene_kgb_acquire_disguises_actors", &function_7f604b6c );
    level thread scene::play( "scene_kgb_acquire_disguises_player", "Intro" );
    level thread scene::play( "scene_kgb_acquire_disguises_props", "Intro" );
    level thread scene::play( "scene_kgb_acquire_disguises_actors", "Intro" );
    level thread scene::play( "scene_kgb_acquire_disguises_bag", "Intro" );
    level thread function_18aea9a4();
    level thread scene::play( "scene_kgb_acquire_disguises_inside", "Intro" );
    wait 59.8;
}

// Namespace kgb_ins_rv/namespace_2de23526
// Params 0
// Checksum 0xe8f1b0a7, Offset: 0x23d8
// Size: 0xb4
function function_18aea9a4()
{
    level.var_2f043e81 = 0;
    wait 38;
    struct = struct::get( "struct_takedown_hide", "targetname" );
    objectives::goto( "hide_spot", struct.origin, undefined, undefined, 0, "cp_waypoint_kgb_hide" );
    level thread function_b6b893f4();
    level waittill( #"hash_58a05e82d72c9b91" );
    objectives::complete( "hide_spot" );
}

// Namespace kgb_ins_rv/namespace_2de23526
// Params 0
// Checksum 0xa15427ba, Offset: 0x2498
// Size: 0x10e
function function_b6b893f4()
{
    level endon( #"hash_58a05e82d72c9b91" );
    player = getplayers()[ 0 ];
    player endon( #"death" );
    vol = getent( "vol_takedown_hide", "targetname" );
    
    while ( true )
    {
        if ( player istouching( vol ) )
        {
            level.var_2f043e81 = 1;
            objectives::hide( "hide_spot" );
            
            while ( player istouching( vol ) )
            {
                waitframe( 1 );
            }
            
            level.var_2f043e81 = 0;
            objectives::show( "hide_spot" );
        }
        
        waitframe( 1 );
    }
}

// Namespace kgb_ins_rv/namespace_2de23526
// Params 0
// Checksum 0x115de745, Offset: 0x25b0
// Size: 0x54
function function_e006a09a()
{
    level thread scene::play( "scene_kgb_acquire_disguises_inside", "Kill_Loop" );
    level thread scene::play( "scene_kgb_acquire_disguises_actors", "Kill_Loop" );
}

// Namespace kgb_ins_rv/namespace_2de23526
// Params 2
// Checksum 0x4a3b74ed, Offset: 0x2610
// Size: 0x108
function function_7c1c5aff( shot_name, var_8cb24cdb )
{
    level notify( #"hash_37cef3976d327d1f" );
    level endon( #"hash_37cef3976d327d1f" );
    
    if ( var_8cb24cdb )
    {
        level childthread scene::play( "scene_kgb_acquire_disguises_player", shot_name );
        level childthread function_15386625( shot_name );
        level scene::play( "scene_kgb_acquire_disguises_inside", shot_name );
    }
    else
    {
        level childthread scene::play( "scene_kgb_acquire_disguises_bag", shot_name );
        level childthread function_15386625( shot_name );
        level scene::play( "scene_kgb_acquire_disguises_inside", shot_name );
    }
    
    level notify( #"takedown_done" );
}

// Namespace kgb_ins_rv/namespace_2de23526
// Params 1
// Checksum 0x806f9b96, Offset: 0x2720
// Size: 0x9c
function function_15386625( shot_name )
{
    level thread scene::play( "scene_kgb_acquire_disguises_bag", shot_name );
    level scene::play( "scene_kgb_acquire_disguises_actors", shot_name );
    level thread scene::play( "scene_kgb_acquire_disguises_bag", "Fail_Loop" );
    level thread scene::play( "scene_kgb_acquire_disguises_actors", "Fail_Loop" );
}

// Namespace kgb_ins_rv/namespace_2de23526
// Params 0
// Checksum 0xcf917dc7, Offset: 0x27c8
// Size: 0x54
function function_8f07753c()
{
    level thread scene::play( "scene_kgb_acquire_disguises_bag", "Fail_Loop" );
    level thread scene::play( "scene_kgb_acquire_disguises_actors", "Fail_Loop" );
}

// Namespace kgb_ins_rv/namespace_2de23526
// Params 0
// Checksum 0xb21201a, Offset: 0x2828
// Size: 0x24
function function_203098f4()
{
    wait 0.5;
    level thread lui::screen_fade_in( 1 );
}

// Namespace kgb_ins_rv/namespace_2de23526
// Params 0
// Checksum 0xf03cea05, Offset: 0x2858
// Size: 0x44
function function_ab071d71()
{
    level waittill( #"start_fade_out" );
    level lui::screen_fade_out( 1.5, "black" );
}

// Namespace kgb_ins_rv/namespace_2de23526
// Params 0
// Checksum 0xf67a0d1, Offset: 0x28a8
// Size: 0x1ee
function function_4a8d44b7()
{
    player = getplayers()[ 0 ];
    level endon( #"takedown_logic_cleanup" );
    wait 0.05;
    player notifyonplayercommand( "weapon_melee", "+melee" );
    player notifyonplayercommand( "weapon_melee", "+melee_zoom" );
    struct = struct::get( "struct_takedown_prompt", "targetname" );
    trig = spawn( "trigger_radius", struct.origin, 0, 96, 96 );
    trig sethintstring( #"hash_56cec4baa5332ed0" );
    trig setteamfortrigger( player.team );
    trig thread function_b3dcc32f();
    level thread function_6cff03c4();
    
    while ( true )
    {
        if ( player istouching( trig ) )
        {
            level flag::set( "flag_fake_touch" );
            
            while ( player istouching( trig ) )
            {
                waitframe( 1 );
            }
            
            level flag::clear( "flag_fake_touch" );
        }
        
        waitframe( 1 );
    }
}

// Namespace kgb_ins_rv/namespace_2de23526
// Params 0
// Checksum 0x10f66b55, Offset: 0x2aa0
// Size: 0xa2
function function_6cff03c4()
{
    player = getplayers()[ 0 ];
    level endon( #"takedown_logic_cleanup" );
    
    while ( true )
    {
        player waittill( #"weapon_melee" );
        
        if ( level flag::get( "flag_fake_touch" ) )
        {
            level thread function_5f64631f();
            break;
        }
        
        waitframe( 1 );
    }
}

// Namespace kgb_ins_rv/namespace_2de23526
// Params 1
// Checksum 0x55fba62, Offset: 0x2b50
// Size: 0x7c
function function_5f64631f( *prompt_struct )
{
    level flag::set( "flag_takedown_success" );
    level notify( #"takedown_logic_cleanup" );
    namespace_353d803e::music( "7.1_attack_sting" );
    level thread function_7c1c5aff( "Success", 1 );
}

// Namespace kgb_ins_rv/namespace_2de23526
// Params 0
// Checksum 0x5d2a3dca, Offset: 0x2bd8
// Size: 0x54
function function_b3dcc32f()
{
    level waittill( #"takedown_logic_cleanup" );
    level flag::set( "remove_takedown_prompt" );
    self delete();
}

// Namespace kgb_ins_rv/namespace_2de23526
// Params 0
// Checksum 0x50a686c2, Offset: 0x2c38
// Size: 0x22c
function function_484bfb02()
{
    player = getplayers()[ 0 ];
    wait 9;
    struct = struct::get( "struct_takedown_clothes", "targetname" );
    tag = spawn( "script_model", struct.origin );
    tag setmodel( "tag_origin" );
    tag util::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), #"hash_2d8a46f8111bd39c", 80 );
    tag waittill( #"trigger" );
    namespace_353d803e::music( "8.0_undercover", 3.5 );
    diff = tag.origin - player.origin;
    tag delete();
    level thread function_3262752b( 2 );
    level flag::set( "remove_clothing_prompt" );
    
    if ( diff[ 0 ] < 0 )
    {
        level thread scene::play( "scene_kgb_acquire_disguises_actors", "Change_Clothes" );
        level scene::play( "scene_kgb_acquire_disguises_player", "Change_Clothes" );
        return;
    }
    
    level thread scene::play( "scene_kgb_acquire_disguises_actors", "Change_Clothes_Alt" );
    level scene::play( "scene_kgb_acquire_disguises_player", "Change_Clothes_Alt" );
}

// Namespace kgb_ins_rv/namespace_2de23526
// Params 1
// Checksum 0xb61e0b06, Offset: 0x2e70
// Size: 0x34
function function_3262752b( time )
{
    wait time;
    level thread lui::screen_fade_out( 1.5, "black" );
}

// Namespace kgb_ins_rv/namespace_2de23526
// Params 0
// Checksum 0x80f724d1, Offset: 0x2eb0
// Size: 0x4
function function_3f5c3b7c()
{
    
}

// Namespace kgb_ins_rv/namespace_2de23526
// Params 0
// Checksum 0xad7b9913, Offset: 0x2ec0
// Size: 0xbc
function function_4105690c()
{
    level waittill( #"hash_64846a612e785746" );
    level lui::screen_fade_out( 0.75, "black" );
    wait 1;
    level lui::screen_fade_in( 0.5 );
    wait 0.5;
    level thread globallogic_ui::function_7bc0e4b9( 0, 1 );
    level thread savegame::checkpoint_save();
    namespace_353d803e::music( "7.0_tunnels" );
}

// Namespace kgb_ins_rv/namespace_2de23526
// Params 0
// Checksum 0x8c441656, Offset: 0x2f88
// Size: 0xb4
function function_1e56b6d7()
{
    level thread function_3209e378();
    level thread function_49f1319a();
    level flag::wait_till( "flag_player_checkpoint_start" );
    level scene::stop( "scene_kgb_walkup_hall_talk", 1 );
    level scene::stop( "scene_kgb_walkup_stairs_duo", 1 );
    level scene::stop( "scene_kgb_walkup_charkov", 1 );
}

// Namespace kgb_ins_rv/namespace_2de23526
// Params 0
// Checksum 0x9649ee51, Offset: 0x3048
// Size: 0xcc
function function_3209e378()
{
    level thread scene::play( "scene_kgb_walkup_hall_talk", "Shot 1" );
    level.adler waittill( #"hash_2c9839971e87b765" );
    namespace_353d803e::music( "8.2_cello_stingers_1" );
    level thread scene::play( "scene_kgb_walkup_hall_talk", "Shot 2" );
    
    if ( level flag::get( "flag_checkpoint_moment_done" ) )
    {
        level thread scene::play( "scene_kgb_walkup_charkov" );
    }
}

// Namespace kgb_ins_rv/namespace_2de23526
// Params 0
// Checksum 0x4b2df249, Offset: 0x3120
// Size: 0x44
function function_49f1319a()
{
    level.adler waittill( #"hash_5f3452bc1c48bf4d" );
    level thread scene::play( "scene_kgb_walkup_stairs_duo", "Shot 1" );
}

// Namespace kgb_ins_rv/namespace_2de23526
// Params 2
// Checksum 0x966eed3a, Offset: 0x3170
// Size: 0x1ca, Type: bool
function function_7f7143e4( player, var_7b20e52b )
{
    if ( isdefined( self.targetname ) && self.targetname == "prisoner" )
    {
        return false;
    }
    
    angles = self gettagangles( "tag_eye" );
    v_forward = anglestoforward( angles );
    v_loc = player geteye();
    v_dir = vectornormalize( v_loc - self gettagorigin( "tag_eye" ) );
    dp = vectordot( v_forward, v_dir );
    
    if ( dp > 0.6 )
    {
        if ( is_true( var_7b20e52b ) )
        {
            v_loc = player.origin + ( 0, 0, 48 );
            
            if ( sighttracepassed( self gettagorigin( "tag_eye" ), v_loc, 0, self ) )
            {
                dist = distance2dsquared( self gettagorigin( "tag_eye" ), v_loc );
                
                if ( dist < 1960000 )
                {
                    return true;
                }
            }
        }
        
        return false;
    }
    
    return false;
}

// Namespace kgb_ins_rv/namespace_2de23526
// Params 1
// Checksum 0x3452ee9, Offset: 0x3348
// Size: 0x324
function function_ce801c8b( *starting )
{
    level scene::add_scene_func( "scene_kgb_walkup_charkov", &function_ec6bb2ec );
    level flag::set( "flag_player_swap_complete" );
    level flag::set( "flag_checkpoint_moment_done" );
    level thread function_9987ec40();
    level.adler = namespace_e77bf565::adler_spawn( "kgb_ins_rv" );
    level.adler.ignoreme = 1;
    level.adler.ignoreall = 1;
    level thread scene::play( "scene_kgb_acquire_disguises_actors", "Change_Clothes_Alt" );
    level scene::play( "scene_kgb_acquire_disguises_player", "Change_Clothes_Alt" );
    level.adler namespace_e77bf565::function_5770c74();
    level thread function_1e56b6d7();
    player = getplayers()[ 0 ];
    player setmovespeedscale( 0.5 );
    clip = getent( "prison_door_clip", "targetname" );
    level thread scene::play( "scene_kgb_walkup_gate_guard", "Shot 1" );
    level scene::play( "scene_kgb_walkup_adler", "Shot 1", [ level.adler ] );
    level thread scene::play( "scene_kgb_walkup_adler", "Shot 2", [ level.adler ] );
    level flag::wait_till( "flag_aslt_upstairs" );
    level flag::set( "flag_prep_elevator" );
    level thread kgb_aslt_entry::function_272c06e0();
    level thread scene::play( "scene_kgb_walkup_gate_guard", "Shot 2" );
    wait 2;
    clip notsolid();
    level thread scene::play( "scene_kgb_walkup_adler", "Shot 3", [ level.adler ] );
}

// Namespace kgb_ins_rv/namespace_2de23526
// Params 1
// Checksum 0xfa6b79dd, Offset: 0x3678
// Size: 0x4c
function function_7a89c7d8( a_ents )
{
    a_ents[ #"hash_25c349eb26f191d7" ] thread function_c1e43496();
    a_ents[ #"hash_25c34aeb26f1938a" ] thread function_c1e43496();
}

// Namespace kgb_ins_rv/namespace_2de23526
// Params 1
// Checksum 0xf2af23d, Offset: 0x36d0
// Size: 0x6c
function function_32e58509( a_ents )
{
    a_ents[ #"warden" ] thread function_c1e43496();
    a_ents[ #"guard01" ] thread function_c1e43496();
    a_ents[ #"guard02" ] thread function_c1e43496();
}

// Namespace kgb_ins_rv/namespace_2de23526
// Params 0
// Checksum 0x1c59668a, Offset: 0x3748
// Size: 0x3a
function function_c1e43496()
{
    self.ignoreme = 1;
    self.ignoreall = 1;
    self.propername = kgb_ins_prepare::function_70594daa();
}

// Namespace kgb_ins_rv/namespace_2de23526
// Params 1
// Checksum 0x152596db, Offset: 0x3790
// Size: 0x5c
function function_ec6bb2ec( a_ents )
{
    var_8a3834d = a_ents[ #"hash_22e4f0609e73cccc" ];
    var_8a3834d thread entname::add( #"hash_50d58662d307f9c7", #"axis" );
}

