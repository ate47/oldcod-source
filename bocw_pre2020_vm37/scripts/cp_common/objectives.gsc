#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\objectives_ui;

#namespace objectives;

// Namespace objectives/objectives
// Params 0, eflags: 0x6
// Checksum 0x5c7782d0, Offset: 0x100
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"objectives", &preinit, undefined, undefined, undefined );
}

// Namespace objectives/objectives
// Params 0, eflags: 0x4
// Checksum 0xfbc930e2, Offset: 0x148
// Size: 0x1c
function private preinit()
{
    mission.var_c68f10d0 = [];
    mission.var_ac8e2ff9 = [];
}

// Namespace objectives/objectives
// Params 8
// Checksum 0x70a89775, Offset: 0x170
// Size: 0x4b4
function set( str_objective, a_targets, var_8c7ec5ce, var_4cfa0710 = str_objective, menu_description, show_splash = 1, show_waypoint = 1, var_bfcac307 )
{
    level flag::wait_till( #"gameplay_started" );
    
    if ( isdefined( a_targets ) )
    {
        if ( !isdefined( a_targets ) )
        {
            a_targets = [];
        }
        else if ( !isarray( a_targets ) )
        {
            a_targets = array( a_targets );
        }
        
        if ( a_targets.size > 1 )
        {
            scripted( var_4cfa0710, undefined, menu_description, show_splash, var_bfcac307 );
            function_1de88d60( var_4cfa0710, undefined, 0, a_targets.size );
        }
        
        foreach ( target in a_targets )
        {
            n_obj_id = gameobjects::get_next_obj_id();
            var_ff48959 = target;
            
            if ( isvec( target ) )
            {
                mission.var_c68f10d0[ var_4cfa0710 ] = n_obj_id;
            }
            else
            {
                if ( !isdefined( target.a_n_objective_ids ) )
                {
                    target.a_n_objective_ids = [];
                }
                
                target.a_n_objective_ids[ var_4cfa0710 ] = n_obj_id;
                
                if ( !isentity( target ) && isdefined( target.origin ) )
                {
                    var_ff48959 = target.origin;
                }
                
                if ( is_true( var_8c7ec5ce ) && isentity( target ) )
                {
                    target thread function_aa8c2bb2( var_4cfa0710, a_targets );
                }
            }
            
            objective_add( n_obj_id, "active", var_ff48959, str_objective );
            function_6da98133( n_obj_id );
            
            if ( a_targets.size == 1 )
            {
                if ( isdefined( menu_description ) )
                {
                    objectives_ui::function_bfdab223( n_obj_id, menu_description );
                    objectives_ui::set_state( n_obj_id, 0 );
                }
                
                if ( isdefined( var_bfcac307 ) )
                {
                    objectives_ui::function_bacd9b1f( n_obj_id, var_bfcac307 );
                }
            }
            
            if ( show_waypoint )
            {
                thread objectives_ui::function_f3ac479c( n_obj_id );
            }
        }
    }
    else
    {
        n_obj_id = gameobjects::get_next_obj_id();
        mission.var_c68f10d0[ var_4cfa0710 ] = n_obj_id;
        objective_add( n_obj_id, "active", ( 0, 0, 0 ), str_objective );
        function_6da98133( n_obj_id );
        
        if ( isdefined( menu_description ) )
        {
            objectives_ui::function_bfdab223( n_obj_id, menu_description );
            objectives_ui::set_state( n_obj_id, 0 );
        }
        
        if ( isdefined( var_bfcac307 ) )
        {
            objectives_ui::function_bacd9b1f( n_obj_id, var_bfcac307 );
        }
        
        if ( show_waypoint )
        {
            thread objectives_ui::function_f3ac479c( n_obj_id );
        }
    }
    
    if ( show_splash && isdefined( menu_description ) )
    {
        thread objectives_ui::function_8d9f9a22( n_obj_id );
        thread objectives_ui::function_1c6b4aeb();
    }
    
    player = getplayers()[ 0 ];
    
    if ( isdefined( player ) && show_waypoint )
    {
        player thread objectives_ui::show_objectives( 0 );
    }
}

// Namespace objectives/objectives
// Params 6
// Checksum 0x2cb81404, Offset: 0x630
// Size: 0x74
function follow( var_4cfa0710, var_b3177bd9, menu_description, show_splash, show_waypoint, var_c3056ba3 = #"hash_f71affaf9c403ac" )
{
    set( var_c3056ba3, var_b3177bd9, 1, var_4cfa0710, menu_description, show_splash, show_waypoint );
}

// Namespace objectives/objectives
// Params 7
// Checksum 0x356ae543, Offset: 0x6b0
// Size: 0x7c
function kill( var_4cfa0710, var_3829dccf, menu_description, show_splash, show_waypoint, var_bfcac307, var_c3056ba3 = #"hash_5c90265e62b1f975" )
{
    set( var_c3056ba3, var_3829dccf, 1, var_4cfa0710, menu_description, show_splash, show_waypoint, var_bfcac307 );
}

// Namespace objectives/objectives
// Params 8
// Checksum 0x456c69fc, Offset: 0x738
// Size: 0xf4
function area( var_4cfa0710, var_8343acf6, radius, menu_description, show_splash, show_waypoint, var_bfcac307, var_c3056ba3 = #"hash_4a026a0a4473d478" )
{
    set( var_c3056ba3, undefined, 0, var_4cfa0710, menu_description, show_splash, show_waypoint, var_bfcac307 );
    
    if ( isentity( var_8343acf6 ) )
    {
        update_position( var_4cfa0710, var_8343acf6.origin );
    }
    else
    {
        update_position( var_4cfa0710, var_8343acf6 );
    }
    
    function_64eaa790( var_4cfa0710, var_8343acf6, radius );
}

// Namespace objectives/objectives
// Params 6
// Checksum 0x67d568b4, Offset: 0x838
// Size: 0xa4
function goto( var_4cfa0710, position, menu_description, show_splash, show_waypoint, var_c3056ba3 = #"hash_7057d3992f70bf08" )
{
    if ( isdefined( mission.var_c68f10d0[ var_4cfa0710 ] ) )
    {
        update_position( var_4cfa0710, position );
        return;
    }
    
    set( var_c3056ba3, position, 0, var_4cfa0710, menu_description, show_splash, show_waypoint );
}

// Namespace objectives/objectives
// Params 6
// Checksum 0xad68db4b, Offset: 0x8e8
// Size: 0x6c
function function_4eb5c04a( var_4cfa0710, position, menu_description, show_splash, show_waypoint, var_c3056ba3 = #"hash_6d05b1cec06f98c" )
{
    goto( var_4cfa0710, position, menu_description, show_splash, show_waypoint, var_c3056ba3 );
}

// Namespace objectives/objectives
// Params 5
// Checksum 0xac382dd, Offset: 0x960
// Size: 0x64
function scripted( var_4cfa0710, a_ents, menu_description, show_splash, var_bfcac307 )
{
    set( #"cp_scripted", a_ents, 1, var_4cfa0710, menu_description, show_splash, 0, var_bfcac307 );
}

// Namespace objectives/objectives
// Params 2
// Checksum 0xd3a59bc1, Offset: 0x9d0
// Size: 0x5c
function convert( var_4cfa0710, var_c3056ba3 )
{
    if ( isdefined( mission.var_c68f10d0[ var_4cfa0710 ] ) )
    {
        objective_add( mission.var_c68f10d0[ var_4cfa0710 ], "active", ( 0, 0, 0 ), var_c3056ba3 );
    }
}

// Namespace objectives/objectives
// Params 2
// Checksum 0x42955799, Offset: 0xa38
// Size: 0x1d4
function remove( str_objective, a_targets )
{
    if ( isdefined( a_targets ) )
    {
        if ( !isdefined( a_targets ) )
        {
            a_targets = [];
        }
        else if ( !isarray( a_targets ) )
        {
            a_targets = array( a_targets );
        }
        
        foreach ( target in a_targets )
        {
            if ( target function_31679256( str_objective ) )
            {
                n_obj_id = target.a_n_objective_ids[ str_objective ];
                target.a_n_objective_ids[ str_objective ] = undefined;
                objectives_ui::remove_objective( n_obj_id );
                objective_delete( n_obj_id );
                gameobjects::release_obj_id( n_obj_id );
            }
        }
        
        return;
    }
    
    if ( isdefined( mission.var_c68f10d0[ str_objective ] ) )
    {
        n_obj_id = mission.var_c68f10d0[ str_objective ];
        mission.var_c68f10d0[ str_objective ] = undefined;
        objectives_ui::remove_objective( n_obj_id );
        objective_delete( n_obj_id );
        gameobjects::release_obj_id( n_obj_id );
    }
}

// Namespace objectives/objectives
// Params 2
// Checksum 0xda5b6d96, Offset: 0xc18
// Size: 0x16c
function update_position( str_objective, position )
{
    if ( isdefined( mission.var_c68f10d0[ str_objective ] ) )
    {
        if ( isentity( position ) )
        {
            objective_onentity( mission.var_c68f10d0[ str_objective ], position );
        }
        else
        {
            objective_clearentity( mission.var_c68f10d0[ str_objective ] );
            objective_setposition( mission.var_c68f10d0[ str_objective ], position );
        }
        
        if ( objective_state( mission.var_c68f10d0[ str_objective ] ) == "done" )
        {
            objective_setstate( mission.var_c68f10d0[ str_objective ], "active" );
            objectives_ui::set_state( mission.var_c68f10d0[ str_objective ], 0 );
            thread objectives_ui::function_f4a32e0b( str_objective, undefined, 1 );
        }
        
        thread objectives_ui::function_6b177efc( str_objective );
    }
}

// Namespace objectives/objectives
// Params 3
// Checksum 0x2f9f0e19, Offset: 0xd90
// Size: 0xcc
function function_64eaa790( str_objective, var_8343acf6, radius )
{
    if ( isdefined( mission.var_c68f10d0[ str_objective ] ) )
    {
        if ( isentity( var_8343acf6 ) )
        {
            if ( !isdefined( radius ) )
            {
                thread function_b6b76073( str_objective, var_8343acf6 );
            }
            else
            {
                thread function_634c16ef( str_objective, var_8343acf6, radius );
            }
            
            return;
        }
        
        if ( isdefined( radius ) )
        {
            thread function_37cf9b17( str_objective, var_8343acf6, radius );
            return;
        }
        
        assertmsg( "<dev string:x38>" );
    }
}

// Namespace objectives/objectives
// Params 3
// Checksum 0xc6331e58, Offset: 0xe68
// Size: 0x2fc
function complete( str_objective, a_targets, var_834e72f6 = 0 )
{
    if ( isdefined( a_targets ) )
    {
        if ( !isdefined( a_targets ) )
        {
            a_targets = [];
        }
        else if ( !isarray( a_targets ) )
        {
            a_targets = array( a_targets );
        }
        
        foreach ( target in a_targets )
        {
            if ( target function_31679256( str_objective ) )
            {
                function_45951a55( str_objective );
                n_obj_id = target.a_n_objective_ids[ str_objective ];
                objective_setstate( n_obj_id, "done" );
                
                if ( objectives_ui::function_1fe5876a( n_obj_id ) )
                {
                    objectives_ui::set_state( n_obj_id, 1 );
                    
                    if ( var_834e72f6 )
                    {
                        objectives_ui::function_79ed6d2( 1 );
                    }
                }
                else
                {
                    gameobjects::release_obj_id( n_obj_id );
                    target.a_n_objective_ids[ str_objective ] = undefined;
                    
                    if ( var_834e72f6 && isdefined( mission.var_c68f10d0[ str_objective ] ) && objectives_ui::function_1fe5876a( mission.var_c68f10d0[ str_objective ] ) )
                    {
                        objectives_ui::function_79ed6d2( 1 );
                    }
                }
                
                target notify( "complete_objective_" + str_objective );
            }
        }
        
        return;
    }
    
    if ( isdefined( mission.var_c68f10d0[ str_objective ] ) )
    {
        n_obj_id = mission.var_c68f10d0[ str_objective ];
        objective_setstate( n_obj_id, "done" );
        
        if ( objectives_ui::function_1fe5876a( n_obj_id ) )
        {
            objectives_ui::set_state( n_obj_id, 1 );
            
            if ( var_834e72f6 )
            {
                objectives_ui::function_79ed6d2( var_834e72f6 );
            }
            
            return;
        }
        
        gameobjects::release_obj_id( n_obj_id );
        mission.var_c68f10d0[ str_objective ] = undefined;
    }
}

// Namespace objectives/objectives
// Params 2
// Checksum 0xcd83cb78, Offset: 0x1170
// Size: 0x6c
function function_aa8c2bb2( str_objective, *a_targets )
{
    self endon( #"deleted", "complete_objective_" + a_targets );
    self waittill( #"death", #"remove_objective" );
    thread complete( a_targets, self );
}

// Namespace objectives/objectives
// Params 3
// Checksum 0x2c40e3d, Offset: 0x11e8
// Size: 0xe0
function show( str_objective, a_targets, e_player )
{
    a_n_objective_ids = function_d849bbf2( str_objective, a_targets );
    
    foreach ( n_objective_id in a_n_objective_ids )
    {
        if ( isdefined( e_player ) )
        {
            objective_setvisibletoplayer( n_objective_id, e_player );
            continue;
        }
        
        objective_setvisibletoall( n_objective_id );
    }
}

// Namespace objectives/objectives
// Params 3
// Checksum 0xd177c4a5, Offset: 0x12d0
// Size: 0xe0
function hide( str_objective, a_targets, e_player )
{
    a_n_objective_ids = function_d849bbf2( str_objective, a_targets );
    
    foreach ( n_objective_id in a_n_objective_ids )
    {
        if ( isdefined( e_player ) )
        {
            objective_setinvisibletoplayer( n_objective_id, e_player );
            continue;
        }
        
        objective_setinvisibletoall( n_objective_id );
    }
}

// Namespace objectives/objectives
// Params 0
// Checksum 0x49a5c3c4, Offset: 0x13b8
// Size: 0x24
function function_9dfb43fc()
{
    globallogic_ui::function_9ed5232e( "hudItems.hideWaypoints", 1 );
}

// Namespace objectives/objectives
// Params 0
// Checksum 0x343d3ab0, Offset: 0x13e8
// Size: 0x1c
function function_4279fd02()
{
    globallogic_ui::function_9ed5232e( "hudItems.hideWaypoints", 0 );
}

// Namespace objectives/objectives
// Params 3
// Checksum 0x4edf5782, Offset: 0x1410
// Size: 0xd8
function set_progress( str_objective, a_targets, n_progress )
{
    a_n_objective_ids = function_d849bbf2( str_objective, a_targets );
    
    foreach ( n_objective_id in a_n_objective_ids )
    {
        objective_setprogress( n_objective_id, n_progress );
        objectives_ui::set_progress( n_objective_id, n_progress );
    }
}

// Namespace objectives/objectives
// Params 3
// Checksum 0x301836c5, Offset: 0x14f0
// Size: 0xc0
function function_630d2576( str_objective, a_targets, var_4f8b76db )
{
    a_n_objective_ids = function_d849bbf2( str_objective, a_targets );
    
    foreach ( n_objective_id in a_n_objective_ids )
    {
        objective_setgamemodeflags( n_objective_id, var_4f8b76db );
    }
}

// Namespace objectives/objectives
// Params 4
// Checksum 0xfcafc4fb, Offset: 0x15b8
// Size: 0x154
function function_1de88d60( str_objective, a_targets, var_177f646b, var_d126f60d )
{
    a_n_objective_ids = function_d849bbf2( str_objective, a_targets );
    
    foreach ( n_objective_id in a_n_objective_ids )
    {
        if ( isdefined( var_177f646b ) )
        {
            objective_setuimodelvalue( n_objective_id, "obj_x", var_177f646b );
            objectives_ui::function_97d05398( n_objective_id, var_177f646b );
        }
        
        if ( isdefined( var_d126f60d ) )
        {
            objective_setuimodelvalue( n_objective_id, "obj_y", var_d126f60d );
            objectives_ui::function_302128de( n_objective_id, var_d126f60d );
        }
    }
    
    if ( isdefined( mission.var_c68f10d0[ str_objective ] ) )
    {
        mission.var_ac8e2ff9[ str_objective ] = var_177f646b;
    }
}

// Namespace objectives/objectives
// Params 1
// Checksum 0x9b233319, Offset: 0x1718
// Size: 0xb4
function function_45951a55( str_objective )
{
    if ( isdefined( mission.var_c68f10d0[ str_objective ] ) && isdefined( mission.var_ac8e2ff9[ str_objective ] ) )
    {
        mission.var_ac8e2ff9[ str_objective ]++;
        objective_id = mission.var_c68f10d0[ str_objective ];
        objective_setuimodelvalue( objective_id, "obj_x", mission.var_ac8e2ff9[ str_objective ] );
        objectives_ui::function_97d05398( objective_id, mission.var_ac8e2ff9[ str_objective ] );
    }
}

// Namespace objectives/objectives
// Params 1
// Checksum 0xc68472b6, Offset: 0x17d8
// Size: 0xb4
function function_3595a59d( str_objective )
{
    if ( isdefined( mission.var_c68f10d0[ str_objective ] ) && isdefined( mission.var_ac8e2ff9[ str_objective ] ) )
    {
        mission.var_ac8e2ff9[ str_objective ]--;
        objective_id = mission.var_c68f10d0[ str_objective ];
        objective_setuimodelvalue( objective_id, "obj_x", mission.var_ac8e2ff9[ str_objective ] );
        objectives_ui::function_97d05398( objective_id, mission.var_ac8e2ff9[ str_objective ] );
    }
}

// Namespace objectives/objectives
// Params 4
// Checksum 0x5b795812, Offset: 0x1898
// Size: 0xe0
function set_value( str_objective, a_targets, var_9922f839, n_value )
{
    a_n_objective_ids = function_d849bbf2( str_objective, a_targets );
    
    foreach ( n_objective_id in a_n_objective_ids )
    {
        objective_setuimodelvalue( n_objective_id, var_9922f839, n_value );
        objectives_ui::function_302128de( n_objective_id, n_value );
    }
}

// Namespace objectives/objectives
// Params 1
// Checksum 0xa3960192, Offset: 0x1980
// Size: 0x4c
function function_572778b9( str_objective )
{
    obj_id = function_285e460( str_objective );
    
    if ( isdefined( obj_id ) )
    {
        objectives_ui::function_572778b9( obj_id );
    }
}

// Namespace objectives/objectives
// Params 5
// Checksum 0xfeb170ac, Offset: 0x19d8
// Size: 0x108
function function_6a5ca7ac( str_objective, a_target, var_f4089be9, var_52710aa4, var_834e72f6 = 1 )
{
    parent_id = function_285e460( var_f4089be9, var_52710aa4 );
    
    if ( isdefined( parent_id ) )
    {
        a_n_objective_ids = function_d849bbf2( str_objective, a_target );
        
        foreach ( n_objective_id in a_n_objective_ids )
        {
            objectives_ui::function_6a5ca7ac( n_objective_id, parent_id, var_834e72f6 );
        }
    }
}

// Namespace objectives/objectives
// Params 2
// Checksum 0x166f1424, Offset: 0x1ae8
// Size: 0xc0
function function_5d6a7294( str_objective, a_targets )
{
    a_n_objective_ids = function_d849bbf2( str_objective, a_targets );
    
    foreach ( n_objective_id in a_n_objective_ids )
    {
        objectives_ui::function_6a5ca7ac( n_objective_id, -1 );
    }
}

// Namespace objectives/objectives
// Params 3
// Checksum 0x8309fee2, Offset: 0x1bb0
// Size: 0xc0
function set_state( str_objective, a_targets, str_state )
{
    a_n_objective_ids = function_d849bbf2( str_objective, a_targets );
    
    foreach ( n_objective_id in a_n_objective_ids )
    {
        objective_setstate( n_objective_id, str_state );
    }
}

// Namespace objectives/objectives
// Params 3
// Checksum 0x8be2d7aa, Offset: 0x1c78
// Size: 0x104
function function_67f87f80( str_objective, a_targets, text )
{
    if ( isdefined( a_targets ) )
    {
        if ( !isdefined( a_targets ) )
        {
            a_targets = [];
        }
        else if ( !isarray( a_targets ) )
        {
            a_targets = array( a_targets );
        }
        
        foreach ( target in a_targets )
        {
            thread objectives_ui::function_49dec5b( str_objective, target, text );
        }
        
        return;
    }
    
    thread objectives_ui::function_49dec5b( str_objective, undefined, text );
}

// Namespace objectives/objectives
// Params 3
// Checksum 0x89225b65, Offset: 0x1d88
// Size: 0x104
function function_fb65245c( str_objective, a_targets, icon )
{
    if ( isdefined( a_targets ) )
    {
        if ( !isdefined( a_targets ) )
        {
            a_targets = [];
        }
        else if ( !isarray( a_targets ) )
        {
            a_targets = array( a_targets );
        }
        
        foreach ( target in a_targets )
        {
            thread objectives_ui::function_fdeb5e85( str_objective, target, icon );
        }
        
        return;
    }
    
    thread objectives_ui::function_fdeb5e85( str_objective, undefined, icon );
}

// Namespace objectives/objectives
// Params 4, eflags: 0x20 variadic
// Checksum 0xe10a384e, Offset: 0x1e98
// Size: 0x108
function function_509db762( str_objective, a_targets, var_bc9bff3f, ... )
{
    a_n_objective_ids = function_d849bbf2( str_objective, a_targets );
    
    foreach ( n_objective_id in a_n_objective_ids )
    {
        a_args = arraycombine( array( n_objective_id ), vararg, 1, 0 );
        util::single_func_argarray( undefined, var_bc9bff3f, a_args );
    }
}

// Namespace objectives/objectives
// Params 2
// Checksum 0x67e10594, Offset: 0x1fa8
// Size: 0x70
function function_285e460( str_objective, target )
{
    if ( isdefined( target ) )
    {
        if ( target function_31679256( str_objective ) )
        {
            return target.a_n_objective_ids[ str_objective ];
        }
    }
    else if ( isdefined( mission.var_c68f10d0[ str_objective ] ) )
    {
        return mission.var_c68f10d0[ str_objective ];
    }
    
    return undefined;
}

// Namespace objectives/objectives
// Params 2
// Checksum 0x9da6a36f, Offset: 0x2020
// Size: 0x1ec
function function_d849bbf2( str_objective, a_targets )
{
    a_n_objective_ids = [];
    
    if ( isdefined( a_targets ) )
    {
        if ( !isdefined( a_targets ) )
        {
            a_targets = [];
        }
        else if ( !isarray( a_targets ) )
        {
            a_targets = array( a_targets );
        }
        
        foreach ( target in a_targets )
        {
            if ( isdefined( target ) && !function_3132f113( target ) && target function_31679256( str_objective ) )
            {
                if ( !isdefined( a_n_objective_ids ) )
                {
                    a_n_objective_ids = [];
                }
                else if ( !isarray( a_n_objective_ids ) )
                {
                    a_n_objective_ids = array( a_n_objective_ids );
                }
                
                a_n_objective_ids[ a_n_objective_ids.size ] = target.a_n_objective_ids[ str_objective ];
            }
        }
    }
    else if ( isdefined( mission.var_c68f10d0[ str_objective ] ) )
    {
        if ( !isdefined( a_n_objective_ids ) )
        {
            a_n_objective_ids = [];
        }
        else if ( !isarray( a_n_objective_ids ) )
        {
            a_n_objective_ids = array( a_n_objective_ids );
        }
        
        a_n_objective_ids[ a_n_objective_ids.size ] = mission.var_c68f10d0[ str_objective ];
    }
    
    return a_n_objective_ids;
}

// Namespace objectives/objectives
// Params 1, eflags: 0x4
// Checksum 0x6e87801a, Offset: 0x2218
// Size: 0x28, Type: bool
function private function_31679256( str_objective )
{
    return isdefined( self.a_n_objective_ids ) && isdefined( self.a_n_objective_ids[ str_objective ] );
}

// Namespace objectives/objectives
// Params 2, eflags: 0x4
// Checksum 0xedc2be14, Offset: 0x2248
// Size: 0x9c
function private function_5f2c6084( var_75de6891, str_objective )
{
    objectives_ui::function_748ac1b7( var_75de6891 );
    
    if ( var_75de6891 )
    {
        hide( str_objective );
        objectives_ui::function_b6d41b41( #"hash_55ff57573b3951ef" );
        return;
    }
    
    if ( isdefined( str_objective ) )
    {
        show( str_objective );
    }
    
    objectives_ui::function_be5b472b();
}

// Namespace objectives/objectives
// Params 2, eflags: 0x4
// Checksum 0xe9ee243e, Offset: 0x22f0
// Size: 0x144
function private function_b6b76073( str_objective, ent )
{
    level notify( "objective_search_area_" + str_objective );
    level endoncallback( &function_d5874fcc, "objective_search_area_" + str_objective );
    player = level.players[ 0 ];
    in_area = 0;
    
    while ( isdefined( mission.var_c68f10d0[ str_objective ] ) && objective_state( mission.var_c68f10d0[ str_objective ] ) == "active" )
    {
        if ( !in_area && player istouching( ent ) || in_area && !player istouching( ent ) )
        {
            in_area = !in_area;
            function_5f2c6084( in_area, str_objective );
        }
        
        waitframe( 1 );
    }
    
    function_d5874fcc();
}

// Namespace objectives/objectives
// Params 3, eflags: 0x4
// Checksum 0x69a60b3f, Offset: 0x2440
// Size: 0x184
function private function_634c16ef( str_objective, ent, radius )
{
    level notify( "objective_search_area_" + str_objective );
    level endoncallback( &function_d5874fcc, "objective_search_area_" + str_objective );
    player = level.players[ 0 ];
    radius_squared = radius * radius;
    in_area = 0;
    
    while ( isdefined( mission.var_c68f10d0[ str_objective ] ) && objective_state( mission.var_c68f10d0[ str_objective ] ) == "active" )
    {
        if ( !in_area && distancesquared( player.origin, ent.origin ) <= radius_squared || in_area && distancesquared( player.origin, ent.origin ) > radius_squared )
        {
            in_area = !in_area;
            function_5f2c6084( in_area, str_objective );
        }
        
        waitframe( 1 );
    }
    
    function_d5874fcc();
}

// Namespace objectives/objectives
// Params 3, eflags: 0x4
// Checksum 0x54c30991, Offset: 0x25d0
// Size: 0x17c
function private function_37cf9b17( str_objective, pos, radius )
{
    level notify( "objective_search_area_" + str_objective );
    level endoncallback( &function_d5874fcc, "objective_search_area_" + str_objective );
    player = level.players[ 0 ];
    radius_squared = radius * radius;
    in_area = 0;
    
    while ( isdefined( mission.var_c68f10d0[ str_objective ] ) && objective_state( mission.var_c68f10d0[ str_objective ] ) == "active" )
    {
        if ( !in_area && distancesquared( player.origin, pos ) <= radius_squared || in_area && distancesquared( player.origin, pos ) > radius_squared )
        {
            in_area = !in_area;
            function_5f2c6084( in_area, str_objective );
        }
        
        waitframe( 1 );
    }
    
    function_d5874fcc();
}

// Namespace objectives/objectives
// Params 1, eflags: 0x4
// Checksum 0xd1a1cb6, Offset: 0x2758
// Size: 0x34
function private function_d5874fcc( *var_201c5b1f )
{
    objectives_ui::function_748ac1b7( 0 );
    objectives_ui::function_be5b472b();
}

