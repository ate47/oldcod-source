#using script_3c51754cf708b246;
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
// Params 0, eflags: 0x2
// Checksum 0x72c014ca, Offset: 0x4f0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_gametype", &__init__, undefined, undefined);
}

// Namespace zm_gametype/zm_gametype
// Params 0, eflags: 0x0
// Checksum 0x21024e59, Offset: 0x538
// Size: 0x24
function __init__() {
    callback::on_connecting(&menu_onplayerconnect);
}

// Namespace zm_gametype/zm_gametype
// Params 0, eflags: 0x0
// Checksum 0x86078da3, Offset: 0x568
// Size: 0x66c
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
    level.nopersistence = 1;
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
    bundle = function_5cadb094();
    setvisiblescoreboardcolumns(bundle.scoreboard_1, bundle.scoreboard_2, bundle.scoreboard_3, bundle.scoreboard_4, bundle.scoreboard_5, bundle.var_8e072e84, bundle.var_b409a8ed, bundle.var_72160cfa);
    callback::on_connect(&onplayerconnect_check_for_hotjoin);
}

// Namespace zm_gametype/zm_gametype
// Params 0, eflags: 0x0
// Checksum 0xc7885c42, Offset: 0xbe0
// Size: 0x4c6
function globallogic_setupdefault_zombiecallbacks() {
    level.spawnplayer = &globallogic_spawn::spawnplayer;
    level.spawnplayerprediction = &globallogic_spawn::spawnplayerprediction;
    level.spawnclient = &globallogic_spawn::spawnclient;
    level.spawnspectator = &globallogic_spawn::spawnspectator;
    level.spawnintermission = &globallogic_spawn::spawnintermission;
    level.scoreongiveplayerscore = &globallogic_score::giveplayerscore;
    level.onplayerscore = &globallogic::blank;
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
    level.curclass = &globallogic_ui::menuclass;
    level.allies = &menuallieszombies;
    level.teammenu = &globallogic_ui::menuteam;
    level.autocontrolplayer = &globallogic_ui::menuautocontrolplayer;
    level.callbackactorkilled = &globallogic::blank;
    level.callbackvehicledamage = &globallogic::blank;
    level.callbackvehiclekilled = &globallogic::blank;
}

// Namespace zm_gametype/zm_gametype
// Params 0, eflags: 0x0
// Checksum 0x606e80c3, Offset: 0x10b0
// Size: 0x5e
function do_game_mode_shellshock() {
    self endon(#"disconnect");
    self._being_shellshocked = 1;
    self shellshock(#"grief_stab_zm", 0.75);
    wait 0.75;
    self._being_shellshocked = 0;
}

// Namespace zm_gametype/zm_gametype
// Params 0, eflags: 0x0
// Checksum 0x2c191816, Offset: 0x1118
// Size: 0x6
function canplayersuicide() {
    return false;
}

// Namespace zm_gametype/zm_gametype
// Params 0, eflags: 0x0
// Checksum 0x3a12fee0, Offset: 0x1128
// Size: 0x5c
function onplayerdisconnect() {
    if (isdefined(level.var_7e94ca68)) {
        level [[ level.var_7e94ca68 ]](self);
    }
    self zm_laststand::add_weighted_down();
    level zm_player::function_cb9259f5(self);
}

// Namespace zm_gametype/zm_gametype
// Params 1, eflags: 0x0
// Checksum 0xbc651c2d, Offset: 0x1190
// Size: 0x2c
function ondeadevent(team) {
    thread globallogic::endgame(level.zombie_team, "");
}

// Namespace zm_gametype/zm_gametype
// Params 0, eflags: 0x0
// Checksum 0x260313b8, Offset: 0x11c8
// Size: 0xd4
function onspawnintermission() {
    spawnpointname = "info_intermission";
    spawnpoints = getentarray(spawnpointname, "classname");
    if (spawnpoints.size < 1) {
        println("<dev string:x30>" + spawnpointname + "<dev string:x34>");
        return;
    }
    spawnpoint = spawnpoints[randomint(spawnpoints.size)];
    if (isdefined(spawnpoint)) {
        self spawn(spawnpoint.origin, spawnpoint.angles);
    }
}

// Namespace zm_gametype/zm_gametype
// Params 2, eflags: 0x0
// Checksum 0x84e9fad1, Offset: 0x12a8
// Size: 0x14
function onspawnspectator(origin, angles) {
    
}

// Namespace zm_gametype/zm_gametype
// Params 0, eflags: 0x0
// Checksum 0x8fba8606, Offset: 0x12c8
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
// Params 0, eflags: 0x0
// Checksum 0xcd40b89d, Offset: 0x1348
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
// Params 0, eflags: 0x0
// Checksum 0x8646621f, Offset: 0x14d0
// Size: 0x1c
function onspawnplayerunified() {
    onspawnplayer(0);
}

// Namespace zm_gametype/zm_gametype
// Params 0, eflags: 0x0
// Checksum 0xadbf3fa9, Offset: 0x14f8
// Size: 0x2ea
function onfindvalidspawnpoint() {
    println("<dev string:x48>");
    if (level flag::get("begin_spawning")) {
        spawnpoint = zm_player::check_for_valid_spawn_near_team(self, 1);
        /#
            if (!isdefined(spawnpoint)) {
                println("<dev string:x64>");
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
        assert(isdefined(spawnpoints), "<dev string:xb6>");
        spawnpoint = zm_player::getfreespawnpoint(spawnpoints, self);
    }
    return spawnpoint;
}

// Namespace zm_gametype/zm_gametype
// Params 1, eflags: 0x0
// Checksum 0x5ca98899, Offset: 0x17f0
// Size: 0x3f4
function onspawnplayer(predictedspawn = 0) {
    pixbeginevent(#"hash_45a46111e3862b44");
    self.usingobj = undefined;
    self.is_zombie = 0;
    zm_player::updateplayernum(self);
    if (isdefined(level.custom_spawnplayer) && isdefined(self.player_initialized) && self.player_initialized) {
        self [[ level.custom_spawnplayer ]]();
        return;
    }
    if (isdefined(level.customspawnlogic)) {
        println("<dev string:xdb>");
        spawnpoint = self [[ level.customspawnlogic ]](predictedspawn);
        if (predictedspawn) {
            return;
        }
    } else {
        println("<dev string:x48>");
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
    self.score = self globallogic_score::getpersstat("score");
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
    if (!(isdefined(level.host_ended_game) && level.host_ended_game)) {
        self val::reset(#"onspawnplayer", "freezecontrols");
        self val::reset(#"onspawnplayer", "disablegadgets");
        self enableweapons();
    }
    if (isdefined(level.var_4eb2f852)) {
        spawn_in_spectate = [[ level.var_4eb2f852 ]]();
        if (spawn_in_spectate) {
            self util::delay(0.05, undefined, &zm_player::spawnspectator);
        }
    }
    pixendevent();
}

// Namespace zm_gametype/zm_gametype
// Params 0, eflags: 0x0
// Checksum 0x36fedf98, Offset: 0x1bf0
// Size: 0x1f8
function get_player_spawns_for_gametype() {
    a_s_player_spawns = [];
    a_structs = struct::get_array("player_respawn_point", "targetname");
    foreach (struct in a_structs) {
        if (isdefined(struct.script_string)) {
            var_4f9375aa = strtok(struct.script_string, " ");
            foreach (var_8e21e24b in var_4f9375aa) {
                if (var_8e21e24b == level.scr_zm_ui_gametype) {
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
// Params 1, eflags: 0x0
// Checksum 0x624515cc, Offset: 0x1df0
// Size: 0xc
function onendgame(winningteam) {
    
}

// Namespace zm_gametype/zm_gametype
// Params 1, eflags: 0x0
// Checksum 0x1b6c6eb1, Offset: 0x1e08
// Size: 0x102
function onroundendgame(roundwinner) {
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
// Params 0, eflags: 0x0
// Checksum 0x248baa8d, Offset: 0x1f18
// Size: 0x26a
function menu_init() {
    game.menu = [];
    game.menu[#"menu_team"] = "ChangeTeam";
    game.menu[#"menu_changeclass_allies"] = "ChooseClass_InGame";
    game.menu[#"menu_initteam_allies"] = "initteam_marines";
    game.menu[#"menu_changeclass_axis"] = "ChooseClass_InGame";
    game.menu[#"menu_initteam_axis"] = "initteam_opfor";
    game.menu[#"menu_class"] = "class";
    game.menu[#"menu_start_menu"] = "StartMenu_Main";
    game.menu[#"menu_changeclass"] = "ChooseClass_InGame";
    game.menu[#"menu_changeclass_offline"] = "ChooseClass_InGame";
    game.menu[#"menu_changeclass_custom"] = "changeclass_custom";
    game.menu[#"menu_draft"] = "PositionDraft";
    game.menu[#"menu_controls"] = "ingame_controls";
    game.menu[#"menu_options"] = "ingame_options";
    game.menu[#"menu_leavegame"] = "popup_leavegame";
    game.menu[#"menu_restartgamepopup"] = "restartgamepopup";
}

// Namespace zm_gametype/zm_gametype
// Params 0, eflags: 0x0
// Checksum 0x9015c52c, Offset: 0x2190
// Size: 0x1c
function menu_onplayerconnect() {
    self thread menu_onmenuresponse();
}

// Namespace zm_gametype/zm_gametype
// Params 0, eflags: 0x0
// Checksum 0x8d57ab5f, Offset: 0x21b8
// Size: 0x4c
function zm_map_restart() {
    self endon(#"disconnect");
    while (!function_bf0a2058()) {
        waitframe(1);
    }
    map_restart(1);
}

// Namespace zm_gametype/zm_gametype
// Params 0, eflags: 0x0
// Checksum 0xa67e2b37, Offset: 0x2210
// Size: 0x8e8
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
                if (!(isdefined(level.gameended) && level.gameended)) {
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
        if (response == "restart_level_zm") {
            self thread zm_map_restart();
        }
        if (response == "killserverpc") {
            level thread globallogic::killserverpc();
            continue;
        }
        if (response == "endround") {
            if (!(isdefined(level.gameended) && level.gameended)) {
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
                self iprintln(#"hash_6e4cedc56165f367");
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
            continue;
        }
        if (menu == "PositionDraft") {
            self draft::function_168be332(response, intval);
        }
    }
}

// Namespace zm_gametype/zm_gametype
// Params 0, eflags: 0x0
// Checksum 0x5de9ab37, Offset: 0x2b00
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
        self player::function_c68794fe(0);
        self notify(#"end_respawn");
    }
}

// Namespace zm_gametype/zm_gametype
// Params 0, eflags: 0x0
// Checksum 0x48f8a183, Offset: 0x2cf8
// Size: 0x34
function custom_spawn_init_func() {
    array::thread_all(level.zombie_spawners, &spawner::add_spawn_function, level._zombies_round_spawn_failsafe);
}

// Namespace zm_gametype/zm_gametype
// Params 0, eflags: 0x0
// Checksum 0x9475bd13, Offset: 0x2d38
// Size: 0x5c
function init() {
    level flag::init("pregame");
    level flag::set("pregame");
    level thread onplayerconnect();
}

// Namespace zm_gametype/zm_gametype
// Params 0, eflags: 0x0
// Checksum 0x6260b7e8, Offset: 0x2da0
// Size: 0x70
function onplayerconnect() {
    for (;;) {
        waitresult = level waittill(#"connected");
        waitresult.player thread onplayerspawned();
        if (isdefined(level.var_bcccda55)) {
            waitresult.player [[ level.var_bcccda55 ]]();
        }
    }
}

// Namespace zm_gametype/zm_gametype
// Params 0, eflags: 0x0
// Checksum 0x1a24b6f3, Offset: 0x2e18
// Size: 0x25c
function onplayerspawned() {
    level endon(#"end_game");
    self endon(#"disconnect");
    for (;;) {
        self util::waittill_either("spawned_player", "fake_spawned_player");
        if (isdefined(level.match_is_ending) && level.match_is_ending) {
            return;
        }
        if (self laststand::player_is_in_laststand()) {
            self thread zm_laststand::auto_revive(self);
        }
        if (isdefined(level.var_3ecd9b3a)) {
            self [[ level.var_3ecd9b3a ]]();
        }
        self setstance("stand");
        self.zmbdialogqueue = [];
        self.zmbdialogactive = 0;
        self.zmbdialoggroups = [];
        self.zmbdialoggroup = "";
        self takeallweapons();
        if (isdefined(level.givecustomcharacters)) {
            self [[ level.givecustomcharacters ]]();
        }
        self giveweapon(level.weaponbasemelee);
        if (isdefined(level.onplayerspawned_restore_previous_weapons) && isdefined(level.isresetting_grief) && level.isresetting_grief) {
            weapons_restored = self [[ level.onplayerspawned_restore_previous_weapons ]]();
        }
        if (!(isdefined(weapons_restored) && weapons_restored)) {
            self zm_loadout::give_start_weapon(1);
        }
        weapons_restored = 0;
        if (isdefined(level._team_loadout)) {
            self giveweapon(level._team_loadout);
            self switchtoweapon(level._team_loadout);
        }
        if (isdefined(level.var_df283b60)) {
            self [[ level.var_df283b60 ]]();
        }
    }
}

// Namespace zm_gametype/zm_gametype
// Params 0, eflags: 0x0
// Checksum 0x546088a6, Offset: 0x3080
// Size: 0xcc
function onplayerconnect_check_for_hotjoin() {
    /#
        if (getdvarint(#"zm_instajoin", 0) > 0) {
            return;
        }
    #/
    var_728ed071 = level flag::exists("start_zombie_round_logic");
    var_d73ff2f0 = level flag::get("start_zombie_round_logic");
    if (var_728ed071 && var_d73ff2f0 && !(isdefined(level.var_c39b7fc1) && level.var_c39b7fc1)) {
        self thread player_hotjoin();
    }
}

// Namespace zm_gametype/zm_gametype
// Params 0, eflags: 0x0
// Checksum 0x7c41f473, Offset: 0x3158
// Size: 0x15c
function player_hotjoin() {
    self endon(#"disconnect");
    self initialblack();
    self.rebuild_barrier_reward = 1;
    self.is_hotjoining = 1;
    wait 0.5;
    if (isdefined(level.givecustomcharacters)) {
        self [[ level.givecustomcharacters ]]();
    }
    self zm_player::spawnspectator();
    music::setmusicstate("none");
    self.is_hotjoining = 0;
    self.is_hotjoin = 1;
    self thread function_e675a6d3();
    if (isdefined(level.intermission) && level.intermission || isdefined(level.host_ended_game) && level.host_ended_game) {
        self setclientthirdperson(0);
        self resetfov();
        self.health = 100;
        self thread [[ level.custom_intermission ]]();
    }
}

// Namespace zm_gametype/zm_gametype
// Params 0, eflags: 0x0
// Checksum 0x2e98e3e5, Offset: 0x32c0
// Size: 0x54
function function_e675a6d3() {
    self util::streamer_wait(undefined, 0, 30);
    if (isdefined(level.var_20ae5b37)) {
        wait level.var_20ae5b37;
    }
    initialblackend();
}

// Namespace zm_gametype/zm_gametype
// Params 0, eflags: 0x0
// Checksum 0xa4739766, Offset: 0x3320
// Size: 0x5c
function initialblack() {
    initial_black = lui::get_luimenu("InitialBlack");
    initial_black initial_black::close(self);
    initial_black initial_black::open(self, 1);
}

// Namespace zm_gametype/zm_gametype
// Params 0, eflags: 0x0
// Checksum 0x557c32b9, Offset: 0x3388
// Size: 0x3c
function initialblackend() {
    initial_black = lui::get_luimenu("InitialBlack");
    initial_black initial_black::close(self);
}

// Namespace zm_gametype/zm_gametype
// Params 1, eflags: 0x4
// Checksum 0xa08e2734, Offset: 0x33d0
// Size: 0x20
function private function_c039b345(value) {
    if (!isdefined(value)) {
        return "";
    }
    return value;
}

// Namespace zm_gametype/zm_gametype
// Params 8, eflags: 0x0
// Checksum 0x63908eed, Offset: 0x33f8
// Size: 0x134
function setvisiblescoreboardcolumns(col1, col2, col3, col4, col5, col6, col7, col8) {
    col1 = function_c039b345(col1);
    col2 = function_c039b345(col2);
    col3 = function_c039b345(col3);
    col4 = function_c039b345(col4);
    col5 = function_c039b345(col5);
    col6 = function_c039b345(col6);
    col7 = function_c039b345(col7);
    col8 = function_c039b345(col8);
    setscoreboardcolumns(col1, col2, col3, col4, col5, col6, col7, col8);
}

