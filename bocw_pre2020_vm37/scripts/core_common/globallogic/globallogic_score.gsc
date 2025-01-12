#using script_7f6cd71c43c45c57;
#using scripts\core_common\activecamo_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\contracts_shared;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\rank_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\weapons_shared;
#using scripts\weapons\weapon_utils;

#namespace globallogic_score;

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x6
// Checksum 0xe0b0186b, Offset: 0x140
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"globallogic_score", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x5 linked
// Checksum 0x5a81f4e4, Offset: 0x188
// Size: 0x9c
function private function_70a657d8() {
    callback::on_start_gametype(&init);
    callback::on_spawned(&playerspawn);
    /#
        setdvar(#"logscoreevents", 0);
        setdvar(#"dumpscoreevents", 0);
        thread function_bb9f3842();
    #/
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x1 linked
// Checksum 0xb8d7a10f, Offset: 0x230
// Size: 0x7c
function init() {
    level.var_e0582de1 = [];
    scoreevents::registerscoreeventcallback("playerKilled", &function_f7f7b14e);
    scoreevents::function_9677601b("playerKilled", &function_1a0fa609);
    level.capturedobjectivefunction = &function_eced93f5;
}

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x1 linked
// Checksum 0x6f478377, Offset: 0x2b8
// Size: 0x84
function playerspawn() {
    self.var_60a9eae7 = 0;
    self.var_a6b00192 = 0;
    self.var_7fff4605 = 0;
    self callback::on_weapon_change(&on_weapon_change);
    self callback::on_weapon_fired(&on_weapon_fired);
    self callback::on_grenade_fired(&on_grenade_fired);
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x5 linked
// Checksum 0x443435c9, Offset: 0x348
// Size: 0x22
function private on_weapon_change(*params) {
    self.var_a6b00192 = 0;
    self.var_7fff4605 = 0;
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x5 linked
// Checksum 0x6572f700, Offset: 0x378
// Size: 0x2c
function private on_weapon_fired(params) {
    self function_5aa55c0a(params.weapon);
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x5 linked
// Checksum 0xe9a171c5, Offset: 0x3b0
// Size: 0xd4
function private function_f0d51d49(projectile, weapon) {
    self endon(#"disconnect");
    level endon(#"game_ended");
    scoreevents = function_3cbc4c6c(weapon.var_2e4a8800);
    if (!isdefined(scoreevents.var_aa14d757)) {
        return;
    }
    var_2a7ea9a6 = projectile waittilltimeout(10, #"death");
    if (var_2a7ea9a6._notify != "timeout") {
        scoreevents::processscoreevent(scoreevents.var_aa14d757, self, undefined, weapon);
    }
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x5 linked
// Checksum 0x388cd18e, Offset: 0x490
// Size: 0x7c
function private on_grenade_fired(params) {
    weapon = params.weapon;
    if (!isdefined(weapon) || !isdefined(weapon.var_2e4a8800)) {
        return;
    }
    self function_5aa55c0a(weapon);
    self thread function_f0d51d49(params.projectile, weapon);
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x1 linked
// Checksum 0xe07fc5b9, Offset: 0x518
// Size: 0x8c
function function_5aa55c0a(weapon) {
    if (isdefined(weapon) && isdefined(weapon.var_2e4a8800)) {
        scoreevents = function_3cbc4c6c(weapon.var_2e4a8800);
    }
    if (!isdefined(scoreevents)) {
        return;
    }
    if (isdefined(scoreevents.var_7ecee77b)) {
        scoreevents::processscoreevent(scoreevents.var_7ecee77b, self, undefined, weapon);
    }
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x1 linked
// Checksum 0xbcb127a9, Offset: 0x5b0
// Size: 0x4c
function inctotalkills(team) {
    if (level.teambased && isdefined(level.teams[team])) {
        game.totalkillsteam[team]++;
    }
    game.totalkills++;
}

// Namespace globallogic_score/globallogic_score
// Params 3, eflags: 0x1 linked
// Checksum 0x1964e792, Offset: 0x608
// Size: 0x44
function givekillstats(smeansofdeath, weapon, evictim) {
    if (isdefined(level.scoreevents_givekillstats)) {
        [[ level.scoreevents_givekillstats ]](smeansofdeath, weapon, evictim);
    }
}

// Namespace globallogic_score/globallogic_score
// Params 6, eflags: 0x1 linked
// Checksum 0x40b54c1a, Offset: 0x658
// Size: 0xcc
function function_e93cd1bb(event, var_ba01256c, weapon, attacker, victim, var_586a3b24) {
    if (!isdefined(var_ba01256c)) {
        return;
    }
    if (!isdefined(attacker.var_19f577f)) {
        attacker.var_19f577f = [];
    }
    attacker.var_19f577f[event] = (isdefined(attacker.var_19f577f[event]) ? attacker.var_19f577f[event] : 0) + 1;
    if (is_true(var_586a3b24)) {
        scoreevents::processscoreevent(event, attacker, victim, weapon);
    }
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x1 linked
// Checksum 0xe980affa, Offset: 0x730
// Size: 0xc4
function function_969ea48d(var_ba01256c, weapon) {
    if (!isdefined(var_ba01256c)) {
        return;
    }
    scoreevents = function_3cbc4c6c(var_ba01256c.var_2e4a8800);
    if (!isdefined(scoreevents) || !isdefined(scoreevents.var_1253685d)) {
        return;
    }
    scoreevents::processscoreevent(scoreevents.var_1253685d, self, undefined, weapon);
    if (rank::function_ca5d4a8(scoreevents.var_1253685d)) {
        function_e93cd1bb(scoreevents.var_1253685d, var_ba01256c, weapon, self, undefined, 0);
    }
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x1 linked
// Checksum 0x2000dac, Offset: 0x800
// Size: 0xee
function function_52ca9649(event) {
    if (!isdefined(level.scoreinfo[event])) {
        println("<dev string:x38>" + event);
        return;
    }
    if (!isdefined(self.var_19f577f)) {
        self.var_19f577f = [];
    }
    if (!isdefined(self.var_19f577f[event]) || self.var_19f577f[event] <= 0) {
        return;
    }
    eventindex = level.scoreinfo[event][#"row"];
    self luinotifyevent(#"end_sustaining_action", 1, eventindex);
    self.var_19f577f[event]--;
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x1 linked
// Checksum 0x675bfb45, Offset: 0x8f8
// Size: 0x84
function function_fc47f2ff(var_ba01256c, *weapon) {
    if (!isdefined(weapon)) {
        return;
    }
    scoreevents = function_3cbc4c6c(weapon.var_2e4a8800);
    if (!isdefined(scoreevents) || !isdefined(scoreevents.var_1253685d)) {
        return;
    }
    function_52ca9649(scoreevents.var_1253685d);
}

// Namespace globallogic_score/globallogic_score
// Params 6, eflags: 0x1 linked
// Checksum 0x3d8cb36d, Offset: 0x988
// Size: 0x1d8
function processassist(killedplayer, damagedone, weapon, assist_level = undefined, time = gettime(), meansofdeath = "MOD_UNKNOWN") {
    waitframe(1);
    util::waittillslowprocessallowed();
    if (!isdefined(self) || !isdefined(killedplayer) || !isplayer(self) || !isplayer(killedplayer) || !isdefined(weapon)) {
        return;
    }
    if (isarray(level.specweapons)) {
        foreach (var_25f92d1d in level.specweapons) {
            self function_b78294bf(killedplayer, var_25f92d1d.weapon, weapon, var_25f92d1d, time, meansofdeath);
        }
    }
    self function_b78294bf(killedplayer, weapon, weapon, undefined, time, meansofdeath);
    if (isdefined(level.scoreevents_processassist)) {
        self [[ level.scoreevents_processassist ]](killedplayer, damagedone, weapon, assist_level);
    }
}

// Namespace globallogic_score/globallogic_score
// Params 6, eflags: 0x5 linked
// Checksum 0x97551720, Offset: 0xb68
// Size: 0x1dc
function private function_b78294bf(victim, weapon, attackerweapon, var_67660cb2, *time, meansofdeath) {
    scoreevents = function_3cbc4c6c(attackerweapon.var_2e4a8800);
    if ((isdefined(weapon.var_60a9eae7) ? weapon.var_60a9eae7 : 0) && isdefined(scoreevents) && isdefined(scoreevents.var_a6bfdc5f)) {
        if (isdefined(time)) {
            if (!isdefined(time.var_37850de1) || ![[ time.var_37850de1 ]](self, weapon, attackerweapon, var_67660cb2)) {
                return;
            }
        }
        self function_662aaa65(attackerweapon);
        self.multikills[attackerweapon.name].objectivekills++;
        if (isdefined(scoreevents) && isdefined(scoreevents.var_a6bfdc5f)) {
            scoreevents::processscoreevent(scoreevents.var_a6bfdc5f, self, weapon, attackerweapon);
        }
    } else {
        if (isdefined(time)) {
            if (!isdefined(time.kill_callback) || ![[ time.kill_callback ]](self, weapon, attackerweapon, var_67660cb2, meansofdeath)) {
                return;
            }
        }
        if (isdefined(scoreevents) && isdefined(scoreevents.var_170b3630)) {
            scoreevents::processscoreevent(scoreevents.var_170b3630, self, weapon, attackerweapon);
        }
    }
    self function_8279d8bf(attackerweapon, scoreevents);
}

// Namespace globallogic_score/globallogic_score
// Params 3, eflags: 0x1 linked
// Checksum 0x6e3fb2e3, Offset: 0xd50
// Size: 0x28c
function function_5829abe3(attacker, weapon, var_651b6171) {
    if (!isdefined(self) || !isdefined(var_651b6171) || !isdefined(attacker) || !isplayer(attacker)) {
        return;
    }
    if (!isdefined(weapon)) {
        weapon = level.weaponnone;
    }
    attacker challenges::function_24db0c33(weapon, var_651b6171);
    if (isdefined(level.iskillstreakweapon)) {
        if ([[ level.iskillstreakweapon ]](weapon) || isdefined(weapon.statname) && [[ level.iskillstreakweapon ]](getweapon(weapon.statname))) {
            weaponiskillstreak = 1;
        }
        if ([[ level.iskillstreakweapon ]](var_651b6171)) {
            destroyedkillstreak = 1;
        }
    }
    var_3c727edf = function_3cbc4c6c(var_651b6171.var_2e4a8800);
    if ((!is_true(weaponiskillstreak) || is_true(destroyedkillstreak)) && isdefined(var_3c727edf) && isdefined(var_3c727edf.var_3143c814) && util::function_fbce7263(attacker.team, self.team)) {
        scoreevents::processscoreevent(var_3c727edf.var_3143c814, attacker, self, var_651b6171);
        attacker stats::function_dad108fa(#"stats_destructions", 1);
    }
    if (var_651b6171.issignatureweapon) {
        attacker activecamo::function_896ac347(weapon, #"showstopper", 1);
    }
    scoreevents = function_3cbc4c6c(weapon.var_2e4a8800);
    if (isdefined(scoreevents) && isdefined(scoreevents.var_84eddb70)) {
        scoreevents::processscoreevent(scoreevents.var_84eddb70, attacker, self, weapon);
    }
}

// Namespace globallogic_score/globallogic_score
// Params 5, eflags: 0x1 linked
// Checksum 0xe564fdb3, Offset: 0xfe8
// Size: 0x2e4
function function_a890cac2(attacker, owningteam, weapon, scoreevents, objectiveobj) {
    attacker function_662aaa65(weapon);
    attacker.multikills[weapon.name].objectivekills++;
    if (level.teambased && isdefined(owningteam) && attacker.team == owningteam) {
        if (isdefined(level.specweapons) && isdefined(level.specweapons[weapon.name]) && isdefined(level.specweapons[weapon.name].var_826b85e7)) {
            [[ level.specweapons[weapon.name].var_826b85e7 ]](attacker, self, weapon, objectiveobj);
        }
        if (isdefined(scoreevents) && isdefined(scoreevents.var_867de225)) {
            scoreevents::processscoreevent(scoreevents.var_867de225, attacker, self, weapon);
        }
        if ((isdefined(attacker.multikills[weapon.name].objectivekills) ? attacker.multikills[weapon.name].objectivekills : 0) > 2 && (isdefined(objectiveobj.var_4e02c9bd) ? objectiveobj.var_4e02c9bd : 0) < gettime()) {
            enemies = attacker getenemies();
            var_f6612539 = 0;
            foreach (enemy in enemies) {
                if (enemy istouching(objectiveobj)) {
                    var_f6612539 = 1;
                    break;
                }
            }
            if (!var_f6612539) {
                objectiveobj.var_4e02c9bd = gettime() + 4000;
                attacker.multikills[weapon.name].var_d6089e48 = 1;
            }
        }
    }
    if (isdefined(scoreevents) && isdefined(scoreevents.var_8600aca4)) {
        scoreevents::processscoreevent(scoreevents.var_8600aca4, attacker, self, weapon);
    }
}

// Namespace globallogic_score/globallogic_score
// Params 4, eflags: 0x0
// Checksum 0xd51a7c0d, Offset: 0x12d8
// Size: 0xca
function function_2e33e275(einflictor, attacker, weapon, var_5b1d28ec) {
    if (!isplayer(attacker) || !isplayer(self) || !isdefined(weapon) || !isdefined(var_5b1d28ec)) {
        return false;
    }
    if (!self istouching(var_5b1d28ec)) {
        if (!isdefined(einflictor) || einflictor != attacker || !attacker istouching(var_5b1d28ec)) {
            return false;
        }
    }
    return true;
}

// Namespace globallogic_score/globallogic_score
// Params 5, eflags: 0x0
// Checksum 0x3cafa483, Offset: 0x13b0
// Size: 0x210
function function_7d830bc(*einflictor, attacker, weapon, var_5b1d28ec, owningteam) {
    attacker endon(#"disconnect", #"death");
    level endon(#"game_ended");
    self notify("382d87d60e60f869");
    self endon("382d87d60e60f869");
    self.var_60a9eae7 = 1;
    attacker.var_f46a73a1 = weapon;
    attacker.var_60f43bac = gettime();
    attacker.var_e3d30669 = var_5b1d28ec;
    scoreevents = function_3cbc4c6c(weapon.var_2e4a8800);
    self function_a890cac2(attacker, owningteam, weapon, scoreevents, var_5b1d28ec);
    if (isarray(level.specweapons)) {
        foreach (var_25f92d1d in level.specweapons) {
            if (!isdefined(var_25f92d1d.var_37850de1) || ![[ var_25f92d1d.var_37850de1 ]](attacker, self, var_25f92d1d.weapon, weapon)) {
                continue;
            }
            var_bbe53115 = function_3cbc4c6c(var_25f92d1d.weapon.var_2e4a8800);
            self function_a890cac2(attacker, owningteam, var_25f92d1d.weapon, var_bbe53115, var_5b1d28ec);
        }
    }
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x5 linked
// Checksum 0x935096f3, Offset: 0x15c8
// Size: 0x1ec
function private function_eced93f5(objective, var_c217216c) {
    if (!isdefined(objective) || !isdefined(var_c217216c) || !isdefined(self) || !isdefined(self.var_f46a73a1) || !isdefined(self.var_60f43bac) || !isdefined(self.var_e3d30669)) {
        return;
    }
    if (var_c217216c - self.var_60f43bac > int(20 * 1000) || objective != self.var_e3d30669) {
        return;
    }
    if (isarray(level.specweapons)) {
        foreach (specialweapon in level.specweapons) {
            if (isdefined(specialweapon.var_d20c7012)) {
                [[ specialweapon.var_d20c7012 ]](self, self.var_f46a73a1, self.var_60f43bac, self.var_e3d30669, specialweapon.weapon);
            }
        }
    }
    scoreevents = function_3cbc4c6c(self.var_f46a73a1.var_2e4a8800);
    if (isdefined(scoreevents) && isdefined(scoreevents.var_1d0ab0f4)) {
        scoreevents::processscoreevent(scoreevents.var_1d0ab0f4, self, undefined, self.var_f46a73a1);
    }
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x1 linked
// Checksum 0x388b082d, Offset: 0x17c0
// Size: 0x58
function function_3cbc4c6c(scriptbundle) {
    if (!isdefined(scriptbundle)) {
        return;
    }
    if (!isdefined(level.var_e0582de1[scriptbundle])) {
        level.var_e0582de1[scriptbundle] = getscriptbundle(scriptbundle);
    }
    return level.var_e0582de1[scriptbundle];
}

// Namespace globallogic_score/globallogic_score
// Params 8, eflags: 0x1 linked
// Checksum 0xb820e10e, Offset: 0x1820
// Size: 0x498
function function_24d66e59(inflictor, meansofdeath, victim, attacker, weapon, var_bd10969, time, data) {
    if (!isdefined(var_bd10969) || !isarray(var_bd10969)) {
        return;
    }
    if (!isdefined(victim)) {
        return;
    }
    foreach (effect in var_bd10969) {
        if (!isdefined(effect) || !isdefined(effect.var_4b22e697) || victim == effect.var_4b22e697) {
            continue;
        }
        scoreevents = function_3cbc4c6c(effect.var_2e4a8800);
        if (!isdefined(scoreevents)) {
            continue;
        }
        if ((isdefined(victim.var_60a9eae7) ? victim.var_60a9eae7 : 0) && (isdefined(scoreevents.var_a6bfdc5f) || isdefined(scoreevents.var_8600aca4))) {
            attacker function_662aaa65(effect);
            attacker.multikills[effect.name].objectivekills++;
            if (isdefined(effect.var_4b22e697) && isplayer(effect.var_4b22e697) && attacker != effect.var_4b22e697) {
                if (isdefined(scoreevents.var_a6bfdc5f)) {
                    scoreevents::processscoreevent(scoreevents.var_a6bfdc5f, effect.var_4b22e697, victim, effect.var_3d1ed4bd);
                }
            } else if (isdefined(scoreevents.var_8600aca4)) {
                scoreevents::processscoreevent(scoreevents.var_8600aca4, effect.var_4b22e697, victim, effect.var_3d1ed4bd);
            }
        } else if (isdefined(effect.var_4b22e697) && isplayer(effect.var_4b22e697) && attacker != effect.var_4b22e697 && attacker util::isenemyplayer(effect.var_4b22e697) == 0) {
            baseweapon = weapons::getbaseweapon(weapon);
            if (isdefined(scoreevents.var_2eaed769) && (is_true(baseweapon.issignatureweapon) || is_true(baseweapon.var_76ce72e8))) {
                scoreevents::processscoreevent(scoreevents.var_2eaed769, effect.var_4b22e697, victim, effect.var_3d1ed4bd);
            } else if (isdefined(scoreevents.var_170b3630)) {
                scoreevents::processscoreevent(scoreevents.var_170b3630, effect.var_4b22e697, victim, effect.var_3d1ed4bd);
            }
        }
        if (attacker == effect.var_4b22e697) {
            if (isdefined(level.var_f19c99e1) && isdefined(level.var_f19c99e1[effect.name]) && isdefined(level.var_f19c99e1[effect.name].kill_callback)) {
                if (![[ level.var_f19c99e1[effect.name].kill_callback ]](self, victim, effect.var_3d1ed4bd, weapon, meansofdeath)) {
                    return;
                }
            }
            updatemultikill(inflictor, meansofdeath, victim, attacker, scoreevents, effect.var_3d1ed4bd, weapon, effect, time, data);
        }
    }
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x1 linked
// Checksum 0xf4b125bd, Offset: 0x1cc0
// Size: 0x504
function function_f7f7b14e(data) {
    profilestart();
    inflictor = data.einflictor;
    victim = data.victim;
    attacker = data.attacker;
    meansofdeath = data.smeansofdeath;
    if (!isplayer(attacker)) {
        profilestop();
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
        foreach (var_25f92d1d in level.specweapons) {
            if (isdefined(var_25f92d1d.kill_callback)) {
                specweapon = var_25f92d1d.weapon;
                var_b6f366b = function_3cbc4c6c(specweapon.var_2e4a8800);
                attacker updatemultikill(inflictor, meansofdeath, victim, attacker, var_b6f366b, specweapon, weapon, specweapon, time, data);
            }
        }
    }
    attacker function_24d66e59(inflictor, meansofdeath, victim, attacker, weapon, data.var_bd10969, time, data);
    if (isdefined(data.victimweapon)) {
        var_3d2a11cf = function_3cbc4c6c(data.victimweapon.var_2e4a8800);
        if (data.victimweapon.issignatureweapon) {
            attacker activecamo::function_896ac347(weapon, #"showstopper", 1);
        }
    }
    if (!isdefined(var_3d2a11cf) && isdefined(victim.heroability) && isdefined(victim.heroabilityactivatetime) && victim.heroabilityactivatetime + 700 > time) {
        var_3d2a11cf = function_3cbc4c6c(victim.heroability.var_2e4a8800);
        attacker activecamo::function_896ac347(weapon, #"showstopper", 1);
    }
    if (isdefined(weapon) && isdefined(level.iskillstreakweapon)) {
        if ([[ level.iskillstreakweapon ]](weapon) || isdefined(weapon.statname) && [[ level.iskillstreakweapon ]](getweapon(weapon.statname))) {
            weaponiskillstreak = 1;
        }
    }
    if (isdefined(var_3d2a11cf) && isdefined(var_3d2a11cf.var_3143c814) && !is_true(weaponiskillstreak) && isdefined(attacker) && isdefined(victim) && util::function_fbce7263(attacker.team, victim.team)) {
        scoreevents::processscoreevent(var_3d2a11cf.var_3143c814, attacker, victim, weapon);
        victim.var_ad1472a2 = 1;
        attacker stats::function_dad108fa(#"stats_shutdowns", 1);
        attacker contracts::increment_contract(#"contract_mp_shutdown");
    }
    baseweapon = weapons::getbaseweapon(weapon);
    attacker updatemultikill(inflictor, meansofdeath, victim, attacker, function_3cbc4c6c(weapon.var_2e4a8800), weapon, weapon, baseweapon, time, data);
    if (weapons::ismeleemod(meansofdeath)) {
        scoreevents::processscoreevent(#"melee_kill", attacker, self, weapon);
        data.var_7b4d33ac = 1;
    }
    profilestop();
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x5 linked
// Checksum 0xf101e8d3, Offset: 0x21d0
// Size: 0xca
function private function_1a0fa609(data) {
    attacker = data.attacker;
    if (!isplayer(attacker)) {
        return;
    }
    if (data.var_7b4d33ac !== 1) {
        victim = data.victim;
        weapon = isdefined(data.weapon) ? data.weapon : level.weaponnone;
        scoreevents::processscoreevent(#"ekia", attacker, self, weapon);
        data.var_7b4d33ac = 1;
    }
}

// Namespace globallogic_score/globallogic_score
// Params 8, eflags: 0x5 linked
// Checksum 0xa5635a1d, Offset: 0x22a8
// Size: 0x862
function private function_d68ae402(inflictor, *meansofdeath, victim, attacker, scoreevents, weapon, var_f801f37e, time) {
    level endon(#"game_ended");
    var_ac4c1 = var_f801f37e.name;
    attacker notify(var_ac4c1 + "MultiKillScore");
    attacker endon(var_ac4c1 + "MultiKillScore", #"disconnect");
    if (meansofdeath.var_a6b00192 >= 3 && !(isdefined(meansofdeath.var_7fff4605) ? meansofdeath.var_7fff4605 : 0)) {
        if (isdefined(scoreevents) && isdefined(scoreevents.var_db750037)) {
            scoreevents::processscoreevent(scoreevents.var_db750037, attacker, undefined, weapon);
        }
        meansofdeath.var_7fff4605 = 1;
    }
    if (var_ac4c1 == #"frag_grenade" || var_ac4c1 == #"eq_molotov" || var_ac4c1 == #"hatchet") {
        attacker contracts::increment_contract(#"hash_3ffc3d28289d21bb");
        if (var_ac4c1 == #"eq_molotov") {
            attacker contracts::increment_contract(#"contract_mp_molotov_kill");
        }
    }
    if (!isdefined(attacker.multikills) || !isdefined(attacker.multikills[var_ac4c1])) {
        return;
    }
    waitresult = attacker waittilltimeout(4, #"death", #"team_changed");
    if (var_ac4c1 == #"frag_grenade" || var_ac4c1 == #"eq_molotov" || var_ac4c1 == #"hatchet") {
        if (attacker.multikills[var_ac4c1].kills >= 2) {
            if (!isdefined(attacker.pers[#"hash_52e978325c91fe24"])) {
                attacker.pers[#"hash_52e978325c91fe24"] = 0;
            }
            attacker.pers[#"hash_52e978325c91fe24"]++;
            if (attacker.pers[#"hash_52e978325c91fe24"] % 2 == 0) {
                attacker stats::function_dad108fa(#"hash_52e978325c91fe24", 1);
            }
        }
    }
    if (var_ac4c1 == #"frag_grenade") {
        if (attacker.multikills[var_ac4c1].kills >= 2) {
            attacker contracts::increment_contract(#"hash_6696408f54c6ada7");
        }
    }
    if (var_ac4c1 == #"eq_molotov") {
        if (attacker.multikills[var_ac4c1].kills >= 2) {
            attacker contracts::increment_contract(#"hash_4a7d49c14e026e91");
        }
    }
    if (isdefined(scoreevents)) {
        switch (isdefined(attacker.multikills[var_ac4c1].kills) ? attacker.multikills[var_ac4c1].kills : 0) {
        case 0:
        case 1:
            break;
        case 2:
            if (isdefined(scoreevents.var_d58bd0e9)) {
                scoreevents::processscoreevent(scoreevents.var_d58bd0e9, attacker, victim, weapon);
            }
            break;
        case 3:
            if (isdefined(scoreevents.var_6643c0a0)) {
                scoreevents::processscoreevent(scoreevents.var_6643c0a0, attacker, victim, weapon);
            }
            break;
        case 4:
            if (isdefined(scoreevents.var_16abf654)) {
                scoreevents::processscoreevent(scoreevents.var_16abf654, attacker, victim, weapon);
            }
            break;
        case 5:
            if (isdefined(scoreevents.var_1b8b6771)) {
                scoreevents::processscoreevent(scoreevents.var_1b8b6771, attacker, victim, weapon);
            }
            break;
        default:
            if (attacker.multikills[var_ac4c1].kills > 5 && isdefined(scoreevents.var_67b4a761)) {
                scoreevents::processscoreevent(scoreevents.var_67b4a761, attacker, victim, weapon);
            }
            break;
        }
        if ((isdefined(attacker.multikills[var_ac4c1].kills) ? attacker.multikills[var_ac4c1].kills : 0) >= 2) {
            attacker specialistmedalachievement(weapon, scoreevents);
        }
    }
    attacker.multikills[var_ac4c1].kills = 0;
    switch (isdefined(attacker.multikills[var_ac4c1].objectivekills) ? attacker.multikills[var_ac4c1].objectivekills : 0) {
    case 0:
    case 1:
    case 2:
        break;
    default:
        if (attacker.multikills[var_ac4c1].objectivekills > 2) {
            if (isdefined(scoreevents) && isdefined(scoreevents.var_3655354)) {
                scoreevents::processscoreevent(scoreevents.var_3655354, attacker, undefined, weapon);
            }
            if (isdefined(attacker.multikills[var_ac4c1].var_d6089e48) ? attacker.multikills[var_ac4c1].var_d6089e48 : 0) {
                if (isdefined(scoreevents) && isdefined(scoreevents.var_7b590f90)) {
                    scoreevents::processscoreevent(scoreevents.var_7b590f90, attacker, undefined, weapon);
                    attacker.multikills[var_ac4c1].var_d6089e48 = 0;
                }
                if (isarray(level.specweapons)) {
                    foreach (var_25f92d1d in level.specweapons) {
                        if (isdefined(var_25f92d1d.var_34f2424e)) {
                            [[ var_25f92d1d.var_34f2424e ]](attacker, time, weapon, var_25f92d1d.weapon);
                        }
                    }
                }
            }
        }
        break;
    }
    attacker.multikills[var_ac4c1].objectivekills = 0;
}

// Namespace globallogic_score/globallogic_score
// Params 10, eflags: 0x5 linked
// Checksum 0xd8043167, Offset: 0x2b18
// Size: 0x51c
function private updatemultikill(inflictor, meansofdeath, victim, attacker, scoreevents, weapon, attackerweapon, var_f801f37e, time, data) {
    self function_662aaa65(var_f801f37e);
    if (!isdefined(inflictor)) {
        inflictor = attacker;
    }
    if (isdefined(level.specweapons) && isdefined(level.specweapons[var_f801f37e.name]) && isdefined(level.specweapons[var_f801f37e.name].kill_callback)) {
        if (![[ level.specweapons[var_f801f37e.name].kill_callback ]](self, victim, weapon, attackerweapon, meansofdeath)) {
            return;
        }
    }
    if (isarray(level.specweapons)) {
        foreach (var_25f92d1d in level.specweapons) {
            if (isdefined(var_25f92d1d.var_90e3cfd7)) {
                [[ var_25f92d1d.var_90e3cfd7 ]](attacker, time, weapon, var_25f92d1d.weapon, isdefined(victim.var_60a9eae7) ? victim.var_60a9eae7 : 0);
            }
        }
    }
    if (isdefined(scoreevents) && isdefined(scoreevents.var_2ecceeab) && (!(isdefined(victim.var_60a9eae7) ? victim.var_60a9eae7 : 0) || !isdefined(scoreevents.var_8600aca4))) {
        scoreevents::processscoreevent(scoreevents.var_2ecceeab, attacker, victim, weapon);
        data.var_7b4d33ac = 1;
    }
    attacker function_8279d8bf(weapon, scoreevents);
    if (isdefined(scoreevents) && isdefined(scoreevents.var_2892e164) || isdefined(level.specweapons) && isdefined(level.specweapons[var_f801f37e.name]) && isdefined(level.specweapons[var_f801f37e.name].var_ec2a6a4c)) {
        if (level.teambased && isdefined(victim) && isdefined(victim.damagedplayers)) {
            foreach (entitydamaged in victim.damagedplayers) {
                if (!isdefined(entitydamaged.entity) || entitydamaged.entity == attacker || attacker util::isenemyplayer(entitydamaged.entity) || !isdefined(entitydamaged.time)) {
                    continue;
                }
                if (time - entitydamaged.time < 1000) {
                    if (isdefined(level.specweapons) && isdefined(level.specweapons[var_f801f37e.name]) && isdefined(level.specweapons[var_f801f37e.name].var_ec2a6a4c)) {
                        [[ level.specweapons[var_f801f37e.name].var_ec2a6a4c ]](attacker, victim, entitydamaged.entity, time, weapon, level.specweapons[var_f801f37e.name].weapon);
                    }
                    if (isdefined(scoreevents) && isdefined(scoreevents.var_2892e164)) {
                        scoreevents::processscoreevent(scoreevents.var_2892e164, attacker, victim, weapon);
                    }
                }
            }
        }
    }
    self.multikills[var_f801f37e.name].kills++;
    if (!isdefined(inflictor.var_a6b00192)) {
        inflictor.var_a6b00192 = 0;
    }
    inflictor.var_a6b00192++;
    self thread function_d68ae402(inflictor, meansofdeath, victim, self, scoreevents, weapon, var_f801f37e, time);
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x1 linked
// Checksum 0x73a90347, Offset: 0x3040
// Size: 0x4bc
function specialistmedalachievement(weapon, scoreevents) {
    if (!sessionmodeismultiplayergame() || !level.rankedmatch || level.disablestattracking || !isdefined(self) || !isplayer(self) || !isdefined(weapon)) {
        return;
    }
    if (!isdefined(scoreevents)) {
        scoreevents = function_3cbc4c6c(weapon.var_2e4a8800);
    }
    var_e716a62e = 0;
    baseweapon = weapons::getbaseweapon(weapon);
    if (is_true(baseweapon.issignatureweapon)) {
        var_e716a62e += self stats::get_stat_global(#"stats_battle_shield_x2_multikill_summary");
        var_e716a62e += self stats::get_stat_global(#"stats_war_machine_x2_multikill_summary");
        var_e716a62e += self stats::get_stat_global(#"stats_tak5_multikill_x2_multikill_summary");
        var_e716a62e += self stats::get_stat_global(#"stats_purifier_x2_multikill_summary");
        var_e716a62e += self stats::get_stat_global(#"stats_attack_dog_x2_multikill_summary");
        var_e716a62e += self stats::get_stat_global(#"stats_tempest_x2_multikill_summary");
        var_e716a62e += self stats::get_stat_global(#"stats_vision_pulse_x2_multikill_summary");
        var_e716a62e += self stats::get_stat_global(#"stats_gravity_slam_multikill_x2");
        var_e716a62e += self stats::get_stat_global(#"stats_annihilator_x2_multikill_summary");
        var_e716a62e += self stats::get_stat_global(#"stats_deployable_cover_x2_multikill_summary");
        if (var_e716a62e >= 10) {
            self giveachievement(#"mp_trophy_special_issue_weaponry");
        }
        return;
    }
    if (is_true(baseweapon.var_76ce72e8) && isdefined(scoreevents) && is_true(scoreevents.var_fcd2ff3a)) {
        var_e716a62e += self stats::get_stat_global(#"stats_swat_grenade_multikill_x2_summary");
        var_e716a62e += self stats::get_stat_global(#"stats_cluster_semtex_multikill_x2_summary");
        var_e716a62e += self stats::get_stat_global(#"hash_3427f2d4181d570");
        var_e716a62e += self stats::get_stat_global(#"stats_radiation_field_multikill_x2_summary");
        var_e716a62e += self stats::get_stat_global(#"stats_tripwire_ied_multikill_x2_summary");
        var_e716a62e += self stats::get_stat_global(#"stats_seeker_shock_mine_paralyzed_headshot");
        var_e716a62e += self stats::get_stat_global(#"stats_sensor_dart_multikill_x2_summary");
        var_e716a62e += self stats::get_stat_global(#"stats_grapple_gun_multikill_x2_summary");
        var_e716a62e += self stats::get_stat_global(#"stats_spawn_beacon_multikill_x2_summary");
        var_e716a62e += self stats::get_stat_global(#"stats_concertina_wire_multikill_x2_summary");
        if (var_e716a62e >= 10) {
            self giveachievement(#"mp_trophy_special_issue_equipment");
        }
    }
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x1 linked
// Checksum 0xab5619c1, Offset: 0x3508
// Size: 0x124
function function_8279d8bf(weapon, scoreevents) {
    if (sessionmodeiswarzonegame()) {
        return;
    }
    equipment = self loadout::function_18a77b37("primarygrenade");
    ability = self loadout::function_18a77b37("specialgrenade");
    baseweapon = weapons::getbaseweapon(weapon);
    if (isdefined(ability) && baseweapon.issignatureweapon === 1) {
        self function_be7a08a8(ability, 1);
        return;
    }
    if (isdefined(equipment) && isdefined(scoreevents) && baseweapon.var_76ce72e8 === 1 && scoreevents.var_fcd2ff3a === 1) {
        self function_be7a08a8(equipment, 1);
    }
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x1 linked
// Checksum 0xc581dc26, Offset: 0x3638
// Size: 0x94
function function_662aaa65(var_f801f37e) {
    if (!isdefined(self.multikills)) {
        self.multikills = [];
    }
    if (isdefined(var_f801f37e) && !isdefined(self.multikills[var_f801f37e.name])) {
        struct = spawnstruct();
        struct.kills = 0;
        struct.objectivekills = 0;
        self.multikills[var_f801f37e.name] = struct;
    }
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x1 linked
// Checksum 0x4fabc8ec, Offset: 0x36d8
// Size: 0xa2
function function_1f9441d7(weapon) {
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
// Checksum 0xbe0ddfb1, Offset: 0x3788
// Size: 0x4a
function register_kill_callback(weapon, callback) {
    function_1f9441d7(weapon);
    level.specweapons[weapon.name].kill_callback = callback;
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x0
// Checksum 0x23e60292, Offset: 0x37e0
// Size: 0x82
function function_a458dbe1(status_effect_name, callback) {
    if (!isdefined(level.var_f19c99e1)) {
        level.var_f19c99e1 = [];
    }
    if (!isdefined(level.var_f19c99e1[status_effect_name])) {
        level.var_f19c99e1[status_effect_name] = spawnstruct();
    }
    level.var_f19c99e1[status_effect_name].kill_callback = callback;
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x0
// Checksum 0xd7916142, Offset: 0x3870
// Size: 0x4a
function function_86f90713(weapon, callback) {
    function_1f9441d7(weapon);
    level.specweapons[weapon.name].var_37850de1 = callback;
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x0
// Checksum 0xf8f5b324, Offset: 0x38c8
// Size: 0x4a
function function_82fb1afa(weapon, callback) {
    function_1f9441d7(weapon);
    level.specweapons[weapon.name].var_d20c7012 = callback;
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x0
// Checksum 0x6456fac7, Offset: 0x3920
// Size: 0x4a
function function_2b2c09db(weapon, callback) {
    function_1f9441d7(weapon);
    level.specweapons[weapon.name].var_ec2a6a4c = callback;
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x0
// Checksum 0x62e17938, Offset: 0x3978
// Size: 0x4a
function function_5b0c227a(weapon, callback) {
    function_1f9441d7(weapon);
    level.specweapons[weapon.name].var_34f2424e = callback;
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x0
// Checksum 0xf4757579, Offset: 0x39d0
// Size: 0x4a
function function_b150f9ac(weapon, callback) {
    function_1f9441d7(weapon);
    level.specweapons[weapon.name].var_826b85e7 = callback;
}

// Namespace globallogic_score/globallogic_score
// Params 2, eflags: 0x0
// Checksum 0x69aa43d4, Offset: 0x3a28
// Size: 0x4a
function function_c1e9b86b(weapon, callback) {
    function_1f9441d7(weapon);
    level.specweapons[weapon.name].var_90e3cfd7 = callback;
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x1 linked
// Checksum 0x9264faed, Offset: 0x3a80
// Size: 0x18e
function function_d3ca3608(eventname) {
    assert(isdefined(eventname));
    if (!isdefined(level.scoreinfo[eventname]) || !isdefined(self) || !isplayer(self)) {
        return;
    }
    /#
        if (getdvarint(#"logscoreevents", 0) > 0) {
            if (!isdefined(level.var_10cd7193)) {
                level.var_10cd7193 = [];
            }
            eventstr = ishash(eventname) ? function_9e72a96(eventname) : eventname;
            if (!isdefined(level.var_10cd7193)) {
                level.var_10cd7193 = [];
            } else if (!isarray(level.var_10cd7193)) {
                level.var_10cd7193 = array(level.var_10cd7193);
            }
            level.var_10cd7193[level.var_10cd7193.size] = eventstr;
        }
    #/
    eventindex = level.scoreinfo[eventname][#"row"];
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x1 linked
// Checksum 0xf5b96538, Offset: 0x3c18
// Size: 0x6c
function function_61254438(weapon) {
    var_8725a10d = function_3cbc4c6c(weapon.var_2e4a8800);
    if (!isdefined(var_8725a10d) || !isdefined(var_8725a10d.var_14d1d5a1)) {
        return;
    }
    self function_d3ca3608(var_8725a10d.var_14d1d5a1);
}

// Namespace globallogic_score/globallogic_score
// Params 1, eflags: 0x1 linked
// Checksum 0x478a05db, Offset: 0x3c90
// Size: 0x6c
function allow_old_indexs(var_8d498080) {
    var_8725a10d = function_3cbc4c6c(var_8d498080.var_2e4a8800);
    if (!isdefined(var_8725a10d) || !isdefined(var_8725a10d.var_14d1d5a1)) {
        return;
    }
    self function_d3ca3608(var_8725a10d.var_14d1d5a1);
}

/#

    // Namespace globallogic_score/globallogic_score
    // Params 0, eflags: 0x0
    // Checksum 0x8451a608, Offset: 0x3d08
    // Size: 0x22e
    function function_bb9f3842() {
        level endon(#"game_ended");
        if (!isdefined(level.var_10cd7193)) {
            level.var_10cd7193 = [];
        }
        while (true) {
            if (getdvarint(#"dumpscoreevents", 0) > 0) {
                var_594354f3 = [];
                foreach (scoreevent in level.var_10cd7193) {
                    if (!isdefined(var_594354f3[scoreevent])) {
                        var_594354f3[scoreevent] = 0;
                    }
                    var_594354f3[scoreevent]++;
                }
                println("<dev string:x75>");
                foreach (var_d975dd49 in getarraykeys(var_594354f3)) {
                    count = var_594354f3[var_d975dd49];
                    println(var_d975dd49 + "<dev string:xcb>" + (isdefined(count) ? "<dev string:xd1>" + count : "<dev string:xd1>"));
                }
                println("<dev string:xd5>");
                setdvar(#"dumpscoreevents", 0);
            }
            waitframe(1);
        }
    }

#/
