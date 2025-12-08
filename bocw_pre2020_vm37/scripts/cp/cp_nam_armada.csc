#using script_13263926d775e7d7;
#using script_140d5347de8af85c;
#using script_280ea497b298d2e;
#using script_38867f943fb86135;
#using scripts\core_common\animation_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\easing;
#using scripts\core_common\load_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\util_shared;

#namespace cp_nam_armada;

// Namespace cp_nam_armada/level_init
// Params 1, eflags: 0x40
// Checksum 0xc56b7dd9, Offset: 0x268
// Size: 0x1cc
function event_handler[level_init] main( *eventstruct )
{
    setsaveddvar( #"enable_global_wind", 1 );
    setsaveddvar( #"wind_global_vector", "88 0 0" );
    setsaveddvar( #"wind_global_low_altitude", 0 );
    setsaveddvar( #"wind_global_hi_altitude", 10000 );
    setsaveddvar( #"wind_global_low_strength_percent", 100 );
    init_clientfields();
    level._effect[ #"hash_2a1d270f13c9e4e8" ] = #"hash_224ea61b958bad13";
    level._effect[ #"hash_12368454c367c6fc" ] = #"hash_41db1a73a41027b";
    load::main();
    level thread namespace_72b0499b::init_audio();
    util::waitforclient( 0 );
    level thread function_578ff07e();
    players = getlocalplayers();
    allowactionslotinput( players[ 0 ] getlocalclientnumber() );
}

// Namespace cp_nam_armada/cp_nam_armada
// Params 0
// Checksum 0xfa27a692, Offset: 0x440
// Size: 0x364
function init_clientfields()
{
    clientfield::register( "toplayer", "pstfx_sprite_rain_loop", 1, 1, "int", &pstfx_sprite_rain_loop, 0, 0 );
    clientfield::register( "toplayer", "pstfx_slowed", 1, 1, "int", &pstfx_slowed, 0, 0 );
    clientfield::register( "toplayer", "pstfx_vignette", 1, 1, "int", &pstfx_vignette, 0, 0 );
    clientfield::register( "vehicle", "firebase_smoke_fx", 1, 1, "int", &firebase_smoke_fx, 0, 0 );
    clientfield::register( "vehicle", "bamboo_heli_landing_rain_fx", 1, 1, "int", &bamboo_heli_landing_rain_fx, 0, 0 );
    clientfield::register( "vehicle", "adler_chopper_mortar_village", 1, 1, "int", &function_8617decb, 0, 0 );
    clientfield::register( "toplayer", "ease_to_dialog_dof", 1, 1, "int", &ease_to_dialog_dof, 0, 0 );
    clientfield::register( "toplayer", "lerp_fov", 1, 3, "int", &lerp_fov, 0, 1 );
    clientfield::register( "toplayer", "postfx_bundle_explosive_damage", 1, 1, "int", &postfx_bundle_explosive_damage, 0, 0 );
    clientfield::register( "toplayer", "pstfx_script_vignette", 1, 2, "int", &namespace_f180c0d7::pstfx_script_vignette, 0, 0 );
    clientfield::register( "toplayer", "forest_pbg_switch", 1, 1, "int", &forest_pbg_switch, 0, 0 );
    clientfield::register( "world", "toggle_gameplay_character_visibility", 1, 1, "int", &toggle_gameplay_character_visibility, 0, 0 );
}

// Namespace cp_nam_armada/cp_nam_armada
// Params 7
// Checksum 0xa5b0d5c6, Offset: 0x7b0
// Size: 0x7c
function toggle_gameplay_character_visibility( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump )
{
    waitframe( 1 );
    
    if ( bwasdemojump )
    {
        util::function_8eb5d4b0( 1500, 5 );
        return;
    }
    
    util::function_21aef83c();
}

// Namespace cp_nam_armada/cp_nam_armada
// Params 7
// Checksum 0xb35ac9ce, Offset: 0x838
// Size: 0x3c
function lerp_fov( *localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump )
{
    
}

// Namespace cp_nam_armada/cp_nam_armada
// Params 0
// Checksum 0x65f0202, Offset: 0x880
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

// Namespace cp_nam_armada/cp_nam_armada
// Params 0
// Checksum 0xffc470cf, Offset: 0xa78
// Size: 0x16
function dof_disable_autofocus()
{
    self notify( #"disable_autofocus" );
}

// Namespace cp_nam_armada/cp_nam_armada
// Params 1
// Checksum 0x199c7edd, Offset: 0xa98
// Size: 0x54
function function_26826144( *str_notify )
{
    self function_9e574055( 0 );
    self function_3c54e2b8( 1 );
    self function_9ea7b4eb( 1 );
}

// Namespace cp_nam_armada/cp_nam_armada
// Params 7
// Checksum 0xb2248674, Offset: 0xaf8
// Size: 0x10c
function ease_to_dialog_dof( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( bwastimejump == 1 )
    {
        self function_9e574055( 2 );
        self easing::function_b6f1c993( undefined, 60, 1, #"linear" );
        self easing::function_136edb11( undefined, 1, 1, #"linear" );
        return;
    }
    
    self easing::function_b6f1c993( undefined, 10000, 2, #"linear" );
    self easing::function_136edb11( undefined, 50, 2, #"linear" );
}

// Namespace cp_nam_armada/cp_nam_armada
// Params 7
// Checksum 0xd6a4f, Offset: 0xc10
// Size: 0xa4
function firebase_smoke_fx( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( bwastimejump )
    {
        self.var_ec09db0e = self util::playfxontag( fieldname, level._effect[ #"hash_2a1d270f13c9e4e8" ], self, "tag_origin" );
        return;
    }
    
    stopfx( fieldname, self.var_ec09db0e );
}

// Namespace cp_nam_armada/cp_nam_armada
// Params 7
// Checksum 0xc628f7ed, Offset: 0xcc0
// Size: 0xa4
function bamboo_heli_landing_rain_fx( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( bwastimejump )
    {
        self.var_40e9c967 = self util::playfxontag( fieldname, level._effect[ #"hash_12368454c367c6fc" ], self, "tag_origin" );
        return;
    }
    
    stopfx( fieldname, self.var_40e9c967 );
}

// Namespace cp_nam_armada/cp_nam_armada
// Params 7
// Checksum 0x991e9865, Offset: 0xd70
// Size: 0x84
function function_8617decb( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( bwastimejump )
    {
        self function_9974c822( "cp_nam_armada_helicopter" );
        return;
    }
    
    self function_5dcc74d1( "cp_nam_armada_helicopter" );
}

// Namespace cp_nam_armada/cp_nam_armada
// Params 7
// Checksum 0x33e645ec, Offset: 0xe00
// Size: 0xc4
function pstfx_sprite_rain_loop( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump )
{
    if ( bwasdemojump )
    {
        if ( self postfx::function_556665f2( "pstfx_t9_sprite_heli_spray_r" ) )
        {
            self postfx::stoppostfxbundle( "pstfx_t9_sprite_heli_spray_r" );
        }
        
        self postfx::playpostfxbundle( "pstfx_t9_sprite_heli_spray_r" );
        return;
    }
    
    self postfx::exitpostfxbundle( "pstfx_t9_sprite_heli_spray_r" );
}

// Namespace cp_nam_armada/cp_nam_armada
// Params 0
// Checksum 0xb23c2c63, Offset: 0xed0
// Size: 0xde
function function_578ff07e()
{
    while ( true )
    {
        fov = getdvarfloat( #"cg_fov", 60 );
        started = 0;
        
        while ( !started )
        {
            active = getdvarint( #"hash_4fd2de7c0e3c131a", 0 );
            
            if ( active )
            {
                started = 1;
                break;
            }
            
            waitframe( 1 );
        }
        
        players = getlocalplayers();
        players[ 0 ] function_49cdf043( fov, 0 );
        waitframe( 1 );
    }
}

// Namespace cp_nam_armada/cp_nam_armada
// Params 7
// Checksum 0xb939347d, Offset: 0xfb8
// Size: 0xf4
function pstfx_slowed( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump )
{
    if ( bwasdemojump )
    {
        if ( self postfx::function_556665f2( "pstfx_slowed" ) )
        {
            self postfx::stoppostfxbundle( "pstfx_slowed" );
        }
        
        self postfx::playpostfxbundle( "pstfx_slowed" );
        self postfx::function_c8b5f318( "pstfx_slowed", "Blur", 0.02 );
        return;
    }
    
    self postfx::exitpostfxbundle( "pstfx_slowed" );
}

// Namespace cp_nam_armada/cp_nam_armada
// Params 7
// Checksum 0x3b9ecdfe, Offset: 0x10b8
// Size: 0xc4
function pstfx_vignette( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump )
{
    if ( bwasdemojump )
    {
        if ( self postfx::function_556665f2( "pstfx_vignette" ) )
        {
            self postfx::stoppostfxbundle( "pstfx_vignette" );
        }
        
        self postfx::playpostfxbundle( "pstfx_vignette" );
        return;
    }
    
    self postfx::exitpostfxbundle( "pstfx_vignette" );
}

// Namespace cp_nam_armada/cp_nam_armada
// Params 7
// Checksum 0x30b402ad, Offset: 0x1188
// Size: 0xc4
function postfx_bundle_explosive_damage( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump )
{
    if ( bwasdemojump )
    {
        if ( self postfx::function_556665f2( "postfx_bundle_explosive_damage" ) )
        {
            self postfx::stoppostfxbundle( "postfx_bundle_explosive_damage" );
        }
        
        self postfx::playpostfxbundle( "postfx_bundle_explosive_damage" );
        return;
    }
    
    self postfx::exitpostfxbundle( "postfx_bundle_explosive_damage" );
}

// Namespace cp_nam_armada/cp_nam_armada
// Params 7
// Checksum 0x139aa655, Offset: 0x1258
// Size: 0xb4
function forest_pbg_switch( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump )
{
    if ( bwasdemojump == 1 )
    {
        setexposureactivebank( fieldname, 2 );
        setpbgactivebank( fieldname, 2 );
        return;
    }
    
    setexposureactivebank( fieldname, 1 );
    setpbgactivebank( fieldname, 1 );
}

