#using script_31e9b35aaacbbd93;
#using script_3626f1b2cf51a99c;
#using script_3dc93ca9902a9cda;
#using script_61cfc2ab8e60625;
#using script_671f58f0b7aa833d;
#using script_9bfd3d8a6a89e5e;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\districts;
#using scripts\core_common\flag_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\collectibles;
#using scripts\cp_common\dialog_tree;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;

#namespace tkdn_raid_capture;

// Namespace tkdn_raid_capture/cp_takedown_raid_capture
// Params 1
// Checksum 0x5294beb4, Offset: 0x7a0
// Size: 0x384
function starting( *var_d3440450 )
{
    thread objectives::scripted( "obj_takedown_capture", undefined, #"hash_49c1d860c97e3792" );
    player = getplayers()[ 0 ];
    var_8a3bb97c = getspawnerarray( "raid_adler", "targetname" );
    woods_spawner = getspawnerarray( "raid_woods", "targetname" );
    level.adler = var_8a3bb97c[ 0 ] spawner::spawn( 1 );
    var_fcbd93e0 = struct::get( "raid_capture_adler", "targetname" );
    level.adler forceteleport( var_fcbd93e0.origin, var_fcbd93e0.angles );
    level.adler.ignoreall = 1;
    weapon = getweapon( #"pistol_semiauto_t9" );
    level.adler aiutility::setprimaryweapon( weapon );
    level.adler ai::gun_switchto( weapon, "right" );
    level.woods = woods_spawner[ 0 ] spawner::spawn( 1 );
    var_1100faeb = struct::get( "raid_capture_woods", "targetname" );
    level.woods forceteleport( var_1100faeb.origin, var_1100faeb.angles );
    level.woods.ignoreall = 1;
    player setlowready( 1 );
    level flag::set( "flag_qasim_ready_for_interrogation" );
    level scene::init( "scene_tkd_hit2_rooftop" );
    level thread function_daaa52d5();
    player clientfield::set_to_player( "lerp_fov", 7 );
    level.qasim = getactorarray( "raid_qasim", "targetname" )[ 0 ];
    level.qasim thread namespace_b100dd86::swap_head( undefined, "c_t9_cp_ira_militant_vip_qasim_head_nohat_injured" );
    level.qasim thread namespace_b100dd86::function_f82142f8( undefined, "c_t9_cp_ira_militant_vip_qasim_tkd_body" );
    level thread scene::skipto_end( "scene_tkd_hit2_rooftop_slide_enemy2", "Shot 1", undefined, 1, 0 );
}

// Namespace tkdn_raid_capture/cp_takedown_raid_capture
// Params 0
// Checksum 0x1193d426, Offset: 0xb30
// Size: 0x2b0
function function_daaa52d5()
{
    raid_capture_plant = getent( "raid_capture_plant", "targetname" );
    
    if ( isdefined( raid_capture_plant ) )
    {
        level scene::init( "scene_tkd_hit2_rooftop_props", [ raid_capture_plant ] );
    }
    
    level thread scene::play( "scene_tkd_hit2_canal_ambience" );
    level thread scene::init( "bird_plantsmash_startle", "targetname" );
    level thread function_bde24dd8();
    canal_boats = getentarray( "canal_boats", "targetname" );
    
    foreach ( boat in canal_boats )
    {
        if ( isdefined( boat.target ) )
        {
            boat.var_dcc87061 = [];
            var_dcc87061 = getentarray( boat.target, "targetname" );
            
            foreach ( var_a8f6e856 in var_dcc87061 )
            {
                if ( isdefined( var_a8f6e856 ) )
                {
                    var_a8f6e856 linkto( boat );
                    
                    if ( !isdefined( boat.var_dcc87061 ) )
                    {
                        boat.var_dcc87061 = [];
                    }
                    else if ( !isarray( boat.var_dcc87061 ) )
                    {
                        boat.var_dcc87061 = array( boat.var_dcc87061 );
                    }
                    
                    boat.var_dcc87061[ boat.var_dcc87061.size ] = var_a8f6e856;
                }
            }
        }
        
        boat thread function_d40d301c();
    }
}

// Namespace tkdn_raid_capture/cp_takedown_raid_capture
// Params 0
// Checksum 0xc9b37a4b, Offset: 0xde8
// Size: 0x44
function function_bde24dd8()
{
    level waittill( #"bird_plantsmash_startle" );
    level thread scene::play( "bird_plantsmash_startle", "targetname" );
}

// Namespace tkdn_raid_capture/cp_takedown_raid_capture
// Params 0
// Checksum 0x5b499e30, Offset: 0xe38
// Size: 0x84
function function_d40d301c()
{
    wait randomfloatrange( 0.5, 1.5 );
    
    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "boat_small" )
    {
        self thread scene::play( "scene_tkd_hit2_canal_ambience_boat_small", self );
        return;
    }
    
    self thread scene::play( "scene_tkd_hit2_canal_ambience_boat_large", self );
}

// Namespace tkdn_raid_capture/cp_takedown_raid_capture
// Params 2
// Checksum 0x9538173b, Offset: 0xec8
// Size: 0x464
function main( var_d3440450, *var_50cc0d4f )
{
    level.var_b21fd7ea = [];
    scene::function_d0d7d9f7( "scene_tkd_hit2_rooftop", &function_6c1a4c01 );
    scene::function_d0d7d9f7( "scene_tkd_hit2_rooftop_props", &function_6c1a4c01 );
    
    /#
        iprintlnbold( "<dev string:x38>" );
    #/
    
    level thread function_3dafee47();
    
    if ( isdefined( level.adler ) )
    {
        level.raid_adler = level.adler;
    }
    
    if ( isdefined( level.woods ) )
    {
        level.raid_woods = level.woods;
    }
    
    level thread function_26e6230d();
    level thread function_ba74fe83();
    level waittill( #"hash_1971429b4a856253" );
    player = getplayers()[ 0 ];
    player disableweapons();
    level.adler thread function_e5aa773b( "adler_leave_capture" );
    level.woods thread function_e5aa773b( "woods_leave_capture" );
    player clientfield::set_to_player( "lerp_fov", 0 );
    player function_2d0aefe0();
    level thread objectives::complete( "obj_takedown_capture" );
    level util::screen_fade_out( 0.5 );
    wait 0.6;
    player enableweapons();
    namespace_a052577e::function_a5d5a125();
    player setstance( "stand" );
    player freezecontrols( 1 );
    
    if ( player function_8bc54983() )
    {
        player setlowready( 0 );
    }
    
    if ( isdefined( level.raid_adler.magic_bullet_shield ) )
    {
        level thread util::stop_magic_bullet_shield( level.raid_adler );
    }
    
    if ( isdefined( level.raid_woods.magic_bullet_shield ) )
    {
        level thread util::stop_magic_bullet_shield( level.raid_woods );
    }
    
    level scene::stop( "scene_tkd_hit2_rooftop", 1 );
    level scene::stop( "scene_tkd_hit2_rooftop_props", 1 );
    level scene::stop( "scene_tkd_hit2_canal_ambience", 1 );
    corpses = getcorpsearray();
    
    foreach ( corpse in corpses )
    {
        if ( isactorcorpse( corpse ) )
        {
            corpse delete();
        }
    }
    
    if ( isdefined( var_50cc0d4f ) )
    {
        skipto::function_4e3ab877( var_50cc0d4f );
    }
}

// Namespace tkdn_raid_capture/cp_takedown_raid_capture
// Params 0
// Checksum 0x722be2de, Offset: 0x1338
// Size: 0x10c
function function_26e6230d()
{
    if ( !isdefined( level.qasim ) )
    {
        level.qasim = getactorarray( "raid_qasim", "targetname" )[ 0 ];
    }
    
    level.qasim endon( #"death" );
    level.qasim.var_c681e4c1 = 1;
    level.qasim.ignoreall = 1;
    level.raid_adler = level.adler;
    level.raid_woods = level.woods;
    level.raid_qasim = level.qasim;
    level flag::wait_till( "flag_qasim_ready_for_interrogation" );
    level.qasim thread dialog_tree::function_cfa96cee( level.var_27da2f39, undefined, undefined, undefined, 80, 200, undefined, undefined, 1 );
}

// Namespace tkdn_raid_capture/cp_takedown_raid_capture
// Params 1
// Checksum 0x2c27050b, Offset: 0x1450
// Size: 0x7c
function function_e5aa773b( struct_name )
{
    struct = struct::get( struct_name, "targetname" );
    self ai::set_behavior_attribute( "demeanor", "patrol" );
    self ai::force_goal( struct.origin, 0 );
}

// Namespace tkdn_raid_capture/cp_takedown_raid_capture
// Params 2
// Checksum 0x9004227d, Offset: 0x14d8
// Size: 0x11c
function function_6c1a4c01( a_ents, *str_shot )
{
    foreach ( ent in str_shot )
    {
        if ( !isdefined( level.var_b21fd7ea ) )
        {
            level.var_b21fd7ea = [];
        }
        else if ( !isarray( level.var_b21fd7ea ) )
        {
            level.var_b21fd7ea = array( level.var_b21fd7ea );
        }
        
        if ( !isinarray( level.var_b21fd7ea, ent ) )
        {
            level.var_b21fd7ea[ level.var_b21fd7ea.size ] = ent;
        }
    }
}

// Namespace tkdn_raid_capture/cp_takedown_raid_capture
// Params 0
// Checksum 0x7299b1fa, Offset: 0x1600
// Size: 0x8c
function function_44f8874()
{
    level thread scene::play( "scene_tkd_hit2_rooftop_props", "dt_enter" );
    level scene::play( "scene_tkd_hit2_rooftop", "dt_enter" );
    level notify( #"hash_6fec65520df29efc" );
    level thread scene::play( "scene_tkd_hit2_rooftop", "dt_idle" );
}

// Namespace tkdn_raid_capture/cp_takedown_raid_capture
// Params 0
// Checksum 0x1cca9f42, Offset: 0x1698
// Size: 0x3c
function function_8a6dd527()
{
    level waittill( #"hash_74f0b712a3680b18" );
    self clientfield::set_to_player( "lerp_fov", 5 );
}

// Namespace tkdn_raid_capture/cp_takedown_raid_capture
// Params 0
// Checksum 0x1fe1f56e, Offset: 0x16e0
// Size: 0x49c
function function_3dafee47()
{
    var_6139147e = [ "vox_cp_tdwn_05100_qasm_iijusthandlethe_6e", "vox_cp_tdwn_05100_adlr_idontthinkyouun_95", "vox_cp_tdwn_05100_qasm_youcantdothisyo_0e", "vox_cp_tdwn_05100_adlr_ivesteppedthrou_86", "vox_cp_tdwn_05100_adlr_newpresidentnew_27" ];
    level.var_27da2f39 = dialog_tree::new_tree( &function_44f8874, undefined, 1, 0, "scene_tkd_hit2_rooftop" );
    level.var_27da2f39 dialog_tree::add_option( #"hash_3c66be703efed3de", undefined, "dt_1_res", "dt_idle", 1, undefined, undefined, &function_86b6bafa );
    level.var_27da2f39 dialog_tree::add_option( #"hash_318bdd24cc15cbb", undefined, "dt_1_res", "dt_idle", 1, undefined, undefined, &function_86b6bafa );
    dialog_tree::function_21780fc5( level.var_27da2f39, array( 1340, 700 ) );
    level.var_58759087 = dialog_tree::new_tree( undefined, undefined, 1, 0, "scene_tkd_hit2_rooftop" );
    level.var_58759087 dialog_tree::add_option( #"hash_f2078633819f72a", undefined, "dt_2_res", "dt_idle", 1, undefined, undefined, &function_58efdf6d );
    level.var_58759087 dialog_tree::add_option( #"hash_18daf35010313d18", undefined, "dt_2_res", "dt_idle", 1, undefined, undefined, &function_58efdf6d );
    dialog_tree::function_21780fc5( level.var_58759087, array( 1340, 700 ) );
    level.var_4a3df400 = dialog_tree::new_tree( undefined, undefined, 1, 0, "scene_tkd_hit2_rooftop" );
    level.var_4a3df400 dialog_tree::add_option( #"hash_349afebd4cf454c0", undefined, "dt_3_res", "dt_idle", 1, undefined, undefined, &function_6321f3d1 );
    level.var_4a3df400 dialog_tree::add_option( #"hash_492dbe6eaab8aa2f", undefined, undefined, undefined, 1, undefined, undefined, &function_80b14544 );
    dialog_tree::function_21780fc5( level.var_4a3df400, array( 1340, 700 ) );
    level.var_cb1375a9 = dialog_tree::new_tree( undefined, undefined, 1, 0, "scene_tkd_hit2_rooftop" );
    level.var_cb1375a9 dialog_tree::add_option( #"hash_129166306e8bfcd3", undefined, undefined, undefined, 1, undefined, undefined, &function_4f4627e4 );
    level.var_cb1375a9 dialog_tree::add_option( #"hash_492dbe6eaab8aa2f", undefined, undefined, undefined, 1, undefined, undefined, &function_80b14544 );
    level.var_cb1375a9 dialog_tree::add_option( #"hash_48d4e67acff606fd", undefined, undefined, undefined, 1, undefined, undefined, &function_c29f52ec );
    dialog_tree::function_21780fc5( level.var_cb1375a9, array( 1340, 700 ) );
}

// Namespace tkdn_raid_capture/cp_takedown_raid_capture
// Params 0
// Checksum 0x49d9614, Offset: 0x1b88
// Size: 0x8c
function function_86b6bafa()
{
    level thread namespace_a052577e::function_e88f8edb();
    self waittill( #"dialog_tree_scene_response_complete" );
    level.var_58759087 thread dialog_tree::run( level.qasim );
    level districts::function_a7d79fcb( [ "airfield_intro", "airfield_base" ] );
}

// Namespace tkdn_raid_capture/cp_takedown_raid_capture
// Params 0
// Checksum 0x8d7973b1, Offset: 0x1c20
// Size: 0x1cc
function function_b47183fb()
{
    if ( !isdefined( level.raid_capture_street_vehicle ) )
    {
        level.raid_capture_street_vehicle = getent( "raid_capture_street_vehicle", "targetname" );
    }
    
    if ( !isdefined( level.raid_capture_street_vehicle ) )
    {
        return;
    }
    
    if ( level.raid_capture_street_vehicle haspart( "tag_glass_windshield_d1" ) )
    {
        level.raid_capture_street_vehicle hidepart( "tag_glass_windshield_d1" );
    }
    
    if ( level.raid_capture_street_vehicle haspart( "tag_glass_hatch_d1" ) )
    {
        level.raid_capture_street_vehicle hidepart( "tag_glass_hatch_d1" );
    }
    
    if ( level.raid_capture_street_vehicle haspart( "tag_glass_right_side_d1" ) )
    {
        level.raid_capture_street_vehicle hidepart( "tag_glass_right_side_d1" );
    }
    
    if ( level.raid_capture_street_vehicle haspart( "tag_glass_left_side_d1" ) )
    {
        level.raid_capture_street_vehicle hidepart( "tag_glass_left_side_d1" );
    }
    
    if ( level.raid_capture_street_vehicle haspart( "tag_glass_right_front_d1" ) )
    {
        level.raid_capture_street_vehicle hidepart( "tag_glass_right_front_d1" );
    }
    
    if ( level.raid_capture_street_vehicle haspart( "tag_glass_left_front_d1" ) )
    {
        level.raid_capture_street_vehicle hidepart( "tag_glass_left_front_d1" );
    }
}

// Namespace tkdn_raid_capture/cp_takedown_raid_capture
// Params 0
// Checksum 0x945fb41b, Offset: 0x1df8
// Size: 0x3f4
function function_ba74fe83()
{
    if ( !isdefined( level.raid_capture_street_vehicle ) )
    {
        level function_b47183fb();
    }
    
    if ( !isdefined( level.raid_capture_street_vehicle ) )
    {
        return;
    }
    
    level waittill( #"hash_6cb6f4903c20dbae" );
    playfxontag( "destruct/fx_dest_glass_shard_impact_burst", level.raid_capture_street_vehicle, "tag_glass_windshield_d0" );
    
    if ( level.raid_capture_street_vehicle haspart( "tag_glass_windshield_d0" ) )
    {
        level.raid_capture_street_vehicle hidepart( "tag_glass_windshield_d0" );
    }
    
    if ( level.raid_capture_street_vehicle haspart( "tag_glass_windshield_d1" ) )
    {
        level.raid_capture_street_vehicle showpart( "tag_glass_windshield_d1" );
    }
    
    playfxontag( "destruct/fx_dest_glass_shard_impact_burst", level.raid_capture_street_vehicle, "tag_glass_hatch_d0" );
    
    if ( level.raid_capture_street_vehicle haspart( "tag_glass_hatch_d0" ) )
    {
        level.raid_capture_street_vehicle hidepart( "tag_glass_hatch_d0" );
    }
    
    if ( level.raid_capture_street_vehicle haspart( "tag_glass_hatch_d1" ) )
    {
        level.raid_capture_street_vehicle showpart( "tag_glass_hatch_d1" );
    }
    
    if ( level.raid_capture_street_vehicle haspart( "tag_glass_right_side_d0" ) )
    {
        level.raid_capture_street_vehicle hidepart( "tag_glass_right_side_d0" );
    }
    
    if ( level.raid_capture_street_vehicle haspart( "tag_glass_right_side_d1" ) )
    {
        level.raid_capture_street_vehicle showpart( "tag_glass_right_side_d1" );
    }
    
    playfxontag( "destruct/fx_dest_glass_shard_impact_burst", level.raid_capture_street_vehicle, "tag_glass_left_side_d0" );
    
    if ( level.raid_capture_street_vehicle haspart( "tag_glass_left_side_d0" ) )
    {
        level.raid_capture_street_vehicle hidepart( "tag_glass_left_side_d0" );
    }
    
    if ( level.raid_capture_street_vehicle haspart( "tag_glass_left_side_d1" ) )
    {
        level.raid_capture_street_vehicle showpart( "tag_glass_left_side_d1" );
    }
    
    playfxontag( "destruct/fx_dest_glass_shard_impact_burst", level.raid_capture_street_vehicle, "tag_glass_right_front_d0" );
    
    if ( level.raid_capture_street_vehicle haspart( "tag_glass_right_front_d0" ) )
    {
        level.raid_capture_street_vehicle hidepart( "tag_glass_right_front_d0" );
    }
    
    if ( level.raid_capture_street_vehicle haspart( "tag_glass_right_front_d1" ) )
    {
        level.raid_capture_street_vehicle showpart( "tag_glass_right_front_d1" );
    }
    
    if ( level.raid_capture_street_vehicle haspart( "tag_glass_left_front_d0" ) )
    {
        level.raid_capture_street_vehicle hidepart( "tag_glass_left_front_d0" );
    }
    
    if ( level.raid_capture_street_vehicle haspart( "tag_glass_left_front_d1" ) )
    {
        level.raid_capture_street_vehicle showpart( "tag_glass_left_front_d1" );
    }
}

// Namespace tkdn_raid_capture/cp_takedown_raid_capture
// Params 0
// Checksum 0x264f5212, Offset: 0x21f8
// Size: 0x3c
function function_58efdf6d()
{
    self waittill( #"dialog_tree_scene_response_complete" );
    level.var_4a3df400 thread dialog_tree::run( level.qasim );
}

// Namespace tkdn_raid_capture/cp_takedown_raid_capture
// Params 0
// Checksum 0x85b1ccbc, Offset: 0x2240
// Size: 0x54
function function_6321f3d1()
{
    self waittill( #"dialog_tree_scene_response_complete" );
    collectibles::function_6cd091d2( 1 );
    level.var_cb1375a9 thread dialog_tree::run( level.qasim );
}

// Namespace tkdn_raid_capture/cp_takedown_raid_capture
// Params 0
// Checksum 0xc73b05fa, Offset: 0x22a0
// Size: 0x96
function function_80b14544()
{
    level thread scene::play( "scene_tkd_hit2_rooftop", "dt_end_1_throw" );
    music::function_edda155f( "3.2_kill_stinger" );
    player = getplayers()[ 0 ];
    player waittillmatch( { #notetrack:"end" }, #"hash_b1f863e899edc77" );
}

// Namespace tkdn_raid_capture/cp_takedown_raid_capture
// Params 0
// Checksum 0x2c53b726, Offset: 0x2340
// Size: 0x7e
function function_c29f52ec()
{
    level thread scene::play( "scene_tkd_hit2_rooftop", "dt_end_2_capture" );
    player = getplayers()[ 0 ];
    player waittillmatch( { #notetrack:"end" }, #"hash_40acbc898ee5e354" );
}

// Namespace tkdn_raid_capture/cp_takedown_raid_capture
// Params 0
// Checksum 0x42a8d5ac, Offset: 0x23c8
// Size: 0xb6
function function_4f4627e4()
{
    level thread scene::play( "scene_tkd_hit2_rooftop", "dt_5_res" );
    self thread function_95707bc7();
    player = getplayers()[ 0 ];
    player setlowready( 0 );
    player waittillmatch( { #notetrack:"end" }, #"hash_576c5aac6ddaa60a" );
}

// Namespace tkdn_raid_capture/cp_takedown_raid_capture
// Params 0
// Checksum 0x27ce6076, Offset: 0x2488
// Size: 0x11c
function function_95707bc7()
{
    level endon( #"hash_19e8d79db3b9786a" );
    level.qasim thread function_fa343ac7();
    waitresult = level.qasim waittill( #"damage", #"dt_5_res_over" );
    
    if ( waitresult._notify == "dt_5_res_over" )
    {
        level thread scene::play( "scene_tkd_hit2_rooftop", "dt_5_res_idle" );
        level thread function_2ed341fb();
        level.qasim waittill( #"damage" );
    }
    
    level notify( #"hash_2871e831466dfa03" );
    level scene::play( "scene_tkd_hit2_rooftop", "dt_end_3_playershoots" );
}

// Namespace tkdn_raid_capture/cp_takedown_raid_capture
// Params 0
// Checksum 0xa2134d9, Offset: 0x25b0
// Size: 0x66
function function_fa343ac7()
{
    self endon( #"death" );
    self endon( #"damage" );
    self waittillmatch( { #notetrack:"end" }, #"hash_14f49c6f7696568c" );
    self notify( #"dt_5_res_over" );
}

// Namespace tkdn_raid_capture/cp_takedown_raid_capture
// Params 0
// Checksum 0xabe317fb, Offset: 0x2620
// Size: 0x5c
function function_2ed341fb()
{
    level endon( #"hash_2871e831466dfa03" );
    wait 6;
    level notify( #"hash_19e8d79db3b9786a" );
    level scene::play( "scene_tkd_hit2_rooftop", "dt_end_4_Adlershoots" );
}

// Namespace tkdn_raid_capture/cp_takedown_raid_capture
// Params 4
// Checksum 0x41a4e804, Offset: 0x2688
// Size: 0x3e4
function cleanup( *name, *starting, *direct, *player )
{
    if ( isdefined( level.raid_qasim ) )
    {
        if ( isdefined( level.raid_qasim.magic_bullet_shield ) )
        {
            level thread util::stop_magic_bullet_shield( level.raid_qasim );
        }
        
        level.raid_qasim delete();
    }
    
    if ( isdefined( level.raid_adler ) )
    {
        if ( isdefined( level.raid_adler.magic_bullet_shield ) )
        {
            level thread util::stop_magic_bullet_shield( level.raid_adler );
        }
        
        level.raid_adler delete();
    }
    
    if ( isdefined( level.raid_woods ) )
    {
        if ( isdefined( level.raid_woods.magic_bullet_shield ) )
        {
            level thread util::stop_magic_bullet_shield( level.raid_woods );
        }
        
        level.raid_woods delete();
    }
    
    raid_capture_street_vehicle = getent( "raid_capture_street_vehicle", "targetname" );
    
    if ( isdefined( raid_capture_street_vehicle ) )
    {
        raid_capture_street_vehicle delete();
    }
    
    raid_capture_plant = getent( "raid_capture_plant", "targetname" );
    
    if ( isdefined( raid_capture_plant ) )
    {
        raid_capture_plant delete();
    }
    
    canal_boats = getentarray( "canal_boats", "targetname" );
    
    if ( isdefined( canal_boats ) )
    {
        foreach ( boat in canal_boats )
        {
            if ( isdefined( boat.target ) )
            {
                var_dcc87061 = getentarray( boat.target, "targetname" );
                
                foreach ( var_a8f6e856 in var_dcc87061 )
                {
                    if ( isdefined( var_a8f6e856 ) )
                    {
                        var_a8f6e856 delete();
                    }
                }
            }
            
            if ( isdefined( boat ) )
            {
                boat delete();
            }
        }
    }
    
    canal_house_boat = getent( "canal_house_boat", "targetname" );
    
    if ( isdefined( canal_house_boat ) )
    {
        canal_house_boat delete();
    }
    
    canal_small_boat = getent( "canal_small_boat", "targetname" );
    
    if ( isdefined( canal_small_boat ) )
    {
        canal_small_boat delete();
    }
}

// Namespace tkdn_raid_capture/cp_takedown_raid_capture
// Params 0
// Checksum 0x80f724d1, Offset: 0x2a78
// Size: 0x4
function init_flags()
{
    
}

// Namespace tkdn_raid_capture/cp_takedown_raid_capture
// Params 0
// Checksum 0x80f724d1, Offset: 0x2a88
// Size: 0x4
function init_clientfields()
{
    
}

// Namespace tkdn_raid_capture/cp_takedown_raid_capture
// Params 0
// Checksum 0x80f724d1, Offset: 0x2a98
// Size: 0x4
function function_22b7fffd()
{
    
}

// Namespace tkdn_raid_capture/cp_takedown_raid_capture
// Params 2
// Checksum 0xca5d57d5, Offset: 0x2aa8
// Size: 0x184
function function_2d0aefe0( *height, time = 3 )
{
    self disableweapons();
    struct = struct::get( "raid_zoom_out_pos", "targetname" );
    namespace_a052577e::function_60c0a46b();
    var_4449f5d0 = spawn( "script_model", self.origin + ( 0, 0, 120 ) );
    var_4449f5d0.angles = struct.angles;
    var_4449f5d0 setmodel( "tag_origin" );
    self playerlinktoblend( var_4449f5d0, "tag_origin", 0.5, 0, 0, 0.5, 0, 0, 1 );
    var_4449f5d0 moveto( struct.origin, time, 0.5, time / 3 );
    wait time;
    var_4449f5d0 util::delay( 2, undefined, &delete );
}

