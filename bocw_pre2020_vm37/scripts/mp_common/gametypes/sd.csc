#using script_13da4e6b98ca81a1;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;

#namespace sd;

// Namespace sd/gametype_init
// Params 1, eflags: 0x40
// Checksum 0xb6d47270, Offset: 0xe8
// Size: 0xfc
function event_handler[gametype_init] main( *eventstruct )
{
    if ( getgametypesetting( #"silentplant" ) != 0 )
    {
        setsoundcontext( "bomb_plant", "silent" );
    }
    
    level.var_e4935474 = [];
    clientfield::function_5b7d846d( "hudItems.war.attackingTeam", #"war_data", #"attackingteam", 1, 2, "int", undefined, 0, 1 );
    clientfield::register( "scriptmover", "entityModelsNum", 1, 10, "int", &function_e116df6c, 0, 0 );
}

// Namespace sd/sd
// Params 7
// Checksum 0xb7aaab2a, Offset: 0x1f0
// Size: 0x14c
function function_e116df6c( localclientnum, oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( !isdefined( level.var_e4935474 ) )
    {
        level.var_e4935474 = [];
    }
    
    if ( bwastimejump != fieldname )
    {
        entitynumber = self getentitynumber();
        
        if ( bwastimejump != -1 )
        {
            level.var_e4935474[ entitynumber ] = bwastimejump;
        }
        
        var_ad3145bb = level.var_e4935474[ entitynumber ];
        var_c6523334 = getentbynum( binitialsnap, var_ad3145bb );
        
        if ( isdefined( var_c6523334 ) )
        {
            if ( bwastimejump == -1 )
            {
                var_c6523334 codcaster::function_6d9b84d9( #"rob_codcaster_keyline" );
                return;
            }
            
            var_c6523334 codcaster::function_89106df8( binitialsnap, #"hash_597d12ed59905d57", #"rob_codcaster_keyline", self );
        }
    }
}

