#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace forward_spawn;

// Namespace forward_spawn/forward_spawn
// Params 0, eflags: 0x2
// Checksum 0x5b50c13a, Offset: 0x230
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "forward_spawn", &__init__, undefined, undefined );
}

// Namespace forward_spawn/forward_spawn
// Params 0
// Checksum 0xb72cb1cf, Offset: 0x270
// Size: 0x7c
function __init__()
{
    setupuimodels();
    level.nextforwardspawnindex = 0;
    clientfield::register( "worlduimodel", "hudItems.war.forwardSpawnStatus", 1, 2, "int", undefined, 0, 1 );
    callback::on_finalize_initialization( &setupforwardspawnmodels );
}

// Namespace forward_spawn/forward_spawn
// Params 1
// Checksum 0x9b72f116, Offset: 0x2f8
// Size: 0x20
function getstaticmodelprefix( index )
{
    return "forwardspawns." + index + ".";
}

// Namespace forward_spawn/forward_spawn
// Params 0
// Checksum 0x9698a406, Offset: 0x320
// Size: 0x116
function setupuimodels()
{
    for ( index = 0; index < 8 ; index++ )
    {
        forwardspawnprefix = getstaticmodelprefix( index );
        createuimodel( getglobaluimodel(), forwardspawnprefix + "origin.x" );
        createuimodel( getglobaluimodel(), forwardspawnprefix + "origin.y" );
        createuimodel( getglobaluimodel(), forwardspawnprefix + "origin.z" );
        createuimodel( getglobaluimodel(), forwardspawnprefix + "zone_index" );
    }
}

// Namespace forward_spawn/forward_spawn
// Params 1
// Checksum 0x826a991c, Offset: 0x440
// Size: 0x1dc
function populateforwardspawnmodel( forwardspawn )
{
    basename = getstaticmodelprefix( level.nextforwardspawnindex );
    level.nextforwardspawnindex++;
    xmodel = getuimodel( getglobaluimodel(), basename + "origin.x" );
    setuimodelvalue( xmodel, forwardspawn.origin[ 0 ] );
    ymodel = getuimodel( getglobaluimodel(), basename + "origin.y" );
    setuimodelvalue( ymodel, forwardspawn.origin[ 1 ] );
    zmodel = getuimodel( getglobaluimodel(), basename + "origin.z" );
    setuimodelvalue( zmodel, forwardspawn.origin[ 2 ] );
    zoneindexmodel = getuimodel( getglobaluimodel(), basename + "zone_index" );
    setuimodelvalue( zoneindexmodel, forwardspawn.script_zoneindex );
}

// Namespace forward_spawn/forward_spawn
// Params 1
// Checksum 0x6fd88508, Offset: 0x628
// Size: 0xea
function setupforwardspawnmodels( localclientnum )
{
    forwardspawns = struct::get_array( "forward_spawn", "targetname" );
    
    if ( !isdefined( forwardspawns ) )
    {
        return;
    }
    
    forwardspawnssorted = array::get_all_closest( ( 0, 0, 0 ), forwardspawns );
    
    foreach ( forwardspawn in forwardspawnssorted )
    {
        populateforwardspawnmodel( forwardspawn );
    }
}

