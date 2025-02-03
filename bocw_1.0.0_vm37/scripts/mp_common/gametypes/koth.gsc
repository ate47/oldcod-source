#using script_1435f3c9fc699e04;
#using script_1cc417743d7c262d;
#using script_335d0650ed05d36d;
#using script_44b0b8420eabacad;
#using script_7d712f77ab8d0c16;
#using scripts\core_common\array_shared;
#using scripts\core_common\battlechatter;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\contracts_shared;
#using scripts\core_common\demo_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\hostmigration_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\medals_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\popups_shared;
#using scripts\core_common\potm_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\sound_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\challenges;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_spawn;
#using scripts\mp_common\gametypes\globallogic_utils;
#using scripts\mp_common\gametypes\outcome;
#using scripts\mp_common\gametypes\round;
#using scripts\mp_common\gametypes\spawning;
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\spawnbeacon;
#using scripts\mp_common\util;

#namespace koth;

// Namespace koth/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x9bdf0617, Offset: 0x580
// Size: 0x454
function event_handler[gametype_init] main(*eventstruct) {
    globallogic::init();
    util::registerscorelimit(0, 1000);
    level.doprematch = 1;
    level.kothstarttime = 0;
    level.onstartgametype = &onstartgametype;
    level.playerspawnedcb = &koth_playerspawnedcb;
    player::function_cf3aa03d(&onplayerkilled);
    player::function_3c5cc656(&function_610d3790);
    level.var_c605eb2a = &function_38874bf6;
    clientfield::register("world", "hardpoint", 1, 5, "int");
    clientfield::register("world", "hardpointteam", 1, 5, "int");
    clientfield::register("world", "activeTriggerIndex", 1, 5, "int");
    clientfield::register("scriptmover", "scriptid", 1, 5, "int");
    level.zoneautomovetime = getgametypesetting(#"autodestroytime");
    level.zonespawntime = getgametypesetting(#"objectivespawntime");
    level.shownextzoneobjective = getgametypesetting(#"shownextzoneobjective");
    level.kothmode = getgametypesetting(#"kothmode");
    level.capturetime = getgametypesetting(#"capturetime");
    level.destroytime = getgametypesetting(#"destroytime");
    level.delayplayer = getgametypesetting(#"delayplayer");
    level.randomzonespawn = getgametypesetting(#"randomobjectivelocations");
    level.scoreperplayer = getgametypesetting(#"scoreperplayer");
    level.timepauseswheninzone = getgametypesetting(#"timepauseswheninzone");
    level.b_allow_vehicle_proximity_pickup = 1;
    level.var_c85170d1 = 1;
    spawning::addsupportedspawnpointtype("koth");
    spawning::function_754c78a6(&function_259770ba);
    spawning::function_754c78a6(&function_40c08152);
    spawning::function_32b97d1b(&spawning::function_90dee50d);
    spawning::function_adbbb58a(&spawning::function_c24e290c);
    /#
        spawning::function_a860c440(&function_ed2b0a19);
    #/
    game.objective_gained_sound = "mpl_flagcapture_sting_friend";
    game.objective_lost_sound = "mpl_flagcapture_sting_enemy";
    game.objective_contested_sound = "mpl_flagreturn_sting";
    level.zonespawnqueue = [];
    level.var_d3a438fb = &function_d3a438fb;
}

// Namespace koth/koth
// Params 0, eflags: 0x4
// Checksum 0x1d21e88c, Offset: 0x9e0
// Size: 0x122
function private function_14e751e9() {
    level endon(#"game_ended");
    while (true) {
        waitframe(1);
        foreach (player in level.players) {
            if (isdefined(player.var_592f3e3c)) {
                if (is_true(level.zone.gameobject.iscontested) || !isdefined(player.touchtriggers) || !isdefined(player.touchtriggers[level.zone.gameobject.entnum])) {
                    player.var_592f3e3c = undefined;
                }
            }
        }
    }
}

// Namespace koth/koth
// Params 3, eflags: 0x0
// Checksum 0x211cb989, Offset: 0xb10
// Size: 0xd4
function updateobjectivehintmessages(defenderteam, defendmessage, attackmessage) {
    foreach (team, _ in level.teams) {
        if (defenderteam == team) {
            game.strings["objective_hint_" + team] = defendmessage;
            continue;
        }
        game.strings["objective_hint_" + team] = attackmessage;
    }
}

// Namespace koth/koth
// Params 1, eflags: 0x0
// Checksum 0xbf5422ac, Offset: 0xbf0
// Size: 0x9c
function updateobjectivehintmessage(message) {
    foreach (team, _ in level.teams) {
        game.strings["objective_hint_" + team] = message;
    }
}

// Namespace koth/koth
// Params 0, eflags: 0x0
// Checksum 0x8fab4741, Offset: 0xc98
// Size: 0x24c
function onstartgametype() {
    globallogic_score::resetteamscores();
    level.kothtotalsecondsinzone = 0;
    level.objectivehintpreparezone = #"mp/control_koth";
    level.objectivehintcapturezone = #"mp/capture_koth";
    level.objectivehintdefendhq = #"mp/defend_koth";
    luinotifyevent(#"round_start");
    spawning::function_fac242d0(10, "koth_zone_", &function_b11bd4e4);
    if (getgametypesetting(#"allowovertime")) {
        level.ontimelimit = &function_a2ef4132;
    }
    if (level.zonespawntime) {
        updateobjectivehintmessage(level.objectivehintpreparezone);
    } else {
        updateobjectivehintmessage(level.objectivehintcapturezone);
    }
    if (!setupzones()) {
        return;
    }
    updategametypedvars();
    foreach (zone in level.zones) {
        othervisuals = getentarray(zone.target, "targetname");
        for (j = 0; j < othervisuals.size; j++) {
            othervisuals[j] notsolid();
        }
    }
    thread kothmainloop();
    thread function_14e751e9();
}

// Namespace koth/koth
// Params 0, eflags: 0x0
// Checksum 0xa5302fb2, Offset: 0xef0
// Size: 0x34
function pause_time() {
    if (level.timepauseswheninzone) {
        globallogic_utils::pausetimer();
        level.timerpaused = 1;
    }
}

// Namespace koth/koth
// Params 0, eflags: 0x0
// Checksum 0x92a0ee48, Offset: 0xf30
// Size: 0x58
function resume_time() {
    if (level.timepauseswheninzone) {
        globallogic_utils::resumetimerdiscardoverride(int(level.kothtotalsecondsinzone * 1000));
        level.timerpaused = 0;
    }
}

// Namespace koth/koth
// Params 0, eflags: 0x0
// Checksum 0xe36ca1ff, Offset: 0xf90
// Size: 0x54
function updategametypedvars() {
    level.playercapturelpm = getgametypesetting(#"maxplayereventsperminute");
    level.timepauseswheninzone = getgametypesetting(#"timepauseswheninzone");
}

// Namespace koth/koth
// Params 0, eflags: 0x0
// Checksum 0x8f3231ba, Offset: 0xff0
// Size: 0x10c
function function_9695c3e3() {
    assert(isdefined(level.var_96226f2e));
    if (level.randomzonespawn == 1) {
        nextzoneindex = function_ac4c0c88(1);
        nextzone = level.zonespawnqueue[nextzoneindex];
    } else {
        nextzoneindex = function_ac4c0c88(0);
        nextzone = level.zones[nextzoneindex];
    }
    objective_setstate(level.var_96226f2e, "invisible");
    if (isdefined(nextzone)) {
        objective_onentity(level.var_96226f2e, nextzone.objectiveanchor);
        level.var_e89ee661 = 1;
        return;
    }
    level.var_e89ee661 = 0;
}

// Namespace koth/koth
// Params 0, eflags: 0x0
// Checksum 0x152ce9e1, Offset: 0x1108
// Size: 0x84
function function_9f81bb75() {
    assert(isdefined(level.var_96226f2e));
    if (is_true(level.var_e89ee661) && !is_true(level.overtime)) {
        objective_setstate(level.var_96226f2e, "active");
    }
}

// Namespace koth/koth
// Params 1, eflags: 0x0
// Checksum 0xee57ae51, Offset: 0x1198
// Size: 0x1dc
function spawn_first_zone(*delay) {
    if (level.randomzonespawn == 1) {
        level.zone = getnextzonefromqueue();
    } else {
        level.zone = getfirstzone();
    }
    if (!isdefined(level.zone)) {
        globallogic_utils::add_map_error("No zones available");
        return;
    }
    /#
        print("<dev string:x38>" + level.zone.trigorigin[0] + "<dev string:x4b>" + level.zone.trigorigin[1] + "<dev string:x4b>" + level.zone.trigorigin[2] + "<dev string:x50>");
    #/
    level.zone enable_influencers(1);
    level.zone.gameobject.trigger allowtacticalinsertion(0);
    spawn_beacon::addprotectedzone(level.zone.trig);
    level clientfield::set("activeTriggerIndex", level.zone.var_b76aa8);
    matchrecordroundstart();
    if (isdefined(level.var_96226f2e)) {
        function_9695c3e3();
    }
}

// Namespace koth/koth
// Params 0, eflags: 0x0
// Checksum 0xa58aa0ac, Offset: 0x1380
// Size: 0x1ac
function spawn_next_zone() {
    level.zone.gameobject.trigger allowtacticalinsertion(1);
    if (level.randomzonespawn != 0) {
        level.zone = getnextzonefromqueue();
    } else {
        level.zone = getnextzone();
    }
    matchrecordroundend();
    if (isdefined(level.zone)) {
        /#
            print("<dev string:x38>" + level.zone.trigorigin[0] + "<dev string:x4b>" + level.zone.trigorigin[1] + "<dev string:x4b>" + level.zone.trigorigin[2] + "<dev string:x50>");
        #/
        level.zone enable_influencers(1);
        spawn_beacon::addprotectedzone(level.zone.trig);
        matchrecordroundstart();
    }
    level.zone.gameobject.trigger allowtacticalinsertion(0);
}

// Namespace koth/koth
// Params 0, eflags: 0x0
// Checksum 0xb102db62, Offset: 0x1538
// Size: 0x2c
function function_568f7563() {
    level waittill(#"game_ended");
    matchrecordroundend();
}

// Namespace koth/koth
// Params 1, eflags: 0x0
// Checksum 0x48f0a8c4, Offset: 0x1570
// Size: 0x94
function togglezoneeffects(enabled) {
    index = 0;
    if (enabled) {
        index = self.script_index;
    }
    level clientfield::set("hardpoint", index);
    level clientfield::set("hardpointteam", 0);
    level clientfield::set("activeTriggerIndex", self.var_b76aa8);
}

// Namespace koth/koth
// Params 0, eflags: 0x0
// Checksum 0x3fc4a790, Offset: 0x1610
// Size: 0x500
function kothcaptureloop() {
    level endon(#"game_ended", #"zone_moved");
    level.kothstarttime = gettime();
    while (true) {
        level.zone.gameobject gameobjects::allow_use(#"group_all");
        level.zone.gameobject gameobjects::set_use_time(level.capturetime);
        level.zone.gameobject gameobjects::set_use_text(#"mp/capturing_objective");
        level.zone.gameobject gameobjects::set_visible(#"group_all");
        level.zone.gameobject gameobjects::set_model_visibility(1, 1);
        level.zone.gameobject gameobjects::must_maintain_claim(0);
        level.zone.gameobject gameobjects::can_contest_claim(1);
        level.zone.gameobject.onuse = &onzonecapture;
        level.zone.gameobject.onbeginuse = &onbeginuse;
        level.zone.gameobject.onenduse = &onenduse;
        level.zone.gameobject.ontouchuse = &ontouchuse;
        level.zone.gameobject.onupdateuserate = &onupdateuserate;
        level.zone togglezoneeffects(1);
        msg = level waittill(#"zone_captured", #"zone_destroyed");
        if (msg._notify == "zone_destroyed") {
            continue;
        }
        ownerteam = level.zone.gameobject gameobjects::get_owner_team();
        foreach (_ in level.teams) {
            updateobjectivehintmessages(ownerteam, level.objectivehintdefendhq, level.objectivehintcapturezone);
        }
        level.zone.gameobject gameobjects::allow_use(#"group_none");
        level.zone.gameobject.onuse = undefined;
        level.zone.gameobject.onunoccupied = &onzoneunoccupied;
        level.zone.gameobject.oncontested = &onzonecontested;
        level.zone.gameobject.onuncontested = &onzoneuncontested;
        waitresult = level waittill(#"zone_destroyed");
        if (!level.kothmode || level.zonedestroyedbytimer) {
            break;
        }
        thread forcespawnteam(ownerteam);
        if (isdefined(waitresult.destroy_team)) {
            level.zone.gameobject gameobjects::set_owner_team(waitresult.destroy_team);
            continue;
        }
        level.zone.gameobject gameobjects::set_owner_team("none");
    }
}

// Namespace koth/koth
// Params 0, eflags: 0x0
// Checksum 0x13823ef7, Offset: 0x1b18
// Size: 0x790
function kothmainloop() {
    level endon(#"game_ended");
    spawn_first_zone();
    while (level.inprematchperiod) {
        waitframe(1);
    }
    pause_time();
    wait 5;
    luinotifyevent(#"hardpoint_unlocked");
    foreach (zone in level.zones) {
        othervisuals = getentarray(zone.target, "targetname");
        for (j = 0; j < othervisuals.size; j++) {
            othervisuals[j] clientfield::set("scriptid", zone.script_index);
        }
        zone.objectiveanchor clientfield::set("scriptid", zone.script_index);
    }
    waitframe(1);
    setbombtimer("A", 0);
    setmatchflag("bomb_timer_a", 0);
    thread hidetimerdisplayongameend();
    thread function_568f7563();
    while (true) {
        resume_time();
        sound::play_on_players("mp_suitcase_pickup");
        globallogic_audio::leader_dialog("kothLocated", undefined, "gamemode_objective", undefined, "kothActiveDialogBuffer");
        level.zone.gameobject gameobjects::set_model_visibility(1, 1);
        if (level.zonespawntime) {
            level.zone.gameobject gameobjects::set_visible(#"group_all");
            level.zone.gameobject gameobjects::set_flags(1);
            updateobjectivehintmessage(level.objectivehintpreparezone);
            setmatchflag("bomb_timer_a", 1);
            setbombtimer("A", int(gettime() + 1000 + int(level.zonespawntime * 1000)));
            wait level.zonespawntime;
            level.zone.gameobject gameobjects::set_flags(0);
            globallogic_audio::leader_dialog("kothOnline", undefined, "gamemode_objective", undefined, "kothActiveDialogBuffer");
        }
        setmatchflag("bomb_timer_a", 0);
        waittillframeend();
        updateobjectivehintmessage(level.objectivehintcapturezone);
        sound::play_on_players("mpl_hq_cap_us");
        level.zone.gameobject gameobjects::enable_object();
        function_18fbab10(level.zone.gameobject.objectiveid, #"hash_3f7d871e78c8264f");
        objective_onentity(level.zone.gameobject.objectiveid, level.zone.objectiveanchor);
        level.zone.gameobject.capturecount = 0;
        if (level.zoneautomovetime) {
            thread movezoneaftertime(level.zoneautomovetime);
            setmatchflag("bomb_timer_a", 1);
            setbombtimer("A", int(gettime() + 1000 + int(level.zoneautomovetime * 1000)));
        } else {
            level.zonedestroyedbytimer = 0;
        }
        kothcaptureloop();
        ownerteam = level.zone.gameobject gameobjects::get_owner_team();
        pause_time();
        level.zone enable_influencers(0);
        level.zone.gameobject.lastcaptureteam = undefined;
        level.zone.gameobject gameobjects::disable_object();
        level.zone.gameobject gameobjects::allow_use(#"group_none");
        level.zone.gameobject gameobjects::set_owner_team(#"neutral");
        level.zone.gameobject gameobjects::set_model_visibility(0, 1);
        level.zone.gameobject gameobjects::must_maintain_claim(0);
        level.zone togglezoneeffects(0);
        spawn_beacon::removeprotectedzone(level.zone.trig);
        level notify(#"zone_reset");
        setmatchflag("bomb_timer_a", 0);
        spawn_next_zone();
        wait 0.5;
        thread forcespawnteam(ownerteam);
        wait 0.5;
        if (isdefined(level.var_96226f2e)) {
            function_9695c3e3();
        }
    }
}

// Namespace koth/koth
// Params 0, eflags: 0x0
// Checksum 0x502a72ef, Offset: 0x22b0
// Size: 0x34
function hidetimerdisplayongameend() {
    level waittill(#"game_ended");
    setmatchflag("bomb_timer_a", 0);
}

// Namespace koth/koth
// Params 1, eflags: 0x0
// Checksum 0x1dbfc4c4, Offset: 0x22f0
// Size: 0x98
function forcespawnteam(team) {
    players = level.players;
    for (i = 0; i < players.size; i++) {
        player = players[i];
        if (!isdefined(player)) {
            continue;
        }
        if (player.pers[#"team"] == team) {
            player notify(#"force_spawn");
            wait 0.1;
        }
    }
}

// Namespace koth/koth
// Params 0, eflags: 0x0
// Checksum 0x8fceba62, Offset: 0x2390
// Size: 0xfc
function updateteamclientfield() {
    ownerteam = self gameobjects::get_owner_team();
    if (is_true(self.iscontested)) {
        level clientfield::set("hardpointteam", 3);
        return;
    }
    if (ownerteam == #"neutral") {
        level clientfield::set("hardpointteam", 0);
        return;
    }
    if (ownerteam == #"allies") {
        level clientfield::set("hardpointteam", 1);
        return;
    }
    level clientfield::set("hardpointteam", 2);
}

// Namespace koth/koth
// Params 1, eflags: 0x4
// Checksum 0x96dd09bf, Offset: 0x2498
// Size: 0x64
function private iszonecontested(gameobject) {
    if (gameobject gameobjects::get_num_touching(game.attackers) > 0 && gameobject gameobjects::get_num_touching(game.defenders) > 0) {
        return true;
    }
    return false;
}

// Namespace koth/koth
// Params 0, eflags: 0x0
// Checksum 0x61f40a85, Offset: 0x2508
// Size: 0x1fe
function onupdateuserate() {
    if (!isdefined(self.iscontested)) {
        self.iscontested = 0;
        self.var_464f0169 = 0;
    }
    self.iscontested = iszonecontested(self);
    if (self.iscontested) {
        if (!self.var_464f0169) {
            foreach (user in self.users) {
                if (!isdefined(user.touching.players)) {
                    continue;
                }
                foreach (struct in user.touching.players) {
                    if (!isdefined(struct)) {
                        continue;
                    }
                    player = struct.player;
                    if (isdefined(player) && isplayer(player) && (isdefined(player.var_c8d27c06) ? player.var_c8d27c06 : 0) < gettime()) {
                        player playsoundtoplayer(#"mpl_control_capture_contested", player);
                        player.var_c8d27c06 = gettime() + 5000;
                    }
                }
            }
        }
    }
}

// Namespace koth/koth
// Params 1, eflags: 0x0
// Checksum 0x43cc1f9c, Offset: 0x2710
// Size: 0xc4
function ontouchuse(sentient) {
    if (isplayer(sentient)) {
        self.var_464f0169 = self.iscontested;
        if (iszonecontested(self) && (isdefined(sentient.var_c8d27c06) ? sentient.var_c8d27c06 : 0) < gettime()) {
            sentient playsoundtoplayer(#"mpl_control_capture_contested", sentient);
            sentient.var_c8d27c06 = gettime() + 5000;
        }
        battlechatter::function_98898d14(sentient, self);
    }
}

// Namespace koth/koth
// Params 1, eflags: 0x0
// Checksum 0x1caf30ff, Offset: 0x27e0
// Size: 0xc
function onbeginuse(*sentient) {
    
}

// Namespace koth/koth
// Params 3, eflags: 0x0
// Checksum 0xa2d40ac5, Offset: 0x27f8
// Size: 0x70
function onenduse(*team, sentient, *success) {
    if (!isdefined(success)) {
        return;
    }
    player = success;
    if (!isplayer(player)) {
        player = success.owner;
    }
    player notify(#"event_ended");
}

// Namespace koth/koth
// Params 1, eflags: 0x0
// Checksum 0x5c81a704, Offset: 0x2870
// Size: 0x460
function onzonecapture(sentient) {
    player = sentient;
    if (!isplayer(player)) {
        player = sentient.owner;
    }
    capture_team = player.team;
    capturetime = gettime();
    /#
        print("<dev string:x55>");
    #/
    pause_time();
    string = #"hash_446b7b0b3e4df72e";
    level.zone.gameobject.iscontested = 0;
    spawning::function_7a87efaa();
    if (!isdefined(self.lastcaptureteam) || self.lastcaptureteam != capture_team) {
        touchlist = arraycopy(self.users[capture_team].touching.players);
        thread give_capture_credit(touchlist, string, capturetime, capture_team, self.lastcaptureteam);
    }
    level.kothcapteam = capture_team;
    self gameobjects::set_owner_team(capture_team);
    if (!level.kothmode) {
        self gameobjects::set_use_time(level.destroytime);
    }
    foreach (team, _ in level.teams) {
        if (team == capture_team) {
            if (!isdefined(self.lastcaptureteam) || self.lastcaptureteam != team) {
                globallogic_audio::leader_dialog("kothSecured", team, "gamemode_objective", undefined, "kothActiveDialogBuffer");
                for (index = 0; index < level.players.size; index++) {
                    player = level.players[index];
                    if (player.pers[#"team"] == team) {
                        if (player.lastkilltime + 500 > gettime()) {
                            player challenges::killedlastcontester();
                        }
                    }
                }
            }
            thread sound::play_on_players(game.objective_gained_sound, team);
            continue;
        }
        if (!isdefined(self.lastcaptureteam)) {
            globallogic_audio::leader_dialog("kothCaptured", team, "gamemode_objective", undefined, "kothActiveDialogBuffer");
        } else if (self.lastcaptureteam == team) {
            globallogic_audio::leader_dialog("kothLost", team, "gamemode_objective", undefined, "kothActiveDialogBuffer");
        }
        thread sound::play_on_players(game.objective_lost_sound, team);
    }
    self thread awardcapturepoints(capture_team, self.lastcaptureteam);
    self.capturecount++;
    self.lastcaptureteam = capture_team;
    self gameobjects::must_maintain_claim(1);
    self updateteamclientfield();
    level notify(#"zone_captured");
    level notify("zone_captured" + capture_team);
    player notify(#"event_ended");
}

// Namespace koth/koth
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x2cd8
// Size: 0x4
function track_capture_time() {
    
}

// Namespace koth/koth
// Params 5, eflags: 0x0
// Checksum 0x78f797e, Offset: 0x2ce8
// Size: 0x3f8
function give_capture_credit(touchlist, string, capturetime, capture_team, lastcaptureteam) {
    waitframe(1);
    util::waittillslowprocessallowed();
    foreach (touch in touchlist) {
        player = gameobjects::function_73944efe(touchlist, touch);
        if (!isdefined(player)) {
            continue;
        }
        player updatecapsperminute(lastcaptureteam);
        if (!isscoreboosting(player)) {
            player challenges::capturedobjective(capturetime, self.trigger);
            if (level.kothstarttime + 3000 > capturetime && level.kothcapteam == capture_team) {
                scoreevents::processscoreevent(#"quickly_secure_point", player, undefined, undefined);
                player stats::function_dad108fa(#"hash_60545a50ce7c9791", 1);
            }
            scoreevents::processscoreevent(#"koth_secure", player, undefined, undefined);
            player recordgameevent("capture");
            player recordgameevent("hardpoint_captured");
            battlechatter::function_924699f4(player, self);
            level thread popups::displayteammessagetoall(string, player);
            if (isdefined(player.pers[#"captures"])) {
                player.pers[#"captures"]++;
                player.captures = player.pers[#"captures"];
            }
            player.pers[#"objectives"]++;
            player.objectives = player.pers[#"objectives"];
            if (level.kothstarttime + 500 > capturetime) {
                player challenges::immediatecapture();
            }
            demo::bookmark(#"event", gettime(), player);
            potm::bookmark(#"event", gettime(), player);
            player stats::function_bb7eedf0(#"captures", 1);
            player stats::function_bb7eedf0(#"captures_in_capture_area", 1);
            player contracts::increment_contract(#"contract_mp_objective_capture");
            continue;
        }
        /#
            player iprintlnbold("<dev string:x66>");
        #/
    }
}

// Namespace koth/koth
// Params 0, eflags: 0x0
// Checksum 0xccf6bd6b, Offset: 0x30e8
// Size: 0xbe
function onzoneunoccupied() {
    level notify(#"zone_destroyed");
    level.kothcapteam = #"neutral";
    level.zone.gameobject.wasleftunoccupied = 1;
    level.zone.gameobject.iscontested = 0;
    level.zone.gameobject recordgameeventnonplayer("hardpoint_empty");
    resume_time();
    self updateteamclientfield();
    self.mustmaintainclaim = 0;
}

// Namespace koth/koth
// Params 0, eflags: 0x0
// Checksum 0xdeae55c6, Offset: 0x31b0
// Size: 0x170
function onzonecontested() {
    zoneowningteam = self gameobjects::get_owner_team();
    self.wascontested = 1;
    self.iscontested = 1;
    self updateteamclientfield();
    self recordgameeventnonplayer("hardpoint_contested");
    resume_time();
    util::function_a3f7de13(8, #"none");
    foreach (team, _ in level.teams) {
        if (team == zoneowningteam) {
            thread sound::play_on_players(game.objective_contested_sound, team);
            globallogic_audio::leader_dialog("kothContested", team, "gamemode_objective", undefined, "kothActiveDialogBuffer");
        }
    }
}

// Namespace koth/koth
// Params 1, eflags: 0x0
// Checksum 0x94bd6d47, Offset: 0x3328
// Size: 0xc8
function onzoneuncontested(lastclaimteam) {
    assert(lastclaimteam == level.zone.gameobject gameobjects::get_owner_team());
    self.iscontested = 0;
    pause_time();
    self gameobjects::set_claim_team(lastclaimteam);
    self updateteamclientfield();
    self recordgameeventnonplayer("hardpoint_uncontested");
    level notify(#"hardpoint_uncontested");
}

// Namespace koth/koth
// Params 1, eflags: 0x0
// Checksum 0xf29dcfaa, Offset: 0x33f8
// Size: 0x294
function movezoneaftertime(time) {
    level endon(#"game_ended", #"zone_reset");
    level.zonemovetime = gettime() + int(time * 1000);
    level.zonedestroyedbytimer = 0;
    if (isdefined(level.var_96226f2e)) {
        var_f03a7dfd = time - 10;
        if (var_f03a7dfd <= 0) {
            function_9f81bb75();
            wait time;
        } else if (var_f03a7dfd >= time) {
            wait time;
        } else {
            wait var_f03a7dfd;
            function_9f81bb75();
            wait 10;
        }
    } else {
        wait time;
    }
    if (is_true(level.overtime)) {
        return;
    }
    if (!isdefined(level.zone.gameobject.wascontested) || level.zone.gameobject.wascontested == 0) {
        if (!isdefined(level.zone.gameobject.wasleftunoccupied) || level.zone.gameobject.wasleftunoccupied == 0) {
            zoneowningteam = level.zone.gameobject gameobjects::get_owner_team();
            challenges::controlzoneentirely(zoneowningteam);
        }
    }
    level.zonedestroyedbytimer = 1;
    level.zone.gameobject recordgameeventnonplayer("hardpoint_moved");
    playsoundatposition(#"mpl_hardpoint_move", (0, 0, 0));
    level notify(#"zone_moved");
    level.zone.gameobject.onuse = undefined;
    util::function_a3f7de13(6, #"none");
}

// Namespace koth/koth
// Params 2, eflags: 0x0
// Checksum 0xd02969c3, Offset: 0x3698
// Size: 0x490
function awardcapturepoints(team, *lastcaptureteam) {
    level endon(#"game_ended", #"zone_destroyed", #"zone_reset", #"zone_moved");
    level notify(#"awardcapturepointsrunning");
    level endon(#"awardcapturepointsrunning");
    foreach (player in level.players) {
        player.var_592f3e3c = undefined;
    }
    seconds = 1;
    score = 1;
    while (!level.gameended) {
        wait seconds;
        hostmigration::waittillhostmigrationdone();
        if (!level.zone.gameobject.iscontested) {
            if (level.scoreperplayer) {
                score = level.zone.gameobject gameobjects::get_num_touching(lastcaptureteam);
            }
            globallogic_score::giveteamscoreforobjective(lastcaptureteam, score);
            level.kothtotalsecondsinzone++;
            foreach (player in function_a1ef346b(lastcaptureteam)) {
                if (!isdefined(player.touchtriggers[self.entnum])) {
                    continue;
                }
                if (isdefined(player.pers[#"objtime"])) {
                    player.pers[#"objtime"]++;
                    player.objtime = player.pers[#"objtime"];
                }
                zoneindex = array::find(level.zones, level.zone);
                var_998771f0 = "hardpoint" + zoneindex;
                if (!isdefined(player.pers[var_998771f0])) {
                    player.pers[var_998771f0] = 0;
                }
                player.pers[var_998771f0]++;
                player function_eaab1468(player.pers[var_998771f0], zoneindex);
                player stats::function_bb7eedf0(#"objective_time", 1);
                player globallogic_score::incpersstat(#"objectivetime", 1, 0, 1);
                player function_2e698e8e(player.pers[#"objtime"]);
                if (!isdefined(player.var_592f3e3c)) {
                    player.var_592f3e3c = gettime();
                    continue;
                }
                if (player.var_592f3e3c <= gettime() - 5000) {
                    player scoreevents::processscoreevent(#"hardpoint_owned", player);
                    player.var_592f3e3c = gettime();
                }
            }
            if (is_true(level.overtime) && isdefined(outcome::function_6d0354e3())) {
                round::function_870759fb();
                thread globallogic::end_round(2);
            }
        }
    }
}

// Namespace koth/koth
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x3b30
// Size: 0x4
function koth_playerspawnedcb() {
    
}

// Namespace koth/koth
// Params 2, eflags: 0x0
// Checksum 0x23681922, Offset: 0x3b40
// Size: 0xe8
function comparezoneindexes(zone_a, zone_b) {
    script_index_a = zone_a.script_index;
    script_index_b = zone_b.script_index;
    if (!isdefined(script_index_a) && !isdefined(script_index_b)) {
        return false;
    }
    if (!isdefined(script_index_a) && isdefined(script_index_b)) {
        println("<dev string:xae>" + zone_a.origin);
        return true;
    }
    if (isdefined(script_index_a) && !isdefined(script_index_b)) {
        println("<dev string:xae>" + zone_b.origin);
        return false;
    }
    if (script_index_a > script_index_b) {
        return true;
    }
    return false;
}

// Namespace koth/koth
// Params 0, eflags: 0x0
// Checksum 0x55f4175c, Offset: 0x3c30
// Size: 0x104
function getzonearray() {
    zones = getentarray("koth_zone_center", "targetname");
    if (!isdefined(zones)) {
        return undefined;
    }
    swapped = 1;
    for (n = zones.size; swapped; n--) {
        swapped = 0;
        for (i = 0; i < n - 1; i++) {
            if (comparezoneindexes(zones[i], zones[i + 1])) {
                temp = zones[i];
                zones[i] = zones[i + 1];
                zones[i + 1] = temp;
                swapped = 1;
            }
        }
    }
    return zones;
}

// Namespace koth/koth
// Params 0, eflags: 0x0
// Checksum 0x7083e79e, Offset: 0x3d40
// Size: 0x4f8
function setupzones() {
    zones = getzonearray();
    if (zones.size == 0) {
        globallogic_utils::add_map_error("No zones found for KOTH in map " + util::get_map_name());
    }
    trigs = getentarray("koth_zone_trigger", "targetname");
    var_4cb5e04 = getentarray("koth_zone_trigger", "script_noteworthy");
    trigs = arraycombine(trigs, var_4cb5e04);
    assert(zones.size == trigs.size, "<dev string:xd8>");
    for (i = 0; i < zones.size; i++) {
        errored = 0;
        zone = zones[i];
        zone.trig = undefined;
        for (j = 0; j < trigs.size; j++) {
            if (zone istouching(trigs[j])) {
                if (isdefined(zone.trig)) {
                    globallogic_utils::add_map_error("Zone at " + zone.origin + " is touching more than one \"zonetrigger\" trigger");
                    errored = 1;
                    break;
                }
                zone.trig = trigs[j];
                zone.var_b76aa8 = j;
                zone.trig trigger::add_flags(16);
                break;
            }
        }
        if (!isdefined(zone.trig)) {
            if (!errored) {
                globallogic_utils::add_map_error("Zone at " + zone.origin + " is not inside any \"zonetrigger\" trigger");
                continue;
            }
        }
        assert(!errored);
        zone.trigorigin = zone.trig.origin;
        zone.objectiveanchor = spawn("script_model", zone.origin);
        visuals = [];
        visuals[0] = zone;
        if (isdefined(zone.target)) {
            othervisuals = getentarray(zone.target, "targetname");
            for (j = 0; j < othervisuals.size; j++) {
                visuals[visuals.size] = othervisuals[j];
            }
        }
        zone.gameobject = gameobjects::create_use_object(#"neutral", zone.trig, visuals, (0, 0, 0), #"hardpoint");
        zone.gameobject gameobjects::set_objective_entity(zone);
        zone.gameobject gameobjects::disable_object();
        zone.gameobject gameobjects::set_model_visibility(0, 1);
        zone.trig.useobj = zone.gameobject;
        zone createzonespawninfluencer();
    }
    if (is_true(level.shownextzoneobjective)) {
        level.var_e89ee661 = 0;
        level.var_96226f2e = gameobjects::get_next_obj_id();
        objective_add(level.var_96226f2e, "invisible", level.zone.objectiveanchor, #"hardpoint_next");
        function_18fbab10(level.var_96226f2e, #"hash_1ff7adbf21cf79eb");
    }
    if (globallogic_utils::print_map_errors()) {
        return false;
    }
    level.zones = zones;
    level.prevzone = undefined;
    level.prevzone2 = undefined;
    setupzoneexclusions();
    return true;
}

// Namespace koth/koth
// Params 0, eflags: 0x0
// Checksum 0xb7b3aaf4, Offset: 0x4240
// Size: 0x1b8
function setupzoneexclusions() {
    if (!isdefined(level.levelkothdisable)) {
        return;
    }
    foreach (nullzone in level.levelkothdisable) {
        mindist = 1410065408;
        foundzone = undefined;
        foreach (zone in level.zones) {
            distance = distancesquared(nullzone.origin, zone.origin);
            if (distance < mindist) {
                foundzone = zone;
                mindist = distance;
            }
        }
        if (isdefined(foundzone)) {
            if (!isdefined(foundzone.gameobject.exclusions)) {
                foundzone.gameobject.exclusions = [];
            }
            foundzone.gameobject.exclusions[foundzone.gameobject.exclusions.size] = nullzone;
        }
    }
}

// Namespace koth/koth
// Params 1, eflags: 0x0
// Checksum 0x6122d364, Offset: 0x4400
// Size: 0x8c
function function_ac4c0c88(var_6075f900) {
    if (var_6075f900) {
        if (level.zonespawnqueue.size == 0) {
            shufflezones();
        }
        assert(level.zonespawnqueue.size > 0);
        return 0;
    }
    return (level.prevzoneindex + 1) % level.zones.size;
}

// Namespace koth/koth
// Params 0, eflags: 0x0
// Checksum 0x94de1c34, Offset: 0x4498
// Size: 0x80
function getfirstzone() {
    zone = level.zones[0];
    level.prevzone2 = level.prevzone;
    level.prevzone = zone;
    level.prevzoneindex = 0;
    shufflezones();
    arrayremovevalue(level.zonespawnqueue, zone);
    return zone;
}

// Namespace koth/koth
// Params 0, eflags: 0x0
// Checksum 0x5a530521, Offset: 0x4520
// Size: 0x78
function getnextzone() {
    nextzoneindex = function_ac4c0c88(0);
    zone = level.zones[nextzoneindex];
    level.prevzone2 = level.prevzone;
    level.prevzone = zone;
    level.prevzoneindex = nextzoneindex;
    return zone;
}

// Namespace koth/koth
// Params 0, eflags: 0x0
// Checksum 0xc3216382, Offset: 0x45a0
// Size: 0x74
function pickrandomzonetospawn() {
    level.prevzoneindex = randomint(level.zones.size);
    zone = level.zones[level.prevzoneindex];
    level.prevzone2 = level.prevzone;
    level.prevzone = zone;
    return zone;
}

// Namespace koth/koth
// Params 0, eflags: 0x0
// Checksum 0x8c706a8b, Offset: 0x4620
// Size: 0x132
function shufflezones() {
    level.zonespawnqueue = [];
    spawnqueue = arraycopy(level.zones);
    for (total_left = spawnqueue.size; total_left > 0; total_left--) {
        index = randomint(total_left);
        valid_zones = 0;
        for (zone = 0; zone < level.zones.size; zone++) {
            if (!isdefined(spawnqueue[zone])) {
                continue;
            }
            if (valid_zones == index) {
                if (level.zonespawnqueue.size == 0 && isdefined(level.zone) && level.zone == spawnqueue[zone]) {
                    continue;
                }
                level.zonespawnqueue[level.zonespawnqueue.size] = spawnqueue[zone];
                spawnqueue[zone] = undefined;
                break;
            }
            valid_zones++;
        }
    }
}

// Namespace koth/koth
// Params 0, eflags: 0x0
// Checksum 0x55793fe8, Offset: 0x4760
// Size: 0x60
function getnextzonefromqueue() {
    nextzoneindex = function_ac4c0c88(1);
    next_zone = level.zonespawnqueue[nextzoneindex];
    arrayremoveindex(level.zonespawnqueue, nextzoneindex);
    return next_zone;
}

// Namespace koth/koth
// Params 0, eflags: 0x0
// Checksum 0xa35ca57f, Offset: 0x47c8
// Size: 0x28
function function_38874bf6() {
    if (isdefined(level.zone)) {
        return level.zone.origin;
    }
}

// Namespace koth/koth
// Params 4, eflags: 0x0
// Checksum 0x6a1563e1, Offset: 0x47f8
// Size: 0xc2c
function function_610d3790(einflictor, victim, *idamage, weapon) {
    attacker = self;
    if (!isplayer(attacker) || level.capturetime && !idamage.touchtriggers.size && !attacker.touchtriggers.size || attacker.pers[#"team"] == idamage.pers[#"team"]) {
        return;
    }
    if (isdefined(weapon) && isdefined(level.iskillstreakweapon)) {
        if ([[ level.iskillstreakweapon ]](weapon) || isdefined(weapon.statname) && [[ level.iskillstreakweapon ]](getweapon(weapon.statname))) {
            weaponiskillstreak = 1;
        }
    }
    medalgiven = 0;
    scoreeventprocessed = 0;
    var_1cfdf798 = isdefined(idamage.lastattacker) ? idamage.lastattacker === attacker : 0;
    ownerteam = undefined;
    if (level.capturetime == 0) {
        if (!isdefined(level.zone)) {
            return;
        }
        ownerteam = level.zone.gameobject gameobjects::get_owner_team();
        if (!isdefined(ownerteam) || ownerteam == #"neutral") {
            return;
        }
    }
    if (idamage.touchtriggers.size || level.capturetime == 0 && idamage istouching(level.zone.trig)) {
        if (level.capturetime > 0) {
            triggerids = getarraykeys(idamage.touchtriggers);
            ownerteam = idamage.touchtriggers[triggerids[0]].useobj gameobjects::get_owner_team();
        }
        if (ownerteam != #"neutral") {
            attacker.prevlastkilltime = attacker.lastkilltime;
            attacker.lastkilltime = gettime();
            team = attacker.pers[#"team"];
            if (team == ownerteam) {
                if (!medalgiven) {
                    if (var_1cfdf798) {
                        attacker medals::offenseglobalcount();
                        attacker thread challenges::killedbaseoffender(level.zone.trig, weapon, victim);
                    }
                    attacker challenges::function_2f462ffd(idamage, weapon, victim, level.zone.gameobject);
                    attacker.pers[#"objectiveekia"]++;
                    attacker.objectiveekia = attacker.pers[#"objectiveekia"];
                    attacker.pers[#"objectives"]++;
                    attacker.objectives = attacker.pers[#"objectives"];
                    medalgiven = 1;
                }
                if (var_1cfdf798) {
                    if (!is_true(weaponiskillstreak)) {
                        scoreevents::processscoreevent(#"hardpoint_kill", attacker, idamage, weapon);
                        if (isdefined(idamage.var_1318544a)) {
                            idamage.var_1318544a.var_7b4d33ac = 1;
                        }
                    }
                    idamage recordkillmodifier("defending");
                }
                scoreeventprocessed = 1;
            } else {
                if (!medalgiven) {
                    if (var_1cfdf798) {
                        if (isdefined(attacker.pers[#"defends"])) {
                            attacker.pers[#"defends"]++;
                            attacker.defends = attacker.pers[#"defends"];
                        }
                        attacker medals::defenseglobalcount();
                        attacker thread challenges::killedbasedefender(level.zone.trig);
                        attacker recordgameevent("defending");
                    }
                    attacker challenges::function_2f462ffd(idamage, weapon, victim, level.zone.gameobject);
                    attacker.pers[#"objectiveekia"]++;
                    attacker.objectiveekia = attacker.pers[#"objectiveekia"];
                    attacker.pers[#"objectives"]++;
                    attacker.objectives = attacker.pers[#"objectives"];
                    medalgiven = 1;
                }
                if (var_1cfdf798) {
                    attacker challenges::killedzoneattacker(weapon);
                    if (!is_true(weaponiskillstreak)) {
                        scoreevents::processscoreevent(#"hardpoint_kill", attacker, idamage, weapon);
                        if (isdefined(idamage.var_1318544a)) {
                            idamage.var_1318544a.var_7b4d33ac = 1;
                        }
                    }
                }
                idamage recordkillmodifier("assaulting");
                scoreeventprocessed = 1;
            }
        }
    }
    if (isdefined(level.zone)) {
        if (isdefined(attacker) && isdefined(victim) && victim != attacker) {
            var_7901de48 = distance2dsquared(level.zone.trig.maxs, level.zone.trig.mins) * 0.5 + sqr(350);
            dist = distance2dsquared(victim.origin, level.zone.origin);
            if (dist > var_7901de48) {
                return;
            }
        }
    }
    if (attacker.touchtriggers.size || level.capturetime == 0 && attacker istouching(level.zone.trig)) {
        if (level.capturetime > 0) {
            triggerids = getarraykeys(attacker.touchtriggers);
            ownerteam = attacker.touchtriggers[triggerids[0]].useobj gameobjects::get_owner_team();
        }
        if (ownerteam != #"neutral") {
            team = idamage.pers[#"team"];
            if (team == ownerteam) {
                if (!medalgiven) {
                    if (isdefined(attacker.pers[#"defends"])) {
                        attacker.pers[#"defends"]++;
                        attacker.defends = attacker.pers[#"defends"];
                    }
                    if (var_1cfdf798) {
                        attacker medals::defenseglobalcount();
                        attacker thread challenges::killedbasedefender(level.zone.trig);
                        attacker recordgameevent("defending");
                    }
                    medalgiven = 1;
                }
                if (scoreeventprocessed == 0) {
                    if (var_1cfdf798) {
                        attacker challenges::killedzoneattacker(weapon);
                        if (!is_true(weaponiskillstreak)) {
                            scoreevents::processscoreevent(#"hardpoint_kill", attacker, idamage, weapon);
                            if (isdefined(idamage.var_1318544a)) {
                                idamage.var_1318544a.var_7b4d33ac = 1;
                            }
                        }
                        idamage recordkillmodifier("assaulting");
                    }
                    attacker challenges::function_2f462ffd(idamage, weapon, victim, level.zone.gameobject);
                    attacker.pers[#"objectiveekia"]++;
                    attacker.objectiveekia = attacker.pers[#"objectiveekia"];
                    attacker.pers[#"objectives"]++;
                    attacker.objectives = attacker.pers[#"objectives"];
                }
            } else {
                if (!medalgiven && var_1cfdf798) {
                    attacker medals::offenseglobalcount();
                    medalgiven = 1;
                    attacker thread challenges::killedbaseoffender(level.zone.trig, weapon, victim);
                }
                if (scoreeventprocessed == 0) {
                    if (var_1cfdf798) {
                        if (!is_true(weaponiskillstreak)) {
                            scoreevents::processscoreevent(#"hardpoint_kill", attacker, idamage, weapon);
                            if (isdefined(idamage.var_1318544a)) {
                                idamage.var_1318544a.var_7b4d33ac = 1;
                            }
                        }
                        idamage recordkillmodifier("defending");
                    }
                    attacker challenges::function_2f462ffd(idamage, weapon, victim, level.zone.gameobject);
                    attacker.pers[#"objectiveekia"]++;
                    attacker.objectiveekia = attacker.pers[#"objectiveekia"];
                    attacker.pers[#"objectives"]++;
                    attacker.objectives = attacker.pers[#"objectives"];
                }
            }
        }
    }
    if (var_1cfdf798 && scoreeventprocessed === 1) {
        attacker challenges::function_82bb78f7(weapon);
    }
}

// Namespace koth/koth
// Params 9, eflags: 0x0
// Checksum 0x868269a8, Offset: 0x5430
// Size: 0x4c
function onplayerkilled(*einflictor, *attacker, *idamage, *smeansofdeath, *weapon, *vdir, *shitloc, *psoffsettime, *deathanimduration) {
    
}

// Namespace koth/koth
// Params 1, eflags: 0x0
// Checksum 0xfdee378f, Offset: 0x5488
// Size: 0x3c
function enable_influencers(enabled) {
    enableinfluencer(self.influencer_large, enabled);
    enableinfluencer(self.influencer_small, enabled);
}

// Namespace koth/koth
// Params 0, eflags: 0x0
// Checksum 0x30a4b127, Offset: 0x54d0
// Size: 0x104
function createzonespawninfluencer() {
    self.influencer_large = self influencers::create_influencer("koth_large", self.gameobject.curorigin, 0);
    self.influencer_small = influencers::create_influencer("koth_small", self.gameobject.curorigin, 0);
    self enable_influencers(0);
    if ((isdefined(self.influencer_radius_small) ? self.influencer_radius_small : 0) > 0) {
        function_2e07e8f9(self.influencer_small, self.influencer_radius_small);
    }
    if ((isdefined(self.influencer_radius_large) ? self.influencer_radius_large : 0) > 0) {
        function_2e07e8f9(self.influencer_large, self.influencer_radius_large);
    }
}

// Namespace koth/koth
// Params 1, eflags: 0x0
// Checksum 0xc3647cbd, Offset: 0x55e0
// Size: 0x146
function updatecapsperminute(lastownerteam) {
    if (!isdefined(self.capsperminute)) {
        self.numcaps = 0;
        self.capsperminute = 0;
    }
    if (!isdefined(lastownerteam) || lastownerteam == #"neutral") {
        return;
    }
    self.numcaps++;
    minutespassed = float(globallogic_utils::gettimepassed()) / 60000;
    if (isplayer(self) && isdefined(self.timeplayed[#"total"])) {
        minutespassed = self.timeplayed[#"total"] / 60;
    }
    if (minutespassed <= 0) {
        self.capsperminute = self.numcaps;
        return;
    }
    self.capsperminute = self.numcaps / minutespassed;
    if (self.capsperminute > self.numcaps) {
        self.capsperminute = self.numcaps;
    }
}

// Namespace koth/koth
// Params 1, eflags: 0x0
// Checksum 0x2279a9de, Offset: 0x5730
// Size: 0x3a
function isscoreboosting(player) {
    if (!level.rankedmatch) {
        return false;
    }
    if (player.capsperminute > level.playercapturelpm) {
        return true;
    }
    return false;
}

// Namespace koth/koth
// Params 1, eflags: 0x0
// Checksum 0xc3df040a, Offset: 0x5778
// Size: 0x6e
function function_d3a438fb(entity) {
    if (!isdefined(level.zone) || !isdefined(level.zone.trig)) {
        return false;
    }
    if (entity istouching(level.zone.trig)) {
        return true;
    }
    return false;
}

// Namespace koth/koth
// Params 0, eflags: 0x0
// Checksum 0xecbc70cc, Offset: 0x57f0
// Size: 0x7c
function function_a2ef4132() {
    if (is_true(level.overtime)) {
        return;
    }
    if (isdefined(outcome::function_6d0354e3())) {
        round::function_870759fb();
        thread globallogic::end_round(2);
        return;
    }
    function_841cf30a();
}

// Namespace koth/koth
// Params 0, eflags: 0x0
// Checksum 0x9db314b3, Offset: 0x5878
// Size: 0xe0
function function_841cf30a() {
    level.overtime = 1;
    setmatchflag("bomb_timer_a", 0);
    globallogic_audio::leader_dialog("roundOvertime");
    foreach (player in level.players) {
        player luinotifyevent(#"hash_6b67aa04e378d681", 1, 8);
    }
}

// Namespace koth/koth
// Params 1, eflags: 0x4
// Checksum 0x3e3dfd2c, Offset: 0x5960
// Size: 0x11a
function private function_b11bd4e4(var_f99d1b44) {
    switch (var_f99d1b44) {
    case 0:
        return "spl1";
    case 1:
        return "spl2";
    case 2:
        return "spl3";
    case 3:
        return "spl4";
    case 4:
        return "spl5";
    case 5:
        return "spl6";
    case 6:
        return "spl7";
    case 7:
        return "spl8";
    case 8:
        return "spl9";
    case 9:
        return "fallback";
    }
    return "auto_normal";
}

// Namespace koth/koth
// Params 1, eflags: 0x4
// Checksum 0x11c151a3, Offset: 0x5a88
// Size: 0x5a
function private function_259770ba(*e_player) {
    if (spawning::usestartspawns() || !isdefined(level.zone.script_index)) {
        return undefined;
    }
    return function_b11bd4e4(level.zone.script_index);
}

// Namespace koth/koth
// Params 1, eflags: 0x4
// Checksum 0x750468df, Offset: 0x5af0
// Size: 0x2a
function private function_40c08152(*e_player) {
    if (spawning::usestartspawns()) {
        return undefined;
    }
    return "auto_normal";
}

/#

    // Namespace koth/koth
    // Params 0, eflags: 0x0
    // Checksum 0x5d4c07bc, Offset: 0x5b28
    // Size: 0x74
    function function_ed2b0a19() {
        for (index = 0; index < 10; index++) {
            spawning::function_25e7711a(function_b11bd4e4(index), #"none", "<dev string:x119>" + index + "<dev string:x128>", "<dev string:x12f>");
        }
    }

#/
