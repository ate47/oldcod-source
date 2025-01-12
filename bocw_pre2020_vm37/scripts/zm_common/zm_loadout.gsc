#using scripts\abilities\ability_util;
#using scripts\core_common\aat_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\gamestate;
#using scripts\core_common\item_inventory;
#using scripts\core_common\item_world;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\bb;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_hero_weapon;
#using scripts\zm_common\zm_items;
#using scripts\zm_common\zm_magicbox;
#using scripts\zm_common\zm_maptable;
#using scripts\zm_common\zm_melee_weapon;
#using scripts\zm_common\zm_pack_a_punch_util;
#using scripts\zm_common\zm_placeable_mine;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace zm_loadout;

// Namespace zm_loadout/zm_loadout
// Params 0, eflags: 0x6
// Checksum 0x8caf896, Offset: 0x390
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_loadout", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_loadout/zm_loadout
// Params 0, eflags: 0x5 linked
// Checksum 0x6628e9a0, Offset: 0x3d8
// Size: 0x484
function private function_70a657d8() {
    level.var_928a7cf1 = 1;
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
    level.defaultclass = "CLASS_CUSTOM1";
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
    load_default_loadout("CLASS_SMG", 12);
    load_default_loadout("CLASS_CQB", 13);
    load_default_loadout("CLASS_ASSAULT", 14);
    load_default_loadout("CLASS_LMG", 15);
    load_default_loadout("CLASS_SNIPER", 16);
    load_default_loadout("CLASS_SPECIALIZED", 17);
}

// Namespace zm_loadout/zm_loadout
// Params 0, eflags: 0x1 linked
// Checksum 0x6fb6192f, Offset: 0x868
// Size: 0x114
function on_player_connect() {
    self.currentweaponstarttime = gettime();
    self.currentweapon = level.weaponnone;
    self.previousweapon = level.weaponnone;
    if (!isdefined(self.var_57c1d146)) {
        self.var_57c1d146 = [];
    }
    self.pers[#"loadoutindex"] = 0;
    if (loadout::function_87bcb1b()) {
        if (!isdefined(self.pers[#"class"])) {
            self.pers[#"class"] = "";
        }
        self.curclass = self.pers[#"class"];
        self.lastclass = "";
        self loadout::function_c67222df();
        self function_d7c205b9(self.curclass);
    }
}

// Namespace zm_loadout/zm_loadout
// Params 0, eflags: 0x1 linked
// Checksum 0x57033226, Offset: 0x988
// Size: 0x22
function on_player_spawned() {
    self.class_num = self function_cc90c352();
}

// Namespace zm_loadout/weapon_change
// Params 1, eflags: 0x40
// Checksum 0x622e9a7b, Offset: 0x9b8
// Size: 0x6a
function event_handler[weapon_change] weapon_changed(eventstruct) {
    if (!is_true(level.var_928a7cf1)) {
        return;
    }
    if (!isplayer(self)) {
        return;
    }
    self.currentweaponstarttime = gettime();
    self.currentweapon = eventstruct.weapon;
    self.previousweapon = eventstruct.last_weapon;
}

// Namespace zm_loadout/player_loadoutchanged
// Params 1, eflags: 0x40
// Checksum 0x6451d3be, Offset: 0xa30
// Size: 0x54
function event_handler[player_loadoutchanged] loadout_changed(eventstruct) {
    if (!is_true(level.var_928a7cf1)) {
        return;
    }
    if (isdefined(self)) {
        self callback::callback(#"hash_39bf72fd97e248a0", eventstruct);
    }
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x0
// Checksum 0xcdf7e74a, Offset: 0xa90
// Size: 0x22c
function function_ad4c1664(weapon) {
    self notify(#"weapon_take", weapon);
    primaryweapons = self getweaponslistprimaries();
    current_weapon = self getcurrentweapon();
    if (zm_equipment::is_equipment(weapon)) {
        self zm_equipment::take(weapon);
    }
    if (function_59b0ef71("melee_weapon", weapon)) {
        self function_6519eea8("melee_weapon", level.weaponnone);
    } else if (function_59b0ef71("hero_weapon", weapon)) {
        self function_6519eea8("hero_weapon", level.weaponnone);
    } else if (function_59b0ef71("lethal_grenade", weapon)) {
        self function_6519eea8("lethal_grenade", level.weaponnone);
    } else if (function_59b0ef71("tactical_grenade", weapon)) {
        self function_6519eea8("tactical_grenade", level.weaponnone);
    } else if (function_59b0ef71("placeable_mine", weapon)) {
        self function_6519eea8("placeable_mine", level.weaponnone);
    }
    if (!is_offhand_weapon(weapon) && primaryweapons.size < 1) {
        self zm_weapons::give_fallback_weapon();
    }
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x0
// Checksum 0x595a44d, Offset: 0xcc8
// Size: 0x58c
function function_54cb37a4(weapon) {
    self notify(#"weapon_give", weapon);
    self endon(#"disconnect");
    if (weapon == getweapon(#"hash_788c96e19cc7a46e")) {
        return;
    }
    primaryweapons = self getweaponslistprimaries();
    initial_current_weapon = self getcurrentweapon();
    current_weapon = self zm_weapons::switch_from_alt_weapon(initial_current_weapon);
    assert(self zm_weapons::player_can_use_content(weapon));
    weapon_limit = zm_utility::get_player_weapon_limit(self);
    if (is_true(weapon.craftitem)) {
        zm_items::player_pick_up(self, weapon);
        return;
    }
    if (zm_equipment::is_equipment(weapon)) {
        self zm_equipment::give(weapon);
    }
    if (weapon.isriotshield) {
        if (isdefined(self.player_shield_reset_health)) {
            self [[ self.player_shield_reset_health ]](weapon);
        }
    }
    if (function_59b0ef71("melee_weapon", weapon)) {
        had_fallback_weapon = self zm_melee_weapon::take_fallback_weapon();
        self function_6519eea8("melee_weapon", weapon);
        if (had_fallback_weapon) {
            self zm_melee_weapon::give_fallback_weapon();
        }
    } else if (function_59b0ef71("hero_weapon", weapon)) {
        self function_6519eea8("hero_weapon", weapon);
    } else if (function_59b0ef71("lethal_grenade", weapon)) {
        self function_6519eea8("lethal_grenade", weapon);
    } else if (function_59b0ef71("tactical_grenade", weapon)) {
        self function_6519eea8("tactical_grenade", weapon);
    } else if (function_59b0ef71("placeable_mine", weapon)) {
        self function_6519eea8("placeable_mine", weapon);
    }
    if (!is_offhand_weapon(weapon) && !function_2ff6913(weapon) && weapon != self zm_melee_weapon::determine_fallback_weapon()) {
        self zm_weapons::take_fallback_weapon();
    }
    if (primaryweapons.size > weapon_limit) {
        if (is_placeable_mine(current_weapon) || zm_equipment::is_equipment(current_weapon) || self.laststandpistol === weapon) {
            current_weapon = undefined;
        }
        if (isdefined(current_weapon)) {
            if (!is_offhand_weapon(weapon)) {
                self zm_weapons::weapon_take(current_weapon);
                if (isdefined(initial_current_weapon) && current_weapon != initial_current_weapon) {
                    self zm_weapons::weapon_take(initial_current_weapon);
                }
            }
        }
    }
    if (isdefined(level.zombiemode_offhand_weapon_give_override)) {
        if (self [[ level.zombiemode_offhand_weapon_give_override ]](weapon)) {
            return;
        }
    }
    if (is_placeable_mine(weapon)) {
        self thread zm_placeable_mine::setup_for_player(weapon);
        return weapon;
    }
    if (isdefined(level.zombie_weapons_callbacks) && isdefined(level.zombie_weapons_callbacks[weapon])) {
        self thread [[ level.zombie_weapons_callbacks[weapon] ]]();
    }
    self zm_weapons::function_7c5dd4bd(weapon);
    if (is_true(self.var_57c1d146[weapon])) {
        self.var_57c1d146[weapon] = undefined;
        return;
    }
    if (!is_offhand_weapon(weapon) && !is_hero_weapon(weapon)) {
        if (!is_melee_weapon(weapon)) {
            self switchtoweapon(weapon);
            return;
        }
        self switchtoweapon(current_weapon);
    }
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x1 linked
// Checksum 0xae3eceae, Offset: 0x1260
// Size: 0x60
function function_5a5a742a(slot) {
    if (!isdefined(level.var_d5f9c1d2)) {
        level.var_d5f9c1d2 = [];
    }
    if (!isdefined(level.var_d5f9c1d2[slot])) {
        level.var_d5f9c1d2[slot] = [];
    }
    return level.var_d5f9c1d2[slot];
}

// Namespace zm_loadout/zm_loadout
// Params 2, eflags: 0x1 linked
// Checksum 0x50acc663, Offset: 0x12c8
// Size: 0xf2
function function_e884e095(slot, weapon) {
    if (isstring(weapon) || ishash(weapon)) {
        weapon = getweapon(weapon);
    }
    if (weapon.name == #"none") {
        return;
    }
    if (function_59b0ef71(slot, weapon)) {
        return;
    }
    if (!isdefined(level.var_d5f9c1d2)) {
        level.var_d5f9c1d2 = [];
    }
    if (!isdefined(level.var_d5f9c1d2[slot])) {
        level.var_d5f9c1d2[slot] = [];
    }
    level.var_d5f9c1d2[slot][weapon] = weapon;
}

// Namespace zm_loadout/zm_loadout
// Params 2, eflags: 0x1 linked
// Checksum 0x4311fc35, Offset: 0x13c8
// Size: 0x60
function function_59b0ef71(slot, weapon) {
    if (!isdefined(weapon) || !isdefined(level.var_d5f9c1d2) || !isdefined(level.var_d5f9c1d2[slot])) {
        return false;
    }
    return isdefined(level.var_d5f9c1d2[slot][weapon]);
}

// Namespace zm_loadout/zm_loadout
// Params 2, eflags: 0x1 linked
// Checksum 0x2baea654, Offset: 0x1430
// Size: 0x72
function function_393977df(slot, weapon) {
    if (!isdefined(weapon) || weapon == level.weaponnone || !isdefined(self.slot_weapons) || !isdefined(self.slot_weapons[slot])) {
        return false;
    }
    return self.slot_weapons[slot] == weapon;
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x1 linked
// Checksum 0x61debce4, Offset: 0x14b0
// Size: 0x98
function function_8f85096(slot) {
    if (!isdefined(self.slot_weapons)) {
        self.slot_weapons = [];
    }
    if (!isdefined(self.slot_weapons[slot])) {
        self.slot_weapons[slot] = level.weaponnone;
    }
    var_4d5892ca = level.weaponnone;
    if (isdefined(self.slot_weapons) && isdefined(self.slot_weapons[slot])) {
        var_4d5892ca = self.slot_weapons[slot];
    }
    return var_4d5892ca;
}

// Namespace zm_loadout/zm_loadout
// Params 2, eflags: 0x1 linked
// Checksum 0xaa012f08, Offset: 0x1550
// Size: 0x164
function function_6519eea8(slot, weapon) {
    if (!isdefined(self.slot_weapons)) {
        self.slot_weapons = [];
    }
    if (!isdefined(self.slot_weapons[slot])) {
        self.slot_weapons[slot] = level.weaponnone;
    }
    if (!isdefined(weapon)) {
        weapon = level.weaponnone;
    }
    old_weapon = self function_8f85096(slot);
    self notify(#"hash_4078956b159dd0f3", {#slot:slot, #weapon:weapon});
    self notify("new_" + slot, {#weapon:weapon});
    self.slot_weapons[slot] = level.weaponnone;
    if (old_weapon != level.weaponnone && old_weapon != weapon) {
        if (self hasweapon(old_weapon)) {
            self takeweapon(old_weapon);
        }
    }
    self.slot_weapons[slot] = weapon;
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x1 linked
// Checksum 0x70df77be, Offset: 0x16c0
// Size: 0x24
function register_lethal_grenade_for_level(weaponname) {
    function_e884e095("lethal_grenade", weaponname);
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x1 linked
// Checksum 0x7e717d3c, Offset: 0x16f0
// Size: 0x16
function is_lethal_grenade(weapon) {
    return weapon.islethalgrenade;
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x1 linked
// Checksum 0x88ef0d1, Offset: 0x1710
// Size: 0x2a
function is_player_lethal_grenade(weapon) {
    return self function_393977df("lethal_grenade", weapon);
}

// Namespace zm_loadout/zm_loadout
// Params 0, eflags: 0x1 linked
// Checksum 0xd7fceb19, Offset: 0x1748
// Size: 0x22
function get_player_lethal_grenade() {
    return self function_8f85096("lethal_grenade");
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x1 linked
// Checksum 0x7505f8c6, Offset: 0x1778
// Size: 0x2c
function set_player_lethal_grenade(weapon) {
    self function_6519eea8("lethal_grenade", weapon);
}

// Namespace zm_loadout/zm_loadout
// Params 2, eflags: 0x1 linked
// Checksum 0x2ec1a352, Offset: 0x17b0
// Size: 0x74
function register_tactical_grenade_for_level(weaponname, var_b1830d98 = 0) {
    function_e884e095("tactical_grenade", weaponname);
    if (var_b1830d98) {
        w_shield = getweapon(weaponname);
        level.var_b115fab2 = w_shield;
    }
}

// Namespace zm_loadout/zm_loadout
// Params 2, eflags: 0x1 linked
// Checksum 0xdadf33c1, Offset: 0x1830
// Size: 0x6a
function is_tactical_grenade(weapon, var_9f428637 = 1) {
    if (!var_9f428637 && is_true(weapon.isriotshield)) {
        return 0;
    }
    return function_59b0ef71("tactical_grenade", weapon);
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x1 linked
// Checksum 0x670fba89, Offset: 0x18a8
// Size: 0x2a
function is_player_tactical_grenade(weapon) {
    return self function_393977df("tactical_grenade", weapon);
}

// Namespace zm_loadout/zm_loadout
// Params 0, eflags: 0x1 linked
// Checksum 0x6f747fad, Offset: 0x18e0
// Size: 0x22
function get_player_tactical_grenade() {
    return self function_8f85096("tactical_grenade");
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x0
// Checksum 0x3133ca01, Offset: 0x1910
// Size: 0x2c
function set_player_tactical_grenade(weapon) {
    self function_6519eea8("tactical_grenade", weapon);
}

// Namespace zm_loadout/zm_loadout
// Params 0, eflags: 0x0
// Checksum 0xd774cf32, Offset: 0x1948
// Size: 0x2c
function init_player_tactical_grenade() {
    self function_6519eea8("tactical_grenade", level.zombie_tactical_grenade_player_init);
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x1 linked
// Checksum 0x25f661da, Offset: 0x1980
// Size: 0x22
function is_placeable_mine(weapon) {
    return function_59b0ef71("placeable_mine", weapon);
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x1 linked
// Checksum 0x67cd6d68, Offset: 0x19b0
// Size: 0x2a
function is_player_placeable_mine(weapon) {
    return self function_393977df("placeable_mine", weapon);
}

// Namespace zm_loadout/zm_loadout
// Params 0, eflags: 0x1 linked
// Checksum 0x8c99eff9, Offset: 0x19e8
// Size: 0x22
function get_player_placeable_mine() {
    return self function_8f85096("placeable_mine");
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x1 linked
// Checksum 0x95279b88, Offset: 0x1a18
// Size: 0x2c
function set_player_placeable_mine(weapon) {
    self function_6519eea8("placeable_mine", weapon);
}

// Namespace zm_loadout/zm_loadout
// Params 0, eflags: 0x0
// Checksum 0x6f328dcf, Offset: 0x1a50
// Size: 0x2c
function init_player_placeable_mine() {
    self function_6519eea8("placeable_mine", level.zombie_placeable_mine_player_init);
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x1 linked
// Checksum 0x6e0c31a2, Offset: 0x1a88
// Size: 0x24
function register_melee_weapon_for_level(weaponname) {
    function_e884e095("melee_weapon", weaponname);
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x1 linked
// Checksum 0xbcb9cff2, Offset: 0x1ab8
// Size: 0x22
function is_melee_weapon(weapon) {
    return function_59b0ef71("melee_weapon", weapon);
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x1 linked
// Checksum 0xee8eea31, Offset: 0x1ae8
// Size: 0x2a
function is_player_melee_weapon(weapon) {
    return self function_393977df("melee_weapon", weapon);
}

// Namespace zm_loadout/zm_loadout
// Params 0, eflags: 0x1 linked
// Checksum 0xc04778a7, Offset: 0x1b20
// Size: 0x22
function get_player_melee_weapon() {
    return self function_8f85096("melee_weapon");
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x1 linked
// Checksum 0x73e4191, Offset: 0x1b50
// Size: 0x6c
function set_player_melee_weapon(weapon) {
    had_fallback_weapon = self zm_melee_weapon::take_fallback_weapon();
    self function_6519eea8("melee_weapon", weapon);
    if (had_fallback_weapon) {
        self zm_melee_weapon::give_fallback_weapon();
    }
}

// Namespace zm_loadout/zm_loadout
// Params 0, eflags: 0x0
// Checksum 0xf14ac4cb, Offset: 0x1bc8
// Size: 0x2c
function init_player_melee_weapon() {
    self zm_weapons::weapon_give(level.zombie_melee_weapon_player_init, 1, 0);
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x0
// Checksum 0x39db7268, Offset: 0x1c00
// Size: 0x24
function register_hero_weapon_for_level(weaponname) {
    function_e884e095("hero_weapon", weaponname);
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x1 linked
// Checksum 0xc1c5d9ea, Offset: 0x1c30
// Size: 0x22
function is_hero_weapon(weapon) {
    return function_59b0ef71("hero_weapon", weapon);
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x1 linked
// Checksum 0x225df355, Offset: 0x1c60
// Size: 0x2a
function is_player_hero_weapon(weapon) {
    return self function_393977df("hero_weapon", weapon);
}

// Namespace zm_loadout/zm_loadout
// Params 0, eflags: 0x1 linked
// Checksum 0xf0e819ab, Offset: 0x1c98
// Size: 0x22
function get_player_hero_weapon() {
    return self function_8f85096("hero_weapon");
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x1 linked
// Checksum 0xc3387483, Offset: 0x1cc8
// Size: 0x2c
function set_player_hero_weapon(weapon) {
    self function_6519eea8("hero_weapon", weapon);
}

// Namespace zm_loadout/zm_loadout
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x1d00
// Size: 0x4
function init_player_hero_weapon() {
    
}

// Namespace zm_loadout/zm_loadout
// Params 0, eflags: 0x0
// Checksum 0xe965b274, Offset: 0x1d10
// Size: 0x36
function has_player_hero_weapon() {
    current_hero_weapon = get_player_hero_weapon();
    return isdefined(current_hero_weapon) && current_hero_weapon != level.weaponnone;
}

// Namespace zm_loadout/zm_loadout
// Params 0, eflags: 0x1 linked
// Checksum 0xd2f8b1a9, Offset: 0x1d50
// Size: 0xe2
function register_offhand_weapons_for_level_defaults() {
    if (isdefined(level.var_54f1e174)) {
        [[ level.var_54f1e174 ]]();
        return;
    }
    if (isdefined(level.var_22fda912)) {
        [[ level.var_22fda912 ]]();
    }
    register_melee_weapon_for_level(level.weaponbasemelee.name);
    if (zm_maptable::get_story() == 1) {
        register_melee_weapon_for_level(#"bowie_knife_story_1");
    } else {
        register_melee_weapon_for_level(#"bowie_knife");
    }
    level.zombie_melee_weapon_player_init = level.weaponbasemelee;
    level.zombie_equipment_player_init = undefined;
}

// Namespace zm_loadout/zm_loadout
// Params 0, eflags: 0x1 linked
// Checksum 0x2f0878a3, Offset: 0x1e40
// Size: 0xec
function init_player_offhand_weapons() {
    nullprimary = getweapon(#"null_offhand_primary");
    self giveweapon(nullprimary);
    self setweaponammoclip(nullprimary, 0);
    self switchtooffhand(nullprimary);
    bare_hands = getweapon(#"bare_hands");
    self giveweapon(bare_hands);
    self function_c9a111a(bare_hands);
    self switchtoweapon(bare_hands, 1);
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x1 linked
// Checksum 0xaf6024f7, Offset: 0x1f38
// Size: 0x24
function function_2ff6913(weapon) {
    return weapon.isperkbottle || weapon.isflourishweapon;
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x1 linked
// Checksum 0xc6dd13a5, Offset: 0x1f68
// Size: 0x9c
function is_offhand_weapon(weapon) {
    return is_lethal_grenade(weapon) || is_tactical_grenade(weapon) || is_placeable_mine(weapon) || is_melee_weapon(weapon) || is_hero_weapon(weapon) || zm_equipment::is_equipment(weapon);
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x0
// Checksum 0xf2a30e37, Offset: 0x2010
// Size: 0x9c
function is_player_offhand_weapon(weapon) {
    return self is_player_lethal_grenade(weapon) || self is_player_tactical_grenade(weapon) || self is_player_placeable_mine(weapon) || self is_player_melee_weapon(weapon) || self is_player_hero_weapon(weapon) || self zm_equipment::is_player_equipment(weapon);
}

// Namespace zm_loadout/zm_loadout
// Params 0, eflags: 0x1 linked
// Checksum 0xfba5ef5e, Offset: 0x20b8
// Size: 0x1a
function has_powerup_weapon() {
    return is_true(self.has_powerup_weapon);
}

// Namespace zm_loadout/zm_loadout
// Params 0, eflags: 0x1 linked
// Checksum 0x86f4f4f6, Offset: 0x20e0
// Size: 0x42
function has_hero_weapon() {
    weapon = self getcurrentweapon();
    return is_true(weapon.isheroweapon);
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x1 linked
// Checksum 0x77ca7a96, Offset: 0x2130
// Size: 0x3e4
function give_start_weapon(b_switch_weapon) {
    primary_weapon = self function_439b009a("primary");
    var_c6eea9c1 = isdefined(zm_stats::function_12b698fa(#"hash_265dfd25205ffba8")) ? zm_stats::function_12b698fa(#"hash_265dfd25205ffba8") : 0;
    /#
        var_df6f833b = getdvarint(#"hash_31933df32887a98b", 0);
        if (var_df6f833b > 0) {
            var_c6eea9c1 = var_df6f833b;
        }
    #/
    var_8c590502 = isdefined(getgametypesetting(#"hash_3c2c78e639bfd3c6")) ? getgametypesetting(#"hash_3c2c78e639bfd3c6") : 0;
    if (var_8c590502 > 0) {
        var_c6eea9c1 = var_8c590502;
    }
    if (var_c6eea9c1 >= 1 && var_c6eea9c1 < 3) {
        self zm_weapons::weapon_give(getweapon(#"knife"));
    } else if (var_c6eea9c1 >= 3) {
        self zm_weapons::weapon_give(getweapon(#"bowie_knife"));
    }
    s_weapon = getunlockableiteminfofromindex(primary_weapon.statindex, 1);
    if (isdefined(s_weapon) && isdefined(s_weapon.namehash) && zm_custom::function_bce642a1(s_weapon) && zm_custom::function_901b751c(#"zmstartingweaponenabled")) {
        if (isdefined(primary_weapon.attachments) && primary_weapon.attachments.size > 0) {
            self zm_weapons::weapon_give(primary_weapon, 1, b_switch_weapon, undefined, undefined, undefined, primary_weapon.attachments);
        } else {
            self zm_weapons::weapon_give(primary_weapon, 1, b_switch_weapon);
        }
        if (zm_custom::function_901b751c(#"zmstartingweaponenabled") && isdefined(self.var_8313fee5)) {
            self thread function_d9153457(b_switch_weapon);
        }
        return;
    }
    var_abb79409 = getweapon(getdvarstring(#"hash_35d047ae6d3ad4a", "pistol_semiauto_t9"));
    self zm_weapons::weapon_give(var_abb79409, 1, b_switch_weapon);
    if (isdefined(s_weapon) && (!zm_custom::function_bce642a1(s_weapon) || !zm_custom::function_901b751c(#"zmstartingweaponenabled"))) {
        self thread zm_custom::function_343353f8();
    }
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x1 linked
// Checksum 0xb30c78a5, Offset: 0x2520
// Size: 0x6a
function get_loadout_item(slot) {
    if (!isdefined(self.class_num)) {
        self.class_num = self function_cc90c352();
    }
    if (!isdefined(self.class_num)) {
        self.class_num = 0;
    }
    return self getloadoutitem(self.class_num, slot);
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x1 linked
// Checksum 0xb096c88b, Offset: 0x2598
// Size: 0x6a
function function_439b009a(slot) {
    if (!isdefined(self.class_num)) {
        self.class_num = self function_cc90c352();
    }
    if (!isdefined(self.class_num)) {
        self.class_num = 0;
    }
    return self getloadoutweapon(self.class_num, slot);
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x1 linked
// Checksum 0xa88cb176, Offset: 0x2610
// Size: 0x1d8
function function_6972fdbb(weaponclass) {
    assert(isdefined(weaponclass));
    prefixstring = "CLASS_CUSTOM";
    var_8bba14bc = self getcustomclasscount();
    var_8bba14bc = max(var_8bba14bc, 0);
    if (isstring(weaponclass) && issubstr(weaponclass, prefixstring)) {
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

// Namespace zm_loadout/zm_loadout
// Params 2, eflags: 0x1 linked
// Checksum 0xc87258c7, Offset: 0x27f0
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

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x1 linked
// Checksum 0x12f5f5ba, Offset: 0x29a8
// Size: 0x44
function function_97d216fa(response) {
    assert(isdefined(level.classmap[response]));
    return level.classmap[response];
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x0
// Checksum 0xeb25a0df, Offset: 0x29f8
// Size: 0xc
function function_a7079aac(*attachments) {
    
}

// Namespace zm_loadout/zm_loadout
// Params 4, eflags: 0x1 linked
// Checksum 0x26d10dc3, Offset: 0x2a10
// Size: 0x7c8
function menuclass(response, forcedclass, *updatecharacterindex, var_632376a3) {
    if (!isdefined(self.pers[#"team"]) || !isdefined(level.teams[self.pers[#"team"]])) {
        return 0;
    }
    if (!loadout::function_87bcb1b()) {
        if ((game.state == "pregame" || game.state == "playing") && self.sessionstate != "playing") {
            self thread [[ level.spawnclient ]](0);
        }
        return;
    }
    if (!isdefined(updatecharacterindex)) {
        playerclass = self function_97d216fa(forcedclass);
    } else {
        playerclass = updatecharacterindex;
    }
    if (is_true(level.disablecustomcac) && issubstr(playerclass, "CLASS_CUSTOM") && isarray(level.classtoclassnum) && level.classtoclassnum.size > 0) {
        defaultclasses = getarraykeys(level.var_8e1db8ee);
        playerclass = level.var_8e1db8ee[defaultclasses[randomint(defaultclasses.size)]];
    }
    self function_d7c205b9(playerclass);
    var_96b1ace = 0;
    if (isdefined(self.pers[#"class"]) && self.pers[#"class"] == playerclass) {
        primary_weapon = self function_439b009a("primary");
        current_weapon = self getcurrentweapon();
        if (isdefined(primary_weapon.attachments) && isdefined(current_weapon.attachments) && primary_weapon.rootweapon === current_weapon.rootweapon) {
            if (primary_weapon.attachments.size != current_weapon.attachments.size) {
                var_96b1ace = 1;
            } else {
                foreach (attachment in primary_weapon.attachments) {
                    var_c27e271b = isinarray(current_weapon.attachments, attachment);
                    if (!var_c27e271b) {
                        var_96b1ace = 1;
                        break;
                    }
                }
            }
        }
        if (!var_96b1ace) {
            return 1;
        }
    }
    self.pers[#"changed_class"] = !isdefined(self.curclass) || self.curclass != playerclass || var_96b1ace;
    var_8d7a946 = !isdefined(self.curclass) || self.curclass == "";
    self.pers[#"class"] = playerclass;
    self.curclass = playerclass;
    self function_d7c205b9(playerclass);
    self.pers[#"weapon"] = undefined;
    self notify(#"changed_class");
    if (gamestate::is_game_over()) {
        return 0;
    }
    if (self.sessionstate != "playing") {
        if (self.sessionstate != "spectator") {
            if (self isinvehicle()) {
                return 0;
            }
            if (self isremotecontrolling()) {
                return 0;
            }
            if (self isweaponviewonlylinked()) {
                return 0;
            }
        }
        if (self.sessionstate != "dead") {
            timepassed = undefined;
            if (!is_true(level.var_d0252074) || !is_true(self.hasspawned)) {
                if (isdefined(self.respawntimerstarttime)) {
                    timepassed = float(gettime() - self.respawntimerstarttime) / 1000;
                }
                self thread [[ level.spawnclient ]](timepassed);
                self.respawntimerstarttime = undefined;
            }
        }
    }
    if (self.sessionstate == "playing") {
        supplystationclasschange = isdefined(self.usingsupplystation) && self.usingsupplystation;
        self.usingsupplystation = 0;
        if (is_true(level.ingraceperiod) && !is_true(self.hasdonecombat) || is_true(supplystationclasschange) || var_632376a3 === 1 || self.pers[#"latejoin"] === 1 && self.pers[#"time_played_alive"] < level.graceperiod && !is_true(self.hasdonecombat)) {
            self.curclass = self.pers[#"class"];
            self.tag_stowed_back = undefined;
            self.tag_stowed_hip = undefined;
            self give_loadout();
        } else if (!var_8d7a946 && self.pers[#"changed_class"] && !is_true(level.var_f46d16f0)) {
            loadoutindex = self function_6972fdbb(playerclass);
            self luinotifyevent(#"hash_6b67aa04e378d681", 2, 6, loadoutindex);
        }
    }
    return 1;
}

// Namespace zm_loadout/zm_loadout
// Params 2, eflags: 0x5 linked
// Checksum 0x874fb2ca, Offset: 0x31e0
// Size: 0x34
function private load_default_loadout(weaponclass, classnum) {
    level.classtoclassnum[weaponclass] = classnum;
    level.var_8e1db8ee[classnum] = weaponclass;
}

// Namespace zm_loadout/zm_loadout
// Params 0, eflags: 0x1 linked
// Checksum 0x5553550e, Offset: 0x3220
// Size: 0x264
function give_loadout() {
    if (!is_true(level.var_928a7cf1)) {
        return;
    }
    if (self.var_1fa95cc === gettime() && isdefined(self.curclass) && function_6972fdbb(self.curclass) === self.pers[#"loadoutindex"]) {
        return;
    }
    if (loadout::function_87bcb1b()) {
        assert(isdefined(self.curclass));
        self function_d7c205b9(self.curclass, #"give_loadout");
        actionslot3 = getdvarint(#"hash_449fa75f87a4b5b4", 0) < 0 ? "flourish_callouts" : "ping_callouts";
        self setactionslot(3, actionslot3);
        actionslot4 = getdvarint(#"hash_23270ec9008cb656", 0) < 0 ? "scorestreak_wheel" : "sprays_boasts";
        self setactionslot(4, actionslot4);
        if (isdefined(level.givecustomloadout)) {
            self [[ level.givecustomloadout ]]();
        } else {
            init_player(isdefined(self.var_1fa95cc));
            function_f436358b(self.curclass);
            zm_weapons::give_start_weapons();
        }
    } else if (isdefined(level.givecustomloadout)) {
        self [[ level.givecustomloadout ]]();
    }
    self.var_1fa95cc = gettime();
    self notify(#"loadout_given");
    callback::callback(#"on_loadout");
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x1 linked
// Checksum 0x682c4873, Offset: 0x3490
// Size: 0x4e
function init_player(takeallweapons) {
    if (takeallweapons) {
        item_inventory::reset_inventory(0);
        self takeallweapons();
    }
    self.specialty = [];
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x1 linked
// Checksum 0x91d39bd2, Offset: 0x34e8
// Size: 0x124
function function_f436358b(weaponclass) {
    self.class_num = function_6972fdbb(weaponclass);
    if (issubstr(weaponclass, "CLASS_CUSTOM")) {
        pixbeginevent(#"custom class");
        self.class_num_for_global_weapons = self.class_num;
        pixendevent();
    } else {
        pixbeginevent(#"default class");
        assert(isdefined(self.pers[#"class"]), "<dev string:x38>");
        self.class_num_for_global_weapons = 0;
        pixendevent();
    }
    self recordloadoutindex(self.class_num);
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x1 linked
// Checksum 0x22090276, Offset: 0x3618
// Size: 0xc4
function function_d9153457(b_switch_weapon = 1) {
    self endon(#"death");
    var_19673a84 = getweapon(self.var_8313fee5);
    if (var_19673a84 !== level.weaponnone) {
        self zm_weapons::weapon_give(var_19673a84, 1, 0);
        if (b_switch_weapon) {
            level waittill(#"start_zombie_round_logic");
            self switchtoweaponimmediate(var_19673a84, 1);
        }
    }
}

