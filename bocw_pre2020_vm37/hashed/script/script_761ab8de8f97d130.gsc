#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_2c5daa95f8fec03c;
#using script_47851dbeea22fe66;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_774302f762d76254;
#using script_79315a6ccf4fce3d;
#using scripts\core_common\ai\archetype_damage_utility;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai\systems\destructible_character;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie_eye_glow;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;

#namespace namespace_b5ca279a;

// Namespace namespace_b5ca279a/namespace_b5ca279a
// Params 0
// Checksum 0xc84ce13c, Offset: 0x450
// Size: 0x1cc
function init()
{
    namespace_250e9486::function_252dff4d( "basic_zombie", &function_7f78da, undefined );
    namespace_250e9486::function_252dff4d( "barreler_zombie", &function_ef2758f9, undefined );
    namespace_250e9486::function_252dff4d( "riser_zombie", &function_a4b27d0e, undefined );
    namespace_250e9486::function_252dff4d( "blood_riser", &function_1eb8e7ef, undefined );
    namespace_250e9486::function_252dff4d( "smoke_zombie", &function_83a2d68c, undefined );
    namespace_250e9486::function_252dff4d( "light_armor_zombie", &function_4b6805ce, undefined );
    namespace_250e9486::function_252dff4d( "heavy_armor_zombie", &function_4b6805ce, undefined );
    registration = namespace_250e9486::function_3dd94c25( "barreler_zombie" );
    
    if ( !isdefined( registration.var_71e54e3a ) )
    {
        registration.var_71e54e3a = [];
    }
    else if ( !isarray( registration.var_71e54e3a ) )
    {
        registration.var_71e54e3a = array( registration.var_71e54e3a );
    }
    
    registration.var_71e54e3a[ registration.var_71e54e3a.size ] = "kgb";
    registerbehaviorscriptfunctions();
}

// Namespace namespace_b5ca279a/namespace_b5ca279a
// Params 0
// Checksum 0x7422554, Offset: 0x628
// Size: 0x3b4
function registerbehaviorscriptfunctions()
{
    assert( isscriptfunctionptr( &function_63e044e7 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_11f0b891a9d2e6c7", &function_63e044e7 );
    assert( isscriptfunctionptr( &function_9e433573 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_2b2a4705912ffb22", &function_9e433573 );
    assert( isscriptfunctionptr( &function_55b7ea22 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_7561185fb9f89048", &function_55b7ea22 );
    assert( isscriptfunctionptr( &function_98b102d8 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_66d076094cefbdbb", &function_98b102d8 );
    assert( isscriptfunctionptr( &function_4402c40a ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_530185ba74913077", &function_4402c40a );
    assert( isscriptfunctionptr( &function_6a3bcddc ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_545373e09d03a06c", &function_6a3bcddc );
    assert( isscriptfunctionptr( &function_b9b03294 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_1f70e1d883cae162", &function_b9b03294 );
    assert( isscriptfunctionptr( &zombietraversalservice ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"doazombietraversalservice", &zombietraversalservice );
    assert( isscriptfunctionptr( &function_f637b05d ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_52efb6ed5d3a4220", &function_f637b05d, 1 );
}

// Namespace namespace_b5ca279a/namespace_b5ca279a
// Params 0
// Checksum 0x3a350fff, Offset: 0x9e8
// Size: 0x122
function function_7f78da()
{
    self namespace_250e9486::function_25b2c8a9();
    self.var_1038c5e0 = "ai_zombie_riser";
    self.var_596fb6ed = "ai_zombie_riser";
    self.basic = 1;
    self.var_c3ce559a = 0;
    self.var_bb68380c = namespace_4dae815d::function_59a9cf1d() == 0;
    self.shouldspawn = namespace_4dae815d::function_59a9cf1d() != 0;
    self thread zombie_eye_glow::function_b43f92cd();
    
    if ( self.var_bb68380c )
    {
        self thread function_e6634b0c();
        self thread function_a00c9d13();
        return;
    }
    
    if ( self.zombie_move_speed == "walk" )
    {
        self.zombie_move_speed = math::cointoss() ? "sprint" : "run";
    }
}

// Namespace namespace_b5ca279a/namespace_b5ca279a
// Params 0
// Checksum 0x2eed911f, Offset: 0xb18
// Size: 0x19a
function function_c4faf752()
{
    self function_7f78da();
    self.basic = undefined;
    self.shouldspawn = 0;
    self.zombie_move_speed = math::cointoss() ? "sprint" : isdefined( level.doa.var_13e8f9c9 ) ? level.doa.var_13e8f9c9 : "run";
    self.var_c3ce559a = 1;
    animrate = randomfloatrange( 1.2, 1.4 );
    self asmsetanimationrate( animrate );
    self namespace_ed80aead::function_df5afb5e( 1 );
    self allowedstances( "crouch" );
    self setphysparams( 15, 0, 24 );
    self allowpitchangle( 1 );
    self setpitchorient();
    
    if ( isdefined( level.doa.var_a598a835 ) )
    {
        self.spawnloc = [[ level.doa.var_a598a835 ]]();
    }
}

// Namespace namespace_b5ca279a/namespace_b5ca279a
// Params 0
// Checksum 0x67577042, Offset: 0xcc0
// Size: 0x32
function function_1eb8e7ef()
{
    function_a4b27d0e();
    self.var_1038c5e0 = "ai_blood_riser";
    self.var_596fb6ed = "ai_blood_riser";
}

// Namespace namespace_b5ca279a/namespace_b5ca279a
// Params 0
// Checksum 0xe2be06b5, Offset: 0xd00
// Size: 0x106
function function_a4b27d0e()
{
    self function_7f78da();
    self.basic = undefined;
    self.shouldspawn = 1;
    self.zombie_arms_position = randomint( 100 ) < 50 ? "down" : "up";
    self.zombie_move_speed = isdefined( level.doa.var_13e8f9c9 ) ? level.doa.var_13e8f9c9 : "run";
    
    if ( isdefined( level.doa.var_a598a835 ) )
    {
        self.spawnloc = [[ level.doa.var_a598a835 ]]();
        return;
    }
    
    self.spawnloc = [[ level.doa.var_39e3fa99 ]]->function_59fc184c();
}

// Namespace namespace_b5ca279a/namespace_b5ca279a
// Params 0
// Checksum 0x61b163, Offset: 0xe10
// Size: 0x1d4
function function_ef2758f9()
{
    self function_7f78da();
    self.basic = undefined;
    self.zombie_arms_position = "up";
    self setavoidancemask( "avoid none" );
    self.zombie_move_speed = isdefined( level.doa.var_13e8f9c9 ) ? level.doa.var_13e8f9c9 : "run";
    self thread namespace_ec06fe4a::function_570729f0( 30 );
    barrel = namespace_fb2125f::function_f1ca69a7( "zombietron_explosive_barrel", undefined, self.origin, self.angles, 0 );
    
    if ( isdefined( barrel ) )
    {
        barrel notsolid();
        barrel enablelinkto();
        self enablelinkto();
        barrel disableaimassist();
        barrel.carried = 1;
        barrel.takedamage = 1;
        barrel.health = 99999;
        barrel linkto( self, "j_head", ( 0, 0, 15 ), ( 90, 0, 0 ) );
        barrel thread function_bd3de922( self );
        barrel thread namespace_ec06fe4a::function_52afe5df( 120 );
    }
}

// Namespace namespace_b5ca279a/namespace_b5ca279a
// Params 0
// Checksum 0x5b0f0e50, Offset: 0xff0
// Size: 0x13c
function function_4b6805ce()
{
    self function_7f78da();
    self.basic = undefined;
    
    switch ( self.subarchetype )
    {
        case #"zombie_medium_armor":
            var_f10b6fe6 = 3200;
            self.zombie_move_speed = "sprint";
            break;
        case #"hash_7a778318514578f7":
            var_f10b6fe6 = 6500;
            self.zombie_move_speed = "run";
            break;
    }
    
    self.zombie_move_speed = isdefined( level.doa.var_13e8f9c9 ) ? level.doa.var_13e8f9c9 : self.zombie_move_speed;
    
    if ( self.health < var_f10b6fe6 )
    {
        self.health = var_f10b6fe6;
    }
    
    self.maxhealth = self.health;
    function_cea9ab47( self );
    aiutility::addaioverridedamagecallback( self, &function_d2fee26e );
}

// Namespace namespace_b5ca279a/namespace_b5ca279a
// Params 1
// Checksum 0xc20650fb, Offset: 0x1138
// Size: 0x19c
function function_cea9ab47( entity )
{
    namespace_81245006::initweakpoints( self );
    
    if ( !isdefined( entity.subarchetype ) )
    {
        return;
    }
    
    switch ( entity.subarchetype )
    {
        case #"zombie_medium_armor":
            entity attach( "c_t9_zmb_zombie_medium_helmet" );
            entity attach( "c_t9_zmb_zombie_medium_armor" );
            self function_2d4173a8( 1 );
            break;
        case #"hash_7a778318514578f7":
            entity attach( "c_t9_zmb_zombie_heavy_torso_armor" );
            entity attach( "c_t9_zmb_zombie_heavy_arm_armor_lt" );
            entity attach( "c_t9_zmb_zombie_heavy_arm_armor_rt" );
            entity attach( "c_t9_zmb_zombie_heavy_leg_armor_lt" );
            entity attach( "c_t9_zmb_zombie_heavy_leg_armor_rt" );
            self function_2d4173a8( 1 );
            break;
    }
    
    entity destructserverutils::togglespawngibs( entity, 1 );
}

// Namespace namespace_b5ca279a/namespace_b5ca279a
// Params 1
// Checksum 0xd3ea9f3c, Offset: 0x12e0
// Size: 0xf4
function function_bd3de922( carrier )
{
    self endon( #"death" );
    carrier waittill( #"death" );
    self unlink();
    self solid();
    impulse = anglestoforward( self.angles ) + ( 0, 0, 5 );
    impulse = vectorscale( impulse, 3 );
    self physicslaunch( self.origin, impulse );
    self enableaimassist();
    self thread namespace_fb2125f::function_db4a8bad( 1, self );
}

// Namespace namespace_b5ca279a/namespace_b5ca279a
// Params 0
// Checksum 0x13044531, Offset: 0x13e0
// Size: 0x214
function function_83a2d68c()
{
    self namespace_250e9486::function_25b2c8a9();
    self.var_1038c5e0 = "shadow_rez_in";
    self.var_596fb6ed = "shadow_appear";
    self.var_bb68380c = namespace_4dae815d::function_59a9cf1d() == 0;
    self.shouldspawn = 1;
    self.var_c5348ec8 = randomint( 2 ) + 1;
    self.zombie_move_speed = isdefined( level.doa.var_13e8f9c9 ) ? level.doa.var_13e8f9c9 : "sprint";
    
    if ( isdefined( level.doa.var_a598a835 ) )
    {
        self.spawnloc = [[ level.doa.var_a598a835 ]]();
    }
    else
    {
        self.spawnloc = [[ level.doa.var_39e3fa99 ]]->function_70fb5745();
    }
    
    self.org = namespace_ec06fe4a::spawnmodel( self.spawnloc.origin + ( 0, 0, 40 ), "tag_origin" );
    
    if ( isdefined( self.org ) )
    {
        self.org.takedamage = 0;
        self.org.targetname = "shadowTeleportMeNow";
        self.org thread namespace_ec06fe4a::function_d55f042c( self, "death" );
    }
    
    self.var_e66cd6fb = 1;
    aiutility::addaioverridedamagecallback( self, &function_a86c6bf8 );
    self thread shadowteleportmenow( 1, self.spawnloc.origin );
}

// Namespace namespace_b5ca279a/namespace_b5ca279a
// Params 2
// Checksum 0xfefe1d1d, Offset: 0x1600
// Size: 0x402
function shadowteleportmenow( initial = 0, origin = self.origin )
{
    self endon( #"death" );
    
    if ( is_true( self.intransition ) )
    {
        return;
    }
    
    assert( self.var_c5348ec8 > 0 );
    self.intransition = 1;
    
    if ( !initial )
    {
        self.var_c5348ec8--;
    }
    
    spot = [[ level.doa.var_39e3fa99 ]]->function_70fb5745( origin, 256, 1400 ).origin;
    self.ignoreall = 1;
    self.takedamage = 0;
    self namespace_83eb6304::function_3ecfde67( "shadow_fade" );
    wait 0.1;
    
    if ( isdefined( self.org ) )
    {
        self.org.origin = self.origin + ( 0, 0, 40 );
        self.org namespace_83eb6304::function_3ecfde67( "shadow_move" );
        self.org namespace_83eb6304::function_3ecfde67( "shadow_glow" );
        self.org namespace_e32bb68::function_3a59ec34( "zmb_enemy_smokeman_poof" );
        wait 0.3;
        self namespace_ec06fe4a::function_8c808737();
        self notsolid();
        self setplayercollision( 0 );
        self linkto( self.org );
        self.org moveto( spot + ( 0, 0, 40 ), 2 );
        self.org waittilltimeout( 2.1, #"movedone" );
        self.org namespace_83eb6304::function_3ecfde67( "shadow_appear" );
        wait 1;
        self.org namespace_e32bb68::function_3a59ec34( "zmb_enemy_smokeman_wings" );
        wait 1;
        self namespace_e32bb68::function_3a59ec34( "zmb_enemy_smokeman_poof" );
        self unlink();
        self forceteleport( spot );
        self namespace_ec06fe4a::function_4f72130c();
        self solid();
        self setplayercollision( 1 );
        self.org namespace_83eb6304::turnofffx( "shadow_move" );
        self.org namespace_83eb6304::turnofffx( "shadow_glow" );
        self.org namespace_e32bb68::function_ae271c0b( "zmb_enemy_smokeman_poof" );
    }
    
    self namespace_83eb6304::function_3ecfde67( "spawnZombie" );
    wait 1;
    self.ignoreall = 0;
    self.takedamage = 1;
    self.intransition = undefined;
}

// Namespace namespace_b5ca279a/namespace_b5ca279a
// Params 15
// Checksum 0x6e131896, Offset: 0x1a10
// Size: 0x140
function function_a86c6bf8( *einflictor, eattacker, idamage, *idflags, smeansofdeath, *weapon, *vpoint, *vdir, *shitloc, *vdamageorigin, *timeoffset, *boneindex, *modelindex, *surfacetype, *surfacenormal )
{
    if ( self.var_c5348ec8 > 0 )
    {
        if ( surfacetype >= self.health )
        {
            surfacetype = self.health - 1;
        }
        
        self thread shadowteleportmenow();
    }
    
    if ( self.health == 1 )
    {
        self namespace_83eb6304::function_3ecfde67( "shadow_die" );
        self namespace_ec06fe4a::function_4f72130c();
        self.takedamage = 0;
        self.aioverridedamage = undefined;
        self thread namespace_ec06fe4a::function_570729f0( 0.1, modelindex, surfacenormal );
    }
    
    return surfacetype;
}

// Namespace namespace_b5ca279a/namespace_b5ca279a
// Params 0
// Checksum 0x8a629385, Offset: 0x1b58
// Size: 0x5c
function function_a00c9d13()
{
    self endon( #"death" );
    self waittill( #"speed_change" );
    self.var_860a34b9 = undefined;
    self.var_72283e28 = 0;
    self thread function_e6634b0c( self.var_fe2082cc );
}

// Namespace namespace_b5ca279a/namespace_b5ca279a
// Params 1
// Checksum 0xecf52b68, Offset: 0x1bc0
// Size: 0x204
function function_e6634b0c( var_11b86a4c = 60 )
{
    self notify( "4831683d87d1b430" );
    self endon( "4831683d87d1b430" );
    self endon( #"death" );
    
    if ( self.zombie_move_speed != "walk" )
    {
        self waittilltimeout( var_11b86a4c, #"wander" );
        
        if ( isdefined( self.var_ce1aa55f ) && gettime() - self.var_ce1aa55f <= 10000 )
        {
            self thread function_e6634b0c();
        }
    }
    else
    {
        self waittill( #"wander", #"speed_change" );
    }
    
    spot = [[ level.doa.var_39e3fa99 ]]->function_70fb5745( self.origin, 300, 2048 );
    
    if ( isdefined( spot ) )
    {
        self.var_860a34b9 = spot.origin;
    }
    else
    {
        self.var_860a34b9 = self.startposition;
    }
    
    self.oldradius = self.goalradius;
    self.goalradius = 256;
    self.var_72283e28 = 0;
    self setavoidancemask( "avoid none" );
    self setgoal( self.var_860a34b9 );
    self waittilltimeout( 10, #"goal" );
    self setavoidancemask( "avoid actor" );
    self.var_860a34b9 = undefined;
    self.goalradius = self.oldradius;
    self thread function_e6634b0c( var_11b86a4c );
}

// Namespace namespace_b5ca279a/namespace_b5ca279a
// Params 1
// Checksum 0xb74c939c, Offset: 0x1dd0
// Size: 0x32
function function_f637b05d( behaviortreeentity )
{
    behaviortreeentity.var_93a62fe = namespace_7f5aeb59::function_7781556b( behaviortreeentity.origin, 1 );
}

// Namespace namespace_b5ca279a/namespace_b5ca279a
// Params 1
// Checksum 0x57b4ffd6, Offset: 0x1e10
// Size: 0x3c, Type: bool
function zombietraversalservice( entity )
{
    if ( isdefined( entity.traversestartnode ) )
    {
        entity collidewithactors( 0 );
        return true;
    }
    
    return false;
}

// Namespace namespace_b5ca279a/namespace_b5ca279a
// Params 1, eflags: 0x4
// Checksum 0x9a5e628, Offset: 0x1e58
// Size: 0x72, Type: bool
function private function_b9b03294( entity )
{
    if ( self function_3c566724() )
    {
        return true;
    }
    
    startnode = entity.traversestartnode;
    
    if ( !isdefined( startnode ) || !isnodeenabled( startnode ) )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_b5ca279a/namespace_b5ca279a
// Params 1, eflags: 0x4
// Checksum 0x9b32f7c2, Offset: 0x1ed8
// Size: 0xa0, Type: bool
function private function_4402c40a( entity )
{
    if ( !is_true( entity.var_e5ad72a0 ) )
    {
        if ( isdefined( entity.var_1038c5e0 ) )
        {
            entity namespace_83eb6304::function_3ecfde67( entity.var_1038c5e0 );
        }
        
        entity.var_c0bd8c06 = undefined;
        entity.var_e5ad72a0 = 1;
        entity disableaimassist();
        entity pathmode( "dont move", 1 );
    }
    
    return true;
}

// Namespace namespace_b5ca279a/namespace_b5ca279a
// Params 1, eflags: 0x4
// Checksum 0x9f111884, Offset: 0x1f80
// Size: 0x5e, Type: bool
function private function_6a3bcddc( entity )
{
    entity namespace_ec06fe4a::function_8c808737();
    entity notsolid();
    entity notify( #"hash_12b1eb419a23e3bd" );
    entity.var_e5ad72a0 = undefined;
    return true;
}

// Namespace namespace_b5ca279a/namespace_b5ca279a
// Params 1, eflags: 0x4
// Checksum 0x9b75d49d, Offset: 0x1fe8
// Size: 0xbc
function private function_55b7ea22( entity )
{
    if ( !is_true( entity.var_1f2d0447 ) )
    {
        entity solid();
        
        if ( isdefined( entity.var_596fb6ed ) )
        {
            entity namespace_83eb6304::function_3ecfde67( entity.var_596fb6ed );
        }
        
        entity pathmode( "dont move" );
        entity.var_1f2d0447 = 1;
        entity.shouldspawn = undefined;
        entity disableaimassist();
    }
}

// Namespace namespace_b5ca279a/namespace_b5ca279a
// Params 1, eflags: 0x4
// Checksum 0xc222187, Offset: 0x20b0
// Size: 0x60
function private function_98b102d8( entity )
{
    entity.var_1f2d0447 = undefined;
    entity pathmode( "move allowed" );
    entity enableaimassist();
    entity notify( #"not_underground" );
}

// Namespace namespace_b5ca279a/namespace_b5ca279a
// Params 1, eflags: 0x4
// Checksum 0x7f9de577, Offset: 0x2118
// Size: 0x22
function private function_63e044e7( entity )
{
    return is_true( entity.shouldspawn );
}

// Namespace namespace_b5ca279a/namespace_b5ca279a
// Params 1, eflags: 0x4
// Checksum 0x37ac7120, Offset: 0x2148
// Size: 0x22
function private function_9e433573( entity )
{
    return is_true( entity.var_c0bd8c06 );
}

// Namespace namespace_b5ca279a/namespace_b5ca279a
// Params 12
// Checksum 0x8f660d, Offset: 0x2178
// Size: 0x228
function function_d2fee26e( *einflictor, *eattacker, idamage, *idflags, *smeansofdeath, *weapon, *vpoint, *vdir, shitloc, *psoffsettime, *boneindex, *modelindex )
{
    self.var_426947c4 = undefined;
    weakpoint = namespace_81245006::function_3131f5dd( self, modelindex, 1 );
    
    if ( isdefined( weakpoint ) && weakpoint.type === #"armor" )
    {
        namespace_81245006::damageweakpoint( weakpoint, boneindex );
        
        if ( namespace_81245006::function_f29756fe( weakpoint ) === 3 && isdefined( weakpoint.var_f371ebb0 ) )
        {
            destructserverutils::function_8475c53a( self, weakpoint.var_f371ebb0 );
            self.var_426947c4 = 1;
            
            if ( weakpoint.var_f371ebb0 === "body_armor" )
            {
                callback::callback( #"hash_7d67d0e9046494fb" );
            }
        }
        
        if ( self.subarchetype === #"hash_7a778318514578f7" )
        {
            boneindex = int( boneindex * 0.25 );
        }
        else if ( self.subarchetype === #"zombie_medium_armor" )
        {
            boneindex = int( boneindex * 0.5 );
        }
        
        self.var_67f98db0 = 1;
        var_43f0e034 = function_f4e9bba4( self );
        self function_2d4173a8( var_43f0e034 );
    }
    
    return boneindex;
}

// Namespace namespace_b5ca279a/namespace_b5ca279a
// Params 1
// Checksum 0x2ed6bf22, Offset: 0x23a8
// Size: 0x12a
function function_f4e9bba4( entity )
{
    max_health = 0;
    curr_health = 0;
    weakpoints = namespace_81245006::function_fab3ee3e( entity );
    
    if ( !isdefined( weakpoints ) )
    {
        return 0;
    }
    
    foreach ( weakpoint in weakpoints )
    {
        if ( weakpoint.type === #"armor" )
        {
            max_health += weakpoint.maxhealth;
            curr_health += max( weakpoint.health, 0 );
        }
    }
    
    if ( max_health == 0 )
    {
        return 0;
    }
    
    return curr_health / max_health;
}

