#using scripts/core_common/struct;

#namespace teamset;

// Namespace teamset/teamset
// Params 0
// Checksum 0xe42fb185, Offset: 0x108
// Size: 0x82
function init()
{
    if ( !isdefined( game.flagmodels ) )
    {
        game.flagmodels = [];
    }
    
    if ( !isdefined( game.carry_flagmodels ) )
    {
        game.carry_flagmodels = [];
    }
    
    if ( !isdefined( game.carry_icon ) )
    {
        game.carry_icon = [];
    }
    
    game.flagmodels[ "neutral" ] = "p7_mp_flag_neutral";
}

// Namespace teamset/teamset
// Params 0
// Checksum 0x2de1bd03, Offset: 0x198
// Size: 0xb4
function customteam_init()
{
    if ( getdvarstring( "g_customTeamName_Allies" ) != "" )
    {
        setdvar( "g_TeamName_Allies", getdvarstring( "g_customTeamName_Allies" ) );
    }
    
    if ( getdvarstring( "g_customTeamName_Axis" ) != "" )
    {
        setdvar( "g_TeamName_Axis", getdvarstring( "g_customTeamName_Axis" ) );
    }
}

