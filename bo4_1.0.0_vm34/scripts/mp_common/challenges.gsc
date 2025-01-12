#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\weapons_shared;
#using scripts\killstreaks\emp_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\mp\counteruav;
#using scripts\killstreaks\mp\uav;
#using scripts\mp_common\gametypes\match;
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\util;
#using scripts\weapons\weapon_utils;

#namespace challenges;

// Namespace challenges/challenges
// Params 0, eflags: 0x2
// Checksum 0x4f6c7a37, Offset: 0x460
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"challenges", &__init__, undefined, undefined);
}

// Namespace challenges/challenges
// Params 0, eflags: 0x0
// Checksum 0xee2743f7, Offset: 0x4a8
// Size: 0xa6
function __init__() {
    if (sessionmodeiswarzonegame()) {
        return;
    }
    if (!isdefined(level.challengescallbacks)) {
        level.challengescallbacks = [];
    }
    callback::on_start_gametype(&start_gametype);
    callback::on_spawned(&on_player_spawn);
    level.heroabilityactivateneardeath = &heroabilityactivateneardeath;
    level.var_3b36608e = &function_3b36608e;
}

// Namespace challenges/challenges
// Params 0, eflags: 0x0
// Checksum 0x90a208e1, Offset: 0x558
// Size: 0xb4
function start_gametype() {
    waittillframeend();
    if (isdefined(level.scoreeventgameendcallback)) {
        registerchallengescallback("gameEnd", level.scoreeventgameendcallback);
    }
    if (canprocesschallenges()) {
        registerchallengescallback("playerKilled", &challengekills);
        registerchallengescallback("gameEnd", &challengegameendmp);
    }
    callback::on_connect(&on_player_connect);
}

// Namespace challenges/challenges
// Params 0, eflags: 0x0
// Checksum 0xba0f01ce, Offset: 0x618
// Size: 0x5c
function on_player_connect() {
    initchallengedata();
    self thread spawnwatcher();
    self thread monitorreloads();
    self thread monitorgrenadefire();
}

// Namespace challenges/challenges
// Params 0, eflags: 0x0
// Checksum 0xa984b5bf, Offset: 0x680
// Size: 0xde
function initchallengedata() {
    self.pers[#"hash_1f0376e90d850ee7"] = 0;
    self.pers[#"hash_595d621c6b788be0"] = 0;
    self.pers[#"stickexplosivekill"] = 0;
    self.pers[#"carepackagescalled"] = 0;
    self.pers[#"challenge_destroyed_air"] = 0;
    self.pers[#"challenge_destroyed_ground"] = 0;
    self.pers[#"challenge_anteup_earn"] = 0;
    self.pers[#"specialiststatabilityusage"] = 0;
    self.pers[#"activekillstreaks"] = [];
}

// Namespace challenges/challenges
// Params 0, eflags: 0x0
// Checksum 0x41f77b6c, Offset: 0x768
// Size: 0x228
function spawnwatcher() {
    self endon(#"disconnect");
    self.pers[#"killnemesis"] = 0;
    self.pers[#"killsfastmagext"] = 0;
    self.pers[#"longshotsperlife"] = 0;
    self.pers[#"specialiststatabilityusage"] = 0;
    self.challenge_defenderkillcount = 0;
    self.challenge_offenderkillcount = 0;
    self.challenge_offenderprojectilemultikillcount = 0;
    self.challenge_offendercomlinkkillcount = 0;
    self.challenge_offendersentryturretkillcount = 0;
    self.challenge_objectivedefensivekillcount = 0;
    self.challenge_objectiveoffensivekillcount = 0;
    self.challenge_scavengedcount = 0;
    self.challenge_resuppliednamekills = 0;
    self.challenge_objectivedefensive = undefined;
    self.challenge_objectiveoffensive = undefined;
    self.challenge_lastsurvivewithflakfrom = undefined;
    self.explosiveinfo = [];
    self function_57a423a3();
    for (;;) {
        self waittill(#"spawned_player");
        self function_57a423a3();
        self thread function_92823005();
        self thread watchjump();
        self thread watchswimming();
        self thread function_7f4a227d();
        self thread watchslide();
        self thread watchsprint();
        self thread watchscavengelethal();
        self thread function_de32795d();
        self thread watchweaponchangecomplete();
    }
}

// Namespace challenges/challenges
// Params 0, eflags: 0x0
// Checksum 0x93b57f4f, Offset: 0x998
// Size: 0x3e
function function_57a423a3() {
    self.weaponkillsthisspawn = [];
    self.attachmentkillsthisspawn = [];
    self.challenge_hatchettosscount = 0;
    self.challenge_hatchetkills = 0;
    self.challenge_combatrobotattackclientid = [];
}

// Namespace challenges/challenges
// Params 0, eflags: 0x0
// Checksum 0xb79d96e9, Offset: 0x9e0
// Size: 0x58
function watchscavengelethal() {
    self endon(#"death");
    self endon(#"disconnect");
    self.challenge_scavengedcount = 0;
    for (;;) {
        self waittill(#"scavenged_primary_grenade");
        self.challenge_scavengedcount++;
    }
}

// Namespace challenges/challenges
// Params 0, eflags: 0x0
// Checksum 0xfc3c1907, Offset: 0xa40
// Size: 0xde
function function_92823005() {
    self endon(#"death");
    self endon(#"disconnect");
    self.var_150f7cf6 = 0;
    self.var_fdd0883a = 0;
    for (;;) {
        ret = self waittill(#"doublejump_begin", #"doublejump_end", #"disconnect");
        switch (ret._notify) {
        case #"doublejump_begin":
            self.var_150f7cf6 = gettime();
            break;
        case #"doublejump_end":
            self.var_fdd0883a = gettime();
            break;
        }
    }
}

// Namespace challenges/challenges
// Params 0, eflags: 0x0
// Checksum 0x20090772, Offset: 0xb28
// Size: 0xde
function watchjump() {
    self endon(#"death");
    self endon(#"disconnect");
    self.challenge_jump_begin = 0;
    self.challenge_jump_end = 0;
    for (;;) {
        ret = self waittill(#"jump_begin", #"jump_end", #"disconnect");
        switch (ret._notify) {
        case #"jump_begin":
            self.challenge_jump_begin = gettime();
            break;
        case #"jump_end":
            self.challenge_jump_end = gettime();
            break;
        }
    }
}

// Namespace challenges/challenges
// Params 0, eflags: 0x0
// Checksum 0xbed0ffec, Offset: 0xc10
// Size: 0xde
function watchswimming() {
    self endon(#"death");
    self endon(#"disconnect");
    self.challenge_swimming_begin = 0;
    self.challenge_swimming_end = 0;
    for (;;) {
        ret = self waittill(#"swimming_begin", #"swimming_end", #"disconnect");
        switch (ret._notify) {
        case #"swimming_begin":
            self.challenge_swimming_begin = gettime();
            break;
        case #"swimming_end":
            self.challenge_swimming_end = gettime();
            break;
        }
    }
}

// Namespace challenges/challenges
// Params 0, eflags: 0x0
// Checksum 0x27bf33ed, Offset: 0xcf8
// Size: 0xde
function function_7f4a227d() {
    self endon(#"death");
    self endon(#"disconnect");
    self.var_da3759c8 = 0;
    self.var_77c2a8fc = 0;
    for (;;) {
        ret = self waittill(#"wallrun_begin", #"wallrun_end", #"disconnect");
        switch (ret._notify) {
        case #"wallrun_begin":
            self.var_da3759c8 = gettime();
            break;
        case #"wallrun_end":
            self.var_77c2a8fc = gettime();
            break;
        }
    }
}

// Namespace challenges/challenges
// Params 0, eflags: 0x0
// Checksum 0xd85a8d12, Offset: 0xde0
// Size: 0xde
function watchslide() {
    self endon(#"death");
    self endon(#"disconnect");
    self.challenge_slide_begin = 0;
    self.challenge_slide_end = 0;
    for (;;) {
        ret = self waittill(#"slide_begin", #"slide_end", #"disconnect");
        switch (ret._notify) {
        case #"slide_begin":
            self.challenge_slide_begin = gettime();
            break;
        case #"slide_end":
            self.challenge_slide_end = gettime();
            break;
        }
    }
}

// Namespace challenges/challenges
// Params 0, eflags: 0x0
// Checksum 0xd3ca301d, Offset: 0xec8
// Size: 0xde
function watchsprint() {
    self endon(#"death");
    self endon(#"disconnect");
    self.challenge_sprint_begin = 0;
    self.challenge_sprint_end = 0;
    for (;;) {
        ret = self waittill(#"sprint_begin", #"sprint_end", #"disconnect");
        switch (ret._notify) {
        case #"sprint_begin":
            self.challenge_sprint_begin = gettime();
            break;
        case #"sprint_end":
            self.challenge_sprint_end = gettime();
            break;
        }
    }
}

// Namespace challenges/challenges
// Params 1, eflags: 0x0
// Checksum 0x23ac1eb5, Offset: 0xfb0
// Size: 0x303c
function challengekills(data) {
    weapon = data.weapon;
    player = data.attacker;
    victim = data.victim;
    attacker = data.attacker;
    time = data.time;
    attacker.lastkilledplayer = victim;
    var_3828b415 = data.var_3828b415;
    attackerheroability = data.attackerheroability;
    attackerheroabilityactive = data.attackerheroabilityactive;
    attackersliding = data.attackersliding;
    attackerspeedburst = data.attackerspeedburst;
    attackertraversing = data.attackertraversing;
    attackervisionpulseactivatetime = data.attackervisionpulseactivatetime;
    attackervisionpulsearray = data.attackervisionpulsearray;
    attackervisionpulseorigin = data.attackervisionpulseorigin;
    attackervisionpulseoriginarray = data.attackervisionpulseoriginarray;
    var_e4763e35 = data.var_e4763e35;
    attackerwasconcussed = data.attackerwasconcussed;
    attackerwasflashed = data.attackerwasflashed;
    attackerwasheatwavestunned = data.attackerwasheatwavestunned;
    attackerwasonground = data.attackeronground;
    attackerwasunderwater = data.attackerwasunderwater;
    attackerlastfastreloadtime = data.attackerlastfastreloadtime;
    lastweaponbeforetoss = data.lastweaponbeforetoss;
    meansofdeath = data.smeansofdeath;
    ownerweaponatlaunch = data.ownerweaponatlaunch;
    victimbedout = data.bledout;
    victimorigin = data.victimorigin;
    victimcombatefficiencylastontime = data.victimcombatefficiencylastontime;
    victimcombatefficieny = data.victimcombatefficieny;
    victimelectrifiedby = data.victimelectrifiedby;
    victimheroability = data.victimheroability;
    victimheroabilityactive = data.victimheroabilityactive;
    victimspeedburst = data.victimspeedburst;
    victimspeedburstlastontime = data.victimspeedburstlastontime;
    victimvisionpulseactivatetime = data.victimvisionpulseactivatetime;
    victimvisionpulseactivatetime = data.victimvisionpulseactivatetime;
    victimvisionpulsearray = data.victimvisionpulsearray;
    victimvisionpulseorigin = data.victimvisionpulseorigin;
    victimvisionpulseoriginarray = data.victimvisionpulseoriginarray;
    victimattackersthisspawn = data.victimattackersthisspawn;
    var_b9995fb9 = data.var_b9995fb9;
    victimwasinslamstate = data.victimwasinslamstate;
    victimwaslungingwitharmblades = data.victimwaslungingwitharmblades;
    var_7501e33a = data.var_7501e33a;
    victimwasonground = data.victimonground;
    victimwasunderwater = data.wasunderwater;
    var_f67ec791 = data.var_f67ec791;
    victimlaststunnedby = data.victimlaststunnedby;
    victimactiveproximitygrenades = data.victim.activeproximitygrenades;
    victimactivebouncingbetties = data.victim.activebouncingbetties;
    attackerlastflashedby = data.attackerlastflashedby;
    attackerlaststunnedby = data.attackerlaststunnedby;
    attackerlaststunnedtime = data.attackerlaststunnedtime;
    attackerwassliding = data.attackerwassliding;
    attackerwassprinting = data.attackerwassprinting;
    wasdefusing = data.wasdefusing;
    wasplanting = data.wasplanting;
    inflictorownerwassprinting = data.inflictorownerwassprinting;
    playerorigin = data.attackerorigin;
    var_5bd9ee89 = data.var_5bd9ee89;
    var_82701a51 = data.var_82701a51;
    victim_jump_begin = data.victim_jump_begin;
    victim_jump_end = data.victim_jump_end;
    victim_swimming_begin = data.victim_swimming_begin;
    victim_swimming_end = data.victim_swimming_end;
    victim_slide_begin = data.victim_slide_begin;
    victim_slide_end = data.victim_slide_end;
    var_5d1971dd = data.var_5d1971dd;
    var_d4842f85 = data.var_d4842f85;
    var_6a9f8d24 = data.var_6a9f8d24;
    var_f4b4b342 = data.var_f4b4b342;
    var_3e129f16 = data.var_3e129f16;
    attacker_jump_begin = data.attacker_jump_begin;
    attacker_jump_end = data.attacker_jump_end;
    attacker_swimming_begin = data.attacker_swimming_begin;
    attacker_swimming_end = data.attacker_swimming_end;
    attacker_slide_begin = data.attacker_slide_begin;
    attacker_slide_end = data.attacker_slide_end;
    var_519c883c = data.var_519c883c;
    var_80924500 = data.var_80924500;
    var_f7f92f13 = data.var_f7f92f13;
    attacker_sprint_end = data.attacker_sprint_end;
    attacker_sprint_begin = data.attacker_sprint_begin;
    var_b041219e = data.var_b041219e;
    inflictoriscooked = data.inflictoriscooked;
    inflictorchallenge_hatchettosscount = data.inflictorchallenge_hatchettosscount;
    inflictorownerwassprinting = data.inflictorownerwassprinting;
    inflictorplayerhasengineerperk = data.inflictorplayerhasengineerperk;
    inflictor = data.einflictor;
    var_d43e44c7 = isdefined(victim.challenge_combatrobotattackclientid) && isdefined(victim.challenge_combatrobotattackclientid[player.clientid]);
    weaponclass = util::getweaponclass(weapon);
    baseweapon = getbaseweapon(weapon);
    baseweaponitemindex = getbaseweaponitemindex(baseweapon);
    weaponpurchased = player isitempurchased(baseweaponitemindex);
    victimsupportindex = victim.team;
    playersupportindex = player.team;
    if (!level.teambased) {
        playersupportindex = player.entnum;
        victimsupportindex = victim.entnum;
    }
    if (meansofdeath == "MOD_HEAD_SHOT" || meansofdeath == "MOD_PISTOL_BULLET" || meansofdeath == "MOD_RIFLE_BULLET") {
        bulletkill = 1;
    } else {
        bulletkill = 0;
    }
    if (level.teambased) {
        if (player.team == victim.team) {
            return;
        }
    } else if (player == victim) {
        return;
    }
    killstreak = killstreaks::get_from_weapon(data.weapon);
    if (!isdefined(killstreak)) {
        player processspecialistchallenge("kills");
        if (weapon.isheavyweapon) {
            if (!isdefined(player.pers[#"challenge_heroweaponkills"])) {
                player.pers[#"challenge_heroweaponkills"] = 0;
            }
            player processspecialistchallenge("kills_weapon");
            player.heavyweaponkillsthisactivation++;
            player.pers[#"challenge_heroweaponkills"]++;
            if (player.pers[#"challenge_heroweaponkills"] >= 6) {
                player processspecialistchallenge("kill_one_game_weapon");
                player.pers[#"challenge_heroweaponkills"] = 0;
            }
        }
    }
    if (bulletkill) {
        if (weaponpurchased) {
            if (weaponclass == #"weapon_sniper") {
                if (isdefined(victim.firsttimedamaged) && victim.firsttimedamaged == time) {
                    player stats::function_b48aa4e(#"kill_enemy_one_bullet_sniper", 1);
                    player stats::function_4f10b697(weapon, #"kill_enemy_one_bullet_sniper", 1);
                }
            } else if (weaponclass == "weapon_cqb") {
                if (isdefined(victim.firsttimedamaged) && victim.firsttimedamaged == time) {
                    player stats::function_b48aa4e(#"kill_enemy_one_bullet_shotgun", 1);
                    player stats::function_4f10b697(weapon, #"kill_enemy_one_bullet_shotgun", 1);
                }
            }
        }
        if (isdefined(attacker_swimming_end) && isdefined(var_f4b4b342) && time - attacker_swimming_end <= 2000 && time - var_f4b4b342 <= 2000) {
            player stats::function_b48aa4e(#"hash_27ffc0fa529062b1", 1);
        }
        if (attackerwassliding) {
            if (var_3e129f16 == attacker_slide_begin) {
                player stats::function_b48aa4e(#"hash_9d83be25c5affbd", 1);
            }
        }
        checkkillstreak5(baseweapon, player);
        if (weapon.isdualwield && weaponpurchased) {
            checkdualwield(baseweapon, player, attacker, time, attackerwassprinting, attacker_sprint_end);
        }
        if (isdefined(weapon.attachments) && weapon.attachments.size > 0) {
            attachmentname = player getweaponoptic(weapon);
            if (isdefined(attachmentname) && attachmentname != "" && player weaponhasattachmentandunlocked(weapon, attachmentname)) {
                if (weapon.attachments.size > 5 && player allweaponattachmentsunlocked(weapon) && !isdefined(attacker.tookweaponfrom[weapon])) {
                    player stats::function_b48aa4e(#"kill_optic_5_attachments", 1);
                }
                if (isdefined(player.attachmentkillsthisspawn[attachmentname])) {
                    player.attachmentkillsthisspawn[attachmentname]++;
                    if (player.attachmentkillsthisspawn[attachmentname] == 5) {
                        player stats::function_4f10b697(weapon, #"killstreak_5_attachment", 1);
                    }
                } else {
                    player.attachmentkillsthisspawn[attachmentname] = 1;
                }
                if (weapon_utils::ispistol(weapon.rootweapon)) {
                    if (player weaponhasattachmentandunlocked(weapon, "suppressed", "extbarrel")) {
                        player stats::function_b48aa4e(#"kills_pistol_lasersight_suppressor_longbarrel", 1);
                    }
                }
            }
            if (player weaponhasattachmentandunlocked(weapon, "suppressed")) {
                if (attacker util::has_hard_wired_perk_purchased_and_equipped() && attacker util::has_ghost_perk_purchased_and_equipped() && attacker util::has_jetquiet_perk_purchased_and_equipped()) {
                    player stats::function_b48aa4e(#"kills_suppressor_ghost_hardwired_blastsuppressor", 1);
                }
            }
            if (player playerads() == 1) {
                if (isdefined(player.smokegrenadetime) && isdefined(player.smokegrenadeposition)) {
                    if (player.smokegrenadetime + 14000 > time) {
                        if (player util::is_looking_at(player.smokegrenadeposition) || distancesquared(player.origin, player.smokegrenadeposition) < 40000) {
                            if (player weaponhasattachmentandunlocked(weapon, "ir")) {
                                player stats::function_b48aa4e(#"kill_with_thermal_and_smoke_ads", 1);
                                player stats::function_4f10b697(weapon, #"kill_thermal_through_smoke", 1);
                            }
                        }
                    }
                }
            }
            if (weapon.attachments.size > 1) {
                if (player playerads() == 1) {
                    if (player weaponhasattachmentandunlocked(weapon, "grip", "quickdraw")) {
                        player stats::function_b48aa4e(#"kills_ads_quickdraw_and_grip", 1);
                    }
                    if (player weaponhasattachmentandunlocked(weapon, "swayreduc", "stalker")) {
                        player stats::function_b48aa4e(#"kills_ads_stock_and_cpu", 1);
                    }
                } else if (player weaponhasattachmentandunlocked(weapon, "rf", "steadyaim")) {
                    if (attacker util::has_fast_hands_perk_purchased_and_equipped()) {
                        player stats::function_b48aa4e(#"kills_hipfire_rapidfire_lasersights_fasthands", 1);
                    }
                }
                if (player weaponhasattachmentandunlocked(weapon, "fastreload", "extclip")) {
                    player.pers[#"killsfastmagext"]++;
                    if (player.pers[#"killsfastmagext"] > 4) {
                        player stats::function_b48aa4e(#"kills_one_life_fastmags_and_extclip", 1);
                        player.pers[#"killsfastmagext"] = 0;
                    }
                }
            }
            if (weapon.attachments.size > 2) {
                if (meansofdeath == "MOD_HEAD_SHOT") {
                    if (player weaponhasattachmentandunlocked(weapon, "fmj", "damage", "extbarrel")) {
                        player stats::function_b48aa4e(#"headshot_fmj_highcaliber_longbarrel", 1);
                    }
                }
            }
            if (weapon.attachments.size > 4) {
                if (player weaponhasattachmentandunlocked(weapon, "extclip", "grip", "fastreload", "quickdraw", "stalker")) {
                    player stats::function_b48aa4e(#"kills_extclip_grip_fastmag_quickdraw_stock", 1);
                }
            }
        }
        if (var_6a9f8d24 && var_f7f92f13) {
            player stats::function_b48aa4e(#"hash_57f4ca3fae659e74", 1);
        }
        if (isdefined(attackerlastfastreloadtime) && time - attackerlastfastreloadtime <= 5000 && player weaponhasattachmentandunlocked(weapon, "fastreload")) {
            player stats::function_b48aa4e(#"kills_after_reload_fastreload", 1);
        }
        if (victim.idflagstime == time) {
            if (victim.idflags & 8) {
                player stats::function_b48aa4e(#"kill_enemy_through_wall", 1);
                if (player weaponhasattachmentandunlocked(weapon, "fmj")) {
                    player stats::function_b48aa4e(#"kill_enemy_through_wall_with_fmj", 1);
                }
            }
        }
        if (var_b041219e === 1) {
            player stats::function_b48aa4e(#"hash_5f7304be50f9ba38", 1);
        }
    } else if (weapon_utils::ismeleemod(meansofdeath) && !isdefined(killstreak)) {
        player stats::function_b48aa4e(#"melee", 1);
        if (weapon_utils::ispunch(weapon)) {
            player stats::function_b48aa4e(#"kill_enemy_with_fists", 1);
        }
        checkkillstreak5(baseweapon, player);
    } else {
        if (weaponpurchased) {
            slot_weapon = player loadout::function_3d8b02a0("primarygrenade");
            if (weapon == slot_weapon) {
                if (player.challenge_scavengedcount > 0) {
                    player.challenge_resuppliednamekills++;
                    if (player.challenge_resuppliednamekills >= 3) {
                        player stats::function_b48aa4e(#"kills_3_resupplied_nade_one_life", 1);
                        player.challenge_resuppliednamekills = 0;
                    }
                    player.challenge_scavengedcount--;
                }
            }
            if (isdefined(inflictoriscooked)) {
                if (inflictoriscooked == 1 && weapon.rootweapon.name != "hatchet") {
                    player stats::function_b48aa4e(#"kill_with_cooked_grenade", 1);
                }
            }
            if (victimlaststunnedby === player) {
                if (weaponclass == "weapon_grenade") {
                    player stats::function_b48aa4e(#"kill_stun_lethal", 1);
                }
            }
            if (baseweapon == level.weaponspecialcrossbow) {
                if (weapon.isdualwield) {
                    checkdualwield(baseweapon, player, attacker, time, attackerwassprinting, attacker_sprint_end);
                }
            }
            if (baseweapon == level.weaponshotgunenergy) {
                if (isdefined(victim.firsttimedamaged) && victim.firsttimedamaged == time) {
                    player stats::function_b48aa4e(#"kill_enemy_one_bullet_shotgun", 1);
                    player stats::function_4f10b697(weapon, #"kill_enemy_one_bullet_shotgun", 1);
                }
            }
        }
        if (baseweapon.forcedamagehitlocation || baseweapon == level.weaponspecialcrossbow || baseweapon == level.weaponshotgunenergy) {
            checkkillstreak5(baseweapon, player);
        }
    }
    if (isdefined(attacker.tookweaponfrom[weapon]) && isdefined(attacker.tookweaponfrom[weapon].previousowner)) {
        if (!isdefined(attacker.tookweaponfrom[weapon].previousowner.team) || attacker.tookweaponfrom[weapon].previousowner.team != player.team) {
            player stats::function_b48aa4e(#"kill_with_pickup", 1);
        }
    }
    awarded_kill_enemy_that_blinded_you = 0;
    playerhastacticalmask = player player::function_8c628e44();
    if (attackerwasflashed) {
        if (attackerlastflashedby === victim && !playerhastacticalmask) {
            player stats::function_b48aa4e(#"kill_enemy_that_blinded_you", 1);
            awarded_kill_enemy_that_blinded_you = 1;
        }
    }
    if (!awarded_kill_enemy_that_blinded_you && isdefined(attackerlaststunnedtime) && attackerlaststunnedtime + 5000 > time) {
        if (attackerlaststunnedby === victim && !playerhastacticalmask) {
            player stats::function_b48aa4e(#"kill_enemy_that_blinded_you", 1);
            awarded_kill_enemy_that_blinded_you = 1;
        }
    }
    killedstunnedvictim = 0;
    if (isdefined(victim.lastconcussedby) && victim.lastconcussedby == attacker) {
        if (victim.concussionendtime > time) {
            if (player util::is_item_purchased(#"concussion_grenade")) {
                player stats::function_b48aa4e(#"hash_65f463ce38d57812", 1);
            }
            killedstunnedvictim = 1;
            player function_b5489c4b(getweapon(#"concussion_grenade"), 1);
        }
    }
    if (isdefined(victim.lastshockedby) && victim.lastshockedby == attacker) {
        if (victim.shockendtime > time) {
            if (player util::is_item_purchased(#"proximity_grenade")) {
                player stats::function_b48aa4e(#"kill_shocked_enemy", 1);
            }
            player function_b5489c4b(getweapon(#"proximity_grenade"), 1);
            killedstunnedvictim = 1;
            if (weapon.rootweapon.name == "bouncingbetty") {
                player stats::function_b48aa4e(#"kill_trip_mine_shocked", 1);
            }
        }
    }
    if (victim util::isflashbanged()) {
        if (isdefined(victim.lastflashedby) && victim.lastflashedby == player) {
            killedstunnedvictim = 1;
            if (player util::is_item_purchased(#"flash_grenade")) {
                player stats::function_b48aa4e(#"kill_flashed_enemy", 1);
            }
            player function_b5489c4b(getweapon(#"flash_grenade"), 1);
        }
    }
    if (level.teambased) {
        if (!isdefined(player.pers[#"kill_every_enemy_with_specialist"]) && level.playercount[victim.pers[#"team"]] > 3 && player.pers[#"killed_players_with_specialist"].size >= level.playercount[victim.pers[#"team"]]) {
            player stats::function_b48aa4e(#"kill_every_enemy", 1);
            player.pers[#"kill_every_enemy_with_specialist"] = 1;
        }
        if (isdefined(victimattackersthisspawn) && isarray(victimattackersthisspawn)) {
            if (victimattackersthisspawn.size > 5) {
                attackercount = 0;
                foreach (attacking_player in victimattackersthisspawn) {
                    if (!isdefined(attacking_player)) {
                        continue;
                    }
                    if (attacking_player == attacker) {
                        continue;
                    }
                    if (attacking_player.team != attacker.team) {
                        continue;
                    }
                    attackercount++;
                }
                if (attackercount > 4) {
                    player stats::function_b48aa4e(#"kill_enemy_5_teammates_assists", 1);
                }
            }
        }
    }
    if (isdefined(killstreak)) {
        if (killstreak == "rcbomb" || killstreak == "inventory_rcbomb") {
            if (!victimwasonground || var_f67ec791) {
                player stats::function_b48aa4e(#"hash_28180b78aa5622ae", 1);
            }
        }
        if (killstreak == "autoturret" || killstreak == "inventory_autoturret") {
            if (isdefined(inflictor) && player util::is_item_purchased(#"hash_2beb8d5bcc1ee8fa")) {
                if (!isdefined(inflictor.challenge_killcount)) {
                    inflictor.challenge_killcount = 0;
                }
                inflictor.challenge_killcount++;
                if (inflictor.challenge_killcount == 5) {
                    player stats::function_b48aa4e(#"hash_533d112164fda487", 1);
                }
            }
        }
    }
    if (var_d43e44c7) {
        if (!isdefined(inflictor) || !isdefined(inflictor.killstreaktype) || !isstring(inflictor.killstreaktype) || inflictor.killstreaktype != "combat_robot") {
            player stats::function_b48aa4e(#"kill_enemy_who_damaged_robot", 1);
        }
    }
    player trackkillstreaksupportkills(victim);
    if (!isdefined(killstreak)) {
        if (attackerwasunderwater) {
            player stats::function_b48aa4e(#"kill_while_underwater", 1);
        }
        if (player util::has_purchased_perk_equipped(#"specialty_jetcharger")) {
            if (var_f4b4b342 > var_3e129f16 || var_3e129f16 + 3000 > time || attacker_slide_begin > attacker_slide_end || attacker_slide_end + 3000 > time) {
                player stats::function_b48aa4e(#"hash_7c7067d81784dd9d", 1);
                if (player util::has_purchased_perk_equipped(#"specialty_overcharge")) {
                    player stats::function_b48aa4e(#"hash_2bf56577a0bfec0c", 1);
                }
            }
        }
        trackedplayer = 0;
        if (player util::has_purchased_perk_equipped(#"specialty_tracker")) {
            if (!victim hasperk(#"specialty_trackerjammer")) {
                player stats::function_b48aa4e(#"kill_detect_tracker", 1);
                trackedplayer = 1;
            }
        }
        if (player util::has_purchased_perk_equipped(#"specialty_detectnearbyenemies")) {
            if (!victim hasperk(#"specialty_sixthsensejammer")) {
                player stats::function_b48aa4e(#"kill_enemy_sixth_sense", 1);
                if (player util::has_purchased_perk_equipped(#"specialty_loudenemies")) {
                    if (!victim hasperk(#"specialty_quieter")) {
                        player stats::function_b48aa4e(#"kill_sixthsense_awareness", 1);
                    }
                }
            }
            if (trackedplayer) {
                player stats::function_b48aa4e(#"kill_tracker_sixthsense", 1);
            }
        }
        if (weapon.isheavyweapon == 1 || attackerheroabilityactive) {
            if (player util::has_purchased_perk_equipped(#"specialty_overcharge")) {
                player stats::function_b48aa4e(#"kill_with_specialist_overclock", 1);
            }
        }
        if (player util::has_purchased_perk_equipped(#"specialty_gpsjammer")) {
            if (uav::hasuav(victimsupportindex)) {
                player stats::function_b48aa4e(#"kill_uav_enemy_with_ghost", 1);
            }
            if (player util::has_blind_eye_perk_purchased_and_equipped()) {
                activekillstreaks = victim killstreaks::getactivekillstreaks();
                awarded_kill_blindeye_ghost_aircraft = 0;
                foreach (activestreak in activekillstreaks) {
                    if (awarded_kill_blindeye_ghost_aircraft) {
                        break;
                    }
                    switch (activestreak.killstreaktype) {
                    case #"drone_striked":
                    case #"uav":
                    case #"helicopter_comlink":
                    case #"sentinel":
                        player stats::function_b48aa4e(#"kill_blindeye_ghost_aircraft", 1);
                        awarded_kill_blindeye_ghost_aircraft = 1;
                        break;
                    }
                }
            }
        }
        if (player util::has_purchased_perk_equipped(#"specialty_flakjacket")) {
            if (isdefined(player.challenge_lastsurvivewithflakfrom) && player.challenge_lastsurvivewithflakfrom == victim) {
                player stats::function_b48aa4e(#"kill_enemy_survive_flak", 1);
            }
            if (player util::has_tactical_mask_purchased_and_equipped()) {
                var_7488049d = 0;
                if (isdefined(player.challenge_lastsurvivewithflaktime)) {
                    if (player.challenge_lastsurvivewithflaktime + 3000 > time) {
                        var_7488049d = 1;
                    }
                }
                var_186c1d3e = 0;
                if (isdefined(player.laststunnedtime)) {
                    if (player.laststunnedtime + 2000 > time) {
                        var_186c1d3e = 1;
                    }
                }
                if (var_7488049d || player util::isflashbanged() || var_186c1d3e) {
                    player stats::function_b48aa4e(#"kill_flak_tac_while_stunned", 1);
                }
            }
        }
        if (player util::has_hard_wired_perk_purchased_and_equipped()) {
            if (victim counteruav::hasindexactivecounteruav(victimsupportindex) || victim emp::hasactiveemp()) {
                player stats::function_b48aa4e(#"kills_counteruav_emp_hardline", 1);
            }
        }
        if (player util::has_scavenger_perk_purchased_and_equipped()) {
            if (player.scavenged) {
                player stats::function_b48aa4e(#"kill_after_resupply", 1);
                if (trackedplayer) {
                    player stats::function_b48aa4e(#"kill_scavenger_tracker_resupply", 1);
                }
            }
        }
        if (player util::has_fast_hands_perk_purchased_and_equipped()) {
            if (bulletkill) {
                if (attackerwassprinting || attacker_sprint_end + 3000 > time) {
                    player stats::function_b48aa4e(#"kills_after_sprint_fasthands", 1);
                    if (player util::has_gung_ho_perk_purchased_and_equipped()) {
                        player stats::function_b48aa4e(#"kill_fasthands_gungho_sprint", 1);
                    }
                }
            }
        }
        if (player util::has_hard_wired_perk_purchased_and_equipped()) {
            if (player util::has_cold_blooded_perk_purchased_and_equipped()) {
                player stats::function_b48aa4e(#"kill_hardwired_coldblooded", 1);
            }
        }
        killedplayerwithgungho = 0;
        if (player util::has_gung_ho_perk_purchased_and_equipped()) {
            if (bulletkill) {
                killedplayerwithgungho = 1;
                if (attackerwassprinting && player playerads() != 1) {
                    player stats::function_b48aa4e(#"kill_hip_gung_ho", 1);
                }
            }
            if (weaponclass == "weapon_grenade") {
                if (isdefined(inflictorownerwassprinting) && inflictorownerwassprinting == 1) {
                    killedplayerwithgungho = 1;
                    player stats::function_b48aa4e(#"kill_hip_gung_ho", 1);
                }
            }
        }
        if (player util::has_jetquiet_perk_purchased_and_equipped()) {
            if (var_3828b415 || var_3e129f16 + 3000 > time) {
                player stats::function_b48aa4e(#"hash_78de1d6f9571a31c", 1);
                if (player util::has_ghost_perk_purchased_and_equipped()) {
                    if (uav::hasuav(victimsupportindex)) {
                        player stats::function_b48aa4e(#"hash_dbfa1eef8facdaf", 1);
                    }
                }
            }
        }
        if (player util::has_awareness_perk_purchased_and_equipped()) {
            player stats::function_b48aa4e(#"kill_awareness", 1);
        }
        if (killedstunnedvictim) {
            if (player util::has_tactical_mask_purchased_and_equipped()) {
                player stats::function_b48aa4e(#"kill_stunned_tacmask", 1);
                if (killedplayerwithgungho == 1) {
                    player stats::function_b48aa4e(#"kill_sprint_stunned_gungho_tac", 1);
                }
            }
        }
        if (player util::has_ninja_perk_purchased_and_equipped()) {
            player stats::function_b48aa4e(#"kill_dead_silence", 1);
            if (distancesquared(playerorigin, victimorigin) < 14400) {
                if (player util::has_awareness_perk_purchased_and_equipped()) {
                    player stats::function_b48aa4e(#"kill_close_deadsilence_awareness", 1);
                }
                if (player util::has_jetquiet_perk_purchased_and_equipped()) {
                    player stats::function_b48aa4e(#"kill_close_blast_deadsilence", 1);
                }
            }
        }
        primary_weapon = player loadout::function_3d8b02a0("primary");
        if (isdefined(primary_weapon) && weapon == primary_weapon || isdefined(primary_weapon.altweapon) && weapon == primary_weapon.altweapon) {
            if (player function_6fe12e03("secondary")) {
                player function_a73e1cf7("primary", 0);
                player function_a73e1cf7("secondary", 0);
            } else {
                player function_a73e1cf7("primary", 1);
            }
        } else {
            secondary_weapon = player loadout::function_3d8b02a0("secondary");
            if (isdefined(secondary_weapon) && weapon == secondary_weapon || isdefined(secondary_weapon.altweapon) && weapon == secondary_weapon.altweapon) {
                if (player function_6fe12e03("primary")) {
                    player function_a73e1cf7("primary", 0);
                    player function_a73e1cf7("secondary", 0);
                } else {
                    player function_a73e1cf7("secondary", 1);
                }
            }
        }
        if (player util::has_hacker_perk_purchased_and_equipped() && player util::has_hard_wired_perk_purchased_and_equipped()) {
            should_award_kill_near_plant_engineer_hardwired = 0;
            if (isdefined(victimactivebouncingbetties)) {
                foreach (bouncingbettyinfo in victimactivebouncingbetties) {
                    if (!isdefined(bouncingbettyinfo) || !isdefined(bouncingbettyinfo.origin)) {
                        continue;
                    }
                    if (distancesquared(bouncingbettyinfo.origin, victimorigin) < 400 * 400) {
                        should_award_kill_near_plant_engineer_hardwired = 1;
                        break;
                    }
                }
            }
            if (isdefined(victimactiveproximitygrenades) && should_award_kill_near_plant_engineer_hardwired == 0) {
                foreach (proximitygrenadeinfo in victimactiveproximitygrenades) {
                    if (!isdefined(proximitygrenadeinfo) || !isdefined(proximitygrenadeinfo.origin)) {
                        continue;
                    }
                    if (distancesquared(proximitygrenadeinfo.origin, victimorigin) < 400 * 400) {
                        should_award_kill_near_plant_engineer_hardwired = 1;
                        break;
                    }
                }
            }
            if (should_award_kill_near_plant_engineer_hardwired) {
                player stats::function_b48aa4e(#"kill_near_plant_engineer_hardwired", 1);
            }
        }
    } else if (weapon.name == #"supplydrop") {
        if (isdefined(inflictorplayerhasengineerperk)) {
            player stats::function_b48aa4e(#"kill_booby_trap_engineer", 1);
        }
    }
    if (weapon.isheavyweapon == 1 || attackerheroabilityactive || isdefined(killstreak)) {
        if (player util::has_purchased_perk_equipped(#"specialty_overcharge") && player util::has_purchased_perk_equipped(#"specialty_anteup")) {
            player stats::function_b48aa4e(#"kill_anteup_overclock_scorestreak_specialist", 1);
        }
    }
}

// Namespace challenges/challenges
// Params 0, eflags: 0x0
// Checksum 0x20fdebac, Offset: 0x3ff8
// Size: 0x2c
function on_player_spawn() {
    if (canprocesschallenges()) {
        self fix_challenge_stats_on_spawn();
    }
}

// Namespace challenges/challenges
// Params 2, eflags: 0x0
// Checksum 0x799b9770, Offset: 0x4030
// Size: 0x44
function force_challenge_stat(stat_name, stat_value) {
    self stats::set_stat_global(stat_name, stat_value);
    self stats::set_stat_challenge(stat_name, stat_value);
}

// Namespace challenges/challenges
// Params 2, eflags: 0x0
// Checksum 0x650b89fd, Offset: 0x4080
// Size: 0x52
function get_challenge_group_stat(group_name, stat_name) {
    return self stats::get_stat(#"groupstats", group_name, #"stats", stat_name, #"challengevalue");
}

// Namespace challenges/challenges
// Params 0, eflags: 0x0
// Checksum 0x6f0d90e3, Offset: 0x40e0
// Size: 0x42
function fix_challenge_stats_on_spawn() {
    player = self;
    if (!isdefined(player)) {
        return;
    }
    if (player.var_77333b5 === 1) {
        return;
    }
    player.var_77333b5 = 1;
}

// Namespace challenges/challenges
// Params 1, eflags: 0x0
// Checksum 0xf88d567c, Offset: 0x4130
// Size: 0xc4
function fix_tu6_weapon_for_diamond(stat_name) {
    player = self;
    wepaon_for_diamond = player stats::get_stat_challenge(stat_name);
    if (wepaon_for_diamond == 1) {
        secondary_mastery = player stats::get_stat_challenge("secondary_mastery");
        if (secondary_mastery == 3) {
            player force_challenge_stat(stat_name, 2);
            return;
        }
        player force_challenge_stat(stat_name, 0);
    }
}

// Namespace challenges/challenges
// Params 0, eflags: 0x0
// Checksum 0x1c7c4d4b, Offset: 0x4200
// Size: 0xcc
function fix_tu6_ar_garand() {
    player = self;
    group_weapon_assault = player get_challenge_group_stat("weapon_assault", "challenges");
    weapons_mastery_assault = player stats::get_stat_challenge("weapons_mastery_assault");
    if (group_weapon_assault >= 49 && weapons_mastery_assault < 1) {
        player force_challenge_stat("weapons_mastery_assault", 1);
        player stats::function_b48aa4e(#"ar_garand_for_diamond", 1);
    }
}

// Namespace challenges/challenges
// Params 0, eflags: 0x0
// Checksum 0x97934af0, Offset: 0x42d8
// Size: 0xcc
function fix_tu6_pistol_shotgun() {
    player = self;
    group_weapon_pistol = player get_challenge_group_stat("weapon_pistol", "challenges");
    secondary_mastery_pistol = player stats::get_stat_challenge("secondary_mastery_pistol");
    if (group_weapon_pistol >= 21 && secondary_mastery_pistol < 1) {
        player force_challenge_stat("secondary_mastery_pistol", 1);
        player stats::function_b48aa4e(#"pistol_shotgun_for_diamond", 1);
    }
}

// Namespace challenges/challenges
// Params 2, eflags: 0x0
// Checksum 0x33411e0d, Offset: 0x43b0
// Size: 0x40
function completed_specific_challenge(target_value, challenge_name) {
    challenge_count = self stats::get_stat_challenge(challenge_name);
    return challenge_count >= target_value;
}

// Namespace challenges/challenges
// Params 2, eflags: 0x0
// Checksum 0x89c39c2c, Offset: 0x43f8
// Size: 0x38
function tally_completed_challenge(target_value, challenge_name) {
    return self completed_specific_challenge(target_value, challenge_name) ? 1 : 0;
}

// Namespace challenges/challenges
// Params 0, eflags: 0x0
// Checksum 0xd9a17b8c, Offset: 0x4438
// Size: 0x1c
function tu7_fix_100_percenter() {
    self tu7_fix_mastery_perk_2();
}

// Namespace challenges/challenges
// Params 0, eflags: 0x0
// Checksum 0x4fd62f25, Offset: 0x4460
// Size: 0x26c
function tu7_fix_mastery_perk_2() {
    player = self;
    mastery_perk_2 = player stats::get_stat_challenge("mastery_perk_2");
    if (mastery_perk_2 >= 12) {
        return;
    }
    if (player completed_specific_challenge(200, "earn_scorestreak_anteup") == 0) {
        return;
    }
    perk_2_tally = 1;
    perk_2_tally += player tally_completed_challenge(100, "destroy_ai_scorestreak_coldblooded");
    perk_2_tally += player tally_completed_challenge(100, "kills_counteruav_emp_hardline");
    perk_2_tally += player tally_completed_challenge(200, "kill_after_resupply");
    perk_2_tally += player tally_completed_challenge(100, "kills_after_sprint_fasthands");
    perk_2_tally += player tally_completed_challenge(200, "kill_detect_tracker");
    perk_2_tally += player tally_completed_challenge(10, "earn_5_scorestreaks_anteup");
    perk_2_tally += player tally_completed_challenge(25, "kill_scavenger_tracker_resupply");
    perk_2_tally += player tally_completed_challenge(25, "kill_hardwired_coldblooded");
    perk_2_tally += player tally_completed_challenge(25, "kill_anteup_overclock_scorestreak_specialist");
    perk_2_tally += player tally_completed_challenge(50, "kill_fasthands_gungho_sprint");
    perk_2_tally += player tally_completed_challenge(50, "kill_tracker_sixthsense");
    if (mastery_perk_2 < perk_2_tally) {
        player stats::function_b48aa4e(#"mastery_perk_2", 1);
    }
}

// Namespace challenges/challenges
// Params 1, eflags: 0x0
// Checksum 0xf56fc582, Offset: 0x46d8
// Size: 0x7a
function getbaseweapon(weapon) {
    rootweapon = weapons::getbaseweapon(weapon);
    baseweapon = getweapon(rootweapon.statname);
    if (level.weaponnone == baseweapon) {
        baseweapon = rootweapon;
    }
    return baseweapon.rootweapon;
}

// Namespace challenges/challenges
// Params 2, eflags: 0x0
// Checksum 0xa27d24fc, Offset: 0x4760
// Size: 0xde
function checkkillstreak5(baseweapon, player) {
    assert(isdefined(baseweapon));
    assert(isdefined(player.weaponkillsthisspawn));
    if (isdefined(player.weaponkillsthisspawn[baseweapon])) {
        player.weaponkillsthisspawn[baseweapon]++;
        if (player.weaponkillsthisspawn[baseweapon] % 5 == 0) {
            player stats::function_4f10b697(baseweapon, #"killstreak_5", 1);
        }
        return;
    }
    player.weaponkillsthisspawn[baseweapon] = 1;
}

// Namespace challenges/challenges
// Params 6, eflags: 0x0
// Checksum 0x3e54bf6a, Offset: 0x4848
// Size: 0x8c
function checkdualwield(baseweapon, player, attacker, time, attackerwassprinting, attacker_sprint_end) {
    if (attackerwassprinting || attacker_sprint_end + 1000 > time) {
        if (attacker util::has_gung_ho_perk_purchased_and_equipped()) {
            player stats::function_b48aa4e(#"kills_sprinting_dual_wield_and_gung_ho", 1);
        }
    }
}

// Namespace challenges/challenges
// Params 1, eflags: 0x0
// Checksum 0xc7389e78, Offset: 0x48e0
// Size: 0x294
function challengegameendmp(data) {
    player = data.player;
    winner = data.winner;
    if (!isdefined(player)) {
        return;
    }
    if (endedearly(winner, match::get_flag("tie"))) {
        return;
    }
    if (level.teambased) {
        winnerscore = game.stat[#"teamscores"][winner];
        loserscore = getlosersteamscores(winner);
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
        if (level.teambased) {
            playeriswinner = player.team === winner;
        } else {
            playeriswinner = level.placement[#"all"][0] === winner || level.placement[#"all"][1] === winner || level.placement[#"all"][2] === winner;
        }
        if (playeriswinner) {
            player stats::function_b48aa4e(#"hash_7347e683426cd120", 1);
        }
    }
}

// Namespace challenges/challenges
// Params 2, eflags: 0x0
// Checksum 0x18158d27, Offset: 0x4b80
// Size: 0x386
function killedbaseoffender(objective, weapon) {
    self endon(#"disconnect");
    self stats::function_2dabbec7(#"defends", 1);
    self.challenge_offenderkillcount++;
    if (!isdefined(self.challenge_objectiveoffensive) || self.challenge_objectiveoffensive != objective) {
        self.challenge_objectiveoffensivekillcount = 0;
    }
    self.challenge_objectiveoffensivekillcount++;
    self.challenge_objectiveoffensive = objective;
    killstreak = killstreaks::get_from_weapon(weapon);
    if (isdefined(killstreak)) {
        switch (killstreak) {
        case #"drone_strike":
        case #"remote_missile":
        case #"inventory_planemortar":
        case #"hash_3acefe501ccc322d":
        case #"inventory_remote_missile":
        case #"planemortar":
            self.challenge_offenderprojectilemultikillcount++;
            break;
        case #"helicopter_comlink":
        case #"inventory_helicopter_comlink":
            self.challenge_offendercomlinkkillcount++;
            break;
        case #"combat_robot":
        case #"inventory_combat_robot":
            self stats::function_b48aa4e(#"kill_attacker_with_robot_or_tank", 1);
            break;
        case #"autoturret":
        case #"inventory_autoturret":
            self.challenge_offendersentryturretkillcount++;
            self stats::function_b48aa4e(#"kill_attacker_with_robot_or_tank", 1);
            break;
        }
    }
    if (self.challenge_offendercomlinkkillcount == 2) {
        self stats::function_b48aa4e(#"kill_2_attackers_with_comlink", 1);
    }
    if (self.challenge_objectiveoffensivekillcount > 4) {
        self stats::function_2dabbec7("multikill_5_attackers", 1);
        self.challenge_objectiveoffensivekillcount = 0;
    }
    if (self.challenge_offendersentryturretkillcount > 2) {
        self stats::function_b48aa4e(#"multikill_3_attackers_ai_tank", 1);
        self.challenge_offendersentryturretkillcount = 0;
    }
    self util::player_contract_event("offender_kill");
    self waittilltimeoutordeath(4);
    if (self.challenge_offenderkillcount > 1) {
        self stats::function_b48aa4e(#"hash_77a300646e7362fe", 1);
    }
    self.challenge_offenderkillcount = 0;
    if (self.challenge_offenderprojectilemultikillcount >= 2) {
        self stats::function_b48aa4e(#"multikill_2_objective_scorestreak_projectile", 1);
    }
    self.challenge_offenderprojectilemultikillcount = 0;
}

// Namespace challenges/challenges
// Params 1, eflags: 0x0
// Checksum 0x45b2d1d8, Offset: 0x4f10
// Size: 0x10e
function killedbasedefender(objective) {
    self endon(#"disconnect");
    self stats::function_2dabbec7(#"offends", 1);
    if (!isdefined(self.challenge_objectivedefensive) || self.challenge_objectivedefensive != objective) {
        self.challenge_objectivedefensivekillcount = 0;
    }
    self.challenge_objectivedefensivekillcount++;
    self.challenge_objectivedefensive = objective;
    self.challenge_defenderkillcount++;
    self util::player_contract_event("defender_kill");
    self waittilltimeoutordeath(4);
    if (self.challenge_defenderkillcount > 1) {
        self stats::function_b48aa4e(#"hash_505cdac7594d9abe", 1);
    }
    self.challenge_defenderkillcount = 0;
}

// Namespace challenges/challenges
// Params 1, eflags: 0x0
// Checksum 0xa60af776, Offset: 0x5028
// Size: 0x26
function waittilltimeoutordeath(timeout) {
    self endon(#"death");
    wait timeout;
}

// Namespace challenges/challenges
// Params 0, eflags: 0x0
// Checksum 0x4e275e46, Offset: 0x5058
// Size: 0x44
function killstreak_30_noscorestreaks() {
    if (level.gametype == "dm") {
        self stats::function_b48aa4e(#"killstreak_30_no_scorestreaks", 1);
    }
}

// Namespace challenges/challenges
// Params 0, eflags: 0x0
// Checksum 0xd6122e42, Offset: 0x50a8
// Size: 0xaa
function heroabilityactivateneardeath() {
    if (isdefined(self.heroability)) {
        switch (self.heroability.name) {
        case #"gadget_clone":
        case #"gadget_vision_pulse":
        case #"gadget_heat_wave":
        case #"gadget_armor":
        case #"gadget_speed_burst":
        case #"gadget_camo":
            self thread checkforherosurvival();
            break;
        }
    }
}

// Namespace challenges/challenges
// Params 0, eflags: 0x0
// Checksum 0x756bc9d8, Offset: 0x5160
// Size: 0x74
function checkforherosurvival() {
    self endon(#"death");
    self endon(#"disconnect");
    self waittilltimeout(8, #"challenge_survived_from_death", #"disconnect");
    self stats::function_b48aa4e(#"death_dodger", 1);
}

// Namespace challenges/challenges
// Params 0, eflags: 0x0
// Checksum 0x12dcccae, Offset: 0x51e0
// Size: 0xee
function function_3b36608e() {
    var_841da7da = self emp::enemyempowner();
    if (isdefined(var_841da7da) && isplayer(var_841da7da)) {
        var_841da7da stats::function_b48aa4e(#"hash_2b222f6f7b6e9a2", 1);
        return;
    }
    if (isdefined(self.empstarttime) && self.empstarttime > gettime() - 100) {
        if (isdefined(self.empedby) && isplayer(self.empedby)) {
            self.empedby stats::function_b48aa4e(#"hash_2b222f6f7b6e9a2", 1);
            return;
        }
    }
}

// Namespace challenges/challenges
// Params 0, eflags: 0x0
// Checksum 0x2cf53511, Offset: 0x52d8
// Size: 0xe
function calledincomlinkchopper() {
    self.challenge_offendercomlinkkillcount = 0;
}

// Namespace challenges/challenges
// Params 2, eflags: 0x0
// Checksum 0x67db0339, Offset: 0x52f0
// Size: 0x5e
function combat_robot_damage(eattacker, combatrobotowner) {
    if (!isdefined(eattacker.challenge_combatrobotattackclientid[combatrobotowner.clientid])) {
        eattacker.challenge_combatrobotattackclientid[combatrobotowner.clientid] = spawnstruct();
    }
}

// Namespace challenges/challenges
// Params 1, eflags: 0x0
// Checksum 0xe9785d93, Offset: 0x5358
// Size: 0x1bc
function trackkillstreaksupportkills(victim) {
    if (level.activeplayeruavs[self.entnum] > 0 && (!isdefined(level.forceradar) || level.forceradar == 0)) {
        self stats::function_4f10b697(getweapon(#"uav"), #"kills_while_active", 1);
    }
    if (isdefined(level.activeplayersatellites) && level.activeplayersatellites[self.entnum] > 0) {
        self stats::function_4f10b697(getweapon(#"satellite"), #"kills_while_active", 1);
    }
    if (level.activeplayercounteruavs[self.entnum] > 0) {
        self stats::function_4f10b697(getweapon(#"counteruav"), #"kills_while_active", 1);
    }
    if (isdefined(victim.lastmicrowavedby) && victim.lastmicrowavedby == self) {
        self stats::function_4f10b697(getweapon(#"microwave_turret"), #"kills_while_active", 1);
    }
}

// Namespace challenges/challenges
// Params 0, eflags: 0x0
// Checksum 0x8e156bf4, Offset: 0x5520
// Size: 0xbe
function monitorreloads() {
    self endon(#"disconnect");
    self endon(#"killmonitorreloads");
    while (true) {
        self waittill(#"reload");
        currentweapon = self getcurrentweapon();
        if (currentweapon == level.weaponnone) {
            continue;
        }
        time = gettime();
        self.lastreloadtime = time;
        if (weaponhasattachment(currentweapon, "fastreload")) {
            self.lastfastreloadtime = time;
        }
    }
}

// Namespace challenges/challenges
// Params 0, eflags: 0x0
// Checksum 0xc28e6d2b, Offset: 0x55e8
// Size: 0xfa
function monitorgrenadefire() {
    self notify(#"grenadetrackingstart");
    self endon(#"grenadetrackingstart");
    self endon(#"disconnect");
    for (;;) {
        waitresult = self waittill(#"grenade_fire");
        grenade = waitresult.projectile;
        weapon = waitresult.weapon;
        if (!isdefined(grenade)) {
            continue;
        }
        if (weapon.rootweapon.name == "hatchet") {
            self.challenge_hatchettosscount++;
            grenade.challenge_hatchettosscount = self.challenge_hatchettosscount;
        }
        if (self issprinting()) {
            grenade.ownerwassprinting = 1;
        }
    }
}

// Namespace challenges/challenges
// Params 0, eflags: 0x0
// Checksum 0xd266b29a, Offset: 0x56f0
// Size: 0x76
function watchweaponchangecomplete() {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"joined_team");
    self endon(#"joined_spectators");
    while (true) {
        self.heavyweaponkillsthisactivation = 0;
        self waittill(#"weapon_change_complete");
    }
}

// Namespace challenges/challenges
// Params 1, eflags: 0x0
// Checksum 0xbfa2e681, Offset: 0x5770
// Size: 0xac
function longdistancekillmp(weapon) {
    self stats::function_4f10b697(weapon, #"longshot_kill", 1);
    if (self weaponhasattachmentandunlocked(weapon, "extbarrel", "suppressed")) {
        if (self getweaponoptic(weapon) != "") {
            self stats::function_b48aa4e(#"long_shot_longbarrel_suppressor_optic", 1);
        }
    }
}

// Namespace challenges/challenges
// Params 0, eflags: 0x0
// Checksum 0xd8cc1dd9, Offset: 0x5828
// Size: 0x2ac
function function_de32795d() {
    player = self;
    player endon(#"death");
    player endon(#"disconnect");
    player endon(#"joined_team");
    player endon(#"joined_spectators");
    self.var_37509fac = 0;
    while (true) {
        if (!player iswallrunning()) {
            self.var_37509fac = 0;
            player waittill(#"wallrun_begin");
        }
        ret = player waittill(#"jump_begin", #"wallrun_end", #"disconnect", #"joined_team", #"joined_spectators");
        if (ret._notify == "wallrun_end") {
            continue;
        }
        wall_normal = player getwallrunwallnormal();
        player waittill(#"jump_end");
        if (!player iswallrunning()) {
            continue;
        }
        var_731104ea = wall_normal;
        wall_normal = player getwallrunwallnormal();
        var_5fcaadc = vectordot(wall_normal, var_731104ea) < -0.5;
        if (!var_5fcaadc) {
            continue;
        }
        player.var_37509fac = 1;
        while (player iswallrunning()) {
            ret = player waittill(#"jump_end", #"wallrun_end", #"joined_team", #"joined_spectators");
            if (ret._notify == "wallrun_end") {
                break;
            }
        }
        waitframe(1);
        while (!player isonground()) {
            waitframe(1);
        }
    }
}

// Namespace challenges/challenges
// Params 1, eflags: 0x0
// Checksum 0x9084db0, Offset: 0x5ae0
// Size: 0x2c
function processspecialistchallenge(statname) {
    self addspecialiststat(statname, 1);
}

// Namespace challenges/challenges
// Params 2, eflags: 0x0
// Checksum 0x71b8f7eb, Offset: 0x5b18
// Size: 0x86
function flakjacketprotectedmp(weapon, attacker) {
    if (weapon.name == #"claymore") {
        self.flakjacketclaymore[attacker.clientid] = 1;
    }
    self stats::function_b48aa4e(#"survive_with_flak", 1);
    self.challenge_lastsurvivewithflakfrom = attacker;
    self.challenge_lastsurvivewithflaktime = gettime();
}

// Namespace challenges/challenges
// Params 2, eflags: 0x4
// Checksum 0x2bd7bfd0, Offset: 0x5ba8
// Size: 0x46
function private function_a73e1cf7(slot_index, killed) {
    slot = self loadout::get_loadout_slot(slot_index);
    slot.killed = killed;
}

// Namespace challenges/challenges
// Params 1, eflags: 0x4
// Checksum 0xd3f3364b, Offset: 0x5bf8
// Size: 0x3a
function private function_6fe12e03(slot_index) {
    slot = self loadout::get_loadout_slot(slot_index);
    return slot.killed;
}

