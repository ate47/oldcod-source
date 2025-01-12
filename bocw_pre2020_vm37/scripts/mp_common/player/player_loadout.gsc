#using scripts\abilities\ability_player;
#using scripts\abilities\ability_util;
#using scripts\abilities\gadgets\gadget_health_regen;
#using scripts\core_common\armor;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\dev_shared;
#using scripts\core_common\flag_shared;
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
#using scripts\mp_common\challenges;
#using scripts\mp_common\gametypes\dev;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_utils;
#using scripts\mp_common\teams\teams;
#using scripts\weapons\weapon_utils;

#namespace loadout;

// Namespace loadout/player_loadout
// Params 0, eflags: 0x2
// Checksum 0xabb51a1, Offset: 0x5a0
// Size: 0x2b0
function autoexec function_313e9d31() {
    callback::on_start_gametype(&function_dd840c5f);
    level.specialisthealingenabled = getgametypesetting(#"specialisthealingenabled_allies_1");
    level.specialistabilityenabled = getgametypesetting(#"specialistabilityenabled_allies_1");
    level.specialistequipmentenabled = getgametypesetting(#"specialistequipmentenabled_allies_1");
    level.var_50e97365 = getgametypesetting(#"hash_7684a70eb68f1ebb");
    level.specialistabilityreadyonrespawn = getgametypesetting(#"specialistabilityreadyonrespawn_allies_1");
    level.specialistequipmentreadyonrespawn = getgametypesetting(#"specialistequipmentreadyonrespawn_allies_1");
    level.playerloadoutrestrictions = [];
    level.playerloadoutrestrictions[0] = getscriptbundle(#"plr_mp_default");
    if (is_true(getgametypesetting(#"scorestreaksbarebones"))) {
        level.scorestreaksbarebones = [];
        level.scorestreaksbarebones[0] = 126;
        level.scorestreaksbarebones[1] = 130;
        level.scorestreaksbarebones[2] = 134;
    }
    wildcardtable = getscriptbundle(#"wildcardtable");
    foreach (wildcard in wildcardtable.wildcardtable) {
        var_43645456 = wildcard.playerloadoutrestrictions;
        playerloadoutrestrictions = getscriptbundle(var_43645456);
        level.playerloadoutrestrictions[playerloadoutrestrictions.var_9bb0ceab] = playerloadoutrestrictions;
    }
}

// Namespace loadout/player_loadout
// Params 0, eflags: 0x1 linked
// Checksum 0xd5aea646, Offset: 0x858
// Size: 0x1e
function function_dd840c5f() {
    profilestart();
    mp_init();
    profilestop();
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x1 linked
// Checksum 0x4aa43047, Offset: 0x880
// Size: 0x594
function function_9f888e75(*weapons_table) {
    level.weapon_sig_minigun = getweapon(#"sig_minigun");
    level.weapon_hero_annihilator = getweapon(#"hero_annihilator");
    level.weaponbasemeleeheld = getweapon(#"bare_hands");
    level.weaponknifeloadout = getweapon(#"knife_loadout");
    level.weaponmeleeclub = getweapon(#"melee_club_t8");
    level.weaponmeleecoinbag = getweapon(#"melee_coinbag_t8");
    level.weaponmeleecutlass = getweapon(#"melee_cutlass_t8");
    level.weaponmeleedemohammer = getweapon(#"melee_demohammer_t8");
    level.weaponmeleesecretsanta = getweapon(#"melee_secretsanta_t8");
    level.weaponmeleeslaybell = getweapon(#"melee_slaybell_t8");
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
    level.meleeweapons[level.meleeweapons.size] = level.weaponmeleeclub;
    if (!isdefined(level.meleeweapons)) {
        level.meleeweapons = [];
    } else if (!isarray(level.meleeweapons)) {
        level.meleeweapons = array(level.meleeweapons);
    }
    level.meleeweapons[level.meleeweapons.size] = level.weaponmeleecoinbag;
    if (!isdefined(level.meleeweapons)) {
        level.meleeweapons = [];
    } else if (!isarray(level.meleeweapons)) {
        level.meleeweapons = array(level.meleeweapons);
    }
    level.meleeweapons[level.meleeweapons.size] = level.weaponmeleecutlass;
    if (!isdefined(level.meleeweapons)) {
        level.meleeweapons = [];
    } else if (!isarray(level.meleeweapons)) {
        level.meleeweapons = array(level.meleeweapons);
    }
    level.meleeweapons[level.meleeweapons.size] = level.weaponmeleedemohammer;
    if (!isdefined(level.meleeweapons)) {
        level.meleeweapons = [];
    } else if (!isarray(level.meleeweapons)) {
        level.meleeweapons = array(level.meleeweapons);
    }
    level.meleeweapons[level.meleeweapons.size] = level.weaponmeleesecretsanta;
    if (!isdefined(level.meleeweapons)) {
        level.meleeweapons = [];
    } else if (!isarray(level.meleeweapons)) {
        level.meleeweapons = array(level.meleeweapons);
    }
    level.meleeweapons[level.meleeweapons.size] = level.weaponmeleeslaybell;
    level.weaponshotgunenergy = getweapon(#"shotgun_energy");
    level.weaponpistolenergy = getweapon(#"pistol_energy");
    level.var_c1954e36 = getweapon(#"ac130_chaingun");
}

// Namespace loadout/player_loadout
// Params 0, eflags: 0x1 linked
// Checksum 0xa2d9b5, Offset: 0xe20
// Size: 0x3a4
function function_5be71695() {
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
    level.classmap[#"custom12"] = "CLASS_CUSTOM_BONUS1";
    level.classmap[#"custom13"] = "CLASS_CUSTOM_BONUS2";
    level.classmap[#"custom14"] = level.classmap[#"class_smg"];
    level.classmap[#"custom15"] = level.classmap[#"class_cqb"];
    level.classmap[#"custom16"] = level.classmap[#"class_assault"];
    level.classmap[#"custom17"] = level.classmap[#"class_lmg"];
    level.classmap[#"hash_1343c17502a7844f"] = level.classmap[#"class_sniper"];
    level.classmap[#"hash_1343c07502a7829c"] = level.classmap[#"class_specialized"];
}

// Namespace loadout/player_loadout
// Params 0, eflags: 0x1 linked
// Checksum 0x9577c7bb, Offset: 0x11d0
// Size: 0x14c
function function_5f206535() {
    if (!function_87bcb1b()) {
        return;
    }
    function_5be71695();
    level.defaultclass = "CLASS_CUSTOM1";
    create_class_exclusion_list();
    function_445ac5cc("CLASS_CUSTOM_BONUS1", 12);
    function_445ac5cc("CLASS_CUSTOM_BONUS2", 13);
    load_default_loadout("CLASS_SMG", 14);
    load_default_loadout("CLASS_CQB", 15);
    load_default_loadout("CLASS_ASSAULT", 16);
    load_default_loadout("CLASS_LMG", 17);
    load_default_loadout("CLASS_SNIPER", 18);
    load_default_loadout("CLASS_SPECIALIZED", 19);
}

// Namespace loadout/player_loadout
// Params 0, eflags: 0x1 linked
// Checksum 0xd9142880, Offset: 0x1328
// Size: 0x164
function mp_init() {
    level.maxkillstreaks = 4;
    level.maxspecialties = 6;
    level.maxallocation = getgametypesetting(#"maxallocation");
    level.loadoutkillstreaksenabled = getgametypesetting(#"loadoutkillstreaksenabled");
    level.var_a1c77c9c = &give_loadout;
    level.prestigenumber = 5;
    function_6bc4927f();
    level thread function_8624b793();
    function_9f888e75();
    function_5f206535();
    callback::on_connecting(&on_player_connecting);
    if (is_false(level.specialisthealingenabled) && !sessionmodeiswarzonegame()) {
        ability_player::register_gadget_activation_callbacks(23, undefined, &offhealthregen);
    }
}

// Namespace loadout/player_loadout
// Params 0, eflags: 0x5 linked
// Checksum 0x2f7e1f97, Offset: 0x1498
// Size: 0xf8
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
// Checksum 0x1284253a, Offset: 0x1598
// Size: 0x5e
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
// Params 2, eflags: 0x5 linked
// Checksum 0x5031869c, Offset: 0x1600
// Size: 0x24
function private function_445ac5cc(weaponclass, classnum) {
    level.var_f9f569c2[weaponclass] = classnum;
}

// Namespace loadout/player_loadout
// Params 2, eflags: 0x5 linked
// Checksum 0x23d1fc1e, Offset: 0x1630
// Size: 0x34
function private load_default_loadout(weaponclass, classnum) {
    level.classtoclassnum[weaponclass] = classnum;
    level.var_8e1db8ee[classnum] = weaponclass;
}

// Namespace loadout/player_loadout
// Params 2, eflags: 0x5 linked
// Checksum 0xa1df9a16, Offset: 0x1670
// Size: 0x174
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
    assert(0, "<dev string:x38>" + weapon_type + "<dev string:x7c>" + weaponname);
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x4
// Checksum 0x606e464c, Offset: 0x17f0
// Size: 0x3c
function private heavy_weapon_register_dialog(weapon) {
    readyvo = weapon.name + "_ready";
    game.dialog[readyvo] = readyvo;
}

// Namespace loadout/player_loadout
// Params 0, eflags: 0x5 linked
// Checksum 0xa1cdff32, Offset: 0x1838
// Size: 0x304
function private function_6bc4927f() {
    level.meleeweapons = [];
    level.primary_weapon_array = [];
    level.side_arm_array = [];
    level.grenade_array = [];
    level.inventory_array = [];
    level.perkicons = [];
    level.perkspecialties = [];
    level.killstreakicons = [];
    level.killstreakindices = [];
    level.killstreakdeathpenaltyindividualearn = [];
    level.var_b29e45cf = [];
    level.var_b3c95dd8 = [];
    for (i = 0; i < 1024; i++) {
        iteminfo = getunlockableiteminfofromindex(i, 0);
        if (isdefined(iteminfo)) {
            group_s = iteminfo.itemgroupname;
            reference_s = iteminfo.name;
            var_da0b29d2 = iteminfo.namehash;
            display_name_s = iteminfo.displayname;
            if (issubstr(group_s, "weapon_") || group_s == "hero") {
                if (group_s != "" && var_da0b29d2 != "") {
                    weapon_class_register(var_da0b29d2, group_s);
                }
                continue;
            }
            if (group_s == "specialty") {
                level.perkspecialties[display_name_s] = reference_s;
                continue;
            }
            if (group_s == "killstreak") {
                level.tbl_killstreakdata[i] = var_da0b29d2;
                level.killstreakindices[var_da0b29d2] = i;
                if (isdefined(iteminfo.killstreakdeathpenaltyindividualearn)) {
                    level.killstreakdeathpenaltyindividualearn[var_da0b29d2] = iteminfo.killstreakdeathpenaltyindividualearn / 100;
                    assert(level.killstreakdeathpenaltyindividualearn[var_da0b29d2] <= 1);
                }
                if (isdefined(iteminfo.var_b29e45cf)) {
                    level.var_b29e45cf[var_da0b29d2] = iteminfo.var_b29e45cf;
                    assert(level.var_b29e45cf[var_da0b29d2] > 0);
                }
                if (isdefined(iteminfo.var_b3c95dd8)) {
                    level.var_b3c95dd8[var_da0b29d2] = iteminfo.var_b3c95dd8;
                    assert(level.var_b3c95dd8[var_da0b29d2] > 0);
                }
            }
        }
    }
}

// Namespace loadout/player_loadout
// Params 0, eflags: 0x5 linked
// Checksum 0xb94dae2c, Offset: 0x1b48
// Size: 0x184
function private function_8624b793() {
    /#
        wait 0.5;
        for (i = 0; i < 1024; i++) {
            iteminfo = getunlockableiteminfofromindex(i, 0);
            if (!isdefined(iteminfo)) {
                continue;
            }
            reference_s = iteminfo.name;
            if (reference_s == "<dev string:x8d>") {
                continue;
            }
            group_s = iteminfo.itemgroupname;
            display_name_s = iteminfo.displayname;
            if (group_s == "<dev string:x91>") {
                dev::add_perk_devgui(display_name_s, reference_s);
                continue;
            }
            if (group_s == "<dev string:x9e>") {
                if (strstartswith(iteminfo.name, "<dev string:xa8>")) {
                    dev::function_8263c0d5(reference_s, "<dev string:xb3>");
                    continue;
                }
                postfix = "<dev string:xba>" + sessionmodeabbreviation();
                dev::function_373068ca(reference_s, postfix);
            }
        }
    #/
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x1 linked
// Checksum 0xe9bfb8eb, Offset: 0x1cd8
// Size: 0x44
function function_97d216fa(response) {
    assert(isdefined(level.classmap[response]));
    return level.classmap[response];
}

// Namespace loadout/player_loadout
// Params 2, eflags: 0x5 linked
// Checksum 0xc32bdd61, Offset: 0x1d28
// Size: 0x12c
function private function_f8157311(weaponclass, killstreaknum) {
    killstreaknum++;
    killstreakstring = "killstreak" + killstreaknum;
    /#
        if (getdvarint("<dev string:xbf>" + killstreakstring, 0) > 0) {
            return getdvarint("<dev string:xbf>" + killstreakstring, 0);
        }
    #/
    if (getdvarint(#"custom_killstreak_mode", 0) == 2) {
        return getdvarint("custom_" + killstreakstring, 0);
    }
    if (isdefined(level.scorestreaksbarebones) && isdefined(level.scorestreaksbarebones[killstreaknum - 1])) {
        return level.scorestreaksbarebones[killstreaknum - 1];
    }
    return self getloadoutitem(weaponclass, killstreakstring);
}

// Namespace loadout/player_loadout
// Params 0, eflags: 0x1 linked
// Checksum 0x7b17360f, Offset: 0x1e60
// Size: 0x136
function clear_killstreaks() {
    player = self;
    if (isdefined(player.killstreak)) {
        foreach (killstreak in player.killstreak) {
            killstreaktype = killstreaks::get_by_menu_name(killstreak);
            if (isdefined(killstreaktype)) {
                killstreakweapon = killstreaks::get_killstreak_weapon(killstreaktype);
                player takeweapon(killstreakweapon);
            }
        }
        for (i = 0; i < level.maxkillstreaks; i++) {
            player function_b181bcbd(i);
        }
    }
    player.killstreak = [];
}

// Namespace loadout/player_loadout
// Params 0, eflags: 0x1 linked
// Checksum 0x295ba433, Offset: 0x1fa0
// Size: 0x194
function give_killstreaks() {
    self clear_killstreaks();
    if (!level.loadoutkillstreaksenabled || level.var_bc4f0fc1 === 1) {
        return;
    }
    classnum = self.class_num_for_global_weapons;
    sortedkillstreaks = [];
    for (killstreaknum = 0; killstreaknum < level.maxkillstreaks; killstreaknum++) {
        killstreakindex = function_f8157311(classnum, killstreaknum);
        if (isdefined(killstreakindex) && killstreakindex > 0) {
            give_killstreak(killstreakindex, sortedkillstreaks);
        }
    }
    var_2e1bd530 = [];
    var_2e1bd530[0] = 3;
    var_2e1bd530[1] = 1;
    var_2e1bd530[2] = 0;
    if (level.usingmomentum === 1) {
        for (sortindex = 0; sortindex < sortedkillstreaks.size && sortindex < var_2e1bd530.size; sortindex++) {
            if (sortedkillstreaks[sortindex].weapon != level.weaponnone) {
                self function_d9b9c4c6(var_2e1bd530[sortindex], sortedkillstreaks[sortindex].weapon);
            }
        }
    }
}

// Namespace loadout/player_loadout
// Params 2, eflags: 0x1 linked
// Checksum 0x253f663a, Offset: 0x2140
// Size: 0x386
function give_killstreak(var_523d9b33, &var_58335e4f) {
    assert(isdefined(level.tbl_killstreakdata[var_523d9b33]), "<dev string:xc7>" + var_523d9b33 + "<dev string:xd8>");
    if (isdefined(level.tbl_killstreakdata[var_523d9b33])) {
        if (isitemrestricted(level.tbl_killstreakdata[var_523d9b33])) {
            return;
        }
        self.killstreak[self.killstreak.size] = level.tbl_killstreakdata[var_523d9b33];
        if (level.usingmomentum === 1) {
            killstreaktype = killstreaks::get_by_menu_name(self.killstreak[self.killstreak.size - 1]);
            if (isdefined(killstreaktype)) {
                weapon = killstreaks::get_killstreak_weapon(killstreaktype);
                self giveweapon(weapon);
                if (level.usingscorestreaks === 1) {
                    if (weapon.iscarriedkillstreak) {
                        if (!isdefined(self.pers[#"held_killstreak_ammo_count"][weapon])) {
                            self.pers[#"held_killstreak_ammo_count"][weapon] = 0;
                        }
                        if (!isdefined(self.pers[#"held_killstreak_clip_count"][weapon])) {
                            self.pers[#"held_killstreak_clip_count"][weapon] = 0;
                        }
                        if (self.pers[#"held_killstreak_ammo_count"][weapon] > 0) {
                            self killstreaks::function_fa6e0467(weapon);
                        } else {
                            self function_3ba6ee5d(weapon, 0);
                        }
                    } else {
                        self setweaponammoclip(weapon, isdefined(self.pers[#"killstreak_quantity"][weapon]) ? self.pers[#"killstreak_quantity"][weapon] : 0);
                    }
                }
                sortdata = spawnstruct();
                sortdata.cost = self function_dceb5542(level.killstreaks[killstreaktype].itemindex);
                sortdata.weapon = weapon;
                sortindex = 0;
                for (sortindex = 0; sortindex < var_58335e4f.size; sortindex++) {
                    if (var_58335e4f[sortindex].cost > sortdata.cost) {
                        break;
                    }
                }
                for (i = var_58335e4f.size; i > sortindex; i--) {
                    var_58335e4f[i] = var_58335e4f[i - 1];
                }
                var_58335e4f[sortindex] = sortdata;
            }
        }
    }
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x5 linked
// Checksum 0x6a1a53c9, Offset: 0x24d0
// Size: 0x16
function private reset_specialty_slots(*class_num) {
    self.specialty = [];
}

// Namespace loadout/player_loadout
// Params 0, eflags: 0x1 linked
// Checksum 0x1e148f3c, Offset: 0x24f0
// Size: 0xe
function function_da96d067() {
    self.staticweaponsstarttime = gettime();
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x5 linked
// Checksum 0x6a1231b1, Offset: 0x2508
// Size: 0x3e
function private function_50797a7f(equipment_name) {
    if (level.disabletacinsert && equipment_name === level.weapontacticalinsertion.name) {
        return false;
    }
    return true;
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x1 linked
// Checksum 0x23c2fff6, Offset: 0x2550
// Size: 0x5e
function init_player(takeallweapons) {
    if (takeallweapons) {
        self takeallweapons();
    }
    self.specialty = [];
    self clear_killstreaks();
    self notify(#"give_map");
}

// Namespace loadout/player_loadout
// Params 0, eflags: 0x5 linked
// Checksum 0xa45f8313, Offset: 0x25b8
// Size: 0x1c
function private give_gesture() {
    self gestures::clear_gesture();
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x5 linked
// Checksum 0xca56c999, Offset: 0x25e0
// Size: 0xd6
function private function_c84c77d8(loadoutslot) {
    switch (loadoutslot) {
    case 41:
        self.playerloadoutrestrictions.var_a2ef45f8--;
        if (self.playerloadoutrestrictions.var_a2ef45f8 < 0) {
            return false;
        }
        break;
    case 42:
        self.playerloadoutrestrictions.var_cd3db98c--;
        if (self.playerloadoutrestrictions.var_cd3db98c < 0) {
            return false;
        }
        break;
    case 43:
        self.playerloadoutrestrictions.var_25a22f4--;
        if (self.playerloadoutrestrictions.var_25a22f4 < 0) {
            return false;
        }
        break;
    }
    return true;
}

// Namespace loadout/player_loadout
// Params 0, eflags: 0x1 linked
// Checksum 0x14d4a1c3, Offset: 0x26c0
// Size: 0x2dc
function give_talents() {
    pixbeginevent(#"give_talents");
    self.var_c8836f02 = self function_fd62a2aa(self.class_num);
    foreach (var_ebdddedf in self.var_c8836f02) {
        if (var_ebdddedf.namehash == #"hash_6be738527a4213aa" && level.hardcoremode) {
            var_ebdddedf.namehash = #"hash_5c9c79c25b74b7bb";
        }
        var_b3ed76f5 = function_c84c77d8(var_ebdddedf.loadoutslot);
        if (var_b3ed76f5 && !self function_6c32d092(var_ebdddedf.namehash)) {
            self function_b5feff95(var_ebdddedf.namehash);
        }
    }
    var_621c7d1e = 0;
    wildcards = self function_6f2c0492(self.class_num);
    if (isdefined(wildcards) && wildcards.size > 0) {
        foreach (var_9bb0ceab in wildcards) {
            if (var_9bb0ceab === #"hash_4a12859000892dda") {
                var_621c7d1e = 1;
            }
        }
    }
    if (var_621c7d1e) {
        self function_b5feff95(#"hash_25c2dcf9ec4c42e2");
        if (self function_b958b70d(self.class_num, "secondarygrenade") == #"hash_364914e1708cb629") {
            self function_b5feff95(#"hash_1ef9a210c389803a");
        }
    }
    pixendevent();
}

// Namespace loadout/player_loadout
// Params 0, eflags: 0x1 linked
// Checksum 0xbf833ace, Offset: 0x29a8
// Size: 0x15c
function give_perks() {
    pixbeginevent(#"give_perks");
    self.specialty = self getloadoutperks(self.class_num);
    self setplayerstateloadoutweapons(self.class_num);
    self setplayerstateloadoutbonuscards(self.class_num);
    if (level.leaguematch) {
        for (i = 0; i < self.specialty.size; i++) {
            if (isitemrestricted(self.specialty[i])) {
                arrayremoveindex(self.specialty, i);
                i--;
            }
        }
    }
    self register_perks();
    if (self hasperk(#"specialty_immunenvthermal")) {
        self clientfield::set("cold_blooded", 1);
    }
    pixendevent();
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x1 linked
// Checksum 0x39d81808, Offset: 0x2b10
// Size: 0x13c
function function_f436358b(weaponclass) {
    self.class_num = function_6972fdbb(weaponclass);
    if (issubstr(weaponclass, "CLASS_CUSTOM")) {
        pixbeginevent(#"custom class");
        self.class_num_for_global_weapons = self.class_num;
        self reset_specialty_slots(self.class_num);
        pixendevent();
    } else {
        pixbeginevent(#"default class");
        assert(isdefined(self.pers[#"class"]), "<dev string:xf0>");
        self.class_num_for_global_weapons = 0;
        pixendevent();
    }
    self recordloadoutindex(self.class_num);
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x1 linked
// Checksum 0x3850f1cd, Offset: 0x2c58
// Size: 0x228
function function_6972fdbb(weaponclass) {
    assert(isdefined(weaponclass));
    prefixstring = "CLASS_CUSTOM";
    var_8bba14bc = self getcustomclasscount();
    var_8bba14bc = max(var_8bba14bc, 0);
    if (isstring(weaponclass) && issubstr(weaponclass, "CLASS_CUSTOM_BONUS")) {
        class_num = level.var_f9f569c2[weaponclass];
    } else if (isstring(weaponclass) && issubstr(weaponclass, prefixstring)) {
        var_3858e4e = getsubstr(weaponclass, prefixstring.size);
        class_num = int(var_3858e4e) - 1;
        if (class_num == -1) {
            class_num = var_8bba14bc;
        }
        assert(isdefined(class_num));
        if (class_num < 0 || class_num > var_8bba14bc) {
            class_num = 0;
        }
        assert(class_num >= 0 && class_num <= var_8bba14bc);
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
// Checksum 0x8889eae4, Offset: 0x2e88
// Size: 0x92
function private function_d81e599e() {
    self.spawnweapon = level.weaponbasemeleeheld;
    self giveweapon(level.weaponbasemeleeheld);
    self.pers[#"spawnweapon"] = self.spawn_weapon;
    switchimmediate = isdefined(self.alreadysetspawnweapononce);
    self setspawnweapon(self.spawnweapon, switchimmediate);
    self.alreadysetspawnweapononce = 1;
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x5 linked
// Checksum 0x75c6928b, Offset: 0x2f28
// Size: 0x10
function private function_6bc6995e(weapon_options) {
    return weapon_options;
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x5 linked
// Checksum 0xd97f5523, Offset: 0x2f40
// Size: 0x2a
function private get_weapon_options(type_index) {
    return self function_6eff28b5(self.class_num, type_index);
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x5 linked
// Checksum 0xb75979d2, Offset: 0x2f78
// Size: 0x42
function private function_f4042786(type_index) {
    weapon_options = self get_weapon_options(type_index);
    return function_6bc6995e(weapon_options);
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x5 linked
// Checksum 0xd08985af, Offset: 0x2fc8
// Size: 0xaa
function private function_2ada6938(slot) {
    weapon = self getloadoutweapon(self.class_num, slot);
    if (weapon.iscarriedkillstreak) {
        weapon = level.weaponnull;
    }
    var_348d3044 = weapon.name;
    if (slot == "primary" || slot == "secondary") {
        var_4d371861 = self getweaponoptic(weapon);
    }
    return weapon;
}

// Namespace loadout/player_loadout
// Params 4, eflags: 0x5 linked
// Checksum 0x3e7480c8, Offset: 0x3080
// Size: 0x260
function private give_weapon(weapon, slot, var_a6a8156, var_bc218695) {
    pixbeginevent(#"give_weapon");
    if (weapon != level.weaponnull) {
        if (isdefined(var_a6a8156)) {
            weapon_options = self [[ var_a6a8156 ]](var_bc218695);
        } else {
            weapon_options = 0;
        }
        self giveweapon(weapon, weapon_options);
        self function_442539(slot, weapon);
        if (self hasperk(#"specialty_extraammo") || self function_db654c9(self.class_num, #"hash_4a12859000892dda")) {
            self givemaxammo(weapon);
        }
        changedspecialist = self.pers[#"changed_specialist"];
        if (weapon.isgadget) {
            self ability_util::gadget_reset(weapon, self.pers[#"changed_class"], !util::isoneround(), util::isfirstround(), changedspecialist);
        }
        charmindex = self function_9b237966(self.class_num, "primary" == slot);
        if (charmindex >= 0) {
            self function_3fb8b14(weapon, charmindex);
        }
        deathfxindex = self function_73182cb6(self.class_num, "primary" == slot);
        if (deathfxindex >= 0) {
            self function_a85d2581(weapon, deathfxindex);
        }
    }
    pixendevent();
    return weapon;
}

// Namespace loadout/player_loadout
// Params 4, eflags: 0x5 linked
// Checksum 0xf2ba52bd, Offset: 0x32e8
// Size: 0x68
function private function_d35292b6(var_c41b864, new_weapon, *var_9691c281, *var_8feec653) {
    spawn_weapon = var_9691c281;
    if (var_8feec653 != level.weaponnull) {
        if (spawn_weapon == level.weaponnull) {
            spawn_weapon = var_8feec653;
        }
    }
    return spawn_weapon;
}

// Namespace loadout/player_loadout
// Params 2, eflags: 0x5 linked
// Checksum 0x773024a5, Offset: 0x3358
// Size: 0x98
function private function_286ee0b6(previous_weapon, spawn_weapon) {
    if (!self hasmaxprimaryweapons()) {
        if (!isusingt7melee()) {
            self giveweapon(level.weaponbasemeleeheld);
            return self function_d35292b6(spawn_weapon, level.weaponbasemeleeheld, previous_weapon, level.weaponbasemeleeheld);
        }
    }
    return spawn_weapon;
}

// Namespace loadout/player_loadout
// Params 0, eflags: 0x5 linked
// Checksum 0x1e85e8ad, Offset: 0x33f8
// Size: 0x6c
function private function_ee9b8d55() {
    primary_weapon = function_18a77b37("primary");
    secondary_weapon = function_18a77b37("secondary");
    self bbclasschoice(self.class_num, primary_weapon, secondary_weapon);
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x5 linked
// Checksum 0xb9687951, Offset: 0x3470
// Size: 0xdc
function private function_d9035e42(weapon) {
    itemindex = getbaseweaponitemindex(weapon);
    iteminfo = getunlockableiteminfofromindex(itemindex, 1);
    if (iteminfo.loadoutslotname === "primary") {
        self.playerloadoutrestrictions.numprimaryweapons--;
        if (self.playerloadoutrestrictions.numprimaryweapons < 0) {
            return false;
        }
    } else if (iteminfo.loadoutslotname === "secondary") {
        self.playerloadoutrestrictions.var_ab1984e9--;
        if (self.playerloadoutrestrictions.var_ab1984e9 < 0) {
            return false;
        }
    }
    return true;
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x5 linked
// Checksum 0xb9e9a2d5, Offset: 0x3558
// Size: 0x98
function private function_ad874c55(weapon) {
    foreach (attachment in weapon.attachments) {
        if (attachment === "custom2") {
            return true;
        }
    }
    return false;
}

// Namespace loadout/player_loadout
// Params 2, eflags: 0x5 linked
// Checksum 0x7c8b663c, Offset: 0x35f8
// Size: 0x15c
function private function_3aa744b9(slot, weapon) {
    num_attachments = weapon.attachments.size;
    if (function_ad874c55(weapon)) {
        num_attachments--;
    }
    if (slot === "primary") {
        self.playerloadoutrestrictions.var_355c3581 -= num_attachments;
        if (self.playerloadoutrestrictions.var_355c3581 < 0) {
            return false;
        }
        if (weapon.isdualwield) {
            self.playerloadoutrestrictions.var_882b6b71--;
            if (self.playerloadoutrestrictions.var_882b6b71 < 0) {
                return false;
            }
        }
    } else if (slot === "secondary") {
        self.playerloadoutrestrictions.var_934131b6 -= num_attachments;
        if (self.playerloadoutrestrictions.var_934131b6 < 0) {
            return false;
        }
        if (weapon.isdualwield) {
            self.playerloadoutrestrictions.var_c3fc8c73--;
            if (self.playerloadoutrestrictions.var_c3fc8c73 < 0) {
                return false;
            }
        }
    }
    return true;
}

// Namespace loadout/player_loadout
// Params 2, eflags: 0x5 linked
// Checksum 0x7a9ecefb, Offset: 0x3760
// Size: 0x15a
function private function_d126318c(slot, weapon) {
    var_b5bd8bd9 = 0;
    if (slot === "primary") {
        var_b5bd8bd9 = self.playerloadoutrestrictions.var_355c3581;
    } else if (slot === "secondary") {
        var_b5bd8bd9 = self.playerloadoutrestrictions.var_934131b6;
    }
    attachments = arraycopy(weapon.attachments);
    max_index = attachments.size + var_b5bd8bd9;
    for (i = attachments.size - 1; i >= max_index; i--) {
        arrayremoveindex(attachments, i);
    }
    rootweaponname = weapon.rootweapon.name;
    if (weapon.isdualwield) {
        if (#"smg_handling_t8_dw" == rootweaponname) {
            rootweaponname = #"smg_handling_t8";
        }
    }
    return getweapon(rootweaponname, attachments);
}

// Namespace loadout/player_loadout
// Params 5, eflags: 0x5 linked
// Checksum 0xd8db893d, Offset: 0x38c8
// Size: 0x13a
function private function_68c2f1dc(slot, previous_weapon, var_c41b864, var_fe5710f, var_60b97679) {
    loadout = self get_loadout_slot(slot);
    var_8feec653 = loadout.weapon;
    weapon = self function_2ada6938(slot);
    if (weapon != level.weaponnull) {
        if (!self function_d9035e42(weapon)) {
            weapon = level.weaponnull;
        } else if (!self function_3aa744b9(slot, weapon)) {
            weapon = self function_d126318c(slot, weapon);
        }
    }
    self give_weapon(weapon, slot, var_60b97679, var_fe5710f);
    return self function_d35292b6(var_c41b864, weapon, previous_weapon, var_8feec653);
}

// Namespace loadout/player_loadout
// Params 4, eflags: 0x5 linked
// Checksum 0xe341c2f9, Offset: 0x3a10
// Size: 0x9a
function private function_cba7f33e(slot, previous_weapon, var_c41b864, var_4571c11d) {
    var_8feec653 = self function_18a77b37(slot);
    weapon = self function_2ada6938(slot);
    self [[ var_4571c11d ]](slot, previous_weapon);
    return self function_d35292b6(var_c41b864, weapon, previous_weapon, var_8feec653);
}

// Namespace loadout/player_loadout
// Params 3, eflags: 0x5 linked
// Checksum 0x30c85c89, Offset: 0x3ab8
// Size: 0xb2
function private function_f20f595a(previous_weapon, var_c41b864, var_4571c11d) {
    var_8feec653 = self function_18a77b37("ultimate");
    if (isdefined(self.playerrole) && isdefined(self.playerrole.ultimateweapon)) {
        weapon = getweapon(self.playerrole.ultimateweapon);
        self [[ var_4571c11d ]]("ultimate", previous_weapon);
    }
    return var_c41b864;
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x1 linked
// Checksum 0x583c7ea2, Offset: 0x3b78
// Size: 0x15a
function function_d98a8122(spawn_weapon) {
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
// Params 1, eflags: 0x5 linked
// Checksum 0xffd29ab3, Offset: 0x3ce0
// Size: 0x274
function private give_weapons(previous_weapon) {
    /#
        if (getdvarint(#"hash_3ff1cd3c47489190", 0)) {
            function_d81e599e();
            function_d98a8122(level.weaponbasemeleeheld);
            return;
        }
    #/
    pixbeginevent(#"give_weapons");
    self.primaryloadoutgunsmithvariantindex = self getloadoutgunsmithvariantindex(self.class_num, 0);
    self.secondaryloadoutgunsmithvariantindex = self getloadoutgunsmithvariantindex(self.class_num, 1);
    spawn_weapon = self function_68c2f1dc("primary", previous_weapon, level.weaponnull, 0, &function_f4042786);
    spawn_weapon = self function_68c2f1dc("secondary", previous_weapon, spawn_weapon, 1, &get_weapon_options);
    spawn_weapon = self function_286ee0b6(previous_weapon, spawn_weapon);
    spawn_weapon = self function_cba7f33e("primarygrenade", previous_weapon, spawn_weapon, &function_8e961216);
    spawn_weapon = self function_cba7f33e("secondarygrenade", previous_weapon, spawn_weapon, &function_c3448ab0);
    spawn_weapon = self function_cba7f33e("specialgrenade", previous_weapon, spawn_weapon, &give_special_offhand);
    spawn_weapon = self function_f20f595a(previous_weapon, spawn_weapon, &give_ultimate);
    self function_d98a8122(spawn_weapon);
    self function_da96d067();
    self function_ee9b8d55();
    pixendevent();
}

// Namespace loadout/player_loadout
// Params 0, eflags: 0x0
// Checksum 0x5f96f0f9, Offset: 0x3f60
// Size: 0x14
function function_cdb86a18() {
    function_5536bd9e();
}

// Namespace loadout/player_loadout
// Params 0, eflags: 0x1 linked
// Checksum 0x4ed78cc7, Offset: 0x3f80
// Size: 0x294
function function_5536bd9e() {
    has_specialty_armor = self hasperk(#"specialty_armor");
    healthtoassign = self.spawnhealth;
    if (isdefined(level.maxspawnhealthboostprct)) {
        self.bonusspawnhealth = int(level.maxspawnhealthboostprct * self.spawnhealth);
        healthtoassign += self.bonusspawnhealth;
    }
    if (isdefined(self.var_71a70093)) {
        healthtoassign = self.var_71a70093;
    }
    self player::function_9080887a(healthtoassign);
    self.maxhealth = healthtoassign + (isdefined(level.var_90bb9821) ? level.var_90bb9821 : 0);
    new_health = self.var_66cb03ad < 0 ? healthtoassign : self.var_66cb03ad;
    give_armor = has_specialty_armor && (!isdefined(self.var_a06951b7) || self.var_a06951b7 < gettime());
    armor = give_armor ? self.spawnarmor : 0;
    self.health = new_health;
    self armor::set_armor(armor, armor, 0, self function_e95ae03(#"hash_56055daf9601d89e"), self function_e95ae03(#"hash_e7550a3c852687e"), self function_e95ae03(#"hash_5a20313f9a8825a9"), self function_e95ae03(#"hash_7c24b2a7dce26e8f"), 1, 1, 1);
    self.var_ed2f8b3a = self.spawnhealth;
    if (give_armor || isdefined(self.var_a06951b7) && self.var_a06951b7 < gettime()) {
        self.var_a06951b7 = undefined;
        clientfield::set_player_uimodel("hudItems.armorIsOnCooldown", 0);
    }
    self healthoverlay::restart_player_health_regen();
}

// Namespace loadout/player_loadout
// Params 2, eflags: 0x5 linked
// Checksum 0x1bb2dd18, Offset: 0x4220
// Size: 0x4cc
function private function_8e961216(slot, *previous_weapon) {
    pixbeginevent(#"hash_7187aa59ab81d21a");
    changedclass = self.pers[#"changed_class"];
    roundbased = !util::isoneround();
    firstround = util::isfirstround();
    changedspecialist = self.pers[#"changed_specialist"];
    primaryoffhand = level.weaponnone;
    primaryoffhandcount = 0;
    primaryoffhandname = self function_b958b70d(self.class_num, "primarygrenade");
    if (primaryoffhandname == "default_specialist_equipment" && isdefined(self.playerrole) && isdefined(self.playerrole.var_a7e7cb46)) {
        if (is_true(level.var_50e97365)) {
            primaryoffhandname = self.playerrole.var_a7e7cb46;
        } else {
            primaryoffhandname = #"weapon_null";
        }
    }
    if (primaryoffhandname != #"" && primaryoffhandname != #"weapon_null") {
        primaryoffhand = getweapon(primaryoffhandname);
        primaryoffhandcount = 1 + self getloadoutitem(self.class_num, "primarygrenadecount");
        if (isdefined(self.pers[#"primarygrenadecount"]) && self.pers[#"primarygrenadecount"] < primaryoffhandcount && isdefined(self.pers[#"held_gadgets_power"]) && isdefined(self.pers[#"held_gadgets_power"][primaryoffhand])) {
            self.pers[#"held_gadgets_power"][primaryoffhand] = self.pers[#"held_gadgets_power"][primaryoffhand] * self.pers[#"primarygrenadecount"] / primaryoffhandcount;
        }
        self.pers[#"primarygrenadecount"] = primaryoffhandcount;
    }
    if (isitemrestricted(primaryoffhand.name) || !function_50797a7f(primaryoffhand.name)) {
        primaryoffhand = level.weaponnone;
        primaryoffhandcount = 0;
    }
    if (primaryoffhand == level.weaponnone || is_false(level.specialistequipmentenabled)) {
        primaryoffhand = level.var_34d27b26;
        primaryoffhandcount = 0;
    }
    if (primaryoffhand != level.weaponnull) {
        self giveweapon(primaryoffhand);
        self setweaponammoclip(primaryoffhand, primaryoffhandcount);
        self switchtooffhand(primaryoffhand);
        loadout = self get_loadout_slot(previous_weapon);
        loadout.weapon = primaryoffhand;
        loadout.count = primaryoffhandcount;
        self ability_util::gadget_reset(primaryoffhand, changedclass, roundbased, firstround, changedspecialist);
        if (is_true(level.specialistequipmentreadyonrespawn)) {
            self ability_util::function_36a15b60(primaryoffhand);
        }
    }
    if (primaryoffhand.gadget_type == 0) {
        self giveweapon(level.var_34d27b26);
        self setweaponammoclip(level.var_34d27b26, 0);
    }
    pixendevent();
}

// Namespace loadout/player_loadout
// Params 3, eflags: 0x1 linked
// Checksum 0x12b8ce, Offset: 0x46f8
// Size: 0x4ec
function function_c3448ab0(slot, *previous_weapon, force_give_gadget_health_regen = 1) {
    pixbeginevent(#"hash_d790bf4ec8958ba");
    changedclass = self.pers[#"changed_class"];
    roundbased = !util::isoneround();
    firstround = util::isfirstround();
    changedspecialist = self.pers[#"changed_specialist"];
    secondaryoffhand = level.weaponnone;
    secondaryoffhandcount = 0;
    if (getdvarint(#"equipmentasgadgets", 0) == 1) {
        if (isdefined(self.playerrole) && isdefined(self.playerrole.var_743dc11d)) {
            secondaryoffhand = self.playerrole.var_743dc11d;
            secondaryoffhandcount = secondaryoffhand.startammo;
        }
    } else {
        secondaryoffhandname = self function_b958b70d(self.class_num, "secondarygrenade");
        if (secondaryoffhandname != #"" && secondaryoffhandname != #"weapon_null") {
            secondaryoffhand = getweapon(secondaryoffhandname);
            secondaryoffhandcount = 1 + self getloadoutitem(self.class_num, "secondarygrenadecount");
        }
    }
    if (isitemrestricted(secondaryoffhand.name) || !function_50797a7f(secondaryoffhand.name)) {
        secondaryoffhand = level.weaponnone;
        secondaryoffhandcount = 0;
    }
    if (secondaryoffhand == level.weaponnone) {
        secondaryoffhand = level.var_6388e216;
        secondaryoffhandcount = 0;
    }
    if (globallogic_utils::function_308e3379()) {
        secondaryoffhand = getweapon(#"hash_28323cd36d8b5f93");
        secondaryoffhandcount = 0;
    } else if (force_give_gadget_health_regen === 1 && level.new_health_model && getdvarint(#"hash_ef13b0a277ba1f6", 0) != 0) {
        if (is_true(level.specialisthealingenabled)) {
            if (getdvarint(#"hash_7f9cfdea69a18091", 1) == 1) {
                secondaryoffhand = getweapon(#"hash_788c96e19cc7a46e");
            } else if (secondaryoffhand == level.var_6388e216) {
                secondaryoffhand = getweapon(#"gadget_health_regen");
            }
            secondaryoffhandcount = 0;
        }
    }
    if (getdvarint(#"hash_5cf1725e36a7104", 0) > 0) {
        secondaryoffhand = level.weaponnone;
        secondaryoffhandcount = 0;
    }
    if (secondaryoffhand != level.weaponnull) {
        self giveweapon(secondaryoffhand);
        self setweaponammoclip(secondaryoffhand, secondaryoffhandcount);
        self switchtooffhand(secondaryoffhand);
        loadout = self get_loadout_slot(previous_weapon);
        loadout.weapon = secondaryoffhand;
        loadout.count = secondaryoffhandcount;
        if (secondaryoffhand.gadget_type != 0) {
            if (force_give_gadget_health_regen === 1 && secondaryoffhand.gadget_type == 23) {
                self ability_util::function_36a15b60(secondaryoffhand);
            } else {
                self ability_util::gadget_reset(secondaryoffhand, changedclass, roundbased, firstround, changedspecialist);
            }
        }
    }
    pixendevent();
}

// Namespace loadout/player_loadout
// Params 2, eflags: 0x5 linked
// Checksum 0xe947c798, Offset: 0x4bf0
// Size: 0x44c
function private give_special_offhand(slot, *previous_weapon) {
    pixbeginevent(#"give_special_offhand");
    changedclass = self.pers[#"changed_class"];
    roundbased = !util::isoneround();
    firstround = util::isfirstround();
    changedspecialist = self.pers[#"changed_specialist"];
    specialoffhand = level.weaponnone;
    var_4ee2888b = 0;
    specialoffhandcount = 0;
    var_d07d57b2 = self function_b958b70d(self.class_num, "specialgrenade");
    if (var_d07d57b2 != #"" && var_d07d57b2 != #"weapon_null") {
        specialoffhand = getweapon(var_d07d57b2);
        var_4ee2888b = self getloadoutitem(self.class_num, "specialgrenadecount");
        specialoffhandcount = var_4ee2888b < 0 ? 1 : 2;
        if (isdefined(self.pers[#"specialgrenadecount"]) && self.pers[#"specialgrenadecount"] < specialoffhandcount && isdefined(self.pers[#"held_gadgets_power"]) && isdefined(self.pers[#"held_gadgets_power"][specialoffhand])) {
            self.pers[#"held_gadgets_power"][specialoffhand] = self.pers[#"held_gadgets_power"][specialoffhand] * self.pers[#"specialgrenadecount"] / specialoffhandcount;
        }
        self.pers[#"specialgrenadecount"] = specialoffhandcount;
    }
    if (isitemrestricted(specialoffhand.name) || !function_50797a7f(specialoffhand.name)) {
        specialoffhand = level.weaponnone;
        specialoffhandcount = 0;
    }
    if (specialoffhand != level.weaponnull) {
        self giveweapon(specialoffhand);
        if (getdvarint(#"hash_65c6d6e72413571b", 0)) {
            self setweaponammoclip(specialoffhand, specialoffhandcount);
        }
        self switchtooffhand(specialoffhand);
        loadout = self get_loadout_slot(previous_weapon);
        loadout.weapon = specialoffhand;
        loadout.count = specialoffhandcount;
        self ability_util::gadget_reset(specialoffhand, changedclass, roundbased, firstround, changedspecialist);
        if (is_true(level.specialistequipmentreadyonrespawn)) {
            self ability_util::function_36a15b60(specialoffhand);
        }
    }
    if (specialoffhand.gadget_type == 0) {
        self giveweapon(level.var_43a51921);
        self setweaponammoclip(level.var_43a51921, 0);
    }
    pixendevent();
}

// Namespace loadout/player_loadout
// Params 2, eflags: 0x5 linked
// Checksum 0x8e7527ff, Offset: 0x5048
// Size: 0x314
function private give_ultimate(slot, *previous_weapon) {
    pixbeginevent(#"give_ultimate");
    changedclass = self.pers[#"changed_class"];
    roundbased = !util::isoneround();
    firstround = util::isfirstround();
    changedspecialist = self.pers[#"changed_specialist"];
    classnum = self.class_num_for_global_weapons;
    ultimate = level.weaponnone;
    var_36aac800 = 0;
    if (isdefined(self.playerrole) && isdefined(self.playerrole.ultimateweapon)) {
        ultimate = getweapon(self.playerrole.ultimateweapon);
        var_36aac800 = ultimate.startammo;
    }
    /#
        if (getdvarstring(#"hash_488ee9aa10c06400") != "<dev string:x8d>") {
            var_92d4ff6c = getdvarstring(#"hash_488ee9aa10c06400");
            ultimate = level.weaponnone;
            if (var_92d4ff6c != "<dev string:x121>") {
                ultimate = getweapon(var_92d4ff6c);
            }
        }
    #/
    if (isitemrestricted(ultimate.name) || !function_50797a7f(ultimate.name)) {
        ultimate = level.weaponnone;
        var_36aac800 = 0;
    }
    if (ultimate == level.weaponnone) {
        ultimate = level.var_387e902c;
        var_36aac800 = 0;
    }
    if (ultimate != level.weaponnull) {
        self giveweapon(ultimate);
        self setweaponammoclip(ultimate, var_36aac800);
        loadout = self get_loadout_slot("ultimate");
        loadout.weapon = ultimate;
        loadout.count = var_36aac800;
        self ability_util::gadget_reset(ultimate, changedclass, roundbased, firstround, changedspecialist);
        self function_442539(previous_weapon, ultimate);
    }
    pixendevent();
}

/#

    // Namespace loadout/player_loadout
    // Params 2, eflags: 0x0
    // Checksum 0xf10fa269, Offset: 0x5368
    // Size: 0x4e
    function function_3d16577a(team, weaponclass) {
        level.var_8314ef9f = 1;
        self give_loadout(team, weaponclass);
        level.var_8314ef9f = undefined;
    }

#/

// Namespace loadout/player_loadout
// Params 3, eflags: 0x1 linked
// Checksum 0xf48f8847, Offset: 0x53c0
// Size: 0x57c
function give_loadout(*team, weaponclass, var_e0f216b9) {
    self endon(#"death");
    pixbeginevent(#"give_loadout");
    self clientfield::set("cold_blooded", 0);
    if (function_87bcb1b()) {
        assert(isdefined(self.curclass));
        self function_d7c205b9(self.curclass, #"give_loadout");
        var_c8f2f688 = 1;
        /#
            if (level.var_8314ef9f === 1) {
                var_c8f2f688 = 0;
            }
        #/
        current_weapon = self getcurrentweapon();
        if (isdefined(self.var_560765bb) && self.var_560765bb >= gettime() && current_weapon != level.weaponnone) {
            pixendevent();
            return;
        }
        if (current_weapon == level.weaponnone && isdefined(self.class_num)) {
            current_weapon = self getloadoutweapon(self.class_num, "primary");
        }
        actionslot3 = getdvarint(#"hash_449fa75f87a4b5b4", 0) < 0 ? "flourish_callouts" : "ping_callouts";
        self setactionslot(3, actionslot3);
        actionslot4 = getdvarint(#"hash_23270ec9008cb656", 0) < 0 ? "scorestreak_wheel" : "sprays_boasts";
        self setactionslot(4, actionslot4);
        if (isdefined(level.givecustomloadout)) {
            spawn_weapon = self [[ level.givecustomloadout ]]();
            if (isdefined(spawn_weapon)) {
                self thread initweaponattachments(spawn_weapon);
            }
            self.spawnweapon = spawn_weapon;
        } else {
            self init_player(1);
            function_f436358b(weaponclass);
            allocationspent = self getloadoutallocation(self.class_num);
            overallocation = allocationspent > level.maxallocation;
            self function_8aa3ff4e();
            if (var_c8f2f688) {
                self function_e6f9e3cd();
                give_talents();
            }
            give_perks();
            give_weapons(current_weapon);
            function_5536bd9e();
            give_gesture();
            give_killstreaks();
            self.attackeraccuracy = self function_968b6c6a();
        }
    } else if (isdefined(level.givecustomloadout)) {
        spawn_weapon = self [[ level.givecustomloadout ]]();
        if (isdefined(spawn_weapon)) {
            self thread initweaponattachments(spawn_weapon);
        }
        self.spawnweapon = spawn_weapon;
    }
    self detachall();
    if (isdefined(self.movementspeedmodifier)) {
        self setmovespeedscale(self.movementspeedmodifier * self getmovespeedscale());
    } else {
        self setmovespeedscale(1);
    }
    self cac_selector();
    self.firstspawn = 0;
    primary_weapon = function_18a77b37("primary");
    self function_43048d33(self.spawnweapon, primary_weapon, var_e0f216b9);
    self notify(#"loadout_given");
    callback::callback(#"on_loadout");
    self thread function_b61852e1();
    pixendevent();
}

// Namespace loadout/player_loadout
// Params 0, eflags: 0x5 linked
// Checksum 0x682eca71, Offset: 0x5948
// Size: 0xac
function private function_b61852e1() {
    self endon(#"disconnect");
    self notify("108f6b79ef1cbb8a");
    self endon("108f6b79ef1cbb8a");
    waitframe(1);
    self luinotifyevent(#"hash_21e30e91084f7e66", 0);
    wait 0.1;
    self luinotifyevent(#"hash_21e30e91084f7e66", 0);
    wait 0.5;
    self luinotifyevent(#"hash_21e30e91084f7e66", 0);
}

// Namespace loadout/player_loadout
// Params 3, eflags: 0x5 linked
// Checksum 0x6d3c0c89, Offset: 0x5a00
// Size: 0x1fc
function private function_43048d33(spawn_weapon, primaryweapon, var_e0f216b9 = 0) {
    if (!isdefined(self.firstspawn) || var_e0f216b9) {
        if (isdefined(spawn_weapon)) {
            self initialweaponraise(spawn_weapon);
            if (isdefined(self.firstspawn)) {
                self function_6edc650b(spawn_weapon);
            }
        } else if (isdefined(primaryweapon)) {
            self initialweaponraise(primaryweapon);
            if (isdefined(self.firstspawn)) {
                self function_6edc650b(primaryweapon);
            }
        }
    } else {
        self seteverhadweaponall(1);
    }
    if (!var_e0f216b9) {
        if (isdefined(spawn_weapon)) {
            self function_c9a111a(spawn_weapon);
        } else if (isdefined(primaryweapon)) {
            self function_c9a111a(primaryweapon);
        }
    }
    self.firstspawn = 0;
    self.switchedteamsresetgadgets = 0;
    self.var_560765bb = gettime();
    if (is_true(self.pers[#"changed_specialist"])) {
        self notify(#"changed_specialist");
        self callback::callback(#"changed_specialist");
        self.var_228b6835 = 1;
    } else {
        self.var_228b6835 = 0;
    }
    self.pers[#"changed_specialist"] = 0;
    self flag::set(#"loadout_given");
}

// Namespace loadout/player_loadout
// Params 0, eflags: 0x5 linked
// Checksum 0x6f8c0a69, Offset: 0x5c08
// Size: 0xdc
function private on_player_connecting() {
    if (!isdefined(self)) {
        return;
    }
    self.pers[#"loadoutindex"] = 0;
    if (function_87bcb1b()) {
        if (!isdefined(self.pers[#"class"])) {
            self.pers[#"class"] = "";
        }
        self.curclass = self.pers[#"class"];
        self.lastclass = "";
        self function_c67222df();
        self function_d7c205b9(self.curclass);
    }
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x1 linked
// Checksum 0x78da66e8, Offset: 0x5cf0
// Size: 0x1a
function function_53b62db1(newclass) {
    self.curclass = newclass;
}

// Namespace loadout/player_loadout
// Params 2, eflags: 0x1 linked
// Checksum 0x43235959, Offset: 0x5d18
// Size: 0x1ac
function function_d7c205b9(newclass, var_eead10f0 = #"unspecified") {
    loadoutindex = isdefined(newclass) ? function_6972fdbb(newclass) : undefined;
    self.pers[#"loadoutindex"] = loadoutindex;
    var_45843e9a = var_eead10f0 == #"give_loadout";
    var_7f8c24df = 0;
    if (!var_45843e9a) {
        var_7f8c24df = isdefined(game) && isdefined(game.state) && game.state == "playing" && isalive(self);
        if (var_7f8c24df && self.sessionstate == "playing") {
            var_25b0cd7 = self.usingsupplystation === 1;
            if (is_true(level.ingraceperiod) && !is_true(self.hasdonecombat) || var_25b0cd7) {
                var_7f8c24df = 0;
            }
        }
    }
    if (var_7f8c24df) {
        return;
    }
    self setloadoutindex(loadoutindex);
    self setplayerstateloadoutweapons(loadoutindex);
}

// Namespace loadout/player_loadout
// Params 0, eflags: 0x1 linked
// Checksum 0x71c8255b, Offset: 0x5ed0
// Size: 0x12c
function init_dvars() {
    level.cac_armorpiercing_data = getdvarint(#"perk_armorpiercing", 40) / 100;
    level.cac_bulletdamage_data = getdvarint(#"perk_bulletdamage", 35);
    level.cac_fireproof_data = getdvarint(#"perk_fireproof", 20);
    level.cac_armorvest_data = getdvarint(#"perk_armorvest", 80);
    level.cac_flakjacket_data = getdvarint(#"perk_flakjacket", 35);
    level.cac_flakjacket_hardcore_data = getdvarint(#"perk_flakjacket_hardcore", 9);
}

// Namespace loadout/player_loadout
// Params 0, eflags: 0x5 linked
// Checksum 0xe40e59ae, Offset: 0x6008
// Size: 0x7e
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
// Params 0, eflags: 0x1 linked
// Checksum 0xd574c5da, Offset: 0x6090
// Size: 0x114
function register_perks() {
    pixbeginevent(#"register_perks");
    perks = self.specialty;
    perks::perk_reset_all();
    if (isdefined(perks) && is_true(level.perksenabled)) {
        for (i = 0; i < perks.size; i++) {
            perk = perks[i];
            if (perk == #"specialty_null" || perk == #"weapon_null") {
                continue;
            }
            self perks::perk_setperk(perk);
        }
    }
    /#
        dev::giveextraperks();
    #/
    pixendevent();
}

// Namespace loadout/player_loadout
// Params 7, eflags: 0x1 linked
// Checksum 0xc96900b7, Offset: 0x61b0
// Size: 0x616
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
                attacker.name = "<dev string:x130>";
            }
        }
    #/
    final_damage = damage;
    if (victim != attacker) {
        var_81ca51d = 1;
        if (attacker_is_player && attacker hasperk(#"specialty_bulletdamage") && isprimarydamage(mod)) {
            if (victim hasperk(#"specialty_armorvest") && !function_4c80bca1(hitloc)) {
                /#
                    if (debug) {
                        println("<dev string:x13b>" + victim.name + "<dev string:x146>" + attacker.name + "<dev string:x15d>");
                    }
                #/
            } else {
                final_damage = damage * (100 + level.cac_bulletdamage_data) / 100;
                /#
                    if (debug) {
                        println("<dev string:x13b>" + attacker.name + "<dev string:x17b>" + victim.name);
                    }
                #/
            }
        } else if (victim hasperk(#"specialty_armorvest") && isprimarydamage(mod) && !function_4c80bca1(hitloc)) {
            final_damage = damage * level.cac_armorvest_data * 0.01;
            /#
                if (debug) {
                    println("<dev string:x13b>" + attacker.name + "<dev string:x1a4>" + victim.name);
                }
            #/
        } else if (victim hasperk(#"specialty_fireproof") && weapons::isfiredamage(weapon, mod)) {
            final_damage = damage * level.cac_fireproof_data * 0.01;
            /#
                if (debug) {
                    println("<dev string:x13b>" + attacker.name + "<dev string:x1cc>" + victim.name);
                }
            #/
        } else if (!var_81ca51d && victim hasperk(#"specialty_flakjacket") && weapons::isexplosivedamage(mod) && !weapon.ignoresflakjacket && !victim grenade_stuck(inflictor)) {
            cac_data = level.hardcoremode ? level.cac_flakjacket_hardcore_data : level.cac_flakjacket_data;
            final_damage = int(damage * cac_data / 100);
            /#
                if (debug) {
                    println("<dev string:x13b>" + victim.name + "<dev string:x1ed>" + attacker.name + "<dev string:x20a>");
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
            println("<dev string:x21f>" + final_damage / damage + "<dev string:x239>" + damage + "<dev string:x24c>" + final_damage);
        }
    #/
    final_damage = int(final_damage);
    if (final_damage < 1) {
        final_damage = 1;
    }
    return final_damage;
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x5 linked
// Checksum 0x1986bc00, Offset: 0x67d0
// Size: 0x3e
function private function_4c80bca1(hitloc) {
    return hitloc == "helmet" || hitloc == "head" || hitloc == "neck";
}

// Namespace loadout/player_loadout
// Params 1, eflags: 0x5 linked
// Checksum 0xc12b6cb4, Offset: 0x6818
// Size: 0x34
function private grenade_stuck(inflictor) {
    return isdefined(inflictor) && isdefined(inflictor.stucktoplayer) && inflictor.stucktoplayer == self;
}

// Namespace loadout/player_loadout
// Params 2, eflags: 0x5 linked
// Checksum 0xf783e447, Offset: 0x6858
// Size: 0x4c
function private offhealthregen(*slot, *weapon) {
    self gadgetdeactivate(self.gadget_health_regen_slot, self.gadget_health_regen_weapon);
    thread function_c57586b8();
}

// Namespace loadout/player_loadout
// Params 0, eflags: 0x5 linked
// Checksum 0xfdbfe71b, Offset: 0x68b0
// Size: 0x64
function private function_c57586b8() {
    self endon(#"disconnect");
    wait 0.5;
    self gadget_health_regen::power_off();
    if (isdefined(self.gadget_health_regen_slot)) {
        self function_19ed70ca(self.gadget_health_regen_slot, 1);
    }
}

// Namespace loadout/player_loadout
// Params 0, eflags: 0x5 linked
// Checksum 0xaec0eaf1, Offset: 0x6920
// Size: 0x56e
function private function_8aa3ff4e() {
    wildcards = self function_6f2c0492(self.class_num);
    self.playerloadoutrestrictions = spawnstruct();
    self.playerloadoutrestrictions.numprimaryweapons = isdefined(level.playerloadoutrestrictions[0].numprimaryweapons) ? level.playerloadoutrestrictions[0].numprimaryweapons : 0;
    self.playerloadoutrestrictions.var_355c3581 = isdefined(level.playerloadoutrestrictions[0].var_355c3581) ? level.playerloadoutrestrictions[0].var_355c3581 : 0;
    self.playerloadoutrestrictions.var_882b6b71 = isdefined(level.playerloadoutrestrictions[0].var_882b6b71) ? level.playerloadoutrestrictions[0].var_882b6b71 : 0;
    self.playerloadoutrestrictions.var_ab1984e9 = isdefined(level.playerloadoutrestrictions[0].var_ab1984e9) ? level.playerloadoutrestrictions[0].var_ab1984e9 : 0;
    self.playerloadoutrestrictions.var_934131b6 = isdefined(level.playerloadoutrestrictions[0].var_934131b6) ? level.playerloadoutrestrictions[0].var_934131b6 : 0;
    self.playerloadoutrestrictions.var_c3fc8c73 = isdefined(level.playerloadoutrestrictions[0].var_c3fc8c73) ? level.playerloadoutrestrictions[0].var_c3fc8c73 : 0;
    self.playerloadoutrestrictions.var_a2ef45f8 = isdefined(level.playerloadoutrestrictions[0].var_a2ef45f8) ? level.playerloadoutrestrictions[0].var_a2ef45f8 : 0;
    self.playerloadoutrestrictions.var_cd3db98c = isdefined(level.playerloadoutrestrictions[0].var_cd3db98c) ? level.playerloadoutrestrictions[0].var_cd3db98c : 0;
    self.playerloadoutrestrictions.var_25a22f4 = isdefined(level.playerloadoutrestrictions[0].var_25a22f4) ? level.playerloadoutrestrictions[0].var_25a22f4 : 0;
    if (isdefined(wildcards) && wildcards.size > 0) {
        foreach (var_9bb0ceab in wildcards) {
            var_47dbd1c3 = level.playerloadoutrestrictions[var_9bb0ceab];
            if (isdefined(var_47dbd1c3)) {
                self.playerloadoutrestrictions.numprimaryweapons += isdefined(var_47dbd1c3.numprimaryweapons) ? var_47dbd1c3.numprimaryweapons : 0;
                self.playerloadoutrestrictions.var_355c3581 += isdefined(var_47dbd1c3.var_355c3581) ? var_47dbd1c3.var_355c3581 : 0;
                self.playerloadoutrestrictions.var_882b6b71 += isdefined(var_47dbd1c3.var_882b6b71) ? var_47dbd1c3.var_882b6b71 : 0;
                self.playerloadoutrestrictions.var_ab1984e9 += isdefined(var_47dbd1c3.var_ab1984e9) ? var_47dbd1c3.var_ab1984e9 : 0;
                self.playerloadoutrestrictions.var_934131b6 += isdefined(var_47dbd1c3.var_934131b6) ? var_47dbd1c3.var_934131b6 : 0;
                self.playerloadoutrestrictions.var_c3fc8c73 += isdefined(var_47dbd1c3.var_c3fc8c73) ? var_47dbd1c3.var_c3fc8c73 : 0;
                self.playerloadoutrestrictions.var_a2ef45f8 += isdefined(var_47dbd1c3.var_a2ef45f8) ? var_47dbd1c3.var_a2ef45f8 : 0;
                self.playerloadoutrestrictions.var_cd3db98c += isdefined(var_47dbd1c3.var_cd3db98c) ? var_47dbd1c3.var_cd3db98c : 0;
                self.playerloadoutrestrictions.var_25a22f4 += isdefined(var_47dbd1c3.var_25a22f4) ? var_47dbd1c3.var_25a22f4 : 0;
            }
        }
    }
}

