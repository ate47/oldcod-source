#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace dialog_shared;

// Namespace dialog_shared/dialog_shared
// Params 0, eflags: 0x2
// Checksum 0x3491271b, Offset: 0xbc0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"dialog_shared", &__init__, undefined, undefined);
}

// Namespace dialog_shared/dialog_shared
// Params 0, eflags: 0x0
// Checksum 0xbb09f1cc, Offset: 0xc08
// Size: 0x9ca
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
    level.var_d0e5eb94 = &function_bd3e9f8e;
    level.bcsounds = [];
    level.bcsounds[#"incoming_alert"] = [];
    level.bcsounds[#"incoming_alert"][#"frag_grenade"] = "incomingFrag";
    level.bcsounds[#"incoming_alert"][#"incendiary_grenade"] = "incomingIncendiary";
    level.bcsounds[#"incoming_alert"][#"sticky_grenade"] = "incomingSemtex";
    level.bcsounds[#"incoming_alert"][#"launcher_standard"] = "threatRpg";
    level.bcsounds[#"incoming_delay"] = [];
    level.bcsounds[#"incoming_delay"][#"frag_grenade"] = "fragGrenadeDelay";
    level.bcsounds[#"incoming_delay"][#"incendiary_grenade"] = "incendiaryGrenadeDelay";
    level.bcsounds[#"incoming_alert"][#"sticky_grenade"] = "semtexDelay";
    level.bcsounds[#"incoming_delay"][#"launcher_standard"] = "missileDelay";
    level.bcsounds[#"kill_dialog"] = [];
    level.bcsounds[#"kill_dialog"][#"battery"] = "killBattery";
    level.bcsounds[#"kill_dialog"][#"buffassault"] = "killBuffAssault";
    level.bcsounds[#"kill_dialog"][#"engineer"] = "killEngineer";
    level.bcsounds[#"kill_dialog"][#"firebreak"] = "killFirebreak";
    level.bcsounds[#"kill_dialog"][#"nomad"] = "killNomad";
    level.bcsounds[#"kill_dialog"][#"prophet"] = "killProphet";
    level.bcsounds[#"kill_dialog"][#"recon"] = "killRecon";
    level.bcsounds[#"kill_dialog"][#"ruin"] = "killRuin";
    level.bcsounds[#"kill_dialog"][#"seraph"] = "killSeraph";
    level.bcsounds[#"kill_dialog"][#"swatpolice"] = "killSwatPolice";
    if (level.teambased && !isdefined(game.boostplayerspicked)) {
        game.boostplayerspicked = [];
        foreach (team, _ in level.teams) {
            game.boostplayerspicked[team] = 0;
        }
    }
    level.allowbattlechatter[#"bc"] = getgametypesetting(#"allowbattlechatter");
    clientfield::register("world", "boost_number", 1, 2, "int");
    clientfield::register("allplayers", "play_boost", 1, 2, "int");
    level thread pick_boost_number();
    playerdialogbundles = struct::get_script_bundles("mpdialog_player");
    foreach (bundle in playerdialogbundles) {
        count_keys(bundle, "killGeneric");
        count_keys(bundle, "killSniper");
        count_keys(bundle, "killBattery");
        count_keys(bundle, "killBuffAssault");
        count_keys(bundle, "killEngineer");
        count_keys(bundle, "killFirebreak");
        count_keys(bundle, "killNomad");
        count_keys(bundle, "killProphet");
        count_keys(bundle, "killRecon");
        count_keys(bundle, "killRuin");
        count_keys(bundle, "killSeraph");
        count_keys(bundle, "killSwatPolice");
    }
    level.playerdialogbundles = playerdialogbundles;
    level.allowspecialistdialog = mpdialog_value("enableHeroDialog", 0) && isdefined(level.allowbattlechatter[#"bc"]) && level.allowbattlechatter[#"bc"];
    level.playstartconversation = mpdialog_value("enableConversation", 0) && isdefined(level.allowbattlechatter[#"bc"]) && level.allowbattlechatter[#"bc"];
}

// Namespace dialog_shared/dialog_shared
// Params 0, eflags: 0x0
// Checksum 0x81cd770a, Offset: 0x15e0
// Size: 0x80
function flush_dialog() {
    foreach (player in level.players) {
        player flush_dialog_on_player();
    }
}

// Namespace dialog_shared/dialog_shared
// Params 0, eflags: 0x0
// Checksum 0xdbcb379c, Offset: 0x1668
// Size: 0x3e
function flush_dialog_on_player() {
    self.leaderdialogqueue = [];
    self.currentleaderdialog = undefined;
    self.killstreakdialogqueue = [];
    self.scorestreakdialogplaying = 0;
    self notify(#"flush_dialog");
}

// Namespace dialog_shared/dialog_shared
// Params 2, eflags: 0x0
// Checksum 0x7574745f, Offset: 0x16b0
// Size: 0x84
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
// Checksum 0x32a90482, Offset: 0x1740
// Size: 0x3c
function pick_boost_number() {
    wait 5;
    level clientfield::set("boost_number", randomint(4));
}

// Namespace dialog_shared/dialog_shared
// Params 1, eflags: 0x0
// Checksum 0xaab55d03, Offset: 0x1788
// Size: 0xdc
function on_joined_team(params) {
    self endon(#"disconnect");
    if (level.teambased) {
        if (self.team == #"allies") {
            self set_blops_dialog();
        } else {
            self set_cdp_dialog();
        }
    } else if (randomintrange(0, 2)) {
        self set_blops_dialog();
    } else {
        self set_cdp_dialog();
    }
    self flush_dialog_on_player();
}

// Namespace dialog_shared/dialog_shared
// Params 0, eflags: 0x0
// Checksum 0x4f0c8124, Offset: 0x1870
// Size: 0x46
function set_blops_dialog() {
    self.pers[#"mptaacom"] = "blops_taacom";
    self.pers[#"mpcommander"] = "blops_commander";
}

// Namespace dialog_shared/dialog_shared
// Params 0, eflags: 0x0
// Checksum 0xf8c1f83f, Offset: 0x18c0
// Size: 0x46
function set_cdp_dialog() {
    self.pers[#"mptaacom"] = "cdp_taacom";
    self.pers[#"mpcommander"] = "cdp_commander";
}

// Namespace dialog_shared/dialog_shared
// Params 0, eflags: 0x0
// Checksum 0x444aef8b, Offset: 0x1910
// Size: 0xe4
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
    if (!level.allowbattlechatter[#"bc"]) {
        return;
    }
    self thread water_vox();
    if (level.teambased) {
        self thread enemy_threat();
        self thread check_boost_start_conversation();
    }
}

// Namespace dialog_shared/dialog_shared
// Params 1, eflags: 0x0
// Checksum 0x3190e879, Offset: 0x1a00
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
// Checksum 0x8046279e, Offset: 0x1a88
// Size: 0x86
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
// Checksum 0x7dbefd8d, Offset: 0x1b18
// Size: 0x232
function water_vox() {
    self endon(#"death");
    level endon(#"game_ended");
    interval = mpdialog_value("underwaterInterval", float(function_f9f48566()) / 1000);
    if (interval <= 0) {
        assert(interval > 0, "<dev string:x30>");
        return;
    }
    while (true) {
        wait interval;
        if (self isplayerunderwater()) {
            if (!self.voxunderwatertime && !self.voxemergebreath) {
                self stopsounds();
                self.voxunderwatertime = gettime();
            } else if (self.voxunderwatertime) {
                if (gettime() > self.voxunderwatertime + int(mpdialog_value("underwaterBreathTime", 0) * 1000)) {
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
// Checksum 0xe6078891, Offset: 0x1d58
// Size: 0x13c
function taking_fire_vox(params) {
    if (isdefined(params.eattacker) && (isai(params.eattacker) || isvehicle(params.eattacker) || isplayer(params.eattacker))) {
        if (isdefined(params.eattacker.team) && self.team !== params.eattacker.team) {
            takingfire_cooldown = "taking_fire_vo_" + string(self.team);
            if (level util::iscooldownready(takingfire_cooldown)) {
                self play_dialog("takingFire", 1);
                level util::cooldown(takingfire_cooldown, 5);
            }
        }
    }
}

// Namespace dialog_shared/dialog_shared
// Params 1, eflags: 0x0
// Checksum 0x87df89c8, Offset: 0x1ea0
// Size: 0x134
function pain_vox(meansofdeath) {
    if (dialog_chance("smallPainChance")) {
        if (meansofdeath == "MOD_DROWN") {
            dialogkey = "exertPainDrowning";
            self.voxdrowning = 1;
        } else if (meansofdeath == "MOD_DOT" || meansofdeath == "MOD_DOT_SELF") {
            if (!isdefined(self.var_74a21aed)) {
                return;
            }
            dialogkey = "exertPainDamageTick";
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
// Checksum 0x65bde2a9, Offset: 0x1fe0
// Size: 0x4c
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
// Checksum 0xe3d0b47, Offset: 0x2038
// Size: 0x3a
function on_player_near_explodable(object, type) {
    self endon(#"death");
    level endon(#"game_ended");
}

// Namespace dialog_shared/dialog_shared
// Params 0, eflags: 0x0
// Checksum 0x7b23c655, Offset: 0x2080
// Size: 0x2b6
function enemy_threat() {
    self endon(#"death");
    level endon(#"game_ended");
    while (true) {
        self waittill(#"weapon_ads");
        if (self hasperk(#"specialty_quieter")) {
            continue;
        }
        if (self.enemythreattime + int(mpdialog_value("enemyContactInterval", 0) * 1000) >= gettime()) {
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
            if (isdefined(traceresult[#"entity"]) && traceresult[#"entity"].classname == "player" && traceresult[#"entity"].team != self.team) {
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
// Checksum 0x9e1304c1, Offset: 0x2340
// Size: 0x25e
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
// Checksum 0xf4d8ea19, Offset: 0x25a8
// Size: 0x154
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
// Checksum 0x2cd8d55b, Offset: 0x2708
// Size: 0xd4
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
// Checksum 0x320fdbd9, Offset: 0x27e8
// Size: 0x98
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
// Checksum 0x35b23bd9, Offset: 0x2888
// Size: 0x3c4
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
    } else if (dialog_chance("enemyKillChance")) {
        if (isdefined(victim.spottedtime) && victim.spottedtime + mpdialog_value("enemySniperKillTime", 0) >= gettime() && array::contains(victim.spottedby, attacker) && dialog_chance("enemySniperKillChance")) {
            killdialog = attacker get_random_key("killSniper");
        } else if (dialog_chance("enemyHeroKillChance")) {
            victimdialogname = victim getmpdialogname();
            killdialog = attacker get_random_key(level.bcsounds[#"kill_dialog"][victimdialogname]);
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

// Namespace dialog_shared/missile_fire
// Params 1, eflags: 0x40
// Checksum 0x184b047e, Offset: 0x2c58
// Size: 0x194
function event_handler[missile_fire] function_2543dd4(eventstruct) {
    if (!isplayer(self)) {
        return;
    }
    grenade = eventstruct.projectile;
    weapon = eventstruct.weapon;
    if (!isdefined(grenade.weapon) || !isdefined(grenade.weapon.rootweapon) || !dialog_chance("incomingProjectileChance")) {
        return;
    }
    dialogkey = level.bcsounds[#"incoming_alert"][grenade.weapon.rootweapon.name];
    if (isdefined(dialogkey)) {
        waittime = mpdialog_value(level.bcsounds[#"incoming_delay"][grenade.weapon.rootweapon.name], float(function_f9f48566()) / 1000);
        level thread incoming_projectile_alert(self, grenade, dialogkey, waittime);
    }
}

// Namespace dialog_shared/grenade_fire
// Params 1, eflags: 0x40
// Checksum 0xbbffd4aa, Offset: 0x2df8
// Size: 0x17c
function event_handler[grenade_fire] function_6969b896(eventstruct) {
    if (!isplayer(self)) {
        return;
    }
    missile = eventstruct.projectile;
    if (!isdefined(missile.item) || !isdefined(missile.item.rootweapon) || !dialog_chance("incomingProjectileChance")) {
        return;
    }
    dialogkey = level.bcsounds[#"incoming_alert"][missile.item.rootweapon.name];
    if (isdefined(dialogkey)) {
        waittime = mpdialog_value(level.bcsounds[#"incoming_delay"][missile.item.rootweapon.name], float(function_f9f48566()) / 1000);
        level thread incoming_projectile_alert(self, missile, dialogkey, waittime);
    }
}

// Namespace dialog_shared/dialog_shared
// Params 4, eflags: 0x0
// Checksum 0xd719f9b4, Offset: 0x2f80
// Size: 0x192
function incoming_projectile_alert(thrower, projectile, dialogkey, waittime) {
    level endon(#"game_ended");
    if (waittime <= 0) {
        assert(waittime > 0, "<dev string:x76>");
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
        if (!isdefined(thrower) || thrower.team == #"spectator") {
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

// Namespace dialog_shared/grenade_stuck
// Params 1, eflags: 0x40
// Checksum 0x24450b5c, Offset: 0x3120
// Size: 0xbc
function event_handler[grenade_stuck] function_fce52eca(eventstruct) {
    if (!isplayer(self)) {
        return;
    }
    grenade = eventstruct.projectile;
    if (isalive(self) && isdefined(grenade) && isdefined(grenade.weapon)) {
        if (grenade.weapon.rootweapon.name == "sticky_grenade") {
            self thread play_dialog("stuckSticky", 6);
        }
    }
}

// Namespace dialog_shared/dialog_shared
// Params 0, eflags: 0x0
// Checksum 0x2a7c611f, Offset: 0x31e8
// Size: 0x34c
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
// Checksum 0xa184fb50, Offset: 0x3540
// Size: 0x254
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
// Checksum 0x1c5cdff0, Offset: 0x37a0
// Size: 0x3a
function gametype_specific_battle_chatter(event, team) {
    self endon(#"death");
    level endon(#"game_ended");
}

// Namespace dialog_shared/dialog_shared
// Params 0, eflags: 0x0
// Checksum 0x3b916360, Offset: 0x37e8
// Size: 0x3c
function play_laststand_vox() {
    dialogkey = "laststandDown";
    if (isdefined(dialogkey)) {
        self play_dialog(dialogkey, 1);
    }
}

// Namespace dialog_shared/dialog_shared
// Params 0, eflags: 0x0
// Checksum 0x311ac638, Offset: 0x3830
// Size: 0x5c
function function_bd3e9f8e() {
    dialogkey = "exertFullyHealedBreath";
    dialogalias = self get_player_dialog_alias(dialogkey);
    if (isdefined(dialogalias)) {
        self thread play_dialog(dialogkey, 16);
    }
}

// Namespace dialog_shared/dialog_shared
// Params 4, eflags: 0x0
// Checksum 0xfb9b93c7, Offset: 0x3898
// Size: 0x8c
function play_death_vox(body, attacker, weapon, meansofdeath) {
    dialogkey = self get_death_vox(weapon, meansofdeath);
    dialogalias = self get_player_dialog_alias(dialogkey);
    if (isdefined(dialogalias)) {
        body playsoundontag(dialogalias, "J_Head");
    }
}

// Namespace dialog_shared/dialog_shared
// Params 2, eflags: 0x0
// Checksum 0x47019a1f, Offset: 0x3930
// Size: 0x162
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
        case #"mod_dot":
            return "exertDeathDrowned";
        case #"mod_dot_self":
            return "exertDeathDrowned";
        }
    }
    if (isdefined(weapon) && meansofdeath !== "MOD_MELEE_WEAPON_BUTT") {
        switch (weapon.rootweapon.name) {
        case #"knife_loadout":
        case #"hatchet":
        case #"hero_armblade":
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
// Checksum 0xdc89b268, Offset: 0x3aa0
// Size: 0x5c
function play_killstreak_threat(killstreaktype) {
    if (!isdefined(killstreaktype) || !isdefined(level.killstreaks[killstreaktype])) {
        return;
    }
    self thread play_dialog(level.killstreaks[killstreaktype].threatdialogkey, 1);
}

// Namespace dialog_shared/dialog_shared
// Params 6, eflags: 0x0
// Checksum 0x5383bfb, Offset: 0x3b08
// Size: 0xac
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
// Checksum 0xb174667b, Offset: 0x3bc0
// Size: 0x4d4
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
    if (level flagsys::get(#"chyron_active")) {
        return;
    }
    if (isdefined(self.team) && level flagsys::get(#"dialog_mutex_" + self.team)) {
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
// Checksum 0x71f7f3a7, Offset: 0x40a0
// Size: 0x92
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
// Checksum 0xb3708fb7, Offset: 0x4140
// Size: 0x42
function stop_dialog() {
    self notify(#"stop_dialog");
    self stopsounds();
    self.playingdialog = 0;
    self.playinggadgetreadydialog = 0;
}

// Namespace dialog_shared/dialog_shared
// Params 1, eflags: 0x0
// Checksum 0x83cf6e8c, Offset: 0x4190
// Size: 0xc
function wait_playback_time(soundalias) {
    
}

// Namespace dialog_shared/dialog_shared
// Params 1, eflags: 0x0
// Checksum 0x40139982, Offset: 0x41a8
// Size: 0x9a
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
// Checksum 0x58a48313, Offset: 0x4250
// Size: 0xce
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
// Checksum 0x6d50adf5, Offset: 0x4328
// Size: 0xec
function get_random_key(dialogkey) {
    bundlename = self getmpdialogname();
    if (!isdefined(bundlename)) {
        return undefined;
    }
    playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
    if (!isdefined(playerbundle) || !isdefined(playerbundle.keycounts) || !isdefined(playerbundle.keycounts[dialogkey])) {
        return dialogkey;
    }
    if (playerbundle.keycounts[dialogkey] > 0) {
        return (dialogkey + randomint(playerbundle.keycounts[dialogkey]));
    }
    return dialogkey + 0;
}

// Namespace dialog_shared/dialog_shared
// Params 2, eflags: 0x0
// Checksum 0xab916cea, Offset: 0x4420
// Size: 0x5fc
function play_gadget_ready(weapon, userflip = 0) {
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
    case #"hero_bowlauncher2":
    case #"hero_bowlauncher3":
    case #"hero_bowlauncher4":
    case #"hero_bowlauncher":
        dialogkey = "sparrowWeaponReady";
        break;
    case #"gadget_vision_pulse":
        dialogkey = "visionpulseAbilityReady";
        break;
    case #"hero_lightninggun":
    case #"hero_lightninggun_arc":
        dialogkey = "tempestWeaponReady";
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
        self thread play_dialog(dialogkey, dialogflags);
        return;
    }
    waittime = 0;
    dialogflags = 32;
    if (userflip) {
        minwaittime = 0;
        if (self.playinggadgetreadydialog) {
            self stop_dialog();
            minwaittime = float(function_f9f48566()) / 1000;
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
            if (self.laststolengadget === weapon && self.laststolengadgettime + int(mpdialog_value(repeatthresholdkey, 0) * 1000) > gettime()) {
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
// Checksum 0x6eafc088, Offset: 0x4a28
// Size: 0x304
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
    case #"hero_bowlauncher2":
    case #"hero_bowlauncher3":
    case #"hero_bowlauncher4":
    case #"hero_bowlauncher":
        dialogkey = "sparrowWeaponUse";
        break;
    case #"gadget_vision_pulse":
        dialogkey = "visionpulseAbilityUse";
        break;
    case #"hero_lightninggun":
    case #"hero_lightninggun_arc":
        dialogkey = "tempestWeaponUse";
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
    self thread play_dialog(dialogkey, dialogflags, dialogbuffer);
}

// Namespace dialog_shared/dialog_shared
// Params 3, eflags: 0x0
// Checksum 0x86653b5d, Offset: 0x4d38
// Size: 0x344
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
    case #"hero_bowlauncher2":
    case #"hero_bowlauncher3":
    case #"hero_bowlauncher4":
    case #"hero_bowlauncher":
        dialogkey = "sparrowWeaponSuccess";
        break;
    case #"gadget_vision_pulse":
        dialogkey = "visionpulseAbilitySuccess";
        break;
    case #"hero_lightninggun":
    case #"hero_lightninggun_arc":
        dialogkey = "tempestWeaponSuccess";
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
// Checksum 0x10e52a59, Offset: 0x5088
// Size: 0xbc
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
// Checksum 0x643d511a, Offset: 0x5150
// Size: 0x44
function play_throw_hatchet() {
    self thread play_dialog("exertAxeThrow", 21, mpdialog_value("playerExertBuffer", 0));
}

// Namespace dialog_shared/dialog_shared
// Params 0, eflags: 0x0
// Checksum 0xb77df4e8, Offset: 0x51a0
// Size: 0x192
function get_enemy_players() {
    players = [];
    if (level.teambased) {
        foreach (team, _ in level.teams) {
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
// Checksum 0x51138996, Offset: 0x5340
// Size: 0xb0
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
// Checksum 0x644824dc, Offset: 0x53f8
// Size: 0x100
function can_play_dialog(teamonly) {
    if (!isplayer(self) || !isalive(self) || self.playingdialog === 1 || self isplayerunderwater() || self isremotecontrolling() || self isinvehicle() || self isweaponviewonlylinked()) {
        return false;
    }
    if (isdefined(teamonly) && !teamonly && self hasperk(#"specialty_quieter")) {
        return false;
    }
    return true;
}

// Namespace dialog_shared/dialog_shared
// Params 2, eflags: 0x0
// Checksum 0xfb94c81b, Offset: 0x5500
// Size: 0xe6
function get_closest_player_enemy(origin = self.origin, teamonly) {
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
// Checksum 0x60b7a212, Offset: 0x55f0
// Size: 0xf2
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
// Checksum 0x104740e0, Offset: 0x56f0
// Size: 0x1b2
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
// Checksum 0xd38da316, Offset: 0x58b0
// Size: 0x72
function pick_boost_players(player1, player2) {
    player1 clientfield::set("play_boost", 1);
    player2 clientfield::set("play_boost", 2);
    game.boostplayerspicked[player1.team] = 1;
}

// Namespace dialog_shared/dialog_shared
// Params 2, eflags: 0x0
// Checksum 0xb488cea, Offset: 0x5930
// Size: 0x190
function game_end_vox(winner, tie) {
    if (!level.allowspecialistdialog) {
        return;
    }
    foreach (player in level.players) {
        if (player issplitscreen()) {
            continue;
        }
        if (tie) {
            dialogkey = "boostDraw";
        } else if (level.teambased && isdefined(level.teams[winner]) && player.pers[#"team"] == winner || !level.teambased && player == winner) {
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
    // Checksum 0xd07f3327, Offset: 0x5ac8
    // Size: 0x408
    function devgui_think() {
        setdvar(#"devgui_mpdialog", "<dev string:xb0>");
        setdvar(#"testalias_player", "<dev string:xb1>");
        setdvar(#"testalias_taacom", "<dev string:xcc>");
        setdvar(#"testalias_commander", "<dev string:xe6>");
        while (true) {
            wait 1;
            player = util::gethostplayer();
            if (!isdefined(player)) {
                continue;
            }
            spacing = getdvarfloat(#"testdialog_spacing", 0.25);
            switch (getdvarstring(#"devgui_mpdialog", "<dev string:xb0>")) {
            case #"hash_7912e80189f9c6":
                player thread test_player_dialog(0);
                player thread test_taacom_dialog(spacing);
                player thread test_commander_dialog(2 * spacing);
                break;
            case #"hash_69c6be086f76a9d4":
                player thread test_player_dialog(0);
                player thread test_commander_dialog(spacing);
                break;
            case #"hash_3af5f0a904b3f8fa":
                player thread test_other_dialog(0);
                player thread test_commander_dialog(spacing);
                break;
            case #"hash_32945da5f7ac491":
                player thread test_taacom_dialog(0);
                player thread test_commander_dialog(spacing);
                break;
            case #"hash_597b27a5c8857d19":
                player thread test_player_dialog(0);
                player thread test_taacom_dialog(spacing);
                break;
            case #"hash_74f798193af006b3":
                player thread test_other_dialog(0);
                player thread test_taacom_dialog(spacing);
                break;
            case #"hash_5bd6a2c5d0ff3cb2":
                player thread test_other_dialog(0);
                player thread test_player_dialog(spacing);
                break;
            case #"hash_4a5a66c89be92eb":
                player thread play_conv_self_other();
                break;
            case #"hash_18683ef7652f40ed":
                player thread play_conv_other_self();
                break;
            case #"hash_2b559b1a5e81715f":
                player thread play_conv_other_other();
                break;
            }
            setdvar(#"devgui_mpdialog", "<dev string:xb0>");
        }
    }

    // Namespace dialog_shared/dialog_shared
    // Params 1, eflags: 0x0
    // Checksum 0x7aaec771, Offset: 0x5ed8
    // Size: 0xe2
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
    // Checksum 0x13ab081, Offset: 0x5fc8
    // Size: 0x64
    function test_player_dialog(delay) {
        if (!isdefined(delay)) {
            delay = 0;
        }
        wait delay;
        self playsoundontag(getdvarstring(#"testalias_player", "<dev string:xb0>"), "<dev string:x107>");
    }

    // Namespace dialog_shared/dialog_shared
    // Params 1, eflags: 0x0
    // Checksum 0x6cd88f9, Offset: 0x6038
    // Size: 0x5c
    function test_taacom_dialog(delay) {
        if (!isdefined(delay)) {
            delay = 0;
        }
        wait delay;
        self playlocalsound(getdvarstring(#"testalias_taacom", "<dev string:xb0>"));
    }

    // Namespace dialog_shared/dialog_shared
    // Params 1, eflags: 0x0
    // Checksum 0x95a7dee5, Offset: 0x60a0
    // Size: 0x5c
    function test_commander_dialog(delay) {
        if (!isdefined(delay)) {
            delay = 0;
        }
        wait delay;
        self playlocalsound(getdvarstring(#"testalias_commander", "<dev string:xb0>"));
    }

    // Namespace dialog_shared/dialog_shared
    // Params 1, eflags: 0x0
    // Checksum 0x5490cf1c, Offset: 0x6108
    // Size: 0x4c
    function play_test_dialog(dialogkey) {
        dialogalias = self get_player_dialog_alias(dialogkey);
        self playsoundontag(dialogalias, "<dev string:x107>");
    }

    // Namespace dialog_shared/dialog_shared
    // Params 0, eflags: 0x0
    // Checksum 0x352b9555, Offset: 0x6160
    // Size: 0x10c
    function response_key() {
        switch (self getmpdialogname()) {
        case #"assassin":
            return "<dev string:x10e>";
        case #"grenadier":
            return "<dev string:x116>";
        case #"outrider":
            return "<dev string:x120>";
        case #"prophet":
            return "<dev string:x129>";
        case #"pyro":
            return "<dev string:x136>";
        case #"reaper":
            return "<dev string:x140>";
        case #"ruin":
            return "<dev string:x147>";
        case #"seraph":
            return "<dev string:x151>";
        case #"trapper":
            return "<dev string:x15a>";
        }
        return "<dev string:xb0>";
    }

    // Namespace dialog_shared/dialog_shared
    // Params 0, eflags: 0x0
    // Checksum 0x24f32798, Offset: 0x6278
    // Size: 0x13c
    function play_conv_self_other() {
        num = randomintrange(0, 4);
        self play_test_dialog("<dev string:x162>" + num);
        wait 4;
        players = arraysort(level.players, self.origin);
        foreach (player in players) {
            if (player != self && isalive(player)) {
                player play_test_dialog("<dev string:x16d>" + self response_key() + num);
                break;
            }
        }
    }

    // Namespace dialog_shared/dialog_shared
    // Params 0, eflags: 0x0
    // Checksum 0x2eb45db5, Offset: 0x63c0
    // Size: 0x13c
    function play_conv_other_self() {
        num = randomintrange(0, 4);
        players = arraysort(level.players, self.origin);
        foreach (player in players) {
            if (player != self && isalive(player)) {
                player play_test_dialog("<dev string:x162>" + num);
                break;
            }
        }
        wait 4;
        self play_test_dialog("<dev string:x16d>" + player response_key() + num);
    }

    // Namespace dialog_shared/dialog_shared
    // Params 0, eflags: 0x0
    // Checksum 0x6179538a, Offset: 0x6508
    // Size: 0x1dc
    function play_conv_other_other() {
        num = randomintrange(0, 4);
        players = arraysort(level.players, self.origin);
        foreach (player in players) {
            if (player != self && isalive(player)) {
                player play_test_dialog("<dev string:x162>" + num);
                firstplayer = player;
                break;
            }
        }
        wait 4;
        foreach (player in players) {
            if (player != self && player !== firstplayer && isalive(player)) {
                player play_test_dialog("<dev string:x16d>" + firstplayer response_key() + num);
                break;
            }
        }
    }

#/
