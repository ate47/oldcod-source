#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm\weapons\zm_weap_chakram;
#using scripts\zm\weapons\zm_weap_hammer;
#using scripts\zm\weapons\zm_weap_scepter;
#using scripts\zm\weapons\zm_weap_sword_pistol;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_wallbuy;

#namespace zm_weapons;

// Namespace zm_weapons/zm_weapons
// Params 0, eflags: 0x2
// Checksum 0x1478da5a, Offset: 0x100
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_weapons", &__init__, &__main__, undefined);
}

// Namespace zm_weapons/zm_weapons
// Params 0, eflags: 0x0
// Checksum 0x1e46e731, Offset: 0x150
// Size: 0xda
function __init__() {
    level flag::init("weapon_table_loaded");
    callback::on_localclient_connect(&on_player_connect);
    level.weaponnone = getweapon(#"none");
    level.weaponnull = getweapon(#"weapon_null");
    level.weaponbasemelee = getweapon(#"knife");
    if (!isdefined(level.zombie_weapons_upgraded)) {
        level.zombie_weapons_upgraded = [];
    }
}

// Namespace zm_weapons/zm_weapons
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x238
// Size: 0x4
function __main__() {
    
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x4
// Checksum 0xb4d901c4, Offset: 0x248
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
// Params 1, eflags: 0x0
// Checksum 0xc1dc02e2, Offset: 0x3e0
// Size: 0x36
function is_weapon_included(weapon) {
    if (!isdefined(level._included_weapons)) {
        return false;
    }
    return isdefined(level._included_weapons[weapon.rootweapon]);
}

// Namespace zm_weapons/zm_weapons
// Params 5, eflags: 0x0
// Checksum 0xf81907f7, Offset: 0x420
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
// Params 5, eflags: 0x0
// Checksum 0x46faa4e4, Offset: 0x528
// Size: 0x27c
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
            thread util::error("<dev string:x30>" + function_15979fa9(weapon_name) + "<dev string:x4f>");
        #/
        return;
    }
    addzombieboxweapon(weapon, weapon.worldmodel, weapon.isdualwield);
}

// Namespace zm_weapons/zm_weapons
// Params 5, eflags: 0x0
// Checksum 0x86968791, Offset: 0x7b0
// Size: 0xf6
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
// Checksum 0x7c34a195, Offset: 0x8b0
// Size: 0x5e
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
// Params 1, eflags: 0x0
// Checksum 0x565fbfa5, Offset: 0x918
// Size: 0x24
function checkstringvalid(str) {
    if (str != "") {
        return str;
    }
    return undefined;
}

// Namespace zm_weapons/zm_weapons
// Params 2, eflags: 0x0
// Checksum 0x38ce52b3, Offset: 0x948
// Size: 0x304
function load_weapon_spec_from_table(table, first_row) {
    gametype = util::get_game_type();
    index = first_row;
    for (row = tablelookuprow(table, index); isdefined(row); row = tablelookuprow(table, index)) {
        weapon_name = checkstringvalid(row[0]);
        upgrade_name = checkstringvalid(row[1]);
        hint = row[2];
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
        var_e44dc8f1 = tolower(row[19]);
        include_weapon(weapon_name, in_box, cost, ammo_cost, 0);
        if (isdefined(upgrade_name)) {
            include_upgraded_weapon(weapon_name, upgrade_name, upgrade_in_box, cost, 4500);
        }
        index++;
    }
    level flag::set("weapon_table_loaded");
}

