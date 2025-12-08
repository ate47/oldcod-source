#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;

#namespace namespace_ecdab0f4;

// Namespace namespace_ecdab0f4/namespace_aa16cd50
// Params 0
// Checksum 0xa77d88a3, Offset: 0x138
// Size: 0xa4
function function_f84e1e7()
{
    var_dd67799c = getent( "heli", "targetname" );
    var_dd67799c.probe = getent( "probe_script_introHeli", "targetname" );
    
    if ( isdefined( var_dd67799c.probe ) )
    {
        var_dd67799c.probe linkto( var_dd67799c, "tag_origin_animate", ( 50, 0, -50 ), ( 0, 89.981, 2.4999 ) );
    }
}

