#using script_1fd2c6e5fc8cb1c3;
#using script_2856038948e153b5;
#using script_2d443451ce681a;
#using script_3dc93ca9902a9cda;
#using script_4ec222619bffcfd1;
#using script_4fdb32cc1d125464;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\districts;
#using scripts\core_common\doors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp\cp_rus_kgb;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;

#namespace kgb_aslt_exfil;

// Namespace kgb_aslt_exfil/namespace_7ab70467
// Params 1
// Checksum 0x66e94c42, Offset: 0x9b0
// Size: 0xc
function starting( *var_d3440450 )
{
    
}

// Namespace kgb_aslt_exfil/namespace_7ab70467
// Params 2
// Checksum 0xa2cadee4, Offset: 0x9c8
// Size: 0x31c
function main( var_d3440450, var_50cc0d4f )
{
    level flag::set( "aslt_exfil_begin" );
    
    if ( is_true( var_50cc0d4f ) )
    {
        level.adler = namespace_e77bf565::adler_spawn( var_d3440450, "adler_shotgun" );
        level.adler kgb_aslt_bunker_escape_deploy_gas::function_59dd75dc();
        level.inside_man = namespace_e77bf565::function_e4660071( var_d3440450, "inside_man_shotgun" );
        level.inside_man kgb_aslt_bunker_escape_deploy_gas::function_59dd75dc();
        level thread scene::skipto_end_noai( "scene_kgb_door_kick", "Last_Frame", undefined, 1 );
        level thread scene::skipto_end_noai( "scene_kgb_utility_room_adler", "Door_Closed", undefined, 1 );
        level thread kgb_aslt_exfil_escape::function_1f999428();
        player = getplayers()[ 0 ];
        player clientfield::set_to_player( "set_player_pbg_bank", 2 );
        level thread function_3b4bc579();
        level flag::set( "turn_on_elevator_alarm_light" );
        level thread scene::init( "scene_kgb_elevator_exfil_intro_adler" );
        level thread scene::init( "scene_kgb_elevator_exfil_intro_insideman" );
    }
    
    level thread namespace_e77bf565::escape_objective( var_d3440450, var_50cc0d4f );
    wait 0.05;
    namespace_353d803e::music( "deactivate_14.0b_full_alert" );
    level thread function_67c25994( var_d3440450 );
    level thread function_b735db01();
    level thread function_d883a464();
    level thread doors::close_all();
    level thread doors::function_f35467ac();
    level flag::wait_till( "aslt_exfil_player_left_elevator" );
    level flag::wait_till( "aslt_exfil_complete" );
    
    if ( isdefined( var_d3440450 ) )
    {
        skipto::function_4e3ab877( var_d3440450 );
    }
}

// Namespace kgb_aslt_exfil/namespace_7ab70467
// Params 0
// Checksum 0x2c035815, Offset: 0xcf0
// Size: 0x58
function function_3b4bc579()
{
    level flag::wait_till( "elevator_clips_ready" );
    level thread scene::init( "scene_kgb_elevator_exfil" );
    level notify( #"hash_75603f5b1241ba55" );
}

// Namespace kgb_aslt_exfil/namespace_7ab70467
// Params 4
// Checksum 0x46470899, Offset: 0xd50
// Size: 0x24
function cleanup( *name, *starting, *direct, *player )
{
    
}

// Namespace kgb_aslt_exfil/namespace_7ab70467
// Params 0
// Checksum 0xb1c9ee9, Offset: 0xd80
// Size: 0x104
function init_flags()
{
    level flag::init( "aslt_exfil_begin" );
    level flag::init( "aslt_exfil_complete" );
    level flag::init( "player_grabbed_armor" );
    level flag::init( "exfil_move_adler_to_elevator" );
    level flag::init( "exfil_adler_in_elevator" );
    level flag::init( "enable_gas_mask_interact" );
    level flag::init( "start_scene_kgb_elevator_exfil" );
    level flag::init( "slow_mo_stopped" );
}

// Namespace kgb_aslt_exfil/namespace_7ab70467
// Params 0
// Checksum 0x6f53cbb6, Offset: 0xe90
// Size: 0x64
function init_clientfields()
{
    clientfield::register( "scriptmover", "clf_fx_c4_on", 1, 1, "int" );
    clientfield::register( "scriptmover", "clf_fx_c4_blink", 1, 1, "int" );
}

// Namespace kgb_aslt_exfil/namespace_7ab70467
// Params 0
// Checksum 0x6e89ab07, Offset: 0xf00
// Size: 0x144
function function_22b7fffd()
{
    animation::add_notetrack_func( "kgb_audio::snd_play_cin_kgb_exfil_amb_lp_lr", &namespace_353d803e::function_d4ea305a );
    animation::add_notetrack_func( "kgb_aslt_exfil::c4_on", &function_3e23839f );
    animation::add_notetrack_func( "kgb_aslt_exfil::elevator_breach_slow_mo", &function_595d8864 );
    animation::add_notetrack_func( "kgb_aslt_exfil::make_guy_killable", &function_a02bf06e );
    animation::add_notetrack_func( "kgb_aslt_exfil::elevator_exfil_outro_gesture", &function_7750b07d );
    animation::add_notetrack_func( "kgb_aslt_exfil::elevator_exfil_outro_enable_player_control", &function_d32c245c );
    animation::add_notetrack_func( "kgb_aslt_exfil::allow_look_control_after_readying_weapon", &function_c0303dd1 );
    animation::add_notetrack_func( "kgb_aslt_exfil::lock_look_control_when_readying_explosive", &function_2ad193ed );
}

// Namespace kgb_aslt_exfil/namespace_7ab70467
// Params 1
// Checksum 0x6296727d, Offset: 0x1050
// Size: 0x5bc
function function_67c25994( *var_d3440450 )
{
    player = getplayers()[ 0 ];
    exfil_player_grab_armor_org = struct::get( "exfil_player_grab_armor_org", "targetname" );
    tag = spawn( "script_model", exfil_player_grab_armor_org.origin );
    tag setmodel( "tag_origin" );
    tag util::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), #"hash_410efc195dd1d8d", 64, undefined, undefined, undefined, 700, undefined, undefined, 1 );
    level flag::set( "enable_gas_mask_interact" );
    level thread function_9bdd4147();
    tag waittill( #"trigger" );
    player val::set( #"hash_6979003f12a8b0e4", "show_hud", 0 );
    player freezecontrolsallowlook( 1 );
    player val::set( #"hash_6979003f12a8b0e4", "disable_weapons", 1 );
    player val::set( #"hash_6979003f12a8b0e4", "disable_weapon_fire", 1 );
    player val::set( #"hash_6979003f12a8b0e4", "disable_weapon_reload", 1 );
    player val::set( #"hash_6979003f12a8b0e4", "disable_weapon_cycling", 1 );
    player val::set( #"hash_6979003f12a8b0e4", "disable_offhand_weapons", 1 );
    player val::set( #"hash_6979003f12a8b0e4", "disable_offhand_special", 1 );
    player val::set( #"hash_6979003f12a8b0e4", "allow_ads", 0 );
    namespace_353d803e::function_d9da407c();
    namespace_353d803e::function_f1a71ddd();
    tag util::remove_cursor_hint();
    level flag::set( "player_grabbed_armor" );
    level thread function_e58b5a12();
    level.player clientfield::set_to_player( "stream_elevator_exfil_assets", 1 );
    level thread scene::init_streamer( #"scene_kgb_elevator_exfil", getplayers() );
    wait 1;
    level.adler util::stop_magic_bullet_shield();
    level.adler delete();
    level.adler = namespace_e77bf565::adler_spawn( undefined, "adler_casual_killer" );
    level.adler kgb_aslt_bunker_escape_deploy_gas::function_b5b663();
    level.adler thread kgb_aslt_exfil_escape::function_8484087e();
    level.adler thread kgb_aslt_exfil_escape::give_lmg();
    level.inside_man util::stop_magic_bullet_shield();
    level.inside_man delete();
    level.inside_man = namespace_e77bf565::adler_spawn( undefined, "inside_man_casual_killer" );
    level.inside_man kgb_aslt_bunker_escape_deploy_gas::function_b5b663();
    level.inside_man thread kgb_aslt_exfil_escape::function_8484087e();
    level.inside_man thread kgb_aslt_exfil_escape::give_lmg();
    level flag::wait_till( "start_scene_kgb_elevator_exfil" );
    level.player clientfield::set_to_player( "stream_elevator_exfil_assets", 0 );
    level thread kgb_aslt_exfil_escape::alarm_lights();
    thread namespace_353d803e::function_6556551a();
    scene::play( "scene_kgb_elevator_exfil", "elevator_exfil_main" );
    exploder::exploder_stop( "gas" );
    exploder::exploder_stop( "vault_breach" );
    level flag::set( "aslt_exfil_complete" );
}

// Namespace kgb_aslt_exfil/namespace_7ab70467
// Params 1
// Checksum 0x39ce8f08, Offset: 0x1618
// Size: 0x64
function function_7750b07d( *params )
{
    player = getplayers()[ 0 ];
    player playgestureviewmodel( #"hash_76ab310d2a89b823", undefined, 1, 0.2, undefined, 1, 1 );
}

// Namespace kgb_aslt_exfil/namespace_7ab70467
// Params 1
// Checksum 0x96a0f030, Offset: 0x1688
// Size: 0x8c
function function_c0303dd1( *params )
{
    player = getplayers()[ 0 ];
    
    if ( isdefined( player ) && isdefined( player getlinkedent() ) )
    {
        player lerpviewangleclamp( 0.5, 0.5, 0, 10, 10, 10, 10 );
    }
}

// Namespace kgb_aslt_exfil/namespace_7ab70467
// Params 1
// Checksum 0x93f7d745, Offset: 0x1720
// Size: 0x84
function function_2ad193ed( *params )
{
    player = getplayers()[ 0 ];
    
    if ( isdefined( player ) && isdefined( player getlinkedent() ) )
    {
        player lerpviewangleclamp( 0.5, 0.5, 0, 0, 0, 0, 0 );
    }
}

// Namespace kgb_aslt_exfil/namespace_7ab70467
// Params 1
// Checksum 0x4d4bb55e, Offset: 0x17b0
// Size: 0x1d4
function function_d32c245c( *params )
{
    player = getplayers()[ 0 ];
    self hide();
    
    if ( isdefined( player ) && isdefined( player getlinkedent() ) )
    {
        player lerpviewangleclamp( 0.2, 0.1, 0, 20, 20, 20, 20 );
    }
    
    player val::reset( #"hash_6979003f12a8b0e4", "disable_weapon_fire" );
    player val::reset( #"hash_6979003f12a8b0e4", "disable_weapon_reload" );
    player val::reset( #"hash_6979003f12a8b0e4", "disable_weapon_cycling" );
    player val::reset( #"hash_6979003f12a8b0e4", "disable_offhand_weapons" );
    player val::reset( #"hash_6979003f12a8b0e4", "disable_offhand_special" );
    player val::reset( #"hash_6979003f12a8b0e4", "allow_ads" );
    player val::reset( #"hash_6979003f12a8b0e4", "show_hud" );
    player freezecontrolsallowlook( 0 );
}

// Namespace kgb_aslt_exfil/namespace_7ab70467
// Params 0
// Checksum 0x93cfc395, Offset: 0x1990
// Size: 0xc4
function function_b735db01()
{
    level.adler endon( #"death" );
    level.adler colors::disable();
    level.adler ai::set_behavior_attribute( "demeanor", "combat" );
    level thread scene::play( "scene_kgb_elevator_exfil_intro_adler" );
    level flag::wait_till( "player_grabbed_armor" );
    level thread scene::stop( "scene_kgb_elevator_exfil_intro_adler" );
}

// Namespace kgb_aslt_exfil/namespace_7ab70467
// Params 0
// Checksum 0xf3757ebc, Offset: 0x1a60
// Size: 0xc4
function function_d883a464()
{
    level.inside_man endon( #"death" );
    level.inside_man colors::disable();
    level.inside_man ai::set_behavior_attribute( "demeanor", "combat" );
    level thread scene::play( "scene_kgb_elevator_exfil_intro_insideman" );
    level flag::wait_till( "player_grabbed_armor" );
    level thread scene::stop( "scene_kgb_elevator_exfil_intro_insideman" );
}

// Namespace kgb_aslt_exfil/namespace_7ab70467
// Params 0
// Checksum 0x3313e1fd, Offset: 0x1b30
// Size: 0x114
function function_e5a2d425()
{
    level endon( #"hash_526bc20fac39185d" );
    player = getplayers()[ 0 ];
    player endon( #"death" );
    var_e5a2d425 = [];
    var_e5a2d425[ var_e5a2d425.size ] = "vox_cp_rkgb_08000_adlr_hitthebuttonbel_3b";
    var_e5a2d425[ var_e5a2d425.size ] = "vox_cp_rkgb_08000_adlr_getthedoorbell_4e";
    var_e5a2d425[ var_e5a2d425.size ] = "vox_cp_rkgb_08000_adlr_letsgobell_82";
    wait 10;
    i = 0;
    
    while ( true )
    {
        player thread objectives_ui::show_objectives();
        level.adler dialogue::queue( "" + var_e5a2d425[ i ] );
        i++;
        
        if ( i + 1 > var_e5a2d425.size )
        {
            i = 0;
        }
        
        wait 10;
    }
}

// Namespace kgb_aslt_exfil/namespace_7ab70467
// Params 0
// Checksum 0x2b66461b, Offset: 0x1c50
// Size: 0x264
function function_e58b5a12()
{
    util::delay( 2.5, undefined, &lui::screen_fade_out, 0.5, "black" );
    scene::play( "scene_kgb_elevator_exfil_intro_player" );
    level.player districts::function_930f8c81( [ "kgb_und_vault_bunker_main" ] );
    level.player districts::function_a7d79fcb( [ "kgb_hq_front_04", "kgb_hq_intersection", "kgb_hq_east_wing", "kgb_hq_elevator", "kgb_hq_armory_wing", "kgb_hq_courtyard", "kgb_hq_second_floor" ] );
    player = getplayers()[ 0 ];
    player clientfield::set_to_player( "set_player_pbg_bank", 0 );
    player cp_rus_kgb::function_69e3b754( undefined, "kgb_officer_exfil", 1, 1 );
    level thread function_45ba6f18();
    wait 3;
    player val::reset( #"hash_6979003f12a8b0e4", "disable_weapons" );
    level.adler dialogue::queue( "vox_cp_rkgb_08000_adlr_letsgetuptop_99" );
    level flag::set( "start_scene_kgb_elevator_exfil" );
    wait 0.5;
    level thread lui::screen_fade_in( 1 );
    snd::client_msg( #"hash_71b18c4ea1c4cea2" );
    namespace_353d803e::music( "14.1_elevator" );
}

// Namespace kgb_aslt_exfil/namespace_7ab70467
// Params 0
// Checksum 0x5047756d, Offset: 0x1ec0
// Size: 0x260
function function_45ba6f18()
{
    exfil_escape_cover_clip = getentarray( "exfil_escape_cover_clip", "targetname" );
    
    foreach ( clip in exfil_escape_cover_clip )
    {
        if ( isdefined( clip.script_noteworthy ) && clip.script_noteworthy == "link_to_elevator" )
        {
            clip linkto( level.elevator );
        }
        
        if ( isdefined( clip.script_string ) && clip.script_string == "delete_on_gear_up" )
        {
            clip delete();
        }
    }
    
    exfil_escape_cover_model = struct::get_array( "exfil_escape_cover_model", "targetname" );
    
    foreach ( model in exfil_escape_cover_model )
    {
        if ( isdefined( model.script_noteworthy ) && model.script_noteworthy == "link_to_elevator" )
        {
            if ( isdefined( model.script_model ) )
            {
                model.script_model linkto( level.elevator );
            }
        }
        
        if ( isdefined( model.script_string ) && model.script_string == "delete_on_gear_up" )
        {
            if ( isdefined( model.script_model ) )
            {
                model.script_model delete();
            }
        }
    }
}

// Namespace kgb_aslt_exfil/namespace_7ab70467
// Params 1
// Checksum 0xd690da, Offset: 0x2128
// Size: 0xc4
function function_3e23839f( *params )
{
    self clientfield::set( "clf_fx_c4_on", 1 );
    level waittill( #"hash_1945b16f8963fc51" );
    self clientfield::set( "clf_fx_c4_on", 0 );
    self clientfield::set( "clf_fx_c4_blink", 1 );
    level flag::wait_till( "exfil_escape_elevator_guards_explosion_triggered" );
    self clientfield::set( "clf_fx_c4_blink", 0 );
}

// Namespace kgb_aslt_exfil/namespace_7ab70467
// Params 1
// Checksum 0x886bb555, Offset: 0x21f8
// Size: 0x124
function function_595d8864( *params )
{
    level notify( #"hash_1945b16f8963fc51" );
    namespace_353d803e::music( "deactivate_14.1_elevator" );
    var_a1b2be39 = 0.3;
    var_8f6ebef8 = 0.5;
    var_e949dab8 = 0.1;
    setslowmotion( 1, var_a1b2be39, var_8f6ebef8 );
    level waittilltimeout( 6, #"hash_1849d5500c113ddd", #"hash_44155301ad2081b0" );
    level flag::set( "slow_mo_stopped" );
    snd::client_msg( #"hash_2d7e4cbd73ad29fb" );
    setslowmotion( var_a1b2be39, 1, var_e949dab8 );
}

// Namespace kgb_aslt_exfil/namespace_7ab70467
// Params 1
// Checksum 0xa6ee7e64, Offset: 0x2328
// Size: 0x2e
function function_a02bf06e( *params )
{
    self.allowdeath = 1;
    self.takedamage = 1;
    self.magic_bullet_shield = undefined;
}

// Namespace kgb_aslt_exfil/namespace_7ab70467
// Params 0
// Checksum 0x5688c806, Offset: 0x2360
// Size: 0x94
function function_9bdd4147()
{
    level endon( #"player_grabbed_armor" );
    wait 2;
    level.inside_man dialogue::queue( "vox_cp_rkgb_08000_blkv_theresthegear_b4" );
    wait 0.25;
    level.inside_man dialogue::queue( "vox_cp_rkgb_08000_blkv_bodyarmorhelmet_79" );
    wait 0.25;
    level.adler dialogue::queue( "vox_cp_rkgb_08000_adlr_gearupbell_7d" );
}

