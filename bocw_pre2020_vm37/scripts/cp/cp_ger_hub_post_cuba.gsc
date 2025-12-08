#using script_19971192452f4209;
#using script_4052585f7ae90f3a;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\cp_common\hint_tutorial;
#using scripts\cp_common\load;
#using scripts\cp_common\skipto;

#namespace hub_post_cuba;

// Namespace hub_post_cuba/cp_ger_hub_post_cuba
// Params 1
// Checksum 0xd9bb52d0, Offset: 0x198
// Size: 0xc
function starting( *var_d3440450 )
{
    
}

// Namespace hub_post_cuba/cp_ger_hub_post_cuba
// Params 2
// Checksum 0x7bc288e1, Offset: 0x1b0
// Size: 0x134
function main( var_d3440450, *var_50cc0d4f )
{
    level namespace_31c67f6d::function_6194f34a( "post_cuba", 1 );
    level thread function_ff7cb1bd();
    level thread namespace_4ed3ce47::function_7edafa59( var_50cc0d4f + "_briefing" );
    setlightingstate( 3 );
    level thread namespace_31c67f6d::function_29279de1( "post_cuba" );
    level thread namespace_31c67f6d::function_b0558ba2( "7" );
    level thread scene::play( "fan_01" );
    level function_107195fb();
    
    if ( isdefined( var_50cc0d4f ) )
    {
        skipto::function_4e3ab877( var_50cc0d4f );
    }
    
    skipto::function_1c2dfc20( "cp_nam_prisoner" );
}

// Namespace hub_post_cuba/cp_ger_hub_post_cuba
// Params 0
// Checksum 0x39481f95, Offset: 0x2f0
// Size: 0x34
function function_26282537()
{
    level waittill( #"ambient_ext_override" );
    level thread namespace_4ed3ce47::ambient_ext_override();
}

// Namespace hub_post_cuba/cp_ger_hub_post_cuba
// Params 0
// Checksum 0x4bd3ddf0, Offset: 0x330
// Size: 0x34
function function_eeb6e2e1()
{
    level waittill( #"hash_6e37b7c047667b8e" );
    level thread namespace_4ed3ce47::ambient_int_override();
}

// Namespace hub_post_cuba/cp_ger_hub_post_cuba
// Params 0
// Checksum 0x7fcdce86, Offset: 0x370
// Size: 0x34
function function_d2e1f6b8()
{
    level waittill( #"ambient_override_return_to_normal" );
    level thread namespace_4ed3ce47::ambient_override_return_to_normal();
}

// Namespace hub_post_cuba/cp_ger_hub_post_cuba
// Params 0
// Checksum 0xa9b2cf0c, Offset: 0x3b0
// Size: 0xf2
function function_107195fb()
{
    var_ea95c1e7 = namespace_31c67f6d::function_c9dc0e79();
    thread function_26282537();
    thread function_eeb6e2e1();
    thread function_d2e1f6b8();
    
    switch ( var_ea95c1e7 )
    {
        case #"park":
            function_276264f4( "scene_hub_post_cuba_briefing_park_survived" );
            break;
        case #"lazar":
            function_276264f4( "scene_hub_post_cuba_briefing_lazar_survived" );
            break;
        case #"sims":
            function_276264f4( "scene_hub_post_cuba_briefing_no_survivor" );
            break;
    }
}

// Namespace hub_post_cuba/cp_ger_hub_post_cuba
// Params 1
// Checksum 0x3e54c827, Offset: 0x4b0
// Size: 0xd4
function function_276264f4( str_scene )
{
    level scene::init( str_scene );
    
    while ( !isdefined( level.player_connected ) && level.player_connected != 1 )
    {
        waitframe( 1 );
    }
    
    wait 3;
    
    if ( isdefined( level.var_d7d201ba ) && isdefined( level.var_28c22d88 ) )
    {
        level.player flag::set( level.var_d7d201ba );
    }
    
    level thread namespace_31c67f6d::function_82743d25( level.var_f5552371, 1 );
    level scene::play( str_scene );
}

// Namespace hub_post_cuba/cp_ger_hub_post_cuba
// Params 0
// Checksum 0x6f2f1f65, Offset: 0x590
// Size: 0x24
function function_f50bc4b9()
{
    level flag::init( "flag_post_cuba_complete" );
}

// Namespace hub_post_cuba/cp_ger_hub_post_cuba
// Params 0
// Checksum 0x16f0dea9, Offset: 0x5c0
// Size: 0x4c
function function_ff7cb1bd()
{
    level thread namespace_4ed3ce47::function_9ac95ec9();
    level thread namespace_4ed3ce47::function_d6c61f8();
    level thread namespace_4ed3ce47::function_b7c50de7();
}

