#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace classicmode;

// Namespace classicmode/classicmode
// Params 0, eflags: 0x2
// Checksum 0x7609ffe5, Offset: 0x2d8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "classicmode", &__init__, undefined, undefined );
}

// Namespace classicmode/classicmode
// Params 0
// Checksum 0x510417e6, Offset: 0x318
// Size: 0x4c
function __init__()
{
    level.classicmode = getgametypesetting( "classicMode" );
    
    if ( level.classicmode )
    {
        enableclassicmode();
    }
}

// Namespace classicmode/classicmode
// Params 0
// Checksum 0x60748498, Offset: 0x370
// Size: 0x1bc
function enableclassicmode()
{
    setdvar( "bg_t7BlockMeleeUsageTime", 100 );
    setdvar( "doublejump_enabled", 0 );
    setdvar( "wallRun_enabled", 0 );
    setdvar( "slide_maxTime", 550 );
    setdvar( "playerEnergy_slideEnergyEnabled", 0 );
    setdvar( "trm_maxSideMantleHeight", 0 );
    setdvar( "trm_maxBackMantleHeight", 0 );
    setdvar( "player_swimming_enabled", 0 );
    setdvar( "player_swimHeightRatio", 0.9 );
    setdvar( "player_sprintSpeedScale", 1.5 );
    setdvar( "jump_slowdownEnable", 1 );
    setdvar( "sprint_allowRestore", 0 );
    setdvar( "sprint_allowReload", 0 );
    setdvar( "sprint_allowRechamber", 0 );
    setdvar( "cg_blur_time", 500 );
    setdvar( "tu11_enableClassicMode", 1 );
}

