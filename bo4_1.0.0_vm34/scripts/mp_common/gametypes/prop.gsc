#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\bots\bot;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\damagefeedback_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\hostmigration_shared;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\killcam_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\tweakables_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\gametypes\_prop_controls;
#using scripts\mp_common\gametypes\_prop_dev;
#using scripts\mp_common\gametypes\battlechatter;
#using scripts\mp_common\gametypes\deathicons;
#using scripts\mp_common\gametypes\dogtags;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_audio;
#using scripts\mp_common\gametypes\globallogic_defaults;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_spawn;
#using scripts\mp_common\gametypes\globallogic_ui;
#using scripts\mp_common\gametypes\globallogic_utils;
#using scripts\mp_common\gametypes\round;
#using scripts\mp_common\gametypes\spawning;
#using scripts\mp_common\player\player_loadout;
#using scripts\mp_common\util;
#using scripts\weapons\weapons;

#namespace prop;

// Namespace prop/gametype_init
// Params 1, eflags: 0x40
// Checksum 0xb62378e, Offset: 0x648
// Size: 0x70c
function event_handler[gametype_init] main(eventstruct) {
    globallogic::init();
    util::registerroundswitch(0, 9);
    util::registertimelimit(0, 4);
    util::registerscorelimit(0, 0);
    util::registerroundlimit(0, 4);
    util::registerroundwinlimit(0, 3);
    util::registernumlives(0, 1);
    level.phsettings = spawnstruct();
    level.phsettings.prophidetime = 30;
    level.phsettings.propwhistletime = function_fc1530ac();
    level.phsettings.propchangecount = 2;
    level.phsettings.propnumflashes = 1;
    level.phsettings.propnumclones = 3;
    level.phsettings.propspeedscale = 1.4;
    level.phsettings.var_60a20fdc = 2;
    level.phsettings.var_23bd3153 = 0;
    level.phsettings.var_e332c699 = level.script == "mp_nuketown_x";
    level.phsettings.var_78280ce0 = level.phsettings.var_e332c699;
    if (level.phsettings.var_78280ce0) {
        level.phsettings.propnumclones = 9;
    }
    globallogic::registerfriendlyfiredelay(level.gametype, 15, 0, 1440);
    level.isprophunt = 1;
    level.allow_teamchange = "1";
    level.killstreaksenabled = 0;
    level.teambased = 1;
    level.overrideteamscore = 1;
    level.alwaysusestartspawns = 1;
    level.scoreroundwinbased = getgametypesetting("cumulativeRoundScores") == 0;
    level.teamscoreperkill = getgametypesetting("teamScorePerKill");
    level.teamscoreperdeath = getgametypesetting("teamScorePerDeath");
    level.teamscoreperheadshot = getgametypesetting("teamScorePerHeadshot");
    level.killstreaksgivegamescore = getgametypesetting("killstreaksGiveGameScore");
    level.onstartgametype = &onstartgametype;
    level.onspawnplayer = &onspawnplayer;
    level.onplayerdisconnect = &onplayerdisconnect;
    level.onroundendgame = &onroundendgame;
    level.onroundswitch = &onroundswitch;
    level.var_7d4f8220 = &function_7d4f8220;
    level.onplayerkilled = &onplayerkilled;
    level.ononeleftevent = &ononeleftevent;
    level.ontimelimit = &ontimelimit;
    level.ondeadevent = &ondeadevent;
    level.var_b9fd53a3 = &function_470f21c5;
    level.var_a58db931 = &playdeathsoundph;
    level.overrideplayerdamage = &gamemodemodifyplayerdamage;
    level.var_c17c938d = &function_c17c938d;
    level.var_6f13f156 = &function_6f13f156;
    level.var_e0d16266 = &function_e0d16266;
    level.var_4fb47492 = &function_4fb47492;
    level.givecustomloadout = &givecustomloadout;
    level.var_a4623c17 = &function_e999d;
    level.var_dc6b46ed = &function_dc6b46ed;
    level.var_9bb11de9 = &function_9bb11de9;
    level.determinewinner = &determinewinner;
    level.var_64783fef = 1;
    gameobjects::register_allowed_gameobject(level.gametype);
    level.proplist = [];
    level.propindex = [];
    level.spawnproplist = [];
    level.abilities = array("FLASH", "CLONE");
    populateproplist();
    level.graceperiod = int(level.phsettings.prophidetime + 0.5);
    level thread onplayerconnect();
    level thread delayset();
    level thread function_1edf732a();
    if (level.phsettings.var_e332c699) {
        level thread function_7010fe7f();
    }
    util::set_dvar_int_if_unset("scr_prop_minigame", 1);
    /#
        level.var_2898ef72 = 0;
        thread prop_dev::propdevgui();
    #/
    clientfield::register("allplayers", "hideTeamPlayer", 1, 2, "int");
    clientfield::register("allplayers", "pingHighlight", 1, 1, "int");
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x421d3339, Offset: 0xd60
// Size: 0x64
function function_fc1530ac() {
    if (level.script == "mp_chinatown") {
        return 18;
    } else if (level.script == "mp_redwood") {
        return 20;
    } else if (level.script == "mp_nuketown_x") {
        return 0;
    }
    return 30;
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x3042bba2, Offset: 0xdd0
// Size: 0x22
function delayset() {
    waitframe(1);
    level.playstartconversation = 0;
    level.allowspecialistdialog = 0;
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0x4fbba457, Offset: 0xe00
// Size: 0x44
function onendgame(winningteam) {
    if (isdefined(winningteam) && isdefined(level.teams[winningteam])) {
        globallogic_score::giveteamscoreforobjective(winningteam, 1);
    }
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0xd4640, Offset: 0xe50
// Size: 0xd4
function onroundswitch() {
    if (!isdefined(game.switchedsides)) {
        game.switchedsides = 0;
    }
    game.switchedsides = !game.switchedsides;
    if (level.scoreroundwinbased) {
        foreach (team in level.teams) {
            [[ level._setteamscore ]](team, game.stat[#"roundswon"][team]);
        }
    }
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0x5aad9e1a, Offset: 0xf30
// Size: 0x80
function onroundendgame(var_18d04d1c) {
    gamewinner = var_18d04d1c;
    if (level.gameended) {
        gamewinner = function_c7ac59e(gamewinner, 1);
    }
    if (gamewinner == "allies" || gamewinner == "axis") {
        ph_setfinalkillcamwinner(gamewinner);
    }
    return gamewinner;
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0x252b39f0, Offset: 0xfb8
// Size: 0x22
function determinewinner(roundwinner) {
    return function_c7ac59e(roundwinner, 0);
}

// Namespace prop/prop
// Params 2, eflags: 0x0
// Checksum 0xdafd7ac5, Offset: 0xfe8
// Size: 0x276
function function_c7ac59e(roundwinner, var_6ea8eea4) {
    gamewinner = roundwinner;
    var_f432b51f = "roundswon";
    level.proptiebreaker = "none";
    if (game.stat[var_f432b51f][#"allies"] == game.stat[var_f432b51f][#"axis"]) {
        level.proptiebreaker = "kills";
        if (game.propscore[#"axis"] == game.propscore[#"allies"]) {
            level.proptiebreaker = "time";
            if (game.hunterkilltime[#"axis"] == game.hunterkilltime[#"allies"]) {
                level.proptiebreaker = "tie";
                gamewinner = "tie";
            } else if (game.hunterkilltime[#"axis"] < game.hunterkilltime[#"allies"]) {
                gamewinner = "axis";
            } else {
                gamewinner = "allies";
            }
        } else if (game.propscore[#"axis"] > game.propscore[#"allies"]) {
            gamewinner = "axis";
        } else {
            gamewinner = "allies";
        }
        if (gamewinner != "tie" && var_6ea8eea4) {
            level thread givephteamscore(gamewinner);
        }
    } else if (game.stat[var_f432b51f][#"axis"] > game.stat[var_f432b51f][#"allies"]) {
        gamewinner = "axis";
    } else {
        gamewinner = "allies";
    }
    return gamewinner;
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0xaab873d7, Offset: 0x1268
// Size: 0x1a4
function onscoreclosemusic() {
    teamscores = [];
    while (!level.gameended) {
        scorelimit = level.scorelimit;
        scorethreshold = scorelimit * 0.1;
        scorethresholdstart = abs(scorelimit - scorethreshold);
        scorelimitcheck = scorelimit - 10;
        topscore = 0;
        runnerupscore = 0;
        foreach (team in level.teams) {
            score = [[ level._getteamscore ]](team);
            if (score > topscore) {
                runnerupscore = topscore;
                topscore = score;
                continue;
            }
            if (score > runnerupscore) {
                runnerupscore = score;
            }
        }
        scoredif = topscore - runnerupscore;
        if (topscore >= scorelimit * 0.5) {
            level notify(#"sndmusichalfway");
            return;
        }
        wait 1;
    }
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0xff0acdbb, Offset: 0x1418
// Size: 0xce
function onplayerconnect() {
    while (true) {
        res = level waittill(#"connected");
        player = res.player;
        player.var_d1d70226 = 1;
        if (isdefined(level.allow_teamchange) && level.allow_teamchange == "0") {
            player.hasdonecombat = 1;
        }
        if (!isdefined(player.pers[#"objtime"])) {
            player.pers[#"objtime"] = 0;
        }
    }
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0xd8ab737a, Offset: 0x14f0
// Size: 0xf8
function hidehudintermission() {
    level waittill(#"game_ended");
    if (useprophudserver()) {
        level.elim_hud.alpha = 0;
        if (level.phsettings.propwhistletime > 0) {
            level.phwhistletimer.alpha = 0;
            level.whistling.alpha = 0;
        }
    }
    foreach (player in level.players) {
        player prop_controls::propabilitykeysvisible(0);
    }
}

// Namespace prop/prop
// Params 2, eflags: 0x0
// Checksum 0xc675c228, Offset: 0x15f0
// Size: 0xce
function update_objective_hint_message(attackersmsg, defendersmsg) {
    foreach (team, _ in level.teams) {
        if (team == game.attackers) {
            game.strings["objective_hint_" + team] = attackersmsg;
            continue;
        }
        game.strings["objective_hint_" + team] = defendersmsg;
    }
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x59f7ab4c, Offset: 0x16c8
// Size: 0x6ec
function onstartgametype() {
    setclientnamemode("manual_change");
    if (!isdefined(game.switchedsides)) {
        game.switchedsides = 0;
    }
    level.displayroundendtext = 0;
    influencers::create_map_placed_influencers();
    level.spawnmins = (0, 0, 0);
    level.spawnmaxs = (0, 0, 0);
    util::setobjectivetext(game.attackers, #"objectives_ph_attacker");
    util::setobjectivetext(game.defenders, #"objectives_ph_defender");
    update_objective_hint_message(#"objectives_ph_attacker_hint", #"objectives_ph_defender_hint");
    if (level.splitscreen) {
        util::setobjectivescoretext(game.attackers, #"objectives_ph_attacker");
        util::setobjectivescoretext(game.defenders, #"objectives_ph_defender");
    } else {
        util::setobjectivescoretext(game.attackers, #"objectives_ph_attacker_score");
        util::setobjectivescoretext(game.defenders, #"objectives_ph_defender_score");
    }
    foreach (team in level.teams) {
        spawning::add_spawn_points(team, "mp_tdm_spawn");
        spawning::place_spawn_points(spawning::gettdmstartspawnname(team));
    }
    spawning::updateallspawnpoints();
    var_1210f0f7 = game.roundsplayed % 4 == 2 || game.roundsplayed % 4 == 3;
    if (var_1210f0f7) {
        game.switchedsides = !game.switchedsides;
    }
    level.spawn_start = [];
    foreach (team in level.teams) {
        level.spawn_start[team] = spawning::get_spawnpoint_array(spawning::gettdmstartspawnname(team));
    }
    if (var_1210f0f7) {
        game.switchedsides = !game.switchedsides;
    }
    level.mapcenter = math::find_box_center(level.spawnmins, level.spawnmaxs);
    setmapcenter(level.mapcenter);
    spawnpoint = spawning::get_random_intermission_point();
    setdemointermissionpoint(spawnpoint.origin, spawnpoint.angles);
    level thread onscoreclosemusic();
    if (!util::isoneround()) {
        level.displayroundendtext = 1;
        if (level.scoreroundwinbased) {
            globallogic_score::resetteamscores();
        }
    }
    if (isdefined(level.droppedtagrespawn) && level.droppedtagrespawn) {
        level.numlives = 1;
    }
    level._effect[#"propflash"] = "explosions/fx_exp_dest_barrel_lg";
    level._effect[#"propdeathfx"] = "explosions/fx_exp_dest_barrel_lg";
    if (!isdefined(game.propscore)) {
        game.propscore = [];
        game.propscore[#"allies"] = 0;
        game.propscore[#"axis"] = 0;
    }
    if (!isdefined(game.propsurvivaltime)) {
        game.propsurvivaltime = [];
        game.propsurvivaltime[#"allies"] = 0;
        game.propsurvivaltime[#"axis"] = 0;
    }
    if (!isdefined(game.hunterkilltime)) {
        game.hunterkilltime = [];
        game.hunterkilltime[#"allies"] = 0;
        game.hunterkilltime[#"axis"] = 0;
    }
    level flag::init("props_hide_over", 0);
    level thread setuproundstarthud();
    if (level.phsettings.propwhistletime > 0) {
        level thread propwhistle();
    }
    level thread hidehudintermission();
    level thread monitortimers();
    level thread setphteamscores();
    level thread stillalivexp();
    level thread function_4bdf92a7();
    level thread tracktimealive();
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0x136916fd, Offset: 0x1dc0
// Size: 0x8c
function function_eed17dac(weapon) {
    self.primaryweapon = weapon;
    self giveweapon(weapon);
    self switchtoweapon(weapon);
    self setspawnweapon(weapon);
    self.spawnweapon = weapon;
    self setblockweaponpickup(weapon, 1);
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0x1e27826e, Offset: 0x1e58
// Size: 0x54
function function_f6c740a4(weapon) {
    self.secondaryweapon = weapon;
    self giveweapon(weapon);
    self setblockweaponpickup(weapon, 1);
}

// Namespace prop/prop
// Params 2, eflags: 0x0
// Checksum 0x5a4baf17, Offset: 0x1eb8
// Size: 0x76
function function_c32f3fcc(primaryoffhand, primaryoffhandcount) {
    self giveweapon(primaryoffhand);
    self setweaponammostock(primaryoffhand, primaryoffhandcount);
    self switchtooffhand(primaryoffhand);
    self.grenadetypeprimary = primaryoffhand;
    self.grenadetypeprimarycount = primaryoffhandcount;
}

// Namespace prop/prop
// Params 2, eflags: 0x0
// Checksum 0x5eee0909, Offset: 0x1f38
// Size: 0x76
function function_5ca26274(secondaryoffhand, secondaryoffhandcount) {
    self giveweapon(secondaryoffhand);
    self setweaponammoclip(secondaryoffhand, secondaryoffhandcount);
    self switchtooffhand(secondaryoffhand);
    self.grenadetypesecondary = secondaryoffhand;
    self.grenadetypesecondarycount = secondaryoffhandcount;
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0xddc70fe0, Offset: 0x1fb8
// Size: 0x3c
function giveperk(perkname) {
    if (!self hasperk(perkname)) {
        self setperk(perkname);
    }
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x46e796c3, Offset: 0x2000
// Size: 0x152
function givecustomloadout() {
    loadout::init_player(1);
    loadout::function_3f1c5df5(self.curclass);
    self clearperks();
    weapon = undefined;
    if (self util::isprop()) {
        weapon = getweapon("pistol_standard_t8");
        self function_eed17dac(weapon);
    } else {
        weapon = getweapon("pistol_standard_t8");
        self function_f6c740a4(weapon);
        weapon = getweapon("smg_standard_t8");
        self function_eed17dac(weapon);
        self attackerinitammo();
    }
    self giveweapon(level.weaponbasemelee);
    self notify(#"applyloadout");
    return weapon;
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x548d2069, Offset: 0x2160
// Size: 0x1a
function is_player_gamepad_enabled() {
    return self gamepadusedlast();
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0x66a99625, Offset: 0x2188
// Size: 0x5c
function whistlestarttimer(duration) {
    level notify(#"hash_581d4ff3d0fa766c");
    counttime = int(duration);
    if (counttime >= 0) {
        thread whistlestarttimer_internal(counttime);
    }
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0x14d9b7ed, Offset: 0x21f0
// Size: 0x52
function whistlestarttimer_internal(counttime) {
    level endon(#"hash_581d4ff3d0fa766c");
    waittillframeend();
    while (counttime > 0 && !level.gameended) {
        counttime--;
        wait 1;
    }
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0xf82e415a, Offset: 0x2250
// Size: 0x3c
function useprophudserver() {
    /#
        if (getdvarint(#"scr_ph_useprophudserver", 0) != 0) {
            return true;
        }
    #/
    return true;
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0x1091f876, Offset: 0x2298
// Size: 0x1a
function settimer(time) {
    self.time = time;
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0x4a0d5964, Offset: 0x22c0
// Size: 0x1a
function setvalue(value) {
    self.value = value;
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x7d89dd9f, Offset: 0x22e8
// Size: 0x46e
function setuproundstarthud() {
    level.phcountdowntimer = spawnstruct();
    level.phcountdowntimer.label = #"mp_ph_starts_in";
    level.phcountdowntimer.alpha = 0;
    level.phcountdowntimer.archived = 0;
    level.phcountdowntimer.hidewheninmenu = 1;
    level.phcountdowntimer.sort = 1;
    if (useprophudserver()) {
        var_62372e41 = 110;
        var_ff475784 = 20;
        if (!level.console) {
            var_62372e41 = 125;
            var_ff475784 = 15;
        }
        level.elim_hud = spawnstruct();
        level.elim_hud.label = #"mp_ph_alive";
        level.elim_hud setvalue(0);
        level.elim_hud.x = 5;
        level.elim_hud.y = var_62372e41;
        level.elim_hud.alignx = "left";
        level.elim_hud.aligny = "top";
        level.elim_hud.horzalign = "left";
        level.elim_hud.vertalign = "top";
        level.elim_hud.archived = 1;
        level.elim_hud.alpha = 0;
        level.elim_hud.glowalpha = 0;
        level.elim_hud.hidewheninmenu = 0;
        level thread eliminatedhudmonitor();
        if (level.phsettings.propwhistletime > 0) {
            level.phwhistletimer = spawnstruct();
            level.phwhistletimer.x = 5;
            level.phwhistletimer.y = var_62372e41 + var_ff475784;
            level.phwhistletimer.alignx = "left";
            level.phwhistletimer.aligny = "top";
            level.phwhistletimer.horzalign = "left";
            level.phwhistletimer.vertalign = "top";
            level.phwhistletimer.label = #"mp_ph_whistle_in";
            level.phwhistletimer.alpha = 0;
            level.phwhistletimer.archived = 1;
            level.phwhistletimer.hidewheninmenu = 0;
            level.phwhistletimer settimer(120);
            level.whistling = spawnstruct();
            level.whistling.label = #"mp_ph_whistling";
            level.whistling.x = 5;
            level.whistling.y = var_62372e41 + var_ff475784;
            level.whistling.alignx = "left";
            level.whistling.aligny = "top";
            level.whistling.horzalign = "left";
            level.whistling.vertalign = "top";
            level.whistling.archived = 1;
            level.whistling.alpha = 0;
            level.whistling.glowalpha = 0.2;
            level.whistling.hidewheninmenu = 0;
        }
    }
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x622aaef2, Offset: 0x2760
// Size: 0xd0
function eliminatedhudmonitor() {
    level endon(#"game_ended");
    while (true) {
        props = get_alive_nonspecating_players(game.defenders);
        level.elim_hud setvalue(props.size);
        level waittill(#"player_spawned", #"player_killed", #"player_eliminated", #"playercountchanged", #"propcountchanged", #"playerdisconnected");
    }
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0x70be15c, Offset: 0x2838
// Size: 0x104
function get_alive_nonspecating_players(team) {
    var_184db3e = [];
    foreach (player in level.players) {
        if (isdefined(player) && isalive(player) && (!isdefined(player.sessionstate) || player.sessionstate == "playing")) {
            if (!isdefined(team) || player.team == team) {
                var_184db3e[var_184db3e.size] = player;
            }
        }
    }
    return var_184db3e;
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x18789ba, Offset: 0x2948
// Size: 0x44
function onplayerdisconnect() {
    level notify(#"playerdisconnected");
    if (function_503c9413()) {
        thread function_c021720c(0.05);
    }
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x83007c3, Offset: 0x2998
// Size: 0x2e
function function_45c842e9() {
    while (isdefined(level.inprematchperiod) && level.inprematchperiod) {
        waitframe(1);
    }
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0x503b062a, Offset: 0x29d0
// Size: 0x384
function onspawnplayer(predictedspawn) {
    self.breathingstoptime = 0;
    if (self util::isprop()) {
        self.var_292246d3 = undefined;
        if (!isdefined(self.abilityleft)) {
            self.abilityleft = 0;
        }
        if (!isdefined(self.clonesleft)) {
            self.clonesleft = 0;
        }
        if (!isdefined(self.pers[#"ability"])) {
            self.pers[#"ability"] = 0;
        }
        self.currentability = level.abilities[self.pers[#"ability"]];
        if (useprophudserver()) {
            self thread prop_controls::propcontrolshud();
        }
        self.isangleoffset = 0;
        changecount = int(level.phsettings.propchangecount);
        abilitycount = undefined;
        var_4a6a29c9 = undefined;
        if (isdefined(self.spawnedonce) && isdefined(self.changesleft)) {
            changecount = self.changesleft;
            abilitycount = self.abilityleft;
            var_4a6a29c9 = self.clonesleft;
        }
        self prop_controls::propsetchangesleft(changecount);
        self prop_controls::setnewabilitycount(self.currentability, abilitycount);
        self prop_controls::setnewabilitycount("CLONE", var_4a6a29c9);
        self thread prop_controls::cleanuppropcontrolshudondeath();
        self thread handleprop();
    } else {
        self.abilityleft = undefined;
        self.clonesleft = undefined;
        if (!isdefined(self.var_292246d3)) {
            self.var_292246d3 = 0;
        }
        if (!isdefined(self.thrownspecialcount)) {
            self.thrownspecialcount = 0;
        }
        if (useprophudserver()) {
            self thread prop_controls::function_bf45ce54();
        }
        var_292246d3 = level.phsettings.var_60a20fdc;
        if (isdefined(self.spawnedonce) && isdefined(self.var_292246d3)) {
            var_292246d3 = self.var_292246d3;
        }
        self prop_controls::function_afeda2bf(var_292246d3);
        self thread prop_controls::function_227409a5();
        self thread function_346bdc3b();
    }
    self thread attackerswaittime();
    if (level.usestartspawns && !level.ingraceperiod && !level.playerqueuedrespawn) {
        level.usestartspawns = 0;
    }
    self.spawnedonce = 1;
    spawning::onspawnplayer(predictedspawn);
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0xadd808b6, Offset: 0x2d60
// Size: 0x2aa
function monitortimers() {
    level endon(#"game_ended");
    function_45c842e9();
    level.allow_teamchange = "0";
    foreach (player in level.players) {
        player.hasdonecombat = 1;
    }
    level thread function_cdee7177();
    if (level.phsettings.prophidetime > 0) {
        level.phcountdowntimer settimer(level.phsettings.prophidetime);
        level.phcountdowntimer.alpha = 1;
    }
    if (useprophudserver() && level.phsettings.propwhistletime > 0) {
        level.phwhistletimer settimer(level.phsettings.propwhistletime + level.phsettings.prophidetime);
    }
    if (level.phsettings.prophidetime > 0 || level.phsettings.propwhistletime > 0) {
        whistlestarttimer(level.phsettings.propwhistletime + level.phsettings.prophidetime);
    }
    if (level.phsettings.prophidetime > 0) {
        function_da184fd(level.phsettings.prophidetime);
    }
    level flag::set("props_hide_over");
    if (useprophudserver()) {
        if (level.phsettings.propwhistletime > 0) {
            level.phwhistletimer.alpha = 1;
        }
        level.elim_hud.alpha = 1;
    }
    level.phcountdowntimer.alpha = 0;
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x58def94c, Offset: 0x3018
// Size: 0x272
function function_cdee7177() {
    level endon(#"game_ended");
    level endon(#"props_hide_over");
    var_8cbf9eb6 = int(level.phsettings.prophidetime + gettime() / 1000);
    totaltimepassed = 0;
    while (true) {
        level waittill(#"host_migration_begin");
        level.phcountdowntimer.alpha = 0;
        if (useprophudserver() && level.phsettings.propwhistletime > 0) {
            level.phwhistletimer.alpha = 0;
        }
        timepassed = int(hostmigration::waittillhostmigrationdone() / 1000);
        totaltimepassed += timepassed;
        timepassed = totaltimepassed;
        var_c1ce6993 = var_8cbf9eb6 + timepassed - int(gettime() / 1000);
        level.phcountdowntimer settimer(var_c1ce6993);
        if (useprophudserver() && level.phsettings.propwhistletime > 0) {
            level.phwhistletimer settimer(level.phsettings.propwhistletime + var_c1ce6993);
        }
        whistlestarttimer(level.phsettings.propwhistletime + var_c1ce6993);
        level.phcountdowntimer.alpha = 1;
        if (useprophudserver() && level.phsettings.propwhistletime > 0) {
            level.phwhistletimer.alpha = 1;
        }
    }
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0xc1f708b0, Offset: 0x3298
// Size: 0x25c
function handleprop() {
    level endon(#"game_ended");
    self endon(#"disconnect");
    self endon(#"death");
    self waittill(#"applyloadout");
    self allowprone(0);
    self allowcrouch(0);
    self allowsprint(0);
    self allowslide(0);
    self setmovespeedscale(level.phsettings.propspeedscale);
    self playerknockback(0);
    self takeallweapons();
    self allowspectateteam(game.attackers, 1);
    self ghost();
    self setclientuivisibilityflag("weapon_hud_visible", 0);
    self.healthregendisabled = 1;
    self.concussionimmune = undefined;
    assert(!isdefined(self.prop));
    self thread setupprop();
    self thread prop_controls::setupkeybindings();
    self thread setupdamage();
    self thread prop_controls::propinputwatch();
    self thread propwatchdeath();
    self thread propwatchcleanupondisconnect();
    self thread propwatchcleanuponroundend();
    self thread propwatchprematchsettings();
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0xafb2a370, Offset: 0x3500
// Size: 0xce
function getthirdpersonrangeforsize(propsize) {
    switch (propsize) {
    case 50:
        return 120;
    case 100:
        return 150;
    case 200:
        return 180;
    case 300:
        return 260;
    case 400:
        return 320;
    default:
        assertmsg("<dev string:x30>" + propsize);
        break;
    }
    return 120;
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0x9b8725cf, Offset: 0x35d8
// Size: 0xc4
function getthirdpersonheightoffsetforsize(propsize) {
    switch (propsize) {
    case 50:
        return -30;
    case 100:
        return -20;
    case 200:
        return 0;
    case 300:
        return 20;
    case 400:
        return 40;
    default:
        assertmsg("<dev string:x30>" + propsize);
        break;
    }
    return 0;
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0xfd8bb5cc, Offset: 0x36a8
// Size: 0x162
function applyxyzoffset() {
    if (!isdefined(self.prop.xyzoffset)) {
        return;
    }
    self.prop.angles = self.angles;
    forward = anglestoforward(self.prop.angles) * self.prop.xyzoffset[0];
    right = anglestoright(self.prop.angles) * self.prop.xyzoffset[1];
    up = anglestoup(self.prop.angles) * self.prop.xyzoffset[2];
    self.prop.origin += forward;
    self.prop.origin += right;
    self.prop.origin += up;
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0xfdf02b1a, Offset: 0x3818
// Size: 0x6e
function applyanglesoffset() {
    if (!isdefined(self.prop.anglesoffset)) {
        return;
    }
    self.prop.angles = self.angles;
    self.prop.angles += self.prop.anglesoffset;
    self.isangleoffset = 1;
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0xddbdba88, Offset: 0x3890
// Size: 0x4c8
function propwhistle() {
    level endon(#"game_ended");
    function_45c842e9();
    time = gettime();
    whistletime = level.phsettings.propwhistletime * 1000;
    var_d97f029 = 20000;
    var_7335da26 = var_d97f029;
    var_defcb34f = 500;
    var_c3f83285 = 5000;
    var_2812d72a = 0;
    var_1bb1b603 = (0, 0, 0);
    minimapcorners = getentarray("minimap_corner", "targetname");
    if (minimapcorners.size > 0) {
        var_1bb1b603 = minimapcorners[0].origin;
    }
    hostmigration::waitlongdurationwithhostmigrationpause(level.phsettings.prophidetime + level.phsettings.propwhistletime);
    while (true) {
        if (time + whistletime - var_defcb34f < gettime()) {
            var_2812d72a++;
            if (useprophudserver()) {
                level.phwhistletimer.alpha = 0;
                level.whistling.alpha = 1;
                level.whistling.alpha = 0.6;
            }
            sortedplayers = arraysortclosest(level.players, var_1bb1b603);
            foreach (player in sortedplayers) {
                if (!isdefined(player)) {
                    continue;
                }
                if (player util::isprop() && isalive(player)) {
                    playsoundatposition("mpl_phunt_char_whistle", player.origin + (0, 0, 60));
                    hostmigration::waitlongdurationwithhostmigrationpause(1.5);
                }
            }
            time = gettime();
            if (var_2812d72a % 2 == 0) {
                whistletime = max(whistletime - 5000, var_d97f029);
            }
            if (var_7335da26 >= globallogic_utils::gettimeremaining() - var_c3f83285) {
                if (useprophudserver()) {
                    level.whistling.alpha = 0;
                }
                return;
            } else {
                if (var_7335da26 * 2 + getteamplayersalive(game.defenders) * 2500 >= globallogic_utils::gettimeremaining() - var_c3f83285) {
                    if (useprophudserver()) {
                        level.phwhistletimer.label = #"mp_ph_final_whistle";
                    }
                    var_7335da26 += getteamplayersalive(game.defenders) * 2500;
                }
                if (useprophudserver()) {
                    level.phwhistletimer settimer(int(whistletime / 1000));
                }
                whistlestarttimer(int(whistletime / 1000));
                if (useprophudserver()) {
                    level.whistling.alpha = 0;
                    level.phwhistletimer.alpha = 1;
                }
            }
        }
        hostmigration::waitlongdurationwithhostmigrationpause(0.5);
    }
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0x3a7ddb2a, Offset: 0x3d60
// Size: 0xd8
function getlivingplayersonteam(team) {
    players = [];
    foreach (player in level.players) {
        if (!isdefined(player.team)) {
            continue;
        }
        if (isalive(player) && player.team == team) {
            players[players.size] = player;
        }
    }
    return players;
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x89410798, Offset: 0x3e40
// Size: 0xb4
function setupdamage() {
    level endon(#"game_ended");
    self endon(#"death");
    self endon(#"disconnect");
    hostmigration::waitlongdurationwithhostmigrationpause(0.5);
    self.prop.health = 99999;
    self.prop.maxhealth = 99999;
    self.prop thread function_500dc7d9(&damagewatch);
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0xc3ee1445, Offset: 0x3f00
// Size: 0xe2
function function_500dc7d9(damagecallback) {
    level endon(#"game_ended");
    self endon(#"death");
    while (true) {
        res = self waittill(#"damage");
        self thread [[ damagecallback ]](res.amount, res.attacker, res.direction, res.position, res.mod, res.model_name, res.bone_name, res.part_name, res.weapon, res.flags);
    }
}

// Namespace prop/prop
// Params 10, eflags: 0x0
// Checksum 0xbc6c388c, Offset: 0x3ff0
// Size: 0x1a2
function damagewatch(damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, weapon, idflags) {
    if (!isdefined(attacker)) {
        return;
    }
    if (!isdefined(self.owner)) {
        return;
    }
    if (isplayer(attacker)) {
        if (attacker.pers[#"team"] == self.owner.pers[#"team"]) {
            return;
        }
        attacker thread damagefeedback::update();
        if (isdefined(weapon) && weapon.rootweapon.name == "concussion_grenade" && isdefined(meansofdeath) && meansofdeath != "MOD_IMPACT") {
            prop_controls::function_770b4cfa(attacker, undefined, meansofdeath, damage, point, weapon);
        }
    }
    self.owner dodamage(damage, point, attacker, attacker, "none", meansofdeath, idflags, weapon);
    self.health = 99999;
    self.maxhealth = 99999;
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x3f8406ed, Offset: 0x41a0
// Size: 0x4c
function propcleanup() {
    array = array(self.prop, self.propanchor, self.propent);
    self thread propcleanupdelayed(array);
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0xcc69e798, Offset: 0x41f8
// Size: 0x100
function propcleanupdelayed(propents) {
    foreach (prop in propents) {
        if (isdefined(prop)) {
            prop unlink();
        }
    }
    waitframe(1);
    foreach (prop in propents) {
        if (isdefined(prop)) {
            prop delete();
        }
    }
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x74a3cec2, Offset: 0x4300
// Size: 0x10c
function propwatchdeath() {
    level endon(#"game_ended");
    self endon(#"disconnect");
    self waittill(#"death");
    corpse = self.body;
    playsoundatposition("wpn_flash_grenade_explode", self.prop.origin + (0, 0, 4));
    playfx(fx::get("propDeathFX"), self.prop.origin + (0, 0, 4));
    if (isdefined(corpse)) {
        corpse delete();
    }
    self propcleanup();
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x60ac95cf, Offset: 0x4418
// Size: 0x7c
function propwatchcleanupondisconnect() {
    self notify(#"propwatchcleanupondisconnect");
    self endon(#"propwatchcleanupondisconnect");
    level endon(#"game_ended");
    self waittill(#"disconnect");
    self propcleanup();
    self propclonecleanup();
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x730f61af, Offset: 0x44a0
// Size: 0x7c
function propwatchcleanuponroundend() {
    self notify(#"hash_23d745b724b7c0bd");
    self endon(#"hash_23d745b724b7c0bd");
    self endon(#"disconnect");
    level waittill(#"round_end_done");
    self propcleanup();
    self propclonecleanup();
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x678e12f5, Offset: 0x4528
// Size: 0x90
function propclonecleanup() {
    if (isdefined(self.propclones)) {
        foreach (clone in self.propclones) {
            if (isdefined(clone)) {
                clone delete();
            }
        }
    }
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x9ca259d8, Offset: 0x45c0
// Size: 0xa4
function propwatchprematchsettings() {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"joined_team");
    self endon(#"joined_spectators");
    function_45c842e9();
    self allowprone(0);
    self allowcrouch(0);
    self allowsprint(0);
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0xf49910e3, Offset: 0x4670
// Size: 0x22
function organizeproplist(inarray) {
    return array::randomize(inarray);
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x89268cb1, Offset: 0x46a0
// Size: 0x182
function randgetpropsizetoallocate() {
    weight_xsmall = 10 * isdefined(level.proplist[50]);
    weight_small = 30 * isdefined(level.proplist[100]);
    weight_medium = 40 * isdefined(level.proplist[200]);
    weight_large = 20 * isdefined(level.proplist[300]);
    weight_xlarge = 10 * isdefined(level.proplist[400]);
    randomrange = weight_xsmall + weight_small + weight_medium + weight_large + weight_xlarge;
    randomval = randomint(randomrange);
    if (randomval < weight_xsmall) {
        return 50;
    }
    randomval -= weight_xsmall;
    if (randomval < weight_small) {
        return 100;
    }
    randomval -= weight_small;
    if (randomval < weight_medium) {
        return 200;
    }
    randomval -= weight_medium;
    if (randomval < weight_large) {
        return 300;
    }
    randomval -= weight_large;
    return 400;
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0x19cf02d, Offset: 0x4830
// Size: 0x280
function getnextprop(inplayer) {
    var_951c47b8 = randgetpropsizetoallocate();
    var_5ed17249 = getarraykeys(level.proplist);
    var_5ed17249 = array::randomize(var_5ed17249);
    var_fb988098 = array(var_951c47b8);
    foreach (size in var_5ed17249) {
        if (size != var_951c47b8) {
            var_fb988098[var_fb988098.size] = size;
        }
    }
    prop = undefined;
    for (i = 0; i < var_fb988098.size; i++) {
        size = var_fb988098[i];
        if (!isdefined(level.proplist[size]) || !level.proplist[size].size) {
            continue;
        }
        var_ecfadf1a = array::randomize(level.proplist[size]);
        for (j = 0; j < var_ecfadf1a.size; j++) {
            prop = var_ecfadf1a[j];
            var_c8c6579 = 0;
            if (isdefined(inplayer.usedprops) && inplayer.usedprops.size) {
                for (index = 0; index < inplayer.usedprops.size; index++) {
                    if (prop.modelname == inplayer.usedprops[index].modelname) {
                        var_c8c6579 = 1;
                        break;
                    }
                }
            }
            if (!var_c8c6579) {
                return prop;
            }
        }
    }
    return prop;
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x7b27630, Offset: 0x4ab8
// Size: 0xe
function getmapname() {
    return level.script;
}

// Namespace prop/prop
// Params 3, eflags: 0x0
// Checksum 0xb9474f03, Offset: 0x4ad0
// Size: 0x5e
function tablelookupbyrow(var_8c6b47e7, rowindex, columnindex) {
    columns = tablelookuprow(var_8c6b47e7, rowindex);
    if (columnindex < columns.size) {
        return columns[columnindex];
    }
    return "";
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0xb1ff79c4, Offset: 0x4b38
// Size: 0x4a6
function populateproplist() {
    mapname = "mp_coremovement";
    var_8c6b47e7 = "gamedata/tables/mp/" + mapname + "_ph.csv";
    numrows = tablelookuprowcount(var_8c6b47e7);
    for (rowindex = 0; rowindex < numrows; rowindex++) {
        modelname = tablelookupbyrow(var_8c6b47e7, rowindex, 0);
        propsizetext = tablelookupbyrow(var_8c6b47e7, rowindex, 1);
        propscale = float(tablelookupbyrow(var_8c6b47e7, rowindex, 2));
        offsetx = int(tablelookupbyrow(var_8c6b47e7, rowindex, 3));
        offsety = int(tablelookupbyrow(var_8c6b47e7, rowindex, 4));
        offsetz = int(tablelookupbyrow(var_8c6b47e7, rowindex, 5));
        rotationx = int(tablelookupbyrow(var_8c6b47e7, rowindex, 6));
        rotationy = int(tablelookupbyrow(var_8c6b47e7, rowindex, 7));
        rotationz = int(tablelookupbyrow(var_8c6b47e7, rowindex, 8));
        propheight = tablelookupbyrow(var_8c6b47e7, rowindex, 9);
        proprange = tablelookupbyrow(var_8c6b47e7, rowindex, 10);
        offset = undefined;
        if (isdefined(offsetx) && isdefined(offsety) && isdefined(offsetz)) {
            offset = (offsetx, offsety, offsetz);
        }
        rotation = undefined;
        if (isdefined(rotationx) && isdefined(rotationy) && isdefined(rotationz)) {
            rotation = (rotationx, rotationy, rotationz);
        }
        if (!isdefined(propscale) || propscale == 0) {
            propscale = 1;
        }
        propsize = getpropsize(propsizetext);
        if (!isdefined(propheight) || propheight == "") {
            propheight = getthirdpersonheightoffsetforsize(propsize);
        } else {
            propheight = int(propheight);
        }
        if (!isdefined(proprange) || proprange == "") {
            proprange = getthirdpersonrangeforsize(propsize);
        } else {
            proprange = int(proprange);
        }
        addproptolist(modelname, propsize, offset, rotation, propsizetext, propscale, propheight, proprange);
    }
    if (numrows == 0) {
        addproptolist("tag_origin", 200, (0, 0, 0), (0, 0, 0), "medium", 1, getthirdpersonheightoffsetforsize(200), getthirdpersonrangeforsize(200));
    }
    level.proplist = organizeproplist(level.proplist);
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x49086da9, Offset: 0x4fe8
// Size: 0x4b2
function setupprop() {
    self notsolid();
    if (!isdefined(level.phsettings.playercontents) || level.phsettings.playercontents == 0) {
        level.phsettings.playercontents = self setcontents(0);
    } else {
        self setcontents(0);
    }
    self setplayercollision(0);
    propinfo = self.propinfo;
    if (!isdefined(self.propinfo)) {
        propinfo = getnextprop(self);
    }
    self.propanchor = spawn("script_model", self.origin);
    self.propanchor.targetname = "propAnchor";
    self.propanchor linkto(self);
    self.propanchor setcontents(0);
    self.propanchor notsolid();
    self.propanchor setplayercollision(0);
    self.propent = spawn("script_model", self.origin);
    self.propent.targetname = "propEnt";
    self.propent linkto(self.propanchor);
    self.propent setcontents(0);
    self.propent notsolid();
    self.propent setplayercollision(0);
    self.prop = spawn("script_model", self.propent.origin);
    self.prop.targetname = "prop";
    self.prop setmodel(propinfo.modelname);
    self.prop setscale(propinfo.propscale);
    self.prop setcandamage(1);
    self.prop setowner(self);
    self.prop setteam(self.team);
    self.prop.xyzoffset = propinfo.xyzoffset;
    self.prop.anglesoffset = propinfo.anglesoffset;
    self applyxyzoffset();
    self applyanglesoffset();
    self.prop linkto(self.propent);
    self.prop.owner = self;
    self.prop.health = 10000;
    self.prop setplayercollision(0);
    self.prop clientfield::set("enemyequip", 1);
    if (function_503c9413()) {
        self thread function_f2704a3c(0);
    }
    self.thirdpersonrange = propinfo.proprange;
    self.thirdpersonheightoffset = propinfo.propheight;
    self setclientthirdperson(1);
    self.prop.info = propinfo;
    self.propinfo = propinfo;
    if (!isdefined(self.spawnedonce)) {
        self.usedprops = [];
    }
    self.health = getprophealth(propinfo);
    self.maxhealth = self.health;
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0xa60eaece, Offset: 0x54a8
// Size: 0x22
function getprophealth(propinfo) {
    return int(propinfo.propsize);
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0xf430245d, Offset: 0x54d8
// Size: 0x16e
function getpropsize(propsizetext) {
    /#
        if (propsizetext == "<dev string:x3f>") {
            return 0;
        }
    #/
    propsize = 0;
    switch (propsizetext) {
    case #"xsmall":
        propsize = 50;
        break;
    case #"small":
        propsize = 100;
        break;
    case #"medium":
        propsize = 200;
        break;
    case #"large":
        propsize = 300;
        break;
    case #"xlarge":
        propsize = 400;
        break;
    default:
        mapname = getmapname();
        var_8c6b47e7 = "gamedata/tables/mp/" + mapname + "_ph.csv";
        assertmsg("<dev string:x46>" + propsizetext + "<dev string:x5a>" + var_8c6b47e7 + "<dev string:x6c>");
        propsize = 100;
        break;
    }
    return propsize;
}

// Namespace prop/prop
// Params 8, eflags: 0x0
// Checksum 0x19a4af67, Offset: 0x5650
// Size: 0x204
function addproptolist(modelname, propsize, xyzoffset, anglesoffset, propsizetext, propscale, propheight, proprange) {
    if (!isdefined(level.proplist)) {
        level.proplist = [];
    }
    if (!isdefined(level.propindex)) {
        level.propindex = [];
    }
    if (!isdefined(level.proplist[propsize])) {
        level.proplist[propsize] = [];
    }
    propinfo = spawnstruct();
    propinfo.modelname = modelname;
    propinfo.propscale = propscale;
    propinfo.propsize = int(propsize);
    propinfo.propsizetext = propsizetext;
    if (isdefined(xyzoffset)) {
        propinfo.xyzoffset = xyzoffset;
    }
    if (isdefined(anglesoffset)) {
        propinfo.anglesoffset = anglesoffset;
    }
    propinfo.proprange = proprange;
    propinfo.propheight = propheight;
    index = level.propindex.size;
    level.propindex[index] = [];
    level.propindex[index][0] = propsize;
    level.propindex[index][1] = level.proplist[propsize].size;
    level.proplist[propsize][level.proplist[propsize].size] = propinfo;
}

// Namespace prop/prop
// Params 2, eflags: 0x0
// Checksum 0x326c155e, Offset: 0x5860
// Size: 0x44
function function_8eee536a(winning_team, var_c3d87d03) {
    round::set_winner(winning_team);
    thread globallogic::function_e0994b4(winning_team, var_c3d87d03);
}

// Namespace prop/prop
// Params 2, eflags: 0x0
// Checksum 0x1ef4f7dc, Offset: 0x58b0
// Size: 0x8c
function ph_endgame(winningteam, endreasontext) {
    if (isdefined(level.endingph) && level.endingph) {
        return;
    }
    level.endingph = 1;
    ph_setfinalkillcamwinner(winningteam);
    thread function_8eee536a(winningteam, endreasontext);
    level thread givephteamscore(winningteam);
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0x91cad9fc, Offset: 0x5948
// Size: 0x3e
function ph_setfinalkillcamwinner(winningteam) {
    level.finalkillcam_winner = winningteam;
    if (level.finalkillcam_winner == game.defenders) {
        level.var_fb8e299e = 1;
    }
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0x743dc641, Offset: 0x5990
// Size: 0x84
function givephteamscore(team) {
    level endon(#"game_ended");
    var_a307eca2 = 0;
    if (isdefined(game.stat[#"roundswon"])) {
        var_a307eca2 = game.stat[#"roundswon"][team];
    }
    setteamscore(team, var_a307eca2);
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0xf7d22407, Offset: 0x5a20
// Size: 0xdc
function setphteamscores() {
    level endon(#"game_ended");
    var_aa6bd9ef = 0;
    var_c586b70f = 0;
    if (isdefined(game.stat[#"roundswon"])) {
        var_c586b70f = game.stat[#"roundswon"][game.defenders];
        var_aa6bd9ef = game.stat[#"roundswon"][game.attackers];
    }
    setteamscore(game.defenders, var_c586b70f);
    setteamscore(game.attackers, var_aa6bd9ef);
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0x8a532791, Offset: 0x5b08
// Size: 0x13c
function ononeleftevent(team) {
    if (isdefined(level.gameended) && level.gameended) {
        return;
    }
    if (team == game.attackers) {
        return;
    }
    lastplayer = undefined;
    foreach (player in level.players) {
        if (isdefined(team) && player.team != team) {
            continue;
        }
        if (!isalive(player) && !player globallogic_spawn::mayspawn()) {
            continue;
        }
        if (isdefined(lastplayer)) {
            return;
        }
        lastplayer = player;
    }
    if (!isdefined(lastplayer)) {
        return;
    }
    lastplayer thread givelastonteamwarning();
}

// Namespace prop/prop
// Params 2, eflags: 0x0
// Checksum 0x178e21c8, Offset: 0x5c50
// Size: 0xd0
function waittillrecoveredhealth(time, interval) {
    self endon(#"death");
    self endon(#"disconnect");
    fullhealthtime = 0;
    if (!isdefined(interval)) {
        interval = 0.05;
    }
    if (!isdefined(time)) {
        time = 0;
    }
    while (true) {
        if (self.health != self.maxhealth) {
            fullhealthtime = 0;
        } else {
            fullhealthtime += interval;
        }
        wait interval;
        if (self.health == self.maxhealth && fullhealthtime >= time) {
            break;
        }
    }
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x3fb6aeb, Offset: 0x5d30
// Size: 0xa8
function givelastonteamwarning() {
    self endon(#"death");
    self endon(#"disconnect");
    level endon(#"game_ended");
    self waittillrecoveredhealth(3);
    if (self util::isprop()) {
        level notify(#"hash_2732c975dc66dd9e");
        level.nopropsspectate = 1;
    }
    level notify(#"last_alive", self);
}

// Namespace prop/prop
// Params 2, eflags: 0x0
// Checksum 0x21b7a8ea, Offset: 0x5de0
// Size: 0x44
function function_435d5169(var_eb4caf58, calloutplayer) {
    luinotifyevent(#"player_callout", 2, var_eb4caf58, calloutplayer.entnum);
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0xdd6e6687, Offset: 0x5e30
// Size: 0x64
function ontimelimit() {
    if (!(isdefined(level.gameending) && level.gameending)) {
        function_f666ecbf();
        choosefinalkillcam();
        ph_endgame(game.defenders, 2);
    }
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x271d18d8, Offset: 0x5ea0
// Size: 0xde
function function_f666ecbf() {
    var_de5f82e0 = globallogic_defaults::default_gettimelimit() * 60 * 1000;
    timepassed = globallogic_utils::gettimepassed();
    var_fca3efa4 = int(min(var_de5f82e0, timepassed));
    game.propsurvivaltime[game.defenders] = game.propsurvivaltime[game.defenders] + var_fca3efa4;
    game.hunterkilltime[game.attackers] = game.hunterkilltime[game.attackers] + var_fca3efa4;
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0xa0e1856f, Offset: 0x5f88
// Size: 0x19c
function choosefinalkillcam() {
    var_fdf4a4ec = getlivingplayersonteam(game.defenders);
    if (var_fdf4a4ec.size < 1) {
        return;
    }
    var_94ffcd5f = getlivingplayersonteam(game.attackers);
    if (var_94ffcd5f.size < 1) {
        return;
    }
    var_81790aa5 = choosebestpropforkillcam(var_fdf4a4ec, var_94ffcd5f);
    if (isplayer(var_81790aa5)) {
        attackernum = var_81790aa5 getentitynumber();
    } else {
        attackernum = -1;
    }
    victim = var_94ffcd5f[0];
    victim.deathtime = gettime() - 1000;
    weap = getweapon("none");
    killcam_entity_info = killcam::get_killcam_entity_info(var_81790aa5, var_81790aa5, weap);
    level thread killcam::record_settings(attackernum, victim getentitynumber(), weap, "MOD_UNKNOWN", victim.deathtime, 0, 0, killcam_entity_info, [], [], var_81790aa5);
}

// Namespace prop/prop
// Params 2, eflags: 0x0
// Checksum 0x9e6b72ce, Offset: 0x6130
// Size: 0x1fa
function choosebestpropforkillcam(var_fdf4a4ec, var_94ffcd5f) {
    var_b3b19664 = undefined;
    var_fd00913d = 1073741824;
    foreach (prop in var_fdf4a4ec) {
        assert(isalive(prop));
        var_7e7ea558 = undefined;
        var_d939e4ca = 1073741824;
        foreach (hunter in var_94ffcd5f) {
            pathdist = pathdistance(prop.origin, hunter.origin);
            if (!isdefined(pathdist)) {
                pathdist = distance(prop.origin, hunter.origin);
            }
            if (pathdist < var_d939e4ca) {
                var_d939e4ca = pathdist;
                var_7e7ea558 = hunter;
            }
        }
        if (var_d939e4ca < var_fd00913d) {
            var_fd00913d = var_d939e4ca;
            var_b3b19664 = prop;
        }
    }
    if (!isdefined(var_b3b19664)) {
        var_b3b19664 = array::random(var_fdf4a4ec);
    }
    return var_b3b19664;
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0x66c14a31, Offset: 0x6338
// Size: 0x5c
function function_cd929fef(setclientfield) {
    self show();
    self notify(#"showplayer");
    if (setclientfield) {
        self clientfield::set("hideTeamPlayer", 0);
    }
}

// Namespace prop/prop
// Params 2, eflags: 0x0
// Checksum 0xcb8c292, Offset: 0x63a0
// Size: 0xdc
function function_945f1c41(team, setclientfield) {
    self hide();
    if (setclientfield) {
        self thread function_c2dcc15d(team);
    }
    foreach (player in level.players) {
        self thread function_cb3d2d31(player, team);
    }
    self thread function_a8e0199(team);
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0x4c61e21, Offset: 0x6488
// Size: 0x94
function function_c2dcc15d(team) {
    level endon(#"game_ended");
    self endon(#"disconnect");
    self endon(#"showplayer");
    waitframe(1);
    teamint = 1;
    if (team == "axis") {
        teamint = 2;
    }
    self clientfield::set("hideTeamPlayer", teamint);
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0x39e9dd1d, Offset: 0x6528
// Size: 0xa8
function function_a8e0199(team) {
    level endon(#"game_ended");
    self endon(#"disconnect");
    self endon(#"showplayer");
    while (true) {
        res = level waittill(#"connected");
        player = res.player;
        self thread function_cb3d2d31(player, team);
    }
}

// Namespace prop/prop
// Params 2, eflags: 0x0
// Checksum 0x98e33737, Offset: 0x65d8
// Size: 0x130
function function_cb3d2d31(player, team) {
    level endon(#"game_ended");
    self endon(#"disconnect");
    self endon(#"showplayer");
    player endon(#"disconnect");
    if (self util::isprop()) {
        self ghost();
    }
    while (true) {
        if (isdefined(player.hasspawned) && player.hasspawned && player.team != team) {
            self showtoplayer(player);
            if (self util::isprop()) {
                self ghost();
            }
        }
        player waittill(#"spawned");
    }
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x16b40e48, Offset: 0x6710
// Size: 0x144
function function_346bdc3b() {
    self.thirdpersonrange = undefined;
    self setclientthirdperson(0);
    self allowprone(1);
    self allowsprint(1);
    self setmovespeedscale(1);
    self playerknockback(1);
    self show();
    self setclientuivisibilityflag("weapon_hud_visible", 1);
    if (function_503c9413()) {
        self function_543b1a75(0);
    }
    self thread prop_controls::function_b6740059();
    self thread prop_controls::function_1abcc66();
    self.concussionimmune = 1;
    self.healthregendisabled = 0;
    self thread attackerregenammo();
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x9748618c, Offset: 0x6860
// Size: 0x262
function stillalivexp() {
    level endon(#"game_ended");
    level.var_3c96f157[#"kill"][#"value"] = 300;
    level waittill(#"props_hide_over");
    while (true) {
        hostmigration::waitlongdurationwithhostmigrationpause(10);
        /#
            if (getgametypesetting("<dev string:x6f>") == 0) {
                continue;
            }
        #/
        foreach (player in level.players) {
            if (!isdefined(player.team)) {
                continue;
            }
            if (player.team == game.attackers) {
                continue;
            }
            if (!isalive(player)) {
                continue;
            }
            if (!isdefined(player.prop)) {
                continue;
            }
            scoreevents::processscoreevent("still_alive", player);
            switch (player.prop.info.propsize) {
            case 200:
                scoreevents::processscoreevent("still_alive_medium_bonus", player);
                break;
            case 300:
                scoreevents::processscoreevent("still_alive_large_bonus", player);
                break;
            case 400:
                scoreevents::processscoreevent("still_alive_extra_large_bonus", player);
                break;
            default:
                break;
            }
        }
    }
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0xc0474f48, Offset: 0x6ad0
// Size: 0x148
function tracktimealive() {
    level endon(#"game_ended");
    function_45c842e9();
    while (true) {
        foreach (player in level.players) {
            if (!isdefined(player.team)) {
                continue;
            }
            if (player.team == game.attackers) {
                continue;
            }
            if (!isalive(player)) {
                continue;
            }
            player.pers[#"objtime"]++;
            player.objtime = player.pers[#"objtime"];
        }
        hostmigration::waitlongdurationwithhostmigrationpause(1);
    }
}

// Namespace prop/prop
// Params 11, eflags: 0x0
// Checksum 0xcd90228f, Offset: 0x6c20
// Size: 0xc2
function gamemodemodifyplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, boneindex) {
    victim = self;
    if (isdefined(eattacker) && isplayer(eattacker) && isalive(eattacker)) {
        if (!isdefined(eattacker.hashitplayer)) {
            eattacker.hashitplayer = 1;
        }
    }
    return idamage;
}

// Namespace prop/prop
// Params 6, eflags: 0x0
// Checksum 0x2f96f09f, Offset: 0x6cf0
// Size: 0xbe
function function_dc6b46ed(idflags, shitloc, weapon, friendlyfire, attackerishittingself, smeansofdeath) {
    if (isdefined(smeansofdeath) && smeansofdeath == "MOD_FALLING") {
        return true;
    }
    if (self function_e4b2f23()) {
        if (weapon.name == "concussion_grenade") {
            return true;
        }
        if (issubstr(weapon.name, "destructible")) {
            return true;
        }
    }
    return false;
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x19e13633, Offset: 0x6db8
// Size: 0x156
function attackerswaittime() {
    level endon(#"game_ended");
    self endon(#"disconnect");
    function_45c842e9();
    if (self.team == game.defenders) {
        self notify(#"cancelcountdown");
        return;
    }
    while (!isdefined(level.starttime)) {
        waitframe(1);
    }
    while (isdefined(self.controlsfrozen) && self.controlsfrozen) {
        waitframe(1);
    }
    var_e47d50e6 = function_d9c4b3d0();
    remainingtime = level.phsettings.prophidetime - var_e47d50e6;
    result = 0;
    if (remainingtime > 0) {
        if (!function_503c9413()) {
            result = function_b00e098a(var_e47d50e6, remainingtime);
            return;
        }
        result = function_b1b25534(var_e47d50e6, remainingtime);
    }
}

// Namespace prop/prop
// Params 2, eflags: 0x0
// Checksum 0x95820861, Offset: 0x6f18
// Size: 0x100
function function_b00e098a(var_e47d50e6, remainingtime) {
    self freezecontrols(1);
    if (int(var_e47d50e6) > 0) {
        fadeintime = 0;
    } else {
        fadeintime = 1;
    }
    fadeouttime = 1;
    if (fadeintime + fadeouttime > remainingtime) {
        fadeintime = 0;
        fadeouttime = 0;
    }
    self thread prop_controls::function_7244ebc6(remainingtime, fadeintime, fadeouttime);
    result = self function_da184fd(remainingtime);
    self freezecontrols(0);
    return result;
}

// Namespace prop/prop
// Params 2, eflags: 0x0
// Checksum 0xdd439ea7, Offset: 0x7020
// Size: 0x1c8
function function_b1b25534(var_e47d50e6, remainingtime) {
    var_27a8ec66 = 3;
    var_1006f499 = 1;
    fadeintime = 0;
    result = 0;
    var_b73ba41a = remainingtime - var_27a8ec66;
    self thread propwaitminigameinit(var_b73ba41a + var_1006f499);
    waittillframeend();
    self.var_11d543b4 = undefined;
    self.var_f806489a = undefined;
    if (remainingtime > 8) {
        self.var_11d543b4 = self.origin;
        self.var_f806489a = self.angles;
        result = self function_da184fd(var_b73ba41a);
        fadeintime = 1;
    }
    var_e47d50e6 = function_d9c4b3d0();
    remainingtime = level.phsettings.prophidetime - var_e47d50e6;
    if (remainingtime > 0) {
        self freezecontrols(1);
        fadeouttime = 1;
        if (fadeintime + fadeouttime > remainingtime) {
            fadeintime = 0;
            fadeouttime = 0;
        }
        self thread prop_controls::function_7244ebc6(remainingtime, fadeintime, fadeouttime);
        result = self function_da184fd(remainingtime);
        self freezecontrols(0);
    }
    return result;
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x76b5f022, Offset: 0x71f0
// Size: 0x24
function function_d9c4b3d0() {
    return (gettime() - level.starttime - level.var_f2aa1432) / 1000;
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x96d0bd21, Offset: 0x7220
// Size: 0x8e
function function_1edf732a() {
    level.var_f2aa1432 = 0;
    while (true) {
        level waittill(#"host_migration_begin");
        starttime = gettime();
        level waittill(#"host_migration_end");
        passedtime = gettime() - starttime;
        level.var_f2aa1432 += passedtime;
    }
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0xb8f766d5, Offset: 0x72b8
// Size: 0x68
function function_da184fd(remainingtime) {
    result = function_5eebce92(remainingtime);
    /#
        while (getdvarint(#"hash_2a5089002fa897cc", 0) != 0) {
            waitframe(1);
        }
    #/
    return result;
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0x53bf0a9d, Offset: 0x7328
// Size: 0x38
function function_5eebce92(remainingtime) {
    self endon(#"cancelcountdown");
    hostmigration::waitlongdurationwithhostmigrationpause(remainingtime);
    return true;
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0x37662b65, Offset: 0x7368
// Size: 0x64
function freeze_player_controls(b_frozen = 1) {
    if (isdefined(level.hostmigrationtimer)) {
        b_frozen = 1;
    }
    if (b_frozen || !level.gameended) {
        self freezecontrols(b_frozen);
    }
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x988dafea, Offset: 0x73d8
// Size: 0x18c
function function_e999d() {
    if (self.pers[#"team"] == game.attackers) {
        self freeze_player_controls(1);
    } else {
        self thread function_320928f9();
    }
    team = self.pers[#"team"];
    if (isdefined(self.pers[#"music"].spawn) && self.pers[#"music"].spawn == 0) {
        if (level.wagermatch) {
            music = "SPAWN_WAGER";
        } else {
            music = game.music["spawn_" + team];
        }
        if (game.roundsplayed == 0) {
        }
        self.pers[#"music"].spawn = 1;
    }
    if (level.splitscreen) {
        if (isdefined(level.playedstartingmusic)) {
            music = undefined;
        } else {
            level.playedstartingmusic = 1;
        }
    }
    self thread globallogic_spawn::doinitialspawnmessaging();
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x59a5687f, Offset: 0x7570
// Size: 0x5c
function function_320928f9() {
    self endon(#"disconnect");
    self freezecontrolsallowlook(1);
    function_45c842e9();
    self freezecontrolsallowlook(0);
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x85513529, Offset: 0x75d8
// Size: 0x19c
function attackerinitammo() {
    primaryweapons = self getweaponslistprimaries();
    foreach (weapon in primaryweapons) {
        self givemaxammo(weapon);
        self setweaponammoclip(weapon, 999);
    }
    if (!function_503c9413()) {
        if (!isdefined(self.thrownspecialcount)) {
            self.thrownspecialcount = 0;
        }
        weapon = getweapon("concussion_grenade");
        var_10f7466f = self getweaponammostock(weapon);
        var_10f7466f -= self.thrownspecialcount;
        var_10f7466f = int(max(var_10f7466f, 0));
        self setweaponammostock(weapon, var_10f7466f);
        if (var_10f7466f > 0) {
            self thread prop_controls::watchspecialgrenadethrow();
        }
    }
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x926d904a, Offset: 0x7780
// Size: 0xb8
function attackerregenammo() {
    self endon(#"death");
    self endon(#"disconnect");
    self notify(#"attackerregenammo");
    self endon(#"attackerregenammo");
    level endon(#"game_ended");
    while (true) {
        self waittill(#"reload");
        primaryweapon = self getcurrentweapon();
        self givemaxammo(primaryweapon);
    }
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x572f878e, Offset: 0x7840
// Size: 0xc2
function checkkillrespawn() {
    self endon(#"disconnect");
    level endon(#"game_ended");
    hostmigration::waitlongdurationwithhostmigrationpause(0.1);
    if (self.pers[#"lives"] == 1) {
        self.pers[#"lives"]--;
        level.livescount[self.team]--;
        globallogic::updategameevents();
        level notify(#"propcountchanged");
        return;
    }
}

// Namespace prop/prop
// Params 3, eflags: 0x0
// Checksum 0x21c7b8b3, Offset: 0x7910
// Size: 0x45e
function function_7d4f8220(attacker, smeansofdeath, weapon) {
    bestplayer = undefined;
    bestplayermeansofdeath = undefined;
    bestplayerweapon = undefined;
    if (!level flag::get("props_hide_over")) {
        return;
    }
    if (!isdefined(attacker) || attacker.classname == "trigger_hurt" || attacker.classname == "worldspawn" || isdefined(attacker.ismagicbullet) && attacker.ismagicbullet == 1 || attacker == self) {
        for (i = 0; i < self.attackers.size; i++) {
            player = self.attackers[i];
            if (!isdefined(player)) {
                continue;
            }
            if (!isdefined(self.attackerdamage[player.clientid]) || !isdefined(self.attackerdamage[player.clientid].damage)) {
                continue;
            }
            if (player == self || level.teambased && player.team == self.team) {
                continue;
            }
            if (self.attackerdamage[player.clientid].damage > 1 && !isdefined(bestplayer)) {
                bestplayer = player;
                bestplayermeansofdeath = self.attackerdamage[player.clientid].meansofdeath;
                bestplayerweapon = self.attackerdamage[player.clientid].weapon;
                continue;
            }
            if (isdefined(bestplayer) && self.attackerdamage[player.clientid].lasttimedamaged > self.attackerdamage[bestplayer.clientid].lasttimedamaged) {
                bestplayer = player;
                bestplayermeansofdeath = self.attackerdamage[player.clientid].meansofdeath;
                bestplayerweapon = self.attackerdamage[player.clientid].weapon;
            }
        }
        if (!isdefined(bestplayer) && self util::isprop()) {
            bestdistsq = undefined;
            foreach (player in level.players) {
                if (isalive(player) && player.team != self.team) {
                    distsq = distancesquared(player.origin, self.origin);
                    if (!isdefined(bestdistsq) || distsq < bestdistsq) {
                        bestplayer = player;
                        bestdistsq = distsq;
                    }
                }
            }
            if (isdefined(bestplayer)) {
                bestplayermeansofdeath = "MOD_MELEE";
                bestplayerweapon = getweapon("none");
            }
        }
    }
    result = undefined;
    if (isdefined(bestplayer)) {
        result = [];
        result[#"bestplayer"] = bestplayer;
        result[#"bestplayerweapon"] = bestplayerweapon;
        result[#"bestmeansofdeath"] = bestplayermeansofdeath;
    }
    return result;
}

// Namespace prop/prop
// Params 10, eflags: 0x0
// Checksum 0x9b486c7, Offset: 0x7d78
// Size: 0x3be
function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime, deathanimduration, lifeid) {
    victim = self;
    killedbyenemy = 0;
    level notify(#"playercountchanged");
    if (victim.team == game.attackers) {
        self thread respawnplayer();
    } else if (!level flag::get("props_hide_over")) {
        self thread respawnplayer();
        return;
    }
    if (isdefined(attacker) && isplayer(attacker) && attacker != victim && victim.team != attacker.team) {
        killedbyenemy = 1;
    }
    if (killedbyenemy) {
        scoreevents::processscoreevent("prop_finalblow", attacker, victim);
        foreach (assailant in victim.attackers) {
            if (assailant == attacker) {
                assailant playhitmarker("mpl_hit_alert");
                continue;
            }
            assailant playhitmarker("mpl_hit_alert_escort");
        }
    }
    foreach (player in level.players) {
        if (player != attacker && player util::isprop() && isalive(player) && victim util::isprop()) {
            scoreevents::processscoreevent("prop_survived", player);
            continue;
        }
        if (player != attacker && player function_e4b2f23() && victim.team == game.defenders) {
            scoreevents::processscoreevent("prop_killed", player, victim);
        }
    }
    if (victim util::isprop()) {
        attackerteam = util::getotherteam(victim.team);
        game.propscore[attackerteam] = game.propscore[attackerteam] + 1;
    }
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x24368ce4, Offset: 0x8140
// Size: 0x1c
function respawnplayer() {
    self thread waittillcanspawnclient();
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x62c8387d, Offset: 0x8168
// Size: 0xc6
function waittillcanspawnclient() {
    self endon(#"started_spawnplayer");
    self endon(#"disconnect");
    level endon(#"game_ended");
    for (;;) {
        wait 0.05;
        if (isdefined(self) && isdefined(self.curclass) && (self.sessionstate == "spectator" || !isalive(self))) {
            self.pers[#"lives"] = 1;
            self globallogic_spawn::spawnclient();
            continue;
        }
        return;
    }
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0x6dc81de1, Offset: 0x8238
// Size: 0x64
function ondeadevent(team) {
    if (team == game.defenders) {
        /#
            if (isdefined(level.allow_teamchange) && level.allow_teamchange == "<dev string:x79>") {
                return;
            }
        #/
        level thread propkilledend();
    }
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x8f9c5d33, Offset: 0x82a8
// Size: 0xb4
function propkilledend() {
    if (isdefined(level.hunterswonending) && level.hunterswonending) {
        return;
    }
    if (isdefined(level.gameending) && level.gameending) {
        return;
    }
    level.hunterswonending = 1;
    function_f666ecbf();
    level.gameending = 1;
    hostmigration::waitlongdurationwithhostmigrationpause(3);
    thread ph_endgame(game.attackers, 6);
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0xfe6d01f2, Offset: 0x8368
// Size: 0x34
function function_470f21c5(smeansofdeath) {
    if (self.team == game.attackers) {
        self battlechatter::pain_vox(smeansofdeath);
    }
}

// Namespace prop/prop
// Params 4, eflags: 0x0
// Checksum 0x68042f9b, Offset: 0x83a8
// Size: 0x64
function playdeathsoundph(body, attacker, weapon, smeansofdeath) {
    if (self.team == game.attackers && isdefined(body)) {
        self battlechatter::play_death_vox(body, attacker, weapon, smeansofdeath);
    }
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0x7ecc4bd2, Offset: 0x8418
// Size: 0x32
function round(value) {
    value = int(value + 0.5);
    return value;
}

// Namespace prop/prop
// Params 8, eflags: 0x0
// Checksum 0xec80f6e6, Offset: 0x8458
// Size: 0x42c
function function_c17c938d(winner, endtype, endreasontext, outcometext, team, winnerenum, notifyroundendtoui, matchbonus) {
    if (endtype == "gameend" && isdefined(level.proptiebreaker)) {
        if (!isdefined(team) || team == "spectator") {
            if (isdefined(self.team) && self.team != "spectator" && isdefined(game.stat[#"propscore"][self.team])) {
                team = self.team;
            } else if (isdefined(self.sessionteam) && self.sessionteam != "spectator" && isdefined(game.stat[#"propscore"][self.sessionteam])) {
                team = self.sessionteam;
            }
            if (!isdefined(team)) {
                return true;
            }
        }
        otherteam = util::getotherteam(team);
        if (level.proptiebreaker == "kills") {
            winnerscore = game.stat[#"propscore"][team];
            loserscore = game.stat[#"propscore"][otherteam];
            if (winnerscore < loserscore) {
                winnerscore = game.stat[#"propscore"][otherteam];
                loserscore = game.stat[#"propscore"][team];
            }
            var_be546bcd = (winnerscore << 8) + loserscore;
            self luinotifyevent(#"show_outcome", 6, outcometext, #"mp_ph_tiebreaker_kill", int(matchbonus), winnerenum, notifyroundendtoui, var_be546bcd);
            return true;
        } else if (level.proptiebreaker == "time") {
            var_f3258fd1 = game.stat[#"hunterkilltime"][team] / 1000;
            otherteam = util::getotherteam(team);
            var_61cf9ec5 = game.stat[#"hunterkilltime"][otherteam] / 1000;
            var_101aa528 = round(var_f3258fd1);
            var_b71f48d4 = round(var_61cf9ec5);
            if (var_101aa528 == var_b71f48d4) {
                if (var_f3258fd1 > var_61cf9ec5) {
                    var_101aa528++;
                } else {
                    var_b71f48d4++;
                }
            }
            var_cd0a6db3 = var_101aa528;
            var_7bdb281b = var_b71f48d4;
            if (var_cd0a6db3 < var_7bdb281b) {
                var_cd0a6db3 = var_b71f48d4;
                var_7bdb281b = var_101aa528;
            }
            self luinotifyevent(#"show_outcome", 7, outcometext, #"mp_ph_tiebreaker_time", int(matchbonus), winnerenum, notifyroundendtoui, var_cd0a6db3, var_7bdb281b);
            return true;
        }
    }
    return false;
}

// Namespace prop/prop
// Params 2, eflags: 0x0
// Checksum 0xd92a6986, Offset: 0x8890
// Size: 0x2a
function function_e0d16266(spawnpoint, predictedspawn) {
    if (!predictedspawn) {
        self.startspawn = spawnpoint;
    }
}

// Namespace prop/prop
// Params 2, eflags: 0x0
// Checksum 0x117be58e, Offset: 0x88c8
// Size: 0xf2
function function_6f13f156(spawnpoint, predictedspawn) {
    foreach (player in level.players) {
        if (isdefined(player.pers[#"team"]) && player.pers[#"team"] != "spectator") {
            if (isdefined(player.startspawn) && player.startspawn == spawnpoint) {
                return false;
            }
        }
    }
    return true;
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0xa875be6c, Offset: 0x89c8
// Size: 0x6a
function gamehasstarted() {
    if (level.teambased) {
        return globallogic_spawn::allteamshaveexisted();
    }
    return level.maxplayercount > 1 || !util::isoneround() && !util::isfirstround();
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0xa63c4d26, Offset: 0x8a40
// Size: 0x16e
function function_4fb47492() {
    /#
        if (level.var_2898ef72) {
            return true;
        }
    #/
    if (level.inovertime) {
        return false;
    }
    if (level.playerqueuedrespawn && !isdefined(self.allowqueuespawn) && !level.ingraceperiod && !level.usestartspawns) {
        return false;
    }
    if (level.numlives || level.numteamlives) {
        gamehasstarted = gamehasstarted();
        if (gamehasstarted && level.numlives && !self.pers[#"lives"] || level.numteamlives && !game.stat[self.team + "_lives"]) {
            return false;
        } else if (gamehasstarted) {
            if (!level.ingraceperiod && !self.hasspawned && !level.wagermatch) {
                return false;
            }
        }
        if (self disablespawningforplayer()) {
            return false;
        }
    }
    return true;
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x8ac2548c, Offset: 0x8bb8
// Size: 0x5c
function disablespawningforplayer() {
    if (!gamehasstarted()) {
        return false;
    }
    if (self function_e4b2f23()) {
        return false;
    } else if (self util::isprop()) {
        return !level.ingraceperiod;
    }
    return false;
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x6525a1f, Offset: 0x8c20
// Size: 0x22
function function_e4b2f23() {
    return isdefined(self.team) && self.team == game.attackers;
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x34678884, Offset: 0x8c50
// Size: 0xa0
function function_4bdf92a7() {
    turrets = getentarray("misc_turret", "classname");
    foreach (turret in turrets) {
        turret delete();
    }
}

// Namespace prop/prop
// Params 6, eflags: 0x0
// Checksum 0x2c9855f, Offset: 0x8cf8
// Size: 0x94
function function_9bb11de9(eattacker, einflictor, weapon, smeansofdeath, idamage, vpoint) {
    self thread function_b37cf698(eattacker, einflictor, weapon, smeansofdeath, idamage, vpoint);
    if (!self util::isusingremote()) {
        self playrumbleonentity("damage_heavy");
    }
}

// Namespace prop/prop
// Params 6, eflags: 0x0
// Checksum 0x95d15e83, Offset: 0x8d98
// Size: 0x342
function function_b37cf698(eattacker, einflictor, weapon, meansofdeath, damage, point) {
    self endon(#"death");
    self endon(#"disconnect");
    if (isdefined(level._custom_weapon_damage_func)) {
        is_weapon_registered = self [[ level._custom_weapon_damage_func ]](eattacker, einflictor, weapon, meansofdeath, damage);
        if (is_weapon_registered) {
            return;
        }
    }
    switch (weapon.rootweapon.name) {
    case #"concussion_grenade":
        if (isdefined(self.concussionimmune) && self.concussionimmune) {
            return;
        }
        radius = weapon.explosionradius;
        if (self == eattacker) {
            radius *= 0.5;
        }
        damageorigin = einflictor.origin;
        if (isdefined(point)) {
            damageorigin = point;
        }
        if (self prop_controls::function_94e1618c(damageorigin)) {
            return;
        }
        scale = 1 - distance(self.origin, damageorigin) / radius;
        if (scale < 0) {
            scale = 0;
        }
        time = 0.25 + 4 * scale;
        waitframe(1);
        if (meansofdeath != "MOD_IMPACT") {
            if (self hasperk("specialty_stunprotection")) {
                time *= 0.1;
            } else if (self util::mayapplyscreeneffect()) {
                self shellshock("concussion_grenade_mp", time, 0);
            }
            self thread weapons::play_concussion_sound(time);
            self.concussionendtime = gettime() + time * 1000;
            self.lastconcussedby = eattacker;
            if (self util::isprop()) {
                if (isdefined(self.lock) && self.lock) {
                    self prop_controls::unlockprop();
                }
                self prop_controls::function_770b4cfa(einflictor, self, meansofdeath, damage, damageorigin, weapon);
            }
        }
        break;
    default:
        if (isdefined(level.shellshockonplayerdamage)) {
            [[ level.shellshockonplayerdamage ]](meansofdeath, damage, weapon);
        }
        break;
    }
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x47801503, Offset: 0x90e8
// Size: 0x138
function function_7010fe7f() {
    level endon(#"game_ended");
    waitframe(1);
    while (!isdefined(level.mannequins)) {
        waitframe(1);
    }
    foreach (mannequin in level.mannequins) {
        mannequin notsolid();
    }
    level waittill(#"props_hide_over");
    foreach (mannequin in level.mannequins) {
        mannequin solid();
    }
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0x1236e1df, Offset: 0x9228
// Size: 0x10c
function propwaitminigameinit(time) {
    if (!isdefined(level.var_e5ad813f)) {
        level.var_e5ad813f = spawnstruct();
    }
    if (!(isdefined(level.var_e5ad813f.started) && level.var_e5ad813f.started)) {
        level.var_e5ad813f.started = 1;
        self thread function_b408af2c(time);
    }
    self.var_efe75c2f = 0;
    self.var_61add00c = 0;
    if (level.var_e5ad813f.var_d504a1f4 && self function_e4b2f23() && time > 8) {
        waittillframeend();
        if (level.var_abcf2d12.size < 0) {
            self function_83efbfcf();
        }
    }
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0x22c6e2f7, Offset: 0x9340
// Size: 0x3d0
function function_b408af2c(time) {
    if (time <= 0) {
        level.var_e5ad813f.active = 0;
        return;
    }
    thread function_c91df86f();
    function_da184fd(time);
    level notify(#"hash_6b6c8ba66c97153a");
    level.var_e5ad813f.active = 0;
    foreach (player in level.players) {
        if (isdefined(player.pers[#"team"]) && player.pers[#"team"] == game.defenders) {
            player function_2472fc6();
            continue;
        }
        if (isdefined(player.pers[#"team"]) && player.pers[#"team"] == game.attackers) {
            player function_7d5b1fa6();
        }
    }
    /#
    #/
    thread propminigameupdateshowwinner(level.var_e5ad813f.var_239c724[0], -80, 2);
    thread propminigameupdateshowwinner(level.var_e5ad813f.var_239c724[1], -50, 1.75);
    thread propminigameupdateshowwinner(level.var_e5ad813f.var_239c724[2], -20, 1.5);
    if (isdefined(level.var_e5ad813f.targets)) {
        foreach (target in level.var_e5ad813f.targets) {
            if (isdefined(target)) {
                target delete();
            }
        }
    }
    if (isdefined(level.var_abcf2d12)) {
        foreach (clone in level.var_abcf2d12) {
            if (isdefined(clone)) {
                if (isdefined(clone.var_9352d14f)) {
                    clone.var_9352d14f delete();
                }
                if (isdefined(clone.var_6f5f0e80)) {
                    gameobjects::release_obj_id(clone.var_6f5f0e80);
                }
                clone delete();
            }
        }
    }
}

// Namespace prop/prop
// Params 3, eflags: 0x0
// Checksum 0xb9588983, Offset: 0x9718
// Size: 0xa0
function propminigameupdateshowwinner(hud, winyoffset, winfontscale) {
    hud endon(#"death");
    movetime = 0.5;
    showtime = 2.5;
    fadetime = 0.5;
    hud.fontscale = winfontscale;
    wait movetime + showtime;
    hud.alpha = 0;
    /#
        wait fadetime;
    #/
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0xcff9be26, Offset: 0x97c0
// Size: 0x8c
function function_7d5b1fa6() {
    self function_543b1a75(1);
    self takeweapon(getweapon("null_offhand_primary"));
    self function_c32f3fcc(getweapon("concussion_grenade"), 2);
    self attackerinitammo();
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x8efb3a18, Offset: 0x9858
// Size: 0x1c
function function_2472fc6() {
    self function_f2704a3c(1);
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x13aa3483, Offset: 0x9880
// Size: 0x82
function function_503c9413() {
    if (!isdefined(level.var_e5ad813f)) {
        level.var_e5ad813f = spawnstruct();
    }
    if (!isdefined(level.var_e5ad813f.active)) {
        level.var_e5ad813f.active = getdvarint(#"scr_prop_minigame", 0);
    }
    return level.var_e5ad813f.active;
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0x81693638, Offset: 0x9910
// Size: 0xec
function function_543b1a75(isvisible) {
    if (isvisible) {
        self solid();
        self function_cd929fef(1);
        if (isdefined(self.var_11d543b4)) {
            self setorigin(self.var_11d543b4);
            self setplayerangles(self.var_f806489a);
        }
        if (isdefined(self.var_c83b06b4)) {
            self.var_c83b06b4 delete();
        }
        return;
    }
    self notsolid();
    self thread function_945f1c41(game.defenders, 1);
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0x79a58cf1, Offset: 0x9a08
// Size: 0x164
function function_471ff19e(player) {
    player endon(#"disconnect");
    level endon(#"game_ended");
    if (!isdefined(player.var_c83b06b4)) {
        function_45c842e9();
        wait 0.1;
        clone = util::spawn_player_clone(player, "pb_stand_alert");
        weapon = player getcurrentweapon();
        if (isdefined(weapon.worldmodel)) {
            clone attach(weapon.worldmodel, "tag_weapon_right");
        }
        clone notsolid();
        clone hidefromteam(player.pers[#"team"]);
        player.var_c83b06b4 = clone;
        player thread function_84edfab0(player, player.var_c83b06b4);
    }
}

// Namespace prop/prop
// Params 2, eflags: 0x0
// Checksum 0x6a69b0c0, Offset: 0x9b78
// Size: 0x7c
function function_84edfab0(player, clone) {
    clone endon(#"entityshutdown");
    clone endon(#"death");
    player waittill(#"disconnect");
    if (isdefined(clone)) {
        clone delete();
    }
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0x27bf24f4, Offset: 0x9c00
// Size: 0x18c
function function_f2704a3c(isvisible) {
    if (isvisible) {
        if (isdefined(self.prop)) {
            self.prop show();
            self.prop solid();
        }
        self function_cd929fef(0);
        self ghost();
        if (isdefined(self.propclones)) {
            foreach (clone in self.propclones) {
                clone show();
                clone solid();
            }
        }
        return;
    }
    if (isdefined(self.prop)) {
        self.prop notsolid();
        self.prop hidefromteam(game.attackers);
    }
    self thread function_945f1c41(game.attackers, 0);
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x24191d0a, Offset: 0x9d98
// Size: 0x2d0
function function_c91df86f() {
    level.var_e5ad813f.var_d504a1f4 = 0;
    label = #"mp_ph_pregame_hunt";
    if (randomfloat(1) < 0.5) {
        level.var_e5ad813f.var_d504a1f4 = 1;
        label = #"mp_ph_pregame_chase";
    }
    /#
        if (getdvarint(#"hash_6132db0becb8f98", 0) == 2 && level.var_e5ad813f.var_d504a1f4) {
            level.var_e5ad813f.var_d504a1f4 = 0;
            label = #"mp_ph_pregame_hunt";
        } else if (getdvarint(#"hash_6132db0becb8f98", 0) == 1 && !level.var_e5ad813f.var_d504a1f4) {
            level.var_e5ad813f.var_d504a1f4 = 1;
            label = #"mp_ph_pregame_chase";
        }
    #/
    thread function_9b0f77c4(label);
    level.var_e5ad813f.targetlocations = function_1450fc18();
    level.var_e5ad813f.targetlocations = array::randomize(level.var_e5ad813f.targetlocations);
    level.var_e5ad813f.nextindex = 0;
    if (!level.var_e5ad813f.var_d504a1f4) {
        thread function_f26960c8();
    } else {
        level.var_abcf2d12 = [];
    }
    foreach (player in level.players) {
        if (isdefined(player.pers[#"team"]) && player.pers[#"team"] == game.attackers) {
            player thread function_89acdf0d(#"mp_ph_empty");
        }
    }
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0xa4da5dcd, Offset: 0xa070
// Size: 0x134
function function_1450fc18() {
    var_f5af7250 = 90000;
    targetlocations = [];
    alllocations = spawning::get_spawnpoint_array("mp_tdm_spawn");
    hunters = getlivingplayersonteam(game.attackers);
    hunter = hunters[0];
    foreach (location in alllocations) {
        distsq = distancesquared(location.origin, hunter.origin);
        if (distsq > var_f5af7250) {
            targetlocations[targetlocations.size] = location;
        }
    }
    return targetlocations;
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0xe73f1c2b, Offset: 0xa1b0
// Size: 0xa
function function_5f1e8e1b() {
    return "wpn_t7_uplink_ball_world";
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x84563680, Offset: 0xa1c8
// Size: 0x13c
function function_f26960c8() {
    var_8eb640f2 = 40;
    var_8ba71423 = 4;
    model = function_5f1e8e1b();
    numtargets = min(level.var_e5ad813f.targetlocations.size, var_8eb640f2);
    level.var_e5ad813f.targets = [];
    num = 0;
    for (i = 0; i < numtargets; i++) {
        origin = function_8e704405();
        target = function_98636e21(origin, model);
        level.var_e5ad813f.targets[level.var_e5ad813f.targets.size] = target;
        num++;
        if (num >= var_8ba71423) {
            waitframe(1);
            num = 0;
        }
    }
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0x2528ed76, Offset: 0xa310
// Size: 0x3c
function function_7d3dbc54(targetent) {
    waitframe(1);
    if (isdefined(targetent)) {
        playfxontag("ui/fx_uplink_ball_vanish", targetent, "tag_origin");
    }
}

// Namespace prop/prop
// Params 2, eflags: 0x0
// Checksum 0x7b542b74, Offset: 0xa358
// Size: 0x178
function function_98636e21(origin, model) {
    target = spawn("script_model", origin);
    target setmodel(model);
    target.targetname = "propTarget";
    target setcandamage(1);
    target.fakehealth = 50;
    target.health = 99999;
    target.maxhealth = 99999;
    target thread function_500dc7d9(&function_8d5e52a2);
    target setplayercollision(0);
    target makesentient();
    target setteam(game.defenders);
    target hidefromteam(game.defenders);
    target setscale(2);
    thread function_7d3dbc54(target);
    return target;
}

// Namespace prop/prop
// Params 10, eflags: 0x0
// Checksum 0xf3ef2fc7, Offset: 0xa4d8
// Size: 0x11a
function function_8d5e52a2(damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, weapon, idflags) {
    if (!isdefined(attacker)) {
        return;
    }
    if (isplayer(attacker)) {
        if (isdefined(self.isdying) && self.isdying) {
            return;
        }
        attacker thread damagefeedback::update();
        self.lastattacker = attacker;
        self.fakehealth -= damage;
        if (self.fakehealth <= 0) {
            function_a88142c8(attacker);
            self thread movetarget();
        }
    }
    self.health += damage;
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x80656295, Offset: 0xa600
// Size: 0x16e
function movetarget() {
    self.isdying = 1;
    waitframe(1);
    self.fakehealth = 50;
    fxent = playfx(fx::get("propDeathFX"), self.origin + (0, 0, 4));
    fxent hide();
    foreach (player in level.players) {
        if (player function_e4b2f23()) {
            fxent showtoplayer(player);
        }
    }
    fxent playsoundtoteam("wpn_flash_grenade_explode", game.attackers);
    self.origin = function_8e704405();
    self dontinterpolate();
    self.isdying = 0;
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0x4fbcc05f, Offset: 0xa778
// Size: 0xc6
function function_5e31e74e(location) {
    var_cc2c9630 = 90000;
    foreach (target in level.var_e5ad813f.targets) {
        distsq = distancesquared(target.origin, location);
        if (distsq < var_cc2c9630) {
            return true;
        }
    }
    return false;
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0xc77dfe09, Offset: 0xa848
// Size: 0x264
function function_8e704405() {
    if (level.var_e5ad813f.nextindex >= level.var_e5ad813f.targetlocations.size) {
        level.var_e5ad813f.nextindex = 0;
    }
    location = level.var_e5ad813f.targetlocations[level.var_e5ad813f.nextindex];
    if (!isdefined(location.var_54fb921c)) {
        dir = level.mapcenter - location.origin;
        dist = distance(level.mapcenter, location.origin);
        if (dist > 0) {
            dir = (dir[0] / dist, dir[1] / dist, dir[2] / dist);
        }
        attempts = 9;
        newlocation = location.origin;
        rand = randomfloat(1);
        while (attempts > 0) {
            randdist = dist * rand;
            newlocation = location.origin + dir * randdist;
            if (!function_5e31e74e(newlocation)) {
                break;
            }
            rand -= 0.1;
            if (rand < 0) {
                newlocation = location.origin;
                break;
            }
            attempts--;
        }
        newlocation = getclosestpointonnavmesh(newlocation, 100);
        if (!isdefined(newlocation)) {
            newlocation = location.origin;
        }
        location.var_54fb921c = newlocation;
    }
    origin = location.var_54fb921c + (0, 0, 40);
    level.var_e5ad813f.nextindex++;
    return origin;
}

// Namespace prop/prop
// Params 4, eflags: 0x0
// Checksum 0x11046a24, Offset: 0xaab8
// Size: 0x116
function function_249fb651(x, y, label, color) {
    var_f2d1d7d5 = spawnstruct();
    var_f2d1d7d5.label = label;
    var_f2d1d7d5.x = x;
    var_f2d1d7d5.y = y;
    var_f2d1d7d5.alignx = "left";
    var_f2d1d7d5.aligny = "top";
    var_f2d1d7d5.horzalign = "left";
    var_f2d1d7d5.vertalign = "top";
    var_f2d1d7d5.color = color;
    var_f2d1d7d5.archived = 1;
    var_f2d1d7d5.alpha = 0;
    var_f2d1d7d5.glowalpha = 0;
    var_f2d1d7d5.hidewheninmenu = 0;
    var_f2d1d7d5.sort = 1001;
    return var_f2d1d7d5;
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0xcf76e1ad, Offset: 0xabd8
// Size: 0x29c
function function_9b0f77c4(titlelabel) {
    level.var_e5ad813f.var_239c724 = [];
    var_62372e41 = 110;
    var_ff475784 = 20;
    if (!level.console) {
        var_62372e41 = 125;
        var_ff475784 = 15;
    }
    x = 5;
    y = var_62372e41;
    level.var_e5ad813f.var_239c724[level.var_e5ad813f.var_239c724.size] = function_249fb651(x, y, #"mp_ph_minigame_first", (1, 0.843, 0));
    y += var_ff475784;
    level.var_e5ad813f.var_239c724[level.var_e5ad813f.var_239c724.size] = function_249fb651(x, y, #"mp_ph_minigame_second", (0.3, 0.3, 0.3));
    y += var_ff475784;
    level.var_e5ad813f.var_239c724[level.var_e5ad813f.var_239c724.size] = function_249fb651(x, y, #"mp_ph_minigame_third", (0.804, 0.498, 0.196));
    level.var_e5ad813f.var_d410e6e5 = spawnstruct();
    level.var_e5ad813f.var_d410e6e5.label = titlelabel;
    level.var_e5ad813f.var_d410e6e5.x = 0;
    level.var_e5ad813f.var_d410e6e5.archived = 1;
    level.var_e5ad813f.var_d410e6e5.alpha = 1;
    level.var_e5ad813f.var_d410e6e5.glowalpha = 0;
    level.var_e5ad813f.var_d410e6e5.hidewheninmenu = 0;
    thread function_e14e11c4();
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x3d1d918e, Offset: 0xae80
// Size: 0x34
function function_e14e11c4() {
    level endon(#"game_ended");
    wait 5.5;
    wait 1;
    wait 1;
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0xb3c729aa, Offset: 0xaec0
// Size: 0x7c
function function_a88142c8(player) {
    var_47b5687d = gettime() - level.starttime - level.var_f2aa1432;
    player.var_efe75c2f++;
    player.var_61add00c += var_47b5687d;
    player thread function_1cda54();
    function_c021720c();
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0x1189f975, Offset: 0xaf48
// Size: 0x190
function function_c021720c(delaytime) {
    level endon(#"game_ended");
    if (isdefined(delaytime)) {
        wait delaytime;
    }
    hunters = getlivingplayersonteam(game.attackers);
    var_711fc677 = array::merge_sort(hunters, &function_69596636);
    for (i = 0; i < 3; i++) {
        if (isdefined(var_711fc677[i]) && isdefined(var_711fc677[i].var_efe75c2f) && var_711fc677[i].var_efe75c2f > 0) {
            level.var_e5ad813f.var_239c724[i].alpha = 1;
            continue;
        }
        if (isdefined(level.var_e5ad813f.var_239c724) && isdefined(level.var_e5ad813f.var_239c724[i]) && level.var_e5ad813f.var_239c724[i].alpha > 0) {
            level.var_e5ad813f.var_239c724[i].alpha = 0;
        }
    }
}

// Namespace prop/prop
// Params 2, eflags: 0x0
// Checksum 0xf1788de, Offset: 0xb0e0
// Size: 0xb6
function function_69596636(p1, p2) {
    if (!isdefined(p1) || !isdefined(p1.var_efe75c2f)) {
        return false;
    }
    if (!isdefined(p2) || !isdefined(p2.var_efe75c2f)) {
        return true;
    }
    if (p1.var_efe75c2f > p2.var_efe75c2f) {
        return true;
    }
    return p1.var_efe75c2f == p2.var_efe75c2f && p1.var_61add00c <= p2.var_61add00c;
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0x3bccc23d, Offset: 0xb1a0
// Size: 0x11a
function function_ae94b584(label) {
    self.var_24edba04 = spawnstruct();
    self.var_24edba04.label = label;
    self.var_24edba04.x = 0;
    self.var_24edba04.y = 20;
    self.var_24edba04.alignx = "center";
    self.var_24edba04.aligny = "middle";
    self.var_24edba04.horzalign = "user_center";
    self.var_24edba04.vertalign = "middle";
    self.var_24edba04.archived = 1;
    self.var_24edba04.fontscale = 1;
    self.var_24edba04.alpha = 0;
    self.var_24edba04.glowalpha = 0.5;
    self.var_24edba04.hidewheninmenu = 0;
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0x69dfaed4, Offset: 0xb2c8
// Size: 0x24
function function_89acdf0d(label) {
    self function_ae94b584(label);
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0xf3c1aa88, Offset: 0xb2f8
// Size: 0x26
function function_1cda54() {
    self.var_24edba04.alpha = 1;
    self.var_24edba04.alpha = 0;
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x57cbaa8a, Offset: 0xb328
// Size: 0x134
function function_83efbfcf() {
    forward = anglestoforward(self getangles());
    origin = self.origin + vectorscale(forward, 100);
    origin = getclosestpointonnavmesh(origin, 600);
    clone = spawnactor("spawner_bo3_robot_grunt_assault_mp", origin, self.angles, "", 1);
    clone.var_9352d14f = function_16efb8e6(origin + (0, 0, 40));
    clone.var_9352d14f linkto(clone);
    level.var_abcf2d12[level.var_abcf2d12.size] = clone;
    function_ec41bbd2(clone, self, forward);
}

// Namespace prop/prop
// Params 3, eflags: 0x0
// Checksum 0xb0d8444e, Offset: 0xb468
// Size: 0x32c
function function_ec41bbd2(clone, player, forward) {
    clone.isaiclone = 1;
    clone.propername = "";
    clone.ignoretriggerdamage = 1;
    clone.minwalkdistance = 125;
    clone.overrideactordamage = &clonedamageoverride;
    clone.spawntime = gettime();
    clone.var_132756fd = 1;
    clone setmaxhealth(9999);
    clone pushplayer(1);
    clone setcontents(8192);
    clone setavoidancemask("avoid none");
    clone.var_6f5f0e80 = gameobjects::get_next_obj_id();
    objective_add(clone.var_6f5f0e80, "active");
    objective_onentity(clone.var_6f5f0e80, clone);
    clone asmsetanimationrate(1.2);
    clone setclone();
    clone._goal_center_point = function_176b694c();
    queryresult = undefined;
    if (isdefined(clone._goal_center_point) && clone findpath(clone.origin, clone._goal_center_point, 1, 0)) {
        queryresult = positionquery_source_navigation(clone._goal_center_point, 0, 450, 450, 100, clone);
    } else {
        queryresult = positionquery_source_navigation(clone.origin, 500, 750, 750, 50, clone);
    }
    if (queryresult.data.size > 0) {
        clone._clone_goal = queryresult.data[0].origin;
        clone._clone_goal_max_dist = 450;
    } else {
        clone._goal_center_point = clone.origin;
    }
    clone thread _updateclonepathing();
    clone hidefromteam(game.defenders);
    clone ghost();
    _configurecloneteam(clone, player);
}

// Namespace prop/prop
// Params 15, eflags: 0x0
// Checksum 0x44d7e54, Offset: 0xb7a0
// Size: 0x7e
function clonedamageoverride(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, timeoffset, boneindex, modelindex, surfacetype, surfacenormal) {
    return false;
}

// Namespace prop/prop
// Params 2, eflags: 0x0
// Checksum 0xa662ee25, Offset: 0xb828
// Size: 0x6a
function _configurecloneteam(clone, player) {
    team = util::getotherteam(player.team);
    clone.ignoreall = 1;
    clone setteam(team);
    clone.team = team;
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x99053251, Offset: 0xb8a0
// Size: 0xe4
function function_41d2c44e() {
    var_b71aa5e8 = 10000;
    var_ae1cb2e9 = [];
    foreach (clone in level.var_abcf2d12) {
        if (self == clone) {
            continue;
        }
        distsq = distancesquared(clone.origin, self.origin);
        if (distsq < var_b71aa5e8) {
            var_ae1cb2e9[var_ae1cb2e9.size] = clone;
        }
    }
    return var_ae1cb2e9;
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0xc3285994, Offset: 0xb990
// Size: 0x370
function _updateclonepathing() {
    self endon(#"death");
    clone_not_moving_dist_sq = 576;
    clone_not_moving_poll_time = 2000;
    var_38da5046 = 1500;
    if (!isdefined(level.var_e5ad813f.var_dffd326e)) {
        level.var_e5ad813f.var_dffd326e = 0;
    }
    while (true) {
        if (!isdefined(self.lastknownpos)) {
            self.lastknownpos = self.origin;
            self.lastknownpostime = gettime();
        }
        if (!isdefined(self.var_20143a0c)) {
            self.var_20143a0c = gettime();
        }
        distance = 0;
        if (isdefined(self._clone_goal)) {
            distance = distancesquared(self._clone_goal, self.origin);
        }
        var_9bac6f63 = 0;
        if (distance < 14400) {
            var_9bac6f63 = 1;
        } else if (!self haspath()) {
            var_9bac6f63 = 1;
        } else if (self.lastknownpostime + clone_not_moving_poll_time <= gettime()) {
            if (distancesquared(self.lastknownpos, self.origin) < clone_not_moving_dist_sq) {
                var_9bac6f63 = 1;
            }
            self.lastknownpos = self.origin;
            self.lastknownpostime = gettime();
        } else if (self.var_20143a0c + var_38da5046 <= gettime() && level.var_e5ad813f.var_dffd326e != gettime()) {
            clones = function_41d2c44e();
            if (clones.size > 0) {
                var_9bac6f63 = 1;
            }
            for (i = 0; i < clones.size; i++) {
                clones[i].var_20143a0c = gettime();
            }
            self.var_20143a0c = gettime();
        }
        if (var_9bac6f63) {
            level.var_e5ad813f.var_dffd326e = gettime();
            self._goal_center_point = function_176b694c();
            queryresult = positionquery_source_navigation(self._goal_center_point, 500, 750, 750, 100, self);
            if (queryresult.data.size == 0) {
                queryresult = positionquery_source_navigation(self.origin, 500, 750, 750, 100, self);
            }
            if (queryresult.data.size > 0) {
                randindex = randomintrange(0, queryresult.data.size);
                self._clone_goal = queryresult.data[randindex].origin;
                self._clone_goal_max_dist = 750;
            }
        }
        wait 0.5;
    }
}

// Namespace prop/prop
// Params 0, eflags: 0x0
// Checksum 0x3526a4bf, Offset: 0xbd08
// Size: 0x8e
function function_176b694c() {
    if (level.var_e5ad813f.nextindex >= level.var_e5ad813f.targetlocations.size) {
        level.var_e5ad813f.nextindex = 0;
    }
    location = level.var_e5ad813f.targetlocations[level.var_e5ad813f.nextindex];
    level.var_e5ad813f.nextindex++;
    return location.origin;
}

// Namespace prop/prop
// Params 1, eflags: 0x0
// Checksum 0x3a052923, Offset: 0xbda0
// Size: 0x190
function function_16efb8e6(origin) {
    model = function_5f1e8e1b();
    target = spawn("script_model", origin);
    target setmodel(model);
    target.targetname = "propTarget";
    target setcandamage(1);
    target.fakehealth = 50;
    target.health = 99999;
    target.maxhealth = 99999;
    target thread function_500dc7d9(&function_12f9ab17);
    target setplayercollision(0);
    target makesentient();
    target setteam(game.defenders);
    target hidefromteam(game.defenders);
    target setscale(2);
    thread function_7d3dbc54(target);
    return target;
}

// Namespace prop/prop
// Params 10, eflags: 0x0
// Checksum 0x4cee483b, Offset: 0xbf38
// Size: 0xc2
function function_12f9ab17(damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, weapon, idflags) {
    if (!isdefined(attacker)) {
        return;
    }
    if (isplayer(attacker)) {
        attacker thread damagefeedback::update();
        self.lastattacker = attacker;
        function_a88142c8(attacker);
    }
    self.health += damage;
}

