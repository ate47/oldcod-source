#using script_16910aff9d97c520;
#using script_17662ff15f00e748;
#using script_17dcb1172e441bf6;
#using script_1ee011cd0961afd7;
#using script_2050c3ca1efa3116;
#using script_226eec8e867ca977;
#using script_2a5bf5b4a00cee0d;
#using script_47851dbeea22fe66;
#using script_49f7fe670ba9398e;
#using script_4a247ed69e84b56f;
#using script_60c9f7551ce6c823;
#using script_6ee927dd468f79b0;
#using script_774302f762d76254;
#using script_79315a6ccf4fce3d;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_268747c0;

// Namespace namespace_268747c0/namespace_268747c0
// Params 0
// Checksum 0x59d16d53, Offset: 0x228
// Size: 0x44c
function init()
{
    level.doa.var_90dc2431 = [];
    level.doa.var_90dc2431[ #"hash_1febea34ca0f1f7b" ] = [];
    level.doa.var_90dc2431[ #"pole_active" ] = [];
    level.doa.var_90dc2431[ #"hash_3219530007dfba14" ] = [];
    level.doa.var_90dc2431[ #"hash_521b73633b084f93" ] = [];
    level.doa.var_90dc2431[ #"hash_4b482415d7c17889" ] = [];
    level.doa.var_90dc2431[ #"hash_e5ec53ae5bb293c" ] = [];
    level.doa.var_90dc2431[ #"hash_6ce506892f031410" ] = [];
    level.doa.var_90dc2431[ #"hash_3392f8c24dcea4ef" ] = [];
    level.doa.var_90dc2431[ #"hash_1761c31f44e7b8d0" ] = [];
    level.doa.var_90dc2431[ #"hash_4f7fa3734b952caf" ] = [];
    level.doa.var_90dc2431[ #"hash_becfd114c1ec38e" ] = [];
    level.doa.var_90dc2431[ #"hash_2442260ffeb5bf65" ] = [];
    level.doa.var_90dc2431[ #"hash_72917f3d48e23fdb" ] = [];
    level.doa.var_90dc2431[ #"hash_57d182822c6b17c6" ] = [];
    
    for ( i = 0; i < 12 ; i++ )
    {
        function_3111b4b2( "pole", "trigger_radius", 40, 64 );
    }
    
    for ( i = 0; i < 12 ; i++ )
    {
        function_3111b4b2( "pungi", "trigger_box", 64, 64, 64 );
    }
    
    for ( i = 0; i < 4 ; i++ )
    {
        function_3111b4b2( "flogger", "trigger_box", 28, 28, 136 );
    }
    
    for ( i = 0; i < 2 ; i++ )
    {
        function_3111b4b2( "logdrop", "trigger_box", 140, 64, 64 );
    }
    
    for ( i = 0; i < 4 ; i++ )
    {
        function_3111b4b2( "dragonhead", "trigger_radius", 60, 72 );
    }
    
    for ( i = 0; i < 4 ; i++ )
    {
        function_3111b4b2( "killbox", "trigger_box", 128, 128, 128 );
    }
    
    for ( i = 0; i < 4 ; i++ )
    {
        function_3111b4b2( "killzone", "trigger_radius", 128, 128 );
    }
    
    namespace_fb2125f::init();
    namespace_6624770a::init();
    namespace_538252ab::init();
    namespace_53f73cda::init();
    namespace_d20e7d3b::init();
    namespace_85f9e33a::init();
    namespace_a7c12078::init();
    namespace_3c9cfcff::init();
    namespace_2a2a39d4::init();
}

// Namespace namespace_268747c0/namespace_268747c0
// Params 0
// Checksum 0x8a3422ef, Offset: 0x680
// Size: 0x3e4
function main()
{
    for ( i = 0; i < 12 ; i++ )
    {
        if ( isdefined( level.doa.var_90dc2431[ #"pole_active" ][ i ] ) )
        {
            level.doa.var_90dc2431[ #"pole_active" ][ i ] function_54f185a();
        }
    }
    
    for ( i = 0; i < 12 ; i++ )
    {
        if ( isdefined( level.doa.var_90dc2431[ #"hash_521b73633b084f93" ][ i ] ) )
        {
            level.doa.var_90dc2431[ #"hash_521b73633b084f93" ][ i ] function_54f185a();
        }
    }
    
    for ( i = 0; i < 4 ; i++ )
    {
        if ( isdefined( level.doa.var_90dc2431[ #"hash_e5ec53ae5bb293c" ][ i ] ) )
        {
            level.doa.var_90dc2431[ #"hash_e5ec53ae5bb293c" ][ i ] function_54f185a();
        }
    }
    
    for ( i = 0; i < 2 ; i++ )
    {
        if ( isdefined( level.doa.var_90dc2431[ #"hash_3392f8c24dcea4ef" ][ i ] ) )
        {
            level.doa.var_90dc2431[ #"hash_3392f8c24dcea4ef" ][ i ] function_54f185a();
        }
    }
    
    for ( i = 0; i < 4 ; i++ )
    {
        if ( isdefined( level.doa.var_90dc2431[ #"hash_4f7fa3734b952caf" ][ i ] ) )
        {
            level.doa.var_90dc2431[ #"hash_4f7fa3734b952caf" ][ i ] function_54f185a();
        }
    }
    
    for ( i = 0; i < 4 ; i++ )
    {
        if ( isdefined( level.doa.var_90dc2431[ #"hash_2442260ffeb5bf65" ][ i ] ) )
        {
            level.doa.var_90dc2431[ #"hash_2442260ffeb5bf65" ][ i ] function_54f185a();
        }
    }
    
    for ( i = 0; i < 4 ; i++ )
    {
        if ( isdefined( level.doa.var_90dc2431[ #"hash_57d182822c6b17c6" ][ i ] ) )
        {
            level.doa.var_90dc2431[ #"hash_57d182822c6b17c6" ][ i ] function_54f185a();
        }
    }
    
    namespace_fb2125f::main();
    namespace_6624770a::main();
    namespace_538252ab::main();
    namespace_53f73cda::main();
    namespace_d20e7d3b::main();
    namespace_85f9e33a::main();
    namespace_a7c12078::main();
    namespace_3c9cfcff::main();
    namespace_2a2a39d4::main();
}

// Namespace namespace_268747c0/namespace_268747c0
// Params 5
// Checksum 0x4711c4ad, Offset: 0xa70
// Size: 0x1d8
function function_3111b4b2( var_d748f8af, triggertype = "trigger_box", var_bacb72c4, height, width )
{
    trigger = namespace_ec06fe4a::spawntrigger( triggertype, ( 0, 0, 0 ), 1 | 2 | 4 | 4096 | 512, var_bacb72c4, height, width );
    
    if ( isdefined( trigger ) )
    {
        trigger enablelinkto();
        trigger.type = var_d748f8af;
        trigger.width = width;
        trigger.height = height;
        trigger.length = var_bacb72c4;
        trigger.radius = var_bacb72c4;
        var_8bc05e55 = var_d748f8af + "_avail";
        
        if ( !isdefined( level.doa.var_90dc2431[ var_8bc05e55 ] ) )
        {
            level.doa.var_90dc2431[ var_8bc05e55 ] = [];
        }
        else if ( !isarray( level.doa.var_90dc2431[ var_8bc05e55 ] ) )
        {
            level.doa.var_90dc2431[ var_8bc05e55 ] = array( level.doa.var_90dc2431[ var_8bc05e55 ] );
        }
        
        level.doa.var_90dc2431[ var_8bc05e55 ][ level.doa.var_90dc2431[ var_8bc05e55 ].size ] = trigger;
        return trigger;
    }
}

// Namespace namespace_268747c0/namespace_268747c0
// Params 1
// Checksum 0x876264f4, Offset: 0xc50
// Size: 0x9c
function function_e8bbd3ad( var_d748f8af )
{
    var_8bc05e55 = var_d748f8af + "_avail";
    var_e831ee92 = var_d748f8af + "_active";
    arrayremovevalue( level.doa.var_90dc2431[ var_8bc05e55 ], undefined );
    arrayremovevalue( level.doa.var_90dc2431[ var_e831ee92 ], undefined );
}

// Namespace namespace_268747c0/namespace_268747c0
// Params 5
// Checksum 0xf823100a, Offset: 0xcf8
// Size: 0x398
function function_5bfa98c9( type, myorigin, var_a3ea8b6f = 1024, flush = 0, var_6c21387b = 1024 )
{
    if ( !isdefined( namespace_ec06fe4a::function_f3eab80e( myorigin, var_a3ea8b6f ) ) )
    {
        return;
    }
    
    var_8bc05e55 = type + "_avail";
    var_e831ee92 = type + "_active";
    
    if ( level.doa.var_90dc2431[ var_8bc05e55 ].size == 0 )
    {
        if ( flush )
        {
            var_46e82fd9 = [];
            
            foreach ( trigger in level.doa.var_90dc2431[ var_e831ee92 ] )
            {
                if ( !isdefined( namespace_ec06fe4a::function_f3eab80e( trigger.origin, var_6c21387b ) ) )
                {
                    var_46e82fd9[ var_46e82fd9.size ] = trigger;
                }
            }
            
            time = gettime();
            
            foreach ( trigger in var_46e82fd9 )
            {
                if ( trigger.var_a09cdd4f + 3000 < time )
                {
                    trigger function_54f185a();
                }
            }
            
            if ( level.doa.var_90dc2431[ var_8bc05e55 ].size == 0 )
            {
                return;
            }
        }
        else
        {
            return;
        }
    }
    
    trigger = level.doa.var_90dc2431[ var_8bc05e55 ][ 0 ];
    arrayremoveindex( level.doa.var_90dc2431[ var_8bc05e55 ], 0 );
    
    if ( !isdefined( level.doa.var_90dc2431[ var_e831ee92 ] ) )
    {
        level.doa.var_90dc2431[ var_e831ee92 ] = [];
    }
    else if ( !isarray( level.doa.var_90dc2431[ var_e831ee92 ] ) )
    {
        level.doa.var_90dc2431[ var_e831ee92 ] = array( level.doa.var_90dc2431[ var_e831ee92 ] );
    }
    
    level.doa.var_90dc2431[ var_e831ee92 ][ level.doa.var_90dc2431[ var_e831ee92 ].size ] = trigger;
    trigger triggerenable( 1 );
    return trigger;
}

// Namespace namespace_268747c0/namespace_268747c0
// Params 0
// Checksum 0x19afe236, Offset: 0x1098
// Size: 0x196
function function_54f185a()
{
    self triggerenable( 0 );
    type = self.type;
    arrayremovevalue( level.doa.var_90dc2431[ type + "_active" ], self );
    
    if ( !isdefined( level.doa.var_90dc2431[ type + "_avail" ] ) )
    {
        level.doa.var_90dc2431[ type + "_avail" ] = [];
    }
    else if ( !isarray( level.doa.var_90dc2431[ type + "_avail" ] ) )
    {
        level.doa.var_90dc2431[ type + "_avail" ] = array( level.doa.var_90dc2431[ type + "_avail" ] );
    }
    
    level.doa.var_90dc2431[ type + "_avail" ][ level.doa.var_90dc2431[ type + "_avail" ].size ] = self;
    self notify( #"hash_5dc5b7f198cd1bec" );
}

// Namespace namespace_268747c0/namespace_268747c0
// Params 2
// Checksum 0xcfb4f186, Offset: 0x1238
// Size: 0x1ba
function function_3874b272( type, var_2c5f6748 )
{
    switch ( type )
    {
        case #"explo_barrel":
            self thread namespace_fb2125f::function_6e3c8a46();
            return;
        case #"killbox":
            self thread namespace_6624770a::function_813ad4cb();
            return;
        case #"killzone":
            self thread namespace_538252ab::function_90e65586();
            return;
        case #"elec_pole":
            self thread namespace_53f73cda::function_97d551b( var_2c5f6748 );
            return;
        case #"pungi":
            self thread namespace_d20e7d3b::function_433b5718();
            return;
        case #"flogger":
            self thread namespace_85f9e33a::function_a76494d5();
            return;
        case #"logdrop":
            self thread namespace_a7c12078::function_237de89e();
            return;
        case #"dragonhead":
            self thread namespace_3c9cfcff::function_19903280();
            return;
        case #"fireball":
            self thread namespace_2a2a39d4::function_3a25f62f();
            return;
        default:
            assert( 0, "<dev string:x38>" );
            break;
    }
}

// Namespace namespace_268747c0/namespace_268747c0
// Params 0
// Checksum 0xb4a71b76, Offset: 0x1400
// Size: 0x76
function function_978c05b5()
{
    self notify( "4677d872634b0752" );
    self endon( "4677d872634b0752" );
    self endon( #"death", #"destroy_hazard" );
    level waittill( #"game_reset", #"arena_deactivated" );
    self notify( #"destroy_hazard" );
}

// Namespace namespace_268747c0/namespace_268747c0
// Params 0
// Checksum 0x6584052a, Offset: 0x1480
// Size: 0x66
function function_5418a00f()
{
    self notify( "34239a57dcbb7e00" );
    self endon( "34239a57dcbb7e00" );
    self endon( #"death", #"destroy_hazard" );
    level waittill( #"doa_exit_taken" );
    self notify( #"destroy_hazard" );
}

// Namespace namespace_268747c0/namespace_268747c0
// Params 3
// Checksum 0xf5a04161, Offset: 0x14f0
// Size: 0xe4
function play_anim( animation, rate, mode )
{
    self endon( #"death" );
    self notify( #"stop_idle" );
    self stopanimscripted();
    
    if ( !isdefined( rate ) )
    {
        rate = 1;
    }
    
    if ( !isdefined( mode ) )
    {
        mode = "server script";
    }
    
    animorigin = self.origin;
    animangles = self.angles;
    self thread animation::play( animation, animorigin, animangles, rate, 0.2, 0.2, 0, 0, 0, 0, undefined, 0, mode );
}

// Namespace namespace_268747c0/namespace_268747c0
// Params 0
// Checksum 0x538924b4, Offset: 0x15e0
// Size: 0x144
function function_7f6a807c()
{
    self notify( "332250e9cff1eea6" );
    self endon( "332250e9cff1eea6" );
    self endon( #"death" );
    self waittill( #"hash_5dc5b7f198cd1bec" );
    
    if ( isdefined( self.owner ) && isdefined( self.owner.trigger ) )
    {
        if ( isarray( self.owner.trigger ) )
        {
            if ( isinarray( self.owner.trigger, self ) )
            {
                arrayremovevalue( self.owner.trigger, self );
            }
        }
        else if ( self.owner.trigger == self )
        {
            self.owner.trigger = undefined;
        }
        
        namespace_1e25ad94::debugmsg( "Trap (" + self getentitynumber() + ") at origin:" + self.origin + " lost its trigger" );
    }
}

// Namespace namespace_268747c0/namespace_268747c0
// Params 3
// Checksum 0xa569334b, Offset: 0x1730
// Size: 0x7c
function function_b3c196a( owner, origin, angles )
{
    self triggerenable( 0 );
    self.owner = owner;
    self.origin = origin;
    self.angles = angles;
    self.var_a09cdd4f = gettime();
    self thread function_7f6a807c();
}

// Namespace namespace_268747c0/namespace_268747c0
// Params 5
// Checksum 0x587caa36, Offset: 0x17b8
// Size: 0x110
function function_678eaf60( type, origin = self.origin, var_a3ea8b6f, flush = 0, var_6c21387b = 256 )
{
    if ( isdefined( self.trigger ) && !isarray( self.trigger ) )
    {
        return self.trigger;
    }
    
    trigger = undefined;
    
    while ( !isdefined( trigger ) )
    {
        trigger = function_5bfa98c9( type, origin, var_a3ea8b6f, flush, var_6c21387b );
        
        if ( isdefined( trigger ) )
        {
            break;
        }
        
        wait 0.25;
    }
    
    trigger function_b3c196a( self, self.origin, self.angles );
    return trigger;
}

// Namespace namespace_268747c0/namespace_268747c0
// Params 2
// Checksum 0x6f043422, Offset: 0x18d0
// Size: 0x2b8
function function_96e2f261( traps, page )
{
    foreach ( trap in traps )
    {
        if ( trap.script_noteworthy === #"pungi" )
        {
            namespace_d20e7d3b::function_f42615a9( trap, page );
            continue;
        }
        
        if ( trap.script_noteworthy === #"pole" )
        {
            namespace_53f73cda::function_28826539( trap, page );
            continue;
        }
        
        if ( trap.script_noteworthy === #"barrel" )
        {
            namespace_fb2125f::function_3dd2c543( trap, page );
            continue;
        }
        
        if ( trap.script_noteworthy === #"dragonhead" )
        {
            namespace_3c9cfcff::function_c808b1bb( trap, page );
            continue;
        }
        
        if ( trap.script_noteworthy === #"killbox" )
        {
            namespace_6624770a::function_bbdbcaa5( trap, page );
            continue;
        }
        
        if ( trap.script_noteworthy === #"killzone" )
        {
            namespace_538252ab::function_7ae8d74a( trap, page );
            continue;
        }
        
        if ( trap.script_noteworthy === #"flogger" )
        {
            namespace_85f9e33a::function_7fb58446( trap, page );
            continue;
        }
        
        if ( trap.script_noteworthy === #"logdrop" )
        {
            namespace_a7c12078::function_7f3d5e5d( trap, page );
            continue;
        }
        
        if ( trap.script_noteworthy === #"fireball" )
        {
            namespace_2a2a39d4::function_7a2f725d( trap, page );
        }
    }
}

