#using script_3b2905ec05ed796;
#using script_3dc93ca9902a9cda;
#using script_41e8adffbda93483;
#using script_4489198b8bcf36e8;
#using script_498cf7685befe7bf;
#using script_77f51076c7c89596;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flashlight;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\breadcrumbs;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;

#namespace namespace_c34cd176;

// Namespace namespace_c34cd176/namespace_c34cd176
// Params 1
// Checksum 0x559542fa, Offset: 0xc80
// Size: 0xfc
function function_25a6167c( *str_objective )
{
    exploder::exploder( "lgt_exp_pre_nuke_ext_lights" );
    namespace_534279a::spawn_allies( "catacombs_start" );
    level thread namespace_9e5ef376::function_b7e649c0( 1 );
    var_dbdb0082 = getentarray( "veh_courtyard_static", "targetname" );
    array::run_all( var_dbdb0082, &val::set, #"hash_7d97d109d0838d04", "ignoreme", 1 );
    var_fd4c649f = getent( "aa_courtyard", "targetname" );
    var_fd4c649f namespace_534279a::function_86201bb7();
}

// Namespace namespace_c34cd176/namespace_c34cd176
// Params 2
// Checksum 0xf6afcf2d, Offset: 0xd88
// Size: 0x1c4
function function_41e4735f( *str_objective, var_50cc0d4f )
{
    if ( var_50cc0d4f )
    {
        exploder::exploder( "fxexp_env_fx_set_courtyard" );
    }
    
    level thread hms_util::function_eaa0342e( "catacombs_containment_warn", "catacombs_containment_fail" );
    level.mason val::set( #"hash_427e34b7109385d2", "ignoreme", 1 );
    level.woods val::set( #"hash_427e34b7109385d2", "ignoreme", 1 );
    level thread function_861ceb4d( 0 );
    level thread function_9583a1e8();
    level thread function_5fc8eb8b();
    level thread function_7376de2a();
    level thread catacombs_adler_catchup();
    level.player namespace_534279a::function_a3c3a2b0();
    namespace_534279a::function_4f981a25( "right_path_catacombs_juggernaut_group", 1, "flg_catacombs_complete" );
    level flag::wait_till( "flg_catacombs_complete" );
    level thread skipto::function_4e3ab877( "catacombs" );
}

// Namespace namespace_c34cd176/namespace_c34cd176
// Params 4
// Checksum 0xe9e7b143, Offset: 0xf58
// Size: 0x24
function function_fa1a97a3( *str_objective, *var_50cc0d4f, *var_aa1a6455, *player )
{
    
}

// Namespace namespace_c34cd176/namespace_c34cd176
// Params 0
// Checksum 0x6579548a, Offset: 0xf88
// Size: 0x4c
function function_9a9ec77e()
{
    level flag::wait_till( "flg_catacomb_adler_walk" );
    level.adler ai::set_behavior_attribute( "_human_demeanor", "CQB" );
}

// Namespace namespace_c34cd176/namespace_c34cd176
// Params 0
// Checksum 0x990b01f0, Offset: 0xfe0
// Size: 0x41c
function function_983572d5()
{
    nd_goal = getnode( "nd_catacomb_advance_1", "targetname" );
    level flag::wait_till( "flg_catacomb_advance_1" );
    level.adler ai::set_behavior_attribute( "disablelean", 1 );
    level.adler ai::poi_enable( 1, struct::get( "catacombs_poi", "targetname" ) );
    level.adler thread hms_util::function_2f50100e( "stay_ahead", nd_goal.origin );
    level.adler thread hms_util::function_b064d2a4( "walk", nd_goal.origin, "flg_catacomb_advance_3", undefined, 1 );
    level flag::wait_till( "flg_catacomb_advance_3" );
    level thread function_8f35b40();
    level.player endon( #"player_is_ahead_of_ally" );
    nd_goal = getnode( "nd_catacomb_advance_3", "targetname" );
    level flag::wait_till( "flg_catacomb_advance_3" );
    level.adler thread hms_util::function_2f50100e( "stay_ahead", nd_goal.origin );
    level.adler thread hms_util::function_b064d2a4( "jog", nd_goal.origin, "flg_catacomb_advance_4", undefined, 1 );
    nd_goal = getnode( "nd_catacomb_advance_4", "targetname" );
    level flag::wait_till( "flg_catacomb_advance_4" );
    level.adler thread hms_util::function_2f50100e( "stay_ahead", nd_goal.origin );
    level.adler thread hms_util::function_b064d2a4( "run", nd_goal.origin, "flg_catacomb_advance_5", undefined, 1 );
    level.player thread callback::on_weapon_fired( &function_2cd9c163 );
    level.player thread callback::on_grenade_fired( &function_2cd9c163 );
    level flag::wait_till( "flg_catacomb_advance_5" );
    level.adler ai::set_behavior_attribute( "disablelean", 0 );
    level.adler ai::poi_enable( 0 );
    nd_goal = getnode( "nd_catacomb_advance_5", "targetname" );
    level.adler thread hms_util::function_2f50100e( "stay_ahead", nd_goal.origin, "disable_stay_ahead" );
    level.player util::blend_movespeedscale_default( 2 );
    level.adler ai::set_behavior_attribute( "_human_demeanor", "COMBAT" );
    level flag::wait_till( "flg_catacomb_hallway_fallback" );
    level.adler notify( #"disable_stay_ahead" );
}

// Namespace namespace_c34cd176/namespace_c34cd176
// Params 0
// Checksum 0xf63ecb61, Offset: 0x1408
// Size: 0xc4
function function_8f35b40()
{
    level.player flag::wait_till( "player_is_ahead_of_ally" );
    level.adler ai::set_behavior_attribute( "disablelean", 0 );
    level.adler ai::poi_enable( 0 );
    level.player util::blend_movespeedscale_default( 2 );
    level.adler ai::set_behavior_attribute( "_human_demeanor", "COMBAT" );
    level.adler notify( #"disable_stay_ahead" );
}

// Namespace namespace_c34cd176/namespace_c34cd176
// Params 0
// Checksum 0x29e8060b, Offset: 0x14d8
// Size: 0x84
function function_7376de2a()
{
    level endon( #"game_ended" );
    level flag::wait_till( "flg_catacombs_fx_event" );
    exploder::exploder( "fxexp_catacomb_tunnel_debris_falling" );
    level.player playrumbleonentity( "grenade_rumble" );
    snd::client_msg( "audio_catacombs_bomb_rumble" );
}

// Namespace namespace_c34cd176/namespace_c34cd176
// Params 0
// Checksum 0xa7b7ccc9, Offset: 0x1568
// Size: 0xbc
function catacombs_adler_catchup()
{
    level flag::wait_till( "flg_catacombs_adler_catchup" );
    var_fe52e195 = getent( "catacombs_adler_catchup_volume", "targetname" );
    
    if ( !level.adler istouching( var_fe52e195 ) )
    {
        var_57d1bda8 = struct::get( "catacombs_adler_catchup" );
        level.adler teleport( var_57d1bda8.origin, var_57d1bda8.angles );
    }
}

// Namespace namespace_c34cd176/namespace_c34cd176
// Params 1
// Checksum 0x16eb85e0, Offset: 0x1630
// Size: 0xb4
function function_2cd9c163( *params )
{
    self endon( #"death" );
    self endon( #"disconnected" );
    var_2406aadb = getent( "vol_catacombs_advance_5", "targetname" );
    var_2406aadb trigger::use();
    self callback::remove_on_weapon_fired( &function_2cd9c163 );
    self callback::remove_on_grenade_fired( &function_2cd9c163 );
}

// Namespace namespace_c34cd176/namespace_c34cd176
// Params 1
// Checksum 0x69f5a51, Offset: 0x16f0
// Size: 0x194
function function_861ceb4d( b_enabled )
{
    var_c0d91128 = getent( "catacomb_backtrack_door", "targetname" );
    var_a1c2e28e = getent( "catacomb_backtrack_door_collision", "targetname" );
    
    if ( !isdefined( b_enabled ) )
    {
        b_enabled = 0;
    }
    
    if ( b_enabled )
    {
        var_c0d91128 show();
        var_c0d91128 solid();
        var_c0d91128 disconnectpaths();
        var_a1c2e28e show();
        var_a1c2e28e solid();
        var_a1c2e28e disconnectpaths();
        return;
    }
    
    var_c0d91128 hide();
    var_c0d91128 notsolid();
    var_c0d91128 connectpaths();
    var_a1c2e28e hide();
    var_a1c2e28e notsolid();
    var_a1c2e28e connectpaths();
}

// Namespace namespace_c34cd176/namespace_c34cd176
// Params 0
// Checksum 0x625dec0a, Offset: 0x1890
// Size: 0x18c
function function_5fc8eb8b()
{
    level flag::wait_till( "flg_catacombs_dialog_start" );
    level.player hms_util::dialogue( "vox_cp_seig_01300_hdsn_adlerthisishuds_81", 1 );
    level.player hms_util::dialogue( "vox_cp_seig_01300_hdsn_givemesomegoodn_18", 1 );
    level.adler hms_util::dialogue( "vox_cp_seig_01300_adlr_wetookoutthefir_e7" );
    level.player hms_util::dialogue( "vox_cp_seig_01300_hdsn_thatsnotenough_37", 1 );
    level.adler hms_util::dialogue( "vox_cp_seig_01300_adlr_youdontthinkifu_aa" );
    level.player hms_util::dialogue( "vox_cp_seig_01300_hdsn_theclockisticki_e6", 1 );
    level.adler hms_util::dialogue( "vox_cp_seig_01300_adlr_youdothatandyou_ef" );
    level.adler hms_util::dialogue( "vox_cp_seig_01300_adlr_justwaitformysi_64" );
    wait 1;
    level.adler hms_util::dialogue( "vox_cp_seig_01300_adlr_mutteringgoddam_90" );
    level flag::wait_till( "flg_catacomb_hallway_fallback" );
}

// Namespace namespace_c34cd176/namespace_c34cd176
// Params 0, eflags: 0x4
// Checksum 0x9f19909e, Offset: 0x1a28
// Size: 0x48c
function private function_9583a1e8()
{
    level thread function_cf9cf841();
    level thread function_7867c8a3();
    level flag::wait_till( "flg_right_path_drop_down" );
    level.adler val::set( #"catacombs_start", "ignoreall", 1 );
    var_1af5ef75 = spawner::get_ai_group_ai( "right_path_catacomb_hallway_group" );
    array::run_all( var_1af5ef75, &val::set, #"catacombs_start", "ignoreall", 1 );
    level flag::wait_till( "flg_catacomb_advance_4" );
    savegame::checkpoint_save();
    level flag::wait_till( "flg_catacomb_contact" );
    level.adler val::reset( #"catacombs_start", "ignoreall" );
    var_1af5ef75 = spawner::get_ai_group_ai( "right_path_catacomb_hallway_group" );
    array::run_all( var_1af5ef75, &val::reset, #"catacombs_start", "ignoreall" );
    level.adler thread hms_util::dialogue( "vox_cp_seig_01400_adlr_contact_ed" );
    level thread function_95668a8c();
    namespace_534279a::function_4f981a25( "right_path_catacomb_hallway_group", 1, "flg_catacomb_hallway_fallback" );
    namespace_534279a::function_b5e4f3bc( "right_path_catacomb_hallway_group", "right_path_catacombs_back_volume", "script_noteworthy" );
    level flag::wait_till( "flg_right_path_catacomb_stair_sighting" );
    function_d044d1e1( "ar", "vol_fallback_1_ar" );
    wait 1;
    a_ai = spawner::simple_spawn( "catacomb_shotgunner" );
    array::thread_all( a_ai, &ai::force_goal, level.player );
    array::thread_all( a_ai, &ai::set_behavior_attribute, "demeanor", "cqb" );
    
    foreach ( ai in a_ai )
    {
        ai.grenadeammo = 0;
    }
    
    namespace_534279a::function_bd1a75b( "right_path_catacomb_group", 2, "flg_catacombs_fallback_1" );
    function_d044d1e1( "ar", "vol_fallback_1_ar" );
    namespace_534279a::function_bd1a75b( "right_path_catacomb_group", 1, "flg_catacombs_fallback_2" );
    function_d044d1e1( "ar", "vol_fallback_2_ar" );
    level flag::wait_till( "flg_catacomb_first_juggernaut_killed" );
    function_d044d1e1( "shotgun", "right_path_catacombs_back_volume" );
    function_d044d1e1( "smg", "right_path_catacombs_back_volume" );
    function_d044d1e1( "ar", "right_path_catacombs_back_volume" );
}

// Namespace namespace_c34cd176/namespace_c34cd176
// Params 2, eflags: 0x4
// Checksum 0x1787d592, Offset: 0x1ec0
// Size: 0xb4
function private function_d044d1e1( var_14b6bdf, var_dab80c52 )
{
    a_ai = getaiarray( var_14b6bdf, "script_string" );
    
    if ( isdefined( a_ai ) )
    {
        function_1eaaceab( a_ai );
        
        if ( a_ai.size > 0 )
        {
            vol_goal = getent( var_dab80c52, "targetname" );
            array::thread_all( a_ai, &ai::force_goal, vol_goal );
        }
    }
}

// Namespace namespace_c34cd176/namespace_c34cd176
// Params 0, eflags: 0x4
// Checksum 0x4bb0f57c, Offset: 0x1f80
// Size: 0x2c
function private function_95668a8c()
{
    wait 2;
    level flag::set( "flg_catacomb_hallway_fallback" );
}

// Namespace namespace_c34cd176/namespace_c34cd176
// Params 0, eflags: 0x4
// Checksum 0x526ea777, Offset: 0x1fb8
// Size: 0x4a4
function private function_cf9cf841()
{
    level endon( #"game_ended" );
    level.player endon( #"death" );
    level thread function_b12347a2();
    level flag::wait_till( "flg_right_path_catacomb_molotov_reveal" );
    level thread function_861ceb4d( 1 );
    exploder::stop_exploder( "fxexp_env_fx_set_courtyard" );
    exploder::exploder( "fxexp_env_fx_set_graveyard" );
    exploder::exploder( "fxexp_env_fx_set_graveyard_2" );
    function_d044d1e1( "ar", "vol_fallback_1_ar" );
    level thread function_bb281e43();
    wait 1;
    var_161f8862 = spawner::simple_spawn( "catacombs_juggernaut" );
    var_973037b3 = struct::get( "catacomb_juggernaut_tether_back" );
    var_65a28c66 = struct::get( "catacomb_juggernaut_tether_mid" );
    wait 0.1;
    var_161f8862[ 0 ] thread function_7711f534( var_973037b3, "jugg_intro_complete" );
    level flag::wait_till( "flg_catacombs_juggernaut_entered" );
    level.adler.canmelee = 0;
    
    if ( isalive( var_161f8862[ 0 ] ) )
    {
        var_161f8862[ 0 ].favoriteenemy = level.player;
        var_161f8862[ 0 ] namespace_631d466b::function_6aedb63( var_65a28c66.origin, var_65a28c66.radius );
        wait 0.5;
        var_47acec0 = getent( "catacomb_door", "targetname" );
        var_47acec0 movez( 96 * -1, 0.5 );
        snd::client_targetname( var_47acec0, "juggernaut_door_close" );
        level thread function_22082c46();
        level thread function_7f9c110c( var_161f8862[ 0 ], var_973037b3 );
        spawner::waittill_ai_group_amount_killed( "right_path_catacombs_juggernaut_group", 1 );
    }
    else
    {
        level flag::set( "flg_catacombs_juggernaut_killed_early" );
    }
    
    level flag::set( "flg_catacomb_first_juggernaut_killed" );
    level flag::set( "flg_catacomb_all_juggernauts_killed" );
    level.adler.canmelee = 1;
    level.adler thread function_69abda79();
    level thread function_d64774a5();
    
    if ( !level flag::get( "flg_catacombs_juggernaut_killed_early" ) )
    {
        wait 4.5;
        var_47acec0 movez( 96, 2 );
        snd::client_targetname( var_47acec0, "juggernaut_door_open" );
    }
    
    function_d044d1e1( "smg", "right_path_catacombs_far_back_volume" );
    function_d044d1e1( "ar", "right_path_catacombs_far_back_volume" );
    level.adler hms_util::dialogue( "vox_cp_seig_01400_adlr_wegotmaybefivem_94" );
    wait 1;
    level.adler hms_util::dialogue( "vox_cp_seig_01400_adlr_pickupthepace_c7" );
}

// Namespace namespace_c34cd176/namespace_c34cd176
// Params 2
// Checksum 0x2c84a42d, Offset: 0x2468
// Size: 0x94
function function_7f9c110c( var_f6ee0, var_3c2ac608 )
{
    while ( isalive( var_f6ee0 ) )
    {
        var_11423a93 = var_f6ee0.health / var_f6ee0.maxhealth;
        
        if ( var_11423a93 < 0.4 )
        {
            var_f6ee0 namespace_631d466b::function_6aedb63( var_3c2ac608.origin, var_3c2ac608.radius );
            break;
        }
        
        wait 0.25;
    }
}

// Namespace namespace_c34cd176/namespace_c34cd176
// Params 0
// Checksum 0xff7053cb, Offset: 0x2508
// Size: 0xcc
function function_d64774a5()
{
    wait 0.5;
    spawner::simple_spawn( "catacombs_juggernaut_support" );
    ai = spawner::simple_spawn_single( "catacombs_juggernaut_support_shotgunner" );
    ai thread ai::force_goal( level.player );
    wait 2;
    spawner::simple_spawn( "catacombs_juggernaut_support_delay" );
    spawner::waittill_ai_group_ai_count( "right_path_catacomb_group", 1 );
    namespace_534279a::function_b5e4f3bc( "right_path_catacomb_group", "catacombs_exit_fallback", "script_noteworthy" );
}

// Namespace namespace_c34cd176/namespace_c34cd176
// Params 0
// Checksum 0xb6199b6b, Offset: 0x25e0
// Size: 0x8c
function function_b12347a2()
{
    var_9717fa06 = getent( "jugg_spawn", "targetname" );
    level thread trigger::look_trigger( var_9717fa06 );
    var_9717fa06 waittill( #"trigger_look" );
    var_9717fa06 notify( #"death" );
    level flag::set( "flg_right_path_catacomb_molotov_reveal" );
}

// Namespace namespace_c34cd176/namespace_c34cd176
// Params 0, eflags: 0x4
// Checksum 0xe896beef, Offset: 0x2678
// Size: 0xb4
function private function_bb281e43()
{
    var_372d4d9 = struct::get( "catacomb_grenade_origin" );
    var_ba9bc2d9 = util::spawn_model( "tag_origin" );
    var_f0dacf8a = getweapon( #"hash_34fa23e332e34886" );
    w_grenade = var_ba9bc2d9 magicgrenadetype( var_f0dacf8a, var_372d4d9.origin, ( 0, 0, 0 ), 1 );
    var_ba9bc2d9 delete();
}

// Namespace namespace_c34cd176/namespace_c34cd176
// Params 2, eflags: 0x4
// Checksum 0x258f107d, Offset: 0x2738
// Size: 0x84
function private function_7711f534( var_477935fc, *str_notify )
{
    self.var_8ef7113a = 1;
    level thread function_e369720f( self );
    self namespace_631d466b::function_efd568bc( str_notify.origin, 32 );
    level flag::set( "flg_catacombs_juggernaut_entered" );
}

// Namespace namespace_c34cd176/namespace_c34cd176
// Params 1
// Checksum 0x7ea43147, Offset: 0x27c8
// Size: 0xc8
function function_e369720f( var_fed62d00 )
{
    var_b853736f = getent( "catacombs_juggernaut_entrance_trigger", "targetname" );
    
    while ( !level flag::get( "flg_catacombs_juggernaut_entered" ) )
    {
        s_notify = var_b853736f waittill( #"trigger" );
        
        if ( s_notify.activator === var_fed62d00 )
        {
            var_fed62d00 notify( #"goal" );
            level flag::set( "flg_catacombs_juggernaut_entered" );
        }
    }
}

// Namespace namespace_c34cd176/namespace_c34cd176
// Params 0, eflags: 0x4
// Checksum 0x15398b1b, Offset: 0x2898
// Size: 0xdc
function private function_22082c46()
{
    wait 1;
    level.adler hms_util::dialogue( "vox_cp_seig_01400_adlr_shitihatetheseg_31" );
    level.adler hms_util::dialogue( "vox_cp_seig_01400_adlr_takeemdownquick_f1" );
    wait 15;
    
    if ( !level flag::get( "flg_catacomb_first_juggernaut_killed" ) )
    {
        level.adler hms_util::dialogue( "vox_cp_seig_01400_adlr_aimfortheheadai_84" );
    }
    
    wait 15;
    
    if ( !level flag::get( "flg_catacomb_first_juggernaut_killed" ) )
    {
        level.adler hms_util::dialogue( "vox_cp_seig_01400_adlr_finishhimwerelo_2a" );
    }
}

// Namespace namespace_c34cd176/namespace_c34cd176
// Params 0, eflags: 0x4
// Checksum 0x6f2062a6, Offset: 0x2980
// Size: 0xaa
function private function_69abda79()
{
    level endon( #"game_ended" );
    level.adler endon( #"death" );
    
    if ( isdefined( level.adler ) )
    {
        var_ecd1d2eb = level.adler.script_accuracy;
        level.adler.script_accuracy = 0.9;
        level flag::wait_till( "flg_catacombs_complete" );
        level.adler.script_accuracy = var_ecd1d2eb;
    }
}

// Namespace namespace_c34cd176/namespace_c34cd176
// Params 0
// Checksum 0x3846e639, Offset: 0x2a38
// Size: 0xdc
function function_7867c8a3()
{
    level flag::wait_till( "flg_power_returns" );
    var_c3d060a6 = [];
    var_c3d060a6 = arraycombine( var_c3d060a6, spawner::get_ai_group_ai( "right_path_catacomb_hallway_group" ) );
    var_c3d060a6 = arraycombine( var_c3d060a6, spawner::get_ai_group_ai( "right_path_catacomb_group" ) );
    var_c3d060a6 = arraycombine( var_c3d060a6, spawner::get_ai_group_ai( "right_path_catacombs_juggernaut_group" ) );
    array::run_all( var_c3d060a6, &deletedelay );
}

// Namespace namespace_c34cd176/namespace_c34cd176
// Params 0
// Checksum 0x123256fb, Offset: 0x2b20
// Size: 0xd4
function function_fa8268b8()
{
    a_ai = spawner::get_ai_group_ai( "right_path_catacomb_group" );
    
    foreach ( ai in a_ai )
    {
        ai function_794e687();
    }
    
    spawner::add_spawn_function_ai_group( "right_path_catacomb_group", &function_794e687 );
}

// Namespace namespace_c34cd176/namespace_c34cd176
// Params 0
// Checksum 0xa73b5b03, Offset: 0x2c00
// Size: 0x3c
function function_794e687()
{
    self flashlight::function_32fb7a97( "tag_flash" );
    self flashlight::function_65e5c8c8( 1 );
}

