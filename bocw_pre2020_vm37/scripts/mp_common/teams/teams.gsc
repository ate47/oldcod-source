#using scripts\core_common\callbacks_shared;
#using scripts\core_common\gamestate;
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
// Checksum 0x74c2180f, Offset: 0xd0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"teams", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace teams/teams
// Params 0, eflags: 0x5 linked
// Checksum 0x39d4395d, Offset: 0x118
// Size: 0x4c
function private function_70a657d8() {
    callback::on_start_gametype(&init);
    level.getenemyteam = &getenemyteam;
    level.use_team_based_logic_for_locking_on = 1;
}

// Namespace teams/teams
// Params 0, eflags: 0x1 linked
// Checksum 0x6a74da96, Offset: 0x170
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
// Params 0, eflags: 0x1 linked
// Checksum 0x1e2c6d3a, Offset: 0x338
// Size: 0x1c
function on_player_connect() {
    self init_played_time();
}

// Namespace teams/teams
// Params 0, eflags: 0x1 linked
// Checksum 0x88857893, Offset: 0x360
// Size: 0x1c
function on_free_player_connect() {
    self thread track_free_played_time();
}

// Namespace teams/teams
// Params 1, eflags: 0x1 linked
// Checksum 0x9e9114f8, Offset: 0x388
// Size: 0x24
function on_joined_team(*params) {
    self update_time();
}

// Namespace teams/teams
// Params 1, eflags: 0x1 linked
// Checksum 0x7e9046b, Offset: 0x3b8
// Size: 0x24
function on_joined_spectators(*params) {
    self.pers[#"teamtime"] = undefined;
}

// Namespace teams/teams
// Params 0, eflags: 0x1 linked
// Checksum 0x4cbcc3df, Offset: 0x3e8
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
// Params 0, eflags: 0x1 linked
// Checksum 0x955e26ce, Offset: 0x4b8
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
// Params 0, eflags: 0x1 linked
// Checksum 0xef49cc12, Offset: 0x5b8
// Size: 0x68
function function_badbaae6() {
    level endon(#"game_ended");
    while (level.inprematchperiod) {
        waitframe(1);
    }
    for (;;) {
        if (game.state == "playing") {
            function_351a57a9();
        }
        wait 1;
    }
}

// Namespace teams/teams
// Params 0, eflags: 0x1 linked
// Checksum 0x4ddf9e39, Offset: 0x628
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
// Params 0, eflags: 0x1 linked
// Checksum 0xd4dec6a2, Offset: 0x6a0
// Size: 0x4a4
function update_played_time() {
    pixbeginevent(#"updateplayedtime");
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
    pixendevent();
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
// Params 0, eflags: 0x1 linked
// Checksum 0xacab2a8b, Offset: 0xb50
// Size: 0x34
function update_time() {
    if (game.state != "playing") {
        return;
    }
    self.pers[#"teamtime"] = gettime();
}

// Namespace teams/teams
// Params 0, eflags: 0x1 linked
// Checksum 0xb6830c5e, Offset: 0xb90
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
// Checksum 0x3535da7e, Offset: 0xc00
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
// Params 0, eflags: 0x1 linked
// Checksum 0xf842bcd6, Offset: 0xd80
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
// Params 0, eflags: 0x1 linked
// Checksum 0x7c7053a7, Offset: 0xf00
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
        if (game.state == "playing") {
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
// Params 1, eflags: 0x1 linked
// Checksum 0xc0858d12, Offset: 0x1138
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
// Params 1, eflags: 0x1 linked
// Checksum 0xf5276992, Offset: 0x11b0
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
// Params 0, eflags: 0x1 linked
// Checksum 0x2d8c65a2, Offset: 0x1280
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
// Checksum 0x4b66cb9d, Offset: 0x13c8
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
// Checksum 0x9431547d, Offset: 0x14d8
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
// Params 7, eflags: 0x1 linked
// Checksum 0xb6968e85, Offset: 0x15b0
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
// Params 0, eflags: 0x1 linked
// Checksum 0xf1af823, Offset: 0x16a8
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
// Params 1, eflags: 0x1 linked
// Checksum 0x7b1d872b, Offset: 0x1728
// Size: 0x1c
function function_9dd75dad(team) {
    return level.everexisted[team];
}

// Namespace teams/teams
// Params 1, eflags: 0x1 linked
// Checksum 0xcd5938db, Offset: 0x1750
// Size: 0x80
function is_all_dead(team) {
    if (level.numteamlives > 0 && !level.var_c2cc011f && game.lives[team] > 0) {
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
// Params 0, eflags: 0x1 linked
// Checksum 0xabf2b0f8, Offset: 0x17d8
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
// Checksum 0xceb74ee1, Offset: 0x1950
// Size: 0x64
function get_flag_model(teamref) {
    assert(isdefined(game.flagmodels));
    assert(isdefined(game.flagmodels[teamref]));
    return game.flagmodels[teamref];
}

// Namespace teams/teams
// Params 1, eflags: 0x0
// Checksum 0x7c81421c, Offset: 0x19c0
// Size: 0x64
function get_flag_carry_model(teamref) {
    assert(isdefined(game.carry_flagmodels));
    assert(isdefined(game.carry_flagmodels[teamref]));
    return game.carry_flagmodels[teamref];
}

// Namespace teams/teams
// Params 1, eflags: 0x0
// Checksum 0xd44d1875, Offset: 0x1a30
// Size: 0x64
function function_fd110460(teamref) {
    assert(isdefined(game.carry_icon));
    assert(isdefined(game.carry_icon[teamref]));
    return game.carry_icon[teamref];
}

