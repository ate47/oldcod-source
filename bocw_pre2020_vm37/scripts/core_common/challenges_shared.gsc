#using scripts\abilities\ability_player;
#using scripts\abilities\ability_util;
#using scripts\core_common\activecamo_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\contracts_shared;
#using scripts\core_common\drown;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace challenges;

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x6
// Checksum 0x239e0096, Offset: 0x428
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"challenges_shared", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x5 linked
// Checksum 0x912fa557, Offset: 0x470
// Size: 0x1c
function private function_70a657d8() {
    level thread function_57d8515c();
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x498
// Size: 0x4
function init_shared() {
    
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0xcc20a9b1, Offset: 0x4a8
// Size: 0x10
function pickedupballisticknife() {
    self.retreivedblades++;
}

// Namespace challenges/challenges_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x319ce44c, Offset: 0x4c0
// Size: 0x94
function trackassists(attacker, *damage, isflare) {
    if (!isplayer(damage)) {
        return;
    }
    if (!isdefined(self.flareattackerdamage)) {
        self.flareattackerdamage = [];
    }
    if (isdefined(isflare) && isflare == 1) {
        self.flareattackerdamage[damage.clientid] = 1;
        return;
    }
    self.flareattackerdamage[damage.clientid] = 0;
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x38f6ad85, Offset: 0x560
// Size: 0x1bc
function destroyedequipment(weapon) {
    if (sessionmodeiszombiesgame()) {
        return;
    }
    if (isdefined(weapon) && weapon.isemp) {
        if (self util::is_item_purchased(#"emp_grenade")) {
            self stats::function_dad108fa(#"destroy_equipment_with_emp_grenade", 1);
        }
        self function_be7a08a8(weapon, 1);
        if (self util::has_hacker_perk_purchased_and_equipped()) {
            self stats::function_dad108fa(#"destroy_equipment_with_emp_engineer", 1);
            self stats::function_dad108fa(#"destroy_equipment_engineer", 1);
        }
    } else if (self util::has_hacker_perk_purchased_and_equipped()) {
        self stats::function_dad108fa(#"destroy_equipment_engineer", 1);
    }
    self stats::function_dad108fa(#"destroy_equipment", 1);
    if (sessionmodeiswarzonegame()) {
        callback::callback(#"hash_67dd51a5d529c64c");
    }
    self hackedordestroyedequipment();
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0xbca9152, Offset: 0x728
// Size: 0xb4
function destroyedtacticalinsert() {
    if (!isdefined(self.pers[#"tacticalinsertsdestroyed"])) {
        self.pers[#"tacticalinsertsdestroyed"] = 0;
    }
    self.pers[#"tacticalinsertsdestroyed"]++;
    if (self.pers[#"tacticalinsertsdestroyed"] >= 5) {
        self.pers[#"tacticalinsertsdestroyed"] = 0;
        self stats::function_dad108fa(#"destroy_5_tactical_inserts", 1);
    }
}

// Namespace challenges/challenges_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xad214110, Offset: 0x7e8
// Size: 0x1d8
function addflyswatterstat(weapon, aircraft) {
    if (!isdefined(self.pers[#"flyswattercount"])) {
        self.pers[#"flyswattercount"] = 0;
    }
    self stats::function_e24eec31(weapon, #"destroyed_aircraft", 1);
    self.pers[#"flyswattercount"]++;
    if (self.pers[#"flyswattercount"] == 5) {
        self stats::function_e24eec31(weapon, #"destroyed_5_aircraft", 1);
    }
    if (isdefined(aircraft) && isdefined(aircraft.birthtime)) {
        if (gettime() - aircraft.birthtime < 20000) {
            self stats::function_e24eec31(weapon, #"destroyed_aircraft_under20s", 1);
        }
    }
    if (!isdefined(self.destroyedaircrafttime)) {
        self.destroyedaircrafttime = [];
    }
    if (isdefined(self.destroyedaircrafttime[weapon]) && gettime() - self.destroyedaircrafttime[weapon] < 10000) {
        self stats::function_e24eec31(weapon, #"destroyed_2aircraft_quickly", 1);
        self.destroyedaircrafttime[weapon] = undefined;
        return;
    }
    self.destroyedaircrafttime[weapon] = gettime();
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0xf98c5c11, Offset: 0x9c8
// Size: 0x98
function canprocesschallenges() {
    /#
        if (getdvarint(#"scr_debug_challenges", 0)) {
            return true;
        }
    #/
    if (getdvarint(#"hash_4a5c76bca8b0e3d8", 0) > 0) {
        return false;
    }
    if (level.rankedmatch || level.arenamatch || sessionmodeiscampaigngame()) {
        return true;
    }
    return false;
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0x78fd59bd, Offset: 0xa68
// Size: 0xd2
function initteamchallenges(team) {
    if (!isdefined(game.challenge)) {
        game.challenge = [];
    }
    if (!isdefined(game.challenge[team])) {
        game.challenge[team] = [];
        game.challenge[team][#"plantedbomb"] = 0;
        game.challenge[team][#"destroyedbombsite"] = 0;
        game.challenge[team][#"capturedflag"] = 0;
    }
    game.challenge[team][#"allalive"] = 1;
}

// Namespace challenges/challenges_shared
// Params 2, eflags: 0x0
// Checksum 0x672afead, Offset: 0xb48
// Size: 0x7a
function registerchallengescallback(callback, func) {
    if (!isdefined(level.challengescallbacks)) {
        level.challengescallbacks = [];
    }
    if (!isdefined(level.challengescallbacks[callback])) {
        level.challengescallbacks[callback] = [];
    }
    level.challengescallbacks[callback][level.challengescallbacks[callback].size] = func;
}

// Namespace challenges/challenges_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xb9eb50a5, Offset: 0xbd0
// Size: 0xc8
function dochallengecallback(callback, data) {
    if (!isdefined(level.challengescallbacks)) {
        return;
    }
    if (!isdefined(level.challengescallbacks[callback])) {
        return;
    }
    if (isdefined(data)) {
        for (i = 0; i < level.challengescallbacks[callback].size; i++) {
            thread [[ level.challengescallbacks[callback][i] ]](data);
        }
        return;
    }
    for (i = 0; i < level.challengescallbacks[callback].size; i++) {
        thread [[ level.challengescallbacks[callback][i] ]]();
    }
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x4625675d, Offset: 0xca0
// Size: 0x34
function on_player_connect() {
    self thread initchallengedata();
    self thread spawnwatcher();
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x203d01fe, Offset: 0xce0
// Size: 0x3e
function initchallengedata() {
    self.pers[#"stickexplosivekill"] = 0;
    self.pers[#"carepackagescalled"] = 0;
    self.explosiveinfo = [];
}

// Namespace challenges/challenges_shared
// Params 3, eflags: 0x0
// Checksum 0x9b98768d, Offset: 0xd28
// Size: 0xd4
function isdamagefromplayercontrolledaitank(eattacker, einflictor, weapon) {
    if (weapon.name == #"ai_tank_drone_gun") {
        if (isdefined(eattacker) && isdefined(eattacker.remoteweapon) && isdefined(einflictor)) {
            if (is_true(einflictor.controlled)) {
                if (eattacker.remoteweapon == einflictor) {
                    return true;
                }
            }
        }
    } else if (weapon.name == #"ai_tank_drone_rocket") {
        if (isdefined(einflictor) && !isdefined(einflictor.from_ai)) {
            return true;
        }
    }
    return false;
}

// Namespace challenges/challenges_shared
// Params 3, eflags: 0x0
// Checksum 0xa2e677ba, Offset: 0xe08
// Size: 0x96
function isdamagefromplayercontrolledsentry(eattacker, einflictor, weapon) {
    if (weapon.name == #"auto_gun_turret") {
        if (isdefined(eattacker) && isdefined(eattacker.remoteweapon) && isdefined(einflictor)) {
            if (eattacker.remoteweapon == einflictor) {
                if (is_true(einflictor.controlled)) {
                    return true;
                }
            }
        }
    }
    return false;
}

// Namespace challenges/challenges_shared
// Params 3, eflags: 0x0
// Checksum 0x887dfc62, Offset: 0xea8
// Size: 0x6d4
function perkkills(victim, isstunned, time) {
    player = self;
    if (player hasperk(#"specialty_movefaster")) {
        player stats::function_dad108fa(#"perk_movefaster_kills", 1);
    }
    if (player hasperk(#"specialty_noname")) {
        player stats::function_dad108fa(#"perk_noname_kills", 1);
    }
    if (player hasperk(#"specialty_quieter")) {
        player stats::function_dad108fa(#"perk_quieter_kills", 1);
    }
    if (player hasperk(#"specialty_longersprint")) {
        if (isdefined(player.lastsprinttime) && gettime() - player.lastsprinttime < 2500) {
            player stats::function_dad108fa(#"perk_longersprint", 1);
        }
    }
    if (player hasperk(#"specialty_fastmantle")) {
        if (isdefined(player.lastsprinttime) && gettime() - player.lastsprinttime < 2500 && player playerads() >= 1) {
            player stats::function_dad108fa(#"perk_fastmantle_kills", 1);
        }
    }
    if (player hasperk(#"specialty_loudenemies")) {
        player stats::function_dad108fa(#"perk_loudenemies_kills", 1);
    }
    if (isstunned == 1 && player hasperk(#"specialty_stunprotection")) {
        player stats::function_dad108fa(#"perk_protection_stun_kills", 1);
    }
    activeenemyemp = 0;
    activecuav = 0;
    if (level.teambased) {
        foreach (team, _ in level.teams) {
            assert(isdefined(level.activecounteruavs[team]));
            assert(isdefined(level.emp_shared.activeemps[team]));
            if (team == player.team) {
                continue;
            }
            if (level.activecounteruavs[team] > 0) {
                activecuav = 1;
            }
            if (level.emp_shared.activeemps[team] > 0) {
                activeenemyemp = 1;
            }
        }
    } else {
        assert(isdefined(level.activecounteruavs[victim.entnum]));
        assert(isdefined(level.emp_shared.activeemps[victim.entnum]));
        players = level.players;
        for (i = 0; i < players.size; i++) {
            if (players[i] != player) {
                if (isdefined(level.activecounteruavs[players[i].entnum]) && level.activecounteruavs[players[i].entnum] > 0) {
                    activecuav = 1;
                }
                if (isdefined(level.emp_shared.activeemps[players[i].entnum]) && level.emp_shared.activeemps[players[i].entnum] > 0) {
                    activeenemyemp = 1;
                }
            }
        }
    }
    if (activecuav == 1 || activeenemyemp == 1) {
        if (player hasperk(#"specialty_immunecounteruav")) {
            player stats::function_dad108fa(#"perk_immune_cuav_kills", 1);
        }
    }
    activeuavvictim = 0;
    if (isdefined(level.activeuavs[victim.team]) && level.activeuavs[victim.team] > 0) {
        if (player hasperk(#"specialty_gpsjammer")) {
            player stats::function_dad108fa(#"perk_gpsjammer_immune_kills", 1);
        }
    }
    if (player.lastweaponchange + 5000 > time) {
        if (player hasperk(#"specialty_fastweaponswitch")) {
            player stats::function_dad108fa(#"perk_fastweaponswitch_kill_after_swap", 1);
        }
    }
    if (player.scavenged == 1) {
        if (player hasperk(#"specialty_scavenger")) {
            player stats::function_dad108fa(#"perk_scavenger_kills_after_resupply", 1);
        }
    }
}

// Namespace challenges/challenges_shared
// Params 2, eflags: 0x0
// Checksum 0xf430d4ea, Offset: 0x1588
// Size: 0x86
function flakjacketprotected(weapon, attacker) {
    if (weapon.name == #"claymore") {
        self.flakjacketclaymore[attacker.clientid] = 1;
    }
    self stats::function_dad108fa(#"survive_with_flak", 1);
    self.challenge_lastsurvivewithflakfrom = attacker;
    self.challenge_lastsurvivewithflaktime = gettime();
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x208953e1, Offset: 0x1618
// Size: 0x106
function earnedkillstreak() {
    gear = self function_b958b70d(self.class_num, "tacticalgear");
    if (gear === #"gear_scorestreakcharge") {
        self stats::function_dad108fa(#"hash_656a2ab7e777796b", 1);
        if (isdefined(self.var_ea1458aa)) {
            if (!isdefined(self.var_ea1458aa.var_829c3e81)) {
                self.var_ea1458aa.var_829c3e81 = 0;
            }
            self.var_ea1458aa.var_829c3e81++;
            if (self.var_ea1458aa.var_829c3e81 == 5) {
                self stats::function_dad108fa(#"hash_1dd0ef4785aa4084", 1);
                self.var_ea1458aa.var_829c3e81 = 0;
            }
        }
    }
}

// Namespace challenges/challenges_shared
// Params 3, eflags: 0x0
// Checksum 0xe9b7ef87, Offset: 0x1728
// Size: 0xb4
function genericbulletkill(data, *victim, *weapon) {
    player = self;
    time = weapon.time;
    if (weapon.victim.idflagstime == time) {
        if (weapon.victim.idflags & 8) {
            player stats::function_dad108fa(#"kill_enemy_through_objects", 1);
        }
    }
    player function_80327323(weapon);
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x822984e5, Offset: 0x17e8
// Size: 0xb4
function function_80327323(data) {
    player = self;
    attackerstance = data.attackerstance;
    if (isdefined(attackerstance)) {
        if (attackerstance == #"crouch") {
            player stats::function_dad108fa(#"kill_enemy_while_crouched", 1);
            return;
        }
        if (attackerstance == #"prone") {
            player stats::function_dad108fa(#"kill_enemy_while_prone", 1);
        }
    }
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0x45827fce, Offset: 0x18a8
// Size: 0x158
function ishighestscoringplayer(player) {
    if (!isdefined(player.score) || player.score < 1) {
        return false;
    }
    players = level.players;
    if (level.teambased) {
        team = player.pers[#"team"];
    } else {
        team = "all";
    }
    highscore = player.score;
    for (i = 0; i < players.size; i++) {
        if (!isdefined(players[i].score)) {
            continue;
        }
        if (players[i] == player) {
            continue;
        }
        if (players[i].score < 1) {
            continue;
        }
        if (team != "all" && players[i].pers[#"team"] != team) {
            continue;
        }
        if (players[i].score >= highscore) {
            return false;
        }
    }
    return true;
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x1 linked
// Checksum 0xc5264936, Offset: 0x1a08
// Size: 0x148
function spawnwatcher() {
    self endon(#"disconnect", #"killspawnmonitor");
    self.pers[#"stickexplosivekill"] = 0;
    self.pers[#"pistolheadshot"] = 0;
    self.pers[#"assaultrifleheadshot"] = 0;
    self.pers[#"killnemesis"] = 0;
    while (true) {
        self waittill(#"spawned_player");
        self.pers[#"longshotsperlife"] = 0;
        self.weaponkills = [];
        self.attachmentkills = [];
        self.retreivedblades = 0;
        self.lastreloadtime = 0;
        self.crossbowclipkillcount = 0;
        self thread watchfordtp();
        self thread watchformantle();
        self thread monitor_player_sprint();
    }
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x7655c8c4, Offset: 0x1b58
// Size: 0x76
function watchfordtp() {
    self endon(#"disconnect", #"death", #"killdtpmonitor");
    self.dtptime = 0;
    while (true) {
        self waittill(#"dtp_end");
        self.dtptime = gettime() + 4000;
    }
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x1 linked
// Checksum 0xacae9c8b, Offset: 0x1bd8
// Size: 0x82
function watchformantle() {
    self endon(#"disconnect", #"death", #"killmantlemonitor");
    self.mantletime = 0;
    while (true) {
        waitresult = self waittill(#"mantle_start");
        self.mantletime = waitresult.end_time;
    }
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x18965bc9, Offset: 0x1c68
// Size: 0x2c
function disarmedhackedcarepackage() {
    self stats::function_dad108fa(#"disarm_hacked_carepackage", 1);
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x237b77a5, Offset: 0x1ca0
// Size: 0x54
function destroyed_car() {
    if (!isdefined(self) || !isplayer(self)) {
        return;
    }
    self stats::function_dad108fa(#"destroy_car", 1);
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x3f19b352, Offset: 0x1d00
// Size: 0xb4
function killednemesis() {
    if (!isdefined(self.pers[#"killnemesis"])) {
        self.pers[#"killnemesis"] = 0;
    }
    self.pers[#"killnemesis"]++;
    if (self.pers[#"killnemesis"] >= 5) {
        self.pers[#"killnemesis"] = 0;
        self stats::function_dad108fa(#"kill_nemesis", 1);
    }
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0xb54003ae, Offset: 0x1dc0
// Size: 0x2c
function killwhiledamagingwithhpm() {
    self stats::function_dad108fa(#"kill_while_damaging_with_microwave_turret", 1);
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0xdcce241a, Offset: 0x1df8
// Size: 0x2c
function longdistancehatchetkill() {
    self stats::function_dad108fa(#"long_distance_hatchet_kill", 1);
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x1b052647, Offset: 0x1e30
// Size: 0x2c
function blockedsatellite() {
    self stats::function_dad108fa(#"activate_cuav_while_enemy_satelite_active", 1);
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x85e44278, Offset: 0x1e68
// Size: 0x7c
function longdistancekill() {
    self.pers[#"longshotsperlife"]++;
    if (self.pers[#"longshotsperlife"] >= 3) {
        self.pers[#"longshotsperlife"] = 0;
        self stats::function_dad108fa(#"longshot_3_onelife", 1);
    }
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0xda30079, Offset: 0x1ef0
// Size: 0x182
function challengeroundend(data) {
    player = data.player;
    winner = data.winner;
    if (endedearly(winner, winner == "tie")) {
        return;
    }
    if (level.teambased) {
        winnerscore = game.stat[#"teamscores"][winner];
        loserscore = getlosersteamscores(winner);
    }
    switch (level.gametype) {
    case #"sd":
        if (player.team == winner) {
            if (game.challenge[winner][#"allalive"]) {
                player stats::function_d40764f3(#"round_win_no_deaths", 1);
            }
            if (isdefined(player.lastmansddefeat3enemies)) {
                player stats::function_d40764f3(#"last_man_defeat_3_enemies", 1);
            }
        }
        break;
    default:
        break;
    }
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0x47a43c8f, Offset: 0x2080
// Size: 0x84
function last_man_defeat_3_enemies(team) {
    if (function_a1ef346b(team).size == 1) {
        player = function_a1ef346b(team)[0];
        if (isdefined(player.var_66cfa07f)) {
            player stats::function_bb7eedf0(#"last_man_defeat_3_enemies", 1);
        }
    }
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x3dc5150b, Offset: 0x2110
// Size: 0x11c
function roundend(winner) {
    waitframe(1);
    data = spawnstruct();
    data.time = gettime();
    if (level.teambased) {
        if (isdefined(winner) && isdefined(level.teams[winner])) {
            data.winner = winner;
        }
    } else if (isdefined(winner)) {
        data.winner = winner;
    }
    for (index = 0; index < level.placement[#"all"].size; index++) {
        data.player = level.placement[#"all"][index];
        if (isdefined(data.player)) {
            data.place = index;
            dochallengecallback("roundEnd", data);
        }
    }
}

// Namespace challenges/challenges_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x7d12a14d, Offset: 0x2238
// Size: 0xcc4
function function_90185171(totaltimeplayed, credits, casexp) {
    if (!sessionmodeisonlinegame() || !is_true(level.rankedmatch)) {
        return;
    }
    player = self;
    if (!isdefined(player) || !isplayer(player) || isbot(player)) {
        return;
    }
    var_dbb56f7e = getdvarint(#"hash_4574f0b1608d9ea8", 0);
    if (var_dbb56f7e && player function_875e4dbc() && totaltimeplayed > 0) {
        timeoffset = getdvarint(#"live_timewarp", 0) * 60 * 60 * 24;
        timemultiplier = getdvarfloat(#"hash_2956967233bebd4f", 1);
        var_bf107145 = totaltimeplayed;
        if (timemultiplier > 1) {
            var_bf107145 = int(timemultiplier * totaltimeplayed);
        }
    }
    println("<dev string:x38>" + player.name);
    println("<dev string:x51>" + (isdefined(credits) ? credits : "<dev string:x67>"));
    println("<dev string:x6c>" + (isdefined(casexp) ? casexp : "<dev string:x67>"));
    println("<dev string:x82>" + (isdefined(totaltimeplayed) ? totaltimeplayed : "<dev string:x67>"));
    println("<dev string:xa0>" + (isdefined(player.pers[#"participation"]) ? player.pers[#"participation"] : "<dev string:x67>"));
    if (credits <= 0 && casexp <= 0) {
        return;
    }
    if (credits > 0 || casexp > 0) {
        if (!isdefined(totaltimeplayed) || totaltimeplayed <= 0) {
            return;
        }
        /#
            var_dfa63097 = getdvarint(#"hash_6f93a5b2133445ec", 0);
            if (var_dfa63097 > 0) {
                credits = var_dfa63097;
                player.timeplayed[#"total"]++;
                player.pers[#"participation"]++;
            }
            var_159015d5 = getdvarint(#"hash_69a151539f8595de", 0);
            if (var_159015d5 > 0) {
                casexp = var_159015d5;
                player.timeplayed[#"total"]++;
                player.pers[#"participation"]++;
            }
        #/
        if (!isdefined(player.pers[#"participation"]) || player.pers[#"participation"] < 1) {
            if (!sessionmodeiswarzonegame()) {
                println(player.name + "<dev string:xb8>");
                return;
            }
        }
        if (!sessionmodeiswarzonegame() && isdefined(player.pers[#"controllerparticipation"])) {
            if (is_true(player.pers[#"controllerparticipationchecks"])) {
                if (player.pers[#"controllerparticipationchecks"] >= level.var_42dca1dd) {
                    var_7be1e671 = player.pers[#"controllerparticipation"] / player.pers[#"controllerparticipationchecks"];
                    if (var_7be1e671 < level.var_8e1c2aa1) {
                        self.pers[#"controllerparticipationendgameresult"] = 0;
                        println(player.name + "<dev string:xe6>" + var_7be1e671 + "<dev string:x122>" + level.var_8e1c2aa1 + "<dev string:x12a>");
                        return;
                    } else {
                        self.pers[#"controllerparticipationendgameresult"] = 1;
                    }
                }
            }
        }
        if (getdvarint(#"loot_enableblackmarket", 1)) {
            credit_multiplier = max(player function_c52bcf79(), getdvarfloat(#"scr_credit_scale", 1));
            credits *= credit_multiplier;
            tier_boost = player stats::function_ff8f4f17(#"tier_boost");
            if (isdefined(tier_boost) && tier_boost > 0) {
                tier_boost = min(tier_boost, getdvarint(#"hash_20997c814ed4b7ed", 25));
                credits += credits * tier_boost / 100;
                println("<dev string:x12f>" + player.name + "<dev string:x147>" + tier_boost);
            }
            bo_pass_tier_boost = player stats::function_ff8f4f17(#"bo_pass_tier_boost");
            if (isdefined(bo_pass_tier_boost) && bo_pass_tier_boost > 0) {
                credits += credits * bo_pass_tier_boost / 100;
                println("<dev string:x14e>" + player.name + "<dev string:x147>" + bo_pass_tier_boost);
            }
            bo_pass_party_tier_boost = player stats::function_ff8f4f17(#"bo_pass_party_tier_boost");
            if (isdefined(bo_pass_party_tier_boost) && bo_pass_party_tier_boost > 0) {
                credits += credits * bo_pass_party_tier_boost / 100;
                println("<dev string:x16e>" + player.name + "<dev string:x147>" + bo_pass_party_tier_boost);
            }
            println("<dev string:x194>" + player.name + "<dev string:x1a1>" + totaltimeplayed + "<dev string:x1ae>" + credits + "<dev string:x1bd>" + casexp);
            if (player function_875e4dbc()) {
                var_91503b6f = getdvarfloat(#"hash_4da039b4bc312fc1", 1.1);
                credits *= var_91503b6f;
            }
            var_1ed920ee = 0;
            var_5f508856 = 0;
            if (sessionmodeismultiplayergame()) {
                var_1ed920ee = getdvarint(#"hash_3bccd5b062faadee", 1000);
                var_5f508856 = getdvarint(#"hash_3ded794ceefdb21d", 1000);
            } else if (sessionmodeiswarzonegame()) {
                var_1ed920ee = getdvarint(#"hash_3be0d3b0630b5392", 1000);
                var_5f508856 = getdvarint(#"hash_3e456f4cef4816f5", 1000);
            }
            credits = min(credits, var_1ed920ee);
            casexp = min(casexp, var_5f508856);
            modeindex = 1;
            if (sessionmodeiswarzonegame()) {
                modeindex = 2;
            }
            if (credits > 0) {
                if (getdvarint(#"loot_tier_skips_enabled", 0) == 1 && getdvarint(#"lootcontracts_daily_tier_skip", 0) != 1) {
                    if (!isdefined(player.pers[#"hash_6344af0b142ed0b6"])) {
                        player.pers[#"hash_6344af0b142ed0b6"] = 0;
                    }
                }
                if (sessionmodeismultiplayergame() && getdvarint(#"hash_ed47eb88ebf25b2", 1) || sessionmodeiswarzonegame() && getdvarint(#"hash_eb27cb88ea23be6", 1)) {
                    println("<dev string:x1cb>" + credits);
                }
            }
            if (casexp > 0) {
                if (sessionmodeismultiplayergame() && getdvarint(#"hash_107f9b52b0455b54", 1) || sessionmodeiswarzonegame() && getdvarint(#"hash_10d78d52b08fb960", 1)) {
                    var_ae857992 = getdvarint(#"hash_60d812bef0f782fb", 1);
                    println("<dev string:x1e1>" + casexp);
                    player function_cce105c8(#"hash_61aa204cb44750f7", 1, int(var_ae857992), 2, int(casexp));
                }
            }
        }
    }
}

// Namespace challenges/challenges_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x447fa3e5, Offset: 0x2f08
// Size: 0xc4
function function_659f7dc(var_1ef5a3ba, var_3e853b2e, var_25ad32e1) {
    self util::function_22bf0a4a();
    if (isdefined(var_1ef5a3ba) && var_1ef5a3ba > 0) {
        var_5024088b = float(var_1ef5a3ba) / 1000;
        credits = var_5024088b * var_3e853b2e;
        casexp = var_5024088b * var_25ad32e1;
        if (credits > 0) {
            self function_90185171(var_5024088b, credits, casexp);
        }
    }
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x5 linked
// Checksum 0xcd7a72f1, Offset: 0x2fd8
// Size: 0x164
function private function_d6f929d6() {
    wait 2;
    level.var_4f654f3a = 1;
    var_b50d0caa = getdvarfloat(#"hash_13a346481f092189", 0);
    var_7f6396f0 = getdvarfloat(#"hash_5b9ffb659d9e0093", 0);
    foreach (player in level.players) {
        if (isdefined(player.pers[#"hash_150795bee4d46ce4"])) {
            var_28ee869a = gettime() - player.pers[#"hash_150795bee4d46ce4"];
            player function_659f7dc(var_28ee869a, var_b50d0caa, var_7f6396f0);
        }
    }
    function_f4f6d8a1();
}

// Namespace challenges/challenges_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x25f67a9e, Offset: 0x3148
// Size: 0x1dc
function gameend(winner, *var_c1e98979) {
    waitframe(1);
    data = spawnstruct();
    data.time = gettime();
    if (level.teambased) {
        if (isdefined(var_c1e98979) && isdefined(level.teams[var_c1e98979])) {
            data.winner = var_c1e98979;
        }
    } else if (isdefined(var_c1e98979) && isplayer(var_c1e98979)) {
        data.winner = var_c1e98979;
    }
    for (index = 0; index < level.placement[#"all"].size; index++) {
        data.player = level.placement[#"all"][index];
        data.place = index;
        if (isdefined(data.player)) {
            dochallengecallback("gameEnd", data);
        }
    }
    if (sessionmodeismultiplayergame() && sessionmodeisonlinegame() && level.rankedmatch) {
        if (getdvarint(#"hash_7902ca2d14eb933b", 0) == 1) {
            level.var_4f654f3a = 1;
            function_f4f6d8a1();
            return;
        }
        thread function_d6f929d6();
    }
}

// Namespace challenges/challenges_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xbff3c66, Offset: 0x3330
// Size: 0xd4
function function_1e064861(type, var_a7674114) {
    if (type == self.pers[#"hash_4a01db5796cf12b1"]) {
        self.pers[#"hash_3b7fc8c62a7d4420"]++;
    } else {
        self.pers[#"hash_3b7fc8c62a7d4420"] = 1;
        self.pers[#"hash_4a01db5796cf12b1"] = type;
    }
    if (self.pers[#"hash_3b7fc8c62a7d4420"] > self.pers[var_a7674114]) {
        self.pers[var_a7674114] = self.pers[#"hash_3b7fc8c62a7d4420"];
    }
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x15ea6171, Offset: 0x3410
// Size: 0x320
function controllerparticipationcheck() {
    if (!isdefined(self)) {
        return false;
    }
    if (!isdefined(self.pers[#"controllerparticipationchecksskipped"])) {
        self.pers[#"controllerparticipationchecksskipped"] = 0;
    }
    if (isdedicated() && getdvarint(#"hash_2167ce61af5dc0b0", 1) == 0) {
        return false;
    }
    if (self.sessionstate != "playing" || is_true(self.var_4c45f505)) {
        self.pers[#"controllerparticipationchecksskipped"]++;
        return false;
    }
    self.pers[#"controllerparticipationchecks"]++;
    var_51ba979b = #"failure";
    var_a7674114 = "controllerParticipationConsecutiveFailureMax";
    var_fb144707 = self function_1bc04df9();
    if (var_fb144707 >= level.var_5b7e9056) {
        self.pers[#"controllerparticipation"]++;
        var_51ba979b = #"success";
        var_a7674114 = "controllerParticipationConsecutiveSuccessMax";
        if (self.pers[#"controllerparticipationinactivitywarnings"]) {
            self.pers[#"controllerparticipationsuccessafterinactivitywarning"] = 1;
        }
    }
    self function_1e064861(var_51ba979b, var_a7674114);
    if (!self.pers[#"controllerparticipationsuccessafterinactivitywarning"]) {
        if (self.pers[#"controllerparticipationchecks"] >= level.var_5d96cc20) {
            var_b06a954d = self.pers[#"controllerparticipation"] / self.pers[#"controllerparticipationchecks"];
            if (var_b06a954d < level.var_b6752258) {
                if (!self.pers[#"controllerparticipationinactivitywarnings"]) {
                    self.pers[#"controllerparticipationinactivitywarnings"]++;
                    self iprintlnbold(#"hash_59bd89e170a924ac");
                } else {
                    self.pers[#"controllerparticipationendgameresult"] = -2;
                    if (isdefined(level.gamehistoryplayerkicked)) {
                        self thread [[ level.gamehistoryplayerkicked ]]();
                    }
                    kick(self getentitynumber(), "GAME/DROPPEDFORINACTIVITY");
                }
            }
        }
    }
    return true;
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x7a02b0d0, Offset: 0x3738
// Size: 0x38e
function function_57d8515c() {
    if (!sessionmodeisonlinegame() || !is_true(level.rankedmatch)) {
        return;
    }
    var_37c0d246 = 25;
    level.var_5b7e9056 = isdefined(getgametypesetting(#"hash_410c5c7c1e60b534")) ? getgametypesetting(#"hash_410c5c7c1e60b534") : 0;
    level.var_df437ed2 = isdefined(getgametypesetting(#"hash_451245a24412d90f")) ? getgametypesetting(#"hash_451245a24412d90f") : 0;
    level.var_42dca1dd = isdefined(getgametypesetting(#"hash_6ae29c8144cb7659")) ? getgametypesetting(#"hash_6ae29c8144cb7659") : 0;
    level.var_8e1c2aa1 = isdefined(getgametypesetting(#"hash_35e9fc8eee6881e0")) ? getgametypesetting(#"hash_35e9fc8eee6881e0") : 0;
    level.var_5d96cc20 = isdefined(getgametypesetting(#"hash_7adb62a64c6d963")) ? getgametypesetting(#"hash_7adb62a64c6d963") : 0;
    level.var_b6752258 = isdefined(getgametypesetting(#"hash_1df445b9d1af641f")) ? getgametypesetting(#"hash_1df445b9d1af641f") : 0;
    level waittill(#"game_playing");
    for (;;) {
        wait level.var_df437ed2;
        var_a3b5975e = 0;
        players = getplayers();
        foreach (player in players) {
            if (!isdefined(player) || !isplayer(player) || isbot(player)) {
                continue;
            }
            if (player controllerparticipationcheck()) {
                var_a3b5975e++;
            }
            if (12 <= var_a3b5975e) {
                waitframe(1);
            }
        }
    }
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x8762d84b, Offset: 0x3ad0
// Size: 0x4c
function getfinalkill(player) {
    if (isplayer(player)) {
        player stats::function_dad108fa(#"get_final_kill", 1);
    }
}

// Namespace challenges/challenges_shared
// Params 3, eflags: 0x1 linked
// Checksum 0x1919972e, Offset: 0x3b28
// Size: 0xd4
function destroy_killstreak_vehicle(weapon, vehicle, hatchet_kill_stat) {
    if (!isplayer(self) || !isdefined(weapon)) {
        return;
    }
    controlled = isdefined(vehicle.controlled) ? vehicle.controlled : 1;
    self destroyscorestreak(weapon, controlled, 1);
    if (weapon.rootweapon.name == "hatchet" && isdefined(hatchet_kill_stat)) {
        self stats::function_dad108fa(hatchet_kill_stat, 1);
    }
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0x97485a79, Offset: 0x3c08
// Size: 0xf4
function capturedcrate(owner) {
    if (isdefined(self.lastrescuedby) && isdefined(self.lastrescuedtime)) {
        if (self.lastrescuedtime + 5000 > gettime()) {
            self.lastrescuedby stats::function_dad108fa(#"defend_teammate_who_captured_package", 1);
        }
    }
    if (owner == self) {
        self stats::function_dad108fa(#"capture_own_carepackage", 1);
        return;
    }
    if (level.teambased && owner.team != self.team || !level.teambased) {
        self stats::function_dad108fa(#"capture_enemy_carepackage", 1);
    }
}

// Namespace challenges/challenges_shared
// Params 4, eflags: 0x1 linked
// Checksum 0x58a340e9, Offset: 0x3d08
// Size: 0x544
function destroyscorestreak(weapon, playercontrolled, groundbased, countaskillstreakvehicle = 1) {
    if (!isplayer(self) || !isdefined(weapon)) {
        return;
    }
    if (groundbased) {
        self stats::function_dad108fa(#"destroy_groundbased_scorestreak", 1);
    }
    if (isdefined(level.killstreakweapons[weapon])) {
        if (level.killstreakweapons[weapon] == "dart") {
            self stats::function_dad108fa(#"destroy_scorestreak_with_dart", 1);
        }
    } else if (weapon.issignatureweapon) {
        self stats::function_dad108fa(#"destroy_scorestreak_with_specialist", 1);
    } else {
        weaponclass = util::getweaponclass(weapon);
        if (isdefined(weaponclass) && weaponclass == #"weapon_launcher") {
            self stats::function_dad108fa(#"hash_be93d1227e6db1", 1);
        }
    }
    if (!isdefined(playercontrolled) || playercontrolled == 0) {
        if (self function_6c32d092(#"talent_coldblooded")) {
            self stats::function_dad108fa(#"destroy_ai_scorestreak_coldblooded", 1);
        }
        if (self util::has_cold_blooded_perk_purchased_and_equipped()) {
            if (self util::has_blind_eye_perk_purchased_and_equipped()) {
                if (groundbased) {
                    self.pers[#"challenge_destroyed_ground"]++;
                } else {
                    self.pers[#"challenge_destroyed_air"]++;
                }
                if (self.pers[#"challenge_destroyed_ground"] > 0 && self.pers[#"challenge_destroyed_air"] > 0) {
                    self stats::function_dad108fa(#"destroy_air_and_ground_blindeye_coldblooded", 1);
                    self.pers[#"challenge_destroyed_air"] = 0;
                    self.pers[#"challenge_destroyed_ground"] = 0;
                }
            }
        }
    }
    if (!isdefined(self.pers[#"challenge_destroyed_killstreak"])) {
        self.pers[#"challenge_destroyed_killstreak"] = 0;
    }
    self.pers[#"challenge_destroyed_killstreak"]++;
    if (self.pers[#"challenge_destroyed_killstreak"] >= 5) {
        self.pers[#"challenge_destroyed_killstreak"] = 0;
        self stats::function_e24eec31(weapon, #"destroy_5_killstreak", 1);
        self stats::function_e24eec31(weapon, #"destroy_5_killstreak_vehicle", 1);
    }
    self stats::function_e24eec31(weapon, #"destroy_killstreak", 1);
    if (self function_6c32d092(#"talent_engineer")) {
        self stats::function_dad108fa(#"destroy_scorestreaks_equipment_engineer", 1);
    }
    if (isdefined(weapon.attachments) && weapon.attachments.size > 0) {
        if (isdefined(weaponclass) && weaponclass == #"weapon_launcher") {
            if (self weaponhasattachmentandunlocked(weapon, "fastreload")) {
                self stats::function_dad108fa(#"hash_4b19afce40dfc918", 1);
            }
        }
    }
    if (isdefined(level.var_c8de519d) && isdefined(level.var_c8de519d.var_ec391d55)) {
        self [[ level.var_c8de519d.var_ec391d55 ]](weapon, playercontrolled, groundbased, countaskillstreakvehicle);
    }
    self thread watchforrapiddestroy(weapon);
}

// Namespace challenges/challenges_shared
// Params 2, eflags: 0x1 linked
// Checksum 0xd3608ae9, Offset: 0x4258
// Size: 0x294
function function_24db0c33(weapon, destroyedobject) {
    weaponclass = util::getweaponclass(weapon);
    weaponpickedup = 0;
    if (isdefined(self.pickedupweapons) && isdefined(self.pickedupweapons[weapon])) {
        weaponpickedup = 1;
    }
    self stats::function_eec52333(weapon, #"destroyed", 1, self.class_num, weaponpickedup);
    if (self function_6c32d092(#"talent_engineer")) {
        self stats::function_dad108fa(#"destroy_scorestreaks_equipment_engineer", 1);
    }
    if (isdefined(weaponclass) && weaponclass == #"weapon_launcher") {
        self stats::function_dad108fa(#"hash_be93d1227e6db1", 1);
        if (isdefined(weapon.attachments) && weapon.attachments.size > 0) {
            if (self weaponhasattachmentandunlocked(weapon, "fastreload")) {
                self stats::function_dad108fa(#"hash_4b19afce40dfc918", 1);
            }
        }
    }
    if (destroyedobject.var_76ce72e8 === 1) {
        if (isdefined(weapon) && weapon.isbulletweapon && (sessionmodeismultiplayergame() || sessionmodeiswarzonegame())) {
            self stats::function_dad108fa(#"destroy_equipment_with_bullet", 1);
        }
    }
    if (sessionmodeiswarzonegame() && !(destroyedobject.name === #"eq_sensor")) {
        self stats::function_dad108fa(#"destroy_equipment", 1);
        callback::callback(#"hash_67dd51a5d529c64c");
    }
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x5dbfc761, Offset: 0x44f8
// Size: 0xbc
function watchforrapiddestroy(weapon) {
    self endon(#"disconnect");
    if (!isdefined(self.challenge_previousdestroyweapon) || self.challenge_previousdestroyweapon != weapon) {
        self.challenge_previousdestroyweapon = weapon;
        self.challenge_previousdestroycount = 0;
    } else {
        self.challenge_previousdestroycount++;
    }
    self waittilltimeoutordeath(4);
    if (self.challenge_previousdestroycount > 1) {
        self stats::function_e24eec31(weapon, #"destroy_2_killstreaks_rapidly", 1);
    }
}

// Namespace challenges/challenges_shared
// Params 2, eflags: 0x0
// Checksum 0xe025533e, Offset: 0x45c0
// Size: 0x2de
function capturedobjective(capturetime, objective) {
    if (isdefined(self.smokegrenadetime) && isdefined(self.smokegrenadeposition)) {
        if (self.smokegrenadetime + 14000 > capturetime) {
            distsq = distancesquared(self.smokegrenadeposition, self.origin);
            if (distsq < 57600) {
                if (self util::is_item_purchased(#"willy_pete")) {
                    self stats::function_dad108fa(#"capture_objective_in_smoke", 1);
                    scoreevents::processscoreevent(#"hash_1782d884df525a0e", self);
                }
                self stats::function_e24eec31(getweapon(#"willy_pete"), #"combatrecordstat", 1);
                return;
            }
        }
    }
    heroabilitywasactiverecently = isdefined(self.heroabilityactive) || isdefined(self.heroabilitydectivatetime) && self.heroabilitydectivatetime > gettime() - 3000;
    if (heroabilitywasactiverecently && isdefined(self.heroability) && self.heroability.name == "gadget_camo") {
        scoreevents::processscoreevent(#"optic_camo_capture_objective", self);
    }
    if (isdefined(objective)) {
        if (isdefined(level.capturedobjectivefunction) && isdefined(capturetime)) {
            self [[ level.capturedobjectivefunction ]](objective, capturetime);
        }
        if (self.challenge_objectivedefensive === objective) {
            if ((isdefined(self.challenge_objectivedefensivekillcount) ? self.challenge_objectivedefensivekillcount : 0) > 0 && ((isdefined(self.recentkillcount) ? self.recentkillcount : 0) > 2 || self.challenge_objectivedefensivetriplekillmedalorbetterearned === 1)) {
                self stats::function_dad108fa(#"triple_kill_defenders_and_capture", 1);
            }
            self.challenge_objectivedefensivekillcount = 0;
            self.challenge_objectivedefensive = undefined;
            self.challenge_objectivedefensivetriplekillmedalorbetterearned = undefined;
        }
    }
    self notify(#"capturedobjective", {#capturetime:capturetime, #var_eced93f5:objective});
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x1 linked
// Checksum 0xfead26d4, Offset: 0x48a8
// Size: 0x44
function hackedordestroyedequipment() {
    if (self util::has_hacker_perk_purchased_and_equipped()) {
        self stats::function_dad108fa(#"perk_hacker_destroy", 1);
    }
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x5e5a4c54, Offset: 0x48f8
// Size: 0xb4
function bladekill() {
    if (!isdefined(self.pers[#"bladekills"])) {
        self.pers[#"bladekills"] = 0;
    }
    self.pers[#"bladekills"]++;
    if (self.pers[#"bladekills"] >= 15) {
        self.pers[#"bladekills"] = 0;
        self stats::function_dad108fa(#"kill_15_with_blade", 1);
    }
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x9bd2d15f, Offset: 0x49b8
// Size: 0x4c
function destroyedexplosive(weapon) {
    self destroyedequipment(weapon);
    self stats::function_dad108fa(#"destroy_explosive", 1);
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x56bfcd27, Offset: 0x4a10
// Size: 0x2c
function assisted() {
    self stats::function_dad108fa(#"assist", 1);
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0xccc7abbb, Offset: 0x4a48
// Size: 0xf4
function earnedmicrowaveassistscore(score) {
    self stats::function_dad108fa(#"assist_score_microwave_turret", score);
    self stats::function_dad108fa(#"assist_score_killstreak", score);
    self stats::function_e24eec31(getweapon(#"microwave_turret_deploy"), #"assists", 1);
    self stats::function_e24eec31(getweapon(#"microwave_turret_deploy"), #"assist_score", score);
    self contracts::increment_contract(#"hash_4840654e4b2597a5", score);
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0x1def24d6, Offset: 0x4b48
// Size: 0xf4
function earnedcuavassistscore(score) {
    self stats::function_dad108fa(#"assist_score_cuav", score);
    self stats::function_dad108fa(#"assist_score_killstreak", score);
    self stats::function_e24eec31(getweapon(#"counteruav"), #"assists", 1);
    self stats::function_e24eec31(getweapon(#"counteruav"), #"assist_score", score);
    self contracts::increment_contract(#"hash_4840654e4b2597a5", score);
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0xf1d004f6, Offset: 0x4c48
// Size: 0xf4
function earneduavassistscore(score) {
    self stats::function_dad108fa(#"assist_score_uav", score);
    self stats::function_dad108fa(#"assist_score_killstreak", score);
    self stats::function_e24eec31(getweapon(#"uav"), #"assists", 1);
    self stats::function_e24eec31(getweapon(#"uav"), #"assist_score", score);
    self contracts::increment_contract(#"hash_4840654e4b2597a5", score);
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0xe2a05c11, Offset: 0x4d48
// Size: 0xf4
function earnedsatelliteassistscore(score) {
    self stats::function_dad108fa(#"assist_score_satellite", score);
    self stats::function_dad108fa(#"assist_score_killstreak", score);
    self stats::function_e24eec31(getweapon(#"satellite"), #"assists", 1);
    self stats::function_e24eec31(getweapon(#"satellite"), #"assist_score", score);
    self contracts::increment_contract(#"hash_4840654e4b2597a5", score);
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0x34172864, Offset: 0x4e48
// Size: 0xf4
function earnedempassistscore(score) {
    self stats::function_dad108fa(#"assist_score_emp", score);
    self stats::function_dad108fa(#"assist_score_killstreak", score);
    self stats::function_e24eec31(getweapon(#"emp_turret"), #"assists", 1);
    self stats::function_e24eec31(getweapon(#"emp_turret"), #"assist_score", score);
    self contracts::increment_contract(#"hash_4840654e4b2597a5", score);
}

// Namespace challenges/challenges_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x4da3d503, Offset: 0x4f48
// Size: 0x9c
function teamcompletedchallenge(team, challenge) {
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (isdefined(players[i].team) && players[i].team == team) {
            players[i] stats::function_d40764f3(challenge, 1);
        }
    }
}

// Namespace challenges/challenges_shared
// Params 2, eflags: 0x1 linked
// Checksum 0x810902b5, Offset: 0x4ff0
// Size: 0x52
function endedearly(winner, tie) {
    if (level.hostforcedend) {
        return true;
    }
    if (!isdefined(winner)) {
        return true;
    }
    if (level.teambased) {
        if (tie) {
            return true;
        }
    }
    return false;
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xbe647c0c, Offset: 0x5050
// Size: 0xbc
function getlosersteamscores(winner) {
    teamscores = 0;
    foreach (team, _ in level.teams) {
        if (team == winner) {
            continue;
        }
        teamscores += game.stat[#"teamscores"][team];
    }
    return teamscores;
}

// Namespace challenges/challenges_shared
// Params 2, eflags: 0x0
// Checksum 0x55af8235, Offset: 0x5118
// Size: 0xb2
function didloserfailchallenge(winner, challenge) {
    foreach (team, _ in level.teams) {
        if (team == winner) {
            continue;
        }
        if (game.challenge[team][challenge]) {
            return false;
        }
    }
    return true;
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0x6294510c, Offset: 0x51d8
// Size: 0xb6
function challengegameend(data) {
    player = data.player;
    winner = data.winner;
    if (endedearly(winner, winner == "tie")) {
        return;
    }
    if (level.teambased) {
        winnerscore = game.stat[#"teamscores"][winner];
        loserscore = getlosersteamscores(winner);
    }
}

// Namespace challenges/challenges_shared
// Params 2, eflags: 0x0
// Checksum 0x12638146, Offset: 0x5298
// Size: 0x240
function multikill(killcount, weapon) {
    if (!sessionmodeismultiplayergame() && !sessionmodeiswarzonegame()) {
        return;
    }
    doublekill = int(killcount / 2);
    if (doublekill > 0) {
        self stats::function_e24eec31(weapon, #"doublekill", doublekill);
        if (weapon.isheavyweapon) {
            self stats::function_dad108fa(#"multikill_2_with_heroweapon", doublekill);
        }
    }
    triplekill = int(killcount / 3);
    if (triplekill > 0) {
        if (isdefined(self.lastkillwheninjured)) {
            if (self.lastkillwheninjured + 5000 > gettime()) {
                self stats::function_dad108fa(#"multikill_3_near_death", 1);
            }
        }
        self stats::function_e24eec31(weapon, #"triplekill", triplekill);
        if (weapon.isheavyweapon) {
            self stats::function_dad108fa(#"multikill_3_with_heroweapon", triplekill);
        }
    }
    if (isdefined(self.var_ea1458aa)) {
        if (!isdefined(self.var_ea1458aa.var_e0bfa611)) {
            self.var_ea1458aa.var_e0bfa611 = 0;
        }
        self.var_ea1458aa.var_e0bfa611++;
        self function_a4db0a4c();
    }
    if (isdefined(level.var_c8de519d.multikill)) {
        self [[ level.var_c8de519d.multikill ]](killcount, weapon, globallogic_score::function_3cbc4c6c(weapon.var_2e4a8800));
    }
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x1 linked
// Checksum 0xcef0f650, Offset: 0x54e0
// Size: 0xaa
function function_a4db0a4c() {
    if (!isdefined(self.var_ea1458aa.var_e0bfa611)) {
        return;
    }
    if (!isdefined(self.var_ea1458aa.var_2bad4cbb)) {
        return;
    }
    if (self.var_ea1458aa.var_e0bfa611 > 0 && self.var_ea1458aa.var_2bad4cbb > 0) {
        self stats::function_dad108fa(#"hash_5803a1b332accd42", 1);
        self.var_ea1458aa.var_e0bfa611 = undefined;
        self.var_ea1458aa.var_2bad4cbb = undefined;
    }
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0x9cb6b121, Offset: 0x5598
// Size: 0x34
function domattackermultikill(*killcount) {
    self stats::function_d40764f3(#"kill_2_enemies_capturing_your_objective", 1);
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0xd17a5a0, Offset: 0x55d8
// Size: 0x2c
function totaldomination(team) {
    teamcompletedchallenge(team, "control_3_points_3_minutes");
}

// Namespace challenges/challenges_shared
// Params 2, eflags: 0x0
// Checksum 0x8d1cd53, Offset: 0x5610
// Size: 0xbc
function holdflagentirematch(team, label) {
    switch (label) {
    case #"_a":
        event = "hold_a_entire_match";
        break;
    case #"_b":
        event = "hold_b_entire_match";
        break;
    case #"_c":
        event = "hold_c_entire_match";
        break;
    default:
        return;
    }
    teamcompletedchallenge(team, event);
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0xb6064ec7, Offset: 0x56d8
// Size: 0x2c
function function_f96312cb() {
    self stats::function_d40764f3(#"capture_b_first_minute", 1);
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0xc2d0ce10, Offset: 0x5710
// Size: 0x2c
function controlzoneentirely(team) {
    teamcompletedchallenge(team, "control_zone_entirely");
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0xcc99e04b, Offset: 0x5748
// Size: 0x2c
function multi_lmg_smg_kill() {
    self stats::function_dad108fa(#"multikill_3_lmg_or_smg_hip_fire", 1);
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0xbd70fabc, Offset: 0x5780
// Size: 0x74
function killedzoneattacker(weapon) {
    if (weapon.statname == #"planemortar" || weapon.statname == "remote_missile_missile" || weapon.name == #"remote_missile_bomblet") {
        self thread updatezonemultikills();
    }
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x9c31def5, Offset: 0x5800
// Size: 0x11c
function killeddog() {
    origin = self.origin;
    if (level.teambased) {
        teammates = function_a1ef346b(self.team);
        foreach (player in teammates) {
            if (player == self) {
                continue;
            }
            distsq = distancesquared(origin, player.origin);
            if (distsq < 57600) {
                self stats::function_dad108fa(#"killed_dog_close_to_teammate", 1);
                break;
            }
        }
    }
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x2d48a68a, Offset: 0x5928
// Size: 0xb6
function updatezonemultikills() {
    self endon(#"disconnect");
    level endon(#"game_ended");
    self notify(#"updaterecentzonekills");
    self endon(#"updaterecentzonekills");
    if (!isdefined(self.recentzonekillcount)) {
        self.recentzonekillcount = 0;
    }
    self.recentzonekillcount++;
    wait 4;
    if (self.recentzonekillcount > 1) {
        self stats::function_dad108fa(#"multikill_2_zone_attackers", 1);
    }
    self.recentzonekillcount = 0;
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x3c745112, Offset: 0x59e8
// Size: 0x2c
function multi_rcbomb_kill() {
    self stats::function_dad108fa(#"multikill_2_with_rcbomb", 1);
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x3ac1898a, Offset: 0x5a20
// Size: 0x2c
function function_46754062() {
    self stats::function_dad108fa(#"hash_709699a31c8f89f7", 1);
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x91d833e3, Offset: 0x5a58
// Size: 0x2c
function multi_remotemissile_kill() {
    self stats::function_dad108fa(#"multikill_3_remote_missile", 1);
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x2da52124, Offset: 0x5a90
// Size: 0x2c
function multi_mgl_kill() {
    self stats::function_dad108fa(#"multikill_3_with_mgl", 1);
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x596d3b6b, Offset: 0x5ac8
// Size: 0x2c
function immediatecapture() {
    self stats::function_d40764f3(#"immediate_capture", 1);
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x83d25309, Offset: 0x5b00
// Size: 0x2c
function killedlastcontester() {
    self stats::function_d40764f3(#"contest_then_capture", 1);
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x8fee07f0, Offset: 0x5b38
// Size: 0x2c
function bothbombsdetonatewithintime() {
    self stats::function_d40764f3(#"both_bombs_detonate_10_seconds", 1);
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0xc82a7b74, Offset: 0x5b70
// Size: 0x7c
function calledincarepackage() {
    self.pers[#"carepackagescalled"]++;
    if (self.pers[#"carepackagescalled"] >= 3) {
        self stats::function_dad108fa(#"call_in_3_care_packages", 1);
        self.pers[#"carepackagescalled"] = 0;
    }
}

// Namespace challenges/challenges_shared
// Params 4, eflags: 0x0
// Checksum 0x65bd47d8, Offset: 0x5bf8
// Size: 0xb4
function destroyedhelicopter(attacker, weapon, damagetype, *playercontrolled) {
    if (!isplayer(weapon)) {
        return;
    }
    weapon destroyedaircraft(weapon, damagetype, 0, 1);
    if (isdefined(playercontrolled) && (playercontrolled == "MOD_RIFLE_BULLET" || playercontrolled == "MOD_PISTOL_BULLET")) {
        weapon stats::function_dad108fa(#"destroyed_helicopter_with_bullet", 1);
    }
}

// Namespace challenges/challenges_shared
// Params 2, eflags: 0x0
// Checksum 0x62016723, Offset: 0x5cb8
// Size: 0xbc
function destroyedqrdrone(damagetype, weapon) {
    self destroyscorestreak(weapon, 1, 0);
    self stats::function_dad108fa(#"destroy_qrdrone", 1);
    if (damagetype == "MOD_RIFLE_BULLET" || damagetype == "MOD_PISTOL_BULLET") {
        self stats::function_dad108fa(#"destroyed_qrdrone_with_bullet", 1);
    }
    self destroyedplayercontrolledaircraft();
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x4d3a4af0, Offset: 0x5d80
// Size: 0x4c
function destroyedplayercontrolledaircraft() {
    if (self hasperk(#"specialty_noname")) {
        self stats::function_dad108fa(#"destroy_helicopter", 1);
    }
}

// Namespace challenges/challenges_shared
// Params 4, eflags: 0x1 linked
// Checksum 0x26633f99, Offset: 0x5dd8
// Size: 0x29c
function destroyedaircraft(attacker, weapon, playercontrolled, lethal = 1) {
    if (!isplayer(attacker)) {
        return;
    }
    attacker destroyscorestreak(weapon, playercontrolled, 0);
    if (is_true(lethal)) {
        attacker stats::function_dad108fa(#"destroy_lethal_aircraft", 1);
    } else {
        attacker stats::function_dad108fa(#"destroy_nonlethal_aircraft", 1);
    }
    if (isdefined(weapon)) {
        if (weapon.name == #"emp" && attacker util::is_item_purchased(#"killstreak_emp")) {
            attacker stats::function_dad108fa(#"destroy_aircraft_with_emp", 1);
        } else if (weapon.name == #"missile_drone_projectile" || weapon.name == #"missile_drone") {
            attacker stats::function_dad108fa(#"destroy_aircraft_with_missile_drone", 1);
        } else if (weapon.isbulletweapon) {
            attacker stats::function_dad108fa(#"shoot_aircraft", 1);
        }
    }
    if (attacker util::has_blind_eye_perk_purchased_and_equipped()) {
        attacker stats::function_dad108fa(#"perk_nottargetedbyairsupport_destroy_aircraft", 1);
    }
    attacker stats::function_dad108fa(#"destroy_aircraft", 1);
    if (isdefined(playercontrolled) && playercontrolled == 0) {
        if (attacker util::has_blind_eye_perk_purchased_and_equipped()) {
            attacker stats::function_dad108fa(#"destroy_ai_aircraft_using_blindeye", 1);
        }
    }
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0xb340f24f, Offset: 0x6080
// Size: 0x1a4
function killstreakten() {
    if (!isdefined(self.class_num)) {
        return;
    }
    primary = self getloadoutitem(self.class_num, "primary");
    if (primary != 0) {
        return;
    }
    secondary = self getloadoutitem(self.class_num, "secondary");
    if (secondary != 0) {
        return;
    }
    primarygrenade = self getloadoutitem(self.class_num, "primarygrenade");
    if (primarygrenade != 0) {
        return;
    }
    specialgrenade = self getloadoutitem(self.class_num, "specialgrenade");
    if (specialgrenade != 0) {
        return;
    }
    for (numspecialties = 0; numspecialties < level.maxspecialties; numspecialties++) {
        perk = self getloadoutitem(self.class_num, "specialty" + numspecialties + 1);
        if (perk != 0) {
            return;
        }
    }
    self stats::function_dad108fa(#"killstreak_10_no_weapons_perks", 1);
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x1 linked
// Checksum 0x66f352d6, Offset: 0x6230
// Size: 0xc0
function scavengedgrenade(weapon) {
    self endon(#"disconnect", #"death");
    self notify("6bc09f0b97f5d1fc");
    self endon("6bc09f0b97f5d1fc");
    self callback::callback(#"scavenged_primary_grenade", {#weapon:weapon});
    for (;;) {
        self waittill(#"lethalgrenadekill");
        self stats::function_dad108fa(#"kill_with_resupplied_lethal_grenade", 1);
    }
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0xfc4603c9, Offset: 0x62f8
// Size: 0xc
function stunnedtankwithempgrenade(*attacker) {
    
}

// Namespace challenges/challenges_shared
// Params 8, eflags: 0x0
// Checksum 0x30ed4293, Offset: 0x6310
// Size: 0x1788
function playerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, shitloc, attackerstance, bledout) {
    pixbeginevent("PK challenges");
    self.anglesondeath = self getplayerangles();
    if (isdefined(attacker) && isplayer(attacker)) {
        attacker.anglesonkill = attacker getplayerangles();
    }
    if (!isdefined(weapon)) {
        weapon = level.weaponnone;
    }
    self endon(#"disconnect");
    data = spawnstruct();
    victim = self;
    data.victim = victim;
    data.victimorigin = self.origin;
    data.victimforward = anglestoforward(self getplayerangles());
    data.victimstance = self getstance();
    data.einflictor = einflictor;
    data.attacker = attacker;
    data.attackerstance = attackerstance;
    data.idamage = idamage;
    data.smeansofdeath = smeansofdeath;
    data.weapon = weapon;
    data.shitloc = shitloc;
    data.time = gettime();
    data.bledout = 0;
    if (isdefined(bledout)) {
        data.bledout = bledout;
    }
    waslockingon = 0;
    washacked = 0;
    if (isdefined(einflictor)) {
        if (isdefined(einflictor.lastweaponbeforetoss)) {
            data.lastweaponbeforetoss = einflictor.lastweaponbeforetoss;
        }
        if (isdefined(einflictor.ownerweaponatlaunch)) {
            data.ownerweaponatlaunch = einflictor.ownerweaponatlaunch;
        }
        if (isdefined(einflictor.locking_on)) {
            waslockingon |= einflictor.locking_on;
        }
        if (isdefined(einflictor.locked_on)) {
            waslockingon |= einflictor.locked_on;
        }
        washacked = einflictor util::ishacked();
        if (isdefined(einflictor.stucktoplayer) && isdefined(einflictor.originalowner) && einflictor.stucktoplayer == self && einflictor.originalowner == attacker) {
            data.var_c274d62f = 1;
        }
    }
    victimentnum = victim getentitynumber();
    waslockingon &= 1 << victimentnum;
    if (waslockingon != 0) {
        data.waslockingon = 1;
    } else {
        data.waslockingon = 0;
    }
    data.washacked = washacked;
    data.wasplanting = victim.isplanting;
    data.wasunderwater = victim isplayerunderwater();
    data.var_e828179e = victim depthinwater();
    if (!isdefined(data.wasplanting)) {
        data.wasplanting = 0;
    }
    data.wasdefusing = victim.isdefusing;
    if (!isdefined(data.wasdefusing)) {
        data.wasdefusing = 0;
    }
    data.var_f0b3c772 = victim playerads();
    data.var_bd10969 = [];
    if (isarray(self.var_121392a1)) {
        foreach (effect in self.var_121392a1) {
            struct = spawnstruct();
            if (isdefined(effect.var_4f6b79a4)) {
                struct.var_2e4a8800 = effect.var_4f6b79a4.var_2e4a8800;
            }
            struct.var_4b22e697 = effect.var_4b22e697;
            struct.var_3d1ed4bd = effect.var_3d1ed4bd;
            struct.name = effect.namehash;
            if (!isdefined(data.var_bd10969)) {
                data.var_bd10969 = [];
            } else if (!isarray(data.var_bd10969)) {
                data.var_bd10969 = array(data.var_bd10969);
            }
            data.var_bd10969[data.var_bd10969.size] = struct;
        }
    }
    if (isdefined(victim.var_ea1458aa)) {
        data.var_6799f1da = victim.var_ea1458aa.var_6799f1da;
    }
    if (isdefined(victim.var_9cd2c51d)) {
        data.var_70763083 = victim.var_9cd2c51d.var_c54af9a9;
    }
    data.victimweapon = victim.currentweapon;
    data.victimonground = victim isonground();
    data.victimlaststunnedby = victim.laststunnedby;
    data.var_642d3a64 = victim.lastfiretime;
    data.victimcombatefficiencylastontime = victim.combatefficiencylastontime;
    data.victimspeedburstlastontime = victim.speedburstlastontime;
    data.victimcombatefficieny = victim ability_util::gadget_is_active(12);
    data.victimheroabilityactive = ability_player::gadget_checkheroabilitykill(victim);
    data.victimelectrifiedby = victim.electrifiedby;
    data.victimheroability = victim.heroability;
    data.victimwasinslamstate = victim isslamming();
    data.victimwaslungingwitharmblades = victim isgadgetmeleecharging();
    data.var_9fb5719b = victim function_90fe764c();
    data.victimwasheatwavestunned = victim isheatwavestunned();
    data.victimpowerarmorlasttookdamagetime = victim.power_armor_last_took_damage_time;
    data.victimgadgetwasactivelastdamage = victim.gadget_was_active_last_damage;
    data.victimisthieforroulette = victim.isthief === 1 || victim.isroulette === 1;
    data.victimheroabilityname = victim.heroabilityname;
    data.var_989b2258 = victim.var_ec59e88c;
    data.var_893d5683 = victim.var_ae639436;
    data.var_59b78db0 = victim.var_700a5910;
    if (isdefined(data.victimweapon)) {
        slot = victim gadgetgetslot(data.victimweapon);
        if (slot != -1) {
            data.victimgadgetpower = victim gadgetpowerget(slot);
        }
    }
    if (isdefined(victim.in_enemy_mute_smoke) && victim.in_enemy_mute_smoke || isdefined(victim.var_2118ca55) && victim.var_2118ca55) {
        data.var_ab4f5741 = 1;
    }
    data.var_504c7a2f = victim.in_enemy_mute_smoke;
    data.var_7006e4f4 = victim.var_fd0be7bd;
    data.var_af1b39cb = victim.lastflashedby;
    data.var_e020b97e = victim isflashbanged();
    data.var_ac7c0ef7 = victim function_6c32d092(#"talent_resistance");
    data.var_a79760b1 = victim status_effect::function_4617032e(5);
    data.var_dd195b6b = victim.var_a7679005;
    data.var_31310133 = victim.var_7ef2427c;
    data.var_9084d6e = victim status_effect::function_4617032e(2);
    data.var_157f4d3b = victim.var_a010bd8f;
    data.var_f048a359 = victim.var_9060b065;
    if (!isdefined(data.victimcombatefficiencylastontime)) {
        data.victimcombatefficiencylastontime = 0;
    }
    if (!isdefined(data.victimspeedburstlastontime)) {
        data.victimspeedburstlastontime = 0;
    }
    data.victimvisionpulseactivatetime = victim.visionpulseactivatetime;
    if (!isdefined(data.victimvisionpulseactivatetime)) {
        data.victimvisionpulseactivatetime = 0;
    }
    data.victimvisionpulsearray = util::array_copy_if_array(victim.visionpulsearray);
    data.victimvisionpulseorigin = victim.visionpulseorigin;
    data.victimvisionpulseoriginarray = util::array_copy_if_array(victim.visionpulseoriginarray);
    data.victimattackersthisspawn = util::array_copy_if_array(victim.attackersthisspawn);
    data.victimlastvisionpulsedby = victim.lastvisionpulsedby;
    data.victimlastvisionpulsedtime = victim.lastvisionpulsedtime;
    if (!isdefined(data.victimlastvisionpulsedtime)) {
        data.victimlastvisionpulsedtime = 0;
    }
    data.var_31d0fbf5 = victim.var_4dcf932b;
    data.var_f91a4dd6 = victim.recentkillcountsameweapon;
    data.victim_jump_begin = victim.challenge_jump_begin;
    data.victim_jump_end = victim.challenge_jump_end;
    data.victim_swimming_begin = victim.challenge_swimming_begin;
    data.victim_swimming_end = victim.challenge_swimming_end;
    data.victim_slide_begin = victim.challenge_slide_begin;
    data.victim_slide_end = victim.challenge_slide_end;
    data.var_e05c79a4 = isplayer(victim) && victim isplayerswimming();
    if (isdefined(victim.activeproximitygrenades)) {
        data.victimactiveproximitygrenades = [];
        arrayremovevalue(victim.activeproximitygrenades, undefined);
        foreach (proximitygrenade in victim.activeproximitygrenades) {
            proximitygrenadeinfo = spawnstruct();
            proximitygrenadeinfo.origin = proximitygrenade.origin;
            data.victimactiveproximitygrenades[data.victimactiveproximitygrenades.size] = proximitygrenadeinfo;
        }
    }
    if (isdefined(victim.activebouncingbetties)) {
        data.victimactivebouncingbetties = [];
        arrayremovevalue(victim.activebouncingbetties, undefined);
        foreach (bouncingbetty in victim.activebouncingbetties) {
            bouncingbettyinfo = spawnstruct();
            bouncingbettyinfo.origin = bouncingbetty.origin;
            data.victimactivebouncingbetties[data.victimactivebouncingbetties.size] = bouncingbettyinfo;
        }
    }
    if (isplayer(attacker)) {
        data.attackerorigin = attacker.origin;
        data.attackerforward = anglestoforward(attacker.anglesonkill);
        data.attackeronground = attacker isonground();
        data.var_406186a6 = attacker function_8a220d80();
        data.attackertraversing = attacker istraversing();
        data.attackersliding = attacker issliding();
        data.attackerspeedburst = attacker ability_util::gadget_is_active(10);
        data.attackerheroabilityactive = ability_player::gadget_checkheroabilitykill(attacker);
        data.attackerheroability = attacker.heroability;
        data.attackervisionpulseactivatetime = attacker.visionpulseactivatetime;
        if (!isdefined(data.attackervisionpulseactivatetime)) {
            data.attackervisionpulseactivatetime = 0;
        }
        data.attackervisionpulsearray = util::array_copy_if_array(attacker.visionpulsearray);
        data.attackervisionpulseorigin = attacker.visionpulseorigin;
        if (!isdefined(data.attackerstance)) {
            data.attackerstance = attacker getstance();
        }
        data.attackervisionpulseoriginarray = util::array_copy_if_array(attacker.visionpulseoriginarray);
        data.var_1fa3e8cc = attacker function_104d7b4d();
        data.var_8556c722 = attacker isusingoffhand();
        data.attackerwasflashed = attacker isflashbanged();
        data.attackerlastflashedby = attacker.lastflashedby;
        data.attackerlaststunnedby = attacker.laststunnedby;
        data.attackerlaststunnedtime = attacker.laststunnedtime;
        data.attackerwasconcussed = isdefined(attacker.concussionendtime) && attacker.concussionendtime > gettime();
        data.attackerwasheatwavestunned = attacker isheatwavestunned();
        data.attackerwasunderwater = attacker isplayerunderwater();
        data.attackerlastfastreloadtime = attacker.lastfastreloadtime;
        data.attackerwassliding = attacker issliding();
        data.attackerwassprinting = attacker issprinting();
        data.attackerstance = attacker getstance();
        data.attackeristhief = attacker.isthief === 1;
        data.attackerisroulette = attacker.isroulette === 1;
        data.var_911b9b40 = attacker isremotecontrolling();
        data.var_be469b25 = attacker isgrappling() || isdefined(attacker.var_700a5910) && attacker.var_700a5910 + 2000 > gettime();
        data.var_5fa4aeed = isdefined(victim.lastattackedshieldtime) && victim.lastattackedshieldtime + 500 > gettime();
        data.attacker_jump_begin = attacker.challenge_jump_begin;
        data.attacker_jump_end = attacker.challenge_jump_end;
        data.attacker_swimming_begin = attacker.challenge_swimming_begin;
        data.attacker_swimming_end = attacker.challenge_swimming_end;
        data.attacker_slide_begin = attacker.challenge_slide_begin;
        data.attacker_slide_end = attacker.challenge_slide_end;
        data.attacker_sprint_begin = attacker.challenge_sprint_begin;
        data.attacker_sprint_end = attacker.challenge_sprint_end;
        data.var_26aed950 = attacker function_65776b07();
        if (isdefined(attacker.var_ea1458aa)) {
            if (isdefined(attacker.var_ea1458aa.var_8f7ff7ed)) {
                data.var_58b48038 = attacker.var_ea1458aa.var_8f7ff7ed[victimentnum];
            }
        }
        if (isdefined(attacker.var_9cd2c51d)) {
            data.var_e5241328 = attacker.var_9cd2c51d.var_c54af9a9;
            data.var_cc8f0762 = attacker.var_9cd2c51d.var_6e219f3c;
        }
        data.var_a99236f2 = victim.var_ead9cdbf;
        if (isdefined(attacker.sensor_darts)) {
            arrayremovevalue(attacker.sensor_darts, undefined);
        }
        if (isdefined(attacker.sensor_darts) && attacker.sensor_darts.size > 0) {
            data.var_cf13980c = [];
            foreach (sensor_dart in attacker.sensor_darts) {
                if (!isdefined(data.var_cf13980c)) {
                    data.var_cf13980c = [];
                } else if (!isarray(data.var_cf13980c)) {
                    data.var_cf13980c = array(data.var_cf13980c);
                }
                data.var_cf13980c[data.var_cf13980c.size] = sensor_dart;
            }
        } else if (isdefined(attacker.team)) {
            var_8ddd9a81 = getplayers(attacker.team);
            foreach (attacking_player in var_8ddd9a81) {
                if (!isplayer(attacking_player)) {
                    continue;
                }
                if (isdefined(attacking_player.sensor_darts)) {
                    arrayremovevalue(attacking_player.sensor_darts, undefined);
                    if (attacking_player.sensor_darts.size > 0) {
                        data.var_78056843 = attacking_player;
                        data.var_4f6eb670 = [];
                        foreach (sensor_dart in attacking_player.sensor_darts) {
                            if (!isdefined(data.var_4f6eb670)) {
                                data.var_4f6eb670 = [];
                            } else if (!isarray(data.var_4f6eb670)) {
                                data.var_4f6eb670 = array(data.var_4f6eb670);
                            }
                            data.var_4f6eb670[data.var_4f6eb670.size] = sensor_dart;
                        }
                        break;
                    }
                }
            }
        }
        if (isdefined(attacker.var_2ba4c892) && isdefined(attacker.var_2ba4c892[victim getentitynumber()])) {
            data.var_7117b104 = attacker.var_2ba4c892[victim getentitynumber()];
        }
        data.var_d6553aa9 = attacker function_ac8c1222(victim);
        if (isdefined(level.var_81286410)) {
            data.var_807875bc = attacker [[ level.var_81286410 ]]();
            data.var_a73da413 = victim.var_e5a19e3d;
            data.var_5f1818be = victim.var_50703880;
            data.var_c23ee432 = victim.var_3ab8ccc9;
            data.var_dbbf805a = victim.var_5550488a;
            data.var_9c16cd22 = victim.var_bb20a522;
            data.var_5d9be0a1 = victim.var_8c3b7f1a;
        }
    } else {
        data.attackeronground = 0;
        data.attackertraversing = 0;
        data.attackersliding = 0;
        data.attackerspeedburst = 0;
        data.attackervisionpulseactivatetime = 0;
        data.attackerwasflashed = 0;
        data.attackerwasconcussed = 0;
        data.attackerheroabilityactive = 0;
        data.attackerwasheatwavestunned = 0;
        data.attackerstance = "stand";
        data.attackerwasunderwater = 0;
        data.attackerwassprinting = 0;
        data.attackeristhief = 0;
        data.attackerisroulette = 0;
    }
    if (isdefined(einflictor)) {
        if (isdefined(einflictor.iscooked)) {
            data.inflictoriscooked = einflictor.iscooked;
        } else {
            data.inflictoriscooked = 0;
        }
        if (isdefined(einflictor.challenge_hatchettosscount)) {
            data.inflictorchallenge_hatchettosscount = einflictor.challenge_hatchettosscount;
        } else {
            data.inflictorchallenge_hatchettosscount = 0;
        }
        if (isdefined(einflictor.ownerwassprinting)) {
            data.inflictorownerwassprinting = einflictor.ownerwassprinting;
        } else {
            data.inflictorownerwassprinting = 0;
        }
        if (isdefined(einflictor.playerhasengineerperk)) {
            data.inflictorplayerhasengineerperk = einflictor.playerhasengineerperk;
        } else {
            data.inflictorplayerhasengineerperk = 0;
        }
    } else {
        data.inflictoriscooked = 0;
        data.inflictorchallenge_hatchettosscount = 0;
        data.inflictorownerwassprinting = 0;
        data.inflictorplayerhasengineerperk = 0;
    }
    pixendevent();
    waitandprocessplayerkilledcallback(data);
    if (isdefined(attacker)) {
        attacker notify(#"playerkilledchallengesprocessed");
    }
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xd9d1e194, Offset: 0x7aa0
// Size: 0xe4
function waitandprocessplayerkilledcallback(data) {
    if (isdefined(data.attacker)) {
        data.attacker endon(#"disconnect");
    }
    waitframe(1);
    util::waittillslowprocessallowed();
    if (isdefined(data.weapon) && data.weapon != level.weaponnone && isdefined(data.attacker) && isplayer(data.attacker)) {
        level thread dochallengecallback("playerKilled", data);
    }
    level thread scoreevents::doscoreeventcallback("playerKilled", data);
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0x72e34f16, Offset: 0x7b90
// Size: 0x66
function weaponisknife(weapon) {
    if (weapon == level.weaponbasemelee || weapon == level.weaponbasemeleeheld || weapon.rootweapon.statname == level.weaponballisticknife.statname) {
        return true;
    }
    return false;
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0x5500ef04, Offset: 0x7c00
// Size: 0x4a2
function eventreceived(eventname) {
    self endon(#"disconnect");
    util::waittillslowprocessallowed();
    switch (level.gametype) {
    case #"tdm":
        if (eventname == "killstreak_10") {
            self stats::function_d40764f3(#"killstreak_10", 1);
        } else if (eventname == "killstreak_15") {
            self stats::function_d40764f3(#"killstreak_15", 1);
        } else if (eventname == "killstreak_20") {
            self stats::function_d40764f3(#"killstreak_20", 1);
        } else if (eventname == "multikill_3") {
            self stats::function_d40764f3(#"multikill_3", 1);
        } else if (eventname == "kill_enemy_who_killed_teammate") {
            self stats::function_d40764f3(#"kill_enemy_who_killed_teammate", 1);
        } else if (eventname == "kill_enemy_injuring_teammate") {
            self stats::function_d40764f3(#"kill_enemy_injuring_teammate", 1);
        }
        break;
    case #"dm":
        if (eventname == "killstreak_10") {
            self stats::function_d40764f3(#"killstreak_10", 1);
        } else if (eventname == "killstreak_15") {
            self stats::function_d40764f3(#"killstreak_15", 1);
        } else if (eventname == "killstreak_20") {
            self stats::function_d40764f3(#"killstreak_20", 1);
        } else if (eventname == "killstreak_30") {
            self stats::function_d40764f3(#"killstreak_30", 1);
        }
        break;
    case #"sd":
        if (eventname == "defused_bomb_last_man_alive") {
            self stats::function_d40764f3(#"defused_bomb_last_man_alive", 1);
        } else if (eventname == "elimination_and_last_player_alive") {
            self stats::function_d40764f3(#"elimination_and_last_player_alive", 1);
        } else if (eventname == "killed_bomb_planter") {
            self stats::function_d40764f3(#"killed_bomb_planter", 1);
        } else if (eventname == "killed_bomb_defuser") {
            self stats::function_d40764f3(#"killed_bomb_defuser", 1);
        }
        break;
    case #"ctf":
        if (eventname == "kill_flag_carrier") {
            self stats::function_d40764f3(#"kill_flag_carrier", 1);
        } else if (eventname == "defend_flag_carrier") {
            self stats::function_d40764f3(#"defend_flag_carrier", 1);
        }
        break;
    case #"dem":
        if (eventname == "killed_bomb_planter") {
            self stats::function_d40764f3(#"killed_bomb_planter", 1);
        } else if (eventname == "killed_bomb_defuser") {
            self stats::function_d40764f3(#"killed_bomb_defuser", 1);
        }
        break;
    default:
        break;
    }
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x1 linked
// Checksum 0xcca8385b, Offset: 0x80b0
// Size: 0x8a
function monitor_player_sprint() {
    self endon(#"disconnect", #"killplayersprintmonitor", #"death");
    self.lastsprinttime = undefined;
    while (true) {
        self waittill(#"sprint_begin");
        self waittill(#"sprint_end");
        self.lastsprinttime = gettime();
    }
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x4f892d4, Offset: 0x8148
// Size: 0x1a
function isflashbanged() {
    return status_effect::function_4617032e(1);
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x1 linked
// Checksum 0x1b449a13, Offset: 0x8170
// Size: 0x1e
function isheatwavestunned() {
    return isdefined(self._heat_wave_stuned_end) && gettime() < self._heat_wave_stuned_end;
}

// Namespace challenges/challenges_shared
// Params 2, eflags: 0x0
// Checksum 0x9bc45250, Offset: 0x8198
// Size: 0x1b4
function trophy_defense(origin, radius) {
    if (level.challenge_scorestreaksenabled === 1) {
        entities = getdamageableentarray(origin, radius);
        foreach (entity in entities) {
            if (isdefined(entity.challenge_isscorestreak)) {
                self stats::function_dad108fa(#"hash_580b295b38c0ee38", 1);
                break;
            }
            weapon = entity.weapon;
            if (isdefined(weapon)) {
                should_award = 0;
                if (weapon.issignatureweapon) {
                    should_award = 1;
                } else if (weapon.var_76ce72e8) {
                    scoreevents = globallogic_score::function_3cbc4c6c(weapon.var_2e4a8800);
                    should_award = isdefined(scoreevents) && scoreevents.var_fcd2ff3a === 1;
                }
                if (should_award) {
                    self stats::function_dad108fa(#"hash_580b295b38c0ee38", 1);
                    break;
                }
            }
        }
    }
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x1 linked
// Checksum 0xf694820b, Offset: 0x8358
// Size: 0x26
function waittilltimeoutordeath(timeout) {
    self endon(#"death");
    wait timeout;
}

