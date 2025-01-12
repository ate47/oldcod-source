#using script_7f6cd71c43c45c57;
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
// Checksum 0x8f27ecec, Offset: 0xf0
// Size: 0xba
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
// Checksum 0x7a7ac5c3, Offset: 0x1b8
// Size: 0xb8
function testshock() {
    self endon(#"death", #"disconnect");
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
// Params 0, eflags: 0x1 linked
// Checksum 0x60617a74, Offset: 0x278
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
// Params 0, eflags: 0x1 linked
// Checksum 0x1d04f809, Offset: 0x390
// Size: 0x3c
function gettimeremaining() {
    return level.timelimit * int(60 * 1000) - gettimepassed();
}

// Namespace globallogic_utils/globallogic_utils
// Params 1, eflags: 0x1 linked
// Checksum 0xf2315e8e, Offset: 0x3d8
// Size: 0x44
function registerpostroundevent(eventfunc) {
    if (!isdefined(level.postroundevents)) {
        level.postroundevents = [];
    }
    level.postroundevents[level.postroundevents.size] = eventfunc;
}

// Namespace globallogic_utils/globallogic_utils
// Params 0, eflags: 0x1 linked
// Checksum 0xd24dd46f, Offset: 0x428
// Size: 0x56
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
// Checksum 0x3ec80c46, Offset: 0x488
// Size: 0x46
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
    // Checksum 0xd101927e, Offset: 0x4d8
    // Size: 0x2a8
    function assertproperplacement() {
        numplayers = level.placement[#"all"].size;
        if (level.teambased) {
            for (i = 0; i < numplayers - 1; i++) {
                if (level.placement[#"all"][i].score < level.placement[#"all"][i + 1].score) {
                    println("<dev string:x38>");
                    for (j = 0; j < numplayers; j++) {
                        player = level.placement[#"all"][j];
                        println("<dev string:x4e>" + j + "<dev string:x54>" + player.name + "<dev string:x5a>" + player.score);
                    }
                    assertmsg("<dev string:x60>");
                    break;
                }
            }
            return;
        }
        for (i = 0; i < numplayers - 1; i++) {
            if (level.placement[#"all"][i].pointstowin < level.placement[#"all"][i + 1].pointstowin) {
                println("<dev string:x38>");
                for (j = 0; j < numplayers; j++) {
                    player = level.placement[#"all"][j];
                    println("<dev string:x4e>" + j + "<dev string:x54>" + player.name + "<dev string:x5a>" + player.pointstowin);
                }
                assertmsg("<dev string:x60>");
                break;
            }
        }
    }

#/

// Namespace globallogic_utils/globallogic_utils
// Params 1, eflags: 0x1 linked
// Checksum 0x2b209904, Offset: 0x788
// Size: 0x22
function isvalidclass(c) {
    return isdefined(c) && c != "";
}

// Namespace globallogic_utils/globallogic_utils
// Params 1, eflags: 0x0
// Checksum 0xbc208285, Offset: 0x7b8
// Size: 0x118
function playtickingsound(gametype_tick_sound) {
    self endon(#"death", #"stop_ticking");
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
// Checksum 0x455411f6, Offset: 0x8d8
// Size: 0x1e
function stoptickingsound() {
    if (isdefined(self)) {
        self notify(#"stop_ticking");
    }
}

// Namespace globallogic_utils/globallogic_utils
// Params 0, eflags: 0x1 linked
// Checksum 0x4b85546b, Offset: 0x900
// Size: 0x118
function gametimer() {
    level endon(#"game_ended");
    level.var_8a3a9ca4.roundstart = gettime();
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
// Params 0, eflags: 0x1 linked
// Checksum 0x26808193, Offset: 0xa20
// Size: 0x7c
function disableplayerroundstartdelay() {
    player = self;
    player endon(#"death", #"disconnect");
    if (getroundstartdelay()) {
        wait getroundstartdelay();
    }
    player disableroundstartdelay();
}

// Namespace globallogic_utils/globallogic_utils
// Params 0, eflags: 0x1 linked
// Checksum 0xa600af79, Offset: 0xaa8
// Size: 0x54
function getroundstartdelay() {
    waittime = level.roundstartexplosivedelay - float([[ level.gettimepassed ]]()) / 1000;
    if (waittime > 0) {
        return waittime;
    }
    return 0;
}

// Namespace globallogic_utils/globallogic_utils
// Params 0, eflags: 0x1 linked
// Checksum 0x64d830a4, Offset: 0xb08
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
// Params 0, eflags: 0x1 linked
// Checksum 0xd1a1dca6, Offset: 0xbb0
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
// Checksum 0x8568b692, Offset: 0xc20
// Size: 0x54
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
// Checksum 0xfc85409d, Offset: 0xc80
// Size: 0x50
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
// Checksum 0x7046f3f7, Offset: 0xcd8
// Size: 0x38
function resumetimerdiscardoverride(discardtime) {
    if (!level.timerstopped) {
        return;
    }
    level.timerstopped = 0;
    level.discardtime = discardtime;
}

// Namespace globallogic_utils/globallogic_utils
// Params 1, eflags: 0x1 linked
// Checksum 0x39fd4d58, Offset: 0xd18
// Size: 0x1c
function getscoreremaining(score) {
    return level.scorelimit - score;
}

// Namespace globallogic_utils/globallogic_utils
// Params 2, eflags: 0x1 linked
// Checksum 0xecdf93b3, Offset: 0xd40
// Size: 0x50
function function_fd90317f(user, var_b393387d) {
    if (level.cumulativeroundscores && isdefined(game.lastroundscore[user])) {
        return (var_b393387d - game.lastroundscore[user]);
    }
    return var_b393387d;
}

// Namespace globallogic_utils/globallogic_utils
// Params 1, eflags: 0x1 linked
// Checksum 0x3cbf0e39, Offset: 0xd98
// Size: 0x56
function getscoreperminute(var_d0266750) {
    minutespassed = gettimepassed() / int(60 * 1000) + 0.0001;
    return var_d0266750 / minutespassed;
}

// Namespace globallogic_utils/globallogic_utils
// Params 2, eflags: 0x1 linked
// Checksum 0xdb4d7ef8, Offset: 0xdf8
// Size: 0x6e
function getestimatedtimeuntilscorelimit(total_score, var_d0266750) {
    scoreperminute = self getscoreperminute(var_d0266750);
    scoreremaining = self getscoreremaining(total_score);
    if (!scoreperminute) {
        return 999999;
    }
    return scoreremaining / scoreperminute;
}

// Namespace globallogic_utils/globallogic_utils
// Params 0, eflags: 0x0
// Checksum 0xd9e9059d, Offset: 0xe70
// Size: 0x48
function rumbler() {
    self endon(#"disconnect");
    while (true) {
        wait 0.1;
        self playrumbleonentity("damage_heavy");
    }
}

// Namespace globallogic_utils/globallogic_utils
// Params 2, eflags: 0x1 linked
// Checksum 0x1ab060f7, Offset: 0xec0
// Size: 0x24
function waitfortimeornotify(time, notifyname) {
    self endon(notifyname);
    wait time;
}

// Namespace globallogic_utils/globallogic_utils
// Params 2, eflags: 0x0
// Checksum 0x90456c81, Offset: 0xef0
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
// Params 1, eflags: 0x0
// Checksum 0x240365d8, Offset: 0xf58
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
    // Checksum 0x42163702, Offset: 0x10c8
    // Size: 0x5a
    function debugline(start, end) {
        for (i = 0; i < 50; i++) {
            line(start, end);
            waitframe(1);
        }
    }

#/

// Namespace globallogic_utils/globallogic_utils
// Params 2, eflags: 0x1 linked
// Checksum 0x529482db, Offset: 0x1130
// Size: 0x24
function function_4aa8d809(index, string) {
    level.var_336c35f1[index] = string;
}

/#

    // Namespace globallogic_utils/globallogic_utils
    // Params 1, eflags: 0x1 linked
    // Checksum 0xa28294d9, Offset: 0x1160
    // Size: 0x23c
    function function_8d61a6c2(var_c1e98979) {
        assert(isdefined(var_c1e98979));
        assert(isdefined(level.var_336c35f1[var_c1e98979]));
        log_string = level.var_336c35f1[var_c1e98979];
        winner = round::get_winner();
        if (isplayer(winner)) {
            print("<dev string:x8b>" + winner getxuid() + "<dev string:x9d>" + winner.name + "<dev string:xa2>");
        }
        if (isdefined(winner)) {
            if (isplayer(winner)) {
                log_string = log_string + "<dev string:xa7>" + winner getxuid() + "<dev string:x9d>" + winner.name + "<dev string:xa2>";
            } else {
                log_string = log_string + "<dev string:xa7>" + winner;
            }
        }
        foreach (team, str_team in level.teams) {
            log_string = log_string + "<dev string:xb2>" + str_team + "<dev string:x5a>" + game.stat[#"teamscores"][team];
        }
        print(log_string);
    }

#/

// Namespace globallogic_utils/globallogic_utils
// Params 1, eflags: 0x0
// Checksum 0x3cae50b8, Offset: 0x13a8
// Size: 0x44
function add_map_error(msg) {
    if (!isdefined(level.maperrors)) {
        level.maperrors = [];
    }
    level.maperrors[level.maperrors.size] = msg;
}

// Namespace globallogic_utils/globallogic_utils
// Params 0, eflags: 0x0
// Checksum 0x37bc35bd, Offset: 0x13f8
// Size: 0xdc
function print_map_errors() {
    if (isdefined(level.maperrors) && level.maperrors.size > 0) {
        /#
            println("<dev string:xb8>");
            for (i = 0; i < level.maperrors.size; i++) {
                println("<dev string:xe2>" + level.maperrors[i]);
            }
            println("<dev string:xed>");
            util::error("<dev string:x117>");
        #/
        callback::abort_level();
        return true;
    }
    return false;
}

// Namespace globallogic_utils/globallogic_utils
// Params 0, eflags: 0x1 linked
// Checksum 0xc56f1ff8, Offset: 0x14e0
// Size: 0x22
function function_308e3379() {
    return strendswith(level.gametype, "_bb");
}

