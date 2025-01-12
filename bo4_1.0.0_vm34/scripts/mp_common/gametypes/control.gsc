#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\demo_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\hostmigration_shared;
#using scripts\core_common\persistence_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\popups_shared;
#using scripts\core_common\potm_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\sound_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\bb;
#using scripts\mp_common\challenges;
#using scripts\mp_common\gametypes\battlechatter;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_audio;
#using scripts\mp_common\gametypes\globallogic_defaults;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_spawn;
#using scripts\mp_common\gametypes\globallogic_utils;
#using scripts\mp_common\gametypes\hud_message;
#using scripts\mp_common\gametypes\match;
#using scripts\mp_common\gametypes\round;
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\spawnbeacon;
#using scripts\mp_common\userspawnselection;
#using scripts\mp_common\util;

#namespace mission_koth;

// Namespace mission_koth/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x5ab4aad8, Offset: 0x848
// Size: 0x702
function event_handler[gametype_init] main(eventstruct) {
    globallogic::init();
    util::registertimelimit(0, 1440);
    util::registerscorelimit(0, 2000);
    util::registernumlives(0, 100);
    util::registerroundswitch(0, 9);
    util::registerroundlimit(0, 10);
    util::registerroundwinlimit(0, 10);
    util::registerscorelimit(0, 5000);
    globallogic::registerfriendlyfiredelay(level.gametype, 15, 0, 1440);
    game.objective_gained_sound = "mpl_flagcapture_sting_friend";
    game.objective_lost_sound = "mpl_flagcapture_sting_enemy";
    level.onstartgametype = &on_start_gametype;
    level.onspawnplayer = &on_spawn_player;
    player::function_b0320e78(&on_player_killed);
    player::function_74c335a(&function_b794738);
    level.ontimelimit = &on_time_limit;
    level.onendgame = &on_end_game;
    level.ononeleftevent = &ononeleftevent;
    level.onendround = &on_end_round;
    level.gettimelimit = &gettimelimit;
    level.var_c9d3723c = &function_4fdb87a6;
    level.doprematch = 1;
    level.overrideteamscore = 1;
    level.warstarttime = 0;
    level.var_3626d83c = 1;
    level.takelivesondeath = 1;
    level.b_allow_vehicle_proximity_pickup = 1;
    level.scoreroundwinbased = getgametypesetting(#"cumulativeroundscores") == 0;
    level.zonespawntime = getgametypesetting(#"objectivespawntime");
    level.capturetime = getgametypesetting(#"capturetime");
    level.destroytime = getgametypesetting(#"destroytime");
    level.timepauseswheninzone = getgametypesetting(#"timepauseswheninzone");
    level.dela = getgametypesetting(#"delayplayer");
    level.scoreperplayer = getgametypesetting(#"scoreperplayer");
    level.neutralzone = getgametypesetting(#"neutralzone");
    level.decaycapturedzones = getgametypesetting(#"decaycapturedzones");
    level.capdecay = getgametypesetting(#"capdecay");
    level.extratime = getgametypesetting(#"extratime");
    level.playercapturelpm = getgametypesetting(#"maxplayereventsperminute");
    level.autodecaytime = isdefined(getgametypesetting(#"autodecaytime")) ? getgametypesetting(#"autodecaytime") : undefined;
    level.timerpaused = 0;
    level.zonepauseinfo = [];
    level.var_1bc31ae2 = [];
    level.var_ca870aaa = 0;
    level.numzonesoccupied = 0;
    level.flagcapturerateincrease = getgametypesetting(#"flagcapturerateincrease");
    level.bonuslivesforcapturingzone = isdefined(getgametypesetting(#"bonuslivesforcapturingzone")) ? getgametypesetting(#"bonuslivesforcapturingzone") : 0;
    globallogic_audio::set_leader_gametype_dialog("startControl", "hcStartControl", "controlOrdersOfs", "controlOrdersDef");
    register_clientfields();
    callback::on_connect(&on_player_connect);
    level.audiocues = [];
    level.mission_bundle = getscriptbundle("mission_settings_control");
    globallogic_spawn::addsupportedspawnpointtype("control");
    game.strings[#"hash_bab7f2001813aa7"] = #"hash_15294f07ee519376";
    game.strings[#"hash_5db475ae2d5164e1"] = #"hash_3a9b595d0bf81f13";
    hud_message::function_402fbbd3(1, game.strings[#"hash_bab7f2001813aa7"], game.strings[#"hash_5db475ae2d5164e1"]);
    level.audioplaybackthrottle = int(level.mission_bundle.msaudioplaybackthrottle);
    if (!isdefined(level.audioplaybackthrottle)) {
        level.audioplaybackthrottle = 5000;
    }
}

// Namespace mission_koth/control
// Params 0, eflags: 0x0
// Checksum 0x4cf0e076, Offset: 0xf58
// Size: 0x1fc
function updatespawns() {
    globallogic_spawn::function_5e32e69a();
    globallogic_spawn::addsupportedspawnpointtype("control");
    var_d2ee3b15 = [];
    foreach (zone in level.zones) {
        if (!isdefined(zone.gameobject)) {
            continue;
        }
        var_d2ee3b15[zone.zone_index] = isdefined(zone.gameobject.var_221fc67) && zone.gameobject.var_221fc67;
    }
    if (var_d2ee3b15.size == 2) {
        if (var_d2ee3b15[0]) {
            globallogic_spawn::addsupportedspawnpointtype("control_attack_add_1");
            globallogic_spawn::addsupportedspawnpointtype("control_defend_add_1");
        } else {
            globallogic_spawn::addsupportedspawnpointtype("control_attack_remove_0");
            globallogic_spawn::addsupportedspawnpointtype("control_defend_remove_0");
        }
        if (var_d2ee3b15[1]) {
            globallogic_spawn::addsupportedspawnpointtype("control_attack_add_0");
            globallogic_spawn::addsupportedspawnpointtype("control_defend_add_0");
        } else {
            globallogic_spawn::addsupportedspawnpointtype("control_attack_remove_1");
            globallogic_spawn::addsupportedspawnpointtype("control_defend_remove_1");
        }
    }
    globallogic_spawn::addspawns();
}

// Namespace mission_koth/control
// Params 0, eflags: 0x0
// Checksum 0xef5c2205, Offset: 0x1160
// Size: 0xc4
function register_clientfields() {
    clientfield::register("world", "warzone", 1, 5, "int");
    clientfield::register("world", "warzonestate", 1, 10, "int");
    clientfield::register("worlduimodel", "hudItems.missions.captureMultiplierStatus", 1, 2, "int");
    clientfield::register("worlduimodel", "hudItems.war.attackingTeam", 1, 2, "int");
}

// Namespace mission_koth/control
// Params 0, eflags: 0x0
// Checksum 0xb2083678, Offset: 0x1230
// Size: 0xa4
function on_time_limit() {
    if (level.zones.size == level.capturedzones) {
        level thread globallogic::end_round(1);
        return;
    }
    if (isdefined(level.neutralzone) && level.neutralzone) {
        round::function_76a0135d();
    } else {
        round::set_winner(game.defenders);
    }
    thread globallogic::end_round(2);
}

// Namespace mission_koth/control
// Params 1, eflags: 0x0
// Checksum 0x206a1c4, Offset: 0x12e0
// Size: 0x5c
function on_spawn_player(predictedspawn) {
    spawning::onspawnplayer(predictedspawn);
    if (level.numlives > 0) {
        clientfield::set_player_uimodel("hudItems.playerLivesCount", game.lives[self.team]);
    }
}

// Namespace mission_koth/control
// Params 0, eflags: 0x0
// Checksum 0x69109385, Offset: 0x1348
// Size: 0x3e
function gettimelimit() {
    timelimit = globallogic_defaults::default_gettimelimit();
    if (level.usingextratime) {
        return (timelimit + level.extratime);
    }
    return timelimit;
}

// Namespace mission_koth/control
// Params 1, eflags: 0x0
// Checksum 0x97aadbf1, Offset: 0x1390
// Size: 0x7c
function on_end_game(var_c3d87d03) {
    if (level.scoreroundwinbased) {
        globallogic_score::updateteamscorebyroundswon();
        winner = globallogic::determineteamwinnerbygamestat("roundswon");
    } else {
        winner = globallogic::determineteamwinnerbyteamscore();
    }
    match::function_622b7e5e(winner);
}

// Namespace mission_koth/control
// Params 1, eflags: 0x0
// Checksum 0x77e75dbc, Offset: 0x1418
// Size: 0x7c
function on_end_round(var_c3d87d03) {
    if (globallogic::function_560d398c(var_c3d87d03)) {
        winning_team = round::get_winning_team();
        globallogic_score::giveteamscoreforobjective(winning_team, 1);
    }
    function_6958986e(var_c3d87d03);
}

// Namespace mission_koth/control
// Params 0, eflags: 0x0
// Checksum 0x1ec1cb83, Offset: 0x14a0
// Size: 0x30
function function_359fc065() {
    if (!isdefined(self.touchtriggers)) {
        return true;
    }
    if (self.touchtriggers.size == 0) {
        return true;
    }
    return false;
}

// Namespace mission_koth/control
// Params 4, eflags: 0x0
// Checksum 0x367e1184, Offset: 0x14d8
// Size: 0x51c
function function_b794738(einflictor, victim, idamage, weapon) {
    attacker = self;
    if (isdefined(weapon) && isdefined(level.iskillstreakweapon)) {
        if ([[ level.iskillstreakweapon ]](weapon) || isdefined(weapon.statname) && [[ level.iskillstreakweapon ]](getweapon(weapon.statname))) {
            return;
        }
    }
    if (isdefined(victim.var_b3f9ddd4) && victim.var_b3f9ddd4) {
        return;
    }
    if (!isplayer(attacker) || level.capturetime && victim function_359fc065() && attacker function_359fc065() || attacker.pers[#"team"] == victim.pers[#"team"]) {
        victim function_f87fa8d3(attacker, weapon);
        return;
    }
    foreach (zone in level.zones) {
        radius = (zone.trigger.maxs[0] - zone.trigger.mins[0]) * 0.5;
        victim thread globallogic_score::function_93736d46(einflictor, attacker, weapon, zone.trigger, radius, zone.team, zone.trigger);
    }
    medalgiven = 0;
    scoreeventprocessed = 0;
    ownerteam = undefined;
    zone = level.zone;
    if (level.capturetime == 0) {
        if (!isdefined(zone)) {
            return;
        }
        ownerteam = zone.gameobject.ownerteam;
        if (!isdefined(ownerteam) || ownerteam == #"neutral") {
            return;
        }
    }
    if (!victim function_359fc065() || level.capturetime == 0 && victim istouching(zone.trigger)) {
        attacker.pers[#"objectiveekia"]++;
        attacker.objectiveekia = attacker.pers[#"objectiveekia"];
        attacker.pers[#"objectives"]++;
        attacker.objectives = attacker.pers[#"objectives"];
        if (victim.team == game.attackers && attacker.team == game.defenders) {
            attacker thread kill_while_contesting(victim);
        }
        if (victim.team == game.defenders && attacker.team == game.attackers) {
            if (!attacker function_359fc065() || level.capturetime == 0 && attacker istouching(zone.trigger)) {
                scoreevents::processscoreevent(#"war_killed_enemy_while_capping_control", attacker, victim, weapon);
            }
            scoreevents::processscoreevent(#"war_killed_defender_in_zone", attacker, victim, weapon);
        }
        return;
    }
    victim function_f87fa8d3(attacker, weapon);
}

// Namespace mission_koth/control
// Params 9, eflags: 0x0
// Checksum 0x7564b01d, Offset: 0x1a00
// Size: 0x204
function on_player_killed(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    if (!isdefined(self) || !isdefined(attacker) || !isplayer(attacker)) {
        return;
    }
    if (attacker != self && isdefined(self.pers) && self.pers[#"lives"] == 0) {
        scoreevents::processscoreevent(#"eliminated_enemy", attacker, self, weapon);
    }
    if (self.team == game.attackers && attacker.team == game.defenders) {
        if (!self function_359fc065()) {
            scoreevents::processscoreevent(#"war_killed_attacker_in_zone", attacker, self, weapon);
            return;
        }
        if (level.capturetime == 0) {
            foreach (zone in level.zones) {
                if (self istouching(zone.trigger)) {
                    scoreevents::processscoreevent(#"war_killed_attacker_in_zone", attacker, self, weapon);
                    break;
                }
            }
        }
    }
}

// Namespace mission_koth/control
// Params 2, eflags: 0x0
// Checksum 0x3b01a88e, Offset: 0x1c10
// Size: 0x1b8
function function_f87fa8d3(attacker, weapon) {
    if (!isplayer(attacker)) {
        return;
    }
    foreach (zone in level.zones) {
        if (!isdefined(zone.trigger)) {
            continue;
        }
        if (!(isdefined(zone.gameobject.var_221fc67) && zone.gameobject.var_221fc67) && self istouching(zone.trigger, (350, 350, 100))) {
            if (self.team == game.attackers && attacker.team == game.defenders) {
                scoreevents::processscoreevent(#"killed_attacker", attacker, self, weapon);
            }
            if (self.team == game.defenders && attacker.team == game.attackers) {
                scoreevents::processscoreevent(#"killed_defender", attacker, self, weapon);
            }
        }
    }
}

// Namespace mission_koth/control
// Params 1, eflags: 0x0
// Checksum 0xbe747cda, Offset: 0x1dd0
// Size: 0x82
function get_player_userate(use_object) {
    use_rate_multiplier = 1;
    if (isdefined(self.playerrole)) {
        if (self.team == game.attackers) {
            use_rate_multiplier = self.playerrole.attackercapturemultiplier;
        } else if (self.team == game.defenders) {
            use_rate_multiplier = self.playerrole.defenddecaymultiplier;
        }
    }
    return use_rate_multiplier;
}

// Namespace mission_koth/control
// Params 0, eflags: 0x0
// Checksum 0x5fa75e39, Offset: 0x1e60
// Size: 0x24
function on_player_connect() {
    self gameobjects::setplayergametypeuseratecallback(&get_player_userate);
}

// Namespace mission_koth/control
// Params 0, eflags: 0x4
// Checksum 0x37d82774, Offset: 0x1e90
// Size: 0x2a
function private use_start_spawns() {
    level waittill(#"grace_period_ending");
    level.usestartspawns = 0;
}

// Namespace mission_koth/control
// Params 0, eflags: 0x0
// Checksum 0x72e94cad, Offset: 0x1ec8
// Size: 0xdc
function on_start_gametype() {
    level.usingextratime = 0;
    level.wartotalsecondsinzone = 0;
    level.round_winner = undefined;
    setup_objectives();
    globallogic_score::resetteamscores();
    level.zonemask = 0;
    level.zonestatemask = 0;
    thread use_start_spawns();
    userspawnselection::supressspawnselectionmenuforallplayers();
    setup_zones();
    updatespawns();
    thread set_ui_team();
    thread main_loop();
    thread function_319af946();
}

// Namespace mission_koth/control
// Params 0, eflags: 0x0
// Checksum 0x2156e128, Offset: 0x1fb0
// Size: 0x57a
function setup_zones() {
    level.zones = get_zone_array();
    if (level.zones.size == 0) {
        globallogic_utils::print_map_errors();
        return 0;
    }
    if (level.zones.size > 1) {
        level.nzones = level.zones.size;
        trigs = getentarray("control_zone_trigger", "targetname");
    } else {
        level.nzones = 1;
        trigs = getentarray("control_zone_trigger", "targetname");
    }
    for (zi = 0; zi < level.nzones; zi++) {
        zone = level.zones[zi];
        errored = 0;
        zone.trigger = undefined;
        for (j = 0; j < trigs.size; j++) {
            if (zone istouching(trigs[j])) {
                if (isdefined(zone.trigger)) {
                    globallogic_utils::add_map_error("Zone at " + zone.origin + " is touching more than one \"zonetrigger\" trigger");
                    errored = 1;
                    break;
                }
                zone.trigger = trigs[j];
                break;
            }
        }
        if (!isdefined(zone.trigger)) {
            if (!errored) {
                globallogic_utils::add_map_error("Zone at " + zone.origin + " is not inside any \"zonetrigger\" trigger");
                return;
            }
        }
        assert(!errored);
        zone.trigger trigger::function_5345af18(16);
        zone.trigorigin = zone.trigger.origin;
        zone.objectiveanchor = spawn("script_model", zone.origin);
        visuals = [];
        visuals[0] = zone;
        if (isdefined(zone.target)) {
            othervisuals = getentarray(zone.target, "targetname");
            for (j = 0; j < othervisuals.size; j++) {
                visuals[visuals.size] = othervisuals[j];
            }
        }
        ownerteam = game.defenders;
        if (isdefined(level.neutralzone) && level.neutralzone) {
            ownerteam = #"neutral";
        }
        zone.gameobject = gameobjects::create_use_object(ownerteam, zone.trigger, visuals, (0, 0, 0), "control_" + zi);
        zone.gameobject gameobjects::set_objective_entity(zone);
        zone.gameobject gameobjects::disable_object();
        zone.gameobject gameobjects::set_model_visibility(0);
        zone.gameobject.owningzone = zone;
        zone.trigger.useobj = zone.gameobject;
        zone.gameobject.lastteamtoownzone = #"neutral";
        zone.gameobject.currentlyunoccupied = 1;
        zone.gameobject.var_c518b47a = !level.flagcapturerateincrease;
        zone.zoneindex = zi;
        zone.scores = [];
        foreach (team, _ in level.teams) {
            zone.scores[team] = 0;
        }
        zone setup_zone_exclusions();
    }
    if (globallogic_utils::print_map_errors()) {
        return 0;
    }
}

// Namespace mission_koth/control
// Params 0, eflags: 0x4
// Checksum 0xff9f153d, Offset: 0x2538
// Size: 0xa4
function private function_4fdb87a6() {
    spawning::add_spawn_points(game.attackers, "mp_strong_spawn_attacker_region_1");
    spawning::add_spawn_points(game.defenders, "mp_strong_spawn_defender_region_1");
    spawning::updateallspawnpoints();
    if (level.usestartspawns) {
        spawning::add_start_spawn_points(game.attackers, "mp_war_spawn_attacker_zone_1_start");
        spawning::add_start_spawn_points(game.defenders, "mp_war_spawn_defender_zone_1_start");
    }
}

// Namespace mission_koth/control
// Params 2, eflags: 0x0
// Checksum 0x1a78443f, Offset: 0x25e8
// Size: 0xfc
function compare_zone_indicies(zone_a, zone_b) {
    script_index_a = zone_a.script_index;
    script_index_b = zone_b.script_index;
    if (!isdefined(script_index_a) && !isdefined(script_index_b)) {
        return false;
    }
    if (!isdefined(script_index_a) && isdefined(script_index_b)) {
        println("<dev string:x30>" + zone_a.origin);
        return true;
    }
    if (isdefined(script_index_a) && !isdefined(script_index_b)) {
        println("<dev string:x30>" + zone_b.origin);
        return false;
    }
    if (script_index_a > script_index_b) {
        return true;
    }
    return false;
}

// Namespace mission_koth/control
// Params 0, eflags: 0x0
// Checksum 0x23d90416, Offset: 0x26f0
// Size: 0x37c
function get_zone_array() {
    allzones = getentarray("control_zone_center", "targetname");
    if (!isdefined(allzones)) {
        globallogic_utils::add_map_error("Cannot find any zone entities");
        return [];
    }
    if (allzones.size == 0) {
        globallogic_utils::add_map_error("There are no control zones defined for this map " + util::get_map_name());
        return [];
    }
    if (allzones.size > 1) {
        zoneindices = [];
        numberofzones = allzones.size;
        for (i = 0; i < numberofzones; i++) {
            fieldname = "zoneinfo" + numberofzones + i + 1;
            index = isdefined(level.mission_bundle.(fieldname)) ? level.mission_bundle.(fieldname) : 0;
            zoneindices[zoneindices.size] = index;
        }
        zones = [];
        for (i = 0; i < allzones.size; i++) {
            ind = allzones[i].script_index;
            if (isdefined(ind)) {
                for (j = 0; j < zoneindices.size; j++) {
                    if (zoneindices[j] == ind) {
                        zones[zones.size] = allzones[i];
                        break;
                    }
                }
                continue;
            }
            globallogic_utils::add_map_error("Zone with no script_index set");
        }
    } else {
        zones = getentarray("control_zone_center", "targetname");
    }
    if (!isdefined(zones)) {
        globallogic_utils::add_map_error("Cannot find any zone entities");
        return [];
    }
    swapped = 1;
    for (n = zones.size; swapped; n--) {
        swapped = 0;
        for (i = 0; i < n - 1; i++) {
            if (compare_zone_indicies(zones[i], zones[i + 1])) {
                temp = zones[i];
                zones[i] = zones[i + 1];
                zones[i + 1] = temp;
                swapped = 1;
            }
        }
    }
    for (i = 0; i < zones.size; i++) {
        zones[i].zone_index = i;
    }
    return zones;
}

// Namespace mission_koth/control
// Params 2, eflags: 0x0
// Checksum 0x3fdf1e7d, Offset: 0x2a78
// Size: 0xe6
function update_objective_hint_message(attackersmsg, defendersmsg) {
    gametype = util::get_game_type();
    foreach (team, _ in level.teams) {
        if (team == game.attackers) {
            game.strings["objective_hint_" + team] = attackersmsg;
            continue;
        }
        game.strings["objective_hint_" + team] = defendersmsg;
    }
}

// Namespace mission_koth/control
// Params 0, eflags: 0x0
// Checksum 0xed22951c, Offset: 0x2b68
// Size: 0x152
function setup_objectives() {
    level.objectivehintpreparezone = #"mp/control_koth";
    level.objectivehintcapturezone = #"mp/capture_koth";
    level.objectivehintdefendhq = #"mp/defend_koth";
    if (level.zonespawntime) {
        update_objective_hint_message(level.objectivehintpreparezone);
    } else {
        update_objective_hint_message(level.objectivehintcapturezone);
    }
    game.strings[game.attackers + "_mission_win"] = #"hash_6ed10cd957ecbde6";
    game.strings[game.attackers + "_mission_loss"] = #"hash_504843f8a8fe0230";
    game.strings[game.defenders + "_mission_win"] = #"hash_74e465610ac830ce";
    game.strings[game.defenders + "_mission_loss"] = #"hash_7d37cafde0ab4ecd";
}

// Namespace mission_koth/control
// Params 1, eflags: 0x0
// Checksum 0xff91e3d0, Offset: 0x2cc8
// Size: 0xd4
function toggle_zone_effects(enabled) {
    if (enabled) {
        level.zonemask |= 1 << self.zone_index;
    } else {
        level.zonemask &= ~(1 << self.zone_index);
    }
    level.zonestatemask &= ~(3 << self.zone_index);
    level clientfield::set("warzone", level.zonemask);
    level clientfield::set("warzonestate", level.zonestatemask);
}

// Namespace mission_koth/control
// Params 0, eflags: 0x0
// Checksum 0xccca3148, Offset: 0x2da8
// Size: 0x340
function main_loop() {
    level endon(#"game_ended");
    while (level.inprematchperiod) {
        waitframe(1);
    }
    thread hide_timer_on_game_end();
    wait 1;
    sound::play_on_players("mp_suitcase_pickup");
    if (level.zonespawntime && !(isdefined(level.neutralzone) && level.neutralzone)) {
        foreach (zone in level.zones) {
            zone.gameobject gameobjects::set_flags(1);
        }
        update_objective_hint_message(level.objectivehintpreparezone);
        wait level.zonespawntime;
        foreach (zone in level.zones) {
            zone.gameobject gameobjects::set_flags(0);
        }
    }
    waittillframeend();
    if (isdefined(level.neutralzone) && level.neutralzone) {
        update_objective_hint_message(#"mp/capture_strong", #"mp/capture_strong");
    } else {
        update_objective_hint_message(#"mp/capture_strong", #"mp/defend_strong");
    }
    sound::play_on_players("mpl_hq_cap_us");
    thread audio_loop();
    thread function_6c811005();
    foreach (zone in level.zones) {
        thread capture_loop(zone);
    }
    level.capturedzones = 0;
    while (level.capturedzones < level.zones.size) {
        res = level waittill(#"zone_captured");
        waitframe(1);
    }
}

// Namespace mission_koth/control
// Params 0, eflags: 0x0
// Checksum 0x2d30b863, Offset: 0x30f0
// Size: 0x10e
function audio_loop() {
    level endon(#"game_ended");
    self notify(#"audio_loop_singleton");
    self endon(#"audio_loop_singleton");
    while (true) {
        foreach (zone in level.zones) {
            if (is_zone_contested(zone.gameobject)) {
                playsoundatposition(#"mpl_zone_contested", zone.gameobject.origin);
                break;
            }
        }
        wait 1;
    }
}

// Namespace mission_koth/control
// Params 0, eflags: 0x0
// Checksum 0x95c43f48, Offset: 0x3208
// Size: 0x9c
function function_6c811005() {
    level endon(#"game_ended");
    self notify(#"hash_5e9e72ecc3fc7569");
    self endon(#"hash_5e9e72ecc3fc7569");
    while (true) {
        for (i = 0; i < level.zones.size; i++) {
            update_timer(i, 0);
        }
        wait 0.1;
    }
}

// Namespace mission_koth/control
// Params 0, eflags: 0x0
// Checksum 0xfe8f46d4, Offset: 0x32b0
// Size: 0x3c
function function_2369cd9b() {
    util::wait_network_frame();
    util::wait_network_frame();
    self toggle_zone_effects(1);
}

// Namespace mission_koth/control
// Params 1, eflags: 0x0
// Checksum 0xf1111d32, Offset: 0x32f8
// Size: 0x5d6
function capture_loop(zone) {
    level endon(#"game_ended");
    level.warstarttime = gettime();
    zone.gameobject gameobjects::set_flags(0);
    zone.gameobject gameobjects::enable_object();
    objective_onentity(zone.gameobject.objectiveid, zone.objectiveanchor);
    zone.gameobject.capturecount = 0;
    zone.gameobject gameobjects::allow_use(#"enemy");
    zone.gameobject gameobjects::set_use_time(level.capturetime);
    zone.gameobject gameobjects::set_use_text(#"mp/capturing_objective");
    numtouching = zone.gameobject get_num_touching();
    zone.gameobject gameobjects::set_visible_team(#"any");
    zone.gameobject gameobjects::set_model_visibility(1);
    zone.gameobject gameobjects::must_maintain_claim(0);
    zone.gameobject gameobjects::can_contest_claim(1);
    zone.gameobject.decayprogress = 1;
    zone.gameobject gameobjects::set_decay_time(level.capturetime);
    zone.autodecaytime = level.autodecaytime;
    if (isdefined(level.neutralzone) && level.neutralzone) {
        zone.gameobject.onuse = &on_zone_capture_neutral;
    } else {
        zone.gameobject.onuse = &on_zone_capture;
    }
    zone.gameobject.onbeginuse = &on_begin_use;
    zone.gameobject.onenduse = &on_end_use;
    zone.gameobject.ontouchuse = &on_touch_use;
    zone.gameobject.onupdateuserate = &function_2348a677;
    zone.gameobject.onendtouchuse = &on_end_touch_use;
    zone.gameobject.onresumeuse = &on_touch_use;
    zone.gameobject.stage = 1;
    if (isdefined(level.neutralzone) && level.neutralzone) {
        zone.gameobject.onuseupdate = &on_use_update_neutral;
    } else {
        zone.gameobject.onuseupdate = &on_use_update;
    }
    zone.gameobject.ondecaycomplete = &on_decay_complete;
    zone thread function_2369cd9b();
    spawn_beacon::function_8ebadd52(zone.trigger);
    level waittill("zone_captured" + zone.zone_index, #"mission_timed_out");
    ownerteam = zone.gameobject gameobjects::get_owner_team();
    profilestart();
    zone.gameobject.lastcaptureteam = undefined;
    zone.gameobject gameobjects::set_visible_team(#"any");
    zone.gameobject gameobjects::allow_use(#"none");
    zone.gameobject gameobjects::set_owner_team(#"neutral");
    zone.gameobject gameobjects::set_model_visibility(0);
    zone.gameobject gameobjects::must_maintain_claim(0);
    zone.gameobject.decayprogress = 1;
    zone.autodecaytime = level.autodecaytime;
    objective_setstate(zone.gameobject.objectiveid, "done");
    zone toggle_zone_effects(0);
    spawn_beacon::function_931025c3(zone.trigger);
    zone.gameobject gameobjects::disable_object();
    profilestop();
}

// Namespace mission_koth/control
// Params 0, eflags: 0x4
// Checksum 0x3d2d425c, Offset: 0x38d8
// Size: 0x8e
function private get_num_touching() {
    numtouching = 0;
    foreach (team, _ in level.teams) {
        numtouching += self.numtouching[team];
    }
    return numtouching;
}

// Namespace mission_koth/control
// Params 0, eflags: 0x4
// Checksum 0xb491e35a, Offset: 0x3970
// Size: 0x5c
function private hide_timer_on_game_end() {
    level notify(#"hide_timer_on_game_end");
    level endon(#"hide_timer_on_game_end");
    level waittill(#"game_ended");
    setmatchflag("bomb_timer_a", 0);
}

// Namespace mission_koth/control
// Params 2, eflags: 0x4
// Checksum 0x3f286376, Offset: 0x39d8
// Size: 0xb6
function private give_held_credit(touchlist, team) {
    wait 0.05;
    util::waittillslowprocessallowed();
    foreach (touch in touchlist) {
        player = gameobjects::function_4de10422(touchlist, touch);
        if (!isdefined(player)) {
        }
    }
}

// Namespace mission_koth/control
// Params 1, eflags: 0x4
// Checksum 0x6c9852db, Offset: 0x3a98
// Size: 0x5e
function private checkifshouldupdateattackerstatusplayback(sentient) {
    if (sentient.team != game.attackers) {
        return;
    }
    if (!isdefined(self.lastteamtoownzone)) {
        return;
    }
    if (self.lastteamtoownzone == sentient.team) {
        return;
    }
    self.needsattackerstatusplayback = 1;
}

// Namespace mission_koth/control
// Params 1, eflags: 0x4
// Checksum 0x18f17f7d, Offset: 0x3b00
// Size: 0x5e
function private checkifshouldupdatedefenderstatusplayback(sentient) {
    if (sentient.team != game.defenders) {
        return;
    }
    if (isdefined(self.lastteamtoownzone) && self.lastteamtoownzone == sentient.team) {
        return;
    }
    self.needsdefenderstatusplayback = 1;
}

// Namespace mission_koth/control
// Params 1, eflags: 0x4
// Checksum 0xaaf3db16, Offset: 0x3b68
// Size: 0x6c
function private checkifshouldupdatestatusplayback(sentient) {
    if (isdefined(level.neutralzone) && level.neutralzone) {
        self.needsallstatusplayback = 1;
        return;
    }
    checkifshouldupdateattackerstatusplayback(sentient);
    checkifshouldupdatedefenderstatusplayback(sentient);
}

// Namespace mission_koth/control
// Params 0, eflags: 0x4
// Checksum 0x9dcded96, Offset: 0x3be0
// Size: 0x18e
function private function_2348a677() {
    if (!isdefined(self.contested)) {
        self.contested = 0;
    }
    var_66214776 = self.contested;
    self.contested = is_zone_contested(self);
    if (self.contested) {
        if (!var_66214776) {
            foreach (playerlist in self.touchlist) {
                foreach (struct in playerlist) {
                    player = struct.player;
                    if ((isdefined(player.var_8a599de9) ? player.var_8a599de9 : 0) < gettime()) {
                        player playsoundtoplayer("mpl_control_capture_contested", player);
                        player.var_8a599de9 = gettime() + 5000;
                    }
                }
            }
        }
    }
}

// Namespace mission_koth/control
// Params 1, eflags: 0x4
// Checksum 0x2b51b6c0, Offset: 0x3d78
// Size: 0xe4
function private on_touch_use(sentient) {
    if (isplayer(sentient)) {
        if (is_zone_contested(self) && (isdefined(sentient.var_8a599de9) ? sentient.var_8a599de9 : 0) < gettime()) {
            sentient playsoundtoplayer("mpl_control_capture_contested", sentient);
            sentient.var_8a599de9 = gettime() + 5000;
        }
        sentient thread player_use_loop(self);
    }
    self checkifshouldupdatestatusplayback(sentient);
    self update_team_client_field();
}

// Namespace mission_koth/control
// Params 1, eflags: 0x4
// Checksum 0x9e93b280, Offset: 0x3e68
// Size: 0x44
function private on_end_touch_use(sentient) {
    sentient notify("use_stopped" + self.owningzone.zone_index);
    self update_team_client_field();
}

// Namespace mission_koth/control
// Params 3, eflags: 0x4
// Checksum 0xfb9b9dbc, Offset: 0x3eb8
// Size: 0x54
function private on_end_use(team, sentient, success) {
    sentient notify("event_ended" + self.owningzone.zone_index);
    self update_team_client_field();
}

// Namespace mission_koth/control
// Params 2, eflags: 0x4
// Checksum 0xf4073846, Offset: 0x3f18
// Size: 0x8c
function private play_objective_audio(audiocue, team) {
    if (isdefined(level.audiocues[audiocue])) {
        if (level.audiocues[audiocue] + level.audioplaybackthrottle > gettime()) {
            return;
        }
    }
    level.audiocues[audiocue] = gettime();
    thread globallogic_audio::leader_dialog(audiocue, team, undefined, "gamemode_objective", undefined, "kothActiveDialogBuffer");
}

// Namespace mission_koth/control
// Params 2, eflags: 0x4
// Checksum 0x7eec712, Offset: 0x3fb0
// Size: 0x1e8
function private process_zone_capture_audio(zone, capture_team) {
    foreach (team, _ in level.teams) {
        if (team == capture_team) {
            soundkey = "controlZ" + zone.zone_index + 1 + "TakenOfs";
            play_objective_audio(soundkey, team);
            if (level.nzones == 0) {
                soundkey = "controlAllZonesCapOfs";
            } else {
                soundkey = "controlLastZoneOfs";
            }
            play_objective_audio(soundkey, team);
            thread sound::play_on_players(game.objective_gained_sound, team);
            continue;
        }
        soundkey = "controlZ" + zone.zone_index + 1 + "LostDef";
        play_objective_audio(soundkey, team);
        if (level.nzones == 0) {
            soundkey = "controlAllZonesCapDef";
        } else {
            soundkey = "controlLastZoneDef";
        }
        play_objective_audio(soundkey, team);
        thread sound::play_on_players(game.objective_lost_sound, team);
    }
}

// Namespace mission_koth/control
// Params 1, eflags: 0x0
// Checksum 0x4f2595d2, Offset: 0x41a0
// Size: 0xa4
function ononeleftevent(team) {
    index = util::function_12544d86(team);
    players = level.players;
    if (index == players.size) {
        return;
    }
    player = players[index];
    util::function_d1f9db00(17, player.team, player getentitynumber());
}

// Namespace mission_koth/control
// Params 1, eflags: 0x4
// Checksum 0xb435cd99, Offset: 0x4250
// Size: 0x58c
function private on_zone_capture(sentient) {
    level.nzones--;
    capture_team = sentient.team;
    capturetime = gettime();
    string = #"hash_6d6f47aad6be619f";
    if (!isdefined(self.lastcaptureteam) || self.lastcaptureteam != capture_team) {
        if (isdefined(getgametypesetting(#"contributioncapture")) && getgametypesetting(#"contributioncapture")) {
            var_17a75d13 = arraycopy(self.var_17a75d13[capture_team]);
            self thread function_37dbf0d5(var_17a75d13, string, capturetime, capture_team, self.lastcaptureteam);
        } else {
            touchlist = arraycopy(self.touchlist[capture_team]);
            thread give_capture_credit(touchlist, string, capturetime, capture_team, self.lastcaptureteam);
        }
    }
    level.warcapteam = capture_team;
    level.war_mission_succeeded = 1;
    util::function_d1f9db00(20, sentient.team, -1, function_ff111bb1(self.var_977e04c1));
    self gameobjects::set_owner_team(capture_team);
    foreach (team, _ in level.teams) {
        if (team == capture_team) {
            for (index = 0; index < level.players.size; index++) {
                player = level.players[index];
                if (player.pers[#"team"] == team) {
                    if (player.lastkilltime + 500 > gettime()) {
                        player challenges::killedlastcontester();
                    }
                }
            }
        }
    }
    process_zone_capture_audio(self.owningzone, capture_team);
    self.capturecount++;
    self.lastcaptureteam = capture_team;
    self.var_221fc67 = 1;
    self gameobjects::must_maintain_claim(1);
    self update_team_client_field();
    if (isplayer(sentient)) {
        sentient recordgameevent("hardpoint_captured");
    }
    level.capturedzones++;
    if (level.capturedzones == 1 && [[ level.gettimelimit ]]() > 0) {
        level.usingextratime = 1;
    }
    if (level.capturedzones == 1 && (isdefined(level.bonuslivesforcapturingzone) ? level.bonuslivesforcapturingzone : 0) > 0 && capture_team == game.attackers) {
        game.lives[game.attackers] = game.lives[game.attackers] + level.bonuslivesforcapturingzone;
        teamid = "team" + level.teamindex[game.attackers];
        clientfield::set_world_uimodel("hudItems." + teamid + ".livesCount", game.lives[game.attackers]);
    }
    level notify("zone_captured" + self.owningzone.zone_index);
    level notify(#"zone_captured");
    level notify("zone_captured" + capture_team);
    sentient notify("event_ended" + self.owningzone.zone_index);
    if (level.zones.size == level.capturedzones) {
        round::set_winner(game.attackers);
        wait 2.5;
        level thread globallogic::end_round(1);
    }
    thread updatespawns();
}

// Namespace mission_koth/control
// Params 1, eflags: 0x4
// Checksum 0x40bf67d2, Offset: 0x47e8
// Size: 0x426
function private on_zone_capture_neutral(sentient) {
    capture_team = sentient.team;
    capturetime = gettime();
    string = #"hash_6d6f47aad6be619f";
    if (!isdefined(self.lastcaptureteam) || self.lastcaptureteam != capture_team) {
        if (isdefined(getgametypesetting(#"contributioncapture")) && getgametypesetting(#"contributioncapture")) {
            var_17a75d13 = arraycopy(self.var_17a75d13[capture_team]);
            self thread function_37dbf0d5(var_17a75d13, string, capturetime, capture_team, self.lastcaptureteam);
        } else {
            touchlist = arraycopy(self.touchlist[capture_team]);
            thread give_capture_credit(touchlist, string, capturetime, capture_team, self.lastcaptureteam);
        }
    }
    level.warcapteam = capture_team;
    level.war_mission_succeeded = 1;
    if (!(isdefined(level.decaycapturedzones) && level.decaycapturedzones)) {
        if (self.ownerteam != capture_team) {
            self thread award_capture_points_neutral(capture_team);
            self gameobjects::set_owner_team(capture_team);
        }
    } else {
        if (self.ownerteam == #"neutral") {
            self gameobjects::set_owner_team(capture_team);
            self thread award_capture_points_neutral(capture_team);
        }
        if (self.ownerteam != capture_team) {
            level notify(#"awardcapturepointsrunningneutral");
            self gameobjects::set_owner_team(#"neutral");
        }
    }
    foreach (team, _ in level.teams) {
        if (team == capture_team) {
            for (index = 0; index < level.players.size; index++) {
                player = level.players[index];
                if (player.pers[#"team"] == team) {
                    if (player.lastkilltime + 500 > gettime()) {
                        player challenges::killedlastcontester();
                    }
                }
            }
        }
    }
    process_zone_capture_audio(self.owningzone, capture_team);
    self.capturecount++;
    self.lastcaptureteam = capture_team;
    self gameobjects::must_maintain_claim(1);
    self update_team_client_field();
    if (isplayer(sentient)) {
        sentient recordgameevent("hardpoint_captured");
    }
    sentient notify("event_ended" + self.owningzone.zone_index);
}

// Namespace mission_koth/control
// Params 5, eflags: 0x4
// Checksum 0x55ee5538, Offset: 0x4c18
// Size: 0x2bc
function private function_37dbf0d5(var_17a75d13, string, capturetime, capture_team, lastcaptureteam) {
    var_dbec024d = [];
    earliestplayer = undefined;
    foreach (contribution in var_17a75d13) {
        if (isdefined(contribution)) {
            contributor = contribution.player;
            if (isdefined(contributor) && isdefined(contribution.contribution)) {
                percentage = 100 * contribution.contribution / self.usetime;
                contributor.var_7709e43f = int(0.5 + percentage);
                contributor.var_213804be = contribution.starttime;
                if (percentage < getgametypesetting(#"contributionmin")) {
                    continue;
                }
                if (contribution.var_664a1806 && (!isdefined(earliestplayer) || contributor.var_213804be < earliestplayer.var_213804be)) {
                    earliestplayer = contributor;
                }
                if (!isdefined(var_dbec024d)) {
                    var_dbec024d = [];
                } else if (!isarray(var_dbec024d)) {
                    var_dbec024d = array(var_dbec024d);
                }
                var_dbec024d[var_dbec024d.size] = contributor;
            }
        }
    }
    foreach (player in var_dbec024d) {
        var_5bda891e = earliestplayer === player;
        credit_player(player, string, capturetime, capture_team, lastcaptureteam, var_5bda891e);
    }
    self gameobjects::function_1aca7f5();
}

// Namespace mission_koth/control
// Params 5, eflags: 0x4
// Checksum 0x6d53fac7, Offset: 0x4ee0
// Size: 0xe0
function private give_capture_credit(touchlist, string, capturetime, capture_team, lastcaptureteam) {
    foreach (touch in touchlist) {
        player = gameobjects::function_4de10422(touchlist, touch);
        if (!isdefined(player)) {
            continue;
        }
        credit_player(player, string, capturetime, capture_team, lastcaptureteam, 0);
    }
}

// Namespace mission_koth/control
// Params 6, eflags: 0x4
// Checksum 0x844b3aeb, Offset: 0x4fc8
// Size: 0x34c
function private credit_player(player, string, capturetime, capture_team, lastcaptureteam, var_5bda891e) {
    player update_caps_per_minute(lastcaptureteam);
    if (!is_score_boosting(player)) {
        player challenges::capturedobjective(capturetime, self.trigger);
        if (level.warstarttime + 3000 > capturetime && level.warcapteam == capture_team) {
        }
        scoreevents::processscoreevent(#"war_captured_zone", player, undefined, undefined);
        player recordgameevent("capture");
        if (var_5bda891e) {
            level thread popups::displayteammessagetoall(string, player);
        }
        if (isdefined(player.pers[#"captures"])) {
            player.pers[#"captures"]++;
            player.captures = player.pers[#"captures"];
        }
        player.pers[#"objectives"]++;
        player.objectives = player.pers[#"objectives"];
        if (level.warstarttime + 500 > capturetime) {
            player challenges::immediatecapture();
        }
        demo::bookmark(#"event", gettime(), player);
        potm::bookmark(#"event", gettime(), player);
        player stats::function_2dabbec7(#"captures", 1);
        player globallogic_score::incpersstat("objectiveScore", 1, 0, 1);
        if (isdefined(getgametypesetting(#"contributioncapture")) && getgametypesetting(#"contributioncapture")) {
            player luinotifyevent(#"waypoint_captured", 2, self.var_977e04c1, player.var_7709e43f);
            player.var_7709e43f = undefined;
        }
        return;
    }
    /#
        player iprintlnbold("<dev string:x56>");
    #/
}

// Namespace mission_koth/control
// Params 1, eflags: 0x4
// Checksum 0xdcd655dd, Offset: 0x5320
// Size: 0x58
function private is_zone_contested(gameobject) {
    if (gameobject.touchlist[game.attackers].size > 0 && gameobject.touchlist[game.defenders].size > 0) {
        return true;
    }
    return false;
}

// Namespace mission_koth/control
// Params 1, eflags: 0x0
// Checksum 0xd44c75de, Offset: 0x5380
// Size: 0x120
function award_capture_points_neutral(team) {
    level endon(#"game_ended");
    level notify("awardCapturePointsRunningNeutral" + self.owningzone.zone_index);
    level endon("awardCapturePointsRunningNeutral" + self.owningzone.zone_index);
    seconds = int(level.mission_bundle.msscoreinterval);
    if (!isdefined(seconds)) {
        seconds = 4;
    }
    score = int(level.mission_bundle.msscorevalue);
    if (!isdefined(score)) {
        score = 5;
    }
    while (!level.gameended) {
        wait seconds;
        hostmigration::waittillhostmigrationdone();
        globallogic_score::giveteamscoreforobjective(team, score);
    }
}

// Namespace mission_koth/control
// Params 1, eflags: 0x0
// Checksum 0x74744af9, Offset: 0x54a8
// Size: 0x224
function award_capture_points(team) {
    level endon(#"game_ended");
    level notify(#"awardcapturepointsrunning");
    level endon(#"awardcapturepointsrunning");
    seconds = 1;
    score = 1;
    while (!level.gameended) {
        wait seconds;
        hostmigration::waittillhostmigrationdone();
        if (!is_zone_contested(self)) {
            if (level.scoreperplayer) {
                score = self.numtouching[team];
            }
            globallogic_score::giveteamscoreforobjective(team, score);
            level.wartotalsecondsinzone++;
            foreach (player in level.aliveplayers[team]) {
                if (!isdefined(player.touchtriggers[self.entnum])) {
                    continue;
                }
                if (isdefined(player.pers[#"objtime"])) {
                    player.pers[#"objtime"]++;
                    player.objtime = player.pers[#"objtime"];
                }
                player stats::function_2dabbec7(#"objective_time", 1);
                player globallogic_score::incpersstat("objectiveTime", 1, 0, 1);
            }
        }
    }
}

// Namespace mission_koth/control
// Params 1, eflags: 0x0
// Checksum 0xbd6f75ad, Offset: 0x56d8
// Size: 0x1f6
function kill_while_contesting(victim) {
    self endon(#"disconnect");
    if (!isdefined(self.var_1af8f126) || self.var_1af8f126 + 5000 < gettime()) {
        self.clearenemycount = 0;
    }
    self.clearenemycount++;
    self.var_1af8f126 = gettime();
    foreach (trigger in victim.touchtriggers) {
        foreach (zone in level.zones) {
            if (trigger == zone.trigger) {
                point = zone.trigger.useobj;
                found = 1;
                break;
            }
        }
        if (found) {
            break;
        }
    }
    waitframe(1);
    if (isdefined(point) && point.touchlist[game.attackers].size == 0 && self.clearenemycount >= 2) {
        scoreevents::processscoreevent(#"clear_2_attackers", self, victim, undefined);
        self.clearenemycount = 0;
    }
}

// Namespace mission_koth/control
// Params 0, eflags: 0x0
// Checksum 0x6b051c5a, Offset: 0x58d8
// Size: 0x1be
function setup_zone_exclusions() {
    if (!isdefined(level.levelwardisable)) {
        return;
    }
    foreach (nullzone in level.levelwardisable) {
        mindist = 1410065408;
        foundzone = undefined;
        foreach (zone in level.zones) {
            distance = distancesquared(nullzone.origin, zone.origin);
            if (distance < mindist) {
                foundzone = zone;
                mindist = distance;
            }
        }
        if (isdefined(foundzone) && foundzone == self) {
            if (!isdefined(foundzone.gameobject.exclusions)) {
                foundzone.gameobject.exclusions = [];
            }
            foundzone.gameobject.exclusions[foundzone.gameobject.exclusions.size] = nullzone;
        }
    }
}

// Namespace mission_koth/control
// Params 1, eflags: 0x0
// Checksum 0x48c375b9, Offset: 0x5aa0
// Size: 0x3b0
function player_use_loop(gameobject) {
    self notify("player_use_loop_singleton" + gameobject.owningzone.zone_index);
    self endon("player_use_loop_singleton" + gameobject.owningzone.zone_index);
    player = self;
    player endon("use_stopped" + gameobject.owningzone.zone_index);
    player endon("event_ended" + gameobject.owningzone.zone_index);
    player endon(#"death");
    if (!isdefined(player.playerrole)) {
        return;
    }
    fast_capture_threshold = 1.5;
    fast_decay_threshold = 1;
    attacker_capture_multiplier = isdefined(player.playerrole.attackercapturemultiplier) ? player.playerrole.attackercapturemultiplier : 1;
    defend_decay_multiplier = isdefined(player.playerrole.defenddecaymultiplier) ? player.playerrole.defenddecaymultiplier : 1;
    if (attacker_capture_multiplier <= fast_capture_threshold && defend_decay_multiplier <= fast_decay_threshold) {
        return;
    }
    while (true) {
        while (!isdefined(gameobject.userate) || isdefined(gameobject.userate) && gameobject.userate == 0 || gameobject.claimteam == "none") {
            wait 0.2;
        }
        any_capture_progress = 0;
        any_decay_progress = 0;
        measure_progress_end_time = level.time + 5000;
        while (level.time < measure_progress_end_time) {
            prev_progress = gameobject.curprogress;
            wait 1;
            if (gameobject.curprogress > prev_progress) {
                any_capture_progress = 1;
                continue;
            }
            if (gameobject.curprogress < prev_progress) {
                any_decay_progress = 1;
            }
        }
        if (isdefined(gameobject.userate) && gameobject.userate != 0 && gameobject.claimteam != "none") {
            if (any_capture_progress && player.pers[#"team"] == game.attackers && attacker_capture_multiplier > fast_capture_threshold) {
                scoreevents::processscoreevent(#"fast_capture_progress", player, undefined, undefined);
                continue;
            }
            if (any_decay_progress && defend_decay_multiplier > fast_decay_threshold) {
                scoreevents::processscoreevent(#"fast_decay_progress", player, undefined, undefined);
            }
        }
    }
}

// Namespace mission_koth/control
// Params 1, eflags: 0x4
// Checksum 0x3f7e514b, Offset: 0x5e58
// Size: 0x10c
function private on_begin_use(sentient) {
    if (isplayer(sentient)) {
        ownerteam = self gameobjects::get_owner_team();
        if (ownerteam == #"neutral") {
            sentient thread battlechatter::gametype_specific_battle_chatter("hq_protect", sentient.pers[#"team"]);
        } else {
            sentient thread battlechatter::gametype_specific_battle_chatter("hq_attack", sentient.pers[#"team"]);
        }
    }
    self checkifshouldupdatestatusplayback(sentient);
    self update_team_client_field();
}

// Namespace mission_koth/control
// Params 1, eflags: 0x4
// Checksum 0x48fc82ba, Offset: 0x5f70
// Size: 0x86
function private isuserateelevated(touchlist) {
    foreach (touchinfo in touchlist) {
        if (touchinfo.userate > 1) {
            return true;
        }
    }
    return false;
}

// Namespace mission_koth/control
// Params 2, eflags: 0x4
// Checksum 0x65cfc411, Offset: 0x6000
// Size: 0xc2
function private isplayerinzonewithrole(touchlist, roletype) {
    foreach (touchinfo in touchlist) {
        if (isplayer(touchinfo.player) && touchinfo.player.playerrole.rolename == roletype) {
            return true;
        }
    }
    return false;
}

// Namespace mission_koth/control
// Params 1, eflags: 0x4
// Checksum 0xea07eee0, Offset: 0x60d0
// Size: 0x1a4
function private update_team_userate_clientfield(zone) {
    if (is_zone_contested(zone)) {
        clientfield::set_world_uimodel("hudItems.missions.captureMultiplierStatus", 0);
        zone.lastteamtoownzone = "contested";
        return;
    }
    if (zone.touchlist[game.attackers].size > 0) {
        if (isplayerinzonewithrole(zone.touchlist[game.attackers], "objective")) {
            clientfield::set_world_uimodel("hudItems.missions.captureMultiplierStatus", 1);
        }
        zone.lastteamtoownzone = game.attackers;
        return;
    }
    if (zone.touchlist[game.defenders].size > 0 && zone.curprogress > 0) {
        if (isplayerinzonewithrole(zone.touchlist[game.defenders], "objective")) {
            clientfield::set_world_uimodel("hudItems.missions.captureMultiplierStatus", 2);
        }
        zone.lastteamtoownzone = game.defenders;
        return;
    }
    clientfield::set_world_uimodel("hudItems.missions.captureMultiplierStatus", 0);
}

// Namespace mission_koth/control
// Params 0, eflags: 0x4
// Checksum 0xe3d412d0, Offset: 0x6280
// Size: 0x284
function private update_team_client_field() {
    level.zonestatemask = 0;
    for (zi = 0; zi < level.zones.size; zi++) {
        gameobj = level.zones[zi].gameobject;
        ownerteam = gameobj gameobjects::get_owner_team();
        state = 0;
        flags = 0;
        if (isdefined(level.neutralzone) && level.neutralzone) {
            if (gameobj.claimteam == "none" || !isdefined(level.teamindex[gameobj.claimteam])) {
                flags = 0;
            } else {
                flags = level.teamindex[gameobj.claimteam];
            }
        } else if (is_zone_contested(gameobj)) {
            state = 3;
        } else if (gameobj.claimteam != "none" && gameobj.numtouching[gameobj.claimteam] > 0) {
            if (gameobj.claimteam == game.attackers) {
                state = 2;
                flags = level.teamindex[gameobj.claimteam];
            } else {
                state = 1;
            }
        } else if (gameobj.numtouching[ownerteam]) {
            if (ownerteam == game.attackers) {
                state = 2;
                flags = 1;
            } else {
                state = 1;
            }
        }
        level.zonestatemask |= state << zi * 2;
        gameobj gameobjects::set_flags(flags);
    }
    level clientfield::set("warzonestate", level.zonestatemask);
    update_team_userate_clientfield(self);
}

// Namespace mission_koth/control
// Params 1, eflags: 0x0
// Checksum 0x461e4767, Offset: 0x6510
// Size: 0x12a
function update_caps_per_minute(lastownerteam) {
    if (!isdefined(self.capsperminute)) {
        self.numcaps = 0;
        self.capsperminute = 0;
    }
    if (!isdefined(lastownerteam) || lastownerteam == #"neutral") {
        return;
    }
    self.numcaps++;
    minutespassed = float(globallogic_utils::gettimepassed()) / 60000;
    if (isplayer(self) && isdefined(self.timeplayed[#"total"])) {
        minutespassed = self.timeplayed[#"total"] / 60;
    }
    self.capsperminute = self.numcaps / minutespassed;
    if (self.capsperminute > self.numcaps) {
        self.capsperminute = self.numcaps;
    }
}

// Namespace mission_koth/control
// Params 1, eflags: 0x0
// Checksum 0x9b494db0, Offset: 0x6648
// Size: 0x3e
function is_score_boosting(player) {
    if (!level.rankedmatch) {
        return false;
    }
    if (player.capsperminute > level.playercapturelpm) {
        return true;
    }
    return false;
}

// Namespace mission_koth/control
// Params 0, eflags: 0x0
// Checksum 0x3b962eb4, Offset: 0x6690
// Size: 0x168
function on_decay_complete() {
    clientfield::set_world_uimodel("hudItems.missions.captureMultiplierStatus", 0);
    self gameobjects::set_flags(0);
    if (!(isdefined(self.var_e6e0f0c6) && self.var_e6e0f0c6)) {
        if (self.touchlist[game.attackers].size == 0 && self.touchlist[game.defenders].size > 0) {
            self.var_e6e0f0c6 = 1;
            foreach (st in self.touchlist[game.defenders]) {
                player_from_touchlist = gameobjects::function_4de10422(self.touchlist[game.defenders], st);
                if (!isdefined(player_from_touchlist)) {
                    continue;
                }
                scoreevents::processscoreevent(#"hash_abbc936bf9059a6", player_from_touchlist, undefined, undefined);
            }
        }
    }
}

// Namespace mission_koth/control
// Params 0, eflags: 0x0
// Checksum 0x7d03a754, Offset: 0x6800
// Size: 0xf6
function score_capture_progress() {
    trig = self.owningzone.trigger;
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        player = players[i];
        if (player.team == game.attackers) {
            player playsoundtoplayer(#"hash_554eb90f62c68b44", player);
            if (player istouching(trig)) {
                scoreevents::processscoreevent(#"war_capture_progress", player);
            }
        }
    }
}

// Namespace mission_koth/control
// Params 3, eflags: 0x0
// Checksum 0xcb3abafd, Offset: 0x6900
// Size: 0x73e
function on_use_update(team, progress, change) {
    if (isdefined(level.capdecay) && level.capdecay && !(isdefined(level.neutralzone) && level.neutralzone)) {
        if (progress >= 0.666667) {
            if (self.stage == 2) {
                self.decayprogressmin = int(0.666667 * self.usetime);
                score_capture_progress();
                self.stage = 3;
                util::function_d1f9db00(23, team, -1, function_ff111bb1(self.var_977e04c1));
            }
        } else if (progress >= 0.333333) {
            if (self.stage == 1) {
                self.decayprogressmin = int(0.333333 * self.usetime);
                score_capture_progress();
                self.stage = 2;
                util::function_d1f9db00(23, team, -1, function_ff111bb1(self.var_977e04c1));
            }
        }
    }
    if (!(isdefined(level.neutralzone) && level.neutralzone)) {
        update_timer(self.owningzone.zone_index, change);
    }
    if (change > 0 && self.currentlyunoccupied) {
        level.numzonesoccupied++;
        self.currentlyunoccupied = 0;
        players = getplayers();
        foreach (player in players) {
            if (player.team == game.attackers) {
                player playsoundtoplayer(#"hash_3cca41b3702f764a", player);
                continue;
            }
            player playsoundtoplayer(#"hash_2bb2a0ec776ba8f7", player);
        }
    } else if (change == 0 && !self.currentlyunoccupied) {
        level.numzonesoccupied--;
        self.currentlyunoccupied = 1;
    }
    if (progress > 0.05) {
        if (change > 0 && isdefined(self.needsattackerstatusplayback) && self.needsattackerstatusplayback) {
            if (!(isdefined(level.neutralzone) && level.neutralzone)) {
                if (level.numzonesoccupied <= 1) {
                    soundkeyofs = "controlZ" + self.owningzone.zone_index + 1 + "CapturingOfs";
                    soundkeydef = "controlZ" + self.owningzone.zone_index + 1 + "LosingDef";
                    play_objective_audio(soundkeyofs, game.attackers);
                    play_objective_audio(soundkeydef, game.defenders);
                } else {
                    play_objective_audio("controlZMCapturingOfs", game.attackers);
                    play_objective_audio("controlZMLosingDef", game.defenders);
                }
            }
            self.needsattackerstatusplayback = 0;
        } else if (change < 0 && isdefined(self.needsdefenderstatusplayback) && self.needsdefenderstatusplayback) {
            play_objective_audio("warLosingProgressOfs", game.attackers);
            play_objective_audio("warLosingProgressDef", game.defenders);
            self.needsdefenderstatusplayback = 0;
        }
    }
    if (isdefined(self.decayprogressmin) && change == 0 && (progress == 0.333333 || progress == 0.666667)) {
        if (clientfield::get_world_uimodel("hudItems.missions.captureMultiplierStatus") != 0) {
            clientfield::set_world_uimodel("hudItems.missions.captureMultiplierStatus", 0);
        }
    }
    if (change > 0) {
        self.var_e6e0f0c6 = undefined;
    }
    if (change == 0 && !(isdefined(self.var_e6e0f0c6) && self.var_e6e0f0c6)) {
        if (self.touchlist[game.attackers].size == 0 && self.touchlist[game.defenders].size > 0) {
            self.var_e6e0f0c6 = 1;
            foreach (st in self.touchlist[game.defenders]) {
                scoreevents::processscoreevent(#"zone_progress_drained", st.player, undefined, undefined);
            }
        }
    }
    if (self.touchlist[game.attackers].size == 0 && self.touchlist[game.defenders].size > 0) {
        if (!(isdefined(self.var_73d35096) && self.var_73d35096) && self.decayprogressmin === self.curprogress) {
            self update_team_client_field();
            self.var_73d35096 = 1;
        }
        return;
    }
    self.var_73d35096 = undefined;
}

// Namespace mission_koth/control
// Params 3, eflags: 0x0
// Checksum 0x55221411, Offset: 0x7048
// Size: 0x176
function on_use_update_neutral(team, progress, change) {
    if (progress > 0.05) {
        if (isdefined(self.needsallstatusplayback) && self.needsallstatusplayback) {
            if (change > 0) {
                if (self.ownerteam == #"neutral") {
                    play_objective_audio("warCapturingOfs", team);
                    play_objective_audio("warCapturingDef", util::getotherteam(team));
                    self.needsallstatusplayback = 0;
                } else {
                    play_objective_audio("warLosingProgressDef", team);
                    play_objective_audio("warLosingProgressOfs", util::getotherteam(team));
                    self.needsallstatusplayback = 0;
                }
                return;
            }
            if (change < 0) {
                play_objective_audio("warLosingProgressOfs", team);
                play_objective_audio("warLosingProgressDef", util::getotherteam(team));
                self.needsallstatusplayback = 0;
            }
        }
    }
}

// Namespace mission_koth/control
// Params 0, eflags: 0x4
// Checksum 0xde1cca4b, Offset: 0x71c8
// Size: 0x84
function private set_ui_team() {
    wait 0.05;
    if (game.attackers == #"allies" || isdefined(level.neutralzone) && level.neutralzone) {
        clientfield::set_world_uimodel("hudItems.war.attackingTeam", 1);
        return;
    }
    clientfield::set_world_uimodel("hudItems.war.attackingTeam", 2);
}

// Namespace mission_koth/control
// Params 0, eflags: 0x0
// Checksum 0x36ee7e95, Offset: 0x7258
// Size: 0x52
function pause_time() {
    if (level.timepauseswheninzone && !(isdefined(level.timerpaused) && level.timerpaused)) {
        globallogic_utils::pausetimer();
        level.timerpaused = 1;
    }
}

// Namespace mission_koth/control
// Params 0, eflags: 0x0
// Checksum 0x5a20b860, Offset: 0x72b8
// Size: 0x52
function resume_time() {
    if (level.timepauseswheninzone && isdefined(level.timerpaused) && level.timerpaused) {
        globallogic_utils::resumetimer();
        level.timerpaused = 0;
    }
}

// Namespace mission_koth/control
// Params 2, eflags: 0x0
// Checksum 0xfc730bb6, Offset: 0x7318
// Size: 0xfc
function update_timer(zoneindex, change) {
    if (change > 0 || is_zone_contested(level.zones[zoneindex].gameobject)) {
        level.zonepauseinfo[zoneindex] = 1;
        pause_time();
        return;
    }
    level.zonepauseinfo[zoneindex] = 0;
    for (zi = 0; zi < level.zones.size; zi++) {
        if (isdefined(level.zonepauseinfo[zi]) && level.zonepauseinfo[zi]) {
            return;
        }
    }
    resume_time();
}

// Namespace mission_koth/control
// Params 0, eflags: 0x0
// Checksum 0xbec1761f, Offset: 0x7420
// Size: 0x2d4
function function_319af946() {
    level endon(#"game_ended");
    self notify(#"hash_2562ed6d6d163c1a");
    self endon(#"hash_2562ed6d6d163c1a");
    while (true) {
        var_fa07092c = 1;
        for (i = 0; i < level.zones.size; i++) {
            if (!is_zone_contested(level.zones[i].gameobject)) {
                var_fa07092c = 0;
                level.var_ca870aaa = 0;
                break;
            }
        }
        if (var_fa07092c) {
            if (!(isdefined(level.var_ca870aaa) && level.var_ca870aaa)) {
                level.var_ca870aaa = 1;
                play_objective_audio("controlContestedOfsAll", game.attackers);
                play_objective_audio("controlContestedDefAll", game.defenders);
            }
        } else {
            if (is_zone_contested(level.zones[0].gameobject)) {
                if (!(isdefined(level.var_1bc31ae2[0]) && level.var_1bc31ae2[0])) {
                    level.var_1bc31ae2[0] = 1;
                    play_objective_audio("controlContestedOfsA", game.attackers);
                    play_objective_audio("controlContestedDefA", game.defenders);
                }
            } else {
                level.var_1bc31ae2[0] = 0;
            }
            if (is_zone_contested(level.zones[1].gameobject)) {
                if (!(isdefined(level.var_1bc31ae2[1]) && level.var_1bc31ae2[1])) {
                    level.var_1bc31ae2[1] = 1;
                    play_objective_audio("controlContestedOfsB", game.attackers);
                    play_objective_audio("controlContestedDefB", game.defenders);
                }
            } else {
                level.var_1bc31ae2[1] = 0;
            }
        }
        wait 0.2;
    }
}

// Namespace mission_koth/control
// Params 1, eflags: 0x0
// Checksum 0xb4c2ec37, Offset: 0x7700
// Size: 0x18c
function function_6958986e(var_c3d87d03) {
    gamemodedata = spawnstruct();
    gamemodedata.var_3cb5bfaa = game.lives[#"allies"];
    gamemodedata.var_f3a584bb = game.lives[#"axis"];
    switch (var_c3d87d03) {
    case 2:
        gamemodedata.wintype = "time_limit_reached";
        break;
    case 1:
        gamemodedata.wintype = "captured_all_zones";
        break;
    case 6:
        gamemodedata.wintype = "no_lives_left";
        break;
    case 9:
    case 10:
    default:
        gamemodedata.wintype = "NA";
        break;
    }
    gamemodedata.remainingtime = globallogic_utils::gettimeremaining();
    if (gamemodedata.remainingtime < 0) {
        gamemodedata.remainingtime = 0;
    }
    bb::function_a4648ef4(gamemodedata);
}

// Namespace mission_koth/control
// Params 1, eflags: 0x4
// Checksum 0xba164194, Offset: 0x7898
// Size: 0x4c
function private function_ff111bb1(var_53ad1e83) {
    if (var_53ad1e83 == "control_0") {
        var_3a58aa96 = 1;
    } else if (var_53ad1e83 == "control_1") {
        var_3a58aa96 = 2;
    }
    return var_3a58aa96;
}

