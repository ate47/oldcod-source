#using scripts\core_common\clientfield_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\cp_common\util;

#namespace namespace_1512c89a;

// Namespace namespace_1512c89a/level_init
// Params 1, eflags: 0x40
// Checksum 0x6f2c5caa, Offset: 0x200
// Size: 0x10c
function event_handler[level_init] main( *eventstruct )
{
    clientfield::register( "world", "hide_nuke_clouds", 1, 1, "int", &function_685e7492, 0, 0 );
    clientfield::register( "world", "nuke_trigger_hit", 1, 1, "int", &function_4a6ad8d7, 0, 0 );
    clientfield::register( "world", "post_nuke_state", 1, 1, "int", &function_11fba536, 0, 0 );
    load::main();
    util::waitforclient( 0 );
}

// Namespace namespace_1512c89a/namespace_1512c89a
// Params 7
// Checksum 0x1441a0ca, Offset: 0x318
// Size: 0x84
function function_11fba536( *localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    var_11196acd = getent( 0, "nuke_cloud_ring_a_rest", "targetname" );
    var_11196acd hide();
}

// Namespace namespace_1512c89a/namespace_1512c89a
// Params 7
// Checksum 0x2e77b8cc, Offset: 0x3a8
// Size: 0x1ec
function function_685e7492( *localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    var_11196acd = getent( 0, "nuke_cloud_ring_a", "targetname" );
    var_6c6ea17e = getent( 0, "nuke_cloud_ring_a_rest", "targetname" );
    var_a2de0e58 = getent( 0, "nuke_cloud_ring_b", "targetname" );
    var_1d4dedf6 = getent( 0, "nuke_cloud_ring_b_rest", "targetname" );
    var_ac9f21da = getent( 0, "nuke_cloud_ring_c", "targetname" );
    var_a173cea7 = getent( 0, "nuke_cloud_ring_c_rest", "targetname" );
    var_11196acd hide();
    var_6c6ea17e hide();
    var_a2de0e58 hide();
    var_1d4dedf6 hide();
    var_ac9f21da hide();
    var_a173cea7 hide();
}

// Namespace namespace_1512c89a/namespace_1512c89a
// Params 7
// Checksum 0x1481dfc8, Offset: 0x5a0
// Size: 0x84
function function_4a6ad8d7( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( bwastimejump )
    {
        thread function_b25ca84b();
        thread function_5b0bca7f();
        thread function_9fe1697d();
        thread function_9fccf47b();
    }
}

// Namespace namespace_1512c89a/namespace_1512c89a
// Params 0
// Checksum 0x66daee8e, Offset: 0x630
// Size: 0x15c
function function_b25ca84b()
{
    shockwave = getent( 0, "nuke_shockwave_a", "targetname" );
    wait 1;
    
    for ( loopcount = 0; loopcount < 1 ; loopcount++ )
    {
        shockwave playrenderoverridebundle( "rob_nuke_shockwave_02" );
        steps = 0;
        
        while ( steps < 161 )
        {
            time = gettime();
            var_b76b4560 = time / 1000;
            var_78623e67 = steps * 0.009;
            timeoffset = var_b76b4560 - var_78623e67 * 10;
            shockwave function_78233d29( "rob_nuke_shockwave_02", "", "StartTime", timeoffset );
            steps += 1;
            wait 0.05;
        }
        
        shockwave function_f6e99a8d( "rob_nuke_shockwave_02" );
        wait 1;
    }
}

// Namespace namespace_1512c89a/namespace_1512c89a
// Params 0
// Checksum 0x7b373270, Offset: 0x798
// Size: 0x8c
function function_5b0bca7f()
{
    cloud = getent( 0, "nuke_cloud_ring_a_rest", "targetname" );
    function_aa5bd1e8( "nuke_cloud_ring_a", "nuke_cloud_ring_a_rest" );
    cloud playrenderoverridebundle( "rob_nuke_cloud_ring_fade_01" );
    wait 16;
    cloud hide();
}

// Namespace namespace_1512c89a/namespace_1512c89a
// Params 0
// Checksum 0xda371535, Offset: 0x830
// Size: 0x24
function function_9fe1697d()
{
    function_aa5bd1e8( "nuke_cloud_ring_b", "nuke_cloud_ring_b_rest" );
}

// Namespace namespace_1512c89a/namespace_1512c89a
// Params 0
// Checksum 0x2d5d38a9, Offset: 0x860
// Size: 0x24
function function_9fccf47b()
{
    function_aa5bd1e8( "nuke_cloud_ring_c", "nuke_cloud_ring_c_rest" );
}

// Namespace namespace_1512c89a/namespace_1512c89a
// Params 2
// Checksum 0xe02f82b4, Offset: 0x890
// Size: 0x244
function function_aa5bd1e8( var_6c1da019, var_37749f24 )
{
    cloud = getent( 0, var_6c1da019, "targetname" );
    var_6c6ea17e = getent( 0, var_37749f24, "targetname" );
    steps = 0;
    maxsteps = 81;
    timeoffset = 0;
    var_78623e67 = 0;
    var_5b9dea0b = 0.43;
    var_da44ea59 = var_5b9dea0b / maxsteps;
    wait 2;
    starttime = gettime();
    cloud show();
    cloud playrenderoverridebundle( "rob_nuke_cloud_ring_reveal_01" );
    
    while ( var_78623e67 < var_5b9dea0b )
    {
        time = gettime();
        var_b76b4560 = time / 1000;
        var_341ccdfc = max( ( maxsteps - steps / 4 ) / maxsteps, 0.006 );
        var_78623e67 = steps * var_da44ea59 * var_341ccdfc;
        timeoffset = var_b76b4560 - var_78623e67 * 10;
        cloud function_78233d29( "rob_nuke_cloud_ring_reveal_01", "", "StartTime", timeoffset );
        steps += 1;
        wait 0.05;
    }
    
    endtime = gettime();
    cloud function_f6e99a8d( "rob_nuke_cloud_ring_reveal_01" );
    var_6c6ea17e show();
    cloud hide();
}

// Namespace namespace_1512c89a/namespace_1512c89a
// Params 0
// Checksum 0x855d1ade, Offset: 0xae0
// Size: 0xc8
function function_d79ef530()
{
    cloud = getent( 0, "nuke_shockwave_a", "targetname" );
    brightness = 0;
    
    while ( true )
    {
        result = cloud mapshaderconstant( 0, "scriptControl", brightness * 20, 0, 1 );
        brightness += 0.01;
        
        if ( brightness >= 1 )
        {
            brightness = 0;
        }
        
        wait 0.1;
    }
}

