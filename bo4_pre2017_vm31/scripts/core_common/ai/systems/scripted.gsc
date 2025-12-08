#namespace scripted;

#using_animtree( "generic" );

// Namespace scripted/scripted
// Params 0
// Checksum 0x3236703e, Offset: 0xb0
// Size: 0x82
function main()
{
    self endon( #"death" );
    self notify( #"killanimscript" );
    self notify( #"clearsuppressionattack" );
    self.codescripted[ "root" ] = %body;
    self endon( #"end_sequence" );
    self.a.script = "scripted";
    self waittill( "killanimscript" );
}

// Namespace scripted/scripted
// Params 9
// Checksum 0x9d196464, Offset: 0x140
// Size: 0x4c
function init( notifyname, origin, angles, theanim, animmode, root, rate, goaltime, lerptime )
{
    
}

// Namespace scripted/scripted
// Params 0
// Checksum 0x4561f33c, Offset: 0x198
// Size: 0x28
function end_script()
{
    if ( isdefined( self.___archetypeonbehavecallback ) )
    {
        [[ self.___archetypeonbehavecallback ]]( self );
    }
}

