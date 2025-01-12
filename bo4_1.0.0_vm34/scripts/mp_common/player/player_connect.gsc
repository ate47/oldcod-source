#using scripts\core_common\bb_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gamestate;
#using scripts\core_common\high_value_operative;
#using scripts\core_common\hostmigration_shared;
#using scripts\core_common\persistence_shared;
#using scripts\core_common\player\player_role;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\spectating;
#using scripts\core_common\util_shared;
#using scripts\mp_common\draft;
#using scripts\mp_common\gamerep;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_audio;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_spawn;
#using scripts\mp_common\gametypes\globallogic_ui;
#using scripts\mp_common\gametypes\globallogic_utils;
#using scripts\mp_common\gametypes\menus;
#using scripts\mp_common\player\player;
#using scripts\mp_common\player\player_killed;
#using scripts\mp_common\player\player_monitor;
#using scripts\mp_common\player\player_record;

#namespace player;

// Namespace player/player_connect
// Params 0, eflags: 0x0
// Checksum 0x3e6abaef, Offset: 0x508
// Size: 0x1074
function callback_playerconnect() {
    thread function_c7efed3f();
    self.statusicon = "$default";
    self waittill(#"begin");
    if (isdefined(level.reset_clientdvars)) {
        self [[ level.reset_clientdvars ]]();
    }
    waittillframeend();
    self.statusicon = "";
    self.guid = self getguid();
    self.killstreak = [];
    self.leaderdialogqueue = [];
    self.killstreakdialogqueue = [];
    profilelog_begintiming(4, "ship");
    level notify(#"connected", {#player:self});
    self.var_b1f81f5d = 0;
    callback::callback(#"on_player_connect");
    if (self ishost()) {
        self thread globallogic::listenforgameend();
    }
    if (!level.splitscreen && !isdefined(self.pers[#"score"])) {
        if (!sessionmodeiswarzonegame()) {
            iprintln(#"mp/connected", self);
        }
    }
    function_5d5cf84();
    self gamerep::gamerepplayerconnected();
    lpselfnum = self getentitynumber();
    lpguid = self getguid();
    lpxuid = self getxuid(1);
    bb::function_e8ba589f(self.name, lpselfnum, lpxuid);
    recordplayerstats(self, "code_client_num", lpselfnum);
    if (!sessionmodeiszombiesgame()) {
        self setclientuivisibilityflag("hud_visible", 1);
        self setclientuivisibilityflag("weapon_hud_visible", 1);
    }
    self setclientplayersprinttime(level.playersprinttime);
    self setclientnumlives(level.numlives);
    if (level.hardcoremode) {
        self setclientdrawtalk(3);
    }
    self function_59965151();
    self.teamkillpunish = 0;
    if (level.minimumallowedteamkills >= 0 && self.pers[#"teamkills_nostats"] > level.minimumallowedteamkills) {
        self thread function_626cb430();
    }
    self.killedplayerscurrent = [];
    if (self.team != #"spectator" && util::isfirstround()) {
        if (game.state != "playing") {
            self thread globallogic_audio::set_music_on_player("spawnPreLoop");
        } else {
            self thread globallogic_audio::set_music_on_player("none");
        }
    } else if (self.team == #"spectator") {
        self thread globallogic_audio::set_music_on_player("none");
    }
    self.lastkilltime = 0;
    self.cur_death_streak = 0;
    self disabledeathstreak();
    self.gametype_kill_streak = 0;
    self.spawnqueueindex = -1;
    if (!isdefined(self.pers[#"deathtime"])) {
        self.pers[#"deathtime"] = 0;
    }
    self.deathtime = self.pers[#"deathtime"];
    self.class_num = 0;
    self.alivetimes = [];
    for (index = 0; index < level.alivetimemaxcount; index++) {
        self.alivetimes[index] = 0;
    }
    self.alivetimecurrentindex = 0;
    if (level.onlinegame && !(isdefined(level.freerun) && level.freerun)) {
        self.gametype_kill_streak = self stats::function_3774f22d(#"kill_streak");
        if (!isdefined(self.gametype_kill_streak)) {
            self.gametype_kill_streak = 0;
        }
    }
    self.lastgrenadesuicidetime = -1;
    self.teamkillsthisround = 0;
    if (!isdefined(level.livesdonotreset) || !level.livesdonotreset || !isdefined(self.pers[#"lives"])) {
        self.pers[#"lives"] = level.numlives;
    }
    if (!level.teambased) {
        self.pers[#"team"] = undefined;
    }
    init_heal(1, 0);
    self.hasspawned = 0;
    self.waitingtospawn = 0;
    self.wantsafespawn = 0;
    self.deathcount = 0;
    self.wasaliveatmatchstart = 0;
    level.players[level.players.size] = self;
    if (level.splitscreen) {
        setdvar(#"splitscreen_playernum", level.players.size);
    }
    if (gamestate::is_game_over()) {
        self.pers[#"needteam"] = 1;
        self.pers[#"team"] = #"spectator";
        self.team = self.sessionteam;
        self setclientuivisibilityflag("hud_visible", 0);
        self [[ level.spawnintermission ]]();
        self closeingamemenu();
        profilelog_endtiming(4, "gs=" + game.state);
        return;
    }
    if ((level.rankedmatch || level.leaguematch) && !isdefined(self.pers[#"lossalreadyreported"])) {
        globallogic_score::updatelossstats(self);
        self.pers[#"lossalreadyreported"] = 1;
    }
    if ((level.rankedmatch || level.leaguematch) && !isdefined(self.pers[#"latejoin"])) {
        if (game.state == "playing") {
            self.pers[#"latejoin"] = 1;
        } else {
            self.pers[#"latejoin"] = 0;
        }
    }
    if (!isdefined(self.pers[#"winstreakalreadycleared"])) {
        self globallogic_score::backupandclearwinstreaks();
        self.pers[#"winstreakalreadycleared"] = 1;
    }
    if (self istestclient()) {
        recordplayerstats(self, "is_bot", 1);
    }
    level endon(#"game_ended");
    if (isdefined(level.hostmigrationtimer)) {
        self thread hostmigration::hostmigrationtimerthink();
    }
    if (isdefined(self.pers[#"team"])) {
        self.team = self.pers[#"team"];
    }
    if (isdefined(self.pers[#"class"])) {
        self.curclass = self.pers[#"class"];
    }
    if (!isdefined(self.pers[#"team"]) || isdefined(self.pers[#"needteam"])) {
        var_697db1ee = getassignedteamname(self);
        self.pers[#"needteam"] = undefined;
        self.pers[#"team"] = #"spectator";
        self.team = #"spectator";
        self.sessionteam = #"spectator";
        self.sessionstate = "dead";
        self globallogic_ui::updateobjectivetext();
        [[ level.spawnspectator ]]();
        [[ level.autoassign ]](0, var_697db1ee);
        if ((level.rankedmatch || level.leaguematch) && level.var_83469c04 !== 1) {
            self thread globallogic_spawn::kickifdontspawn();
        }
        if (self.pers[#"team"] == #"spectator") {
            self.sessionteam = #"spectator";
            self thread spectate_player_watcher();
        }
        if (level.teambased) {
            self.sessionteam = self.pers[#"team"];
            if (!isalive(self)) {
                self.statusicon = "hud_status_dead";
            }
            self thread spectating::set_permissions();
        }
        init_character_index();
    } else if (self.pers[#"team"] == #"spectator") {
        [[ level.spawnspectator ]]();
        self.sessionteam = #"spectator";
        self.sessionstate = "spectator";
        self thread spectate_player_watcher();
    } else {
        self.sessionteam = self.pers[#"team"];
        self.sessionstate = "dead";
        self globallogic_ui::updateobjectivetext();
        [[ level.spawnspectator ]]();
        init_character_index();
        if (!draft::is_draft_this_round()) {
            if (globallogic_utils::isvalidclass(self.pers[#"class"]) && player_role::is_valid(self player_role::get())) {
                self thread [[ level.spawnclient ]]();
            } else {
                self globallogic_ui::showmainmenuforteam();
            }
        }
        self thread spectating::set_permissions();
    }
    if (self.sessionteam != #"spectator") {
        self thread spawning::onspawnplayer(1);
    }
    if (level.forceradar == 1) {
        self.pers[#"hasradar"] = 1;
        self.hasspyplane = 1;
        if (level.teambased) {
            level.activeuavs[self.team]++;
        } else {
            level.activeuavs[self getentitynumber()]++;
        }
        level.activeplayeruavs[self getentitynumber()]++;
    }
    if (level.forceradar == 2) {
        self setclientuivisibilityflag("g_compassShowEnemies", level.forceradar);
    } else {
        self setclientuivisibilityflag("g_compassShowEnemies", 0);
    }
    profilelog_endtiming(4, "gs=" + game.state);
    if (isbot(self)) {
        return;
    }
    self player_record::record_global_mp_stats_for_player_at_match_start();
    self hvo::function_6ce7e41a();
    num_con = getnumconnectedplayers();
    num_exp = getnumexpectedplayers();
    println("<dev string:x30>", num_con, "<dev string:x61>", num_exp);
    if (num_con == num_exp && num_exp != 0) {
        level flag::set("all_players_connected");
    }
    globallogic_score::updateweaponcontractstart(self);
    if (sessionmodeiswarzonegame()) {
        self callback::function_1dea870d(#"on_end_game", &player_monitor::function_153528fd);
    }
}

// Namespace player/player_connect
// Params 0, eflags: 0x4
// Checksum 0x848b96cc, Offset: 0x1588
// Size: 0x76e
function private function_5d5cf84() {
    if (!isdefined(self.pers[#"score"])) {
        self thread persistence::adjust_recent_stats();
        self stats::function_d7e9dd79(#"valid", 0);
    }
    if ((level.rankedmatch || level.leaguematch) && !isdefined(self.pers[#"matchesplayedstatstracked"])) {
        gamemode = util::getcurrentgamemode();
        self globallogic::incrementmatchcompletionstat(gamemode, "played", "started");
        if (!isdefined(self.pers[#"matcheshostedstatstracked"]) && self islocaltohost()) {
            self globallogic::incrementmatchcompletionstat(gamemode, "hosted", "started");
            self.pers[#"matcheshostedstatstracked"] = 1;
        }
        self.pers[#"matchesplayedstatstracked"] = 1;
        self thread persistence::upload_stats_soon();
    }
    if (!isdefined(self.pers[#"totaltimeplayed"])) {
        self setentertime(gettime());
        self.pers[#"totaltimeplayed"] = 0;
    }
    if (!isdefined(self.pers[#"totalmatchbonus"])) {
        self.pers[#"totalmatchbonus"] = 0;
    }
    if (!isdefined(self.pers[#"spawns"])) {
        self.pers[#"spawns"] = 0;
    }
    if (!isdefined(self.pers[#"best_kill_streak"])) {
        self.pers[#"killed_players"] = [];
        self.pers[#"killed_by"] = [];
        self.pers[#"nemesis_tracking"] = [];
        self.pers[#"artillery_kills"] = 0;
        self.pers[#"dog_kills"] = 0;
        self.pers[#"nemesis_name"] = "";
        self.pers[#"nemesis_rank"] = 0;
        self.pers[#"nemesis_rankicon"] = 0;
        self.pers[#"nemesis_xp"] = 0;
        self.pers[#"nemesis_xuid"] = "";
        self.pers[#"killed_players_with_specialist"] = [];
        self.pers[#"best_kill_streak"] = 0;
    }
    if (!isdefined(self.pers[#"music"])) {
        self.pers[#"music"] = spawnstruct();
        self.pers[#"music"].spawn = 0;
        self.pers[#"music"].inque = 0;
        self.pers[#"music"].currentstate = "SILENT";
        self.pers[#"music"].previousstate = "SILENT";
        self.pers[#"music"].nextstate = "UNDERSCORE";
        self.pers[#"music"].returnstate = "UNDERSCORE";
    }
    if (!isdefined(self.pers[#"cur_kill_streak"])) {
        self.pers[#"cur_kill_streak"] = 0;
    }
    if (!isdefined(self.pers[#"cur_total_kill_streak"])) {
        self.pers[#"cur_total_kill_streak"] = 0;
        self setplayercurrentstreak(0);
    }
    if (!isdefined(self.pers[#"totalkillstreakcount"])) {
        self.pers[#"totalkillstreakcount"] = 0;
    }
    if (!isdefined(self.pers[#"killstreaksearnedthiskillstreak"])) {
        self.pers[#"killstreaksearnedthiskillstreak"] = 0;
    }
    if (isdefined(level.usingscorestreaks) && level.usingscorestreaks && !isdefined(self.pers[#"killstreak_quantity"])) {
        self.pers[#"killstreak_quantity"] = [];
    }
    if (isdefined(level.usingscorestreaks) && level.usingscorestreaks && !isdefined(self.pers[#"held_killstreak_ammo_count"])) {
        self.pers[#"held_killstreak_ammo_count"] = [];
    }
    if (isdefined(level.usingscorestreaks) && level.usingscorestreaks && !isdefined(self.pers[#"held_killstreak_clip_count"])) {
        self.pers[#"held_killstreak_clip_count"] = [];
    }
    if (!isdefined(self.pers[#"changed_class"])) {
        self.pers[#"changed_class"] = 0;
    }
    if (!isdefined(self.pers[#"changed_specialist"])) {
        self.pers[#"changed_specialist"] = 0;
    }
    if (!isdefined(self.pers[#"lastroundscore"])) {
        self.pers[#"lastroundscore"] = 0;
    }
}

// Namespace player/player_connect
// Params 0, eflags: 0x4
// Checksum 0xa7ec1227, Offset: 0x1d00
// Size: 0x264
function private init_character_index() {
    /#
        autoselection = getdvarint(#"auto_select_character", -1);
        if (player_role::is_valid(autoselection)) {
            draft::select_character(autoselection, 1);
            return;
        }
        autoselection = getdvarstring(#"character");
        if (autoselection != "<dev string:x78>") {
            var_f8f209d2 = hash(autoselection);
            playerroletemplatecount = getplayerroletemplatecount(currentsessionmode());
            for (i = 0; i < playerroletemplatecount; i++) {
                var_66d06440 = function_b9650e7f(i, currentsessionmode());
                if (var_66d06440 == var_f8f209d2) {
                    draft::select_character(i, 1);
                    return;
                }
            }
        }
    #/
    if (!getgametypesetting(#"draftenabled")) {
        var_51322f17 = self function_f5860bc();
        if (var_51322f17 != 0) {
            draft::select_character(var_51322f17, 1);
            return;
        }
    }
    if (!draft::is_draft_this_round() && player_role::is_valid(self.pers[#"characterindex"])) {
        player_role::set(self.pers[#"characterindex"]);
    }
    self function_681d40bc(0);
}

// Namespace player/player_connect
// Params 0, eflags: 0x4
// Checksum 0x37c4ed5d, Offset: 0x1f70
// Size: 0x1082
function private function_59965151() {
    self globallogic_score::initpersstat("score");
    self globallogic_score::initpersstat("roleScore");
    self globallogic_score::initpersstat("objscore");
    self globallogic_score::initpersstat("damagedone");
    self globallogic_score::initpersstat("downs");
    self globallogic_score::initpersstat("revives");
    if (level.resetplayerscoreeveryround) {
        self.pers[#"score"] = 0;
        self.pers[#"rolescore"] = 0;
        self.pers[#"objscore"] = 0;
        self.pers[#"downs"] = 0;
        self.pers[#"revives"] = 0;
    }
    self.score = self.pers[#"score"];
    self.rolescore = self.pers[#"rolescore"];
    self.objscore = self.pers[#"objscore"];
    self.damagedone = self.pers[#"damagedone"];
    self.downs = self.pers[#"downs"];
    self.revives = self.pers[#"revives"];
    self globallogic_score::initpersstat("pointstowin");
    if (level.scoreroundwinbased) {
        self.pers[#"pointstowin"] = 0;
    }
    self.pointstowin = self.pers[#"pointstowin"];
    self.pers[#"outcome"] = #"loss";
    self globallogic_score::initpersstat("momentum", 0);
    self.momentum = self globallogic_score::getpersstat("momentum");
    self globallogic_score::initpersstat("suicides");
    self.suicides = self globallogic_score::getpersstat("suicides");
    self globallogic_score::initpersstat("headshots");
    self.headshots = self globallogic_score::getpersstat("headshots");
    self globallogic_score::initpersstat("challenges");
    self.challenges = self globallogic_score::getpersstat("challenges");
    self globallogic_score::initpersstat("EKIA");
    self.ekia = self globallogic_score::getpersstat("EKIA");
    self globallogic_score::initpersstat("ObjectiveEKIA");
    self.objectiveekia = self globallogic_score::getpersstat("ObjectiveEKIA");
    self globallogic_score::initpersstat("ObjectiveScore", 0);
    self.objectivescore = self globallogic_score::getpersstat("ObjectiveScore");
    self globallogic_score::initpersstat("ObjectiveDefends", 0);
    self.objectivedefends = self globallogic_score::getpersstat("ObjectiveDefends");
    self globallogic_score::initpersstat("ObjectiveTime", 0);
    self.objectivetime = self globallogic_score::getpersstat("ObjectiveTime");
    self globallogic_score::initpersstat("kills");
    self.kills = self globallogic_score::getpersstat("kills");
    self globallogic_score::initpersstat("deaths");
    self.deaths = self globallogic_score::getpersstat("deaths");
    self globallogic_score::initpersstat("assists");
    self.assists = self globallogic_score::getpersstat("assists");
    self globallogic_score::initpersstat("defends", 0);
    self.defends = self globallogic_score::getpersstat("defends");
    self globallogic_score::initpersstat("offends", 0);
    self.offends = self globallogic_score::getpersstat("offends");
    self globallogic_score::initpersstat("plants", 0);
    self.plants = self globallogic_score::getpersstat("plants");
    self globallogic_score::initpersstat("defuses", 0);
    self.defuses = self globallogic_score::getpersstat("defuses");
    self globallogic_score::initpersstat("returns", 0);
    self.returns = self globallogic_score::getpersstat("returns");
    self globallogic_score::initpersstat("captures", 0);
    self.captures = self globallogic_score::getpersstat("captures");
    self globallogic_score::initpersstat("objectives", 0);
    self.objectives = self globallogic_score::getpersstat("objectives");
    self globallogic_score::initpersstat("objtime", 0);
    self.objtime = self globallogic_score::getpersstat("objtime");
    self globallogic_score::initpersstat("carries", 0);
    self.carries = self globallogic_score::getpersstat("carries");
    self globallogic_score::initpersstat("throws", 0);
    self.throws = self globallogic_score::getpersstat("throws");
    self globallogic_score::initpersstat("destructions", 0);
    self.destructions = self globallogic_score::getpersstat("destructions");
    self globallogic_score::initpersstat("disables", 0);
    self.disables = self globallogic_score::getpersstat("disables");
    self globallogic_score::initpersstat("escorts", 0);
    self.escorts = self globallogic_score::getpersstat("escorts");
    self globallogic_score::initpersstat("sbtimeplayed", 0);
    self.sbtimeplayed = self globallogic_score::getpersstat("sbtimeplayed");
    self globallogic_score::initpersstat("backstabs", 0);
    self.backstabs = self globallogic_score::getpersstat("backstabs");
    self globallogic_score::initpersstat("longshots", 0);
    self.longshots = self globallogic_score::getpersstat("longshots");
    self globallogic_score::initpersstat("survived", 0);
    self.survived = self globallogic_score::getpersstat("survived");
    self globallogic_score::initpersstat("stabs", 0);
    self.stabs = self globallogic_score::getpersstat("stabs");
    self globallogic_score::initpersstat("tomahawks", 0);
    self.tomahawks = self globallogic_score::getpersstat("tomahawks");
    self globallogic_score::initpersstat("humiliated", 0);
    self.humiliated = self globallogic_score::getpersstat("humiliated");
    self globallogic_score::initpersstat("x2score", 0);
    self.x2score = self globallogic_score::getpersstat("x2score");
    self globallogic_score::initpersstat("agrkills", 0);
    self.x2score = self globallogic_score::getpersstat("agrkills");
    self globallogic_score::initpersstat("hacks", 0);
    self.x2score = self globallogic_score::getpersstat("hacks");
    self globallogic_score::initpersstat("killsconfirmed", 0);
    self.killsconfirmed = self globallogic_score::getpersstat("killsconfirmed");
    self globallogic_score::initpersstat("killsdenied", 0);
    self.killsdenied = self globallogic_score::getpersstat("killsdenied");
    self globallogic_score::initpersstat("rescues", 0);
    self.rescues = self globallogic_score::getpersstat("rescues");
    self globallogic_score::initpersstat("shotsfired", 0);
    self.shotsfired = self globallogic_score::getpersstat("shotsfired");
    self globallogic_score::initpersstat("shotshit", 0);
    self.shotshit = self globallogic_score::getpersstat("shotshit");
    self globallogic_score::initpersstat("shotsmissed", 0);
    self.shotsmissed = self globallogic_score::getpersstat("shotsmissed");
    self globallogic_score::initpersstat("victory", 0);
    self.victory = self globallogic_score::getpersstat("victory");
    self globallogic_score::initpersstat("sessionbans", 0);
    self.sessionbans = self globallogic_score::getpersstat("sessionbans");
    self globallogic_score::initpersstat("gametypeban", 0);
    self globallogic_score::initpersstat("time_played_total", 0);
    self globallogic_score::initpersstat("time_played_alive", 0);
    self globallogic_score::initpersstat("teamkills", 0);
    self globallogic_score::initpersstat("teamkills_nostats", 0);
    self globallogic_score::initpersstat("kill_distances", 0);
    self globallogic_score::initpersstat("num_kill_distance_entries", 0);
    self globallogic_score::initpersstat("time_played_moving", 0);
    self globallogic_score::initpersstat("total_speeds_when_moving", 0);
    self globallogic_score::initpersstat("num_speeds_when_moving_entries", 0);
    self globallogic_score::initpersstat("total_distance_travelled", 0);
    self globallogic_score::initpersstat("movement_Update_Count", 0);
    self globallogic_score::initpersstat("ability_medal_count", 0);
    self.ability_medal_count = self globallogic_score::getpersstat("ability_medal_count");
    self globallogic_score::initpersstat("equipment_medal_count", 0);
    self.equipment_medal_count = self globallogic_score::getpersstat("equipment_medal_count");
}

// Namespace player/player_connect
// Params 0, eflags: 0x4
// Checksum 0x329e0e, Offset: 0x3000
// Size: 0x5c
function private function_c7efed3f() {
    waittillframeend();
    if (isdefined(self)) {
        level notify(#"connecting", {#player:self});
    }
    callback::callback(#"on_player_connecting");
}

