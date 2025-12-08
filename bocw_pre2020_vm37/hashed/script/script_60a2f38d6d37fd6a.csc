#using script_18910f59cc847b42;
#using script_30c7fb449869910;
#using script_3314b730521b9666;
#using script_38635d174016f682;
#using script_42cbbdcd1e160063;
#using script_64e5d3ad71ce8140;
#using script_67049b48b589d81;
#using script_6b71c9befed901f2;
#using script_71603a58e2da0698;
#using script_75c3996cce8959f7;
#using script_76abb7986de59601;
#using script_77163d5a569e2071;
#using script_771f5bff431d8d57;
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

#namespace namespace_9fc66ac;

// Namespace namespace_9fc66ac/namespace_9fc66ac
// Params 0
// Checksum 0x1a4444fa, Offset: 0x1c0
// Size: 0x14
function init()
{
    function_32d5e898();
}

// Namespace namespace_9fc66ac/namespace_9fc66ac
// Params 1
// Checksum 0x4821e2bc, Offset: 0x1e0
// Size: 0x34
function function_32d5e898( *localclientnum )
{
    util::delay( 2, "game_over", &function_5beeba99 );
}

// Namespace namespace_9fc66ac/namespace_9fc66ac
// Params 2
// Checksum 0xb8c9c758, Offset: 0x220
// Size: 0x7c
function function_a77649db( onoff, str_name )
{
    if ( is_true( onoff ) )
    {
        level.var_1d1399b = level.var_5d4c7696;
        function_30f7911( 2, str_name );
        return;
    }
    
    function_f2198fe( level.var_1d1399b );
}

// Namespace namespace_9fc66ac/namespace_9fc66ac
// Params 0
// Checksum 0x51323bc2, Offset: 0x2a8
// Size: 0x5c
function function_5beeba99()
{
    name = level.doa.var_72b899ad.script_noteworthy;
    var_8576a4b1 = level.doa.roundnumber;
    function_30f7911( 0, name );
}

// Namespace namespace_9fc66ac/namespace_9fc66ac
// Params 0
// Checksum 0xc366a6f1, Offset: 0x310
// Size: 0x46
function function_2fc07d61()
{
    name = level.doa.var_72b899ad.script_noteworthy;
    var_8576a4b1 = level.doa.roundnumber;
}

// Namespace namespace_9fc66ac/namespace_9fc66ac
// Params 0
// Checksum 0x5f5a77bb, Offset: 0x360
// Size: 0xca
function function_65fcd877()
{
    switch ( level.doa.world_state )
    {
        case 0:
            peak = 1;
            break;
        case 4:
            function_30f7911( 4 );
            break;
        case 5:
            function_30f7911( 5 );
            break;
        case 1:
            function_30f7911( 1 );
            break;
    }
}

// Namespace namespace_9fc66ac/namespace_9fc66ac
// Params 2
// Checksum 0x150e3f94, Offset: 0x438
// Size: 0x16c
function function_30f7911( type, str_name = undefined )
{
    if ( !isdefined( level.var_5d4c7696 ) )
    {
        level.var_5d4c7696 = "";
    }
    
    if ( !isdefined( level.var_1d1399b ) )
    {
        level.var_1d1399b = "";
    }
    
    var_fc7248c7 = undefined;
    
    switch ( type )
    {
        case 0:
            if ( isdefined( str_name ) )
            {
                var_fc7248c7 = "zm_doa_arena_" + str_name;
            }
            else
            {
                var_fc7248c7 = "zm_doa_arena_default";
            }
            
            break;
        case 2:
            if ( isdefined( str_name ) )
            {
                var_fc7248c7 = "zm_doa_bonusroom_" + str_name;
            }
            else
            {
                var_fc7248c7 = "zm_doa_bonusroom_default";
            }
            
            break;
        case 4:
            var_fc7248c7 = "zm_doa_overworld";
            break;
        case 5:
            var_fc7248c7 = "zm_doa_dungeon";
            break;
        case 1:
            var_fc7248c7 = "zm_doa_gameover";
            break;
    }
    
    function_f2198fe( var_fc7248c7 );
}

// Namespace namespace_9fc66ac/namespace_9fc66ac
// Params 1
// Checksum 0x4276b77a, Offset: 0x5b0
// Size: 0x44
function function_f2198fe( var_fc7248c7 )
{
    if ( level.var_5d4c7696 !== var_fc7248c7 )
    {
        level.var_5d4c7696 = var_fc7248c7;
        forceambientroom( var_fc7248c7 );
    }
}

