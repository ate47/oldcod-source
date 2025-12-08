#using scripts\core_common\flag_shared;
#using scripts\core_common\stealth\callbacks;
#using scripts\core_common\stealth\debug;
#using scripts\core_common\stealth\manager;
#using scripts\core_common\stealth\utility;

#namespace namespace_32a4062b;

// Namespace namespace_32a4062b/friendly
// Params 0
// Checksum 0x7105668e, Offset: 0x108
// Size: 0x84
function main()
{
    if ( !isdefined( level.stealth ) )
    {
        stealth_manager::function_f9682fd();
    }
    
    self init_settings();
    self thread spotted_thread();
    self thread visibility_thread();
    
    /#
        self thread stealth_debug::debug_friendly();
    #/
}

// Namespace namespace_32a4062b/friendly
// Params 0
// Checksum 0x94396519, Offset: 0x198
// Size: 0x12e
function init_settings()
{
    assert( !isdefined( self.stealth ), "<dev string:x38>" );
    self.stealth = spawnstruct();
    self.stealth.spotted_list = [];
    self.stealth.funcs = [];
    self flag::init( "stealth_enabled" );
    self flag::init( "stealth_override_goal" );
    self flag::set( "stealth_enabled" );
    self namespace_979752dc::assign_unique_id();
    self namespace_979752dc::group_add();
    self.stealth.var_103386e8 = self namespace_979752dc::group_flag_init( "stealth_spotted" );
    self.stealth.bsmstate = -1;
}

// Namespace namespace_32a4062b/friendly
// Params 0
// Checksum 0xe7f7daa1, Offset: 0x2d0
// Size: 0x178
function spotted_thread()
{
    self endon( #"death" );
    self notify( #"spotted_thread" );
    self endon( #"spotted_thread" );
    
    while ( true )
    {
        self flag::wait_till( "stealth_enabled" );
        self namespace_979752dc::group_flag_waitopen( "stealth_spotted" );
        
        if ( !self flag::get( "stealth_enabled" ) )
        {
            self flag::wait_till( "stealth_enabled" );
        }
        
        self thread state_hidden();
        self flag::wait_till( "stealth_enabled" );
        self namespace_979752dc::group_flag_wait( "stealth_spotted" );
        
        if ( !self flag::get( "stealth_enabled" ) )
        {
            self flag::wait_till( "stealth_enabled" );
        }
        
        self thread state_spotted();
    }
}

// Namespace namespace_32a4062b/friendly
// Params 0
// Checksum 0xcd52f3ea, Offset: 0x450
// Size: 0xa4
function state_hidden()
{
    self thread namespace_979752dc::setbattlechatter( 0 );
    self.stealth.oldgrenadeammo = self.grenadeammo;
    self.grenadeammo = 0;
    self.forcesidearm = 0;
    self.dontevershoot = 1;
    self.dontattackme = 1;
    
    if ( isdefined( self.stealth.funcs[ #"hidden" ] ) )
    {
        self namespace_b2b86d39::stealth_call_thread( "hidden" );
    }
}

// Namespace namespace_32a4062b/friendly
// Params 0
// Checksum 0x5ef4eda3, Offset: 0x500
// Size: 0xec
function state_spotted()
{
    assert( !isplayer( self ) );
    self thread namespace_979752dc::setbattlechatter( 1 );
    
    if ( isdefined( self.stealth.oldgrenadeammo ) )
    {
        self.grenadeammo = self.stealth.oldgrenadeammo;
    }
    else
    {
        self.grenadeammo = 3;
    }
    
    self.dontevershoot = 0;
    self.dontattackme = 0;
    self pushplayer( 0 );
    
    if ( isdefined( self.stealth.funcs[ #"spotted" ] ) )
    {
        self namespace_b2b86d39::stealth_call_thread( "spotted" );
    }
}

// Namespace namespace_32a4062b/friendly
// Params 0
// Checksum 0x49db3f45, Offset: 0x5f8
// Size: 0x18
function getup_from_prone()
{
    self endon( #"death" );
}

// Namespace namespace_32a4062b/friendly
// Params 0
// Checksum 0x6237e271, Offset: 0x618
// Size: 0x88
function visibility_thread()
{
    self endon( #"death" );
    self endon( #"long_death" );
    
    while ( true )
    {
        self flag::wait_till( "stealth_enabled" );
        
        if ( !isdefined( self.stealth.ignore_visibility ) )
        {
            self.maxvisibledist = self get_detect_range();
        }
        
        wait 0.05;
    }
}

// Namespace namespace_32a4062b/friendly
// Params 0
// Checksum 0xe8c3ced0, Offset: 0x6a8
// Size: 0x112
function get_detect_range()
{
    stance = self.currentpose;
    
    if ( stance === "back" )
    {
        stance = "prone";
    }
    
    if ( self namespace_979752dc::group_spotted_flag() )
    {
        detection = "spotted";
    }
    else
    {
        detection = "hidden";
    }
    
    range = level.stealth.detect.range[ detection ][ stance ];
    
    if ( self flag::get( "stealth_in_shadow" ) )
    {
        range = max( level.stealth.detect.range[ #"hidden" ][ #"prone" ], range * 0.5 );
    }
    
    return range;
}

