#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1b01e95a6b5270fd;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using scripts\core_common\ai\blackboard_vehicle;
#using scripts\core_common\ai\systems\ai_blackboard;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\statemachine_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_death_shared;
#using scripts\core_common\vehicle_shared;

#namespace namespace_8c89a9e9;

// Namespace namespace_8c89a9e9/namespace_8c89a9e9
// Params 0
// Checksum 0x91b6024c, Offset: 0x1c8
// Size: 0x2c
function init()
{
    namespace_250e9486::function_252dff4d( "ghost_zombie", &function_5836955d );
}

// Namespace namespace_8c89a9e9/namespace_8c89a9e9
// Params 0
// Checksum 0x5dca82d6, Offset: 0x200
// Size: 0x10c
function function_5836955d()
{
    namespace_250e9486::function_25b2c8a9();
    self.zombie_move_speed = "sprint";
    self setblackboardattribute( "_locomotion_speed", "locomotion_speed_sprint" );
    self.maxhealth = 100;
    self.health = self.maxhealth;
    self.animrate = 1.5;
    self.var_e66cd6fb = 1;
    self.var_1c8b76d3 = 1;
    self.no_gib = 1;
    self setavoidancemask( "avoid none" );
    self collidewithactors( 0 );
    self setplayercollision( 0 );
    self.overrideactordamage = &function_b8c581fb;
    self thread function_d8e8920a();
}

// Namespace namespace_8c89a9e9/namespace_8c89a9e9
// Params 12, eflags: 0x4
// Checksum 0xa3c7cf11, Offset: 0x318
// Size: 0xbe, Type: bool
function private function_b8c581fb( *inflictor, *attacker, damage, *flags, *meansofdamage, *weapon, *point, *dir, *hitloc, *offsettime, *boneindex, *modelindex )
{
    if ( modelindex >= self.health )
    {
        self.takedamage = 0;
        self namespace_83eb6304::function_3ecfde67( "electrical_explo" );
        self thread namespace_ec06fe4a::function_52afe5df( 0.2 );
    }
    
    return false;
}

// Namespace namespace_8c89a9e9/namespace_8c89a9e9
// Params 0
// Checksum 0x531376d7, Offset: 0x3e0
// Size: 0x29a
function function_d8e8920a()
{
    self endon( #"death" );
    
    if ( !isdefined( level.doa.var_39e3fa99 ) )
    {
        return;
    }
    
    while ( true )
    {
        wait 1 + randomint( 9 );
        
        if ( isdefined( self.enemy ) )
        {
            var_6e3ad56b = self.enemy.origin;
            
            if ( isplayer( self.enemy ) )
            {
                velocity = self.enemy getvelocity();
                velocity = ( velocity[ 0 ], velocity[ 1 ], 0 );
                
                if ( length( velocity ) >= 0 )
                {
                    var_6e3ad56b += vectorscale( velocity, 1.8 );
                }
            }
            
            dest = getrandomnavpoint( var_6e3ad56b, 20, self getpathfindingradius() );
            
            if ( isdefined( dest ) )
            {
                spot = dest;
            }
            else
            {
                continue;
            }
            
            self namespace_83eb6304::function_3ecfde67( "ethereal_vapors" );
            self.ignoreall = 1;
            self setgoal( self.origin );
            angles = self.enemy.angles + ( 0, 180, 0 );
            self clearenemy();
            self.takedamage = 0;
            self namespace_ec06fe4a::function_8c808737();
            self forceteleport( spot, angles );
            wait 0.3;
            self.takedamage = 1;
            self namespace_ec06fe4a::function_4f72130c();
            self namespace_83eb6304::function_3ecfde67( "ethereal_vapors" );
            wait 0.5;
            self.ignoreall = 0;
            wait 4 + randomint( 6 );
        }
    }
}

