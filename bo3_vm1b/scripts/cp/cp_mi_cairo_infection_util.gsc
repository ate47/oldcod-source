#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;

#namespace infection_util;

// Namespace infection_util
// Params 0, eflags: 0x2
// Checksum 0x6adaa2d6, Offset: 0xd48
// Size: 0x2a
function autoexec __init__sytem__()
{
    system::register( "infection_util", &__init__, undefined, undefined );
}

// Namespace infection_util
// Params 0
// Checksum 0xb8efecd1, Offset: 0xd80
// Size: 0x14a
function __init__()
{
    sp_sarah = getent( "sarah", "targetname" );
    
    if ( isdefined( sp_sarah ) )
    {
        sp_sarah spawner::add_spawn_function( &spawn_func_toggle_light_flash );
    }
    
    level.lighting_state = 0;
    callback::on_spawned( &on_player_spawned );
    callback::on_disconnect( &on_player_disconnect );
    callback::on_spawned( &snow_fx_play );
    callback::on_actor_killed( &ai_death_explosions );
    callback::on_actor_killed( &function_1cbdd501 );
    callback::on_ai_spawned( &function_796d4d97 );
    init_client_field_callback_funcs();
    init_flags();
    level thread setup_snow_triggers();
}

// Namespace infection_util
// Params 0
// Checksum 0xf469263a, Offset: 0xed8
// Size: 0x32
function init_flags()
{
    level flag::init( "sarah_anchor_prep_scene_done" );
    level flag::init( "sarah_anchor_post_scene_done" );
}

// Namespace infection_util
// Params 0
// Checksum 0x3bb01302, Offset: 0xf18
// Size: 0x232
function init_client_field_callback_funcs()
{
    clientfield::register( "toplayer", "snow_fx", 1, 2, "int" );
    clientfield::register( "actor", "sarah_objective_light", 1, 1, "int" );
    clientfield::register( "actor", "sarah_body_light", 1, 1, "int" );
    clientfield::register( "actor", "reverse_arrival_snow_fx", 1, 1, "int" );
    clientfield::register( "actor", "reverse_arrival_dmg_fx", 1, 1, "int" );
    clientfield::register( "actor", "exploding_ai_deaths", 1, 1, "int" );
    clientfield::register( "actor", "reverse_arrival_explosion_fx", 1, 1, "int" );
    clientfield::register( "allplayers", "player_spawn_fx", 1, 1, "int" );
    clientfield::register( "toplayer", "stop_post_fx", 1, 1, "counter" );
    clientfield::register( "actor", "ai_dni_rez_in", 1, 1, "int" );
    clientfield::register( "actor", "ai_dni_rez_out", 1, 1, "counter" );
    clientfield::register( "toplayer", "postfx_dni_interrupt", 1, 1, "counter" );
    clientfield::register( "toplayer", "postfx_futz", 1, 1, "counter" );
    clientfield::register( "actor", "sarah_camo_shader", 1, 3, "int" );
}

// Namespace infection_util
// Params 0
// Checksum 0xe9c07cd6, Offset: 0x1158
// Size: 0x2
function on_player_spawned()
{
    
}

// Namespace infection_util
// Params 0
// Checksum 0xe9c07cd6, Offset: 0x1168
// Size: 0x2
function on_player_disconnect()
{
    
}

// Namespace infection_util
// Params 1
// Checksum 0xa775df15, Offset: 0x1178
// Size: 0xf4
function get_structs_with_objective_string( str_objective_string )
{
    a_structs = struct::get_array( "cp_coop_spawn", "targetname" );
    assert( a_structs.size, "<dev string:x28>" );
    a_found = [];
    
    for ( i = 0; i < a_structs.size ; i++ )
    {
        if ( a_structs[ i ].script_objective === str_objective_string )
        {
            if ( !isdefined( a_found ) )
            {
                a_found = [];
            }
            else if ( !isarray( a_found ) )
            {
                a_found = array( a_found );
            }
            
            a_found[ a_found.size ] = a_structs[ i ];
        }
    }
    
    assert( a_found.size, "<dev string:x44>" + str_objective_string );
    return a_found;
}

// Namespace infection_util
// Params 0
// Checksum 0x4531e236, Offset: 0x1278
// Size: 0xa1
function wait_for_player_spawn()
{
    level flag::wait_till( "all_players_connected" );
    
    do
    {
        wait 0.05;
        n_players_playing = 0;
        
        foreach ( player in getplayers() )
        {
            if ( player.sessionstate == "playing" )
            {
                n_players_playing++;
            }
        }
    }
    while ( n_players_playing == 0 );
}

// Namespace infection_util
// Params 2
// Checksum 0x5d9408a7, Offset: 0x1328
// Size: 0x1b3
function gather_players_inside_volume( str_volume_name, str_key )
{
    if ( !isdefined( str_key ) )
    {
        str_key = "targetname";
    }
    
    assert( isdefined( str_volume_name ), "<dev string:x9e>" );
    e_volume = getent( str_volume_name, str_key );
    assert( isdefined( e_volume ), "<dev string:xd8>" + str_key + "<dev string:x108>" + str_volume_name + "<dev string:x10e>" );
    assert( isdefined( e_volume.target ), "<dev string:x11b>" + str_volume_name + "<dev string:x13a>" );
    a_gather_structs = struct::get_array( e_volume.target, "targetname" );
    assert( a_gather_structs.size >= 4, "<dev string:x11b>" + str_volume_name + "<dev string:x171>" + a_gather_structs.size );
    
    foreach ( i, player in level.players )
    {
        if ( !player istouching( e_volume ) )
        {
            player setorigin( a_gather_structs[ i ].origin );
            player setplayerangles( a_gather_structs[ i ].angles );
        }
    }
}

// Namespace infection_util
// Params 0
// Checksum 0x8f5cd3ad, Offset: 0x14e8
// Size: 0x4d
function spawn_func_toggle_light_flash()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"fx_flash_start" );
        self light_flash_bright( 1 );
        self waittill( #"fx_flash_stop" );
        self light_flash_bright( 0 );
    }
}

// Namespace infection_util
// Params 1
// Checksum 0xccaeee6e, Offset: 0x1540
// Size: 0x32
function light_flash_bright( b_show )
{
    if ( !isdefined( b_show ) )
    {
        b_show = 1;
    }
    
    self clientfield::set( "sarah_objective_light", b_show );
}

// Namespace infection_util
// Params 0
// Checksum 0xbf4ea99e, Offset: 0x1580
// Size: 0x1a
function function_dafed344()
{
    self function_dbe72c95( "village" );
}

// Namespace infection_util
// Params 0
// Checksum 0xe66a19c5, Offset: 0x15a8
// Size: 0x1a
function function_2f6bf570()
{
    self function_dbe72c95( "village_inception" );
}

// Namespace infection_util
// Params 1
// Checksum 0x5acc1f09, Offset: 0x15d0
// Size: 0x52
function function_dbe72c95( str_objective )
{
    self endon( #"death" );
    self.script_objective = str_objective;
    
    if ( isdefined( self.animname ) )
    {
        return;
    }
    
    self.overrideactordamage = &callback_foy_ai_damage;
    self foy_custom_ai_spawn_behaivor();
}

// Namespace infection_util
// Params 12
// Checksum 0xcaf16855, Offset: 0x1630
// Size: 0xa6
function callback_foy_ai_damage( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, modelindex, psoffsettime, bonename )
{
    if ( !isplayer( eattacker ) )
    {
        idamage = int( abs( idamage * 0.75 ) );
    }
    
    return idamage;
}

// Namespace infection_util
// Params 2
// Checksum 0x8ab80e89, Offset: 0x16e0
// Size: 0xd6
function foy_custom_ai_spawn_behaivor( str_target, str_script_noteworthy )
{
    if ( !isdefined( str_target ) )
    {
        str_target = undefined;
    }
    
    if ( !isdefined( str_script_noteworthy ) )
    {
        str_script_noteworthy = undefined;
    }
    
    self endon( #"death" );
    
    while ( true )
    {
        if ( !isdefined( self.current_scene ) )
        {
            break;
        }
        
        wait 0.05;
    }
    
    if ( !isdefined( str_target ) )
    {
        if ( isdefined( self.target ) )
        {
            str_target = self.target;
        }
    }
    
    if ( !isdefined( str_script_noteworthy ) )
    {
        if ( isdefined( self.script_noteworthy ) )
        {
            str_script_noteworthy = self.script_noteworthy;
        }
    }
    
    if ( isdefined( str_target ) )
    {
        e_target = getnode( str_target, "targetname" );
        self setgoal( e_target );
        self waittill( #"goal" );
        self.goalradius = 64;
    }
}

// Namespace infection_util
// Params 1
// Checksum 0x4363876e, Offset: 0x17c0
// Size: 0xba
function set_goal_on_spawn( n_goal_radius )
{
    self endon( #"death" );
    
    if ( isdefined( self.target ) )
    {
        e_target = getent( self.target, "targetname" );
        
        if ( !isdefined( e_target ) )
        {
            e_target = getnode( self.target, "targetname" );
        }
        
        if ( isdefined( e_target ) )
        {
            self setgoal( e_target );
        }
        
        if ( isdefined( n_goal_radius ) )
        {
            n_goal_radius_old = self.goalradius;
            self.goalradius = n_goal_radius;
            self waittill( #"goal" );
            self.goalradius = n_goal_radius_old;
        }
    }
}

// Namespace infection_util
// Params 5
// Checksum 0x320463e5, Offset: 0x1888
// Size: 0x12c
function create_trigger_radius( v_position, n_radius, n_height, n_spawn_flags, str_trigger_type )
{
    if ( !isdefined( n_spawn_flags ) )
    {
        n_spawn_flags = 0;
    }
    
    if ( !isdefined( str_trigger_type ) )
    {
        str_trigger_type = "trigger_radius";
    }
    
    assert( isdefined( v_position ), "<dev string:x1a5>" );
    assert( isdefined( n_radius ), "<dev string:x1db>" );
    assert( isdefined( n_height ), "<dev string:x20f>" );
    t_use = spawn( str_trigger_type, v_position, n_spawn_flags, n_radius, n_height );
    t_use triggerignoreteam();
    t_use setvisibletoall();
    t_use setteamfortrigger( "none" );
    t_use usetriggerrequirelookat();
    
    if ( str_trigger_type == "trigger_radius_use" )
    {
        t_use setcursorhint( "HINT_NOICON" );
    }
    
    return t_use;
}

// Namespace infection_util
// Params 5
// Checksum 0xc27f573a, Offset: 0x19c0
// Size: 0x91
function slow_nearby_players_for_time( e_reference, n_distance_to_slow, n_duration, n_loop_time, n_timeout )
{
    if ( !isdefined( n_duration ) )
    {
        n_duration = 2;
    }
    
    if ( !isdefined( n_loop_time ) )
    {
        n_loop_time = 0.25;
    }
    
    if ( !isdefined( n_timeout ) )
    {
        n_timeout = 2;
    }
    
    n_time = 0;
    
    while ( n_time < n_duration )
    {
        slow_nearby_players( e_reference, n_distance_to_slow, n_timeout );
        wait n_loop_time;
        n_time += n_loop_time;
    }
}

// Namespace infection_util
// Params 3
// Checksum 0x5a79920, Offset: 0x1a60
// Size: 0x83
function slow_nearby_players( e_reference, n_distance_to_slow, n_timeout )
{
    foreach ( player in level.players )
    {
        player thread slow_player_within_range_for_time( e_reference, n_distance_to_slow, n_timeout );
    }
}

// Namespace infection_util
// Params 3
// Checksum 0x8af10744, Offset: 0x1af0
// Size: 0x162
function slow_player_within_range_for_time( e_reference, n_distance_to_slow, n_timeout )
{
    if ( !isdefined( n_timeout ) )
    {
        n_timeout = 1;
    }
    
    self endon( #"death" );
    n_current_distance = distance( self.origin, e_reference.origin );
    self.slowdown_amount = mapfloat( 0, n_distance_to_slow, 0.1, 1, n_current_distance );
    self setmovespeedscale( self.slowdown_amount );
    
    if ( !isdefined( self.slowdown_check_running ) )
    {
        self.slowdown_check_running = 0;
    }
    
    self.slowdown_time_stop = gettime() + ( n_timeout - 1 ) * 1000;
    
    if ( !self.slowdown_check_running )
    {
        self.slowdown_check_running = 1;
        
        while ( gettime() < self.slowdown_time_stop )
        {
            wait 0.1;
        }
        
        while ( self.slowdown_amount < 1 )
        {
            self.slowdown_amount = math::clamp( self.slowdown_amount + 0.1, 0, 1 );
            self setmovespeedscale( self.slowdown_amount );
            wait 0.1;
        }
        
        self setmovespeedscale( 1 );
        self.slowdown_check_running = 0;
    }
}

// Namespace infection_util
// Params 1
// Checksum 0xb34a7eef, Offset: 0x1c60
// Size: 0x32
function set_global_snow_fx( n_id )
{
    assert( isdefined( n_id ), "<dev string:x243>" );
    level.snow_fx_id = n_id;
}

// Namespace infection_util
// Params 0
// Checksum 0xcaf2c336, Offset: 0x1ca0
// Size: 0x1d
function get_global_snow_fx()
{
    if ( !isdefined( level.snow_fx_id ) )
    {
        level.snow_fx_id = 0;
    }
    
    return level.snow_fx_id;
}

// Namespace infection_util
// Params 1
// Checksum 0xdc6e38fd, Offset: 0x1cc8
// Size: 0x8b
function turn_on_snow_fx_for_all_players( n_id )
{
    if ( !isdefined( n_id ) )
    {
        n_id = 2;
    }
    
    set_global_snow_fx( n_id );
    
    foreach ( player in level.players )
    {
        player snow_fx_play( n_id );
    }
}

// Namespace infection_util
// Params 0
// Checksum 0xfc59b639, Offset: 0x1d60
// Size: 0x73
function turn_off_snow_fx_for_all_players()
{
    set_global_snow_fx( 0 );
    
    foreach ( player in level.players )
    {
        player snow_fx_stop();
    }
}

// Namespace infection_util
// Params 1
// Checksum 0xae65d077, Offset: 0x1de0
// Size: 0x62
function snow_fx_play( n_id )
{
    assert( isplayer( self ), "<dev string:x269>" );
    
    if ( !isdefined( n_id ) )
    {
        n_id = get_global_snow_fx();
    }
    
    self clientfield::set_to_player( "snow_fx", n_id );
}

// Namespace infection_util
// Params 1
// Checksum 0x2bd37169, Offset: 0x1e50
// Size: 0x6e
function snow_fx_stop( b_pause )
{
    if ( !isdefined( b_pause ) )
    {
        b_pause = 0;
    }
    
    assert( isplayer( self ), "<dev string:x29a>" );
    self clientfield::set_to_player( "snow_fx", 0 );
    
    if ( !b_pause )
    {
        self notify( #"snow_fx_disabled" );
        self.disable_snowfall_trigger_active = 0;
    }
}

// Namespace infection_util
// Params 3
// Checksum 0x547b224f, Offset: 0x1ec8
// Size: 0xc3
function link_traversals( str_value, str_key, b_enable )
{
    a_nodes = getnodearray( str_value, str_key );
    
    foreach ( node in a_nodes )
    {
        if ( node is_traversal_begin_node() )
        {
            if ( b_enable )
            {
                linktraversal( node );
                continue;
            }
            
            unlinktraversal( node );
        }
    }
}

// Namespace infection_util
// Params 0
// Checksum 0xfcd63fde, Offset: 0x1f98
// Size: 0x12, Type: bool
function is_traversal_begin_node()
{
    return self.type === "Begin";
}

// Namespace infection_util
// Params 0
// Checksum 0xfe1502d, Offset: 0x1fb8
// Size: 0x3d
function trigger_disable_snowfall()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"trigger", player );
        self thread disable_snowfall_while_inside_trigger( player );
    }
}

// Namespace infection_util
// Params 1
// Checksum 0x7fa54886, Offset: 0x2000
// Size: 0xca
function disable_snowfall_while_inside_trigger( player )
{
    player endon( #"death" );
    player endon( #"snow_fx_disabled" );
    
    if ( !isdefined( player.disable_snowfall_trigger_active ) )
    {
        player.disable_snowfall_trigger_active = 0;
    }
    
    if ( !player.disable_snowfall_trigger_active )
    {
        player.disable_snowfall_trigger_active = 1;
        n_clientfield_state = player clientfield::get_to_player( "snow_fx" );
        player snow_fx_stop( 1 );
        
        while ( player istouching( self ) )
        {
            wait 0.25;
        }
        
        player.disable_snowfall_trigger_active = 0;
        player snow_fx_play( n_clientfield_state );
    }
}

/#

    // Namespace infection_util
    // Params 1
    // Checksum 0x901ae499, Offset: 0x20d8
    // Size: 0x22, Type: dev
    function play_dialog( str_line )
    {
        iprintlnbold( str_line );
    }

#/

// Namespace infection_util
// Params 1
// Checksum 0xae27dff1, Offset: 0x2108
// Size: 0xe3
function teleport_coop_players_after_shared_cinematic( a_ents )
{
    if ( level.players.size > 1 )
    {
        level thread util::screen_fade_in( 1, "white" );
        earthquake( 0.5, 0.5, level.players[ 0 ].origin, 500 );
        util::teleport_players_igc( level.skipto_point );
        
        foreach ( player in level.players )
        {
            player playrumbleonentity( "damage_heavy" );
        }
    }
}

// Namespace infection_util
// Params 0
// Checksum 0x981a70b8, Offset: 0x21f8
// Size: 0x92
function setup_anim_callbacks()
{
    scene::add_scene_func( "cin_inf_00_00_sarah_vign_move_idle", &callback_scene_objective_light_enable, "play" );
    scene::add_scene_func( "cin_inf_06_03_bastogne_aie_reversemg42", &callback_reverse_time_group_mg42_init, "init" );
    scene::add_scene_func( "cin_inf_06_03_bastogne_aie_reversemg42", &callback_reverse_time_group_mg42_play, "play" );
}

// Namespace infection_util
// Params 1
// Checksum 0xaa1ee12a, Offset: 0x2298
// Size: 0x72
function setup_reverse_time_arrivals( str_group )
{
    a_scene_bundles = struct::get_array( str_group, "targetname" );
    assert( a_scene_bundles.size, "<dev string:x2cb>" + str_group + "<dev string:x312>" );
    level thread array::spread_all( a_scene_bundles, &_init_reverse_time_arrival );
}

// Namespace infection_util
// Params 0
// Checksum 0xce229d05, Offset: 0x2318
// Size: 0x715
function _init_reverse_time_arrival()
{
    if ( !isdefined( self.script_minplayers ) || self.script_minplayers <= level.players.size )
    {
        scene::add_scene_func( self.scriptbundlename, &scene_callback_reverse_time_init, "init" );
        scene::add_scene_func( self.scriptbundlename, &scene_callback_reverse_time_done, "done" );
        scene::init( self.scriptbundlename );
        
        if ( !isdefined( self.radius ) )
        {
            self.radius = 1300;
        }
        
        if ( !isdefined( self.height ) )
        {
            self.height = 512;
        }
        
        if ( !isdefined( self.script_int ) )
        {
            self.script_int = 0;
        }
        
        v_origin_offset = ( 0, 0, self.script_int );
        
        if ( isdefined( self.target ) )
        {
            t_start = getent( self.target, "targetname" );
            
            if ( !isdefined( t_start ) )
            {
                t_start = create_trigger_radius( self.origin + v_origin_offset, self.radius, self.height );
            }
        }
        else
        {
            t_start = create_trigger_radius( self.origin + v_origin_offset, self.radius, self.height );
        }
        
        t_start.script_noteworthy = "reverse_anim_trigger";
        
        if ( !isdefined( t_start.reverse_time_arrivals_using ) )
        {
            t_start.reverse_time_arrivals_using = 0;
        }
        
        t_start.reverse_time_arrivals_using++;
        
        switch ( self.scriptbundlename )
        {
            case "cin_inf_06_03_bastogne_aie_reversemortar":
                self thread function_2f9ccb03( t_start, "target", 1, 2.2, 1, 2 );
                break;
            case "cin_inf_06_03_bastogne_aie_reversehalftrack":
                self thread function_2f9ccb03( t_start, "target", 0, 0, 1, 1.5 );
                break;
            case "cin_inf_06_03_bastogne_vign_reverseforwardroll":
                self thread function_2f9ccb03( t_start, "target", 1, 0.7, 1, 2 );
                break;
            case "cin_inf_06_03_bastogne_vign_reverseforwardroll02":
                self thread function_2f9ccb03( t_start, "target", 1, 2.8, 1, 2.5 );
                break;
            case "cin_inf_06_03_bastogne_vign_reversebackroll":
                self thread function_2f9ccb03( t_start, "target", 1, 0.65, 1, 2.5 );
                break;
            case "cin_inf_06_03_bastogne_vign_reversebackroll02":
                self thread function_2f9ccb03( t_start, "target", 1, 2.1, 1, 2 );
                break;
            case "cin_inf_06_03_bastogne_vign_reversebackroll03":
                self thread function_2f9ccb03( t_start, "target", 1, 1.8, 1, 1 );
                break;
            case "cin_inf_06_03_bastogne_aie_reverselandmine":
                self thread function_2f9ccb03( t_start, "target", 1, 1.3, 1, 1.5 );
                break;
            case "cin_inf_06_03_bastogne_aie_reversemg42":
                self thread function_2f9ccb03( t_start, "script_label", 1, 1.95, 1, 2 );
                break;
            case "cin_inf_10_02_foy_aie_reversetankshell_soldier01_suppressor":
                self thread function_2f9ccb03( t_start, "script_label", 1, 3.5, 0, 0 );
                break;
            case "cin_inf_06_03_bastogne_vign_reversedance":
                self thread function_2f9ccb03( t_start, "script_label", 1, 1.9, 1, 2 );
                break;
            case "cin_inf_10_02_bastogne_vign_reversemortar2floor_sniper":
                self thread function_2f9ccb03( t_start, "script_label", 1, 2.8, 0, 0 );
                break;
            case "cin_inf_06_03_bastogne_aie_reverse_soldier01hipshot":
                self thread function_23bbf7f6( t_start, 1.15 );
                break;
            case "cin_inf_06_03_bastogne_aie_reverse_soldier01hipshot_suppressor":
                self thread function_23bbf7f6( t_start, 1.15 );
                break;
            case "cin_inf_06_03_bastogne_aie_reverse_soldier02headshot":
                self thread function_23bbf7f6( t_start, 1.25 );
                break;
            case "cin_inf_06_03_bastogne_aie_reverse_soldier02headshot_sniper":
                self thread function_23bbf7f6( t_start, 1.25 );
                break;
            case "cin_inf_06_03_bastogne_aie_reverse_soldier02headshot_suppressor":
                self thread function_23bbf7f6( t_start, 1.25 );
                break;
            case "cin_inf_11_02_fold_aie_reverse_1":
                self thread function_23bbf7f6( t_start, 4.25 );
                break;
            case "cin_inf_11_02_fold_aie_reverse_2":
                self thread function_23bbf7f6( t_start, 4.25 );
                break;
            case "cin_inf_11_02_fold_aie_reverse_3":
                self thread function_23bbf7f6( t_start, 4.25 );
                break;
            case "cin_inf_11_03_fold_vign_reverse_sniper":
                self thread function_23bbf7f6( t_start, 1.55 );
                break;
            case "cin_inf_10_02_foy_aie_reverseshot_1_suppressor":
                self thread function_23bbf7f6( t_start, 5.45 );
                break;
            case "cin_inf_10_02_foy_aie_reverseshot_5_sniper":
                self thread function_23bbf7f6( t_start, 5.45 );
                break;
            case "cin_inf_10_02_bastogne_vign_reversefall2floor_suppressor":
                self thread function_23bbf7f6( t_start, 0.85 );
                break;
            case "cin_inf_07_02_worldfallsaway_vign_direwolf_reverse_dth_1":
                self thread function_23bbf7f6( t_start, 2.45 );
                break;
            case "cin_inf_07_02_worldfallsaway_vign_direwolf_reverse_dth_2":
                self thread function_23bbf7f6( t_start, 1.95 );
                break;
            case "cin_inf_07_02_worldfallsaway_vign_direwolf_reverse_dth_3":
                self thread function_23bbf7f6( t_start, 1.95 );
                break;
            case "cin_inf_07_02_worldfallsaway_vign_direwolf_reverse_dth_4":
                self thread function_23bbf7f6( t_start, 1.95 );
                break;
            default:
                t_start waittill( #"trigger" );
                t_start.reverse_time_arrivals_using--;
                
                if ( t_start.reverse_time_arrivals_using == 0 )
                {
                    t_start delete();
                }
                
                if ( isdefined( self.script_delay ) )
                {
                    wait self.script_delay;
                }
                
                scene::play( self.scriptbundlename );
                break;
        }
    }
}

// Namespace infection_util
// Params 6
// Checksum 0xb9d26213, Offset: 0x2a38
// Size: 0x24a
function function_2f9ccb03( t_start, var_151e15ca, var_c69a4c6, var_68d91705, var_8593df01, var_a35c8512 )
{
    if ( !isdefined( var_151e15ca ) )
    {
        var_151e15ca = "target";
    }
    
    if ( !isdefined( var_c69a4c6 ) )
    {
        var_c69a4c6 = 1;
    }
    
    if ( !isdefined( var_68d91705 ) )
    {
        var_68d91705 = 2;
    }
    
    if ( !isdefined( var_8593df01 ) )
    {
        var_8593df01 = 1;
    }
    
    if ( !isdefined( var_a35c8512 ) )
    {
        var_a35c8512 = 2;
    }
    
    t_start waittill( #"trigger" );
    t_start.reverse_time_arrivals_using--;
    
    if ( t_start.reverse_time_arrivals_using == 0 )
    {
        t_start delete();
    }
    
    if ( isdefined( self.script_delay ) )
    {
        wait self.script_delay;
    }
    
    if ( var_c69a4c6 )
    {
        if ( var_151e15ca == "target" )
        {
            if ( isdefined( self.target ) )
            {
                s_loc = struct::get( self.target, "targetname" );
                playfx( level._effect[ "reverse_mortar" ], s_loc.origin );
                wait var_68d91705;
            }
        }
        else if ( var_151e15ca == "script_label" )
        {
            if ( isdefined( self.script_label ) )
            {
                s_loc = struct::get( self.script_label, "targetname" );
                playfx( level._effect[ "reverse_mortar" ], s_loc.origin );
                wait var_68d91705;
            }
        }
    }
    
    if ( var_8593df01 )
    {
        if ( isdefined( self.scenes ) )
        {
            a_actors = [[ self.scenes[ 0 ] ]]->get_ents();
            
            foreach ( actor in a_actors )
            {
                if ( isactor( actor ) )
                {
                    actor clientfield::set( "reverse_arrival_snow_fx", 1 );
                }
            }
        }
        
        wait var_a35c8512;
    }
    
    scene::play( self.scriptbundlename );
}

// Namespace infection_util
// Params 2
// Checksum 0xeb5d4b92, Offset: 0x2c90
// Size: 0xf2
function function_23bbf7f6( t_start, var_ecd15ef7 )
{
    if ( !isdefined( var_ecd15ef7 ) )
    {
        var_ecd15ef7 = 2;
    }
    
    t_start waittill( #"trigger" );
    t_start.reverse_time_arrivals_using--;
    
    if ( t_start.reverse_time_arrivals_using == 0 )
    {
        t_start delete();
    }
    
    if ( isdefined( self.script_delay ) )
    {
        wait self.script_delay;
    }
    
    if ( isdefined( self.script_label ) )
    {
        s_loc = struct::get( self.script_label, "targetname" );
        var_cf340ccb = s_loc.origin;
    }
    
    self thread scene::play( self.scriptbundlename );
    wait var_ecd15ef7;
    
    if ( isdefined( var_cf340ccb ) )
    {
        playfx( level._effect[ "bullet_impact" ], var_cf340ccb );
    }
}

// Namespace infection_util
// Params 1
// Checksum 0xa1df48fb, Offset: 0x2d90
// Size: 0xb3
function scene_callback_reverse_time_init( a_ents )
{
    foreach ( ent in a_ents )
    {
        if ( isactor( ent ) )
        {
            if ( isdefined( level.reduce_german_accuracy ) && level.reduce_german_accuracy )
            {
                ent.script_accuracy = level.var_52b1f753;
            }
            
            ent reverse_time_set_on_ai( 1 );
            ent thread reverse_guy_goto_target_init( self );
        }
    }
}

// Namespace infection_util
// Params 1
// Checksum 0x56360862, Offset: 0x2e50
// Size: 0x7b
function scene_callback_reverse_time_done( a_ents )
{
    foreach ( ent in a_ents )
    {
        if ( isactor( ent ) )
        {
            ent reverse_time_set_on_ai( 0 );
        }
    }
}

// Namespace infection_util
// Params 1
// Checksum 0x8c587008, Offset: 0x2ed8
// Size: 0xdb
function scene_callback_reverse_time_play_foy( a_ents )
{
    str_target = undefined;
    str_script_noteworthy = undefined;
    
    if ( isdefined( self.target ) )
    {
        str_target = self.target;
    }
    
    if ( isdefined( self.script_noteworthy ) )
    {
        str_script_noteworthy = self.script_noteworthy;
    }
    
    foreach ( ent in a_ents )
    {
        if ( isactor( ent ) )
        {
            ent reverse_time_set_on_ai( 0 );
            ent thread foy_custom_ai_spawn_behaivor( str_target, str_script_noteworthy );
        }
    }
}

// Namespace infection_util
// Params 1
// Checksum 0x81d73985, Offset: 0x2fc0
// Size: 0x52
function reverse_time_set_on_ai( b_set )
{
    self ai::set_ignoreall( b_set );
    self ai::set_ignoreme( b_set );
    
    if ( b_set )
    {
        self disableaimassist();
        return;
    }
    
    self enableaimassist();
}

// Namespace infection_util
// Params 1
// Checksum 0x98761c49, Offset: 0x3020
// Size: 0x22
function get_closest_player_to_position( v_position )
{
    return arraysort( level.players, v_position, 1 )[ 0 ];
}

// Namespace infection_util
// Params 1
// Checksum 0xe8d404dd, Offset: 0x3050
// Size: 0x9a
function reverse_guy_goto_target_init( s_bundle )
{
    if ( isdefined( s_bundle.script_string ) )
    {
        radius = 1024;
        
        if ( isdefined( s_bundle.script_float ) )
        {
            radius = s_bundle.script_float;
        }
        
        disable_fallback = 0;
        
        if ( isdefined( s_bundle.script_noteworthy ) && s_bundle.script_noteworthy == "no_fallback" )
        {
            disable_fallback = 1;
        }
        
        self thread reverse_guy_goto_target( s_bundle.script_string, s_bundle.scriptbundlename, radius, disable_fallback );
    }
}

// Namespace infection_util
// Params 4
// Checksum 0xf523dfaf, Offset: 0x30f8
// Size: 0x196
function reverse_guy_goto_target( str_target, str_bundle_name, end_goal_radius, disable_fallback )
{
    self endon( #"death" );
    wait 1;
    
    while ( true )
    {
        if ( !isdefined( self.current_scene ) )
        {
            break;
        }
        
        wait 0.05;
    }
    
    self.goalradius = 64;
    
    if ( isdefined( disable_fallback ) && disable_fallback )
    {
        self.disable_fallback = 1;
    }
    
    if ( issubstr( str_target, "volume" ) )
    {
        e_target = getent( str_target, "targetname" );
        self setgoal( e_target );
    }
    else if ( issubstr( str_target, "nd_array" ) )
    {
        a_nd_targets = getnodearray( str_target, "targetname" );
        nd_closest = arraygetclosest( self.origin, a_nd_targets );
        
        if ( !isnodeoccupied( nd_closest ) )
        {
            self setgoal( nd_closest );
        }
        else
        {
            self.goalradius = end_goal_radius;
            return;
        }
    }
    else
    {
        nd_target = getnode( str_target, "targetname" );
        self setgoal( nd_target.origin );
    }
    
    self waittill( #"goal" );
    self.goalradius = end_goal_radius;
}

// Namespace infection_util
// Params 1
// Checksum 0x1dc1e4ef, Offset: 0x3298
// Size: 0xa
function callback_reverse_time_group_mg42_init( a_ents )
{
    
}

// Namespace infection_util
// Params 1
// Checksum 0x97d77a87, Offset: 0x32b0
// Size: 0xa
function callback_reverse_time_group_mg42_play( a_ents )
{
    
}

// Namespace infection_util
// Params 1
// Checksum 0xc5b7bf96, Offset: 0x32c8
// Size: 0x5a
function function_23e59afd( a_ents )
{
    if ( !isdefined( level.var_340fac2e ) )
    {
        level.var_340fac2e = vehicle::simple_spawn_single( "veh_sarah_mover" );
        level.var_340fac2e.drivepath = 1;
    }
    
    level flag::set( "sarah_anchor_prep_scene_done" );
}

// Namespace infection_util
// Params 1
// Checksum 0x75d07a9, Offset: 0x3330
// Size: 0x14a
function function_e2eba6da( a_ents )
{
    level flag::wait_till( "sarah_anchor_prep_scene_done" );
    assert( isdefined( level.var_340fac2e ), "<dev string:x315>" );
    ai_objective_sarah = a_ents[ "sarah" ];
    ai_objective_sarah ai::set_ignoreall( 1 );
    ai_objective_sarah ai::set_ignoreme( 1 );
    level.var_340fac2e.origin = ai_objective_sarah.origin;
    level.var_340fac2e.angles = ai_objective_sarah.angles;
    ai_objective_sarah.anchor = level.var_340fac2e;
    ai_objective_sarah.anchor.targetname = "sarah_objective_align";
    ai_objective_sarah linkto( ai_objective_sarah.anchor );
    ai_objective_sarah thread function_6987653b();
    ai_objective_sarah thread sarah_objective_marker();
    ai_objective_sarah thread function_8739c05f();
    ai_objective_sarah thread function_1b0b83dc();
    level flag::set( "sarah_anchor_post_scene_done" );
}

// Namespace infection_util
// Params 0
// Checksum 0x38c162d5, Offset: 0x3488
// Size: 0x54
function function_cbc167()
{
    level.var_340fac2e = vehicle::simple_spawn_single( "veh_sarah_mover" );
    level.var_340fac2e.drivepath = 1;
    ai_objective_sarah = util::get_hero( "sarah" );
}

// Namespace infection_util
// Params 3
// Checksum 0x937e745c, Offset: 0x34e8
// Size: 0x3ea
function function_3fe1f72( str_start_trigger, n_start, func_on_complete )
{
    level endon( #"hash_afb79ff0" );
    
    if ( !isdefined( level.var_340fac2e ) )
    {
        level.var_340fac2e = vehicle::simple_spawn_single( "veh_sarah_mover" );
    }
    
    if ( isdefined( n_start ) )
    {
        t_next = getent( str_start_trigger + n_start, "targetname" );
        level.sarah_obj_trigs = objective_trigger_watcher_init( str_start_trigger, n_start );
        array::thread_all( level.sarah_obj_trigs, &objective_trigger_watcher, level.sarah_obj_trigs );
        
        if ( n_start > 0 )
        {
            for ( i = 0; i < n_start - 1 ; i++ )
            {
                t_removed = getent( str_start_trigger + i, "targetname" );
                t_removed delete();
            }
        }
    }
    
    var_c66ffe01 = getvehiclenode( t_next.target, "targetname" );
    ai_objective_sarah = util::get_hero( "sarah" );
    
    if ( !ai_objective_sarah islinkedto( level.var_340fac2e ) )
    {
        ai_objective_sarah forceteleport( var_c66ffe01.origin, var_c66ffe01.angles );
        ai_objective_sarah ai::set_ignoreall( 1 );
        ai_objective_sarah ai::set_ignoreme( 1 );
        ai_objective_sarah.anchor = level.var_340fac2e;
        ai_objective_sarah.anchor.targetname = "sarah_objective_align";
        ai_objective_sarah linkto( ai_objective_sarah.anchor );
        ai_objective_sarah.anchor thread scene::play( "cin_inf_00_00_sarah_vign_move_idle", ai_objective_sarah );
        level.var_340fac2e.origin = var_c66ffe01.origin;
        level.var_340fac2e.angles = var_c66ffe01.angles;
        level.var_340fac2e.drivepath = 1;
        ai_objective_sarah thread function_6987653b();
        ai_objective_sarah thread sarah_objective_marker();
        ai_objective_sarah thread function_8739c05f();
        ai_objective_sarah thread function_1b0b83dc();
    }
    
    var_782c4804 = 0;
    var_255c21d = undefined;
    level thread function_1a5bb539( ai_objective_sarah, func_on_complete );
    
    while ( isdefined( t_next ) )
    {
        var_255c21d = t_next;
        t_next waittill( #"trigger" );
        arrayremovevalue( level.sarah_obj_trigs, t_next );
        n_start++;
        t_next = getent( str_start_trigger + n_start, "targetname" );
        
        if ( !isdefined( t_next ) )
        {
            continue;
        }
        
        if ( !var_782c4804 )
        {
            ai_objective_sarah.anchor vehicle::get_on_path( var_c66ffe01 );
            ai_objective_sarah.anchor thread vehicle::go_path();
            var_782c4804 = 1;
        }
        
        if ( isdefined( var_255c21d.script_flag_set ) && !flag::get( var_255c21d.script_flag_set ) )
        {
            ai_objective_sarah.anchor flag::wait_till( "waiting_for_flag" );
        }
    }
    
    ai_objective_sarah.anchor waittill( #"reached_end_node" );
    function_73c28a85( ai_objective_sarah, func_on_complete );
}

// Namespace infection_util
// Params 2
// Checksum 0x69e27959, Offset: 0x38e0
// Size: 0x129
function function_73c28a85( ai_objective_sarah, func_on_complete )
{
    if ( ai_objective_sarah.anchor scene::is_playing( "cin_inf_00_00_sarah_vign_move_idle" ) || ai_objective_sarah.anchor scene::is_playing( "cin_inf_00_00_sarah_vign_move_enter" ) || ai_objective_sarah.anchor scene::is_playing( "cin_inf_00_00_sarah_vign_move_leave" ) || ai_objective_sarah.anchor scene::is_playing( "cin_inf_00_00_sarah_vign_move_idle_talk" ) )
    {
        ai_objective_sarah.anchor scene::stop();
    }
    
    ai_objective_sarah clientfield::set( "sarah_objective_light", 0 );
    ai_objective_sarah unlink();
    ai_objective_sarah.anchor delete();
    
    if ( isdefined( ai_objective_sarah.var_5d21e1c9 ) )
    {
        ai_objective_sarah.var_5d21e1c9 = 0;
    }
    
    util::wait_network_frame();
    
    if ( isdefined( func_on_complete ) )
    {
        ai_objective_sarah thread [[ func_on_complete ]]();
    }
}

// Namespace infection_util
// Params 0
// Checksum 0x904b83a7, Offset: 0x3a18
// Size: 0x95
function function_6987653b()
{
    self endon( #"death" );
    self.anchor endon( #"death" );
    
    while ( true )
    {
        self.var_f11a8dcd = 1;
        self sarah_moving_animations_start();
        self.anchor flag::wait_till( "waiting_for_flag" );
        self.var_f11a8dcd = 0;
        self sarah_moving_animations_stop();
        self.anchor flag::wait_till_clear( "waiting_for_flag" );
    }
}

// Namespace infection_util
// Params 0
// Checksum 0x232c3e93, Offset: 0x3ab8
// Size: 0x3a
function function_1b0b83dc()
{
    self endon( #"death" );
    self.anchor endon( #"death" );
    level waittill( #"hash_8b5ed1cb" );
    self.anchor resumespeed();
}

// Namespace infection_util
// Params 2
// Checksum 0x9482a9be, Offset: 0x3b00
// Size: 0x8a
function function_1a5bb539( ai_objective_sarah, func_on_complete )
{
    ai_objective_sarah endon( #"reached_end_node" );
    ai_objective_sarah endon( #"death" );
    level waittill( #"hash_afb79ff0" );
    
    if ( isdefined( ai_objective_sarah.anchor ) )
    {
        ai_objective_sarah.anchor setspeed( 0, 99999, 99999 );
        ai_objective_sarah.anchor vehicle::get_off_path();
    }
    
    function_73c28a85( ai_objective_sarah, func_on_complete );
}

// Namespace infection_util
// Params 0
// Checksum 0xd660741b, Offset: 0x3b98
// Size: 0x195
function function_8739c05f()
{
    level endon( #"hash_8b5ed1cb" );
    self endon( #"death" );
    self.anchor endon( #"death" );
    wait 3;
    
    while ( true )
    {
        var_e243bf54 = [];
        
        foreach ( player in level.activeplayers )
        {
            if ( !isdefined( var_e243bf54 ) )
            {
                var_e243bf54 = [];
            }
            else if ( !isarray( var_e243bf54 ) )
            {
                var_e243bf54 = array( var_e243bf54 );
            }
            
            var_e243bf54[ var_e243bf54.size ] = player.origin;
        }
        
        var_e243bf54 = arraysortclosest( var_e243bf54, self.anchor.origin );
        
        if ( isdefined( var_e243bf54[ 0 ] ) && self.var_f11a8dcd )
        {
            if ( distance2d( self.anchor.origin, var_e243bf54[ 0 ] ) < 550 )
            {
                self.anchor setspeed( 300, 30, 600 );
            }
            else
            {
                self.anchor resumespeed();
            }
        }
        
        wait 0.1;
    }
}

// Namespace infection_util
// Params 0
// Checksum 0x841e3065, Offset: 0x3d38
// Size: 0x3a
function sarah_moving_animations_start()
{
    self endon( #"death" );
    self.anchor endon( #"death" );
    self.anchor scene::play( "cin_inf_00_00_sarah_vign_move_leave", self );
}

// Namespace infection_util
// Params 1
// Checksum 0xdf2e2646, Offset: 0x3d80
// Size: 0x7a
function sarah_moving_animations_stop( final_pos )
{
    self endon( #"death" );
    self.anchor endon( #"death" );
    
    if ( isdefined( final_pos ) )
    {
        while ( distance( self.origin, final_pos.origin ) > 512 )
        {
            wait 0.1;
        }
    }
    
    self.anchor scene::play( "cin_inf_00_00_sarah_vign_move_enter", self );
}

// Namespace infection_util
// Params 0
// Checksum 0x4ede5a82, Offset: 0x3e08
// Size: 0x52
function function_637cd603()
{
    ai_sarah = util::get_hero( "sarah" );
    
    if ( isdefined( ai_sarah.anchor ) )
    {
        ai_sarah.anchor thread scene::play( "cin_inf_00_00_sarah_vign_move_idle_talk", ai_sarah );
    }
}

// Namespace infection_util
// Params 0
// Checksum 0x28e9df4, Offset: 0x3e68
// Size: 0xc9
function sarah_objective_marker()
{
    self endon( #"death" );
    self.var_5d21e1c9 = 1;
    
    while ( isdefined( self ) )
    {
        if ( self.var_5d21e1c9 )
        {
            if ( self get_min_distance_players() > 3000 || !self.var_f11a8dcd )
            {
                objectives::set( "cp_level_infection_sarah_goto", self );
                
                while ( ( distance( level.players[ 0 ].origin, self.origin ) > 3000 || !self.var_f11a8dcd ) && self.var_5d21e1c9 )
                {
                    wait 0.1;
                }
                
                objectives::complete( "cp_level_infection_sarah_goto", self );
            }
        }
        
        wait 1;
    }
}

// Namespace infection_util
// Params 0
// Checksum 0xfe6abb0b, Offset: 0x3f40
// Size: 0x73
function get_min_distance_players()
{
    n_dist = 10000;
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        n_player_dist = distance( level.players[ i ].origin, self.origin );
        
        if ( n_player_dist < n_dist )
        {
            n_dist = n_player_dist;
        }
    }
    
    return n_dist;
}

// Namespace infection_util
// Params 2
// Checksum 0xe58059ab, Offset: 0x3fc0
// Size: 0x77
function objective_trigger_watcher_init( str_start_trigger, n_start )
{
    a_t_next = [];
    
    while ( true )
    {
        t_next = getent( str_start_trigger + n_start, "targetname" );
        
        if ( isdefined( t_next ) )
        {
            t_next.t_num = n_start;
            array::add( a_t_next, t_next );
            n_start++;
            continue;
        }
        
        return a_t_next;
    }
}

// Namespace infection_util
// Params 1
// Checksum 0x1c3c66d2, Offset: 0x4040
// Size: 0xa5
function objective_trigger_watcher( a_trigs )
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"trigger", who );
        
        if ( isplayer( who ) )
        {
            for ( i = 0; i < a_trigs.size ; i++ )
            {
                if ( isdefined( a_trigs[ i ] ) && a_trigs[ i ].t_num < self.t_num )
                {
                    a_trigs[ i ] notify( #"trigger" );
                    util::wait_network_frame();
                }
            }
            
            return;
        }
    }
}

// Namespace infection_util
// Params 2
// Checksum 0x85d27b1a, Offset: 0x40f0
// Size: 0x42
function enable_exploding_deaths( b_enabled, n_delay_time )
{
    if ( !isdefined( b_enabled ) )
    {
        b_enabled = 1;
    }
    
    if ( !isdefined( n_delay_time ) )
    {
        n_delay_time = 0.1;
    }
    
    level.exploding_deaths = b_enabled;
    level.exploding_deaths_delay_time = n_delay_time;
}

// Namespace infection_util
// Params 0
// Checksum 0x6d7c6a7f, Offset: 0x4140
// Size: 0x1d
function exploding_deaths_enabled()
{
    if ( !isdefined( level.exploding_deaths ) )
    {
        level.exploding_deaths = 0;
    }
    
    return level.exploding_deaths;
}

// Namespace infection_util
// Params 0
// Checksum 0x171ed7f7, Offset: 0x4168
// Size: 0x73
function function_cd11e6ad()
{
    self endon( #"ai_explosion_death" );
    
    if ( isdefined( self.var_4227b8a9 ) && self.var_4227b8a9 )
    {
        return;
    }
    
    death_explode_delay();
    
    if ( isdefined( self ) )
    {
        self clientfield::increment( "ai_dni_rez_out" );
    }
    
    wait 0.5;
    
    if ( isdefined( self ) )
    {
        self delete();
        self notify( #"ai_explosion_death" );
    }
}

// Namespace infection_util
// Params 0
// Checksum 0xd409fcbc, Offset: 0x41e8
// Size: 0x8f
function explode_when_actor_becomes_corpse()
{
    self endon( #"ai_explosion_death" );
    
    if ( isdefined( self.var_4227b8a9 ) && self.var_4227b8a9 )
    {
        return;
    }
    
    self waittill( #"actor_corpse", e_corpse );
    death_explode_delay();
    
    if ( isdefined( e_corpse ) )
    {
        e_corpse clientfield::increment( "ai_dni_rez_out" );
    }
    
    wait 0.5;
    
    if ( isdefined( e_corpse ) )
    {
        e_corpse delete();
    }
    
    if ( isdefined( self ) )
    {
        self notify( #"ai_explosion_death" );
    }
}

// Namespace infection_util
// Params 0
// Checksum 0xb23fb176, Offset: 0x4280
// Size: 0x12a
function function_796d4d97()
{
    if ( !self should_explode_on_death() || isvehicle( self ) )
    {
        return;
    }
    
    var_fdb28cb6 = getweapon( "gadget_exo_breakdown" );
    var_1391f610 = getweapon( "gadget_mrpukey" );
    var_e0871753 = getweapon( "gadget_mrpukey_upgraded" );
    self waittill( #"cybercom_action", weapon, eattacker );
    
    if ( weapon === var_fdb28cb6 || weapon === var_1391f610 || weapon === var_e0871753 )
    {
        if ( isdefined( self ) )
        {
            self.var_4227b8a9 = 1;
            self notify( #"ai_explosion_death" );
        }
        
        self waittill( #"actor_corpse", e_corpse );
        
        if ( isdefined( e_corpse ) )
        {
            e_corpse clientfield::set( "exploding_ai_deaths", 1 );
        }
        
        util::wait_network_frame();
        
        if ( isdefined( e_corpse ) )
        {
            e_corpse delete();
        }
    }
}

// Namespace infection_util
// Params 2
// Checksum 0xf4aae3df, Offset: 0x43b8
// Size: 0x5a
function death_explode_delay( n_min, n_max )
{
    if ( !isdefined( n_min ) )
    {
        n_min = 0.1;
    }
    
    if ( !isdefined( n_max ) )
    {
        n_max = 0.3;
    }
    
    if ( isdefined( level.exploding_deaths_delay_time ) )
    {
        wait level.exploding_deaths_delay_time;
        return;
    }
    
    wait randomfloatrange( n_min, n_max );
}

// Namespace infection_util
// Params 0
// Checksum 0xb03de57, Offset: 0x4420
// Size: 0x7f
function function_dd8ade86()
{
    self endon( #"ai_explosion_death" );
    
    if ( isdefined( self.var_4227b8a9 ) && self.var_4227b8a9 )
    {
        return;
    }
    
    self waittill( #"actor_corpse", e_corpse );
    
    if ( isdefined( e_corpse ) )
    {
        e_corpse clientfield::increment( "ai_dni_rez_out" );
    }
    
    wait 0.5;
    
    if ( isdefined( e_corpse ) )
    {
        e_corpse delete();
    }
    
    if ( isdefined( self ) )
    {
        self notify( #"ai_explosion_death" );
    }
}

// Namespace infection_util
// Params 1
// Checksum 0x21b9eba1, Offset: 0x44a8
// Size: 0x82
function ai_death_explosions( params )
{
    var_4b570327 = 0;
    
    if ( isdefined( self.targetname ) )
    {
        if ( self.targetname == "sp_tank_gunner_ai" )
        {
            var_4b570327 = 1;
            self thread function_dd8ade86();
        }
    }
    
    if ( !var_4b570327 )
    {
        if ( self should_explode_on_death() )
        {
            self thread explode_when_actor_becomes_corpse();
            self thread function_cd11e6ad();
        }
    }
}

// Namespace infection_util
// Params 1
// Checksum 0xa2ea392c, Offset: 0x4538
// Size: 0x62
function function_1cbdd501( params )
{
    self endon( #"ai_explosion_death" );
    
    if ( isdefined( level.var_74bd7d24 ) && level.var_74bd7d24 )
    {
        if ( randomintrange( 0, 101 ) < 60 )
        {
            wait 0.75;
            
            if ( isdefined( self ) )
            {
                self playsound( "vox_ai_falldeath_scream_male" );
            }
        }
    }
}

// Namespace infection_util
// Params 0
// Checksum 0xf450abfd, Offset: 0x45a8
// Size: 0x36, Type: bool
function should_explode_on_death()
{
    return !isvehicle( self ) && exploding_deaths_enabled() && self.team != "allies";
}

// Namespace infection_util
// Params 0
// Checksum 0x840c474c, Offset: 0x45e8
// Size: 0x4a
function delete_all_ai()
{
    a_ai = getaiteamarray( "axis", "allies" );
    array::spread_all( a_ai, &_delete_if_defined );
}

// Namespace infection_util
// Params 0
// Checksum 0x92cd8e73, Offset: 0x4640
// Size: 0x1a
function _delete_if_defined()
{
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace infection_util
// Params 2
// Checksum 0x68f4d85b, Offset: 0x4668
// Size: 0x62
function delete_ents_if_defined( str_targetname, str_key )
{
    if ( !isdefined( str_key ) )
    {
        str_key = "targetname";
    }
    
    a_ents = getentarray( str_targetname, str_key );
    array::spread_all( a_ents, &_delete_if_defined );
}

// Namespace infection_util
// Params 0
// Checksum 0x5ba3912e, Offset: 0x46d8
// Size: 0x22
function function_e66c8377()
{
    self util::stop_magic_bullet_shield();
    self kill();
}

// Namespace infection_util
// Params 0
// Checksum 0xf062ca27, Offset: 0x4708
// Size: 0x3a
function function_5e78ab8c()
{
    self endon( #"death" );
    self clientfield::increment( "ai_dni_rez_out" );
    wait 0.5;
    self delete();
}

// Namespace infection_util
// Params 1
// Checksum 0x3578ade4, Offset: 0x4750
// Size: 0x1a
function callback_scene_objective_light_enable( a_ents )
{
    _callback_scene_objective_light( a_ents, 1 );
}

// Namespace infection_util
// Params 1
// Checksum 0xe583d665, Offset: 0x4778
// Size: 0x1a
function callback_scene_objective_light_disable_no_delete( a_ents )
{
    _callback_scene_objective_light( a_ents, 0 );
}

// Namespace infection_util
// Params 1
// Checksum 0xa6ea927d, Offset: 0x47a0
// Size: 0xaa
function callback_scene_objective_light_disable( a_ents )
{
    _callback_scene_objective_light( a_ents, 0 );
    
    foreach ( ent in a_ents )
    {
        if ( issubstr( ent.targetname, "sarah" ) )
        {
            ai_objective_sarah = ent;
        }
    }
    
    if ( isdefined( ai_objective_sarah ) )
    {
        ai_objective_sarah thread delete_sarah_when_done();
    }
}

// Namespace infection_util
// Params 0
// Checksum 0x307ac1b9, Offset: 0x4858
// Size: 0x32
function delete_sarah_when_done()
{
    self ai::set_ignoreall( 1 );
    util::wait_network_frame();
    self util::self_delete();
}

// Namespace infection_util
// Params 2
// Checksum 0xd95f3354, Offset: 0x4898
// Size: 0x10a
function _callback_scene_objective_light( a_ents, b_show )
{
    foreach ( ent in a_ents )
    {
        if ( isdefined( ent.targetname ) )
        {
            if ( issubstr( ent.targetname, "sarah" ) )
            {
                ai_objective_sarah = ent;
            }
        }
    }
    
    if ( isdefined( ai_objective_sarah ) )
    {
        if ( isai( ai_objective_sarah ) )
        {
            ai_objective_sarah ai::set_ignoreme( 1 );
        }
        
        if ( isdefined( b_show ) && b_show )
        {
            ai_objective_sarah clientfield::set( "sarah_objective_light", 1 );
            return;
        }
        
        ai_objective_sarah clientfield::set( "sarah_objective_light", 0 );
    }
}

// Namespace infection_util
// Params 0
// Checksum 0xdfa693f5, Offset: 0x49b0
// Size: 0x42
function setup_snow_triggers()
{
    array::spread_all( getentarray( "snow_disable", "script_noteworthy" ), &trigger_disable_snowfall );
}

// Namespace infection_util
// Params 4
// Checksum 0xe12eeb11, Offset: 0x4a00
// Size: 0x92
function play_scene_on_trigger( str_scene, str_trigger_value, str_trigger_key, b_init_at_start )
{
    if ( !isdefined( str_trigger_key ) )
    {
        str_trigger_key = "targetname";
    }
    
    if ( !isdefined( b_init_at_start ) )
    {
        b_init_at_start = 1;
    }
    
    assert( isdefined( str_scene ), "<dev string:x357>" );
    assert( isdefined( str_trigger_value ), "<dev string:x384>" );
    self thread _play_scene_on_trigger( str_scene, str_trigger_value, str_trigger_key, b_init_at_start );
}

// Namespace infection_util
// Params 4
// Checksum 0xb372be8b, Offset: 0x4aa0
// Size: 0x62
function _play_scene_on_trigger( str_scene, str_trigger_value, str_trigger_key, b_init_at_start )
{
    if ( b_init_at_start )
    {
        self scene::init( str_scene );
    }
    
    trigger::wait_till( str_trigger_value, str_trigger_key, undefined, 1 );
    self scene::play( str_scene );
}

// Namespace infection_util
// Params 5
// Checksum 0x92d74bc0, Offset: 0x4b10
// Size: 0x62
function play_scene_on_view_and_radius( str_scene, str_lookat, str_trigger_inner, str_trigger_outter, b_init_at_start )
{
    if ( !isdefined( b_init_at_start ) )
    {
        b_init_at_start = 1;
    }
    
    if ( b_init_at_start )
    {
        self scene::init( str_scene );
    }
    
    self thread _play_scene_on_view_and_radius( str_scene, str_lookat, str_trigger_inner, str_trigger_outter, b_init_at_start );
}

// Namespace infection_util
// Params 5
// Checksum 0x9bdac868, Offset: 0x4b80
// Size: 0x17d
function _play_scene_on_view_and_radius( str_scene, str_lookat, str_trigger_inner, str_trigger_outter, b_init_at_start )
{
    t_inner = getent( str_trigger_inner, "targetname" );
    t_outter = getent( str_trigger_outter, "targetname" );
    s_lookat = struct::get( str_lookat, "targetname" );
    
    while ( true )
    {
        trigger::wait_till( str_trigger_outter, "targetname" );
        
        if ( level.players.size == 1 )
        {
            if ( level.players[ 0 ] lookingatstructduration( s_lookat, t_inner, t_outter, 1 ) || level.players[ 0 ] istouching( t_inner ) )
            {
                self thread scene::play( str_scene );
                t_inner delete();
                t_outter delete();
                break;
            }
        }
        else
        {
            self thread scene::play( str_scene );
            t_inner delete();
            t_outter delete();
            break;
        }
        
        util::wait_network_frame();
    }
}

// Namespace infection_util
// Params 2
// Checksum 0xf319a9da, Offset: 0x4d08
// Size: 0x45
function isbetweeninneroutter( t_inner, t_outter )
{
    if ( self istouching( t_outter ) && !self istouching( t_inner ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace infection_util
// Params 3
// Checksum 0x83986695, Offset: 0x4d58
// Size: 0x7d
function islookingatstruct( s_lookat, n_dot_range, b_trace )
{
    if ( !isdefined( n_dot_range ) )
    {
        n_dot_range = 0.9;
    }
    
    if ( !isdefined( b_trace ) )
    {
        b_trace = 0;
    }
    
    self endon( #"death" );
    self endon( #"disconnect" );
    
    if ( !isdefined( self ) || !isdefined( s_lookat ) )
    {
        return 0;
    }
    
    if ( self util::is_looking_at( s_lookat.origin, n_dot_range, b_trace ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace infection_util
// Params 4
// Checksum 0x24083950, Offset: 0x4de0
// Size: 0xdd
function lookingatstructduration( s_lookat, t_inner, t_outter, n_duration )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    n_time = 0;
    b_radius_check = isbetweeninneroutter( t_inner, t_outter );
    b_lookat_check = islookingatstruct( s_lookat );
    
    while ( b_radius_check && b_lookat_check && n_time < n_duration )
    {
        b_radius_check = isbetweeninneroutter( t_inner, t_outter );
        b_lookat_check = islookingatstruct( s_lookat );
        wait 0.1;
        n_time += 0.1;
    }
    
    if ( b_radius_check && b_lookat_check && n_time >= n_duration )
    {
        return 1;
    }
    
    return 0;
}

// Namespace infection_util
// Params 4
// Checksum 0xe80b3633, Offset: 0x4ec8
// Size: 0x95
function lookingatstructdurationcheck( str_lookat, n_duration, str_notfiy, n_max_distance )
{
    if ( !isdefined( n_max_distance ) )
    {
        n_max_distance = undefined;
    }
    
    self endon( #"death" );
    self endon( #"disconnect" );
    s_lookat = struct::get( str_lookat, "targetname" );
    
    while ( true )
    {
        if ( self lookingatstructdurationonly( s_lookat, n_duration, n_max_distance ) )
        {
            level notify( str_notfiy );
            break;
        }
        
        util::wait_network_frame();
    }
}

// Namespace infection_util
// Params 2
// Checksum 0x76193c54, Offset: 0x4f68
// Size: 0x4e
function iswithinmaxdistance( s_lookat, n_max_distance )
{
    if ( isdefined( n_max_distance ) )
    {
        if ( distance2d( self.origin, s_lookat.origin ) < n_max_distance )
        {
            return 1;
        }
        else
        {
            return 0;
        }
        
        return;
    }
    
    return 1;
}

// Namespace infection_util
// Params 3
// Checksum 0x4a934064, Offset: 0x4fc0
// Size: 0xfd
function lookingatstructdurationonly( s_lookat, n_duration, n_max_distance )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    n_time = 0;
    
    if ( isdefined( s_lookat.radius ) )
    {
        n_max_distance = s_lookat.radius;
    }
    
    b_lookat_check = islookingatstruct( s_lookat );
    b_distance_check = iswithinmaxdistance( s_lookat, n_max_distance );
    
    while ( b_lookat_check && b_lookat_check && n_time < n_duration )
    {
        b_lookat_check = islookingatstruct( s_lookat );
        b_distance_check = iswithinmaxdistance( s_lookat, n_max_distance );
        wait 0.1;
        n_time += 0.1;
    }
    
    if ( b_lookat_check && b_distance_check && n_time >= n_duration )
    {
        return 1;
    }
    
    return 0;
}

// Namespace infection_util
// Params 0
// Checksum 0xbc01e3e6, Offset: 0x50c8
// Size: 0x92
function pull_out_last_weapon()
{
    if ( isdefined( self.lastactiveweapon ) && self.lastactiveweapon != level.weaponnone && self hasweapon( self.lastactiveweapon ) )
    {
        self switchtoweapon( self.lastactiveweapon );
        return;
    }
    
    primaryweapons = self getweaponslistprimaries();
    
    if ( isdefined( primaryweapons ) && primaryweapons.size > 0 )
    {
        self switchtoweapon( primaryweapons[ 0 ] );
    }
}

// Namespace infection_util
// Params 0
// Checksum 0x1b39e00f, Offset: 0x5168
// Size: 0x22
function player_enter_cinematic()
{
    self util::set_low_ready( 1 );
    self enableinvulnerability();
}

// Namespace infection_util
// Params 0
// Checksum 0xaca01040, Offset: 0x5198
// Size: 0x22
function player_leave_cinematic()
{
    self util::set_low_ready( 0 );
    self disableinvulnerability();
}

// Namespace infection_util
// Params 5
// Checksum 0x8cec759b, Offset: 0x51c8
// Size: 0x6d
function monitor_spawner_and_trigger_reinforcement( str_spawner_source, str_spawner_reinforce, str_volume, n_wait, n_count )
{
    while ( true )
    {
        if ( spawn_manager::is_enabled( str_spawner_source ) )
        {
            wait n_wait;
            spawn_by_min_ai_in_volume( str_spawner_reinforce, str_volume, n_count );
            break;
        }
        
        util::wait_network_frame();
    }
}

// Namespace infection_util
// Params 3
// Checksum 0xc07e4932, Offset: 0x5240
// Size: 0x10d
function spawn_by_min_ai_in_volume( str_spawner, str_volume, n_count )
{
    while ( true )
    {
        a_ai = getaiteamarray( "axis" );
        e_volume = getent( str_volume, "targetname" );
        a_ai_in_volume = [];
        
        if ( isdefined( e_volume ) )
        {
            if ( a_ai.size > 0 )
            {
                foreach ( ai in a_ai )
                {
                    if ( ai istouching( e_volume ) )
                    {
                        a_ai_in_volume[ a_ai_in_volume.size ] = ai;
                    }
                }
            }
        }
        
        if ( a_ai_in_volume.size <= n_count )
        {
            spawn_manager::enable( str_spawner );
            break;
        }
        
        util::wait_network_frame();
    }
}

// Namespace infection_util
// Params 1
// Checksum 0x66666da3, Offset: 0x5358
// Size: 0x46
function set_ai_goto_volume( e_volume )
{
    self endon( #"death" );
    self.goalradius = -128;
    self setgoal( e_volume );
    self waittill( #"goal" );
    self.goalradius = 1024;
}

// Namespace infection_util
// Params 2
// Checksum 0x991a0086, Offset: 0x53a8
// Size: 0xdb
function set_ai_goal_volume( str_ai_name, str_goal_volume_name )
{
    e_retreat_goal_volume = getent( str_goal_volume_name, "targetname" );
    a_enemies = getaiarray( str_ai_name, "targetname" );
    
    foreach ( e_enemy in a_enemies )
    {
        if ( isalive( e_enemy ) )
        {
            e_enemy thread set_ai_goto_volume( e_retreat_goal_volume );
        }
        
        util::wait_network_frame();
    }
}

// Namespace infection_util
// Params 2
// Checksum 0x2d753f6, Offset: 0x5490
// Size: 0x11b
function retreat_if_in_volume( str_current_volume, str_next_volume )
{
    a_enemies = getaiteamarray( "axis" );
    e_current_volume = getent( str_current_volume, "targetname" );
    e_next_volume = getent( str_next_volume, "targetname" );
    
    if ( isdefined( e_current_volume ) && isdefined( e_next_volume ) )
    {
        foreach ( e_enemy in a_enemies )
        {
            if ( isalive( e_enemy ) )
            {
                if ( e_enemy istouching( e_current_volume ) )
                {
                    e_enemy thread set_ai_goto_volume( e_next_volume );
                }
            }
            
            util::wait_network_frame();
        }
    }
}

/#

    // Namespace infection_util
    // Params 5
    // Checksum 0x1e01ca36, Offset: 0x55b8
    // Size: 0x7f, Type: dev
    function createclienthudtext( e_player, str_message, x_off, y_off, font_scale )
    {
        font_color = ( 1, 1, 1 );
        hud_elem = e_player create_client_hud_elem( "<dev string:x3b9>", "<dev string:x3c0>", "<dev string:x3b9>", "<dev string:x3c7>", x_off, y_off, font_scale, font_color, str_message );
        return hud_elem;
    }

    // Namespace infection_util
    // Params 9
    // Checksum 0xe14d0ef5, Offset: 0x5640
    // Size: 0x135, Type: dev
    function create_client_hud_elem( alignx, aligny, horzalign, vertalign, xoffset, yoffset, fontscale, color, str_text )
    {
        hud_elem = newclienthudelem( self );
        hud_elem.elemtype = "<dev string:x3cb>";
        hud_elem.font = "<dev string:x3d0>";
        hud_elem.alignx = alignx;
        hud_elem.aligny = aligny;
        hud_elem.horzalign = horzalign;
        hud_elem.vertalign = vertalign;
        hud_elem.x += xoffset;
        hud_elem.y += yoffset;
        hud_elem.foreground = 1;
        hud_elem.fontscale = fontscale;
        hud_elem.alpha = 1;
        hud_elem.color = color;
        hud_elem.hidewheninmenu = 1;
        hud_elem settext( str_text );
        return hud_elem;
    }

#/

// Namespace infection_util
// Params 1
// Checksum 0xce58d7dc, Offset: 0x5780
// Size: 0x20a, Type: bool
function player_can_see_me( dist )
{
    if ( !isdefined( dist ) )
    {
        dist = 512;
    }
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        if ( !isdefined( self ) )
        {
            return false;
        }
        
        if ( !isdefined( level.players[ i ] ) )
        {
            continue;
        }
        
        playerangles = level.players[ i ] getplayerangles();
        playerforwardvec = anglestoforward( playerangles );
        playerunitforwardvec = vectornormalize( playerforwardvec );
        banzaipos = self.origin;
        playerpos = level.players[ i ] getorigin();
        playertobanzaivec = banzaipos - playerpos;
        playertobanzaiunitvec = vectornormalize( playertobanzaivec );
        forwarddotbanzai = vectordot( playerunitforwardvec, playertobanzaiunitvec );
        
        if ( forwarddotbanzai >= 1 )
        {
            anglefromcenter = 0;
        }
        else if ( forwarddotbanzai <= -1 )
        {
            anglefromcenter = -76;
        }
        else
        {
            anglefromcenter = acos( forwarddotbanzai );
        }
        
        playerfov = getdvarfloat( "cg_fov" );
        banzaivsplayerfovbuffer = getdvarfloat( "g_banzai_player_fov_buffer" );
        
        if ( banzaivsplayerfovbuffer <= 0 )
        {
            banzaivsplayerfovbuffer = 0.2;
        }
        
        playercanseeme = anglefromcenter <= playerfov * 0.5 * ( 1 - banzaivsplayerfovbuffer );
        
        if ( isdefined( playercanseeme ) && playercanseeme || distance( level.players[ i ].origin, self.origin ) < dist )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace infection_util
// Params 1
// Checksum 0x8c1a2eb6, Offset: 0x5998
// Size: 0x63
function models_ghost( a_models )
{
    foreach ( model in a_models )
    {
        model ghost();
    }
}

// Namespace infection_util
// Params 1
// Checksum 0xe0c4b659, Offset: 0x5a08
// Size: 0x63
function models_show( a_models )
{
    foreach ( model in a_models )
    {
        model show();
    }
}

// Namespace infection_util
// Params 0
// Checksum 0x29bf809f, Offset: 0x5a78
// Size: 0x2a
function adjust_sunshadowsplitdistance()
{
    level.old_sunshadowsplitdistance = level.sun_shadow_split_distance;
    level util::set_sun_shadow_split_distance( 5000 );
}

// Namespace infection_util
// Params 0
// Checksum 0xc43c4c1c, Offset: 0x5ab0
// Size: 0x22
function reset_sunshadowsplitdistance()
{
    if ( isdefined( level.old_sunshadowsplitdistance ) )
    {
        level util::set_sun_shadow_split_distance( level.old_sunshadowsplitdistance );
    }
}

// Namespace infection_util
// Params 0
// Checksum 0x22e9099e, Offset: 0x5ae0
// Size: 0x121
function zmbaivox_notifyconvert()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self thread function_9fc02a8();
    self thread zmbaivox_playdeath();
    
    while ( true )
    {
        self waittill( #"bhtn_action_notify", notify_string );
        
        switch ( notify_string )
        {
            case "attack_melee":
            case "behind":
            case "close":
            case "death":
            case "electrocute":
                level thread zmbaivox_playvox( self, notify_string, 1 );
                break;
            case "ambient":
            case "crawler":
            case "sprint":
            case "taunt":
            case "teardown":
                level thread zmbaivox_playvox( self, notify_string, 0 );
                break;
            default:
                if ( isdefined( level._zmbaivox_specialtype ) )
                {
                    if ( isdefined( level._zmbaivox_specialtype[ notify_string ] ) )
                    {
                        level thread zmbaivox_playvox( self, notify_string, 0 );
                    }
                }
                
                break;
        }
    }
}

// Namespace infection_util
// Params 3
// Checksum 0xcb8fa2aa, Offset: 0x5c10
// Size: 0x122
function zmbaivox_playvox( zombie, type, override )
{
    zombie endon( #"death" );
    
    if ( !isdefined( zombie ) )
    {
        return;
    }
    
    if ( !isdefined( zombie.voiceprefix ) )
    {
        return;
    }
    
    alias = "zmb_vocals_" + zombie.voiceprefix + "_" + type;
    
    if ( sndisnetworksafe() )
    {
        if ( isdefined( override ) && override )
        {
            if ( type == "death" )
            {
                zombie playsound( alias );
            }
            else
            {
                zombie playsoundontag( alias, "j_head" );
            }
            
            return;
        }
        
        if ( !( isdefined( zombie.talking ) && zombie.talking ) )
        {
            zombie.talking = 1;
            zombie playsoundwithnotify( alias, "sounddone", "j_head" );
            zombie waittill( #"sounddone" );
            zombie.talking = 0;
        }
    }
}

// Namespace infection_util
// Params 0
// Checksum 0x988e37ca, Offset: 0x5d40
// Size: 0xe5
function function_9fc02a8()
{
    self endon( #"death" );
    wait randomfloatrange( 1, 3 );
    
    while ( true )
    {
        type = "ambient";
        
        if ( !isdefined( self.zombie_move_speed ) )
        {
            wait 0.5;
            continue;
        }
        
        switch ( self.zombie_move_speed )
        {
            default:
                type = "ambient";
                break;
            case "run":
                type = "sprint";
                break;
            case "sprint":
                type = "sprint";
                break;
        }
        
        if ( isdefined( self.missinglegs ) && self.missinglegs )
        {
            type = "crawler";
        }
        
        self notify( #"bhtn_action_notify", type );
        wait randomfloatrange( 1, 4 );
    }
}

// Namespace infection_util
// Params 0
// Checksum 0x7c8554a8, Offset: 0x5e30
// Size: 0x42
function zmbaivox_playdeath()
{
    self endon( #"disconnect" );
    self waittill( #"death", attacker, meansofdeath );
    
    if ( isdefined( self ) )
    {
        level thread zmbaivox_playvox( self, "death", 1 );
    }
}

// Namespace infection_util
// Params 0
// Checksum 0x792d6506, Offset: 0x5e80
// Size: 0x1d
function networksafereset()
{
    while ( true )
    {
        level._numzmbaivox = 0;
        util::wait_network_frame();
    }
}

// Namespace infection_util
// Params 0
// Checksum 0xd34de7e3, Offset: 0x5ea8
// Size: 0x34, Type: bool
function sndisnetworksafe()
{
    if ( !isdefined( level._numzmbaivox ) )
    {
        level thread networksafereset();
    }
    
    if ( level._numzmbaivox >= 2 )
    {
        return false;
    }
    
    level._numzmbaivox++;
    return true;
}

// Namespace infection_util
// Params 0
// Checksum 0x269fd66e, Offset: 0x5ee8
// Size: 0x1a5
function zombie_behind_vox()
{
    level endon( #"zombies_completed" );
    self endon( #"death_or_disconnect" );
    level waittill( #"start_zombie_sequence" );
    
    if ( !isdefined( level._zbv_vox_last_update_time ) )
    {
        level._zbv_vox_last_update_time = 0;
        level._audio_zbv_shared_ent_list = getaiteamarray( "axis" );
    }
    
    while ( true )
    {
        wait 1;
        t = gettime();
        
        if ( t > level._zbv_vox_last_update_time + 1000 )
        {
            level._zbv_vox_last_update_time = t;
            level._audio_zbv_shared_ent_list = getaiteamarray( "axis" );
        }
        
        zombs = level._audio_zbv_shared_ent_list;
        played_sound = 0;
        
        for ( i = 0; i < zombs.size ; i++ )
        {
            if ( !isdefined( zombs[ i ] ) )
            {
                continue;
            }
            
            if ( distancesquared( zombs[ i ].origin, self.origin ) < 62500 )
            {
                yaw = self getyawtospot( zombs[ i ].origin );
                z_diff = self.origin[ 2 ] - zombs[ i ].origin[ 2 ];
                
                if ( ( yaw < -95 || yaw > 95 ) && abs( z_diff ) < 50 )
                {
                    zombs[ i ] notify( #"bhtn_action_notify", "behind" );
                    played_sound = 1;
                    break;
                }
            }
        }
        
        if ( played_sound )
        {
            wait 5;
        }
    }
}

// Namespace infection_util
// Params 1
// Checksum 0xd3ff226d, Offset: 0x6098
// Size: 0x56
function getyawtospot( spot )
{
    pos = spot;
    yaw = self.angles[ 1 ] - getyaw( pos );
    yaw = angleclamp180( yaw );
    return yaw;
}

// Namespace infection_util
// Params 1
// Checksum 0x2f37abb5, Offset: 0x60f8
// Size: 0x31
function getyaw( org )
{
    angles = vectortoangles( org - self.origin );
    return angles[ 1 ];
}

// Namespace infection_util
// Params 1
// Checksum 0xb7835bd1, Offset: 0x6138
// Size: 0x8b
function player_distance( pos )
{
    closest_dist = 99999.9;
    a_players = getplayers();
    
    for ( i = 0; i < a_players.size ; i++ )
    {
        dist = distance( a_players[ i ].origin, pos );
        
        if ( dist < closest_dist )
        {
            closest_dist = dist;
        }
    }
    
    return closest_dist;
}

// Namespace infection_util
// Params 2
// Checksum 0x5eb25dde, Offset: 0x61d0
// Size: 0x42
function movie_transition( str_movie_name, var_e0017db3 )
{
    if ( !isdefined( var_e0017db3 ) )
    {
        var_e0017db3 = "fullscreen_additive";
    }
    
    level post_fx_transitions( "dni_futz", str_movie_name, var_e0017db3 );
}

// Namespace infection_util
// Params 5
// Checksum 0xad8d12a6, Offset: 0x6220
// Size: 0x17b
function post_fx_transitions( str_pstfx, str_movie_name, var_e0017db3, var_28856194, b_trans_out )
{
    if ( !isdefined( var_28856194 ) )
    {
        var_28856194 = 0;
    }
    
    if ( !isdefined( b_trans_out ) )
    {
        b_trans_out = 0;
    }
    
    a_postfx_field = [];
    a_postfx_field[ "dni_interrupt" ] = "postfx_dni_interrupt";
    a_postfx_field[ "dni_futz" ] = "postfx_futz";
    assert( isdefined( a_postfx_field[ str_pstfx ] ), "<dev string:x3da>" + str_pstfx );
    
    if ( var_28856194 )
    {
        foreach ( player in level.players )
        {
            player clientfield::increment_to_player( a_postfx_field[ str_pstfx ], 1 );
        }
        
        wait 1;
    }
    
    if ( isdefined( str_movie_name ) )
    {
        lui::play_movie( str_movie_name, var_e0017db3 );
        
        if ( b_trans_out )
        {
            foreach ( player in level.players )
            {
                player clientfield::increment_to_player( a_postfx_field[ str_pstfx ], 1 );
            }
        }
    }
}

// Namespace infection_util
// Params 2
// Checksum 0xa99654f6, Offset: 0x63a8
// Size: 0xb3
function ai_camo( n_camo_state, b_use_spawn_fx )
{
    if ( !isdefined( b_use_spawn_fx ) )
    {
        b_use_spawn_fx = 1;
    }
    
    self endon( #"death" );
    
    if ( isdefined( b_use_spawn_fx ) && b_use_spawn_fx )
    {
        self clientfield::set( "sarah_camo_shader", 2 );
        self clientfield::set( "ai_dni_rez_in", 1 );
        wait 1;
    }
    
    self clientfield::set( "sarah_camo_shader", n_camo_state );
    
    if ( n_camo_state == 1 )
    {
        self ai::set_ignoreme( 1 );
        return;
    }
    
    self ai::set_ignoreme( 0 );
    self notify( #"actor_camo_off" );
}

// Namespace infection_util
// Params 2
// Checksum 0x47a98bf4, Offset: 0x6468
// Size: 0x10a
function actor_camo( n_camo_state, b_use_spawn_fx )
{
    if ( !isdefined( b_use_spawn_fx ) )
    {
        b_use_spawn_fx = 1;
    }
    
    self endon( #"death" );
    
    if ( isdefined( b_use_spawn_fx ) && b_use_spawn_fx )
    {
        self clientfield::set( "sarah_camo_shader", 2 );
        
        if ( n_camo_state == 1 )
        {
            self clientfield::increment( "ai_dni_rez_out", 1 );
        }
        else
        {
            self util::delay( 0.5, undefined, &clientfield::set, "ai_dni_rez_in", 1 );
        }
        
        wait 1;
    }
    
    self clientfield::set( "sarah_camo_shader", n_camo_state );
    
    if ( n_camo_state == 1 )
    {
        self ai::set_ignoreme( 1 );
        self ghost();
        return;
    }
    
    self ai::set_ignoreme( 0 );
    self notify( #"actor_camo_off" );
    self show();
}

// Namespace infection_util
// Params 1
// Checksum 0xa0af58f0, Offset: 0x6580
// Size: 0x109
function wait_for_any_player_to_pass_struct( str_struct )
{
    s_struct = struct::get( str_struct, "targetname" );
    v_struct_dir = anglestoforward( s_struct.angles );
    player_close = 0;
    
    while ( !player_close )
    {
        a_players = getplayers();
        
        for ( i = 0; i < a_players.size ; i++ )
        {
            e_player = a_players[ i ];
            v_dir = vectornormalize( e_player.origin - s_struct.origin );
            dp = vectordot( v_dir, v_struct_dir );
            
            if ( dp > 0 )
            {
                player_close = 1;
                break;
            }
        }
        
        wait 0.05;
    }
}

// Namespace infection_util
// Params 1
// Checksum 0x20ba8427, Offset: 0x6698
// Size: 0x115
function wait_for_all_players_to_pass_struct( str_struct )
{
    s_struct = struct::get( str_struct, "targetname" );
    v_struct_dir = anglestoforward( s_struct.angles );
    
    while ( true )
    {
        num_players_past = 0;
        a_players = getplayers();
        
        for ( i = 0; i < a_players.size ; i++ )
        {
            e_player = a_players[ i ];
            v_dir = vectornormalize( e_player.origin - s_struct.origin );
            dp = vectordot( v_dir, v_struct_dir );
            
            if ( dp > 0 )
            {
                num_players_past++;
            }
        }
        
        if ( num_players_past == a_players.size )
        {
            break;
        }
        
        wait 0.05;
    }
}

// Namespace infection_util
// Params 2
// Checksum 0xad39f0af, Offset: 0x67b8
// Size: 0x1e
function cleanup_group_add( e_ent, str_cleanup_group_name )
{
    e_ent.cleanup_group = str_cleanup_group_name;
}

// Namespace infection_util
// Params 2
// Checksum 0x276b0f4e, Offset: 0x67e0
// Size: 0xa9
function cleanup_group_kill( str_cleanup_group_name, do_death )
{
    a_ai = getaiarray();
    
    if ( isdefined( a_ai ) )
    {
        for ( i = 0; i < a_ai.size ; i++ )
        {
            e_ent = a_ai[ i ];
            
            if ( isdefined( e_ent.cleanup_group ) && e_ent.cleanup_group == str_cleanup_group_name )
            {
                if ( do_death )
                {
                    e_ent kill();
                    continue;
                }
                
                e_ent delete();
            }
        }
    }
}

// Namespace infection_util
// Params 1
// Checksum 0x90a3eb47, Offset: 0x6898
// Size: 0x117
function ent_array_distance_from_players( a_ents )
{
    a_sorted_ents = [];
    a_players = getplayers();
    
    while ( a_ents.size > 0 )
    {
        e_closest = undefined;
        n_closest = 1e+06;
        
        for ( i = 0; i < a_ents.size ; i++ )
        {
            n_player_dist = 1e+06;
            
            for ( np = 0; np < a_players.size ; np++ )
            {
                dist = distance( a_players[ np ].origin, a_ents[ i ].origin );
                
                if ( dist < n_player_dist )
                {
                    n_player_dist = dist;
                }
            }
            
            if ( n_player_dist < n_closest )
            {
                n_closest = n_player_dist;
                e_closest = a_ents[ i ];
            }
        }
        
        a_sorted_ents[ a_sorted_ents.size ] = e_closest;
        arrayremovevalue( a_ents, e_closest );
    }
    
    return a_sorted_ents;
}

// Namespace infection_util
// Params 1
// Checksum 0xe50bd951, Offset: 0x69b8
// Size: 0x80
function infection_battle_chatter( vo_spoken )
{
    a_ai_array = getaiteamarray( "allies" );
    a_ai_array = array::exclude( a_ai_array, level.heroes );
    ai_speaker = arraygetclosest( level.players[ 0 ].origin, a_ai_array );
    
    if ( isdefined( ai_speaker ) )
    {
        ai_speaker notify( #"scriptedbc", vo_spoken );
    }
}

// Namespace infection_util
// Params 0
// Checksum 0xe87e6e5a, Offset: 0x6a40
// Size: 0x8b
function function_67137b13()
{
    var_8db36247 = getentarray( "fold_plane", "targetname" );
    
    foreach ( var_e1427d74 in var_8db36247 )
    {
        var_e1427d74 show();
    }
}

// Namespace infection_util
// Params 0
// Checksum 0xc21710c8, Offset: 0x6ad8
// Size: 0x8b
function function_4f66eed6()
{
    var_8db36247 = getentarray( "fold_plane", "targetname" );
    
    foreach ( var_e1427d74 in var_8db36247 )
    {
        var_e1427d74 ghost();
    }
}

// Namespace infection_util
// Params 2
// Checksum 0xf9fa743d, Offset: 0x6b70
// Size: 0xdb
function function_9f64d290( a_ents, b_enable )
{
    foreach ( ent in a_ents )
    {
        if ( b_enable )
        {
            if ( isactor( ent ) && isdefined( ent.var_68dd6b84 ) )
            {
                ent.propername = ent.var_68dd6b84;
            }
            
            continue;
        }
        
        if ( isactor( ent ) && isdefined( ent.propername ) )
        {
            ent.var_68dd6b84 = ent.propername;
            ent.propername = "";
        }
    }
}

// Namespace infection_util
// Params 2
// Checksum 0xce8b9a09, Offset: 0x6c58
// Size: 0x52
function function_7aca917c( var_920aba92, var_8182276a )
{
    if ( !isdefined( var_8182276a ) )
    {
        var_8182276a = 0;
    }
    
    level.var_1b3f87f7 = createstreamerhint( var_920aba92, 1, var_8182276a );
    level.var_1b3f87f7 setlightingonly( 1 );
}

// Namespace infection_util
// Params 3
// Checksum 0xa94d19c4, Offset: 0x6cb8
// Size: 0x151
function function_f6d49772( str_trig_name, str_dialog, str_notify_end )
{
    level endon( str_notify_end );
    
    while ( true )
    {
        trig = getent( str_trig_name, "targetname" );
        trig waittill( #"trigger", who );
        
        if ( !isdefined( who.var_a2496e3e ) )
        {
            who.var_a2496e3e = [];
            who.var_a2496e3e[ str_dialog ] = 1;
            
            while ( isdefined( who.var_5441261b ) && who.var_5441261b )
            {
                wait 0.5;
            }
            
            who.var_5441261b = 1;
            level dialog::say( str_dialog, 0, 1, who );
            who.var_5441261b = 0;
            continue;
        }
        
        if ( !isdefined( who.var_a2496e3e[ str_dialog ] ) )
        {
            who.var_a2496e3e[ str_dialog ] = 1;
            
            while ( isdefined( who.var_5441261b ) && who.var_5441261b )
            {
                wait 0.5;
            }
            
            who.var_5441261b = 1;
            level dialog::say( str_dialog, 0, 1, who );
            who.var_5441261b = 0;
        }
    }
}

