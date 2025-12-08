#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_40f967ad5d18ea74;
#using script_47851dbeea22fe66;
#using script_4d748e58ce25b60c;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_74a56359b7d02ab6;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_ed80aead;

// Namespace namespace_ed80aead/namespace_ed80aead
// Params 0
// Checksum 0xd746326, Offset: 0x3b8
// Size: 0x17a
function init()
{
    level.doa.var_1c58e161 = array( getweapon( "zombietron_deathmachine" ), getweapon( "zombietron_deathmachine_1" ), getweapon( "zombietron_deathmachine_2" ), getweapon( "zombietron_shotgun_fullauto_t9" ), getweapon( "zombietron_shotgun_fullauto_t9_1" ), getweapon( "zombietron_shotgun_fullauto_t9_2" ), getweapon( "zombietron_launcher_1" ), getweapon( "zombietron_launcher_2" ) );
    level.doa.var_d516e53 = array( "MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTIVLE_SPLASH", "MOD_EXPLOSIVE" );
    level.doa.hitlocs = array( "left_hand", "left_arm_lower", "left_arm_upper", "right_hand", "right_arm_lower", "right_arm_upper" );
}

// Namespace namespace_ed80aead/namespace_ed80aead
// Params 2
// Checksum 0xc73ba5cc, Offset: 0x540
// Size: 0x84
function function_1f275794( *launchvector, *attacker )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !isactor( self ) )
    {
        return;
    }
    
    if ( is_true( self.boss ) )
    {
        return;
    }
    
    gibserverutils::giblegs( self );
    self function_df5afb5e( 1 );
}

// Namespace namespace_ed80aead/namespace_ed80aead
// Params 0
// Checksum 0xbdf526b0, Offset: 0x5d0
// Size: 0x64
function function_586ef822()
{
    assert( self.health <= 0 || is_true( self.marked_for_death ), "<dev string:x38>" );
    gibserverutils::annihilate( self );
}

// Namespace namespace_ed80aead/namespace_ed80aead
// Params 1
// Checksum 0xc40db3a3, Offset: 0x640
// Size: 0x104
function function_c25b3c76( launchvector )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !isactor( self ) )
    {
        return;
    }
    
    assert( self.health <= 0 || is_true( self.marked_for_death ), "<dev string:x8e>" );
    assert( !is_true( self.boss ) );
    self namespace_83eb6304::function_3ecfde67( "gut_explode" );
    self thread namespace_ec06fe4a::function_5678f0d( launchvector );
    
    if ( isdefined( launchvector ) )
    {
        self namespace_e32bb68::function_3a59ec34( "zmb_ragdoll_launched" );
    }
}

// Namespace namespace_ed80aead/namespace_ed80aead
// Params 5
// Checksum 0x79fac8e6, Offset: 0x750
// Size: 0x1ac
function trygibbinghead( entity, damage = 100, hitloc = "head", isexplosive = 0, forced = 0 )
{
    if ( gibserverutils::isgibbed( entity, 8 ) )
    {
        return;
    }
    
    if ( forced || isexplosive && randomfloatrange( 0, 1 ) <= 0.5 )
    {
        gibserverutils::gibhead( entity );
        return;
    }
    
    if ( isinarray( array( "head", "neck", "helmet" ), hitloc ) && randomfloatrange( 0, 1 ) <= 1 )
    {
        gibserverutils::gibhead( entity );
        return;
    }
    
    if ( entity.health - damage <= 0 && randomfloatrange( 0, 1 ) <= 0.25 )
    {
        gibserverutils::gibhead( entity );
    }
}

// Namespace namespace_ed80aead/namespace_ed80aead
// Params 4
// Checksum 0x272fc317, Offset: 0x908
// Size: 0x324
function trygibbinglimb( entity, damage, hitloc = level.doa.hitlocs[ randomint( level.doa.hitlocs.size ) ], isexplosive = 0 )
{
    if ( isexplosive && randomfloatrange( 0, 1 ) <= 0.35 )
    {
        if ( entity.health - damage <= 0 && entity.allowdeath && math::cointoss() )
        {
            if ( !gibserverutils::isgibbed( entity, 16 ) )
            {
                gibserverutils::gibrightarm( entity );
            }
        }
        else if ( !gibserverutils::isgibbed( entity, 32 ) )
        {
            gibserverutils::gibleftarm( entity );
        }
        
        return;
    }
    
    if ( isinarray( array( "left_hand", "left_arm_lower", "left_arm_upper" ), hitloc ) )
    {
        if ( !gibserverutils::isgibbed( entity, 32 ) )
        {
            gibserverutils::gibleftarm( entity );
        }
        
        return;
    }
    
    if ( entity.health - damage <= 0 && entity.allowdeath && isinarray( array( "right_hand", "right_arm_lower", "right_arm_upper" ), hitloc ) )
    {
        gibserverutils::gibrightarm( entity );
        return;
    }
    
    if ( entity.health - damage <= 0 && entity.allowdeath && randomfloatrange( 0, 1 ) <= 0.45 )
    {
        if ( math::cointoss() )
        {
            if ( !gibserverutils::isgibbed( entity, 32 ) )
            {
                gibserverutils::gibleftarm( entity );
            }
            
            return;
        }
        
        if ( !gibserverutils::isgibbed( entity, 16 ) )
        {
            gibserverutils::gibrightarm( entity );
        }
    }
}

// Namespace namespace_ed80aead/namespace_ed80aead
// Params 5
// Checksum 0x8605d6b1, Offset: 0xc38
// Size: 0x49c
function trygibbinglegs( entity, damage, hitloc = level.doa.hitlocs[ randomint( level.doa.hitlocs.size ) ], isexplosive = 0, attacker = entity )
{
    cangiblegs = entity.health - damage <= 0 && entity.allowdeath;
    cangiblegs = cangiblegs || ( entity.health - damage ) / entity.maxhealth <= 0.25 && distancesquared( entity.origin, attacker.origin ) <= sqr( 600 ) && entity.allowdeath;
    
    if ( !is_true( entity.boss ) && entity.health - damage <= 0 && entity.allowdeath && isexplosive && randomfloatrange( 0, 1 ) <= 0.5 )
    {
        if ( !gibserverutils::isgibbed( entity, 384 ) )
        {
            gibserverutils::giblegs( entity );
            entity function_df5afb5e( 1 );
            entity thread namespace_ec06fe4a::function_5678f0d();
        }
    }
    else if ( entity.health - damage <= 0 && entity.allowdeath && randomfloatrange( 0, 1 ) <= 0.25 )
    {
        if ( !gibserverutils::isgibbed( entity, 256 ) )
        {
            gibserverutils::gibleftleg( entity );
            entity function_df5afb5e( 1 );
        }
        
        if ( math::cointoss() )
        {
            if ( !gibserverutils::isgibbed( entity, 128 ) )
            {
                gibserverutils::gibrightleg( entity );
                entity function_df5afb5e( 1 );
            }
        }
    }
    
    if ( cangiblegs && isinarray( array( "left_leg_upper", "left_leg_lower", "left_foot" ), hitloc ) && randomfloatrange( 0, 1 ) <= 1 )
    {
        if ( !gibserverutils::isgibbed( entity, 256 ) )
        {
            gibserverutils::gibleftleg( entity );
            entity function_df5afb5e( 1 );
        }
    }
    
    if ( cangiblegs && isinarray( array( "right_leg_upper", "right_leg_lower", "right_foot" ), hitloc ) && randomfloatrange( 0, 1 ) <= 1 )
    {
        if ( !gibserverutils::isgibbed( entity, 128 ) )
        {
            gibserverutils::gibrightleg( entity );
            entity function_df5afb5e( 1 );
        }
    }
}

// Namespace namespace_ed80aead/namespace_ed80aead
// Params 1
// Checksum 0xc23e06d3, Offset: 0x10e0
// Size: 0x3a
function function_df5afb5e( missinglegs = 0 )
{
    if ( missinglegs )
    {
        self.knockdown = 0;
    }
    
    self.missinglegs = missinglegs;
}

// Namespace namespace_ed80aead/namespace_ed80aead
// Params 6
// Checksum 0x22c2b00b, Offset: 0x1128
// Size: 0x204
function function_5e680689( attacker, damage, meansofdeath, weapon, hitloc, *vdir )
{
    if ( !isactor( self ) )
    {
        return;
    }
    
    if ( self.archetype != "zombie" )
    {
        return;
    }
    
    if ( weapon == "MOD_BURNED" )
    {
        return;
    }
    
    self endon( #"death" );
    isexplosive = isinarray( level.doa.var_d516e53, weapon );
    trygibbinglimb( self, meansofdeath, vdir, isexplosive );
    trygibbinglegs( self, meansofdeath, vdir, isexplosive, damage );
    
    if ( meansofdeath >= self.health && gettime() > self.birthtime )
    {
        self.marked_for_death = 1;
        
        if ( isinarray( level.doa.var_1c58e161, hitloc ) )
        {
            self namespace_83eb6304::function_3ecfde67( "zombie_chunk" );
        }
        
        if ( hitloc === level.doa.var_6a5eb56f || hitloc === level.doa.var_3efdf9e5 )
        {
            trygibbinghead( self, meansofdeath, vdir, isexplosive );
            self namespace_83eb6304::function_3ecfde67( "boost_explode" );
        }
        
        if ( hitloc.doannihilate )
        {
            self function_586ef822();
        }
    }
}

// Namespace namespace_ed80aead/namespace_ed80aead
// Params 1
// Checksum 0xc43fc731, Offset: 0x1338
// Size: 0x11c
function gib_random_part( damage = 100 )
{
    if ( is_true( self.no_gib ) )
    {
        return;
    }
    
    if ( mayspawnentity() && validateorigin( self.origin ) )
    {
        playsoundatposition( #"zmb_death_gibss", self.origin );
    }
    
    val = randomint( 100 );
    
    if ( val > 20 )
    {
        trygibbinghead( self, damage );
    }
    
    if ( val > 30 )
    {
        trygibbinglegs( self, damage );
    }
    
    if ( val > 50 )
    {
        trygibbinglimb( self, damage );
    }
}

