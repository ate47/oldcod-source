#using scripts\abilities\ability_util;
#using scripts\core_common\array_shared;
#using scripts\core_common\bots\bot;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\hostmigration_shared;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\sound_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\spectating;
#using scripts\core_common\util_shared;
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
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\util;

#namespace infect;

// Namespace infect/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x6d4dacf6, Offset: 0x350
// Size: 0x492
function event_handler[gametype_init] main(eventstruct) {
    globallogic::init();
    level.var_f817b02b = 1;
    level.var_b7bd625 = getweapon("pistol_standard_t8");
    level.var_55c74d4a = getweapon("knife_loadout");
    level.var_6fd3f827 = getweapon("hatchet");
    util::registerroundswitch(0, 9);
    util::registertimelimit(0, 1440);
    util::registerscorelimit(0, 50000);
    util::registerroundlimit(0, 10);
    util::registerroundwinlimit(0, 10);
    util::registernumlives(0, 100);
    globallogic::registerfriendlyfiredelay(level.gametype, 15, 0, 1440);
    level.scoreroundwinbased = getgametypesetting("cumulativeRoundScores") == 0;
    level.teamscoreperkill = getgametypesetting("teamScorePerKill");
    level.teamscoreperdeath = getgametypesetting("teamScorePerDeath");
    level.teamscoreperheadshot = getgametypesetting("teamScorePerHeadshot");
    level.teambased = 1;
    level.overrideteamscore = 1;
    level.onstartgametype = &onstartgametype;
    level.onendgame = &onendgame;
    level.onspawnplayer = &onspawnplayer;
    level.onroundendgame = &onroundendgame;
    level.onroundswitch = &onroundswitch;
    level.var_859df572 = &function_859df572;
    level.gettimelimit = &gettimelimit;
    level.var_ad0ac054 = &function_e7129db9;
    callback::on_connect(&onplayerconnect);
    callback::on_disconnect(&onplayerdisconnect);
    callback::on_joined_team(&onplayerjoinedteam);
    callback::on_joined_spectate(&function_27abe9eb);
    player::function_b0320e78(&onplayerkilled);
    gameobjects::register_allowed_gameobject(level.gametype);
    level.givecustomloadout = &givecustomloadout;
    level.var_485556b = &function_485556b;
    level.ontimelimit = &ontimelimit;
    level.var_355e787 = &function_355e787;
    var_ad774848 = [];
    if (!isdefined(var_ad774848)) {
        var_ad774848 = [];
    } else if (!isarray(var_ad774848)) {
        var_ad774848 = array(var_ad774848);
    }
    var_ad774848[var_ad774848.size] = "specialty_sprint";
    if (!isdefined(var_ad774848)) {
        var_ad774848 = [];
    } else if (!isarray(var_ad774848)) {
        var_ad774848 = array(var_ad774848);
    }
    var_ad774848[var_ad774848.size] = "specialty_slide";
    level.var_ad774848 = var_ad774848;
}

// Namespace infect/infect
// Params 0, eflags: 0x0
// Checksum 0x1345666e, Offset: 0x7f0
// Size: 0x3d4
function onstartgametype() {
    setclientnamemode("auto_change");
    game.defenders = "allies";
    game.attackers = "axis";
    if (!isdefined(game.switchedsides)) {
        game.switchedsides = 0;
    }
    if (game.switchedsides) {
        oldattackers = game.attackers;
        olddefenders = game.defenders;
        game.attackers = olddefenders;
        game.defenders = oldattackers;
    }
    level.displayroundendtext = 0;
    influencers::create_map_placed_influencers();
    level.spawnmins = (0, 0, 0);
    level.spawnmaxs = (0, 0, 0);
    foreach (team in level.teams) {
        spawning::add_spawn_points(team, "mp_tdm_spawn");
        spawning::place_spawn_points(spawning::gettdmstartspawnname(team));
    }
    spawning::updateallspawnpoints();
    level.spawn_start = [];
    foreach (team in level.teams) {
        level.spawn_start[team] = spawning::get_spawnpoint_array(spawning::gettdmstartspawnname(team));
    }
    level.mapcenter = math::find_box_center(level.spawnmins, level.spawnmaxs);
    setmapcenter(level.mapcenter);
    spawnpoint = spawning::get_random_intermission_point();
    setdemointermissionpoint(spawnpoint.origin, spawnpoint.angles);
    if (!util::isoneround()) {
        level.displayroundendtext = 1;
        if (level.scoreroundwinbased) {
            globallogic_score::resetteamscores();
        }
    }
    level.infect_chosefirstinfected = 0;
    level.infect_choosingfirstinfected = 0;
    level.infect_allowsuicide = 0;
    level.infect_awardedfinalsurvivor = 0;
    level.infect_players = [];
    inithud();
    maxfree = getdvarint(#"bot_maxfree", 0);
    level thread bot::monitor_bot_population(maxfree);
    level thread function_d07961fd();
    level thread function_938d075f();
}

// Namespace infect/infect
// Params 0, eflags: 0x0
// Checksum 0x6b0b5d0f, Offset: 0xbd0
// Size: 0x44
function function_8dde4d1f() {
    function_f72d8c1c(game.attackers, "MPUI_INFECTED");
    function_f72d8c1c(game.defenders, "MPUI_SURVIVORS");
}

// Namespace infect/infect
// Params 2, eflags: 0x0
// Checksum 0xd5e0ed4f, Offset: 0xc20
// Size: 0x6c
function function_f72d8c1c(team, name) {
    var_19719540 = "g_customTeamName_" + team;
    if (getdvarstring(var_19719540) == "") {
        setdvar(var_19719540, name);
    }
}

// Namespace infect/infect
// Params 1, eflags: 0x0
// Checksum 0xf5723b3b, Offset: 0xc98
// Size: 0x4c
function onendgame(winningteam) {
    if (!util::isoneround() && !util::islastround()) {
        function_22765af9(winningteam);
    }
}

// Namespace infect/infect
// Params 1, eflags: 0x0
// Checksum 0x4735a74f, Offset: 0xcf0
// Size: 0x1c6
function function_22765af9(winningteam) {
    players = level.players;
    for (i = 0; i < players.size; i++) {
        if (!isdefined(players[i].pers[#"team"])) {
            continue;
        }
        if (level.hostforcedend && players[i] ishost()) {
            continue;
        }
        if (winningteam == "tie") {
            globallogic_score::updatetiestats(players[i]);
            continue;
        }
        if (players[i].pers[#"team"] == winningteam) {
            globallogic_score::updatewinstats(players[i]);
            continue;
        }
        if (level.rankedmatch && !level.leaguematch && players[i].pers[#"latejoin"] === 1) {
            globallogic_score::updatelosslatejoinstats(players[i]);
        }
        if (!level.disablestattracking) {
            players[i] stats::set_stat(#"playerstatslist", "cur_win_streak", #"statvalue", 0);
        }
    }
}

// Namespace infect/infect
// Params 0, eflags: 0x0
// Checksum 0xe290b7ea, Offset: 0xec0
// Size: 0xee
function inithud() {
    level.var_796fada2 = spawnstruct();
    level.var_796fada2.label = #"hash_7bf80a392d947b6e";
    level.var_796fada2.alpha = 0;
    level.var_796fada2.archived = 0;
    level.var_796fada2.hidewheninmenu = 1;
    level.var_a3c7456d = spawnstruct();
    level.var_a3c7456d.label = #"hash_29028683f846db5d";
    level.var_a3c7456d.alpha = 0;
    level.var_a3c7456d.archived = 0;
    level.var_a3c7456d.hidewheninmenu = 1;
}

// Namespace infect/infect
// Params 0, eflags: 0x0
// Checksum 0x5b5c1ab8, Offset: 0xfb8
// Size: 0xa2
function onplayerconnect() {
    self.var_e8432f46 = 1;
    self.var_10054897 = level.inprematchperiod;
    if (self.sessionteam != "spectator") {
        self.pers[#"needteam"] = 1;
    }
    playerxuid = self getxuid();
    if (isdefined(level.infect_players[playerxuid])) {
        self.var_1df9e01d = 1;
    }
    self.var_d1d70226 = 1;
}

// Namespace infect/infect
// Params 1, eflags: 0x0
// Checksum 0x9a01055e, Offset: 0x1068
// Size: 0x3a
function onplayerjoinedteam(params) {
    if (self.team == game.attackers) {
        self.disableclassselection = 1;
        return;
    }
    self.disableclassselection = undefined;
}

// Namespace infect/infect
// Params 2, eflags: 0x0
// Checksum 0xfa4b219e, Offset: 0x10b0
// Size: 0x102
function function_485556b(player, comingfrommenu) {
    if (!comingfrommenu && player.sessionteam == "spectator") {
        teamname = "spectator";
    } else if (isdefined(level.var_8d48cf10) && level.var_8d48cf10) {
        level.var_8d48cf10 = undefined;
        teamname = game.defenders;
        level thread function_93f386c5();
    } else if (isdefined(player.var_1df9e01d) && player.var_1df9e01d || isdefined(level.infect_chosefirstinfected) && level.infect_chosefirstinfected) {
        teamname = game.attackers;
    } else {
        teamname = game.defenders;
    }
    return teamname;
}

// Namespace infect/infect
// Params 0, eflags: 0x0
// Checksum 0x4d01d3b7, Offset: 0x11c0
// Size: 0x50
function function_dc5fbf33() {
    started_waiting = gettime();
    while (!self isstreamerready(-1, 1) && started_waiting + 90000 > gettime()) {
        waitframe(1);
    }
}

// Namespace infect/infect
// Params 1, eflags: 0x0
// Checksum 0xf7080e7d, Offset: 0x1218
// Size: 0xd4
function onspawnplayer(predictedspawn) {
    if (level.usestartspawns && !level.ingraceperiod && !level.playerqueuedrespawn) {
        level.usestartspawns = 0;
    }
    updateteamscores();
    if (self.team == game.attackers) {
        function_e834578f();
    }
    if (!level.infect_choosingfirstinfected) {
        level.infect_choosingfirstinfected = 1;
        level thread choosefirstinfected();
    }
    spawning::onspawnplayer(predictedspawn);
}

// Namespace infect/infect
// Params 0, eflags: 0x0
// Checksum 0xdfd93de8, Offset: 0x12f8
// Size: 0x1a
function onroundswitch() {
    game.switchedsides = !game.switchedsides;
}

// Namespace infect/infect
// Params 1, eflags: 0x0
// Checksum 0x7e74c5ef, Offset: 0x1320
// Size: 0xba
function onroundendgame(roundwinner) {
    if (level.scoreroundwinbased) {
        foreach (team in level.teams) {
            [[ level._setteamscore ]](team, game.stat[#"roundswon"][team]);
        }
    }
    return [[ level.determinewinner ]]();
}

// Namespace infect/infect
// Params 0, eflags: 0x0
// Checksum 0xa9895485, Offset: 0x13e8
// Size: 0x20
function function_b3349c22() {
    return self.pers[#"time_played_moving"] > 0;
}

// Namespace infect/infect
// Params 3, eflags: 0x0
// Checksum 0x6ddc416, Offset: 0x1410
// Size: 0xc8
function function_40cc7792(team, var_eb4caf58, calloutplayer) {
    players = function_dd68b18b(team);
    foreach (player in players) {
        player luinotifyevent(#"player_callout", 2, var_eb4caf58, calloutplayer);
    }
}

// Namespace infect/infect
// Params 9, eflags: 0x0
// Checksum 0x66b9d5a, Offset: 0x14e0
// Size: 0x214
function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    processkill = 0;
    wassuicide = 0;
    if (self.team == game.defenders && isdefined(attacker)) {
        if (level.friendlyfire > 0 && isdefined(attacker.team) && attacker.team == self.team) {
            processkill = 0;
        } else if (isplayer(attacker) && attacker != self) {
            processkill = 1;
        } else if (level.infect_allowsuicide && (attacker == self || !isplayer(attacker))) {
            processkill = 1;
            wassuicide = 1;
        }
    }
    if (!processkill) {
        return;
    }
    if (!wassuicide) {
        scoreevents::processscoreevent("infected_survivor", attacker, self, weapon);
        if (isdefined(attacker.pers[#"infects"])) {
            attacker.pers[#"infects"] = attacker.pers[#"infects"] + 1;
            attacker.infects = attacker.pers[#"infects"];
        }
    }
    level thread function_e523aca(self, wassuicide);
}

// Namespace infect/infect
// Params 2, eflags: 0x0
// Checksum 0xcd810975, Offset: 0x1700
// Size: 0x2ac
function function_e523aca(victim, wassuicide) {
    level endon(#"game_ended");
    waittillframeend();
    if (isdefined(victim.laststand)) {
        result = victim function_a27aff1a();
        if (result === "player_input_revive") {
            return;
        }
    }
    waitframe(1);
    if (isdefined(victim)) {
        level thread function_34c8bd01();
        function_f65059ce(victim);
        function_e834578f();
    }
    var_7dc99dab = [[ level._getteamscore ]](game.defenders);
    if (var_7dc99dab > 1 && isdefined(victim)) {
        sound::play_on_players("mpl_flagget_sting_enemy", game.defenders);
        sound::play_on_players("mpl_flagget_sting_friend", game.attackers);
        function_40cc7792(game.defenders, #"hash_244c25683556aaae", victim.entnum);
        if (!wassuicide) {
            function_40cc7792(game.attackers, #"hash_6e923e5da5c6cc5d", victim.entnum);
            survivors = function_dd68b18b(game.defenders);
            foreach (survivor in survivors) {
                if (survivor != victim && survivor function_b3349c22()) {
                    survivor scoreevents::processscoreevent("survivor_still_alive", survivor);
                }
            }
        }
        return;
    }
    if (var_7dc99dab == 1) {
        onfinalsurvivor();
        return;
    }
    if (var_7dc99dab == 0) {
        onsurvivorseliminated();
    }
}

// Namespace infect/infect
// Params 0, eflags: 0x0
// Checksum 0x325db25b, Offset: 0x19b8
// Size: 0x66
function function_a27aff1a() {
    level endon(#"game_ended");
    self endon(#"disconnect");
    waitresult = self waittill(#"player_input_revive", #"death");
    return waitresult._notify;
}

// Namespace infect/infect
// Params 0, eflags: 0x0
// Checksum 0x3081b861, Offset: 0x1a28
// Size: 0x16a
function onfinalsurvivor() {
    if (isdefined(level.var_c1bb459e) && level.var_c1bb459e) {
        return;
    }
    sound::play_on_players("mpl_ballreturn_sting");
    finalsurvivor = function_dd68b18b(game.defenders)[0];
    if (!level.infect_awardedfinalsurvivor) {
        finalsurvivor function_d24c1b2e();
        if (finalsurvivor.var_10054897 && finalsurvivor function_b3349c22()) {
            finalsurvivor scoreevents::processscoreevent("final_survivor", finalsurvivor);
        }
        level.infect_awardedfinalsurvivor = 1;
    }
    luinotifyevent(#"player_callout", 2, #"hash_3e684642ff9a53f1", finalsurvivor.entnum);
    var_e8414f44 = getdvarint(#"hash_a7883ea30e7608a", 0);
    if (var_e8414f44) {
        level thread finalsurvivoruav(finalsurvivor);
    }
    level.var_c1bb459e = 1;
}

// Namespace infect/infect
// Params 0, eflags: 0x0
// Checksum 0xd2942576, Offset: 0x1ba0
// Size: 0x74
function function_d24c1b2e() {
    if (!isdefined(self.heroweapon)) {
        return;
    }
    var_16c7dd95 = self gadgetgetslot(self.heroweapon);
    if (self gadgetisready(var_16c7dd95)) {
        return;
    }
    self gadgetpowerset(var_16c7dd95, 100);
}

// Namespace infect/infect
// Params 1, eflags: 0x0
// Checksum 0x1defd67e, Offset: 0x1c20
// Size: 0x244
function finalsurvivoruav(finalsurvivor) {
    level endon(#"game_ended");
    finalsurvivor endon(#"disconnect");
    finalsurvivor endon(#"death");
    level endon(#"hash_c99e3873a00e736");
    level thread enduavonlatejoiner(finalsurvivor);
    setteamspyplane(game.attackers, 1);
    util::set_team_radar(game.attackers, 1);
    removeuav = 0;
    while (true) {
        prevpos = finalsurvivor.origin;
        wait 4;
        if (removeuav) {
            setteamspyplane(game.attackers, 0);
            util::set_team_radar(game.var_a6368cc2, 0);
            removeuav = 0;
        }
        wait 6;
        if (distancesquared(prevpos, finalsurvivor.origin) < 200 * 200) {
            setteamspyplane(game.attackers, 1);
            util::set_team_radar(game.attackers, 1);
            removeuav = 1;
            foreach (player in level.players) {
                sound::play_on_players("fly_hunter_raise_plr");
            }
        }
    }
}

// Namespace infect/infect
// Params 1, eflags: 0x0
// Checksum 0x6818aef3, Offset: 0x1e70
// Size: 0xf2
function enduavonlatejoiner(finalsurvivor) {
    level endon(#"game_ended");
    finalsurvivor endon(#"disconnect");
    finalsurvivor endon(#"death");
    while (true) {
        var_7dc99dab = [[ level._getteamscore ]](game.defenders);
        if (var_7dc99dab > 1) {
            level notify(#"hash_c99e3873a00e736");
            waitframe(1);
            setteamspyplane(game.attackers, 1);
            util::set_team_radar(game.attackers, 1);
            break;
        }
        waitframe(1);
    }
}

// Namespace infect/infect
// Params 0, eflags: 0x0
// Checksum 0xa752967c, Offset: 0x1f70
// Size: 0x3c
function ontimelimit() {
    winner = game.defenders;
    level thread endgame(winner, 2);
}

// Namespace infect/infect
// Params 0, eflags: 0x0
// Checksum 0x833bc60a, Offset: 0x1fb8
// Size: 0x34
function onsurvivorseliminated() {
    updateteamscores();
    level thread endgame(game.attackers, 6);
}

// Namespace infect/infect
// Params 2, eflags: 0x0
// Checksum 0xcada5a53, Offset: 0x1ff8
// Size: 0x44
function function_8eee536a(winning_team, var_c3d87d03) {
    round::set_winner(winning_team);
    thread globallogic::function_e0994b4(winning_team, var_c3d87d03);
}

// Namespace infect/infect
// Params 2, eflags: 0x0
// Checksum 0x39a4a9e1, Offset: 0x2048
// Size: 0x74
function endgame(winner, endreasontext) {
    if (isdefined(level.var_15e262e5) && level.var_15e262e5) {
        return;
    }
    level.var_15e262e5 = 1;
    util::wait_network_frame();
    function_8eee536a(winner, endreasontext);
}

// Namespace infect/infect
// Params 0, eflags: 0x0
// Checksum 0x8542146b, Offset: 0x20c8
// Size: 0x14
function function_27abe9eb() {
    function_ca9945d6();
}

// Namespace infect/infect
// Params 0, eflags: 0x0
// Checksum 0x24f38a77, Offset: 0x20e8
// Size: 0x14
function onplayerdisconnect() {
    function_ca9945d6();
}

// Namespace infect/infect
// Params 0, eflags: 0x0
// Checksum 0x416f40f9, Offset: 0x2108
// Size: 0x1d0
function function_ca9945d6() {
    if (isdefined(level.gameended) && level.gameended) {
        return;
    }
    updateteamscores();
    var_9cc4807f = [[ level._getteamscore ]](game.attackers);
    var_7dc99dab = [[ level._getteamscore ]](game.defenders);
    if (isdefined(self.infect_isbeingchosen) || level.infect_chosefirstinfected) {
        if (var_9cc4807f > 0 && var_7dc99dab > 0) {
            if (var_7dc99dab == 1) {
                onfinalsurvivor();
            }
        } else if (var_7dc99dab == 0) {
            onsurvivorseliminated();
        } else if (var_9cc4807f == 0) {
            if (var_7dc99dab == 1) {
                winner = game.defenders;
                level thread endgame(winner, 6);
            } else if (var_7dc99dab > 1) {
                level.infect_chosefirstinfected = 0;
                level thread choosefirstinfected();
            }
        }
        return;
    }
    var_c2df8eb5 = function_d418a8fd(game.defenders);
    if (var_c2df8eb5.size < 1) {
        level notify(#"hash_367e3645fd146620");
    }
}

// Namespace infect/infect
// Params 2, eflags: 0x0
// Checksum 0x6f2a2341, Offset: 0x22e0
// Size: 0x8e
function givecustomloadout(takeallweapons, alreadyspawned) {
    if (self.team == game.attackers) {
        self function_4fe19a2e();
        self.movementspeedmodifier = 1.2;
    } else if (self.team == game.defenders) {
        self function_bce75136();
        self.movementspeedmodifier = undefined;
    }
    return self.spawnweapon;
}

// Namespace infect/infect
// Params 0, eflags: 0x0
// Checksum 0xd2230a1c, Offset: 0x2378
// Size: 0xb6
function function_bce75136() {
    loadout::init_player(1);
    loadout::function_3f1c5df5(self.curclass);
    self setactionslot(3, "altMode");
    self setactionslot(4, "");
    level.givecustomloadout = undefined;
    loadout::give_loadout(self.team, self.curclass);
    level.givecustomloadout = &givecustomloadout;
}

// Namespace infect/infect
// Params 0, eflags: 0x0
// Checksum 0xe4b16885, Offset: 0x2438
// Size: 0x236
function function_4fe19a2e() {
    loadout::init_player(1);
    loadout::function_3f1c5df5(self.curclass);
    self clearperks();
    foreach (perkname in level.var_ad774848) {
        if (!self hasperk(perkname)) {
            self setperk(perkname);
        }
    }
    var_9cc4807f = [[ level._getteamscore ]](game.attackers);
    if (var_9cc4807f == 1) {
        defaultweapon = level.var_b7bd625;
    } else {
        defaultweapon = level.var_55c74d4a;
    }
    self function_84503315(defaultweapon);
    self switchtoweapon(defaultweapon);
    self setspawnweapon(defaultweapon);
    self.spawnweapon = defaultweapon;
    primaryoffhand = level.var_6fd3f827;
    primaryoffhandcount = 1;
    self giveweapon(primaryoffhand);
    self setweaponammostock(primaryoffhand, primaryoffhandcount);
    self switchtooffhand(primaryoffhand);
    self.grenadetypeprimary = primaryoffhand;
    self.grenadetypeprimarycount = primaryoffhandcount;
    self giveweapon(level.weaponbasemelee);
    self.heroweapon = undefined;
}

// Namespace infect/infect
// Params 1, eflags: 0x0
// Checksum 0x2bbcab, Offset: 0x2678
// Size: 0x1a
function settimer(time) {
    self.time = time;
}

// Namespace infect/infect
// Params 0, eflags: 0x0
// Checksum 0x58e862f0, Offset: 0x26a0
// Size: 0x15e
function choosefirstinfected() {
    level endon(#"game_ended");
    level endon(#"hash_367e3645fd146620");
    level.infect_allowsuicide = 0;
    level.var_93e2155b = undefined;
    if (level.inprematchperiod) {
        level waittill(#"prematch_over");
    }
    level.var_796fada2.label = #"hash_7bf80a392d947b6e";
    level.var_796fada2 settimer(8);
    level.var_796fada2.alpha = 1;
    hostmigration::waitlongdurationwithhostmigrationpause(8);
    level.var_796fada2.alpha = 0;
    var_c2df8eb5 = function_d418a8fd(game.defenders);
    if (var_c2df8eb5.size > 0) {
        array::random(var_c2df8eb5) setfirstinfected();
        return;
    }
    level.infect_choosingfirstinfected = 0;
}

// Namespace infect/infect
// Params 0, eflags: 0x0
// Checksum 0x838a99f9, Offset: 0x2808
// Size: 0x8a
function function_d07961fd() {
    while (true) {
        waitresult = level waittill(#"game_ended", #"hash_367e3645fd146620");
        if (isdefined(level.var_796fada2)) {
            level.var_796fada2.alpha = 0;
        }
        if (waitresult._notify == "game_ended") {
            return;
        }
        level.infect_choosingfirstinfected = 0;
    }
}

// Namespace infect/infect
// Params 0, eflags: 0x0
// Checksum 0x82ca94d3, Offset: 0x28a0
// Size: 0x106
function function_34c8bd01() {
    level notify(#"timeextended");
    level endon(#"game_ended");
    level endon(#"hash_14fed44cd3ece79d");
    level endon(#"timeextended");
    timeout = 0;
    while (isdefined(level.var_796fada2) && level.var_796fada2.alpha > 0) {
        hostmigration::waitlongdurationwithhostmigrationpause(0.5);
        timeout++;
        if (timeout == 20) {
            return;
        }
    }
    level.var_a3c7456d.alpha = 1;
    hostmigration::waitlongdurationwithhostmigrationpause(1);
    level.var_a3c7456d.alpha = 0;
}

// Namespace infect/infect
// Params 0, eflags: 0x0
// Checksum 0x2c3ab26f, Offset: 0x29b0
// Size: 0x7e
function function_938d075f() {
    while (true) {
        waitresult = level waittill(#"game_ended", #"hash_14fed44cd3ece79d");
        if (isdefined(level.var_a3c7456d)) {
            level.var_a3c7456d.alpha = 0;
        }
        if (waitresult._notify == "game_ended") {
            return;
        }
    }
}

// Namespace infect/infect
// Params 1, eflags: 0x0
// Checksum 0x1cd1afd7, Offset: 0x2a38
// Size: 0x108
function function_d418a8fd(team) {
    activeplayers = [];
    teamplayers = function_dd68b18b(team);
    foreach (player in teamplayers) {
        if (player.sessionstate == "spectator") {
            continue;
        }
        if (!isdefined(activeplayers)) {
            activeplayers = [];
        } else if (!isarray(activeplayers)) {
            activeplayers = array(activeplayers);
        }
        activeplayers[activeplayers.size] = player;
    }
    return activeplayers;
}

// Namespace infect/infect
// Params 0, eflags: 0x0
// Checksum 0x880f1791, Offset: 0x2b48
// Size: 0x282
function setfirstinfected() {
    self endon(#"disconnect");
    self.infect_isbeingchosen = 1;
    while (!isalive(self) || self util::isusingremote()) {
        waitframe(1);
    }
    if (isdefined(self.iscarrying) && self.iscarrying) {
        self notify(#"hash_3c03f07896658fb7");
        waitframe(1);
    }
    while (self ismantling()) {
        waitframe(1);
    }
    while (!self isonground() && !self isonladder()) {
        waitframe(1);
    }
    function_f65059ce(self);
    self.switching_teams = undefined;
    if (self isusingoffhand()) {
        self forceoffhandend();
    }
    self disableoffhandspecial();
    self thread function_4c6fd26d();
    loadout::give_loadout(self.team, self.curclass);
    var_7dc99dab = [[ level._getteamscore ]](game.defenders);
    if (var_7dc99dab < 1) {
        level.var_8d48cf10 = 1;
    } else {
        forcespawnteam(game.defenders);
    }
    luinotifyevent(#"player_callout", 2, #"hash_33b0fc56325b96cd", self.entnum);
    scoreevents::processscoreevent("first_infected", self);
    sound::play_on_players("mpl_flagget_sting_enemy");
    level.infect_allowsuicide = 1;
    level.infect_chosefirstinfected = 1;
    self.infect_isbeingchosen = undefined;
}

// Namespace infect/infect
// Params 1, eflags: 0x0
// Checksum 0xaf59193a, Offset: 0x2dd8
// Size: 0xa0
function forcespawnteam(team) {
    players = function_dd68b18b(team);
    foreach (player in players) {
        player thread playerforcespawn();
    }
}

// Namespace infect/infect
// Params 0, eflags: 0x0
// Checksum 0x30f9095b, Offset: 0x2e80
// Size: 0x110
function playerforcespawn() {
    level endon(#"game_ended");
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"spawned");
    if (self.hasspawned) {
        return;
    }
    if (self.pers[#"team"] == "spectator") {
        return;
    }
    self function_dc5fbf33();
    self.pers[#"class"] = level.defaultclass;
    self.curclass = level.defaultclass;
    self globallogic_ui::closemenus();
    self closemenu("ChooseClass_InGame");
    self thread [[ level.spawnclient ]]();
}

// Namespace infect/infect
// Params 1, eflags: 0x0
// Checksum 0x9cd66606, Offset: 0x2f98
// Size: 0x7c
function function_f65059ce(player) {
    function_e90123d3(player);
    function_fb693482(player);
    player changeteam(game.attackers);
    updateteamscores();
    function_c30d35d6();
}

// Namespace infect/infect
// Params 0, eflags: 0x0
// Checksum 0xbb0c7953, Offset: 0x3020
// Size: 0x64
function function_4c6fd26d() {
    level endon(#"game_ended");
    self endon(#"disconnect");
    self endon(#"death");
    self waittill(#"weapon_change");
    self enableoffhandspecial();
}

// Namespace infect/infect
// Params 1, eflags: 0x0
// Checksum 0xfc8aa570, Offset: 0x3090
// Size: 0x46
function function_e90123d3(player) {
    playerxuid = player getxuid();
    level.infect_players[playerxuid] = 1;
}

// Namespace infect/infect
// Params 1, eflags: 0x0
// Checksum 0xc0697cca, Offset: 0x30e0
// Size: 0x156
function changeteam(team) {
    if (self.sessionstate != "dead") {
        self.switching_teams = 1;
        self.switchedteamsresetgadgets = 1;
        self.joining_team = team;
        self.leaving_team = self.pers[#"team"];
    }
    self.pers[#"team"] = team;
    self.team = team;
    self.pers[#"weapon"] = undefined;
    self.pers[#"spawnweapon"] = undefined;
    self.pers[#"savedmodel"] = undefined;
    self.pers[#"teamtime"] = undefined;
    self.sessionteam = self.pers[#"team"];
    self globallogic_ui::updateobjectivetext();
    self spectating::set_permissions();
    self notify(#"end_respawn");
}

// Namespace infect/infect
// Params 1, eflags: 0x0
// Checksum 0xc1ee15b0, Offset: 0x3240
// Size: 0x138
function function_dd68b18b(team) {
    playersonteam = [];
    foreach (player in level.players) {
        if (!isdefined(player)) {
            continue;
        }
        playerteam = player.pers[#"team"];
        if (isdefined(playerteam) && isdefined(level.teams[playerteam]) && playerteam == team) {
            if (!isdefined(playersonteam)) {
                playersonteam = [];
            } else if (!isarray(playersonteam)) {
                playersonteam = array(playersonteam);
            }
            playersonteam[playersonteam.size] = player;
        }
    }
    return playersonteam;
}

// Namespace infect/infect
// Params 1, eflags: 0x0
// Checksum 0x8bf56c36, Offset: 0x3380
// Size: 0x34
function function_bf7761ac(team) {
    playersonteam = function_dd68b18b(team);
    return playersonteam.size;
}

// Namespace infect/infect
// Params 0, eflags: 0x0
// Checksum 0xe1fd4875, Offset: 0x33c0
// Size: 0x34
function updateteamscores() {
    updateteamscore(game.attackers);
    updateteamscore(game.defenders);
}

// Namespace infect/infect
// Params 1, eflags: 0x0
// Checksum 0x6594317a, Offset: 0x3400
// Size: 0x6c
function updateteamscore(team) {
    score = function_bf7761ac(team);
    game.stat[#"teamscores"][team] = score;
    globallogic_score::updateteamscores(team);
}

// Namespace infect/infect
// Params 1, eflags: 0x0
// Checksum 0x25c3d655, Offset: 0x3478
// Size: 0x28
function function_355e787(weapon) {
    if (self.team === game.attackers) {
        return false;
    }
    return true;
}

// Namespace infect/infect
// Params 1, eflags: 0x0
// Checksum 0x58bc6216, Offset: 0x34a8
// Size: 0x6a
function function_84503315(weapon) {
    self giveweapon(weapon);
    self givestartammo(weapon);
    self setblockweaponpickup(weapon, 1);
    self.var_9ac00079 = weapon;
}

// Namespace infect/infect
// Params 0, eflags: 0x0
// Checksum 0xb89175af, Offset: 0x3520
// Size: 0x140
function function_e834578f() {
    attackers = function_dd68b18b(game.attackers);
    if (attackers.size < 2) {
        return;
    }
    foreach (player in attackers) {
        if (!isalive(player)) {
            continue;
        }
        if (player.var_9ac00079 !== level.var_55c74d4a) {
            if (isdefined(player.var_9ac00079)) {
                player takeweapon(player.var_9ac00079);
            }
            newweapon = level.var_55c74d4a;
            player function_84503315(newweapon);
            player switchtoweapon(newweapon);
        }
    }
}

// Namespace infect/infect
// Params 2, eflags: 0x0
// Checksum 0x3d703faa, Offset: 0x3668
// Size: 0x3e
function function_859df572(weapon, var_a76a1b22) {
    if (weapon == self.grenadetypeprimary || weapon == self.grenadetypesecondary) {
        return 0;
    }
    return var_a76a1b22;
}

// Namespace infect/infect
// Params 0, eflags: 0x0
// Checksum 0x4fce86ae, Offset: 0x36b0
// Size: 0x12
function function_c30d35d6() {
    level.var_93e2155b = gettime();
}

// Namespace infect/infect
// Params 0, eflags: 0x0
// Checksum 0xe557e844, Offset: 0x36d0
// Size: 0x8e
function gettimelimit() {
    defaulttimelimit = getgametypesetting("timeLimit");
    if (defaulttimelimit == 0) {
        return 0;
    }
    if (!isdefined(level.var_93e2155b)) {
        return 0;
    }
    var_22ff0aac = (level.var_93e2155b - level.starttime + 1000) / 60000;
    timelimit = var_22ff0aac + defaulttimelimit;
    return timelimit;
}

// Namespace infect/infect
// Params 1, eflags: 0x0
// Checksum 0xa1135944, Offset: 0x3768
// Size: 0xce
function function_fb693482(player) {
    for (i = 0; i < level.missileentities.size; i++) {
        item = level.missileentities[i];
        if (!isdefined(item)) {
            continue;
        }
        if (!isdefined(item.weapon)) {
            continue;
        }
        if (item.owner !== player && item.originalowner !== player) {
            continue;
        }
        item notify(#"detonating");
        if (isdefined(item)) {
            item delete();
        }
    }
}

// Namespace infect/infect
// Params 8, eflags: 0x0
// Checksum 0xff89186f, Offset: 0x3840
// Size: 0x284
function function_c17c938d(winner, endtype, endreasontext, outcometext, team, winnerenum, notifyroundendtoui, matchbonus) {
    if (endtype == "roundend") {
        if (winner == "tie") {
            outcometext = game.strings[#"draw"];
        } else if (isdefined(self.pers[#"team"]) && winner == team) {
            outcometext = game.strings[#"victory"];
            overridespectator = 1;
        } else {
            outcometext = game.strings[#"defeat"];
            if ((level.rankedmatch || level.leaguematch) && self.pers[#"latejoin"] === 1) {
                endreasontext = game.strings[#"join_in_progress_loss"];
            }
            overridespectator = 1;
        }
        notifyroundendtoui = 0;
        if (team == "spectator" && overridespectator) {
            foreach (team in level.teams) {
                if (endreasontext == game.strings[team + "_eliminated"]) {
                    endreasontext = game.strings[#"cod_caster_team_eliminated"];
                    break;
                }
            }
            outcometext = game.strings[#"cod_caster_team_wins"];
        }
        self luinotifyevent(#"show_outcome", 5, outcometext, endreasontext, int(matchbonus), winnerenum, notifyroundendtoui);
        return true;
    }
    return false;
}

// Namespace infect/infect
// Params 1, eflags: 0x0
// Checksum 0xcad04f41, Offset: 0x3ad0
// Size: 0x60
function function_7ce7fbed(player) {
    if (player.team === game.attackers) {
        playerweapon = player getcurrentweapon();
        if (isdefined(playerweapon.worldmodel)) {
            return playerweapon;
        }
    }
    return undefined;
}

// Namespace infect/infect
// Params 0, eflags: 0x0
// Checksum 0x7ba4c535, Offset: 0x3b38
// Size: 0x64
function function_93f386c5() {
    level endon(#"game_ended");
    level notify(#"hash_674fa4643cd81a8c");
    level endon(#"hash_674fa4643cd81a8c");
    wait 30;
    forcespawnteam(game.defenders);
}

// Namespace infect/infect
// Params 1, eflags: 0x0
// Checksum 0xe148ba7b, Offset: 0x3ba8
// Size: 0x2c
function function_e7129db9(weaponitem) {
    weaponitem hidefromteam(game.attackers);
}

