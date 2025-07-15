#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_ramses2_fx;
#using scripts/cp/cp_mi_cairo_ramses2_sound;
#using scripts/cp/cp_mi_cairo_ramses_arena_defend;
#using scripts/cp/cp_mi_cairo_ramses_utility;
#using scripts/shared/array_shared;
#using scripts/shared/beam_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicles/_quadtank;

#namespace cp_mi_cairo_ramses2;

// Namespace cp_mi_cairo_ramses2
// Params 0
// Checksum 0x85bea829, Offset: 0xc18
// Size: 0x2c2
function main()
{
    util::set_streamer_hint_function( &force_streamer, 5 );
    init_clientfields();
    scene::add_scene_func( "p7_fxanim_cp_ramses_lotus_towers_hunters_01_bundle", &dead_system_laser1, "play" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_lotus_towers_hunters_02_bundle", &dead_system_laser2, "play" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_lotus_towers_hunters_02_bundle", &dead_system_laser2b, "play" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_lotus_towers_hunters_03_bundle", &dead_system_laser3, "play" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_lotus_towers_hunters_04_bundle", &dead_system_laser4, "play" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_lotus_towers_hunters_05_bundle", &dead_system_laser5, "play" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_lotus_towers_hunters_06_bundle", &dead_system_laser6, "play" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_lotus_towers_hunters_07_bundle", &dead_system_laser7, "play" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_lotus_towers_hunters_08_bundle", &dead_system_laser8, "play" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_qt_plaza_palace_wall_collapse_bundle", &qt2_intro_dead_beams, "play" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_lotus_towers_hunters_07_vtol_igc_bundle", &dead_system_laser_vtol_igc, "play" );
    cp_mi_cairo_ramses2_fx::main();
    cp_mi_cairo_ramses2_sound::main();
    load::main();
    level.var_10d89562 = findstaticmodelindexarray( "destroyed_interior" );
    level.var_c6e7f081 = findstaticmodelindexarray( "mobile_wall_sidewalk_smash_after" );
    util::waitforclient( 0 );
}

// Namespace cp_mi_cairo_ramses2
// Params 0
// Checksum 0x6df2186a, Offset: 0xee8
// Size: 0x26a
function init_clientfields()
{
    clientfield::register( "toplayer", "player_spike_plant_postfx", 1, 1, "counter", &player_spike_plant_postfx, 0, 0 );
    clientfield::register( "world", "alley_fog_banks", 1, 1, "int", &alley_fog_banks, 0, 0 );
    clientfield::register( "world", "arena_defend_fxanim_hunters", 1, 1, "int", &arena_defend_fxanim_hunters, 0, 0 );
    clientfield::register( "world", "alley_fxanim_hunters", 1, 1, "int", &alley_fxanim_hunters, 0, 0 );
    clientfield::register( "world", "alley_fxanim_curtains", 1, 1, "int", &alley_fxanim_curtains, 0, 0 );
    clientfield::register( "world", "vtol_igc_fxanim_hunter", 1, 1, "int", &vtol_igc_fxanim_hunters, 0, 0 );
    clientfield::register( "world", "qt_plaza_fxanim_hunters", 1, 1, "int", &qt_plaza_fxanim_hunters, 0, 0 );
    clientfield::register( "world", "theater_fxanim_swap", 1, 1, "int", &theater_fxanim_swap, 0, 0 );
    clientfield::register( "world", "qt_plaza_outro_exposure", 1, 1, "int", &set_exposure_for_qt_plaza_outro, 0, 0 );
    clientfield::register( "world", "arena_defend_mobile_wall_damage", 1, 1, "int", &miscmodel_mobile_wall_damage, 0, 0 );
    clientfield::register( "world", "hide_statue_rubble", 1, 1, "int", &hide_statue_rubble, 0, 0 );
}

// Namespace cp_mi_cairo_ramses2
// Params 1
// Checksum 0x11cbd0ee, Offset: 0x1160
// Size: 0x23d
function force_streamer( n_zone )
{
    switch ( n_zone )
    {
        case 1:
            loadsiegeanim( "p7_fxanim_gp_drone_hunter_swarm_large_sanim" );
            break;
        case 2:
            forcestreamxmodel( "c_hro_khalil_egypt_fb" );
            break;
        case 3:
            loadsiegeanim( "p7_fxanim_gp_drone_hunter_swarm_large_sanim" );
            break;
        case 4:
            forcestreamxmodel( "c_hro_hendricks_egypt_body" );
            forcestreamxmodel( "c_hro_hendricks_egypt_head" );
            forcestreamxmodel( "c_hro_khalil_egypt_fb" );
            forcestreamxmodel( "p7_cai_door_metal_rustic_03_a_l" );
            forcestreamxmodel( "p7_fxanim_cp_ramses_quadtank_statue_static2_mod" );
            forcestreamxmodel( "c_ega_soldier_1_body" );
            forcestreamxmodel( "c_ega_soldier_2_body" );
            forcestreamxmodel( "c_ega_soldier_2_head" );
            forcestreamxmodel( "c_ega_soldier_3_body" );
            forcestreamxmodel( "c_ega_soldier_3_head" );
            forcestreamxmodel( "c_nrc_assault_body" );
            forcestreamxmodel( "c_nrc_assault_head" );
            forcestreambundle( "cin_ram_08_gettofreeway_3rd_sh010" );
            forcestreambundle( "cin_ram_08_gettofreeway_3rd_sh020" );
            forcestreambundle( "cin_ram_08_gettofreeway_3rd_sh030" );
            loadsiegeanim( "p7_fxanim_gp_drone_hunter_swarm_large_sanim" );
            forcestreambundle( "cin_ram_08_gettofreeway_3rd_sh040" );
            break;
        case 5:
            loadsiegeanim( "p7_fxanim_gp_drone_hunter_swarm_large_sanim" );
            break;
    }
}

// Namespace cp_mi_cairo_ramses2
// Params 1
// Checksum 0x37ffcdf2, Offset: 0x13a8
// Size: 0xba
function dead_system_laser1( a_ents )
{
    a_ents[ "hunter" ] waittillmatch( #"_anim_notify_", "hunter01_hit_by_dead" );
    level beam::launch( a_ents[ "hunter" ], "tag_fx_jnt", a_ents[ "hunter" ], "drone_01_link_jnt", "dead_turret_beam" );
    a_ents[ "hunter" ] waittillmatch( #"_anim_notify_", "hunter01_explodes" );
    level beam::kill( a_ents[ "hunter" ], "tag_fx_jnt", a_ents[ "hunter" ], "drone_01_link_jnt", "dead_turret_beam" );
}

// Namespace cp_mi_cairo_ramses2
// Params 1
// Checksum 0x85b8b0ef, Offset: 0x1470
// Size: 0xba
function dead_system_laser2( a_ents )
{
    a_ents[ "hunter" ] waittillmatch( #"_anim_notify_", "hunter02_hit_by_dead" );
    level beam::launch( a_ents[ "hunter" ], "tag_fx_jnt", a_ents[ "hunter" ], "drone_02_link_jnt", "dead_turret_beam" );
    a_ents[ "hunter" ] waittillmatch( #"_anim_notify_", "hutner02_explodes" );
    level beam::kill( a_ents[ "hunter" ], "tag_fx_jnt", a_ents[ "hunter" ], "drone_02_link_jnt", "dead_turret_beam" );
}

// Namespace cp_mi_cairo_ramses2
// Params 1
// Checksum 0xbeb8d034, Offset: 0x1538
// Size: 0xba
function dead_system_laser2b( a_ents )
{
    a_ents[ "hunter" ] waittillmatch( #"_anim_notify_", "hunter02_b_hit_by_dead" );
    level beam::launch( a_ents[ "hunter" ], "tag_fx_b_jnt", a_ents[ "hunter" ], "drone_02_b_link_jnt", "dead_turret_beam" );
    a_ents[ "hunter" ] waittillmatch( #"_anim_notify_", "hunter02_b_explodes" );
    level beam::kill( a_ents[ "hunter" ], "tag_fx_b_jnt", a_ents[ "hunter" ], "drone_02_b_link_jnt", "dead_turret_beam" );
}

// Namespace cp_mi_cairo_ramses2
// Params 1
// Checksum 0xdf942ab5, Offset: 0x1600
// Size: 0xba
function dead_system_laser3( a_ents )
{
    a_ents[ "hunter" ] waittillmatch( #"_anim_notify_", "hunter03_hit_by_dead" );
    level beam::launch( a_ents[ "hunter" ], "tag_fx_jnt", a_ents[ "hunter" ], "drone_03_link_jnt", "dead_turret_beam" );
    a_ents[ "hunter" ] waittillmatch( #"_anim_notify_", "hunter03_explodes" );
    level beam::kill( a_ents[ "hunter" ], "tag_fx_jnt", a_ents[ "hunter" ], "drone_03_link_jnt", "dead_turret_beam" );
}

// Namespace cp_mi_cairo_ramses2
// Params 1
// Checksum 0x3970eaf7, Offset: 0x16c8
// Size: 0xba
function dead_system_laser4( a_ents )
{
    a_ents[ "hunter" ] waittillmatch( #"_anim_notify_", "hunter04_hit_by_dead" );
    level beam::launch( a_ents[ "hunter" ], "tag_fx_jnt", a_ents[ "hunter" ], "drone_04_link_jnt", "dead_turret_beam" );
    a_ents[ "hunter" ] waittillmatch( #"_anim_notify_", "hunter04_explodes" );
    level beam::kill( a_ents[ "hunter" ], "tag_fx_jnt", a_ents[ "hunter" ], "drone_04_link_jnt", "dead_turret_beam" );
}

// Namespace cp_mi_cairo_ramses2
// Params 1
// Checksum 0xf0a6bea2, Offset: 0x1790
// Size: 0xba
function dead_system_laser5( a_ents )
{
    a_ents[ "hunter" ] waittillmatch( #"_anim_notify_", "hunter05_hit_by_dead" );
    level beam::launch( a_ents[ "hunter" ], "tag_fx_jnt", a_ents[ "hunter" ], "drone_05_link_jnt", "dead_turret_beam" );
    a_ents[ "hunter" ] waittillmatch( #"_anim_notify_", "hunter05_explodes" );
    level beam::kill( a_ents[ "hunter" ], "tag_fx_jnt", a_ents[ "hunter" ], "drone_05_link_jnt", "dead_turret_beam" );
}

// Namespace cp_mi_cairo_ramses2
// Params 1
// Checksum 0xee92caef, Offset: 0x1858
// Size: 0xba
function dead_system_laser6( a_ents )
{
    a_ents[ "turret" ] waittillmatch( #"_anim_notify_", "hunter06_hit_by_dead" );
    level beam::launch( a_ents[ "turret" ], "tag_fx_01_jnt", a_ents[ "hunter" ], "tag_body", "dead_turret_beam" );
    a_ents[ "turret" ] waittillmatch( #"_anim_notify_", "hunter06_explodes" );
    level beam::kill( a_ents[ "turret" ], "tag_fx_01_jnt", a_ents[ "hunter" ], "tag_body", "dead_turret_beam" );
}

// Namespace cp_mi_cairo_ramses2
// Params 1
// Checksum 0x54bd927f, Offset: 0x1920
// Size: 0xba
function dead_system_laser7( a_ents )
{
    a_ents[ "turret" ] waittillmatch( #"_anim_notify_", "hunter07_hit_by_dead" );
    level beam::launch( a_ents[ "turret" ], "tag_fx_01_jnt", a_ents[ "hunter" ], "tag_body", "dead_turret_beam" );
    a_ents[ "turret" ] waittillmatch( #"_anim_notify_", "hunter07_explodes" );
    level beam::kill( a_ents[ "turret" ], "tag_fx_01_jnt", a_ents[ "hunter" ], "tag_body", "dead_turret_beam" );
}

// Namespace cp_mi_cairo_ramses2
// Params 1
// Checksum 0xc8b465de, Offset: 0x19e8
// Size: 0xba
function dead_system_laser8( a_ents )
{
    a_ents[ "turret" ] waittillmatch( #"_anim_notify_", "hunter08_hit_by_dead" );
    level beam::launch( a_ents[ "turret" ], "tag_fx_01_jnt", a_ents[ "hunter" ], "tag_body", "dead_turret_beam" );
    a_ents[ "turret" ] waittillmatch( #"_anim_notify_", "hunter08_explodes" );
    level beam::kill( a_ents[ "turret" ], "tag_fx_01_jnt", a_ents[ "hunter" ], "tag_body", "dead_turret_beam" );
}

// Namespace cp_mi_cairo_ramses2
// Params 1
// Checksum 0xc9d0112, Offset: 0x1ab0
// Size: 0xba
function qt2_intro_dead_beams( a_ents )
{
    e_vtol = a_ents[ "qt_plaza_palace_wall_vtol" ];
    a_ents[ "turret_palace_wall_collapse" ] waittillmatch( #"_anim_notify_", "vtol_hit_by_dead" );
    level beam::launch( a_ents[ "turret_palace_wall_collapse" ], "tag_fx_01_jnt", e_vtol, "tag_origin", "dead_turret_beam" );
    a_ents[ "turret_palace_wall_collapse" ] waittillmatch( #"_anim_notify_", "vtol_explodes" );
    level beam::kill( a_ents[ "turret_palace_wall_collapse" ], "tag_fx_01_jnt", e_vtol, "tag_origin", "dead_turret_beam" );
}

// Namespace cp_mi_cairo_ramses2
// Params 1
// Checksum 0x2d1b6054, Offset: 0x1b78
// Size: 0xba
function dead_system_laser_vtol_igc( a_ents )
{
    a_ents[ "turret_vtol_igc" ] waittillmatch( #"_anim_notify_", "hunter07_vtol_igc_hit_by_dead" );
    level beam::launch( a_ents[ "turret_vtol_igc" ], "tag_fx_01_jnt", a_ents[ "hunter" ], "tag_body", "dead_turret_beam" );
    a_ents[ "turret_vtol_igc" ] waittillmatch( #"_anim_notify_", "hunter07_vtol_igc_explodes" );
    level beam::kill( a_ents[ "turret_vtol_igc" ], "tag_fx_01_jnt", a_ents[ "hunter" ], "tag_body", "dead_turret_beam" );
}

// Namespace cp_mi_cairo_ramses2
// Params 7
// Checksum 0x32604ec2, Offset: 0x1c40
// Size: 0x5f
function arena_defend_fxanim_hunters( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        level thread play_arena_defend_fx_anim_hunters();
        return;
    }
    
    level notify( #"stop_arena_defend_fxanim_hunters" );
}

// Namespace cp_mi_cairo_ramses2
// Params 0
// Checksum 0xffc2d1f6, Offset: 0x1ca8
// Size: 0xad
function play_arena_defend_fx_anim_hunters()
{
    level endon( #"stop_arena_defend_fxanim_hunters" );
    level thread hunters_peel_off();
    
    while ( true )
    {
        wait randomfloatrange( 1, 3 );
        
        while ( true )
        {
            n_fxanim = randomintrange( 1, 6 );
            
            if ( !scene::is_playing( "p7_fxanim_cp_ramses_lotus_towers_hunters_0" + n_fxanim + "_bundle" ) )
            {
                break;
            }
            
            wait 0.1;
        }
        
        level thread scene::play( "p7_fxanim_cp_ramses_lotus_towers_hunters_0" + n_fxanim + "_bundle" );
    }
}

// Namespace cp_mi_cairo_ramses2
// Params 0
// Checksum 0xb14531b2, Offset: 0x1d60
// Size: 0x11d
function hunters_peel_off()
{
    level endon( #"stop_arena_defend_fxanim_hunters" );
    
    while ( true )
    {
        wait randomfloatrange( 1, 3 );
        
        while ( true )
        {
            n_fxanim = randomintrange( 1, 5 );
            
            if ( n_fxanim == 4 )
            {
                if ( !scene::is_playing( "p7_fxanim_cp_ramses_lotus_towers_hunters_peel_off_01_bundle" ) && !scene::is_playing( "p7_fxanim_cp_ramses_lotus_towers_hunters_peel_off_02_bundle" ) )
                {
                    break;
                }
            }
            else if ( !scene::is_playing( "p7_fxanim_cp_ramses_lotus_towers_hunters_peel_off_0" + n_fxanim + "_bundle" ) )
            {
                break;
            }
            
            wait 0.05;
        }
        
        if ( n_fxanim == 4 )
        {
            level thread scene::play( "p7_fxanim_cp_ramses_lotus_towers_hunters_peel_off_01_bundle" );
            scene::play( "p7_fxanim_cp_ramses_lotus_towers_hunters_peel_off_02_bundle" );
            continue;
        }
        
        scene::play( "p7_fxanim_cp_ramses_lotus_towers_hunters_0" + n_fxanim + "_bundle" );
    }
}

// Namespace cp_mi_cairo_ramses2
// Params 7
// Checksum 0x950eae07, Offset: 0x1e88
// Size: 0x5f
function alley_fxanim_hunters( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        level thread play_alley_fx_anim_hunters();
        return;
    }
    
    level notify( #"stop_alley_fxanim_hunters" );
}

// Namespace cp_mi_cairo_ramses2
// Params 0
// Checksum 0xef44f8d3, Offset: 0x1ef0
// Size: 0xa5
function play_alley_fx_anim_hunters()
{
    level endon( #"stop_alley_fxanim_hunters" );
    
    while ( true )
    {
        wait randomfloatrange( 5, 10 );
        
        while ( true )
        {
            n_fxanim = randomintrange( 6, 9 );
            
            if ( !scene::is_playing( "p7_fxanim_cp_ramses_lotus_towers_hunters_0" + n_fxanim + "_bundle" ) )
            {
                break;
            }
            
            wait 0.1;
        }
        
        level thread scene::play( "p7_fxanim_cp_ramses_lotus_towers_hunters_0" + n_fxanim + "_bundle" );
    }
}

// Namespace cp_mi_cairo_ramses2
// Params 7
// Checksum 0x7c7a4f1c, Offset: 0x1fa0
// Size: 0xda
function alley_fxanim_curtains( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        level thread scene::play( "p7_fxanim_gp_curtain_torn_center_01_s3_bundle" );
        level thread scene::play( "p7_fxanim_gp_curtain_torn_left_01_s3_bundle" );
        level thread scene::play( "p7_fxanim_gp_curtain_torn_right_01_s3_bundle" );
        return;
    }
    
    if ( newval == 0 )
    {
        level thread scene::stop( "p7_fxanim_gp_curtain_torn_center_01_s3_bundle", 1 );
        level thread scene::stop( "p7_fxanim_gp_curtain_torn_left_01_s3_bundle", 1 );
        level thread scene::stop( "p7_fxanim_gp_curtain_torn_right_01_s3_bundle", 1 );
    }
}

// Namespace cp_mi_cairo_ramses2
// Params 7
// Checksum 0x175aa5ba, Offset: 0x2088
// Size: 0x8a
function vtol_igc_fxanim_hunters( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        s_fxanim = struct::get( "vtol_igc_fxanim_hunter", "targetname" );
        s_fxanim scene::play();
        s_fxanim scene::stop( 1 );
    }
}

// Namespace cp_mi_cairo_ramses2
// Params 7
// Checksum 0x131efa95, Offset: 0x2120
// Size: 0x5f
function qt_plaza_fxanim_hunters( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        level thread play_qt_plaza_fx_anim_hunters();
        return;
    }
    
    level notify( #"stop_qt_plaza_fxanim_hunters" );
}

// Namespace cp_mi_cairo_ramses2
// Params 0
// Checksum 0x5748c48b, Offset: 0x2188
// Size: 0xb5
function play_qt_plaza_fx_anim_hunters()
{
    level endon( #"stop_qt_plaza_fxanim_hunters" );
    a_s_fxanim = struct::get_array( "qt_plaza_hunters", "targetname" );
    
    while ( true )
    {
        wait randomfloatrange( 5, 10 );
        
        while ( true )
        {
            s_fxanim = array::random( a_s_fxanim );
            
            if ( !s_fxanim scene::is_playing() )
            {
                break;
            }
            
            wait 0.05;
        }
        
        s_fxanim scene::play();
    }
}

// Namespace cp_mi_cairo_ramses2
// Params 7
// Checksum 0xe89e951f, Offset: 0x2248
// Size: 0x13b
function theater_fxanim_swap( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    assert( isdefined( level.var_10d89562 ), "<dev string:x28>" );
    
    if ( newval == 1 )
    {
        foreach ( i, model in level.var_10d89562 )
        {
            hidestaticmodel( model );
            
            if ( i % 25 == 0 )
            {
                wait 0.016;
            }
        }
        
        return;
    }
    
    foreach ( model in level.var_10d89562 )
    {
        unhidestaticmodel( model );
    }
}

// Namespace cp_mi_cairo_ramses2
// Params 7
// Checksum 0x50af029e, Offset: 0x2390
// Size: 0x82
function player_spike_plant_postfx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        self thread postfx::playpostfxbundle( "pstfx_dust_chalk" );
        self thread postfx::playpostfxbundle( "pstfx_dust_concrete" );
        return;
    }
    
    self thread postfx::stoppostfxbundle();
}

// Namespace cp_mi_cairo_ramses2
// Params 7
// Checksum 0x29836de9, Offset: 0x2420
// Size: 0x5a
function set_exposure_for_qt_plaza_outro( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        setexposureactivebank( localclientnum, 2 );
    }
}

// Namespace cp_mi_cairo_ramses2
// Params 7
// Checksum 0xafd1c1e8, Offset: 0x2488
// Size: 0x13b
function miscmodel_mobile_wall_damage( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    assert( isdefined( level.var_c6e7f081 ), "<dev string:x61>" );
    
    if ( newval == 1 )
    {
        foreach ( i, model in level.var_c6e7f081 )
        {
            hidestaticmodel( model );
            
            if ( i % 25 == 0 )
            {
                wait 0.016;
            }
        }
        
        return;
    }
    
    foreach ( model in level.var_c6e7f081 )
    {
        unhidestaticmodel( model );
    }
}

// Namespace cp_mi_cairo_ramses2
// Params 7
// Checksum 0x68e2f57d, Offset: 0x25d0
// Size: 0x9a
function hide_statue_rubble( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    var_98ad2cfe = getent( localclientnum, "quadtank_statue_chunks", "targetname" );
    
    if ( isdefined( var_98ad2cfe ) )
    {
        if ( newval == 1 )
        {
            var_98ad2cfe hide();
            return;
        }
        
        var_98ad2cfe show();
    }
}

// Namespace cp_mi_cairo_ramses2
// Params 7
// Checksum 0x5720fb1b, Offset: 0x2678
// Size: 0x69
function alley_fog_banks( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    for ( localclientnum = 0; localclientnum < level.localplayers.size ; localclientnum++ )
    {
        setworldfogactivebank( localclientnum, 1 );
    }
}

