#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\debug;
#using scripts\core_common\stealth\enemy;
#using scripts\core_common\stealth\friendly;
#using scripts\core_common\stealth\group;
#using scripts\core_common\stealth\manager;
#using scripts\core_common\stealth\neutral;
#using scripts\core_common\stealth\threat_sight;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\util;

#namespace utility;

// Namespace utility/utility
// Params 2
// Checksum 0x9c3d9e1, Offset: 0x270
// Size: 0x14
function scalevolume( *ent, *vol )
{
    
}

#namespace namespace_979752dc;

// Namespace namespace_979752dc/utility
// Params 1
// Checksum 0x4d3693f8, Offset: 0x290
// Size: 0x5a
function get_group( name )
{
    if ( !isdefined( level.stealth.groupdata.groups[ name ] ) )
    {
        return undefined;
    }
    
    return level.stealth.groupdata.groups[ name ].members;
}

// Namespace namespace_979752dc/utility
// Params 2
// Checksum 0x7ebaf41, Offset: 0x2f8
// Size: 0x17c
function group_flag_clear( f, group )
{
    name = get_group_flagname( f, group );
    level flag::clear( name );
    array = level.stealth.group.flags[ f ];
    clear = 1;
    
    foreach ( value in array )
    {
        if ( !issubstr( value, "allies" ) && level flag::get( value ) )
        {
            return;
        }
    }
    
    if ( level flag::get( name ) && self != level )
    {
        self notify( f );
    }
    
    level flag::clear( f );
}

// Namespace namespace_979752dc/utility
// Params 1
// Checksum 0x15089e7d, Offset: 0x480
// Size: 0xbc
function group_flag_set( f )
{
    assert( issentient( self ), "<dev string:x38>" );
    name = self get_group_flagname( f );
    
    if ( !level flag::get( name ) && self != level )
    {
        self notify( f );
    }
    
    level flag::set( name );
    level flag::set( f );
}

// Namespace namespace_979752dc/utility
// Params 1
// Checksum 0xf995ba21, Offset: 0x548
// Size: 0x72
function group_flag( f )
{
    assert( issentient( self ), "<dev string:x38>" );
    name = self get_group_flagname( f );
    return level flag::get( name );
}

// Namespace namespace_979752dc/utility
// Params 2
// Checksum 0xc3aba208, Offset: 0x5c8
// Size: 0x7a
function get_group_flagname( f, group )
{
    if ( !isdefined( group ) )
    {
        assert( issentient( self ), "<dev string:x38>" );
        group = self.script_stealthgroup;
    }
    
    name = f + "-Group:" + group;
    return name;
}

// Namespace namespace_979752dc/utility
// Params 1
// Checksum 0x591a0ac8, Offset: 0x650
// Size: 0x44
function group_flag_wait( f )
{
    name = get_group_flagname( f );
    level flag::wait_till( name );
}

// Namespace namespace_979752dc/utility
// Params 1
// Checksum 0xc53df23, Offset: 0x6a0
// Size: 0x44
function group_flag_waitopen( f )
{
    name = get_group_flagname( f );
    level flag::wait_till_clear( name );
}

// Namespace namespace_979752dc/utility
// Params 2
// Checksum 0x59e2cfdc, Offset: 0x6f0
// Size: 0x54
function function_9b4d5512( f, timer )
{
    name = get_group_flagname( f );
    level flag::wait_till_timeout( timer, name );
}

// Namespace namespace_979752dc/utility
// Params 2
// Checksum 0x944efec1, Offset: 0x750
// Size: 0x54
function group_flag_waitopen_or_timeout( f, timer )
{
    name = get_group_flagname( f );
    level flag::wait_till_clear_timeout( timer, name );
}

// Namespace namespace_979752dc/utility
// Params 1
// Checksum 0x97896af6, Offset: 0x7b0
// Size: 0x1ba
function group_flag_init( f )
{
    assert( issentient( self ), "<dev string:x38>" );
    
    if ( isdefined( self.script_stealthgroup ) )
    {
        self.script_stealthgroup = string( self.script_stealthgroup );
    }
    else
    {
        self.script_stealthgroup = "default";
    }
    
    if ( self.team == "allies" )
    {
        self.script_stealthgroup += "allies";
    }
    
    if ( !level flag::exists( f ) )
    {
        level flag::init( f );
    }
    
    name = self get_group_flagname( f );
    
    if ( !level flag::exists( name ) )
    {
        level flag::init( name );
        
        if ( !isdefined( level.stealth.group.flags[ f ] ) )
        {
            level.stealth.group.flags[ f ] = [];
        }
        
        level.stealth.group.flags[ f ][ level.stealth.group.flags[ f ].size ] = name;
    }
    
    return name;
}

// Namespace namespace_979752dc/utility
// Params 2
// Checksum 0xd9074ece, Offset: 0x978
// Size: 0x74
function group_setcombatgoalradius( group, goalradius )
{
    assert( isdefined( level.stealth ) );
    
    if ( !isdefined( level.stealth.combat_goalradius ) )
    {
        level.stealth.combat_goalradius = [];
    }
    
    level.stealth.combat_goalradius[ group ] = goalradius;
}

// Namespace namespace_979752dc/utility
// Params 0
// Checksum 0xd7751ec, Offset: 0x9f8
// Size: 0xe2
function group_add()
{
    assert( issentient( self ), "<dev string:x38>" );
    
    if ( !isdefined( level.stealth.group.groups[ self.script_stealthgroup ] ) )
    {
        level.stealth.group.groups[ self.script_stealthgroup ] = [];
        level.stealth.group notify( self.script_stealthgroup );
    }
    
    level.stealth.group.groups[ self.script_stealthgroup ][ level.stealth.group.groups[ self.script_stealthgroup ].size ] = self;
}

// Namespace namespace_979752dc/utility
// Params 0
// Checksum 0x770d4443, Offset: 0xae8
// Size: 0x82
function group_spotted_flag()
{
    assert( self.team != "<dev string:x59>", "<dev string:x61>" );
    assert( isdefined( self.stealth.var_103386e8 ) );
    return level flag::get( self.stealth.var_103386e8 );
}

// Namespace namespace_979752dc/utility
// Params 1
// Checksum 0x13384744, Offset: 0xb78
// Size: 0x10a, Type: bool
function any_groups_in_combat( stealthgroups )
{
    if ( !level flag::get( "stealth_enabled" ) )
    {
        return false;
    }
    
    foreach ( group in level.stealth.groupdata.groups )
    {
        if ( isdefined( stealthgroups ) && !array::contains( stealthgroups, group.name ) )
        {
            continue;
        }
        
        if ( stealth_group::group_anyoneincombat( group.name ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_979752dc/utility
// Params 0
// Checksum 0xa7fd281, Offset: 0xc90
// Size: 0x82
function get_stealth_state()
{
    switch ( self.stealth.state )
    {
        case 0:
            return "normal";
        case 1:
            return "warning";
        case 2:
            return "warning";
        case 3:
            return "attack";
    }
}

// Namespace namespace_979752dc/utility
// Params 1
// Checksum 0x31799571, Offset: 0xd20
// Size: 0xa6
function set_stealth_state( msg )
{
    switch ( msg )
    {
        case #"attack":
            num = 3;
            break;
        case #"warning2":
            num = 2;
            break;
        case #"warning1":
            num = 1;
            break;
        default:
            num = 0;
            break;
    }
    
    self.stealth.state = num;
}

/#

    // Namespace namespace_979752dc/utility
    // Params 0
    // Checksum 0x252d6e94, Offset: 0xdd0
    // Size: 0x34, Type: dev
    function check_stealth()
    {
        assert( isdefined( self.stealth ), "<dev string:x93>" + self.origin );
    }

#/

// Namespace namespace_979752dc/utility
// Params 0
// Checksum 0xedc1c49f, Offset: 0xe10
// Size: 0x1f4
function alertlevel_init_map()
{
    level.stealth.alert_levels_exe = [];
    level.stealth.alert_levels_exe[ #"normal" ] = "noncombat";
    level.stealth.alert_levels_exe[ #"reset" ] = "noncombat";
    level.stealth.alert_levels_exe[ #"warning1" ] = "low_alert";
    level.stealth.alert_levels_exe[ #"warning2" ] = "high_alert";
    level.stealth.alert_levels_exe[ #"combat_hunt" ] = "high_alert";
    level.stealth.alert_levels_exe[ #"attack" ] = "combat";
    level.stealth.alert_levels_int = [];
    level.stealth.alert_levels_int[ #"normal" ] = 0;
    level.stealth.alert_levels_int[ #"reset" ] = 0;
    level.stealth.alert_levels_int[ #"warning1" ] = 2;
    level.stealth.alert_levels_int[ #"warning2" ] = 3;
    level.stealth.alert_levels_int[ #"combat_hunt" ] = 3;
    level.stealth.alert_levels_int[ #"attack" ] = 4;
    level.stealth.alert_levels_exe[ #"combat" ] = 4;
}

// Namespace namespace_979752dc/utility
// Params 1
// Checksum 0x5c1be69d, Offset: 0x1010
// Size: 0x46
function alertlevel_script_to_exe( alertlevel )
{
    if ( isdefined( level.stealth.alert_levels_exe[ alertlevel ] ) )
    {
        return level.stealth.alert_levels_exe[ alertlevel ];
    }
    
    return alertlevel;
}

// Namespace namespace_979752dc/utility
// Params 1
// Checksum 0xc5ed1193, Offset: 0x1060
// Size: 0x46
function function_7211414e( alertlevel )
{
    if ( isdefined( level.stealth.alert_levels_int[ alertlevel ] ) )
    {
        return level.stealth.alert_levels_int[ alertlevel ];
    }
    
    return -1;
}

// Namespace namespace_979752dc/utility
// Params 2
// Checksum 0xb3170fb3, Offset: 0x10b0
// Size: 0x5c
function set_detect_ranges( hidden, spotted )
{
    if ( !isdefined( hidden ) && !isdefined( spotted ) )
    {
        assertmsg( "<dev string:xc6>" );
    }
    
    stealth_manager::set_detect_ranges_internal( hidden, spotted );
}

// Namespace namespace_979752dc/utility
// Params 2
// Checksum 0xf14315e1, Offset: 0x1118
// Size: 0x206
function set_min_detect_range_darkness( hidden, spotted )
{
    if ( !isdefined( hidden ) && !isdefined( spotted ) )
    {
        assertmsg( "<dev string:xeb>" );
    }
    
    if ( isdefined( hidden ) )
    {
        level.stealth.detect.minrangedarkness[ #"hidden" ][ #"prone" ] = hidden[ #"prone" ];
        level.stealth.detect.minrangedarkness[ #"hidden" ][ #"crouch" ] = hidden[ #"crouch" ];
        level.stealth.detect.minrangedarkness[ #"hidden" ][ #"stand" ] = hidden[ #"stand" ];
    }
    
    if ( isdefined( spotted ) )
    {
        level.stealth.detect.minrangedarkness[ #"spotted" ][ #"prone" ] = spotted[ #"prone" ];
        level.stealth.detect.minrangedarkness[ #"spotted" ][ #"crouch" ] = spotted[ #"crouch" ];
        level.stealth.detect.minrangedarkness[ #"spotted" ][ #"stand" ] = spotted[ #"stand" ];
    }
}

// Namespace namespace_979752dc/utility
// Params 0
// Checksum 0xad2a4b56, Offset: 0x1328
// Size: 0xa2
function do_stealth()
{
    switch ( self.team )
    {
        case #"axis":
        case #"team3":
            self thread stealth_enemy::main();
            break;
        case #"allies":
            self thread namespace_32a4062b::main();
            break;
        case #"neutral":
            self thread namespace_578db516::main();
            break;
    }
}

// Namespace namespace_979752dc/utility
// Params 0
// Checksum 0x7e6294a7, Offset: 0x13d8
// Size: 0x180
function save_last_goal()
{
    if ( isdefined( self.stealth.last_goal ) )
    {
        return "exists";
    }
    
    result = "goal";
    self.saved_script_forcegoal = self.script_forcegoal;
    
    if ( isdefined( self.last_set_goalnode ) )
    {
        self.stealth.last_goal = self.last_set_goalnode;
    }
    else if ( isdefined( self.last_set_goalent ) )
    {
        self.stealth.last_goal = self.last_set_goalent.origin;
    }
    else if ( isdefined( self.last_set_goalpos ) )
    {
        self.stealth.last_goal = self.last_set_goalpos;
    }
    else if ( isdefined( self.go_to_node ) )
    {
        self.stealth.last_goal = self spawner::function_461ce3e9();
        result = "go_to_node";
    }
    else
    {
        self.stealth.last_goal = spawnstruct();
        self.stealth.last_goal.origin = self.origin;
        self.stealth.last_goal.angles = self.angles;
    }
    
    if ( isdefined( self.stealth.last_goal ) )
    {
        return result;
    }
    
    return undefined;
}

/#

    // Namespace namespace_979752dc/utility
    // Params 1
    // Checksum 0x4c88a915, Offset: 0x1560
    // Size: 0x2c, Type: dev
    function set_patrol_move_loop_anim( *animoverride )
    {
        assertmsg( "<dev string:x110>" );
    }

#/

// Namespace namespace_979752dc/utility
// Params 1
// Checksum 0xaaff83e7, Offset: 0x1598
// Size: 0x5c
function set_default_patrol_style( style )
{
    self.stealth.default_patrol_style = style;
    
    if ( isdefined( self.stealth.default_patrol_style ) )
    {
        self set_patrol_style( self.stealth.default_patrol_style );
    }
}

// Namespace namespace_979752dc/utility
// Params 1
// Checksum 0xae68ade7, Offset: 0x1600
// Size: 0x8c
function get_patrol_react_magnitude_int( style )
{
    switch ( style )
    {
        case #"small":
            return 0;
        case #"small_medium":
            return 1;
        case #"medium":
            return 2;
        case #"large":
            return 3;
    }
    
    assertmsg( "<dev string:x135>" );
}

// Namespace namespace_979752dc/utility
// Params 4
// Checksum 0x48b5ef00, Offset: 0x1698
// Size: 0x1b4
function set_patrol_style( style, allowreact, reactposition, magnitude )
{
    if ( style == "unaware" )
    {
        style = "patrol";
    }
    
    var_70fd8440 = -1;
    
    /#
        var_70fd8440 = getdvarint( #"hash_4aa9c88072661ef2", -1 );
    #/
    
    if ( var_70fd8440 < 0 )
    {
        self ai::set_behavior_attribute( "demeanor", style );
    }
    
    self.stealth.var_458bda8 = style;
    
    if ( style == "patrol" || style == "alert" )
    {
        var_39dc2c21 = 1 / 999;
        self function_678d90a1( var_39dc2c21 );
    }
    else
    {
        self function_94575fdf();
    }
    
    if ( style == "cqb" )
    {
        var_68c74e4f = 60;
        
        if ( isdefined( self.stealth.hunt_speed ) )
        {
            var_68c74e4f = self.stealth.hunt_speed;
        }
        
        self set_movement_speed( var_68c74e4f );
    }
    
    if ( is_true( allowreact ) )
    {
        self set_patrol_react( reactposition, magnitude );
    }
}

// Namespace namespace_979752dc/utility
// Params 0
// Checksum 0xeb910462, Offset: 0x1858
// Size: 0x32
function get_patrol_style()
{
    assert( isdefined( self.stealth ) );
    return self.stealth.var_458bda8;
}

// Namespace namespace_979752dc/utility
// Params 0
// Checksum 0x1212149e, Offset: 0x1898
// Size: 0x3e
function get_patrol_style_default()
{
    default_patrol_style = self.stealth.default_patrol_style;
    
    if ( !isdefined( default_patrol_style ) )
    {
        default_patrol_style = level.stealth.default_patrol_style;
    }
    
    return default_patrol_style;
}

// Namespace namespace_979752dc/utility
// Params 1
// Checksum 0x2fdd8d35, Offset: 0x18e0
// Size: 0x76
function function_2b21025e( position )
{
    if ( !isdefined( self.stealth.var_d54b515e ) )
    {
        self.stealth.var_d54b515e = spawnstruct();
    }
    
    self.stealth.var_d54b515e.position = position;
    self.stealth.var_d54b515e.settime = gettime();
}

// Namespace namespace_979752dc/utility
// Params 1
// Checksum 0x3e6e1e5, Offset: 0x1960
// Size: 0xc2, Type: bool
function function_b0c91323( var_affacce = 0 )
{
    if ( !isdefined( self.stealth.var_d54b515e.position ) )
    {
        return false;
    }
    
    currenttime = gettime();
    
    if ( currenttime > self.stealth.var_d54b515e.settime + 100 )
    {
        return false;
    }
    
    if ( var_affacce )
    {
        if ( isdefined( self.stealth.var_d54b515e.processtime ) && currenttime == self.stealth.var_d54b515e.processtime )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace namespace_979752dc/utility
// Params 0
// Checksum 0x7b85716f, Offset: 0x1a30
// Size: 0x1e
function function_ab75abf3()
{
    self.stealth.var_d54b515e.processtime = gettime();
}

// Namespace namespace_979752dc/utility
// Params 2
// Checksum 0xec2398e5, Offset: 0x1a58
// Size: 0x204
function set_patrol_react( position, magnitude )
{
    if ( isdefined( self.stealth.var_5cc4aa60 ) && self.stealth.var_5cc4aa60 > gettime() )
    {
        return;
    }
    
    if ( isdefined( self.stealth.breacting ) )
    {
        if ( get_patrol_react_magnitude_int( self.stealth.breacting ) >= get_patrol_react_magnitude_int( magnitude ) )
        {
            return;
        }
    }
    
    assert( magnitude == "<dev string:x15d>" || magnitude == "<dev string:x166>" || magnitude == "<dev string:x176>" || magnitude == "<dev string:x180>" );
    
    if ( self.alertlevel == "combat" && magnitude != "large" )
    {
        magnitude = "large";
    }
    
    self.stealth.patrol_react_magnitude = magnitude;
    self.stealth.patrol_react_pos = position;
    self.stealth.patrol_react_time = gettime();
    self.stealth.var_527ef51c = self haspath();
    
    if ( self isinscriptedstate() && is_true( self._scene_object._s.stealthreact ) )
    {
        thread [[ self._scene_object ]]->stop( 0 );
    }
    
    self setblackboardattribute( "_react_magnitude", self.stealth.patrol_react_magnitude );
}

// Namespace namespace_979752dc/utility
// Params 3
// Checksum 0x37d314b6, Offset: 0x1c68
// Size: 0x180
function set_goal( goal, faceangles, goalradius = 16 )
{
    result = 1;
    
    if ( self flag::get( "stealth_goal_override" ) )
    {
        return;
    }
    
    self.keepclaimednode = 0;
    self.keepclaimednodeifvalid = 0;
    
    if ( isdefined( faceangles ) )
    {
        goalstruct = spawnstruct();
        
        if ( isvec( goal ) )
        {
            goalstruct.origin = goal;
        }
        else
        {
            goalstruct.origin = goal.origin;
        }
        
        goalstruct.angles = faceangles;
        goal = goalstruct;
    }
    
    self setgoal( goal );
    
    if ( ispathnode( goal ) )
    {
        result = self usecovernode( goal );
    }
    else
    {
        self usecovernode( undefined );
    }
    
    if ( goalradius <= 0 )
    {
        goalradius = undefined;
    }
    
    self set_goal_radius( goalradius );
    return result;
}

// Namespace namespace_979752dc/utility
// Params 1
// Checksum 0x89d3e52e, Offset: 0x1df0
// Size: 0x6c
function set_goal_radius( newradius )
{
    if ( isdefined( newradius ) )
    {
        self val::set( #"stealth", "goalradius", newradius );
        return;
    }
    
    self val::reset( #"stealth", "goalradius" );
}

// Namespace namespace_979752dc/utility
// Params 1
// Checksum 0xf149d0de, Offset: 0x1e68
// Size: 0x1b2
function alert_delay_distance_time( other )
{
    maxwait = 2;
    
    if ( isdefined( self.stealth.maxalertdelay ) )
    {
        maxwait = self.stealth.maxalertdelay;
    }
    
    if ( self [[ self.fnisinstealthinvestigate ]]() )
    {
        maxwait = min( 1.5, maxwait );
    }
    else if ( self [[ self.fnisinstealthhunt ]]() )
    {
        maxwait = min( 1, maxwait );
    }
    
    var_fc45584 = 0.1;
    minwait = 0.4;
    mindist = 64;
    maxdist = 1024;
    dist2d = distance2d( self.origin, other.origin );
    
    if ( dist2d < mindist )
    {
        timefactor = mapfloat( 0, mindist, 0, mindist, dist2d );
        waittime = lerpfloat( var_fc45584, minwait, timefactor );
    }
    else
    {
        timefactor = mapfloat( mindist, maxdist, mindist, maxdist, dist2d );
        waittime = lerpfloat( minwait, maxwait, timefactor );
    }
    
    return waittime;
}

// Namespace namespace_979752dc/utility
// Params 1
// Checksum 0xed3fada2, Offset: 0x2028
// Size: 0x3a
function set_path_dist( ent )
{
    ent.distsqrd = get_path_dist_sq( self.origin, ent.origin, self );
}

// Namespace namespace_979752dc/utility
// Params 3
// Checksum 0x8855426c, Offset: 0x2070
// Size: 0xb4
function get_path_dist_sq( from, to, var_58924346 )
{
    path = self findpath( from, to );
    
    if ( isdefined( var_58924346 ) )
    {
        var_58924346.path = path;
    }
    
    distsq = 0;
    
    for ( i = 1; i < path.size ; i++ )
    {
        distsq += distancesquared( path[ i - 1 ], path[ i ] );
    }
    
    return distsq;
}

// Namespace namespace_979752dc/utility
// Params 0
// Checksum 0x2dcb5838, Offset: 0x2130
// Size: 0x16
function remove_path_dist()
{
    self.path = undefined;
    self.distsqrd = undefined;
}

// Namespace namespace_979752dc/utility
// Params 1
// Checksum 0xfdc75a51, Offset: 0x2150
// Size: 0xc6
function is_visible( other )
{
    if ( isplayer( self ) )
    {
        if ( util::within_fov( self.origin, self.angles, other.origin, 0.766 ) )
        {
            if ( isdefined( other.tagging_visible ) || self tagging_shield() )
            {
                return 1;
            }
            
            if ( util::can_see_ai( self, other, 250 ) )
            {
                return 1;
            }
        }
    }
    else
    {
        return self cansee( other );
    }
    
    return 0;
}

// Namespace namespace_979752dc/utility
// Params 0
// Checksum 0x75f2c6c, Offset: 0x2220
// Size: 0x38, Type: bool
function tagging_shield()
{
    return isdefined( self.offhandshield ) && isdefined( self.offhandshield.active ) && self.offhandshield.active;
}

// Namespace namespace_979752dc/utility
// Params 0
// Checksum 0x1871f882, Offset: 0x2260
// Size: 0x9a
function getcorpseorigin()
{
    if ( isdefined( level.stealth ) )
    {
        if ( isdefined( level.stealth.additional_corpse ) && isdefined( level.stealth.additional_corpse[ self getentitynumber() ] ) )
        {
            return self.origin;
        }
        
        if ( isdefined( level.stealth.fngetcorpseorigin ) )
        {
            return [[ level.stealth.fngetcorpseorigin ]]();
        }
    }
    
    return self.origin;
}

// Namespace namespace_979752dc/utility
// Params 1
// Checksum 0x3d66853d, Offset: 0x2308
// Size: 0x50
function setbattlechatter( state )
{
    if ( isdefined( level.stealth ) && isdefined( level.stealth.fnsetbattlechatter ) )
    {
        return [[ level.stealth.fnsetbattlechatter ]]( state );
    }
}

// Namespace namespace_979752dc/utility
// Params 6
// Checksum 0x2a799641, Offset: 0x2360
// Size: 0x88
function function_f5f4416f( eventaction, eventtype, modifier, delay, eventstruct, force )
{
    if ( isdefined( level.stealth ) && isdefined( level.stealth.fnaddeventplaybcs ) )
    {
        [[ level.stealth.fnaddeventplaybcs ]]( eventaction, eventtype, modifier, delay, eventstruct, force, 1 );
    }
}

// Namespace namespace_979752dc/utility
// Params 6
// Checksum 0x542c1011, Offset: 0x23f0
// Size: 0x84
function addeventplaybcs( eventaction, eventtype, modifier, delay, eventstruct, force )
{
    if ( isdefined( level.stealth ) && isdefined( level.stealth.fnaddeventplaybcs ) )
    {
        [[ level.stealth.fnaddeventplaybcs ]]( eventaction, eventtype, modifier, delay, eventstruct, force, 0 );
    }
}

// Namespace namespace_979752dc/utility
// Params 2
// Checksum 0xf5e01ced, Offset: 0x2480
// Size: 0x204
function stealth_music( musichidden, musicspotted )
{
    self notify( #"stealth_music" );
    self endon( #"stealth_music" );
    self thread stealth_music_pause_monitor();
    
    while ( true )
    {
        level flag::wait_till( "stealth_enabled" );
        level flag::wait_till_clear( "stealth_spotted" );
        level flag::wait_till_clear( "stealth_music_pause" );
        
        foreach ( player in getplayers() )
        {
            player thread stealth_music_transition( musichidden );
        }
        
        level flag::wait_till( "stealth_spotted" );
        level flag::wait_till_clear( "stealth_music_pause" );
        
        foreach ( player in getplayers() )
        {
            player thread stealth_music_transition( musicspotted );
        }
    }
}

// Namespace namespace_979752dc/utility
// Params 0
// Checksum 0xf7f16d2c, Offset: 0x2690
// Size: 0xb8
function stealth_music_stop()
{
    self notify( #"stealth_music" );
    self notify( #"stealth_music_pause_monitor" );
    
    foreach ( player in getplayers() )
    {
        player thread stealth_music_transition( undefined );
    }
}

// Namespace namespace_979752dc/utility
// Params 2
// Checksum 0xcde167a9, Offset: 0x2750
// Size: 0x23c
function stealth_music_pause_monitor( musichidden, musicspotted )
{
    self notify( #"stealth_music_pause_monitor" );
    self endon( #"stealth_music_pause_monitor" );
    
    while ( true )
    {
        level flag::wait_till( "stealth_music_pause" );
        
        foreach ( player in getplayers() )
        {
            player thread stealth_music_transition( undefined );
        }
        
        level flag::wait_till_clear( "stealth_music_pause" );
        
        if ( level flag::get( "stealth_spotted" ) )
        {
            foreach ( player in getplayers() )
            {
                player thread stealth_music_transition( musicspotted );
            }
            
            continue;
        }
        
        foreach ( player in getplayers() )
        {
            player thread stealth_music_transition( musichidden );
        }
    }
}

// Namespace namespace_979752dc/utility
// Params 1
// Checksum 0x8e7b1977, Offset: 0x2998
// Size: 0x28
function stealth_music_transition( aliasto )
{
    if ( isdefined( self.fnstealthmusictransition ) )
    {
        return [[ self.fnstealthmusictransition ]]( aliasto );
    }
}

// Namespace namespace_979752dc/utility
// Params 0
// Checksum 0x75885126, Offset: 0x29c8
// Size: 0x20
function update_light_meter()
{
    if ( isdefined( self.fnupdatelightmeter ) )
    {
        return [[ self.fnupdatelightmeter ]]();
    }
}

// Namespace namespace_979752dc/utility
// Params 1
// Checksum 0xc9ba2ab5, Offset: 0x29f0
// Size: 0x40
function set_disguised( disguised )
{
    if ( isdefined( level.stealth.fnsetdisguised ) )
    {
        self [[ level.stealth.fnsetdisguised ]]( disguised );
    }
}

// Namespace namespace_979752dc/utility
// Params 1
// Checksum 0x47ddff15, Offset: 0x2a38
// Size: 0x350
function set_disguised_default( disguised = 0 )
{
    if ( disguised )
    {
        level.stealth.disguised = 1;
        level.stealth.threatsightratescale = 0.5;
        level.stealth.threatsightdistscale = 0.5;
        level.stealth.proximity_combat_radius_bump = 0;
        level.stealth.proximity_combat_radius_sight = 0;
        level.stealth.proximity_combat_radius_fake_sight = 0;
        setsaveddvar( #"hash_12c53cd4a01caff3", 0.25 );
        setsaveddvar( #"hash_5edb3c8437c5990e", cos( 90 ) );
        setsaveddvar( #"hash_30eedc859ec98ad", 0.025 );
        setsaveddvar( #"hash_5aaea648688ff01e", 0.25 );
    }
    else
    {
        level.stealth.disguised = undefined;
        level.stealth.threatsightratescale = undefined;
        level.stealth.threatsightdistscale = undefined;
        level.stealth.proximity_combat_radius_bump = 100;
        level.stealth.proximity_combat_radius_sight = 150;
        level.stealth.proximity_combat_radius_fake_sight = 60;
        setsaveddvar( #"hash_12c53cd4a01caff3", 0.5 );
        setsaveddvar( #"hash_5edb3c8437c5990e", cos( 180 ) );
        setsaveddvar( #"hash_30eedc859ec98ad", 0.01 );
        setsaveddvar( #"hash_5aaea648688ff01e", 0.1 );
    }
    
    ailist = getactorarray();
    
    foreach ( ai in ailist )
    {
        if ( !isalive( ai ) )
        {
            continue;
        }
        
        if ( isdefined( ai.stealth ) && isdefined( ai.stealth.threat_sight_state ) )
        {
            ai stealth_threat_sight::threat_sight_set_state_parameters();
        }
    }
}

// Namespace namespace_979752dc/utility
// Params 1
// Checksum 0x8b286d36, Offset: 0x2d90
// Size: 0x14a
function stealth_override_goal( override )
{
    assert( isdefined( self.stealth ) );
    
    if ( !isdefined( override ) )
    {
        override = 0;
    }
    
    if ( override )
    {
        self.remove_from_animloop = 1;
        self flag::set( "stealth_override_goal" );
        self stealth_enemy::set_blind( 0 );
        self.last_set_goalent = undefined;
    }
    else
    {
        self flag::clear( "stealth_override_goal" );
    }
    
    if ( override )
    {
        var_29020f90 = self spawner::function_461ce3e9();
        
        if ( !isdefined( self.stealth.var_29020f90 ) )
        {
            self.stealth.var_29020f90 = var_29020f90;
        }
        
        return;
    }
    
    if ( isdefined( self.stealth.var_29020f90 ) )
    {
        self thread spawner::go_to_node( self.stealth.var_29020f90 );
        self.stealth.var_29020f90 = undefined;
    }
}

// Namespace namespace_979752dc/utility
// Params 0
// Checksum 0x16259dca, Offset: 0x2ee8
// Size: 0x44, Type: bool
function stealth_behavior_active()
{
    return self flag::exists( "stealth_override_goal" ) && self flag::get( "stealth_override_goal" );
}

// Namespace namespace_979752dc/utility
// Params 0
// Checksum 0x1142d2e2, Offset: 0x2f38
// Size: 0x3c
function stealth_behavior_wait()
{
    if ( self stealth_behavior_active() )
    {
        self flag::wait_till_clear( "stealth_override_goal" );
    }
}

// Namespace namespace_979752dc/utility
// Params 0
// Checksum 0x9197d11b, Offset: 0x2f80
// Size: 0x1bc
function disable_stealth_system()
{
    level flag::clear( "stealth_enabled" );
    ais = getactorteamarray( "axis", "allies", "team3", "neutral" );
    
    foreach ( ai in ais )
    {
        ai enable_stealth_for_ai( 0 );
    }
    
    foreach ( player in getplayers() )
    {
        player.maxvisibledist = 8192;
        
        if ( player flag::exists( "stealth_enabled" ) )
        {
            player flag::wait_till_clear( "stealth_enabled" );
        }
    }
    
    stealth_manager::event_change( "spotted" );
}

// Namespace namespace_979752dc/utility
// Params 0
// Checksum 0xa8c4f1d0, Offset: 0x3148
// Size: 0x180
function enable_stealth_system()
{
    level flag::set( "stealth_enabled" );
    ais = getaiarray();
    
    foreach ( ai in ais )
    {
        ai enable_stealth_for_ai( 1 );
    }
    
    foreach ( player in getplayers() )
    {
        if ( player flag::exists( "stealth_enabled" ) )
        {
            player flag::set( "stealth_enabled" );
        }
    }
}

// Namespace namespace_979752dc/utility
// Params 2
// Checksum 0xe5e2f12c, Offset: 0x32d0
// Size: 0x1fc
function enable_stealth_for_ai( enabled, var_6f52290c = 0 )
{
    if ( !enabled )
    {
        self.maxvisibledist = 8192;
        
        if ( self flag::exists( "stealth_enabled" ) && self flag::get( "stealth_enabled" ) && self.team == "axis" )
        {
            player = getplayers()[ 0 ];
            dummyevent = spawnstruct();
            dummyevent.origin = player.origin;
            dummyevent.investigate_point = player.origin;
            dummyevent.investigate_pos = player.origin;
            dummyevent.type = "combat";
            dummyevent.typeorig = "attack";
            
            if ( var_6f52290c )
            {
                dummyevent.entity = player;
            }
            
            self.dontevershoot = 0;
            self.dontattackme = 0;
            self stealth_enemy::bt_event_combat( dummyevent );
            stealth_group::function_b6ebd4af( self );
            self stealth_threat_sight::function_60514e0b();
        }
    }
    
    if ( self flag::exists( "stealth_enabled" ) )
    {
        if ( enabled )
        {
            self flag::set( "stealth_enabled" );
            return;
        }
        
        self flag::clear( "stealth_enabled" );
    }
}

// Namespace namespace_979752dc/utility
// Params 1
// Checksum 0xabb497ce, Offset: 0x34d8
// Size: 0xb4
function custom_state_functions( array )
{
    assert( !isdefined( self.stealth ), "<dev string:x189>" );
    
    if ( isdefined( array[ #"spotted" ] ) )
    {
        self.stealth_state_func[ #"spotted" ] = array[ #"spotted" ];
    }
    
    if ( isdefined( array[ #"hidden" ] ) )
    {
        self.stealth_state_func[ #"hidden" ] = array[ #"hidden" ];
    }
}

// Namespace namespace_979752dc/utility
// Params 2
// Checksum 0x2035edec, Offset: 0x3598
// Size: 0x28
function set_stealth_func( type, func )
{
    self.stealth.funcs[ type ] = func;
}

// Namespace namespace_979752dc/utility
// Params 2
// Checksum 0xd89ac85c, Offset: 0x35c8
// Size: 0x64
function set_event_override( eventtype, funcoverride )
{
    if ( isdefined( eventtype ) && isdefined( self.stealth ) && isdefined( self.stealth.funcs ) )
    {
        self.stealth.funcs[ "event_" + eventtype ] = funcoverride;
    }
}

// Namespace namespace_979752dc/utility
// Params 1
// Checksum 0x64dbfe1b, Offset: 0x3638
// Size: 0x58
function function_bc54026c( eventtype )
{
    if ( isdefined( eventtype ) && isdefined( self.stealth ) && isdefined( self.stealth.funcs ) )
    {
        self.stealth.funcs[ "event_" + eventtype ] = undefined;
    }
}

// Namespace namespace_979752dc/utility
// Params 0
// Checksum 0xa3989192, Offset: 0x3698
// Size: 0x58, Type: bool
function bcisincombat()
{
    self endon( #"death" );
    
    if ( !isdefined( self.fnisinstealthcombat ) || self [[ self.fnisinstealthcombat ]]() )
    {
        return true;
    }
    
    if ( !isdefined( self.stealth ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_979752dc/utility
// Params 0
// Checksum 0xaf345432, Offset: 0x36f8
// Size: 0x2e, Type: bool
function function_2baa2568()
{
    if ( level flag::get( "stealth_spotted" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_979752dc/utility
// Params 2
// Checksum 0xb399354, Offset: 0x3730
// Size: 0x88
function waittill_true_goal( origin, radius )
{
    self endon( #"death" );
    
    if ( !isdefined( radius ) )
    {
        radius = self.goalradius;
    }
    
    while ( true )
    {
        self waittill( #"goal" );
        
        if ( distance( self.origin, origin ) < radius + 10 )
        {
            break;
        }
    }
}

// Namespace namespace_979752dc/utility
// Params 0
// Checksum 0x95ae78d, Offset: 0x37c0
// Size: 0x46
function function_133b86af()
{
    result = getclosestpointonnavmesh( self.origin, 500, 16 );
    
    if ( !isdefined( result ) )
    {
        result = self.origin;
    }
    
    return result;
}

// Namespace namespace_979752dc/utility
// Params 0
// Checksum 0xe31484e0, Offset: 0x3810
// Size: 0x4a
function assign_unique_id()
{
    if ( !isdefined( level.ai_number ) )
    {
        level.ai_number = 0;
    }
    
    self.unique_id = "ai" + level.ai_number;
    level.ai_number++;
    return self.unique_id;
}

// Namespace namespace_979752dc/utility
// Params 1
// Checksum 0xcc8aa433, Offset: 0x3868
// Size: 0x24
function set_movement_speed( desiredspeed )
{
    self setdesiredspeed( desiredspeed );
}

// Namespace namespace_979752dc/utility
// Params 0
// Checksum 0xdd8a6902, Offset: 0x3898
// Size: 0x1c
function clear_movement_speed()
{
    self function_9ae1c50();
}

// Namespace namespace_979752dc/utility
// Params 0
// Checksum 0x4088bd5c, Offset: 0x38c0
// Size: 0x52
function ignore_corpse()
{
    waitresult = self waittill( #"actor_corpse" );
    
    if ( isdefined( waitresult.corpse ) )
    {
        waitresult.corpse.found = 1;
    }
}

// Namespace namespace_979752dc/utility
// Params 0
// Checksum 0xffaedef5, Offset: 0x3920
// Size: 0x12
function function_bf1fb16f()
{
    self.fovcosinez = 0;
}

