#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_sgen_fx;
#using scripts/cp/cp_mi_sing_sgen_sound;
#using scripts/shared/ai/systems/fx_character;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/exploder_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicles/_quadtank;
#using scripts/shared/visionset_mgr_shared;

#namespace cp_mi_sing_sgen;

// Namespace cp_mi_sing_sgen
// Params 0
// Checksum 0x9cd26713, Offset: 0x1370
// Size: 0x122
function main()
{
    util::set_streamer_hint_function( &force_streamer, 6 );
    init_clientfields();
    function_fe72942e();
    cp_mi_sing_sgen_fx::main();
    cp_mi_sing_sgen_sound::main();
    callback::on_spawned( &on_player_spawned );
    util::init_breath_fx();
    setup_skiptos();
    load::main();
    util::waitforclient( 0 );
    level thread scene::init( "p7_fxanim_gp_crane_pallet_01_bundle" );
    level thread scene::init( "p7_fxanim_cp_sgen_silo_twins_revenge_flood_bldg_01_bundle" );
    level thread scene::init( "p7_fxanim_cp_sgen_silo_twins_revenge_flood_bldg_02_bundle" );
    level thread scene::init( "p7_fxanim_cp_sgen_silo_twins_revenge_flood_bldg_03_bundle" );
}

// Namespace cp_mi_sing_sgen
// Params 1
// Checksum 0xd78734e1, Offset: 0x14a0
// Size: 0xd2
function on_player_spawned( localclientnum )
{
    filter::init_filter_ev_interference( self );
    duplicate_render::set_dr_filter_offscreen( "sitrep_keyline_red", 25, "keyline_active_red", "keyfill_active_red", 2, "mc/hud_outline_model_z_red", 0 );
    player = getlocalplayer( localclientnum );
    
    if ( player getentitynumber() != self getentitynumber() )
    {
        return;
    }
    
    if ( isdefined( level.var_d9cf9150 ) )
    {
        self thread pallas_monitors_state( localclientnum, undefined, level.var_d9cf9150 );
    }
    
    self.n_oed_futz = 0;
    self.b_oed_futz_filter_on = 0;
    self.n_oed_futz_increment = 0;
}

// Namespace cp_mi_sing_sgen
// Params 0
// Checksum 0xa948bfc, Offset: 0x1580
// Size: 0xa82
function init_clientfields()
{
    clientfield::register( "world", "w_fxa_truck_flip", 1, 1, "int", &truck_flip, 0, 0 );
    clientfield::register( "world", "w_robot_window_break", 1, 2, "int", &robot_window_break, 0, 0 );
    clientfield::register( "world", "testing_lab_wires", 1, 1, "int", &testing_lab_wires, 0, 0 );
    clientfield::register( "world", "silo_swim_bridge_fall", 1, 1, "int", &silo_swim_bridge_fall, 0, 0 );
    clientfield::register( "world", "w_underwater_state", 1, 1, "int", &underwater_state_toggle, 0, 0 );
    clientfield::register( "world", "w_flood_combat_windows_b", 1, 1, "int", &flood_combat_windows_b, 0, 0 );
    clientfield::register( "world", "w_flood_combat_windows_c", 1, 1, "int", &flood_combat_windows_c, 0, 0 );
    clientfield::register( "world", "elevator_light_probe", 1, 1, "int", &link_elevator_light_probe, 0, 0 );
    clientfield::register( "world", "flood_defend_hallway_flood_siege", 1, 1, "int", &flood_defend_hallway_flood_siege, 0, 0 );
    clientfield::register( "world", "tower_chunks1", 1, 1, "int", &tower_chunks1, 0, 0 );
    clientfield::register( "world", "tower_chunks2", 1, 1, "int", &tower_chunks2, 0, 0 );
    clientfield::register( "world", "tower_chunks3", 1, 1, "int", &tower_chunks3, 0, 0 );
    clientfield::register( "world", "observation_deck_destroy", 1, 1, "counter", &observation_deck_destroy, 0, 0 );
    clientfield::register( "world", "fallen_soldiers_client_fxanims", 1, 1, "int", &fallen_soldiers_client_fxanims, 0, 0 );
    clientfield::register( "world", "w_flyover_buoys", 1, 1, "int", &intro_flyover_client_fxanims, 0, 0 );
    clientfield::register( "world", "w_twin_igc_fxanim", 1, 2, "int", &twin_igc_client_fxanims, 0, 0 );
    clientfield::register( "world", "set_exposure_bank", 1, 1, "int", &set_exposure_bank, 0, 0 );
    clientfield::register( "world", "silo_debris", 1, 3, "int", &silo_debris, 0, 0 );
    clientfield::register( "world", "ceiling_collapse", 1, 3, "int", &ceiling_collapse, 0, 0 );
    clientfield::register( "world", "debris_catwalk", 1, 1, "counter", &debris_catwalk, 0, 0 );
    clientfield::register( "world", "debris_wall", 1, 1, "counter", &debris_wall, 0, 0 );
    clientfield::register( "world", "debris_fall", 1, 1, "counter", &debris_fall, 0, 0 );
    clientfield::register( "world", "debris_bridge", 1, 1, "counter", &debris_bridge, 0, 0 );
    clientfield::register( "scriptmover", "structural_weakness", 1, 1, "int", &set_structural_weakness, 0, 0 );
    clientfield::register( "scriptmover", "sm_elevator_shader", 1, 2, "int", &set_elevator_shader, 0, 0 );
    clientfield::register( "scriptmover", "sm_elevator_door_state", 1, 2, "int", &set_elevator_door_state, 0, 0 );
    clientfield::register( "scriptmover", "weakpoint", 1, 1, "int", &weakpoint, 0, 0 );
    duplicate_render::set_dr_filter_offscreen( "weakpoint_keyline", 100, "weakpoint_keyline_show_z", "weakpoint_keyline_hide_z", 2, "mc/hud_outline_model_z_orange" );
    clientfield::register( "scriptmover", "sm_depth_charge_fx", 1, 2, "int", &set_depth_charge_fx, 0, 0 );
    clientfield::register( "scriptmover", "dni_eye", 1, 1, "int", &function_1561b96d, 1, 0 );
    clientfield::register( "scriptmover", "turn_fake_robot_eye", 1, 1, "int", &play_robot_eye_fx, 0, 0 );
    clientfield::register( "scriptmover", "play_cia_robot_rogue_control", 1, 1, "int", &play_cia_robot_rogue_control, 0, 0 );
    clientfield::register( "scriptmover", "cooling_tower_damage", 1, 1, "int", &function_ef39e6b6, 0, 0 );
    clientfield::register( "toplayer", "pallas_monitors_state", 1, getminbitcountfornum( 3 ), "int", &pallas_monitors_state, 0, 0 );
    clientfield::register( "toplayer", "tp_water_sheeting", 1, 1, "int", &water_sheeting_toggle, 0, 0 );
    clientfield::register( "toplayer", "oed_interference", 1, 1, "int", &oed_interference, 0, 0 );
    clientfield::register( "toplayer", "sndSiloBG", 1, 1, "int", &sndsilobg, 0, 0 );
    clientfield::register( "toplayer", "dust_motes", 1, 1, "int", &dust_motes, 0, 0 );
    clientfield::register( "toplayer", "water_motes", 1, 1, "int", &water_motes, 0, 0 );
    clientfield::register( "toplayer", "water_teleport", 1, 1, "int", &water_teleport_transition, 0, 0 );
    clientfield::register( "vehicle", "extra_cam_ent", 1, 2, "int", &set_drone_cam, 0, 0 );
    clientfield::register( "vehicle", "sm_depth_charge_fx", 1, 2, "int", &set_depth_charge_fx, 0, 0 );
    clientfield::register( "vehicle", "quad_tank_tac_mode", 1, 1, "int", &function_8b62fa9d, 0, 0 );
    clientfield::register( "actor", "robot_bubbles", 1, 1, "int", &function_59c47b1, 0, 0 );
    clientfield::register( "actor", "sndStepSet", 1, 1, "int", &sndstepset, 1, 0 );
    clientfield::register( "actor", "disable_tmode", 1, 1, "int", &disable_tmode, 0, 0 );
    clientfield::register( "world", "sndLabWalla", 1, 1, "int", &cp_mi_sing_sgen_sound::sndLabWalla, 0, 0 );
    visionset_mgr::register_overlay_info_style_blur( "earthquake_blur", 1, 1, 0.1, 0.25, 4 );
}

// Namespace cp_mi_sing_sgen
// Params 0
// Checksum 0xaa43f87a, Offset: 0x2010
// Size: 0x9b
function function_fe72942e()
{
    if ( issplitscreen() )
    {
        var_2bb20e65 = struct::get_array( "no_splitscreen", "targetname" );
        
        foreach ( s_fxanim in var_2bb20e65 )
        {
            s_fxanim struct::delete();
        }
    }
}

// Namespace cp_mi_sing_sgen
// Params 0
// Checksum 0xb4442cfe, Offset: 0x20b8
// Size: 0x4e2
function setup_skiptos()
{
    skipto::add( "intro", &skipto_intro, "Intro" );
    skipto::add( "exterior", &skipto_post_intro, "Exterior" );
    skipto::add( "enter_sgen", &skipto_enter_sgen, "Enter SGEN" );
    skipto::add( "enter_lobby", &skipto_enter_lobby, "QTank Fight", &skipto_enter_lobby_done );
    skipto::add( "discover_data", &skipto_discover_data, "Discover Data" );
    skipto::add( "aquarium_shimmy", &skipto_aquarium_shimmy, "Aquarium Shimmy" );
    skipto::add( "gen_lab", &skipto_gen_lab, "Genetics Lab" );
    skipto::add( "post_gen_lab", &skipto_post_gen_lab, "Post Gen Lab" );
    skipto::add( "chem_lab", &skipto_chem_lab, "Chemical Lab" );
    skipto::add( "post_chem_lab", &skipto_post_chem_lab, "Post Chem Lab" );
    skipto::add( "silo_floor", &skipto_silo_floor, "Silo Floor Battle", &skipto_silo_floor_done );
    skipto::add( "under_silo", &skipto_under_silo, "Under Silo" );
    skipto::add( "fallen_soldiers", &skipto_init, "Fallen Soldiers" );
    skipto::add( "testing_lab_igc", &skipto_init, "Human Testing Lab" );
    skipto::add( "dark_battle", &function_70fafd70, "Dark Battle" );
    skipto::add( "charging_station", &skipto_init, "Charging Station" );
    skipto::add( "descent", &skipto_init, "Descent" );
    skipto::add( "pallas_start", &skipto_pallas_start, "pallas start" );
    skipto::add( "pallas_end", &skipto_init, "Pallas Death" );
    skipto::add( "twin_revenge", &function_8a68f6ae, "Twin Revenge", &function_9dd018de );
    skipto::add( "flood_combat", &function_12a6900b, "Flood Combat" );
    skipto::add( "flood_defend", &function_12a6900b, "Flood Defend" );
    skipto::add( "underwater_battle", &function_12a6900b, "Underwater Battle" );
    skipto::add( "underwater_rail", &function_12a6900b, "Underwater Rail" );
    skipto::add( "silo_swim", &function_12a6900b, "Silo Swim" );
}

// Namespace cp_mi_sing_sgen
// Params 2
// Checksum 0x20643a14, Offset: 0x25a8
// Size: 0x12
function skipto_init( str_objective, b_starting )
{
    
}

// Namespace cp_mi_sing_sgen
// Params 2
// Checksum 0xf593029e, Offset: 0x25c8
// Size: 0x2a
function function_70fafd70( str_objective, b_starting )
{
    if ( b_starting )
    {
        exploder::exploder( "sgen_pods_on" );
    }
}

// Namespace cp_mi_sing_sgen
// Params 2
// Checksum 0xe2780fe0, Offset: 0x2600
// Size: 0x32
function function_12a6900b( str_objective, b_starting )
{
    if ( b_starting || str_objective == "flood_combat" )
    {
        level thread function_4b788e97();
    }
}

// Namespace cp_mi_sing_sgen
// Params 2
// Checksum 0x463dc76f, Offset: 0x2640
// Size: 0x2a
function skipto_pallas_start( str_objective, b_starting )
{
    level scene::init( "p7_fxanim_cp_sgen_observation_deck_break_01_bundle" );
}

// Namespace cp_mi_sing_sgen
// Params 2
// Checksum 0x7fc39cbd, Offset: 0x2678
// Size: 0x22
function skipto_intro( str_objective, b_starting )
{
    level thread init_interior_fx_anims();
}

// Namespace cp_mi_sing_sgen
// Params 2
// Checksum 0xe7812b51, Offset: 0x26a8
// Size: 0x2a
function skipto_post_intro( str_objective, b_starting )
{
    if ( b_starting )
    {
        level thread init_interior_fx_anims();
    }
}

// Namespace cp_mi_sing_sgen
// Params 2
// Checksum 0x452b27a7, Offset: 0x26e0
// Size: 0x2a
function skipto_enter_sgen( str_objective, b_starting )
{
    if ( b_starting )
    {
        level thread init_interior_fx_anims();
    }
}

// Namespace cp_mi_sing_sgen
// Params 2
// Checksum 0xba966f22, Offset: 0x2718
// Size: 0x2a
function skipto_enter_lobby( str_objective, b_starting )
{
    if ( b_starting )
    {
        level thread init_interior_fx_anims();
    }
}

// Namespace cp_mi_sing_sgen
// Params 2
// Checksum 0xb8a9d25d, Offset: 0x2750
// Size: 0x12
function skipto_enter_lobby_done( str_objective, b_starting )
{
    
}

// Namespace cp_mi_sing_sgen
// Params 2
// Checksum 0xf7cace28, Offset: 0x2770
// Size: 0x2a
function skipto_discover_data( str_objective, b_starting )
{
    if ( b_starting )
    {
        level thread init_interior_fx_anims();
    }
}

// Namespace cp_mi_sing_sgen
// Params 2
// Checksum 0xf16ab0d6, Offset: 0x27a8
// Size: 0x2a
function skipto_aquarium_shimmy( str_objective, b_starting )
{
    if ( b_starting )
    {
        level thread init_interior_fx_anims();
    }
}

// Namespace cp_mi_sing_sgen
// Params 2
// Checksum 0x217832eb, Offset: 0x27e0
// Size: 0x2a
function skipto_gen_lab( str_objective, b_starting )
{
    if ( b_starting )
    {
        level thread init_fx_anims_from_gen_lab();
    }
}

// Namespace cp_mi_sing_sgen
// Params 2
// Checksum 0x82334a91, Offset: 0x2818
// Size: 0x2a
function skipto_post_gen_lab( str_objective, b_starting )
{
    if ( b_starting )
    {
        level thread init_fx_anims_from_gen_lab();
    }
}

// Namespace cp_mi_sing_sgen
// Params 2
// Checksum 0xacc9db6c, Offset: 0x2850
// Size: 0x2a
function skipto_chem_lab( str_objective, b_starting )
{
    if ( b_starting )
    {
        level thread init_fx_anims_from_chem_lab();
    }
}

// Namespace cp_mi_sing_sgen
// Params 2
// Checksum 0x301722fb, Offset: 0x2888
// Size: 0x2a
function skipto_post_chem_lab( str_objective, b_starting )
{
    if ( b_starting )
    {
        level thread init_fx_anims_from_chem_lab();
    }
}

// Namespace cp_mi_sing_sgen
// Params 2
// Checksum 0x33107d89, Offset: 0x28c0
// Size: 0x2a
function skipto_silo_floor( str_objective, b_starting )
{
    if ( b_starting )
    {
        level thread init_fx_anims_from_chem_lab();
    }
}

// Namespace cp_mi_sing_sgen
// Params 2
// Checksum 0xf28240a6, Offset: 0x28f8
// Size: 0x7a
function skipto_silo_floor_done( str_objective, b_starting )
{
    if ( b_starting )
    {
        wait 1;
    }
    
    if ( scene::is_active( "p7_fxanim_gp_raven_circle_ccw_01_bundle" ) )
    {
        level scene::stop( "p7_fxanim_gp_raven_circle_ccw_01_bundle", "scriptbundlename", 1 );
    }
    
    wait 0.1;
    struct::delete_script_bundle( "scene", "p7_fxanim_gp_raven_circle_ccw_01_bundle" );
}

// Namespace cp_mi_sing_sgen
// Params 2
// Checksum 0xf9c692c3, Offset: 0x2980
// Size: 0x2a
function skipto_under_silo( str_objective, b_starting )
{
    if ( b_starting )
    {
        level thread init_fx_anims_from_chem_lab();
    }
}

// Namespace cp_mi_sing_sgen
// Params 2
// Checksum 0x232ca234, Offset: 0x29b8
// Size: 0x12
function function_8a68f6ae( str_objective, b_starting )
{
    
}

// Namespace cp_mi_sing_sgen
// Params 2
// Checksum 0xa2746baa, Offset: 0x29d8
// Size: 0x12
function function_9dd018de( str_objective, b_starting )
{
    
}

// Namespace cp_mi_sing_sgen
// Params 0
// Checksum 0x4f11f877, Offset: 0x29f8
// Size: 0x32
function init_interior_fx_anims()
{
    level scene::init( "p7_fxanim_cp_sgen_rappel_rope_bundle" );
    level thread scene::play( "p7_fxanim_gp_crane_pallet_01_bundle" );
}

// Namespace cp_mi_sing_sgen
// Params 0
// Checksum 0xf1808b83, Offset: 0x2a38
// Size: 0x1a
function init_fx_anims_from_gen_lab()
{
    level scene::play( "p7_fxanim_gp_crane_pallet_01_bundle" );
}

// Namespace cp_mi_sing_sgen
// Params 0
// Checksum 0x1cd147a7, Offset: 0x2a60
// Size: 0x1a
function init_fx_anims_from_chem_lab()
{
    level scene::play( "p7_fxanim_gp_crane_pallet_01_bundle" );
}

// Namespace cp_mi_sing_sgen
// Params 7
// Checksum 0xe53e8092, Offset: 0x2a88
// Size: 0x82
function function_1561b96d( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        self mapshaderconstant( localclientnum, 0, "scriptVector0", 0, 1, 0, 0 );
        return;
    }
    
    self mapshaderconstant( localclientnum, 0, "scriptVector0", 0, 0, 0, 0 );
}

// Namespace cp_mi_sing_sgen
// Params 7
// Checksum 0x2235e62d, Offset: 0x2b18
// Size: 0x8a
function function_8b62fa9d( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        self tmodesetflag( 9 );
        self tmodesetflag( 10 );
        return;
    }
    
    self tmodeclearflag( 9 );
    self tmodeclearflag( 10 );
}

// Namespace cp_mi_sing_sgen
// Params 7
// Checksum 0xa1bc1e6f, Offset: 0x2bb0
// Size: 0x6a
function disable_tmode( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        self tmodesetflag( 0 );
        return;
    }
    
    self tmodeclearflag( 0 );
}

// Namespace cp_mi_sing_sgen
// Params 4
// Checksum 0xef7426f7, Offset: 0x2c28
// Size: 0x6d
function function_2370f00f( localclientnum, newval, str_value, str_key )
{
    switch ( newval )
    {
        case 2:
            level thread scene::init( str_value, str_key );
            break;
        case 1:
            level thread scene::play( str_value, str_key );
            break;
    }
}

// Namespace cp_mi_sing_sgen
// Params 7
// Checksum 0x35993abc, Offset: 0x2ca0
// Size: 0x5a
function robot_window_break( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    function_2370f00f( localclientnum, newval, "robot_window_break_start", "targetname" );
}

// Namespace cp_mi_sing_sgen
// Params 7
// Checksum 0xa88b5e0c, Offset: 0x2d08
// Size: 0x52
function debris_bridge( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    function_2370f00f( localclientnum, newval, "p7_fxanim_cp_sgen_silo_debris_bridge_bundle" );
}

// Namespace cp_mi_sing_sgen
// Params 7
// Checksum 0x60dce56, Offset: 0x2d68
// Size: 0x52
function debris_wall( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    function_2370f00f( localclientnum, newval, "p7_fxanim_cp_sgen_silo_debris_wall_bundle" );
}

// Namespace cp_mi_sing_sgen
// Params 0
// Checksum 0xad5a9bdf, Offset: 0x2dc8
// Size: 0x1a
function function_4b788e97()
{
    level thread scene::play( "uw_battle_fxanims" );
}

// Namespace cp_mi_sing_sgen
// Params 7
// Checksum 0xc68dc5e4, Offset: 0x2df0
// Size: 0x52
function debris_fall( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        level thread scene::play( "p7_fxanim_cp_sgen_silo_debris_fall_bundle" );
    }
}

// Namespace cp_mi_sing_sgen
// Params 7
// Checksum 0x1c8ad028, Offset: 0x2e50
// Size: 0x52
function debris_catwalk( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        level thread scene::play( "p7_fxanim_cp_sgen_silo_debris_catwalk_bundle" );
    }
}

// Namespace cp_mi_sing_sgen
// Params 7
// Checksum 0xaf8fa9ad, Offset: 0x2eb0
// Size: 0x5a
function truck_flip( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        level thread scene::play( "truck_flip", "targetname" );
    }
}

// Namespace cp_mi_sing_sgen
// Params 7
// Checksum 0x4d10b358, Offset: 0x2f18
// Size: 0x52
function set_structural_weakness( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self duplicate_render::set_item_enemy_equipment( localclientnum, newval );
}

// Namespace cp_mi_sing_sgen
// Params 7
// Checksum 0x38ea3e21, Offset: 0x2f78
// Size: 0x5a
function silo_swim_bridge_fall( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        level thread scene::play( "bridge_collapse", "targetname" );
    }
}

// Namespace cp_mi_sing_sgen
// Params 7
// Checksum 0x58e7a5ec, Offset: 0x2fe0
// Size: 0x21a
function set_drone_cam( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        v_offset = anglestoforward( self.angles ) * 10;
        v_origin = self.origin + v_offset;
        self.e_xcam_ent = spawn( localclientnum, v_origin, "script_origin" );
        self.e_xcam_ent.angles = self.angles + ( 0, 0, -90 );
        self.e_xcam_ent linkto( self, "tag_origin" );
        self.e_xcam_ent setextracam( 0 );
        playsound( 0, "uin_pip_open", ( 0, 0, 0 ) );
        return;
    }
    
    if ( newval == 2 )
    {
        v_offset = anglestoforward( self.angles ) * 10;
        v_origin = self.origin + v_offset;
        self.e_xcam_ent = spawn( localclientnum, v_origin, "script_origin" );
        self.e_xcam_ent.angles = self.angles;
        self.e_xcam_ent linkto( self, "tag_origin" );
        self.e_xcam_ent setextracam( 0 );
        playsound( 0, "uin_pip_open", ( 0, 0, 0 ) );
        return;
    }
    
    if ( isdefined( self.e_xcam_ent ) )
    {
        playsound( 0, "uin_pip_close", ( 0, 0, 0 ) );
        self.e_xcam_ent clearextracam();
        self.e_xcam_ent delete();
    }
}

// Namespace cp_mi_sing_sgen
// Params 7
// Checksum 0x7e26786e, Offset: 0x3208
// Size: 0x82
function oed_interference( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        self.n_oed_futz_increment = 0.004;
        self._remove_oed_futz = 0;
    }
    else
    {
        self.n_oed_futz_increment = -1 * 0.00533333;
        self._remove_oed_futz = 1;
    }
    
    self thread oed_futz_think( localclientnum );
}

// Namespace cp_mi_sing_sgen
// Params 1
// Checksum 0xe70d11de, Offset: 0x3298
// Size: 0x1f5
function oed_futz_think( localclientnum )
{
    self endon( #"death" );
    self notify( #"oed_futz_think_end" );
    self endon( #"oed_futz_think_end" );
    
    if ( !isdefined( self.n_oed_futz ) )
    {
        self.n_oed_futz = 0;
    }
    
    if ( !isdefined( self.b_oed_futz_filter_on ) )
    {
        self.b_oed_futz_filter_on = 0;
    }
    
    if ( !isdefined( self.n_oed_futz_increment ) )
    {
        self.n_oed_futz_increment = 0;
    }
    
    if ( !isdefined( self.b_ev_active ) )
    {
        self.b_ev_active = 0;
    }
    
    while ( isdefined( self ) )
    {
        self.n_oed_futz = self.n_oed_futz + self.n_oed_futz_increment;
        
        if ( self.n_oed_futz < 0 )
        {
            self.n_oed_futz = 0;
        }
        else if ( self.n_oed_futz > 1 )
        {
            self.n_oed_futz = 1;
        }
        
        if ( ( !self.b_ev_active || self.n_oed_futz == 0 ) && !self._remove_oed_futz )
        {
            if ( self.b_oed_futz_filter_on )
            {
                self.b_oed_futz_filter_on = 0;
                filter::disable_filter_ev_interference( self, 0 );
            }
        }
        else if ( self.n_oed_futz > 0 )
        {
            if ( !self.b_oed_futz_filter_on )
            {
                self.b_oed_futz_filter_on = 1;
                filter::enable_filter_ev_interference( self, 0 );
            }
            
            if ( self.b_oed_futz_filter_on )
            {
                filter::set_filter_ev_interference_amount( self, 0, self.n_oed_futz );
                n_range = -106 + ( 1 - self.n_oed_futz ) * 10350;
                n_target_range = 50 + ( 1 - self.n_oed_futz ) * 2950;
                evsetranges( localclientnum, n_range, n_target_range );
            }
        }
        
        wait 0.016;
    }
}

// Namespace cp_mi_sing_sgen
// Params 7
// Checksum 0x7c2b8fb0, Offset: 0x3498
// Size: 0x9a
function testing_lab_wires( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    level thread scene::play( "p7_fxanim_gp_wire_sparking_sml_bundle" );
    level thread scene::play( "p7_fxanim_gp_wire_sparking_med_thick_bundle" );
    level thread scene::play( "p7_fxanim_gp_wire_sparking_xlong_thick_bundle" );
    level thread scene::play( "p7_fxanim_gp_wire_sparking_xsml_thick_bundle" );
}

// Namespace cp_mi_sing_sgen
// Params 7
// Checksum 0xcbb0f68a, Offset: 0x3540
// Size: 0xad
function function_ef39e6b6( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self endon( #"death" );
    self endon( #"entityshutdown" );
    self endon( #"hash_ecd8f5eb" );
    
    if ( !newval )
    {
        self notify( #"hash_ecd8f5eb" );
        return;
    }
    
    while ( true )
    {
        self waittill( #"damage", damage_loc );
        playfx( localclientnum, level._effect[ "core_impact" ], damage_loc );
    }
}

// Namespace cp_mi_sing_sgen
// Params 7
// Checksum 0xcbbcfcbd, Offset: 0x35f8
// Size: 0x62
function ceiling_collapse( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        level scene::play( "hallway_ceiling_collapse_0" + newval, "targetname" );
    }
}

// Namespace cp_mi_sing_sgen
// Params 7
// Checksum 0x7da22e3c, Offset: 0x3668
// Size: 0x115
function pallas_monitors_state( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    level notify( #"hash_2fdfc947" );
    level.var_d9cf9150 = newval;
    
    switch ( newval )
    {
        case 0:
            self thread function_6f15ec64( localclientnum );
            break;
        case 1:
            self thread function_cacf88e6( localclientnum );
            break;
        case 2:
            self thread function_b84a3557( localclientnum );
            break;
        case 3:
            if ( isdefined( self._pallas_monitors ) )
            {
                for ( i = 0; i < self._pallas_monitors.size ; i++ )
                {
                    self._pallas_monitors[ i ] delete();
                }
            }
            
            level.var_d9cf9150 = undefined;
            break;
    }
}

// Namespace cp_mi_sing_sgen
// Params 1
// Checksum 0x75c8f0f6, Offset: 0x3788
// Size: 0x121
function function_cacf88e6( localclientnum )
{
    self endon( #"death" );
    level endon( #"hash_2fdfc947" );
    a_pallas_monitors = getentarray( localclientnum, "pallas_xcam_model", "targetname" );
    
    while ( isdefined( self ) )
    {
        a_pallas_monitors = array::get_all_closest( self.origin, a_pallas_monitors );
        n_count = 0;
        
        foreach ( e_monitor in a_pallas_monitors )
        {
            if ( n_count < 12 )
            {
                if ( isdefined( e_monitor.str_state ) )
                {
                    continue;
                }
                
                e_monitor show();
                n_count++;
                continue;
            }
            
            e_monitor hide();
            e_monitor.str_state = undefined;
        }
        
        wait 0.75;
    }
}

// Namespace cp_mi_sing_sgen
// Params 0
// Checksum 0x250050eb, Offset: 0x38b8
// Size: 0x51
function function_5799c6c0()
{
    level endon( #"hash_2fdfc947" );
    self.str_state = "off";
    self hide();
    wait randomfloatrange( 2, 5 );
    self.str_state = undefined;
}

// Namespace cp_mi_sing_sgen
// Params 0
// Checksum 0x6bddc31d, Offset: 0x3918
// Size: 0xd9
function function_39b5ac35()
{
    level endon( #"hash_2fdfc947" );
    n_time = randomfloatrange( 2, 5 );
    n_iterations = n_time / 0.05;
    self.str_state = "blink";
    
    for ( i = 0; i < n_iterations ; i++ )
    {
        if ( randomint( 100 ) < 50 )
        {
            self show();
        }
        else
        {
            self hide();
        }
        
        wait 0.05;
    }
    
    self hide();
    self.str_state = undefined;
}

// Namespace cp_mi_sing_sgen
// Params 1
// Checksum 0xb66ea8c8, Offset: 0x3a00
// Size: 0xe5
function function_b84a3557( localclientnum )
{
    self endon( #"death" );
    level endon( #"hash_2fdfc947" );
    a_pallas_monitors = getentarray( localclientnum, "pallas_xcam_model", "targetname" );
    
    while ( isdefined( self ) )
    {
        a_pallas_monitors = array::randomize( a_pallas_monitors );
        
        foreach ( i, mdl_monitor in a_pallas_monitors )
        {
            if ( i % 3 == 0 )
            {
                mdl_monitor show();
                continue;
            }
            
            mdl_monitor hide();
        }
        
        wait 0.1;
    }
}

// Namespace cp_mi_sing_sgen
// Params 1
// Checksum 0xaef2c15, Offset: 0x3af0
// Size: 0x9b
function function_6f15ec64( localclientnum )
{
    level endon( #"hash_2fdfc947" );
    a_pallas_monitors = getentarray( localclientnum, "pallas_xcam_model", "targetname" );
    
    foreach ( mdl_monitor in a_pallas_monitors )
    {
        mdl_monitor show();
    }
}

// Namespace cp_mi_sing_sgen
// Params 7
// Checksum 0xe84dec68, Offset: 0x3b98
// Size: 0x6a
function water_sheeting_toggle( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        startwatersheetingfx( localclientnum, 0 );
        return;
    }
    
    stopwatersheetingfx( localclientnum, 1 );
}

// Namespace cp_mi_sing_sgen
// Params 7
// Checksum 0xc3279bea, Offset: 0x3c10
// Size: 0xd2
function underwater_state_toggle( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        setdvar( "phys_buoyancy", 1 );
        setdvar( "phys_ragdoll_buoyancy", 1 );
        setdvar( "player_useWaterFriction", 0 );
        return;
    }
    
    setdvar( "phys_buoyancy", 0 );
    setdvar( "phys_ragdoll_buoyancy", 0 );
    setdvar( "player_useWaterFriction", 1 );
}

// Namespace cp_mi_sing_sgen
// Params 7
// Checksum 0x3d339638, Offset: 0x3cf0
// Size: 0x5a
function flood_combat_windows_b( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        level thread scene::play( "window_lt_01_start", "targetname" );
    }
}

// Namespace cp_mi_sing_sgen
// Params 7
// Checksum 0x901d9e91, Offset: 0x3d58
// Size: 0x5a
function flood_combat_windows_c( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        level thread scene::play( "window_rt_02_start", "targetname" );
    }
}

// Namespace cp_mi_sing_sgen
// Params 7
// Checksum 0xee67f6c, Offset: 0x3dc0
// Size: 0x173
function link_elevator_light_probe( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    a_lights = getentarray( localclientnum, "pallas_elevator_probe", "targetname" );
    a_probes = getentarray( localclientnum, "pallas_elevator_light", "targetname" );
    e_lift = getent( localclientnum, "boss_fight_lift", "targetname" );
    
    foreach ( light in a_lights )
    {
        light linkto( e_lift );
    }
    
    foreach ( probe in a_probes )
    {
        probe linkto( e_lift );
    }
}

// Namespace cp_mi_sing_sgen
// Params 7
// Checksum 0xd88063b1, Offset: 0x3f40
// Size: 0x52
function flood_defend_hallway_flood_siege( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        level scene::play( "p7_fxanim_cp_sgen_water_hallway_flood_bundle" );
    }
}

// Namespace cp_mi_sing_sgen
// Params 7
// Checksum 0xa673dc80, Offset: 0x3fa0
// Size: 0x1bd
function set_elevator_shader( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( !isdefined( self.c_elevator_model ) )
    {
        self.c_elevator_model = getent( localclientnum, "boss_fight_lift", "targetname" );
        self.c_elevator_model linkto( self );
    }
    
    switch ( newval )
    {
        case 3:
            self.c_elevator_model show();
            break;
        case 2:
            self.c_elevator_model hide();
            break;
        case 1:
            i = 0;
            
            while ( i < 2 )
            {
                self.c_elevator_model mapshaderconstant( 0, 0, "scriptVector0", i / 2, 0, 0, 0 );
                wait 0.01;
                i += 0.01;
            }
            
            break;
        case 0:
            i = 3;
            
            while ( i > 0 )
            {
                self.c_elevator_model mapshaderconstant( 0, 0, "scriptVector0", i / 3, 0, 0, 0 );
                wait 0.01;
                i -= 0.01;
            }
            
            self.c_elevator_model hide();
            break;
    }
}

// Namespace cp_mi_sing_sgen
// Params 7
// Checksum 0x110575a5, Offset: 0x4168
// Size: 0xdd
function set_elevator_door_state( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    switch ( newval )
    {
        case 2:
            self.c_elevator_door = getent( localclientnum, "pallas_lift_back", "targetname" );
            self.c_elevator_door linkto( self );
            break;
        case 1:
            self.c_elevator_door = getent( localclientnum, "pallas_lift_front", "targetname" );
            self.c_elevator_door linkto( self );
            break;
    }
}

// Namespace cp_mi_sing_sgen
// Params 7
// Checksum 0xdd618c35, Offset: 0x4250
// Size: 0x8a
function observation_deck_destroy( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( !isdefined( level.anchor_delete_watcher ) )
    {
        level.anchor_delete_watcher = 0;
    }
    
    level.anchor_delete_watcher++;
    
    if ( level.anchor_delete_watcher > 3 )
    {
        return;
    }
    
    level scene::play( "p7_fxanim_cp_sgen_observation_deck_break_0" + level.anchor_delete_watcher + "_bundle" );
}

// Namespace cp_mi_sing_sgen
// Params 7
// Checksum 0x7cc1fb5b, Offset: 0x42e8
// Size: 0x5a
function tower_chunks1( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    level scene::play( "server_tower_chunks_01", "targetname" );
}

// Namespace cp_mi_sing_sgen
// Params 7
// Checksum 0x21a13e1a, Offset: 0x4350
// Size: 0x5a
function tower_chunks2( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    level scene::play( "server_tower_chunks_02", "targetname" );
}

// Namespace cp_mi_sing_sgen
// Params 7
// Checksum 0x42bd41fe, Offset: 0x43b8
// Size: 0x5a
function tower_chunks3( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    level scene::play( "server_tower_chunks_03", "targetname" );
}

// Namespace cp_mi_sing_sgen
// Params 7
// Checksum 0x1e152fd7, Offset: 0x4420
// Size: 0x52
function play_robot_eye_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    fxclientutils::playfxbundle( localclientnum, self, "c_54i_robot_grunt_fx_def_4_rogue" );
}

// Namespace cp_mi_sing_sgen
// Params 7
// Checksum 0xb441b3c0, Offset: 0x4480
// Size: 0x7a
function play_cia_robot_rogue_control( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        fxclientutils::playfxbundle( localclientnum, self, "c_cia_robot_grunt_fx_def_1_rogue" );
        return;
    }
    
    fxclientutils::stopfxbundle( localclientnum, self, "c_cia_robot_grunt_fx_def_1_rogue" );
}

// Namespace cp_mi_sing_sgen
// Params 7
// Checksum 0x7b64a0a, Offset: 0x4508
// Size: 0x77
function sndsilobg( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        self thread sndsilobgthink( "amb_descent_bg_top", "amb_descent_bg_mid", "amb_descent_bg_bot" );
        return;
    }
    
    level notify( #"stopsilobgend" );
}

// Namespace cp_mi_sing_sgen
// Params 3
// Checksum 0xc0c7a9cb, Offset: 0x4588
// Size: 0x4c7
function sndsilobgthink( arg1, arg2, arg3 )
{
    level endon( #"stopsilobgend" );
    startorigin = ( 42, -30, -128 );
    endorigin = ( -53, 865, -2671 );
    distbetween = abs( startorigin[ 2 ] - endorigin[ 2 ] );
    
    if ( !isdefined( arg1 ) && !isdefined( arg2 ) )
    {
        return;
    }
    
    point1 = startorigin[ 2 ];
    point2 = endorigin[ 2 ];
    
    if ( isdefined( arg3 ) )
    {
        point1 = startorigin;
        point2 = ( ( startorigin[ 0 ] + endorigin[ 0 ] ) / 2, ( startorigin[ 1 ] + endorigin[ 1 ] ) / 2, ( startorigin[ 2 ] + endorigin[ 2 ] ) / 2 );
        point3 = endorigin;
    }
    
    sndent1 = spawn( 0, startorigin, "script_origin" );
    sndent1 playloopsound( arg1, 0.5 );
    sndent1 setloopstate( arg1, 1, 1 );
    sndent2 = spawn( 0, startorigin, "script_origin" );
    sndent2 playloopsound( arg2, 0.5 );
    sndent2 setloopstate( arg2, 0, 1 );
    sndent2 linkto( sndent1 );
    
    if ( isdefined( arg3 ) )
    {
        sndent3 = spawn( 0, startorigin, "script_origin" );
        sndent3 playloopsound( arg3, 0.5 );
        sndent3 setloopstate( arg3, 0, 1 );
        sndent3 linkto( sndent1 );
    }
    
    level thread snddeleteents( sndent1, sndent2, sndent3 );
    wait 0.5;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    while ( isdefined( self ) )
    {
        zpoint = self.origin[ 2 ];
        zdistance1 = abs( point1[ 2 ] - zpoint );
        zdistance2 = abs( point2[ 2 ] - zpoint );
        
        if ( isdefined( arg3 ) )
        {
            zdistance3 = abs( point3[ 2 ] - zpoint );
        }
        
        volume1 = audio::scale_speed( 0, abs( point1[ 2 ] - point2[ 2 ] ), 0, 1, zdistance1 );
        volume1 = abs( 1 - volume1 );
        sndent1 setloopstate( arg1, volume1, 1 );
        volume2 = audio::scale_speed( 0, abs( point1[ 2 ] - point2[ 2 ] ), 0, 1, zdistance2 );
        volume2 = abs( 1 - volume2 );
        sndent2 setloopstate( arg2, volume2, 1 );
        
        if ( isdefined( arg3 ) )
        {
            volume3 = audio::scale_speed( 0, abs( point2[ 2 ] - point3[ 2 ] ), 0, 1, zdistance3 );
            volume3 = abs( 1 - volume3 );
            sndent3 setloopstate( arg3, volume3, 1 );
        }
        
        percentage = zdistance1 / distbetween;
        axis1 = ( endorigin[ 0 ] - startorigin[ 0 ] ) * percentage + startorigin[ 0 ];
        axis2 = ( endorigin[ 1 ] - startorigin[ 1 ] ) * percentage + startorigin[ 1 ];
        axis3 = zpoint;
        
        if ( zpoint >= startorigin[ 2 ] )
        {
            axis1 = startorigin[ 0 ];
            axis2 = startorigin[ 1 ];
            axis3 = startorigin[ 2 ];
        }
        
        if ( zpoint <= endorigin[ 2 ] )
        {
            axis1 = endorigin[ 0 ];
            axis2 = endorigin[ 1 ];
            axis3 = endorigin[ 2 ];
        }
        
        sndent1 moveto( ( axis1, axis2, axis3 ), 0.2 );
        wait 0.2;
    }
    
    level notify( #"stopsilobgend" );
}

// Namespace cp_mi_sing_sgen
// Params 3
// Checksum 0x25a7a65a, Offset: 0x4a58
// Size: 0x52
function snddeleteents( ent1, ent2, ent3 )
{
    level waittill( #"stopsilobgend" );
    ent1 delete();
    ent2 delete();
    ent3 delete();
}

// Namespace cp_mi_sing_sgen
// Params 7
// Checksum 0x603ee351, Offset: 0x4ab8
// Size: 0xa2
function dust_motes( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    wait 0.1;
    
    if ( newval )
    {
        self.n_fx_id = playviewmodelfx( localclientnum, level._effect[ "dust_motes" ], "tag_camera" );
        return;
    }
    
    if ( isdefined( self.n_fx_id ) )
    {
        deletefx( localclientnum, self.n_fx_id, 1 );
    }
}

// Namespace cp_mi_sing_sgen
// Params 7
// Checksum 0x16aca5b3, Offset: 0x4b68
// Size: 0xa2
function water_motes( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    wait 0.1;
    
    if ( newval )
    {
        self.var_8e8c7340 = playviewmodelfx( localclientnum, level._effect[ "water_motes" ], "tag_camera" );
        return;
    }
    
    if ( isdefined( self.n_fx_id ) )
    {
        deletefx( localclientnum, self.var_8e8c7340, 1 );
    }
}

// Namespace cp_mi_sing_sgen
// Params 7
// Checksum 0x25bb2dd8, Offset: 0x4c18
// Size: 0xca
function water_teleport_transition( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        self.n_fx_id = playviewmodelfx( localclientnum, level._effect[ "water_teleport" ], "tag_camera" );
        exploder::exploder( "flood_lighting" );
        return;
    }
    
    if ( isdefined( self.n_fx_id ) )
    {
        deletefx( localclientnum, self.n_fx_id, 0 );
        exploder::stop_exploder( "flood_lighting" );
    }
}

// Namespace cp_mi_sing_sgen
// Params 7
// Checksum 0xddb156b0, Offset: 0x4cf0
// Size: 0xa1
function silo_debris( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval < 6 )
    {
        level scene::play( "p7_fxanim_cp_sgen_underwater_silo_debris_0" + newval + "_bundle" );
        return;
    }
    
    for ( x = 0; x < 6 ; x++ )
    {
        level scene::stop( "p7_fxanim_cp_sgen_underwater_silo_debris_0" + x + "_bundle" );
    }
}

// Namespace cp_mi_sing_sgen
// Params 1
// Checksum 0xc233ed7a, Offset: 0x4da0
// Size: 0x2cd
function force_streamer( n_zone )
{
    switch ( n_zone )
    {
        case 2:
            forcestreambundle( "cin_sgen_14_humanlab_3rd_sh010" );
            forcestreambundle( "cin_sgen_14_humanlab_3rd_sh020" );
            forcestreambundle( "cin_sgen_14_humanlab_3rd_sh030" );
            forcestreambundle( "cin_sgen_14_humanlab_3rd_sh040" );
            forcestreambundle( "cin_sgen_14_humanlab_3rd_sh050" );
            forcestreambundle( "cin_sgen_14_humanlab_3rd_sh060" );
            forcestreambundle( "cin_sgen_14_humanlab_3rd_sh070" );
            forcestreambundle( "cin_sgen_14_humanlab_3rd_sh080" );
            forcestreambundle( "cin_sgen_14_humanlab_3rd_sh090" );
            forcestreambundle( "cin_sgen_14_humanlab_3rd_sh020" );
            break;
        case 3:
            forcestreambundle( "p7_fxanim_cp_sgen_pallas_ai_tower_collapse_bundle" );
            forcestreambundle( "cin_sgen_19_ghost_3rd_sh010" );
            forcestreambundle( "cin_sgen_19_ghost_3rd_sh020" );
            forcestreambundle( "cin_sgen_19_ghost_3rd_sh030" );
            forcestreambundle( "cin_sgen_19_ghost_3rd_sh040" );
            forcestreambundle( "cin_sgen_19_ghost_3rd_sh050" );
            forcestreambundle( "cin_sgen_19_ghost_3rd_sh060" );
            forcestreambundle( "cin_sgen_19_ghost_3rd_sh070" );
            forcestreambundle( "cin_sgen_19_ghost_3rd_sh080" );
            forcestreambundle( "cin_sgen_19_ghost_3rd_sh090" );
            break;
        case 4:
            forcestreamxmodel( "c_54i_assault_body" );
            forcestreamxmodel( "c_54i_assault_lieutenant_head" );
            break;
        case 5:
            forcestreambundle( "cin_sgen_26_01_lobbyexit_1st_escape_grab" );
            forcestreambundle( "cin_sgen_26_01_lobbyexit_1st_escape_outro" );
            forcestreambundle( "p7_fxanim_cp_sgen_end_building_collapse_debris_bundle" );
            break;
        case 6:
            forcestreamxmodel( "c_hro_hendricks_sing_body" );
            forcestreamxmodel( "c_hro_hendricks_sing_head" );
            break;
    }
}

// Namespace cp_mi_sing_sgen
// Params 7
// Checksum 0x6950f464, Offset: 0x5078
// Size: 0xaa
function weakpoint( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        self duplicate_render::change_dr_flags( localclientnum, "weakpoint_keyline_show_z", "weakpoint_keyline_hide_z" );
        self weakpoint_enable( 2 );
        return;
    }
    
    self duplicate_render::change_dr_flags( localclientnum, "weakpoint_keyline_hide_z", "weakpoint_keyline_show_z" );
    self weakpoint_enable( 0 );
}

// Namespace cp_mi_sing_sgen
// Params 7
// Checksum 0x11945061, Offset: 0x5130
// Size: 0x52
function fallen_soldiers_client_fxanims( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        level scene::play( "p7_fxanim_gp_wire_sparking_xsml_bundle" );
    }
}

// Namespace cp_mi_sing_sgen
// Params 7
// Checksum 0x43df546a, Offset: 0x5190
// Size: 0x6a
function intro_flyover_client_fxanims( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        level scene::play( "p7_fxanim_gp_floating_buoy_02_upright_bundle" );
        return;
    }
    
    level scene::stop( "p7_fxanim_gp_floating_buoy_02_upright_bundle" );
}

// Namespace cp_mi_sing_sgen
// Params 7
// Checksum 0xa95f4829, Offset: 0x5208
// Size: 0xeb
function sndstepset( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        match = "fly_water_wade";
        triggers = getentarray( 0, "audio_step_trigger", "targetname" );
        
        foreach ( trig in triggers )
        {
            if ( trig.script_label == match )
            {
                self thread sndstepsetthreaded( trig, match );
                return;
            }
        }
    }
}

// Namespace cp_mi_sing_sgen
// Params 2
// Checksum 0xc0745115, Offset: 0x5300
// Size: 0xa5
function sndstepsetthreaded( trigger, alias )
{
    self endon( #"death" );
    self endon( #"entityshutdown" );
    self.stepset = 0;
    
    while ( true )
    {
        if ( self istouching( trigger ) )
        {
            if ( !self.stepset )
            {
                self.stepset = 1;
                self setsteptriggersound( alias + "_npc" );
            }
        }
        else if ( self.stepset )
        {
            self.stepset = 0;
            self clearsteptriggersound();
        }
        
        wait 0.1;
    }
}

// Namespace cp_mi_sing_sgen
// Params 7
// Checksum 0x81ec3c8d, Offset: 0x53b0
// Size: 0x9a
function function_59c47b1( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( !isdefined( self.var_d1efe793 ) )
    {
        self.var_d1efe793 = playfxontag( localclientnum, level._effect[ "water_robot_bubbles" ], self, "tag_aim" );
        self waittill( #"death" );
        stopfx( localclientnum, self.var_d1efe793 );
    }
}

// Namespace cp_mi_sing_sgen
// Params 7
// Checksum 0xf0c813cb, Offset: 0x5458
// Size: 0xed
function set_depth_charge_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( isdefined( self.light_fx ) )
    {
        stopfx( localclientnum, self.light_fx );
        self.light_fx = undefined;
    }
    
    switch ( newval )
    {
        case 1:
            self.light_fx = playfxontag( localclientnum, level._effect[ "yellow_light" ], self, "tag_origin" );
            break;
        case 2:
            self.light_fx = playfxontag( localclientnum, level._effect[ "red_light" ], self, "tag_origin" );
            break;
    }
}

// Namespace cp_mi_sing_sgen
// Params 7
// Checksum 0xdaf8a1e4, Offset: 0x5550
// Size: 0x135
function twin_igc_client_fxanims( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    switch ( newval )
    {
        case 1:
            var_5cee1345 = findstaticmodelindexarray( "twin_revenge_bldg_static1" );
            
            if ( isdefined( var_5cee1345 ) )
            {
                foreach ( var_bc3c6c65 in var_5cee1345 )
                {
                    hidestaticmodel( var_bc3c6c65 );
                }
            }
            
            level thread scene::play( "p7_fxanim_cp_sgen_silo_twins_revenge_flood_bldg_01_bundle" );
            break;
        case 2:
            level thread scene::play( "p7_fxanim_cp_sgen_silo_twins_revenge_flood_bldg_02_bundle" );
            break;
        case 3:
            level thread scene::play( "p7_fxanim_cp_sgen_silo_twins_revenge_flood_bldg_03_bundle" );
            break;
    }
}

// Namespace cp_mi_sing_sgen
// Params 7
// Checksum 0x533df231, Offset: 0x5690
// Size: 0x6a
function set_exposure_bank( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        setexposureactivebank( localclientnum, 4 );
        return;
    }
    
    setexposureactivebank( localclientnum, 1 );
}

