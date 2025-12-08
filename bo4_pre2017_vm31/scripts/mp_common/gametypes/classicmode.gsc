#using scripts/core_common/clientfield_shared;
#using scripts/core_common/spawner_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/mp_common/gametypes/globallogic;
#using scripts/mp_common/gametypes/globallogic_player;
#using scripts/mp_common/gametypes/globallogic_utils;

#namespace classicmode;

// Namespace classicmode/classicmode
// Params 0, eflags: 0x2
// Checksum 0x2958d395, Offset: 0x320
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "classicmode", &__init__, undefined, undefined );
}

// Namespace classicmode/classicmode
// Params 0
// Checksum 0xd6b0ac7c, Offset: 0x360
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
// Checksum 0x1f1f8d47, Offset: 0x3b8
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

