#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using scripts\core_common\ai\archetype_damage_utility;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\destructible_character;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;

#namespace namespace_f6712ec9;

// Namespace namespace_f6712ec9/namespace_f6712ec9
// Params 0
// Checksum 0x1f478321, Offset: 0x198
// Size: 0x18c
function init()
{
    assert( isscriptfunctionptr( &function_29c22852 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_4ead7642034f30f7", &function_29c22852 );
    assert( isscriptfunctionptr( &function_33b29495 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_3d7ced75f59bb519", &function_33b29495 );
    assert( isscriptfunctionptr( &function_27a1a846 ) );
    behaviortreenetworkutility::registerbehaviortreescriptapi( #"hash_6e9be4be56cd06d3", &function_27a1a846 );
    animationstatenetwork::registernotetrackhandlerfunction( "nova_crawler_melee", &function_99ac548f );
    namespace_250e9486::function_252dff4d( "crawler_zombie", &function_96a48049, undefined );
}

// Namespace namespace_f6712ec9/namespace_f6712ec9
// Params 0
// Checksum 0xbfdd5f26, Offset: 0x330
// Size: 0x12c
function function_96a48049()
{
    self namespace_250e9486::function_25b2c8a9();
    self.var_1731eda3 = 1;
    self.var_2c628c0f = 1;
    self.canbetargetedbyturnedzombies = 1;
    self.is_zombie = 1;
    self.zombie_move_speed = "sprint";
    self.no_gib = 1;
    self.var_a592ffaa = 1;
    animrate = randomfloatrange( 1, 1.3 );
    self asmsetanimationrate( animrate );
    self namespace_83eb6304::function_3ecfde67( "nova_crawler_aura_fx" );
    
    if ( isdefined( self.var_d55f22cb ) )
    {
        self namespace_83eb6304::function_3ecfde67( "nova_crawler_burst" );
    }
    
    self callback::function_d8abfc3d( #"on_ai_killed", &function_3dbef270 );
}

// Namespace namespace_f6712ec9/namespace_f6712ec9
// Params 1
// Checksum 0x70ec0d62, Offset: 0x468
// Size: 0x11c
function function_3dbef270( *params )
{
    self stoploopsound();
    
    if ( mayspawnentity() && validateorigin( self.origin ) )
    {
        playsoundatposition( #"zmb_quad_explo", self.origin );
    }
    
    self namespace_83eb6304::function_3ecfde67( "nova_crawler_burst" );
    trigger = namespace_ec06fe4a::spawntrigger( "trigger_radius", self.origin, 2 | 1 | 512, 40, 50 );
    
    if ( isdefined( trigger ) )
    {
        trigger thread namespace_ec06fe4a::function_52afe5df( 3 );
        trigger thread function_86555fba();
    }
}

// Namespace namespace_f6712ec9/namespace_f6712ec9
// Params 0
// Checksum 0x6dd12c8b, Offset: 0x590
// Size: 0x98
function function_86555fba()
{
    self endon( #"death" );
    
    while ( true )
    {
        result = self waittill( #"trigger" );
        
        if ( isdefined( result.activator ) && !is_true( result.activator.boss ) )
        {
            result.activator thread function_b5feb0bf();
        }
    }
}

// Namespace namespace_f6712ec9/namespace_f6712ec9
// Params 0
// Checksum 0x6c7fab0a, Offset: 0x630
// Size: 0x1fe
function function_b5feb0bf()
{
    self notify( "4b6042e7c70ab062" );
    self endon( "4b6042e7c70ab062" );
    self endon( #"death" );
    
    if ( isvehicle( self ) )
    {
        return;
    }
    
    if ( is_true( self.var_a592ffaa ) )
    {
        return;
    }
    
    self.var_4ee91a53 = gettime() + 5000;
    var_36313dca = isdefined( self.animrate ) ? self.animrate : 1;
    
    if ( self.team == #"axis" )
    {
        animrate = 1.25;
    }
    
    if ( self.team == #"allies" )
    {
        animrate = 0.65;
    }
    
    if ( isplayer( self ) )
    {
        self namespace_7f5aeb59::function_ec9a307f( 5, animrate );
    }
    else if ( !isdefined( self.var_26471e4b ) )
    {
        self.var_26471e4b = animrate;
        self asmsetanimationrate( animrate );
        self namespace_83eb6304::function_3ecfde67( "nova_crawler_aura_fx" );
    }
    
    while ( gettime() < self.var_4ee91a53 )
    {
        wait 0.5;
    }
    
    if ( !isplayer( self ) )
    {
        self.var_26471e4b = undefined;
        self asmsetanimationrate( var_36313dca );
        self namespace_83eb6304::turnofffx( "nova_crawler_aura_fx" );
    }
    
    self.var_4ee91a53 = undefined;
}

// Namespace namespace_f6712ec9/namespace_f6712ec9
// Params 1
// Checksum 0xf118535a, Offset: 0x838
// Size: 0x246, Type: bool
function function_29c22852( entity )
{
    if ( !isdefined( entity.enemy ) )
    {
        return false;
    }
    
    if ( isdefined( entity.marked_for_death ) )
    {
        return false;
    }
    
    if ( is_true( entity.ignoremelee ) )
    {
        return false;
    }
    
    if ( abs( entity.origin[ 2 ] - entity.enemy.origin[ 2 ] ) > 64 )
    {
        return false;
    }
    
    if ( isdefined( entity.meleeweapon ) && entity.meleeweapon !== level.weaponnone )
    {
        meleedistsq = entity.meleeweapon.aimeleerange * entity.meleeweapon.aimeleerange;
    }
    
    if ( !isdefined( meleedistsq ) )
    {
        return false;
    }
    
    if ( distancesquared( entity.origin, entity.enemy.origin ) > meleedistsq )
    {
        return false;
    }
    
    yawtoenemy = angleclamp180( entity.angles[ 1 ] - vectortoangles( entity.enemy.origin - entity.origin )[ 1 ] );
    
    if ( abs( yawtoenemy ) > 60 )
    {
        return false;
    }
    
    if ( !entity cansee( entity.enemy ) )
    {
        return false;
    }
    
    if ( !tracepassedonnavmesh( entity.origin, isdefined( entity.enemy.last_valid_position ) ? entity.enemy.last_valid_position : entity.enemy.origin, entity getpathfindingradius() ) )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_f6712ec9/namespace_f6712ec9
// Params 1, eflags: 0x4
// Checksum 0x90eb8462, Offset: 0xa88
// Size: 0xa8
function private function_33b29495( *entity )
{
    var_711090a2 = 0;
    var_b77044e1 = lerpfloat( 0.2, 0.8, math::clamp( ( level.doa.roundnumber - 1 ) / 30, 0, 1 ) );
    
    if ( randomfloat( 1 ) <= var_b77044e1 )
    {
        var_711090a2 = 1;
    }
    
    return var_711090a2;
}

// Namespace namespace_f6712ec9/namespace_f6712ec9
// Params 1, eflags: 0x4
// Checksum 0xa95a67e1, Offset: 0xb38
// Size: 0x4e
function private function_27a1a846( *entity )
{
    var_62d41d8f = 0;
    
    if ( is_true( self.killed_enemy_player ) )
    {
        var_62d41d8f = 1;
        self.killed_enemy_player = 0;
    }
    
    return var_62d41d8f;
}

// Namespace namespace_f6712ec9/namespace_f6712ec9
// Params 1, eflags: 0x4
// Checksum 0xbfb97295, Offset: 0xb90
// Size: 0x44
function private function_99ac548f( entity )
{
    entity melee();
    entity callback::callback( #"on_ai_melee" );
}

