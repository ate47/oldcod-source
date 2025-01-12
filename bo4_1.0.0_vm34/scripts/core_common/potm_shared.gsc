#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\killcam_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\rank_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;

#namespace potm;

// Namespace potm/potm_shared
// Params 0, eflags: 0x2
// Checksum 0xe41a8438, Offset: 0x1e0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"potm", &__init__, undefined, undefined);
}

// Namespace potm/potm_shared
// Params 0, eflags: 0x0
// Checksum 0x62780056, Offset: 0x228
// Size: 0x3e
function __init__() {
    callback::on_start_gametype(&init);
    level.var_634a57d8 = &event_bookmark;
}

// Namespace potm/potm_shared
// Params 0, eflags: 0x0
// Checksum 0xd66129a4, Offset: 0x270
// Size: 0x46
function function_2a4c0867() {
    if (isdefined(game.var_e8667961)) {
        return;
    }
    game.highlightreelinfodefines = gethighlightreelinfodefines();
    game.var_e8667961 = 1;
}

// Namespace potm/potm_shared
// Params 0, eflags: 0x4
// Checksum 0xc2cf546, Offset: 0x2c0
// Size: 0x49c
function private init() {
    if (!isdefined(game.var_86442904)) {
        game.potm_enabled = getgametypesetting(#"allowplayofthematch");
        if (!game.potm_enabled) {
            level.var_634a57d8 = undefined;
            return;
        }
        game.potm_max_events = getgametypesetting(#"maxplayofthematchevents");
        game.var_8927ceef = getgametypesetting(#"hash_567db38226658dbf");
        game.var_906314c0 = getgametypesetting(#"hash_62a4fd40810cb61");
        game.var_369adeaf = getgametypesetting(#"hash_4a6ef8940f4cbb83");
        game.var_b8a3011d = getgametypesetting(#"hash_6881c7cab0dcef39");
        game.var_54728500 = getgametypesetting(#"hash_7c0dcff6ffb1e348");
        game.var_9df72d8d = getgametypesetting(#"hash_4f4a73f236278ba8");
        game.var_1453f42a = getgametypesetting(#"hash_7c0acf14fb1f4080");
        game.var_e10318d5 = !game.var_54728500;
        game.var_acf3568c = getgametypesetting(#"hash_6269eb986d22cd37");
        game.var_89f6c9f = getgametypesetting(#"hash_6e2abf2cc40e03f1");
        game.var_66c3f03d = [];
        game.var_df6ab56e = [];
        game.potmevents = [];
        game.var_84d1b8f6 = #"potm";
        /#
            debuginit();
        #/
        if (sessionmodeismultiplayergame()) {
            game.var_ab77b504 = &function_8d8b87e4;
            game.var_23d69d95 = &function_bccaf403;
            game.var_4960f3a7 = &function_69a46e8d;
            game.var_a572a64f = &function_b0bd93fc;
            game.highlightreelprofileweighting = function_4081ae8c();
            game.var_e10318d5 = 1;
            game.var_7957db00 = 1;
        } else if (sessionmodeiszombiesgame()) {
            game.var_ab77b504 = &function_613f547c;
            game.var_23d69d95 = &function_f83eab9f;
            game.var_4960f3a7 = &function_91d0caf5;
            game.var_a572a64f = undefined;
            game.var_7957db00 = 0;
        } else {
            game.var_ab77b504 = &function_7fc23b66;
            game.var_23d69d95 = &function_4f4b6bab;
            game.var_4960f3a7 = &function_88226285;
            game.var_a572a64f = undefined;
            game.var_7957db00 = 0;
        }
        game.var_c3b6db09 = [];
        game.var_25039b9 = [];
        game.var_86442904 = 1;
    } else {
        for (eventindex = 0; eventindex < game.potmevents.size; eventindex++) {
            removepotmevent(eventindex);
        }
        game.potmevents = [];
    }
    function_2a4c0867();
    level.var_68a36291 = 0;
    thread function_51ee9f74();
}

// Namespace potm/potm_shared
// Params 0, eflags: 0x0
// Checksum 0x244f5b8f, Offset: 0x768
// Size: 0x20
function isenabled() {
    return isdefined(game.potm_enabled) && game.potm_enabled;
}

// Namespace potm/potm_shared
// Params 0, eflags: 0x0
// Checksum 0xbefe1449, Offset: 0x790
// Size: 0x1e
function function_8720246() {
    if (!isenabled()) {
        return false;
    }
    return true;
}

// Namespace potm/potm_shared
// Params 1, eflags: 0x4
// Checksum 0x8d112af8, Offset: 0x7b8
// Size: 0x6c
function private getclientname(clientent) {
    if (!isdefined(clientent)) {
        return "N/A";
    }
    if (isdefined(clientent.name)) {
        return clientent.name;
    }
    cliententnum = clientent getentitynumber();
    return "N/A [" + cliententnum + "]";
}

// Namespace potm/potm_shared
// Params 1, eflags: 0x0
// Checksum 0xae086ee6, Offset: 0x830
// Size: 0x232
function function_e99c9288(preparinginformation) {
    currentevent = preparinginformation.currentevent;
    var_91927f76 = "N/A";
    if (!isdefined(currentevent)) {
        return var_91927f76;
    }
    if (!isdefined(currentevent.killcamparams)) {
        if (isdefined(preparinginformation.clientnum)) {
            foreach (player in level.players) {
                if (player getentitynumber() == preparinginformation.clientnum) {
                    var_91927f76 = getclientname(player);
                    var_91927f76 += " (KillcamParams: N/A)";
                }
            }
        }
        return var_91927f76;
    }
    killcamparams = currentevent.killcamparams;
    attackername = "N/A";
    spectatorclientnum = "N/A";
    if (isdefined(killcamparams.attacker) && isdefined(killcamparams.attacker.name)) {
        attackername = killcamparams.attacker.name;
    }
    var_91927f76 = attackername + " {" + spectatorclientnum + "}";
    if (isdefined(killcamparams.weapon)) {
        var_91927f76 += " Weapon: " + killcamparams.weapon.name;
    }
    if (isdefined(killcamparams.meansofdeath)) {
        var_91927f76 += " MoD: " + killcamparams.meansofdeath;
    }
    return var_91927f76;
}

// Namespace potm/potm_shared
// Params 1, eflags: 0x0
// Checksum 0xed782814, Offset: 0xa70
// Size: 0x224
function function_28ab41b4(bookmark) {
    if (!game.var_7957db00) {
        return;
    }
    var_4aa676b1 = {};
    var_4aa676b1.round = util::getroundsplayed();
    var_4aa676b1.name = bookmark.bookmarkname;
    var_4aa676b1.time = bookmark.time;
    var_4aa676b1.isfirstperson = bookmark.isfirstperson;
    var_4aa676b1.infoindex = bookmark.var_a2e574d8.index;
    var_4aa676b1.mainclientnum = bookmark.mainclientnum;
    var_4aa676b1.var_e369be7a = getclientname(bookmark.var_cf6a9c68);
    var_4aa676b1.otherclientnum = bookmark.otherclientnum;
    var_4aa676b1.var_b4396f45 = getclientname(bookmark.var_e6df0461);
    var_4aa676b1.scoreaddition = bookmark.scoreaddition;
    var_4aa676b1.scoremultiplier = bookmark.scoremultiplier;
    var_4aa676b1.scoreeventpriority = bookmark.scoreeventpriority;
    var_4aa676b1.inflictorentnum = bookmark.inflictorentnum;
    var_4aa676b1.inflictorenttype = bookmark.inflictorenttype;
    var_4aa676b1.overrideentitycamera = bookmark.overrideentitycamera;
    var_4aa676b1.tableindex = bookmark.eventdata.tableindex;
    var_4aa676b1.event_info = bookmark.eventdata.event_info;
    function_b1f6086c(#"hash_4782850b19da4089", var_4aa676b1);
}

// Namespace potm/potm_shared
// Params 1, eflags: 0x0
// Checksum 0x271c9e5f, Offset: 0xca0
// Size: 0x1d4
function function_2f8c76d9(preparinginformation) {
    if (!game.var_7957db00) {
        return;
    }
    if (!isdefined(preparinginformation) || !isdefined(preparinginformation.currentevent)) {
        return;
    }
    duration = preparinginformation.currentevent.endtime - preparinginformation.currentevent.starttime;
    var_5d52cfde = {};
    var_5d52cfde.round = util::getroundsplayed();
    var_5d52cfde.clientnum = preparinginformation.clientnum;
    var_5d52cfde.infoindex = preparinginformation.currentevent.infoindex;
    var_5d52cfde.isfirstperson = preparinginformation.currentevent.var_6f1176;
    var_5d52cfde.starttime = preparinginformation.currentevent.starttime;
    var_5d52cfde.endtime = preparinginformation.currentevent.endtime;
    var_5d52cfde.duration = duration;
    var_5d52cfde.priority = int(preparinginformation.currentevent.priority);
    var_5d52cfde.occurrencecount = preparinginformation.var_f5e5e788;
    var_5d52cfde.killcamparams = function_e99c9288(preparinginformation);
    function_b1f6086c(#"hash_83a3293e7437420", var_5d52cfde);
}

// Namespace potm/potm_shared
// Params 0, eflags: 0x0
// Checksum 0x4bed0ac1, Offset: 0xe80
// Size: 0x6c
function post_round_potm() {
    if (!function_8720246()) {
        println("<dev string:x30>");
        return;
    }
    println("<dev string:x69>");
    level function_2d0c2b62();
}

// Namespace potm/potm_shared
// Params 2, eflags: 0x0
// Checksum 0x9477920a, Offset: 0xef8
// Size: 0x176
function function_7c36167b(deathtime, starttime) {
    self endon(#"disconnect");
    self endon(#"end_killcam");
    var_2f849dd4 = deathtime - starttime;
    waitbeforedeath = 1;
    timetowait = max(0, float(var_2f849dd4) / 1000 - waitbeforedeath);
    game.var_2b83f869 = gettime() + timetowait * 1000;
    wait timetowait;
    util::setclientsysstate("levelNotify", "sndFKsl");
    self playlocalsound(#"hash_96a5f3e5e8749c6");
    setslowmotion(1, 0.25, waitbeforedeath);
    wait waitbeforedeath;
    self playlocalsound(#"hash_38072640bdeb5b48");
    setslowmotion(0.25, 1, 1);
    game.var_2b83f869 = undefined;
}

// Namespace potm/potm_shared
// Params 1, eflags: 0x0
// Checksum 0xb8b6cbc7, Offset: 0x1078
// Size: 0x2fa
function function_3e19cfbf(currentevent) {
    self endon(#"disconnect");
    self endon(#"end_killcam");
    if (!isdefined(currentevent.var_89cb564c)) {
        return;
    }
    if (currentevent.var_89cb564c.size <= 0) {
        return;
    }
    currenttime = gettime();
    starttime = currentevent.starttime;
    var_affacd01 = arraycopy(currentevent.var_89cb564c);
    luinotifyevent(#"clear_notification_queue");
    while (true) {
        waitframe(1);
        if (var_affacd01.size <= 0) {
            break;
        }
        index = 0;
        timeelapsed = gettime() - currenttime;
        do {
            var_7658f6cd = var_affacd01[index];
            if (var_7658f6cd.time - starttime < timeelapsed) {
                if (var_7658f6cd.bookmarkname == #"medal") {
                    medalstruct = {};
                    medalstruct.medal_index = var_7658f6cd.eventdata.tableindex;
                    luinotifyevent(#"medal_received", 1, medalstruct.medal_index);
                } else if (var_7658f6cd.bookmarkname == #"score_event") {
                    label = rank::getscoreinfolabel(var_7658f6cd.eventdata.event_info);
                    score = rank::getscoreinfovalue(var_7658f6cd.eventdata.event_info);
                    if (!isdefined(label)) {
                        label = #"hash_480234a872bd64ac";
                    }
                    eventindex = level.scoreinfo[var_7658f6cd.eventdata.event_info][#"row"];
                    if (!isdefined(eventindex)) {
                        eventindex = 1;
                    }
                    luinotifyevent(#"score_event", 4, label, score, 0, eventindex);
                }
                array::pop(var_affacd01, index, 0);
                continue;
            }
            index++;
        } while (index < var_affacd01.size);
    }
}

// Namespace potm/potm_shared
// Params 1, eflags: 0x4
// Checksum 0x198af4b6, Offset: 0x1380
// Size: 0x562
function private play_potm_on_player_internal(event) {
    killcamparams = event.currentevent.killcamparams;
    var_ec8f0cf0 = isdefined(killcamparams) && !event.currentevent.var_6f1176;
    if (var_ec8f0cf0) {
        var_a2e574d8 = function_81aa747a(event.currentevent.infoindex);
        killcamentitystarttime = killcam::get_killcam_entity_info_starttime(killcamparams.killcam_entity_info);
        killcamoffset = float(gettime() - event.currentevent.starttime) / 1000;
        killcamlength = float(event.currentevent.endtime - event.currentevent.starttime) / 1000 - 0.05;
        killcamstarttime = event.currentevent.starttime;
        spectatorclient = killcamparams.spectatorclientnum;
        var_d130517f = killcamparams.var_d130517f;
        targetentityindex = killcamparams.targetentityindex;
        offsettime = killcamparams.offsettime;
    } else {
        var_a2e574d8 = function_81aa747a(event.currentevent.infoindex);
        killcamoffset = float(gettime() - event.currentevent.starttime) / 1000;
        killcamlength = float(event.currentevent.endtime - event.currentevent.starttime) / 1000;
        spectatorclient = event.clientnum;
        var_d130517f = event.clientxuid;
        targetentityindex = -1;
        offsettime = 0;
    }
    self notify(#"begin_killcam", {#start_time:gettime()});
    self.sessionstate = "spectator";
    self.spectatorclient = spectatorclient;
    self.var_d130517f = var_d130517f;
    self.killcamentity = -1;
    if (var_ec8f0cf0) {
        self thread killcam::set_killcam_entities(killcamparams.killcam_entity_info, killcamstarttime);
        self.killcamweapon = killcamparams.weapon;
        self.killcammod = killcamparams.meansofdeath;
    }
    self.killcamtargetentity = targetentityindex;
    self.archivetime = killcamoffset;
    self.killcamlength = killcamlength;
    self.psoffsettime = offsettime;
    foreach (team, _ in level.teams) {
        self allowspectateteam(team, 1);
    }
    self allowspectateteam("freelook", 1);
    self allowspectateteam(#"none", 1);
    self callback::function_1dea870d(#"on_end_game", &killcam::function_ee1db574);
    waitframe(1);
    self thread killcam::check_for_abrupt_end();
    self.killcam = 1;
    self thread killcam::wait_killcam_time();
    if (var_ec8f0cf0) {
        if (game.var_e10318d5) {
            self thread function_7c36167b(killcamparams.deathtime, killcamstarttime);
        }
    } else if (isdefined(var_a2e574d8)) {
        if (game.var_e10318d5) {
            self thread function_7c36167b(event.currentevent.endtime - var_a2e574d8.secondsafter, event.currentevent.starttime);
        }
    }
    self waittill(#"end_killcam");
}

// Namespace potm/potm_shared
// Params 1, eflags: 0x4
// Checksum 0x75af3a48, Offset: 0x18f0
// Size: 0xd4
function private play_potm_on_player(event) {
    self endon(#"disconnect");
    level endon(#"game_ended");
    luinotifyevent(#"potm_fadeout");
    if (isdefined(game.var_a572a64f)) {
        self [[ game.var_a572a64f ]](event.clientxuid);
    }
    play_potm_on_player_internal(event);
    self val::set(#"potm", "freezecontrols");
    self killcam::end(1);
}

// Namespace potm/potm_shared
// Params 0, eflags: 0x0
// Checksum 0xe539f2c, Offset: 0x19d0
// Size: 0x24
function function_edefc28a() {
    if (!isenabled()) {
        return 0;
    }
    return game.potmevents.size;
}

// Namespace potm/potm_shared
// Params 0, eflags: 0x0
// Checksum 0xa1023307, Offset: 0x1a00
// Size: 0x110
function function_a15b9453() {
    self endon(#"disconnect");
    level endon(#"game_ended");
    level endon(#"potm_finished");
    while (true) {
        waitresult = self waittill(#"menuresponse");
        menu = waitresult.menu;
        response = waitresult.response;
        if (menu == "PlayOfTheMatchWidget") {
            if (isplayer(self) && response == "voteSkip") {
                self.var_264d351 = 1;
                self clientfield::set_player_uimodel("hudItems.voteKillcamSkip", 1);
                return;
            }
        }
        waitframe(1);
    }
}

// Namespace potm/potm_shared
// Params 0, eflags: 0x0
// Checksum 0x5592c4b0, Offset: 0x1b18
// Size: 0x2f6
function function_603ed677() {
    level endon(#"game_ended");
    level endon(#"potm_finished");
    numplayers = 0;
    foreach (player in level.players) {
        if (!isbot(player)) {
            numplayers++;
        }
    }
    var_13c9a1ef = numplayers;
    foreach (player in level.players) {
        player clientfield::set_player_uimodel("hudItems.voteRequired", var_13c9a1ef);
    }
    while (true) {
        var_9861a377 = 0;
        foreach (player in level.players) {
            if (isdefined(player.var_264d351) && player.var_264d351) {
                var_9861a377++;
            }
        }
        foreach (player in level.players) {
            player clientfield::set_player_uimodel("hudItems.voteCommitted", var_9861a377);
        }
        waitframe(1);
        music::setmusicstate("none");
        if (var_9861a377 >= var_13c9a1ef) {
            foreach (player in level.players) {
                player killcam::function_2beac224();
            }
            return;
        }
    }
}

// Namespace potm/potm_shared
// Params 0, eflags: 0x0
// Checksum 0xe3946ddd, Offset: 0x1e18
// Size: 0xdc
function function_8ef22007() {
    foreach (player in level.players) {
        player.var_264d351 = 0;
        player clientfield::set_player_uimodel("hudItems.voteKillcamSkip", 0);
        if (!isbot(player)) {
            player thread function_a15b9453();
        }
    }
    level thread function_603ed677();
}

// Namespace potm/potm_shared
// Params 1, eflags: 0x0
// Checksum 0xa13ab2aa, Offset: 0x1f00
// Size: 0xc4
function function_4a46242f(event) {
    if (!isdefined(event.currentevent.var_a593e565)) {
        return;
    }
    println("<dev string:x8e>" + event.currentevent.var_a593e565 + "<dev string:xab>" + event.currentevent.var_985d814b + "<dev string:xb1>");
    level util::create_streamer_hint(event.currentevent.var_a593e565, event.currentevent.var_985d814b, 0.9);
}

// Namespace potm/potm_shared
// Params 1, eflags: 0x4
// Checksum 0x1f7d8b76, Offset: 0x1fd0
// Size: 0x3e
function private function_ff9bb31(duration) {
    if (!isdefined(game.var_2b83f869)) {
        return true;
    }
    if (gettime() + duration < game.var_2b83f869) {
        return true;
    }
    return false;
}

// Namespace potm/potm_shared
// Params 1, eflags: 0x4
// Checksum 0x5090a006, Offset: 0x2018
// Size: 0x50e
function private function_225e843f(sequence) {
    level endon(#"potm_finished");
    level endon(#"game_ended");
    assert(sequence.params.events.size > 0);
    starttimescale = 1;
    if (sequence.isintro) {
        playsoundatposition(#"hash_3fb775afd7e025dc", (0, 0, 0));
        music::setmusicstate("none");
    }
    cameraindex = 0;
    currenttime = gettime();
    var_f0ca44d8 = 0;
    currenttimescale = starttimescale;
    if (isdefined(sequence.var_f0ca44d8)) {
        var_f0ca44d8 = sequence.var_f0ca44d8;
    }
    do {
        event = sequence.params.events[cameraindex];
        processevent = 1;
        if (isdefined(event.cameraname) && event.cameraname == #"hash_520dfab6dc8b7832") {
            level thread function_7cb0ccfb();
        }
        if (var_f0ca44d8 > 0) {
            if (var_f0ca44d8 >= event.duration) {
                var_f0ca44d8 -= event.duration;
                processevent = 0;
            } else {
                event.duration -= var_f0ca44d8;
                var_f0ca44d8 = 0;
            }
        }
        if (event.luievent != "") {
            luinotifyevent(event.luievent);
        }
        if (processevent) {
            foreach (player in level.players) {
                cmd = 1;
                if (cameraindex == 0 && game.var_9ba761cf == 0) {
                    var_fd1d9234 = [[ game.var_4960f3a7 ]]();
                } else {
                    var_fd1d9234 = 0;
                }
                if (var_fd1d9234 > 0) {
                    cmd |= 4;
                }
                if (isdefined(sequence.inflictorentnum)) {
                    var_3c3e2174 = sequence.inflictorentnum;
                } else {
                    var_3c3e2174 = 0;
                }
                player function_fdd57430(cmd, sequence.infoindex, sequence.var_bf0cd6d9, cameraindex, sequence.params.events[cameraindex].postfxtype, var_fd1d9234, var_3c3e2174);
            }
            game.var_9ba761cf = 0;
            if (cameraindex > 0) {
                starttimescale = sequence.params.events[cameraindex - 1].timescale;
            } else {
                starttimescale = 1;
            }
            currenttimescale = event.timescale;
            if (function_ff9bb31(event.duration)) {
                setslowmotion(starttimescale, currenttimescale, event.duration);
            }
            wait event.duration;
        }
        cameraindex++;
    } while (cameraindex < sequence.params.events.size);
    level thread function_7cb0ccfb();
    if (function_ff9bb31(0)) {
        setslowmotion(currenttimescale, 1, 0);
    }
    timeelapsed = float(gettime() - currenttime) / 1000;
    if (sequence.duration > timeelapsed) {
        wait sequence.duration - timeelapsed;
    }
}

// Namespace potm/potm_shared
// Params 0, eflags: 0x4
// Checksum 0x7cd722fc, Offset: 0x2530
// Size: 0x80
function private function_a0648a8c() {
    foreach (player in level.players) {
        player function_dd566421(0);
    }
}

// Namespace potm/potm_shared
// Params 3, eflags: 0x4
// Checksum 0x1042c381, Offset: 0x25b8
// Size: 0x9a
function private function_632db474(var_613958ff, var_4c32f213, var_14e264c2) {
    var_45515924 = {};
    var_45515924.starttime = var_4c32f213;
    var_45515924.endtime = var_14e264c2;
    var_45515924.duration = float(var_45515924.endtime - var_45515924.starttime) / 1000;
    var_45515924.var_de26dcc8 = 1;
    return var_45515924;
}

// Namespace potm/potm_shared
// Params 1, eflags: 0x4
// Checksum 0x1840c5af, Offset: 0x2660
// Size: 0xa34
function private function_4dd8c24d(event) {
    level endon(#"potm_finished");
    level endon(#"game_ended");
    if (!game.var_54728500) {
        return;
    }
    if (!isdefined(event.currentevent.var_9987e149) || event.currentevent.var_9987e149.size <= 0) {
        return;
    }
    var_fc2755f8 = event.currentevent.var_9987e149;
    var_613958ff = [];
    var_4c32f213 = undefined;
    var_fff544d2 = 0;
    isintro = 1;
    do {
        var_23984ed6 = var_fc2755f8[var_fff544d2];
        infoindex = var_23984ed6.infoindex;
        var_a2e574d8 = function_81aa747a(infoindex);
        result = function_3a833f77(infoindex, isintro);
        if (isdefined(result)) {
            params = function_cdd01ee9(infoindex, result.var_bf0cd6d9);
            if (isdefined(params)) {
                sequence = {};
                duration = 0;
                foreach (var_f9cc0178 in params.events) {
                    duration += abs(var_f9cc0178.duration);
                }
                duration *= 1000;
                if (isintro) {
                    sequence.starttime = event.currentevent.starttime;
                } else {
                    assert(params.events.size > 0);
                    var_2f6e3cce = params.events[0].lerp_duration;
                    var_7b8e0b3c = params.events[0].duration;
                    if (var_2f6e3cce < 0) {
                        var_7b8e0b3c += var_2f6e3cce;
                    }
                    if (var_7b8e0b3c < 0) {
                        sequence.starttime = var_23984ed6.time + var_7b8e0b3c * 1000;
                        if (params.events.size <= 1) {
                            params.events[0].duration = abs(var_7b8e0b3c);
                        } else {
                            var_28a11ccd = var_7b8e0b3c;
                            for (eventindex = 1; eventindex < params.events.size; eventindex++) {
                                var_1c645200 = params.events[eventindex].lerp_duration;
                                if (var_1c645200 < 0) {
                                    params.events[eventindex - 1].duration = abs(var_28a11ccd - params.events[eventindex].duration - var_1c645200);
                                    var_28a11ccd = params.events[eventindex].duration + var_1c645200;
                                    continue;
                                }
                                params.events[eventindex - 1].duration = abs(var_28a11ccd - params.events[eventindex].duration);
                                var_28a11ccd = params.events[eventindex].duration;
                            }
                            params.events[params.events.size - 1].duration = 0;
                        }
                    } else {
                        sequence.starttime = var_23984ed6.time;
                        if (var_2f6e3cce < 0) {
                            sequence.starttime = var_23984ed6.time + var_2f6e3cce * 1000;
                        }
                    }
                }
                sequence.inflictorentnum = var_23984ed6.inflictorentnum;
                sequence.endtime = min(sequence.starttime + duration, event.currentevent.endtime);
                sequence.params = params;
                sequence.isintro = isintro;
                sequence.infoindex = infoindex;
                sequence.var_bf0cd6d9 = result.var_bf0cd6d9;
                sequence.duration = float(sequence.endtime - sequence.starttime) / 1000;
                addsequence = 1;
                if (isdefined(var_4c32f213)) {
                    if (var_4c32f213 >= sequence.starttime) {
                        if (var_4c32f213 >= sequence.endtime) {
                            addsequence = 0;
                            println("<dev string:xb3>" + var_fff544d2 + "<dev string:xe0>" + var_4c32f213 + "<dev string:x100>" + sequence.starttime + "<dev string:x11a>" + var_613958ff.size + "<dev string:x134>" + sequence.starttime + "<dev string:x141>" + sequence.endtime + "<dev string:x14c>" + infoindex + "<dev string:x159>" + isintro + "<dev string:x163>" + result.var_bf0cd6d9 + "<dev string:x179>");
                        } else {
                            sequence.var_f0ca44d8 = float(var_4c32f213 - sequence.starttime) / 1000;
                        }
                    } else {
                        var_45515924 = function_632db474(var_613958ff, var_4c32f213, sequence.starttime);
                        println("<dev string:x17c>" + var_613958ff.size + "<dev string:x134>" + var_45515924.starttime + "<dev string:x141>" + var_45515924.endtime + "<dev string:x179>");
                        array::add(var_613958ff, var_45515924);
                    }
                }
                if (addsequence) {
                    println("<dev string:x199>" + var_613958ff.size + "<dev string:x134>" + sequence.starttime + "<dev string:x141>" + sequence.endtime + "<dev string:x14c>" + infoindex + "<dev string:x159>" + isintro + "<dev string:x163>" + result.var_bf0cd6d9 + "<dev string:x179>");
                    var_4c32f213 = sequence.endtime;
                    array::add(var_613958ff, sequence);
                }
            }
        }
        if (isintro) {
            isintro = 0;
            continue;
        }
        var_fff544d2++;
    } while (var_fff544d2 < var_fc2755f8.size);
    if (isdefined(var_4c32f213) && var_4c32f213 < event.currentevent.endtime) {
        var_45515924 = function_632db474(var_613958ff, var_4c32f213, event.currentevent.endtime);
        println("<dev string:x17c>" + var_613958ff.size + "<dev string:x134>" + var_45515924.starttime + "<dev string:x141>" + var_45515924.endtime + "<dev string:x179>");
        array::add(var_613958ff, var_45515924);
    }
    foreach (sequence in var_613958ff) {
        if (isdefined(sequence.var_de26dcc8) && sequence.var_de26dcc8 == 1) {
            wait sequence.duration;
            continue;
        }
        function_225e843f(sequence);
    }
    function_a0648a8c();
}

// Namespace potm/potm_shared
// Params 1, eflags: 0x4
// Checksum 0x54817b78, Offset: 0x30a0
// Size: 0x94
function private function_a2ee9c38(delta) {
    self endon(#"end_killcam", #"hash_17418db31d60118f");
    time = gettime();
    delta -= 300;
    if (delta > 0) {
        wait float(delta) / 1000;
    }
    luinotifyevent(#"post_potm_transition");
}

// Namespace potm/potm_shared
// Params 1, eflags: 0x0
// Checksum 0xec1a92e6, Offset: 0x3140
// Size: 0x8c
function play_potm(repeatcount) {
    if (isdefined(level.var_141ed2c) && level.var_141ed2c) {
        return;
    }
    level.var_141ed2c = 1;
    println("<dev string:x1af>");
    level waittill(#"play_potm");
    function_2d0c2b62(repeatcount);
}

// Namespace potm/potm_shared
// Params 1, eflags: 0x0
// Checksum 0xe2c3c72d, Offset: 0x31d8
// Size: 0x7f4
function function_2d0c2b62(repeatcount = 1) {
    function_7dbf7e42(1);
    function_dc668451();
    if (game.potmevents.size == 0) {
        println("<dev string:x1d4>");
        level notify(#"potm_finished");
        println("<dev string:x1f2>");
        level.var_141ed2c = 0;
        return;
    }
    level function_4a46242f(game.potmevents[0]);
    setslowmotion(1, 1, 0);
    level.infinalkillcam = 1;
    if (util::waslastround()) {
        setmatchflag("round_end_killcam", 0);
    }
    visionsetnaked("default", 0);
    setmatchflag("potm", 1);
    luinotifyevent(#"pre_potm_transition");
    level notify(#"pre_potm");
    wait 0.25;
    exit = 0;
    count = 0;
    game.var_9ba761cf = 1;
    while (!exit && count < repeatcount) {
        println("<dev string:x20c>" + count + "<dev string:xb1>");
        for (eventindex = 0; eventindex < game.potmevents.size && !exit; eventindex++) {
            event = game.potmevents[eventindex];
            if (isdefined(event.currentevent.killcamparams)) {
                killcamparams = event.currentevent.killcamparams;
                if (!isdefined(killcamparams.targetentityindex)) {
                    continue;
                }
                attacker = killcamparams.attacker;
                if (isdefined(attacker) && isdefined(attacker.archetype) && attacker.archetype == "mannequin") {
                    continue;
                }
            }
            println("<dev string:x21d>" + eventindex + "<dev string:x22f>" + game.potmevents.size + "<dev string:xb1>");
            level function_4a46242f(event);
            startplayofthematch(eventindex);
            thread function_4dd8c24d(event);
            level.var_5394a567 = eventindex;
            level notify(#"potm_selected");
            foreach (player in level.players) {
                player setclientuivisibilityflag("hud_visible", 1);
            }
            waitframe(1);
            thread function_a2ee9c38(event.currentevent.endtime - event.currentevent.starttime);
            level notify(#"hash_4ead2cd3fa59f29b");
            function_de2e251f(event.currentevent);
            function_1ffed911(event.clientxuid);
            level thread function_3e19cfbf(event.currentevent);
            for (index = 0; index < level.players.size; index++) {
                player = level.players[index];
                if (!ispc()) {
                    player closeingamemenu();
                }
                player thread play_potm_on_player(event);
            }
            wait 0.1;
            while (killcam::are_any_players_watching() && !exit) {
                for (index = 0; index < level.players.size; index++) {
                    player = level.players[index];
                    if (game.var_9df72d8d) {
                        if (player jumpbuttonpressed()) {
                            exit = 1;
                            println("<dev string:x234>");
                        }
                    }
                }
                waitframe(1);
            }
        }
        count++;
    }
    music::setmusicstate("none");
    util::wait_network_frame();
    util::setclientsysstate("levelNotify", "sndFKe");
    if (exit) {
        self notify(#"hash_17418db31d60118f");
        luinotifyevent(#"post_potm_transition");
        wait 0.3;
    }
    foreach (player in level.players) {
        player killcam::spawn_end_of_final_killcam();
        if (game.var_54728500) {
            player function_dd566421(0);
        }
    }
    stopplayofthematch();
    setmatchflag("potm", 0);
    level.infinalkillcam = 0;
    level notify(#"potm_finished");
    level.var_141ed2c = 0;
    level.var_5394a567 = undefined;
    println("<dev string:x252>");
}

// Namespace potm/potm_shared
// Params 0, eflags: 0x0
// Checksum 0x81f7ce13, Offset: 0x39d8
// Size: 0xe4
function function_c586df39() {
    self.sessionstate = "playing";
    self.spectatorclient = -1;
    self stopfollowing();
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    self.spectatekillcam = 0;
    self stopfollowing();
    self val::reset(#"potm", "freezecontrols");
    self val::reset(#"spectate", "freezecontrols");
    self freezecontrols(0);
}

// Namespace potm/potm_shared
// Params 0, eflags: 0x0
// Checksum 0xcc3a5b19, Offset: 0x3ac8
// Size: 0x64
function function_7cb0ccfb() {
    if (sessionmodeiswarzonegame() || sessionmodeismultiplayergame()) {
        if (isdefined(game.musicset)) {
            music::setmusicstate("potm_main" + game.musicset);
        }
    }
}

/#

    // Namespace potm/potm_shared
    // Params 0, eflags: 0x4
    // Checksum 0x10434522, Offset: 0x3b38
    // Size: 0x64
    function private waitthennotifyplaypotm() {
        setdvar(#"scr_force_potm", 0);
        setdvar(#"hash_2428eb9c3d05eee0", 0);
        level function_2d0c2b62(1);
    }

#/

// Namespace potm/potm_shared
// Params 0, eflags: 0x4
// Checksum 0x35d80ca3, Offset: 0x3ba8
// Size: 0xa8
function private function_f8409d97() {
    var_7005f419 = -1;
    for (i = 0; i < game.potmevents.size; i++) {
        event = game.potmevents[i];
        if (var_7005f419 < 0 || event.currentevent.priority < game.potmevents[var_7005f419].currentevent.priority) {
            var_7005f419 = i;
        }
    }
    return var_7005f419;
}

// Namespace potm/potm_shared
// Params 1, eflags: 0x4
// Checksum 0x4b751f0b, Offset: 0x3c58
// Size: 0x144
function private function_9eb8fba3(var_7005f419) {
    assert(var_7005f419 >= 0, "<dev string:x264>");
    assert(var_7005f419 < game.potmevents.size);
    if (removepotmevent(var_7005f419)) {
        println("<dev string:x281>" + var_7005f419 + "<dev string:x2ba>" + game.potmevents[var_7005f419].currentevent.priority + "<dev string:x2c9>");
        array::pop(game.potmevents, var_7005f419, 0);
        return;
    }
    println("<dev string:x2cb>" + var_7005f419 + "<dev string:x2ba>" + game.potmevents[var_7005f419].currentevent.priority + "<dev string:x2c9>");
}

// Namespace potm/potm_shared
// Params 0, eflags: 0x4
// Checksum 0xa8c05082, Offset: 0x3da8
// Size: 0x4de
function private function_dc668451() {
    if (game.var_df6ab56e.size <= 0) {
        return;
    }
    if (isdefined(level.infinalkillcam) && level.infinalkillcam) {
        return;
    }
    level.var_68a36291 = 1;
    for (i = 0; i < game.var_df6ab56e.size; i++) {
        item = game.var_df6ab56e[i];
        if (!isdefined(item.currentevent) || !isdefined(item.currentevent.priority)) {
            println("<dev string:x30c>");
            continue;
        }
        if (!isdefined(item.currentevent.starttime) || !isdefined(item.currentevent.endtime)) {
            continue;
        }
        var_9eb8fba3 = 0;
        var_7005f419 = -1;
        var_a0516976 = function_521f071c(item.currentevent.endtime - item.currentevent.starttime);
        if (game.potmevents.size >= game.potm_max_events || !var_a0516976) {
            if (game.potmevents.size <= 0) {
                println("<dev string:x35a>");
                continue;
            }
            var_7005f419 = function_f8409d97();
            assert(var_7005f419 >= 0, "<dev string:x264>");
            assert(var_7005f419 < game.potmevents.size);
            if (isdefined(game.potmevents[var_7005f419]) && isdefined(game.potmevents[var_7005f419].currentevent) && isdefined(game.potmevents[var_7005f419].currentevent.priority) && game.potmevents[var_7005f419].currentevent.priority > item.currentevent.priority) {
                continue;
            }
            if (!var_a0516976) {
                println("<dev string:x3df>");
                function_9eb8fba3(var_7005f419);
            } else {
                var_9eb8fba3 = 1;
            }
        }
        if (addpotmevent(item.currentevent.starttime, item.currentevent.endtime, item.clientnum)) {
            println("<dev string:x436>" + game.var_df6ab56e[i].currentevent.priority + "<dev string:x2c9>");
            array::push(game.potmevents, game.var_df6ab56e[i], game.potmevents.size);
            /#
                if (getdvarint(#"scr_potm_debug_print", 0) == 1) {
                    printplayofthematchdebuginformation(item.currentevent.starttime, item.currentevent.endtime);
                }
            #/
            if (var_9eb8fba3 == 1) {
                function_9eb8fba3(var_7005f419);
            }
        } else {
            println("<dev string:x467>" + game.var_df6ab56e[i].currentevent.priority + "<dev string:x2c9>");
        }
        /#
            updatedebugmenudata(1);
        #/
    }
    level.var_68a36291 = 0;
    game.var_df6ab56e = [];
}

// Namespace potm/potm_shared
// Params 0, eflags: 0x4
// Checksum 0x7baa7eec, Offset: 0x4290
// Size: 0x38
function private function_51ee9f74() {
    while (true) {
        waitframe(1);
        function_7dbf7e42(0);
        function_dc668451();
    }
}

// Namespace potm/potm_shared
// Params 1, eflags: 0x4
// Checksum 0x2ff3e533, Offset: 0x42d0
// Size: 0xa4
function private function_b0bd93fc(xuid) {
    if (!level.rankedmatch) {
        return;
    }
    if (!isplayer(self)) {
        return;
    }
    if (!isdefined(xuid)) {
        return;
    }
    if (self getxuid() == xuid) {
        self stats::set_stat(#"hash_151429c0411edbfb", 0);
        return;
    }
    self stats::inc_stat(#"hash_151429c0411edbfb", 1);
}

// Namespace potm/potm_shared
// Params 0, eflags: 0x4
// Checksum 0xfe90c88c, Offset: 0x4380
// Size: 0xca
function private function_4ba21782() {
    if (isdefined(game.highlightreelprofileweighting) && !level.rankedmatch) {
        var_ddf90171 = self stats::get_stat(#"hash_151429c0411edbfb");
        for (i = game.highlightreelprofileweighting.size - 1; i >= 0; i--) {
            if (var_ddf90171 >= game.highlightreelprofileweighting[i].var_bc066aa2) {
                return game.highlightreelprofileweighting[i].boost;
            }
        }
    }
    return function_4f4b6bab();
}

// Namespace potm/potm_shared
// Params 1, eflags: 0x4
// Checksum 0x95c60b49, Offset: 0x4458
// Size: 0x13c
function private function_1ffed911(var_91c083ce) {
    foundplayer = 0;
    foreach (var_a3cd06 in game.var_25039b9) {
        if (var_a3cd06.xuid == var_91c083ce) {
            var_a3cd06.weight = game.var_acf3568c;
            foundplayer = 1;
            continue;
        }
        var_a3cd06.weight = min(var_a3cd06.weight + game.var_89f6c9f, 1);
    }
    if (!foundplayer) {
        array::add(game.var_25039b9, {#xuid:var_91c083ce, #weight:game.var_acf3568c}, 0);
    }
}

// Namespace potm/potm_shared
// Params 0, eflags: 0x4
// Checksum 0xc74919d0, Offset: 0x45a0
// Size: 0xea
function private function_36633aaf() {
    if (!isplayer(self)) {
        return function_4f4b6bab();
    }
    xuid = self getxuid();
    foreach (var_a3cd06 in game.var_25039b9) {
        if (var_a3cd06.xuid == xuid) {
            return var_a3cd06.weight;
        }
    }
    return function_4f4b6bab();
}

// Namespace potm/potm_shared
// Params 1, eflags: 0x4
// Checksum 0x76158e9a, Offset: 0x4698
// Size: 0xc0
function private function_de2e251f(currentevent) {
    if (!isdefined(currentevent.var_9987e149)) {
        return;
    }
    if (currentevent.var_9987e149.size <= 0) {
        return;
    }
    foreach (details in currentevent.var_9987e149) {
        array::add(game.var_c3b6db09, details.infoindex, 0);
    }
}

// Namespace potm/potm_shared
// Params 1, eflags: 0x4
// Checksum 0x39ef9ca2, Offset: 0x4760
// Size: 0xa2
function private function_97df30a8(var_a2e574d8) {
    foreach (var_70b9202f in game.var_c3b6db09) {
        if (var_a2e574d8.index == var_70b9202f) {
            return var_a2e574d8.var_985228f7;
        }
    }
    return function_4f4b6bab();
}

// Namespace potm/potm_shared
// Params 1, eflags: 0x0
// Checksum 0x4d22ce80, Offset: 0x4810
// Size: 0x12
function function_7fc23b66(var_a2e574d8) {
    return false;
}

// Namespace potm/potm_shared
// Params 1, eflags: 0x0
// Checksum 0x4aefc0ba, Offset: 0x4830
// Size: 0x12
function function_4f4b6bab(var_a2e574d8) {
    return true;
}

// Namespace potm/potm_shared
// Params 1, eflags: 0x0
// Checksum 0xa0632fab, Offset: 0x4850
// Size: 0x22
function function_8d8b87e4(var_a2e574d8) {
    return function_7fc23b66(var_a2e574d8);
}

// Namespace potm/potm_shared
// Params 2, eflags: 0x0
// Checksum 0x60915848, Offset: 0x4880
// Size: 0xd0
function function_bccaf403(var_a2e574d8, var_cf6a9c68) {
    multiplier = function_4f4b6bab();
    if (game.roundsplayed > 0) {
        var_f72a823f = function_97df30a8(var_a2e574d8);
        multiplier *= var_f72a823f;
    }
    var_ebc37118 = var_cf6a9c68 function_4ba21782();
    multiplier *= var_ebc37118;
    var_f53e2c42 = var_cf6a9c68 function_36633aaf();
    multiplier *= var_f53e2c42;
    return multiplier;
}

// Namespace potm/potm_shared
// Params 1, eflags: 0x0
// Checksum 0x98c611a5, Offset: 0x4958
// Size: 0x20
function function_613f547c(var_a2e574d8) {
    return var_a2e574d8.var_9e4cf49d * level.round_number;
}

// Namespace potm/potm_shared
// Params 2, eflags: 0x0
// Checksum 0x5b552b9e, Offset: 0x4980
// Size: 0x2a
function function_f83eab9f(var_a2e574d8, var_cf6a9c68) {
    return function_4f4b6bab(var_a2e574d8);
}

/#

    // Namespace potm/potm_shared
    // Params 1, eflags: 0x4
    // Checksum 0xcd069747, Offset: 0x49b8
    // Size: 0x33c
    function private function_2bb1bf42(bookmark) {
        var_65424bbb = "<dev string:x49f>" + bookmark.bookmarkname + "<dev string:x4c9>" + bookmark.time;
        if (isdefined(bookmark.var_a2e574d8)) {
            var_65424bbb += "<dev string:x4d3>" + bookmark.var_a2e574d8.index;
        }
        if (isdefined(bookmark.isfirstperson)) {
            var_65424bbb += "<dev string:x4ed>" + bookmark.isfirstperson;
        }
        if (isdefined(bookmark.var_cf6a9c68)) {
            var_65424bbb += "<dev string:x4fe>" + getclientname(bookmark.var_cf6a9c68);
        }
        if (isdefined(bookmark.var_e6df0461)) {
            var_65424bbb += "<dev string:x50c>" + getclientname(bookmark.var_e6df0461);
        }
        if (isdefined(bookmark.scoreaddition)) {
            var_65424bbb += "<dev string:x51b>" + bookmark.scoreaddition;
        }
        if (isdefined(bookmark.scoremultiplier)) {
            var_65424bbb += "<dev string:x52c>" + bookmark.scoremultiplier;
        }
        if (isdefined(bookmark.scoreeventpriority)) {
            var_65424bbb += "<dev string:x53f>" + bookmark.scoreeventpriority;
        }
        if (isdefined(bookmark.var_fc963626) && bookmark.var_fc963626.size > 0) {
            var_65424bbb += "<dev string:x555>";
            foreach (var_c17cf89f in bookmark.var_fc963626) {
                var_65424bbb += "<dev string:x566>" + var_c17cf89f;
            }
        }
        if (isdefined(bookmark.overrideentitycamera)) {
            var_65424bbb += "<dev string:x568>" + bookmark.overrideentitycamera;
        }
        if (isdefined(bookmark.eventdata.tableindex)) {
            var_65424bbb += "<dev string:x580>" + bookmark.eventdata.tableindex;
        }
        if (isdefined(bookmark.eventdata.event_info)) {
            var_65424bbb += "<dev string:x598>" + bookmark.eventdata.event_info;
        }
        println(var_65424bbb + "<dev string:xb1>");
    }

#/

// Namespace potm/potm_shared
// Params 10, eflags: 0x0
// Checksum 0x5be37f1d, Offset: 0x4d00
// Size: 0x6c0
function function_e778864(modulename, bookmarkname, time, var_cf6a9c68, var_e6df0461, scoreeventpriority, einflictor, var_fc963626, overrideentitycamera, eventdata) {
    var_3492d4bf = 0;
    if (modulename == #"potm") {
        var_3492d4bf = 1;
    }
    if (isdefined(einflictor)) {
        inflictorenttype = einflictor getentitytype();
    } else {
        inflictorenttype = 0;
    }
    if (!isdefined(var_fc963626) || var_fc963626.size <= 0) {
        var_fc963626 = [];
        array::add(var_fc963626, #"");
    }
    var_a2e574d8 = function_7f64ef46(bookmarkname, inflictorenttype, var_fc963626);
    if (!isdefined(var_a2e574d8)) {
        println(function_15979fa9(modulename) + "<dev string:x5b0>" + bookmarkname + "<dev string:x5cb>");
        return undefined;
    }
    if (var_3492d4bf && isdefined(var_cf6a9c68) && isplayer(var_cf6a9c68) && !isalive(var_cf6a9c68)) {
        println(function_15979fa9(modulename) + "<dev string:x5b0>" + bookmarkname + "<dev string:x5f5>" + var_cf6a9c68 getentitynumber() + "<dev string:x604>");
        return undefined;
    }
    bookmark = spawnstruct();
    bookmark.bookmarkname = bookmarkname;
    bookmark.time = time;
    bookmark.var_cf6a9c68 = var_cf6a9c68;
    if (isdefined(var_cf6a9c68)) {
        bookmark.mainclientnum = var_cf6a9c68 getentitynumber();
        if (isplayer(var_cf6a9c68)) {
            bookmark.var_77a7bbb9 = var_cf6a9c68 getxuid();
        } else {
            bookmark.var_77a7bbb9 = 0;
        }
    } else {
        bookmark.mainclientnum = -1;
        bookmark.var_77a7bbb9 = 0;
    }
    if (isdefined(var_e6df0461)) {
        bookmark.var_e6df0461 = var_e6df0461;
        bookmark.otherclientnum = var_e6df0461 getentitynumber();
        if (isplayer(var_e6df0461)) {
            bookmark.var_ef6d33b2 = var_e6df0461 getxuid();
        } else {
            bookmark.var_ef6d33b2 = 0;
        }
    } else {
        bookmark.otherclientnum = -1;
        bookmark.var_ef6d33b2 = 0;
    }
    if (isdefined(einflictor)) {
        bookmark.inflictorentnum = einflictor getentitynumber();
        bookmark.inflictorenttype = inflictorenttype;
        if (isdefined(einflictor.birthtime)) {
            bookmark.var_96ec641c = einflictor.birthtime;
        } else {
            bookmark.var_96ec641c = 0;
        }
    } else {
        bookmark.inflictorentnum = -1;
        bookmark.inflictorenttype = inflictorenttype;
        bookmark.var_96ec641c = 0;
    }
    bookmark.var_fc963626 = var_fc963626;
    if (isdefined(eventdata)) {
        bookmark.eventdata = eventdata;
    } else {
        bookmark.eventdata = {};
        bookmark.eventdata.tableindex = 0;
        bookmark.eventdata.event_info = #"";
    }
    if (isdefined(scoreeventpriority)) {
        bookmark.scoreeventpriority = scoreeventpriority;
    } else {
        bookmark.scoreeventpriority = 0;
    }
    if (var_3492d4bf) {
        bookmark.scoreaddition = [[ game.var_ab77b504 ]](var_a2e574d8);
        bookmark.scoremultiplier = [[ game.var_23d69d95 ]](var_a2e574d8, var_cf6a9c68);
        if (var_a2e574d8.boostpriorityonly) {
            preparinginformation = function_983c204(bookmark.mainclientnum);
            if (!isdefined(preparinginformation)) {
                println("<dev string:x614>" + bookmark.bookmarkname + "<dev string:x635>");
                return undefined;
            } else {
                if (!isdefined(preparinginformation.currentevent) || !isdefined(preparinginformation.currentevent.infoindex)) {
                    println("<dev string:x674>" + bookmark.bookmarkname + "<dev string:x694>");
                    return undefined;
                }
                bookmark.isfirstperson = function_81aa747a(preparinginformation.currentevent.infoindex).isfirstperson;
            }
        } else {
            bookmark.isfirstperson = var_a2e574d8.isfirstperson;
            if (isdefined(overrideentitycamera) && overrideentitycamera == 1) {
                bookmark.isfirstperson = 1;
            }
        }
    }
    bookmark.var_a2e574d8 = var_a2e574d8;
    if (var_3492d4bf) {
        /#
            function_2bb1bf42(bookmark);
        #/
        function_28ab41b4(bookmark);
    }
    return bookmark;
}

// Namespace potm/potm_shared
// Params 2, eflags: 0x0
// Checksum 0xb7051f6a, Offset: 0x53c8
// Size: 0x80
function function_d2f2ef08(weapon, meansofdeath) {
    var_fc963626 = [];
    if (isdefined(weapon)) {
        array::add(var_fc963626, weapon.name);
    }
    if (isdefined(meansofdeath)) {
        array::add(var_fc963626, hash(meansofdeath));
    }
    return var_fc963626;
}

// Namespace potm/potm_shared
// Params 14, eflags: 0x0
// Checksum 0xb0032736, Offset: 0x5450
// Size: 0x30e
function function_da7a6757(bookmarkname, spectatorclientnum, var_d130517f, targetentity, killcam_entity_info, weapon, meansofdeath, deathtime, deathtimeoffset, offsettime, perks, killstreaks, attacker, einflictor) {
    if (!isenabled()) {
        return;
    }
    if (isdefined(einflictor)) {
        inflictorenttype = einflictor getentitytype();
    } else {
        inflictorenttype = -1;
    }
    var_fc963626 = function_d2f2ef08(weapon, meansofdeath);
    var_a2e574d8 = function_7f64ef46(bookmarkname, inflictorenttype, var_fc963626);
    if (!isdefined(var_a2e574d8)) {
        return;
    }
    var_ff471c47 = function_a6d1f65d(spectatorclientnum, var_d130517f, var_a2e574d8.isfirstperson, 0);
    if (!isdefined(var_ff471c47)) {
        return;
    }
    var_ff471c47.currentevent.killcamparams = {};
    var_ff471c47.currentevent.killcamparams.spectatorclientnum = spectatorclientnum;
    var_ff471c47.currentevent.killcamparams.var_d130517f = var_d130517f;
    var_ff471c47.currentevent.killcamparams.targetentityindex = targetentity getentitynumber();
    var_ff471c47.currentevent.killcamparams.killcam_entity_info = killcam_entity_info;
    var_ff471c47.currentevent.killcamparams.weapon = weapon;
    var_ff471c47.currentevent.killcamparams.meansofdeath = meansofdeath;
    var_ff471c47.currentevent.killcamparams.deathtime = deathtime;
    var_ff471c47.currentevent.killcamparams.deathtimeoffset = deathtimeoffset;
    var_ff471c47.currentevent.killcamparams.offsettime = offsettime;
    var_ff471c47.currentevent.killcamparams.perks = perks;
    var_ff471c47.currentevent.killcamparams.killstreaks = killstreaks;
    var_ff471c47.currentevent.killcamparams.attacker = attacker;
    var_ff471c47.currentevent.killcamparams.inflictor = einflictor;
}

// Namespace potm/potm_shared
// Params 5, eflags: 0x0
// Checksum 0xc40e2d07, Offset: 0x5768
// Size: 0x184
function kill_bookmark(var_cf6a9c68, var_e6df0461, einflictor, var_fc963626, overrideentitycamera) {
    if (!isenabled()) {
        return;
    }
    if (!game.var_b8a3011d && isbot(var_cf6a9c68)) {
        return;
    }
    if (game.var_1453f42a) {
        println("<dev string:x6b8>");
        return;
    }
    mainclientnum = var_cf6a9c68 getentitynumber();
    if (!game.var_b8a3011d && mainclientnum >= level.players.size) {
        println("<dev string:x6d4>" + mainclientnum + "<dev string:x6fc>" + level.players.size + "<dev string:x716>");
        return;
    }
    bookmark = function_e778864(game.var_84d1b8f6, #"kill", gettime(), var_cf6a9c68, var_e6df0461, 0, einflictor, var_fc963626, overrideentitycamera);
    function_7ce019c9(bookmark);
}

// Namespace potm/potm_shared
// Params 6, eflags: 0x0
// Checksum 0x63fed024, Offset: 0x58f8
// Size: 0x19c
function function_e6fdcbca(bookmarkname, var_cf6a9c68, var_e6df0461, einflictor, var_fc963626, overrideentitycamera) {
    if (!isenabled()) {
        return;
    }
    if (!game.var_b8a3011d && isbot(var_cf6a9c68)) {
        return;
    }
    if (game.var_1453f42a) {
        println(function_15979fa9(game.var_84d1b8f6) + "<dev string:x71a>");
        return;
    }
    mainclientnum = var_cf6a9c68 getentitynumber();
    if (!game.var_b8a3011d && mainclientnum >= level.players.size) {
        println("<dev string:x6d4>" + mainclientnum + "<dev string:x6fc>" + level.players.size + "<dev string:x716>");
        return;
    }
    bookmark = function_e778864(game.var_84d1b8f6, bookmarkname, gettime(), var_cf6a9c68, var_e6df0461, 0, einflictor, var_fc963626, overrideentitycamera);
    function_7ce019c9(bookmark);
}

// Namespace potm/potm_shared
// Params 2, eflags: 0x0
// Checksum 0x640e9438, Offset: 0x5aa0
// Size: 0x144
function function_fed85dee(var_cf6a9c68, einflictor = var_cf6a9c68) {
    if (!isenabled()) {
        return;
    }
    if (!game.var_b8a3011d && isbot(var_cf6a9c68)) {
        return;
    }
    mainclientnum = var_cf6a9c68 getentitynumber();
    if (!game.var_b8a3011d && mainclientnum >= level.players.size) {
        println("<dev string:x6d4>" + mainclientnum + "<dev string:x6fc>" + level.players.size + "<dev string:x716>");
        return;
    }
    bookmark = function_e778864(game.var_84d1b8f6, #"object_destroy", gettime(), var_cf6a9c68, undefined, 0, einflictor);
    function_7ce019c9(bookmark);
}

// Namespace potm/potm_shared
// Params 5, eflags: 0x0
// Checksum 0xd2251e41, Offset: 0x5bf0
// Size: 0xc4
function event_bookmark(bookmarkname, time, var_cf6a9c68, scoreeventpriority, eventdata) {
    if (!isenabled()) {
        return;
    }
    if (!isdefined(var_cf6a9c68)) {
        return;
    }
    if (!game.var_b8a3011d && isbot(var_cf6a9c68)) {
        return;
    }
    bookmark = function_e778864(game.var_84d1b8f6, bookmarkname, time, var_cf6a9c68, undefined, scoreeventpriority, undefined, undefined, 0, eventdata);
    function_7ce019c9(bookmark);
}

// Namespace potm/potm_shared
// Params 5, eflags: 0x0
// Checksum 0xf1cdd4e1, Offset: 0x5cc0
// Size: 0xbc
function bookmark(bookmarkname, time, var_cf6a9c68, var_e6df0461, scoreeventpriority) {
    if (!isenabled()) {
        return;
    }
    if (!isdefined(var_cf6a9c68)) {
        return;
    }
    if (!game.var_b8a3011d && isbot(var_cf6a9c68)) {
        return;
    }
    bookmark = function_e778864(game.var_84d1b8f6, bookmarkname, time, var_cf6a9c68, var_e6df0461, scoreeventpriority);
    function_7ce019c9(bookmark);
}

// Namespace potm/potm_shared
// Params 1, eflags: 0x4
// Checksum 0x6026e1d2, Offset: 0x5d88
// Size: 0x2e
function private function_1af271cd(bookmarkname) {
    if (bookmarkname == #"kill") {
        return 1;
    }
    return 0;
}

// Namespace potm/potm_shared
// Params 3, eflags: 0x4
// Checksum 0xd488f71e, Offset: 0x5dc0
// Size: 0x24e
function private function_7f64ef46(bookmarkname, etype, var_fc963626) {
    result = undefined;
    if (function_1af271cd(bookmarkname)) {
        for (i = 0; i < game.highlightreelinfodefines.size; i++) {
            info = game.highlightreelinfodefines[i];
            if (info.bookmarkname == bookmarkname && isdefined(info.etype) && info.etype == etype) {
                foreach (var_c17cf89f in var_fc963626) {
                    if (info.var_2ba4c492 == var_c17cf89f) {
                        return info;
                    }
                }
                if (info.var_2ba4c492 == #"") {
                    result = info;
                }
            }
        }
    } else {
        for (i = 0; i < game.highlightreelinfodefines.size; i++) {
            info = game.highlightreelinfodefines[i];
            if (info.bookmarkname == bookmarkname) {
                foreach (var_c17cf89f in var_fc963626) {
                    if (info.var_2ba4c492 == var_c17cf89f) {
                        return info;
                    }
                }
                if (info.var_2ba4c492 == #"") {
                    result = info;
                }
            }
        }
    }
    return result;
}

// Namespace potm/potm_shared
// Params 1, eflags: 0x4
// Checksum 0xe11f403c, Offset: 0x6018
// Size: 0xa0
function private function_81aa747a(infoindex) {
    assert(infoindex < game.highlightreelinfodefines.size);
    if (infoindex >= game.highlightreelinfodefines.size) {
        println("<dev string:x732>" + infoindex + "<dev string:x75b>" + game.highlightreelinfodefines.size + "<dev string:x716>");
        return undefined;
    }
    return game.highlightreelinfodefines[infoindex];
}

// Namespace potm/potm_shared
// Params 2, eflags: 0x4
// Checksum 0xcc1ce05, Offset: 0x60c0
// Size: 0x6e
function private function_e66eb1b0(clientnum, bookmark) {
    if (bookmark.bookmarkname == #"player_revived") {
        return (bookmark.mainclientnum == clientnum || bookmark.otherclientnum == clientnum);
    }
    return bookmark.mainclientnum == clientnum;
}

// Namespace potm/potm_shared
// Params 3, eflags: 0x4
// Checksum 0xa3cf9dfa, Offset: 0x6138
// Size: 0xda
function private function_af19a19(bookmark, preparinginformation, bonussearchtime) {
    if (preparinginformation.currentevent.endtime < bookmark.time - bookmark.var_a2e574d8.secondsbefore + bonussearchtime) {
        return false;
    }
    if (game.var_8927ceef > 0 && bookmark.time + bookmark.var_a2e574d8.secondsafter - preparinginformation.currentevent.starttime > int(game.var_8927ceef * 1000)) {
        return false;
    }
    return true;
}

// Namespace potm/potm_shared
// Params 2, eflags: 0x4
// Checksum 0x92ec9e70, Offset: 0x6220
// Size: 0xca
function private function_d8f21cd1(bookmark, preparinginformation) {
    if (!isdefined(bookmark.var_cf6a9c68)) {
        println("<dev string:x785>" + bookmark.bookmarkname + "<dev string:x7ad>");
        return;
    }
    if (isdefined(preparinginformation.currentevent.streamerhint)) {
        return;
    }
    preparinginformation.currentevent.var_a593e565 = bookmark.var_cf6a9c68.origin;
    preparinginformation.currentevent.var_985d814b = bookmark.var_cf6a9c68.angles;
}

// Namespace potm/potm_shared
// Params 2, eflags: 0x4
// Checksum 0xff8f1901, Offset: 0x62f8
// Size: 0x1b4
function private function_1126e4a0(preparinginformation, bookmark) {
    if (bookmark.bookmarkname != #"medal" && bookmark.bookmarkname != #"score_event") {
        return;
    }
    if (!isdefined(bookmark.var_cf6a9c68)) {
        println("<dev string:x7ce>" + bookmark.bookmarkname + "<dev string:x7f1>" + bookmark.eventdata.tableindex + "<dev string:x804>" + bookmark.eventdata.event_info + "<dev string:x7ad>");
        return;
    }
    if (!isdefined(preparinginformation.currentevent.var_89cb564c)) {
        preparinginformation.currentevent.var_89cb564c = [];
    }
    var_7658f6cd = {};
    var_7658f6cd.bookmarkname = bookmark.bookmarkname;
    var_7658f6cd.time = bookmark.time + 50;
    var_7658f6cd.player = bookmark.var_cf6a9c68;
    var_7658f6cd.eventdata = bookmark.eventdata;
    array::push(preparinginformation.currentevent.var_89cb564c, var_7658f6cd, preparinginformation.currentevent.var_89cb564c.size);
}

// Namespace potm/potm_shared
// Params 2, eflags: 0x4
// Checksum 0x60952863, Offset: 0x64b8
// Size: 0xdc
function private function_118647ed(bookmark, preparinginformation) {
    if (!isdefined(preparinginformation.currentevent.var_9987e149)) {
        preparinginformation.currentevent.var_9987e149 = [];
    }
    var_9987e149 = {};
    var_9987e149.bookmarkname = bookmark.bookmarkname;
    var_9987e149.time = bookmark.time;
    var_9987e149.infoindex = bookmark.var_a2e574d8.index;
    array::push(preparinginformation.currentevent.var_9987e149, var_9987e149, preparinginformation.currentevent.var_9987e149.size);
}

// Namespace potm/potm_shared
// Params 2, eflags: 0x4
// Checksum 0x8fc8ef5a, Offset: 0x65a0
// Size: 0x110
function private function_fd484ab3(bookmark, var_f5e5e788) {
    if (var_f5e5e788 < 1) {
        var_9764edf0 = bookmark.var_a2e574d8.priorityweightperevent;
    } else {
        var_9764edf0 = bookmark.var_a2e574d8.prioritystackfactor + bookmark.var_a2e574d8.priorityweightperevent;
    }
    if (bookmark.var_a2e574d8.boostpriorityonly) {
        var_99efb27 = var_9764edf0 * bookmark.scoreeventpriority;
    } else {
        var_99efb27 = 0;
        if (var_f5e5e788 >= 1) {
            var_99efb27 += var_f5e5e788 * var_9764edf0;
        } else {
            var_99efb27 += var_9764edf0;
        }
    }
    var_99efb27 += bookmark.scoreaddition;
    var_99efb27 *= bookmark.scoremultiplier;
    return var_99efb27;
}

// Namespace potm/potm_shared
// Params 2, eflags: 0x4
// Checksum 0x4906f587, Offset: 0x66b8
// Size: 0x51c
function private function_7baf8b1f(bookmark, preparinginformation) {
    if (preparinginformation.pendingupdate) {
        if (bookmark.var_a2e574d8.boostpriorityonly && function_e66eb1b0(preparinginformation.clientnum, bookmark) && preparinginformation.currentevent.endtime >= bookmark.time - bookmark.var_a2e574d8.secondsbefore) {
            preparinginformation.currentevent.priority += function_fd484ab3(bookmark, preparinginformation.var_f5e5e788);
            preparinginformation.updatetime = gettime();
            function_1126e4a0(preparinginformation, bookmark);
        } else if (!bookmark.var_a2e574d8.boostpriorityonly && function_e66eb1b0(preparinginformation.clientnum, bookmark)) {
            bonussearchtime = function_3b17006(preparinginformation);
            if (function_af19a19(bookmark, preparinginformation, bonussearchtime)) {
                preparinginformation.currentevent.endtime = bookmark.time + bookmark.var_a2e574d8.secondsafter;
                preparinginformation.currentevent.priority += function_fd484ab3(bookmark, preparinginformation.var_f5e5e788);
                preparinginformation.var_f5e5e788++;
                preparinginformation.updatetime = gettime();
                function_118647ed(bookmark, preparinginformation);
            } else {
                clientnum = preparinginformation.clientnum;
                clientxuid = preparinginformation.clientxuid;
                function_603553d5(preparinginformation);
                function_7650bd13(preparinginformation);
                preparinginformation = function_2cb12eec(clientnum, clientxuid);
            }
        }
    }
    if (!preparinginformation.pendingupdate) {
        if (!bookmark.var_a2e574d8.boostpriorityonly && function_e66eb1b0(preparinginformation.clientnum, bookmark)) {
            last_spawn_time = 0;
            if (isdefined(bookmark.var_cf6a9c68) && isdefined(bookmark.var_cf6a9c68.lastspawntime)) {
                last_spawn_time = bookmark.var_cf6a9c68.lastspawntime;
            }
            preparinginformation.currentevent.starttime = int(max(last_spawn_time, bookmark.time - bookmark.var_a2e574d8.secondsbefore));
            preparinginformation.currentevent.endtime = bookmark.time + bookmark.var_a2e574d8.secondsafter;
            if (preparinginformation.currentevent.endtime <= preparinginformation.currentevent.starttime) {
                function_7650bd13(preparinginformation);
                return;
            }
            preparinginformation.currentevent.priority += function_fd484ab3(bookmark, preparinginformation.var_f5e5e788);
            preparinginformation.currentevent.infoindex = bookmark.var_a2e574d8.index;
            preparinginformation.currentevent.var_6f1176 = 1;
            preparinginformation.currentevent.killcamparams = bookmark.killcamparams;
            preparinginformation.var_f5e5e788 = 1;
            preparinginformation.pendingupdate = 1;
            preparinginformation.updatetime = gettime();
            function_118647ed(bookmark, preparinginformation);
            function_d8f21cd1(bookmark, preparinginformation);
        }
    }
}

// Namespace potm/potm_shared
// Params 2, eflags: 0x4
// Checksum 0x18a9a953, Offset: 0x6be0
// Size: 0x574
function private function_ce1391b0(bookmark, preparinginformation) {
    if (preparinginformation.pendingupdate) {
        if (bookmark.var_a2e574d8.boostpriorityonly && function_e66eb1b0(preparinginformation.clientnum, bookmark) && preparinginformation.currentevent.endtime >= bookmark.time - bookmark.var_a2e574d8.secondsbefore) {
            preparinginformation.currentevent.priority += function_fd484ab3(bookmark, preparinginformation.var_f5e5e788);
            preparinginformation.updatetime = gettime();
            function_1126e4a0(preparinginformation, bookmark);
        } else if (!bookmark.var_a2e574d8.boostpriorityonly && function_e66eb1b0(preparinginformation.clientnum, bookmark) && bookmark.otherclientnum != bookmark.mainclientnum) {
            inflictorentnum = -1;
            if (isdefined(preparinginformation.currentevent.killcamparams) && isdefined(preparinginformation.currentevent.killcamparams.inflictor)) {
                inflictorentnum = preparinginformation.currentevent.killcamparams.inflictor getentitynumber();
            }
            if (inflictorentnum == bookmark.inflictorentnum && abs(preparinginformation.currentevent.starttime + bookmark.var_a2e574d8.secondsbefore - bookmark.time) <= 500) {
                preparinginformation.var_f5e5e788++;
                preparinginformation.currentevent.priority += function_fd484ab3(bookmark, preparinginformation.var_f5e5e788);
                preparinginformation.updatetime = gettime();
                function_118647ed(bookmark, preparinginformation);
            } else {
                clientnum = preparinginformation.clientnum;
                clientxuid = preparinginformation.clientxuid;
                function_603553d5(preparinginformation);
                function_7650bd13(preparinginformation);
                preparinginformation = function_2cb12eec(clientnum, clientxuid);
            }
        }
    }
    if (!preparinginformation.pendingupdate) {
        if (!bookmark.var_a2e574d8.boostpriorityonly && function_e66eb1b0(preparinginformation.clientnum, bookmark) && bookmark.otherclientnum != bookmark.mainclientnum) {
            last_spawn_time = 0;
            if (isdefined(bookmark.var_cf6a9c68) && isdefined(bookmark.var_cf6a9c68.lastspawntime)) {
                last_spawn_time = bookmark.var_cf6a9c68.lastspawntime;
            }
            preparinginformation.currentevent.starttime = int(max(last_spawn_time, bookmark.time - bookmark.var_a2e574d8.secondsbefore));
            preparinginformation.currentevent.endtime = bookmark.time + bookmark.var_a2e574d8.secondsafter;
            preparinginformation.currentevent.killcamparams = bookmark.killcamparams;
            preparinginformation.currentevent.priority += function_fd484ab3(bookmark, preparinginformation.var_f5e5e788);
            preparinginformation.currentevent.infoindex = bookmark.var_a2e574d8.index;
            preparinginformation.currentevent.var_6f1176 = 0;
            preparinginformation.var_f5e5e788 = 1;
            preparinginformation.pendingupdate = 1;
            preparinginformation.updatetime = gettime();
            function_118647ed(bookmark, preparinginformation);
            function_d8f21cd1(bookmark, preparinginformation);
        }
    }
}

// Namespace potm/potm_shared
// Params 2, eflags: 0x4
// Checksum 0xdaccd3f1, Offset: 0x7160
// Size: 0x124
function private function_f20c3684(bookmark, preparinginformation) {
    if (!preparinginformation.pendingupdate) {
        return;
    }
    if (bookmark.time < preparinginformation.currentevent.endtime) {
        preparinginformation.currentevent.endtime = bookmark.time;
        preparinginformation.currentevent.priority -= bookmark.var_a2e574d8.priorityweightperevent / 2;
    }
    if (preparinginformation.currentevent.endtime - preparinginformation.currentevent.starttime >= 1000) {
        clientnum = preparinginformation.clientnum;
        function_603553d5(preparinginformation);
    }
    function_7650bd13(preparinginformation);
}

// Namespace potm/potm_shared
// Params 1, eflags: 0x4
// Checksum 0xb187215e, Offset: 0x7290
// Size: 0xf4
function private function_603553d5(preparinginformation) {
    assert(level.var_68a36291 == 0);
    if (!isdefined(preparinginformation.currentevent) || preparinginformation.currentevent.priority <= 0) {
        return;
    }
    if (preparinginformation.currentevent.endtime > gettime()) {
        println("<dev string:x815>");
        preparinginformation.currentevent.endtime = gettime() - 100;
    }
    array::push(game.var_df6ab56e, preparinginformation, game.var_df6ab56e.size);
    function_2f8c76d9(preparinginformation);
}

// Namespace potm/potm_shared
// Params 2, eflags: 0x4
// Checksum 0x7bedc83d, Offset: 0x7390
// Size: 0xb8
function private function_2cb12eec(clientnum, clientxuid) {
    preparinginformation = spawnstruct();
    preparinginformation.pendingupdate = 0;
    preparinginformation.clientnum = clientnum;
    preparinginformation.clientxuid = clientxuid;
    preparinginformation.var_f5e5e788 = 0;
    preparinginformation.currentevent = {};
    preparinginformation.currentevent.priority = 0;
    array::push(game.var_66c3f03d, preparinginformation, game.var_66c3f03d.size);
    return preparinginformation;
}

// Namespace potm/potm_shared
// Params 1, eflags: 0x4
// Checksum 0xa2f9cd, Offset: 0x7450
// Size: 0x70
function private function_7650bd13(preparinginformation) {
    for (i = 0; i < game.var_66c3f03d.size; i++) {
        if (preparinginformation == game.var_66c3f03d[i]) {
            array::pop(game.var_66c3f03d, i, 0);
            return;
        }
    }
}

// Namespace potm/potm_shared
// Params 1, eflags: 0x4
// Checksum 0x806d0cad, Offset: 0x74c8
// Size: 0xee
function private function_983c204(clientnum) {
    index = undefined;
    for (i = 0; i < game.var_66c3f03d.size; i++) {
        var_3de8dd6c = game.var_66c3f03d[i];
        if (!var_3de8dd6c.pendingupdate) {
            continue;
        }
        if (var_3de8dd6c.clientnum != clientnum) {
            continue;
        }
        if (isdefined(index)) {
            if (var_3de8dd6c.updatetime > game.var_66c3f03d[index].updatetime) {
                index = i;
            }
            continue;
        }
        index = i;
    }
    if (isdefined(index)) {
        return game.var_66c3f03d[index];
    }
    return undefined;
}

// Namespace potm/potm_shared
// Params 4, eflags: 0x4
// Checksum 0x583eff20, Offset: 0x75c0
// Size: 0x124
function private function_a6d1f65d(clientnum, clientxuid, isfirstperson, b_add) {
    for (i = 0; i < game.var_66c3f03d.size; i++) {
        var_3de8dd6c = game.var_66c3f03d[i];
        if (!var_3de8dd6c.pendingupdate) {
            continue;
        }
        if (var_3de8dd6c.clientnum != clientnum) {
            continue;
        }
        if (isdefined(isfirstperson)) {
            if (isdefined(var_3de8dd6c.currentevent.infoindex) && game.highlightreelinfodefines[var_3de8dd6c.currentevent.infoindex].isfirstperson == isfirstperson) {
                return var_3de8dd6c;
            } else {
                continue;
            }
            continue;
        }
        return var_3de8dd6c;
    }
    if (b_add) {
        return function_2cb12eec(clientnum, clientxuid);
    }
    return undefined;
}

// Namespace potm/potm_shared
// Params 1, eflags: 0x4
// Checksum 0xed395e01, Offset: 0x76f0
// Size: 0x9a
function private function_3b17006(preparinginformation) {
    bonussearchtime = 0;
    if (!preparinginformation.pendingupdate) {
        return bonussearchtime;
    }
    if (!preparinginformation.currentevent.var_6f1176) {
        return 1;
    }
    bonussearchtime = min(preparinginformation.var_f5e5e788 * game.var_906314c0, game.var_369adeaf);
    return int(bonussearchtime * 1000);
}

// Namespace potm/potm_shared
// Params 1, eflags: 0x4
// Checksum 0x1f24fc15, Offset: 0x7798
// Size: 0xd6
function private function_7dbf7e42(var_b68903ab) {
    for (i = 0; i < game.var_66c3f03d.size; i++) {
        var_3de8dd6c = game.var_66c3f03d[i];
        thresholdtime = function_3b17006(var_3de8dd6c);
        if (var_b68903ab || var_3de8dd6c.pendingupdate && gettime() - var_3de8dd6c.currentevent.endtime >= thresholdtime) {
            function_603553d5(var_3de8dd6c);
            function_7650bd13(var_3de8dd6c);
        }
    }
}

// Namespace potm/potm_shared
// Params 1, eflags: 0x4
// Checksum 0x517e150a, Offset: 0x7878
// Size: 0x194
function private function_7ce019c9(bookmark) {
    if (!isdefined(bookmark)) {
        return;
    }
    if (function_1af271cd(bookmark.bookmarkname)) {
        do {
            preparinginformation = function_a6d1f65d(bookmark.otherclientnum, bookmark.var_ef6d33b2, undefined, 0);
            if (!isdefined(preparinginformation)) {
                break;
            }
            function_f20c3684(bookmark, preparinginformation);
        } while (true);
    }
    if (bookmark.var_a2e574d8.boostpriorityonly) {
        preparinginformation = function_983c204(bookmark.mainclientnum);
        if (!isdefined(preparinginformation)) {
            println("<dev string:x897>" + bookmark.bookmarkname + "<dev string:x635>");
            return;
        }
    } else {
        preparinginformation = function_a6d1f65d(bookmark.mainclientnum, bookmark.var_77a7bbb9, bookmark.isfirstperson, 1);
    }
    if (bookmark.isfirstperson) {
        function_7baf8b1f(bookmark, preparinginformation);
        return;
    }
    function_ce1391b0(bookmark, preparinginformation);
}

// Namespace potm/potm_shared
// Params 0, eflags: 0x0
// Checksum 0x266d0579, Offset: 0x7a18
// Size: 0x8
function function_91d0caf5() {
    return true;
}

// Namespace potm/potm_shared
// Params 0, eflags: 0x0
// Checksum 0xda7f59ce, Offset: 0x7a28
// Size: 0x6
function function_88226285() {
    return false;
}

// Namespace potm/potm_shared
// Params 0, eflags: 0x0
// Checksum 0xb4aa8024, Offset: 0x7a38
// Size: 0x6
function function_69a46e8d() {
    return false;
}

/#

    // Namespace potm/potm_shared
    // Params 0, eflags: 0x4
    // Checksum 0xb3e75f6, Offset: 0x7a48
    // Size: 0x8c
    function private debuginit() {
        if (!isenabled()) {
            return;
        }
        setdvar(#"scr_potm_debug", 0);
        setdvar(#"scr_potm_debug_print", 0);
        setdvar(#"scr_potm_debug_event_num", 1);
    }

    // Namespace potm/potm_shared
    // Params 1, eflags: 0x4
    // Checksum 0xd2cd48cf, Offset: 0x7ae0
    // Size: 0x4b4
    function private updatedebugmenudata(forceupdate) {
        self endon(#"disconnect");
        level endon(#"game_ended");
        if (!isdefined(level.potmdebugmenu)) {
            return;
        }
        hostplayer = util::gethostplayer();
        menu = level.potmdebugmenu;
        debugeventnum = getdvarint(#"scr_potm_debug_event_num", 0);
        oldestarchivetime = getearliestarchiveclientinfotime();
        hostplayer setluimenudata(menu, #"oldestarchivetime", oldestarchivetime);
        if (isdefined(level.potmdebugeventnum) && level.potmdebugeventnum == debugeventnum && !forceupdate) {
            return;
        }
        level.potmdebugeventnum = debugeventnum;
        infoindex = #"n/a";
        starttime = -1;
        endtime = -1;
        duration = -1;
        priority = -1;
        var_f5e5e788 = 0;
        var_91927f76 = "<dev string:x8b1>";
        var_4cbb60b0 = "<dev string:x8b1>";
        if (debugeventnum - 1 < game.potmevents.size) {
            event = game.potmevents[debugeventnum - 1];
            infoindex = event.currentevent.infoindex;
            starttime = event.currentevent.starttime;
            endtime = event.currentevent.endtime;
            duration = endtime - starttime;
            priority = event.currentevent.priority;
            var_f5e5e788 = event.var_f5e5e788;
            var_91927f76 = function_e99c9288(event);
        }
        hostplayer setluimenudata(menu, #"count", game.potmevents.size);
        hostplayer setluimenudata(menu, #"eventnum", int(debugeventnum));
        hostplayer setluimenudata(menu, #"eventinfoindex", infoindex);
        hostplayer setluimenudata(menu, #"eventstarttime", int(starttime));
        hostplayer setluimenudata(menu, #"eventendtime", int(endtime));
        hostplayer setluimenudata(menu, #"eventduration", int(duration));
        hostplayer setluimenudata(menu, #"scoreeventpriority", int(priority));
        hostplayer setluimenudata(menu, #"hash_752b983964003a68", int(var_f5e5e788));
        hostplayer setluimenudata(menu, #"hash_5935b658727b020c", var_91927f76);
        hostplayer setluimenudata(menu, #"hash_33d80b75d9c6d88d", var_4cbb60b0);
    }

    // Namespace potm/potm_shared
    // Params 0, eflags: 0x4
    // Checksum 0xb2b42958, Offset: 0x7fa0
    // Size: 0xda
    function private updatedebugmenustate() {
        player = util::gethostplayer();
        if (getdvarint(#"scr_potm_debug", 0) == 1) {
            if (!isdefined(level.potmdebugmenu) && isdefined(player)) {
                level.potmdebugmenu = player openluimenu("<dev string:x8b5>");
                return 1;
            }
        } else if (isdefined(level.potmdebugmenu)) {
            player closeluimenu(level.potmdebugmenu);
            level.potmdebugmenu = undefined;
        }
        return 0;
    }

    // Namespace potm/potm_shared
    // Params 0, eflags: 0x0
    // Checksum 0xc71e097f, Offset: 0x8088
    // Size: 0x224
    function debugupdate() {
        if (!isenabled()) {
            return;
        }
        result = updatedebugmenustate();
        updatedebugmenudata(result);
        if (getdvarint(#"scr_force_potm", 0) == 1) {
            level thread waitthennotifyplaypotm();
        }
        if (getdvarint(#"hash_2428eb9c3d05eee0", 0) == 1) {
            level thread waitthennotifyplaypotm();
        }
        if (getdvarint(#"hash_198be770b0735f93", 0) == 1) {
            foreach (player in level.players) {
                player.sessionstate = "<dev string:x8c0>";
                player.spectatorclient = -1;
                player.var_d130517f = 0;
                player.killcamentity = -1;
                player.archivetime = 0;
                player.psoffsettime = 0;
                player.spectatekillcam = 0;
                player stopfollowing();
                player val::reset(#"potm", "<dev string:x8c8>");
            }
            setdvar(#"hash_198be770b0735f93", 0);
        }
    }

#/
