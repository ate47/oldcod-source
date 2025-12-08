#using script_2ef0cf51653aaada;
#using script_35ae72be7b4fec10;
#using script_41e8adffbda93483;
#using script_498cf7685befe7bf;
#using script_77f51076c7c89596;
#using script_e3ec3024527fc15;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;

#namespace namespace_b11c1856;

// Namespace namespace_b11c1856/namespace_b11c1856
// Params 1
// Checksum 0xe86746d, Offset: 0x718
// Size: 0x154
function starting( *str_objective )
{
    level.allowbattlechatter[ #"allies" ] = 0;
    level.allowbattlechatter[ #"axis" ] = 0;
    exploder::exploder( "lgt_exp_pre_nuke_ext_lights" );
    namespace_534279a::spawn_allies();
    namespace_604e2e22::function_3b9e7104();
    level.var_77be18d2 = vehicle::simple_spawn_single( "player_fav" );
    level.var_7b278a4f = vehicle::simple_spawn_single( "ally_fav_left" );
    level.var_5d798cf2 = vehicle::simple_spawn_single( "ally_fav_right" );
    vehicle::simple_spawn( "veh_town" );
    vehicle::simple_spawn( "veh_guard_station" );
    level thread namespace_604e2e22::function_1e2a0690( "aa_courtyard", "courtyard_aa_gunner", "scene_sge_0000_ambient_aa_gun" );
    snd::client_targetname( level.var_77be18d2, "audio_vehicle_drive_in_post_emp" );
}

// Namespace namespace_b11c1856/namespace_b11c1856
// Params 2
// Checksum 0x3df42df5, Offset: 0x878
// Size: 0x246
function main( *str_objective, var_50cc0d4f )
{
    level.player.var_ee4032c4 = 0;
    savegame::checkpoint_save();
    
    if ( var_50cc0d4f === 1 )
    {
        level.var_77be18d2 thread vehicle::lights_on();
        level thread namespace_ce17746::function_ee43d0f7();
        level thread namespace_ce17746::function_53c16fe1();
        level thread namespace_604e2e22::function_4a3de7f5( "emp" );
        exploder::exploder( "fxexp_env_fx_set_courtyard" );
        scene::function_27f5972e( "p9_fxanim_cp_siege_watch_tower_destruction_bundle" );
        scene::function_27f5972e( "p9_fxanim_cp_siege_wood_gate_bundle" );
    }
    
    level thread function_7df588f1();
    level thread function_b644bfb7();
    level thread function_cee4c961();
    level thread function_575dfa11();
    level thread function_e9849cb4();
    level thread function_993246a7();
    level thread function_669e6733();
    level thread function_86f5a078();
    level thread function_ba67eb3b();
    level waittill( #"hash_591304b4cda16171" );
    skipto::function_4e3ab877( "EMP_flash" );
    function_f3c202c9();
    snd::client_targetname( level.var_77be18d2, "audio_vehicle_drive_in_post_emp" );
    level.player.var_ee4032c4 = undefined;
}

// Namespace namespace_b11c1856/namespace_b11c1856
// Params 0
// Checksum 0xb94e5a93, Offset: 0xac8
// Size: 0x404
function function_7df588f1()
{
    level flag::wait_till( "flg_emp_blast" );
    var_8cb61842 = spawner::simple_spawn( "emp_enemy" );
    
    foreach ( ai in var_8cb61842 )
    {
        level thread function_d2b31a03( ai );
    }
    
    a_ai = spawner::simple_spawn( "emp_turret_enemy" );
    var_e37ea03f = undefined;
    var_8933ebaf = undefined;
    var_79c24ccc = undefined;
    var_f1a8db84 = undefined;
    var_71c65bbd = undefined;
    var_8300fe32 = undefined;
    
    foreach ( ai in a_ai )
    {
        nd = getnode( ai.target, "targetname" );
        vh = function_1a2a3760( nd );
        vh setteam( "axis" );
        vh turretsetontargettolerance( 0, 0 );
        vh turret::enable( 0 );
        vh turret::set_burst_parameters( randomintrange( 5, 10 ), randomintrange( 10, 15 ), randomfloatrange( 0.25, 0.5 ), randomfloatrange( 0.5, 0.75 ), 0 );
        vh turret::get_in( ai, 0 );
        
        if ( isdefined( ai.script_noteworthy ) )
        {
            switch ( ai.script_noteworthy )
            {
                case #"intro_hit_player_1":
                    var_e37ea03f = ai;
                    var_f1a8db84 = vh;
                    break;
                case #"intro_hit_player_2":
                    var_8933ebaf = ai;
                    var_71c65bbd = vh;
                    break;
                case #"intro_hit_player_3":
                    var_79c24ccc = ai;
                    var_8300fe32 = vh;
                    break;
                default:
                    assertmsg( "<dev string:x38>" );
                    break;
            }
        }
    }
    
    level thread function_74bcaf79( var_e37ea03f, var_8933ebaf, var_79c24ccc, var_f1a8db84, var_71c65bbd, var_8300fe32 );
    level flag::wait_till( "flg_spawn_drones_1" );
    level.var_4180f434 = spawner::simple_spawn( "spawn_drones_1" );
}

// Namespace namespace_b11c1856/namespace_b11c1856
// Params 6
// Checksum 0x6e45e5ec, Offset: 0xed8
// Size: 0x1cc
function function_74bcaf79( var_e37ea03f, var_8933ebaf, var_79c24ccc, var_f1a8db84, var_71c65bbd, var_8300fe32 )
{
    level thread function_6ad56a7d();
    level flag::wait_till( "flg_intro_hit_player_1" );
    function_544c7da1( var_e37ea03f, var_f1a8db84 );
    
    if ( level.player getammocount( level.player.currentweapon ) == 36 )
    {
        function_544c7da1( var_e37ea03f, var_f1a8db84 );
    }
    
    level flag::wait_till( "flg_intro_hit_player_2" );
    function_544c7da1( var_8933ebaf, var_71c65bbd );
    
    if ( level.player.var_ee4032c4 < 3 )
    {
        function_544c7da1( var_8933ebaf, var_71c65bbd );
    }
    
    level flag::wait_till( "flg_intro_hit_player_3" );
    function_544c7da1( var_79c24ccc, var_8300fe32 );
    
    if ( level.player.var_ee4032c4 < 6 )
    {
        function_544c7da1( var_79c24ccc, var_8300fe32 );
    }
    
    level.player val::reset( #"emp_mg", "takedamage" );
}

// Namespace namespace_b11c1856/namespace_b11c1856
// Params 0
// Checksum 0x6c2e8316, Offset: 0x10b0
// Size: 0x64
function function_6ad56a7d()
{
    wait 2;
    level flag::set( "flg_intro_hit_player_1" );
    wait 6;
    level flag::set( "flg_intro_hit_player_2" );
    wait 6;
    level flag::set( "flg_intro_hit_player_3" );
}

// Namespace namespace_b11c1856/namespace_b11c1856
// Params 2
// Checksum 0x14c190fd, Offset: 0x1120
// Size: 0x34a
function function_544c7da1( ai, vh )
{
    if ( !isalive( ai ) )
    {
        return;
    }
    
    ai endon( #"death" );
    ai endon( #"entitydeleted" );
    level.var_77be18d2.ignoreme = 0;
    vh turret::set_burst_parameters( 100, 100, 0.05, 0.05, 0 );
    level thread function_57a15b5( ai, vh );
    wait 1;
    level.player val::set( #"emp_mg", "takedamage", 1 );
    level.player dodamage( 25, vh.origin );
    level.player val::set( #"emp_mg", "takedamage", 0 );
    wait randomfloatrange( 0.1, 0.3 );
    level.player val::set( #"emp_mg", "takedamage", 1 );
    level.player dodamage( 25, vh.origin );
    level.player val::set( #"emp_mg", "takedamage", 0 );
    wait randomfloatrange( 0.5, 1 );
    level.player val::set( #"emp_mg", "takedamage", 1 );
    level.player dodamage( 25, vh.origin );
    level.player val::set( #"emp_mg", "takedamage", 0 );
    wait 1;
    vh turret::set_burst_parameters( randomintrange( 5, 10 ), randomintrange( 10, 15 ), randomfloatrange( 0.25, 0.5 ), randomfloatrange( 0.5, 0.75 ), 0 );
    level.var_77be18d2.ignoreme = 1;
}

// Namespace namespace_b11c1856/namespace_b11c1856
// Params 2
// Checksum 0xf16e3071, Offset: 0x1478
// Size: 0x128
function function_57a15b5( ai, vh )
{
    ai endon( #"death" );
    ai endon( #"entitydeleted" );
    i = 0;
    
    while ( i < 2 )
    {
        var_21bd6951 = randomfloatrange( -50, 50 );
        var_ef7f04d5 = randomfloatrange( -50, 50 );
        var_fd39a04a = randomfloatrange( -50, 50 );
        vh turret::set_target( level.var_77be18d2, ( var_21bd6951, var_ef7f04d5, var_fd39a04a + 50 ), 0, 1, 1 );
        wait 0.05;
        i += 0.05;
    }
}

// Namespace namespace_b11c1856/namespace_b11c1856
// Params 1
// Checksum 0x556b9ece, Offset: 0x15a8
// Size: 0x6c
function function_d2b31a03( ai )
{
    s_result = ai waittill( #"death" );
    
    if ( s_result.weapon.name == #"hash_154127ac67af815e" )
    {
        level.player.var_ee4032c4++;
    }
}

// Namespace namespace_b11c1856/namespace_b11c1856
// Params 0
// Checksum 0x71cbd86e, Offset: 0x1620
// Size: 0x370
function function_b644bfb7()
{
    level waittill( #"hash_100baecc1ac1beca" );
    a_ai = spawner::get_ai_group_ai( "emp_group" );
    array::run_all( a_ai, &deletedelay );
    level waittill( #"hash_4df9e3fc761b00b4" );
    a_ai = spawner::get_ai_group_ai( "town_group" );
    array::run_all( a_ai, &deletedelay );
    var_fb90e03a = getentarray( "veh_town", "targetname" );
    
    foreach ( e in var_fb90e03a )
    {
        e notify( #"hash_6c7ae72dc5e27d35" );
        e deletedelay();
    }
    
    level waittill( #"hash_188b223cffb6e50a" );
    a_ai = spawner::get_ai_group_ai( "guard_station_group" );
    array::run_all( a_ai, &deletedelay );
    var_fb90e03a = getentarray( "veh_guard_station", "targetname" );
    
    foreach ( e in var_fb90e03a )
    {
        e notify( #"hash_6c7ae72dc5e27d35" );
        e deletedelay();
    }
    
    level waittill( #"hash_465d6bb5960c37f8" );
    a_ai = spawner::get_ai_group_ai( "tower_group" );
    array::run_all( a_ai, &deletedelay );
    a_ai = spawner::get_ai_group_ai( "tower_rpg_group" );
    array::run_all( a_ai, &deletedelay );
    
    foreach ( drone in level.var_4180f434 )
    {
        if ( isdefined( drone ) )
        {
            drone deletedelay();
        }
    }
}

// Namespace namespace_b11c1856/namespace_b11c1856
// Params 0
// Checksum 0x19df6d89, Offset: 0x1998
// Size: 0x18c
function function_de2dfc58()
{
    wait 20;
    level endon( #"camera_movement" );
    level thread function_86531f64();
    var_94c47885 = ( -6, 0, 0 );
    n_lerp_time = 5;
    var_c046d22f = level.player getplayerangles();
    i = 0;
    
    while ( i <= n_lerp_time )
    {
        var_6603789d = i / n_lerp_time;
        x = ( var_94c47885[ 0 ] - var_c046d22f[ 0 ] ) * var_6603789d + var_c046d22f[ 0 ];
        y = ( var_94c47885[ 1 ] - var_c046d22f[ 1 ] ) * var_6603789d + var_c046d22f[ 1 ];
        z = ( var_94c47885[ 2 ] - var_c046d22f[ 2 ] ) * var_6603789d + var_c046d22f[ 2 ];
        level.player setplayerangles( ( x, y, z ) );
        wait 0.05;
        i += 0.05;
    }
    
    level.player cameraactivate( 0 );
}

// Namespace namespace_b11c1856/namespace_b11c1856
// Params 0
// Checksum 0x8477f654, Offset: 0x1b30
// Size: 0x7c
function function_86f5a078()
{
    level flag::wait_till( "flg_emp_blast" );
    wait 1.25;
    magicbullet( getweapon( "launcher_standard_t9_cp_straight_shot_siege" ), ( -818, 7011, 250 ), ( 2194, 3652, 125 ), level.player );
}

// Namespace namespace_b11c1856/namespace_b11c1856
// Params 0
// Checksum 0x350657b, Offset: 0x1bb8
// Size: 0x27c
function function_ba67eb3b()
{
    level waittill( #"flg_wall_rpg" );
    level thread function_8d1484b7();
    var_b986bc82 = getentarray( "veh_wall_vignette", "script_noteworthy" );
    array::run_all( var_b986bc82, &util::stop_magic_bullet_shield );
    level.var_82e50b77 val::reset( "scene_sge_1010_apr_intro:2010_emp", "allowdeath" );
    level.var_82e50b77 util::stop_magic_bullet_shield();
    wait 1.75;
    var_b50c6c7 = spawner::get_ai_group_ai( "tower_group" );
    var_3ab4d4b2 = spawner::get_ai_group_ai( "tower_rpg_group" );
    array::thread_all( var_b50c6c7, &ai::shoot_at_target, "normal", level.var_82e50b77, undefined, 10, undefined, 1 );
    array::thread_all( var_3ab4d4b2, &ai::shoot_at_target, "normal", level.var_82e50b77, undefined, 10, undefined, 1 );
    s_rpg_origin = struct::get( "s_rpg_origin", "targetname" );
    s_rpg_target = struct::get( "s_rpg_target", "targetname" );
    magicbullet( getweapon( "launcher_standard_t9_cp_straight_shot_siege" ), s_rpg_origin.origin, s_rpg_target.origin );
    level flag::set( "flg_wall_rpg_magic_bullet" );
    level thread function_848b5c69();
    level waittill( #"flg_wall_crash" );
    snd::client_msg( "flg_audio_wall_crash" );
}

// Namespace namespace_b11c1856/namespace_b11c1856
// Params 0
// Checksum 0x143a9e28, Offset: 0x1e40
// Size: 0x4c
function function_848b5c69()
{
    wait 2;
    level.player dodamage( level.player.health - 1, ( 6943, -626, 66 ) );
}

// Namespace namespace_b11c1856/namespace_b11c1856
// Params 0
// Checksum 0x76dd650c, Offset: 0x1e98
// Size: 0x78
function function_86531f64()
{
    while ( level.player getnormalizedcameramovement()[ 0 ] == 0 && level.player getnormalizedcameramovement()[ 1 ] == 0 )
    {
        waitframe( 1 );
    }
    
    level notify( #"camera_movement" );
}

// Namespace namespace_b11c1856/namespace_b11c1856
// Params 4
// Checksum 0x53b69dd1, Offset: 0x1f18
// Size: 0x24
function cleanup( *str_objective, *var_50cc0d4f, *var_aa1a6455, *player )
{
    
}

// Namespace namespace_b11c1856/namespace_b11c1856
// Params 0
// Checksum 0xf4073ea2, Offset: 0x1f48
// Size: 0x124
function function_669e6733()
{
    level waittill( #"hash_39210373f249ed12" );
    s_origin = struct::get( "s_rpg_miss_origin" );
    s_target = struct::get( "s_rpg_miss_target" );
    magicbullet( getweapon( "launcher_standard_t9_cp_straight_shot_siege" ), s_origin.origin, s_target.origin );
    level waittill( #"hash_2fb4fdfd35dc601f" );
    s_origin = struct::get( "s_rpg_miss_2_origin" );
    s_target = struct::get( "s_rpg_miss_2_target" );
    magicbullet( getweapon( "launcher_standard_t9_cp_straight_shot_siege" ), s_origin.origin, s_target.origin );
}

// Namespace namespace_b11c1856/namespace_b11c1856
// Params 0
// Checksum 0x963b74e4, Offset: 0x2078
// Size: 0xe4
function function_cee4c961()
{
    level.var_26eb7ff5 = 0;
    level.var_b80457b0 = 0;
    var_5c6c150c = struct::get_array( "watch_tower_destruction", "targetname" );
    array::thread_all( var_5c6c150c, &function_5bf8b176 );
    var_9892ef20 = getentarray( "veh_town", "targetname" );
    var_9892ef20 = arraycombine( var_9892ef20, getentarray( "veh_guard_station", "targetname" ) );
    array::thread_all( var_9892ef20, &function_5bf8b176 );
}

// Namespace namespace_b11c1856/namespace_b11c1856
// Params 0
// Checksum 0xa710110e, Offset: 0x2168
// Size: 0x100
function function_5bf8b176()
{
    self endon( #"hash_6c7ae72dc5e27d35" );
    self waittill( #"death" );
    
    if ( gettime() < level.var_b80457b0 + 3000 )
    {
        return;
    }
    
    switch ( level.var_26eb7ff5 )
    {
        case 0:
            level.adler thread hms_util::dialogue( "vox_cp_seig_01100_adlr_nowwerecooking_2d" );
            break;
        case 1:
            level.adler thread hms_util::dialogue( "vox_cp_seig_01100_adlr_pouriton_c1" );
            break;
    }
    
    level.var_26eb7ff5++;
    level.var_b80457b0 = gettime();
    
    if ( level.var_26eb7ff5 >= 2 )
    {
        level.var_26eb7ff5 = 0;
    }
}

// Namespace namespace_b11c1856/namespace_b11c1856
// Params 0
// Checksum 0x8397619b, Offset: 0x2270
// Size: 0x3c
function function_575dfa11()
{
    level.var_50f33587 = 0;
    level.var_fd0e50a2 = 0;
    callback::on_vehicle_damage( &function_d4aec214 );
}

// Namespace namespace_b11c1856/namespace_b11c1856
// Params 1
// Checksum 0xc0f72512, Offset: 0x22b8
// Size: 0x1c0
function function_d4aec214( params )
{
    if ( params.eattacker !== level.player )
    {
        return;
    }
    
    var_a28063f4 = self === level.var_7b278a4f;
    var_e75e3cca = self === level.var_5d798cf2;
    var_9117ab6c = self === level.var_82e50b77;
    var_8d8229bf = isinarray( level.var_a1030c4e, self );
    
    if ( !( var_a28063f4 || var_e75e3cca || var_8d8229bf ) )
    {
        return;
    }
    
    if ( gettime() < level.var_fd0e50a2 + 3000 )
    {
        return;
    }
    
    switch ( level.var_50f33587 )
    {
        case 0:
            level.adler thread hms_util::dialogue( "vox_cp_seig_01100_adlr_watchyouraimbel_39" );
            break;
        case 1:
            level.adler thread hms_util::dialogue( "vox_cp_seig_01100_adlr_watchittheyreon_fa" );
            break;
        case 2:
            level.player thread hms_util::dialogue( "vox_cp_seig_01100_masn_watchfirewatchf_dc", 1 );
            break;
    }
    
    level.var_50f33587++;
    level.var_fd0e50a2 = gettime();
    
    if ( level.var_50f33587 >= 3 )
    {
        level.var_50f33587 = 0;
    }
}

// Namespace namespace_b11c1856/namespace_b11c1856
// Params 0
// Checksum 0xf8074872, Offset: 0x2480
// Size: 0x174
function function_f3c202c9()
{
    var_5c6c150c = struct::get_array( "watch_tower_destruction", "targetname" );
    
    foreach ( var_90946929 in var_5c6c150c )
    {
        var_90946929 notify( #"hash_6c7ae72dc5e27d35" );
    }
    
    var_9892ef20 = getentarray( "veh_town", "targetname" );
    
    foreach ( var_825d3987 in var_9892ef20 )
    {
        var_825d3987 notify( #"hash_6c7ae72dc5e27d35" );
    }
    
    callback::remove_on_vehicle_damage( &function_d4aec214 );
}

// Namespace namespace_b11c1856/namespace_b11c1856
// Params 0
// Checksum 0xbc69d4cb, Offset: 0x2600
// Size: 0xcc
function function_8d1484b7()
{
    var_3e3877e9 = spawner::get_ai_group_ai( "courtyard_allies" );
    array::thread_all( var_3e3877e9, &namespace_9e5ef376::function_489160a1 );
    level waittill( #"hash_465d6bb5960c37f8" );
    var_e9fc0486 = spawner::get_ai_group_ai( "courtyard_allies" );
    vol_goal = getent( "courtyard_redshirt_advance", "targetname" );
    array::run_all( var_e9fc0486, &setgoal, vol_goal );
}

// Namespace namespace_b11c1856/namespace_b11c1856
// Params 0
// Checksum 0x8292238, Offset: 0x26d8
// Size: 0xde
function function_e9849cb4()
{
    level flag::wait_till( "flg_emp_blast" );
    level endon( #"hash_1339dcac629a7afb" );
    s_waitresult = level.player waittilltimeout( 5, #"weapon_fired" );
    
    if ( s_waitresult._notify == "weapon_fired" )
    {
        return;
    }
    
    level.player util::show_hint_text( #"hash_4496122e436b7380", 0, "weapon_fired", 18 );
    s_waitresult = level.player waittilltimeout( 18, #"weapon_fired" );
}

// Namespace namespace_b11c1856/namespace_b11c1856
// Params 0
// Checksum 0x71f90789, Offset: 0x27c0
// Size: 0x7c
function function_993246a7()
{
    level flag::wait_till( "flg_emp_blast" );
    objectives::scripted( "obj_emp_mg", undefined, #"hash_1955f1a3c2418318", 1 );
    function_169b3fc8();
    objectives::remove( "obj_emp_mg" );
}

// Namespace namespace_b11c1856/namespace_b11c1856
// Params 0
// Checksum 0xd6311930, Offset: 0x2848
// Size: 0x78c
function function_169b3fc8()
{
    level thread function_34e2a831();
    level flag::wait_till( "flg_show_emp_mg_objective_markers_1" );
    var_fb90e03a = getentarray( "emp_mg_objective_1", "targetname" );
    f_distance = ( distance2d( level.player.origin, var_fb90e03a[ 0 ].origin ) + distance2d( level.player.origin, var_fb90e03a[ 1 ].origin ) ) / 2;
    var_ad9858d9 = f_distance * 0.11;
    var_fb90e03a[ 0 ].str_waypoint = var_fb90e03a[ 0 ] scripted_widgets::create_waypoint( "emp_mg_objective_1", var_fb90e03a[ 0 ], #"hash_18092df0dc808ce2", undefined, ( 0, 0, var_ad9858d9 ) );
    scripted_widgets::function_fdb73881( var_fb90e03a[ 0 ].str_waypoint, 0, 10000 );
    scripted_widgets::set_state( var_fb90e03a[ 0 ].str_waypoint, 1 );
    var_fb90e03a[ 0 ] thread function_b8df59d9();
    var_fb90e03a[ 1 ].str_waypoint = var_fb90e03a[ 1 ] scripted_widgets::create_waypoint( "emp_mg_objective_2", var_fb90e03a[ 1 ], #"hash_18092df0dc808ce2", undefined, ( 0, 0, var_ad9858d9 ) );
    scripted_widgets::function_fdb73881( var_fb90e03a[ 1 ].str_waypoint, 0, 10000 );
    scripted_widgets::set_state( var_fb90e03a[ 1 ].str_waypoint, 1 );
    var_fb90e03a[ 1 ] thread function_b8df59d9();
    level thread function_c0557b7a( var_fb90e03a[ 0 ], var_fb90e03a[ 1 ], "flg_show_emp_mg_objective_markers_2" );
    level flag::wait_till( "flg_show_emp_mg_objective_markers_2" );
    var_fb90e03a[ 0 ] notify( #"hash_690490dc48ae49b8" );
    var_fb90e03a[ 1 ] notify( #"hash_690490dc48ae49b8" );
    var_fb90e03a = getentarray( "emp_mg_objective_2", "targetname" );
    f_distance = ( distance2d( level.player.origin, var_fb90e03a[ 0 ].origin ) + distance2d( level.player.origin, var_fb90e03a[ 1 ].origin ) ) / 2;
    var_ad9858d9 = f_distance * 0.08;
    var_fb90e03a[ 0 ].str_waypoint = var_fb90e03a[ 0 ] scripted_widgets::create_waypoint( "emp_mg_objective_1", var_fb90e03a[ 0 ], #"hash_18092df0dc808ce2", undefined, ( 0, 0, var_ad9858d9 ) );
    scripted_widgets::function_fdb73881( var_fb90e03a[ 0 ].str_waypoint, 0, 10000 );
    scripted_widgets::set_state( var_fb90e03a[ 0 ].str_waypoint, 1 );
    var_fb90e03a[ 0 ] thread function_b8df59d9();
    var_fb90e03a[ 1 ].str_waypoint = var_fb90e03a[ 1 ] scripted_widgets::create_waypoint( "emp_mg_objective_2", var_fb90e03a[ 1 ], #"hash_18092df0dc808ce2", undefined, ( 0, 0, var_ad9858d9 ) );
    scripted_widgets::function_fdb73881( var_fb90e03a[ 1 ].str_waypoint, 0, 10000 );
    scripted_widgets::set_state( var_fb90e03a[ 1 ].str_waypoint, 1 );
    var_fb90e03a[ 1 ] thread function_b8df59d9();
    level thread function_c0557b7a( var_fb90e03a[ 0 ], var_fb90e03a[ 1 ], "flg_show_emp_mg_objective_markers_3" );
    level flag::wait_till( "flg_show_emp_mg_objective_markers_3" );
    var_fb90e03a[ 0 ] notify( #"hash_690490dc48ae49b8" );
    var_fb90e03a[ 1 ] notify( #"hash_690490dc48ae49b8" );
    var_fb90e03a = getentarray( "emp_mg_objective_3", "targetname" );
    f_distance = ( distance2d( level.player.origin, var_fb90e03a[ 0 ].origin ) + distance2d( level.player.origin, var_fb90e03a[ 1 ].origin ) ) / 2;
    var_ad9858d9 = f_distance * 0.11;
    var_fb90e03a[ 0 ].str_waypoint = var_fb90e03a[ 0 ] scripted_widgets::create_waypoint( "emp_mg_objective_1", var_fb90e03a[ 0 ], #"hash_18092df0dc808ce2", undefined, ( 0, 0, var_ad9858d9 ) );
    scripted_widgets::function_fdb73881( var_fb90e03a[ 0 ].str_waypoint, 0, 10000 );
    scripted_widgets::set_state( var_fb90e03a[ 0 ].str_waypoint, 1 );
    var_fb90e03a[ 0 ] thread function_b8df59d9();
    var_fb90e03a[ 1 ].str_waypoint = var_fb90e03a[ 1 ] scripted_widgets::create_waypoint( "emp_mg_objective_2", var_fb90e03a[ 1 ], #"hash_18092df0dc808ce2", undefined, ( 0, 0, var_ad9858d9 ) );
    scripted_widgets::function_fdb73881( var_fb90e03a[ 1 ].str_waypoint, 0, 10000 );
    scripted_widgets::set_state( var_fb90e03a[ 1 ].str_waypoint, 1 );
    var_fb90e03a[ 1 ] thread function_b8df59d9();
    level flag::wait_till( "flg_emp_mg_objective_complete" );
    var_fb90e03a[ 0 ] notify( #"hash_690490dc48ae49b8" );
    var_fb90e03a[ 1 ] notify( #"hash_690490dc48ae49b8" );
}

// Namespace namespace_b11c1856/namespace_b11c1856
// Params 0
// Checksum 0x6fe2196b, Offset: 0x2fe0
// Size: 0x8c
function function_34e2a831()
{
    wait 2;
    level flag::set( "flg_show_emp_mg_objective_markers_1" );
    wait 4;
    level flag::set( "flg_show_emp_mg_objective_markers_2" );
    wait 7;
    level flag::set( "flg_show_emp_mg_objective_markers_3" );
    wait 4.5;
    level flag::set( "flg_emp_mg_objective_complete" );
}

// Namespace namespace_b11c1856/namespace_b11c1856
// Params 0
// Checksum 0x7b321881, Offset: 0x3078
// Size: 0x42
function function_b8df59d9()
{
    self waittill( #"hash_690490dc48ae49b8" );
    scripted_widgets::remove( self.str_waypoint );
    self.var_5435d94 = 1;
}

// Namespace namespace_b11c1856/namespace_b11c1856
// Params 3
// Checksum 0x70cfc8ef, Offset: 0x30c8
// Size: 0x96
function function_c0557b7a( var_97009eaf, var_17151ed6, var_c5a3eca9 )
{
    level endon( var_c5a3eca9 );
    
    while ( true )
    {
        if ( is_true( var_97009eaf.var_5435d94 ) && is_true( var_17151ed6.var_5435d94 ) )
        {
            level flag::set( var_c5a3eca9 );
        }
        
        waitframe( 1 );
    }
}

