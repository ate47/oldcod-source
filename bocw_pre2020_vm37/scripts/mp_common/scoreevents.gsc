#using script_7f6cd71c43c45c57;
#using scripts\abilities\ability_player;
#using scripts\core_common\activecamo_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\contracts_shared;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\weapons_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\mp_common\challenges;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\match;
#using scripts\mp_common\util;
#using scripts\weapons\weapon_utils;

#namespace scoreevents;

// Namespace scoreevents/scoreevents
// Params 0, eflags: 0x6
// Checksum 0x2019feae, Offset: 0x638
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"scoreevents", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace scoreevents/scoreevents
// Params 0, eflags: 0x5 linked
// Checksum 0x7f4218b3, Offset: 0x680
// Size: 0x44
function private function_70a657d8() {
    callback::on_start_gametype(&init);
    callback::on_spawned(&on_player_spawned);
}

// Namespace scoreevents/scoreevents
// Params 0, eflags: 0x1 linked
// Checksum 0xe7d1822d, Offset: 0x6d0
// Size: 0x64
function init() {
    level.scoreeventgameendcallback = &ongameend;
    registerscoreeventcallback("playerKilled", &scoreeventplayerkill);
    status_effect::function_7505baeb(&function_4013aee1);
}

// Namespace scoreevents/scoreevents
// Params 2, eflags: 0x1 linked
// Checksum 0xb79a4b48, Offset: 0x740
// Size: 0x152
function function_4013aee1(status_effect, var_3bc85d80) {
    if (!isdefined(status_effect.var_4b22e697) || status_effect.var_4b22e697 == status_effect.owner || !isdefined(status_effect.var_3d1ed4bd)) {
        return;
    }
    switch (status_effect.setype) {
    case 2:
        if (var_3bc85d80 == "begin") {
            if (status_effect.var_3d1ed4bd == getweapon(#"concussion_grenade")) {
                processscoreevent(#"concussed_enemy", status_effect.var_4b22e697, status_effect.owner, status_effect.var_3d1ed4bd);
                status_effect.var_4b22e697.var_9d19aa30 = (isdefined(status_effect.var_4b22e697.var_9d19aa30) ? status_effect.var_4b22e697.var_9d19aa30 : 0) + 1;
                break;
            }
        }
    default:
        break;
    }
}

// Namespace scoreevents/scoreevents
// Params 0, eflags: 0x1 linked
// Checksum 0x1194e65f, Offset: 0x8a0
// Size: 0x54
function on_player_spawned() {
    self player_spawned();
    self thread function_dcdf1105();
    self callback::on_weapon_change(&on_weapon_change);
}

// Namespace scoreevents/scoreevents
// Params 1, eflags: 0x5 linked
// Checksum 0xcb56292b, Offset: 0x900
// Size: 0x1de
function private on_weapon_change(params) {
    if (!isdefined(params.weapon) || !isweapon(params.weapon) || !isdefined(params.last_weapon) || !isweapon(params.last_weapon) || !isdefined(self) || !isplayer(self)) {
        return;
    }
    var_86ecd1f2 = weapons::getbaseweapon(params.weapon);
    var_b577d267 = weapons::getbaseweapon(params.last_weapon);
    if (!isdefined(var_86ecd1f2) || !isdefined(var_b577d267) || var_86ecd1f2 == var_b577d267) {
        return;
    }
    if (var_86ecd1f2.var_76ce72e8 === 1 || var_86ecd1f2.issignatureweapon === 1 || var_86ecd1f2.name == #"none") {
        return;
    }
    if (var_b577d267.var_76ce72e8 === 1 || var_b577d267.issignatureweapon === 1 || var_b577d267.name == #"none") {
        return;
    }
    if (isdefined(killstreaks::get_from_weapon(var_86ecd1f2)) || isdefined(killstreaks::get_from_weapon(var_b577d267))) {
        return;
    }
    self.var_6f3f5189 = gettime();
}

// Namespace scoreevents/scoreevents
// Params 2, eflags: 0x0
// Checksum 0x4905d075, Offset: 0xae8
// Size: 0x52
function scoreeventtablelookupint(index, scoreeventcolumn) {
    return int(tablelookup(getscoreeventtablename(), 0, index, scoreeventcolumn));
}

// Namespace scoreevents/scoreevents
// Params 2, eflags: 0x0
// Checksum 0x658db3e6, Offset: 0xb48
// Size: 0x42
function scoreeventtablelookup(index, scoreeventcolumn) {
    return tablelookup(getscoreeventtablename(), 0, index, scoreeventcolumn);
}

// Namespace scoreevents/scoreevents
// Params 2, eflags: 0x1 linked
// Checksum 0x80ddb926, Offset: 0xb98
// Size: 0x3d2c
function scoreeventplayerkill(data, time) {
    victim = data.victim;
    if (!isdefined(victim)) {
        return;
    }
    attacker = data.attacker;
    if (!isdefined(attacker) || !isplayer(attacker)) {
        return;
    }
    time = data.time;
    level.numkills++;
    attacker.lastkilledplayer = victim;
    wasdefusing = data.wasdefusing;
    wasplanting = data.wasplanting;
    victimwasonground = data.victimonground;
    attackerwasonground = data.attackeronground;
    meansofdeath = data.smeansofdeath;
    attackertraversing = data.attackertraversing;
    attackersliding = data.attackersliding;
    var_406186a6 = data.var_406186a6;
    attackerspeedburst = data.attackerspeedburst;
    victimspeedburst = data.victimspeedburst;
    victimcombatefficieny = data.victimcombatefficieny;
    victimspeedburstlastontime = data.victimspeedburstlastontime;
    victimcombatefficiencylastontime = data.victimcombatefficiencylastontime;
    victimvisionpulseactivatetime = data.victimvisionpulseactivatetime;
    attackervisionpulseactivatetime = data.attackervisionpulseactivatetime;
    attackervisionpulsearray = data.attackervisionpulsearray;
    victimvisionpulsearray = data.victimvisionpulsearray;
    attackervisionpulseoriginarray = data.attackervisionpulseoriginarray;
    victimvisionpulseoriginarray = data.victimvisionpulseoriginarray;
    attackervisionpulseorigin = data.attackervisionpulseorigin;
    victimvisionpulseorigin = data.victimvisionpulseorigin;
    victimlastvisionpulsedby = data.victimlastvisionpulsedby;
    victimlastvisionpulsedtime = data.victimlastvisionpulsedtime;
    var_31d0fbf5 = data.var_31d0fbf5;
    attackerwasflashed = data.attackerwasflashed;
    attackerwasconcussed = data.attackerwasconcussed;
    victimwasunderwater = data.wasunderwater;
    victimheroabilityactive = data.victimheroabilityactive;
    victimheroability = data.victimheroability;
    attackerheroabilityactive = data.attackerheroabilityactive;
    attackerheroability = data.attackerheroability;
    attackerwasheatwavestunned = data.attackerwasheatwavestunned;
    victimwasheatwavestunned = data.victimwasheatwavestunned;
    victimelectrifiedby = data.victimelectrifiedby;
    victimwasinslamstate = data.victimwasinslamstate;
    victimbledout = data.bledout;
    victimwaslungingwitharmblades = data.victimwaslungingwitharmblades;
    var_9fb5719b = data.var_9fb5719b;
    victimpowerarmorlasttookdamagetime = data.victimpowerarmorlasttookdamagetime;
    victimgadgetpower = data.victimgadgetpower;
    victimgadgetwasactivelastdamage = data.victimgadgetwasactivelastdamage;
    victimisthieforroulette = data.victimisthieforroulette;
    attackerisroulette = data.attackerisroulette;
    victimheroabilityname = data.victimheroabilityname;
    var_64aaf8ac = data.var_64aaf8ac;
    var_78056843 = data.var_78056843;
    var_4f6eb670 = data.var_4f6eb670;
    var_cf13980c = data.var_cf13980c;
    var_7117b104 = data.var_7117b104;
    var_989b2258 = data.var_989b2258;
    var_893d5683 = data.var_893d5683;
    var_ab4f5741 = data.var_ab4f5741;
    var_504c7a2f = data.var_504c7a2f;
    var_7006e4f4 = data.var_7006e4f4;
    var_af1b39cb = data.var_af1b39cb;
    var_e020b97e = data.var_e020b97e;
    var_c3f8aa38 = data.var_ac7c0ef7;
    var_a79760b1 = data.var_a79760b1;
    var_dd195b6b = data.var_dd195b6b;
    var_31310133 = data.var_31310133;
    var_a99236f2 = data.var_a99236f2;
    var_9084d6e = data.var_9084d6e;
    var_157f4d3b = data.var_157f4d3b;
    var_f048a359 = data.var_f048a359;
    attacker.var_a7f5c61e = data.var_be469b25;
    var_5fa4aeed = data.var_5fa4aeed;
    if (level.lastkilltime != time) {
        level.prevlastkilltime = level.lastkilltime;
        level.lastkilltime = time;
    }
    if (isdefined(victimheroabilityname)) {
        victimheroabilityequipped = getweapon(victimheroabilityname);
    }
    if (victimbledout == 1) {
        return;
    }
    exlosivedamage = 0;
    attackershotvictim = meansofdeath == "MOD_PISTOL_BULLET" || meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_HEAD_SHOT";
    weapon = level.weaponnone;
    inflictor = data.einflictor;
    isgrenade = 0;
    if (isdefined(data.weapon)) {
        weapon = data.weapon;
        weaponclass = util::getweaponclass(data.weapon);
        isgrenade = weapon.isgrenadeweapon;
        killstreak = killstreaks::get_from_weapon(data.weapon);
    }
    victim.anglesondeath = victim getplayerangles();
    if (meansofdeath == "MOD_GRENADE" || meansofdeath == "MOD_GRENADE_SPLASH" || meansofdeath == "MOD_EXPLOSIVE" || meansofdeath == "MOD_EXPLOSIVE_SPLASH" || meansofdeath == "MOD_PROJECTILE" || meansofdeath == "MOD_PROJECTILE_SPLASH") {
        if (weapon == level.weaponnone && isdefined(data.victim.explosiveinfo[#"weapon"])) {
            weapon = data.victim.explosiveinfo[#"weapon"];
        }
        exlosivedamage = 1;
    }
    attacker.cur_kill_streak++;
    if (attacker.cur_kill_streak % 5 == 0) {
        util::function_a3f7de13(18, attacker.team, attacker getentitynumber(), attacker.cur_kill_streak);
    }
    if (!isdefined(killstreak)) {
        if (level.teambased) {
            if (isdefined(victim.lastkilltime) && victim.lastkilltime > time - 3000) {
                if (isdefined(victim.lastkilledplayer) && victim.lastkilledplayer util::isenemyplayer(attacker) == 0 && attacker != victim.lastkilledplayer) {
                    processscoreevent(#"kill_enemy_who_killed_teammate", attacker, victim, weapon);
                    attacker activecamo::function_896ac347(weapon, #"avenger", 1);
                    attacker activecamo::function_896ac347(weapon, #"hash_39ab7cda18fd5c74", 1);
                    victim recordkillmodifier("avenger");
                }
            }
            if (isdefined(victim.damagedplayers) && isdefined(attacker) && isdefined(attacker.clientid)) {
                keys = getarraykeys(victim.damagedplayers);
                for (i = 0; i < keys.size; i++) {
                    key = keys[i];
                    if (!isdefined(key) || key === attacker.clientid) {
                        continue;
                    }
                    if (!isdefined(victim.damagedplayers[key].entity)) {
                        continue;
                    }
                    if (attacker util::isenemyplayer(victim.damagedplayers[key].entity)) {
                        continue;
                    }
                    if (time - victim.damagedplayers[key].time < 1000) {
                        processscoreevent(#"kill_enemy_injuring_teammate", attacker, victim, weapon);
                        if (isdefined(victim.damagedplayers[key].entity)) {
                            victim.damagedplayers[key].entity.lastrescuedby = attacker;
                            victim.damagedplayers[key].entity.lastrescuedtime = time;
                        }
                        victim recordkillmodifier("defender");
                    }
                }
            }
        }
        if (isgrenade == 0 || weapon.name == #"hero_gravityspikes") {
            if (attackersliding == 1) {
                processscoreevent(#"kill_enemy_while_sliding", attacker, victim, weapon);
            }
            if (attackertraversing == 1) {
                processscoreevent(#"traversal_kill", attacker, victim, weapon);
            }
            if (var_406186a6 && isdefined(attacker.var_3febb1e9) && isplayer(attacker.var_3febb1e9)) {
                if (attacker == attacker.var_3febb1e9) {
                    processscoreevent(#"stim_kill", attacker, victim, getweapon(#"eq_localheal"));
                } else {
                    processscoreevent(#"stim_assist", attacker.var_3febb1e9, victim, getweapon(#"eq_localheal"));
                }
            }
            if (attackerwasflashed) {
                processscoreevent(#"kill_enemy_while_flashbanged", attacker, victim, weapon);
            }
            if (victim.currentweapon.statname == #"sig_bow_flame") {
                processscoreevent(#"hash_6530935b474f2e11", attacker, victim, weapon);
            }
            if (attackerwasconcussed) {
                processscoreevent(#"kill_enemy_while_stunned", attacker, victim, weapon);
            }
            if (attackerwasheatwavestunned) {
                processscoreevent(#"kill_enemy_that_heatwaved_you", attacker, victim, weapon);
                attacker contracts::player_contract_event(#"killed_hero_ability_enemy");
            }
            if (victimwasheatwavestunned) {
                if (isdefined(victim._heat_wave_stunned_by) && isdefined(victim._heat_wave_stunned_by[attacker.clientid]) && victim._heat_wave_stunned_by[attacker.clientid] >= time) {
                    processscoreevent(#"heatwave_kill", attacker, victim, getweapon(#"gadget_heat_wave"));
                    attacker hero_ability_kill_event(getweapon(#"gadget_heat_wave"), get_equipped_hero_ability(victimheroabilityname));
                    attacker specialistmedalachievement();
                    attacker thread specialiststatabilityusage(4, 0);
                    if (!victimisthieforroulette && victimheroabilityname === "gadget_heat_wave") {
                        processscoreevent(#"kill_enemy_with_their_hero_ability", attacker, victim, getweapon(#"gadget_heat_wave"));
                    }
                }
                if (attackerisroulette && !victimisthieforroulette && victimheroabilityname === "gadget_heat_wave") {
                    processscoreevent(#"kill_enemy_with_their_hero_ability", attacker, victim, getweapon(#"gadget_heat_wave"));
                }
            }
        }
        if (isdefined(var_cf13980c)) {
            sensor = function_c01cb128(victim, var_cf13980c);
            if (isdefined(sensor)) {
                processscoreevent(#"sensor_dart_kill", attacker, victim, sensor.weapon);
            }
        } else if (isdefined(var_4f6eb670)) {
            sensor = function_c01cb128(victim, var_4f6eb670);
            if (isdefined(sensor)) {
                if (function_9aef690a(weapon)) {
                    processscoreevent(#"hash_1f661efe5e6707ad", var_78056843, victim, weapon);
                } else {
                    processscoreevent(#"sensor_dart_assist", var_78056843, victim, weapon);
                }
            }
        }
        if (var_9084d6e && isdefined(var_f048a359)) {
            if (var_f048a359 == getweapon(#"concussion_grenade")) {
                processscoreevent(#"concussion_kill", attacker, victim, getweapon(#"concussion_grenade"));
                if (attacker != var_157f4d3b) {
                    processscoreevent(#"assist_concussion", var_157f4d3b, victim, weapon);
                }
            }
        }
        if (weapon == getweapon(#"sig_buckler_turret") || weapon == getweapon(#"sig_buckler_dw")) {
            if (var_e020b97e && isdefined(var_af1b39cb) && var_af1b39cb == attacker) {
                processscoreevent(#"hash_63b75d5e59c12f69", attacker, victim, weapon);
            }
        } else if (var_e020b97e && !var_c3f8aa38 && isdefined(var_af1b39cb) && var_af1b39cb == attacker) {
            processscoreevent(#"swat_grenade_kill_blinded_enemy", attacker, victim, weapon);
        }
        if (isdefined(attacker.var_121392a1) && isarray(attacker.var_121392a1)) {
            foreach (effect in attacker.var_121392a1) {
                if (!isdefined(effect) || !isdefined(effect.var_3d1ed4bd) || !isweapon(effect.var_3d1ed4bd)) {
                    continue;
                }
                if (effect.var_3d1ed4bd == getweapon(#"hash_3f62a872201cd1ce") || effect.var_3d1ed4bd == getweapon(#"seeker_mine_arc") || effect.var_3d1ed4bd == getweapon(#"eq_slow_grenade")) {
                    processscoreevent(#"hash_61640bd6bb7451ad", attacker, victim, effect.var_3d1ed4bd);
                    break;
                }
            }
        }
        if (attackerspeedburst == 1) {
            processscoreevent(#"speed_burst_kill", attacker, victim, getweapon(#"gadget_speed_burst"));
            attacker hero_ability_kill_event(getweapon(#"gadget_speed_burst"), get_equipped_hero_ability(victimheroabilityname));
            attacker specialistmedalachievement();
            attacker thread specialiststatabilityusage(4, 0);
            if (attackerisroulette && !victimisthieforroulette && victimheroabilityname === "gadget_speed_burst") {
                processscoreevent(#"kill_enemy_with_their_hero_ability", attacker, victim, getweapon(#"gadget_speed_burst"));
            }
        }
        if (isdefined(attacker.var_6f3f5189) && attacker.var_6f3f5189 + 2000 >= time && !(weapon.var_76ce72e8 === 1)) {
            processscoreevent("kill_enemy_after_switching_weapons", attacker, victim, weapon);
        }
        if (victimspeedburstlastontime > time - 50) {
            processscoreevent(#"kill_enemy_who_is_speedbursting", attacker, victim, weapon);
            attacker contracts::player_contract_event(#"killed_hero_ability_enemy");
        }
        if (victimcombatefficiencylastontime > time - 50) {
            processscoreevent(#"kill_enemy_who_is_using_focus", attacker, victim, weapon);
            attacker contracts::player_contract_event(#"killed_hero_ability_enemy");
        }
        if (victimwasinslamstate) {
            attacker contracts::player_contract_event(#"killed_hero_weapon_enemy");
        }
        if (challenges::ishighestscoringplayer(victim)) {
            processscoreevent(#"kill_enemy_who_has_high_score", attacker, victim, weapon);
            attacker activecamo::function_896ac347(weapon, #"kingslayer", 1);
            attacker activecamo::function_896ac347(weapon, #"hash_39ab7cda18fd5c74", 1);
            attacker contracts::increment_contract(#"hash_a75db3f2b544591");
        }
        if (victimwasunderwater && exlosivedamage) {
            processscoreevent(#"kill_underwater_enemy_explosive", attacker, victim, weapon);
        }
        if (var_5fa4aeed && isdefined(victim.lastattackedshieldplayer) && victim.lastattackedshieldplayer == attacker) {
            processscoreevent(#"hash_7c2d800a84be69a2", attacker, victim, weapon);
        }
        if (isdefined(victimelectrifiedby) && victimelectrifiedby != attacker) {
            processscoreevent(#"electrified", victimelectrifiedby, victim, weapon);
        }
        if (victimvisionpulseactivatetime != 0 && victimvisionpulseactivatetime > time - 4000) {
            for (i = 0; i < victimvisionpulsearray.size; i++) {
                player = victimvisionpulsearray[i];
                if (player == attacker) {
                    if (victimvisionpulseactivatetime + 300 > time - level.var_2e3031be.gadget_pulse_duration) {
                        distancetopulse = distance(victimvisionpulseoriginarray[i], victimvisionpulseorigin);
                        ratio = distancetopulse / level.var_2e3031be.gadget_pulse_max_range;
                        timing = ratio * level.var_2e3031be.gadget_pulse_duration;
                        if (victimvisionpulseactivatetime + 300 > time - timing) {
                            break;
                        }
                    }
                    processscoreevent(#"vision_pulse_shutdown", attacker, victim, weapon);
                    attacker activecamo::function_896ac347(weapon, #"showstopper", 1);
                    attacker contracts::player_contract_event(#"killed_hero_ability_enemy");
                    break;
                }
            }
            if (isdefined(victimheroability)) {
                attacker notify(#"hero_shutdown", {#gadget:victimheroability});
                attacker notify(#"hero_shutdown_gadget", {#gadget:victimheroability, #victim:victim});
            }
        }
        if (victimlastvisionpulsedtime != 0 && victimlastvisionpulsedtime > time - level.var_2e3031be.var_9d776ba6) {
            if (isdefined(victimlastvisionpulsedby) && attacker != victimlastvisionpulsedby && attacker util::isenemyplayer(victimlastvisionpulsedby) == 0) {
                if (function_9aef690a(weapon)) {
                    processscoreevent(#"hash_bad79b50f40ce0b", victimlastvisionpulsedby, victim, level.var_2e3031be);
                } else {
                    processscoreevent(#"vision_pulse_assist", victimlastvisionpulsedby, victim, level.var_2e3031be);
                }
                processscoreevent(#"hash_6d41ba237c04cb10", attacker, victim, weapon);
            } else {
                attacker hero_ability_kill_event(level.var_2e3031be, get_equipped_hero_ability(victimheroabilityname));
                attacker specialistmedalachievement();
                attacker thread specialiststatabilityusage(4, 0);
                if (attackerisroulette && !victimisthieforroulette && victimheroabilityname === "gadget_vision_pulse") {
                    processscoreevent(#"kill_enemy_with_their_hero_ability", attacker, victim, level.var_2e3031be);
                }
            }
            if (isdefined(victimlastvisionpulsedby)) {
                victimlastvisionpulsedby.visionpulsekill = (isdefined(victimlastvisionpulsedby.visionpulsekill) ? victimlastvisionpulsedby.visionpulsekill : 0) + 1;
            }
        }
        if (isdefined(var_989b2258)) {
            processscoreevent(#"sticky_kill", attacker, victim, getweapon(#"eq_breachlauncher"));
        } else if (weapon == getweapon(#"eq_breachlauncher") && meansofdeath == "MOD_EXPLOSIVE") {
            processscoreevent(#"shrapnel_kill", attacker, victim, weapon);
        }
        if (isdefined(var_ab4f5741) && var_ab4f5741 === 1) {
            foreach (var_69162b32 in victim._gadgets_player) {
                if (var_69162b32 == getweapon(#"mute_smoke")) {
                    processscoreevent(#"hash_438160ef75ca2ea", attacker, victim, weapon);
                    break;
                }
            }
            if (weapon == getweapon(#"eq_arm_blade")) {
                processscoreevent(#"hash_1e657ba6178ae2c6", attacker, victim, weapon);
            }
            if (isdefined(var_7006e4f4) && var_504c7a2f == 1) {
                if (var_7006e4f4 == attacker) {
                    processscoreevent(#"hash_3d3467f13cf43727", attacker, victim, getweapon(#"mute_smoke"));
                } else {
                    processscoreevent(#"hash_5a52344f66f68864", var_7006e4f4, victim, weapon);
                }
            }
        }
        if (isdefined(var_a99236f2)) {
            if (attacker == var_a99236f2) {
                processscoreevent(#"hash_6dee98175676f663", attacker, victim, weapon);
            } else {
                processscoreevent(#"suppression_assist", var_a99236f2, victim, weapon);
            }
        }
        if (is_true(attacker.var_a7f5c61e)) {
            if (weapon != getweapon(#"eq_gravityslam") && gettime() > (isdefined(attacker.var_5069fdec) ? attacker.var_5069fdec : int(-30 * 1000)) + int(30 * 1000)) {
                attacker.var_5069fdec = gettime();
            }
            processscoreevent(#"grapple_gun_kill", attacker, victim, weapon);
        }
        if (weapon == getweapon(#"eq_gravityslam")) {
            processscoreevent(#"gravity_slam_kill", attacker, victim, weapon);
        }
        if (victimheroabilityactive && isdefined(victimheroability)) {
            attacker notify(#"hero_shutdown", {#gadget:victimheroability});
            attacker notify(#"hero_shutdown_gadget", {#gadget:victimheroability, #victim:victim});
            switch (victimheroability.name) {
            case #"gadget_armor":
                processscoreevent(#"kill_enemy_who_has_powerarmor", attacker, victim, weapon);
                attacker contracts::player_contract_event(#"killed_hero_ability_enemy");
                break;
            case #"gadget_resurrect":
                processscoreevent(#"kill_enemy_that_used_resurrect", attacker, victim, weapon);
                attacker contracts::player_contract_event(#"killed_hero_ability_enemy");
                break;
            case #"gadget_camo":
                processscoreevent(#"kill_enemy_that_is_using_optic_camo", attacker, victim, weapon);
                attacker contracts::player_contract_event(#"killed_hero_ability_enemy");
                break;
            case #"gadget_clone":
                processscoreevent(#"end_enemy_psychosis", attacker, victim, weapon);
                attacker contracts::player_contract_event(#"killed_hero_ability_enemy");
                break;
            }
        } else if (isdefined(victimpowerarmorlasttookdamagetime) && time - victimpowerarmorlasttookdamagetime <= 3000) {
            attacker notify(#"hero_shutdown", {#gadget:victimheroability});
            attacker notify(#"hero_shutdown_gadget", {#gadget:victimheroability, #victim:victim});
            processscoreevent(#"kill_enemy_who_has_powerarmor", attacker, victim, weapon);
            attacker contracts::player_contract_event(#"killed_hero_ability_enemy");
        }
        if (isdefined(data.victimweapon) && data.victimweapon.isheavyweapon) {
            attacker notify(#"heavy_shutdown", {#weapon:data.victimweapon});
            attacker notify(#"heavy_shutdown_gadget", {#weapon:data.victimweapon, #victim:victim});
        } else if (isdefined(victim.heavyweapon) && isdefined(victimgadgetpower) && victimgadgetwasactivelastdamage === 1 && victimgadgetpower < 100) {
            attacker notify(#"heavy_shutdown", {#weapon:victim.heavyweapon});
            attacker notify(#"heavy_shutdown_gadget", {#weapon:victim.heavyweapon, #victim:victim});
        }
        if (attackerheroabilityactive && isdefined(attackerheroability)) {
            abilitytocheck = undefined;
            switch (attackerheroability.name) {
            case #"gadget_armor":
                processscoreevent(#"power_armor_kill", attacker, victim, getweapon(#"gadget_armor"));
                attacker hero_ability_kill_event(attackerheroability, get_equipped_hero_ability(victimheroabilityname));
                attacker specialistmedalachievement();
                attacker thread specialiststatabilityusage(4, 0);
                abilitytocheck = attackerheroability.name;
                break;
            case #"gadget_resurrect":
                processscoreevent(#"resurrect_kill", attacker, victim, getweapon(#"gadget_resurrect"));
                attacker hero_ability_kill_event(attackerheroability, get_equipped_hero_ability(victimheroabilityname));
                attacker specialistmedalachievement();
                attacker thread specialiststatabilityusage(4, 0);
                abilitytocheck = attackerheroability.name;
                break;
            case #"gadget_camo":
                processscoreevent(#"optic_camo_kill", attacker, victim, getweapon(#"gadget_camo"));
                attacker hero_ability_kill_event(attackerheroability, get_equipped_hero_ability(victimheroabilityname));
                attacker specialistmedalachievement();
                attacker thread specialiststatabilityusage(4, 0);
                abilitytocheck = attackerheroability.name;
                break;
            case #"gadget_clone":
                processscoreevent(#"kill_enemy_while_using_psychosis", attacker, victim, getweapon(#"gadget_clone"));
                attacker hero_ability_kill_event(attackerheroability, get_equipped_hero_ability(victimheroabilityname));
                attacker specialistmedalachievement();
                attacker thread specialiststatabilityusage(4, 0);
                abilitytocheck = attackerheroability.name;
                break;
            }
            if (attackerisroulette && !victimisthieforroulette && isdefined(abilitytocheck) && victimheroabilityname === abilitytocheck) {
                processscoreevent(#"kill_enemy_with_their_hero_ability", attacker, victim, weapon);
            }
        }
        if (victimwaslungingwitharmblades) {
            processscoreevent(#"end_enemy_armblades_attack", attacker, victim, weapon);
        }
        if (var_9fb5719b) {
            processscoreevent(#"hash_300c1c6babed2cb3", attacker, victim, weapon);
        }
        if (isdefined(data.victimweapon)) {
            killedheavyweaponenemy(attacker, victim, weapon, data.victimweapon, victimgadgetpower);
            if (data.victimweapon.statindex == level.weapon_sig_minigun.statindex) {
                processscoreevent(#"hash_3988d3aa940f2e77", attacker, victim, weapon);
            } else if (data.victimweapon.name == "m32") {
                processscoreevent(#"killed_multiple_grenade_launcher_enemy", attacker, victim, weapon);
            }
        }
        if (weapon.statname == #"frag_grenade") {
            attacker stats::function_dad108fa(#"kills_frag_grenade", 1);
        } else if (weapon.statname == #"eq_molotov") {
            attacker stats::function_dad108fa(#"kills_molotov", 1);
        }
        attacker thread updatemultikills(weapon, weaponclass, killstreak, victim);
        if (level.prevlastkilltime == 0 && attacker.prevlastkilltime == 0) {
            victim recordkillmodifier("firstblood");
            processscoreevent(#"first_kill", attacker, victim, weapon);
            level.var_8a3a9ca4.firstblood = gettime();
            attacker contracts::increment_contract(#"hash_61c7d530de491c8d");
            globallogic::function_3305e557(attacker, "firstBlood", 0);
            attacker function_1f86563a(attacker.pers[#"firstblood"]);
            util::function_a3f7de13(22, attacker.team, attacker getentitynumber());
        } else {
            if (isdefined(attacker.lastkilledby)) {
                if (attacker.lastkilledby == victim) {
                    level.globalpaybacks++;
                    processscoreevent(#"revenge_kill", attacker, victim, weapon);
                    attacker stats::function_e24eec31(weapon, #"revenge_kill", 1);
                    attacker activecamo::function_896ac347(weapon, #"revenge", 1);
                    attacker activecamo::function_896ac347(weapon, #"hash_39ab7cda18fd5c74", 1);
                    victim recordkillmodifier("revenge");
                    attacker.lastkilledby = undefined;
                }
            }
            if (victim killstreaks::function_4a1fb0f()) {
                level.globalbuzzkills++;
                processscoreevent(#"stop_enemy_killstreak", attacker, victim, weapon);
                attacker activecamo::function_896ac347(weapon, #"buzzkill", 1);
                attacker activecamo::function_896ac347(weapon, #"hash_39ab7cda18fd5c74", 1);
                victim recordkillmodifier("buzzkill");
            }
            if (isdefined(victim.lastmansd) && victim.lastmansd == 1) {
                processscoreevent(#"final_kill_elimination", attacker, victim, weapon);
                if (isdefined(attacker.lastmansd) && attacker.lastmansd == 1) {
                    processscoreevent(#"elimination_and_last_player_alive", attacker, victim, weapon);
                }
            }
        }
        if (is_weapon_valid(meansofdeath, weapon, weaponclass, killstreak)) {
            if (isdefined(victim.vattackerorigin)) {
                attackerorigin = victim.vattackerorigin;
            } else {
                attackerorigin = attacker.origin;
            }
            disttovictim = distancesquared(victim.origin, attackerorigin);
            weap_min_dmg_range = get_distance_for_weapon(weapon, weaponclass);
            if (disttovictim > weap_min_dmg_range) {
                attacker challenges::longdistancekillmp(weapon, meansofdeath);
                if (weapon.rootweapon.name == "hatchet") {
                    attacker challenges::longdistancehatchetkill();
                }
                processscoreevent(#"longshot_kill", attacker, victim, weapon);
                attacker contracts::increment_contract(#"contract_mp_longshot");
                attacker.pers[#"longshots"]++;
                victim recordkillmodifier("longshot");
                if (isdefined(attacker.var_ea1458aa)) {
                    if (!isdefined(attacker.var_ea1458aa.longshot_kills)) {
                        attacker.var_ea1458aa.longshot_kills = 0;
                    }
                    attacker.var_ea1458aa.longshot_kills++;
                    if (attacker.var_ea1458aa.longshot_kills % 3 == 0) {
                        attacker stats::function_dad108fa(#"longshot_3_onelife", 1);
                    }
                }
            }
            killdistance = distance(victim.origin, attackerorigin);
            attacker.pers[#"kill_distances"] = attacker.pers[#"kill_distances"] + killdistance;
            attacker.pers[#"num_kill_distance_entries"]++;
            if (weaponclass == "weapon_sniper") {
                globallogic::function_3305e557(attacker, "sniperKills", 0);
                attacker function_f4445d12(attacker.pers[#"sniperkills"]);
            }
        }
        if (isalive(attacker)) {
            if (attacker.health < attacker.maxhealth * 0.35) {
                attacker.lastkillwheninjured = time;
                processscoreevent(#"kill_enemy_when_injured", attacker, victim, weapon);
                attacker stats::function_e24eec31(weapon, #"kill_enemy_when_injured", 1);
                if (attacker util::has_toughness_perk_purchased_and_equipped()) {
                    attacker stats::function_dad108fa(#"perk_bulletflinch_kills", 1);
                }
            }
        } else if (isdefined(attacker.deathtime) && attacker.deathtime + 800 < time && !attacker isinvehicle()) {
            level.globalafterlifes++;
            processscoreevent(#"kill_enemy_after_death", attacker, victim, weapon);
            victim recordkillmodifier("posthumous");
        }
        if (isdefined(attacker.cur_death_streak) && attacker.cur_death_streak >= 3) {
            level.globalcomebacks++;
            processscoreevent(#"comeback_from_deathstreak", attacker, victim, weapon);
            victim recordkillmodifier("comeback");
        }
        if (isdefined(victim.lastmicrowavedby)) {
            foreach (beingmicrowavedby in victim.beingmicrowavedby) {
                if (isdefined(beingmicrowavedby) && attacker util::isenemyplayer(beingmicrowavedby) == 0) {
                    if (beingmicrowavedby != attacker) {
                        scoregiven = processscoreevent(#"microwave_turret_assist", beingmicrowavedby, victim, weapon);
                        if (isdefined(scoregiven)) {
                            beingmicrowavedby challenges::earnedmicrowaveassistscore(scoregiven);
                        }
                        continue;
                    }
                    attackermicrowavedvictim = 1;
                }
            }
            if (attackermicrowavedvictim === 1 && weapon.name != "microwave_turret") {
                attacker challenges::killwhiledamagingwithhpm();
                processscoreevent(#"microwave_turret_kill", beingmicrowavedby, victim, weapon);
                attacker function_be7a08a8(weapon, 1);
            }
        }
        if (weapons::ismeleemod(meansofdeath) && !weapon.isriotshield) {
            attacker.pers[#"stabs"]++;
            attacker.stabs = attacker.pers[#"stabs"];
            vangles = victim.anglesondeath[1];
            pangles = attacker.anglesonkill[1];
            anglediff = angleclamp180(vangles - pangles);
            if (is_true(weapon.var_cfc07f04) && anglediff > -30 && anglediff < 70) {
                level.globalbackstabs++;
                processscoreevent(#"backstabber_kill", attacker, victim, weapon);
                var_1c73f975 = 1;
                weaponpickedup = 0;
                if (isdefined(attacker.pickedupweapons) && isdefined(attacker.pickedupweapons[weapon])) {
                    weaponpickedup = 1;
                }
                attacker stats::function_eec52333(weapon, #"backstabber_kill", 1, attacker.class_num, weaponpickedup);
                attacker.pers[#"backstabs"]++;
            } else if (!is_true(weapon.var_cfc07f04) && (anglediff < -30 || anglediff > 70 || is_true(victim.laststand))) {
                if (meansofdeath == "MOD_MELEE_WEAPON_BUTT" && weapon.name != "ball") {
                    processscoreevent(#"kill_enemy_with_gunbutt", attacker, victim, weapon);
                } else if (weapons::ispunch(weapon)) {
                    processscoreevent(#"kill_enemy_with_fists", attacker, victim, weapon);
                }
            }
        } else if (isdefined(victim.firsttimedamaged) && victim.firsttimedamaged == time && (weapon.statindex == level.weapon_hero_annihilator.statindex || weapon.inventorytype != "ability")) {
            if (attackershotvictim) {
                attacker thread updateoneshotmultikills(victim, weapon, victim.firsttimedamaged, meansofdeath);
                attacker stats::function_e24eec31(weapon, #"kill_enemy_one_bullet", 1);
            }
        }
        if (isdefined(victim.var_d6f11c60) && attacker == victim.var_d6f11c60 && victim.var_e6c1bab8 + 2000 > gettime()) {
            var_21877ec1 = 1;
        } else if (meansofdeath == "MOD_HEAD_SHOT" && (isdefined(victim.armor) ? victim.armor : 0) > 0) {
            var_21877ec1 = 1;
        }
        if (is_true(var_21877ec1)) {
            processscoreevent(#"kill_enemy_with_armor", attacker, victim, weapon);
        }
        assert(isdefined(attacker));
        assert(isdefined(attacker.tookweaponfrom), "<dev string:x38>" + attacker getentnum() + "<dev string:x43>");
        if (isdefined(attacker) && isdefined(attacker.tookweaponfrom) && isdefined(attacker.tookweaponfrom[weapon]) && isdefined(attacker.tookweaponfrom[weapon].previousowner)) {
            pickedupweapon = attacker.tookweaponfrom[weapon];
            if (pickedupweapon.previousowner == victim) {
                processscoreevent(#"kill_enemy_with_their_weapon", attacker, victim, weapon);
                attacker stats::function_e24eec31(weapon, #"kill_enemy_with_their_weapon", 1);
                if (isdefined(pickedupweapon.weapon) && isdefined(pickedupweapon.smeansofdeath) && weapons::ismeleemod(pickedupweapon.smeansofdeath)) {
                    foreach (meleeweapon in level.meleeweapons) {
                        if (weapon != meleeweapon && pickedupweapon.weapon.rootweapon == meleeweapon) {
                            attacker stats::function_e24eec31(meleeweapon, #"kill_enemy_with_their_weapon", 1);
                            break;
                        }
                    }
                }
            }
        }
        if (wasdefusing) {
            processscoreevent(#"killed_bomb_defuser", attacker, victim, weapon);
        } else if (wasplanting) {
            processscoreevent(#"killed_bomb_planter", attacker, victim, weapon);
        }
        heavyweaponkill(attacker, victim, weapon);
    }
    specificweaponkill(attacker, victim, weapon, killstreak, inflictor);
    if (isdefined(level.vtol) && isdefined(level.vtol.owner)) {
        attacker stats::function_dad108fa(#"kill_as_support_gunner", 1);
        processscoreevent(#"mothership_assist_kill", level.vtol.owner, victim, weapon);
    }
    if (isdefined(var_7117b104) && time - var_7117b104 < 5300) {
        processscoreevent(#"alarm_kill", attacker, victim, weapon);
    }
    if (isdefined(data.var_c274d62f) && data.var_c274d62f) {
    }
    switch (weapon.rootweapon.name) {
    case #"hatchet":
        attacker.pers[#"tomahawks"]++;
        attacker contracts::increment_contract(#"hash_172456fa969d6c82");
        if (isdefined(data.victim.explosiveinfo[#"projectile_bounced"]) && data.victim.explosiveinfo[#"projectile_bounced"] == 1) {
            level.globalbankshots++;
            processscoreevent(#"bounce_hatchet_kill", attacker, victim, weapon);
            attacker contracts::increment_contract(#"contract_mp_bankshot");
        }
        break;
    case #"supplydrop":
    case #"inventory_supplydrop":
    case #"supplydrop_marker":
    case #"inventory_supplydrop_marker":
        if (meansofdeath == "MOD_HIT_BY_OBJECT" || meansofdeath == "MOD_CRUSH") {
            processscoreevent(#"kill_enemy_with_care_package_crush", attacker, victim, weapon);
        } else if (isdefined(inflictor.hacker)) {
            processscoreevent(#"kill_enemy_with_hacked_care_package", attacker, victim, weapon);
        } else {
            processscoreevent(#"hash_30fbe29e8c1237da", attacker, victim, weapon);
        }
        break;
    }
    if (isdefined(killstreak)) {
        attacker thread updatemultikills(weapon, weaponclass, killstreak, victim);
        victim recordkillmodifier("killstreak");
    }
    if (isdefined(level.var_5be42934)) {
        attacker [[ level.var_5be42934 ]](data);
    }
    attacker.cur_death_streak = 0;
    attacker disabledeathstreak();
}

// Namespace scoreevents/scoreevents
// Params 1, eflags: 0x1 linked
// Checksum 0x57ffa0e0, Offset: 0x48d0
// Size: 0x2a
function get_equipped_hero_ability(ability_name) {
    if (!isdefined(ability_name)) {
        return undefined;
    }
    return getweapon(ability_name);
}

// Namespace scoreevents/scoreevents
// Params 3, eflags: 0x1 linked
// Checksum 0xba2e13f0, Offset: 0x4908
// Size: 0x28c
function heavyweaponkill(attacker, victim, weapon) {
    if (!isdefined(weapon)) {
        return;
    }
    switch (weapon.name) {
    case #"hero_minigun":
        event = "minigun_kill";
        break;
    case #"hero_flamethrower":
        event = "flamethrower_kill";
        break;
    case #"hero_lightninggun":
    case #"hero_lightninggun_arc":
        event = "tempest_kill";
        break;
    case #"hero_firefly_swarm":
    case #"hero_chemicalgelgun":
        event = "gelgun_kill";
        break;
    case #"hero_bowlauncher2":
    case #"hero_bowlauncher3":
    case #"hero_bowlauncher4":
    case #"hero_bowlauncher":
    case #"sig_bow_flame":
    case #"hash_6653bba8043d03f6":
    case #"hash_6653bca8043d05a9":
    case #"hash_6653bda8043d075c":
    case #"hash_6653bea8043d090f":
        event = "bowlauncher_kill";
        break;
    case #"sig_minigun_alt":
    case #"sig_minigun":
    case #"hash_5a34a2f4b8c715c0":
    case #"hash_5a34aef4b8c72a24":
    case #"hash_5a382ef4b8ca397b":
    case #"hash_5a3832f4b8ca4047":
    case #"hash_5a492ef4b8d8acae":
    case #"hash_5a4932f4b8d8b37a":
        if (attacker function_a867284b() && attacker playerads() == 1) {
            event = "mounted_kill";
        } else {
            event = "minigun_kill";
        }
        break;
    default:
        return;
    }
    processscoreevent(event, attacker, victim, weapon);
}

// Namespace scoreevents/scoreevents
// Params 5, eflags: 0x1 linked
// Checksum 0x42e73594, Offset: 0x4ba0
// Size: 0x19c
function killedheavyweaponenemy(attacker, victim, weapon, victim_weapon, victim_gadget_power) {
    if (!isdefined(victim_weapon)) {
        return;
    }
    if (!isdefined(victim_gadget_power)) {
        return;
    }
    if (victim_gadget_power >= 100) {
        return;
    }
    switch (victim_weapon.name) {
    case #"hero_minigun":
        event = "killed_minigun_enemy";
        break;
    case #"hero_flamethrower":
        event = "killed_flamethrower_enemy";
        break;
    case #"hero_lightninggun":
    case #"hero_lightninggun_arc":
        event = "tempest_shutdown";
        break;
    case #"hero_chemicalgelgun":
        event = "killed_gelgun_enemy";
        break;
    case #"hero_bowlauncher2":
    case #"hero_bowlauncher3":
    case #"hero_bowlauncher4":
    case #"hero_bowlauncher":
        event = "killed_bowlauncher_enemy";
        break;
    default:
        return;
    }
    processscoreevent(event, attacker, victim, weapon);
    attacker contracts::player_contract_event(#"killed_hero_weapon_enemy");
}

// Namespace scoreevents/scoreevents
// Params 5, eflags: 0x1 linked
// Checksum 0x8f1a291b, Offset: 0x4d48
// Size: 0x384
function specificweaponkill(attacker, victim, weapon, killstreak, inflictor) {
    switchweapon = weapon.name;
    if (isdefined(killstreak)) {
        switchweapon = killstreak;
        bundle = killstreaks::get_script_bundle(killstreak);
    }
    switch (switchweapon) {
    case #"eq_arm_blade":
        event = "blade_kill";
        break;
    case #"autoturret":
    case #"inventory_autoturret":
        event = "sentry_gun_kill";
        break;
    case #"tank_robot":
    case #"tank_robot_launcher_turret":
        event = "tank_robot_kill";
        if (is_true(attacker.var_5f28922a)) {
            attacker stats::function_dad108fa(#"kill_with_controlled_ai_tank", 1);
        }
        break;
    case #"microwave_turret":
    case #"microwaveturret":
    case #"inventory_microwaveturret":
    case #"inventory_microwave_turret":
        event = "microwave_turret_kill";
        break;
    case #"combat_robot":
    case #"inventory_combat_robot":
        event = "combat_robot_kill";
        break;
    case #"claymore":
        event = "claymore_kill";
        break;
    case #"inventory_rcbomb":
    case #"rcbomb":
        event = "hover_rcxd_kill";
        break;
    case #"incendiary_fire":
        event = "thermite_kill";
        break;
    case #"eq_frag_gun":
        event = "frag_kill";
        break;
    case #"overwatch_helicopter":
        event = "overwatch_helicopter_kill";
        break;
    case #"swat_team":
        event = "swat_team_kill";
        break;
    default:
        return;
    }
    if (isdefined(inflictor)) {
        if (isdefined(inflictor.killstreak_id) && isdefined(level.matchrecorderkillstreakkills[inflictor.killstreak_id])) {
            level.matchrecorderkillstreakkills[inflictor.killstreak_id]++;
        } else if (isdefined(inflictor.killcament) && isdefined(inflictor.killcament.killstreak_id) && isdefined(level.matchrecorderkillstreakkills[inflictor.killcament.killstreak_id])) {
            level.matchrecorderkillstreakkills[inflictor.killcament.killstreak_id]++;
        }
    }
    processscoreevent(event, attacker, victim, weapon);
}

// Namespace scoreevents/scoreevents
// Params 2, eflags: 0x1 linked
// Checksum 0xc6d80b8a, Offset: 0x50d8
// Size: 0x174
function function_8fe4629e(killcount, weapon) {
    doublekill = int(killcount / 2);
    if (doublekill > 0) {
        self activecamo::function_896ac347(weapon, #"doublekill", doublekill);
    }
    triplekill = int(killcount / 3);
    if (triplekill > 0) {
        self activecamo::function_896ac347(weapon, #"triplekill", triplekill);
    }
    furykill = int(killcount / 4);
    if (furykill > 0) {
        self activecamo::function_896ac347(weapon, #"furykill", furykill);
    }
    pentakill = int(killcount / 5);
    if (pentakill > 0) {
        self activecamo::function_896ac347(weapon, #"pentakill", pentakill);
    }
}

// Namespace scoreevents/scoreevents
// Params 2, eflags: 0x1 linked
// Checksum 0xbf049ee5, Offset: 0x5258
// Size: 0x3e4
function multikill(killcount, weapon) {
    assert(killcount > 1);
    self challenges::multikill(killcount, weapon);
    if (killcount > 7) {
        processscoreevent(#"multikill_more_than_7", self, undefined, weapon);
    } else {
        processscoreevent(#"multikill_" + killcount, self, undefined, weapon);
    }
    if (isdefined(self.var_a95c605e) && isdefined(self.var_3e5d9e0f)) {
        if (self.var_a95c605e > 0 && self.var_3e5d9e0f > 0) {
            self stats::function_dad108fa(#"hash_1be224b059c35269", 1);
        }
    }
    if (killcount > 3) {
        util::function_a3f7de13(19, self.team, self getentitynumber(), killcount);
    }
    if (killcount > 2) {
        if (isdefined(self.challenge_objectivedefensivekillcount) && self.challenge_objectivedefensivekillcount > 0) {
            self.challenge_objectivedefensivetriplekillmedalorbetterearned = 1;
        }
        util::function_a3f7de13(19, self.team, self getentitynumber(), killcount);
    }
    if (killcount >= 2) {
        scoreevents = globallogic_score::function_3cbc4c6c(weapon.var_2e4a8800);
        var_8a4cfbd = weapon.var_76ce72e8 && isdefined(scoreevents) && scoreevents.var_fcd2ff3a === 1;
        if (var_8a4cfbd) {
            self stats::function_dad108fa(#"hash_2fa96b97166080d2", 1);
            self contracts::increment_contract(#"hash_7861508178a93a0f");
        } else if (weapon.issignatureweapon) {
            self stats::function_dad108fa(#"hash_cb8c5c845093e02", 1);
            self contracts::increment_contract(#"hash_3f50e5536ee788ab");
        }
    }
    if (killcount >= 3) {
        self contracts::increment_contract(#"contract_mp_multikill_3_or_better");
        self contracts::increment_contract(#"contract_wl_multikill_3_or_better");
    }
    if (killcount >= 2) {
        self contracts::increment_contract(#"contract_mp_multikill_2_or_better");
        self contracts::increment_contract(#"contract_wl_multikill_2_or_better");
    }
    if (!isdefined(self.pers[#"highestmultikill"])) {
        self.pers[#"highestmultikill"] = 0;
    }
    if (self.pers[#"highestmultikill"] < killcount) {
        self.pers[#"highestmultikill"] = killcount;
    }
    self recordmultikill(killcount);
}

// Namespace scoreevents/scoreevents
// Params 2, eflags: 0x1 linked
// Checksum 0x739f5646, Offset: 0x5648
// Size: 0x12c
function multiheroabilitykill(killcount, weapon) {
    if (killcount > 1) {
        self stats::function_dad108fa(#"multikill_2_with_heroability", int(killcount / 2));
        self stats::function_e24eec31(weapon, #"heroability_doublekill", int(killcount / 2));
        self stats::function_dad108fa(#"multikill_3_with_heroability", int(killcount / 3));
        self stats::function_e24eec31(weapon, #"heroability_triplekill", int(killcount / 3));
    }
}

// Namespace scoreevents/scoreevents
// Params 4, eflags: 0x1 linked
// Checksum 0xe9d43f40, Offset: 0x5780
// Size: 0x1ae
function is_weapon_valid(meansofdeath, weapon, weaponclass, killstreak) {
    valid_weapon = 0;
    if (isdefined(killstreak)) {
        valid_weapon = 0;
    } else if (get_distance_for_weapon(weapon, weaponclass) == 0) {
        valid_weapon = 0;
    } else if (meansofdeath == "MOD_PISTOL_BULLET" || meansofdeath == "MOD_RIFLE_BULLET") {
        valid_weapon = 1;
    } else if (meansofdeath == "MOD_HEAD_SHOT") {
        valid_weapon = 1;
    } else if (weapon.rootweapon.name == "hatchet" && meansofdeath == "MOD_IMPACT") {
        valid_weapon = 1;
    } else {
        baseweapon = challenges::getbaseweapon(weapon);
        if ((baseweapon == level.weaponspecialcrossbow || weapon.isballisticknife || baseweapon == level.weaponflechette) && meansofdeath == "MOD_IMPACT") {
            valid_weapon = 1;
        } else if ((baseweapon.forcedamagehitlocation || baseweapon == level.weaponshotgunenergy) && meansofdeath == "MOD_PROJECTILE") {
            valid_weapon = 1;
        }
    }
    return valid_weapon;
}

// Namespace scoreevents/scoreevents
// Params 4, eflags: 0x1 linked
// Checksum 0x6b4d64b8, Offset: 0x5938
// Size: 0x1074
function updatemultikills(weapon, weaponclass, killstreak, victim) {
    self endon(#"disconnect");
    level endon(#"game_ended");
    self notify(#"updaterecentkills");
    self endon(#"updaterecentkills");
    baseweapon = weapons::getbaseweapon(weapon);
    if (!isdefined(self.recentkillvariables)) {
        self resetrecentkillvariables();
    }
    primary_weapon = self loadout::function_18a77b37("primary");
    secondary_weapon = self loadout::function_18a77b37("secondary");
    if (isdefined(primary_weapon) && baseweapon.statname == primary_weapon.statname) {
        if (!isdefined(self.var_a95c605e)) {
            self.var_a95c605e = 0;
        }
        self.var_a95c605e++;
    } else if (isdefined(secondary_weapon) && baseweapon.statname == secondary_weapon.statname) {
        if (!isdefined(self.var_3e5d9e0f)) {
            self.var_3e5d9e0f = 0;
        }
        self.var_3e5d9e0f++;
    }
    if (!isdefined(self.recentkillcountweapon) || self.recentkillcountweapon != baseweapon) {
        self.recentkillcountsameweapon = 0;
        self.recentkillcountweapon = baseweapon;
    }
    if (!isdefined(killstreak)) {
        self.recentkillcountsameweapon++;
        self.recentkillcount++;
    }
    if (is_true(baseweapon.issignatureweapon) || is_true(baseweapon.var_76ce72e8)) {
        self.var_311e32f++;
        if (self.var_311e32f > 8) {
            processscoreevent(#"hash_658629ce68f99fb5", self, victim, weapon);
        } else if (self.var_311e32f > 1) {
            scorestr = "specialist_weapon_equipment_multikill_x" + self.var_311e32f;
            processscoreevent(scorestr, self, victim, weapon);
        }
    }
    if (isdefined(weaponclass)) {
        if (weaponclass == "weapon_lmg" || weaponclass == "weapon_smg") {
            if (self playerads() < 1) {
                self.recent_lmg_smg_killcount++;
            }
        }
        if (weaponclass == "weapon_grenade") {
            self.recentlethalcount++;
        }
    }
    if (weapon.name == #"satchel_charge") {
        self.recentc4killcount++;
    }
    if (isdefined(level.killstreakweapons) && isdefined(level.killstreakweapons[weapon])) {
        switch (level.killstreakweapons[weapon]) {
        case #"remote_missile":
        case #"inventory_remote_missile":
            self.recentremotemissilecount++;
            break;
        case #"inventory_rcbomb":
        case #"rcbomb":
            self.recentrcbombcount++;
            break;
        }
    }
    if (weapon.isheavyweapon) {
        self.recentheavykill = gettime();
        self.recentheavyweaponkillcount++;
        if (isdefined(victim)) {
            self.recentheavyweaponvictims[victim getentitynumber()] = victim;
        }
        switch (weapon.name) {
        case #"hero_annihilator":
            self.recentanihilatorcount++;
            break;
        case #"hero_minigun":
            self.recentminiguncount++;
            break;
        case #"hero_bowlauncher2":
        case #"hero_bowlauncher3":
        case #"hero_bowlauncher4":
        case #"hero_bowlauncher":
            self.recentbowlaunchercount++;
            break;
        case #"hero_flamethrower":
            self.recentflamethrowercount++;
            break;
        case #"hero_lightninggun":
        case #"hero_lightninggun_arc":
            self.recentlightningguncount++;
            break;
        case #"hero_pineapple_grenade":
        case #"hero_pineapplegun":
            self.recentpineappleguncount++;
            break;
        case #"hero_firefly_swarm":
        case #"hero_chemicalgun":
            self.recentgelguncount++;
            break;
        }
    }
    if (self.var_a7f5c61e && weapon.name == #"eq_gravityslam") {
        self.var_cc5ece37++;
    }
    if (isdefined(self.heroability) && isdefined(victim)) {
        if (victim ability_player::gadget_checkheroabilitykill(self)) {
            if (isdefined(self.recentheroabilitykillweapon) && self.recentheroabilitykillweapon != self.heroability) {
                self.recentheroabilitykillcount = 0;
            }
            self.recentheroabilitykillweapon = self.heroability;
            self.recentheroabilitykillcount++;
        }
    }
    if (isdefined(killstreak)) {
        switch (killstreak) {
        case #"remote_missile":
            self.recentremotemissilekillcount++;
            break;
        case #"rcbomb":
            self.recentrcbombkillcount++;
            break;
        case #"recon_car":
        case #"inventory_recon_car":
            self.var_70845d87++;
            break;
        case #"m32":
        case #"inventory_m32":
            self.recentmglkillcount++;
            break;
        }
    }
    if (self.recentkillcountsameweapon == 2) {
        self stats::function_e24eec31(weapon, #"multikill_2", 1);
    } else if (self.recentkillcountsameweapon == 3) {
        self stats::function_e24eec31(weapon, #"multikill_3", 1);
    }
    self waittilltimeoutordeath(4);
    if (self.recent_lmg_smg_killcount >= 3) {
        self challenges::multi_lmg_smg_kill();
    }
    if (self.recentrcbombkillcount >= 2) {
        self challenges::multi_rcbomb_kill();
    }
    if (self.var_70845d87 >= 2) {
        self challenges::function_46754062();
        self contracts::increment_contract(#"hash_741b3c0ab3e7a55f");
    }
    if (self.recentmglkillcount >= 3) {
        self challenges::multi_mgl_kill();
    }
    if (self.recentremotemissilekillcount >= 3) {
        self challenges::multi_remotemissile_kill();
        self contracts::increment_contract(#"hash_276886a0fbac5de0");
    }
    if (isdefined(self.recentheroweaponkillcount) && self.recentheroweaponkillcount > 1) {
        self hero_weapon_multikill_event(self.recentheroweaponkillcount, weapon);
    }
    if (self.recentheavyweaponkillcount > 5) {
        arrayremovevalue(self.recentheavyweaponvictims, undefined);
        if (self.recentheavyweaponvictims.size > 5) {
            self stats::function_dad108fa(#"kill_entire_team_with_specialist_weapon", 1);
        }
    }
    if (self.recentanihilatorcount >= 3) {
        self multikillmedalachievement();
    } else if (self.recentanihilatorcount == 2) {
        self multikillmedalachievement();
    }
    if (self.recentminiguncount >= 3) {
        processscoreevent(#"minigun_multikill", self, victim, weapon);
        self multikillmedalachievement();
    } else if (self.recentminiguncount == 2) {
        processscoreevent(#"minigun_multikill_2", self, victim, weapon);
        self multikillmedalachievement();
    }
    if (self.recentbowlaunchercount >= 3) {
        processscoreevent(#"bowlauncher_multikill", self, victim, weapon);
        self multikillmedalachievement();
    } else if (self.recentbowlaunchercount == 2) {
        processscoreevent(#"bowlauncher_multikill_2", self, victim, weapon);
        self multikillmedalachievement();
    }
    if (self.recentflamethrowercount >= 3) {
        processscoreevent(#"flamethrower_multikill", self, victim, weapon);
        self multikillmedalachievement();
    } else if (self.recentflamethrowercount == 2) {
        processscoreevent(#"flamethrower_multikill_2", self, victim, weapon);
        self multikillmedalachievement();
    }
    if (self.recentlightningguncount >= 3) {
        processscoreevent(#"lightninggun_multikill", self, victim, weapon);
        self multikillmedalachievement();
    } else if (self.recentlightningguncount == 2) {
        processscoreevent(#"hash_1ff9cffb9d62d81a", self, victim, weapon);
        self multikillmedalachievement();
    }
    if (self.recentpineappleguncount >= 3) {
        self multikillmedalachievement();
    } else if (self.recentpineappleguncount == 2) {
        self multikillmedalachievement();
    }
    if (self.recentgelguncount >= 3) {
        processscoreevent(#"gelgun_multikill", self, victim, weapon);
        self multikillmedalachievement();
    } else if (self.recentgelguncount == 2) {
        processscoreevent(#"gelgun_multikill_2", self, victim, weapon);
        self multikillmedalachievement();
    }
    if (self.recentarmbladecount >= 3) {
        processscoreevent(#"armblades_multikill", self, victim, weapon);
        self multikillmedalachievement();
    } else if (self.recentarmbladecount == 2) {
        processscoreevent(#"armblades_multikill_2", self, victim, weapon);
        self multikillmedalachievement();
    }
    if (self.recentc4killcount >= 2) {
        processscoreevent(#"c4_multikill", self, victim, weapon);
    }
    if (self.recentremotemissilecount >= 3) {
        self stats::function_dad108fa(#"multikill_3_remote_missile", 1);
    }
    if (self.recentrcbombcount >= 2) {
        self stats::function_dad108fa(#"multikill_2_rcbomb", 1);
    }
    if (self.recentlethalcount >= 2) {
        if (!isdefined(self.pers[#"challenge_kills_double_kill_lethal"])) {
            self.pers[#"challenge_kills_double_kill_lethal"] = 0;
        }
        self.pers[#"challenge_kills_double_kill_lethal"]++;
        if (self.pers[#"challenge_kills_double_kill_lethal"] >= 3) {
            self stats::function_dad108fa(#"kills_double_kill_3_lethal", 1);
        }
    }
    if (self.recentkillcount > 1) {
        self multikill(self.recentkillcount, weapon);
        if (self.recentkillcountsameweapon < self.recentkillcount) {
            self contracts::increment_contract(#"contract_mp_hotswap_multikill");
        }
    }
    if (self.recentkillcountsameweapon > 1) {
        self function_8fe4629e(self.recentkillcountsameweapon, weapon);
    }
    if (self.recentheroabilitykillcount > 1) {
        self multiheroabilitykill(self.recentheroabilitykillcount, self.recentheroabilitykillweapon);
        self hero_ability_multikill_event(self.recentheroabilitykillcount, self.recentheroabilitykillweapon);
    }
    if (self.var_cc5ece37 >= 2) {
        event = "grapple_slam_multikill_" + self.var_cc5ece37;
        processscoreevent(event, self, victim, weapon);
    }
    self resetrecentkillvariables();
}

// Namespace scoreevents/scoreevents
// Params 0, eflags: 0x5 linked
// Checksum 0x43bc6628, Offset: 0x69b8
// Size: 0x14e
function private resetrecentkillvariables() {
    self.recentanihilatorcount = 0;
    self.recent_lmg_smg_killcount = 0;
    self.recentarmbladecount = 0;
    self.recentbowlaunchercount = 0;
    self.recentc4killcount = 0;
    self.recentflamethrowercount = 0;
    self.recentgelguncount = 0;
    self.var_cc5ece37 = 0;
    self.recentheroabilitykillcount = 0;
    self.recentheavyweaponkillcount = 0;
    self.recentheavyweaponvictims = [];
    self.recentkillcount = 0;
    self.recentkillcountsameweapon = 0;
    self.recentkillcountweapon = undefined;
    self.recentlethalcount = 0;
    self.recentlightningguncount = 0;
    self.recentmglkillcount = 0;
    self.recentminiguncount = 0;
    self.recentpineappleguncount = 0;
    self.recentrcbombcount = 0;
    self.recentrcbombkillcount = 0;
    self.var_70845d87 = 0;
    self.recentremotemissilecount = 0;
    self.recentremotemissilekillcount = 0;
    self.var_311e32f = 0;
    self.var_a95c605e = undefined;
    self.var_3e5d9e0f = undefined;
    self.var_fa9604fd = undefined;
    self.recentkillvariables = 1;
}

// Namespace scoreevents/scoreevents
// Params 1, eflags: 0x1 linked
// Checksum 0xda3043a, Offset: 0x6b10
// Size: 0x26
function waittilltimeoutordeath(timeout) {
    self endon(#"death");
    wait timeout;
}

// Namespace scoreevents/scoreevents
// Params 4, eflags: 0x1 linked
// Checksum 0xab037240, Offset: 0x6b40
// Size: 0x2be
function updateoneshotmultikills(victim, weapon, firsttimedamaged, meansofdeath) {
    self endon(#"death", #"disconnect");
    self notify("updateoneshotmultikills" + firsttimedamaged);
    self endon("updateoneshotmultikills" + firsttimedamaged);
    if (!isdefined(self.oneshotmultikills) || firsttimedamaged > (isdefined(self.oneshotmultikillsdamagetime) ? self.oneshotmultikillsdamagetime : 0)) {
        self.oneshotmultikills = 0;
    }
    self.oneshotmultikills++;
    self.oneshotmultikillsdamagetime = firsttimedamaged;
    wait 1;
    if (self.oneshotmultikills > 1) {
        processscoreevent(#"kill_enemies_one_bullet", self, victim, weapon);
        self contracts::increment_contract(#"hash_45b74ebf1ab2fd47");
    } else if (weapon.statindex != level.weapon_hero_annihilator.statindex) {
        processscoreevent(#"kill_enemy_one_bullet", self, victim, weapon);
        if (!level.hardcoremode) {
            self contracts::increment_contract(#"hash_47f2f8fa5afb9d01");
        }
        if (meansofdeath == "MOD_HEAD_SHOT") {
            var_f9d69b3b = self stats::get_stat_global(#"kill_enemy_one_bullet_headshot");
            var_35635206 = self stats::function_af5584ca(#"kill_enemy_one_bullet_headshot");
            var_413c3e61 = 1;
            if (isdefined(var_35635206)) {
                switch (var_35635206) {
                case 1:
                    if (var_f9d69b3b < 50) {
                        var_413c3e61 += 50;
                    }
                    break;
                case 2:
                    if (var_f9d69b3b < 150) {
                        var_413c3e61 += 150;
                    }
                    break;
                }
            }
            self stats::function_dad108fa(#"kill_enemy_one_bullet_headshot", var_413c3e61);
        }
    }
    self.oneshotmultikills = 0;
}

// Namespace scoreevents/scoreevents
// Params 2, eflags: 0x1 linked
// Checksum 0xd83637b9, Offset: 0x6e08
// Size: 0x1fe
function get_distance_for_weapon(weapon, weaponclass) {
    distance = 0;
    if (!isdefined(weaponclass)) {
        return 0;
    }
    if (weapon.rootweapon.name == "pistol_shotgun") {
        weaponclass = "weapon_cqb";
    }
    switch (weaponclass) {
    case #"weapon_smg":
        distance = 1960000;
        break;
    case #"weapon_assault":
        distance = 2560000;
        break;
    case #"weapon_tactical":
        distance = 2560000;
        break;
    case #"weapon_lmg":
        distance = 2560000;
        break;
    case #"weapon_sniper":
        distance = 4000000;
        break;
    case #"weapon_pistol":
        distance = 1000000;
        break;
    case #"weapon_cqb":
        distance = 302500;
        break;
    case #"weapon_special":
        baseweapon = challenges::getbaseweapon(weapon);
        if (weapon.isballisticknife || baseweapon == level.weaponspecialcrossbow) {
            distance = 2250000;
        }
        break;
    case #"weapon_grenade":
        if (weapon.rootweapon.name == "hatchet") {
            distance = 2250000;
        }
        break;
    default:
        distance = 0;
        break;
    }
    return distance;
}

// Namespace scoreevents/scoreevents
// Params 1, eflags: 0x1 linked
// Checksum 0x1a376ca0, Offset: 0x7010
// Size: 0x1c4
function ongameend(data) {
    player = data.player;
    winner = data.winner;
    if (isdefined(winner)) {
        if (level.teambased) {
            if (!match::get_flag("tie") && player.team == winner) {
                player.pers[#"hash_6344af0b142ed0b6"] = 1;
                processscoreevent(#"won_match", player, undefined, undefined);
                return;
            }
        } else {
            placement = level.placement[#"all"];
            topthreeplayers = min(3, placement.size);
            for (index = 0; index < topthreeplayers; index++) {
                if (level.placement[#"all"][index] == player) {
                    player.pers[#"hash_6344af0b142ed0b6"] = 1;
                    processscoreevent(#"won_match", player, undefined, undefined);
                    return;
                }
            }
        }
    }
    processscoreevent(#"completed_match", player, undefined, undefined);
}

// Namespace scoreevents/scoreevents
// Params 0, eflags: 0x1 linked
// Checksum 0x35c39540, Offset: 0x71e0
// Size: 0xc4
function specialistmedalachievement() {
    if (level.rankedmatch) {
        if (!isdefined(self.pers[#"specialistmedalachievement"])) {
            self.pers[#"specialistmedalachievement"] = 0;
        }
        self.pers[#"specialistmedalachievement"]++;
        if (self.pers[#"specialistmedalachievement"] == 5) {
            self giveachievement(#"mp_specialist_medals");
        }
        self contracts::player_contract_event(#"earned_specialist_ability_medal");
    }
}

// Namespace scoreevents/scoreevents
// Params 2, eflags: 0x1 linked
// Checksum 0xfcafc5c8, Offset: 0x72b0
// Size: 0x256
function specialiststatabilityusage(usagesinglegame, multitrackperlife) {
    self endon(#"disconnect");
    level endon(#"game_ended");
    self notify(#"hash_f92aeaeaf35ba82");
    self endon(#"hash_f92aeaeaf35ba82");
    isroulette = self.isroulette === 1;
    if (isdefined(self.heroability) && !isroulette) {
        self function_be7a08a8(self.heroability, 1);
    }
    self challenges::processspecialistchallenge("kills_ability");
    if (!isdefined(self.pers[#"specialistusagepergame"])) {
        self.pers[#"specialistusagepergame"] = 0;
    }
    self.pers[#"specialistusagepergame"]++;
    if (self.pers[#"specialistusagepergame"] >= usagesinglegame) {
        self challenges::processspecialistchallenge("kill_one_game_ability");
        self.pers[#"specialistusagepergame"] = 0;
    }
    if (multitrackperlife) {
        self.pers[#"specialiststatabilityusage"]++;
        if (self.pers[#"specialiststatabilityusage"] >= 2) {
            self challenges::processspecialistchallenge("multikill_ability");
        }
        return;
    }
    if (!isdefined(self.specialiststatabilityusage)) {
        self.specialiststatabilityusage = 0;
    }
    self.specialiststatabilityusage++;
    self waittilltimeoutordeath(4);
    if (self.specialiststatabilityusage >= 2) {
        self challenges::processspecialistchallenge("multikill_ability");
    }
    self.specialiststatabilityusage = 0;
}

// Namespace scoreevents/scoreevents
// Params 1, eflags: 0x1 linked
// Checksum 0x7f4e7a1c, Offset: 0x7510
// Size: 0x6c
function function_9aef690a(weapon) {
    baseweapon = weapons::getbaseweapon(weapon);
    return is_true(baseweapon.issignatureweapon) || is_true(baseweapon.var_76ce72e8);
}

// Namespace scoreevents/scoreevents
// Params 0, eflags: 0x1 linked
// Checksum 0xbcc78430, Offset: 0x7588
// Size: 0x54
function multikillmedalachievement() {
    if (level.rankedmatch) {
        self giveachievement(#"mp_multi_kill_medals");
        self challenges::processspecialistchallenge("multikill_weapon");
    }
}

// Namespace scoreevents/scoreevents
// Params 2, eflags: 0x1 linked
// Checksum 0x6870d4e9, Offset: 0x75e8
// Size: 0x7a
function function_c01cb128(entity, sensor_darts) {
    if (!isdefined(entity) || !isdefined(sensor_darts) || !isarray(sensor_darts) || !isdefined(entity.origin)) {
        return undefined;
    }
    return function_c28e2c05(entity.origin, sensor_darts, 1);
}

// Namespace scoreevents/scoreevents
// Params 3, eflags: 0x1 linked
// Checksum 0xd9703295, Offset: 0x7670
// Size: 0x132
function function_c28e2c05(entity_origin, sensor_darts, var_e13a103a) {
    if (!var_e13a103a) {
        if (!isdefined(sensor_darts) || !isarray(sensor_darts) || !isdefined(entity_origin)) {
            return undefined;
        }
    }
    foreach (sensor in sensor_darts) {
        if (!isdefined(sensor)) {
            continue;
        }
        if (distancesquared(entity_origin, sensor.origin) < function_a3f6cdac((sessionmodeiswarzonegame() ? 2400 : 800) + 50)) {
            return sensor;
        }
    }
    return undefined;
}

// Namespace scoreevents/scoreevents
// Params 1, eflags: 0x0
// Checksum 0xb05722ac, Offset: 0x77b0
// Size: 0x8e
function function_3932ffa2(sensor_darts) {
    foreach (sensor in sensor_darts) {
        if (!isdefined(sensor)) {
            continue;
        }
        sensor.var_1fd3a368 = 0;
    }
}

// Namespace scoreevents/scoreevents
// Params 3, eflags: 0x0
// Checksum 0xd1439059, Offset: 0x7848
// Size: 0x2b4
function function_43ee1b3d(attacker, victim, attackerweapon) {
    if (!isdefined(level.smartcoversettings) || !isdefined(level.smartcoversettings.var_f115c746)) {
        return;
    }
    if (isdefined(attackerweapon) && isdefined(level.iskillstreakweapon) && [[ level.iskillstreakweapon ]](attackerweapon)) {
        return 0;
    }
    foreach (smartcover in level.smartcoversettings.var_f115c746) {
        if (!isdefined(smartcover)) {
            continue;
        }
        if (victim == smartcover.owner) {
            continue;
        }
        var_583e1573 = distancesquared(smartcover.origin, attacker.origin);
        if (var_583e1573 > level.smartcoversettings.var_357db326) {
            continue;
        }
        var_eb870c = distancesquared(victim.origin, smartcover.origin);
        var_ae30f518 = distancesquared(victim.origin, attacker.origin);
        var_d9ecf725 = var_ae30f518 > var_583e1573;
        var_1d1ca33b = var_ae30f518 > var_eb870c;
        if (var_d9ecf725 && var_1d1ca33b) {
            var_a3aba5a9 = 1;
            var_71eedb0b = smartcover.owner;
            break;
        }
    }
    if (isdefined(var_71eedb0b) && isdefined(var_a3aba5a9) && var_a3aba5a9) {
        if (smartcover.owner == attacker) {
            processscoreevent(#"deployable_cover_kill", var_71eedb0b, victim, level.smartcoversettings.var_8d86ade8);
            return;
        }
        processscoreevent(#"deployable_cover_assist", var_71eedb0b, victim, level.smartcoversettings.var_8d86ade8);
    }
}

