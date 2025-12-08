#using script_237e957844a8197c;
#using script_7728aa611ab72ad9;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp_common\dialog_tree;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\spawn_manager;
#using scripts\cp_common\ui\prompts;
#using scripts\cp_common\util;
#using scripts\killstreaks\cp\ac130;
#using scripts\killstreaks\killstreaks_shared;

#namespace namespace_379d0dc2;

// Namespace namespace_379d0dc2/namespace_379d0dc2
// Params 1
// Checksum 0x6d3dcdb6, Offset: 0xde8
// Size: 0x1cc
function start( *str_objective )
{
    level hms_util::function_ee1d1df6( "park", "Park", "park_rooftop_struct" );
    level hms_util::function_ee1d1df6( "lazar", "Lazar", "lazar_rooftop_struct" );
    level.park.ignoreall = 0;
    level.park.script_accuracy = 0.5;
    level.park colors::disable();
    park_exfil_node = getnode( "rooftop_redshirt_1_node", "targetname" );
    level.park setgoal( park_exfil_node );
    level.lazar.ignoreall = 0;
    level.lazar.script_accuracy = 0.5;
    level.lazar colors::disable();
    var_cb77324d = getnode( "rooftop_lazar_node", "targetname" );
    level.lazar setgoal( var_cb77324d );
    level flag::set( "flg_turn_on_rooftop_kill_volume" );
    level thread namespace_a789f8ae::function_ba3f106b( "exfil" );
}

// Namespace namespace_379d0dc2/namespace_379d0dc2
// Params 2
// Checksum 0x4dbc99e1, Offset: 0xfc0
// Size: 0xaf0
function main( *str_objective, *var_50cc0d4f )
{
    /#
        hms_util::print( "<dev string:x38>" );
    #/
    
    hms_util::function_eaa0342e( "rooftop_containment_warnings", "rooftop_containment_fails" );
    savegame::checkpoint_save();
    level thread function_5a5ce08a();
    level.park.script_accuracy = 0.5;
    level.lazar.script_accuracy = 0.5;
    var_93e04a30 = spawner::simple_spawn_single( "rooftop_defend_wave_3_1_rpg_1", &function_d210173f, "exfil_rpg_inital_pos_1", "exfil_rpg_target_1" );
    wait randomfloatrange( 0.5, 1 );
    var_ed087c7f = spawner::simple_spawn_single( "rooftop_defend_wave_3_1_rpg_2", &function_d210173f, "exfil_rpg_inital_pos_2", "exfil_rpg_target_2" );
    wait randomfloatrange( 0.5, 1 );
    var_b7b711dd = spawner::simple_spawn_single( "rooftop_defend_wave_3_1_rpg_3", &function_d210173f, "exfil_rpg_inital_pos_3", "exfil_rpg_target_3" );
    var_bf311605 = array( var_93e04a30, var_ed087c7f, var_b7b711dd );
    wait 5;
    level flag::wait_till( "flg_rpg_volly_done" );
    park_exfil_node = getnode( "rooftop_redshirt_1_node", "targetname" );
    level.park setgoal( park_exfil_node );
    wait randomfloatrange( 1, 2 );
    var_db9245a6 = spawner::simple_spawn( "rooftop_defend_wave_3_2" );
    wait randomfloatrange( 1, 2 );
    var_b3e00a8c = spawner::simple_spawn( "rooftop_defend_wave_3_3" );
    var_b9943a82 = spawner::simple_spawn( "rooftop_defend_wave_2_2" );
    wait randomfloatrange( 1, 1.5 );
    var_9bc52185 = spawner::simple_spawn( "rooftop_defend_wave_2_3" );
    var_b9290093 = arraycombine( var_bf311605, var_db9245a6 );
    var_b9290093 = arraycombine( var_b9290093, var_b3e00a8c );
    var_b9290093 = arraycombine( var_b9290093, var_b9943a82 );
    var_b9290093 = arraycombine( var_b9290093, var_9bc52185 );
    
    foreach ( guy in var_b9290093 )
    {
        if ( isalive( guy ) )
        {
            guy.script_accuracy = 0.1;
        }
    }
    
    wait 2;
    level flag::set( "flg_ac130_ready" );
    var_12ca8919 = spawner::simple_spawn( "rooftop_defend_mortar_fodder_1" );
    var_45146dac = spawner::simple_spawn( "rooftop_defend_mortar_fodder_2" );
    var_e18ea69e = spawner::simple_spawn( "rooftop_defend_mortar_fodder_3" );
    var_bc5fb0c = spawner::simple_spawn( "rooftop_defend_mortar_fodder_4" );
    var_b9290093 = arraycombine( var_b9290093, var_12ca8919 );
    var_b9290093 = arraycombine( var_b9290093, var_45146dac );
    var_b9290093 = arraycombine( var_b9290093, var_e18ea69e );
    var_b9290093 = arraycombine( var_b9290093, var_bc5fb0c );
    level thread function_4df2f981();
    level flag::wait_till( "flg_give_ac130_prompt" );
    level.player.ignoreme = 1;
    level flag::set( "flg_mortar_ready" );
    level.player thread function_29758311();
    wait 6;
    level thread function_ac6f37f4();
    level.player.ignoreme = 0;
    level flag::wait_till( "flg_ac130_active" );
    var_bd8e9ff7 = getent( "rooftop_damage_trigger_1", "targetname" );
    var_49fe9e2a = struct::get( "ac130_damage_fx_1", "targetname" );
    var_cab83a4a = getent( "rooftop_damage_trigger_2", "targetname" );
    var_5c45c2b8 = struct::get( "ac130_damage_fx_2", "targetname" );
    var_18ffd6d8 = getent( "rooftop_damage_trigger_3", "targetname" );
    var_a34ad0c5 = struct::get( "ac130_damage_fx_3", "targetname" );
    var_cb6b3b9c = getent( "rooftop_damage_trigger_4", "targetname" );
    var_588a3b41 = struct::get( "ac130_damage_fx_4", "targetname" );
    var_1922d70a = getent( "rooftop_damage_trigger_5", "targetname" );
    var_30f16c10 = struct::get( "ac130_damage_fx_5", "targetname" );
    level thread function_501002d8( var_bd8e9ff7, var_49fe9e2a );
    level thread function_501002d8( var_cab83a4a, var_5c45c2b8 );
    level thread function_501002d8( var_18ffd6d8, var_a34ad0c5 );
    level thread function_501002d8( var_cb6b3b9c, var_588a3b41 );
    level thread function_501002d8( var_1922d70a, var_30f16c10 );
    var_f03e70e7 = spawner::simple_spawn( "ac13_drone_rooftop_runners" );
    wait 6;
    
    foreach ( guy in var_b9290093 )
    {
        if ( isdefined( guy ) && isalive( guy ) )
        {
            guy thread function_4abb5b73();
        }
    }
    
    level flag::wait_till( "flg_ac130_done" );
    savegame::checkpoint_save();
    scene::add_scene_func( "scene_rev_5050_rtp_extract", &function_e6e98d21, "choice_loop" );
    level thread namespace_a789f8ae::function_fe8c8150();
    level flag::wait_till_all( array( #"flg_park_skyhook_ready", #"flg_lazar_skyhook_ready" ) );
    level thread function_fd1be627();
    level flag::wait_till( "flg_skyhook_ready" );
    level thread function_ac6f37f4();
    level flag::wait_till_any( array( "flg_no_choice", "flg_choice_made" ) );
    wait 8;
    var_10489ce6 = spawner::simple_spawn( "exfil_ally_killers" );
    
    foreach ( guy in var_10489ce6 )
    {
        guy thread ai::shoot_at_target( "normal", getent( "exfil_killers_shoot_at_skyhook", "targetname" ), "tag_origin", 10, 100, 1 );
    }
}

// Namespace namespace_379d0dc2/namespace_379d0dc2
// Params 0
// Checksum 0xf66ae1d4, Offset: 0x1ab8
// Size: 0x9c
function function_4abb5b73()
{
    self endon( #"death" );
    vol_fallback = getent( "a_wave_catch_all_enemies_fallback", "targetname" );
    self setgoal( vol_fallback );
    self waittill( #"goal" );
    
    if ( isalive( self ) )
    {
        self deletedelay();
    }
}

// Namespace namespace_379d0dc2/namespace_379d0dc2
// Params 2
// Checksum 0xeeef088c, Offset: 0x1b60
// Size: 0x154
function function_d210173f( var_3c97f36d, var_5442a320 )
{
    self endon( #"death" );
    self val::set( #"hash_722c2bad015d62bc", "ignoreall", 1 );
    self spawner::go_to_struct( struct::get( var_3c97f36d, "targetname" ) );
    self waittill( #"goal" );
    self thread ai::shoot_at_target( "normal", getent( var_5442a320, "targetname" ), "tag_origin", 10, 100, 1 );
    self waittill( #"shoot" );
    self ai::stop_shoot_at_target();
    self val::set( #"hash_722c2bad015d62bc", "ignoreall", 0 );
    level flag::set( "flg_rpg_volly_done" );
}

// Namespace namespace_379d0dc2/namespace_379d0dc2
// Params 1
// Checksum 0xfcffa620, Offset: 0x1cc0
// Size: 0x2c
function function_5f668630( *a_ents )
{
    level flag::set( #"flg_park_skyhook_ready" );
}

// Namespace namespace_379d0dc2/namespace_379d0dc2
// Params 1
// Checksum 0xfa171b67, Offset: 0x1cf8
// Size: 0x2c
function function_8e61cf6d( *a_ents )
{
    level flag::set( #"flg_lazar_skyhook_ready" );
}

// Namespace namespace_379d0dc2/namespace_379d0dc2
// Params 0
// Checksum 0xc8137533, Offset: 0x1d30
// Size: 0x1dc
function function_fd1be627()
{
    var_3f8b5025 = struct::get( "s_obj_exfil", "targetname" );
    objectives::goto( "obj_skyhook", var_3f8b5025.origin, #"hash_1434d5e6bc8057d2" );
    var_37827744 = struct::get( "skyhook_interact_org", "targetname" );
    var_490deb68 = util::spawn_model( "tag_origin", var_37827744.origin, var_37827744.angles );
    var_490deb68 util::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), #"hash_1a19c2c28f3d349d", 150, undefined, undefined, undefined, 500 );
    var_490deb68.var_99aeff0 = getent( "skyhook_valid_volume", "targetname" );
    var_490deb68 prompts::function_a4a9acfc( #"use", &function_f60e249b );
    level flag::set( "flg_skyhook_ready" );
    var_490deb68 waittill( #"trigger" );
    level flag::set( "flg_skyhook_interacted" );
    level.player thread function_d564f5b8();
    level namespace_a789f8ae::function_23334bfb();
}

// Namespace namespace_379d0dc2/namespace_379d0dc2
// Params 0
// Checksum 0x5d0b9ec5, Offset: 0x1f18
// Size: 0xf4
function function_d564f5b8()
{
    self endon( #"death" );
    var_9c77c444 = struct::get( "smoke_fx_org", "targetname" );
    self waittill( #"hash_bf5bfd22f483570" );
    effect = getstatuseffect( "blurred" );
    self status_effect::status_effect_apply( effect, getweapon( #"launcher_standard_t9" ), self, undefined, 5000 );
    playfx( level._effect[ #"hash_7527861319d5e820" ], var_9c77c444.origin );
}

// Namespace namespace_379d0dc2/namespace_379d0dc2
// Params 0
// Checksum 0x4a1c6ec5, Offset: 0x2018
// Size: 0x258
function function_37158954()
{
    level endon( #"exfil_done" );
    level.player waittill( #"hash_bf5bfd22f483570" );
    s_magicbullet_source_1 = struct::get( "s_magicbullet_source_1", "targetname" );
    s_magicbullet_target_1 = struct::get( "s_magicbullet_target_1", "targetname" );
    s_magicbullet_source_2 = struct::get( "s_magicbullet_source_2", "targetname" );
    s_magicbullet_target_2 = struct::get( "s_magicbullet_target_2", "targetname" );
    s_magicbullet_source_3 = struct::get( "s_magicbullet_source_3", "targetname" );
    s_magicbullet_target_3 = struct::get( "s_magicbullet_target_3", "targetname" );
    s_magicbullet_source_4 = struct::get( "s_magicbullet_source_4", "targetname" );
    s_magicbullet_target_4 = struct::get( "s_magicbullet_target_4", "targetname" );
    var_a7167363 = getweapon( #"ar_accurate_t9" );
    
    while ( true )
    {
        magicbullet( var_a7167363, s_magicbullet_source_1.origin, s_magicbullet_target_1.origin );
        magicbullet( var_a7167363, s_magicbullet_source_2.origin, s_magicbullet_target_2.origin );
        magicbullet( var_a7167363, s_magicbullet_source_3.origin, s_magicbullet_target_3.origin );
        magicbullet( var_a7167363, s_magicbullet_source_4.origin, s_magicbullet_target_4.origin );
        wait 0.2;
    }
}

// Namespace namespace_379d0dc2/namespace_379d0dc2
// Params 1
// Checksum 0xe50f837a, Offset: 0x2278
// Size: 0x2a
function function_f60e249b( s_info )
{
    return s_info.player istouching( self.var_99aeff0 );
}

// Namespace namespace_379d0dc2/namespace_379d0dc2
// Params 0
// Checksum 0xcd579f05, Offset: 0x22b0
// Size: 0x314
function function_5a5ce08a()
{
    level endon( #"death" );
    level endon( #"flg_choice_made" );
    var_106f184b = struct::get( "pilot_dialogue_exfil", "targetname" );
    var_7cb820ce = struct::get( "ai_mason_radio", "targetname" );
    level.lazar hms_util::dialogue( "vox_cp_cbcr_01900_lazr_imgettinglowona_74", undefined, "allies", "Lazar" );
    level.park hms_util::dialogue( "vox_cp_cbcr_01900_park_oneminutestayfo_33", undefined, "allies", "Park" );
    level.park hms_util::dialogue( "vox_cp_cbcr_01900_park_tellyouwhatwhen_7b", undefined, "allies", "Park" );
    level.lazar hms_util::dialogue( "vox_cp_cbcr_01900_lazr_nowthatssomethi_d9", undefined, "allies", "Lazar" );
    level flag::wait_till( "flg_ac130_ready" );
    var_106f184b hms_util::dialogue( "vox_cp_cbcr_02400_pilo_groundteamthisi_3b", 1, "allies", "Pilot" );
    level.park hms_util::dialogue( "vox_cp_cbcr_02400_park_thatwouldbemuch_87", undefined, "allies", "Park" );
    var_106f184b thread hms_util::dialogue( "vox_cp_cbcr_02400_pilo_rogerthathelpis_a0", 1, "allies", "Pilot" );
    level flag::set( "flg_give_ac130_prompt" );
    level flag::wait_till( "flg_ac130_active" );
    level.park hms_util::dialogue( "vox_cp_cbcr_02400_park_groundteamtosky_03", 1, "allies", "Park" );
    var_106f184b hms_util::dialogue( "vox_cp_cbcr_02400_pilo_rogerthatcleari_1c", 1, "allies", "Pilot" );
    level flag::wait_till( "flg_ac130_done" );
    level.lazar hms_util::dialogue( "vox_cp_cbcr_01900_lazr_icanseetheplane_a9" );
    level.park hms_util::dialogue( "vox_cp_cbcr_01900_park_welldoitinturns_aa" );
    level thread function_99eade0f();
}

// Namespace namespace_379d0dc2/namespace_379d0dc2
// Params 0
// Checksum 0x702ebb2a, Offset: 0x25d0
// Size: 0x104
function function_866ea46f()
{
    level endon( #"flg_choice_made", #"flg_no_choice" );
    level flag::wait_till( "flg_choice_nags" );
    level.lazar thread hms_util::dialogue( "vox_cp_cbcr_02000_lazr_aggghhmylegs_39" );
    level flag::wait_till( "flg_nearing_exfil" );
    
    /#
        hms_util::print( "<dev string:x4a>" );
    #/
    
    level.park thread hms_util::dialogue( "vox_cp_cbcr_02000_park_pleasetimeisrun_4c", undefined, "allies", "Park" );
    level.lazar hms_util::dialogue( "vox_cp_cbcr_02000_lazr_quickly_03", undefined, "allies", "Lazar" );
}

// Namespace namespace_379d0dc2/namespace_379d0dc2
// Params 0
// Checksum 0x829649c5, Offset: 0x26e0
// Size: 0x15e
function function_99eade0f()
{
    level.player endon( #"death" );
    level endon( #"flg_skyhook_interacted" );
    wait 3;
    var_ffbbfc35 = [];
    var_ffbbfc35[ 0 ] = hms_util::function_e1449992( level.park, "vox_cp_cbcr_01900_park_bellhookin_94" );
    var_ffbbfc35[ 1 ] = hms_util::function_e1449992( level.park, "vox_cp_cbcr_01900_park_belltheskyhook_35" );
    var_ffbbfc35[ 2 ] = hms_util::function_e1449992( level.park, "vox_cp_cbcr_01900_park_bellhookintothe_ec" );
    var_ffbbfc35[ 3 ] = hms_util::function_e1449992( level.park, "vox_cp_cbcr_01900_park_moveitbellthepl_ab" );
    var_ffbbfc35[ 4 ] = hms_util::function_e1449992( level.park, "vox_cp_cbcr_01900_park_bellhurryup_2b" );
    var_ffbbfc35[ 5 ] = hms_util::function_e1449992( level.park, "vox_cp_cbcr_01900_park_bellwedonthavem_f8" );
    
    while ( true )
    {
        hms_util::vo_knockout_manager( "cuban_hook_in_nags", var_ffbbfc35 );
        wait 4;
    }
}

// Namespace namespace_379d0dc2/namespace_379d0dc2
// Params 0
// Checksum 0x12fb7c0a, Offset: 0x2848
// Size: 0x154
function function_e2262e44()
{
    var_106f184b = struct::get( "pilot_dialogue_exfil", "targetname" );
    level flag::wait_till( "flg_exfil_explosion_hit" );
    wait 7.5;
    var_106f184b hms_util::dialogue( "vox_cp_cbcr_02000_pilo_groundhogwehave_78", 1, "allies", "Pilot" );
    level flag::set( "flg_pilot_talked" );
    var_106f184b hms_util::dialogue( "vox_cp_cbcr_02000_pilo_9_4d", 1, "allies", "Pilot" );
    var_106f184b thread hms_util::dialogue( "vox_cp_cbcr_02000_pilo_pickupin8765_a5", 1, "allies", "Pilot" );
    wait 2;
    level flag::set( "flg_nearing_exfil" );
    var_106f184b hms_util::dialogue( "vox_cp_cbcr_02000_pilo_4321_f2", 1, "allies", "Pilot" );
}

// Namespace namespace_379d0dc2/namespace_379d0dc2
// Params 1
// Checksum 0x11a8cba3, Offset: 0x29a8
// Size: 0x124
function function_e6e98d21( *a_ents )
{
    var_74e225bb = struct::get( "exfil_choose_lazar" );
    var_74e225bb util::create_cursor_hint( undefined, undefined, #"hash_234a4924902e7f54", 1000, undefined, &function_6edd5850 );
    var_74e225bb prompts::function_44d7831a( #"use", 1 );
    var_e2d370cc = struct::get( "exfil_choose_park" );
    var_e2d370cc util::create_cursor_hint( undefined, undefined, #"hash_6a6f310d70076147", 1000, undefined, &function_4c0cb050 );
    var_e2d370cc prompts::function_44d7831a( #"use", 1 );
    level thread function_b35624bf();
}

// Namespace namespace_379d0dc2/namespace_379d0dc2
// Params 0
// Checksum 0x80f28839, Offset: 0x2ad8
// Size: 0xfc
function function_b35624bf()
{
    level endon( #"hash_111283e0a76017f6" );
    wait 13;
    var_e2d370cc = struct::get( "exfil_choose_park" );
    var_74e225bb = struct::get( "exfil_choose_lazar" );
    var_e2d370cc util::remove_cursor_hint();
    var_74e225bb util::remove_cursor_hint();
    level flag::set( "flg_no_choice" );
    level thread namespace_a789f8ae::function_d4b87197();
    level waittill( #"exfil_done" );
    skipto::function_1c2dfc20( "cp_ger_hub_post_cuba" );
}

// Namespace namespace_379d0dc2/namespace_379d0dc2
// Params 1
// Checksum 0xcefc5456, Offset: 0x2be0
// Size: 0xbc
function function_6edd5850( *s_info )
{
    level notify( #"hash_111283e0a76017f6" );
    level flag::set( "flg_choice_made" );
    var_79964af3 = struct::get( "exfil_choose_park" );
    var_79964af3 util::remove_cursor_hint();
    level thread namespace_a789f8ae::function_5bbd4049();
    level waittill( #"exfil_done" );
    skipto::function_1c2dfc20( "cp_ger_hub_post_cuba" );
}

// Namespace namespace_379d0dc2/namespace_379d0dc2
// Params 1
// Checksum 0xa7c347cf, Offset: 0x2ca8
// Size: 0xbc
function function_4c0cb050( *s_info )
{
    level notify( #"hash_111283e0a76017f6" );
    level flag::set( "flg_choice_made" );
    var_79964af3 = struct::get( "exfil_choose_lazar" );
    var_79964af3 util::remove_cursor_hint();
    level thread namespace_a789f8ae::function_67b48edc();
    level waittill( #"exfil_done" );
    skipto::function_1c2dfc20( "cp_ger_hub_post_cuba" );
}

// Namespace namespace_379d0dc2/namespace_379d0dc2
// Params 0
// Checksum 0x901a0684, Offset: 0x2d70
// Size: 0x118
function function_cc48b106()
{
    level endon( #"flg_choice_made" );
    var_e8a9ad8 = struct::get_array( "wave_3_smoke", "targetname" );
    
    foreach ( var_10ed23ba in var_e8a9ad8 )
    {
        level.player magicgrenadeplayer( getweapon( #"willy_pete" ), var_10ed23ba.origin, ( 0, 0, 0 ) );
        wait randomfloatrange( 0.5, 1 );
    }
}

// Namespace namespace_379d0dc2/namespace_379d0dc2
// Params 0
// Checksum 0x6b728667, Offset: 0x2e90
// Size: 0x36e
function function_ac6f37f4()
{
    level endon( #"flg_ac130_active" );
    level endon( #"flg_skyhook_interacted" );
    wait 5;
    var_6e1d93e1 = spawner::simple_spawn( "exfil_skyhook_guys_1" );
    var_ee2b13fe = spawner::simple_spawn( "exfil_skyhook_guys_2" );
    var_d81b9fd6 = arraycombine( var_6e1d93e1, var_ee2b13fe );
    
    foreach ( guy in var_d81b9fd6 )
    {
        if ( isalive( guy ) )
        {
            guy.script_accuracy = 0.2;
        }
    }
    
    wait 8;
    
    foreach ( guy in var_d81b9fd6 )
    {
        if ( isalive( guy ) )
        {
            guy.script_accuracy = 0.6;
        }
    }
    
    wait 5;
    
    foreach ( guy in var_d81b9fd6 )
    {
        if ( isalive( guy ) )
        {
            guy.script_accuracy = 0.8;
        }
    }
    
    wait 5;
    
    foreach ( guy in var_d81b9fd6 )
    {
        if ( isalive( guy ) )
        {
            guy.script_accuracy = 50;
        }
    }
    
    wait 5;
    
    foreach ( guy in var_d81b9fd6 )
    {
        if ( isalive( guy ) )
        {
            guy.script_accuracy = 1000;
        }
    }
}

// Namespace namespace_379d0dc2/namespace_379d0dc2
// Params 0
// Checksum 0x6a1b1567, Offset: 0x3208
// Size: 0x1fc
function function_29758311()
{
    level endon( #"hash_5dfc215255b7bf4" );
    self notifyonplayercommand( "ac130_support", "+actionslot 4" );
    self thread util::show_hint_text( #"hash_28625d21da426e88", 0, "ac130_support", 5 );
    self waittilltimeout( 5, #"ac130_support" );
    level flag::set( "flg_ac130_active" );
    snd::client_msg( "audio_ac130_started" );
    weap = getweapon( "ac130" );
    
    if ( isdefined( weap ) )
    {
        self giveweapon( weap );
        self switchtoweapon( weap );
        wait 0.3;
    }
    
    namespace_8bcd067b::function_1c110d7a( getent( "ac130_center_point", "targetname" ).origin, 8000 );
    self killstreaks::give( "ac130" );
    self killstreaks::usekillstreak( "ac130", 0 );
    
    if ( isdefined( weap ) )
    {
        wait 4;
        self takeweapon( weap );
    }
    
    wait 17;
    level flag::set( "flg_ac130_done" );
    snd::client_msg( "audio_ac130_stopped" );
}

// Namespace namespace_379d0dc2/namespace_379d0dc2
// Params 2
// Checksum 0x3fafe2b8, Offset: 0x3410
// Size: 0xb4
function function_501002d8( damage_trigger, fx_struct )
{
    level endon( #"flg_ac130_done" );
    
    while ( true )
    {
        var_7b1b5529 = damage_trigger waittill( #"damage" );
        
        if ( var_7b1b5529.mod === "MOD_PROJECTILE_SPLASH" )
        {
            playfx( level._effect[ #"hash_711a6d544750ccfb" ], fx_struct.origin + ( 0, 0, 50 ) );
            break;
        }
    }
}

// Namespace namespace_379d0dc2/namespace_379d0dc2
// Params 0
// Checksum 0xc7a18306, Offset: 0x34d0
// Size: 0x68
function function_4df2f981()
{
    level endon( #"flg_ac130_done" );
    
    while ( true )
    {
        var_c9651cf4 = spawner::simple_spawn( "ac13_drone_runners" );
        wait randomfloatrange( 8, 10 );
    }
}

// Namespace namespace_379d0dc2/namespace_379d0dc2
// Params 0
// Checksum 0xf5b12585, Offset: 0x3540
// Size: 0x424
function function_3817f59e()
{
    level endon( #"flg_skyhook_ready" );
    s_exfil_mortar_pos = struct::get_array( "s_exfil_mortar_pos", "targetname" );
    s_exfil_mortar_pos = array::randomize( s_exfil_mortar_pos );
    var_7b05954a = 0;
    
    foreach ( target in s_exfil_mortar_pos )
    {
        var_4a3daa0b = struct::get( target.target );
        var_7b05954a = 0;
        level flag::clear( "flg_mortar_seen" );
        
        while ( var_7b05954a <= 2 )
        {
            within_fov = util::within_fov( level.player getplayercamerapos(), level.player getplayerangles(), target.origin, cos( 65 ) );
            var_19433220 = sighttracepassed( level.player getplayercamerapos(), target.origin, 0, undefined );
            
            if ( within_fov == 1 && var_19433220 == 1 )
            {
                playfx( level._effect[ #"hash_5334c84fbd555272" ], target.origin + ( 0, 0, 50 ) );
                playfx( level._effect[ #"hash_2da85b06a03a2ba" ], target.origin );
                earthquake( 0.5, 1, target.origin, 1000 );
                radiusdamage( target.origin, 650, 1000, 100, level.player );
                level flag::set( "flg_mortar_seen" );
                break;
            }
            
            wait 1;
            var_7b05954a += 1;
            
            if ( var_7b05954a == 2 && !level flag::get( "flg_mortar_seen" ) )
            {
                playfx( level._effect[ #"hash_5334c84fbd555272" ], target.origin + ( 0, 0, 50 ) );
                playfx( level._effect[ #"hash_2da85b06a03a2ba" ], target.origin );
                earthquake( 0.5, 1, target.origin, 1000 );
                radiusdamage( target.origin, 650, 1000, 100, level.player );
                break;
            }
        }
    }
    
    level flag::set( "flg_mortar_strike_done" );
}

// Namespace namespace_379d0dc2/namespace_379d0dc2
// Params 1
// Checksum 0x8c9d1cc5, Offset: 0x3970
// Size: 0x7c
function function_4d15227c( *end_origin )
{
    self endon( #"death" );
    earthquake( 0.25, 1, self.origin, 2500 );
    self detonate();
    level thread function_b4d19680( self );
}

// Namespace namespace_379d0dc2/namespace_379d0dc2
// Params 1
// Checksum 0xeebe2ae7, Offset: 0x39f8
// Size: 0x1c2
function function_b4d19680( e_grenade )
{
    level endon( #"end_game" );
    var_b84a170a = getweapon( #"hash_7e94745566021fff" );
    var_740add51 = 120;
    var_2b9a525f = randomfloatrange( 0, var_740add51 );
    v_start = e_grenade.origin;
    
    for ( i = 0; i < 3 ; i++ )
    {
        n_angle = var_2b9a525f + var_740add51 * i + randomfloatrange( -10, 10 );
        v_dir = anglestoforward( ( 0, n_angle, 0 ) );
        v_spawn = v_start + 5 * v_dir;
        var_497d8162 = randomintrangeinclusive( 100, 250 );
        var_36bc8509 = randomintrangeinclusive( 200, 1000 );
        v_launch = var_497d8162 * v_dir - ( 0, 0, var_36bc8509 );
        level.player magicgrenadeplayer( var_b84a170a, v_spawn, v_launch );
        waitframe( 1 );
    }
}

/#

    // Namespace namespace_379d0dc2/namespace_379d0dc2
    // Params 4
    // Checksum 0x1ffbba3b, Offset: 0x3bc8
    // Size: 0x44, Type: dev
    function cleanup( *str_objective, *var_50cc0d4f, *var_aa1a6455, *player )
    {
        hms_util::print( "<dev string:x64>" );
    }

#/
