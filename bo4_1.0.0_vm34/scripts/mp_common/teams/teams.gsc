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
// Params 0, eflags: 0x2
// Checksum 0xe100c2cc, Offset: 0xd0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"teams", &__init__, undefined, undefined);
}

// Namespace teams/teams
// Params 0, eflags: 0x0
// Checksum 0xb12ec748, Offset: 0x118
// Size: 0x4e
function __init__() {
    callback::on_start_gametype(&init);
    level.getenemyteam = &getenemyteam;
    level.use_team_based_logic_for_locking_on = 1;
}

// Namespace teams/teams
// Params 0, eflags: 0x0
// Checksum 0x16deec25, Offset: 0x170
// Size: 0x1a4
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
        return;
    }
    callback::on_connect(&on_free_player_connect);
    wait 0.15;
    level thread update_player_times();
}

// Namespace teams/teams
// Params 0, eflags: 0x0
// Checksum 0x90b11a21, Offset: 0x320
// Size: 0x1c
function on_player_connect() {
    self thread function_e7a40e44();
}

// Namespace teams/teams
// Params 0, eflags: 0x0
// Checksum 0xdb684e0d, Offset: 0x348
// Size: 0x1c
function on_free_player_connect() {
    self thread track_free_played_time();
}

// Namespace teams/teams
// Params 1, eflags: 0x0
// Checksum 0x40da568b, Offset: 0x370
// Size: 0x5c
function on_joined_team(params) {
    println("<dev string:x30>" + self.pers[#"team"]);
    self update_time();
}

// Namespace teams/teams
// Params 1, eflags: 0x0
// Checksum 0xb2fb621e, Offset: 0x3d8
// Size: 0x24
function on_joined_spectators(params) {
    self.pers[#"teamtime"] = undefined;
}

// Namespace teams/teams
// Params 0, eflags: 0x0
// Checksum 0xb02f1ae8, Offset: 0x408
// Size: 0x294
function function_e7a40e44() {
    self endon(#"disconnect");
    if (!isdefined(self.pers[#"totaltimeplayed"])) {
        self.pers[#"totaltimeplayed"] = 0;
    }
    self.timeplayed[#"free"] = 0;
    self.timeplayed[#"other"] = 0;
    self.timeplayed[#"alive"] = 0;
    if (!isdefined(self.timeplayed[#"total"]) || !(level.gametype == "twar" && 0 < game.roundsplayed && 0 < self.timeplayed[#"total"])) {
        self.timeplayed[#"total"] = 0;
    }
    while (level.inprematchperiod) {
        waitframe(1);
    }
    for (;;) {
        if (game.state == "playing") {
            if (isdefined(level.teams[self.sessionteam])) {
                if (!isdefined(self.timeplayed[self.sessionteam])) {
                    self.timeplayed[self.sessionteam] = 0;
                }
                self.timeplayed[self.sessionteam]++;
                self.timeplayed[#"total"]++;
                if (level.mpcustommatch) {
                    self.pers[#"sbtimeplayed"] = self.timeplayed[#"total"];
                    self.sbtimeplayed = self.pers[#"sbtimeplayed"];
                }
                if (isalive(self)) {
                    self.timeplayed[#"alive"]++;
                }
            } else if (self.sessionteam == #"spectator") {
                self.timeplayed[#"other"]++;
            }
        }
        wait 1;
    }
}

// Namespace teams/teams
// Params 0, eflags: 0x0
// Checksum 0x6d6b91fd, Offset: 0x6a8
// Size: 0x78
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
// Checksum 0xd6fc1248, Offset: 0x728
// Size: 0x3ee
function update_played_time() {
    pixbeginevent(#"updateplayedtime");
    foreach (team, str_team in level.teams) {
        if (isdefined(self.timeplayed[team]) && self.timeplayed[team]) {
            time = int(min(self.timeplayed[team], level.timeplayedcap));
            if (sessionmodeismultiplayergame() && level.teambased) {
                self stats::function_b48aa4e(#"time_played_" + str_team, time);
            }
            self stats::function_2dabbec7(#"time_played_total", time);
        }
    }
    if (self.timeplayed[#"other"]) {
        time = int(min(self.timeplayed[#"other"], level.timeplayedcap));
        self stats::function_b48aa4e(#"time_played_other", time);
        self stats::function_2dabbec7(#"time_played_other", time);
    }
    if (self.timeplayed[#"alive"]) {
        timealive = int(min(self.timeplayed[#"alive"], level.timeplayedcap));
        self stats::function_b48aa4e(#"time_played_alive", timealive);
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
// Params 0, eflags: 0x0
// Checksum 0xdaf85672, Offset: 0xb20
// Size: 0x36
function update_time() {
    if (game.state != "playing") {
        return;
    }
    self.pers[#"teamtime"] = gettime();
}

// Namespace teams/teams
// Params 0, eflags: 0x0
// Checksum 0xf3f8d44, Offset: 0xb60
// Size: 0x68
function update_balance_dvar() {
    for (;;) {
        level.teambalance = getdvarint(#"scr_teambalance", 0);
        level.timeplayedcap = getdvarint(#"scr_timeplayedcap", 1800);
        wait 1;
    }
}

// Namespace teams/teams
// Params 1, eflags: 0x0
// Checksum 0xb495b22c, Offset: 0xbd0
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
// Checksum 0xe33621ac, Offset: 0xd50
// Size: 0x158
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
// Checksum 0xcbc9bd83, Offset: 0xeb0
// Size: 0x21c
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
// Params 1, eflags: 0x0
// Checksum 0xb89945ee, Offset: 0x10d8
// Size: 0x64
function get_flag_model(teamref) {
    assert(isdefined(game.flagmodels));
    assert(isdefined(game.flagmodels[teamref]));
    return game.flagmodels[teamref];
}

// Namespace teams/teams
// Params 1, eflags: 0x0
// Checksum 0x43647767, Offset: 0x1148
// Size: 0x64
function get_flag_carry_model(teamref) {
    assert(isdefined(game.carry_flagmodels));
    assert(isdefined(game.carry_flagmodels[teamref]));
    return game.carry_flagmodels[teamref];
}

// Namespace teams/teams
// Params 1, eflags: 0x0
// Checksum 0x22aff028, Offset: 0x11b8
// Size: 0x70
function getteamindex(team) {
    if (!isdefined(team)) {
        return 0;
    }
    if (team == #"free") {
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
// Checksum 0xcafbf196, Offset: 0x1230
// Size: 0xba
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
// Checksum 0x1a076034, Offset: 0x12f8
// Size: 0x138
function getenemyplayers() {
    enemies = [];
    foreach (player in level.players) {
        if (player.team == #"spectator") {
            continue;
        }
        if (level.teambased && player.team != self.team || !level.teambased && player != self) {
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
// Checksum 0xee936c5, Offset: 0x1438
// Size: 0xf0
function getfriendlyplayers() {
    friendlies = [];
    foreach (player in level.players) {
        if (player.team == self.team && player != self) {
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
// Checksum 0x47460113, Offset: 0x1530
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
// Checksum 0xb79cf13b, Offset: 0x1608
// Size: 0xe2
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
// Checksum 0x652690d1, Offset: 0x16f8
// Size: 0x64
function hidetosameteam() {
    if (level.teambased) {
        self setvisibletoallexceptteam(self.team);
        return;
    }
    self setvisibletoall();
    self setinvisibletoplayer(self.owner);
}

