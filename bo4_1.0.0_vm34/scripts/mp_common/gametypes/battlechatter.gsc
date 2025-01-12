#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\player\player_role;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\gametypes\globallogic_audio;
#using scripts\mp_common\gametypes\match;
#using scripts\weapons\grapple;

#namespace battlechatter;

// Namespace battlechatter/battlechatter
// Params 0, eflags: 0x2
// Checksum 0xb588651e, Offset: 0x858
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"battlechatter", &__init__, undefined, undefined);
}

// Namespace battlechatter/battlechatter
// Params 0, eflags: 0x0
// Checksum 0xe92bdfe, Offset: 0x8a0
// Size: 0xaba
function __init__() {
    /#
        level thread devgui_think();
    #/
    callback::on_joined_team(&on_joined_team);
    callback::on_spawned(&on_player_spawned);
    level.heroplaydialog = &play_dialog;
    level.var_412805ce = &function_7c1fe73f;
    level.playgadgetready = &play_gadget_ready;
    level.playgadgetactivate = &play_gadget_activate;
    level.var_57918348 = &function_4906a3fd;
    level.var_33b45d0b = &function_9bd04d84;
    level.playgadgetsuccess = &play_gadget_success;
    level.var_86ebfbc0 = &mpdialog_value;
    level.var_b31e16d4 = &function_1f637da2;
    level.playpromotionreaction = &play_promotion_reaction;
    level.var_602d80f2 = &function_22c87d44;
    level.playkillstreakthreat = &function_a135f102;
    level.var_151de896 = &function_1b64a6b6;
    level.var_d0e5eb94 = &function_bd3e9f8e;
    level.var_30f43eae = &function_d7091e26;
    level.bcsounds = [];
    level.bcsounds[#"incoming_alert"] = [];
    level.bcsounds[#"incoming_alert"][#"frag_grenade"] = "incomingFrag";
    level.bcsounds[#"incoming_alert"][#"incendiary_grenade"] = "incomingIncendiary";
    level.bcsounds[#"incoming_alert"][#"sticky_grenade"] = "incomingSemtex";
    level.bcsounds[#"incoming_alert"][#"eq_sticky_grenade"] = "incomingSemtex";
    level.bcsounds[#"incoming_alert"][#"launcher_standard"] = "threatRpg";
    level.bcsounds[#"incoming_delay"] = [];
    level.bcsounds[#"incoming_delay"][#"frag_grenade"] = "fragGrenadeDelay";
    level.bcsounds[#"incoming_delay"][#"incendiary_grenade"] = "incendiaryGrenadeDelay";
    level.bcsounds[#"incoming_alert"][#"sticky_grenade"] = "semtexDelay";
    level.bcsounds[#"incoming_alert"][#"eq_sticky_grenade"] = "semtexDelay";
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
    mpdialog = struct::get_script_bundle("mpdialog", "mpdialog_default");
    if (!isdefined(mpdialog)) {
        mpdialog = spawnstruct();
    }
    level.allowspecialistdialog = (isdefined(mpdialog.enableherodialog) ? mpdialog.enableherodialog : 0) && isdefined(level.allowbattlechatter[#"bc"]) && level.allowbattlechatter[#"bc"];
    level.playstartconversation = (isdefined(mpdialog.enableconversation) ? mpdialog.enableconversation : 0) && isdefined(level.allowbattlechatter[#"bc"]) && level.allowbattlechatter[#"bc"];
}

// Namespace battlechatter/battlechatter
// Params 0, eflags: 0x0
// Checksum 0x2e14b716, Offset: 0x1368
// Size: 0x3c
function pick_boost_number() {
    wait 5;
    level clientfield::set("boost_number", randomint(4));
}

// Namespace battlechatter/battlechatter
// Params 1, eflags: 0x0
// Checksum 0x3f534c1d, Offset: 0x13b0
// Size: 0x1ce
function on_joined_team(params) {
    self endon(#"disconnect");
    teammask = getteammask(self.team);
    for (teamindex = 0; teammask > 1; teamindex++) {
        teammask >>= 1;
    }
    if (teamindex % 2) {
        self set_blops_dialog();
    } else {
        self set_cdp_dialog();
    }
    self globallogic_audio::flush_dialog();
    if (!(isdefined(level.inprematchperiod) && level.inprematchperiod) && !(isdefined(self.pers[#"playedgamemode"]) && self.pers[#"playedgamemode"]) && isdefined(level.leaderdialog)) {
        if (level.hardcoremode) {
            self globallogic_audio::leader_dialog_on_player(level.leaderdialog.starthcgamedialog, undefined, undefined, undefined, 1);
        } else {
            self globallogic_audio::leader_dialog_on_player(level.leaderdialog.startgamedialog, undefined, undefined, undefined, 1);
        }
        self.pers[#"playedgamemode"] = 1;
    }
}

// Namespace battlechatter/battlechatter
// Params 0, eflags: 0x0
// Checksum 0xe53773b2, Offset: 0x1588
// Size: 0x46
function set_blops_dialog() {
    self.pers[#"mptaacom"] = "blops_taacom";
    self.pers[#"mpcommander"] = "blops_commander";
}

// Namespace battlechatter/battlechatter
// Params 0, eflags: 0x0
// Checksum 0x94a4ee, Offset: 0x15d8
// Size: 0x46
function set_cdp_dialog() {
    self.pers[#"mptaacom"] = "cdp_taacom";
    self.pers[#"mpcommander"] = "cdp_commander";
}

// Namespace battlechatter/battlechatter
// Params 0, eflags: 0x0
// Checksum 0x67f2af6a, Offset: 0x1628
// Size: 0x174
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
    if (level.splitscreen || !level.allowbattlechatter[#"bc"]) {
        return;
    }
    self thread water_vox();
    self thread grenade_tracking();
    self thread missile_tracking();
    self thread sticky_grenade_tracking();
    self thread function_ada7377f();
    self thread function_ddad8400();
    self thread watchfordamage();
    if (level.teambased) {
        self thread enemy_threat();
    }
}

// Namespace battlechatter/battlechatter
// Params 0, eflags: 0x0
// Checksum 0xa0944bc5, Offset: 0x17a8
// Size: 0x172
function watchfordamage() {
    self endon(#"death", #"disconnect");
    level endon(#"game_ended");
    self notify("557d090bf13396a2");
    self endon("557d090bf13396a2");
    while (true) {
        waitresult = self waittill(#"damage");
        if (!isdefined(waitresult.attacker) || !isplayer(waitresult.attacker) || waitresult.attacker == self) {
            return;
        }
        if (isdefined(waitresult.weapon) && isdefined(waitresult.amount)) {
            if (waitresult.weapon == getweapon(#"gadget_radiation_field")) {
                waitresult.attacker.radiationdamage = (isdefined(waitresult.attacker.radiationdamage) ? waitresult.attacker.radiationdamage : 0) + waitresult.amount;
            }
        }
    }
}

// Namespace battlechatter/battlechatter
// Params 0, eflags: 0x0
// Checksum 0x342298d0, Offset: 0x1928
// Size: 0x2fe
function function_ada7377f() {
    self endon(#"death", #"disconnect");
    level endon(#"game_ended");
    self notify("4836cf49c4b246f");
    self endon("4836cf49c4b246f");
    if (isdefined(self.currentweapon)) {
        nextweapon = self.currentweapon;
    }
    while (true) {
        waitresult = self waittill(#"weapon_change");
        if (isdefined(waitresult.weapon) && isweapon(waitresult.weapon)) {
            nextweapon = waitresult.weapon;
        } else {
            nextweapon = self.currentweapon;
        }
        if (isdefined(nextweapon) && (nextweapon.name == "sig_buckler_dw" || nextweapon.name == "sig_buckler_turret") && (self.currentweapon.name == "sig_buckler_dw" || self.currentweapon.name == "sig_buckler_turret")) {
            continue;
        }
        if (nextweapon.name == "none") {
            continue;
        }
        self.var_7e2d559d = 0;
        self.var_91a331bc = 0;
        bundlename = self getmpdialogname();
        if (!isdefined(bundlename)) {
            continue;
        }
        playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
        if (!isdefined(playerbundle)) {
            continue;
        }
        switch (nextweapon.name) {
        case #"hero_pineapplegun":
            dialogkey = playerbundle.warmachineweaponuse;
            break;
        case #"shock_rifle":
        case #"hero_lightninggun":
        case #"hero_lightninggun_arc":
            dialogkey = playerbundle.tempestweaponuse;
            break;
        case #"sig_minigun":
            dialogkey = playerbundle.var_2b0b5e05;
            break;
        case #"sig_bow_quickshot":
            dialogkey = playerbundle.sparrowweaponuse;
            break;
        }
        if (isdefined(dialogkey)) {
            self thread function_9e201b50(dialogkey, undefined, undefined, undefined);
            dialogkey = undefined;
        }
    }
}

// Namespace battlechatter/battlechatter
// Params 1, eflags: 0x0
// Checksum 0x3df1329c, Offset: 0x1c30
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

// Namespace battlechatter/battlechatter
// Params 2, eflags: 0x0
// Checksum 0x4d484593, Offset: 0x1cb8
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

// Namespace battlechatter/battlechatter
// Params 0, eflags: 0x0
// Checksum 0xb874d66d, Offset: 0x1d48
// Size: 0x28a
function water_vox() {
    self endon(#"death");
    level endon(#"game_ended");
    interval = mpdialog_value("underwaterInterval", float(function_f9f48566()) / 1000);
    if (interval <= 0) {
        assert(interval > 0, "<dev string:x30>");
        return;
    }
    bundlename = self getmpdialogname();
    if (!isdefined(bundlename)) {
        return;
    }
    playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
    if (!isdefined(playerbundle)) {
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
            self thread function_9e201b50(playerbundle.exertemergegasp, 20, mpdialog_value("playerExertBuffer", 0));
            self.voxdrowning = 0;
            self.voxemergebreath = 0;
            continue;
        }
        if (self.voxemergebreath) {
            self thread function_9e201b50(playerbundle.exertemergebreath, 20, mpdialog_value("playerExertBuffer", 0));
            self.voxemergebreath = 0;
        }
    }
}

// Namespace battlechatter/battlechatter
// Params 2, eflags: 0x0
// Checksum 0x42a69b4c, Offset: 0x1fe0
// Size: 0x2be
function pain_vox(meansofdeath, weapon) {
    bundlename = self getmpdialogname();
    if (!isdefined(bundlename)) {
        return;
    }
    playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
    if (!isdefined(playerbundle)) {
        return;
    }
    if (dialog_chance("smallPainChance")) {
        if (meansofdeath == "MOD_DROWN") {
            dialogkey = playerbundle.exertpaindrowning;
            self.voxdrowning = 1;
        } else if (meansofdeath == "MOD_DOT" || meansofdeath == "MOD_DOT_SELF") {
            if (!isdefined(self.var_74a21aed)) {
                return;
            }
            if (isdefined(weapon)) {
                if (weapon.doesfiredamage) {
                    dialogkey = playerbundle.var_82c5b22a;
                }
            } else {
                dialogkey = playerbundle.exertpaindamagetick;
            }
        } else if (meansofdeath == "MOD_FALLING") {
            dialogkey = playerbundle.exertpainfalling;
        } else if (meansofdeath == "MOD_BURNED") {
            dialogkey = playerbundle.var_82c5b22a;
        } else if (meansofdeath == "MOD_ELECTROCUTED") {
            dialogkey = playerbundle.var_9fcb14f1;
        } else if (self isplayerunderwater()) {
            dialogkey = playerbundle.exertpainunderwater;
        } else {
            if (isdefined(self.armor)) {
                if (self.armor > 0) {
                    return;
                }
            }
            if (isdefined(weapon)) {
                if (weapon.name == "shock_rifle") {
                    dialogkey = playerbundle.exertdeathelectrocuted;
                }
            }
            dialogkey = playerbundle.exertpain;
        }
        exertbuffer = mpdialog_value("playerExertBuffer", 0);
        if (isdefined(self.var_b1dfb486) && gettime() - self.var_b1dfb486 < int(exertbuffer * 1000)) {
            return;
        }
        self thread function_9e201b50(dialogkey, 30, exertbuffer);
        self.var_b1dfb486 = gettime();
    }
}

// Namespace battlechatter/battlechatter
// Params 0, eflags: 0x0
// Checksum 0x9325c661, Offset: 0x22a8
// Size: 0x9c
function function_bd3e9f8e() {
    bundlename = self getmpdialogname();
    if (!isdefined(bundlename)) {
        return;
    }
    playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
    if (!isdefined(playerbundle)) {
        return;
    }
    dialogkey = playerbundle.exertfullyhealedbreath;
    if (isdefined(dialogkey)) {
        self thread function_9e201b50(dialogkey, 16);
    }
}

// Namespace battlechatter/battlechatter
// Params 2, eflags: 0x0
// Checksum 0xa3251c4b, Offset: 0x2350
// Size: 0x4c
function on_player_suicide_or_team_kill(player, type) {
    self endon(#"death");
    level endon(#"game_ended");
    waittillframeend();
    if (!level.teambased) {
        return;
    }
}

// Namespace battlechatter/battlechatter
// Params 2, eflags: 0x0
// Checksum 0x11bc908a, Offset: 0x23a8
// Size: 0x3a
function on_player_near_explodable(object, type) {
    self endon(#"death");
    level endon(#"game_ended");
}

// Namespace battlechatter/battlechatter
// Params 1, eflags: 0x0
// Checksum 0xfa41dac2, Offset: 0x23f0
// Size: 0x29c
function function_cc24b842(dialogname) {
    if (!level.allowspecialistdialog || !isdefined(dialogname)) {
        return;
    }
    bundlename = self getmpdialogname();
    if (!isdefined(bundlename)) {
        return;
    }
    playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
    if (!isdefined(playerbundle)) {
        return;
    }
    switch (dialogname) {
    case #"battery":
        dialogkey = playerbundle.var_41ca17cc;
        break;
    case #"buffassault":
        dialogkey = playerbundle.var_4f4a4f37;
        break;
    case #"engineer":
        dialogkey = playerbundle.var_6225787e;
        break;
    case #"firebreak":
        dialogkey = playerbundle.var_b0155daa;
        break;
    case #"nomad":
        dialogkey = playerbundle.var_1a1adb7a;
        break;
    case #"outrider":
        dialogkey = playerbundle.var_9caa68a1;
        break;
    case #"prophet":
        dialogkey = playerbundle.var_7d7cda7d;
        break;
    case #"reaper":
        dialogkey = playerbundle.var_686d456c;
        break;
    case #"recon":
        dialogkey = playerbundle.var_fd96422e;
        break;
    case #"ruin":
        dialogkey = playerbundle.var_c1d0d0bb;
        break;
    case #"seraph":
        dialogkey = playerbundle.var_af2953ba;
        break;
    case #"spectre":
        dialogkey = playerbundle.var_c38ddcbf;
        break;
    case #"swatpolice":
        dialogkey = playerbundle.var_a6fc4f76;
        break;
    }
    if (isdefined(dialogkey)) {
        self thread function_9e201b50(dialogkey, 1, undefined, undefined);
    }
}

// Namespace battlechatter/battlechatter
// Params 0, eflags: 0x0
// Checksum 0x3106eb18, Offset: 0x2698
// Size: 0x376
function function_ddad8400() {
    self endon(#"death", #"disconnect");
    level endon(#"game_ended");
    self notify("12397a6de14bf16f");
    self endon("12397a6de14bf16f");
    while (true) {
        result = self waittill(#"bulletwhizby");
        if (!isdefined(result.suppressor) || (isdefined(result.suppressor.var_91a331bc) ? result.suppressor.var_91a331bc : 0)) {
            continue;
        }
        if (isdefined(result.suppressor.currentweapon) && isplayer(result.suppressor)) {
            bundlename = self getmpdialogname();
            if (!isdefined(bundlename)) {
                continue;
            }
            playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
            if (!isdefined(playerbundle)) {
                continue;
            }
            switch (result.suppressor.currentweapon.name) {
            case #"hero_annihilator":
                dialogkey = playerbundle.var_776563b6;
                break;
            }
        } else if (isdefined(result.suppressor.turretweapon)) {
            if (result.suppressor.turretweapon.name == #"gun_ultimate_turret") {
                result.suppressor.var_91a331bc = 1;
                play_killstreak_threat(result.suppressor.killstreaktype);
            }
        } else if (isdefined(result.suppressor.weapon)) {
            if (isdefined(level.var_18df0256) && isdefined(result.suppressor.ai) && isdefined(result.suppressor.ai.swat_gunner) && result.suppressor.ai.swat_gunner && result.suppressor.weapon.name == #"hash_6c1be4b025206124") {
                result.suppressor [[ level.var_18df0256 ]](self, result.suppressor.script_owner);
            }
        }
        if (!isdefined(dialogkey)) {
            continue;
        }
        result.suppressor.var_91a331bc = 1;
        self thread function_9e201b50(dialogkey, 2, undefined, undefined);
        dialogkey = undefined;
    }
}

// Namespace battlechatter/battlechatter
// Params 5, eflags: 0x0
// Checksum 0xd9507bcd, Offset: 0x2a18
// Size: 0x6d2
function function_b505bc94(var_b9c362a7, attacker, eventorigin, eventobject, timedelay) {
    if (!level.allowspecialistdialog || !isdefined(self) || (isdefined(self.var_91a331bc) ? self.var_91a331bc : 0) || (isdefined(eventobject.var_91a331bc) ? eventobject.var_91a331bc : 0) || !isdefined(var_b9c362a7) || !isplayer(self)) {
        return;
    }
    switch (var_b9c362a7.name) {
    case #"sig_buckler_dw":
    case #"sig_buckler_turret":
        var_59ab9479 = 1;
        break;
    case #"eq_concertina_wire":
        var_521d72f9 = 1;
        break;
    case #"eq_slow_grenade":
    case #"concussion_grenade":
        var_59ab9479 = 1;
        var_521d72f9 = 1;
        break;
    case #"gadget_health_boost":
    case #"gadget_cleanse":
        break;
    case #"dog_ai_defaultmelee":
        var_521d72f9 = 1;
        break;
    case #"eq_swat_grenade":
    case #"hash_3f62a872201cd1ce":
    case #"hash_5825488ac68418af":
        var_59ab9479 = 1;
        var_521d72f9 = 1;
        break;
    case #"frag_grenade":
        var_59ab9479 = 1;
        var_521d72f9 = 1;
        break;
    case #"eq_gravityslam":
        var_d275f39a = 1;
        var_75271007 = 1;
        break;
    case #"hero_flamethrower":
        var_d275f39a = 1;
        break;
    case #"gadget_radiation_field":
        var_d275f39a = 1;
        break;
    case #"ability_smart_cover":
        var_521d72f9 = 1;
        var_d275f39a = 1;
        var_75271007 = 1;
        break;
    case #"gadget_supplypod":
        var_521d72f9 = 1;
        break;
    case #"trophy_system":
        var_521d72f9 = 1;
        break;
    case #"gadget_vision_pulse":
        var_59ab9479 = 1;
        break;
    default:
        return;
    }
    if (isdefined(var_59ab9479) ? var_59ab9479 : 0) {
        if (isdefined(attacker) && isplayer(attacker)) {
            if (isdefined(var_521d72f9) ? var_521d72f9 : 0) {
                eventobject.var_91a331bc = 1;
            } else {
                self.var_91a331bc = 1;
            }
            attacker function_88ff90f1(var_b9c362a7, timedelay);
            return;
        }
        return;
    }
    if (isdefined(eventorigin)) {
        players = self getenemies();
        allyradius = mpdialog_value("enemyContactAllyRadius", 0);
        enemydistance = mpdialog_value("enemyContactDistance", 0);
        foreach (player in players) {
            if (!isplayer(player)) {
                continue;
            }
            if (isdefined(attacker) && isplayer(attacker) && player == attacker) {
                continue;
            }
            if (isdefined(var_d275f39a) ? var_d275f39a : 0) {
                if (distancesquared(eventorigin, player.origin) < allyradius * allyradius) {
                    if (isdefined(var_75271007) ? var_75271007 : 0) {
                        relativepos = vectornormalize(player.origin - eventorigin);
                        dir = anglestoforward(self getplayerangles());
                        dotproduct = vectordot(relativepos, dir);
                        if (dotproduct > 0) {
                            continue;
                        }
                    } else {
                        continue;
                    }
                }
            }
            if (distancesquared(eventorigin, player.origin) > enemydistance * enemydistance) {
                continue;
            }
            eyepoint = player geteye();
            relativepos = vectornormalize(eventorigin - eyepoint);
            dir = anglestoforward(player getplayerangles());
            dotproduct = vectordot(relativepos, dir);
            if (dotproduct > 0) {
                if (sighttracepassed(eventorigin, eyepoint, 1, player, eventobject)) {
                    if (isdefined(var_521d72f9) ? var_521d72f9 : 0) {
                        eventobject.var_91a331bc = 1;
                    } else {
                        self.var_91a331bc = 1;
                    }
                    player function_88ff90f1(var_b9c362a7, timedelay);
                    return;
                }
            }
        }
    }
}

// Namespace battlechatter/battlechatter
// Params 2, eflags: 0x4
// Checksum 0x87c582da, Offset: 0x30f8
// Size: 0x314
function private function_88ff90f1(weapon, timedelay) {
    bundlename = self getmpdialogname();
    if (!isdefined(bundlename)) {
        return;
    }
    playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
    if (!isdefined(playerbundle)) {
        return;
    }
    switch (weapon.name) {
    case #"sig_buckler_dw":
    case #"sig_buckler_turret":
        dialogkey = playerbundle.var_bc588ec;
        break;
    case #"eq_concertina_wire":
        dialogkey = playerbundle.var_e367b5ae;
        break;
    case #"eq_slow_grenade":
    case #"concussion_grenade":
        dialogkey = playerbundle.var_bd6ca84d;
        break;
    case #"gadget_health_boost":
    case #"gadget_cleanse":
        dialogkey = playerbundle.var_dc7d4c74;
        break;
    case #"dog_ai_defaultmelee":
        dialogkey = playerbundle.var_60c5d915;
        break;
    case #"eq_swat_grenade":
    case #"hash_3f62a872201cd1ce":
    case #"hash_5825488ac68418af":
        dialogkey = playerbundle.var_bfd13b73;
        break;
    case #"frag_grenade":
        dialogkey = playerbundle.var_4c208389;
        break;
    case #"eq_gravityslam":
        dialogkey = playerbundle.var_9fdbcc5a;
        break;
    case #"hero_flamethrower":
        dialogkey = playerbundle.var_cc9dd2b5;
        break;
    case #"gadget_radiation_field":
        dialogkey = playerbundle.var_1173836e;
        break;
    case #"ability_smart_cover":
        dialogkey = playerbundle.var_76c30e19;
        break;
    case #"gadget_supplypod":
        dialogkey = playerbundle.var_56e7f295;
        break;
    case #"trophy_system":
        dialogkey = playerbundle.var_b37d3f1c;
        break;
    case #"gadget_vision_pulse":
        dialogkey = playerbundle.var_7965cab2;
        break;
    default:
        return;
    }
    self thread function_b318503c(timedelay, dialogkey, 2, undefined, undefined, "disconnect");
}

// Namespace battlechatter/battlechatter
// Params 0, eflags: 0x0
// Checksum 0xd990ad7e, Offset: 0x3418
// Size: 0x5fa
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
        eyepoint = self geteye();
        dir = anglestoforward(self getplayerangles());
        dir *= mpdialog_value("enemyContactDistance", 0);
        endpoint = eyepoint + dir;
        traceresult = bullettrace(eyepoint, endpoint, 1, self);
        if (isdefined(traceresult[#"entity"]) && traceresult[#"entity"].classname == "player" && traceresult[#"entity"].team != self.team) {
            if (dialog_chance("enemyContactChance")) {
                if (dialog_chance("enemyHeroContactChance")) {
                    self function_cc24b842(traceresult[#"entity"] getmpdialogname());
                } else {
                    self thread play_dialog("threatInfantry", 1);
                }
                level notify(#"level_enemy_spotted", self.team);
                self.enemythreattime = gettime();
            }
            continue;
        }
        if (isdefined(traceresult[#"entity"]) && traceresult[#"entity"].team != self.team) {
            if (isdefined(traceresult[#"entity"].weapon)) {
                if (traceresult[#"entity"].weapon.name == "ar_accurate_t8_swat") {
                    self play_killstreak_threat("swat_team");
                } else if (traceresult[#"entity"].weapon.name == #"straferun_rockets" || traceresult[#"entity"].weapon.name == #"straferun_gun") {
                    self play_killstreak_threat("straferun");
                }
            } else if (isdefined(traceresult[#"entity"].turretweapon)) {
                if (traceresult[#"entity"].turretweapon.name == #"tank_robot_launcher_turret" && !(isdefined(traceresult[#"entity"].var_9dd74129) && traceresult[#"entity"].var_9dd74129)) {
                    self play_killstreak_threat("tank_robot");
                    traceresult[#"entity"].var_9dd74129 = 1;
                } else if (traceresult[#"entity"].turretweapon.name == #"hash_38ffd09564931482") {
                    self play_killstreak_threat("recon_car");
                } else if (traceresult[#"entity"].turretweapon.name == #"hash_5fbda3ef4b135b49" || traceresult[#"entity"].turretweapon.name == #"hash_26ffb92552ae26be") {
                    self play_killstreak_threat("drone_squadron");
                } else if (traceresult[#"entity"].turretweapon.name == #"player_air_vehicle1_main_turret_3rd_person" && !(isdefined(traceresult[#"entity"].var_9dd74129) && traceresult[#"entity"].var_9dd74129)) {
                    self play_killstreak_threat("overwatch_helicopter");
                }
            }
            self.enemythreattime = gettime();
        }
    }
}

// Namespace battlechatter/battlechatter
// Params 1, eflags: 0x0
// Checksum 0x12720718, Offset: 0x3a20
// Size: 0x276
function killed_by_sniper(sniper) {
    self endon(#"disconnect");
    sniper endon(#"disconnect");
    level endon(#"game_ended");
    if (!level.teambased || !level.allowspecialistdialog) {
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

// Namespace battlechatter/battlechatter
// Params 3, eflags: 0x0
// Checksum 0x1ddcbbaa, Offset: 0x3ca0
// Size: 0x1a2
function function_ea793aac(speakingplayer, player, allyradiussq) {
    if (!isdefined(player) || !isdefined(player.origin) || !isdefined(speakingplayer) || !isdefined(speakingplayer.origin) || !isalive(player) || player.sessionstate != "playing" || player.playingdialog || player isplayerunderwater() || player isremotecontrolling() || player isinvehicle() || player isweaponviewonlylinked() || player == speakingplayer || player.team != speakingplayer.team || player.playerrole == speakingplayer.playerrole) {
        return false;
    }
    distsq = distancesquared(speakingplayer.origin, player.origin);
    if (distsq > allyradiussq) {
        return false;
    }
    return true;
}

// Namespace battlechatter/battlechatter
// Params 2, eflags: 0x0
// Checksum 0x6ba27470, Offset: 0x3e50
// Size: 0xfc
function function_18e49eb8(speakingplayer, allyradiussq) {
    allies = [];
    foreach (player in level.players) {
        if (!function_ea793aac(speakingplayer, player, allyradiussq)) {
            continue;
        }
        allies[allies.size] = player;
    }
    allies = arraysort(allies, speakingplayer.origin);
    if (!isdefined(allies) || allies.size == 0) {
        return undefined;
    }
    return allies[0];
}

// Namespace battlechatter/battlechatter
// Params 4, eflags: 0x0
// Checksum 0x159e554c, Offset: 0x3f58
// Size: 0x414
function function_a3098aa3(var_2605333a, weapon, waitkey, var_ed283a6b) {
    self endon(#"death", #"disconnect");
    level endon(#"game_ended");
    if (!level.teambased || !level.allowspecialistdialog) {
        return;
    }
    if (!isdefined(waitkey)) {
        waitkey = "playerDialogBuffer";
    }
    self thread function_b318503c(mpdialog_value(waitkey, 0), var_2605333a, 2, mpdialog_value("successResponseBuffer", undefined), undefined, "cancel_kill_dialog");
    wait mpdialog_value(waitkey, 0) + 0.1;
    while (self.playingdialog) {
        wait 0.3;
    }
    allyradiussq = mpdialog_value("SuccessReactionRadius", 500) * mpdialog_value("SuccessReactionRadius", 500);
    if (isdefined(var_ed283a6b) && function_ea793aac(self, var_ed283a6b, allyradiussq)) {
        var_6c8f4df5 = var_ed283a6b;
    } else {
        var_6c8f4df5 = function_18e49eb8(self, allyradiussq);
    }
    if (!isdefined(var_6c8f4df5)) {
        return;
    }
    bundlename = var_6c8f4df5 getmpdialogname();
    if (!isdefined(bundlename)) {
        return;
    }
    playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
    if (!isdefined(playerbundle)) {
        return;
    }
    switch (weapon.name) {
    case #"gadget_health_boost":
    case #"gadget_cleanse":
        var_29f687b1 = playerbundle.var_d93aec64;
        break;
    case #"eq_concertina_wire":
        var_29f687b1 = playerbundle.var_3baac446;
        break;
    case #"molotov_fire":
    case #"eq_molotov":
        var_118a2213 = function_b9650e7f(self player_role::get(), currentsessionmode());
        if (isdefined(var_118a2213) && var_118a2213 == #"prt_mp_firebreak") {
            var_29f687b1 = playerbundle.var_a0ff8b5f;
        }
        break;
    case #"gadget_radiation_field":
        var_29f687b1 = playerbundle.var_e5992906;
        break;
    case #"eq_sensor":
        var_29f687b1 = playerbundle.var_1f238828;
        break;
    case #"gadget_supplypod":
        var_29f687b1 = playerbundle.var_9d66c157;
        break;
    case #"gadget_vision_pulse":
        var_29f687b1 = playerbundle.var_adf1cda;
        break;
    case #"eq_localheal":
        var_29f687b1 = playerbundle.var_c5e7ddbb;
        break;
    default:
        return;
    }
    if (isdefined(var_29f687b1)) {
        var_6c8f4df5 function_9e201b50(var_29f687b1, 2, undefined, undefined);
    }
}

// Namespace battlechatter/battlechatter
// Params 4, eflags: 0x0
// Checksum 0x5cfdb3b3, Offset: 0x4378
// Size: 0x8dc
function function_fe7f907c(attacker, victim, weapon, inflictor) {
    if (!isdefined(attacker) || !isplayer(attacker) || !isdefined(weapon) || !isplayer(victim)) {
        return 0;
    }
    var_345657b = undefined;
    var_17194950 = undefined;
    mpdialog = struct::get_script_bundle("mpdialog", "mpdialog_default");
    if (!isdefined(mpdialog)) {
        mpdialog = spawnstruct();
    }
    relativepos = vectornormalize(victim.origin - attacker.origin);
    dir = anglestoforward(attacker getplayerangles());
    dotproduct = vectordot(dir, relativepos);
    switch (weapon.name) {
    case #"hero_annihilator":
        attacker.var_7e2d559d = (isdefined(attacker.var_7e2d559d) ? attacker.var_7e2d559d : 0) + 1;
        if (attacker.var_7e2d559d == (isdefined(mpdialog.var_e846925e) ? mpdialog.var_e846925e : 0)) {
            var_345657b = 1;
        }
        break;
    case #"sig_buckler_dw":
    case #"sig_buckler_turret":
        attacker.var_7e2d559d = (isdefined(attacker.var_7e2d559d) ? attacker.var_7e2d559d : 0) + 1;
        if (attacker.var_7e2d559d == (isdefined(mpdialog.var_1d18fb68) ? mpdialog.var_1d18fb68 : 0)) {
            var_345657b = 1;
        }
        break;
    case #"claymore":
        if (dotproduct > 0 && sighttracepassed(attacker geteye(), victim geteye(), 1, attacker, victim)) {
            var_345657b = 1;
        }
        break;
    case #"dog_ai_defaultmelee":
        if (!isdefined(inflictor)) {
            return;
        }
        inflictor.var_7e2d559d = (isdefined(inflictor.var_7e2d559d) ? inflictor.var_7e2d559d : 0) + 1;
        if (!isdefined(inflictor.var_386b346a) && inflictor.var_7e2d559d > (isdefined(mpdialog.var_c8fd19b5) ? mpdialog.var_c8fd19b5 : 0) && dotproduct > 0 && sighttracepassed(attacker geteye(), victim geteye(), 1, attacker, victim)) {
            var_345657b = 1;
            inflictor.var_386b346a = 1;
        }
        break;
    case #"hero_flamethrower":
        attacker.var_7e2d559d = (isdefined(attacker.var_7e2d559d) ? attacker.var_7e2d559d : 0) + 1;
        if (attacker.var_7e2d559d == (isdefined(mpdialog.var_70770d55) ? mpdialog.var_70770d55 : 0)) {
            var_345657b = 1;
        }
        break;
    case #"eq_gravityslam":
        attacker.var_7e2d559d = (isdefined(attacker.var_7e2d559d) ? attacker.var_7e2d559d : 0) + 1;
        if (attacker.var_7e2d559d == (isdefined(mpdialog.var_1d21362) ? mpdialog.var_1d21362 : 0)) {
            var_345657b = 1;
        }
        break;
    case #"gun_mini_turret":
        if (!isdefined(inflictor)) {
            return;
        }
        inflictor.var_7e2d559d = (isdefined(inflictor.var_7e2d559d) ? inflictor.var_7e2d559d : 0) + 1;
        if (!isdefined(inflictor.var_386b346a) && inflictor.var_7e2d559d > (isdefined(mpdialog.var_b2a7292) ? mpdialog.var_b2a7292 : 0) && dotproduct > 0 && sighttracepassed(attacker geteye(), victim geteye(), 1, attacker, victim)) {
            var_345657b = 1;
            inflictor.var_386b346a = 1;
        }
        break;
    case #"sig_bow_quickshot4":
        attacker.var_7e2d559d = (isdefined(attacker.var_7e2d559d) ? attacker.var_7e2d559d : 0) + 1;
        if (attacker.var_7e2d559d == (isdefined(mpdialog.var_fccf6f9b) ? mpdialog.var_fccf6f9b : 0)) {
            var_345657b = 1;
        }
        break;
    case #"hash_5a4932f4b8d8b37a":
        attacker.var_bd430c07 = (isdefined(attacker.var_bd430c07) ? attacker.var_bd430c07 : 0) + 1;
        if (attacker.var_bd430c07 == (isdefined(mpdialog.var_a8ccfbeb) ? mpdialog.var_a8ccfbeb : 0)) {
            var_345657b = 1;
        }
        break;
    case #"shock_rifle":
    case #"hero_lightninggun":
        attacker.var_7e2d559d = (isdefined(attacker.var_7e2d559d) ? attacker.var_7e2d559d : 0) + 1;
        if (attacker.var_7e2d559d == (isdefined(mpdialog.var_12596511) ? mpdialog.var_12596511 : 0)) {
            var_345657b = 1;
        }
        break;
    case #"eq_tripwire":
        if (dotproduct > 0 && sighttracepassed(attacker geteye(), victim geteye(), 1, attacker, victim)) {
            var_345657b = 1;
        }
        break;
    case #"hero_pineapplegun":
        attacker.var_7e2d559d = (isdefined(attacker.var_7e2d559d) ? attacker.var_7e2d559d : 0) + 1;
        if (attacker.var_7e2d559d == (isdefined(mpdialog.var_6052c0b8) ? mpdialog.var_6052c0b8 : 0)) {
            var_345657b = 1;
        }
        break;
    default:
        break;
    }
    if (isdefined(var_345657b)) {
        attacker function_46a69a89(weapon);
        return 1;
    }
    return 0;
}

// Namespace battlechatter/battlechatter
// Params 5, eflags: 0x0
// Checksum 0xc10813c, Offset: 0x4c60
// Size: 0x224
function player_killed(attacker, killstreaktype, einflictor, weapon, mod) {
    if (!level.teambased || !level.allowspecialistdialog) {
        return;
    }
    if (self === attacker) {
        return;
    }
    waittillframeend();
    if (weapon.name == #"dog_ai_defaultmelee" && isdefined(einflictor)) {
        attacker function_b505bc94(weapon, self, einflictor.origin, einflictor);
    } else if (weapon.name == #"hero_flamethrower") {
        attacker function_b505bc94(weapon, self, attacker.origin, attacker);
    }
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

// Namespace battlechatter/battlechatter
// Params 4, eflags: 0x0
// Checksum 0xf2b4f39e, Offset: 0x4e90
// Size: 0x276
function function_44ce0825(attacker, weapon, victim, inflictor) {
    if (!dialog_chance("specialKillChance")) {
        return undefined;
    }
    dialogkey = undefined;
    switch (victim.currentweapon.name) {
    case #"hero_annihilator":
        dialogkey = "annihilatorDestroyed";
        break;
    case #"sig_buckler_dw":
    case #"sig_buckler_turret":
        dialogkey = "battleShieldWeaponDestroyed";
        break;
    case #"sig_minigun":
        dialogkey = "swivelMountLMGWeaponDestroyed";
        break;
    case #"sig_bow_quickshot":
        dialogkey = "sparrowWeaponDestroyed";
        break;
    case #"hero_pineapplegun":
        dialogkey = "warmachineWeaponDestroyed";
        break;
    case #"shock_rifle":
    case #"hero_lightninggun":
    case #"hero_lightninggun_arc":
        dialogkey = "tempestWeaponDestroyed";
        break;
    case #"hero_flamethrower":
        dialogkey = "purifierWeaponDestroyed";
        break;
    }
    if (!isdefined(dialogkey) && isdefined(victim.heroability)) {
        heroabilitywasactiverecently = isdefined(victim.heroabilityactive) || isdefined(victim.heroabilitydectivatetime) && victim.heroabilitydectivatetime > gettime() - 3000;
        if (heroabilitywasactiverecently) {
            switch (victim.heroability.name) {
            case #"eq_gravityslam":
                dialogkey = "gravitySlamWeaponDestroyed";
                break;
            case #"eq_grapple":
                dialogkey = "grappleGunWeaponDestroyed";
                break;
            case #"gadget_radiation_field":
                dialogkey = "radiationFieldWeaponDestroyed";
                break;
            }
        }
    }
    return dialogkey;
}

// Namespace battlechatter/battlechatter
// Params 4, eflags: 0x0
// Checksum 0xfa51bef2, Offset: 0x5110
// Size: 0x35c
function function_1f637da2(attacker, owner, gadgetweapon, attackerweapon) {
    if (!level.allowspecialistdialog || !isdefined(gadgetweapon) || !isdefined(attacker) || !isplayer(attacker) || isdefined(owner) && owner == attacker) {
        return;
    }
    if (isdefined(attackerweapon) && isdefined(level.iskillstreakweapon)) {
        if ([[ level.iskillstreakweapon ]](attackerweapon) || isdefined(attackerweapon.statname) && [[ level.iskillstreakweapon ]](getweapon(attackerweapon.statname))) {
            return;
        }
    }
    bundlename = attacker getmpdialogname();
    if (!isdefined(bundlename)) {
        return;
    }
    playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
    if (!isdefined(playerbundle)) {
        return;
    }
    dialogkey = undefined;
    switch (gadgetweapon.name) {
    case #"eq_sensor":
        dialogkey = playerbundle.var_ff8e5e49;
        break;
    case #"gadget_spawnbeacon":
        dialogkey = playerbundle.var_d619a923;
        break;
    case #"claymore":
        dialogkey = playerbundle.var_4372bfb2;
        break;
    case #"eq_concertina_wire":
        dialogkey = playerbundle.var_732678d3;
        break;
    case #"gun_mini_turret":
        dialogkey = playerbundle.var_97ac55f;
        break;
    case #"dog_ai_defaultmelee":
        dialogkey = playerbundle.dogweapondestroyed;
        break;
    case #"seeker_mine_arc":
        dialogkey = playerbundle.var_84c72cfe;
        break;
    case #"ability_smart_cover":
        dialogkey = playerbundle.var_912c9b06;
        break;
    case #"gadget_supplypod":
        dialogkey = playerbundle.supplypodweapondestroyed;
        break;
    case #"eq_tripwire":
        dialogkey = playerbundle.var_bed6fde0;
        break;
    case #"trophy_system":
        dialogkey = playerbundle.var_303af8cd;
        break;
    default:
        return;
    }
    attacker thread function_b318503c(mpdialog_value("enemyKillDelay", 0), dialogkey, 1, undefined, undefined, "cancel_kill_dialog");
}

// Namespace battlechatter/battlechatter
// Params 5, eflags: 0x0
// Checksum 0xbd471fbb, Offset: 0x5478
// Size: 0x55c
function say_kill_battle_chatter(attacker, weapon, victim, inflictor, meansofdeath) {
    if (!level.allowspecialistdialog) {
        return;
    }
    if (!isdefined(attacker) || !isplayer(attacker) || !isalive(attacker) || attacker isremotecontrolling() || attacker isinvehicle() || attacker isweaponviewonlylinked() || !isdefined(victim) || !isplayer(victim)) {
        return;
    }
    if (isdefined(meansofdeath) && (meansofdeath == "MOD_MELEE" || meansofdeath == "MOD_MELEE_WEAPON_BUTT")) {
        return;
    }
    if (isdefined(inflictor) && !isplayer(inflictor) && inflictor.birthtime < attacker.spawntime) {
        return;
    }
    var_10e5a554 = victim function_fe7f907c(attacker, victim, weapon, inflictor);
    if (var_10e5a554 || weapon.skipbattlechatterkill) {
        return;
    }
    killdialog = function_44ce0825(attacker, weapon, victim, inflictor);
    if (weapon.isheavyweapon) {
        if (!isdefined(attacker.heavyweaponkillcount)) {
            attacker.heavyweaponkillcount = 0;
        }
        attacker.heavyweaponkillcount++;
        if (!(isdefined(attacker.playedgadgetsuccess) && attacker.playedgadgetsuccess) && attacker.heavyweaponkillcount === mpdialog_value("heroWeaponKillCount", 0)) {
            attacker thread play_gadget_success(weapon, "enemyKillDelay", victim);
            attacker thread heavy_weapon_success_reaction();
        }
    } else if (isdefined(attacker.speedburston) && attacker.speedburston) {
        if (!(isdefined(attacker.speedburstkill) && attacker.speedburstkill)) {
            speedburstkilldist = mpdialog_value("speedBurstKillDistance", 0);
            if (distancesquared(attacker.origin, victim.origin) < speedburstkilldist * speedburstkilldist) {
                attacker.speedburstkill = 1;
            }
        }
    } else if (!isdefined(killdialog) && dialog_chance("enemyKillChance")) {
        if (isdefined(victim.spottedtime) && victim.spottedtime + mpdialog_value("enemySniperKillTime", 0) >= gettime() && array::contains(victim.spottedby, attacker) && dialog_chance("enemySniperKillChance")) {
            killdialog = attacker get_random_key("killSniper");
        } else if (dialog_chance("enemyHeroKillChance")) {
            victimdialogname = victim getmpdialogname();
            if (isdefined(victimdialogname) && isdefined(level.bcsounds[#"kill_dialog"][victimdialogname])) {
                killdialog = attacker get_random_key(level.bcsounds[#"kill_dialog"][victimdialogname]);
            } else {
                killdialog = attacker get_random_key("killGeneric");
            }
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

// Namespace battlechatter/battlechatter
// Params 0, eflags: 0x0
// Checksum 0x52f1d77b, Offset: 0x59e0
// Size: 0x390
function grenade_tracking() {
    self endon(#"death");
    level endon(#"game_ended");
    while (true) {
        waitresult = self waittill(#"grenade_fire");
        grenade = waitresult.projectile;
        weapon = waitresult.weapon;
        switch (weapon.name) {
        case #"frag_grenade":
        case #"eq_swat_grenade":
        case #"hash_5825488ac68418af":
        case #"eq_slow_grenade":
        case #"concussion_grenade":
            waitresult = grenade waittilltimeout(0.3, #"death");
            if (waitresult._notify == "death" || !isdefined(grenade)) {
                return;
            }
            enemies = self getenemiesinradius(grenade.origin, 100);
            if (isarray(enemies) && enemies.size > 0) {
                foreach (enemy in enemies) {
                    if (!isplayer(enemy)) {
                        continue;
                    }
                    self function_b505bc94(weapon, enemy, grenade.origin, grenade);
                    break;
                }
            }
        default:
            break;
        }
        if (!isdefined(grenade.weapon) || !isdefined(grenade.weapon.rootweapon) || !dialog_chance("incomingProjectileChance")) {
            continue;
        }
        dialogkey = level.bcsounds[#"incoming_alert"][grenade.weapon.rootweapon.name];
        if (isdefined(dialogkey)) {
            waittime = mpdialog_value(level.bcsounds[#"incoming_delay"][grenade.weapon.rootweapon.name], float(function_f9f48566()) / 1000);
            level thread incoming_projectile_alert(self, grenade, dialogkey, waittime);
        }
    }
}

// Namespace battlechatter/battlechatter
// Params 0, eflags: 0x0
// Checksum 0xed9e864a, Offset: 0x5d78
// Size: 0x1c8
function missile_tracking() {
    self endon(#"death");
    level endon(#"game_ended");
    while (true) {
        waitresult = self waittill(#"missile_fire");
        missile = waitresult.projectile;
        weapon = waitresult.weapon;
        if (!isdefined(missile.item) || !isdefined(missile.item.rootweapon) || !dialog_chance("incomingProjectileChance")) {
            continue;
        }
        dialogkey = level.bcsounds[#"incoming_alert"][missile.item.rootweapon.name];
        if (isdefined(dialogkey)) {
            waittime = mpdialog_value(level.bcsounds[#"incoming_delay"][missile.item.rootweapon.name], float(function_f9f48566()) / 1000);
            level thread incoming_projectile_alert(self, missile, dialogkey, waittime);
        }
    }
}

// Namespace battlechatter/battlechatter
// Params 4, eflags: 0x0
// Checksum 0xc10c2e52, Offset: 0x5f48
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

// Namespace battlechatter/battlechatter
// Params 0, eflags: 0x0
// Checksum 0xb3e2a16b, Offset: 0x60e8
// Size: 0x1b8
function sticky_grenade_tracking() {
    self endon(#"death");
    level endon(#"game_ended");
    while (true) {
        waitresult = self waittill(#"grenade_stuck");
        grenade = waitresult.projectile;
        if (isalive(self) && isplayer(self) && isdefined(grenade) && isdefined(grenade.weapon)) {
            if (grenade.weapon.rootweapon.name == "sticky_grenade" || grenade.weapon.rootweapon.name == "eq_sticky_grenade" || grenade.weapon.rootweapon.name == "eq_cluster_semtex_grenade") {
                bundlename = self getmpdialogname();
                if (!isdefined(bundlename)) {
                    continue;
                }
                playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
                if (!isdefined(playerbundle)) {
                    continue;
                }
                self thread function_9e201b50(playerbundle.stucksticky, 6);
            }
        }
    }
}

// Namespace battlechatter/battlechatter
// Params 0, eflags: 0x0
// Checksum 0xec3c6ac1, Offset: 0x62a8
// Size: 0x35c
function heavy_weapon_success_reaction() {
    self endon(#"death");
    level endon(#"game_ended");
    if (!level.teambased || !level.allowspecialistdialog) {
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

// Namespace battlechatter/battlechatter
// Params 0, eflags: 0x0
// Checksum 0x9bb06619, Offset: 0x6610
// Size: 0x26c
function play_promotion_reaction() {
    if (!level.allowspecialistdialog) {
        return;
    }
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
        dialogalias = player get_player_dialog_alias("promotionReaction", undefined);
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

// Namespace battlechatter/battlechatter
// Params 2, eflags: 0x0
// Checksum 0x336ad880, Offset: 0x6888
// Size: 0x3a
function gametype_specific_battle_chatter(event, team) {
    self endon(#"death");
    level endon(#"game_ended");
}

// Namespace battlechatter/battlechatter
// Params 4, eflags: 0x0
// Checksum 0x93e0729, Offset: 0x68d0
// Size: 0x6c
function play_death_vox(body, attacker, weapon, meansofdeath) {
    dialogkey = self get_death_vox(weapon, meansofdeath);
    if (isdefined(dialogkey)) {
        body playsoundontag(dialogkey, "J_Head");
    }
}

// Namespace battlechatter/battlechatter
// Params 2, eflags: 0x0
// Checksum 0xf88fb4e0, Offset: 0x6948
// Size: 0x316
function get_death_vox(weapon, meansofdeath) {
    bundlename = self getmpdialogname();
    if (!isdefined(bundlename)) {
        return;
    }
    if (isdefined(meansofdeath) && meansofdeath == "MOD_META" && (isdefined(self.pers[#"changed_specialist"]) ? self.pers[#"changed_specialist"] : 0)) {
        bundlename = self.var_4d52496f;
    }
    playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
    if (!isdefined(playerbundle)) {
        return;
    }
    if (self isplayerunderwater()) {
        return playerbundle.exertdeathdrowned;
    }
    if (isdefined(meansofdeath)) {
        switch (meansofdeath) {
        case #"mod_burned":
            return playerbundle.exertdeathburned;
        case #"mod_melee_weapon_butt":
            return playerbundle.exertdeathstabbed;
        case #"mod_head_shot":
            return playerbundle.var_cf373d27;
        case #"mod_trigger_hurt":
            if (self getvelocity()[2] < -100) {
                return playerbundle.var_a3af7d2e;
            } else {
                return playerbundle.exertdeath;
            }
        case #"mod_dot":
        case #"mod_drown":
        case #"mod_dot_self":
            if (isdefined(self.suicide) && self.suicide) {
                return playerbundle.var_38a355ae;
            }
            if (weapon.doesfiredamage) {
                return playerbundle.exertdeathburned;
            }
            return playerbundle.exertdeathdrowned;
        }
    }
    if (isdefined(weapon) && meansofdeath !== "MOD_MELEE_WEAPON_BUTT") {
        switch (weapon.rootweapon.name) {
        case #"knife_loadout":
        case #"hatchet":
        case #"hero_armblade":
            return playerbundle.exertdeathstabbed;
        case #"hero_firefly_swarm":
            return playerbundle.exertdeathburned;
        case #"shock_rifle":
        case #"hero_lightninggun":
        case #"hero_lightninggun_arc":
            return playerbundle.exertdeathelectrocuted;
        }
    }
    return playerbundle.exertdeath;
}

// Namespace battlechatter/battlechatter
// Params 1, eflags: 0x0
// Checksum 0x4e5451e, Offset: 0x6c68
// Size: 0x124
function function_a135f102(var_129fa37a) {
    if (!level.allowspecialistdialog) {
        return;
    }
    if (!isdefined(self) || !isdefined(var_129fa37a) || !isdefined(self.team) || !isdefined(var_129fa37a.team) || !isdefined(var_129fa37a.killstreaktype) || !isplayer(self)) {
        return;
    }
    if (self.team != var_129fa37a.team && !(isdefined(var_129fa37a.var_9dd74129) && var_129fa37a.var_9dd74129)) {
        closest_ally = self get_closest_player_ally(1);
        if (!isdefined(closest_ally)) {
            return;
        }
        var_129fa37a.var_9dd74129 = 1;
        self play_killstreak_threat(var_129fa37a.killstreaktype);
    }
}

// Namespace battlechatter/battlechatter
// Params 1, eflags: 0x0
// Checksum 0xd01ff823, Offset: 0x6d98
// Size: 0x74
function play_killstreak_threat(killstreaktype) {
    if (!level.allowspecialistdialog || !isdefined(killstreaktype) || !isdefined(level.killstreaks[killstreaktype])) {
        return;
    }
    self thread play_dialog(level.killstreaks[killstreaktype].threatdialogkey, 1);
}

// Namespace battlechatter/battlechatter
// Params 2, eflags: 0x0
// Checksum 0xda349700, Offset: 0x6e18
// Size: 0xfc
function function_b5530e2c(killstreaktype, weapon) {
    if (!level.allowspecialistdialog || !isdefined(killstreaktype) || !isdefined(level.killstreaks[killstreaktype]) || !isdefined(self) || !isdefined(weapon)) {
        return;
    }
    if (isdefined(level.iskillstreakweapon)) {
        if ([[ level.iskillstreakweapon ]](weapon) || isdefined(weapon.statname) && [[ level.iskillstreakweapon ]](getweapon(weapon.statname))) {
            return;
        }
    }
    self thread play_dialog(level.killstreaks[killstreaktype].var_5b8c204f);
}

// Namespace battlechatter/battlechatter
// Params 6, eflags: 0x0
// Checksum 0x378b6306, Offset: 0x6f20
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

// Namespace battlechatter/battlechatter
// Params 2, eflags: 0x0
// Checksum 0x429d1095, Offset: 0x6fd8
// Size: 0x124
function function_7c1fe73f(dialogkey, entity) {
    self endon(#"death");
    level endon(#"game_ended");
    if (isdefined(self.playingdialog) && self.playingdialog || self isplayerunderwater() || !isdefined(self) || !isdefined(entity) || !isplayer(entity)) {
        return;
    }
    dialogalias = entity get_player_dialog_alias(dialogkey, undefined);
    if (isdefined(dialogalias)) {
        entity playsoundtoplayer(dialogalias, self);
        self thread wait_dialog_buffer(mpdialog_value("killstreakDialogBuffer", 0));
    }
}

// Namespace battlechatter/battlechatter
// Params 4, eflags: 0x0
// Checksum 0xfc9dc87a, Offset: 0x7108
// Size: 0x2fc
function play_dialog(dialogkey, dialogflags, dialogbuffer, enemy) {
    self endon(#"death");
    level endon(#"game_ended");
    if (!isdefined(dialogkey) || !isplayer(self) || !isalive(self) || level.gameended) {
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
    dialogalias = self get_player_dialog_alias(dialogkey, undefined);
    if (!isdefined(dialogalias)) {
        return;
    }
    if (self isplayerunderwater() && !(dialogflags & 8)) {
        return;
    }
    if (isdefined(self.playingdialog) && self.playingdialog) {
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

// Namespace battlechatter/battlechatter
// Params 6, eflags: 0x0
// Checksum 0x9e642275, Offset: 0x7410
// Size: 0xac
function function_b318503c(waittime, dialogalias, dialogflags, dialogbuffer, enemy, endnotify) {
    self endon(#"death");
    level endon(#"game_ended");
    if (isdefined(waittime) && waittime > 0) {
        if (isdefined(endnotify)) {
            self endon(endnotify);
        }
        wait waittime;
    }
    self thread function_9e201b50(dialogalias, dialogflags, dialogbuffer, enemy);
}

// Namespace battlechatter/battlechatter
// Params 4, eflags: 0x0
// Checksum 0x514ea656, Offset: 0x74c8
// Size: 0x26c
function function_9e201b50(dialogalias, dialogflags, dialogbuffer, enemy) {
    self endon(#"death");
    level endon(#"game_ended");
    if (!isdefined(dialogalias) || !isplayer(self) || !isalive(self) || level.gameended) {
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
    if (self isplayerunderwater() && !(dialogflags & 8)) {
        return;
    }
    if (isdefined(self.playingdialog) && self.playingdialog) {
        if (!(dialogflags & 4)) {
            return;
        }
        self stopsounds();
        waitframe(1);
    }
    if (dialogflags & 32) {
        self.playinggadgetreadydialog = 1;
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

// Namespace battlechatter/battlechatter
// Params 1, eflags: 0x0
// Checksum 0x27f034f7, Offset: 0x7740
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

// Namespace battlechatter/battlechatter
// Params 0, eflags: 0x0
// Checksum 0x7fab907e, Offset: 0x77e0
// Size: 0x42
function stop_dialog() {
    self notify(#"stop_dialog");
    self stopsounds();
    self.playingdialog = 0;
    self.playinggadgetreadydialog = 0;
}

// Namespace battlechatter/battlechatter
// Params 1, eflags: 0x0
// Checksum 0xc1f9561d, Offset: 0x7830
// Size: 0xc
function wait_playback_time(soundalias) {
    
}

// Namespace battlechatter/battlechatter
// Params 2, eflags: 0x0
// Checksum 0x29297d76, Offset: 0x7848
// Size: 0x112
function get_player_dialog_alias(dialogkey, meansofdeath) {
    if (!isplayer(self)) {
        return undefined;
    }
    bundlename = self getmpdialogname();
    if (isdefined(meansofdeath) && meansofdeath == "MOD_META" && (isdefined(self.pers[#"changed_specialist"]) ? self.pers[#"changed_specialist"] : 0)) {
        bundlename = self.var_4d52496f;
    }
    if (!isdefined(bundlename)) {
        return undefined;
    }
    playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
    if (!isdefined(playerbundle)) {
        return undefined;
    }
    return globallogic_audio::get_dialog_bundle_alias(playerbundle, dialogkey);
}

// Namespace battlechatter/battlechatter
// Params 2, eflags: 0x0
// Checksum 0x17d4b26d, Offset: 0x7968
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

// Namespace battlechatter/battlechatter
// Params 1, eflags: 0x0
// Checksum 0x82a4071e, Offset: 0x7a40
// Size: 0xdc
function get_random_key(dialogkey) {
    bundlename = self getmpdialogname();
    if (!isdefined(bundlename)) {
        return undefined;
    }
    playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
    if (!isdefined(playerbundle) || !isdefined(playerbundle.keycounts) || !isdefined(playerbundle.keycounts[dialogkey]) || playerbundle.keycounts[dialogkey] == 0) {
        return dialogkey;
    }
    return dialogkey + randomint(playerbundle.keycounts[dialogkey]);
}

// Namespace battlechatter/battlechatter
// Params 2, eflags: 0x0
// Checksum 0x13b0970, Offset: 0x7b28
// Size: 0x754
function play_gadget_ready(weapon, userflip = 0) {
    if (!isdefined(weapon) || !level.allowspecialistdialog || gettime() - level.starttime < int(mpdialog_value("readyAudioDelay", 0) * 1000)) {
        return;
    }
    dialogkey = undefined;
    bundlename = self getmpdialogname();
    if (!isdefined(bundlename)) {
        return;
    }
    playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
    if (!isdefined(playerbundle)) {
        return;
    }
    switch (weapon.name) {
    case #"hero_annihilator":
        dialogkey = playerbundle.annihilatorweaponready;
        break;
    case #"sig_buckler_dw":
    case #"hero_minigun":
        dialogkey = playerbundle.var_3a564001;
        break;
    case #"eq_localheal":
        dialogkey = playerbundle.var_2bd9b576;
        break;
    case #"gadget_health_boost":
    case #"gadget_cleanse":
        dialogkey = playerbundle.var_a3edcd9;
        break;
    case #"ability_dog":
        dialogkey = playerbundle.var_86409ae2;
        break;
    case #"hero_gravityspikes":
    case #"eq_gravityslam":
        dialogkey = playerbundle.var_f766bfa3;
        break;
    case #"shock_rifle":
    case #"hero_lightninggun":
    case #"hero_lightninggun_arc":
        dialogkey = playerbundle.tempestweaponready;
        break;
    case #"sig_minigun":
        dialogkey = playerbundle.var_3ca508a1;
        break;
    case #"gadget_spawnbeacon":
        dialogkey = playerbundle.combatfocusabilityready;
        break;
    case #"ability_smart_cover":
        dialogkey = playerbundle.var_f505e0a6;
        break;
    case #"mute_smoke":
        dialogkey = playerbundle.var_a8a6324a;
        break;
    case #"hero_flamethrower":
        dialogkey = playerbundle.purifierweaponready;
        break;
    case #"gadget_radiation_field":
        dialogkey = playerbundle.var_e4020be7;
        break;
    case #"hero_bowlauncher2":
    case #"hero_bowlauncher3":
    case #"hero_bowlauncher4":
    case #"sig_bow_quickshot":
    case #"hero_bowlauncher":
        dialogkey = playerbundle.sparrowweaponready;
        break;
    case #"gadget_supplypod":
        dialogkey = playerbundle.var_a5ac0b62;
        break;
    case #"gadget_vision_pulse":
        dialogkey = playerbundle.visionpulseabilityready;
        break;
    case #"hash_26257539b3c6195b":
    case #"hero_pineapplegun":
        dialogkey = playerbundle.warmachineweaponready;
        break;
    default:
        return;
    }
    if (!(isdefined(self.isthief) && self.isthief) && !(isdefined(self.isroulette) && self.isroulette)) {
        self thread function_9e201b50(dialogkey);
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
            generickey = playerbundle.thiefweaponready;
            repeatkey = playerbundle.thiefweaponrepeat;
            repeatthresholdkey = "thiefRepeatThreshold";
            chancekey = "thiefReadyChance";
            delaykey = "thiefRevealDelay";
        } else {
            generickey = playerbundle.rouletteabilityready;
            repeatkey = playerbundle.rouletteabilityrepeat;
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
    self thread function_b318503c(waittime, dialogkey, dialogflags, undefined, undefined, undefined);
}

// Namespace battlechatter/battlechatter
// Params 2, eflags: 0x0
// Checksum 0x57f2a4f1, Offset: 0x8288
// Size: 0x14c
function function_1b64a6b6(dogstate, dog) {
    if (!level.allowspecialistdialog) {
        return;
    }
    if (!isdefined(dogstate)) {
        return;
    }
    if (!isdefined(self.script_owner) || !isplayer(self.script_owner)) {
        return;
    }
    bundlename = self.script_owner getmpdialogname();
    if (!isdefined(bundlename)) {
        return;
    }
    playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
    if (!isdefined(playerbundle)) {
        return;
    }
    dialogkey = undefined;
    switch (dogstate) {
    case 0:
        dialogkey = playerbundle.var_f9b78c27;
        break;
    case 1:
        dialogkey = playerbundle.var_a85c7ffe;
        break;
    default:
        return;
    }
    self.script_owner thread function_9e201b50(dialogkey);
}

// Namespace battlechatter/battlechatter
// Params 1, eflags: 0x0
// Checksum 0xe7caed4c, Offset: 0x83e0
// Size: 0x2ac
function function_d7091e26(var_da55018b) {
    if (!isdefined(var_da55018b) || !isdefined(self) || !level.allowspecialistdialog || !isplayer(self) || self isplayerunderwater()) {
        return;
    }
    if (!isdefined(self.lastcallouttime)) {
        self.lastcallouttime = 0;
    }
    specialistname = self getmpdialogname();
    if (!isdefined(specialistname) || self.lastcallouttime > gettime() || isdefined(self.playingdialog) && self.playingdialog) {
        return;
    }
    switch (specialistname) {
    case #"battery":
        dialogalias = var_da55018b.var_47924198;
        break;
    case #"buffassault":
        dialogalias = var_da55018b.var_b9a17d3e;
        break;
    case #"engineer":
        dialogalias = var_da55018b.var_73ea08d6;
        break;
    case #"firebreak":
        dialogalias = var_da55018b.var_87c7bb92;
        break;
    case #"nomad":
        dialogalias = var_da55018b.var_45ac76c2;
        break;
    case #"prophet":
        dialogalias = var_da55018b.var_7b80b623;
        break;
    case #"recon":
        dialogalias = var_da55018b.var_b8750766;
        break;
    case #"ruin":
        dialogalias = var_da55018b.var_e3d66215;
        break;
    case #"seraph":
        dialogalias = var_da55018b.var_8020db02;
        break;
    case #"swatpolice":
        dialogalias = var_da55018b.var_cc1a02e8;
        break;
    default:
        return;
    }
    cooldown = mpdialog_value("specialistCalloutCoolDown", 0);
    self.lastcallouttime = gettime() + cooldown;
    self thread function_9e201b50(dialogalias);
}

// Namespace battlechatter/battlechatter
// Params 2, eflags: 0x0
// Checksum 0x707b469b, Offset: 0x8698
// Size: 0x104
function function_22c87d44(dialogkey, var_9d054ced) {
    if (!level.allowspecialistdialog || !isdefined(dialogkey) || !isdefined(self) || !isplayer(self) || self isplayerunderwater()) {
        return;
    }
    dialogbuffer = mpdialog_value("killstreakDialogBuffer", 0);
    self play_dialog(dialogkey, 6, dialogbuffer, undefined);
    var_9e15e384 = self get_player_dialog_alias(var_9d054ced, undefined);
    if (isdefined(var_9e15e384)) {
        self function_444351e(var_9e15e384, dialogbuffer);
    }
}

// Namespace battlechatter/battlechatter
// Params 1, eflags: 0x0
// Checksum 0x1238d86f, Offset: 0x87a8
// Size: 0x22c
function function_9bd04d84(weapon) {
    if (!isdefined(weapon) || !level.allowspecialistdialog || !isdefined(self) || !isplayer(self) || !isalive(self) || level.gameended || self isplayerunderwater()) {
        return;
    }
    bundlename = self getmpdialogname();
    if (!isdefined(bundlename)) {
        return;
    }
    playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
    if (!isdefined(playerbundle)) {
        return;
    }
    switch (weapon.name) {
    case #"eq_concertina_wire":
        dialogkey = playerbundle.var_ee7144fb;
        var_d604f1e9 = playerbundle.var_b8b1325e;
        break;
    case #"ability_smart_cover":
        dialogkey = playerbundle.var_fc8d624e;
        var_d604f1e9 = playerbundle.var_d33e6317;
        break;
    case #"gadget_spawnbeacon":
        dialogkey = playerbundle.var_9ee1ee4b;
        var_d604f1e9 = playerbundle.var_b846450e;
        break;
    case #"gadget_supplypod":
        dialogkey = playerbundle.var_2116b5ea;
        var_d604f1e9 = playerbundle.var_18e8539b;
        break;
    default:
        return;
    }
    self thread function_9e201b50(dialogkey, undefined, undefined, undefined);
    if (isdefined(var_d604f1e9)) {
        self function_444351e(var_d604f1e9, undefined);
    }
}

// Namespace battlechatter/battlechatter
// Params 1, eflags: 0x0
// Checksum 0x8c34939e, Offset: 0x89e0
// Size: 0x2ac
function function_4906a3fd(weapon) {
    if (!level.allowspecialistdialog || !isdefined(weapon) || !isdefined(self) || !isplayer(self) || !isalive(self) || level.gameended || (isdefined(self.var_98085641) ? self.var_98085641 : 0) > gettime() || self isplayerunderwater()) {
        return;
    }
    bundlename = self getmpdialogname();
    if (!isdefined(bundlename)) {
        return;
    }
    playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
    if (!isdefined(playerbundle)) {
        return;
    }
    switch (weapon.name) {
    case #"eq_concertina_wire":
        dialogkey = playerbundle.var_5207eb3;
        break;
    case #"dog_ai_defaultmelee":
        dialogkey = playerbundle.var_2d24198a;
        break;
    case #"eq_localheal":
        dialogkey = playerbundle.var_1b41619e;
        break;
    case #"ability_smart_cover":
        dialogkey = playerbundle.var_3d68e9ce;
        break;
    case #"gadget_spawnbeacon":
        dialogkey = playerbundle.var_df342e03;
        break;
    case #"gadget_supplypod":
        dialogkey = playerbundle.var_24d23e0a;
        break;
    default:
        return;
    }
    if (isdefined(dialogkey)) {
        self.var_98085641 = gettime() + int(mpdialog_value("useFailDelay", 5) * 1000);
        self playsoundtoplayer(dialogkey, self);
        self thread wait_dialog_buffer(mpdialog_value("playerDialogBuffer", 0));
    }
}

// Namespace battlechatter/battlechatter
// Params 1, eflags: 0x0
// Checksum 0xfe6a9e19, Offset: 0x8c98
// Size: 0x53c
function play_gadget_activate(weapon) {
    if (!isdefined(weapon) || !level.allowspecialistdialog || self isplayerunderwater()) {
        return;
    }
    bundlename = self getmpdialogname();
    if (!isdefined(bundlename)) {
        return;
    }
    playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
    if (!isdefined(playerbundle)) {
        return;
    }
    dialogkey = undefined;
    dialogflags = 1;
    switch (weapon.name) {
    case #"hero_annihilator":
        dialogkey = playerbundle.annihilatorweaponuse;
        break;
    case #"sig_buckler_dw":
        dialogkey = playerbundle.var_a1ae9765;
        break;
    case #"gadget_health_boost":
    case #"gadget_cleanse":
        dialogkey = playerbundle.var_cbbfc0cd;
        break;
    case #"hatchet":
        dialogkey = playerbundle.var_61e8b944;
        break;
    case #"eq_slow_grenade":
    case #"concussion_grenade":
        dialogkey = playerbundle.var_ff5fa662;
        break;
    case #"eq_swat_grenade":
    case #"hash_3f62a872201cd1ce":
    case #"hash_5825488ac68418af":
        dialogkey = playerbundle.var_9f1c5f1c;
        break;
    case #"frag_grenade":
        dialogkey = playerbundle.var_7cb86cbe;
        break;
    case #"eq_grapple":
        dialogkey = playerbundle.grapplegunweaponuse;
        dialogbuffer = 0.05;
        break;
    case #"eq_gravityslam":
        if (grapple::function_b06e88c(self, undefined, undefined, undefined)) {
            dialogkey = playerbundle.var_9a8ca757;
            dialogflags = 22;
            dialogbuffer = 0.05;
        }
        break;
    case #"eq_localheal":
        if (isdefined(self.var_e7dbe562) && self.var_e7dbe562) {
            dialogkey = playerbundle.var_341a3d5e;
            var_d604f1e9 = playerbundle.var_514a0a87;
            self.var_e7dbe562 = undefined;
        } else {
            return;
        }
        break;
    case #"mini_turret":
        dialogkey = playerbundle.var_919cf6e7;
        break;
    case #"eq_molotov":
        dialogkey = playerbundle.var_a7da5d32;
        break;
    case #"mute_smoke":
        dialogkey = playerbundle.var_7267ccc2;
        break;
    case #"hero_flamethrower":
        self function_b505bc94(weapon, self, self.origin, self);
        dialogkey = playerbundle.purifierweaponuse;
        break;
    case #"gadget_radiation_field":
        dialogkey = playerbundle.var_e297d9bb;
        break;
    case #"eq_seeker_mine":
    case #"hash_4e068a4937a333f7":
        dialogkey = playerbundle.var_673f91e6;
        break;
    case #"eq_sticky_grenade":
    case #"eq_cluster_semtex_grenade":
        dialogkey = playerbundle.var_13ffd872;
        break;
    case #"eq_sensor":
        dialogkey = playerbundle.var_e7d2fa11;
        var_d604f1e9 = playerbundle.var_870246ec;
        break;
    case #"eq_tripwire":
        dialogkey = playerbundle.var_299659f8;
        break;
    case #"trophy_system":
        dialogkey = playerbundle.var_c3fda595;
        break;
    case #"gadget_vision_pulse":
        dialogkey = playerbundle.visionpulseabilityuse;
        var_d604f1e9 = playerbundle.var_ef21adca;
        break;
    default:
        return;
    }
    self thread function_9e201b50(dialogkey, dialogflags, dialogbuffer, undefined);
    if (isdefined(var_d604f1e9)) {
        self function_444351e(var_d604f1e9, dialogbuffer);
    }
}

// Namespace battlechatter/battlechatter
// Params 2, eflags: 0x4
// Checksum 0x289e2887, Offset: 0x91e0
// Size: 0x218
function private function_444351e(var_9e15e384, dialogbuffer) {
    if (!isdefined(self) || !isplayer(self) || !isdefined(var_9e15e384)) {
        return;
    }
    if (!isdefined(dialogbuffer)) {
        dialogbuffer = mpdialog_value("playerDialogBuffer", 0);
    }
    teamarray = getplayers(self.team);
    localplayers = getplayers(self.team, self.origin, 1200);
    foreach (localplayer in localplayers) {
        arrayremovevalue(teamarray, localplayer, 0);
    }
    foreach (player in teamarray) {
        if (!isdefined(player) || !isalive(player) || isdefined(player.playingdialog) && player.playingdialog) {
            continue;
        }
        player playsoundtoplayer(var_9e15e384, player);
        player thread wait_dialog_buffer(dialogbuffer);
    }
}

// Namespace battlechatter/battlechatter
// Params 4, eflags: 0x0
// Checksum 0x478513ed, Offset: 0x9400
// Size: 0x2bc
function play_gadget_success(weapon, waitkey, victim, var_2f030098) {
    if (!isdefined(weapon) || !level.allowspecialistdialog) {
        return;
    }
    dialogkey = undefined;
    var_29f687b1 = undefined;
    bundlename = self getmpdialogname();
    if (!isdefined(bundlename)) {
        return;
    }
    playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
    if (!isdefined(playerbundle)) {
        return;
    }
    switch (weapon.name) {
    case #"gadget_health_boost":
    case #"gadget_cleanse":
        dialogkey = playerbundle.var_8646c2ed;
        break;
    case #"eq_concertina_wire":
        dialogkey = playerbundle.var_8eff7f3b;
        break;
    case #"eq_swat_grenade":
    case #"hash_3f62a872201cd1ce":
    case #"hash_5825488ac68418af":
        dialogkey = playerbundle.var_44ff4930;
        break;
    case #"eq_grapple":
        dialogkey = playerbundle.var_a0c2c95;
        break;
    case #"molotov_fire":
    case #"eq_molotov":
        dialogkey = playerbundle.var_f0e3eed6;
        break;
    case #"gadget_radiation_field":
        dialogkey = playerbundle.var_2624d3fb;
        break;
    case #"eq_sensor":
        dialogkey = playerbundle.var_6d5f20b1;
        break;
    case #"gadget_supplypod":
        dialogkey = playerbundle.var_56a7a90e;
        break;
    case #"gadget_vision_pulse":
        dialogkey = playerbundle.visionpulseabilitysuccess;
        break;
    case #"eq_localheal":
        dialogkey = playerbundle.var_c7a7d6e2;
        break;
    default:
        return;
    }
    if (isdefined(dialogkey)) {
        self.playedgadgetsuccess = 1;
        self thread function_a3098aa3(dialogkey, weapon, undefined, var_2f030098);
    }
}

// Namespace battlechatter/battlechatter
// Params 0, eflags: 0x0
// Checksum 0x54398c91, Offset: 0x96c8
// Size: 0x44
function play_throw_hatchet() {
    self thread play_dialog("exertAxeThrow", 21, mpdialog_value("playerExertBuffer", 0));
}

// Namespace battlechatter/battlechatter
// Params 0, eflags: 0x0
// Checksum 0xafaa60eb, Offset: 0x9718
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

// Namespace battlechatter/battlechatter
// Params 0, eflags: 0x0
// Checksum 0xe957148, Offset: 0x98b8
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

// Namespace battlechatter/battlechatter
// Params 1, eflags: 0x0
// Checksum 0x99e9a63f, Offset: 0x9970
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

// Namespace battlechatter/battlechatter
// Params 2, eflags: 0x0
// Checksum 0x729d85d, Offset: 0x9a78
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

// Namespace battlechatter/battlechatter
// Params 1, eflags: 0x0
// Checksum 0xe06e2763, Offset: 0x9b68
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

// Namespace battlechatter/battlechatter
// Params 0, eflags: 0x0
// Checksum 0x7f7e1299, Offset: 0x9c68
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

// Namespace battlechatter/battlechatter
// Params 2, eflags: 0x0
// Checksum 0xf0a7a6da, Offset: 0x9e28
// Size: 0x72
function pick_boost_players(player1, player2) {
    player1 clientfield::set("play_boost", 1);
    player2 clientfield::set("play_boost", 2);
    game.boostplayerspicked[player1.team] = 1;
}

// Namespace battlechatter/battlechatter
// Params 1, eflags: 0x0
// Checksum 0xe9d44ca3, Offset: 0x9ea8
// Size: 0x1e8
function game_end_vox(winner) {
    if (!level.allowspecialistdialog) {
        return;
    }
    foreach (player in level.players) {
        if (player issplitscreen()) {
            continue;
        }
        bundlename = player getmpdialogname();
        if (!isdefined(bundlename)) {
            return;
        }
        playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
        if (!isdefined(playerbundle)) {
            return;
        }
        if (match::get_flag("tie")) {
            dialogkey = playerbundle.boostdraw;
        } else if (isdefined(winner) && level.teambased && isdefined(level.teams[winner]) && player.pers[#"team"] == winner || !level.teambased && player == winner) {
            dialogkey = playerbundle.boostwin;
        } else {
            dialogkey = playerbundle.boostloss;
        }
        if (isdefined(dialogkey)) {
            player playlocalsound(dialogkey);
        }
    }
}

/#

    // Namespace battlechatter/battlechatter
    // Params 0, eflags: 0x0
    // Checksum 0xbbcb2f58, Offset: 0xa098
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

    // Namespace battlechatter/battlechatter
    // Params 1, eflags: 0x0
    // Checksum 0x9ab0d964, Offset: 0xa4a8
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

    // Namespace battlechatter/battlechatter
    // Params 1, eflags: 0x0
    // Checksum 0xf51bcd60, Offset: 0xa598
    // Size: 0x64
    function test_player_dialog(delay) {
        if (!isdefined(delay)) {
            delay = 0;
        }
        wait delay;
        self playsoundontag(getdvarstring(#"testalias_player", "<dev string:xb0>"), "<dev string:x107>");
    }

    // Namespace battlechatter/battlechatter
    // Params 1, eflags: 0x0
    // Checksum 0x2f4c44fe, Offset: 0xa608
    // Size: 0x5c
    function test_taacom_dialog(delay) {
        if (!isdefined(delay)) {
            delay = 0;
        }
        wait delay;
        self playlocalsound(getdvarstring(#"testalias_taacom", "<dev string:xb0>"));
    }

    // Namespace battlechatter/battlechatter
    // Params 1, eflags: 0x0
    // Checksum 0x54218a25, Offset: 0xa670
    // Size: 0x5c
    function test_commander_dialog(delay) {
        if (!isdefined(delay)) {
            delay = 0;
        }
        wait delay;
        self playlocalsound(getdvarstring(#"testalias_commander", "<dev string:xb0>"));
    }

    // Namespace battlechatter/battlechatter
    // Params 1, eflags: 0x0
    // Checksum 0x90f8d3e, Offset: 0xa6d8
    // Size: 0x54
    function play_test_dialog(dialogkey) {
        dialogalias = self get_player_dialog_alias(dialogkey, undefined);
        self playsoundontag(dialogalias, "<dev string:x107>");
    }

    // Namespace battlechatter/battlechatter
    // Params 0, eflags: 0x0
    // Checksum 0x7a7ae1f6, Offset: 0xa738
    // Size: 0x10c
    function response_key() {
        switch (self getmpdialogname()) {
        case #"spectre":
            return "<dev string:x10e>";
        case #"battery":
            return "<dev string:x116>";
        case #"outrider":
            return "<dev string:x11e>";
        case #"prophet":
            return "<dev string:x127>";
        case #"firebreak":
            return "<dev string:x12f>";
        case #"reaper":
            return "<dev string:x139>";
        case #"ruin":
            return "<dev string:x140>";
        case #"seraph":
            return "<dev string:x145>";
        case #"nomad":
            return "<dev string:x14c>";
        }
        return "<dev string:xb0>";
    }

    // Namespace battlechatter/battlechatter
    // Params 0, eflags: 0x0
    // Checksum 0x3c4acff7, Offset: 0xa850
    // Size: 0x13c
    function play_conv_self_other() {
        num = randomintrange(0, 4);
        self play_test_dialog("<dev string:x152>" + num);
        wait 4;
        players = arraysort(level.players, self.origin);
        foreach (player in players) {
            if (player != self && isalive(player)) {
                player play_test_dialog("<dev string:x15d>" + self response_key() + num);
                break;
            }
        }
    }

    // Namespace battlechatter/battlechatter
    // Params 0, eflags: 0x0
    // Checksum 0x2e9d1b02, Offset: 0xa998
    // Size: 0x13c
    function play_conv_other_self() {
        num = randomintrange(0, 4);
        players = arraysort(level.players, self.origin);
        foreach (player in players) {
            if (player != self && isalive(player)) {
                player play_test_dialog("<dev string:x152>" + num);
                break;
            }
        }
        wait 4;
        self play_test_dialog("<dev string:x15d>" + player response_key() + num);
    }

    // Namespace battlechatter/battlechatter
    // Params 0, eflags: 0x0
    // Checksum 0xe409439, Offset: 0xaae0
    // Size: 0x1dc
    function play_conv_other_other() {
        num = randomintrange(0, 4);
        players = arraysort(level.players, self.origin);
        foreach (player in players) {
            if (player != self && isalive(player)) {
                player play_test_dialog("<dev string:x152>" + num);
                firstplayer = player;
                break;
            }
        }
        wait 4;
        foreach (player in players) {
            if (player != self && player !== firstplayer && isalive(player)) {
                player play_test_dialog("<dev string:x15d>" + firstplayer response_key() + num);
                break;
            }
        }
    }

#/
