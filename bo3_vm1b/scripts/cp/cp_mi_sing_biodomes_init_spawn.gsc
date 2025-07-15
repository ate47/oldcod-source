#using scripts/codescripts/struct;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;

#namespace sm_initial_spawns;

// Namespace sm_initial_spawns
// Params 0, eflags: 0x2
// Checksum 0x8cf20879, Offset: 0x250
// Size: 0x3a
function autoexec __init__sytem__()
{
    system::register( "sm_initial_spawns", &__init__, &__main__, undefined );
}

// Namespace sm_initial_spawns
// Params 0
// Checksum 0xe9c07cd6, Offset: 0x298
// Size: 0x2
function __init__()
{
    
}

// Namespace sm_initial_spawns
// Params 0
// Checksum 0xfc3a4c71, Offset: 0x2a8
// Size: 0x12
function __main__()
{
    level thread sm_infil_zone_setup();
}

// Namespace sm_initial_spawns
// Params 1
// Checksum 0xdea29acb, Offset: 0x2c8
// Size: 0x62
function sm_axis_initial_spawn_func( spawn_struct )
{
    self endon( #"death" );
    wait 1;
    
    if ( !level flag::get( "sm_combat_started" ) )
    {
        wait randomfloatrange( 0.5, 1 );
        level flag::set( "sm_combat_started" );
    }
}

// Namespace sm_initial_spawns
// Params 0
// Checksum 0x503eee0e, Offset: 0x338
// Size: 0xc
function start_wave_spawning_on_combat()
{
    level waittill( #"sm_combat_started" );
}

// Namespace sm_initial_spawns
// Params 0
// Checksum 0x8d3803cf, Offset: 0x350
// Size: 0x8b
function sm_infil_zone_setup()
{
    wait 1;
    a_infil_zones = struct::get_array( "infil_manager", "targetname" );
    
    foreach ( zone in a_infil_zones )
    {
        zone infil_zone_selection();
    }
}

// Namespace sm_initial_spawns
// Params 0
// Checksum 0x13ae633c, Offset: 0x3e8
// Size: 0x5a
function infil_zone_selection()
{
    a_volume_list = getentarray( self.target, "targetname" );
    assert( a_volume_list.size != 0, "<dev string:x28>" );
    a_volume_list[ 0 ] thread spawn_infil_zones();
}

// Namespace sm_initial_spawns
// Params 1
// Checksum 0x87cfd9e3, Offset: 0x450
// Size: 0x125
function get_infil_activity( a_volume_list )
{
    for ( i = 0; i < a_volume_list.size ; i++ )
    {
        if ( isdefined( a_volume_list[ i ].script_noteworthy ) && isdefined( level.gametype ) )
        {
            if ( a_volume_list[ i ].script_noteworthy == level.gametype )
            {
                s_spawn_manager = a_volume_list[ i ];
                continue;
            }
            
            a_volume_list[ i ] infil_clean_up();
            array::remove_index( a_volume_list, i, 1 );
        }
    }
    
    if ( a_volume_list.size == 0 )
    {
        return;
    }
    
    if ( !isdefined( s_spawn_manager ) )
    {
        s_spawn_manager = array::random( a_volume_list );
    }
    
    foreach ( volume in a_volume_list )
    {
        if ( volume != s_spawn_manager )
        {
            volume infil_clean_up();
        }
    }
    
    return s_spawn_manager;
}

// Namespace sm_initial_spawns
// Params 0
// Checksum 0x61bb5c90, Offset: 0x580
// Size: 0x13b
function spawn_infil_zones()
{
    while ( true )
    {
        self waittill( #"trigger", ent );
        
        if ( isdefined( ent.sessionstate ) && ent.sessionstate != "spectator" )
        {
            break;
        }
        
        wait 0.05;
    }
    
    target = self.target;
    a_entities = getentarray( target, "targetname" );
    assert( a_entities.size != 0, "<dev string:x60>" );
    s_handler = self;
    wait 1;
    
    foreach ( entity in a_entities )
    {
        if ( isspawner( entity ) && !isdefined( level._infil_actor_off ) && isdefined( s_handler ) )
        {
            entity handle_role_assignment( s_handler );
        }
    }
    
    self notify( #"infil_spawn_complete" );
}

// Namespace sm_initial_spawns
// Params 1
// Checksum 0x43502dab, Offset: 0x6c8
// Size: 0x1d2
function handle_role_assignment( handler_struct )
{
    defend_volume = getent( "street_battle_volume", "targetname" );
    
    if ( isdefined( level.free_targeting ) || isdefined( level.target_volume ) )
    {
        if ( isdefined( self.script_noteworthy ) && self.script_noteworthy != "wasp_swarm" && self.script_noteworthy != "hunter_swarm" )
        {
            self.target = undefined;
        }
    }
    
    if ( !isdefined( self.script_noteworthy ) )
    {
        camp_guard = spawner::simple_spawn_single( self );
        
        if ( isdefined( level.target_volume ) && isactor( camp_guard ) )
        {
            camp_guard setgoal( defend_volume );
        }
        
        return;
    }
    
    if ( self.script_noteworthy == "wasp_swarm" )
    {
        self thread wasp_swarm_logic();
        return;
    }
    
    if ( self.script_noteworthy == "hunter_swarm" )
    {
        self thread hunter_swarm_logic();
        return;
    }
    
    camp_guard = spawner::simple_spawn_single( self );
    
    if ( self.script_noteworthy == "patrol" )
    {
        camp_guard thread infil_patrol_logic( self.target );
        return;
    }
    
    if ( self.script_noteworthy == "defend" )
    {
        if ( isdefined( camp_guard.target ) )
        {
        }
        
        return;
    }
    
    if ( self.script_noteworthy == "guard" )
    {
        if ( isdefined( camp_guard.target ) )
        {
        }
        
        return;
    }
    
    if ( self.script_noteworthy == "scene" )
    {
        camp_guard thread script_scene_setup( self, handler_struct );
    }
}

// Namespace sm_initial_spawns
// Params 0
// Checksum 0x2ef7f2a4, Offset: 0x8a8
// Size: 0x91
function wasp_swarm_logic()
{
    path_start = getvehiclenode( self.target, "targetname" );
    offset = ( 0, 60, 0 );
    
    for ( i = 0; i < self.script_int ; i++ )
    {
        wasp = spawner::simple_spawn_single( self );
        wasp thread handle_spline( path_start, i );
    }
}

// Namespace sm_initial_spawns
// Params 0
// Checksum 0xe8ac00d7, Offset: 0x948
// Size: 0xc6
function hunter_swarm_logic()
{
    path_start = getvehiclenode( self.target, "targetname" );
    hunter = spawner::simple_spawn_single( self );
    hunter vehicle_ai::start_scripted();
    hunter vehicle::get_on_path( path_start );
    hunter.drivepath = 1;
    hunter vehicle::go_path();
    hunter setgoal( level.players[ 0 ], 0, 1000 );
    hunter vehicle_ai::stop_scripted();
    hunter.lockontarget = level.players[ 0 ];
}

// Namespace sm_initial_spawns
// Params 2
// Checksum 0x36642361, Offset: 0xa18
// Size: 0xd2
function handle_spline( path_start, index )
{
    offset = ( 0, 30, 0 );
    self vehicle_ai::start_scripted();
    self vehicle::get_on_path( path_start );
    self.drivepath = 1;
    offset_scale = get_offset_scale( index );
    self pathfixedoffset( offset * offset_scale );
    self vehicle::go_path();
    self setgoal( level.players[ 0 ], 0, 600, -106 );
    self vehicle_ai::stop_scripted();
    self.lockontarget = level.players[ 0 ];
}

// Namespace sm_initial_spawns
// Params 1
// Checksum 0x2fb69a2f, Offset: 0xaf8
// Size: 0x33
function get_offset_scale( i )
{
    if ( i % 2 == 0 )
    {
        return ( i / 2 * -1 );
    }
    
    return i - i / 2 + 0.5;
}

// Namespace sm_initial_spawns
// Params 1
// Checksum 0x6f472489, Offset: 0xb38
// Size: 0x6d
function infil_patrol_logic( str_start_node )
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"patrol_wp_reached", node );
        
        if ( isdefined( node.script_wait_min ) && ( isdefined( node.script_wait ) || isdefined( node.script_wait_max ) ) )
        {
            node util::script_wait();
        }
    }
}

// Namespace sm_initial_spawns
// Params 2
// Checksum 0xbd87d939, Offset: 0xbb0
// Size: 0x102
function script_scene_setup( align_node, handler_struct )
{
    if ( isdefined( self.target ) )
    {
        node = getnode( self.target, "targetname" );
        
        if ( isdefined( node ) )
        {
        }
        else
        {
            defend_volume = getent( self.target, "targetname" );
            
            if ( isdefined( defend_volume ) )
            {
            }
        }
    }
    else
    {
        if ( isdefined( handler_struct.height ) )
        {
            self.goalheight = handler_struct.height;
        }
        
        if ( isdefined( handler_struct.radius ) )
        {
            self.goalradius = handler_struct.radius;
        }
    }
    
    wait 0.05;
    assert( isdefined( self.script_string ), "<dev string:x97>" );
    align_node thread scene::init( self.script_string, self );
}

// Namespace sm_initial_spawns
// Params 0
// Checksum 0xc95bd9c2, Offset: 0xcc0
// Size: 0x16a
function infil_clean_up()
{
    a_entities = getentarray( self.target, "targetname" );
    
    foreach ( entity in a_entities )
    {
        if ( isspawner( entity ) )
        {
            entity delete();
            continue;
        }
        
        if ( isdefined( entity.target ) )
        {
            nd_cover_nodes = getnodearray( entity.target, "targetname" );
            
            foreach ( node in nd_cover_nodes )
            {
                setenablenode( node, 0 );
            }
        }
        
        entity connectpaths();
        entity delete();
    }
    
    self delete();
}

// Namespace sm_initial_spawns
// Params 0
// Checksum 0x700fa315, Offset: 0xe38
// Size: 0x16
function kill_infil_actor_spawn()
{
    if ( !isdefined( level._infil_actor_off ) )
    {
        level._infil_actor_off = 1;
    }
}

