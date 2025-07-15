#using scripts/shared/stealth;
#using scripts/shared/stealth_aware;
#using scripts/shared/stealth_behavior;
#using scripts/shared/stealth_debug;
#using scripts/shared/stealth_vo;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace stealth_event;

// Namespace stealth_event
// Params 0
// Checksum 0x7ec38d94, Offset: 0x210
// Size: 0xb2
function init()
{
    assert( isdefined( self.stealth ) );
    
    if ( isdefined( self.stealth.event ) )
    {
        return;
    }
    
    if ( !isdefined( self.stealth.event ) )
    {
        self.stealth.event = spawnstruct();
    }
    
    if ( !isdefined( self.stealth.event.package ) )
    {
        self.stealth.event.package = spawnstruct();
    }
    
    self register_default_handlers();
}

// Namespace stealth_event
// Params 0
// Checksum 0xa4da884b, Offset: 0x2d0
// Size: 0x1e, Type: bool
function enabled()
{
    return isdefined( self.stealth ) && isdefined( self.stealth.event );
}

// Namespace stealth_event
// Params 0
// Checksum 0x5e6a3888, Offset: 0x2f8
// Size: 0x202
function register_default_handlers()
{
    self register_handler( "alert", &stealth_aware::on_alert_changed, 3 );
    
    if ( isactor( self ) )
    {
        self register_handler( "pain", &on_pain, 2 );
        self register_handler( "death", &on_pain, 2 );
        self register_handler( "damage", &on_pain, 2 );
        self register_handler( "combat_spread", &stealth_aware::function_101ac5, 1 );
        self register_handler( "combat_interest", &stealth_aware::function_933965f6, 2 );
        self register_handler( "stealth_sight_start", &stealth_aware::function_ca6a0809, 1 );
        self register_handler( "stealth_sight_max", &stealth_aware::on_sighted, 1 );
        self register_handler( "stealth_sight_end", &stealth_aware::on_sight_end, 1 );
        self register_handler( "witness_combat", &stealth_aware::on_witness_combat, 2 );
        self register_handler( "investigate", &stealth_behavior::on_investigate, 3 );
        self register_handler( "stealth_vo", &stealth_vo::on_voice_event, 1 );
    }
    
    self thread function_b349369d();
}

// Namespace stealth_event
// Params 0
// Checksum 0xc4860d46, Offset: 0x508
// Size: 0x2b
function function_b349369d()
{
    self util::waittill_any( "stop_stealth", "death" );
    self notify( #"hash_2bbc4f84" );
}

// Namespace stealth_event
// Params 3
// Checksum 0x457ea54f, Offset: 0x540
// Size: 0x14d
function register_handler( eventname, func, var_8a0dd434 )
{
    if ( !isdefined( var_8a0dd434 ) )
    {
        var_8a0dd434 = 0;
    }
    
    if ( !isdefined( level.stealth.eventhandler ) )
    {
        level.stealth.eventhandler = [];
    }
    
    if ( !isdefined( level.stealth.eventhandler[ eventname ] ) )
    {
        level.stealth.eventhandler[ eventname ] = func;
    }
    
    if ( eventname == "death" )
    {
        self thread function_551bd4f3();
        return;
    }
    
    switch ( var_8a0dd434 )
    {
        case 0:
            self thread function_44782a56( eventname );
            break;
        case 1:
            self thread function_6a7aa4bf( eventname );
            break;
        case 2:
            self thread function_f8733584( eventname );
            break;
        case 3:
            self thread function_1e75afed( eventname );
            break;
        default:
            /#
                iprintlnbold( "<dev string:x28>" + var_8a0dd434 );
            #/
            
            break;
    }
}

// Namespace stealth_event
// Params 1
// Checksum 0x33aaa1c6, Offset: 0x698
// Size: 0x35
function function_44782a56( eventname )
{
    self endon( #"hash_2bbc4f84" );
    
    while ( true )
    {
        self waittill( eventname );
        self thread function_5b52d0d9( eventname );
    }
}

// Namespace stealth_event
// Params 1
// Checksum 0xff62b60d, Offset: 0x6d8
// Size: 0x3d
function function_6a7aa4bf( eventname )
{
    self endon( #"hash_2bbc4f84" );
    
    while ( true )
    {
        self waittill( eventname, arg1 );
        self thread function_5b52d0d9( eventname, arg1 );
    }
}

// Namespace stealth_event
// Params 1
// Checksum 0xf1413c0b, Offset: 0x720
// Size: 0x4d
function function_f8733584( eventname )
{
    self endon( #"hash_2bbc4f84" );
    
    while ( true )
    {
        self waittill( eventname, arg1, arg2 );
        self thread function_5b52d0d9( eventname, arg1, arg2 );
    }
}

// Namespace stealth_event
// Params 0
// Checksum 0x22e9db40, Offset: 0x778
// Size: 0x42
function function_551bd4f3()
{
    self endon( #"stop_stealth" );
    self waittill( #"death", arg1, arg2 );
    self thread function_5b52d0d9( "death", arg1, arg2 );
}

// Namespace stealth_event
// Params 1
// Checksum 0xfa58b943, Offset: 0x7c8
// Size: 0x55
function function_1e75afed( eventname )
{
    self endon( #"hash_2bbc4f84" );
    
    while ( true )
    {
        self waittill( eventname, arg1, arg2, arg3 );
        self thread function_5b52d0d9( eventname, arg1, arg2, arg3 );
    }
}

// Namespace stealth_event
// Params 4, eflags: 0x4
// Checksum 0xe3d2bbef, Offset: 0x828
// Size: 0x239
function private function_5b52d0d9( eventname, arg1, arg2, arg3 )
{
    self endon( #"stop_stealth" );
    assert( isdefined( eventname ) );
    assert( isdefined( level.stealth.eventhandler[ eventname ] ) );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.stealth ) )
    {
        return;
    }
    
    if ( !isdefined( level.stealth ) )
    {
        return;
    }
    
    if ( eventname != "alert" || !( isdefined( self.var_89b9fc6 ) && self.var_89b9fc6 ) )
    {
        if ( isdefined( self.ignoreall ) && self.ignoreall && eventname != "death" )
        {
            return;
        }
    }
    
    /#
        if ( stealth_debug::enabled() && isdefined( self ) && isentity( self ) )
        {
            args = "<dev string:x5f>";
            
            if ( isdefined( arg1 ) )
            {
                args = "<dev string:x60>" + stealth_debug::debug_text( arg1 ) + args;
            }
            
            self thread stealth_debug::rising_text( eventname + "<dev string:x62>" + args + "<dev string:x65>", ( 0.75, 0.75, 0.75 ), 1, 0.5, self.origin + ( 0, 0, 30 ), 3 );
        }
    #/
    
    self.stealth.event.package.name = eventname;
    self.stealth.event.package.parms[ 0 ] = arg1;
    self.stealth.event.package.parms[ 1 ] = arg2;
    self.stealth.event.package.parms[ 2 ] = arg3;
    self [[ level.stealth.eventhandler[ eventname ] ]]( self.stealth.event.package );
}

// Namespace stealth_event
// Params 1
// Checksum 0xa609f4c5, Offset: 0xa70
// Size: 0xfa
function on_pain( eventpackage )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    e_attacker = eventpackage.parms[ 0 ];
    
    if ( !isentity( e_attacker ) )
    {
        e_attacker = eventpackage.parms[ 1 ];
    }
    
    wait 0.05;
    
    if ( !isdefined( self ) || !isdefined( self.team ) )
    {
        return;
    }
    
    if ( isdefined( e_attacker ) && e_attacker.team != self.team )
    {
        if ( isalive( self ) )
        {
            self notify( #"alert", "combat", e_attacker.origin, e_attacker, "took_damage" );
        }
        
        self broadcast_to_team( self.team, self.origin, 300, -128, 1, "witness_combat", e_attacker, "saw_combat" );
    }
}

// Namespace stealth_event
// Params 11
// Checksum 0x425d5186, Offset: 0xb78
// Size: 0x1d9
function broadcast_to_team( str_team, v_origin, radius, maxheightdiff, requiresight, eventname, arg1, arg2, arg3, arg4, arg5 )
{
    radiussq = radius * radius;
    agentlist = getaiarray();
    
    foreach ( agent in agentlist )
    {
        if ( !isalive( agent ) )
        {
            continue;
        }
        
        if ( ( !isdefined( self ) || !( agent === self ) ) && distancesquared( v_origin, agent.origin ) < radiussq )
        {
            if ( agent stealth_aware::enabled() && agent stealth_aware::get_awareness() == "combat" )
            {
                continue;
            }
            
            if ( abs( agent.origin[ 2 ] - self.origin[ 2 ] ) > maxheightdiff )
            {
                continue;
            }
            
            bvalidtarget = !requiresight;
            
            if ( requiresight )
            {
                bvalidtarget = agent stealth::can_see( self );
            }
            
            if ( bvalidtarget && requiresight )
            {
                agent notify( eventname, arg1, arg2, arg3, arg4, arg5 );
                continue;
            }
            
            if ( bvalidtarget )
            {
                agent notify( eventname, arg1, arg2, arg3, arg4, arg5 );
            }
        }
    }
}

