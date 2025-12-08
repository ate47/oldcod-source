#using script_7cc5fb39b97494c4;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\serverfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\bb;

#namespace lockpick;

// Namespace lockpick
// Method(s) 12 Total 47
class class_d28acd06 : class_9e71c1a2
{

    var m_s_bundle;
    var var_1c4a269e;
    var var_1d21e4f3;
    var var_63e8057;
    var var_6dfc35a;
    var var_7529951f;
    var var_9e3fdeff;
    var var_b4563cfa;
    var var_b5a03b21;

    // Namespace namespace_d28acd06/lockpick
    // Params 1
    // Checksum 0x5ea2709b, Offset: 0x708
    // Size: 0xcc
    function _reset( *str_team )
    {
        if ( isdefined( var_b5a03b21.last_player ) )
        {
            var_b5a03b21.last_player flag::clear( "lockpicking" );
            var_b5a03b21.last_player val::reset( #"lockpicking", "show_weapon_hud" );
            var_b5a03b21.last_player showcrosshair( 1 );
            var_b5a03b21.last_player notify( #"hash_226f6717c97d10d6" );
        }
    }

    // Namespace namespace_d28acd06/lockpick
    // Params 0
    // Checksum 0xd621642c, Offset: 0x408
    // Size: 0x2dc
    function _init()
    {
        var_1c4a269e = 1;
        var_7529951f = 1;
        var_b4563cfa = #"hash_74dc1865536890ee";
        
        if ( sessionmodeiscampaigngame() && isdefined( level.var_6a7fb742 ) )
        {
            foreach ( interact_location in var_63e8057 )
            {
                if ( isdefined( interact_location.c_door ) && isdefined( interact_location.c_door.m_e_door ) )
                {
                    bundle = getscriptbundle( m_s_bundle.gameobject );
                    prompt_text = bundle.str_hint;
                    var_80778410 = rotatepoint( var_b5a03b21.origin - interact_location.c_door.m_e_door.origin, ( 0, 0, 0 ) - interact_location.c_door.m_e_door.angles );
                    var_de6f0004 = isdefined( bundle.n_trigger_use_time ) ? bundle.n_trigger_use_time : 0;
                    interact_location.c_door.m_e_door.var_645eee83 = self;
                    interact_location.c_door.m_e_door.interact_location = interact_location;
                    interact_location.c_door.m_e_door thread [[ level.var_6a7fb742 ]]( #"use", { #prompt_text:prompt_text, #var_71b9f0c0:200, #offset:var_80778410, #var_754bedbb:0, #var_87c991f3:40, #var_de6f0004:var_de6f0004, #var_be77841a:0, #var_531201f1:&minigame::function_cc2939a2, #complete_callback:&minigame::function_76974d96 } );
                }
            }
        }
    }

    // Namespace namespace_d28acd06/lockpick
    // Params 2
    // Checksum 0x359a8801, Offset: 0xae0
    // Size: 0x38
    function function_309c16b5( e_player, n_new_val )
    {
        complete( e_player, n_new_val == 2, e_player.team );
    }

    // Namespace namespace_d28acd06/lockpick
    // Params 1
    // Checksum 0x635f7709, Offset: 0xa80
    // Size: 0x34
    function function_6084622f( e_player )
    {
        bb::function_cd497743( "lockpick_fail", e_player );
        _reset();
    }

    // Namespace namespace_d28acd06/lockpick
    // Params 1
    // Checksum 0x6b14a647, Offset: 0x910
    // Size: 0xc
    function function_613e65ee( *e_player )
    {
        
    }

    // Namespace namespace_d28acd06/lockpick
    // Params 1
    // Checksum 0x280db843, Offset: 0x6f0
    // Size: 0xc
    function _start( *e_player )
    {
        
    }

    // Namespace namespace_d28acd06/lockpick
    // Params 1
    // Checksum 0x18306b97, Offset: 0x928
    // Size: 0x34
    function _stop( e_player )
    {
        if ( isdefined( e_player ) )
        {
            e_player clientfield::set_to_player( "lockpick_state", 0 );
        }
    }

    // Namespace namespace_d28acd06/lockpick
    // Params 1
    // Checksum 0xd00ad9c3, Offset: 0xac0
    // Size: 0x18
    function function_91ef58fb( var_f8d01c02 )
    {
        return var_1d21e4f3[ var_f8d01c02 ];
    }

    // Namespace namespace_d28acd06/lockpick
    // Params 1
    // Checksum 0xdf78d98f, Offset: 0x7e0
    // Size: 0x124
    function function_a466ed26( e_player )
    {
        assert( var_9e3fdeff > 0 );
        assert( var_6dfc35a >= 0 );
        
        if ( isdefined( e_player ) )
        {
            e_player val::set( #"lockpicking", "show_weapon_hud", 0 );
            e_player flag::set( "lockpicking" );
            e_player showcrosshair( 0 );
            e_player clientfield::set_to_player( "lockpick_num_pins", var_9e3fdeff );
            e_player clientfield::set_to_player( "lockpick_lock_index", var_6dfc35a );
            e_player clientfield::set_to_player( "lockpick_state", 1 );
        }
    }

    // Namespace namespace_d28acd06/lockpick
    // Params 1
    // Checksum 0x44dd136c, Offset: 0x968
    // Size: 0x110
    function function_e28586b3( e_player )
    {
        if ( isdefined( var_b5a03b21.target ) )
        {
            if ( !isdefined( var_b5a03b21.script_lockpick_open ) )
            {
                var_b5a03b21.script_lockpick_open = 1;
            }
            
            if ( isdefined( var_b5a03b21.var_ac5b22fa ) )
            {
                var_b5a03b21.var_ac5b22fa doors::unlock( undefined, undefined, var_b5a03b21.script_lockpick_open, e_player );
            }
            else
            {
                doors::unlock( var_b5a03b21.target, "targetname", var_b5a03b21.script_lockpick_open, e_player );
            }
        }
        
        bb::function_cd497743( "lockpick_success", e_player );
        e_player notify( #"minigame_tutorial_complete" );
        _reset();
    }

}

// Namespace lockpick/lockpick
// Params 0, eflags: 0x6
// Checksum 0x9967a79b, Offset: 0x190
// Size: 0x5c
function private autoexec __init__system__()
{
    level.var_51e24470[ "minigame_" + "lockpick" ] = &function_8d584152;
    system::register( "lockpick", &preinit );
}

// Namespace lockpick/lockpick
// Params 0, eflags: 0x4
// Checksum 0x870f983a, Offset: 0x1f8
// Size: 0xcc
function private preinit()
{
    clientfield::register( "toplayer", "lockpick_state", 1, 1, "int" );
    clientfield::register( "toplayer", "lockpick_num_pins", 1, 3, "int" );
    clientfield::register( "toplayer", "lockpick_lock_index", 1, 1, "int" );
    serverfield::register( "lockpick_state", 1, 2, "int", &function_74ad25ad );
}

// Namespace lockpick/lockpick
// Params 0
// Checksum 0xfc8abf36, Offset: 0x2d0
// Size: 0x14
function function_8d584152()
{
    return new class_d28acd06();
}

// Namespace lockpick/lockpick
// Params 0
// Checksum 0xcf0ad959, Offset: 0x2f0
// Size: 0x6c
function cancel()
{
    assert( isplayer( self ), "<dev string:x38>" );
    
    if ( self.var_97c1c267.last_player === self )
    {
        self.var_97c1c267 minigame::function_c09ff52( undefined, undefined, self );
    }
}

// Namespace lockpick/lockpick
// Params 2, eflags: 0x4
// Checksum 0x13e867be, Offset: 0x368
// Size: 0x58
function private function_74ad25ad( *oldval, newval )
{
    if ( newval > 0 && self.var_97c1c267.last_player === self )
    {
        [[ self.var_97c1c267.var_ff3c99c5 ]]->function_309c16b5( self, newval );
    }
}

