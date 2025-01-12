#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\demo_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\hostmigration_shared;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\medals_shared;
#using scripts\core_common\persistence_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\popups_shared;
#using scripts\core_common\potm_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\sound_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\challenges;
#using scripts\mp_common\gametypes\battlechatter;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_audio;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_spawn;
#using scripts\mp_common\gametypes\globallogic_utils;
#using scripts\mp_common\gametypes\hostmigration;
#using scripts\mp_common\gametypes\spawning;
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\spawnbeacon;
#using scripts\mp_common\util;

#namespace koth;

// Namespace koth/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x7e053538, Offset: 0x490
// Size: 0x3d2
function event_handler[gametype_init] main(eventstruct) {
    globallogic::init();
    util::registertimelimit(0, 1440);
    util::registerscorelimit(0, 1000);
    util::registernumlives(0, 100);
    util::registerroundswitch(0, 9);
    util::registerroundwinlimit(0, 10);
    globallogic::registerfriendlyfiredelay(level.gametype, 15, 0, 1440);
    level.doprematch = 1;
    level.overrideteamscore = 1;
    level.kothstarttime = 0;
    level.onstartgametype = &onstartgametype;
    level.playerspawnedcb = &koth_playerspawnedcb;
    player::function_b0320e78(&onplayerkilled);
    player::function_74c335a(&function_b794738);
    level.var_c5dae0c = &function_7cc39492;
    clientfield::register("world", "hardpoint", 1, 5, "int");
    clientfield::register("world", "hardpointteam", 1, 5, "int");
    level.zoneautomovetime = getgametypesetting(#"autodestroytime");
    level.zonespawntime = getgametypesetting(#"objectivespawntime");
    level.kothmode = getgametypesetting(#"kothmode");
    level.capturetime = getgametypesetting(#"capturetime");
    level.destroytime = getgametypesetting(#"destroytime");
    level.delayplayer = getgametypesetting(#"delayplayer");
    level.randomzonespawn = getgametypesetting(#"randomobjectivelocations");
    level.scoreperplayer = getgametypesetting(#"scoreperplayer");
    level.timepauseswheninzone = getgametypesetting(#"timepauseswheninzone");
    level.b_allow_vehicle_proximity_pickup = 1;
    globallogic_spawn::addsupportedspawnpointtype("koth");
    globallogic_audio::set_leader_gametype_dialog("startHardPoint", "hcStartHardPoint", "objCapture", "objCapture");
    game.objective_gained_sound = "mpl_flagcapture_sting_friend";
    game.objective_lost_sound = "mpl_flagcapture_sting_enemy";
    game.objective_contested_sound = "mpl_flagreturn_sting";
    level.zonespawnqueue = [];
}

// Namespace koth/koth
// Params 0, eflags: 0x4
// Checksum 0xa91308a5, Offset: 0x870
// Size: 0x132
function private function_284274e8() {
    level endon(#"game_ended");
    while (true) {
        waitframe(1);
        foreach (player in level.players) {
            if (isdefined(player.var_4f07a9c3)) {
                if (isdefined(level.zone.gameobject.iscontested) && level.zone.gameobject.iscontested || !isdefined(player.touchtriggers) || !isdefined(player.touchtriggers[level.zone.gameobject.entnum])) {
                    player.var_4f07a9c3 = undefined;
                }
            }
        }
    }
}

// Namespace koth/koth
// Params 3, eflags: 0x0
// Checksum 0x37c87688, Offset: 0x9b0
// Size: 0xd2
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
// Checksum 0xb58b98d2, Offset: 0xa90
// Size: 0x8e
function updateobjectivehintmessage(message) {
    foreach (team, _ in level.teams) {
        game.strings["objective_hint_" + team] = message;
    }
}

// Namespace koth/koth
// Params 0, eflags: 0x4
// Checksum 0x1d158885, Offset: 0xb28
// Size: 0x10c
function private function_495c3bab() {
    foreach (team, _ in level.teams) {
        spawning::add_spawn_points(team, "mp_tdm_spawn");
        spawning::add_spawn_points(team, "mp_multi_team_spawn");
        spawning::place_spawn_points(spawning::gettdmstartspawnname(team));
        spawning::add_start_spawn_points(team, spawning::gettdmstartspawnname(team));
    }
    spawning::updateallspawnpoints();
}

// Namespace koth/koth
// Params 0, eflags: 0x0
// Checksum 0xef61187e, Offset: 0xc40
// Size: 0x10c
function onstartgametype() {
    globallogic_score::resetteamscores();
    level.kothtotalsecondsinzone = 0;
    level.objectivehintpreparezone = #"mp/control_koth";
    level.objectivehintcapturezone = #"mp/capture_koth";
    level.objectivehintdefendhq = #"mp/defend_koth";
    if (level.zonespawntime) {
        updateobjectivehintmessage(level.objectivehintpreparezone);
    } else {
        updateobjectivehintmessage(level.objectivehintcapturezone);
    }
    function_495c3bab();
    if (!setupzones()) {
        return;
    }
    updategametypedvars();
    thread kothmainloop();
    thread function_284274e8();
}

// Namespace koth/koth
// Params 0, eflags: 0x0
// Checksum 0x653d209d, Offset: 0xd58
// Size: 0x32
function pause_time() {
    if (level.timepauseswheninzone) {
        globallogic_utils::pausetimer();
        level.timerpaused = 1;
    }
}

// Namespace koth/koth
// Params 0, eflags: 0x0
// Checksum 0x94985586, Offset: 0xd98
// Size: 0x5a
function resume_time() {
    if (level.timepauseswheninzone) {
        globallogic_utils::resumetimerdiscardoverride(int(level.kothtotalsecondsinzone * 1000));
        level.timerpaused = 0;
    }
}

// Namespace koth/koth
// Params 0, eflags: 0x0
// Checksum 0xbbee4dd7, Offset: 0xe00
// Size: 0x56
function updategametypedvars() {
    level.playercapturelpm = getgametypesetting(#"maxplayereventsperminute");
    level.timepauseswheninzone = getgametypesetting(#"timepauseswheninzone");
}

// Namespace koth/koth
// Params 1, eflags: 0x0
// Checksum 0xb337bd09, Offset: 0xe60
// Size: 0x17c
function spawn_first_zone(delay) {
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
        print("<dev string:x30>" + level.zone.trigorigin[0] + "<dev string:x40>" + level.zone.trigorigin[1] + "<dev string:x40>" + level.zone.trigorigin[2] + "<dev string:x42>");
    #/
    level.zone enable_influencers(1);
    level.zone.gameobject.trigger allowtacticalinsertion(0);
    spawn_beacon::function_8ebadd52(level.zone.trig);
}

// Namespace koth/koth
// Params 0, eflags: 0x0
// Checksum 0xbced77ad, Offset: 0xfe8
// Size: 0x18c
function spawn_next_zone() {
    level.zone.gameobject.trigger allowtacticalinsertion(1);
    if (level.randomzonespawn != 0) {
        level.zone = getnextzonefromqueue();
    } else {
        level.zone = getnextzone();
    }
    if (isdefined(level.zone)) {
        /#
            print("<dev string:x30>" + level.zone.trigorigin[0] + "<dev string:x40>" + level.zone.trigorigin[1] + "<dev string:x40>" + level.zone.trigorigin[2] + "<dev string:x42>");
        #/
        level.zone enable_influencers(1);
        spawn_beacon::function_8ebadd52(level.zone.trig);
    }
    level.zone.gameobject.trigger allowtacticalinsertion(0);
}

// Namespace koth/koth
// Params 0, eflags: 0x0
// Checksum 0xbdef3b1d, Offset: 0x1180
// Size: 0x8e
function getnumtouching() {
    numtouching = 0;
    foreach (team, _ in level.teams) {
        numtouching += self.numtouching[team];
    }
    return numtouching;
}

// Namespace koth/koth
// Params 1, eflags: 0x0
// Checksum 0x30d6a079, Offset: 0x1218
// Size: 0x6c
function togglezoneeffects(enabled) {
    index = 0;
    if (enabled) {
        index = self.script_index;
    }
    level clientfield::set("hardpoint", index);
    level clientfield::set("hardpointteam", 0);
}

// Namespace koth/koth
// Params 0, eflags: 0x0
// Checksum 0x537a621f, Offset: 0x1290
// Size: 0x510
function kothcaptureloop() {
    level endon(#"game_ended");
    level endon(#"zone_moved");
    level.kothstarttime = gettime();
    while (true) {
        level.zone.gameobject gameobjects::allow_use(#"any");
        level.zone.gameobject gameobjects::set_use_time(level.capturetime);
        level.zone.gameobject gameobjects::set_use_text(#"mp/capturing_objective");
        numtouching = level.zone.gameobject getnumtouching();
        level.zone.gameobject gameobjects::set_visible_team(#"any");
        level.zone.gameobject gameobjects::set_model_visibility(1);
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
        level.zone.gameobject gameobjects::allow_use(#"none");
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
// Checksum 0x21fb4904, Offset: 0x17a8
// Size: 0x600
function kothmainloop() {
    level endon(#"game_ended");
    spawn_first_zone();
    while (level.inprematchperiod) {
        waitframe(1);
    }
    pause_time();
    wait 5;
    setbombtimer("A", 0);
    setmatchflag("bomb_timer_a", 0);
    thread hidetimerdisplayongameend();
    while (true) {
        resume_time();
        sound::play_on_players("mp_suitcase_pickup");
        globallogic_audio::leader_dialog("kothLocated", undefined, undefined, "gamemode_objective", undefined, "kothActiveDialogBuffer");
        level.zone.gameobject gameobjects::set_model_visibility(1);
        if (level.zonespawntime) {
            level.zone.gameobject gameobjects::set_visible_team(#"any");
            level.zone.gameobject gameobjects::set_flags(1);
            updateobjectivehintmessage(level.objectivehintpreparezone);
            setmatchflag("bomb_timer_a", 1);
            setbombtimer("A", int(gettime() + 1000 + int(level.zonespawntime * 1000)));
            wait level.zonespawntime;
            level.zone.gameobject gameobjects::set_flags(0);
            globallogic_audio::leader_dialog("kothOnline", undefined, undefined, "gamemode_objective", undefined, "kothActiveDialogBuffer");
        }
        setmatchflag("bomb_timer_a", 0);
        waittillframeend();
        updateobjectivehintmessage(level.objectivehintcapturezone);
        sound::play_on_players("mpl_hq_cap_us");
        level.zone.gameobject gameobjects::enable_object();
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
        level.zone.gameobject gameobjects::allow_use(#"none");
        level.zone.gameobject gameobjects::set_owner_team(#"neutral");
        level.zone.gameobject gameobjects::set_model_visibility(0);
        level.zone.gameobject gameobjects::must_maintain_claim(0);
        level.zone togglezoneeffects(0);
        spawn_beacon::function_931025c3(level.zone.trig);
        level notify(#"zone_reset");
        setmatchflag("bomb_timer_a", 0);
        spawn_next_zone();
        wait 0.5;
        thread forcespawnteam(ownerteam);
        wait 0.5;
    }
}

// Namespace koth/koth
// Params 0, eflags: 0x0
// Checksum 0xeb672f0b, Offset: 0x1db0
// Size: 0x34
function hidetimerdisplayongameend() {
    level waittill(#"game_ended");
    setmatchflag("bomb_timer_a", 0);
}

// Namespace koth/koth
// Params 1, eflags: 0x0
// Checksum 0x44fe6140, Offset: 0x1df0
// Size: 0xaa
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
// Checksum 0x567da967, Offset: 0x1ea8
// Size: 0x104
function updateteamclientfield() {
    ownerteam = self gameobjects::get_owner_team();
    if (isdefined(self.iscontested) && self.iscontested) {
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
// Checksum 0x42dfb948, Offset: 0x1fb8
// Size: 0x58
function private iszonecontested(gameobject) {
    if (gameobject.touchlist[game.attackers].size > 0 && gameobject.touchlist[game.defenders].size > 0) {
        return true;
    }
    return false;
}

// Namespace koth/koth
// Params 0, eflags: 0x0
// Checksum 0xa961187f, Offset: 0x2018
// Size: 0x18e
function onupdateuserate() {
    if (!isdefined(self.iscontested)) {
        self.iscontested = 0;
        self.var_66214776 = 0;
    }
    self.iscontested = iszonecontested(self);
    if (self.iscontested) {
        if (!self.var_66214776) {
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
    }
}

// Namespace koth/koth
// Params 1, eflags: 0x0
// Checksum 0xf7de9599, Offset: 0x21b0
// Size: 0xae
function ontouchuse(sentient) {
    if (isplayer(sentient)) {
        self.var_66214776 = self.iscontested;
        if (iszonecontested(self) && (isdefined(sentient.var_8a599de9) ? sentient.var_8a599de9 : 0) < gettime()) {
            sentient playsoundtoplayer("mpl_control_capture_contested", sentient);
            sentient.var_8a599de9 = gettime() + 5000;
        }
    }
}

// Namespace koth/koth
// Params 1, eflags: 0x0
// Checksum 0x9d2f6170, Offset: 0x2268
// Size: 0xfc
function onbeginuse(sentient) {
    player = sentient;
    if (!isplayer(player)) {
        player = sentient.owner;
    }
    ownerteam = self gameobjects::get_owner_team();
    if (ownerteam == #"neutral") {
        player thread battlechatter::gametype_specific_battle_chatter("hq_protect", player.pers[#"team"]);
        return;
    }
    player thread battlechatter::gametype_specific_battle_chatter("hq_attack", player.pers[#"team"]);
}

// Namespace koth/koth
// Params 3, eflags: 0x0
// Checksum 0x166dbada, Offset: 0x2370
// Size: 0x70
function onenduse(team, sentient, success) {
    if (!isdefined(sentient)) {
        return;
    }
    player = sentient;
    if (!isplayer(player)) {
        player = sentient.owner;
    }
    player notify(#"event_ended");
}

// Namespace koth/koth
// Params 1, eflags: 0x0
// Checksum 0xd8eea716, Offset: 0x23e8
// Size: 0x480
function onzonecapture(sentient) {
    player = sentient;
    if (!isplayer(player)) {
        player = sentient.owner;
    }
    capture_team = player.team;
    capturetime = gettime();
    /#
        print("<dev string:x44>");
    #/
    pause_time();
    string = #"hash_446b7b0b3e4df72e";
    level.zone.gameobject.iscontested = 0;
    level.usestartspawns = 0;
    if (!isdefined(self.lastcaptureteam) || self.lastcaptureteam != capture_team) {
        touchlist = arraycopy(self.touchlist[capture_team]);
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
                globallogic_audio::leader_dialog("kothSecured", team, undefined, "gamemode_objective", undefined, "kothActiveDialogBuffer");
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
            globallogic_audio::leader_dialog("kothCaptured", team, undefined, "gamemode_objective", undefined, "kothActiveDialogBuffer");
        } else if (self.lastcaptureteam == team) {
            globallogic_audio::leader_dialog("kothLost", team, undefined, "gamemode_objective", undefined, "kothActiveDialogBuffer");
        }
        thread sound::play_on_players(game.objective_lost_sound, team);
    }
    self thread awardcapturepoints(capture_team, self.lastcaptureteam);
    self.capturecount++;
    self.lastcaptureteam = capture_team;
    self gameobjects::must_maintain_claim(1);
    self updateteamclientfield();
    player recordgameevent("hardpoint_captured");
    level notify(#"zone_captured");
    level notify("zone_captured" + capture_team);
    player notify(#"event_ended");
}

// Namespace koth/koth
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x2870
// Size: 0x4
function track_capture_time() {
    
}

// Namespace koth/koth
// Params 5, eflags: 0x0
// Checksum 0xa7f555, Offset: 0x2880
// Size: 0x358
function give_capture_credit(touchlist, string, capturetime, capture_team, lastcaptureteam) {
    waitframe(1);
    util::waittillslowprocessallowed();
    foreach (touch in touchlist) {
        player = gameobjects::function_4de10422(touchlist, touch);
        if (!isdefined(player)) {
            continue;
        }
        player updatecapsperminute(lastcaptureteam);
        if (!isscoreboosting(player)) {
            player challenges::capturedobjective(capturetime, self.trigger);
            if (level.kothstarttime + 3000 > capturetime && level.kothcapteam == capture_team) {
                scoreevents::processscoreevent(#"quickly_secure_point", player, undefined, undefined);
            }
            scoreevents::processscoreevent(#"koth_secure", player, undefined, undefined);
            player recordgameevent("capture");
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
            player stats::function_2dabbec7(#"captures", 1);
            continue;
        }
        /#
            player iprintlnbold("<dev string:x52>");
        #/
    }
}

// Namespace koth/koth
// Params 2, eflags: 0x0
// Checksum 0xbd260642, Offset: 0x2be0
// Size: 0xe0
function give_held_credit(touchlist, team) {
    waitframe(1);
    util::waittillslowprocessallowed();
    foreach (touch in touchlist) {
        player = gameobjects::function_4de10422(touchlist, touch);
        if (!isdefined(player)) {
            continue;
        }
        scoreevents::processscoreevent(#"koth_held", player, undefined, undefined);
    }
}

// Namespace koth/koth
// Params 0, eflags: 0x0
// Checksum 0x15ff4e0d, Offset: 0x2cc8
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
// Checksum 0x903ba4b1, Offset: 0x2d90
// Size: 0x160
function onzonecontested() {
    zoneowningteam = self gameobjects::get_owner_team();
    self.wascontested = 1;
    self.iscontested = 1;
    self updateteamclientfield();
    self recordgameeventnonplayer("hardpoint_contested");
    resume_time();
    util::function_d1f9db00(8, #"free");
    foreach (team, _ in level.teams) {
        if (team == zoneowningteam) {
            thread sound::play_on_players(game.objective_contested_sound, team);
            globallogic_audio::leader_dialog("kothContested", team, undefined, "gamemode_objective", undefined, "kothActiveDialogBuffer");
        }
    }
}

// Namespace koth/koth
// Params 1, eflags: 0x0
// Checksum 0xcc01a473, Offset: 0x2ef8
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
// Checksum 0x4cdc32a5, Offset: 0x2fc8
// Size: 0x1cc
function movezoneaftertime(time) {
    level endon(#"game_ended");
    level endon(#"zone_reset");
    level.zonemovetime = gettime() + int(time * 1000);
    level.zonedestroyedbytimer = 0;
    wait time;
    if (!isdefined(level.zone.gameobject.wascontested) || level.zone.gameobject.wascontested == 0) {
        if (!isdefined(level.zone.gameobject.wasleftunoccupied) || level.zone.gameobject.wasleftunoccupied == 0) {
            zoneowningteam = level.zone.gameobject gameobjects::get_owner_team();
            challenges::controlzoneentirely(zoneowningteam);
        }
    }
    level.zonedestroyedbytimer = 1;
    level.zone.gameobject recordgameeventnonplayer("hardpoint_moved");
    level notify(#"zone_moved");
    level.zone.gameobject.onuse = undefined;
    util::function_d1f9db00(6, #"free");
}

// Namespace koth/koth
// Params 2, eflags: 0x0
// Checksum 0xc1c13210, Offset: 0x31a0
// Size: 0x362
function awardcapturepoints(team, lastcaptureteam) {
    level endon(#"game_ended");
    level endon(#"zone_destroyed");
    level endon(#"zone_reset");
    level endon(#"zone_moved");
    level notify(#"awardcapturepointsrunning");
    level endon(#"awardcapturepointsrunning");
    foreach (player in level.players) {
        player.var_4f07a9c3 = undefined;
    }
    seconds = 1;
    score = 1;
    while (!level.gameended) {
        wait seconds;
        hostmigration::waittillhostmigrationdone();
        if (!level.zone.gameobject.iscontested) {
            if (level.scoreperplayer) {
                score = level.zone.gameobject.numtouching[team];
            }
            globallogic_score::giveteamscoreforobjective(team, score);
            level.kothtotalsecondsinzone++;
            foreach (player in level.aliveplayers[team]) {
                if (!isdefined(player.touchtriggers[self.entnum])) {
                    continue;
                }
                if (isdefined(player.pers[#"objtime"])) {
                    player.pers[#"objtime"]++;
                    player.objtime = player.pers[#"objtime"];
                }
                player stats::function_2dabbec7(#"objective_time", 1);
                player globallogic_score::incpersstat("objectiveTime", 1, 0, 1);
                if (!isdefined(player.var_4f07a9c3)) {
                    player.var_4f07a9c3 = gettime();
                    continue;
                }
                if (player.var_4f07a9c3 <= gettime() - 5000) {
                    player scoreevents::processscoreevent(#"hardpoint_owned", player);
                    player.var_4f07a9c3 = gettime();
                }
            }
        }
    }
}

// Namespace koth/koth
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x3510
// Size: 0x4
function koth_playerspawnedcb() {
    
}

// Namespace koth/koth
// Params 2, eflags: 0x0
// Checksum 0x1df7e8f1, Offset: 0x3520
// Size: 0xfc
function comparezoneindexes(zone_a, zone_b) {
    script_index_a = zone_a.script_index;
    script_index_b = zone_b.script_index;
    if (!isdefined(script_index_a) && !isdefined(script_index_b)) {
        return false;
    }
    if (!isdefined(script_index_a) && isdefined(script_index_b)) {
        println("<dev string:x97>" + zone_a.origin);
        return true;
    }
    if (isdefined(script_index_a) && !isdefined(script_index_b)) {
        println("<dev string:x97>" + zone_b.origin);
        return false;
    }
    if (script_index_a > script_index_b) {
        return true;
    }
    return false;
}

// Namespace koth/koth
// Params 0, eflags: 0x0
// Checksum 0x1d78ba2e, Offset: 0x3628
// Size: 0x11e
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
// Checksum 0xb76d1035, Offset: 0x3750
// Size: 0x430
function setupzones() {
    zones = getzonearray();
    if (zones.size == 0) {
        globallogic_utils::add_map_error("No zones found for KOTH in map " + util::get_map_name());
    }
    trigs = getentarray("koth_zone_trigger", "targetname");
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
                zone.trig trigger::function_5345af18(16);
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
        objective_name = #"hardpoint";
        zone.gameobject = gameobjects::create_use_object(#"neutral", zone.trig, visuals, (0, 0, 0), objective_name);
        zone.gameobject gameobjects::set_objective_entity(zone);
        zone.gameobject gameobjects::disable_object();
        zone.gameobject gameobjects::set_model_visibility(0);
        zone.trig.useobj = zone.gameobject;
        zone createzonespawninfluencer();
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
// Checksum 0x3b4609ff, Offset: 0x3b88
// Size: 0x1b2
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
// Params 0, eflags: 0x0
// Checksum 0x1a98bb45, Offset: 0x3d48
// Size: 0x88
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
// Checksum 0xc319e2bc, Offset: 0x3dd8
// Size: 0x82
function getnextzone() {
    nextzoneindex = (level.prevzoneindex + 1) % level.zones.size;
    zone = level.zones[nextzoneindex];
    level.prevzone2 = level.prevzone;
    level.prevzone = zone;
    level.prevzoneindex = nextzoneindex;
    return zone;
}

// Namespace koth/koth
// Params 0, eflags: 0x0
// Checksum 0x4c2b4a1f, Offset: 0x3e68
// Size: 0x76
function pickrandomzonetospawn() {
    level.prevzoneindex = randomint(level.zones.size);
    zone = level.zones[level.prevzoneindex];
    level.prevzone2 = level.prevzone;
    level.prevzone = zone;
    return zone;
}

// Namespace koth/koth
// Params 0, eflags: 0x0
// Checksum 0x67aa6007, Offset: 0x3ee8
// Size: 0x14a
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
// Checksum 0x4294d74f, Offset: 0x4040
// Size: 0x90
function getnextzonefromqueue() {
    if (level.zonespawnqueue.size == 0) {
        shufflezones();
    }
    assert(level.zonespawnqueue.size > 0);
    next_zone = level.zonespawnqueue[0];
    arrayremoveindex(level.zonespawnqueue, 0);
    return next_zone;
}

// Namespace koth/koth
// Params 0, eflags: 0x0
// Checksum 0xa988c90e, Offset: 0x40d8
// Size: 0x28
function function_7cc39492() {
    if (isdefined(level.zone)) {
        return level.zone.origin;
    }
}

// Namespace koth/koth
// Params 4, eflags: 0x0
// Checksum 0x388a4102, Offset: 0x4108
// Size: 0xadc
function function_b794738(einflictor, victim, idamage, weapon) {
    attacker = self;
    if (!isplayer(attacker) || level.capturetime && !victim.touchtriggers.size && !attacker.touchtriggers.size || attacker.pers[#"team"] == victim.pers[#"team"]) {
        return;
    }
    if (isdefined(weapon) && isdefined(level.iskillstreakweapon)) {
        if ([[ level.iskillstreakweapon ]](weapon) || isdefined(weapon.statname) && [[ level.iskillstreakweapon ]](getweapon(weapon.statname))) {
            return;
        }
    }
    medalgiven = 0;
    scoreeventprocessed = 0;
    ownerteam = undefined;
    if (level.capturetime == 0) {
        if (!isdefined(level.zone)) {
            return;
        }
        ownerteam = level.zone.gameobject.ownerteam;
        if (!isdefined(ownerteam) || ownerteam == #"neutral") {
            return;
        }
    }
    if (victim.touchtriggers.size || level.capturetime == 0 && victim istouching(level.zone.trig)) {
        if (level.capturetime > 0) {
            triggerids = getarraykeys(victim.touchtriggers);
            ownerteam = victim.touchtriggers[triggerids[0]].useobj.ownerteam;
        }
        if (ownerteam != #"neutral") {
            attacker.lastkilltime = gettime();
            team = attacker.pers[#"team"];
            if (team == ownerteam) {
                if (!medalgiven) {
                    attacker medals::offenseglobalcount();
                    attacker thread challenges::killedbaseoffender(level.zone.trig, weapon);
                    attacker.pers[#"objectiveekia"]++;
                    attacker.objectiveekia = attacker.pers[#"objectiveekia"];
                    attacker.pers[#"objectives"]++;
                    attacker.objectives = attacker.pers[#"objectives"];
                    medalgiven = 1;
                }
                scoreevents::processscoreevent(#"hardpoint_kill", attacker, undefined, weapon);
                victim recordkillmodifier("defending");
                scoreeventprocessed = 1;
            } else {
                if (!medalgiven) {
                    if (isdefined(attacker.pers[#"defends"])) {
                        attacker.pers[#"defends"]++;
                        attacker.defends = attacker.pers[#"defends"];
                    }
                    attacker medals::defenseglobalcount();
                    medalgiven = 1;
                    attacker thread challenges::killedbasedefender(level.zone.trig);
                    attacker.pers[#"objectiveekia"]++;
                    attacker.objectiveekia = attacker.pers[#"objectiveekia"];
                    attacker.pers[#"objectives"]++;
                    attacker.objectives = attacker.pers[#"objectives"];
                    attacker recordgameevent("defending");
                }
                attacker challenges::killedzoneattacker(weapon);
                scoreevents::processscoreevent(#"hardpoint_kill", attacker, undefined, weapon);
                victim recordkillmodifier("assaulting");
                scoreeventprocessed = 1;
            }
        }
    }
    if (isdefined(level.zone)) {
        if (isdefined(attacker) && isdefined(einflictor) && einflictor != attacker) {
            var_2453d80f = distance2dsquared(level.zone.trig.maxs, level.zone.trig.mins) * 0.5 + 350 * 350;
            dist = distance2dsquared(einflictor.origin, level.zone.origin);
            if (dist > var_2453d80f) {
                return;
            }
        }
    }
    if (attacker.touchtriggers.size || level.capturetime == 0 && attacker istouching(level.zone.trig)) {
        if (level.capturetime > 0) {
            triggerids = getarraykeys(attacker.touchtriggers);
            ownerteam = attacker.touchtriggers[triggerids[0]].useobj.ownerteam;
        }
        if (ownerteam != #"neutral") {
            team = victim.pers[#"team"];
            if (team == ownerteam) {
                if (!medalgiven) {
                    if (isdefined(attacker.pers[#"defends"])) {
                        attacker.pers[#"defends"]++;
                        attacker.defends = attacker.pers[#"defends"];
                    }
                    attacker medals::defenseglobalcount();
                    medalgiven = 1;
                    attacker thread challenges::killedbasedefender(level.zone.trig);
                    attacker recordgameevent("defending");
                }
                if (scoreeventprocessed == 0) {
                    attacker challenges::killedzoneattacker(weapon);
                    scoreevents::processscoreevent(#"hardpoint_kill", attacker, undefined, weapon);
                    victim recordkillmodifier("assaulting");
                    attacker.pers[#"objectiveekia"]++;
                    attacker.objectiveekia = attacker.pers[#"objectiveekia"];
                    attacker.pers[#"objectives"]++;
                    attacker.objectives = attacker.pers[#"objectives"];
                }
            } else {
                if (!medalgiven) {
                    attacker medals::offenseglobalcount();
                    medalgiven = 1;
                    attacker thread challenges::killedbaseoffender(level.zone.trig, weapon);
                }
                if (scoreeventprocessed == 0) {
                    scoreevents::processscoreevent(#"hardpoint_kill", attacker, undefined, weapon);
                    victim recordkillmodifier("defending");
                    attacker.pers[#"objectiveekia"]++;
                    attacker.objectiveekia = attacker.pers[#"objectiveekia"];
                    attacker.pers[#"objectives"]++;
                    attacker.objectives = attacker.pers[#"objectives"];
                }
            }
        }
    }
    if (medalgiven == 1) {
        if (isdefined(level.zone.gameobject.iscontested) && level.zone.gameobject.iscontested) {
            attacker thread killwhilecontesting();
        }
    }
}

// Namespace koth/koth
// Params 9, eflags: 0x0
// Checksum 0xab77c188, Offset: 0x4bf0
// Size: 0x4c
function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    
}

// Namespace koth/koth
// Params 0, eflags: 0x0
// Checksum 0x64712514, Offset: 0x4c48
// Size: 0x17e
function killwhilecontesting() {
    self notify(#"killwhilecontesting");
    self endon(#"killwhilecontesting");
    self endon(#"disconnect");
    killtime = gettime();
    playerteam = self.pers[#"team"];
    if (!isdefined(self.clearenemycount)) {
        self.clearenemycount = 0;
    }
    self.clearenemycount++;
    var_b34f24c5 = level waittill("zone_captured" + playerteam, #"zone_destroyed", #"hardpoint_uncontested", #"zone_captured", #"death");
    if (var_b34f24c5._notify == "death" || playerteam != self.pers[#"team"]) {
        self.clearenemycount = 0;
        return;
    }
    if (self.clearenemycount >= 2 && killtime + 200 > gettime()) {
        scoreevents::processscoreevent(#"clear_2_attackers", self, undefined, undefined);
    }
    self.clearenemycount = 0;
}

// Namespace koth/koth
// Params 1, eflags: 0x0
// Checksum 0x7c4cbf7d, Offset: 0x4dd0
// Size: 0x3c
function enable_influencers(enabled) {
    enableinfluencer(self.influencer_large, enabled);
    enableinfluencer(self.influencer_small, enabled);
}

// Namespace koth/koth
// Params 0, eflags: 0x0
// Checksum 0xfbf581e1, Offset: 0x4e18
// Size: 0x84
function createzonespawninfluencer() {
    self.influencer_large = self influencers::create_influencer("koth_large", self.gameobject.curorigin, 0);
    self.influencer_small = influencers::create_influencer("koth_small", self.gameobject.curorigin, 0);
    self enable_influencers(0);
}

// Namespace koth/koth
// Params 1, eflags: 0x0
// Checksum 0xa815c954, Offset: 0x4ea8
// Size: 0x12a
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
    self.capsperminute = self.numcaps / minutespassed;
    if (self.capsperminute > self.numcaps) {
        self.capsperminute = self.numcaps;
    }
}

// Namespace koth/koth
// Params 1, eflags: 0x0
// Checksum 0x53b75e71, Offset: 0x4fe0
// Size: 0x3e
function isscoreboosting(player) {
    if (!level.rankedmatch) {
        return false;
    }
    if (player.capsperminute > level.playercapturelpm) {
        return true;
    }
    return false;
}

