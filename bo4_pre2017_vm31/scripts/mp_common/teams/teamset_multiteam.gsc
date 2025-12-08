#using scripts/core_common/struct;
#using scripts/mp_common/teams/teamset;
#using scripts/mp_common/teams/teamset_allies;
#using scripts/mp_common/teams/teamset_axis;

#namespace teamset_multiteam;

// Namespace teamset_multiteam/teamset_multiteam
// Params 0
// Checksum 0xf9ef52c1, Offset: 0x418
// Size: 0xd8
function main()
{
    teamset::init();
    toggle = 0;
    
    foreach ( team in level.teams )
    {
        if ( toggle % 2 )
        {
            init_axis( team );
        }
        else
        {
            init_allies( team );
        }
        
        toggle++;
    }
}

// Namespace teamset_multiteam/teamset_multiteam
// Params 1
// Checksum 0x2900a4fc, Offset: 0x4f8
// Size: 0x33e
function init_allies( team )
{
    game.team = "allies";
    game.attackers = team;
    game.entity_headicon[ team ] = "faction_allies";
    game.headicon[ team ] = "faction_allies";
    level.teamprefix[ team ] = "vox_st";
    level.teampostfix[ team ] = "st6";
    setdvar( "g_TeamName_" + team, &"MPUI_ALLIES_SHORT" );
    setdvar( "g_TeamColor_" + team, "0.6 0.64 0.69" );
    setdvar( "g_ScoresColor_" + team, "0.6 0.64 0.69" );
    setdvar( "g_FactionName_" + team, game.team );
    game.strings[ team + "_win" ] = &"MP_SEALS_WIN_MATCH";
    game.strings[ team + "_win_round" ] = &"MP_SEALS_WIN_ROUND";
    game.strings[ team + "_mission_accomplished" ] = &"MP_SEALS_MISSION_ACCOMPLISHED";
    game.strings[ team + "_eliminated" ] = &"MP_SEALS_ELIMINATED";
    game.strings[ team + "_forfeited" ] = &"MP_SEALS_FORFEITED";
    game.strings[ team + "_name" ] = &"MP_SEALS_NAME";
    game.music[ "spawn_" + team ] = "SPAWN_ST6";
    game.music[ "spawn_short" + team ] = "SPAWN_SHORT_ST6";
    game.music[ "victory_" + team ] = "VICTORY_ST6";
    game.icons[ team ] = "faction_allies";
    game.voice[ team ] = "vox_st6_";
    setdvar( "scr_" + team, "marines" );
    level.heli_vo[ team ][ "hit" ] = "vox_ops_2_kls_attackheli_hit";
    game.flagmodels[ team ] = "mp_flag_allies_1";
    game.carry_flagmodels[ team ] = "mp_flag_allies_1_carry";
}

// Namespace teamset_multiteam/teamset_multiteam
// Params 1
// Checksum 0x1278fb59, Offset: 0x840
// Size: 0x33e
function init_axis( team )
{
    game.team = "axis";
    game.defenders = team;
    game.entity_headicon[ team ] = "faction_axis";
    game.headicon[ team ] = "faction_axis";
    level.teamprefix[ team ] = "vox_pm";
    level.teampostfix[ team ] = "init_axis";
    setdvar( "g_TeamName_" + team, &"MPUI_AXIS_SHORT" );
    setdvar( "g_TeamColor_" + team, "0.65 0.57 0.41" );
    setdvar( "g_ScoresColor_" + team, "0.65 0.57 0.41" );
    setdvar( "g_FactionName_" + team, game.team );
    game.strings[ team + "_win" ] = &"MP_PMC_WIN_MATCH";
    game.strings[ team + "_win_round" ] = &"MP_PMC_WIN_ROUND";
    game.strings[ team + "_mission_accomplished" ] = &"MP_PMC_MISSION_ACCOMPLISHED";
    game.strings[ team + "_eliminated" ] = &"MP_PMC_ELIMINATED";
    game.strings[ team + "_forfeited" ] = &"MP_PMC_FORFEITED";
    game.strings[ team + "_name" ] = &"MP_PMC_NAME";
    game.music[ "spawn_" + team ] = "SPAWN_PMC";
    game.music[ "spawn_short" + team ] = "SPAWN_SHORT_PMC";
    game.music[ "victory_" + team ] = "VICTORY_PMC";
    game.icons[ team ] = "faction_axis";
    game.voice[ team ] = "vox_pmc_";
    setdvar( "scr_" + team, "ussr" );
    level.heli_vo[ team ][ "hit" ] = "vox_rus_0_kls_attackheli_hit";
    game.flagmodels[ team ] = "mp_flag_axis_1";
    game.carry_flagmodels[ team ] = "mp_flag_axis_1_carry";
}

