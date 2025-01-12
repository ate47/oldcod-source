#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\gamestate;
#using scripts\core_common\hostmigration_shared;
#using scripts\core_common\hud_message_shared;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\oob;
#using scripts\core_common\player\player_role;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\spectating;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\mp_common\armor;
#using scripts\mp_common\bots\mp_bot;
#using scripts\mp_common\callbacks;
#using scripts\mp_common\gametypes\battlechatter;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_audio;
#using scripts\mp_common\gametypes\globallogic_defaults;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_ui;
#using scripts\mp_common\gametypes\globallogic_utils;
#using scripts\mp_common\gametypes\hostmigration;
#using scripts\mp_common\gametypes\hud_message;
#using scripts\mp_common\player\player_killed;
#using scripts\mp_common\player\player_loadout;
#using scripts\mp_common\player\player_monitor;
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\teams\teams;
#using scripts\mp_common\userspawnselection;
#using scripts\mp_common\util;

#namespace globallogic_spawn;

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x2
// Checksum 0x6b84e9, Offset: 0x2f8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"globallogic_spawn", &__init__, undefined, undefined);
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0x8d363158, Offset: 0x340
// Size: 0x20e
function __init__() {
    level.requirespawnpointstoexistinlevel = 0;
    level.spawnsystem.var_65fd4eef = 0;
    spawning::add_default_spawnlist("auto_normal");
    level.spawnentitytypes = [];
    array::add(level.spawnentitytypes, {#team:"all", #entityname:"mp_t8_spawn_point"});
    if (level.gametype == #"dom") {
        array::add(level.spawnentitytypes, {#team:#"allies", #entityname:"mp_t8_spawn_point"});
        array::add(level.spawnentitytypes, {#team:#"axis", #entityname:"mp_t8_spawn_point"});
    }
    array::add(level.spawnentitytypes, {#team:#"allies", #entityname:"mp_t8_spawn_point_allies"});
    array::add(level.spawnentitytypes, {#team:#"axis", #entityname:"mp_t8_spawn_point_axis"});
    level.allspawnpoints = [];
    level.spawnpoints = [];
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0xbf74f4b1, Offset: 0x558
// Size: 0xe
function getspawnentitytypes() {
    return level.spawnentitytypes;
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0x87a225df, Offset: 0x570
// Size: 0xe
function getmpspawnpoints() {
    return level.allspawnpoints;
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 2, eflags: 0x0
// Checksum 0x7af7e1f, Offset: 0x588
// Size: 0x7cc
function function_f3d97e47(spawnpoint, gametype) {
    switch (gametype) {
    case #"ffa":
        return (isdefined(spawnpoint.ffa) && spawnpoint.ffa);
    case #"sd":
        return (isdefined(spawnpoint.sd) && spawnpoint.sd);
    case #"ctf":
        return (isdefined(spawnpoint.ctf) && spawnpoint.ctf);
    case #"dom":
        return (isdefined(spawnpoint.domination) && spawnpoint.domination);
    case #"dem":
        return (isdefined(spawnpoint.demolition) && spawnpoint.demolition);
    case #"gg":
        return (isdefined(spawnpoint.gg) && spawnpoint.gg);
    case #"tdm":
        return (isdefined(spawnpoint.tdm) && spawnpoint.tdm);
    case #"infil":
        return (isdefined(spawnpoint.infiltration) && spawnpoint.infiltration);
    case #"control":
        return (isdefined(spawnpoint.control) && spawnpoint.control);
    case #"uplink":
        return (isdefined(spawnpoint.uplink) && spawnpoint.uplink);
    case #"kc":
        return (isdefined(spawnpoint.kc) && spawnpoint.kc);
    case #"koth":
        return (isdefined(spawnpoint.hardpoint) && spawnpoint.hardpoint);
    case #"frontline":
        return (isdefined(spawnpoint.frontline) && spawnpoint.frontline);
    case #"dom_flag_a":
        return (isdefined(spawnpoint.domination_flag_a) && spawnpoint.domination_flag_a);
    case #"dom_flag_b":
        return (isdefined(spawnpoint.domination_flag_b) && spawnpoint.domination_flag_b);
    case #"dom_flag_c":
        return (isdefined(spawnpoint.domination_flag_c) && spawnpoint.domination_flag_c);
    case #"hash_6056c310624d5afd":
        return (isdefined(spawnpoint.demolition_attacker_a) && spawnpoint.demolition_attacker_a);
    case #"hash_6056c010624d55e4":
        return (isdefined(spawnpoint.demolition_attacker_b) && spawnpoint.demolition_attacker_b);
    case #"hash_6ef2d89ce8ee9a32":
        return (isdefined(spawnpoint.demolition_remove_a) && spawnpoint.demolition_remove_a);
    case #"hash_6ef2d79ce8ee987f":
        return (isdefined(spawnpoint.demolition_remove_b) && spawnpoint.demolition_remove_b);
    case #"dem_overtime":
        return (isdefined(spawnpoint.demolition_overtime) && spawnpoint.demolition_overtime);
    case #"hash_7cb9d0a58715cebe":
        return (isdefined(spawnpoint.demolition_start_spawn) && spawnpoint.demolition_start_spawn);
    case #"hash_6d83e5f1bdefa7dd":
        return (isdefined(spawnpoint.demolition_defender_a) && spawnpoint.demolition_defender_a);
    case #"hash_6d83e2f1bdefa2c4":
        return (isdefined(spawnpoint.demolition_defender_b) && spawnpoint.demolition_defender_b);
    case #"control_attack_add_0":
        return (isdefined(spawnpoint.control_attack_add_a) && spawnpoint.control_attack_add_a);
    case #"control_attack_add_1":
        return (isdefined(spawnpoint.control_attack_add_b) && spawnpoint.control_attack_add_b);
    case #"control_attack_remove_0":
        return (isdefined(spawnpoint.control_attack_remove_a) && spawnpoint.control_attack_remove_a);
    case #"control_attack_remove_1":
        return (isdefined(spawnpoint.control_attack_remove_b) && spawnpoint.control_attack_remove_b);
    case #"control_defend_add_0":
        return (isdefined(spawnpoint.var_9fac815b) && spawnpoint.var_9fac815b);
    case #"control_defend_add_1":
        return (isdefined(spawnpoint.control_defend_add_b) && spawnpoint.control_defend_add_b);
    case #"control_defend_remove_0":
        return (isdefined(spawnpoint.control_defend_remove_a) && spawnpoint.control_defend_remove_a);
    case #"control_defend_remove_1":
        return (isdefined(spawnpoint.control_defend_remove_b) && spawnpoint.control_defend_remove_b);
    case #"ct":
        return (isdefined(spawnpoint.ct) && spawnpoint.ct);
    case #"escort":
        return (isdefined(spawnpoint.escort) && spawnpoint.escort);
    case #"bounty":
        return (isdefined(spawnpoint.bounty) && spawnpoint.bounty);
    default:
        assertmsg("<dev string:x30>" + gametype + "<dev string:x3c>" + spawnpoint.origin[0] + "<dev string:x65>" + spawnpoint.origin[1] + "<dev string:x6a>" + spawnpoint.origin[2]);
        break;
    }
    return false;
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 2, eflags: 0x0
// Checksum 0xf1acb4b6, Offset: 0xd60
// Size: 0x94
function addsupportedspawnpointtype(spawnpointtype, team) {
    if (!isdefined(level.supportedspawntypes)) {
        level.supportedspawntypes = [];
    }
    spawnpointstruct = spawnstruct();
    spawnpointstruct.type = spawnpointtype;
    if (isdefined(team)) {
        spawnpointstruct.team = team;
    }
    array::add(level.supportedspawntypes, spawnpointstruct);
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0x51591f21, Offset: 0xe00
// Size: 0x1e
function function_5e32e69a() {
    level.supportedspawntypes = [];
    level.allspawnpoints = [];
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 1, eflags: 0x0
// Checksum 0x671fb0a3, Offset: 0xe28
// Size: 0xaa
function function_686dd8da(spawn) {
    foreach (var_a286f631 in level.supportedspawntypes) {
        supportedspawntype = var_a286f631.type;
        if (function_f3d97e47(spawn, supportedspawntype)) {
            return true;
        }
    }
    return false;
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 4, eflags: 0x0
// Checksum 0x65b5450e, Offset: 0xee0
// Size: 0x244
function addspawnsforteamname(teamname, searchentity, &spawnarray, &startspawns) {
    rawspawns = struct::get_array(searchentity, "targetname");
    foreach (spawn in rawspawns) {
        array::add(level.allspawnpoints, spawn);
        spawn.team = teamname;
        foreach (var_a286f631 in level.supportedspawntypes) {
            supportedspawntype = var_a286f631.type;
            if (!function_f3d97e47(spawn, supportedspawntype)) {
                continue;
            }
            teamname = util::get_team_mapping(teamname);
            if (isdefined(var_a286f631.team)) {
                if (teamname != var_a286f631.team) {
                    continue;
                }
            }
            usespawnarray = isdefined(spawn.var_7e38bf33) ? spawn.var_7e38bf33 : 0 ? startspawns : spawnarray;
            if (!isdefined(usespawnarray[teamname])) {
                usespawnarray[teamname] = [];
            }
            if (!isdefined(spawn.enabled)) {
                spawn.enabled = -1;
            }
            array::add(usespawnarray[teamname], spawn);
        }
    }
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0x4e8469dd, Offset: 0x1130
// Size: 0x68c
function addspawns() {
    clearspawnpoints("auto_normal");
    if (!isdefined(level.supportedspawntypes)) {
        println("<dev string:x6f>");
        addsupportedspawnpointtype("tdm");
    }
    spawnstoadd = [];
    startspawns = [];
    foreach (spawnentitytype in level.spawnentitytypes) {
        addspawnsforteamname(spawnentitytype.team, spawnentitytype.entityname, spawnstoadd, startspawns);
    }
    spawnteams = getarraykeys(spawnstoadd);
    foreach (spawnteam in spawnteams) {
        if (spawnteam == "all") {
            if (sessionmodeiswarzonegame()) {
                addspawnpoints("free", spawnstoadd[spawnteam], "auto_normal");
                enablespawnpointlist("auto_normal", util::getteammask("free"));
                level.spawnpoints = arraycombine(level.spawnpoints, spawnstoadd[spawnteam], 0, 0);
            } else {
                foreach (team, _ in level.teams) {
                    addspawnpoints(team, spawnstoadd[spawnteam], "auto_normal");
                    level.spawnpoints = arraycombine(level.spawnpoints, spawnstoadd[spawnteam], 0, 0);
                    enablespawnpointlist("auto_normal", util::getteammask(team));
                }
            }
            continue;
        }
        teamforspawns = spawning::function_2b4d76ea() ? util::getotherteam(spawnteam) : spawnteam;
        addspawnpoints(teamforspawns, spawnstoadd[spawnteam], "auto_normal");
        enablespawnpointlist("auto_normal", util::getteammask(teamforspawns));
        foreach (spawnpoint in spawnstoadd[spawnteam]) {
            array::add(level.spawnpoints, spawnpoint, 0);
        }
    }
    if (!isdefined(level.spawn_start)) {
        level.spawn_start = [];
    }
    var_e5c696a2 = getarraykeys(startspawns);
    foreach (spawnteam in var_e5c696a2) {
        if (spawnteam == "all") {
            foreach (team, _ in level.teams) {
                if (!isdefined(level.spawn_start[team])) {
                    level.spawn_start[team] = [];
                }
                level.spawn_start[team] = arraycombine(level.spawn_start[team], startspawns[spawnteam], 0, 0);
            }
            continue;
        }
        teamforspawns = spawning::function_2b4d76ea() ? util::getotherteam(spawnteam) : spawnteam;
        if (!isdefined(level.spawn_start[teamforspawns])) {
            level.spawn_start[teamforspawns] = [];
        }
        level.spawn_start[teamforspawns] = arraycombine(level.spawn_start[teamforspawns], startspawns[spawnteam], 0, 0);
    }
    calculate_map_center();
    spawnpoint = spawning::get_random_intermission_point();
    setdemointermissionpoint(spawnpoint.origin, spawnpoint.angles);
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0x9684987f, Offset: 0x17c8
// Size: 0x16c
function calculate_map_center() {
    if (!isdefined(level.mapcenter)) {
        spawn_points = level.spawnpoints;
        if (isdefined(spawn_points[0])) {
            level.spawnmins = spawn_points[0].origin;
            level.spawnmaxs = spawn_points[0].origin;
        } else {
            level.spawnmins = (0, 0, 0);
            level.spawnmaxs = (0, 0, 0);
        }
        for (index = 0; index < spawn_points.size; index++) {
            origin = spawn_points[index].origin;
            level.spawnmins = math::expand_mins(level.spawnmins, origin);
            level.spawnmaxs = math::expand_maxs(level.spawnmaxs, origin);
        }
        level.mapcenter = math::find_box_center(level.spawnmins, level.spawnmaxs);
        setmapcenter(level.mapcenter);
    }
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 1, eflags: 0x0
// Checksum 0x916c60bf, Offset: 0x1940
// Size: 0x1f4
function timeuntilspawn(includeteamkilldelay) {
    if (level.ingraceperiod && !self.hasspawned) {
        return 0;
    }
    respawndelay = 0;
    if (self.hasspawned) {
        result = self [[ level.onrespawndelay ]]();
        if (isdefined(result)) {
            respawndelay = result;
        } else {
            respawndelay = level.playerrespawndelay;
        }
        if (isdefined(level.playerincrementalrespawndelay) && isdefined(self.pers[#"spawns"])) {
            respawndelay += level.playerincrementalrespawndelay * self.pers[#"spawns"];
        }
        if (isdefined(self.suicide) && self.suicide && level.suicidespawndelay > 0) {
            respawndelay += level.suicidespawndelay;
        }
        if (isdefined(self.teamkilled) && self.teamkilled && level.teamkilledspawndelay > 0) {
            respawndelay += level.teamkilledspawndelay;
        }
        if (includeteamkilldelay && isdefined(self.teamkillpunish) && self.teamkillpunish) {
            respawndelay += player::function_f1377a79();
        }
    }
    wavebased = level.waverespawndelay > 0;
    if (wavebased) {
        return self timeuntilwavespawn(respawndelay);
    }
    if (isdefined(self.usedresurrect) && self.usedresurrect) {
        return 0;
    }
    return respawndelay;
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0xd25e85bd, Offset: 0x1b40
// Size: 0xa8
function allteamshaveexisted() {
    foreach (team, _ in level.teams) {
        if (level.everexisted[team] == 0) {
            return false;
        }
        if (level.everexisted[team] > gettime() + 1000) {
            return false;
        }
    }
    return true;
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0x93138ad3, Offset: 0x1bf0
// Size: 0x1c2
function mayspawn() {
    if (isdefined(level.mayspawn) && !self [[ level.mayspawn ]]()) {
        return false;
    }
    if (level.playerqueuedrespawn && !isdefined(self.allowqueuespawn) && !level.ingraceperiod && !level.usestartspawns) {
        return false;
    }
    if (level.numlives || level.numteamlives) {
        if (level.numlives && !self.pers[#"lives"]) {
            return false;
        } else if (!level.numlives && level.numteamlives && game.lives[self.team] <= 0) {
            return false;
        } else {
            if (level.teambased) {
                gamehasstarted = allteamshaveexisted();
            } else {
                gamehasstarted = level.maxplayercount > 1 || !util::isoneround() && !util::isfirstround();
            }
            if (gamehasstarted && isdefined(level.var_4ec8f819) && level.var_4ec8f819) {
                if (!level.ingraceperiod && !self.hasspawned) {
                    return false;
                }
            }
        }
    }
    return true;
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 1, eflags: 0x0
// Checksum 0xc4e44b00, Offset: 0x1dc0
// Size: 0x154
function timeuntilwavespawn(minimumwait) {
    earliestspawntime = gettime() + int(minimumwait * 1000);
    lastwavetime = level.lastwave[self.pers[#"team"]];
    wavedelay = int(level.wavedelay[self.pers[#"team"]] * 1000);
    if (wavedelay == 0) {
        return 0;
    }
    numwavespassedearliestspawntime = (earliestspawntime - lastwavetime) / wavedelay;
    numwaves = ceil(numwavespassedearliestspawntime);
    timeofspawn = lastwavetime + numwaves * wavedelay;
    if (isdefined(self.wavespawnindex)) {
        timeofspawn += 50 * self.wavespawnindex;
    }
    return float(timeofspawn - gettime()) / 1000;
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0x2aef4aac, Offset: 0x1f20
// Size: 0x46
function stoppoisoningandflareonspawn() {
    self endon(#"disconnect");
    self.inpoisonarea = 0;
    self.inburnarea = 0;
    self.inflarevisionarea = 0;
    self.ingroundnapalm = 0;
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0x979a56ca, Offset: 0x1f70
// Size: 0x110
function spawnplayerprediction() {
    self endon(#"disconnect");
    self endon(#"end_respawn");
    self endon(#"game_ended");
    self endon(#"joined_spectators");
    self endon(#"spawned");
    plrs = teams::count_players();
    nolivesleft = level.numlives && !self.pers[#"lives"] || level.numteamlives && game.lives[self.team] > 0;
    if (nolivesleft) {
        return;
    }
    while (true) {
        wait 0.5;
        spawning::onspawnplayer(1);
    }
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 1, eflags: 0x0
// Checksum 0x2d70c114, Offset: 0x2088
// Size: 0x144
function playmatchstartaudio(team) {
    self endon(#"disconnect");
    for (index = 0; index < 5; index++) {
        waitframe(1);
    }
    if (self.pers[#"playedgamemode"] !== 1) {
        if (level.hardcoremode) {
            self globallogic_audio::leader_dialog_on_player(level.leaderdialog.starthcgamedialog);
        } else {
            self globallogic_audio::leader_dialog_on_player(level.leaderdialog.startgamedialog);
        }
        self.pers[#"playedgamemode"] = 1;
    }
    if (team == game.attackers) {
        self globallogic_audio::leader_dialog_on_player(level.leaderdialog.offenseorderdialog);
        return;
    }
    self globallogic_audio::leader_dialog_on_player(level.leaderdialog.defenseorderdialog);
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 1, eflags: 0x0
// Checksum 0x28669ef3, Offset: 0x21d8
// Size: 0x19c
function doinitialspawnmessaging(params = undefined) {
    pixbeginevent(#"sound");
    if (level.gametype !== "bounty") {
        if (isdefined(self.pers[#"music"].spawn) && self.pers[#"music"].spawn == 0) {
            if (game.roundsplayed == 0) {
                self thread globallogic_audio::set_music_on_player("spawnFull");
            } else {
                self thread globallogic_audio::set_music_on_player("spawnShort");
            }
            self.pers[#"music"].spawn = 1;
        }
    }
    if (level.splitscreen) {
        if (isdefined(level.playedstartingmusic)) {
            music = undefined;
        } else {
            level.playedstartingmusic = 1;
        }
    }
    self.playleaderdialog = 1;
    if (isdefined(level.leaderdialog)) {
        self thread playmatchstartaudio(self.pers[#"team"]);
    }
    pixendevent();
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0x53e0856a, Offset: 0x2380
// Size: 0xe
function resetattackersthisspawnlist() {
    self.attackersthisspawn = [];
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0xc46f00e4, Offset: 0x2398
// Size: 0x8ec
function spawnplayer() {
    pixbeginevent(#"spawnplayer_preuts");
    self endon(#"disconnect");
    self endon(#"joined_spectators");
    hadspawned = self.hasspawned;
    self player::spawn_player();
    if (globallogic_utils::getroundstartdelay()) {
        self thread globallogic_utils::applyroundstartdelay();
    }
    if (isdefined(self.spawnlightarmor) && self.spawnlightarmor > 0) {
        self thread armor::setlightarmor(self.spawnlightarmor);
    }
    self.nextkillstreakfree = undefined;
    self.deathmachinekills = 0;
    self resetattackersthisspawnlist();
    self.diedonvehicle = undefined;
    if (!self.wasaliveatmatchstart) {
        if (level.ingraceperiod || globallogic_utils::gettimepassed() < int(20 * 1000)) {
            self.wasaliveatmatchstart = 1;
        }
    }
    pixbeginevent(#"onspawnplayer");
    self [[ level.onspawnplayer ]](0);
    if (isdefined(level.playerspawnedcb)) {
        self [[ level.playerspawnedcb ]]();
    }
    pixendevent();
    pixendevent();
    level thread globallogic::updateteamstatus();
    pixbeginevent(#"spawnplayer_postuts");
    self val::nuke("disable_oob");
    self thread stoppoisoningandflareonspawn();
    self.sensorgrenadedata = undefined;
    self.var_a541ee78 = 0;
    self.var_6209d597 = undefined;
    self.var_fd488445 = undefined;
    role = self player_role::get();
    assert(!loadout::function_cd383ec5() || globallogic_utils::isvalidclass(self.curclass));
    assert(player_role::is_valid(role));
    self.pers[#"momentum_at_spawn_or_game_end"] = isdefined(self.pers[#"momentum"]) ? self.pers[#"momentum"] : 0;
    if (loadout::function_cd383ec5()) {
        self loadout::function_e7e08814(self.curclass);
    }
    self loadout::give_loadout(self.team, self.curclass);
    specialist = function_b9650e7f(role, currentsessionmode());
    self function_87200b59(specialist);
    if (level.inprematchperiod) {
        self val::set(#"spawn_player", "freezecontrols");
        self val::set(#"spawn_player", "disablegadgets");
        self callback::on_prematch_end(&doinitialspawnmessaging);
    } else {
        self val::reset(#"spawn_player", "freezecontrols");
        self val::reset(#"spawn_player", "disablegadgets");
        self enableweapons();
        if (!hadspawned && game.state == "playing") {
            self thread doinitialspawnmessaging();
        }
    }
    if (isdefined(level.scoreresetondeath) && level.scoreresetondeath) {
        self globallogic_score::resetplayermomentumonspawn();
    }
    self.deathtime = 0;
    self.pers[#"deathtime"] = 0;
    if (self hasperk(#"specialty_anteup")) {
        anteup_bonus = getdvarint(#"perk_killstreakanteupresetvalue", 0);
        if (self.pers[#"momentum_at_spawn_or_game_end"] < anteup_bonus) {
            globallogic_score::_setplayermomentum(self, anteup_bonus, 0);
        }
    }
    if (!isdefined(getdvar(#"scr_showperksonspawn"))) {
        setdvar(#"scr_showperksonspawn", 0);
    }
    if (level.hardcoremode) {
        setdvar(#"scr_showperksonspawn", 0);
    }
    /#
        if (getdvarint(#"scr_showperksonspawn", 0) == 1 && !gamestate::is_game_over()) {
            pixbeginevent(#"showperksonspawn");
            if (level.perksenabled == 1) {
                self hud::showperks();
            }
            pixendevent();
        }
    #/
    if (isdefined(self.pers[#"momentum"])) {
        self.momentum = self.pers[#"momentum"];
    }
    self callback::function_1dea870d(#"on_end_game", &on_end_game);
    self setsprintboost(0);
    pixendevent();
    waittillframeend();
    self notify(#"spawned_player");
    callback::callback(#"on_player_spawned");
    self thread player_monitor::monitor();
    /#
        print("<dev string:xc9>" + self.origin[0] + "<dev string:xcc>" + self.origin[1] + "<dev string:xcc>" + self.origin[2] + "<dev string:xce>");
    #/
    setdvar(#"scr_selecting_location", "");
    if (gamestate::is_game_over()) {
        assert(!level.intermission);
        self player::freeze_player_for_round_end();
    }
    self util::set_lighting_state();
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0xf6637c6f, Offset: 0x2c90
// Size: 0x5e
function on_end_game() {
    self.pers[#"momentum_at_spawn_or_game_end"] = isdefined(self.pers[#"momentum"]) ? self.pers[#"momentum"] : 0;
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 2, eflags: 0x0
// Checksum 0x100bb49d, Offset: 0x2cf8
// Size: 0x4c
function spawnspectator(origin, angles) {
    self notify(#"spawned");
    self notify(#"end_respawn");
    in_spawnspectator(origin, angles);
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 2, eflags: 0x0
// Checksum 0x2b46a26c, Offset: 0x2d50
// Size: 0x2c
function respawn_asspectator(origin, angles) {
    in_spawnspectator(origin, angles);
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0xc700cb3e, Offset: 0x2d88
// Size: 0x2dc
function function_db7943b8() {
    if (self.team != #"spectator" && level.spectatetype == 4 && self.spectatorteam == #"invalid") {
        team_players = getplayers(self.team);
        foreach (player in team_players) {
            if (player != self && isalive(player)) {
                self.spectatorteam = player.team;
                println("<dev string:xd0>" + player.team + "<dev string:xeb>" + self.name + "<dev string:xf1>" + self.team + "<dev string:x101>" + player.name + "<dev string:x10b>");
                return;
            }
        }
        foreach (player in team_players) {
            if (player != self && player.spectatorteam != #"invalid") {
                self.spectatorteam = player.spectatorteam;
                println("<dev string:xd0>" + player.spectatorteam + "<dev string:xeb>" + self.name + "<dev string:xf1>" + self.team + "<dev string:x101>" + player.name + "<dev string:x115>");
                return;
            }
        }
        self.spectatorteam = self.team;
        println("<dev string:xd0>" + self.spectatorteam + "<dev string:xeb>" + self.name + "<dev string:xf1>" + self.team + "<dev string:x12e>");
    }
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 2, eflags: 0x0
// Checksum 0xa021cf3a, Offset: 0x3070
// Size: 0x1c4
function in_spawnspectator(origin, angles) {
    pixmarker("BEGIN: in_spawnSpectator");
    self player::set_spawn_variables();
    self.sessionstate = "spectator";
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    self.spectatekillcam = 0;
    self.friendlydamage = undefined;
    if (self.pers[#"team"] == #"spectator") {
        self.statusicon = "";
    } else {
        self.statusicon = "hud_status_dead";
    }
    if (level.spectatetype != 4 || self.pers[#"team"] == #"spectator") {
        self.spectatorclient = -1;
        spectating::set_permissions_for_machine();
    }
    function_db7943b8();
    [[ level.onspawnspectator ]](origin, angles);
    if (level.teambased && !level.splitscreen) {
        self thread spectatorthirdpersonness();
    }
    level thread globallogic::updateteamstatus();
    pixmarker("END: in_spawnSpectator");
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0x4b7a3a2f, Offset: 0x3240
// Size: 0x5a
function spectatorthirdpersonness() {
    self endon(#"disconnect");
    self endon(#"spawned");
    self notify(#"spectator_thirdperson_thread");
    self endon(#"spectator_thirdperson_thread");
    self.spectatingthirdperson = 0;
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 1, eflags: 0x0
// Checksum 0xb8e02602, Offset: 0x32a8
// Size: 0x140
function forcespawn(time) {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"spawned");
    if (!isdefined(time)) {
        time = 60;
    }
    wait time;
    if (self.hasspawned) {
        return;
    }
    if (self.pers[#"team"] == #"spectator") {
        return;
    }
    if (!globallogic_utils::isvalidclass(self.pers[#"class"])) {
        self.pers[#"class"] = "CLASS_CUSTOM1";
        self.curclass = self.pers[#"class"];
    }
    if (!ispc()) {
        self globallogic_ui::closemenus();
    }
    self thread [[ level.spawnclient ]]();
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0x2b877af4, Offset: 0x33f0
// Size: 0x64
function kickifdontspawn() {
    /#
        if (getdvarint(#"scr_hostmigrationtest", 0) == 1) {
            return;
        }
    #/
    if (self ishost()) {
        return;
    }
    self kickifidontspawninternal();
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0xf3828409, Offset: 0x3460
// Size: 0x28c
function kickifidontspawninternal() {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"spawned");
    while (true) {
        if (!(isdefined(level.inprematchperiod) && level.inprematchperiod) && self isstreamerready()) {
            break;
        }
        wait 5;
    }
    waittime = 90;
    if (getdvarstring(#"scr_kick_time") != "") {
        waittime = getdvarfloat(#"scr_kick_time", 0);
    }
    mintime = 45;
    if (getdvarstring(#"scr_kick_mintime") != "") {
        mintime = getdvarfloat(#"scr_kick_mintime", 0);
    }
    starttime = gettime();
    kickwait(waittime);
    timepassed = float(gettime() - starttime) / 1000;
    if (timepassed < waittime - 0.1 && timepassed < mintime) {
        return;
    }
    if (self.hasspawned) {
        return;
    }
    if (sessionmodeisprivate()) {
        return;
    }
    if (self.pers[#"team"] == #"spectator") {
        return;
    }
    if (!mayspawn() && self.pers[#"time_played_total"] > 0) {
        return;
    }
    globallogic::gamehistoryplayerkicked();
    kick(self getentitynumber(), "EXE/PLAYERKICKED_NOTSPAWNED");
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 1, eflags: 0x0
// Checksum 0x22fb4b48, Offset: 0x36f8
// Size: 0x34
function kickwait(waittime) {
    level endon(#"game_ended");
    hostmigration::waitlongdurationwithhostmigrationpause(waittime);
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0xfbb59bc3, Offset: 0x3738
// Size: 0x16c
function spawninterroundintermission() {
    self notify(#"spawned");
    self notify(#"end_respawn");
    self player::set_spawn_variables();
    self hud_message::clearlowermessage();
    self val::reset(#"spawn_player", "freezecontrols");
    self val::reset(#"spawn_player", "disablegadgets");
    self.sessionstate = "spectator";
    self.spectatorclient = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    self.spectatekillcam = 0;
    self.friendlydamage = undefined;
    self globallogic_defaults::default_onspawnintermission();
    self setorigin(self.origin);
    self setplayerangles(self.angles);
    self clientfield::set_to_player("player_dof_settings", 2);
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 2, eflags: 0x0
// Checksum 0x4b2ecc67, Offset: 0x38b0
// Size: 0x174
function spawnintermission(usedefaultcallback, endgame) {
    self notify(#"spawned");
    self notify(#"end_respawn");
    self endon(#"disconnect");
    self player::set_spawn_variables();
    self hud_message::clearlowermessage();
    self val::reset(#"spawn_player", "freezecontrols");
    self val::reset(#"spawn_player", "disablegadgets");
    self.sessionstate = "intermission";
    self.spectatorclient = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    self.spectatekillcam = 0;
    self.friendlydamage = undefined;
    if (isdefined(usedefaultcallback) && usedefaultcallback) {
        globallogic_defaults::default_onspawnintermission();
    } else {
        [[ level.onspawnintermission ]](endgame);
    }
    self clientfield::set_to_player("player_dof_settings", 2);
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 1, eflags: 0x0
// Checksum 0x6c3ca7ed, Offset: 0x3a30
// Size: 0xc8
function spawnqueuedclientonteam(team) {
    player_to_spawn = undefined;
    for (i = 0; i < level.deadplayers[team].size; i++) {
        player = level.deadplayers[team][i];
        if (player.waitingtospawn) {
            continue;
        }
        player_to_spawn = player;
        break;
    }
    if (isdefined(player_to_spawn)) {
        player_to_spawn.allowqueuespawn = 1;
        player_to_spawn globallogic_ui::closemenus();
        player_to_spawn thread [[ level.spawnclient ]]();
    }
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 2, eflags: 0x0
// Checksum 0x4a6d1b7d, Offset: 0x3b00
// Size: 0x130
function spawnqueuedclient(dead_player_team, killer) {
    if (!level.playerqueuedrespawn) {
        return;
    }
    util::waittillslowprocessallowed();
    spawn_team = undefined;
    if (isdefined(killer) && isdefined(killer.team) && isdefined(level.teams[killer.team])) {
        spawn_team = killer.team;
    }
    if (isdefined(spawn_team)) {
        spawnqueuedclientonteam(spawn_team);
        return;
    }
    foreach (team, _ in level.teams) {
        if (team == dead_player_team) {
            continue;
        }
        spawnqueuedclientonteam(team);
    }
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0x13e51123, Offset: 0x3c38
// Size: 0xc6
function allteamsnearscorelimit() {
    if (!level.teambased) {
        return false;
    }
    if (level.scorelimit <= 1) {
        return false;
    }
    foreach (team, _ in level.teams) {
        if (!(game.stat[#"teamscores"][team] >= level.scorelimit - 1)) {
            return false;
        }
    }
    return true;
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0x24e93a7f, Offset: 0x3d08
// Size: 0x6e
function shouldshowrespawnmessage() {
    if (util::waslastround()) {
        return false;
    }
    if (util::isoneround()) {
        return false;
    }
    if (isdefined(level.livesdonotreset) && level.livesdonotreset) {
        return false;
    }
    if (allteamsnearscorelimit()) {
        return false;
    }
    return true;
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0x88ff6920, Offset: 0x3d80
// Size: 0x44
function default_spawnmessage() {
    hud_message::setlowermessage(game.strings[#"spawn_next_round"]);
    self thread globallogic_ui::removespawnmessageshortly(3);
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0xcf3191a5, Offset: 0x3dd0
// Size: 0x28
function showspawnmessage() {
    if (shouldshowrespawnmessage()) {
        self thread [[ level.spawnmessage ]]();
    }
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 1, eflags: 0x0
// Checksum 0xd6c1fbaa, Offset: 0x3e00
// Size: 0x1e4
function spawnclient(timealreadypassed) {
    pixbeginevent(#"spawnclient");
    assert(isdefined(self.team));
    assert(!loadout::function_cd383ec5() || globallogic_utils::isvalidclass(self.curclass));
    if (!self mayspawn() && !(isdefined(self.usedresurrect) && self.usedresurrect)) {
        currentorigin = self.origin;
        currentangles = self.angles;
        self showspawnmessage();
        self thread [[ level.spawnspectator ]](currentorigin + (0, 0, 60), currentangles);
        pixendevent();
        return;
    }
    if (self.waitingtospawn) {
        pixendevent();
        return;
    }
    self.waitingtospawn = 1;
    self.allowqueuespawn = undefined;
    if (!(isdefined(level.takelivesondeath) && level.takelivesondeath)) {
        game.lives[self.team]--;
    }
    self waitandspawnclient(timealreadypassed);
    if (isdefined(self)) {
        self.waitingtospawn = 0;
    }
    pixendevent();
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 1, eflags: 0x0
// Checksum 0x145bebbb, Offset: 0x3ff0
// Size: 0x558
function waitandspawnclient(timealreadypassed) {
    self endon(#"disconnect");
    self endon(#"end_respawn");
    level endon(#"game_ended");
    if (!isdefined(timealreadypassed)) {
        timealreadypassed = 0;
    }
    spawnedasspectator = 0;
    if (isdefined(self.teamkillpunish) && self.teamkillpunish) {
        var_f1377a79 = player::function_f1377a79();
        if (var_f1377a79 > timealreadypassed) {
            var_f1377a79 -= timealreadypassed;
            timealreadypassed = 0;
        } else {
            timealreadypassed -= var_f1377a79;
            var_f1377a79 = 0;
        }
        if (var_f1377a79 > 0) {
            hud_message::setlowermessage(#"hash_7d1a0e5bd191fce", var_f1377a79);
            self thread respawn_asspectator(self.origin + (0, 0, 60), self.angles);
            spawnedasspectator = 1;
            wait var_f1377a79;
        }
        self.teamkillpunish = 0;
    }
    if (!isdefined(self.wavespawnindex) && isdefined(level.waveplayerspawnindex[self.team])) {
        self.wavespawnindex = level.waveplayerspawnindex[self.team];
        level.waveplayerspawnindex[self.team]++;
    }
    timeuntilspawn = timeuntilspawn(0);
    if (timeuntilspawn > timealreadypassed) {
        timeuntilspawn -= timealreadypassed;
        timealreadypassed = 0;
    } else {
        timealreadypassed -= timeuntilspawn;
        timeuntilspawn = 0;
    }
    if (timeuntilspawn > 0) {
        if (level.playerqueuedrespawn) {
            hud_message::setlowermessage(game.strings[#"you_will_spawn"], timeuntilspawn);
        } else {
            hud_message::setlowermessage(game.strings[#"waiting_to_spawn"], timeuntilspawn);
        }
        if (!spawnedasspectator) {
            spawnorigin = self.origin + (0, 0, 60);
            spawnangles = self.angles;
            if (isdefined(level.useintermissionpointsonwavespawn) && [[ level.useintermissionpointsonwavespawn ]]() == 1) {
                spawnpoint = spawning::get_random_intermission_point();
                if (isdefined(spawnpoint)) {
                    spawnorigin = spawnpoint.origin;
                    spawnangles = spawnpoint.angles;
                }
            }
            self thread respawn_asspectator(spawnorigin, spawnangles);
        }
        spawnedasspectator = 1;
        self globallogic_utils::waitfortimeornotify(timeuntilspawn, "force_spawn");
        self notify(#"stop_wait_safe_spawn_button");
    }
    if (isdefined(level.var_2b829c4e)) {
        if (!spawnedasspectator) {
            self thread respawn_asspectator(self.origin + (0, 0, 60), self.angles);
        }
        spawnedasspectator = 1;
        if (!self [[ level.var_2b829c4e ]]()) {
            self.waitingtospawn = 0;
            self hud_message::clearlowermessage();
            self.wavespawnindex = undefined;
            self.respawntimerstarttime = undefined;
            return;
        }
    }
    wavebased = level.waverespawndelay > 0;
    if (!level.playerforcerespawn && self.hasspawned && !wavebased && !self.wantsafespawn && !level.playerqueuedrespawn) {
        hud_message::setlowermessage(game.strings[#"press_to_spawn"]);
        if (!spawnedasspectator) {
            self thread respawn_asspectator(self.origin + (0, 0, 60), self.angles);
        }
        spawnedasspectator = 1;
        self waitrespawnorsafespawnbutton();
    }
    self.waitingtospawn = 0;
    self hud_message::clearlowermessage();
    self.wavespawnindex = undefined;
    self.respawntimerstarttime = undefined;
    self.pers[#"spawns"]++;
    self thread [[ level.spawnplayer ]]();
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0x8697708d, Offset: 0x4550
// Size: 0x54
function waitrespawnorsafespawnbutton() {
    self endon(#"disconnect");
    self endon(#"end_respawn");
    while (true) {
        if (self usebuttonpressed()) {
            break;
        }
        waitframe(1);
    }
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0x86e11e1d, Offset: 0x45b0
// Size: 0xb2
function waitinspawnqueue() {
    self endon(#"disconnect");
    self endon(#"end_respawn");
    if (!level.ingraceperiod && !level.usestartspawns) {
        currentorigin = self.origin;
        currentangles = self.angles;
        self thread [[ level.spawnspectator ]](currentorigin + (0, 0, 60), currentangles);
        self waittill(#"queue_respawn");
    }
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 1, eflags: 0x0
// Checksum 0x81e782d, Offset: 0x4670
// Size: 0xdc
function setthirdperson(value) {
    if (!level.console) {
        return;
    }
    if (!isdefined(self.spectatingthirdperson) || value != self.spectatingthirdperson) {
        self.spectatingthirdperson = value;
        if (value) {
            self setclientthirdperson(1);
            self clientfield::set_to_player("player_dof_settings", 2);
        } else {
            self setclientthirdperson(0);
            self clientfield::set_to_player("player_dof_settings", 1);
        }
        self resetfov();
    }
}

// Namespace globallogic_spawn/globallogic_spawn
// Params 4, eflags: 0x0
// Checksum 0x92209107, Offset: 0x4758
// Size: 0x208
function function_4410852b(origin, angles, team, gamemode) {
    if (gamemode != level.gametype) {
        return;
    }
    spawnpoint = spawnstruct();
    if (team == "axis") {
        spawnpoint.classname = "mp_t8_spawn_point_axis";
        spawnpoint.targetname = "mp_t8_spawn_point_axis";
    } else if (team == "allies") {
        spawnpoint.classname = "mp_t8_spawn_point_allies";
        spawnpoint.targetname = "mp_t8_spawn_point_allies";
    }
    spawnpoint.origin = origin;
    spawnpoint.angles = angles;
    spawnpoint.var_7e38bf33 = 1;
    spawnpoint.tdm = 1;
    spawnpoint.var_cd213ee1 = 1;
    if (!isdefined(level.spawn_start)) {
        level.spawn_start = [];
    }
    if (!isdefined(level.spawn_start[team])) {
        level.spawn_start[team] = [];
    }
    if (!isdefined(level.spawn_start[team])) {
        level.spawn_start[team] = [];
    } else if (!isarray(level.spawn_start[team])) {
        level.spawn_start[team] = array(level.spawn_start[team]);
    }
    level.spawn_start[team][level.spawn_start[team].size] = spawnpoint;
}

