#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\demo_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\hostmigration_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\persistence_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\popups_shared;
#using scripts\core_common\potm_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\sound_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\bb;
#using scripts\mp_common\challenges;
#using scripts\mp_common\gametypes\gametype;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_audio;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_spawn;
#using scripts\mp_common\gametypes\globallogic_utils;
#using scripts\mp_common\gametypes\hostmigration;
#using scripts\mp_common\gametypes\match;
#using scripts\mp_common\gametypes\round;
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\spawnbeacon;
#using scripts\mp_common\userspawnselection;
#using scripts\mp_common\util;

#namespace dom;

// Namespace dom/gametype_init
// Params 1, eflags: 0x40
// Checksum 0xd39d7936, Offset: 0x7c0
// Size: 0x612
function event_handler[gametype_init] main(eventstruct) {
    globallogic::init();
    util::registertimelimit(0, 1440);
    util::registerscorelimit(0, 2000);
    util::registerroundscorelimit(0, 2000);
    util::registerroundlimit(0, 10);
    util::registerroundwinlimit(0, 10);
    util::registerroundswitch(0, 9);
    util::registernumlives(0, 100);
    globallogic::registerfriendlyfiredelay(level.gametype, 15, 0, 1440);
    level.scoreroundwinbased = getgametypesetting(#"cumulativeroundscores") == 0;
    level.overrideteamscore = 1;
    level.var_3626d83c = 1;
    level.onstartgametype = &onstartgametype;
    player::function_b0320e78(&onplayerkilled);
    player::function_74c335a(&function_b794738);
    level.onroundswitch = &on_round_switch;
    level.onendround = &onendround;
    level.var_c9d3723c = &function_4fdb87a6;
    globallogic_spawn::addsupportedspawnpointtype("dom");
    globallogic_audio::set_leader_gametype_dialog("startDomination", "hcStartDomination", "objCapture", "objCapture");
    game.dialog[#"securing_a"] = "domFriendlySecuringA";
    game.dialog[#"securing_b"] = "domFriendlySecuringB";
    game.dialog[#"securing_c"] = "domFriendlySecuringC";
    game.dialog[#"secured_a"] = "domFriendlySecuredA";
    game.dialog[#"secured_b"] = "domFriendlySecuredB";
    game.dialog[#"secured_c"] = "domFriendlySecuredC";
    game.dialog[#"secured_all"] = "domFriendlySecuredAll";
    game.dialog[#"losing_a"] = "domEnemySecuringA";
    game.dialog[#"losing_b"] = "domEnemySecuringB";
    game.dialog[#"losing_c"] = "domEnemySecuringC";
    game.dialog[#"lost_a"] = "domEnemySecuredA";
    game.dialog[#"lost_b"] = "domEnemySecuredB";
    game.dialog[#"lost_c"] = "domEnemySecuredC";
    game.dialog[#"lost_all"] = "domEnemySecuredAll";
    game.dialog[#"enemy_a"] = "domEnemyHasA";
    game.dialog[#"enemy_b"] = "domEnemyHasB";
    game.dialog[#"enemy_c"] = "domEnemyHasC";
    game.dialogtime = [];
    game.dialogtime[#"securing_a"] = 0;
    game.dialogtime[#"securing_b"] = 0;
    game.dialogtime[#"securing_c"] = 0;
    game.dialogtime[#"losing_a"] = 0;
    game.dialogtime[#"losing_b"] = 0;
    game.dialogtime[#"losing_c"] = 0;
    level.var_2c709667 = [];
    level.var_2c709667[#"_a"] = "dom_flag_a";
    level.var_2c709667[#"_b"] = "dom_flag_b";
    level.var_2c709667[#"_c"] = "dom_flag_c";
}

// Namespace dom/dom
// Params 0, eflags: 0x0
// Checksum 0x2860d115, Offset: 0xde0
// Size: 0xb8
function function_3ea60649() {
    foreach (team, _ in level.teams) {
        spawnteam = util::function_82f4ab63(team);
        spawning::add_start_spawn_points(spawnteam, "mp_dom_spawn_" + team + "_start");
    }
}

// Namespace dom/dom
// Params 0, eflags: 0x0
// Checksum 0xefb297e4, Offset: 0xea0
// Size: 0x66
function function_4fdb87a6() {
    spawning::place_spawn_points("mp_dom_spawn_allies_start");
    spawning::place_spawn_points("mp_dom_spawn_axis_start");
    function_3ea60649();
    level.spawn_all = spawning::get_spawnpoint_array("mp_dom_spawn");
}

// Namespace dom/dom
// Params 0, eflags: 0x0
// Checksum 0x8282bf84, Offset: 0xf10
// Size: 0x104
function onstartgametype() {
    level.flagbasefxid = [];
    level.startpos[#"allies"] = level.spawn_start[#"allies"][0].origin;
    level.startpos[#"axis"] = level.spawn_start[#"axis"][0].origin;
    level.b_allow_vehicle_proximity_pickup = 1;
    level thread watchforbflagcap();
    updategametypedvars();
    thread domflags();
    thread updatedomscores();
    level function_25cda323();
}

// Namespace dom/dom
// Params 1, eflags: 0x0
// Checksum 0xb4706c1f, Offset: 0x1020
// Size: 0x11c
function onendround(var_c3d87d03) {
    for (i = 0; i < level.domflags.size; i++) {
        domflag = level.domflags[i];
        if (isdefined(domflag.singleowner) && domflag.singleowner == 1) {
            team = domflag gameobjects::get_owner_team();
            label = domflag gameobjects::get_label();
            challenges::holdflagentirematch(team, label);
        }
        if (isdefined(domflag.var_632f5ac2)) {
            domflag.var_f1bc4543[domflag.var_f1bc4543.size] = gettime() - domflag.var_632f5ac2;
        }
    }
    function_cebd665d(var_c3d87d03);
}

// Namespace dom/dom
// Params 0, eflags: 0x0
// Checksum 0x8f178c2c, Offset: 0x1148
// Size: 0x19a
function setup_zone_exclusions() {
    if (!isdefined(level.var_f3b00249)) {
        return;
    }
    foreach (nullzone in level.var_f3b00249) {
        mindist = 1410065408;
        foundzone = undefined;
        foreach (flag in level.flags) {
            distance = distancesquared(nullzone.origin, flag.origin);
            if (distance < mindist) {
                foundzone = flag;
                mindist = distance;
            }
        }
        if (isdefined(foundzone) && foundzone == self.trigger) {
            if (!isdefined(self.exclusions)) {
                self.exclusions = [];
            }
            self.exclusions[self.exclusions.size] = nullzone;
        }
    }
}

// Namespace dom/dom
// Params 0, eflags: 0x0
// Checksum 0xca80204d, Offset: 0x12f0
// Size: 0x1fa
function updategametypedvars() {
    level.flagcapturetime = getgametypesetting(#"capturetime");
    level.playercapturelpm = getgametypesetting(#"maxplayereventsperminute");
    level.flagcapturelpm = getgametypesetting(#"maxobjectiveeventsperminute");
    level.playeroffensivemax = getgametypesetting(#"maxplayeroffensive");
    level.playerdefensivemax = getgametypesetting(#"maxplayerdefensive");
    level.flagcanbeneutralized = getgametypesetting(#"flagcanbeneutralized");
    level.decayprogress = isdefined(getgametypesetting(#"decayprogress")) ? getgametypesetting(#"decayprogress") : 0;
    level.autodecaytime = isdefined(getgametypesetting(#"autodecaytime")) ? getgametypesetting(#"autodecaytime") : undefined;
    level.flagcapturerateincrease = isdefined(getgametypesetting(#"flagcapturerateincrease")) ? getgametypesetting(#"flagcapturerateincrease") : 0;
}

// Namespace dom/dom
// Params 0, eflags: 0x0
// Checksum 0x71f59748, Offset: 0x14f8
// Size: 0x9e4
function domflags() {
    level.laststatus[#"allies"] = 0;
    level.laststatus[#"axis"] = 0;
    level.flagmodel[#"allies"] = "tag_origin";
    level.flagmodel[#"axis"] = "tag_origin";
    level.flagmodel[#"neutral"] = "tag_origin";
    primaryflags = getentarray("flag_primary", "targetname");
    if (primaryflags.size < 2) {
        println("<dev string:x30>");
        callback::abort_level();
        return;
    }
    level.flags = [];
    foreach (dom_flag in primaryflags) {
        if (isdefined(dom_flag.target)) {
            trigger = getent(dom_flag.target, "targetname");
            trigger trigger::function_5345af18(16);
            if (isdefined(trigger)) {
                trigger.visual = dom_flag;
                trigger.script_label = dom_flag.script_label;
                spawn_beacon::function_8ebadd52(trigger);
            } else {
                /#
                    util::error("<dev string:x5e>" + dom_flag.script_label + "<dev string:x7e>" + dom_flag.target);
                #/
            }
        } else {
            /#
                util::error("<dev string:x5e>" + dom_flag.script_label);
            #/
        }
        if (trigger.script_label == "_a") {
            level.flags[0] = trigger;
            continue;
        }
        if (trigger.script_label == "_b") {
            level.flags[1] = trigger;
            continue;
        }
        if (trigger.script_label == "_c") {
            level.flags[2] = trigger;
            continue;
        }
        /#
            util::error("<dev string:x90>" + trigger.script_label);
        #/
    }
    level.domflags = [];
    for (fi = 0; fi < level.flags.size; fi++) {
        trigger = level.flags[fi];
        trigger.visual setmodel(level.flagmodel[#"neutral"]);
        name = #"dom" + trigger.visual.script_label;
        visuals = [];
        visuals[0] = trigger.visual;
        domflag = gameobjects::create_use_object(#"neutral", trigger, visuals, (0, 0, 0), name);
        domflag gameobjects::allow_use(#"enemy");
        if (level.flagcanbeneutralized) {
            domflag gameobjects::set_use_time(level.flagcapturetime / 2);
        } else {
            domflag gameobjects::set_use_time(level.flagcapturetime);
        }
        domflag gameobjects::set_use_text(#"mp/capturing_flag");
        label = domflag gameobjects::get_label();
        domflag.label = label;
        domflag.flagindex = trigger.visual.script_index;
        domflag gameobjects::set_visible_team(#"any");
        domflag.onuse = &onuse;
        domflag.onbeginuse = &onbeginuse;
        domflag.onuseupdate = &onuseupdate;
        domflag.onenduse = &onenduse;
        domflag.onupdateuserate = &onupdateuserate;
        domflag.ondecaycomplete = &ondecaycomplete;
        domflag.hasbeencaptured = 0;
        domflag.var_c518b47a = !level.flagcapturerateincrease;
        domflag.decayprogress = level.decayprogress;
        domflag.autodecaytime = level.autodecaytime;
        domflag.currentlyunoccupied = 1;
        domflag.ontouchuse = &on_touch_use;
        if (domflag.decayprogress) {
            domflag gameobjects::must_maintain_claim(0);
            if (level.flagcanbeneutralized) {
                domflag gameobjects::set_decay_time(level.flagcapturetime / 2);
            } else {
                domflag gameobjects::set_decay_time(level.flagcapturetime);
            }
        }
        domflag gameobjects::set_objective_entity(visuals[0]);
        domflag gameobjects::set_owner_team(#"neutral");
        tracestart = visuals[0].origin + (0, 0, 32);
        traceend = visuals[0].origin + (0, 0, -32);
        trace = bullettrace(tracestart, traceend, 0, undefined);
        upangles = vectortoangles(trace[#"normal"]);
        domflag.baseeffectforward = anglestoforward(upangles);
        domflag.baseeffectright = anglestoright(upangles);
        domflag.baseeffectpos = trace[#"position"];
        trigger.useobj = domflag;
        trigger.adjflags = [];
        trigger.nearbyspawns = [];
        domflag.levelflag = trigger;
        domflag.var_f1bc4543 = [];
        domflag setup_zone_exclusions();
        level.domflags[level.domflags.size] = domflag;
    }
    level.bestspawnflag = [];
    level.bestspawnflag[#"allies"] = getunownedflagneareststart(#"allies", undefined);
    level.bestspawnflag[#"axis"] = getunownedflagneareststart(#"axis", level.bestspawnflag[#"allies"]);
    for (index = 0; index < level.domflags.size; index++) {
        level.domflags[index] createflagspawninfluencers();
    }
    flagsetup();
    /#
        thread domdebug();
    #/
}

// Namespace dom/dom
// Params 2, eflags: 0x0
// Checksum 0xe71a8f10, Offset: 0x1ee8
// Size: 0x122
function getunownedflagneareststart(team, excludeflag) {
    best = undefined;
    bestdistsq = undefined;
    for (i = 0; i < level.flags.size; i++) {
        flag = level.flags[i];
        if (flag getflagteam() != #"neutral") {
            continue;
        }
        distsq = distancesquared(flag.origin, level.startpos[team]);
        if ((!isdefined(excludeflag) || flag != excludeflag) && (!isdefined(best) || distsq < bestdistsq)) {
            bestdistsq = distsq;
            best = flag;
        }
    }
    return best;
}

/#

    // Namespace dom/dom
    // Params 0, eflags: 0x0
    // Checksum 0x31be6467, Offset: 0x2018
    // Size: 0x274
    function domdebug() {
        while (true) {
            if (getdvarint(#"scr_domdebug", 0) != 1) {
                wait 2;
                continue;
            }
            while (true) {
                if (getdvarint(#"scr_domdebug", 0) != 1) {
                    break;
                }
                for (i = 0; i < level.flags.size; i++) {
                    for (j = 0; j < level.flags[i].adjflags.size; j++) {
                        line(level.flags[i].origin, level.flags[i].adjflags[j].origin, (1, 1, 1));
                    }
                    for (j = 0; j < level.flags[i].nearbyspawns.size; j++) {
                        line(level.flags[i].origin, level.flags[i].nearbyspawns[j].origin, (0.2, 0.2, 0.6));
                    }
                    if (level.flags[i] == level.bestspawnflag[#"allies"]) {
                        print3d(level.flags[i].origin, "<dev string:xa4>");
                    }
                    if (level.flags[i] == level.bestspawnflag[#"axis"]) {
                        print3d(level.flags[i].origin, "<dev string:xbb>");
                    }
                }
                waitframe(1);
            }
        }
    }

#/

// Namespace dom/dom
// Params 1, eflags: 0x0
// Checksum 0x76aca8e0, Offset: 0x2298
// Size: 0xf6
function onbeginuse(sentient) {
    ownerteam = self gameobjects::get_owner_team();
    self.didstatusnotify = 0;
    if (ownerteam == #"allies") {
        otherteam = #"axis";
    } else {
        otherteam = #"allies";
    }
    if (ownerteam == #"neutral") {
        otherteam = util::getotherteam(sentient.team);
        statusdialog("securing" + self.label, sentient.team, "objective" + self.label);
        return;
    }
}

// Namespace dom/dom
// Params 3, eflags: 0x0
// Checksum 0xf2ebfd7e, Offset: 0x2398
// Size: 0x2d2
function onuseupdate(team, progress, change) {
    if (change > 0) {
        self gameobjects::set_flags(team == "allies" ? 1 : 2);
    }
    if (progress > 0.05 && change && !self.didstatusnotify) {
        ownerteam = self gameobjects::get_owner_team();
        if (ownerteam == #"neutral") {
            otherteam = util::getotherteam(team);
            statusdialog("securing" + self.label, team, "objective" + self.label);
        } else {
            statusdialog("losing" + self.label, ownerteam, "objective" + self.label);
            statusdialog("securing" + self.label, team, "objective" + self.label);
            globallogic_audio::flush_objective_dialog("objective_all");
        }
        self.didstatusnotify = 1;
    }
    if (change > 0 && self.currentlyunoccupied) {
        self.currentlyunoccupied = 0;
        players = getplayers();
        foreach (player in players) {
            if (player.team == team) {
                player playsoundtoplayer(#"hash_3cca41b3702f764a", player);
                continue;
            }
            player playsoundtoplayer(#"hash_2bb2a0ec776ba8f7", player);
        }
        return;
    }
    if (change == 0 && !self.currentlyunoccupied) {
        self.currentlyunoccupied = 1;
    }
}

// Namespace dom/dom
// Params 0, eflags: 0x0
// Checksum 0x5ad62ed3, Offset: 0x2678
// Size: 0x140
function ondecaycomplete() {
    team = self.ownerteam;
    enemyteam = util::get_enemy_team(team);
    if (self.touchlist[enemyteam].size == 0 && self.touchlist[team].size > 0) {
        self.var_e6e0f0c6 = 1;
        foreach (st in self.touchlist[team]) {
            player_from_touchlist = gameobjects::function_4de10422(self.touchlist[team], st);
            if (!isdefined(player_from_touchlist)) {
                continue;
            }
            scoreevents::processscoreevent(#"hash_7edabe01ed05afa3", player_from_touchlist, undefined, undefined);
        }
    }
}

// Namespace dom/dom
// Params 0, eflags: 0x0
// Checksum 0xc353ed8d, Offset: 0x27c0
// Size: 0x4c
function flushobjectiveflagdialog() {
    globallogic_audio::flush_objective_dialog("objective_a");
    globallogic_audio::flush_objective_dialog("objective_b");
    globallogic_audio::flush_objective_dialog("objective_c");
}

// Namespace dom/dom
// Params 3, eflags: 0x0
// Checksum 0x2baccdbb, Offset: 0x2818
// Size: 0xe4
function statusdialog(dialog, team, objectivekey) {
    dialogtime = game.dialogtime[dialog];
    if (isdefined(dialogtime)) {
        time = gettime();
        if (dialogtime > time) {
            return;
        }
        game.dialogtime[dialog] = time + 10000;
    }
    dialogkey = game.dialog[dialog];
    if (isdefined(objectivekey)) {
        if (objectivekey != "objective_all") {
            dialogbufferkey = "domPointDialogBuffer";
        }
    }
    globallogic_audio::leader_dialog(dialogkey, team, undefined, objectivekey, undefined, dialogbufferkey);
}

// Namespace dom/dom
// Params 3, eflags: 0x0
// Checksum 0x8efae499, Offset: 0x2908
// Size: 0x5a
function onenduse(team, player, success) {
    if (!success) {
        globallogic_audio::flush_objective_dialog("objective" + self.label);
    }
    self.currentlyunoccupied = 1;
}

// Namespace dom/dom
// Params 1, eflags: 0x0
// Checksum 0x6269aa74, Offset: 0x2970
// Size: 0x1e4
function flagcapturedfromneutral(team) {
    self.singleowner = 1;
    otherteam = util::getotherteam(team);
    thread util::printandsoundoneveryone(team, undefined, #"", undefined, "mp_war_objective_taken");
    thread sound::play_on_players("mus_dom_captured" + "_" + level.teampostfix[team]);
    if (getteamflagcount(team) == level.flags.size) {
        statusdialog("secured_all", team, "objective_all");
        statusdialog("lost_all", otherteam, "objective_all");
        flushobjectiveflagdialog();
    } else {
        statusdialog("secured" + self.label, team, "objective" + self.label);
        statusdialog(#"enemy" + self.label, otherteam, "objective" + self.label);
        globallogic_audio::flush_objective_dialog("objective_all");
    }
    globallogic_audio::play_2d_on_team("mpl_flagcapture_sting_enemy", otherteam);
    globallogic_audio::play_2d_on_team("mpl_flagcapture_sting_friend", team);
}

// Namespace dom/dom
// Params 2, eflags: 0x0
// Checksum 0x2ac8c20f, Offset: 0x2b60
// Size: 0x21e
function flagcapturedfromteam(team, oldteam) {
    self.singleowner = 0;
    thread util::printandsoundoneveryone(team, oldteam, #"", #"", "mp_war_objective_taken", "mp_war_objective_lost", "");
    if (getteamflagcount(team) == level.flags.size) {
        statusdialog("secured_all", team, "objective_all");
        statusdialog("lost_all", oldteam, "objective_all");
        flushobjectiveflagdialog();
    } else {
        statusdialog("secured" + self.label, team, "objective" + self.label);
        if (randomint(2)) {
            statusdialog("lost" + self.label, oldteam, "objective" + self.label);
        } else {
            statusdialog(#"enemy" + self.label, oldteam, "objective" + self.label);
        }
        globallogic_audio::flush_objective_dialog("objective_all");
        globallogic_audio::play_2d_on_team("mpl_flagcapture_sting_enemy", oldteam);
        globallogic_audio::play_2d_on_team("mpl_flagcapture_sting_friend", team);
    }
    level.bestspawnflag[oldteam] = self.levelflag;
}

// Namespace dom/dom
// Params 2, eflags: 0x0
// Checksum 0x34c33644, Offset: 0x2d88
// Size: 0x144
function flagneutralized(team, oldteam) {
    self.singleowner = 1;
    thread util::printandsoundoneveryone(#"neutral", oldteam, #"", #"", "mp_war_objective_neutralized", "mp_war_objective_lost", "");
    if (getteamflagcount(team) == level.flags.size) {
        statusdialog("lost_all", oldteam, "objective_all");
        flushobjectiveflagdialog();
        return;
    }
    statusdialog("lost" + self.label, oldteam, "objective" + self.label);
    globallogic_audio::flush_objective_dialog("objective_all");
    globallogic_audio::play_2d_on_team("mpl_flagcapture_sting_enemy", oldteam);
}

// Namespace dom/dom
// Params 2, eflags: 0x0
// Checksum 0x8cd60c17, Offset: 0x2ed8
// Size: 0x226
function getdomflagusestring(label, neutralized) {
    string = #"";
    if (neutralized) {
        switch (label) {
        case #"_a":
            string = #"hash_3ff1c88b4360ea84";
            break;
        case #"_b":
            string = #"hash_dd6191acefd6847";
            break;
        case #"_c":
            string = #"hash_25a2a0aff40c76aa";
            break;
        case #"_d":
            string = #"hash_2bcd7171f9aae4a5";
            break;
        case #"_e":
            string = #"hash_5334d65b46b55660";
            break;
        default:
            break;
        }
    } else {
        switch (label) {
        case #"_a":
            string = #"hash_5b47de31c97a49ff";
            break;
        case #"_b":
            string = #"hash_481e5e34f798331e";
            break;
        case #"_c":
            string = #"hash_6a0c2383d37849bd";
            break;
        case #"_d":
            string = #"hash_5079687d6a87790c";
            break;
        case #"_e":
            string = #"hash_78e2a90cf85daa3b";
            break;
        default:
            break;
        }
    }
    return string;
}

// Namespace dom/dom
// Params 1, eflags: 0x0
// Checksum 0x4ddfbec9, Offset: 0x3108
// Size: 0x44c
function onusewithneutralizingflag(sentient) {
    team = sentient.team;
    oldteam = self gameobjects::get_owner_team();
    label = self gameobjects::get_label();
    /#
        print("<dev string:xd0>" + self.label);
    #/
    level.usestartspawns = 0;
    assert(team != #"neutral");
    string = #"";
    if (oldteam == #"neutral") {
        level notify(#"flag_captured");
        string = getdomflagusestring(label, 0);
        level.bestspawnflag[oldteam] = self.levelflag;
        self gameobjects::set_owner_team(team);
        self.visuals[0] setmodel(level.flagmodel[team]);
        self update_spawn_influencers(team);
        self flagcapturedfromneutral(team);
    } else {
        level notify(#"flag_neutralized");
        string = getdomflagusestring(label, 1);
        self gameobjects::set_owner_team(#"neutral");
        self.visuals[0] setmodel(level.flagmodel[#"neutral"]);
        self update_spawn_influencers(#"neutral");
        self flagneutralized(team, oldteam);
    }
    assert(string != #"");
    touchlist = arraycopy(self.touchlist[team]);
    isbflag = 0;
    if (label == "_b") {
        isbflag = 1;
    }
    if (oldteam == #"neutral") {
        if (isdefined(getgametypesetting(#"contributioncapture")) && getgametypesetting(#"contributioncapture")) {
            var_17a75d13 = arraycopy(self.var_17a75d13[team]);
            self thread function_37dbf0d5(var_17a75d13, string, oldteam, isbflag, 0);
        } else {
            thread give_capture_credit(touchlist, string, oldteam, isbflag, 1);
        }
    } else {
        thread give_neutralized_credit(touchlist, string, oldteam, isbflag);
    }
    bb::function_9cca214a("dom_capture", label, team, sentient.origin);
    if (dominated_challenge_check()) {
        level thread totaldomination(team);
    }
}

// Namespace dom/dom
// Params 1, eflags: 0x0
// Checksum 0x89bfe621, Offset: 0x3560
// Size: 0x394
function onusewithoutneutralizingflag(sentient) {
    level notify(#"flag_captured");
    team = sentient.team;
    oldteam = self gameobjects::get_owner_team();
    label = self gameobjects::get_label();
    /#
        print("<dev string:xd0>" + self.label);
    #/
    self gameobjects::set_owner_team(team);
    self.visuals[0] setmodel(level.flagmodel[team]);
    level.usestartspawns = 0;
    assert(team != #"neutral");
    isbflag = 0;
    if (label == "_b") {
        isbflag = 1;
    }
    string = getdomflagusestring(label, 0);
    assert(string != #"");
    if (isdefined(getgametypesetting(#"contributioncapture")) && getgametypesetting(#"contributioncapture")) {
        var_17a75d13 = arraycopy(self.var_17a75d13[team]);
        self thread function_37dbf0d5(var_17a75d13, string, oldteam, isbflag, 0);
    } else {
        touchlist = arraycopy(self.touchlist[team]);
        thread give_capture_credit(touchlist, string, oldteam, isbflag, 0);
    }
    bb::function_9cca214a("dom_capture", undefined, team, sentient.origin);
    if (oldteam == #"neutral") {
        self flagcapturedfromneutral(team);
        self.firstcapture = gettime();
        self.var_8aa0f613 = 1;
        self.var_632f5ac2 = gettime();
    } else {
        self flagcapturedfromteam(team, oldteam);
        self.var_f1bc4543[self.var_f1bc4543.size] = gettime() - self.var_632f5ac2;
        self.var_632f5ac2 = gettime();
        self.var_8aa0f613++;
    }
    if (dominated_challenge_check()) {
        level thread totaldomination(team);
        util::function_d1f9db00(25, team);
    }
    self update_spawn_influencers(team);
}

// Namespace dom/dom
// Params 1, eflags: 0x0
// Checksum 0xa56cf33d, Offset: 0x3900
// Size: 0xd4
function onuse(sentient) {
    if (level.flagcanbeneutralized) {
        self onusewithneutralizingflag(sentient);
    } else {
        self onusewithoutneutralizingflag(sentient);
    }
    var_3a58aa96 = 3;
    if (self.label == "_a") {
        var_3a58aa96 = 1;
    } else if (self.label == "_b") {
        var_3a58aa96 = 2;
    }
    util::function_d1f9db00(20, sentient.team, -1, var_3a58aa96);
    level function_25cda323();
}

// Namespace dom/dom
// Params 1, eflags: 0x0
// Checksum 0xc40152ab, Offset: 0x39e0
// Size: 0x54
function totaldomination(team) {
    level endon(#"flag_captured");
    level endon(#"game_ended");
    wait 180;
    challenges::totaldomination(team);
}

// Namespace dom/dom
// Params 0, eflags: 0x0
// Checksum 0x6c375624, Offset: 0x3a40
// Size: 0x90
function watchforbflagcap() {
    level endon(#"game_ended");
    level endon(#"endwatchforbflagcapaftertime");
    level thread endwatchforbflagcapaftertime(60);
    for (;;) {
        waitresult = level waittill(#"b_flag_captured");
        waitresult.player challenges::capturedbfirstminute();
    }
}

// Namespace dom/dom
// Params 1, eflags: 0x0
// Checksum 0xef6e5b57, Offset: 0x3ad8
// Size: 0x40
function endwatchforbflagcapaftertime(time) {
    level endon(#"game_ended");
    wait 60;
    level notify(#"endwatchforbflagcapaftertime");
}

// Namespace dom/dom
// Params 5, eflags: 0x0
// Checksum 0x959eb9aa, Offset: 0x3b20
// Size: 0x304
function function_37dbf0d5(var_17a75d13, string, lastownerteam, isbflag, neutralizing) {
    time = gettime();
    waitframe(1);
    util::waittillslowprocessallowed();
    self updatecapsperminute(lastownerteam);
    var_dbec024d = [];
    earliestplayer = undefined;
    foreach (contribution in var_17a75d13) {
        if (isdefined(contribution)) {
            contributor = contribution.player;
            if (isdefined(contributor) && isdefined(contribution.contribution)) {
                percentage = 100 * contribution.contribution / self.usetime;
                contributor.var_7709e43f = int(0.5 + percentage);
                contributor.var_213804be = contribution.starttime;
                if (percentage < getgametypesetting(#"contributionmin")) {
                    continue;
                }
                if (contribution.var_664a1806 && (!isdefined(earliestplayer) || contributor.var_213804be < earliestplayer.var_213804be)) {
                    earliestplayer = contributor;
                }
                if (!isdefined(var_dbec024d)) {
                    var_dbec024d = [];
                } else if (!isarray(var_dbec024d)) {
                    var_dbec024d = array(var_dbec024d);
                }
                var_dbec024d[var_dbec024d.size] = contributor;
            }
        }
    }
    foreach (player in var_dbec024d) {
        var_5bda891e = earliestplayer === player;
        credit_player(player, string, lastownerteam, isbflag, neutralizing, time, var_5bda891e);
    }
    self gameobjects::function_1aca7f5();
}

// Namespace dom/dom
// Params 5, eflags: 0x0
// Checksum 0x63ae59e9, Offset: 0x3e30
// Size: 0x120
function give_capture_credit(touchlist, string, lastownerteam, isbflag, neutralizing) {
    time = gettime();
    waitframe(1);
    util::waittillslowprocessallowed();
    self updatecapsperminute(lastownerteam);
    foreach (touch in touchlist) {
        player_from_touchlist = gameobjects::function_4de10422(touchlist, touch);
        if (!isdefined(player_from_touchlist)) {
            continue;
        }
        credit_player(player_from_touchlist, string, lastownerteam, isbflag, neutralizing, time, 0);
    }
}

// Namespace dom/dom
// Params 7, eflags: 0x0
// Checksum 0x3cf7e751, Offset: 0x3f58
// Size: 0x414
function credit_player(player, string, lastownerteam, isbflag, neutralizing, time, var_5bda891e) {
    player updatecapsperminute(lastownerteam);
    if (!isscoreboosting(player, self)) {
        player challenges::capturedobjective(time, self.levelflag);
        if (lastownerteam == #"neutral" && neutralizing && isdefined(self.hasbeencaptured) && self.hasbeencaptured) {
            scoreevents::processscoreevent(#"dom_point_secured_neutralizing", player, undefined, undefined);
        } else if (lastownerteam == #"neutral") {
            if (isbflag) {
                scoreevents::processscoreevent(#"neutral_b_secured", player, undefined, undefined);
            } else {
                scoreevents::processscoreevent(#"dom_point_neutral_secured", player, undefined, undefined);
            }
        } else {
            scoreevents::processscoreevent(#"dom_point_secured", player, undefined, undefined);
        }
        self.hasbeencaptured = 1;
        player recordgameevent("capture");
        if (isbflag) {
            level notify(#"b_flag_captured", {#player:player});
        }
        if (isdefined(player.pers[#"captures"])) {
            player.pers[#"captures"]++;
            player.captures = player.pers[#"captures"];
        }
        player.pers[#"objectives"]++;
        player.objectives = player.pers[#"objectives"];
        demo::bookmark(#"event", gettime(), player);
        potm::bookmark(#"event", gettime(), player);
        player stats::function_2dabbec7(#"captures", 1);
        player globallogic_score::incpersstat("objectiveScore", 1, 0, 1);
        if (isdefined(getgametypesetting(#"contributioncapture")) && getgametypesetting(#"contributioncapture")) {
            player luinotifyevent(#"waypoint_captured", 2, self.var_977e04c1, player.var_7709e43f);
            player.var_7709e43f = undefined;
        }
    } else {
        /#
            player iprintlnbold("<dev string:xe0>");
        #/
    }
    if (var_5bda891e) {
        level thread popups::displayteammessagetoall(string, player);
    }
}

// Namespace dom/dom
// Params 4, eflags: 0x0
// Checksum 0x88fa71a2, Offset: 0x4378
// Size: 0x248
function give_neutralized_credit(touchlist, string, lastownerteam, isbflag) {
    time = gettime();
    waitframe(1);
    util::waittillslowprocessallowed();
    foreach (touch in touchlist) {
        player_from_touchlist = gameobjects::function_4de10422(touchlist, touch);
        if (!isdefined(player_from_touchlist)) {
            continue;
        }
        player_from_touchlist updatecapsperminute(lastownerteam);
        if (!isscoreboosting(player_from_touchlist, self)) {
            scoreevents::processscoreevent(#"dom_point_neutralized_neutralizing", player_from_touchlist, undefined, undefined);
            player_from_touchlist recordgameevent("neutralized");
            if (isdefined(player_from_touchlist.pers[#"neutralizes"])) {
                player_from_touchlist.pers[#"neutralizes"]++;
                player_from_touchlist.captures = player_from_touchlist.pers[#"neutralizes"];
            }
            demo::bookmark(#"event", gettime(), player_from_touchlist);
            potm::bookmark(#"event", gettime(), player_from_touchlist);
        } else {
            /#
                player_from_touchlist iprintlnbold("<dev string:xe0>");
            #/
        }
        level thread popups::displayteammessagetoall(string, player_from_touchlist);
    }
}

// Namespace dom/dom
// Params 0, eflags: 0x0
// Checksum 0x816e3a50, Offset: 0x45c8
// Size: 0x5b0
function updatedomscores() {
    if (level.roundscorelimit && !level.timelimit) {
        warningscore = max(0, level.roundscorelimit - 12);
    } else {
        warningscore = 0;
    }
    playednearendvo = 0;
    alliesroundstartscore = [[ level._getteamscore ]](#"allies");
    axisroundstartscore = [[ level._getteamscore ]](#"axis");
    while (!level.gameended) {
        numownedflags = 0;
        scoring_teams = [];
        round_score_limit = util::get_current_round_score_limit();
        totalflags = getteamflagcount(#"allies") + getteamflagcount(#"axis");
        if (totalflags == 3 && game.stat[#"teamscores"][#"allies"] == round_score_limit - 1 && game.stat[#"teamscores"][#"axis"] == round_score_limit - 1) {
            level.clampscorelimit = 0;
        }
        numflags = getteamflagcount(#"allies");
        numownedflags += numflags;
        if (numflags) {
            scoring_teams[scoring_teams.size] = #"allies";
            globallogic_score::giveteamscoreforobjective_delaypostprocessing(#"allies", numflags);
        }
        numflags = getteamflagcount(#"axis");
        numownedflags += numflags;
        if (numflags) {
            scoring_teams[scoring_teams.size] = #"axis";
            globallogic_score::giveteamscoreforobjective_delaypostprocessing(#"axis", numflags);
        }
        if (numownedflags) {
            globallogic_score::postprocessteamscores(scoring_teams);
        }
        if (warningscore && !playednearendvo) {
            winningteam = undefined;
            alliesroundscore = [[ level._getteamscore ]](#"allies") - alliesroundstartscore;
            axisroundscore = [[ level._getteamscore ]](#"axis") - axisroundstartscore;
            if (alliesroundscore >= warningscore) {
                winningteam = #"allies";
            } else if (axisroundscore >= warningscore) {
                winningteam = #"axis";
            }
            if (isdefined(winningteam)) {
                nearwinning = "nearWinning";
                nearlosing = "nearLosing";
                if (util::isoneround() || util::islastround()) {
                    nearwinning = "nearWinningFinal";
                    nearlosing = "nearLosingFinal";
                } else {
                    if (randomint(4) < 3) {
                        nearwinning = "nearWinningFinal";
                    }
                    if (randomint(4) < 1) {
                        nearlosing = "nearLosingFinal";
                    }
                }
                globallogic_audio::leader_dialog(nearwinning, winningteam);
                globallogic_audio::leader_dialog_for_other_teams(nearlosing, winningteam);
                playednearendvo = 1;
            }
        }
        onscoreclosemusic();
        timepassed = globallogic_utils::gettimepassed();
        if ((float(timepassed) / 1000 > 120 && numownedflags < 2 || float(timepassed) / 1000 > 300 && numownedflags < 3) && gamemodeismode(0)) {
            round::set_flag("tie");
            thread globallogic::end_round(0);
            return;
        }
        wait 5;
        hostmigration::waittillhostmigrationdone();
    }
}

// Namespace dom/dom
// Params 0, eflags: 0x0
// Checksum 0x34a43c9e, Offset: 0x4b80
// Size: 0x35e
function onscoreclosemusic() {
    axisscore = [[ level._getteamscore ]](#"axis");
    alliedscore = [[ level._getteamscore ]](#"allies");
    scorelimit = level.scorelimit;
    scorethreshold = scorelimit * 0.1;
    scoredif = abs(axisscore - alliedscore);
    scorethresholdstart = abs(scorelimit - scorethreshold);
    scorelimitcheck = scorelimit - 10;
    if (!isdefined(level.playingactionmusic)) {
        level.playingactionmusic = 0;
    }
    if (!isdefined(level.sndhalfway)) {
        level.sndhalfway = 0;
    }
    if (alliedscore > axisscore) {
        currentscore = alliedscore;
    } else {
        currentscore = axisscore;
    }
    /#
        if (getdvarint(#"debug_music", 0) > 0) {
            println("<dev string:x125>" + scoredif);
            println("<dev string:x149>" + axisscore);
            println("<dev string:x16e>" + alliedscore);
            println("<dev string:x195>" + scorelimit);
            println("<dev string:x1bb>" + currentscore);
            println("<dev string:x1e3>" + scorethreshold);
            println("<dev string:x125>" + scoredif);
            println("<dev string:x20d>" + scorethresholdstart);
        }
    #/
    if (scoredif <= scorethreshold && scorethresholdstart <= currentscore && level.playingactionmusic != 1) {
    }
    halfwayscore = scorelimit * 0.5;
    if (isdefined(level.roundscorelimit)) {
        halfwayscore = level.roundscorelimit * 0.5;
        if (game.roundsplayed == 1) {
            halfwayscore += level.roundscorelimit;
        }
    }
    if ((axisscore >= halfwayscore || alliedscore >= halfwayscore) && !level.sndhalfway) {
        level notify(#"sndmusichalfway");
        level.sndhalfway = 1;
    }
}

// Namespace dom/dom
// Params 0, eflags: 0x0
// Checksum 0x3c7b3084, Offset: 0x4ee8
// Size: 0xb0
function on_round_switch() {
    gametype::on_round_switch();
    if (level.scoreroundwinbased) {
        [[ level._setteamscore ]](#"allies", game.stat[#"roundswon"][#"allies"]);
        [[ level._setteamscore ]](#"axis", game.stat[#"roundswon"][#"axis"]);
    }
}

// Namespace dom/dom
// Params 4, eflags: 0x0
// Checksum 0x9379d30e, Offset: 0x4fa0
// Size: 0xb6c
function function_b794738(einflictor, victim, idamage, weapon) {
    attacker = self;
    if (isdefined(weapon) && isdefined(level.iskillstreakweapon)) {
        if ([[ level.iskillstreakweapon ]](weapon) || isdefined(weapon.statname) && [[ level.iskillstreakweapon ]](getweapon(weapon.statname))) {
            return;
        }
    }
    foreach (flag in level.flags) {
        if (isdefined(einflictor) && isdefined(attacker) && einflictor != attacker) {
            var_2453d80f = (flag.radius + 350) * (flag.radius + 350);
            dist = distance2dsquared(einflictor.origin, flag.origin);
            if (dist < var_2453d80f) {
                awardscore = 1;
            } else {
                continue;
            }
        } else {
            awardscore = 1;
        }
        victim thread globallogic_score::function_93736d46(einflictor, attacker, weapon, flag, flag.radius, flag.useobj.ownerteam, flag.useobj);
    }
    if (!(isdefined(awardscore) && awardscore)) {
        return;
    }
    if (isdefined(attacker) && isplayer(attacker)) {
        scoreeventprocessed = isdefined(attacker.var_d1fa9d67) && attacker.var_d1fa9d67;
        if (!scoreeventprocessed && isdefined(attacker.touchtriggers) && attacker.touchtriggers.size && attacker.pers[#"team"] != victim.pers[#"team"]) {
            triggerids = getarraykeys(attacker.touchtriggers);
            ownerteam = attacker.touchtriggers[triggerids[0]].useobj.ownerteam;
            team = attacker.pers[#"team"];
            if (team != ownerteam) {
                scoreevents::processscoreevent(#"kill_enemy_while_capping_dom", attacker, victim, weapon);
                attacker.pers[#"objectiveekia"]++;
                attacker.objectiveekia = attacker.pers[#"objectiveekia"];
                attacker.pers[#"objectives"]++;
                attacker.objectives = attacker.pers[#"objectives"];
                scoreeventprocessed = 1;
            }
        }
        for (index = 0; index < level.flags.size; index++) {
            flagteam = "invalidTeam";
            inflagzone = 0;
            defendedflag = 0;
            offendedflag = 0;
            flagorigin = level.flags[index].origin;
            offenseradiussq = level.flags[index].radius * level.flags[index].radius;
            dist = distance2dsquared(victim.origin, flagorigin);
            if (dist < offenseradiussq) {
                inflagzone = 1;
                if (level.flags[index] getflagteam() == attacker.pers[#"team"] || level.flags[index] getflagteam() == #"neutral") {
                    defendedflag = 1;
                } else {
                    offendedflag = 1;
                }
            }
            dist = distance2dsquared(attacker.origin, flagorigin);
            if (dist < offenseradiussq) {
                inflagzone = 1;
                if (level.flags[index] getflagteam() == attacker.pers[#"team"] || level.flags[index] getflagteam() == #"neutral") {
                    defendedflag = 1;
                } else {
                    offendedflag = 1;
                }
            }
            if (inflagzone && isplayer(attacker) && attacker.pers[#"team"] != victim.pers[#"team"]) {
                if (offendedflag) {
                    if (!isdefined(attacker.dom_defends)) {
                        attacker.dom_defends = 0;
                    }
                    attacker.dom_defends++;
                    if (level.playerdefensivemax >= attacker.dom_defends) {
                        attacker thread challenges::killedbasedefender(level.flags[index]);
                        if (!scoreeventprocessed) {
                            scoreevents::processscoreevent(#"killed_defender", attacker, victim, weapon);
                            attacker.pers[#"objectiveekia"]++;
                            attacker.objectiveekia = attacker.pers[#"objectiveekia"];
                            attacker.pers[#"objectives"]++;
                            attacker.objectives = attacker.pers[#"objectives"];
                        }
                        victim recordkillmodifier("defending");
                        break;
                    } else {
                        /#
                            attacker iprintlnbold("<dev string:x23c>");
                        #/
                    }
                }
                if (defendedflag) {
                    if (!isdefined(attacker.dom_offends)) {
                        attacker.dom_offends = 0;
                    }
                    attacker thread updateattackermultikills();
                    attacker.dom_offends++;
                    if (level.playeroffensivemax >= attacker.dom_offends) {
                        attacker.pers[#"defends"]++;
                        attacker.defends = attacker.pers[#"defends"];
                        attacker thread challenges::killedbaseoffender(level.flags[index], weapon);
                        attacker recordgameevent("return");
                        attacker challenges::killedzoneattacker(weapon);
                        if (!scoreeventprocessed) {
                            scoreevents::processscoreevent(#"killed_attacker", attacker, victim, weapon);
                            attacker.pers[#"objectiveekia"]++;
                            attacker.objectiveekia = attacker.pers[#"objectiveekia"];
                            attacker.pers[#"objectives"]++;
                            attacker.objectives = attacker.pers[#"objectives"];
                        }
                        victim recordkillmodifier("assaulting");
                        break;
                    }
                    /#
                        attacker iprintlnbold("<dev string:x283>");
                    #/
                }
            }
        }
        if (isdefined(victim.touchtriggers) && victim.touchtriggers.size && attacker.pers[#"team"] != victim.pers[#"team"]) {
            triggerids = getarraykeys(victim.touchtriggers);
            ownerteam = victim.touchtriggers[triggerids[0]].useobj.ownerteam;
            team = victim.pers[#"team"];
            if (team != ownerteam) {
                flag = victim.touchtriggers[triggerids[0]].useobj;
                if (isdefined(flag.contested) && flag.contested == 1) {
                    attacker killwhilecontesting(flag);
                }
            }
        }
    }
}

// Namespace dom/dom
// Params 9, eflags: 0x0
// Checksum 0x9a903bfc, Offset: 0x5b18
// Size: 0x1ca
function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    if (isdefined(weapon) && isdefined(level.iskillstreakweapon)) {
        if ([[ level.iskillstreakweapon ]](weapon) || isdefined(weapon.statname) && [[ level.iskillstreakweapon ]](getweapon(weapon.statname))) {
            return;
        }
    }
    if (isdefined(self.touchtriggers) && self.touchtriggers.size && attacker.pers[#"team"] != self.pers[#"team"]) {
        triggerids = getarraykeys(self.touchtriggers);
        ownerteam = self.touchtriggers[triggerids[0]].useobj.ownerteam;
        team = self.pers[#"team"];
        if (team != ownerteam) {
            scoreevents::processscoreevent(#"kill_enemy_that_is_capping_your_team_dom", attacker, self, weapon);
            attacker.var_d1fa9d67 = 1;
        }
    }
}

// Namespace dom/dom
// Params 1, eflags: 0x0
// Checksum 0x69c17c52, Offset: 0x5cf0
// Size: 0x186
function killwhilecontesting(flag) {
    self notify(#"killwhilecontesting");
    self endon(#"killwhilecontesting");
    self endon(#"disconnect");
    killtime = gettime();
    playerteam = self.pers[#"team"];
    if (!isdefined(self.clearenemycount)) {
        self.clearenemycount = 0;
    }
    self.clearenemycount++;
    flag waittill(#"contest_over");
    if (playerteam != self.pers[#"team"] || isdefined(self.spawntime) && killtime < self.spawntime) {
        self.clearenemycount = 0;
        return;
    }
    if (flag.ownerteam != playerteam && flag.ownerteam != #"neutral") {
        self.clearenemycount = 0;
        return;
    }
    if (self.clearenemycount >= 2 && killtime + 200 > gettime()) {
        scoreevents::processscoreevent(#"clear_2_attackers", self, undefined, undefined);
    }
    self.clearenemycount = 0;
}

// Namespace dom/dom
// Params 0, eflags: 0x0
// Checksum 0x17965eb2, Offset: 0x5e80
// Size: 0xae
function updateattackermultikills() {
    self endon(#"disconnect");
    level endon(#"game_ended");
    self notify(#"updatedomrecentkills");
    self endon(#"updatedomrecentkills");
    if (!isdefined(self.recentdomattackerkillcount)) {
        self.recentdomattackerkillcount = 0;
    }
    self.recentdomattackerkillcount++;
    wait 4;
    if (self.recentdomattackerkillcount > 1) {
        self challenges::domattackermultikill(self.recentdomattackerkillcount);
    }
    self.recentdomattackerkillcount = 0;
}

// Namespace dom/dom
// Params 1, eflags: 0x0
// Checksum 0x2ab0ceec, Offset: 0x5f38
// Size: 0x78
function getteamflagcount(team) {
    score = 0;
    for (i = 0; i < level.flags.size; i++) {
        if (level.domflags[i] gameobjects::get_owner_team() == team) {
            score++;
        }
    }
    return score;
}

// Namespace dom/dom
// Params 0, eflags: 0x0
// Checksum 0xcbc0bd8b, Offset: 0x5fb8
// Size: 0x1a
function getflagteam() {
    return self.useobj gameobjects::get_owner_team();
}

// Namespace dom/dom
// Params 0, eflags: 0x0
// Checksum 0xb9e95961, Offset: 0x5fe0
// Size: 0xf2
function getboundaryflags() {
    bflags = [];
    for (i = 0; i < level.flags.size; i++) {
        for (j = 0; j < level.flags[i].adjflags.size; j++) {
            if (level.flags[i].useobj gameobjects::get_owner_team() != level.flags[i].adjflags[j].useobj gameobjects::get_owner_team()) {
                bflags[bflags.size] = level.flags[i];
                break;
            }
        }
    }
    return bflags;
}

// Namespace dom/dom
// Params 1, eflags: 0x0
// Checksum 0x6074fd5d, Offset: 0x60e0
// Size: 0xea
function getboundaryflagspawns(team) {
    spawns = [];
    bflags = getboundaryflags();
    for (i = 0; i < bflags.size; i++) {
        if (isdefined(team) && bflags[i] getflagteam() != team) {
            continue;
        }
        for (j = 0; j < bflags[i].nearbyspawns.size; j++) {
            spawns[spawns.size] = bflags[i].nearbyspawns[j];
        }
    }
    return spawns;
}

// Namespace dom/dom
// Params 1, eflags: 0x0
// Checksum 0x1ce7be0c, Offset: 0x61d8
// Size: 0x12a
function getspawnsboundingflag(avoidflag) {
    spawns = [];
    for (i = 0; i < level.flags.size; i++) {
        flag = level.flags[i];
        if (flag == avoidflag) {
            continue;
        }
        isbounding = 0;
        for (j = 0; j < flag.adjflags.size; j++) {
            if (flag.adjflags[j] == avoidflag) {
                isbounding = 1;
                break;
            }
        }
        if (!isbounding) {
            continue;
        }
        for (j = 0; j < flag.nearbyspawns.size; j++) {
            spawns[spawns.size] = flag.nearbyspawns[j];
        }
    }
    return spawns;
}

// Namespace dom/dom
// Params 1, eflags: 0x0
// Checksum 0x1acc0cfd, Offset: 0x6310
// Size: 0x1a0
function getownedandboundingflagspawns(team) {
    spawns = [];
    for (i = 0; i < level.flags.size; i++) {
        if (level.flags[i] getflagteam() == team) {
            for (s = 0; s < level.flags[i].nearbyspawns.size; s++) {
                spawns[spawns.size] = level.flags[i].nearbyspawns[s];
            }
            continue;
        }
        for (j = 0; j < level.flags[i].adjflags.size; j++) {
            if (level.flags[i].adjflags[j] getflagteam() == team) {
                for (s = 0; s < level.flags[i].nearbyspawns.size; s++) {
                    spawns[spawns.size] = level.flags[i].nearbyspawns[s];
                }
                break;
            }
        }
    }
    return spawns;
}

// Namespace dom/dom
// Params 1, eflags: 0x0
// Checksum 0x419c2d29, Offset: 0x64b8
// Size: 0xd2
function getownedflagspawns(team) {
    spawns = [];
    for (i = 0; i < level.flags.size; i++) {
        if (level.flags[i] getflagteam() == team) {
            for (s = 0; s < level.flags[i].nearbyspawns.size; s++) {
                spawns[spawns.size] = level.flags[i].nearbyspawns[s];
            }
        }
    }
    return spawns;
}

// Namespace dom/dom
// Params 0, eflags: 0x0
// Checksum 0x8bb5adb8, Offset: 0x6598
// Size: 0x5b2
function flagsetup() {
    descriptorsbylinkname = [];
    descriptors = getentarray("flag_descriptor", "targetname");
    flags = level.flags;
    for (i = 0; i < level.domflags.size; i++) {
        closestdist = undefined;
        closestdesc = undefined;
        for (j = 0; j < descriptors.size; j++) {
            dist = distance(flags[i].origin, descriptors[j].origin);
            if (!isdefined(closestdist) || dist < closestdist) {
                closestdist = dist;
                closestdesc = descriptors[j];
            }
        }
        if (!isdefined(closestdesc)) {
            globallogic_utils::add_map_error("there is no flag_descriptor in the map! see explanation in dom.gsc");
            break;
        }
        if (isdefined(closestdesc.flag)) {
            globallogic_utils::add_map_error("flag_descriptor with script_linkname \"" + closestdesc.script_linkname + "\" is nearby more than one flag; is there a unique descriptor near each flag?");
            continue;
        }
        flags[i].descriptor = closestdesc;
        closestdesc.flag = flags[i];
        descriptorsbylinkname[closestdesc.script_linkname] = closestdesc;
    }
    if (!isdefined(level.maperrors) || level.maperrors.size == 0) {
        for (i = 0; i < flags.size; i++) {
            if (isdefined(flags[i].descriptor.script_linkto)) {
                adjdescs = strtok(flags[i].descriptor.script_linkto, " ");
            } else {
                adjdescs = [];
            }
            for (j = 0; j < adjdescs.size; j++) {
                otherdesc = descriptorsbylinkname[adjdescs[j]];
                if (!isdefined(otherdesc) || otherdesc.targetname != "flag_descriptor") {
                    globallogic_utils::add_map_error("flag_descriptor with script_linkname \"" + flags[i].descriptor.script_linkname + "\" linked to \"" + adjdescs[j] + "\" which does not exist as a script_linkname of any other entity with a targetname of flag_descriptor (or, if it does, that flag_descriptor has not been assigned to a flag)");
                    continue;
                }
                adjflag = otherdesc.flag;
                if (adjflag == flags[i]) {
                    globallogic_utils::add_map_error("flag_descriptor with script_linkname \"" + flags[i].descriptor.script_linkname + "\" linked to itself");
                    continue;
                }
                flags[i].adjflags[flags[i].adjflags.size] = adjflag;
            }
        }
    }
    spawnpoints = spawning::get_spawnpoint_array("mp_dom_spawn");
    for (i = 0; i < spawnpoints.size; i++) {
        if (isdefined(spawnpoints[i].script_linkto)) {
            desc = descriptorsbylinkname[spawnpoints[i].script_linkto];
            if (!isdefined(desc) || desc.targetname != "flag_descriptor") {
                globallogic_utils::add_map_error("Spawnpoint at " + spawnpoints[i].origin + "\" linked to \"" + spawnpoints[i].script_linkto + "\" which does not exist as a script_linkname of any entity with a targetname of flag_descriptor (or, if it does, that flag_descriptor has not been assigned to a flag)");
                continue;
            }
            nearestflag = desc.flag;
        } else {
            nearestflag = undefined;
            nearestdist = undefined;
            for (j = 0; j < flags.size; j++) {
                dist = distancesquared(flags[j].origin, spawnpoints[i].origin);
                if (!isdefined(nearestflag) || dist < nearestdist) {
                    nearestflag = flags[j];
                    nearestdist = dist;
                }
            }
        }
        nearestflag.nearbyspawns[nearestflag.nearbyspawns.size] = spawnpoints[i];
    }
    if (globallogic_utils::print_map_errors()) {
        return 0;
    }
}

// Namespace dom/dom
// Params 0, eflags: 0x0
// Checksum 0x60e657d3, Offset: 0x6b58
// Size: 0x12c
function createflagspawninfluencers() {
    ss = level.spawnsystem;
    for (flag_index = 0; flag_index < level.flags.size; flag_index++) {
        if (level.domflags[flag_index] == self) {
            break;
        }
    }
    self.owned_flag_influencer = self influencers::create_influencer("dom_friendly", self.trigger.origin, 0);
    self.neutral_flag_influencer = self influencers::create_influencer("dom_neutral", self.trigger.origin, 0);
    self.enemy_flag_influencer = self influencers::create_influencer("dom_enemy", self.trigger.origin, 0);
    self update_spawn_influencers(#"neutral");
}

// Namespace dom/dom
// Params 1, eflags: 0x0
// Checksum 0xa3d2c794, Offset: 0x6c90
// Size: 0x18c
function update_spawn_influencers(team) {
    assert(isdefined(self.neutral_flag_influencer));
    assert(isdefined(self.owned_flag_influencer));
    assert(isdefined(self.enemy_flag_influencer));
    if (team == #"neutral") {
        enableinfluencer(self.neutral_flag_influencer, 1);
        enableinfluencer(self.owned_flag_influencer, 0);
        enableinfluencer(self.enemy_flag_influencer, 0);
        return;
    }
    enableinfluencer(self.neutral_flag_influencer, 0);
    enableinfluencer(self.owned_flag_influencer, 1);
    enableinfluencer(self.enemy_flag_influencer, 1);
    setinfluencerteammask(self.owned_flag_influencer, util::getteammask(team));
    setinfluencerteammask(self.enemy_flag_influencer, util::getotherteamsmask(team));
}

// Namespace dom/dom
// Params 4, eflags: 0x0
// Checksum 0x6ebbcd96, Offset: 0x6e28
// Size: 0x84
function addspawnpointsforflag(team, flag_team, flagspawnname, label) {
    team = util::function_82f4ab63(team);
    otherteam = util::getotherteam(team);
    if (flag_team != otherteam) {
        spawning::add_spawn_points(team, flagspawnname);
    }
}

// Namespace dom/dom
// Params 3, eflags: 0x0
// Checksum 0x8634ec22, Offset: 0x6eb8
// Size: 0x74
function function_4a1e8dc6(team, flag_team, label) {
    otherteam = util::getotherteam(team);
    if (flag_team != otherteam) {
        globallogic_spawn::addsupportedspawnpointtype(level.var_2c709667[label], team);
    }
}

// Namespace dom/dom
// Params 0, eflags: 0x0
// Checksum 0xa370621d, Offset: 0x6f38
// Size: 0x17c
function function_25cda323() {
    globallogic_spawn::function_5e32e69a();
    globallogic_spawn::addsupportedspawnpointtype("dom");
    var_5a5001b5 = level.flags.size;
    if (dominated_check()) {
        globallogic_spawn::addsupportedspawnpointtype("dom_flag_a");
        globallogic_spawn::addsupportedspawnpointtype("dom_flag_b");
        globallogic_spawn::addsupportedspawnpointtype("dom_flag_c");
    } else {
        for (i = 0; i < var_5a5001b5; i++) {
            label = level.flags[i].useobj gameobjects::get_label();
            flag_team = level.flags[i] getflagteam();
            function_4a1e8dc6(#"allies", flag_team, label);
            function_4a1e8dc6(#"axis", flag_team, label);
        }
    }
    globallogic_spawn::addspawns();
}

// Namespace dom/dom
// Params 0, eflags: 0x0
// Checksum 0xe7f598ee, Offset: 0x70c0
// Size: 0xf2
function dominated_challenge_check() {
    num_flags = level.flags.size;
    allied_flags = 0;
    axis_flags = 0;
    for (i = 0; i < num_flags; i++) {
        flag_team = level.flags[i] getflagteam();
        if (flag_team == #"allies") {
            allied_flags++;
        } else if (flag_team == #"axis") {
            axis_flags++;
        } else {
            return false;
        }
        if (allied_flags > 0 && axis_flags > 0) {
            return false;
        }
    }
    return true;
}

// Namespace dom/dom
// Params 0, eflags: 0x0
// Checksum 0xbad2ad4, Offset: 0x71c0
// Size: 0xea
function dominated_check() {
    num_flags = level.flags.size;
    allied_flags = 0;
    axis_flags = 0;
    for (i = 0; i < num_flags; i++) {
        flag_team = level.flags[i] getflagteam();
        if (flag_team == #"allies") {
            allied_flags++;
        } else if (flag_team == #"axis") {
            axis_flags++;
        }
        if (allied_flags > 0 && axis_flags > 0) {
            return false;
        }
    }
    return true;
}

// Namespace dom/dom
// Params 1, eflags: 0x0
// Checksum 0xff01d29c, Offset: 0x72b8
// Size: 0x122
function updatecapsperminute(lastownerteam) {
    if (!isdefined(self.capsperminute)) {
        self.numcaps = 0;
        self.capsperminute = 0;
    }
    if (lastownerteam == #"neutral") {
        return;
    }
    self.numcaps++;
    minutespassed = float(globallogic_utils::gettimepassed()) / 60000;
    if (isplayer(self) && isdefined(self.timeplayed[#"total"])) {
        minutespassed = self.timeplayed[#"total"] / 60;
    }
    self.capsperminute = self.numcaps / minutespassed;
    if (self.capsperminute > self.numcaps) {
        self.capsperminute = self.numcaps;
    }
}

// Namespace dom/dom
// Params 2, eflags: 0x0
// Checksum 0x68d5a63b, Offset: 0x73e8
// Size: 0x62
function isscoreboosting(player, flag) {
    if (!level.rankedmatch) {
        return false;
    }
    if (player.capsperminute > level.playercapturelpm) {
        return true;
    }
    if (flag.capsperminute > level.flagcapturelpm) {
        return true;
    }
    return false;
}

// Namespace dom/dom
// Params 1, eflags: 0x0
// Checksum 0xfd23d59f, Offset: 0x7458
// Size: 0x9e
function on_touch_use(sentient) {
    if (isplayer(sentient)) {
        if ((isdefined(self.contested) ? self.contested : 0) && (isdefined(sentient.var_8a599de9) ? sentient.var_8a599de9 : 0) < gettime()) {
            sentient playsoundtoplayer("mpl_control_capture_contested", sentient);
            sentient.var_8a599de9 = gettime() + 5000;
        }
    }
}

// Namespace dom/dom
// Params 0, eflags: 0x0
// Checksum 0x9fb3836f, Offset: 0x7500
// Size: 0x202
function onupdateuserate() {
    if (!isdefined(self.contested)) {
        self.contested = 0;
    }
    numother = gameobjects::get_num_touching_except_team(self.claimteam);
    numowners = self.numtouching[self.claimteam];
    previousstate = self.contested;
    if (numother > 0 && numowners > 0) {
        if (previousstate == 0) {
            foreach (playerlist in self.touchlist) {
                foreach (struct in playerlist) {
                    player = struct.player;
                    if ((isdefined(player.var_8a599de9) ? player.var_8a599de9 : 0) < gettime()) {
                        player playsoundtoplayer("mpl_control_capture_contested", player);
                        player.var_8a599de9 = gettime() + 5000;
                    }
                }
            }
        }
        self.contested = 1;
        return;
    }
    if (previousstate == 1) {
        self notify(#"contest_over");
    }
    self.contested = 0;
}

// Namespace dom/dom
// Params 1, eflags: 0x0
// Checksum 0xd559c4eb, Offset: 0x7710
// Size: 0x26e
function function_cebd665d(var_c3d87d03) {
    gamemodedata = spawnstruct();
    switch (var_c3d87d03) {
    case 4:
        gamemodedata.wintype = "round_score_reached";
        break;
    case 9:
    case 10:
    default:
        gamemodedata.wintype = "NA";
        break;
    }
    bb::function_a4648ef4(gamemodedata);
    for (var_b47d31d7 = 0; var_b47d31d7 < level.domflags.size; var_b47d31d7++) {
        domflag = level.domflags[var_b47d31d7];
        var_7da401e3 = 0;
        for (var_6c3e1005 = 0; var_6c3e1005 < domflag.var_f1bc4543.size; var_6c3e1005++) {
            var_7da401e3 += domflag.var_f1bc4543[var_6c3e1005];
        }
        if (domflag.var_f1bc4543.size != 0) {
            averagetime = var_7da401e3 / domflag.var_f1bc4543.size;
        }
        var_6de0e37 = {#gametime:function_25e96038(), #round:game.roundsplayed, #label:domflag gameobjects::get_label(), #firstcapture:domflag.firstcapture, #var_360c0694:isdefined(averagetime) ? averagetime : 0, #var_8aa0f613:domflag.var_8aa0f613};
        function_b1f6086c(#"hash_4b747d11b8ad1b23", var_6de0e37);
    }
}

