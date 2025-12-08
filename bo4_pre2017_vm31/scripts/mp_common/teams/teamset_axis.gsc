#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/mp_common/teams/teamset;

#namespace teamset_axis;

// Namespace teamset_axis/teamset_axis
// Params 0, eflags: 0x2
// Checksum 0x70a8682a, Offset: 0x2c0
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "teamset_axis", &__init__, undefined, undefined );
}

// Namespace teamset_axis/teamset_axis
// Params 0
// Checksum 0xf457d926, Offset: 0x300
// Size: 0x2c
function __init__()
{
    init( "axis" );
    teamset::customteam_init();
}

// Namespace teamset_axis/teamset_axis
// Params 1
// Checksum 0x74edaeb5, Offset: 0x338
// Size: 0x33e
function init( team )
{
    teamset::init();
    game.team = "axis";
    game.defenders = team;
    game.entity_headicon[ team ] = "faction_axis";
    game.headicon[ team ] = "faction_axis";
    level.teamprefix[ team ] = "vox_pm";
    level.teampostfix[ team ] = "axis";
    setdvar( "g_TeamName_" + team, &"MPUI_AXIS_SHORT" );
    setdvar( "g_FactionName_" + team, "axis" );
    game.strings[ team + "_win" ] = &"MP_CDP_WIN_MATCH";
    game.strings[ team + "_win_round" ] = &"MP_CDP_WIN_ROUND";
    game.strings[ team + "_mission_accomplished" ] = &"MP_CDP_MISSION_ACCOMPLISHED";
    game.strings[ team + "_eliminated" ] = &"MP_CDP_ELIMINATED";
    game.strings[ team + "_forfeited" ] = &"MP_CDP_FORFEITED";
    game.strings[ team + "_name" ] = &"MP_CDP_NAME";
    game.strings[ team + "_sweep" ] = &"MP_CDP_SWEEP_MATCH";
    game.music[ "spawn_" + team ] = "SPAWN_PMC";
    game.music[ "spawn_short" + team ] = "SPAWN_SHORT_PMC";
    game.music[ "victory_" + team ] = "VICTORY_PMC";
    game.icons[ team ] = "faction_axis";
    game.voice[ team ] = "vox_pmc_";
    setdvar( "scr_" + team, "ussr" );
    level.heli_vo[ team ][ "hit" ] = "vox_rus_0_kls_attackheli_hit";
    game.flagmodels[ team ] = "p7_mp_flag_axis";
    game.carry_flagmodels[ team ] = "p7_mp_flag_axis_carry";
    game.flagmodels[ "neutral" ] = "p7_mp_flag_neutral";
}

