#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/mp_common/teams/teamset;

#namespace teamset_allies;

// Namespace teamset_allies/teamset_allies
// Params 0, eflags: 0x2
// Checksum 0x7a3adedf, Offset: 0x308
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "teamset_allies", &__init__, undefined, undefined );
}

// Namespace teamset_allies/teamset_allies
// Params 0
// Checksum 0x6d64287a, Offset: 0x348
// Size: 0xcc
function __init__()
{
    init( "free" );
    
    foreach ( team in level.teams )
    {
        if ( team == "axis" )
        {
            continue;
        }
        
        init( team );
    }
    
    teamset::customteam_init();
}

// Namespace teamset_allies/teamset_allies
// Params 1
// Checksum 0xd50187a4, Offset: 0x420
// Size: 0x33e
function init( team )
{
    teamset::init();
    game.team = "allies";
    game.attackers = team;
    game.entity_headicon[ team ] = "faction_allies";
    game.headicon[ team ] = "faction_allies";
    level.teamprefix[ team ] = "vox_st";
    level.teampostfix[ team ] = "st6";
    setdvar( "g_TeamName_" + team, &"MPUI_ALLIES_SHORT" );
    setdvar( "g_FactionName_" + team, "allies" );
    game.strings[ team + "_win" ] = &"MP_BLACK_OPS_WIN_MATCH";
    game.strings[ team + "_win_round" ] = &"MP_BLACK_OPS_WIN_ROUND";
    game.strings[ team + "_mission_accomplished" ] = &"MP_BLACK_OPS_MISSION_ACCOMPLISHED";
    game.strings[ team + "_eliminated" ] = &"MP_BLACK_OPS_ELIMINATED";
    game.strings[ team + "_forfeited" ] = &"MP_BLACK_OPS_FORFEITED";
    game.strings[ team + "_name" ] = &"MP_BLACK_OPS_NAME";
    game.strings[ team + "_sweep" ] = &"MP_BLACK_OPS_SWEEP_MATCH";
    game.music[ "spawn_" + team ] = "SPAWN_ST6";
    game.music[ "spawn_short" + team ] = "SPAWN_SHORT_ST6";
    game.music[ "victory_" + team ] = "VICTORY_ST6";
    game.icons[ team ] = "faction_allies";
    game.voice[ team ] = "vox_st6_";
    setdvar( "scr_" + team, "marines" );
    level.heli_vo[ team ][ "hit" ] = "vox_ops_2_kls_attackheli_hit";
    game.flagmodels[ team ] = "p7_mp_flag_allies";
    game.carry_flagmodels[ team ] = "p7_mp_flag_allies_carry";
    game.flagmodels[ "neutral" ] = "p7_mp_flag_neutral";
}

