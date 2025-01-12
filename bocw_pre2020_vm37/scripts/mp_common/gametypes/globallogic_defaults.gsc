#using script_1cc417743d7c262d;
#using script_44b0b8420eabacad;
#using script_7dc3a36c222eaf22;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\gamestate;
#using scripts\core_common\math_shared;
#using scripts\core_common\rank_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\match;
#using scripts\mp_common\gametypes\round;
#using scripts\mp_common\util;

#namespace globallogic_defaults;

// Namespace globallogic_defaults/globallogic_defaults
// Params 1, eflags: 0x1 linked
// Checksum 0x1a23b97c, Offset: 0x128
// Size: 0x32
function getwinningteamfromloser(losing_team) {
    if (level.multiteam) {
        return undefined;
    }
    return util::getotherteam(losing_team);
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 1, eflags: 0x1 linked
// Checksum 0x43ade6bd, Offset: 0x168
// Size: 0x174
function default_onforfeit(params) {
    level.gameforfeited = 1;
    level notify(#"forfeit in progress");
    level endon(#"forfeit in progress", #"abort forfeit");
    forfeit_delay = 20;
    announcement(game.strings[#"opponent_forfeiting_in"], forfeit_delay, 0);
    wait 10;
    announcement(game.strings[#"opponent_forfeiting_in"], 10, 0);
    wait 10;
    if (!isdefined(params)) {
        round::set_winner(level.players[0]);
    } else if (params.var_6eb69269.size) {
        round::set_winner(params.var_6eb69269[0]);
    }
    level.forcedend = 1;
    round::set_flag("force_end");
    thread globallogic::end_round(7);
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 1, eflags: 0x0
// Checksum 0x6f9f3348, Offset: 0x2e8
// Size: 0xdc
function default_ondeadevent(team) {
    var_2e0d5506 = round::get_winner();
    if (isdefined(var_2e0d5506) && var_2e0d5506 != #"none") {
        return;
    }
    if (isdefined(level.teams[team])) {
        round::set_winner(getwinningteamfromloser(team));
        thread globallogic::end_round(6);
        return;
    }
    round::set_flag("tie");
    thread globallogic::end_round(6);
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 1, eflags: 0x1 linked
// Checksum 0x219db865, Offset: 0x3d0
// Size: 0xdc
function function_dcf41142(params) {
    /#
        if (getdvarint(#"hash_3b4d2cf24a06392e", 0)) {
            return;
        }
    #/
    if (gamestate::is_game_over()) {
        return;
    }
    if (params.teams_alive.size && isdefined(level.teams[params.teams_alive[0]])) {
        round::function_af2e264f(params.teams_alive[0]);
    } else {
        round::set_flag("tie");
    }
    thread globallogic::end_round(6);
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 0, eflags: 0x0
// Checksum 0xea49192f, Offset: 0x4b8
// Size: 0x34
function function_daa7e9d5() {
    level callback::remove_callback(#"on_last_alive", &function_dcf41142);
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 1, eflags: 0x1 linked
// Checksum 0xc180958f, Offset: 0x4f8
// Size: 0xc
function default_onalivecountchange(*team) {
    
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 1, eflags: 0x1 linked
// Checksum 0x9dcd81d0, Offset: 0x510
// Size: 0x54
function onendgame(*var_c1e98979) {
    if (level.scoreroundwinbased) {
        globallogic_score::function_9779ac61();
    }
    match::function_af2e264f(match::function_6d0354e3());
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 1, eflags: 0x1 linked
// Checksum 0xede1416f, Offset: 0x570
// Size: 0x150
function default_ononeleftevent(team) {
    if (!level.teambased) {
        round::set_winner(globallogic_score::gethighestscoringplayer());
        thread globallogic::end_round(6);
        return;
    }
    foreach (player in level.players) {
        if (!isalive(player)) {
            continue;
        }
        if (!isdefined(player.pers[#"team"]) || player.pers[#"team"] != team) {
            continue;
        }
        player globallogic_audio::leader_dialog_on_player("sudden_death");
    }
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 0, eflags: 0x1 linked
// Checksum 0x2b47e0e4, Offset: 0x6c8
// Size: 0x2c
function default_ontimelimit() {
    round::function_870759fb();
    thread globallogic::end_round(2);
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 0, eflags: 0x1 linked
// Checksum 0x5fa5bdd9, Offset: 0x700
// Size: 0x48
function default_onscorelimit() {
    if (!level.endgameonscorelimit) {
        return false;
    }
    round::function_870759fb();
    thread globallogic::end_round(3);
    return true;
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 0, eflags: 0x1 linked
// Checksum 0x89cd0615, Offset: 0x750
// Size: 0x40
function default_onroundscorelimit() {
    round::function_870759fb();
    param1 = 4;
    thread globallogic::end_round(param1);
    return true;
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 2, eflags: 0x5 linked
// Checksum 0xc6211d01, Offset: 0x798
// Size: 0x74
function private function_85d45b4b(origin, angles) {
    self spawn(origin, angles);
    if (self.team != #"spectator" && level.var_1ba484ad === 2) {
        self namespace_8a203916::function_86df9236();
    }
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 2, eflags: 0x1 linked
// Checksum 0xb07a2316, Offset: 0x818
// Size: 0xd4
function default_onspawnspectator(origin, angles) {
    if (isdefined(origin) && isdefined(angles)) {
        self function_85d45b4b(origin, angles);
        return;
    }
    spawnpoints = spawning::get_spawnpoint_array("mp_global_intermission");
    assert(spawnpoints.size, "<dev string:x38>");
    spawnpoint = spawning::get_spawnpoint_random(spawnpoints);
    self function_85d45b4b(spawnpoint.origin, spawnpoint.angles);
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 1, eflags: 0x1 linked
// Checksum 0x6e001ff5, Offset: 0x8f8
// Size: 0x94
function default_onspawnintermission(endgame) {
    if (is_true(endgame)) {
        return;
    }
    spawnpoint = spawning::get_random_intermission_point();
    if (isdefined(spawnpoint)) {
        self spawn(spawnpoint.origin, spawnpoint.angles);
        return;
    }
    /#
        util::error("<dev string:x95>");
    #/
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 0, eflags: 0x1 linked
// Checksum 0xd0c020d2, Offset: 0x998
// Size: 0xba
function default_gettimelimit() {
    /#
        if (getdvarfloat(#"timelimit_override", -1) != -1) {
            return math::clamp(getdvarfloat(#"timelimit_override", -1), level.timelimitmin, level.timelimitmax);
        }
    #/
    return math::clamp(getgametypesetting(#"timelimit"), level.timelimitmin, level.timelimitmax);
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 4, eflags: 0x1 linked
// Checksum 0xb309d667, Offset: 0xa60
// Size: 0xb0
function default_getteamkillpenalty(einflictor, attacker, smeansofdeath, weapon) {
    teamkill_penalty = 1;
    if (killstreaks::is_killstreak_weapon(weapon)) {
        teamkill_penalty *= killstreaks::get_killstreak_team_kill_penalty_scale(weapon);
    }
    if (isdefined(level.var_17ae20ae) && [[ level.var_17ae20ae ]](einflictor, attacker, smeansofdeath, weapon)) {
        teamkill_penalty *= level.teamkillpenaltymultiplier;
    }
    return teamkill_penalty;
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 4, eflags: 0x1 linked
// Checksum 0xf644d94b, Offset: 0xb18
// Size: 0xc2
function default_getteamkillscore(einflictor, attacker, smeansofdeath, weapon) {
    teamkill_score = attacker rank::getscoreinfovalue("team_kill");
    if (isdefined(level.var_17ae20ae) && [[ level.var_17ae20ae ]](einflictor, attacker, smeansofdeath, weapon)) {
        teamkill_score = attacker rank::getscoreinfovalue("kill");
        teamkill_score *= level.teamkillscoremultiplier;
    }
    return int(teamkill_score);
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 1, eflags: 0x0
// Checksum 0x725d05ab, Offset: 0xbe8
// Size: 0x102
function get_alive_players(players) {
    alive_players = [];
    foreach (player in players) {
        if (player == self) {
            continue;
        }
        if (!isalive(player)) {
            continue;
        }
        if (!isdefined(alive_players)) {
            alive_players = [];
        } else if (!isarray(alive_players)) {
            alive_players = array(alive_players);
        }
        alive_players[alive_players.size] = player;
    }
    return alive_players;
}

