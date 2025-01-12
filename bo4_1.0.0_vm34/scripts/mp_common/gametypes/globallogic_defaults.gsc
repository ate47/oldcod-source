#using scripts\core_common\math_shared;
#using scripts\core_common\rank_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_audio;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\match;
#using scripts\mp_common\gametypes\round;
#using scripts\mp_common\util;

#namespace globallogic_defaults;

// Namespace globallogic_defaults/globallogic_defaults
// Params 1, eflags: 0x0
// Checksum 0xc7d5ed9, Offset: 0x108
// Size: 0x32
function getwinningteamfromloser(losing_team) {
    if (level.multiteam) {
        return undefined;
    }
    return util::getotherteam(losing_team);
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 1, eflags: 0x0
// Checksum 0x28b139b8, Offset: 0x148
// Size: 0x1fc
function default_onforfeit(team) {
    level.gameforfeited = 1;
    level notify(#"forfeit in progress");
    level endon(#"forfeit in progress");
    level endon(#"abort forfeit");
    forfeit_delay = 20;
    announcement(game.strings[#"opponent_forfeiting_in"], forfeit_delay, 0);
    wait 10;
    announcement(game.strings[#"opponent_forfeiting_in"], 10, 0);
    wait 10;
    if (level.multiteam) {
        winner = team;
    } else if (!isdefined(team)) {
        winner = level.players[0];
    } else if (isdefined(level.teams[team])) {
        winner = getwinningteamfromloser(team);
    } else {
        assert(isdefined(team), "<dev string:x30>");
        assert(0, "<dev string:x4e>" + team + "<dev string:x5e>");
        winner = undefined;
    }
    level.forcedend = 1;
    round::set_flag("force_end");
    round::set_winner(winner);
    thread globallogic::end_round(7);
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 1, eflags: 0x0
// Checksum 0x46a10380, Offset: 0x350
// Size: 0x9c
function default_ondeadevent(team) {
    if (isdefined(level.teams[team])) {
        round::set_winner(getwinningteamfromloser(team));
        thread globallogic::end_round(6);
        return;
    }
    round::set_flag("tie");
    thread globallogic::end_round(6);
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 1, eflags: 0x0
// Checksum 0xe62bc3de, Offset: 0x3f8
// Size: 0x84
function function_45c10f52(team) {
    if (isdefined(level.teams[team])) {
        round::function_622b7e5e(team);
        thread globallogic::end_round(6);
        return;
    }
    round::set_flag("tie");
    thread globallogic::end_round(6);
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 1, eflags: 0x0
// Checksum 0xaed4723, Offset: 0x488
// Size: 0xc
function default_onalivecountchange(team) {
    
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 1, eflags: 0x0
// Checksum 0x3c086963, Offset: 0x4a0
// Size: 0x54
function onendgame(var_c3d87d03) {
    if (level.scoreroundwinbased) {
        globallogic_score::updateteamscorebyroundswon();
    }
    match::function_622b7e5e(match::function_81e31796());
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 1, eflags: 0x0
// Checksum 0x84d2b9d7, Offset: 0x500
// Size: 0x140
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
// Params 0, eflags: 0x0
// Checksum 0x62ed1526, Offset: 0x648
// Size: 0x2c
function default_ontimelimit() {
    round::function_76a0135d();
    thread globallogic::end_round(2);
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 0, eflags: 0x0
// Checksum 0x73c1c372, Offset: 0x680
// Size: 0x48
function default_onscorelimit() {
    if (!level.endgameonscorelimit) {
        return false;
    }
    round::function_76a0135d();
    thread globallogic::end_round(3);
    return true;
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 0, eflags: 0x0
// Checksum 0x90b7f575, Offset: 0x6d0
// Size: 0x40
function default_onroundscorelimit() {
    round::function_76a0135d();
    param1 = 4;
    thread globallogic::end_round(param1);
    return true;
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 2, eflags: 0x0
// Checksum 0xf067ac, Offset: 0x718
// Size: 0xdc
function default_onspawnspectator(origin, angles) {
    if (isdefined(origin) && isdefined(angles)) {
        self spawn(origin, angles);
        return;
    }
    spawnpoints = spawning::get_spawnpoint_array("mp_global_intermission");
    assert(spawnpoints.size, "<dev string:x75>");
    spawnpoint = spawning::get_spawnpoint_random(spawnpoints);
    self spawn(spawnpoint.origin, spawnpoint.angles);
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 1, eflags: 0x0
// Checksum 0x1896dd1, Offset: 0x800
// Size: 0x94
function default_onspawnintermission(endgame) {
    if (isdefined(endgame) && endgame) {
        return;
    }
    spawnpoint = spawning::get_random_intermission_point();
    if (isdefined(spawnpoint)) {
        self spawn(spawnpoint.origin, spawnpoint.angles);
        return;
    }
    /#
        util::error("<dev string:xcf>");
    #/
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 0, eflags: 0x0
// Checksum 0x432c7bbc, Offset: 0x8a0
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
// Params 4, eflags: 0x0
// Checksum 0x39ba3d01, Offset: 0x968
// Size: 0x6c
function default_getteamkillpenalty(einflictor, attacker, smeansofdeath, weapon) {
    teamkill_penalty = 1;
    if (killstreaks::is_killstreak_weapon(weapon)) {
        teamkill_penalty *= killstreaks::get_killstreak_team_kill_penalty_scale(weapon);
    }
    return teamkill_penalty;
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 4, eflags: 0x0
// Checksum 0xe9d2d684, Offset: 0x9e0
// Size: 0x42
function default_getteamkillscore(einflictor, attacker, smeansofdeath, weapon) {
    return attacker rank::getscoreinfovalue("team_kill");
}

