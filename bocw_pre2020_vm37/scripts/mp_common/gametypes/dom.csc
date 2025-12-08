#using script_13da4e6b98ca81a1;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;

#namespace dom;

// Namespace dom/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x381bda5, Offset: 0x220
// Size: 0x45c
function event_handler[gametype_init] main( *eventstruct )
{
    callback::on_localclient_connect( &on_localclient_connect );
    
    if ( getgametypesetting( #"silentplant" ) != 0 )
    {
        setsoundcontext( "bomb_plant", "silent" );
    }
    
    clientfield::register( "scriptmover", "scriptid", 1, 5, "int", &function_e116df6c, 0, 0 );
    level._effect[ #"zoneedgemarker" ] = [];
    level._effect[ #"zoneedgemarker" ][ 0 ] = #"ui/fx8_infil_marker_neutral";
    level._effect[ #"zoneedgemarker" ][ 1 ] = #"hash_5c2ae9f4f331d4b9";
    level._effect[ #"zoneedgemarker" ][ 2 ] = #"hash_7d1b0f001ea88b82";
    level._effect[ #"zoneedgemarker" ][ 3 ] = #"hash_7981eb245ea536fc";
    level._effect[ #"zoneedgemarkerwndw" ] = [];
    level._effect[ #"zoneedgemarkerwndw" ][ 0 ] = #"ui/fx8_infil_marker_neutral_window";
    level._effect[ #"zoneedgemarkerwndw" ][ 1 ] = #"hash_5565c3fc2c7742fe";
    level._effect[ #"zoneedgemarkerwndw" ][ 2 ] = #"hash_3283b765fe480df7";
    level._effect[ #"zoneedgemarkerwndw" ][ 3 ] = #"hash_6a512c225256a2e9";
    level.zonemarkers = [];
    level.zonemarkers[ #"a" ] = struct::get_array( "doma", "targetname" );
    level.zonemarkers[ #"b" ] = struct::get_array( "domb", "targetname" );
    level.zonemarkers[ #"c" ] = struct::get_array( "domc", "targetname" );
    level.zonemarkers[ #"d" ] = struct::get_array( "domd", "targetname" );
    level.zonemarkers[ #"e" ] = struct::get_array( "dome", "targetname" );
    level.zonemarkers[ #"f" ] = struct::get_array( "domf", "targetname" );
    level.othervisuals = [];
    level.var_117b4a3a = [];
    level.var_117b4a3a[ 0 ] = #"hash_280d5153e1276d";
    level.var_117b4a3a[ 1 ] = #"hash_4b1a3a0285bea14d";
    level.var_117b4a3a[ 2 ] = #"hash_36a94457406aea0e";
    level.var_117b4a3a[ 3 ] = #"hash_5a60154937b01557";
    level.var_117b4a3a[ 4 ] = #"hash_c102abd4eb802c2";
    level.var_117b4a3a[ 5 ] = #"hash_1f6942044733abd";
    callback::on_spawned( &function_df78674f );
}

// Namespace dom/event_f4737734
// Params 1, eflags: 0x40
// Checksum 0x3685cfc8, Offset: 0x688
// Size: 0x4c
function event_handler[event_f4737734] objective_update( eventstruct )
{
    localclientnum = eventstruct.localclientnum;
    objid = eventstruct.id;
    function_dd2493cc( localclientnum, objid );
}

// Namespace dom/dom
// Params 1
// Checksum 0x8f4231af, Offset: 0x6e0
// Size: 0x200
function function_64ffa588( *local_client_num )
{
    effects = [];
    effects[ #"zoneedgemarker" ] = level._effect[ #"zoneedgemarker" ];
    effects[ #"zoneedgemarkerwndw" ] = level._effect[ #"zoneedgemarkerwndw" ];
    effects[ #"zoneedgemarker" ][ 1 ] = #"hash_682365220f952226";
    effects[ #"zoneedgemarker" ][ 2 ] = #"hash_5c0d472966d09d41";
    effects[ #"zoneedgemarker" ][ 3 ] = [];
    effects[ #"zoneedgemarker" ][ 3 ][ 1 ] = #"hash_3d943e08d321081c";
    effects[ #"zoneedgemarker" ][ 3 ][ 2 ] = #"hash_6328e922e5ef809f";
    effects[ #"zoneedgemarkerwndw" ][ 1 ] = #"hash_6bfa43a02f3672e3";
    effects[ #"zoneedgemarkerwndw" ][ 2 ] = #"hash_7e0524ef3f409d16";
    effects[ #"zoneedgemarkerwndw" ][ 3 ] = [];
    effects[ #"zoneedgemarkerwndw" ][ 3 ][ 1 ] = #"hash_252ee62d9ea8dcc9";
    effects[ #"zoneedgemarkerwndw" ][ 3 ][ 2 ] = #"hash_7495c7dec3ebf9dc";
    return effects;
}

// Namespace dom/dom
// Params 1
// Checksum 0xc51a6ddb, Offset: 0x8e8
// Size: 0x4c0
function on_localclient_connect( localclientnum )
{
    level.domflags = [];
    level.var_4c3d5929 = [];
    
    while ( !isdefined( level.domflags[ #"a" ] ) )
    {
        level.domflags[ #"a" ] = serverobjective_getobjective( localclientnum, "dom_a" );
        level.domflags[ #"b" ] = serverobjective_getobjective( localclientnum, "dom_b" );
        level.domflags[ #"c" ] = serverobjective_getobjective( localclientnum, "dom_c" );
        level.domflags[ #"d" ] = serverobjective_getobjective( localclientnum, "dom_d" );
        level.domflags[ #"e" ] = serverobjective_getobjective( localclientnum, "dom_e" );
        level.domflags[ #"f" ] = serverobjective_getobjective( localclientnum, "dom_f" );
        waitframe( 1 );
    }
    
    if ( isdefined( level.domflags[ #"a" ] ) )
    {
        level.var_882f7b6a[ level.domflags[ #"a" ] ] = 1;
    }
    
    if ( isdefined( level.domflags[ #"b" ] ) )
    {
        level.var_882f7b6a[ level.domflags[ #"b" ] ] = 2;
    }
    
    if ( isdefined( level.domflags[ #"c" ] ) )
    {
        level.var_882f7b6a[ level.domflags[ #"c" ] ] = 3;
    }
    
    if ( isdefined( level.domflags[ #"d" ] ) )
    {
        level.var_882f7b6a[ level.domflags[ #"d" ] ] = 4;
    }
    
    if ( isdefined( level.domflags[ #"e" ] ) )
    {
        level.var_882f7b6a[ level.domflags[ #"e" ] ] = 5;
    }
    
    if ( isdefined( level.domflags[ #"f" ] ) )
    {
        level.var_882f7b6a[ level.domflags[ #"f" ] ] = 6;
    }
    
    var_f06ec6c3 = getentarray( localclientnum, "flag_descriptor", "targetname" );
    
    foreach ( descriptor in var_f06ec6c3 )
    {
        assert( isdefined( descriptor.target ), "<dev string:x38>" + descriptor.origin + "<dev string:x53>" );
        function_ca036b2c( localclientnum, descriptor.target );
    }
    
    foreach ( key, flag_objective in level.domflags )
    {
        level thread monitor_flag_fx( localclientnum, flag_objective, key );
        level thread function_3ec0c10c( localclientnum, flag_objective, key );
    }
}

// Namespace dom/dom
// Params 2
// Checksum 0xad2cac7e, Offset: 0xdb0
// Size: 0x64
function function_ca036b2c( localclientnum, var_e0fe7fde )
{
    if ( is_false( getgametypesetting( #"hash_4091f2d0019b1f4a" ) ) )
    {
        return;
    }
    
    lui::function_ca036b2c( localclientnum, var_e0fe7fde );
}

// Namespace dom/dom
// Params 7
// Checksum 0xfcdca19a, Offset: 0xe20
// Size: 0x1c4
function function_e116df6c( *localclientnum, oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( bwastimejump != fieldname || !isdefined( self.script_index ) )
    {
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
        
        if ( !self function_d2503806( level.var_117b4a3a[ 0 ] ) )
        {
            self playrenderoverridebundle( level.var_117b4a3a[ 0 ] );
        }
    }
}

// Namespace dom/dom
// Params 3
// Checksum 0xaef5cbcb, Offset: 0xff0
// Size: 0x3c6
function monitor_flag_fx( localclientnum, flag_objective, flag_name )
{
    if ( !isdefined( flag_objective ) )
    {
        return;
    }
    
    flag = spawnstruct();
    flag.name = flag_name;
    flag.objectiveid = flag_objective;
    flag.origin = serverobjective_getobjectiveorigin( localclientnum, flag_objective );
    flag.angles = ( 0, 0, 0 );
    flag.var_28a64002 = struct::get_array( "dom" + flag_name, "targetname" );
    flag_entity = serverobjective_getobjectiveentity( localclientnum, flag_objective );
    foo = getentarray( localclientnum, "flag_primary", "targetname" );
    
    if ( isdefined( flag_entity ) )
    {
        flag.origin = flag_entity.origin;
        flag.angles = flag_entity.angles;
    }
    
    fx_name = get_base_fx( flag, #"neutral" );
    play_base_fx( localclientnum, flag, fx_name, #"neutral" );
    function_7f6bca11( localclientnum, flag_name, 0 );
    flag.last_progress = 0;
    
    while ( true )
    {
        team = serverobjective_getobjectiveteam( localclientnum, flag_objective );
        
        if ( team != flag.last_team )
        {
            flag update_base_fx( localclientnum, flag, team );
            state = 0;
            
            if ( team == #"allies" )
            {
                state = 1;
            }
            else if ( team == #"axis" )
            {
                state = 2;
            }
            
            function_7f6bca11( localclientnum, flag_name, state );
        }
        
        progress = serverobjective_getobjectiveprogress( localclientnum, flag_objective ) > 0;
        
        if ( progress != flag.last_progress )
        {
            var_76587cfe = team;
            
            if ( var_76587cfe == #"neutral" )
            {
                var_4e8c1813 = serverobjective_getobjectivegamemodeflags( localclientnum, flag_objective );
                
                if ( var_4e8c1813 == 2 )
                {
                    var_76587cfe = codcaster::function_b8fe9b52( localclientnum ) ? #"axis" : #"allies";
                }
                else if ( var_4e8c1813 == 1 )
                {
                    var_76587cfe = codcaster::function_b8fe9b52( localclientnum ) ? #"allies" : #"axis";
                }
            }
            else if ( codcaster::function_b8fe9b52( localclientnum ) )
            {
                var_76587cfe = util::get_other_team( var_76587cfe );
            }
            
            flag update_cap_fx( localclientnum, flag, var_76587cfe, progress );
        }
        
        waitframe( 1 );
    }
}

// Namespace dom/dom
// Params 4
// Checksum 0xae52b572, Offset: 0x13c0
// Size: 0xaa
function play_base_fx( localclientnum, flag, *fx_name, team )
{
    if ( isdefined( fx_name.base_fx ) )
    {
        stopfx( flag, fx_name.base_fx );
    }
    
    up = anglestoup( fx_name.angles );
    forward = anglestoforward( fx_name.angles );
    fx_name.last_team = team;
}

// Namespace dom/dom
// Params 3
// Checksum 0xcf8ba460, Offset: 0x1478
// Size: 0x172
function update_base_fx( localclientnum, flag, team )
{
    fx_name = get_base_fx( flag, team );
    
    if ( codcaster::function_b8fe9b52( localclientnum ) && team != #"neutral" )
    {
        fx_name += team == #"allies" ? "_codcaster_allies" : "_codcaster_axis";
    }
    
    if ( team == #"neutral" )
    {
        play_base_fx( localclientnum, flag, fx_name, team );
        return;
    }
    
    if ( flag.last_team == #"neutral" || codcaster::function_b8fe9b52( localclientnum ) )
    {
        play_base_fx( localclientnum, flag, fx_name, team );
        return;
    }
    
    if ( isdefined( flag.base_fx ) )
    {
        setfxteam( localclientnum, flag.base_fx, team );
    }
    
    flag.last_team = team;
}

// Namespace dom/dom
// Params 4
// Checksum 0x922d45c2, Offset: 0x15f8
// Size: 0x9e
function play_cap_fx( localclientnum, flag, *fx_name, *team )
{
    if ( isdefined( team.cap_fx ) )
    {
        killfx( fx_name, team.cap_fx );
    }
    
    up = anglestoup( team.angles );
    forward = anglestoforward( team.angles );
}

// Namespace dom/dom
// Params 4
// Checksum 0x710ae611, Offset: 0x16a0
// Size: 0x11a
function update_cap_fx( localclientnum, flag, team, progress )
{
    if ( progress == 0 )
    {
        if ( isdefined( flag.cap_fx ) )
        {
            killfx( localclientnum, flag.cap_fx );
        }
        
        flag.last_progress = progress;
        return;
    }
    
    fx_name = get_cap_fx( flag, team );
    
    if ( codcaster::function_b8fe9b52( localclientnum ) && team != #"neutral" )
    {
        fx_name += team == #"allies" ? "_codcaster_allies" : "_codcaster_axis";
    }
    
    play_cap_fx( localclientnum, flag, fx_name, team );
    flag.last_progress = progress;
}

// Namespace dom/dom
// Params 2
// Checksum 0x634c70a9, Offset: 0x17c8
// Size: 0x7c
function get_base_fx( flag, team )
{
    if ( isdefined( level.domflagbasefxoverride ) )
    {
        fx = [[ level.domflagbasefxoverride ]]( flag, team );
        
        if ( isdefined( fx ) )
        {
            return fx;
        }
    }
    
    if ( team == #"neutral" )
    {
        return "ui/fx_dom_marker_neutral";
    }
    
    return "ui/fx_dom_marker_team";
}

// Namespace dom/dom
// Params 2
// Checksum 0x48980270, Offset: 0x1850
// Size: 0x7c
function get_cap_fx( flag, team )
{
    if ( isdefined( level.domflagcapfxoverride ) )
    {
        fx = [[ level.domflagcapfxoverride ]]( flag, team );
        
        if ( isdefined( fx ) )
        {
            return fx;
        }
    }
    
    if ( team == #"neutral" )
    {
        return "ui/fx_dom_cap_indicator_neutral";
    }
    
    return "ui/fx_dom_cap_indicator_team";
}

// Namespace dom/dom
// Params 3
// Checksum 0xa4709635, Offset: 0x18d8
// Size: 0x318
function function_7f6bca11( local_client_num, zone, state )
{
    effects = [];
    
    if ( codcaster::function_39bce377( local_client_num ) )
    {
    }
    else
    {
        effects[ #"zoneedgemarker" ] = level._effect[ #"zoneedgemarker" ];
        effects[ #"zoneedgemarkerwndw" ] = level._effect[ #"zoneedgemarkerwndw" ];
    }
    
    if ( isdefined( level.var_4c3d5929[ local_client_num ] ) && isdefined( level.var_4c3d5929[ local_client_num ][ zone ] ) )
    {
        foreach ( fx in level.var_4c3d5929[ local_client_num ][ zone ] )
        {
            stopfx( local_client_num, fx );
        }
    }
    
    if ( !isdefined( level.var_4c3d5929[ local_client_num ] ) )
    {
        level.var_4c3d5929[ local_client_num ] = [];
    }
    
    level.var_4c3d5929[ local_client_num ][ zone ] = [];
    
    if ( isdefined( level.zonemarkers[ zone ] ) )
    {
        fx_state = get_fx_state( local_client_num, state, codcaster::function_b8fe9b52( local_client_num ) );
        
        foreach ( visual in level.zonemarkers[ zone ] )
        {
            if ( !isdefined( visual.script_fxid ) )
            {
                continue;
            }
            
            fxid = get_fx( visual.script_fxid, fx_state, effects );
            
            if ( isarray( fxid ) )
            {
                state = 1;
                function_ca8ebccf( local_client_num, zone, visual, fxid[ state ], state );
                state = 2;
                function_ca8ebccf( local_client_num, zone, visual, fxid[ state ], state );
                continue;
            }
            
            function_ca8ebccf( local_client_num, zone, visual, fxid, state );
        }
    }
}

// Namespace dom/dom
// Params 1
// Checksum 0xb8b9f7e3, Offset: 0x1bf8
// Size: 0x118
function function_df78674f( localclientnum )
{
    self endon( #"death", #"disconnect" );
    
    while ( !isdefined( level.domflags[ #"a" ] ) || !isdefined( level.var_882f7b6a[ level.domflags[ #"a" ] ] ) )
    {
        waitframe( 1 );
    }
    
    if ( isdefined( localclientnum ) )
    {
        foreach ( objid in level.domflags )
        {
            function_dd2493cc( localclientnum, objid );
        }
    }
}

// Namespace dom/dom
// Params 2
// Checksum 0x7d09f1dd, Offset: 0x1d18
// Size: 0x3d8
function function_dd2493cc( local_client_num, objid )
{
    local_player = function_5c10bd79( local_client_num );
    iscodcaster = codcaster::function_b8fe9b52( local_client_num );
    team = serverobjective_getobjectiveteam( local_client_num, objid );
    friendlyteam = function_9b3f0ed1( local_client_num );
    enemyteam = util::get_enemy_team( friendlyteam );
    
    if ( iscodcaster )
    {
        var_4bb78aa3 = function_8147db19( local_client_num, objid, #"allies" );
        var_c7fc4f01 = function_8147db19( local_client_num, objid, #"axis" );
    }
    else
    {
        var_4bb78aa3 = function_8147db19( local_client_num, objid, friendlyteam );
        var_c7fc4f01 = function_e7508755( local_client_num, objid );
    }
    
    zone_index = level.var_882f7b6a[ objid ];
    suffix = iscodcaster ? "_codcaster" : "";
    state = 0;
    
    if ( friendlyteam == team )
    {
        state = 1;
    }
    
    if ( enemyteam == team )
    {
        state = 2;
    }
    
    if ( var_4bb78aa3 && ( team == #"neutral" || team == #"none" ) )
    {
        state = 4;
    }
    
    if ( var_c7fc4f01 && ( team == #"neutral" || team == #"none" ) )
    {
        state = 5;
    }
    
    if ( var_4bb78aa3 && var_c7fc4f01 )
    {
        state = 3;
    }
    
    if ( isdefined( level.othervisuals[ zone_index ] ) )
    {
        foreach ( entid in level.othervisuals[ zone_index ] )
        {
            entity = getentbynum( local_client_num, entid );
            
            for ( si = 0; si < 6 ; si++ )
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

// Namespace dom/dom
// Params 5, eflags: 0x4
// Checksum 0x7798b7d7, Offset: 0x20f8
// Size: 0x14c
function private function_ca8ebccf( local_client_num, zone, visual, fxid, state )
{
    if ( isdefined( visual.angles ) )
    {
        forward = anglestoforward( visual.angles );
    }
    else
    {
        forward = ( 0, 0, 0 );
    }
    
    fxhandle = playfx( local_client_num, fxid, visual.origin, forward );
    level.var_4c3d5929[ local_client_num ][ zone ][ level.var_4c3d5929[ local_client_num ][ zone ].size ] = fxhandle;
    
    if ( isdefined( fxhandle ) )
    {
        if ( state == 1 )
        {
            setfxteam( local_client_num, fxhandle, #"allies" );
            return;
        }
        
        if ( state == 2 )
        {
            setfxteam( local_client_num, fxhandle, #"axis" );
            return;
        }
        
        setfxteam( local_client_num, fxhandle, #"none" );
    }
}

// Namespace dom/dom
// Params 3
// Checksum 0x9eef4bd, Offset: 0x2250
// Size: 0x26
function get_fx( fx_name, fx_state, effects )
{
    return effects[ fx_name ][ fx_state ];
}

// Namespace dom/dom
// Params 3
// Checksum 0x4d217b56, Offset: 0x2280
// Size: 0xbc
function get_fx_state( local_client_num, state, var_b8fe9b52 )
{
    if ( var_b8fe9b52 )
    {
        return state;
    }
    
    if ( state == 1 )
    {
        if ( function_9b3f0ed1( local_client_num ) == #"allies" )
        {
            return 1;
        }
        else
        {
            return 2;
        }
    }
    else if ( state == 2 )
    {
        if ( function_9b3f0ed1( local_client_num ) == #"axis" )
        {
            return 1;
        }
        else
        {
            return 2;
        }
    }
    
    return state;
}

// Namespace dom/dom
// Params 3
// Checksum 0x385a3f4, Offset: 0x2348
// Size: 0x598
function function_3ec0c10c( localclientnum, flag_objective, flag_name )
{
    level endon( #"game_ended" );
    level thread function_33c6e40f( localclientnum );
    minpitch = 0.7;
    maxpitch = 1;
    var_f802a6b1 = 255;
    var_465feb0a = spawnstruct();
    var_465feb0a.name = flag_name;
    var_465feb0a.objectiveid = flag_objective;
    var_465feb0a.origin = serverobjective_getobjectiveorigin( localclientnum, var_465feb0a.objectiveid );
    var_465feb0a.entity = serverobjective_getobjectiveentity( localclientnum, var_465feb0a.objectiveid );
    var_465feb0a.var_95d7f85e = 0;
    var_465feb0a.var_d11f7b3a = 0;
    
    while ( true )
    {
        local_player = function_5c10bd79( localclientnum );
        
        if ( !isdefined( local_player.var_a01d8a9b ) )
        {
            local_player.var_a01d8a9b = [];
        }
        
        if ( !isdefined( local_player.var_bf29fd10 ) )
        {
            local_player.var_bf29fd10 = [];
        }
        
        player_using = function_ebea14a0( localclientnum, var_465feb0a.objectiveid, local_player );
        
        if ( player_using )
        {
            progress = serverobjective_getobjectiveprogress( localclientnum, var_465feb0a.objectiveid );
            team = serverobjective_getobjectiveteam( localclientnum, var_465feb0a.objectiveid );
            var_4bb78aa3 = function_8147db19( localclientnum, var_465feb0a.objectiveid, function_73f4b33( localclientnum ) );
            var_c7fc4f01 = function_e7508755( localclientnum, var_465feb0a.objectiveid );
            
            if ( is_true( var_c7fc4f01 ) )
            {
                if ( is_true( var_465feb0a.var_95d7f85e ) )
                {
                    local_player stoploopsound( local_player.var_bf29fd10[ var_465feb0a.objectiveid ] );
                    var_465feb0a.var_95d7f85e = 0;
                }
                
                local_player.var_a01d8a9b[ var_465feb0a.objectiveid ] = local_player playloopsound( #"hash_44df4b7db8f17a52" );
                wait 0.25;
                continue;
            }
            
            if ( isdefined( local_player.var_a01d8a9b[ var_465feb0a.objectiveid ] ) )
            {
                local_player stoploopsound( local_player.var_a01d8a9b[ var_465feb0a.objectiveid ] );
            }
            
            change = progress - ( isdefined( var_465feb0a.var_d11f7b3a ) ? var_465feb0a.var_d11f7b3a : 0 );
            
            if ( change <= 0 || team === #"allies" )
            {
                if ( is_true( var_465feb0a.var_95d7f85e ) )
                {
                    local_player stoploopsound( local_player.var_bf29fd10[ var_465feb0a.objectiveid ] );
                    var_465feb0a.var_95d7f85e = 0;
                }
            }
            else
            {
                if ( !is_true( var_465feb0a.var_95d7f85e ) )
                {
                    local_player.var_bf29fd10[ var_465feb0a.objectiveid ] = local_player playloopsound( #"hash_26e97e936335e7c8" );
                    var_465feb0a.var_95d7f85e = 1;
                }
                
                newpitch = function_1c14bff6( minpitch, maxpitch, progress / var_f802a6b1 );
                setsoundpitchrate( local_player.var_bf29fd10[ var_465feb0a.objectiveid ], 1 );
                setsoundpitch( local_player.var_bf29fd10[ var_465feb0a.objectiveid ], newpitch );
            }
            
            var_465feb0a.var_d11f7b3a = progress;
        }
        else
        {
            if ( is_true( var_465feb0a.var_95d7f85e ) )
            {
                if ( isdefined( local_player.var_bf29fd10[ var_465feb0a.objectiveid ] ) )
                {
                    local_player stoploopsound( local_player.var_bf29fd10[ var_465feb0a.objectiveid ] );
                }
                
                var_465feb0a.var_95d7f85e = 0;
            }
            
            if ( isdefined( local_player.var_a01d8a9b[ var_465feb0a.objectiveid ] ) )
            {
                local_player stoploopsound( local_player.var_a01d8a9b[ var_465feb0a.objectiveid ] );
            }
        }
        
        wait 0.25;
    }
}

// Namespace dom/dom
// Params 3
// Checksum 0x8b3619f9, Offset: 0x28e8
// Size: 0x4a
function function_1c14bff6( var_62307863, var_efdd8c05, n_percentage )
{
    dy = var_efdd8c05 - var_62307863;
    w = n_percentage * dy + var_62307863;
    return w;
}

// Namespace dom/dom
// Params 1
// Checksum 0xb36c452d, Offset: 0x2940
// Size: 0x188
function function_33c6e40f( localclientnum )
{
    level waittill( #"post_game", #"game_ended" );
    local_player = function_5c10bd79( localclientnum );
    
    if ( !isdefined( local_player ) )
    {
        return;
    }
    
    if ( isdefined( local_player.var_bf29fd10 ) )
    {
        foreach ( sound_id in local_player.var_bf29fd10 )
        {
            local_player stoploopsound( sound_id );
        }
    }
    
    if ( isdefined( local_player.var_a01d8a9b ) )
    {
        foreach ( sound_id in local_player.var_a01d8a9b )
        {
            local_player stoploopsound( sound_id );
        }
    }
}

