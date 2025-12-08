#using script_1351b3cdb6539f9b;
#using script_61fee52bb750ac99;
#using script_93de924cdc949f;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flashlight;
#using scripts\core_common\load_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\manager;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicleriders_shared;
#using scripts\cp\cp_nam_prisoner_fx;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\smart_bundle;
#using scripts\cp_common\util;

#namespace namespace_c6aa31df;

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 1
// Checksum 0xb1632780, Offset: 0x1a80
// Size: 0xc
function start( *str_objective )
{
    
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 2
// Checksum 0xfc29f9f3, Offset: 0x1a98
// Size: 0x104
function main( str_objective, var_50cc0d4f )
{
    if ( var_50cc0d4f )
    {
        level flag::wait_till( "level_intro_complete" );
    }
    
    level thread namespace_d9b153b9::function_179cab4a();
    var_c79d614f = "rice_paddies";
    
    if ( level.var_731c10af.paths[ var_c79d614f ].count != 1 )
    {
        level thread cp_nam_prisoner_fx::function_20aac67e();
    }
    
    level thread rice_paddies( str_objective );
    level flag::wait_till( var_c79d614f + "_complete" );
    savegame::function_379f84b3();
    skipto::function_4e3ab877( str_objective );
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 4
// Checksum 0x38629887, Offset: 0x1ba8
// Size: 0x24
function cleanup( *str_objective, *var_50cc0d4f, *var_aa1a6455, *player )
{
    
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 0
// Checksum 0x2ea1e7d6, Offset: 0x1bd8
// Size: 0x1f4
function function_c26b0bc0()
{
    level flag::init( "player_intro_anim_done" );
    level flag::init( "rice_paddies_weapon_one" );
    level flag::init( "rice_paddies_weapon_two" );
    level flag::init( "rice_paddies_allies_move_up_1" );
    level flag::init( "rice_paddies_allies_move_up_2" );
    level flag::init( "rice_paddies_one_enemy_dead" );
    level flag::init( "rice_paddies_enemies_dead" );
    level flag::init( "rice_paddies_complete" );
    level flag::init( "rice_paddies_v1_wave_4" );
    level flag::init( "flag_rice_paddies_enemies_retreat_5" );
    level flag::init( "flag_rice_paddies_enemies_at_hut_retreat" );
    level flag::init( "rice_paddies_final_retreat" );
    level flag::init( "rice_paddies_v4_kill_all_enemies" );
    level flag::init( "rice_paddies_stealth_fail" );
    spawner::add_spawn_function_group( "rice_paddies_v1_allies", "targetname", &function_4071af21 );
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 0
// Checksum 0xd82e9322, Offset: 0x1dd8
// Size: 0x2ea
function function_a08d5cab()
{
    level flag::clear( "rice_paddies_v1_initial_wave" );
    level flag::clear( "rice_paddies_allies_move_up_1" );
    level flag::clear( "rice_paddies_allies_move_up_2" );
    level flag::clear( "rice_paddies_v1_wave_1" );
    level flag::clear( "rice_paddies_v1_wave_2" );
    level flag::clear( "rice_paddies_v1_wave_3" );
    level flag::clear( "rice_paddies_v1_wave_4" );
    level flag::clear( "flag_rice_paddies_enemies_retreat_1" );
    level flag::clear( "flag_rice_paddies_enemies_retreat_2" );
    level flag::clear( "flag_rice_paddies_enemies_retreat_3" );
    level flag::clear( "flag_rice_paddies_enemies_retreat_4" );
    level flag::clear( "flag_rice_paddies_enemies_retreat_5" );
    level flag::clear( "rice_paddies_final_retreat" );
    level flag::clear( "rice_paddies_enemies_dead" );
    level flag::clear( "player_intro_anim_done" );
    level flag::clear( "flag_rice_paddies_end" );
    level flag::clear( "flag_rice_paddies_player_near_first_jump_down" );
    level flag::clear( "flag_adler_paddies_disappear" );
    level flag::clear( "rice_paddies_one_enemy_dead" );
    level flag::clear( "rice_paddies_complete" );
    level flag::clear( "flag_rice_paddies_ai_cleanup" );
    level.var_708ccf64 = undefined;
    level.var_86d6c2ab = undefined;
    level.var_e5b7895f = undefined;
    level.var_aa567810 = undefined;
    level.rice_paddies_v1_allies = undefined;
    level.var_6725979c = undefined;
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 1
// Checksum 0x9aaba3dc, Offset: 0x20d0
// Size: 0x7c
function rice_paddies( str_objective )
{
    level endon( #"start_outro" );
    
    if ( !isdefined( level.var_708ccf64 ) )
    {
        level thread function_61c7a808( str_objective );
    }
    
    level thread function_7f2bb3d3( str_objective );
    level thread function_695c1fb5();
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 0
// Checksum 0x35e7fc87, Offset: 0x2158
// Size: 0x3c
function function_695c1fb5()
{
    level flag::wait_till( "flag_rice_paddies_ai_cleanup" );
    level thread namespace_d9b153b9::function_5f3438c4();
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 1
// Checksum 0xe1d578f2, Offset: 0x21a0
// Size: 0xd9c
function function_61c7a808( str_objective )
{
    level.player endon( #"death" );
    level thread function_41380e1f();
    level flag::set( "flag_fx_exploder_start_rice_paddies" );
    level flag::set( "flag_fx_exploder_start_jungle_path" );
    
    if ( !isdefined( level.rice_paddies_intro_heli ) )
    {
        level.rice_paddies_intro_heli = getent( "rice_paddies_intro_heli", "targetname" );
    }
    
    if ( !isdefined( level.crashed_helicopter_2 ) )
    {
        level.crashed_helicopter_2 = getent( "crashed_helicopter_2", "targetname" );
        level.crashed_helicopter_2.org = spawn( "script_model", level.crashed_helicopter_2.origin );
        level.crashed_helicopter_2.org.origin = level.crashed_helicopter_2 gettagorigin( "tag_body_animate" );
        level.crashed_helicopter_2.org.angles = level.crashed_helicopter_2.angles;
    }
    
    level.crashed_helicopter_2.org thread scene::play( "scene_pri_paddies_lower_dead_pilot" );
    scene::add_scene_func( "scene_pri_intro_long", &function_cc5291ff );
    scene::add_scene_func( "scene_pri_intro_long_trailer", &function_cc5291ff );
    scene::add_scene_func( "scene_pri_intro_short_fastforward", &function_cc5291ff );
    scene::add_scene_func( "scene_pri_intro_short", &function_cc5291ff );
    
    if ( isdefined( level.var_731c10af.paths[ #"rice_paddies" ] ) && isdefined( level.var_731c10af.paths ) && isdefined( level.var_731c10af ) && isdefined( level.var_28c22d88 ) && ( array::contains( level.var_28c22d88, "rice_paddies_1" ) || array::contains( level.var_28c22d88, "dev_rice_paddies_1_all_districts" ) ) )
    {
        if ( level.var_731c10af.paths[ #"rice_paddies" ].count == 0 )
        {
            level flag::set( "player_intro_anim_done" );
            level flag::set( "rice_paddies_v1_initial_wave" );
            level thread scene::play( "scene_pri_intro_loop", array( level.rice_paddies_intro_heli ) );
            level thread scene::skipto_end( "scene_pri_paddies_heli_crash_dead", "Shot 1", undefined, 1, 0 );
            return;
        }
        else
        {
            level.player val::set( "teleport_controls", "freezecontrols" );
            level.player val::set( "teleport_weapons", "disable_weapons" );
            level.player val::set( "bunker_weapons", "disable_weapons" );
        }
    }
    
    if ( isdefined( level.var_708ccf64 ) )
    {
        level.player val::set( "teleport_controls", "freezecontrols", 1 );
        level.player val::set( "teleport_weapons", "disable_weapons", 1 );
        level flag::set( "rice_paddies_v1_sb_allies_flag_true" );
        rice_paddies_v1_sb_allies = smart_bundle::function_6c12ff6( "rice_paddies_v1_sb_allies" );
        
        while ( !isdefined( level.var_209e1b2d ) )
        {
            wait 0.05;
        }
        
        if ( isdefined( getdvar( #"hash_6ef95addde94da2c" ) ) && getdvar( #"hash_6ef95addde94da2c" ) != 0 )
        {
            level thread scene::init( "scene_pri_intro_long_trailer", level.var_209e1b2d );
            level thread scene::play( "scene_pri_intro_long_trailer", level.var_209e1b2d );
        }
        else
        {
            level thread scene::init( "scene_pri_intro_long", level.var_209e1b2d );
            level thread scene::play( "scene_pri_intro_long", level.var_209e1b2d );
        }
        
        level thread function_cb906385( "intro_long_magicbullet_start_struct", "intro_long_magicbullet_end_struct" );
        getplayers()[ 0 ] waittill( #"hash_46b49ecf80181c56" );
        level notify( #"hash_336c5048dcf6d064" );
        level thread function_cb906385( "intro_long_magicbullet_start_struct", "intro_long_magicbullet_end_2_struct" );
        level thread function_274673a1();
        getplayers()[ 0 ] waittill( #"hash_193b7066aa5e7141" );
        level notify( #"hash_518acb5c9f4114da" );
        level thread function_cb906385( "intro_long_magicbullet_start_struct", "intro_long_magicbullet_end_struct" );
        level thread scene::play( "scene_pri_intro_vc_attack" );
        scene::add_scene_func( "scene_pri_intro_vc_running", &function_f2d852cc );
        level thread scene::play( "scene_pri_intro_vc_running" );
        level thread util::delay( 0.8, undefined, &function_96e425c7, "intro_long_anim_magicgrenade3" );
        level thread util::delay( 1.2, undefined, &function_96e425c7, "intro_long_anim_magicgrenade1" );
        level thread util::delay( 2, undefined, &function_96e425c7, "intro_long_anim_magicgrenade2" );
        getplayers()[ 0 ] waittill( #"hash_5887ded86e911c44" );
        level thread function_cb906385( "intro_long_magicbullet_start_struct", "intro_long_magicbullet_end_2_struct" );
        getplayers()[ 0 ] waittill( #"player_on_ground" );
        level flag::set( "rice_paddies_v1_initial_wave" );
        level thread scene::stop( "scene_pri_intro_vc_attack" );
        level thread scene::stop( "scene_pri_intro_vc_running" );
        level scene::delete_scene_spawned_ents( "scene_pri_intro_vc_attack" );
        level scene::delete_scene_spawned_ents( "scene_pri_intro_vc_running" );
        level thread util::delay( 5, undefined, &function_96e425c7, "intro_long_anim_done_magicgrenade" );
        animation = "scene_pri_intro_long";
    }
    else
    {
        level flag::set( "flag_clear_teleport_fx" );
        
        if ( str_objective == "rice_paddies_4" )
        {
            level thread scene::play( "scene_pri_intro_short_fastforward" );
            animation = "scene_pri_intro_short_fastforward";
            level thread namespace_d9b153b9::function_1e281213( "model_jungle_lab2", 4, "flag_jungle_lab_rob2", "render_texture_switch", "flag_in_end_path" );
            level thread namespace_b6fe1dbe::function_6db13656();
        }
        else
        {
            level thread scene::play( "scene_pri_intro_short" );
            animation = "scene_pri_intro_short";
        }
        
        wait 0.05;
        
        if ( animation != "scene_pri_intro_short_fastforward" )
        {
            getplayers()[ 0 ] waittill( #"player_on_ground" );
            level flag::set( "rice_paddies_v1_initial_wave" );
        }
    }
    
    level thread scene::skipto_end( "scene_pri_paddies_heli_crash_dead", "Shot 1", undefined, 1, 0 );
    
    if ( animation != "scene_pri_intro_short_fastforward" )
    {
        while ( level.player scene::is_igc_active() )
        {
            waitframe( 1 );
        }
        
        namespace_d9b153b9::force_weapon_loadout( "rice_paddies", level.var_731c10af.paths[ #"rice_paddies" ].count );
    }
    else
    {
        wait 3;
        level flag::set( "rice_paddies_v1_initial_wave" );
    }
    
    level flag::set( "player_intro_anim_done" );
    level notify( #"hash_63c5f5f853b10253" );
    wait 0.25;
    
    if ( animation == "scene_pri_intro_short_fastforward" )
    {
        wait 5;
        level.player clientfield::set_to_player( "zipline_postfx", 1 );
        wait 2.25;
        level flag::set( "rice_paddies_v4_kill_all_enemies" );
        
        while ( level.player scene::is_igc_active() )
        {
            waitframe( 1 );
        }
        
        namespace_d9b153b9::force_weapon_loadout( "rice_paddies", level.var_731c10af.paths[ #"rice_paddies" ].count );
        level flag::set( "flag_rice_paddies_cleanup" );
        level flag::set( "rice_paddies_enemies_dead" );
        level.player clientfield::set_to_player( "zipline_postfx", 0 );
        level thread namespace_d9b153b9::function_5f3438c4();
    }
    
    level.player val::reset( "teleport_controls", "freezecontrols" );
    level.player val::reset( "teleport_weapons", "disable_weapons" );
    level.player val::reset( "bunker_weapons", "disable_weapons" );
    level thread savegame::checkpoint_save();
    level flag::wait_till( "flag_rice_paddies_cleanup" );
    level thread scene::stop( animation );
    level scene::delete_scene_spawned_ents( animation );
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 0
// Checksum 0x4be5e3c4, Offset: 0x2f48
// Size: 0x14c
function function_5e71243b()
{
    org = getent( "ally_drop_weapon_org", "targetname" );
    weapon = getent( org.linkname, "linkto" );
    
    if ( isdefined( weapon ) )
    {
        weapon hide();
    }
    
    level waittill( #"hash_43adf39eda87fda2" );
    org = getent( "ally_drop_weapon_org", "targetname" );
    org linkto( level.var_2d5aba86, "tag_weapon_right", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    level.var_2d5aba86 waittillmatch( { #notetrack:"hide_weapon" }, #"hash_6cc8280ad38cc4af" );
    
    if ( isdefined( weapon ) )
    {
        weapon show();
    }
    
    org unlink();
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 0
// Checksum 0xe5762d93, Offset: 0x30a0
// Size: 0x104
function function_274673a1()
{
    level.var_274673a1 = vehicle::simple_spawn_single( "rice_paddies_heli_flyby" );
    wait 0.05;
    level.var_274673a1 setrotorspeed( 1 );
    level.var_274673a1.ignoreme = 1;
    getplayers()[ 0 ] waittill( #"hash_193b7066aa5e7141" );
    var_ee768162 = spawner::simple_spawn( "rice_paddies_heli_flyby_riders", &function_2c05ec2d );
    nd_path = getvehiclenode( "intro_heli_flyby_start_path", "targetname" );
    level.var_274673a1 thread vehicle::get_on_and_go_path( nd_path );
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 0
// Checksum 0x3d67b501, Offset: 0x31b0
// Size: 0x6c
function function_2c05ec2d()
{
    if ( issubstr( self.script_startingposition, "gunner" ) )
    {
        self ai::gun_remove();
    }
    
    self.ignoreme = 1;
    self vehicle::get_in( self, level.var_274673a1, self.script_startingposition );
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 0
// Checksum 0x417f6e0c, Offset: 0x3228
// Size: 0x204
function function_41380e1f()
{
    if ( isdefined( level.var_708ccf64 ) )
    {
        level waittill( #"hash_4234a90c2b3e2d88" );
        level thread namespace_b6fe1dbe::music( "rice_paddies_start" );
        level flag::wait_till_any( array( "rice_paddies_final_retreat", "rice_paddies_enemies_dead", "flag_jungle_path" ) );
        level thread namespace_b6fe1dbe::music( "3.0_ruins_1" );
        return;
    }
    
    level waittill( #"hash_65cfe67d5232e08" );
    
    if ( isdefined( level.var_731c10af.var_42659717 ) && level.var_731c10af.var_42659717 == 1 )
    {
        level thread namespace_b6fe1dbe::music( "rice_paddies_part2_bow_start" );
        level flag::wait_till_any( array( "rice_paddies_enemies_dead", "flag_jungle_path" ) );
        level thread namespace_b6fe1dbe::music( "8.0_ruin_2" );
        return;
    }
    
    if ( isdefined( level.var_731c10af.var_42659717 ) && level.var_731c10af.var_42659717 == 2 )
    {
        level thread namespace_b6fe1dbe::music( "rice_paddies_part3_start" );
        level flag::wait_till_any( array( "rice_paddies_enemies_dead", "flag_jungle_path" ) );
        level thread namespace_b6fe1dbe::music( "rice_paddies_part3_end" );
    }
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 1
// Checksum 0xf53e5f45, Offset: 0x3438
// Size: 0xac
function function_96e425c7( struct_targetname )
{
    magicgrenade = struct::get( struct_targetname, "targetname" );
    tag_origin = util::spawn_model( "tag_origin", magicgrenade.origin, magicgrenade.angles );
    playfx( "explosions/fx8_exp_grenade_water", tag_origin.origin );
    tag_origin delete();
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 1
// Checksum 0x56d08ac4, Offset: 0x34f0
// Size: 0x1cc
function function_cc5291ff( a_ents )
{
    level.var_c90d21e1 = a_ents[ #"rice_paddies_intro_heli" ];
    level.var_6c3ab26f = a_ents[ #"hash_49b1db5963fdcbf5" ];
    level.var_b517b599 = a_ents[ #"hash_32bf1e4d7ae150d1" ];
    level.var_ebf4a352 = a_ents[ #"hash_32bf1b4d7ae14bb8" ];
    level.var_b918d422 = a_ents[ #"hash_68b1bc1b32394e13" ];
    level.var_2d5aba86 = a_ents[ #"hash_3a4fbd4603e2ae1d" ];
    level.var_80c622e = a_ents[ #"hash_3be12fabbc392116" ];
    
    if ( isdefined( level.var_80c622e ) )
    {
        if ( isdefined( level.var_80c622e._scene_object._o_scene._e_root.scriptbundlename ) && level.var_80c622e._scene_object._o_scene._e_root.scriptbundlename == hash( #"scene_pri_intro_long" ) )
        {
            if ( isdefined( level.var_80c622e.last_item.worldmodel ) )
            {
                level.var_80c622e detach( level.var_80c622e.last_item.worldmodel, "tag_weapon_right" );
            }
            
            level.var_80c622e attach( "wpn_t9_bp_ar_damage_world", "tag_weapon_right" );
        }
    }
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 1
// Checksum 0x3d1cb8ba, Offset: 0x36c8
// Size: 0x154
function function_f2d852cc( a_ents )
{
    level.var_f6c7fc3f = a_ents[ #"hash_7a46e96b3d1fd65c" ];
    level.var_e0f9d0a3 = a_ents[ #"hash_7a46ec6b3d1fdb75" ];
    level.var_d3383520 = a_ents[ #"hash_7a46eb6b3d1fd9c2" ];
    
    if ( isdefined( level.var_f6c7fc3f ) )
    {
        node = getnode( "vc_running_enemy1_node", "targetname" );
        level.var_f6c7fc3f thread ai::force_goal( node );
    }
    
    if ( isdefined( level.var_e0f9d0a3 ) )
    {
        node = getnode( "vc_running_enemy2_node", "targetname" );
        level.var_e0f9d0a3 thread ai::force_goal( node );
    }
    
    if ( isdefined( level.var_d3383520 ) )
    {
        node = getnode( "vc_running_enemy3_node", "targetname" );
        level.var_d3383520 thread ai::force_goal( node );
    }
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 3
// Checksum 0x5cca1877, Offset: 0x3828
// Size: 0x230
function function_cb906385( var_54f793c, var_aad0f074, *endon_flag )
{
    level notify( #"hash_63c5f5f853b10253" );
    level endon( #"hash_63c5f5f853b10253" );
    var_c45dc15a = struct::get_array( var_aad0f074, "targetname" );
    var_b35d0e54 = struct::get_array( endon_flag, "targetname" );
    
    while ( true )
    {
        random_start = array::random( var_c45dc15a );
        random_end = array::random( var_b35d0e54 );
        
        if ( math::cointoss() )
        {
            magicbullet( getweapon( #"hash_4ff481a4f55ed901" ), random_start.origin, random_end.origin );
        }
        else
        {
            magicbullet( getweapon( #"hash_4ff481a4f55ed901" ), random_start.origin, random_end.origin );
            wait 0.25;
            magicbullet( getweapon( #"hash_4ff481a4f55ed901" ), random_start.origin, random_end.origin );
            wait 0.25;
            magicbullet( getweapon( #"hash_4ff481a4f55ed901" ), random_start.origin, random_end.origin );
        }
        
        wait randomfloatrange( 0.5, 1.5 );
    }
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 1
// Checksum 0xcb9894a0, Offset: 0x3a60
// Size: 0x2a4
function function_7f2bb3d3( str_objective )
{
    level endon( #"visit_restart" );
    level endon( #"start_outro" );
    var_c79d614f = "rice_paddies";
    level.var_3f5c80c8 = "rice_paddies";
    
    if ( !level flag::get( "flag_" + var_c79d614f ) )
    {
        level flag::set( "flag_" + var_c79d614f );
    }
    
    level thread function_d1fa28d3( var_c79d614f );
    level thread rice_paddies_visit_2_nosight_noclip( var_c79d614f );
    level thread function_559733b4( var_c79d614f );
    level thread namespace_b6fe1dbe::function_8a5580af( var_c79d614f );
    
    if ( level.var_731c10af.paths[ var_c79d614f ].count == 0 )
    {
        level thread function_e3d37fd6();
    }
    else if ( level.var_731c10af.paths[ var_c79d614f ].count == 1 )
    {
        level thread function_9ade6ddd();
    }
    else if ( level.var_731c10af.paths[ var_c79d614f ].count == 2 )
    {
        level thread function_880ec83e();
    }
    else if ( level.var_731c10af.paths[ var_c79d614f ].count == 3 )
    {
        level thread function_acbe11ac();
    }
    
    level flag::wait_till_any( array( "rice_paddies_enemies_dead", "flag_jungle_path" ) );
    namespace_d9b153b9::function_e106e062( var_c79d614f );
    
    if ( str_objective == "rice_paddies_4" )
    {
        namespace_d9b153b9::function_e106e062( "jungle_path" );
    }
    
    level flag::set( var_c79d614f + "_complete" );
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 1
// Checksum 0x55bf45ec, Offset: 0x3d10
// Size: 0x408
function function_d1fa28d3( var_c79d614f )
{
    level endon( #"visit_restart" );
    level endon( #"start_outro" );
    
    while ( true )
    {
        level flag::wait_till( "flag_" + var_c79d614f );
        
        if ( isdefined( level.var_86d6c2ab ) )
        {
            level thread scene::play( "scene_pri_intro_loop" );
            level.crashed_helicopter_2.org thread scene::play( "scene_pri_paddies_lower_dead_pilot" );
            level thread scene::skipto_end( "scene_pri_paddies_heli_crash_dead", "Shot 1", undefined, 1, 0 );
        }
        
        exploder::exploder( "rice_paddies_heli_crash_1_tail" );
        
        while ( !isdefined( level.rice_paddies_intro_heli ) )
        {
            wait 0.05;
        }
        
        probe = getent( "rice_paddies_heli_1_probe", "targetname" );
        probe linkto( level.rice_paddies_intro_heli, "tag_body_animate", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        exploder::exploder( "rice_paddies_heli_crash_1_probe" );
        level.rice_paddies_intro_heli clientfield::set( "rice_paddies_heli_1_spark_fx", 1 );
        
        if ( level.var_731c10af.paths[ var_c79d614f ].count == 1 )
        {
            level thread namespace_b6fe1dbe::function_aa0b70f3();
            level flag::set( "rice_paddies_visit_2_sb_sm_flag_true" );
        }
        
        level flag::wait_till( "flag_rice_paddies_cleanup" );
        level flag::clear( "flag_" + var_c79d614f );
        level.var_86d6c2ab = 1;
        level thread scene::stop( "scene_pri_intro_loop" );
        level scene::delete_scene_spawned_ents( "scene_pri_intro_loop" );
        level.crashed_helicopter_2.org thread scene::stop( "scene_pri_paddies_lower_dead_pilot" );
        level scene::delete_scene_spawned_ents( "scene_pri_paddies_lower_dead_pilot" );
        level thread scene::stop( "scene_pri_paddies_heli_crash_dead" );
        level scene::delete_scene_spawned_ents( "scene_pri_paddies_heli_crash_dead" );
        exploder::exploder_stop( "rice_paddies_heli_crash_1_tail" );
        probe unlink();
        exploder::exploder_stop( "rice_paddies_heli_crash_1_probe" );
        level.rice_paddies_intro_heli clientfield::set( "rice_paddies_heli_1_spark_fx", 0 );
        
        if ( level.var_731c10af.paths[ var_c79d614f ].count == 1 )
        {
            level thread namespace_b6fe1dbe::function_ae63d294();
            level flag::clear( "rice_paddies_visit_2_sb_sm_flag_true" );
        }
    }
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 1
// Checksum 0x6749ff6, Offset: 0x4120
// Size: 0x8c8
function function_559733b4( var_c79d614f )
{
    level endon( #"visit_restart" );
    level endon( #"start_outro" );
    level endon( #"flag_jungle_path" );
    level.player endon( #"death" );
    level.var_3e64ba09 = 0;
    level thread function_e1c7c7b3();
    level thread function_cf110761();
    
    if ( level.var_731c10af.paths[ var_c79d614f ].count == 0 )
    {
        level thread function_f929c0db();
        
        if ( isdefined( level.var_708ccf64 ) )
        {
            level waittill( #"hash_336c5048dcf6d064" );
            dialogue::radio( "vox_cp_prsn_01000_adlr_thecrashsurvivo_13" );
        }
        else
        {
            wait 1;
        }
        
        level flag::wait_till( "rice_paddies_v1_initial_wave" );
        thread dialogue::radio( "vox_cp_prsn_01000_adlr_youranforwardan_8c" );
        level thread namespace_d9b153b9::function_f6cbf7fd( &function_3e64ba09, 5, 15, "flag_jungle_path" );
        level.weapon_count = 0;
        level.player callback::on_weapon_change( &function_379bceb2 );
        level flag::wait_till_any( array( "rice_paddies_weapon_one", "rice_paddies_weapon_two", "flag_rice_paddies_first_jump_down" ) );
        
        if ( flag::get( "rice_paddies_weapon_two" ) )
        {
            dialogue::radio( "vox_cp_prsn_01000_adlr_ormaybeitwasano_ea" );
        }
        else if ( !( level flag::get( "rice_paddies_weapon_one" ) && level flag::get( "rice_paddies_weapon_two" ) ) && flag::get( "flag_rice_paddies_first_jump_down" ) )
        {
            dialogue::radio( "vox_cp_prsn_01000_adlr_youwentinunarme_83" );
        }
        
        level flag::wait_till_any( array( "rice_paddies_final_retreat", "rice_paddies_enemies_dead", "flag_jungle_path" ) );
        
        if ( !flag::get( "rice_paddies_enemies_dead" ) && !flag::get( "flag_jungle_path" ) )
        {
            wait 2;
            
            if ( !flag::get( "rice_paddies_enemies_dead" ) && !flag::get( "flag_jungle_path" ) )
            {
                dialogue::radio( "vox_cp_prsn_01210_adlr_theremainingvcf_70" );
            }
        }
        
        level flag::wait_till_any( array( "flag_rice_paddies_enemies_not_in_volume", "rice_paddies_enemies_dead" ) );
        dialogue::radio( "vox_cp_prsn_01210_adlr_itwasthenyourea_46" );
        level notify( #"hash_5feb7f2a774573b8" );
        return;
    }
    
    if ( level.var_731c10af.paths[ var_c79d614f ].count == 1 )
    {
        wait 1.5;
        dialogue::radio( "vox_cp_prsn_04000_adlr_accordingtoyour_51" );
        level flag::wait_till( "player_intro_anim_done" );
        var_80613419 = getaiarray( "rice_paddies_v2_searching_upper_enemies", "script_parameters" );
        level thread function_61ff6bfe( var_80613419 );
        var_159f8e40 = getaiarray( "rice_paddies_v2_path_enemies", "script_parameters" );
        level thread function_a891f9d8( var_159f8e40 );
        level thread namespace_d9b153b9::function_f6cbf7fd( &function_3e64ba09, 1, 15, "flag_jungle_path" );
        dialogue::radio( "vox_cp_prsn_04000_adlr_youreadiedyourb_52" );
        level flag::wait_till_any( array( "rice_paddies_enemies_dead", "flag_rice_paddies_end" ) );
        
        if ( !level flag::get( "stealth_spotted" ) && !level flag::get( "rice_paddies_stealth_fail" ) && level flag::get( "rice_paddies_enemies_dead" ) )
        {
        }
        else if ( !level flag::get( "stealth_spotted" ) && !level flag::get( "rice_paddies_stealth_fail" ) )
        {
        }
        else if ( ( level flag::get( "stealth_spotted" ) || level flag::get( "rice_paddies_stealth_fail" ) ) && level flag::get( "rice_paddies_enemies_dead" ) )
        {
        }
        else if ( ( level flag::get( "stealth_spotted" ) || level flag::get( "rice_paddies_stealth_fail" ) ) && !level flag::get( "rice_paddies_enemies_dead" ) )
        {
        }
        
        if ( level flag::get( "stealth_spotted" ) || level flag::get( "rice_paddies_stealth_fail" ) && !level flag::get( "rice_paddies_enemies_dead" ) )
        {
        }
        
        return;
    }
    
    if ( level.var_731c10af.paths[ var_c79d614f ].count == 2 )
    {
        level thread function_f929c0db();
        wait 1.5;
        dialogue::radio( "vox_cp_prsn_07000_adlr_accordingtoyour_54" );
        dialogue::radio( "vox_cp_prsn_07000_adlr_thecrashsurvivo_13" );
        level flag::wait_till( "player_intro_anim_done" );
        level thread namespace_d9b153b9::function_f6cbf7fd( &function_3e64ba09, 1, 15, "flag_jungle_path" );
        dialogue::radio( "vox_cp_prsn_07000_adlr_youreadiedagren_96" );
        level flag::wait_till( "rice_paddies_enemies_dead" );
        
        if ( flag::get( "flag_rice_paddies_end" ) )
        {
        }
        
        return;
    }
    
    if ( level.var_731c10af.paths[ var_c79d614f ].count == 3 )
    {
        wait 1;
        wait 1;
        dialogue::radio( "vox_cp_prsn_11000_adlr_wevebeenoverthi_30" );
        wait 1;
        thread dialogue::radio( "vox_cp_prsn_11000_adlr_skipaheadtothen_f2" );
    }
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 1
// Checksum 0x285b22dd, Offset: 0x49f0
// Size: 0x2ac
function function_61ff6bfe( a_enemies )
{
    level endon( #"visit_restart" );
    level endon( #"start_outro" );
    level endon( #"flag_jungle_path" );
    level.player endon( #"death" );
    
    foreach ( enemy in a_enemies )
    {
        enemy endon( #"death" );
        enemy endon( #"set_alert_level" );
        enemy thread function_e960ab92();
    }
    
    while ( isdefined( a_enemies[ 0 ] ) && distancesquared( level.player.origin, a_enemies[ 0 ].origin ) > 490000 )
    {
        wait 0.1;
    }
    
    if ( !( isdefined( a_enemies[ 0 ] ) && isdefined( a_enemies[ 1 ] ) ) )
    {
        return;
    }
    
    a_enemies[ 0 ] dialogue::queue( "vox_cp_prsn_21000_vms1_hasanyoneseenan_5b" );
    
    if ( !( isdefined( a_enemies[ 0 ] ) && isdefined( a_enemies[ 1 ] ) ) )
    {
        return;
    }
    
    a_enemies[ 1 ] dialogue::queue( "vox_cp_prsn_21000_vms2_notthativeheard_b4" );
    
    if ( !( isdefined( a_enemies[ 0 ] ) && isdefined( a_enemies[ 1 ] ) ) )
    {
        return;
    }
    
    a_enemies[ 0 ] dialogue::queue( "vox_cp_prsn_21000_vms1_ithinktheressom_d3" );
    
    if ( !( isdefined( a_enemies[ 0 ] ) && isdefined( a_enemies[ 1 ] ) ) )
    {
        return;
    }
    
    a_enemies[ 1 ] dialogue::queue( "vox_cp_prsn_21000_vms2_letsmoveupthere_f2" );
    
    if ( !( isdefined( a_enemies[ 0 ] ) && isdefined( a_enemies[ 1 ] ) ) )
    {
        return;
    }
    
    a_enemies[ 0 ] dialogue::queue( "vox_cp_prsn_21000_vms1_allrightillgeta_08" );
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 1
// Checksum 0x910fb25b, Offset: 0x4ca8
// Size: 0x1a4
function function_a891f9d8( a_enemies )
{
    level.player endon( #"death" );
    
    foreach ( enemy in a_enemies )
    {
        enemy endon( #"death" );
        enemy endon( #"set_alert_level" );
        enemy thread function_e960ab92();
    }
    
    while ( isdefined( a_enemies[ 0 ] ) && distancesquared( level.player.origin, a_enemies[ 0 ].origin ) > 490000 )
    {
        wait 0.1;
    }
    
    if ( !( isdefined( a_enemies[ 0 ] ) && isdefined( a_enemies[ 1 ] ) ) )
    {
        return;
    }
    
    a_enemies[ 0 ] dialogue::queue( "vox_cp_prsn_21100_vms1_whereweretheame_ad" );
    
    if ( !( isdefined( a_enemies[ 0 ] ) && isdefined( a_enemies[ 1 ] ) ) )
    {
        return;
    }
    
    a_enemies[ 1 ] dialogue::queue( "vox_cp_prsn_21100_vms3_noideabutwellkn_fa" );
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 0
// Checksum 0x38f7c9f0, Offset: 0x4e58
// Size: 0x3c
function function_e960ab92()
{
    self waittill( #"death", #"set_alert_level" );
    self dialogue::function_47b06180();
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 0
// Checksum 0x4dd98b7, Offset: 0x4ea0
// Size: 0x1ec
function function_cf110761()
{
    level endon( #"visit_restart" );
    level endon( #"start_outro" );
    level endon( #"flag_rice_paddies_cleanup" );
    level.player endon( #"death" );
    
    if ( !level flag::get( "rice_paddies_enemies_dead" ) )
    {
        level flag::wait_till( "rice_paddies_enemies_dead" );
        wait 10;
    }
    
    level.player childthread namespace_d9b153b9::function_d683b544( &function_713ce2c4, level.rice_paddies_intro_heli.origin, undefined, 640000 );
    level.player childthread namespace_d9b153b9::function_d683b544( &function_aa05d455, level.crashed_helicopter_2.origin );
    struct_lookat_rice_paddies_vista = struct::get( "struct_lookat_rice_paddies_vista", "targetname" );
    level.player childthread namespace_d9b153b9::function_d683b544( &function_8cad26f4, struct_lookat_rice_paddies_vista.origin, undefined, 4000000 );
    struct_lookat_rice_paddies_hut = struct::get( "struct_lookat_rice_paddies_hut", "targetname" );
    level.player childthread namespace_d9b153b9::function_d683b544( &function_2821cb7e, struct_lookat_rice_paddies_hut.origin );
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 0
// Checksum 0xe656f034, Offset: 0x5098
// Size: 0x1c
function function_713ce2c4()
{
    dialogue::radio( "vox_cp_prsn_14000_adlr_yeahitwasquitea_25" );
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 0
// Checksum 0xcd5f1ed, Offset: 0x50c0
// Size: 0x1c
function function_aa05d455()
{
    dialogue::radio( "vox_cp_prsn_14000_adlr_dontworryaboutt_43" );
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 0
// Checksum 0x5adce58b, Offset: 0x50e8
// Size: 0x1c
function function_8cad26f4()
{
    dialogue::radio( "vox_cp_prsn_14000_adlr_bellwedontneedt_70" );
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 0
// Checksum 0x609dac4a, Offset: 0x5110
// Size: 0x1c
function function_2821cb7e()
{
    dialogue::radio( "vox_cp_prsn_14000_adlr_younevermention_12" );
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 0
// Checksum 0x3090302f, Offset: 0x5138
// Size: 0x134
function function_3e64ba09()
{
    level endon( #"flag_jungle_path" );
    level.var_3e64ba09++;
    
    if ( level.var_3e64ba09 == 1 )
    {
        dialogue::radio( "vox_cp_prsn_14000_adlr_soyoudidnothing_84" );
        level flag::wait_till( "rice_paddies_enemies_dead" );
        level thread namespace_d9b153b9::function_f6cbf7fd( &function_3e64ba09, 1, 15, "flag_jungle_path" );
    }
    
    if ( level.var_3e64ba09 == 2 )
    {
        dialogue::radio( "vox_cp_prsn_14000_adlr_wegetitbellever_dc" );
        level thread namespace_d9b153b9::function_f6cbf7fd( &function_3e64ba09, 1, 15, "flag_jungle_path" );
    }
    
    if ( level.var_3e64ba09 == 3 )
    {
        dialogue::radio( "vox_cp_prsn_14000_adlr_jesuschristbell_27" );
    }
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 0
// Checksum 0x62b39f50, Offset: 0x5278
// Size: 0x178
function function_e1c7c7b3()
{
    level endon( #"rice_paddies_enemies_dead" );
    level endon( #"flag_jungle_path" );
    level flag::wait_till( "player_intro_anim_done" );
    wait 3;
    
    if ( !isdefined( level.rice_paddies_v1_allies ) )
    {
        return;
    }
    
    vo_array = [];
    vo_array[ vo_array.size ] = "vox_cp_prsn_20100_ams1_werebeingoverru_05";
    vo_array[ vo_array.size ] = "vox_cp_prsn_20100_ams2_mylastclip_83";
    vo_array[ vo_array.size ] = "vox_cp_prsn_20100_ams3_imout_4a";
    vo_array[ vo_array.size ] = "vox_cp_prsn_20100_ams1_theyreadvancing_58";
    vo_array[ vo_array.size ] = "vox_cp_prsn_20100_ams2_mandownmandown_4a";
    vo_array[ vo_array.size ] = "vox_cp_prsn_20100_ams3_imhit_37";
    
    while ( level.rice_paddies_v1_allies.size > 0 )
    {
        ally = array::random( level.rice_paddies_v1_allies );
        vo = array::random( vo_array );
        
        if ( isdefined( ally ) )
        {
            ally dialogue::queue( vo );
        }
        
        wait randomintrange( 8, 14 );
    }
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 0
// Checksum 0xeb699b2e, Offset: 0x53f8
// Size: 0x64
function function_f929c0db()
{
    level endon( #"rice_paddies_enemies_dead" );
    level endon( #"rice_paddies_final_retreat" );
    level flag::wait_till( "flag_rice_paddies_end" );
    dialogue::radio( "vox_cp_prsn_14000_adlr_youjustranawayt_d3" );
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 1
// Checksum 0x5de01b1, Offset: 0x5468
// Size: 0x204
function function_379bceb2( params )
{
    level.player endon( #"death" );
    
    if ( !isdefined( params.weapon ) || !isweapon( params.weapon ) || !isdefined( self ) || !isplayer( self ) || params.weapon.name == #"hash_32454fc6213eedd6" )
    {
        return;
    }
    
    if ( isdefined( params.weapon ) )
    {
        level.player givemaxammo( params.weapon );
    }
    
    level.weapon_count++;
    
    if ( params.weapon.name == #"hash_4ff481a4f55ed901" )
    {
        level flag::set( "rice_paddies_weapon_one" );
    }
    else
    {
        level flag::set( "rice_paddies_weapon_two" );
    }
    
    weapon = getweapon( #"hash_32454fc6213eedd6" );
    
    if ( level.player hasweapon( weapon ) )
    {
        level.player takeweapon( weapon );
    }
    
    if ( isdefined( level.weapon_count ) && level.weapon_count == 2 )
    {
        level.player callback::remove_on_weapon_change( &function_379bceb2 );
    }
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 0
// Checksum 0xfa57298f, Offset: 0x5678
// Size: 0x5fc
function function_e3d37fd6()
{
    level endon( #"visit_restart" );
    level endon( #"start_outro" );
    
    if ( !flag::get( "rice_paddies_v1_sb_allies_flag_true" ) )
    {
        level flag::set( "rice_paddies_v1_sb_allies_flag_true" );
    }
    
    level flag::set( "rice_paddies_v1_sb_weapons_flag_true" );
    
    if ( isdefined( level.var_708ccf64 ) )
    {
        level thread function_1a0d3f6( array( "rice_paddies_intro_long_anim_enemy_smg", "rice_paddies_intro_long_anim_enemy_ar" ), "intro_long_anim_start_1" );
        level waittill( #"hash_518acb5c9f4114da" );
        ai_group = getaiarray( "rice_paddies_intro_long_anim_enemies", "script_aigroup" );
        
        foreach ( ai in ai_group )
        {
            if ( isdefined( ai ) )
            {
                ai delete();
            }
        }
        
        level thread function_5e71243b();
        level thread function_1a0d3f6( array( "rice_paddies_intro_long_anim_enemy_smg", "rice_paddies_intro_long_anim_enemy_ar" ), "intro_long_anim_start_1" );
    }
    
    level flag::wait_till( "rice_paddies_v1_initial_wave" );
    ai_group = getaiarray( "rice_paddies_intro_long_anim_enemies", "script_aigroup" );
    
    foreach ( ai in ai_group )
    {
        if ( isdefined( ai ) )
        {
            ai delete();
        }
    }
    
    spawner::add_spawn_function_group( "rice_paddies_v1_enemies_1", "targetname", &function_d529d45f );
    level flag::set( "rice_paddies_v1_sb1_flag_true" );
    level flag::delay_set( 5, "rice_paddies_v1_initial_wave_part_2" );
    rice_paddies_v1_sb1 = smart_bundle::function_6c12ff6( "rice_paddies_v1_sb1" );
    level thread function_e041c214( rice_paddies_v1_sb1 );
    level thread function_95d06832( rice_paddies_v1_sb1, 3 );
    level thread rice_paddies_enemies_dead( rice_paddies_v1_sb1 );
    rice_paddies_v1_sb1 thread smart_bundle::function_f059be95( "rice_paddies_one_enemy_dead", 1 );
    rice_paddies_v1_sb1 thread smart_bundle::function_f059be95( "rice_paddies_v1_wave_1", 2 );
    rice_paddies_v1_sb1 thread smart_bundle::function_f059be95( "rice_paddies_allies_move_up_2", 4 );
    rice_paddies_v1_sb1 thread smart_bundle::function_f059be95( "rice_paddies_v1_wave_2", 5 );
    rice_paddies_v1_sb1 thread smart_bundle::function_f059be95( "rice_paddies_allies_move_up_3", 6 );
    rice_paddies_v1_sb1 thread smart_bundle::function_f059be95( "rice_paddies_v1_wave_3", 7 );
    rice_paddies_v1_sb1 thread smart_bundle::function_f059be95( "rice_paddies_allies_move_up_4", 8 );
    rice_paddies_v1_sb1 thread smart_bundle::function_f059be95( "rice_paddies_allies_move_up_5", 10 );
    level flag::wait_till_any( array( "rice_paddies_v1_wave_1", "flag_rice_paddies_enemies_retreat_1" ) );
    
    if ( !flag::get( "rice_paddies_v1_wave_1" ) )
    {
        level flag::set( "rice_paddies_v1_wave_1" );
    }
    
    level flag::wait_till_any( array( "rice_paddies_v1_wave_2", "flag_rice_paddies_enemies_retreat_2" ) );
    
    if ( !flag::get( "rice_paddies_v1_wave_2" ) )
    {
        level flag::set( "rice_paddies_v1_wave_2" );
    }
    
    level flag::wait_till_any( array( "rice_paddies_v1_wave_3", "flag_rice_paddies_enemies_retreat_3" ) );
    
    if ( !flag::get( "rice_paddies_v1_wave_3" ) )
    {
        level flag::set( "rice_paddies_v1_wave_3" );
    }
    
    level flag::wait_till_any( array( "rice_paddies_v1_wave_4", "flag_rice_paddies_enemies_retreat_4" ) );
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 1
// Checksum 0x5d69b789, Offset: 0x5c80
// Size: 0x5c
function rice_paddies_enemies_dead( smart_bundle )
{
    if ( isdefined( smart_bundle ) && isdefined( smart_bundle.var_f0a4c650 ) )
    {
        var_268d3aa4 = smart_bundle.var_f0a4c650.size;
        smart_bundle thread smart_bundle::function_f059be95( "rice_paddies_enemies_dead", var_268d3aa4 );
    }
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 3
// Checksum 0x60f53127, Offset: 0x5ce8
// Size: 0x334
function function_1a0d3f6( var_b2a24c22, var_dcd97b9c, num_to_spawn )
{
    spawners = [];
    
    foreach ( var_fe90712e in var_b2a24c22 )
    {
        spawner_array = getspawnerarray( var_fe90712e, "targetname" );
        
        foreach ( spawner in spawner_array )
        {
            if ( !isdefined( spawners ) )
            {
                spawners = [];
            }
            else if ( !isarray( spawners ) )
            {
                spawners = array( spawners );
            }
            
            spawners[ spawners.size ] = spawner;
        }
    }
    
    var_8059f942 = struct::get_array( var_dcd97b9c, "targetname" );
    count = 0;
    
    foreach ( start in var_8059f942 )
    {
        if ( isdefined( num_to_spawn ) && count >= num_to_spawn )
        {
            return;
        }
        
        if ( isdefined( start.script_noteworthy ) )
        {
            foreach ( s in spawners )
            {
                if ( s.targetname == start.script_noteworthy )
                {
                    spawner = s;
                    break;
                }
            }
        }
        else
        {
            spawner = array::random( spawners );
        }
        
        spawner.origin = start.origin;
        spawner.angles = start.angles;
        spawner.target = start.target;
        spawner::simple_spawn_single( spawner );
        wait 0.05;
        count++;
    }
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 2
// Checksum 0x439eac3c, Offset: 0x6028
// Size: 0x126
function function_95d06832( smart_bundle, var_44dcf448 )
{
    level endon( #"visit_restart" );
    level endon( #"start_outro" );
    
    if ( isdefined( smart_bundle ) && isdefined( smart_bundle.var_f0a4c650 ) )
    {
        var_268d3aa4 = smart_bundle.var_f0a4c650.size - var_44dcf448;
        smart_bundle smart_bundle::function_f029622c( var_268d3aa4 );
        ai_array = smart_bundle smart_bundle::function_44cbaa85();
        
        foreach ( ai in ai_array )
        {
            ai.health = 1;
        }
    }
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 0
// Checksum 0xe4a60721, Offset: 0x6158
// Size: 0x474
function function_4071af21()
{
    self endon( #"death" );
    self.goalradius = 32;
    self.grenadeammo = 0;
    self.old_accuracy = self.script_accuracy;
    self.script_accuracy = 0.06;
    self.fixednode = 1;
    
    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "rice_paddies_ally_1" )
    {
        self.script_animname = "soldier_2";
        level.var_209e1b2d = self;
        self.ignoreme = 1;
    }
    
    if ( !isdefined( level.rice_paddies_v1_allies ) )
    {
        level.rice_paddies_v1_allies = [];
    }
    
    if ( !isdefined( level.rice_paddies_v1_allies ) )
    {
        level.rice_paddies_v1_allies = [];
    }
    else if ( !isarray( level.rice_paddies_v1_allies ) )
    {
        level.rice_paddies_v1_allies = array( level.rice_paddies_v1_allies );
    }
    
    level.rice_paddies_v1_allies[ level.rice_paddies_v1_allies.size ] = self;
    self callback::function_d8abfc3d( #"on_ai_killed", &function_8e61418 );
    self util::magic_bullet_shield();
    level flag::wait_till( "visit_start" );
    wait 1;
    level flag::wait_till( "player_intro_anim_done" );
    self thread function_d3cfa58d();
    wait 3;
    
    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "rice_paddies_ally_1" )
    {
        self.ignoreme = 0;
        self.goalradius = 64;
        self.grenadeammo = 0;
        self thread ai::force_goal( getnode( self.script_noteworthy + "_node", "targetname" ) );
        self.fixednode = 1;
    }
    
    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "rice_paddies_ally_4" )
    {
        wait 5;
        self thread function_2a48fb2d( 5 );
        return;
    }
    
    level flag::wait_till_any( array( "rice_paddies_v1_wave_1", "flag_rice_paddies_enemies_retreat_1" ) );
    
    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "rice_paddies_ally_3" )
    {
        self thread function_2a48fb2d( 10 );
        return;
    }
    
    level flag::wait_till_any( array( "rice_paddies_v1_wave_3", "flag_rice_paddies_enemies_retreat_3" ) );
    
    if ( !isdefined( level.var_e5b7895f ) )
    {
        if ( math::cointoss() )
        {
            level.var_e5b7895f = "rice_paddies_ally_1";
            level.var_aa567810 = "rice_paddies_ally_2";
        }
        else
        {
            level.var_e5b7895f = "rice_paddies_ally_2";
            level.var_aa567810 = "rice_paddies_ally_1";
        }
    }
    
    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == level.var_e5b7895f )
    {
        self thread function_2a48fb2d( 10 );
    }
    
    level flag::wait_till_any( array( "rice_paddies_v1_wave_4", "flag_rice_paddies_enemies_retreat_4" ) );
    
    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == level.var_aa567810 )
    {
        self thread function_2a48fb2d( 5 );
    }
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 0
// Checksum 0x8c46ed61, Offset: 0x65d8
// Size: 0x2fc
function function_d3cfa58d()
{
    self endon( #"death" );
    
    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "rice_paddies_allies_4" )
    {
        level flag::wait_till( "player_intro_anim_done" );
        
        if ( !level flag::get( "rice_paddies_allies_4_move_up" ) )
        {
            level flag::set( "rice_paddies_allies_4_move_up" );
        }
        
        return;
    }
    
    level flag::wait_till( "player_intro_anim_done" );
    level flag::wait_till_any( array( "flag_rice_paddies_player_near_first_jump_down", "rice_paddies_v1_wave_1" ) );
    
    if ( !level flag::get( "rice_paddies_allies_move_up_1" ) )
    {
        level flag::set( "rice_paddies_allies_move_up_1" );
    }
    
    level flag::wait_till_any( array( "flag_rice_paddies_enemies_retreat_1", "rice_paddies_v1_wave_2", "rice_paddies_allies_move_up_2" ) );
    
    if ( !level flag::get( "rice_paddies_allies_move_up_2" ) )
    {
        level flag::set( "rice_paddies_allies_move_up_2" );
    }
    
    level flag::wait_till_any( array( "flag_rice_paddies_enemies_retreat_2", "rice_paddies_v1_wave_3", "rice_paddies_allies_move_up_3" ) );
    
    if ( !level flag::get( "rice_paddies_allies_move_up_3" ) )
    {
        level flag::set( "rice_paddies_allies_move_up_3" );
    }
    
    level flag::wait_till_any( array( "flag_rice_paddies_enemies_retreat_3", "rice_paddies_v1_wave_4", "rice_paddies_allies_move_up_4" ) );
    
    if ( !level flag::get( "rice_paddies_allies_move_up_4" ) )
    {
        level flag::set( "rice_paddies_allies_move_up_4" );
    }
    
    level flag::wait_till_any( array( "flag_rice_paddies_enemies_retreat_4", "rice_paddies_allies_move_up_5" ) );
    
    if ( !level flag::get( "rice_paddies_allies_move_up_5" ) )
    {
        level flag::set( "rice_paddies_allies_move_up_5" );
    }
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 1
// Checksum 0x3e08eacc, Offset: 0x68e0
// Size: 0x25c
function function_2a48fb2d( time_to_wait )
{
    self endon( #"death" );
    level.player endon( #"death" );
    
    if ( isdefined( self.magic_bullet_shield ) )
    {
        self util::stop_magic_bullet_shield();
    }
    
    self.health = 1;
    count = 0;
    var_4d5ca023 = time_to_wait - 2;
    level waittilltimeout( var_4d5ca023, #"rice_paddies_final_retreat" );
    var_2b8c229c = var_4d5ca023 / 0.05;
    
    while ( !util::within_fov( level.player.origin, level.player.angles, self.origin + ( 0, 0, 64 ), cos( 70 ) ) && count < var_4d5ca023 && !level flag::get( "rice_paddies_final_retreat" ) )
    {
        wait 0.05;
        count++;
    }
    
    if ( !level flag::get( "rice_paddies_final_retreat" ) )
    {
        wait randomfloatrange( 0.1, 0.5 );
    }
    
    if ( isdefined( self.magic_bullet_shield ) )
    {
        self util::stop_magic_bullet_shield();
    }
    
    var_1c86e6cd = self gettagorigin( "j_head" );
    magicbullet( getweapon( #"hash_4ff481a4f55ed901" ), var_1c86e6cd + ( 0, 50, 0 ), var_1c86e6cd );
    wait 0.5;
    self kill();
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 0
// Checksum 0x5ee82531, Offset: 0x6b48
// Size: 0x13e
function function_d529d45f()
{
    self endon( #"death" );
    
    if ( !isdefined( level.var_6725979c ) )
    {
        level.var_6725979c = [];
    }
    
    if ( !isdefined( level.var_6725979c ) )
    {
        level.var_6725979c = [];
    }
    else if ( !isarray( level.var_6725979c ) )
    {
        level.var_6725979c = array( level.var_6725979c );
    }
    
    level.var_6725979c[ level.var_6725979c.size ] = self;
    self callback::function_d8abfc3d( #"on_ai_killed", &function_8e61418 );
    self.grenadeammo = 0;
    
    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "front_runner" )
    {
        self.ignoreme = 1;
        level flag::wait_till_timeout( 10, "flag_rice_paddies_enemies_retreat_1" );
        self.ignoreme = 0;
    }
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 1
// Checksum 0xe8a3859f, Offset: 0x6c90
// Size: 0x204
function function_8e61418( *str_notify )
{
    if ( isdefined( self ) && isdefined( level.var_6725979c ) && array::contains( level.var_6725979c, self ) )
    {
        arrayremovevalue( level.var_6725979c, self );
        wait 0.05;
        
        if ( level flag::get( "rice_paddies_v1_wave_3" ) || level flag::get( "rice_paddies_v2_sb1_flag_true" ) )
        {
            if ( level.var_6725979c.size <= 9 )
            {
                if ( !level flag::get( "flag_rice_paddies_enemies_retreat_5" ) )
                {
                    level flag::set( "flag_rice_paddies_enemies_retreat_5" );
                }
            }
            
            if ( level.var_6725979c.size <= 7 )
            {
                if ( !level flag::get( "flag_rice_paddies_enemies_at_hut_retreat" ) )
                {
                    level flag::set( "flag_rice_paddies_enemies_at_hut_retreat" );
                }
            }
            
            if ( level.var_6725979c.size <= 5 )
            {
                if ( !level flag::get( "rice_paddies_v1_wave_4" ) )
                {
                    level flag::set( "rice_paddies_v1_wave_4" );
                }
            }
        }
    }
    
    if ( isdefined( self ) && isdefined( level.rice_paddies_v1_allies ) && array::contains( level.rice_paddies_v1_allies, self ) )
    {
        arrayremovevalue( level.rice_paddies_v1_allies, self );
        wait 0.05;
    }
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 1
// Checksum 0xc4592476, Offset: 0x6ea0
// Size: 0x4e4
function function_e041c214( smart_bundle )
{
    level endon( #"visit_restart" );
    level endon( #"start_outro" );
    var_a4c09f1 = getent( "rice_paddies_front1_vol", "targetname" );
    var_61bbe946 = getent( "rice_paddies_front_vol", "targetname" );
    var_2af845e = getent( "rice_paddies_mid_vol", "targetname" );
    var_6cc537cb = getent( "rice_paddies_back_vol", "targetname" );
    var_1024bf40 = getent( "rice_paddies_back_left_vol", "targetname" );
    var_c2e05d84 = getent( "rice_paddies_back_right_vol", "targetname" );
    var_c4c70223 = getent( "rice_paddies_back1_vol", "targetname" );
    var_75422d3c = getent( "rice_paddies_hut_vol", "targetname" );
    
    if ( level.var_731c10af.paths[ #"rice_paddies" ].count == 3 )
    {
        var_61bbe946 = getent( "rice_paddies_v3_front_vol", "targetname" );
        var_2af845e = getent( "rice_paddies_v3_mid_vol", "targetname" );
        var_6cc537cb = getent( "rice_paddies_v3_back_vol", "targetname" );
    }
    else if ( level.var_731c10af.paths[ #"rice_paddies" ].count == 0 )
    {
        level thread util::delay( 6, "flag_rice_paddies_enemies_retreat_1", &function_95246a18, smart_bundle, var_a4c09f1, var_61bbe946, "flag_rice_paddies_enemies_retreat_1" );
        level thread util::delay( 6, "flag_rice_paddies_enemies_retreat_2", &function_95246a18, smart_bundle, var_61bbe946, var_2af845e, "flag_rice_paddies_enemies_retreat_2" );
        level thread util::delay( 6, "flag_rice_paddies_enemies_retreat_3", &function_95246a18, smart_bundle, var_2af845e, var_6cc537cb, "flag_rice_paddies_enemies_retreat_3" );
        level thread function_d79447e6( smart_bundle );
        level endon( #"rice_paddies_final_retreat" );
    }
    
    level flag::wait_till( "flag_rice_paddies_enemies_retreat_1" );
    level thread retreat_enemies( smart_bundle, var_a4c09f1, var_61bbe946, "flag_rice_paddies_enemies_retreat_2" );
    level flag::wait_till( "flag_rice_paddies_enemies_retreat_2" );
    level thread retreat_enemies( smart_bundle, var_61bbe946, var_2af845e, "flag_rice_paddies_enemies_retreat_3" );
    level flag::wait_till_any( array( "rice_paddies_v1_wave_3", "flag_rice_paddies_enemies_retreat_3" ) );
    
    if ( !level flag::get( "flag_rice_paddies_enemies_retreat_3" ) )
    {
        level flag::wait_till( "flag_rice_paddies_enemies_retreat_3" );
    }
    
    level thread retreat_enemies( smart_bundle, var_2af845e, var_6cc537cb, "flag_rice_paddies_enemies_retreat_5" );
    level flag::wait_till( "flag_rice_paddies_enemies_retreat_5" );
    level thread retreat_enemies( smart_bundle, var_6cc537cb, var_c4c70223, "rice_paddies_final_retreat" );
    level flag::wait_till( "flag_rice_paddies_enemies_at_hut_retreat" );
    level thread retreat_enemies( smart_bundle, var_75422d3c, var_c4c70223, "rice_paddies_final_retreat" );
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 1
// Checksum 0x9e3d9229, Offset: 0x7390
// Size: 0x168
function function_2e55ad19( smart_bundle )
{
    level endon( #"visit_restart" );
    level endon( #"start_outro" );
    level flag::wait_till( "rice_paddies_v1_wave_3" );
    wait 0.1;
    ai_array = smart_bundle smart_bundle::function_44cbaa85();
    var_c4c70223 = getent( "rice_paddies_back1_vol", "targetname" );
    
    foreach ( ai in ai_array )
    {
        if ( isdefined( ai ) )
        {
            ai notify( #"stop_going_to_node" );
            ai cleargoalvolume();
            ai.target = var_c4c70223.targetname;
            ai thread ai::force_goal( var_c4c70223 );
        }
    }
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 1
// Checksum 0x665ea6a0, Offset: 0x7500
// Size: 0x250
function function_d79447e6( smart_bundle )
{
    level endon( #"visit_restart" );
    level endon( #"start_outro" );
    level flag::wait_till( "rice_paddies_v1_wave_4" );
    level flag::set( "rice_paddies_final_retreat" );
    wait 0.1;
    ai_array = smart_bundle smart_bundle::function_44cbaa85();
    count = 0;
    rice_paddies_jungle_path_vol = getent( "rice_paddies_jungle_path_vol", "targetname" );
    
    foreach ( ai in ai_array )
    {
        if ( isdefined( ai ) )
        {
            if ( !isdefined( level.var_1e78aa8c ) )
            {
                level.var_1e78aa8c = 1;
                ai thread dialogue::queue( "vox_cp_prsn_20200_vms2_retreatretreat_31" );
            }
            
            ai notify( #"stop_going_to_node" );
            ai cleargoalvolume();
            ai.target = rice_paddies_jungle_path_vol.targetname;
            count++;
            
            if ( count < 4 )
            {
                ai.ignoreall = 1;
            }
            
            if ( isdefined( ai.ignoreall ) && ai.ignoreall == 1 )
            {
                ai thread ai::force_goal( rice_paddies_jungle_path_vol, 0 );
            }
            else
            {
                ai thread ai::force_goal( rice_paddies_jungle_path_vol, 1 );
            }
            
            ai thread function_7aec722b( rice_paddies_jungle_path_vol );
        }
    }
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 1
// Checksum 0x7dc0f56b, Offset: 0x7758
// Size: 0x27c
function function_7aec722b( volume )
{
    self endon( #"death" );
    self endon( #"deleted" );
    level.player endon( #"death" );
    waittime = randomintrange( 600, 800 );
    
    for ( count = 0; true ; count++ )
    {
        if ( self istouching( volume ) )
        {
            break;
        }
        
        if ( count >= waittime )
        {
            break;
        }
        
        if ( isdefined( self ) && isdefined( self.ignoreall ) && self.ignoreall == 1 )
        {
            if ( level flag::get( "flag_rice_paddies_enemies_not_in_volume" ) )
            {
                if ( distancesquared( level.player.origin, self.origin ) < 250000 )
                {
                    self.ignoreall = 0;
                }
            }
            else if ( distancesquared( level.player.origin, self.origin ) < 40000 )
            {
                self.ignoreall = 0;
            }
        }
        
        wait 0.05;
    }
    
    self.ignoreall = 0;
    
    if ( level.player function_80d68e4d( self, 0.7, 1 ) )
    {
        self delete();
        return;
    }
    
    while ( true )
    {
        if ( level.player function_80d68e4d( self, 0.7, 1 ) )
        {
            distance = distancesquared( level.player.origin, self.origin );
            max_distance = 490000;
            
            if ( distance > max_distance )
            {
                break;
            }
        }
        
        wait 0.05;
    }
    
    self kill();
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 4
// Checksum 0xbe7722ac, Offset: 0x79e0
// Size: 0x278
function retreat_enemies( smart_bundle, var_8a6ab185, var_cad6091, var_eb483a6d )
{
    level endon( #"rice_paddies_final_retreat" );
    
    if ( isdefined( var_eb483a6d ) )
    {
        if ( level flag::get( var_eb483a6d ) )
        {
            return;
        }
        
        level endon( var_eb483a6d );
    }
    
    wait 1;
    ai_array = smart_bundle smart_bundle::function_44cbaa85();
    
    foreach ( ai in ai_array )
    {
        if ( isdefined( var_8a6ab185 ) && isdefined( ai.target ) && isdefined( ai ) && isdefined( var_8a6ab185.targetname ) && ( ai.target == var_8a6ab185.targetname || ai istouching( var_8a6ab185 ) ) )
        {
            ai endon( #"death" );
            ai notify( #"stop_going_to_node" );
            ai cleargoalvolume();
            ai.target = var_cad6091.targetname;
            ai ai::set_goal( var_cad6091.targetname, "targetname", 1 );
            
            if ( math::cointoss() )
            {
                ai val::set( "rp_enemy_retreat", "ignoreall", 1 );
                waittime = randomfloatrange( 0.3, 1 );
                ai util::delay( waittime, "death", &val::reset, "rp_enemy_retreat", "ignoreall", 0 );
            }
        }
    }
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 4
// Checksum 0x7950ea0a, Offset: 0x7c60
// Size: 0x390
function function_95246a18( smart_bundle, var_8a6ab185, var_f298563d, endon_flag )
{
    level endon( #"rice_paddies_final_retreat" );
    level endon( #"rice_paddies_enemies_dead" );
    
    if ( isdefined( endon_flag ) )
    {
        if ( level flag::get( endon_flag ) )
        {
            return;
        }
        
        level endon( endon_flag );
    }
    
    var_49ff1a4d = [];
    
    while ( true )
    {
        ai_array = smart_bundle smart_bundle::function_44cbaa85();
        
        if ( !isdefined( ai_array ) || isdefined( ai_array ) && ai_array.size == 0 )
        {
            return;
        }
        
        count = 0;
        var_9997e80e = function_9997e80e( var_8a6ab185, ai_array );
        
        if ( var_9997e80e < 2 )
        {
            function_1eaaceab( var_49ff1a4d );
            
            foreach ( ai in ai_array )
            {
                if ( var_49ff1a4d.size == 0 )
                {
                    if ( isdefined( ai ) && ai istouching( var_f298563d ) )
                    {
                        if ( var_9997e80e == 0 )
                        {
                            var_83514f96 = 2;
                        }
                        else if ( var_9997e80e == 1 )
                        {
                            var_83514f96 = 1;
                        }
                        
                        if ( count < var_83514f96 )
                        {
                            ai notify( #"stop_going_to_node" );
                            ai cleargoalvolume();
                            ai.target = var_8a6ab185.targetname;
                            ai ai::set_goal( var_8a6ab185.targetname, "targetname", 1 );
                            
                            if ( !isdefined( var_49ff1a4d ) )
                            {
                                var_49ff1a4d = [];
                            }
                            else if ( !isarray( var_49ff1a4d ) )
                            {
                                var_49ff1a4d = array( var_49ff1a4d );
                            }
                            
                            if ( !isinarray( var_49ff1a4d, ai ) )
                            {
                                var_49ff1a4d[ var_49ff1a4d.size ] = ai;
                            }
                        }
                        
                        count++;
                    }
                    
                    continue;
                }
                
                if ( isdefined( ai.target ) && isdefined( ai ) && isdefined( var_49ff1a4d ) && array::contains( var_49ff1a4d, ai ) && ai.target == var_8a6ab185.targetname && ai istouching( var_8a6ab185 ) )
                {
                    arrayremovevalue( var_49ff1a4d, ai );
                }
            }
        }
        
        wait randomfloatrange( 0.5, 2 );
        wait 0.05;
    }
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 2
// Checksum 0x44a21f61, Offset: 0x7ff8
// Size: 0xde
function function_9997e80e( volume, ai_array )
{
    var_bb6d18e1 = 0;
    
    foreach ( ai in ai_array )
    {
        if ( isdefined( volume ) && isdefined( ai.target ) && isdefined( ai ) && isdefined( volume.targetname ) && ai.target == volume.targetname )
        {
            var_bb6d18e1++;
        }
    }
    
    return var_bb6d18e1;
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 0
// Checksum 0x1d9167ff, Offset: 0x80e0
// Size: 0x2c4
function function_9ade6ddd()
{
    level endon( #"visit_restart" );
    level endon( #"start_outro" );
    stealth_manager::set_default_settings( 1 );
    spawner::add_spawn_function_group( "rice_paddies_v2_enemies_1", "targetname", &function_385cd8e0 );
    level flag::set( "rice_paddies_v2_sb1_flag_true" );
    rice_paddies_v2_sb1 = smart_bundle::function_6c12ff6( "rice_paddies_v2_sb1" );
    rice_paddies_v2_sb1 smart_bundle::function_e47ac090();
    level thread rice_paddies_enemies_dead( rice_paddies_v2_sb1 );
    var_80613419 = getaiarray( "rice_paddies_v2_searching_upper_enemies", "script_parameters" );
    level thread scene::init( "scene_pri_vc_searching_upper", var_80613419 );
    var_42da502e = getaiarray( "rice_paddies_v2_searching_lower_enemies", "script_parameters" );
    level thread scene::init( "scene_pri_vc_searching_lower", var_42da502e );
    var_e6b79317 = getaiarray( "rice_paddies_v2_hut_deck_01_enemy", "script_parameters" );
    level thread scene::init( "scene_pri_paddies_hut_deck_01", var_e6b79317 );
    var_cc021601 = getaiarray( "rice_paddies_v2_hut_deck_02_enemy", "script_parameters" );
    level thread scene::init( "scene_pri_paddies_hut_deck_02", var_cc021601 );
    level thread function_a62b9a2();
    level thread function_d2971a8c( rice_paddies_v2_sb1 );
    wait 8;
    level thread scene::play( "scene_pri_vc_searching_upper", var_80613419 );
    level thread scene::play( "scene_pri_vc_searching_lower", var_42da502e );
    level thread scene::play( "scene_pri_paddies_hut_deck_01", var_e6b79317 );
    level thread scene::play( "scene_pri_paddies_hut_deck_02", var_cc021601 );
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 1
// Checksum 0x55f40481, Offset: 0x83b0
// Size: 0x288
function rice_paddies_visit_2_nosight_noclip( var_c79d614f )
{
    level flag::wait_till( "flag_" + var_c79d614f );
    wait 0.5;
    var_f3c3f9d2 = getentarray( "rice_paddies_visit_2_nosight_noclip", "targetname" );
    
    if ( !( isdefined( var_f3c3f9d2 ) && var_f3c3f9d2.size > 0 ) )
    {
        return;
    }
    
    foreach ( clip in var_f3c3f9d2 )
    {
        if ( isdefined( clip ) )
        {
            clip hide();
        }
    }
    
    if ( level.var_731c10af.paths[ var_c79d614f ].count == 1 )
    {
        level flag::wait_till( "rice_paddies_v2_sb1_flag_true" );
        
        foreach ( clip in var_f3c3f9d2 )
        {
            if ( isdefined( clip ) )
            {
                clip show();
            }
        }
        
        level flag::wait_till_any( array( "rice_paddies_stealth_fail", "visit_restart" ) );
    }
    
    foreach ( clip in var_f3c3f9d2 )
    {
        if ( isdefined( clip ) )
        {
            clip delete();
        }
    }
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 0
// Checksum 0xdacc7819, Offset: 0x8640
// Size: 0x1fc
function function_385cd8e0()
{
    self endon( #"death" );
    
    if ( !isdefined( level.var_6725979c ) )
    {
        level.var_6725979c = [];
    }
    
    if ( !isdefined( level.var_6725979c ) )
    {
        level.var_6725979c = [];
    }
    else if ( !isarray( level.var_6725979c ) )
    {
        level.var_6725979c = array( level.var_6725979c );
    }
    
    level.var_6725979c[ level.var_6725979c.size ] = self;
    self callback::function_d8abfc3d( #"on_ai_killed", &function_8e61418 );
    self.grenadeammo = 0;
    util::waittill_any_ents( self, "set_alert_level", level, "rice_paddies_stealth_fail" );
    
    if ( !level flag::get( "rice_paddies_stealth_fail" ) )
    {
        if ( ( isdefined( self.script_stealthgroup ) && self.script_stealthgroup == "rice_paddies_stealth_searching_upper" || self.script_stealthgroup == "rice_paddies_stealth_path" ) && isdefined( self.alertlevel ) && ( self.alertlevel == "noncombat" || self.alertlevel == "combat" ) )
        {
            self notify( #"stop_going_to_node" );
            self cleargoalvolume();
            self setgoal( self.origin, 1, 32 );
        }
    }
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 1, eflags: 0x4
// Checksum 0xf65ec396, Offset: 0x8848
// Size: 0x74
function private on_ai_damage( s_params )
{
    e_player = s_params.eattacker;
    w_melee = s_params.weapon;
    
    if ( !isplayer( e_player ) )
    {
        return;
    }
    
    if ( isdefined( self.magic_bullet_shield ) )
    {
        self util::stop_magic_bullet_shield();
    }
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 0
// Checksum 0xa843aec, Offset: 0x88c8
// Size: 0xa4
function function_a62b9a2()
{
    level endon( #"visit_restart" );
    level endon( #"start_outro" );
    
    while ( true )
    {
        level flag::wait_till( "stealth_spotted" );
        wait 3;
        
        if ( level flag::get( "stealth_spotted" ) )
        {
            level flag::set( "rice_paddies_stealth_fail" );
            break;
        }
        
        wait 0.05;
    }
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 1
// Checksum 0x68dd413b, Offset: 0x8978
// Size: 0x30c
function function_d2971a8c( smart_bundle )
{
    level endon( #"visit_restart" );
    level endon( #"start_outro" );
    level flag::wait_till( "rice_paddies_stealth_fail" );
    ai_array = smart_bundle smart_bundle::function_44cbaa85();
    
    foreach ( ai in ai_array )
    {
        if ( isdefined( ai.script_noteworthy ) )
        {
            if ( level flag::get( "flag_rice_paddies_enemies_retreat_2" ) )
            {
                if ( ai.script_noteworthy == "rice_paddies_front_vol" )
                {
                    ai.script_noteworthy = "rice_paddies_mid_vol";
                }
            }
            
            if ( level flag::get( "flag_rice_paddies_enemies_retreat_3" ) )
            {
                if ( ai.script_noteworthy == "rice_paddies_front_vol" || ai.script_noteworthy == "rice_paddies_mid_vol" )
                {
                    ai.script_noteworthy = "rice_paddies_back_vol";
                }
            }
            
            if ( level flag::get( "flag_rice_paddies_enemies_retreat_4" ) )
            {
                if ( ai.script_noteworthy == "rice_paddies_front_vol" || ai.script_noteworthy == "rice_paddies_mid_vol" )
                {
                    ai.script_noteworthy = "rice_paddies_back_vol";
                }
            }
            
            if ( level flag::get( "flag_rice_paddies_enemies_retreat_5" ) )
            {
                if ( ai.script_noteworthy == "rice_paddies_front_vol" || ai.script_noteworthy == "rice_paddies_mid_vol" || ai.script_noteworthy == "rice_paddies_back_vol" )
                {
                    ai.script_noteworthy = "rice_paddies_back1_vol";
                }
            }
            
            volume = getent( ai.script_noteworthy, "targetname" );
            ai notify( #"stop_going_to_node" );
            ai cleargoalvolume();
            ai.target = ai.script_noteworthy;
            ai ai::set_goal( volume.targetname, "targetname", 1 );
        }
    }
    
    level thread function_e041c214( smart_bundle );
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 0
// Checksum 0x423ba1ef, Offset: 0x8c90
// Size: 0x314
function function_880ec83e()
{
    level endon( #"visit_restart" );
    level endon( #"start_outro" );
    level thread function_5453a202();
    level flag::set( "rice_paddies_v1_sb_allies_flag_true" );
    spawner::add_spawn_function_group( "rice_paddies_v3_enemies_1", "targetname", &function_d529d45f );
    level flag::set( "rice_paddies_v3_sb1_flag_true" );
    rice_paddies_v3_sb1 = smart_bundle::function_6c12ff6( "rice_paddies_v3_sb1" );
    level thread rice_paddies_enemies_dead( rice_paddies_v3_sb1 );
    level thread function_e041c214( rice_paddies_v3_sb1 );
    rice_paddies_v3_sb1 thread smart_bundle::function_f059be95( "rice_paddies_v1_wave_1", 2 );
    level flag::wait_till_any( array( "rice_paddies_v1_wave_1", "flag_rice_paddies_enemies_retreat_1" ) );
    
    if ( !flag::get( "rice_paddies_v1_wave_1" ) )
    {
        level flag::set( "rice_paddies_v1_wave_1" );
    }
    
    rice_paddies_v3_sb1 thread smart_bundle::function_f059be95( "rice_paddies_allies_move_up_2", 4 );
    rice_paddies_v3_sb1 thread smart_bundle::function_f059be95( "rice_paddies_v1_wave_2", 5 );
    level flag::wait_till_any( array( "rice_paddies_v1_wave_2", "flag_rice_paddies_enemies_retreat_2" ) );
    
    if ( !flag::get( "rice_paddies_v1_wave_2" ) )
    {
        level flag::set( "rice_paddies_v1_wave_2" );
    }
    
    rice_paddies_v3_sb1 thread smart_bundle::function_f059be95( "rice_paddies_allies_move_up_3", 6 );
    rice_paddies_v3_sb1 thread smart_bundle::function_f059be95( "rice_paddies_v1_wave_3", 7 );
    level flag::wait_till_any( array( "rice_paddies_v1_wave_3", "flag_rice_paddies_enemies_retreat_3" ) );
    
    if ( !flag::get( "rice_paddies_v1_wave_3" ) )
    {
        level flag::set( "rice_paddies_v1_wave_3" );
    }
    
    level flag::wait_till_any( array( "rice_paddies_v1_wave_4", "flag_rice_paddies_enemies_retreat_4" ) );
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 0
// Checksum 0x2ebb523c, Offset: 0x8fb0
// Size: 0x74
function function_5453a202()
{
    level thread scene::play( "scene_pri_paddies_observe", "shot 1" );
    level flag::wait_till( "flag_adler_paddies_disappear" );
    level scene::play( "scene_pri_paddies_observe", "shot 2" );
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 0
// Checksum 0x6a105680, Offset: 0x9030
// Size: 0xf4
function function_b1953f7e()
{
    self endon( #"death" );
    level endon( #"rice_paddies_enemies_dead" );
    level endon( #"flag_jungle_path" );
    
    while ( true )
    {
        weapons = self getweaponslist();
        
        foreach ( weapon in weapons )
        {
            self givemaxammo( weapon );
        }
        
        wait 1.6;
    }
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 0
// Checksum 0xd3b234d2, Offset: 0x9130
// Size: 0x3cc
function function_acbe11ac()
{
    level endon( #"visit_restart" );
    level endon( #"start_outro" );
    level thread function_1a0d3f6( array( "rice_paddies_intro_long_anim_enemy_smg", "rice_paddies_intro_long_anim_enemy_ar" ), "intro_long_anim_start_1", 6 );
    level flag::wait_till( "rice_paddies_v1_initial_wave" );
    ai_group = getaiarray( "rice_paddies_intro_long_anim_enemies", "script_aigroup" );
    
    foreach ( ai in ai_group )
    {
        if ( isdefined( ai ) )
        {
            ai delete();
        }
    }
    
    level flag::set( "rice_paddies_v1_sb_allies_flag_true" );
    rice_paddies_v1_sb_allies = smart_bundle::function_6c12ff6( "rice_paddies_v1_sb_allies" );
    spawner::add_spawn_function_group( "rice_paddies_v4_enemies_1", "targetname", &function_41b4522 );
    level flag::set( "rice_paddies_v4_sb1_flag_true" );
    rice_paddies_v4_sb1 = smart_bundle::function_6c12ff6( "rice_paddies_v4_sb1" );
    wait 0.1;
    rice_paddies_v4_sb1 thread smart_bundle::function_f059be95( "rice_paddies_one_enemy_dead", 2 );
    level flag::wait_till( "rice_paddies_v4_kill_all_enemies" );
    enemy_array = rice_paddies_v4_sb1 smart_bundle::function_44cbaa85();
    ally_array = rice_paddies_v1_sb_allies smart_bundle::function_44cbaa85();
    ai_array = arraycombine( ally_array, enemy_array );
    
    foreach ( ai in ai_array )
    {
        if ( isdefined( ai ) )
        {
            ai.diequietly = 1;
            ai asmsetanimationrate( 0.4 );
            ai setentityanimrate( 0.4 );
            
            if ( isdefined( ai.magic_bullet_shield ) )
            {
                ai util::stop_magic_bullet_shield();
            }
            
            ai kill();
        }
    }
    
    level flag::wait_till( "flag_jungle_path_fork" );
    level flag::clear( "rice_paddies_v4_sb1_flag_true" );
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 0
// Checksum 0xc6d67eda, Offset: 0x9508
// Size: 0xe
function function_41b4522()
{
    self.grenadeammo = 0;
}

// Namespace namespace_c6aa31df/namespace_c6aa31df
// Params 1
// Checksum 0xc59a993a, Offset: 0x9520
// Size: 0x504
function function_c8f499c5( str_objective )
{
    wait 2;
    
    if ( str_objective == "rice_paddies_1" )
    {
        org = getent( "ally_drop_weapon_org", "targetname" );
        
        if ( isdefined( org ) )
        {
            weapon = getent( org.linkname, "linkto" );
            
            if ( isdefined( weapon ) )
            {
                weapon delete();
            }
            
            org delete();
        }
        
        level flag::clear( "rice_paddies_v1_initial_wave" );
        level flag::clear( "rice_paddies_v1_sb1_flag_true" );
        rice_paddies_v1_enemies_1 = getentarray( "rice_paddies_v1_enemies_1", "targetname" );
        array::thread_all( rice_paddies_v1_enemies_1, &namespace_d9b153b9::ent_cleanup );
        rice_paddies_heli_flyby = getentarray( "rice_paddies_heli_flyby", "targetname" );
        array::thread_all( rice_paddies_heli_flyby, &namespace_d9b153b9::ent_cleanup );
        rice_paddies_heli_flyby_riders = getentarray( "rice_paddies_heli_flyby_riders", "targetname" );
        array::thread_all( rice_paddies_heli_flyby_riders, &namespace_d9b153b9::ent_cleanup );
        
        if ( isdefined( level.player ) )
        {
            level.player callback::remove_on_weapon_change( &function_379bceb2 );
        }
        
        level flag::clear( "rice_paddies_v1_sb_weapons_flag_true" );
        rice_paddies_v1_sb_weapons = getentarray( "rice_paddies_v1_sb_weapons", "targetname" );
        
        if ( isdefined( rice_paddies_v1_sb_weapons ) )
        {
            array::thread_all( rice_paddies_v1_sb_weapons, &namespace_d9b153b9::ent_cleanup );
        }
    }
    
    if ( str_objective == "rice_paddies_2" )
    {
        level flag::clear( "rice_paddies_v2_sb1_flag_true" );
        rice_paddies_v2_enemies_1 = getentarray( "rice_paddies_v2_enemies_1", "targetname" );
        array::thread_all( rice_paddies_v2_enemies_1, &namespace_d9b153b9::ent_cleanup );
        rice_paddies_v2_volumes = getentarray( "rice_paddies_v2_volumes", "script_noteworthy" );
        array::thread_all( rice_paddies_v2_volumes, &namespace_d9b153b9::ent_cleanup );
        var_f3c3f9d2 = getentarray( "rice_paddies_visit_2_nosight_noclip", "targetname" );
        
        if ( isdefined( var_f3c3f9d2 ) )
        {
            array::thread_all( var_f3c3f9d2, &namespace_d9b153b9::ent_cleanup );
        }
    }
    
    if ( str_objective == "rice_paddies_3" )
    {
        level flag::clear( "rice_paddies_v3_sb1_flag_true" );
        rice_paddies_v3_enemies_1 = getentarray( "rice_paddies_v3_enemies_1", "targetname" );
        array::thread_all( rice_paddies_v3_enemies_1, &namespace_d9b153b9::ent_cleanup );
        rice_paddies_v3_volumes = getentarray( "rice_paddies_v3_volumes", "script_noteworthy" );
        array::thread_all( rice_paddies_v3_volumes, &namespace_d9b153b9::ent_cleanup );
    }
    
    if ( str_objective == "rice_paddies_4" )
    {
        level flag::clear( "rice_paddies_v4_sb1_flag_true" );
        rice_paddies_v4_enemies_1 = getentarray( "rice_paddies_v4_enemies_1", "targetname" );
        array::thread_all( rice_paddies_v4_enemies_1, &namespace_d9b153b9::ent_cleanup );
        rice_paddies_v4_volumes = getentarray( "rice_paddies_v4_volumes", "script_noteworthy" );
        array::thread_all( rice_paddies_v4_volumes, &namespace_d9b153b9::ent_cleanup );
    }
}

