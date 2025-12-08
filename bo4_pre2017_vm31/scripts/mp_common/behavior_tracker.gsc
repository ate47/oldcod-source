#using scripts/core_common/math_shared;

#namespace behaviortracker;

// Namespace behaviortracker/behavior_tracker
// Params 0
// Checksum 0x6ca68a0b, Offset: 0x1f0
// Size: 0x18c
function function_c7516f2f()
{
    if ( isdefined( self.behaviortracker.traits ) )
    {
        return;
    }
    
    self.behaviortracker.traits = [];
    self.behaviortracker.traits[ "effectiveCombat" ] = 0.5;
    self.behaviortracker.traits[ "effectiveWallRunCombat" ] = 0.5;
    self.behaviortracker.traits[ "effectiveDoubleJumpCombat" ] = 0.5;
    self.behaviortracker.traits[ "effectiveSlideCombat" ] = 0.5;
    
    if ( self.behaviortracker.version != 0 )
    {
        traits = getarraykeys( self.behaviortracker.traits );
        
        for ( i = 0; i < traits.size ; i++ )
        {
            trait = traits[ i ];
            self.behaviortracker.traits[ trait ] = float( self function_16ff7316( trait ) );
        }
    }
}

// Namespace behaviortracker/behavior_tracker
// Params 0
// Checksum 0xc58c68cf, Offset: 0x388
// Size: 0x12c
function initialize()
{
    if ( self isbot() )
    {
        return;
    }
    
    if ( isdefined( self.behaviortracker ) )
    {
        return;
    }
    
    if ( isdefined( level.var_43b32a7 ) && level.var_43b32a7 == 1 )
    {
        return;
    }
    
    self.behaviortracker = spawnstruct();
    self.behaviortracker.version = int( self function_16ff7316( "version" ) );
    self.behaviortracker.numRecords = int( self function_16ff7316( "numRecords" ) ) + 1;
    self function_c7516f2f();
    self.behaviortracker.valid = 1;
}

// Namespace behaviortracker/behavior_tracker
// Params 0
// Checksum 0x8f535706, Offset: 0x4c0
// Size: 0x4c
function finalize()
{
    if ( !self isallowed() )
    {
        return;
    }
    
    self function_83084a92();
    self function_cca0db2d();
}

// Namespace behaviortracker/behavior_tracker
// Params 0
// Checksum 0x38381e7d, Offset: 0x518
// Size: 0x6c, Type: bool
function isallowed()
{
    if ( !isdefined( self ) )
    {
        return false;
    }
    
    if ( !isdefined( self.behaviortracker ) )
    {
        return false;
    }
    
    if ( !self.behaviortracker.valid )
    {
        return false;
    }
    
    if ( isdefined( level.var_43b32a7 ) && level.var_43b32a7 == 1 )
    {
        return false;
    }
    
    return true;
}

// Namespace behaviortracker/behavior_tracker
// Params 0
// Checksum 0x7d93577c, Offset: 0x590
// Size: 0xb4
function function_cca0db2d()
{
    bbprint( "mpbehaviortracker", "username %s version %d numRecords %d effectiveSlideCombat %f effectiveDoubleJumpCombat %f effectiveWallRunCombat %f effectiveCombat %f", self.name, self.behaviortracker.version, self.behaviortracker.numRecords, self.behaviortracker.traits[ "effectiveSlideCombat" ], self.behaviortracker.traits[ "effectiveDoubleJumpCombat" ], self.behaviortracker.traits[ "effectiveWallRunCombat" ], self.behaviortracker.traits[ "effectiveCombat" ] );
}

// Namespace behaviortracker/behavior_tracker
// Params 1
// Checksum 0x59c40000, Offset: 0x650
// Size: 0x24
function function_254224( trait )
{
    return self.behaviortracker.traits[ trait ];
}

// Namespace behaviortracker/behavior_tracker
// Params 2
// Checksum 0x3e6cec08, Offset: 0x680
// Size: 0x32
function function_80251728( trait, value )
{
    self.behaviortracker.traits[ trait ] = value;
}

// Namespace behaviortracker/behavior_tracker
// Params 2
// Checksum 0xf79d8f2c, Offset: 0x6c0
// Size: 0x164
function function_b1f374e6( trait, percent )
{
    if ( !self isallowed() )
    {
        return;
    }
    
    math::clamp( percent, -1, 1 );
    currentvalue = self function_254224( trait );
    
    if ( percent >= 0 )
    {
        delta = ( 1 - currentvalue ) * percent;
    }
    else
    {
        delta = ( currentvalue - 0 ) * percent;
    }
    
    var_4b6c2694 = 0.1 * delta;
    newvalue = currentvalue + var_4b6c2694;
    newvalue = math::clamp( newvalue, 0, 1 );
    self function_80251728( trait, newvalue );
    bbprint( "mpbehaviortraitupdate", "username %s trait %s percent %f", self.name, trait, percent );
}

// Namespace behaviortracker/behavior_tracker
// Params 3
// Checksum 0x7e7501d7, Offset: 0x830
// Size: 0x2d4
function function_dbc71f52( attacker, victim, damage )
{
    if ( isdefined( victim ) && victim isallowed() )
    {
        damageratio = float( damage ) / float( victim.maxhealth );
        math::clamp( damageratio, 0, 1 );
        damageratio *= -1;
        victim function_b1f374e6( "effectiveCombat", damageratio );
        
        if ( victim iswallrunning() )
        {
            victim function_b1f374e6( "effectiveWallRunCombat", damageratio );
        }
        
        if ( victim issliding() )
        {
            victim function_b1f374e6( "effectiveSlideCombat", damageratio );
        }
        
        if ( victim isdoublejumping() )
        {
            victim function_b1f374e6( "effectiveDoubleJumpCombat", damageratio );
        }
    }
    
    if ( isdefined( attacker ) && attacker isallowed() && attacker != victim )
    {
        damageratio = float( damage ) / float( attacker.maxhealth );
        math::clamp( damageratio, 0, 1 );
        attacker function_b1f374e6( "effectiveCombat", damageratio );
        
        if ( attacker iswallrunning() )
        {
            attacker function_b1f374e6( "effectiveWallRunCombat", damageratio );
        }
        
        if ( attacker issliding() )
        {
            attacker function_b1f374e6( "effectiveSlideCombat", damageratio );
        }
        
        if ( attacker isdoublejumping() )
        {
            attacker function_b1f374e6( "effectiveDoubleJumpCombat", damageratio );
        }
    }
}

// Namespace behaviortracker/behavior_tracker
// Params 2
// Checksum 0x5faad474, Offset: 0xb10
// Size: 0x234
function function_702c6ee2( attacker, victim )
{
    if ( isdefined( victim ) && victim isallowed() )
    {
        victim function_b1f374e6( "effectiveCombat", -1 );
        
        if ( victim iswallrunning() )
        {
            victim function_b1f374e6( "effectiveWallRunCombat", -1 );
        }
        
        if ( victim issliding() )
        {
            victim function_b1f374e6( "effectiveSlideCombat", -1 );
        }
        
        if ( victim isdoublejumping() )
        {
            victim function_b1f374e6( "effectiveDoubleJumpCombat", -1 );
        }
    }
    
    if ( isdefined( attacker ) && attacker isallowed() && attacker != victim )
    {
        attacker function_b1f374e6( "effectiveCombat", 1 );
        
        if ( attacker iswallrunning() )
        {
            attacker function_b1f374e6( "effectiveWallRunCombat", 1 );
        }
        
        if ( attacker issliding() )
        {
            attacker function_b1f374e6( "effectiveSlideCombat", 1 );
        }
        
        if ( attacker isdoublejumping() )
        {
            attacker function_b1f374e6( "effectiveDoubleJumpCombat", 1 );
        }
    }
}

// Namespace behaviortracker/behavior_tracker
// Params 0
// Checksum 0x6d14974a, Offset: 0xd50
// Size: 0x12e
function function_83084a92()
{
    if ( self.behaviortracker.version == 0 )
    {
        return;
    }
    
    self.behaviortracker.numRecords += 1;
    self function_91ad671a( "numRecords", self.behaviortracker.numRecords );
    traits = getarraykeys( self.behaviortracker.traits );
    
    for ( i = 0; i < traits.size ; i++ )
    {
        trait = traits[ i ];
        value = self.behaviortracker.traits[ trait ];
        self function_91ad671a( trait, value );
    }
}

// Namespace behaviortracker/behavior_tracker
// Params 1
// Checksum 0x749a8061, Offset: 0xe88
// Size: 0x2a
function function_16ff7316( trait )
{
    return self getdstat( "behaviorTracker", trait );
}

// Namespace behaviortracker/behavior_tracker
// Params 2
// Checksum 0x397443d8, Offset: 0xec0
// Size: 0x3c
function function_91ad671a( trait, value )
{
    self setdstat( "behaviorTracker", trait, value );
}

