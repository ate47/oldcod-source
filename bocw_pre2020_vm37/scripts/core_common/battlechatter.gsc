#using script_1f17c601c8e8824c;
#using script_396f7d71538c9677;
#using script_6d9bde564029bdf6;
#using script_725554a59d6a75b9;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\weapons\weapon_utils;

#namespace battlechatter;

// Namespace battlechatter/battlechatter
// Params 0, eflags: 0x6
// Checksum 0x75897d11, Offset: 0x470
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"battlechatter", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace battlechatter/battlechatter
// Params 0, eflags: 0x5 linked
// Checksum 0xd7221cbc, Offset: 0x4b8
// Size: 0x270
function private function_70a657d8() {
    /#
        level thread devgui_think();
    #/
    callback::on_spawned(&on_player_spawned);
    if (is_true(level.teambased) && !isdefined(game.boostplayerspicked)) {
        game.boostplayerspicked = [];
        foreach (team, _ in level.teams) {
            game.boostplayerspicked[team] = 0;
        }
    }
    level.allowbattlechatter[#"bc"] = currentsessionmode() != 4 && (isdefined(getgametypesetting(#"allowbattlechatter")) ? getgametypesetting(#"allowbattlechatter") : 0);
    mpdialog = getscriptbundle("mpdialog_default");
    if (!isdefined(mpdialog)) {
        mpdialog = spawnstruct();
    }
    level.allowspecialistdialog = (isdefined(mpdialog.enableherodialog) ? mpdialog.enableherodialog : 0) && is_true(level.allowbattlechatter[#"bc"]);
    level.playstartconversation = (isdefined(mpdialog.enableconversation) ? mpdialog.enableconversation : 0) && is_true(level.allowbattlechatter[#"bc"]);
}

// Namespace battlechatter/battlechatter
// Params 0, eflags: 0x1 linked
// Checksum 0xcb8c9091, Offset: 0x730
// Size: 0xdc
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
    self.var_6765d33e = 0;
    self.playedgadgetsuccess = 1;
    self callback::add_callback("weapon_melee", &function_59f9cdab);
    self callback::add_callback("weapon_melee_charge", &function_59f9cdab);
}

// Namespace battlechatter/battlechatter
// Params 6, eflags: 0x0
// Checksum 0x7ef8eda4, Offset: 0x818
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

// Namespace battlechatter/battlechatter
// Params 3, eflags: 0x0
// Checksum 0x70fc64bf, Offset: 0x8c8
// Size: 0x1e4
function function_f57e565f(dialogkey, entity, waittime) {
    self endon(#"death");
    level endon(#"game_ended");
    if (!isdefined(self) || is_true(self.playingdialog) || !isplayer(self) || !isdefined(entity) || self == entity && self isplayerunderwater() || !isplayer(entity)) {
        return;
    }
    dialogalias = entity get_player_dialog_alias(dialogkey, undefined);
    if (isdefined(waittime) && waittime > 0) {
        wait waittime;
        if (!isdefined(self) || is_true(self.playingdialog) || !isplayer(self) || !isdefined(entity) || self == entity && self isplayerunderwater() || !isplayer(entity)) {
            return;
        }
    }
    if (isdefined(dialogalias)) {
        self playsoundtoplayer(dialogalias, self);
        self thread wait_dialog_buffer(mpdialog_value("killstreakDialogBuffer", 0));
    }
}

// Namespace battlechatter/battlechatter
// Params 4, eflags: 0x1 linked
// Checksum 0xf912ea83, Offset: 0xab8
// Size: 0x64
function play_dialog(dialogkey, dialogflags, dialogbuffer, enemy) {
    dialogalias = self get_player_dialog_alias(dialogkey, undefined);
    function_a48c33ff(dialogalias, dialogflags, dialogbuffer, enemy);
}

// Namespace battlechatter/battlechatter
// Params 6, eflags: 0x1 linked
// Checksum 0x2f0e15e6, Offset: 0xb28
// Size: 0xa4
function function_5896274(waittime, dialogalias, dialogflags, dialogbuffer, enemy, endnotify) {
    self endon(#"death");
    level endon(#"game_ended");
    if (isdefined(waittime) && waittime > 0) {
        if (isdefined(endnotify)) {
            self endon(endnotify);
        }
        wait waittime;
    }
    self thread function_a48c33ff(dialogalias, dialogflags, dialogbuffer, enemy);
}

// Namespace battlechatter/battlechatter
// Params 4, eflags: 0x1 linked
// Checksum 0x642ddb51, Offset: 0xbd8
// Size: 0x3a4
function function_a48c33ff(dialogalias, dialogflags, dialogbuffer, enemy) {
    self endon(#"death");
    var_c84adc7e = !sessionmodeiswarzonegame() || !isdefined(dialogflags) || dialogflags & 128;
    if (!var_c84adc7e) {
        level endon(#"game_ended");
    }
    if (!isdefined(dialogalias) || !isplayer(self) || !isalive(self) || level.gameended && !var_c84adc7e) {
        return;
    }
    if (!isdefined(dialogflags)) {
        dialogflags = 0;
    }
    if (!is_true(level.allowspecialistdialog) && (dialogflags & 16) == 0) {
        return;
    }
    if (!isdefined(dialogbuffer)) {
        dialogbuffer = mpdialog_value("playerDialogBuffer", 0);
    }
    if (self isplayerunderwater() && !(dialogflags & 8)) {
        return;
    }
    if (is_true(self.playingdialog)) {
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
        if (self hasdobj() && self haspart("J_Head")) {
            self playsoundontag(dialogalias, "J_Head");
        }
    } else if (dialogflags & 1) {
        if (self hasdobj() && self haspart("J_Head")) {
            if (isdefined(enemy)) {
                self playsoundontag(dialogalias, "J_Head", self.team, enemy);
            } else {
                self playsoundontag(dialogalias, "J_Head", self.team);
            }
        }
    } else {
        self playlocalsound(dialogalias);
    }
    self notify(#"played_dialog");
    self thread wait_dialog_buffer(dialogbuffer);
}

// Namespace battlechatter/battlechatter
// Params 1, eflags: 0x1 linked
// Checksum 0xa19cec19, Offset: 0xf88
// Size: 0x9e
function wait_dialog_buffer(dialogbuffer) {
    self endon(#"death", #"played_dialog", #"stop_dialog");
    level endon(#"game_ended");
    self.playingdialog = 1;
    if (isdefined(dialogbuffer) && dialogbuffer > 0) {
        wait dialogbuffer;
    }
    self.playingdialog = 0;
    self.var_6765d33e = 0;
    self.playinggadgetreadydialog = 0;
}

// Namespace battlechatter/battlechatter
// Params 0, eflags: 0x1 linked
// Checksum 0x2b23b4fa, Offset: 0x1030
// Size: 0x4e
function stop_dialog() {
    self notify(#"stop_dialog");
    self stopsounds();
    self.playingdialog = 0;
    self.var_6765d33e = 0;
    self.playinggadgetreadydialog = 0;
}

// Namespace battlechatter/battlechatter
// Params 6, eflags: 0x1 linked
// Checksum 0x934a0afa, Offset: 0x1088
// Size: 0x124
function function_9d4a3d68(var_11317dc8, speakingplayer, var_df336ed3, weapon, startdelay, var_44e63719) {
    level endon(#"game_ended");
    speakingplayer endon(#"disconnect");
    assert(isdefined(var_11317dc8));
    assert(isplayer(speakingplayer));
    startdelay = isdefined(startdelay) ? startdelay : 0;
    var_44e63719 = isdefined(var_44e63719) ? var_44e63719 : 4;
    if (startdelay > 0) {
        wait startdelay;
        if (!isdefined(speakingplayer)) {
            return;
        }
    }
    speakingplayer function_18aba49d(var_11317dc8, weapon, var_df336ed3);
    thread wait_dialog_buffer(var_44e63719);
}

// Namespace battlechatter/battlechatter
// Params 0, eflags: 0x0
// Checksum 0xf356621f, Offset: 0x11b8
// Size: 0x1b6
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
// Params 5, eflags: 0x1 linked
// Checksum 0xd531e347, Offset: 0x1378
// Size: 0x124
function function_e6457410(var_5c238c21, attacker, victim, weapon, *inflictor) {
    if (!isdefined(victim) || !isplayer(victim) || victim hasperk(#"specialty_quieter")) {
        return false;
    }
    if (!isdefined(inflictor) || !isplayer(weapon)) {
        return false;
    }
    if (!isdefined(attacker)) {
        return false;
    }
    if (!(isdefined(attacker.var_4a648cbd) ? attacker.var_4a648cbd : 0)) {
        return false;
    }
    var_49376124 = isdefined(attacker.var_14e8550b) ? attacker.var_14e8550b : 0;
    if (var_49376124 == 0) {
        return false;
    }
    return victim.var_3528f7e9 == var_49376124;
}

// Namespace battlechatter/battlechatter
// Params 4, eflags: 0x1 linked
// Checksum 0xc03e573d, Offset: 0x14a8
// Size: 0x100
function function_7c107ed4(attacker, *weapon, victim, *inflictor) {
    if (!dialog_chance("specialKillChance") || !isdefined(inflictor)) {
        return undefined;
    }
    if (!isdefined(inflictor.currentweapon)) {
        return undefined;
    }
    var_9074cacb = function_58c93260(victim);
    if (!isdefined(var_9074cacb) || !isdefined(var_9074cacb.voiceprefix)) {
        return;
    }
    var_5c238c21 = function_cdd81094(inflictor.currentweapon);
    if (!isdefined(var_5c238c21) || !isdefined(var_5c238c21.var_7f45d0d9)) {
        return;
    }
    return var_9074cacb.voiceprefix + var_5c238c21.var_7f45d0d9;
}

// Namespace battlechatter/battlechatter
// Params 2, eflags: 0x0
// Checksum 0x5e27dc56, Offset: 0x15b0
// Size: 0x12c
function function_551980b7(speakingplayer, var_76787d10) {
    if (!level.allowspecialistdialog || !isdefined(var_76787d10)) {
        return;
    }
    if (!isdefined(speakingplayer) || !isplayer(speakingplayer)) {
        return;
    }
    if (!isdefined(var_76787d10) || !isplayer(var_76787d10)) {
        return;
    }
    var_daeb4f94 = function_58c93260(speakingplayer);
    var_2708cdb2 = function_58c93260(var_76787d10);
    if (!isdefined(var_daeb4f94) || !isdefined(var_2708cdb2)) {
        return;
    }
    if (!isdefined(var_daeb4f94.voiceprefix) || !isdefined(var_2708cdb2.var_ff5e0d8e)) {
        return;
    }
    thread function_9d4a3d68(6, speakingplayer, var_76787d10, level.weaponnone, 0, 4);
}

// Namespace battlechatter/battlechatter
// Params 5, eflags: 0x1 linked
// Checksum 0x34be716b, Offset: 0x16e8
// Size: 0x5ba
function function_bd715920(var_28b40381, attacker, eventorigin, eventobject, timedelay) {
    if (!level.allowspecialistdialog || !isdefined(self) || !isplayer(self)) {
        return;
    }
    if ((isdefined(self.var_87b1ba00) ? self.var_87b1ba00 : 0) || (isdefined(eventobject.var_87b1ba00) ? eventobject.var_87b1ba00 : 0) || !isdefined(var_28b40381)) {
        return;
    }
    var_8e39def3 = function_cdd81094(var_28b40381);
    if (!isdefined(var_8e39def3)) {
        return;
    }
    var_4a247dec = isdefined(var_8e39def3.var_2bb73e97) ? var_8e39def3.var_2bb73e97 : 0;
    var_2f741f8e = isdefined(var_8e39def3.var_9715d1af) ? var_8e39def3.var_9715d1af : 0;
    var_4e424b8b = isdefined(var_8e39def3.var_c6face5d) ? var_8e39def3.var_c6face5d : 0;
    var_494ab587 = isdefined(var_8e39def3.var_97a93569) ? var_8e39def3.var_97a93569 : 0;
    if (isdefined(var_4a247dec) ? var_4a247dec : 0) {
        if (isdefined(attacker) && isplayer(attacker) && !attacker hasperk(#"specialty_quieter")) {
            if (isdefined(var_2f741f8e) ? var_2f741f8e : 0) {
                eventobject.var_87b1ba00 = 1;
            } else {
                self.var_87b1ba00 = 1;
            }
            attacker function_95e44f78(var_28b40381, timedelay);
            return;
        }
        return;
    }
    if (isdefined(eventorigin)) {
        players = self getenemies();
        allyradius = mpdialog_value("enemyContactAllyRadius", 0);
        enemydistance = mpdialog_value("enemyContactDistance", 0);
        foreach (player in players) {
            if (!isplayer(player) || player hasperk(#"specialty_quieter")) {
                continue;
            }
            if (isdefined(attacker) && isplayer(attacker) && player == attacker) {
                continue;
            }
            if (isdefined(var_4e424b8b) ? var_4e424b8b : 0) {
                if (distancesquared(eventorigin, player.origin) < function_a3f6cdac(allyradius)) {
                    if (isdefined(var_494ab587) ? var_494ab587 : 0) {
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
            if (distancesquared(eventorigin, player.origin) > function_a3f6cdac(enemydistance)) {
                continue;
            }
            eyepoint = player geteye();
            relativepos = vectornormalize(eventorigin - eyepoint);
            dir = anglestoforward(player getplayerangles());
            dotproduct = vectordot(relativepos, dir);
            if (dotproduct > 0) {
                if (sighttracepassed(eventorigin, eyepoint, 1, player, eventobject)) {
                    if (isdefined(var_2f741f8e) ? var_2f741f8e : 0) {
                        eventobject.var_87b1ba00 = 1;
                    } else {
                        self.var_87b1ba00 = 1;
                    }
                    player function_95e44f78(var_28b40381, timedelay);
                    return;
                }
            }
        }
    }
}

// Namespace battlechatter/battlechatter
// Params 3, eflags: 0x1 linked
// Checksum 0x9d040cc4, Offset: 0x1cb0
// Size: 0x402
function function_fc82b10(weapon, eventorigin, eventobject) {
    if (!isdefined(weapon)) {
        return;
    }
    var_8e39def3 = function_cdd81094(weapon);
    if (!isdefined(var_8e39def3.var_ff5e0d8e)) {
        return;
    }
    if (isdefined(eventobject.var_87b1ba00) ? eventobject.var_87b1ba00 : 0) {
        return;
    }
    var_4e424b8b = isdefined(var_8e39def3.var_c6face5d) ? var_8e39def3.var_c6face5d : 0;
    if (isdefined(eventorigin)) {
        players = self getenemies();
        if (isdefined(players) && players.size > 0) {
            playerbundle = function_58c93260(players[0], undefined);
            if (!isdefined(playerbundle.voiceprefix)) {
                return;
            }
            dialogkey = playerbundle.voiceprefix + var_8e39def3.var_ff5e0d8e;
            allyradius = mpdialog_value("enemyContactAllyRadius", 0);
            enemydistance = mpdialog_value("enemyContactDistance", 0);
            foreach (player in players) {
                if (!isplayer(player) || player hasperk(#"specialty_quieter")) {
                    continue;
                }
                distancetoplayer = distancesquared(eventorigin, player.origin);
                if (var_4e424b8b) {
                    if (distancetoplayer < function_a3f6cdac(allyradius)) {
                        relativepos = vectornormalize(player.origin - eventorigin);
                        dir = anglestoforward(self getplayerangles());
                        dotproduct = vectordot(relativepos, dir);
                        if (dotproduct > 0) {
                            continue;
                        }
                    }
                }
                if (distancetoplayer > function_a3f6cdac(enemydistance)) {
                    continue;
                }
                eyepoint = player geteye();
                relativepos = vectornormalize(eventorigin - eyepoint);
                dir = anglestoforward(player getplayerangles());
                dotproduct = vectordot(relativepos, dir);
                if (dotproduct > 0) {
                    if (sighttracepassed(eventorigin, eyepoint, 1, player, eventobject)) {
                        eventobject.var_87b1ba00 = 1;
                        player thread function_a48c33ff(dialogkey, 2);
                        return;
                    }
                }
            }
        }
    }
}

// Namespace battlechatter/battlechatter
// Params 2, eflags: 0x1 linked
// Checksum 0x68ebaa80, Offset: 0x20c0
// Size: 0xe4
function function_95e44f78(weapon, *timedelay) {
    playerbundle = function_58c93260(self, undefined);
    if (!isdefined(playerbundle) || !isdefined(playerbundle.voiceprefix)) {
        return;
    }
    var_5c238c21 = function_cdd81094(timedelay);
    if (!isdefined(var_5c238c21) || !isdefined(var_5c238c21.var_ff5e0d8e)) {
        return;
    }
    dialogkey = playerbundle.voiceprefix + var_5c238c21.var_ff5e0d8e;
    thread function_9d4a3d68(6, self, undefined, level.weaponnone, var_5c238c21.var_c4d151c8, var_5c238c21.var_4eb6c155);
}

// Namespace battlechatter/battlechatter
// Params 1, eflags: 0x1 linked
// Checksum 0xa7093bb3, Offset: 0x21b0
// Size: 0x2e4
function function_b06bbccf(sniper) {
    if (!function_e1983f22()) {
        return false;
    }
    if (!isdefined(sniper) || !isdefined(self) || !level.teambased || !level.allowspecialistdialog) {
        return false;
    }
    if (!dialog_chance("sniperKillChance")) {
        return false;
    }
    closest_ally = self get_closest_player_ally(0);
    allyradius = mpdialog_value("sniperKillAllyRadius", 0);
    if (!isdefined(closest_ally) || distancesquared(self.origin, closest_ally.origin) > allyradius * allyradius) {
        return false;
    }
    voiceprefix = function_e05060f0(closest_ally);
    if (!isdefined(voiceprefix)) {
        return false;
    }
    playerbundle = function_58c93260(closest_ally);
    if (!isdefined(playerbundle) || !isdefined(playerbundle.threatsniper)) {
        return false;
    }
    var_a1886234 = voiceprefix + playerbundle.threatsniper;
    closest_ally thread function_a48c33ff(var_a1886234, 2);
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
    return true;
}

// Namespace battlechatter/battlechatter
// Params 1, eflags: 0x1 linked
// Checksum 0x34de420a, Offset: 0x24a0
// Size: 0xb0
function function_bafe1ee4(weapon) {
    if (!function_e1983f22()) {
        return false;
    }
    voiceprefix = function_e05060f0(self);
    if (!isdefined(voiceprefix)) {
        return false;
    }
    var_8e39def3 = function_cdd81094(weapon);
    if (!isdefined(var_8e39def3)) {
        return false;
    }
    dialogalias = voiceprefix + var_8e39def3.var_2c07bbf1;
    self thread function_a48c33ff(dialogalias, 6);
    return true;
}

// Namespace battlechatter/battlechatter
// Params 4, eflags: 0x1 linked
// Checksum 0xbd7a8dd6, Offset: 0x2558
// Size: 0x14c
function function_d2600afc(attacker, owner, gadgetweapon, attackerweapon) {
    if (!level.allowspecialistdialog || !isdefined(attacker) || !isplayer(attacker) || attacker hasperk(#"specialty_quieter")) {
        return;
    }
    if (!isdefined(gadgetweapon) || isdefined(owner) && owner == attacker) {
        return;
    }
    if (isdefined(level.var_98769415)) {
        if (isdefined(attackerweapon) && isdefined([[ level.var_98769415 ]](attackerweapon))) {
            return;
        }
    }
    var_5c238c21 = function_cdd81094(gadgetweapon);
    if (!isdefined(var_5c238c21) || !isdefined(var_5c238c21.destroyedalias)) {
        return;
    }
    thread function_9d4a3d68(9, attacker, undefined, gadgetweapon, var_5c238c21.var_8f77c9dd, var_5c238c21.var_51812235);
}

// Namespace battlechatter/battlechatter
// Params 5, eflags: 0x0
// Checksum 0x8001a628, Offset: 0x26b0
// Size: 0x5f4
function playkillbattlechatter(attacker, weapon, victim, inflictor, meansofdeath) {
    if (!level.allowspecialistdialog) {
        return;
    }
    if (!isdefined(attacker) || !isplayer(attacker) || !isalive(attacker) || attacker isremotecontrolling() || attacker isinvehicle() || attacker isweaponviewonlylinked() || attacker hasperk(#"specialty_quieter") || !isdefined(victim) || !isplayer(victim)) {
        return;
    }
    if ((isdefined(meansofdeath) && meansofdeath == "MOD_MELEE" && weapon.name != #"sig_blade" || meansofdeath == "MOD_MELEE_WEAPON_BUTT") && weapon != getweapon("dog_ai_defaultmelee")) {
        return;
    }
    if (isdefined(inflictor) && inflictor.classname != "worldspawn" && !isplayer(inflictor) && inflictor.birthtime < attacker.spawntime) {
        return;
    }
    if (isdefined(inflictor) && is_true(inflictor.var_259f6c17)) {
        var_857133db = 1;
    }
    var_5c238c21 = function_cdd81094(weapon);
    var_25db02aa = victim function_e6457410(var_5c238c21, attacker, victim, weapon, inflictor);
    if (var_25db02aa) {
        var_71449560 = isdefined(var_5c238c21.var_9ccf7d8b) ? var_5c238c21.var_9ccf7d8b : 4;
        if (isdefined(var_5c238c21.var_48b8bd2c)) {
            var_71449560 += isdefined(var_5c238c21.var_c4d151c8) ? var_5c238c21.var_c4d151c8 : 0;
            var_71449560 += isdefined(var_5c238c21.var_4eb6c155) ? var_5c238c21.var_4eb6c155 : 4;
        }
        thread function_9d4a3d68(0, attacker, undefined, weapon, var_5c238c21.var_57c1e152, var_71449560);
        return;
    }
    if (var_25db02aa || weapon.skipbattlechatterkill) {
        return;
    }
    killdialog = function_7c107ed4(attacker, weapon, victim, inflictor);
    if (!isdefined(killdialog) && dialog_chance("enemyKillChance")) {
        var_9074cacb = function_58c93260(attacker);
        var_68be4b0a = function_58c93260(victim);
        if (!isdefined(var_9074cacb)) {
            return;
        }
        if (isdefined(victim.spottedtime) && victim.spottedtime + mpdialog_value("enemySniperKillTime", 0) >= gettime() && array::contains(victim.spottedby, attacker) && dialog_chance("enemySniperKillChance")) {
            suffix = var_9074cacb.("killSniper");
        } else if (isdefined(var_68be4b0a) && dialog_chance("enemyHeroKillChance")) {
            key = "kill" + randomint(3);
            suffix = var_68be4b0a.(key);
        }
        if (!isdefined(suffix) && dialog_chance("enemyKillChance")) {
            if (randomfloatrange(0, 1) < 0.8) {
                suffix = var_9074cacb.killgeneric;
            } else if (victim util::is_female()) {
                suffix = var_9074cacb.var_3823c559;
            } else {
                suffix = var_9074cacb.var_9903c3b;
            }
        }
        if (isdefined(suffix) && isdefined(var_9074cacb.voiceprefix)) {
            killdialog = var_9074cacb.voiceprefix + suffix;
        }
    }
    victim.spottedtime = undefined;
    victim.spottedby = undefined;
    if (!isdefined(killdialog) || (isdefined(var_857133db) ? var_857133db : 0)) {
        return;
    }
    attacker thread function_5896274(mpdialog_value("enemyKillDelay", 0), killdialog, 2, undefined, victim, "cancel_kill_dialog");
}

// Namespace battlechatter/battlechatter
// Params 0, eflags: 0x1 linked
// Checksum 0x9e3aaa2e, Offset: 0x2cb0
// Size: 0x394
function function_b5242998() {
    self endon(#"death");
    level endon(#"game_ended");
    if (!level.teambased || !level.allowspecialistdialog) {
        return;
    }
    allies = [];
    allyradiussq = mpdialog_value("playerVoiceRadius", 0);
    allyradiussq *= allyradiussq;
    foreach (player in level.players) {
        if (!isdefined(player) || !isalive(player) || player.sessionstate != "playing" || player == self || player hasperk(#"specialty_quieter") || util::function_fbce7263(player.team, self.team)) {
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
        player play_dialog("heroWeaponSuccessReaction", 2);
        break;
    }
}

// Namespace battlechatter/battlechatter
// Params 0, eflags: 0x1 linked
// Checksum 0x96670636, Offset: 0x3050
// Size: 0x33c
function function_f5b398b6() {
    if (!level.allowspecialistdialog || !isdefined(self) || !isplayer(self) || self hasperk(#"specialty_quieter")) {
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
        if (player == self) {
            continue;
        }
        playerdialog = player getmpdialogname();
        if (!isdefined(playerdialog) || playerdialog == selfdialog || !player can_play_dialog(1) || distancesquared(self.origin, player.origin) >= voiceradiussq) {
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
        if (ally hasdobj() && ally haspart("J_Head")) {
            ally playsoundontag(dialogalias, "J_Head", undefined, self);
        } else {
            ally playsoundontag(dialogalias, "tag_origin", undefined, self);
        }
        ally thread wait_dialog_buffer(mpdialog_value("playerDialogBuffer", 0));
    }
}

// Namespace battlechatter/battlechatter
// Params 1, eflags: 0x1 linked
// Checksum 0x3e21ae60, Offset: 0x3398
// Size: 0x144
function function_576ff6fe(killstreaktype) {
    if (!level.allowspecialistdialog || !isdefined(self) || !isplayer(self) || self hasperk(#"specialty_quieter")) {
        return;
    }
    if (!isdefined(killstreaktype) || !isdefined(level.killstreaks[killstreaktype])) {
        return;
    }
    if (!isdefined(level.killstreaks[killstreaktype].script_bundle.var_c236921c)) {
        return;
    }
    playerbundle = function_58c93260(self);
    if (!isdefined(playerbundle) || !isdefined(playerbundle.voiceprefix)) {
        return;
    }
    dialogalias = playerbundle.voiceprefix + level.killstreaks[killstreaktype].script_bundle.var_c236921c;
    self thread function_a48c33ff(dialogalias, 2);
}

// Namespace battlechatter/battlechatter
// Params 1, eflags: 0x1 linked
// Checksum 0x5b1c72da, Offset: 0x34e8
// Size: 0x144
function playkillstreakthreat(killstreaktype) {
    if (!level.allowspecialistdialog || !isdefined(self) || !isplayer(self) || self hasperk(#"specialty_quieter")) {
        return;
    }
    if (!isdefined(killstreaktype) || !isdefined(level.killstreaks[killstreaktype])) {
        return;
    }
    if (!isdefined(level.killstreaks[killstreaktype].script_bundle.var_aef5ea0a)) {
        return;
    }
    playerbundle = function_58c93260(self);
    if (!isdefined(playerbundle) || !isdefined(playerbundle.voiceprefix)) {
        return;
    }
    dialogalias = playerbundle.voiceprefix + level.killstreaks[killstreaktype].script_bundle.var_aef5ea0a;
    self thread function_a48c33ff(dialogalias, 2);
}

// Namespace battlechatter/battlechatter
// Params 2, eflags: 0x1 linked
// Checksum 0xc6816e2c, Offset: 0x3638
// Size: 0x134
function function_eebf94f6(killstreaktype, *weapon) {
    if (!level.allowspecialistdialog || !isdefined(self) || !isplayer(self) || self hasperk(#"specialty_quieter")) {
        return;
    }
    if (isdefined(level.var_98769415)) {
        if (!isdefined(weapon) || !isdefined(level.killstreaks[weapon])) {
            return;
        }
    }
    if (!isdefined(level.killstreaks[weapon].script_bundle.var_1b390aa1)) {
        return;
    }
    playerbundle = function_58c93260(self);
    if (!isdefined(playerbundle) || !isdefined(playerbundle.voiceprefix)) {
        return;
    }
    thread function_9d4a3d68(11, self, undefined, killstreaks::get_killstreak_weapon(weapon));
}

// Namespace battlechatter/battlechatter
// Params 2, eflags: 0x1 linked
// Checksum 0xdc821b7, Offset: 0x3778
// Size: 0x4c4
function playgadgetready(weapon, userflip = 0) {
    if (!level.allowspecialistdialog || !isdefined(self) || !isplayer(self) || self hasperk(#"specialty_quieter")) {
        return;
    }
    if (!isdefined(weapon) || gettime() - (isdefined(level.starttime) ? level.starttime : 0) < int(mpdialog_value("readyAudioDelay", 0) * 1000)) {
        return;
    }
    var_5c238c21 = function_cdd81094(weapon);
    if (!isdefined(var_5c238c21) || !isdefined(var_5c238c21.var_788c5852)) {
        return;
    }
    playerbundle = function_58c93260(self);
    if (!isdefined(playerbundle) || !isdefined(playerbundle.voiceprefix)) {
        return;
    }
    dialogkey = playerbundle.voiceprefix + var_5c238c21.var_788c5852;
    if (!is_true(self.isthief) && !is_true(self.isroulette)) {
        self thread function_a48c33ff(dialogkey, 2);
        return;
    }
    waittime = 0;
    dialogflags = 32;
    if (userflip) {
        minwaittime = 0;
        if (self.playinggadgetreadydialog) {
            self stop_dialog();
            minwaittime = float(function_60d95f53()) / 1000;
        }
        if (is_true(self.isthief)) {
            delaykey = "thiefFlipDelay";
        } else {
            delaykey = "rouletteFlipDelay";
        }
        waittime = mpdialog_value(delaykey, minwaittime);
        dialogflags += 64;
    } else {
        if (is_true(self.isthief)) {
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
    self thread function_5896274(waittime, dialogkey, dialogflags, undefined, undefined, undefined);
}

// Namespace battlechatter/battlechatter
// Params 2, eflags: 0x0
// Checksum 0x777b41e7, Offset: 0x3c48
// Size: 0x16c
function function_1d4b0ec0(dogstate, *dog) {
    if (!level.allowspecialistdialog) {
        return;
    }
    if (!isdefined(dog)) {
        return;
    }
    if (!isdefined(self.script_owner) || !isplayer(self.script_owner) || self.script_owner hasperk(#"specialty_quieter")) {
        return;
    }
    bundlename = self.script_owner getmpdialogname();
    if (!isdefined(bundlename)) {
        return;
    }
    playerbundle = getscriptbundle(bundlename);
    if (!isdefined(playerbundle)) {
        return;
    }
    dialogkey = undefined;
    switch (dog) {
    case 0:
        dialogkey = playerbundle.var_499ffcee;
        break;
    case 1:
        dialogkey = playerbundle.var_38ab9818;
        break;
    default:
        return;
    }
    self.script_owner thread function_a48c33ff(dialogkey);
}

// Namespace battlechatter/battlechatter
// Params 2, eflags: 0x0
// Checksum 0xe35599f5, Offset: 0x3dc0
// Size: 0x264
function function_e3ebbf87(var_aa988d26, var_c1132df6) {
    if (!isdefined(var_aa988d26) || !isdefined(self) || !isplayer(self)) {
        return;
    }
    self notify("779ece0b483dbbf6");
    self endon("779ece0b483dbbf6");
    self endon(#"death", #"disconnect");
    if (!sessionmodeiswarzonegame()) {
        level endon(#"game_ended");
    }
    waittime = mpdialog_value("calloutTriggerDelay", 0);
    wait waittime;
    if (!isdefined(self) || !isplayer(self) || self isplayerunderwater()) {
        return;
    }
    if (is_true(self.playingdialog)) {
        return;
    }
    dialogbundle = function_58c93260(self);
    if (!isdefined(dialogbundle) || !isdefined(dialogbundle.voiceprefix)) {
        return;
    }
    if (!is_true(var_c1132df6) && !isdefined(var_aa988d26.var_4bc5b617) || is_true(var_c1132df6) && !isdefined(var_aa988d26.var_5cb8190f)) {
        return;
    }
    var_4bc5b617 = is_true(var_c1132df6) ? var_aa988d26.var_5cb8190f : var_aa988d26.var_4bc5b617;
    dialogalias = dialogbundle.voiceprefix + var_4bc5b617;
    dialogbuffer = mpdialog_value("calloutDialogBuffer", 0);
    self thread function_a48c33ff(dialogalias, 146, dialogbuffer);
}

// Namespace battlechatter/battlechatter
// Params 2, eflags: 0x0
// Checksum 0x76761fcc, Offset: 0x4030
// Size: 0x16c
function function_fff18afc(dialogkey, var_4d5833c) {
    if (!level.allowspecialistdialog || !isdefined(self) || !isplayer(self)) {
        return;
    }
    if (!isdefined(dialogkey) || self isplayerunderwater()) {
        return;
    }
    dialogbuffer = mpdialog_value("killstreakDialogBuffer", 0);
    voiceprefix = function_e05060f0(self);
    if (isdefined(voiceprefix)) {
        dialogalias = voiceprefix + dialogkey;
    } else {
        dialogalias = dialogkey;
    }
    if (!self hasperk(#"specialty_quieter")) {
        self function_a48c33ff(dialogalias, 6, dialogbuffer, undefined);
    }
    var_cf210c5b = self get_player_dialog_alias(var_4d5833c, undefined);
    if (isdefined(var_cf210c5b)) {
        self function_253c2ba4(var_cf210c5b, dialogbuffer);
    }
}

// Namespace battlechatter/battlechatter
// Params 1, eflags: 0x1 linked
// Checksum 0x86bfbf8, Offset: 0x41a8
// Size: 0xfc
function function_cad61ec(weapon) {
    if (!level.allowspecialistdialog || !isdefined(self) || !isplayer(self)) {
        return;
    }
    if (!isdefined(weapon) || !isalive(self) || level.gameended || self isplayerunderwater()) {
        return;
    }
    var_5c238c21 = function_cdd81094(weapon);
    if (!isdefined(var_5c238c21) || !isdefined(var_5c238c21.deployalias)) {
        return;
    }
    thread function_9d4a3d68(8, self, undefined, weapon, var_5c238c21.var_25b5335a, var_5c238c21.var_373ebd09);
}

// Namespace battlechatter/battlechatter
// Params 1, eflags: 0x1 linked
// Checksum 0xf375a2a1, Offset: 0x42b0
// Size: 0x20c
function function_916b4c72(weapon) {
    if (!level.allowspecialistdialog || !isdefined(self) || !isplayer(self) || self hasperk(#"specialty_quieter")) {
        return;
    }
    if (!isdefined(weapon) || !isalive(self) || level.gameended || (isdefined(self.var_8720dd77) ? self.var_8720dd77 : 0) > gettime() || self isplayerunderwater()) {
        return;
    }
    playerbundle = function_58c93260(self, undefined);
    if (!isdefined(playerbundle) || !isdefined(playerbundle.voiceprefix)) {
        return;
    }
    var_5c238c21 = function_cdd81094(weapon);
    if (!isdefined(var_5c238c21) || !isdefined(var_5c238c21.var_931a4bf8)) {
        return;
    }
    dialogkey = playerbundle.voiceprefix + var_5c238c21.var_931a4bf8;
    self.var_8720dd77 = gettime() + int(mpdialog_value("useFailDelay", 5) * 1000);
    self playsoundtoplayer(dialogkey, self);
    self thread wait_dialog_buffer(mpdialog_value("playerDialogBuffer", 0));
}

// Namespace battlechatter/battlechatter
// Params 1, eflags: 0x1 linked
// Checksum 0x948de022, Offset: 0x44c8
// Size: 0x11c
function function_4b6a650d(weapon) {
    if (!level.allowspecialistdialog || !isdefined(self) || !isplayer(self)) {
        return;
    }
    if (!isdefined(weapon) || self isplayerunderwater()) {
        return;
    }
    playerbundle = function_58c93260(self, undefined);
    if (!isdefined(playerbundle) || !isdefined(playerbundle.voiceprefix)) {
        return;
    }
    var_5c238c21 = function_cdd81094(weapon);
    if (!isdefined(var_5c238c21) || !isdefined(var_5c238c21.equipalias)) {
        return;
    }
    thread function_9d4a3d68(10, self, undefined, weapon, var_5c238c21.var_79b79488, var_5c238c21.var_eeb8e319);
}

// Namespace battlechatter/battlechatter
// Params 1, eflags: 0x1 linked
// Checksum 0xca1e35ab, Offset: 0x45f0
// Size: 0x11c
function function_26dd1669(weapon) {
    if (!level.allowspecialistdialog || !isdefined(self) || !isplayer(self)) {
        return;
    }
    if (!isdefined(weapon) || self isplayerunderwater()) {
        return;
    }
    playerbundle = function_58c93260(self, undefined);
    if (!isdefined(playerbundle) || !isdefined(playerbundle.voiceprefix)) {
        return;
    }
    var_5c238c21 = function_cdd81094(weapon);
    if (!isdefined(var_5c238c21) || !isdefined(var_5c238c21.usealias)) {
        return;
    }
    thread function_9d4a3d68(7, self, undefined, weapon, var_5c238c21.var_14da1618, var_5c238c21.var_b76b8205);
}

// Namespace battlechatter/battlechatter
// Params 2, eflags: 0x5 linked
// Checksum 0x1df780dd, Offset: 0x4718
// Size: 0x2a0
function private function_253c2ba4(var_cf210c5b, dialogbuffer) {
    if (!level.allowspecialistdialog || !isdefined(self) || !isplayer(self) || !isdefined(var_cf210c5b)) {
        return;
    }
    if (!isdefined(dialogbuffer)) {
        dialogbuffer = mpdialog_value("playerDialogBuffer", 0);
    }
    teamarray = getplayers(self.team);
    if (self hasperk(#"specialty_quieter")) {
        arrayremovevalue(teamarray, self, 0);
    } else {
        localplayers = getplayers(self.team, self.origin, 1200);
        foreach (localplayer in localplayers) {
            arrayremovevalue(teamarray, localplayer, 0);
        }
    }
    foreach (player in teamarray) {
        if (!isdefined(player) || !isalive(player) || is_true(player.playingdialog) && !is_true(player.var_6765d33e)) {
            continue;
        }
        player.var_6765d33e = 0;
        player playsoundtoplayer(var_cf210c5b, player);
        player thread wait_dialog_buffer(dialogbuffer);
    }
}

// Namespace battlechatter/battlechatter
// Params 4, eflags: 0x1 linked
// Checksum 0xe82d1157, Offset: 0x49c0
// Size: 0x19c
function play_gadget_success(weapon, *waitkey, *victim, var_5d738b56) {
    if (!level.allowspecialistdialog || !isdefined(self) || !isplayer(self) || self hasperk(#"specialty_quieter")) {
        return;
    }
    if (!isdefined(victim) || !level.teambased) {
        return;
    }
    var_5c238c21 = function_cdd81094(victim);
    if (!isdefined(var_5c238c21) || !isdefined(var_5c238c21.var_c8d8482c)) {
        return;
    }
    self.playedgadgetsuccess = 1;
    var_71449560 = isdefined(var_5c238c21.var_9ccf7d8b) ? var_5c238c21.var_9ccf7d8b : 4;
    if (isdefined(var_5c238c21.var_48b8bd2c)) {
        var_71449560 += isdefined(var_5c238c21.var_c4d151c8) ? var_5c238c21.var_c4d151c8 : 0;
        var_71449560 += isdefined(var_5c238c21.var_4eb6c155) ? var_5c238c21.var_4eb6c155 : 4;
    }
    thread function_9d4a3d68(0, self, var_5d738b56, victim, var_5c238c21.var_57c1e152, var_71449560);
}

// Namespace battlechatter/battlechatter
// Params 2, eflags: 0x0
// Checksum 0xd4f4cc77, Offset: 0x4b68
// Size: 0x108
function function_98898d14(player, objective) {
    if (isdefined(objective.var_76975be4[player.team]) && objective.var_b4ea8d3f[player.team] + int(20 * 1000) < gettime()) {
        return;
    }
    if (randomfloatrange(0, 1) < 0.25) {
        var_57fce7c = function_8c4b101f(player.team, player.origin, 360);
        if (var_57fce7c.size >= 2) {
            player play_dialog("captureStartObjective", 1);
            objective.var_b4ea8d3f[player.team] = gettime();
        }
    }
}

// Namespace battlechatter/battlechatter
// Params 2, eflags: 0x0
// Checksum 0xb6a47b1, Offset: 0x4c78
// Size: 0x108
function function_924699f4(player, objective) {
    if (isdefined(objective.var_2a30805a[player.team]) && objective.var_fe3d79b9[player.team] + int(20 * 1000) < gettime()) {
        return;
    }
    if (randomfloatrange(0, 1) < 0.25) {
        var_57fce7c = function_8c4b101f(player.team, player.origin, 360);
        if (var_57fce7c.size >= 2) {
            player play_dialog("capturedObjective", 1);
            objective.var_fe3d79b9[player.team] = gettime();
        }
    }
}

// Namespace battlechatter/battlechatter
// Params 1, eflags: 0x0
// Checksum 0x58a43658, Offset: 0x4d88
// Size: 0x1c0
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
        playerbundle = getscriptbundle(bundlename);
        if (!isdefined(playerbundle.voiceprefix)) {
            return;
        }
        if (isdefined(winner) && level.teambased && isdefined(level.teams[winner]) && player.pers[#"team"] == winner || !level.teambased && player == winner) {
            dialogkey = playerbundle.boostwin;
        } else {
            dialogkey = playerbundle.boostloss;
        }
        if (isdefined(playerbundle.voiceprefix) && isdefined(dialogkey)) {
            player playlocalsound(playerbundle.voiceprefix + dialogkey);
        }
    }
}

// Namespace battlechatter/battlechatter
// Params 0, eflags: 0x0
// Checksum 0xab752596, Offset: 0x4f50
// Size: 0xb4
function function_72b65730() {
    bundlename = self getmpdialogname();
    if (!isdefined(bundlename)) {
        return;
    }
    playerbundle = getscriptbundle(bundlename);
    if (!isdefined(playerbundle)) {
        return;
    }
    dialogkey = playerbundle.var_96b4150c;
    waittime = mpdialog_value("playerExertBuffer", 0);
    thread function_5896274(waittime, dialogkey, 2);
}

// Namespace battlechatter/battlechatter
// Params 3, eflags: 0x1 linked
// Checksum 0x5b390b80, Offset: 0x5010
// Size: 0xc4
function heavyweaponkilllogic(attacker, weapon, victim) {
    if (!isdefined(attacker.heavyweaponkillcount)) {
        attacker.heavyweaponkillcount = 0;
    }
    attacker.heavyweaponkillcount++;
    if (!is_true(attacker.playedgadgetsuccess) && attacker.heavyweaponkillcount >= mpdialog_value("heroWeaponKillCount", 0)) {
        attacker thread play_gadget_success(weapon, "enemyKillDelay", victim);
        attacker thread function_b5242998();
    }
}
