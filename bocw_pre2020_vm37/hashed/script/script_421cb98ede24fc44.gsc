#using script_3dc93ca9902a9cda;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;

#namespace namespace_31aff1e6;

// Namespace namespace_31aff1e6/namespace_31aff1e6
// Params 0, eflags: 0x6
// Checksum 0x569f7812, Offset: 0x1d8
// Size: 0x4c
function private autoexec __init__system__()
{
    system::register( #"ice_slide", &preload, &postload, undefined, undefined );
}

// Namespace namespace_31aff1e6/namespace_31aff1e6
// Params 0
// Checksum 0x33fc094b, Offset: 0x230
// Size: 0xf4
function preload()
{
    clientfield::register( "toplayer", "ice_slide_postfx", 1, 1, "int" );
    clientfield::register( "toplayer", "ice_slide_looping_fx", 1, 2, "int" );
    clientfield::register( "toplayer", "ice_slide_landing_fx", 1, 2, "int" );
    clientfield::register( "toplayer", "ice_slide_dof", 1, 3, "int" );
    clientfield::register( "toplayer", "ice_slide_fov", 1, 1, "int" );
}

// Namespace namespace_31aff1e6/namespace_31aff1e6
// Params 0
// Checksum 0xc2dda917, Offset: 0x330
// Size: 0xb8
function postload()
{
    var_547465a0 = getentarray( "ice_slide", "targetname" );
    
    foreach ( var_fa0bcfcc in var_547465a0 )
    {
        var_fa0bcfcc callback::on_trigger( &function_a8fc3bf1 );
    }
}

// Namespace namespace_31aff1e6/namespace_31aff1e6
// Params 1
// Checksum 0x3c8f57d, Offset: 0x3f0
// Size: 0x7bc
function function_a8fc3bf1( s_info )
{
    e_player = s_info.activator;
    
    if ( isalive( e_player ) && !is_true( e_player.var_6a81e560 ) )
    {
        e_player.var_6a81e560 = 1;
        e_player playrumbleonentity( #"jump_rumble_start" );
        snd::play( "evt_slide_downhill_start_lr", e_player );
        var_24559b62 = snd::play( "evt_slide_downhill_loop_lr", e_player );
        e_player playrumblelooponentity( #"buzz_high" );
        e_player thread function_2915e3aa();
        e_player setmovespeedscale( 0 );
        
        if ( !is_true( self.var_859762f6 ) )
        {
            e_player thread function_803405ff();
            e_player val::set( #"ice_slide", "allow_prone", 0 );
            e_player val::set( #"ice_slide", "allow_jump", 0 );
            e_player val::set( #"ice_slide", "allow_stand", 0 );
            e_player clientfield::set_to_player( "ice_slide_postfx", 1 );
            e_player thread clientfield::set_to_player( "ice_slide_fov", 1 );
            assert( isdefined( self.str_location ), "<dev string:x38>" );
            
            switch ( self.str_location )
            {
                case #"mountain":
                    e_player clientfield::set_to_player( "ice_slide_looping_fx", 1 );
                    e_player thread clientfield::set_to_player( "ice_slide_dof", 1 );
                    break;
                case #"server_reveal":
                    e_player clientfield::set_to_player( "ice_slide_looping_fx", 1 );
                    e_player thread clientfield::set_to_player( "ice_slide_dof", 1 );
                    break;
                case #"server_descent":
                    e_player clientfield::set_to_player( "ice_slide_looping_fx", 1 );
                    e_player thread clientfield::set_to_player( "ice_slide_dof", 2 );
                    break;
                case #"amerika":
                    e_player clientfield::set_to_player( "ice_slide_looping_fx", 2 );
                    e_player thread clientfield::set_to_player( "ice_slide_dof", 2 );
                    break;
                default:
                    assert( 0, "<dev string:x6f>" );
                    break;
            }
        }
        
        while ( isalive( e_player ) && e_player istouching( self ) )
        {
            waitframe( 1 );
        }
        
        if ( isdefined( e_player ) )
        {
            e_player playrumbleonentity( "jump_rumble_end" );
            earthquake( 0.65, 1, e_player.origin, 100 );
            
            if ( !is_true( self.var_859762f6 ) )
            {
                e_player clientfield::set_to_player( "ice_slide_looping_fx", 0 );
                e_player clientfield::set_to_player( "ice_slide_postfx", 0 );
                e_player thread clientfield::set_to_player( "ice_slide_fov", 0 );
                
                switch ( self.str_location )
                {
                    case #"server_reveal":
                        e_player thread clientfield::set_to_player( "ice_slide_dof", 3 );
                        break;
                    case #"mountain":
                    case #"server_descent":
                    case #"amerika":
                        e_player thread clientfield::set_to_player( "ice_slide_dof", 4 );
                        break;
                    default:
                        assert( 0, "<dev string:x6f>" );
                        break;
                }
            }
            
            self.var_859762f6 = 1;
            
            if ( is_true( self.var_5739c21f ) && isdefined( self.var_51e34a4e ) )
            {
                switch ( self.var_51e34a4e )
                {
                    case #"ice":
                        e_player clientfield::set_to_player( "ice_slide_landing_fx", 1 );
                        break;
                    case #"dirt":
                        e_player clientfield::set_to_player( "ice_slide_landing_fx", 2 );
                        break;
                    default:
                        assert( 0, "<dev string:xce>" );
                        break;
                }
            }
            
            waitframe( 1 );
            e_player stoprumble( #"buzz_high" );
            e_player notify( #"hash_21e7754db7821ef8" );
            snd::play( "evt_slide_downhill_stop_lr", e_player );
            util::delay( 0.25, undefined, &snd::stop, var_24559b62 );
            var_24559b62 = undefined;
            e_player.var_6a81e560 = 0;
            e_player val::reset_all( #"ice_slide" );
            e_player setmovespeedscale( 1 );
            e_player playrumbleonentity( "jump_rumble_end" );
            
            if ( isalive( e_player ) )
            {
                e_player setstance( "stand" );
            }
        }
    }
}

// Namespace namespace_31aff1e6/namespace_31aff1e6
// Params 0
// Checksum 0xf71d859d, Offset: 0xbb8
// Size: 0xca
function function_803405ff()
{
    self endon( #"death", #"hash_21e7754db7821ef8" );
    str_stance = self getstance();
    
    switch ( str_stance )
    {
        case #"stand":
            self setstance( "crouch" );
            wait 0.2;
            break;
        case #"prone":
            self setstance( "crouch" );
            wait 1;
            break;
    }
}

// Namespace namespace_31aff1e6/namespace_31aff1e6
// Params 0
// Checksum 0x6a54440, Offset: 0xc90
// Size: 0x90
function function_2915e3aa()
{
    self endon( #"hash_21e7754db7821ef8", #"death" );
    
    while ( true )
    {
        n_magnitude = randomfloatrange( 0.15, 0.3 );
        earthquake( n_magnitude, 0.3, self.origin, 100 );
        wait 0.3;
    }
}

