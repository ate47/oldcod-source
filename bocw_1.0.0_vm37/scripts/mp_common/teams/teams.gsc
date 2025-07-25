#using scripts\core_common\callbacks_shared;
#using scripts\core_common\gamestate_util;
#using scripts\core_common\persistence_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\spectating;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\gametypes\globallogic_ui;
#using scripts\mp_common\util;

#namespace teams;

// Namespace teams/teams
// Params 0, eflags: 0x6
// Checksum 0x38782047, Offset: 0xd8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"teams", &preinit, undefined, undefined, undefined);
}

// Namespace teams/teams
// Params 0, eflags: 0x4
// Checksum 0x168bec31, Offset: 0x120
// Size: 0x4c
function private preinit() {
    callback::on_start_gametype(&init);
    level.getenemyteam = &getenemyteam;
    level.use_team_based_logic_for_locking_on = 1;
}

// Namespace teams/teams
// Params 0, eflags: 0x0
// Checksum 0x2c8c9b5e, Offset: 0x178
// Size: 0x1bc
function init() {
    game.strings[#"autobalance"] = #"mp/autobalance_now";
    level.teambalance = getdvarint(#"scr_teambalance", 0);
    level.teambalancetimer = 0;
    level.timeplayedcap = getdvarint(#"scr_timeplayedcap", 1800);
    level.freeplayers = [];
    if (level.teambased) {
        level.alliesplayers = [];
        level.axisplayers = [];
        callback::on_connect(&on_player_connect);
        callback::on_joined_team(&on_joined_team);
        callback::on_joined_spectate(&on_joined_spectators);
        level thread update_balance_dvar();
        wait 0.15;
        level thread update_player_times();
        level thread function_badbaae6();
        return;
    }
    callback::on_connect(&on_free_player_connect);
    wait 0.15;
    level thread update_player_times();
}

// Namespace teams/teams
// Params 0, eflags: 0x0
// Checksum 0x9996bc2a, Offset: 0x340
// Size: 0x1c
function on_player_connect() {
    self init_played_time();
}

// Namespace teams/teams
// Params 0, eflags: 0x0
// Checksum 0xfb49dc2a, Offset: 0x368
// Size: 0x1c
function on_free_player_connect() {
    self thread track_free_played_time();
}

// Namespace teams/teams
// Params 1, eflags: 0x0
// Checksum 0x3a6c977a, Offset: 0x390
// Size: 0x24
function on_joined_team(*params) {
    self update_time();
}

// Namespace teams/teams
// Params 1, eflags: 0x0
// Checksum 0x198e261f, Offset: 0x3c0
// Size: 0x24
function on_joined_spectators(*params) {
    self.pers[#"teamtime"] = undefined;
}

// Namespace teams/teams
// Params 0, eflags: 0x0
// Checksum 0xb806158a, Offset: 0x3f0
// Size: 0xc4
function function_45721cef() {
    foreach (team, _ in level.teams) {
        if (!isdefined(game.migratedhost)) {
            game.stat[#"teamscores"][team] = 0;
        }
        game.teamsuddendeath[team] = 0;
        game.totalkillsteam[team] = 0;
    }
}

// Namespace teams/teams
// Params 0, eflags: 0x0
// Checksum 0x37b92694, Offset: 0x4c0
// Size: 0xf4
function init_played_time() {
    if (!isdefined(self.pers[#"totaltimeplayed"])) {
        self.pers[#"totaltimeplayed"] = 0;
    }
    self.timeplayed[#"other"] = 0;
    self.timeplayed[#"alive"] = 0;
    if (!isdefined(self.timeplayed[#"total"]) || !(level.gametype == "twar" && 0 < game.roundsplayed && 0 < self.timeplayed[#"total"])) {
        self.timeplayed[#"total"] = 0;
    }
}

// Namespace teams/teams
// Params 0, eflags: 0x0
// Checksum 0x6145a62e, Offset: 0x5c0
// Size: 0x70
function function_badbaae6() {
    level endon(#"game_ended");
    while (level.inprematchperiod) {
        waitframe(1);
    }
    for (;;) {
        if (game.state == #"playing") {
            function_351a57a9();
        }
        wait 1;
    }
}

// Namespace teams/teams
// Params 0, eflags: 0x0
// Checksum 0x29816290, Offset: 0x638
// Size: 0x70
function update_player_times() {
    nexttoupdate = 0;
    for (;;) {
        nexttoupdate++;
        if (nexttoupdate >= level.players.size) {
            nexttoupdate = 0;
        }
        if (isdefined(level.players[nexttoupdate])) {
            level.players[nexttoupdate] update_played_time();
        }
        wait 1;
    }
}

// Namespace teams/teams
// Params 0, eflags: 0x0
// Checksum 0x62b3f827, Offset: 0x6b0
// Size: 0x48c
function update_played_time() {
    pixbeginevent(#"");
    foreach (team, str_team in level.teams) {
        if (isdefined(self.timeplayed[team]) && self.timeplayed[team]) {
            time = int(min(self.timeplayed[team], level.timeplayedcap));
            if (sessionmodeismultiplayergame()) {
                if (level.teambased) {
                    self stats::function_dad108fa(#"time_played_" + str_team, time);
                }
                if (is_true(level.hardcoremode)) {
                    hc_time_played = self stats::get_stat(#"playerstatslist", #"hc_time_played", #"statvalue") + time;
                    self stats::set_stat(#"playerstatslist", #"hc_time_played", #"statvalue", hc_time_played);
                }
            }
            self stats::function_bb7eedf0(#"time_played_total", time);
        }
    }
    if (self.timeplayed[#"other"]) {
        time = int(min(self.timeplayed[#"other"], level.timeplayedcap));
        self stats::function_dad108fa(#"time_played_other", time);
        self stats::function_bb7eedf0(#"time_played_other", time);
    }
    if (self.timeplayed[#"alive"]) {
        timealive = int(min(self.timeplayed[#"alive"], level.timeplayedcap));
        self stats::function_dad108fa(#"time_played_alive", timealive);
    }
    timealive = int(min(self.timeplayed[#"alive"], level.timeplayedcap));
    self.pers[#"time_played_alive"] = self.pers[#"time_played_alive"] + timealive;
    profilestop();
    if (gamestate::is_game_over()) {
        return;
    }
    foreach (team, _ in level.teams) {
        if (isdefined(self.timeplayed[team])) {
            self.timeplayed[team] = 0;
        }
    }
    self.timeplayed[#"other"] = 0;
    self.timeplayed[#"alive"] = 0;
}

// Namespace teams/teams
// Params 0, eflags: 0x0
// Checksum 0x728c6b67, Offset: 0xb48
// Size: 0x3c
function update_time() {
    if (game.state != #"playing") {
        return;
    }
    self.pers[#"teamtime"] = gettime();
}

// Namespace teams/teams
// Params 0, eflags: 0x0
// Checksum 0x9400025c, Offset: 0xb90
// Size: 0x66
function update_balance_dvar() {
    for (;;) {
        level.teambalance = getdvarint(#"scr_teambalance", 0);
        level.timeplayedcap = getdvarint(#"scr_timeplayedcap", 1800);
        wait 1;
    }
}

// Namespace teams/teams
// Params 1, eflags: 0x0
// Checksum 0x1edb27dc, Offset: 0xc00
// Size: 0x176
function change(team) {
    if (self.sessionstate != "dead") {
        self.switching_teams = 1;
        self.switchedteamsresetgadgets = 1;
        self.joining_team = team;
        self.leaving_team = self.pers[#"team"];
        self suicide();
    }
    self.pers[#"team"] = team;
    self.team = team;
    self.pers[#"spawnweapon"] = undefined;
    self.pers[#"savedmodel"] = undefined;
    self.pers[#"teamtime"] = undefined;
    self.sessionteam = self.pers[#"team"];
    self globallogic_ui::updateobjectivetext();
    self spectating::set_permissions();
    self openmenu(game.menu[#"menu_start_menu"]);
    self notify(#"end_respawn");
}

// Namespace teams/teams
// Params 0, eflags: 0x0
// Checksum 0x769964e9, Offset: 0xd80
// Size: 0x174
function count_players() {
    players = level.players;
    playercounts = [];
    foreach (team, _ in level.teams) {
        playercounts[team] = 0;
    }
    foreach (player in level.players) {
        if (player == self) {
            continue;
        }
        team = player.pers[#"team"];
        if (isdefined(team) && isdefined(level.teams[team])) {
            playercounts[team]++;
        }
    }
    return playercounts;
}

// Namespace teams/teams
// Params 0, eflags: 0x0
// Checksum 0xdf1e495e, Offset: 0xf00
// Size: 0x22c
function track_free_played_time() {
    self endon(#"disconnect");
    if (!isdefined(self.timeplayed)) {
        self.timeplayed = [];
    }
    foreach (team, _ in level.teams) {
        if (isdefined(self.timeplayed[team])) {
            self.timeplayed[team] = 0;
        }
    }
    self.timeplayed[#"other"] = 0;
    self.timeplayed[#"total"] = 0;
    self.timeplayed[#"alive"] = 0;
    for (;;) {
        if (game.state == #"playing") {
            team = self.pers[#"team"];
            if (isdefined(team) && isdefined(level.teams[team]) && self.sessionteam != #"spectator") {
                if (!isdefined(self.timeplayed[team])) {
                    self.timeplayed[team] = 0;
                }
                self.timeplayed[team]++;
                self.timeplayed[#"total"]++;
                if (isalive(self)) {
                    self.timeplayed[#"alive"]++;
                }
            } else {
                self.timeplayed[#"other"]++;
            }
        }
        wait 1;
    }
}

// Namespace teams/teams
// Params 1, eflags: 0x0
// Checksum 0x47548267, Offset: 0x1138
// Size: 0x70
function getteamindex(team) {
    if (!isdefined(team)) {
        return 0;
    }
    if (team == #"none") {
        return 0;
    }
    if (team == #"allies") {
        return 1;
    }
    if (team == #"axis") {
        return 2;
    }
    return 0;
}

// Namespace teams/teams
// Params 1, eflags: 0x0
// Checksum 0xc6d7f0a5, Offset: 0x11b0
// Size: 0xc2
function getenemyteam(player_team) {
    foreach (team, _ in level.teams) {
        if (team == player_team) {
            continue;
        }
        if (team == #"spectator") {
            continue;
        }
        return team;
    }
    return util::getotherteam(player_team);
}

// Namespace teams/teams
// Params 0, eflags: 0x0
// Checksum 0x6c1240e4, Offset: 0x1280
// Size: 0x13a
function getenemyplayers() {
    enemies = [];
    foreach (player in level.players) {
        if (player.team == #"spectator") {
            continue;
        }
        if (level.teambased && player util::isenemyteam(self.team) || !level.teambased && player != self) {
            if (!isdefined(enemies)) {
                enemies = [];
            } else if (!isarray(enemies)) {
                enemies = array(enemies);
            }
            enemies[enemies.size] = player;
        }
    }
    return enemies;
}

// Namespace teams/teams
// Params 0, eflags: 0x0
// Checksum 0xd9dae22c, Offset: 0x13c8
// Size: 0x102
function getfriendlyplayers() {
    friendlies = [];
    foreach (player in level.players) {
        if (!player util::isenemyteam(self.team) && player != self) {
            if (!isdefined(friendlies)) {
                friendlies = [];
            } else if (!isarray(friendlies)) {
                friendlies = array(friendlies);
            }
            friendlies[friendlies.size] = player;
        }
    }
    return friendlies;
}

// Namespace teams/teams
// Params 6, eflags: 0x0
// Checksum 0x11b4e133, Offset: 0x14d8
// Size: 0xca
function waituntilteamchange(player, callback, arg, end_condition1, end_condition2, end_condition3) {
    if (isdefined(end_condition1)) {
        self endon(end_condition1);
    }
    if (isdefined(end_condition2)) {
        self endon(end_condition2);
    }
    if (isdefined(end_condition3)) {
        self endon(end_condition3);
    }
    event = player waittill(#"joined_team", #"disconnect", #"joined_spectators");
    if (isdefined(callback)) {
        self [[ callback ]](arg, event);
    }
}

// Namespace teams/teams
// Params 7, eflags: 0x0
// Checksum 0x4e2cb070, Offset: 0x15b0
// Size: 0xea
function waituntilteamchangesingleton(player, singletonstring, callback, arg, end_condition1, end_condition2, end_condition3) {
    self notify(singletonstring);
    self endon(singletonstring);
    if (isdefined(end_condition1)) {
        self endon(end_condition1);
    }
    if (isdefined(end_condition2)) {
        self endon(end_condition2);
    }
    if (isdefined(end_condition3)) {
        self endon(end_condition3);
    }
    event = player waittill(#"joined_team", #"disconnect", #"joined_spectators");
    if (isdefined(callback)) {
        self thread [[ callback ]](arg, event);
    }
}

// Namespace teams/teams
// Params 0, eflags: 0x0
// Checksum 0x9e1f4413, Offset: 0x16a8
// Size: 0x74
function hidetosameteam() {
    if (isdefined(self)) {
        if (level.teambased) {
            self setvisibletoallexceptteam(self.team);
            return;
        }
        self setvisibletoall();
        if (isdefined(self.owner)) {
            self setinvisibletoplayer(self.owner);
        }
    }
}

// Namespace teams/teams
// Params 1, eflags: 0x0
// Checksum 0x5a377a2c, Offset: 0x1728
// Size: 0x1c
function function_9dd75dad(team) {
    return level.everexisted[team];
}

// Namespace teams/teams
// Params 1, eflags: 0x0
// Checksum 0x90d347f2, Offset: 0x1750
// Size: 0x88
function is_all_dead(team) {
    if (level.numteamlives > 0 && !level.spawnsystem.var_c2cc011f && game.lives[team] > 0) {
        return false;
    }
    if (level.playerlives[team]) {
        return false;
    }
    if (function_a1ef346b(team).size) {
        return false;
    }
    return true;
}

// Namespace teams/teams
// Params 0, eflags: 0x0
// Checksum 0x28efa1d5, Offset: 0x17e0
// Size: 0x170
function function_596bfb16() {
    foreach (team, _ in level.teams) {
        if (function_a1ef346b(team).size) {
            game.everexisted[team] = 1;
            level.var_4ad4bec3 = 1;
            if (level.everexisted[team] == 0) {
                level.everexisted[team] = gettime();
            }
        }
    }
    /#
        if (getdvarint(#"hash_79f55d595a926104", 0)) {
            foreach (team, _ in level.teams) {
                game.everexisted[team] = 0;
                level.everexisted[team] = 0;
            }
        }
    #/
}

// Namespace teams/teams
// Params 1, eflags: 0x0
// Checksum 0x81757ede, Offset: 0x1958
// Size: 0x64
function get_flag_model(teamref) {
    assert(isdefined(game.flagmodels));
    assert(isdefined(game.flagmodels[teamref]));
    return game.flagmodels[teamref];
}

// Namespace teams/teams
// Params 1, eflags: 0x0
// Checksum 0x975e36a5, Offset: 0x19c8
// Size: 0x64
function get_flag_carry_model(teamref) {
    assert(isdefined(game.carry_flagmodels));
    assert(isdefined(game.carry_flagmodels[teamref]));
    return game.carry_flagmodels[teamref];
}

// Namespace teams/teams
// Params 1, eflags: 0x0
// Checksum 0x7bec6b34, Offset: 0x1a38
// Size: 0x64
function function_fd110460(teamref) {
    assert(isdefined(game.carry_icon));
    assert(isdefined(game.carry_icon[teamref]));
    return game.carry_icon[teamref];
}

