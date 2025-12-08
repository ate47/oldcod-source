#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_350cffecd05ef6cf;
#using script_40f967ad5d18ea74;
#using script_47851dbeea22fe66;
#using script_48e04a393ec6d855;
#using script_4d748e58ce25b60c;
#using script_50fca1a24ae351;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_683a55734f15d50e;
#using script_746267f0669c40ae;
#using script_74a56359b7d02ab6;
#using script_dc59353021baee1;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_22574328;

// Namespace namespace_22574328/namespace_22574328
// Params 0
// Checksum 0x691a7a8b, Offset: 0x168
// Size: 0x16
function init()
{
    level.doa.var_51400a66 = [];
}

// Namespace namespace_22574328/namespace_22574328
// Params 0
// Checksum 0x646ba9e8, Offset: 0x188
// Size: 0x1c
function function_b9c8a739()
{
    level thread function_417fd9b();
}

// Namespace namespace_22574328/namespace_22574328
// Params 0
// Checksum 0x6dc4b6d0, Offset: 0x1b0
// Size: 0xf0
function function_da7439a2()
{
    level notify( #"hash_2303b11a0ac86ffe" );
    
    foreach ( loot in level.doa.var_51400a66 )
    {
        if ( isdefined( loot.item.var_c8386627 ) )
        {
            namespace_1c2a96f9::function_85da1646( loot.item.var_c8386627 );
        }
        
        if ( isdefined( loot.item ) )
        {
            loot.item delete();
        }
    }
}

// Namespace namespace_22574328/namespace_22574328
// Params 0
// Checksum 0x15022a3b, Offset: 0x2a8
// Size: 0x35c
function function_417fd9b()
{
    self notify( "6e9984cb89667089" );
    self endon( "6e9984cb89667089" );
    level endon( #"game_over", #"hash_2303b11a0ac86ffe" );
    
    while ( true )
    {
        wait 0.5;
        
        foreach ( loot in level.doa.var_51400a66 )
        {
            time = gettime();
            
            if ( isdefined( loot.var_eb9d64bb ) && time < loot.var_eb9d64bb )
            {
                continue;
            }
            
            if ( is_true( loot.activated ) || isdefined( loot.owner ) && is_true( loot.owner.activated ) )
            {
                continue;
            }
            
            loot.var_eb9d64bb = time + 1000 + randomint( 1600 );
            
            if ( !isdefined( loot.item ) )
            {
                activate = 0;
                loot.var_f8660931 = namespace_ec06fe4a::function_6eacecf5( loot.origin, 1600 );
                
                if ( isdefined( loot.var_f8660931 ) )
                {
                    activate = 1;
                }
                
                if ( activate )
                {
                    loot.item = namespace_41f5b853::spawnlootitem( loot.origin, loot.angles, loot.script_string, loot.radius, 2 );
                    
                    if ( isdefined( loot.item ) )
                    {
                        loot.item.owner = loot;
                        namespace_1e25ad94::debugmsg( "Paging IN loot at:" + loot.origin );
                    }
                    
                    loot.var_eb9d64bb += 5000;
                }
                
                continue;
            }
            
            loot.var_f8660931 = namespace_ec06fe4a::function_6eacecf5( loot.origin, 1800 );
            
            if ( !isdefined( loot.var_f8660931 ) )
            {
                if ( !isdefined( loot.script_string ) )
                {
                    loot.script_string = loot.item.defname;
                }
                
                if ( isdefined( loot.item.var_c8386627 ) )
                {
                    namespace_1c2a96f9::function_85da1646( loot.item.var_c8386627 );
                }
                
                loot.item delete();
                namespace_1e25ad94::debugmsg( "Paging OUT loot at:" + loot.origin );
            }
        }
    }
}

