#using script_19971192452f4209;
#using script_2d443451ce681a;
#using script_4052585f7ae90f3a;
#using script_5513c8efed5ff300;
#using scripts\core_common\animation_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\districts;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp_common\dialog_tree;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\load;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;

#namespace namespace_fdde5f3d;

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 0
// Checksum 0x1c320f5e, Offset: 0xcf8
// Size: 0xc4
function function_f50bc4b9()
{
    level flag::init( "flag_post_prisoner_ally_enter" );
    level flag::init( "flag_post_prisoner_ally_exit" );
    level flag::init( "flag_post_prisoner_lie" );
    level flag::init( "flag_post_prisoner_truth" );
    level flag::init( "flag_post_prisoner_radio" );
    level flag::init( "flag_post_prisoner_complete" );
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 1
// Checksum 0x2d23ee22, Offset: 0xdc8
// Size: 0xc
function starting( *var_d3440450 )
{
    
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 2
// Checksum 0x666e44b3, Offset: 0xde0
// Size: 0xec
function main( var_d3440450, *var_50cc0d4f )
{
    level.player districts::function_a7d79fcb( "safehouse", 1 );
    level namespace_31c67f6d::function_6194f34a( "post_prisoner", 1 );
    level thread function_dbf5481b();
    level thread namespace_4ed3ce47::function_7edafa59( var_50cc0d4f + "_briefing" );
    level thread namespace_31c67f6d::function_b0558ba2( "8" );
    level function_3b9f24df();
    
    if ( isdefined( var_50cc0d4f ) )
    {
        skipto::function_4e3ab877( var_50cc0d4f );
    }
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 0
// Checksum 0x8784ba74, Offset: 0xed8
// Size: 0x30c
function function_3b9f24df()
{
    level.var_ea95c1e7 = namespace_31c67f6d::function_c9dc0e79();
    level.player thread clientfield::set_to_player( "set_hub_fov", 1 );
    level thread function_474dc7d3();
    
    while ( !isdefined( level.player_connected ) && level.player_connected != 1 )
    {
        waitframe( 1 );
    }
    
    wait 3;
    level thread namespace_31c67f6d::pstfx_teleport( 3, 1, 1 );
    
    if ( isdefined( level.var_d7d201ba ) && isdefined( level.var_28c22d88 ) )
    {
        level.player flag::set( level.var_d7d201ba );
    }
    
    wait 3;
    level thread namespace_31c67f6d::function_82743d25( level.var_f5552371, 1 );
    level function_3812af3b();
    level function_5091c7b2();
    level function_5e48631f();
    level function_92141ec2();
    level function_8c5e0f4f();
    level function_3c0e1eab();
    level function_b96d7941();
    level function_4f7ea045();
    level function_af645aa();
    level function_49bbba06();
    level function_47f7d061();
    level scene::play( "scene_hub_post_prisoner_dialog", "dt_04_exit", level.var_58ccee4 );
    level function_8c6c6957();
    level thread scene::play( "scene_hub_post_prisoner_dialog", "dt_04_waiting_idle" );
    level function_5a2663f4();
    level function_855165f7();
    level function_96eb5464();
    wait 10;
    level.player scene::stop( "scene_hub_post_prisoner_dialog" );
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 0
// Checksum 0x37af38e, Offset: 0x11f0
// Size: 0x34
function function_474dc7d3()
{
    level thread scene::init( "scene_hub_post_prisoner_dialog", "dt_01_waiting_idle", level.var_58ccee4 );
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 3
// Checksum 0x8458f979, Offset: 0x1230
// Size: 0xc4
function function_79af8a52( str_shot_name, var_70c303e9, var_2ef4511b )
{
    if ( level.var_ea95c1e7 == "sims" && isdefined( var_2ef4511b ) )
    {
        level scene::play( "scene_hub_post_prisoner_dialog", var_2ef4511b, level.var_58ccee4 );
    }
    else
    {
        level scene::play( "scene_hub_post_prisoner_dialog", str_shot_name, level.var_58ccee4 );
    }
    
    level thread scene::play( "scene_hub_post_prisoner_dialog", var_70c303e9, level.var_58ccee4 );
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 0
// Checksum 0x5e646d74, Offset: 0x1300
// Size: 0xd4
function function_92141ec2()
{
    level thread namespace_31c67f6d::pstfx_teleport( 2, 1, 1 );
    wait 1;
    level.player districts::function_a7d79fcb( "airstrip", 1 );
    level flag::set( "af_player_start_ride" );
    level scene::stop( "scene_hub_post_prisoner_dialog" );
    function_b663575e();
    function_cbd66c4c();
    wait 1;
    level.player districts::function_a7d79fcb( "safehouse", 1 );
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 0
// Checksum 0xec933a9c, Offset: 0x13e0
// Size: 0x28
function function_b663575e()
{
    level.player = getplayers()[ 0 ];
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 0
// Checksum 0x8766f744, Offset: 0x1410
// Size: 0x314
function function_cbd66c4c()
{
    setsaveddvar( #"hash_7bf40e4b6a830d11", 0 );
    vehicle::add_spawn_function_group( "airport_truck_approach", "targetname", &function_78bc26d5 );
    vehicle::simple_spawn( "airport_truck_approach" );
    plane = function_5431431d();
    function_c8381339( plane, 0 );
    level thread function_5dd4ff85();
    thread function_f7c7ce51();
    vehicle::add_spawn_function_group( "af_intro_vehicle", "targetname", &function_78bc26d5 );
    level.player val::set( #"overlook", "ignoreme", 1 );
    guys = ai::array_spawn( "af_unloader_guy" );
    level music::setmusicstate( "b2.0_recon", undefined, 6 );
    level thread scene::play_from_time( "scene_hub_post_prisoner_flashback_overlook", "overlook_shot", [ level.arash, level.var_e2e0716f ] );
    level thread scene::play_from_time( "scene_tkd_hit3_intro_overlook", "overlook_shot", undefined );
    level thread scene::play_from_time( "scene_tkd_hit3_intro_overlook_enemy4", "overlook_shot", undefined );
    level thread util::delay( "play_b3.0_iced_mus", undefined, &music::function_edda155f, "b3.0_iced" );
    level thread util::delay( "play_b3.0_iced_mus", undefined, &music::setmusicstate, "b4.0_hold_fire" );
    level thread util::delay( "play_b4.1_identify_mus", undefined, &music::function_edda155f, "b4.1_identify" );
    wait 1;
    wait 53;
    level thread namespace_31c67f6d::pstfx_teleport( 5, 1, 1, 1 );
    level.player dialogue::radio( "vox_cp_sh8_00010_adlr_voweweretherewe_12" );
    wait 1;
    thread function_cd682321( guys, plane );
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 2
// Checksum 0xddcfe003, Offset: 0x1730
// Size: 0x18c
function function_cd682321( guys, plane )
{
    level thread scene::stop( "scene_tkd_hit3_intro_overlook_arash", 1 );
    level thread scene::stop( "scene_tkd_hit3_intro_overlook", 1 );
    level thread scene::stop( "scene_tkd_hit3_intro_overlook_enemy4", 1 );
    plane thread scene::stop( "scene_tkd_hit3_chase_plane", 1 );
    
    foreach ( guy in guys )
    {
        if ( isdefined( guy ) )
        {
            guy delete();
        }
    }
    
    if ( isdefined( plane ) )
    {
        plane delete();
    }
    
    if ( isdefined( level.arash ) )
    {
        level.arash delete();
    }
    
    if ( isdefined( level.var_e2e0716f ) )
    {
        level.var_e2e0716f delete();
    }
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 0
// Checksum 0xe733d0a5, Offset: 0x18c8
// Size: 0x2d0
function function_5431431d()
{
    plane = getent( "cargo_plane", "targetname" );
    plane notsolid();
    things = getentarray( "af_plane_triggers", "targetname" );
    things = arraycombine( things, getentarray( "plane_floor_clip", "targetname" ) );
    things = arraycombine( things, getentarray( "plane_cargo", "targetname" ) );
    
    foreach ( thing in things )
    {
        thing enablelinkto();
        thing linkto( plane, "tag_body_animate" );
    }
    
    plane function_8e4c996d();
    plane function_b6cccb8();
    scene::add_scene_func( "scene_tkd_hit3_chase_plane", &function_d804fc99, "init" );
    plane thread scene::init( "scene_tkd_hit3_chase_plane" );
    thread function_d60a1c78( plane );
    level.af_plane = plane;
    thread scene::init( "scene_tkd_hit3_intro_overlook_arash", [ level.af_plane ] );
    level.var_c7b3a621 = util::spawn_model( "tag_origin", plane.origin - ( 200, 0, 175 ), plane.angles );
    level.var_c7b3a621 linkto( plane );
    function_c8381339( plane, 1 );
    return plane;
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 2
// Checksum 0xd2551f57, Offset: 0x1ba0
// Size: 0x33c
function function_c8381339( plane, var_857b0901 )
{
    probe = getent( "cargo_probe_1", "targetname" );
    
    if ( isdefined( probe ) )
    {
        probe linkto( plane, "tag_body_animate", ( -24, 0, 24 ), ( 0, 0, 0 ) );
    }
    
    probe = getent( "cargo_probe_2", "targetname" );
    
    if ( isdefined( probe ) )
    {
        probe linkto( plane, "tag_body_animate", ( -152, 0, 24 ), ( 0, 0, 0 ) );
    }
    
    probe = getent( "cargo_probe_3", "targetname" );
    
    if ( isdefined( probe ) )
    {
        probe linkto( plane, "tag_body_animate", ( -288, 0, 24 ), ( 0, 0, 0 ) );
    }
    
    probe = getent( "cargo_probe_4", "targetname" );
    
    if ( isdefined( probe ) )
    {
        probe linkto( plane, "tag_body_animate", ( -408, 0, -40 ), ( 0, 0, 0 ) );
    }
    
    if ( var_857b0901 )
    {
        probe = getent( "cargo_probe_5", "targetname" );
        
        if ( isdefined( probe ) )
        {
            probe linkto( plane, "tag_body_animate", ( -72, 0, -88 ), ( 0, 0, 0 ) );
        }
        
        probe = getent( "cargo_probe_6", "targetname" );
        
        if ( isdefined( probe ) )
        {
            probe linkto( plane, "tag_body_animate", ( 72, 280, -48 ), ( 0, 0, 0 ) );
        }
        
        probe = getent( "cargo_probe_7", "targetname" );
        
        if ( isdefined( probe ) )
        {
            probe linkto( plane, "tag_body_animate", ( 72, -280, -48 ), ( 0, 0, 0 ) );
        }
        
        probe = getent( "cargo_probe_8", "targetname" );
        
        if ( isdefined( probe ) )
        {
            probe linkto( plane, "tag_body_animate", ( -664, 200, -40 ), ( 0, 0, 0 ) );
        }
        
        probe = getent( "cargo_probe_9", "targetname" );
        
        if ( isdefined( probe ) )
        {
            probe linkto( plane, "tag_body_animate", ( -664, -200, -40 ), ( 0, 0, 0 ) );
        }
    }
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 0
// Checksum 0xe6c081e4, Offset: 0x1ee8
// Size: 0x4c
function function_8e4c996d()
{
    if ( is_true( self.var_fd00d4f8 ) )
    {
        return;
    }
    
    self.var_fd00d4f8 = 1;
    self clientfield::set( "clf_cargoplane_landing_lights", 1 );
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 0
// Checksum 0xd70676f3, Offset: 0x1f40
// Size: 0x4c
function function_b6cccb8()
{
    if ( is_true( self.var_1b0a7080 ) )
    {
        return;
    }
    
    self.var_1b0a7080 = 1;
    self clientfield::set( "clf_cargoplane_nav_lights", 1 );
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 1
// Checksum 0xec020399, Offset: 0x1f98
// Size: 0x148
function function_d804fc99( a_ents )
{
    var_936fb5e7 = [ "Prop 1", "Prop 2", "Prop 3", "Prop 4" ];
    
    foreach ( prop in var_936fb5e7 )
    {
        if ( isdefined( a_ents[ prop ] ) && !isdefined( a_ents[ prop ].clip ) )
        {
            clip = getent( prop, "script_noteworthy" );
            a_ents[ prop ].clip = clip;
            clip linkto( a_ents[ prop ], undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
        }
    }
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 1
// Checksum 0x452d7df4, Offset: 0x20e8
// Size: 0x6c
function function_d60a1c78( plane )
{
    wait 0.2;
    level.plane_mover = util::spawn_model( "tag_origin", plane.origin, plane.angles );
    plane linkto( level.plane_mover, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 0
// Checksum 0x1f99e66f, Offset: 0x2160
// Size: 0x44
function function_5dd4ff85()
{
    level waittill( #"hash_59132013626fbab6" );
    level thread scene::play( "scene_tkd_hit3_intro_overlook_enemy4", "overlook_shot" );
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 0
// Checksum 0x49c50df6, Offset: 0x21b0
// Size: 0x28
function function_f7c7ce51()
{
    level.arash = ai::array_spawn( "arash" )[ 0 ];
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 0
// Checksum 0x56f86c10, Offset: 0x21e0
// Size: 0x40
function function_78bc26d5()
{
    self vehicle::lights_on();
    self vehicle::toggle_force_driver_taillights( 1 );
    level.var_e2e0716f = self;
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 0
// Checksum 0xe73a45d2, Offset: 0x2228
// Size: 0x7a
function function_8c5e0f4f()
{
    level thread namespace_31c67f6d::pstfx_teleport( 2, 1, 1 );
    wait 2;
    level function_55851873( #"hash_6a5da6573e9ec353" );
    level thread namespace_31c67f6d::pstfx_teleport( 2, 1, 1, 1 );
    wait 2;
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 0
// Checksum 0x5860c050, Offset: 0x22b0
// Size: 0xb2
function function_b96d7941()
{
    level thread namespace_31c67f6d::pstfx_teleport( 2, 1, 1 );
    wait 2;
    iprintlnbold( "Character Creation Scene" );
    level.player thread namespace_70eba6e6::function_5a4cb86d( 0 );
    function_80996e77();
    level notify( #"personnel_profile_closed" );
    level thread namespace_31c67f6d::pstfx_teleport( 2, 1, 1, 1 );
    wait 2;
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 0
// Checksum 0x2b1faec9, Offset: 0x2370
// Size: 0x5c
function function_80996e77()
{
    level.adler dialogue::queue( "vox_cp_sh8_00010_adlr_weneededtogivey_ee" );
    level.adler util::dialog_faction_vo( "vox_cp_sh8_00010_adlr_simsandibothwan_44", "vox_cp_sh8_00010_adlr_itwasparksideat_fd", "vox_cp_sh8_00010_adlr_hudsonthoughtwe_d6", "vox_cp_sh8_00010_adlr_intheendnospeci_e0" );
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 0
// Checksum 0x36678df4, Offset: 0x23d8
// Size: 0x92
function function_4f7ea045()
{
    level thread namespace_31c67f6d::pstfx_teleport( 2, 1, 1 );
    wait 2;
    level thread function_4af4a400();
    iprintlnbold( "Hacking Scene" );
    wait 7;
    level thread namespace_31c67f6d::pstfx_teleport( 2, 1, 1, 1 );
    wait 2;
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 0
// Checksum 0x4beeb872, Offset: 0x2478
// Size: 0x94
function function_4af4a400()
{
    level.adler dialogue::queue( "vox_cp_sh8_00010_adlr_andwewereableto_cd" );
    level.adler dialogue::queue( "vox_cp_sh8_00010_adlr_thebiggerchalle_b5" );
    str_vo = util::function_a1a0fe0c( "vox_cp_sh8_00010_park_theciasmkultrap_0b", "vox_cp_sh8_00010_lazr_youwereputthrou_53", "vox_cp_sh8_00010_sims_youwereaguineap_97" );
    level.adler dialogue::queue( str_vo );
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 0
// Checksum 0x28d36fec, Offset: 0x2518
// Size: 0x7a
function function_af645aa()
{
    level thread namespace_31c67f6d::pstfx_teleport( 2, 1, 1 );
    wait 2;
    level function_55851873( #"hash_75edbfa225f8353c" );
    level thread namespace_31c67f6d::pstfx_teleport( 2, 1, 1, 1 );
    wait 2;
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 0
// Checksum 0x769ff6f6, Offset: 0x25a0
// Size: 0x7c
function function_47f7d061()
{
    level thread namespace_31c67f6d::pstfx_teleport( 1, 1, 1 );
    wait 1;
    level function_55851873( #"hash_5d26a915f728a78e" );
    level thread namespace_31c67f6d::pstfx_teleport( 0.25, 1, 1, 1 );
    wait 0.25;
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 0
// Checksum 0x152eba14, Offset: 0x2628
// Size: 0x4c
function function_558f09c7()
{
    level.adler dialogue::queue( "vox_cp_sh8_00010_adlr_thetriggerphras_26" );
    wait 1;
    level.adler dialogue::queue( "vox_cp_sh8_00010_adlr_voyourinnermost_f7" );
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 0
// Checksum 0xbc1e9e31, Offset: 0x2680
// Size: 0x84
function function_8c6c6957()
{
    level thread namespace_31c67f6d::pstfx_teleport( 0.25, 1, 1 );
    wait 0.25;
    level function_55851873( #"hash_6d80efb68b8460d2" );
    level thread namespace_31c67f6d::pstfx_teleport( 0.25, 1, 1, 1 );
    wait 0.25;
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 0
// Checksum 0x4e81ad93, Offset: 0x2710
// Size: 0x24
function function_5a2663f4()
{
    level.adler dialogue::queue( "vox_cp_sh8_00010_adlr_bellirealizeyou_1e" );
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 0
// Checksum 0x9ad2ffb9, Offset: 0x2740
// Size: 0x82
function function_855165f7()
{
    level thread namespace_31c67f6d::pstfx_teleport( 0.25, 1, 1 );
    wait 0.25;
    level function_55851873( #"hash_1faa87a29a1517cb" );
    level thread namespace_31c67f6d::pstfx_teleport( 2, 1, 1, 1 );
    wait 2;
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 0
// Checksum 0x1c22d8a1, Offset: 0x27d0
// Size: 0x7c
function function_3812af3b()
{
    level thread function_1df6057e();
    level scene::play( "scene_hub_post_prisoner_dialog", "dt_01_enter", level.var_58ccee4 );
    level thread scene::play( "scene_hub_post_prisoner_dialog", "dt_01_waiting_idle", level.var_58ccee4 );
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 0
// Checksum 0x3f37c092, Offset: 0x2858
// Size: 0x1c
function function_1df6057e()
{
    level thread function_346c56e8();
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 0
// Checksum 0xe9d2e5fe, Offset: 0x2880
// Size: 0x54
function function_346c56e8()
{
    str_vo = util::function_3ac6fa36( "vox_cp_sh8_00010_sims_hescomingto_e9", "vox_cp_sh8_00010_sims_shescomingto_5c", "vox_cp_sh8_00010_sims_theyrecomingto_3a" );
    level.adler dialogue::queue( str_vo );
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 0
// Checksum 0xfeebdbd, Offset: 0x28e0
// Size: 0x11c
function function_5091c7b2()
{
    waitframe( 1 );
    level thread scene::play( "scene_hub_post_prisoner_dialog", "dt_01_waiting_idle", level.var_58ccee4 );
    level.adler.var_dfbbd0a = dialog_tree::new_tree();
    level.adler.var_dfbbd0a dialog_tree::add_option( #"hash_14ea8d0dbbc54b93", "vox_cp_sh8_00010_adlr_youredisoriente_a3", "dt_01_1a", "dt_01_waiting_idle", 1 );
    level.adler.var_dfbbd0a dialog_tree::add_option( #"hash_14f4bd0dbbcdf1a8", "vox_cp_sh8_00010_adlr_whatyouregoingt_0c", "dt_01_2a", "dt_01_waiting_idle", 1 );
    level.adler.var_dfbbd0a dialog_tree::run( level.adler );
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 0
// Checksum 0xbf249870, Offset: 0x2a08
// Size: 0x1a4
function function_5e48631f()
{
    level thread scene::play( "scene_hub_post_prisoner_dialog", "dt_01_waiting_idle", level.var_58ccee4 );
    level.adler.var_fc421997 = dialog_tree::new_tree();
    level.adler.var_fc421997 dialog_tree::add_option( #"hash_54b2eb15279dd690", "vox_cp_sh8_00010_adlr_bullshitiswhaty_fa", "dt_02_1a", "dt_01_waiting_idle" );
    level.adler.var_fc421997 dialog_tree::add_option( #"hash_54a8fb1527959d3b", undefined, "dt_02_2a", "dt_03_waiting_idle", 1, undefined, undefined, &function_9841c802 );
    level.adler.var_fc421997 dialog_tree::add_option( #"hash_54abdf152797a37e", undefined, "dt_02_3a", "dt_03_waiting_idle", 1, undefined, undefined, &function_63ec9e09 );
    level.adler.var_fc421997 dialog_tree::run( level.adler );
    level thread scene::play( "scene_hub_post_prisoner_dialog", "dt_03_waiting_idle", level.var_58ccee4 );
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 0
// Checksum 0x7276feac, Offset: 0x2bb8
// Size: 0x34
function function_9841c802()
{
    level function_79af8a52( "dt_02_2a", "dt_03_waiting_idle", "dt_02_3a_alt_survivor" );
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 0
// Checksum 0x873efa4b, Offset: 0x2bf8
// Size: 0x34
function function_63ec9e09()
{
    level function_79af8a52( "dt_02_3a", "dt_03_waiting_idle", "dt_02_3a_alt_survivor" );
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 0
// Checksum 0xe3373f6d, Offset: 0x2c38
// Size: 0x17c
function function_3c0e1eab()
{
    level thread scene::play( "scene_hub_post_prisoner_dialog", "dt_03_waiting_idle", level.var_58ccee4 );
    level function_79af8a52( "dt_03_enter", "dt_03_waiting_idle" );
    level.adler.var_eae6f6e1 = dialog_tree::new_tree();
    level.adler.var_eae6f6e1 dialog_tree::add_option( #"hash_72bc6a5ab99e461d", undefined, "dt_03_part1", "waiting_idle_02", 1, undefined, undefined, &function_10970dd9 );
    level.adler.var_eae6f6e1 dialog_tree::add_option( #"hash_72b8825ab99a860e", undefined, "dt_03_part1", "waiting_idle_02", 1, undefined, undefined, &function_10970dd9 );
    level.adler.var_eae6f6e1 dialog_tree::run( level.adler );
    level thread scene::play( "scene_hub_post_prisoner_dialog", "dt_04_waiting_idle" );
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 0
// Checksum 0x8e640a87, Offset: 0x2dc0
// Size: 0x5c
function function_10970dd9()
{
    level scene::play( "scene_hub_post_prisoner_dialog", "dt_03_part1" );
    level function_79af8a52( "dt_03_part2", "dt_04_waiting_idle", "dt_03_part2_alt_survivor" );
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 0
// Checksum 0x954fcffb, Offset: 0x2e28
// Size: 0x25c
function function_49bbba06()
{
    level thread scene::play( "scene_hub_post_prisoner_dialog", "dt_04_waiting_idle" );
    level.adler.var_d924535c = dialog_tree::new_tree();
    level.adler.var_d924535c dialog_tree::add_option( #"hash_4543be1afb05e83a", "vox_cp_sh8_00010_adlr_areyourhandscle_62", "dt_04_1a", "waiting_idle_02", 0, undefined, undefined );
    level.adler.var_d924535c dialog_tree::add_option( #"hash_4546a61afb07f549", "vox_cp_sh8_00010_adlr_nocountyourself_2c", "dt_04_2a", "waiting_idle_02", 0, undefined, undefined );
    level.adler.var_d924535c.var_2fad984e = level.adler.var_d924535c dialog_tree::add_option( #"hash_454a8a1afb0bae8c", "vox_cp_sh8_00010_adlr_interrogationdi_d1", "dt_04_3a", "waiting_idle_02", 0, undefined, undefined );
    level.adler.var_d924535c dialog_tree::function_ad98a815( level.adler.var_d924535c.var_2fad984e, #"hash_454a8d1afb0bb3a5", undefined, "dt_04_3b", "waiting_idle_02", 1, undefined, undefined, &function_22e051e5 );
    level.adler.var_d924535c dialog_tree::function_ad98a815( level.adler.var_d924535c.var_2fad984e, #"hash_4532821afaf70f13", undefined, "dt_04_4a", "waiting_idle_02", 1, undefined, undefined, &function_2be2cbf6 );
    level.adler.var_d924535c dialog_tree::run( level.adler );
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 0
// Checksum 0x1648836c, Offset: 0x3090
// Size: 0x34
function function_22e051e5()
{
    level scene::play( "scene_hub_post_prisoner_dialog", "dt_04_3b", level.var_58ccee4 );
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 0
// Checksum 0x9221f3b2, Offset: 0x30d0
// Size: 0x34
function function_2be2cbf6()
{
    level scene::play( "scene_hub_post_prisoner_dialog", "dt_04_4a", level.var_58ccee4 );
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 0
// Checksum 0xbea6d3ae, Offset: 0x3110
// Size: 0x1e4
function function_96eb5464()
{
    level scene::play( "scene_hub_post_prisoner_dialog", "dt_05_enter" );
    level thread scene::play( "scene_hub_post_prisoner_dialog", "dt_05_waiting_idle" );
    var_b688fbdc = struct::get( "hint_projector_remote", "targetname" );
    level.var_5538ea31 = util::spawn_model( "tag_origin", var_b688fbdc.origin, var_b688fbdc.angles );
    level.adler.var_5900d313 = dialog_tree::new_tree();
    level.adler.var_5900d313 dialog_tree::add_option( #"hash_52b14f9f73548cd5", "vox_cp_sh8_00010_adlr_solovetsky_cd", "dt_05_1a", "dt_05_exit", 1, undefined, "forever", &function_46d26798 );
    level.adler.var_5900d313 dialog_tree::add_option( #"hash_6bbcd96077b1429a", "vox_cp_sh8_00010_adlr_duga_0b", "dt_05_2a", "dt_05_exit", 1, undefined, "forever", &function_f1eacff2 );
    level.adler.var_5900d313 dialog_tree::run( level.adler );
    level thread function_79af8a52( "dt_05_exit", "zone_idle" );
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 0
// Checksum 0x63d8b351, Offset: 0x3300
// Size: 0x24
function function_dd297dbc()
{
    level.adler dialogue::queue( "vox_cp_sh8_00010_adlr_thisisyourchanc_78" );
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 0
// Checksum 0x189aa345, Offset: 0x3330
// Size: 0x44
function function_a6771058()
{
    level.adler dialogue::queue( "vox_cp_sh8_00010_adlr_simsgetwashingt_5a" );
    level.adler dialogue::queue( "vox_cp_sh8_00010_adlr_youmadetheright_ea" );
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 0
// Checksum 0xc55c8438, Offset: 0x3380
// Size: 0x24
function function_46d26798()
{
    level flag::set( "flag_post_prisoner_truth" );
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 0
// Checksum 0x87cc2aa0, Offset: 0x33b0
// Size: 0x24
function function_f1eacff2()
{
    level flag::set( "flag_post_prisoner_lie" );
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 0
// Checksum 0x9ffd3b59, Offset: 0x33e0
// Size: 0x34
function function_dbf5481b()
{
    level thread namespace_4ed3ce47::function_849d7772();
    level thread namespace_4ed3ce47::function_dd79396d();
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 1
// Checksum 0xd2fe2e0f, Offset: 0x3420
// Size: 0x74
function function_c649acda( *var_d3440450 )
{
    level thread scene::play( "scene_hub_post_prisoner_dialog", "zone_idle" );
    level thread namespace_31c67f6d::function_b0558ba2( "8" );
    level flag::set( "flag_post_prisoner_lie" );
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 1
// Checksum 0xbdeccd29, Offset: 0x34a0
// Size: 0x34
function function_55851873( str_scene_name )
{
    level lui::play_movie( str_scene_name, "fullscreen", 0, 0, 1 );
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 1
// Checksum 0x240a37dc, Offset: 0x34e0
// Size: 0x74
function function_6be7ec40( *var_d3440450 )
{
    level thread scene::play( "scene_hub_post_prisoner_dialog", "zone_idle" );
    level thread namespace_31c67f6d::function_b0558ba2( "8" );
    level flag::set( "flag_post_prisoner_truth" );
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 2
// Checksum 0x6684ec43, Offset: 0x3560
// Size: 0xc4
function function_82c37b22( var_d3440450, *var_50cc0d4f )
{
    while ( !isdefined( level.player_connected ) && level.player_connected != 1 )
    {
        waitframe( 1 );
    }
    
    if ( isdefined( level.var_d7d201ba ) && isdefined( level.var_28c22d88 ) )
    {
        level.player flag::set( level.var_d7d201ba );
    }
    
    level function_d6d3bd92();
    
    if ( isdefined( var_50cc0d4f ) )
    {
        skipto::function_4e3ab877( var_50cc0d4f );
    }
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 0
// Checksum 0xcd319189, Offset: 0x3630
// Size: 0xc4
function function_d6d3bd92()
{
    if ( level flag::get( "flag_post_prisoner_truth" ) )
    {
        wait 5;
        skipto::function_1c2dfc20( "cp_rus_siege" );
        return;
    }
    
    if ( level flag::get( "flag_post_prisoner_lie" ) )
    {
        wait 1;
        level thread function_af3dcba6();
        flag::wait_till_all_timeout( 30, array( "flag_post_prisoner_radio" ) );
        skipto::function_1c2dfc20( "cp_rus_duga" );
    }
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 0
// Checksum 0x924dbb78, Offset: 0x3700
// Size: 0x184
function function_af3dcba6()
{
    struct = struct::get( "struct_obj_radio", "targetname" );
    objectives::goto( "radio_objective", struct.origin + ( 0, 0, 8 ), #"hash_6d27d69a4d24a684", 1 );
    objectives::function_67f87f80( "radio_objective", undefined, #"hash_696adfeed5b67f39" );
    tag = spawn( "script_model", struct.origin );
    tag setmodel( "tag_origin" );
    tag util::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), #"hash_696adfeed5b67f39" );
    tag waittill( #"trigger" );
    objectives::complete( "radio_objective" );
    level.player namespace_70eba6e6::function_cde4f4e9( 1 );
    wait 1;
    flag::set( "flag_post_prisoner_radio" );
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 2
// Checksum 0x8be291d6, Offset: 0x3890
// Size: 0x14
function start_timer( *n_seconds, *str_label )
{
    
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 0
// Checksum 0x80f724d1, Offset: 0x38b0
// Size: 0x4
function stop_timer()
{
    
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 1
// Checksum 0x285123fb, Offset: 0x38c0
// Size: 0xc
function function_fb10b77d( *var_d3440450 )
{
    
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 2
// Checksum 0x6a89bf95, Offset: 0x38d8
// Size: 0x11c
function function_cbf93ca7( *var_d3440450, *var_50cc0d4f )
{
    level thread namespace_31c67f6d::function_b0558ba2( "1" );
    
    while ( !isdefined( level.player_connected ) && level.player_connected != 1 )
    {
        waitframe( 1 );
    }
    
    if ( isdefined( level.var_d7d201ba ) && isdefined( level.var_28c22d88 ) )
    {
        level.player flag::set( level.var_d7d201ba );
    }
    
    setlightingstate( 1 );
    animation::add_notetrack_func( "hub_post_prisoner::burn_pstfx", &function_95b1e0d9 );
    scene::play( "scene_hub_safehouse_burns" );
    level waittill( #"forever" );
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 1
// Checksum 0x253d1d91, Offset: 0x3a00
// Size: 0x34
function function_95b1e0d9( *player )
{
    level.player clientfield::set_to_player( "clf_pstfx_burn_safehouse", 1 );
}

// Namespace namespace_fdde5f3d/namespace_db1ba63f
// Params 4
// Checksum 0xdf8313f, Offset: 0x3a40
// Size: 0x24
function function_6bb0fd28( *str_objective, *var_50cc0d4f, *var_aa1a6455, *player )
{
    
}

