#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/drown;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace challenges;

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x11b0
// Size: 0x4
function init_shared() {
    
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0xf4211061, Offset: 0x11c0
// Size: 0x10
function pickedupballisticknife() {
    self.retreivedblades++;
}

// Namespace challenges/challenges_shared
// Params 3, eflags: 0x0
// Checksum 0xf4f11b87, Offset: 0x11d8
// Size: 0x8e
function trackassists(attacker, damage, isflare) {
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
// Checksum 0x926f8f8b, Offset: 0x1270
// Size: 0x1b4
function destroyedequipment(weapon) {
    if (sessionmodeiszombiesgame()) {
        return;
    }
    if (isdefined(weapon) && weapon.isemp) {
        if (self util::is_item_purchased("emp_grenade")) {
            self addplayerstat("destroy_equipment_with_emp_grenade", 1);
        }
        self addweaponstat(weapon, "combatRecordStat", 1);
        if (self util::has_hacker_perk_purchased_and_equipped()) {
            self addplayerstat("destroy_equipment_with_emp_engineer", 1);
            self addplayerstat("destroy_equipment_engineer", 1);
        }
    } else if (self util::has_hacker_perk_purchased_and_equipped()) {
        self addplayerstat("destroy_equipment_engineer", 1);
    }
    self addplayerstat("destroy_equipment", 1);
    if (isdefined(weapon) && weapon.isbulletweapon && sessionmodeismultiplayergame()) {
        self addplayerstat("destroy_equipment_with_bullet", 1);
    }
    self hackedordestroyedequipment();
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x3fcbe176, Offset: 0x1430
// Size: 0x94
function destroyedtacticalinsert() {
    if (!isdefined(self.pers["tacticalInsertsDestroyed"])) {
        self.pers["tacticalInsertsDestroyed"] = 0;
    }
    self.pers["tacticalInsertsDestroyed"]++;
    if (self.pers["tacticalInsertsDestroyed"] >= 5) {
        self.pers["tacticalInsertsDestroyed"] = 0;
        self addplayerstat("destroy_5_tactical_inserts", 1);
    }
}

// Namespace challenges/challenges_shared
// Params 2, eflags: 0x0
// Checksum 0x91b2ff0, Offset: 0x14d0
// Size: 0x1aa
function addflyswatterstat(weapon, aircraft) {
    if (!isdefined(self.pers["flyswattercount"])) {
        self.pers["flyswattercount"] = 0;
    }
    self addweaponstat(weapon, "destroyed_aircraft", 1);
    self.pers["flyswattercount"]++;
    if (self.pers["flyswattercount"] == 5) {
        self addweaponstat(weapon, "destroyed_5_aircraft", 1);
    }
    if (isdefined(aircraft) && isdefined(aircraft.birthtime)) {
        if (gettime() - aircraft.birthtime < 20000) {
            self addweaponstat(weapon, "destroyed_aircraft_under20s", 1);
        }
    }
    if (!isdefined(self.destroyedaircrafttime)) {
        self.destroyedaircrafttime = [];
    }
    if (isdefined(self.destroyedaircrafttime[weapon]) && gettime() - self.destroyedaircrafttime[weapon] < 10000) {
        self addweaponstat(weapon, "destroyed_2aircraft_quickly", 1);
        self.destroyedaircrafttime[weapon] = undefined;
        return;
    }
    self.destroyedaircrafttime[weapon] = gettime();
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0x475cf93e, Offset: 0x1688
// Size: 0x34
function destroynonairscorestreak_poststatslock(weapon) {
    self addweaponstat(weapon, "destroyed_aircraft", 1);
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x97017450, Offset: 0x16c8
// Size: 0x76
function canprocesschallenges() {
    /#
        if (getdvarint("<dev string:x28>", 0)) {
            return true;
        }
    #/
    if (level.rankedmatch || level.arenamatch || level.wagermatch || sessionmodeiscampaigngame()) {
        return true;
    }
    return false;
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0x9f71bce8, Offset: 0x1748
// Size: 0xd4
function initteamchallenges(team) {
    if (!isdefined(game.challenge)) {
        game.challenge = [];
    }
    if (!isdefined(game.challenge[team])) {
        game.challenge[team] = [];
        game.challenge[team]["plantedBomb"] = 0;
        game.challenge[team]["destroyedBombSite"] = 0;
        game.challenge[team]["capturedFlag"] = 0;
    }
    game.challenge[team]["allAlive"] = 1;
}

// Namespace challenges/challenges_shared
// Params 2, eflags: 0x0
// Checksum 0x11d577a3, Offset: 0x1828
// Size: 0x6c
function registerchallengescallback(callback, func) {
    if (!isdefined(level.challengescallbacks[callback])) {
        level.challengescallbacks[callback] = [];
    }
    level.challengescallbacks[callback][level.challengescallbacks[callback].size] = func;
}

// Namespace challenges/challenges_shared
// Params 2, eflags: 0x0
// Checksum 0xb21c98f0, Offset: 0x18a0
// Size: 0xfa
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
// Checksum 0xb6c86f9a, Offset: 0x19a8
// Size: 0x4c
function on_player_connect() {
    self thread initchallengedata();
    self thread spawnwatcher();
    self thread monitorreloads();
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x4a7c1d6b, Offset: 0x1a00
// Size: 0xe0
function monitorreloads() {
    self endon(#"disconnect");
    self endon(#"killmonitorreloads");
    while (true) {
        self waittill("reload");
        currentweapon = self getcurrentweapon();
        if (currentweapon == level.weaponnone) {
            continue;
        }
        time = gettime();
        self.lastreloadtime = time;
        if (weaponhasattachment(currentweapon, "supply") || weaponhasattachment(currentweapon, "dualclip")) {
            self thread function_81f67537(currentweapon);
        }
    }
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0x8c4489de, Offset: 0x1ae8
// Size: 0xb8
function function_81f67537(reloadweapon) {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"hash_1dc38794");
    self notify(#"hash_33251375");
    self endon(#"hash_33251375");
    self thread function_ed2b9c30(5);
    for (;;) {
        waitresult = self waittill("killed_enemy_player");
        if (reloadweapon == waitresult.weapon) {
            self addplayerstat("reload_then_kill_dualclip", 1);
        }
    }
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0xee4a2541, Offset: 0x1ba8
// Size: 0x42
function function_ed2b9c30(time) {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"hash_33251375");
    wait time;
    self notify(#"hash_1dc38794");
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x99df3a5d, Offset: 0x1bf8
// Size: 0x64
function initchallengedata() {
    self.pers["bulletStreak"] = 0;
    self.pers["lastBulletKillTime"] = 0;
    self.pers["stickExplosiveKill"] = 0;
    self.pers["carepackagesCalled"] = 0;
    self.explosiveinfo = [];
}

// Namespace challenges/challenges_shared
// Params 3, eflags: 0x0
// Checksum 0x3f20288c, Offset: 0x1c68
// Size: 0xe2
function isdamagefromplayercontrolledaitank(eattacker, einflictor, weapon) {
    if (weapon.name == "ai_tank_drone_gun") {
        if (isdefined(eattacker) && isdefined(eattacker.remoteweapon) && isdefined(einflictor)) {
            if (isdefined(einflictor.controlled) && einflictor.controlled) {
                if (eattacker.remoteweapon == einflictor) {
                    return true;
                }
            }
        }
    } else if (weapon.name == "ai_tank_drone_rocket") {
        if (isdefined(einflictor) && !isdefined(einflictor.from_ai)) {
            return true;
        }
    }
    return false;
}

// Namespace challenges/challenges_shared
// Params 3, eflags: 0x0
// Checksum 0xa50aef10, Offset: 0x1d58
// Size: 0xa2
function isdamagefromplayercontrolledsentry(eattacker, einflictor, weapon) {
    if (weapon.name == "auto_gun_turret") {
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
// Checksum 0x222b6d3e, Offset: 0x1e08
// Size: 0x72c
function perkkills(victim, isstunned, time) {
    player = self;
    if (player hasperk("specialty_movefaster")) {
        player addplayerstat("perk_movefaster_kills", 1);
    }
    if (player hasperk("specialty_noname")) {
        player addplayerstat("perk_noname_kills", 1);
    }
    if (player hasperk("specialty_quieter")) {
        player addplayerstat("perk_quieter_kills", 1);
    }
    if (player hasperk("specialty_longersprint")) {
        if (isdefined(player.lastsprinttime) && gettime() - player.lastsprinttime < 2500) {
            player addplayerstat("perk_longersprint", 1);
        }
    }
    if (player hasperk("specialty_fastmantle")) {
        if (isdefined(player.lastsprinttime) && gettime() - player.lastsprinttime < 2500 && player playerads() >= 1) {
            player addplayerstat("perk_fastmantle_kills", 1);
        }
    }
    if (player hasperk("specialty_loudenemies")) {
        player addplayerstat("perk_loudenemies_kills", 1);
    }
    if (isstunned == 1 && player hasperk("specialty_stunprotection")) {
        player addplayerstat("perk_protection_stun_kills", 1);
    }
    activeenemyemp = 0;
    activecuav = 0;
    if (level.teambased) {
        foreach (team in level.teams) {
            assert(isdefined(level.activecounteruavs[team]));
            assert(isdefined(level.activeemps[team]));
            if (team == player.team) {
                continue;
            }
            if (level.activecounteruavs[team] > 0) {
                activecuav = 1;
            }
            if (level.activeemps[team] > 0) {
                activeenemyemp = 1;
            }
        }
    } else {
        assert(isdefined(level.activecounteruavs[victim.entnum]));
        assert(isdefined(level.activeemps[victim.entnum]));
        players = level.players;
        for (i = 0; i < players.size; i++) {
            if (players[i] != player) {
                if (isdefined(level.activecounteruavs[players[i].entnum]) && level.activecounteruavs[players[i].entnum] > 0) {
                    activecuav = 1;
                }
                if (isdefined(level.activeemps[players[i].entnum]) && level.activeemps[players[i].entnum] > 0) {
                    activeenemyemp = 1;
                }
            }
        }
    }
    if (activecuav == 1 || activeenemyemp == 1) {
        if (player hasperk("specialty_immunecounteruav")) {
            player addplayerstat("perk_immune_cuav_kills", 1);
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
        if (player hasperk("specialty_gpsjammer")) {
            player addplayerstat("perk_gpsjammer_immune_kills", 1);
        }
    }
    if (player.lastweaponchange + 5000 > time) {
        if (player hasperk("specialty_fastweaponswitch")) {
            player addplayerstat("perk_fastweaponswitch_kill_after_swap", 1);
        }
    }
    if (player.scavenged == 1) {
        if (player hasperk("specialty_scavenger")) {
            player addplayerstat("perk_scavenger_kills_after_resupply", 1);
        }
    }
}

// Namespace challenges/challenges_shared
// Params 2, eflags: 0x0
// Checksum 0xc962264e, Offset: 0x2540
// Size: 0x88
function flakjacketprotected(weapon, attacker) {
    if (weapon.name == "claymore") {
        self.flakjacketclaymore[attacker.clientid] = 1;
    }
    self addplayerstat("survive_with_flak", 1);
    self.challenge_lastsurvivewithflakfrom = attacker;
    self.challenge_lastsurvivewithflaktime = gettime();
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0xdcd1592f, Offset: 0x25d0
// Size: 0xb0
function earnedkillstreak() {
    if (self util::has_purchased_perk_equipped("specialty_anteup")) {
        self addplayerstat("earn_scorestreak_anteup", 1);
        if (!isdefined(self.var_fcd72b66)) {
            self.var_fcd72b66 = 0;
        }
        self.var_fcd72b66++;
        if (self.var_fcd72b66 >= 5) {
            self addplayerstat("earn_5_scorestreaks_anteup", 1);
            self.var_fcd72b66 = 0;
        }
    }
}

// Namespace challenges/challenges_shared
// Params 3, eflags: 0x0
// Checksum 0x8212b262, Offset: 0x2688
// Size: 0x164
function genericbulletkill(data, victim, weapon) {
    player = self;
    time = data.time;
    if (player.pers["lastBulletKillTime"] == time) {
        player.pers["bulletStreak"]++;
    } else {
        player.pers["bulletStreak"] = 1;
    }
    player.pers["lastBulletKillTime"] = time;
    if (data.victim.idflagstime == time) {
        if (data.victim.idflags & 8) {
            player addplayerstat("kill_enemy_through_wall", 1);
            if (isdefined(weapon) && weaponhasattachment(weapon, "fmj")) {
                player addplayerstat("kill_enemy_through_wall_with_fmj", 1);
            }
        }
    }
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0xc04943b0, Offset: 0x27f8
// Size: 0x192
function ishighestscoringplayer(player) {
    if (!isdefined(player.score) || player.score < 1) {
        return false;
    }
    players = level.players;
    if (level.teambased) {
        team = player.pers["team"];
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
        if (team != "all" && players[i].pers["team"] != team) {
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
// Checksum 0xbbd5dece, Offset: 0x2998
// Size: 0x130
function spawnwatcher() {
    self endon(#"disconnect");
    self endon(#"killspawnmonitor");
    self.pers["stickExplosiveKill"] = 0;
    self.pers["pistolHeadshot"] = 0;
    self.pers["assaultRifleHeadshot"] = 0;
    self.pers["killNemesis"] = 0;
    while (true) {
        self waittill("spawned_player");
        self.pers["longshotsPerLife"] = 0;
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
// Checksum 0x917e2c6a, Offset: 0x2ad0
// Size: 0x60
function watchfordtp() {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"killdtpmonitor");
    self.dtptime = 0;
    while (true) {
        self waittill("dtp_end");
        self.dtptime = gettime() + 4000;
    }
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x6c50cc05, Offset: 0x2b38
// Size: 0x70
function watchformantle() {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"killmantlemonitor");
    self.mantletime = 0;
    while (true) {
        waitresult = self waittill("mantle_start");
        self.mantletime = waitresult.end_time;
    }
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0xd74fafb9, Offset: 0x2bb0
// Size: 0x24
function disarmedhackedcarepackage() {
    self addplayerstat("disarm_hacked_carepackage", 1);
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x55e69d56, Offset: 0x2be0
// Size: 0x4c
function destroyed_car() {
    if (!isdefined(self) || !isplayer(self)) {
        return;
    }
    self addplayerstat("destroy_car", 1);
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0xe19557b3, Offset: 0x2c38
// Size: 0x64
function killednemesis() {
    self.pers["killNemesis"]++;
    if (self.pers["killNemesis"] >= 5) {
        self.pers["killNemesis"] = 0;
        self addplayerstat("kill_nemesis", 1);
    }
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0xc395c6d8, Offset: 0x2ca8
// Size: 0x24
function killwhiledamagingwithhpm() {
    self addplayerstat("kill_while_damaging_with_microwave_turret", 1);
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x8e43010d, Offset: 0x2cd8
// Size: 0x24
function longdistancehatchetkill() {
    self addplayerstat("long_distance_hatchet_kill", 1);
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0xb5136276, Offset: 0x2d08
// Size: 0x24
function blockedsatellite() {
    self addplayerstat("activate_cuav_while_enemy_satelite_active", 1);
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x9389ba1b, Offset: 0x2d38
// Size: 0x64
function longdistancekill() {
    self.pers["longshotsPerLife"]++;
    if (self.pers["longshotsPerLife"] >= 3) {
        self.pers["longshotsPerLife"] = 0;
        self addplayerstat("longshot_3_onelife", 1);
    }
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0x1357ba01, Offset: 0x2da8
// Size: 0x172
function challengeroundend(data) {
    player = data.player;
    winner = data.winner;
    if (endedearly(winner)) {
        return;
    }
    if (level.teambased) {
        winnerscore = game.stat["teamScores"][winner];
        loserscore = getlosersteamscores(winner);
    }
    switch (level.gametype) {
    case #"sd":
        if (player.team == winner) {
            if (game.challenge[winner]["allAlive"]) {
                player addgametypestat("round_win_no_deaths", 1);
            }
            if (isdefined(player.lastmansddefeat3enemies)) {
                player addgametypestat("last_man_defeat_3_enemies", 1);
            }
        }
        break;
    default:
        break;
    }
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0xb2c14fb3, Offset: 0x2f28
// Size: 0x146
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
    for (index = 0; index < level.placement["all"].size; index++) {
        data.player = level.placement["all"][index];
        if (isdefined(data.player)) {
            data.place = index;
            dochallengecallback("roundEnd", data);
        }
    }
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0x17030c78, Offset: 0x3078
// Size: 0x15e
function gameend(winner) {
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
    for (index = 0; index < level.placement["all"].size; index++) {
        data.player = level.placement["all"][index];
        data.place = index;
        if (isdefined(data.player)) {
            dochallengecallback("gameEnd", data);
        }
    }
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0x59ef5718, Offset: 0x31e0
// Size: 0x44
function getfinalkill(player) {
    if (isplayer(player)) {
        player addplayerstat("get_final_kill", 1);
    }
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0x9e3a7d11, Offset: 0x3230
// Size: 0x94
function destroyrcbomb(weapon) {
    if (!isplayer(self)) {
        return;
    }
    self destroyscorestreak(weapon, 1, 1);
    if (weapon.rootweapon.name == "hatchet") {
        self addplayerstat("destroy_hcxd_with_hatchet", 1);
    }
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0xba5d748d, Offset: 0x32d0
// Size: 0xd4
function capturedcrate(owner) {
    if (isdefined(self.lastrescuedby) && isdefined(self.lastrescuedtime)) {
        if (self.lastrescuedtime + 5000 > gettime()) {
            self.lastrescuedby addplayerstat("defend_teammate_who_captured_package", 1);
        }
    }
    if (level.teambased && owner.team != self.team || owner != self && !level.teambased) {
        self addplayerstat("capture_enemy_carepackage", 1);
    }
}

// Namespace challenges/challenges_shared
// Params 4, eflags: 0x0
// Checksum 0xde40b252, Offset: 0x33b0
// Size: 0x3cc
function destroyscorestreak(weapon, playercontrolled, groundbased, countaskillstreakvehicle) {
    if (!isdefined(countaskillstreakvehicle)) {
        countaskillstreakvehicle = 1;
    }
    if (!isplayer(self)) {
        return;
    }
    if (isdefined(level.killstreakweapons[weapon])) {
        if (level.killstreakweapons[weapon] == "dart") {
            self addplayerstat("destroy_scorestreak_with_dart", 1);
        }
    } else if (weapon.isheavyweapon) {
        self addplayerstat("destroy_scorestreak_with_specialist", 1);
    } else if (weaponhasattachment(weapon, "fmj", "rf")) {
        self addplayerstat("destroy_scorestreak_rapidfire_fmj", 1);
    }
    if (!isdefined(playercontrolled) || playercontrolled == 0) {
        if (self util::has_cold_blooded_perk_purchased_and_equipped()) {
            if (groundbased) {
                self addplayerstat("destroy_ai_scorestreak_coldblooded", 1);
            }
            if (self util::has_blind_eye_perk_purchased_and_equipped()) {
                if (groundbased) {
                    self.pers["challenge_destroyed_ground"]++;
                } else {
                    self.pers["challenge_destroyed_air"]++;
                }
                if (self.pers["challenge_destroyed_ground"] > 0 && self.pers["challenge_destroyed_air"] > 0) {
                    self addplayerstat("destroy_air_and_ground_blindeye_coldblooded", 1);
                    self.pers["challenge_destroyed_air"] = 0;
                    self.pers["challenge_destroyed_ground"] = 0;
                }
            }
        }
    }
    if (!isdefined(self.pers["challenge_destroyed_killstreak"])) {
        self.pers["challenge_destroyed_killstreak"] = 0;
    }
    self.pers["challenge_destroyed_killstreak"]++;
    if (self.pers["challenge_destroyed_killstreak"] >= 5) {
        self.pers["challenge_destroyed_killstreak"] = 0;
        self addweaponstat(weapon, "destroy_5_killstreak", 1);
        self addweaponstat(weapon, "destroy_5_killstreak_vehicle", 1);
    }
    self addweaponstat(weapon, "destroy_killstreak", 1);
    weaponpickedup = 0;
    if (isdefined(self.pickedupweapons) && isdefined(self.pickedupweapons[weapon])) {
        weaponpickedup = 1;
    }
    self addweaponstat(weapon, "destroyed", 1, self.class_num, weaponpickedup, undefined, self.primaryloadoutgunsmithvariantindex, self.secondaryloadoutgunsmithvariantindex);
    self thread watchforrapiddestroy(weapon);
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0xcb3c200a, Offset: 0x3788
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
        self addweaponstat(weapon, "destroy_2_killstreaks_rapidly", 1);
    }
}

// Namespace challenges/challenges_shared
// Params 2, eflags: 0x0
// Checksum 0x14e26651, Offset: 0x3850
// Size: 0x27a
function capturedobjective(capturetime, objective) {
    if (isdefined(self.smokegrenadetime) && isdefined(self.smokegrenadeposition)) {
        if (self.smokegrenadetime + 14000 > capturetime) {
            distsq = distancesquared(self.smokegrenadeposition, self.origin);
            if (distsq < 57600) {
                if (self util::is_item_purchased("willy_pete")) {
                    self addplayerstat("capture_objective_in_smoke", 1);
                }
                self addweaponstat(getweapon("willy_pete"), "CombatRecordStat", 1);
                return;
            }
        }
    }
    if (isdefined(level.capturedobjectivefunction)) {
        self [[ level.capturedobjectivefunction ]]();
    }
    heroabilitywasactiverecently = isdefined(self.heroabilitydectivatetime) && (isdefined(self.heroabilityactive) || self.heroabilitydectivatetime > gettime() - 3000);
    if (heroabilitywasactiverecently && isdefined(self.heroability) && self.heroability.name == "gadget_camo") {
        scoreevents::processscoreevent("optic_camo_capture_objective", self);
    }
    if (isdefined(objective)) {
        if (self.challenge_objectivedefensive === objective) {
            if ((isdefined(self.recentkillcount) ? self.recentkillcount : 0) > 2 || (isdefined(self.challenge_objectivedefensivekillcount) ? self.challenge_objectivedefensivekillcount : 0) > 0 && self.challenge_objectivedefensivetriplekillmedalorbetterearned === 1) {
                self addplayerstat("triple_kill_defenders_and_capture", 1);
            }
            self.challenge_objectivedefensivekillcount = 0;
            self.challenge_objectivedefensive = undefined;
            self.challenge_objectivedefensivetriplekillmedalorbetterearned = undefined;
        }
    }
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x5a15796b, Offset: 0x3ad8
// Size: 0x3c
function hackedordestroyedequipment() {
    if (self util::has_hacker_perk_purchased_and_equipped()) {
        self addplayerstat("perk_hacker_destroy", 1);
    }
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x596ca729, Offset: 0x3b20
// Size: 0x94
function bladekill() {
    if (!isdefined(self.pers["bladeKills"])) {
        self.pers["bladeKills"] = 0;
    }
    self.pers["bladeKills"]++;
    if (self.pers["bladeKills"] >= 15) {
        self.pers["bladeKills"] = 0;
        self addplayerstat("kill_15_with_blade", 1);
    }
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0x4dcaf96b, Offset: 0x3bc0
// Size: 0x44
function destroyedexplosive(weapon) {
    self destroyedequipment(weapon);
    self addplayerstat("destroy_explosive", 1);
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x99736bd2, Offset: 0x3c10
// Size: 0x24
function assisted() {
    self addplayerstat("assist", 1);
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0x70d84b3c, Offset: 0x3c40
// Size: 0xbc
function earnedmicrowaveassistscore(score) {
    self addplayerstat("assist_score_microwave_turret", score);
    self addplayerstat("assist_score_killstreak", score);
    self addweaponstat(getweapon("microwave_turret_deploy"), "assists", 1);
    self addweaponstat(getweapon("microwave_turret_deploy"), "assist_score", score);
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0x670f90a4, Offset: 0x3d08
// Size: 0xbc
function earnedcuavassistscore(score) {
    self addplayerstat("assist_score_cuav", score);
    self addplayerstat("assist_score_killstreak", score);
    self addweaponstat(getweapon("counteruav"), "assists", 1);
    self addweaponstat(getweapon("counteruav"), "assist_score", score);
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0x3ab66cf8, Offset: 0x3dd0
// Size: 0xbc
function earneduavassistscore(score) {
    self addplayerstat("assist_score_uav", score);
    self addplayerstat("assist_score_killstreak", score);
    self addweaponstat(getweapon("uav"), "assists", 1);
    self addweaponstat(getweapon("uav"), "assist_score", score);
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0xfde239e9, Offset: 0x3e98
// Size: 0xbc
function earnedsatelliteassistscore(score) {
    self addplayerstat("assist_score_satellite", score);
    self addplayerstat("assist_score_killstreak", score);
    self addweaponstat(getweapon("satellite"), "assists", 1);
    self addweaponstat(getweapon("satellite"), "assist_score", score);
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0x666d7e20, Offset: 0x3f60
// Size: 0xbc
function earnedempassistscore(score) {
    self addplayerstat("assist_score_emp", score);
    self addplayerstat("assist_score_killstreak", score);
    self addweaponstat(getweapon("emp_turret"), "assists", 1);
    self addweaponstat(getweapon("emp_turret"), "assist_score", score);
}

// Namespace challenges/challenges_shared
// Params 2, eflags: 0x0
// Checksum 0xda181216, Offset: 0x4028
// Size: 0xb6
function teamcompletedchallenge(team, challenge) {
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (isdefined(players[i].team) && players[i].team == team) {
            players[i] addgametypestat(challenge, 1);
        }
    }
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0xff0af246, Offset: 0x40e8
// Size: 0x58
function endedearly(winner) {
    if (level.hostforcedend) {
        return true;
    }
    if (!isdefined(winner)) {
        return true;
    }
    if (level.teambased) {
        if (winner == "tie") {
            return true;
        }
    }
    return false;
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0x32d98e1a, Offset: 0x4148
// Size: 0xcc
function getlosersteamscores(winner) {
    teamscores = 0;
    foreach (team in level.teams) {
        if (team == winner) {
            continue;
        }
        teamscores += game.stat["teamScores"][team];
    }
    return teamscores;
}

// Namespace challenges/challenges_shared
// Params 2, eflags: 0x0
// Checksum 0x5291682, Offset: 0x4220
// Size: 0xbc
function didloserfailchallenge(winner, challenge) {
    foreach (team in level.teams) {
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
// Checksum 0x7d0224f2, Offset: 0x42e8
// Size: 0x58e
function challengegameend(data) {
    player = data.player;
    winner = data.winner;
    if (endedearly(winner)) {
        return;
    }
    if (level.teambased) {
        winnerscore = game.stat["teamScores"][winner];
        loserscore = getlosersteamscores(winner);
    }
    switch (level.gametype) {
    case #"tdm":
        if (player.team == winner) {
            if (winnerscore >= loserscore + 20) {
                player addgametypestat("CRUSH", 1);
            }
        }
        var_d2d122ff = 1;
        for (index = 0; index < level.placement["all"].size; index++) {
            if (level.placement["all"][index].deaths < player.deaths) {
                var_d2d122ff = 0;
            }
            if (level.placement["all"][index].kills > player.kills) {
                var_d2d122ff = 0;
            }
        }
        if (var_d2d122ff && player.kills > 0 && level.placement["all"].size > 3) {
            player addgametypestat("most_kills_least_deaths", 1);
        }
        break;
    case #"dm":
        if (player == winner) {
            if (level.placement["all"].size >= 2) {
                secondplace = level.placement["all"][1];
                if (player.kills >= secondplace.kills + 7) {
                    player addgametypestat("CRUSH", 1);
                }
            }
        }
        break;
    case #"ctf":
        if (player.team == winner) {
            if (loserscore == 0) {
                player addgametypestat("SHUT_OUT", 1);
            }
        }
        break;
    case #"dom":
        if (player.team == winner) {
            if (winnerscore >= loserscore + 70) {
                player addgametypestat("CRUSH", 1);
            }
        }
        break;
    case #"hq":
        if (player.team == winner && winnerscore > 0) {
            if (winnerscore >= loserscore + 70) {
                player addgametypestat("CRUSH", 1);
            }
        }
        break;
    case #"koth":
        if (player.team == winner && winnerscore > 0) {
            if (winnerscore >= loserscore + 70) {
                player addgametypestat("CRUSH", 1);
            }
        }
        if (player.team == winner && winnerscore > 0) {
            if (winnerscore >= loserscore + 110) {
                player addgametypestat("ANNIHILATION", 1);
            }
        }
        break;
    case #"dem":
        if (player.team == game.defenders && player.team == winner) {
            if (loserscore == 0) {
                player addgametypestat("SHUT_OUT", 1);
            }
        }
        break;
    case #"sd":
        if (player.team == winner) {
            if (loserscore <= 1) {
                player addgametypestat("CRUSH", 1);
            }
        }
    default:
        break;
    }
}

// Namespace challenges/challenges_shared
// Params 2, eflags: 0x0
// Checksum 0x2e252bbd, Offset: 0x4880
// Size: 0x1bc
function multikill(killcount, weapon) {
    if (!sessionmodeismultiplayergame()) {
        return;
    }
    if (killcount >= 3 && isdefined(self.lastkillwheninjured)) {
        if (self.lastkillwheninjured + 5000 > gettime()) {
            self addplayerstat("multikill_3_near_death", 1);
        }
    }
    self addweaponstat(weapon, "doublekill", int(killcount / 2));
    self addweaponstat(weapon, "triplekill", int(killcount / 3));
    if (weapon.isheavyweapon) {
        doublekill = int(killcount / 2);
        if (doublekill) {
            self addplayerstat("MULTIKILL_2_WITH_HEROWEAPON", doublekill);
        }
        triplekill = int(killcount / 3);
        if (triplekill) {
            self addplayerstat("MULTIKILL_3_WITH_HEROWEAPON", triplekill);
        }
    }
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0x24b96099, Offset: 0x4a48
// Size: 0x2c
function domattackermultikill(killcount) {
    self addgametypestat("kill_2_enemies_capturing_your_objective", 1);
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0xd14a9a8d, Offset: 0x4a80
// Size: 0x2c
function totaldomination(team) {
    teamcompletedchallenge(team, "control_3_points_3_minutes");
}

// Namespace challenges/challenges_shared
// Params 2, eflags: 0x0
// Checksum 0xea0302ed, Offset: 0x4ab8
// Size: 0x9c
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
// Checksum 0x49a89d83, Offset: 0x4b60
// Size: 0x24
function capturedbfirstminute() {
    self addgametypestat("capture_b_first_minute", 1);
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0xe4d5917d, Offset: 0x4b90
// Size: 0x2c
function controlzoneentirely(team) {
    teamcompletedchallenge(team, "control_zone_entirely");
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x6fdbd0, Offset: 0x4bc8
// Size: 0x24
function multi_lmg_smg_kill() {
    self addplayerstat("multikill_3_lmg_or_smg_hip_fire", 1);
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0x16dd37fc, Offset: 0x4bf8
// Size: 0x74
function killedzoneattacker(weapon) {
    if (weapon.name == "planemortar" || weapon.name == "remote_missile_missile" || weapon.name == "remote_missile_bomblet") {
        self thread updatezonemultikills();
    }
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x238a0561, Offset: 0x4c78
// Size: 0x13e
function killeddog() {
    origin = self.origin;
    if (level.teambased) {
        teammates = util::function_c664826a(self.team);
        foreach (player in teammates.a) {
            if (player == self) {
                continue;
            }
            distsq = distancesquared(origin, player.origin);
            if (distsq < 57600) {
                self addplayerstat("killed_dog_close_to_teammate", 1);
                break;
            }
        }
    }
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x95459ebc, Offset: 0x4dc0
// Size: 0xa8
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
        self addplayerstat("multikill_2_zone_attackers", 1);
    }
    self.recentzonekillcount = 0;
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x10e325a2, Offset: 0x4e70
// Size: 0x24
function multi_rcbomb_kill() {
    self addplayerstat("multikill_2_with_rcbomb", 1);
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x7b5619a6, Offset: 0x4ea0
// Size: 0x24
function multi_remotemissile_kill() {
    self addplayerstat("multikill_3_remote_missile", 1);
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x73e0b7e9, Offset: 0x4ed0
// Size: 0x24
function multi_mgl_kill() {
    self addplayerstat("multikill_3_with_mgl", 1);
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0xff0b7d5b, Offset: 0x4f00
// Size: 0x24
function immediatecapture() {
    self addgametypestat("immediate_capture", 1);
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x2a031f33, Offset: 0x4f30
// Size: 0x24
function killedlastcontester() {
    self addgametypestat("contest_then_capture", 1);
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0xb2655f24, Offset: 0x4f60
// Size: 0x24
function bothbombsdetonatewithintime() {
    self addgametypestat("both_bombs_detonate_10_seconds", 1);
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x60816449, Offset: 0x4f90
// Size: 0x6a
function calledincarepackage() {
    self.pers["carepackagesCalled"]++;
    if (self.pers["carepackagesCalled"] >= 3) {
        self addplayerstat("call_in_3_care_packages", 1);
        self.pers["carepackagesCalled"] = 0;
    }
}

// Namespace challenges/challenges_shared
// Params 4, eflags: 0x0
// Checksum 0xecae6db0, Offset: 0x5008
// Size: 0xa4
function destroyedhelicopter(attacker, weapon, damagetype, playercontrolled) {
    if (!isplayer(attacker)) {
        return;
    }
    attacker destroyscorestreak(weapon, playercontrolled, 0);
    if (damagetype == "MOD_RIFLE_BULLET" || damagetype == "MOD_PISTOL_BULLET") {
        attacker addplayerstat("destroyed_helicopter_with_bullet", 1);
    }
}

// Namespace challenges/challenges_shared
// Params 2, eflags: 0x0
// Checksum 0x1361559f, Offset: 0x50b8
// Size: 0xac
function destroyedqrdrone(damagetype, weapon) {
    self destroyscorestreak(weapon, 1, 0);
    self addplayerstat("destroy_qrdrone", 1);
    if (damagetype == "MOD_RIFLE_BULLET" || damagetype == "MOD_PISTOL_BULLET") {
        self addplayerstat("destroyed_qrdrone_with_bullet", 1);
    }
    self destroyedplayercontrolledaircraft();
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x1993f44c, Offset: 0x5170
// Size: 0x44
function destroyedplayercontrolledaircraft() {
    if (self hasperk("specialty_noname")) {
        self addplayerstat("destroy_helicopter", 1);
    }
}

// Namespace challenges/challenges_shared
// Params 3, eflags: 0x0
// Checksum 0x91e7cdcf, Offset: 0x51c0
// Size: 0x1fc
function destroyedaircraft(attacker, weapon, playercontrolled) {
    if (!isplayer(attacker)) {
        return;
    }
    attacker destroyscorestreak(weapon, playercontrolled, 0);
    if (isdefined(weapon)) {
        if (weapon.name == "emp" && attacker util::is_item_purchased("killstreak_emp")) {
            attacker addplayerstat("destroy_aircraft_with_emp", 1);
        } else if (weapon.name == "missile_drone_projectile" || weapon.name == "missile_drone") {
            attacker addplayerstat("destroy_aircraft_with_missile_drone", 1);
        } else if (weapon.isbulletweapon) {
            attacker addplayerstat("shoot_aircraft", 1);
        }
    }
    if (attacker util::has_blind_eye_perk_purchased_and_equipped()) {
        attacker addplayerstat("perk_nottargetedbyairsupport_destroy_aircraft", 1);
    }
    attacker addplayerstat("destroy_aircraft", 1);
    if (isdefined(playercontrolled) && playercontrolled == 0) {
        if (attacker util::has_blind_eye_perk_purchased_and_equipped()) {
            attacker addplayerstat("destroy_ai_aircraft_using_blindeye", 1);
        }
    }
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x86229e8d, Offset: 0x53c8
// Size: 0x1b4
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
    self addplayerstat("killstreak_10_no_weapons_perks", 1);
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0xaa78b96b, Offset: 0x5588
// Size: 0x78
function scavengedgrenade() {
    self endon(#"disconnect");
    self endon(#"death");
    self notify(#"scavengedgrenade");
    self endon(#"scavengedgrenade");
    self notify(#"scavenged_primary_grenade");
    for (;;) {
        self waittill("lethalGrenadeKill");
        self addplayerstat("kill_with_resupplied_lethal_grenade", 1);
    }
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0x2eef676, Offset: 0x5608
// Size: 0x2c
function stunnedtankwithempgrenade(attacker) {
    attacker addplayerstat("stun_aitank_wIth_emp_grenade", 1);
}

// Namespace challenges/challenges_shared
// Params 8, eflags: 0x0
// Checksum 0x26d50e2d, Offset: 0x5640
// Size: 0x16ac
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
    if (isdefined(einflictor) && isdefined(einflictor.lastweaponbeforetoss)) {
        data.lastweaponbeforetoss = einflictor.lastweaponbeforetoss;
    }
    if (isdefined(einflictor) && isdefined(einflictor.ownerweaponatlaunch)) {
        data.ownerweaponatlaunch = einflictor.ownerweaponatlaunch;
    }
    waslockingon = 0;
    washacked = 0;
    if (isdefined(einflictor)) {
        if (isdefined(einflictor.locking_on)) {
            waslockingon |= einflictor.locking_on;
        }
        if (isdefined(einflictor.locked_on)) {
            waslockingon |= einflictor.locked_on;
        }
        washacked = einflictor util::ishacked();
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
    data.victimweapon = data.victim.currentweapon;
    data.victimonground = data.victim isonground();
    data.victimwaswallrunning = data.victim iswallrunning();
    data.victimlaststunnedby = data.victim.laststunnedby;
    data.victimwasdoublejumping = data.victim isdoublejumping();
    data.victimcombatefficiencylastontime = data.victim.combatefficiencylastontime;
    data.victimspeedburstlastontime = data.victim.speedburstlastontime;
    data.victimcombatefficieny = data.victim ability_util::gadget_is_active(15);
    data.victimflashbacktime = data.victim.flashbacktime;
    data.victimheroabilityactive = ability_player::gadget_checkheroabilitykill(data.victim);
    data.victimelectrifiedby = data.victim.electrifiedby;
    data.victimheroability = data.victim.heroability;
    data.victimwasinslamstate = data.victim isslamming();
    data.victimwaslungingwitharmblades = data.victim isgadgetmeleecharging();
    data.victimwasheatwavestunned = data.victim isheatwavestunned();
    data.victimpowerarmorlasttookdamagetime = data.victim.power_armor_last_took_damage_time;
    data.victimheavyweaponkillsthisactivation = data.victim.heavyweaponkillsthisactivation;
    data.victimgadgetpower = data.victim gadgetpowerget(0);
    data.victimgadgetwasactivelastdamage = data.victim.gadget_was_active_last_damage;
    data.victimisthieforroulette = data.victim.isthief === 1 || data.victim.isroulette === 1;
    data.victimheroabilityname = data.victim.heroabilityname;
    if (!isdefined(data.victimflashbacktime)) {
        data.victimflashbacktime = 0;
    }
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
        data.attackerwallrunning = data.attacker iswallrunning();
        data.attackerdoublejumping = data.attacker isdoublejumping();
        data.attackertraversing = data.attacker istraversing();
        data.attackersliding = data.attacker issliding();
        data.attackerspeedburst = data.attacker ability_util::gadget_is_active(13);
        data.attackerflashbacktime = data.attacker.flashbacktime;
        data.attackerheroabilityactive = ability_player::gadget_checkheroabilitykill(data.attacker);
        data.attackerheroability = data.attacker.heroability;
        if (!isdefined(data.attackerflashbacktime)) {
            data.attackerflashbacktime = 0;
        }
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
    } else {
        data.attackeronground = 0;
        data.attackerwallrunning = 0;
        data.attackerdoublejumping = 0;
        data.attackertraversing = 0;
        data.attackersliding = 0;
        data.attackerspeedburst = 0;
        data.attackerflashbacktime = 0;
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
// Checksum 0x80a1fd08, Offset: 0x6cf8
// Size: 0xfa
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
// Checksum 0xdcb6dbad, Offset: 0x6e00
// Size: 0x8c
function waitandprocessplayerkilledcallback(data) {
    if (isdefined(data.attacker)) {
        data.attacker endon(#"disconnect");
    }
    waitframe(1);
    util::waittillslowprocessallowed();
    level thread dochallengecallback("playerKilled", data);
    level thread doscoreeventcallback("playerKilled", data);
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0x764b3f7a, Offset: 0x6e98
// Size: 0x50
function weaponisknife(weapon) {
    if (weapon == level.weaponbasemelee || weapon == level.weaponbasemeleeheld || weapon == level.weaponballisticknife) {
        return true;
    }
    return false;
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0x8461e000, Offset: 0x6ef0
// Size: 0x46a
function eventreceived(eventname) {
    self endon(#"disconnect");
    util::waittillslowprocessallowed();
    switch (level.gametype) {
    case #"tdm":
        if (eventname == "killstreak_10") {
            self addgametypestat("killstreak_10", 1);
        } else if (eventname == "killstreak_15") {
            self addgametypestat("killstreak_15", 1);
        } else if (eventname == "killstreak_20") {
            self addgametypestat("killstreak_20", 1);
        } else if (eventname == "multikill_3") {
            self addgametypestat("multikill_3", 1);
        } else if (eventname == "kill_enemy_who_killed_teammate") {
            self addgametypestat("kill_enemy_who_killed_teammate", 1);
        } else if (eventname == "kill_enemy_injuring_teammate") {
            self addgametypestat("kill_enemy_injuring_teammate", 1);
        }
        break;
    case #"dm":
        if (eventname == "killstreak_10") {
            self addgametypestat("killstreak_10", 1);
        } else if (eventname == "killstreak_15") {
            self addgametypestat("killstreak_15", 1);
        } else if (eventname == "killstreak_20") {
            self addgametypestat("killstreak_20", 1);
        } else if (eventname == "killstreak_30") {
            self addgametypestat("killstreak_30", 1);
        }
        break;
    case #"sd":
        if (eventname == "defused_bomb_last_man_alive") {
            self addgametypestat("defused_bomb_last_man_alive", 1);
        } else if (eventname == "elimination_and_last_player_alive") {
            self addgametypestat("elimination_and_last_player_alive", 1);
        } else if (eventname == "killed_bomb_planter") {
            self addgametypestat("killed_bomb_planter", 1);
        } else if (eventname == "killed_bomb_defuser") {
            self addgametypestat("killed_bomb_defuser", 1);
        }
        break;
    case #"ctf":
        if (eventname == "kill_flag_carrier") {
            self addgametypestat("kill_flag_carrier", 1);
        } else if (eventname == "defend_flag_carrier") {
            self addgametypestat("defend_flag_carrier", 1);
        }
        break;
    case #"dem":
        if (eventname == "killed_bomb_planter") {
            self addgametypestat("killed_bomb_planter", 1);
        } else if (eventname == "killed_bomb_defuser") {
            self addgametypestat("killed_bomb_defuser", 1);
        }
        break;
    default:
        break;
    }
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0xe2c26b67, Offset: 0x7368
// Size: 0x6c
function monitor_player_sprint() {
    self endon(#"disconnect");
    self endon(#"killplayersprintmonitor");
    self endon(#"death");
    self.lastsprinttime = undefined;
    while (true) {
        self waittill("sprint_begin");
        self waittill("sprint_end");
        self.lastsprinttime = gettime();
    }
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0xfa24d55a, Offset: 0x73e0
// Size: 0x20
function isflashbanged() {
    return isdefined(self.flashendtime) && gettime() < self.flashendtime;
}

// Namespace challenges/challenges_shared
// Params 0, eflags: 0x0
// Checksum 0x6b5099ea, Offset: 0x7408
// Size: 0x20
function isheatwavestunned() {
    return isdefined(self._heat_wave_stuned_end) && gettime() < self._heat_wave_stuned_end;
}

// Namespace challenges/challenges_shared
// Params 2, eflags: 0x0
// Checksum 0x90846f35, Offset: 0x7430
// Size: 0x106
function trophy_defense(origin, radius) {
    if (isdefined(level.challenge_scorestreaksenabled) && level.challenge_scorestreaksenabled == 1) {
        entities = getdamageableentarray(origin, radius);
        foreach (entity in entities) {
            if (isdefined(entity.challenge_isscorestreak)) {
                self addplayerstat("protect_streak_with_trophy", 1);
                break;
            }
        }
    }
}

// Namespace challenges/challenges_shared
// Params 1, eflags: 0x0
// Checksum 0x50fe810, Offset: 0x7540
// Size: 0x1e
function waittilltimeoutordeath(timeout) {
    self endon(#"death");
    wait timeout;
}

