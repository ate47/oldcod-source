#using scripts/core_common/util_shared;

#namespace spawning;

// Namespace spawning/spawning
// Params 2
// Checksum 0x95c6a36e, Offset: 0xd8
// Size: 0x15c
function getteamstartspawnname( team, spawnpointnamebase )
{
    spawn_point_team_name = team;
    
    if ( !level.multiteam && game.switchedsides )
    {
        spawn_point_team_name = util::getotherteam( team );
    }
    
    if ( level.multiteam )
    {
        if ( team == "axis" )
        {
            spawn_point_team_name = "team1";
        }
        else if ( team == "allies" )
        {
            spawn_point_team_name = "team2";
        }
        
        if ( !util::isoneround() )
        {
            number = int( getsubstr( spawn_point_team_name, 4, 5 ) ) - 1;
            number = ( number + game.roundsplayed ) % level.teams.size + 1;
            spawn_point_team_name = "team" + number;
        }
    }
    
    return spawnpointnamebase + "_" + spawn_point_team_name + "_start";
}

// Namespace spawning/spawning
// Params 1
// Checksum 0xf78f17d9, Offset: 0x240
// Size: 0x2a
function gettdmstartspawnname( team )
{
    return getteamstartspawnname( team, "mp_tdm_spawn" );
}

