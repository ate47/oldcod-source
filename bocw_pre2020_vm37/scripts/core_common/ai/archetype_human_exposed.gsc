#using scripts\core_common\ai\archetype_cover_utility;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\behavior_state_machine;
#using scripts\core_common\ai\systems\behavior_tree_utility;

#namespace archetype_human_exposed;

// Namespace archetype_human_exposed/archetype_human_exposed
// Params 0, eflags: 0x2
// Checksum 0x74ebbb96, Offset: 0x190
// Size: 0x56c
function autoexec registerbehaviorscriptfunctions()
{
    assert( isscriptfunctionptr( &hascloseenemy ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "hasCloseEnemy", &hascloseenemy );
    assert( isscriptfunctionptr( &nocloseenemyservice ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "noCloseEnemyService", &nocloseenemyservice );
    assert( isscriptfunctionptr( &tryreacquireservice ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "tryReacquireService", &tryreacquireservice );
    assert( isscriptfunctionptr( &preparetoreacttoenemy ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "prepareToReactToEnemy", &preparetoreacttoenemy );
    assert( isscriptfunctionptr( &resetreactiontoenemy ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "resetReactionToEnemy", &resetreactiontoenemy );
    assert( isscriptfunctionptr( &exposedUpdate ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "exposedUpdate", &exposedUpdate );
    assert( isscriptfunctionptr( &exposedsetdesiredstancetostand ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "exposedSetDesiredStanceToStand", &exposedsetdesiredstancetostand );
    assert( isscriptfunctionptr( &setpathmovedelayedrandom ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "setPathMoveDelayedRandom", &setpathmovedelayedrandom );
    assert( isscriptfunctionptr( &shouldusesidearmpistol ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "shouldUseSidearmPistol", &shouldusesidearmpistol );
    assert( isscriptfunctionptr( &function_ec3ea122 ) );
    behaviorstatemachine::registerbsmscriptapiinternal( #"hash_bf0ead963f57001", &function_ec3ea122 );
    assert( isscriptfunctionptr( &function_bb575b62 ) );
    behaviorstatemachine::registerbsmscriptapiinternal( #"hash_30b41b7040b96c68", &function_bb575b62 );
    assert( isscriptfunctionptr( &isusingsidearm ) );
    behaviorstatemachine::registerbsmscriptapiinternal( #"isusingsidearm", &isusingsidearm );
    assert( isscriptfunctionptr( &outofammo ) );
    behaviorstatemachine::registerbsmscriptapiinternal( #"outofammo", &outofammo );
    assert( isscriptfunctionptr( &function_56512b87 ) );
    behaviorstatemachine::registerbsmscriptapiinternal( #"hash_b01c4c3e55f7cd", &function_56512b87 );
}

// Namespace archetype_human_exposed/archetype_human_exposed
// Params 1, eflags: 0x4
// Checksum 0xc5d7b452, Offset: 0x708
// Size: 0x6a
function private exposedUpdate( entity )
{
    if ( is_true( entity.var_11b1735a ) && entity isatcovernode() )
    {
        aiutility::setnextfindbestcovertime( entity );
        entity.var_79f94433 = gettime();
        entity.var_11b1735a = undefined;
    }
}

// Namespace archetype_human_exposed/archetype_human_exposed
// Params 1, eflags: 0x4
// Checksum 0x42cc8179, Offset: 0x780
// Size: 0x44
function private preparetoreacttoenemy( behaviortreeentity )
{
    behaviortreeentity.newenemyreaction = 0;
    behaviortreeentity.malfunctionreaction = 0;
    behaviortreeentity pathmode( "move delayed", 1, 3 );
}

// Namespace archetype_human_exposed/archetype_human_exposed
// Params 1, eflags: 0x4
// Checksum 0x988ef2db, Offset: 0x7d0
// Size: 0x22
function private resetreactiontoenemy( behaviortreeentity )
{
    behaviortreeentity.newenemyreaction = 0;
    behaviortreeentity.malfunctionreaction = 0;
}

// Namespace archetype_human_exposed/archetype_human_exposed
// Params 1, eflags: 0x4
// Checksum 0x3f9afd79, Offset: 0x800
// Size: 0x54, Type: bool
function private nocloseenemyservice( behaviortreeentity )
{
    if ( isdefined( behaviortreeentity.enemy ) && aiutility::hascloseenemytomelee( behaviortreeentity ) )
    {
        behaviortreeentity clearpath();
        return true;
    }
    
    return false;
}

// Namespace archetype_human_exposed/archetype_human_exposed
// Params 1, eflags: 0x4
// Checksum 0xb5b60e4f, Offset: 0x860
// Size: 0x5a, Type: bool
function private hascloseenemy( behaviortreeentity )
{
    if ( !isdefined( behaviortreeentity.enemy ) )
    {
        return false;
    }
    
    if ( distancesquared( behaviortreeentity.origin, behaviortreeentity.enemy.origin ) < 22500 )
    {
        return true;
    }
    
    return false;
}

// Namespace archetype_human_exposed/archetype_human_exposed
// Params 1, eflags: 0x4
// Checksum 0x87d8073, Offset: 0x8c8
// Size: 0x2a, Type: bool
function private function_56512b87( entity )
{
    entity.bulletsinclip = entity.sidearm.clipsize;
    return true;
}

// Namespace archetype_human_exposed/archetype_human_exposed
// Params 1, eflags: 0x4
// Checksum 0xc0e470aa, Offset: 0x900
// Size: 0x36
function private outofammo( entity )
{
    outofammo = 0;
    
    if ( entity.bulletsinclip <= 0 )
    {
        outofammo = 1;
    }
    
    return outofammo;
}

// Namespace archetype_human_exposed/archetype_human_exposed
// Params 1, eflags: 0x4
// Checksum 0xf55343a1, Offset: 0x940
// Size: 0x10, Type: bool
function private function_bb575b62( *entity )
{
    return true;
}

// Namespace archetype_human_exposed/archetype_human_exposed
// Params 1, eflags: 0x4
// Checksum 0x27f70552, Offset: 0x958
// Size: 0x20, Type: bool
function private isusingsidearm( entity )
{
    return entity.weapon != entity.primaryweapon;
}

// Namespace archetype_human_exposed/archetype_human_exposed
// Params 1, eflags: 0x4
// Checksum 0xf561184b, Offset: 0x980
// Size: 0x34, Type: bool
function private function_ec3ea122( entity )
{
    return !shouldusesidearmpistol( entity, sqr( 500 ) );
}

// Namespace archetype_human_exposed/archetype_human_exposed
// Params 2, eflags: 0x4
// Checksum 0xa1c9981, Offset: 0x9c0
// Size: 0x38e
function private shouldusesidearmpistol( entity, checkdistance = sqr( 300 ) )
{
    var_64c23a1b = 0;
    
    if ( isdefined( entity.sidearm ) )
    {
        if ( is_true( entity.forcesidearm ) )
        {
            var_64c23a1b = 1;
        }
        else if ( is_true( entity.var_742cee23 ) && isdefined( entity.enemy ) && distancesquared( entity.origin, entity.enemy.origin ) < checkdistance )
        {
            targetangles = vectortoangles( entity.enemy.origin - entity.origin );
            entityangles = entity.angles;
            
            if ( isdefined( entity.node ) && ( entity.node.type == #"cover left" || entity.node.type == #"cover right" || entity.node.type == #"cover pillar" || entity.node.type == #"cover stand" || entity.node.type == #"conceal stand" || entity.node.type == #"cover crouch" || entity.node.type == #"cover crouch window" || entity.node.type == #"conceal crouch" ) && btapi_isatcovercondition( entity ) )
            {
                entityangles = entity.node.angles;
            }
            
            var_507685eb = angleclamp180( targetangles[ 1 ] - entityangles[ 1 ] );
            
            if ( abs( var_507685eb ) < 60 )
            {
                var_64c23a1b = 1;
            }
        }
    }
    
    /#
        var_f5093b66 = is_true( entity.usingsidearm );
        
        if ( var_64c23a1b != var_f5093b66 )
        {
            println( "<dev string:x38>" + entity getentnum() + "<dev string:x43>" + var_64c23a1b + "<dev string:x6b>" );
        }
    #/
    
    entity.usingsidearm = var_64c23a1b;
    return var_64c23a1b;
}

// Namespace archetype_human_exposed/archetype_human_exposed
// Params 2, eflags: 0x4
// Checksum 0x3aaa706c, Offset: 0xd58
// Size: 0x4c
function private setpathmovedelayedrandom( behaviortreeentity, *asmstatename )
{
    asmstatename pathmode( "move delayed", 0, randomfloatrange( 1, 3 ) );
}

// Namespace archetype_human_exposed/archetype_human_exposed
// Params 2, eflags: 0x4
// Checksum 0x26d2e811, Offset: 0xdb0
// Size: 0x7c
function private exposedsetdesiredstancetostand( behaviortreeentity, *asmstatename )
{
    aiutility::keepclaimnode( asmstatename );
    currentstance = asmstatename getblackboardattribute( "_stance" );
    asmstatename setblackboardattribute( "_desired_stance", "stand" );
}

// Namespace archetype_human_exposed/archetype_human_exposed
// Params 1, eflags: 0x4
// Checksum 0xbc087ca4, Offset: 0xe38
// Size: 0x36e, Type: bool
function private tryreacquireservice( behaviortreeentity )
{
    if ( !isdefined( behaviortreeentity.reacquire_state ) )
    {
        behaviortreeentity.reacquire_state = 0;
    }
    
    if ( !isdefined( behaviortreeentity.enemy ) )
    {
        behaviortreeentity.reacquire_state = 0;
        return false;
    }
    
    if ( aiutility::isexposedatcovercondition( behaviortreeentity ) )
    {
        return false;
    }
    
    if ( isdefined( behaviortreeentity.ai.var_47823ae7 ) && gettime() < behaviortreeentity.ai.var_47823ae7 )
    {
        behaviortreeentity.reacquire_state = 0;
        return false;
    }
    
    if ( behaviortreeentity.birthtime + 1000 > gettime() )
    {
        behaviortreeentity.reacquire_state = 0;
        return false;
    }
    
    if ( behaviortreeentity haspath() )
    {
        behaviortreeentity.reacquire_state = 0;
        return false;
    }
    
    if ( is_true( behaviortreeentity.fixednode ) )
    {
        behaviortreeentity.reacquire_state = 0;
        return false;
    }
    
    if ( behaviortreeentity seerecently( behaviortreeentity.enemy, 4 ) )
    {
        behaviortreeentity.reacquire_state = 0;
        return false;
    }
    
    dirtoenemy = vectornormalize( behaviortreeentity.enemy.origin - behaviortreeentity.origin );
    forward = anglestoforward( behaviortreeentity.angles );
    
    if ( vectordot( dirtoenemy, forward ) < 0.5 )
    {
        behaviortreeentity.reacquire_state = 0;
        return false;
    }
    
    switch ( behaviortreeentity.reacquire_state )
    {
        case 0:
        case 1:
        case 2:
            step_size = 32 + behaviortreeentity.reacquire_state * 32;
            reacquirepos = behaviortreeentity reacquirestep( step_size );
            break;
        case 4:
            if ( !behaviortreeentity cansee( behaviortreeentity.enemy ) || !behaviortreeentity canshootenemy() )
            {
                behaviortreeentity flagenemyunattackable();
            }
            
            break;
        default:
            if ( behaviortreeentity.reacquire_state > 15 )
            {
                behaviortreeentity.reacquire_state = 0;
                return false;
            }
            
            break;
    }
    
    if ( isvec( reacquirepos ) )
    {
        behaviortreeentity.ai.var_bb3caa0f = gettime();
        behaviortreeentity.ai.var_21eb2c42 = reacquirepos;
        behaviortreeentity function_a57c34b7( reacquirepos );
        return true;
    }
    
    behaviortreeentity.reacquire_state++;
    return false;
}

