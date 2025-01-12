#using scripts/core_common/abilities/gadgets/gadget_camo;
#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/killstreaks_shared;
#using scripts/core_common/scene_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace dialog_shared;

// Namespace dialog_shared/dialog_shared
// Params 0, eflags: 0x2
// Checksum 0x7750c2f8, Offset: 0x10a8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("dialog_shared", &__init__, undefined, undefined);
}

// Namespace dialog_shared/dialog_shared
// Params 0, eflags: 0x0
// Checksum 0x11e97f37, Offset: 0x10e8
// Size: 0x890
function __init__() {
    /#
        level thread devgui_think();
    #/
    callback::on_joined_team(&on_joined_team);
    callback::on_spawned(&on_player_spawned);
    callback::on_player_damage(&taking_fire_vox);
    level.heroplaydialog = &play_dialog;
    level.playgadgetready = &play_gadget_ready;
    level.playgadgetactivate = &play_gadget_activate;
    level.playgadgetsuccess = &play_gadget_success;
    level.playpromotionreaction = &play_promotion_reaction;
    level.playthrowhatchet = &play_throw_hatchet;
    level.playgadgetoff = &play_gadget_off;
    level.bcsounds = [];
    level.bcsounds["incoming_alert"] = [];
    level.bcsounds["incoming_alert"]["frag_grenade"] = "incomingFrag";
    level.bcsounds["incoming_alert"]["incendiary_grenade"] = "incomingIncendiary";
    level.bcsounds["incoming_alert"]["sticky_grenade"] = "incomingSemtex";
    level.bcsounds["incoming_alert"]["launcher_standard"] = "threatRpg";
    level.bcsounds["incoming_delay"] = [];
    level.bcsounds["incoming_delay"]["frag_grenade"] = "fragGrenadeDelay";
    level.bcsounds["incoming_delay"]["incendiary_grenade"] = "incendiaryGrenadeDelay";
    level.bcsounds["incoming_alert"]["sticky_grenade"] = "semtexDelay";
    level.bcsounds["incoming_delay"]["launcher_standard"] = "missileDelay";
    level.bcsounds["kill_dialog"] = [];
    level.bcsounds["kill_dialog"]["assassin"] = "killSpectre";
    level.bcsounds["kill_dialog"]["grenadier"] = "killGrenadier";
    level.bcsounds["kill_dialog"]["outrider"] = "killOutrider";
    level.bcsounds["kill_dialog"]["prophet"] = "killTechnomancer";
    level.bcsounds["kill_dialog"]["pyro"] = "killFirebreak";
    level.bcsounds["kill_dialog"]["reaper"] = "killReaper";
    level.bcsounds["kill_dialog"]["ruin"] = "killMercenary";
    level.bcsounds["kill_dialog"]["seraph"] = "killEnforcer";
    level.bcsounds["kill_dialog"]["trapper"] = "killTrapper";
    level.bcsounds["kill_dialog"]["blackjack"] = "killBlackjack";
    if (level.teambased && !isdefined(game.boostplayerspicked)) {
        game.boostplayerspicked = [];
        foreach (team in level.teams) {
            game.boostplayerspicked[team] = 0;
        }
    }
    level.allowbattlechatter = getgametypesetting("allowBattleChatter");
    clientfield::register("world", "boost_number", 1, 2, "int");
    clientfield::register("allplayers", "play_boost", 1, 2, "int");
    level thread pick_boost_number();
    playerdialogbundles = struct::get_script_bundles("mpdialog_player");
    foreach (bundle in playerdialogbundles) {
        count_keys(bundle, "killGeneric");
        count_keys(bundle, "killSniper");
        count_keys(bundle, "killSpectre");
        count_keys(bundle, "killGrenadier");
        count_keys(bundle, "killOutrider");
        count_keys(bundle, "killTechnomancer");
        count_keys(bundle, "killFirebreak");
        count_keys(bundle, "killReaper");
        count_keys(bundle, "killMercenary");
        count_keys(bundle, "killEnforcer");
        count_keys(bundle, "killTrapper");
        count_keys(bundle, "killBlackjack");
    }
    level.playerdialogbundles = playerdialogbundles;
    level.allowspecialistdialog = mpdialog_value("enableHeroDialog", 0) && level.allowbattlechatter;
    level.playstartconversation = mpdialog_value("enableConversation", 0) && level.allowbattlechatter;
    level.var_64428877 = spawn("script_origin", (0, 0, 0));
    level.var_ec79a8a4 = spawn("script_origin", (0, 0, 0));
}

// Namespace dialog_shared/dialog_shared
// Params 0, eflags: 0x0
// Checksum 0x4cd0567f, Offset: 0x1980
// Size: 0x92
function flush_dialog() {
    foreach (player in level.players) {
        player flush_dialog_on_player();
    }
}

// Namespace dialog_shared/dialog_shared
// Params 0, eflags: 0x0
// Checksum 0xa52428cf, Offset: 0x1a20
// Size: 0x42
function flush_dialog_on_player() {
    self.leaderdialogqueue = [];
    self.currentleaderdialog = undefined;
    self.killstreakdialogqueue = [];
    self.scorestreakdialogplaying = 0;
    self notify(#"flush_dialog");
}

// Namespace dialog_shared/dialog_shared
// Params 2, eflags: 0x0
// Checksum 0x60e33b1, Offset: 0x1a70
// Size: 0x96
function get_dialog_bundle_alias(dialogbundle, dialogkey) {
    if (!isdefined(dialogbundle) || !isdefined(dialogkey)) {
        return undefined;
    }
    dialogalias = dialogbundle.(dialogkey);
    if (!isdefined(dialogalias)) {
        return;
    }
    voiceprefix = dialogbundle.("voiceprefix");
    if (isdefined(voiceprefix)) {
        dialogalias = voiceprefix + dialogalias;
    }
    return dialogalias;
}

// Namespace dialog_shared/dialog_shared
// Params 0, eflags: 0x0
// Checksum 0xeba6281f, Offset: 0x1b10
// Size: 0x3c
function pick_boost_number() {
    wait 5;
    level clientfield::set("boost_number", randomint(4));
}

// Namespace dialog_shared/dialog_shared
// Params 0, eflags: 0x0
// Checksum 0x5da5954, Offset: 0x1b58
// Size: 0x144
function on_joined_team() {
    self endon(#"disconnect");
    if (level.teambased) {
        if (self.team == "allies") {
            self set_blops_dialog();
        } else {
            self set_cdp_dialog();
        }
    } else if (randomintrange(0, 2)) {
        self set_blops_dialog();
    } else {
        self set_cdp_dialog();
    }
    self flush_dialog();
    if (level.var_29d9f951 === 1) {
        return;
    }
    if (isdefined(level.inprematchperiod) && level.inprematchperiod && !(isdefined(self.pers["playedGameMode"]) && self.pers["playedGameMode"]) && isdefined(level.leaderdialog)) {
    }
}

// Namespace dialog_shared/dialog_shared
// Params 0, eflags: 0x0
// Checksum 0xddbbedc0, Offset: 0x1ca8
// Size: 0x3a
function set_blops_dialog() {
    self.pers["mptaacom"] = "blops_taacom";
    self.pers["mpcommander"] = "blops_commander";
}

// Namespace dialog_shared/dialog_shared
// Params 0, eflags: 0x0
// Checksum 0x40a6c996, Offset: 0x1cf0
// Size: 0x3a
function set_cdp_dialog() {
    self.pers["mptaacom"] = "cdp_taacom";
    self.pers["mpcommander"] = "cdp_commander";
}

// Namespace dialog_shared/dialog_shared
// Params 0, eflags: 0x0
// Checksum 0xbc5539e1, Offset: 0x1d38
// Size: 0x12c
function on_player_spawned() {
    self.enemythreattime = 0;
    self.heartbeatsnd = 0;
    self.soundmod = "player";
    self.voxunderwatertime = 0;
    self.voxemergebreath = 0;
    self.voxdrowning = 0;
    self.pilotisspeaking = 0;
    self.playingdialog = 0;
    self.playinggadgetreadydialog = 0;
    self.playedgadgetsuccess = 1;
    if (level.splitscreen) {
        return;
    }
    self thread water_vox();
    self thread grenade_tracking();
    self thread missile_tracking();
    self thread sticky_grenade_tracking();
    if (level.teambased) {
        self thread enemy_threat();
        self thread check_boost_start_conversation();
    }
}

// Namespace dialog_shared/dialog_shared
// Params 1, eflags: 0x0
// Checksum 0xa3101d41, Offset: 0x1e70
// Size: 0x80
function dialog_chance(chancekey) {
    dialogchance = mpdialog_value(chancekey);
    if (!isdefined(dialogchance) || dialogchance <= 0) {
        return false;
    } else if (dialogchance >= 100) {
        return true;
    }
    return randomint(100) < dialogchance;
}

// Namespace dialog_shared/dialog_shared
// Params 2, eflags: 0x0
// Checksum 0xbd95a022, Offset: 0x1ef8
// Size: 0x90
function mpdialog_value(mpdialogkey, defaultvalue) {
    if (!isdefined(mpdialogkey)) {
        return defaultvalue;
    }
    mpdialog = struct::get_script_bundle("mpdialog", "mpdialog_default");
    if (!isdefined(mpdialog)) {
        return defaultvalue;
    }
    structvalue = mpdialog.(mpdialogkey);
    if (!isdefined(structvalue)) {
        return defaultvalue;
    }
    return structvalue;
}

// Namespace dialog_shared/dialog_shared
// Params 0, eflags: 0x0
// Checksum 0x8c240a4, Offset: 0x1f90
// Size: 0x214
function water_vox() {
    self endon(#"death");
    level endon(#"game_ended");
    interval = mpdialog_value("underwaterInterval", 0.05);
    if (interval <= 0) {
        /#
            assert(interval > 0, "<dev string:x28>");
        #/
        return;
    }
    while (true) {
        wait interval;
        if (self isplayerunderwater()) {
            if (!self.voxunderwatertime && !self.voxemergebreath) {
                self stopsounds();
                self.voxunderwatertime = gettime();
            } else if (self.voxunderwatertime) {
                if (gettime() > self.voxunderwatertime + mpdialog_value("underwaterBreathTime", 0) * 1000) {
                    self.voxunderwatertime = 0;
                    self.voxemergebreath = 1;
                }
            }
            continue;
        }
        if (self.voxdrowning) {
            self thread play_dialog("exertEmergeGasp", 20, mpdialog_value("playerExertBuffer", 0));
            self.voxdrowning = 0;
            self.voxemergebreath = 0;
            continue;
        }
        if (self.voxemergebreath) {
            self thread play_dialog("exertEmergeBreath", 20, mpdialog_value("playerExertBuffer", 0));
            self.voxemergebreath = 0;
        }
    }
}

// Namespace dialog_shared/dialog_shared
// Params 1, eflags: 0x0
// Checksum 0xd0f54dca, Offset: 0x21b0
// Size: 0x134
function taking_fire_vox(params) {
    if (isai(params.eattacker) || isvehicle(params.eattacker) || isdefined(params.eattacker) && isplayer(params.eattacker)) {
        if (isdefined(params.eattacker.team) && self.team !== params.eattacker.team) {
            takingfire_cooldown = "taking_fire_vo_" + self.team;
            if (level util::iscooldownready(takingfire_cooldown)) {
                self play_dialog("takingFire", 1);
                level util::cooldown(takingfire_cooldown, 5);
            }
        }
    }
}

// Namespace dialog_shared/dialog_shared
// Params 1, eflags: 0x0
// Checksum 0xf5974c0a, Offset: 0x22f0
// Size: 0xfc
function pain_vox(meansofdeath) {
    if (dialog_chance("smallPainChance")) {
        if (meansofdeath == "MOD_DROWN") {
            dialogkey = "exertPainDrowning";
            self.voxdrowning = 1;
        } else if (meansofdeath == "MOD_FALLING") {
            dialogkey = "exertPainFalling";
        } else if (self isplayerunderwater()) {
            dialogkey = "exertPainUnderwater";
        } else {
            dialogkey = "exertPain";
        }
        exertbuffer = mpdialog_value("playerExertBuffer", 0);
        self thread play_dialog(dialogkey, 30, exertbuffer);
    }
}

// Namespace dialog_shared/dialog_shared
// Params 2, eflags: 0x0
// Checksum 0xff62a186, Offset: 0x23f8
// Size: 0x40
function on_player_suicide_or_team_kill(player, type) {
    self endon(#"death");
    level endon(#"game_ended");
    waittillframeend();
    if (!level.teambased) {
        return;
    }
}

// Namespace dialog_shared/dialog_shared
// Params 2, eflags: 0x0
// Checksum 0x27e5c06d, Offset: 0x2440
// Size: 0x2e
function on_player_near_explodable(object, type) {
    self endon(#"death");
    level endon(#"game_ended");
}

// Namespace dialog_shared/dialog_shared
// Params 0, eflags: 0x0
// Checksum 0xc3b15869, Offset: 0x2478
// Size: 0x28c
function enemy_threat() {
    self endon(#"death");
    level endon(#"game_ended");
    while (true) {
        self waittill("weapon_ads");
        if (self hasperk("specialty_quieter")) {
            continue;
        }
        if (self.enemythreattime + mpdialog_value("enemyContactInterval", 0) * 1000 >= gettime()) {
            continue;
        }
        closest_ally = self get_closest_player_ally(1);
        if (!isdefined(closest_ally)) {
            continue;
        }
        allyradius = mpdialog_value("enemyContactAllyRadius", 0);
        if (distancesquared(self.origin, closest_ally.origin) < allyradius * allyradius) {
            eyepoint = self geteye();
            dir = anglestoforward(self getplayerangles());
            dir *= mpdialog_value("enemyContactDistance", 0);
            endpoint = eyepoint + dir;
            traceresult = bullettrace(eyepoint, endpoint, 1, self);
            if (isdefined(traceresult["entity"]) && traceresult["entity"].classname == "player" && traceresult["entity"].team != self.team) {
                if (dialog_chance("enemyContactChance")) {
                    self thread play_dialog("threatInfantry", 1);
                    level notify(#"level_enemy_spotted", self.team);
                    self.enemythreattime = gettime();
                }
            }
        }
    }
}

// Namespace dialog_shared/dialog_shared
// Params 1, eflags: 0x0
// Checksum 0xbe55e907, Offset: 0x2710
// Size: 0x280
function killed_by_sniper(sniper) {
    self endon(#"disconnect");
    sniper endon(#"disconnect");
    level endon(#"game_ended");
    if (!level.teambased) {
        return 0;
    }
    waittillframeend();
    if (dialog_chance("sniperKillChance")) {
        closest_ally = self get_closest_player_ally();
        allyradius = mpdialog_value("sniperKillAllyRadius", 0);
        if (isdefined(closest_ally) && distancesquared(self.origin, closest_ally.origin) < allyradius * allyradius) {
            closest_ally thread play_dialog("threatSniper", 1);
            sniper.spottedtime = gettime();
            sniper.spottedby = [];
            players = self get_friendly_players();
            players = arraysort(players, self.origin);
            voiceradius = mpdialog_value("playerVoiceRadius", 0);
            voiceradiussq = voiceradius * voiceradius;
            foreach (player in players) {
                if (distancesquared(closest_ally.origin, player.origin) <= voiceradiussq) {
                    sniper.spottedby[sniper.spottedby.size] = player;
                }
            }
        }
    }
}

// Namespace dialog_shared/dialog_shared
// Params 2, eflags: 0x0
// Checksum 0x5b6e24ee, Offset: 0x2998
// Size: 0x164
function player_killed(attacker, killstreaktype) {
    if (!level.teambased) {
        return;
    }
    if (self === attacker) {
        return;
    }
    waittillframeend();
    if (isdefined(killstreaktype)) {
        if (!isdefined(level.killstreaks[killstreaktype]) || !isdefined(level.killstreaks[killstreaktype].threatonkill) || !level.killstreaks[killstreaktype].threatonkill || !dialog_chance("killstreakKillChance")) {
            return;
        }
        ally = get_closest_player_ally(1);
        allyradius = mpdialog_value("killstreakKillAllyRadius", 0);
        if (isdefined(ally) && distancesquared(self.origin, ally.origin) < allyradius * allyradius) {
            ally play_killstreak_threat(killstreaktype);
        }
    }
}

// Namespace dialog_shared/dialog_shared
// Params 3, eflags: 0x0
// Checksum 0x6a03a57e, Offset: 0x2b08
// Size: 0xe4
function heavyweaponkilllogic(attacker, weapon, victim) {
    if (!isdefined(attacker.heavyweaponkillcount)) {
        attacker.heavyweaponkillcount = 0;
    }
    attacker.heavyweaponkillcount++;
    if (!(isdefined(attacker.playedgadgetsuccess) && attacker.playedgadgetsuccess) && attacker.heavyweaponkillcount >= mpdialog_value("heroWeaponKillCount", 0)) {
        attacker thread play_gadget_success(weapon, "enemyKillDelay", victim);
        attacker thread heavy_weapon_success_reaction();
    }
}

// Namespace dialog_shared/dialog_shared
// Params 4, eflags: 0x0
// Checksum 0x5f0e1c05, Offset: 0x2bf8
// Size: 0x90
function playkillbattlechatter(attacker, weapon, victim, einflictor) {
    if (isplayer(attacker)) {
        level thread say_kill_battle_chatter(attacker, weapon, victim, einflictor);
    }
    if (isdefined(einflictor)) {
        einflictor notify(#"bhtn_action_notify", {#action:"attack_kill"});
    }
}

// Namespace dialog_shared/dialog_shared
// Params 4, eflags: 0x0
// Checksum 0x13b143ee, Offset: 0x2c90
// Size: 0x4b4
function say_kill_battle_chatter(attacker, weapon, victim, inflictor) {
    if (weapon.skipbattlechatterkill || !isdefined(attacker) || !isplayer(attacker) || !isalive(attacker) || attacker isremotecontrolling() || attacker isinvehicle() || attacker isweaponviewonlylinked() || !isdefined(victim) || !isplayer(victim)) {
        return;
    }
    if (isdefined(inflictor) && !isplayer(inflictor) && inflictor.birthtime < attacker.spawntime) {
        return;
    }
    if (weapon.isheavyweapon) {
        heavyweaponkilllogic(attacker, weapon, victim);
    } else if (isdefined(attacker.speedburston) && attacker.speedburston) {
        if (!(isdefined(attacker.speedburstkill) && attacker.speedburstkill)) {
            speedburstkilldist = mpdialog_value("speedBurstKillDistance", 0);
            if (distancesquared(attacker.origin, victim.origin) < speedburstkilldist * speedburstkilldist) {
                attacker.speedburstkill = 1;
            }
        }
    } else if (isdefined(attacker.var_9b8eaff2) && (attacker gadget_camo::function_6b246a0f() || attacker.var_9b8eaff2 + mpdialog_value("camoKillTime", 0) * 1000 >= gettime())) {
        if (!(isdefined(attacker.playedgadgetsuccess) && attacker.playedgadgetsuccess)) {
            attacker thread play_gadget_success(getweapon("gadget_camo"), "enemyKillDelay", victim);
        }
    } else if (dialog_chance("enemyKillChance")) {
        if (isdefined(victim.spottedtime) && victim.spottedtime + mpdialog_value("enemySniperKillTime", 0) >= gettime() && array::contains(victim.spottedby, attacker) && dialog_chance("enemySniperKillChance")) {
            killdialog = attacker get_random_key("killSniper");
        } else if (dialog_chance("enemyHeroKillChance")) {
            victimdialogname = victim getmpdialogname();
            killdialog = attacker get_random_key(level.bcsounds["kill_dialog"][victimdialogname]);
        } else {
            killdialog = attacker get_random_key("killGeneric");
        }
    }
    victim.spottedtime = undefined;
    victim.spottedby = undefined;
    if (!isdefined(killdialog)) {
        return;
    }
    attacker thread wait_play_dialog(mpdialog_value("enemyKillDelay", 0), killdialog, 1, undefined, victim, "cancel_kill_dialog");
}

// Namespace dialog_shared/dialog_shared
// Params 0, eflags: 0x0
// Checksum 0x83ebd03e, Offset: 0x3150
// Size: 0x198
function grenade_tracking() {
    self endon(#"death");
    level endon(#"game_ended");
    while (true) {
        waitresult = self waittill("grenade_fire");
        grenade = waitresult.projectile;
        weapon = waitresult.weapon;
        if (!isdefined(grenade.weapon) || !isdefined(grenade.weapon.rootweapon) || !dialog_chance("incomingProjectileChance")) {
            continue;
        }
        dialogkey = level.bcsounds["incoming_alert"][grenade.weapon.rootweapon.name];
        if (isdefined(dialogkey)) {
            waittime = mpdialog_value(level.bcsounds["incoming_delay"][grenade.weapon.rootweapon.name], 0.05);
            level thread incoming_projectile_alert(self, grenade, dialogkey, waittime);
        }
    }
}

// Namespace dialog_shared/dialog_shared
// Params 0, eflags: 0x0
// Checksum 0xc7b776ad, Offset: 0x32f0
// Size: 0x178
function missile_tracking() {
    self endon(#"death");
    level endon(#"game_ended");
    while (true) {
        waitresult = self waittill("missile_fire");
        missile = waitresult.projectile;
        if (!isdefined(missile.item) || !isdefined(missile.item.rootweapon) || !dialog_chance("incomingProjectileChance")) {
            continue;
        }
        dialogkey = level.bcsounds["incoming_alert"][missile.item.rootweapon.name];
        if (isdefined(dialogkey)) {
            waittime = mpdialog_value(level.bcsounds["incoming_delay"][missile.item.rootweapon.name], 0.05);
            level thread incoming_projectile_alert(self, missile, dialogkey, waittime);
        }
    }
}

// Namespace dialog_shared/dialog_shared
// Params 4, eflags: 0x0
// Checksum 0x3c0bab4e, Offset: 0x3470
// Size: 0x19a
function incoming_projectile_alert(thrower, projectile, dialogkey, waittime) {
    level endon(#"game_ended");
    if (waittime <= 0) {
        /#
            assert(waittime > 0, "<dev string:x6e>");
        #/
        return;
    }
    while (true) {
        wait waittime;
        if (waittime > 0.2) {
            waittime /= 2;
        }
        if (!isdefined(projectile)) {
            return;
        }
        if (!isdefined(thrower) || thrower.team == "spectator") {
            return;
        }
        if (level.players.size) {
            closest_enemy = thrower get_closest_player_enemy(projectile.origin);
            incomingprojectileradius = mpdialog_value("incomingProjectileRadius", 0);
            if (isdefined(closest_enemy) && distancesquared(projectile.origin, closest_enemy.origin) < incomingprojectileradius * incomingprojectileradius) {
                closest_enemy thread play_dialog(dialogkey, 6);
                return;
            }
        }
    }
}

// Namespace dialog_shared/dialog_shared
// Params 0, eflags: 0x0
// Checksum 0xcae4dc2a, Offset: 0x3618
// Size: 0xe8
function sticky_grenade_tracking() {
    self endon(#"death");
    level endon(#"game_ended");
    while (true) {
        waitresult = self waittill("grenade_stuck");
        grenade = waitresult.projectile;
        if (isalive(self) && isdefined(grenade) && isdefined(grenade.weapon)) {
            if (grenade.weapon.rootweapon.name == "sticky_grenade") {
                self thread play_dialog("stuckSticky", 6);
            }
        }
    }
}

// Namespace dialog_shared/dialog_shared
// Params 0, eflags: 0x0
// Checksum 0x3e4d4970, Offset: 0x3708
// Size: 0x386
function heavy_weapon_success_reaction() {
    self endon(#"death");
    level endon(#"game_ended");
    if (!level.teambased) {
        return;
    }
    allies = [];
    allyradiussq = mpdialog_value("playerVoiceRadius", 0);
    allyradiussq *= allyradiussq;
    foreach (player in level.players) {
        if (!isdefined(player) || !isalive(player) || player.sessionstate != "playing" || player == self || player.team != self.team) {
            continue;
        }
        distsq = distancesquared(self.origin, player.origin);
        if (distsq > allyradiussq) {
            continue;
        }
        allies[allies.size] = player;
    }
    wait mpdialog_value("enemyKillDelay", 0) + 0.1;
    while (self.playingdialog) {
        wait 0.5;
    }
    allies = arraysort(allies, self.origin);
    foreach (player in allies) {
        if (!isalive(player) || player.sessionstate != "playing" || player.playingdialog || player isplayerunderwater() || player isremotecontrolling() || player isinvehicle() || player isweaponviewonlylinked()) {
            continue;
        }
        distsq = distancesquared(self.origin, player.origin);
        if (distsq > allyradiussq) {
            break;
        }
        player play_dialog("heroWeaponSuccessReaction", 1);
        break;
    }
}

// Namespace dialog_shared/dialog_shared
// Params 0, eflags: 0x0
// Checksum 0xf3b1818a, Offset: 0x3a98
// Size: 0x26c
function play_promotion_reaction() {
    self endon(#"death");
    level endon(#"game_ended");
    if (!level.teambased) {
        return;
    }
    wait 9;
    players = self get_friendly_players();
    players = arraysort(players, self.origin);
    selfdialog = self getmpdialogname();
    voiceradius = mpdialog_value("playerVoiceRadius", 0);
    voiceradiussq = voiceradius * voiceradius;
    foreach (player in players) {
        if (player == self || player getmpdialogname() == selfdialog || !player can_play_dialog(1) || distancesquared(self.origin, player.origin) >= voiceradiussq) {
            continue;
        }
        dialogalias = player get_player_dialog_alias("promotionReaction");
        if (!isdefined(dialogalias)) {
            continue;
        }
        ally = player;
        break;
    }
    if (isdefined(ally)) {
        ally playsoundontag(dialogalias, "J_Head", undefined, self);
        ally thread wait_dialog_buffer(mpdialog_value("playerDialogBuffer", 0));
    }
}

// Namespace dialog_shared/dialog_shared
// Params 2, eflags: 0x0
// Checksum 0xf3fc1f39, Offset: 0x3d10
// Size: 0x2e
function gametype_specific_battle_chatter(event, team) {
    self endon(#"death");
    level endon(#"game_ended");
}

// Namespace dialog_shared/dialog_shared
// Params 0, eflags: 0x0
// Checksum 0x4c46cec6, Offset: 0x3d48
// Size: 0x3c
function play_laststand_vox() {
    dialogkey = "laststandDown";
    if (isdefined(dialogkey)) {
        self play_dialog(dialogkey, 1);
    }
}

// Namespace dialog_shared/dialog_shared
// Params 4, eflags: 0x0
// Checksum 0x6fc06ec1, Offset: 0x3d90
// Size: 0xa4
function play_death_vox(body, attacker, weapon, meansofdeath) {
    dialogkey = self get_death_vox(weapon, meansofdeath);
    dialogalias = self get_player_dialog_alias(dialogkey);
    if (isdefined(dialogalias)) {
        body playsoundontag(dialogalias, "J_Head");
    }
}

// Namespace dialog_shared/dialog_shared
// Params 2, eflags: 0x0
// Checksum 0x8ff94bb8, Offset: 0x3e40
// Size: 0xfe
function get_death_vox(weapon, meansofdeath) {
    if (self isplayerunderwater()) {
        return "exertDeathDrowned";
    }
    if (isdefined(meansofdeath)) {
        switch (meansofdeath) {
        case #"mod_burned":
            return "exertDeathBurned";
        case #"mod_drown":
            return "exertDeathDrowned";
        }
    }
    if (isdefined(weapon) && meansofdeath !== "MOD_MELEE_WEAPON_BUTT") {
        switch (weapon.rootweapon.name) {
        case #"hatchet":
        case #"hero_armblade":
        case #"knife_loadout":
            return "exertDeathStabbed";
        case #"hero_firefly_swarm":
            return "exertDeathBurned";
        case #"hero_lightninggun_arc":
            return "exertDeathElectrocuted";
        }
    }
    return "exertDeath";
}

// Namespace dialog_shared/dialog_shared
// Params 1, eflags: 0x0
// Checksum 0xf0881809, Offset: 0x3f48
// Size: 0x64
function play_killstreak_threat(killstreaktype) {
    if (!isdefined(killstreaktype) || !isdefined(level.killstreaks[killstreaktype])) {
        return;
    }
    self thread play_dialog(level.killstreaks[killstreaktype].threatdialogkey, 1);
}

// Namespace dialog_shared/dialog_shared
// Params 6, eflags: 0x0
// Checksum 0xf4677f8c, Offset: 0x3fb8
// Size: 0xa4
function wait_play_dialog(waittime, dialogkey, dialogflags, dialogbuffer, enemy, endnotify) {
    self endon(#"death");
    level endon(#"game_ended");
    if (isdefined(waittime) && waittime > 0) {
        if (isdefined(endnotify)) {
            self endon(endnotify);
        }
        wait waittime;
    }
    self thread play_dialog(dialogkey, dialogflags, dialogbuffer, enemy);
}

// Namespace dialog_shared/dialog_shared
// Params 4, eflags: 0x0
// Checksum 0x6ba8c084, Offset: 0x4068
// Size: 0x4f4
function play_dialog(dialogkey, dialogflags, dialogbuffer, enemy) {
    self endon(#"death");
    level endon(#"game_ended");
    if (level flag::exists("intro_igcs_done")) {
        if (!level flag::get("intro_igcs_done")) {
            return;
        }
    } else if (isdefined(mission)) {
        if (!mission flag::exists("intro_igcs_done") || !mission flag::get("intro_igcs_done")) {
            return;
        }
    } else {
        return;
    }
    if (!isdefined(dialogkey) || !isplayer(self) || !isalive(self) || level.gameended) {
        return;
    }
    global_cooldown = "global_" + self.team;
    charactertype_cooldown = "character_" + self getmpdialogname() + self.team;
    if (!level util::iscooldownready(global_cooldown) || !level util::iscooldownready(charactertype_cooldown)) {
        return;
    }
    level util::cooldown(global_cooldown, 0.9);
    level util::cooldown(charactertype_cooldown, 2.5);
    if (self scene::is_igc_active()) {
        return;
    }
    if (level flagsys::get("chyron_active")) {
        return;
    }
    if (isdefined(self.team) && level flagsys::get("dialog_mutex_" + self.team)) {
        return;
    }
    if (!isdefined(dialogflags)) {
        dialogflags = 0;
    }
    if (!level.allowspecialistdialog && (dialogflags & 16) == 0) {
        return;
    }
    if (!isdefined(dialogbuffer)) {
        dialogbuffer = mpdialog_value("playerDialogBuffer", 0);
    }
    dialogalias = self get_player_dialog_alias(dialogkey);
    if (!isdefined(dialogalias)) {
        return;
    }
    if (self isplayerunderwater() && !(dialogflags & 8)) {
        return;
    }
    if (self.playingdialog) {
        if (!(dialogflags & 4)) {
            return;
        }
        self stopsounds();
        waitframe(1);
    }
    if (dialogflags & 32) {
        self.playinggadgetreadydialog = 1;
    }
    if (dialogflags & 64) {
        if (!isdefined(self.stolendialogindex)) {
            self.stolendialogindex = 0;
        }
        dialogalias = dialogalias + "_0" + self.stolendialogindex;
        self.stolendialogindex++;
        self.stolendialogindex %= 4;
    }
    if (dialogflags & 2) {
        self playsoundontag(dialogalias, "J_Head");
    } else if (dialogflags & 1) {
        if (isdefined(enemy)) {
            self playsoundontag(dialogalias, "J_Head", self.team, enemy);
        } else {
            self playsoundontag(dialogalias, "J_Head", self.team);
        }
    } else {
        self playlocalsound(dialogalias);
    }
    self notify(#"played_dialog");
    self thread wait_dialog_buffer(dialogbuffer);
}

// Namespace dialog_shared/dialog_shared
// Params 1, eflags: 0x0
// Checksum 0x916a63dd, Offset: 0x4568
// Size: 0x80
function wait_dialog_buffer(dialogbuffer) {
    self endon(#"death");
    self endon(#"played_dialog");
    self endon(#"stop_dialog");
    level endon(#"game_ended");
    self.playingdialog = 1;
    if (isdefined(dialogbuffer) && dialogbuffer > 0) {
        wait dialogbuffer;
    }
    self.playingdialog = 0;
    self.playinggadgetreadydialog = 0;
}

// Namespace dialog_shared/dialog_shared
// Params 0, eflags: 0x0
// Checksum 0xf1960f9e, Offset: 0x45f0
// Size: 0x3c
function stop_dialog() {
    self notify(#"stop_dialog");
    self stopsounds();
    self.playingdialog = 0;
    self.playinggadgetreadydialog = 0;
}

// Namespace dialog_shared/dialog_shared
// Params 1, eflags: 0x0
// Checksum 0xb67203b8, Offset: 0x4638
// Size: 0xc
function wait_playback_time(soundalias) {
    
}

// Namespace dialog_shared/dialog_shared
// Params 1, eflags: 0x0
// Checksum 0xcf8f14a1, Offset: 0x4650
// Size: 0xaa
function get_player_dialog_alias(dialogkey) {
    if (!isplayer(self)) {
        return undefined;
    }
    bundlename = self getmpdialogname();
    if (!isdefined(bundlename)) {
        return undefined;
    }
    playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
    if (!isdefined(playerbundle)) {
        return undefined;
    }
    return get_dialog_bundle_alias(playerbundle, dialogkey);
}

// Namespace dialog_shared/dialog_shared
// Params 2, eflags: 0x0
// Checksum 0x8ce7d7ac, Offset: 0x4708
// Size: 0xe6
function count_keys(bundle, dialogkey) {
    i = 0;
    field = dialogkey + i;
    for (fieldvalue = bundle.(field); isdefined(fieldvalue); fieldvalue = bundle.(field)) {
        aliasarray[i] = fieldvalue;
        i++;
        field = dialogkey + i;
    }
    if (!isdefined(bundle.keycounts)) {
        bundle.keycounts = [];
    }
    bundle.keycounts[dialogkey] = i;
}

// Namespace dialog_shared/dialog_shared
// Params 1, eflags: 0x0
// Checksum 0x82cd912a, Offset: 0x47f8
// Size: 0xd4
function get_random_key(dialogkey) {
    bundlename = self getmpdialogname();
    if (!isdefined(bundlename)) {
        return undefined;
    }
    playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
    if (!isdefined(playerbundle) || !isdefined(playerbundle.keycounts) || !isdefined(playerbundle.keycounts[dialogkey])) {
        return dialogkey;
    }
    return dialogkey + randomint(playerbundle.keycounts[dialogkey]);
}

// Namespace dialog_shared/dialog_shared
// Params 2, eflags: 0x0
// Checksum 0xab7acb1b, Offset: 0x48d8
// Size: 0x56c
function play_gadget_ready(weapon, userflip) {
    if (!isdefined(userflip)) {
        userflip = 0;
    }
    if (!isdefined(weapon)) {
        return;
    }
    dialogkey = undefined;
    switch (weapon.name) {
    case #"hero_gravityspikes":
        dialogkey = "gravspikesWeaponReady";
        break;
    case #"gadget_speed_burst":
        dialogkey = "overdriveAbilityReady";
        break;
    case #"hero_bowlauncher":
    case #"hero_bowlauncher2":
    case #"hero_bowlauncher3":
    case #"hero_bowlauncher4":
        dialogkey = "sparrowWeaponReady";
        break;
    case #"gadget_vision_pulse":
        dialogkey = "visionpulseAbilityReady";
        break;
    case #"hero_lightninggun":
    case #"hero_lightninggun_arc":
        dialogkey = "tempestWeaponReady";
        break;
    case #"hash_9334d6bb":
        dialogkey = "glitchAbilityReady";
        break;
    case #"hero_pineapplegun":
    case #"hero_pineapplegun_companion":
        dialogkey = "warmachineWeaponREady";
        break;
    case #"gadget_armor":
        dialogkey = "kineticArmorAbilityReady";
        break;
    case #"hero_annihilator":
        dialogkey = "annihilatorWeaponReady";
        break;
    case #"gadget_combat_efficiency":
        dialogkey = "combatfocusAbilityReady";
        break;
    case #"hero_chemicalgelgun":
        dialogkey = "hiveWeaponReady";
        break;
    case #"gadget_resurrect":
        dialogkey = "rejackAbilityReady";
        break;
    case #"hero_minigun":
        dialogkey = "scytheWeaponReady";
        break;
    case #"gadget_clone":
        dialogkey = "psychosisAbilityReady";
        break;
    case #"hero_armblade":
        dialogkey = "ripperWeaponReady";
        break;
    case #"gadget_camo":
        dialogkey = "activeCamoAbilityReady";
        break;
    case #"hero_flamethrower":
        dialogkey = "purifierWeaponReady";
        break;
    case #"gadget_heat_wave":
        dialogkey = "heatwaveAbilityReady";
        break;
    default:
        return;
    }
    if (!(isdefined(self.isthief) && self.isthief) && !(isdefined(self.isroulette) && self.isroulette)) {
        dialogflags = undefined;
        if (self util::function_4f5dd9d2()) {
            dialogflags = 1;
        }
        self thread play_dialog(dialogkey, dialogflags);
        return;
    }
    waittime = 0;
    dialogflags = 32;
    if (userflip) {
        minwaittime = 0;
        if (self.playinggadgetreadydialog) {
            self stop_dialog();
            minwaittime = 0.05;
        }
        if (isdefined(self.isthief) && self.isthief) {
            delaykey = "thiefFlipDelay";
        } else {
            delaykey = "rouletteFlipDelay";
        }
        waittime = mpdialog_value(delaykey, minwaittime);
        dialogflags += 64;
    } else {
        if (isdefined(self.isthief) && self.isthief) {
            generickey = "thiefWeaponReady";
            repeatkey = "thiefWeaponRepeat";
            repeatthresholdkey = "thiefRepeatThreshold";
            chancekey = "thiefReadyChance";
            delaykey = "thiefRevealDelay";
        } else {
            generickey = "rouletteAbilityReady";
            repeatkey = "rouletteAbilityRepeat";
            repeatthresholdkey = "rouletteRepeatThreshold";
            chancekey = "rouletteReadyChance";
            delaykey = "rouletteRevealDelay";
        }
        if (randomint(100) < mpdialog_value(chancekey, 0)) {
            dialogkey = generickey;
        } else {
            waittime = mpdialog_value(delaykey, 0);
            if (self.laststolengadget === weapon && self.laststolengadgettime + mpdialog_value(repeatthresholdkey, 0) * 1000 > gettime()) {
                dialogkey = repeatkey;
            } else {
                dialogflags += 64;
            }
        }
    }
    self.laststolengadget = weapon;
    self.laststolengadgettime = gettime();
    if (waittime) {
        self notify(#"cancel_kill_dialog");
    }
    self thread wait_play_dialog(waittime, dialogkey, dialogflags);
}

// Namespace dialog_shared/dialog_shared
// Params 1, eflags: 0x0
// Checksum 0x3b830b91, Offset: 0x4e50
// Size: 0x2ac
function play_gadget_activate(weapon) {
    if (!isdefined(weapon)) {
        return;
    }
    dialogkey = undefined;
    switch (weapon.name) {
    case #"hero_gravityspikes":
        dialogkey = "gravspikesWeaponUse";
        dialogflags = 22;
        dialogbuffer = 0.05;
        break;
    case #"gadget_speed_burst":
        dialogkey = "overdriveAbilityUse";
        break;
    case #"hero_bowlauncher":
    case #"hero_bowlauncher2":
    case #"hero_bowlauncher3":
    case #"hero_bowlauncher4":
        dialogkey = "sparrowWeaponUse";
        break;
    case #"gadget_vision_pulse":
        dialogkey = "visionpulseAbilityUse";
        break;
    case #"hero_lightninggun":
    case #"hero_lightninggun_arc":
        dialogkey = "tempestWeaponUse";
        break;
    case #"hash_9334d6bb":
        dialogkey = "glitchAbilityUse";
        break;
    case #"hero_pineapplegun":
    case #"hero_pineapplegun_companion":
        dialogkey = "warmachineWeaponUse";
        break;
    case #"gadget_armor":
        dialogkey = "kineticArmorAbilityUse";
        break;
    case #"hero_annihilator":
        dialogkey = "annihilatorWeaponUse";
        break;
    case #"gadget_combat_efficiency":
        dialogkey = "combatfocusAbilityUse";
        break;
    case #"hero_chemicalgelgun":
        dialogkey = "hiveWeaponUse";
        break;
    case #"gadget_resurrect":
        dialogkey = "rejackAbilityUse";
        break;
    case #"hero_minigun":
        dialogkey = "scytheWeaponUse";
        break;
    case #"gadget_clone":
        dialogkey = "psychosisAbilityUse";
        break;
    case #"hero_armblade":
        dialogkey = "ripperWeaponUse";
        break;
    case #"gadget_camo":
        dialogkey = "activeCamoAbilityUse";
        break;
    case #"hero_flamethrower":
        dialogkey = "purifierWeaponUse";
        break;
    case #"gadget_heat_wave":
        dialogkey = "heatwaveAbilityUse";
        break;
    default:
        return;
    }
    if (self util::function_4f5dd9d2()) {
        if (isdefined(dialogflags)) {
            dialogflags |= 1;
        } else {
            dialogflags = 1;
        }
    }
    self thread play_dialog(dialogkey, dialogflags, dialogbuffer);
}

// Namespace dialog_shared/dialog_shared
// Params 3, eflags: 0x0
// Checksum 0x69c90e90, Offset: 0x5108
// Size: 0x2ac
function play_gadget_success(weapon, waitkey, victim) {
    if (!isdefined(weapon)) {
        return;
    }
    dialogkey = undefined;
    switch (weapon.name) {
    case #"hero_gravityspikes":
        dialogkey = "gravspikesWeaponSuccess";
        break;
    case #"gadget_speed_burst":
        dialogkey = "overdriveAbilitySuccess";
        break;
    case #"hero_bowlauncher":
    case #"hero_bowlauncher2":
    case #"hero_bowlauncher3":
    case #"hero_bowlauncher4":
        dialogkey = "sparrowWeaponSuccess";
        break;
    case #"gadget_vision_pulse":
        dialogkey = "visionpulseAbilitySuccess";
        break;
    case #"hero_lightninggun":
    case #"hero_lightninggun_arc":
        dialogkey = "tempestWeaponSuccess";
        break;
    case #"hash_9334d6bb":
        dialogkey = "glitchAbilitySuccess";
        break;
    case #"hero_pineapplegun":
    case #"hero_pineapplegun_companion":
        dialogkey = "warmachineWeaponSuccess";
        break;
    case #"gadget_armor":
        dialogkey = "kineticArmorAbilitySuccess";
        break;
    case #"hero_annihilator":
        dialogkey = "annihilatorWeaponSuccess";
        break;
    case #"gadget_combat_efficiency":
        dialogkey = "combatfocusAbilitySuccess";
        break;
    case #"hero_chemicalgelgun":
        dialogkey = "hiveWeaponSuccess";
        break;
    case #"gadget_resurrect":
        dialogkey = "rejackAbilitySuccess";
        break;
    case #"hero_minigun":
        dialogkey = "scytheWeaponSuccess";
        break;
    case #"gadget_clone":
        dialogkey = "psychosisAbilitySuccess";
        break;
    case #"hero_armblade":
        dialogkey = "ripperWeaponSuccess";
        break;
    case #"gadget_camo":
        dialogkey = "activeCamoAbilitySuccess";
        break;
    case #"hero_flamethrower":
        dialogkey = "purifierWeaponSuccess";
        break;
    case #"gadget_heat_wave":
        dialogkey = "heatwaveAbilitySuccess";
        break;
    default:
        return;
    }
    if (isdefined(waitkey)) {
        waittime = mpdialog_value(waitkey, 0);
    }
    dialogkey += "0";
    self.playedgadgetsuccess = 1;
    self thread wait_play_dialog(waittime, dialogkey, 1, undefined, victim);
}

// Namespace dialog_shared/dialog_shared
// Params 1, eflags: 0x0
// Checksum 0x30322b7b, Offset: 0x53c0
// Size: 0xa4
function play_gadget_off(weapon) {
    if (!isdefined(weapon)) {
        return;
    }
    dialogkey = undefined;
    switch (weapon.name) {
    case #"gadget_speed_burst":
        dialogkey = "overdriveAbilityOff";
        break;
    case #"hero_pineapplegun":
    case #"hero_pineapplegun_companion":
        dialogkey = "warmachineWeaponOff";
        break;
    default:
        return;
    }
    self thread play_dialog(dialogkey, 1);
}

// Namespace dialog_shared/dialog_shared
// Params 0, eflags: 0x0
// Checksum 0x33ab3616, Offset: 0x5470
// Size: 0x44
function play_throw_hatchet() {
    self thread play_dialog("exertAxeThrow", 21, mpdialog_value("playerExertBuffer", 0));
}

// Namespace dialog_shared/dialog_shared
// Params 0, eflags: 0x0
// Checksum 0x17ab142d, Offset: 0x54c0
// Size: 0x1ce
function get_enemy_players() {
    players = [];
    if (level.teambased) {
        foreach (team in level.teams) {
            if (team == self.team) {
                continue;
            }
            foreach (player in level.aliveplayers[team]) {
                players[players.size] = player;
            }
        }
    } else {
        foreach (player in level.activeplayers) {
            if (player != self) {
                players[players.size] = player;
            }
        }
    }
    return players;
}

// Namespace dialog_shared/dialog_shared
// Params 0, eflags: 0x0
// Checksum 0x691f286e, Offset: 0x5698
// Size: 0xc8
function get_friendly_players() {
    players = [];
    if (level.teambased) {
        foreach (player in level.aliveplayers[self.team]) {
            players[players.size] = player;
        }
    } else {
        players[0] = self;
    }
    return players;
}

// Namespace dialog_shared/dialog_shared
// Params 1, eflags: 0x0
// Checksum 0x4dd55bc8, Offset: 0x5768
// Size: 0xf6
function can_play_dialog(teamonly) {
    if (!isplayer(self) || !isalive(self) || self.playingdialog === 1 || self isplayerunderwater() || self isremotecontrolling() || self isinvehicle() || self isweaponviewonlylinked()) {
        return false;
    }
    if (isdefined(teamonly) && !teamonly && self hasperk("specialty_quieter")) {
        return false;
    }
    return true;
}

// Namespace dialog_shared/dialog_shared
// Params 2, eflags: 0x0
// Checksum 0x56cdfdc1, Offset: 0x5868
// Size: 0x108
function get_closest_player_enemy(origin, teamonly) {
    if (!isdefined(origin)) {
        origin = self.origin;
    }
    players = self get_enemy_players();
    players = arraysort(players, origin);
    foreach (player in players) {
        if (!player can_play_dialog(teamonly)) {
            continue;
        }
        return player;
    }
    return undefined;
}

// Namespace dialog_shared/dialog_shared
// Params 1, eflags: 0x0
// Checksum 0x58fcd323, Offset: 0x5978
// Size: 0x102
function get_closest_player_ally(teamonly) {
    if (!level.teambased) {
        return undefined;
    }
    players = self get_friendly_players();
    players = arraysort(players, self.origin);
    foreach (player in players) {
        if (player == self || !player can_play_dialog(teamonly)) {
            continue;
        }
        return player;
    }
    return undefined;
}

// Namespace dialog_shared/dialog_shared
// Params 0, eflags: 0x0
// Checksum 0x6e1a6bc2, Offset: 0x5a88
// Size: 0x1d4
function check_boost_start_conversation() {
    if (!level.playstartconversation) {
        return;
    }
    if (!level.inprematchperiod || !level.teambased || game.boostplayerspicked[self.team]) {
        return;
    }
    players = self get_friendly_players();
    array::add(players, self, 0);
    players = array::randomize(players);
    playerindex = 1;
    foreach (player in players) {
        playerdialog = player getmpdialogname();
        for (i = playerindex; i < players.size; i++) {
            playeri = players[i];
            if (playerdialog != playeri getmpdialogname()) {
                pick_boost_players(player, playeri);
                return;
            }
        }
        playerindex++;
    }
}

// Namespace dialog_shared/dialog_shared
// Params 2, eflags: 0x0
// Checksum 0xa93ec077, Offset: 0x5c68
// Size: 0x76
function pick_boost_players(player1, player2) {
    player1 clientfield::set("play_boost", 1);
    player2 clientfield::set("play_boost", 2);
    game.boostplayerspicked[player1.team] = 1;
}

// Namespace dialog_shared/dialog_shared
// Params 1, eflags: 0x0
// Checksum 0xa969fd40, Offset: 0x5ce8
// Size: 0x1da
function game_end_vox(winner) {
    if (!level.allowspecialistdialog) {
        return;
    }
    var_71859219 = level.teambased && (!isdefined(winner) || winner == "tie");
    foreach (player in level.players) {
        if (player issplitscreen()) {
            continue;
        }
        if (var_71859219) {
            dialogkey = "boostDraw";
        } else if (!level.teambased && (level.teambased && isdefined(level.teams[winner]) && player.pers["team"] == winner || player == winner)) {
            dialogkey = "boostWin";
        } else {
            dialogkey = "boostLoss";
        }
        dialogalias = player get_player_dialog_alias(dialogkey);
        if (isdefined(dialogalias)) {
            player playlocalsound(dialogalias);
        }
    }
}

/#

    // Namespace dialog_shared/dialog_shared
    // Params 0, eflags: 0x0
    // Checksum 0x178dd9ee, Offset: 0x5ed0
    // Size: 0x380
    function devgui_think() {
        setdvar("<dev string:xa8>", "<dev string:xb8>");
        setdvar("<dev string:xb9>", "<dev string:xca>");
        setdvar("<dev string:xe5>", "<dev string:xf6>");
        setdvar("<dev string:x110>", "<dev string:x124>");
        while (true) {
            wait 1;
            player = util::gethostplayer();
            if (!isdefined(player)) {
                continue;
            }
            spacing = getdvarfloat("<dev string:x145>", 0.25);
            switch (getdvarstring("<dev string:xa8>", "<dev string:xb8>")) {
            case #"hash_a44caacc":
                player thread test_player_dialog(0);
                player thread test_taacom_dialog(spacing);
                player thread test_commander_dialog(2 * spacing);
                break;
            case #"hash_ccef9d3a":
                player thread test_player_dialog(0);
                player thread test_commander_dialog(spacing);
                break;
            case #"hash_fc2d2a30":
                player thread test_other_dialog(0);
                player thread test_commander_dialog(spacing);
                break;
            case #"hash_94c50ce9":
                player thread test_taacom_dialog(0);
                player thread test_commander_dialog(spacing);
                break;
            case #"hash_e1beeaa5":
                player thread test_player_dialog(0);
                player thread test_taacom_dialog(spacing);
                break;
            case #"hash_e6de4bbf":
                player thread test_other_dialog(0);
                player thread test_taacom_dialog(spacing);
                break;
            case #"hash_733722ac":
                player thread test_other_dialog(0);
                player thread test_player_dialog(spacing);
                break;
            case #"hash_d6bbad13":
                player thread play_conv_self_other();
                break;
            case #"hash_f9d78311":
                player thread play_conv_other_self();
                break;
            case #"hash_2f69d023":
                player thread play_conv_other_other();
                break;
            }
            setdvar("<dev string:xa8>", "<dev string:xb8>");
        }
    }

    // Namespace dialog_shared/dialog_shared
    // Params 1, eflags: 0x0
    // Checksum 0x99de55cd, Offset: 0x6258
    // Size: 0xf4
    function test_other_dialog(delay) {
        players = arraysort(level.players, self.origin);
        foreach (player in players) {
            if (player != self && isalive(player)) {
                player thread test_player_dialog(delay);
                return;
            }
        }
    }

    // Namespace dialog_shared/dialog_shared
    // Params 1, eflags: 0x0
    // Checksum 0xd312e60c, Offset: 0x6358
    // Size: 0x64
    function test_player_dialog(delay) {
        if (!isdefined(delay)) {
            delay = 0;
        }
        wait delay;
        self playsoundontag(getdvarstring("<dev string:xb9>", "<dev string:xb8>"), "<dev string:x1f3>");
    }

    // Namespace dialog_shared/dialog_shared
    // Params 1, eflags: 0x0
    // Checksum 0xcddc5c61, Offset: 0x63c8
    // Size: 0x5c
    function test_taacom_dialog(delay) {
        if (!isdefined(delay)) {
            delay = 0;
        }
        wait delay;
        self playlocalsound(getdvarstring("<dev string:xe5>", "<dev string:xb8>"));
    }

    // Namespace dialog_shared/dialog_shared
    // Params 1, eflags: 0x0
    // Checksum 0x53da3026, Offset: 0x6430
    // Size: 0x5c
    function test_commander_dialog(delay) {
        if (!isdefined(delay)) {
            delay = 0;
        }
        wait delay;
        self playlocalsound(getdvarstring("<dev string:x110>", "<dev string:xb8>"));
    }

    // Namespace dialog_shared/dialog_shared
    // Params 1, eflags: 0x0
    // Checksum 0x2da4dba8, Offset: 0x6498
    // Size: 0x5c
    function play_test_dialog(dialogkey) {
        dialogalias = self get_player_dialog_alias(dialogkey);
        self playsoundontag(dialogalias, "<dev string:x1f3>");
    }

    // Namespace dialog_shared/dialog_shared
    // Params 0, eflags: 0x0
    // Checksum 0xf03a34d5, Offset: 0x6500
    // Size: 0xc4
    function response_key() {
        switch (self getmpdialogname()) {
        case #"assassin":
            return "<dev string:x203>";
        case #"grenadier":
            return "<dev string:x215>";
        case #"outrider":
            return "<dev string:x228>";
        case #"prophet":
            return "<dev string:x239>";
        case #"pyro":
            return "<dev string:x24b>";
        case #"reaper":
            return "<dev string:x25c>";
        case #"ruin":
            return "<dev string:x268>";
        case #"seraph":
            return "<dev string:x279>";
        case #"trapper":
            return "<dev string:x28a>";
        }
        return "<dev string:xb8>";
    }

    // Namespace dialog_shared/dialog_shared
    // Params 0, eflags: 0x0
    // Checksum 0x90838af2, Offset: 0x65d0
    // Size: 0x15e
    function play_conv_self_other() {
        num = randomintrange(0, 4);
        self play_test_dialog("<dev string:x292>" + num);
        wait 4;
        players = arraysort(level.players, self.origin);
        foreach (player in players) {
            if (player != self && isalive(player)) {
                player play_test_dialog("<dev string:x29d>" + self response_key() + num);
                break;
            }
        }
    }

    // Namespace dialog_shared/dialog_shared
    // Params 0, eflags: 0x0
    // Checksum 0x9d0ee894, Offset: 0x6738
    // Size: 0x15c
    function play_conv_other_self() {
        num = randomintrange(0, 4);
        players = arraysort(level.players, self.origin);
        foreach (player in players) {
            if (player != self && isalive(player)) {
                player play_test_dialog("<dev string:x292>" + num);
                break;
            }
        }
        wait 4;
        self play_test_dialog("<dev string:x29d>" + player response_key() + num);
    }

    // Namespace dialog_shared/dialog_shared
    // Params 0, eflags: 0x0
    // Checksum 0xfb061f18, Offset: 0x68a0
    // Size: 0x206
    function play_conv_other_other() {
        num = randomintrange(0, 4);
        players = arraysort(level.players, self.origin);
        foreach (player in players) {
            if (player != self && isalive(player)) {
                player play_test_dialog("<dev string:x292>" + num);
                firstplayer = player;
                break;
            }
        }
        wait 4;
        foreach (player in players) {
            if (player != self && player !== firstplayer && isalive(player)) {
                player play_test_dialog("<dev string:x29d>" + firstplayer response_key() + num);
                break;
            }
        }
    }

#/
