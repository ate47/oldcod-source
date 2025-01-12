#using scripts\abilities\ability_player;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\weapons_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\mp_common\challenges;
#using scripts\mp_common\gametypes\match;
#using scripts\mp_common\util;
#using scripts\weapons\weapon_utils;

#namespace scoreevents;

// Namespace scoreevents/scoreevents
// Params 0, eflags: 0x2
// Checksum 0x6d827be6, Offset: 0x5f0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"scoreevents", &__init__, undefined, undefined);
}

// Namespace scoreevents/scoreevents
// Params 0, eflags: 0x0
// Checksum 0xf9eddc55, Offset: 0x638
// Size: 0x44
function __init__() {
    callback::on_start_gametype(&init);
    callback::on_spawned(&on_player_spawned);
}

// Namespace scoreevents/scoreevents
// Params 0, eflags: 0x0
// Checksum 0xd4293a00, Offset: 0x688
// Size: 0x64
function init() {
    level.scoreeventgameendcallback = &ongameend;
    registerscoreeventcallback("playerKilled", &scoreeventplayerkill);
    status_effect::function_a95bb02c(&function_455ce834);
}

// Namespace scoreevents/scoreevents
// Params 2, eflags: 0x0
// Checksum 0x94ca4c38, Offset: 0x6f8
// Size: 0x1da
function function_455ce834(status_effect, var_2c5d9a58) {
    if (!isdefined(status_effect.var_85e878ff) || status_effect.var_85e878ff == status_effect.owner || !isdefined(status_effect.var_ed5f2f94)) {
        return;
    }
    switch (status_effect.setype) {
    case 2:
        if (var_2c5d9a58 == "begin") {
            if (status_effect.var_ed5f2f94 == getweapon(#"concussion_grenade")) {
                processscoreevent(#"concussed_enemy", status_effect.var_85e878ff, status_effect.owner, status_effect.var_ed5f2f94);
                status_effect.var_85e878ff.var_132fb2fa = (isdefined(status_effect.var_85e878ff.var_132fb2fa) ? status_effect.var_85e878ff.var_132fb2fa : 0) + 1;
                if (status_effect.var_85e878ff.var_132fb2fa == 2 && isdefined(level.playgadgetsuccess)) {
                    status_effect.var_85e878ff thread [[ level.playgadgetsuccess ]](getweapon(#"concussion_grenade"), undefined, undefined, undefined);
                }
                break;
            }
        }
    default:
        break;
    }
}

// Namespace scoreevents/scoreevents
// Params 0, eflags: 0x0
// Checksum 0x7d6b16f2, Offset: 0x8e0
// Size: 0x54
function on_player_spawned() {
    self player_spawned();
    self thread function_546914f();
    self callback::on_weapon_change(&on_weapon_change);
}

// Namespace scoreevents/scoreevents
// Params 1, eflags: 0x4
// Checksum 0xc186ec8a, Offset: 0x940
// Size: 0x18e
function private on_weapon_change(params) {
    if (!isdefined(params.weapon) || !isweapon(params.weapon) || !isdefined(params.last_weapon) || !isweapon(params.last_weapon) || !isdefined(self) || !isplayer(self)) {
        return;
    }
    var_3237e7f4 = weapons::getbaseweapon(params.weapon);
    var_124769bd = weapons::getbaseweapon(params.last_weapon);
    if (!isdefined(var_3237e7f4) || !isdefined(var_124769bd) || var_3237e7f4 == var_124769bd) {
        return;
    }
    if (isdefined(var_3237e7f4.var_ee15463f) && var_3237e7f4.var_ee15463f || var_3237e7f4.name == #"none") {
        return;
    }
    if (isdefined(level.iskillstreakweapon)) {
        if ([[ level.iskillstreakweapon ]](var_3237e7f4)) {
            return;
        }
    }
    self.var_642dd161 = gettime();
}

// Namespace scoreevents/scoreevents
// Params 2, eflags: 0x0
// Checksum 0x56db4297, Offset: 0xad8
// Size: 0x52
function scoreeventtablelookupint(index, scoreeventcolumn) {
    return int(tablelookup(getscoreeventtablename(), 0, index, scoreeventcolumn));
}

// Namespace scoreevents/scoreevents
// Params 2, eflags: 0x0
// Checksum 0x4cc10fb2, Offset: 0xb38
// Size: 0x42
function scoreeventtablelookup(index, scoreeventcolumn) {
    return tablelookup(getscoreeventtablename(), 0, index, scoreeventcolumn);
}

// Namespace scoreevents/scoreevents
// Params 2, eflags: 0x0
// Checksum 0x509d55b7, Offset: 0xb88
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

// Namespace scoreevents/scoreevents
// Params 2, eflags: 0x0
// Checksum 0x3888f763, Offset: 0xc18
// Size: 0x43bc
function scoreeventplayerkill(data, time) {
    victim = data.victim;
    attacker = data.attacker;
    time = data.time;
    level.numkills++;
    attacker.lastkilledplayer = victim;
    wasdefusing = data.wasdefusing;
    wasplanting = data.wasplanting;
    victimwasonground = data.victimonground;
    attackerwasonground = data.attackeronground;
    meansofdeath = data.smeansofdeath;
    attackertraversing = data.attackertraversing;
    var_e4763e35 = data.var_e4763e35;
    var_3828b415 = data.var_3828b415;
    attackersliding = data.attackersliding;
    var_c39b9276 = data.var_c39b9276;
    var_f67ec791 = data.var_f67ec791;
    var_b9995fb9 = data.var_b9995fb9;
    attackerspeedburst = data.attackerspeedburst;
    victimspeedburst = data.victimspeedburst;
    victimcombatefficieny = data.victimcombatefficieny;
    victimspeedburstlastontime = data.victimspeedburstlastontime;
    victimcombatefficiencylastontime = data.victimcombatefficiencylastontime;
    victimvisionpulseactivatetime = data.victimvisionpulseactivatetime;
    attackervisionpulseactivatetime = data.attackervisionpulseactivatetime;
    victimvisionpulseactivatetime = data.victimvisionpulseactivatetime;
    attackervisionpulsearray = data.attackervisionpulsearray;
    victimvisionpulsearray = data.victimvisionpulsearray;
    attackervisionpulseoriginarray = data.attackervisionpulseoriginarray;
    victimvisionpulseoriginarray = data.victimvisionpulseoriginarray;
    attackervisionpulseorigin = data.attackervisionpulseorigin;
    victimvisionpulseorigin = data.victimvisionpulseorigin;
    victimlastvisionpulsedby = data.victimlastvisionpulsedby;
    victimlastvisionpulsedtime = data.victimlastvisionpulsedtime;
    var_38377c1b = data.var_38377c1b;
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
    var_7501e33a = data.var_7501e33a;
    victimpowerarmorlasttookdamagetime = data.victimpowerarmorlasttookdamagetime;
    var_3893310d = data.var_3893310d;
    victimgadgetpower = data.victimgadgetpower;
    victimgadgetwasactivelastdamage = data.victimgadgetwasactivelastdamage;
    victimisthieforroulette = data.victimisthieforroulette;
    attackerisroulette = data.attackerisroulette;
    victimheroabilityname = data.victimheroabilityname;
    var_5a4c6af5 = data.var_5a4c6af5;
    var_1edcd7b = data.var_1edcd7b;
    var_cfbdcd9e = data.var_cfbdcd9e;
    var_74dc8fca = data.var_74dc8fca;
    var_c500bb2f = data.var_c500bb2f;
    var_9c8b7685 = data.var_9c8b7685;
    var_83a9e4a6 = data.var_83a9e4a6;
    var_af10010a = data.var_af10010a;
    var_fda6fe6 = data.var_fda6fe6;
    var_4aa55cc0 = data.var_4aa55cc0;
    var_1a493d95 = data.var_1a493d95;
    var_cc0c0c1a = data.var_cc0c0c1a;
    var_3088702b = data.var_3088702b;
    var_c52dac68 = data.var_c52dac68;
    var_b4f52924 = data.var_b4f52924;
    var_e13bb0e8 = data.var_e13bb0e8;
    var_a2a42cd5 = data.var_a2a42cd5;
    var_eec11386 = data.var_eec11386;
    var_a2ac4ca6 = data.var_a2ac4ca6;
    attacker.var_53be3fe2 = data.var_a978676b;
    var_ce2d42f1 = data.var_ce2d42f1;
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
    if (!isdefined(killstreak)) {
        if (level.teambased) {
            if (isdefined(victim.lastkilltime) && victim.lastkilltime > time - 3000) {
                if (isdefined(victim.lastkilledplayer) && victim.lastkilledplayer util::isenemyplayer(attacker) == 0 && attacker != victim.lastkilledplayer) {
                    processscoreevent(#"kill_enemy_who_killed_teammate", attacker, victim, weapon);
                    victim recordkillmodifier("avenger");
                }
            }
            if (isdefined(victim.damagedplayers)) {
                keys = getarraykeys(victim.damagedplayers);
                for (i = 0; i < keys.size; i++) {
                    key = keys[i];
                    if (key == attacker.clientid) {
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
            if (var_b9995fb9 == 1) {
                if (var_3828b415 == 1) {
                    processscoreevent(#"kill_enemy_while_both_in_air", attacker, victim, weapon);
                }
                processscoreevent(#"kill_enemy_that_is_in_air", attacker, victim, weapon);
                attacker stats::function_b48aa4e(#"hash_358f1258d5231e43", 1);
            }
            if (var_3828b415 == 1) {
                processscoreevent(#"kill_enemy_while_in_air", attacker, victim, weapon);
                attacker stats::function_b48aa4e(#"hash_3fdb9703c01d938c", 1);
            }
            if (var_f67ec791 == 1) {
                processscoreevent(#"kill_enemy_that_is_wallrunning", attacker, victim, weapon);
                attacker stats::function_b48aa4e(#"hash_39b1a234947367ff", 1);
            }
            if (var_e4763e35 == 1) {
                processscoreevent(#"kill_enemy_while_wallrunning", attacker, victim, weapon);
                attacker stats::function_b48aa4e(#"hash_3762770b322ac7fb", 1);
            }
            if (attackersliding == 1) {
                processscoreevent(#"kill_enemy_while_sliding", attacker, victim, weapon);
                attacker stats::function_b48aa4e(#"hash_d73110a583bac76", 1);
            }
            if (attackertraversing == 1) {
                processscoreevent(#"traversal_kill", attacker, victim, weapon);
                attacker stats::function_b48aa4e(#"hash_5785c9bc7d72374c", 1);
            }
            if (var_c39b9276 && isdefined(attacker.var_e54edb6) && isplayer(attacker.var_e54edb6)) {
                if (attacker == attacker.var_e54edb6) {
                    processscoreevent(#"stim_kill", attacker, victim, getweapon(#"eq_localheal"));
                } else {
                    processscoreevent(#"stim_assist", attacker.var_e54edb6, victim, getweapon(#"eq_localheal"));
                }
            }
            if (attackerwasflashed) {
                processscoreevent(#"kill_enemy_while_flashbanged", attacker, victim, weapon);
            }
            if (victim.currentweapon == getweapon(#"sig_bow_quickshot") || victim.currentweapon == getweapon(#"sig_bow_quickshot2") || victim.currentweapon == getweapon(#"sig_bow_quickshot3") || victim.currentweapon == getweapon(#"sig_bow_quickshot4")) {
                processscoreevent(#"hash_6530935b474f2e11", attacker, victim, weapon);
            }
            if (attackerwasconcussed) {
                processscoreevent(#"kill_enemy_while_stunned", attacker, victim, weapon);
            }
            if (attackerwasheatwavestunned) {
                processscoreevent(#"kill_enemy_that_heatwaved_you", attacker, victim, weapon);
                attacker util::player_contract_event("killed_hero_ability_enemy");
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
        if (isdefined(var_74dc8fca)) {
            sensor = function_dd6dafbf(victim, var_74dc8fca);
            if (isdefined(sensor)) {
                processscoreevent(#"sensor_dart_kill", attacker, victim, sensor.weapon);
                if ((isdefined(sensor.var_56e8339c) ? sensor.var_56e8339c : 1) && isdefined(level.playgadgetsuccess)) {
                    attacker.sensorkill = (isdefined(attacker.sensorkill) ? attacker.sensorkill : 0) + 1;
                    if (isdefined(level.var_86ebfbc0)) {
                        var_848752a7 = [[ level.var_86ebfbc0 ]]("sensorDartSuccessLineCount", 0);
                    }
                    if (attacker.sensorkill == (isdefined(var_848752a7) ? var_848752a7 : 3)) {
                        attacker [[ level.playgadgetsuccess ]](sensor.weapon, undefined, victim, undefined);
                        function_afd1c30c(var_74dc8fca);
                        attacker.sensorkill = 0;
                    }
                }
            }
        } else if (isdefined(var_cfbdcd9e)) {
            sensor = function_dd6dafbf(victim, var_cfbdcd9e);
            if (isdefined(sensor)) {
                if (function_66d24d75(weapon)) {
                    processscoreevent(#"hash_1f661efe5e6707ad", var_1edcd7b, victim, weapon);
                } else {
                    processscoreevent(#"sensor_dart_assist", var_1edcd7b, victim, weapon);
                }
                if ((isdefined(sensor.var_56e8339c) ? sensor.var_56e8339c : 1) && isdefined(level.playgadgetsuccess)) {
                    var_1edcd7b.sensorkill = (isdefined(var_1edcd7b.sensorkill) ? var_1edcd7b.sensorkill : 0) + 1;
                    if (isdefined(level.var_86ebfbc0)) {
                        var_848752a7 = [[ level.var_86ebfbc0 ]]("sensorDartSuccessLineCount", 0);
                    }
                    if (var_1edcd7b.sensorkill == (isdefined(var_848752a7) ? var_848752a7 : 3)) {
                        var_1edcd7b [[ level.playgadgetsuccess ]](sensor.weapon, undefined, victim, attacker);
                        function_afd1c30c(var_cfbdcd9e);
                        var_1edcd7b.sensorkill = 0;
                    }
                }
            }
        }
        if (var_a2a42cd5 && isdefined(var_a2ac4ca6)) {
            if (var_a2ac4ca6 == getweapon(#"concussion_grenade")) {
                processscoreevent(#"concussion_kill", attacker, victim, getweapon(#"concussion_grenade"));
                if (attacker != var_eec11386) {
                    processscoreevent(#"assist_concussion", var_eec11386, victim, weapon);
                }
            }
        }
        if (weapon == getweapon(#"sig_buckler_turret") || weapon == getweapon(#"sig_buckler_dw")) {
            if (var_cc0c0c1a && isdefined(var_1a493d95) && var_1a493d95 == attacker) {
                processscoreevent(#"hash_63b75d5e59c12f69", attacker, victim, weapon);
            }
        } else if (var_cc0c0c1a && isdefined(var_1a493d95) && var_1a493d95 == attacker) {
            processscoreevent(#"swat_grenade_kill_blinded_enemy", attacker, victim, weapon);
        }
        if (isdefined(attacker.var_a304768d) && isarray(attacker.var_a304768d)) {
            foreach (effect in attacker.var_a304768d) {
                if (!isdefined(effect) || !isdefined(effect.var_ed5f2f94) || !isweapon(effect.var_ed5f2f94)) {
                    continue;
                }
                if (effect.var_ed5f2f94 == getweapon(#"hash_3f62a872201cd1ce") || effect.var_ed5f2f94 == getweapon(#"seeker_mine_arc") || effect.var_ed5f2f94 == getweapon(#"eq_slow_grenade")) {
                    processscoreevent(#"hash_61640bd6bb7451ad", attacker, victim, effect.var_ed5f2f94);
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
        if (isdefined(attacker.var_642dd161) && attacker.var_642dd161 + 2000 >= time) {
            processscoreevent("kill_enemy_after_switching_weapons", attacker, victim, weapon);
        }
        if (victimspeedburstlastontime > time - 50) {
            processscoreevent(#"kill_enemy_who_is_speedbursting", attacker, victim, weapon);
            attacker util::player_contract_event("killed_hero_ability_enemy");
        }
        if (victimcombatefficiencylastontime > time - 50) {
            processscoreevent(#"kill_enemy_who_is_using_focus", attacker, victim, weapon);
            attacker util::player_contract_event("killed_hero_ability_enemy");
        }
        if (victimwasinslamstate) {
            attacker util::player_contract_event("killed_hero_weapon_enemy");
        }
        if (challenges::ishighestscoringplayer(victim)) {
            processscoreevent(#"kill_enemy_who_has_high_score", attacker, victim, weapon);
        }
        if (victimwasunderwater && exlosivedamage) {
            processscoreevent(#"kill_underwater_enemy_explosive", attacker, victim, weapon);
        }
        if (var_ce2d42f1 && isdefined(victim.lastattackedshieldplayer) && victim.lastattackedshieldplayer == attacker) {
            processscoreevent(#"hash_7c2d800a84be69a2", attacker, victim, weapon);
        }
        if (isdefined(victimelectrifiedby) && victimelectrifiedby != attacker) {
            processscoreevent(#"electrified", victimelectrifiedby, victim, weapon);
        }
        if (victimvisionpulseactivatetime != 0 && victimvisionpulseactivatetime > time - 4000) {
            for (i = 0; i < victimvisionpulsearray.size; i++) {
                player = victimvisionpulsearray[i];
                if (player == attacker) {
                    if (victimvisionpulseactivatetime + 300 > time - level.weaponvisionpulse.gadget_pulse_duration) {
                        distancetopulse = distance(victimvisionpulseoriginarray[i], victimvisionpulseorigin);
                        ratio = distancetopulse / level.weaponvisionpulse.gadget_pulse_max_range;
                        timing = ratio * level.weaponvisionpulse.gadget_pulse_duration;
                        if (victimvisionpulseactivatetime + 300 > time - timing) {
                            break;
                        }
                    }
                    processscoreevent(#"vision_pulse_shutdown", attacker, victim, weapon);
                    attacker util::player_contract_event("killed_hero_ability_enemy");
                    break;
                }
            }
            if (isdefined(victimheroability)) {
                attacker notify(#"hero_shutdown", {#gadget:victimheroability});
                attacker notify(#"hero_shutdown_gadget", {#gadget:victimheroability, #victim:victim});
            }
        }
        if (victimlastvisionpulsedtime != 0 && victimlastvisionpulsedtime > time - level.weaponvisionpulse.var_c9c3fdbb) {
            if (isdefined(victimlastvisionpulsedby) && attacker != victimlastvisionpulsedby) {
                if (function_66d24d75(weapon)) {
                    processscoreevent(#"hash_bad79b50f40ce0b", victimlastvisionpulsedby, victim, level.weaponvisionpulse);
                } else {
                    processscoreevent(#"vision_pulse_assist", victimlastvisionpulsedby, victim, level.weaponvisionpulse);
                }
                processscoreevent(#"hash_6d41ba237c04cb10", attacker, victim, weapon);
            } else {
                attacker hero_ability_kill_event(level.weaponvisionpulse, get_equipped_hero_ability(victimheroabilityname));
                attacker specialistmedalachievement();
                attacker thread specialiststatabilityusage(4, 0);
                if (attackerisroulette && !victimisthieforroulette && victimheroabilityname === "gadget_vision_pulse") {
                    processscoreevent(#"kill_enemy_with_their_hero_ability", attacker, victim, level.weaponvisionpulse);
                }
            }
            if (isdefined(level.playgadgetsuccess) && isdefined(victimlastvisionpulsedby)) {
                victimlastvisionpulsedby.visionpulsekill = (isdefined(victimlastvisionpulsedby.visionpulsekill) ? victimlastvisionpulsedby.visionpulsekill : 0) + 1;
                if (isdefined(level.var_86ebfbc0)) {
                    var_848752a7 = [[ level.var_86ebfbc0 ]]("visionPulseSuccessLineCount", 0);
                }
                if (victimlastvisionpulsedby.visionpulsekill == (isdefined(var_848752a7) ? var_848752a7 : 3)) {
                    victimlastvisionpulsedby thread [[ level.playgadgetsuccess ]](level.weaponvisionpulse, undefined, undefined, undefined);
                }
            }
        }
        if (isdefined(var_9c8b7685)) {
            processscoreevent(#"sticky_kill", attacker, victim, getweapon(#"eq_breachlauncher"));
        } else if (weapon == getweapon(#"eq_breachlauncher") && meansofdeath == "MOD_EXPLOSIVE") {
            processscoreevent(#"shrapnel_kill", attacker, victim, weapon);
        }
        if (isdefined(var_af10010a) && var_af10010a === 1) {
            foreach (var_da3ed5f5 in victim._gadgets_player) {
                if (var_da3ed5f5 == getweapon(#"mute_smoke")) {
                    processscoreevent(#"hash_438160ef75ca2ea", attacker, victim, weapon);
                    break;
                }
            }
            if (weapon == getweapon(#"eq_arm_blade")) {
                processscoreevent(#"hash_1e657ba6178ae2c6", attacker, victim, weapon);
            }
            if (isdefined(var_4aa55cc0) && var_fda6fe6 == 1) {
                if (var_4aa55cc0 == attacker) {
                    processscoreevent(#"hash_3d3467f13cf43727", attacker, victim, getweapon(#"mute_smoke"));
                } else {
                    processscoreevent(#"hash_5a52344f66f68864", var_4aa55cc0, victim, weapon);
                }
            }
        }
        if (isdefined(var_e13bb0e8)) {
            if (attacker == var_e13bb0e8) {
                processscoreevent(#"hash_6dee98175676f663", attacker, victim, weapon);
            } else {
                processscoreevent(#"suppression_assist", var_e13bb0e8, victim, weapon);
            }
        }
        if (isdefined(attacker.var_53be3fe2) && attacker.var_53be3fe2) {
            if (isdefined(level.playgadgetsuccess) && weapon != getweapon(#"eq_gravityslam") && gettime() > (isdefined(attacker.var_3cc43bbd) ? attacker.var_3cc43bbd : int(-30 * 1000)) + int(30 * 1000)) {
                attacker [[ level.playgadgetsuccess ]](getweapon(#"eq_grapple"), undefined, undefined, undefined);
                attacker.var_3cc43bbd = gettime();
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
                attacker util::player_contract_event("killed_hero_ability_enemy");
                break;
            case #"gadget_resurrect":
                processscoreevent(#"kill_enemy_that_used_resurrect", attacker, victim, weapon);
                attacker util::player_contract_event("killed_hero_ability_enemy");
                break;
            case #"gadget_camo":
                processscoreevent(#"kill_enemy_that_is_using_optic_camo", attacker, victim, weapon);
                attacker util::player_contract_event("killed_hero_ability_enemy");
                break;
            case #"gadget_clone":
                processscoreevent(#"end_enemy_psychosis", attacker, victim, weapon);
                attacker util::player_contract_event("killed_hero_ability_enemy");
                break;
            }
        } else if (isdefined(victimpowerarmorlasttookdamagetime) && time - victimpowerarmorlasttookdamagetime <= 3000) {
            attacker notify(#"hero_shutdown", {#gadget:victimheroability});
            attacker notify(#"hero_shutdown_gadget", {#gadget:victimheroability, #victim:victim});
            processscoreevent(#"kill_enemy_who_has_powerarmor", attacker, victim, weapon);
            attacker util::player_contract_event("killed_hero_ability_enemy");
        }
        if (isdefined(data.victimweapon) && data.victimweapon.isheavyweapon) {
            attacker notify(#"heavy_shutdown", {#weapon:data.victimweapon});
            attacker notify(#"heavy_shutdown_gadget", {#weapon:data.victimweapon, #victim:victim});
        } else if (isdefined(victim.heavyweapon) && victimgadgetwasactivelastdamage === 1 && victimgadgetpower < 100) {
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
        if (var_7501e33a) {
            processscoreevent(#"hash_300c1c6babed2cb3", attacker, victim, weapon);
        }
        if (isdefined(data.victimweapon)) {
            killedheavyweaponenemy(attacker, victim, weapon, data.victimweapon, victimgadgetpower, victimgadgetwasactivelastdamage);
            if (data.victimweapon.statindex == level.weapon_sig_minigun.statindex) {
                processscoreevent(#"hash_3988d3aa940f2e77", attacker, victim, weapon);
            } else if (data.victimweapon.name == "m32") {
                processscoreevent(#"killed_multiple_grenade_launcher_enemy", attacker, victim, weapon);
            }
            var_91a527f7 = isdefined(victim.heavyweapon) && victim.heavyweapon.name == "hero_armblade" && victimgadgetwasactivelastdamage;
            if ((data.victimweapon.isheavyweapon || var_91a527f7) && victimgadgetpower < 100) {
                if (var_3893310d === 0) {
                    attacker stats::function_b48aa4e(#"kill_before_specialist_weapon_use", 1);
                }
                if (weapon.isheavyweapon) {
                    attacker stats::function_b48aa4e(#"kill_specialist_with_specialist", 1);
                }
                var_eceaee76 = isdefined(attacker.heavyweapon) && attacker.heavyweapon.name == "gadget_thief";
                if (!var_eceaee76) {
                    processscoreevent(#"hash_5aa91fb1d4010928", attacker, victim, weapon);
                }
            }
        }
        if (weapon.rootweapon.name == "frag_grenade") {
            attacker function_22ab88ed(victim, weapon, weaponclass, killstreak);
        }
        attacker thread updatemultikills(weapon, weaponclass, killstreak, victim);
        if (level.numkills == 1) {
            victim recordkillmodifier("firstblood");
            processscoreevent(#"first_kill", attacker, victim, weapon);
            level.var_a033439c.firstblood = gettime();
            util::function_d1f9db00(22, attacker.team, attacker getentitynumber());
        } else {
            if (isdefined(attacker.lastkilledby)) {
                if (attacker.lastkilledby == victim) {
                    level.globalpaybacks++;
                    processscoreevent(#"revenge_kill", attacker, victim, weapon);
                    attacker stats::function_4f10b697(weapon, #"revenge_kill", 1);
                    victim recordkillmodifier("revenge");
                    attacker.lastkilledby = undefined;
                }
            }
            if (victim killstreaks::is_an_a_killstreak()) {
                level.globalbuzzkills++;
                processscoreevent(#"stop_enemy_killstreak", attacker, victim, weapon);
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
                attacker challenges::longdistancekillmp(weapon);
                if (weapon.rootweapon.name == "hatchet") {
                    attacker challenges::longdistancehatchetkill();
                }
                processscoreevent(#"longshot_kill", attacker, victim, weapon);
                attacker.pers[#"longshots"]++;
                attacker.longshots = attacker.pers[#"longshots"];
                victim recordkillmodifier("longshot");
            }
            killdistance = distance(victim.origin, attackerorigin);
            attacker.pers[#"kill_distances"] = attacker.pers[#"kill_distances"] + killdistance;
            attacker.pers[#"num_kill_distance_entries"]++;
        }
        if (isalive(attacker)) {
            if (attacker.health < attacker.maxhealth * 0.35) {
                attacker.lastkillwheninjured = time;
                processscoreevent(#"kill_enemy_when_injured", attacker, victim, weapon);
                attacker stats::function_4f10b697(weapon, #"kill_enemy_when_injured", 1);
                if (attacker util::has_toughness_perk_purchased_and_equipped()) {
                    attacker stats::function_b48aa4e(#"perk_bulletflinch_kills", 1);
                }
            }
        } else if (isdefined(attacker.deathtime) && attacker.deathtime + 800 < time && !attacker isinvehicle()) {
            level.globalafterlifes++;
            processscoreevent(#"kill_enemy_after_death", attacker, victim, weapon);
            victim recordkillmodifier("posthumous");
        }
        if (attacker.cur_death_streak >= 3) {
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
                attacker function_b5489c4b(weapon, 1);
            }
        }
        if (weapon_utils::ismeleemod(meansofdeath) && !weapon.isriotshield) {
            attacker.pers[#"stabs"]++;
            attacker.stabs = attacker.pers[#"stabs"];
            vangles = victim.anglesondeath[1];
            pangles = attacker.anglesonkill[1];
            anglediff = angleclamp180(vangles - pangles);
            if (isdefined(weapon.var_9a6ce18e) && weapon.var_9a6ce18e && anglediff > -30 && anglediff < 70) {
                level.globalbackstabs++;
                processscoreevent(#"backstabber_kill", attacker, victim, weapon);
                var_199b56 = 1;
                weaponpickedup = 0;
                if (isdefined(attacker.pickedupweapons) && isdefined(attacker.pickedupweapons[weapon])) {
                    weaponpickedup = 1;
                }
                attacker stats::function_c8a05f4f(weapon, #"backstabber_kill", 1, attacker.class_num, weaponpickedup);
                attacker.pers[#"backstabs"]++;
                attacker.backstabs = attacker.pers[#"backstabs"];
            } else if (!(isdefined(weapon.var_9a6ce18e) && weapon.var_9a6ce18e) && (anglediff < -30 || anglediff > 70 || isdefined(victim.laststand) && victim.laststand)) {
                if (meansofdeath == "MOD_MELEE_WEAPON_BUTT" && weapon.name != "ball") {
                    processscoreevent(#"kill_enemy_with_gunbutt", attacker, victim, weapon);
                } else if (weapon_utils::ispunch(weapon)) {
                    processscoreevent(#"kill_enemy_with_fists", attacker, victim, weapon);
                }
            }
        } else if (weapon.inventorytype != "ability" && isdefined(victim.firsttimedamaged) && victim.firsttimedamaged == time) {
            if (attackershotvictim) {
                attacker thread updateoneshotmultikills(victim, weapon, victim.firsttimedamaged);
                attacker stats::function_4f10b697(weapon, #"kill_enemy_one_bullet", 1);
            }
        }
        if (isdefined(victim.var_73b9d5c8) && attacker == victim.var_73b9d5c8 && victim.var_d7ff854d + 2000 > gettime()) {
            destroyedarmor = 1;
        } else if (meansofdeath == "MOD_HEAD_SHOT" && (isdefined(victim.armor) ? victim.armor : 0) > 0) {
            destroyedarmor = 1;
        }
        if (isdefined(destroyedarmor) && destroyedarmor) {
            processscoreevent(#"kill_enemy_with_armor", attacker, victim, weapon);
        }
        assert(isdefined(attacker));
        assert(isdefined(attacker.tookweaponfrom), "<dev string:x30>" + attacker getentnum() + "<dev string:x38>");
        if (isdefined(attacker.tookweaponfrom[weapon]) && isdefined(attacker.tookweaponfrom[weapon].previousowner)) {
            pickedupweapon = attacker.tookweaponfrom[weapon];
            if (pickedupweapon.previousowner == victim) {
                processscoreevent(#"kill_enemy_with_their_weapon", attacker, victim, weapon);
                attacker stats::function_4f10b697(weapon, #"kill_enemy_with_their_weapon", 1);
                if (isdefined(pickedupweapon.sweapon) && isdefined(pickedupweapon.smeansofdeath) && weapon_utils::ismeleemod(pickedupweapon.smeansofdeath)) {
                    foreach (meleeweapon in level.meleeweapons) {
                        if (weapon != meleeweapon && pickedupweapon.sweapon.rootweapon == meleeweapon) {
                            attacker stats::function_4f10b697(meleeweapon, #"kill_enemy_with_their_weapon", 1);
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
        attacker stats::function_b48aa4e(#"kill_as_support_gunner", 1);
        processscoreevent(#"mothership_assist_kill", level.vtol.owner, victim, weapon);
    }
    if (isdefined(var_c500bb2f) && time - var_c500bb2f < 5300) {
        processscoreevent(#"alarm_kill", attacker, victim, weapon);
    }
    if (isdefined(data.var_b83eae54) && data.var_b83eae54) {
    }
    switch (weapon.rootweapon.name) {
    case #"hatchet":
        attacker.pers[#"tomahawks"]++;
        attacker.tomahawks = attacker.pers[#"tomahawks"];
        processscoreevent(#"hatchet_kill", attacker, victim, weapon);
        if (isdefined(data.victim.explosiveinfo[#"projectile_bounced"]) && data.victim.explosiveinfo[#"projectile_bounced"] == 1) {
            level.globalbankshots++;
            processscoreevent(#"bounce_hatchet_kill", attacker, victim, weapon);
        }
        break;
    case #"supplydrop":
    case #"inventory_supplydrop":
    case #"supplydrop_marker":
    case #"inventory_supplydrop_marker":
        if (meansofdeath == "MOD_HIT_BY_OBJECT" || meansofdeath == "MOD_CRUSH") {
            processscoreevent(#"kill_enemy_with_care_package_crush", attacker, victim, weapon);
        } else {
            processscoreevent(#"kill_enemy_with_hacked_care_package", attacker, victim, weapon);
        }
        break;
    }
    if (isdefined(killstreak)) {
        attacker thread updatemultikills(weapon, weaponclass, killstreak, victim);
        victim recordkillmodifier("killstreak");
    }
    attacker.cur_death_streak = 0;
    attacker disabledeathstreak();
}

// Namespace scoreevents/scoreevents
// Params 1, eflags: 0x0
// Checksum 0x1223a55f, Offset: 0x4fe0
// Size: 0x2a
function get_equipped_hero_ability(ability_name) {
    if (!isdefined(ability_name)) {
        return undefined;
    }
    return getweapon(ability_name);
}

// Namespace scoreevents/scoreevents
// Params 3, eflags: 0x0
// Checksum 0x429826c2, Offset: 0x5018
// Size: 0x2b4
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
    case #"eq_arm_blade":
    case #"hero_armblade":
        event = "armblades_kill";
        break;
    case #"hero_bowlauncher2":
    case #"hero_bowlauncher3":
    case #"hero_bowlauncher4":
    case #"sig_bow_quickshot3":
    case #"sig_bow_quickshot2":
    case #"sig_bow_quickshot4":
    case #"sig_bow_quickshot":
    case #"hero_bowlauncher":
        event = "bowlauncher_kill";
        break;
    case #"sig_minigun_alt":
    case #"sig_minigun":
    case #"sig_minigun_turret_28":
    case #"hash_5a34aef4b8c72a24":
    case #"sig_minigun_turret_32":
    case #"hash_5a3832f4b8ca4047":
    case #"hash_5a492ef4b8d8acae":
    case #"hash_5a4932f4b8d8b37a":
        if (attacker function_80cbd71f() && attacker playerads() == 1) {
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
// Params 6, eflags: 0x0
// Checksum 0x19494277, Offset: 0x52d8
// Size: 0x1f4
function killedheavyweaponenemy(attacker, victim, weapon, victim_weapon, victim_gadget_power, victimgadgetwasactivelastdamage) {
    if (!isdefined(victim_weapon)) {
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
        if (isdefined(victim.heavyweapon) && victim.heavyweapon.name == "hero_armblade" && victimgadgetwasactivelastdamage) {
            event = "killed_armblades_enemy";
        } else {
            return;
        }
        break;
    }
    processscoreevent(event, attacker, victim, weapon);
    attacker util::player_contract_event("killed_hero_weapon_enemy");
}

// Namespace scoreevents/scoreevents
// Params 5, eflags: 0x0
// Checksum 0xee114843, Offset: 0x54d8
// Size: 0x464
function specificweaponkill(attacker, victim, weapon, killstreak, inflictor) {
    switchweapon = weapon.name;
    if (isdefined(killstreak)) {
        switchweapon = killstreak;
        bundle = level.killstreakbundle[killstreak];
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
        if (isdefined(inflictor) && isdefined(inflictor.controlled)) {
            if (inflictor.controlled == 1) {
                attacker stats::function_b48aa4e(#"kill_with_controlled_ai_tank", 1);
            }
        }
        break;
    case #"microwave_turret":
    case #"microwaveturret":
    case #"inventory_microwaveturret":
    case #"inventory_microwave_turret":
        event = "microwave_turret_kill";
        break;
    case #"hash_54f8725ff685c2c4":
    case #"raps":
        event = "raps_kill";
        break;
    case #"hash_3021ac1b3725f600":
    case #"sentinel":
        event = "sentinel_kill";
        if (isdefined(inflictor) && isdefined(inflictor.controlled)) {
            if (inflictor.controlled == 1) {
                attacker stats::function_b48aa4e(#"hash_3c5cf6f4fae0b8c6", 1);
            }
        }
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
    case #"dart":
    case #"inventory_dart":
    case #"dart_turret":
        event = "dart_kill";
        break;
    case #"incendiary_fire":
        event = "thermite_kill";
        break;
    case #"eq_frag_gun":
        event = "frag_kill";
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
// Params 2, eflags: 0x0
// Checksum 0x410315d, Offset: 0x5948
// Size: 0x1ac
function multikill(killcount, weapon) {
    assert(killcount > 1);
    self challenges::multikill(killcount, weapon);
    if (killcount > 7) {
        processscoreevent(#"multikill_more_than_7", self, undefined, weapon);
    } else {
        processscoreevent(#"multikill_" + killcount, self, undefined, weapon);
    }
    if (killcount > 3) {
        util::function_d1f9db00(19, self.team, self getentitynumber(), killcount);
    }
    if (killcount > 2) {
        if (isdefined(self.challenge_objectivedefensivekillcount) && self.challenge_objectivedefensivekillcount > 0) {
            self.challenge_objectivedefensivetriplekillmedalorbetterearned = 1;
        }
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
// Params 2, eflags: 0x0
// Checksum 0xbe3548cb, Offset: 0x5b00
// Size: 0x12c
function multiheroabilitykill(killcount, weapon) {
    if (killcount > 1) {
        self stats::function_b48aa4e(#"multikill_2_with_heroability", int(killcount / 2));
        self stats::function_4f10b697(weapon, #"heroability_doublekill", int(killcount / 2));
        self stats::function_b48aa4e(#"multikill_3_with_heroability", int(killcount / 3));
        self stats::function_4f10b697(weapon, #"heroability_triplekill", int(killcount / 3));
    }
}

// Namespace scoreevents/scoreevents
// Params 4, eflags: 0x0
// Checksum 0x491b17f3, Offset: 0x5c38
// Size: 0x18a
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
        if (baseweapon == level.weaponspecialcrossbow && meansofdeath == "MOD_IMPACT") {
            valid_weapon = 1;
        } else if ((baseweapon.forcedamagehitlocation || baseweapon == level.weaponshotgunenergy) && meansofdeath == "MOD_PROJECTILE") {
            valid_weapon = 1;
        }
    }
    return valid_weapon;
}

// Namespace scoreevents/scoreevents
// Params 4, eflags: 0x0
// Checksum 0x5d994acc, Offset: 0x5dd0
// Size: 0x146
function function_22ab88ed(victim, weapon, weaponclass, killstreak) {
    self endon(#"disconnect");
    level endon(#"game_ended");
    self notify(#"hash_668a2f2b276e44ad");
    self endon(#"hash_668a2f2b276e44ad");
    if (!isdefined(self.var_1b55e77a) || self.var_253ec259 != victim.explosiveinfo[#"damageid"]) {
        self.var_1b55e77a = 0;
    }
    self.var_253ec259 = victim.explosiveinfo[#"damageid"];
    self.var_1b55e77a++;
    self waittilltimeoutordeath(0.05);
    if (self.var_1b55e77a >= 2) {
        processscoreevent(#"hash_665ed726363e8b77", self, victim, weapon);
    }
    self.var_1b55e77a = 0;
}

// Namespace scoreevents/scoreevents
// Params 4, eflags: 0x0
// Checksum 0xc72cda1a, Offset: 0x5f20
// Size: 0xed4
function updatemultikills(weapon, weaponclass, killstreak, victim) {
    self endon(#"disconnect");
    level endon(#"game_ended");
    self notify(#"updaterecentkills");
    self endon(#"updaterecentkills");
    baseweapon = weapons::getbaseweapon(weapon);
    if (!isdefined(self.recentkillvariables)) {
        self resetrecentkillvariables();
    }
    if (!isdefined(self.recentkillcountweapon) || self.recentkillcountweapon != baseweapon) {
        self.recentkillcountsameweapon = 0;
        self.recentkillcountweapon = baseweapon;
    }
    if (!isdefined(killstreak)) {
        self.recentkillcountsameweapon++;
        self.recentkillcount++;
    }
    if (isdefined(baseweapon.issignatureweapon) && baseweapon.issignatureweapon || isdefined(baseweapon.var_ee15463f) && baseweapon.var_ee15463f) {
        self.var_65c871c0++;
        if (self.var_65c871c0 > 8) {
            processscoreevent(#"hash_658629ce68f99fb5", self, victim, weapon);
        } else if (self.var_65c871c0 > 1) {
            scorestr = "specialist_weapon_equipment_multikill_x" + self.var_65c871c0;
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
        case #"hero_armblade":
            self.recentarmbladecount++;
            break;
        }
    }
    if (self.var_53be3fe2 && weapon.name == #"eq_gravityslam") {
        self.var_324bc5e8++;
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
        case #"m32":
        case #"inventory_m32":
            self.recentmglkillcount++;
            break;
        }
    }
    if (self.recentkillcountsameweapon == 2) {
        self stats::function_4f10b697(weapon, #"multikill_2", 1);
    } else if (self.recentkillcountsameweapon == 3) {
        self stats::function_4f10b697(weapon, #"multikill_3", 1);
    }
    self waittilltimeoutordeath(4);
    if (self.recent_lmg_smg_killcount >= 3) {
        self challenges::multi_lmg_smg_kill();
    }
    if (self.recentrcbombkillcount >= 2) {
        self challenges::multi_rcbomb_kill();
    }
    if (self.recentmglkillcount >= 3) {
        self challenges::multi_mgl_kill();
    }
    if (self.recentremotemissilekillcount >= 3) {
        self challenges::multi_remotemissile_kill();
    }
    if (isdefined(self.recentheroweaponkillcount) && self.recentheroweaponkillcount > 1) {
        self hero_weapon_multikill_event(self.recentheroweaponkillcount, weapon);
    }
    if (self.recentheavyweaponkillcount > 5) {
        arrayremovevalue(self.recentheavyweaponvictims, undefined);
        if (self.recentheavyweaponvictims.size > 5) {
            self stats::function_b48aa4e(#"kill_entire_team_with_specialist_weapon", 1);
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
        self stats::function_b48aa4e(#"multikill_3_remote_missile", 1);
    }
    if (self.recentrcbombcount >= 2) {
        self stats::function_b48aa4e(#"multikill_2_rcbomb", 1);
    }
    if (self.recentlethalcount >= 2) {
        if (!isdefined(self.pers[#"challenge_kills_double_kill_lethal"])) {
            self.pers[#"challenge_kills_double_kill_lethal"] = 0;
        }
        self.pers[#"challenge_kills_double_kill_lethal"]++;
        if (self.pers[#"challenge_kills_double_kill_lethal"] >= 3) {
            self stats::function_b48aa4e(#"kills_double_kill_3_lethal", 1);
        }
    }
    if (self.recentkillcount > 1) {
        self multikill(self.recentkillcount, weapon);
    }
    if (self.recentheroabilitykillcount > 1) {
        self multiheroabilitykill(self.recentheroabilitykillcount, self.recentheroabilitykillweapon);
        self hero_ability_multikill_event(self.recentheroabilitykillcount, self.recentheroabilitykillweapon);
    }
    if (self.var_324bc5e8 >= 2) {
        event = "grapple_slam_multikill_" + self.var_324bc5e8;
        processscoreevent(event, self, victim, weapon);
    }
    self resetrecentkillvariables();
}

// Namespace scoreevents/scoreevents
// Params 0, eflags: 0x0
// Checksum 0xb5581105, Offset: 0x6e00
// Size: 0x12a
function resetrecentkillvariables() {
    self.recentanihilatorcount = 0;
    self.recent_lmg_smg_killcount = 0;
    self.recentarmbladecount = 0;
    self.recentbowlaunchercount = 0;
    self.recentc4killcount = 0;
    self.recentflamethrowercount = 0;
    self.recentgelguncount = 0;
    self.var_324bc5e8 = 0;
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
    self.recentremotemissilecount = 0;
    self.recentremotemissilekillcount = 0;
    self.var_65c871c0 = 0;
    self.recentkillvariables = 1;
}

// Namespace scoreevents/scoreevents
// Params 1, eflags: 0x0
// Checksum 0xc54190e, Offset: 0x6f38
// Size: 0x26
function waittilltimeoutordeath(timeout) {
    self endon(#"death");
    wait timeout;
}

// Namespace scoreevents/scoreevents
// Params 3, eflags: 0x0
// Checksum 0x947636fa, Offset: 0x6f68
// Size: 0x1ae
function updateoneshotmultikills(victim, weapon, firsttimedamaged) {
    self endon(#"death");
    self endon(#"disconnect");
    self notify("updateoneshotmultikills" + firsttimedamaged);
    self endon("updateoneshotmultikills" + firsttimedamaged);
    if (!isdefined(self.oneshotmultikills) || firsttimedamaged > (isdefined(self.oneshotmultikillsdamagetime) ? self.oneshotmultikillsdamagetime : 0)) {
        self.oneshotmultikills = 0;
    }
    self.oneshotmultikills++;
    self.oneshotmultikillsdamagetime = firsttimedamaged;
    wait 1;
    if (self.oneshotmultikills > 1) {
        if (weapon.statindex == level.weapon_hero_annihilator.statindex) {
            processscoreevent(#"hash_38ce4ad6f4be82b8", self, victim, weapon);
        } else {
            processscoreevent(#"kill_enemies_one_bullet", self, victim, weapon);
        }
    } else if (weapon.statindex != level.weapon_hero_annihilator.statindex) {
        processscoreevent(#"kill_enemy_one_bullet", self, victim, weapon);
    }
    self.oneshotmultikills = 0;
}

// Namespace scoreevents/scoreevents
// Params 2, eflags: 0x0
// Checksum 0xdef21827, Offset: 0x7120
// Size: 0x216
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
        distance = 2250000;
        break;
    case #"weapon_assault":
        distance = 3062500;
        break;
    case #"weapon_tactical":
        distance = 3062500;
        break;
    case #"weapon_lmg":
        distance = 3062500;
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
        if (weapon == level.weaponballisticknife || baseweapon == level.weaponspecialcrossbow) {
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
// Params 1, eflags: 0x0
// Checksum 0x224359d3, Offset: 0x7340
// Size: 0x19c
function ongameend(data) {
    player = data.player;
    winner = data.winner;
    if (isdefined(winner)) {
        if (level.teambased) {
            if (!match::get_flag("tie") && player.team == winner) {
                processscoreevent(#"won_match", player, undefined, undefined);
                return;
            }
        } else {
            placement = level.placement[#"all"];
            topthreeplayers = min(3, placement.size);
            for (index = 0; index < topthreeplayers; index++) {
                if (level.placement[#"all"][index] == player) {
                    processscoreevent(#"won_match", player, undefined, undefined);
                    return;
                }
            }
        }
    }
    processscoreevent(#"completed_match", player, undefined, undefined);
}

// Namespace scoreevents/scoreevents
// Params 0, eflags: 0x0
// Checksum 0x3f31d6aa, Offset: 0x74e8
// Size: 0xc4
function specialistmedalachievement() {
    if (level.rankedmatch) {
        if (!isdefined(self.pers[#"specialistmedalachievement"])) {
            self.pers[#"specialistmedalachievement"] = 0;
        }
        self.pers[#"specialistmedalachievement"]++;
        if (self.pers[#"specialistmedalachievement"] == 5) {
            self giveachievement("MP_SPECIALIST_MEDALS");
        }
        self util::player_contract_event("earned_specialist_ability_medal");
    }
}

// Namespace scoreevents/scoreevents
// Params 2, eflags: 0x0
// Checksum 0x53d37fe9, Offset: 0x75b8
// Size: 0x256
function specialiststatabilityusage(usagesinglegame, multitrackperlife) {
    self endon(#"disconnect");
    level endon(#"game_ended");
    self notify(#"updatethread specialiststatabilityusage");
    self endon(#"updatethread specialiststatabilityusage");
    isroulette = self.isroulette === 1;
    if (isdefined(self.heroability) && !isroulette) {
        self function_b5489c4b(self.heroability, 1);
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
// Params 1, eflags: 0x0
// Checksum 0x539923a9, Offset: 0x7818
// Size: 0x6e
function function_66d24d75(weapon) {
    baseweapon = weapons::getbaseweapon(weapon);
    return isdefined(baseweapon.issignatureweapon) && baseweapon.issignatureweapon || isdefined(baseweapon.var_ee15463f) && baseweapon.var_ee15463f;
}

// Namespace scoreevents/scoreevents
// Params 0, eflags: 0x0
// Checksum 0xc147c3b3, Offset: 0x7890
// Size: 0x4c
function multikillmedalachievement() {
    if (level.rankedmatch) {
        self giveachievement("MP_MULTI_KILL_MEDALS");
        self challenges::processspecialistchallenge("multikill_weapon");
    }
}

// Namespace scoreevents/scoreevents
// Params 2, eflags: 0x0
// Checksum 0x1d0bb0e3, Offset: 0x78e8
// Size: 0x102
function function_dd6dafbf(entity, sensor_darts) {
    foreach (sensor in sensor_darts) {
        if (!isdefined(sensor)) {
            continue;
        }
        if (distancesquared(entity.origin, sensor.origin) < ((sessionmodeiswarzonegame() ? 2400 : 800) + 50) * ((sessionmodeiswarzonegame() ? 2400 : 800) + 50)) {
            return sensor;
        }
    }
    return undefined;
}

// Namespace scoreevents/scoreevents
// Params 1, eflags: 0x0
// Checksum 0xdcf8bf75, Offset: 0x79f8
// Size: 0x82
function function_afd1c30c(sensor_darts) {
    foreach (sensor in sensor_darts) {
        if (!isdefined(sensor)) {
            continue;
        }
        sensor.var_56e8339c = 0;
    }
}

// Namespace scoreevents/scoreevents
// Params 3, eflags: 0x0
// Checksum 0xa786b1db, Offset: 0x7a88
// Size: 0x2cc
function function_29b88aa6(attacker, victim, attackerweapon) {
    if (!isdefined(level.smartcoversettings) || !isdefined(level.smartcoversettings.var_d8404722)) {
        return;
    }
    if (isdefined(attackerweapon) && isdefined(level.iskillstreakweapon) && [[ level.iskillstreakweapon ]](attackerweapon)) {
        return 0;
    }
    foreach (smartcover in level.smartcoversettings.var_d8404722) {
        if (!isdefined(smartcover)) {
            continue;
        }
        if (victim == smartcover.owner) {
            continue;
        }
        var_6bb3efd = distancesquared(smartcover.origin, attacker.origin);
        if (var_6bb3efd > level.smartcoversettings.var_bee3c05a) {
            continue;
        }
        var_d280e2c4 = distancesquared(victim.origin, smartcover.origin);
        var_9bdfaca3 = distancesquared(victim.origin, attacker.origin);
        var_bede1ff6 = var_9bdfaca3 > var_6bb3efd;
        var_9b852882 = var_9bdfaca3 > var_d280e2c4;
        if (var_bede1ff6 && var_9b852882) {
            var_9308fab1 = 1;
            var_7b62838a = smartcover.owner;
            break;
        }
    }
    if (isdefined(var_7b62838a) && isdefined(var_9308fab1) && var_9308fab1) {
        if (smartcover.owner == attacker) {
            processscoreevent(#"deployable_cover_kill", var_7b62838a, victim, level.smartcoversettings.smartcoverweapon);
            return;
        }
        processscoreevent(#"deployable_cover_assist", var_7b62838a, victim, level.smartcoversettings.smartcoverweapon);
    }
}

