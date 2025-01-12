#using scripts\core_common\callbacks_shared;
#using scripts\core_common\hud_message_shared;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\gametypes\globallogic;
#using scripts\zm_common\gametypes\globallogic_player;
#using scripts\zm_common\gametypes\spectating;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_loadout;

#namespace globallogic_ui;

// Namespace globallogic_ui/globallogic_ui
// Params 0, eflags: 0x6
// Checksum 0xe585cdd9, Offset: 0x120
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"globallogic_ui", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace globallogic_ui/globallogic_ui
// Params 0, eflags: 0x5 linked
// Checksum 0x80f724d1, Offset: 0x168
// Size: 0x4
function private function_70a657d8() {
    
}

// Namespace globallogic_ui/globallogic_ui
// Params 0, eflags: 0x0
// Checksum 0x2d0ec685, Offset: 0x178
// Size: 0x7c
function setupcallbacks() {
    level.autoassign = &menuautoassign;
    level.spectator = &menuspectator;
    level.curclass = &zm_loadout::menuclass;
    level.teammenu = &menuteam;
    level.autocontrolplayer = &menuautocontrolplayer;
}

/#

    // Namespace globallogic_ui/globallogic_ui
    // Params 0, eflags: 0x0
    // Checksum 0x67f35ac8, Offset: 0x200
    // Size: 0x27c
    function freegameplayhudelems() {
        if (isdefined(self.perkicon)) {
            for (numspecialties = 0; numspecialties < level.maxspecialties; numspecialties++) {
                if (isdefined(self.perkicon[numspecialties])) {
                    self.perkicon[numspecialties] hud::destroyelem();
                    self.perkname[numspecialties] hud::destroyelem();
                }
            }
        }
        if (isdefined(self.perkhudelem)) {
            self.perkhudelem hud::destroyelem();
        }
        if (isdefined(self.killstreakicon)) {
            if (isdefined(self.killstreakicon[0])) {
                self.killstreakicon[0] hud::destroyelem();
            }
            if (isdefined(self.killstreakicon[1])) {
                self.killstreakicon[1] hud::destroyelem();
            }
            if (isdefined(self.killstreakicon[2])) {
                self.killstreakicon[2] hud::destroyelem();
            }
            if (isdefined(self.killstreakicon[3])) {
                self.killstreakicon[3] hud::destroyelem();
            }
            if (isdefined(self.killstreakicon[4])) {
                self.killstreakicon[4] hud::destroyelem();
            }
        }
        if (isdefined(self.lowermessage)) {
            self.lowermessage hud::destroyelem();
        }
        if (isdefined(self.lowertimer)) {
            self.lowertimer hud::destroyelem();
        }
        if (isdefined(self.proxbar)) {
            self.proxbar hud::destroyelem();
        }
        if (isdefined(self.proxbartext)) {
            self.proxbartext hud::destroyelem();
        }
        if (isdefined(self.carryicon)) {
            self.carryicon hud::destroyelem();
        }
    }

#/

// Namespace globallogic_ui/globallogic_ui
// Params 1, eflags: 0x0
// Checksum 0x491d6a11, Offset: 0x488
// Size: 0xb6
function teamplayercountsequal(playercounts) {
    count = undefined;
    foreach (team, _ in level.teams) {
        if (!isdefined(count)) {
            count = playercounts[team];
            continue;
        }
        if (count != playercounts[team]) {
            return false;
        }
    }
    return true;
}

// Namespace globallogic_ui/globallogic_ui
// Params 2, eflags: 0x0
// Checksum 0xf1e9f4f4, Offset: 0x548
// Size: 0xc4
function teamwithlowestplayercount(playercounts, *ignore_team) {
    count = 9999;
    lowest_team = undefined;
    foreach (team, _ in level.teams) {
        if (count > ignore_team[team]) {
            count = ignore_team[team];
            lowest_team = team;
        }
    }
    return lowest_team;
}

// Namespace globallogic_ui/globallogic_ui
// Params 1, eflags: 0x1 linked
// Checksum 0xd65972e7, Offset: 0x618
// Size: 0x564
function menuautoassign(comingfrommenu) {
    teamkeys = getarraykeys(level.teams);
    assignment = teamkeys[randomint(teamkeys.size)];
    self closemenus();
    if (isdefined(level.forceallallies) && level.forceallallies) {
        assignment = #"allies";
    } else if (level.teambased) {
        if (getdvarint(#"party_autoteams", 0) == 1) {
            if (level.allow_teamchange && (self.hasspawned || comingfrommenu)) {
                assignment = "";
            } else {
                team = getassignedteam(self);
                switch (team) {
                case 1:
                    assignment = teamkeys[1];
                    break;
                case 2:
                    assignment = teamkeys[0];
                    break;
                case 3:
                    assignment = teamkeys[2];
                    break;
                case 4:
                    if (!isdefined(level.forceautoassign) || !level.forceautoassign) {
                        return;
                    }
                default:
                    assignment = "";
                    if (isdefined(level.teams[team])) {
                        assignment = team;
                    } else if (team == "spectator" && !level.forceautoassign) {
                        return;
                    }
                    break;
                }
            }
        }
        if (assignment == "" || getdvarint(#"party_autoteams", 0) == 0) {
            assignment = #"allies";
        }
        if (assignment == self.pers[#"team"] && (self.sessionstate == "playing" || self.sessionstate == "dead")) {
            self beginclasschoice();
            return;
        }
    } else if (getdvarint(#"party_autoteams", 0) == 1) {
        if (!level.allow_teamchange || !self.hasspawned && !comingfrommenu) {
            team = getassignedteam(self);
            if (isdefined(level.teams[team])) {
                assignment = team;
            } else if (team == "spectator" && !level.forceautoassign) {
                return;
            }
        }
    }
    if (isdefined(self.botteam) && self.botteam != "autoassign") {
        assignment = self.botteam;
    }
    if (assignment != self.pers[#"team"] && (self.sessionstate == "playing" || self.sessionstate == "dead")) {
        self.switching_teams = 1;
        self.joining_team = assignment;
        self.leaving_team = self.pers[#"team"];
        self suicide();
    }
    self.pers[#"team"] = assignment;
    self.team = assignment;
    self.pers[#"class"] = undefined;
    self.curclass = undefined;
    self.pers[#"weapon"] = undefined;
    self.pers[#"savedmodel"] = undefined;
    self updateobjectivetext();
    self.sessionteam = assignment;
    if (!isalive(self)) {
        self.statusicon = "hud_status_dead";
    }
    self player::function_466d8a4b(comingfrommenu);
    self notify(#"end_respawn");
    self beginclasschoice();
}

// Namespace globallogic_ui/globallogic_ui
// Params 0, eflags: 0x1 linked
// Checksum 0xdf638bd9, Offset: 0xb88
// Size: 0xcc
function teamscoresequal() {
    score = undefined;
    foreach (team, _ in level.teams) {
        if (!isdefined(score)) {
            score = getteamscore(team);
            continue;
        }
        if (score != getteamscore(team)) {
            return false;
        }
    }
    return true;
}

// Namespace globallogic_ui/globallogic_ui
// Params 0, eflags: 0x1 linked
// Checksum 0xe2960cd6, Offset: 0xc60
// Size: 0xbe
function teamwithlowestscore() {
    score = 99999999;
    lowest_team = undefined;
    foreach (team, _ in level.teams) {
        if (score > getteamscore(team)) {
            lowest_team = team;
        }
    }
    return lowest_team;
}

// Namespace globallogic_ui/globallogic_ui
// Params 1, eflags: 0x0
// Checksum 0x25cdfb8d, Offset: 0xd28
// Size: 0x7a
function pickteamfromscores(teams) {
    assignment = #"allies";
    if (teamscoresequal()) {
        assignment = teams[randomint(teams.size)];
    } else {
        assignment = teamwithlowestscore();
    }
    return assignment;
}

// Namespace globallogic_ui/globallogic_ui
// Params 0, eflags: 0x0
// Checksum 0x984919de, Offset: 0xdb0
// Size: 0xca
function getsplitscreenteam() {
    for (index = 0; index < level.players.size; index++) {
        if (!isdefined(level.players[index])) {
            continue;
        }
        if (level.players[index] == self) {
            continue;
        }
        if (!self isplayeronsamemachine(level.players[index])) {
            continue;
        }
        team = level.players[index].sessionteam;
        if (team != "spectator") {
            return team;
        }
    }
    return "";
}

// Namespace globallogic_ui/globallogic_ui
// Params 0, eflags: 0x1 linked
// Checksum 0xb1524a0c, Offset: 0xe88
// Size: 0x24
function updateobjectivetext() {
    self setclientcgobjectivetext("");
}

// Namespace globallogic_ui/globallogic_ui
// Params 0, eflags: 0x1 linked
// Checksum 0x68b945ff, Offset: 0xeb8
// Size: 0x1c
function closemenus() {
    self closeingamemenu();
}

// Namespace globallogic_ui/globallogic_ui
// Params 1, eflags: 0x1 linked
// Checksum 0xb06525a9, Offset: 0xee0
// Size: 0xfc
function beginclasschoice(*forcenewchoice) {
    assert(isdefined(level.teams[self.pers[#"team"]]));
    team = self.pers[#"team"];
    self.pers[#"class"] = level.defaultclass;
    self.curclass = level.defaultclass;
    if (self.sessionstate != "playing" && game.state == "playing") {
        self thread [[ level.spawnclient ]]();
    }
    self thread spectating::setspectatepermissionsformachine();
}

// Namespace globallogic_ui/globallogic_ui
// Params 0, eflags: 0x0
// Checksum 0xe03d5d4a, Offset: 0xfe8
// Size: 0x9c
function showmainmenuforteam() {
    assert(isdefined(level.teams[self.pers[#"team"]]));
    team = self.pers[#"team"];
    self openmenu(game.menu["menu_changeclass_" + level.teams[team]]);
}

// Namespace globallogic_ui/globallogic_ui
// Params 0, eflags: 0x1 linked
// Checksum 0x3af0e31c, Offset: 0x1090
// Size: 0x54
function menuautocontrolplayer() {
    self closemenus();
    if (self.pers[#"team"] != "spectator") {
        toggleplayercontrol(self);
    }
}

// Namespace globallogic_ui/globallogic_ui
// Params 1, eflags: 0x1 linked
// Checksum 0x7359dbfd, Offset: 0x10f0
// Size: 0x204
function menuteam(team) {
    self closemenus();
    if (!level.console && !level.allow_teamchange && isdefined(self.hasdonecombat) && self.hasdonecombat) {
        return;
    }
    if (self.pers[#"team"] != team) {
        if (level.ingraceperiod && (!isdefined(self.hasdonecombat) || !self.hasdonecombat)) {
            self.hasspawned = 0;
        }
        if (self.sessionstate == "playing") {
            self.switching_teams = 1;
            self.joining_team = team;
            self.leaving_team = self.pers[#"team"];
            self suicide();
        }
        self.pers[#"team"] = team;
        self.team = team;
        self.pers[#"class"] = undefined;
        self.curclass = undefined;
        self.pers[#"weapon"] = undefined;
        self.pers[#"savedmodel"] = undefined;
        self updateobjectivetext();
        self.sessionteam = team;
        self player::function_466d8a4b(1);
        self notify(#"end_respawn");
    }
    self beginclasschoice();
}

// Namespace globallogic_ui/globallogic_ui
// Params 0, eflags: 0x1 linked
// Checksum 0x7c35e042, Offset: 0x1300
// Size: 0x18e
function menuspectator() {
    self closemenus();
    if (self.pers[#"team"] != "spectator") {
        if (isalive(self)) {
            self.switching_teams = 1;
            self.joining_team = "spectator";
            self.leaving_team = self.pers[#"team"];
            self suicide();
        }
        self.pers[#"team"] = "spectator";
        self.team = "spectator";
        self.pers[#"class"] = undefined;
        self.curclass = undefined;
        self.pers[#"weapon"] = undefined;
        self.pers[#"savedmodel"] = undefined;
        self updateobjectivetext();
        self.sessionteam = "spectator";
        [[ level.spawnspectator ]]();
        self thread globallogic_player::spectate_player_watcher();
        self notify(#"joined_spectators");
    }
}

// Namespace globallogic_ui/globallogic_ui
// Params 1, eflags: 0x0
// Checksum 0xa72d8d70, Offset: 0x1498
// Size: 0x24
function menuclass(*response) {
    self closemenus();
}

// Namespace globallogic_ui/globallogic_ui
// Params 1, eflags: 0x0
// Checksum 0xd6d1cbe, Offset: 0x14c8
// Size: 0x54
function removespawnmessageshortly(delay) {
    self endon(#"disconnect");
    waittillframeend();
    self endon(#"end_respawn");
    wait delay;
    self hud_message::clearlowermessage();
}
