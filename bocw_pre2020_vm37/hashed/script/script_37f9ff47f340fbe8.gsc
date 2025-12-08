#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace easing;

// Namespace easing/namespace_df0c90a5
// Params 0, eflags: 0x6
// Checksum 0xe6b52751, Offset: 0x78
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"easing", &ease_init, undefined, undefined, undefined );
}

// Namespace easing/namespace_df0c90a5
// Params 0
// Checksum 0x7393520, Offset: 0xc0
// Size: 0x1ec
function ease_init()
{
    level.ease_funcs = [];
    level.ease_funcs[ #"linear" ] = &ease_linear;
    level.ease_funcs[ #"power" ] = &ease_power;
    level.ease_funcs[ #"quadratic" ] = &ease_quadratic;
    level.ease_funcs[ #"cubic" ] = &ease_cubic;
    level.ease_funcs[ #"quartic" ] = &ease_quartic;
    level.ease_funcs[ #"quintic" ] = &ease_quintic;
    level.ease_funcs[ #"exponential" ] = &ease_exponential;
    level.ease_funcs[ #"logarithmic" ] = &ease_logarithmic;
    level.ease_funcs[ #"sine" ] = &ease_sine;
    level.ease_funcs[ #"back" ] = &ease_back;
    level.ease_funcs[ #"elastic" ] = &ease_elastic;
    level.ease_funcs[ #"bounce" ] = &ease_bounce;
}

// Namespace easing/namespace_df0c90a5
// Params 5
// Checksum 0xaf2dbf16, Offset: 0x2b8
// Size: 0x46
function ease_linear( start, end, pct, *ease_in, *ease_out )
{
    return ( 1 - ease_out ) * pct + ease_out * ease_in;
}

// Namespace easing/namespace_df0c90a5
// Params 6
// Checksum 0x2c39d726, Offset: 0x308
// Size: 0x72
function ease_power( start, end, pct, ease_in, ease_out, power )
{
    pct = easepower( pct, power, ease_in, ease_out );
    return ( 1 - pct ) * start + pct * end;
}

// Namespace easing/namespace_df0c90a5
// Params 5
// Checksum 0x52c3dda9, Offset: 0x388
// Size: 0x6a
function ease_quadratic( start, end, pct, ease_in, ease_out )
{
    pct = easepower( pct, 2, ease_in, ease_out );
    return ( 1 - pct ) * start + pct * end;
}

// Namespace easing/namespace_df0c90a5
// Params 5
// Checksum 0x2b81f3d9, Offset: 0x400
// Size: 0x6a
function ease_cubic( start, end, pct, ease_in, ease_out )
{
    pct = easepower( pct, 3, ease_in, ease_out );
    return ( 1 - pct ) * start + pct * end;
}

// Namespace easing/namespace_df0c90a5
// Params 5
// Checksum 0xa0427bf4, Offset: 0x478
// Size: 0x6a
function ease_quartic( start, end, pct, ease_in, ease_out )
{
    pct = easepower( pct, 4, ease_in, ease_out );
    return ( 1 - pct ) * start + pct * end;
}

// Namespace easing/namespace_df0c90a5
// Params 5
// Checksum 0x1e608c46, Offset: 0x4f0
// Size: 0x6a
function ease_quintic( start, end, pct, ease_in, ease_out )
{
    pct = easepower( pct, 5, ease_in, ease_out );
    return ( 1 - pct ) * start + pct * end;
}

// Namespace easing/namespace_df0c90a5
// Params 6
// Checksum 0xaaa08a05, Offset: 0x568
// Size: 0x72
function ease_exponential( start, end, pct, ease_in, ease_out, scale )
{
    pct = easeexponential( pct, scale, ease_in, ease_out );
    return ( 1 - pct ) * start + pct * end;
}

// Namespace easing/namespace_df0c90a5
// Params 6
// Checksum 0x71a02f06, Offset: 0x5e8
// Size: 0x72
function ease_logarithmic( start, end, pct, ease_in, ease_out, log_base )
{
    pct = easelogarithmic( pct, log_base, ease_in, ease_out );
    return ( 1 - pct ) * start + pct * end;
}

// Namespace easing/namespace_df0c90a5
// Params 5
// Checksum 0xa0638f9e, Offset: 0x668
// Size: 0x62
function ease_sine( start, end, pct, ease_in, ease_out )
{
    pct = easesine( pct, ease_in, ease_out );
    return ( 1 - pct ) * start + pct * end;
}

// Namespace easing/namespace_df0c90a5
// Params 7
// Checksum 0x2cf57ddc, Offset: 0x6d8
// Size: 0x7a
function ease_back( start, end, pct, ease_in, ease_out, overshoot_scalar, power )
{
    pct = easeback( pct, overshoot_scalar, power, ease_in, ease_out );
    return ( 1 - pct ) * start + pct * end;
}

// Namespace easing/namespace_df0c90a5
// Params 8
// Checksum 0xa1258e3e, Offset: 0x760
// Size: 0x82
function ease_elastic( start, end, pct, ease_in, ease_out, amplitude, frequency, fade_scalar )
{
    pct = easeelastic( pct, amplitude, frequency, fade_scalar, ease_in, ease_out );
    return ( 1 - pct ) * start + pct * end;
}

// Namespace easing/namespace_df0c90a5
// Params 7
// Checksum 0xccbe0c35, Offset: 0x7f0
// Size: 0x7a
function ease_bounce( start, end, pct, ease_in, ease_out, bounces, decay_scalar )
{
    pct = easebounce( pct, bounces, decay_scalar, ease_in, ease_out );
    return ( 1 - pct ) * start + pct * end;
}

// Namespace easing/namespace_df0c90a5
// Params 3
// Checksum 0x1eef6733, Offset: 0x878
// Size: 0x74
function function_8ff186e5( var_b3160f0, dvar, var_c7ec7d60 )
{
    if ( is_true( var_c7ec7d60 ) )
    {
        setsaveddvar( dvar, var_b3160f0.cur_value );
        return;
    }
    
    setdvar( dvar, var_b3160f0.cur_value );
}

// Namespace easing/namespace_df0c90a5
// Params 2
// Checksum 0x8264d34f, Offset: 0x8f8
// Size: 0x112
function function_54354e4e( var_b3160f0, axis )
{
    switch ( axis )
    {
        case 0:
            self.origin = ( var_b3160f0.cur_value, self.origin[ 1 ], self.origin[ 2 ] );
            break;
        case 1:
            self.origin = ( self.origin[ 0 ], var_b3160f0.cur_value, self.origin[ 2 ] );
            break;
        case 2:
            self.origin = ( self.origin[ 0 ], self.origin[ 1 ], var_b3160f0.cur_value );
            break;
        default:
            self.origin = var_b3160f0.cur_value;
            break;
    }
}

// Namespace easing/namespace_df0c90a5
// Params 2
// Checksum 0x397eff90, Offset: 0xa18
// Size: 0xfa
function function_92b063ff( var_b3160f0, axis )
{
    switch ( axis )
    {
        case 0:
            self.origin += ( var_b3160f0.delta, 0, 0 );
            break;
        case 1:
            self.origin += ( 0, var_b3160f0.delta, 0 );
            break;
        case 2:
            self.origin += ( 0, 0, var_b3160f0.delta );
            break;
        default:
            self.origin += var_b3160f0.delta;
            break;
    }
}

// Namespace easing/namespace_df0c90a5
// Params 2
// Checksum 0x3af8de03, Offset: 0xb20
// Size: 0x104
function function_3b3f9801( var_b3160f0, axis )
{
    var_cad5b24d = float( function_60d95f53() ) / 1000;
    angles = var_b3160f0.cur_value;
    
    switch ( axis )
    {
        case 0:
            angles = ( angles, 0, 0 );
            break;
        case 1:
            angles = ( 0, angles, 0 );
            break;
        case 2:
            angles = ( 0, 0, angles );
            break;
    }
    
    self rotateto( var_b3160f0.cur_value, var_cad5b24d );
}

// Namespace easing/namespace_df0c90a5
// Params 2
// Checksum 0x78275994, Offset: 0xc30
// Size: 0x16e
function function_faea843b( var_b3160f0, axis )
{
    switch ( axis )
    {
        case 0:
            self.angles += ( var_b3160f0.delta, 0, 0 );
            break;
        case 1:
            self.angles += ( 0, var_b3160f0.delta, 0 );
            break;
        case 2:
            self.angles += ( 0, 0, var_b3160f0.delta );
            break;
        default:
            self.angles += var_b3160f0.delta;
            break;
    }
    
    if ( var_b3160f0.var_37e98bce )
    {
        self.angles = ( angleclamp180( self.angles[ 0 ] ), angleclamp180( self.angles[ 1 ] ), angleclamp180( self.angles[ 2 ] ) );
    }
}

