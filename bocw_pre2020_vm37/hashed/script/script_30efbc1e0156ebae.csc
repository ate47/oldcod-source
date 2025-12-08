#using script_18910f59cc847b42;
#using script_30c7fb449869910;
#using script_3314b730521b9666;
#using script_38635d174016f682;
#using script_42cbbdcd1e160063;
#using script_60a2f38d6d37fd6a;
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

#namespace namespace_5a917022;

// Namespace namespace_5a917022/namespace_5a917022
// Params 0
// Checksum 0x5c415ba4, Offset: 0x1c0
// Size: 0x5c
function init()
{
    clientfield::register( "world", "set_bonus_room", 1, 4, "int", &function_40356127, 0, 0 );
    function_32d5e898();
}

// Namespace namespace_5a917022/namespace_5a917022
// Params 1
// Checksum 0xd908c9e8, Offset: 0x228
// Size: 0x134
function function_32d5e898( *localclientnum )
{
    level.doa.var_8f6ccf63 = [];
    level.doa.var_6f3d327 = undefined;
    rooms = struct::get_array( "zombietron_bonus_room", "targetname" );
    
    foreach ( room in rooms )
    {
        if ( isdefined( room.script_parameters ) )
        {
            args = strtok( room.script_parameters, ";" );
            room.freecam = int( args[ 0 ] );
        }
        
        level.doa.var_8f6ccf63[ room.script_noteworthy ] = room;
    }
}

// Namespace namespace_5a917022/namespace_5a917022
// Params 7
// Checksum 0x784f02a8, Offset: 0x368
// Size: 0x1b2
function function_40356127( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    level.doa.var_938e4f08 = bwastimejump;
    
    switch ( bwastimejump )
    {
        case 0:
            function_a7ff1fc3( fieldname );
            break;
        case 1:
            function_d2e02ee( fieldname, "armory" );
            break;
        case 2:
            function_d2e02ee( fieldname, "coop" );
            break;
        case 3:
            function_d2e02ee( fieldname, "treasure" );
            break;
        case 4:
            function_d2e02ee( fieldname, "tradingpost" );
            break;
        case 5:
            function_d2e02ee( fieldname, "nukebunker" );
            break;
        case 6:
            function_d2e02ee( fieldname, "templeofdoom" );
            break;
    }
}

// Namespace namespace_5a917022/namespace_5a917022
// Params 1
// Checksum 0x6322ec92, Offset: 0x528
// Size: 0x94
function function_a7ff1fc3( *localclientnum )
{
    var_b2b025b1 = getlocalplayers()[ 0 ];
    
    if ( isdefined( var_b2b025b1.doa.var_903d75b1 ) )
    {
        var_b2b025b1.doa.cameramode = var_b2b025b1.doa.var_903d75b1;
    }
    else
    {
        var_b2b025b1.doa.cameramode = 1;
    }
    
    namespace_9fc66ac::function_a77649db( 0 );
}

// Namespace namespace_5a917022/namespace_5a917022
// Params 2
// Checksum 0x90d8aae6, Offset: 0x5c8
// Size: 0x114
function function_d2e02ee( *localclientnum, name )
{
    assert( isdefined( level.doa.var_8f6ccf63[ name ] ) );
    room = level.doa.var_8f6ccf63[ name ];
    var_b2b025b1 = getlocalplayers()[ 0 ];
    
    if ( !is_true( room.freecam ) )
    {
        var_b2b025b1.doa.cameramode = 5;
    }
    
    level.doa.var_b73cc08.origin = room.origin;
    level.doa.var_b73cc08.angles = room.angles;
    namespace_9fc66ac::function_a77649db( 1, name );
}

