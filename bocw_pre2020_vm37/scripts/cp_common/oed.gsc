#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\cp_common\gametypes\save;

#namespace oed;

// Namespace oed/oed
// Params 0, eflags: 0x6
// Checksum 0x7e90622b, Offset: 0x178
// Size: 0x4c
function private autoexec __init__system__()
{
    system::register( #"oed", &preinit, &postinit, undefined, undefined );
}

// Namespace oed/oed
// Params 0, eflags: 0x4
// Checksum 0x1552d10, Offset: 0x1d0
// Size: 0x27c
function private preinit()
{
    clientfield::register( "toplayer", "sitrep_toggle", 1, 1, "int" );
    clientfield::register( "toplayer", "active_dni_fx", 1, 1, "counter" );
    clientfield::register( "toplayer", "hack_dni_fx", 1, 1, "counter" );
    clientfield::register( "actor", "sitrep_material", 1, 1, "int" );
    clientfield::register( "vehicle", "sitrep_material", 1, 1, "int" );
    clientfield::register( "scriptmover", "sitrep_material", 1, 1, "int" );
    clientfield::register( "item", "sitrep_material", 1, 1, "int" );
    clientfield::register( "vehicle", "turret_keyline_render", 1, 1, "int" );
    clientfield::register( "vehicle", "vehicle_keyline_toggle", 1, 1, "int" );
    callback::on_spawned( &on_player_spawned );
    spawner::add_global_spawn_function( #"axis", &function_9eccf6c1 );
    spawner::add_global_spawn_function( #"allies", &function_9eccf6c1 );
    level.var_3cebd57f = 1;
    level.var_7813404f = 0;
    level.enable_thermal = &enable_thermal;
    level.disable_thermal = &disable_thermal;
}

// Namespace oed/oed
// Params 0, eflags: 0x4
// Checksum 0x80f724d1, Offset: 0x458
// Size: 0x4
function private postinit()
{
    
}

// Namespace oed/oed
// Params 0
// Checksum 0xcac3027, Offset: 0x468
// Size: 0x6c
function on_player_spawned()
{
    self.var_3cebd57f = level.var_3cebd57f;
    self.var_a12ca713 = 0;
    self function_4b06932( self.var_a12ca713 );
    var_92ea5533 = 0;
    self clientfield::set_to_player( "sitrep_toggle", 1 );
}

// Namespace oed/button_bit_actionslot_1_pressed
// Params 0, eflags: 0x40
// Checksum 0x5719d3e, Offset: 0x4e0
// Size: 0x8c
function event_handler[button_bit_actionslot_1_pressed] function_84d84898()
{
    if ( is_true( level.var_3cebd57f ) && is_true( self.var_3cebd57f ) )
    {
        if ( !scene::is_igc_active() )
        {
            self.var_a12ca713 = !is_true( self.var_a12ca713 );
            self function_4b06932( self.var_a12ca713 );
        }
    }
}

// Namespace oed/oed
// Params 0
// Checksum 0x3c432374, Offset: 0x578
// Size: 0x64
function function_9eccf6c1()
{
    if ( self.team == #"axis" )
    {
        self enable_thermal();
        return;
    }
    
    if ( self.team == #"allies" )
    {
        self enable_thermal();
    }
}

// Namespace oed/oed
// Params 1
// Checksum 0xc6e851ca, Offset: 0x5e8
// Size: 0x5c
function enable_thermal( var_5bf5152f )
{
    self endon( #"death" );
    self thread function_5feac491();
    
    if ( isdefined( var_5bf5152f ) )
    {
        level waittill( var_5bf5152f );
        self disable_thermal();
    }
}

// Namespace oed/oed
// Params 0
// Checksum 0x61d544bf, Offset: 0x650
// Size: 0x44
function function_5feac491()
{
    self endon( #"disable_thermal" );
    self waittill( #"death" );
    
    if ( isdefined( self ) )
    {
        self disable_thermal();
    }
}

// Namespace oed/oed
// Params 0
// Checksum 0x671d65a8, Offset: 0x6a0
// Size: 0x16
function disable_thermal()
{
    self notify( #"disable_thermal" );
}

// Namespace oed/oed
// Params 1
// Checksum 0x46e09049, Offset: 0x6c0
// Size: 0xaa
function function_9ce86e2d( b_enabled = 1 )
{
    level.var_3cebd57f = b_enabled;
    
    foreach ( e_player in level.players )
    {
        e_player.var_3cebd57f = b_enabled;
    }
}

// Namespace oed/oed
// Params 1
// Checksum 0x9f703af2, Offset: 0x778
// Size: 0x4c
function enable_ev( b_enabled = 1 )
{
    self.var_3cebd57f = b_enabled;
    
    if ( !b_enabled )
    {
        self function_4b06932( b_enabled );
    }
}

// Namespace oed/oed
// Params 1
// Checksum 0x83c5e23d, Offset: 0x7d0
// Size: 0x5e
function function_4b06932( b_enabled = 1 )
{
    self.var_a12ca713 = b_enabled;
    
    if ( self.var_a12ca713 )
    {
        self notify( #"hash_4bf84da81ef07fa4" );
        return;
    }
    
    self notify( #"hash_2e8449934db3fd9d" );
}

// Namespace oed/oed
// Params 2
// Checksum 0x26fc000e, Offset: 0x838
// Size: 0x8c
function function_f2a6c166( *var_af4a3f3e, var_5bf5152f )
{
    self endon( #"death" );
    self clientfield::set( "sitrep_material", 1 );
    self thread function_99b61739();
    
    if ( isdefined( var_5bf5152f ) )
    {
        level waittill( var_5bf5152f );
        self function_b925bd3c();
    }
}

// Namespace oed/oed
// Params 0
// Checksum 0xb834ba5e, Offset: 0x8d0
// Size: 0x34
function function_99b61739()
{
    self waittill( #"death" );
    
    if ( isdefined( self ) )
    {
        self function_b925bd3c();
    }
}

// Namespace oed/oed
// Params 0
// Checksum 0xc40be7ed, Offset: 0x910
// Size: 0x24
function function_b925bd3c()
{
    self clientfield::set( "sitrep_material", 0 );
}

// Namespace oed/oed
// Params 1
// Checksum 0x59609703, Offset: 0x940
// Size: 0xc8
function function_19b0de13( *b_active )
{
    foreach ( player in level.players )
    {
        player.var_bef05351 = !is_true( player.var_bef05351 );
        player clientfield::set_to_player( "sitrep_toggle", player.var_bef05351 );
    }
}

// Namespace oed/oed
// Params 0
// Checksum 0x73c02237, Offset: 0xa10
// Size: 0xb2
function function_8c3be026()
{
    if ( !isdefined( self.angles ) )
    {
        self.angles = ( 0, 0, 0 );
    }
    
    var_57f4c959 = level.scriptbundles[ #"sitrep" ][ self.scriptbundlename ];
    var_7343683f = util::spawn_model( var_57f4c959.model, self.origin, self.angles );
    
    if ( isdefined( var_57f4c959.var_2e0f906a ) )
    {
        var_7343683f.var_280ea1f = var_57f4c959.var_2e0f906a;
    }
    else
    {
        var_7343683f.var_280ea1f = 0;
    }
    
    return var_7343683f;
}

