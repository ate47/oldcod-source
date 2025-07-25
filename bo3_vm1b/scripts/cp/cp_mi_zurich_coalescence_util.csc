#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace zurich_util;

// Namespace zurich_util
// Params 0, eflags: 0x2
// Checksum 0x93d67202, Offset: 0x1978
// Size: 0x2a
function autoexec __init__sytem__()
{
    system::register( "zurich_util", &__init__, undefined, undefined );
}

// Namespace zurich_util
// Params 0
// Checksum 0x3f078fb7, Offset: 0x19b0
// Size: 0x42
function __init__()
{
    init_clientfields();
    util::init_breath_fx();
    level.var_1cf7e9e8 = [];
    level.var_18402cb = [];
    init_effects();
}

// Namespace zurich_util
// Params 0
// Checksum 0x20770d12, Offset: 0x1a00
// Size: 0x6f2
function init_clientfields()
{
    var_2d20335b = getminbitcountfornum( 5 );
    var_a9ef5da3 = getminbitcountfornum( 6 );
    visionset_mgr::register_visionset_info( "cp_zurich_hallucination", 1, 1, "cp_zurich_hallucination", "cp_zurich_hallucination" );
    clientfield::register( "actor", "exploding_ai_deaths", 1, 1, "int", &callback_exploding_death_fx, 0, 0 );
    clientfield::register( "actor", "hero_spawn_fx", 1, 1, "int", &function_78bd19c4, 0, 0 );
    clientfield::register( "scriptmover", "hero_spawn_fx", 1, 1, "int", &function_78bd19c4, 0, 0 );
    clientfield::register( "scriptmover", "vehicle_spawn_fx", 1, 1, "int", &function_f026ccfa, 0, 0 );
    clientfield::register( "toplayer", "set_world_fog", 1, 1, "int", &function_346468e3, 0, 0 );
    clientfield::register( "scriptmover", "raven_juke_effect", 1, 1, "counter", &function_69d5dc62, 0, 0 );
    clientfield::register( "actor", "raven_juke_limb_effect", 1, 1, "counter", &function_d559bc1d, 0, 0 );
    clientfield::register( "scriptmover", "raven_teleport_effect", 1, 1, "counter", &function_cb609334, 0, 0 );
    clientfield::register( "actor", "raven_teleport_limb_effect", 1, 1, "counter", &function_496c80db, 0, 0 );
    clientfield::register( "scriptmover", "raven_teleport_in_effect", 1, 1, "counter", &function_c39ee0a8, 0, 0 );
    clientfield::register( "toplayer", "player_weather", 1, var_2d20335b, "int", &function_6120ef33, 0, 0 );
    clientfield::register( "toplayer", "vortex_teleport", 1, 1, "counter", &function_560fbdb4, 0, 0 );
    clientfield::register( "toplayer", "postfx_futz", 1, 1, "counter", &postfx_futz, 0, 0 );
    clientfield::register( "toplayer", "postfx_futz_mild", 1, 1, "counter", &postfx_futz_mild, 0, 0 );
    clientfield::register( "toplayer", "postfx_transition", 1, 1, "counter", &postfx_transition, 0, 0 );
    clientfield::register( "world", "zurich_city_ambience", 1, 1, "int", &zurich_city_ambience, 0, 0 );
    clientfield::register( "actor", "skin_transition_melt", 1, 1, "int", &function_28572b48, 0, 1 );
    clientfield::register( "scriptmover", "corvus_body_fx", 1, 1, "int", &function_b5037219, 0, 0 );
    clientfield::register( "actor", "raven_ai_rez", 1, 1, "int", &function_91c7508e, 0, 0 );
    clientfield::register( "scriptmover", "raven_ai_rez", 1, 1, "int", &function_91c7508e, 0, 0 );
    clientfield::register( "toplayer", "zurich_server_cam", 1, 1, "int", &zurich_server_cam, 0, 0 );
    clientfield::register( "world", "set_exposure_bank", 1, 1, "int", &set_exposure_bank, 0, 0 );
    clientfield::register( "scriptmover", "corvus_tree_shader", 1, 1, "int", &function_51e77d4f, 0, 0 );
    clientfield::register( "actor", "hero_cold_breath", 1, 1, "int", &function_33714f9b, 0, 0 );
    clientfield::register( "world", "set_post_color_grade_bank", 1, 1, "int", &set_post_color_grade_bank, 0, 0 );
    clientfield::register( "toplayer", "postfx_hallucinations", 1, 1, "counter", &postfx_hallucinations, 0, 0 );
    clientfield::register( "toplayer", "player_water_transition", 1, 1, "int", &function_70a9fa32, 0, 0 );
    clientfield::register( "toplayer", "raven_hallucinations", 1, 1, "int", &raven_hallucinations, 0, 0 );
    clientfield::register( "scriptmover", "quadtank_raven_explosion", 1, 1, "int", &quadtank_raven_explosion, 0, 0 );
    clientfield::register( "scriptmover", "raven_fade_out", 1, 1, "int", &raven_fade_out, 0, 0 );
}

// Namespace zurich_util
// Params 0
// Checksum 0x3a67e0e, Offset: 0x2100
// Size: 0x64b
function init_effects()
{
    level._effect[ "exploding_death" ] = "player/fx_ai_raven_dissolve_torso";
    level._effect[ "vehicle_spawn_fx" ] = "player/fx_ai_dni_rez_in_hero_clean";
    level._effect[ "raven_juke_effect" ] = "player/fx_ai_raven_juke_out";
    level._effect[ "raven_juke_effect_arm_le" ] = "player/fx_ai_raven_juke_out_arm_le";
    level._effect[ "raven_juke_effect_arm_ri" ] = "player/fx_ai_raven_juke_out_arm_ri";
    level._effect[ "raven_juke_effect_leg_le" ] = "player/fx_ai_raven_juke_out_leg_le";
    level._effect[ "raven_juke_effect_leg_ri" ] = "player/fx_ai_raven_juke_out_leg_ri";
    level._effect[ "raven_teleport_effect" ] = "player/fx_ai_raven_teleport";
    level._effect[ "raven_teleport_effect_arm_le" ] = "player/fx_ai_raven_teleport_out_arm_le";
    level._effect[ "raven_teleport_effect_arm_ri" ] = "player/fx_ai_raven_teleport_out_arm_ri";
    level._effect[ "raven_teleport_effect_leg_le" ] = "player/fx_ai_raven_teleport_out_leg_le";
    level._effect[ "raven_teleport_effect_leg_ri" ] = "player/fx_ai_raven_teleport_out_leg_ri";
    level._effect[ "raven_teleport_in_effect" ] = "player/fx_ai_raven_teleport_in";
    level._effect[ "red_rain" ] = "weather/fx_rain_system_hvy_blood_runner_loop";
    level._effect[ "light_snow" ] = "weather/fx_snow_player_lt_loop";
    level._effect[ "regular_snow" ] = "weather/fx_snow_player_loop";
    level._effect[ "reverse_snow" ] = "weather/fx_snow_player_loop_reverse";
    level._effect[ "vortex_explode" ] = "player/fx_ai_dni_rez_in_hero_clean";
    level._effect[ "corvus_fx_arm_le" ] = "player/fx_ai_corvus_arm_left_loop";
    level._effect[ "corvus_fx_arm_ri" ] = "player/fx_ai_corvus_arm_right_loop";
    level._effect[ "corvus_fx_head" ] = "player/fx_ai_corvus_head_loop";
    level._effect[ "corvus_fx_hip_le" ] = "player/fx_ai_corvus_hip_left_loop";
    level._effect[ "corvus_fx_hip_ri" ] = "player/fx_ai_corvus_hip_right_loop";
    level._effect[ "corvus_fx_leg_le" ] = "player/fx_ai_corvus_leg_left_loop";
    level._effect[ "corvus_fx_leg_ri" ] = "player/fx_ai_corvus_leg_right_loop";
    level._effect[ "corvus_fx_torso" ] = "player/fx_ai_corvus_torso_loop";
    level._effect[ "corvus_fx_waist" ] = "player/fx_ai_corvus_waist_loop";
    level._effect[ "hero_cold_breath" ] = "player/fx_plyr_breath_steam_3p";
    level._effect[ "raven_in_fx_arm_le" ] = "player/fx_ai_dni_rez_in_arm_left_dirty";
    level._effect[ "raven_in_fx_arm_ri" ] = "player/fx_ai_dni_rez_in_arm_right_dirty";
    level._effect[ "raven_in_fx_head" ] = "player/fx_ai_dni_rez_in_head_dirty";
    level._effect[ "raven_in_fx_hip_le" ] = "player/fx_ai_dni_rez_in_hip_left_dirty";
    level._effect[ "raven_in_fx_hip_ri" ] = "player/fx_ai_dni_rez_in_hip_right_dirty";
    level._effect[ "raven_in_fx_leg_le" ] = "player/fx_ai_dni_rez_in_leg_left_dirty";
    level._effect[ "raven_in_fx_leg_ri" ] = "player/fx_ai_dni_rez_in_leg_right_dirty";
    level._effect[ "raven_in_fx_torso" ] = "player/fx_ai_dni_rez_in_torso_dirty";
    level._effect[ "raven_in_fx_waist" ] = "player/fx_ai_dni_rez_in_waist_dirty";
    level._effect[ "raven_hallucination_fx" ] = "animals/fx_bio_birds_raven_player_camera";
    level._effect[ "raven_out_fx_arm_le" ] = "player/fx_ai_dni_rez_out_arm_left_dirty";
    level._effect[ "raven_out_fx_arm_ri" ] = "player/fx_ai_dni_rez_out_arm_right_dirty";
    level._effect[ "raven_out_fx_head" ] = "player/fx_ai_dni_rez_out_head_dirty";
    level._effect[ "raven_out_fx_hip_le" ] = "player/fx_ai_dni_rez_out_hip_left_dirty";
    level._effect[ "raven_out_fx_hip_ri" ] = "player/fx_ai_dni_rez_out_hip_right_dirty";
    level._effect[ "raven_out_fx_leg_le" ] = "player/fx_ai_dni_rez_out_leg_left_dirty";
    level._effect[ "raven_out_fx_leg_ri" ] = "player/fx_ai_dni_rez_out_leg_right_dirty";
    level._effect[ "raven_out_fx_torso" ] = "player/fx_ai_dni_rez_out_torso_dirty";
    level._effect[ "raven_out_fx_waist" ] = "player/fx_ai_dni_rez_out_waist_dirty";
    level._effect[ "hero_in_fx_arm_le" ] = "player/fx_ai_dni_rez_in_arm_left_clean";
    level._effect[ "hero_in_fx_arm_ri" ] = "player/fx_ai_dni_rez_in_arm_right_clean";
    level._effect[ "hero_in_fx_head" ] = "player/fx_ai_dni_rez_in_head_clean";
    level._effect[ "hero_in_fx_hip_le" ] = "player/fx_ai_dni_rez_in_hip_left_clean";
    level._effect[ "hero_in_fx_hip_ri" ] = "player/fx_ai_dni_rez_in_hip_right_clean";
    level._effect[ "hero_in_fx_leg_le" ] = "player/fx_ai_dni_rez_in_leg_left_clean";
    level._effect[ "hero_in_fx_leg_ri" ] = "player/fx_ai_dni_rez_in_leg_right_clean";
    level._effect[ "hero_in_fx_torso" ] = "player/fx_ai_dni_rez_in_torso_clean";
    level._effect[ "hero_in_fx_waist" ] = "player/fx_ai_dni_rez_in_waist_clean";
    level._effect[ "hero_out_fx_arm_le" ] = "player/fx_ai_dni_rez_out_arm_left_clean";
    level._effect[ "hero_out_fx_arm_ri" ] = "player/fx_ai_dni_rez_out_arm_right_clean";
    level._effect[ "hero_out_fx_head" ] = "player/fx_ai_dni_rez_out_head_clean";
    level._effect[ "hero_out_fx_hip_le" ] = "player/fx_ai_dni_rez_out_hip_left_clean";
    level._effect[ "hero_out_fx_hip_ri" ] = "player/fx_ai_dni_rez_out_hip_right_clean";
    level._effect[ "hero_out_fx_leg_le" ] = "player/fx_ai_dni_rez_out_leg_left_clean";
    level._effect[ "hero_out_fx_leg_ri" ] = "player/fx_ai_dni_rez_out_leg_right_clean";
    level._effect[ "hero_out_fx_torso" ] = "player/fx_ai_dni_rez_out_torso_clean";
    level._effect[ "hero_out_fx_waist" ] = "player/fx_ai_dni_rez_out_waist_clean";
    level._effect[ "quadtank_explosion_fx" ] = "explosions/fx_exp_dni_raven_reveal";
    level._effect[ "raven_fade_out_fx" ] = "animals/fx_bio_raven_dni_rez_out_dirty";
}

// Namespace zurich_util
// Params 2
// Checksum 0x44a9bee8, Offset: 0x2758
// Size: 0x12
function skipto_start( str_objective, b_starting )
{
    
}

// Namespace zurich_util
// Params 2
// Checksum 0x18196241, Offset: 0x2778
// Size: 0x425
function function_3bf27f88( str_objective, b_starting )
{
    if ( str_objective == "plaza_battle" )
    {
        wait 1;
        level struct::delete_script_bundle( "scene", "p7_fxanim_cp_zurich_wasp_swarm_bundle" );
        return;
    }
    
    if ( str_objective == "root_zurich_vortex" )
    {
        wait 1;
        level struct::delete_script_bundle( "scene", "p7_fxanim_cp_zurich_root_wall_01_bundle" );
        level struct::delete_script_bundle( "scene", "p7_fxanim_cp_zurich_root_wall_02_bundle" );
        return;
    }
    
    if ( str_objective == "root_cairo_vortex" )
    {
        wait 1;
        level struct::delete_script_bundle( "scene", "p7_fxanim_cp_zurich_cairo_b_collapse_01_bundle" );
        level struct::delete_script_bundle( "scene", "p7_fxanim_cp_zurich_cairo_b_collapse_02_bundle" );
        level struct::delete_script_bundle( "scene", "p7_fxanim_cp_zurich_cairo_b_collapse_03_bundle" );
        level struct::delete_script_bundle( "scene", "p7_fxanim_cp_zurich_cairo_lightpole_bundle" );
        level struct::delete_script_bundle( "scene", "p7_fxanim_cp_zurich_sinkhole_01_bundle" );
        level struct::delete_script_bundle( "scene", "p7_fxanim_cp_zurich_sinkhole_02_bundle" );
        return;
    }
    
    if ( str_objective == "clearing_hub_3" )
    {
        wait 1;
        level struct::delete_script_bundle( "scene", "p7_fxanim_cp_zurich_root_door_center_bundle" );
        level struct::delete_script_bundle( "scene", "p7_fxanim_cp_zurich_root_door_left_bundle" );
        level struct::delete_script_bundle( "scene", "p7_fxanim_cp_zurich_root_door_right_bundle" );
        level struct::delete_script_bundle( "scene", "p7_fxanim_cp_zurich_root_door_round_bundle" );
        level struct::delete_script_bundle( "scene", "cin_zur_16_02_clearing_vign_bodies01" );
        level struct::delete_script_bundle( "scene", "cin_zur_16_02_clearing_vign_bodies02" );
        level struct::delete_script_bundle( "scene", "cin_zur_16_02_clearing_vign_bodies04" );
        return;
    }
    
    if ( str_objective == "root_singapore_vortex" )
    {
        wait 1;
        level struct::delete_script_bundle( "scene", "cin_zur_16_02_singapore_hanging_shortrope" );
        level struct::delete_script_bundle( "scene", "cin_zur_16_02_singapore_hanging_shortrope_2" );
        level struct::delete_script_bundle( "scene", "cin_zur_16_02_singapore_vign_bodies01" );
        level struct::delete_script_bundle( "scene", "cin_zur_16_02_singapore_vign_bodies02" );
        level struct::delete_script_bundle( "scene", "cin_zur_16_02_singapore_vign_bodies03" );
        level struct::delete_script_bundle( "scene", "cin_zur_16_02_singapore_vign_pulled01" );
        level struct::delete_script_bundle( "scene", "cin_zur_16_02_singapore_vign_pulled02" );
        level struct::delete_script_bundle( "scene", "cin_zur_16_02_singapore_vign_pulled03" );
        level struct::delete_script_bundle( "scene", "p7_fxanim_cp_zurich_roots_water01_bundle" );
        level struct::delete_script_bundle( "scene", "p7_fxanim_cp_zurich_roots_water02_bundle" );
        level struct::delete_script_bundle( "scene", "p7_fxanim_gp_shutter_lt_02_red_bundle" );
        level struct::delete_script_bundle( "scene", "p7_fxanim_gp_shutter_lt_10_red_white_bundle" );
        level struct::delete_script_bundle( "scene", "p7_fxanim_gp_shutter_rt_02_red_bundle" );
        level struct::delete_script_bundle( "scene", "p7_fxanim_gp_shutter_rt_10_red_white_bundle" );
    }
}

// Namespace zurich_util
// Params 2
// Checksum 0x996d4ebd, Offset: 0x2ba8
// Size: 0xbb
function function_4dd02a03( a_ents, str_notify )
{
    if ( isdefined( str_notify ) )
    {
        level waittill( str_notify );
    }
    
    if ( isdefined( a_ents ) && isarray( a_ents ) )
    {
        a_ents = array::remove_undefined( a_ents );
        
        if ( a_ents.size )
        {
            foreach ( e_ent in a_ents )
            {
                e_ent delete();
            }
        }
    }
}

// Namespace zurich_util
// Params 7
// Checksum 0x489491b1, Offset: 0x2c70
// Size: 0x10a
function callback_exploding_death_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        pos = self gettagorigin( "j_spine4" );
        angles = self gettagangles( "j_spine4" );
        fxobj = util::spawn_model( localclientnum, "tag_origin", pos, angles );
        playfxontag( localclientnum, level._effect[ "exploding_death" ], fxobj, "tag_origin" );
        fxobj playsound( localclientnum, "evt_ai_explode" );
        wait 6;
        fxobj delete();
    }
}

// Namespace zurich_util
// Params 7
// Checksum 0x5d59b8b8, Offset: 0x2d88
// Size: 0x3d2
function function_78bd19c4( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        playfxontag( localclientnum, level._effect[ "hero_in_fx_arm_le" ], self, "j_elbow_le" );
        playfxontag( localclientnum, level._effect[ "hero_in_fx_arm_le" ], self, "j_shoulder_le" );
        playfxontag( localclientnum, level._effect[ "hero_in_fx_arm_ri" ], self, "j_elbow_ri" );
        playfxontag( localclientnum, level._effect[ "hero_in_fx_arm_ri" ], self, "j_shoulder_ri" );
        playfxontag( localclientnum, level._effect[ "hero_in_fx_head" ], self, "j_head" );
        playfxontag( localclientnum, level._effect[ "hero_in_fx_hip_le" ], self, "j_hip_le" );
        playfxontag( localclientnum, level._effect[ "hero_in_fx_hip_ri" ], self, "j_hip_ri" );
        playfxontag( localclientnum, level._effect[ "hero_in_fx_leg_le" ], self, "j_knee_le" );
        playfxontag( localclientnum, level._effect[ "hero_in_fx_leg_ri" ], self, "j_knee_ri" );
        playfxontag( localclientnum, level._effect[ "hero_in_fx_torso" ], self, "j_spine4" );
        playfxontag( localclientnum, level._effect[ "hero_in_fx_waist" ], self, "j_spinelower" );
        self playsound( localclientnum, "evt_ai_raven_spawn" );
        return;
    }
    
    playfxontag( localclientnum, level._effect[ "hero_out_fx_arm_le" ], self, "j_elbow_le" );
    playfxontag( localclientnum, level._effect[ "hero_out_fx_arm_le" ], self, "j_shoulder_le" );
    playfxontag( localclientnum, level._effect[ "hero_out_fx_arm_ri" ], self, "j_elbow_ri" );
    playfxontag( localclientnum, level._effect[ "hero_out_fx_arm_ri" ], self, "j_shoulder_ri" );
    playfxontag( localclientnum, level._effect[ "hero_out_fx_head" ], self, "j_head" );
    playfxontag( localclientnum, level._effect[ "hero_out_fx_hip_le" ], self, "j_hip_le" );
    playfxontag( localclientnum, level._effect[ "hero_out_fx_hip_ri" ], self, "j_hip_ri" );
    playfxontag( localclientnum, level._effect[ "hero_out_fx_leg_le" ], self, "j_knee_le" );
    playfxontag( localclientnum, level._effect[ "hero_out_fx_leg_ri" ], self, "j_knee_ri" );
    playfxontag( localclientnum, level._effect[ "hero_out_fx_torso" ], self, "j_spine4" );
    playfxontag( localclientnum, level._effect[ "hero_out_fx_waist" ], self, "j_spinelower" );
}

// Namespace zurich_util
// Params 7
// Checksum 0xf64b3291, Offset: 0x3168
// Size: 0x7a
function function_f026ccfa( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    playfxontag( localclientnum, level._effect[ "vehicle_spawn_fx" ], self, "tag_origin" );
    self playsound( localclientnum, "evt_ai_raven_spawn" );
}

// Namespace zurich_util
// Params 7
// Checksum 0xc7e492dc, Offset: 0x31f0
// Size: 0x92
function function_346468e3( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        setlitfogbank( localclientnum, -1, 1, -1 );
        setworldfogactivebank( localclientnum, 2 );
        return;
    }
    
    setlitfogbank( localclientnum, -1, 0, -1 );
    setworldfogactivebank( localclientnum, 1 );
}

// Namespace zurich_util
// Params 7
// Checksum 0x9a3c4d92, Offset: 0x3290
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

// Namespace zurich_util
// Params 7
// Checksum 0x29233f86, Offset: 0x3308
// Size: 0x6a
function set_post_color_grade_bank( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        setpbgactivebank( localclientnum, 2 );
        return;
    }
    
    setpbgactivebank( localclientnum, 1 );
}

// Namespace zurich_util
// Params 7
// Checksum 0xb82c85e7, Offset: 0x3380
// Size: 0x7a
function function_69d5dc62( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    playfxontag( localclientnum, level._effect[ "raven_juke_effect" ], self, "tag_origin" );
    self playsound( localclientnum, "evt_ai_juke" );
}

// Namespace zurich_util
// Params 7
// Checksum 0xa1ae1ae6, Offset: 0x3408
// Size: 0x17a
function function_d559bc1d( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    playfxontag( localclientnum, level._effect[ "raven_juke_effect_arm_le" ], self, "j_elbow_le" );
    playfxontag( localclientnum, level._effect[ "raven_juke_effect_arm_le" ], self, "j_shoulder_le" );
    playfxontag( localclientnum, level._effect[ "raven_juke_effect_arm_ri" ], self, "j_elbow_ri" );
    playfxontag( localclientnum, level._effect[ "raven_juke_effect_arm_ri" ], self, "j_shoulder_ri" );
    playfxontag( localclientnum, level._effect[ "raven_juke_effect_leg_le" ], self, "j_knee_le" );
    playfxontag( localclientnum, level._effect[ "raven_juke_effect_leg_le" ], self, "j_hip_le" );
    playfxontag( localclientnum, level._effect[ "raven_juke_effect_leg_ri" ], self, "j_knee_ri" );
    playfxontag( localclientnum, level._effect[ "raven_juke_effect_leg_ri" ], self, "j_hip_ri" );
}

// Namespace zurich_util
// Params 7
// Checksum 0x63455f10, Offset: 0x3590
// Size: 0x7a
function function_cb609334( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    playfxontag( localclientnum, level._effect[ "raven_teleport_effect" ], self, "tag_origin" );
    self playsound( localclientnum, "evt_ai_teleoprt" );
}

// Namespace zurich_util
// Params 7
// Checksum 0x1d7087fe, Offset: 0x3618
// Size: 0x17a
function function_496c80db( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    playfxontag( localclientnum, level._effect[ "raven_teleport_effect_arm_le" ], self, "j_elbow_le" );
    playfxontag( localclientnum, level._effect[ "raven_teleport_effect_arm_le" ], self, "j_shoulder_le" );
    playfxontag( localclientnum, level._effect[ "raven_teleport_effect_arm_ri" ], self, "j_elbow_ri" );
    playfxontag( localclientnum, level._effect[ "raven_teleport_effect_arm_ri" ], self, "j_shoulder_ri" );
    playfxontag( localclientnum, level._effect[ "raven_teleport_effect_leg_le" ], self, "j_knee_le" );
    playfxontag( localclientnum, level._effect[ "raven_teleport_effect_leg_le" ], self, "j_hip_le" );
    playfxontag( localclientnum, level._effect[ "raven_teleport_effect_leg_ri" ], self, "j_knee_ri" );
    playfxontag( localclientnum, level._effect[ "raven_teleport_effect_leg_ri" ], self, "j_hip_ri" );
}

// Namespace zurich_util
// Params 7
// Checksum 0x4ef5d722, Offset: 0x37a0
// Size: 0x7a
function function_c39ee0a8( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    playfxontag( localclientnum, level._effect[ "raven_teleport_in_effect" ], self, "tag_origin" );
    self playsound( localclientnum, "evt_ai_teleport_in" );
}

// Namespace zurich_util
// Params 7
// Checksum 0x37b0c30, Offset: 0x3828
// Size: 0x9a
function function_560fbdb4( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    wait 0.1;
    v_fxpos = self.origin + ( 0, 0, 32 ) + anglestoforward( self.angles ) * 12;
    playfx( localclientnum, level._effect[ "vortex_explode" ], v_fxpos );
}

// Namespace zurich_util
// Params 7
// Checksum 0xe1accbf9, Offset: 0x38d0
// Size: 0x3d2
function function_91c7508e( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        playfxontag( localclientnum, level._effect[ "raven_in_fx_arm_le" ], self, "j_elbow_le" );
        playfxontag( localclientnum, level._effect[ "raven_in_fx_arm_le" ], self, "j_shoulder_le" );
        playfxontag( localclientnum, level._effect[ "raven_in_fx_arm_ri" ], self, "j_elbow_ri" );
        playfxontag( localclientnum, level._effect[ "raven_in_fx_arm_ri" ], self, "j_shoulder_ri" );
        playfxontag( localclientnum, level._effect[ "raven_in_fx_head" ], self, "j_head" );
        playfxontag( localclientnum, level._effect[ "raven_in_fx_hip_le" ], self, "j_hip_le" );
        playfxontag( localclientnum, level._effect[ "raven_in_fx_hip_ri" ], self, "j_hip_ri" );
        playfxontag( localclientnum, level._effect[ "raven_in_fx_leg_le" ], self, "j_knee_le" );
        playfxontag( localclientnum, level._effect[ "raven_in_fx_leg_ri" ], self, "j_knee_ri" );
        playfxontag( localclientnum, level._effect[ "raven_in_fx_torso" ], self, "j_spine4" );
        playfxontag( localclientnum, level._effect[ "raven_in_fx_waist" ], self, "j_spinelower" );
        self playsound( localclientnum, "evt_ai_raven_spawn" );
        return;
    }
    
    playfxontag( localclientnum, level._effect[ "raven_out_fx_arm_le" ], self, "j_elbow_le" );
    playfxontag( localclientnum, level._effect[ "raven_out_fx_arm_le" ], self, "j_shoulder_le" );
    playfxontag( localclientnum, level._effect[ "raven_out_fx_arm_ri" ], self, "j_elbow_ri" );
    playfxontag( localclientnum, level._effect[ "raven_out_fx_arm_ri" ], self, "j_shoulder_ri" );
    playfxontag( localclientnum, level._effect[ "raven_out_fx_head" ], self, "j_head" );
    playfxontag( localclientnum, level._effect[ "raven_out_fx_hip_le" ], self, "j_hip_le" );
    playfxontag( localclientnum, level._effect[ "raven_out_fx_hip_ri" ], self, "j_hip_ri" );
    playfxontag( localclientnum, level._effect[ "raven_out_fx_leg_le" ], self, "j_knee_le" );
    playfxontag( localclientnum, level._effect[ "raven_out_fx_leg_ri" ], self, "j_knee_ri" );
    playfxontag( localclientnum, level._effect[ "raven_out_fx_torso" ], self, "j_spine4" );
    playfxontag( localclientnum, level._effect[ "raven_out_fx_waist" ], self, "j_spinelower" );
}

// Namespace zurich_util
// Params 7
// Checksum 0x2f2c38f9, Offset: 0x3cb0
// Size: 0x331
function function_b5037219( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        self.a_fx_id = [];
        var_120b6bed = playfxontag( localclientnum, level._effect[ "corvus_fx_arm_le" ], self, "j_elbow_le" );
        var_380de656 = playfxontag( localclientnum, level._effect[ "corvus_fx_arm_le" ], self, "j_shoulder_le" );
        var_5e1060bf = playfxontag( localclientnum, level._effect[ "corvus_fx_arm_ri" ], self, "j_elbow_ri" );
        var_53ff07e0 = playfxontag( localclientnum, level._effect[ "corvus_fx_arm_ri" ], self, "j_shoulder_ri" );
        fx_head = playfxontag( localclientnum, level._effect[ "corvus_fx_head" ], self, "j_head" );
        var_7c88767e = playfxontag( localclientnum, level._effect[ "corvus_fx_hip_le" ], self, "j_hip_le" );
        var_5685fc15 = playfxontag( localclientnum, level._effect[ "corvus_fx_hip_ri" ], self, "j_hip_ri" );
        var_af98a017 = playfxontag( localclientnum, level._effect[ "corvus_fx_leg_le" ], self, "j_knee_le" );
        var_3d9130dc = playfxontag( localclientnum, level._effect[ "corvus_fx_leg_ri" ], self, "j_knee_ri" );
        var_a4653f43 = playfxontag( localclientnum, level._effect[ "corvus_fx_torso" ], self, "j_spine4" );
        var_a656ad3a = playfxontag( localclientnum, level._effect[ "corvus_fx_waist" ], self, "j_spinelower" );
        self.a_fx_id = array( var_120b6bed, var_380de656, var_5e1060bf, var_53ff07e0, fx_head, var_7c88767e, var_5685fc15, var_af98a017, var_3d9130dc, var_a4653f43, var_a656ad3a );
        return;
    }
    
    if ( isdefined( self.a_fx_id ) )
    {
        for ( i = 0; i < self.a_fx_id.size ; i++ )
        {
            deletefx( localclientnum, self.a_fx_id[ i ], 0 );
        }
        
        self.a_fx_id = undefined;
    }
}

// Namespace zurich_util
// Params 7
// Checksum 0x359d73e6, Offset: 0x3ff0
// Size: 0x19a
function function_6120ef33( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval >= 1 )
    {
        if ( level.var_1cf7e9e8[ localclientnum ] === newval )
        {
            return;
        }
        
        level.var_1cf7e9e8[ localclientnum ] = newval;
        
        switch ( newval )
        {
            case 1:
                str_fx = "regular_snow";
                n_delay = 0.5;
                self thread function_965fdae0( localclientnum, str_fx, n_delay );
                break;
            case 2:
                str_fx = "red_rain";
                n_delay = 0.3;
                self thread function_965fdae0( localclientnum, str_fx, n_delay );
                break;
            case 3:
                str_fx = "reverse_snow";
                n_delay = 0.03;
                self thread function_965fdae0( localclientnum, str_fx, n_delay );
                break;
            case 4:
                str_fx = "light_snow";
                n_delay = 0.03;
                self thread function_965fdae0( localclientnum, str_fx, n_delay );
                break;
            default:
                self function_a0b8d731( localclientnum );
                break;
        }
        
        return;
    }
    
    self function_a0b8d731( localclientnum );
}

// Namespace zurich_util
// Params 3
// Checksum 0x161c6aac, Offset: 0x4198
// Size: 0x73
function function_965fdae0( localclientnum, str_fx, n_delay )
{
    if ( isdefined( level.var_18402cb[ localclientnum ] ) )
    {
        deletefx( localclientnum, level.var_18402cb[ localclientnum ], 1 );
        level.var_18402cb[ localclientnum ] = undefined;
    }
    
    level.var_18402cb[ localclientnum ] = playfxoncamera( localclientnum, level._effect[ str_fx ], ( 0, 0, 0 ), ( 1, 0, 0 ), ( 0, 0, 1 ) );
}

// Namespace zurich_util
// Params 1
// Checksum 0x2a463e38, Offset: 0x4218
// Size: 0x42
function function_a0b8d731( localclientnum )
{
    level.var_1cf7e9e8[ localclientnum ] = undefined;
    
    if ( isdefined( level.var_18402cb[ localclientnum ] ) )
    {
        deletefx( localclientnum, level.var_18402cb[ localclientnum ], 1 );
        level.var_18402cb[ localclientnum ] = undefined;
    }
}

// Namespace zurich_util
// Params 7
// Checksum 0x87e57420, Offset: 0x4268
// Size: 0x82
function postfx_futz( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    player = getlocalplayer( localclientnum );
    playsound( localclientnum, "evt_dni_interrupt", ( 0, 0, 0 ) );
    player postfx::playpostfxbundle( "pstfx_dni_screen_futz" );
}

// Namespace zurich_util
// Params 7
// Checksum 0x7c455fa3, Offset: 0x42f8
// Size: 0x6a
function postfx_transition( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    player = getlocalplayer( localclientnum );
    player thread postfx::playpostfxbundle( "pstfx_cp_transition_sprite_zur" );
}

// Namespace zurich_util
// Params 7
// Checksum 0x7d9eca97, Offset: 0x4370
// Size: 0x82
function postfx_futz_mild( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    player = getlocalplayer( localclientnum );
    playsound( localclientnum, "evt_dni_interrupt", ( 0, 0, 0 ) );
    player postfx::playpostfxbundle( "pstfx_dni_interrupt_mild" );
}

// Namespace zurich_util
// Params 7
// Checksum 0xb2af024b, Offset: 0x4400
// Size: 0x6a
function zurich_city_ambience( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        level thread scene::play( "p7_fxanim_cp_zurich_wasp_swarm_bundle" );
        return;
    }
    
    level scene::stop( "p7_fxanim_cp_zurich_wasp_swarm_bundle", 1 );
}

// Namespace zurich_util
// Params 7
// Checksum 0x16fbdd0, Offset: 0x4478
// Size: 0xdd
function function_28572b48( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        n_start_time = gettime();
        
        while ( isdefined( self ) )
        {
            n_time = gettime();
            var_348e23ad = ( n_time - n_start_time ) / 1000;
            
            if ( var_348e23ad >= 4 )
            {
                var_348e23ad = 4;
                b_is_updating = 0;
            }
            
            var_daad71ff = 1 * var_348e23ad / 4;
            self mapshaderconstant( 0, 0, "scriptVector0", var_daad71ff, var_daad71ff, 0 );
            wait 0.01;
        }
    }
}

// Namespace zurich_util
// Params 7
// Checksum 0x5bfe538f, Offset: 0x4560
// Size: 0x87
function function_51e77d4f( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        if ( isdefined( self.var_540c25e7 ) && self.var_540c25e7 )
        {
            return;
        }
        
        self.var_540c25e7 = 1;
        self thread corvus_tree_shader();
        return;
    }
    
    self.var_540c25e7 = undefined;
    self notify( #"stop_shader" );
}

// Namespace zurich_util
// Params 0
// Checksum 0x1fb5a35, Offset: 0x45f0
// Size: 0x135
function corvus_tree_shader()
{
    self endon( #"stop_shader" );
    n_increment = 0.1;
    n_pulse_max = 1;
    n_pulse_min = 0.4;
    n_pulse = n_pulse_min;
    
    while ( isdefined( self ) )
    {
        n_cycle_time = randomfloatrange( 2, 8 );
        n_pulse_increment = ( n_pulse_max - n_pulse_min ) / n_cycle_time / n_increment;
        
        while ( n_pulse < n_pulse_max && isdefined( self ) )
        {
            self mapshaderconstant( 0, 0, "scriptVector0", 1, n_pulse, 0, 0 );
            n_pulse += n_pulse_increment;
            wait n_increment;
        }
        
        n_cycle_time = randomfloatrange( 2, 8 );
        n_pulse_increment = ( n_pulse_max - n_pulse_min ) / n_cycle_time / n_increment;
        
        while ( n_pulse_min < n_pulse && isdefined( self ) )
        {
            self mapshaderconstant( 0, 0, "scriptVector0", 1, n_pulse, 0, 0 );
            n_pulse -= n_pulse_increment;
            wait n_increment;
        }
    }
}

// Namespace zurich_util
// Params 7
// Checksum 0x65e9c824, Offset: 0x4730
// Size: 0xaa
function zurich_server_cam( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        s_align = struct::get( "tag_align_coalescence_return_server" );
        playmaincamxcam( localclientnum, "c_zur_20_01_plaza_1st_fight_it_shooting_cam", 0, "", "", s_align.origin, s_align.angles );
        return;
    }
    
    stopmaincamxcam( localclientnum );
}

// Namespace zurich_util
// Params 7
// Checksum 0x935a652f, Offset: 0x47e8
// Size: 0x6a
function function_70a9fa32( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        self thread postfx::playpostfxbundle( "pstfx_blood_transition" );
        return;
    }
    
    self thread postfx::playpostfxbundle( "pstfx_blood_t_out" );
}

// Namespace zurich_util
// Params 7
// Checksum 0x9fb9e1f0, Offset: 0x4860
// Size: 0x5f
function function_33714f9b( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        self thread function_1cb0f58c( localclientnum );
        return;
    }
    
    self notify( #"disable_breath_fx" );
}

// Namespace zurich_util
// Params 1
// Checksum 0x519d510c, Offset: 0x48c8
// Size: 0x5d
function function_1cb0f58c( localclientnum )
{
    self endon( #"disable_breath_fx" );
    self endon( #"entityshutdown" );
    
    while ( true )
    {
        playfxontag( localclientnum, level._effect[ "hero_cold_breath" ], self, "j_head" );
        wait randomintrange( 6, 8 );
    }
}

// Namespace zurich_util
// Params 7
// Checksum 0x73c21f10, Offset: 0x4930
// Size: 0xfa
function postfx_hallucinations( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self endon( #"entityshutdown" );
    
    if ( newval == 1 )
    {
        self playsound( 0, "evt_dni_interrupt" );
        self thread postfx::playpostfxbundle( "pstfx_dni_screen_futz_short" );
        wait 0.5;
        self thread postfx::exitpostfxbundle();
        wait 0.3;
        self thread postfx::playpostfxbundle( "pstfx_raven_loop" );
        wait 0.5;
        self playsound( 0, "evt_dni_interrupt" );
        self thread postfx::exitpostfxbundle();
    }
}

// Namespace zurich_util
// Params 7
// Checksum 0xa389d9f8, Offset: 0x4a38
// Size: 0xe2
function raven_hallucinations( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self endon( #"entityshutdown" );
    
    if ( newval )
    {
        self thread function_b5adc0ad( localclientnum );
        self thread postfx::playpostfxbundle( "pstfx_dni_screen_futz_short" );
        wait 0.5;
        self thread postfx::exitpostfxbundle();
        return;
    }
    
    self notify( #"hash_5ca6609a" );
    wait 1.5;
    self thread postfx::playpostfxbundle( "pstfx_dni_screen_futz_short" );
    wait 0.15;
    self thread postfx::exitpostfxbundle();
}

// Namespace zurich_util
// Params 1
// Checksum 0xea2dcfd0, Offset: 0x4b28
// Size: 0x55
function function_b5adc0ad( localclientnum )
{
    self endon( #"entityshutdown" );
    self endon( #"hash_5ca6609a" );
    
    while ( true )
    {
        playfxoncamera( localclientnum, level._effect[ "raven_hallucination_fx" ], ( 0, 0, 0 ), ( 1, 0, 0 ), ( 0, 0, 1 ) );
        wait 0.05;
    }
}

// Namespace zurich_util
// Params 7
// Checksum 0x3e1f73cd, Offset: 0x4b88
// Size: 0x72
function raven_fade_out( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self endon( #"entityshutdown" );
    
    if ( newval )
    {
        playfxontag( localclientnum, level._effect[ "raven_fade_out_fx" ], self, "j_spine_2" );
    }
}

// Namespace zurich_util
// Params 7
// Checksum 0x29c100c6, Offset: 0x4c08
// Size: 0x82
function quadtank_raven_explosion( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        playfxontag( localclientnum, level._effect[ "quadtank_explosion_fx" ], self, "tag_origin" );
        self playsound( 0, "veh_quadtank_crowsplosion" );
    }
}

