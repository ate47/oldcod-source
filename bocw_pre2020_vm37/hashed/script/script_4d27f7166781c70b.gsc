#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\cp_common\gametypes\globallogic;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;

#namespace namespace_ef60e103;

// Namespace namespace_ef60e103/namespace_ef60e103
// Params 1
// Checksum 0x89e8b8d3, Offset: 0x148
// Size: 0x44
function function_7ab616c1( *str_objective )
{
    setlightingstate( 3 );
    level flag::set( "flg_loose_ends" );
}

// Namespace namespace_ef60e103/namespace_ef60e103
// Params 2
// Checksum 0xb539ef48, Offset: 0x198
// Size: 0x21c
function function_2435d3e( *str_objective, var_50cc0d4f )
{
    if ( !var_50cc0d4f )
    {
        level.player freezecontrols( 1 );
        iprintlnbold( "Start outro movie." );
        wait 1;
        setlightingstate( 3 );
        exploder::kill_exploder( "fxexp_nuke_loop_fx" );
        var_82af4def = struct::get( "loose_ends", "targetname" );
        level.player setorigin( var_82af4def.origin );
        level.player setplayerangles( var_82af4def.angles );
        wait 3;
        iprintlnbold( "Finish outro movie." );
        wait 3;
        iprintlnbold( "Start Loose Ends movie." );
        wait 3;
        iprintlnbold( "Finish Loose Ends movie." );
        wait 5;
        level.player freezecontrols( 0 );
    }
    
    s_end_level = struct::get( "s_end_level", "targetname" );
    s_end_level util::create_cursor_hint( undefined, undefined, #"hash_34dc03add0f7d8e0", 1000, undefined, undefined, undefined, 1000, 360 );
    s_end_level waittill( #"trigger" );
    skipto::function_f02f0c63();
    skipto::function_1c2dfc20();
}

// Namespace namespace_ef60e103/namespace_ef60e103
// Params 4
// Checksum 0x1f3d7513, Offset: 0x3c0
// Size: 0x24
function function_8f77588( *str_objective, *var_50cc0d4f, *var_aa1a6455, *player )
{
    
}

