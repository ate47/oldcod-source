#using script_1b05b3ef7baa1c84;
#using scripts\core_common\aat_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
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
#using scripts\zm_common\zm_melee_weapon;
#using scripts\zm_common\zm_pack_a_punch_util;
#using scripts\zm_common\zm_placeable_mine;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace zm_loadout;

// Namespace zm_loadout/zm_loadout
// Params 0, eflags: 0x2
// Checksum 0xcca21264, Offset: 0x1a0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_loadout", &__init__, undefined, undefined);
}

// Namespace zm_loadout/zm_loadout
// Params 0, eflags: 0x0
// Checksum 0xf48d5ca9, Offset: 0x1e8
// Size: 0x44
function __init__() {
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
}

// Namespace zm_loadout/zm_loadout
// Params 0, eflags: 0x0
// Checksum 0xe28a70cd, Offset: 0x238
// Size: 0x2e
function on_player_connect() {
    self.currentweaponstarttime = gettime();
    self.currentweapon = level.weaponnone;
    self.previousweapon = level.weaponnone;
}

// Namespace zm_loadout/zm_loadout
// Params 0, eflags: 0x0
// Checksum 0x1a73fff2, Offset: 0x270
// Size: 0xe
function on_player_spawned() {
    self.class_num = 0;
}

// Namespace zm_loadout/weapon_change
// Params 1, eflags: 0x40
// Checksum 0xabfa2e7a, Offset: 0x288
// Size: 0x5a
function event_handler[weapon_change] weapon_changed(eventstruct) {
    if (!isplayer(self)) {
        return;
    }
    self.currentweaponstarttime = gettime();
    self.currentweapon = eventstruct.weapon;
    self.previousweapon = eventstruct.last_weapon;
}

// Namespace zm_loadout/player_loadoutchanged
// Params 1, eflags: 0x40
// Checksum 0xddabdac0, Offset: 0x2f0
// Size: 0xac
function event_handler[player_loadoutchanged] loadout_changed(eventstruct) {
    switch (eventstruct.event) {
    case #"give_weapon":
        self function_9231fc6d(eventstruct.weapon);
        break;
    case #"take_weapon":
        self function_5ca8c407(eventstruct.weapon);
        break;
    }
    self callback::callback(#"hash_39bf72fd97e248a0", eventstruct);
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x0
// Checksum 0x8a911950, Offset: 0x3a8
// Size: 0x22c
function function_5ca8c407(weapon) {
    self notify(#"weapon_take", weapon);
    primaryweapons = self getweaponslistprimaries();
    current_weapon = self getcurrentweapon();
    if (zm_equipment::is_equipment(weapon)) {
        self zm_equipment::take(weapon);
    }
    if (function_13a2af3("melee_weapon", weapon)) {
        self function_66ee357("melee_weapon", level.weaponnone);
    } else if (function_13a2af3("hero_weapon", weapon)) {
        self function_66ee357("hero_weapon", level.weaponnone);
    } else if (function_13a2af3("lethal_grenade", weapon)) {
        self function_66ee357("lethal_grenade", level.weaponnone);
    } else if (function_13a2af3("tactical_grenade", weapon)) {
        self function_66ee357("tactical_grenade", level.weaponnone);
    } else if (function_13a2af3("placeable_mine", weapon)) {
        self function_66ee357("placeable_mine", level.weaponnone);
    }
    if (!is_offhand_weapon(weapon) && primaryweapons.size < 1) {
        self zm_weapons::give_fallback_weapon();
    }
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x0
// Checksum 0x11cd4831, Offset: 0x5e0
// Size: 0x55c
function function_9231fc6d(weapon) {
    self notify(#"weapon_give", weapon);
    primaryweapons = self getweaponslistprimaries();
    initial_current_weapon = self getcurrentweapon();
    current_weapon = self zm_weapons::switch_from_alt_weapon(initial_current_weapon);
    assert(self zm_weapons::player_can_use_content(weapon));
    weapon_limit = zm_utility::get_player_weapon_limit(self);
    if (isdefined(weapon.craftitem) && weapon.craftitem) {
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
    if (function_13a2af3("melee_weapon", weapon)) {
        had_fallback_weapon = self zm_melee_weapon::take_fallback_weapon();
        self function_66ee357("melee_weapon", weapon);
        if (had_fallback_weapon) {
            self zm_melee_weapon::give_fallback_weapon();
        }
    } else if (function_13a2af3("hero_weapon", weapon)) {
        self function_66ee357("hero_weapon", weapon);
    } else if (function_13a2af3("lethal_grenade", weapon)) {
        self function_66ee357("lethal_grenade", weapon);
    } else if (function_13a2af3("tactical_grenade", weapon)) {
        self function_66ee357("tactical_grenade", weapon);
    } else if (function_13a2af3("placeable_mine", weapon)) {
        self function_66ee357("placeable_mine", weapon);
    }
    if (!is_offhand_weapon(weapon) && !function_65f8e85(weapon) && weapon != self zm_melee_weapon::determine_fallback_weapon()) {
        self zm_weapons::take_fallback_weapon();
    }
    if (primaryweapons.size > weapon_limit) {
        if (is_placeable_mine(current_weapon) || zm_equipment::is_equipment(current_weapon) || self.laststandpistol === weapon) {
            current_weapon = undefined;
        }
        if (isdefined(current_weapon)) {
            if (!is_offhand_weapon(weapon)) {
                if (current_weapon.isballisticknife) {
                    self notify(#"hash_1fdb7e931333fd8b");
                }
                self zm_weapons::weapon_take(current_weapon);
                if (isdefined(initial_current_weapon) && weaponhasattachment(weapon, "dualoptic")) {
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
    self zm_weapons::function_d13d5303(weapon);
    if (!is_offhand_weapon(weapon) && !is_hero_weapon(weapon)) {
        if (!is_melee_weapon(weapon)) {
            self switchtoweapon(weapon);
            return;
        }
        self switchtoweapon(current_weapon);
    }
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x0
// Checksum 0x857b2895, Offset: 0xb48
// Size: 0x60
function function_992fe093(slot) {
    if (!isdefined(level.var_544b342c)) {
        level.var_544b342c = [];
    }
    if (!isdefined(level.var_544b342c[slot])) {
        level.var_544b342c[slot] = [];
    }
    return level.var_544b342c[slot];
}

// Namespace zm_loadout/zm_loadout
// Params 2, eflags: 0x0
// Checksum 0x4977a73e, Offset: 0xbb0
// Size: 0x104
function function_4e1a22d7(slot, weapon) {
    if (isstring(weapon) || ishash(weapon)) {
        weapon = getweapon(weapon);
    }
    if (weapon.name == #"none") {
        return;
    }
    if (function_13a2af3(slot, weapon)) {
        return;
    }
    if (!isdefined(level.var_544b342c)) {
        level.var_544b342c = [];
    }
    if (!isdefined(level.var_544b342c[slot])) {
        level.var_544b342c[slot] = [];
    }
    level.var_544b342c[slot][weapon] = weapon;
}

// Namespace zm_loadout/zm_loadout
// Params 2, eflags: 0x0
// Checksum 0xa8fb4fd0, Offset: 0xcc0
// Size: 0x64
function function_13a2af3(slot, weapon) {
    if (!isdefined(weapon) || !isdefined(level.var_544b342c) || !isdefined(level.var_544b342c[slot])) {
        return false;
    }
    return isdefined(level.var_544b342c[slot][weapon]);
}

// Namespace zm_loadout/zm_loadout
// Params 2, eflags: 0x0
// Checksum 0x563075b9, Offset: 0xd30
// Size: 0x72
function function_c5c7cae1(slot, weapon) {
    if (!isdefined(weapon) || weapon == level.weaponnone || !isdefined(self.slot_weapons) || !isdefined(self.slot_weapons[slot])) {
        return false;
    }
    return self.slot_weapons[slot] == weapon;
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x0
// Checksum 0x2ae58631, Offset: 0xdb0
// Size: 0x98
function function_4135542b(slot) {
    if (!isdefined(self.slot_weapons)) {
        self.slot_weapons = [];
    }
    if (!isdefined(self.slot_weapons[slot])) {
        self.slot_weapons[slot] = level.weaponnone;
    }
    w_ret = level.weaponnone;
    if (isdefined(self.slot_weapons) && isdefined(self.slot_weapons[slot])) {
        w_ret = self.slot_weapons[slot];
    }
    return w_ret;
}

// Namespace zm_loadout/zm_loadout
// Params 2, eflags: 0x0
// Checksum 0x1951f4bf, Offset: 0xe50
// Size: 0x16a
function function_66ee357(slot, weapon) {
    if (!isdefined(self.slot_weapons)) {
        self.slot_weapons = [];
    }
    if (!isdefined(self.slot_weapons[slot])) {
        self.slot_weapons[slot] = level.weaponnone;
    }
    if (!isdefined(weapon)) {
        weapon = level.weaponnone;
    }
    old_weapon = self function_4135542b(slot);
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
// Params 1, eflags: 0x0
// Checksum 0x5f3c6b48, Offset: 0xfc8
// Size: 0x24
function register_lethal_grenade_for_level(weaponname) {
    function_4e1a22d7("lethal_grenade", weaponname);
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x0
// Checksum 0x7d610e0d, Offset: 0xff8
// Size: 0x22
function is_lethal_grenade(weapon) {
    return function_13a2af3("lethal_grenade", weapon);
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x0
// Checksum 0xbb01091b, Offset: 0x1028
// Size: 0x2a
function is_player_lethal_grenade(weapon) {
    return self function_c5c7cae1("lethal_grenade", weapon);
}

// Namespace zm_loadout/zm_loadout
// Params 0, eflags: 0x0
// Checksum 0x40e0c5ca, Offset: 0x1060
// Size: 0x22
function get_player_lethal_grenade() {
    return self function_4135542b("lethal_grenade");
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x0
// Checksum 0xc75c90b9, Offset: 0x1090
// Size: 0x2c
function set_player_lethal_grenade(weapon) {
    self function_66ee357("lethal_grenade", weapon);
}

// Namespace zm_loadout/zm_loadout
// Params 0, eflags: 0x0
// Checksum 0x11019035, Offset: 0x10c8
// Size: 0x17c
function init_player_lethal_grenade() {
    var_556a3847 = self get_loadout_item("primarygrenade");
    s_weapon = getunlockableiteminfofromindex(var_556a3847, 1);
    w_weapon = level.zombie_lethal_grenade_player_init;
    if (isdefined(s_weapon) && isdefined(s_weapon.namehash)) {
        w_weapon = getweapon(s_weapon.namehash);
        self zm_weapons::weapon_give(w_weapon, 1, 0);
    } else {
        self zm_weapons::weapon_give(level.zombie_lethal_grenade_player_init, 1, 0);
    }
    if (w_weapon.isgadget) {
        slot = self gadgetgetslot(w_weapon);
        var_79b5bc7a = isdefined(self.firstspawn) ? self.firstspawn : 1;
        if (slot >= 0 && var_79b5bc7a) {
            self gadgetpowerreset(slot, 1);
        }
    }
}

// Namespace zm_loadout/zm_loadout
// Params 2, eflags: 0x0
// Checksum 0xf2c211f2, Offset: 0x1250
// Size: 0x76
function register_tactical_grenade_for_level(weaponname, var_ed710271 = 0) {
    function_4e1a22d7("tactical_grenade", weaponname);
    if (var_ed710271) {
        w_shield = getweapon(weaponname);
        level.var_119ddc6b = w_shield;
    }
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x0
// Checksum 0xd71ee8d1, Offset: 0x12d0
// Size: 0x22
function is_tactical_grenade(weapon) {
    return function_13a2af3("tactical_grenade", weapon);
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x0
// Checksum 0x10b28455, Offset: 0x1300
// Size: 0x2a
function is_player_tactical_grenade(weapon) {
    return self function_c5c7cae1("tactical_grenade", weapon);
}

// Namespace zm_loadout/zm_loadout
// Params 0, eflags: 0x0
// Checksum 0xda4bb275, Offset: 0x1338
// Size: 0x22
function get_player_tactical_grenade() {
    return self function_4135542b("tactical_grenade");
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x0
// Checksum 0xeb89b7cc, Offset: 0x1368
// Size: 0x2c
function set_player_tactical_grenade(weapon) {
    self function_66ee357("tactical_grenade", weapon);
}

// Namespace zm_loadout/zm_loadout
// Params 0, eflags: 0x0
// Checksum 0xca750975, Offset: 0x13a0
// Size: 0x2c
function init_player_tactical_grenade() {
    self function_66ee357("tactical_grenade", level.zombie_tactical_grenade_player_init);
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x0
// Checksum 0x1e2c1eff, Offset: 0x13d8
// Size: 0x22
function is_placeable_mine(weapon) {
    return function_13a2af3("placeable_mine", weapon);
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x0
// Checksum 0xf53da92, Offset: 0x1408
// Size: 0x2a
function is_player_placeable_mine(weapon) {
    return self function_c5c7cae1("placeable_mine", weapon);
}

// Namespace zm_loadout/zm_loadout
// Params 0, eflags: 0x0
// Checksum 0x99fab709, Offset: 0x1440
// Size: 0x22
function get_player_placeable_mine() {
    return self function_4135542b("placeable_mine");
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x0
// Checksum 0x8a9dd21d, Offset: 0x1470
// Size: 0x2c
function set_player_placeable_mine(weapon) {
    self function_66ee357("placeable_mine", weapon);
}

// Namespace zm_loadout/zm_loadout
// Params 0, eflags: 0x0
// Checksum 0x7f0ab032, Offset: 0x14a8
// Size: 0x2c
function init_player_placeable_mine() {
    self function_66ee357("placeable_mine", level.zombie_placeable_mine_player_init);
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x0
// Checksum 0x1862d386, Offset: 0x14e0
// Size: 0x24
function register_melee_weapon_for_level(weaponname) {
    function_4e1a22d7("melee_weapon", weaponname);
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x0
// Checksum 0x6911bd06, Offset: 0x1510
// Size: 0x22
function is_melee_weapon(weapon) {
    return function_13a2af3("melee_weapon", weapon);
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x0
// Checksum 0x290fc168, Offset: 0x1540
// Size: 0x2a
function is_player_melee_weapon(weapon) {
    return self function_c5c7cae1("melee_weapon", weapon);
}

// Namespace zm_loadout/zm_loadout
// Params 0, eflags: 0x0
// Checksum 0x164d2353, Offset: 0x1578
// Size: 0x22
function get_player_melee_weapon() {
    return self function_4135542b("melee_weapon");
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x0
// Checksum 0xf25fe0b8, Offset: 0x15a8
// Size: 0x6c
function set_player_melee_weapon(weapon) {
    had_fallback_weapon = self zm_melee_weapon::take_fallback_weapon();
    self function_66ee357("melee_weapon", weapon);
    if (had_fallback_weapon) {
        self zm_melee_weapon::give_fallback_weapon();
    }
}

// Namespace zm_loadout/zm_loadout
// Params 0, eflags: 0x0
// Checksum 0xd779baf6, Offset: 0x1620
// Size: 0x2c
function init_player_melee_weapon() {
    self zm_weapons::weapon_give(level.zombie_melee_weapon_player_init, 1, 0);
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x0
// Checksum 0x76544a12, Offset: 0x1658
// Size: 0x24
function register_hero_weapon_for_level(weaponname) {
    function_4e1a22d7("hero_weapon", weaponname);
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x0
// Checksum 0xc3df7db6, Offset: 0x1688
// Size: 0x22
function is_hero_weapon(weapon) {
    return function_13a2af3("hero_weapon", weapon);
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x0
// Checksum 0xe47f5afb, Offset: 0x16b8
// Size: 0x2a
function is_player_hero_weapon(weapon) {
    return self function_c5c7cae1("hero_weapon", weapon);
}

// Namespace zm_loadout/zm_loadout
// Params 0, eflags: 0x0
// Checksum 0x9ee74e4b, Offset: 0x16f0
// Size: 0x22
function get_player_hero_weapon() {
    return self function_4135542b("hero_weapon");
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x0
// Checksum 0x149f4cf1, Offset: 0x1720
// Size: 0x2c
function set_player_hero_weapon(weapon) {
    self function_66ee357("hero_weapon", weapon);
}

// Namespace zm_loadout/zm_loadout
// Params 0, eflags: 0x0
// Checksum 0x28209e14, Offset: 0x1758
// Size: 0x1c
function init_player_hero_weapon() {
    self zm_hero_weapon::hero_weapon_player_init();
}

// Namespace zm_loadout/zm_loadout
// Params 0, eflags: 0x0
// Checksum 0x981de213, Offset: 0x1780
// Size: 0x36
function has_player_hero_weapon() {
    current_hero_weapon = get_player_hero_weapon();
    return isdefined(current_hero_weapon) && current_hero_weapon != level.weaponnone;
}

// Namespace zm_loadout/zm_loadout
// Params 0, eflags: 0x0
// Checksum 0x217569a2, Offset: 0x17c0
// Size: 0x1d6
function register_offhand_weapons_for_level_defaults() {
    if (isdefined(level.var_f55453ea)) {
        [[ level.var_f55453ea ]]();
        return;
    }
    if (isdefined(level.var_a732b3aa)) {
        [[ level.var_a732b3aa ]]();
    }
    register_lethal_grenade_for_level(#"claymore");
    register_lethal_grenade_for_level(#"eq_acid_bomb");
    register_lethal_grenade_for_level(#"eq_frag_grenade");
    register_lethal_grenade_for_level(#"eq_molotov");
    register_lethal_grenade_for_level(#"eq_wraith_fire");
    register_lethal_grenade_for_level(#"mini_turret");
    register_lethal_grenade_for_level(#"proximity_grenade");
    register_lethal_grenade_for_level(#"sticky_grenade");
    level.zombie_lethal_grenade_player_init = getweapon(#"eq_frag_grenade");
    register_melee_weapon_for_level(level.weaponbasemelee.name);
    register_melee_weapon_for_level(#"bowie_knife");
    level.zombie_melee_weapon_player_init = level.weaponbasemelee;
    level.zombie_equipment_player_init = undefined;
}

// Namespace zm_loadout/zm_loadout
// Params 0, eflags: 0x0
// Checksum 0x63c0419f, Offset: 0x19a0
// Size: 0x64
function init_player_offhand_weapons() {
    init_player_lethal_grenade();
    init_player_tactical_grenade();
    init_player_placeable_mine();
    init_player_melee_weapon();
    init_player_hero_weapon();
    zm_equipment::init_player_equipment();
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x0
// Checksum 0xf6529420, Offset: 0x1a10
// Size: 0x28
function function_65f8e85(weapon) {
    return weapon.isperkbottle || weapon.isflourishweapon;
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x0
// Checksum 0xca50d8f5, Offset: 0x1a40
// Size: 0x9c
function is_offhand_weapon(weapon) {
    return is_lethal_grenade(weapon) || is_tactical_grenade(weapon) || is_placeable_mine(weapon) || is_melee_weapon(weapon) || is_hero_weapon(weapon) || zm_equipment::is_equipment(weapon);
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x0
// Checksum 0xe62bcce8, Offset: 0x1ae8
// Size: 0x9c
function is_player_offhand_weapon(weapon) {
    return self is_player_lethal_grenade(weapon) || self is_player_tactical_grenade(weapon) || self is_player_placeable_mine(weapon) || self is_player_melee_weapon(weapon) || self is_player_hero_weapon(weapon) || self zm_equipment::is_player_equipment(weapon);
}

// Namespace zm_loadout/zm_loadout
// Params 0, eflags: 0x0
// Checksum 0xf908fcd1, Offset: 0x1b90
// Size: 0x18
function has_powerup_weapon() {
    return isdefined(self.has_powerup_weapon) && self.has_powerup_weapon;
}

// Namespace zm_loadout/zm_loadout
// Params 0, eflags: 0x0
// Checksum 0xcfd1165b, Offset: 0x1bb0
// Size: 0x44
function has_hero_weapon() {
    weapon = self getcurrentweapon();
    return isdefined(weapon.isheroweapon) && weapon.isheroweapon;
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x0
// Checksum 0x2a008471, Offset: 0x1c00
// Size: 0x114
function give_start_weapon(b_switch_weapon) {
    var_dc5b5fb7 = self get_loadout_item("primary");
    s_weapon = getunlockableiteminfofromindex(var_dc5b5fb7, 1);
    if (isdefined(s_weapon) && isdefined(s_weapon.namehash) && zm_custom::function_1bc3066a(s_weapon) && zm_custom::function_5638f689(#"zmstartingweaponenabled")) {
        self zm_weapons::weapon_give(getweapon(s_weapon.namehash), 1, b_switch_weapon);
        return;
    }
    self zm_weapons::weapon_give(level.start_weapon, 1, b_switch_weapon);
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x0
// Checksum 0xc6a18e2b, Offset: 0x1d20
// Size: 0x7a
function get_loadout_item(slot) {
    if (!isdefined(self.class_num)) {
        self.class_num = self stats::get_stat(#"selectedcustomclass");
    }
    if (!isdefined(self.class_num)) {
        self.class_num = 0;
    }
    return self getloadoutitem(self.class_num, slot);
}

// Namespace zm_loadout/zm_loadout
// Params 1, eflags: 0x0
// Checksum 0x7815d034, Offset: 0x1da8
// Size: 0x7a
function function_2e08c289(slot) {
    if (!isdefined(self.class_num)) {
        self.class_num = self stats::get_stat(#"selectedcustomclass");
    }
    if (!isdefined(self.class_num)) {
        self.class_num = 0;
    }
    return self getloadoutweapon(self.class_num, slot);
}

