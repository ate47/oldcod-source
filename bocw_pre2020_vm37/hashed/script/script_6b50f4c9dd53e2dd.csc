#using script_13da4e6b98ca81a1;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;

#namespace namespace_d03f485e;

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 1
// Checksum 0xe675cef2, Offset: 0xe0
// Size: 0x14c
function init_shared( *eventstruct )
{
    level.var_117b4a3a = [];
    level.var_117b4a3a[ 0 ] = #"hash_280d5153e1276d";
    level.var_117b4a3a[ 1 ] = #"hash_4b1a3a0285bea14d";
    level.var_117b4a3a[ 2 ] = #"hash_36a94457406aea0e";
    level.var_117b4a3a[ 3 ] = #"hash_5a60154937b01557";
    level.zones = [];
    level.var_5070c5fa = [];
    level.current_zone = [];
    clientfield::register( "world", "war_zone", 1, 5, "int", &function_a0c208cf, 0, 0 );
    clientfield::register( "scriptmover", "scriptid", 1, 5, "int", &function_e116df6c, 0, 0 );
    callback::on_localclient_connect( &on_localclient_connect );
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 1
// Checksum 0xfaf68637, Offset: 0x238
// Size: 0x138
function on_localclient_connect( local_client_num )
{
    while ( level.var_5070c5fa.size == 0 )
    {
        waitframe( 1 );
        
        for ( zi = 0; zi < 5 ; zi++ )
        {
            objid = serverobjective_getobjective( local_client_num, "war_" + zi );
            
            if ( !isdefined( objid ) )
            {
                continue;
            }
            
            level.var_5070c5fa[ objid ] = zi;
        }
    }
    
    objectives = getarraykeys( level.var_5070c5fa );
    
    foreach ( objective in objectives )
    {
        function_dd2493cc( local_client_num, objective );
    }
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 2
// Checksum 0xc3449637, Offset: 0x378
// Size: 0x3e8
function function_dd2493cc( local_client_num, objid )
{
    local_player = function_5c10bd79( local_client_num );
    iscodcaster = codcaster::function_b8fe9b52( local_client_num );
    
    if ( iscodcaster )
    {
        var_4bb78aa3 = function_8147db19( local_client_num, objid, #"allies" );
        var_c7fc4f01 = function_8147db19( local_client_num, objid, #"axis" );
    }
    else
    {
        team = serverobjective_getobjectiveteam( local_client_num, objid );
        var_4bb78aa3 = function_8147db19( local_client_num, objid, function_73f4b33( local_client_num ) );
        var_c7fc4f01 = function_e7508755( local_client_num, objid );
    }
    
    var_efa99888 = serverobjective_getobjectivegamemodeflags( local_client_num, objid );
    zone_index = level.var_5070c5fa[ objid ];
    
    if ( !isdefined( zone_index ) )
    {
        return;
    }
    
    suffix = iscodcaster ? "_codcaster" : "";
    state = 0;
    
    if ( var_efa99888 == 3 )
    {
        state = 0;
    }
    else if ( var_c7fc4f01 && var_4bb78aa3 )
    {
        state = 3;
    }
    else if ( var_efa99888 == 1 )
    {
        if ( function_9b3f0ed1( local_client_num ) == #"allies" )
        {
            state = 1;
        }
        else
        {
            state = 2;
        }
    }
    else if ( var_efa99888 == 2 )
    {
        if ( function_9b3f0ed1( local_client_num ) == #"axis" )
        {
            state = 1;
        }
        else
        {
            state = 2;
        }
    }
    
    if ( isdefined( level.othervisuals[ zone_index ] ) )
    {
        foreach ( entid in level.othervisuals[ zone_index ] )
        {
            entity = getentbynum( local_client_num, entid );
            
            for ( si = 0; si < 4 ; si++ )
            {
                rob = level.var_117b4a3a[ si ] + suffix;
                
                if ( entity function_d2503806( rob ) )
                {
                    if ( state != si )
                    {
                        entity stoprenderoverridebundle( rob );
                    }
                    
                    continue;
                }
                
                if ( state == si )
                {
                    entity playrenderoverridebundle( rob );
                    
                    if ( iscodcaster )
                    {
                        codcaster::function_773f6e31( local_client_num, entity, rob, state );
                    }
                }
            }
        }
    }
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 7
// Checksum 0xed880439, Offset: 0x768
// Size: 0x29c
function function_a0c208cf( local_client_num, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    currentzoneindex = level.current_zone[ fieldname ];
    
    if ( isdefined( currentzoneindex ) && isdefined( level.othervisuals[ currentzoneindex ] ) )
    {
        foreach ( entid in level.othervisuals[ currentzoneindex ] )
        {
            entity = getentbynum( fieldname, entid );
            
            for ( si = 0; si < 4 ; si++ )
            {
                if ( entity function_d2503806( level.var_117b4a3a[ si ] ) )
                {
                    entity stoprenderoverridebundle( level.var_117b4a3a[ si ] );
                }
            }
        }
    }
    
    level.current_zone[ fieldname ] = bwastimejump;
    
    if ( isdefined( level.zones[ bwastimejump ] ) )
    {
        foreach ( entid in level.othervisuals[ bwastimejump ] )
        {
            newzone = getentbynum( fieldname, entid );
            
            if ( !newzone function_d2503806( level.var_117b4a3a[ 0 ] ) )
            {
                newzone playrenderoverridebundle( level.var_117b4a3a[ 0 ] );
            }
        }
        
        return;
    }
    
    level.current_zone[ fieldname ] = undefined;
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 7
// Checksum 0x47a0ff18, Offset: 0xa10
// Size: 0x1b8
function function_e116df6c( *localclientnum, oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    fieldname -= 1;
    bwastimejump -= 1;
    
    if ( bwastimejump == fieldname && isdefined( self.script_index ) )
    {
        return;
    }
    
    script_index = bwastimejump;
    self.script_index = script_index;
    
    if ( !isdefined( level.othervisuals[ script_index ] ) )
    {
        level.othervisuals[ script_index ] = [];
    }
    
    if ( !isdefined( level.othervisuals[ script_index ] ) )
    {
        level.othervisuals[ script_index ] = [];
    }
    else if ( !isarray( level.othervisuals[ script_index ] ) )
    {
        level.othervisuals[ script_index ] = array( level.othervisuals[ script_index ] );
    }
    
    if ( !isinarray( level.othervisuals[ script_index ], self getentitynumber() ) )
    {
        level.othervisuals[ script_index ][ level.othervisuals[ script_index ].size ] = self getentitynumber();
    }
    
    level.zones[ bwastimejump ] = self getentitynumber();
}

// Namespace namespace_d03f485e/event_f4737734
// Params 1, eflags: 0x40
// Checksum 0xdce46d84, Offset: 0xbd0
// Size: 0x64
function event_handler[event_f4737734] objective_update( eventstruct )
{
    local_client_num = eventstruct.localclientnum;
    obj_id = eventstruct.id;
    ent = eventstruct.entity_num;
    function_dd2493cc( local_client_num, obj_id );
}

// Namespace namespace_d03f485e/namespace_d03f485e
// Params 7
// Checksum 0x41525f39, Offset: 0xc40
// Size: 0x60
function function_d4d9232e( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( bwastimejump != level.current_state[ fieldname ] )
    {
        level.current_state[ fieldname ] = bwastimejump;
    }
}

