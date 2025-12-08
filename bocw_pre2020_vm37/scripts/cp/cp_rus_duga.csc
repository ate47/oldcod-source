#using script_38867f943fb86135;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\easing;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\util_shared;

#namespace cp_rus_duga;

// Namespace cp_rus_duga/level_init
// Params 1, eflags: 0x40
// Checksum 0x4ce39941, Offset: 0x160
// Size: 0x104
function event_handler[level_init] main( *eventstruct )
{
    setsaveddvar( #"enable_global_wind", 1 );
    setsaveddvar( #"wind_global_vector", "88 0 0" );
    setsaveddvar( #"wind_global_low_altitude", 0 );
    setsaveddvar( #"wind_global_hi_altitude", 10000 );
    setsaveddvar( #"wind_global_low_strength_percent", 100 );
    init_clientfields();
    load::main();
    util::waitforclient( 0 );
}

// Namespace cp_rus_duga/cp_rus_duga
// Params 0
// Checksum 0x514a720c, Offset: 0x270
// Size: 0x124
function init_clientfields()
{
    clientfield::register( "toplayer", "tappy_input_player", 1, 1, "int", &function_6dc4c05f, 0, 1 );
    clientfield::register( "toplayer", "pstfx_slow_motion", 1, 1, "int", &function_91f74051, 0, 1 );
    clientfield::register( "toplayer", "pstfx_player_stabbed", 1, 1, "int", &function_405b4be7, 0, 1 );
    clientfield::register( "toplayer", "pstfx_chromatic_aberration", 1, 1, "int", &pstfx_chromatic_aberration, 0, 0 );
}

// Namespace cp_rus_duga/cp_rus_duga
// Params 7
// Checksum 0xa25944fe, Offset: 0x3a0
// Size: 0x3c
function function_6dc4c05f( *localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    
}

// Namespace cp_rus_duga/cp_rus_duga
// Params 7
// Checksum 0x23ceae43, Offset: 0x3e8
// Size: 0x84
function function_91f74051( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( bwastimejump > 0 )
    {
        self postfx::playpostfxbundle( "pstfx_slow_motion" );
        return;
    }
    
    self postfx::stoppostfxbundle( "pstfx_slow_motion" );
}

// Namespace cp_rus_duga/cp_rus_duga
// Params 7
// Checksum 0x34e37590, Offset: 0x478
// Size: 0x84
function function_405b4be7( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( bwastimejump > 0 )
    {
        self postfx::playpostfxbundle( "pstfx_head_trauma" );
        return;
    }
    
    self postfx::stoppostfxbundle( "pstfx_head_trauma" );
}

// Namespace cp_rus_duga/cp_rus_duga
// Params 7
// Checksum 0x6ea5510a, Offset: 0x508
// Size: 0xc4
function pstfx_chromatic_aberration( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump )
{
    if ( bwasdemojump )
    {
        if ( self postfx::function_556665f2( "pstfx_catseye_interactive_cinematic" ) )
        {
            self postfx::stoppostfxbundle( "pstfx_catseye_interactive_cinematic" );
        }
        
        self postfx::playpostfxbundle( "pstfx_catseye_interactive_cinematic" );
        return;
    }
    
    self postfx::exitpostfxbundle( "pstfx_catseye_interactive_cinematic" );
}

