#using script_1cc417743d7c262d;
#using script_6167e26342be354b;
#using script_725554a59d6a75b9;
#using script_7f6cd71c43c45c57;
#using scripts\abilities\ability_player;
#using scripts\core_common\activecamo_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\contracts_shared;
#using scripts\core_common\demo_shared;
#using scripts\core_common\gamestate;
#using scripts\core_common\globallogic\globallogic_player;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\globallogic\globallogic_vehicle;
#using scripts\core_common\hostmigration_shared;
#using scripts\core_common\killcam_shared;
#using scripts\core_common\match_record;
#using scripts\core_common\math_shared;
#using scripts\core_common\medals_shared;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\player\player_role;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\potm_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\tweakables_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\weapons_shared;
#using scripts\killstreaks\killstreak_bundles;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\mp_common\bb;
#using scripts\mp_common\challenges;
#using scripts\mp_common\gametypes\deathicons;
#using scripts\mp_common\gametypes\display_transition;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_spawn;
#using scripts\mp_common\gametypes\globallogic_utils;
#using scripts\mp_common\player\player_damage;
#using scripts\mp_common\player\player_record;
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\teams\teams;
#using scripts\mp_common\userspawnselection;
#using scripts\mp_common\util;
#using scripts\weapons\weapon_utils;
#using scripts\weapons\weapons;

#namespace player;

// Namespace player/player_killed
// Params 3, eflags: 0x1 linked
// Checksum 0xe52bc0c0, Offset: 0x6a8
// Size: 0x2a4
function function_df36a02d(attacker, weapon, mod) {
    if (isdefined(weapon)) {
        var_2f9ea2b9 = weapons::getbaseweapon(weapon);
        baseweaponindex = getbaseweaponitemindex(var_2f9ea2b9);
        self clientfield::set_player_uimodel("huditems.killedByItemIndex", baseweaponindex);
    } else {
        self clientfield::set_player_uimodel("huditems.killedByItemIndex", 0);
    }
    if (isdefined(attacker)) {
        self clientfield::set_player_uimodel("huditems.killedByEntNum", attacker getentitynumber());
    } else {
        self clientfield::set_player_uimodel("huditems.killedByEntNum", 15);
    }
    if (isdefined(mod)) {
        var_19b57d54 = function_4a856ead(mod);
        if (mod != "MOD_META") {
            if (attacker === self) {
                var_19b57d54 = function_4a856ead("MOD_SUICIDE");
            } else if (weapon === level.weaponnone) {
                var_19b57d54 = function_4a856ead("MOD_UNKNOWN");
                self clientfield::set_player_uimodel("huditems.killedByEntNum", self getentitynumber());
            }
        }
        self clientfield::set_player_uimodel("huditems.killedByMOD", var_19b57d54);
    } else {
        self clientfield::set_player_uimodel("huditems.killedByEntNum", 15);
    }
    attachments = function_30d57f0e(weapon);
    self clientfield::set_player_uimodel("huditems.killedByAttachmentCount", attachments.size);
    for (var_20d65af5 = 0; var_20d65af5 < attachments.size && var_20d65af5 < 5; var_20d65af5++) {
        self clientfield::set_player_uimodel("huditems.killedByAttachment" + var_20d65af5, attachments[var_20d65af5]);
    }
}

// Namespace player/player_killed
// Params 1, eflags: 0x1 linked
// Checksum 0x1183f0a6, Offset: 0x958
// Size: 0x104
function function_7622d447(attacker) {
    if (isdefined(self.attackers)) {
        for (j = 0; j < self.attackers.size; j++) {
            player = self.attackers[j];
            if (self function_ca27b62b(attacker, player)) {
                damage_done = self.attackerdamage[player.clientid].damage;
                einflictor = self.attackerdamage[player.clientid].einflictor;
                weapon = self.attackerdamage[player.clientid].weapon;
                player function_b8871aa2(einflictor, self, damage_done, weapon);
            }
        }
    }
}

// Namespace player/player_killed
// Params 2, eflags: 0x1 linked
// Checksum 0x9ecb71ed, Offset: 0xa68
// Size: 0x12c
function function_ca27b62b(attacker, player) {
    if (!isdefined(player)) {
        return false;
    }
    if (isdefined(attacker) && player util::isenemyteam(attacker.team)) {
        return false;
    }
    if (self.attackerdamage[player.clientid].damage == 0) {
        return false;
    }
    if (is_true(level.ekiaresetondeath) && isdefined(player.deathtime) && player.deathtime > self.attackerdamage[player.clientid].lastdamagetime) {
        return false;
    }
    if (isdefined(level.var_c77de7d6) && gettime() > int(level.var_c77de7d6 * 1000) + self.attackerdamage[player.clientid].lastdamagetime) {
        return false;
    }
    return true;
}

// Namespace player/player_killed
// Params 3, eflags: 0x1 linked
// Checksum 0x890d030d, Offset: 0xba0
// Size: 0x23c
function function_284c61bd(attacker, meansofdeath, bledout = 0) {
    if (isdefined(self.attackers) && isdefined(attacker)) {
        for (j = 0; j < self.attackers.size; j++) {
            player = self.attackers[j];
            if (!isdefined(player)) {
                continue;
            }
            if (player util::isenemyteam(attacker.team)) {
                continue;
            }
            if (self.attackerdamage[player.clientid].damage == 0) {
                continue;
            }
            if (is_true(level.ekiaresetondeath) && isdefined(player.deathtime) && player.deathtime > self.attackerdamage[player.clientid].lastdamagetime) {
                continue;
            }
            if (isdefined(level.var_c77de7d6) && level.var_c77de7d6 && gettime() > int(level.var_c77de7d6 * 1000) + self.attackerdamage[player.clientid].lastdamagetime && !bledout) {
                continue;
            }
            einflictor = self.attackerdamage[player.clientid].einflictor;
            weapon = self.attackerdamage[player.clientid].weapon;
            if (player != attacker) {
                meansofdeath = self.attackerdamage[player.clientid].meansofdeath;
            }
            self function_4e3e8bee(einflictor, player, meansofdeath, weapon, attacker);
        }
    }
}

// Namespace player/player_killed
// Params 0, eflags: 0x5 linked
// Checksum 0x6b5baee6, Offset: 0xde8
// Size: 0xe6
function private function_66cec679() {
    team = self.team;
    teammates = getplayers(team);
    foreach (player in teammates) {
        if (player == self) {
            continue;
        }
        if (player.sessionstate == "spectator") {
            player.spectatorclient = self getentitynumber();
        }
    }
}

// Namespace player/player_killed
// Params 0, eflags: 0x5 linked
// Checksum 0xf75fb6e3, Offset: 0xed8
// Size: 0x19e
function private function_448f7ed2() {
    if (is_true(level.var_a4c48e88)) {
        return false;
    }
    if (level.var_f2814a96 !== 0) {
        return false;
    }
    if (is_true(level.wave_spawn)) {
        time = gettime();
        team = self.pers[#"team"];
        if (isdefined(team) && isdefined(level.lastwave) && isdefined(level.lastwave[team]) && isdefined(level.wavedelay) && isdefined(level.wavedelay[team])) {
            wavedelay = int(level.wavedelay[team] * 1000);
            lasttime = time - level.lastwave[team];
            timediff = wavedelay - lasttime;
            var_4e7f2872 = isdefined(level.var_75db41a7) && time >= level.var_75db41a7;
            if (timediff > 5000 && !var_4e7f2872) {
                return true;
            }
        }
    } else {
        return true;
    }
    return false;
}

// Namespace player/player_killed
// Params 10, eflags: 0x1 linked
// Checksum 0x4c64251c, Offset: 0x1080
// Size: 0xc5c
function callback_playerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration, enteredresurrect = 0) {
    profilelog_begintiming(7, "ship");
    self endon(#"spawned");
    self.var_4ef33446 = smeansofdeath == "MOD_META";
    /#
        if (getdvarint(#"hash_2517ca1e8454c3c8", 0) == 1) {
            self.var_4ef33446 = 1;
        }
    #/
    if (gamestate::is_game_over()) {
        post_game_death(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
        return;
    }
    if (self.sessionteam == #"spectator") {
        return;
    }
    util::function_1ea0b2ce();
    level.var_445b1bca = gettime();
    self needsrevive(0);
    if (isdefined(self.burning) && self.burning == 1) {
        self setburn(0);
    }
    self.cur_kill_streak = 0;
    self.suicide = 0;
    self.teamkilled = 0;
    countdeath = !is_true(self.var_cee93f5) && !self.var_4ef33446;
    if (countdeath) {
        if (!isdefined(self.var_a7d7e50a)) {
            self.var_a7d7e50a = 0;
        }
        level.deaths[self.team]++;
        self.var_a7d7e50a++;
        start_generator_captureshouldshowpain();
    }
    attacker callback::callback(#"on_killed_player");
    self thread globallogic_audio::flush_leader_dialog_key_on_player("equipmentDestroyed");
    weapon = update_weapon(einflictor, weapon);
    pixbeginevent(#"hash_47eb123ec5413349");
    self thread audio::function_30d4f8c4(attacker, smeansofdeath, weapon);
    wasinlaststand = 0;
    bledout = 0;
    deathtimeoffset = 0;
    attackerstance = undefined;
    self.laststandthislife = undefined;
    self.vattackerorigin = undefined;
    self.var_a9914487 = undefined;
    self.var_d50e861c = undefined;
    self.var_4db23b = undefined;
    self function_df36a02d(attacker, weapon, smeansofdeath);
    weapon_at_time_of_death = self getcurrentweapon();
    var_8efc9727 = isplayer(attacker) && self util::isenemyplayer(attacker) == 0;
    var_41c4d474 = isplayer(attacker) && self == attacker;
    vattacker = isdefined(attacker) ? attacker : self;
    var_a44c7fd8 = {#victimorigin:self.origin, #var_5fceefd4:self getplayerangles(), #victimweapon:self.currentweapon, #einflictor:einflictor, #attacker:attacker, #attackerorigin:vattacker.origin, #var_83634238:isplayer(vattacker) ? vattacker getplayerangles() : vattacker.angles, #idamage:idamage, #smeansofdeath:smeansofdeath, #weapon:weapon, #vdir:vdir, #shitloc:shitloc, #matchtime:function_f8d53445()};
    if (isdefined(self.uselaststandparams) && enteredresurrect == 0) {
        self.uselaststandparams = undefined;
        assert(isdefined(self.laststandparams));
        if (isdefined(self.laststandparams) && (!level.teambased || !isdefined(attacker) || !isplayer(attacker) || !var_8efc9727 || var_41c4d474)) {
            einflictor = self.laststandparams.einflictor;
            attacker = self.laststandparams.attacker;
            attackerstance = self.laststandparams.attackerstance;
            idamage = self.laststandparams.idamage;
            smeansofdeath = self.laststandparams.smeansofdeath;
            assert(isdefined(smeansofdeath));
            weapon = self.laststandparams.weapon;
            vdir = self.laststandparams.vdir;
            shitloc = self.laststandparams.shitloc;
            self.vattackerorigin = self.laststandparams.vattackerorigin;
            self.killcam_entity_info_cached = self.laststandparams.killcam_entity_info_cached;
            if (!is_true(self.laststandparams.var_59b19c1b)) {
                deathtimeoffset = float(gettime() - self.laststandparams.laststandstarttime) / 1000;
            }
            bledout = self.laststandparams.bledout;
            wasinlaststand = 1;
            var_8efc9727 = isplayer(attacker) && self util::isenemyplayer(attacker) == 0;
            var_41c4d474 = isplayer(attacker) && self == attacker;
        }
    }
    params = {#victim:self, #einflictor:einflictor, #eattacker:attacker, #idamage:idamage, #smeansofdeath:smeansofdeath, #weapon:weapon, #vdir:vdir, #shitloc:shitloc, #psoffsettime:psoffsettime, #deathanimduration:deathanimduration, #laststandparams:self.laststandparams};
    self callback::callback(#"on_player_killed", params);
    self stopsounds();
    var_c391d0a8 = self function_fc51dcf8(attacker, weapon, smeansofdeath, shitloc, var_41c4d474 || var_8efc9727);
    if (isdefined(var_c391d0a8.attacker)) {
        attacker = var_c391d0a8.attacker;
        smeansofdeath = var_c391d0a8.smeansofdeath;
        shitloc = var_c391d0a8.shitloc;
        weapon = var_c391d0a8.weapon;
    }
    self function_5f6cde96(var_41c4d474, var_8efc9727);
    var_c391d0a8.attacker = update_attacker(attacker, weapon);
    attacker = var_c391d0a8.attacker;
    function_813829e3(einflictor);
    self thread function_8826f676();
    self function_a3030357(var_c391d0a8.var_23da26bf, einflictor, var_c391d0a8.var_60851fcf, var_c391d0a8.var_4b5379af, bledout);
    self function_c2c4d6e9(var_c391d0a8, bledout, enteredresurrect, countdeath);
    pixendevent();
    self function_4a762be0(var_c391d0a8, var_a44c7fd8, weapon_at_time_of_death, attackerstance, countdeath, var_41c4d474, var_8efc9727, wasinlaststand, bledout, enteredresurrect);
    self function_c220950f(var_c391d0a8, idamage, weapon_at_time_of_death);
    level thread globallogic::updateteamstatus();
    level thread globallogic::updatealivetimes(self.team);
    self thread function_395ef176();
    self weapons::detach_carry_object_model();
    self function_7804764f(var_a44c7fd8, deathanimduration, psoffsettime, enteredresurrect);
    if (enteredresurrect) {
        thread globallogic_spawn::spawnqueuedclient(self.team, attacker);
    }
    self function_ff3ec0d4(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
    self function_7622d447();
    self.laststandparams = undefined;
    self.var_a1d415ee = undefined;
    if (isdefined(self.attackers)) {
        self.attackers = [];
    }
    if (!isdefined(self.killstreak_delay_killcam)) {
        self thread [[ level.spawnplayerprediction ]]();
    }
    if (self.currentspectatingclient != -1 && (level.spectatetype == 4 || level.spectatetype == 5) && self.pers[#"team"] != #"spectator") {
        function_39a7df61(self);
    }
    profilelog_endtiming(7, "gs=" + game.state);
    self function_42862f77(var_a44c7fd8, var_c391d0a8.attacker, deathtimeoffset, psoffsettime, deathanimduration, var_8efc9727, var_41c4d474, var_c391d0a8.assisted_suicide, enteredresurrect);
    function_93115f65(enteredresurrect);
}

// Namespace player/player_killed
// Params 4, eflags: 0x5 linked
// Checksum 0xf6810ca4, Offset: 0x1ce8
// Size: 0xdc
function private should_do_killcam(attacker, einflictor, var_41c4d474, assistedsuicide) {
    /#
        if (getdvarint(#"scr_forcekillcam", 0) != 0) {
            return true;
        }
    #/
    if (isdefined(self.killstreak_delay_killcam)) {
        return false;
    }
    if (var_41c4d474) {
        return false;
    }
    if (assistedsuicide) {
        return false;
    }
    if (level.killcammode == 2) {
        return false;
    }
    if (self.var_4ef33446) {
        return false;
    }
    if (isplayer(attacker)) {
        return true;
    }
    if (isdefined(einflictor.killcament)) {
        return true;
    }
    return false;
}

// Namespace player/player_killed
// Params 4, eflags: 0x5 linked
// Checksum 0x1ad68d3, Offset: 0x1dd0
// Size: 0x10a
function private function_388d8a53(attacker, einflictor, var_41c4d474, assistedsuicide) {
    var_c547267e = -1;
    if (!var_41c4d474 && !assistedsuicide && isplayer(attacker)) {
        var_c547267e = attacker getentitynumber();
    }
    if (isdefined(einflictor.killcament) && !isplayer(attacker)) {
        var_c547267e = self getentitynumber();
    }
    /#
        if (getdvarint(#"scr_forcekillcam", 0) != 0 && var_c547267e < 0) {
            var_c547267e = self getentitynumber();
        }
    #/
    return var_c547267e;
}

// Namespace player/player_killed
// Params 9, eflags: 0x5 linked
// Checksum 0xbd80487f, Offset: 0x1ee8
// Size: 0xb56
function private function_42862f77(var_a2f12b49, attacker, deathtimeoffset, psoffsettime, deathanimduration, var_8efc9727, var_41c4d474, assistedsuicide, enteredresurrect) {
    if (isdefined(self.killcam_entity_info_cached)) {
        killcam_entity_info = self.killcam_entity_info_cached;
        self.killcam_entity_info_cached = undefined;
    } else {
        killcam_entity_info = killcam::get_killcam_entity_info(var_a2f12b49.attacker, var_a2f12b49.einflictor, var_a2f12b49.weapon);
    }
    perks = [];
    killstreaks = globallogic::getkillstreaks(var_a2f12b49.attacker);
    var_c547267e = function_388d8a53(attacker, var_a2f12b49.einflictor, var_41c4d474, assistedsuicide);
    self thread killcam::function_eb3deeec(var_c547267e, self getentitynumber(), killcam_entity_info, var_a2f12b49.weapon, var_a2f12b49.smeansofdeath, self.deathtime, deathtimeoffset, psoffsettime, perks, killstreaks, var_a2f12b49.attacker);
    wasteamkill = var_8efc9727 && !(var_41c4d474 || assistedsuicide);
    if (wasteamkill == 0 && assistedsuicide == 0 && var_a2f12b49.smeansofdeath != "MOD_SUICIDE" && !(!isdefined(var_a2f12b49.attacker) || var_a2f12b49.attacker.classname == "trigger_hurt" || var_a2f12b49.attacker.classname == "worldspawn" || var_41c4d474 || isdefined(var_a2f12b49.attacker.disablefinalkillcam))) {
        level thread killcam::record_settings(var_c547267e, self getentitynumber(), killcam_entity_info, var_a2f12b49.weapon, var_a2f12b49.smeansofdeath, self.deathtime, deathtimeoffset, psoffsettime, perks, killstreaks, var_a2f12b49.attacker);
        var_c8fa9c41 = isplayer(var_a2f12b49.attacker) ? var_a2f12b49.attacker getxuid() : 0;
        level thread potm::function_5523a49a(#"kill", var_c547267e, var_c8fa9c41, self, killcam_entity_info, var_a2f12b49.weapon, var_a2f12b49.smeansofdeath, self.deathtime, deathtimeoffset, psoffsettime, perks, killstreaks, var_a2f12b49.attacker, var_a2f12b49.einflictor);
    }
    if (enteredresurrect) {
        return;
    }
    livesleft = !(level.numlives && !self.pers[#"lives"]) && !(level.numteamlives && !game.lives[self.team]);
    timeuntilspawn = globallogic_spawn::timeuntilspawn(1);
    if (livesleft) {
        self function_6bf621ea(#"respawn_timer", 2, int(timeuntilspawn + deathanimduration - 250), self getentitynumber());
    }
    if (!self.var_4ef33446) {
        if (is_true(self.var_342564dd) && self == var_a2f12b49.attacker) {
            waitframe(1);
        } else {
            wait 0.25;
        }
    }
    self.cancelkillcam = 0;
    if (!userspawnselection::isspawnselectenabled()) {
        self thread killcam::cancel_on_use();
    }
    if (!self.var_4ef33446) {
        self watch_death(var_a2f12b49.weapon, var_a2f12b49.attacker, var_a2f12b49.smeansofdeath, deathanimduration);
    }
    self.respawntimerstarttime = gettime();
    keep_deathcam = 0;
    if (level.killcammode == 2) {
        self.var_686890d5 = undefined;
        if (!gamestate::is_game_over()) {
            if (teams::is_all_dead(self.team)) {
                self function_66cec679();
                self thread display_transition::function_1caf5c87(self.team);
            } else if (function_73da2f89()) {
                if (self function_448f7ed2()) {
                    self thread display_transition::function_b3964dc9();
                }
            } else {
                self thread display_transition::function_9b2bd02c();
            }
        }
        self.sessionstate = "dead";
        self.spectatorclient = -1;
        self.killcamentity = -1;
        self.archivetime = 0;
        self.psoffsettime = 0;
        self.spectatekillcam = 0;
        livesleft = !(level.numlives && !self.pers[#"lives"]) && !(level.numteamlives && !game.lives[self.team]);
        if (livesleft) {
            if (is_true(level.deathcirclerespawn)) {
                self thread [[ level.spawnspectator ]](self.origin + (0, 0, 60), self.angles);
            } else {
                function_93115f65();
            }
            return;
        }
        if (!is_true(self.var_686890d5)) {
            self thread [[ level.spawnspectator ]](self.origin + (0, 0, 60), self.angles);
        }
        return;
    } else {
        if (game.state != "playing") {
            return;
        }
        if (isdefined(self.overrideplayerdeadstatus)) {
            keep_deathcam = self [[ self.overrideplayerdeadstatus ]]();
        }
    }
    dokillcam = self should_do_killcam(attacker, var_a2f12b49.einflictor, var_41c4d474, assistedsuicide);
    if (!self.cancelkillcam && dokillcam && level.killcammode == 1 && wasteamkill == 0) {
        self clientfield::set_player_uimodel("hudItems.killcamActive", 1);
        livesleft = !(level.numlives && !self.pers[#"lives"]) && !(level.numteamlives && !game.lives[self.team]);
        timeuntilspawn = globallogic_spawn::timeuntilspawn(1);
        willrespawnimmediately = livesleft && timeuntilspawn <= 0 && !level.playerqueuedrespawn && !userspawnselection::isspawnselectenabled();
        self killcam::killcam(var_c547267e, self getentitynumber(), killcam_entity_info, var_a2f12b49.weapon, var_a2f12b49.smeansofdeath, self.deathtime, deathtimeoffset, psoffsettime, willrespawnimmediately, globallogic_utils::timeuntilroundend(), perks, killstreaks, var_a2f12b49.attacker, keep_deathcam);
        if (sessionmodeiswarzonegame()) {
            self luinotifyevent(#"hash_5b2d65a026de792d", 0);
        }
    } else if (self.cancelkillcam) {
        if (isdefined(self.killcamsskipped)) {
            self.killcamsskipped++;
        } else {
            self.killcamsskipped = 1;
        }
    }
    self clientfield::set_player_uimodel("hudItems.killcamActive", 0);
    self function_7b0f4389();
    if (self.var_4ef33446) {
        waitframe(1);
    }
    secondary_deathcam = 0;
    timeuntilspawn = globallogic_spawn::timeuntilspawn(1);
    shoulddoseconddeathcam = timeuntilspawn > 0;
    if (shoulddoseconddeathcam && isdefined(self.secondarydeathcamtime)) {
        secondary_deathcam = self [[ self.secondarydeathcamtime ]]();
    }
    if (secondary_deathcam > 0 && !self.cancelkillcam) {
        self.spectatorclient = -1;
        self.killcamentity = -1;
        self.archivetime = 0;
        self.psoffsettime = 0;
        self.spectatekillcam = 0;
        globallogic_utils::waitfortimeornotify(secondary_deathcam, "end_death_delay");
        self notify(#"death_delay_finished");
    }
    if (!self.cancelkillcam && dokillcam && level.killcammode == 1 && keep_deathcam) {
        self.sessionstate = "dead";
        self.spectatorclient = -1;
        self.killcamentity = -1;
        self.archivetime = 0;
        self.psoffsettime = 0;
        self.spectatekillcam = 0;
    }
}

// Namespace player/player_killed
// Params 4, eflags: 0x5 linked
// Checksum 0xcc67a544, Offset: 0x2a48
// Size: 0x29c
function private function_7804764f(var_a2f12b49, deathanimduration, psoffsettime, enteredresurrect) {
    pixbeginevent(#"hash_6a07afbdee38d766");
    if (enteredresurrect == 0) {
        var_86825274 = var_a2f12b49.weapon;
        if (weapons::ismeleemod(var_a2f12b49.smeansofdeath) && var_86825274.type != "melee") {
            var_86825274 = level.weaponnone;
        }
        body = self cloneplayer(deathanimduration, var_86825274, var_a2f12b49.attacker, var_a2f12b49.vdir);
        if (isdefined(body) && !level.inprematchperiod) {
            if (is_true(self.var_6f9e9dc9)) {
                body.var_6f9e9dc9 = 1;
            }
            vattackerorigin = undefined;
            if (isdefined(var_a2f12b49.attacker)) {
                vattackerorigin = var_a2f12b49.attacker.origin;
            }
            self create_body(var_a2f12b49, vattackerorigin, deathanimduration, body);
            self battlechatter::play_death_vox(body, var_a2f12b49.attacker, var_a2f12b49.weapon, var_a2f12b49.smeansofdeath);
            var_a1d415ee = self.var_a1d415ee;
            if (isdefined(var_a1d415ee)) {
                globallogic::doweaponspecificcorpseeffects(body, var_a1d415ee.einflictor, var_a1d415ee.attacker, var_a1d415ee.idamage, var_a1d415ee.smeansofdeath, var_a1d415ee.weapon, var_a1d415ee.vdir, var_a1d415ee.shitloc, psoffsettime);
            } else if (!isdefined(self.laststandparams) || !is_true(self.laststandparams.bledout)) {
                globallogic::doweaponspecificcorpseeffects(body, var_a2f12b49.einflictor, var_a2f12b49.attacker, var_a2f12b49.idamage, var_a2f12b49.smeansofdeath, var_a2f12b49.weapon, var_a2f12b49.vdir, var_a2f12b49.shitloc, psoffsettime);
            }
        }
    }
    pixendevent();
}

// Namespace player/player_killed
// Params 3, eflags: 0x5 linked
// Checksum 0xec4b4eb9, Offset: 0x2cf0
// Size: 0x7ac
function private function_c220950f(var_c391d0a8, idamage, weapon_at_time_of_death) {
    killer = undefined;
    killerloadoutindex = -1;
    killerwasads = 0;
    killerinvictimfov = 0;
    victiminkillerfov = 0;
    weapon = var_c391d0a8.weapon;
    victimspecialist = function_b14806c6(self player_role::get(), currentsessionmode());
    if (isplayer(var_c391d0a8.attacker)) {
        attackerspecialist = function_b14806c6(var_c391d0a8.attacker player_role::get(), currentsessionmode());
        killer = var_c391d0a8.attacker;
        killerloadoutindex = var_c391d0a8.attacker.class_num;
        killerwasads = var_c391d0a8.attacker playerads() >= 1;
        killerinvictimfov = util::within_fov(self.origin, self.angles, killer.origin, self.fovcosine);
        victiminkillerfov = util::within_fov(killer.origin, killer.angles, self.origin, killer.fovcosine);
        var_c144d535 = isdefined(self.currentweapon) ? self.currentweapon.name : "";
        attacker_origin = isplayer(killer) ? killer.origin : (0, 0, 0);
        if (killstreaks::is_killstreak_weapon(weapon)) {
            killstreak = killstreaks::get_killstreak_for_weapon_for_stats(weapon);
            bb::function_c3b9e07f(var_c391d0a8.attacker, attacker_origin, attackerspecialist, weapon.name, self, self.origin, victimspecialist, var_c144d535, idamage, var_c391d0a8.smeansofdeath, var_c391d0a8.shitloc, 1, killstreak);
        } else {
            bb::function_c3b9e07f(var_c391d0a8.attacker, attacker_origin, attackerspecialist, weapon.name, self, self.origin, victimspecialist, var_c144d535, idamage, var_c391d0a8.smeansofdeath, var_c391d0a8.shitloc, 1, undefined);
        }
    } else {
        bb::function_c3b9e07f(undefined, undefined, undefined, weapon.name, self, self.origin, victimspecialist, undefined, idamage, var_c391d0a8.smeansofdeath, var_c391d0a8.shitloc, 1, undefined);
    }
    victimweapon = undefined;
    victimweaponpickedup = 0;
    victimkillstreakweaponindex = 0;
    var_8926cc9f = 0;
    if (isdefined(weapon_at_time_of_death)) {
        victimweapon = weapon_at_time_of_death;
        if (isdefined(self.pickedupweapons) && isdefined(self.pickedupweapons[victimweapon])) {
            victimweaponpickedup = 1;
        }
        if (killstreaks::is_killstreak_weapon(victimweapon)) {
            killstreak = killstreaks::get_killstreak_for_weapon_for_stats(victimweapon);
            if (isdefined(level.killstreaks[killstreak].menuname)) {
                var_8926cc9f = 1;
                victimkillstreakweaponindex = level.killstreakindices[level.killstreaks[killstreak].menuname];
                if (!isdefined(victimkillstreakweaponindex)) {
                    var_8926cc9f = 0;
                    victimkillstreakweaponindex = 0;
                }
            }
        }
    }
    victimwasads = self playerads() >= 1;
    killerweaponpickedup = 0;
    killerkillstreakweaponindex = 0;
    var_28af8061 = 0;
    if (isdefined(weapon)) {
        if (isdefined(killer) && isdefined(killer.pickedupweapons) && isdefined(killer.pickedupweapons[weapon])) {
            killerweaponpickedup = 1;
        }
        if (killstreaks::is_killstreak_weapon(weapon)) {
            killstreak = killstreaks::get_killstreak_for_weapon_for_stats(weapon);
            if (isdefined(level.killstreaks[killstreak].menuname)) {
                var_28af8061 = 1;
                killerkillstreakweaponindex = level.killstreakindices[level.killstreaks[killstreak].menuname];
                if (!isdefined(killerkillstreakweaponindex)) {
                    var_28af8061 = 0;
                    killerkillstreakweaponindex = 0;
                }
            }
        }
    }
    var_989983f4 = spawnstruct();
    var_989983f4.victimloadoutindex = self.class_num;
    var_989983f4.victimweaponpickedup = victimweaponpickedup;
    var_989983f4.victimwasads = victimwasads;
    var_989983f4.killerloadoutindex = killerloadoutindex;
    var_989983f4.killerweaponpickedup = killerweaponpickedup;
    var_989983f4.killerwasads = killerwasads;
    var_989983f4.victiminkillerfov = victiminkillerfov;
    var_989983f4.killerinvictimfov = killerinvictimfov;
    var_989983f4.killerkillstreakweaponindex = killerkillstreakweaponindex;
    var_989983f4.victimkillstreakweaponindex = victimkillstreakweaponindex;
    var_989983f4.var_28af8061 = var_28af8061;
    var_989983f4.var_8926cc9f = var_8926cc9f;
    matchrecordlogadditionaldeathinfo(self, killer, victimweapon, weapon, var_989983f4);
    self player_record::record_special_move_data_for_life(killer);
    /#
        attackerstring = "<dev string:x38>";
        if (isdefined(killer)) {
            attackerstring = killer getxuid() + "<dev string:x40>" + killer.name + "<dev string:x45>";
        }
        print("<dev string:x4a>" + var_c391d0a8.smeansofdeath + "<dev string:x40>" + weapon.name + "<dev string:x50>" + attackerstring + "<dev string:x58>" + idamage + "<dev string:x5f>" + (isdefined(var_c391d0a8.shitloc) ? var_c391d0a8.shitloc : "<dev string:x66>") + "<dev string:x6a>" + int(self.origin[0]) + "<dev string:x71>" + int(self.origin[1]) + "<dev string:x71>" + int(self.origin[2]));
    #/
}

// Namespace player/player_killed
// Params 10, eflags: 0x5 linked
// Checksum 0xc3e7ee2c, Offset: 0x34a8
// Size: 0xa7c
function private function_4a762be0(var_c391d0a8, var_a44c7fd8, weapon_at_time_of_death, attackerstance, countdeath, var_41c4d474, var_8efc9727, wasinlaststand, bledout, enteredresurrect) {
    pixbeginevent(#"hash_73d96d7b280db109");
    awardassists = 0;
    wasteamkill = 0;
    wassuicide = 0;
    if (wasinlaststand) {
        function_caabcf70(self, var_a44c7fd8, self.laststandparams, self.var_a1d415ee);
    }
    if (!self.var_4ef33446) {
        self function_abbc84ad(var_c391d0a8.attacker, var_c391d0a8.weapon, var_c391d0a8.smeansofdeath, var_a44c7fd8.einflictor);
    }
    if (var_c391d0a8.assisted_suicide) {
        scoreevents::processscoreevent(#"assisted_suicide", var_c391d0a8.attacker, self, var_c391d0a8.weapon);
        self recordkillmodifier("assistedsuicide");
    }
    if (countdeath) {
        scoreevents::processscoreevent(#"death", self, self, var_c391d0a8.weapon);
    }
    if (isplayer(var_c391d0a8.attacker)) {
        if (var_41c4d474 || var_c391d0a8.assisted_suicide == 1) {
            if (countdeath) {
                wassuicide = 1;
                awardassists = self suicide(var_a44c7fd8.einflictor, var_c391d0a8.attacker, var_c391d0a8.smeansofdeath, var_c391d0a8.weapon, var_c391d0a8.shitloc);
                if (var_c391d0a8.assisted_suicide == 1) {
                    self function_284c61bd(var_c391d0a8.attacker, var_c391d0a8.smeansofdeath);
                }
                if (level.friendlyfire == 4) {
                    self team_kill(var_a44c7fd8.einflictor, var_c391d0a8.attacker, var_c391d0a8.smeansofdeath, var_c391d0a8.weapon, var_c391d0a8.shitloc);
                }
            }
        } else {
            pixbeginevent(#"hash_3c7e54851be0668");
            if (var_8efc9727 && var_c391d0a8.smeansofdeath == "MOD_GRENADE" && level.friendlyfire == 0) {
            } else if (var_8efc9727) {
                wasteamkill = 1;
                self team_kill(var_a44c7fd8.einflictor, var_c391d0a8.attacker, var_c391d0a8.smeansofdeath, var_c391d0a8.weapon, var_c391d0a8.shitloc);
            } else {
                updatekillstreak(var_a44c7fd8.einflictor, var_c391d0a8.attacker, var_c391d0a8.weapon);
                if (bledout == 0 || level.var_7d1eeba9 === 1) {
                    self kill(var_a44c7fd8.einflictor, var_c391d0a8.attacker, var_c391d0a8.smeansofdeath, var_c391d0a8.weapon, var_c391d0a8.shitloc);
                    self function_284c61bd(var_c391d0a8.attacker, var_c391d0a8.smeansofdeath, bledout);
                }
                if (bledout == 0 || level.var_81ca6158 === 1) {
                    if (level.teambased) {
                        awardassists = 1;
                    }
                }
            }
            if (var_c391d0a8.smeansofdeath == "MOD_HEAD_SHOT" && !wasteamkill && !isdefined(killstreaks::get_killstreak_for_weapon(var_c391d0a8.weapon))) {
                scoreevents::processscoreevent(#"headshot", var_c391d0a8.attacker, self, var_c391d0a8.weapon);
                var_c391d0a8.attacker contracts::player_contract_event(#"headshot");
            }
            var_c391d0a8.prevlastkilltime = var_c391d0a8.lastkilltime;
            var_c391d0a8.attacker.lastkilltime = gettime();
            var_c391d0a8.attacker.var_e03e3ae5 = gettime();
            pixendevent();
        }
        if (!var_41c4d474 && !var_8efc9727) {
            var_c391d0a8.attacker notify(#"killed_enemy_player", {#victim:self, #weapon:var_c391d0a8.weapon, #time:gettime()});
            self thread challenges::playerkilled(var_a44c7fd8.einflictor, var_c391d0a8.attacker, var_a44c7fd8.idamage, var_c391d0a8.smeansofdeath, var_c391d0a8.weapon, var_c391d0a8.shitloc, attackerstance, bledout);
        } else {
            self notify(#"playerkilledchallengesprocessed");
        }
        if (isdefined(var_c391d0a8.attacker.pers)) {
            if (var_c391d0a8.attacker.pers[#"hash_49e7469988944ecf"] === 1) {
                if (var_c391d0a8.weapon.statindex == level.weapon_hero_annihilator.statindex) {
                    scoreevents::processscoreevent(#"hash_39926f44fa76b382", var_c391d0a8.attacker, self, var_c391d0a8.weapon);
                    var_c391d0a8.attacker.pers[#"hash_49e7469988944ecf"] = undefined;
                }
            }
        }
    } else if (isdefined(var_c391d0a8.attacker) && (var_c391d0a8.attacker.classname == "trigger_hurt" || var_c391d0a8.attacker.classname == "worldspawn")) {
        scoreevents::processscoreevent(#"suicide", self, undefined, undefined);
        self globallogic_score::incpersstat(#"suicides", 1);
        self.suicides = self globallogic_score::getpersstat(#"suicides");
        self.suicide = 1;
        awardassists = 1;
        self function_284c61bd(undefined, var_c391d0a8.smeansofdeath);
        if (level.maxsuicidesbeforekick > 0 && level.maxsuicidesbeforekick <= self.suicides) {
            self notify(#"teamkillkicked");
            self function_3c238bc5();
        }
    } else {
        wassuicide = 1;
        if (isdefined(var_a44c7fd8.einflictor.killcament)) {
            wassuicide = 0;
        }
        if (isdefined(var_c391d0a8.attacker) && isdefined(var_c391d0a8.attacker.team) && isdefined(level.teams[var_c391d0a8.attacker.team])) {
            if (self util::isenemyteam(var_c391d0a8.attacker.team)) {
                if (level.teambased) {
                    if (!isdefined(killstreaks::get_killstreak_for_weapon(var_c391d0a8.weapon)) || is_true(level.killstreaksgivegamescore)) {
                        globallogic_score::giveteamscore("kill", var_c391d0a8.attacker.team, var_c391d0a8.attacker, self);
                    }
                }
                wassuicide = 0;
            }
        }
        awardassists = 1;
        self function_284c61bd(undefined, var_c391d0a8.smeansofdeath);
    }
    if (!level.ingraceperiod && enteredresurrect == 0) {
        if (var_c391d0a8.smeansofdeath != "MOD_FALLING") {
            if (var_c391d0a8.weapon.name != "incendiary_fire") {
                self weapons::drop_scavenger_for_death(var_c391d0a8.attacker);
            }
        }
        if (should_drop_weapon_on_death(wasteamkill, wassuicide, weapon_at_time_of_death, var_c391d0a8.smeansofdeath)) {
            self weapons::drop_for_death(var_c391d0a8.attacker, var_c391d0a8.weapon, var_c391d0a8.smeansofdeath, var_a44c7fd8.idamage, 0);
        }
    }
    if (awardassists) {
        self function_48a1200f(var_a44c7fd8.einflictor, var_c391d0a8.attacker, var_c391d0a8.weapon);
    }
    pixendevent();
}

// Namespace player/player_killed
// Params 4, eflags: 0x5 linked
// Checksum 0xbb27af91, Offset: 0x3f30
// Size: 0x164
function private function_c2c4d6e9(var_c391d0a8, *bledout, enteredresurrect, countdeath) {
    self update_killstreaks(bledout.attacker, bledout.weapon);
    if (enteredresurrect == 0) {
        self.sessionstate = "dead";
        self.statusicon = "hud_status_dead";
    }
    self.hasriotshield = 0;
    self.hasriotshieldequipped = 0;
    self.pers[#"weapon"] = undefined;
    self.killedplayerscurrent = [];
    self.lastattacker = bledout.attacker;
    self.lastdeathpos = self.origin;
    self.pickedupweapons = [];
    self.switching_teams = undefined;
    self.joining_team = undefined;
    self.leaving_team = undefined;
    self.wantsafespawn = 0;
    if (countdeath) {
        if (!isdefined(self.deathcount)) {
            self.deathcount = 0;
        }
        self.deathcount++;
    }
    println("<dev string:x76>" + self.clientid + "<dev string:x82>" + self.deathcount);
}

// Namespace player/player_killed
// Params 5, eflags: 0x5 linked
// Checksum 0xfcfb387e, Offset: 0x40a0
// Size: 0x4ce
function private function_fc51dcf8(attacker, weapon, smeansofdeath, shitloc, var_20227168) {
    var_3a41c58c = {#attacker:undefined, #weapon:weapon, #smeansofdeath:smeansofdeath, #shitloc:shitloc, #assisted_suicide:0};
    if (isdefined(self.attackers) && (!isdefined(attacker) || attacker.classname === "trigger_hurt" || attacker.classname === "worldspawn" || is_true(attacker.ismagicbullet) || attacker == self)) {
        if (!var_20227168) {
            foreach (player in self.attackers) {
                if (!isdefined(player)) {
                    continue;
                }
                if (!isdefined(self.attackerdamage[player.clientid]) || !isdefined(self.attackerdamage[player.clientid].damage)) {
                    continue;
                }
                if (player == self) {
                    continue;
                }
                if (isdefined(level.var_c77de7d6) && gettime() > int(level.var_c77de7d6 * 1000) + self.attackerdamage[player.clientid].lastdamagetime) {
                    continue;
                }
                if (!globallogic_player::allowedassistweapon(self.attackerdamage[player.clientid].weapon)) {
                    continue;
                }
                attacker_damage = self.attackerdamage[player.clientid];
                if (attacker_damage.damage > 1 && !isdefined(var_3a41c58c.attacker)) {
                    var_3a41c58c.attacker = player;
                    var_3a41c58c.smeansofdeath = attacker_damage.meansofdeath;
                    var_3a41c58c.weapon = attacker_damage.weapon;
                    var_3a41c58c.shitloc = attacker_damage.shitloc;
                    continue;
                }
                if (isdefined(var_3a41c58c.attacker) && self.attackerdamage[player.clientid].damage > self.attackerdamage[var_3a41c58c.attacker.clientid].damage) {
                    var_3a41c58c.attacker = player;
                    var_3a41c58c.smeansofdeath = attacker_damage.meansofdeath;
                    var_3a41c58c.weapon = attacker_damage.weapon;
                    var_3a41c58c.shitloc = attacker_damage.shitloc;
                }
            }
        }
        if (isdefined(var_3a41c58c.attacker)) {
            var_3a41c58c.assisted_suicide = 1;
        }
    }
    if (!isdefined(var_3a41c58c.attacker)) {
        var_3a41c58c.attacker = attacker;
    }
    var_3a41c58c.smeansofdeath = self function_b029639e(var_3a41c58c.attacker, var_3a41c58c.weapon, var_3a41c58c.smeansofdeath, var_3a41c58c.shitloc);
    if (isdefined(self.var_a1d415ee) && isplayer(self.var_a1d415ee.attacker)) {
        var_3a41c58c.var_23da26bf = self.var_a1d415ee.attacker;
        var_3a41c58c.var_60851fcf = self.var_a1d415ee.weapon;
        var_3a41c58c.var_4b5379af = self.var_a1d415ee.smeansofdeath;
        var_3a41c58c.var_6613188 = self.var_a1d415ee.shitloc;
    } else {
        var_3a41c58c.var_23da26bf = var_3a41c58c.attacker;
        var_3a41c58c.var_4b5379af = var_3a41c58c.smeansofdeath;
        var_3a41c58c.var_60851fcf = var_3a41c58c.weapon;
        var_3a41c58c.var_6613188 = var_3a41c58c.shitloc;
    }
    return var_3a41c58c;
}

// Namespace player/player_killed
// Params 2, eflags: 0x5 linked
// Checksum 0x3908d269, Offset: 0x4578
// Size: 0xf2
function private function_5f6cde96(var_41c4d474, var_8efc9727) {
    self.deathtime = gettime();
    self.pers[#"deathtime"] = self.deathtime;
    if (!var_41c4d474 && !var_8efc9727) {
        assert(isdefined(self.lastspawntime));
        if (!isdefined(self.alivetimecurrentindex)) {
            self.alivetimecurrentindex = 0;
        }
        if (isdefined(self.lastspawntime)) {
            self.alivetimes[self.alivetimecurrentindex] = self.deathtime - self.lastspawntime;
        } else {
            self.alivetimes[self.alivetimecurrentindex] = 0;
        }
        self.alivetimecurrentindex = (self.alivetimecurrentindex + 1) % level.alivetimemaxcount;
    }
}

// Namespace player/player_killed
// Params 0, eflags: 0x0
// Checksum 0x9b1d4f11, Offset: 0x4678
// Size: 0x1c
function function_e3d34c3b() {
    wait 20;
    function_93115f65();
}

// Namespace player/player_killed
// Params 0, eflags: 0x1 linked
// Checksum 0x68e7e1db, Offset: 0x46a0
// Size: 0x90
function function_6faccb24() {
    var_3db6ed91 = level.deathcircles.size - 2;
    if (var_3db6ed91 < 0) {
        return false;
    }
    if (level.deathcircleindex === var_3db6ed91) {
        return (is_true(level.deathcircle.var_8663a20d.scaling) || level.deathcircle.var_8663a20d.radius <= 0);
    }
    return false;
}

// Namespace player/player_killed
// Params 0, eflags: 0x1 linked
// Checksum 0x604cf17e, Offset: 0x4738
// Size: 0x40
function function_9956f107() {
    if (isdefined(level.deathcircle.var_8663a20d) && !isdefined(level.deathcircle.nextcircle)) {
        return true;
    }
    return false;
}

// Namespace player/player_killed
// Params 0, eflags: 0x1 linked
// Checksum 0x592eaf0a, Offset: 0x4780
// Size: 0xfa
function function_73da2f89() {
    if (game.state != "pregame" && game.state != "playing") {
        return 0;
    }
    if (is_true(level.var_d91ebbf4)) {
        if (function_6faccb24()) {
            return 0;
        }
        if (isdefined(level.var_78442886) && isdefined(level.var_245d4af9) && level.var_78442886 >= level.var_245d4af9) {
            return 0;
        }
    }
    if (is_true(level.wave_spawn) && function_9956f107()) {
        return 0;
    }
    return globallogic_player::function_38527849();
}

// Namespace player/player_killed
// Params 1, eflags: 0x5 linked
// Checksum 0xd1699b92, Offset: 0x4888
// Size: 0x186
function private function_93115f65(enteredresurrect) {
    if (is_true(enteredresurrect)) {
        return;
    }
    if (game.state != "playing") {
        self.sessionstate = "dead";
        self.spectatorclient = -1;
        self.killcamtargetentity = -1;
        self.killcamentity = -1;
        self.archivetime = 0;
        self.psoffsettime = 0;
        self.spectatekillcam = 0;
        return;
    }
    function_f9dc085a();
    userespawntime = 1;
    if (isdefined(level.hostmigrationtimer)) {
        userespawntime = 0;
    }
    hostmigration::waittillhostmigrationcountdown();
    if (globallogic_utils::isvalidclass(self.curclass) || !loadout::function_87bcb1b()) {
        timepassed = undefined;
        if (isdefined(self.respawntimerstarttime) && userespawntime) {
            timepassed = float(gettime() - self.respawntimerstarttime) / 1000;
        }
        self thread [[ level.spawnclient ]](timepassed);
        self.respawntimerstarttime = undefined;
    }
}

// Namespace player/player_killed
// Params 4, eflags: 0x5 linked
// Checksum 0xccedb9c7, Offset: 0x4a18
// Size: 0x33c
function private function_caabcf70(victim, var_aedb48f4, laststandparams, var_a1d415ee) {
    assert(isdefined(victim));
    assert(isdefined(var_aedb48f4));
    if (!isdefined(victim) || !isdefined(var_aedb48f4)) {
        return;
    }
    var_f53d817d = isdefined(laststandparams) ? laststandparams : var_aedb48f4;
    var_ee2f4691 = isdefined(var_a1d415ee) ? var_a1d415ee : var_aedb48f4;
    function_ad11630f(victim, var_f53d817d.victimorigin, var_f53d817d.var_5fceefd4, var_f53d817d.victimweapon, var_f53d817d.attacker, var_f53d817d.attackerorigin, var_f53d817d.var_83634238, var_f53d817d.weapon, var_f53d817d.matchtime, var_f53d817d.shitloc, var_f53d817d.smeansofdeath, var_ee2f4691.attacker, var_ee2f4691.attackerorigin, var_ee2f4691.var_83634238, var_ee2f4691.weapon, var_ee2f4691.matchtime, var_ee2f4691.shitloc, var_ee2f4691.smeansofdeath);
    lifeindex = victim match_record::get_player_stat(#"hash_ec4aea1a8bbd82");
    if (isdefined(lifeindex) && isdefined(victim) && isplayer(victim)) {
        victimindex = victim match_record::get_player_index();
        if (isdefined(victimindex)) {
            match_record::set_stat(#"lives", lifeindex, #"player_index", victimindex);
        }
        if (isdefined(var_f53d817d) && isdefined(var_f53d817d.attacker) && isplayer(var_f53d817d.attacker)) {
            attackerindex = var_f53d817d.attacker match_record::get_player_index();
            if (isdefined(attackerindex)) {
                match_record::set_stat(#"lives", lifeindex, #"attacker_index", attackerindex);
            }
        }
        if (isdefined(var_ee2f4691) && isdefined(var_ee2f4691.attacker) && isplayer(var_ee2f4691.attacker)) {
            killerindex = var_ee2f4691.attacker match_record::get_player_index();
            if (isdefined(killerindex)) {
                match_record::set_stat(#"lives", lifeindex, #"killer_index", killerindex);
            }
        }
    }
}

// Namespace player/player_killed
// Params 0, eflags: 0x5 linked
// Checksum 0x8df5d1ec, Offset: 0x4d60
// Size: 0x184
function private function_7b0f4389() {
    self.var_eca4c67f = 0;
    if (userspawnselection::isspawnselectenabled() && !is_true(self.switching_teams) && self globallogic_spawn::mayspawn()) {
        while (!self function_d1be915f()) {
            waitframe(1);
        }
        showmenu = self userspawnselection::shouldshowspawnselectionmenu();
        if (showmenu) {
            if (isdefined(self.predicted_spawn_point)) {
                self setorigin(self.predicted_spawn_point.origin);
                self setplayerangles(self.predicted_spawn_point.angles);
            }
            specialistindex = self player_role::get();
            if (player_role::is_valid(specialistindex)) {
                self.var_eca4c67f = 1;
                self userspawnselection::function_b55c5868();
                self userspawnselection::waitforspawnselection();
            }
            return;
        }
        self userspawnselection::activatespawnselectionmenu();
    }
}

// Namespace player/player_killed
// Params 0, eflags: 0x5 linked
// Checksum 0x4a9bd71d, Offset: 0x4ef0
// Size: 0x38
function private function_d1be915f() {
    if (self isremotecontrolling()) {
        return false;
    }
    if (isdefined(self.killstreak_delay_killcam)) {
        return false;
    }
    return true;
}

// Namespace player/player_killed
// Params 4, eflags: 0x5 linked
// Checksum 0x4496cee3, Offset: 0x4f30
// Size: 0x15e
function private watch_death(weapon, attacker, smeansofdeath, deathanimduration) {
    defaultplayerdeathwatchtime = 1.75;
    if (smeansofdeath == "MOD_MELEE_ASSASSINATE" || 0 > weapon.deathcamtime) {
        defaultplayerdeathwatchtime = deathanimduration * 0.001 + 0.5;
    } else if (0 < weapon.deathcamtime) {
        defaultplayerdeathwatchtime = weapon.deathcamtime;
    }
    if (isdefined(level.overrideplayerdeathwatchtimer)) {
        defaultplayerdeathwatchtime = [[ level.overrideplayerdeathwatchtimer ]](defaultplayerdeathwatchtime);
    }
    /#
        if (getdvarfloat(#"hash_8138dbf7b9de085", -1) >= 0) {
            defaultplayerdeathwatchtime = getdvarfloat(#"hash_8138dbf7b9de085", -1);
        }
    #/
    if (!(is_true(self.var_342564dd) && self == attacker)) {
        globallogic_utils::waitfortimeornotify(defaultplayerdeathwatchtime, "end_death_delay");
    }
    self notify(#"death_delay_finished");
}

// Namespace player/player_killed
// Params 4, eflags: 0x5 linked
// Checksum 0x7a869248, Offset: 0x5098
// Size: 0xee
function private function_b029639e(attacker, weapon, smeansofdeath, shitloc) {
    assert(isdefined(smeansofdeath));
    if (weapons::isheadshot(weapon, shitloc, smeansofdeath) && isplayer(attacker)) {
        return "MOD_HEAD_SHOT";
    }
    switch (weapon.name) {
    case #"dog_bite":
        return "MOD_PISTOL_BULLET";
    case #"destructible_car":
        return "MOD_EXPLOSIVE";
    case #"explodable_barrel":
        return "MOD_EXPLOSIVE";
    }
    return smeansofdeath;
}

// Namespace player/player_killed
// Params 2, eflags: 0x5 linked
// Checksum 0x2968cb94, Offset: 0x5190
// Size: 0x438
function private update_killstreaks(attacker, weapon) {
    if (!isdefined(self.switching_teams) && !self.var_4ef33446) {
        if (isplayer(attacker) && level.teambased && attacker != self && !self util::isenemyteam(attacker.team)) {
            self.pers[#"cur_kill_streak"] = 0;
            self.pers[#"cur_total_kill_streak"] = 0;
            self.pers[#"totalkillstreakcount"] = 0;
            self.pers[#"killstreaksearnedthiskillstreak"] = 0;
            self setplayercurrentstreak(0);
        } else {
            if (!is_true(self.var_cee93f5)) {
                self globallogic_score::incpersstat(#"deaths", 1, 1, 1);
            }
            self.deaths = self globallogic_score::getpersstat(#"deaths");
            self updatestatratio("kdratio", "kills", "deaths");
            if (self.pers[#"cur_kill_streak"] > self.pers[#"best_kill_streak"]) {
                self.pers[#"best_kill_streak"] = self.pers[#"cur_kill_streak"];
            }
            self.pers[#"kill_streak_before_death"] = self.pers[#"cur_kill_streak"];
            if (isdefined(self.pers[#"hvo"]) && isdefined(self.pers[#"hvo"][#"current"])) {
                self.pers[#"hvo"][#"current"][#"highestkillstreak"] = 0;
            }
            self.pers[#"cur_kill_streak"] = 0;
            self.pers[#"cur_total_kill_streak"] = 0;
            self.pers[#"totalkillstreakcount"] = 0;
            self.pers[#"killstreaksearnedthiskillstreak"] = 0;
            self setplayercurrentstreak(0);
            if (isdefined(self.cur_death_streak)) {
                self.cur_death_streak++;
                if (self.cur_death_streak >= getdvarint(#"perk_deathstreakcountrequired", 0)) {
                    self enabledeathstreak();
                }
            }
        }
    } else {
        self.pers[#"cur_kill_streak"] = 0;
        self.pers[#"cur_total_kill_streak"] = 0;
        self.pers[#"totalkillstreakcount"] = 0;
        self.pers[#"killstreaksearnedthiskillstreak"] = 0;
        self setplayercurrentstreak(0);
    }
    if (killstreaks::is_killstreak_weapon(weapon)) {
        level.globalkillstreaksdeathsfrom++;
    }
}

// Namespace player/player_killed
// Params 4, eflags: 0x5 linked
// Checksum 0x49c21fcf, Offset: 0x55d0
// Size: 0x3b4
function private function_abbc84ad(attacker, weapon, smeansofdeath, inflictor) {
    if (isplayer(attacker) && attacker != self && (!level.teambased || self util::isenemyteam(attacker.team))) {
        attackerweaponpickedup = 0;
        if (isdefined(attacker.pickedupweapons) && isdefined(attacker.pickedupweapons[weapon])) {
            attackerweaponpickedup = 1;
        }
        self stats::function_eec52333(weapon, #"deaths", 1, self.class_num, attackerweaponpickedup);
        victim_weapon = self.lastdroppableweapon;
        if (isdefined(victim_weapon)) {
            victimweaponpickedup = 0;
            if (isdefined(self.pickedupweapons) && isdefined(self.pickedupweapons[victim_weapon])) {
                victimweaponpickedup = 1;
            }
            self stats::function_eec52333(victim_weapon, #"deathsduringuse", 1, self.class_num, victimweaponpickedup);
        }
        recordweaponstatkills = 1;
        if (attacker.isthief === 1 && isdefined(weapon) && weapon.isheroweapon === 1) {
            recordweaponstatkills = 0;
        }
        if (smeansofdeath != "MOD_FALLING" && recordweaponstatkills) {
            if (weapon.name == #"explosive_bolt" && isdefined(inflictor) && isdefined(inflictor.ownerweaponatlaunch) && inflictor.owneradsatlaunch) {
                inflictorownerweaponatlaunchpickedup = 0;
                if (isdefined(attacker.pickedupweapons) && isdefined(attacker.pickedupweapons[inflictor.ownerweaponatlaunch])) {
                    inflictorownerweaponatlaunchpickedup = 1;
                }
                attacker stats::function_eec52333(inflictor.ownerweaponatlaunch, #"kills", 1, attacker.class_num, inflictorownerweaponatlaunchpickedup, 1);
            } else {
                attacker stats::function_eec52333(weapon, #"kills", 1, attacker.class_num, attackerweaponpickedup);
            }
        }
        if (smeansofdeath == "MOD_HEAD_SHOT") {
            attacker stats::function_eec52333(weapon, #"headshots", 1, attacker.class_num, attackerweaponpickedup);
        }
        if (smeansofdeath == "MOD_PROJECTILE") {
            attacker stats::function_e24eec31(weapon, #"direct_hit_kills", 1);
        }
        victimisroulette = self.isroulette === 1;
        if (self ability_player::gadget_checkheroabilitykill(attacker) && !victimisroulette) {
            attacker stats::function_e24eec31(attacker.heroability, #"kills_while_active", 1);
        }
    }
}

// Namespace player/player_killed
// Params 6, eflags: 0x1 linked
// Checksum 0x49825198, Offset: 0x5990
// Size: 0x464
function function_a3030357(attacker, einflictor, weapon, smeansofdeath, bledout, *var_bee367e6) {
    if (self.var_4ef33446) {
        return;
    }
    if (!isplayer(einflictor) || self util::isenemyplayer(einflictor) == 0 || isdefined(smeansofdeath) && killstreaks::is_killstreak_weapon(smeansofdeath)) {
        level notify(#"reset_obituary_count");
        level.lastobituaryplayercount = 0;
        level.lastobituaryplayer = undefined;
    } else {
        if (isdefined(level.lastobituaryplayer) && level.lastobituaryplayer == einflictor) {
            level.lastobituaryplayercount++;
        } else {
            level notify(#"reset_obituary_count");
            level.lastobituaryplayer = einflictor;
            level.lastobituaryplayercount = 1;
        }
        level thread scoreevents::decrementlastobituaryplayercountafterfade();
        if (level.lastobituaryplayercount >= 4) {
            level notify(#"reset_obituary_count");
            level.lastobituaryplayercount = 0;
            level.lastobituaryplayer = undefined;
            self thread scoreevents::uninterruptedobitfeedkills(einflictor, smeansofdeath);
        }
    }
    overrideentitycamera = function_c0f28ff9(einflictor, smeansofdeath);
    var_50d1e41a = potm::function_775b9ad1(smeansofdeath, bledout);
    var_e9d49a33 = 0;
    if (isdefined(smeansofdeath) && killstreaks::is_killstreak_weapon(smeansofdeath)) {
        var_e9d49a33 = 1;
    }
    if (isdefined(weapon) && (is_true(weapon.var_e9d49a33) || isdefined(weapon.owner) && is_true(weapon.owner.var_e9d49a33))) {
        var_e9d49a33 = 1;
    }
    var_f87dccb5 = self util::isenemyteam(einflictor.team);
    if (self != einflictor && !var_f87dccb5) {
        var_e9d49a33 = 1;
    }
    if (isdefined(weapon) && weapon.archetype === "robot") {
        if (bledout == "MOD_HIT_BY_OBJECT") {
            smeansofdeath = getweapon(#"combat_robot_marker");
        }
        bledout = "MOD_RIFLE_BULLET";
    }
    if (var_bee367e6) {
        bledout = "MOD_BLED_OUT";
    }
    if (level.teambased && isdefined(einflictor.pers) && !var_f87dccb5 && bledout == "MOD_GRENADE" && level.friendlyfire == 0) {
        obituary(self, self, smeansofdeath, bledout);
        demo::kill_bookmark(self, self, weapon, var_50d1e41a, overrideentitycamera);
        if (!var_e9d49a33) {
            potm::kill_bookmark(self, self, weapon, var_50d1e41a, overrideentitycamera);
        }
        return;
    }
    obituary(self, einflictor, smeansofdeath, bledout);
    demo::kill_bookmark(einflictor, self, weapon, var_50d1e41a, overrideentitycamera);
    if (!var_e9d49a33) {
        potm::kill_bookmark(einflictor, self, weapon, var_50d1e41a, overrideentitycamera);
    }
}

// Namespace player/player_killed
// Params 2, eflags: 0x1 linked
// Checksum 0xd2d76bb2, Offset: 0x5e00
// Size: 0x62
function function_c0f28ff9(attacker, weapon) {
    overrideentitycamera = 0;
    if (!isdefined(weapon)) {
        return overrideentitycamera;
    }
    if (killstreaks::is_killstreak_weapon(weapon)) {
        overrideentitycamera = killstreaks::should_override_entity_camera_in_demo(attacker, weapon);
    }
    return overrideentitycamera;
}

// Namespace player/player_killed
// Params 5, eflags: 0x5 linked
// Checksum 0xd6348054, Offset: 0x5e70
// Size: 0x348
function private suicide(einflictor, attacker, smeansofdeath, weapon, shitloc) {
    awardassists = 0;
    self.suicide = 0;
    if (isdefined(self.switching_teams)) {
        if (!level.teambased && isdefined(level.teams[self.leaving_team]) && isdefined(level.teams[self.joining_team]) && level.teams[self.leaving_team] != level.teams[self.joining_team]) {
            playercounts = self teams::count_players();
            playercounts[self.leaving_team]--;
            playercounts[self.joining_team]++;
            if (playercounts[self.joining_team] - playercounts[self.leaving_team] > 1) {
                scoreevents::processscoreevent(#"suicide", self, undefined, undefined);
                self globallogic_score::incpersstat(#"suicides", 1);
                self.suicides = self globallogic_score::getpersstat(#"suicides");
                self.suicide = 1;
            }
        }
    } else {
        scoreevents::processscoreevent(#"suicide", self);
        self globallogic_score::incpersstat(#"suicides", 1);
        self.suicides = self globallogic_score::getpersstat(#"suicides");
        if (smeansofdeath === "MOD_SUICIDE" && shitloc === "none" && is_true(self.throwinggrenade)) {
            self.lastgrenadesuicidetime = gettime();
        }
        if (level.maxsuicidesbeforekick > 0 && level.maxsuicidesbeforekick <= self.suicides) {
            self notify(#"teamkillkicked");
            self function_3c238bc5();
        }
        awardassists = 1;
        self.suicide = 1;
    }
    if (isdefined(self.friendlydamage)) {
        self iprintln(#"mp/friendly_fire_will_not");
        if (level.teamkillpointloss) {
            scoresub = self [[ level.getteamkillscore ]](einflictor, attacker, smeansofdeath, weapon);
            globallogic_score::function_17a678b7(attacker, scoresub);
        }
    }
    return awardassists;
}

// Namespace player/player_killed
// Params 5, eflags: 0x5 linked
// Checksum 0xa7da50b9, Offset: 0x61c0
// Size: 0x2f4
function private team_kill(einflictor, attacker, smeansofdeath, weapon, *shitloc) {
    scoreevents::processscoreevent(#"team_kill", smeansofdeath, undefined, shitloc);
    self.teamkilled = 1;
    if (!ignore_team_kills(shitloc, weapon, attacker)) {
        teamkill_penalty = self [[ level.getteamkillpenalty ]](attacker, smeansofdeath, weapon, shitloc);
        smeansofdeath globallogic_score::incpersstat(#"teamkills_nostats", teamkill_penalty, 0);
        smeansofdeath globallogic_score::incpersstat(#"teamkills", 1);
        if (!isdefined(smeansofdeath.teamkillsthisround)) {
            smeansofdeath.teamkillsthisround = 0;
        }
        smeansofdeath.teamkillsthisround++;
        if (level.friendlyfire == 4 && smeansofdeath.pers[#"teamkills_nostats"] == level.var_fe3ff9c1) {
            smeansofdeath.var_e03ca8a5 = 1;
        }
        if (level.teamkillpointloss) {
            scoresub = self [[ level.getteamkillscore ]](attacker, smeansofdeath, weapon, shitloc);
            globallogic_score::function_17a678b7(smeansofdeath, scoresub);
        }
        if (globallogic_utils::gettimepassed() < 5000) {
            var_821200bb = 1;
        } else if (smeansofdeath.pers[#"teamkills_nostats"] > 1 && globallogic_utils::gettimepassed() < int((8 + smeansofdeath.pers[#"teamkills_nostats"]) * 1000)) {
            var_821200bb = 1;
        } else {
            var_821200bb = smeansofdeath function_821200bb();
        }
        if (var_821200bb > 0) {
            smeansofdeath.teamkillpunish = 1;
            smeansofdeath thread wait_and_suicide();
            if (smeansofdeath function_78a6af2d(var_821200bb)) {
                smeansofdeath notify(#"teamkillkicked");
                smeansofdeath thread function_dd602974();
            }
            smeansofdeath thread function_a932bf9c();
        }
    }
}

// Namespace player/player_killed
// Params 0, eflags: 0x5 linked
// Checksum 0x479586eb, Offset: 0x64c0
// Size: 0x8c
function private wait_and_suicide() {
    self endon(#"disconnect");
    self val::set(#"wait_and_suicide", "freezecontrols");
    wait 0.25;
    self val::reset(#"wait_and_suicide", "freezecontrols");
    self suicide();
}

// Namespace player/player_killed
// Params 3, eflags: 0x5 linked
// Checksum 0x97cf376c, Offset: 0x6558
// Size: 0x2e4
function private function_48a1200f(einflictor, attacker, weapon) {
    pixbeginevent(#"hash_115d2072d5ab2061");
    if (isdefined(self.attackers)) {
        for (j = 0; j < self.attackers.size; j++) {
            player = self.attackers[j];
            if (!isdefined(player)) {
                continue;
            }
            if (player == attacker) {
                continue;
            }
            if (player util::isenemyteam(attacker.team)) {
                continue;
            }
            damage_done = self.attackerdamage[player.clientid].damage;
            if (sessionmodeismultiplayergame() && isdefined(player.currentweapon)) {
                function_92d1707f(#"hash_d1357992f4715f0", {#gametime:function_f8d53445(), #assistspawnid:getplayerspawnid(player), #assistspecialist:function_b14806c6(player player_role::get(), currentsessionmode()), #assistweapon:player.currentweapon.name});
            }
            player thread globallogic_score::processassist(self, damage_done, self.attackerdamage[player.clientid].weapon, self.attackerdamage[player.clientid].time, self.attackerdamage[player.clientid].smeansofdeath);
        }
    }
    if (level.teambased) {
        self globallogic_score::processkillstreakassists(attacker, einflictor, weapon);
    }
    if (isdefined(self.lastattackedshieldplayer) && isdefined(self.lastattackedshieldtime) && self.lastattackedshieldplayer != attacker) {
        if (gettime() - self.lastattackedshieldtime < 4000) {
            self.lastattackedshieldplayer thread globallogic_score::processshieldassist(self);
        }
    }
    pixendevent();
}

// Namespace player/player_killed
// Params 1, eflags: 0x1 linked
// Checksum 0xd240436, Offset: 0x6848
// Size: 0x10c
function function_f632c17e(weapon) {
    if (isdefined(weapon) && isdefined(level.iskillstreakweapon) && [[ level.iskillstreakweapon ]](weapon)) {
        return true;
    }
    if (isdefined(weapon) && isdefined(weapon.statname) && isdefined(level.iskillstreakweapon) && [[ level.iskillstreakweapon ]](getweapon(weapon.statname))) {
        return true;
    }
    switch (weapon.name) {
    case #"ar_accurate_t8_swat":
    case #"hash_17df39d53492b0bf":
    case #"tank_robot_launcher_turret":
    case #"ac130_chaingun":
    case #"hash_7b24d0d0d2823bca":
        return true;
    }
    return false;
}

// Namespace player/player_killed
// Params 5, eflags: 0x5 linked
// Checksum 0x79a1b53d, Offset: 0x6960
// Size: 0x4a4
function private function_4e3e8bee(einflictor, attacker, smeansofdeath, weapon, var_e7a369ea) {
    attacker thread globallogic_score::givekillstats(smeansofdeath, weapon, self, var_e7a369ea);
    killstreak = killstreaks::get_killstreak_for_weapon(weapon);
    var_7414b854 = 0;
    if (isdefined(killstreak)) {
        if (scoreevents::isregisteredevent(killstreak)) {
            scoreevents::processscoreevent(killstreak, attacker, self, weapon);
        }
        if (isdefined(einflictor)) {
            bundle = einflictor killstreak_bundles::function_48e9536e();
            if (isdefined(bundle) && is_true(bundle.var_ad1e41b)) {
                scoreevents::processscoreevent(#"ekia", attacker, self, weapon);
            }
            if (killstreak == "dart" || killstreak == "inventory_dart") {
                einflictor notify(#"veh_collision");
                callback::callback(#"veh_collision", {#normal:(0, 0, 1)});
            }
        }
    } else if (!function_f632c17e(weapon)) {
        if (var_e7a369ea == attacker) {
            if (isdefined(self.laststandparams)) {
                if (isdefined(self.var_a1d415ee) && self.laststandparams.attacker !== self.var_a1d415ee.attacker) {
                    scoreevents::processscoreevent(#"kill", self.laststandparams.attacker, self, self.laststandparams.weapon);
                    scoreevents::processscoreevent(#"cleaned_up", self.var_a1d415ee.attacker, self, self.var_a1d415ee.weapon);
                    scoreevents::processscoreevent(#"hash_3a4044777bf1a070", self.var_a1d415ee.attacker, self, self.var_a1d415ee.weapon);
                } else {
                    scoreevents::processscoreevent(#"kill", attacker, self, weapon);
                }
                var_7414b854 = is_true(self.laststandparams.var_7414b854);
            } else {
                scoreevents::processscoreevent(#"kill", attacker, self, weapon);
            }
            if (distancesquared(self.origin, var_e7a369ea.origin) <= function_a3f6cdac(100)) {
                scoreevents::processscoreevent(#"hash_56ede06b1821a561", var_e7a369ea, self, weapon);
            }
        }
    }
    damage = self function_40c6c42d(attacker);
    if (var_7414b854) {
        function_f887b191(self, attacker, damage, 4);
    } else {
        function_f887b191(self, attacker, damage);
    }
    attacker thread globallogic_score::trackattackerkill(self.name, self.pers[#"rank"], self.pers[#"rankxp"], self.pers[#"prestige"], self getxuid(), weapon);
    attacker thread globallogic_score::inckillstreaktracker(weapon);
}

// Namespace player/player_killed
// Params 5, eflags: 0x5 linked
// Checksum 0x407cd763, Offset: 0x6e10
// Size: 0x21c
function private kill(einflictor, attacker, smeansofdeath, weapon, *shitloc) {
    if (!isdefined(killstreaks::get_killstreak_for_weapon(shitloc)) || is_true(level.killstreaksgivegamescore)) {
        globallogic_score::inctotalkills(smeansofdeath.team);
    }
    attackername = smeansofdeath.name;
    self thread globallogic_score::trackattackeedeath(attackername, smeansofdeath.pers[#"rank"], smeansofdeath.pers[#"rankxp"], smeansofdeath.pers[#"prestige"], smeansofdeath getxuid());
    self thread medals::setlastkilledby(smeansofdeath, attacker);
    if (level.teambased && smeansofdeath.team != #"spectator") {
        killstreak = killstreaks::get_killstreak_for_weapon(shitloc);
        if (!isdefined(killstreak) || is_true(level.killstreaksgivegamescore)) {
            globallogic_score::giveteamscore("kill", smeansofdeath.team, smeansofdeath, self);
        }
    }
    scoresub = level.deathpointloss;
    if (scoresub != 0) {
        globallogic_score::function_17a678b7(self, scoresub);
    }
    level thread function_e8decd0b(smeansofdeath, shitloc, self, attacker, weapon);
}

// Namespace player/player_killed
// Params 1, eflags: 0x5 linked
// Checksum 0x97fa6d9, Offset: 0x7038
// Size: 0x24
function private should_allow_postgame_death(smeansofdeath) {
    if (smeansofdeath == "MOD_POST_GAME") {
        return true;
    }
    return false;
}

// Namespace player/player_killed
// Params 9, eflags: 0x5 linked
// Checksum 0xc9868e46, Offset: 0x7068
// Size: 0x2d4
function private post_game_death(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, *psoffsettime, deathanimduration) {
    if (!should_allow_postgame_death(weapon)) {
        return;
    }
    self weapons::detach_carry_object_model();
    self.sessionstate = "dead";
    self.spectatorclient = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    clone_weapon = vdir;
    if (weapons::ismeleemod(weapon) && clone_weapon.type != "melee") {
        clone_weapon = level.weaponnone;
    }
    body = self cloneplayer(deathanimduration, clone_weapon, idamage, shitloc);
    if (isdefined(body)) {
        vattacker = isdefined(idamage) ? idamage : self;
        var_a2f12b49 = {#victimorigin:self.origin, #var_5fceefd4:self getplayerangles(), #victimweapon:self.currentweapon, #einflictor:attacker, #attacker:idamage, #attackerorigin:vattacker.origin, #var_83634238:isplayer(vattacker) ? vattacker getplayerangles() : vattacker.angles, #idamage:smeansofdeath, #smeansofdeath:weapon, #weapon:vdir, #vdir:shitloc, #shitloc:psoffsettime, #matchtime:function_f8d53445()};
        self create_body(var_a2f12b49, (0, 0, 0), deathanimduration, body);
    }
}

// Namespace player/player_killed
// Params 0, eflags: 0x5 linked
// Checksum 0xaf441c4, Offset: 0x7348
// Size: 0x630
function private function_395ef176() {
    self endon(#"disconnect");
    var_8f42b3ff = 10;
    var_65671d4a = level.numteamlives - var_8f42b3ff;
    if (is_true(level.teambased) && is_true(level.takelivesondeath) && level.numteamlives > 0) {
        enemy_team = util::getotherteam(self.team);
        teamarray = getplayers(self.team);
        if (game.lives[self.team] == 0 && !level.var_61952d8b[self.team]) {
            level.var_61952d8b[self.team] = 1;
            level.var_a236b703[self.team] = 1;
            thread globallogic_audio::leader_dialog("controlNoLives", self.team);
            thread globallogic_audio::leader_dialog("controlNoLivesEnemy", enemy_team);
            clientfield::set_world_uimodel("hudItems.team" + level.teamindex[self.team] + ".noRespawnsLeft", 1);
            level notify(#"hash_15b8b6edc4ed3032");
            game.lives[self.team] = 0;
            level.var_9161927e[self.team] = teamarray.size;
            teammates = function_a1ef346b(self.team);
            foreach (player in teammates) {
                player luinotifyevent(#"hash_6b67aa04e378d681", 1, 7);
            }
            util::function_a3f7de13(24, self.team);
        }
        if (level.deaths[self.team] >= var_65671d4a && !level.var_a236b703[self.team]) {
            level.var_a236b703[self.team] = 1;
            thread globallogic_audio::leader_dialog("controlLowLives", self.team);
            thread globallogic_audio::leader_dialog("controlLowLivesEnemy", enemy_team);
        }
        if (isdefined(level.var_9161927e) && isdefined(level.var_9161927e[self.team])) {
            if (level.var_9161927e[self.team] > 0) {
                teammates = function_a1ef346b(self.team);
                foreach (player in teammates) {
                    player luinotifyevent(#"hash_6b67aa04e378d681", 2, 1, level.var_9161927e[self.team]);
                }
            }
            if (level.var_9161927e[self.team] == 1) {
                thread globallogic_audio::leader_dialog("roundEncourageLastPlayer", self.team);
                thread globallogic_audio::leader_dialog("roundEncourageLastPlayerEnemy", enemy_team);
            }
            level.var_9161927e[self.team]--;
        }
        function_c49fc862(self.team);
        return;
    }
    clientfield::set_player_uimodel("hudItems.playerLivesCount", level.numlives - self.var_a7d7e50a);
    if (is_true(level.var_4348a050)) {
        var_e6caaa48 = level.playerlives[#"allies"];
        var_5724b72f = level.playerlives[#"axis"];
        if (level.gametype == "sd" && userspawnselection::function_127864f2(self)) {
            return;
        }
        if (var_e6caaa48 > 0 && var_5724b72f > 0) {
            foreach (player in function_a1ef346b()) {
                if (!isdefined(player)) {
                    continue;
                }
                player luinotifyevent(#"hash_6b67aa04e378d681", 3, 2, var_e6caaa48, var_5724b72f);
            }
        }
    }
}

// Namespace player/player_killed
// Params 1, eflags: 0x5 linked
// Checksum 0x734e71b, Offset: 0x7980
// Size: 0x46
function private function_5c5a8dad(lives) {
    if (lives == 0) {
        level notify(#"player_eliminated");
        self notify(#"player_eliminated");
    }
}

// Namespace player/player_killed
// Params 0, eflags: 0x5 linked
// Checksum 0x4abd620e, Offset: 0x79d0
// Size: 0x25c
function private start_generator_captureshouldshowpain() {
    if (!is_true(level.takelivesondeath)) {
        self function_5c5a8dad(self.pers[#"lives"]);
        return;
    }
    if (is_true(self.var_cee93f5)) {
        return;
    }
    if (game.lives[self.team] > 0) {
        if (is_true(level.competitiveteamlives)) {
        } else if (self.attackers.size < 1) {
            return;
        } else {
            foreach (attacker in self.attackers) {
                if (!isdefined(attacker)) {
                    continue;
                }
                if (attacker.team != self.team) {
                    removelives = 1;
                    break;
                }
            }
            if (!is_true(removelives)) {
                return;
            }
        }
        game.lives[self.team]--;
        if (self.pers[#"lives"] == 0) {
            self function_5c5a8dad(game.lives[self.team]);
        }
        return;
    }
    if (self.pers[#"lives"]) {
        self.pers[#"lives"]--;
        level callback::callback(#"hash_e702d557e24bb6", {#player:self});
        self function_5c5a8dad(self.pers[#"lives"]);
    }
}

// Namespace player/player_killed
// Params 4, eflags: 0x5 linked
// Checksum 0x9df554f, Offset: 0x7c38
// Size: 0x3e4
function private create_body(var_a2f12b49, vattackerorigin, deathanimduration, body) {
    if (var_a2f12b49.smeansofdeath == "MOD_HIT_BY_OBJECT" && self getstance() == "prone") {
        self.body = body;
        if (!isdefined(self.switching_teams)) {
            thread deathicons::add(body, self, self.team);
        }
        return;
    }
    if (isdefined(level.ragdoll_override) && self [[ level.ragdoll_override ]](var_a2f12b49.idamage, var_a2f12b49.smeansofdeath, var_a2f12b49.weapon, var_a2f12b49.shitloc, var_a2f12b49.vdir, vattackerorigin, deathanimduration, var_a2f12b49.einflictor, 0, body)) {
        return;
    }
    if (self isonladder() || self ismantling() || var_a2f12b49.smeansofdeath == "MOD_CRUSH" || var_a2f12b49.smeansofdeath == "MOD_HIT_BY_OBJECT") {
        body startragdoll();
    }
    if (!self isonground() && var_a2f12b49.smeansofdeath != "MOD_FALLING") {
        if (getdvarint(#"scr_disable_air_death_ragdoll", 0) == 0) {
            body startragdoll();
        }
    }
    if (var_a2f12b49.smeansofdeath == "MOD_MELEE_ASSASSINATE" && !var_a2f12b49.attacker isonground()) {
        body start_death_from_above_ragdoll(var_a2f12b49.vdir);
    }
    if (self is_explosive_ragdoll(var_a2f12b49.weapon, var_a2f12b49.einflictor)) {
        body start_explosive_ragdoll(var_a2f12b49.vdir, var_a2f12b49.weapon);
    }
    thread delayed_ragdoll(body, var_a2f12b49.shitloc, var_a2f12b49.vdir, var_a2f12b49.weapon, var_a2f12b49.einflictor, var_a2f12b49.smeansofdeath);
    if (var_a2f12b49.smeansofdeath == "MOD_CRUSH") {
        body globallogic_vehicle::vehiclecrush(var_a2f12b49.attacker, var_a2f12b49.einflictor);
    }
    hidedeathicon = isplayer(var_a2f12b49.attacker) && var_a2f12b49.attacker hasperk(#"hash_67340eb8c5d0f17f");
    self.body = body;
    if (!isdefined(self.switching_teams) && !hidedeathicon) {
        thread deathicons::add(body, self, self.team);
    }
    body.player = self;
    body.iscorpse = 1;
    self.body callback::callback(#"on_player_corpse", var_a2f12b49);
}

// Namespace player/player_killed
// Params 4, eflags: 0x5 linked
// Checksum 0x3e16a020, Offset: 0x8028
// Size: 0x8c
function private should_drop_weapon_on_death(wasteamkill, wassuicide, current_weapon, smeansofdeath) {
    if (wasteamkill) {
        return false;
    }
    if (wassuicide) {
        return false;
    }
    if (smeansofdeath == "MOD_TRIGGER_HURT" && !self isonground()) {
        return false;
    }
    if (isdefined(current_weapon) && current_weapon.isheavyweapon) {
        return false;
    }
    return true;
}

// Namespace player/player_killed
// Params 0, eflags: 0x5 linked
// Checksum 0x84db805d, Offset: 0x80c0
// Size: 0x28
function private function_8826f676() {
    if (isbot(self)) {
        level.globallarryskilled++;
    }
}

// Namespace player/player_killed
// Params 0, eflags: 0x5 linked
// Checksum 0xb686622, Offset: 0x80f0
// Size: 0x44
function private function_f9dc085a() {
    if (isdefined(self.killstreak_delay_killcam)) {
        while (isdefined(self.killstreak_delay_killcam)) {
            wait 0.1;
        }
        wait 2;
        self killstreaks::reset_killstreak_delay_killcam();
    }
}

// Namespace player/player_killed
// Params 0, eflags: 0x5 linked
// Checksum 0xf2dac931, Offset: 0x8140
// Size: 0x94
function private function_3c238bc5() {
    self globallogic_score::incpersstat(#"sessionbans", 1);
    self endon(#"disconnect");
    waittillframeend();
    globallogic::gamehistoryplayerkicked();
    ban(self getentitynumber());
    globallogic_audio::leader_dialog("gamePlayerKicked");
}

// Namespace player/player_killed
// Params 0, eflags: 0x5 linked
// Checksum 0xe0845d30, Offset: 0x81e0
// Size: 0x1f4
function private function_dd602974() {
    self globallogic_score::incpersstat(#"sessionbans", 1);
    self endon(#"disconnect");
    waittillframeend();
    playlistbanquantum = tweakables::gettweakablevalue("team", "teamkillerplaylistbanquantum");
    playlistbanpenalty = tweakables::gettweakablevalue("team", "teamkillerplaylistbanpenalty");
    if (playlistbanquantum > 0 && playlistbanpenalty > 0) {
        timeplayedtotal = self stats::get_stat_global(#"time_played_total");
        minutesplayed = timeplayedtotal / 60;
        freebees = 2;
        banallowance = int(floor(minutesplayed / playlistbanquantum)) + freebees;
        if (self globallogic_score::getpersstat(#"sessionbans") > banallowance) {
            self stats::set_stat_global(#"gametypeban", timeplayedtotal + playlistbanpenalty * 60);
        }
    }
    globallogic::gamehistoryplayerkicked();
    ban(self getentitynumber(), "EXE/PLAYERKICK_TEAM_KILL");
    globallogic_audio::leader_dialog("gamePlayerKicked");
}

// Namespace player/player_killed
// Params 0, eflags: 0x1 linked
// Checksum 0x619b3be8, Offset: 0x83e0
// Size: 0xe2
function function_821200bb() {
    teamkills = self.pers[#"teamkills_nostats"];
    if (level.friendlyfire == 4) {
        if (teamkills < level.var_fe3ff9c1) {
            return 0;
        } else {
            exceeded = teamkills - level.var_fe3ff9c1 - 1;
            return (level.var_ca1c5097 + level.var_2c3d094b * exceeded);
        }
        return;
    }
    if (level.minimumallowedteamkills < 0 || teamkills <= level.minimumallowedteamkills) {
        return 0;
    }
    exceeded = teamkills - level.minimumallowedteamkills;
    return level.teamkillspawndelay * exceeded;
}

// Namespace player/player_killed
// Params 1, eflags: 0x5 linked
// Checksum 0xa174ace5, Offset: 0x84d0
// Size: 0xdc
function private function_78a6af2d(var_821200bb) {
    if (isbot(self)) {
        return false;
    }
    if (level.friendlyfire == 4) {
        if (self.pers[#"teamkills_nostats"] >= level.var_fe3ff9c1 + level.var_3297fce5) {
            return true;
        }
        return false;
    }
    if (var_821200bb && level.minimumallowedteamkills >= 0) {
        if (globallogic_utils::gettimepassed() >= 5000) {
            return true;
        }
        if (self.pers[#"teamkills_nostats"] > 1) {
            return true;
        }
    }
    return false;
}

// Namespace player/player_killed
// Params 0, eflags: 0x1 linked
// Checksum 0x1a9b8dd8, Offset: 0x85b8
// Size: 0xf2
function function_a932bf9c() {
    if (level.friendlyfire == 4) {
        return;
    }
    timeperoneteamkillreduction = 20;
    reductionpersecond = 1 / timeperoneteamkillreduction;
    while (true) {
        if (isalive(self)) {
            self.pers[#"teamkills_nostats"] = self.pers[#"teamkills_nostats"] - reductionpersecond;
            if (self.pers[#"teamkills_nostats"] < level.minimumallowedteamkills) {
                self.pers[#"teamkills_nostats"] = level.minimumallowedteamkills;
                break;
            }
        }
        wait 1;
    }
}

// Namespace player/player_killed
// Params 3, eflags: 0x5 linked
// Checksum 0xb773f927, Offset: 0x86b8
// Size: 0xfe
function private ignore_team_kills(weapon, smeansofdeath, einflictor) {
    if (weapons::ismeleemod(smeansofdeath)) {
        return false;
    }
    if (weapon.ignore_team_kills === 1 || weapon.ignoreteamkills === 1) {
        return true;
    }
    if (isdefined(einflictor) && einflictor.ignore_team_kills === 1) {
        return true;
    }
    if (isdefined(einflictor) && isdefined(einflictor.destroyedby) && isdefined(einflictor.owner) && einflictor.destroyedby != einflictor.owner) {
        return true;
    }
    if (isdefined(einflictor) && einflictor.classname == "worldspawn") {
        return true;
    }
    return false;
}

// Namespace player/player_killed
// Params 2, eflags: 0x5 linked
// Checksum 0x31e54e83, Offset: 0x87c0
// Size: 0xb2
function private is_explosive_ragdoll(weapon, inflictor) {
    if (!isdefined(weapon)) {
        return false;
    }
    if (weapon.name == #"destructible_car" || weapon.name == #"explodable_barrel") {
        return true;
    }
    if (weapon.projexplosiontype == "grenade") {
        if (isdefined(inflictor) && isdefined(inflictor.stucktoplayer)) {
            if (inflictor.stucktoplayer == self) {
                return true;
            }
        }
    }
    return false;
}

// Namespace player/player_killed
// Params 2, eflags: 0x5 linked
// Checksum 0x411ec368, Offset: 0x8880
// Size: 0x1a4
function private start_explosive_ragdoll(dir, weapon) {
    if (!isdefined(self)) {
        return;
    }
    x = randomintrange(50, 100);
    y = randomintrange(50, 100);
    z = randomintrange(10, 20);
    if (isdefined(weapon) && (weapon.name == #"sticky_grenade" || weapon.name == #"explosive_bolt")) {
        if (isdefined(dir) && lengthsquared(dir) > 0) {
            x = dir[0] * x;
            y = dir[1] * y;
        }
    } else {
        if (math::cointoss()) {
            x *= -1;
        }
        if (math::cointoss()) {
            y *= -1;
        }
    }
    self startragdoll();
    self launchragdoll((x, y, z));
}

// Namespace player/player_killed
// Params 1, eflags: 0x5 linked
// Checksum 0x3892d52b, Offset: 0x8a30
// Size: 0x4c
function private start_death_from_above_ragdoll(*dir) {
    if (!isdefined(self)) {
        return;
    }
    self startragdoll();
    self launchragdoll((0, 0, -100));
}

// Namespace player/player_killed
// Params 6, eflags: 0x5 linked
// Checksum 0xa68c047e, Offset: 0x8a88
// Size: 0x1fc
function private delayed_ragdoll(ent, *shitloc, *vdir, *weapon, *einflictor, *smeansofdeath) {
    if (isdefined(smeansofdeath)) {
        if (is_true(smeansofdeath.var_6f9e9dc9)) {
            if (!smeansofdeath isragdoll()) {
                smeansofdeath startragdoll();
            }
            return;
        }
        deathanim = smeansofdeath getcorpseanim();
        if (isdefined(deathanim) && animhasnotetrack(deathanim, "ignore_ragdoll")) {
            return;
        }
    }
    waittillframeend();
    if (!isdefined(smeansofdeath)) {
        return;
    }
    if (smeansofdeath isragdoll()) {
        return;
    }
    deathanim = smeansofdeath getcorpseanim();
    if (isdefined(deathanim) && animhasnotetrack(deathanim, "ignore_ragdoll")) {
        return;
    }
    startfrac = 0.35;
    if (animhasnotetrack(deathanim, "start_ragdoll")) {
        times = getnotetracktimes(deathanim, "start_ragdoll");
        if (isdefined(times)) {
            startfrac = times[0];
        }
    }
    waittime = startfrac * getanimlength(deathanim);
    if (waittime > 0) {
        wait waittime;
    }
    if (isdefined(smeansofdeath)) {
        smeansofdeath startragdoll();
    }
}

// Namespace player/player_killed
// Params 2, eflags: 0x5 linked
// Checksum 0x3be9249c, Offset: 0x8c90
// Size: 0x364
function private update_attacker(attacker, weapon) {
    if (isai(attacker) && isdefined(attacker.script_owner)) {
        if (!level.teambased || self util::isenemyteam(attacker.script_owner.team)) {
            attacker = attacker.script_owner;
        }
    }
    if (attacker.classname == "script_vehicle" && isdefined(attacker.owner)) {
        attacker notify(#"killed", {#victim:self});
        attacker = attacker.owner;
    }
    if (isai(attacker)) {
        attacker notify(#"killed", {#victim:self});
    }
    if (isdefined(self.capturinglastflag) && self.capturinglastflag == 1) {
        attacker.lastcapkiller = 1;
    }
    if (isdefined(attacker) && attacker != self && isdefined(weapon)) {
        if (weapon.statname == #"planemortar") {
            if (!isdefined(attacker.planemortarbda)) {
                attacker.planemortarbda = 0;
            }
            attacker.planemortarbda++;
        } else if (weapon.statname == #"dart" || weapon.statname == #"dart_turret") {
            if (!isdefined(attacker.dartbda)) {
                attacker.dartbda = 0;
            }
            attacker.dartbda++;
        } else if (weapon.name == #"straferun_rockets" || weapon.name == #"straferun_gun") {
            if (isdefined(attacker.straferunbda)) {
                attacker.straferunbda++;
            }
        } else if (weapon.statname == #"remote_missile" || weapon.statname == #"remote_missile_missile" || weapon.name == #"remote_missile_bomblet") {
            if (!isdefined(attacker.remotemissilebda)) {
                attacker.remotemissilebda = 0;
            }
            attacker.remotemissilebda++;
        }
    }
    if (isdefined(attacker) && isplayer(attacker) && isdefined(self.clientid)) {
        if (!isdefined(attacker.damagedplayers)) {
            attacker.damagedplayers = [];
        }
        attacker.damagedplayers[self.clientid] = undefined;
    }
    return attacker;
}

// Namespace player/player_killed
// Params 1, eflags: 0x5 linked
// Checksum 0xc431890, Offset: 0x9000
// Size: 0x74
function private function_813829e3(einflictor) {
    if (isdefined(einflictor) && einflictor.classname == "script_vehicle") {
        einflictor notify(#"killed", {#victim:self});
        if (isdefined(einflictor.bda)) {
            einflictor.bda++;
        }
    }
}

// Namespace player/player_killed
// Params 2, eflags: 0x5 linked
// Checksum 0x8334cc85, Offset: 0x9080
// Size: 0xe2
function private update_weapon(einflictor, weapon) {
    if (weapon == level.weaponnone && isdefined(einflictor)) {
        if (isdefined(einflictor.targetname) && einflictor.targetname == "explodable_barrel") {
            weapon = getweapon(#"explodable_barrel");
        } else if (isdefined(einflictor.destructible_type) && issubstr(einflictor.destructible_type, "vehicle_")) {
            weapon = getweapon(#"destructible_car");
        }
    }
    return weapon;
}

// Namespace player/player_killed
// Params 5, eflags: 0x5 linked
// Checksum 0xd46bff6, Offset: 0x9170
// Size: 0xf0
function private function_e8decd0b(attacker, weapon, victim, einflictor, smeansofdeath) {
    if (isplayer(attacker)) {
        if (!killstreaks::is_killstreak_weapon(weapon) || killstreaks::function_e3a30c69(weapon)) {
            level thread battlechatter::playkillbattlechatter(attacker, weapon, victim, einflictor, smeansofdeath);
        }
    }
    if (isdefined(einflictor)) {
        bhtnactionstartevent(einflictor, "attack_kill");
        einflictor notify(#"bhtn_action_notify", {#action:"attack_kill"});
    }
}

// Namespace player/player_killed
// Params 3, eflags: 0x1 linked
// Checksum 0x12ad8e14, Offset: 0x9268
// Size: 0x576
function updatekillstreak(einflictor, attacker, weapon) {
    if (isalive(attacker)) {
        pixbeginevent(#"killstreak");
        if (!isdefined(einflictor) || !isdefined(einflictor.requireddeathcount) || attacker.deathcount == einflictor.requireddeathcount) {
            shouldgivekillstreak = killstreaks::should_give_killstreak(weapon);
            shouldgivekillstreak &= !attacker isinvehicle();
            if (shouldgivekillstreak) {
                attacker killstreaks::add_to_killstreak_count(weapon);
            }
            attacker.pers[#"cur_total_kill_streak"]++;
            attacker setplayercurrentstreak(attacker.pers[#"cur_total_kill_streak"]);
            if (isdefined(level.killstreaks) && shouldgivekillstreak) {
                attacker.pers[#"cur_kill_streak"]++;
                if (attacker.pers[#"cur_kill_streak"] >= 2) {
                    if (attacker.pers[#"cur_kill_streak"] % 5 == 0) {
                        attacker activecamo::function_896ac347(weapon, #"killstreak_5", 1);
                        attacker contracts::increment_contract(#"hash_4c15367eed618401");
                        attacker contracts::increment_contract(#"contract_wl_kills_without_dying");
                    }
                    if (attacker.pers[#"cur_kill_streak"] % 10 == 0) {
                        attacker challenges::killstreakten();
                        attacker contracts::increment_contract(#"contract_mp_merciless");
                    }
                    if (attacker.pers[#"cur_kill_streak"] <= 30) {
                        scoreevents::processscoreevent(#"killstreak_" + attacker.pers[#"cur_kill_streak"], attacker, self, weapon);
                        if (attacker.pers[#"cur_kill_streak"] == 30) {
                            attacker challenges::killstreak_30_noscorestreaks();
                        }
                    } else {
                        scoreevents::processscoreevent(#"killstreak_more_than_30", attacker, self, weapon);
                    }
                    if (isdefined(attacker.var_ea1458aa)) {
                        if (attacker.pers[#"cur_kill_streak"] >= 5 && attacker.pers[#"cur_kill_streak"] % 5 && attacker.pers[#"cur_kill_streak"] < 30 || attacker.pers[#"cur_kill_streak"] > 30) {
                            if (!isdefined(attacker.var_ea1458aa.var_2bad4cbb)) {
                                attacker.var_ea1458aa.var_2bad4cbb = 0;
                            }
                            attacker.var_ea1458aa.var_2bad4cbb++;
                            attacker challenges::function_a4db0a4c();
                        }
                    }
                }
                if (!isdefined(level.usingmomentum) || !level.usingmomentum) {
                    attacker thread killstreaks::give_for_streak();
                }
            }
        }
        pixendevent();
    }
    if (isdefined(attacker.gametype_kill_streak) && attacker.pers[#"cur_kill_streak"] > attacker.gametype_kill_streak) {
        attacker stats::function_baa25a23(#"kill_streak", attacker.pers[#"cur_kill_streak"]);
        attacker.gametype_kill_streak = attacker.pers[#"cur_kill_streak"];
    }
    if (isdefined(attacker.var_b6f732c0) && attacker.pers[#"cur_kill_streak"] > attacker.var_b6f732c0) {
        attacker stats::set_stat_global(#"longest_killstreak", attacker.pers[#"cur_kill_streak"]);
        attacker.var_b6f732c0 = attacker.pers[#"cur_kill_streak"];
    }
}

// Namespace player/player_killed
// Params 9, eflags: 0x1 linked
// Checksum 0xd69465b5, Offset: 0x97e8
// Size: 0x11e
function function_ff3ec0d4(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    foreach (callback in level.var_da2045d0) {
        if (callback.threaded) {
            self thread [[ callback.callback ]](einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
            continue;
        }
        profilestart();
        self [[ callback.callback ]](einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
        profilestop();
    }
}

// Namespace player/player_killed
// Params 4, eflags: 0x1 linked
// Checksum 0xd18e7d3a, Offset: 0x9910
// Size: 0xe6
function function_b8871aa2(einflictor, victim, idamage, weapon) {
    foreach (callback in level.var_fa66fada) {
        if (callback.threaded) {
            self thread [[ callback.callback ]](einflictor, victim, idamage, weapon);
            continue;
        }
        profilestart();
        self [[ callback.callback ]](einflictor, victim, idamage, weapon);
        profilestop();
    }
}

