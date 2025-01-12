#using scripts\core_common\gamestate;
#using scripts\core_common\hud_message_shared;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\player\player_role;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\spectating;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\mp_common\bots\mp_bot;
#using scripts\mp_common\draft;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\player\player;
#using scripts\mp_common\player\player_loadout;
#using scripts\mp_common\teams\teams;
#using scripts\mp_common\userspawnselection;
#using scripts\mp_common\util;

#namespace globallogic_ui;

// Namespace globallogic_ui/globallogic_ui
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x178
// Size: 0x4
function init() {
    
}

// Namespace globallogic_ui/globallogic_ui
// Params 0, eflags: 0x0
// Checksum 0x7a56531e, Offset: 0x188
// Size: 0xd6
function setupcallbacks() {
    level.autoassign = &menuautoassign;
    level.spectator = &menuspectator;
    level.curclass = &menuclass;
    level.specialistmenu = &menuspecialist;
    level.teammenu = &menuteam;
    level.draftmenu = &menupositiondraft;
    level.autocontrolplayer = &menuautocontrolplayer;
    if (!isdefined(level.var_8c85e786)) {
        level.var_8c85e786 = &function_4d024084;
    }
}

/#

    // Namespace globallogic_ui/globallogic_ui
    // Params 0, eflags: 0x0
    // Checksum 0xbb1aebdf, Offset: 0x268
    // Size: 0x284
    function freegameplayhudelems() {
        /#
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
        #/
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
// Checksum 0xde4ef48b, Offset: 0x4f8
// Size: 0xb2
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
// Checksum 0x7d93689b, Offset: 0x5b8
// Size: 0xc0
function teamwithlowestplayercount(playercounts, ignore_team) {
    count = 9999;
    lowest_team = undefined;
    foreach (team, _ in level.teams) {
        if (count > playercounts[team]) {
            count = playercounts[team];
            lowest_team = team;
        }
    }
    return lowest_team;
}

// Namespace globallogic_ui/globallogic_ui
// Params 1, eflags: 0x0
// Checksum 0x361fb86, Offset: 0x680
// Size: 0x10
function function_4d024084(player) {
    return true;
}

// Namespace globallogic_ui/globallogic_ui
// Params 2, eflags: 0x0
// Checksum 0x4c36ea5f, Offset: 0x698
// Size: 0xce
function function_8c85e786(teamname, comingfrommenu) {
    if (level.rankedmatch) {
        return false;
    }
    if (level.inprematchperiod) {
        return false;
    }
    if (teamname != "free") {
        return false;
    }
    if (comingfrommenu) {
        return false;
    }
    if (self ishost()) {
        return false;
    }
    if (level.forceautoassign) {
        return false;
    }
    if (isbot(self)) {
        return false;
    }
    if (self issplitscreen()) {
        return false;
    }
    if (![[ level.var_8c85e786 ]]()) {
        return false;
    }
    return true;
}

// Namespace globallogic_ui/globallogic_ui
// Params 2, eflags: 0x4
// Checksum 0xf164413c, Offset: 0x770
// Size: 0xb2
function private function_35b49340(original_team, new_team) {
    if (!isdefined(original_team) || original_team == #"spectator" || !isdefined(new_team)) {
        return;
    }
    if (game.everexisted[original_team] && !game.everexisted[new_team] && level.playerlives[original_team]) {
        game.everexisted[original_team] = 0;
        level.everexisted[original_team] = 0;
    }
}

// Namespace globallogic_ui/globallogic_ui
// Params 0, eflags: 0x0
// Checksum 0xd68fe52d, Offset: 0x830
// Size: 0x26
function get_assigned_team() {
    teamname = getassignedteamname(self);
}

// Namespace globallogic_ui/globallogic_ui
// Params 0, eflags: 0x0
// Checksum 0xb55c6f75, Offset: 0x860
// Size: 0x3a
function function_d3ea4dfe() {
    var_7fc46072 = util::gethostplayerforbots();
    if (isdefined(var_7fc46072)) {
        return var_7fc46072.team;
    }
    return "";
}

// Namespace globallogic_ui/globallogic_ui
// Params 0, eflags: 0x0
// Checksum 0xf5dc4118, Offset: 0x8a8
// Size: 0x7a
function function_e38c042c() {
    party = self getparty();
    return isbot(self) && isdefined(self.botteam) && self.botteam != "autoassign" && party.var_355bcaf8 <= 1;
}

// Namespace globallogic_ui/globallogic_ui
// Params 2, eflags: 0x0
// Checksum 0xa666dc43, Offset: 0x930
// Size: 0x1f0
function function_35df8e9b(team, team_players) {
    var_edab0d74 = [];
    /#
        var_da88f92 = getdvarint(#"hash_4cbf229ab691d987", 0);
    #/
    foreach (player in team_players) {
        party = player getparty();
        assert(party.var_355bcaf8 <= level.maxteamplayers);
        var_edab0d74[party.party_id] = party.fill ? party.var_355bcaf8 : level.maxteamplayers;
        /#
            if (var_da88f92) {
                var_edab0d74[party.party_id] = party.var_355bcaf8;
            }
        #/
    }
    var_a9f5bd20 = 0;
    foreach (count in var_edab0d74) {
        var_a9f5bd20 += count;
    }
    return level.maxteamplayers - var_a9f5bd20;
}

// Namespace globallogic_ui/globallogic_ui
// Params 1, eflags: 0x0
// Checksum 0x51c0b8b0, Offset: 0xb28
// Size: 0x13a
function function_c81e5c3a(team) {
    team_players = getplayers(team);
    if (team_players.size >= level.maxteamplayers) {
        return false;
    }
    available_spots = function_35df8e9b(team, team_players);
    party = self getparty();
    if (party.var_355bcaf8 > available_spots) {
        return false;
    }
    /#
        if (getdvarint(#"hash_2ffea48b89a9ff3f", 0) && self != getplayers()[0] && getplayers()[0].team == team && !isbot(self)) {
            return false;
        }
    #/
    return true;
}

// Namespace globallogic_ui/globallogic_ui
// Params 0, eflags: 0x0
// Checksum 0x9e6bdf34, Offset: 0xc70
// Size: 0xe2
function function_acc9eb63() {
    foreach (team in level.teams) {
        if (function_c81e5c3a(team)) {
            println("<dev string:x30>" + self.name + "<dev string:x54>" + team);
            /#
                function_d84bdfa6(team);
            #/
            return team;
        }
    }
    return #"spectator";
}

// Namespace globallogic_ui/globallogic_ui
// Params 1, eflags: 0x0
// Checksum 0x4250435, Offset: 0xd60
// Size: 0x1aa
function function_a6c278f(party) {
    assert(party.var_355bcaf8 <= level.maxteamplayers);
    foreach (member in party.party_members) {
        if (self == member) {
            continue;
        }
        if (member.team != "autoassign" && member.team != "spectate") {
            team_players = getplayers(member.team);
            if (team_players.size >= level.maxteamplayers) {
                break;
            }
            println("<dev string:x30>" + self.name + "<dev string:x54>" + member.team + "<dev string:x5e>" + member.name);
            /#
                function_d84bdfa6(member.team);
            #/
            return member.team;
        }
    }
    return function_acc9eb63();
}

// Namespace globallogic_ui/globallogic_ui
// Params 0, eflags: 0x4
// Checksum 0x12271d28, Offset: 0xf18
// Size: 0x170
function private function_a865079f() {
    if (function_e38c042c()) {
        return self.botteam;
    }
    teamkeys = getarraykeys(level.teams);
    assignment = teamkeys[randomint(teamkeys.size)];
    playercounts = self teams::count_players();
    if (teamplayercountsequal(playercounts)) {
        if (!level.splitscreen && self issplitscreen()) {
            assignment = self get_splitscreen_team();
            if (assignment == "") {
                assignment = pickteamfromscores(teamkeys);
            }
        } else {
            assignment = pickteamfromscores(teamkeys);
        }
    } else {
        assignment = teamwithlowestplayercount(playercounts, #"none");
    }
    assert(isdefined(assignment));
    return assignment;
}

// Namespace globallogic_ui/globallogic_ui
// Params 0, eflags: 0x4
// Checksum 0x4a49f660, Offset: 0x1090
// Size: 0xd0
function private function_2244e505() {
    if (function_e38c042c() && function_c81e5c3a(self.botteam)) {
        return self.botteam;
    }
    party = self getparty();
    if (isdefined(party) && party.var_355bcaf8 > 1) {
        assignment = function_a6c278f(party);
    } else {
        assignment = function_acc9eb63();
    }
    assert(isdefined(assignment));
    return assignment;
}

// Namespace globallogic_ui/globallogic_ui
// Params 0, eflags: 0x0
// Checksum 0xe4cfe812, Offset: 0x1168
// Size: 0x78
function function_84065614() {
    if (level.multiteam && level.maxteamplayers > 0) {
        assignment = function_2244e505();
    } else {
        assignment = function_a865079f();
    }
    assert(isdefined(assignment));
    return assignment;
}

// Namespace globallogic_ui/globallogic_ui
// Params 2, eflags: 0x0
// Checksum 0x7c1fbcad, Offset: 0x11e8
// Size: 0x5cc
function menuautoassign(comingfrommenu, var_697db1ee) {
    original_team = self.pers[#"team"];
    self luinotifyevent(#"clear_notification_queue");
    if (level.teambased) {
        if (!isdefined(var_697db1ee)) {
            teamname = getassignedteamname(self);
        } else {
            teamname = var_697db1ee;
        }
        if (teamname !== "free" && !comingfrommenu) {
            assignment = teamname;
        } else if (function_8c85e786(teamname, comingfrommenu)) {
            assignment = #"spectator";
        } else if (isdefined(level.forcedplayerteam) && !isbot(self)) {
            assignment = level.forcedplayerteam;
        } else {
            assignment = function_84065614();
            assert(isdefined(assignment));
        }
        if (assignment === self.pers[#"team"] && (self.sessionstate === "playing" || self.sessionstate === "dead")) {
            self beginclasschoice(0);
            return;
        }
    } else {
        if (!comingfrommenu) {
            assignment = var_697db1ee;
        } else {
            clientnum = self getentitynumber();
            count = 0;
            foreach (team, _ in level.teams) {
                if (team == "free") {
                    continue;
                }
                count++;
                if (count == clientnum + 1) {
                    assignment = team;
                    break;
                }
            }
        }
        if (self.sessionstate == "playing" || self.sessionstate == "dead") {
            return;
        }
    }
    /#
        assignmentoverride = getdvarstring(#"autoassignteam");
        if (assignmentoverride != "<dev string:x6b>" && (assignmentoverride != #"spectator" || !isbot(self))) {
            assignment = assignmentoverride;
        }
    #/
    assert(isdefined(assignment));
    if (assignment === #"spectator" && !level.forceautoassign) {
        self.pers[#"team"] = assignment;
        self.team = assignment;
        self.sessionteam = assignment;
        return;
    }
    if (assignment !== self.pers[#"team"] && (self.sessionstate == "playing" || self.sessionstate == "dead")) {
        self.switching_teams = 1;
        self.switchedteamsresetgadgets = 1;
        self.joining_team = assignment;
        self.leaving_team = self.pers[#"team"];
        self suicide();
    }
    self.pers[#"team"] = assignment;
    self.team = level.teams[assignment];
    self.pers[#"class"] = "";
    self.curclass = "";
    self.pers[#"weapon"] = undefined;
    self.pers[#"savedmodel"] = undefined;
    self updateobjectivetext();
    self.sessionteam = level.teams[assignment];
    if (!isalive(self)) {
        self.statusicon = "hud_status_dead";
    }
    function_35b49340(original_team, team);
    self player::function_c68794fe(comingfrommenu, team);
    self notify(#"end_respawn");
    self beginclasschoice(comingfrommenu);
    /#
        self function_a08425d9();
    #/
}

// Namespace globallogic_ui/globallogic_ui
// Params 0, eflags: 0x0
// Checksum 0x3ffae3a7, Offset: 0x17c0
// Size: 0xbc
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
// Params 0, eflags: 0x0
// Checksum 0xdf16e3cc, Offset: 0x1888
// Size: 0xae
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
// Checksum 0xb7d297ff, Offset: 0x1940
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
// Checksum 0xe6f40a5f, Offset: 0x19c8
// Size: 0xce
function get_splitscreen_team() {
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
        if (team != #"spectator") {
            return team;
        }
    }
    return "";
}

// Namespace globallogic_ui/globallogic_ui
// Params 0, eflags: 0x0
// Checksum 0x702c87d4, Offset: 0x1aa0
// Size: 0xec
function updateobjectivetext() {
    if (self.pers[#"team"] == #"spectator") {
        self setclientcgobjectivetext("");
        return;
    }
    if (level.scorelimit > 0 || level.roundscorelimit > 0) {
        self setclientcgobjectivetext(util::getobjectivescoretext(self.pers[#"team"]));
        return;
    }
    self setclientcgobjectivetext(util::getobjectivetext(self.pers[#"team"]));
}

// Namespace globallogic_ui/globallogic_ui
// Params 0, eflags: 0x0
// Checksum 0xcc2bde81, Offset: 0x1b98
// Size: 0x1c
function closemenus() {
    self closeingamemenu();
}

// Namespace globallogic_ui/globallogic_ui
// Params 1, eflags: 0x0
// Checksum 0xd0e19dff, Offset: 0x1bc0
// Size: 0x2f4
function beginclasschoice(comingfrommenu) {
    if (isbot(self)) {
        return;
    }
    assert(isdefined(level.teams[self.pers[#"team"]]));
    team = self.pers[#"team"];
    if (level.disableclassselection == 1 || getdvarint(#"migration_soak", 0) == 1) {
        self player_role::set(getdvarint(#"auto_select_character", 1));
        started_waiting = gettime();
        while (!self isstreamerready(-1, 1) && started_waiting + 90000 > gettime()) {
            waitframe(1);
        }
        self.pers[#"class"] = level.defaultclass;
        self.curclass = level.defaultclass;
        if (self.sessionstate != "playing" && (game.state == "playing" || game.state == "pregame")) {
            self thread [[ level.spawnclient ]]();
        }
        level thread globallogic::updateteamstatus();
        self thread spectating::set_permissions_for_machine();
        return;
    }
    util::wait_network_frame();
    if (!draft::is_enabled() || comingfrommenu || !level.inprematchperiod) {
        [[ level.spawnspectator ]]();
        self userspawnselection::closespawnselect();
        self userspawnselection::clearcacheforplayer();
        self draft::clear_cooldown();
        if (comingfrommenu || !player_role::is_valid(player_role::get())) {
            self draft::open();
        }
    }
}

// Namespace globallogic_ui/globallogic_ui
// Params 0, eflags: 0x0
// Checksum 0xdf6fe375, Offset: 0x1ec0
// Size: 0x8c
function showmainmenuforteam() {
    assert(isdefined(level.teams[self.pers[#"team"]]));
    team = self.pers[#"team"];
    [[ level.spawnspectator ]]();
    self draft::open();
}

// Namespace globallogic_ui/globallogic_ui
// Params 1, eflags: 0x0
// Checksum 0x32d13e06, Offset: 0x1f58
// Size: 0x2bc
function menuteam(team) {
    if (!level.console && !level.allow_teamchange && isdefined(self.hasdonecombat) && self.hasdonecombat) {
        return;
    }
    if (self.pers[#"team"] != team) {
        function_35b49340(self.pers[#"team"], team);
        if (level.ingraceperiod && (!isdefined(self.hasdonecombat) || !self.hasdonecombat)) {
            self.hasspawned = 0;
        }
        if (self.sessionstate == "playing") {
            self.switchedteamsresetgadgets = 1;
            self.joining_team = team;
            self.leaving_team = self.pers[#"team"];
            self suicide();
        }
        self userspawnselection::closespawnselect();
        self userspawnselection::clearcacheforplayer();
        self luinotifyevent(#"clear_notification_queue");
        self.switching_teams = 1;
        self.pers[#"team"] = team;
        self.team = team;
        self.pers[#"class"] = "";
        self.curclass = "";
        self.pers[#"weapon"] = undefined;
        self.pers[#"savedmodel"] = undefined;
        self updateobjectivetext();
        if (!level.rankedmatch && !level.leaguematch) {
            self.sessionstate = "spectator";
        }
        self.sessionteam = team;
        self player::function_c68794fe(1, team);
        self notify(#"end_respawn");
    }
    self beginclasschoice(1);
}

// Namespace globallogic_ui/globallogic_ui
// Params 0, eflags: 0x0
// Checksum 0xf669acf9, Offset: 0x2220
// Size: 0x1d4
function menuspectator() {
    self closemenus();
    if (self.pers[#"team"] != #"spectator") {
        if (isalive(self)) {
            self.switching_teams = 1;
            self.switchedteamsresetgadgets = 1;
            self.joining_team = #"spectator";
            self.leaving_team = self.pers[#"team"];
            self suicide();
        }
        self.pers[#"team"] = #"spectator";
        self.team = #"spectator";
        self.pers[#"class"] = "";
        self.curclass = "";
        self.pers[#"weapon"] = undefined;
        self.pers[#"savedmodel"] = undefined;
        self updateobjectivetext();
        self.sessionteam = #"spectator";
        [[ level.spawnspectator ]]();
        self thread player::spectate_player_watcher();
        self player::function_7da2050c(1);
    }
}

// Namespace globallogic_ui/globallogic_ui
// Params 4, eflags: 0x0
// Checksum 0xf6b14106, Offset: 0x2400
// Size: 0x578
function menuclass(response, forcedclass, updatecharacterindex, closemenus) {
    if (!isdefined(self.pers[#"team"]) || !isdefined(level.teams[self.pers[#"team"]])) {
        return 0;
    }
    if (!loadout::function_cd383ec5()) {
        if ((game.state == "pregame" || game.state == "playing") && self.sessionstate != "playing") {
            self thread [[ level.spawnclient ]](0);
        }
        return;
    }
    if (!isdefined(forcedclass)) {
        playerclass = self loadout::function_b30f6c7c(response);
    } else {
        playerclass = forcedclass;
    }
    self loadout::function_bc11a936(playerclass);
    if (!player_role::is_valid(self player_role::get())) {
        return 0;
    }
    if (isdefined(self.pers[#"class"]) && self.pers[#"class"] == playerclass) {
        return 1;
    }
    self.pers[#"changed_class"] = 1;
    self notify(#"changed_class");
    if (isdefined(self.curclass) && self.curclass == playerclass) {
        self.pers[#"changed_class"] = 0;
    }
    var_8b6a63ac = !isdefined(self.curclass) || self.curclass == "";
    self.pers[#"class"] = playerclass;
    self.curclass = playerclass;
    self loadout::function_bc11a936(playerclass);
    self.pers[#"weapon"] = undefined;
    if (gamestate::is_game_over()) {
        return 0;
    }
    if (self.sessionstate != "playing") {
        if (self.sessionstate != "spectator") {
            if (self isinvehicle()) {
                return 0;
            }
            if (self isremotecontrolling()) {
                return 0;
            }
            if (self isweaponviewonlylinked()) {
                return 0;
            }
        }
        if (self.sessionstate != "dead") {
            timepassed = undefined;
            if (isdefined(self.respawntimerstarttime)) {
                timepassed = float(gettime() - self.respawntimerstarttime) / 1000;
            }
            self thread [[ level.spawnclient ]](timepassed);
            self.respawntimerstarttime = undefined;
        }
    }
    if (self.sessionstate == "playing") {
        supplystationclasschange = isdefined(self.usingsupplystation) && self.usingsupplystation;
        self.usingsupplystation = 0;
        if (isdefined(level.ingraceperiod) && level.ingraceperiod && !(isdefined(self.hasdonecombat) && self.hasdonecombat) || isdefined(supplystationclasschange) && supplystationclasschange) {
            self loadout::function_e7e08814(self.pers[#"class"]);
            self.tag_stowed_back = undefined;
            self.tag_stowed_hip = undefined;
            self loadout::give_loadout(self.pers[#"team"], self.pers[#"class"]);
            self killstreaks::give_owned();
        } else if (!self issplitscreen() && !var_8b6a63ac && self.pers[#"changed_class"]) {
            self luinotifyevent(#"hash_6b67aa04e378d681", 1, 6);
        }
    }
    level thread globallogic::updateteamstatus();
    self thread spectating::set_permissions_for_machine();
    return 1;
}

// Namespace globallogic_ui/globallogic_ui
// Params 1, eflags: 0x0
// Checksum 0xdf48fddd, Offset: 0x2980
// Size: 0x2bc
function menuspecialist(characterindex) {
    self endon(#"disconnect");
    if (!isdefined(characterindex)) {
        println("<dev string:x6c>");
        return;
    }
    if (!draft::can_select_character(characterindex)) {
        return 0;
    }
    if (player_role::get() != characterindex) {
        self.pers[#"changed_specialist"] = 1;
        self.var_4d52496f = self getmpdialogname();
        self.pers[#"hash_1b145cf9f0673e9"] = function_b9650e7f(self player_role::get(), currentsessionmode());
    } else {
        self.pers[#"changed_specialist"] = 0;
    }
    spawns = self.pers[#"spawns"];
    self draft::select_character(characterindex, 0);
    specialist_name = getcharacterdisplayname(characterindex, currentsessionmode());
    iprintln(#"hash_52f20b5836b29e3", self, specialist_name);
    if (isdefined(self.pers[#"changed_specialist"]) && self.pers[#"changed_specialist"]) {
        self notify(#"changed_specialist_death");
    }
    if (game.state == "playing" && !userspawnselection::function_279204ca() && spawns != 0 && !(isdefined(level.var_f1294938) && level.var_f1294938)) {
        self suicide("MOD_META");
        waitframe(1);
    }
    if (isdefined(self)) {
        self luinotifyevent(#"hash_2dddf8559f5b304d", 1, 1);
    }
}

// Namespace globallogic_ui/globallogic_ui
// Params 0, eflags: 0x0
// Checksum 0x763ab1b8, Offset: 0x2c48
// Size: 0x5c
function menuautocontrolplayer() {
    self closemenus();
    if (self.pers[#"team"] != #"spectator") {
        toggleplayercontrol(self);
    }
}

// Namespace globallogic_ui/globallogic_ui
// Params 2, eflags: 0x0
// Checksum 0xf99c787e, Offset: 0x2cb0
// Size: 0x16c
function menupositiondraft(response, intpayload) {
    if (response == "changecharacter") {
        if (self draft::function_2cfc07fc()) {
            self player_role::clear();
        }
        return;
    }
    if (response == "randomcharacter") {
        self player_role::clear();
        draft::assign_remaining_players(self);
        if (!(isdefined(level.inprematchperiod) && level.inprematchperiod)) {
            self draft::close();
            if (!ispc()) {
                self closeingamemenu();
            }
        }
        return;
    }
    if (response == "ready") {
        self draft::client_ready();
        return;
    }
    if (response == "opendraft") {
        self draft::open();
        return;
    }
    if (response == "closedraft") {
        self draft::close();
    }
}

// Namespace globallogic_ui/globallogic_ui
// Params 1, eflags: 0x0
// Checksum 0x315b0690, Offset: 0x2e28
// Size: 0x54
function removespawnmessageshortly(delay) {
    self endon(#"disconnect");
    waittillframeend();
    self endon(#"end_respawn");
    wait delay;
    self hud_message::clearlowermessage();
}

/#

    // Namespace globallogic_ui/globallogic_ui
    // Params 1, eflags: 0x0
    // Checksum 0xdee98c0, Offset: 0x2e88
    // Size: 0xd0
    function function_c7827a2(party) {
        foreach (party_member in party.party_members) {
            var_2c208f19 = party_member getparty();
            if (var_2c208f19.var_355bcaf8 != party.var_355bcaf8) {
                assertmsg("<dev string:xa7>");
            }
        }
    }

    // Namespace globallogic_ui/globallogic_ui
    // Params 1, eflags: 0x0
    // Checksum 0x161b06ca, Offset: 0x2f60
    // Size: 0xb0
    function function_d84bdfa6(team) {
        players = getplayers(team);
        foreach (player in players) {
            function_c7827a2(player getparty());
        }
    }

    // Namespace globallogic_ui/globallogic_ui
    // Params 0, eflags: 0x0
    // Checksum 0xb46e0a0b, Offset: 0x3018
    // Size: 0x3fc
    function function_a08425d9() {
        if (level.multiteam && level.maxteamplayers > 0) {
            players = getplayers();
            foreach (team in level.teams) {
                var_d533f662 = getplayers(team);
                if (var_d533f662.size > level.maxteamplayers) {
                    var_2a4bbda9 = "<dev string:x6b>";
                    foreach (player in var_d533f662) {
                        party = player getparty();
                        var_2a4bbda9 = var_2a4bbda9 + player.name + "<dev string:xd8>" + party.party_id + "<dev string:xe3>";
                    }
                    assertmsg("<dev string:xe5>" + self.name + "<dev string:xf8>" + (ishash(team) ? function_15979fa9(team) : team) + "<dev string:x11b>" + var_d533f662.size + "<dev string:x12d>" + level.maxteamplayers + "<dev string:xe3>" + var_2a4bbda9);
                }
            }
            foreach (player in players) {
                if (player.team == #"spectator") {
                    continue;
                }
                party = player getparty();
                foreach (party_member in party.party_members) {
                    if (party_member.team == #"spectator") {
                        continue;
                    }
                    if (party_member.team != player.team) {
                        assertmsg("<dev string:x13b>" + player.name + "<dev string:x167>" + function_15979fa9(player.team) + "<dev string:x16a>" + party_member.name + "<dev string:x167>" + function_15979fa9(party_member.team) + "<dev string:x16d>");
                    }
                }
            }
        }
    }

#/
