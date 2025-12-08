#using scripts\core_common\util_shared;

#namespace namespace_c9c45ed8;

// Namespace namespace_c9c45ed8/namespace_c9c45ed8
// Params 0
// Checksum 0xcdd6fcf5, Offset: 0xd8
// Size: 0x308
function init()
{
    level.doa.dungeons = array( { #name:"invalid", #var_dd490566:1 }, { #name:"jungle_1_dungeon1", #locstring:#"hash_3419b70eb1cb87d3", #policy:0 }, { #name:"jungle_1_dungeon2", #locstring:#"hash_3419b80eb1cb8986", #policy:0 }, { #name:"jungle_1_dungeon3", #locstring:#"hash_3419b90eb1cb8b39", #policy:0 }, { #name:"cellar", #locstring:undefined, #policy:0, #var_dd490566:1 }, { #name:"jungle_1_dungeon4", #locstring:#"hash_3419ba0eb1cb8cec", #policy:0 } );
    
    /#
        var_663588d = "<dev string:x38>";
        
        foreach ( dungeon in level.doa.dungeons )
        {
            if ( is_true( dungeon.var_dd490566 ) )
            {
                continue;
            }
            
            name = function_9e72a96( dungeon.name );
            locstr = function_9e72a96( dungeon.locstring );
            cmdline = "<dev string:x4f>" + name + "<dev string:x6a>";
            util::add_devgui( var_663588d + name, cmdline );
        }
    #/
}

