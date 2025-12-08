#using script_3357acf79ce92f4b;
#using script_3411bb48d41bd3b;
#using script_34ab99a4ca1a43d;
#using scripts\core_common\array_shared;
#using scripts\core_common\content_manager;
#using scripts\core_common\math_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\zm_common\objective_manager;

#namespace namespace_54471cf3;

// Namespace namespace_54471cf3/level_init
// Params 1, eflags: 0x40
// Checksum 0xfd9f686b, Offset: 0xd8
// Size: 0x6c
function event_handler[level_init] main( *eventstruct )
{
    objective_manager::register_script( #"hash_5077900a6875c57", &init, &function_55df422c, #"hash_5077900a6875c57", #"hash_6ee7d9a72e055d23" );
}

// Namespace namespace_54471cf3/namespace_54471cf3
// Params 1
// Checksum 0x5fe2077e, Offset: 0x150
// Size: 0x2e2
function init( s_instance )
{
    s_instance.var_1a8e0327 = getweapon( "survival_ball_tag_device" );
    s_instance.var_339281cf = [];
    s_instance.var_7a3806fc = [];
    s_instance.var_d3606120 = 0;
    
    switch ( getplayers().size )
    {
        case 1:
            s_instance.var_4879985f = 1;
            break;
        case 2:
        case 3:
            s_instance.var_4879985f = 3;
            break;
        case 4:
        case 5:
            s_instance.var_4879985f = 5;
            break;
    }
    
    foreach ( s_ball in s_instance.contentgroups[ #"hash_31bc7b539d5e81b" ] )
    {
        s_instance.var_339281cf[ s_instance.var_339281cf.size ] = content_manager::spawn_script_model( s_ball, #"wpn_t8_basketball_world", 0 );
    }
    
    foreach ( var_5ca7f2a9 in s_instance.contentgroups[ #"hash_4033fccc7e75876f" ] )
    {
        s_instance.var_339281cf[ s_instance.var_339281cf.size ] = content_manager::spawn_script_model( var_5ca7f2a9, #"hash_26951ad9ebdb849c", 0 );
        s_instance.var_5062e391 = spawn( "trigger_radius", var_5ca7f2a9.origin, 0, 64, 64 );
    }
    
    if ( !isdefined( s_instance.aitype ) )
    {
        s_instance.aitype = #"hash_4f87aa2a203d37d0";
    }
    
    if ( math::cointoss() )
    {
        s_instance.aitype = #"spawner_bo5_avogadro_sr";
    }
}

// Namespace namespace_54471cf3/namespace_54471cf3
// Params 1
// Checksum 0x648cbe5b, Offset: 0x440
// Size: 0xe4
function function_55df422c( s_instance )
{
    foreach ( mdl_ball in s_instance.var_339281cf )
    {
        spawnweapon( getweapon( "survival_ball_tag_device" ), mdl_ball.origin, mdl_ball.angles );
        mdl_ball delete();
    }
    
    function_afa1c1d8( s_instance );
}

// Namespace namespace_54471cf3/namespace_54471cf3
// Params 1
// Checksum 0xbfaf7450, Offset: 0x530
// Size: 0xc
function function_6ea48cd3( *s_instance )
{
    
}

// Namespace namespace_54471cf3/namespace_54471cf3
// Params 1
// Checksum 0x5b6b6e4, Offset: 0x548
// Size: 0xb4
function function_afa1c1d8( s_instance )
{
    s_instance endon( #"objective_ended" );
    
    while ( s_instance.var_d3606120 < s_instance.var_4879985f )
    {
        var_c2db447d = array::random( s_instance.contentgroups[ #"hash_14f5e1832e4f8321" ] );
        ai = namespace_85745671::function_9d3ad056( s_instance.aitype );
        
        if ( isdefined( ai ) )
        {
            s_instance.var_d3606120++;
            wait 15;
        }
        
        wait 0.5;
    }
}

