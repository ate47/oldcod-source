#using script_25b0725f0d26dbf5;
#using script_3711e526ec2a3863;
#using script_4937c6974f43bb71;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp\cp_nam_armada;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\spawn_manager;
#using scripts\killstreaks\napalm_strike_shared;

#namespace armada_crash;

// Namespace armada_crash/namespace_5243a812
// Params 2
// Checksum 0x540b10cf, Offset: 0x5d8
// Size: 0x404
function function_945def6e( var_d3440450, var_50cc0d4f )
{
    level function_7b315e60();
    level flag::set( "flag_vo_crash_rpg" );
    
    if ( isdefined( level.var_7466d419.var_6bbdd0a5 ) )
    {
        level.var_7466d419.var_6bbdd0a5 delete();
    }
    
    if ( is_true( var_50cc0d4f ) )
    {
        namespace_82bfe441::fade( 1, "FadeSlow" );
    }
    
    a_ents = [];
    
    if ( isdefined( level.pilot ) )
    {
        namespace_b7cfe907::function_3af72756( level.var_7466d419, level.pilot, "driver" );
        level.pilot util::stop_magic_bullet_shield();
        a_ents[ #"pilot" ] = level.pilot;
    }
    
    if ( isdefined( level.copilot ) )
    {
        namespace_b7cfe907::function_3af72756( level.var_7466d419, level.copilot, "passenger1" );
        level.copilot util::stop_magic_bullet_shield();
        a_ents[ #"copilot" ] = level.copilot;
    }
    
    if ( isdefined( level.buddy ) )
    {
        namespace_b7cfe907::function_3af72756( level.var_7466d419, level.buddy, "crew" );
        a_ents[ #"buddy" ] = level.buddy;
    }
    
    if ( isdefined( level.vip ) )
    {
        namespace_b7cfe907::function_3af72756( level.var_7466d419, level.vip, "crew" );
        a_ents[ #"vip" ] = level.vip;
    }
    
    if ( isdefined( level.gunner ) )
    {
        if ( level.gunner flag::get( #"turret_pilot" ) )
        {
            level.var_7466d419 usevehicle( level.gunner, 1 );
            level.gunner flag::clear( #"turret_pilot" );
        }
        
        namespace_b7cfe907::function_3af72756( level.var_7466d419, level.gunner, "gunner1" );
        level.gunner util::stop_magic_bullet_shield();
        a_ents[ #"gunner" ] = level.gunner;
    }
    
    namespace_72b0499b::music( "tmp_crash_scene", 6 );
    objectives::scripted( #"nuke_return", undefined, #"hash_ac851f5cde226a9" );
    a_ents[ #"hash_4972abe0166bbc73" ] = level.var_7466d419;
    level scene::play( #"armada_crash_start", a_ents );
    objectives::complete( #"nuke_return" );
    skipto::function_4e3ab877( var_d3440450 );
}

// Namespace armada_crash/namespace_5243a812
// Params 0
// Checksum 0x779dc4c5, Offset: 0x9e8
// Size: 0x3c
function function_7b315e60()
{
    scene::add_scene_func( #"armada_crash_start", &function_b8cf916c, "play" );
}

// Namespace armada_crash/namespace_5243a812
// Params 1
// Checksum 0xfff727d5, Offset: 0xa30
// Size: 0xec
function function_b8cf916c( a_ents )
{
    if ( isdefined( a_ents[ #"vehicle 1" ] ) && isdefined( a_ents[ #"vehicle 2" ] ) )
    {
        streamermodelhint( a_ents[ #"vehicle 1" ].model, 30 );
        streamermodelhint( a_ents[ #"vehicle 2" ].model, 30 );
        a_ents[ #"vehicle 1" ] sethighdetail( 1 );
        a_ents[ #"vehicle 2" ] sethighdetail( 1 );
    }
}

// Namespace armada_crash/namespace_5243a812
// Params 4
// Checksum 0x67da66a, Offset: 0xb28
// Size: 0x6c
function function_9eecfef5( *name, *starting, *direct, *player )
{
    namespace_722cc932::function_208489a2();
    level clientfield::set( "toggle_gameplay_character_visibility", 1 );
    level thread function_6ac5ef82();
}

// Namespace armada_crash/namespace_5243a812
// Params 0
// Checksum 0xefc7bd8, Offset: 0xba0
// Size: 0xd4
function function_6ac5ef82()
{
    level flag::wait_till( #"all_players_spawned" );
    level.player setmovespeedscale( 0.35 );
    level.player setcinematicmotionoverride( #"hash_58e6030bfae1aaff" );
    level.player val::set( #"hash_296522f55a840af7", "allow_sprint", 0 );
    level clientfield::set( "" + #"hash_7dc38a630ed68eb3", 1 );
}

// Namespace armada_crash/namespace_5243a812
// Params 2
// Checksum 0xb4f524c2, Offset: 0xc80
// Size: 0x484
function function_58ef8b05( *str_objective, *var_50cc0d4f )
{
    level snd::client_msg( #"hash_66209bfcf3bd11ca" );
    level snd::client_msg( #"hash_4a41082a1d97f925" );
    spawner::add_global_spawn_function( #"axis", &function_21c6bdaa, 500 );
    
    if ( !isdefined( level.var_d3e0f34c ) )
    {
        namespace_b7cfe907::function_f305c075();
    }
    
    if ( isdefined( level.var_7466d419 ) )
    {
        level notify( #"hash_62387d6018db17f7" );
        level.var_7466d419 delete();
    }
    
    if ( isdefined( level.gunner ) )
    {
        level.gunner util::stop_magic_bullet_shield();
        level.gunner delete();
    }
    
    if ( isdefined( level.pilot ) )
    {
        level.pilot util::stop_magic_bullet_shield();
        level.pilot delete();
    }
    
    if ( isdefined( level.copilot ) )
    {
        level.copilot util::stop_magic_bullet_shield();
        level.copilot delete();
    }
    
    level thread exploder::exploder( "crash_env_smoke" );
    namespace_72b0499b::music( "tmp_crash_defend", 15 );
    level.vip namespace_b7cfe907::swap_hat_model();
    level.vip val::set( #"last_stand", "magic_bullet_shield" );
    level flag::set( "flag_vo_crash_wakeup" );
    util::delay( 15, undefined, &function_bbcf495 );
    util::delay( 20, undefined, &objectives::scripted, #"last_stand", undefined, #"hash_512f51804b601599", 1 );
    level.var_d3e0f34c thread dialogue::queue( "vox_guide9386ed6821b4b10ad5776c1694203e1" );
    level.var_d3e0f34c thread dialogue::queue( "vox_guid7a33a19b2ee64b2f8bdef45781f04e14" );
    level.var_d3e0f34c thread dialogue::queue( "vox_guid6252589a09cf4fbeaeef6b3c7e514e6e" );
    level thread scene::play( #"hash_30c1ba04c9ba0bf3", "intro" );
    level.player flag::wait_till_clear( #"scene" );
    level flag::set( "flag_vo_crash_attach_belt" );
    level.var_d3e0f34c setseatoccupied( 2, 0 );
    level.var_d3e0f34c makevehicleusable();
    level.var_d3e0f34c usevehicle( level.player, 2 );
    level.var_d3e0f34c makevehicleunusable();
    level thread savegame::checkpoint_save( 1 );
    function_9283a7e2();
    skipto::function_4e3ab877( "armada_crash_part_1_gunner" );
    level skipto::function_51726ac8( [ "armada_crash_part_4_laststand" ], 0 );
}

// Namespace armada_crash/namespace_5243a812
// Params 0
// Checksum 0xfe07bc44, Offset: 0x1110
// Size: 0xb0
function function_bbcf495()
{
    a_spawners = getspawnerarray( "crash_turret_enemies", "targetname" );
    
    foreach ( sp in a_spawners )
    {
        sp thread spawn_ai();
    }
}

// Namespace armada_crash/namespace_5243a812
// Params 0
// Checksum 0xd981aa8e, Offset: 0x11c8
// Size: 0xd6
function spawn_ai()
{
    self endon( #"death" );
    b_first = 1;
    
    while ( self.count > 0 )
    {
        if ( b_first )
        {
            b_first = 0;
            util::script_delay();
        }
        else
        {
            if ( is_true( self.var_e48ddb6b ) && isalive( self.e_ai ) )
            {
                self.e_ai waittill( #"death" );
            }
            
            util::script_wait();
        }
        
        self.e_ai = spawner::spawn();
    }
}

// Namespace armada_crash/namespace_5243a812
// Params 0
// Checksum 0xb009c85, Offset: 0x12a8
// Size: 0x160
function function_9283a7e2()
{
    level endon( #"hash_32a51c08a30d997b" );
    spawner::waittill_ai_group_count( "crash_turret_enemies", 2 );
    
    while ( true )
    {
        wait randomfloatrange( 0.333333, 0.666667 );
        a_enemies = getaiteamarray( #"axis" );
        
        if ( isarray( a_enemies ) && a_enemies.size )
        {
            ai = array::random( a_enemies );
            
            if ( isalive( ai ) )
            {
                v_source = level.vip gettagorigin( "tag_weapon_right" );
                magicbullet( level.vip.weapon, v_source, ai getcentroid(), level.vip );
                ai ai::bloody_death();
            }
        }
    }
}

// Namespace armada_crash/namespace_5243a812
// Params 3
// Checksum 0xda24260, Offset: 0x1410
// Size: 0x11a
function pstfx_slowed( n_time = 7.5, b_loop = 0, n_wait_time = 3 )
{
    self notify( #"stop_pstfx_slowed" );
    self endoncallback( &function_c2b2ee6, #"death", #"stop_pstfx_slowed" );
    
    for ( ;; )
    {
        clientfield::set_to_player( "pstfx_slowed", 1 );
        wait n_time;
        function_c2b2ee6();
        
        if ( b_loop )
        {
            if ( isarray( n_wait_time ) )
            {
                wait randomfloatrange( n_wait_time[ 0 ], n_wait_time[ 1 ] );
            }
            else
            {
                wait n_wait_time;
            }
            
            continue;
        }
        
        break;
    }
}

// Namespace armada_crash/namespace_5243a812
// Params 1
// Checksum 0xb070bd6, Offset: 0x1538
// Size: 0x24
function function_c2b2ee6( *param )
{
    clientfield::set_to_player( "pstfx_slowed", 0 );
}

// Namespace armada_crash/namespace_5243a812
// Params 4
// Checksum 0x53b9f51f, Offset: 0x1568
// Size: 0x8c
function function_398bee81( *name, starting, *direct, *player )
{
    spawner::remove_global_spawn_function( #"axis", &function_21c6bdaa );
    
    if ( player )
    {
        objectives::scripted( #"last_stand", undefined, #"hash_512f51804b601599" );
    }
}

// Namespace armada_crash/namespace_5243a812
// Params 0
// Checksum 0x327cab29, Offset: 0x1600
// Size: 0x92
function function_a337b00e()
{
    pistol = getweapon( "pistol_semiauto_t9" );
    level.vip aiutility::setprimaryweapon( pistol );
    level.vip ai::gun_switchto( pistol, "right" );
    level.vip.grenadeammo = 0;
    level.vip.canbemeleed = 0;
}

// Namespace armada_crash/namespace_5243a812
// Params 0
// Checksum 0xe973b1da, Offset: 0x16a0
// Size: 0x92
function function_c1b1ec5e()
{
    pistol = getweapon( "pistol_semiauto_t9" );
    level.buddy aiutility::setprimaryweapon( pistol );
    level.buddy ai::gun_switchto( pistol, "right" );
    level.buddy.grenadeammo = 0;
    level.buddy.canbemeleed = 0;
}

// Namespace armada_crash/namespace_5243a812
// Params 1
// Checksum 0x52161718, Offset: 0x1740
// Size: 0xc4
function smoke_signal( a_ents )
{
    a_ents[ #"smoke_signal" ] waittill( #"death" );
    v_org = a_ents[ #"smoke_signal" ].origin;
    level fx::play( #"hash_4aeb2425485e527", v_org, ( 0, 0, 0 ), "last_stand_beat_1" );
    level util::delay( "last_stand_beat_1", undefined, &fx::play, #"hash_66372422472364c", v_org );
}

// Namespace armada_crash/namespace_5243a812
// Params 2
// Checksum 0x3b4aca64, Offset: 0x1810
// Size: 0x4dc
function function_cd3c6f53( *str_objective, *var_50cc0d4f )
{
    callback::on_ai_spawned( &function_9a7a2ede );
    spawner::add_global_spawn_function( #"axis", &function_21c6bdaa );
    level snd::client_msg( #"hash_2086d5e690a6ff1b" );
    level snd::client_msg( #"hash_763d59f6976503eb" );
    util::delay( 10, undefined, &spawn_manager::enable, "last_stand_spawn_manager" );
    level thread scene::play( #"hash_30c1ba04c9ba0bf3", "outro" );
    level.player flag::wait_till_clear( #"scene" );
    level thread savegame::checkpoint_save( 1 );
    var_d0979dcb = getnode( "adler_last_stand_node", "targetname" );
    level.vip setgoal( var_d0979dcb, 1, 0 );
    level.vip flag::wait_till_clear( #"scene" );
    wait 7.5;
    level flag::set( "last_stand_beat_1" );
    level.vip dialogue::queue( "vox_guid074492a1027547619ebc008840148f1c" );
    wait 7.5;
    level.var_dfdeb3ed = 1;
    location = struct::get( "napalm_target1" );
    napalm_target_flyby_1 = struct::get( "napalm_target_flyby_1" );
    napalm_target_flyby_2 = struct::get( "napalm_target_flyby_2" );
    napalm_target_flyby_3 = struct::get( "napalm_target_flyby_3" );
    level.player thread napalm_strike::function_88e2e18a( napalm_target_flyby_1, #"allies", undefined, 0, "napalm_flyby_start_node_1" );
    level.player thread napalm_strike::function_88e2e18a( napalm_target_flyby_2, #"allies", undefined, 0, "napalm_flyby_start_node_2" );
    level.player thread napalm_strike::function_88e2e18a( napalm_target_flyby_3, #"allies", undefined, 0, "napalm_flyby_start_node_3" );
    napalm_target_flyby_3 waittill( #"hash_dce0602346144a3" );
    spawn_manager::enable( "last_stand_spawn_manager2" );
    level thread function_25d5fbb();
    level thread function_de3421fa();
    level waittill( #"drop_bombs" );
    level.player val::set( "armada_finish", "low_ready" );
    level.player setstance( "prone" );
    level.player freezecontrolsallowlook( 1 );
    wait 2;
    level.player lui::screen_fade_out( 2 );
    wait 2;
    level.player thread lui::screen_fade_in( 0.3 );
    level thread scene::play( #"hash_30c1ba04c9ba0bf3", "ending" );
    wait scene::function_8582657c( #"hash_30c1ba04c9ba0bf3", "ending" ) - 0.5;
    skipto::function_1c2dfc20( "cp_ger_hub_post_armada" );
}

// Namespace armada_crash/namespace_5243a812
// Params 0
// Checksum 0x3ba6e3f, Offset: 0x1cf8
// Size: 0x120
function function_25d5fbb()
{
    level endon( #"drop_bombs" );
    var_bd1e2865 = struct::get_array( "magic_rpg_source" );
    a_targets = struct::get_array( "magic_rpg_dest" );
    
    while ( true )
    {
        s_src = array::random( var_bd1e2865 );
        s_dest = arraysortclosest( a_targets, level.player.origin )[ 0 ];
        magicbullet( getweapon( #"launcher_freefire_t9" ), s_src.origin, s_dest.origin );
        wait randomfloatrange( 0.5, 3 );
    }
}

// Namespace armada_crash/namespace_5243a812
// Params 0
// Checksum 0x401fa7db, Offset: 0x1e20
// Size: 0x220
function function_de3421fa()
{
    level.player thread napalm_strike::function_88e2e18a( struct::get( "napalm_target1" ), #"allies", undefined, 0, "napalm_strike_path_start1" );
    level.player thread napalm_strike::function_88e2e18a( struct::get( "napalm_target2" ), #"allies", undefined, 0, "napalm_strike_path_start2" );
    level.player napalm_strike::function_88e2e18a( struct::get( "napalm_target3" ), #"allies", undefined, 0, "napalm_strike_path_start3" );
    exploder::exploder( "napalm_lingering_fire" );
    level.vip.perfectaim = 1;
    spawn_manager::kill( "last_stand_spawn_manager" );
    spawn_manager::kill( "last_stand_spawn_manager2" );
    
    foreach ( ai in getaiteamarray( #"axis" ) )
    {
        if ( isalive( ai ) )
        {
            ai util::delay( 0.2, "death", &kill );
        }
    }
}

// Namespace armada_crash/namespace_5243a812
// Params 0
// Checksum 0x4fb427a2, Offset: 0x2048
// Size: 0x12
function function_9a7a2ede()
{
    self.script_accuracy = 0.7;
}

// Namespace armada_crash/namespace_5243a812
// Params 1
// Checksum 0xd4287d56, Offset: 0x2068
// Size: 0x5c
function function_21c6bdaa( n_goal_radius = 1024 )
{
    if ( is_true( self.var_8e14f582 ) )
    {
        self setgoal( level.player, 1, n_goal_radius );
    }
}

