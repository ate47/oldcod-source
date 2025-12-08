#using scripts\core_common\ai\archetype_locomotion_utility;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\behavior_state_machine;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai_shared;

#namespace namespace_2dd2c4d8;

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 0, eflags: 0x2
// Checksum 0xba59c75f, Offset: 0x218
// Size: 0x124c
function autoexec registerbehaviorscriptfunctions()
{
    assert( isscriptfunctionptr( &prepareformovement ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"prepareformovement", &prepareformovement );
    assert( isscriptfunctionptr( &prepareformovement ) );
    behaviorstatemachine::registerbsmscriptapiinternal( #"prepareformovement", &prepareformovement );
    assert( isscriptfunctionptr( &shouldtacticalarrivecondition ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"shouldtacticalarrive", &shouldtacticalarrivecondition );
    assert( isscriptfunctionptr( &planhumanarrivalatcover ) );
    behaviorstatemachine::registerbsmscriptapiinternal( #"planhumanarrivalatcover", &planhumanarrivalatcover );
    assert( isscriptfunctionptr( &shouldplanarrivalintocover ) );
    behaviorstatemachine::registerbsmscriptapiinternal( #"shouldplanarrivalintocover", &shouldplanarrivalintocover );
    assert( iscodefunctionptr( &btapi_shouldarriveexposed ) );
    behaviorstatemachine::registerbsmscriptapiinternal( #"btapi_shouldarriveexposed", &btapi_shouldarriveexposed );
    assert( iscodefunctionptr( &btapi_humannoncombatlocomotionupdate ) );
    behaviorstatemachine::registerbsmscriptapiinternal( #"btapi_humannoncombatlocomotionupdate", &btapi_humannoncombatlocomotionupdate );
    assert( isscriptfunctionptr( &combatlocomotionstart ) );
    behaviorstatemachine::registerbsmscriptapiinternal( #"combatlocomotionstart", &combatlocomotionstart );
    assert( isscriptfunctionptr( &function_52950d3d ) );
    behaviorstatemachine::registerbsmscriptapiinternal( #"hash_6b12744ac88be28f", &function_52950d3d );
    assert( isscriptfunctionptr( &function_4937d436 ) );
    behaviorstatemachine::registerbsmscriptapiinternal( #"hash_5ff9dd2b25d5c185", &function_4937d436 );
    assert( isscriptfunctionptr( &function_145df88b ) );
    behaviorstatemachine::registerbsmscriptapiinternal( #"hash_57981ededd43a0de", &function_145df88b );
    assert( isscriptfunctionptr( &function_2985b5fa ) );
    behaviorstatemachine::registerbsmscriptapiinternal( #"hash_4caa5fa7a97f83ea", &function_2985b5fa );
    assert( isscriptfunctionptr( &function_31a6aada ) );
    behaviorstatemachine::registerbsmscriptapiinternal( #"hash_341f9ccd69da418c", &function_31a6aada );
    assert( isscriptfunctionptr( &function_41ae663f ) );
    behaviorstatemachine::registerbsmscriptapiinternal( #"hash_cf6fb7a59d64171", &function_41ae663f );
    assert( isscriptfunctionptr( &function_76ff98aa ) );
    behaviorstatemachine::registerbsmscriptapiinternal( #"hash_1fa0b1eca87bd7ef", &function_76ff98aa );
    assert( isscriptfunctionptr( &function_e20dbfa4 ) );
    behaviorstatemachine::registerbsmscriptapiinternal( #"hash_66f99f9da0a69762", &function_e20dbfa4 );
    assert( isscriptfunctionptr( &function_888d9ea5 ) );
    behaviorstatemachine::registerbsmscriptapiinternal( #"hash_58eba240a42bbdcd", &function_888d9ea5 );
    assert( isscriptfunctionptr( &function_e20dbfa4 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_66f99f9da0a69762", &function_e20dbfa4 );
    assert( isscriptfunctionptr( &function_888d9ea5 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_58eba240a42bbdcd", &function_888d9ea5 );
    assert( isscriptfunctionptr( &function_45d8f364 ) );
    behaviorstatemachine::registerbsmscriptapiinternal( #"hash_4160e8b3456ab234", &function_45d8f364 );
    assert( isscriptfunctionptr( &function_27c368b1 ) );
    behaviorstatemachine::registerbsmscriptapiinternal( #"hash_6c5516f89d4ff0c7", &function_27c368b1 );
    assert( isscriptfunctionptr( &function_45d8f364 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_4160e8b3456ab234", &function_45d8f364 );
    assert( isscriptfunctionptr( &function_27c368b1 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_6c5516f89d4ff0c7", &function_27c368b1 );
    assert( iscodefunctionptr( &btapi_combatlocomotionupdate ) );
    behaviorstatemachine::registerbsmscriptapiinternal( #"btapi_combatlocomotionupdate", &btapi_combatlocomotionupdate );
    assert( iscodefunctionptr( &btapi_humannoncombatlocomotioncondition ) );
    behaviorstatemachine::registerbsmscriptapiinternal( #"btapi_humannoncombatlocomotioncondition", &btapi_humannoncombatlocomotioncondition );
    assert( iscodefunctionptr( &btapi_humancombatlocomotioncondition ) );
    behaviorstatemachine::registerbsmscriptapiinternal( #"btapi_humancombatlocomotioncondition", &btapi_humancombatlocomotioncondition );
    assert( isscriptfunctionptr( &preparetostopnearenemy ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"preparetostopnearenemy", &preparetostopnearenemy );
    assert( isscriptfunctionptr( &preparetostopnearenemy ) );
    behaviorstatemachine::registerbsmscriptapiinternal( #"preparetostopnearenemy", &preparetostopnearenemy );
    assert( isscriptfunctionptr( &preparetomoveawayfromnearbyenemy ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"preparetomoveawayfromnearbyenemy", &preparetomoveawayfromnearbyenemy );
    assert( isscriptfunctionptr( &shouldtacticalwalkpain ) );
    behaviorstatemachine::registerbsmscriptapiinternal( #"shouldtacticalwalkpain", &shouldtacticalwalkpain );
    assert( isscriptfunctionptr( &begintacticalwalkpain ) );
    behaviorstatemachine::registerbsmscriptapiinternal( #"begintacticalwalkpain", &begintacticalwalkpain );
    assert( isscriptfunctionptr( &shouldcontinuetacticalwalkpain ) );
    behaviorstatemachine::registerbsmscriptapiinternal( #"shouldcontinuetacticalwalkpain", &shouldcontinuetacticalwalkpain );
    assert( isscriptfunctionptr( &bsmlocomotionhasvalidpaininterrupt ) );
    behaviorstatemachine::registerbsmscriptapiinternal( #"bsmlocomotionhasvalidpaininterrupt", &bsmlocomotionhasvalidpaininterrupt );
    assert( isscriptfunctionptr( &function_1972c057 ) );
    behaviorstatemachine::registerbsmscriptapiinternal( #"hash_61aa304b516f76a7", &function_1972c057 );
    assert( isscriptfunctionptr( &function_968efd1f ) );
    behaviorstatemachine::registerbsmscriptapiinternal( #"hash_17b044df7de84a21", &function_968efd1f );
    assert( isscriptfunctionptr( &function_80c579d8 ) );
    behaviorstatemachine::registerbsmscriptapiinternal( #"hash_2a9f4015fc6217df", &function_80c579d8 );
    assert( iscodefunctionptr( &function_2da76de ) );
    behaviorstatemachine::registerbsmscriptapiinternal( #"hash_34f3c9eb834c01fb", &function_2da76de );
    assert( iscodefunctionptr( &function_2da76de ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_34f3c9eb834c01fb", &function_2da76de );
    assert( isscriptfunctionptr( &function_c34dd9f8 ) );
    behaviorstatemachine::registerbsmscriptapiinternal( #"hash_2746da0437b7aaf9", &function_c34dd9f8 );
    assert( isscriptfunctionptr( &function_f2c9142 ) );
    behaviorstatemachine::registerbsmscriptapiinternal( #"hash_77f68c7d2552ba09", &function_f2c9142 );
    assert( isscriptfunctionptr( &function_d8a81861 ) );
    behaviorstatemachine::registerbsmscriptapiinternal( #"hash_3d48a4a68d62f9b2", &function_d8a81861 );
    assert( isscriptfunctionptr( &function_ab6f96b6 ) );
    behaviorstatemachine::registerbsmscriptapiinternal( #"hash_25898377b0649f0e", &function_ab6f96b6 );
    assert( isscriptfunctionptr( &function_7ba867a8 ) );
    behaviorstatemachine::registerbsmscriptapiinternal( #"hash_631ad7fc5b704ad", &function_7ba867a8 );
    assert( isscriptfunctionptr( &function_52c3ab28 ) );
    behaviorstatemachine::registerbsmscriptapiinternal( #"hash_799d1239ee7780df", &function_52c3ab28 );
    assert( isscriptfunctionptr( &function_b1092561 ) );
    behaviorstatemachine::registerbsmscriptapiinternal( #"hash_7a0baaf803e988e1", &function_b1092561 );
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x187b06d, Offset: 0x1470
// Size: 0x6e
function private shouldtacticalwalkpain( entity )
{
    if ( ( !isdefined( entity.startpaintime ) || entity.startpaintime + 3000 < gettime() ) && randomfloat( 1 ) > 0.25 )
    {
        return bsmlocomotionhasvalidpaininterrupt( entity );
    }
    
    return 0;
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x1214ed11, Offset: 0x14e8
// Size: 0x1a, Type: bool
function private begintacticalwalkpain( entity )
{
    entity.startpaintime = gettime();
    return true;
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x8f340d13, Offset: 0x1510
// Size: 0x20, Type: bool
function private shouldcontinuetacticalwalkpain( entity )
{
    return entity.startpaintime + 100 >= gettime();
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x841fa322, Offset: 0x1538
// Size: 0x2a
function private bsmlocomotionhasvalidpaininterrupt( entity )
{
    return entity hasvalidinterrupt( "pain" );
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0xa969229b, Offset: 0x1570
// Size: 0x3c
function private preparetostopnearenemy( behaviortreeentity )
{
    behaviortreeentity clearpath();
    aiutility::keepclaimnode( behaviortreeentity );
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x333ce0e5, Offset: 0x15b8
// Size: 0x3c
function private preparetomoveawayfromnearbyenemy( behaviortreeentity )
{
    behaviortreeentity clearpath();
    aiutility::keepclaimnode( behaviortreeentity );
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x137255d6, Offset: 0x1600
// Size: 0x208, Type: bool
function private shouldplanarrivalintocover( behaviortreeentity )
{
    goingtocovernode = isdefined( behaviortreeentity.node ) && iscovernode( behaviortreeentity.node ) && behaviortreeentity function_4c2fffe6( behaviortreeentity.node );
    
    if ( !goingtocovernode )
    {
        return false;
    }
    
    if ( !aiutility::function_c94f0d1( behaviortreeentity ) )
    {
        return false;
    }
    
    if ( isdefined( behaviortreeentity.pathgoalpos ) )
    {
        if ( isdefined( behaviortreeentity.arrivalfinalpos ) )
        {
            if ( behaviortreeentity.arrivalfinalpos != behaviortreeentity.pathgoalpos )
            {
                return true;
            }
            else if ( behaviortreeentity.ai.replannedcoverarrival === 0 && isdefined( behaviortreeentity.exitpos ) && isdefined( behaviortreeentity.predictedexitpos ) )
            {
                behaviortreeentity.ai.replannedcoverarrival = 1;
                exitdir = vectornormalize( behaviortreeentity.predictedexitpos - behaviortreeentity.exitpos );
                currentdir = vectornormalize( behaviortreeentity.origin - behaviortreeentity.exitpos );
                
                if ( vectordot( exitdir, currentdir ) < cos( 30 ) )
                {
                    behaviortreeentity.predictedarrivaldirectionvalid = 0;
                    return true;
                }
                
                if ( behaviortreeentity.var_2dc0ed5e !== function_15a5703b( #"human", behaviortreeentity function_28e7d252() ) )
                {
                    return true;
                }
            }
        }
    }
    
    return false;
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0xcfa865cd, Offset: 0x1810
// Size: 0x100, Type: bool
function private combatlocomotionstart( behaviortreeentity )
{
    behaviortreeentity setblackboardattribute( "_desired_stance", "stand" );
    behaviortreeentity ai::function_fc7bd6c7();
    randomchance = randomint( 100 );
    
    if ( randomchance > 50 )
    {
        behaviortreeentity setblackboardattribute( "_run_n_gun_variation", "variation_forward" );
        return true;
    }
    
    if ( randomchance > 25 )
    {
        behaviortreeentity setblackboardattribute( "_run_n_gun_variation", "variation_strafe_1" );
        return true;
    }
    
    behaviortreeentity setblackboardattribute( "_run_n_gun_variation", "variation_strafe_2" );
    return true;
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0xd4821ef0, Offset: 0x1918
// Size: 0x28, Type: bool
function private function_52950d3d( behaviortreeentity )
{
    behaviortreeentity ai::function_f6060793();
    return true;
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 2
// Checksum 0xcdf3ad25, Offset: 0x1948
// Size: 0x4c
function function_3b9e6ead( entity, var_cddf6299 )
{
    if ( function_52c3ab28( entity ) )
    {
        entity astsearch( var_cddf6299, "planHumanTurnAnimations" );
    }
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x6ff1ad42, Offset: 0x19a0
// Size: 0x120, Type: bool
function private function_4937d436( behaviortreeentity )
{
    behaviortreeentity setblackboardattribute( "_desired_stance", "stand" );
    behaviortreeentity function_ed7c3705( "run_n_gun" );
    behaviortreeentity ai::function_fc7bd6c7();
    randomchance = randomint( 100 );
    
    if ( randomchance > 50 )
    {
        behaviortreeentity setblackboardattribute( "_run_n_gun_variation", "variation_forward" );
        return true;
    }
    
    if ( randomchance > 25 )
    {
        behaviortreeentity setblackboardattribute( "_run_n_gun_variation", "variation_strafe_1" );
        return true;
    }
    
    behaviortreeentity setblackboardattribute( "_run_n_gun_variation", "variation_strafe_2" );
    return true;
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x7eb64f4, Offset: 0x1ac8
// Size: 0x4c, Type: bool
function private function_145df88b( entity )
{
    if ( btapi_combatlocomotionupdate( entity ) )
    {
        function_3b9e6ead( entity, "turn@locomotion" );
        return true;
    }
    
    return false;
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x24b3d3ef, Offset: 0x1b20
// Size: 0x48, Type: bool
function private function_2985b5fa( behaviortreeentity )
{
    behaviortreeentity ai::function_f6060793();
    behaviortreeentity function_ed7c3705( "none" );
    return true;
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x80c4c457, Offset: 0x1b70
// Size: 0x70, Type: bool
function private function_31a6aada( behaviortreeentity )
{
    behaviortreeentity setblackboardattribute( "_desired_stance", "stand" );
    behaviortreeentity function_ed7c3705( "non_combat_run" );
    behaviortreeentity ai::function_fc7bd6c7();
    return true;
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x86111871, Offset: 0x1be8
// Size: 0x4c, Type: bool
function private function_41ae663f( entity )
{
    if ( btapi_humannoncombatlocomotionupdate( entity ) )
    {
        function_3b9e6ead( entity, "turn@locomotion" );
        return true;
    }
    
    return false;
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0xfeddace8, Offset: 0x1c40
// Size: 0x48, Type: bool
function private function_76ff98aa( behaviortreeentity )
{
    behaviortreeentity ai::function_f6060793();
    behaviortreeentity function_ed7c3705( "none" );
    return true;
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x75df33a8, Offset: 0x1c90
// Size: 0x28, Type: bool
function private function_e20dbfa4( behaviortreeentity )
{
    behaviortreeentity ai::function_fc7bd6c7();
    return true;
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x8231f4f5, Offset: 0x1cc0
// Size: 0x28, Type: bool
function private function_888d9ea5( behaviortreeentity )
{
    behaviortreeentity ai::function_f6060793();
    return true;
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0xa4a47100, Offset: 0x1cf0
// Size: 0x28, Type: bool
function private function_45d8f364( behaviortreeentity )
{
    behaviortreeentity ai::function_fc7bd6c7();
    return true;
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0xca21fd1f, Offset: 0x1d20
// Size: 0x28, Type: bool
function private function_27c368b1( behaviortreeentity )
{
    behaviortreeentity ai::function_f6060793();
    return true;
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x6c729828, Offset: 0x1d50
// Size: 0x38, Type: bool
function private prepareformovement( behaviortreeentity )
{
    behaviortreeentity setblackboardattribute( "_stance", "stand" );
    return true;
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x6d7705ec, Offset: 0x1d90
// Size: 0x32, Type: bool
function private isarrivingfour( arrivalangle )
{
    if ( arrivalangle >= 45 && arrivalangle <= 120 )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x81ad05de, Offset: 0x1dd0
// Size: 0x32, Type: bool
function private isarrivingone( arrivalangle )
{
    if ( arrivalangle >= 120 && arrivalangle <= 165 )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0xe0fbc327, Offset: 0x1e10
// Size: 0x32, Type: bool
function private isarrivingtwo( arrivalangle )
{
    if ( arrivalangle >= 165 && arrivalangle <= 195 )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x23f1d231, Offset: 0x1e50
// Size: 0x32, Type: bool
function private isarrivingthree( arrivalangle )
{
    if ( arrivalangle >= 195 && arrivalangle <= 240 )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0xe9d8b425, Offset: 0x1e90
// Size: 0x32, Type: bool
function private isarrivingsix( arrivalangle )
{
    if ( arrivalangle >= 240 && arrivalangle <= 315 )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x90b7369, Offset: 0x1ed0
// Size: 0x32, Type: bool
function private isfacingfour( facingangle )
{
    if ( facingangle >= 45 && facingangle <= 135 )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0xacb47016, Offset: 0x1f10
// Size: 0x32, Type: bool
function private isfacingeight( facingangle )
{
    if ( facingangle >= -45 && facingangle <= 45 )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x562f4e24, Offset: 0x1f50
// Size: 0x30, Type: bool
function private isfacingseven( facingangle )
{
    if ( facingangle >= 0 && facingangle <= 90 )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x6ec8416c, Offset: 0x1f88
// Size: 0x32, Type: bool
function private isfacingsix( facingangle )
{
    if ( facingangle >= -135 && facingangle <= -45 )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0xe67efd53, Offset: 0x1fc8
// Size: 0x30, Type: bool
function private isfacingnine( facingangle )
{
    if ( facingangle >= -90 && facingangle <= 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x62b41415, Offset: 0x2000
// Size: 0x3fa, Type: bool
function private shouldtacticalarrivecondition( behaviortreeentity )
{
    if ( getdvarint( #"enabletacticalarrival", 0 ) != 1 )
    {
        return false;
    }
    
    if ( !isdefined( behaviortreeentity.node ) )
    {
        return false;
    }
    
    if ( !( behaviortreeentity.node.type == #"cover left" ) )
    {
        return false;
    }
    
    stance = behaviortreeentity getblackboardattribute( "_arrival_stance" );
    
    if ( stance != "stand" )
    {
        return false;
    }
    
    arrivaldistance = 35;
    
    /#
        arrivaldvar = getdvarint( #"tacarrivaldistance", 0 );
        
        if ( arrivaldvar != 0 )
        {
            arrivaldistance = arrivaldvar;
        }
    #/
    
    nodeoffsetposition = behaviortreeentity getnodeoffsetposition( behaviortreeentity.node );
    
    if ( distance( nodeoffsetposition, behaviortreeentity.origin ) > arrivaldistance || distance( nodeoffsetposition, behaviortreeentity.origin ) < 25 )
    {
        return false;
    }
    
    entityangles = vectortoangles( behaviortreeentity.origin - nodeoffsetposition );
    
    if ( abs( behaviortreeentity.node.angles[ 1 ] - entityangles[ 1 ] ) < 60 )
    {
        return false;
    }
    
    tacticalfaceangle = behaviortreeentity getblackboardattribute( "_tactical_arrival_facing_yaw" );
    arrivalangle = behaviortreeentity getblackboardattribute( "_locomotion_arrival_yaw" );
    
    if ( isarrivingfour( arrivalangle ) )
    {
        if ( !isfacingsix( tacticalfaceangle ) && !isfacingeight( tacticalfaceangle ) && !isfacingfour( tacticalfaceangle ) )
        {
            return false;
        }
    }
    else if ( isarrivingone( arrivalangle ) )
    {
        if ( !isfacingnine( tacticalfaceangle ) && !isfacingseven( tacticalfaceangle ) )
        {
            return false;
        }
    }
    else if ( isarrivingtwo( arrivalangle ) )
    {
        if ( !isfacingeight( tacticalfaceangle ) )
        {
            return false;
        }
    }
    else if ( isarrivingthree( arrivalangle ) )
    {
        if ( !isfacingseven( tacticalfaceangle ) && !isfacingnine( tacticalfaceangle ) )
        {
            return false;
        }
    }
    else if ( isarrivingsix( arrivalangle ) )
    {
        if ( !isfacingfour( tacticalfaceangle ) && !isfacingeight( tacticalfaceangle ) && !isfacingsix( tacticalfaceangle ) )
        {
            return false;
        }
    }
    else
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 2, eflags: 0x4
// Checksum 0xaa339639, Offset: 0x2408
// Size: 0x694, Type: bool
function private planhumanarrivalatcover( behaviortreeentity, arrivalanim )
{
    if ( behaviortreeentity ai::get_behavior_attribute( "disablearrivals" ) )
    {
        return false;
    }
    
    behaviortreeentity setblackboardattribute( "_desired_stance", "stand" );
    
    if ( !isdefined( arrivalanim ) )
    {
        return false;
    }
    
    if ( !aiutility::function_c94f0d1( behaviortreeentity ) )
    {
        return false;
    }
    
    if ( isdefined( behaviortreeentity.node ) && isdefined( behaviortreeentity.pathgoalpos ) )
    {
        if ( !iscovernode( behaviortreeentity.node ) || !behaviortreeentity function_4c2fffe6( behaviortreeentity.node ) )
        {
            return false;
        }
        
        nodeoffsetposition = behaviortreeentity getnodeoffsetposition( behaviortreeentity.node );
        
        if ( nodeoffsetposition != behaviortreeentity.pathgoalpos )
        {
            return false;
        }
        
        if ( isdefined( arrivalanim ) )
        {
            splittime = getarrivalsplittime( arrivalanim );
            issplitarrival = splittime > 0 && splittime < 1;
            nodeapproachyaw = behaviortreeentity getnodeoffsetangles( behaviortreeentity.node )[ 1 ];
            angle = ( 0, nodeapproachyaw - getangledelta( arrivalanim ), 0 );
            forwarddir = anglestoforward( angle );
            rightdir = anglestoright( angle );
            animlength = getanimlength( arrivalanim );
            var_ff177acc = getmovedelta( arrivalanim, 0, ( animlength - 0.2 ) / animlength );
            
            if ( issplitarrival )
            {
                var_d56d1d2d = getmovedelta( arrivalanim, 0, splittime );
                var_f0dd8bc8 = var_ff177acc - var_d56d1d2d;
                var_fb34812f = vectorscale( forwarddir, var_d56d1d2d[ 0 ] );
                var_944b0150 = vectorscale( rightdir, var_d56d1d2d[ 1 ] );
                var_85e98eb9 = vectorscale( forwarddir, var_f0dd8bc8[ 0 ] );
                var_a358ca3 = vectorscale( rightdir, var_f0dd8bc8[ 1 ] );
                var_6e775fcc = nodeoffsetposition - var_85e98eb9 + var_a358ca3;
                coverenterpos = var_6e775fcc - var_fb34812f + var_944b0150;
                var_5fd77fe1 = var_6e775fcc + ( 0, 0, 8 );
                var_c7c8e445 = nodeoffsetposition + ( 0, 0, 8 );
                var_6c21c197 = coverenterpos + ( 0, 0, 8 );
                
                /#
                    recordline( var_5fd77fe1, var_c7c8e445, ( 1, 0.5, 0 ), "<dev string:x38>" );
                    record3dtext( "<dev string:x46>", var_5fd77fe1, ( 1, 0.5, 0 ), "<dev string:x38>" );
                    recordline( var_6c21c197, var_5fd77fe1, ( 1, 0.5, 0 ), "<dev string:x38>" );
                    record3dtext( "<dev string:x5e>", var_6c21c197, ( 1, 0.5, 0 ), "<dev string:x38>" );
                #/
                
                if ( !behaviortreeentity maymovefrompointtopoint( var_5fd77fe1, var_c7c8e445, 1, 1, behaviortreeentity, 0.05 ) )
                {
                    return false;
                }
                
                if ( !behaviortreeentity maymovefrompointtopoint( var_6c21c197, var_5fd77fe1, 1, 1, behaviortreeentity, 0.05 ) )
                {
                    return false;
                }
            }
            else
            {
                forward = vectorscale( forwarddir, var_ff177acc[ 0 ] );
                right = vectorscale( rightdir, var_ff177acc[ 1 ] );
                coverenterpos = nodeoffsetposition - forward + right;
                var_c7c8e445 = nodeoffsetposition + ( 0, 0, 8 );
                var_6c21c197 = coverenterpos + ( 0, 0, 8 );
                
                /#
                    recordline( var_6c21c197, var_c7c8e445, ( 1, 0.5, 0 ), "<dev string:x38>" );
                    record3dtext( "<dev string:x5e>", var_6c21c197, ( 1, 0.5, 0 ), "<dev string:x38>" );
                #/
                
                if ( !behaviortreeentity maymovefrompointtopoint( var_6c21c197, var_c7c8e445, 1, 1, behaviortreeentity, 0.05 ) )
                {
                    return false;
                }
            }
            
            if ( !checkcoverarrivalconditions( coverenterpos, nodeoffsetposition ) )
            {
                return false;
            }
            
            if ( ispointonnavmesh( coverenterpos, behaviortreeentity ) )
            {
                behaviortreeentity.var_2dc0ed5e = function_15a5703b( #"human", behaviortreeentity function_28e7d252() );
                
                /#
                    recordcircle( coverenterpos, 2, ( 1, 0, 0 ), "<dev string:x74>" );
                #/
                
                behaviortreeentity function_a57c34b7( coverenterpos, behaviortreeentity.pathgoalpos );
                return true;
            }
        }
    }
    
    return false;
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 2, eflags: 0x4
// Checksum 0xde8a4445, Offset: 0x2aa8
// Size: 0x2ec, Type: bool
function private checkcoverarrivalconditions( coverenterpos, coverpos )
{
    distsqtonode = distancesquared( self.origin, coverpos );
    distsqfromnodetoenterpos = distancesquared( coverpos, coverenterpos );
    awayfromenterpos = distsqtonode >= distsqfromnodetoenterpos + 150;
    
    if ( !awayfromenterpos )
    {
        return false;
    }
    
    trace = groundtrace( coverenterpos + ( 0, 0, 72 ), coverenterpos + ( 0, 0, -72 ), 0, 0, 0 );
    
    if ( isdefined( trace[ #"position" ] ) && abs( trace[ #"position" ][ 2 ] - coverpos[ 2 ] ) > 30 )
    {
        /#
            if ( getdvarint( #"ai_debugarrivals", 0 ) )
            {
                recordcircle( coverenterpos, 1, ( 1, 0, 0 ), "<dev string:x38>" );
                record3dtext( "<dev string:x7e>", coverenterpos, ( 1, 0, 0 ), "<dev string:x38>", undefined, 0.4 );
                recordcircle( trace[ #"position" ], 1, ( 1, 0, 0 ), "<dev string:x38>" );
                record3dtext( "<dev string:x98>" + int( abs( trace[ #"position" ][ 2 ] - coverpos[ 2 ] ) ), trace[ #"position" ] + ( 0, 0, 5 ), ( 1, 0, 0 ), "<dev string:x38>", undefined, 0.4 );
                record3dtext( "<dev string:xb0>" + 30, trace[ #"position" ], ( 1, 0, 0 ), "<dev string:x38>", undefined, 0.4 );
                recordline( coverenterpos, trace[ #"position" ], ( 1, 0, 0 ), "<dev string:x38>" );
            }
        #/
        
        return false;
    }
    
    return true;
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x72f2dcc0, Offset: 0x2da0
// Size: 0x220
function private getarrivalsplittime( arrivalanim )
{
    if ( !isdefined( level.animarrivalsplittimes ) )
    {
        level.animarrivalsplittimes = [];
    }
    
    if ( isdefined( level.animarrivalsplittimes[ arrivalanim ] ) )
    {
        return level.animarrivalsplittimes[ arrivalanim ];
    }
    
    bestsplit = -1;
    
    if ( animhasnotetrack( arrivalanim, "corner" ) )
    {
        times = getnotetracktimes( arrivalanim, "corner" );
        assert( times.size == 1, "<dev string:xde>" + function_9e72a96( arrivalanim ) + "<dev string:xf0>" + "<dev string:x10f>" + "<dev string:x119>" );
        bestsplit = times[ 0 ];
    }
    else
    {
        /#
            var_1e582813 = function_9e72a96( arrivalanim );
            var_ccd34262 = issubstr( var_1e582813, "<dev string:x128>" ) || issubstr( var_1e582813, "<dev string:x12e>" ) || issubstr( var_1e582813, "<dev string:x134>" );
            var_ffc4381b = issubstr( var_1e582813, "<dev string:x13a>" );
            
            if ( var_ccd34262 && !var_ffc4381b )
            {
                assertmsg( "<dev string:xde>" + var_1e582813 + "<dev string:x145>" + "<dev string:x10f>" + "<dev string:x154>" );
            }
        #/
    }
    
    level.animarrivalsplittimes[ arrivalanim ] = bestsplit;
    return bestsplit;
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 2, eflags: 0x4
// Checksum 0x81841446, Offset: 0x2fc8
// Size: 0x92
function private deltarotate( delta, yaw )
{
    cosine = cos( yaw );
    sine = sin( yaw );
    return ( delta[ 0 ] * cosine - delta[ 1 ] * sine, delta[ 1 ] * cosine + delta[ 0 ] * sine, 0 );
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 0, eflags: 0x4
// Checksum 0x3c8eb7a2, Offset: 0x3068
// Size: 0x72
function private function_e7f9cf11()
{
    assert( self.archetype == #"human" || self.archetype == #"civilian" );
    speed = self function_28e7d252();
    return speed;
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 0, eflags: 0x4
// Checksum 0xff8f6816, Offset: 0x30e8
// Size: 0x5a
function private function_3298688b()
{
    assert( self.archetype == #"human" );
    speed = self function_359fd121();
    return speed;
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 0, eflags: 0x4
// Checksum 0xfc4573f2, Offset: 0x3150
// Size: 0x3a
function private function_eb731440()
{
    assert( self.archetype == #"human" );
    return self.var_55a3f1d3;
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 0, eflags: 0x4
// Checksum 0x64ec41b2, Offset: 0x3198
// Size: 0x5e
function private function_631d7179()
{
    assert( self.archetype == #"human" );
    
    if ( is_true( self.var_dd1cd771 ) )
    {
        return self.var_31162969;
    }
    
    return self.var_55a3f1d3;
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x18d98c1a, Offset: 0x3200
// Size: 0x164, Type: bool
function private function_cb9c22a2( entity )
{
    if ( entity haspath() && !isdefined( entity.traversestartnode ) && !entity function_3c566724() )
    {
        if ( entity getorientmode( "script" ) != "face enemy strafe" )
        {
            entity.var_6a36b46d = 1;
            entity animmode( "zonly_physics" );
            entity orientmode( "face enemy strafe" );
            entity.var_6a36b46d = 0;
        }
    }
    
    var_55a3f1d3 = entity function_144f21ef();
    
    if ( is_true( entity.ai.var_c978f9a1 ) )
    {
        if ( -85 < var_55a3f1d3 && var_55a3f1d3 < 35 )
        {
            return false;
        }
        
        return true;
    }
    
    if ( var_55a3f1d3 < -90 || var_55a3f1d3 > 135 )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0xe0b59047, Offset: 0x3370
// Size: 0x2e, Type: bool
function private function_1972c057( entity )
{
    if ( function_cb9c22a2( entity ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x3920c7a3, Offset: 0x33a8
// Size: 0x2e, Type: bool
function private function_968efd1f( entity )
{
    if ( !function_cb9c22a2( entity ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x899a6cb5, Offset: 0x33e0
// Size: 0x5e, Type: bool
function private function_c2fb1a1e( entity )
{
    if ( !level.enablehipflip )
    {
        return false;
    }
    
    starttime = entity.ai.var_f92c6536;
    
    if ( !isdefined( starttime ) )
    {
        return false;
    }
    
    if ( gettime() - starttime < 1000 )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x7ee8dac2, Offset: 0x3448
// Size: 0xa8, Type: bool
function private function_aede5c43( entity )
{
    if ( entity haspath() )
    {
        disttogoal = distancesquared( entity.pathgoalpos, entity.origin );
        
        if ( disttogoal < 10000 )
        {
            return false;
        }
    }
    
    footstep = entity function_4b57124f( 150 );
    
    if ( footstep != "left foot" )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x20ee547d, Offset: 0x34f8
// Size: 0xf6, Type: bool
function private function_c34dd9f8( entity )
{
    if ( !function_c2fb1a1e( entity ) )
    {
        return false;
    }
    
    if ( !is_true( entity.ai.var_c978f9a1 ) )
    {
        var_55a3f1d3 = entity.ai.var_7979fbb2;
        
        if ( var_55a3f1d3 < -120 && var_55a3f1d3 < entity.ai.var_798e85cd )
        {
            return function_aede5c43( entity );
        }
        
        if ( var_55a3f1d3 > 55 && var_55a3f1d3 < 90 && var_55a3f1d3 > entity.ai.var_798e85cd )
        {
            return function_aede5c43( entity );
        }
    }
    
    return false;
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x938acf47, Offset: 0x35f8
// Size: 0x106, Type: bool
function private function_f2c9142( entity )
{
    if ( !function_c2fb1a1e( entity ) )
    {
        return false;
    }
    
    if ( is_true( entity.ai.var_c978f9a1 ) )
    {
        var_55a3f1d3 = entity.ai.var_7979fbb2;
        
        if ( var_55a3f1d3 < 55 && var_55a3f1d3 > 20 && var_55a3f1d3 < entity.ai.var_798e85cd )
        {
            return function_aede5c43( entity );
        }
        
        if ( var_55a3f1d3 > -135 && var_55a3f1d3 < -105 && var_55a3f1d3 > entity.ai.var_798e85cd )
        {
            return function_aede5c43( entity );
        }
    }
    
    return false;
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0xf4c1fe98, Offset: 0x3708
// Size: 0xca, Type: bool
function private function_d8a81861( entity )
{
    if ( !level.enablehipflip )
    {
        return function_1972c057( entity );
    }
    
    if ( !is_true( entity.ai.var_c978f9a1 ) )
    {
        var_55a3f1d3 = entity.ai.var_7979fbb2;
        
        if ( var_55a3f1d3 > 135 && var_55a3f1d3 > entity.ai.var_798e85cd )
        {
            return true;
        }
        
        if ( var_55a3f1d3 < -135 && var_55a3f1d3 < entity.ai.var_798e85cd )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0xc552f620, Offset: 0x37e0
// Size: 0xaa, Type: bool
function private function_ab6f96b6( entity )
{
    if ( !level.enablehipflip )
    {
        return function_968efd1f( entity );
    }
    
    if ( is_true( entity.ai.var_c978f9a1 ) )
    {
        var_55a3f1d3 = entity.ai.var_7979fbb2;
        
        if ( var_55a3f1d3 > -60 && var_55a3f1d3 < 45 && var_55a3f1d3 > entity.ai.var_798e85cd )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 1
// Checksum 0x74a7dda7, Offset: 0x3898
// Size: 0x66
function function_7ba867a8( entity )
{
    var_422d3ed4 = entity function_fe54a83e();
    
    if ( var_422d3ed4 >= 45 && var_422d3ed4 <= 315 )
    {
        return 1;
    }
    
    entity.var_3b77553e = -1;
    return 0;
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 1
// Checksum 0x6f1ab204, Offset: 0x3908
// Size: 0x150, Type: bool
function function_52c3ab28( entity )
{
    if ( !function_7ba867a8( entity ) )
    {
        return false;
    }
    else if ( !isdefined( entity.var_3b77553e ) || entity.var_3b77553e <= 0 )
    {
        return true;
    }
    else if ( !isdefined( entity.var_7b1f015a ) )
    {
        return true;
    }
    else if ( distance2dsquared( entity.var_7b1f015a.pos, entity.var_14b548c5 ) > sqr( 4 ) )
    {
        return true;
    }
    else if ( abs( entity.var_7b1f015a.angle - entity.var_871c9e86 ) > 1 )
    {
        return true;
    }
    else if ( entity.var_7b1f015a.var_568d90d2 != function_15a5703b( #"human", entity function_359fd121() ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 1
// Checksum 0xf56bfb54, Offset: 0x3a60
// Size: 0x1b0, Type: bool
function function_b1092561( entity )
{
    if ( ( isdefined( entity.var_3b77553e ) ? entity.var_3b77553e : 0 ) > 0 && isdefined( entity.var_7b1f015a.animation ) && isdefined( entity.var_14b548c5 ) )
    {
        splittime = 0.5;
        
        if ( animhasnotetrack( entity.var_7b1f015a.animation, "corner" ) )
        {
            times = getnotetracktimes( entity.var_7b1f015a.animation, "corner" );
            assert( times.size == 1, "<dev string:x183>" + function_9e72a96( entity.var_7b1f015a.animation ) + "<dev string:xf0>" + "<dev string:x10f>" + "<dev string:x119>" );
            splittime = times[ 0 ];
        }
        
        localdeltahalfvector = getmovedelta( entity.var_7b1f015a.animation, 0, splittime );
        
        if ( distance2dsquared( entity.origin, entity.var_14b548c5 ) <= lengthsquared( localdeltahalfvector ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x34d9a85d, Offset: 0x3c18
// Size: 0x12
function private function_80c579d8( *entity )
{
    return self.var_ca796dd1;
}

// Namespace namespace_2dd2c4d8/archetype_human_locomotion
// Params 0
// Checksum 0xf3bd3951, Offset: 0x3c38
// Size: 0x70
function function_2fa3d847()
{
    enemy = self.enemy;
    
    if ( !isdefined( enemy ) )
    {
        return 0;
    }
    
    var_d9894e47 = self function_584873ef();
    
    /#
        recordenttext( "<dev string:x192>" + var_d9894e47, self, ( 1, 0, 0 ), "<dev string:x38>" );
    #/
    
    return var_d9894e47;
}

