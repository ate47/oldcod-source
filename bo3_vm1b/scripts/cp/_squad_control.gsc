#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_biodomes;
#using scripts/cp/cp_mi_sing_biodomes_util;
#using scripts/cp/cp_mi_sing_biodomes_warehouse;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/objpoints_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;

#namespace squad_control;

// Namespace squad_control
// Params 0, eflags: 0x2
// Checksum 0x629ac5cf, Offset: 0xab8
// Size: 0x2a
function autoexec __init__sytem__()
{
    system::register( "squad_control", &__init__, undefined, undefined );
}

// Namespace squad_control
// Params 0
// Checksum 0xa8f848bd, Offset: 0xaf0
// Size: 0x12a
function __init__()
{
    for ( i = 0; i < 4 ; i++ )
    {
        str_cf_name = "keyline_outline_p" + i;
        clientfield::register( "actor", str_cf_name, 1, 2, "int" );
        clientfield::register( "vehicle", str_cf_name, 1, 2, "int" );
        clientfield::register( "scriptmover", str_cf_name, 1, 3, "int" );
    }
    
    for ( i = 0; i < 4 ; i++ )
    {
        str_cf_name = "squad_indicator_p" + i;
        clientfield::register( "actor", str_cf_name, 1, 1, "int" );
    }
    
    clientfield::register( "actor", "robot_camo_shader", 1, 3, "int" );
    level.a_ai_squad = [];
    level.b_squad_player_controlled = 0;
    callback::on_disconnect( &on_player_disconnect );
}

// Namespace squad_control
// Params 0
// Checksum 0x666d8642, Offset: 0xc28
// Size: 0x9b
function on_player_disconnect()
{
    self remove_player_robot_indicators();
    
    if ( isdefined( self.obj_icon ) )
    {
        self.obj_icon destroy_temp_icon();
    }
    
    if ( isdefined( self.a_robots ) )
    {
        for ( i = 0; i < self.a_robots.size ; i++ )
        {
            self.a_robots[ i ] util::stop_magic_bullet_shield();
            self.a_robots[ i ] kill();
        }
    }
    
    self notify( #"end_squad_control" );
}

// Namespace squad_control
// Params 1
// Checksum 0x90c93d19, Offset: 0xcd0
// Size: 0x7a
function init_squad_control( b_squad_player_controlled )
{
    if ( !isdefined( b_squad_player_controlled ) )
    {
        b_squad_player_controlled = 0;
    }
    
    self.b_has_task = 0;
    self.a_targets = [];
    self.a_robot_tasks = [];
    level.b_squad_player_controlled = b_squad_player_controlled;
    self thread squad_init();
    self thread squad_names();
    self thread squad_control_think();
    self thread squad_control_end();
}

// Namespace squad_control
// Params 1
// Checksum 0x330e3a7d, Offset: 0xd58
// Size: 0x8b
function function_e56e9d7d( a_ai_squad )
{
    level.a_robot_tasks = [];
    level.b_squad_player_controlled = 0;
    
    foreach ( ai_robot in a_ai_squad )
    {
        if ( isalive( ai_robot ) )
        {
            level robot_init( ai_robot );
        }
    }
}

// Namespace squad_control
// Params 0
// Checksum 0xe72ed712, Offset: 0xdf0
// Size: 0x12b
function squad_control_end()
{
    self endon( #"death" );
    self waittill( #"end_squad_control" );
    wait 0.5;
    
    foreach ( ai_robot in self.a_robots )
    {
        if ( isdefined( ai_robot ) )
        {
            ai_robot thread disable_keyline();
            ai_robot thread enable_indicator( self, 0 );
        }
    }
    
    self.a_robots = [];
    a_e_targets = getaiteamarray( "axis" );
    
    foreach ( e_target in a_e_targets )
    {
        if ( isdefined( e_target.obj_icon ) )
        {
            e_target.obj_icon destroy_temp_icon();
        }
    }
}

// Namespace squad_control
// Params 0
// Checksum 0x379a9646, Offset: 0xf28
// Size: 0x4a
function squad_control_think()
{
    self endon( #"death" );
    self endon( #"end_squad_control" );
    
    if ( level.b_squad_player_controlled )
    {
        self thread squad_control_command();
        self thread mark_potential_targets();
        self thread player_laststand_monitor();
    }
}

// Namespace squad_control
// Params 1
// Checksum 0xd80adcd9, Offset: 0xf80
// Size: 0x149
function update_robot_escort_pos( player )
{
    self endon( #"death" );
    player endon( #"death" );
    player endon( #"end_squad_control" );
    wait randomfloatrange( 1, 3 );
    v_escort_pos_last = player point_near_player_front( self );
    self.v_escort_pos_current = player point_near_player_front( self );
    self ai::set_behavior_attribute( "escort_position", self.v_escort_pos_current );
    
    while ( true )
    {
        if ( self ai::get_behavior_attribute( "move_mode" ) === "escort" && self.b_avail )
        {
            self.v_escort_pos_current = player point_near_player_front( self );
            v_distance_squared = distancesquared( self.v_escort_pos_current, v_escort_pos_last );
            
            if ( v_distance_squared > 2500 )
            {
                v_escort_pos_last = self.v_escort_pos_current;
                self clearforcedgoal();
                self ai::set_behavior_attribute( "escort_position", self.v_escort_pos_current );
            }
        }
        
        wait 2;
    }
}

// Namespace squad_control
// Params 1
// Checksum 0xb4b9a470, Offset: 0x10d8
// Size: 0xb5
function update_robot_goal( player )
{
    self endon( #"death" );
    player endon( #"end_squad_control" );
    
    while ( true )
    {
        wait 5;
        
        if ( self ai::get_behavior_attribute( "move_mode" ) === "escort" && self.b_avail )
        {
            v_pos = getclosestpointonnavmesh( player.origin, 120, 32 );
            
            if ( isdefined( v_pos ) )
            {
                self setgoal( v_pos );
                continue;
            }
            
            self setgoal( player.origin );
        }
    }
}

// Namespace squad_control
// Params 1
// Checksum 0xf1835c5e, Offset: 0x1198
// Size: 0x4a
function point_near_player_front( e_robot )
{
    v_pos_nav = util::positionquery_pointarray( self.origin, 64, -56, 16, 16, 32 );
    
    if ( v_pos_nav.size )
    {
        return v_pos_nav[ 0 ];
    }
    
    return self.origin;
}

// Namespace squad_control
// Params 0
// Checksum 0xe95cf663, Offset: 0x11f0
// Size: 0x72
function squad_init()
{
    str_name = self.playername;
    
    for ( i = 0; i < self.a_robots.size ; i++ )
    {
        level robot_init( self.a_robots[ i ], self );
    }
    
    self thread monitor_squad();
    self thread robot_camo_energy_regen();
}

// Namespace squad_control
// Params 2
// Checksum 0x9828cddf, Offset: 0x1270
// Size: 0x242
function robot_init( ai_robot, player )
{
    ai_robot.b_moving = 0;
    ai_robot.b_avail = 1;
    ai_robot.b_target = 0;
    ai_robot.str_action = "Standard";
    ai_robot.b_camo = 0;
    ai_robot.goalradius = -56;
    ai_robot.attackeraccuracy = 1;
    ai_robot.minwalkdistance = 600;
    ai_robot ai::set_behavior_attribute( "supports_super_sprint", 1 );
    ai_robot ai::set_behavior_attribute( "can_be_meleed", 0 );
    
    if ( level.b_squad_player_controlled && isplayer( player ) )
    {
        ai_robot thread remove_squad_member( player );
        ai_robot thread update_robot_escort_pos( player );
        ai_robot thread update_robot_goal( player );
        ai_robot enable_indicator( player, 1 );
        ai_robot ai::set_behavior_attribute( "move_mode", "escort" );
        player.n_entity = player getentitynumber();
    }
    else
    {
        ai_robot thread replenish_squad();
        
        if ( level flag::get( "warehouse_warlord_friendly_goal" ) )
        {
            e_goal_volume = getent( "warehouse_warlord_friendly_volume", "targetname" );
            ai_robot setgoal( e_goal_volume, 1 );
        }
        else
        {
            ai_robot ai::set_behavior_attribute( "move_mode", "normal" );
            ai_robot colors::set_force_color( "c" );
        }
        
        ai_robot function_eb13b9c0();
    }
    
    array::add( level.a_ai_squad, ai_robot, 0 );
    
    if ( level.override_robot_damage )
    {
        ai_robot.overrideactordamage = &callback_robot_damage;
    }
}

// Namespace squad_control
// Params 0
// Checksum 0x27c6ba51, Offset: 0x14c0
// Size: 0x1a
function function_eb13b9c0()
{
    self clientfield::set( "cybercom_setiffname", 2 );
}

// Namespace squad_control
// Params 1
// Checksum 0x24a01297, Offset: 0x14e8
// Size: 0xfd
function random_robot_camo( player )
{
    self endon( #"death" );
    player endon( #"end_squad_control" );
    self endon( #"stop_camo" );
    
    if ( level.b_squad_player_controlled )
    {
        return;
    }
    
    while ( true )
    {
        wait randomintrange( 6, 12 );
        n_chance = randomfloatrange( 0, 1 );
        
        if ( n_chance >= 0.5 && !self.b_camo && self.b_avail )
        {
            self thread robot_camo( 1, player );
            self ai::set_behavior_attribute( "move_mode", "rusher" );
            self.perfectaim = 1;
            wait 10;
            self ai::set_behavior_attribute( "move_mode", "escort" );
            self thread robot_camo( 0, player );
            self.perfectaim = 0;
        }
    }
}

// Namespace squad_control
// Params 0
// Checksum 0x44ceac47, Offset: 0x15f0
// Size: 0x9a
function squad_camo_intro()
{
    self endon( #"death" );
    self clientfield::set( "robot_camo_shader", 1 );
    self playsound( "gdt_camo_suit_on" );
    self.ignoreme = 1;
    self.b_camo = 1;
    wait randomintrange( 3, 6 );
    self clientfield::set( "robot_camo_shader", 0 );
    self playsound( "gdt_camo_suit_off" );
    self.ignoreme = 0;
    self.b_camo = 0;
}

// Namespace squad_control
// Params 0
// Checksum 0x92d56802, Offset: 0x1698
// Size: 0x6ba
function squad_names()
{
    if ( !level.b_squad_player_controlled )
    {
        return;
    }
    
    self.n_entity = self getentitynumber();
    str_name = self.playername;
    
    if ( self.n_entity == 0 )
    {
        objectives::set( "robot_name_1", self.a_robots[ 0 ] );
        objectives::set_value( "robot_name_1", "robot1", str_name + "-" + 0 );
        self.a_robots[ 0 ] thread remove_squad_name_ondeath( "robot_name_1", self );
        self.a_robots[ 0 ] thread remove_squad_name( "robot_name_1", self );
        
        if ( self.a_robots.size > 1 )
        {
            objectives::set( "robot_name_2", self.a_robots[ 1 ] );
            objectives::set_value( "robot_name_2", "robot2", str_name + "-" + 1 );
            self.a_robots[ 1 ] thread remove_squad_name_ondeath( "robot_name_2", self );
            self.a_robots[ 1 ] thread remove_squad_name( "robot_name_2", self );
        }
        
        if ( self.a_robots.size > 2 )
        {
            objectives::set( "robot_name_3", self.a_robots[ 2 ] );
            objectives::set_value( "robot_name_3", "robot3", str_name + "-" + 2 );
            self.a_robots[ 2 ] thread remove_squad_name_ondeath( "robot_name_3", self );
            self.a_robots[ 2 ] thread remove_squad_name( "robot_name_3", self );
        }
        
        if ( self.a_robots.size > 3 )
        {
            objectives::set( "robot_name_4", self.a_robots[ 3 ] );
            objectives::set_value( "robot_name_4", "robot4", str_name + "-" + 3 );
            self.a_robots[ 3 ] thread remove_squad_name_ondeath( "robot_name_4", self );
            self.a_robots[ 3 ] thread remove_squad_name( "robot_name_4", self );
        }
        
        return;
    }
    
    if ( self.n_entity == 1 )
    {
        objectives::set( "robot_name_5", self.a_robots[ 0 ] );
        objectives::set_value( "robot_name_5", "robot5", str_name + "-" + 0 );
        self.a_robots[ 0 ] thread remove_squad_name_ondeath( "robot_name_5", self );
        self.a_robots[ 0 ] thread remove_squad_name( "robot_name_5", self );
        objectives::set( "robot_name_6", self.a_robots[ 1 ] );
        objectives::set_value( "robot_name_6", "robot6", str_name + "-" + 1 );
        self.a_robots[ 1 ] thread remove_squad_name_ondeath( "robot_name_6", self );
        self.a_robots[ 1 ] thread remove_squad_name( "robot_name_6", self );
        
        if ( self.a_robots.size > 2 )
        {
            objectives::set( "robot_name_7", self.a_robots[ 2 ] );
            objectives::set_value( "robot_name_7", "robot7", str_name + "-" + 2 );
            self.a_robots[ 2 ] thread remove_squad_name_ondeath( "robot_name_7", self );
            self.a_robots[ 2 ] thread remove_squad_name( "robot_name_7", self );
        }
        
        return;
    }
    
    if ( self.n_entity == 2 )
    {
        objectives::set( "robot_name_8", self.a_robots[ 0 ] );
        objectives::set_value( "robot_name_8", "robot8", str_name + "-" + 0 );
        self.a_robots[ 0 ] thread remove_squad_name_ondeath( "robot_name_8", self );
        self.a_robots[ 0 ] thread remove_squad_name( "robot_name_8", self );
        objectives::set( "robot_name_9", self.a_robots[ 1 ] );
        objectives::set_value( "robot_name_9", "robot9", str_name + "-" + 1 );
        self.a_robots[ 1 ] thread remove_squad_name_ondeath( "robot_name_9", self );
        self.a_robots[ 1 ] thread remove_squad_name( "robot_name_9", self );
        return;
    }
    
    objectives::set( "robot_name_10", self.a_robots[ 0 ] );
    objectives::set_value( "robot_name_10", "robot10", str_name + "-" + 0 );
    self.a_robots[ 0 ] thread remove_squad_name_ondeath( "robot_name_10", self );
    self.a_robots[ 0 ] thread remove_squad_name( "robot_name_10", self );
    objectives::set( "robot_name_11", self.a_robots[ 1 ] );
    objectives::set_value( "robot_name_11", "robot11", str_name + "-" + 1 );
    self.a_robots[ 1 ] thread remove_squad_name_ondeath( "robot_name_11", self );
    self.a_robots[ 1 ] thread remove_squad_name( "robot_name_11", self );
}

// Namespace squad_control
// Params 2
// Checksum 0x1a5a88a6, Offset: 0x1d60
// Size: 0x3a
function remove_squad_name( str_obj, e_player )
{
    self endon( #"death" );
    e_player waittill( #"end_squad_control" );
    objectives::complete( str_obj, self );
}

// Namespace squad_control
// Params 2
// Checksum 0xf4ed6af4, Offset: 0x1da8
// Size: 0x4a
function remove_squad_name_ondeath( str_obj, e_player )
{
    e_player endon( #"end_squad_control" );
    self waittill( #"death" );
    objectives::complete( str_obj, self );
    self enable_indicator( e_player, 0 );
}

// Namespace squad_control
// Params 0
// Checksum 0x31527010, Offset: 0x1e00
// Size: 0x1df
function mark_potential_targets()
{
    self endon( #"disconnect" );
    self endon( #"end_squad_control" );
    
    while ( true )
    {
        if ( !self laststand::player_is_in_laststand() )
        {
            a_e_targets = getaiteamarray( "axis" );
            
            for ( i = 0; i < a_e_targets.size ; i++ )
            {
                n_dist = distance2dsquared( self.origin, a_e_targets[ i ].origin );
                
                if ( self util::is_player_looking_at( a_e_targets[ i ].origin, 0.95, 0, self ) && self sightconetrace( a_e_targets[ i ] geteye(), a_e_targets[ i ] ) && isalive( a_e_targets[ i ] ) && n_dist < 5760000 )
                {
                    if ( isdefined( a_e_targets[ i ].b_keylined ) && !a_e_targets[ i ].b_keylined && isdefined( a_e_targets[ i ].b_targeted ) && !a_e_targets[ i ].b_targeted )
                    {
                        a_e_targets[ i ] thread enable_keyline( 1, self );
                        a_e_targets[ i ].b_keylined = 1;
                    }
                    
                    continue;
                }
                
                if ( isalive( a_e_targets[ i ] ) && isdefined( a_e_targets[ i ].b_targeted ) && !a_e_targets[ i ].b_targeted )
                {
                    a_e_targets[ i ] thread disable_keyline( self );
                    a_e_targets[ i ].b_keylined = 0;
                }
            }
        }
        
        wait 3;
    }
}

// Namespace squad_control
// Params 0
// Checksum 0x609e4916, Offset: 0x1fe8
// Size: 0x6e
function show_scanline()
{
    self endon( #"death" );
    self endon( #"end_squad_control" );
    
    if ( !isdefined( self.is_playing_scanline ) )
    {
        self.is_playing_scanline = 0;
    }
    
    if ( !self.is_playing_scanline && isdefined( self.reticule_menu ) )
    {
        self.is_playing_scanline = 1;
        self lui::play_animation( self.reticule_menu, "Scanline" );
        wait 2;
        self.is_playing_scanline = 0;
    }
}

// Namespace squad_control
// Params 0
// Checksum 0x58d3b1fb, Offset: 0x2060
// Size: 0x2e5
function squad_control_command()
{
    self endon( #"disconnect" );
    self endon( #"end_squad_control" );
    n_trace = 1600;
    n_count = 10;
    
    while ( true )
    {
        if ( !self laststand::player_is_in_laststand() )
        {
            if ( self actionslotonebuttonpressed() )
            {
                v_direction = anglestoforward( self getplayerangles() );
                v_eye = self geteye();
                v_trace_pos = v_eye + v_direction * n_trace;
                v_eye_trace = bullettrace( v_eye, v_trace_pos, 0, self )[ "position" ];
                v_pos = groundpos_ignore_water( v_eye_trace ) + ( 0, 0, 5 );
                v_moveto = getclosestpointonnavmesh( v_pos, 100, 32 );
                n_inc = 0;
                
                while ( self actionslotonebuttonpressed() )
                {
                    n_inc++;
                    
                    if ( n_inc > 2 )
                    {
                        /#
                            level util::debug_line( self.origin + ( 0, 0, 32 ), v_pos, ( 0, 0.25, 1 ), 0.25, undefined, 1 );
                            v_direction = anglestoforward( self getplayerangles() );
                            v_eye = self geteye();
                            v_trace_pos = v_eye + v_direction * n_trace;
                            v_eye_trace = bullettrace( v_eye, v_trace_pos, 0, self )[ "<dev string:x28>" ];
                            v_pos = groundpos_ignore_water( v_eye_trace ) + ( 0, 0, 5 );
                            v_moveto = getclosestpointonnavmesh( v_pos, 100, 32 );
                        #/
                    }
                    
                    if ( n_inc >= n_count )
                    {
                        n_inc = n_count;
                    }
                    
                    wait 0.05;
                }
                
                self thread cp_mi_sing_biodomes_util::player_interact_anim_generic();
                
                if ( n_inc >= n_count )
                {
                    self squad_move_command( v_moveto );
                    self playsoundtoplayer( "evt_robocommand_assign_task", self );
                }
                else
                {
                    self playsoundtoplayer( "evt_robocommand_assign_task", self );
                    self squad_update_task();
                    self squad_assign_task();
                    self squad_carryout_orders( v_moveto );
                }
                
                while ( self actionslotonebuttonpressed() )
                {
                    wait 0.05;
                }
            }
        }
        
        wait 0.05;
    }
}

// Namespace squad_control
// Params 1
// Checksum 0x82b98ac, Offset: 0x2350
// Size: 0x31a
function squad_move_command( v_moveto )
{
    self endon( #"end_squad_control" );
    
    if ( isdefined( v_moveto ) )
    {
        self thread remove_player_robot_indicators();
        a_v_points = util::positionquery_pointarray( v_moveto, 16, -16, 70, 64, 40 );
        
        if ( isdefined( a_v_points ) && a_v_points.size >= self.a_robots.size )
        {
            if ( isdefined( self.obj_icon ) )
            {
                self.obj_icon destroy_temp_icon();
            }
            
            foreach ( robot in self.a_robots )
            {
                robot enable_indicator( self, 0 );
            }
            
            self.a_robots = arraysortclosest( self.a_robots, self.origin );
            a_goal_markers = [];
            
            for ( i = 0; i < self.a_robots.size ; i++ )
            {
                if ( self.a_robots[ i ].b_avail )
                {
                    str_removal_notify = "remove_waypoint_p" + self getentitynumber() + "_robot" + i;
                    a_goal_markers[ i ] = level fx::play( "squad_waypoint_base", a_v_points[ i ] + ( 0, 0, 4 ), ( -90, 0, 0 ), str_removal_notify, 0, undefined, 1 );
                    a_goal_markers[ i ] setinvisibletoall();
                    a_goal_markers[ i ] setvisibletoplayer( self );
                    self.a_robots[ i ] notify( #"moving" );
                    self.a_robots[ i ].b_moving = 1;
                    self.a_robots[ i ].str_action = "Moving";
                    self.a_robots[ i ] notify( #"action" );
                    self.a_robots[ i ] colors::disable();
                    self.a_robots[ i ] clearentitytarget();
                    self.a_robots[ i ] ai::set_behavior_attribute( "move_mode", "normal" );
                    self.a_robots[ i ] setgoal( a_v_points[ i ], 1 );
                    self.a_robots[ i ] thread sndplaydelayedacknowledgement();
                    self thread return_to_player( self.a_robots[ i ], str_removal_notify );
                }
            }
        }
        else
        {
            self notify( #"invalid_pos" );
            self thread squad_invalid_message();
        }
        
        return;
    }
    
    self notify( #"invalid_pos" );
    self thread squad_invalid_message();
}

// Namespace squad_control
// Params 0
// Checksum 0xa069a4d0, Offset: 0x2678
// Size: 0x67
function remove_player_robot_indicators()
{
    n_player = self getentitynumber();
    
    if ( isdefined( self.a_robots ) )
    {
        for ( i = 0; i < self.a_robots.size ; i++ )
        {
            str_removal_notify = "remove_waypoint_p" + n_player + "_robot" + i;
            level notify( str_removal_notify );
        }
    }
}

// Namespace squad_control
// Params 0
// Checksum 0xaea7b67f, Offset: 0x26e8
// Size: 0x1aa
function squad_update_task()
{
    if ( self.b_has_task )
    {
        for ( i = 0; i < self.a_robot_tasks.size ; i++ )
        {
            if ( isdefined( self.a_robot_tasks[ i ] ) && isdefined( self.a_robot_tasks[ i ].obj_icon ) )
            {
                self.a_robot_tasks[ i ] notify( #"end" );
                self.a_robot_tasks[ i ].obj_icon destroy_temp_icon();
            }
        }
        
        self.b_has_task = 0;
    }
    
    if ( self.a_targets.size )
    {
        foreach ( ai_robot in self.a_robots )
        {
            if ( ai_robot.b_target )
            {
                ai_robot notify( #"stop_shooting" );
                ai_robot.str_action = "Standard";
                ai_robot notify( #"action" );
                ai_robot.b_target = 0;
                ai_robot clearentitytarget();
            }
        }
        
        for ( i = 0; i < self.a_targets.size ; i++ )
        {
            if ( isalive( self.a_targets[ i ] ) )
            {
                self.a_targets[ i ].b_targeted = 0;
                self.a_targets[ i ] disable_keyline( self );
            }
        }
        
        self.a_targets = [];
    }
}

// Namespace squad_control
// Params 0
// Checksum 0x5db817b1, Offset: 0x28a0
// Size: 0x261
function squad_assign_task()
{
    for ( i = 0; i < self.a_robot_tasks.size ; i++ )
    {
        if ( isdefined( self.a_robot_tasks[ i ] ) )
        {
            n_dist = distance2dsquared( self.origin, self.a_robot_tasks[ i ].origin );
            
            if ( !self.a_robot_tasks[ i ].b_engaged && n_dist < 5760000 )
            {
                if ( self util::is_player_looking_at( self.a_robot_tasks[ i ].origin, 0.9, 0, self ) )
                {
                    if ( self.a_robots.size >= self.a_robot_tasks[ i ].n_required )
                    {
                        self.a_robot_tasks[ i ].b_engaged = 1;
                        self.b_has_task = 1;
                        a_ai_robots = [];
                        
                        if ( self.a_robot_tasks[ i ].script_noteworthy == "turret_hall" )
                        {
                            a_ai_robots = arraycopy( level.a_ai_squad );
                        }
                        else
                        {
                            a_temp = arraycopy( level.a_ai_squad );
                            
                            while ( true )
                            {
                                ai_closest = arraygetclosest( self.a_robot_tasks[ i ].origin, a_temp );
                                arrayremovevalue( a_temp, ai_closest );
                                
                                if ( ai_closest.b_avail )
                                {
                                    ai_closest.b_avail = 0;
                                    array::add( a_ai_robots, ai_closest );
                                    
                                    if ( a_ai_robots.size > 1 )
                                    {
                                        break;
                                    }
                                }
                                
                                if ( !a_temp.size )
                                {
                                    iprintlnbold( "NOT ENOUGH ROBOTS" );
                                    self.a_robot_tasks[ i ].b_engaged = 0;
                                    self.b_has_task = 0;
                                    a_ai_robots = [];
                                    break;
                                }
                                
                                wait 0.05;
                            }
                            
                            a_temp = [];
                        }
                        
                        if ( a_ai_robots.size )
                        {
                            self thread robot_task( a_ai_robots, self.a_robot_tasks[ i ] );
                        }
                        
                        break;
                    }
                    
                    iprintlnbold( self.playername + " DOES NOT HAVE ENOUGH ROBOTS" );
                }
            }
        }
    }
}

// Namespace squad_control
// Params 2
// Checksum 0x26b2d77f, Offset: 0x2b10
// Size: 0x22b
function squad_assign_task_independent( str_task, n_delay_timer )
{
    if ( !isdefined( n_delay_timer ) )
    {
        n_delay_timer = 0;
    }
    
    if ( level.b_squad_player_controlled )
    {
        return;
    }
    
    e_robot_task = getent( str_task, "script_noteworthy" );
    e_robot_task endon( #"death" );
    wait n_delay_timer;
    
    for ( i = 0; i < level.a_robot_tasks.size ; i++ )
    {
        if ( level.a_robot_tasks[ i ] === e_robot_task && !level.a_robot_tasks[ i ].b_engaged )
        {
            while ( level.a_ai_squad.size < level.a_robot_tasks[ i ].n_required )
            {
                level notify( #"spawn_friendly_robot" );
                wait 0.05;
            }
            
            if ( level.a_ai_squad.size >= level.a_robot_tasks[ i ].n_required )
            {
                level.a_robot_tasks[ i ].b_engaged = 1;
                a_ai_robots = [];
                a_temp = arraycopy( level.a_ai_squad );
                
                while ( true )
                {
                    ai_closest = arraygetclosest( level.a_robot_tasks[ i ].origin, a_temp );
                    arrayremovevalue( a_temp, ai_closest );
                    
                    if ( isalive( ai_closest ) && ai_closest.b_avail && !ai_closest.iscrawler )
                    {
                        ai_closest.b_avail = 0;
                        ai_closest util::magic_bullet_shield();
                        array::add( a_ai_robots, ai_closest );
                        
                        if ( a_ai_robots.size > 1 )
                        {
                            break;
                        }
                    }
                    
                    if ( !a_temp.size )
                    {
                        level.a_robot_tasks[ i ].b_engaged = 0;
                        a_ai_robots = [];
                        break;
                    }
                    
                    wait 0.05;
                }
                
                a_temp = [];
                
                if ( a_ai_robots.size )
                {
                    level thread robot_task( a_ai_robots, level.a_robot_tasks[ i ] );
                }
                
                break;
            }
        }
    }
}

// Namespace squad_control
// Params 1
// Checksum 0x6e29e4df, Offset: 0x2d48
// Size: 0x26a
function squad_carryout_orders( v_moveto )
{
    a_e_targets = getaiteamarray( "axis" );
    
    if ( !self.b_has_task )
    {
        for ( i = 0; i < a_e_targets.size ; i++ )
        {
            n_dist = distance2dsquared( self.origin, a_e_targets[ i ].origin );
            
            if ( self util::is_player_looking_at( a_e_targets[ i ].origin, 0.95, 0, self ) && self sightconetrace( a_e_targets[ i ] geteye(), a_e_targets[ i ] ) && isalive( a_e_targets[ i ] ) && n_dist < 5760000 )
            {
                if ( !isdefined( a_e_targets[ i ].b_engaged ) )
                {
                    if ( !isdefined( self.a_targets ) )
                    {
                        self.a_targets = [];
                    }
                    else if ( !isarray( self.a_targets ) )
                    {
                        self.a_targets = array( self.a_targets );
                    }
                    
                    self.a_targets[ self.a_targets.size ] = a_e_targets[ i ];
                    self thread mark_target( a_e_targets[ i ], "target" );
                    self thread remove_target_ondeath( a_e_targets[ i ] );
                }
            }
        }
    }
    
    if ( self.a_targets.size )
    {
        foreach ( ai_robot in self.a_robots )
        {
            if ( isalive( ai_robot ) && ai_robot.b_avail )
            {
                self thread robot_attack_target( ai_robot );
            }
        }
        
        return;
    }
    
    self squad_move_command( v_moveto );
    self playsoundtoplayer( "evt_robocommand_assign_task", self );
}

// Namespace squad_control
// Params 0
// Checksum 0xe48590e4, Offset: 0x2fc0
// Size: 0x42
function sndplaydelayedacknowledgement()
{
    self endon( #"death" );
    wait randomfloatrange( 0.4, 1.2 );
    
    if ( isdefined( self ) )
    {
        self playsound( "evt_robocommand_acknowledge" );
    }
}

// Namespace squad_control
// Params 0
// Checksum 0x93b485ce, Offset: 0x3010
// Size: 0x79
function squad_invalid_message()
{
    self endon( #"disconnect" );
    self endon( #"invalid_pos" );
    
    if ( isdefined( self.invalid_menu ) )
    {
        self closeluimenu( self.invalid_menu );
        self.invalid_menu = undefined;
    }
    
    self.invalid_menu = self openluimenu( "SquadInvalidPosMenu" );
    wait 2;
    self closeluimenu( self.invalid_menu );
    self.invalid_menu = undefined;
}

// Namespace squad_control
// Params 0
// Checksum 0xd0807d38, Offset: 0x3098
// Size: 0x2e1
function squad_control_follow()
{
    self endon( #"disconnect" );
    self endon( #"end_squad_control" );
    
    while ( true )
    {
        n_min_dist = 48;
        n_max_dist = 400;
        n_max_height = 48;
        
        if ( isdefined( self.b_narrow_space ) && self.b_narrow_space )
        {
            n_min_dist = 24;
            n_max_dist = 82;
            n_max_height = 0;
        }
        
        v_player_pos = getclosestpointonnavmesh( self.origin, 82, 32 );
        
        if ( isdefined( v_player_pos ) )
        {
            a_v_points = util::positionquery_pointarray( v_player_pos, n_min_dist, n_max_dist, n_max_height, 100, 48 );
            
            if ( a_v_points.size >= self.a_robots.size )
            {
                self.a_robots = arraysortclosest( self.a_robots, self.origin );
                
                for ( i = 0; i < self.a_robots.size ; i++ )
                {
                    if ( distance2dsquared( self.origin, self.a_robots[ i ].origin ) > 40000 )
                    {
                        if ( !self.a_robots[ i ].b_moving && !self.a_robots[ i ].b_target && self.a_robots[ i ].b_avail )
                        {
                            self.a_robots[ i ] setgoal( a_v_points[ i ], 1 );
                            wait randomfloatrange( 0.1, 0.3 );
                        }
                    }
                }
            }
            else
            {
                a_alt_pos = [];
                
                for ( i = 0; i < self.a_robots.size ; i++ )
                {
                    if ( distance2dsquared( self.origin, self.a_robots[ i ].origin ) > 40000 )
                    {
                        if ( !self.a_robots[ i ].b_moving && !self.a_robots[ i ].b_target && self.a_robots[ i ].b_avail )
                        {
                            a_alt_pos[ i ] = getclosestpointonnavmesh( self.origin + ( i * 50, i * 50, 0 ), 82, 32 );
                            
                            if ( isdefined( a_alt_pos[ i ] ) )
                            {
                                self.a_robots[ i ] setgoal( a_alt_pos[ i ], 1 );
                                wait randomfloatrange( 0.1, 0.3 );
                            }
                        }
                    }
                }
                
                a_alt_pos = undefined;
            }
        }
        
        wait 0.1;
    }
}

// Namespace squad_control
// Params 0
// Checksum 0x9e74f015, Offset: 0x3388
// Size: 0x157
function player_laststand_monitor()
{
    self endon( #"disconnect" );
    self endon( #"end_squad_control" );
    
    while ( true )
    {
        self waittill( #"player_downed" );
        
        for ( i = 0; i < self.a_robots.size ; i++ )
        {
            if ( isalive( self.a_robots[ i ] ) )
            {
                self.a_robots[ i ] notify( #"stop_shooting" );
                self.a_robots[ i ].b_target = 0;
                self.a_robots[ i ].b_moving = 0;
                self.a_robots[ i ].str_action = "Standard";
                self.a_robots[ i ] notify( #"action" );
            }
        }
        
        wait 0.5;
        
        if ( self.a_targets.size )
        {
            foreach ( e_target in self.a_targets )
            {
                if ( isalive( e_target ) )
                {
                    e_target thread disable_keyline( self );
                }
            }
        }
    }
}

// Namespace squad_control
// Params 0
// Checksum 0x40842989, Offset: 0x34e8
// Size: 0x4e
function robot_wait_goal()
{
    self endon( #"death" );
    self endon( #"moving" );
    str_msg = self util::waittill_any_timeout( 20, "goal" );
    
    if ( str_msg == "goal" )
    {
        wait 3;
    }
    
    self.b_moving = 0;
}

// Namespace squad_control
// Params 2
// Checksum 0xe3161e76, Offset: 0x3540
// Size: 0xc8
function return_to_player( ai_robot, str_removal_notify )
{
    self endon( #"disconnect" );
    self endon( #"end_squad_control" );
    ai_robot endon( #"moving" );
    ai_robot endon( #"death" );
    str_msg = ai_robot util::waittill_any_timeout( 20, "goal" );
    level notify( str_removal_notify );
    ai_robot enable_indicator( self, 1 );
    
    if ( str_msg == "goal" )
    {
        wait 3;
    }
    
    ai_robot ai::set_behavior_attribute( "move_mode", "escort" );
    ai_robot.b_moving = 0;
    ai_robot.str_action = "Standard";
    ai_robot notify( #"action" );
}

// Namespace squad_control
// Params 2
// Checksum 0xf69e61e8, Offset: 0x3610
// Size: 0x66
function mark_target( e_target, str_obj )
{
    e_target endon( #"death" );
    e_target endon( #"end" );
    e_target disable_keyline( self );
    wait 0.05;
    e_target enable_keyline( 2, self );
    e_target.b_targeted = 1;
}

// Namespace squad_control
// Params 2
// Checksum 0x11b038e8, Offset: 0x3680
// Size: 0x52
function mark_task( e_target, str_obj )
{
    e_target.obj_icon = create_temp_icon( str_obj, e_target getentitynumber(), e_target.origin + ( 0, 0, 72 ) );
}

// Namespace squad_control
// Params 1
// Checksum 0x53dc4525, Offset: 0x36e0
// Size: 0x92
function remove_target_ondeath( ai_target )
{
    ai_target waittill( #"death" );
    
    if ( isdefined( ai_target ) && isdefined( self.a_targets ) && isinarray( self.a_targets, ai_target ) )
    {
        arrayremovevalue( self.a_targets, ai_target );
    }
    
    if ( isdefined( ai_target ) )
    {
        ai_target disable_keyline();
    }
    
    if ( isdefined( ai_target.obj_icon ) )
    {
        ai_target.obj_icon destroy_temp_icon();
    }
}

// Namespace squad_control
// Params 1
// Checksum 0x3fa08d58, Offset: 0x3780
// Size: 0xd5
function squad_control_task( e_task )
{
    e_task.b_engaged = 0;
    
    if ( !isdefined( self.a_robot_tasks ) )
    {
        self.a_robot_tasks = [];
    }
    else if ( !isarray( self.a_robot_tasks ) )
    {
        self.a_robot_tasks = array( self.a_robot_tasks );
    }
    
    self.a_robot_tasks[ self.a_robot_tasks.size ] = e_task;
    
    switch ( e_task.script_noteworthy )
    {
        case "pry_door":
            e_task.n_required = 2;
            break;
        case "floor_collapse":
            e_task.n_required = 2;
            break;
        default:
            e_task.n_required = 1;
            break;
    }
}

// Namespace squad_control
// Params 2
// Checksum 0x1be5e58e, Offset: 0x3860
// Size: 0x18d
function robot_task( a_ai_robots, e_task )
{
    foreach ( ai_robot in a_ai_robots )
    {
        if ( isalive( ai_robot ) && !ai_robot.iscrawler )
        {
            if ( e_task.script_noteworthy == "floor_collapse" )
            {
                ai_robot ai::set_behavior_attribute( "move_mode", "rambo" );
            }
            else
            {
                ai_robot ai::set_behavior_attribute( "move_mode", "normal" );
            }
            
            ai_robot util::magic_bullet_shield();
            ai_robot.b_avail = 0;
            ai_robot ai::disable_pain();
            ai_robot.ignoresuppression = 1;
            ai_robot notify( #"stop_shooting" );
            ai_robot notify( #"stop_camo" );
            ai_robot.str_action = "Interacting";
            ai_robot notify( #"action" );
            continue;
        }
        
        return;
    }
    
    switch ( e_task.script_noteworthy )
    {
        default:
            self thread robot_interact_warehouse_door( a_ai_robots, e_task );
            break;
        case "floor_collapse":
            self thread robot_interact_markets1_turret( a_ai_robots, e_task );
            break;
    }
}

// Namespace squad_control
// Params 1
// Checksum 0xfe1d9618, Offset: 0x39f8
// Size: 0x448
function robot_attack_target( ai_robot )
{
    ai_robot endon( #"death" );
    ai_robot endon( #"stop_shooting" );
    self endon( #"end_squad_control" );
    self endon( #"disconnect" );
    n_min_dist = 60;
    n_max_dist = -56;
    ai_robot.goalradius = 1024;
    ai_robot ai::set_behavior_attribute( "move_mode", "rusher" );
    ai_robot thread robot_camo( 1, self );
    
    for ( i = 0; i < self.a_targets.size ; i++ )
    {
        self.a_targets[ i ].b_targeted_by_robot = 0;
        
        if ( isalive( self.a_targets[ i ] ) )
        {
            if ( self.a_targets[ i ].aitype === "spawner_enemy_54i_human_warlord_minigun" )
            {
                continue;
            }
            
            v_target_pos = getclosestpointonnavmesh( self.a_targets[ i ].origin, 64, 16 );
            
            if ( isdefined( v_target_pos ) )
            {
                a_v_points = util::positionquery_pointarray( v_target_pos, n_min_dist, n_max_dist, 70, 32, ai_robot );
                
                if ( a_v_points.size >= self.a_robots.size )
                {
                    n_height_diff = abs( self.origin[ 2 ] - a_v_points[ i ][ 2 ] );
                    
                    if ( n_height_diff < -96 && distancesquared( self.origin, a_v_points[ i ] ) < 1048576 )
                    {
                        ai_robot setgoal( a_v_points[ i ], 1 );
                    }
                    
                    if ( isactor( self.a_targets[ i ] ) )
                    {
                        ai_robot thread ai::shoot_at_target( "kill_within_time", self.a_targets[ i ], undefined, 0.05, 100 );
                    }
                    else
                    {
                        ai_robot thread ai::shoot_at_target( "shoot_until_target_dead", self.a_targets[ i ], undefined, 0.05, 100 );
                    }
                }
                else
                {
                    ai_robot ai::set_behavior_attribute( "move_mode", "normal" );
                    
                    if ( isactor( self.a_targets[ i ] ) )
                    {
                        ai_robot thread ai::shoot_at_target( "kill_within_time", self.a_targets[ i ], undefined, 0.05, 100 );
                    }
                    else
                    {
                        ai_robot thread ai::shoot_at_target( "shoot_until_target_dead", self.a_targets[ i ], undefined, 0.05, 100 );
                    }
                }
            }
            else if ( isactor( self.a_targets[ i ] ) )
            {
                ai_robot thread ai::shoot_at_target( "kill_within_time", self.a_targets[ i ], undefined, 0.05, 100 );
            }
            else
            {
                ai_robot thread ai::shoot_at_target( "shoot_until_target_dead", self.a_targets[ i ], undefined, 0.05, 100 );
            }
            
            self.a_targets[ i ].b_targeted_by_robot = 1;
            ai_robot.b_target = 1;
            ai_robot.str_action = "Attacking";
            ai_robot notify( #"action" );
            
            /#
                level util::debug_line( ai_robot.origin + ( 0, 0, 64 ), self.a_targets[ i ].origin + ( 0, 0, 64 ), ( 1, 0, 0 ), 0.1, undefined, 3 );
            #/
            
            ai_robot thread sndplaydelayedacknowledgement();
        }
    }
    
    while ( self.a_targets.size )
    {
        wait 0.05;
    }
    
    ai_robot clearforcedgoal();
    ai_robot thread robot_camo( 0, self );
    ai_robot ai::set_behavior_attribute( "move_mode", "escort" );
    ai_robot.b_target = 0;
    ai_robot.str_action = "Standard";
    ai_robot notify( #"action" );
}

// Namespace squad_control
// Params 2
// Checksum 0xbc16618d, Offset: 0x3e48
// Size: 0x2aa
function robot_interact_markets1_turret( a_ai_robots, e_task )
{
    level endon( #"turret1_dead" );
    
    if ( isinarray( self.a_robot_tasks, e_task ) )
    {
        arrayremovevalue( self.a_robot_tasks, e_task );
    }
    
    level thread squad_interaction_end( a_ai_robots, "turret1_dead" );
    level thread function_2b79dc3e();
    
    if ( isdefined( e_task ) && !level flag::get( "turret1_dead" ) )
    {
        if ( isalive( e_task ) )
        {
            if ( e_task getteam() === "allies" )
            {
                level flag::set( "turret1_dead" );
                return;
            }
            
            level thread scene::init( "cin_bio_03_02_market_vign_targetkill_robot01", a_ai_robots[ 0 ] );
            level thread scene::init( "cin_bio_03_02_market_vign_targetkill_robot02", a_ai_robots[ 1 ] );
            level util::waittill_multiple_ents( a_ai_robots[ 0 ], "goal", a_ai_robots[ 1 ], "goal" );
            level thread scene::play( "scene_turret1", "targetname", a_ai_robots );
            e_task util::magic_bullet_shield();
            level util::waittill_notify_or_timeout( "floor_fall", 10 );
            e_floor_collision = getent( "vendor_shop_turret_destroyed", "targetname" );
            
            if ( isdefined( e_floor_collision ) )
            {
                e_floor_collision delete();
            }
            
            level thread scene::play( "p7_fxanim_cp_biodomes_turret_collapse_bundle" );
            e_turret_tag = getent( "turret_collapse", "targetname" );
            
            if ( isdefined( e_task ) && isdefined( e_turret_tag ) )
            {
                e_task linkto( e_turret_tag, "turret_jnt" );
                fx::play( "ceiling_collapse", e_task.origin );
                playrumbleonposition( "cp_biodomes_markets1_turret_collapse_rumble", e_task.origin );
            }
            
            level notify( #"hash_62a94152" );
            
            if ( isalive( e_task ) )
            {
                e_task util::stop_magic_bullet_shield();
                e_task kill();
            }
        }
    }
}

// Namespace squad_control
// Params 0
// Checksum 0xc5eb9136, Offset: 0x4100
// Size: 0x72
function function_2b79dc3e()
{
    level endon( #"hash_62a94152" );
    level flag::wait_till( "turret1_dead" );
    level scene::stop( "cin_bio_03_02_market_vign_targetkill_robot01" );
    level scene::stop( "cin_bio_03_02_market_vign_targetkill_robot02" );
    level scene::stop( "scene_turret1", "targetname" );
}

// Namespace squad_control
// Params 2
// Checksum 0x48f44ed, Offset: 0x4180
// Size: 0x1b
function robot_camo( n_camo_state, player )
{
    self endon( #"death" );
}

// Namespace squad_control
// Params 1
// Checksum 0x48af2445, Offset: 0x4260
// Size: 0x82
function update_camo_energy_hud( n_camo_pct )
{
    self endon( #"death" );
    self endon( #"end_squad_control" );
    
    if ( level.b_squad_player_controlled && isdefined( self.squad_menu ) )
    {
        self setluimenudata( self.squad_menu, "squad_camo_amount", n_camo_pct );
        str_robot_camo_energy = &"CP_MI_SING_BIODOMES_ROBOT_CAMO_ENERGY";
        self setluimenudata( self.squad_menu, "squad_camo_text", str_robot_camo_energy );
    }
}

// Namespace squad_control
// Params 0
// Checksum 0x5f703837, Offset: 0x42f0
// Size: 0x135
function robot_camo_energy_regen()
{
    self endon( #"death" );
    self.n_robot_camo_energy = 500;
    n_robot_camo_energy_pct = int( self.n_robot_camo_energy / 500 * 100 );
    
    while ( true )
    {
        if ( level.skipto_point == "objective_cloudmountain" && level.b_squad_player_controlled )
        {
            break;
        }
        
        if ( self.n_robot_camo_energy < 500 )
        {
            self.n_robot_camo_energy = self.n_robot_camo_energy + 20;
            
            if ( self.n_robot_camo_energy > 500 )
            {
                self.n_robot_camo_energy = 500;
            }
            
            n_robot_camo_energy_pct = int( self.n_robot_camo_energy / 500 * 100 );
            self thread update_camo_energy_hud( n_robot_camo_energy_pct );
        }
        
        for ( i = 0; i < self.a_robots.size ; i++ )
        {
            if ( isdefined( self.a_robots[ i ].enemy ) )
            {
                n_wait = 5;
                break;
            }
            
            n_wait = 0.5;
        }
        
        wait n_wait;
    }
}

// Namespace squad_control
// Params 1
// Checksum 0xb08ba375, Offset: 0x4430
// Size: 0x132
function robot_camo_energy_deplete( player )
{
    self endon( #"robot_camo_off" );
    self endon( #"death" );
    player endon( #"death" );
    
    if ( player.n_robot_camo_energy >= 10 )
    {
        player.n_robot_camo_energy -= 10;
        n_robot_camo_energy_pct = int( player.n_robot_camo_energy / 500 * 100 );
        player thread update_camo_energy_hud( n_robot_camo_energy_pct );
        
        while ( player.n_robot_camo_energy >= 0 )
        {
            wait 3;
            player.n_robot_camo_energy -= 5;
            
            if ( player.n_robot_camo_energy < 0 )
            {
                player.n_robot_camo_energy = 0;
                self robot_camo( 0, player );
            }
            
            n_robot_camo_energy_pct = int( player.n_robot_camo_energy / 500 * 100 );
            player thread update_camo_energy_hud( n_robot_camo_energy_pct );
        }
        
        return;
    }
    
    self thread robot_camo( 0, player );
}

// Namespace squad_control
// Params 2
// Checksum 0xce971030, Offset: 0x4570
// Size: 0x147
function squad_interaction_end( a_ai_robots, str_flag )
{
    level flag::wait_till( str_flag );
    wait 0.5;
    
    foreach ( ai_robot in a_ai_robots )
    {
        if ( isalive( ai_robot ) )
        {
            ai_robot thread util::delay( 10, "death", &util::stop_magic_bullet_shield );
            ai_robot.goalradius = 1024;
            ai_robot.ignoresuppression = 0;
            ai_robot ai::set_ignoreall( 0 );
            ai_robot ai::enable_pain();
            ai_robot.b_avail = 1;
            ai_robot.animname = undefined;
            ai_robot.str_action = "Standard";
            ai_robot notify( #"action" );
            ai_robot clearforcedgoal();
            ai_robot ai::set_behavior_attribute( "move_mode", "normal" );
        }
    }
    
    a_ai_robots = [];
}

// Namespace squad_control
// Params 3
// Checksum 0xe421d735, Offset: 0x46c0
// Size: 0x18c
function squad_attack_target( v_goal, a_targets, str_endon )
{
    self endon( #"death" );
    level endon( str_endon );
    str_msg = self util::waittill_any_timeout( 15, "goal" );
    
    if ( str_msg != "goal" )
    {
        self setgoal( self.origin, 1 );
        self waittill( #"goal" );
        self forceteleport( v_goal );
        self setgoal( v_goal, 1 );
    }
    
    if ( isarray( a_targets ) )
    {
        arraysortclosest( a_targets, self.origin );
        
        for ( i = 0; i < a_targets.size ; i++ )
        {
            if ( isalive( a_targets[ i ] ) )
            {
                self thread ai::shoot_at_target( "normal", a_targets[ i ], undefined, 3 );
                wait 3;
                
                if ( isalive( a_targets[ i ] ) )
                {
                    a_targets[ i ] kill();
                }
            }
        }
        
        return;
    }
    
    if ( isalive( a_targets ) )
    {
        self thread ai::shoot_at_target( "shoot_until_target_dead", a_targets );
        self waittill( #"stop_shoot_at_target" );
    }
}

// Namespace squad_control
// Params 2
// Checksum 0xc90d1d4b, Offset: 0x4858
// Size: 0x1aa
function robot_interact_warehouse_door( a_ai_robots, e_task )
{
    if ( isinarray( self.a_robot_tasks, e_task ) )
    {
        arrayremovevalue( self.a_robot_tasks, e_task );
    }
    
    level.ai_hendricks colors::disable();
    level.ai_hendricks notify( #"stop_following" );
    level thread squad_interaction_end( a_ai_robots, "back_door_opened" );
    level thread scene::init( "cin_bio_06_01_backdoor_vign_open_hendricks", level.ai_hendricks );
    level thread scene::init( "cin_bio_06_01_backdoor_vign_open_robot01", a_ai_robots[ 0 ] );
    level thread scene::init( "cin_bio_06_01_backdoor_vign_open_robot02", a_ai_robots[ 1 ] );
    level util::waittill_multiple_ents( level.ai_hendricks, "goal", a_ai_robots[ 0 ], "goal", a_ai_robots[ 1 ], "goal" );
    level thread warehouse_door_clip();
    level scene::play( "scene_warehouse_door", "targetname" );
    level flag::set( "back_door_opened" );
    level notify( #"open" );
    
    if ( isdefined( e_task ) )
    {
        e_task delete();
    }
    
    a_ai_robots = [];
    level flag::wait_till( "objective_warehouse_completed" );
    level thread scene::stop( "scene_warehouse_door", "targetname" );
}

// Namespace squad_control
// Params 1
// Checksum 0xfd19a5f8, Offset: 0x4a10
// Size: 0x62
function robot_waittill_goal( nd_pos )
{
    self endon( #"death" );
    self setgoal( nd_pos, 1 );
    self util::waittill_any_timeout( 20, "goal" );
    self clearforcedgoal();
    self.goalradius = 4;
    self.b_ready = 1;
}

// Namespace squad_control
// Params 0
// Checksum 0x616dac5a, Offset: 0x4a80
// Size: 0xb2
function warehouse_door_clip()
{
    level waittill( #"notetrack_warehouse_door" );
    e_player_clip = getent( "back_door_player_clip", "targetname" );
    e_player_clip delete();
    var_60f8f46f = getent( "back_door_full_clip", "targetname" );
    var_60f8f46f delete();
    var_bee08349 = getent( "back_door_no_pen_clip", "targetname" );
    var_bee08349 delete();
}

// Namespace squad_control
// Params 2
// Checksum 0xb944a494, Offset: 0x4b40
// Size: 0x2a
function task_timeout( n_wait, str_flag )
{
    level endon( str_flag );
    wait n_wait;
    level flag::set( str_flag );
}

// Namespace squad_control
// Params 2
// Checksum 0xc9dd4e15, Offset: 0x4b78
// Size: 0x3a
function robots_reached_positions( a_robots, str_flag )
{
    level endon( str_flag );
    array::wait_till( a_robots, "goal" );
    level flag::set( str_flag );
}

// Namespace squad_control
// Params 0
// Checksum 0x2bca9b58, Offset: 0x4bc0
// Size: 0x33
function monitor_squad()
{
    self endon( #"disconnect" );
    self endon( #"end_squad_control" );
    
    if ( level.b_squad_player_controlled )
    {
        self waittill( #"player_squad_dead" );
        self notify( #"end_squad_control" );
    }
}

// Namespace squad_control
// Params 0
// Checksum 0xdb5b7440, Offset: 0x4c00
// Size: 0x23d
function replenish_squad()
{
    level endon( #"back_door_opened" );
    level endon( #"hash_a68d9993" );
    self waittill( #"death" );
    arrayremovevalue( level.a_ai_squad, self );
    n_timer = randomintrange( 8, 15 );
    level util::waittill_notify_or_timeout( "spawn_friendly_robot", n_timer );
    var_63cc825f = 0;
    
    while ( var_63cc825f == 0 )
    {
        if ( !level flag::get( "back_door_opened" ) )
        {
            var_96336215 = getentarray( "friendly_robot_reinforcement", "targetname" );
            var_d5b88441 = [];
            
            foreach ( spawner in var_96336215 )
            {
                if ( level.var_996e05eb === spawner.script_noteworthy )
                {
                    array::add( var_d5b88441, spawner, 0 );
                }
            }
            
            if ( var_d5b88441.size )
            {
                var_6bafcc3 = arraygetclosest( level.players[ 0 ].origin, var_d5b88441 );
            }
            else
            {
                var_6bafcc3 = arraygetclosest( level.players[ 0 ].origin, var_96336215 );
            }
            
            if ( isdefined( var_6bafcc3 ) )
            {
                var_19ec51f9 = spawner::simple_spawn_single( var_6bafcc3 );
                
                if ( isalive( var_19ec51f9 ) )
                {
                    level robot_init( var_19ec51f9 );
                    var_19ec51f9.health = int( var_19ec51f9.health * 0.75 );
                    var_19ec51f9.n_start_health = var_19ec51f9.health;
                    var_19ec51f9.start_health = var_19ec51f9.health;
                    var_63cc825f = 1;
                }
                else
                {
                    wait 3;
                }
            }
            
            continue;
        }
        
        break;
    }
}

// Namespace squad_control
// Params 1
// Checksum 0xf66ddf98, Offset: 0x4e48
// Size: 0x64
function remove_squad_member( player )
{
    self waittill( #"death" );
    arrayremovevalue( player.a_robots, self );
    arrayremovevalue( level.a_ai_squad, self );
    
    if ( player.a_robots.size <= 0 )
    {
        player notify( #"player_squad_dead" );
    }
}

// Namespace squad_control
// Params 4
// Checksum 0xb74b91ad, Offset: 0x4eb8
// Size: 0xfc
function create_temp_icon( str_obj_type, str_obj_name, v_pos, v_offset )
{
    if ( !isdefined( v_offset ) )
    {
        v_offset = ( 0, 0, 0 );
    }
    
    switch ( str_obj_type )
    {
        case "target":
            str_shader = "waypoint_targetneutral";
            break;
        case "task":
            str_shader = "waypoint_captureneutral";
            break;
        case "goto":
            str_shader = "waypoint_circle_arrow_green";
            break;
        default:
            assertmsg( "<dev string:x31>" + str_obj_type + "<dev string:x38>" );
            break;
    }
    
    nextobjpoint = objpoints::create( str_obj_name, v_pos + v_offset, "all", str_shader, 0.75, 0.25 );
    nextobjpoint setwaypoint( 0, str_shader );
    return nextobjpoint;
}

// Namespace squad_control
// Params 0
// Checksum 0x610bd8be, Offset: 0x4fc0
// Size: 0x12
function destroy_temp_icon()
{
    objpoints::delete( self );
}

// Namespace squad_control
// Params 12
// Checksum 0xa1019ac2, Offset: 0x4fe0
// Size: 0xf1
function callback_robot_damage( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, modelindex, psoffsettime, bonename )
{
    if ( isdefined( eattacker ) && isplayer( eattacker ) )
    {
        if ( smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_EXPLOSIVE" || smeansofdeath == "MOD_EXPLOSIVE_SPLASH" || smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_PROJECTILE_SPLASH" )
        {
            return int( idamage );
        }
        else
        {
            idamage = 0;
        }
    }
    
    return int( idamage );
}

// Namespace squad_control
// Params 1
// Checksum 0xbb59e521, Offset: 0x50e0
// Size: 0x32
function groundpos_ignore_water( origin )
{
    return groundtrace( origin, origin + ( 0, 0, -100000 ), 0, undefined, 1 )[ "position" ];
}

// Namespace squad_control
// Params 0
// Checksum 0xd50d0d4b, Offset: 0x5120
// Size: 0x1a
function get_keyline_field()
{
    return "keyline_outline_p" + self getentitynumber();
}

// Namespace squad_control
// Params 0
// Checksum 0x23ebca60, Offset: 0x5148
// Size: 0x1a
function get_indicator_field()
{
    return "squad_indicator_p" + self getentitynumber();
}

// Namespace squad_control
// Params 2
// Checksum 0xdf0776ad, Offset: 0x5170
// Size: 0x4a
function enable_indicator( e_player, b_indicator )
{
    self endon( #"death" );
    str_field = e_player get_indicator_field();
    self clientfield::set( str_field, b_indicator );
}

// Namespace squad_control
// Params 3
// Checksum 0x8d40cfac, Offset: 0x51c8
// Size: 0x122
function enable_keyline( n_color_value, e_player, str_disable_notify )
{
    self endon( #"death" );
    
    if ( !isdefined( self.keyline_players ) )
    {
        self.keyline_players = [];
    }
    
    a_players = getplayers();
    
    if ( isdefined( e_player ) )
    {
        a_players = array( e_player );
        e_player endon( #"disconnect" );
    }
    
    foreach ( player in a_players )
    {
        str_field = player get_keyline_field();
        self clientfield::set( str_field, n_color_value );
        array::add( self.keyline_players, e_player, 0 );
    }
    
    self setforcenocull();
    self thread disable_keyline_on_death();
}

// Namespace squad_control
// Params 0
// Checksum 0x2165217, Offset: 0x52f8
// Size: 0x32
function disable_keyline_on_death()
{
    self notify( #"disable_keyline_on_death" );
    self endon( #"disable_keyline_on_death" );
    self waittill( #"death" );
    
    if ( isdefined( self ) )
    {
        self thread disable_keyline();
    }
}

// Namespace squad_control
// Params 1
// Checksum 0x9024628b, Offset: 0x5338
// Size: 0x10a
function disable_keyline( e_player )
{
    a_players = getplayers();
    
    if ( isdefined( e_player ) )
    {
        a_players = array( e_player );
    }
    
    if ( !isdefined( self.keyline_players ) )
    {
        self.keyline_players = [];
    }
    
    foreach ( player in a_players )
    {
        str_field = player get_keyline_field();
        self clientfield::set( str_field, 0 );
        arrayremovevalue( self.keyline_players, player, 0 );
    }
    
    if ( isdefined( self.keyline_players ) && self.keyline_players.size == 0 )
    {
        self removeforcenocull();
    }
}

