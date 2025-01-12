#using scripts\core_common\hud_message_shared;
#using scripts\core_common\struct;
#using scripts\zm_common\gametypes\globallogic_score;
#using scripts\zm_common\gametypes\hostmigration;

#namespace globallogic_utils;

// Namespace globallogic_utils/globallogic_utils
// Params 0, eflags: 0x0
// Checksum 0xf3af687e, Offset: 0xc0
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
// Checksum 0x3cd06676, Offset: 0x188
// Size: 0x94
function testhps() {
    self endon(#"death");
    self endon(#"disconnect");
    hps = [];
    hps[hps.size] = "radar";
    hps[hps.size] = "artillery";
    hps[hps.size] = "dogs";
    for (;;) {
        hp = "radar";
        wait 20;
    }
}

// Namespace globallogic_utils/globallogic_utils
// Params 0, eflags: 0x0
// Checksum 0x770b2e7d, Offset: 0x228
// Size: 0xe4
function timeuntilroundend() {
    if (level.gameended) {
        timepassed = (gettime() - level.gameendtime) / 1000;
        timeremaining = level.postroundtime - timepassed;
        if (timeremaining < 0) {
            return 0;
        }
        return timeremaining;
    }
    if (level.inovertime) {
        return undefined;
    }
    if (level.timelimit <= 0) {
        return undefined;
    }
    if (!isdefined(level.starttime)) {
        return undefined;
    }
    timepassed = (gettimepassed() - level.starttime) / 1000;
    timeremaining = level.timelimit * 60 - timepassed;
    return timeremaining + level.postroundtime;
}

// Namespace globallogic_utils/globallogic_utils
// Params 0, eflags: 0x0
// Checksum 0xf1603e2b, Offset: 0x318
// Size: 0x2c
function gettimeremaining() {
    return level.timelimit * 60 * 1000 - gettimepassed();
}

// Namespace globallogic_utils/globallogic_utils
// Params 1, eflags: 0x0
// Checksum 0x1bfa460f, Offset: 0x350
// Size: 0x46
function registerpostroundevent(eventfunc) {
    if (!isdefined(level.postroundevents)) {
        level.postroundevents = [];
    }
    level.postroundevents[level.postroundevents.size] = eventfunc;
}

// Namespace globallogic_utils/globallogic_utils
// Params 0, eflags: 0x0
// Checksum 0x28d45583, Offset: 0x3a0
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
// Checksum 0xd88af0a7, Offset: 0x400
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
    // Checksum 0x6ca3293a, Offset: 0x458
    // Size: 0x1c2
    function assertproperplacement() {
        numplayers = level.placement[#"all"].size;
        for (i = 0; i < numplayers - 1; i++) {
            if (isdefined(level.placement[#"all"][i]) && isdefined(level.placement[#"all"][i + 1])) {
                if (level.placement[#"all"][i].score < level.placement[#"all"][i + 1].score) {
                    println("<dev string:x30>");
                    for (i = 0; i < numplayers; i++) {
                        player = level.placement[#"all"][i];
                        println("<dev string:x43>" + i + "<dev string:x46>" + player.name + "<dev string:x49>" + player.score);
                    }
                    assertmsg("<dev string:x4c>");
                    break;
                }
            }
        }
    }

#/

// Namespace globallogic_utils/globallogic_utils
// Params 1, eflags: 0x0
// Checksum 0xb3ba5b63, Offset: 0x628
// Size: 0x6a
function isvalidclass(vclass) {
    if (level.oldschool || sessionmodeiszombiesgame()) {
        assert(!isdefined(vclass));
        return true;
    }
    return isdefined(vclass) && vclass != "";
}

// Namespace globallogic_utils/globallogic_utils
// Params 1, eflags: 0x0
// Checksum 0x86604aed, Offset: 0x6a0
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
// Checksum 0x3e928777, Offset: 0x7c0
// Size: 0x16
function stoptickingsound() {
    self notify(#"stop_ticking");
}

// Namespace globallogic_utils/globallogic_utils
// Params 0, eflags: 0x0
// Checksum 0x7c1310cf, Offset: 0x7e0
// Size: 0xe8
function gametimer() {
    level endon(#"game_ended");
    level waittill(#"prematch_over");
    level.starttime = gettime();
    level.discardtime = 0;
    if (isdefined(game.roundmillisecondsalreadypassed)) {
        level.starttime -= game.roundmillisecondsalreadypassed;
        game.roundmillisecondsalreadypassed = undefined;
    }
    prevtime = gettime();
    while (game.state == "playing") {
        if (!level.timerstopped) {
            game.timepassed += gettime() - prevtime;
        }
        prevtime = gettime();
        wait 1;
    }
}

// Namespace globallogic_utils/globallogic_utils
// Params 0, eflags: 0x0
// Checksum 0x9b9b5f2e, Offset: 0x8d0
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
// Params 0, eflags: 0x0
// Checksum 0x6a65240c, Offset: 0x940
// Size: 0x2e
function pausetimer() {
    if (level.timerstopped) {
        return;
    }
    level.timerstopped = 1;
    level.timerpausetime = gettime();
}

// Namespace globallogic_utils/globallogic_utils
// Params 0, eflags: 0x0
// Checksum 0x14d000f8, Offset: 0x978
// Size: 0x46
function resumetimer() {
    if (!level.timerstopped) {
        return;
    }
    level.timerstopped = 0;
    level.discardtime += gettime() - level.timerpausetime;
}

// Namespace globallogic_utils/globallogic_utils
// Params 1, eflags: 0x0
// Checksum 0x665ff841, Offset: 0x9c8
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
// Checksum 0x4a4f58fb, Offset: 0xa70
// Size: 0xea
function getscoreperminute(team) {
    assert(isplayer(self) || isdefined(team));
    scorelimit = level.scorelimit;
    timelimit = level.timelimit;
    minutespassed = gettimepassed() / 60000 + 0.0001;
    if (isplayer(self)) {
        return (globallogic_score::_getplayerscore(self) / minutespassed);
    }
    return getteamscore(team) / minutespassed;
}

// Namespace globallogic_utils/globallogic_utils
// Params 1, eflags: 0x0
// Checksum 0xff31ef7d, Offset: 0xb68
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
// Checksum 0x154d6511, Offset: 0xc10
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
// Checksum 0xec261b, Offset: 0xc60
// Size: 0x24
function waitfortimeornotify(time, notifyname) {
    self endon(notifyname);
    wait time;
}

// Namespace globallogic_utils/globallogic_utils
// Params 2, eflags: 0x0
// Checksum 0xde3ce096, Offset: 0xc90
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
// Checksum 0x8d2102f9, Offset: 0xcf8
// Size: 0x9e
function isheadshot(weapon, shitloc, smeansofdeath, einflictor) {
    if (shitloc != "head" && shitloc != "helmet") {
        return false;
    }
    switch (smeansofdeath) {
    case #"mod_melee":
        return false;
    case #"mod_impact":
        if (weapon != level.weaponballisticknife) {
            return false;
        }
        break;
    }
    return true;
}

// Namespace globallogic_utils/globallogic_utils
// Params 1, eflags: 0x0
// Checksum 0x16b69b2b, Offset: 0xda0
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
    // Checksum 0xe4d8dba9, Offset: 0xf10
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
// Checksum 0x3ec2e5b6, Offset: 0xf78
// Size: 0x56
function isexcluded(entity, entitylist) {
    for (index = 0; index < entitylist.size; index++) {
        if (entity == entitylist[index]) {
            return true;
        }
    }
    return false;
}

/#

    // Namespace globallogic_utils/globallogic_utils
    // Params 2, eflags: 0x0
    // Checksum 0x56f163b9, Offset: 0xfd8
    // Size: 0xfc
    function logteamwinstring(wintype, winner) {
        log_string = wintype;
        if (isdefined(winner)) {
            log_string = log_string + "<dev string:x74>" + winner;
        }
        foreach (team, str_team in level.teams) {
            log_string = log_string + "<dev string:x7c>" + str_team + "<dev string:x49>" + game.stat[#"teamscores"][team];
        }
        print(log_string);
    }

#/
