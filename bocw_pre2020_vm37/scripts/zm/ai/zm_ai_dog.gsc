#using script_36f4be19da8eb6d0;
#using script_789f2367a00401d8;
#using scripts\core_common\ai\archetype_mocomps_utility;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\system_shared;
#using scripts\zm\ai\zm_ai_dog_interface;
#using scripts\zm_common\ai\zombie_dog_toxic_cloud;
#using scripts\zm_common\zm_utility;

#namespace zm_ai_dog;

// Namespace zm_ai_dog/zm_ai_dog
// Params 0, eflags: 0x6
// Checksum 0xa20b1f8c, Offset: 0x250
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"zm_ai_dog", &preinit, undefined, undefined, undefined );
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 0, eflags: 0x4
// Checksum 0x1dde9e24, Offset: 0x298
// Size: 0x74
function private preinit()
{
    registerbehaviorscriptfunctions();
    spawner::add_archetype_spawn_function( #"zombie_dog", &function_b9d56970 );
    clientfield::register( "actor", "ZombieDogVocals", 1, 2, "int" );
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 0
// Checksum 0x59b778d3, Offset: 0x318
// Size: 0x104
function function_b9d56970()
{
    self.var_93a62fe = zm_utility::get_closest_valid_player( self.origin, undefined, 1 );
    self.closest_player_override = &zm_utility::function_c52e1749;
    self.var_ef1ed308 = &function_ea61b64a;
    self.var_b077b73d = &function_b077b73d;
    self callback::function_d8abfc3d( #"on_ai_killed", &function_ca4ce82b );
    
    if ( level.dog_round_count <= 1 )
    {
        self clientfield::set( "ZombieDogVocals", 1 );
        return;
    }
    
    self clientfield::set( "ZombieDogVocals", 2 );
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 0
// Checksum 0xd86d131b, Offset: 0x428
// Size: 0x424
function registerbehaviorscriptfunctions()
{
    spawner::add_archetype_spawn_function( #"zombie_dog", &archetypezombiedogblackboardinit );
    assert( isscriptfunctionptr( &zombiedogtargetservice ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"zombiedogtargetservice", &zombiedogtargetservice, 1 );
    assert( isscriptfunctionptr( &function_5e50d260 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_29b43f0d0b6bd4e2", &function_5e50d260, 2 );
    assert( isscriptfunctionptr( &zombiedogshouldmelee ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"zombiedogshouldmelee", &zombiedogshouldmelee );
    assert( isscriptfunctionptr( &zombiedogshouldwalk ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"zombiedogshouldwalk", &zombiedogshouldwalk );
    assert( isscriptfunctionptr( &zombiedogshouldrun ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"zombiedogshouldrun", &zombiedogshouldrun );
    assert( isscriptfunctionptr( &function_4a7e2ba0 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_545a7d19924edd47", &function_4a7e2ba0 );
    assert( !isdefined( &zombiedogmeleeaction ) || isscriptfunctionptr( &zombiedogmeleeaction ) );
    assert( !isdefined( undefined ) || isscriptfunctionptr( undefined ) );
    assert( !isdefined( &zombiedogmeleeactionterminate ) || isscriptfunctionptr( &zombiedogmeleeactionterminate ) );
    behaviortreenetworkutility::registerbehaviortreeaction( "zombieDogMeleeAction", &zombiedogmeleeaction, undefined, &zombiedogmeleeactionterminate );
    animationstatenetwork::registernotetrackhandlerfunction( "zombie_dog_explode", &function_7ee905fc );
    animationstatenetwork::registernotetrackhandlerfunction( "zombie_dog_suicide", &function_7ee905fc );
    zm_ai_dog_interface::registerzombiedoginterfaceattributes();
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 0
// Checksum 0x66f2b4a7, Offset: 0x858
// Size: 0x56
function archetypezombiedogblackboardinit()
{
    blackboard::createblackboardforentity( self );
    ai::createinterfaceforentity( self );
    self.___archetypeonanimscriptedcallback = &archetypezombiedogonanimscriptedcallback;
    self.kill_on_wine_coccon = 1;
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 1, eflags: 0x4
// Checksum 0xb45bd1b, Offset: 0x8b8
// Size: 0x2c
function private archetypezombiedogonanimscriptedcallback( entity )
{
    entity.__blackboard = undefined;
    entity archetypezombiedogblackboardinit();
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 0
// Checksum 0xcd964edf, Offset: 0x8f0
// Size: 0xba
function bb_getshouldrunstatus()
{
    if ( isdefined( self.var_1dddf9ab ) )
    {
        return self [[ self.var_1dddf9ab ]]();
    }
    
    /#
        if ( is_true( self.ispuppet ) )
        {
            return "<dev string:x38>";
        }
    #/
    
    if ( is_true( self.hasseenfavoriteenemy ) || ai::hasaiattribute( self, "sprint" ) && ai::getaiattribute( self, "sprint" ) )
    {
        return "run";
    }
    
    return "walk";
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 0
// Checksum 0x8636ed30, Offset: 0x9b8
// Size: 0xc2
function bb_getshouldhowlstatus()
{
    if ( self ai::has_behavior_attribute( "howl_chance" ) && is_true( self.hasseenfavoriteenemy ) )
    {
        if ( !isdefined( self.shouldhowl ) )
        {
            chance = self ai::get_behavior_attribute( "howl_chance" );
            self.shouldhowl = randomfloat( 1 ) <= chance;
        }
        
        return ( self.shouldhowl ? "howl" : "dont_howl" );
    }
    
    return "dont_howl";
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 1
// Checksum 0x4c4b0160, Offset: 0xa88
// Size: 0x3e
function getyaw( org )
{
    angles = vectortoangles( org - self.origin );
    return angles[ 1 ];
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 0
// Checksum 0x27ee7b16, Offset: 0xad0
// Size: 0x92
function absyawtoenemy()
{
    assert( isdefined( self.enemy ) );
    yaw = self.angles[ 1 ] - getyaw( self.enemy.origin );
    yaw = angleclamp180( yaw );
    
    if ( yaw < 0 )
    {
        yaw = -1 * yaw;
    }
    
    return yaw;
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 0
// Checksum 0xc2b64e8f, Offset: 0xb70
// Size: 0x21a, Type: bool
function need_to_run()
{
    run_dist_squared = sqr( self ai::get_behavior_attribute( "min_run_dist" ) );
    run_yaw = 20;
    run_pitch = 30;
    run_height = 192;
    
    if ( level.dog_round_count > 1 )
    {
        return true;
    }
    
    if ( self.health < self.maxhealth )
    {
        return true;
    }
    
    if ( !isdefined( self.enemy ) || !isalive( self.enemy ) )
    {
        return false;
    }
    
    if ( !self cansee( self.enemy ) )
    {
        return false;
    }
    
    dist = distance2dsquared( self.origin, self.enemy.origin );
    
    if ( dist > run_dist_squared )
    {
        return false;
    }
    
    height = self.origin[ 2 ] - self.enemy.origin[ 2 ];
    
    if ( abs( height ) > run_height )
    {
        return false;
    }
    
    yaw = self absyawtoenemy();
    
    if ( yaw > run_yaw )
    {
        return false;
    }
    
    pitch = angleclamp180( vectortoangles( self.origin - self.enemy.origin )[ 0 ] );
    
    if ( abs( pitch ) > run_pitch )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 2
// Checksum 0x63863b2d, Offset: 0xd98
// Size: 0x20c
function is_target_valid( dog, target )
{
    if ( !isdefined( target ) )
    {
        return 0;
    }
    
    if ( !isalive( target ) )
    {
        return 0;
    }
    
    if ( !( dog.team == #"allies" ) )
    {
        if ( !isplayer( target ) && sessionmodeiszombiesgame() )
        {
            return 0;
        }
        
        if ( isdefined( target.is_zombie ) && target.is_zombie == 1 )
        {
            return 0;
        }
    }
    
    if ( isplayer( target ) && target.sessionstate == "spectator" )
    {
        return 0;
    }
    
    if ( isplayer( target ) && target.sessionstate == "intermission" )
    {
        return 0;
    }
    
    if ( is_true( self.intermission ) )
    {
        return 0;
    }
    
    if ( is_true( target.ignoreme ) )
    {
        return 0;
    }
    
    if ( target isnotarget() )
    {
        return 0;
    }
    
    if ( dog.team == target.team )
    {
        return 0;
    }
    
    if ( isplayer( target ) && isdefined( level.var_6f6cc58 ) )
    {
        if ( !dog [[ level.var_6f6cc58 ]]( target ) )
        {
            return 0;
        }
    }
    
    if ( isplayer( target ) && isdefined( level.is_player_valid_override ) )
    {
        return [[ level.is_player_valid_override ]]( target );
    }
    
    return 1;
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 1, eflags: 0x4
// Checksum 0xa5b02e9f, Offset: 0xfb0
// Size: 0x21c
function private get_favorite_enemy( dog )
{
    dog_targets = [];
    
    if ( sessionmodeiszombiesgame() )
    {
        if ( self.team == #"allies" )
        {
            dog_targets = getaiteamarray( level.zombie_team );
        }
        else
        {
            dog_targets = getplayers();
        }
    }
    else
    {
        dog_targets = arraycombine( getplayers(), getaiarray(), 0, 0 );
    }
    
    least_hunted = dog_targets[ 0 ];
    closest_target_dist_squared = undefined;
    
    for ( i = 0; i < dog_targets.size ; i++ )
    {
        if ( !isdefined( dog_targets[ i ].hunted_by ) )
        {
            dog_targets[ i ].hunted_by = 0;
        }
        
        if ( !is_target_valid( dog, dog_targets[ i ] ) )
        {
            continue;
        }
        
        if ( !is_target_valid( dog, least_hunted ) )
        {
            least_hunted = dog_targets[ i ];
        }
        
        dist_squared = distancesquared( dog.origin, dog_targets[ i ].origin );
        
        if ( dog_targets[ i ].hunted_by <= least_hunted.hunted_by && ( !isdefined( closest_target_dist_squared ) || dist_squared < closest_target_dist_squared ) )
        {
            least_hunted = dog_targets[ i ];
            closest_target_dist_squared = dist_squared;
        }
    }
    
    if ( !is_target_valid( dog, least_hunted ) )
    {
        return undefined;
    }
    
    least_hunted.hunted_by += 1;
    return least_hunted;
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 0
// Checksum 0x7f5848df, Offset: 0x11d8
// Size: 0x2e
function get_last_valid_position()
{
    if ( isplayer( self ) )
    {
        return self.last_valid_position;
    }
    
    return self.origin;
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 1
// Checksum 0x405ff123, Offset: 0x1210
// Size: 0x232
function get_locomotion_target( behaviortreeentity )
{
    if ( !isdefined( behaviortreeentity.favoriteenemy ) )
    {
        return undefined;
    }
    
    last_valid_position = behaviortreeentity.favoriteenemy get_last_valid_position();
    
    if ( !isdefined( last_valid_position ) )
    {
        return undefined;
    }
    
    locomotion_target = last_valid_position;
    
    if ( ai::has_behavior_attribute( "spacing_value" ) )
    {
        spacing_near_dist = ai::get_behavior_attribute( "spacing_near_dist" );
        spacing_far_dist = ai::get_behavior_attribute( "spacing_far_dist" );
        spacing_horz_dist = ai::get_behavior_attribute( "spacing_horz_dist" );
        spacing_value = ai::get_behavior_attribute( "spacing_value" );
        to_enemy = behaviortreeentity.favoriteenemy.origin - behaviortreeentity.origin;
        perp = vectornormalize( ( to_enemy[ 1 ] * -1, to_enemy[ 0 ], 0 ) );
        offset = perp * spacing_horz_dist * spacing_value;
        spacing_dist = math::clamp( length( to_enemy ), spacing_near_dist, spacing_far_dist );
        lerp_amount = math::clamp( ( spacing_dist - spacing_near_dist ) / ( spacing_far_dist - spacing_near_dist ), 0, 1 );
        desired_point = last_valid_position + offset * lerp_amount;
        desired_point = getclosestpointonnavmesh( desired_point, spacing_horz_dist * 1.2, 16 );
        
        if ( isdefined( desired_point ) )
        {
            locomotion_target = desired_point;
        }
    }
    
    return locomotion_target;
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 1
// Checksum 0x66065bc6, Offset: 0x1450
// Size: 0x3d2
function zombiedogtargetservice( behaviortreeentity )
{
    if ( is_true( level.intermission ) )
    {
        behaviortreeentity clearpath();
        return;
    }
    
    /#
        if ( is_true( behaviortreeentity.ispuppet ) )
        {
            return;
        }
    #/
    
    if ( behaviortreeentity ai::has_behavior_attribute( "patrol" ) && behaviortreeentity ai::get_behavior_attribute( "patrol" ) )
    {
        return;
    }
    
    if ( !is_target_valid( behaviortreeentity, behaviortreeentity.favoriteenemy ) )
    {
        if ( isdefined( behaviortreeentity.favoriteenemy ) )
        {
            function_ea61b64a( behaviortreeentity );
            behaviortreeentity.hasseenfavoriteenemy = 0;
        }
        
        behaviortreeentity.favoriteenemy = get_favorite_enemy( behaviortreeentity );
    }
    
    if ( behaviortreeentity.ignoreall || behaviortreeentity.pacifist || !is_target_valid( behaviortreeentity, behaviortreeentity.favoriteenemy ) )
    {
        if ( is_target_valid( behaviortreeentity, behaviortreeentity.favoriteenemy ) )
        {
            if ( isdefined( level.var_d22435d9 ) )
            {
                [[ level.var_d22435d9 ]]( behaviortreeentity );
            }
        }
        else
        {
            if ( isdefined( behaviortreeentity function_4794d6a3().overridegoalpos ) )
            {
                behaviortreeentity function_d4c687c9();
            }
            
            if ( isdefined( level.no_target_override ) )
            {
                [[ level.no_target_override ]]( behaviortreeentity );
                return;
            }
            
            behaviortreeentity setgoal( behaviortreeentity.origin );
            return;
        }
    }
    
    if ( !is_true( behaviortreeentity.hasseenfavoriteenemy ) )
    {
        if ( isdefined( behaviortreeentity.favoriteenemy ) && behaviortreeentity need_to_run() )
        {
            behaviortreeentity.hasseenfavoriteenemy = 1;
            
            if ( level.dog_round_count <= 1 )
            {
                self clientfield::set( "ZombieDogVocals", 2 );
            }
        }
    }
    
    if ( isdefined( behaviortreeentity.favoriteenemy ) )
    {
        if ( isdefined( level.enemy_location_override_func ) )
        {
            goalpos = [[ level.enemy_location_override_func ]]( behaviortreeentity, behaviortreeentity.favoriteenemy );
            
            if ( isdefined( goalpos ) )
            {
                behaviortreeentity setgoal( goalpos );
                return;
            }
        }
        
        locomotion_target = get_locomotion_target( behaviortreeentity );
        
        if ( isdefined( locomotion_target ) )
        {
            repathdist = 16;
            
            if ( !isdefined( behaviortreeentity.lasttargetposition ) || distancesquared( behaviortreeentity.lasttargetposition, locomotion_target ) > sqr( repathdist ) || !behaviortreeentity haspath() )
            {
                behaviortreeentity function_a57c34b7( locomotion_target );
                behaviortreeentity.lasttargetposition = locomotion_target;
            }
        }
    }
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 1
// Checksum 0x3b7cfb73, Offset: 0x1830
// Size: 0xe0, Type: bool
function zombiedogshouldmelee( behaviortreeentity )
{
    if ( behaviortreeentity.ignoreall || !is_target_valid( behaviortreeentity, behaviortreeentity.favoriteenemy ) )
    {
        return false;
    }
    
    if ( !is_true( level.intermission ) )
    {
        meleedist = 72;
        
        if ( distancesquared( behaviortreeentity.origin, behaviortreeentity.favoriteenemy.origin ) < sqr( meleedist ) && behaviortreeentity cansee( behaviortreeentity.favoriteenemy ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 1
// Checksum 0x50acd040, Offset: 0x1918
// Size: 0x24, Type: bool
function zombiedogshouldwalk( *behaviortreeentity )
{
    return bb_getshouldrunstatus() == "walk";
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 1
// Checksum 0xa61c2ba8, Offset: 0x1948
// Size: 0x24, Type: bool
function zombiedogshouldrun( *behaviortreeentity )
{
    return bb_getshouldrunstatus() == "run";
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 1
// Checksum 0x14134054, Offset: 0x1978
// Size: 0x68, Type: bool
function function_4a7e2ba0( behaviortreeentity )
{
    if ( !is_true( behaviortreeentity.takedamage ) )
    {
        return false;
    }
    
    if ( behaviortreeentity.subarchetype === #"hash_28e36e7b7d5421f" )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 0
// Checksum 0x66c900a2, Offset: 0x19e8
// Size: 0x166, Type: bool
function use_low_attack()
{
    if ( !isdefined( self.enemy ) || !isplayer( self.enemy ) )
    {
        return false;
    }
    
    height_diff = self.enemy.origin[ 2 ] - self.origin[ 2 ];
    low_enough = 30;
    
    if ( height_diff < low_enough && self.enemy getstance() == "prone" )
    {
        return true;
    }
    
    melee_origin = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] + 65 );
    enemy_origin = ( self.enemy.origin[ 0 ], self.enemy.origin[ 1 ], self.enemy.origin[ 2 ] + 32 );
    
    if ( !bullettracepassed( melee_origin, enemy_origin, 0, self ) )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 2
// Checksum 0x447e31b, Offset: 0x1b58
// Size: 0xa0
function zombiedogmeleeaction( behaviortreeentity, asmstatename )
{
    behaviortreeentity clearpath();
    context = "high";
    
    if ( behaviortreeentity use_low_attack() )
    {
        context = "low";
    }
    
    behaviortreeentity setblackboardattribute( "_context", context );
    animationstatenetworkutility::requeststate( behaviortreeentity, asmstatename );
    return 5;
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 2
// Checksum 0xf5b825a0, Offset: 0x1c00
// Size: 0x38
function zombiedogmeleeactionterminate( behaviortreeentity, *asmstatename )
{
    asmstatename setblackboardattribute( "_context", undefined );
    return 4;
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 4
// Checksum 0x4ad1fd3f, Offset: 0x1c40
// Size: 0x44
function zombiedoggravity( entity, *attribute, *oldvalue, value )
{
    oldvalue setblackboardattribute( "_low_gravity", value );
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 1
// Checksum 0xddf62886, Offset: 0x1c90
// Size: 0x166
function function_5e50d260( dog )
{
    if ( !isdefined( dog.favoriteenemy ) || !zm_utility::is_player_valid( dog.favoriteenemy ) )
    {
        return;
    }
    
    if ( !isdefined( dog.var_93a62fe ) || dog.favoriteenemy == dog.var_93a62fe )
    {
        return;
    }
    
    if ( !is_true( dog.var_2eda3fd0 ) )
    {
        dog.var_90957231 = dog zm_utility::approximate_path_dist( dog.favoriteenemy );
        dog.var_2eda3fd0 = 1;
        return;
    }
    
    new_target_dist = dog zm_utility::approximate_path_dist( dog.var_93a62fe );
    
    if ( isdefined( dog.var_90957231 ) )
    {
        if ( isdefined( new_target_dist ) && dog.var_90957231 - new_target_dist > 200 )
        {
            dog function_e856134( dog, dog.var_93a62fe );
        }
    }
    else if ( isdefined( new_target_dist ) )
    {
        dog function_e856134( dog, dog.var_93a62fe );
    }
    
    dog.var_2eda3fd0 = 0;
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 2
// Checksum 0x21c2a60a, Offset: 0x1e00
// Size: 0x64
function function_e856134( dog, new_target )
{
    function_ea61b64a( dog );
    
    if ( !isdefined( new_target.hunted_by ) )
    {
        new_target.hunted_by = 0;
    }
    
    dog.favoriteenemy = new_target;
    dog.favoriteenemy.hunted_by++;
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 1
// Checksum 0x49b35788, Offset: 0x1e70
// Size: 0x6e
function function_ea61b64a( dog )
{
    if ( isdefined( dog.favoriteenemy ) && isdefined( dog.favoriteenemy.hunted_by ) && dog.favoriteenemy.hunted_by > 0 )
    {
        dog.favoriteenemy.hunted_by--;
    }
    
    dog.favoriteenemy = undefined;
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 1, eflags: 0x4
// Checksum 0xca0588c9, Offset: 0x1ee8
// Size: 0x8c
function private function_7ee905fc( *params )
{
    if ( self ishidden() )
    {
        return;
    }
    
    self callback::callback( #"on_dog_killed" );
    
    if ( isalive( self ) )
    {
        self kill( undefined, undefined, undefined, undefined, 0, 1 );
    }
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 1, eflags: 0x4
// Checksum 0xe9180085, Offset: 0x1f80
// Size: 0xcc
function private function_b077b73d( *time )
{
    if ( self.subarchetype === #"hash_28e36e7b7d5421f" || self.subarchetype === #"hash_2a5479b83161cb35" )
    {
        context = self getblackboardattribute( "_context" );
        
        if ( isdefined( context ) && ( context == "low" || context == "high" ) )
        {
            self ai::stun();
            println( "<dev string:x80>" );
        }
    }
}

// Namespace zm_ai_dog/zm_ai_dog
// Params 1, eflags: 0x4
// Checksum 0x7b86ab7, Offset: 0x2058
// Size: 0x106
function private function_ca4ce82b( s_params )
{
    self clientfield::set( "ZombieDogVocals", 0 );
    
    if ( self.subarchetype === #"hash_2a5479b83161cb35" )
    {
        self playsound( #"hash_6e603d5f1970365b" );
    }
    else
    {
        self playsound( #"hash_550a93f75490460f" );
    }
    
    if ( self.subarchetype === #"hash_28e36e7b7d5421f" || self.subarchetype === #"hash_2a5479b83161cb35" )
    {
        if ( isdefined( s_params.weapon ) && namespace_b376a999::function_5fef4201( s_params.weapon ) )
        {
            self.var_270befd2 = 1;
        }
    }
}

