#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2474a362752098d2;
#using script_2a5bf5b4a00cee0d;
#using script_40f967ad5d18ea74;
#using script_47851dbeea22fe66;
#using script_48e04a393ec6d855;
#using script_4d748e58ce25b60c;
#using script_50fca1a24ae351;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_74a56359b7d02ab6;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_f63bdb08;

// Namespace namespace_f63bdb08/namespace_f63bdb08
// Params 0
// Checksum 0x19951e0b, Offset: 0x1a8
// Size: 0x64
function init()
{
    clientfield::register( "scriptmover", "door_state", 1, 2, "int" );
    clientfield::register( "scriptmover", "door_type", 1, 2, "int" );
}

// Namespace namespace_f63bdb08/namespace_f63bdb08
// Params 7
// Checksum 0xb521c2a6, Offset: 0x218
// Size: 0x2d4
function function_2a1e5c1f( origin, angles, modelname, type = 1, var_5653e2ee = 2, context, var_fc5f2aa0 )
{
    door_model = namespace_ec06fe4a::spawnmodel( origin, modelname );
    
    if ( !isdefined( door_model ) )
    {
        return;
    }
    
    door_model.angles = angles;
    door_model solid();
    door_model clientfield::set( "door_type", type );
    door_model.targetname = namespace_ec06fe4a::function_3390402b();
    door_model.script_noteworthy = "dungeon_door";
    
    if ( context !== 2 )
    {
        door_model disconnectpaths();
    }
    
    door_model.type = type;
    door_model.trigger_offset = ( 0, 0, 0 );
    door_model.var_d6118311 = var_5653e2ee;
    door_model.context = context;
    
    if ( type === 4 )
    {
        door_model.trigger_offset = ( 0, 0, -64 );
    }
    
    if ( isdefined( var_fc5f2aa0 ) )
    {
        args = strtok( var_fc5f2aa0, ";" );
        
        if ( args.size > 1 )
        {
            door_model.var_fc5f2aa0 = { #type:args[ 1 ] };
            
            if ( args.size > 2 )
            {
                switch ( int( args[ 2 ] ) )
                {
                    case 1:
                        door_model.var_fc5f2aa0.hintstring = #"hash_4bd50984d9d381eb";
                        door_model.var_fc5f2aa0.var_e8dff5e5 = #"hash_4de7d058f1248fe8";
                        break;
                }
            }
            
            if ( args.size > 3 )
            {
                door_model.var_fc5f2aa0.var_115ea089 = args[ 3 ];
            }
        }
    }
    
    namespace_1e25ad94::debugmsg( "Creating Door (" + modelname + ") at " + origin );
    level.doa.var_b8ef1466[ level.doa.var_b8ef1466.size ] = door_model;
    return door_model;
}

// Namespace namespace_f63bdb08/namespace_f63bdb08
// Params 1
// Checksum 0x1e62e300, Offset: 0x4f8
// Size: 0x1bc
function function_49957ef3( door )
{
    if ( door.type == 4 )
    {
        door namespace_83eb6304::function_3ecfde67( "magic_door_open" );
        door notsolid();
        door scene::play( #"hash_30c46dd666dd7707", door );
        door waittill( #"scenes_done" );
        door namespace_83eb6304::function_3ecfde67( "magic_door_open" );
        door namespace_e32bb68::function_3a59ec34( "magic_door_open" );
        door namespace_ec06fe4a::function_8c808737();
        door connectpaths();
        wait 0.5;
        door delete();
        return;
    }
    
    namespace_1e25ad94::debugmsg( "Door Opened" );
    door namespace_e32bb68::function_3a59ec34( "fly_open_door" );
    door clientfield::set( "door_state", 1 );
    door.var_81b6ad63 = 1;
    wait 0.5;
    door notsolid();
    door connectpaths();
}

