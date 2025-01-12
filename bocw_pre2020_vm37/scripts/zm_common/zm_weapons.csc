#using script_101d8280497ff416;
#using script_680dddbda86931fa;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\item_world;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\weapons;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_wallbuy;

#namespace zm_weapons;

// Namespace zm_weapons/zm_weapons
// Params 0, eflags: 0x6
// Checksum 0xbf87c599, Offset: 0x128
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"zm_weapons", &function_70a657d8, &postinit, undefined, undefined);
}

// Namespace zm_weapons/zm_weapons
// Params 0, eflags: 0x5 linked
// Checksum 0xcf0a2871, Offset: 0x180
// Size: 0x114
function private function_70a657d8() {
    level flag::init("weapon_table_loaded");
    callback::on_localclient_connect(&on_player_connect);
    level.weaponnone = getweapon(#"none");
    level.weaponnull = getweapon(#"weapon_null");
    level.var_78032351 = getweapon(#"defaultweapon");
    level.weaponbasemelee = getweapon(#"knife");
    if (!isdefined(level.zombie_weapons_upgraded)) {
        level.zombie_weapons_upgraded = [];
    }
    weapons::init_shared();
}

// Namespace zm_weapons/zm_weapons
// Params 0, eflags: 0x5 linked
// Checksum 0x68998764, Offset: 0x2a0
// Size: 0x14
function private postinit() {
    init_weapons();
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x5 linked
// Checksum 0x4a20be78, Offset: 0x2c0
// Size: 0x190
function private on_player_connect(localclientnum) {
    if (getmigrationstatus(localclientnum)) {
        return;
    }
    resetweaponcosts(localclientnum);
    level flag::wait_till("weapon_table_loaded");
    if (getgametypesetting(#"zmwallbuysenabled")) {
        level flag::wait_till("weapon_wallbuys_created");
    }
    if (isdefined(level.weapon_costs)) {
        foreach (weaponcost in level.weapon_costs) {
            player_cost = compute_player_weapon_ammo_cost(weaponcost.weapon, weaponcost.ammo_cost, weaponcost.upgraded);
            setweaponcosts(localclientnum, weaponcost.weapon, weaponcost.cost, weaponcost.ammo_cost, player_cost, weaponcost.upgradedweapon);
        }
    }
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0xf20c5f8b, Offset: 0x458
// Size: 0x36
function is_weapon_included(weapon) {
    if (!isdefined(level._included_weapons)) {
        return false;
    }
    return isdefined(level._included_weapons[weapon.rootweapon]);
}

// Namespace zm_weapons/zm_weapons
// Params 5, eflags: 0x1 linked
// Checksum 0x8da0b02b, Offset: 0x498
// Size: 0xfe
function compute_player_weapon_ammo_cost(weapon, cost, upgraded, n_base_non_wallbuy_cost = 750, n_upgraded_non_wallbuy_cost = 5000) {
    w_root = weapon.rootweapon;
    if (upgraded) {
        if (zm_wallbuy::is_wallbuy(level.zombie_weapons_upgraded[w_root])) {
            n_ammo_cost = 4000;
        } else {
            n_ammo_cost = n_upgraded_non_wallbuy_cost;
        }
    } else if (zm_wallbuy::is_wallbuy(w_root)) {
        n_ammo_cost = cost;
        n_ammo_cost = zm_utility::halve_score(n_ammo_cost);
    } else {
        n_ammo_cost = n_base_non_wallbuy_cost;
    }
    return n_ammo_cost;
}

// Namespace zm_weapons/zm_weapons
// Params 5, eflags: 0x1 linked
// Checksum 0x9768d8a1, Offset: 0x5a0
// Size: 0x25c
function include_weapon(weapon_name, display_in_box, cost, ammo_cost, upgraded = 0) {
    if (!isdefined(level._included_weapons)) {
        level._included_weapons = [];
    }
    weapon = getweapon(weapon_name);
    level._included_weapons[weapon] = weapon;
    if (!isdefined(level.weapon_costs)) {
        level.weapon_costs = [];
    }
    if (!isdefined(level.weapon_costs[weapon_name])) {
        level.weapon_costs[weapon_name] = spawnstruct();
        level.weapon_costs[weapon_name].weapon = weapon;
        level.weapon_costs[weapon_name].upgradedweapon = level.weaponnone;
    }
    level.weapon_costs[weapon_name].cost = cost;
    if (!isdefined(ammo_cost) || ammo_cost == 0) {
        ammo_cost = zm_utility::round_up_to_ten(int(cost * 0.5));
    }
    level.weapon_costs[weapon_name].ammo_cost = ammo_cost;
    level.weapon_costs[weapon_name].upgraded = upgraded;
    if (isdefined(display_in_box) && !display_in_box) {
        return;
    }
    if (!isdefined(level._resetzombieboxweapons)) {
        level._resetzombieboxweapons = 1;
        resetzombieboxweapons();
    }
    if (!isdefined(weapon.worldmodel)) {
        /#
            thread util::error("<dev string:x38>" + function_9e72a96(weapon_name) + "<dev string:x5a>");
        #/
        return;
    }
    addzombieboxweapon(weapon, weapon.worldmodel, weapon.isdualwield);
}

// Namespace zm_weapons/zm_weapons
// Params 5, eflags: 0x1 linked
// Checksum 0xbe6ce556, Offset: 0x808
// Size: 0xe2
function include_upgraded_weapon(weapon_name, upgrade_name, display_in_box, cost, ammo_cost) {
    include_weapon(upgrade_name, display_in_box, cost, ammo_cost, 1);
    if (!isdefined(level.zombie_weapons_upgraded)) {
        level.zombie_weapons_upgraded = [];
    }
    weapon = getweapon(weapon_name);
    upgrade = getweapon(upgrade_name);
    level.zombie_weapons_upgraded[upgrade] = weapon;
    if (isdefined(level.weapon_costs[weapon_name])) {
        level.weapon_costs[weapon_name].upgradedweapon = upgrade;
    }
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x83dc8fa6, Offset: 0x8f8
// Size: 0x5a
function is_weapon_upgraded(weapon) {
    if (!isdefined(level.zombie_weapons_upgraded)) {
        level.zombie_weapons_upgraded = [];
    }
    rootweapon = weapon.rootweapon;
    if (isdefined(level.zombie_weapons_upgraded[rootweapon])) {
        return true;
    }
    return false;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0x64c94cda, Offset: 0x960
// Size: 0x24
function checkstringvalid(str) {
    if (str != "") {
        return str;
    }
    return undefined;
}

// Namespace zm_weapons/zm_weapons
// Params 0, eflags: 0x1 linked
// Checksum 0x4d004d4a, Offset: 0x990
// Size: 0xae
function init_weapons() {
    level.var_c60359dc = [];
    var_4ef031c9 = #"hash_2298893b58cc2885";
    load_weapon_spec_from_table(var_4ef031c9, 0);
    if (isdefined(level.var_d0ab70a2)) {
        load_weapon_spec_from_table(level.var_d0ab70a2, 0);
    }
    level thread function_350ee41();
    level flag::set("weapon_table_loaded");
    level.var_c60359dc = undefined;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0x99a87a6e, Offset: 0xa48
// Size: 0x148
function function_15827c82(var_904df15f) {
    if (var_904df15f.type === "itemspawnlist") {
        foreach (s_item in var_904df15f.itemlist) {
            if (s_item.type === "itemspawnlist") {
                function_15827c82(s_item);
                continue;
            }
            if (!isdefined(level.var_8bd4028f)) {
                level.var_8bd4028f = [];
            } else if (!isarray(level.var_8bd4028f)) {
                level.var_8bd4028f = array(level.var_8bd4028f);
            }
            level.var_8bd4028f[level.var_8bd4028f.size] = s_item.var_a6762160;
        }
    }
}

// Namespace zm_weapons/zm_weapons
// Params 0, eflags: 0x5 linked
// Checksum 0xebe05b6b, Offset: 0xb98
// Size: 0x288
function private function_350ee41() {
    if (!isdefined(level.var_82b76a68)) {
        level.var_82b76a68 = "zm_magicbox_item_list";
    }
    s_bundle = getscriptbundle(level.var_82b76a68);
    foreach (s_item in s_bundle.itemlist) {
        if (s_item.type === "itemspawnlist") {
            function_15827c82(s_item);
        }
        if (!isdefined(level.var_8bd4028f)) {
            level.var_8bd4028f = [];
        } else if (!isarray(level.var_8bd4028f)) {
            level.var_8bd4028f = array(level.var_8bd4028f);
        }
        level.var_8bd4028f[level.var_8bd4028f.size] = s_item.var_a6762160;
        var_89230090 = getscriptbundle(s_item.var_a6762160);
        weapon = item_world_util::function_35e06774(var_89230090, isdefined(var_89230090.attachments));
        if (isweapon(weapon)) {
            if (!isdefined(level.var_c8b5248e)) {
                level.var_c8b5248e = [];
            } else if (!isarray(level.var_c8b5248e)) {
                level.var_c8b5248e = array(level.var_c8b5248e);
            }
            if (!isinarray(level.var_c8b5248e, weapon)) {
                level.var_c8b5248e[level.var_c8b5248e.size] = weapon;
            }
            addzombieboxweapon(weapon, weapon.worldmodel, weapon.isdualwield);
        }
    }
}

// Namespace zm_weapons/zm_weapons
// Params 2, eflags: 0x1 linked
// Checksum 0xab205ad1, Offset: 0xe28
// Size: 0x352
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
        cost = row[3];
        weaponvo = checkstringvalid(row[4]);
        weaponvoresp = checkstringvalid(row[5]);
        ammo_cost = row[6];
        create_vox = row[7];
        is_zcleansed = row[8];
        in_box = row[9];
        upgrade_in_box = row[10];
        is_limited = row[11];
        limit = row[12];
        upgrade_limit = row[13];
        content_restrict = row[14];
        wallbuy_autospawn = row[15];
        weapon_class = checkstringvalid(row[16]);
        is_wonder_weapon = row[18];
        tier = row[19];
        include_weapon(weapon_name, in_box, cost, ammo_cost, 0);
        if (isdefined(upgrade_name)) {
            include_upgraded_weapon(weapon_name, upgrade_name, upgrade_in_box, cost, 4500);
        }
        index++;
    }
}

