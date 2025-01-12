#using scripts\core_common\callbacks_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\zm_common\gametypes\globallogic;
#using scripts\zm_common\gametypes\globallogic_audio;
#using scripts\zm_common\gametypes\globallogic_score;
#using scripts\zm_common\gametypes\globallogic_utils;
#using scripts\zm_common\gametypes\spawnlogic;
#using scripts\zm_common\util;

#namespace globallogic_defaults;

// Namespace globallogic_defaults/globallogic_defaults
// Params 1, eflags: 0x0
// Checksum 0xf64f638d, Offset: 0x128
// Size: 0x3a
function getwinningteamfromloser(losing_team) {
    if (level.multiteam) {
        return "tie";
    }
    return util::getotherteam(losing_team);
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 1, eflags: 0x0
// Checksum 0x5e02d0e5, Offset: 0x170
// Size: 0x2ec
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
    endreason = #"";
    if (!isdefined(team)) {
        setdvar(#"ui_text_endreason", game.strings[#"players_forfeited"]);
        endreason = game.strings[#"players_forfeited"];
        winner = level.players[0];
    } else if (isdefined(level.teams[team])) {
        endreason = game.strings[team + "_forfeited"];
        setdvar(#"ui_text_endreason", endreason);
        winner = getwinningteamfromloser(team);
    } else {
        assert(isdefined(team), "<dev string:x30>");
        assert(0, "<dev string:x4e>" + team + "<dev string:x5e>");
        winner = "tie";
    }
    level.forcedend = 1;
    /#
        if (isplayer(winner)) {
            print("<dev string:x75>" + winner getxuid() + "<dev string:x84>" + winner.name + "<dev string:x86>");
        } else {
            globallogic_utils::logteamwinstring("<dev string:x88>", winner);
        }
    #/
    thread globallogic::endgame(winner, endreason);
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 1, eflags: 0x0
// Checksum 0x6900e2ef, Offset: 0x468
// Size: 0x1bc
function default_ondeadevent(team) {
    level callback::callback(#"on_dead_event", team);
    if (isdefined(level.teams[team])) {
        eliminatedstring = game.strings[team + "_eliminated"];
        iprintln(eliminatedstring);
        setdvar(#"ui_text_endreason", eliminatedstring);
        winner = getwinningteamfromloser(team);
        globallogic_utils::logteamwinstring("team eliminated", winner);
        thread globallogic::endgame(winner, eliminatedstring);
        return;
    }
    setdvar(#"ui_text_endreason", game.strings[#"tie"]);
    globallogic_utils::logteamwinstring("tie");
    if (level.teambased) {
        thread globallogic::endgame("tie", game.strings[#"tie"]);
        return;
    }
    thread globallogic::endgame(undefined, game.strings[#"tie"]);
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 1, eflags: 0x0
// Checksum 0x12f5bb85, Offset: 0x630
// Size: 0xc
function default_onalivecountchange(team) {
    
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 1, eflags: 0x0
// Checksum 0xc04cc064, Offset: 0x648
// Size: 0x10
function default_onroundendgame(winner) {
    return winner;
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 1, eflags: 0x0
// Checksum 0xe98199e0, Offset: 0x660
// Size: 0x162
function default_ononeleftevent(team) {
    if (!level.teambased) {
        winner = globallogic_score::gethighestscoringplayer();
        /#
            if (isdefined(winner)) {
                print("<dev string:x90>" + winner.name);
            } else {
                print("<dev string:xa6>");
            }
        #/
        thread globallogic::endgame(winner, #"mp_enemies_eliminated");
        return;
    }
    for (index = 0; index < level.players.size; index++) {
        player = level.players[index];
        if (!isalive(player)) {
            continue;
        }
        if (!isdefined(player.pers[#"team"]) || player.pers[#"team"] != team) {
        }
    }
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 0, eflags: 0x0
// Checksum 0x902d4867, Offset: 0x7d0
// Size: 0x12c
function default_ontimelimit() {
    winner = undefined;
    if (level.teambased) {
        winner = globallogic::determineteamwinnerbygamestat("teamScores");
        globallogic_utils::logteamwinstring("time limit", winner);
    } else {
        winner = globallogic_score::gethighestscoringplayer();
        /#
            if (isdefined(winner)) {
                print("<dev string:xc3>" + winner.name);
            } else {
                print("<dev string:xd5>");
            }
        #/
    }
    setdvar(#"ui_text_endreason", game.strings[#"time_limit_reached"]);
    thread globallogic::endgame(winner, game.strings[#"time_limit_reached"]);
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 0, eflags: 0x0
// Checksum 0xbef4daae, Offset: 0x908
// Size: 0x148
function default_onscorelimit() {
    if (!level.endgameonscorelimit) {
        return false;
    }
    winner = undefined;
    if (level.teambased) {
        winner = globallogic::determineteamwinnerbygamestat("teamScores");
        globallogic_utils::logteamwinstring("scorelimit", winner);
    } else {
        winner = globallogic_score::gethighestscoringplayer();
        /#
            if (isdefined(winner)) {
                print("<dev string:xe5>" + winner.name);
            } else {
                print("<dev string:xf7>");
            }
        #/
    }
    setdvar(#"ui_text_endreason", game.strings[#"score_limit_reached"]);
    thread globallogic::endgame(winner, game.strings[#"score_limit_reached"]);
    return true;
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 2, eflags: 0x0
// Checksum 0x18ef8bd7, Offset: 0xa58
// Size: 0xf4
function default_onspawnspectator(origin, angles) {
    if (isdefined(origin) && isdefined(angles)) {
        self spawn(origin, angles);
        return;
    }
    spawnpointname = "mp_global_intermission";
    spawnpoints = getentarray(spawnpointname, "classname");
    assert(spawnpoints.size, "<dev string:x107>");
    spawnpoint = spawnlogic::getspawnpoint_random(spawnpoints);
    self spawn(spawnpoint.origin, spawnpoint.angles);
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 0, eflags: 0x0
// Checksum 0xaa9bcd2c, Offset: 0xb58
// Size: 0xb4
function default_onspawnintermission() {
    spawnpointname = "mp_global_intermission";
    spawnpoints = getentarray(spawnpointname, "classname");
    spawnpoint = spawnpoints[0];
    if (isdefined(spawnpoint)) {
        self spawn(spawnpoint.origin, spawnpoint.angles);
        return;
    }
    /#
        util::error("<dev string:x161>" + spawnpointname + "<dev string:x165>");
    #/
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 0, eflags: 0x0
// Checksum 0xa16a0295, Offset: 0xc18
// Size: 0x42
function default_gettimelimit() {
    return math::clamp(getgametypesetting(#"timelimit"), level.timelimitmin, level.timelimitmax);
}

