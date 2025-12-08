#using script_1b9f100b85b7e21d;
#using script_2f4f71f95573b891;
#using script_4489198b8bcf36e8;
#using script_498cf7685befe7bf;
#using script_589f7fc6e210aea7;
#using script_77f51076c7c89596;
#using script_e3ec3024527fc15;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicleriders_shared;
#using scripts\cp\cp_rus_siege;
#using scripts\cp_common\breadcrumbs;
#using scripts\cp_common\gametypes\globallogic;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\spawn_manager;
#using scripts\cp_common\util;
#using scripts\killstreaks\planemortar_shared;

#namespace namespace_9e5ef376;

// Namespace namespace_9e5ef376/namespace_9e5ef376
// Params 1
// Checksum 0xc1dd2b43, Offset: 0x1300
// Size: 0x16c
function function_abfa576( *str_objective )
{
    level.courtyard_enemies = [];
    exploder::exploder( "lgt_exp_pre_nuke_ext_lights" );
    namespace_534279a::spawn_allies();
    namespace_604e2e22::function_3b9e7104();
    level thread namespace_604e2e22::function_1e2a0690( "aa_courtyard", "courtyard_aa_gunner", "scene_sge_0000_ambient_aa_gun" );
    level thread namespace_604e2e22::function_4a3de7f5( "courtyard" );
    level.var_77be18d2 = vehicle::simple_spawn_single( "player_fav" );
    level.var_77be18d2 val::set( #"hash_533b89b2c3072f64", "takedamage", 0 );
    level.var_7b278a4f = vehicle::simple_spawn_single( "ally_fav_left" );
    level.var_5d798cf2 = vehicle::simple_spawn_single( "ally_fav_right" );
    snd::client_targetname( level.var_77be18d2, "audio_courtyard_fav_idle" );
    scene::function_27f5972e( "p9_fxanim_cp_siege_radar_destruction_01_bundle" );
}

// Namespace namespace_9e5ef376/namespace_9e5ef376
// Params 2
// Checksum 0x955dbed9, Offset: 0x1478
// Size: 0x714
function function_802a0aed( *str_objective, var_50cc0d4f )
{
    level.player endon( #"death" );
    level thread function_33dd0a42();
    
    if ( !var_50cc0d4f )
    {
        level waittill( #"hash_465d6bb5960c37f8" );
        level.allowbattlechatter[ #"allies" ] = 1;
        level.allowbattlechatter[ #"axis" ] = 1;
        var_3e3877e9 = spawner::get_ai_group_ai( "initial_ally_group" );
    }
    else
    {
        level.var_77be18d2 makevehicleusable();
        level.var_77be18d2 usevehicle( level.player, 5 );
        level.var_77be18d2 usevehicle( level.player, 5 );
        level.var_77be18d2 makevehicleunusable();
        level.player allowcrouch( 1 );
        level.player allowprone( 1 );
        level.player namespace_534279a::function_6e9256df();
        level.player namespace_534279a::function_a3c3a2b0();
        level notify( #"courtyard_start" );
        exploder::exploder( "fxexp_env_fx_set_courtyard" );
        level thread function_70461e70();
    }
    
    var_8f33990e = spawner::simple_spawn_single( "courtyard_aa_gunner" );
    level thread function_50680202( var_8f33990e );
    level thread function_fba8776c( var_8f33990e );
    var_dbdb0082 = getentarray( "veh_courtyard_static", "targetname" );
    array::run_all( var_dbdb0082, &val::set, #"hash_7d97d109d0838d04", "ignoreme", 1 );
    level thread hms_util::function_eaa0342e( "courtyard_containment_warn", "courtyard_containment_fail" );
    level thread function_f40bfd86();
    level thread function_b414002b();
    level thread function_e3ac7d4e();
    level thread function_488f070b();
    level thread function_2033fa29();
    level.adler thread function_1e101b5a();
    level.woods thread function_1e101b5a();
    level.mason thread function_1e101b5a();
    wait 1;
    var_1054f3aa = getentarray( "courtyard_initial_ally_positions", "targetname" );
    array::run_all( var_1054f3aa, &trigger::use );
    function_6ea2cd94();
    objectives::complete( #"hash_1408f7418b622890" );
    savegame::checkpoint_save();
    var_5d0c20f2 = spawner::get_ai_group_ai( "courtyard_chapel_window_group" );
    var_1490a75e = var_5d0c20f2.size;
    level thread function_1eb17b46();
    var_811b60d = struct::get( "objective_marker_right_path_start" );
    objectives::goto( #"hash_7956ac3690b300bb", var_811b60d.origin, #"hash_74dd5a3afb4c014e" );
    objectives::show( #"hash_7956ac3690b300bb" );
    var_3e88828c = getentarray( "courtyard_assault_fallback_2", "targetname" );
    array::run_all( var_3e88828c, &trigger::use );
    level flag::wait_till( "flg_open_chapel_door" );
    level thread function_b7e649c0();
    var_5b3c6590 = struct::get( "objective_marker_right_path_catacomb" );
    objectives::update_position( #"hash_7956ac3690b300bb", var_5b3c6590.origin );
    namespace_534279a::function_4f981a25( "courtyard_chapel_group", 1, "flg_right_path_cathedral_fallback" );
    level flag::set( "flg_west_wing_dialog" );
    var_935774e6 = getent( "courtyard_door_advance", "targetname" );
    var_935774e6 trigger::use();
    savegame::checkpoint_save();
    level flag::wait_till( "flg_right_path_cathedral_fallback" );
    level.player val::reset( "courtyard_encounter", "attackeraccuracy" );
    objectives::hide( #"hash_7956ac3690b300bb" );
    level thread skipto::function_4e3ab877( "courtyard" );
    var_3e88828c = getentarray( "courtyard_assault_fallback_3", "targetname" );
    array::run_all( var_3e88828c, &trigger::use );
}

// Namespace namespace_9e5ef376/namespace_9e5ef376
// Params 0, eflags: 0x4
// Checksum 0x7fd98258, Offset: 0x1b98
// Size: 0xd8
function private function_70461e70()
{
    wait 2;
    var_3e3877e9 = spawner::get_ai_group_ai( "courtyard_allies" );
    vol_goal = getent( "courtyard_redshirt_advance", "targetname" );
    
    foreach ( var_c1ad446a in var_3e3877e9 )
    {
        var_c1ad446a setgoal( vol_goal );
    }
}

// Namespace namespace_9e5ef376/namespace_9e5ef376
// Params 0, eflags: 0x4
// Checksum 0x6441cac6, Offset: 0x1c78
// Size: 0xd0
function private function_33dd0a42()
{
    level endon( #"flg_player_entering_courtyard" );
    var_175c9e88 = struct::get_array( "courtyard_magic_bullet_origin", "targetname" );
    a_s_target = struct::get_array( "courtyard_magic_bullet_target", "targetname" );
    
    while ( true )
    {
        level thread function_4a9738ac( array::random( var_175c9e88 ), array::random( a_s_target ) );
        wait randomfloatrange( 0.25, 2 );
    }
}

// Namespace namespace_9e5ef376/namespace_9e5ef376
// Params 2, eflags: 0x4
// Checksum 0x80ba8b72, Offset: 0x1d50
// Size: 0xac
function private function_4a9738ac( s_origin, s_target )
{
    var_f0935a68 = getweapon( "turret_manned_m60" );
    var_7722d34c = randomintrange( 4, 10 );
    
    for ( i = 0; i < var_7722d34c ; i++ )
    {
        magicbullet( var_f0935a68, s_origin.origin, s_target.origin );
        wait 0.1;
    }
}

// Namespace namespace_9e5ef376/namespace_9e5ef376
// Params 0
// Checksum 0x92112969, Offset: 0x1e08
// Size: 0x9c
function function_489160a1()
{
    self endon( #"death" );
    self flag::wait_till_clear( #"riding_vehicle" );
    self flag::wait_till_clear( #"scripted_anim_this_frame" );
    vol_goal = getent( "courtyard_redshirt_advance", "targetname" );
    self setgoal( vol_goal );
}

// Namespace namespace_9e5ef376/namespace_9e5ef376
// Params 0
// Checksum 0xd1d1fd2a, Offset: 0x1eb0
// Size: 0x344
function function_2033fa29()
{
    createthreatbiasgroup( "player" );
    createthreatbiasgroup( "courtyard" );
    setthreatbias( "player", "courtyard", 750 );
    level.player setthreatbiasgroup( "player" );
    var_e1d6eabc = getspawnerarray( "courtyard_reinforcement_1_left", "targetname" );
    var_eddf88e5 = getspawnerarray( "courtyard_reinforcement_1_rear", "targetname" );
    var_e1d6eabc = arraycombine( var_e1d6eabc, var_eddf88e5, 0 );
    var_eddf88e5 = getspawnerarray( "courtyard_reinforcement_1_right", "targetname" );
    var_e1d6eabc = arraycombine( var_e1d6eabc, var_eddf88e5, 0 );
    var_eddf88e5 = getspawnerarray( "courtyard_reinforcement_2_left", "targetname" );
    var_e1d6eabc = arraycombine( var_e1d6eabc, var_eddf88e5, 0 );
    var_eddf88e5 = getspawnerarray( "courtyard_reinforcement_2_rear", "targetname" );
    var_e1d6eabc = arraycombine( var_e1d6eabc, var_eddf88e5, 0 );
    var_eddf88e5 = getspawnerarray( "courtyard_reinforcement_2_right", "targetname" );
    var_e1d6eabc = arraycombine( var_e1d6eabc, var_eddf88e5, 0 );
    var_eddf88e5 = getspawnerarray( "courtyard_reinforcement_3_5_left", "targetname" );
    var_e1d6eabc = arraycombine( var_e1d6eabc, var_eddf88e5, 0 );
    var_eddf88e5 = getspawnerarray( "courtyard_reinforcement_3_5_rear", "targetname" );
    var_e1d6eabc = arraycombine( var_e1d6eabc, var_eddf88e5, 0 );
    var_eddf88e5 = getspawnerarray( "courtyard_reinforcement_3_5_right", "targetname" );
    var_e1d6eabc = arraycombine( var_e1d6eabc, var_eddf88e5, 0 );
    var_eddf88e5 = getspawnerarray( "courtyard_reinforcement_3_left", "targetname" );
    var_e1d6eabc = arraycombine( var_e1d6eabc, var_eddf88e5, 0 );
    var_eddf88e5 = getspawnerarray( "courtyard_reinforcement_3_rear", "targetname" );
    var_e1d6eabc = arraycombine( var_e1d6eabc, var_eddf88e5, 0 );
    var_eddf88e5 = getspawnerarray( "courtyard_reinforcement_3_right", "targetname" );
    var_e1d6eabc = arraycombine( var_e1d6eabc, var_eddf88e5, 0 );
    array::thread_all( var_e1d6eabc, &spawner::add_spawn_function, &function_a6534cdc );
}

// Namespace namespace_9e5ef376/namespace_9e5ef376
// Params 0
// Checksum 0x498c0e6d, Offset: 0x2200
// Size: 0x34
function function_a6534cdc()
{
    self endon( #"death" );
    self setthreatbiasgroup( "courtyard" );
}

// Namespace namespace_9e5ef376/namespace_9e5ef376
// Params 0
// Checksum 0xd8c25578, Offset: 0x2240
// Size: 0x29c
function function_488f070b()
{
    level.woods hms_util::dialogue( "vox_cp_seig_01100_wood_pushthroughpush_c9" );
    level flag::wait_till( "flg_player_entering_courtyard" );
    level.adler thread hms_util::dialogue( "vox_cp_seig_01200_adlr_aagunstraightah_b2" );
    var_667bdbcd = [ getent( "aa_courtyard", "targetname" ) ];
    objectives::kill( #"hash_1408f7418b622890", var_667bdbcd, #"hash_596228abde0d7286", undefined, 0, 1 );
    objectives_ui::function_49dec5b( #"hash_1408f7418b622890", var_667bdbcd[ 0 ], #"hash_7056653275b7909e" );
    level flag::wait_till( "flg_courtyard_assault_fallback_0" );
    level.adler hms_util::dialogue( "vox_cp_seig_01200_adlr_masonwoodscover_20" );
    level flag::wait_till( "flg_courtyard_assault_fallback_2" );
    level.adler hms_util::dialogue( "vox_cp_seig_01200_adlr_bellplantthatc4_03" );
    level thread function_e3f8cfba();
    level flag::wait_till( "flg_aa_gun_c4_planted" );
    var_ffbbfc35 = [];
    var_ffbbfc35[ 0 ] = hms_util::function_e1449992( level.adler, "vox_cp_seig_01200_adlr_standbackitshot_ce" );
    var_ffbbfc35[ 1 ] = hms_util::function_e1449992( level.adler, "vox_cp_seig_01200_adlr_rightstandbackc_01" );
    var_ffbbfc35[ 2 ] = hms_util::function_e1449992( level.adler, "vox_cp_seig_01200_adlr_fireinthehole_c7" );
    hms_util::vo_knockout_manager( "courtyard_aa_gun", var_ffbbfc35 );
    level waittill( #"hash_261ad1569f4c15d1" );
    wait 2;
    level.adler hms_util::dialogue( "vox_cp_seig_01300_adlr_niceworkintothe_5c" );
}

// Namespace namespace_9e5ef376/namespace_9e5ef376
// Params 1
// Checksum 0x4134c503, Offset: 0x24e8
// Size: 0x10c
function function_b7e649c0( var_ddab8604 )
{
    if ( !isdefined( var_ddab8604 ) || !var_ddab8604 )
    {
        function_1ede49cc();
        return;
    }
    
    var_643a73f4 = getent( "chapel_door_left", "targetname" );
    var_a0d4ecdf = getent( "chapel_door_right", "targetname" );
    var_643a73f4 rotateyaw( -105, 0.3 );
    var_a0d4ecdf rotateyaw( 95, 0.3 );
    var_643a73f4 disconnectpaths();
    var_a0d4ecdf disconnectpaths();
}

// Namespace namespace_9e5ef376/namespace_9e5ef376
// Params 0
// Checksum 0xd646f2d, Offset: 0x2600
// Size: 0x1b4
function function_1ede49cc()
{
    var_7bacf73f = level spawner::simple_spawn( "courtyard_chapel_breach_group" );
    var_643a73f4 = getent( "chapel_door_left", "targetname" );
    var_a0d4ecdf = getent( "chapel_door_right", "targetname" );
    a_actors = [];
    a_actors[ #"actor 1" ] = var_7bacf73f[ 0 ];
    level thread scene::play( "scene_rev_0000_door_entry_single_soldier_kick_02", "Shot 1", a_actors );
    a_actors[ #"actor 1" ] waittill( #"hash_553184e6c2383c0d" );
    level.adler thread hms_util::dialogue( "vox_cp_seig_01300_adlr_cutemdown_11" );
    var_643a73f4 rotateyaw( -95, 0.3 );
    var_a0d4ecdf rotateyaw( 85, 0.3 );
    snd::client_msg( "audio_church_doors_kick_open" );
    wait 0.5;
    var_643a73f4 disconnectpaths();
    var_a0d4ecdf disconnectpaths();
}

// Namespace namespace_9e5ef376/namespace_9e5ef376
// Params 0
// Checksum 0xcc9423c5, Offset: 0x27c0
// Size: 0x274
function function_1eb17b46()
{
    var_5d0c20f2 = spawner::get_ai_group_ai( "courtyard_chapel_window_group" );
    
    if ( var_5d0c20f2.size > 1 )
    {
        level.woods thread ai::shoot_at_target( "kill_within_time", var_5d0c20f2[ 1 ], undefined, 1 );
    }
    
    if ( var_5d0c20f2.size > 0 )
    {
        level.mason thread ai::shoot_at_target( "kill_within_time", var_5d0c20f2[ 0 ], undefined, 1 );
    }
    
    wait 1.5;
    vol_goal = getent( "courtyard_chapel_entrance", "targetname" );
    a_ai = spawner::get_ai_group_ai( "courtyard_enemies" );
    array::run_all( a_ai, &setgoal, vol_goal );
    
    while ( a_ai.size > 0 )
    {
        level.adler thread ai::shoot_at_target( "kill_within_time", a_ai[ 0 ], undefined, 0.5 );
        
        if ( a_ai.size > 1 )
        {
            level.mason thread ai::shoot_at_target( "kill_within_time", a_ai[ 1 ], undefined, 0.5 );
        }
        
        if ( a_ai.size > 2 )
        {
            level.woods thread ai::shoot_at_target( "kill_within_time", a_ai[ 2 ], undefined, 0.5 );
        }
        
        wait 1;
        a_ai = spawner::get_ai_group_ai( "courtyard_enemies" );
    }
    
    a_ai = spawner::get_ai_group_ai( "courtyard_chapel_group" );
    array::run_all( a_ai, &setgoal, vol_goal );
    
    if ( a_ai.size > 0 )
    {
        level.adler thread ai::shoot_at_target( "kill_within_time", a_ai[ 0 ], undefined, 1 );
    }
}

// Namespace namespace_9e5ef376/namespace_9e5ef376
// Params 0
// Checksum 0x4aac6344, Offset: 0x2a40
// Size: 0xb4
function function_6ea2cd94()
{
    level thread namespace_604e2e22::scene_sge_4020_per_bomb_plant( "courtyard" );
    var_f9e27979 = getent( "aa_courtyard", "targetname" );
    var_f9e27979 namespace_534279a::function_2a8ee50f( "courtyard" );
    var_f9e27979 notify( #"remove_objective" );
    level notify( #"hash_261ad1569f4c15d1" );
    level flag::set( "flg_courtyard_aa_complete" );
}

// Namespace namespace_9e5ef376/namespace_9e5ef376
// Params 0
// Checksum 0xcd403f49, Offset: 0x2b00
// Size: 0xcc
function function_e3f8cfba()
{
    var_d3e49516 = [];
    level endon( #"flg_courtyard_aa_complete" );
    wait 15;
    level.adler thread hms_util::dialogue( "vox_cp_seig_01200_adlr_belltakeoutthat_bb" );
    wait 15;
    level.adler thread hms_util::dialogue( "vox_cp_seig_01200_adlr_destroytheaagun_78" );
    wait 15;
    level.adler thread hms_util::dialogue( "vox_cp_seig_01200_adlr_theaaguntakeito_89" );
    wait 15;
    level.adler thread hms_util::dialogue( "vox_cp_seig_01200_adlr_bellwhatthehell_33" );
}

// Namespace namespace_9e5ef376/namespace_9e5ef376
// Params 4
// Checksum 0xcaec5805, Offset: 0x2bd8
// Size: 0x44
function function_77335d30( *str_objective, *var_50cc0d4f, *var_aa1a6455, *player )
{
    level flag::set( "flg_courtyard_completed" );
}

// Namespace namespace_9e5ef376/namespace_9e5ef376
// Params 0
// Checksum 0xb7575783, Offset: 0x2c28
// Size: 0x16c
function blocker_init()
{
    a_e_blockers = getentarray( "left_path_backtrack_blocker", "targetname" );
    array::run_all( a_e_blockers, &show );
    array::run_all( a_e_blockers, &solid );
    a_e_blockers = getentarray( "left_path_return_blocker", "targetname" );
    array::run_all( a_e_blockers, &disconnectpaths );
    a_e_blockers = getentarray( "right_path_return_blocker", "targetname" );
    array::run_all( a_e_blockers, &disconnectpaths );
    a_e_blockers = getentarray( "courtyard_return_truck", "targetname" );
    array::run_all( a_e_blockers, &hide );
    array::run_all( a_e_blockers, &notsolid );
    array::run_all( a_e_blockers, &connectpaths );
}

// Namespace namespace_9e5ef376/namespace_9e5ef376
// Params 0, eflags: 0x4
// Checksum 0xbf950f81, Offset: 0x2da0
// Size: 0x1a4
function private function_f40bfd86()
{
    var_3e3877e9 = spawner::get_ai_group_ai( "courtyard_allies" );
    vol_goal = getent( "courtyard_redshirt_cover", "targetname" );
    array::run_all( var_3e3877e9, &setgoal, vol_goal );
    level flag::wait_till( "flg_player_entering_courtyard" );
    var_3e3877e9 = spawner::get_ai_group_ai( "courtyard_allies" );
    
    if ( var_3e3877e9.size > 2 )
    {
        a_ai_enemies = spawner::get_ai_group_ai( "courtyard_enemies" );
        vol_goal = getent( "courtyard_allies_front", "targetname" );
        
        for ( i = 2; i < var_3e3877e9.size ; i++ )
        {
            var_3e3877e9[ i ] setgoal( vol_goal );
            
            if ( a_ai_enemies.size > i )
            {
                a_ai_enemies[ i ] thread ai::shoot_at_target( "kill_within_time", var_3e3877e9[ i ], undefined, 5 );
                continue;
            }
            
            a_ai_enemies[ 0 ] thread ai::shoot_at_target( "kill_within_time", var_3e3877e9[ i ], undefined, 5 );
        }
    }
}

// Namespace namespace_9e5ef376/namespace_9e5ef376
// Params 0, eflags: 0x4
// Checksum 0xfc2900ff, Offset: 0x2f50
// Size: 0x114
function private function_9dc2e510()
{
    var_3e3877e9 = spawner::get_ai_group_ai( "courtyard_allies" );
    a_ai_enemies = spawner::get_ai_group_ai( "courtyard_enemies" );
    vol_goal = getent( "courtyard_right_rear", "targetname" );
    
    for ( i = 0; i < var_3e3877e9.size ; i++ )
    {
        var_3e3877e9[ i ] setgoal( vol_goal );
        
        if ( a_ai_enemies.size > i )
        {
            a_ai_enemies[ i ] thread ai::shoot_at_target( "kill_within_time", var_3e3877e9[ i ], undefined, 3 );
            continue;
        }
        
        a_ai_enemies[ 0 ] thread ai::shoot_at_target( "kill_within_time", var_3e3877e9[ i ], undefined, 3 );
    }
}

// Namespace namespace_9e5ef376/namespace_9e5ef376
// Params 0, eflags: 0x4
// Checksum 0xe39fdfc0, Offset: 0x3070
// Size: 0x662
function private function_b414002b()
{
    level.player endon( #"death" );
    level flag::wait_till( "flg_courtyard_spawned" );
    exploder::exploder( "fxexp_debris_falling_entrance" );
    level spawn_manager::enable( "courtyard_wave_1_manager" );
    var_ffbbfc35 = [];
    var_ffbbfc35[ 0 ] = hms_util::function_e1449992( level.adler, "RPG!" );
    var_ffbbfc35[ 1 ] = hms_util::function_e1449992( level.adler, "RPGs!" );
    var_ffbbfc35[ 2 ] = hms_util::function_e1449992( level.adler, "Heads up! RPG!" );
    level thread hms_util::vo_knockout_manager( "courtyard_RPG", var_ffbbfc35 );
    waitframe( 1 );
    var_2f6b9a0 = level spawner::get_ai_group_ai( "courtyard_enemies" );
    array::run_all( var_2f6b9a0, &util::magic_bullet_shield );
    level flag::wait_till( "flg_player_entering_courtyard" );
    var_2f6b9a0 = level spawner::get_ai_group_ai( "courtyard_enemies" );
    array::run_all( var_2f6b9a0, &util::stop_magic_bullet_shield );
    var_11b2a17d = level spawner::get_ai_group_ai( "courtyard_window_RPG" );
    var_e9fc0486 = level spawner::get_ai_group_ai( "courtyard_allies" );
    
    if ( var_11b2a17d.size > 0 && var_e9fc0486.size > 0 )
    {
        var_11b2a17d[ 0 ] ai::shoot_at_target( "kill_within_time", var_e9fc0486[ 0 ], undefined, 3 );
    }
    
    level thread function_ae6a9244();
    namespace_534279a::function_4f981a25( "courtyard_enemies", 7, "flg_courtyard_assault_fallback_0" );
    spawner::waittill_ai_group_amount_killed( "courtyard_enemies", 4 );
    var_3e88828c = getentarray( "courtyard_assault_fallback_0", "targetname" );
    array::run_all( var_3e88828c, &trigger::use );
    level thread function_c4a7bebe();
    level.adler.grenadeammo = 0;
    level.mason.grenadeammo = 0;
    level.woods.grenadeammo = 0;
    namespace_534279a::function_4f981a25( "courtyard_enemies", 12, "flg_courtyard_assault_fallback_1" );
    spawner::waittill_ai_group_amount_killed( "courtyard_enemies", 7 );
    var_3e88828c = getentarray( "courtyard_assault_fallback_1", "targetname" );
    array::run_all( var_3e88828c, &trigger::use );
    level thread function_f886eda8();
    namespace_534279a::function_bd1a75b( "courtyard_enemies", 2, "flg_courtyard_assault_fallback_1_5" );
    var_3e88828c = getentarray( "courtyard_assault_fallback_1_5", "targetname" );
    array::run_all( var_3e88828c, &trigger::use );
    level thread function_7afaab65();
    level thread function_9dc2e510();
    var_11b2a17d = level spawner::get_ai_group_ai( "courtyard_window_RPG" );
    
    if ( var_11b2a17d.size )
    {
        array::thread_all( var_11b2a17d, &function_68675239 );
    }
    
    var_2fe2b603 = level spawner::get_ai_group_ai( "courtyard_roof_RPG" );
    
    if ( var_2fe2b603.size )
    {
        array::thread_all( var_2fe2b603, &function_68675239 );
    }
    
    level flag::wait_till( "flg_courtyard_assault_fallback_2_start" );
    level thread function_47c5954d();
    level.adler.script_accuracy = 0.9;
    level.woods.script_accuracy = 0.9;
    level.mason.script_accuracy = 0.9;
    level flag::wait_till( "flg_right_path_start" );
    spawner::waittill_ai_group_amount_killed( "courtyard_chapel_group", 2 );
    namespace_534279a::function_b5e4f3bc( "courtyard_chapel_group", "right_path_cathedral_fallback_volume", "script_noteworthy" );
    level.adler.script_accuracy = 0.2;
    level.woods.script_accuracy = 0.2;
    level.mason.script_accuracy = 0.2;
}

// Namespace namespace_9e5ef376/namespace_9e5ef376
// Params 0, eflags: 0x4
// Checksum 0x224c909d, Offset: 0x36e0
// Size: 0x1c
function private function_68675239()
{
    self kill();
}

// Namespace namespace_9e5ef376/namespace_9e5ef376
// Params 0, eflags: 0x4
// Checksum 0x2fc155aa, Offset: 0x3708
// Size: 0x1d4
function private function_e4a6ccc2()
{
    vol_goal = getent( "courtyard_chapel_entrance", "targetname" );
    a_ai = spawner::get_ai_group_ai( "courtyard_enemies" );
    array::run_all( a_ai, &setgoal, vol_goal );
    
    while ( a_ai.size > 0 )
    {
        level.adler thread ai::shoot_at_target( "kill_within_time", a_ai[ 0 ], undefined, 0.5 );
        
        if ( a_ai.size > 1 )
        {
            level.mason thread ai::shoot_at_target( "kill_within_time", a_ai[ 1 ], undefined, 0.5 );
        }
        
        if ( a_ai.size > 2 )
        {
            level.woods thread ai::shoot_at_target( "kill_within_time", a_ai[ 2 ], undefined, 0.5 );
        }
        
        wait 1;
        a_ai = spawner::get_ai_group_ai( "courtyard_enemies" );
    }
    
    a_ai = spawner::get_ai_group_ai( "courtyard_chapel_group" );
    array::run_all( a_ai, &setgoal, vol_goal );
    
    if ( a_ai.size > 0 )
    {
        level.adler thread ai::shoot_at_target( "kill_within_time", a_ai[ 0 ], undefined, 1 );
    }
}

// Namespace namespace_9e5ef376/namespace_9e5ef376
// Params 0, eflags: 0x4
// Checksum 0x6a546a7a, Offset: 0x38e8
// Size: 0x42c
function private function_ae6a9244()
{
    level endon( #"flg_courtyard_assault_fallback_0" );
    level spawn_manager::function_3c035c82( 10 );
    level spawn_manager::disable( "courtyard_wave_1_manager" );
    var_92b71fdd = spawner::get_ai_group_ai( "courtyard_enemies" );
    a_ai_enemies = getaiarray( "courtyard_left", "script_string" );
    vol_goal = getent( "courtyard_left_front", "targetname" );
    array::run_all( a_ai_enemies, &setgoal, vol_goal );
    var_ee755f4d = getentarray( "courtyard_reinforcement_2_left", "targetname" );
    
    foreach ( e_spawner in var_ee755f4d )
    {
        e_spawner.target = "courtyard_left_mid";
    }
    
    a_ai_enemies = getaiarray( "courtyard_rear", "script_string" );
    vol_goal = getent( "courtyard_left_rear", "targetname" );
    array::run_all( a_ai_enemies, &setgoal, vol_goal );
    var_ee755f4d = getentarray( "courtyard_reinforcement_2_rear", "targetname" );
    
    foreach ( e_spawner in var_ee755f4d )
    {
        e_spawner.target = "courtyard_aa_platform";
    }
    
    a_ai_enemies = getaiarray( "courtyard_right", "script_string" );
    vol_goal = getent( "courtyard_right_front", "targetname" );
    array::run_all( a_ai_enemies, &setgoal, vol_goal );
    var_ee755f4d = getentarray( "courtyard_reinforcement_2_right", "targetname" );
    
    foreach ( e_spawner in var_ee755f4d )
    {
        e_spawner.target = "courtyard_right_rear";
    }
    
    level thread function_55a5d157();
    spawner::waittill_ai_group_ai_count( "courtyard_enemies", 7 );
    level spawn_manager::enable( "courtyard_wave_2_manager_left" );
    level spawn_manager::enable( "courtyard_wave_2_manager_rear" );
    level spawn_manager::enable( "courtyard_wave_2_manager_right" );
}

// Namespace namespace_9e5ef376/namespace_9e5ef376
// Params 0, eflags: 0x4
// Checksum 0xf97e1981, Offset: 0x3d20
// Size: 0x4fc
function private function_c4a7bebe()
{
    level endon( #"flg_courtyard_assault_fallback_1" );
    level spawn_manager::function_3c035c82( 10 );
    var_92b71fdd = spawner::get_ai_group_ai( "courtyard_enemies" );
    level spawn_manager::disable( "courtyard_wave_2_manager_left" );
    level spawn_manager::disable( "courtyard_wave_2_manager_rear" );
    level spawn_manager::disable( "courtyard_wave_2_manager_right" );
    var_3e3877e9 = spawner::get_ai_group_ai( "courtyard_allies" );
    vol_goal = getent( "courtyard_allies_front", "targetname" );
    array::run_all( var_3e3877e9, &setgoal, vol_goal );
    
    if ( var_3e3877e9.size < 4 )
    {
        level spawner::simple_spawn( "ally_breach_spawner_4" );
        level spawner::simple_spawn( "ally_breach_spawner_4" );
    }
    
    a_ai_enemies = getaiarray( "courtyard_left", "script_string" );
    vol_goal = getent( "courtyard_left_mid", "targetname" );
    array::run_all( a_ai_enemies, &setgoal, vol_goal );
    var_ee755f4d = getentarray( "courtyard_reinforcement_3_left", "targetname" );
    
    foreach ( e_spawner in var_ee755f4d )
    {
        e_spawner.target = "courtyard_left_mid";
    }
    
    a_ai_enemies = getaiarray( "courtyard_rear", "script_string" );
    vol_goal = getent( "courtyard_left_rear", "targetname" );
    array::run_all( a_ai_enemies, &setgoal, vol_goal );
    var_ee755f4d = getentarray( "courtyard_reinforcement_3_rear", "targetname" );
    
    foreach ( e_spawner in var_ee755f4d )
    {
        e_spawner.target = "courtyard_aa_platform";
    }
    
    a_ai_enemies = getaiarray( "courtyard_right", "script_string" );
    vol_goal = getent( "courtyard_aa_platform", "targetname" );
    array::run_all( a_ai_enemies, &setgoal, vol_goal );
    var_ee755f4d = getentarray( "courtyard_reinforcement_3_right", "targetname" );
    
    foreach ( e_spawner in var_ee755f4d )
    {
        e_spawner.target = "courtyard_right_rear";
    }
    
    spawner::waittill_ai_group_ai_count( "courtyard_enemies", 7 );
    level spawn_manager::enable( "courtyard_wave_3_manager_left" );
    level spawn_manager::enable( "courtyard_wave_3_manager_rear" );
    level spawn_manager::enable( "courtyard_wave_3_manager_right" );
}

// Namespace namespace_9e5ef376/namespace_9e5ef376
// Params 0, eflags: 0x4
// Checksum 0xfa2eadff, Offset: 0x4228
// Size: 0x4ec
function private function_f886eda8()
{
    level endon( #"flg_courtyard_assault_fallback_1_5" );
    savegame::checkpoint_save();
    level spawn_manager::function_3c035c82( 8 );
    var_92b71fdd = spawner::get_ai_group_ai( "courtyard_enemies" );
    level spawn_manager::disable( "courtyard_wave_3_manager_left" );
    level spawn_manager::disable( "courtyard_wave_3_manager_rear" );
    level spawn_manager::disable( "courtyard_wave_3_manager_right" );
    var_3e3877e9 = spawner::get_ai_group_ai( "courtyard_allies" );
    vol_goal = getent( "courtyard_right_mid", "targetname" );
    array::run_all( var_3e3877e9, &setgoal, vol_goal );
    
    if ( var_3e3877e9.size < 2 )
    {
        level spawner::simple_spawn( "ally_breach_spawner_5" );
        level spawner::simple_spawn( "ally_breach_spawner_5" );
    }
    
    a_ai_enemies = getaiarray( "courtyard_left", "script_string" );
    vol_goal = getent( "courtyard_left_rear", "targetname" );
    array::run_all( a_ai_enemies, &setgoal, vol_goal );
    var_ee755f4d = getentarray( "courtyard_reinforcement_3_5_left", "targetname" );
    
    foreach ( e_spawner in var_ee755f4d )
    {
        e_spawner.target = "courtyard_left_rear";
    }
    
    a_ai_enemies = getaiarray( "courtyard_rear", "script_string" );
    vol_goal = getent( "courtyard_aa_platform", "targetname" );
    array::run_all( a_ai_enemies, &setgoal, vol_goal );
    var_ee755f4d = getentarray( "courtyard_reinforcement_3_5_rear", "targetname" );
    
    foreach ( e_spawner in var_ee755f4d )
    {
        e_spawner.target = "courtyard_aa_platform";
    }
    
    a_ai_enemies = getaiarray( "courtyard_right", "script_string" );
    vol_goal = getent( "courtyard_rear_full", "targetname" );
    array::run_all( a_ai_enemies, &setgoal, vol_goal );
    var_ee755f4d = getentarray( "courtyard_reinforcement_3_5_right", "targetname" );
    
    foreach ( e_spawner in var_ee755f4d )
    {
        e_spawner.target = "courtyard_rear_full";
    }
    
    spawner::waittill_ai_group_ai_count( "courtyard_enemies", 5 );
    level spawn_manager::enable( "courtyard_wave_3_5_manager_rear" );
    level spawn_manager::enable( "courtyard_wave_3_5_manager_right" );
}

// Namespace namespace_9e5ef376/namespace_9e5ef376
// Params 0, eflags: 0x4
// Checksum 0xd96733de, Offset: 0x4720
// Size: 0x474
function private function_7afaab65()
{
    level endon( #"flg_courtyard_assault_fallback_2_start" );
    level spawn_manager::function_3c035c82( 6 );
    level spawner::simple_spawn( "courtyard_reinforcement_3_window" );
    var_92b71fdd = spawner::get_ai_group_ai( "courtyard_enemies" );
    level spawn_manager::disable( "courtyard_wave_3_5_manager_left" );
    level spawn_manager::disable( "courtyard_wave_3_5_manager_rear" );
    level spawn_manager::disable( "courtyard_wave_3_5_manager_right" );
    a_ai_enemies = getaiarray( "courtyard_left", "script_string" );
    vol_goal = getent( "courtyard_left_rear", "targetname" );
    array::run_all( a_ai_enemies, &setgoal, vol_goal );
    var_ee755f4d = getentarray( "courtyard_reinforcement_4_left", "targetname" );
    
    foreach ( e_spawner in var_ee755f4d )
    {
        e_spawner.target = "courtyard_left_rear";
    }
    
    a_ai_enemies = getaiarray( "courtyard_rear", "script_string" );
    vol_goal = getent( "courtyard_aa_platform", "targetname" );
    array::run_all( a_ai_enemies, &setgoal, vol_goal );
    var_ee755f4d = getentarray( "courtyard_reinforcement_4_rear", "targetname" );
    
    foreach ( e_spawner in var_ee755f4d )
    {
        e_spawner.target = "courtyard_aa_platform";
    }
    
    a_ai_enemies = getaiarray( "courtyard_right", "script_string" );
    vol_goal = getent( "courtyard_rear_full", "targetname" );
    array::run_all( a_ai_enemies, &setgoal, vol_goal );
    var_ee755f4d = getentarray( "courtyard_reinforcement_4_right", "targetname" );
    
    foreach ( e_spawner in var_ee755f4d )
    {
        e_spawner.target = "courtyard_rear_full";
    }
    
    spawner::waittill_ai_group_ai_count( "courtyard_enemies", 4 );
    level spawn_manager::enable( "courtyard_wave_4_manager_rear" );
    level spawn_manager::enable( "courtyard_wave_4_manager_right" );
    wait 3;
    level spawn_manager::disable( "courtyard_wave_4_manager_rear" );
}

// Namespace namespace_9e5ef376/namespace_9e5ef376
// Params 0, eflags: 0x4
// Checksum 0x44348ff3, Offset: 0x4ba0
// Size: 0x9c
function private function_55a5d157()
{
    level endon( #"flg_courtyard_assault_fallback_1_5" );
    spawner::simple_spawn_single( "courtyard_window_reinforcement_1" );
    wait 5;
    spawner::waittill_ai_group_amount_killed( "courtyard_window_RPG", 1 );
    wait 8;
    level flag::wait_till( "flg_courtyard_assault_fallback_0" );
    spawner::simple_spawn_single( "courtyard_window_reinforcement_2" );
}

// Namespace namespace_9e5ef376/namespace_9e5ef376
// Params 0, eflags: 0x4
// Checksum 0x29fa705e, Offset: 0x4c48
// Size: 0x9c
function private function_c9f96389()
{
    level endon( #"flg_courtyard_assault_fallback_1_5" );
    spawner::simple_spawn_single( "courtyard_roof_reinforcement_1" );
    wait 6;
    spawner::waittill_ai_group_amount_killed( "courtyard_roof_RPG", 1 );
    wait 10;
    level flag::wait_till( "flg_courtyard_assault_fallback_1" );
    spawner::simple_spawn_single( "courtyard_roof_reinforcement_2" );
}

// Namespace namespace_9e5ef376/namespace_9e5ef376
// Params 0, eflags: 0x4
// Checksum 0xf15384f8, Offset: 0x4cf0
// Size: 0x3bc
function private function_47c5954d()
{
    level.player endon( #"death" );
    level namespace_534279a::function_bd1a75b( "courtyard_enemies", 4, "flg_courtyard_assault_fallback_2" );
    level.player val::set( "courtyard_encounter", "attackeraccuracy", 0.2 );
    a_ai_enemies = getaiarray( "courtyard_left", "script_string" );
    vol_goal = getent( "courtyard_chapel_yard", "targetname" );
    array::run_all( a_ai_enemies, &setgoal, vol_goal );
    var_ee755f4d = getentarray( "courtyard_reinforcement_4_left", "targetname" );
    
    foreach ( e_spawner in var_ee755f4d )
    {
        e_spawner.target = "courtyard_chapel_yard";
    }
    
    a_ai_enemies = getaiarray( "courtyard_rear", "script_string" );
    vol_goal = getent( "courtyard_chapel_yard", "targetname" );
    array::run_all( a_ai_enemies, &setgoal, vol_goal );
    var_ee755f4d = getentarray( "courtyard_reinforcement_4_rear", "targetname" );
    
    foreach ( e_spawner in var_ee755f4d )
    {
        e_spawner.target = "courtyard_chapel_yard";
    }
    
    a_ai_enemies = getaiarray( "courtyard_right", "script_string" );
    vol_goal = getent( "courtyard_chapel_yard", "targetname" );
    array::run_all( a_ai_enemies, &setgoal, vol_goal );
    var_ee755f4d = getentarray( "courtyard_reinforcement_4_right", "targetname" );
    
    foreach ( e_spawner in var_ee755f4d )
    {
        e_spawner.target = "courtyard_chapel_yard";
    }
    
    wait 3;
    level spawn_manager::disable( "courtyard_wave_4_manager_right" );
}

// Namespace namespace_9e5ef376/namespace_9e5ef376
// Params 0, eflags: 0x4
// Checksum 0xb9e2b794, Offset: 0x50b8
// Size: 0xd0
function private function_1e101b5a()
{
    level endon( #"flg_courtyard_assault_fallback_2_start" );
    level endon( #"game_ended" );
    level.adler endon( #"death" );
    var_ecd1d2eb = self.script_accuracy;
    
    while ( true )
    {
        var_942cba63 = spawner::get_ai_group_ai( "courtyard_enemies" );
        
        if ( var_942cba63.size > level.var_539b11be )
        {
            self.script_accuracy = 0.9;
        }
        else
        {
            self.script_accuracy = var_ecd1d2eb;
        }
        
        wait 3;
    }
}

// Namespace namespace_9e5ef376/namespace_9e5ef376
// Params 0, eflags: 0x4
// Checksum 0x878ecf29, Offset: 0x5190
// Size: 0x84
function private function_f66f2135()
{
    level spawner::simple_spawn( "courtyard_aa_crew_spawner" );
    level spawner::waittill_ai_group_amount_killed( "courtyard_aa_crew", 3 );
    
    if ( !level flag::get( "flg_courtyard_assault_fallback_1" ) )
    {
        level spawner::simple_spawn( "courtyard_aa_crew_spawner" );
    }
}

// Namespace namespace_9e5ef376/namespace_9e5ef376
// Params 0, eflags: 0x4
// Checksum 0xaddaef45, Offset: 0x5220
// Size: 0x9c
function private function_e3ac7d4e()
{
    level flag::wait_till( "flg_right_path_drop_down" );
    var_f4c28052 = spawner::get_ai_group_ai( "courtyard_enemies" );
    array::run_all( var_f4c28052, &deletedelay );
    var_f4c28052 = spawner::get_ai_group_ai( "courtyard_chapel_group" );
    array::run_all( var_f4c28052, &deletedelay );
}

// Namespace namespace_9e5ef376/namespace_9e5ef376
// Params 1
// Checksum 0x3724848a, Offset: 0x52c8
// Size: 0x1e8
function function_4b8cec86( *str_objective )
{
    exploder::exploder( "lgt_exp_pre_nuke_ext_lights" );
    namespace_534279a::spawn_allies();
    var_53aba3f8 = struct::get( "courtyard_start_adler" );
    level.adler forceteleport( var_53aba3f8.origin, var_53aba3f8.angles );
    var_f8518240 = getspawnerarray( "courtyard_ground_spawner", "targetname" );
    level spawner::kill_spawnernum( 1 );
    level.var_77be18d2 = vehicle::simple_spawn_single( "player_fav" );
    level.var_77be18d2 val::set( #"hash_533b89b2c3072f64", "takedamage", 0 );
    level.var_c88d2182 = [];
    level.var_c88d2182[ 0 ] = getent( "e_radar_1_rotation", "targetname" );
    level.var_c88d2182[ 1 ] = getent( "e_radar_2_rotation", "targetname" );
    level.var_c88d2182[ 2 ] = getent( "e_radar_3_rotation", "targetname" );
    level.var_c88d2182[ 3 ] = getent( "e_radar_4_rotation", "targetname" );
}

// Namespace namespace_9e5ef376/namespace_9e5ef376
// Params 2
// Checksum 0x6f32ac81, Offset: 0x54b8
// Size: 0x13c
function outro_main( *str_objective, var_50cc0d4f )
{
    if ( var_50cc0d4f )
    {
        namespace_9940c067::function_a5083d9c();
        level thread namespace_604e2e22::function_f2f9526e();
    }
    
    level.player freezecontrols( 1 );
    wait 2.7;
    exploder::exploder( "fxexp_bombing_run_drops_fx" );
    wait 1;
    exploder::exploder( "fxexp_bombing_run_initial_fx" );
    wait 3;
    exploder::exploder( "fxexp_bombing_run_radar_exp_fx" );
    level thread function_e3a25e6a();
    wait 2.85;
    exploder::kill_exploder( "lgt_exp_post_nuke_power_on_03_lightpost" );
    exploder::exploder( "lgt_exp_post_nuke_power_on_03_fall" );
    wait 2.75;
    level thread skipto::function_4e3ab877( "outro" );
}

// Namespace namespace_9e5ef376/namespace_9e5ef376
// Params 4
// Checksum 0xf19586eb, Offset: 0x5600
// Size: 0x24
function outro_cleanup( *str_objective, *var_50cc0d4f, *var_aa1a6455, *player )
{
    
}

// Namespace namespace_9e5ef376/namespace_9e5ef376
// Params 0
// Checksum 0xca1997df, Offset: 0x5630
// Size: 0x84
function function_e3a25e6a()
{
    wait 1.1;
    level thread function_c1f193cc( 4 );
    wait 0.5;
    level thread function_c1f193cc( 3 );
    wait 1;
    level thread function_c1f193cc( 1 );
    wait 0.1;
    level thread function_c1f193cc( 2 );
}

// Namespace namespace_9e5ef376/namespace_9e5ef376
// Params 1
// Checksum 0x7cbc64b6, Offset: 0x56c0
// Size: 0xac
function function_c1f193cc( i_id )
{
    s_scene = struct::get( "radar_" + i_id, "targetname" );
    s_scene thread scene::play( "play" );
    level.var_c88d2182[ i_id - 1 ] hide();
    level.var_1d829da4[ i_id - 1 ] cp_rus_siege::kill_radar_fx();
}

// Namespace namespace_9e5ef376/namespace_9e5ef376
// Params 1
// Checksum 0x247cd0ad, Offset: 0x5778
// Size: 0x54
function function_50680202( var_8f33990e )
{
    var_8f33990e endon( #"hash_771d89dbae9683d1" );
    level waittill( #"hash_523968c9e8e5864" );
    var_8f33990e delete();
}

// Namespace namespace_9e5ef376/namespace_9e5ef376
// Params 1
// Checksum 0xbe7c2034, Offset: 0x57d8
// Size: 0x7c
function function_fba8776c( var_8f33990e )
{
    var_8f33990e endon( #"death" );
    var_8f33990e waittill( #"hash_771d89dbae9683d1" );
    vol_goal = getent( "courtyard_chapel_entrance", "targetname" );
    var_8f33990e setgoal( vol_goal );
}

