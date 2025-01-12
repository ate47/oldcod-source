#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\hud_message_shared;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\gametypes\globallogic;
#using scripts\zm_common\gametypes\globallogic_audio;
#using scripts\zm_common\gametypes\globallogic_defaults;
#using scripts\zm_common\gametypes\globallogic_player;
#using scripts\zm_common\gametypes\globallogic_score;
#using scripts\zm_common\gametypes\globallogic_ui;
#using scripts\zm_common\gametypes\globallogic_utils;
#using scripts\zm_common\gametypes\hostmigration;
#using scripts\zm_common\gametypes\spawning;
#using scripts\zm_common\gametypes\spawnlogic;
#using scripts\zm_common\gametypes\spectating;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_utility;

#namespace globallogic_spawn;

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x2
// Checksum 0x8f2bb97d, Offset: 0x1e0
// Size: 0x2e
function autoexec init() {
    if (!isdefined(level.givestartloadout)) {
        level.givestartloadout = &givestartloadout;
    }
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 1, eflags: 0x0
// Checksum 0x4ee4b95, Offset: 0x218
// Size: 0xc0
function timeuntilspawn(includeteamkilldelay) {
    if (level.ingraceperiod && !self.hasspawned) {
        return 0;
    }
    respawndelay = 0;
    if (self.hasspawned) {
        result = self [[ level.onrespawndelay ]]();
        if (isdefined(result)) {
            respawndelay = result;
        } else {
            respawndelay = level.playerrespawndelay;
        }
    }
    wavebased = level.waverespawndelay > 0;
    if (wavebased) {
        return self timeuntilwavespawn(respawndelay);
    }
    return respawndelay;
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0x1e8aeaed, Offset: 0x2e0
// Size: 0x84
function allteamshaveexisted() {
    foreach (team, _ in level.teams) {
        if (!level.everexisted[team]) {
            return false;
        }
    }
    return true;
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0xda06c614, Offset: 0x370
// Size: 0x17a
function mayspawn() {
    if (isdefined(level.playermayspawn) && !self [[ level.playermayspawn ]]()) {
        return false;
    }
    if (level.inovertime) {
        return false;
    }
    if (level.playerqueuedrespawn && !isdefined(self.allowqueuespawn) && !level.ingraceperiod && !level.usestartspawns) {
        return false;
    }
    if (level.numlives) {
        if (level.teambased) {
            gamehasstarted = allteamshaveexisted();
        } else {
            gamehasstarted = level.maxplayercount > 1 || !util::isoneround() && !util::isfirstround();
        }
        if (!self.pers[#"lives"] && gamehasstarted) {
            return false;
        } else if (gamehasstarted) {
            if (!level.ingraceperiod && !self.hasspawned && !isbot(self)) {
                return false;
            }
        }
    }
    return true;
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 1, eflags: 0x0
// Checksum 0xeb03abff, Offset: 0x4f8
// Size: 0x124
function timeuntilwavespawn(minimumwait) {
    earliestspawntime = gettime() + minimumwait * 1000;
    lastwavetime = level.lastwave[self.pers[#"team"]];
    wavedelay = level.wavedelay[self.pers[#"team"]] * 1000;
    if (wavedelay == 0) {
        return 0;
    }
    numwavespassedearliestspawntime = (earliestspawntime - lastwavetime) / wavedelay;
    numwaves = ceil(numwavespassedearliestspawntime);
    timeofspawn = lastwavetime + numwaves * wavedelay;
    if (isdefined(self.wavespawnindex)) {
        timeofspawn += 50 * self.wavespawnindex;
    }
    return (timeofspawn - gettime()) / 1000;
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0xf4b50cb1, Offset: 0x628
// Size: 0x46
function stoppoisoningandflareonspawn() {
    self endon(#"disconnect");
    self.inpoisonarea = 0;
    self.inburnarea = 0;
    self.inflarevisionarea = 0;
    self.ingroundnapalm = 0;
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0xe374ed7, Offset: 0x678
// Size: 0xdc
function spawnplayerprediction() {
    self endon(#"disconnect", #"end_respawn", #"game_ended", #"joined_spectators", #"spawned");
    while (true) {
        wait 0.5;
        if (isdefined(level.onspawnplayerunified) && getdvarint(#"scr_disableunifiedspawning", 0) == 0) {
            spawning::onspawnplayer_unified(1);
            continue;
        }
        self [[ level.onspawnplayer ]](1);
    }
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 2, eflags: 0x0
// Checksum 0xf7cc3cf3, Offset: 0x760
// Size: 0xcc
function giveloadoutlevelspecific(team, _class) {
    pixbeginevent(#"giveloadoutlevelspecific");
    if (isdefined(level.givecustomcharacters)) {
        self [[ level.givecustomcharacters ]]();
    }
    if (isdefined(level.givestartloadout)) {
        self [[ level.givestartloadout ]]();
    }
    self flagsys::set(#"loadout_given");
    callback::callback(#"on_loadout");
    pixendevent();
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0xa24db11d, Offset: 0x838
// Size: 0x28
function givestartloadout() {
    if (isdefined(level.givecustomloadout)) {
        self [[ level.givecustomloadout ]]();
    }
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0x19a96876, Offset: 0x868
// Size: 0x68c
function spawnplayer() {
    pixbeginevent(#"spawnplayer_preuts");
    self endon(#"disconnect", #"joined_spectators");
    hadspawned = self.hasspawned;
    self player::spawn_player();
    if (!self.hasspawned) {
        self.underscorechance = 70;
    }
    self.laststand = undefined;
    self.revivingteammate = 0;
    self.burning = undefined;
    self.nextkillstreakfree = undefined;
    self.activeuavs = 0;
    self.activecounteruavs = 0;
    self.activesatellites = 0;
    self.maxarmor = 150;
    self.deathmachinekills = 0;
    self.diedonvehicle = undefined;
    if (!self.wasaliveatmatchstart) {
        if (level.ingraceperiod || globallogic_utils::gettimepassed() < 20000) {
            self.wasaliveatmatchstart = 1;
        }
    }
    pixbeginevent(#"onspawnplayer");
    if (isdefined(level.onspawnplayerunified) && getdvarint(#"scr_disableunifiedspawning", 0) == 0) {
        self [[ level.onspawnplayerunified ]]();
    } else {
        self [[ level.onspawnplayer ]](0);
    }
    if (isdefined(level.playerspawnedcb)) {
        self [[ level.playerspawnedcb ]]();
    }
    pixendevent();
    pixendevent();
    globallogic::updateteamstatus();
    pixbeginevent(#"spawnplayer_postuts");
    self thread stoppoisoningandflareonspawn();
    assert(globallogic_utils::isvalidclass(self.curclass));
    self giveloadoutlevelspecific(self.team, self.curclass);
    if (level.inprematchperiod) {
        self val::set(#"prematch_period", "freezecontrols");
        self val::set(#"prematch_period", "disablegadgets");
        self val::set(#"prematch_period", "disable_weapons");
    } else if (!hadspawned && game.state == "playing") {
        pixbeginevent(#"sound");
        team = self.team;
        if (isdefined(self.pers[#"music"].spawn) && self.pers[#"music"].spawn == 0) {
            self.pers[#"music"].spawn = 1;
        }
        if (level.splitscreen) {
            if (isdefined(level.playedstartingmusic)) {
                music = undefined;
            } else {
                level.playedstartingmusic = 1;
            }
        }
        pixendevent();
    }
    /#
        if (!level.splitscreen && getdvarint(#"scr_showperksonspawn", 0) == 1 && game.state != "<dev string:x30>") {
            pixbeginevent(#"showperksonspawn");
            if (level.perksenabled == 1) {
                self hud::showperks();
            }
            pixendevent();
        }
    #/
    if (isdefined(self.pers[#"momentum"])) {
        self.momentum = self.pers[#"momentum"];
    }
    pixendevent();
    waittillframeend();
    self notify(#"spawned_player");
    self callback::callback(#"on_player_spawned");
    /#
        print("<dev string:x39>" + self.origin[0] + "<dev string:x3c>" + self.origin[1] + "<dev string:x3c>" + self.origin[2] + "<dev string:x3e>");
    #/
    setdvar(#"scr_selecting_location", "");
    self zm_utility::set_max_health();
    if (game.state == "postgame") {
        assert(!level.intermission);
        self globallogic_player::freezeplayerforroundend();
    }
    self util::set_lighting_state();
    self util::set_sun_shadow_split_distance();
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 2, eflags: 0x0
// Checksum 0xba7d2359, Offset: 0xf00
// Size: 0x4c
function spawnspectator(origin, angles) {
    self notify(#"spawned");
    self notify(#"end_respawn");
    in_spawnspectator(origin, angles);
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 2, eflags: 0x0
// Checksum 0xa20746f1, Offset: 0xf58
// Size: 0x2c
function respawn_asspectator(origin, angles) {
    in_spawnspectator(origin, angles);
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 2, eflags: 0x0
// Checksum 0x144b21ce, Offset: 0xf90
// Size: 0x144
function in_spawnspectator(origin, angles) {
    pixmarker("BEGIN: in_spawnSpectator");
    self player::set_spawn_variables();
    self.sessionstate = "spectator";
    self.spectatorclient = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    self.friendlydamage = undefined;
    if (self.pers[#"team"] == "spectator") {
        self.statusicon = "";
    } else {
        self.statusicon = "hud_status_dead";
    }
    spectating::setspectatepermissionsformachine();
    [[ level.onspawnspectator ]](origin, angles);
    if (level.teambased && !level.splitscreen) {
        self thread spectatorthirdpersonness();
    }
    pixmarker("END: in_spawnSpectator");
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0x3b19399d, Offset: 0x10e0
// Size: 0x52
function spectatorthirdpersonness() {
    self notify(#"spectator_thirdperson_thread");
    self endon(#"disconnect", #"spawned", #"spectator_thirdperson_thread");
    self.spectatingthirdperson = 0;
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 1, eflags: 0x0
// Checksum 0xcde05acd, Offset: 0x1140
// Size: 0xf8
function forcespawn(time) {
    self endon(#"death", #"spawned");
    if (!isdefined(time)) {
        time = 60;
    }
    wait time;
    if (self.hasspawned) {
        return;
    }
    if (self.pers[#"team"] == "spectator") {
        return;
    }
    if (!globallogic_utils::isvalidclass(self.pers[#"class"])) {
        self.pers[#"class"] = "CLASS_CUSTOM1";
        self.curclass = self.pers[#"class"];
    }
    self thread [[ level.spawnclient ]]();
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0x107d443a, Offset: 0x1240
// Size: 0x64
function kickifdontspawn() {
    /#
        if (getdvarint(#"scr_hostmigrationtest", 0) == 1) {
            return;
        }
    #/
    if (self ishost()) {
        return;
    }
    self kickifidontspawninternal();
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0xdbdc47ea, Offset: 0x12b0
// Size: 0x1c4
function kickifidontspawninternal() {
    self endon(#"death", #"spawned");
    waittime = 90;
    if (getdvarstring(#"scr_kick_time") != "") {
        waittime = getdvarfloat(#"scr_kick_time", 0);
    }
    mintime = 45;
    if (getdvarstring(#"scr_kick_mintime") != "") {
        mintime = getdvarfloat(#"scr_kick_mintime", 0);
    }
    starttime = gettime();
    kickwait(waittime);
    timepassed = (gettime() - starttime) / 1000;
    if (timepassed < waittime - 0.1 && timepassed < mintime) {
        return;
    }
    if (self.hasspawned) {
        return;
    }
    if (sessionmodeisprivate()) {
        return;
    }
    if (self.pers[#"team"] == "spectator") {
        return;
    }
    kick(self getentitynumber());
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 1, eflags: 0x0
// Checksum 0x8c8ae795, Offset: 0x1480
// Size: 0x34
function kickwait(waittime) {
    level endon(#"game_ended");
    hostmigration::waitlongdurationwithhostmigrationpause(waittime);
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0x301e6dc5, Offset: 0x14c0
// Size: 0x10c
function spawninterroundintermission() {
    self notify(#"spawned");
    self notify(#"end_respawn");
    self player::set_spawn_variables();
    self hud_message::clearlowermessage();
    self.sessionstate = "spectator";
    self.spectatorclient = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    self.friendlydamage = undefined;
    self globallogic_defaults::default_onspawnintermission();
    self setorigin(self.origin);
    self setplayerangles(self.angles);
    self clientfield::set_to_player("player_dof_settings", 2);
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 1, eflags: 0x0
// Checksum 0x3a11b24a, Offset: 0x15d8
// Size: 0x244
function spawnintermission(usedefaultcallback) {
    self notify(#"spawned");
    self notify(#"end_respawn");
    self endon(#"disconnect");
    self player::set_spawn_variables();
    self hud_message::clearlowermessage();
    if (level.rankedmatch && util::waslastround()) {
        if (self.postgamemilestones || self.postgamecontracts || self.postgamepromotion) {
            if (self.postgamepromotion) {
                self playlocalsound(#"mus_level_up");
            } else if (self.postgamecontracts) {
                self playlocalsound(#"mus_challenge_complete");
            } else if (self.postgamemilestones) {
                self playlocalsound(#"mus_contract_complete");
            }
            self closeingamemenu();
            for (waittime = 4; waittime; waittime -= 0.25) {
                wait 0.25;
            }
        }
    }
    self.sessionstate = "intermission";
    self.spectatorclient = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    self.friendlydamage = undefined;
    if (isdefined(usedefaultcallback) && usedefaultcallback) {
        globallogic_defaults::default_onspawnintermission();
    } else {
        [[ level.onspawnintermission ]]();
    }
    if (game.state != "postgame") {
        self clientfield::set_to_player("player_dof_settings", 2);
    }
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 1, eflags: 0x0
// Checksum 0x21a4ca7a, Offset: 0x1828
// Size: 0xb4
function spawnqueuedclientonteam(team) {
    player_to_spawn = undefined;
    for (i = 0; i < level.deadplayers[team].size; i++) {
        player = level.deadplayers[team][i];
        if (player.waitingtospawn) {
            continue;
        }
        player_to_spawn = player;
        break;
    }
    if (isdefined(player_to_spawn)) {
        player_to_spawn.allowqueuespawn = 1;
        player_to_spawn thread [[ level.spawnclient ]]();
    }
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 2, eflags: 0x0
// Checksum 0xa2236415, Offset: 0x18e8
// Size: 0x130
function spawnqueuedclient(dead_player_team, killer) {
    if (!level.playerqueuedrespawn) {
        return;
    }
    util::waittillslowprocessallowed();
    spawn_team = undefined;
    if (isdefined(killer) && isdefined(killer.team) && isdefined(level.teams[killer.team])) {
        spawn_team = killer.team;
    }
    if (isdefined(spawn_team)) {
        spawnqueuedclientonteam(spawn_team);
        return;
    }
    foreach (team, _ in level.teams) {
        if (team == dead_player_team) {
            continue;
        }
        spawnqueuedclientonteam(team);
    }
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0x268781cd, Offset: 0x1a20
// Size: 0xc6
function allteamsnearscorelimit() {
    if (!level.teambased) {
        return false;
    }
    if (level.scorelimit <= 1) {
        return false;
    }
    foreach (team, _ in level.teams) {
        if (!(game.stat[#"teamscores"][team] >= level.scorelimit - 1)) {
            return false;
        }
    }
    return true;
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0xd15a3eb6, Offset: 0x1af0
// Size: 0x6e
function shouldshowrespawnmessage() {
    if (util::waslastround()) {
        return false;
    }
    if (util::isoneround()) {
        return false;
    }
    if (isdefined(level.livesdonotreset) && level.livesdonotreset) {
        return false;
    }
    if (allteamsnearscorelimit()) {
        return false;
    }
    return true;
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0x4d1de1e5, Offset: 0x1b68
// Size: 0x2c
function default_spawnmessage() {
    hud_message::setlowermessage(game.strings[#"spawn_next_round"]);
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0xb5c585ca, Offset: 0x1ba0
// Size: 0x28
function showspawnmessage() {
    if (shouldshowrespawnmessage()) {
        self thread [[ level.spawnmessage ]]();
    }
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 1, eflags: 0x0
// Checksum 0xe45d03d0, Offset: 0x1bd0
// Size: 0x184
function spawnclient(timealreadypassed) {
    pixbeginevent(#"spawnclient");
    assert(isdefined(self.team));
    assert(globallogic_utils::isvalidclass(self.curclass));
    if (!self mayspawn()) {
        currentorigin = self.origin;
        currentangles = self.angles;
        self showspawnmessage();
        self thread [[ level.spawnspectator ]](currentorigin + (0, 0, 60), currentangles);
        pixendevent();
        return;
    }
    if (self.waitingtospawn) {
        pixendevent();
        return;
    }
    self.waitingtospawn = 1;
    self.allowqueuespawn = undefined;
    self waitandspawnclient(timealreadypassed);
    if (isdefined(self)) {
        self.waitingtospawn = 0;
    }
    pixendevent();
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 1, eflags: 0x0
// Checksum 0x97ea8a1d, Offset: 0x1d60
// Size: 0x3ac
function waitandspawnclient(timealreadypassed) {
    self endon(#"disconnect", #"end_respawn");
    level endon(#"game_ended");
    if (!isdefined(timealreadypassed)) {
        timealreadypassed = 0;
    }
    spawnedasspectator = 0;
    if (!isdefined(self.wavespawnindex) && isdefined(level.waveplayerspawnindex[self.team])) {
        self.wavespawnindex = level.waveplayerspawnindex[self.team];
        level.waveplayerspawnindex[self.team]++;
    }
    timeuntilspawn = timeuntilspawn(0);
    if (timeuntilspawn > timealreadypassed) {
        timeuntilspawn -= timealreadypassed;
        timealreadypassed = 0;
    } else {
        timealreadypassed -= timeuntilspawn;
        timeuntilspawn = 0;
    }
    if (timeuntilspawn > 0) {
        if (level.playerqueuedrespawn) {
            hud_message::setlowermessage(game.strings[#"you_will_spawn"], timeuntilspawn);
        } else {
            hud_message::setlowermessage(game.strings[#"waiting_to_spawn"], timeuntilspawn);
        }
        if (!spawnedasspectator) {
            spawnorigin = self.origin + (0, 0, 60);
            spawnangles = self.angles;
            if (isdefined(level.useintermissionpointsonwavespawn) && [[ level.useintermissionpointsonwavespawn ]]() == 1) {
                spawnpoint = spawnlogic::getrandomintermissionpoint();
                if (isdefined(spawnpoint)) {
                    spawnorigin = spawnpoint.origin;
                    spawnangles = spawnpoint.angles;
                }
            }
            self thread respawn_asspectator(spawnorigin, spawnangles);
        }
        spawnedasspectator = 1;
        self globallogic_utils::waitfortimeornotify(timeuntilspawn, "force_spawn");
        self notify(#"stop_wait_safe_spawn_button");
    }
    wavebased = level.waverespawndelay > 0;
    if (!level.playerforcerespawn && self.hasspawned && !wavebased && !self.wantsafespawn && !level.playerqueuedrespawn) {
        hud_message::setlowermessage(game.strings[#"press_to_spawn"]);
        if (!spawnedasspectator) {
            self thread respawn_asspectator(self.origin + (0, 0, 60), self.angles);
        }
        spawnedasspectator = 1;
        self waitrespawnorsafespawnbutton();
    }
    self.waitingtospawn = 0;
    self.wavespawnindex = undefined;
    self.respawntimerstarttime = undefined;
    self thread [[ level.spawnplayer ]]();
    self hud_message::clearlowermessage();
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0x835e2830, Offset: 0x2118
// Size: 0x54
function waitrespawnorsafespawnbutton() {
    self endon(#"disconnect", #"end_respawn");
    while (true) {
        if (self usebuttonpressed()) {
            break;
        }
        waitframe(1);
    }
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0x74383261, Offset: 0x2178
// Size: 0xb2
function waitinspawnqueue() {
    self endon(#"disconnect", #"end_respawn");
    if (!level.ingraceperiod && !level.usestartspawns) {
        currentorigin = self.origin;
        currentangles = self.angles;
        self thread [[ level.spawnspectator ]](currentorigin + (0, 0, 60), currentangles);
        self waittill(#"queue_respawn");
    }
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 1, eflags: 0x0
// Checksum 0x670785c3, Offset: 0x2238
// Size: 0xdc
function setthirdperson(value) {
    if (!level.console) {
        return;
    }
    if (!isdefined(self.spectatingthirdperson) || value != self.spectatingthirdperson) {
        self.spectatingthirdperson = value;
        if (value) {
            self setclientthirdperson(1);
            self clientfield::set_to_player("player_dof_settings", 2);
        } else {
            self setclientthirdperson(0);
            self clientfield::set_to_player("player_dof_settings", 1);
        }
        self resetfov();
    }
}

