#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace userspawnselection;

// Namespace userspawnselection/userspawnselection
// Params 0, eflags: 0x2
// Checksum 0xa378618e, Offset: 0x318
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "userspawnselection", &__init__, undefined, undefined );
}

// Namespace userspawnselection/userspawnselection
// Params 1
// Checksum 0x51908ca, Offset: 0x358
// Size: 0xc0
function getteamclientfieldvalue( team )
{
    if ( !isdefined( team ) )
    {
        return 0;
    }
    
    teamname = team;
    
    if ( team == "attackers" )
    {
        teamname = game.attackers;
    }
    else if ( team == "defenders" )
    {
        teamname = game.defenders;
    }
    
    if ( team == "allies" )
    {
        return 1;
    }
    else if ( team == "axis" )
    {
        return 2;
    }
    else if ( team == "neutral" )
    {
        return 3;
    }
    
    return 0;
}

// Namespace userspawnselection/userspawnselection
// Params 0
// Checksum 0x671f87af, Offset: 0x420
// Size: 0xbc
function __init__()
{
    level.next_spawngroup_index = 0;
    level.spawngroups = [];
    level.spawnselect_timelimit_ms = getdvarint( "spawnselect_timelimit_ms", 10000 );
    level.useteamspecificforwardspawns = getgametypesetting( "forwardSpawnTeamSpecificSpawns" );
    callback::on_finalize_initialization( &setupspawngroups );
    setupuimodels();
    setupclientfields();
}

// Namespace userspawnselection/userspawnselection
// Params 1, eflags: 0x4
// Checksum 0xf29eb6c2, Offset: 0x4e8
// Size: 0x20
function private getdatamodelprefix( id )
{
    return "spawngroupStatus." + id + ".";
}

// Namespace userspawnselection/userspawnselection
// Params 0
// Checksum 0x8f349a16, Offset: 0x510
// Size: 0x18c
function setupclientfields()
{
    for ( index = 0; index < 20 ; index++ )
    {
        basename = getdatamodelprefix( index );
        clientfield::register( "worlduimodel", basename + "visStatus", 1, 1, "int", undefined, 0, 1 );
        clientfield::register( "worlduimodel", basename + "useStatus", 1, 1, "int", undefined, 0, 1 );
        clientfield::register( "worlduimodel", basename + "team", 1, 2, "int", undefined, 0, 1 );
    }
    
    clientfield::register( "toplayer", "spawnselect_timeout", 1, 1, "int", &ontimeoutchange, 0, 0 );
    clientfield::register( "clientuimodel", "hudItems.showSpawnSelect", 1, 1, "int", undefined, 0, 0 );
}

// Namespace userspawnselection/userspawnselection
// Params 7
// Checksum 0x91972e71, Offset: 0x6a8
// Size: 0xc4
function ontimeoutchange( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    controllermodel = getuimodelforcontroller( localclientnum );
    timeoutmodel = createuimodel( controllermodel, "hudItems.spawnSelectEndTime" );
    setuimodelvalue( timeoutmodel, getservertime( 0, 1 ) + level.spawnselect_timelimit_ms );
}

// Namespace userspawnselection/userspawnselection
// Params 0
// Checksum 0x5feb8044, Offset: 0x778
// Size: 0x176
function setupuimodels()
{
    for ( index = 0; index < 20 ; index++ )
    {
        spawngroupprefix = getdatamodelprefix( index );
        createuimodel( getglobaluimodel(), spawngroupprefix + "regionName" );
        createuimodel( getglobaluimodel(), spawngroupprefix + "origin.x" );
        createuimodel( getglobaluimodel(), spawngroupprefix + "origin.y" );
        createuimodel( getglobaluimodel(), spawngroupprefix + "origin.z" );
        createuimodel( getglobaluimodel(), spawngroupprefix + "isForwardSpawn" );
        createuimodel( getglobaluimodel(), spawngroupprefix + "team" );
    }
}

// Namespace userspawnselection/userspawnselection
// Params 1, eflags: 0x4
// Checksum 0xc1a54698, Offset: 0x8f8
// Size: 0x2bc
function private setupstaticmodelfieldsforspawngroup( spawngroup )
{
    basename = getdatamodelprefix( spawngroup.uiindex );
    namemodel = getuimodel( getglobaluimodel(), basename + "regionName" );
    spawngroupname = "";
    
    if ( isdefined( spawngroup.ui_label ) )
    {
        spawngroupname = istring( spawngroup.ui_label );
    }
    
    setuimodelvalue( namemodel, spawngroupname );
    xmodel = getuimodel( getglobaluimodel(), basename + "origin.x" );
    setuimodelvalue( xmodel, spawngroup.origin[ 0 ] );
    ymodel = getuimodel( getglobaluimodel(), basename + "origin.y" );
    setuimodelvalue( ymodel, spawngroup.origin[ 1 ] );
    zmodel = getuimodel( getglobaluimodel(), basename + "origin.z" );
    setuimodelvalue( zmodel, spawngroup.origin[ 2 ] );
    isforwardspawnmodel = getuimodel( getglobaluimodel(), basename + "isForwardSpawn" );
    
    if ( isdefined( spawngroup.spawnflags ) && ( spawngroup.spawnflags & 1 ) == 1 )
    {
        setuimodelvalue( isforwardspawnmodel, 1 );
        return;
    }
    
    setuimodelvalue( isforwardspawnmodel, 0 );
}

// Namespace userspawnselection/userspawnselection
// Params 1
// Checksum 0x19facbdc, Offset: 0xbc0
// Size: 0x6c
function setupspawngroup( spawngroup )
{
    spawngroup.uiindex = level.next_spawngroup_index;
    level.next_spawngroup_index++;
    level.spawngroups[ spawngroup.uiindex ] = spawngroup;
    setupstaticmodelfieldsforspawngroup( spawngroup );
}

// Namespace userspawnselection/userspawnselection
// Params 1
// Checksum 0xc67fed66, Offset: 0xc38
// Size: 0x14a
function setupspawngroups( localclientnum )
{
    spawngroups = struct::get_array( "spawn_group_marker", "targetname" );
    
    if ( !isdefined( spawngroups ) )
    {
        return;
    }
    
    spawngroupssorted = array::get_all_closest( ( 0, 0, 0 ), spawngroups );
    
    foreach ( spawngroup in spawngroupssorted )
    {
        if ( !level.useteamspecificforwardspawns )
        {
            if ( isdefined( spawngroup.spawnflags ) && ( spawngroup.spawnflags & 1 ) == 1 && spawngroup.script_team == "defenders" )
            {
                continue;
            }
        }
        
        setupspawngroup( spawngroup );
    }
}

