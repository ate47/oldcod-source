#using scripts/shared/ai_shared;
#using scripts/shared/stealth_actor;
#using scripts/shared/stealth_aware;
#using scripts/shared/stealth_player;
#using scripts/shared/stealth_vo;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace stealth_behavior;

// Namespace stealth_behavior
// Params 1
// Checksum 0x4b78bb73, Offset: 0x1a8
// Size: 0x92
function on_investigate( eventpackage )
{
    if ( !isactor( self ) || !isalive( self ) )
    {
        return;
    }
    
    v_origin = eventpackage.parms[ 0 ];
    e_originator = eventpackage.parms[ 1 ];
    str_type = eventpackage.parms[ 2 ];
    
    if ( isdefined( v_origin ) )
    {
        self thread investigate_thread( v_origin, e_originator, str_type );
    }
}

// Namespace stealth_behavior
// Params 3
// Checksum 0xa75cb894, Offset: 0x248
// Size: 0x1af
function get_random_investigation_point( v_origin, desiredradius, previousresult )
{
    nearestpoint = undefined;
    goalpoint = undefined;
    searchradius = desiredradius * 0.5;
    itterations = 0;
    
    while ( !isdefined( nearestpoint ) && itterations < 4 )
    {
        itterations++;
        searchradius *= 2;
        nearestpoint = getclosestpointonnavmesh( v_origin, searchradius, 30 );
    }
    
    if ( isdefined( nearestpoint ) )
    {
        pointlist = util::positionquery_pointarray( v_origin, 0, searchradius + 50, 70, 64 );
        valid = 0;
        mydistsq = distancesquared( self.origin, v_origin );
        
        foreach ( point in pointlist )
        {
            distsq = distancesquared( point, v_origin );
            
            if ( mydistsq > 256 && distsq > mydistsq )
            {
                continue;
            }
            
            valid += 1;
            chance = 1 / valid;
            
            if ( randomfloatrange( 0, 1 ) <= chance )
            {
                goalpoint = point;
            }
        }
    }
    
    return goalpoint;
}

// Namespace stealth_behavior
// Params 0
// Checksum 0x17c219ea, Offset: 0x400
// Size: 0x1b
function investigate_stop()
{
    self.stealth.investigating = undefined;
    self notify( #"investigate_stop" );
}

// Namespace stealth_behavior
// Params 3
// Checksum 0x72d4e575, Offset: 0x428
// Size: 0x2da
function investigate_thread( v_origin, e_originator, str_type )
{
    self notify( #"investigate_thread" );
    self endon( #"investigate_thread" );
    self endon( #"death" );
    self endon( #"stop_stealth" );
    self endon( #"investigate_stop" );
    assert( self stealth_actor::enabled() );
    
    if ( !isdefined( str_type ) )
    {
        str_type = "default";
    }
    
    self stopanimscripted();
    self.stealth.investigating = str_type;
    self notify( #"lase_points" );
    self laseroff();
    
    if ( isplayer( e_originator ) && e_originator stealth_player::enabled() )
    {
        e_originator stealth_vo::function_e3ae87b3( "investigating", self, 1 );
    }
    
    nearestnode = undefined;
    goalradius = -128;
    var_d0808a0e = gettime() + randomfloatrange( 25, 30 ) * 1000;
    
    if ( str_type == "infinite" )
    {
        var_d0808a0e = -1;
    }
    else if ( str_type == "quick" )
    {
        var_d0808a0e = gettime() + randomfloatrange( 10, 15 ) * 1000;
    }
    
    if ( var_d0808a0e > 0 )
    {
        self thread function_628d42af( ( var_d0808a0e - gettime() ) / 1000 );
    }
    
    self notify( #"stealth_vo", "alert" );
    
    if ( isdefined( self.patroller ) && self.patroller )
    {
        self ai::end_and_clean_patrol_behaviors();
    }
    
    result = "";
    
    while ( ( var_d0808a0e < 0 || gettime() < var_d0808a0e ) && isdefined( v_origin ) )
    {
        investigatepoint = get_random_investigation_point( v_origin, 256, result );
        
        if ( isdefined( investigatepoint ) )
        {
            /#
                self.stealth.debug_msg = undefined;
            #/
            
            result = self function_edba2e78( investigatepoint );
            
            if ( result == "bad_path" )
            {
                /#
                    self.stealth.debug_msg = "<dev string:x28>";
                #/
                
                v_origin = self.origin;
                wait 1;
            }
            else
            {
                self waittill( #"stealthidleterminate" );
            }
            
            continue;
        }
        
        /#
            self.stealth.debug_msg = "<dev string:x3f>";
        #/
        
        v_origin = self.origin;
        wait 1;
    }
    
    self stealth_aware::set_awareness( "unaware" );
    self investigate_stop();
}

// Namespace stealth_behavior
// Params 1
// Checksum 0xae6c414c, Offset: 0x710
// Size: 0x6a
function function_628d42af( delayseconds )
{
    self endon( #"investigate_thread" );
    self endon( #"death" );
    self endon( #"stop_stealth" );
    self endon( #"investigate_stop" );
    wait delayseconds;
    self.stealth_resume_after_idle = 1;
    self notify( #"stealth_vo", "resume" );
    self stealth_aware::set_awareness( "unaware" );
    self investigate_stop();
}

// Namespace stealth_behavior
// Params 1
// Checksum 0xd8538fe1, Offset: 0x788
// Size: 0xcf
function function_edba2e78( v_origin )
{
    self notify( #"hash_edba2e78" );
    self endon( #"hash_edba2e78" );
    self endon( #"investigate_thread" );
    self endon( #"death" );
    self endon( #"stop_stealth" );
    assert( self stealth_actor::enabled() );
    self setgoalpos( v_origin, 1, 8 );
    
    /#
        self.stealth.var_edba2e78 = v_origin;
    #/
    
    result = self util::waittill_any_timeout( 30, "goal", "near_goal", "bad_path" );
    
    /#
        self.stealth.var_edba2e78 = undefined;
    #/
    
    return result;
}

