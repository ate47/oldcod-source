#using script_1caf36ff04a85ff6;
#using script_340a2e805e35f7a2;
#using script_471b31bd963b388e;
#using scripts\abilities\ability_util;
#using scripts\core_common\aat_shared;
#using scripts\core_common\activecamo_shared;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\bb_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\item_drop;
#using scripts\core_common\item_inventory;
#using scripts\core_common\item_world;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\weapons;
#using scripts\zm_common\bb;
#using scripts\zm_common\gametypes\globallogic_utils;
#using scripts\zm_common\trials\zm_trial_reset_loadout;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_camos;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_hero_weapon;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_magicbox;
#using scripts\zm_common\zm_melee_weapon;
#using scripts\zm_common\zm_pack_a_punch_util;
#using scripts\zm_common\zm_placeable_mine;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_wallbuy;

#namespace zm_weapons;

// Namespace zm_weapons/zm_weapons
// Params 0, eflags: 0x6
// Checksum 0xbf87c599, Offset: 0x298
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"zm_weapons", &function_70a657d8, &postinit, undefined, undefined);
}

// Namespace zm_weapons/zm_weapons
// Params 0, eflags: 0x5 linked
// Checksum 0x8bc61564, Offset: 0x2f0
// Size: 0x1c4
function private function_70a657d8() {
    level flag::init("zm_weapons_table_loaded");
    level.weaponnone = getweapon(#"none");
    level.weaponnull = getweapon(#"weapon_null");
    level.var_78032351 = getweapon(#"defaultweapon");
    level.weaponbasemelee = getweapon(#"knife");
    if (!isdefined(level.zombie_weapons)) {
        level.zombie_weapons = [];
    }
    if (!isdefined(level.zombie_weapons_upgraded)) {
        level.zombie_weapons_upgraded = [];
    }
    level.limited_weapons = [];
    function_ec38915a();
    level.var_51443ce5 = &get_player_weapondata;
    level.var_bfbdc0cd = &weapondata_give;
    level.var_ee5c0b6e = &function_93cd8e76;
    callback::on_weapon_change(&on_weapon_change);
    callback::on_item_pickup(&on_item_pickup);
    function_30b08f95();
    weapons::init_shared();
}

// Namespace zm_weapons/zm_weapons
// Params 0, eflags: 0x5 linked
// Checksum 0x59075f86, Offset: 0x4c0
// Size: 0x14
function private postinit() {
    init();
}

// Namespace zm_weapons/zm_weapons
// Params 0, eflags: 0x1 linked
// Checksum 0x32e438ae, Offset: 0x4e0
// Size: 0x9c
function init() {
    if (!isdefined(level.pack_a_punch_camo_index)) {
        level.pack_a_punch_camo_index = 42;
    }
    level.primary_weapon_array = [];
    level.side_arm_array = [];
    level.grenade_array = [];
    level.inventory_array = [];
    init_weapons();
    level._zombiemode_check_firesale_loc_valid_func = &default_check_firesale_loc_valid_func;
    callback::on_spawned(&on_player_spawned);
}

// Namespace zm_weapons/zm_weapons
// Params 0, eflags: 0x1 linked
// Checksum 0x41dbcfa0, Offset: 0x588
// Size: 0x56
function on_player_spawned() {
    self thread watchforgrenadeduds();
    self thread watchforgrenadelauncherduds();
    self.staticweaponsstarttime = gettime();
    if (!isdefined(self.var_f6d3c3)) {
        self.var_f6d3c3 = [];
    }
}

// Namespace zm_weapons/zm_weapons
// Params 0, eflags: 0x1 linked
// Checksum 0x6393236b, Offset: 0x5e8
// Size: 0x308
function function_30b08f95() {
    level.var_29d88fe5 = [];
    var_a559259f = [];
    itemspawnlist = getscriptbundle(#"random_attachment_weapons_list");
    var_70f9bc79 = getscriptbundle(#"random_attachment_weapons_common_list");
    foreach (item in var_70f9bc79.itemlist) {
        point = getscriptbundle(item.var_a6762160);
        if (isdefined(point.weapon)) {
            parentweapon = point.weapon.name;
            if (isdefined(parentweapon) && isdefined(item.var_3f8c08e3)) {
                var_a559259f[parentweapon] = item.var_3f8c08e3;
            }
        }
    }
    foreach (item in itemspawnlist.itemlist) {
        point = getscriptbundle(item.var_a6762160);
        if (isdefined(point.weapon)) {
            parentweapon = point.weapon.name;
            if (isdefined(item.var_23a1d10f) && isdefined(item.var_7b0c7fe3) && isdefined(item.var_8261a18) && isdefined(item.var_3f8c08e3) && isdefined(var_a559259f[parentweapon]) && isdefined(parentweapon) && isdefined(item.var_168e36e8)) {
                level.var_29d88fe5[parentweapon] = [#"white":var_a559259f[parentweapon], #"green":item.var_3f8c08e3, #"blue":item.var_8261a18, #"purple":item.var_7b0c7fe3, #"orange":item.var_23a1d10f, #"gold":item.var_168e36e8];
            }
        }
    }
}

// Namespace zm_weapons/zm_weapons
// Params 0, eflags: 0x1 linked
// Checksum 0x920c6b25, Offset: 0x8f8
// Size: 0x17c
function function_ec38915a() {
    if (!isdefined(level.var_5a069e6)) {
        level.var_5a069e6 = [];
    }
    if (!isdefined(level.var_44e0d625)) {
        level.var_44e0d625 = [];
    }
    function_8005e7f3(getweapon(#"smg_handling_t8"), getweapon(#"smg_handling_t8_dw"));
    function_8005e7f3(getweapon(#"smg_handling_t8_upgraded"), getweapon(#"smg_handling_t8_upgraded_dw"));
    function_8005e7f3(getweapon(#"special_ballisticknife_t8_dw"), getweapon(#"special_ballisticknife_t8_dw_dw"));
    function_8005e7f3(getweapon(#"special_ballisticknife_t8_dw_upgraded"), getweapon(#"special_ballisticknife_t8_dw_upgraded_dw"));
}

// Namespace zm_weapons/zm_weapons
// Params 2, eflags: 0x1 linked
// Checksum 0x1bac0e2f, Offset: 0xa80
// Size: 0x5c
function function_8005e7f3(w_base, var_ebc2aad) {
    if (w_base != level.weaponnone && var_ebc2aad != level.weaponnone) {
        level.var_5a069e6[w_base] = var_ebc2aad;
        level.var_44e0d625[var_ebc2aad] = w_base;
    }
}

// Namespace zm_weapons/player_gunchallengecomplete
// Params 1, eflags: 0x40
// Checksum 0xc751a6f9, Offset: 0xae8
// Size: 0x1c4
function event_handler[player_gunchallengecomplete] player_gunchallengecomplete(s_event) {
    if (s_event.is_lastrank) {
        var_8e617ca1 = 0;
        a_w_guns = get_guns();
        foreach (weapon in a_w_guns) {
            str_weapon = weapon.name;
            n_item_index = getbaseweaponitemindex(weapon);
            var_cc074f5b = stats::get_stat(#"ranked_item_stats", str_weapon, #"xp");
            if (isdefined(var_cc074f5b)) {
                var_6b792d1d = function_33cc663e(str_weapon);
                var_56ccc9fe = stats::get_stat(#"ranked_item_stats", str_weapon, #"plevel");
                if (var_cc074f5b >= var_6b792d1d || var_56ccc9fe >= 1) {
                    var_8e617ca1++;
                }
            }
        }
        if (var_8e617ca1 >= 25) {
            zm_utility::function_659819fa(#"zm_trophy_gold");
        }
    }
}

// Namespace zm_weapons/zm_weapons
// Params 0, eflags: 0x1 linked
// Checksum 0xaab28114, Offset: 0xcb8
// Size: 0x15a
function get_guns() {
    a_w_guns = [];
    foreach (s_weapon in level.zombie_weapons) {
        switch (s_weapon.weapon_classname) {
        case 0:
        case #"equipment":
        case #"shield":
        case #"melee":
            continue;
        }
        if (is_wonder_weapon(s_weapon.weapon)) {
            continue;
        }
        if (!isdefined(a_w_guns)) {
            a_w_guns = [];
        } else if (!isarray(a_w_guns)) {
            a_w_guns = array(a_w_guns);
        }
        a_w_guns[a_w_guns.size] = s_weapon.weapon;
    }
    return a_w_guns;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0xb55bfc03, Offset: 0xe20
// Size: 0xb0
function function_14590040(str_weapon) {
    var_9bea1b6 = [];
    for (i = 0; i < 16; i++) {
        var_4a3def14 = tablelookup(#"gamedata/weapons/zm/zm_gunlevels.csv", 2, str_weapon, 0, i, 1);
        if ("" == var_4a3def14) {
            break;
        }
        var_9bea1b6[i] = int(var_4a3def14);
    }
    return var_9bea1b6;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0x3a8b8327, Offset: 0xed8
// Size: 0x3e
function function_33cc663e(str_weapon) {
    var_9bea1b6 = function_14590040(str_weapon);
    return var_9bea1b6[var_9bea1b6.size - 1];
}

// Namespace zm_weapons/zm_weapons
// Params 0, eflags: 0x1 linked
// Checksum 0xe9916151, Offset: 0xf20
// Size: 0xd0
function watchforgrenadeduds() {
    self endon(#"death", #"disconnect");
    while (true) {
        waitresult = self waittill(#"grenade_fire");
        grenade = waitresult.projectile;
        weapon = waitresult.weapon;
        if (!zm_equipment::is_equipment(weapon) && !zm_loadout::is_placeable_mine(weapon)) {
            grenade thread checkgrenadefordud(weapon, 1, self);
        }
    }
}

// Namespace zm_weapons/zm_weapons
// Params 0, eflags: 0x1 linked
// Checksum 0x683e40e5, Offset: 0xff8
// Size: 0xa0
function watchforgrenadelauncherduds() {
    self endon(#"death", #"disconnect");
    while (true) {
        waitresult = self waittill(#"grenade_launcher_fire");
        grenade = waitresult.projectile;
        weapon = waitresult.weapon;
        grenade thread checkgrenadefordud(weapon, 0, self);
    }
}

// Namespace zm_weapons/zm_weapons
// Params 2, eflags: 0x1 linked
// Checksum 0x9c84f3b9, Offset: 0x10a0
// Size: 0x40
function grenade_safe_to_throw(player, weapon) {
    if (isdefined(level.grenade_safe_to_throw)) {
        return self [[ level.grenade_safe_to_throw ]](player, weapon);
    }
    return 1;
}

// Namespace zm_weapons/zm_weapons
// Params 2, eflags: 0x1 linked
// Checksum 0x203c2de5, Offset: 0x10e8
// Size: 0x40
function grenade_safe_to_bounce(player, weapon) {
    if (isdefined(level.grenade_safe_to_bounce)) {
        return self [[ level.grenade_safe_to_bounce ]](player, weapon);
    }
    return 1;
}

// Namespace zm_weapons/zm_weapons
// Params 0, eflags: 0x1 linked
// Checksum 0x58fe4447, Offset: 0x1130
// Size: 0x64
function makegrenadedudanddestroy() {
    self endon(#"death");
    self notify(#"grenade_dud");
    self makegrenadedud();
    wait 3;
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace zm_weapons/zm_weapons
// Params 3, eflags: 0x1 linked
// Checksum 0x6fd4b825, Offset: 0x11a0
// Size: 0x102
function checkgrenadefordud(weapon, *isthrowngrenade, player) {
    self endon(#"death");
    player endon(#"zombify");
    if (!isdefined(self)) {
        return;
    }
    if (!self grenade_safe_to_throw(player, isthrowngrenade)) {
        self thread makegrenadedudanddestroy();
        return;
    }
    for (;;) {
        self waittilltimeout(0.25, #"grenade_bounce", #"stationary", #"death", #"zombify");
        if (!self grenade_safe_to_bounce(player, isthrowngrenade)) {
            self thread makegrenadedudanddestroy();
            return;
        }
    }
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0xa85a6b5b, Offset: 0x12b0
// Size: 0x34
function get_nonalternate_weapon(weapon) {
    if (is_true(weapon.isaltmode)) {
        return weapon.altweapon;
    }
    return weapon;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0xfe0ad1f, Offset: 0x12f0
// Size: 0x4a
function function_af29d744(weapon) {
    if (isdefined(weapon)) {
        if (weapon.isaltmode) {
            weapon = weapon.altweapon;
        }
        weapon = function_386dacbc(weapon);
    }
    return weapon;
}

// Namespace zm_weapons/zm_weapons
// Params 2, eflags: 0x1 linked
// Checksum 0x168ba71, Offset: 0x1348
// Size: 0x92
function function_93cd8e76(weapon, var_1011fc73 = 0) {
    if (weapon.inventorytype == "dwlefthand") {
        weapon = weapon.dualwieldweapon;
    }
    weapon = function_af29d744(weapon);
    if (var_1011fc73 && isdefined(level.zombie_weapons_upgraded[weapon])) {
        return level.zombie_weapons_upgraded[weapon];
    }
    return weapon;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0xf78c1552, Offset: 0x13e8
// Size: 0xa0
function switch_from_alt_weapon(weapon) {
    if (weapon.ischargeshot) {
        return weapon;
    }
    alt = get_nonalternate_weapon(weapon);
    if (alt != weapon) {
        if (!weaponhasattachment(weapon, "dualoptic")) {
            self switchtoweaponimmediate(alt);
            self waittilltimeout(1, #"weapon_change_complete");
        }
        return alt;
    }
    return weapon;
}

// Namespace zm_weapons/zm_weapons
// Params 2, eflags: 0x1 linked
// Checksum 0x597e4187, Offset: 0x1490
// Size: 0x44
function give_start_weapons(*takeallweapons, *alreadyspawned) {
    self zm_loadout::init_player_offhand_weapons();
    self zm_loadout::give_start_weapon(1);
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0xfaa858a9, Offset: 0x14e0
// Size: 0x2c
function give_fallback_weapon(immediate = 0) {
    zm_melee_weapon::give_fallback_weapon(immediate);
}

// Namespace zm_weapons/zm_weapons
// Params 0, eflags: 0x1 linked
// Checksum 0x1cf30e7e, Offset: 0x1518
// Size: 0x14
function take_fallback_weapon() {
    zm_melee_weapon::take_fallback_weapon();
}

// Namespace zm_weapons/zm_weapons
// Params 3, eflags: 0x1 linked
// Checksum 0xbbb84264, Offset: 0x1538
// Size: 0x244
function switch_back_primary_weapon(oldprimary, immediate = 0, var_6d4494f9 = 0) {
    if (is_true(self.laststand)) {
        return;
    }
    if (!isdefined(oldprimary) || oldprimary == level.weaponnone || oldprimary.isflourishweapon || zm_loadout::is_melee_weapon(oldprimary) || zm_loadout::is_placeable_mine(oldprimary) || zm_loadout::is_lethal_grenade(oldprimary) || zm_loadout::is_tactical_grenade(oldprimary, !var_6d4494f9) || !self hasweapon(oldprimary)) {
        oldprimary = undefined;
    } else if ((oldprimary.isheroweapon || oldprimary.isgadget) && (!isdefined(self.hero_power) || self.hero_power <= 0)) {
        oldprimary = undefined;
    }
    primaryweapons = self getweaponslistprimaries();
    if (isdefined(oldprimary) && (isinarray(primaryweapons, oldprimary) || oldprimary.isriotshield && var_6d4494f9)) {
        if (immediate) {
            self switchtoweaponimmediate(oldprimary);
        } else {
            self switchtoweapon(oldprimary);
        }
        return;
    }
    if (primaryweapons.size > 0) {
        if (immediate) {
            self switchtoweaponimmediate();
        } else {
            self switchtoweapon();
        }
        return;
    }
    give_fallback_weapon(immediate);
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0x4203c96e, Offset: 0x1788
// Size: 0x9c
function updatelastheldweapontimingszm(newtime) {
    if (isdefined(self.currentweapon) && isdefined(self.currenttime)) {
        curweapon = self.currentweapon;
        totaltime = int((newtime - self.currenttime) / 1000);
        if (totaltime > 0) {
            self stats::function_e24eec31(curweapon, #"timeused", totaltime);
        }
    }
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0x52b3a207, Offset: 0x1830
// Size: 0x8e
function updateweapontimingszm(newtime) {
    if (isbot(self)) {
        return;
    }
    updatelastheldweapontimingszm(newtime);
    if (!isdefined(self.staticweaponsstarttime)) {
        return;
    }
    totaltime = int((newtime - self.staticweaponsstarttime) / 1000);
    if (totaltime < 0) {
        return;
    }
    self.staticweaponsstarttime = newtime;
}

// Namespace zm_weapons/zm_weapons
// Params 0, eflags: 0x1 linked
// Checksum 0x6554d124, Offset: 0x18c8
// Size: 0x8
function default_check_firesale_loc_valid_func() {
    return true;
}

// Namespace zm_weapons/zm_weapons
// Params 13, eflags: 0x1 linked
// Checksum 0xa435de16, Offset: 0x18d8
// Size: 0x374
function add_zombie_weapon(weapon_name, upgrade_name, is_ee, cost, weaponvo, weaponvoresp, ammo_cost, create_vox, weapon_class, is_wonder_weapon, tier = 0, in_box, element) {
    weapon = getweapon(weapon_name);
    upgrade = undefined;
    if (isdefined(upgrade_name)) {
        upgrade = getweapon(upgrade_name);
    }
    if (isdefined(level.zombie_include_weapons) && !isdefined(level.zombie_include_weapons[weapon])) {
        return;
    }
    struct = spawnstruct();
    if (!isdefined(level.zombie_weapons)) {
        level.zombie_weapons = [];
    }
    if (!isdefined(level.zombie_weapons_upgraded)) {
        level.zombie_weapons_upgraded = [];
    }
    if (isdefined(upgrade_name)) {
        level.zombie_weapons_upgraded[upgrade] = weapon;
    }
    struct.weapon = weapon;
    struct.upgrade = upgrade;
    struct.weapon_classname = weapon_class;
    struct.hint = #"hash_60606b68e93a29c8";
    struct.cost = cost;
    struct.vox = weaponvo;
    struct.vox_response = weaponvoresp;
    struct.is_wonder_weapon = is_wonder_weapon;
    struct.tier = tier;
    struct.var_9d17fab9 = weapon_name + "_item_sr";
    struct.element = isdefined(element) && element != #"" ? element : undefined;
    println("<dev string:x38>" + function_9e72a96(weapon_name));
    struct.is_in_box = level.zombie_include_weapons[weapon];
    if (!isdefined(ammo_cost) || ammo_cost == 0) {
        ammo_cost = zm_utility::round_up_to_ten(int(cost * 0.5));
    }
    struct.ammo_cost = ammo_cost;
    if (weapon.isemp || isdefined(upgrade) && upgrade.isemp) {
        level.should_watch_for_emp = 1;
    }
    level.zombie_weapons[weapon] = struct;
    if (isdefined(create_vox)) {
    }
    /#
        if (isdefined(level.devgui_add_weapon) && (!is_ee || getdvarint(#"zm_debug_ee", 0))) {
            level thread [[ level.devgui_add_weapon ]](weapon, upgrade, in_box, cost, weaponvo, weaponvoresp, ammo_cost);
        }
    #/
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0x49538d93, Offset: 0x1c58
// Size: 0x56
function is_weapon_included(weapon) {
    if (!isdefined(level.zombie_weapons)) {
        return false;
    }
    weapon = get_nonalternate_weapon(weapon);
    return isdefined(level.zombie_weapons[function_386dacbc(weapon)]);
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0xc036dff5, Offset: 0x1cb8
// Size: 0x68
function is_weapon_or_base_included(weapon) {
    weapon = get_nonalternate_weapon(weapon);
    return isdefined(level.zombie_weapons[function_386dacbc(weapon)]) || isdefined(level.zombie_weapons[get_base_weapon(weapon)]);
}

// Namespace zm_weapons/zm_weapons
// Params 2, eflags: 0x1 linked
// Checksum 0x8694104e, Offset: 0x1d28
// Size: 0x94
function include_zombie_weapon(weapon_name, in_box) {
    if (!isdefined(level.zombie_include_weapons)) {
        level.zombie_include_weapons = [];
    }
    if (!isdefined(in_box)) {
        in_box = 1;
    }
    println("<dev string:x57>" + function_9e72a96(weapon_name));
    level.zombie_include_weapons[getweapon(weapon_name)] = in_box;
}

// Namespace zm_weapons/zm_weapons
// Params 0, eflags: 0x1 linked
// Checksum 0x6fc4fde1, Offset: 0x1dc8
// Size: 0x10e
function init_weapons() {
    level.var_c60359dc = [];
    var_8e01336 = getdvarint(#"hash_4fdf506c770b343", 0);
    switch (var_8e01336) {
    default:
        var_4ef031c9 = #"hash_2298893b58cc2885";
        break;
    }
    load_weapon_spec_from_table(var_4ef031c9, 0);
    if (isdefined(level.var_d0ab70a2)) {
        load_weapon_spec_from_table(level.var_d0ab70a2, 0);
    }
    level thread function_350ee41();
    level flag::set("zm_weapons_table_loaded");
    level.var_c60359dc = undefined;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x5 linked
// Checksum 0xbb40d18f, Offset: 0x1ee0
// Size: 0x120
function private function_a2ce802c(list) {
    var_ecce48b5 = [];
    s_bundle = getscriptbundle(list);
    foreach (s_item in s_bundle.itemlist) {
        if (!isdefined(var_ecce48b5)) {
            var_ecce48b5 = [];
        } else if (!isarray(var_ecce48b5)) {
            var_ecce48b5 = array(var_ecce48b5);
        }
        var_ecce48b5[var_ecce48b5.size] = s_item.var_a6762160;
    }
    level.var_4da246c[list] = arraycopy(var_ecce48b5);
}

// Namespace zm_weapons/zm_weapons
// Params 0, eflags: 0x5 linked
// Checksum 0x5de45a07, Offset: 0x2008
// Size: 0x578
function private function_350ee41() {
    if (!isdefined(level.var_4da246c)) {
        level.var_4da246c = [];
    }
    if (!isdefined(level.str_magicbox_weapon_itemspawnlist)) {
        level.str_magicbox_weapon_itemspawnlist = #"zm_magicbox_weapons_list";
    }
    if (!isdefined(level.var_e2f02558)) {
        level.var_e2f02558 = #"zm_magicbox_weapon_pistols_list";
    }
    if (!isdefined(level.var_430d4cfe)) {
        level.var_430d4cfe = #"zm_magicbox_weapon_shotgun_list";
    }
    if (!isdefined(level.var_3d802d78)) {
        level.var_3d802d78 = #"zm_magicbox_weapon_lmg_list";
    }
    if (!isdefined(level.var_5793d07d)) {
        level.var_5793d07d = #"zm_magicbox_weapon_smg_list";
    }
    if (!isdefined(level.var_5396aa34)) {
        level.var_5396aa34 = #"zm_magicbox_weapon_ar_list";
    }
    if (!isdefined(level.var_887d12df)) {
        level.var_887d12df = #"zm_magicbox_weapon_tr_list";
    }
    if (!isdefined(level.var_5cf89c5c)) {
        level.var_5cf89c5c = #"zm_magicbox_weapon_sniper_list";
    }
    if (!isdefined(level.var_95f4d593)) {
        level.var_95f4d593 = #"zm_magicbox_weapon_misc_list";
    }
    function_a2ce802c(level.var_e2f02558);
    function_a2ce802c(level.var_430d4cfe);
    function_a2ce802c(level.var_3d802d78);
    function_a2ce802c(level.var_5793d07d);
    function_a2ce802c(level.var_5396aa34);
    function_a2ce802c(level.var_887d12df);
    function_a2ce802c(level.var_5cf89c5c);
    function_a2ce802c(level.var_95f4d593);
    if (!isdefined(level.var_c0c63390)) {
        level.var_c0c63390 = [];
    }
    s_bundle = getscriptbundle(level.str_magicbox_weapon_itemspawnlist);
    totalweight = 0;
    foreach (s_item in s_bundle.itemlist) {
        totalweight += s_item.minweight;
        level.var_c0c63390[s_item.var_a6762160] = totalweight;
    }
    if (!isdefined(level.var_d6c88b25)) {
        level.var_d6c88b25 = "zm_magicbox_equipment_list";
    }
    s_bundle = getscriptbundle(level.var_d6c88b25);
    foreach (s_item in s_bundle.itemlist) {
        if (!isdefined(level.var_d93ad181)) {
            level.var_d93ad181 = [];
        } else if (!isarray(level.var_d93ad181)) {
            level.var_d93ad181 = array(level.var_d93ad181);
        }
        level.var_d93ad181[level.var_d93ad181.size] = s_item.var_a6762160;
    }
    if (!isdefined(level.str_magicbox_support_itemspawnlist)) {
        level.str_magicbox_support_itemspawnlist = "zm_magicbox_scorestreak_list";
    }
    s_bundle = getscriptbundle(level.str_magicbox_support_itemspawnlist);
    foreach (s_item in s_bundle.itemlist) {
        if (!isdefined(level.var_e5067476)) {
            level.var_e5067476 = [];
        } else if (!isarray(level.var_e5067476)) {
            level.var_e5067476 = array(level.var_e5067476);
        }
        level.var_e5067476[level.var_e5067476.size] = s_item.var_a6762160;
    }
}

// Namespace zm_weapons/zm_weapons
// Params 2, eflags: 0x1 linked
// Checksum 0x5d80fc0, Offset: 0x2588
// Size: 0x44
function add_limited_weapon(weapon_name, amount) {
    if (amount == 0) {
        return;
    }
    level.limited_weapons[getweapon(weapon_name)] = amount;
}

// Namespace zm_weapons/zm_weapons
// Params 2, eflags: 0x1 linked
// Checksum 0xdad03a33, Offset: 0x25d8
// Size: 0x480
function limited_weapon_below_quota(weapon, ignore_player) {
    if (isdefined(level.limited_weapons[weapon])) {
        pap_machines = undefined;
        if (!isdefined(pap_machines)) {
            pap_machines = getentarray("zm_pack_a_punch", "targetname");
        }
        if (is_true(level.no_limited_weapons)) {
            return false;
        }
        upgradedweapon = weapon;
        if (isdefined(level.zombie_weapons[weapon]) && isdefined(level.zombie_weapons[weapon].upgrade)) {
            upgradedweapon = level.zombie_weapons[weapon].upgrade;
        }
        players = getplayers();
        count = 0;
        limit = level.limited_weapons[weapon];
        for (i = 0; i < players.size; i++) {
            if (isdefined(ignore_player) && ignore_player == players[i]) {
                continue;
            }
            if (players[i] has_weapon_or_upgrade(weapon)) {
                count++;
                if (count >= limit) {
                    return false;
                }
            }
        }
        foreach (machine in pap_machines) {
            if (!isdefined(machine)) {
                continue;
            }
            if (!isdefined(machine.unitrigger_stub)) {
                continue;
            }
            if (isdefined(machine.unitrigger_stub.current_weapon) && (machine.unitrigger_stub.current_weapon == weapon || machine.unitrigger_stub.current_weapon == upgradedweapon)) {
                count++;
                if (count >= limit) {
                    return false;
                }
            }
        }
        foreach (chest in level.chests) {
            if (!isdefined(chest)) {
                continue;
            }
            if (!isdefined(chest.zbarrier)) {
                continue;
            }
            if (isdefined(chest.zbarrier.weapon) && chest.zbarrier.weapon == weapon) {
                count++;
                if (count >= limit) {
                    return false;
                }
            }
        }
        if (isdefined(level.custom_limited_weapon_checks)) {
            foreach (check in level.custom_limited_weapon_checks) {
                count += [[ check ]](weapon);
            }
            if (count >= limit) {
                return false;
            }
        }
        if (isdefined(level.random_weapon_powerups)) {
            for (powerupindex = 0; powerupindex < level.random_weapon_powerups.size; powerupindex++) {
                if (isdefined(level.random_weapon_powerups[powerupindex]) && level.random_weapon_powerups[powerupindex].base_weapon == weapon) {
                    count++;
                    if (count >= limit) {
                        return false;
                    }
                }
            }
        }
    }
    return true;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x82df7e4c, Offset: 0x2a60
// Size: 0x44
function add_custom_limited_weapon_check(callback) {
    if (!isdefined(level.custom_limited_weapon_checks)) {
        level.custom_limited_weapon_checks = [];
    }
    level.custom_limited_weapon_checks[level.custom_limited_weapon_checks.size] = callback;
}

// Namespace zm_weapons/zm_weapons
// Params 2, eflags: 0x0
// Checksum 0x6ec06afe, Offset: 0x2ab0
// Size: 0x54
function add_weapon_to_content(weapon_name, package) {
    if (!isdefined(level.content_weapons)) {
        level.content_weapons = [];
    }
    level.content_weapons[getweapon(weapon_name)] = package;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0x45d8694c, Offset: 0x2b10
// Size: 0x58
function player_can_use_content(weapon) {
    if (isdefined(level.content_weapons)) {
        if (isdefined(level.content_weapons[weapon])) {
            return self hasdlcavailable(level.content_weapons[weapon]);
        }
    }
    return 1;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0xc04a4f25, Offset: 0x2b70
// Size: 0x72
function get_weapon_hint(weapon) {
    assert(isdefined(level.zombie_weapons[weapon]), function_9e72a96(weapon.name) + "<dev string:x74>");
    return level.zombie_weapons[weapon].hint;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0xcfccfa38, Offset: 0x2bf0
// Size: 0x72
function get_weapon_cost(weapon) {
    assert(isdefined(level.zombie_weapons[weapon]), function_9e72a96(weapon.name) + "<dev string:x74>");
    return level.zombie_weapons[weapon].cost;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0x4bc0837a, Offset: 0x2c70
// Size: 0x154
function function_5d47055e(var_13f9dee7) {
    switch (var_13f9dee7) {
    case #"resource":
    case #"none":
    case #"white":
    case #"loadout":
        return 0;
    case #"green":
    case #"uncommon":
        return 250;
    case #"blue":
    case #"rare":
        return 500;
    case #"purple":
    case #"epic":
        return 750;
    case #"yellow":
    case #"ultra":
    case #"gold":
    case #"orange":
    case #"named":
    case #"legendary":
        return 1000;
    }
    return 0;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0x6030a6f5, Offset: 0x2dd0
// Size: 0x72
function get_ammo_cost(weapon) {
    assert(isdefined(level.zombie_weapons[weapon]), function_9e72a96(weapon.name) + "<dev string:x74>");
    return level.zombie_weapons[weapon].ammo_cost;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x76c117fa, Offset: 0x2e50
// Size: 0x94
function get_upgraded_ammo_cost(weapon) {
    assert(isdefined(level.zombie_weapons[weapon]), function_9e72a96(weapon.name) + "<dev string:x74>");
    if (isdefined(level.zombie_weapons[weapon].upgraded_ammo_cost)) {
        return level.zombie_weapons[weapon].upgraded_ammo_cost;
    }
    return 4500;
}

// Namespace zm_weapons/zm_weapons
// Params 3, eflags: 0x0
// Checksum 0xfa936fef, Offset: 0x2ef0
// Size: 0x13e
function get_ammo_cost_for_weapon(w_current, n_base_non_wallbuy_cost = 750, n_upgraded_non_wallbuy_cost = 5000) {
    w_root = function_386dacbc(w_current);
    if (is_weapon_upgraded(w_root)) {
        w_root = get_base_weapon(w_root);
    }
    if (self has_upgrade(w_root)) {
        if (zm_wallbuy::is_wallbuy(w_root)) {
            n_ammo_cost = 4000;
        } else {
            n_ammo_cost = n_upgraded_non_wallbuy_cost;
        }
    } else if (zm_wallbuy::is_wallbuy(w_root)) {
        n_ammo_cost = get_ammo_cost(w_root);
        n_ammo_cost = zm_utility::halve_score(n_ammo_cost);
    } else {
        n_ammo_cost = n_base_non_wallbuy_cost;
    }
    return n_ammo_cost;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xdb317451, Offset: 0x3038
// Size: 0x5a
function get_is_in_box(weapon) {
    assert(isdefined(level.zombie_weapons[weapon]), weapon.name + "<dev string:x74>");
    return level.zombie_weapons[weapon].is_in_box;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0xe93487b6, Offset: 0x30a0
// Size: 0x74
function function_603af7a8(weapon) {
    if (isdefined(level.zombie_weapons[weapon])) {
        level.zombie_weapons[weapon].is_in_box = 1;
    }
    /#
        level thread zm_devgui::function_bcc8843e(getweaponname(weapon), "<dev string:xb3>", "<dev string:xb3>");
    #/
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x543cef36, Offset: 0x3120
// Size: 0x3e
function function_f1114209(weapon) {
    if (isdefined(level.zombie_weapons[weapon])) {
        level.zombie_weapons[weapon].is_in_box = 0;
    }
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xb080a622, Offset: 0x3168
// Size: 0x4a
function weapon_supports_default_attachment(weapon) {
    weapon = get_base_weapon(weapon);
    attachment = level.zombie_weapons[weapon].default_attachment;
    return isdefined(attachment);
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x2dcb5040, Offset: 0x31c0
// Size: 0x60
function default_attachment(weapon) {
    weapon = get_base_weapon(weapon);
    attachment = level.zombie_weapons[weapon].default_attachment;
    if (isdefined(attachment)) {
        return attachment;
    }
    return "none";
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x1cdc03cd, Offset: 0x3228
// Size: 0x5c
function weapon_supports_attachments(weapon) {
    weapon = get_base_weapon(weapon);
    attachments = level.zombie_weapons[weapon].addon_attachments;
    return isdefined(attachments) && attachments.size > 1;
}

// Namespace zm_weapons/zm_weapons
// Params 2, eflags: 0x0
// Checksum 0x3ef8cd62, Offset: 0x3290
// Size: 0x142
function random_attachment(weapon, exclude) {
    lo = 0;
    if (isdefined(level.zombie_weapons[weapon].addon_attachments) && level.zombie_weapons[weapon].addon_attachments.size > 0) {
        attachments = level.zombie_weapons[weapon].addon_attachments;
    } else {
        attachments = weapon.supportedattachments;
        lo = 1;
    }
    minatt = lo;
    if (isdefined(exclude) && exclude != "none") {
        minatt = lo + 1;
    }
    if (attachments.size > minatt) {
        while (true) {
            idx = randomint(attachments.size - lo) + lo;
            if (!isdefined(exclude) || attachments[idx] != exclude) {
                return attachments[idx];
            }
        }
    }
    return "none";
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x9fccd942, Offset: 0x33e0
// Size: 0x138
function get_attachment_index(weapon) {
    attachments = weapon.attachments;
    if (!attachments.size) {
        return -1;
    }
    weapon = get_nonalternate_weapon(weapon);
    base = function_386dacbc(weapon);
    if (attachments[0] === level.zombie_weapons[base].default_attachment) {
        return 0;
    }
    if (isdefined(level.zombie_weapons[base].addon_attachments)) {
        for (i = 0; i < level.zombie_weapons[base].addon_attachments.size; i++) {
            if (level.zombie_weapons[base].addon_attachments[i] == attachments[0]) {
                return (i + 1);
            }
        }
    }
    println("<dev string:xb7>" + weapon.name);
    return -1;
}

// Namespace zm_weapons/zm_weapons
// Params 2, eflags: 0x0
// Checksum 0x289e4eb0, Offset: 0x3520
// Size: 0xe2
function weapon_supports_this_attachment(weapon, att) {
    weapon = get_nonalternate_weapon(weapon);
    base = function_386dacbc(weapon);
    if (att == level.zombie_weapons[base].default_attachment) {
        return true;
    }
    if (isdefined(level.zombie_weapons[base].addon_attachments)) {
        for (i = 0; i < level.zombie_weapons[base].addon_attachments.size; i++) {
            if (level.zombie_weapons[base].addon_attachments[i] == att) {
                return true;
            }
        }
    }
    return false;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0x366692f, Offset: 0x3610
// Size: 0x66
function get_base_weapon(upgradedweapon) {
    upgradedweapon = get_nonalternate_weapon(upgradedweapon);
    upgradedweapon = function_386dacbc(upgradedweapon);
    if (isdefined(level.zombie_weapons_upgraded[upgradedweapon])) {
        return level.zombie_weapons_upgraded[upgradedweapon];
    }
    return upgradedweapon;
}

// Namespace zm_weapons/zm_weapons
// Params 2, eflags: 0x1 linked
// Checksum 0x97702d3e, Offset: 0x3680
// Size: 0x1d2
function get_upgrade_weapon(weapon, *add_attachment) {
    add_attachment = get_nonalternate_weapon(add_attachment);
    rootweapon = function_386dacbc(add_attachment);
    newweapon = rootweapon;
    baseweapon = get_base_weapon(add_attachment);
    if (!is_weapon_upgraded(rootweapon) && isdefined(level.zombie_weapons[rootweapon])) {
        newweapon = level.zombie_weapons[rootweapon].upgrade;
    } else if (!zm_custom::function_901b751c(#"zmsuperpapenabled")) {
        return add_attachment;
    }
    /#
        if (isdefined(self.var_8d5839f4) && isinarray(self.var_8d5839f4, add_attachment) && add_attachment.attachments.size) {
            newweapon = getweapon(newweapon.name, add_attachment.attachments);
            return newweapon;
        }
    #/
    if (isdefined(level.zombie_weapons[rootweapon]) && isdefined(level.zombie_weapons[rootweapon].default_attachment)) {
        att = level.zombie_weapons[rootweapon].default_attachment;
        newweapon = getweapon(newweapon.name, att);
    }
    return newweapon;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0xe6937c34, Offset: 0x3860
// Size: 0xe2
function can_upgrade_weapon(weapon) {
    if (weapon == level.weaponnone || weapon == level.weaponzmfists || !is_weapon_included(weapon)) {
        return false;
    }
    weapon = get_nonalternate_weapon(weapon);
    rootweapon = function_386dacbc(weapon);
    if (!is_weapon_upgraded(rootweapon)) {
        upgraded_weapon = level.zombie_weapons[rootweapon].upgrade;
        return (isdefined(upgraded_weapon) && upgraded_weapon != level.weaponnone);
    }
    return false;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0xf1637f7b, Offset: 0x3950
// Size: 0xa6
function weapon_supports_aat(weapon) {
    if (!zm_custom::function_901b751c(#"zmsuperpapenabled")) {
        return false;
    }
    if (!isdefined(weapon)) {
        return false;
    }
    if (weapon == level.weaponnone || weapon == level.weaponzmfists) {
        return false;
    }
    weapontopack = get_nonalternate_weapon(weapon);
    if (!aat::is_exempt_weapon(weapontopack)) {
        return true;
    }
    return false;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0x7d922bba, Offset: 0x3a00
// Size: 0x9a
function is_weapon_upgraded(weapon) {
    if (!isdefined(weapon)) {
        return false;
    }
    if (weapon == level.weaponnone || weapon == level.weaponzmfists) {
        return false;
    }
    weapon = get_nonalternate_weapon(weapon);
    rootweapon = function_386dacbc(weapon);
    if (isdefined(level.zombie_weapons_upgraded[rootweapon])) {
        return true;
    }
    return false;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0x202b43d6, Offset: 0x3aa8
// Size: 0xbe
function get_weapon_with_attachments(weapon) {
    weapon = get_nonalternate_weapon(weapon);
    rootweapon = function_386dacbc(weapon);
    if (self has_weapon_or_attachments(rootweapon)) {
        /#
            if (isdefined(self.var_8d5839f4) && isinarray(self.var_8d5839f4, weapon) && weapon.attachments.size) {
                return weapon;
            }
        #/
        return self getbuildkitweapon(rootweapon);
    }
    return undefined;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0x162d6bc6, Offset: 0x3b70
// Size: 0xd6
function has_weapon_or_attachments(weapon) {
    primaryweapon = self namespace_a0d533d1::function_2b83d3ff(self item_inventory::function_2e711614(17 + 1));
    secondaryweapon = self namespace_a0d533d1::function_2b83d3ff(self item_inventory::function_2e711614(17 + 1 + 8 + 1));
    primaryweapon = primaryweapon.rootweapon;
    secondaryweapon = secondaryweapon.rootweapon;
    if (weapon.rootweapon === primaryweapon || weapon.rootweapon === secondaryweapon) {
        return true;
    }
    return false;
}

// Namespace zm_weapons/zm_weapons
// Params 2, eflags: 0x1 linked
// Checksum 0x2d85ba9e, Offset: 0x3c50
// Size: 0x34
function function_40d216ce(currentweapon, weapon) {
    if (currentweapon.rootweapon === weapon.rootweapon) {
        return true;
    }
    return false;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0x1d1ca99, Offset: 0x3c90
// Size: 0x4c
function function_386dacbc(weapon) {
    rootweapon = weapon.rootweapon;
    if (isdefined(level.var_44e0d625[rootweapon])) {
        rootweapon = level.var_44e0d625[rootweapon];
    }
    return rootweapon;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0xdc0be236, Offset: 0x3ce8
// Size: 0xb2
function has_upgrade(weapon) {
    weapon = get_nonalternate_weapon(weapon);
    rootweapon = function_386dacbc(weapon);
    has_upgrade = 0;
    if (isdefined(level.zombie_weapons[rootweapon]) && isdefined(level.zombie_weapons[rootweapon].upgrade)) {
        has_upgrade = self has_weapon_or_attachments(level.zombie_weapons[rootweapon].upgrade);
    }
    return has_upgrade;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0x9562261f, Offset: 0x3da8
// Size: 0x132
function has_weapon_or_upgrade(weapon) {
    weapon = get_nonalternate_weapon(weapon);
    rootweapon = function_386dacbc(weapon);
    upgradedweaponname = rootweapon;
    if (isdefined(level.zombie_weapons[rootweapon]) && isdefined(level.zombie_weapons[rootweapon].upgrade)) {
        upgradedweaponname = level.zombie_weapons[rootweapon].upgrade;
    }
    has_weapon = 0;
    if (isdefined(level.zombie_weapons[rootweapon])) {
        has_weapon = self has_weapon_or_attachments(rootweapon) || self has_upgrade(rootweapon);
    }
    if (!has_weapon && zm_equipment::is_equipment(rootweapon)) {
        has_weapon = self zm_equipment::is_active(rootweapon);
    }
    return has_weapon;
}

// Namespace zm_weapons/zm_weapons
// Params 2, eflags: 0x0
// Checksum 0xe9e9bc29, Offset: 0x3ee8
// Size: 0x2e
function add_shared_ammo_weapon(weapon, base_weapon) {
    level.zombie_weapons[weapon].shared_ammo_weapon = base_weapon;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0x11da5bc1, Offset: 0x3f20
// Size: 0x186
function get_shared_ammo_weapon(weapon) {
    weapon = get_nonalternate_weapon(weapon);
    rootweapon = function_386dacbc(weapon);
    weapons = self getweaponslist(1);
    foreach (w in weapons) {
        w = function_386dacbc(w);
        if (!isdefined(level.zombie_weapons[w]) && isdefined(level.zombie_weapons_upgraded[w])) {
            w = level.zombie_weapons_upgraded[w];
        }
        if (isdefined(level.zombie_weapons[w]) && isdefined(level.zombie_weapons[w].shared_ammo_weapon) && level.zombie_weapons[w].shared_ammo_weapon == rootweapon) {
            return w;
        }
    }
    return undefined;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0xd1936cd4, Offset: 0x40b0
// Size: 0x132
function get_player_weapon_with_same_base(weapon) {
    if (isdefined(level.var_ee565b3f)) {
        retweapon = [[ level.var_ee565b3f ]](weapon);
        if (isdefined(retweapon)) {
            return retweapon;
        }
    }
    weapon = get_nonalternate_weapon(weapon);
    rootweapon = function_386dacbc(weapon);
    retweapon = self get_weapon_with_attachments(rootweapon);
    if (!isdefined(retweapon)) {
        if (isdefined(level.zombie_weapons[rootweapon])) {
            if (isdefined(level.zombie_weapons[rootweapon].upgrade)) {
                retweapon = self get_weapon_with_attachments(level.zombie_weapons[rootweapon].upgrade);
            }
        } else if (isdefined(level.zombie_weapons_upgraded[rootweapon])) {
            retweapon = self get_weapon_with_attachments(level.zombie_weapons_upgraded[rootweapon]);
        }
    }
    return retweapon;
}

// Namespace zm_weapons/zm_weapons
// Params 0, eflags: 0x1 linked
// Checksum 0x1d5202fe, Offset: 0x41f0
// Size: 0x12
function get_weapon_hint_ammo() {
    return #"hash_60606b68e93a29c8";
}

// Namespace zm_weapons/zm_weapons
// Params 2, eflags: 0x0
// Checksum 0xcd320e0e, Offset: 0x4210
// Size: 0x3c
function weapon_set_first_time_hint(*cost, *ammo_cost) {
    self sethintstring(get_weapon_hint_ammo());
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xb493a11f, Offset: 0x4258
// Size: 0x194
function get_pack_a_punch_weapon_options(weapon) {
    if (!isdefined(self.pack_a_punch_weapon_options)) {
        self.pack_a_punch_weapon_options = [];
    }
    if (!is_weapon_upgraded(weapon)) {
        return self function_6eff28b5(0, 0, 0);
    }
    if (isdefined(self.pack_a_punch_weapon_options[weapon])) {
        return self.pack_a_punch_weapon_options[weapon];
    }
    camo_index = self zm_camos::function_4f727cf5(weapon);
    reticle_index = randomintrange(0, 16);
    var_eb2e3f90 = 0;
    plain_reticle_index = 16;
    use_plain = randomint(10) < 1;
    if (use_plain) {
        reticle_index = plain_reticle_index;
    }
    /#
        if (getdvarint(#"scr_force_reticle_index", 0) >= 0) {
            reticle_index = getdvarint(#"scr_force_reticle_index", 0);
        }
    #/
    self.pack_a_punch_weapon_options[weapon] = self function_6eff28b5(camo_index, reticle_index, var_eb2e3f90);
    return self.pack_a_punch_weapon_options[weapon];
}

// Namespace zm_weapons/zm_weapons
// Params 0, eflags: 0x0
// Checksum 0xc43c9417, Offset: 0x43f8
// Size: 0x10c
function function_17512fb3() {
    lethal_grenade = self zm_loadout::get_player_lethal_grenade();
    if (!self hasweapon(lethal_grenade)) {
        self giveweapon(lethal_grenade);
        self setweaponammoclip(lethal_grenade, 0);
    }
    frac = self getfractionmaxammo(lethal_grenade);
    if (frac < 0.25) {
        self setweaponammoclip(lethal_grenade, 2);
        return;
    }
    if (frac < 0.5) {
        self setweaponammoclip(lethal_grenade, 3);
        return;
    }
    self setweaponammoclip(lethal_grenade, 4);
}

// Namespace zm_weapons/zm_weapons
// Params 4, eflags: 0x1 linked
// Checksum 0xe7198f8, Offset: 0x4510
// Size: 0x52
function give_build_kit_weapon(weapon, var_51ec4e93, var_bd5d43c6, b_switch_weapon = 1) {
    return weapon_give(weapon, 0, b_switch_weapon, var_51ec4e93, var_bd5d43c6);
}

// Namespace zm_weapons/zm_weapons
// Params 3, eflags: 0x1 linked
// Checksum 0x4decce70, Offset: 0x4570
// Size: 0x32c
function function_98776900(item, nosound = 0, var_ac6e9818 = 0) {
    if (item.var_a6762160.itemtype !== #"weapon") {
        return;
    }
    if (!item_world_util::function_d9648161(item.networkid)) {
        println("<dev string:xee>" + (isdefined(item.var_a6762160.name) ? item.var_a6762160.name : "<dev string:x11f>"));
        return;
    }
    if (!is_true(nosound)) {
        self zm_utility::play_sound_on_ent("purchase");
    }
    if (isentity(item) && isdefined(item.var_627c698b.attachments) && !isdefined(item.attachments)) {
        attachments = item.var_627c698b.attachments;
        foreach (attachment in attachments) {
            var_41ade915 = item_world_util::function_6a0ee21a(attachment);
            attachmentitem = function_4ba8fde(var_41ade915);
            if (isdefined(attachmentitem)) {
                namespace_a0d533d1::function_8b7b98f(item, attachmentitem);
            }
        }
    }
    if (var_ac6e9818) {
        var_db0dca92 = self item_inventory::get_weapon_count();
        w_current = self getcurrentweapon();
        if (var_db0dca92 == zm_utility::get_player_weapon_limit(self)) {
            self weapon_take(w_current);
        }
    }
    var_fa3df96 = self item_inventory::function_e66dcff5(item);
    if (isdefined(var_fa3df96)) {
        if (!item_world_util::function_db35e94f(item.networkid)) {
            item.networkid = item_world_util::function_970b8d86(var_fa3df96);
        }
        self item_world::function_de2018e3(item, self, var_fa3df96);
    }
}

// Namespace zm_weapons/zm_weapons
// Params 7, eflags: 0x1 linked
// Checksum 0xfd982ca0, Offset: 0x48a8
// Size: 0x388
function weapon_give(weapon, nosound, *b_switch_weapon, *var_51ec4e93, *var_bd5d43c6 = 0, var_823339c8 = #"none", var_1b46b4cb) {
    if (!is_true(var_bd5d43c6)) {
        self zm_utility::play_sound_on_ent("purchase");
    }
    if (isweapon(var_51ec4e93)) {
        if (is_weapon_upgraded(var_51ec4e93)) {
            var_e05f8872 = var_51ec4e93.name + "_zm_item";
        } else if (var_823339c8 != #"none" && isdefined(level.var_29d88fe5[var_51ec4e93.name][var_823339c8])) {
            var_e05f8872 = level.var_29d88fe5[var_51ec4e93.name][var_823339c8];
        } else if (var_51ec4e93.name == #"knife_loadout") {
            var_e05f8872 = var_51ec4e93.name + "_t9" + "_item_sr";
        } else {
            var_e05f8872 = var_51ec4e93.name + "_item_sr";
        }
    }
    var_3383cd4e = function_4ba8fde(var_e05f8872);
    if (isdefined(var_3383cd4e)) {
        if (isarray(var_1b46b4cb)) {
            foreach (var_b0f63180 in var_1b46b4cb) {
                var_67419ad4 = item_world_util::function_6a0ee21a(var_b0f63180);
                var_5b788df2 = function_4ba8fde(var_67419ad4);
                namespace_a0d533d1::function_9e9c82a6(var_3383cd4e, var_5b788df2, 1);
            }
        }
        var_fa3df96 = self item_inventory::function_e66dcff5(var_3383cd4e);
        if (isdefined(var_fa3df96)) {
            if (!item_world_util::function_db35e94f(var_3383cd4e.networkid)) {
                var_3383cd4e.networkid = item_world_util::function_970b8d86(var_fa3df96);
            }
            self item_world::function_de2018e3(var_3383cd4e, self, var_fa3df96);
        }
    } else {
        self giveweapon(var_51ec4e93);
        self switchtoweapon(var_51ec4e93);
    }
    if (!is_true(var_bd5d43c6)) {
        self play_weapon_vo(var_51ec4e93);
    }
    return var_51ec4e93;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0xa8c07bb5, Offset: 0x4c38
// Size: 0xc4
function weapon_take(weapon) {
    if (self hasweapon(weapon)) {
        var_8a83ec7a = item_inventory::function_a33744de(weapon);
        if (isdefined(var_8a83ec7a)) {
            if (var_8a83ec7a != 32767) {
                var_f9f12a82 = item_inventory::drop_inventory_item(var_8a83ec7a);
                if (isentity(var_f9f12a82)) {
                    item_world::consume_item(var_f9f12a82);
                }
            }
            return;
        }
        self takeweapon(weapon);
    }
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0x43a16932, Offset: 0x4d08
// Size: 0x274
function play_weapon_vo(weapon) {
    if (isdefined(level.var_d99d49fd)) {
        result = self [[ level.var_d99d49fd ]](weapon);
        if (result) {
            return;
        }
    }
    if (isdefined(level._audio_custom_weapon_check)) {
        type = self [[ level._audio_custom_weapon_check ]](weapon);
    } else {
        type = self weapon_type_check(weapon);
    }
    if (!isdefined(type)) {
        return;
    }
    if (isdefined(level.sndweaponpickupoverride)) {
        foreach (override in level.sndweaponpickupoverride) {
            if (type === override) {
                self zm_audio::create_and_play_dialog(#"weapon_pickup", override);
                return;
            }
        }
    }
    if (is_true(self.var_966bfd1b)) {
        self.var_966bfd1b = 0;
        self zm_audio::create_and_play_dialog(#"magicbox", type);
        return;
    }
    if (type == "upgrade") {
        self zm_audio::create_and_play_dialog(#"weapon_pickup", #"upgrade");
        return;
    }
    if (randomintrange(0, 100) <= 75 || type == "shield") {
        self zm_audio::create_and_play_dialog(#"weapon_pickup", type);
        return;
    }
    self zm_audio::create_and_play_dialog(#"weapon_pickup", #"generic");
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0x5af43a3e, Offset: 0x4f88
// Size: 0xcc
function weapon_type_check(weapon) {
    if (!isdefined(self.entity_num)) {
        return "crappy";
    }
    weapon = get_nonalternate_weapon(weapon);
    weapon = function_386dacbc(weapon);
    if (is_weapon_upgraded(weapon) && !self bgb::is_enabled(#"zm_bgb_wall_power")) {
        return "upgrade";
    }
    if (isdefined(level.zombie_weapons[weapon])) {
        return level.zombie_weapons[weapon].vox;
    }
    return "crappy";
}

// Namespace zm_weapons/zm_weapons
// Params 2, eflags: 0x1 linked
// Checksum 0x8e416d31, Offset: 0x5060
// Size: 0x2a6
function ammo_give(weapon, b_purchased = 1) {
    var_cd9d17e0 = 0;
    if (!zm_loadout::is_offhand_weapon(weapon) || weapon.isriotshield) {
        weapon = self get_weapon_with_attachments(weapon);
        if (isdefined(weapon)) {
            var_cb48c3c9 = weapon.maxammo;
            var_ef0714fa = weapon.startammo;
            var_98f6dae8 = self getweaponammoclip(weapon);
            n_clip_size = weapon.clipsize;
            if (var_98f6dae8 < n_clip_size) {
                var_cd9d17e0 = 1;
            }
            var_4052eae0 = 0;
            if (!var_cd9d17e0 && weapon.dualwieldweapon != level.weaponnone) {
                var_4052eae0 = self getweaponammoclip(weapon.dualwieldweapon);
                var_5916b9ab = weapon.dualwieldweapon.clipsize;
                if (var_4052eae0 < var_5916b9ab) {
                    var_cd9d17e0 = 1;
                }
            }
            if (!var_cd9d17e0) {
                var_b8624c26 = self getammocount(weapon);
                if (self hasperk(#"specialty_extraammo")) {
                    n_ammo_max = var_cb48c3c9;
                } else {
                    n_ammo_max = var_ef0714fa;
                }
                if (weapon.isdualwield) {
                    n_ammo_max *= 2;
                }
                if (var_b8624c26 >= n_ammo_max + var_98f6dae8 + var_4052eae0) {
                    var_cd9d17e0 = 0;
                } else {
                    var_cd9d17e0 = 1;
                }
            }
        }
    } else if (self has_weapon_or_upgrade(weapon)) {
        if (self getammocount(weapon) < weapon.maxammo) {
            var_cd9d17e0 = 1;
        }
    }
    if (var_cd9d17e0) {
        if (b_purchased) {
            self zm_utility::play_sound_on_ent("purchase");
        }
        self function_7c5dd4bd(weapon);
        return 1;
    }
    if (!var_cd9d17e0) {
        return 0;
    }
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0xee22a129, Offset: 0x5310
// Size: 0x1f4
function get_default_weapondata(weapon) {
    weapondata = [];
    weapondata[#"weapon"] = weapon;
    dw_weapon = weapon.dualwieldweapon;
    alt_weapon = weapon.altweapon;
    weaponnone = getweapon(#"none");
    if (isdefined(level.weaponnone)) {
        weaponnone = level.weaponnone;
    }
    if (weapon != weaponnone) {
        weapondata[#"clip"] = weapon.clipsize;
        weapondata[#"stock"] = weapon.maxammo;
        weapondata[#"fuel"] = weapon.fuellife;
        weapondata[#"heat"] = 0;
        weapondata[#"overheat"] = 0;
    }
    if (dw_weapon != weaponnone) {
        weapondata[#"lh_clip"] = dw_weapon.clipsize;
    } else {
        weapondata[#"lh_clip"] = 0;
    }
    if (alt_weapon != weaponnone) {
        weapondata[#"alt_clip"] = alt_weapon.clipsize;
        weapondata[#"alt_stock"] = alt_weapon.maxammo;
    } else {
        weapondata[#"alt_clip"] = 0;
        weapondata[#"alt_stock"] = 0;
    }
    return weapondata;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0xfd0e0c6a, Offset: 0x5510
// Size: 0x3d4
function get_player_weapondata(weapon) {
    weapondata = [];
    if (!isdefined(weapon)) {
        weapon = self getcurrentweapon();
    }
    weapondata[#"weapon"] = weapon;
    if (weapondata[#"weapon"] != level.weaponnone) {
        weapondata[#"clip"] = self getweaponammoclip(weapon);
        weapondata[#"stock"] = self getweaponammostock(weapon);
        weapondata[#"fuel"] = self getweaponammofuel(weapon);
        weapondata[#"heat"] = self isweaponoverheating(1, weapon);
        weapondata[#"overheat"] = self isweaponoverheating(0, weapon);
        if (weapon.isgadget) {
            slot = self gadgetgetslot(weapon);
            weapondata[#"power"] = self gadgetpowerget(slot);
        }
        if (weapon.isriotshield) {
            weapondata[#"health"] = self.weaponhealth;
        }
    } else {
        weapondata[#"clip"] = 0;
        weapondata[#"stock"] = 0;
        weapondata[#"fuel"] = 0;
        weapondata[#"heat"] = 0;
        weapondata[#"overheat"] = 0;
        weapondata[#"power"] = undefined;
    }
    dw_weapon = weapon.dualwieldweapon;
    if (dw_weapon != level.weaponnone) {
        weapondata[#"lh_clip"] = self getweaponammoclip(dw_weapon);
    } else {
        weapondata[#"lh_clip"] = 0;
    }
    alt_weapon = weapon.altweapon;
    if (alt_weapon != level.weaponnone) {
        weapondata[#"alt_clip"] = self getweaponammoclip(alt_weapon);
        weapondata[#"alt_stock"] = self getweaponammostock(alt_weapon);
    } else {
        weapondata[#"alt_clip"] = 0;
        weapondata[#"alt_stock"] = 0;
    }
    if (self aat::has_aat(weapon)) {
        weapondata[#"aat"] = self aat::getaatonweapon(weapon, 1);
    }
    weapondata[#"repacks"] = self zm_pap_util::function_83c29ddb(weapon);
    return weapondata;
}

// Namespace zm_weapons/zm_weapons
// Params 2, eflags: 0x1 linked
// Checksum 0x8e2c1bbf, Offset: 0x58f0
// Size: 0x6e
function weapon_is_better(left, right) {
    if (left != right) {
        left_upgraded = is_weapon_upgraded(left);
        right_upgraded = is_weapon_upgraded(right);
        if (left_upgraded) {
            return true;
        }
    }
    return false;
}

// Namespace zm_weapons/zm_weapons
// Params 2, eflags: 0x1 linked
// Checksum 0x7d80afd3, Offset: 0x5968
// Size: 0x5ac
function merge_weapons(oldweapondata, newweapondata) {
    weapondata = [];
    if (isdefined(level.var_bb2323e4)) {
        weapondata = [[ level.var_bb2323e4 ]](oldweapondata, newweapondata);
        if (isdefined(weapondata)) {
            return weapondata;
        }
    }
    if (weapon_is_better(oldweapondata[#"weapon"], newweapondata[#"weapon"])) {
        weapondata[#"weapon"] = oldweapondata[#"weapon"];
    } else {
        weapondata[#"weapon"] = newweapondata[#"weapon"];
    }
    weapon = weapondata[#"weapon"];
    dw_weapon = weapon.dualwieldweapon;
    alt_weapon = weapon.altweapon;
    if (weapon != level.weaponnone) {
        weapondata[#"clip"] = newweapondata[#"clip"] + oldweapondata[#"clip"];
        weapondata[#"clip"] = int(min(weapondata[#"clip"], weapon.clipsize));
        weapondata[#"stock"] = newweapondata[#"stock"] + oldweapondata[#"stock"];
        weapondata[#"stock"] = int(min(weapondata[#"stock"], weapon.maxammo));
        weapondata[#"fuel"] = newweapondata[#"fuel"] + oldweapondata[#"fuel"];
        weapondata[#"fuel"] = int(min(weapondata[#"fuel"], weapon.fuellife));
        weapondata[#"heat"] = int(min(newweapondata[#"heat"], oldweapondata[#"heat"]));
        weapondata[#"overheat"] = int(min(newweapondata[#"overheat"], oldweapondata[#"overheat"]));
        weapondata[#"power"] = int(max(isdefined(newweapondata[#"power"]) ? newweapondata[#"power"] : 0, isdefined(oldweapondata[#"power"]) ? oldweapondata[#"power"] : 0));
    }
    if (dw_weapon != level.weaponnone) {
        weapondata[#"lh_clip"] = newweapondata[#"lh_clip"] + oldweapondata[#"lh_clip"];
        weapondata[#"lh_clip"] = int(min(weapondata[#"lh_clip"], dw_weapon.clipsize));
    }
    if (alt_weapon != level.weaponnone) {
        weapondata[#"alt_clip"] = newweapondata[#"alt_clip"] + oldweapondata[#"alt_clip"];
        weapondata[#"alt_clip"] = int(min(weapondata[#"alt_clip"], alt_weapon.clipsize));
        weapondata[#"alt_stock"] = newweapondata[#"alt_stock"] + oldweapondata[#"alt_stock"];
        weapondata[#"alt_stock"] = int(min(weapondata[#"alt_stock"], alt_weapon.maxammo));
    }
    return weapondata;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0x5d5e3c67, Offset: 0x5f20
// Size: 0x4f0
function weapondata_give(weapondata) {
    current = self get_player_weapon_with_same_base(weapondata[#"weapon"]);
    if (isdefined(current)) {
        curweapondata = self get_player_weapondata(current);
        self weapon_take(current);
        weapondata = merge_weapons(curweapondata, weapondata);
    }
    weapon = weapondata[#"weapon"];
    weapon_give(weapon, 1);
    if (weapon != level.weaponnone) {
        if (weapondata[#"clip"] + weapondata[#"stock"] <= weapon.clipsize) {
            self setweaponammoclip(weapon, weapon.clipsize);
            self setweaponammostock(weapon, 0);
        } else {
            self setweaponammoclip(weapon, weapondata[#"clip"]);
            self setweaponammostock(weapon, weapondata[#"stock"]);
        }
        if (isdefined(weapondata[#"fuel"])) {
            self setweaponammofuel(weapon, weapondata[#"fuel"]);
        }
        if (isdefined(weapondata[#"heat"]) && isdefined(weapondata[#"overheat"])) {
            self setweaponoverheating(weapondata[#"overheat"], weapondata[#"heat"], weapon);
        }
        if (weapon.isgadget && isdefined(weapondata[#"power"])) {
            slot = self gadgetgetslot(weapon);
            if (slot >= 0) {
                self gadgetpowerset(slot, weapondata[#"power"]);
            }
        }
        if (weapon.isriotshield && isdefined(weapondata[#"health"])) {
            self.weaponhealth = weapondata[#"health"];
        }
    }
    dw_weapon = weapon.dualwieldweapon;
    if (function_386dacbc(dw_weapon) != level.weaponnone) {
        if (!self hasweapon(dw_weapon)) {
            self giveweapon(dw_weapon);
        }
        self setweaponammoclip(dw_weapon, weapondata[#"lh_clip"]);
    }
    alt_weapon = weapon.altweapon;
    if (function_386dacbc(alt_weapon) != level.weaponnone) {
        if (!self hasweapon(alt_weapon)) {
            self giveweapon(alt_weapon);
        }
        self setweaponammoclip(alt_weapon, weapondata[#"alt_clip"]);
        self setweaponammostock(alt_weapon, weapondata[#"alt_stock"]);
    }
    if (isdefined(weapondata[#"aat"])) {
        self aat::acquire(weapon, weapondata[#"aat"]);
    }
    if (isdefined(weapondata[#"repacks"]) && weapondata[#"repacks"] > 0) {
        self zm_pap_util::repack_weapon(weapon, weapondata[#"repacks"]);
    }
    return weapon;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0x2b8d6340, Offset: 0x6418
// Size: 0x204
function weapondata_take(weapondata) {
    weapon = weapondata[#"weapon"];
    if (weapon != level.weaponnone) {
        if (self hasweapon(weapon)) {
            self weapon_take(weapon);
        }
    }
    dw_weapon = weapon.dualwieldweapon;
    if (dw_weapon != level.weaponnone) {
        if (self hasweapon(dw_weapon)) {
            self weapon_take(dw_weapon);
        }
    }
    alt_weapon = weapon.altweapon;
    a_alt_weapons = [];
    while (alt_weapon != level.weaponnone) {
        if (!isdefined(a_alt_weapons)) {
            a_alt_weapons = [];
        } else if (!isarray(a_alt_weapons)) {
            a_alt_weapons = array(a_alt_weapons);
        }
        if (!isinarray(a_alt_weapons, alt_weapon)) {
            a_alt_weapons[a_alt_weapons.size] = alt_weapon;
        }
        if (self hasweapon(alt_weapon)) {
            self weapon_take(alt_weapon);
        }
        alt_weapon = alt_weapon.altweapon;
        if (isinarray(a_alt_weapons, alt_weapon)) {
            println("<dev string:x12f>" + function_9e72a96(alt_weapon.name) + "<dev string:x14f>");
            break;
        }
    }
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x65ebd3c2, Offset: 0x6628
// Size: 0x192
function create_loadout(weapons) {
    weaponnone = getweapon(#"none");
    if (isdefined(level.weaponnone)) {
        weaponnone = level.weaponnone;
    }
    loadout = spawnstruct();
    loadout.weapons = [];
    foreach (weapon in weapons) {
        if (isstring(weapon)) {
            weapon = getweapon(weapon);
        }
        if (weapon == weaponnone) {
            println("<dev string:x1e8>" + weapon.name);
        }
        loadout.weapons[weapon.name] = get_default_weapondata(weapon);
        if (!isdefined(loadout.current)) {
            loadout.current = weapon;
        }
    }
    return loadout;
}

// Namespace zm_weapons/zm_weapons
// Params 0, eflags: 0x1 linked
// Checksum 0xd3c1d85, Offset: 0x67c8
// Size: 0x104
function player_get_loadout() {
    loadout = spawnstruct();
    loadout.current = self getcurrentweapon();
    loadout.stowed = self getstowedweapon();
    loadout.weapons = [];
    foreach (weapon in self getweaponslist()) {
        loadout.weapons[weapon.name] = self get_player_weapondata(weapon);
    }
    return loadout;
}

// Namespace zm_weapons/zm_weapons
// Params 3, eflags: 0x1 linked
// Checksum 0x45580c91, Offset: 0x68d8
// Size: 0x2bc
function player_give_loadout(loadout, replace_existing = 1, immediate_switch = 0) {
    if (replace_existing) {
        self takeallweapons();
    }
    foreach (weapondata in loadout.weapons) {
        if (is_true(weapondata[#"weapon"].isheroweapon)) {
            self zm_hero_weapon::hero_give_weapon(self.var_fd05e363, 0);
            w_weapon = weapondata[#"weapon"];
            if (w_weapon.isgadget && isdefined(weapondata[#"power"])) {
                slot = self gadgetgetslot(w_weapon);
                if (slot >= 0) {
                    self gadgetpowerset(slot, weapondata[#"power"]);
                }
            }
            continue;
        }
        self weapondata_give(weapondata);
    }
    if (self getweaponslistprimaries().size == 0) {
        self zm_loadout::give_start_weapon(1);
    }
    if (!zm_loadout::is_offhand_weapon(loadout.current)) {
        if (immediate_switch) {
            self switchtoweaponimmediate(loadout.current);
        } else {
            self switchtoweapon(loadout.current);
        }
    } else if (immediate_switch) {
        self switchtoweaponimmediate();
    } else {
        self switchtoweapon();
    }
    if (isdefined(loadout.stowed)) {
        self setstowedweapon(loadout.stowed);
    }
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x7e93bd04, Offset: 0x6ba0
// Size: 0x98
function player_take_loadout(loadout) {
    foreach (weapondata in loadout.weapons) {
        self weapondata_take(weapondata);
    }
}

// Namespace zm_weapons/zm_weapons
// Params 2, eflags: 0x1 linked
// Checksum 0x70c2cef0, Offset: 0x6c40
// Size: 0x54
function register_zombie_weapon_callback(weapon, func) {
    if (!isdefined(level.zombie_weapons_callbacks)) {
        level.zombie_weapons_callbacks = [];
    }
    if (!isdefined(level.zombie_weapons_callbacks[weapon])) {
        level.zombie_weapons_callbacks[weapon] = func;
    }
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x9f46516f, Offset: 0x6ca0
// Size: 0x54
function set_stowed_weapon(weapon) {
    self.weapon_stowed = weapon;
    if (!is_true(self.stowed_weapon_suppressed)) {
        self setstowedweapon(self.weapon_stowed);
    }
}

// Namespace zm_weapons/zm_weapons
// Params 0, eflags: 0x0
// Checksum 0xc401d8ad, Offset: 0x6d00
// Size: 0x34
function clear_stowed_weapon() {
    self notify(#"hash_70957a1035bda74b");
    self.weapon_stowed = undefined;
    self clearstowedweapon();
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x8266b55e, Offset: 0x6d40
// Size: 0x6c
function suppress_stowed_weapon(onoff) {
    self.stowed_weapon_suppressed = onoff;
    if (onoff || !isdefined(self.weapon_stowed)) {
        self clearstowedweapon();
        return;
    }
    self setstowedweapon(self.weapon_stowed);
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0x42afc57d, Offset: 0x6db8
// Size: 0x24
function checkstringvalid(hash_or_str) {
    if (hash_or_str != "") {
        return hash_or_str;
    }
    return undefined;
}

// Namespace zm_weapons/zm_weapons
// Params 2, eflags: 0x1 linked
// Checksum 0xb614f824, Offset: 0x6de8
// Size: 0x47a
function load_weapon_spec_from_table(table, first_row) {
    gametype = util::get_game_type();
    index = first_row;
    for (row = tablelookuprow(table, index); isdefined(row); row = tablelookuprow(table, index)) {
        weapon_name = checkstringvalid(row[0]);
        if (isinarray(level.var_c60359dc, weapon_name)) {
            index++;
            row = tablelookuprow(table, index);
            continue;
        }
        if (!isdefined(level.var_c60359dc)) {
            level.var_c60359dc = [];
        } else if (!isarray(level.var_c60359dc)) {
            level.var_c60359dc = array(level.var_c60359dc);
        }
        level.var_c60359dc[level.var_c60359dc.size] = weapon_name;
        upgrade_name = checkstringvalid(row[1]);
        is_ee = row[2];
        cost = row[3];
        weaponvo = checkstringvalid(row[4]);
        weaponvoresp = checkstringvalid(row[5]);
        ammo_cost = row[6];
        create_vox = row[7];
        is_zcleansed = row[8];
        in_box = row[9];
        upgrade_in_box = row[10];
        is_limited = row[11];
        var_ddca6652 = row[17];
        limit = row[12];
        upgrade_limit = row[13];
        content_restrict = row[14];
        wallbuy_autospawn = row[15];
        weapon_class = checkstringvalid(row[16]);
        is_wonder_weapon = row[18];
        tier = row[19];
        element = row[20];
        zm_utility::include_weapon(weapon_name, in_box);
        if (isdefined(upgrade_name)) {
            zm_utility::include_weapon(upgrade_name, upgrade_in_box);
        }
        add_zombie_weapon(weapon_name, upgrade_name, is_ee, cost, weaponvo, weaponvoresp, ammo_cost, create_vox, weapon_class, is_wonder_weapon, tier, in_box, element);
        if (is_limited) {
            if (isdefined(limit)) {
                add_limited_weapon(weapon_name, limit);
            }
            if (isdefined(upgrade_limit) && isdefined(upgrade_name)) {
                add_limited_weapon(upgrade_name, upgrade_limit);
            }
        }
        if (!var_ddca6652 && weapon_class !== "equipment") {
            aat::register_aat_exemption(getweapon(weapon_name));
            if (isdefined(upgrade_name)) {
                aat::register_aat_exemption(getweapon(upgrade_name));
            }
        }
        index++;
    }
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0xad492d4f, Offset: 0x7270
// Size: 0x64
function is_wonder_weapon(w_to_check) {
    w_base = get_base_weapon(w_to_check);
    if (isdefined(level.zombie_weapons[w_base]) && level.zombie_weapons[w_base].is_wonder_weapon) {
        return true;
    }
    return false;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0x3c1aadcf, Offset: 0x72e0
// Size: 0xc6
function is_tactical_rifle(w_to_check) {
    var_6351a511 = array(getweapon(#"tr_leveraction_t8"), getweapon(#"tr_longburst_t8"), getweapon(#"tr_midburst_t8"), getweapon(#"tr_powersemi_t8"));
    if (isinarray(var_6351a511, w_to_check)) {
        return true;
    }
    return false;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0xabe1709b, Offset: 0x73b0
// Size: 0x38
function is_explosive_weapon(weapon) {
    if (weapon.explosioninnerdamage > 0 || weapon.explosionouterdamage > 0) {
        return true;
    }
    return false;
}

// Namespace zm_weapons/zm_weapons
// Params 2, eflags: 0x1 linked
// Checksum 0x31484d69, Offset: 0x73f0
// Size: 0x96
function function_f5a0899d(weapon, var_d921715f = 1) {
    if (isdefined(weapon)) {
        if (!var_d921715f && is_wonder_weapon(weapon)) {
            return false;
        }
        var_3ba4bf7d = self getweaponslistprimaries();
        if (isinarray(var_3ba4bf7d, weapon)) {
            return true;
        }
    }
    return false;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0x5e555f, Offset: 0x7490
// Size: 0xf4
function function_7c5dd4bd(w_weapon) {
    if (zm_loadout::function_2ff6913(w_weapon)) {
        return;
    }
    if (!self hasweapon(w_weapon)) {
        return;
    }
    self setweaponammoclip(w_weapon, w_weapon.clipsize);
    self notify(#"hash_278526d0bbdb4ce7");
    if (zm_trial_reset_loadout::is_active(1)) {
        self function_7f7c1226(w_weapon);
        return;
    }
    if (self hasperk(#"specialty_extraammo")) {
        self givemaxammo(w_weapon);
        return;
    }
    self givestartammo(w_weapon);
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0x7c586c18, Offset: 0x7590
// Size: 0xcc
function function_51aa5813(n_slot) {
    if (isdefined(n_slot)) {
        weapon = self namespace_a0d533d1::function_2b83d3ff(self item_inventory::function_2e711614(n_slot));
        if (isdefined(weapon) && weapon != level.weaponnone && weapon != level.weaponbasemeleeheld) {
            self setweaponammoclip(weapon, weapon.clipsize);
            maxammo = weapon.maxammo;
            self setweaponammostock(weapon, maxammo);
        }
    }
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x5 linked
// Checksum 0xfd67bb97, Offset: 0x7668
// Size: 0x64
function private function_7f7c1226(weapon) {
    waittillframeend();
    if (is_true(weapon.isriotshield)) {
        n_stock = weapon.clipsize;
    } else {
        n_stock = 0;
    }
    self setweaponammostock(weapon, n_stock);
}

// Namespace zm_weapons/zm_weapons
// Params 3, eflags: 0x1 linked
// Checksum 0x22371a98, Offset: 0x76d8
// Size: 0x53a
function function_ed29dde5(var_947d01ee, var_ccd1bc81 = 0, var_609a8d33 = 0) {
    a_weapons = [];
    foreach (s_weapon in level.zombie_weapons) {
        if (s_weapon.weapon_classname === var_947d01ee) {
            if (var_609a8d33) {
                if (!isdefined(a_weapons)) {
                    a_weapons = [];
                } else if (!isarray(a_weapons)) {
                    a_weapons = array(a_weapons);
                }
                a_weapons[a_weapons.size] = s_weapon.weapon.name;
            } else {
                if (!isdefined(a_weapons)) {
                    a_weapons = [];
                } else if (!isarray(a_weapons)) {
                    a_weapons = array(a_weapons);
                }
                a_weapons[a_weapons.size] = s_weapon.weapon;
            }
            if (var_ccd1bc81) {
                if (var_609a8d33) {
                    if (!isdefined(a_weapons)) {
                        a_weapons = [];
                    } else if (!isarray(a_weapons)) {
                        a_weapons = array(a_weapons);
                    }
                    a_weapons[a_weapons.size] = s_weapon.upgrade.name;
                } else {
                    if (!isdefined(a_weapons)) {
                        a_weapons = [];
                    } else if (!isarray(a_weapons)) {
                        a_weapons = array(a_weapons);
                    }
                    a_weapons[a_weapons.size] = s_weapon.upgrade;
                }
            }
        }
        if (s_weapon.weapon_classname === "shield" && var_947d01ee != "shield") {
            if (s_weapon.weapon.weapclass === var_947d01ee) {
                if (var_609a8d33) {
                    if (!isdefined(a_weapons)) {
                        a_weapons = [];
                    } else if (!isarray(a_weapons)) {
                        a_weapons = array(a_weapons);
                    }
                    a_weapons[a_weapons.size] = s_weapon.weapon.name;
                    if (s_weapon.weapon.dualwieldweapon != level.weaponnone) {
                        if (!isdefined(a_weapons)) {
                            a_weapons = [];
                        } else if (!isarray(a_weapons)) {
                            a_weapons = array(a_weapons);
                        }
                        a_weapons[a_weapons.size] = s_weapon.weapon.dualwieldweapon.name;
                    }
                } else {
                    if (!isdefined(a_weapons)) {
                        a_weapons = [];
                    } else if (!isarray(a_weapons)) {
                        a_weapons = array(a_weapons);
                    }
                    a_weapons[a_weapons.size] = s_weapon.weapon;
                    if (s_weapon.weapon.dualwieldweapon != level.weaponnone) {
                        if (!isdefined(a_weapons)) {
                            a_weapons = [];
                        } else if (!isarray(a_weapons)) {
                            a_weapons = array(a_weapons);
                        }
                        a_weapons[a_weapons.size] = s_weapon.weapon.dualwieldweapon;
                    }
                }
            }
            if (s_weapon.weapon.altweapon.weapclass === var_947d01ee) {
                if (var_609a8d33) {
                    if (!isdefined(a_weapons)) {
                        a_weapons = [];
                    } else if (!isarray(a_weapons)) {
                        a_weapons = array(a_weapons);
                    }
                    a_weapons[a_weapons.size] = s_weapon.weapon.altweapon.name;
                    continue;
                }
                if (!isdefined(a_weapons)) {
                    a_weapons = [];
                } else if (!isarray(a_weapons)) {
                    a_weapons = array(a_weapons);
                }
                a_weapons[a_weapons.size] = s_weapon.weapon.altweapon;
            }
        }
    }
    return a_weapons;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0x3f79a17e, Offset: 0x7c20
// Size: 0x12c
function on_item_pickup(params) {
    item = params.item;
    weapon = namespace_a0d533d1::function_2b83d3ff(item);
    if (isdefined(item) && isdefined(weapon)) {
        if (isdefined(item.var_a8bccf69)) {
            inventoryitem = item_inventory::get_inventory_item(item.networkid);
            self item_inventory::function_73ae3380(inventoryitem, item.var_a8bccf69);
        }
        if (isdefined(item.aat)) {
            inventoryitem = item_inventory::get_inventory_item(item.networkid);
            self item_inventory::function_b579540e(inventoryitem, item.aat);
            self function_e1fd87b0(weapon, item.aat);
            return;
        }
        self function_51897592(weapon);
    }
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0x593a28e2, Offset: 0x7d58
// Size: 0xdc
function on_weapon_change(params) {
    weapon = params.weapon;
    if (weapon === level.weaponnone) {
        return;
    }
    waitframe(1);
    networkid = self item_inventory::function_ec087745();
    if (networkid != 32767) {
        item = self item_inventory::get_inventory_item(networkid);
        if (isdefined(item)) {
            if (isdefined(item.aat)) {
                self function_e1fd87b0(weapon, item.aat);
                return;
            }
            self function_51897592(weapon);
        }
    }
}

// Namespace zm_weapons/zm_weapons
// Params 3, eflags: 0x1 linked
// Checksum 0x6c53ec73, Offset: 0x7e40
// Size: 0x4c
function function_37e9e0cb(item, weapon, aat_name) {
    self item_inventory::function_b579540e(item, aat_name);
    self function_e1fd87b0(weapon, aat_name);
}

// Namespace zm_weapons/zm_weapons
// Params 2, eflags: 0x1 linked
// Checksum 0xb4a7b0b9, Offset: 0x7e98
// Size: 0x4c
function function_e1fd87b0(weapon, aat_name) {
    if (!aat::is_exempt_weapon(weapon)) {
        self aat::acquire(weapon, aat_name);
    }
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0x49816eb8, Offset: 0x7ef0
// Size: 0x3c
function function_51897592(weapon) {
    if (self aat::has_aat(weapon)) {
        self aat::remove(weapon);
    }
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0xad563522, Offset: 0x7f38
// Size: 0x26
function function_896671d5(var_a8bccf69) {
    damage_mod = var_a8bccf69 + 1;
    return damage_mod;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0xcdee88b8, Offset: 0x7f68
// Size: 0xca
function function_d85e6c3a(var_bc61fcdc = "none") {
    switch (var_bc61fcdc) {
    case #"uncommon":
        return 0.05;
    case #"rare":
        return 0.1;
    case #"epic":
        return 0.15;
    case #"ultra":
    case #"legendary":
        return 0.2;
    default:
        return 0;
    }
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0xf4ea1135, Offset: 0x8040
// Size: 0x40
function function_f066796f(weapon) {
    if (isdefined(weapon) && isdefined(level.zombie_weapons[weapon])) {
        return level.zombie_weapons[weapon].element;
    }
}

