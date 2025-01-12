#using script_7f6cd71c43c45c57;
#using scripts\core_common\activecamo_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\contracts_shared;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\weapons_shared;
#using scripts\killstreaks\emp_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\mp\uav;
#using scripts\mp_common\gametypes\match;
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\scoreevents;
#using scripts\mp_common\util;
#using scripts\weapons\weapon_utils;

#namespace challenges;

// Namespace challenges/challenges
// Params 0, eflags: 0x6
// Checksum 0xb93cd254, Offset: 0x438
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"challenges", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace challenges/challenges
// Params 0, eflags: 0x5 linked
// Checksum 0x18464d09, Offset: 0x480
// Size: 0x194
function private function_70a657d8() {
    if (!isdefined(level.challengescallbacks)) {
        level.challengescallbacks = [];
    }
    callback::on_start_gametype(&start_gametype);
    callback::on_spawned(&on_player_spawn);
    callback::add_callback(#"scavenged_primary_grenade", &scavenged_primary_grenade);
    level.heroabilityactivateneardeath = &heroabilityactivateneardeath;
    level.var_c8de519d = {};
    level.var_c8de519d.multikill = &function_19e8b086;
    level.var_c8de519d.var_ec391d55 = &function_3ee91387;
    level.var_7897141a = [];
    level.var_7897141a[getweapon(#"hash_66401df7cd6bf292")] = 1;
    level.var_7897141a[getweapon(#"hash_3f62a872201cd1ce")] = 1;
    level.var_ca4ce464 = [];
    level.var_ca4ce464[getweapon(#"ability_smart_cover")] = 1;
}

// Namespace challenges/challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x76b505ca, Offset: 0x620
// Size: 0x104
function start_gametype() {
    waittillframeend();
    if (isdefined(level.scoreeventgameendcallback)) {
        registerchallengescallback("gameEnd", level.scoreeventgameendcallback);
    }
    if (canprocesschallenges()) {
        registerchallengescallback("playerKilled", &challengekills);
        registerchallengescallback("gameEnd", &challengegameendmp);
        player::function_3c5cc656(&function_a79ea08b);
        self callback::add_callback(#"done_healing", &player_fully_healed);
    }
    callback::on_connect(&on_player_connect);
}

// Namespace challenges/challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xfb924cbf, Offset: 0x730
// Size: 0x1e
function on_player_connect() {
    profilestart();
    initchallengedata();
    profilestop();
}

// Namespace challenges/challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xf4539403, Offset: 0x758
// Size: 0x1ac
function initchallengedata() {
    self.var_9cd2c51d = {};
    self.pers[#"stickexplosivekill"] = 0;
    self.pers[#"carepackagescalled"] = 0;
    self.pers[#"challenge_destroyed_air"] = 0;
    self.pers[#"challenge_destroyed_ground"] = 0;
    self.pers[#"challenge_anteup_earn"] = 0;
    self.pers[#"specialiststatabilityusage"] = 0;
    self.pers[#"activekillstreaks"] = [];
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
    self.challenge_scavengedcount = 0;
    self.challenge_resuppliednamekills = 0;
    self.challenge_objectivedefensive = undefined;
    self.challenge_objectiveoffensive = undefined;
    self.challenge_lastsurvivewithflakfrom = undefined;
    self.explosiveinfo = [];
    self function_6b34141d();
}

// Namespace challenges/challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x47e6132, Offset: 0x910
// Size: 0x56
function function_6b34141d() {
    self.weaponkillsthisspawn = [];
    self.var_93da0d74 = [];
    self.var_c9062c1c = [];
    self.attachmentkillsthisspawn = [];
    self.challenge_hatchettosscount = 0;
    self.challenge_hatchetkills = 0;
    self.challenge_combatrobotattackclientid = [];
}

// Namespace challenges/weapon_change
// Params 1, eflags: 0x40
// Checksum 0x38ab3dd6, Offset: 0x970
// Size: 0x122
function event_handler[weapon_change] function_edc4ebe8(eventstruct) {
    if (!isdefined(self.var_ea1458aa)) {
        return;
    }
    var_f2b25a4e = self isusingoffhand() ? self getcurrentoffhand() : eventstruct.weapon;
    if (var_f2b25a4e.var_76ce72e8) {
        self.var_ea1458aa.var_59ac2f5 = undefined;
        scoreevents = globallogic_score::function_3cbc4c6c(var_f2b25a4e.var_2e4a8800);
        if (isdefined(scoreevents) && scoreevents.var_fcd2ff3a === 1) {
            self.var_ea1458aa.var_59ac2f5 = 0;
        }
        return;
    }
    if (!isdefined(level.var_ca4ce464) || level.var_ca4ce464[var_f2b25a4e] !== 1) {
        self.var_ea1458aa.var_96d50420 = undefined;
        if (var_f2b25a4e.issignatureweapon) {
            self.var_ea1458aa.var_96d50420 = 0;
        }
    }
}

// Namespace challenges/offhand_fire
// Params 1, eflags: 0x40
// Checksum 0x2de6b9fa, Offset: 0xaa0
// Size: 0x2e
function event_handler[offhand_fire] function_97023fdf(eventstruct) {
    if (!isdefined(self.var_ea1458aa)) {
        return;
    }
    newweapon = eventstruct.weapon;
}

// Namespace challenges/grenade_fire
// Params 1, eflags: 0x40
// Checksum 0x53b6b81a, Offset: 0xad8
// Size: 0x202
function event_handler[grenade_fire] function_4776caf4(eventstruct) {
    if (!isplayer(self)) {
        return;
    }
    newweapon = eventstruct.weapon;
    if (isdefined(self.var_9cd2c51d)) {
        if (isdefined(level.var_ca4ce464) && level.var_ca4ce464[newweapon] === 1) {
            self.var_9cd2c51d.var_d298c9a8 = undefined;
            if (newweapon.issignatureweapon) {
                self.var_9cd2c51d.var_d298c9a8 = 0;
            }
        }
    }
    if (isdefined(self.var_ea1458aa)) {
        if (isdefined(level.var_7897141a) && level.var_7897141a[newweapon] !== 1) {
            if (!newweapon.issignatureweapon) {
                self.var_ea1458aa.var_59ac2f5 = undefined;
                if (newweapon.var_76ce72e8) {
                    scoreevents = globallogic_score::function_3cbc4c6c(newweapon.var_2e4a8800);
                    if (isdefined(scoreevents) && scoreevents.var_fcd2ff3a === 1) {
                        self.var_ea1458aa.var_59ac2f5 = 0;
                    }
                }
            }
        }
    }
    if (level.var_e7c95d09 !== 1) {
        if (isdefined(eventstruct.projectile)) {
            grenade = eventstruct.projectile;
            weapon = eventstruct.weapon;
            if (weapon.rootweapon.name == "hatchet") {
                self.challenge_hatchettosscount++;
                grenade.challenge_hatchettosscount = self.challenge_hatchettosscount;
            }
            if (self issprinting()) {
                grenade.ownerwassprinting = 1;
            }
        }
    }
}

// Namespace challenges/challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xa8fbf2bf, Offset: 0xce8
// Size: 0xee
function player_fully_healed() {
    var_c3ade07c = self.var_ea1458aa;
    info = self.var_9cd2c51d;
    if (isdefined(var_c3ade07c) && isdefined(info)) {
        if (isdefined(info.var_6e219f3c) && info.var_6e219f3c <= 52) {
            if (!isdefined(var_c3ade07c.recover_full_health_from_critical)) {
                var_c3ade07c.recover_full_health_from_critical = 0;
            }
            var_c3ade07c.recover_full_health_from_critical++;
            if (var_c3ade07c.recover_full_health_from_critical >= 3) {
                self stats::function_dad108fa(#"recover_full_health_from_critical", 1);
                var_c3ade07c.recover_full_health_from_critical = undefined;
            }
            var_c3ade07c.var_55a37dc7 = 1;
        } else {
            var_c3ade07c.var_55a37dc7 = 0;
        }
        var_c3ade07c.var_a440c10 = gettime();
    }
}

// Namespace challenges/challenges
// Params 1, eflags: 0x1 linked
// Checksum 0xace4c8c7, Offset: 0xde0
// Size: 0x2c
function scavenged_primary_grenade(*params) {
    if (!isdefined(self.challenge_scavengedcount)) {
        self.challenge_scavengedcount = 0;
    }
    self.challenge_scavengedcount++;
}

// Namespace challenges/jump_begin
// Params 1, eflags: 0x40
// Checksum 0xaf57dc60, Offset: 0xe18
// Size: 0x16
function event_handler[jump_begin] function_6a50096c(*eventstruct) {
    self.challenge_jump_begin = gettime();
}

// Namespace challenges/sprint_end
// Params 1, eflags: 0x40
// Checksum 0x52701219, Offset: 0xe38
// Size: 0x16
function event_handler[sprint_end] function_a65ce628(*eventstruct) {
    self.challenge_sprint_end = gettime();
}

// Namespace challenges/challenges
// Params 4, eflags: 0x1 linked
// Checksum 0x573a29bc, Offset: 0xe58
// Size: 0x2684
function function_a79ea08b(*einflictor, victim, *idamage, weapon) {
    if (!isdefined(self) || !isplayer(self) || !isdefined(idamage) || !isplayer(idamage)) {
        return;
    }
    if (!isdefined(weapon) || !isdefined(idamage.var_ea1458aa) || !isdefined(idamage.var_ea1458aa.attackerdamage)) {
        return;
    }
    if (level.teambased) {
        if (self.team == idamage.team) {
            return;
        }
    } else if (self == idamage) {
        return;
    }
    time = gettime();
    var_5afc3871 = self function_65776b07();
    killstreak = killstreaks::get_from_weapon(weapon);
    if (!isdefined(killstreak)) {
        var_6af452fc = function_2e532eed(idamage.var_ea1458aa.attackerdamage[self.clientid]);
        var_5018995b = idamage.gadget_weapon;
        var_bcbcb4ec = isdefined(level.var_49ef5263) ? idamage [[ level.var_49ef5263 ]]() : 0;
        var_fff76b4 = idamage.var_b6672e47;
        totalenemies = countplayers(idamage.team);
        victimentnum = idamage getentitynumber();
        var_3cd641b = var_6af452fc.class_num;
        if (!isdefined(self.var_ea1458aa)) {
            self.var_ea1458aa = {};
        }
        if (!isdefined(self.var_ea1458aa.ekia)) {
            self.var_ea1458aa.ekia = [];
        }
        if (!isdefined(self.var_ea1458aa.ekia[#"primary"])) {
            self.var_ea1458aa.ekia[#"primary"] = 0;
        }
        if (!isdefined(self.var_ea1458aa.ekia[#"secondary"])) {
            self.var_ea1458aa.ekia[#"secondary"] = 0;
        }
        isprimaryweapon = weapon.name == self function_b958b70d(var_3cd641b, "primary");
        var_197329e6 = weapon.name == self function_b958b70d(var_3cd641b, "secondary");
        if (isprimaryweapon) {
            self.var_ea1458aa.ekia[#"primary"]++;
        } else if (var_197329e6) {
            self.var_ea1458aa.ekia[#"secondary"]++;
        }
        if (self.var_ea1458aa.ekia[#"primary"] > 0 && self.var_ea1458aa.ekia[#"secondary"] > 0) {
            var_95ac2e77 = 1;
            self.var_ea1458aa.ekia[#"primary"]--;
            self.var_ea1458aa.ekia[#"secondary"]--;
        }
        scoreevents = globallogic_score::function_3cbc4c6c(weapon.var_2e4a8800);
        var_8a4cfbd = weapon.var_76ce72e8 && isdefined(scoreevents) && scoreevents.var_fcd2ff3a === 1;
        if (isdefined(self.var_9cd2c51d)) {
            if (weapon.issignatureweapon && isdefined(level.var_ca4ce464) && level.var_ca4ce464[weapon] === 1) {
                if (!isdefined(self.var_9cd2c51d.var_d298c9a8)) {
                    self.var_9cd2c51d.var_d298c9a8 = 0;
                }
                self.var_9cd2c51d.var_d298c9a8++;
                if (self.var_9cd2c51d.var_d298c9a8 % 4 == 0) {
                    var_828dac8f = 1;
                }
            }
        }
        if (!isdefined(var_828dac8f)) {
            if (weapon.issignatureweapon && isdefined(self.var_ea1458aa.var_96d50420)) {
                if (!isdefined(self.var_9cd2c51d.var_96d50420)) {
                    self.var_9cd2c51d.var_96d50420 = 0;
                }
                self.var_ea1458aa.var_96d50420++;
                if (self.var_ea1458aa.var_96d50420 % 4 == 0) {
                    var_828dac8f = 1;
                }
            } else if (var_8a4cfbd && isdefined(self.var_ea1458aa.var_59ac2f5)) {
                if (!isdefined(self.var_9cd2c51d.var_59ac2f5)) {
                    self.var_9cd2c51d.var_59ac2f5 = 0;
                }
                self.var_ea1458aa.var_59ac2f5++;
                if (self.var_ea1458aa.var_59ac2f5 % 4 == 0) {
                    var_828dac8f = 1;
                }
            }
        }
        var_ffe9dfa5 = self weaponhasattachmentandunlocked(weapon, "extclip");
        if (var_ffe9dfa5) {
            if (!isdefined(self.var_ea1458aa.var_23f5861b)) {
                self.var_ea1458aa.var_23f5861b = 0;
            }
            self.var_ea1458aa.var_23f5861b++;
        }
        if (totalenemies >= 4) {
            if (!isdefined(self.var_ea1458aa.ekia_every_enemy_onelife)) {
                self.var_ea1458aa.ekia_every_enemy_onelife = [];
            }
            self.var_ea1458aa.ekia_every_enemy_onelife[victimentnum] = 1;
            if (self.var_ea1458aa.ekia_every_enemy_onelife.size >= totalenemies) {
                var_2adaec2f = 1;
                self.var_ea1458aa.ekia_every_enemy_onelife = undefined;
            }
        }
        if (isdefined(level.var_1aef539f) && [[ level.var_1aef539f ]](idamage, self)) {
            var_1f0bdb8f = 1;
        }
        var_70137a58 = function_2e532eed(self.var_ea1458aa);
        if (!isdefined(var_5afc3871[#"talent_resistance"])) {
            var_2d4a24ea = self.var_ef9b6f0b === 1;
            var_6c5ba24c = self.lastflashedby === idamage;
            if (isdefined(self.var_121392a1) && isdefined(self.var_121392a1[#"shock_seeker_mine"])) {
                if (self.var_121392a1[#"shock_seeker_mine"].var_4b22e697 === idamage) {
                    var_ba9c5900 = 1;
                }
            }
        }
        var_30f88120 = scoreevents::function_c28e2c05(idamage.origin, var_6af452fc.sensordarts, 0);
    }
    util::waittillslowprocessallowed();
    if (!isdefined(self)) {
        return;
    }
    if (!isdefined(killstreak)) {
        weaponclass = util::getweaponclass(weapon);
        if (isdefined(var_3cd641b)) {
            if (isprimaryweapon) {
                self stats::function_dad108fa(#"ekia_primary_secondary_weapon", 1);
                if (weapon.attachments.size > 2) {
                    self stats::function_dad108fa(#"hash_6803083fa39064a4", 1);
                }
            } else if (var_197329e6) {
                self stats::function_dad108fa(#"ekia_primary_secondary_weapon", 1);
                if (weapon.attachments.size > 2) {
                    self stats::function_dad108fa(#"hash_7b0b54996f4aafbc", 1);
                }
            }
            if (var_95ac2e77 === 1) {
                if (self function_db654c9(var_3cd641b, #"bonuscard_overkill")) {
                    self stats::function_dad108fa(#"hash_33dd7ef72b15e6ac", 1);
                    self contracts::increment_contract(#"contract_mp_overkill");
                } else if (self function_db654c9(var_3cd641b, #"bonuscard_underkill")) {
                    self stats::function_dad108fa(#"hash_9cb265b8b1483b0", 1);
                }
            }
            talents = self function_4a9f1384(var_3cd641b);
            if (isdefined(talents) && isarray(talents)) {
                if (self function_db654c9(var_3cd641b, #"bonuscard_perk_1_greed")) {
                    if (isdefined(talents[0]) && talents[0] != #"weapon_null" && isdefined(talents[3]) && talents[3] != #"weapon_null") {
                        self stats::function_dad108fa(#"ekia_perk1_greed", 1);
                    }
                }
                if (self function_db654c9(var_3cd641b, #"bonuscard_perk_2_greed")) {
                    if (isdefined(talents[1]) && talents[1] != #"weapon_null" && isdefined(talents[4]) && talents[4] != #"weapon_null") {
                        self stats::function_dad108fa(#"ekia_perk2_greed", 1);
                    }
                }
                if (self function_db654c9(var_3cd641b, #"bonuscard_perk_3_greed")) {
                    if (isdefined(talents[2]) && talents[2] != #"weapon_null" && isdefined(talents[5]) && talents[5] != #"weapon_null") {
                        self stats::function_dad108fa(#"ekia_perk3_greed", 1);
                    }
                }
                arrayremovevalue(talents, #"weapon_null");
                if (talents.size > 2) {
                    var_ee03db9e = 0;
                    if (self function_db654c9(var_3cd641b, #"bonuscard_perk_1_gluttony")) {
                        self stats::function_dad108fa(#"ekia_perk1_gluttony", 1);
                        var_ee03db9e = 1;
                    } else if (self function_db654c9(var_3cd641b, #"bonuscard_perk_2_gluttony")) {
                        self stats::function_dad108fa(#"ekia_perk2_gluttony", 1);
                        var_ee03db9e = 1;
                    } else if (self function_db654c9(var_3cd641b, #"bonuscard_perk_3_gluttony")) {
                        self stats::function_dad108fa(#"ekia_perk3_gluttony", 1);
                        var_ee03db9e = 1;
                    }
                    if (var_ee03db9e) {
                        self contracts::increment_contract(#"contract_mp_class_gluttony");
                    }
                }
                if (talents.size >= 5) {
                    self contracts::increment_contract(#"contract_mp_class_5_perks");
                }
                if (isdefined(var_5afc3871[#"talent_resistance"])) {
                    if (var_6af452fc.var_5745c480 === 1) {
                        self stats::function_dad108fa(#"ekia_stunned_slowed_irradiated_cuav_resistance", 1);
                    } else if (isdefined(var_6af452fc.var_121392a1) && isarray(var_6af452fc.var_121392a1) && var_6af452fc.var_121392a1.size > 0) {
                        foreach (effect in var_6af452fc.var_121392a1) {
                            if (!isdefined(effect.var_4b22e697) || self == effect.var_4b22e697 || !isdefined(effect.var_3d1ed4bd)) {
                                continue;
                            }
                            switch (effect.var_3d1ed4bd.name) {
                            case #"ability_smart_cover":
                            case #"eq_swat_grenade":
                            case #"hash_3f62a872201cd1ce":
                            case #"eq_seeker_mine":
                            case #"eq_concertina_wire":
                            case #"eq_slow_grenade":
                            case #"gadget_radiation_field":
                                award = 1;
                                break;
                            default:
                                break;
                            }
                            if (award === 1) {
                                self stats::function_dad108fa(#"ekia_stunned_slowed_irradiated_cuav_resistance", 1);
                                break;
                            }
                        }
                    }
                }
                if (var_6af452fc.var_53611a9c === 1) {
                    if (isdefined(var_5afc3871[#"talent_teamlink"])) {
                        self stats::function_dad108fa(#"ekia_minimap_teamlink", 1);
                    }
                    if (isdefined(var_5afc3871[#"talent_tracker"])) {
                        self stats::function_dad108fa(#"ekia_tracker", 1);
                    }
                } else if (isdefined(var_5afc3871[#"talent_teamlink"]) && var_6af452fc.var_ec93e5f2 === 1) {
                    self stats::function_dad108fa(#"ekia_minimap_teamlink", 1);
                }
                if (isdefined(var_5afc3871[#"talent_deadsilence"])) {
                    self stats::function_dad108fa(#"ekia_deadsilence", 1);
                }
                if (isdefined(var_5afc3871[#"talent_ghost"]) && (var_6af452fc.var_8e35fb71 === 1 || var_6af452fc.var_efc9cf4d === 1)) {
                    self stats::function_dad108fa(#"ekia_enemy_uav_sensordart_ghost", 1);
                }
                if (isdefined(var_5afc3871[#"talent_gungho"]) && var_6af452fc.var_e8072c8d === 1) {
                    self stats::function_dad108fa(#"hash_cdd16b48f26b85f", 1);
                }
                if (isdefined(var_5afc3871[#"talent_dexterity"])) {
                    if (var_6af452fc.ismantling === 1 || var_6af452fc.var_bd77a1eb === 1 || var_6af452fc.isjumping === 1) {
                        self stats::function_dad108fa(#"ekia_swap_weapon_jump_mantle_dexterity", 1);
                    }
                }
                if (isdefined(var_5afc3871[#"talent_scavenger"]) && var_6af452fc.var_54433d4b === 1) {
                    self stats::function_dad108fa(#"ekia_ammo_pickup_scavenger", 1);
                }
            }
            wildcards = self function_6f2c0492(var_3cd641b);
            arrayremovevalue(wildcards, #"weapon_null");
            if (wildcards.size > 1) {
                self stats::function_dad108fa(#"hash_3c794263f2d7e231", 1);
            }
            gear = self function_b958b70d(var_3cd641b, "tacticalgear");
            if (isdefined(gear)) {
                switch (gear) {
                case #"gear_armor":
                    if (var_6af452fc.var_d7bd6f9b === 1) {
                        self stats::function_dad108fa(#"ekia_against_armor_damager", 1);
                    }
                    break;
                case #"gear_awareness":
                    minimaprange = function_fd82b127() * 0.5;
                    if (var_6af452fc.var_85997af0 < function_a3f6cdac(minimaprange)) {
                        self stats::function_dad108fa(#"ekia_minimap_awareness", 1);
                        if (isdefined(var_5afc3871[#"talent_tracker"]) && var_6af452fc.var_53611a9c === 1) {
                            self stats::function_dad108fa(#"ekia_minimap_awareness_tracker", 1);
                        }
                    }
                    break;
                case #"gear_equipmentcharge":
                    scoreevents = globallogic_score::function_3cbc4c6c(weapon.var_2e4a8800);
                    baseweapon = weapons::getbaseweapon(weapon);
                    if (baseweapon.var_76ce72e8 && isdefined(scoreevents) && scoreevents.var_fcd2ff3a === 1) {
                        self stats::function_dad108fa(#"ekia_specialist_equipment_equipmentcharge", 1);
                        if (!isdefined(self.var_9cd2c51d.var_b385927)) {
                            self.var_9cd2c51d.var_b385927 = 0;
                        }
                        self.var_9cd2c51d.var_b385927++;
                        if (self.var_9cd2c51d.var_b385927 == 7) {
                            self stats::function_dad108fa(#"hash_7db6a4180312b94c", 1);
                        }
                    }
                    break;
                case #"gear_medicalinjectiongun":
                    if (var_6af452fc.var_46a82df0 === 1) {
                        self stats::function_dad108fa(#"ekia_full_heal_medicalinjectiongun", 1);
                        if (var_6af452fc.var_69b66e8e === 1) {
                            self stats::function_dad108fa(#"ekia_critical_heal_medicalinjectiongun_revenge", 1);
                        }
                    }
                    break;
                case #"weapon_null":
                default:
                    break;
                }
            }
        }
        if (isdefined(level.gametype) && (level.gametype == #"tdm" || level.gametype == #"dm")) {
            if (level.hardcoremode) {
                self stats::function_dad108fa(#"ekia_hc_in_tdm_dm", 1);
            } else if (!level.arenamatch) {
                self stats::function_dad108fa(#"ekia_core_in_tdm_dm", 1);
            }
        }
        if (isdefined(weapon.attachments) && weapon.attachments.size > 0) {
            isads = is_true(var_6af452fc.isads);
            attachmentupgrades = 0;
            if (self weaponhasattachmentandunlocked(weapon, "grip")) {
                if (isads) {
                    self stats::function_dad108fa(#"ekia_ads_grip", 1);
                }
                if (self weaponhasattachmentandunlocked(weapon, "grip2")) {
                    attachmentupgrades++;
                }
            }
            if (self weaponhasattachmentandunlocked(weapon, "quickdraw")) {
                if (isads) {
                    self stats::function_dad108fa(#"ekia_ads_quickdraw", 1);
                }
                if (self weaponhasattachmentandunlocked(weapon, "quickdraw2")) {
                    attachmentupgrades++;
                }
            }
            if (self weaponhasattachmentandunlocked(weapon, "stalker")) {
                if (isads) {
                    self stats::function_dad108fa(#"ekia_ads_stalker", 1);
                }
                if (self weaponhasattachmentandunlocked(weapon, "stalker2")) {
                    attachmentupgrades++;
                }
            }
            if (isads) {
                if (self weaponhasattachmentandunlocked(weapon, "quickdraw", "stalker", "grip")) {
                    self stats::function_dad108fa(#"ekia_ads_quickdraw_stalker_grip", 1);
                }
            }
            if (var_ffe9dfa5 == 1) {
                if (var_70137a58.var_23f5861b % 2 == 0) {
                    self stats::function_dad108fa(#"hash_779e1fc5021c532c", 1);
                }
                if (self weaponhasattachmentandunlocked(weapon, "extclip2")) {
                    attachmentupgrades++;
                }
            }
            if (self weaponhasattachmentandunlocked(weapon, "steadyaim")) {
                if (var_6af452fc.var_bd77a1eb === 1) {
                    if (isdefined(var_3cd641b) && isdefined(var_5afc3871[#"talent_dexterity"]) && self function_db654c9(var_3cd641b, #"bonuscard_overkill")) {
                        if (!isdefined(self.var_9cd2c51d.var_1a72ebf5)) {
                            self.var_9cd2c51d.var_1a72ebf5 = 0;
                        }
                        self.var_9cd2c51d.var_1a72ebf5++;
                        if (self.var_9cd2c51d.var_1a72ebf5 == 5) {
                            self stats::function_dad108fa(#"hash_6c13ae81deff608b", 1);
                        }
                    }
                }
                if (self weaponhasattachmentandunlocked(weapon, "steadyaim2")) {
                    attachmentupgrades++;
                }
            }
            if (self weaponhasattachmentandunlocked(weapon, "fastreload")) {
                self stats::function_dad108fa(#"ekia_fastreload_mixclip", 1);
                if (weaponclass == #"weapon_launcher") {
                    self stats::function_dad108fa(#"hash_4b19afce40dfc918", 1);
                }
                if (self weaponhasattachmentandunlocked(weapon, "fastreload2")) {
                    attachmentupgrades++;
                    if (isads && var_6af452fc.var_14f058c7 === 1 && self weaponhasattachmentandunlocked(weapon, "quickdraw")) {
                        self stats::function_dad108fa(#"ekia_ads_reload_quickdraw_fastreload2", 1);
                    }
                }
            }
            if (self weaponhasattachmentandunlocked(weapon, "mixclip")) {
                self stats::function_dad108fa(#"ekia_fastreload_mixclip", 1);
            }
            if (attachmentupgrades < 2) {
                if (self weaponhasattachmentandunlocked(weapon, "barrel", "barrel2")) {
                    attachmentupgrades++;
                }
            }
            if (attachmentupgrades == 1) {
                self stats::function_dad108fa(#"hash_51430fd20ccb2b05", 1);
            } else if (attachmentupgrades > 1) {
                self stats::function_dad108fa(#"hash_6c36aa2d7d6f2b4", 1);
            }
        }
        if (weapon.statname == "smg_handling_t8" && (isdefined(weapon.dualwieldweapon) && weapon.dualwieldweapon != level.weaponnone || self weaponhasattachmentandunlocked(weapon, "dw"))) {
            self stats::function_dad108fa(#"ekia_dw_fatbarrel_skullsplitter_dragonbreath", 1);
        }
        if (isdefined(var_5018995b) && var_5018995b.statname == #"gadget_radiation_field" && (!isdefined(var_6af452fc.var_75c08813) || var_6af452fc.var_75c08813 < 1)) {
            self stats::function_dad108fa(#"radiation_field_shutdown_ekia", 1);
        }
        if (var_bcbcb4ec === 1) {
            self stats::function_dad108fa(#"kill_enemy_who_has_goldenammo", 1);
        }
        if (var_fff76b4 === 1) {
            self stats::function_dad108fa(#"kill_enemy_who_has_bonus_health", 1);
        }
        if (!isdefined(var_5afc3871[#"talent_resistance"])) {
            if (var_2d4a24ea) {
                if (var_6c5ba24c) {
                    self stats::function_dad108fa(#"kill_enemy_who_stunned_you_during_stun", 1);
                }
            }
            if (var_ba9c5900 === 1) {
                self stats::function_dad108fa(#"kill_enemy_who_stunned_you_during_stun", 1);
            }
        }
        if (isdefined(var_70137a58.var_64ffda50)) {
            var_f4917629 = var_70137a58.var_64ffda50[victimentnum];
            if (isdefined(var_f4917629) && var_f4917629 + 6000 > time) {
                self stats::function_dad108fa(#"kill_after_shot_in_back", 1);
            }
        }
        if (weapon != level.weaponnone) {
            if (isdefined(self.pickedupweapons) && isdefined(self.pickedupweapons[weapon]) && isdefined(self.var_c9062c1c)) {
                var_eef88563 = self.pickedupweapons[weapon];
                if (var_eef88563 >= 0 && var_eef88563 == victimentnum) {
                    if (!isdefined(self.var_c9062c1c[weapon])) {
                        self.var_c9062c1c[weapon] = [];
                    }
                    if (!isdefined(self.var_c9062c1c[weapon][var_eef88563])) {
                        self.var_c9062c1c[weapon][var_eef88563] = 0;
                    }
                    self.var_c9062c1c[weapon][var_eef88563]++;
                }
                if (isdefined(self.var_93da0d74[weapon])) {
                    self.var_93da0d74[weapon]++;
                    if (self.var_93da0d74[weapon] >= 5 && isdefined(self.var_c9062c1c[weapon]) && var_eef88563 == victimentnum && self.var_c9062c1c[weapon][var_eef88563] > 0) {
                        self stats::function_dad108fa(#"killstreak_5_picked_up_weapon", 1);
                        self.var_93da0d74[weapon] = self.var_93da0d74[weapon] - 5;
                        self.var_c9062c1c[weapon][var_eef88563]--;
                    }
                } else {
                    self.var_93da0d74[weapon] = 1;
                }
                self contracts::increment_contract(#"contract_mp_pickup_weapon_kills");
            }
        }
        if (var_2adaec2f === 1) {
            self stats::function_dad108fa(#"ekia_every_enemy_onelife", 1);
        }
        if (var_1f0bdb8f === 1) {
            self stats::function_dad108fa(#"hash_3bf4605458c33226", 1);
        }
        if (var_8a4cfbd) {
            self stats::function_dad108fa(#"ekia_specialized_equipment", 1);
        } else if (weapon.issignatureweapon) {
            self stats::function_dad108fa(#"ekia_specialized_weapons", 1);
        }
        if (var_6af452fc.var_9a5c07a === 1) {
            if (var_6af452fc.var_79eb9a59 === self) {
                self stats::function_dad108fa(#"ekia_debuffed_enemies_specialized_weapon_equipment", 1);
                var_38a1a18 = 1;
            }
        }
        if (!(var_38a1a18 === 1) && isdefined(var_6af452fc.sensor_darts)) {
            if (isdefined(var_30f88120)) {
                self stats::function_dad108fa(#"ekia_debuffed_enemies_specialized_weapon_equipment", 1);
                var_38a1a18 = 1;
            }
        }
        if (!(var_38a1a18 === 1) && isdefined(var_6af452fc.var_2acdce3e)) {
            foreach (effect in var_6af452fc.var_2acdce3e) {
                if (!isdefined(effect.var_4b22e697) || self != effect.var_4b22e697 || !isdefined(effect.var_3d1ed4bd)) {
                    continue;
                }
                switch (effect.var_3d1ed4bd.name) {
                case #"shock_rifle":
                case #"ability_smart_cover":
                case #"eq_swat_grenade":
                case #"hash_3f62a872201cd1ce":
                case #"eq_seeker_mine":
                case #"eq_concertina_wire":
                case #"hero_flamethrower":
                case #"gadget_radiation_field":
                    award = 1;
                    break;
                default:
                    break;
                }
                if (award === 1) {
                    self stats::function_dad108fa(#"ekia_debuffed_enemies_specialized_weapon_equipment", 1);
                    break;
                }
            }
        }
        if (var_828dac8f === 1) {
            self stats::function_dad108fa(#"hash_23d2a4d333f13590", 1);
        }
        if (var_6af452fc.var_b535f1ea === self && isdefined(var_6af452fc.var_2acdce3e)) {
            if (isdefined(var_6af452fc.var_2acdce3e[#"hash_1527a22d8a6fdc21"]) && var_6af452fc.var_2acdce3e[#"hash_1527a22d8a6fdc21"].endtime > time) {
                if (self util::is_item_purchased(#"eq_slow_grenade")) {
                    self stats::function_dad108fa(#"ekia_concussed_enemy", 1);
                }
            }
        }
    }
    if (isdefined(level.activeplayeruavs[self.entnum]) && level.activeplayeruavs[self.entnum] && (!isdefined(level.forceradar) || level.forceradar == 0)) {
        self stats::function_dad108fa(#"ekia_uav", 1);
    }
    if (isdefined(level.activeplayercounteruavs[self.entnum]) && level.activeplayercounteruavs[self.entnum] > 0) {
        self stats::function_dad108fa(#"ekia_counteruav", 1);
    }
    if (killstreak === #"ability_dog") {
        if (weapon.issignatureweapon) {
            self stats::function_dad108fa(#"ekia_specialized_weapons", 1);
        }
    }
}

// Namespace challenges/challenges
// Params 1, eflags: 0x1 linked
// Checksum 0x31ffeff, Offset: 0x34e8
// Size: 0x344c
function challengekills(data) {
    weapon = data.weapon;
    player = data.attacker;
    victim = data.victim;
    attacker = data.attacker;
    time = data.time;
    attacker.lastkilledplayer = victim;
    attackerheroability = data.attackerheroability;
    attackerheroabilityactive = data.attackerheroabilityactive;
    attackersliding = data.attackersliding;
    attackerspeedburst = data.attackerspeedburst;
    attackertraversing = data.attackertraversing;
    var_1fa3e8cc = data.var_1fa3e8cc;
    var_8556c722 = data.var_8556c722;
    attackerwasconcussed = data.attackerwasconcussed;
    attackerwasflashed = data.attackerwasflashed;
    attackerwasheatwavestunned = data.attackerwasheatwavestunned;
    attackerwasonground = data.attackeronground;
    attackerwasunderwater = data.attackerwasunderwater;
    var_911b9b40 = data.var_911b9b40;
    attackerlastfastreloadtime = data.attackerlastfastreloadtime;
    lastweaponbeforetoss = data.lastweaponbeforetoss;
    meansofdeath = data.smeansofdeath;
    ownerweaponatlaunch = data.ownerweaponatlaunch;
    victimweapon = data.victimweapon;
    victimbedout = data.bledout;
    victimorigin = data.victimorigin;
    victimforward = data.victimforward;
    victimcombatefficiencylastontime = data.victimcombatefficiencylastontime;
    victimcombatefficieny = data.victimcombatefficieny;
    victimelectrifiedby = data.victimelectrifiedby;
    victimheroability = data.victimheroability;
    victimheroabilityactive = data.victimheroabilityactive;
    victimspeedburst = data.victimspeedburst;
    victimspeedburstlastontime = data.victimspeedburstlastontime;
    victimvisionpulseactivatetime = data.victimvisionpulseactivatetime;
    victimvisionpulsearray = data.victimvisionpulsearray;
    victimvisionpulseorigin = data.victimvisionpulseorigin;
    victimvisionpulseoriginarray = data.victimvisionpulseoriginarray;
    victimattackersthisspawn = data.victimattackersthisspawn;
    victimwasinslamstate = data.victimwasinslamstate;
    victimwaslungingwitharmblades = data.victimwaslungingwitharmblades;
    var_9fb5719b = data.var_9fb5719b;
    victimwasonground = data.victimonground;
    var_59b78db0 = data.var_59b78db0;
    victimwasunderwater = data.wasunderwater;
    var_e828179e = data.var_e828179e;
    victimlaststunnedby = data.victimlaststunnedby;
    var_642d3a64 = data.var_642d3a64;
    victimactiveproximitygrenades = data.victimactiveproximitygrenades;
    victimactivebouncingbetties = data.victimactivebouncingbetties;
    var_f91a4dd6 = data.var_f91a4dd6;
    attackerlastflashedby = data.attackerlastflashedby;
    attackerlaststunnedby = data.attackerlaststunnedby;
    attackerlaststunnedtime = data.attackerlaststunnedtime;
    attackerwassliding = data.attackerwassliding;
    attackerwassprinting = data.attackerwassprinting;
    attackerstance = data.attackerstance;
    wasdefusing = data.wasdefusing;
    wasplanting = data.wasplanting;
    inflictorownerwassprinting = data.inflictorownerwassprinting;
    playerorigin = data.attackerorigin;
    attackerforward = data.attackerforward;
    var_70763083 = data.var_70763083;
    var_d6553aa9 = data.var_d6553aa9;
    var_d24b8539 = data.var_6799f1da;
    attacker_slide_begin = data.attacker_slide_begin;
    attacker_slide_end = data.attacker_slide_end;
    attacker_sprint_end = data.attacker_sprint_end;
    attacker_sprint_begin = data.attacker_sprint_begin;
    var_e5241328 = data.var_e5241328;
    var_cc8f0762 = data.var_cc8f0762;
    var_26aed950 = data.var_26aed950;
    inflictoriscooked = data.inflictoriscooked;
    inflictorchallenge_hatchettosscount = data.inflictorchallenge_hatchettosscount;
    inflictorownerwassprinting = data.inflictorownerwassprinting;
    inflictorplayerhasengineerperk = data.inflictorplayerhasengineerperk;
    inflictor = data.einflictor;
    var_937b6de2 = isdefined(victim.challenge_combatrobotattackclientid) && isdefined(victim.challenge_combatrobotattackclientid[player.clientid]);
    weaponclass = util::getweaponclass(weapon);
    baseweapon = getbaseweapon(weapon);
    baseweaponitemindex = getbaseweaponitemindex(baseweapon);
    weaponpurchased = player isitempurchased(baseweaponitemindex);
    if (meansofdeath == #"mod_head_shot" || meansofdeath == #"mod_pistol_bullet" || meansofdeath == #"mod_rifle_bullet") {
        bulletkill = 1;
    } else if (baseweapon == level.weaponflechette && (meansofdeath == #"mod_impact" || meansofdeath == #"mod_projectile" || meansofdeath == #"mod_projectile_splash")) {
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
    killstreak = killstreaks::get_from_weapon(weapon);
    if (!isdefined(killstreak)) {
        if (level.hardcoremode) {
            player stats::function_dad108fa(#"kill_hc", 1);
            if (isdefined(var_e5241328) && var_e5241328 + 4500 > time) {
                player stats::function_dad108fa(#"kill_hc_stim", 1);
            }
            if (player.health < player.maxhealth) {
                player stats::function_dad108fa(#"kill_hc_crit_health", 1);
            }
            if (weapons::ismeleemod(meansofdeath) && weapons::ispunch(weapon)) {
                player stats::function_dad108fa(#"kill_hc_fist", 1);
            }
        }
        player processspecialistchallenge("kills");
        if (weapon.isheavyweapon) {
            if (!isdefined(player.pers[#"challenge_heroweaponkills"])) {
                player.pers[#"challenge_heroweaponkills"] = 0;
            }
            player processspecialistchallenge("kills_weapon");
            player.pers[#"challenge_heroweaponkills"]++;
            if (player.pers[#"challenge_heroweaponkills"] >= 6) {
                player processspecialistchallenge("kill_one_game_weapon");
                player.pers[#"challenge_heroweaponkills"] = 0;
            }
        }
    } else {
        player function_ea966b4a(killstreak);
    }
    if (bulletkill && !isdefined(killstreak)) {
        player genericbulletkill(data, victim, weapon);
        if (weaponpurchased) {
            if (weaponclass == #"weapon_sniper") {
                if (isdefined(victim.firsttimedamaged) && victim.firsttimedamaged == time) {
                    player stats::function_dad108fa(#"kill_enemy_one_bullet_sniper", 1);
                    player stats::function_e24eec31(weapon, #"kill_enemy_one_bullet_sniper", 1);
                    if (!isdefined(player.pers[#"kill_enemy_one_bullet_sniper"])) {
                        player.pers[#"kill_enemy_one_bullet_sniper"] = 0;
                    }
                    player.pers[#"kill_enemy_one_bullet_sniper"]++;
                    if (player.pers[#"kill_enemy_one_bullet_sniper"] % 10 == 0) {
                        player stats::function_dad108fa(#"hash_2ebd387ffb67e1dc", 1);
                    }
                }
            } else if (weaponclass == "weapon_cqb") {
                if (isdefined(victim.firsttimedamaged) && victim.firsttimedamaged == time) {
                    player stats::function_dad108fa(#"kill_enemy_one_bullet_shotgun", 1);
                    player stats::function_e24eec31(weapon, #"kill_enemy_one_bullet_shotgun", 1);
                }
            }
        }
        checkkillstreak5(baseweapon, player);
        function_b2b18857(player);
        if (meansofdeath == #"mod_head_shot") {
            if (isdefined(victim.var_ea1458aa) && isdefined(victim.var_ea1458aa.attackerdamage)) {
                var_d72bd991 = victim.var_ea1458aa.attackerdamage[player.clientid];
                gear = player function_b958b70d(player.class_num, "tacticalgear");
                if (gear === #"gear_armor" && isdefined(var_d72bd991)) {
                    if (var_d72bd991.var_d7bd6f9b === 1) {
                        player stats::function_dad108fa(#"hash_2ed3de647f5090f1", 1);
                    }
                }
            }
        }
        if (isdefined(var_26aed950[#"talent_lightweight"])) {
            player stats::function_dad108fa(#"kill_lightweight", 1);
        }
        if (weapon.isdualwield && weaponpurchased) {
            checkdualwield(baseweapon, player, attacker, time, attackerwassprinting, attacker_sprint_end);
        }
        if (isdefined(weapon.attachments) && weapon.attachments.size > 0) {
            attachmentname = player getweaponoptic(weapon);
            if (isdefined(attachmentname) && attachmentname != "" && player weaponhasattachmentandunlocked(weapon, attachmentname)) {
                if (weapon.attachments.size > 5 && player allweaponattachmentsunlocked(weapon) && !isdefined(attacker.tookweaponfrom[weapon])) {
                    player stats::function_dad108fa(#"kill_optic_5_attachments", 1);
                }
                if (isdefined(player.attachmentkillsthisspawn[attachmentname])) {
                    player.attachmentkillsthisspawn[attachmentname]++;
                    if (player.attachmentkillsthisspawn[attachmentname] == 5) {
                        player stats::function_e24eec31(weapon, #"killstreak_5_attachment", 1);
                    }
                } else {
                    player.attachmentkillsthisspawn[attachmentname] = 1;
                }
                if (weapons::ispistol(weapon.rootweapon)) {
                    if (player weaponhasattachmentandunlocked(weapon, "suppressed", "barrel")) {
                        player stats::function_dad108fa(#"kills_pistol_lasersight_suppressor_longbarrel", 1);
                    }
                }
            }
            if (player weaponhasattachmentandunlocked(weapon, "suppressed")) {
                if (attacker util::has_hard_wired_perk_purchased_and_equipped() && attacker util::has_ghost_perk_purchased_and_equipped() && attacker util::has_jetquiet_perk_purchased_and_equipped()) {
                    player stats::function_dad108fa(#"kills_suppressor_ghost_hardwired_blastsuppressor", 1);
                }
            }
            if (player playerads() == 1) {
                if (isdefined(player.smokegrenadetime) && isdefined(player.smokegrenadeposition)) {
                    if (player.smokegrenadetime + 14000 > time) {
                        if (player util::is_looking_at(player.smokegrenadeposition) || distancesquared(player.origin, player.smokegrenadeposition) < 40000) {
                            if (player weaponhasattachmentandunlocked(weapon, "ir")) {
                                player stats::function_dad108fa(#"kill_with_thermal_and_smoke_ads", 1);
                                player stats::function_e24eec31(weapon, #"kill_thermal_through_smoke", 1);
                            }
                        }
                    }
                }
            }
            if (weapon.attachments.size > 1) {
                if (player playerads() == 1) {
                    if (player weaponhasattachmentandunlocked(weapon, "grip", "quickdraw")) {
                        player stats::function_dad108fa(#"kills_ads_quickdraw_and_grip", 1);
                    }
                }
                if (player weaponhasattachmentandunlocked(weapon, "fastreload", "extclip")) {
                    player.pers[#"killsfastmagext"]++;
                    if (player.pers[#"killsfastmagext"] > 4) {
                        player stats::function_dad108fa(#"kills_one_life_fastmags_and_extclip", 1);
                        player.pers[#"killsfastmagext"] = 0;
                    }
                }
            }
            if (weapon.attachments.size > 4) {
                if (player weaponhasattachmentandunlocked(weapon, "extclip", "grip", "fastreload", "quickdraw", "stalker")) {
                    player stats::function_dad108fa(#"kills_extclip_grip_fastmag_quickdraw_stock", 1);
                }
            }
        }
        if (isdefined(attackerlastfastreloadtime) && time - attackerlastfastreloadtime <= 5000 && player weaponhasattachmentandunlocked(weapon, "fastreload")) {
            player stats::function_dad108fa(#"kills_after_reload_fastreload", 1);
        }
        if (isdefined(victim.idflagstime) && victim.idflagstime == time) {
            if (victim.idflags & 8) {
                player stats::function_dad108fa(#"kill_enemy_through_wall", 1);
            }
        }
        if (vectordot(attackerforward, victimforward) < -0.98) {
            if (isdefined(var_642d3a64) && var_642d3a64 + 5500 > time) {
                var_141c7081 = victimorigin + (0, 0, 31);
                var_2baca0fc = !bullettracepassed(var_141c7081, var_141c7081 + victimforward * 144, 0, victim);
                if (var_2baca0fc) {
                    player stats::function_dad108fa(#"kill_enemy_shooting_in_partial_cover", 1);
                }
            }
        }
    } else if (weapons::ismeleemod(meansofdeath) && !isdefined(killstreak)) {
        player stats::function_dad108fa(#"melee", 1);
        if (weapons::ispunch(weapon)) {
            player stats::function_dad108fa(#"kill_enemy_with_fists", 1);
        }
        checkkillstreak5(baseweapon, player);
    } else if (!isdefined(killstreak)) {
        if (weaponclass == #"weapon_launcher") {
            player stats::function_dad108fa(#"hash_be93d1227e6db1", 1);
        }
        if (weaponpurchased) {
            slot_weapon = player loadout::function_18a77b37("primarygrenade");
            if (weapon === slot_weapon) {
                if (player.challenge_scavengedcount > 0) {
                    player.challenge_resuppliednamekills++;
                    if (player.challenge_resuppliednamekills >= 3) {
                        player stats::function_dad108fa(#"kills_3_resupplied_nade_one_life", 1);
                        player.challenge_resuppliednamekills = 0;
                    }
                    player.challenge_scavengedcount--;
                }
            }
            if (isdefined(inflictoriscooked)) {
                if (inflictoriscooked == 1 && weapon.statname == #"frag_grenade") {
                    player stats::function_dad108fa(#"kill_with_cooked_grenade", 1);
                }
            }
            if (victimlaststunnedby === player) {
                if (weaponclass == "weapon_grenade") {
                    player stats::function_dad108fa(#"kill_stun_lethal", 1);
                }
            }
            if (baseweapon.statname == level.weaponballisticknife.statname) {
                player function_80327323(data);
                if (isdefined(var_26aed950[#"talent_lightweight"])) {
                    player stats::function_dad108fa(#"kill_lightweight", 1);
                }
            }
            if (baseweapon == level.weaponspecialcrossbow) {
                if (weapon.isdualwield) {
                    checkdualwield(baseweapon, player, attacker, time, attackerwassprinting, attacker_sprint_end);
                }
            }
            if (baseweapon == level.weaponshotgunenergy) {
                if (isdefined(victim.firsttimedamaged) && victim.firsttimedamaged == time) {
                    player stats::function_dad108fa(#"kill_enemy_one_bullet_shotgun", 1);
                    player stats::function_e24eec31(weapon, #"kill_enemy_one_bullet_shotgun", 1);
                }
            }
        }
        if (baseweapon.forcedamagehitlocation || baseweapon == level.weaponspecialcrossbow || baseweapon == level.weaponshotgunenergy || baseweapon.statname == level.weaponballisticknife.statname) {
            checkkillstreak5(baseweapon, player);
        }
    }
    if (isdefined(attacker) && isdefined(attacker.tookweaponfrom) && isdefined(attacker.tookweaponfrom[weapon]) && isdefined(attacker.tookweaponfrom[weapon].previousowner)) {
        if (!isdefined(attacker.tookweaponfrom[weapon].previousowner.team) || attacker.tookweaponfrom[weapon].previousowner.team != player.team) {
            player stats::function_dad108fa(#"kill_with_pickup", 1);
        }
    }
    awarded_kill_enemy_that_blinded_you = 0;
    playerhastacticalmask = player player::function_14e61d05();
    if (attackerwasflashed) {
        if (attackerlastflashedby === victim && !playerhastacticalmask) {
            player stats::function_dad108fa(#"kill_enemy_that_blinded_you", 1);
            awarded_kill_enemy_that_blinded_you = 1;
        }
    }
    if (!awarded_kill_enemy_that_blinded_you && isdefined(attackerlaststunnedtime) && attackerlaststunnedtime + 5000 > time) {
        if (attackerlaststunnedby === victim && !playerhastacticalmask) {
            player stats::function_dad108fa(#"kill_enemy_that_blinded_you", 1);
            awarded_kill_enemy_that_blinded_you = 1;
        }
    }
    killedstunnedvictim = 0;
    if (isdefined(victim.lastconcussedby) && victim.lastconcussedby == attacker) {
        if (victim.concussionendtime > time) {
            killedstunnedvictim = 1;
        }
    }
    if (isdefined(victim.lastshockedby) && victim.lastshockedby == attacker) {
        if (victim.shockendtime > time) {
            if (player util::is_item_purchased(#"proximity_grenade")) {
                player stats::function_dad108fa(#"kill_shocked_enemy", 1);
            }
            player function_be7a08a8(getweapon(#"proximity_grenade"), 1);
            killedstunnedvictim = 1;
            if (weapon.rootweapon.name == "bouncingbetty") {
                player stats::function_dad108fa(#"kill_trip_mine_shocked", 1);
            }
        }
    }
    if (victim util::isflashbanged()) {
        if (isdefined(victim.lastflashedby) && victim.lastflashedby == player) {
            killedstunnedvictim = 1;
            if (player util::is_item_purchased(#"flash_grenade")) {
                player stats::function_dad108fa(#"kill_flashed_enemy", 1);
            }
            player function_be7a08a8(getweapon(#"flash_grenade"), 1);
        }
    }
    if (level.teambased) {
        if (!isdefined(player.pers[#"kill_every_enemy_with_specialist"]) && level.playercount[victim.pers[#"team"]] > 3 && player.pers[#"killed_players_with_specialist"].size >= level.playercount[victim.pers[#"team"]]) {
            player stats::function_dad108fa(#"kill_every_enemy", 1);
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
                    player stats::function_dad108fa(#"kill_enemy_5_teammates_assists", 1);
                }
            }
        }
    }
    if (isdefined(killstreak)) {
        if (killstreak == "ultimate_turret" || killstreak == "inventory_ultimate_turret") {
            if (isdefined(inflictor)) {
                if (!isdefined(inflictor.challenge_killcount)) {
                    inflictor.challenge_killcount = 0;
                }
                inflictor.challenge_killcount++;
                if (inflictor.challenge_killcount == 5) {
                    player stats::function_dad108fa(#"hash_636e38d21d529ce3", 1);
                }
            }
        }
    }
    if (var_937b6de2) {
        if (!isdefined(inflictor) || !isdefined(inflictor.killstreaktype) || !isstring(inflictor.killstreaktype) || inflictor.killstreaktype != "combat_robot") {
            player stats::function_dad108fa(#"kill_enemy_who_damaged_robot", 1);
        }
    }
    var_46119dfa = player getloadoutitem(player.class_num, "primarygrenadecount");
    if (var_46119dfa) {
        if (weapon.rootweapon.name == "hatchet" && inflictorchallenge_hatchettosscount <= 2) {
            player.challenge_hatchetkills++;
            if (player.challenge_hatchetkills == 2) {
                player stats::function_dad108fa(#"kills_first_throw_both_hatchets", 1);
            }
        }
    }
    player trackkillstreaksupportkills(victim);
    if (!isdefined(killstreak)) {
        if (attackerwasunderwater) {
            player stats::function_dad108fa(#"kill_while_underwater", 1);
        }
        if (attackerwasunderwater && var_e828179e < 5 && !var_8556c722) {
            player stats::function_dad108fa(#"kill_enemy_on_land_underwater", 1);
        }
        if (player util::has_purchased_perk_equipped(#"specialty_jetcharger")) {
        }
        trackedplayer = 0;
        if (player util::has_purchased_perk_equipped(#"specialty_tracker")) {
            if (!victim hasperk(#"specialty_trackerjammer")) {
                player stats::function_dad108fa(#"kill_detect_tracker", 1);
                trackedplayer = 1;
            }
        }
        if (player util::has_purchased_perk_equipped(#"specialty_detectnearbyenemies")) {
            if (!victim hasperk(#"specialty_sixthsensejammer")) {
                player stats::function_dad108fa(#"kill_enemy_sixth_sense", 1);
                if (player util::has_purchased_perk_equipped(#"specialty_loudenemies")) {
                    if (!victim hasperk(#"specialty_quieter")) {
                        player stats::function_dad108fa(#"kill_sixthsense_awareness", 1);
                    }
                }
            }
            if (trackedplayer) {
                player stats::function_dad108fa(#"kill_tracker_sixthsense", 1);
            }
        }
        if (weapon.isheavyweapon == 1 || attackerheroabilityactive) {
            if (player util::has_purchased_perk_equipped(#"specialty_overcharge")) {
                player stats::function_dad108fa(#"kill_with_specialist_overclock", 1);
            }
        }
        if (player util::has_purchased_perk_equipped(#"specialty_gpsjammer")) {
            if (uav::hasuav(victim.team)) {
                player stats::function_dad108fa(#"kill_uav_enemy_with_ghost", 1);
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
                        player stats::function_dad108fa(#"kill_blindeye_ghost_aircraft", 1);
                        awarded_kill_blindeye_ghost_aircraft = 1;
                        break;
                    }
                }
            }
        }
        if (player util::has_purchased_perk_equipped(#"specialty_flakjacket")) {
            if (isdefined(player.challenge_lastsurvivewithflakfrom) && player.challenge_lastsurvivewithflakfrom == victim) {
                player stats::function_dad108fa(#"kill_enemy_survive_flak", 1);
            }
            if (player util::has_tactical_mask_purchased_and_equipped()) {
                if (attackerwasflashed || isdefined(player.challenge_lastsurvivewithflaktime) && player.challenge_lastsurvivewithflaktime + 3500 > time || isdefined(attackerlaststunnedtime) && attackerlaststunnedtime + 2500 > time) {
                    player stats::function_dad108fa(#"kill_flak_tac_while_stunned", 1);
                }
            }
        }
        if (player util::has_hard_wired_perk_purchased_and_equipped()) {
            if (isdefined(level.hasindexactivecounteruav) && victim [[ level.hasindexactivecounteruav ]](victim.team)) {
                player stats::function_dad108fa(#"kills_counteruav_emp_hardline", 1);
            }
        }
        if (player util::has_scavenger_perk_purchased_and_equipped()) {
            if (player.scavenged) {
                player stats::function_dad108fa(#"kill_after_resupply", 1);
                if (trackedplayer) {
                    player stats::function_dad108fa(#"kill_scavenger_tracker_resupply", 1);
                }
            }
        }
        if (player util::has_fast_hands_perk_purchased_and_equipped()) {
            if (bulletkill) {
                if (attackerwassprinting || attacker_sprint_end + 3000 > time) {
                    player stats::function_dad108fa(#"kills_after_sprint_fasthands", 1);
                    if (player util::has_gung_ho_perk_purchased_and_equipped()) {
                        player stats::function_dad108fa(#"kill_fasthands_gungho_sprint", 1);
                    }
                }
            }
        }
        if (player util::has_hard_wired_perk_purchased_and_equipped()) {
            if (player util::has_cold_blooded_perk_purchased_and_equipped()) {
                player stats::function_dad108fa(#"kill_hardwired_coldblooded", 1);
            }
        }
        killedplayerwithgungho = 0;
        if (player util::has_gung_ho_perk_purchased_and_equipped()) {
            if (bulletkill) {
                killedplayerwithgungho = 1;
                if (attackerwassprinting && player playerads() != 1) {
                    player stats::function_dad108fa(#"kill_hip_gung_ho", 1);
                }
            }
            if (weaponclass == "weapon_grenade") {
                if (isdefined(inflictorownerwassprinting) && inflictorownerwassprinting == 1) {
                    killedplayerwithgungho = 1;
                    player stats::function_dad108fa(#"kill_hip_gung_ho", 1);
                }
            }
        }
        if (player util::has_awareness_perk_purchased_and_equipped()) {
            player stats::function_dad108fa(#"kill_awareness", 1);
        }
        if (killedstunnedvictim) {
            if (player util::has_tactical_mask_purchased_and_equipped()) {
                player stats::function_dad108fa(#"kill_stunned_tacmask", 1);
                if (killedplayerwithgungho == 1) {
                    player stats::function_dad108fa(#"kill_sprint_stunned_gungho_tac", 1);
                }
            }
        }
        if (player util::has_ninja_perk_purchased_and_equipped()) {
            player stats::function_dad108fa(#"kill_dead_silence", 1);
            if (distancesquared(playerorigin, victimorigin) < 14400) {
                if (player util::has_awareness_perk_purchased_and_equipped()) {
                    player stats::function_dad108fa(#"kill_close_deadsilence_awareness", 1);
                }
                if (player util::has_jetquiet_perk_purchased_and_equipped()) {
                    player stats::function_dad108fa(#"kill_close_blast_deadsilence", 1);
                }
            }
        }
        primary_weapon = player loadout::function_18a77b37("primary");
        if (isdefined(primary_weapon) && weapon == primary_weapon || isdefined(primary_weapon) && isdefined(primary_weapon.altweapon) && weapon == primary_weapon.altweapon) {
            if (player function_861fe993("secondary")) {
                player function_7ec2f2c("primary", 0);
                player function_7ec2f2c("secondary", 0);
            } else {
                player function_7ec2f2c("primary", 1);
            }
        } else {
            secondary_weapon = player loadout::function_18a77b37("secondary");
            if (isdefined(secondary_weapon) && weapon == secondary_weapon || isdefined(secondary_weapon) && isdefined(secondary_weapon.altweapon) && weapon == secondary_weapon.altweapon) {
                if (player function_861fe993("primary")) {
                    player function_7ec2f2c("primary", 0);
                    player function_7ec2f2c("secondary", 0);
                } else {
                    player function_7ec2f2c("secondary", 1);
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
                    if (distancesquared(bouncingbettyinfo.origin, victimorigin) < function_a3f6cdac(400)) {
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
                    if (distancesquared(proximitygrenadeinfo.origin, victimorigin) < function_a3f6cdac(400)) {
                        should_award_kill_near_plant_engineer_hardwired = 1;
                        break;
                    }
                }
            }
            if (should_award_kill_near_plant_engineer_hardwired) {
                player stats::function_dad108fa(#"kill_near_plant_engineer_hardwired", 1);
            }
        }
        if (isdefined(var_70763083) && var_70763083 + 2500 > time) {
            player stats::function_dad108fa(#"kill_enemy_after_they_heal", 1);
        }
        if (isdefined(var_e5241328) && var_e5241328 + 4500 > time) {
            if (isdefined(attacker.health) && isdefined(var_cc8f0762) && attacker.health - var_cc8f0762 > 40) {
                attacker stats::function_dad108fa(#"kill_enemy_after_you_heal", 1);
            }
        }
        if (var_d6553aa9 === 1 && level.teambased) {
            attacker stats::function_dad108fa(#"kill_enemy_revealed_by_team_fog_of_war", 1);
        }
        if (!victimwasonground && var_e828179e <= 0) {
            attacker stats::function_dad108fa(#"kill_enemy_thats_in_air", 1);
        }
        if (victimweapon.issignatureweapon === 1) {
            if (!isdefined(var_f91a4dd6) || var_f91a4dd6 < 1) {
                attacker stats::function_dad108fa(#"kill_before_specialist_weapon_use", 1);
            }
            if (victimweapon.statname == #"sig_buckler_dw") {
                if (!isdefined(killstreak) && bulletkill && vectordot(victimforward, playerorigin - victimorigin) < 0) {
                    attacker stats::function_dad108fa(#"shutdown_ballisticshield_in_back", 1);
                }
            }
        }
        if (isdefined(level.var_2e3031be) && isdefined(victimvisionpulseactivatetime) && victimvisionpulseactivatetime + level.var_2e3031be.gadget_pulse_duration / 3 + 500 > time) {
            attacker stats::function_dad108fa(#"shutdown_visionpulse_immediately", 1);
        }
        if (var_1fa3e8cc === 1 && !var_8556c722 && var_911b9b40 !== 1) {
            attacker stats::function_dad108fa(#"kill_with_weapon_in_right_hand_only", 1);
        }
        if (isdefined(attacker.attackerdamage) && isdefined(attacker.attackerdamage[victim.clientid]) && isdefined(attacker.attackerdamage[victim.clientid].lasttimedamaged) && attacker.attackerdamage[victim.clientid].lasttimedamaged + 1500 > time) {
            attacker stats::function_dad108fa(#"kill_enemy_damage_you", 1);
        }
        if (!victimwasonground && victimwasinslamstate && var_d24b8539 === 1) {
            attacker stats::function_dad108fa(#"shutdown_gravslam_midair_after_grapple", 1);
        }
        if (isdefined(data.var_58b48038)) {
            attacker stats::function_dad108fa(#"kill_enemy_after_surviving_rcxd", 1);
        }
    } else {
        if (weapon.name == #"supplydrop") {
            if (isdefined(inflictorplayerhasengineerperk)) {
                player stats::function_dad108fa(#"kill_booby_trap_engineer", 1);
            }
        }
        var_2cf35051 = globallogic_score::function_3cbc4c6c(victimweapon.var_2e4a8800);
        if (victimweapon.issignatureweapon === 1 || isdefined(var_2cf35051) && var_2cf35051.var_fcd2ff3a === 1) {
            if (killstreak == #"dart" || killstreak == #"inventory_dart" || killstreak == #"recon_car" || killstreak == #"inventory_recon_car" || (killstreak == #"tank_robot" || killstreak == #"inventory_tank_robot") && var_911b9b40 === 1) {
                attacker stats::function_dad108fa(#"shutdown_enemy_by_controlling_scorestreak", 1);
            }
        }
    }
    if (weapon.isheavyweapon == 1 || attackerheroabilityactive || isdefined(killstreak)) {
        if (player util::has_purchased_perk_equipped(#"specialty_overcharge") && player util::has_purchased_perk_equipped(#"specialty_anteup")) {
            player stats::function_dad108fa(#"kill_anteup_overclock_scorestreak_specialist", 1);
        }
    }
    var_eae59bb8 = globallogic_score::function_3cbc4c6c(weapon.var_2e4a8800);
    if (weapon.issignatureweapon === 1 || isdefined(var_eae59bb8) && var_eae59bb8.var_fcd2ff3a === 1) {
        if (victimweapon.issignatureweapon === 1) {
            attacker stats::function_dad108fa(#"kill_specialist_with_specialist", 1);
        }
    }
    if (victimweapon.statname == #"hero_flamethrower" && weapon.statname == #"eq_molotov") {
        attacker stats::function_dad108fa(#"shutdown_purifier_with_molotov", 1);
    }
    if (victimweapon.statname == #"hero_annihilator" && (weapon.statname == #"hero_annihilator" || weapon.statname == #"pistol_revolver_t8")) {
        attacker stats::function_dad108fa(#"shutdown_annihilator_with_revolver", 1);
    }
}

// Namespace challenges/challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xc5b2aabf, Offset: 0x6940
// Size: 0x66
function on_player_spawn() {
    profilestart();
    if (canprocesschallenges()) {
        self fix_challenge_stats_on_spawn();
        self function_b6d44fd9();
    }
    self function_6b34141d();
    profilestop();
}

// Namespace challenges/challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xb7d8036d, Offset: 0x69b0
// Size: 0xe
function function_b6d44fd9() {
    self.var_ea1458aa = {};
}

// Namespace challenges/challenges
// Params 2, eflags: 0x1 linked
// Checksum 0xde5510c5, Offset: 0x69c8
// Size: 0x44
function force_challenge_stat(stat_name, stat_value) {
    self stats::set_stat_global(stat_name, stat_value);
    self stats::set_stat_challenge(stat_name, stat_value);
}

// Namespace challenges/challenges
// Params 2, eflags: 0x1 linked
// Checksum 0x76afff9c, Offset: 0x6a18
// Size: 0x52
function get_challenge_group_stat(group_name, stat_name) {
    return self stats::get_stat(#"groupstats", group_name, #"stats", stat_name, #"challengevalue");
}

// Namespace challenges/challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x3d96065d, Offset: 0x6a78
// Size: 0x52
function fix_challenge_stats_on_spawn() {
    player = self;
    if (!isdefined(player)) {
        return;
    }
    if (player.var_8efcbd6a === 1) {
        return;
    }
    player thread function_4039ce49();
    player.var_8efcbd6a = 1;
}

// Namespace challenges/challenges
// Params 0, eflags: 0x5 linked
// Checksum 0x71852ee6, Offset: 0x6ad8
// Size: 0x9e
function private function_4039ce49() {
    player = self;
    player endon(#"disconnect");
    while (game.state != "playing") {
        wait 1;
    }
    wait_time = randomfloatrange(3, 5);
    wait wait_time;
    if (!isdefined(player)) {
        return;
    }
    profilestart();
    player function_ba57595b();
    profilestop();
}

// Namespace challenges/challenges
// Params 0, eflags: 0x5 linked
// Checksum 0x659a7821, Offset: 0x6b80
// Size: 0x54
function private function_ba57595b() {
    player = self;
    player function_223ff464();
    player function_f4106216();
    player function_34364901();
}

// Namespace challenges/challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xbf57cc45, Offset: 0x6be0
// Size: 0x26c
function function_223ff464() {
    if (!(self stats::get_stat(#"extrabools", 0) === 1)) {
        self force_challenge_stat(#"mastery_marksman", 0);
        marksmanarray = [];
        array::add(marksmanarray, #"hash_4075f20007923416");
        array::add(marksmanarray, #"hash_72d1952fced05f40");
        array::add(marksmanarray, #"hash_70cd6c54d1c07272");
        array::add(marksmanarray, #"hash_6b828c2fcb0e8df5");
        array::add(marksmanarray, #"hash_2ea8a6bab2364c58");
        array::add(marksmanarray, #"hash_7ecfcae46143397c");
        array::add(marksmanarray, #"hash_3b30f98820bc20cf");
        array::add(marksmanarray, #"hash_18816731b999fbfb");
        array::add(marksmanarray, #"hash_6c1c399dcbe1af97");
        array::add(marksmanarray, #"hash_5630ec40181e1db3");
        array::add(marksmanarray, #"hash_354bfe5c140365bf");
        array::add(marksmanarray, #"hash_51eff59939399dc9");
        for (index = 0; index < marksmanarray.size; index++) {
            if (self stats::function_af5584ca(marksmanarray[index]) === 1) {
                self stats::function_dad108fa(#"mastery_marksman", 1);
            }
        }
        self stats::set_stat(#"extrabools", 0, 1);
    }
}

// Namespace challenges/challenges
// Params 0, eflags: 0x0
// Checksum 0x251a5ce8, Offset: 0x6e58
// Size: 0xdc
function function_bd5db926() {
    if (!(self stats::get_stat(#"extrabools", 1) === 1)) {
        var_5d157945 = self stats::get_stat_global(#"stats_rcxd_kill");
        recon_car = getweapon(#"hash_38ffd09564931482");
        self stats::function_e24eec31(recon_car, #"kills", var_5d157945);
        self stats::set_stat(#"extrabools", 1, 1);
    }
}

// Namespace challenges/challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x843e10bd, Offset: 0x6f40
// Size: 0x11c
function function_f4106216() {
    if (!(self stats::get_stat(#"playerstatslist", #"hash_195a18a5697c5c96") === 1)) {
        challengetier = self stats::function_af5584ca("shutdown_gravslam_before_impact");
        if (!isdefined(challengetier)) {
            return;
        }
        if (challengetier > 0) {
            self stats::function_8e071909("stats_gravity_slam_shutdown", challengetier);
        }
        challengevalue = self stats::get_stat_challenge("shutdown_gravslam_before_impact");
        self stats::set_stat_challenge("stats_gravity_slam_shutdown", challengevalue);
        self stats::set_stat(#"playerstatslist", #"hash_195a18a5697c5c96", 1);
    }
}

// Namespace challenges/challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xf9868b71, Offset: 0x7068
// Size: 0x1c4
function function_34364901() {
    player = self;
    var_fae27922 = player stats::get_stat(#"item_stats", #"sniper_locus_t8", #"challenges_tu", #"challengevalue");
    if (var_fae27922 === 6) {
        player stats::set_stat(#"item_stats", #"sniper_locus_t8", #"challenges_tu", #"challengevalue", 5);
        player stats::set_stat(#"item_stats", #"sniper_locus_t8", #"challenges_tu", #"statvalue", 5);
        player stats::set_stat(#"item_stats", #"sniper_locus_t8", #"challenges_tu", #"challengetier", 0);
        player addweaponstat(getweapon(#"sniper_locus_t8"), #"challenges_tu", 1);
    }
}

// Namespace challenges/challenges
// Params 1, eflags: 0x0
// Checksum 0x5ba40c3f, Offset: 0x7238
// Size: 0xbc
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
// Checksum 0x7988f67e, Offset: 0x7300
// Size: 0xcc
function fix_tu6_ar_garand() {
    player = self;
    group_weapon_assault = player get_challenge_group_stat("weapon_assault", "challenges");
    weapons_mastery_assault = player stats::get_stat_challenge("weapons_mastery_assault");
    if (group_weapon_assault >= 49 && weapons_mastery_assault < 1) {
        player force_challenge_stat("weapons_mastery_assault", 1);
        player stats::function_dad108fa(#"ar_garand_for_diamond", 1);
    }
}

// Namespace challenges/challenges
// Params 0, eflags: 0x0
// Checksum 0xb9a12f4f, Offset: 0x73d8
// Size: 0xcc
function fix_tu6_pistol_shotgun() {
    player = self;
    group_weapon_pistol = player get_challenge_group_stat("weapon_pistol", "challenges");
    secondary_mastery_pistol = player stats::get_stat_challenge("secondary_mastery_pistol");
    if (group_weapon_pistol >= 21 && secondary_mastery_pistol < 1) {
        player force_challenge_stat("secondary_mastery_pistol", 1);
        player stats::function_dad108fa(#"pistol_shotgun_for_diamond", 1);
    }
}

// Namespace challenges/challenges
// Params 2, eflags: 0x1 linked
// Checksum 0x59ac6989, Offset: 0x74b0
// Size: 0x3c
function completed_specific_challenge(target_value, challenge_name) {
    challenge_count = self stats::get_stat_challenge(challenge_name);
    return challenge_count >= target_value;
}

// Namespace challenges/challenges
// Params 2, eflags: 0x1 linked
// Checksum 0x8e3eada7, Offset: 0x74f8
// Size: 0x38
function tally_completed_challenge(target_value, challenge_name) {
    return self completed_specific_challenge(target_value, challenge_name) ? 1 : 0;
}

// Namespace challenges/challenges
// Params 0, eflags: 0x0
// Checksum 0x331278cd, Offset: 0x7538
// Size: 0x1c
function tu7_fix_100_percenter() {
    self tu7_fix_mastery_perk_2();
}

// Namespace challenges/challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x77e9364c, Offset: 0x7560
// Size: 0x2bc
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
    perk_2_tally += player tally_completed_challenge(100, #"destroy_ai_scorestreak_coldblooded");
    perk_2_tally += player tally_completed_challenge(100, #"kills_counteruav_emp_hardline");
    perk_2_tally += player tally_completed_challenge(200, #"kill_after_resupply");
    perk_2_tally += player tally_completed_challenge(100, #"kills_after_sprint_fasthands");
    perk_2_tally += player tally_completed_challenge(200, #"kill_detect_tracker");
    perk_2_tally += player tally_completed_challenge(10, #"earn_5_scorestreaks_anteup");
    perk_2_tally += player tally_completed_challenge(25, #"kill_scavenger_tracker_resupply");
    perk_2_tally += player tally_completed_challenge(25, #"kill_hardwired_coldblooded");
    perk_2_tally += player tally_completed_challenge(25, #"kill_anteup_overclock_scorestreak_specialist");
    perk_2_tally += player tally_completed_challenge(50, #"kill_fasthands_gungho_sprint");
    perk_2_tally += player tally_completed_challenge(50, #"kill_tracker_sixthsense");
    if (mastery_perk_2 < perk_2_tally) {
        player stats::function_dad108fa(#"mastery_perk_2", 1);
    }
}

// Namespace challenges/challenges
// Params 1, eflags: 0x1 linked
// Checksum 0xb166e238, Offset: 0x7828
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
// Params 2, eflags: 0x1 linked
// Checksum 0x17c35fff, Offset: 0x78b0
// Size: 0xc4
function checkkillstreak5(baseweapon, player) {
    assert(isdefined(baseweapon));
    assert(isdefined(player.weaponkillsthisspawn));
    if (isdefined(player.weaponkillsthisspawn[baseweapon])) {
        player.weaponkillsthisspawn[baseweapon]++;
        if (player.weaponkillsthisspawn[baseweapon] % 5 == 0) {
            player stats::function_e24eec31(baseweapon, #"killstreak_5", 1);
        }
        return;
    }
    player.weaponkillsthisspawn[baseweapon] = 1;
}

// Namespace challenges/challenges
// Params 1, eflags: 0x1 linked
// Checksum 0x7e3a70e9, Offset: 0x7980
// Size: 0x6c
function function_b2b18857(player) {
    if (isdefined(player.headshots) && player.headshots > 0) {
        if (player.headshots % 5 == 0) {
            player stats::function_dad108fa(#"headshot_5", 1);
        }
    }
}

// Namespace challenges/challenges
// Params 6, eflags: 0x1 linked
// Checksum 0x67691323, Offset: 0x79f8
// Size: 0x8c
function checkdualwield(*baseweapon, player, attacker, time, attackerwassprinting, attacker_sprint_end) {
    if (attackerwassprinting || attacker_sprint_end + 1000 > time) {
        if (attacker util::has_gung_ho_perk_purchased_and_equipped()) {
            player stats::function_dad108fa(#"kills_sprinting_dual_wield_and_gung_ho", 1);
        }
    }
}

// Namespace challenges/challenges
// Params 1, eflags: 0x1 linked
// Checksum 0x1f1558e9, Offset: 0x7a90
// Size: 0x89a
function challengegameendmp(data) {
    player = data.player;
    winner = data.winner;
    var_f5d9e583 = data.place;
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
    mostekiasleastdeaths = 1;
    for (index = 0; index < level.placement[#"all"].size; index++) {
        if (level.placement[#"all"][index].deaths < player.deaths) {
            mostekiasleastdeaths = 0;
        }
        if (level.placement[#"all"][index].ekia > player.ekia) {
            mostekiasleastdeaths = 0;
        }
    }
    if (mostekiasleastdeaths && player.ekia > 0 && level.placement[#"all"].size > 3) {
        if (level.teambased) {
            playeriswinner = player.team === winner;
        } else {
            playeriswinner = var_f5d9e583 < 3;
        }
        if (playeriswinner) {
            player stats::function_dad108fa(#"most_ekias_least_deaths", 1);
            player contracts::increment_contract(#"hash_8f83854f9aa068e");
        }
    }
    if (var_f5d9e583 < 3) {
        if (level.hardcoremode) {
            player stats::function_dad108fa(#"hash_4551622490fb634f", 1);
        } else if (!level.arenamatch) {
            player stats::function_dad108fa(#"hash_726639776bb5add", 1);
        }
    }
    switch (level.gametype) {
    case #"tdm_hc":
    case #"tdm":
        if (player.team == winner) {
            if (winnerscore >= loserscore + 25) {
                player stats::function_d40764f3(#"crush", 1);
                player stats::function_dad108fa(#"hash_38cf622aaf2ce3d7", 1);
            }
        }
        break;
    case #"dm":
    case #"dm_hc":
        if (player == winner) {
            if (level.placement[#"all"].size >= 2) {
                secondplace = level.placement[#"all"][1];
                if (player.kills >= secondplace.kills + 7) {
                    player stats::function_d40764f3(#"crush", 1);
                    player stats::function_dad108fa(#"hash_38cf622aaf2ce3d7", 1);
                }
            }
        }
        break;
    case #"ctf":
    case #"ctf_hc":
        if (player.team == winner) {
            if (loserscore == 0) {
                player stats::function_d40764f3(#"shut_out", 1);
            }
        }
        break;
    case #"dom_hc":
    case #"dom":
        if (player.team == winner) {
            if (winnerscore >= loserscore + 70) {
                player stats::function_d40764f3(#"crush", 1);
                player stats::function_dad108fa(#"hash_1b0c06f37648493f", 1);
            }
        }
        break;
    case #"hq":
    case #"hq_hc":
        if (player.team == winner && winnerscore > 0) {
            if (winnerscore >= loserscore + 70) {
                player stats::function_d40764f3(#"crush", 1);
            }
        }
        break;
    case #"koth":
    case #"koth_hc":
        if (player.team == winner && winnerscore > 0) {
            if (winnerscore >= loserscore + 70) {
                player stats::function_d40764f3(#"crush", 1);
                player stats::function_dad108fa(#"hash_1b0c06f37648493f", 1);
            }
        }
        if (player.team == winner && winnerscore > 0) {
            if (winnerscore >= loserscore + 110) {
                player stats::function_d40764f3(#"annihilation", 1);
            }
        }
        break;
    case #"dem":
    case #"dem_hc":
        if (player.team == game.defenders && player.team == winner) {
            if (loserscore == 0) {
                player stats::function_d40764f3(#"shut_out", 1);
            }
        }
        break;
    case #"control":
    case #"sd":
    case #"control_hc":
    case #"bounty_hc":
    case #"bounty":
    case #"sd_hc":
        if (player.team == winner) {
            if (loserscore == 0) {
                player stats::function_d40764f3(#"crush", 1);
                player stats::function_dad108fa(#"hash_644326620d99cbbb", 1);
            }
        }
        break;
    case #"conf":
    case #"conf_hc":
        if (player.team == winner) {
            if (winnerscore >= loserscore + 25) {
                player stats::function_d40764f3(#"crush", 1);
            }
        }
        break;
    default:
        break;
    }
}

// Namespace challenges/challenges
// Params 1, eflags: 0x1 linked
// Checksum 0xcc59813e, Offset: 0x8338
// Size: 0x262
function function_ea966b4a(killstreak) {
    if (!isdefined(killstreak) || !isdefined(self) || !isplayer(self)) {
        return;
    }
    switch (killstreak) {
    case #"dart":
    case #"remote_missile":
    case #"inventory_planemortar":
    case #"drone_squadron":
    case #"inventory_drone_squadron":
    case #"overwatch_helicopter":
    case #"inventory_dart":
    case #"inventory_straferun":
    case #"inventory_ac130":
    case #"inventory_remote_missile":
    case #"straferun":
    case #"ac130":
    case #"helicopter_comlink":
    case #"planemortar":
    case #"inventory_overwatch_helicopter":
    case #"inventory_helicopter_comlink":
        self stats::function_dad108fa(#"air_assault_total_kills", 1);
        self contracts::player_contract_event(#"air_assault_total_kills");
        break;
    case #"ultimate_turret":
    case #"inventory_ultimate_turret":
    case #"tank_robot":
    case #"swat_team":
    case #"recon_car":
    case #"inventory_recon_car":
    case #"inventory_tank_robot":
    case #"inventory_swat_team":
        self stats::function_dad108fa(#"hash_10b0c56ae630070d", 1);
        self contracts::player_contract_event(#"hash_10b0c56ae630070d");
        break;
    }
}

// Namespace challenges/challenges
// Params 4, eflags: 0x0
// Checksum 0xfaff7c45, Offset: 0x85a8
// Size: 0x7c4
function function_2f462ffd(victim, weapon, *inflictor, objective) {
    if (!isdefined(inflictor) || !isdefined(self) || !isplayer(self) || !isdefined(weapon) || !isplayer(weapon)) {
        return;
    }
    if (level.teambased) {
        if (self.team == weapon.team) {
            return;
        }
    } else if (self == weapon) {
        return;
    }
    killstreak = killstreaks::get_from_weapon(inflictor);
    if (isdefined(killstreak)) {
        switch (killstreak) {
        case #"dart":
        case #"remote_missile":
        case #"inventory_planemortar":
        case #"drone_squadron":
        case #"inventory_drone_squadron":
        case #"overwatch_helicopter":
        case #"inventory_dart":
        case #"inventory_straferun":
        case #"inventory_ac130":
        case #"inventory_remote_missile":
        case #"straferun":
        case #"ac130":
        case #"helicopter_comlink":
        case #"planemortar":
        case #"inventory_overwatch_helicopter":
        case #"inventory_helicopter_comlink":
            self stats::function_dad108fa(#"hash_55a5fc51678a4dde", 1);
            break;
        case #"recon_car":
        case #"inventory_recon_car":
            self stats::function_dad108fa(#"hash_7daf653f5e86b75", 1);
        case #"ultimate_turret":
        case #"inventory_ultimate_turret":
        case #"tank_robot":
        case #"swat_team":
        case #"inventory_tank_robot":
        case #"inventory_swat_team":
            self stats::function_dad108fa(#"hash_1efa6ab922134e1d", 1);
            break;
        }
    } else {
        if (level.hardcoremode) {
            self stats::function_dad108fa(#"hash_753f02ea48b19cd", 1);
        } else if (!level.arenamatch) {
            self stats::function_dad108fa(#"hash_45fca5cee12d8bdb", 1);
        }
        self contracts::player_contract_event(#"objective_ekia");
        scoreevents = globallogic_score::function_3cbc4c6c(inflictor.var_2e4a8800);
        var_8a4cfbd = inflictor.var_76ce72e8 && isdefined(scoreevents) && scoreevents.var_fcd2ff3a === 1;
        if (var_8a4cfbd) {
            self stats::function_dad108fa(#"hash_d4a989a2da3fa72", 1);
        } else if (inflictor.issignatureweapon) {
            self stats::function_dad108fa(#"hash_6c3172682467122", 1);
        }
        if (isdefined(inflictor.attachments) && inflictor.attachments.size > 2) {
            if (self weaponhasattachmentandunlocked(inflictor, "suppressed", "barrel")) {
                if (!isdefined(self.var_953ec9b5)) {
                    self.var_953ec9b5 = [];
                }
                if (!isdefined(self.var_953ec9b5[objective.entnum])) {
                    self.var_953ec9b5[objective.entnum] = 0;
                }
                self.var_953ec9b5[objective.entnum]++;
                if (self.var_953ec9b5[objective.entnum] == 5) {
                    self stats::function_dad108fa(#"hash_6f0a5b0f2c1e8ed5", 1);
                }
            }
        }
        if (isdefined(weapon.var_ea1458aa)) {
            var_d72bd991 = weapon.var_ea1458aa.attackerdamage[self.clientid];
            gear = self function_b958b70d(var_d72bd991.class_num, "tacticalgear");
            if (gear == #"gear_medicalinjectiongun") {
                if (var_d72bd991.var_46a82df0 === 1) {
                    self stats::function_dad108fa(#"hash_47c5c8af0f105c71", 1);
                }
            } else if (gear == #"gear_equipmentcharge") {
                if (var_8a4cfbd) {
                    if (!isdefined(self.var_9cd2c51d.var_17ff6e52)) {
                        self.var_9cd2c51d.var_17ff6e52 = 0;
                    }
                    self.var_9cd2c51d.var_17ff6e52++;
                    if (self.var_9cd2c51d.var_17ff6e52 == 5) {
                        self stats::function_dad108fa(#"hash_386525eb8f4537c2", 1);
                    }
                }
            }
        }
        if (isdefined(weapon.lastconcussedby) && weapon.lastconcussedby == self && isdefined(weapon.var_121392a1)) {
            if (isdefined(weapon.var_121392a1[#"hash_1527a22d8a6fdc21"]) && weapon.var_121392a1[#"hash_1527a22d8a6fdc21"].endtime > gettime()) {
                if (self util::is_item_purchased(#"eq_slow_grenade")) {
                    self stats::function_dad108fa(#"hash_1a02c128bae3a6a0", 1);
                }
            }
        }
    }
    victimweapon = weapon.currentweapon;
    var_2cf35051 = globallogic_score::function_3cbc4c6c(victimweapon.var_2e4a8800);
    if (victimweapon.issignatureweapon === 1 || isdefined(var_2cf35051) && var_2cf35051.var_fcd2ff3a === 1) {
        self stats::function_dad108fa(#"end_enemy_specialist_weapon_on_objective", 1);
    }
}

// Namespace challenges/challenges
// Params 1, eflags: 0x0
// Checksum 0x8ed8c912, Offset: 0x8d78
// Size: 0xfe
function function_82bb78f7(weapon) {
    if (!isdefined(self) || !isplayer(self) || !isdefined(weapon) || isdefined(killstreaks::get_from_weapon(weapon))) {
        return;
    }
    self activecamo::function_896ac347(weapon, #"vanguard", 1);
    if (isdefined(self.var_aef7ad9) && self.var_aef7ad9 + int(5 * 1000) >= gettime()) {
        self activecamo::function_896ac347(weapon, #"rapid_vanguard", 1);
    }
    self.var_aef7ad9 = gettime();
}

// Namespace challenges/challenges
// Params 1, eflags: 0x0
// Checksum 0xa6ce125f, Offset: 0x8e80
// Size: 0xac
function function_e0f51b6f(weapon) {
    should_award = 0;
    if (weapon.issignatureweapon) {
        should_award = 1;
    } else {
        scoreevents = globallogic_score::function_3cbc4c6c(weapon.var_2e4a8800);
        should_award = weapon.var_76ce72e8 && isdefined(scoreevents) && scoreevents.var_fcd2ff3a === 1;
    }
    if (should_award) {
        self stats::function_dad108fa(#"hash_7dfdf288a8fccdb0", 1);
    }
}

// Namespace challenges/challenges
// Params 1, eflags: 0x1 linked
// Checksum 0xdf9d28fa, Offset: 0x8f38
// Size: 0xac
function function_57ca42c6(weapon) {
    should_award = 0;
    if (weapon.issignatureweapon) {
        should_award = 1;
    } else {
        scoreevents = globallogic_score::function_3cbc4c6c(weapon.var_2e4a8800);
        should_award = weapon.var_76ce72e8 && isdefined(scoreevents) && scoreevents.var_fcd2ff3a === 1;
    }
    if (should_award) {
        self stats::function_dad108fa(#"hash_7ddba69a0de126e5", 1);
    }
}

// Namespace challenges/challenges
// Params 3, eflags: 0x0
// Checksum 0x78765be1, Offset: 0x8ff0
// Size: 0x4ce
function killedbaseoffender(objective, weapon, inflictor) {
    self endon(#"disconnect");
    self stats::function_bb7eedf0(#"defends", 1);
    self.challenge_offenderkillcount++;
    if (isdefined(self.var_ea1458aa) && isdefined(objective)) {
        if (!isdefined(self.var_ea1458aa.challenge_objectiveoffensive) || !(self.var_ea1458aa.challenge_objectiveoffensive === objective)) {
            self.var_ea1458aa.challenge_objectiveoffensivekillcount = 0;
        }
        self.var_ea1458aa.challenge_objectiveoffensivekillcount++;
        self.var_ea1458aa.challenge_objectiveoffensive = objective;
        if (self.var_ea1458aa.challenge_objectiveoffensivekillcount > 4) {
            self stats::function_dad108fa(#"multikill_5_attackers", 1);
            self.var_ea1458aa.challenge_objectiveoffensivekillcount = 0;
        }
    }
    killstreak = killstreaks::get_from_weapon(weapon);
    if (isdefined(killstreak)) {
        switch (killstreak) {
        case #"remote_missile":
        case #"inventory_planemortar":
        case #"inventory_straferun":
        case #"inventory_remote_missile":
        case #"straferun":
        case #"planemortar":
            self.challenge_offenderprojectilemultikillcount++;
            break;
        case #"helicopter_comlink":
        case #"inventory_helicopter_comlink":
            self.challenge_offendercomlinkkillcount++;
            break;
        case #"combat_robot":
        case #"inventory_combat_robot":
            self stats::function_dad108fa(#"kill_attacker_with_robot_or_tank", 1);
            break;
        case #"autoturret":
        case #"inventory_autoturret":
            self.challenge_offendersentryturretkillcount++;
            self stats::function_dad108fa(#"kill_attacker_with_robot_or_tank", 1);
            break;
        case #"swat_team":
        case #"inventory_swat_team":
            self stats::function_dad108fa(#"hash_103a235d7563069c", 1);
            break;
        case #"ultimate_turret":
        case #"inventory_ultimate_turret":
            self stats::function_dad108fa(#"hash_103a235d7563069c", 1);
            if (isdefined(inflictor)) {
                if (!isdefined(inflictor.var_d6489fb6)) {
                    inflictor.var_d6489fb6 = 0;
                }
                inflictor.var_d6489fb6++;
                if (inflictor.var_d6489fb6 == 3) {
                    self stats::function_dad108fa(#"hash_1379d16cee958f3e", 1);
                }
            }
            break;
        }
    }
    if (self.challenge_offendercomlinkkillcount == 2) {
        self stats::function_dad108fa(#"kill_2_attackers_with_comlink", 1);
    }
    if (self.challenge_offendersentryturretkillcount > 2) {
        self stats::function_dad108fa(#"multikill_3_attackers_ai_tank", 1);
        self.challenge_offendersentryturretkillcount = 0;
    }
    self contracts::player_contract_event(#"offender_kill");
    self waittilltimeoutordeath(4);
    if (self.challenge_offenderkillcount > 1) {
        self stats::function_dad108fa(#"hash_4b3049ba027dd495", 1);
    }
    self.challenge_offenderkillcount = 0;
    if (self.challenge_offenderprojectilemultikillcount >= 2) {
        self stats::function_dad108fa(#"multikill_2_objective_scorestreak_projectile", 1);
    }
    self.challenge_offenderprojectilemultikillcount = 0;
}

// Namespace challenges/challenges
// Params 1, eflags: 0x0
// Checksum 0xa9920c1a, Offset: 0x94c8
// Size: 0x10e
function killedbasedefender(objective) {
    self endon(#"disconnect");
    self stats::function_bb7eedf0(#"offends", 1);
    if (!isdefined(self.challenge_objectivedefensive) || self.challenge_objectivedefensive != objective) {
        self.challenge_objectivedefensivekillcount = 0;
    }
    self.challenge_objectivedefensivekillcount++;
    self.challenge_objectivedefensive = objective;
    self.challenge_defenderkillcount++;
    self contracts::player_contract_event(#"defender_kill");
    self waittilltimeoutordeath(4);
    if (self.challenge_defenderkillcount > 1) {
        self stats::function_dad108fa(#"hash_4b3049ba027dd495", 1);
    }
    self.challenge_defenderkillcount = 0;
}

// Namespace challenges/challenges
// Params 1, eflags: 0x1 linked
// Checksum 0x5f2ded25, Offset: 0x95e0
// Size: 0x26
function waittilltimeoutordeath(timeout) {
    self endon(#"death");
    wait timeout;
}

// Namespace challenges/challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x72385d2e, Offset: 0x9610
// Size: 0x5c
function killstreak_30_noscorestreaks() {
    if (level.gametype == "dm" || level.gametype == "dm_hc") {
        self stats::function_dad108fa(#"killstreak_30_no_scorestreaks", 1);
    }
}

// Namespace challenges/challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x1ed5eb34, Offset: 0x9678
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
// Params 0, eflags: 0x1 linked
// Checksum 0x89152115, Offset: 0x9730
// Size: 0x74
function checkforherosurvival() {
    self endon(#"death", #"disconnect");
    self waittilltimeout(8, #"challenge_survived_from_death", #"disconnect");
    self stats::function_dad108fa(#"death_dodger", 1);
}

// Namespace challenges/challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xc19b8407, Offset: 0x97b0
// Size: 0xe
function calledincomlinkchopper() {
    self.challenge_offendercomlinkkillcount = 0;
}

// Namespace challenges/challenges
// Params 2, eflags: 0x0
// Checksum 0x78a5b36b, Offset: 0x97c8
// Size: 0x54
function combat_robot_damage(eattacker, combatrobotowner) {
    if (!isdefined(eattacker.challenge_combatrobotattackclientid[combatrobotowner.clientid])) {
        eattacker.challenge_combatrobotattackclientid[combatrobotowner.clientid] = spawnstruct();
    }
}

// Namespace challenges/challenges
// Params 1, eflags: 0x1 linked
// Checksum 0x677dc5a, Offset: 0x9828
// Size: 0x1f4
function trackkillstreaksupportkills(victim) {
    if (isdefined(level.activeplayeruavs[self.entnum]) && level.activeplayeruavs[self.entnum] > 0 && (!isdefined(level.forceradar) || level.forceradar == 0)) {
        self stats::function_e24eec31(getweapon(#"uav"), #"kills_while_active", 1);
    }
    if (isdefined(level.activeplayersatellites) && level.activeplayersatellites[self.entnum] > 0) {
        self stats::function_e24eec31(getweapon(#"satellite"), #"kills_while_active", 1);
    }
    if (isdefined(level.activeplayercounteruavs[self.entnum]) && level.activeplayercounteruavs[self.entnum] > 0) {
        self stats::function_e24eec31(getweapon(#"counteruav"), #"kills_while_active", 1);
    }
    if (isdefined(victim.lastmicrowavedby) && victim.lastmicrowavedby == self) {
        self stats::function_e24eec31(getweapon(#"microwave_turret"), #"kills_while_active", 1);
    }
}

// Namespace challenges/reload
// Params 1, eflags: 0x40
// Checksum 0xd1cc52b6, Offset: 0x9a28
// Size: 0xaa
function event_handler[reload] function_b4174270(eventstruct) {
    if (level.var_e7c95d09 === 1) {
        return;
    }
    currentweapon = eventstruct.weapon;
    if (currentweapon == level.weaponnone) {
        return;
    }
    time = gettime();
    self.lastreloadtime = time;
    if (isdefined(self.var_ea1458aa)) {
        self.var_ea1458aa.var_23f5861b = undefined;
    }
    if (weaponhasattachment(currentweapon, "fastreload")) {
        self.lastfastreloadtime = time;
    }
}

// Namespace challenges/challenges
// Params 2, eflags: 0x1 linked
// Checksum 0x60fc0876, Offset: 0x9ae0
// Size: 0xdc
function longdistancekillmp(weapon, *meansofdeath) {
    self stats::function_e24eec31(meansofdeath, #"longshot_kill", 1);
    if (isdefined(meansofdeath.attachments) && meansofdeath.attachments.size > 1) {
        if (self weaponhasattachmentandunlocked(meansofdeath, "barrel", "suppressed")) {
            if (self getweaponoptic(meansofdeath) != "") {
                self stats::function_dad108fa(#"long_shot_longbarrel_suppressor_optic", 1);
            }
        }
    }
}

// Namespace challenges/challenges
// Params 1, eflags: 0x1 linked
// Checksum 0x337e01f, Offset: 0x9bc8
// Size: 0x2c
function processspecialistchallenge(statname) {
    self addspecialiststat(statname, 1);
}

// Namespace challenges/challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x488869e1, Offset: 0x9c00
// Size: 0x94
function flakjacketprotectedmp() {
    self endon(#"death");
    level endon(#"game_ended");
    self notify("193a4c5df7b3204f");
    self endon("193a4c5df7b3204f");
    if (!self function_6c32d092(#"talent_flakjacket")) {
        return;
    }
    wait 2;
    self stats::function_dad108fa(#"survive_with_flak", 1);
}

// Namespace challenges/challenges
// Params 2, eflags: 0x5 linked
// Checksum 0xb451bf87, Offset: 0x9ca0
// Size: 0x42
function private function_7ec2f2c(slot_index, killed) {
    slot = self loadout::get_loadout_slot(slot_index);
    slot.killed = killed;
}

// Namespace challenges/challenges
// Params 1, eflags: 0x5 linked
// Checksum 0xb0f2f1c1, Offset: 0x9cf0
// Size: 0x36
function private function_861fe993(slot_index) {
    slot = self loadout::get_loadout_slot(slot_index);
    return slot.killed;
}

// Namespace challenges/challenges
// Params 4, eflags: 0x1 linked
// Checksum 0x29fa466f, Offset: 0x9d30
// Size: 0x48
function function_3ee91387(weapon, *playercontrolled, *groundbased, *countaskillstreakvehicle) {
    if (isdefined(level.hintobjectivehint_updat)) {
        self [[ level.hintobjectivehint_updat ]](countaskillstreakvehicle);
    }
}

// Namespace challenges/challenges
// Params 3, eflags: 0x1 linked
// Checksum 0x6e637b38, Offset: 0x9d80
// Size: 0x34
function function_19e8b086(killcount, weapon, var_2e4a8800) {
    self specialist_multikill(killcount, weapon, var_2e4a8800);
}

// Namespace challenges/challenges
// Params 3, eflags: 0x5 linked
// Checksum 0xa3782d22, Offset: 0x9dc0
// Size: 0x154
function private specialist_multikill(*killcount, weapon, scoreevents) {
    baseweapon = getweapon(weapon.statname);
    ability = self loadout::function_18a77b37("specialgrenade");
    if (isdefined(ability) && is_true(baseweapon.issignatureweapon)) {
        self stats::function_dad108fa(#"specialist_multikill", 1);
        return;
    }
    equipment = self loadout::function_18a77b37("primarygrenade");
    if (isdefined(equipment) && is_true(baseweapon.var_76ce72e8) && isdefined(scoreevents) && is_true(scoreevents.var_fcd2ff3a)) {
        self stats::function_dad108fa(#"specialist_multikill", 1);
    }
}

