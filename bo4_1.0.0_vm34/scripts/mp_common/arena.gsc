#using scripts\core_common\callbacks_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;
#using scripts\mp_common\gametypes\match;

#namespace arena;

// Namespace arena/arena
// Params 0, eflags: 0x2
// Checksum 0xb2539052, Offset: 0xa8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"arena", &__init__, undefined, undefined);
}

// Namespace arena/arena
// Params 0, eflags: 0x0
// Checksum 0x780ce044, Offset: 0xf0
// Size: 0x24
function __init__() {
    callback::on_connect(&on_connect);
}

// Namespace arena/arena
// Params 0, eflags: 0x0
// Checksum 0xf4332871, Offset: 0x120
// Size: 0xee
function on_connect() {
    if (isdefined(self.pers[#"arenainit"]) && self.pers[#"arenainit"] == 1) {
        return;
    }
    draftenabled = getgametypesetting(#"pregamedraftenabled") == 1;
    voteenabled = getgametypesetting(#"pregameitemvoteenabled") == 1;
    if (!draftenabled && !voteenabled) {
        self arenabeginmatch();
    }
    self.pers[#"arenainit"] = 1;
}

// Namespace arena/arena
// Params 0, eflags: 0x0
// Checksum 0x174ed71d, Offset: 0x218
// Size: 0x182
function update_arena_challenge_seasons() {
    perseasonwins = self stats::get_stat(#"arenaperseasonstats", #"wins");
    if (perseasonwins >= getdvarint(#"arena_seasonvetchallengewins", 0)) {
        arenaslot = arenagetslot();
        currentseason = self stats::get_stat(#"arenastats", arenaslot, #"season");
        seasonvetchallengearraycount = self getdstatarraycount("arenaChallengeSeasons");
        for (i = 0; i < seasonvetchallengearraycount; i++) {
            challengeseason = self stats::get_stat(#"arenachallengeseasons", i);
            if (challengeseason == currentseason) {
                return;
            }
            if (challengeseason == 0) {
                self stats::set_stat(#"arenachallengeseasons", i, currentseason);
                break;
            }
        }
    }
}

// Namespace arena/arena
// Params 0, eflags: 0x0
// Checksum 0x4b737a1c, Offset: 0x3a8
// Size: 0x12e
function match_end() {
    for (index = 0; index < level.players.size; index++) {
        player = level.players[index];
        if (isdefined(player.pers[#"arenainit"]) && player.pers[#"arenainit"] == 1) {
            if (match::get_flag("tie")) {
                player arenaendmatch(0);
                continue;
            }
            if (match::function_356f8b9b(player)) {
                player arenaendmatch(1);
                player update_arena_challenge_seasons();
                continue;
            }
            player arenaendmatch(-1);
        }
    }
}

