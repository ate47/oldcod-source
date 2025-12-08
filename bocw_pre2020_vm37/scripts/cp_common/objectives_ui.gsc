#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\hint_tutorial;
#using scripts\cp_common\objectives;

#namespace objectives_ui;

// Namespace objectives_ui/objectives_ui
// Params 0, eflags: 0x6
// Checksum 0x84bef794, Offset: 0x338
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"objectives_ui", &preinit, undefined, undefined, undefined );
}

// Namespace objectives_ui/objectives_ui
// Params 0, eflags: 0x4
// Checksum 0xe1513f46, Offset: 0x380
// Size: 0x7c
function private preinit()
{
    temp = #"hash_147e5fa1e7f7cd06";
    temp = #"hash_850d28553336ed0";
    temp = #"hash_3537e7d6b8dc612b";
    temp = #"hash_147fefcf7bb5023c";
    clientfield::register( "toplayer", "show_objectives", 1, 2, "int" );
}

// Namespace objectives_ui/objectives_ui
// Params 1
// Checksum 0xcdb39d9, Offset: 0x408
// Size: 0x9c
function show_objectives( var_e9791619 = 1 )
{
    self notify( "5651785c71962c50" );
    self endon( "5651785c71962c50" );
    
    if ( var_e9791619 )
    {
        clientfield::set_to_player( "show_objectives", 2 );
    }
    else
    {
        waittillframeend();
        clientfield::set_to_player( "show_objectives", 1 );
    }
    
    waitframe( 1 );
    clientfield::set_to_player( "show_objectives", 0 );
}

// Namespace objectives_ui/objectives_ui
// Params 0
// Checksum 0x2b7cd7d6, Offset: 0x4b0
// Size: 0x9c
function function_49ebaad2()
{
    player = getplayers()[ 0 ];
    
    if ( isdefined( player ) )
    {
        timeout = 5;
        notify_str = "show_objectives";
        player thread function_d18e2e61( timeout, notify_str );
        player thread hint_tutorial::function_4c2d4fc4( #"hash_30ae598288c72637", undefined, undefined, undefined, 2, timeout, notify_str );
    }
}

// Namespace objectives_ui/objectives_ui
// Params 2, eflags: 0x4
// Checksum 0x75c83f62, Offset: 0x558
// Size: 0x7c
function private function_d18e2e61( timeout, notify_str )
{
    self endon( #"death" );
    self notifyonplayercommand( notify_str, "+scores" );
    self waittilltimeout( timeout, notify_str );
    self notifyonplayercommandremove( notify_str, "+scores" );
}

// Namespace objectives_ui/objectives_ui
// Params 0
// Checksum 0xe7a8ee61, Offset: 0x5e0
// Size: 0x64
function function_1c6b4aeb()
{
    globallogic_ui::function_9ed5232e( "hudItems.cpObjectiveUiData.splash", 1, 1, 1, 0, 0, 1 );
    waitframe( 1 );
    globallogic_ui::function_9ed5232e( "hudItems.cpObjectiveUiData.splash", 0, 1, 1, 0, 0, 1 );
}

// Namespace objectives_ui/objectives_ui
// Params 1
// Checksum 0xbdcfb48, Offset: 0x650
// Size: 0x3c
function function_79ed6d2( var_8eaad3c1 )
{
    globallogic_ui::function_9ed5232e( "hudItems.cpObjectiveUiData.showHideHint", var_8eaad3c1, 1, 1, 0, 0, 1 );
}

// Namespace objectives_ui/objectives_ui
// Params 1
// Checksum 0x4b427827, Offset: 0x698
// Size: 0x2c
function function_b6d41b41( message )
{
    globallogic_ui::function_9ed5232e( "hudItems.cpObjectiveUiData.compassMessage", message, 1 );
}

// Namespace objectives_ui/objectives_ui
// Params 0
// Checksum 0x59c4008b, Offset: 0x6d0
// Size: 0x34
function function_be5b472b()
{
    globallogic_ui::function_9ed5232e( "hudItems.cpObjectiveUiData.compassMessage", #"", 1 );
}

// Namespace objectives_ui/objectives_ui
// Params 1
// Checksum 0x7ddd5651, Offset: 0x710
// Size: 0x2c
function function_748ac1b7( var_75de6891 )
{
    globallogic_ui::function_9ed5232e( "hudItems.cpObjectiveUiData.inObjectiveArea", var_75de6891, 1 );
}

// Namespace objectives_ui/objectives_ui
// Params 3
// Checksum 0x12bc0863, Offset: 0x748
// Size: 0xac
function function_49dec5b( str_objective, target, text )
{
    obj_id = objectives::function_285e460( str_objective, target );
    
    if ( isdefined( obj_id ) )
    {
        globallogic_ui::function_9ed5232e( "objectives_info." + obj_id + ".waypointText", text );
        globallogic_ui::function_9ed5232e( "objectives_info." + obj_id + ".forceUpdate", 1, 0, 1, 0, 0, 1 );
    }
}

// Namespace objectives_ui/objectives_ui
// Params 3
// Checksum 0x75d0d9dd, Offset: 0x800
// Size: 0xac
function function_fdeb5e85( str_objective, target, icon )
{
    obj_id = objectives::function_285e460( str_objective, target );
    
    if ( isdefined( obj_id ) )
    {
        globallogic_ui::function_9ed5232e( "objectives_info." + obj_id + ".waypointIcon", icon );
        globallogic_ui::function_9ed5232e( "objectives_info." + obj_id + ".forceUpdate", 1, 0, 1, 0, 0, 1 );
    }
}

// Namespace objectives_ui/objectives_ui
// Params 3
// Checksum 0x3a4f1c6c, Offset: 0x8b8
// Size: 0xb4
function function_f4a32e0b( str_objective, target, state )
{
    obj_id = objectives::function_285e460( str_objective, target );
    
    if ( isdefined( obj_id ) )
    {
        globallogic_ui::function_9ed5232e( "objectives_info." + obj_id + ".state", state );
        util::wait_network_frame( 1 );
        globallogic_ui::function_9ed5232e( "ForceObjectiveRefresh", 1, 0, 1, 0, 0, 1 );
    }
}

// Namespace objectives_ui/objectives_ui
// Params 3
// Checksum 0xd7ea8495, Offset: 0x978
// Size: 0x104
function function_6b177efc( str_objective, target, delay_network_frames = 2 )
{
    if ( isdefined( target ) )
    {
        target endon( #"death" );
    }
    
    level notify( "update_waypoint_" + str_objective );
    level endon( "update_waypoint_" + str_objective );
    
    if ( delay_network_frames > 0 )
    {
        util::wait_network_frame( delay_network_frames );
    }
    
    obj_id = objectives::function_285e460( str_objective, target );
    
    if ( isdefined( obj_id ) )
    {
        model_name = "objectives_info." + obj_id + ".waypointUpdate";
        globallogic_ui::function_9ed5232e( model_name, 1, 0, 1 );
    }
}

// Namespace objectives_ui/objectives_ui
// Params 2
// Checksum 0x8293545f, Offset: 0xa88
// Size: 0x3c
function function_bfdab223( obj_id, desc )
{
    globallogic_ui::function_8954fa13( "_DataSources.cp_objectives_list", obj_id, "description", desc );
}

// Namespace objectives_ui/objectives_ui
// Params 1
// Checksum 0x3518f1cf, Offset: 0xad0
// Size: 0x32
function get_state( obj_id )
{
    return globallogic_ui::function_596db691( "_DataSources.cp_objectives_list", obj_id, "state" );
}

// Namespace objectives_ui/objectives_ui
// Params 2
// Checksum 0x10f18b7b, Offset: 0xb10
// Size: 0x3c
function set_state( obj_id, state )
{
    globallogic_ui::function_8954fa13( "_DataSources.cp_objectives_list", obj_id, "state", state );
}

// Namespace objectives_ui/objectives_ui
// Params 3
// Checksum 0xa5cb723f, Offset: 0xb58
// Size: 0xb4
function function_6a5ca7ac( obj_id, parent_id, var_834e72f6 = 1 )
{
    if ( function_1fe5876a( obj_id ) && function_1fe5876a( parent_id ) )
    {
        globallogic_ui::function_8954fa13( "_DataSources.cp_objectives_list", obj_id, "parent", parent_id );
        
        if ( var_834e72f6 )
        {
            thread function_8d9f9a22( parent_id );
            thread function_1c6b4aeb();
        }
    }
}

// Namespace objectives_ui/objectives_ui
// Params 1
// Checksum 0xb4aee79e, Offset: 0xc18
// Size: 0x74
function function_572778b9( obj_id )
{
    if ( isdefined( obj_id ) )
    {
        globallogic_ui::function_8954fa13( "_DataSources.cp_objectives_list", obj_id, "isOptional", 1 );
        model_name = "objectives_info." + obj_id + ".isOptional";
        globallogic_ui::function_9ed5232e( model_name, 1 );
    }
}

// Namespace objectives_ui/objectives_ui
// Params 1
// Checksum 0x8f64c57a, Offset: 0xc98
// Size: 0xa4
function function_8d9f9a22( obj_id )
{
    notify_string = "objective_splash" + obj_id;
    level notify( notify_string );
    level endon( notify_string );
    globallogic_ui::function_8954fa13( "_DataSources.cp_objectives_list", obj_id, "newObjective", 1 );
    level waittill( #"objectives_shown" );
    globallogic_ui::function_8954fa13( "_DataSources.cp_objectives_list", obj_id, "newObjective", 0 );
}

// Namespace objectives_ui/objectives_ui
// Params 1
// Checksum 0xae812814, Offset: 0xd48
// Size: 0x8c
function function_f3ac479c( obj_id )
{
    model = "objectives_info." + obj_id + ".newObjective";
    level notify( model );
    level endon( model );
    globallogic_ui::function_9ed5232e( model, 1 );
    level waittill( #"objectives_shown" );
    globallogic_ui::function_9ed5232e( model, 0 );
}

// Namespace objectives_ui/objectives_ui
// Params 2
// Checksum 0x186dccb, Offset: 0xde0
// Size: 0x3c
function set_progress( obj_id, progress )
{
    globallogic_ui::function_8954fa13( "_DataSources.cp_objectives_list", obj_id, "progress", progress );
}

// Namespace objectives_ui/objectives_ui
// Params 2
// Checksum 0x23c9154a, Offset: 0xe28
// Size: 0x3c
function function_97d05398( obj_id, count )
{
    globallogic_ui::function_8954fa13( "_DataSources.cp_objectives_list", obj_id, "currentCount", count );
}

// Namespace objectives_ui/objectives_ui
// Params 2
// Checksum 0x9719e99c, Offset: 0xe70
// Size: 0x3c
function function_302128de( obj_id, count )
{
    globallogic_ui::function_8954fa13( "_DataSources.cp_objectives_list", obj_id, "targetCount", count );
}

// Namespace objectives_ui/objectives_ui
// Params 2
// Checksum 0xf5c9821, Offset: 0xeb8
// Size: 0x3c
function function_bacd9b1f( obj_id, show )
{
    globallogic_ui::function_8954fa13( "_DataSources.cp_objectives_list", obj_id, "showCounts", show );
}

// Namespace objectives_ui/objectives_ui
// Params 1
// Checksum 0x161acbe2, Offset: 0xf00
// Size: 0x34, Type: bool
function function_1fe5876a( obj_id )
{
    return isdefined( globallogic_ui::function_a8d716c5( "_DataSources.cp_objectives_list", obj_id, "description" ) );
}

// Namespace objectives_ui/objectives_ui
// Params 1
// Checksum 0x444ca619, Offset: 0xf40
// Size: 0x6c
function remove_objective( obj_id )
{
    globallogic_ui::function_6db5e620( "_DataSources.cp_objectives_list", obj_id );
    globallogic_ui::function_9ed5232e( "hudItems.cpObjectiveUiData.updateList", 1, 1, 1, 0, 0, 1 );
    function_bb708c99( obj_id );
}

// Namespace objectives_ui/objectives_ui
// Params 0
// Checksum 0x849e3baa, Offset: 0xfb8
// Size: 0x8c
function remove_all()
{
    for ( i = 0; i < 64 ; i++ )
    {
        globallogic_ui::function_6db5e620( "_DataSources.cp_objectives_list", i );
    }
    
    globallogic_ui::function_9ed5232e( "hudItems.cpObjectiveUiData.updateList", 1, 1, 1, 0, 0, 1 );
    function_bb708c99( -1 );
}

// Namespace objectives_ui/objectives_ui
// Params 1, eflags: 0x4
// Checksum 0x2e4f10ce, Offset: 0x1050
// Size: 0x2c
function private function_bb708c99( obj_id )
{
    globallogic_ui::function_9ed5232e( "objective.removedObjective", obj_id, 0, 1 );
}

