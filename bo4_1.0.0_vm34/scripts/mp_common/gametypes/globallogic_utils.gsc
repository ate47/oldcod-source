#using scripts\core_common\callbacks_shared;
#using scripts\core_common\hostmigration_shared;
#using scripts\core_common\hud_message_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\hostmigration;
#using scripts\mp_common\gametypes\hud_message;
#using scripts\mp_common\gametypes\round;

#namespace globallogic_utils;

// Namespace globallogic_utils/globallogic_utils
// Params 2, eflags: 0x0
// Checksum 0xfb6376ea, Offset: 0xf8
// Size: 0xca
function is_winner(outcome, team_or_player) {
    if (isplayer(team_or_player)) {
        if (outcome.players.size && outcome.players[0] == team_or_player) {
            return true;
        }
        if (isdefined(outcome.team) && outcome.team == team_or_player.team) {
            return true;
        }
    } else if (isdefined(outcome.team) && outcome.team == team_or_player) {
        return true;
    }
    return false;
}

// Namespace globallogic_utils/globallogic_utils
// Params 0, eflags: 0x0
// Checksum 0x9e94c4dc, Offset: 0x1d0
// Size: 0xba
function testshock() {
    self endon(#"death");
    self endon(#"disconnect");
    for (;;) {
        wait 3;
        numshots = randomint(6);
        for (i = 0; i < numshots; i++) {
            iprintlnbold(numshots);
            self shellshock(#"frag_grenade_mp", 0.2);
            wait 0.1;
        }
    }
}

// Namespace globallogic_utils/globallogic_utils
// Params 0, eflags: 0x0
// Checksum 0x27e01602, Offset: 0x298
// Size: 0xd0
function testhps() {
    self endon(#"death");
    self endon(#"disconnect");
    hps = [];
    hps[hps.size] = "radar";
    hps[hps.size] = "artillery";
    hps[hps.size] = "dogs";
    for (;;) {
        hp = "radar";
        if (self thread killstreaks::give(hp)) {
            self playlocalsound(level.killstreaks[hp].informdialog);
        }
        wait 20;
    }
}

// Namespace globallogic_utils/globallogic_utils
// Params 0, eflags: 0x0
// Checksum 0x7c910dcf, Offset: 0x370
// Size: 0x10e
function timeuntilroundend() {
    if (level.gameended) {
        timepassed = float(gettime() - level.gameendtime) / 1000;
        timeremaining = level.roundenddelay[3] - timepassed;
        if (timeremaining < 0) {
            return 0;
        }
        return timeremaining;
    }
    if (level.timelimit <= 0) {
        return undefined;
    }
    if (!isdefined(level.starttime)) {
        return undefined;
    }
    timepassed = float(gettimepassed() - level.starttime) / 1000;
    timeremaining = level.timelimit * 60 - timepassed;
    return timeremaining + level.roundenddelay[3];
}

// Namespace globallogic_utils/globallogic_utils
// Params 0, eflags: 0x0
// Checksum 0x32a59885, Offset: 0x488
// Size: 0x3c
function gettimeremaining() {
    return level.timelimit * int(60 * 1000) - gettimepassed();
}

// Namespace globallogic_utils/globallogic_utils
// Params 1, eflags: 0x0
// Checksum 0x3f0d6dc0, Offset: 0x4d0
// Size: 0x46
function registerpostroundevent(eventfunc) {
    if (!isdefined(level.postroundevents)) {
        level.postroundevents = [];
    }
    level.postroundevents[level.postroundevents.size] = eventfunc;
}

// Namespace globallogic_utils/globallogic_utils
// Params 0, eflags: 0x0
// Checksum 0xb51a1bd2, Offset: 0x520
// Size: 0x58
function executepostroundevents() {
    if (!isdefined(level.postroundevents)) {
        return;
    }
    for (i = 0; i < level.postroundevents.size; i++) {
        [[ level.postroundevents[i] ]]();
    }
}

// Namespace globallogic_utils/globallogic_utils
// Params 3, eflags: 0x0
// Checksum 0xd4ed7fb0, Offset: 0x580
// Size: 0x4e
function getvalueinrange(value, minvalue, maxvalue) {
    if (value > maxvalue) {
        return maxvalue;
    }
    if (value < minvalue) {
        return minvalue;
    }
    return value;
}

/#

    // Namespace globallogic_utils/globallogic_utils
    // Params 0, eflags: 0x0
    // Checksum 0x5381a90b, Offset: 0x5d8
    // Size: 0x2ca
    function assertproperplacement() {
        numplayers = level.placement[#"all"].size;
        if (level.teambased) {
            for (i = 0; i < numplayers - 1; i++) {
                if (level.placement[#"all"][i].score < level.placement[#"all"][i + 1].score) {
                    println("<dev string:x30>");
                    for (j = 0; j < numplayers; j++) {
                        player = level.placement[#"all"][j];
                        println("<dev string:x43>" + j + "<dev string:x46>" + player.name + "<dev string:x49>" + player.score);
                    }
                    assertmsg("<dev string:x4c>");
                    break;
                }
            }
            return;
        }
        for (i = 0; i < numplayers - 1; i++) {
            if (level.placement[#"all"][i].pointstowin < level.placement[#"all"][i + 1].pointstowin) {
                println("<dev string:x30>");
                for (j = 0; j < numplayers; j++) {
                    player = level.placement[#"all"][j];
                    println("<dev string:x43>" + j + "<dev string:x46>" + player.name + "<dev string:x49>" + player.pointstowin);
                }
                assertmsg("<dev string:x4c>");
                break;
            }
        }
    }

#/

// Namespace globallogic_utils/globallogic_utils
// Params 1, eflags: 0x0
// Checksum 0x4331842c, Offset: 0x8b0
// Size: 0x22
function isvalidclass(c) {
    return isdefined(c) && c != "";
}

// Namespace globallogic_utils/globallogic_utils
// Params 1, eflags: 0x0
// Checksum 0xc3ecc658, Offset: 0x8e0
// Size: 0x118
function playtickingsound(gametype_tick_sound) {
    self endon(#"death");
    self endon(#"stop_ticking");
    level endon(#"game_ended");
    time = level.bombtimer;
    while (true) {
        self playsound(gametype_tick_sound);
        if (time > 10) {
            time -= 1;
            wait 1;
        } else if (time > 4) {
            time -= 0.5;
            wait 0.5;
        } else if (time > 1) {
            time -= 0.4;
            wait 0.4;
        } else {
            time -= 0.3;
            wait 0.3;
        }
        hostmigration::waittillhostmigrationdone();
    }
}

// Namespace globallogic_utils/globallogic_utils
// Params 0, eflags: 0x0
// Checksum 0x5123b612, Offset: 0xa00
// Size: 0x1e
function stoptickingsound() {
    if (isdefined(self)) {
        self notify(#"stop_ticking");
    }
}

// Namespace globallogic_utils/globallogic_utils
// Params 0, eflags: 0x0
// Checksum 0x9f77d8ab, Offset: 0xa28
// Size: 0x10c
function gametimer() {
    level endon(#"game_ended");
    level.var_a033439c.roundstart = gettime();
    level.starttime = gettime();
    level.discardtime = 0;
    if (isdefined(game.roundmillisecondsalreadypassed)) {
        level.starttime -= game.roundmillisecondsalreadypassed;
        game.roundmillisecondsalreadypassed = undefined;
    }
    prevtime = gettime() - 1000;
    while (game.state == "playing") {
        if (!level.timerstopped) {
            game.timepassed += gettime() - prevtime;
        }
        if (!level.playabletimerstopped) {
            game.playabletimepassed += gettime() - prevtime;
        }
        prevtime = gettime();
        wait 1;
    }
}

// Namespace globallogic_utils/globallogic_utils
// Params 0, eflags: 0x0
// Checksum 0x3e4ff0df, Offset: 0xb40
// Size: 0x84
function disableplayerroundstartdelay() {
    player = self;
    player endon(#"death");
    player endon(#"disconnect");
    if (getroundstartdelay()) {
        wait getroundstartdelay();
    }
    player disableroundstartdelay();
}

// Namespace globallogic_utils/globallogic_utils
// Params 0, eflags: 0x0
// Checksum 0x2f982098, Offset: 0xbd0
// Size: 0x54
function getroundstartdelay() {
    waittime = level.roundstartexplosivedelay - float([[ level.gettimepassed ]]()) / 1000;
    if (waittime > 0) {
        return waittime;
    }
    return 0;
}

// Namespace globallogic_utils/globallogic_utils
// Params 0, eflags: 0x0
// Checksum 0x263361c5, Offset: 0xc30
// Size: 0x9c
function applyroundstartdelay() {
    self endon(#"disconnect", #"joined_spectators", #"death");
    if (game.state == "pregame") {
        level waittill(#"game_playing");
    } else {
        waitframe(1);
    }
    self enableroundstartdelay();
    self thread disableplayerroundstartdelay();
}

// Namespace globallogic_utils/globallogic_utils
// Params 0, eflags: 0x0
// Checksum 0x33e09a17, Offset: 0xcd8
// Size: 0x66
function gettimepassed() {
    if (!isdefined(level.starttime)) {
        return 0;
    }
    if (level.timerstopped) {
        return (level.timerpausetime - level.starttime - level.discardtime);
    }
    return gettime() - level.starttime - level.discardtime;
}

// Namespace globallogic_utils/globallogic_utils
// Params 1, eflags: 0x0
// Checksum 0xb1d7cae9, Offset: 0xd48
// Size: 0x52
function pausetimer(pauseplayabletimer = 0) {
    level.playabletimerstopped = pauseplayabletimer;
    if (level.timerstopped) {
        return;
    }
    level.timerstopped = 1;
    level.timerpausetime = gettime();
}

// Namespace globallogic_utils/globallogic_utils
// Params 0, eflags: 0x0
// Checksum 0x244d3896, Offset: 0xda8
// Size: 0x52
function resumetimer() {
    if (!level.timerstopped) {
        return;
    }
    level.timerstopped = 0;
    level.playabletimerstopped = 0;
    level.discardtime += gettime() - level.timerpausetime;
}

// Namespace globallogic_utils/globallogic_utils
// Params 1, eflags: 0x0
// Checksum 0xb568ec7c, Offset: 0xe08
// Size: 0x3a
function resumetimerdiscardoverride(discardtime) {
    if (!level.timerstopped) {
        return;
    }
    level.timerstopped = 0;
    level.discardtime = discardtime;
}

// Namespace globallogic_utils/globallogic_utils
// Params 1, eflags: 0x0
// Checksum 0xb834b8c8, Offset: 0xe50
// Size: 0x9e
function getscoreremaining(team) {
    assert(isplayer(self) || isdefined(team));
    scorelimit = level.scorelimit;
    if (isplayer(self)) {
        return (scorelimit - globallogic_score::_getplayerscore(self));
    }
    return scorelimit - getteamscore(team);
}

// Namespace globallogic_utils/globallogic_utils
// Params 1, eflags: 0x0
// Checksum 0x58b55911, Offset: 0xef8
// Size: 0x6a
function getteamscoreforround(team) {
    if (level.cumulativeroundscores && isdefined(game.lastroundscore[team])) {
        return (getteamscore(team) - game.lastroundscore[team]);
    }
    return getteamscore(team);
}

// Namespace globallogic_utils/globallogic_utils
// Params 1, eflags: 0x0
// Checksum 0x1dd4c54b, Offset: 0xf70
// Size: 0xd2
function getscoreperminute(team) {
    assert(isplayer(self) || isdefined(team));
    minutespassed = gettimepassed() / int(60 * 1000) + 0.0001;
    if (isplayer(self)) {
        return (globallogic_score::_getplayerscore(self) / minutespassed);
    }
    return getteamscoreforround(team) / minutespassed;
}

// Namespace globallogic_utils/globallogic_utils
// Params 1, eflags: 0x0
// Checksum 0x528352b5, Offset: 0x1050
// Size: 0x9a
function getestimatedtimeuntilscorelimit(team) {
    assert(isplayer(self) || isdefined(team));
    scoreperminute = self getscoreperminute(team);
    scoreremaining = self getscoreremaining(team);
    if (!scoreperminute) {
        return 999999;
    }
    return scoreremaining / scoreperminute;
}

// Namespace globallogic_utils/globallogic_utils
// Params 0, eflags: 0x0
// Checksum 0x2ec1e62d, Offset: 0x10f8
// Size: 0x48
function rumbler() {
    self endon(#"disconnect");
    while (true) {
        wait 0.1;
        self playrumbleonentity("damage_heavy");
    }
}

// Namespace globallogic_utils/globallogic_utils
// Params 2, eflags: 0x0
// Checksum 0x4569550a, Offset: 0x1148
// Size: 0x24
function waitfortimeornotify(time, notifyname) {
    self endon(notifyname);
    wait time;
}

// Namespace globallogic_utils/globallogic_utils
// Params 2, eflags: 0x0
// Checksum 0x4a796368, Offset: 0x1178
// Size: 0x60
function waitfortimeornotifynoartillery(time, notifyname) {
    self endon(notifyname);
    wait time;
    while (isdefined(level.artilleryinprogress)) {
        assert(level.artilleryinprogress);
        wait 0.25;
    }
}

// Namespace globallogic_utils/globallogic_utils
// Params 4, eflags: 0x0
// Checksum 0x9525bae7, Offset: 0x11e0
// Size: 0xf8
function isheadshot(weapon, shitloc, smeansofdeath, einflictor) {
    if (shitloc != "head" && shitloc != "helmet") {
        return false;
    }
    switch (smeansofdeath) {
    case #"mod_melee_assassinate":
    case #"mod_melee":
        return false;
    case #"mod_impact":
        if (weapon != level.weaponballisticknife) {
            return false;
        }
        break;
    }
    if (killstreaks::is_killstreak_weapon(weapon)) {
        if (!isdefined(einflictor) || !isdefined(einflictor.controlled) || einflictor.controlled == 0) {
            return false;
        }
    }
    return true;
}

// Namespace globallogic_utils/globallogic_utils
// Params 1, eflags: 0x0
// Checksum 0xf09cbc2b, Offset: 0x12e0
// Size: 0x166
function gethitlocheight(shitloc) {
    switch (shitloc) {
    case #"head":
    case #"helmet":
    case #"neck":
        return 60;
    case #"left_arm_lower":
    case #"left_arm_upper":
    case #"torso_upper":
    case #"right_arm_lower":
    case #"left_hand":
    case #"right_arm_upper":
    case #"gun":
    case #"right_hand":
        return 48;
    case #"torso_lower":
        return 40;
    case #"right_leg_upper":
    case #"left_leg_upper":
        return 32;
    case #"left_leg_lower":
    case #"right_leg_lower":
        return 10;
    case #"left_foot":
    case #"right_foot":
        return 5;
    }
    return 48;
}

/#

    // Namespace globallogic_utils/globallogic_utils
    // Params 2, eflags: 0x0
    // Checksum 0x940e8045, Offset: 0x1450
    // Size: 0x5c
    function debugline(start, end) {
        for (i = 0; i < 50; i++) {
            line(start, end);
            waitframe(1);
        }
    }

#/

// Namespace globallogic_utils/globallogic_utils
// Params 2, eflags: 0x0
// Checksum 0xb9b6ea1d, Offset: 0x14b8
// Size: 0x56
function isexcluded(entity, entitylist) {
    for (index = 0; index < entitylist.size; index++) {
        if (entity == entitylist[index]) {
            return true;
        }
    }
    return false;
}

// Namespace globallogic_utils/globallogic_utils
// Params 2, eflags: 0x0
// Checksum 0xfd6dbb47, Offset: 0x1518
// Size: 0x2a
function function_3e5486f6(index, string) {
    level.var_c356c6bc[index] = string;
}

/#

    // Namespace globallogic_utils/globallogic_utils
    // Params 1, eflags: 0x0
    // Checksum 0xfd418aa5, Offset: 0x1550
    // Size: 0x22c
    function function_f44aa11d(var_c3d87d03) {
        assert(isdefined(var_c3d87d03));
        assert(isdefined(level.var_c356c6bc[var_c3d87d03]));
        log_string = level.var_c356c6bc[var_c3d87d03];
        winner = round::get_winner();
        if (isplayer(winner)) {
            print("<dev string:x74>" + winner getxuid() + "<dev string:x83>" + winner.name + "<dev string:x85>");
        }
        if (isdefined(winner)) {
            if (isplayer(winner)) {
                log_string = log_string + "<dev string:x87>" + winner getxuid() + "<dev string:x83>" + winner.name + "<dev string:x85>";
            } else {
                log_string = log_string + "<dev string:x87>" + winner;
            }
        }
        foreach (team, str_team in level.teams) {
            log_string = log_string + "<dev string:x8f>" + str_team + "<dev string:x49>" + game.stat[#"teamscores"][team];
        }
        print(log_string);
    }

#/

// Namespace globallogic_utils/globallogic_utils
// Params 1, eflags: 0x0
// Checksum 0x6783e248, Offset: 0x1788
// Size: 0x46
function add_map_error(msg) {
    if (!isdefined(level.maperrors)) {
        level.maperrors = [];
    }
    level.maperrors[level.maperrors.size] = msg;
}

// Namespace globallogic_utils/globallogic_utils
// Params 0, eflags: 0x0
// Checksum 0xdfd62403, Offset: 0x17d8
// Size: 0xdc
function print_map_errors() {
    if (isdefined(level.maperrors) && level.maperrors.size > 0) {
        /#
            println("<dev string:x92>");
            for (i = 0; i < level.maperrors.size; i++) {
                println("<dev string:xb9>" + level.maperrors[i]);
            }
            println("<dev string:xc1>");
            util::error("<dev string:xe8>");
        #/
        callback::abort_level();
        return true;
    }
    return false;
}

