#using scripts/core_common/gameobjects_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/util_shared;
#using scripts/mp_common/gametypes/globallogic;
#using scripts/mp_common/gametypes/globallogic_audio;
#using scripts/mp_common/gametypes/globallogic_score;
#using scripts/mp_common/gametypes/loadout;
#using scripts/mp_common/util;

#namespace os;

// Namespace os/os
// Params 1
// Checksum 0x3595dad5, Offset: 0x210
// Size: 0xc8
function turn_back_time( basegametype )
{
    gameobjects::register_allowed_gameobject( "os" );
    gameobjects::register_allowed_gameobject( basegametype );
    level.oldschoolweapon = getweapon( "pistol_standard" );
    level.primaryoffhandnull = getweapon( "null_offhand_primary" );
    level.secondaryoffhandnull = getweapon( "null_offhand_secondary" );
    level.givecustomloadout = &give_oldschool_loadout;
}

// Namespace os/os
// Params 0
// Checksum 0x9574f24e, Offset: 0x2e0
// Size: 0x136
function give_oldschool_loadout()
{
    self loadout::function_79d05183( 1 );
    self loadout::function_1d84af77( "CLASS_ASSAULT" );
    self giveweapon( level.oldschoolweapon );
    self switchtoweapon( level.oldschoolweapon );
    self giveweapon( level.primaryoffhandnull );
    self giveweapon( level.secondaryoffhandnull );
    self setweaponammoclip( level.primaryoffhandnull, 0 );
    self setweaponammoclip( level.secondaryoffhandnull, 0 );
    
    if ( self.firstspawn !== 0 )
    {
        self setspawnweapon( level.oldschoolweapon );
    }
    
    return level.oldschoolweapon;
}

