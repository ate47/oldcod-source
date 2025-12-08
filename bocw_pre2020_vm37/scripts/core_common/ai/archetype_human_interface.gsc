#using scripts\core_common\ai\archetype_human;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\ai_interface;

#namespace humaninterface;

// Namespace humaninterface/archetype_human_interface
// Params 0
// Checksum 0x48786ade, Offset: 0x1a0
// Size: 0x494
function registerhumaninterfaceattributes()
{
    ai::registermatchedinterface( #"human", #"can_be_meleed", 1, array( 1, 0 ), &aiutility::meleeattributescallback );
    ai::registermatchedinterface( #"human", #"can_melee", 1, array( 1, 0 ), &aiutility::meleeattributescallback );
    ai::registermatchedinterface( #"human", #"can_initiateaivsaimelee", 1, array( 1, 0 ) );
    ai::registermatchedinterface( #"human", #"coveridleonly", 0, array( 1, 0 ) );
    ai::registermatchedinterface( #"human", #"useanimationoverride", 0, array( 1, 0 ), &humansoldierserverutils::useanimationoverridecallback );
    ai::registermatchedinterface( #"human", #"disablearrivals", 0, array( 1, 0 ), &aiutility::arrivalattributescallback );
    ai::registermatchedinterface( #"human", #"disablepeek", 0, array( 1, 0 ), &aiutility::function_eef4346c );
    ai::registermatchedinterface( #"human", #"disablelean", 0, array( 1, 0 ), &aiutility::function_1cd75f29 );
    ai::registermatchedinterface( #"human", #"stealth", 0, array( 1, 0 ) );
    ai::registermatchedinterface( #"human", #"vignette_mode", "off", array( "off", "slow", "fast" ), &humansoldierserverutils::vignettemodecallback );
    ai::registermatchedinterface( #"human", #"usegrenades", 1, array( 1, 0 ) );
    ai::registermatchedinterface( #"human", #"demeanor", "combat", array( "combat", "patrol", "cqb", "alert" ), &humansoldierserverutils::function_20fdb709 );
    ai::registermatchedinterface( #"human", #"aim_state", "none", array( "none", "ads", "up", "down" ), &humansoldierserverutils::function_beabbc97 );
}

#namespace humansoldierserverutils;

// Namespace humansoldierserverutils/archetype_human_interface
// Params 4
// Checksum 0xfdeb64a, Offset: 0x640
// Size: 0x64
function useanimationoverridecallback( entity, *attribute, *oldvalue, value )
{
    if ( value )
    {
        oldvalue asmchangeanimmappingtable( 1 );
        return;
    }
    
    oldvalue asmchangeanimmappingtable( 0 );
}

// Namespace humansoldierserverutils/archetype_human_interface
// Params 4
// Checksum 0xf698cc18, Offset: 0x6b0
// Size: 0x1fa
function vignettemodecallback( entity, *attribute, *oldvalue, value )
{
    switch ( value )
    {
        case #"off":
            oldvalue.pushable = 1;
            oldvalue collidewithactors( 0 );
            oldvalue pushplayer( 0 );
            oldvalue setavoidancemask( "avoid all" );
            oldvalue setsteeringmode( "normal steering" );
            break;
        case #"slow":
            oldvalue.pushable = 0;
            oldvalue collidewithactors( 0 );
            oldvalue pushplayer( 1 );
            oldvalue setavoidancemask( "avoid ai" );
            oldvalue setsteeringmode( "vignette steering" );
            break;
        case #"fast":
            oldvalue.pushable = 0;
            oldvalue collidewithactors( 1 );
            oldvalue pushplayer( 1 );
            oldvalue setavoidancemask( "avoid none" );
            oldvalue setsteeringmode( "vignette steering" );
            break;
        default:
            break;
    }
}

// Namespace humansoldierserverutils/archetype_human_interface
// Params 4
// Checksum 0xd2ec0710, Offset: 0x8b8
// Size: 0x17a
function function_20fdb709( entity, *attribute, oldvalue, value )
{
    if ( value === oldvalue )
    {
        return;
    }
    
    attribute setblackboardattribute( "_human_prev_demeanor", oldvalue );
    
    switch ( value )
    {
        case #"combat":
            attribute setblackboardattribute( "_human_demeanor", "COMBAT" );
            break;
        case #"patrol":
            attribute setblackboardattribute( "_human_demeanor", "PATROL" );
            break;
        case #"cqb":
            attribute setblackboardattribute( "_human_demeanor", "CQB" );
            break;
        case #"alert":
            attribute setblackboardattribute( "_human_demeanor", "ALERT" );
            break;
        default:
            attribute setblackboardattribute( "_human_demeanor", "COMBAT" );
            break;
    }
}

// Namespace humansoldierserverutils/archetype_human_interface
// Params 4
// Checksum 0xcda7a514, Offset: 0xa40
// Size: 0x132
function function_beabbc97( entity, *attribute, oldvalue, value )
{
    if ( value === oldvalue )
    {
        return;
    }
    
    switch ( value )
    {
        case #"ads":
            attribute setblackboardattribute( "_aim_overlay", "ADS" );
            break;
        case #"up":
            attribute setblackboardattribute( "_aim_overlay", "UP" );
            break;
        case #"down":
            attribute setblackboardattribute( "_aim_overlay", "DOWN" );
            break;
        case #"none":
        default:
            attribute setblackboardattribute( "_aim_overlay", "NONE" );
            break;
    }
}

