#using script_38867f943fb86135;
#using script_6f47ce61add0f75d;
#using script_7198e82f67d7691;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\easing;
#using scripts\core_common\flashlight;
#using scripts\core_common\load_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\util_shared;

#namespace cp_rus_kgb;

// Namespace cp_rus_kgb/level_init
// Params 1, eflags: 0x40
// Checksum 0x946694c6, Offset: 0x4f8
// Size: 0x104
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
}

// Namespace cp_rus_kgb/cp_rus_kgb
// Params 0
// Checksum 0x17752b30, Offset: 0x608
// Size: 0x4dc
function init_clientfields()
{
    clientfield::register( "toplayer", "set_player_pbg_bank", 1, 2, "int", &set_player_pbg_bank, 0, 0 );
    clientfield::register( "actor", "set_flashlight_fx", 1, 1, "int", &set_flashlight_fx, 0, 0 );
    clientfield::register( "scriptmover", "set_camera_fx", 1, 1, "int", &set_camera_fx, 0, 0 );
    clientfield::register( "scriptmover", "vault_torch_vfx", 1, 1, "int", &vault_torch_vfx, 0, 0 );
    evidence_board_mission_preview::register();
    clientfield::register( "toplayer", "set_fov", 1, 3, "int", &set_fov, 0, 0 );
    clientfield::register( "toplayer", "set_dof", 1, 3, "int", &set_dof, 0, 0 );
    clientfield::register( "world", "elevator_hall_dmg_models_and_vol_decals", 1, 1, "int", &function_a61974ab, 0, 1 );
    clientfield::register( "world", "exfil_cover_models", 1, 1, "int", &function_79ff9f83, 0, 1 );
    clientfield::register( "world", "vault_breach_dmg_models_and_vol_decals", 1, 1, "int", &function_d1d32f56, 0, 1 );
    clientfield::register( "scriptmover", "clf_rob_char_burn", 1, 1, "int", &function_45ff448a, 0, 0 );
    clientfield::register( "scriptmover", "clf_rob_torch_cut", 1, 1, "int", &function_6d565158, 0, 0 );
    clientfield::register( "scriptmover", "vault_hanging_light_vfx", 1, 1, "int", &vault_hanging_light_vfx, 0, 0 );
    clientfield::register( "scriptmover", "clf_fx_c4_on", 1, 1, "int", &function_12315dac, 0, 0 );
    clientfield::register( "scriptmover", "clf_fx_c4_blink", 1, 1, "int", &function_f8229597, 0, 0 );
    clientfield::register( "toplayer", "gasmask_clf", 1, 1, "int", &function_e067b5e6, 0, 0 );
    clientfield::register( "toplayer", "exfilmask_clf", 1, 1, "int", &function_4479bcfe, 0, 0 );
    clientfield::register( "toplayer", "stream_elevator_exfil_assets", 1, 1, "int", &stream_elevator_exfil_assets, 0, 0 );
}

// Namespace cp_rus_kgb/cp_rus_kgb
// Params 7
// Checksum 0x2fe9d64, Offset: 0xaf0
// Size: 0x2c2
function function_a61974ab( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    a_n_decals = findvolumedecalindexarray( "elevator_hall_dmg_vol_decals" );
    var_648616bf = findstaticmodelindexarray( "elevator_hall_dmg_models" );
    
    switch ( bwastimejump )
    {
        case 0:
            foreach ( n_decal in a_n_decals )
            {
                hidevolumedecal( n_decal );
            }
            
            foreach ( model in var_648616bf )
            {
                hidestaticmodel( model );
            }
            
            break;
        case 1:
            foreach ( model in var_648616bf )
            {
                unhidestaticmodel( model );
            }
            
            foreach ( n_decal in a_n_decals )
            {
                unhidevolumedecal( n_decal );
            }
            
            break;
        default:
            break;
    }
}

// Namespace cp_rus_kgb/cp_rus_kgb
// Params 7
// Checksum 0xe5f7177, Offset: 0xdc0
// Size: 0x3d2
function function_d1d32f56( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    var_689aebca = findstaticmodelindexarray( "vault_breach_undamaged_models" );
    a_n_decals = findvolumedecalindexarray( "vault_breach_dmg_vol_decals" );
    var_648616bf = findstaticmodelindexarray( "vault_breach_dmg_models" );
    
    switch ( bwastimejump )
    {
        case 0:
            foreach ( n_decal in a_n_decals )
            {
                hidevolumedecal( n_decal );
            }
            
            foreach ( model in var_648616bf )
            {
                hidestaticmodel( model );
            }
            
            foreach ( model in var_689aebca )
            {
                unhidestaticmodel( model );
            }
            
            break;
        case 1:
            foreach ( n_decal in a_n_decals )
            {
                unhidevolumedecal( n_decal );
            }
            
            foreach ( model in var_648616bf )
            {
                unhidestaticmodel( model );
            }
            
            foreach ( model in var_689aebca )
            {
                hidestaticmodel( model );
            }
            
            break;
        default:
            break;
    }
}

// Namespace cp_rus_kgb/cp_rus_kgb
// Params 7
// Checksum 0x9d87edd8, Offset: 0x11a0
// Size: 0x2ba
function function_79ff9f83( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    var_648616bf = findstaticmodelindexarray( "exfil_cover_models" );
    var_1fb7432d = findstaticmodelindexarray( "exfil_cover_models_og" );
    
    switch ( bwastimejump )
    {
        case 0:
            foreach ( model in var_648616bf )
            {
                hidestaticmodel( model );
            }
            
            foreach ( model in var_1fb7432d )
            {
                unhidestaticmodel( model );
            }
            
            break;
        case 1:
            foreach ( model in var_648616bf )
            {
                unhidestaticmodel( model );
            }
            
            foreach ( model in var_1fb7432d )
            {
                hidestaticmodel( model );
            }
            
            break;
        default:
            break;
    }
}

// Namespace cp_rus_kgb/cp_rus_kgb
// Params 7
// Checksum 0x6764532d, Offset: 0x1468
// Size: 0x172
function set_player_pbg_bank( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump )
{
    self notify( #"hash_2866809d9cfd329b" );
    
    switch ( bwasdemojump )
    {
        case 1:
            function_be93487f( fieldname, 2, 0, 1, 0, 0 );
            break;
        case 2:
            self thread function_22f4412d( fieldname );
            break;
        case 3:
            function_be93487f( fieldname, 8, 0, 0, 0, 1 );
            break;
        default:
            function_be93487f( fieldname, 1, 1, 0, 0, 0 );
            break;
    }
}

// Namespace cp_rus_kgb/cp_rus_kgb
// Params 2, eflags: 0x4
// Checksum 0xc93f45d9, Offset: 0x15e8
// Size: 0xfc
function private function_22f4412d( localclientnum, transitiontime = 5 )
{
    self notify( "2a855b3860b0ec15" );
    self endon( "2a855b3860b0ec15" );
    self endon( #"death", #"hash_2866809d9cfd329b" );
    progress = 0;
    increment = 1 / transitiontime / 0.016;
    
    while ( progress < 1 )
    {
        function_be93487f( localclientnum, 5, 1, 0, progress, 0 );
        progress += increment;
        waitframe( 1 );
    }
    
    function_be93487f( localclientnum, 4, 0, 0, 1, 0 );
}

// Namespace cp_rus_kgb/cp_rus_kgb
// Params 7
// Checksum 0x6f3d3a87, Offset: 0x16f0
// Size: 0xb4
function set_flashlight_fx( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump )
{
    switch ( bwasdemojump )
    {
        case 1:
            flashlightfx = "maps/cp_kgb/fx9_kgb_lo_flashlight";
            break;
        default:
            flashlightfx = "light/fx9_light_cp_flashlight";
            break;
    }
    
    self flashlight::function_69258685( fieldname, flashlightfx );
}

// Namespace cp_rus_kgb/cp_rus_kgb
// Params 7
// Checksum 0x8810b5da, Offset: 0x17b0
// Size: 0x192
function set_fov( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    n_time = 0.5;
    
    switch ( bwastimejump )
    {
        case 1:
            self function_9298adaf( 1 );
            break;
        case 2:
            self easing::function_f95cb457( undefined, 17, n_time, #"linear" );
            break;
        case 3:
            self easing::function_f95cb457( undefined, 20, n_time, #"linear" );
            break;
        case 4:
            self easing::function_f95cb457( undefined, 25, n_time, #"linear" );
            break;
        case 5:
            self easing::function_f95cb457( undefined, 30, n_time, #"linear" );
            break;
    }
}

// Namespace cp_rus_kgb/cp_rus_kgb
// Params 7
// Checksum 0x990c1e5e, Offset: 0x1950
// Size: 0x192
function set_dof( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    n_time = 0.5;
    
    switch ( bwastimejump )
    {
        case 1:
            self function_9e574055( 0 );
            self function_3c54e2b8( n_time );
            self function_9ea7b4eb( n_time );
            break;
        case 2:
            self function_9e574055( 2 );
            self function_1816c600( 1.5, n_time );
            self function_d7be9a9f( 50, n_time );
            break;
        case 3:
            self function_9e574055( 2 );
            self function_1816c600( 1.5, n_time );
            self function_d7be9a9f( 90, n_time );
            break;
    }
}

// Namespace cp_rus_kgb/cp_rus_kgb
// Params 7
// Checksum 0x515686be, Offset: 0x1af0
// Size: 0xae
function set_camera_fx( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump )
{
    if ( bwasdemojump == 1 )
    {
        self.var_ace0380 = util::playfxontag( fieldname, "maps/cp_kgb/fx9_kgb_camera_fov", self, "tag_origin" );
        return;
    }
    
    if ( isdefined( self.var_ace0380 ) )
    {
        killfx( fieldname, self.var_ace0380 );
        self.var_7a1ac572 = undefined;
    }
}

// Namespace cp_rus_kgb/cp_rus_kgb
// Params 7
// Checksum 0xaa424a74, Offset: 0x1ba8
// Size: 0x9c
function vault_torch_vfx( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump )
{
    if ( bwasdemojump == 1 )
    {
        self.vault_torch_vfx = util::playfxontag( fieldname, #"hash_5e3ecff0db09def2", self, "tag_fx" );
        return;
    }
    
    killfx( fieldname, self.vault_torch_vfx );
}

// Namespace cp_rus_kgb/cp_rus_kgb
// Params 7, eflags: 0x4
// Checksum 0xbdac19d6, Offset: 0x1c50
// Size: 0xb2
function private function_45ff448a( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    switch ( bwastimejump )
    {
        case 0:
            self function_f6e99a8d( "rob_p9_cp_kgb_character_burn" );
            break;
        case 1:
            self playrenderoverridebundle( "rob_p9_cp_kgb_character_burn" );
            break;
    }
}

// Namespace cp_rus_kgb/cp_rus_kgb
// Params 7, eflags: 0x4
// Checksum 0x9a7a12ff, Offset: 0x1d10
// Size: 0xb2
function private function_6d565158( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    switch ( bwastimejump )
    {
        case 0:
            self function_f6e99a8d( "rob_p9_cp_kgb_torch_cut" );
            break;
        case 1:
            self playrenderoverridebundle( "rob_p9_cp_kgb_torch_cut" );
            break;
    }
}

// Namespace cp_rus_kgb/cp_rus_kgb
// Params 7, eflags: 0x4
// Checksum 0xa01ab59c, Offset: 0x1dd0
// Size: 0xae
function private function_12315dac( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( bwastimejump )
    {
        fxid = util::playfxontag( fieldname, "maps/cp_kgb/fx9_kgb_c4_light_green", self, "tag_origin" );
        self thread function_e360e5ab( fieldname, fxid, "stop_c4_on_fx" );
        return;
    }
    
    self notify( #"stop_c4_on_fx" );
}

// Namespace cp_rus_kgb/cp_rus_kgb
// Params 7, eflags: 0x4
// Checksum 0x8ad3fd00, Offset: 0x1e88
// Size: 0xae
function private function_f8229597( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( bwastimejump )
    {
        fxid = util::playfxontag( fieldname, "maps/cp_kgb/fx9_kgb_c4_light_red", self, "tag_origin" );
        self thread function_e360e5ab( fieldname, fxid, "stop_c4_blink_fx" );
        return;
    }
    
    self notify( #"stop_c4_blink_fx" );
}

// Namespace cp_rus_kgb/cp_rus_kgb
// Params 3, eflags: 0x4
// Checksum 0x61292138, Offset: 0x1f40
// Size: 0x5c
function private function_e360e5ab( localclientnum, fxid, end_notify )
{
    self waittill( #"death", #"fx_death", end_notify );
    stopfx( localclientnum, fxid );
}

// Namespace cp_rus_kgb/cp_rus_kgb
// Params 7, eflags: 0x4
// Checksum 0x62c52e60, Offset: 0x1fa8
// Size: 0xc4
function private function_e067b5e6( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( bwastimejump )
    {
        if ( self postfx::function_556665f2( "pstfx_gasmask_cp" ) )
        {
            self postfx::stoppostfxbundle( "pstfx_gasmask_cp" );
        }
        
        self postfx::playpostfxbundle( "pstfx_gasmask_cp" );
        return;
    }
    
    self postfx::stoppostfxbundle( "pstfx_gasmask_cp" );
}

// Namespace cp_rus_kgb/cp_rus_kgb
// Params 7, eflags: 0x4
// Checksum 0x66118d0c, Offset: 0x2078
// Size: 0xc4
function private function_4479bcfe( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( bwastimejump )
    {
        if ( self postfx::function_556665f2( "pstfx_exfilmask_cp" ) )
        {
            self postfx::stoppostfxbundle( "pstfx_exfilmask_cp" );
        }
        
        self postfx::playpostfxbundle( "pstfx_exfilmask_cp" );
        return;
    }
    
    self postfx::stoppostfxbundle( "pstfx_exfilmask_cp" );
}

// Namespace cp_rus_kgb/cp_rus_kgb
// Params 7
// Checksum 0xed12eb8a, Offset: 0x2148
// Size: 0xac
function stream_elevator_exfil_assets( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump )
{
    if ( bwasdemojump )
    {
        forcestreamxmodel( "c_t9_cp_usa_hero_adler_kgb_exfil_armor" );
        forcestreamxmodel( "c_t9_cp_rus_kgb_hq_vip_belikov_exfil" );
        return;
    }
    
    stopforcestreamingxmodel( "c_t9_cp_usa_hero_adler_kgb_exfil_armor" );
    stopforcestreamingxmodel( "c_t9_cp_rus_kgb_hq_vip_belikov_exfil" );
}

// Namespace cp_rus_kgb/cp_rus_kgb
// Params 7
// Checksum 0x875aae30, Offset: 0x2200
// Size: 0xae
function vault_hanging_light_vfx( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( bwastimejump )
    {
        self.var_a2f0a0e3 = util::playfxontag( fieldname, "light/fx9_light_cp_kgb_vault_hanging", self, "tag_fx" );
        return;
    }
    
    if ( isdefined( self.var_a2f0a0e3 ) )
    {
        killfx( fieldname, self.var_a2f0a0e3 );
        self.var_a2f0a0e3 = undefined;
    }
}

