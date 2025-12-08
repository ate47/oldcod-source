#using script_2cd384a0f7be5baf;
#using script_3626f1b2cf51a99c;
#using script_3d81630134db409c;
#using script_4d984e2ed26bb2d9;
#using script_52da18c20f45c56a;
#using script_55d773296cc240b4;
#using script_5c325a0a637fdc2e;
#using script_6fad88ff3ed4ff7d;
#using script_c36b776c6718540;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp_common\breadcrumbs;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;

#namespace namespace_7ef9d872;

// Namespace namespace_7ef9d872/namespace_78b61e8b
// Params 2
// Checksum 0x8fdedcca, Offset: 0xab8
// Size: 0x534
function function_87560e1a( str_objective, var_50cc0d4f )
{
    level.player endon( #"death" );
    
    if ( var_50cc0d4f )
    {
        level thread function_79905291( "vh_kgb_excavation_hind" );
    }
    
    level thread function_94cfd8cf();
    level.ai_woods clearenemy();
    level thread namespace_8a404420::scene_yam_8001_srv_slide_approach();
    level.ai_woods.goalradius = 32;
    level thread server_attach_interact();
    level flag::wait_till( "flg_server_reveal_start" );
    level thread function_f4492634( "ai_server_preslide_gophers" );
    level flag::wait_till( "flg_server_reveal_jump_start" );
    objectives::complete( #"hash_e99b81d72c16905" );
    level thread function_f4492634( "ai_server_slide_gophers" );
    level.ai_woods val::set( #"server_slide", "ignoreall", 1 );
    level.ai_woods val::set( #"server_slide", "ignoreme", 1 );
    level thread function_e2241aaa();
    level flag::wait_till( "flg_server_room_start" );
    level.player val::reset_all( #"hash_7bed230cd6d62c10" );
    level.ai_woods val::reset_all( #"server_slide" );
    level.ai_woods.goalradius = 256;
    level scene::stop( "scene_yam_8001_srv_slide_approach" );
    namespace_8a404420::function_6699b719();
    savegame::function_7790f03( 1 );
    vol_server_reveal_upper_left = getent( "vol_server_reveal_upper_left", "targetname" );
    vol_server_reveal_backup = getent( "vol_server_reveal_backup", "targetname" );
    level.ai_woods thread function_8767f7a7();
    level thread namespace_7468806b::function_7cf87afb();
    level flag::wait_till_any( array( "flg_server_woods_slide", "flg_server_woods_front", "flg_cleanup_server_approach" ) );
    t_server_fall_kill = getent( "t_server_fall_kill", "targetname" );
    t_server_fall_kill delete();
    
    if ( !level flag::get( "flg_cleanup_server_approach" ) )
    {
        var_b95bc4d6 = spawner::simple_spawn( "ai_server_reveal_1" );
        doors::unlock( "door_server_backup_front", "targetname", 1 );
        spawner::simple_spawn( "ai_server_reveal_backup" );
        doors::unlock( "door_server_backup_right", "targetname", 1 );
    }
    
    level thread namespace_b73b9191::function_5d981106( "ai_server_reveal", 0, "flg_on_server" );
    level flag::wait_till( "flg_on_server" );
    level flag::wait_till_any( array( "flg_server_woods_slide", "flg_server_woods_front" ) );
    function_6137f397();
    level notify( #"stop_server_nag" );
    objectives::complete( "server_clear" );
    skipto::function_4e3ab877( str_objective );
}

// Namespace namespace_7ef9d872/namespace_78b61e8b
// Params 0
// Checksum 0xfc687d26, Offset: 0xff8
// Size: 0x76
function function_94cfd8cf()
{
    level.player endon( #"death" );
    level endon( #"flg_server_room_start" );
    
    while ( true )
    {
        if ( level flag::get( "flg_player_approaching_final_slide" ) )
        {
            level action_utility::function_1e8adf77();
        }
        
        waitframe( 1 );
    }
}

// Namespace namespace_7ef9d872/namespace_78b61e8b
// Params 1
// Checksum 0xc0666d59, Offset: 0x1078
// Size: 0x76
function function_f4492634( str_targetname )
{
    for ( i = 0; i < 3 ; i++ )
    {
        wait randomfloatrange( 1, 3 );
        ai = spawner::simple_spawn( str_targetname, &ai_server_slide_gophers );
    }
}

// Namespace namespace_7ef9d872/namespace_78b61e8b
// Params 2
// Checksum 0x17f2d54f, Offset: 0x10f8
// Size: 0x64
function function_6ba86af8( flag, e_goal )
{
    self endon( #"death" );
    level flag::wait_till( flag );
    self setgoal( e_goal, 1 );
}

// Namespace namespace_7ef9d872/namespace_78b61e8b
// Params 0
// Checksum 0x30e2789f, Offset: 0x1168
// Size: 0x9c
function ai_server_slide_gophers()
{
    self endon( #"death" );
    self val::set( "server_slide", "ignoreall", 1 );
    self val::set( "server_slide", "ignoreme", 1 );
    self waittill( #"goal" );
    self util::delayed_delete( 0.1 );
}

// Namespace namespace_7ef9d872/namespace_78b61e8b
// Params 0
// Checksum 0x8900e64b, Offset: 0x1210
// Size: 0x94
function function_100635e0()
{
    level flag::wait_till( "flg_server_woods_front" );
    var_f4b833a8 = spawner::simple_spawn_single( "ai_server_reveal_zipline" );
    level flag::wait_till( "flg_server_cable_attaching" );
    
    if ( isalive( var_f4b833a8 ) )
    {
        var_f4b833a8 delete();
    }
}

// Namespace namespace_7ef9d872/namespace_78b61e8b
// Params 0
// Checksum 0xa9b30929, Offset: 0x12b0
// Size: 0x1cc
function function_8767f7a7()
{
    level.ai_woods.goalradius = 128;
    level.ai_woods ai::function_3a5e9945( 1 );
    var_f42f9a55 = getnode( "woods_server_descent_start", "targetname" );
    level.ai_woods setgoal( var_f42f9a55 );
    level thread namespace_7468806b::function_d5600243( "stop_server_nag" );
    level flag::wait_till_any( array( "flg_server_reveal_left", "flg_server_reveal_right" ) );
    level.ai_woods ai::function_3a5e9945( 0 );
    var_8a10ced4 = getent( "vol_woods_server_front", "targetname" );
    level.ai_woods setgoal( var_8a10ced4 );
    level.ai_woods.perfectaim = 1;
    level flag::wait_till_any( array( "flg_server_woods_slide", "flg_server_woods_front" ) );
    level notify( #"stop_server_nag" );
    level thread namespace_7468806b::function_38d13158();
    level thread namespace_7468806b::function_d5600243( "stop_server_nag" );
}

// Namespace namespace_7ef9d872/namespace_78b61e8b
// Params 1
// Checksum 0x813e1989, Offset: 0x1488
// Size: 0xb4
function function_79905291( heli_targetname )
{
    level.var_ebbd5cf8 = namespace_b73b9191::function_f206e65e( heli_targetname, "sp_excavation_helo_pilot", 0 );
    level.var_ebbd5cf8 val::set( "server_heli", "ignoreme", 1 );
    level thread function_da1f037();
    snd::client_targetname( level.var_ebbd5cf8, "audio_srv_heli" );
    wait 3;
    namespace_7468806b::function_18babf5c();
}

// Namespace namespace_7ef9d872/namespace_78b61e8b
// Params 0
// Checksum 0x1d423c8, Offset: 0x1548
// Size: 0x2c
function function_da1f037()
{
    level scene::play( "scene_yam_7090_exc_heli_flyover", level.var_ebbd5cf8 );
}

// Namespace namespace_7ef9d872/namespace_78b61e8b
// Params 1
// Checksum 0x6ba6d1f4, Offset: 0x1580
// Size: 0xfc
function function_dba43792( *str_objective )
{
    objectives::complete( "obj_yamantau_3" );
    level thread objectives::scripted( "obj_yamantau_4", undefined, #"hash_74aac1baed0971dd" );
    level thread scene::play( "scene_yam_7010_exc_extraction", "stage3" );
    level thread breadcrumb::function_61037c6c( #"hash_28557f9975795d89" );
    namespace_b73b9191::function_2683ec5d();
    var_8c37586a = struct::get( "server_reveal_woods_start", "targetname" );
    level.ai_woods forceteleport( var_8c37586a.origin, var_8c37586a.angles );
}

// Namespace namespace_7ef9d872/namespace_78b61e8b
// Params 4
// Checksum 0x7bd24974, Offset: 0x1688
// Size: 0x24
function function_bb405879( *str_objective, *var_50cc0d4f, *var_aa1a6455, *player )
{
    
}

// Namespace namespace_7ef9d872/namespace_78b61e8b
// Params 0
// Checksum 0xb9d5bd48, Offset: 0x16b8
// Size: 0x44
function function_4cf852d1()
{
    self endon( #"death" );
    ai::shoot_at_target( "shoot_until_target_dead", level.player, undefined, 10, undefined, 1 );
}

// Namespace namespace_7ef9d872/namespace_78b61e8b
// Params 0
// Checksum 0xa735bbe3, Offset: 0x1708
// Size: 0x4c
function function_4ceba0c9()
{
    self endon( #"death" );
    level flag::wait_till( "flg_cleanup_server_approach" );
    self delete();
}

// Namespace namespace_7ef9d872/namespace_78b61e8b
// Params 0
// Checksum 0x558db5b5, Offset: 0x1760
// Size: 0xbc
function function_6137f397()
{
    level.ai_woods.goalradius = 32;
    level.ai_woods val::set( "server", "ignoreall", 1 );
    level.ai_woods setdesiredspeed( "sprint" );
    level.ai_woods val::reset( "server", "ignoreall" );
    level thread namespace_8a404420::function_e0069c97();
    level waittill( #"hash_3f088a5ad5757027" );
}

// Namespace namespace_7ef9d872/namespace_78b61e8b
// Params 2
// Checksum 0xcf96c5a8, Offset: 0x1828
// Size: 0x5c4
function function_e936fbf4( str_objective, var_50cc0d4f )
{
    var_a6937647 = struct::get( "server_attach_interact", "targetname" );
    objectives::goto( #"hash_4141fb8a6f3458b2", var_a6937647.origin + ( 0, 0, 30 ) );
    objectives::complete( "obj_yamantau_4" );
    objectives::scripted( "obj_yamantau_5", undefined, #"hash_22b60d94db70b18c" );
    
    if ( var_50cc0d4f )
    {
        t_server_fall_kill = getent( "t_server_fall_kill", "targetname" );
        t_server_fall_kill delete();
        level thread server_attach_interact();
        function_6137f397();
    }
    
    level thread namespace_8a404420::function_a8eb3579();
    level.ai_woods val::set( "server", "ignoreall", 1 );
    level.ai_woods.attackeraccuracy = 0.01;
    level thread namespace_7468806b::function_49572f9a();
    level flag::wait_till( "flg_woods_server_nag" );
    level flag::wait_till( "flg_server_cable_attaching" );
    level.var_17d7d4dc.var_121c5e14 setmovingplatformenabled( 1 );
    objectives::complete( #"hash_4141fb8a6f3458b2" );
    level flag::wait_till( "flg_server_cable_spawn_attackers" );
    level.var_17d7d4dc.var_5a8a0179 solid();
    callback::on_ai_damage( &namespace_25845e22::function_9ee98725 );
    var_be7ede03 = spawner::simple_spawn( "ai_server_reveal_snipers_upper" );
    nd_server_lift_guard_01 = getnode( "nd_server_lift_guard_01", "targetname" );
    nd_server_lift_guard_02 = getnode( "nd_server_lift_guard_02", "targetname" );
    var_be7ede03[ 0 ] setgoal( nd_server_lift_guard_01, 1 );
    var_be7ede03[ 1 ] setgoal( nd_server_lift_guard_02, 1 );
    level waittill( #"hash_23f689b82d9c89ab" );
    level.var_6cc58e4b = 1;
    level callback::on_player_killed( &function_ce966826 );
    wait 0.2;
    level.player actions::function_fc288808();
    level thread function_6dcdd6a6();
    level flag::wait_till( "flg_server_cable_attached" );
    level.ai_woods linkto( level.var_17d7d4dc.var_121c5e14 );
    savegame::function_7790f03( 1 );
    objectives::complete( "obj_yamantau_5" );
    objectives::scripted( "obj_yamantau_6", undefined, #"hash_20bf411b274bfe85" );
    level thread function_f5c1bd9b();
    level thread namespace_7468806b::function_4175d4c2();
    var_233809e = getentarray( "cp_explosive_barrel", "targetname" );
    
    foreach ( barrel in var_233809e )
    {
        barrel.health = 5;
    }
    
    namespace_1d6bb8b4::function_3b57a70e();
    callback::remove_on_ai_damage( &namespace_25845e22::function_9ee98725 );
    level thread function_b62fff3d();
    level waittill( #"hash_2fe46a0db2c6edd1" );
    skipto::function_4e3ab877( str_objective );
    skipto::function_1c2dfc20( "cp_ger_hub_post_yamantau" );
}

// Namespace namespace_7ef9d872/namespace_78b61e8b
// Params 0
// Checksum 0xd145e4de, Offset: 0x1df8
// Size: 0x9c
function function_6dcdd6a6()
{
    wait 3;
    var_d06cdfcb = spawner::simple_spawn( "ai_server_reveal_lower_left" );
    doors::unlock( "door_server_backup_left", "targetname", 1 );
    wait 1;
    spawner::simple_spawn( "ai_server_reveal_back" );
    doors::unlock( "door_server_backup_rear", "targetname", 1 );
}

// Namespace namespace_7ef9d872/namespace_78b61e8b
// Params 0
// Checksum 0x75e9b4bc, Offset: 0x1ea0
// Size: 0x7c
function function_b62fff3d()
{
    level waittill( #"hash_40a006c39854958" );
    n_time = float( soundgetplaybacktime( "vox_cp_ymnt_02400_wood_werecleardimitr_8b" ) ) / 1000;
    wait n_time;
    level.player actions::function_e972f9a5();
}

// Namespace namespace_7ef9d872/namespace_78b61e8b
// Params 0
// Checksum 0x3cab651a, Offset: 0x1f28
// Size: 0x374
function server_attach_interact()
{
    level waittill( #"hash_1d64100e7ce394d" );
    level.var_dcfe7888 = getent( "vol_server_ai_1", "targetname" );
    var_a6937647 = struct::get( "server_attach_interact", "targetname" );
    var_ef3d9775 = struct::get( "server_attach_anchor", "targetname" );
    var_a6937647 util::create_cursor_hint( undefined, undefined, #"hash_4567f6915161496a", 48, 1, undefined, undefined, 2000, undefined, undefined, 1, 1, &function_a1ae75fc );
    level flag::set( "flg_woods_server_nag" );
    var_a6937647 waittill( #"trigger" );
    str_stance = level.player getstance();
    
    switch ( str_stance )
    {
        case #"crouch":
            level.player setstance( "stand" );
            wait 0.2;
            break;
        case #"prone":
            level.player setstance( "stand" );
            wait 1;
            break;
    }
    
    level.player thread actions::function_e972f9a5();
    e_anchor = util::spawn_model( #"tag_origin", level.player.origin, level.player.angles );
    
    while ( !isdefined( e_anchor ) )
    {
        waitframe( 1 );
    }
    
    level.player playerlinktodelta( e_anchor, "tag_origin", 1, 95, 95, 45, 45 );
    e_anchor moveto( var_ef3d9775.origin, 0.5 );
    e_anchor rotateto( var_ef3d9775.angles, 0.5 );
    wait 0.5;
    e_anchor unlink();
    e_anchor delete();
    level flag::set( "flg_server_cable_attaching" );
    level.ai_woods notify( #"flg_server_cable_attaching" );
    wait 5;
    level flag::set( "flg_server_cable_spawn_attackers" );
}

// Namespace namespace_7ef9d872/namespace_78b61e8b
// Params 1
// Checksum 0x57e8e7ee, Offset: 0x22a8
// Size: 0x2a
function function_a1ae75fc( s_info )
{
    return s_info.player istouching( level.var_dcfe7888 );
}

// Namespace namespace_7ef9d872/namespace_78b61e8b
// Params 0
// Checksum 0xd0fcce90, Offset: 0x22e0
// Size: 0x688
function function_f5c1bd9b()
{
    level waittill( #"hash_12b31d6a99eea81a" );
    var_e5b0ac66 = spawner::simple_spawn( "ai_server_lift_floor_1" );
    doors::unlock( "door_vault_lift_floor_1", "targetname", 1 );
    level waittill( #"hash_a8ac86a957464eb" );
    var_c0ac910e = spawner::simple_spawn( "ai_server_lift_floor_2_a" );
    level waittill( #"hash_a8ac96a9574669e" );
    var_d6f6bda2 = spawner::simple_spawn( "ai_server_lift_floor_2_b" );
    var_b379f6a9 = spawner::simple_spawn( "ai_server_lift_floor_2_d" );
    level waittill( #"hash_7fd5af6a8ecf4f70" );
    var_2357c123 = spawner::simple_spawn( "ai_server_lift_floor_3_a" );
    level waittill( #"hash_209a58fdf8310232" );
    profilestart();
    var_b8009024 = spawn( "script_origin", level.player.origin );
    var_b8009024.angles = level.player.angles;
    var_b8009024 linkto( level.var_17d7d4dc.var_121c5e14 );
    level.player playerlinktodelta( var_b8009024 );
    earthquake( 0.3, 0.2, level.player.origin, 64 );
    profilestop();
    level waittill( #"hash_4f2bf4110fc24572" );
    earthquake( 0.3, 0.2, level.player.origin, 64 );
    var_b8009024 delete();
    level waittill( #"hash_7fd5b26a8ecf5489" );
    var_91eea144 = spawner::simple_spawn( "ai_server_lift_floor_3_smash" );
    s_server_lift_rpg_1_origin = struct::get( "s_server_lift_rpg_1_origin", "targetname" );
    s_server_lift_rpg_1_target = struct::get( "s_server_lift_rpg_1_target", "targetname" );
    s_server_lift_rpg_2_origin = struct::get( "s_server_lift_rpg_2_origin", "targetname" );
    s_server_lift_rpg_2_target = struct::get( "s_server_lift_rpg_2_target", "targetname" );
    var_2478b276 = getweapon( #"hash_706b2d9309cd7d8b" );
    magicbullet( var_2478b276, s_server_lift_rpg_2_origin.origin, s_server_lift_rpg_2_target.origin );
    wait 0.5;
    magicbullet( var_2478b276, s_server_lift_rpg_1_origin.origin, s_server_lift_rpg_1_target.origin );
    level waittill( #"hash_7fd5b16a8ecf52d6" );
    earthquake( 0.8, 1, level.player.origin, 512 );
    target_pos = struct::get( "s_vault_smash", "targetname" );
    exploder::exploder( "server_hit" );
    
    for ( i = 0; i < 3 ; i++ )
    {
        if ( var_91eea144[ i ].health > 0 )
        {
            level thread scene::play( #"hash_2c3b41681130ce9" + i + 1, var_91eea144[ i ] );
        }
    }
    
    level waittill( #"hash_7fd5b46a8ecf57ef" );
    var_20b53bde = spawner::simple_spawn( "ai_server_lift_floor_3_c" );
    var_72845f7b = spawner::simple_spawn( "ai_server_lift_floor_3_d" );
    level waittill( #"hash_79609a6a8bc70d81" );
    var_6ff151eb = spawner::simple_spawn( "ai_server_lift_floor_4_a" );
    level waittill( #"hash_6f191fcaa2309f29" );
    level waittill( #"hash_52b20c7e767b2318" );
    var_7d1e6c45 = spawner::simple_spawn( "ai_server_lift_floor_4_b" );
    var_7faf0fa = arraycombine( var_6ff151eb, var_7d1e6c45 );
    level waittill( #"hash_1f851ee5f4d951a8" );
    
    foreach ( ai in var_7faf0fa )
    {
        if ( isalive( ai ) )
        {
            ai val::set( "server_lift", "ignoreall", 1 );
        }
    }
}

// Namespace namespace_7ef9d872/namespace_78b61e8b
// Params 1
// Checksum 0x3f69cf53, Offset: 0x2970
// Size: 0xf4
function function_f59af500( *str_objective )
{
    level.var_ebbd5cf8 = namespace_b73b9191::function_f206e65e( "vh_kgb_server_lift_hind", "sp_excavation_helo_pilot", 0 );
    level.var_ebbd5cf8 val::set( "server_heli", "ignoreme", 1 );
    level thread scene::play( "scene_yam_7010_exc_extraction", "stage3" );
    namespace_b73b9191::function_2683ec5d();
    var_b4bb921 = struct::get( "woods_server_attach_teleport", "targetname" );
    level.ai_woods forceteleport( var_b4bb921.origin, var_b4bb921.angles );
}

// Namespace namespace_7ef9d872/namespace_78b61e8b
// Params 4
// Checksum 0xe3cdfdb5, Offset: 0x2a70
// Size: 0x24
function function_b80cf494( *str_objective, *var_50cc0d4f, *var_aa1a6455, *player )
{
    
}

// Namespace namespace_7ef9d872/namespace_78b61e8b
// Params 1
// Checksum 0xc8a6284f, Offset: 0x2aa0
// Size: 0x4c
function function_7319dbc7( e_player )
{
    e_player endon( #"death" );
    
    while ( !e_player istouching( self ) )
    {
        wait 0.5;
    }
}

// Namespace namespace_7ef9d872/namespace_78b61e8b
// Params 1
// Checksum 0x27ff0fba, Offset: 0x2af8
// Size: 0x5c
function function_fa87d829( str_targetname )
{
    var_a3c01854 = getnode( str_targetname, "targetname" );
    level.ai_woods setgoal( var_a3c01854, 1 );
}

// Namespace namespace_7ef9d872/namespace_78b61e8b
// Params 0
// Checksum 0xa21a516a, Offset: 0x2b60
// Size: 0x44
function function_c78b88a0()
{
    self enableaimassist();
    self waittill( #"death" );
    self disableaimassist();
}

// Namespace namespace_7ef9d872/namespace_78b61e8b
// Params 1
// Checksum 0xe6e48164, Offset: 0x2bb0
// Size: 0x144
function function_ce966826( *s_params )
{
    waitframe( 1 );
    player_pos = self getplayercamerapos();
    var_cac40761 = self getplayerangles();
    v_forward = vectornormalize( anglestoforward( var_cac40761 ) ) * 50 + ( 0, 0, 30 );
    e_anchor = util::spawn_model( #"tag_origin", player_pos - v_forward, var_cac40761 );
    var_121c5e14 = getent( "vault_lift", "targetname" );
    e_anchor linkto( var_121c5e14 );
    
    for ( i = 0; i < 3 ; i++ )
    {
        waitframe( 1 );
        self camerasetposition( e_anchor );
    }
}

// Namespace namespace_7ef9d872/namespace_78b61e8b
// Params 0
// Checksum 0x3cf3426c, Offset: 0x2d00
// Size: 0x1f0
function function_8627ac91()
{
    self endon( #"death" );
    
    while ( true )
    {
        s_notify = level waittill( #"woods_stumble_left", #"woods_stumble_right", #"woods_stumble_forward", #"woods_stumble_back" );
        level.ai_woods val::set( "server", "ignoreall", 1 );
        waitframe( 1 );
        
        switch ( s_notify._notify )
        {
            case #"woods_stumble_left":
                self scene::play( "scene_yam_8020_sra_server_ascent_woods_stumble", "woods_stumble_left", self );
                break;
            case #"woods_stumble_right":
                self scene::play( "scene_yam_8020_sra_server_ascent_woods_stumble", "woods_stumble_right", self );
                break;
            case #"woods_stumble_forward":
                self scene::play( "scene_yam_8020_sra_server_ascent_woods_stumble", "woods_stumble_forward", self );
                break;
            case #"woods_stumble_back":
                self scene::play( "scene_yam_8020_sra_server_ascent_woods_stumble", "woods_stumble_back", self );
                break;
            default:
                break;
        }
        
        waitframe( 1 );
        level.ai_woods val::reset( "server", "ignoreall" );
    }
}

// Namespace namespace_7ef9d872/namespace_78b61e8b
// Params 0
// Checksum 0xe717edcc, Offset: 0x2ef8
// Size: 0x9c
function function_e2241aaa()
{
    level flag::wait_till( "flg_server_reveal_slide_stop_mb" );
    level.player val::set( #"hash_7bed230cd6d62c10", "disable_weapons", 1 );
    level.player val::set( #"hash_7bed230cd6d62c10", "freezecontrols_allowlook", 1 );
    wait 0.3;
}

