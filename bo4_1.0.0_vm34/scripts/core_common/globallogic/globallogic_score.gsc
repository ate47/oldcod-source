#using scripts\core_common\callbacks_shared;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\rank_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\weapons_shared;

#namespace globallogic_score;

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x2
// Checksum 0x64d3d177, Offset: 0x150
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"globallogic_score", &__init__, undefined, undefined);
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x0
// Checksum 0x63571606, Offset: 0x198
// Size: 0x9c
function __init__() {
    callback::on_start_gametype(&init);
    callback::on_spawned(&playerspawn);
    /#
        setdvar(#"logscoreevents", 0);
        setdvar(#"dumpscoreevents", 0);
        thread function_b77e6c5();
    #/
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x0
// Checksum 0x96951a6a, Offset: 0x240
// Size: 0x56
function init() {
    level.var_cb586a = [];
    registerscoreeventcallback("playerKilled", &function_d1a5a31e);
    level.capturedobjectivefunction = &function_f63c6ccc;
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x0
// Checksum 0xe8a61e27, Offset: 0x2a0
// Size: 0x84
function playerspawn() {
    self.var_8de4e781 = 0;
    self.var_4d31b505 = 0;
    self.var_88e777dd = 0;
    self callback::on_weapon_change(&on_weapon_change);
    self callback::on_weapon_fired(&on_weapon_fired);
    self callback::on_grenade_fired(&on_grenade_fired);
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x4
// Checksum 0x792dd167, Offset: 0x330
// Size: 0x22
function private on_weapon_change(params) {
    self.var_4d31b505 = 0;
    self.var_88e777dd = 0;
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x4
// Checksum 0xee7af0e9, Offset: 0x360
// Size: 0x2c
function private on_weapon_fired(params) {
    self function_1d5777b3(params.weapon);
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x4
// Checksum 0xce1d597f, Offset: 0x398
// Size: 0xd4
function private function_d5a9ab4b(projectile, weapon) {
    self endon(#"disconnect");
    level endon(#"game_ended");
    scoreevents = function_c8e9dad8(weapon.var_980d2212);
    if (!isdefined(scoreevents.var_c3674108)) {
        return;
    }
    var_4d78dc3b = projectile waittilltimeout(10, #"death");
    if (var_4d78dc3b._notify != "timeout") {
        scoreevents::processscoreevent(scoreevents.var_c3674108, self, undefined, weapon);
    }
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x4
// Checksum 0xd7189796, Offset: 0x478
// Size: 0x7c
function private on_grenade_fired(params) {
    weapon = params.weapon;
    if (!isdefined(weapon) || !isdefined(weapon.var_980d2212)) {
        return;
    }
    self function_1d5777b3(weapon);
    self thread function_d5a9ab4b(params.projectile, weapon);
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0x2bf83459, Offset: 0x500
// Size: 0x8c
function function_1d5777b3(weapon) {
    if (isdefined(weapon) && isdefined(weapon.var_980d2212)) {
        scoreevents = function_c8e9dad8(weapon.var_980d2212);
    }
    if (!isdefined(scoreevents)) {
        return;
    }
    if (isdefined(scoreevents.var_84a89d4f)) {
        scoreevents::processscoreevent(scoreevents.var_84a89d4f, self, undefined, weapon);
    }
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xfbe53a89, Offset: 0x598
// Size: 0x50
function inctotalkills(team) {
    if (level.teambased && isdefined(level.teams[team])) {
        game.totalkillsteam[team]++;
    }
    game.totalkills++;
}

// Namespace globallogic_score/globallogic_score
// Params 3, eflags: 0x0
// Checksum 0x7e37d808, Offset: 0x5f0
// Size: 0x48
function givekillstats(smeansofdeath, weapon, evictim) {
    if (isdefined(level.scoreevents_givekillstats)) {
        [[ level.scoreevents_givekillstats ]](smeansofdeath, weapon, evictim);
    }
}

// Namespace globallogic_score/globallogic_score
// Params 6, eflags: 0x0
// Checksum 0x279c9045, Offset: 0x640
// Size: 0xdc
function function_10fac0c5(event, var_d0f70a32, weapon, attacker, victim, var_d0953629) {
    if (!isdefined(var_d0f70a32)) {
        return 0;
    }
    if (!isdefined(attacker.var_b58efbe8)) {
        attacker.var_b58efbe8 = [];
    }
    attacker.var_b58efbe8[event] = (isdefined(attacker.var_b58efbe8[event]) ? attacker.var_b58efbe8[event] : 0) + 1;
    if (isdefined(var_d0953629) && var_d0953629) {
        scoreevents::processscoreevent(event, attacker, victim, weapon);
    }
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x0
// Checksum 0xe28b78a3, Offset: 0x728
// Size: 0xd8
function function_e0e7bfe2(var_d0f70a32, weapon) {
    if (!isdefined(var_d0f70a32)) {
        return false;
    }
    scoreevents = function_c8e9dad8(var_d0f70a32.var_980d2212);
    if (!isdefined(scoreevents) || !isdefined(scoreevents.var_c201b233)) {
        return false;
    }
    scoreevents::processscoreevent(scoreevents.var_c201b233, self, undefined, weapon);
    if (rank::function_9f61ba96(scoreevents.var_c201b233)) {
        function_10fac0c5(scoreevents.var_c201b233, var_d0f70a32, weapon, self, undefined, 0);
    }
    return true;
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0x82354465, Offset: 0x808
// Size: 0xee
function function_4a898ea3(event) {
    if (!isdefined(level.scoreinfo[event])) {
        println("<dev string:x30>" + event);
        return 0;
    }
    if (!isdefined(self.var_b58efbe8)) {
        self.var_b58efbe8 = [];
    }
    if (!isdefined(self.var_b58efbe8[event]) || self.var_b58efbe8[event] <= 0) {
        return;
    }
    eventindex = level.scoreinfo[event][#"row"];
    self luinotifyevent(#"end_sustaining_action", 1, eventindex);
    self.var_b58efbe8[event]--;
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x0
// Checksum 0x93969dae, Offset: 0x900
// Size: 0x84
function function_be88174b(var_d0f70a32, weapon) {
    if (!isdefined(var_d0f70a32)) {
        return 0;
    }
    scoreevents = function_c8e9dad8(var_d0f70a32.var_980d2212);
    if (!isdefined(scoreevents) || !isdefined(scoreevents.var_c201b233)) {
        return 0;
    }
    function_4a898ea3(scoreevents.var_c201b233);
}

// Namespace globallogic_score/globallogic_score
// Params 6, eflags: 0x0
// Checksum 0x639b41a6, Offset: 0x990
// Size: 0x1f0
function processassist(killedplayer, damagedone, weapon, assist_level = undefined, time = gettime(), meansofdeath = "MOD_UNKNOWN") {
    waitframe(1);
    util::waittillslowprocessallowed();
    if (!isdefined(self) || !isdefined(killedplayer) || !isplayer(self) || !isplayer(killedplayer) || !isdefined(weapon)) {
        return;
    }
    if (isarray(level.specweapons)) {
        foreach (var_bdf00e5c in level.specweapons) {
            self function_ac70ea36(killedplayer, var_bdf00e5c.weapon, weapon, var_bdf00e5c, time, meansofdeath);
        }
    }
    self function_ac70ea36(killedplayer, weapon, weapon, undefined, time, meansofdeath);
    if (isdefined(level.scoreevents_processassist) && !level.var_3867395b) {
        self [[ level.scoreevents_processassist ]](killedplayer, damagedone, weapon, assist_level);
    }
}

// Namespace globallogic_score/globallogic_score
// Params 6, eflags: 0x4
// Checksum 0xd41a1e99, Offset: 0xb88
// Size: 0x1f4
function private function_ac70ea36(victim, weapon, attackerweapon, var_96ad51b1, time, meansofdeath) {
    scoreevents = function_c8e9dad8(weapon.var_980d2212);
    if ((isdefined(victim.var_8de4e781) ? victim.var_8de4e781 : 0) && isdefined(scoreevents) && isdefined(scoreevents.var_70924b34)) {
        if (isdefined(var_96ad51b1)) {
            if (!isdefined(var_96ad51b1.var_9bc836c1) || ![[ var_96ad51b1.var_9bc836c1 ]](self, victim, weapon, attackerweapon)) {
                return;
            }
        }
        self function_e6909d2b(weapon);
        self.multikills[weapon.name].objectivekills++;
        if (isdefined(scoreevents) && isdefined(scoreevents.var_70924b34)) {
            scoreevents::processscoreevent(scoreevents.var_70924b34, self, victim, weapon);
        }
    } else {
        if (isdefined(var_96ad51b1)) {
            if (!isdefined(var_96ad51b1.kill_callback) || ![[ var_96ad51b1.kill_callback ]](self, victim, weapon, attackerweapon, meansofdeath)) {
                return;
            }
        }
        if (isdefined(scoreevents) && isdefined(scoreevents.var_13a154a6)) {
            scoreevents::processscoreevent(scoreevents.var_13a154a6, self, victim, weapon);
        }
    }
    self function_9192be68(weapon, scoreevents);
}

// Namespace globallogic_score/globallogic_score
// Params 3, eflags: 0x0
// Checksum 0x74cb711e, Offset: 0xd88
// Size: 0x214
function function_a63adb85(attacker, weapon, var_b9b9d291) {
    if (!isdefined(self) || !isdefined(var_b9b9d291) || !isdefined(weapon) || !isdefined(attacker) || !isplayer(attacker)) {
        return;
    }
    if (isdefined(level.iskillstreakweapon)) {
        if ([[ level.iskillstreakweapon ]](weapon) || isdefined(weapon.statname) && [[ level.iskillstreakweapon ]](getweapon(weapon.statname))) {
            weaponiskillstreak = 1;
        }
        if ([[ level.iskillstreakweapon ]](var_b9b9d291)) {
            destroyedkillstreak = 1;
        }
    }
    var_454b790f = function_c8e9dad8(var_b9b9d291.var_980d2212);
    if ((!(isdefined(weaponiskillstreak) && weaponiskillstreak) || isdefined(destroyedkillstreak) && destroyedkillstreak) && isdefined(var_454b790f) && isdefined(var_454b790f.var_c15c218c)) {
        scoreevents::processscoreevent(var_454b790f.var_c15c218c, attacker, self, var_b9b9d291);
        attacker stats::function_b48aa4e(#"stats_destructions", 1);
    }
    scoreevents = function_c8e9dad8(weapon.var_980d2212);
    if (isdefined(scoreevents) && isdefined(scoreevents.var_12843605)) {
        scoreevents::processscoreevent(scoreevents.var_12843605, attacker, self, weapon);
    }
}

// Namespace globallogic_score/globallogic_score
// Params 6, eflags: 0x0
// Checksum 0x9744a365, Offset: 0xfa8
// Size: 0x284
function function_8dd85fe(attacker, owningteam, weapon, scoreevents, objectiveobj, var_5a319138) {
    attacker function_e6909d2b(weapon);
    attacker.multikills[weapon.name].objectivekills++;
    if (level.teambased && isdefined(owningteam) && attacker.team == owningteam) {
        if (isdefined(level.specweapons) && isdefined(level.specweapons[weapon.name]) && isdefined(level.specweapons[weapon.name].var_929151ca)) {
            [[ level.specweapons[weapon.name].var_929151ca ]](attacker, self, weapon, objectiveobj);
        }
        if (isdefined(scoreevents) && isdefined(scoreevents.var_d0b367bf)) {
            scoreevents::processscoreevent(scoreevents.var_d0b367bf, attacker, self, weapon);
        }
        if ((isdefined(attacker.multikills[weapon.name].objectivekills) ? attacker.multikills[weapon.name].objectivekills : 0) > 2 && (isdefined(objectiveobj.var_dfbf048e) ? objectiveobj.var_dfbf048e : 0) < gettime()) {
            enemies = attacker getenemiesinradius(objectiveobj.origin, var_5a319138);
            if (enemies.size == 0) {
                objectiveobj.var_dfbf048e = gettime() + 4000;
                attacker.multikills[weapon.name].var_6d7a4ed1 = 1;
            }
        }
    }
    if (isdefined(scoreevents) && isdefined(scoreevents.var_21b74e29)) {
        scoreevents::processscoreevent(scoreevents.var_21b74e29, attacker, self, weapon);
    }
}

// Namespace globallogic_score/globallogic_score
// Params 7, eflags: 0x0
// Checksum 0x8e3211fe, Offset: 0x1238
// Size: 0x328
function function_93736d46(einflictor, attacker, weapon, objectiveobj, var_5a319138, owningteam, var_bd20bf9e) {
    attacker endon(#"disconnect", #"death");
    level endon(#"game_ended");
    self notify("666ff07fc0bc04a4");
    self endon("666ff07fc0bc04a4");
    if (!isplayer(attacker) || !isplayer(self) || !isdefined(weapon) || !isdefined(objectiveobj) || !isdefined(var_bd20bf9e) || !isdefined(var_5a319138)) {
        return;
    }
    if (!self istouching(var_bd20bf9e, (var_5a319138, var_5a319138, 100))) {
        if (!isdefined(einflictor) || einflictor != attacker || !attacker istouching(var_bd20bf9e, (var_5a319138, var_5a319138, 100))) {
            return;
        }
    }
    self.var_8de4e781 = 1;
    attacker.var_47b8986a = weapon;
    attacker.var_fffcbcb5 = gettime();
    attacker.var_3d36d801 = objectiveobj;
    scoreevents = function_c8e9dad8(weapon.var_980d2212);
    self function_8dd85fe(attacker, owningteam, weapon, scoreevents, objectiveobj, var_5a319138);
    if (isarray(level.specweapons)) {
        foreach (var_bdf00e5c in level.specweapons) {
            if (!isdefined(var_bdf00e5c.var_9bc836c1) || ![[ var_bdf00e5c.var_9bc836c1 ]](attacker, self, var_bdf00e5c.weapon, weapon)) {
                continue;
            }
            var_a8118bb9 = function_c8e9dad8(var_bdf00e5c.weapon.var_980d2212);
            self function_8dd85fe(attacker, owningteam, var_bdf00e5c.weapon, var_a8118bb9, objectiveobj, var_5a319138);
        }
    }
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x4
// Checksum 0xdd783ef4, Offset: 0x1568
// Size: 0x1e4
function private function_f63c6ccc(objective, var_37a77878) {
    if (!isdefined(objective) || !isdefined(var_37a77878) || !isdefined(self) || !isdefined(self.var_47b8986a) || !isdefined(self.var_fffcbcb5) || !isdefined(self.var_3d36d801)) {
        return;
    }
    if (var_37a77878 - self.var_fffcbcb5 > int(20 * 1000) || objective != self.var_3d36d801) {
        return;
    }
    if (isarray(level.specweapons)) {
        foreach (specialweapon in level.specweapons) {
            if (isdefined(specialweapon.var_e1814239)) {
                [[ specialweapon.var_e1814239 ]](self, self.var_47b8986a, self.var_fffcbcb5, self.var_3d36d801, specialweapon.weapon);
            }
        }
    }
    scoreevents = function_c8e9dad8(self.var_47b8986a.var_980d2212);
    if (isdefined(scoreevents) && isdefined(scoreevents.var_2bf46ebd)) {
        scoreevents::processscoreevent(scoreevents.var_2bf46ebd, self, undefined, self.var_47b8986a);
    }
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x0
// Checksum 0x74591b11, Offset: 0x1758
// Size: 0x84
function registerscoreeventcallback(callback, func) {
    if (!isdefined(level.scoreeventcallbacks)) {
        level.scoreeventcallbacks = [];
    }
    if (!isdefined(level.scoreeventcallbacks[callback])) {
        level.scoreeventcallbacks[callback] = [];
    }
    level.scoreeventcallbacks[callback][level.scoreeventcallbacks[callback].size] = func;
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xb2bc76d9, Offset: 0x17e8
// Size: 0x5c
function function_c8e9dad8(scriptbundle) {
    if (!isdefined(scriptbundle)) {
        return;
    }
    if (!isdefined(level.var_cb586a[scriptbundle])) {
        level.var_cb586a[scriptbundle] = getscriptbundle(scriptbundle);
    }
    return level.var_cb586a[scriptbundle];
}

// Namespace globallogic_score/globallogic_score
// Params 7, eflags: 0x0
// Checksum 0x69fafca6, Offset: 0x1850
// Size: 0x4c0
function function_54207c82(inflictor, meansofdeath, victim, attacker, weapon, var_b1079a1b, time) {
    if (!isdefined(var_b1079a1b) || !isarray(var_b1079a1b)) {
        return;
    }
    waitframe(1);
    util::waittillslowprocessallowed();
    if (!isdefined(victim)) {
        return;
    }
    foreach (effect in var_b1079a1b) {
        if (!isdefined(effect) || !isdefined(effect.var_85e878ff) || victim == effect.var_85e878ff) {
            continue;
        }
        scoreevents = function_c8e9dad8(effect.var_980d2212);
        if (!isdefined(scoreevents)) {
            continue;
        }
        if ((isdefined(victim.var_8de4e781) ? victim.var_8de4e781 : 0) && (isdefined(scoreevents.var_70924b34) || isdefined(scoreevents.var_21b74e29))) {
            attacker function_e6909d2b(effect);
            attacker.multikills[effect.name].objectivekills++;
            if (isdefined(effect.var_85e878ff) && isplayer(effect.var_85e878ff) && attacker != effect.var_85e878ff) {
                if (isdefined(scoreevents.var_70924b34)) {
                    scoreevents::processscoreevent(scoreevents.var_70924b34, effect.var_85e878ff, victim, effect.var_ed5f2f94);
                }
            } else if (isdefined(scoreevents.var_21b74e29)) {
                scoreevents::processscoreevent(scoreevents.var_21b74e29, effect.var_85e878ff, victim, effect.var_ed5f2f94);
            }
        } else if (isdefined(effect.var_85e878ff) && isplayer(effect.var_85e878ff) && attacker != effect.var_85e878ff) {
            baseweapon = weapons::getbaseweapon(weapon);
            if (isdefined(scoreevents.var_8a9a897) && (isdefined(baseweapon.issignatureweapon) && baseweapon.issignatureweapon || isdefined(baseweapon.var_ee15463f) && baseweapon.var_ee15463f)) {
                scoreevents::processscoreevent(scoreevents.var_8a9a897, effect.var_85e878ff, victim, effect.var_ed5f2f94);
            } else if (isdefined(scoreevents.var_13a154a6)) {
                scoreevents::processscoreevent(scoreevents.var_13a154a6, effect.var_85e878ff, victim, effect.var_ed5f2f94);
            }
        }
        if (attacker == effect.var_85e878ff) {
            if (isdefined(level.var_23f5efd4) && isdefined(level.var_23f5efd4[effect.name]) && isdefined(level.var_23f5efd4[effect.name].kill_callback)) {
                if (![[ level.var_23f5efd4[effect.name].kill_callback ]](self, victim, effect.var_ed5f2f94, weapon, meansofdeath)) {
                    return;
                }
            }
            updatemultikill(inflictor, meansofdeath, victim, attacker, scoreevents, effect.var_ed5f2f94, weapon, effect, time);
        }
    }
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xdc77a946, Offset: 0x1d18
// Size: 0x42c
function function_d1a5a31e(data) {
    inflictor = data.einflictor;
    victim = data.victim;
    attacker = data.attacker;
    meansofdeath = data.smeansofdeath;
    if (!isplayer(attacker)) {
        return;
    }
    time = data.time;
    if (!isdefined(time)) {
        time = gettime();
    }
    weapon = level.weaponnone;
    if (isdefined(data.weapon)) {
        weapon = data.weapon;
    }
    if (isarray(level.specweapons)) {
        foreach (var_bdf00e5c in level.specweapons) {
            if (isdefined(var_bdf00e5c.kill_callback)) {
                specweapon = var_bdf00e5c.weapon;
                var_db6344dd = function_c8e9dad8(specweapon.var_980d2212);
                attacker updatemultikill(inflictor, meansofdeath, victim, attacker, var_db6344dd, specweapon, weapon, specweapon, time);
            }
        }
    }
    attacker thread function_54207c82(inflictor, meansofdeath, victim, attacker, weapon, data.var_b1079a1b, time);
    if (isdefined(victim.currentweapon)) {
        var_bf4b192 = function_c8e9dad8(victim.currentweapon.var_980d2212);
    }
    if (!isdefined(var_bf4b192) && isdefined(victim.heroability) && isdefined(victim.heroabilityactivatetime) && victim.heroabilityactivatetime + 700 > time) {
        var_bf4b192 = function_c8e9dad8(victim.heroability.var_980d2212);
    }
    if (isdefined(weapon) && isdefined(level.iskillstreakweapon)) {
        if ([[ level.iskillstreakweapon ]](weapon) || isdefined(weapon.statname) && [[ level.iskillstreakweapon ]](getweapon(weapon.statname))) {
            weaponiskillstreak = 1;
        }
    }
    if (isdefined(var_bf4b192) && isdefined(var_bf4b192.var_c15c218c) && !(isdefined(weaponiskillstreak) && weaponiskillstreak)) {
        scoreevents::processscoreevent(var_bf4b192.var_c15c218c, attacker, victim, victim.currentweapon);
        attacker stats::function_b48aa4e(#"stats_shutdowns", 1);
    }
    baseweapon = weapons::getbaseweapon(weapon);
    attacker updatemultikill(inflictor, meansofdeath, victim, attacker, function_c8e9dad8(weapon.var_980d2212), weapon, weapon, baseweapon, time);
}

// Namespace globallogic_score/globallogic_score
// Params 8, eflags: 0x4
// Checksum 0xe6bcf18, Offset: 0x2150
// Size: 0x6e6
function private function_112aef0a(inflictor, meansofdeath, victim, attacker, scoreevents, weapon, var_ff40eac7, time) {
    level endon(#"game_ended");
    attacker notify(var_ff40eac7.name + "MultiKillScore");
    attacker endon(var_ff40eac7.name + "MultiKillScore", #"disconnect");
    if (inflictor.var_4d31b505 >= 3 && !(isdefined(inflictor.var_88e777dd) ? inflictor.var_88e777dd : 0)) {
        if (isdefined(scoreevents) && isdefined(scoreevents.var_d465dce1)) {
            scoreevents::processscoreevent(scoreevents.var_d465dce1, attacker, undefined, weapon);
        }
        inflictor.var_88e777dd = 1;
    }
    if (!isdefined(attacker.multikills) || !isdefined(attacker.multikills[var_ff40eac7.name])) {
        return;
    }
    waitresult = attacker waittilltimeout(4, #"death", #"team_changed");
    if (isdefined(scoreevents)) {
        switch (isdefined(attacker.multikills[var_ff40eac7.name].kills) ? attacker.multikills[var_ff40eac7.name].kills : 0) {
        case 0:
        case 1:
            break;
        case 2:
            if (isdefined(scoreevents.var_d5190bc)) {
                scoreevents::processscoreevent(scoreevents.var_d5190bc, attacker, victim, weapon);
            }
            break;
        case 3:
            if (isdefined(scoreevents.var_144f0a79)) {
                scoreevents::processscoreevent(scoreevents.var_144f0a79, attacker, victim, weapon);
            }
            break;
        case 4:
            if (isdefined(scoreevents.var_12f9619e)) {
                scoreevents::processscoreevent(scoreevents.var_12f9619e, attacker, victim, weapon);
            }
            break;
        case 5:
            if (isdefined(scoreevents.var_17acbb0b)) {
                scoreevents::processscoreevent(scoreevents.var_17acbb0b, attacker, victim, weapon);
            }
            break;
        default:
            if (attacker.multikills[var_ff40eac7.name].kills > 5 && isdefined(scoreevents.var_a34c0bb8)) {
                scoreevents::processscoreevent(scoreevents.var_a34c0bb8, attacker, victim, weapon);
            }
            break;
        }
        if ((isdefined(attacker.multikills[var_ff40eac7.name].kills) ? attacker.multikills[var_ff40eac7.name].kills : 0) >= 2) {
            attacker specialistmedalachievement(weapon, scoreevents);
        }
    }
    attacker.multikills[var_ff40eac7.name].kills = 0;
    switch (isdefined(attacker.multikills[var_ff40eac7.name].objectivekills) ? attacker.multikills[var_ff40eac7.name].objectivekills : 0) {
    case 0:
    case 1:
    case 2:
        break;
    default:
        if (attacker.multikills[var_ff40eac7.name].objectivekills > 2) {
            if (isdefined(scoreevents) && isdefined(scoreevents.var_726f5fac)) {
                scoreevents::processscoreevent(scoreevents.var_726f5fac, attacker, undefined, weapon);
            }
            if (isdefined(attacker.multikills[var_ff40eac7.name].var_6d7a4ed1) ? attacker.multikills[var_ff40eac7.name].var_6d7a4ed1 : 0) {
                if (isdefined(scoreevents) && isdefined(scoreevents.var_bef756d8)) {
                    scoreevents::processscoreevent(scoreevents.var_bef756d8, attacker, undefined, weapon);
                    attacker.multikills[var_ff40eac7.name].var_6d7a4ed1 = 0;
                }
                if (isarray(level.specweapons)) {
                    foreach (var_bdf00e5c in level.specweapons) {
                        if (isdefined(var_bdf00e5c.var_fdf27be7)) {
                            [[ var_bdf00e5c.var_fdf27be7 ]](attacker, time, weapon, var_bdf00e5c.weapon);
                        }
                    }
                }
            }
        }
        break;
    }
    attacker.multikills[var_ff40eac7.name].objectivekills = 0;
}

// Namespace globallogic_score/globallogic_score
// Params 9, eflags: 0x4
// Checksum 0xa68868fb, Offset: 0x2840
// Size: 0x554
function private updatemultikill(inflictor, meansofdeath, victim, attacker, scoreevents, weapon, attackerweapon, var_ff40eac7, time) {
    self function_e6909d2b(var_ff40eac7);
    if (!isdefined(inflictor)) {
        inflictor = attacker;
    }
    if (isdefined(level.specweapons) && isdefined(level.specweapons[var_ff40eac7.name]) && isdefined(level.specweapons[var_ff40eac7.name].kill_callback)) {
        if (![[ level.specweapons[var_ff40eac7.name].kill_callback ]](self, victim, weapon, attackerweapon, meansofdeath)) {
            return;
        }
    }
    if (isarray(level.specweapons)) {
        foreach (var_bdf00e5c in level.specweapons) {
            if (isdefined(var_bdf00e5c.var_562ea7ab)) {
                [[ var_bdf00e5c.var_562ea7ab ]](attacker, time, weapon, var_bdf00e5c.weapon, isdefined(victim.var_8de4e781) ? victim.var_8de4e781 : 0);
            }
        }
    }
    if (isdefined(scoreevents) && isdefined(scoreevents.var_be551573) && (!(isdefined(victim.var_8de4e781) ? victim.var_8de4e781 : 0) || !isdefined(scoreevents.var_21b74e29))) {
        scoreevents::processscoreevent(scoreevents.var_be551573, attacker, victim, weapon);
    }
    attacker function_9192be68(weapon, scoreevents);
    if (isdefined(scoreevents) && isdefined(scoreevents.var_8cf7c65f) || isdefined(level.specweapons) && isdefined(level.specweapons[var_ff40eac7.name]) && isdefined(level.specweapons[var_ff40eac7.name].var_91b7dbe3)) {
        if (level.teambased && isdefined(victim) && isdefined(victim.damagedplayers)) {
            foreach (entitydamaged in victim.damagedplayers) {
                if (!isdefined(entitydamaged.entity) || entitydamaged.entity == attacker || attacker util::isenemyplayer(entitydamaged.entity) || !isdefined(entitydamaged.time)) {
                    continue;
                }
                if (time - entitydamaged.time < 1000) {
                    if (isdefined(level.specweapons) && isdefined(level.specweapons[var_ff40eac7.name]) && isdefined(level.specweapons[var_ff40eac7.name].var_91b7dbe3)) {
                        [[ level.specweapons[var_ff40eac7.name].var_91b7dbe3 ]](attacker, victim, entitydamaged.entity, time, weapon, level.specweapons[var_ff40eac7.name].weapon);
                    }
                    if (isdefined(scoreevents) && isdefined(scoreevents.var_8cf7c65f)) {
                        scoreevents::processscoreevent(scoreevents.var_8cf7c65f, attacker, victim, weapon);
                    }
                }
            }
        }
    }
    self.multikills[var_ff40eac7.name].kills++;
    if (!isdefined(inflictor.var_4d31b505)) {
        inflictor.var_4d31b505 = 0;
    }
    inflictor.var_4d31b505++;
    self thread function_112aef0a(inflictor, meansofdeath, victim, self, scoreevents, weapon, var_ff40eac7, time);
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x0
// Checksum 0x3a0f07e5, Offset: 0x2da0
// Size: 0x4c4
function specialistmedalachievement(weapon, scoreevents) {
    if (!sessionmodeismultiplayergame() || !level.rankedmatch || level.disablestattracking || !isdefined(self) || !isplayer(self) || !isdefined(weapon)) {
        return;
    }
    if (!isdefined(scoreevents)) {
        scoreevents = function_c8e9dad8(weapon.var_980d2212);
    }
    var_dbd0bb1c = 0;
    baseweapon = weapons::getbaseweapon(weapon);
    if (isdefined(baseweapon.issignatureweapon) && baseweapon.issignatureweapon) {
        var_dbd0bb1c += self stats::get_stat_global(#"stats_battle_shield_x2_multikill_summary");
        var_dbd0bb1c += self stats::get_stat_global(#"stats_war_machine_x2_multikill_summary");
        var_dbd0bb1c += self stats::get_stat_global(#"stats_tak5_multikill_x2_multikill_summary");
        var_dbd0bb1c += self stats::get_stat_global(#"stats_purifier_x2_multikill_summary");
        var_dbd0bb1c += self stats::get_stat_global(#"stats_attack_dog_x2_multikill_summary");
        var_dbd0bb1c += self stats::get_stat_global(#"stats_tempest_x2_multikill_summary");
        var_dbd0bb1c += self stats::get_stat_global(#"stats_vision_pulse_x2_multikill_summary");
        var_dbd0bb1c += self stats::get_stat_global(#"stats_gravity_slam_multikill_x2");
        var_dbd0bb1c += self stats::get_stat_global(#"stats_annihilator_x2_multikill_summary");
        var_dbd0bb1c += self stats::get_stat_global(#"stats_deployable_cover_x2_multikill_summary");
        if (var_dbd0bb1c >= 10) {
            self giveachievement("mp_trophy_special_issue_weaponry");
        }
        return;
    }
    if (isdefined(baseweapon.var_ee15463f) && baseweapon.var_ee15463f && isdefined(scoreevents) && isdefined(scoreevents.var_2088f509) && scoreevents.var_2088f509) {
        var_dbd0bb1c += self stats::get_stat_global(#"stats_swat_grenade_multikill_x2_summary");
        var_dbd0bb1c += self stats::get_stat_global(#"stats_cluster_semtex_multikill_x2_summary");
        var_dbd0bb1c += self stats::get_stat_global(#"hash_3427f2d4181d570");
        var_dbd0bb1c += self stats::get_stat_global(#"stats_radiation_field_multikill_x2_summary");
        var_dbd0bb1c += self stats::get_stat_global(#"stats_tripwire_ied_multikill_x2_summary");
        var_dbd0bb1c += self stats::get_stat_global(#"stats_seeker_shock_mine_paralyzed_headshot");
        var_dbd0bb1c += self stats::get_stat_global(#"stats_sensor_dart_multikill_x2_summary");
        var_dbd0bb1c += self stats::get_stat_global(#"stats_grapple_gun_multikill_x2_summary");
        var_dbd0bb1c += self stats::get_stat_global(#"stats_spawn_beacon_multikill_x2_summary");
        var_dbd0bb1c += self stats::get_stat_global(#"stats_concertina_wire_multikill_x2_summary");
        if (var_dbd0bb1c >= 10) {
            self giveachievement("mp_trophy_special_issue_equipment");
        }
    }
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x0
// Checksum 0xdfeb8b3b, Offset: 0x3270
// Size: 0x154
function function_9192be68(weapon, scoreevents) {
    if (sessionmodeiswarzonegame()) {
        return;
    }
    equipment = self loadout::function_3d8b02a0("primarygrenade");
    ability = self loadout::function_3d8b02a0("specialgrenade");
    baseweapon = weapons::getbaseweapon(weapon);
    if (isdefined(ability) && isdefined(baseweapon.issignatureweapon) && baseweapon.issignatureweapon) {
        self function_b5489c4b(ability, 1);
        return;
    }
    if (isdefined(equipment) && isdefined(baseweapon.var_ee15463f) && baseweapon.var_ee15463f && isdefined(scoreevents) && isdefined(scoreevents.var_2088f509) && scoreevents.var_2088f509) {
        self function_b5489c4b(equipment, 1);
    }
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xd892508f, Offset: 0x33d0
// Size: 0x9a
function function_e6909d2b(var_ff40eac7) {
    if (!isdefined(self.multikills)) {
        self.multikills = [];
    }
    if (isdefined(var_ff40eac7) && !isdefined(self.multikills[var_ff40eac7.name])) {
        struct = spawnstruct();
        struct.kills = 0;
        struct.objectivekills = 0;
        self.multikills[var_ff40eac7.name] = struct;
    }
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xbffc7dae, Offset: 0x3478
// Size: 0xba
function function_fa546328(weapon) {
    if (!isdefined(level.specweapons)) {
        level.specweapons = [];
    }
    if (!isdefined(level.specweapons[weapon.name])) {
        level.specweapons[weapon.name] = spawnstruct();
    }
    if (!isdefined(level.specweapons[weapon.name].weapon)) {
        level.specweapons[weapon.name].weapon = weapon;
    }
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x0
// Checksum 0x81477c6e, Offset: 0x3540
// Size: 0x4e
function register_kill_callback(weapon, callback) {
    function_fa546328(weapon);
    level.specweapons[weapon.name].kill_callback = callback;
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x0
// Checksum 0x2ca3e881, Offset: 0x3598
// Size: 0x8a
function function_4f0048ef(status_effect_name, callback) {
    if (!isdefined(level.var_23f5efd4)) {
        level.var_23f5efd4 = [];
    }
    if (!isdefined(level.var_23f5efd4[status_effect_name])) {
        level.var_23f5efd4[status_effect_name] = spawnstruct();
    }
    level.var_23f5efd4[status_effect_name].kill_callback = callback;
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x0
// Checksum 0x1d06a4ce, Offset: 0x3630
// Size: 0x4e
function function_55e3f7c(weapon, callback) {
    function_fa546328(weapon);
    level.specweapons[weapon.name].var_9bc836c1 = callback;
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x0
// Checksum 0x3a8c0f78, Offset: 0x3688
// Size: 0x4e
function function_bddb28c1(weapon, callback) {
    function_fa546328(weapon);
    level.specweapons[weapon.name].var_e1814239 = callback;
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x0
// Checksum 0xd44e94ca, Offset: 0x36e0
// Size: 0x4e
function function_27915f9b(weapon, callback) {
    function_fa546328(weapon);
    level.specweapons[weapon.name].var_91b7dbe3 = callback;
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x0
// Checksum 0xf6cc50e9, Offset: 0x3738
// Size: 0x4e
function function_21d6f81f(weapon, callback) {
    function_fa546328(weapon);
    level.specweapons[weapon.name].var_fdf27be7 = callback;
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x0
// Checksum 0x5d43689f, Offset: 0x3790
// Size: 0x4e
function function_b2769662(weapon, callback) {
    function_fa546328(weapon);
    level.specweapons[weapon.name].var_929151ca = callback;
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x0
// Checksum 0x2d805628, Offset: 0x37e8
// Size: 0x4e
function function_1a5ec023(weapon, callback) {
    function_fa546328(weapon);
    level.specweapons[weapon.name].var_562ea7ab = callback;
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0x5c17d9f0, Offset: 0x3840
// Size: 0x19e
function function_8fe8d71e(eventname) {
    assert(isdefined(eventname));
    if (!isdefined(level.scoreinfo[eventname]) || !isdefined(self) || !isplayer(self)) {
        return;
    }
    /#
        if (getdvarint(#"logscoreevents", 0) > 0) {
            if (!isdefined(level.var_ce007bc4)) {
                level.var_ce007bc4 = [];
            }
            eventstr = ishash(eventname) ? function_15979fa9(eventname) : eventname;
            if (!isdefined(level.var_ce007bc4)) {
                level.var_ce007bc4 = [];
            } else if (!isarray(level.var_ce007bc4)) {
                level.var_ce007bc4 = array(level.var_ce007bc4);
            }
            level.var_ce007bc4[level.var_ce007bc4.size] = eventstr;
        }
    #/
    eventindex = level.scoreinfo[eventname][#"row"];
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0x381056ce, Offset: 0x39e8
// Size: 0x6c
function function_691c588f(weapon) {
    var_2032630b = function_c8e9dad8(weapon.var_980d2212);
    if (!isdefined(var_2032630b) || !isdefined(var_2032630b.var_aa13dc78)) {
        return;
    }
    self function_8fe8d71e(var_2032630b.var_aa13dc78);
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xcbd094c3, Offset: 0x3a60
// Size: 0x6c
function function_63de40fa(var_77b19ea2) {
    var_2032630b = function_c8e9dad8(var_77b19ea2.var_980d2212);
    if (!isdefined(var_2032630b) || !isdefined(var_2032630b.var_aa13dc78)) {
        return;
    }
    self function_8fe8d71e(var_2032630b.var_aa13dc78);
}

/#

    // Namespace globallogic_score/globallogic_score
    // Params 0, eflags: 0x0
    // Checksum 0x9c5413f0, Offset: 0x3ad8
    // Size: 0x226
    function function_b77e6c5() {
        level endon(#"game_ended");
        if (!isdefined(level.var_ce007bc4)) {
            level.var_ce007bc4 = [];
        }
        while (true) {
            if (getdvarint(#"dumpscoreevents", 0) > 0) {
                var_b8ccbd37 = [];
                foreach (scoreevent in level.var_ce007bc4) {
                    if (!isdefined(var_b8ccbd37[scoreevent])) {
                        var_b8ccbd37[scoreevent] = 0;
                    }
                    var_b8ccbd37[scoreevent]++;
                }
                println("<dev string:x6a>");
                foreach (var_6ac11168 in getarraykeys(var_b8ccbd37)) {
                    count = var_b8ccbd37[var_6ac11168];
                    println(var_6ac11168 + "<dev string:xbd>" + (isdefined(count) ? "<dev string:xc0>" + count : "<dev string:xc0>"));
                }
                println("<dev string:xc1>");
                setdvar(#"dumpscoreevents", 0);
            }
            waitframe(1);
        }
    }

#/
