#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1b01e95a6b5270fd;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_3faf478d5b0850fe;
#using script_47851dbeea22fe66;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_79cafc73107dd980;
#using scripts\core_common\ai\archetype_damage_utility;
#using scripts\core_common\ai\systems\animation_state_machine_mocomp;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\ai\systems\behavior_state_machine;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\util_shared;

#namespace namespace_a204c0f4;

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 0
// Checksum 0x3536e96, Offset: 0x928
// Size: 0x36c
function init()
{
    namespace_250e9486::function_252dff4d( "margwa", &function_e9608fd3 );
    spawner::add_archetype_spawn_function( #"margwa", &function_a8751f9b );
    clientfield::register( "actor", "margwa_head_left", 1, 2, "int" );
    clientfield::register( "actor", "margwa_head_mid", 1, 2, "int" );
    clientfield::register( "actor", "margwa_head_right", 1, 2, "int" );
    clientfield::register( "actor", "margwa_fx_in", 1, 1, "counter" );
    clientfield::register( "actor", "margwa_fx_out", 1, 1, "counter" );
    clientfield::register( "actor", "margwa_fx_spawn", 1, 1, "counter" );
    clientfield::register( "actor", "margwa_smash", 1, 1, "counter" );
    clientfield::register( "actor", "margwa_head_left_hit", 1, 1, "counter" );
    clientfield::register( "actor", "margwa_head_mid_hit", 1, 1, "counter" );
    clientfield::register( "actor", "margwa_head_right_hit", 1, 1, "counter" );
    clientfield::register( "actor", "margwa_head_killed", 1, 2, "int" );
    clientfield::register( "actor", "margwa_jaw", 1, 6, "int" );
    clientfield::register( "toplayer", "margwa_head_explosion", 1, 1, "counter" );
    clientfield::register( "scriptmover", "margwa_fx_travel", 1, 1, "int" );
    clientfield::register( "scriptmover", "margwa_fx_travel_tell", 1, 1, "int" );
    clientfield::register( "actor", "supermargwa", 1, 1, "int" );
    registerbehaviorscriptfunctions();
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 0
// Checksum 0xe8ad7300, Offset: 0xca0
// Size: 0xf4c
function registerbehaviorscriptfunctions()
{
    assert( isscriptfunctionptr( &margwatargetservice ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaTargetService", &margwatargetservice );
    assert( isscriptfunctionptr( &margwashouldsmashattack ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaShouldSmashAttack", &margwashouldsmashattack );
    assert( isscriptfunctionptr( &margwashouldswipeattack ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaShouldSwipeAttack", &margwashouldswipeattack );
    assert( isscriptfunctionptr( &margwashouldshowpain ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaShouldShowPain", &margwashouldshowpain );
    assert( isscriptfunctionptr( &margwashouldreactstun ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaShouldReactStun", &margwashouldreactstun );
    assert( isscriptfunctionptr( &margwaShouldReactIDGun ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaShouldReactIDGun", &margwaShouldReactIDGun );
    assert( isscriptfunctionptr( &margwaShouldReactSword ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaShouldReactSword", &margwaShouldReactSword );
    assert( isscriptfunctionptr( &margwashouldspawn ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaShouldSpawn", &margwashouldspawn );
    assert( isscriptfunctionptr( &margwaShouldFreeze ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaShouldFreeze", &margwaShouldFreeze );
    assert( isscriptfunctionptr( &margwaShouldTeleportIn ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaShouldTeleportIn", &margwaShouldTeleportIn );
    assert( isscriptfunctionptr( &margwaShouldTeleportOut ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaShouldTeleportOut", &margwaShouldTeleportOut );
    assert( isscriptfunctionptr( &margwaShouldWait ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaShouldWait", &margwaShouldWait );
    assert( isscriptfunctionptr( &margwashouldreset ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaShouldReset", &margwashouldreset );
    assert( !isdefined( &margwareactstunaction ) || isscriptfunctionptr( &margwareactstunaction ) );
    assert( !isdefined( undefined ) || isscriptfunctionptr( undefined ) );
    assert( !isdefined( undefined ) || isscriptfunctionptr( undefined ) );
    behaviortreenetworkutility::registerbehaviortreeaction( "margwaReactStunAction", &margwareactstunaction, undefined, undefined );
    assert( !isdefined( &margwaswipeattackaction ) || isscriptfunctionptr( &margwaswipeattackaction ) );
    assert( !isdefined( &function_12a0b652 ) || isscriptfunctionptr( &function_12a0b652 ) );
    assert( !isdefined( &function_9f21d288 ) || isscriptfunctionptr( &function_9f21d288 ) );
    behaviortreenetworkutility::registerbehaviortreeaction( "margwaSwipeAttackAction", &margwaswipeattackaction, &function_12a0b652, &function_9f21d288 );
    assert( isscriptfunctionptr( &margwaidlestart ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaIdleStart", &margwaidlestart );
    assert( isscriptfunctionptr( &margwamovestart ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaMoveStart", &margwamovestart );
    assert( isscriptfunctionptr( &margwatraverseactionstart ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaTraverseActionStart", &margwatraverseactionstart );
    assert( isscriptfunctionptr( &margwaTeleportInStart ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaTeleportInStart", &margwaTeleportInStart );
    assert( isscriptfunctionptr( &margwaTeleportInTerminate ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaTeleportInTerminate", &margwaTeleportInTerminate );
    assert( isscriptfunctionptr( &margwaTeleportOutStart ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaTeleportOutStart", &margwaTeleportOutStart );
    assert( isscriptfunctionptr( &margwaTeleportOutTerminate ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaTeleportOutTerminate", &margwaTeleportOutTerminate );
    assert( isscriptfunctionptr( &margwapainstart ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaPainStart", &margwapainstart );
    assert( isscriptfunctionptr( &margwapainterminate ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaPainTerminate", &margwapainterminate );
    assert( isscriptfunctionptr( &margwareactstunstart ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaReactStunStart", &margwareactstunstart );
    assert( isscriptfunctionptr( &margwareactstunterminate ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaReactStunTerminate", &margwareactstunterminate );
    assert( isscriptfunctionptr( &margwaReactIDGunStart ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaReactIDGunStart", &margwaReactIDGunStart );
    assert( isscriptfunctionptr( &margwaReactIDGunTerminate ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaReactIDGunTerminate", &margwaReactIDGunTerminate );
    assert( isscriptfunctionptr( &margwaReactSwordStart ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaReactSwordStart", &margwaReactSwordStart );
    assert( isscriptfunctionptr( &margwaReactSwordTerminate ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaReactSwordTerminate", &margwaReactSwordTerminate );
    assert( isscriptfunctionptr( &margwaspawnstart ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaSpawnStart", &margwaspawnstart );
    assert( isscriptfunctionptr( &margwasmashattackstart ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaSmashAttackStart", &margwasmashattackstart );
    assert( isscriptfunctionptr( &margwasmashattackterminate ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaSmashAttackTerminate", &margwasmashattackterminate );
    assert( isscriptfunctionptr( &margwaswipeattackstart ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaSwipeAttackStart", &margwaswipeattackstart );
    assert( isscriptfunctionptr( &margwaswipeattackterminate ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaSwipeAttackTerminate", &margwaswipeattackterminate );
    animationstatenetwork::registeranimationmocomp( "mocomp_teleport_traversal@margwa", &function_d425394, &function_70cf1d98, &function_7fc28dc1 );
    animationstatenetwork::registernotetrackhandlerfunction( "margwa_smash_attack", &function_b4c86753 );
    animationstatenetwork::registernotetrackhandlerfunction( "margwa_bodyfall large", &function_11199ef4 );
    animationstatenetwork::registernotetrackhandlerfunction( "margwa_melee_fire", &function_badfb816 );
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 0
// Checksum 0xa4910dc3, Offset: 0x1bf8
// Size: 0x38a
function function_e9608fd3()
{
    self namespace_250e9486::function_25b2c8a9();
    self.health = 3 * ( 70000 + getplayers().size * 40000 );
    self.maxhealth = self.health;
    self.boss = 1;
    self collidewithactors( 1 );
    self function_11578581( 70 );
    self setavoidancemask( "avoid none" );
    self disableaimassist();
    self.goalradius = 80;
    self.animrate = 1.2;
    self.meleedistsq = sqr( 120 );
    self.var_3adc3f4a = 0;
    self.disableammodrop = 1;
    self.no_gib = 1;
    self.zombie_move_speed = "walk";
    self.var_1c8b76d3 = 1;
    self.overrideactordamage = &function_239ee36;
    self.candamage = 1;
    self.var_887aaf49 = 3;
    self.var_a5d387bf = 0;
    
    if ( randomint( 100 ) > 50 )
    {
        self function_195ee8be( "c_zom_margwa_chunks_le", "j_chunk_head_bone_le" );
        self function_195ee8be( "c_zom_margwa_chunks_ri", "j_chunk_head_bone_ri" );
    }
    else
    {
        self function_195ee8be( "c_zom_margwa_chunks_ri", "j_chunk_head_bone_ri" );
        self function_195ee8be( "c_zom_margwa_chunks_le", "j_chunk_head_bone_le" );
    }
    
    self function_195ee8be( "c_zom_margwa_chunks_mid", "j_chunk_head_bone" );
    self.var_b3d3bd49 = 600;
    self function_b705860f();
    self.var_6897304e = spawn( "script_model", self.origin );
    self.var_6897304e setmodel( #"tag_origin" );
    self.var_6897304e notsolid();
    self.var_7d26d4a8 = spawn( "script_model", self.origin );
    self.var_7d26d4a8 setmodel( #"tag_origin" );
    self.var_7d26d4a8 notsolid();
    self thread function_ea39f784();
    self.updatesight = 0;
    self.var_cccb0ad2 = 1;
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 0, eflags: 0x4
// Checksum 0xa861b66e, Offset: 0x1f90
// Size: 0x5a
function private function_a8751f9b()
{
    blackboard::createblackboardforentity( self );
    self setblackboardattribute( "_locomotion_speed", "locomotion_speed_walk" );
    self.___archetypeonanimscriptedcallback = &function_46d5894d;
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 1, eflags: 0x4
// Checksum 0x1e2f07, Offset: 0x1ff8
// Size: 0x2c
function private function_46d5894d( entity )
{
    entity.__blackboard = undefined;
    entity function_a8751f9b();
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 1, eflags: 0x4
// Checksum 0xee6c33e2, Offset: 0x2030
// Size: 0x2fc
function private function_b4c86753( entity )
{
    players = getplayers();
    
    foreach ( player in players )
    {
        var_9f06b4e9 = entity.origin + vectorscale( anglestoforward( self.angles ), 60 );
        distsq = distancesquared( var_9f06b4e9, player.origin );
        
        if ( distsq < 20736 )
        {
            if ( !isgodmode( player ) )
            {
                if ( is_true( player.hasriotshield ) )
                {
                    damageshield = 0;
                    attackdir = player.origin - self.origin;
                    
                    if ( is_true( player.hasriotshieldequipped ) )
                    {
                        if ( player function_6337506a( attackdir, 0.2 ) )
                        {
                            damageshield = 1;
                        }
                    }
                    else if ( player function_6337506a( attackdir, 0.2, 0 ) )
                    {
                        damageshield = 1;
                    }
                    
                    if ( damageshield )
                    {
                        self clientfield::increment( "margwa_smash" );
                        shield_damage = level.weaponriotshield.weaponstarthitpoints;
                        
                        if ( isdefined( player.weaponriotshield ) )
                        {
                            shield_damage = player.weaponriotshield.weaponstarthitpoints;
                        }
                        
                        player [[ player.player_shield_apply_damage ]]( shield_damage, 0 );
                        continue;
                    }
                }
                
                if ( isdefined( level.var_abc9fecd ) && isfunctionptr( level.var_abc9fecd ) )
                {
                    if ( player [[ level.var_abc9fecd ]]( self ) )
                    {
                        continue;
                    }
                }
                
                self clientfield::increment( "margwa_smash" );
                player dodamage( 166, self.origin, self );
            }
        }
    }
    
    if ( isdefined( self.var_a567e412 ) )
    {
        self [[ self.var_a567e412 ]]();
    }
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 1, eflags: 0x4
// Checksum 0xc7a6a2a3, Offset: 0x2338
// Size: 0x58
function private function_11199ef4( entity )
{
    if ( self.archetype == #"margwa" )
    {
        entity ghost();
        
        if ( isdefined( self.var_5ba15acc ) )
        {
            self [[ self.var_5ba15acc ]]();
        }
    }
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 1, eflags: 0x4
// Checksum 0x76a80513, Offset: 0x2398
// Size: 0x24
function private function_badfb816( entity )
{
    entity melee();
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 1
// Checksum 0xa833ff30, Offset: 0x23c8
// Size: 0x4c, Type: bool
function margwashouldsmashattack( entity )
{
    if ( self.zombie_move_speed != "walk" )
    {
        return false;
    }
    
    if ( !isdefined( entity.var_bec33427 ) )
    {
        entity.var_bec33427 = 0;
    }
    
    return gettime() > entity.var_bec33427;
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 1
// Checksum 0xd8ac3528, Offset: 0x2420
// Size: 0x10a, Type: bool
function margwashouldswipeattack( entity )
{
    if ( !isdefined( entity.enemy ) )
    {
        return false;
    }
    
    var_5065f112 = isdefined( entity.meleedistsq ) ? entity.meleedistsq : 16384;
    
    if ( distancesquared( entity.origin, entity.enemy.origin ) > var_5065f112 )
    {
        return false;
    }
    
    if ( var_5065f112 < 10000 && var_5065f112 > 10000 )
    {
        if ( randomint( 100 ) > 50 )
        {
            return false;
        }
    }
    
    yaw = abs( namespace_ec06fe4a::getyawtoenemy() );
    
    if ( yaw > 45 )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 1, eflags: 0x4
// Checksum 0x22270aa9, Offset: 0x2538
// Size: 0x10a, Type: bool
function private margwashouldshowpain( entity )
{
    if ( isdefined( entity.headdestroyed ) )
    {
        headinfo = entity.head[ entity.headdestroyed ];
        
        switch ( headinfo.cf )
        {
            case #"margwa_head_left":
                self setblackboardattribute( "_margwa_head", "left" );
                break;
            case #"margwa_head_mid":
                self setblackboardattribute( "_margwa_head", "middle" );
                break;
            case #"margwa_head_right":
                self setblackboardattribute( "_margwa_head", "right" );
                break;
        }
        
        return true;
    }
    
    return false;
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 1, eflags: 0x4
// Checksum 0x5cd9525e, Offset: 0x2650
// Size: 0x2e, Type: bool
function private margwashouldreactstun( entity )
{
    if ( is_true( entity.var_b8239c7b ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 1, eflags: 0x4
// Checksum 0xf976fc39, Offset: 0x2688
// Size: 0x2e, Type: bool
function private margwaShouldReactIDGun( entity )
{
    if ( is_true( entity.var_42b101a5 ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 1, eflags: 0x4
// Checksum 0x1ad7220, Offset: 0x26c0
// Size: 0x2e, Type: bool
function private margwaShouldReactSword( entity )
{
    if ( is_true( entity.var_5e6d54e3 ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 1, eflags: 0x4
// Checksum 0xf12812a6, Offset: 0x26f8
// Size: 0x2e, Type: bool
function private margwashouldspawn( entity )
{
    if ( is_true( entity.var_243b04fc ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 1, eflags: 0x4
// Checksum 0x179fa443, Offset: 0x2730
// Size: 0x2e, Type: bool
function private margwaShouldFreeze( entity )
{
    if ( is_true( entity.isfrozen ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 1, eflags: 0x4
// Checksum 0x7c5ae726, Offset: 0x2768
// Size: 0x2e, Type: bool
function private margwaShouldTeleportIn( entity )
{
    if ( is_true( entity.var_72420956 ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 1, eflags: 0x4
// Checksum 0xc044d1b3, Offset: 0x27a0
// Size: 0x2e, Type: bool
function private margwaShouldTeleportOut( entity )
{
    if ( is_true( entity.var_4a2354b9 ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 1, eflags: 0x4
// Checksum 0xe50cb325, Offset: 0x27d8
// Size: 0x2e, Type: bool
function private margwaShouldWait( entity )
{
    if ( is_true( entity.waiting ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 1, eflags: 0x4
// Checksum 0xfed35031, Offset: 0x2810
// Size: 0x86, Type: bool
function private margwashouldreset( entity )
{
    if ( isdefined( entity.headdestroyed ) )
    {
        return true;
    }
    
    if ( is_true( entity.var_42b101a5 ) )
    {
        return true;
    }
    
    if ( is_true( entity.var_5e6d54e3 ) )
    {
        return true;
    }
    
    if ( is_true( entity.var_b8239c7b ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 2, eflags: 0x4
// Checksum 0x58e6d0f9, Offset: 0x28a0
// Size: 0xe8
function private margwareactstunaction( entity, asmstatename )
{
    animationstatenetworkutility::requeststate( entity, asmstatename );
    var_e369804c = entity astsearch( asmstatename );
    var_30358842 = animationstatenetworkutility::searchanimationmap( entity, var_e369804c[ #"animation" ] );
    closetime = int( getanimlength( var_30358842 ) * 1000 );
    entity function_e146597a( closetime );
    margwareactstunstart( entity );
    return 5;
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 2, eflags: 0x4
// Checksum 0x26234b66, Offset: 0x2990
// Size: 0xea
function private margwaswipeattackaction( entity, asmstatename )
{
    animationstatenetworkutility::requeststate( entity, asmstatename );
    
    if ( !isdefined( entity.var_514cf595 ) )
    {
        var_d44a2fd7 = entity astsearch( asmstatename );
        var_cb7794c3 = animationstatenetworkutility::searchanimationmap( entity, var_d44a2fd7[ #"animation" ] );
        entity.var_514cf595 = int( getanimlength( var_cb7794c3 ) * 1000 );
    }
    
    if ( !isdefined( entity.var_4a40767b ) )
    {
        entity.var_4a40767b = gettime() + entity.var_514cf595;
    }
    
    return 5;
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 2, eflags: 0x4
// Checksum 0x5023d83d, Offset: 0x2a88
// Size: 0x40
function private function_12a0b652( entity, *asmstatename )
{
    if ( isdefined( asmstatename.var_4a40767b ) && gettime() > asmstatename.var_4a40767b )
    {
        return 4;
    }
    
    return 5;
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 2, eflags: 0x4
// Checksum 0xc5a8c3e9, Offset: 0x2ad0
// Size: 0x22
function private function_9f21d288( entity, *asmstatename )
{
    asmstatename.var_4a40767b = undefined;
    return 4;
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 1, eflags: 0x4
// Checksum 0x29cd9f24, Offset: 0x2b00
// Size: 0x64
function private margwaidlestart( entity )
{
    entity orientmode( "face enemy" );
    
    if ( entity function_b92d6daa() )
    {
        entity clientfield::set( "margwa_jaw", 1 );
    }
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 1, eflags: 0x4
// Checksum 0x9aaf67ed, Offset: 0x2b70
// Size: 0xa4
function private margwamovestart( entity )
{
    entity orientmode( "face motion" );
    
    if ( entity function_b92d6daa() )
    {
        if ( entity.zombie_move_speed == "run" )
        {
            entity clientfield::set( "margwa_jaw", 13 );
            return;
        }
        
        entity clientfield::set( "margwa_jaw", 7 );
    }
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 1, eflags: 0x4
// Checksum 0x9e60a323, Offset: 0x2c20
// Size: 0xc
function private function_fa5c3a61( *entity )
{
    
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 1, eflags: 0x4
// Checksum 0xe339a7e9, Offset: 0x2c38
// Size: 0x16a
function private margwatraverseactionstart( entity )
{
    entity setblackboardattribute( "_traversal_type", entity.traversestartnode.animscript );
    
    if ( isdefined( entity.traversestartnode.animscript ) )
    {
        if ( entity function_b92d6daa() )
        {
            switch ( entity.traversestartnode.animscript )
            {
                case #"jump_down_36":
                    entity clientfield::set( "margwa_jaw", 21 );
                    break;
                case #"jump_down_96":
                    entity clientfield::set( "margwa_jaw", 22 );
                    break;
                case #"jump_up_36":
                    entity clientfield::set( "margwa_jaw", 24 );
                    break;
                case #"jump_up_96":
                    entity clientfield::set( "margwa_jaw", 25 );
                    break;
            }
        }
    }
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 1, eflags: 0x4
// Checksum 0x25dfa2ab, Offset: 0x2db0
// Size: 0x144
function private margwaTeleportInStart( entity )
{
    entity unlink();
    
    if ( isdefined( entity.teleportpos ) )
    {
        entity forceteleport( entity.teleportpos );
    }
    
    entity show();
    entity pathmode( "move allowed" );
    entity.var_72420956 = 0;
    self setblackboardattribute( "_margwa_teleport", "in" );
    
    if ( isdefined( self.var_6897304e ) )
    {
        self.var_6897304e clientfield::set( "margwa_fx_travel", 0 );
    }
    
    self clientfield::increment( "margwa_fx_in", 1 );
    
    if ( entity function_b92d6daa() )
    {
        entity clientfield::set( "margwa_jaw", 17 );
    }
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 1
// Checksum 0xc849b93b, Offset: 0x2f00
// Size: 0x46
function margwaTeleportInTerminate( entity )
{
    if ( isdefined( self.var_6897304e ) )
    {
        self.var_6897304e clientfield::set( "margwa_fx_travel", 0 );
    }
    
    entity.isteleporting = 0;
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 1, eflags: 0x4
// Checksum 0x80fdeb07, Offset: 0x2f50
// Size: 0xac
function private margwaTeleportOutStart( entity )
{
    entity.var_4a2354b9 = 0;
    entity.isteleporting = 1;
    entity.var_951bd2b8 = entity.origin;
    self setblackboardattribute( "_margwa_teleport", "out" );
    self clientfield::increment( "margwa_fx_out", 1 );
    
    if ( entity function_b92d6daa() )
    {
        entity clientfield::set( "margwa_jaw", 18 );
    }
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 1, eflags: 0x4
// Checksum 0xe1f86649, Offset: 0x3008
// Size: 0x114
function private margwaTeleportOutTerminate( entity )
{
    if ( isdefined( entity.var_6897304e ) )
    {
        entity.var_6897304e.origin = entity gettagorigin( "j_spine_1" );
        entity.var_6897304e clientfield::set( "margwa_fx_travel", 1 );
    }
    
    entity ghost();
    entity pathmode( "dont move" );
    
    if ( isdefined( entity.var_6897304e ) )
    {
        entity linkto( entity.var_6897304e );
    }
    
    if ( isdefined( entity.var_22de9777 ) )
    {
        entity thread [[ entity.var_22de9777 ]]();
        return;
    }
    
    entity thread function_22de9777();
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 1, eflags: 0x4
// Checksum 0x34ac9936, Offset: 0x3128
// Size: 0x13e
function private margwapainstart( entity )
{
    entity notify( #"hash_28b17b286ff6e084" );
    
    if ( entity function_b92d6daa() )
    {
        head = self getblackboardattribute( "_margwa_head" );
        
        switch ( head )
        {
            case #"left":
                entity clientfield::set( "margwa_jaw", 3 );
                break;
            case #"middle":
                entity clientfield::set( "margwa_jaw", 4 );
                break;
            case #"right":
                entity clientfield::set( "margwa_jaw", 5 );
                break;
        }
    }
    
    entity.headdestroyed = undefined;
    entity.var_aef14ab3 = 0;
    entity.candamage = 0;
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 1, eflags: 0x4
// Checksum 0x5b5f4e32, Offset: 0x3270
// Size: 0x64
function private margwapainterminate( entity )
{
    entity.headdestroyed = undefined;
    entity.var_aef14ab3 = 1;
    entity.candamage = 1;
    entity function_e146597a( 5000 );
    entity clearpath();
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 1, eflags: 0x4
// Checksum 0x3e2b40c8, Offset: 0x32e0
// Size: 0x54
function private margwareactstunstart( entity )
{
    entity.var_b8239c7b = undefined;
    entity.var_aef14ab3 = 0;
    
    if ( entity function_b92d6daa() )
    {
        entity clientfield::set( "margwa_jaw", 6 );
    }
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 1
// Checksum 0xb5d048e5, Offset: 0x3340
// Size: 0x1a
function margwareactstunterminate( entity )
{
    entity.var_aef14ab3 = 1;
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 1, eflags: 0x4
// Checksum 0x5625b26d, Offset: 0x3368
// Size: 0x120
function private margwaReactIDGunStart( entity )
{
    entity.var_42b101a5 = undefined;
    entity.var_aef14ab3 = 0;
    var_f65dbf3e = 0;
    
    if ( entity getblackboardattribute( "_zombie_damageweapon_type" ) == "regular" )
    {
        if ( entity function_b92d6daa() )
        {
            entity clientfield::set( "margwa_jaw", 8 );
        }
        
        entity function_e146597a( 5000 );
    }
    else
    {
        if ( entity function_b92d6daa() )
        {
            entity clientfield::set( "margwa_jaw", 9 );
        }
        
        entity function_e146597a( 10000 );
        var_f65dbf3e = 1;
    }
    
    if ( isdefined( entity.var_24b81a2a ) )
    {
        entity [[ entity.var_24b81a2a ]]( var_f65dbf3e );
    }
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 1
// Checksum 0xbd6eaf27, Offset: 0x3490
// Size: 0x3c
function margwaReactIDGunTerminate( entity )
{
    entity.var_aef14ab3 = 1;
    entity setblackboardattribute( "_zombie_damageweapon_type", "regular" );
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 1, eflags: 0x4
// Checksum 0x5be11e01, Offset: 0x34d8
// Size: 0x4c
function private margwaReactSwordStart( entity )
{
    entity.var_5e6d54e3 = undefined;
    entity.var_aef14ab3 = 0;
    
    if ( isdefined( entity.var_f67a6b94 ) )
    {
        entity.var_f67a6b94 notify( #"hash_4230f999642111fa" );
    }
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 1, eflags: 0x4
// Checksum 0x2643cbd5, Offset: 0x3530
// Size: 0x1a
function private margwaReactSwordTerminate( entity )
{
    entity.var_aef14ab3 = 1;
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 1, eflags: 0x4
// Checksum 0xef7bb736, Offset: 0x3558
// Size: 0x16
function private margwaspawnstart( entity )
{
    entity.var_243b04fc = 0;
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 0
// Checksum 0x165f8eeb, Offset: 0x3578
// Size: 0x37c
function function_729da05c()
{
    self notify( "2d18a84d8ed7c3bb" );
    self endon( "2d18a84d8ed7c3bb" );
    self endon( #"death" );
    self endon( #"hash_2b106aceb73a448d" );
    self waittill( #"margwa_smash_attack" );
    zombies = arraysortclosest( getaiteamarray( "axis" ), self.origin, undefined, 0, 150 );
    var_31a419e0 = [];
    
    foreach ( zombie in zombies )
    {
        if ( is_true( zombie.basic ) )
        {
            if ( !isdefined( var_31a419e0 ) )
            {
                var_31a419e0 = [];
            }
            else if ( !isarray( var_31a419e0 ) )
            {
                var_31a419e0 = array( var_31a419e0 );
            }
            
            var_31a419e0[ var_31a419e0.size ] = zombie;
        }
    }
    
    foreach ( zombie in var_31a419e0 )
    {
        zombie namespace_250e9486::setup_zombie_knockdown( self );
    }
    
    forward = anglestoforward( self.angles );
    right = anglestoright( self.angles );
    spot = self.origin + forward * 100;
    groundpos = namespace_ec06fe4a::function_65ee50ba( spot );
    trigger = namespace_ec06fe4a::spawntrigger( "trigger_radius", groundpos, 2 | 1 | 512, 72, 60 );
    
    if ( isdefined( trigger ) )
    {
        trigger thread namespace_ec06fe4a::function_52afe5df( 10 );
        trigger thread namespace_f6712ec9::function_86555fba();
    }
    
    obj = namespace_ec06fe4a::spawnmodel( groundpos );
    obj thread namespace_ec06fe4a::function_52afe5df( 10 );
    obj namespace_83eb6304::function_3ecfde67( "nova_crawler_burst" );
    util::wait_network_frame();
    obj thread function_66a5466d( spot, 72 );
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 2
// Checksum 0x97a33a75, Offset: 0x3900
// Size: 0xc8
function function_66a5466d( origin, radius )
{
    self endon( #"death" );
    
    while ( true )
    {
        currentangle = randomint( 360 );
        var_5ccd914d = rotatepointaroundaxis( ( randomintrange( 12, radius ), 0, 0 ), ( 0, 0, 1 ), currentangle );
        self.origin = origin + var_5ccd914d;
        self namespace_83eb6304::function_3ecfde67( "nova_crawler_burst" );
        wait 0.5;
    }
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 1, eflags: 0x4
// Checksum 0x6e5ab1ac, Offset: 0x39d0
// Size: 0x9c
function private margwasmashattackstart( entity )
{
    entity.var_bec33427 = gettime() + randomintrange( 3000, 10000 );
    entity function_59b4caf4();
    entity thread function_729da05c();
    
    if ( entity function_b92d6daa() )
    {
        entity clientfield::set( "margwa_jaw", 14 );
    }
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 1
// Checksum 0xc3f80f01, Offset: 0x3a78
// Size: 0x34
function margwasmashattackterminate( entity )
{
    entity notify( #"hash_2b106aceb73a448d" );
    entity function_e146597a();
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 1
// Checksum 0xd4969f95, Offset: 0x3ab8
// Size: 0x44
function margwaswipeattackstart( entity )
{
    if ( entity function_b92d6daa() )
    {
        entity clientfield::set( "margwa_jaw", 16 );
    }
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 1, eflags: 0x4
// Checksum 0x80531c44, Offset: 0x3b08
// Size: 0x24
function private margwaswipeattackterminate( entity )
{
    entity function_e146597a();
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 5, eflags: 0x4
// Checksum 0xb3d62c28, Offset: 0x3b38
// Size: 0x10e
function private function_d425394( entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration )
{
    mocompduration orientmode( "face angle", mocompduration.angles[ 1 ] );
    mocompduration animmode( "normal" );
    
    if ( isdefined( mocompduration.traverseendnode ) )
    {
        mocompduration.var_951bd2b8 = mocompduration.origin;
        mocompduration.teleportpos = mocompduration.traverseendnode.origin;
        self clientfield::increment( "margwa_fx_out", 1 );
        
        if ( isdefined( mocompduration.traversestartnode ) )
        {
            if ( isdefined( mocompduration.traversestartnode.speed ) )
            {
                self.var_a334922b = mocompduration.traversestartnode.speed;
            }
        }
    }
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 5, eflags: 0x4
// Checksum 0x550146ac, Offset: 0x3c50
// Size: 0x2c
function private function_70cf1d98( *entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration )
{
    
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 5, eflags: 0x4
// Checksum 0x2c1f6521, Offset: 0x3c88
// Size: 0x44
function private function_7fc28dc1( entity, *mocompanim, *mocompanimblendouttime, *mocompanimflag, *mocompduration )
{
    margwaTeleportOutTerminate( mocompduration );
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 0, eflags: 0x4
// Checksum 0x1a2900bc, Offset: 0x3cd8
// Size: 0x94
function private function_ea39f784()
{
    self waittill( #"death" );
    
    if ( isdefined( self.var_f2bf0700 ) )
    {
        self.var_f2bf0700 notify( #"margwa_kill" );
    }
    
    if ( isdefined( self.var_6897304e ) )
    {
        self.var_6897304e delete();
    }
    
    if ( isdefined( self.var_7d26d4a8 ) )
    {
        self.var_7d26d4a8 delete();
    }
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 0
// Checksum 0xe9fa6fff, Offset: 0x3d78
// Size: 0x12
function function_c9bdb4b5()
{
    self.var_aef14ab3 = 1;
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 0, eflags: 0x4
// Checksum 0xc8a1b262, Offset: 0x3d98
// Size: 0xe
function private function_b705860f()
{
    self.var_aef14ab3 = 0;
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 2, eflags: 0x4
// Checksum 0x1137011c, Offset: 0x3db0
// Size: 0x3c4
function private function_195ee8be( headmodel, var_755136c1 )
{
    model = headmodel;
    var_ac8fb879 = undefined;
    self attach( model );
    
    if ( !isdefined( self.head ) )
    {
        self.head = [];
    }
    
    self.head[ model ] = spawnstruct();
    self.head[ model ].model = model;
    self.head[ model ].tag = var_755136c1;
    self.head[ model ].health = 70000 + getplayers().size * 40000;
    self.head[ model ].candamage = 0;
    self.head[ model ].open = 1;
    self.head[ model ].closed = 2;
    self.head[ model ].smash = 3;
    
    switch ( headmodel )
    {
        case #"c_zom_margwa_chunks_le":
            self.head[ model ].cf = "margwa_head_left";
            self.head[ model ].var_2d048cdf = "margwa_head_left_hit";
            self.head[ model ].gore = "c_zom_margwa_gore_le";
            
            if ( isdefined( var_ac8fb879 ) )
            {
                self.head[ model ].gore = var_ac8fb879;
            }
            
            self.head[ model ].var_d3879c8e = 1;
            self.var_94be3b8e = model;
            break;
        case #"c_zom_margwa_chunks_mid":
            self.head[ model ].cf = "margwa_head_mid";
            self.head[ model ].var_2d048cdf = "margwa_head_mid_hit";
            self.head[ model ].gore = "c_zom_margwa_gore_mid";
            
            if ( isdefined( var_ac8fb879 ) )
            {
                self.head[ model ].gore = var_ac8fb879;
            }
            
            self.head[ model ].var_d3879c8e = 2;
            self.var_a0986652 = model;
            break;
        case #"c_zom_margwa_chunks_ri":
            self.head[ model ].cf = "margwa_head_right";
            self.head[ model ].var_2d048cdf = "margwa_head_right_hit";
            self.head[ model ].gore = "c_zom_margwa_gore_ri";
            
            if ( isdefined( var_ac8fb879 ) )
            {
                self.head[ model ].gore = var_ac8fb879;
            }
            
            self.head[ model ].var_d3879c8e = 3;
            self.var_a285d7da = model;
            break;
    }
    
    self thread function_81b6b294( self.head[ model ] );
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 1
// Checksum 0xfb824c18, Offset: 0x4180
// Size: 0x96
function function_b847ce75( health )
{
    self.var_b3d3bd49 = health;
    
    foreach ( head in self.head )
    {
        head.health = health;
    }
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 2, eflags: 0x4
// Checksum 0xd005b14f, Offset: 0x4220
// Size: 0x3c
function private function_4a60d0c7( min, max )
{
    time = gettime() + randomintrange( min, max );
    return time;
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 0, eflags: 0x4
// Checksum 0x261f5a50, Offset: 0x4268
// Size: 0x3e, Type: bool
function private function_d150bac6()
{
    if ( self.var_887aaf49 > 1 )
    {
        if ( self.var_a5d387bf < self.var_887aaf49 - 1 )
        {
            return true;
        }
    }
    else
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 1, eflags: 0x4
// Checksum 0xf76db088, Offset: 0x42b0
// Size: 0x288
function private function_81b6b294( headinfo )
{
    self endon( #"death", #"hash_28b17b286ff6e084" );
    headinfo notify( #"hash_28b17b286ff6e084" );
    headinfo endon( #"hash_28b17b286ff6e084" );
    
    while ( true )
    {
        if ( self ispaused() )
        {
            util::wait_network_frame();
            continue;
        }
        
        if ( !isdefined( headinfo.closetime ) )
        {
            if ( self.var_887aaf49 == 1 )
            {
                headinfo.closetime = function_4a60d0c7( 500, 1000 );
            }
            else
            {
                headinfo.closetime = function_4a60d0c7( 1500, 3500 );
            }
        }
        
        if ( gettime() > headinfo.closetime && self function_d150bac6() )
        {
            self.var_a5d387bf++;
            headinfo.closetime = undefined;
        }
        else
        {
            util::wait_network_frame();
            continue;
        }
        
        self function_efe04de1( headinfo, 1 );
        self clientfield::set( headinfo.cf, headinfo.open );
        self playsoundontag( "zmb_vocals_margwa_ambient", headinfo.tag );
        
        while ( true )
        {
            if ( !isdefined( headinfo.opentime ) )
            {
                headinfo.opentime = function_4a60d0c7( 3000, 5000 );
            }
            
            if ( gettime() > headinfo.opentime )
            {
                self.var_a5d387bf--;
                headinfo.opentime = undefined;
                break;
            }
            
            util::wait_network_frame();
            continue;
        }
        
        self function_efe04de1( headinfo, 0 );
        self clientfield::set( headinfo.cf, headinfo.closed );
    }
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 2, eflags: 0x4
// Checksum 0x5f664b00, Offset: 0x4540
// Size: 0x3e
function private function_efe04de1( headinfo, candamage )
{
    self endon( #"death" );
    wait 0.1;
    headinfo.candamage = candamage;
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 0, eflags: 0x4
// Checksum 0x9cb44ce, Offset: 0x4588
// Size: 0x198
function private function_59b4caf4()
{
    self notify( #"hash_28b17b286ff6e084" );
    var_f04f8dd5 = [];
    
    foreach ( head in self.head )
    {
        if ( head.health > 0 )
        {
            var_f04f8dd5[ var_f04f8dd5.size ] = head;
        }
    }
    
    var_f04f8dd5 = array::randomize( var_f04f8dd5 );
    open = 0;
    
    foreach ( head in var_f04f8dd5 )
    {
        if ( !open )
        {
            head.candamage = 1;
            self clientfield::set( head.cf, head.smash );
            open = 1;
            continue;
        }
        
        self function_c6899c2b( head );
    }
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 1, eflags: 0x4
// Checksum 0x6ad78949, Offset: 0x4728
// Size: 0x3c
function private function_c6899c2b( headinfo )
{
    headinfo.candamage = 0;
    self clientfield::set( headinfo.cf, headinfo.closed );
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 1, eflags: 0x4
// Checksum 0x57da20e4, Offset: 0x4770
// Size: 0x110
function private function_e146597a( closetime )
{
    if ( self ispaused() )
    {
        return;
    }
    
    foreach ( head in self.head )
    {
        if ( head.health > 0 )
        {
            head.closetime = undefined;
            head.opentime = undefined;
            
            if ( isdefined( closetime ) )
            {
                head.closetime = gettime() + closetime;
            }
            
            self.var_a5d387bf = 0;
            self function_c6899c2b( head );
            self thread function_81b6b294( head );
        }
    }
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 2
// Checksum 0x1d2d89d1, Offset: 0x4888
// Size: 0x16c
function function_a6af900e( var_71938d68, attacker )
{
    headinfo = self.head[ var_71938d68 ];
    
    if ( is_true( headinfo.killed ) )
    {
        return;
    }
    
    headinfo.health = 0;
    headinfo.killed = 1;
    headinfo notify( #"hash_28b17b286ff6e084" );
    
    if ( is_true( headinfo.candamage ) )
    {
        self function_c6899c2b( headinfo );
        self.var_a5d387bf--;
    }
    
    self function_e140363d();
    self clientfield::set( "margwa_head_killed", headinfo.var_d3879c8e );
    self detach( headinfo.model );
    self attach( headinfo.gore );
    self.var_887aaf49--;
    
    if ( self.var_887aaf49 <= 0 )
    {
        self.var_f2bf0700 = attacker;
        return 1;
    }
    else
    {
        self.headdestroyed = var_71938d68;
    }
    
    return 0;
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 0
// Checksum 0x9176ca0f, Offset: 0x4a00
// Size: 0xb4, Type: bool
function function_71c049c4()
{
    foreach ( head in self.head )
    {
        if ( isdefined( head ) && head.health > 0 && is_true( head.candamage ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 0
// Checksum 0x11a6f02e, Offset: 0x4ac0
// Size: 0x40, Type: bool
function function_bbaf72a2()
{
    if ( isdefined( self ) && self.health > 0 && is_true( self.candamage ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 12
// Checksum 0xaa8c060, Offset: 0x4b08
// Size: 0x2d0
function function_239ee36( *inflictor, attacker, damage, *dflags, *mod, *weapon, *point, *dir, *hitloc, *offsettime, *boneindex, *modelindex )
{
    if ( is_true( self.marked_for_death ) )
    {
        self namespace_ec06fe4a::function_2f4b0f9( self.health - modelindex );
        return modelindex;
    }
    
    var_f04f8dd5 = [];
    
    foreach ( head in self.head )
    {
        if ( head.health > 0 )
        {
            var_f04f8dd5[ var_f04f8dd5.size ] = head;
        }
    }
    
    if ( var_f04f8dd5.size )
    {
        var_fe17e856 = var_f04f8dd5[ 0 ];
        var_fe17e856.health -= modelindex;
        self clientfield::increment( var_fe17e856.var_2d048cdf );
        
        if ( var_fe17e856.health <= 0 )
        {
            if ( self function_a6af900e( var_fe17e856.model, boneindex ) )
            {
                return self.health;
            }
        }
    }
    
    if ( modelindex > self.health )
    {
        foreach ( head in self.head )
        {
            self function_a6af900e( head.model, boneindex );
        }
        
        self thread namespace_ec06fe4a::function_570729f0( 1 );
        self.takedamage = 0;
        self namespace_ec06fe4a::function_2f4b0f9( 0 );
        return ( self.health - 1 );
    }
    
    self namespace_ec06fe4a::function_2f4b0f9( self.health - modelindex );
    return modelindex;
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 2, eflags: 0x4
// Checksum 0xfcdc13ba, Offset: 0x4de0
// Size: 0xa4
function private function_102d7140( *entity, partname )
{
    switch ( partname )
    {
        case #"j_chunk_head_bone_le":
        case #"j_jaw_lower_1_le":
            return self.var_94be3b8e;
        case #"j_jaw_lower_1":
        case #"j_chunk_head_bone":
            return self.var_a0986652;
        case #"j_chunk_head_bone_ri":
        case #"j_jaw_lower_1_ri":
            return self.var_a285d7da;
    }
    
    return undefined;
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 0, eflags: 0x4
// Checksum 0x6e2e29ca, Offset: 0x4e90
// Size: 0x94
function private function_e140363d()
{
    if ( self.zombie_move_speed == "walk" )
    {
        self.zombie_move_speed = "run";
        self setblackboardattribute( "_locomotion_speed", "locomotion_speed_run" );
        return;
    }
    
    if ( self.zombie_move_speed == "run" )
    {
        self.zombie_move_speed = "sprint";
        self setblackboardattribute( "_locomotion_speed", "locomotion_speed_sprint" );
    }
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 0
// Checksum 0xcf0c8e6d, Offset: 0x4f30
// Size: 0x34
function function_6c6b91ed()
{
    self.zombie_move_speed = "sprint";
    self setblackboardattribute( "_locomotion_speed", "locomotion_speed_sprint" );
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 1, eflags: 0x4
// Checksum 0x404782b2, Offset: 0x4f70
// Size: 0xc
function private function_35709f56( *var_71938d68 )
{
    
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 0
// Checksum 0xd3453ed1, Offset: 0x4f88
// Size: 0x3a, Type: bool
function function_b92d6daa()
{
    if ( !is_true( self.var_180ce19e ) )
    {
        return false;
    }
    
    if ( self.var_887aaf49 < 3 )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 3
// Checksum 0x1fa46158, Offset: 0x4fd0
// Size: 0x86, Type: bool
function function_c6248cd4( origin, *radius, *var_d0a07ed6 )
{
    pos = getclosestpointonnavmesh( var_d0a07ed6, 64, 30 );
    
    if ( isdefined( pos ) )
    {
        self setgoal( pos );
        return true;
    }
    
    self setgoal( self.origin );
    return false;
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 0, eflags: 0x4
// Checksum 0x6eecad07, Offset: 0x5060
// Size: 0x172
function private function_22de9777()
{
    self endon( #"death" );
    self.waiting = 1;
    self.var_72420956 = 1;
    destpos = self.teleportpos + ( 0, 0, 60 );
    dist = distance( self.var_951bd2b8, destpos );
    time = dist / 600;
    
    if ( isdefined( self.var_a334922b ) )
    {
        if ( self.var_a334922b > 0 )
        {
            time = dist / self.var_a334922b;
        }
    }
    
    if ( isdefined( self.var_6897304e ) )
    {
        self thread function_e01fe209();
        self.var_6897304e moveto( destpos, time );
        self.var_6897304e waittilltimeout( time + 0.1, #"movedone" );
        self.var_7d26d4a8 clientfield::set( "margwa_fx_travel_tell", 0 );
    }
    
    self.waiting = 0;
    self.var_4a2354b9 = 0;
    
    if ( isdefined( self.var_a334922b ) )
    {
        self.var_a334922b = undefined;
    }
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 0
// Checksum 0x4b31252a, Offset: 0x51e0
// Size: 0x6c
function function_e01fe209()
{
    self endon( #"death" );
    self.var_7d26d4a8.origin = self.teleportpos;
    util::wait_network_frame();
    self.var_7d26d4a8 clientfield::set( "margwa_fx_travel_tell", 1 );
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 3
// Checksum 0x4443b40a, Offset: 0x5258
// Size: 0x134, Type: bool
function function_6337506a( vdir, limit, front = 1 )
{
    orientation = self getplayerangles();
    forwardvec = anglestoforward( orientation );
    
    if ( !front )
    {
        forwardvec *= -1;
    }
    
    forwardvec2d = ( forwardvec[ 0 ], forwardvec[ 1 ], 0 );
    unitforwardvec2d = vectornormalize( forwardvec2d );
    tofaceevec = vdir * -1;
    tofaceevec2d = ( tofaceevec[ 0 ], tofaceevec[ 1 ], 0 );
    unittofaceevec2d = vectornormalize( tofaceevec2d );
    dotproduct = vectordot( unitforwardvec2d, unittofaceevec2d );
    return dotproduct > limit;
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 1, eflags: 0x4
// Checksum 0xa2e2ca7, Offset: 0x5398
// Size: 0xb4, Type: bool
function private function_fe2eb01c( enemy )
{
    var_9f06b4e9 = self.origin;
    heightoffset = abs( self.origin[ 2 ] - enemy.origin[ 2 ] );
    
    if ( heightoffset > 48 )
    {
        return false;
    }
    
    distsq = distancesquared( var_9f06b4e9, enemy.origin );
    
    if ( distsq > 2500 && distsq < 10000 )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_a204c0f4/namespace_a204c0f4
// Params 1, eflags: 0x4
// Checksum 0xb646496d, Offset: 0x5458
// Size: 0x148
function private margwatargetservice( entity )
{
    if ( is_true( entity.ignoreall ) )
    {
        return 0;
    }
    
    if ( gettime() > entity.var_3adc3f4a )
    {
        entity.var_3adc3f4a = gettime() + 3000;
        entity.favoriteenemy = undefined;
    }
    
    player = entity.favoriteenemy;
    
    if ( !isdefined( player ) || is_true( player.laststand ) )
    {
        player = namespace_250e9486::function_4b49bf0d();
    }
    
    if ( !isdefined( player ) )
    {
        entity setgoal( entity.origin );
        return 0;
    }
    
    targetpos = getclosestpointonnavmesh( player.origin, 64, 30 );
    
    if ( isdefined( targetpos ) )
    {
        entity setgoal( targetpos );
        return 1;
    }
    
    entity setgoal( entity.origin );
    return 0;
}

