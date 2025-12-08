#namespace oic;

// Namespace oic/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x148461f3, Offset: 0x68
// Size: 0x124
function event_handler[gametype_init] main( *eventstruct )
{
    level.var_8eef5741 = 1;
    var_1f99b9e8 = [];
    
    if ( !isdefined( var_1f99b9e8 ) )
    {
        var_1f99b9e8 = [];
    }
    else if ( !isarray( var_1f99b9e8 ) )
    {
        var_1f99b9e8 = array( var_1f99b9e8 );
    }
    
    var_1f99b9e8[ var_1f99b9e8.size ] = getweapon( #"pistol_semiauto_t9", "" );
    gunselection = getgametypesetting( #"gunselection" );
    level.var_bf82f6b0 = var_1f99b9e8[ gunselection ];
    
    if ( isdefined( level.var_bf82f6b0 ) && isdefined( level.var_bf82f6b0.worldmodel ) )
    {
        forcestreamxmodel( level.var_bf82f6b0.worldmodel );
    }
}

