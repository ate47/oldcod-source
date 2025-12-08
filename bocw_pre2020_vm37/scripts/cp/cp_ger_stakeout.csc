#using script_196ed2508fd0fd9d;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\easing;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flashlight;
#using scripts\core_common\load_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\serverfield_shared;
#using scripts\core_common\util_shared;

#namespace cp_ger_stakeout;

// Namespace cp_ger_stakeout/level_init
// Params 1, eflags: 0x40
// Checksum 0xfc8a6ec0, Offset: 0x7a0
// Size: 0x1ec
function event_handler[level_init] main( *eventstruct )
{
    setsaveddvar( #"enable_global_wind", 1 );
    setsaveddvar( #"wind_global_vector", "88 0 0" );
    setsaveddvar( #"wind_global_low_altitude", 0 );
    setsaveddvar( #"wind_global_hi_altitude", 10000 );
    setsaveddvar( #"wind_global_low_strength_percent", 100 );
    init_clientfields();
    load::main();
    util::waitforclient( 0 );
    level flashlight::function_69258685( undefined, "maps/cp_stakeout/fx9_flashlight" );
    level._effect[ #"guard_room_light" ] = #"hash_d2a2dd55181f074";
    level._effect[ #"darkroom_light" ] = #"hash_78e234f940b499a";
    level._effect[ #"rooftop_spotlight" ] = #"hash_3a149841990ac7b1";
    level._effect[ #"hash_27d555878676deb1" ] = #"hash_7c3a90be6566a844";
    level._effect[ #"player_blacklight" ] = #"hash_2a8bc9be6587131c";
}

// Namespace cp_ger_stakeout/cp_ger_stakeout
// Params 0
// Checksum 0xfe81e469, Offset: 0x998
// Size: 0x464
function init_clientfields()
{
    clientfield::register( "toplayer", "force_stream_train", 1, 1, "int", &function_602a63fc, 0, 0 );
    clientfield::register( "world", "force_stream_bar", 1, 1, "int", &function_d5fba952, 0, 0 );
    clientfield::register( "toplayer", "pstfx_chromatic_aberration", 1, 1, "int", &pstfx_chromatic_aberration, 0, 0 );
    clientfield::register( "toplayer", "pstfx_sprite_rain_loop", 1, 1, "int", &pstfx_sprite_rain_loop, 0, 0 );
    clientfield::register( "toplayer", "pstfx_sprite_rain_ladder", 1, 1, "int", &pstfx_sprite_rain_ladder, 0, 0 );
    clientfield::register( "toplayer", "pstfx_head_trauma", 1, 1, "counter", &pstfx_head_trauma, 0, 0 );
    clientfield::register( "toplayer", "lerp_fov", 1, 3, "int", &lerp_fov, 0, 1 );
    clientfield::register( "toplayer", "player_blacklight", 1, 1, "int", &function_c20ade4a, 0, 0 );
    clientfield::register( "toplayer", "knock_out_vision", 1, 1, "int", &function_5568fbbb, 1, 0 );
    clientfield::register( "scriptmover", "guard_room_light", 1, 1, "int", &function_e80b775e, 0, 0 );
    clientfield::register( "scriptmover", "sewer_exit_flashlight_fx", 1, 1, "int", &sewer_exit_flashlight_fx, 0, 0 );
    clientfield::register( "scriptmover", "darkroom_light", 1, 1, "int", &darkroom_light, 0, 0 );
    clientfield::register( "scriptmover", "rooftop_spotlight", 1, 1, "int", &rooftop_spotlight, 0, 0 );
    clientfield::register( "scriptmover", "render_emissive_blacklight_material", 1, 1, "int", &render_emissive_blacklight_material, 0, 0 );
    clientfield::register( "toplayer", "kraus_zoom_hint_start", 1, 1, "int", &function_e1bea416, 0, 0 );
    serverfield::register( "kraus_zoom_hint_end", 1, 1, "int" );
}

// Namespace cp_ger_stakeout/cp_ger_stakeout
// Params 7
// Checksum 0xc5e9cd64, Offset: 0xe08
// Size: 0x58c
function function_602a63fc( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump )
{
    if ( bwasdemojump )
    {
        forcestreamxmodel( "c_t9_ger_civ_female_urban_07_body3" );
        forcestreamxmodel( "c_t9_ger_civ_female_head02" );
        forcestreamxmodel( "c_t9_net_civ_female_urban_body6" );
        forcestreamxmodel( "c_t9_ger_civ_female_head03" );
        forcestreamxmodel( "c_t9_ger_civ_female_urban_06b_body" );
        forcestreamxmodel( "c_t9_ger_civ_female_head04" );
        forcestreamxmodel( "c_t9_ger_civ_male_urban_body2b" );
        forcestreamxmodel( "c_t9_ger_civ_male_head02" );
        forcestreamxmodel( "c_t9_ger_civ_male_urban_body3" );
        forcestreamxmodel( "c_t9_ger_civ_male_head04" );
        forcestreamxmodel( "c_t9_ger_civ_male_urban_body4h" );
        forcestreamxmodel( "c_t9_guard_m_berlin_head02" );
        forcestreamxmodel( "c_t9_ger_civ_male_urban_body1b" );
        forcestreamxmodel( "c_t9_ger_civ_male_head05" );
        forcestreamxmodel( "c_t9_ger_civ_male_urban_body8" );
        forcestreamxmodel( "c_t9_shg_npc_j_hernandez" );
        forcestreamxmodel( "c_t9_net_civ_male_urban_body5b" );
        forcestreamxmodel( "c_t9_ger_civ_male_head07" );
        forcestreamxmodel( "c_t9_ger_civ_male_urban_body10" );
        forcestreamxmodel( "c_t9_ger_civ_male_head01" );
        forcestreamxmodel( "c_t9_ger_civ_male_urban_body5" );
        forcestreamxmodel( "c_t9_ger_civ_male_head02" );
        forcestreamxmodel( "c_t9_ger_civ_male_urban_body5b" );
        forcestreamxmodel( "c_t9_ger_civ_male_head02" );
        forcestreamxmodel( "ndy_cigarette_01" );
        forcestreamxmodel( "par_umbrella_closed_01_85" );
        forcestreamxmodel( "briefcase_prop" );
        forcestreamxmodel( "stk_newspaper_anim_01" );
        return;
    }
    
    stopforcestreamingxmodel( "c_t9_ger_civ_female_urban_07_body3" );
    stopforcestreamingxmodel( "c_t9_ger_civ_female_head02" );
    stopforcestreamingxmodel( "c_t9_net_civ_female_urban_body6" );
    stopforcestreamingxmodel( "c_t9_ger_civ_female_head03" );
    stopforcestreamingxmodel( "c_t9_ger_civ_female_urban_06b_body" );
    stopforcestreamingxmodel( "c_t9_ger_civ_female_head04" );
    stopforcestreamingxmodel( "c_t9_ger_civ_male_urban_body2b" );
    stopforcestreamingxmodel( "c_t9_ger_civ_male_head02" );
    stopforcestreamingxmodel( "c_t9_ger_civ_male_urban_body3" );
    stopforcestreamingxmodel( "c_t9_ger_civ_male_head04" );
    stopforcestreamingxmodel( "c_t9_ger_civ_male_urban_body4h" );
    stopforcestreamingxmodel( "c_t9_guard_m_berlin_head02" );
    stopforcestreamingxmodel( "c_t9_ger_civ_male_urban_body1b" );
    stopforcestreamingxmodel( "c_t9_ger_civ_male_head05" );
    stopforcestreamingxmodel( "c_t9_ger_civ_male_urban_body8" );
    stopforcestreamingxmodel( "c_t9_shg_npc_j_hernandez" );
    stopforcestreamingxmodel( "c_t9_net_civ_male_urban_body5b" );
    stopforcestreamingxmodel( "c_t9_ger_civ_male_head07" );
    stopforcestreamingxmodel( "c_t9_ger_civ_male_urban_body10" );
    stopforcestreamingxmodel( "c_t9_ger_civ_male_head01" );
    stopforcestreamingxmodel( "c_t9_ger_civ_male_urban_body5" );
    stopforcestreamingxmodel( "c_t9_ger_civ_male_head02" );
    stopforcestreamingxmodel( "c_t9_ger_civ_male_urban_body5b" );
    stopforcestreamingxmodel( "c_t9_ger_civ_male_head02" );
    stopforcestreamingxmodel( "ndy_cigarette_01" );
    stopforcestreamingxmodel( "par_umbrella_closed_01_85" );
    stopforcestreamingxmodel( "briefcase_prop" );
    stopforcestreamingxmodel( "stk_newspaper_anim_01" );
}

// Namespace cp_ger_stakeout/cp_ger_stakeout
// Params 7
// Checksum 0x3e1fd99e, Offset: 0x13a0
// Size: 0x2ec
function function_d5fba952( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump )
{
    if ( bwasdemojump )
    {
        forcestreamxmodel( "aac_kitchen_chair_01" );
        forcestreamxmodel( "c_t9_ger_civ_male_head07" );
        forcestreamxmodel( "aac_kitchen_chair_01" );
        forcestreamxmodel( "par_glassware_01" );
        forcestreamxmodel( "par_glassware_03" );
        forcestreamxmodel( "cob_cigarette_pack_01" );
        forcestreamxmodel( "ndy_cigarette_static_01_lit_long" );
        forcestreamxmodel( "decor_ashtray_cigarette_01" );
        forcestreamxmodel( "stk_serving_tray_01" );
        forcestreamxmodel( "stk_glass_beer_bottle_01" );
        forcestreamxmodel( "cob_playing_cards_01" );
        forcestreamxmodel( "stk_cards_playing_single_015" );
        forcestreamxmodel( "generic_prop_x5" );
        forcestreamxmodel( "par_umbrella_open_01_anim" );
        return;
    }
    
    stopforcestreamingxmodel( "aac_kitchen_chair_01" );
    stopforcestreamingxmodel( "c_t9_ger_civ_male_head07" );
    stopforcestreamingxmodel( "aac_kitchen_chair_01" );
    stopforcestreamingxmodel( "par_glassware_01" );
    stopforcestreamingxmodel( "par_glassware_03" );
    stopforcestreamingxmodel( "cob_cigarette_pack_01" );
    stopforcestreamingxmodel( "ndy_cigarette_static_01_lit_long" );
    stopforcestreamingxmodel( "decor_ashtray_cigarette_01" );
    stopforcestreamingxmodel( "stk_serving_tray_01" );
    stopforcestreamingxmodel( "stk_glass_beer_bottle_01" );
    stopforcestreamingxmodel( "cob_playing_cards_01" );
    stopforcestreamingxmodel( "stk_cards_playing_single_015" );
    stopforcestreamingxmodel( "generic_prop_x5" );
    stopforcestreamingxmodel( "par_umbrella_open_01_anim" );
}

// Namespace cp_ger_stakeout/cp_ger_stakeout
// Params 7
// Checksum 0x6dd3cde9, Offset: 0x1698
// Size: 0xd2
function function_e1bea416( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump )
{
    if ( bwasdemojump )
    {
        self endon( #"hash_17bf3ed360080e51" );
        
        while ( true )
        {
            zoom = self waittill( #"camera_zoom" );
            
            if ( zoom.pct > 0.2 )
            {
                self serverfield::set( "kraus_zoom_hint_end", 1 );
                self notify( #"hash_17bf3ed360080e51" );
            }
        }
    }
}

// Namespace cp_ger_stakeout/cp_ger_stakeout
// Params 7
// Checksum 0xe22c7c70, Offset: 0x1778
// Size: 0x26a
function lerp_fov( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump )
{
    switch ( bwasdemojump )
    {
        case 1:
            self easing::function_f95cb457( undefined, 23.9, 0.016, #"linear" );
            break;
        case 2:
            self function_9298adaf( 0.5 );
            break;
        case 3:
            self easing::function_f95cb457( undefined, 20.13, 2, #"linear" );
            self thread dof_enable_autofocus();
            break;
        case 4:
            self function_9298adaf( 2 );
            self thread dof_disable_autofocus();
            break;
        case 5:
            self easing::function_f95cb457( undefined, 21.55, 1, #"linear" );
            self thread dof_enable_autofocus();
            break;
        case 6:
            self function_9298adaf( 1 );
            self thread dof_disable_autofocus();
            break;
        case 0:
        default:
            self function_9298adaf( 0.5 );
            self thread dof_disable_autofocus();
            break;
    }
}

// Namespace cp_ger_stakeout/cp_ger_stakeout
// Params 0
// Checksum 0xb3ca6cae, Offset: 0x19f0
// Size: 0x1ee
function dof_enable_autofocus()
{
    self endoncallback( &function_26826144, #"death", #"disable_autofocus" );
    self function_9e574055( 1 );
    self easing::function_136edb11( undefined, 5.6, 1, #"linear" );
    
    while ( true )
    {
        v_eye = self geteye();
        v_fwd = anglestoforward( self getcamangles() );
        a_trace = physicstrace( v_eye, v_eye + v_fwd * 1000, ( 1 * -1, 1 * -1, 1 * -1 ), ( 1, 1, 1 ), self, 1 );
        var_a84275e3 = distance( v_eye, a_trace[ #"position" ] + v_fwd * 1 );
        
        if ( var_a84275e3 < 100 )
        {
            self function_9e574055( 2 );
        }
        else
        {
            self function_9e574055( 1 );
        }
        
        self function_d7be9a9f( var_a84275e3, 0 );
        waitframe( 1 );
    }
}

// Namespace cp_ger_stakeout/cp_ger_stakeout
// Params 0
// Checksum 0x6b3d5f70, Offset: 0x1be8
// Size: 0x16
function dof_disable_autofocus()
{
    self notify( #"disable_autofocus" );
}

// Namespace cp_ger_stakeout/cp_ger_stakeout
// Params 1
// Checksum 0x711171a3, Offset: 0x1c08
// Size: 0x54
function function_26826144( *str_notify )
{
    self function_9e574055( 0 );
    self function_3c54e2b8( 1 );
    self function_9ea7b4eb( 1 );
}

// Namespace cp_ger_stakeout/cp_ger_stakeout
// Params 7
// Checksum 0x1fec1deb, Offset: 0x1c68
// Size: 0xc4
function pstfx_chromatic_aberration( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump )
{
    if ( bwasdemojump )
    {
        if ( self postfx::function_556665f2( "pstfx_catseye_interactive_cinematic" ) )
        {
            self postfx::stoppostfxbundle( "pstfx_catseye_interactive_cinematic" );
        }
        
        self postfx::playpostfxbundle( "pstfx_catseye_interactive_cinematic" );
        return;
    }
    
    self postfx::exitpostfxbundle( "pstfx_catseye_interactive_cinematic" );
}

// Namespace cp_ger_stakeout/cp_ger_stakeout
// Params 7
// Checksum 0xa14ae784, Offset: 0x1d38
// Size: 0xc4
function pstfx_sprite_rain_loop( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump )
{
    if ( bwasdemojump )
    {
        if ( self postfx::function_556665f2( "pstfx_sprite_rain_loop" ) )
        {
            self postfx::stoppostfxbundle( "pstfx_sprite_rain_loop" );
        }
        
        self postfx::playpostfxbundle( "pstfx_sprite_rain_loop" );
        return;
    }
    
    self postfx::exitpostfxbundle( "pstfx_sprite_rain_loop" );
}

// Namespace cp_ger_stakeout/cp_ger_stakeout
// Params 7
// Checksum 0xfdedf491, Offset: 0x1e08
// Size: 0xc4
function pstfx_sprite_rain_ladder( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump )
{
    if ( bwasdemojump )
    {
        if ( self postfx::function_556665f2( "pstfx_sprite_rain_loop_enter_stage" ) )
        {
            self postfx::stoppostfxbundle( "pstfx_sprite_rain_loop_enter_stage" );
        }
        
        self postfx::playpostfxbundle( "pstfx_sprite_rain_loop_enter_stage" );
        return;
    }
    
    self postfx::exitpostfxbundle( "pstfx_sprite_rain_loop_enter_stage" );
}

// Namespace cp_ger_stakeout/cp_ger_stakeout
// Params 7
// Checksum 0xac78316, Offset: 0x1ed8
// Size: 0x54
function pstfx_head_trauma( *localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump )
{
    self thread function_cd8c0e74();
}

// Namespace cp_ger_stakeout/cp_ger_stakeout
// Params 0
// Checksum 0xbe5ba67f, Offset: 0x1f38
// Size: 0xb4
function function_cd8c0e74()
{
    self notify( "28336b897ff325fd" );
    self endon( "28336b897ff325fd" );
    self endon( #"death" );
    
    if ( self postfx::function_556665f2( "pstfx_head_trauma" ) )
    {
        self postfx::stoppostfxbundle( "pstfx_head_trauma" );
    }
    
    self thread postfx::playpostfxbundle( "pstfx_head_trauma" );
    wait 1.5;
    self thread postfx::exitpostfxbundle( "pstfx_head_trauma" );
}

// Namespace cp_ger_stakeout/cp_ger_stakeout
// Params 7
// Checksum 0xe3093d4, Offset: 0x1ff8
// Size: 0xbe
function function_e80b775e( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump )
{
    if ( bwasdemojump )
    {
        self.var_9028faf2 = util::playfxontag( fieldname, level._effect[ #"guard_room_light" ], self, "tag_fx" );
        return;
    }
    
    if ( isdefined( self.var_9028faf2 ) )
    {
        killfx( fieldname, self.var_9028faf2 );
        self.var_9028faf2 = undefined;
    }
}

// Namespace cp_ger_stakeout/cp_ger_stakeout
// Params 7
// Checksum 0x271be3cc, Offset: 0x20c0
// Size: 0xbe
function sewer_exit_flashlight_fx( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump )
{
    if ( bwasdemojump )
    {
        self.var_103f6c4c = util::playfxontag( fieldname, level._effect[ #"hash_27d555878676deb1" ], self, "tag_light" );
        return;
    }
    
    if ( isdefined( self.var_103f6c4c ) )
    {
        killfx( fieldname, self.var_103f6c4c );
        self.var_103f6c4c = undefined;
    }
}

// Namespace cp_ger_stakeout/cp_ger_stakeout
// Params 7
// Checksum 0xdb66e7d4, Offset: 0x2188
// Size: 0xbe
function darkroom_light( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump )
{
    if ( bwasdemojump )
    {
        self.var_23de4c6c = util::playfxontag( fieldname, level._effect[ #"darkroom_light" ], self, "tag_fx" );
        return;
    }
    
    if ( isdefined( self.var_23de4c6c ) )
    {
        killfx( fieldname, self.var_23de4c6c );
        self.var_23de4c6c = undefined;
    }
}

// Namespace cp_ger_stakeout/cp_ger_stakeout
// Params 7
// Checksum 0xcdeee438, Offset: 0x2250
// Size: 0xbe
function rooftop_spotlight( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump )
{
    if ( bwasdemojump )
    {
        self.var_7a1ac572 = util::playfxontag( fieldname, level._effect[ #"rooftop_spotlight" ], self, "fx_tag_spotlight_script" );
        return;
    }
    
    if ( isdefined( self.var_7a1ac572 ) )
    {
        killfx( fieldname, self.var_7a1ac572 );
        self.var_7a1ac572 = undefined;
    }
}

// Namespace cp_ger_stakeout/cp_ger_stakeout
// Params 7
// Checksum 0x89fe9688, Offset: 0x2318
// Size: 0xbe
function function_c20ade4a( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump )
{
    if ( bwasdemojump )
    {
        self.var_5da1ad93 = playfxoncamera( fieldname, level._effect[ #"player_blacklight" ], ( 0, 0, 0 ), ( 1, 0, -0.1 ), ( 0, 0, 1 ) );
        return;
    }
    
    stopfx( fieldname, self.var_5da1ad93 );
    self.var_5da1ad93 = undefined;
}

// Namespace cp_ger_stakeout/cp_ger_stakeout
// Params 7
// Checksum 0x71ef3e26, Offset: 0x23e0
// Size: 0x8c
function function_b8dc550f( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( bwastimejump )
    {
        self playrenderoverridebundle( #"hash_2e8a19e34993fbc2" );
        return;
    }
    
    self stoprenderoverridebundle( #"hash_2e8a19e34993fbc2" );
}

// Namespace cp_ger_stakeout/cp_ger_stakeout
// Params 7
// Checksum 0xd1c0ce34, Offset: 0x2478
// Size: 0x40c
function render_emissive_blacklight_material( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    player = function_5c10bd79( fieldname );
    
    if ( bwastimejump )
    {
        self flag::set( "draw_mat" );
        self playrenderoverridebundle( #"hash_2e8a19e34993fbc2" );
        self.threshold = 0;
        min_dist = 10;
        min_dist_squared = min_dist * min_dist;
        max_dist = 400;
        var_11ecc9fe = max_dist * max_dist;
        
        while ( self flag::get( "draw_mat" ) )
        {
            eye = getlocalclienteyepos( 0 );
            fwd = anglestoforward( player getcamangles() );
            dotlimit = 0.9781;
            delta = self.origin - eye;
            dir = vectornormalize( delta );
            vector_dot = vectordot( dir, fwd );
            dist = distance2dsquared( self.origin, eye );
            
            if ( vector_dot > dotlimit && dist < var_11ecc9fe )
            {
                range = 0.0219;
                self.threshold = 1 - ( 1 - vector_dot ) / range;
                
                /#
                #/
                
                self.threshold = math::clamp( self.threshold, 0, 1 );
                self function_78233d29( #"hash_2e8a19e34993fbc2", "", #"brightness", self.threshold );
                self function_78233d29( #"hash_2e8a19e34993fbc2", "", #"alpha", self.threshold );
            }
            else
            {
                if ( self.threshold > 0 )
                {
                    self util::lerp_generic( fieldname, 150, &function_9e7290f5, self.threshold, 0 );
                    wait 0.15;
                    self.threshold = 0;
                }
                
                self function_78233d29( #"hash_2e8a19e34993fbc2", "", #"brightness", 0 );
                self function_78233d29( #"hash_2e8a19e34993fbc2", "", #"alpha", 0 );
            }
            
            waitframe( 1 );
        }
        
        return;
    }
    
    self function_f6e99a8d( #"hash_2e8a19e34993fbc2" );
    self flag::clear( "draw_mat" );
}

// Namespace cp_ger_stakeout/cp_ger_stakeout
// Params 3
// Checksum 0x248c1653, Offset: 0x2890
// Size: 0x9c
function fade_bundle( localclientnum, bundle, fadeduration )
{
    self endon( #"death" );
    self util::lerp_generic( localclientnum, fadeduration, &function_9e7290f5, 1, 0, bundle );
    wait float( fadeduration ) / 1000;
    self stoprenderoverridebundle( bundle );
}

// Namespace cp_ger_stakeout/cp_ger_stakeout
// Params 6
// Checksum 0xc24a2939, Offset: 0x2938
// Size: 0xdc
function function_9e7290f5( *currenttime, elapsedtime, *localclientnum, fadeduration, from, to )
{
    percent = localclientnum / fadeduration;
    amount = to * percent + from * ( 1 - percent );
    self function_78233d29( #"hash_2e8a19e34993fbc2", "", #"brightness", amount );
    self function_78233d29( #"hash_2e8a19e34993fbc2", "", #"alpha", amount );
}

// Namespace cp_ger_stakeout/cp_ger_stakeout
// Params 7
// Checksum 0xc7205ecf, Offset: 0x2a20
// Size: 0xc4
function function_5568fbbb( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( bwastimejump == 1 )
    {
        if ( !self postfx::function_556665f2( "pstfx_takedown_wreck_vision" ) )
        {
            self postfx::playpostfxbundle( "pstfx_takedown_wreck_vision" );
        }
        
        return;
    }
    
    if ( self postfx::function_556665f2( "pstfx_takedown_wreck_vision" ) )
    {
        self postfx::exitpostfxbundle( "pstfx_takedown_wreck_vision" );
    }
}

