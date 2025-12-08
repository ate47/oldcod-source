#using script_22caeaa9257194b8;
#using script_7cc5fb39b97494c4;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\gametypes\globallogic_utils;

#namespace namespace_4f6b19b0;

// Namespace namespace_4f6b19b0/namespace_4f6b19b0
// Params 0
// Checksum 0xe6305061, Offset: 0x100
// Size: 0xc2
function function_6249a416()
{
    self.fndooropen = &open_door;
    self.fndoorclose = &close_door;
    self.fndoorneedstoclose = &door_needs_to_close;
    self.fngetdoorcenter = &get_door_center;
    self.fndooralreadyopen = &is_door_already_open;
    self.var_54aff8ae = &function_28483c4a;
    self.var_9a22ab2b = &function_6f0d502b;
    self.var_b84eb531 = &function_cd2d8ed8;
}

// Namespace namespace_4f6b19b0/namespace_4f6b19b0
// Params 2, eflags: 0x4
// Checksum 0x9e33a25b, Offset: 0x1d0
// Size: 0x64
function private open_door( c_door, t )
{
    if ( t < 0.2 )
    {
        c_door doors::door_bash_open( self );
        return;
    }
    
    c_door.m_e_door thread doors::open( undefined, undefined, self );
}

// Namespace namespace_4f6b19b0/namespace_4f6b19b0
// Params 1, eflags: 0x4
// Checksum 0xc6777369, Offset: 0x240
// Size: 0xe, Type: bool
function private door_needs_to_close( *c_door )
{
    return false;
}

// Namespace namespace_4f6b19b0/namespace_4f6b19b0
// Params 1, eflags: 0x4
// Checksum 0xa06be487, Offset: 0x258
// Size: 0x3c
function private close_door( c_door )
{
    self endon( #"opening_door" );
    c_door.m_e_door thread doors::close( undefined, undefined );
}

// Namespace namespace_4f6b19b0/namespace_4f6b19b0
// Params 1, eflags: 0x4
// Checksum 0xba1a285, Offset: 0x2a0
// Size: 0x1e
function private get_door_center( c_door )
{
    return c_door.var_85f2454d.doorbottomcenter;
}

// Namespace namespace_4f6b19b0/namespace_4f6b19b0
// Params 1, eflags: 0x4
// Checksum 0x5a544ebd, Offset: 0x2c8
// Size: 0x46, Type: bool
function private is_door_already_open( c_door )
{
    if ( is_true( c_door flag::get( "door_fully_open" ) ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_4f6b19b0/namespace_4f6b19b0
// Params 0
// Checksum 0x88e073d7, Offset: 0x318
// Size: 0x1c
function function_6f0d502b()
{
    self thread waitfordooropen( 1 );
}

// Namespace namespace_4f6b19b0/namespace_4f6b19b0
// Params 0
// Checksum 0xfc587e4a, Offset: 0x340
// Size: 0x1c
function function_28483c4a()
{
    self thread waitfordooropen( 0 );
}

// Namespace namespace_4f6b19b0/namespace_4f6b19b0
// Params 0
// Checksum 0xc9a42b5f, Offset: 0x368
// Size: 0x26
function function_cd2d8ed8()
{
    self.ai.var_10150769 = undefined;
    self notify( #"hash_4df5ebbdfb65254e" );
}

// Namespace namespace_4f6b19b0/namespace_4f6b19b0
// Params 0, eflags: 0x4
// Checksum 0xface10e9, Offset: 0x398
// Size: 0x96
function private calcdooropenspeed()
{
    t = 0.75;
    speed = length( self getvelocity() );
    
    if ( speed > 0 )
    {
        t = 24 / speed;
    }
    
    if ( t < 0.15 )
    {
        t = 0.15;
    }
    else if ( t > 1 )
    {
        t = 1;
    }
    
    return t;
}

// Namespace namespace_4f6b19b0/namespace_4f6b19b0
// Params 0, eflags: 0x4
// Checksum 0xbe63535d, Offset: 0x438
// Size: 0x14e
function private opendooratreasonabletime()
{
    door = self.ai.doortoopen;
    fndooropen = self.fndooropen;
    
    if ( !isdefined( door ) || !isdefined( fndooropen ) )
    {
        return;
    }
    
    self.ai.door_opened = 1;
    self endon( #"death" );
    door endon( #"death" );
    doorcenter = self [[ self.fngetdoorcenter ]]( door );
    var_45047e1c = distance2dsquared( doorcenter, self.origin );
    opendistsq = 4096;
    
    while ( var_45047e1c > opendistsq )
    {
        var_45047e1c = distance2dsquared( doorcenter, self.origin );
        waitframe( 1 );
    }
    
    t = calcdooropenspeed();
    self notify( #"opening_door" );
    self thread [[ fndooropen ]]( door, t );
    return t;
}

// Namespace namespace_4f6b19b0/namespace_4f6b19b0
// Params 0, eflags: 0x4
// Checksum 0xbff8d0bc, Offset: 0x590
// Size: 0x6e
function private opendooratreasonabletime_waitforabort()
{
    self endon( #"opening_door_done", #"death" );
    self waittill( #"hash_4df5ebbdfb65254e" );
    self.ai.doortoopen = undefined;
    self.ai.isopeningdoor = undefined;
    self notify( #"opening_door_done" );
}

// Namespace namespace_4f6b19b0/namespace_4f6b19b0
// Params 1, eflags: 0x4
// Checksum 0xd573036f, Offset: 0x608
// Size: 0x54
function private closedoorifnecessary( door )
{
    assert( isdefined( self.fndoorneedstoclose ) );
    
    if ( self [[ self.fndoorneedstoclose ]]( door ) )
    {
        self [[ self.fndoorclose ]]( door );
    }
}

// Namespace namespace_4f6b19b0/namespace_4f6b19b0
// Params 1, eflags: 0x4
// Checksum 0x58c14367, Offset: 0x668
// Size: 0x4ec
function private waitfordooropen( var_91fea62e )
{
    self.ai.var_10150769 = var_91fea62e;
    var_636f02cd = #"hash_3866cfe35818bf88";
    self notify( #"hash_4df5ebbdfb65254e" );
    self endon( #"hash_4df5ebbdfb65254e", #"death" );
    
    while ( true )
    {
        if ( isdefined( self.ai.doortoopen ) )
        {
            var_9fdc36a = 0;
            
            if ( self [[ self.fndooralreadyopen ]]( self.ai.doortoopen ) )
            {
                var_9fdc36a = 1;
            }
            
            if ( !var_9fdc36a && !isdefined( self.ai.doortoopen ) )
            {
                results = self function_a847c61f( 4096, 200 );
                
                if ( !results.var_4e035bb7 )
                {
                    var_9fdc36a = 1;
                }
            }
            
            if ( var_9fdc36a )
            {
                self.ai.doortoopen = undefined;
                waitframe( 1 );
                continue;
            }
            
            var_bdb3737a = 1;
            door = self.ai.doortoopen;
            
            if ( !self shouldfacemotion() )
            {
                lookaheaddir = self.lookaheaddir;
                lookaheaddir = vectornormalize( ( lookaheaddir[ 0 ], lookaheaddir[ 1 ], 0 ) );
                facingdir = anglestoforward( self.angles );
                
                if ( vectordot( lookaheaddir, facingdir ) < 0.966 )
                {
                    t = self opendooratreasonabletime();
                    
                    if ( isdefined( t ) )
                    {
                        self thread opendooratreasonabletime_waitforabort();
                        wait t;
                    }
                    
                    self notify( #"opening_door_done" );
                    
                    if ( isdefined( self.ai.doortoopen ) && self.ai.doortoopen == door )
                    {
                        self.ai.doortoopen = undefined;
                    }
                    
                    self.ai.isopeningdoor = undefined;
                    continue;
                }
            }
            
            self.ai.door_opened = undefined;
            var_d9bc30fb = 1;
            cdooroffset = 160;
            cdoorpadding = 2;
            targetspeed = length2d( self getvelocity() );
            
            if ( !is_true( var_91fea62e ) )
            {
                dooranim = self astsearch( var_636f02cd );
            }
            
            var_70e679e1 = var_d9bc30fb + cdooroffset + cdoorpadding;
            doorcenter = self [[ self.fngetdoorcenter ]]( door );
            disttodoor = distance2d( doorcenter, self.origin );
            
            if ( disttodoor < var_70e679e1 )
            {
                self thread closedoorifnecessary( door );
                framedurationseconds = function_60d95f53() / 1000;
                
                if ( is_true( var_91fea62e ) || disttodoor < var_70e679e1 - targetspeed * 2 * framedurationseconds )
                {
                    assert( isdefined( self.fndooropen ) );
                    t = self opendooratreasonabletime();
                    
                    if ( isdefined( t ) )
                    {
                        self thread opendooratreasonabletime_waitforabort();
                        wait t;
                    }
                    
                    self notify( #"opening_door_done" );
                    
                    if ( isdefined( self.ai.doortoopen ) && self.ai.doortoopen == door )
                    {
                        self.ai.doortoopen = undefined;
                    }
                    
                    self.ai.isopeningdoor = undefined;
                }
            }
        }
        
        waitframe( 1 );
    }
}

