#using scripts\core_common\util_shared;
#using scripts\mp_common\util;

#namespace spawning;

// Namespace spawning/spawning
// Params 2, eflags: 0x0
// Checksum 0x47a8faa9, Offset: 0xa0
// Size: 0x138
function getteamstartspawnname(team, spawnpointnamebase) {
    spawn_point_team_name = team;
    spawn_point_team_name = util::function_82f4ab63(team);
    if (level.multiteam) {
        if (team == #"axis") {
            spawn_point_team_name = "team1";
        } else if (team == #"allies") {
            spawn_point_team_name = "team2";
        }
        if (!util::isoneround()) {
            number = int(getsubstr(spawn_point_team_name, 4, 5)) - 1;
            number = (number + game.roundsplayed) % level.teams.size + 1;
            spawn_point_team_name = "team" + number;
        }
    }
    return spawnpointnamebase + "_" + spawn_point_team_name + "_start";
}

// Namespace spawning/spawning
// Params 1, eflags: 0x0
// Checksum 0xb2617f91, Offset: 0x1e0
// Size: 0x2a
function gettdmstartspawnname(team) {
    return getteamstartspawnname(team, "mp_tdm_spawn");
}

