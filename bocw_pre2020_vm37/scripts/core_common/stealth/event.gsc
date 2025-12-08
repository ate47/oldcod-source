#using scripts\core_common\flag_shared;
#using scripts\core_common\stealth\callbacks;
#using scripts\core_common\stealth\debug;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\util_shared;

#namespace event;

// Namespace event/event
// Params 2
// Checksum 0x197addf3, Offset: 0x270
// Size: 0x14
function scalevolume( *ent, *vol )
{
    
}

#namespace stealth_event;

// Namespace stealth_event/event
// Params 0
// Checksum 0x6fce8197, Offset: 0x290
// Size: 0x34
function event_init_entity()
{
    self thread event_listener_thread();
    self event_entity_core_set_enabled( 1 );
}

// Namespace stealth_event/event
// Params 1
// Checksum 0x724517f7, Offset: 0x2d0
// Size: 0x286
function event_entity_core_set_enabled( enabled )
{
    if ( !isdefined( level.stealth.core_events ) )
    {
        level.stealth.core_events = [ "bulletwhizby", "explode", "footstep", "footstep_run", "footstep_sprint", "footstep_walk", "grenade danger", "gunshot", "gunshot_teammate", "projectile_impact", "silenced_shot" ];
    }
    
    if ( enabled && !is_true( self.stealth.var_6b368eb9 ) )
    {
        foreach ( eventname in level.stealth.core_events )
        {
            self addsentienteventlistener( eventname );
        }
        
        self.stealth.var_6b368eb9 = 1;
        return;
    }
    
    if ( !enabled && is_true( self.stealth.var_6b368eb9 ) )
    {
        foreach ( eventname in level.stealth.core_events )
        {
            self removesentienteventlistener( eventname );
        }
        
        self.stealth.var_6b368eb9 = undefined;
    }
}

// Namespace stealth_event/event
// Params 0
// Checksum 0x560c1565, Offset: 0x560
// Size: 0x4cc
function event_init_level()
{
    if ( !isdefined( level.stealth.event_priority ) )
    {
        level.stealth.event_priority = [];
    }
    
    level.stealth.event_priority[ "investigate" ] = 0;
    level.stealth.event_priority[ "cover_blown" ] = 1;
    level.stealth.event_priority[ "combat" ] = 2;
    level namespace_979752dc::set_stealth_func( "broadcast", &event_broadcast_generic );
    event_severity_set( "investigate", "footstep", 15, 0.07 );
    event_severity_set( "investigate", "footstep_run", 15, 0.07 );
    event_severity_set( "investigate", "footstep_sprint", 10, 0.1 );
    event_severity_set( "investigate", "footstep_walk", 20, 0.05 );
    event_severity_set( "investigate", "unresponsive_teammate", 20, 0.05 );
    event_severity_set( "investigate", "window_open", 0, 0.2 );
    event_severity_set( "investigate", "ally_hurt_peripheral", 0, 0.1 );
    event_severity_set( "cover_blown", "sight", 2, 0.45 );
    event_severity_set( "cover_blown", "saw_corpse", 0, 0.3 );
    event_severity_set( "cover_blown", "found_corpse", 0, 0.3 );
    event_severity_set( "cover_blown", "gunshot_teammate", 10, 0.1 );
    event_severity_set( "cover_blown", "silenced_shot", 5, 0.23 );
    event_severity_set( "cover_blown", "gunshot", 3, 0.4 );
    event_severity_set( "cover_blown", "explode", 2, 0.8 );
    event_severity_set( "cover_blown", "seek_backup", 0, 0 );
    event_severity_set( "cover_blown", "grenade danger", 0, 0.9 );
    event_severity_set( "cover_blown", "glass_destroyed", 2, 0.5 );
    event_severity_set( "cover_blown", "light_killed", 3, 0.4 );
    event_severity_set( "cover_blown", "bulletwhizby", 3, 0.4 );
    event_severity_set( "combat", "projectile_impact" );
    event_severity_set( "combat", "attack" );
    event_severity_set( "combat", "damage" );
    event_severity_set( "combat", "proximity" );
    event_severity_set( "combat", "ally_damaged" );
    event_severity_set( "combat", "ally_killed" );
}

// Namespace stealth_event/event
// Params 2
// Checksum 0x841cdb75, Offset: 0xa38
// Size: 0xfe
function event_severity_compare( severitya, severityb )
{
    assert( isdefined( level.stealth ) );
    assert( isdefined( level.stealth.event_priority ) );
    assert( isdefined( level.stealth.event_priority[ severitya ] ) );
    assert( isdefined( level.stealth.event_priority[ severityb ] ) );
    result = level.stealth.event_priority[ severitya ] - level.stealth.event_priority[ severityb ];
    return result;
}

// Namespace stealth_event/event
// Params 2
// Checksum 0xc0ae64e6, Offset: 0xb40
// Size: 0x142
function event_severity_shift( severity, direction )
{
    assert( isdefined( level.stealth ) );
    assert( isdefined( level.stealth.event_priority ) );
    assert( isdefined( level.stealth.event_priority[ severity ] ) );
    priority = level.stealth.event_priority[ severity ] + direction;
    
    foreach ( var_64cba2ea, priorityval in level.stealth.event_priority )
    {
        if ( priorityval == priority )
        {
            return var_64cba2ea;
        }
    }
    
    return severity;
}

// Namespace stealth_event/event
// Params 5
// Checksum 0x4132ea1, Offset: 0xc90
// Size: 0x1ac
function event_severity_set( severity, eventname, escalation, escalation_scalar, escalation_to_combat )
{
    assert( !( severity == "<dev string:x38>" && isdefined( escalation_to_combat ) ) );
    assert( !( severity == "<dev string:x47>" && isdefined( escalation ) ) );
    
    if ( !isdefined( escalation ) )
    {
        escalation = 0;
    }
    
    if ( !isdefined( escalation_scalar ) )
    {
        escalation_scalar = 0;
    }
    
    if ( !isdefined( level.stealth.event_severity ) )
    {
        level.stealth.event_severity = [];
    }
    
    if ( !isdefined( level.stealth.event_escalation ) )
    {
        level.stealth.event_escalation = [];
    }
    
    if ( !isdefined( level.stealth.event_escalation_scalars ) )
    {
        level.stealth.event_escalation_scalars = [];
    }
    
    if ( !isdefined( level.stealth.event_escalation_to_combat ) )
    {
        level.stealth.event_escalation_to_combat = [];
    }
    
    level.stealth.event_severity[ eventname ] = severity;
    level.stealth.event_escalation[ eventname ] = escalation;
    level.stealth.event_escalation_scalars[ eventname ] = escalation_scalar;
    level.stealth.event_escalation_to_combat[ eventname ] = escalation_to_combat;
}

// Namespace stealth_event/event
// Params 1
// Checksum 0xb0e33f8c, Offset: 0xe48
// Size: 0x4c
function event_severity_get( eventname )
{
    assert( isdefined( level.stealth.event_severity ) );
    return level.stealth.event_severity[ eventname ];
}

// Namespace stealth_event/event
// Params 1
// Checksum 0x8bd86625, Offset: 0xea0
// Size: 0x4c
function event_escalation_get( eventname )
{
    assert( isdefined( level.stealth.event_escalation ) );
    return level.stealth.event_escalation[ eventname ];
}

// Namespace stealth_event/event
// Params 1
// Checksum 0x1ff92320, Offset: 0xef8
// Size: 0x4c
function event_escalation_scalar_get( eventname )
{
    assert( isdefined( level.stealth.event_escalation_scalars ) );
    return level.stealth.event_escalation_scalars[ eventname ];
}

// Namespace stealth_event/event
// Params 1
// Checksum 0x7267f771, Offset: 0xf50
// Size: 0x4c
function event_escalation_to_combat_get( eventname )
{
    assert( isdefined( level.stealth.event_escalation_to_combat ) );
    return level.stealth.event_escalation_to_combat[ eventname ];
}

// Namespace stealth_event/event
// Params 0
// Checksum 0x8d5c514b, Offset: 0xfa8
// Size: 0x2a
function event_escalation_clear()
{
    self.stealth.event_escalation_count = undefined;
    self.stealth.event_escalation_scalar = 0;
}

// Namespace stealth_event/event
// Params 0
// Checksum 0x3994be20, Offset: 0xfe0
// Size: 0x676
function event_listener_thread()
{
    self notify( #"event_listener_thread" );
    self endon( #"event_listener_thread" );
    self endon( #"death" );
    
    while ( true )
    {
        self flag::wait_till( "stealth_enabled" );
        wait_result = self waittill( #"ai_events" );
        waittillframeend();
        
        if ( !self flag::get( "stealth_enabled" ) )
        {
            continue;
        }
        
        if ( self.ignoreall || self isragdoll() )
        {
            continue;
        }
        
        foreach ( event in wait_result.events )
        {
            if ( !isdefined( event.entity ) )
            {
                continue;
            }
            
            if ( issentient( event.entity ) && ( event.entity.ignoreme || is_true( event.entity isnotarget() ) ) )
            {
                continue;
            }
            
            event.typeorig = event.type;
            event.receiver = self;
            var_33a263c4 = event_severity_get( event.type );
            escalation = undefined;
            escalation_scalar = undefined;
            escalation_to_combat = undefined;
            
            if ( isdefined( var_33a263c4 ) )
            {
                if ( !isdefined( self.disableescalation ) && var_33a263c4 != "combat" )
                {
                    escalation = event_escalation_get( event.type );
                    escalation_scalar = event_escalation_scalar_get( event.type );
                    escalation_to_combat = event_escalation_to_combat_get( event.type );
                    
                    if ( escalation > 0 )
                    {
                        if ( !isdefined( self.stealth.event_escalation_count ) )
                        {
                            self.stealth.event_escalation_count = [];
                        }
                        
                        if ( !isdefined( self.stealth.event_escalation_count[ event.type ] ) )
                        {
                            self.stealth.event_escalation_count[ event.type ] = 0;
                        }
                        
                        if ( isdefined( escalation_to_combat ) && self.stealth.event_escalation_count[ event.type ] + 1 >= escalation_to_combat )
                        {
                            var_33a263c4 = event_severity_shift( var_33a263c4, 2 );
                        }
                        else if ( self.stealth.event_escalation_count[ event.type ] + 1 >= escalation )
                        {
                            var_33a263c4 = event_severity_shift( var_33a263c4, 1 );
                        }
                        else if ( self.stealth.event_escalation_scalar + escalation_scalar >= 1 )
                        {
                            var_33a263c4 = event_severity_shift( var_33a263c4, 1 );
                        }
                    }
                }
                
                event.type = var_33a263c4;
            }
            
            eventhandled = self namespace_b2b86d39::stealth_call( event.type, event );
            
            if ( is_true( eventhandled ) && isdefined( escalation ) && event.type != "combat" )
            {
                if ( escalation > 0 )
                {
                    if ( !isdefined( self.stealth.event_escalation_count ) )
                    {
                        self.stealth.event_escalation_count = [];
                    }
                    
                    if ( !isdefined( self.stealth.event_escalation_count[ event.typeorig ] ) )
                    {
                        self.stealth.event_escalation_count[ event.typeorig ] = 0;
                    }
                    
                    self.stealth.event_escalation_count[ event.typeorig ]++;
                }
                
                self.stealth.event_escalation_scalar += escalation_scalar;
            }
            
            /#
                typeorig = "<dev string:x51>";
                
                if ( isdefined( event.typeorig ) )
                {
                    typeorig = "<dev string:x55>" + ( ishash( event.typeorig ) ? function_9e72a96( event.typeorig ) : event.typeorig ) + "<dev string:x5b>";
                }
                
                event_str = "<dev string:x60>" + ( ishash( event.type ) ? function_9e72a96( event.type ) : event.type ) + typeorig;
                
                if ( isdefined( eventhandled ) && !eventhandled )
                {
                    event_str += "<dev string:x6b>";
                }
                
                self thread stealth_debug::function_314b7255( event_str, ( 1, 1, 1 ), 1, 0.5, ( 0, 0, 40 ), 4 );
                self.stealth.ai_event = event.type;
            #/
        }
    }
}

// Namespace stealth_event/event
// Params 5
// Checksum 0x4a0323d4, Offset: 0x1660
// Size: 0x2e8
function event_broadcast_axis( eventtype, eventtypeperipheral, enemy, rangeauto, rangesight )
{
    ais = getactorteamarray( self.team );
    rangeautosq = sqr( rangeauto );
    rangesightsq = sqr( rangesight );
    
    foreach ( ai in ais )
    {
        if ( !isalive( ai ) )
        {
            continue;
        }
        
        if ( ai == self )
        {
            continue;
        }
        
        if ( !isdefined( ai.stealth ) )
        {
            continue;
        }
        
        broadcast = 0;
        distsq = distancesquared( ai.origin, self.origin );
        
        if ( distsq <= rangeautosq )
        {
            broadcast = self util::has_tac_vis( ai );
        }
        
        if ( !broadcast && distsq <= rangesightsq )
        {
            if ( ai namespace_979752dc::is_visible( self ) || ai namespace_979752dc::is_visible( enemy ) )
            {
                broadcast = 1;
            }
        }
        
        if ( !isdefined( ai.fnisinstealthcombat ) || ai [[ ai.fnisinstealthcombat ]]() )
        {
            if ( broadcast )
            {
                ai getenemyinfo( enemy );
            }
            
            continue;
        }
        
        if ( broadcast )
        {
            if ( ai lastknowntime( enemy ) == 0 )
            {
                ai function_a3fcf9e0( eventtype, enemy, self.origin );
            }
            else
            {
                ai function_a3fcf9e0( eventtype, enemy, enemy.origin );
            }
            
            continue;
        }
        
        if ( ai canseeperipheral( self ) )
        {
            ai function_a3fcf9e0( eventtypeperipheral, enemy, self.origin );
        }
    }
}

// Namespace stealth_event/event
// Params 4
// Checksum 0xc517ccc0, Offset: 0x1950
// Size: 0x170
function event_broadcast_generic( eventtype, eventposition, eventradius, evententity )
{
    ais = getactorteamarray( "axis", "team3" );
    
    if ( !isdefined( evententity ) )
    {
        evententity = getplayers()[ 0 ];
    }
    
    rangeautosq = sqr( eventradius );
    
    foreach ( ai in ais )
    {
        if ( !isalive( ai ) )
        {
            continue;
        }
        
        if ( !isdefined( ai.stealth ) )
        {
            continue;
        }
        
        if ( distancesquared( ai.origin, eventposition ) <= rangeautosq )
        {
            ai function_a3fcf9e0( eventtype, evententity, eventposition );
        }
    }
}

// Namespace stealth_event/event
// Params 7
// Checksum 0x62bd4698, Offset: 0x1ac8
// Size: 0x1f0
function event_broadcast_axis_by_tacsight( eventtype, enemy, eventposition, eventradius, bcheckfov, tacposition, var_683e4bdc )
{
    ais = getactorteamarray( "axis", "team3" );
    cradiussq = eventradius * eventradius;
    
    if ( !isdefined( bcheckfov ) )
    {
        bcheckfov = 1;
    }
    
    var_ca5ecc3c = undefined;
    
    if ( isdefined( var_683e4bdc ) )
    {
        var_ca5ecc3c = var_683e4bdc * var_683e4bdc;
    }
    
    if ( !isdefined( tacposition ) )
    {
        tacposition = eventposition;
    }
    
    foreach ( ai in ais )
    {
        if ( !isalive( ai ) )
        {
            continue;
        }
        
        if ( !isdefined( ai.stealth ) )
        {
            continue;
        }
        
        var_d60e3570 = distancesquared( ai.origin, eventposition );
        
        if ( var_d60e3570 > cradiussq )
        {
            continue;
        }
        
        var_b03a913a = bcheckfov;
        
        if ( bcheckfov && isdefined( var_ca5ecc3c ) && var_d60e3570 <= var_ca5ecc3c )
        {
            var_b03a913a = 0;
        }
        
        if ( !ai util::has_tac_vis( tacposition, var_b03a913a ) )
        {
            continue;
        }
        
        ai function_a3fcf9e0( eventtype, enemy, eventposition );
    }
}

// Namespace stealth_event/event
// Params 7
// Checksum 0xf5c47602, Offset: 0x1cc0
// Size: 0x5c
function event_broadcast_axis_by_sight( eventtype, enemy, eventposition, eventradius, bcheckfov, tacposition, autorange )
{
    thread event_broadcast_axis_by_sight_thread( eventtype, enemy, eventposition, eventradius, bcheckfov, tacposition, autorange );
}

// Namespace stealth_event/event
// Params 7
// Checksum 0x6b8e54cd, Offset: 0x1d28
// Size: 0x278
function event_broadcast_axis_by_sight_thread( eventtype, enemy, eventposition, eventradius, bcheckfov, tacposition, autorange )
{
    ais = getactorteamarray( "axis", "team3" );
    cradiussq = eventradius * eventradius;
    
    if ( !isdefined( bcheckfov ) )
    {
        bcheckfov = 1;
    }
    
    if ( !isdefined( tacposition ) )
    {
        tacposition = eventposition;
    }
    
    var_a0229356 = 3;
    var_1389681c = 0;
    
    foreach ( ai in ais )
    {
        if ( !isalive( ai ) )
        {
            continue;
        }
        
        if ( !isdefined( ai.stealth ) )
        {
            continue;
        }
        
        distsq = distancesquared( ai.origin, eventposition );
        
        if ( distsq > cradiussq )
        {
            continue;
        }
        
        if ( isdefined( autorange ) && distsq <= sqr( autorange ) )
        {
            ai function_a3fcf9e0( eventtype, enemy, eventposition );
            continue;
        }
        
        if ( !ai util::has_tac_vis( tacposition, bcheckfov ) )
        {
            if ( bcheckfov && !ai pointinfov( eventposition ) )
            {
                continue;
            }
            
            var_1389681c++;
            
            if ( var_1389681c > var_a0229356 )
            {
                waitframe( 1 );
                var_1389681c = 0;
            }
            
            if ( !sighttracepassed( ai geteye(), eventposition, 0, enemy ) )
            {
                continue;
            }
        }
        
        ai function_a3fcf9e0( eventtype, enemy, eventposition );
    }
}

