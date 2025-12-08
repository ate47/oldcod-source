#using script_305169d9fdb05b9;
#using script_3d6cf0d984c55aac;
#using script_4d0e7ced9714e7d4;
#using script_5513c8efed5ff300;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp\cp_rus_duga_ambush;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;

#namespace cp_rus_duga;

// Namespace cp_rus_duga/level_init
// Params 1, eflags: 0x40
// Checksum 0xe059e160, Offset: 0x208
// Size: 0x8c
function event_handler[level_init] main( *eventstruct )
{
    init_callbacks();
    init_clientfields();
    function_37dfd679();
    load::main();
    level function_cf9b0986();
    setdvar( #"compassmaxrange", "2100" );
}

// Namespace cp_rus_duga/cp_rus_duga
// Params 0
// Checksum 0xe2e3ab39, Offset: 0x2a0
// Size: 0x13c
function function_37dfd679()
{
    skipto::function_eb91535d( "comprimised", &namespace_d6f0b09d::function_60a583d8, &namespace_d6f0b09d::function_ad4c4af2, "Intro", &namespace_d6f0b09d::function_be4e11a7 );
    skipto::function_eb91535d( "ambush", &duga_ambush::main, &duga_ambush::starting, "Ambush", &duga_ambush::cleanup );
    skipto::function_eb91535d( "loose_ends", &namespace_3562695::main, &namespace_3562695::starting, "Loose Ends", &namespace_3562695::cleanup );
    
    /#
        skipto::add_dev( "<dev string:x38>", &namespace_3562695::function_dbe8c8f4, &namespace_3562695::function_f5d9adcd, "<dev string:x4e>" );
    #/
}

// Namespace cp_rus_duga/cp_rus_duga
// Params 0
// Checksum 0x9b5a5f77, Offset: 0x3e8
// Size: 0xc4
function init_clientfields()
{
    clientfield::register( "toplayer", "tappy_input_player", 1, 1, "int" );
    clientfield::register( "toplayer", "pstfx_slow_motion", 1, 1, "int" );
    clientfield::register( "toplayer", "pstfx_player_stabbed", 1, 1, "int" );
    clientfield::register( "toplayer", "pstfx_chromatic_aberration", 1, 1, "int" );
}

// Namespace cp_rus_duga/cp_rus_duga
// Params 0
// Checksum 0x5d2cf6fe, Offset: 0x4b8
// Size: 0x44
function init_callbacks()
{
    callback::on_spawned( &on_spawned );
    callback::on_connect( &on_connect );
}

// Namespace cp_rus_duga/cp_rus_duga
// Params 0
// Checksum 0x9580bd52, Offset: 0x508
// Size: 0x17a
function function_48737ebb()
{
    var_1584d516 = self namespace_70eba6e6::function_1c4fb6d4();
    level.var_96d76ea = self namespace_70eba6e6::function_d9f060cc();
    level.var_de6ca1e4 = self namespace_70eba6e6::function_33bf99f8( 1 );
    
    /#
        var_99b11734 = getdvarint( #"hash_242537bc5f13e42f", -1 );
        var_9a7b5d79 = getdvarint( #"hash_4dd19684bf68597b", -1 );
        
        if ( var_99b11734 != -1 )
        {
            level.var_96d76ea = var_99b11734;
        }
        
        if ( var_9a7b5d79 != -1 )
        {
            var_1584d516 = var_9a7b5d79;
        }
    #/
    
    switch ( var_1584d516 )
    {
        case 0:
            level.var_deda09e = "park";
            break;
        case 1:
            level.var_deda09e = "lazar";
            break;
        case 2:
            level.var_deda09e = undefined;
            break;
    }
}

// Namespace cp_rus_duga/cp_rus_duga
// Params 0
// Checksum 0x12784c2c, Offset: 0x690
// Size: 0x8c
function function_cf9b0986()
{
    sp = getent( "lazar", "targetname" );
    sp spawner::add_spawn_function( &function_9995e4d5 );
    sp = getent( "park", "targetname" );
    sp spawner::add_spawn_function( &function_9995e4d5 );
}

// Namespace cp_rus_duga/cp_rus_duga
// Params 0
// Checksum 0x7bdf8dce, Offset: 0x728
// Size: 0x1e
function function_9995e4d5()
{
    level.var_c1881cdd = self;
    self.animname = "park_or_lazar";
}

// Namespace cp_rus_duga/cp_rus_duga
// Params 0
// Checksum 0xb3bc4973, Offset: 0x750
// Size: 0xd4
function on_connect()
{
    self function_48737ebb();
    
    if ( isdefined( level.var_28c22d88 ) && array::contains( level.var_28c22d88, "comprimised" ) || level.var_28c22d88.size == 0 )
    {
        util::function_f3cadc9a( "cp_duga_player_ready" );
        
        if ( isdefined( level.var_d7d201ba ) && !self flag::exists( level.var_d7d201ba ) )
        {
            self flag::init( level.var_d7d201ba );
        }
    }
}

// Namespace cp_rus_duga/cp_rus_duga
// Params 0
// Checksum 0xabf05256, Offset: 0x830
// Size: 0x102
function on_spawned()
{
    self setcharacterbodytype( 0 );
    self setcharacteroutfit( 0 );
    self util::function_a5318821();
    
    switch ( level.var_28c22d88[ 0 ] )
    {
        case #"ambush":
        case #"comprimised":
        case #"intro":
            self thread namespace_ac5221d7::function_292592aa();
            break;
        case #"loose_ends":
            self thread namespace_ac5221d7::function_a22db743();
            break;
        default:
            self thread namespace_ac5221d7::function_a22db743();
            break;
    }
}

