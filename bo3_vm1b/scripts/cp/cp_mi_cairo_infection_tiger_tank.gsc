#using scripts/codescripts/struct;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_death_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicleriders_shared;

#namespace tiger_tank;

// Namespace tiger_tank
// Method(s) 0 Total 0
class class_57d92933
{

}

// Namespace tiger_tank
// Params 0, eflags: 0x2
// Checksum 0x33d1e3af, Offset: 0x560
// Size: 0x2a
function autoexec __init__sytem__()
{
    system::register( "tiger_tank", &__init__, undefined, undefined );
}

// Namespace tiger_tank
// Params 0
// Checksum 0x853daf10, Offset: 0x598
// Size: 0x6a
function __init__()
{
    level._effect[ "fx_exp_quadtank_death_03" ] = "explosions/fx_exp_quadtank_death_03";
    clientfield::register( "vehicle", "tiger_tank_retreat_fx", 1, 1, "int" );
    clientfield::register( "vehicle", "tiger_tank_disable_sfx", 1, 1, "int" );
}

#namespace ctigertank;

// Namespace ctigertank
// Params 0
// Checksum 0x60c02475, Offset: 0x610
// Size: 0x142
function __constructor()
{
    self.m_str_state = "none";
    self.m_str_state_last = "";
    self.m_n_time_turret_last_fired = 0;
    self.m_n_times_retreated = 0;
    self.m_b_retreat_override = 0;
    self.m_n_last_random_goal_index = -1;
    self.m_e_target = undefined;
    self.m_vehicle_dead = 0;
    register_state_func( "attack", "attack_moving", 100, &state_attack_moving, &state_attack_moving_validate );
    register_state_func( "retreat", "retreat", 100, &state_retreat, &always_true );
    register_state_func( "idle", "idle", 100, &state_idle, &always_true );
    self flag::init( "firing" );
    self flag::init( "moving" );
}

// Namespace ctigertank
// Params 0
// Checksum 0xe9c07cd6, Offset: 0x760
// Size: 0x2
function __destructor()
{
    
}

// Namespace ctigertank
// Params 2
// Checksum 0x6ed6f03b, Offset: 0x770
// Size: 0x72
function tiger_tank_setup( vehicle, str_gunner_name )
{
    if ( isdefined( str_gunner_name ) )
    {
        sp_gunner = getent( str_gunner_name, "targetname" );
        ai_gunner = spawner::simple_spawn_single( sp_gunner );
        set_ai_gunner( ai_gunner );
    }
    
    set_ai_vehicle( vehicle );
}

// Namespace ctigertank
// Params 0
// Checksum 0xf715a5ed, Offset: 0x7f0
// Size: 0x23
function retreat_override()
{
    if ( self.m_n_times_retreated < 2 )
    {
        self.m_b_retreat_override = 1;
        self notify( #"state_changed" );
    }
}

// Namespace ctigertank
// Params 1
// Checksum 0xccd6da7f, Offset: 0x820
// Size: 0x32
function disable_sfx( n_state )
{
    if ( isdefined( self.m_vehicle ) )
    {
        self.m_vehicle clientfield::set( "tiger_tank_disable_sfx", n_state );
    }
}

// Namespace ctigertank
// Params 0
// Checksum 0x605ac155, Offset: 0x860
// Size: 0x6a
function start_think()
{
    self endon( #"stop_think" );
    
    if ( !self.m_vehicle_dead )
    {
        if ( isdefined( self.m_vehicle ) )
        {
            self thread track_target();
            wait 0.1;
            self thread state_think();
            wait 3;
            self thread fire_turret();
            self thread fire_gunner();
        }
    }
}

// Namespace ctigertank
// Params 0
// Checksum 0x5609360, Offset: 0x8d8
// Size: 0x13
function stop_think()
{
    self notify( #"stop_think" );
    self notify( #"state_changed" );
}

// Namespace ctigertank
// Params 0
// Checksum 0x41f57497, Offset: 0x8f8
// Size: 0x2a
function delete_gunner()
{
    if ( isdefined( self.m_ai_gunner ) )
    {
        self.m_ai_gunner delete();
        self.m_ai_gunner = undefined;
    }
}

// Namespace ctigertank
// Params 0
// Checksum 0x54209ae5, Offset: 0x930
// Size: 0x62
function delete_ai()
{
    stop_think();
    
    if ( isdefined( self.m_vehicle ) )
    {
        self.m_vehicle delete();
        self.m_vehicle = undefined;
    }
    
    if ( isdefined( self.m_ai_gunner ) )
    {
        self.m_ai_gunner delete();
        self.m_ai_gunner = undefined;
    }
}

// Namespace ctigertank
// Params 1
// Checksum 0xf6f3f240, Offset: 0x9a0
// Size: 0x1ba
function set_ai_vehicle( vehicle )
{
    self.m_vehicle = vehicle;
    self.m_vehicle.health = self.m_vehicle.healthdefault;
    self.m_vehicle setneargoalnotifydist( 120 );
    self.m_vehicle cybercom::cybercom_aioptout( "cybercom_immolation" );
    target_set( self.m_vehicle, ( 0, 0, 60 ) );
    self.m_vehicle turret::set_burst_parameters( 0.75, 1.5, 0.25, 0.75, 1 );
    self.m_vehicle setontargetangle( 1, 0 );
    self.m_vehicle set_field_of_view();
    
    if ( issentient( self.m_vehicle ) )
    {
        self thread vehicle_death();
    }
    
    if ( isdefined( self.m_ai_gunner ) )
    {
        setup_ai_gunner();
    }
    
    self thread damage_watcher();
    self thread show_state_info();
    self.m_e_lookat = getent( "street_lookat", "targetname" );
    self.m_vehicle setlookatent( self.m_e_lookat );
}

// Namespace ctigertank
// Params 1
// Checksum 0x75ac209f, Offset: 0xb68
// Size: 0x12
function set_ai_gunner( ai_gunner )
{
    self.m_ai_gunner = ai_gunner;
}

// Namespace ctigertank
// Params 0
// Checksum 0xf6eae2a, Offset: 0xb88
// Size: 0x42
function setup_ai_gunner()
{
    if ( isdefined( self.m_ai_gunner ) )
    {
        self.m_ai_gunner thread vehicle::get_in( self.m_vehicle, "gunner1", 1 );
        self thread disable_mg_turret_on_gunner_death();
    }
}

// Namespace ctigertank
// Params 0
// Checksum 0x7fc6ddad, Offset: 0xbd8
// Size: 0x13d
function fire_turret()
{
    self endon( #"death" );
    self endon( #"stop_think" );
    self.m_vehicle endon( #"death" );
    
    while ( true )
    {
        if ( isdefined( self.m_e_target ) )
        {
            v_target_offset = ( 0, 0, 53 );
            v_target_origin = self.m_e_target.origin + v_target_offset;
            self.m_n_distance_to_enemy = distance( self.m_vehicle.origin, self.m_e_target.origin );
            self.m_vehicle util::waittill_any_timeout( 2, "turret_on_target" );
            
            if ( can_hit_target( v_target_origin ) && self.m_n_distance_to_enemy > 620 )
            {
                self.m_vehicle fireweapon( 0, self.m_e_target, v_target_offset );
            }
            else
            {
                self.m_vehicle clearturrettarget();
            }
        }
        else
        {
            self.m_vehicle clearturrettarget();
        }
        
        wait randomfloatrange( 4, 8 );
    }
}

// Namespace ctigertank
// Params 0
// Checksum 0xadf17ab8, Offset: 0xd20
// Size: 0xc9
function fire_gunner()
{
    self endon( #"death" );
    self endon( #"stop_think" );
    self.m_vehicle endon( #"death" );
    
    while ( true )
    {
        if ( isdefined( self.m_e_target ) )
        {
            if ( isdefined( self.m_ai_gunner ) && isalive( self.m_ai_gunner ) )
            {
                self.m_vehicle thread turret::shoot_at_target( get_gunner_target(), -1, ( 0, 0, 0 ), 1, 0 );
            }
            
            wait randomfloatrange( 2, 3 );
            self.m_vehicle turret::disable( 1 );
            wait randomfloatrange( 4, 6 );
            continue;
        }
        
        wait 0.1;
    }
}

// Namespace ctigertank
// Params 0
// Checksum 0x566af5d8, Offset: 0xdf8
// Size: 0xad
function track_target()
{
    self endon( #"death" );
    self endon( #"stop_think" );
    self.m_vehicle endon( #"death" );
    
    while ( true )
    {
        self.m_e_target = get_closest_target();
        
        if ( isdefined( self.m_e_target ) )
        {
            self.m_vehicle settargetentity( self.m_e_target );
        }
        else
        {
            self.m_vehicle clearturrettarget();
            self.m_vehicle cleartargetentity();
        }
        
        wait randomfloatrange( 4, 5 );
    }
}

// Namespace ctigertank
// Params 0
// Checksum 0x22201ba5, Offset: 0xeb0
// Size: 0xed
function state_think()
{
    self endon( #"death" );
    self endon( #"stop_think" );
    self.m_vehicle endon( #"death" );
    
    while ( true )
    {
        b_has_target = has_valid_target();
        
        if ( b_has_target )
        {
            b_should_retreat = should_retreat();
            
            if ( b_should_retreat )
            {
                str_type = "retreat";
            }
            else if ( self.m_b_retreat_override )
            {
                self.m_b_retreat_override = 0;
                str_type = "retreat";
            }
            else
            {
                str_type = "attack";
            }
        }
        else
        {
            str_type = "idle";
        }
        
        str_next_state = select_behavior_from_type( str_type );
        update_state( str_type, str_next_state );
        wait 0.1;
    }
}

// Namespace ctigertank
// Params 0
// Checksum 0xa23d27aa, Offset: 0xfa8
// Size: 0x6f
function damage_watcher()
{
    self endon( #"death" );
    self endon( #"stop_think" );
    self.m_vehicle endon( #"death" );
    
    while ( true )
    {
        self.m_vehicle waittill( #"damage" );
        self.m_n_time_last_damaged = gettime();
        
        if ( should_retreat() )
        {
            debug_print( "cTigerTank: damage interrupt!" );
            self notify( #"state_interrupt" );
        }
    }
}

// Namespace ctigertank
// Params 2
// Checksum 0x6f5ad422, Offset: 0x1020
// Size: 0x98
function update_state( str_type, str_next_state )
{
    self endon( #"state_interrupt" );
    
    if ( self.m_str_state != str_next_state )
    {
        self notify( #"state_changed" );
        assert( isdefined( self.m_a_states[ str_type ][ str_next_state ] ), "<dev string:x28>" + str_type + "<dev string:x45>" + str_next_state + "<dev string:x54>" );
        self.m_str_state_last = self.m_str_state;
        self.m_str_state = str_next_state;
    }
    
    [[ self.m_a_states[ str_type ][ str_next_state ].func_state ]]();
}

// Namespace ctigertank
// Params 0
// Checksum 0x6074e42f, Offset: 0x10c0
// Size: 0x69
function state_idle()
{
    self endon( #"state_changed" );
    debug_print( "cTigerTank: idle" );
    self.m_vehicle turret::disable( 0 );
    stop_gunner_firing();
    
    while ( !has_valid_target() )
    {
        wait 0.5;
    }
}

// Namespace ctigertank
// Params 0
// Checksum 0xf43709ca, Offset: 0x1138
// Size: 0x4, Type: bool
function state_attack_moving_validate()
{
    return true;
}

// Namespace ctigertank
// Params 0
// Checksum 0xa8e087f2, Offset: 0x1148
// Size: 0x1d6
function state_attack_moving()
{
    self endon( #"state_changed" );
    debug_print( "cTigerTank: attack moving" );
    
    if ( isdefined( self.m_e_target ) )
    {
        v_to_target = vectornormalize( self.m_e_target.origin - self.m_vehicle.origin ) * 900;
        s_goal = find_best_goal_position_around_target( self.m_vehicle.origin + v_to_target );
        
        if ( isdefined( s_goal ) )
        {
            n_distance_to_new_goal = distance( self.m_vehicle.origin, s_goal.origin );
            v_dir = anglestoforward( s_goal.angles ) * -56;
            self.m_e_lookat.origin = s_goal.origin + v_dir;
            send_vehicle_to_position( s_goal.origin, 1, 1 );
        }
        
        n_action_wait = randomfloatrange( 2.5, 3 );
        wait n_action_wait;
        nd_random_goal = get_random_goal();
        n_distance_to_new_goal = distance( self.m_vehicle.origin, nd_random_goal.origin );
        send_vehicle_to_position( nd_random_goal.origin, 1, 1 );
        n_action_wait = randomfloatrange( 3.5, 4 );
        wait n_action_wait;
        return;
    }
    
    wait 3;
}

// Namespace ctigertank
// Params 0
// Checksum 0x3869f689, Offset: 0x1328
// Size: 0x122
function state_retreat()
{
    self endon( #"state_changed" );
    debug_print( "cTigerTank: retreat" );
    self.m_n_last_random_goal_index = -1;
    nd_goal = get_retreat_goal();
    
    if ( isdefined( nd_goal ) )
    {
        debug_print( "cTigerTank: retreating!" );
        show_point_with_text( nd_goal.origin, "RETREAT", ( 0, 0, 1 ), -56 );
        self.m_vehicle clientfield::set( "tiger_tank_retreat_fx", 1 );
        self.m_n_time_since_last_retreat = gettime();
        send_vehicle_to_position( nd_goal.origin, 1, 0, 0 );
        stop_movement();
        self wait_till_moving_complete();
        self.m_vehicle clientfield::set( "tiger_tank_retreat_fx", 0 );
        return;
    }
    
    debug_print( "cTigerTank: retreat failed!" );
}

// Namespace ctigertank
// Params 0
// Checksum 0xc006c8e1, Offset: 0x1458
// Size: 0x36
function has_valid_target()
{
    a_targets = self.m_vehicle turret::_get_potential_targets( 0 );
    b_has_target = a_targets.size > 0;
    return b_has_target;
}

// Namespace ctigertank
// Params 0
// Checksum 0x980e9c29, Offset: 0x1498
// Size: 0xed
function get_closest_target()
{
    a_targets = self.m_vehicle turret::_get_potential_targets( 0 );
    e_closest = undefined;
    
    if ( a_targets.size > 0 )
    {
        a_targets_closest = arraysort( a_targets, self.m_vehicle.origin, 1 );
        
        foreach ( e_target in a_targets_closest )
        {
            if ( distance2d( e_target.origin, self.m_vehicle.origin ) > self.m_vehicle.radius )
            {
                e_closest = e_target;
            }
        }
    }
    
    return e_closest;
}

// Namespace ctigertank
// Params 0
// Checksum 0x7cdd6e0c, Offset: 0x1590
// Size: 0x26
function get_targets()
{
    a_targets = self.m_vehicle turret::_get_potential_targets( 0 );
    return a_targets;
}

// Namespace ctigertank
// Params 1
// Checksum 0xb3d23ba3, Offset: 0x15c0
// Size: 0x9e
function select_behavior_from_type( str_type )
{
    assert( isdefined( self.m_a_states[ str_type ] ), "<dev string:x64>" + str_type + "<dev string:xa6>" );
    a_valid_behaviors = get_valid_behaviors( str_type );
    
    if ( a_valid_behaviors.size > 1 && isinarray( a_valid_behaviors, self.m_str_state ) )
    {
        arrayremovevalue( a_valid_behaviors, self.m_str_state, 0 );
    }
    
    str_behavior = select_behavior_from_chance( str_type, a_valid_behaviors );
    return str_behavior;
}

// Namespace ctigertank
// Params 1
// Checksum 0xe45057f, Offset: 0x1668
// Size: 0xdc
function get_valid_behaviors( str_type )
{
    a_behaviors = getarraykeys( self.m_a_states[ str_type ] );
    a_valid_behaviors = [];
    
    for ( i = 0; i < a_behaviors.size ; i++ )
    {
        if ( [[ self.m_a_states[ str_type ][ a_behaviors[ i ] ].func_validate ]]() )
        {
            if ( !isdefined( a_valid_behaviors ) )
            {
                a_valid_behaviors = [];
            }
            else if ( !isarray( a_valid_behaviors ) )
            {
                a_valid_behaviors = array( a_valid_behaviors );
            }
            
            a_valid_behaviors[ a_valid_behaviors.size ] = a_behaviors[ i ];
        }
    }
    
    assert( a_valid_behaviors.size, "<dev string:xa9>" + str_type + "<dev string:xa6>" );
    return a_valid_behaviors;
}

// Namespace ctigertank
// Params 2
// Checksum 0xe4bb193b, Offset: 0x1750
// Size: 0xf4
function select_behavior_from_chance( str_type, a_behaviors )
{
    n_chance_max = 0;
    
    for ( i = 0; i < a_behaviors.size ; i++ )
    {
        n_chance_max += self.m_a_states[ str_type ][ a_behaviors[ i ] ].n_chance;
        self.m_a_states[ str_type ][ a_behaviors[ i ] ].n_chance_temp = n_chance_max;
    }
    
    n_roll = randomintrange( 0, n_chance_max );
    
    for ( j = 0; j < a_behaviors.size ; j++ )
    {
        if ( n_roll < self.m_a_states[ str_type ][ a_behaviors[ j ] ].n_chance_temp )
        {
            str_behavior = a_behaviors[ j ];
            break;
        }
    }
    
    assert( isdefined( str_behavior ), "<dev string:xf4>" );
    return str_behavior;
}

// Namespace ctigertank
// Params 5
// Checksum 0xf065ea90, Offset: 0x1850
// Size: 0x18e
function register_state_func( str_type, str_state, n_chance, func_state, func_validate )
{
    assert( isdefined( str_type ), "<dev string:x135>" );
    assert( isdefined( str_state ), "<dev string:x16c>" );
    assert( isdefined( n_chance ), "<dev string:x1a4>" );
    assert( isdefined( func_state ), "<dev string:x1db>" );
    assert( isdefined( func_validate ), "<dev string:x214>" );
    
    if ( !isdefined( self.m_a_states ) )
    {
        self.m_a_states = [];
    }
    
    if ( !isdefined( self.m_a_states[ str_type ] ) )
    {
        self.m_a_states[ str_type ] = [];
    }
    
    assert( !isdefined( self.m_a_states[ str_type ][ str_state ] ), "<dev string:x250>" + str_type + "<dev string:x2a4>" + str_state + "<dev string:xa6>" );
    self.m_a_states[ str_type ][ str_state ] = spawnstruct();
    self.m_a_states[ str_type ][ str_state ].n_chance = n_chance;
    self.m_a_states[ str_type ][ str_state ].func_state = func_state;
    self.m_a_states[ str_type ][ str_state ].func_validate = func_validate;
}

// Namespace ctigertank
// Params 0
// Checksum 0x81c54bfd, Offset: 0x19e8
// Size: 0x32
function wait_till_moving_complete()
{
    self endon( #"death" );
    self.m_vehicle endon( #"death" );
    self flag::wait_till_clear( "moving" );
}

// Namespace ctigertank
// Params 0
// Checksum 0x77f4b645, Offset: 0x1a28
// Size: 0x5a
function stop_movement()
{
    self.m_vehicle setvehgoalpos( self.m_vehicle.origin, 1, 0 );
    self.m_vehicle cancelaimove();
    self flag::clear( "moving" );
}

// Namespace ctigertank
// Params 5
// Checksum 0xffda67c7, Offset: 0x1a90
// Size: 0x1ca
function send_vehicle_to_position( v_target, b_stop_at_goal, b_slow_down, b_notify_within_engagement_distance, n_timeout )
{
    if ( !isdefined( b_slow_down ) )
    {
        b_slow_down = 0;
    }
    
    if ( !isdefined( b_notify_within_engagement_distance ) )
    {
        b_notify_within_engagement_distance = 0;
    }
    
    if ( !isdefined( n_timeout ) )
    {
        n_timeout = 20;
    }
    
    self flag::set( "moving" );
    b_can_path = self.m_vehicle setvehgoalpos( v_target, b_stop_at_goal, 1 );
    
    if ( b_can_path )
    {
        if ( b_slow_down )
        {
            self.m_vehicle setspeed( 10 );
        }
        
        if ( b_notify_within_engagement_distance )
        {
            self thread _notify_within_engagement_distance();
        }
        
        self thread goal_position_show( v_target );
        str_result = self.m_vehicle util::waittill_any_timeout( n_timeout, "near_goal", "goal", "within_engagement_distance" );
        self.m_vehicle clearvehgoalpos();
        self.m_vehicle cancelaimove();
        goal_position_hide();
        
        if ( str_result === "timeout" )
        {
            debug_print( "cTigerTank: send_vehicle_to_position timed out" );
        }
        
        if ( b_slow_down )
        {
            n_speed_max = self.m_vehicle getmaxspeed() / 17.6;
            self.m_vehicle setspeed( n_speed_max );
        }
        
        self flag::clear( "moving" );
    }
}

// Namespace ctigertank
// Params 3
// Checksum 0x855a38a5, Offset: 0x1c68
// Size: 0xc6
function find_best_goal_position_around_target( v_target, n_search_radius_max, n_search_radius_min )
{
    a_position_name = array( "street", "street_0", "street_1", "street_2" );
    str_next_position = a_position_name[ self.m_n_times_retreated ];
    self.m_a_nodes = getvehiclenodearray( str_next_position, "script_noteworthy" );
    assert( self.m_a_nodes.size, "<dev string:x2af>" );
    s_best = arraygetclosest( v_target, self.m_a_nodes );
    return s_best;
}

// Namespace ctigertank
// Params 0
// Checksum 0x74c107b0, Offset: 0x1d38
// Size: 0x182
function vehicle_death()
{
    str_deathmodel = self.m_vehicle.deathmodel;
    self.m_vehicle waittill( #"death" );
    self.m_vehicle_dead = 1;
    stop_think();
    
    if ( isdefined( self.m_vehicle ) )
    {
        self.m_vehicle playsound( "exp_tiger_death" );
        m_death = util::spawn_model( str_deathmodel, self.m_vehicle.origin, self.m_vehicle.angles );
        badplace_box( "", 0, self.m_vehicle.origin, self.m_vehicle.radius, "neutral" );
        playfxontag( level._effect[ "fx_exp_quadtank_death_03" ], m_death, "tag_origin" );
        self.m_vehicle ai::set_ignoreme( 1 );
        self.m_vehicle ai::set_ignoreall( 1 );
        self.m_vehicle hide();
        delete_gunner();
        wait 2;
        self.m_vehicle delete();
        self.m_vehicle = undefined;
    }
}

// Namespace ctigertank
// Params 0
// Checksum 0xf2f08427, Offset: 0x1ec8
// Size: 0x3a
function disable_mg_turret_on_gunner_death()
{
    self endon( #"death" );
    self.m_vehicle endon( #"death" );
    self.m_ai_gunner waittill( #"death" );
    stop_gunner_firing();
}

// Namespace ctigertank
// Params 0
// Checksum 0xb54f9a92, Offset: 0x1f10
// Size: 0xaa
function _notify_within_engagement_distance()
{
    self endon( #"death" );
    self endon( #"state_changed" );
    self.m_vehicle endon( #"death" );
    self.m_vehicle endon( #"goal" );
    self.m_vehicle endon( #"near_goal" );
    
    while ( distance( self.m_vehicle.origin, self.m_e_target.origin ) > 900 )
    {
        wait 0.25;
    }
    
    debug_print( "cTigerTank: notify - within_engagement_distance" );
    self.m_vehicle notify( #"within_engagement_distance" );
}

// Namespace ctigertank
// Params 0
// Checksum 0xf43709ca, Offset: 0x1fc8
// Size: 0x4, Type: bool
function always_true()
{
    return true;
}

// Namespace ctigertank
// Params 0
// Checksum 0x1a98afb5, Offset: 0x1fd8
// Size: 0x3, Type: bool
function always_false()
{
    return false;
}

// Namespace ctigertank
// Params 0
// Checksum 0xcbb8535, Offset: 0x1fe8
// Size: 0xb1
function get_retreat_goal()
{
    a_locations = array( "street_0_retreat", "street_1_retreat", "street_2_retreat" );
    str_next_position = a_locations[ self.m_n_times_retreated ];
    self.m_a_nodes = getvehiclenodearray( str_next_position, "script_noteworthy" );
    nd_goal = arraygetfarthest( self.m_vehicle.origin, self.m_a_nodes );
    self.m_n_times_retreated++;
    
    if ( self.m_n_times_retreated == 1 )
    {
        level notify( #"tiger_tank_first_retreat" );
    }
    
    return nd_goal;
}

// Namespace ctigertank
// Params 0
// Checksum 0xd44bb4cf, Offset: 0x20a8
// Size: 0xd7
function get_random_goal()
{
    a_locations = array( "street", "street_0", "street_1", "street_2" );
    str_next_position = a_locations[ self.m_n_times_retreated ];
    self.m_a_nodes = getvehiclenodearray( str_next_position, "script_noteworthy" );
    
    for ( n_random_goal_index = randomint( self.m_a_nodes.size ); n_random_goal_index == self.m_n_last_random_goal_index ; n_random_goal_index = randomint( self.m_a_nodes.size ) )
    {
    }
    
    self.m_n_last_random_goal_index = n_random_goal_index;
    nd_goal = self.m_a_nodes[ n_random_goal_index ];
    return nd_goal;
}

// Namespace ctigertank
// Params 0
// Checksum 0x8b5e7f0d, Offset: 0x2188
// Size: 0xd9
function should_retreat()
{
    if ( self.m_n_times_retreated < 2 )
    {
        n_current_time = gettime();
        
        if ( isdefined( self.m_n_time_last_damaged ) )
        {
            n_time_since_last_damage = ( n_current_time - self.m_n_time_last_damaged ) * 0.001;
            
            if ( n_time_since_last_damage < 5 )
            {
                b_retreat_from_damage = 1;
            }
            else
            {
                b_retreat_from_damage = 0;
            }
        }
        else
        {
            b_retreat_from_damage = 0;
        }
        
        b_retreat_from_low_health = get_vehicle_health_percentage() < 0.7;
        b_retreated_recently = isdefined( self.m_n_time_since_last_retreat ) && ( n_current_time - self.m_n_time_since_last_retreat ) * 0.001 < 5;
        b_should_retreat = b_retreat_from_damage && b_retreat_from_low_health && !b_retreated_recently;
        return b_should_retreat;
    }
    
    return 0;
}

// Namespace ctigertank
// Params 0
// Checksum 0xc62d3ad1, Offset: 0x2270
// Size: 0x22
function get_vehicle_health_percentage()
{
    return self.m_vehicle.health / self.m_vehicle.healthdefault;
}

// Namespace ctigertank
// Params 1
// Checksum 0x35c6faf6, Offset: 0x22a0
// Size: 0x3a
function debug_print( str_text )
{
    /#
        if ( getdvarint( "<dev string:x2fb>", 0 ) )
        {
            iprintlnbold( str_text );
        }
    #/
}

// Namespace ctigertank
// Params 0
// Checksum 0x981a8a82, Offset: 0x22e8
// Size: 0xd5
function show_state_info()
{
    self endon( #"death" );
    self.m_vehicle endon( #"death" );
    
    while ( true )
    {
        if ( getdvarint( "debug_tiger_tank", 0 ) )
        {
            print_debug_3d( "STATE: " + self.m_str_state, 0, 2 );
            print_debug_3d( "FIRING: " + self flag::get( "firing" ), 1, 2 );
            print_debug_3d( "MOVING: " + self flag::get( "moving" ), 2, 2 );
        }
        
        wait 0.1;
    }
}

// Namespace ctigertank
// Params 1
// Checksum 0x9849e643, Offset: 0x23c8
// Size: 0x5e
function can_hit_target( v_target )
{
    v_start = self.m_vehicle gettagorigin( "tag_barrel" );
    b_trace_passed = bullettracepassed( v_start, v_target, 0, self.m_vehicle );
    return b_trace_passed;
}

// Namespace ctigertank
// Params 3
// Checksum 0xd1bd2361, Offset: 0x2430
// Size: 0x7a
function print_debug_3d( str_text, n_offset_lines, n_duration )
{
    v_offset = ( 0, 0, 120 ) + ( 0, 0, n_offset_lines * 25 );
    
    /#
        print3d( self.m_vehicle.origin + v_offset, str_text, ( 1, 1, 1 ), 1, 1.5, n_duration );
    #/
}

/#

    // Namespace ctigertank
    // Params 0
    // Checksum 0xdf0bbaf1, Offset: 0x24b8
    // Size: 0x32, Type: dev
    function break_if_in_debug_mode()
    {
        if ( getdvarint( "<dev string:x2fb>", 0 ) > 1 )
        {
            debugbreak();
        }
    }

#/

// Namespace ctigertank
// Params 1
// Checksum 0x7b60916f, Offset: 0x24f8
// Size: 0x55
function goal_position_show( v_goal )
{
    self endon( #"death" );
    self endon( #"goal_position_hide" );
    
    /#
        while ( true )
        {
            show_point_with_text( v_goal, "<dev string:x30c>", ( 1, 1, 1 ), 1 );
            wait 0.05;
        }
    #/
}

// Namespace ctigertank
// Params 0
// Checksum 0xb61868d2, Offset: 0x2558
// Size: 0xf
function goal_position_hide()
{
    /#
        self notify( #"goal_position_hide" );
    #/
}

// Namespace ctigertank
// Params 4
// Checksum 0xdc9be099, Offset: 0x2570
// Size: 0x92
function show_point_with_text( v_goal, str_text, v_color, n_duration )
{
    /#
        if ( getdvarint( "<dev string:x2fb>", 0 ) )
        {
            debugstar( v_goal, n_duration, v_color );
            print3d( v_goal + ( 0, 0, 40 ), str_text, v_color, 1, 1.5, n_duration );
        }
    #/
}

// Namespace ctigertank
// Params 0
// Checksum 0xe40f4d21, Offset: 0x2610
// Size: 0xa
function set_field_of_view()
{
    self.fovcosine = 0;
}

// Namespace ctigertank
// Params 0
// Checksum 0x99146927, Offset: 0x2628
// Size: 0x2a
function stop_gunner_firing()
{
    self.m_vehicle turret::disable( 1 );
    self.m_vehicle notify( "turret_disabled" + 1 );
}

// Namespace ctigertank
// Params 0
// Checksum 0xddfba641, Offset: 0x2660
// Size: 0x7e
function get_gunner_target()
{
    a_potential_targets = get_targets();
    
    if ( isdefined( self.m_e_target ) )
    {
        arrayremovevalue( a_potential_targets, self.m_e_target );
    }
    
    if ( a_potential_targets.size > 0 )
    {
        e_gunner_target = arraysort( a_potential_targets, self.m_vehicle.origin, 1 )[ 0 ];
    }
    else
    {
        e_gunner_target = self.m_e_target;
    }
    
    return e_gunner_target;
}

