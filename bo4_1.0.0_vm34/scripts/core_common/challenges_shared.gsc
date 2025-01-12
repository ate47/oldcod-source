#using scripts\abilities\ability_player;
#using scripts\abilities\ability_util;
#using scripts\core_common\drown;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\util_shared;

#namespace challenges;

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x2e0
// Size: 0x4
function init_shared() {
    
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0xccfc9c81, Offset: 0x2f0
// Size: 0x10
function pickedupballisticknife() {
    self.retreivedblades++;
}

// Namespace challenges/challenges_shared
// Params 3, eflags: 0x0
// Checksum 0x4e5cf367, Offset: 0x308
// Size: 0x9e
function trackassists(attacker, damage, isflare) {
    if (!isplayer(attacker)) {
        return;
    }
    if (!isdefined(self.flareattackerdamage)) {
        self.flareattackerdamage = [];
    }
    if (isdefined(isflare) && isflare == 1) {
        self.flareattackerdamage[attacker.clientid] = 1;
        return;
    }
    self.flareattackerdamage[attacker.clientid] = 0;
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0x515151f6, Offset: 0x3b0
// Size: 0x1f4
function destroyedequipment(weapon) {
    if (sessionmodeiszombiesgame()) {
        return;
    }
    if (isdefined(weapon) && weapon.isemp) {
        if (self util::is_item_purchased(#"emp_grenade")) {
            self stats::function_b48aa4e(#"destroy_equipment_with_emp_grenade", 1);
        }
        self function_b5489c4b(weapon, 1);
        if (self util::has_hacker_perk_purchased_and_equipped()) {
            self stats::function_b48aa4e(#"destroy_equipment_with_emp_engineer", 1);
            self stats::function_b48aa4e(#"destroy_equipment_engineer", 1);
        }
    } else if (self util::has_hacker_perk_purchased_and_equipped()) {
        self stats::function_b48aa4e(#"destroy_equipment_engineer", 1);
    }
    self stats::function_b48aa4e(#"destroy_equipment", 1);
    if (isdefined(weapon) && weapon.isbulletweapon && (sessionmodeismultiplayergame() || sessionmodeiswarzonegame())) {
        self stats::function_b48aa4e(#"destroy_equipment_with_bullet", 1);
    }
    self hackedordestroyedequipment();
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x7df94a50, Offset: 0x5b0
// Size: 0xb4
function destroyedtacticalinsert() {
    if (!isdefined(self.pers[#"tacticalinsertsdestroyed"])) {
        self.pers[#"tacticalinsertsdestroyed"] = 0;
    }
    self.pers[#"tacticalinsertsdestroyed"]++;
    if (self.pers[#"tacticalinsertsdestroyed"] >= 5) {
        self.pers[#"tacticalinsertsdestroyed"] = 0;
        self stats::function_b48aa4e(#"destroy_5_tactical_inserts", 1);
    }
}

// Namespace challenges/challenges_shared
// Params 2, eflags: 0x0
// Checksum 0x1168a7e2, Offset: 0x670
// Size: 0x1da
function addflyswatterstat(weapon, aircraft) {
    if (!isdefined(self.pers[#"flyswattercount"])) {
        self.pers[#"flyswattercount"] = 0;
    }
    self stats::function_4f10b697(weapon, #"destroyed_aircraft", 1);
    self.pers[#"flyswattercount"]++;
    if (self.pers[#"flyswattercount"] == 5) {
        self stats::function_4f10b697(weapon, #"destroyed_5_aircraft", 1);
    }
    if (isdefined(aircraft) && isdefined(aircraft.birthtime)) {
        if (gettime() - aircraft.birthtime < 20000) {
            self stats::function_4f10b697(weapon, #"destroyed_aircraft_under20s", 1);
        }
    }
    if (!isdefined(self.destroyedaircrafttime)) {
        self.destroyedaircrafttime = [];
    }
    if (isdefined(self.destroyedaircrafttime[weapon]) && gettime() - self.destroyedaircrafttime[weapon] < 10000) {
        self stats::function_4f10b697(weapon, #"destroyed_2aircraft_quickly", 1);
        self.destroyedaircrafttime[weapon] = undefined;
        return;
    }
    self.destroyedaircrafttime[weapon] = gettime();
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0x66b4dfff, Offset: 0x858
// Size: 0x3c
function function_90c432bd(weapon) {
    self stats::function_4f10b697(weapon, #"destroyed_aircraft", 1);
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0xdb9c4836, Offset: 0x8a0
// Size: 0x70
function canprocesschallenges() {
    /#
        if (getdvarint(#"scr_debug_challenges", 0)) {
            return true;
        }
    #/
    if (level.rankedmatch || level.arenamatch || sessionmodeiscampaigngame()) {
        return true;
    }
    return false;
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0x9fe678be, Offset: 0x918
// Size: 0xf0
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
// Checksum 0xb096c2b5, Offset: 0xa10
// Size: 0x84
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
// Params 2, eflags: 0x0
// Checksum 0x597453c6, Offset: 0xaa0
// Size: 0xda
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
// Checksum 0x9d839f77, Offset: 0xb88
// Size: 0x34
function on_player_connect() {
    self thread initchallengedata();
    self thread spawnwatcher();
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x5e0fea9, Offset: 0xbc8
// Size: 0x72
function initchallengedata() {
    self.pers[#"hash_1f0376e90d850ee7"] = 0;
    self.pers[#"hash_595d621c6b788be0"] = 0;
    self.pers[#"stickexplosivekill"] = 0;
    self.pers[#"carepackagescalled"] = 0;
    self.explosiveinfo = [];
}

// Namespace challenges/challenges_shared
// Params 3, eflags: 0x0
// Checksum 0xd053cb66, Offset: 0xc48
// Size: 0xdc
function isdamagefromplayercontrolledaitank(eattacker, einflictor, weapon) {
    if (weapon.name == #"ai_tank_drone_gun") {
        if (isdefined(eattacker) && isdefined(eattacker.remoteweapon) && isdefined(einflictor)) {
            if (isdefined(einflictor.controlled) && einflictor.controlled) {
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
// Checksum 0x59bf3103, Offset: 0xd30
// Size: 0x98
function isdamagefromplayercontrolledsentry(eattacker, einflictor, weapon) {
    if (weapon.name == #"auto_gun_turret") {
        if (isdefined(eattacker) && isdefined(eattacker.remoteweapon) && isdefined(einflictor)) {
            if (eattacker.remoteweapon == einflictor) {
                if (isdefined(einflictor.controlled) && einflictor.controlled) {
                    return true;
                }
            }
        }
    }
    return false;
}

// Namespace challenges/challenges_shared
// Params 3, eflags: 0x0
// Checksum 0xc91c53fb, Offset: 0xdd0
// Size: 0x74c
function perkkills(victim, isstunned, time) {
    player = self;
    if (player hasperk(#"specialty_movefaster")) {
        player stats::function_b48aa4e(#"perk_movefaster_kills", 1);
    }
    if (player hasperk(#"specialty_noname")) {
        player stats::function_b48aa4e(#"perk_noname_kills", 1);
    }
    if (player hasperk(#"specialty_quieter")) {
        player stats::function_b48aa4e(#"perk_quieter_kills", 1);
    }
    if (player hasperk(#"specialty_longersprint")) {
        if (isdefined(player.lastsprinttime) && gettime() - player.lastsprinttime < 2500) {
            player stats::function_b48aa4e(#"perk_longersprint", 1);
        }
    }
    if (player hasperk(#"specialty_fastmantle")) {
        if (isdefined(player.lastsprinttime) && gettime() - player.lastsprinttime < 2500 && player playerads() >= 1) {
            player stats::function_b48aa4e(#"perk_fastmantle_kills", 1);
        }
    }
    if (player hasperk(#"specialty_loudenemies")) {
        player stats::function_b48aa4e(#"perk_loudenemies_kills", 1);
    }
    if (isstunned == 1 && player hasperk(#"specialty_stunprotection")) {
        player stats::function_b48aa4e(#"perk_protection_stun_kills", 1);
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
            player stats::function_b48aa4e(#"perk_immune_cuav_kills", 1);
        }
    }
    activeuavvictim = 0;
    if (level.teambased) {
        if (level.activeuavs[victim.team] > 0) {
            activeuavvictim = 1;
        }
    } else {
        activeuavvictim = isdefined(level.activeuavs[victim.entnum]) && level.activeuavs[victim.entnum] > 0;
    }
    if (activeuavvictim == 1) {
        if (player hasperk(#"specialty_gpsjammer")) {
            player stats::function_b48aa4e(#"perk_gpsjammer_immune_kills", 1);
        }
    }
    if (player.lastweaponchange + 5000 > time) {
        if (player hasperk(#"specialty_fastweaponswitch")) {
            player stats::function_b48aa4e(#"perk_fastweaponswitch_kill_after_swap", 1);
        }
    }
    if (player.scavenged == 1) {
        if (player hasperk(#"specialty_scavenger")) {
            player stats::function_b48aa4e(#"perk_scavenger_kills_after_resupply", 1);
        }
    }
}

// Namespace challenges/challenges_shared
// Params 2, eflags: 0x0
// Checksum 0x381744ca, Offset: 0x1528
// Size: 0x86
function flakjacketprotected(weapon, attacker) {
    if (weapon.name == #"claymore") {
        self.flakjacketclaymore[attacker.clientid] = 1;
    }
    self stats::function_b48aa4e(#"survive_with_flak", 1);
    self.challenge_lastsurvivewithflakfrom = attacker;
    self.challenge_lastsurvivewithflaktime = gettime();
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0xe3b715a9, Offset: 0x15b8
// Size: 0xae
function earnedkillstreak() {
    if (self util::has_purchased_perk_equipped(#"specialty_anteup")) {
        self stats::function_b48aa4e(#"earn_scorestreak_anteup", 1);
        if (!isdefined(self.var_fcd72b66)) {
            self.var_fcd72b66 = 0;
        }
        self.var_fcd72b66++;
        if (self.var_fcd72b66 >= 5) {
            self stats::function_b48aa4e(#"earn_5_scorestreaks_anteup", 1);
            self.var_fcd72b66 = 0;
        }
    }
}

// Namespace challenges/challenges_shared
// Params 3, eflags: 0x0
// Checksum 0xe3033437, Offset: 0x1670
// Size: 0x184
function genericbulletkill(data, victim, weapon) {
    player = self;
    time = data.time;
    if (player.pers[#"hash_595d621c6b788be0"] == time) {
        player.pers[#"hash_1f0376e90d850ee7"]++;
    } else {
        player.pers[#"hash_1f0376e90d850ee7"] = 1;
    }
    player.pers[#"hash_595d621c6b788be0"] = time;
    if (data.victim.idflagstime == time) {
        if (data.victim.idflags & 8) {
            player stats::function_b48aa4e(#"kill_enemy_through_wall", 1);
            if (isdefined(weapon) && weaponhasattachment(weapon, "fmj")) {
                player stats::function_b48aa4e(#"kill_enemy_through_wall_with_fmj", 1);
            }
        }
    }
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0x681bbeb7, Offset: 0x1800
// Size: 0x182
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
// Params 0, eflags: 0x0
// Checksum 0x7cea3473, Offset: 0x1990
// Size: 0x158
function spawnwatcher() {
    self endon(#"disconnect");
    self endon(#"killspawnmonitor");
    self.pers[#"stickexplosivekill"] = 0;
    self.pers[#"pistolheadshot"] = 0;
    self.pers[#"assaultrifleheadshot"] = 0;
    self.pers[#"killnemesis"] = 0;
    while (true) {
        self waittill(#"spawned_player");
        self.pers[#"longshotsperlife"] = 0;
        self.flakjacketclaymore = [];
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
// Params 0, eflags: 0x0
// Checksum 0x3f3aee99, Offset: 0x1af0
// Size: 0x76
function watchfordtp() {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"killdtpmonitor");
    self.dtptime = 0;
    while (true) {
        self waittill(#"dtp_end");
        self.dtptime = gettime() + 4000;
    }
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x4dc3db24, Offset: 0x1b70
// Size: 0x82
function watchformantle() {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"killmantlemonitor");
    self.mantletime = 0;
    while (true) {
        waitresult = self waittill(#"mantle_start");
        self.mantletime = waitresult.end_time;
    }
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x23c5b5f5, Offset: 0x1c00
// Size: 0x2c
function disarmedhackedcarepackage() {
    self stats::function_b48aa4e(#"disarm_hacked_carepackage", 1);
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0xcf2b1ef1, Offset: 0x1c38
// Size: 0x54
function destroyed_car() {
    if (!isdefined(self) || !isplayer(self)) {
        return;
    }
    self stats::function_b48aa4e(#"destroy_car", 1);
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0xd5e4c471, Offset: 0x1c98
// Size: 0xb4
function killednemesis() {
    if (!isdefined(self.pers[#"killnemesis"])) {
        self.pers[#"killnemesis"] = 0;
    }
    self.pers[#"killnemesis"]++;
    if (self.pers[#"killnemesis"] >= 5) {
        self.pers[#"killnemesis"] = 0;
        self stats::function_b48aa4e(#"kill_nemesis", 1);
    }
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0xa8c4ba99, Offset: 0x1d58
// Size: 0x2c
function killwhiledamagingwithhpm() {
    self stats::function_b48aa4e(#"kill_while_damaging_with_microwave_turret", 1);
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0xf4298e87, Offset: 0x1d90
// Size: 0x2c
function longdistancehatchetkill() {
    self stats::function_b48aa4e(#"long_distance_hatchet_kill", 1);
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x5abdb128, Offset: 0x1dc8
// Size: 0x2c
function blockedsatellite() {
    self stats::function_b48aa4e(#"activate_cuav_while_enemy_satelite_active", 1);
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x86864982, Offset: 0x1e00
// Size: 0x7c
function longdistancekill() {
    self.pers[#"longshotsperlife"]++;
    if (self.pers[#"longshotsperlife"] >= 3) {
        self.pers[#"longshotsperlife"] = 0;
        self stats::function_b48aa4e(#"longshot_3_onelife", 1);
    }
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0xd82b1e72, Offset: 0x1e88
// Size: 0x18a
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
                player stats::function_5396eef9(#"round_win_no_deaths", 1);
            }
            if (isdefined(player.lastmansddefeat3enemies)) {
                player stats::function_5396eef9(#"last_man_defeat_3_enemies", 1);
            }
        }
        break;
    default:
        break;
    }
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0xdf52d5e2, Offset: 0x2020
// Size: 0x126
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
// Params 0, eflags: 0x4
// Checksum 0x2ab85311, Offset: 0x2150
// Size: 0x2c
function private function_451c9c6b() {
    wait 2;
    level.var_c9225931 = 1;
    function_5ce5d0be();
}

// Namespace challenges/challenges_shared
// Params 2, eflags: 0x0
// Checksum 0x5eede4c7, Offset: 0x2188
// Size: 0x204
function gameend(winner, var_c3d87d03) {
    waitframe(1);
    data = spawnstruct();
    data.time = gettime();
    if (level.teambased) {
        if (isdefined(winner) && isdefined(level.teams[winner])) {
            data.winner = winner;
        }
    } else if (isdefined(winner) && isplayer(winner)) {
        data.winner = winner;
    }
    for (index = 0; index < level.placement[#"all"].size; index++) {
        data.player = level.placement[#"all"][index];
        data.place = index;
        if (isdefined(data.player)) {
            dochallengecallback("gameEnd", data);
        }
    }
    if ((sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) && sessionmodeisonlinegame() && level.rankedmatch) {
        if (getdvarint(#"hash_7902ca2d14eb933b", 0) == 1) {
            level.var_c9225931 = 1;
            function_5ce5d0be();
            return;
        }
        thread function_451c9c6b();
    }
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0x2ecb19f, Offset: 0x2398
// Size: 0x4c
function getfinalkill(player) {
    if (isplayer(player)) {
        player stats::function_b48aa4e(#"get_final_kill", 1);
    }
}

// Namespace challenges/challenges_shared
// Params 2, eflags: 0x0
// Checksum 0xb7126533, Offset: 0x23f0
// Size: 0xa4
function destroy_killstreak_vehicle(weapon, hatchet_kill_stat) {
    if (!isplayer(self) || !isdefined(weapon)) {
        return;
    }
    self destroyscorestreak(weapon, 1, 1);
    if (weapon.rootweapon.name == "hatchet" && isdefined(hatchet_kill_stat)) {
        self stats::function_b48aa4e(hatchet_kill_stat, 1);
    }
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0x68fac976, Offset: 0x24a0
// Size: 0xd4
function capturedcrate(owner) {
    if (isdefined(self.lastrescuedby) && isdefined(self.lastrescuedtime)) {
        if (self.lastrescuedtime + 5000 > gettime()) {
            self.lastrescuedby stats::function_b48aa4e(#"defend_teammate_who_captured_package", 1);
        }
    }
    if (owner != self && (level.teambased && owner.team != self.team || !level.teambased)) {
        self stats::function_b48aa4e(#"capture_enemy_carepackage", 1);
    }
}

// Namespace challenges/challenges_shared
// Params 4, eflags: 0x0
// Checksum 0xcc69b8bc, Offset: 0x2580
// Size: 0x42c
function destroyscorestreak(weapon, playercontrolled, groundbased, countaskillstreakvehicle = 1) {
    if (!isplayer(self) || !isdefined(weapon)) {
        return;
    }
    if (isdefined(level.killstreakweapons[weapon])) {
        if (level.killstreakweapons[weapon] == "dart") {
            self stats::function_b48aa4e(#"destroy_scorestreak_with_dart", 1);
        }
    } else if (weapon.isheavyweapon) {
        self stats::function_b48aa4e(#"destroy_scorestreak_with_specialist", 1);
    } else if (weaponhasattachment(weapon, "fmj", "rf")) {
        self stats::function_b48aa4e(#"destroy_scorestreak_rapidfire_fmj", 1);
    }
    if (!isdefined(playercontrolled) || playercontrolled == 0) {
        if (self util::has_cold_blooded_perk_purchased_and_equipped()) {
            if (groundbased) {
                self stats::function_b48aa4e(#"destroy_ai_scorestreak_coldblooded", 1);
            }
            if (self util::has_blind_eye_perk_purchased_and_equipped()) {
                if (groundbased) {
                    self.pers[#"challenge_destroyed_ground"]++;
                } else {
                    self.pers[#"challenge_destroyed_air"]++;
                }
                if (self.pers[#"challenge_destroyed_ground"] > 0 && self.pers[#"challenge_destroyed_air"] > 0) {
                    self stats::function_b48aa4e(#"destroy_air_and_ground_blindeye_coldblooded", 1);
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
        self stats::function_4f10b697(weapon, #"destroy_5_killstreak", 1);
        self stats::function_4f10b697(weapon, #"destroy_5_killstreak_vehicle", 1);
    }
    self stats::function_4f10b697(weapon, #"destroy_killstreak", 1);
    weaponpickedup = 0;
    if (isdefined(self.pickedupweapons) && isdefined(self.pickedupweapons[weapon])) {
        weaponpickedup = 1;
    }
    self stats::function_c8a05f4f(weapon, #"destroyed", 1, self.class_num, weaponpickedup);
    self thread watchforrapiddestroy(weapon);
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0xd5f7185c, Offset: 0x29b8
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
        self stats::function_4f10b697(weapon, #"destroy_2_killstreaks_rapidly", 1);
    }
}

// Namespace challenges/challenges_shared
// Params 2, eflags: 0x0
// Checksum 0xa8668b8c, Offset: 0x2a80
// Size: 0x2be
function capturedobjective(capturetime, objective) {
    if (isdefined(self.smokegrenadetime) && isdefined(self.smokegrenadeposition)) {
        if (self.smokegrenadetime + 14000 > capturetime) {
            distsq = distancesquared(self.smokegrenadeposition, self.origin);
            if (distsq < 57600) {
                if (self util::is_item_purchased(#"willy_pete")) {
                    self stats::function_b48aa4e(#"capture_objective_in_smoke", 1);
                }
                self stats::function_4f10b697(getweapon(#"willy_pete"), #"combatrecordstat", 1);
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
                self stats::function_b48aa4e(#"triple_kill_defenders_and_capture", 1);
            }
            self.challenge_objectivedefensivekillcount = 0;
            self.challenge_objectivedefensive = undefined;
            self.challenge_objectivedefensivetriplekillmedalorbetterearned = undefined;
        }
    }
    self notify(#"capturedobjective", {#capturetime:capturetime, #var_f63c6ccc:objective});
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x3b7bb330, Offset: 0x2d48
// Size: 0x44
function hackedordestroyedequipment() {
    if (self util::has_hacker_perk_purchased_and_equipped()) {
        self stats::function_b48aa4e(#"perk_hacker_destroy", 1);
    }
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x97d4c7d6, Offset: 0x2d98
// Size: 0xb4
function bladekill() {
    if (!isdefined(self.pers[#"bladekills"])) {
        self.pers[#"bladekills"] = 0;
    }
    self.pers[#"bladekills"]++;
    if (self.pers[#"bladekills"] >= 15) {
        self.pers[#"bladekills"] = 0;
        self stats::function_b48aa4e(#"kill_15_with_blade", 1);
    }
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0xa05b0809, Offset: 0x2e58
// Size: 0x4c
function destroyedexplosive(weapon) {
    self destroyedequipment(weapon);
    self stats::function_b48aa4e(#"destroy_explosive", 1);
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x11ee7da5, Offset: 0x2eb0
// Size: 0x2c
function assisted() {
    self stats::function_b48aa4e(#"assist", 1);
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0xa4540d2d, Offset: 0x2ee8
// Size: 0xd4
function earnedmicrowaveassistscore(score) {
    self stats::function_b48aa4e(#"assist_score_microwave_turret", score);
    self stats::function_b48aa4e(#"assist_score_killstreak", score);
    self stats::function_4f10b697(getweapon(#"microwave_turret_deploy"), #"assists", 1);
    self stats::function_4f10b697(getweapon(#"microwave_turret_deploy"), #"assist_score", score);
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0xd039ca79, Offset: 0x2fc8
// Size: 0xd4
function earnedcuavassistscore(score) {
    self stats::function_b48aa4e(#"assist_score_cuav", score);
    self stats::function_b48aa4e(#"assist_score_killstreak", score);
    self stats::function_4f10b697(getweapon(#"counteruav"), #"assists", 1);
    self stats::function_4f10b697(getweapon(#"counteruav"), #"assist_score", score);
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0x46f14423, Offset: 0x30a8
// Size: 0xd4
function earneduavassistscore(score) {
    self stats::function_b48aa4e(#"assist_score_uav", score);
    self stats::function_b48aa4e(#"assist_score_killstreak", score);
    self stats::function_4f10b697(getweapon(#"uav"), #"assists", 1);
    self stats::function_4f10b697(getweapon(#"uav"), #"assist_score", score);
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0x2af737fb, Offset: 0x3188
// Size: 0xd4
function earnedsatelliteassistscore(score) {
    self stats::function_b48aa4e(#"assist_score_satellite", score);
    self stats::function_b48aa4e(#"assist_score_killstreak", score);
    self stats::function_4f10b697(getweapon(#"satellite"), #"assists", 1);
    self stats::function_4f10b697(getweapon(#"satellite"), #"assist_score", score);
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0xf82fd31e, Offset: 0x3268
// Size: 0xd4
function earnedempassistscore(score) {
    self stats::function_b48aa4e(#"assist_score_emp", score);
    self stats::function_b48aa4e(#"assist_score_killstreak", score);
    self stats::function_4f10b697(getweapon(#"emp_turret"), #"assists", 1);
    self stats::function_4f10b697(getweapon(#"emp_turret"), #"assist_score", score);
}

// Namespace challenges/challenges_shared
// Params 2, eflags: 0x0
// Checksum 0xd13622ad, Offset: 0x3348
// Size: 0xae
function teamcompletedchallenge(team, challenge) {
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (isdefined(players[i].team) && players[i].team == team) {
            players[i] stats::function_5396eef9(challenge, 1);
        }
    }
}

// Namespace challenges/challenges_shared
// Params 2, eflags: 0x0
// Checksum 0xb19a127e, Offset: 0x3400
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
// Params 1, eflags: 0x0
// Checksum 0x94b357ca, Offset: 0x3460
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
// Checksum 0x6ff05eea, Offset: 0x3528
// Size: 0xaa
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
// Checksum 0xac7c1841, Offset: 0x35e0
// Size: 0x5d2
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
    switch (level.gametype) {
    case #"tdm":
        if (player.team == winner) {
            if (winnerscore >= loserscore + 20) {
                player stats::function_5396eef9(#"crush", 1);
            }
        }
        var_d2d122ff = 1;
        for (index = 0; index < level.placement[#"all"].size; index++) {
            if (level.placement[#"all"][index].deaths < player.deaths) {
                var_d2d122ff = 0;
            }
            if (level.placement[#"all"][index].kills > player.kills) {
                var_d2d122ff = 0;
            }
        }
        if (var_d2d122ff && player.kills > 0 && level.placement[#"all"].size > 3) {
            player stats::function_5396eef9(#"hash_7347e683426cd120", 1);
        }
        break;
    case #"dm":
        if (player == winner) {
            if (level.placement[#"all"].size >= 2) {
                secondplace = level.placement[#"all"][1];
                if (player.kills >= secondplace.kills + 7) {
                    player stats::function_5396eef9(#"crush", 1);
                }
            }
        }
        break;
    case #"ctf":
        if (player.team == winner) {
            if (loserscore == 0) {
                player stats::function_5396eef9(#"shut_out", 1);
            }
        }
        break;
    case #"dom":
        if (player.team == winner) {
            if (winnerscore >= loserscore + 70) {
                player stats::function_5396eef9(#"crush", 1);
            }
        }
        break;
    case #"hq":
        if (player.team == winner && winnerscore > 0) {
            if (winnerscore >= loserscore + 70) {
                player stats::function_5396eef9(#"crush", 1);
            }
        }
        break;
    case #"koth":
        if (player.team == winner && winnerscore > 0) {
            if (winnerscore >= loserscore + 70) {
                player stats::function_5396eef9(#"crush", 1);
            }
        }
        if (player.team == winner && winnerscore > 0) {
            if (winnerscore >= loserscore + 110) {
                player stats::function_5396eef9(#"annihilation", 1);
            }
        }
        break;
    case #"dem":
        if (player.team == game.defenders && player.team == winner) {
            if (loserscore == 0) {
                player stats::function_5396eef9(#"shut_out", 1);
            }
        }
        break;
    case #"sd":
        if (player.team == winner) {
            if (loserscore <= 1) {
                player stats::function_5396eef9(#"crush", 1);
            }
        }
    default:
        break;
    }
}

// Namespace challenges/challenges_shared
// Params 2, eflags: 0x0
// Checksum 0x58e47bcd, Offset: 0x3bc0
// Size: 0x1dc
function multikill(killcount, weapon) {
    if (!sessionmodeismultiplayergame() && !sessionmodeiswarzonegame()) {
        return;
    }
    if (killcount >= 3 && isdefined(self.lastkillwheninjured)) {
        if (self.lastkillwheninjured + 5000 > gettime()) {
            self stats::function_b48aa4e(#"multikill_3_near_death", 1);
        }
    }
    self stats::function_4f10b697(weapon, #"doublekill", int(killcount / 2));
    self stats::function_4f10b697(weapon, #"triplekill", int(killcount / 3));
    if (weapon.isheavyweapon) {
        doublekill = int(killcount / 2);
        if (doublekill) {
            self stats::function_b48aa4e(#"multikill_2_with_heroweapon", doublekill);
        }
        triplekill = int(killcount / 3);
        if (triplekill) {
            self stats::function_b48aa4e(#"multikill_3_with_heroweapon", triplekill);
        }
    }
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0x9cc2a899, Offset: 0x3da8
// Size: 0x34
function domattackermultikill(killcount) {
    self stats::function_5396eef9(#"kill_2_enemies_capturing_your_objective", 1);
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0xb567ce2e, Offset: 0x3de8
// Size: 0x2c
function totaldomination(team) {
    teamcompletedchallenge(team, "control_3_points_3_minutes");
}

// Namespace challenges/challenges_shared
// Params 2, eflags: 0x0
// Checksum 0xdabecf57, Offset: 0x3e20
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
// Checksum 0x2f756586, Offset: 0x3ee8
// Size: 0x2c
function capturedbfirstminute() {
    self stats::function_5396eef9(#"capture_b_first_minute", 1);
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0x2121ae47, Offset: 0x3f20
// Size: 0x2c
function controlzoneentirely(team) {
    teamcompletedchallenge(team, "control_zone_entirely");
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x2ad54adf, Offset: 0x3f58
// Size: 0x2c
function multi_lmg_smg_kill() {
    self stats::function_b48aa4e(#"multikill_3_lmg_or_smg_hip_fire", 1);
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0x601e1986, Offset: 0x3f90
// Size: 0x74
function killedzoneattacker(weapon) {
    if (weapon.name == #"planemortar" || weapon.name == "remote_missile_missile" || weapon.name == #"remote_missile_bomblet") {
        self thread updatezonemultikills();
    }
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x22f3bea1, Offset: 0x4010
// Size: 0x10c
function killeddog() {
    origin = self.origin;
    if (level.teambased) {
        teammates = util::get_active_players(self.team);
        foreach (player in teammates) {
            if (player == self) {
                continue;
            }
            distsq = distancesquared(origin, player.origin);
            if (distsq < 57600) {
                self stats::function_b48aa4e(#"killed_dog_close_to_teammate", 1);
                break;
            }
        }
    }
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0xaaa357c4, Offset: 0x4128
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
        self stats::function_b48aa4e(#"multikill_2_zone_attackers", 1);
    }
    self.recentzonekillcount = 0;
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0xf2bcbd89, Offset: 0x41e8
// Size: 0x2c
function multi_rcbomb_kill() {
    self stats::function_b48aa4e(#"multikill_2_with_rcbomb", 1);
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x8921392e, Offset: 0x4220
// Size: 0x2c
function multi_remotemissile_kill() {
    self stats::function_b48aa4e(#"multikill_3_remote_missile", 1);
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0xb0be9df6, Offset: 0x4258
// Size: 0x2c
function multi_mgl_kill() {
    self stats::function_b48aa4e(#"multikill_3_with_mgl", 1);
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x9380c249, Offset: 0x4290
// Size: 0x2c
function immediatecapture() {
    self stats::function_5396eef9(#"immediate_capture", 1);
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x3261c9f7, Offset: 0x42c8
// Size: 0x2c
function killedlastcontester() {
    self stats::function_5396eef9(#"contest_then_capture", 1);
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x3488578a, Offset: 0x4300
// Size: 0x2c
function bothbombsdetonatewithintime() {
    self stats::function_5396eef9(#"both_bombs_detonate_10_seconds", 1);
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x72e9b28c, Offset: 0x4338
// Size: 0x7e
function calledincarepackage() {
    self.pers[#"carepackagescalled"]++;
    if (self.pers[#"carepackagescalled"] >= 3) {
        self stats::function_b48aa4e(#"call_in_3_care_packages", 1);
        self.pers[#"carepackagescalled"] = 0;
    }
}

// Namespace challenges/challenges_shared
// Params 4, eflags: 0x0
// Checksum 0x77874b31, Offset: 0x43c0
// Size: 0xac
function destroyedhelicopter(attacker, weapon, damagetype, playercontrolled) {
    if (!isplayer(attacker)) {
        return;
    }
    attacker destroyscorestreak(weapon, playercontrolled, 0);
    if (damagetype == "MOD_RIFLE_BULLET" || damagetype == "MOD_PISTOL_BULLET") {
        attacker stats::function_b48aa4e(#"destroyed_helicopter_with_bullet", 1);
    }
}

// Namespace challenges/challenges_shared
// Params 2, eflags: 0x0
// Checksum 0xaf4c6b8b, Offset: 0x4478
// Size: 0xbc
function destroyedqrdrone(damagetype, weapon) {
    self destroyscorestreak(weapon, 1, 0);
    self stats::function_b48aa4e(#"destroy_qrdrone", 1);
    if (damagetype == "MOD_RIFLE_BULLET" || damagetype == "MOD_PISTOL_BULLET") {
        self stats::function_b48aa4e(#"destroyed_qrdrone_with_bullet", 1);
    }
    self destroyedplayercontrolledaircraft();
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x3984761, Offset: 0x4540
// Size: 0x4c
function destroyedplayercontrolledaircraft() {
    if (self hasperk(#"specialty_noname")) {
        self stats::function_b48aa4e(#"destroy_helicopter", 1);
    }
}

// Namespace challenges/challenges_shared
// Params 3, eflags: 0x0
// Checksum 0x10876c7e, Offset: 0x4598
// Size: 0x224
function destroyedaircraft(attacker, weapon, playercontrolled) {
    if (!isplayer(attacker)) {
        return;
    }
    attacker destroyscorestreak(weapon, playercontrolled, 0);
    if (isdefined(weapon)) {
        if (weapon.name == #"emp" && attacker util::is_item_purchased(#"killstreak_emp")) {
            attacker stats::function_b48aa4e(#"destroy_aircraft_with_emp", 1);
        } else if (weapon.name == #"missile_drone_projectile" || weapon.name == #"missile_drone") {
            attacker stats::function_b48aa4e(#"destroy_aircraft_with_missile_drone", 1);
        } else if (weapon.isbulletweapon) {
            attacker stats::function_b48aa4e(#"shoot_aircraft", 1);
        }
    }
    if (attacker util::has_blind_eye_perk_purchased_and_equipped()) {
        attacker stats::function_b48aa4e(#"perk_nottargetedbyairsupport_destroy_aircraft", 1);
    }
    attacker stats::function_b48aa4e(#"destroy_aircraft", 1);
    if (isdefined(playercontrolled) && playercontrolled == 0) {
        if (attacker util::has_blind_eye_perk_purchased_and_equipped()) {
            attacker stats::function_b48aa4e(#"destroy_ai_aircraft_using_blindeye", 1);
        }
    }
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x408347ca, Offset: 0x47c8
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
    self stats::function_b48aa4e(#"killstreak_10_no_weapons_perks", 1);
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x7a76716c, Offset: 0x4978
// Size: 0xa0
function scavengedgrenade() {
    self endon(#"disconnect");
    self endon(#"death");
    self notify(#"scavengedgrenade");
    self endon(#"scavengedgrenade");
    self notify(#"scavenged_primary_grenade");
    for (;;) {
        self waittill(#"lethalgrenadekill");
        self stats::function_b48aa4e(#"kill_with_resupplied_lethal_grenade", 1);
    }
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0x93793518, Offset: 0x4a20
// Size: 0x34
function stunnedtankwithempgrenade(attacker) {
    attacker stats::function_b48aa4e(#"stun_aitank_with_emp_grenade", 1);
}

// Namespace challenges/challenges_shared
// Params 8, eflags: 0x0
// Checksum 0xb24a2c2, Offset: 0x4a60
// Size: 0x1cc0
function playerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, shitloc, attackerstance, bledout) {
    /#
        print(level.gametype);
    #/
    self.anglesondeath = self getplayerangles();
    if (isdefined(attacker)) {
        attacker.anglesonkill = attacker getplayerangles();
    }
    if (!isdefined(weapon)) {
        weapon = level.weaponnone;
    }
    self endon(#"disconnect");
    data = spawnstruct();
    data.victim = self;
    data.victimorigin = self.origin;
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
            data.var_b83eae54 = 1;
        }
    }
    waslockingon &= 1 << data.victim getentitynumber();
    if (waslockingon != 0) {
        data.waslockingon = 1;
    } else {
        data.waslockingon = 0;
    }
    data.washacked = washacked;
    data.wasplanting = data.victim.isplanting;
    data.wasunderwater = data.victim isplayerunderwater();
    if (!isdefined(data.wasplanting)) {
        data.wasplanting = 0;
    }
    data.wasdefusing = data.victim.isdefusing;
    if (!isdefined(data.wasdefusing)) {
        data.wasdefusing = 0;
    }
    data.var_b1079a1b = [];
    if (isarray(self.var_a304768d)) {
        foreach (effect in self.var_a304768d) {
            struct = spawnstruct();
            if (isdefined(effect.var_2fcb5e92)) {
                struct.var_980d2212 = effect.var_2fcb5e92.var_980d2212;
            }
            struct.var_85e878ff = effect.var_85e878ff;
            struct.var_ed5f2f94 = effect.var_ed5f2f94;
            struct.name = effect.namehash;
            if (!isdefined(data.var_b1079a1b)) {
                data.var_b1079a1b = [];
            } else if (!isarray(data.var_b1079a1b)) {
                data.var_b1079a1b = array(data.var_b1079a1b);
            }
            data.var_b1079a1b[data.var_b1079a1b.size] = struct;
        }
    }
    data.victimweapon = data.victim.currentweapon;
    data.victimonground = data.victim isonground();
    data.var_f67ec791 = data.victim iswallrunning();
    data.victimlaststunnedby = data.victim.laststunnedby;
    data.var_b9995fb9 = data.victim isdoublejumping();
    data.victimcombatefficiencylastontime = data.victim.combatefficiencylastontime;
    data.victimspeedburstlastontime = data.victim.speedburstlastontime;
    data.victimcombatefficieny = data.victim ability_util::gadget_is_active(12);
    data.victimheroabilityactive = ability_player::gadget_checkheroabilitykill(data.victim);
    data.victimelectrifiedby = data.victim.electrifiedby;
    data.victimheroability = data.victim.heroability;
    data.victimwasinslamstate = data.victim isslamming();
    data.victimwaslungingwitharmblades = data.victim isgadgetmeleecharging();
    data.var_7501e33a = data.victim function_4867f855();
    data.victimwasheatwavestunned = data.victim isheatwavestunned();
    data.victimpowerarmorlasttookdamagetime = data.victim.power_armor_last_took_damage_time;
    data.var_3893310d = data.victim.heavyweaponkillsthisactivation;
    data.victimgadgetwasactivelastdamage = data.victim.gadget_was_active_last_damage;
    data.victimisthieforroulette = data.victim.isthief === 1 || data.victim.isroulette === 1;
    data.victimheroabilityname = data.victim.heroabilityname;
    data.var_9c8b7685 = data.victim.var_fd488445;
    data.var_83a9e4a6 = data.victim.var_8ecca966;
    slot = data.victim gadgetgetslot(data.victimweapon);
    data.victimgadgetpower = data.victim gadgetpowerget(slot);
    if (isdefined(data.victim.in_enemy_mute_smoke) && data.victim.in_enemy_mute_smoke || isdefined(data.victim.var_6eb292ec) && data.victim.var_6eb292ec) {
        data.var_af10010a = 1;
    }
    data.var_fda6fe6 = data.victim.in_enemy_mute_smoke;
    data.var_4aa55cc0 = data.victim.var_d80a3c80;
    data.var_1a493d95 = data.victim.lastflashedby;
    data.var_cc0c0c1a = data.victim isflashbanged();
    data.var_3088702b = data.victim status_effect::function_d7236ba9(5);
    data.var_c52dac68 = data.victim.var_8236e828;
    data.var_b4f52924 = data.victim.var_4243ae4;
    data.var_a2a42cd5 = data.victim status_effect::function_d7236ba9(2);
    data.var_eec11386 = data.victim.var_94ffc146;
    data.var_a2ac4ca6 = data.victim.var_d0b44166;
    if (!isdefined(data.victimcombatefficiencylastontime)) {
        data.victimcombatefficiencylastontime = 0;
    }
    if (!isdefined(data.victimspeedburstlastontime)) {
        data.victimspeedburstlastontime = 0;
    }
    data.victimvisionpulseactivatetime = data.victim.visionpulseactivatetime;
    if (!isdefined(data.victimvisionpulseactivatetime)) {
        data.victimvisionpulseactivatetime = 0;
    }
    data.victimvisionpulsearray = util::array_copy_if_array(data.victim.visionpulsearray);
    data.victimvisionpulseorigin = data.victim.visionpulseorigin;
    data.victimvisionpulseoriginarray = util::array_copy_if_array(data.victim.visionpulseoriginarray);
    data.victimattackersthisspawn = util::array_copy_if_array(data.victim.attackersthisspawn);
    data.victimlastvisionpulsedby = data.victim.lastvisionpulsedby;
    data.victimlastvisionpulsedtime = data.victim.lastvisionpulsedtime;
    if (!isdefined(data.victimlastvisionpulsedtime)) {
        data.victimlastvisionpulsedtime = 0;
    }
    data.var_38377c1b = data.victim.var_355829db;
    data.var_5bd9ee89 = data.victim.var_150f7cf6;
    data.var_82701a51 = data.victim.var_fdd0883a;
    data.victim_jump_begin = data.victim.challenge_jump_begin;
    data.victim_jump_end = data.victim.challenge_jump_end;
    data.victim_swimming_begin = data.victim.challenge_swimming_begin;
    data.victim_swimming_end = data.victim.challenge_swimming_end;
    data.victim_slide_begin = data.victim.challenge_slide_begin;
    data.victim_slide_end = data.victim.challenge_slide_end;
    data.var_5d1971dd = data.victim.var_da3759c8;
    data.var_d4842f85 = data.victim.var_77c2a8fc;
    data.var_6a9f8d24 = data.victim drown::is_player_drowning();
    if (isdefined(data.victim.activeproximitygrenades)) {
        data.victimactiveproximitygrenades = [];
        arrayremovevalue(data.victim.activeproximitygrenades, undefined);
        foreach (proximitygrenade in data.victim.activeproximitygrenades) {
            proximitygrenadeinfo = spawnstruct();
            proximitygrenadeinfo.origin = proximitygrenade.origin;
            data.victimactiveproximitygrenades[data.victimactiveproximitygrenades.size] = proximitygrenadeinfo;
        }
    }
    if (isdefined(data.victim.activebouncingbetties)) {
        data.victimactivebouncingbetties = [];
        arrayremovevalue(data.victim.activebouncingbetties, undefined);
        foreach (bouncingbetty in data.victim.activebouncingbetties) {
            bouncingbettyinfo = spawnstruct();
            bouncingbettyinfo.origin = bouncingbetty.origin;
            data.victimactivebouncingbetties[data.victimactivebouncingbetties.size] = bouncingbettyinfo;
        }
    }
    if (isplayer(attacker)) {
        data.attackerorigin = data.attacker.origin;
        data.attackeronground = data.attacker isonground();
        data.var_e4763e35 = data.attacker iswallrunning();
        data.var_c39b9276 = data.attacker function_9467d61();
        data.var_3828b415 = data.attacker isdoublejumping();
        data.attackertraversing = data.attacker istraversing();
        data.attackersliding = data.attacker issliding();
        data.attackerspeedburst = data.attacker ability_util::gadget_is_active(10);
        data.attackerheroabilityactive = ability_player::gadget_checkheroabilitykill(data.attacker);
        data.attackerheroability = data.attacker.heroability;
        data.attackervisionpulseactivatetime = attacker.visionpulseactivatetime;
        if (!isdefined(data.attackervisionpulseactivatetime)) {
            data.attackervisionpulseactivatetime = 0;
        }
        data.attackervisionpulsearray = util::array_copy_if_array(attacker.visionpulsearray);
        data.attackervisionpulseorigin = attacker.visionpulseorigin;
        if (!isdefined(data.attackerstance)) {
            data.attackerstance = data.attacker getstance();
        }
        data.attackervisionpulseoriginarray = util::array_copy_if_array(attacker.visionpulseoriginarray);
        data.attackerwasflashed = data.attacker isflashbanged();
        data.attackerlastflashedby = data.attacker.lastflashedby;
        data.attackerlaststunnedby = data.attacker.laststunnedby;
        data.attackerlaststunnedtime = data.attacker.laststunnedtime;
        data.attackerwasconcussed = isdefined(data.attacker.concussionendtime) && data.attacker.concussionendtime > gettime();
        data.attackerwasheatwavestunned = data.attacker isheatwavestunned();
        data.attackerwasunderwater = data.attacker isplayerunderwater();
        data.attackerlastfastreloadtime = data.attacker.lastfastreloadtime;
        data.attackerwassliding = data.attacker issliding();
        data.attackerwassprinting = data.attacker issprinting();
        data.attackeristhief = attacker.isthief === 1;
        data.attackerisroulette = attacker.isroulette === 1;
        data.var_a978676b = data.attacker isgrappling() || isdefined(data.attacker.var_f25a80c2) && data.attacker.var_f25a80c2 + 2000 > gettime();
        data.var_ce2d42f1 = isdefined(data.victim.lastattackedshieldtime) && data.victim.lastattackedshieldtime + 500 > gettime();
        data.var_f4b4b342 = data.attacker.var_150f7cf6;
        data.var_3e129f16 = data.attacker.var_fdd0883a;
        data.attacker_jump_begin = data.attacker.challenge_jump_begin;
        data.attacker_jump_end = data.attacker.challenge_jump_end;
        data.attacker_swimming_begin = data.attacker.challenge_swimming_begin;
        data.attacker_swimming_end = data.attacker.challenge_swimming_end;
        data.attacker_slide_begin = data.attacker.challenge_slide_begin;
        data.attacker_slide_end = data.attacker.challenge_slide_end;
        data.var_519c883c = data.attacker.var_da3759c8;
        data.var_80924500 = data.attacker.var_77c2a8fc;
        data.var_f7f92f13 = data.attacker drown::is_player_drowning();
        data.attacker_sprint_begin = data.attacker.challenge_sprint_begin;
        data.attacker_sprint_end = data.attacker.challenge_sprint_end;
        data.var_b041219e = data.attacker.var_37509fac;
        data.var_e13bb0e8 = data.victim.var_25db07c1;
        if (isdefined(attacker.sensor_darts)) {
            arrayremovevalue(attacker.sensor_darts, undefined);
        }
        if (isdefined(attacker.sensor_darts) && attacker.sensor_darts.size > 0) {
            data.var_74dc8fca = [];
            foreach (sensor_dart in attacker.sensor_darts) {
                if (!isdefined(data.var_74dc8fca)) {
                    data.var_74dc8fca = [];
                } else if (!isarray(data.var_74dc8fca)) {
                    data.var_74dc8fca = array(data.var_74dc8fca);
                }
                data.var_74dc8fca[data.var_74dc8fca.size] = sensor_dart;
            }
        } else if (isdefined(attacker.team)) {
            var_672e8552 = getplayers(attacker.team);
            foreach (attacking_player in var_672e8552) {
                if (!isplayer(attacking_player)) {
                    continue;
                }
                if (isdefined(attacking_player.sensor_darts)) {
                    arrayremovevalue(attacking_player.sensor_darts, undefined);
                    if (attacking_player.sensor_darts.size > 0) {
                        data.var_1edcd7b = attacking_player;
                        data.var_cfbdcd9e = [];
                        foreach (sensor_dart in attacking_player.sensor_darts) {
                            if (!isdefined(data.var_cfbdcd9e)) {
                                data.var_cfbdcd9e = [];
                            } else if (!isarray(data.var_cfbdcd9e)) {
                                data.var_cfbdcd9e = array(data.var_cfbdcd9e);
                            }
                            data.var_cfbdcd9e[data.var_cfbdcd9e.size] = sensor_dart;
                        }
                        break;
                    }
                }
            }
        }
        if (isdefined(attacker.var_49ce53d3) && isdefined(attacker.var_49ce53d3[data.victim getentitynumber()])) {
            data.var_c500bb2f = attacker.var_49ce53d3[data.victim getentitynumber()];
        }
    } else {
        data.attackeronground = 0;
        data.var_e4763e35 = 0;
        data.var_3828b415 = 0;
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
    waitandprocessplayerkilledcallback(data);
    data.attacker notify(#"playerkilledchallengesprocessed");
}

// Namespace challenges/challenges_shared
// Params 2, eflags: 0x0
// Checksum 0x53ad7df9, Offset: 0x6728
// Size: 0xda
function doscoreeventcallback(callback, data) {
    if (!isdefined(level.scoreeventcallbacks)) {
        return;
    }
    if (!isdefined(level.scoreeventcallbacks[callback])) {
        return;
    }
    if (isdefined(data)) {
        for (i = 0; i < level.scoreeventcallbacks[callback].size; i++) {
            thread [[ level.scoreeventcallbacks[callback][i] ]](data);
        }
        return;
    }
    for (i = 0; i < level.scoreeventcallbacks[callback].size; i++) {
        thread [[ level.scoreeventcallbacks[callback][i] ]]();
    }
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0xb71835bc, Offset: 0x6810
// Size: 0xec
function waitandprocessplayerkilledcallback(data) {
    if (isdefined(data.attacker)) {
        data.attacker endon(#"disconnect");
    }
    waitframe(1);
    util::waittillslowprocessallowed();
    if (isdefined(data.weapon) && data.weapon != level.weaponnone && isdefined(data.attacker) && isplayer(data.attacker)) {
        level thread dochallengecallback("playerKilled", data);
    }
    level thread doscoreeventcallback("playerKilled", data);
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0xb06ccfd9, Offset: 0x6908
// Size: 0x52
function weaponisknife(weapon) {
    if (weapon == level.weaponbasemelee || weapon == level.weaponbasemeleeheld || weapon == level.weaponballisticknife) {
        return true;
    }
    return false;
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0x92e3e60b, Offset: 0x6968
// Size: 0x4a2
function eventreceived(eventname) {
    self endon(#"disconnect");
    util::waittillslowprocessallowed();
    switch (level.gametype) {
    case #"tdm":
        if (eventname == "killstreak_10") {
            self stats::function_5396eef9(#"killstreak_10", 1);
        } else if (eventname == "killstreak_15") {
            self stats::function_5396eef9(#"killstreak_15", 1);
        } else if (eventname == "killstreak_20") {
            self stats::function_5396eef9(#"killstreak_20", 1);
        } else if (eventname == "multikill_3") {
            self stats::function_5396eef9(#"multikill_3", 1);
        } else if (eventname == "kill_enemy_who_killed_teammate") {
            self stats::function_5396eef9(#"kill_enemy_who_killed_teammate", 1);
        } else if (eventname == "kill_enemy_injuring_teammate") {
            self stats::function_5396eef9(#"kill_enemy_injuring_teammate", 1);
        }
        break;
    case #"dm":
        if (eventname == "killstreak_10") {
            self stats::function_5396eef9(#"killstreak_10", 1);
        } else if (eventname == "killstreak_15") {
            self stats::function_5396eef9(#"killstreak_15", 1);
        } else if (eventname == "killstreak_20") {
            self stats::function_5396eef9(#"killstreak_20", 1);
        } else if (eventname == "killstreak_30") {
            self stats::function_5396eef9(#"killstreak_30", 1);
        }
        break;
    case #"sd":
        if (eventname == "defused_bomb_last_man_alive") {
            self stats::function_5396eef9(#"defused_bomb_last_man_alive", 1);
        } else if (eventname == "elimination_and_last_player_alive") {
            self stats::function_5396eef9(#"elimination_and_last_player_alive", 1);
        } else if (eventname == "killed_bomb_planter") {
            self stats::function_5396eef9(#"killed_bomb_planter", 1);
        } else if (eventname == "killed_bomb_defuser") {
            self stats::function_5396eef9(#"killed_bomb_defuser", 1);
        }
        break;
    case #"ctf":
        if (eventname == "kill_flag_carrier") {
            self stats::function_5396eef9(#"kill_flag_carrier", 1);
        } else if (eventname == "defend_flag_carrier") {
            self stats::function_5396eef9(#"defend_flag_carrier", 1);
        }
        break;
    case #"dem":
        if (eventname == "killed_bomb_planter") {
            self stats::function_5396eef9(#"killed_bomb_planter", 1);
        } else if (eventname == "killed_bomb_defuser") {
            self stats::function_5396eef9(#"killed_bomb_defuser", 1);
        }
        break;
    default:
        break;
    }
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x532cdb38, Offset: 0x6e18
// Size: 0x8a
function monitor_player_sprint() {
    self endon(#"disconnect");
    self endon(#"killplayersprintmonitor");
    self endon(#"death");
    self.lastsprinttime = undefined;
    while (true) {
        self waittill(#"sprint_begin");
        self waittill(#"sprint_end");
        self.lastsprinttime = gettime();
    }
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0xf36f6db6, Offset: 0x6eb0
// Size: 0x1a
function isflashbanged() {
    return status_effect::function_d7236ba9(1);
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x46569531, Offset: 0x6ed8
// Size: 0x1e
function isheatwavestunned() {
    return isdefined(self._heat_wave_stuned_end) && gettime() < self._heat_wave_stuned_end;
}

// Namespace challenges/challenges_shared
// Params 2, eflags: 0x0
// Checksum 0xad669a04, Offset: 0x6f00
// Size: 0xf4
function trophy_defense(origin, radius) {
    if (isdefined(level.challenge_scorestreaksenabled) && level.challenge_scorestreaksenabled == 1) {
        entities = getdamageableentarray(origin, radius);
        foreach (entity in entities) {
            if (isdefined(entity.challenge_isscorestreak)) {
                self stats::function_b48aa4e(#"hash_754270d3259c2cc7", 1);
                break;
            }
        }
    }
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0x1773753e, Offset: 0x7000
// Size: 0x26
function waittilltimeoutordeath(timeout) {
    self endon(#"death");
    wait timeout;
}

