#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1b01e95a6b5270fd;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using scripts\core_common\ai\archetype_brutus;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\status_effects\status_effect_util;

#namespace namespace_df4fbf0;

// Namespace namespace_df4fbf0/namespace_df4fbf0
// Params 0
// Checksum 0xc1c7c62a, Offset: 0x1b8
// Size: 0x9c
function init()
{
    namespace_250e9486::function_252dff4d( "brutus", &function_8b038048, undefined );
    clientfield::register( "toplayer", "brutus_shock_attack_player", 1, 1, "counter" );
    clientfield::register( "actor", "brutus_shock_attack", 1, 1, "counter" );
    registerbehaviorscriptfunctions();
}

// Namespace namespace_df4fbf0/namespace_df4fbf0
// Params 0
// Checksum 0x8cf79ab5, Offset: 0x260
// Size: 0x234
function registerbehaviorscriptfunctions()
{
    assert( isscriptfunctionptr( &namespace_250e9486::function_abb6c18a ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_67cf14163bf00d16", &namespace_250e9486::function_abb6c18a );
    assert( isscriptfunctionptr( &namespace_250e9486::function_99ed5179 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_14f093af5e75dca1", &namespace_250e9486::function_99ed5179 );
    assert( isscriptfunctionptr( &namespace_250e9486::function_50547dae ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_23de4beb58b2ce65", &namespace_250e9486::function_50547dae );
    assert( isscriptfunctionptr( &function_3bda3c55 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_43c922ea035ca163", &function_3bda3c55 );
    assert( isscriptfunctionptr( &function_f4a61e6a ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_7cdf61f23f735254", &function_f4a61e6a );
    animationstatenetwork::registernotetrackhandlerfunction( "hit_ground", &function_85e8940a );
}

// Namespace namespace_df4fbf0/namespace_df4fbf0
// Params 0
// Checksum 0xfe26329, Offset: 0x4a0
// Size: 0xa4
function function_8b038048()
{
    namespace_250e9486::function_25b2c8a9();
    self.var_9329a57c = 0;
    self.health = 50000;
    self.boss = 1;
    self.var_1c8b76d3 = 1;
    self.no_gib = 1;
    self.zombie_move_speed = "walk";
    self.maxhealth = self.health;
    self.shock_status_effect = getstatuseffect( #"hash_19533caf858a9f3b" );
    self thread damagewatch();
}

// Namespace namespace_df4fbf0/namespace_df4fbf0
// Params 0
// Checksum 0x75242d6a, Offset: 0x550
// Size: 0xdc
function damagewatch()
{
    self notify( "1f1bcef7ab74253d" );
    self endon( "1f1bcef7ab74253d" );
    self endon( #"death" );
    result = self waittill( #"damage", #"nuked" );
    self.goalradius = 42;
    
    if ( self.zombie_move_speed == "walk" )
    {
        self.var_8766b29b = 1;
    }
    
    self.zombie_move_speed = "run";
    
    if ( result._notify === "nuked" )
    {
        self dodamage( 1000, self.origin );
    }
}

// Namespace namespace_df4fbf0/namespace_df4fbf0
// Params 1, eflags: 0x4
// Checksum 0xf0be3914, Offset: 0x638
// Size: 0xee, Type: bool
function private function_3bda3c55( entity )
{
    if ( is_true( entity.var_8766b29b ) )
    {
        self.var_8766b29b = undefined;
        return true;
    }
    
    if ( entity.var_9329a57c > gettime() )
    {
        return false;
    }
    
    if ( !isdefined( entity.favoriteenemy ) )
    {
        return false;
    }
    
    if ( abs( entity.origin[ 2 ] - entity.favoriteenemy.origin[ 2 ] ) > 72 )
    {
        return false;
    }
    
    if ( distance2dsquared( entity.origin, entity.favoriteenemy.origin ) > sqr( 200 ) )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_df4fbf0/namespace_df4fbf0
// Params 1, eflags: 0x4
// Checksum 0xefbc7a48, Offset: 0x730
// Size: 0x4e
function private function_f4a61e6a( entity )
{
    entity.var_9329a57c = gettime() + int( entity ai::function_9139c839().var_d5427206 * 1000 );
}

// Namespace namespace_df4fbf0/namespace_df4fbf0
// Params 1, eflags: 0x4
// Checksum 0x7c1e1c48, Offset: 0x788
// Size: 0x2d0
function private function_85e8940a( entity )
{
    var_aa6baab8 = entity ai::function_9139c839().var_1709a39;
    players = getplayers( #"all", entity.origin, var_aa6baab8 );
    entity clientfield::increment( "brutus_shock_attack", 1 );
    
    foreach ( player in players )
    {
        if ( !namespace_7f5aeb59::isplayervalid( player ) )
        {
            continue;
        }
        
        if ( player.origin[ 2 ] - entity.origin[ 2 ] < -32 )
        {
            continue;
        }
        
        if ( player.origin[ 2 ] - entity.origin[ 2 ] > 200 )
        {
            continue;
        }
        
        if ( !bullettracepassed( entity.origin, player gettagorigin( "j_spine4" ), 0, entity, player ) )
        {
            continue;
        }
        
        damage = mapfloat( entity getpathfindingradius() + 15, entity ai::function_9139c839().var_1709a39, 90, 20, distance( entity.origin, player.origin ) );
        damage = int( max( 20, damage ) );
        player dodamage( damage, entity.origin, entity, entity, "none", "MOD_PROJECTILE_SPLASH" );
        player thread status_effect::status_effect_apply( self.shock_status_effect, undefined, self, 0 );
        player clientfield::increment_to_player( "brutus_shock_attack_player", 1 );
    }
}

