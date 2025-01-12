#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\persistence_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\rank_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\spawning_shared;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_audio;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_spawn;
#using scripts\mp_common\gametypes\match;
#using scripts\mp_common\gametypes\round;
#using scripts\mp_common\player\player_loadout;
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\util;
#using scripts\weapons\weapon_utils;

#namespace gun;

// Namespace gun/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x95035fce, Offset: 0x1f8
// Size: 0xadc
function event_handler[gametype_init] main(eventstruct) {
    globallogic::init();
    level.onstartgametype = &onstartgametype;
    level.onspawnplayer = &onspawnplayer;
    player::function_b0320e78(&onplayerkilled);
    level.onendgame = &onendgame;
    level.var_c9d3723c = &function_4fdb87a6;
    level.var_3c16bcb = &function_13637a21;
    globallogic_audio::set_leader_gametype_dialog("startGunGame", "hcSstartGunGame", "", "");
    level.givecustomloadout = &givecustomloadout;
    level.setbacksperdemotion = getgametypesetting(#"setbacks");
    level.inactivitykick = 60;
    globallogic_spawn::addsupportedspawnpointtype("gg");
    level.gunprogression = [];
    gunlist = getgametypesetting(#"gunselection");
    if (gunlist == 3) {
        gunlist = randomintrange(0, 3);
    }
    switch (gunlist) {
    case 0:
        addguntoprogression(#"pistol_standard_t8");
        addguntoprogression(#"pistol_revolver_t8");
        addguntoprogression(#"shotgun_pump_t8");
        addguntoprogression(#"shotgun_semiauto_t8");
        addguntoprogression(#"smg_standard_t8");
        addguntoprogression(#"smg_fastfire_t8");
        addguntoprogression(#"smg_accurate_t8");
        addguntoprogression(#"ar_fastfire_t8");
        addguntoprogression(#"ar_modular_t8");
        addguntoprogression(#"ar_stealth_t8");
        addguntoprogression(#"ar_damage_t8");
        addguntoprogression(#"tr_powersemi_t8");
        addguntoprogression(#"tr_longburst_t8");
        addguntoprogression(#"lmg_standard_t8");
        addguntoprogression(#"sniper_quickscope_t8");
        addguntoprogression(#"sniper_powerbolt_t8");
        addguntoprogression(#"launcher_standard_t8");
        addguntoprogression(#"hash_288ff6586a8b59c1");
        break;
    case 1:
        addguntoprogression(#"pistol_standard", "reddot");
        addguntoprogression(#"hash_1f11c32b202a899f", "reflex");
        addguntoprogression(#"hash_2fcd0efc53043f92");
        addguntoprogression(#"hash_42bffbf6dd56bbe1");
        addguntoprogression(#"hash_1f11c32b202a899f");
        addguntoprogression(#"shotgun_semiauto", "steadyaim");
        addguntoprogression(#"shotgun_fullauto", "suppressed");
        addguntoprogression(#"shotgun_pump", "quickdraw");
        addguntoprogression(#"shotgun_precision", "reddot");
        addguntoprogression(#"smg_fastfire", "holo");
        addguntoprogression(#"smg_standard", "quickdraw");
        addguntoprogression(#"smg_versatile", "suppressed");
        addguntoprogression(#"smg_capacity", "stalker");
        addguntoprogression(#"hash_22f0702e5c029d6a", "rf");
        addguntoprogression(#"smg_burst", "reddot");
        addguntoprogression(#"lmg_cqb", "quickdraw");
        addguntoprogression(#"launcher_standard");
        addguntoprogression(#"sniper_powerbolt", "reddot");
        addguntoprogression(#"knife_loadout");
        addguntoprogression(#"bare_hands");
        break;
    case 2:
        addguntoprogression(#"smg_capacity", "holo", "quickdraw");
        addguntoprogression(#"hash_22f0702e5c029d6a", "acog", "extclip");
        addguntoprogression(#"smg_burst", "acog", "extbarrel");
        addguntoprogression(#"ar_cqb", "acog");
        addguntoprogression(#"ar_standard", "reflex");
        addguntoprogression(#"ar_longburst", "extbarrel");
        addguntoprogression(#"hash_3c4884d898bf8ed", "holo");
        addguntoprogression(#"ar_marksman", "acog");
        addguntoprogression(#"ar_damage", "reddot");
        addguntoprogression(#"ar_accurate", "ir", "extbarrel");
        addguntoprogression(#"lmg_light", "ir");
        addguntoprogression(#"lmg_cqb", "reflex");
        addguntoprogression(#"lmg_heavy", "acog");
        addguntoprogression(#"lmg_slowfire", "ir", "extclip");
        addguntoprogression(#"sniper_fastsemi", "swayreduc", "stalker");
        addguntoprogression(#"sniper_fastbolt", "ir", "rf");
        addguntoprogression(#"sniper_powerbolt", "swayreduc");
        addguntoprogression(#"launcher_standard");
        addguntoprogression(#"knife_loadout");
        addguntoprogression(#"bare_hands");
        break;
    }
    util::registertimelimit(0, 1440);
    util::registerroundlimit(0, 10);
    util::registerroundwinlimit(0, 10);
    util::registernumlives(0, 100);
}

// Namespace gun/gun
// Params 0, eflags: 0x0
// Checksum 0xb41517e0, Offset: 0xce0
// Size: 0xdc
function function_4fdb87a6() {
    foreach (team, _ in level.teams) {
        spawning::add_spawn_points(team, "mp_dm_spawn");
        spawning::place_spawn_points("mp_dm_spawn_start");
    }
    level.spawn_start = spawning::get_spawnpoint_array("mp_dm_spawn_start");
    spawning::updateallspawnpoints();
}

// Namespace gun/gun
// Params 0, eflags: 0x0
// Checksum 0x9af75296, Offset: 0xdc8
// Size: 0x8c
function onstartgametype() {
    level.gungamekillscore = rank::getscoreinfovalue("kill_gun");
    util::registerscorelimit(level.gunprogression.size * level.gungamekillscore, level.gunprogression.size * level.gungamekillscore);
    level.displayroundendtext = 0;
    globallogic_spawn::addspawns();
}

// Namespace gun/gun
// Params 0, eflags: 0x0
// Checksum 0x510eb987, Offset: 0xe60
// Size: 0x194
function inactivitykick() {
    self endon(#"disconnect");
    self endon(#"death");
    if (sessionmodeisprivate()) {
        return;
    }
    if (level.inactivitykick == 0) {
        return;
    }
    while (level.inactivitykick > self.timeplayed[#"total"]) {
        wait 1;
    }
    if (self.pers[#"participation"] == 0 && self.pers[#"time_played_moving"] < 1) {
        globallogic::gamehistoryplayerkicked();
        kick(self getentitynumber(), "GAME/DROPPEDFORINACTIVITY");
    }
    if (self.pers[#"participation"] == 0 && self.timeplayed[#"total"] > 60) {
        globallogic::gamehistoryplayerkicked();
        kick(self getentitynumber(), "GAME/DROPPEDFORINACTIVITY");
    }
}

// Namespace gun/gun
// Params 1, eflags: 0x0
// Checksum 0x3c95a508, Offset: 0x1000
// Size: 0x6c
function onspawnplayer(predictedspawn) {
    if (!level.inprematchperiod) {
        level.usestartspawns = 0;
    }
    spawning::onspawnplayer(predictedspawn);
    self thread infiniteammo();
    self thread inactivitykick();
}

// Namespace gun/gun
// Params 9, eflags: 0x0
// Checksum 0xddf2cbd7, Offset: 0x1078
// Size: 0x1f4
function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    level.usestartspawns = 0;
    if (smeansofdeath == "MOD_SUICIDE" || smeansofdeath == "MOD_TRIGGER_HURT") {
        self thread demoteplayer();
        return;
    }
    if (isdefined(attacker) && isplayer(attacker)) {
        if (attacker == self) {
            self thread demoteplayer(attacker);
            return;
        }
        if (isdefined(attacker.lastpromotiontime) && attacker.lastpromotiontime + 3000 > gettime()) {
            scoreevents::processscoreevent(#"kill_in_3_seconds_gun", attacker, self, weapon);
        }
        if (weapon_utils::ismeleemod(smeansofdeath)) {
            scoreevents::processscoreevent(#"humiliation_gun", attacker, self, weapon);
            if (globallogic_score::gethighestscoringplayer() === self) {
                scoreevents::processscoreevent(#"melee_leader_gun", attacker, self, weapon);
            }
            self thread demoteplayer(attacker);
        }
        if (smeansofdeath != "MOD_MELEE_WEAPON_BUTT") {
            attacker thread promoteplayer(weapon);
        }
    }
}

// Namespace gun/gun
// Params 1, eflags: 0x0
// Checksum 0xc7ede53d, Offset: 0x1278
// Size: 0x74
function onendgame(var_c3d87d03) {
    player = round::function_2da88e92();
    if (isdefined(player)) {
        [[ level._setplayerscore ]](player, [[ level._getplayerscore ]](player) + level.gungamekillscore);
    }
    match::set_winner(player);
}

// Namespace gun/gun
// Params 9, eflags: 0x0
// Checksum 0x9cab050f, Offset: 0x12f8
// Size: 0x16a
function addguntoprogression(weaponname, attachment1, attachment2, attachment3, attachment4, attachment5, attachment6, attachment7, attachment8) {
    attachments = [];
    if (isdefined(attachment1)) {
        attachments[attachments.size] = attachment1;
    }
    if (isdefined(attachment2)) {
        attachments[attachments.size] = attachment2;
    }
    if (isdefined(attachment3)) {
        attachments[attachments.size] = attachment3;
    }
    if (isdefined(attachment4)) {
        attachments[attachments.size] = attachment4;
    }
    if (isdefined(attachment5)) {
        attachments[attachments.size] = attachment5;
    }
    if (isdefined(attachment6)) {
        attachments[attachments.size] = attachment6;
    }
    if (isdefined(attachment7)) {
        attachments[attachments.size] = attachment7;
    }
    if (isdefined(attachment8)) {
        attachments[attachments.size] = attachment8;
    }
    weapon = getweapon(weaponname, attachments);
    level.gunprogression[level.gunprogression.size] = weapon;
}

// Namespace gun/gun
// Params 1, eflags: 0x0
// Checksum 0xb3d1617a, Offset: 0x1470
// Size: 0x4c
function takeoldweapon(oldweapon) {
    self endon(#"death");
    self endon(#"disconnect");
    wait 1;
    self takeweapon(oldweapon);
}

// Namespace gun/gun
// Params 1, eflags: 0x0
// Checksum 0x9dcb4f1f, Offset: 0x14c8
// Size: 0x248
function givecustomloadout(takeoldweapon = 0) {
    self loadout::init_player(!takeoldweapon);
    perks = self getloadoutperks(0);
    foreach (perk in perks) {
        self setperk(perk);
    }
    if (takeoldweapon) {
        oldweapon = self getcurrentweapon();
        weapons = self getweaponslist();
        foreach (weapon in weapons) {
            if (weapon != oldweapon) {
                self takeweapon(weapon);
            }
        }
        self thread takeoldweapon(oldweapon);
    }
    if (!isdefined(self.gunprogress)) {
        self.gunprogress = 0;
    }
    currentweapon = level.gunprogression[self.gunprogress];
    self giveweapon(currentweapon);
    self switchtoweapon(currentweapon);
    self disableweaponcycling();
    if (self.firstspawn !== 0) {
        self setspawnweapon(currentweapon);
    }
    return currentweapon;
}

// Namespace gun/gun
// Params 1, eflags: 0x0
// Checksum 0x99a86337, Offset: 0x1718
// Size: 0x19e
function promoteplayer(weaponused) {
    self endon(#"disconnect");
    self endon(#"cancel_promotion");
    level endon(#"game_ended");
    waitframe(1);
    if (weaponused.rootweapon == level.gunprogression[self.gunprogress].rootweapon || isdefined(level.gunprogression[self.gunprogress].dualwieldweapon) && level.gunprogression[self.gunprogress].dualwieldweapon.rootweapon == weaponused.rootweapon) {
        if (self.gunprogress < level.gunprogression.size - 1) {
            self.gunprogress++;
            if (isalive(self)) {
                self thread givecustomloadout(1);
            }
        }
        pointstowin = self.pers[#"pointstowin"];
        if (pointstowin < level.scorelimit) {
            self globallogic_score::givepointstowin(level.gungamekillscore);
            scoreevents::processscoreevent(#"kill_gun", self, undefined, undefined);
        }
        self.lastpromotiontime = gettime();
    }
}

// Namespace gun/gun
// Params 1, eflags: 0x0
// Checksum 0x81587562, Offset: 0x18c0
// Size: 0x214
function demoteplayer(attacker) {
    self endon(#"disconnect");
    self notify(#"cancel_promotion");
    currentgunprogress = self.gunprogress;
    for (i = 0; i < level.setbacksperdemotion; i++) {
        if (self.gunprogress <= 0) {
            break;
        }
        self globallogic_score::givepointstowin(level.gungamekillscore * -1);
        self.gunprogress--;
    }
    if (currentgunprogress != self.gunprogress && isalive(self)) {
        self thread givecustomloadout(1);
    }
    if (isdefined(attacker)) {
        self stats::function_2dabbec7(#"humiliate_attacker", 1);
        attacker recordgameevent("capture");
    }
    self stats::function_2dabbec7(#"humiliate_victim", 1);
    self.pers[#"humiliated"]++;
    self.humiliated = self.pers[#"humiliated"];
    self recordgameevent("return");
    self playlocalsound(#"mpl_wager_humiliate");
    self globallogic_audio::leader_dialog_on_player("humiliated");
}

// Namespace gun/gun
// Params 0, eflags: 0x0
// Checksum 0x53ae30a1, Offset: 0x1ae0
// Size: 0x70
function infiniteammo() {
    self endon(#"death");
    self endon(#"disconnect");
    while (true) {
        wait 0.1;
        weapon = self getcurrentweapon();
        self givemaxammo(weapon);
    }
}

// Namespace gun/gun
// Params 0, eflags: 0x0
// Checksum 0xa661015, Offset: 0x1b58
// Size: 0x10a
function function_13637a21() {
    ruleweaponsleft = 3;
    /#
    #/
    minweaponsleft = level.gunprogression.size;
    foreach (player in level.activeplayers) {
        if (!isdefined(player)) {
            continue;
        }
        if (!isdefined(player.gunprogress)) {
            continue;
        }
        weaponsleft = level.gunprogression.size - player.gunprogress;
        if (minweaponsleft > weaponsleft) {
            minweaponsleft = weaponsleft;
        }
        if (ruleweaponsleft >= minweaponsleft) {
            /#
            #/
            return false;
        }
    }
    /#
    #/
    return true;
}

