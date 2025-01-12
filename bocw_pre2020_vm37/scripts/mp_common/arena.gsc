#using scripts\core_common\callbacks_shared;
#using scripts\core_common\gamestate;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;
#using scripts\mp_common\gametypes\match;

#namespace arena;

// Namespace arena/arena
// Params 0, eflags: 0x6
// Checksum 0x59e219e0, Offset: 0xb0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"arena", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace arena/arena
// Params 0, eflags: 0x5 linked
// Checksum 0x8fccc650, Offset: 0xf8
// Size: 0x8c
function private function_70a657d8() {
    callback::on_connect(&on_connect);
    callback::on_disconnect(&on_disconnect);
    if (gamemodeisarena()) {
        callback::on_game_playing(&on_game_playing);
        level.var_a962eeb6 = &function_51203700;
    }
}

// Namespace arena/arena
// Params 0, eflags: 0x1 linked
// Checksum 0x2bb43d9f, Offset: 0x190
// Size: 0x6
function function_51203700() {
    return false;
}

// Namespace arena/arena
// Params 0, eflags: 0x1 linked
// Checksum 0x4d357aa8, Offset: 0x1a0
// Size: 0xcc
function on_connect() {
    if (!gamemodeisarena() || isdefined(self.pers[#"arenainit"]) && self.pers[#"arenainit"] == 1) {
        return;
    }
    self arenabeginmatch();
    if (function_945560bf() == 0) {
        self.pers[#"hash_1b5251cc167039c8"] = self function_a200171d();
    }
    self.pers[#"arenainit"] = 1;
}

// Namespace arena/arena
// Params 0, eflags: 0x1 linked
// Checksum 0x5da01d00, Offset: 0x278
// Size: 0x2c
function on_game_playing() {
    if (gamemodeisarena()) {
        function_e938380b();
    }
}

// Namespace arena/arena
// Params 1, eflags: 0x1 linked
// Checksum 0x6c064d55, Offset: 0x2b0
// Size: 0x184
function function_b856a952(team) {
    if (gamemodeisarena() && getdvarint(#"hash_6eb6c222bc98b01", 0)) {
        penalty = function_377f07c2();
        for (index = 0; index < level.players.size; index++) {
            player = level.players[index];
            if (isdefined(player.team) && player.team == team && !isdefined(player.pers[#"hash_6dbbb195b62e0dd3"])) {
                if (isdefined(player.pers[#"arenainit"]) && player.pers[#"arenainit"] == 1) {
                    if (isdefined(player.pers[#"hash_1b5251cc167039c8"])) {
                        player function_ca53535e(penalty);
                        player.pers[#"hash_6dbbb195b62e0dd3"] = 1;
                    }
                }
            }
        }
    }
}

// Namespace arena/arena
// Params 0, eflags: 0x1 linked
// Checksum 0x48e20e7d, Offset: 0x440
// Size: 0xf4
function on_disconnect() {
    if (gamemodeisarena() && isdefined(self.pers[#"arenainit"]) && self.pers[#"arenainit"] == 1) {
        if (isdefined(self) && isdefined(self.team) && isdefined(level.playercount) && isdefined(level.playercount[self.team])) {
            if (!gamestate::is_game_over() && level.playercount[self.team] <= function_7a0dc792()) {
                function_b856a952(self.team);
            }
        }
    }
}

// Namespace arena/arena
// Params 0, eflags: 0x1 linked
// Checksum 0x848959be, Offset: 0x540
// Size: 0x1c4
function match_end() {
    if (gamemodeisarena()) {
        for (index = 0; index < level.players.size; index++) {
            player = level.players[index];
            if (isdefined(player.pers[#"arenainit"]) && player.pers[#"arenainit"] == 1) {
                matchresult = undefined;
                if (match::get_flag("tie")) {
                    matchresult = 0;
                    player arenaendmatch(0);
                } else if (match::function_a2b53e17(player)) {
                    matchresult = 1;
                    player arenaendmatch(1);
                } else {
                    matchresult = -1;
                    player arenaendmatch(-1);
                }
                if (isdefined(player.pers[#"hash_1b5251cc167039c8"])) {
                    if (isdefined(matchresult)) {
                        player function_cce105c8(#"hash_45b731f317083a1b", 1, player.pers[#"hash_1b5251cc167039c8"], 2, matchresult);
                    }
                }
            }
        }
        function_42e2cd11();
    }
}

// Namespace arena/arena
// Params 0, eflags: 0x0
// Checksum 0x600ab142, Offset: 0x710
// Size: 0x260
function update_arena_challenge_seasons() {
    if (!gamemodeisarena()) {
        return;
    }
    eventstate = "";
    eventtype = function_945560bf();
    switch (eventtype) {
    case 1:
        eventstate = #"rankedplaystats";
        break;
    case 0:
        eventstate = #"leagueplaystats";
        break;
    case 4:
        eventstate = #"hash_4986c748eb81d3c5";
        break;
    default:
        return;
    }
    perseasonwins = self stats::get_stat(#"arenaperseasonstats", eventstate, #"matchesstats", #"wins");
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

