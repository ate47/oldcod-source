#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\values_shared;

#namespace zombie_horde;

// Namespace zombie_horde/zombie_horde
// Params 0, eflags: 0x6
// Checksum 0xcf080855, Offset: 0xe8
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"zombie_horde", &preinit, undefined, undefined, undefined );
}

// Namespace zombie_horde/zombie_horde
// Params 0, eflags: 0x4
// Checksum 0x80da250, Offset: 0x130
// Size: 0x3c
function private preinit()
{
    level.var_e051b3bc = [];
    thread think();
    
    /#
        thread debug();
    #/
}

/#

    // Namespace zombie_horde/zombie_horde
    // Params 0, eflags: 0x4
    // Checksum 0x78803c49, Offset: 0x178
    // Size: 0x2c2, Type: dev
    function private debug()
    {
        while ( true )
        {
            foreach ( horde in level.var_e051b3bc )
            {
                recordcircle( horde.origin, horde.radius, ( 0, 0, 1 ), "<dev string:x38>" );
                recordcircle( horde.origin, 20, ( 0, 0, 1 ), "<dev string:x38>" );
                
                foreach ( var_812bc6e0 in horde.goal_points )
                {
                    recordline( horde.origin, var_812bc6e0.origin, ( 0, 1, 0 ), "<dev string:x38>" );
                    recordcircle( var_812bc6e0.origin, 20, ( 0, 1, 0 ), "<dev string:x38>" );
                }
                
                if ( isdefined( horde.path ) )
                {
                    for ( i = 0; i < horde.path.pathpoints.size - 1 ; i++ )
                    {
                        point = horde.path.pathpoints[ i ];
                        next_point = horde.path.pathpoints[ i + 1 ];
                        recordline( point, next_point, ( 1, 0, 0 ), "<dev string:x38>" );
                        recordcircle( point, 20, ( 1, 0, 0 ), "<dev string:x38>" );
                    }
                    
                    point = horde.path.pathpoints[ i ];
                    recordcircle( point, 20, ( 1, 0, 0 ), "<dev string:x38>" );
                }
            }
            
            waitframe( 1 );
        }
    }

#/

// Namespace zombie_horde/zombie_horde
// Params 4
// Checksum 0x164e394f, Offset: 0x448
// Size: 0xa4
function function_86d29fe1( var_f9289185, origin, angles, radius )
{
    horde = { #name:var_f9289185, #origin:origin, #angles:angles, #radius:radius, #path:undefined, #var_91fc28f4:-1, #at_goal:0 };
    return horde;
}

// Namespace zombie_horde/zombie_horde
// Params 1, eflags: 0x4
// Checksum 0xd057bcbe, Offset: 0x4f8
// Size: 0x292
function private function_88b2dd98( numpoints )
{
    goal_points = [];
    
    for ( i = 0; i < numpoints ; i++ )
    {
        point_found = 0;
        attempts = 0;
        var_812bc6e0 = spawnstruct();
        
        while ( !point_found && attempts < 10 )
        {
            spawn_angle = randomint( 360 );
            var_e294ac7d = randomfloat( 1 );
            var_e294ac7d = sqrt( var_e294ac7d );
            spawn_radius = int( var_e294ac7d * self.radius );
            spawnx = self.origin[ 0 ] + spawn_radius * cos( spawn_angle );
            spawny = self.origin[ 1 ] + spawn_radius * sin( spawn_angle );
            spawnz = self.origin[ 2 ];
            var_812bc6e0.origin = ( spawnx, spawny, spawnz );
            point_found = 1;
            
            foreach ( var_a4e6f42c in goal_points )
            {
                if ( distance2dsquared( var_812bc6e0.origin, var_a4e6f42c.origin ) < 2500 )
                {
                    point_found = 0;
                }
            }
            
            attempts++;
        }
        
        var_812bc6e0.zombie = undefined;
        var_812bc6e0.offset = self.origin - var_812bc6e0.origin;
        goal_points[ i ] = var_812bc6e0;
    }
    
    self.goal_points = goal_points;
}

// Namespace zombie_horde/zombie_horde
// Params 5
// Checksum 0xfb7cf904, Offset: 0x798
// Size: 0x18c
function function_11280436( var_f9289185, origin, angles, radius, var_aae3fc82 )
{
    horde = function_86d29fe1( var_f9289185, origin, angles, radius );
    horde function_88b2dd98( var_aae3fc82 );
    
    for ( i = 0; i < horde.goal_points.size ; i++ )
    {
        var_812bc6e0 = horde.goal_points[ i ];
        spawn_angles = ( 0, randomint( 360 ), 0 );
        zombie = spawnactor( "spawner_boct_zombie_wz", var_812bc6e0.origin, spawn_angles, "radial_zombie" );
        zombie.variant_type = randomint( level.var_9ee73630[ zombie.zombie_move_speed ][ zombie.zombie_arms_position ] );
        zombie.ignoreall = 1;
        zombie pathmode( "dont move", 1 );
        var_812bc6e0.zombie = zombie;
    }
    
    level.var_e051b3bc[ level.var_e051b3bc.size ] = horde;
}

// Namespace zombie_horde/zombie_horde
// Params 0, eflags: 0x4
// Checksum 0xecd56952, Offset: 0x930
// Size: 0x110
function private think()
{
    while ( true )
    {
        for ( i = 0; i < level.var_e051b3bc.size ; i++ )
        {
            horde = level.var_e051b3bc[ i ];
            var_71890760 = horde function_8ac809ae();
            
            if ( !var_71890760 )
            {
                horde function_e20d964f();
                i--;
                continue;
            }
            
            if ( isdefined( horde.path ) )
            {
                horde function_3e88b567();
                horde function_18ca9034();
                continue;
            }
            
            if ( horde.at_goal == 1 )
            {
                horde function_684b4879();
            }
        }
        
        wait 0.2;
    }
}

// Namespace zombie_horde/zombie_horde
// Params 0, eflags: 0x4
// Checksum 0x1c39febc, Offset: 0xa48
// Size: 0x152
function private function_3e88b567()
{
    goal = self.path.pathpoints[ self.var_91fc28f4 ];
    
    if ( distancesquared( self.origin, goal ) < 100 )
    {
        self.var_91fc28f4++;
        
        if ( !isdefined( self.path.pathpoints[ self.var_91fc28f4 ] ) )
        {
            self.path = undefined;
            self.var_91fc28f4 = -1;
            self.origin = goal;
            self.at_goal = 1;
            return;
        }
        
        goal = self.path.pathpoints[ self.var_91fc28f4 ];
    }
    
    move_direction = vectornormalize( goal - self.origin );
    velocity = move_direction * 10;
    self.origin += velocity;
    self.origin = getclosestpointonnavmesh( self.origin, 200, 32 );
    self.angles = vectortoangles( move_direction );
}

// Namespace zombie_horde/zombie_horde
// Params 0, eflags: 0x4
// Checksum 0x14c5189c, Offset: 0xba8
// Size: 0x1d0
function private function_18ca9034()
{
    foreach ( var_812bc6e0 in self.goal_points )
    {
        var_812bc6e0.origin = getclosestpointonnavmesh( self.origin - var_812bc6e0.offset, 200, 32 );
        zombie = var_812bc6e0.zombie;
        
        if ( !isdefined( zombie ) || !isalive( zombie ) )
        {
            continue;
        }
        
        if ( !zombie.allowoffnavmesh )
        {
            zombie function_d1e55248( #"zombie_moving", 1 );
        }
        
        zombie function_a57c34b7( var_812bc6e0.origin );
        distancetogoalsq = distance2dsquared( var_812bc6e0.origin, zombie.origin );
        
        if ( distancetogoalsq > 40000 || zombie.zombie_move_speed == "sprint" && distancetogoalsq > 6400 )
        {
            zombie function_9758722( "sprint" );
            continue;
        }
        
        zombie function_9758722( "walk" );
    }
}

// Namespace zombie_horde/zombie_horde
// Params 1
// Checksum 0xeae9779e, Offset: 0xd80
// Size: 0xd2
function function_9defb9e0( goal )
{
    path = generatenavmeshpath( self.origin, goal, undefined, self.radius, 100 );
    
    if ( !isdefined( path ) )
    {
        return;
    }
    
    self.path = path;
    self.var_91fc28f4 = 0;
    var_bdd8bda9 = self.path.pathpoints[ 1 ];
    
    if ( !isdefined( var_bdd8bda9 ) )
    {
        return;
    }
    
    move_direction = vectornormalize( var_bdd8bda9 - self.origin );
    self.angles = vectortoangles( move_direction );
}

// Namespace zombie_horde/zombie_horde
// Params 1
// Checksum 0xb9820374, Offset: 0xe60
// Size: 0xb2
function function_9758722( speed )
{
    if ( self.zombie_move_speed === speed )
    {
        return;
    }
    
    self.zombie_move_speed = speed;
    
    if ( !isdefined( self.zombie_arms_position ) )
    {
        self.zombie_arms_position = math::cointoss() == 1 ? "up" : "down";
    }
    
    if ( isdefined( level.var_9ee73630 ) )
    {
        self.variant_type = randomint( level.var_9ee73630[ self.zombie_move_speed ][ self.zombie_arms_position ] );
    }
}

// Namespace zombie_horde/zombie_horde
// Params 0, eflags: 0x4
// Checksum 0x6b76cae6, Offset: 0xf20
// Size: 0xac, Type: bool
function private function_8ac809ae()
{
    foreach ( point in self.goal_points )
    {
        zombie = point.zombie;
        
        if ( isdefined( zombie ) && isalive( zombie ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zombie_horde/zombie_horde
// Params 0
// Checksum 0x6d8c805, Offset: 0xfd8
// Size: 0x94
function function_e20d964f()
{
    foreach ( point in self.goal_points )
    {
        point = undefined;
    }
    
    arrayremovevalue( level.var_e051b3bc, self );
}

// Namespace zombie_horde/zombie_horde
// Params 2, eflags: 0x4
// Checksum 0xc734d9e1, Offset: 0x1078
// Size: 0x7c
function private function_d1e55248( id, value )
{
    if ( is_true( value ) )
    {
        self val::set( id, "allowoffnavmesh", 1 );
        return;
    }
    
    self val::reset( id, "allowoffnavmesh" );
}

// Namespace zombie_horde/zombie_horde
// Params 0, eflags: 0x4
// Checksum 0xe17a03f1, Offset: 0x1100
// Size: 0x118
function private function_684b4879()
{
    foreach ( point in self.goal_points )
    {
        zombie = point.zombie;
        
        if ( isdefined( zombie ) && isalive( zombie ) )
        {
            distsq = distancesquared( zombie.origin, zombie.overridegoalpos );
            
            if ( distsq < 400 && zombie.allowoffnavmesh )
            {
                zombie function_d1e55248( #"zombie_moving", 0 );
            }
        }
    }
}

