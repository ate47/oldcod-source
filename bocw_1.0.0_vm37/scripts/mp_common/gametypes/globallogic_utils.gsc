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
// Checksum 0x74f6e705, Offset: 0xd8
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
// Checksum 0x5a230fc, Offset: 0x1a0
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
// Params 0, eflags: 0x0
// Checksum 0x1d82bcc0, Offset: 0x260
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
// Checksum 0xb43673c6, Offset: 0x378
// Size: 0x3c
function gettimeremaining() {
    return level.timelimit * int(60 * 1000) - gettimepassed();
}

// Namespace globallogic_utils/globallogic_utils
// Params 1, eflags: 0x0
// Checksum 0x54feae18, Offset: 0x3c0
// Size: 0x44
function registerpostroundevent(eventfunc) {
    if (!isdefined(level.postroundevents)) {
        level.postroundevents = [];
    }
    level.postroundevents[level.postroundevents.size] = eventfunc;
}

// Namespace globallogic_utils/globallogic_utils
// Params 0, eflags: 0x0
// Checksum 0x3d53fd68, Offset: 0x410
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
// Checksum 0xd7b6380d, Offset: 0x470
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
    // Checksum 0x8e18d93e, Offset: 0x4c0
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
// Params 1, eflags: 0x0
// Checksum 0x5f7aecdf, Offset: 0x770
// Size: 0x22
function isvalidclass(c) {
    return isdefined(c) && c != "";
}

// Namespace globallogic_utils/globallogic_utils
// Params 1, eflags: 0x0
// Checksum 0xafd94b65, Offset: 0x7a0
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
// Checksum 0xcfdb9b9f, Offset: 0x8c0
// Size: 0x1e
function stoptickingsound() {
    if (isdefined(self)) {
        self notify(#"stop_ticking");
    }
}

// Namespace globallogic_utils/globallogic_utils
// Params 0, eflags: 0x0
// Checksum 0x80d86b7b, Offset: 0x8e8
// Size: 0x11c
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
    while (game.state == #"playing") {
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
// Checksum 0x48e7af5c, Offset: 0xa10
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
// Params 0, eflags: 0x0
// Checksum 0xa2472438, Offset: 0xa98
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
// Checksum 0x474ac7d7, Offset: 0xaf8
// Size: 0xa4
function applyroundstartdelay() {
    self endon(#"disconnect", #"joined_spectators", #"death");
    if (game.state == #"pregame") {
        level waittill(#"game_playing");
    } else {
        waitframe(1);
    }
    self enableroundstartdelay();
    self thread disableplayerroundstartdelay();
}

// Namespace globallogic_utils/globallogic_utils
// Params 0, eflags: 0x0
// Checksum 0xfc12bea0, Offset: 0xba8
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
// Checksum 0xbac07565, Offset: 0xc18
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
// Checksum 0x54429bbe, Offset: 0xc78
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
// Checksum 0x780b0a1e, Offset: 0xcd0
// Size: 0x38
function resumetimerdiscardoverride(discardtime) {
    if (!level.timerstopped) {
        return;
    }
    level.timerstopped = 0;
    level.discardtime = discardtime;
}

// Namespace globallogic_utils/globallogic_utils
// Params 1, eflags: 0x0
// Checksum 0xf6c978b3, Offset: 0xd10
// Size: 0x1c
function getscoreremaining(score) {
    return level.scorelimit - score;
}

// Namespace globallogic_utils/globallogic_utils
// Params 2, eflags: 0x0
// Checksum 0xa273326e, Offset: 0xd38
// Size: 0x50
function function_fd90317f(user, var_b393387d) {
    if (level.cumulativeroundscores && isdefined(game.lastroundscore[user])) {
        return (var_b393387d - game.lastroundscore[user]);
    }
    return var_b393387d;
}

// Namespace globallogic_utils/globallogic_utils
// Params 1, eflags: 0x0
// Checksum 0x65923b21, Offset: 0xd90
// Size: 0x56
function getscoreperminute(var_d0266750) {
    minutespassed = gettimepassed() / int(60 * 1000) + 0.0001;
    return var_d0266750 / minutespassed;
}

// Namespace globallogic_utils/globallogic_utils
// Params 2, eflags: 0x0
// Checksum 0x15598674, Offset: 0xdf0
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
// Checksum 0xb5dfd4a, Offset: 0xe68
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
// Checksum 0x9e45578c, Offset: 0xeb8
// Size: 0x24
function waitfortimeornotify(time, notifyname) {
    self endon(notifyname);
    wait time;
}

// Namespace globallogic_utils/globallogic_utils
// Params 2, eflags: 0x0
// Checksum 0xd5796dd2, Offset: 0xee8
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
// Checksum 0xab929487, Offset: 0xf50
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
    // Checksum 0x745ad78d, Offset: 0x10c0
    // Size: 0x5a
    function debugline(start, end) {
        for (i = 0; i < 50; i++) {
            line(start, end);
            waitframe(1);
        }
    }

#/

// Namespace globallogic_utils/globallogic_utils
// Params 2, eflags: 0x0
// Checksum 0x7298d9b7, Offset: 0x1128
// Size: 0x24
function function_4aa8d809(index, string) {
    level.var_336c35f1[index] = string;
}

/#

    // Namespace globallogic_utils/globallogic_utils
    // Params 1, eflags: 0x0
    // Checksum 0x9355b87c, Offset: 0x1158
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
// Checksum 0x97d366d4, Offset: 0x13a0
// Size: 0x44
function add_map_error(msg) {
    if (!isdefined(level.maperrors)) {
        level.maperrors = [];
    }
    level.maperrors[level.maperrors.size] = msg;
}

// Namespace globallogic_utils/globallogic_utils
// Params 0, eflags: 0x0
// Checksum 0x53ebda26, Offset: 0x13f0
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
// Params 0, eflags: 0x0
// Checksum 0x8be2e8cf, Offset: 0x14d8
// Size: 0x22
function function_308e3379() {
    return strendswith(level.gametype, "_bb");
}

