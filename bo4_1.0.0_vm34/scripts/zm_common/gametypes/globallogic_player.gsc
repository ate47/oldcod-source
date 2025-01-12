#using scripts\core_common\array_shared;
#using scripts\core_common\bb_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\demo_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\globallogic\globallogic_player;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\hud_message_shared;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\struct;
#using scripts\core_common\tweakables_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\weapons_shared;
#using scripts\weapons\weapon_utils;
#using scripts\zm_common\gametypes\globallogic;
#using scripts\zm_common\gametypes\globallogic_audio;
#using scripts\zm_common\gametypes\globallogic_score;
#using scripts\zm_common\gametypes\globallogic_spawn;
#using scripts\zm_common\gametypes\globallogic_ui;
#using scripts\zm_common\gametypes\globallogic_utils;
#using scripts\zm_common\gametypes\hostmigration;
#using scripts\zm_common\gametypes\spawning;
#using scripts\zm_common\gametypes\spawnlogic;
#using scripts\zm_common\gametypes\spectating;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_stats;

#namespace globallogic_player;

// Namespace globallogic_player/globallogic_player
// Params 0, eflags: 0x0
// Checksum 0xe6a87bea, Offset: 0x230
// Size: 0x84
function freezeplayerforroundend() {
    self hud_message::clearlowermessage();
    self closeingamemenu();
    self val::set(#"round_end", "freezecontrols");
    self val::set(#"round_end", "disablegadgets");
}

// Namespace globallogic_player/globallogic_player
// Params 0, eflags: 0x0
// Checksum 0x78304998, Offset: 0x2c0
// Size: 0x34
function init_character_index() {
    self.pers[#"characterindex"] = 0;
    self setspecialistindex(0);
}

// Namespace globallogic_player/globallogic_player
// Params 0, eflags: 0x0
// Checksum 0x1fdab651, Offset: 0x300
// Size: 0x1074
function callback_playerconnect() {
    thread notifyconnecting();
    self.statusicon = "$default";
    self waittill(#"begin");
    if (isdefined(level.reset_clientdvars)) {
        self [[ level.reset_clientdvars ]]();
    }
    waittillframeend();
    self.statusicon = "";
    self.guid = self getguid();
    profilelog_begintiming(4, "ship");
    level notify(#"connected", {#player:self});
    demo::reset_actor_bookmark_kill_times();
    callback::callback(#"on_player_connect");
    if (self ishost()) {
        self thread globallogic::listenforgameend();
    }
    if (!level.splitscreen && !isdefined(self.pers[#"score"])) {
        iprintln(#"mp/connected", self);
    }
    if (!isdefined(self.pers[#"score"])) {
        self thread zm_stats::adjustrecentstats();
    }
    if (gamemodeismode(0) && !isdefined(self.pers[#"matchesplayedstatstracked"])) {
        gamemode = util::getcurrentgamemode();
        self globallogic::incrementmatchcompletionstat(gamemode, "played", "started");
        if (!isdefined(self.pers[#"matcheshostedstatstracked"]) && self islocaltohost()) {
            self globallogic::incrementmatchcompletionstat(gamemode, "hosted", "started");
            self.pers[#"matcheshostedstatstracked"] = 1;
        }
        self.pers[#"matchesplayedstatstracked"] = 1;
        self thread zm_stats::uploadstatssoon();
    }
    init_character_index();
    lpselfnum = self getentitynumber();
    lpguid = self getguid();
    lpxuid = self getxuid(1);
    bb::function_e8ba589f(self.name, lpselfnum, lpxuid);
    if (level.forceradar == 1) {
        self.pers[#"hasradar"] = 1;
        self.hasspyplane = 1;
        level.activeuavs[self getentitynumber()] = 1;
    }
    if (level.forceradar == 2) {
        self setclientuivisibilityflag("g_compassShowEnemies", level.forceradar);
    } else {
        self setclientuivisibilityflag("g_compassShowEnemies", 0);
    }
    self setclientplayersprinttime(level.playersprinttime);
    self setclientnumlives(level.numlives);
    self [[ level.player_stats_init ]]();
    self.killedplayerscurrent = [];
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
    self.leaderdialogqueue = [];
    self.leaderdialogactive = 0;
    self.leaderdialoggroups = [];
    self.currentleaderdialoggroup = "";
    self.currentleaderdialog = "";
    self.currentleaderdialogtime = 0;
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
    self.lastkilltime = 0;
    self.cur_death_streak = 0;
    self disabledeathstreak();
    self.death_streak = 0;
    self.kill_streak = 0;
    self.gametype_kill_streak = 0;
    self.spawnqueueindex = -1;
    self.deathtime = 0;
    self.lastgrenadesuicidetime = -1;
    self.teamkillsthisround = 0;
    player::init_heal(1, 1);
    if (!isdefined(level.livesdonotreset) || !level.livesdonotreset || !isdefined(self.pers[#"lives"])) {
        self.pers[#"lives"] = level.numlives;
    }
    if (!level.teambased) {
        self.pers[#"team"] = undefined;
    }
    self.hasspawned = 0;
    self.waitingtospawn = 0;
    self.wantsafespawn = 0;
    self.deathcount = 0;
    self.wasaliveatmatchstart = 0;
    if (level.splitscreen) {
        setdvar(#"splitscreen_playernum", level.players.size);
    }
    if (game.state == "postgame") {
        self.pers[#"needteam"] = 1;
        self.pers[#"team"] = "spectator";
        self.team = "spectator";
        self.sessionteam = "spectator";
        self setclientuivisibilityflag("hud_visible", 0);
        self [[ level.spawnintermission ]]();
        self closeingamemenu();
        profilelog_endtiming(4, "gs=" + game.state + " zom=" + sessionmodeiszombiesgame());
        return;
    }
    level endon(#"game_ended");
    if (isdefined(level.hostmigrationtimer)) {
        self thread hostmigration::hostmigrationtimerthink();
    }
    if (level.oldschool) {
        self.pers[#"class"] = undefined;
        self.curclass = self.pers[#"class"];
    }
    if (isdefined(self.pers[#"team"])) {
        self.team = self.pers[#"team"];
    }
    if (isdefined(self.pers[#"class"])) {
        self.curclass = self.pers[#"class"];
    }
    if (!isdefined(self.pers[#"team"]) || isdefined(self.pers[#"needteam"])) {
        self.pers[#"needteam"] = undefined;
        self.pers[#"team"] = "spectator";
        self.team = "spectator";
        self.sessionstate = "dead";
        [[ level.spawnspectator ]]();
        if (level.rankedmatch) {
            [[ level.autoassign ]](0);
            self thread globallogic_spawn::kickifdontspawn();
        } else {
            [[ level.autoassign ]](0);
        }
        if (self.pers[#"team"] == "spectator") {
            self.sessionteam = "spectator";
            self thread spectate_player_watcher();
        }
        if (level.teambased) {
            self.sessionteam = self.pers[#"team"];
            if (!isalive(self)) {
                self.statusicon = "hud_status_dead";
            }
            self thread spectating::setspectatepermissions();
        }
    } else if (self.pers[#"team"] == "spectator") {
        [[ level.spawnspectator ]]();
        self.sessionteam = "spectator";
        self.sessionstate = "spectator";
        self thread spectate_player_watcher();
    } else {
        self.sessionteam = self.pers[#"team"];
        self.sessionstate = "dead";
        [[ level.spawnspectator ]]();
        if (globallogic_utils::isvalidclass(self.pers[#"class"])) {
            self thread [[ level.spawnclient ]]();
        }
        self thread spectating::setspectatepermissions();
    }
    if (self.sessionteam != "spectator") {
        self thread spawning::onspawnplayer_unified(1);
    }
    profilelog_endtiming(4, "gs=" + game.state + " zom=" + sessionmodeiszombiesgame());
    if (!isdefined(level.players)) {
        level.players = [];
    } else if (!isarray(level.players)) {
        level.players = array(level.players);
    }
    if (!isinarray(level.players, self)) {
        level.players[level.players.size] = self;
    }
    globallogic::updateteamstatus();
}

// Namespace globallogic_player/globallogic_player
// Params 0, eflags: 0x0
// Checksum 0xc779a613, Offset: 0x1380
// Size: 0x284
function spectate_player_watcher() {
    self endon(#"disconnect");
    self.watchingactiveclient = 1;
    while (true) {
        if (self.pers[#"team"] != "spectator" || level.gameended) {
            self val::reset(#"spectate", "freezecontrols");
            self.watchingactiveclient = 0;
            break;
        }
        /#
            if (!level.splitscreen && !level.hardcoremode && getdvarint(#"scr_showperksonspawn", 0) == 1 && game.state != "<dev string:x30>" && !isdefined(self.perkhudelem)) {
                if (level.perksenabled == 1) {
                    self hud::showperks();
                }
            }
        #/
        count = 0;
        for (i = 0; i < level.players.size; i++) {
            if (level.players[i].team != "spectator") {
                count++;
                break;
            }
        }
        if (count > 0) {
            if (!self.watchingactiveclient) {
                self val::reset(#"spectate", "freezecontrols");
                println("<dev string:x39>");
            }
            self.watchingactiveclient = 1;
        } else {
            if (self.watchingactiveclient) {
                [[ level.onspawnspectator ]]();
                self val::set(#"spectate", "freezecontrols", 1);
            }
            self.watchingactiveclient = 0;
        }
        wait 0.5;
    }
}

// Namespace globallogic_player/globallogic_player
// Params 0, eflags: 0x0
// Checksum 0x3d88733d, Offset: 0x1610
// Size: 0xd0
function callback_playermigrated() {
    println("<dev string:x4e>" + self.name + "<dev string:x56>" + gettime());
    if (isdefined(self.connected) && self.connected) {
    }
    self thread inform_clientvm_of_migration();
    level.hostmigrationreturnedplayercount++;
    if (level.hostmigrationreturnedplayercount >= level.players.size * 2 / 3) {
        println("<dev string:x73>");
        level notify(#"hostmigration_enoughplayers");
    }
}

// Namespace globallogic_player/globallogic_player
// Params 0, eflags: 0x0
// Checksum 0x7335bb46, Offset: 0x16e8
// Size: 0x20
function inform_clientvm_of_migration() {
    self endon(#"disconnect");
    wait 1;
}

// Namespace globallogic_player/globallogic_player
// Params 1, eflags: 0x0
// Checksum 0x3d600c57, Offset: 0x1710
// Size: 0x82
function arraytostring(inputarray) {
    targetstring = "";
    for (i = 0; i < inputarray.size; i++) {
        targetstring += inputarray[i];
        if (i != inputarray.size - 1) {
            targetstring += ",";
        }
    }
    return targetstring;
}

// Namespace globallogic_player/globallogic_player
// Params 2, eflags: 0x0
// Checksum 0x67cc1de, Offset: 0x17a0
// Size: 0x6e4
function function_12cd49c1(player, result) {
    lpselfnum = player getentitynumber();
    lpxuid = player getxuid(1);
    bb::function_a8a8fbfc(player.name, lpselfnum, lpxuid);
    primaryweaponname = #"";
    primaryweaponattachstr = "";
    secondaryweaponname = #"";
    secondaryweaponattachstr = "";
    if (isdefined(player.primaryloadoutweapon)) {
        primaryweaponname = player.primaryloadoutweapon.name;
        primaryweaponattachstr = arraytostring(getarraykeys(player.primaryloadoutweapon.attachments));
    }
    if (isdefined(player.secondaryloadoutweapon)) {
        secondaryweaponname = player.secondaryloadoutweapon.name;
        secondaryweaponattachstr = arraytostring(getarraykeys(player.secondaryloadoutweapon.attachments));
    }
    resultstr = result;
    if (isdefined(player.team) && result == player.team) {
        resultstr = #"win";
    } else if (result == #"allies" || result == #"axis") {
        resultstr = #"lose";
    }
    timeplayed = game.timepassed / 1000;
    var_6aca5c39 = spawnstruct();
    var_6aca5c39.match_id = getdemofileid();
    var_6aca5c39.game_variant = "zm";
    var_6aca5c39.game_mode = level.gametype;
    var_6aca5c39.private_match = sessionmodeisprivate();
    var_6aca5c39.game_map = util::get_map_name();
    var_6aca5c39.player_xuid = player getxuid(1);
    var_6aca5c39.player_ip = player getipaddress();
    var_6aca5c39.season_pass_owned = player hasseasonpass(0);
    var_6aca5c39.dlc_owned = player getdlcavailable();
    var_efb2fb58 = spawnstruct();
    var_efb2fb58.match_kills = player.kills;
    var_efb2fb58.match_deaths = player.deaths;
    var_efb2fb58.match_score = player.score;
    var_efb2fb58.match_streak = player.pers[#"best_kill_streak"];
    var_efb2fb58.match_captures = player.pers[#"captures"];
    var_efb2fb58.match_defends = player.pers[#"defends"];
    var_efb2fb58.match_headshots = player.pers[#"headshots"];
    var_efb2fb58.match_longshots = player.pers[#"longshots"];
    var_efb2fb58.match_result = resultstr;
    var_efb2fb58.match_duration = int(timeplayed);
    var_efb2fb58.match_hits = player.var_779c0265;
    var_efb2fb58.prestige_max = player.pers[#"plevel"];
    var_efb2fb58.level_max = player.pers[#"rank"];
    var_8c7365c3 = spawnstruct();
    var_8c7365c3.player_gender = player getplayergendertype(currentsessionmode());
    var_8c7365c3.loadout_primary_weapon = primaryweaponname;
    var_8c7365c3.loadout_secondary_weapon = secondaryweaponname;
    var_8c7365c3.loadout_primary_attachments = primaryweaponattachstr;
    var_8c7365c3.loadout_secondary_attachments = secondaryweaponattachstr;
    end_match_zm = spawnstruct();
    end_match_zm.money = player.score;
    end_match_zm.zombie_waves = level.round_number;
    end_match_zm.revives = player.pers[#"revives"];
    end_match_zm.doors = player.pers[#"doors_purchased"];
    end_match_zm.downs = player.pers[#"downs"];
    function_b1f6086c(#"hash_4c5946fa1191bc64", #"hash_71960e91f80c3365", var_6aca5c39, #"hash_4682ee0eb5071d2", var_efb2fb58, #"hash_209c80d657442a83", var_8c7365c3, #"end_match_zm", end_match_zm);
}

// Namespace globallogic_player/globallogic_player
// Params 0, eflags: 0x0
// Checksum 0x167f5685, Offset: 0x1e90
// Size: 0x4f4
function callback_playerdisconnect() {
    profilelog_begintiming(5, "ship");
    if (game.state != "postgame" && !level.gameended) {
        gamelength = globallogic::getgamelength();
        self globallogic::bbplayermatchend(gamelength, "MP_PLAYER_DISCONNECT", 0);
    }
    arrayremovevalue(level.players, self);
    if (level.splitscreen) {
        players = level.players;
        if (players.size <= 1) {
            level thread globallogic::forceend();
        }
        setdvar(#"splitscreen_playernum", players.size);
    }
    if (isdefined(self.score) && isdefined(self.pers[#"team"])) {
        /#
            print("<dev string:x9a>" + self.pers[#"team"] + "<dev string:xa7>" + self.score);
        #/
        level.dropteam += 1;
    }
    [[ level.onplayerdisconnect ]]();
    lpselfnum = self getentitynumber();
    function_12cd49c1(self, #"disconnected");
    for (entry = 0; entry < level.players.size; entry++) {
        if (level.players[entry] == self) {
            while (entry < level.players.size - 1) {
                level.players[entry] = level.players[entry + 1];
                entry++;
            }
            level.players[entry] = undefined;
            break;
        }
    }
    for (entry = 0; entry < level.players.size; entry++) {
        if (isdefined(level.players[entry].pers[#"killed_players"][self.name])) {
            level.players[entry].pers[#"killed_players"][self.name] = undefined;
        }
        if (isdefined(level.players[entry].killedplayerscurrent[self.name])) {
            level.players[entry].killedplayerscurrent[self.name] = undefined;
        }
        if (isdefined(level.players[entry].pers[#"killed_by"][self.name])) {
            level.players[entry].pers[#"killed_by"][self.name] = undefined;
        }
        if (isdefined(level.players[entry].pers[#"nemesis_tracking"][self.name])) {
            level.players[entry].pers[#"nemesis_tracking"][self.name] = undefined;
        }
        if (level.players[entry].pers[#"nemesis_name"] == self.name) {
            level.players[entry] choosenextbestnemesis();
        }
    }
    if (level.gameended) {
        self globallogic::removedisconnectedplayerfromplacement();
    }
    globallogic::updateteamstatus();
    profilelog_endtiming(5, "gs=" + game.state + " zom=" + sessionmodeiszombiesgame());
}

// Namespace globallogic_player/globallogic_player
// Params 8, eflags: 0x0
// Checksum 0x42b8a254, Offset: 0x2390
// Size: 0xc4
function callback_playermelee(eattacker, idamage, weapon, vorigin, vdir, boneindex, shieldhit, frombehind) {
    hit = 1;
    if (level.teambased && self.team == eattacker.team) {
        if (level.friendlyfire == 0) {
            hit = 0;
        }
    }
    self finishmeleehit(eattacker, weapon, vorigin, vdir, boneindex, shieldhit, hit, frombehind);
}

// Namespace globallogic_player/globallogic_player
// Params 0, eflags: 0x0
// Checksum 0xa5fc448d, Offset: 0x2460
// Size: 0x256
function choosenextbestnemesis() {
    nemesisarray = self.pers[#"nemesis_tracking"];
    nemesisarraykeys = getarraykeys(nemesisarray);
    nemesisamount = 0;
    nemesisname = "";
    if (nemesisarraykeys.size > 0) {
        for (i = 0; i < nemesisarraykeys.size; i++) {
            nemesisarraykey = nemesisarraykeys[i];
            if (nemesisarray[nemesisarraykey] > nemesisamount) {
                nemesisname = nemesisarraykey;
                nemesisamount = nemesisarray[nemesisarraykey];
            }
        }
    }
    self.pers[#"nemesis_name"] = nemesisname;
    if (nemesisname != "") {
        for (playerindex = 0; playerindex < level.players.size; playerindex++) {
            if (level.players[playerindex].name == nemesisname) {
                nemesisplayer = level.players[playerindex];
                self.pers[#"nemesis_rank"] = nemesisplayer.pers[#"rank"];
                self.pers[#"nemesis_rankicon"] = nemesisplayer.pers[#"rankxp"];
                self.pers[#"nemesis_xp"] = nemesisplayer.pers[#"prestige"];
                self.pers[#"nemesis_xuid"] = nemesisplayer getxuid();
                break;
            }
        }
        return;
    }
    self.pers[#"nemesis_xuid"] = "";
}

// Namespace globallogic_player/globallogic_player
// Params 0, eflags: 0x0
// Checksum 0xd3b30c1, Offset: 0x26c0
// Size: 0x5c
function notifyconnecting() {
    waittillframeend();
    if (isdefined(self)) {
        level notify(#"connecting", {#player:self});
        self callback::callback(#"on_player_connecting");
    }
}

// Namespace globallogic_player/globallogic_player
// Params 0, eflags: 0x0
// Checksum 0x5288770, Offset: 0x2728
// Size: 0xa0
function recordactiveplayersendgamematchrecordstats() {
    foreach (player in level.players) {
        recordplayermatchend(player);
        recordplayerstats(player, "present_at_end", 1);
    }
}

// Namespace globallogic_player/globallogic_player
// Params 1, eflags: 0x0
// Checksum 0xcfa74ddb, Offset: 0x27d0
// Size: 0x16
function figureoutfriendlyfire(victim) {
    return level.friendlyfire;
}

// Namespace globallogic_player/globallogic_player
// Params 0, eflags: 0x0
// Checksum 0xee1df091, Offset: 0x27f0
// Size: 0x2e
function function_dd466180() {
    globallogic::updateteamstatus(1);
    self notify(#"death");
}

