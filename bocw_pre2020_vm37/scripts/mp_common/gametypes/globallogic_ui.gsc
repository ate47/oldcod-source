#using script_3d703ef87a841fe4;
#using script_45fdb6cec5580007;
#using scripts\abilities\ability_player;
#using scripts\core_common\gamestate;
#using scripts\core_common\hud_message_shared;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\player\player_role;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\spectating;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\mp_common\draft;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\player\player;
#using scripts\mp_common\player\player_loadout;
#using scripts\mp_common\teams\team_assignment;
#using scripts\mp_common\userspawnselection;
#using scripts\mp_common\util;

#namespace globallogic_ui;

// Namespace globallogic_ui/globallogic_ui
// Params 0, eflags: 0x1 linked
// Checksum 0x80f724d1, Offset: 0x1a0
// Size: 0x4
function init() {
    
}

// Namespace globallogic_ui/globallogic_ui
// Params 0, eflags: 0x1 linked
// Checksum 0xd164beea, Offset: 0x1b0
// Size: 0x94
function setupcallbacks() {
    level.autoassign = &menuautoassign;
    level.spectator = &menuspectator;
    level.curclass = &menuclass;
    level.teammenu = &menuteam;
    level.draftmenu = &menupositiondraft;
    level.autocontrolplayer = &menuautocontrolplayer;
}

/#

    // Namespace globallogic_ui/globallogic_ui
    // Params 0, eflags: 0x0
    // Checksum 0x6a5585a7, Offset: 0x250
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
// Params 2, eflags: 0x5 linked
// Checksum 0xc2b3ad76, Offset: 0x4e0
// Size: 0xbc
function private function_34a60b2f(original_team, new_team) {
    if (!isdefined(original_team) || original_team == #"spectator" || !isdefined(new_team)) {
        return;
    }
    if (game.everexisted[original_team] && !game.everexisted[new_team] && level.playerlives[original_team]) {
        game.everexisted[original_team] = 0;
        level.everexisted[original_team] = 0;
        level.teameliminated[original_team] = 0;
    }
}

// Namespace globallogic_ui/globallogic_ui
// Params 2, eflags: 0x1 linked
// Checksum 0xe6767391, Offset: 0x5a8
// Size: 0x464
function menuautoassign(comingfrommenu, var_4c542e39) {
    original_team = self.pers[#"team"];
    self luinotifyevent(#"clear_notification_queue");
    if (level.teambased) {
        assignment = teams::function_d22a4fbb(comingfrommenu, var_4c542e39);
        if (assignment === self.pers[#"team"] && (self.sessionstate === "playing" || self.sessionstate === "dead")) {
            self beginclasschoice(0);
            return;
        }
    } else {
        if (self.sessionstate == "playing" || self.sessionstate == "dead") {
            return;
        }
        assignment = teams::function_b55ab4b3(comingfrommenu, var_4c542e39);
    }
    /#
        assignmentoverride = getdvarstring(#"autoassignteam");
        if (assignmentoverride != "<dev string:x38>" && (assignmentoverride != #"spectator" || !isbot(self))) {
            assignment = assignmentoverride;
        }
    #/
    if (!isdefined(assignment)) {
        assignment = var_4c542e39;
    }
    assert(isdefined(assignment));
    if (assignment === #"spectator" && !level.forceautoassign) {
        self teams::function_dc7eaabd(assignment);
        return;
    }
    if (assignment !== self.pers[#"team"] && (self.sessionstate == "playing" || self.sessionstate == "dead")) {
        self.switching_teams = 1;
        self.switchedteamsresetgadgets = 1;
        self.joining_team = assignment;
        self.leaving_team = self.pers[#"team"];
        self suicide();
    }
    self.pers[#"class"] = "";
    self.curclass = "";
    self.pers[#"weapon"] = undefined;
    self.pers[#"savedmodel"] = undefined;
    self teams::function_dc7eaabd(assignment);
    self squads::function_c70b26ea();
    distribution = teams::function_7d93567f();
    self updateobjectivetext();
    if (!isalive(self)) {
        self.statusicon = "hud_status_dead";
    }
    function_34a60b2f(original_team, assignment);
    self player::function_466d8a4b(comingfrommenu, assignment);
    if (level.var_b3c4b7b7 === 1) {
        draft::assign_remaining_players(self);
    } else {
        self notify(#"end_respawn");
        self beginclasschoice(comingfrommenu);
    }
    /#
        self teams::function_58b6d2c9();
    #/
}

// Namespace globallogic_ui/globallogic_ui
// Params 0, eflags: 0x1 linked
// Checksum 0xae84eed4, Offset: 0xa18
// Size: 0x18c
function updateobjectivetext() {
    if (self.pers[#"team"] == #"spectator") {
        self setclientcgobjectivetext("");
        return;
    }
    if (level.scorelimit > 0 || level.roundscorelimit > 0) {
        if (isdefined(util::getobjectivescoretext(self.pers[#"team"]))) {
            self setclientcgobjectivetext(util::getobjectivescoretext(self.pers[#"team"]));
        } else {
            self setclientcgobjectivetext("");
        }
        return;
    }
    if (isdefined(util::getobjectivetext(self.pers[#"team"]))) {
        self setclientcgobjectivetext(util::getobjectivetext(self.pers[#"team"]));
        return;
    }
    self setclientcgobjectivetext("");
}

// Namespace globallogic_ui/globallogic_ui
// Params 0, eflags: 0x1 linked
// Checksum 0x22c27728, Offset: 0xbb0
// Size: 0x1c
function closemenus() {
    self closeingamemenu();
}

// Namespace globallogic_ui/globallogic_ui
// Params 1, eflags: 0x1 linked
// Checksum 0x5ea73386, Offset: 0xbd8
// Size: 0x374
function beginclasschoice(comingfrommenu) {
    if (isbot(self)) {
        return;
    }
    assert(isdefined(level.teams[self.pers[#"team"]]));
    team = self.pers[#"team"];
    if (level.disableclassselection == 1 || getdvarint(#"migration_soak", 0) == 1) {
        var_2e535d42 = getdvarint(#"auto_select_character", 0);
        if (var_2e535d42 === 0) {
            var_2e535d42 = self stats::function_6d50f14b(#"cacloadouts", #"charactercontext", #"characterindex");
        }
        if (!isdefined(var_2e535d42) || var_2e535d42 === 0) {
            var_2e535d42 = 1;
        }
        self player_role::set(var_2e535d42);
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
// Params 0, eflags: 0x1 linked
// Checksum 0x1e3655dd, Offset: 0xf58
// Size: 0x8c
function showmainmenuforteam() {
    assert(isdefined(level.teams[self.pers[#"team"]]));
    team = self.pers[#"team"];
    [[ level.spawnspectator ]]();
    self draft::open();
}

// Namespace globallogic_ui/globallogic_ui
// Params 1, eflags: 0x1 linked
// Checksum 0x78d6aaa, Offset: 0xff0
// Size: 0x2bc
function menuteam(team) {
    if (!level.console && !level.allow_teamchange && isdefined(self.hasdonecombat) && self.hasdonecombat) {
        return;
    }
    if (self.pers[#"team"] != team) {
        function_34a60b2f(self.pers[#"team"], team);
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
        self player::function_466d8a4b(1, team);
        self notify(#"end_respawn");
    }
    self beginclasschoice(1);
}

// Namespace globallogic_ui/globallogic_ui
// Params 0, eflags: 0x1 linked
// Checksum 0xe8475fe, Offset: 0x12b8
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
        self player::function_6f6c29e(1);
    }
}

// Namespace globallogic_ui/globallogic_ui
// Params 4, eflags: 0x1 linked
// Checksum 0x62e539c9, Offset: 0x1498
// Size: 0x778
function menuclass(response, forcedclass, *updatecharacterindex, var_632376a3) {
    if (!isdefined(self.pers[#"team"]) || !isdefined(level.teams[self.pers[#"team"]])) {
        return 0;
    }
    if (!loadout::function_87bcb1b()) {
        if ((game.state == "pregame" || game.state == "playing") && self.sessionstate != "playing") {
            self thread [[ level.spawnclient ]](0);
        }
        return;
    }
    if (!isdefined(updatecharacterindex)) {
        playerclass = self loadout::function_97d216fa(forcedclass);
    } else {
        playerclass = updatecharacterindex;
    }
    if (is_true(level.disablecustomcac) && issubstr(playerclass, "CLASS_CUSTOM") && isarray(level.classtoclassnum) && level.classtoclassnum.size > 0) {
        defaultclasses = getarraykeys(level.var_8e1db8ee);
        playerclass = level.var_8e1db8ee[defaultclasses[randomint(defaultclasses.size)]];
    }
    self loadout::function_d7c205b9(playerclass);
    if (!player_role::is_valid(self player_role::get())) {
        characterindex = player_role::function_965ea244();
        self draft::select_character(characterindex, 1);
    }
    if (isdefined(self.pers[#"class"]) && self.pers[#"class"] == playerclass) {
        return 1;
    }
    self.pers[#"changed_class"] = !isdefined(self.curclass) || self.curclass != playerclass;
    var_8d7a946 = !isdefined(self.curclass) || self.curclass == "";
    self.pers[#"class"] = playerclass;
    self.curclass = playerclass;
    self loadout::function_d7c205b9(playerclass);
    self.pers[#"weapon"] = undefined;
    self notify(#"changed_class");
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
            if (!is_true(level.var_d0252074) || !is_true(self.hasspawned)) {
                if (isdefined(self.respawntimerstarttime)) {
                    timepassed = float(gettime() - self.respawntimerstarttime) / 1000;
                }
                self thread [[ level.spawnclient ]](timepassed);
                self.respawntimerstarttime = undefined;
            }
        } else if (!var_8d7a946 && self.pers[#"changed_class"] && !is_true(level.var_f46d16f0)) {
            function_4538a730(playerclass);
        }
    }
    if (self.sessionstate == "playing") {
        supplystationclasschange = isdefined(self.usingsupplystation) && self.usingsupplystation;
        self.usingsupplystation = 0;
        if (is_true(level.ingraceperiod) && !is_true(self.hasdonecombat) || is_true(supplystationclasschange) || var_632376a3 === 1 || self.pers[#"time_played_alive"] < level.graceperiod && !is_true(self.hasdonecombat)) {
            self loadout::function_53b62db1(self.pers[#"class"]);
            self.tag_stowed_back = undefined;
            self.tag_stowed_hip = undefined;
            self ability_player::gadgets_save_power(0);
            self loadout::give_loadout(self.pers[#"team"], self.pers[#"class"], var_632376a3);
            self killstreaks::give_owned();
            if (var_632376a3 === 1 && isdefined(level.var_f830a9db)) {
                self [[ level.var_f830a9db ]]();
            }
        } else if (!var_8d7a946 && self.pers[#"changed_class"] && !is_true(level.var_f46d16f0)) {
            function_4538a730(playerclass);
        }
    }
    level thread globallogic::updateteamstatus();
    self thread spectating::set_permissions_for_machine();
    return 1;
}

// Namespace globallogic_ui/globallogic_ui
// Params 1, eflags: 0x1 linked
// Checksum 0x210d5865, Offset: 0x1c18
// Size: 0x5c
function function_4538a730(playerclass) {
    loadoutindex = self loadout::function_6972fdbb(playerclass);
    self luinotifyevent(#"hash_6b67aa04e378d681", 2, 6, loadoutindex);
}

// Namespace globallogic_ui/globallogic_ui
// Params 0, eflags: 0x1 linked
// Checksum 0xda5ec557, Offset: 0x1c80
// Size: 0x5c
function menuautocontrolplayer() {
    self closemenus();
    if (self.pers[#"team"] != #"spectator") {
        toggleplayercontrol(self);
    }
}

// Namespace globallogic_ui/globallogic_ui
// Params 2, eflags: 0x1 linked
// Checksum 0xc0d880a, Offset: 0x1ce8
// Size: 0x16c
function menupositiondraft(response, *intpayload) {
    if (intpayload == "changecharacter") {
        if (self draft::function_904deeb2()) {
            self player_role::clear();
        }
        return;
    }
    if (intpayload == "randomcharacter") {
        self player_role::clear();
        draft::assign_remaining_players(self);
        if (!is_true(level.inprematchperiod)) {
            self draft::close();
            if (!self function_8b1a219a()) {
                self closeingamemenu();
            }
        }
        return;
    }
    if (intpayload == "ready") {
        self draft::client_ready();
        return;
    }
    if (intpayload == "opendraft") {
        self draft::open();
        return;
    }
    if (intpayload == "closedraft") {
        self draft::close();
    }
}

// Namespace globallogic_ui/globallogic_ui
// Params 1, eflags: 0x1 linked
// Checksum 0xc46cd8b6, Offset: 0x1e60
// Size: 0x54
function removespawnmessageshortly(delay) {
    self endon(#"disconnect");
    waittillframeend();
    self endon(#"end_respawn");
    wait delay;
    self hud_message::clearlowermessage();
}

// Namespace globallogic_ui/globallogic_ui
// Params 0, eflags: 0x1 linked
// Checksum 0x68fa4069, Offset: 0x1ec0
// Size: 0x24
function function_bc2eb1b8() {
    self luinotifyevent(#"hash_3ab41287e432bf6c");
}

