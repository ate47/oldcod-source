#using scripts\core_common\ai_shared;
#using scripts\core_common\smart_object;

#namespace namespace_206491b4;

// Namespace namespace_206491b4/tac
// Params 1
// Checksum 0x9ba73f7, Offset: 0xd0
// Size: 0xcc
function function_24b5e32( pos )
{
    pos = goal_origin( pos );
    
    if ( isdefined( self.smart_object ) )
    {
        return self.smart_object smart_object::get_goal().angles;
    }
    
    if ( is_true( self.limitstealthturning ) )
    {
        return vectortoangles( pos - self.origin );
    }
    
    lookdir = findopenlookdir( pos );
    
    if ( isdefined( lookdir ) )
    {
        return vectortoangles( lookdir );
    }
}

// Namespace namespace_206491b4/tac
// Params 3
// Checksum 0x9caadac6, Offset: 0x1a8
// Size: 0x1f0
function findopenlookdir( from, radius = 256, mindist = 96 )
{
    from = goal_origin( from );
    space = ai::t_cylinder( from, radius, 128 );
    tacpoints = isdefined( tacticalquery( "stealth_open_view_space", from, space ) ) ? tacticalquery( "stealth_open_view_space", from, space ) : [];
    mindistsq = sqr( mindist );
    
    foreach ( tac in tacpoints )
    {
        if ( distancesquared( from, tac.origin ) > mindistsq )
        {
            /#
                print3d( tac.origin, "<dev string:x38>", ( 1, 1, 1 ), 1, 1, 1 );
            #/
            
            dir = tac.origin - from;
            return vectornormalize( ( dir[ 0 ], dir[ 1 ], 0 ) );
        }
    }
}

// Namespace namespace_206491b4/tac
// Params 6
// Checksum 0x60a5bc8e, Offset: 0x3a0
// Size: 0x7a
function findclosestnonlospointwithinradius( center, radius, var_72cc3c18, var_465a4fd5, ignorepoints, ignoreradius )
{
    cylinder = ai::t_cylinder( center, radius, 128 );
    return function_a4b83b6a( "stealth_closest_non_los_space", cylinder, var_72cc3c18, var_465a4fd5, ignorepoints, ignoreradius );
}

// Namespace namespace_206491b4/tac
// Params 5
// Checksum 0x7445493b, Offset: 0x428
// Size: 0x4a
function findclosestnonlospointwithinvolume( vol, var_72cc3c18, var_465a4fd5, ignorepoints, ignoreradius )
{
    return function_a4b83b6a( "stealth_closest_non_los_space", vol, var_72cc3c18, var_465a4fd5, ignorepoints, ignoreradius );
}

// Namespace namespace_206491b4/tac
// Params 6
// Checksum 0x5951af4b, Offset: 0x480
// Size: 0x7a
function findclosestlospointwithinradius( center, radius, var_72cc3c18, var_465a4fd5, ignorepoints, ignoreradius )
{
    cylinder = ai::t_cylinder( center, radius, 128 );
    return function_a4b83b6a( "stealth_closest_los_space", cylinder, var_72cc3c18, var_465a4fd5, ignorepoints, ignoreradius );
}

// Namespace namespace_206491b4/tac
// Params 5
// Checksum 0xf9e7c9c0, Offset: 0x508
// Size: 0x4a
function findclosestlospointwithinvolume( vol, var_72cc3c18, var_465a4fd5, ignorepoints, ignoreradius )
{
    return function_a4b83b6a( "stealth_closest_los_space", vol, var_72cc3c18, var_465a4fd5, ignorepoints, ignoreradius );
}

// Namespace namespace_206491b4/tac
// Params 6, eflags: 0x4
// Checksum 0xcd8b3a5e, Offset: 0x560
// Size: 0x238
function private function_a4b83b6a( tacquery, space, var_72cc3c18, var_465a4fd5, ignorepoints, ignoreradius )
{
    tacpoints = isdefined( tacticalquery( tacquery, space.origin, space, var_72cc3c18, var_465a4fd5 ) ) ? tacticalquery( tacquery, space.origin, space, var_72cc3c18, var_465a4fd5 ) : [];
    
    if ( isdefined( ignorepoints ) )
    {
        assert( isdefined( ignoreradius ) );
        var_dfdc1e6f = sqr( ignoreradius );
        var_fdba779a = [];
        
        foreach ( tac in tacpoints )
        {
            ignored = 0;
            
            foreach ( point in ignorepoints )
            {
                if ( distancesquared( point.origin, tac.origin ) < var_dfdc1e6f )
                {
                    ignored = 1;
                    break;
                }
            }
            
            if ( !ignored )
            {
                var_fdba779a[ var_fdba779a.size ] = tac;
            }
        }
        
        tacpoints = var_fdba779a;
    }
    
    if ( tacpoints.size > 0 )
    {
        return tacpoints[ 0 ].origin;
    }
    
    return var_465a4fd5;
}

// Namespace namespace_206491b4/tac
// Params 1, eflags: 0x4
// Checksum 0x3d114348, Offset: 0x7a0
// Size: 0x36
function private goal_origin( goal )
{
    if ( isvec( goal ) )
    {
        return goal;
    }
    
    return goal.origin;
}

