#using script_4194df57536e11ed;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\hud_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\gametypes\globallogic;
#using scripts\zm_common\gametypes\globallogic_defaults;
#using scripts\zm_common\gametypes\globallogic_score;
#using scripts\zm_common\gametypes\globallogic_spawn;
#using scripts\zm_common\gametypes\globallogic_ui;
#using scripts\zm_common\gametypes\globallogic_utils;
#using scripts\zm_common\gametypes\hud_message;
#using scripts\zm_common\gametypes\spawning;
#using scripts\zm_common\util;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_blockers;
#using scripts\zm_common\zm_game_module;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;

#namespace zm_gametype;

// Namespace zm_gametype/zm_gametype
// Params 0, eflags: 0x6
// Checksum 0x3d317d52, Offset: 0x580
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_gametype", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_gametype/zm_gametype
// Params 0, eflags: 0x5 linked
// Checksum 0xfeea0490, Offset: 0x5c8
// Size: 0x24
function private function_70a657d8() {
    callback::on_connecting(&menu_onplayerconnect);
}

// Namespace zm_gametype/zm_gametype
// Params 0, eflags: 0x1 linked
// Checksum 0x6d39ed73, Offset: 0x5f8
// Size: 0x5b4
function main() {
    globallogic::init();
    globallogic_setupdefault_zombiecallbacks();
    menu_init();
    util::registerroundlimit(1, 1);
    util::registertimelimit(0, 0);
    util::registerscorelimit(0, 0);
    util::registerroundwinlimit(0, 0);
    util::registernumlives(1, 1);
    globallogic::registerfriendlyfiredelay(level.gametype, 15, 0, 1440);
    level.takelivesondeath = 1;
    level.teambased = 1;
    level.disablemomentum = 1;
    level.overrideteamscore = 0;
    level.overrideplayerscore = 0;
    level.displayhalftimetext = 0;
    level.displayroundendtext = 0;
    level.allowannouncer = 0;
    level.endgameonscorelimit = 0;
    level.endgameontimelimit = 0;
    level.resetplayerscoreeveryround = 1;
    level.doprematch = 0;
    level.cumulativeroundscores = 1;
    level.forceautoassign = 1;
    level.dontshowendreason = 1;
    level.forceallallies = 1;
    level.allow_teamchange = 0;
    setdvar(#"scr_disable_team_selection", 1);
    setdvar(#"scr_disable_weapondrop", 1);
    level.onstartgametype = &onstartgametype;
    level.onspawnplayer = &globallogic::blank;
    level.onspawnplayerunified = &onspawnplayerunified;
    level.onroundendgame = &onroundendgame;
    level.playermayspawn = &mayspawn;
    game.zm_roundlimit = 1;
    game.zm_scorelimit = 1;
    game._team1_num = 0;
    game._team2_num = 0;
    map_name = level.script;
    mode = util::get_game_type();
    if ((!isdefined(mode) || mode == "") && isdefined(level.default_game_mode)) {
        mode = level.default_game_mode;
    }
    zm_utility::set_gamemode_var_once("mode", mode);
    if (!isdefined(game.side_selection)) {
        game.side_selection = 1;
    }
    location = level.default_start_location;
    zm_utility::set_gamemode_var_once("location", location);
    zm_utility::set_gamemode_var_once("randomize_mode", getdvarint(#"zm_rand_mode", 0));
    zm_utility::set_gamemode_var_once("randomize_location", getdvarint(#"zm_rand_loc", 0));
    zm_utility::set_gamemode_var_once("team_1_score", 0);
    zm_utility::set_gamemode_var_once("team_2_score", 0);
    zm_utility::set_gamemode_var_once("current_round", 0);
    zm_utility::set_gamemode_var_once("rules_read", 0);
    if (!isdefined(game.switchedsides)) {
        game.switchedsides = 0;
    }
    gametype = util::get_game_type();
    game.dialog[#"gametype"] = gametype + "_start";
    game.dialog[#"gametype_hardcore"] = gametype + "_start";
    game.dialog[#"offense_obj"] = "generic_boost";
    game.dialog[#"defense_obj"] = "generic_boost";
    zm_utility::set_gamemode_var("pre_init_zombie_spawn_func", undefined);
    zm_utility::set_gamemode_var("post_init_zombie_spawn_func", undefined);
    zm_utility::set_gamemode_var("match_end_notify", undefined);
    zm_utility::set_gamemode_var("match_end_func", undefined);
    callback::on_connect(&onplayerconnect_check_for_hotjoin);
}

// Namespace zm_gametype/zm_gametype
// Params 0, eflags: 0x1 linked
// Checksum 0x9359b9ef, Offset: 0xbb8
// Size: 0x4a4
function globallogic_setupdefault_zombiecallbacks() {
    level.spawnplayer = &globallogic_spawn::spawnplayer;
    level.spawnplayerprediction = &globallogic_spawn::spawnplayerprediction;
    level.spawnclient = &globallogic_spawn::spawnclient;
    level.spawnspectator = &globallogic_spawn::spawnspectator;
    level.spawnintermission = &globallogic_spawn::spawnintermission;
    level.scoreongiveplayerscore = &globallogic_score::giveplayerscore;
    level.onplayerscore = &globallogic_score::default_onplayerscore;
    level.onteamscore = &globallogic::blank;
    level.wavespawntimer = &globallogic::wavespawntimer;
    level.onspawnplayer = &globallogic::blank;
    level.onspawnplayerunified = &globallogic::blank;
    level.onspawnspectator = &onspawnspectator;
    level.onspawnintermission = &onspawnintermission;
    level.onrespawndelay = &globallogic::blank;
    level.onforfeit = &globallogic::blank;
    level.ontimelimit = &globallogic::blank;
    level.onscorelimit = &globallogic::blank;
    level.ondeadevent = &ondeadevent;
    level.ononeleftevent = &globallogic::blank;
    level.giveteamscore = &globallogic::blank;
    level.gettimepassed = &globallogic_utils::gettimepassed;
    level.gettimelimit = &globallogic_defaults::default_gettimelimit;
    level.getteamkillpenalty = &globallogic::blank;
    level.getteamkillscore = &globallogic::blank;
    level.iskillboosting = &globallogic::blank;
    level._setteamscore = &globallogic_score::_setteamscore;
    level._setplayerscore = &globallogic::blank;
    level._getteamscore = &globallogic::blank;
    level._getplayerscore = &globallogic::blank;
    level.onprecachegametype = &globallogic::blank;
    level.onstartgametype = &globallogic::blank;
    level.onplayerconnect = &globallogic::blank;
    level.onplayerdisconnect = &onplayerdisconnect;
    level.onplayerdamage = &globallogic::blank;
    level.onplayerkilled = &globallogic::blank;
    level.onplayerkilledextraunthreadedcbs = [];
    level.onteamoutcomenotify = &globallogic::blank;
    level.onoutcomenotify = &globallogic::blank;
    level.onendgame = &onendgame;
    level.onroundendgame = &globallogic::blank;
    level.onmedalawarded = &globallogic::blank;
    level.dogmanagerongetdogs = &globallogic::blank;
    level.autoassign = &globallogic_ui::menuautoassign;
    level.spectator = &globallogic_ui::menuspectator;
    level.allies = &menuallieszombies;
    level.teammenu = &globallogic_ui::menuteam;
    level.autocontrolplayer = &globallogic_ui::menuautocontrolplayer;
    level.callbackactorkilled = &globallogic::blank;
    level.callbackvehicledamage = &globallogic::blank;
    level.callbackvehiclekilled = &globallogic::blank;
}

// Namespace zm_gametype/zm_gametype
// Params 0, eflags: 0x0
// Checksum 0x7d3158d7, Offset: 0x1068
// Size: 0x5e
function do_game_mode_shellshock() {
    self endon(#"disconnect");
    self._being_shellshocked = 1;
    self shellshock(#"grief_stab_zm", 0.75);
    wait 0.75;
    self._being_shellshocked = 0;
}

// Namespace zm_gametype/zm_gametype
// Params 0, eflags: 0x1 linked
// Checksum 0xdaa78384, Offset: 0x10d0
// Size: 0x6
function canplayersuicide() {
    return false;
}

// Namespace zm_gametype/zm_gametype
// Params 0, eflags: 0x1 linked
// Checksum 0xc2c704da, Offset: 0x10e0
// Size: 0x5c
function onplayerdisconnect() {
    if (isdefined(level.var_7b27c856)) {
        level [[ level.var_7b27c856 ]](self);
    }
    self zm_laststand::add_weighted_down();
    level zm_player::function_8ef51109(self);
}

// Namespace zm_gametype/zm_gametype
// Params 1, eflags: 0x1 linked
// Checksum 0x43f6b3e9, Offset: 0x1148
// Size: 0x2c
function ondeadevent(*team) {
    thread globallogic::endgame(level.zombie_team, "");
}

// Namespace zm_gametype/zm_gametype
// Params 0, eflags: 0x1 linked
// Checksum 0x5f4546a2, Offset: 0x1180
// Size: 0xd4
function onspawnintermission() {
    spawnpointname = "info_intermission";
    spawnpoints = getentarray(spawnpointname, "classname");
    if (spawnpoints.size < 1) {
        println("<dev string:x38>" + spawnpointname + "<dev string:x3f>");
        return;
    }
    spawnpoint = spawnpoints[randomint(spawnpoints.size)];
    if (isdefined(spawnpoint)) {
        self spawn(spawnpoint.origin, spawnpoint.angles);
    }
}

// Namespace zm_gametype/zm_gametype
// Params 2, eflags: 0x1 linked
// Checksum 0x8468dd8f, Offset: 0x1260
// Size: 0x14
function onspawnspectator(*origin, *angles) {
    
}

// Namespace zm_gametype/zm_gametype
// Params 0, eflags: 0x1 linked
// Checksum 0x7007c87d, Offset: 0x1280
// Size: 0x76
function mayspawn() {
    if (isdefined(level.custommayspawnlogic)) {
        return self [[ level.custommayspawnlogic ]]();
    }
    if (self.pers[#"lives"] == 0) {
        level notify(#"player_eliminated");
        self notify(#"player_eliminated");
        return 0;
    }
    return 1;
}

// Namespace zm_gametype/zm_gametype
// Params 0, eflags: 0x1 linked
// Checksum 0x680d72e4, Offset: 0x1300
// Size: 0x17c
function onstartgametype() {
    setclientnamemode("auto_change");
    level.spawnmins = (0, 0, 0);
    level.spawnmaxs = (0, 0, 0);
    structs = struct::get_array("player_respawn_point", "targetname");
    foreach (struct in structs) {
        level.spawnmins = math::expand_mins(level.spawnmins, struct.origin);
        level.spawnmaxs = math::expand_maxs(level.spawnmaxs, struct.origin);
    }
    level.mapcenter = math::find_box_center(level.spawnmins, level.spawnmaxs);
    setmapcenter(level.mapcenter);
    spawning::create_map_placed_influencers();
}

// Namespace zm_gametype/zm_gametype
// Params 0, eflags: 0x1 linked
// Checksum 0xb92dd8e9, Offset: 0x1488
// Size: 0x1c
function onspawnplayerunified() {
    onspawnplayer(0);
}

// Namespace zm_gametype/zm_gametype
// Params 0, eflags: 0x1 linked
// Checksum 0x45029c0b, Offset: 0x14b0
// Size: 0x2f2
function onfindvalidspawnpoint() {
    println("<dev string:x56>");
    if (level flag::get("begin_spawning")) {
        spawnpoint = zm_player::check_for_valid_spawn_near_team(self, 1);
        /#
            if (!isdefined(spawnpoint)) {
                println("<dev string:x75>");
            }
        #/
    }
    if (!isdefined(spawnpoint)) {
        match_string = "";
        location = level.scr_zm_map_start_location;
        if ((location == "default" || location == "") && isdefined(level.default_start_location)) {
            location = level.default_start_location;
        }
        match_string = level.scr_zm_ui_gametype + "_" + location;
        spawnpoints = [];
        structs = struct::get_array("initial_spawn", "script_noteworthy");
        if (isdefined(structs)) {
            foreach (struct in structs) {
                if (isdefined(struct.script_string)) {
                    tokens = strtok(struct.script_string, " ");
                    foreach (token in tokens) {
                        if (token == match_string) {
                            spawnpoints[spawnpoints.size] = struct;
                        }
                    }
                }
            }
        }
        if (!isdefined(spawnpoints) || spawnpoints.size == 0) {
            spawnpoints = struct::get_array("initial_spawn_points", "targetname");
        }
        assert(isdefined(spawnpoints), "<dev string:xca>");
        spawnpoint = zm_player::getfreespawnpoint(spawnpoints, self);
    }
    return spawnpoint;
}

// Namespace zm_gametype/zm_gametype
// Params 1, eflags: 0x1 linked
// Checksum 0x502aba35, Offset: 0x17b0
// Size: 0x3bc
function onspawnplayer(predictedspawn = 0) {
    self.usingobj = undefined;
    self.is_zombie = 0;
    zm_player::updateplayernum(self);
    if (isdefined(level.custom_spawnplayer) && is_true(self.player_initialized)) {
        self [[ level.custom_spawnplayer ]]();
        return;
    }
    if (isdefined(level.customspawnlogic)) {
        println("<dev string:xf2>");
        spawnpoint = self [[ level.customspawnlogic ]](predictedspawn);
        if (predictedspawn) {
            return;
        }
    } else {
        println("<dev string:x56>");
        spawnpoint = self onfindvalidspawnpoint();
        if (predictedspawn) {
            self predictspawnpoint(spawnpoint.origin, spawnpoint.angles);
            return;
        } else {
            self spawn(spawnpoint.origin, spawnpoint.angles, "zsurvival");
        }
    }
    self.entity_num = self getentitynumber();
    self thread zm_player::onplayerspawned();
    self thread zm_player::player_revive_monitor();
    self val::set(#"onspawnplayer", "freezecontrols");
    self val::set(#"onspawnplayer", "disablegadgets");
    self.spectator_respawn = spawnpoint;
    self.score = self globallogic_score::getpersstat(#"score");
    self.pers[#"participation"] = 0;
    /#
        if (getdvarint(#"zombie_cheat", 0) >= 1) {
            self.score = 100000;
        }
    #/
    self.score_total = self.score;
    self.old_score = self.score;
    self.player_initialized = 0;
    self.zombification_time = 0;
    self thread zm_blockers::rebuild_barrier_reward_reset();
    if (!is_true(level.host_ended_game)) {
        self val::reset(#"onspawnplayer", "freezecontrols");
        self val::reset(#"onspawnplayer", "disablegadgets");
        self enableweapons();
    }
    if (isdefined(level.var_ce6bb796)) {
        spawn_in_spectate = [[ level.var_ce6bb796 ]]();
        if (spawn_in_spectate) {
            self util::delay(0.05, undefined, &zm_player::spawnspectator);
        }
    }
}

// Namespace zm_gametype/zm_gametype
// Params 0, eflags: 0x1 linked
// Checksum 0x17c90e33, Offset: 0x1b78
// Size: 0x202
function get_player_spawns_for_gametype() {
    a_s_player_spawns = [];
    a_structs = struct::get_array("player_respawn_point", "targetname");
    foreach (struct in a_structs) {
        if (isdefined(struct.script_string)) {
            var_61fc7c84 = strtok(struct.script_string, " ");
            foreach (var_5d975b01 in var_61fc7c84) {
                if (var_5d975b01 == level.scr_zm_ui_gametype) {
                    if (!isdefined(a_s_player_spawns)) {
                        a_s_player_spawns = [];
                    } else if (!isarray(a_s_player_spawns)) {
                        a_s_player_spawns = array(a_s_player_spawns);
                    }
                    a_s_player_spawns[a_s_player_spawns.size] = struct;
                }
            }
            continue;
        }
        if (!isdefined(a_s_player_spawns)) {
            a_s_player_spawns = [];
        } else if (!isarray(a_s_player_spawns)) {
            a_s_player_spawns = array(a_s_player_spawns);
        }
        a_s_player_spawns[a_s_player_spawns.size] = struct;
    }
    return a_s_player_spawns;
}

// Namespace zm_gametype/zm_gametype
// Params 1, eflags: 0x1 linked
// Checksum 0x9d4c94d7, Offset: 0x1d88
// Size: 0xc
function onendgame(*winningteam) {
    
}

// Namespace zm_gametype/zm_gametype
// Params 1, eflags: 0x1 linked
// Checksum 0x285f2548, Offset: 0x1da0
// Size: 0x102
function onroundendgame(*roundwinner) {
    if (game.stat[#"roundswon"][#"allies"] == game.stat[#"roundswon"][#"axis"]) {
        winner = "tie";
    } else if (game.stat[#"roundswon"][#"axis"] > game.stat[#"roundswon"][#"allies"]) {
        winner = #"axis";
    } else {
        winner = #"allies";
    }
    return winner;
}

// Namespace zm_gametype/zm_gametype
// Params 0, eflags: 0x1 linked
// Checksum 0x66d8fb1c, Offset: 0x1eb0
// Size: 0x1ec
function menu_init() {
    game.menu = [];
    game.menu[#"menu_team"] = "ChangeTeam";
    game.menu[#"menu_changeclass_allies"] = "ChooseClass_InGame";
    game.menu[#"menu_initteam_allies"] = "initteam_marines";
    game.menu[#"menu_changeclass_axis"] = "ChooseClass_InGame";
    game.menu[#"menu_initteam_axis"] = "initteam_opfor";
    game.menu[#"menu_class"] = "class";
    game.menu[#"menu_start_menu"] = "StartMenu_Main";
    game.menu[#"menu_changeclass"] = "PositionDraft";
    game.menu[#"menu_changeclass_offline"] = "PositionDraft";
    game.menu[#"menu_changeclass_custom"] = "PositionDraft";
    game.menu[#"menu_draft"] = "PositionDraft";
    game.menu[#"menu_controls"] = "ingame_controls";
    game.menu[#"menu_options"] = "ingame_options";
    game.menu[#"menu_leavegame"] = "popup_leavegame";
    game.menu[#"menu_restartgamepopup"] = "T7Hud_zm_factory";
}

// Namespace zm_gametype/zm_gametype
// Params 0, eflags: 0x1 linked
// Checksum 0xa86a7a34, Offset: 0x20a8
// Size: 0x1c
function menu_onplayerconnect() {
    self thread menu_onmenuresponse();
}

// Namespace zm_gametype/zm_gametype
// Params 0, eflags: 0x1 linked
// Checksum 0xbe63679f, Offset: 0x20d0
// Size: 0x4c
function zm_map_restart() {
    self endon(#"disconnect");
    while (!function_65f7de49()) {
        waitframe(1);
    }
    map_restart(1);
}

// Namespace zm_gametype/zm_gametype
// Params 0, eflags: 0x1 linked
// Checksum 0x546609e7, Offset: 0x2128
// Size: 0x89c
function menu_onmenuresponse() {
    self endon(#"disconnect");
    for (;;) {
        waitresult = self waittill(#"menuresponse");
        menu = waitresult.menu;
        response = waitresult.response;
        intval = waitresult.intpayload;
        if (response == "back") {
            self closeingamemenu();
            if (level.console) {
                if (menu == game.menu[#"menu_changeclass"] || menu == game.menu_changeclass_offline || menu == game.menu[#"menu_team"] || menu == game.menu[#"menu_controls"]) {
                    if (self.pers[#"team"] == #"allies") {
                        self openmenu(game.menu[#"menu_start_menu"]);
                    }
                    if (self.pers[#"team"] == #"axis") {
                        self openmenu(game.menu[#"menu_start_menu"]);
                    }
                }
            }
            continue;
        }
        if (response == "changeteam" && level.allow_teamchange) {
            self closeingamemenu();
            self openmenu(game.menu[#"menu_team"]);
        }
        if (response == "changeclass_marines") {
            self closeingamemenu();
            self openmenu(game.menu[#"menu_changeclass_allies"]);
            continue;
        }
        if (response == "changeclass_opfor") {
            self closeingamemenu();
            self openmenu(game.menu[#"menu_changeclass_axis"]);
            continue;
        }
        if (response == "changeclass_custom") {
            self closeingamemenu();
            self openmenu(game.menu[#"menu_changeclass_custom"]);
            continue;
        }
        if (response == "changeclass_marines_splitscreen") {
            self openmenu("changeclass_marines_splitscreen");
        }
        if (response == "changeclass_opfor_splitscreen") {
            self openmenu("changeclass_opfor_splitscreen");
        }
        if (response == "endgame") {
            if (self issplitscreen()) {
                level.skipvote = 1;
                if (!is_true(level.gameended)) {
                    self zm_laststand::add_weighted_down();
                    self zm_stats::increment_client_stat("deaths");
                    self zm_stats::increment_player_stat("deaths");
                    level.host_ended_game = 1;
                    foreach (player in getplayers()) {
                        player val::set(#"game_end", "freezecontrols");
                        player val::set(#"game_end", "disablegadgets");
                    }
                    level notify(#"end_game");
                }
            }
            continue;
        }
        if (response == "killserverpc") {
            level thread globallogic::killserverpc();
            continue;
        }
        if (response == "endround") {
            if (!is_true(level.gameended)) {
                self globallogic::gamehistoryplayerquit();
                self zm_laststand::add_weighted_down();
                self closeingamemenu();
                level.host_ended_game = 1;
                foreach (player in getplayers()) {
                    player val::set(#"game_end", "freezecontrols");
                    player val::set(#"game_end", "disablegadgets");
                }
                level notify(#"end_game");
            } else {
                self closeingamemenu();
                self iprintln(#"mp/host_endgame_response");
            }
            continue;
        }
        if (response == "autocontrol") {
            self [[ level.autocontrolplayer ]]();
            continue;
        }
        if (menu == game.menu[#"menu_team"] && level.allow_teamchange) {
            switch (response) {
            case #"allies":
                self [[ level.allies ]]();
                break;
            case #"axis":
                self [[ level.teammenu ]](response);
                break;
            case #"autoassign":
                self [[ level.autoassign ]](1);
                break;
            case #"spectator":
                self [[ level.spectator ]]();
                break;
            }
            continue;
        }
        if (menu == game.menu[#"menu_changeclass"] || menu == game.menu[#"menu_changeclass_offline"] || menu == game.menu[#"menu_changeclass_custom"]) {
            self closeingamemenu();
            self.selectedclass = 1;
            self [[ level.curclass ]](response);
        }
    }
}

// Namespace zm_gametype/zm_gametype
// Params 0, eflags: 0x1 linked
// Checksum 0xbdcba0e1, Offset: 0x29d0
// Size: 0x1ee
function menuallieszombies() {
    if (!level.console && !level.allow_teamchange && isdefined(self.hasdonecombat) && self.hasdonecombat) {
        return;
    }
    if (self.pers[#"team"] != #"allies") {
        if (level.ingraceperiod && (!isdefined(self.hasdonecombat) || !self.hasdonecombat)) {
            self.hasspawned = 0;
        }
        if (self.sessionstate == "playing") {
            self.switching_teams = 1;
            self.joining_team = #"allies";
            self.leaving_team = self.pers[#"team"];
            self suicide();
        }
        self.pers[#"team"] = #"allies";
        self.team = #"allies";
        self.pers[#"class"] = undefined;
        self.curclass = undefined;
        self.pers[#"weapon"] = undefined;
        self.pers[#"savedmodel"] = undefined;
        self.sessionteam = #"allies";
        self player::function_466d8a4b(0);
        self notify(#"end_respawn");
    }
}

// Namespace zm_gametype/zm_gametype
// Params 0, eflags: 0x1 linked
// Checksum 0xc47995fa, Offset: 0x2bc8
// Size: 0x34
function custom_spawn_init_func() {
    array::thread_all(level.zombie_spawners, &spawner::add_spawn_function, level._zombies_round_spawn_failsafe);
}

// Namespace zm_gametype/zm_gametype
// Params 0, eflags: 0x0
// Checksum 0x502a8a86, Offset: 0x2c08
// Size: 0x5c
function init() {
    level flag::init("pregame");
    level flag::set("pregame");
    level thread onplayerconnect();
}

// Namespace zm_gametype/zm_gametype
// Params 0, eflags: 0x1 linked
// Checksum 0xb0fb8f89, Offset: 0x2c70
// Size: 0x78
function onplayerconnect() {
    for (;;) {
        waitresult = level waittill(#"connected");
        waitresult.player thread onplayerspawned();
        if (isdefined(level.var_2742b26e)) {
            waitresult.player [[ level.var_2742b26e ]]();
        }
    }
}

// Namespace zm_gametype/zm_gametype
// Params 0, eflags: 0x1 linked
// Checksum 0xcba93064, Offset: 0x2cf0
// Size: 0x234
function onplayerspawned() {
    level endon(#"end_game");
    self endon(#"disconnect");
    for (;;) {
        self waittill(#"spawned_player", #"fake_spawned_player");
        if (is_true(level.match_is_ending)) {
            return;
        }
        if (self laststand::player_is_in_laststand()) {
            self thread zm_laststand::auto_revive(self);
        }
        if (isdefined(level.var_3129849c)) {
            self [[ level.var_3129849c ]]();
        }
        self setstance("stand");
        self.zmbdialogqueue = [];
        self.zmbdialogactive = 0;
        self.zmbdialoggroups = [];
        self.zmbdialoggroup = "";
        self takeallweapons();
        self giveweapon(level.weaponbasemelee);
        if (isdefined(level.onplayerspawned_restore_previous_weapons) && is_true(level.isresetting_grief)) {
            weapons_restored = self [[ level.onplayerspawned_restore_previous_weapons ]]();
        }
        if (!is_true(weapons_restored)) {
            self zm_loadout::give_start_weapon(1);
        }
        weapons_restored = 0;
        if (isdefined(level._team_loadout)) {
            self giveweapon(level._team_loadout);
            self switchtoweapon(level._team_loadout);
        }
        if (isdefined(level.var_3c7ec322)) {
            self [[ level.var_3c7ec322 ]]();
        }
    }
}

// Namespace zm_gametype/zm_gametype
// Params 0, eflags: 0x1 linked
// Checksum 0x5d89ef54, Offset: 0x2f30
// Size: 0xcc
function onplayerconnect_check_for_hotjoin() {
    /#
        if (getdvarint(#"zm_instajoin", 0) > 0) {
            return;
        }
    #/
    gametype = hash(util::get_game_type());
    if (gametype == #"zsurvival") {
        return;
    }
    if (level flag::get("start_zombie_round_logic") && !is_true(level.var_e52901a5)) {
        self thread player_hotjoin();
    }
}

// Namespace zm_gametype/zm_gametype
// Params 0, eflags: 0x1 linked
// Checksum 0x82c0af07, Offset: 0x3008
// Size: 0x29c
function player_hotjoin() {
    self endon(#"disconnect");
    self.rebuild_barrier_reward = 1;
    self.is_hotjoining = 1;
    val::set(#"initial_black", "hide");
    val::set(#"initial_black", "takedamage", 0);
    val::set(#"initial_black", "ignoreme");
    val::set(#"initial_black", "freezecontrols");
    wait 0.5;
    self zm_player::spawnspectator();
    music::setmusicstate("none");
    self.is_hotjoining = 0;
    self.is_hotjoin = 1;
    if (is_true(level.intermission) || is_true(level.host_ended_game)) {
        self setclientthirdperson(0);
        self resetfov();
        self.health = 100;
        self thread [[ level.custom_intermission ]]();
    }
    self util::streamer_wait(undefined, 0, 30);
    if (isdefined(level.var_58d27156)) {
        wait level.var_58d27156;
    }
    initialblackend();
    val::reset(#"initial_black", "hide");
    val::reset(#"initial_black", "takedamage");
    val::reset(#"initial_black", "freezecontrols");
    val::reset(#"initial_black", "ignoreme");
}

// Namespace zm_gametype/zm_gametype
// Params 0, eflags: 0x1 linked
// Checksum 0xc05dccee, Offset: 0x32b0
// Size: 0x3c
function initialblackend() {
    initial_black = lui::get_luimenu("InitialBlack");
    initial_black initial_black::close(self);
}

// Namespace zm_gametype/zm_gametype
// Params 1, eflags: 0x4
// Checksum 0xb6f24b43, Offset: 0x32f8
// Size: 0x20
function private function_788fb510(value) {
    if (!isdefined(value)) {
        return "";
    }
    return value;
}

