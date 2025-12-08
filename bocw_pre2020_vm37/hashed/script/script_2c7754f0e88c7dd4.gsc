#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1b01e95a6b5270fd;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_774302f762d76254;
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
#using scripts\core_common\vehicles\raps;

#namespace namespace_a0fa2b5;

// Namespace namespace_a0fa2b5/namespace_a0fa2b5
// Params 0
// Checksum 0x7bc9b9d9, Offset: 0x1b0
// Size: 0xac
function init()
{
    namespace_250e9486::function_252dff4d( "meatball_large", &function_d240d5de, &function_41157a40 );
    namespace_250e9486::function_252dff4d( "meatball_medium", &function_d240d5de, &function_41157a40 );
    namespace_250e9486::function_252dff4d( "meatball_small", &function_d240d5de, &function_41157a40 );
}

// Namespace namespace_a0fa2b5/namespace_a0fa2b5
// Params 1
// Checksum 0xf929cb29, Offset: 0x268
// Size: 0x1e4
function function_fd051611( *s_params )
{
    enemy = self.favoriteenemy;
    origin = self.origin;
    angles = self.angles;
    
    if ( self.vehicletype == #"spawner_zombietron_veh_meatball" )
    {
        if ( !isdefined( level.doa.var_e37e1100 ) )
        {
            level.doa.var_e37e1100 = doa_enemy::function_d7c5adee( "meatball_medium" );
        }
        
        def = level.doa.var_e37e1100;
    }
    else if ( self.vehicletype == #"spawner_zombietron_veh_meatball_med" )
    {
        if ( !isdefined( level.doa.var_77c6357f ) )
        {
            level.doa.var_77c6357f = doa_enemy::function_d7c5adee( "meatball_small" );
        }
        
        def = level.doa.var_77c6357f;
    }
    
    if ( isdefined( def ) )
    {
        var_3dcc592c = doa_enemy::function_db55a448( def, origin, enemy );
        var_5001fd97 = doa_enemy::function_db55a448( def, origin + ( 0, 20, 0 ), enemy );
        
        if ( isdefined( var_3dcc592c ) )
        {
            var_3dcc592c namespace_83eb6304::function_3ecfde67( "demon_burst" );
        }
        
        if ( isdefined( var_5001fd97 ) )
        {
            var_5001fd97 namespace_83eb6304::function_3ecfde67( "demon_burst" );
        }
    }
}

// Namespace namespace_a0fa2b5/namespace_a0fa2b5
// Params 0
// Checksum 0x399ddc8d, Offset: 0x458
// Size: 0x39c
function function_d240d5de()
{
    self useanimtree( "generic" );
    self namespace_ec06fe4a::function_8c808737();
    self callback::function_d8abfc3d( #"on_vehicle_killed", &function_fd051611 );
    namespace_250e9486::function_25b2c8a9();
    initblackboard();
    self.b_ignore_cleanup = 1;
    self.var_5dd07a80 = 1;
    self.var_232915af = 1;
    self.var_68139d12 = 1;
    self.nodamagefeedback = 1;
    self vehicle::friendly_fire_shield();
    self enableaimassist();
    self setneargoalnotifydist( 60 );
    self setdrawinfrared( 1 );
    self solid();
    self.fovcosine = 0;
    self.fovcosinebusy = 0;
    assert( isdefined( self.scriptbundlesettings ) );
    self.settings = getscriptbundle( self.scriptbundlesettings );
    self.showdelay = 0.4;
    self.goalradius = 512;
    self.goalheight = 100;
    self.var_ec0d66ce = 0.5 * ( self.settings.engagementdistmin + self.settings.engagementdistmax );
    self.var_ff6d7c88 = sqr( self.var_ec0d66ce );
    self thread vehicle_ai::nudge_collision();
    self.health = 3000;
    self.maxhealth = 3000;
    self.var_f7f65924 = 5;
    self.damage_on_death = 0;
    target_set( self );
    
    if ( isdefined( level.doa.var_a598a835 ) )
    {
        self.spawnloc = [[ level.doa.var_a598a835 ]]();
    }
    else if ( namespace_4dae815d::function_59a9cf1d() == 0 )
    {
        if ( self.vehicletype == #"spawner_zombietron_veh_meatball" )
        {
            self.spawnloc = spawnstruct();
            self.spawnloc.origin = [[ level.doa.var_39e3fa99 ]]->function_70fb5745().origin + ( 0, 0, 1600 );
            self.spawnloc.angles = [[ level.doa.var_39e3fa99 ]]->function_70fb5745().angles;
        }
    }
    
    if ( namespace_4dae815d::function_59a9cf1d() == 5 )
    {
        /#
            self thread function_839fc28e();
        #/
    }
}

/#

    // Namespace namespace_a0fa2b5/namespace_a0fa2b5
    // Params 0
    // Checksum 0xb904330, Offset: 0x800
    // Size: 0x66, Type: dev
    function function_839fc28e()
    {
        self endon( #"death" );
        
        while ( true )
        {
            line( self.origin, self.origin + ( 0, 0, 1000 ), ( 1, 0, 0 ), 1, 0, 1 );
            waitframe( 1 );
        }
    }

#/

// Namespace namespace_a0fa2b5/namespace_a0fa2b5
// Params 0
// Checksum 0x1b0df3e2, Offset: 0x870
// Size: 0x64
function function_41157a40()
{
    self endon( #"death" );
    self thread updatetarget();
    
    while ( !self.var_c0bd8c06 )
    {
        wait 1;
        namespace_250e9486::function_c1f37cab();
    }
    
    self thread namespace_ec06fe4a::function_570729f0( 0 );
}

// Namespace namespace_a0fa2b5/namespace_a0fa2b5
// Params 0, eflags: 0x4
// Checksum 0xf26db51a, Offset: 0x8e0
// Size: 0x54
function private initblackboard()
{
    self.__blackboard = undefined;
    blackboard::createblackboardforentity( self );
    self blackboard::registervehicleblackboardattributes();
    ai::createinterfaceforentity( self );
}

// Namespace namespace_a0fa2b5/namespace_a0fa2b5
// Params 0, eflags: 0x4
// Checksum 0xffb3980e, Offset: 0x940
// Size: 0x70
function private updatetarget()
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( is_true( self.ignoreall ) )
        {
            wait 0.5;
            continue;
        }
        
        self namespace_250e9486::function_4b49bf0d();
        wait 0.5;
    }
}

