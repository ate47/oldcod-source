#using scripts\abilities\ability_util;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\dev_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\healthoverlay;
#using scripts\core_common\loadout_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\perks;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\tweakables_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\mp_common\armor;
#using scripts\mp_common\challenges;
#using scripts\mp_common\gametypes\dev;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\teams\teams;
#using scripts\weapons\weapon_utils;

#namespace loadout;

// Namespace loadout/player_loadout
// Params 0, eflags: 0x2
// Checksum 0x2723eddc, Offset: 0x470
// Size: 0x24
function autoexec function_c7b8e4fb() {
    callback::on_start_gametype(&function_e03ad0f1);
}

// Namespace loadout/player_loadout
// Params 0, eflags: 0x0
// Checksum 0xc87f6d6b, Offset: 0x4a0
// Size: 0x1e
function function_e03ad0f1() {
    profilestart();
    mp_init();
    profilestop();
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x0
// Checksum 0x7d10139e, Offset: 0x4c8
// Size: 0xa16
function function_c30c3e1(weapons_table) {
    level.weapon_sig_minigun = getweapon(#"sig_minigun");
    level.weapon_hero_annihilator = getweapon(#"hash_5ad0111d1b5c15d2");
    level.weaponbasemeleeheld = getweapon(#"bare_hands");
    level.weaponknifeloadout = getweapon(#"knife_loadout");
    level.var_dbfc7979 = getweapon(#"hash_621375504166608a");
    level.var_4b668568 = getweapon(#"hash_767be96cf6b67c9f");
    level.var_ed508918 = getweapon(#"hash_6528d67aee6f8e7d");
    level.var_9d6d34a6 = getweapon(#"hash_57ede9407d094555");
    level.var_2506cce1 = getweapon(#"hash_40fe1c0b2fd5fd9c");
    level.weaponspecialcrossbow = getweapon(#"special_crossbow");
    level.var_a37fcb5 = getweapon(#"hash_7fa6f020656ec42");
    level.var_87abc71c = getweapon(#"melee_bat");
    level.var_50ef580f = getweapon(#"melee_bowie");
    level.var_fcab6539 = getweapon(#"hash_237fe9f8d55cb55e");
    level.var_680e11a1 = getweapon(#"hash_3651d81f0fccde7c");
    level.var_d81e42fb = getweapon(#"hash_4d000f8349450c36");
    level.var_b6eabba5 = getweapon(#"hash_fbd50963ccf562c");
    level.weaponshotgunenergy = getweapon(#"shotgun_energy");
    level.weaponpistolenergy = getweapon(#"pistol_energy");
    level.var_f5c917fc = getweapon(#"ac130_chaingun");
    if (!isdefined(level.meleeweapons)) {
        level.meleeweapons = [];
    } else if (!isarray(level.meleeweapons)) {
        level.meleeweapons = array(level.meleeweapons);
    }
    level.meleeweapons[level.meleeweapons.size] = level.weaponknifeloadout;
    if (!isdefined(level.meleeweapons)) {
        level.meleeweapons = [];
    } else if (!isarray(level.meleeweapons)) {
        level.meleeweapons = array(level.meleeweapons);
    }
    level.meleeweapons[level.meleeweapons.size] = level.var_dbfc7979;
    if (!isdefined(level.meleeweapons)) {
        level.meleeweapons = [];
    } else if (!isarray(level.meleeweapons)) {
        level.meleeweapons = array(level.meleeweapons);
    }
    level.meleeweapons[level.meleeweapons.size] = level.var_4b668568;
    if (!isdefined(level.meleeweapons)) {
        level.meleeweapons = [];
    } else if (!isarray(level.meleeweapons)) {
        level.meleeweapons = array(level.meleeweapons);
    }
    level.meleeweapons[level.meleeweapons.size] = level.var_ed508918;
    if (!isdefined(level.meleeweapons)) {
        level.meleeweapons = [];
    } else if (!isarray(level.meleeweapons)) {
        level.meleeweapons = array(level.meleeweapons);
    }
    level.meleeweapons[level.meleeweapons.size] = level.var_9d6d34a6;
    if (!isdefined(level.meleeweapons)) {
        level.meleeweapons = [];
    } else if (!isarray(level.meleeweapons)) {
        level.meleeweapons = array(level.meleeweapons);
    }
    level.meleeweapons[level.meleeweapons.size] = level.var_2506cce1;
    if (!isdefined(level.meleeweapons)) {
        level.meleeweapons = [];
    } else if (!isarray(level.meleeweapons)) {
        level.meleeweapons = array(level.meleeweapons);
    }
    level.meleeweapons[level.meleeweapons.size] = level.var_a37fcb5;
    if (!isdefined(level.meleeweapons)) {
        level.meleeweapons = [];
    } else if (!isarray(level.meleeweapons)) {
        level.meleeweapons = array(level.meleeweapons);
    }
    level.meleeweapons[level.meleeweapons.size] = level.var_87abc71c;
    if (!isdefined(level.meleeweapons)) {
        level.meleeweapons = [];
    } else if (!isarray(level.meleeweapons)) {
        level.meleeweapons = array(level.meleeweapons);
    }
    level.meleeweapons[level.meleeweapons.size] = level.var_50ef580f;
    if (!isdefined(level.meleeweapons)) {
        level.meleeweapons = [];
    } else if (!isarray(level.meleeweapons)) {
        level.meleeweapons = array(level.meleeweapons);
    }
    level.meleeweapons[level.meleeweapons.size] = level.var_fcab6539;
    if (!isdefined(level.meleeweapons)) {
        level.meleeweapons = [];
    } else if (!isarray(level.meleeweapons)) {
        level.meleeweapons = array(level.meleeweapons);
    }
    level.meleeweapons[level.meleeweapons.size] = level.var_680e11a1;
    if (!isdefined(level.meleeweapons)) {
        level.meleeweapons = [];
    } else if (!isarray(level.meleeweapons)) {
        level.meleeweapons = array(level.meleeweapons);
    }
    level.meleeweapons[level.meleeweapons.size] = level.var_d81e42fb;
    if (!isdefined(level.meleeweapons)) {
        level.meleeweapons = [];
    } else if (!isarray(level.meleeweapons)) {
        level.meleeweapons = array(level.meleeweapons);
    }
    level.meleeweapons[level.meleeweapons.size] = level.var_b6eabba5;
}

// Namespace loadout/player_loadout
// Params 0, eflags: 0x0
// Checksum 0xba0bb20a, Offset: 0xee8
// Size: 0x422
function function_f2f46f6c() {
    level.classmap[#"class_smg"] = "CLASS_SMG";
    level.classmap[#"class_cqb"] = "CLASS_CQB";
    level.classmap[#"class_assault"] = "CLASS_ASSAULT";
    level.classmap[#"class_lmg"] = "CLASS_LMG";
    level.classmap[#"class_sniper"] = "CLASS_SNIPER";
    level.classmap[#"class_specialized"] = "CLASS_SPECIALIZED";
    level.classmap[#"custom0"] = "CLASS_CUSTOM1";
    level.classmap[#"custom1"] = "CLASS_CUSTOM2";
    level.classmap[#"custom2"] = "CLASS_CUSTOM3";
    level.classmap[#"custom3"] = "CLASS_CUSTOM4";
    level.classmap[#"custom4"] = "CLASS_CUSTOM5";
    level.classmap[#"custom5"] = "CLASS_CUSTOM6";
    level.classmap[#"custom6"] = "CLASS_CUSTOM7";
    level.classmap[#"custom7"] = "CLASS_CUSTOM8";
    level.classmap[#"custom8"] = "CLASS_CUSTOM9";
    level.classmap[#"custom9"] = "CLASS_CUSTOM10";
    level.classmap[#"custom10"] = "CLASS_CUSTOM11";
    level.classmap[#"custom11"] = "CLASS_CUSTOM12";
    level.classmap[#"custom12"] = level.classmap[#"class_smg"];
    level.classmap[#"custom13"] = level.classmap[#"class_cqb"];
    level.classmap[#"custom14"] = level.classmap[#"class_assault"];
    level.classmap[#"custom15"] = level.classmap[#"class_lmg"];
    level.classmap[#"custom16"] = level.classmap[#"class_sniper"];
    level.classmap[#"custom17"] = level.classmap[#"class_specialized"];
}

// Namespace loadout/player_loadout
// Params 0, eflags: 0x0
// Checksum 0x8fd07a4b, Offset: 0x1318
// Size: 0x30
function function_cd383ec5() {
    if (isdefined(level.var_cd383ec5) && level.var_cd383ec5 == 0) {
        return false;
    }
    return true;
}

// Namespace loadout/player_loadout
// Params 0, eflags: 0x0
// Checksum 0x88a0eb8f, Offset: 0x1350
// Size: 0x114
function function_1d7e0005() {
    if (!function_cd383ec5()) {
        return;
    }
    function_f2f46f6c();
    level.defaultclass = "CLASS_CUSTOM1";
    create_class_exclusion_list();
    load_default_loadout("CLASS_SMG", 12);
    load_default_loadout("CLASS_CQB", 13);
    load_default_loadout("CLASS_ASSAULT", 14);
    load_default_loadout("CLASS_LMG", 15);
    load_default_loadout("CLASS_SNIPER", 16);
    load_default_loadout("CLASS_SPECIALIZED", 17);
}

// Namespace loadout/player_loadout
// Params 0, eflags: 0x0
// Checksum 0x2af7732f, Offset: 0x1470
// Size: 0xf4
function mp_init() {
    level.maxkillstreaks = 4;
    level.maxspecialties = 6;
    level.maxallocation = getgametypesetting(#"maxallocation");
    level.loadoutkillstreaksenabled = getgametypesetting(#"loadoutkillstreaksenabled");
    level.prestigenumber = 5;
    function_3eeafcd9();
    level thread function_7d119baa();
    function_c30c3e1();
    function_1d7e0005();
    callback::on_connecting(&on_player_connecting);
}

// Namespace loadout/player_loadout
// Params 0, eflags: 0x4
// Checksum 0x12154eac, Offset: 0x1570
// Size: 0x108
function private create_class_exclusion_list() {
    currentdvar = 0;
    level.itemexclusions = [];
    while (getdvarint("item_exclusion_" + currentdvar, 0)) {
        level.itemexclusions[currentdvar] = getdvarint("item_exclusion_" + currentdvar, 0);
        currentdvar++;
    }
    level.attachmentexclusions = [];
    for (currentdvar = 0; getdvarstring("attachment_exclusion_" + currentdvar) != ""; currentdvar++) {
        level.attachmentexclusions[currentdvar] = getdvarstring("attachment_exclusion_" + currentdvar);
    }
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x4
// Checksum 0x6c92b389, Offset: 0x1680
// Size: 0x68
function private is_attachment_excluded(attachment) {
    numexclusions = level.attachmentexclusions.size;
    for (exclusionindex = 0; exclusionindex < numexclusions; exclusionindex++) {
        if (attachment == level.attachmentexclusions[exclusionindex]) {
            return true;
        }
    }
    return false;
}

// Namespace loadout/player_loadout
// Params 2, eflags: 0x4
// Checksum 0x8fc90830, Offset: 0x16f0
// Size: 0x2a
function private load_default_loadout(weaponclass, classnum) {
    level.classtoclassnum[weaponclass] = classnum;
}

// Namespace loadout/player_loadout
// Params 2, eflags: 0x4
// Checksum 0x42e04b1a, Offset: 0x1728
// Size: 0x19c
function private weapon_class_register(weaponname, weapon_type) {
    if (issubstr("weapon_smg weapon_cqb weapon_assault weapon_tactical weapon_lmg weapon_sniper weapon_shotgun weapon_launcher weapon_knife weapon_special", weapon_type)) {
        level.primary_weapon_array[getweapon(weaponname)] = 1;
        return;
    }
    if (issubstr("weapon_pistol", weapon_type)) {
        level.side_arm_array[getweapon(weaponname)] = 1;
        return;
    }
    if (issubstr("weapon_grenade hero", weapon_type)) {
        level.grenade_array[getweapon(weaponname)] = 1;
        return;
    }
    if (weapon_type == "weapon_explosive") {
        level.inventory_array[getweapon(weaponname)] = 1;
        return;
    }
    if (weapon_type == "weapon_rifle") {
        level.inventory_array[getweapon(weaponname)] = 1;
        return;
    }
    assert(0, "<dev string:x30>" + weapon_type + "<dev string:x71>" + weaponname);
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x4
// Checksum 0xf8d4a00f, Offset: 0x18d0
// Size: 0x42
function private heavy_weapon_register_dialog(weapon) {
    readyvo = weapon.name + "_ready";
    game.dialog[readyvo] = readyvo;
}

// Namespace loadout/player_loadout
// Params 0, eflags: 0x4
// Checksum 0x3d3a9b76, Offset: 0x1920
// Size: 0x1fc
function private function_3eeafcd9() {
    level.meleeweapons = [];
    level.primary_weapon_array = [];
    level.side_arm_array = [];
    level.grenade_array = [];
    level.inventory_array = [];
    level.perkicons = [];
    level.perkspecialties = [];
    level.killstreakicons = [];
    level.killstreakindices = [];
    for (i = 0; i < 1024; i++) {
        iteminfo = getunlockableiteminfofromindex(i, 0);
        if (isdefined(iteminfo)) {
            group_s = iteminfo.itemgroupname;
            reference_s = iteminfo.name;
            var_b0500e1a = iteminfo.namehash;
            display_name_s = iteminfo.displayname;
            if (issubstr(group_s, "weapon_") || group_s == "hero") {
                if (group_s != "" && var_b0500e1a != "") {
                    weapon_class_register(var_b0500e1a, group_s);
                }
                continue;
            }
            if (group_s == "specialty") {
                level.perkspecialties[display_name_s] = reference_s;
                continue;
            }
            if (group_s == "killstreak") {
                level.tbl_killstreakdata[i] = var_b0500e1a;
                level.killstreakindices[var_b0500e1a] = i;
            }
        }
    }
}

// Namespace loadout/player_loadout
// Params 0, eflags: 0x4
// Checksum 0x14907e9e, Offset: 0x1b28
// Size: 0x18e
function private function_7d119baa() {
    /#
        wait 0.5;
        for (i = 0; i < 1024; i++) {
            iteminfo = getunlockableiteminfofromindex(i, 0);
            if (!isdefined(iteminfo)) {
                continue;
            }
            reference_s = iteminfo.name;
            if (reference_s == "<dev string:x7f>") {
                continue;
            }
            group_s = iteminfo.itemgroupname;
            display_name_s = iteminfo.displayname;
            if (group_s == "<dev string:x80>") {
                dev::add_perk_devgui(display_name_s, reference_s);
                continue;
            }
            if (group_s == "<dev string:x8a>") {
                if (strstartswith(iteminfo.name, "<dev string:x91>")) {
                    dev::function_89d3cfb4(reference_s, "<dev string:x99>");
                    continue;
                }
                postfix = "<dev string:x9d>" + sessionmodeabbreviation();
                dev::function_69a73201(reference_s, postfix);
            }
        }
    #/
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x0
// Checksum 0xf7e24ef1, Offset: 0x1cc0
// Size: 0x44
function function_b30f6c7c(response) {
    assert(isdefined(level.classmap[response]));
    return level.classmap[response];
}

// Namespace loadout/player_loadout
// Params 2, eflags: 0x4
// Checksum 0x28603264, Offset: 0x1d10
// Size: 0x9c
function private get_killstreak_index(weaponclass, killstreaknum) {
    killstreaknum++;
    killstreakstring = "killstreak" + killstreaknum;
    if (getdvarint(#"custom_killstreak_mode", 0) == 2) {
        return getdvarint("custom_" + killstreakstring, 0);
    }
    return self getloadoutitem(weaponclass, killstreakstring);
}

// Namespace loadout/player_loadout
// Params 0, eflags: 0x0
// Checksum 0x13956546, Offset: 0x1db8
// Size: 0x55e
function give_killstreaks() {
    self.killstreak = [];
    if (!level.loadoutkillstreaksenabled) {
        return;
    }
    classnum = self.class_num_for_global_weapons;
    sortedkillstreaks = [];
    currentkillstreak = 0;
    for (killstreaknum = 0; killstreaknum < level.maxkillstreaks; killstreaknum++) {
        killstreakindex = get_killstreak_index(classnum, killstreaknum);
        if (isdefined(killstreakindex) && killstreakindex > 0) {
            assert(isdefined(level.tbl_killstreakdata[killstreakindex]), "<dev string:x9f>" + killstreakindex + "<dev string:xad>");
            if (isdefined(level.tbl_killstreakdata[killstreakindex])) {
                self.killstreak[currentkillstreak] = level.tbl_killstreakdata[killstreakindex];
                if (isdefined(level.usingmomentum) && level.usingmomentum) {
                    killstreaktype = killstreaks::get_by_menu_name(self.killstreak[currentkillstreak]);
                    if (isdefined(killstreaktype)) {
                        weapon = killstreaks::get_killstreak_weapon(killstreaktype);
                        self giveweapon(weapon);
                        if (isdefined(level.usingscorestreaks) && level.usingscorestreaks) {
                            if (weapon.iscarriedkillstreak) {
                                if (!isdefined(self.pers[#"held_killstreak_ammo_count"][weapon])) {
                                    self.pers[#"held_killstreak_ammo_count"][weapon] = 0;
                                }
                                if (!isdefined(self.pers[#"held_killstreak_clip_count"][weapon])) {
                                    self.pers[#"held_killstreak_clip_count"][weapon] = 0;
                                }
                                if (self.pers[#"held_killstreak_ammo_count"][weapon] > 0) {
                                    self setweaponammoclip(weapon, self.pers[#"held_killstreak_clip_count"][weapon]);
                                    self setweaponammostock(weapon, self.pers[#"held_killstreak_ammo_count"][weapon] - self.pers[#"held_killstreak_clip_count"][weapon]);
                                } else {
                                    self function_fae397a1(weapon, 0);
                                }
                            } else {
                                quantity = self.pers[#"killstreak_quantity"][weapon];
                                if (!isdefined(quantity)) {
                                    quantity = 0;
                                }
                                self setweaponammoclip(weapon, quantity);
                            }
                        }
                        sortdata = spawnstruct();
                        sortdata.cost = self function_ec6a435b(level.killstreaks[killstreaktype].itemindex);
                        sortdata.weapon = weapon;
                        sortindex = 0;
                        for (sortindex = 0; sortindex < sortedkillstreaks.size; sortindex++) {
                            if (sortedkillstreaks[sortindex].cost > sortdata.cost) {
                                break;
                            }
                        }
                        for (i = sortedkillstreaks.size; i > sortindex; i--) {
                            sortedkillstreaks[i] = sortedkillstreaks[i - 1];
                        }
                        sortedkillstreaks[sortindex] = sortdata;
                    }
                }
                currentkillstreak++;
            }
        }
    }
    var_1dc8fd1d = [];
    var_1dc8fd1d[0] = 3;
    var_1dc8fd1d[1] = 1;
    var_1dc8fd1d[2] = 0;
    if (isdefined(level.usingmomentum) && level.usingmomentum) {
        for (sortindex = 0; sortindex < sortedkillstreaks.size && sortindex < var_1dc8fd1d.size; sortindex++) {
            if (sortedkillstreaks[sortindex].weapon != level.weaponnone) {
                self setkillstreakweapon(var_1dc8fd1d[sortindex], sortedkillstreaks[sortindex].weapon);
            }
        }
    }
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x4
// Checksum 0x7b3ae716, Offset: 0x2320
// Size: 0x16
function private reset_specialty_slots(class_num) {
    self.specialty = [];
}

// Namespace loadout/player_loadout
// Params 0, eflags: 0x0
// Checksum 0xe6d7460c, Offset: 0x2340
// Size: 0xe
function function_2d98422e() {
    self.staticweaponsstarttime = gettime();
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x4
// Checksum 0x99f8a1fc, Offset: 0x2358
// Size: 0x40
function private function_e47995c5(equipment_name) {
    if (equipment_name == level.weapontacticalinsertion.name && level.disabletacinsert) {
        return false;
    }
    return true;
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x4
// Checksum 0xb581ecde, Offset: 0x23a0
// Size: 0x2e
function private function_38cb4d89(item) {
    if (level.leaguematch) {
        return isitemrestricted(item);
    }
    return 0;
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x0
// Checksum 0x7d0c335a, Offset: 0x23d8
// Size: 0x56
function init_player(takeallweapons) {
    if (takeallweapons) {
        self takeallweapons();
    }
    self.specialty = [];
    self.killstreak = [];
    self notify(#"give_map");
}

// Namespace loadout/player_loadout
// Params 0, eflags: 0x4
// Checksum 0xea5565ba, Offset: 0x2438
// Size: 0x1c
function private give_gesture() {
    self gestures::clear_gesture();
}

// Namespace loadout/player_loadout
// Params 0, eflags: 0x4
// Checksum 0xaca339c3, Offset: 0x2460
// Size: 0xd4
function private give_talents() {
    pixbeginevent(#"give_talents");
    self.var_45dafde7 = self function_9511d057(self.class_num);
    foreach (var_b0608510 in self.var_45dafde7) {
        self function_748988bc(var_b0608510);
    }
    pixendevent();
}

// Namespace loadout/player_loadout
// Params 0, eflags: 0x0
// Checksum 0xf5052f5f, Offset: 0x2540
// Size: 0x21c
function give_perks() {
    pixbeginevent(#"give_perks");
    self.specialty = self getloadoutperks(self.class_num);
    self setplayerstateloadoutweapons(self.class_num);
    if (level.leaguematch) {
        for (i = 0; i < self.specialty.size; i++) {
            if (function_38cb4d89(self.specialty[i])) {
                arrayremoveindex(self.specialty, i);
                i--;
            }
        }
    }
    self register_perks();
    anteup_bonus = getdvarint(#"perk_killstreakanteupresetvalue", 0);
    momentum_at_spawn_or_game_end = isdefined(self.pers[#"momentum_at_spawn_or_game_end"]) ? self.pers[#"momentum_at_spawn_or_game_end"] : 0;
    var_c95a3982 = !(self.hasdonecombat === 1);
    if (level.inprematchperiod || level.ingraceperiod && var_c95a3982) {
        new_momentum = momentum_at_spawn_or_game_end;
        if (self hasperk(#"specialty_anteup") && momentum_at_spawn_or_game_end < anteup_bonus) {
            new_momentum = anteup_bonus;
        }
        globallogic_score::_setplayermomentum(self, new_momentum, 0);
    }
    pixendevent();
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x0
// Checksum 0x2f087cf5, Offset: 0x2768
// Size: 0x18c
function function_3f1c5df5(weaponclass) {
    self.class_num = get_class_num(weaponclass);
    if (issubstr(weaponclass, "CLASS_CUSTOM")) {
        pixbeginevent(#"custom class");
        self.class_num_for_global_weapons = self.class_num;
        self reset_specialty_slots(self.class_num);
        playerrenderoptions = self calcplayeroptions(self.class_num);
        self setplayerrenderoptions(playerrenderoptions);
        pixendevent();
    } else {
        pixbeginevent(#"default class");
        assert(isdefined(self.pers[#"class"]), "<dev string:xc2>");
        self.class_num_for_global_weapons = 0;
        self setplayerrenderoptions(0);
        pixendevent();
    }
    self recordloadoutindex(self.class_num);
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x0
// Checksum 0x6dc7a008, Offset: 0x2900
// Size: 0x1c8
function get_class_num(weaponclass) {
    assert(isdefined(weaponclass));
    prefixstring = "CLASS_CUSTOM";
    var_658414ab = self getcustomclasscount();
    var_658414ab = max(var_658414ab, 0);
    if (issubstr(weaponclass, prefixstring)) {
        var_80ee8c9a = getsubstr(weaponclass, prefixstring.size);
        class_num = int(var_80ee8c9a) - 1;
        if (class_num == -1) {
            class_num = var_658414ab;
        }
        assert(isdefined(class_num));
        if (class_num < 0 || class_num > var_658414ab) {
            class_num = 0;
        }
        assert(class_num >= 0 && class_num <= var_658414ab);
    } else {
        class_num = level.classtoclassnum[weaponclass];
    }
    if (!isdefined(class_num)) {
        class_num = self stats::get_stat(#"selectedcustomclass");
        if (!isdefined(class_num)) {
            class_num = 0;
        }
    }
    assert(isdefined(class_num));
    return class_num;
}

// Namespace loadout/player_loadout
// Params 0, eflags: 0x4
// Checksum 0x25b8959, Offset: 0x2ad0
// Size: 0x9a
function private function_1c9bac79() {
    self.spawnweapon = level.weaponbasemeleeheld;
    self giveweapon(level.weaponbasemeleeheld);
    self.pers[#"spawnweapon"] = self.spawn_weapon;
    switchimmediate = isdefined(self.alreadysetspawnweapononce);
    self setspawnweapon(self.spawnweapon, switchimmediate);
    self.alreadysetspawnweapononce = 1;
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x4
// Checksum 0x17259381, Offset: 0x2b78
// Size: 0x10
function private function_9349563f(weapon_options) {
    return weapon_options;
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x4
// Checksum 0x7be17bbb, Offset: 0x2b90
// Size: 0x2a
function private get_weapon_options(type_index) {
    return self calcweaponoptions(self.class_num, type_index);
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x4
// Checksum 0xb44fa8, Offset: 0x2bc8
// Size: 0x42
function private function_65ba9408(type_index) {
    weapon_options = self get_weapon_options(type_index);
    return function_9349563f(weapon_options);
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x4
// Checksum 0x6e4f8fe1, Offset: 0x2c18
// Size: 0xe6
function private function_d808275a(slot) {
    weapon = self getloadoutweapon(self.class_num, slot);
    if (weapon.iscarriedkillstreak) {
        weapon = level.weaponnull;
    }
    current_weapon_name = weapon.name;
    if (slot == "primary" || slot == "secondary") {
        var_dff4cda2 = self getweaponoptic(weapon);
    }
    var_d114ede = getdvarint(#"hash_3c3e56404c9ca59c", 0) > 0;
    return weapon;
}

// Namespace loadout/player_loadout
// Params 4, eflags: 0x4
// Checksum 0xbca95f94, Offset: 0x2d08
// Size: 0x160
function private give_weapon(weapon, slot, var_1ed7a28c, var_75017848) {
    if (weapon != level.weaponnull) {
        if (isdefined(var_1ed7a28c)) {
            weapon_options = self [[ var_1ed7a28c ]](var_75017848);
        } else {
            weapon_options = 0;
        }
        self giveweapon(weapon, weapon_options);
        self function_51315abd(slot, weapon);
        if (self hasperk(#"specialty_extraammo")) {
            self givemaxammo(weapon);
        }
        changedspecialist = 0;
        changedspecialist = self.pers[#"changed_specialist"];
        if (weapon.isgadget) {
            self ability_util::gadget_reset(weapon, self.pers[#"changed_class"], !util::isoneround(), util::isfirstround(), changedspecialist);
        }
    }
    return weapon;
}

// Namespace loadout/player_loadout
// Params 4, eflags: 0x4
// Checksum 0x548e78d8, Offset: 0x2e70
// Size: 0x68
function private function_bee2cc4c(var_c991c24b, new_weapon, var_96fef9c3, var_66b9c880) {
    spawn_weapon = var_c991c24b;
    if (new_weapon != level.weaponnull) {
        if (spawn_weapon == level.weaponnull) {
            spawn_weapon = new_weapon;
        }
    }
    return spawn_weapon;
}

// Namespace loadout/player_loadout
// Params 2, eflags: 0x4
// Checksum 0x527b8f21, Offset: 0x2ee0
// Size: 0x98
function private function_5e031a40(previous_weapon, spawn_weapon) {
    if (!self hasmaxprimaryweapons()) {
        if (!isusingt7melee()) {
            self giveweapon(level.weaponbasemeleeheld);
            return self function_bee2cc4c(spawn_weapon, level.weaponbasemeleeheld, previous_weapon, level.weaponbasemeleeheld);
        }
    }
    return spawn_weapon;
}

// Namespace loadout/player_loadout
// Params 0, eflags: 0x4
// Checksum 0xc719ecb, Offset: 0x2f80
// Size: 0x6c
function private function_eb5fe08b() {
    primary_weapon = function_3d8b02a0("primary");
    secondary_weapon = function_3d8b02a0("secondary");
    self bbclasschoice(self.class_num, primary_weapon, secondary_weapon);
}

// Namespace loadout/player_loadout
// Params 5, eflags: 0x4
// Checksum 0xc51d093d, Offset: 0x2ff8
// Size: 0xca
function private function_d1aec399(slot, previous_weapon, var_c991c24b, var_250da3db, var_ff2e2aeb) {
    loadout = self get_loadout_slot(slot);
    var_66b9c880 = loadout.weapon;
    weapon = self function_d808275a(slot);
    self give_weapon(weapon, slot, var_ff2e2aeb, var_250da3db);
    return self function_bee2cc4c(var_c991c24b, weapon, previous_weapon, var_66b9c880);
}

// Namespace loadout/player_loadout
// Params 4, eflags: 0x4
// Checksum 0x940401fd, Offset: 0x30d0
// Size: 0x9a
function private function_6fefd5bf(slot, previous_weapon, var_c991c24b, var_591c4244) {
    var_66b9c880 = self function_3d8b02a0(slot);
    weapon = self function_d808275a(slot);
    self [[ var_591c4244 ]](slot, previous_weapon);
    return self function_bee2cc4c(var_c991c24b, weapon, previous_weapon, var_66b9c880);
}

// Namespace loadout/player_loadout
// Params 3, eflags: 0x4
// Checksum 0x4cef863d, Offset: 0x3178
// Size: 0x8a
function private give_hero_gadget(previous_weapon, var_c991c24b, var_591c4244) {
    var_66b9c880 = self function_3d8b02a0("herogadget");
    weapon = getweapon(self.playerrole.var_4c698c3d);
    self [[ var_591c4244 ]]("herogadget", previous_weapon);
    return var_c991c24b;
}

// Namespace loadout/player_loadout
// Params 3, eflags: 0x4
// Checksum 0x5273e7ed, Offset: 0x3210
// Size: 0xa2
function private function_953a8667(previous_weapon, var_c991c24b, var_591c4244) {
    var_66b9c880 = self function_3d8b02a0("ultimate");
    if (isdefined(self.playerrole.ultimateweapon)) {
        weapon = getweapon(self.playerrole.ultimateweapon);
        self [[ var_591c4244 ]]("ultimate", previous_weapon);
    }
    return var_c991c24b;
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x0
// Checksum 0xea943760, Offset: 0x32c0
// Size: 0x15a
function function_468931fa(spawn_weapon) {
    if (!isdefined(self.spawnweapon) && isdefined(self.pers[#"spawnweapon"])) {
        self.spawnweapon = self.pers[#"spawnweapon"];
    }
    if (isdefined(self.spawnweapon) && doesweaponreplacespawnweapon(self.spawnweapon, spawn_weapon) && !self.pers[#"changed_class"]) {
        spawn_weapon = self.spawnweapon;
    }
    self thread initweaponattachments(spawn_weapon);
    self.pers[#"changed_class"] = 0;
    self.spawnweapon = spawn_weapon;
    self.pers[#"spawn_weapon"] = self.spawnweapon;
    if (spawn_weapon != level.weaponnone) {
        switchimmediate = isdefined(self.alreadysetspawnweapononce);
        self setspawnweapon(spawn_weapon, switchimmediate);
        self.alreadysetspawnweapononce = 1;
    }
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x4
// Checksum 0x242866e6, Offset: 0x3428
// Size: 0x21c
function private give_weapons(previous_weapon) {
    pixbeginevent(#"give_weapons");
    self.primaryloadoutgunsmithvariantindex = self getloadoutgunsmithvariantindex(self.class_num, 0);
    self.secondaryloadoutgunsmithvariantindex = self getloadoutgunsmithvariantindex(self.class_num, 1);
    spawn_weapon = self function_d1aec399("primary", previous_weapon, level.weaponnull, 0, &function_65ba9408);
    spawn_weapon = self function_d1aec399("secondary", previous_weapon, spawn_weapon, 1, &get_weapon_options);
    spawn_weapon = self function_5e031a40(previous_weapon, spawn_weapon);
    spawn_weapon = self function_6fefd5bf("primarygrenade", previous_weapon, spawn_weapon, &function_33fc554c);
    spawn_weapon = self function_6fefd5bf("specialgrenade", previous_weapon, spawn_weapon, &function_d6e27588);
    spawn_weapon = self give_hero_gadget(previous_weapon, spawn_weapon, &give_special_offhand);
    spawn_weapon = self function_953a8667(previous_weapon, spawn_weapon, &give_ultimate);
    self function_468931fa(spawn_weapon);
    self function_2d98422e();
    self function_eb5fe08b();
    pixendevent();
}

// Namespace loadout/player_loadout
// Params 0, eflags: 0x0
// Checksum 0x6a346a89, Offset: 0x3650
// Size: 0x14
function function_2cd7e6c4() {
    function_d7fe55fd();
}

// Namespace loadout/player_loadout
// Params 0, eflags: 0x0
// Checksum 0x828086bd, Offset: 0x3670
// Size: 0x284
function function_d7fe55fd() {
    has_specialty_armor = self hasperk(#"specialty_armor");
    healthtoassign = self.spawnhealth;
    if (isdefined(level.maxspawnhealthboostprct)) {
        self.bonusspawnhealth = int(level.maxspawnhealthboostprct * self.spawnhealth);
        healthtoassign += self.bonusspawnhealth;
    }
    if (isdefined(self.var_a5ed74d2)) {
        healthtoassign = self.var_a5ed74d2;
    }
    self player::function_26fa96fc(healthtoassign);
    self.maxhealth = healthtoassign + (isdefined(level.var_9ef11bf6) ? level.var_9ef11bf6 : 0);
    new_health = self.var_63f2cd6e < 0 ? healthtoassign : self.var_63f2cd6e;
    give_armor = has_specialty_armor && (!isdefined(self.var_bb3cb3b) || self.var_bb3cb3b < gettime());
    armor = give_armor ? self.spawnarmor : 0;
    self.health = new_health;
    self armor::set_armor(armor, armor, self function_a7a85103(#"hash_56055daf9601d89e"), self function_a7a85103(#"hash_e7550a3c852687e"), self function_a7a85103(#"hash_5a20313f9a8825a9"), self function_a7a85103(#"hash_7c24b2a7dce26e8f"));
    self.var_1925b7f2 = self.spawnhealth;
    if (give_armor || isdefined(self.var_bb3cb3b) && self.var_bb3cb3b < gettime()) {
        self.var_bb3cb3b = undefined;
        clientfield::set_player_uimodel("hudItems.armorIsOnCooldown", 0);
    }
    self healthoverlay::restart_player_health_regen();
}

// Namespace loadout/player_loadout
// Params 2, eflags: 0x4
// Checksum 0x69f06af4, Offset: 0x3900
// Size: 0x334
function private function_33fc554c(slot, previous_weapon) {
    pixbeginevent(#"hash_7187aa59ab81d21a");
    changedclass = self.pers[#"changed_class"];
    roundbased = !util::isoneround();
    firstround = util::isfirstround();
    changedspecialist = self.pers[#"changed_specialist"];
    primaryoffhand = level.weaponnone;
    var_b9719c6d = 0;
    primaryoffhandcount = 0;
    primaryoffhandname = self function_568679e3(self.class_num, "primarygrenade");
    if (primaryoffhandname == "default_specialist_equipment" && isdefined(self.playerrole) && isdefined(self.playerrole.primaryequipment)) {
        primaryoffhandname = self.playerrole.primaryequipment;
    }
    if (primaryoffhandname != #"" && primaryoffhandname != #"weapon_null") {
        primaryoffhand = getweapon(primaryoffhandname);
        var_b9719c6d = self getloadoutitem(self.class_num, "primarygrenadecount");
        primaryoffhandcount = var_b9719c6d ? 2 : 1;
    }
    if (function_38cb4d89(primaryoffhand.name) || !function_e47995c5(primaryoffhand.name)) {
        primaryoffhand = level.weaponnone;
        primaryoffhandcount = 0;
    }
    if (primaryoffhand == level.weaponnone) {
        primaryoffhand = level.var_8ec54942;
        primaryoffhandcount = 0;
    }
    if (primaryoffhand != level.weaponnull) {
        self giveweapon(primaryoffhand);
        self setweaponammoclip(primaryoffhand, primaryoffhandcount);
        self switchtooffhand(primaryoffhand);
        loadout = self get_loadout_slot(slot);
        loadout.weapon = primaryoffhand;
        loadout.count = primaryoffhandcount;
        self ability_util::gadget_reset(primaryoffhand, changedclass, roundbased, firstround, changedspecialist);
    }
    pixendevent();
}

// Namespace loadout/player_loadout
// Params 3, eflags: 0x0
// Checksum 0x26ce02cf, Offset: 0x3c40
// Size: 0x464
function function_d6e27588(slot, previous_weapon, force_give_gadget_health_regen = 1) {
    pixbeginevent(#"hash_d790bf4ec8958ba");
    changedclass = self.pers[#"changed_class"];
    roundbased = !util::isoneround();
    firstround = util::isfirstround();
    changedspecialist = self.pers[#"changed_specialist"];
    secondaryoffhand = level.weaponnone;
    secondaryoffhandcount = 0;
    if (getdvarint(#"equipmentasgadgets", 0) == 1) {
        secondaryoffhand = self.playerrole.secondaryequipment;
        secondaryoffhandcount = secondaryoffhand.startammo;
    } else {
        secondaryoffhandname = self function_568679e3(self.class_num, "specialgrenade");
        if (secondaryoffhandname != #"" && secondaryoffhandname != #"weapon_null") {
            secondaryoffhand = getweapon(secondaryoffhandname);
            secondaryoffhandcount = self getloadoutitem(self.class_num, "specialgrenadecount");
        }
    }
    if (function_38cb4d89(secondaryoffhand.name) || !function_e47995c5(secondaryoffhand.name)) {
        secondaryoffhand = level.weaponnone;
        secondaryoffhandcount = 0;
    }
    if (secondaryoffhand == level.weaponnone) {
        secondaryoffhand = level.var_439614d2;
        secondaryoffhandcount = 0;
    }
    var_8301f1c9 = isdefined(getgametypesetting(#"hash_4ca06c610b5d53bd")) ? getgametypesetting(#"hash_4ca06c610b5d53bd") : 0;
    if (force_give_gadget_health_regen === 1 && level.new_health_model && !var_8301f1c9) {
        tactical_gear = self function_5e761013(self.class_num);
        if (#"gear_medicalinjectiongun" == tactical_gear) {
            secondaryoffhand = getweapon(#"gadget_medicalinjectiongun");
        } else {
            secondaryoffhand = getweapon(#"gadget_health_regen");
        }
        secondaryoffhandcount = 0;
    }
    if (secondaryoffhand != level.weaponnull) {
        self giveweapon(secondaryoffhand);
        self setweaponammoclip(secondaryoffhand, secondaryoffhandcount);
        self switchtooffhand(secondaryoffhand);
        loadout = self get_loadout_slot(slot);
        loadout.weapon = secondaryoffhand;
        loadout.count = secondaryoffhandcount;
        if (force_give_gadget_health_regen === 1) {
            self ability_util::function_aa8c40c1(secondaryoffhand);
        } else {
            self ability_util::gadget_reset(secondaryoffhand, changedclass, roundbased, firstround, changedspecialist);
        }
    }
    pixendevent();
}

// Namespace loadout/player_loadout
// Params 2, eflags: 0x4
// Checksum 0x3bb5d951, Offset: 0x40b0
// Size: 0x36c
function private give_special_offhand(slot, previous_weapon) {
    pixbeginevent(#"give_special_offhand");
    changedclass = self.pers[#"changed_class"];
    roundbased = !util::isoneround();
    firstround = util::isfirstround();
    changedspecialist = self.pers[#"changed_specialist"];
    classnum = self.class_num_for_global_weapons;
    specialoffhand = level.weaponnone;
    specialoffhandcount = 0;
    specialoffhand = getweapon(self.playerrole.var_4c698c3d);
    specialoffhandcount = specialoffhand.startammo;
    /#
        if (getdvarstring(#"scr_herogadgetname_debug") != "<dev string:x7f>") {
            herogadgetname = getdvarstring(#"scr_herogadgetname_debug");
            specialoffhand = level.weaponnone;
            if (herogadgetname != "<dev string:xf0>") {
                specialoffhand = getweapon(herogadgetname);
            }
        }
    #/
    if (isdefined(self.pers[#"rouletteweapon"])) {
        assert(specialoffhand.name == "<dev string:xfc>");
        specialoffhand = self.pers[#"rouletteweapon"];
    }
    if (function_38cb4d89(specialoffhand.name) || !function_e47995c5(specialoffhand.name)) {
        specialoffhand = level.weaponnone;
        specialoffhandcount = 0;
    }
    if (specialoffhand == level.weaponnone) {
        specialoffhand = level.var_35aeafd6;
        specialoffhandcount = 0;
    }
    if (specialoffhand != level.weaponnull) {
        self giveweapon(specialoffhand);
        self setweaponammoclip(specialoffhand, specialoffhandcount);
        loadout = self get_loadout_slot("specialgrenade");
        loadout.weapon = specialoffhand;
        loadout.count = specialoffhandcount;
        self ability_util::gadget_reset(specialoffhand, changedclass, roundbased, firstround, changedspecialist);
        self function_51315abd(slot, specialoffhand);
    }
    pixendevent();
}

// Namespace loadout/player_loadout
// Params 2, eflags: 0x4
// Checksum 0xd78adc09, Offset: 0x4428
// Size: 0x2fc
function private give_ultimate(slot, previous_weapon) {
    pixbeginevent(#"give_ultimate");
    changedclass = self.pers[#"changed_class"];
    roundbased = !util::isoneround();
    firstround = util::isfirstround();
    changedspecialist = self.pers[#"changed_specialist"];
    classnum = self.class_num_for_global_weapons;
    ultimate = getweapon(self.playerrole.ultimateweapon);
    var_a7b8497d = ultimate.startammo;
    /#
        if (getdvarstring(#"hash_488ee9aa10c06400") != "<dev string:x7f>") {
            var_bfbb1d99 = getdvarstring(#"hash_488ee9aa10c06400");
            ultimate = level.weaponnone;
            if (var_bfbb1d99 != "<dev string:xf0>") {
                ultimate = getweapon(var_bfbb1d99);
            }
        }
    #/
    if (function_38cb4d89(ultimate.name) || !function_e47995c5(ultimate.name)) {
        ultimate = level.weaponnone;
        var_a7b8497d = 0;
    }
    if (ultimate == level.weaponnone) {
        ultimate = level.var_aac1d977;
        var_a7b8497d = 0;
    }
    if (ultimate != level.weaponnull) {
        self giveweapon(ultimate);
        self setweaponammoclip(ultimate, var_a7b8497d);
        loadout = self get_loadout_slot("ultimate");
        loadout.weapon = ultimate;
        loadout.count = var_a7b8497d;
        self ability_util::gadget_reset(ultimate, changedclass, roundbased, firstround, changedspecialist);
        self function_51315abd(slot, ultimate);
    }
    pixendevent();
}

/#

    // Namespace loadout/player_loadout
    // Params 2, eflags: 0x0
    // Checksum 0xa3b4b872, Offset: 0x4730
    // Size: 0x4e
    function function_d92e1a6d(team, weaponclass) {
        level.var_1709ffcb = 1;
        self give_loadout(team, weaponclass);
        level.var_1709ffcb = undefined;
    }

#/

// Namespace loadout/player_loadout
// Params 2, eflags: 0x0
// Checksum 0xd9e4153e, Offset: 0x4788
// Size: 0x614
function give_loadout(team, weaponclass) {
    self endon(#"death");
    pixbeginevent(#"give_loadout");
    pixbeginevent(#"hash_d8a2ffe71c27024");
    if (function_cd383ec5()) {
        assert(isdefined(self.curclass));
        self function_bc11a936(self.curclass, #"give_loadout");
        var_cfaa8258 = 1;
        /#
            if (level.var_1709ffcb === 1) {
                var_cfaa8258 = 0;
            }
        #/
        if (isdefined(self.var_f8b9d19) && self.var_f8b9d19 >= gettime()) {
            return;
        }
        current_weapon = self getcurrentweapon();
        if (current_weapon == level.weaponnone && isdefined(self.class_num)) {
            current_weapon = self getloadoutweapon(self.class_num, "primary");
        }
        if (isdefined(level.givecustomloadout)) {
            spawn_weapon = self [[ level.givecustomloadout ]]();
            if (isdefined(spawn_weapon)) {
                self thread initweaponattachments(spawn_weapon);
            }
            self.spawnweapon = spawn_weapon;
        } else {
            hero_gadget = self function_3d8b02a0("herogadget");
            self.var_75c78e2e = isdefined(hero_gadget) ? self getweaponammoclip(hero_gadget) : undefined;
            primary_grenade = self function_3d8b02a0("primarygrenade");
            self.var_221bcd1d = undefined;
            if (isdefined(primary_grenade)) {
                slot = self gadgetgetslot(primary_grenade);
                self.var_221bcd1d = self gadgetpowerget(slot);
            }
            self init_player(1);
            function_3f1c5df5(weaponclass);
            self setactionslot(3, "altMode");
            self setactionslot(4, "sprays_boasts");
            allocationspent = self getloadoutallocation(self.class_num);
            overallocation = allocationspent > level.maxallocation;
            if (var_cfaa8258) {
                self function_edf4fd1d();
                give_talents();
            }
            give_perks();
            give_weapons(current_weapon);
            function_d7fe55fd();
            give_gesture();
            give_killstreaks();
            self.attackeraccuracy = self function_8699a05a();
        }
    } else if (isdefined(level.givecustomloadout)) {
        spawn_weapon = self [[ level.givecustomloadout ]]();
        if (isdefined(spawn_weapon)) {
            self thread initweaponattachments(spawn_weapon);
        }
        self.spawnweapon = spawn_weapon;
    }
    self.var_75c78e2e = undefined;
    self.var_221bcd1d = undefined;
    self detachall();
    if (isdefined(self.movementspeedmodifier)) {
        self setmovespeedscale(self.movementspeedmodifier * self getmovespeedscale());
    } else {
        self setmovespeedscale(1);
    }
    self cac_selector();
    specialistindex = self getspecialistindex();
    self.ability_medal_count = isdefined(self.pers["ability_medal_count" + specialistindex]) ? self.pers["ability_medal_count" + specialistindex] : 0;
    self.equipment_medal_count = isdefined(self.pers["equipment_medal_count" + specialistindex]) ? self.pers["equipment_medal_count" + specialistindex] : 0;
    primary_weapon = function_3d8b02a0("primary");
    self function_add7ff5c(self.spawnweapon, primary_weapon);
    self notify(#"loadout_given");
    callback::callback(#"on_loadout");
    self thread function_bf244dd6();
    pixendevent();
}

// Namespace loadout/player_loadout
// Params 0, eflags: 0x4
// Checksum 0xb9e67dc8, Offset: 0x4da8
// Size: 0xac
function private function_bf244dd6() {
    self endon(#"disconnect");
    self notify("159398502b5ce2eb");
    self endon("159398502b5ce2eb");
    waitframe(1);
    self luinotifyevent(#"hash_21e30e91084f7e66", 0);
    wait 0.1;
    self luinotifyevent(#"hash_21e30e91084f7e66", 0);
    wait 0.5;
    self luinotifyevent(#"hash_21e30e91084f7e66", 0);
}

// Namespace loadout/player_loadout
// Params 2, eflags: 0x4
// Checksum 0x9073f553, Offset: 0x4e60
// Size: 0x1a4
function private function_add7ff5c(spawn_weapon, primaryweapon) {
    if (!isdefined(self.firstspawn)) {
        if (isdefined(spawn_weapon)) {
            self initialweaponraise(spawn_weapon);
        } else if (isdefined(primaryweapon)) {
            self initialweaponraise(primaryweapon);
        }
    } else {
        self seteverhadweaponall(1);
    }
    if (isdefined(spawn_weapon)) {
        self function_a9ce8955(spawn_weapon);
    } else if (isdefined(primaryweapon)) {
        self function_a9ce8955(primaryweapon);
    }
    self.firstspawn = 0;
    self.switchedteamsresetgadgets = 0;
    self.var_f8b9d19 = gettime();
    if (isdefined(self.pers[#"changed_specialist"]) && self.pers[#"changed_specialist"]) {
        self notify(#"changed_specialist");
        self callback::callback(#"changed_specialist");
        self.var_a825d3c2 = 1;
    } else {
        self.var_a825d3c2 = 0;
    }
    self.pers[#"changed_specialist"] = 0;
    self flagsys::set(#"loadout_given");
}

// Namespace loadout/player_loadout
// Params 0, eflags: 0x4
// Checksum 0x6b639beb, Offset: 0x5010
// Size: 0xdc
function private on_player_connecting() {
    self.pers[#"loadoutindex"] = 0;
    if (function_cd383ec5()) {
        if (!isdefined(self.pers[#"class"])) {
            self.pers[#"class"] = "";
        }
        self.curclass = self.pers[#"class"];
        self.lastclass = "";
        self function_fbd52c88();
        self function_bc11a936(self.curclass);
    }
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x0
// Checksum 0x96377767, Offset: 0x50f8
// Size: 0x1a
function function_e7e08814(newclass) {
    self.curclass = newclass;
}

// Namespace loadout/player_loadout
// Params 2, eflags: 0x0
// Checksum 0x8999ad92, Offset: 0x5120
// Size: 0x1b4
function function_bc11a936(newclass, calledfrom = #"unspecified") {
    loadoutindex = isdefined(newclass) ? get_class_num(newclass) : undefined;
    self.pers[#"loadoutindex"] = loadoutindex;
    var_8419acbc = calledfrom == #"give_loadout";
    var_59b56604 = 0;
    if (!var_8419acbc) {
        var_59b56604 = isdefined(game) && isdefined(game.state) && game.state == "playing" && isalive(self);
        if (var_59b56604 && self.sessionstate == "playing") {
            var_7e988ad7 = self.usingsupplystation === 1;
            if (isdefined(level.ingraceperiod) && level.ingraceperiod && !(isdefined(self.hasdonecombat) && self.hasdonecombat) || var_7e988ad7) {
                var_59b56604 = 0;
            }
        }
    }
    if (var_59b56604) {
        return;
    }
    self setloadoutindex(loadoutindex);
    self setplayerstateloadoutweapons(loadoutindex);
}

// Namespace loadout/player_loadout
// Params 0, eflags: 0x0
// Checksum 0xc602aafd, Offset: 0x52e0
// Size: 0x126
function init_dvars() {
    level.cac_armorpiercing_data = getdvarint(#"perk_armorpiercing", 40) / 100;
    level.cac_bulletdamage_data = getdvarint(#"perk_bulletdamage", 35);
    level.cac_fireproof_data = getdvarint(#"perk_fireproof", 20);
    level.cac_armorvest_data = getdvarint(#"perk_armorvest", 80);
    level.cac_flakjacket_data = getdvarint(#"perk_flakjacket", 35);
    level.cac_flakjacket_hardcore_data = getdvarint(#"perk_flakjacket_hardcore", 9);
}

// Namespace loadout/player_loadout
// Params 0, eflags: 0x4
// Checksum 0x1940dff2, Offset: 0x5410
// Size: 0x88
function private cac_selector() {
    self.detectexplosives = 0;
    if (isdefined(self.specialty)) {
        perks = self.specialty;
        for (i = 0; i < perks.size; i++) {
            perk = perks[i];
            if (perk == "specialty_detectexplosive") {
                self.detectexplosives = 1;
            }
        }
    }
}

// Namespace loadout/player_loadout
// Params 0, eflags: 0x0
// Checksum 0x39f28185, Offset: 0x54a0
// Size: 0xdc
function register_perks() {
    perks = self.specialty;
    perks::perk_reset_all();
    for (i = 0; i < perks.size; i++) {
        perk = perks[i];
        if (perk == #"specialty_null" || perk == #"weapon_null") {
            continue;
        }
        if (!level.perksenabled) {
            continue;
        }
        self perks::perk_setperk(perk);
    }
    /#
        dev::giveextraperks();
    #/
}

// Namespace loadout/player_loadout
// Params 7, eflags: 0x0
// Checksum 0x4c2fecae, Offset: 0x5588
// Size: 0x6ee
function cac_modified_damage(victim, attacker, damage, mod, weapon, inflictor, hitloc) {
    assert(isdefined(victim));
    assert(isdefined(attacker));
    assert(isplayer(victim));
    attacker_is_player = isplayer(attacker);
    if (damage <= 0) {
        return damage;
    }
    /#
        debug = 0;
        if (getdvarint(#"scr_perkdebug", 0)) {
            debug = 1;
            if (!isdefined(attacker.name)) {
                attacker.name = "<dev string:x10c>";
            }
        }
    #/
    final_damage = damage;
    if (victim != attacker) {
        var_ce2df41f = 1;
        if (attacker_is_player && attacker hasperk(#"specialty_bulletdamage") && isprimarydamage(mod)) {
            if (victim hasperk(#"specialty_armorvest") && !function_13ece01e(hitloc)) {
                /#
                    if (debug) {
                        println("<dev string:x114>" + victim.name + "<dev string:x11c>" + attacker.name + "<dev string:x130>");
                    }
                #/
            } else {
                final_damage = damage * (100 + level.cac_bulletdamage_data) / 100;
                /#
                    if (debug) {
                        println("<dev string:x114>" + attacker.name + "<dev string:x14b>" + victim.name);
                    }
                #/
            }
        } else if (victim hasperk(#"specialty_armorvest") && isprimarydamage(mod) && !function_13ece01e(hitloc)) {
            final_damage = damage * level.cac_armorvest_data * 0.01;
            /#
                if (debug) {
                    println("<dev string:x114>" + attacker.name + "<dev string:x171>" + victim.name);
                }
            #/
        } else if (victim hasperk(#"specialty_fireproof") && weapon_utils::isfiredamage(weapon, mod)) {
            final_damage = damage * level.cac_fireproof_data * 0.01;
            /#
                if (debug) {
                    println("<dev string:x114>" + attacker.name + "<dev string:x196>" + victim.name);
                }
            #/
        } else if (!var_ce2df41f && victim hasperk(#"specialty_flakjacket") && weapon_utils::isexplosivedamage(mod) && !weapon.ignoresflakjacket && !victim grenade_stuck(inflictor)) {
            cac_data = level.hardcoremode ? level.cac_flakjacket_hardcore_data : level.cac_flakjacket_data;
            if (victim util::has_flak_jacket_perk_purchased_and_equipped()) {
                if (level.teambased && attacker.team != victim.team) {
                    victim thread challenges::flakjacketprotectedmp(weapon, attacker);
                } else if (attacker != victim) {
                    victim thread challenges::flakjacketprotectedmp(weapon, attacker);
                }
            }
            final_damage = int(damage * cac_data / 100);
            /#
                if (debug) {
                    println("<dev string:x114>" + victim.name + "<dev string:x1b4>" + attacker.name + "<dev string:x1ce>");
                }
            #/
        }
    }
    /#
        victim.cac_debug_damage_type = tolower(mod);
        victim.cac_debug_original_damage = damage;
        victim.cac_debug_final_damage = final_damage;
        victim.cac_debug_location = tolower(hitloc);
        victim.cac_debug_weapon = weapon.displayname;
        victim.cac_debug_range = int(distance(attacker.origin, victim.origin));
        if (debug) {
            println("<dev string:x1e0>" + final_damage / damage + "<dev string:x1f7>" + damage + "<dev string:x207>" + final_damage);
        }
    #/
    final_damage = int(final_damage);
    if (final_damage < 1) {
        final_damage = 1;
    }
    return final_damage;
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x4
// Checksum 0xbf489fd4, Offset: 0x5c80
// Size: 0x3e
function private function_13ece01e(hitloc) {
    return hitloc == "helmet" || hitloc == "head" || hitloc == "neck";
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x4
// Checksum 0x5bd42d1c, Offset: 0x5cc8
// Size: 0x38
function private grenade_stuck(inflictor) {
    return isdefined(inflictor) && isdefined(inflictor.stucktoplayer) && inflictor.stucktoplayer == self;
}

