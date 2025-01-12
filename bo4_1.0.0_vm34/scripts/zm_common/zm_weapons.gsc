#using script_1b05b3ef7baa1c84;
#using scripts\abilities\ability_util;
#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\bb_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\weapons;
#using scripts\zm\weapons\zm_weap_chakram;
#using scripts\zm\weapons\zm_weap_hammer;
#using scripts\zm\weapons\zm_weap_molotov;
#using scripts\zm\weapons\zm_weap_scepter;
#using scripts\zm\weapons\zm_weap_sword_pistol;
#using scripts\zm\weapons\zm_weap_wraith_fire;
#using scripts\zm_common\bb;
#using scripts\zm_common\gametypes\globallogic_utils;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_customgame;
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
// Params 0, eflags: 0x2
// Checksum 0x32b9cea1, Offset: 0x248
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_weapons", &__init__, &__main__, undefined);
}

// Namespace zm_weapons/zm_weapons
// Params 0, eflags: 0x0
// Checksum 0xd198ed5a, Offset: 0x298
// Size: 0xe2
function __init__() {
    level flag::init("zm_weapons_table_loaded");
    level.weaponnone = getweapon(#"none");
    level.weaponnull = getweapon(#"weapon_null");
    level.weaponbasemelee = getweapon(#"knife");
    if (!isdefined(level.zombie_weapons)) {
        level.zombie_weapons = [];
    }
    if (!isdefined(level.zombie_weapons_upgraded)) {
        level.zombie_weapons_upgraded = [];
    }
    level.limited_weapons = [];
}

// Namespace zm_weapons/zm_weapons
// Params 0, eflags: 0x0
// Checksum 0x7fcb39d3, Offset: 0x388
// Size: 0x14
function __main__() {
    init();
}

// Namespace zm_weapons/zm_weapons
// Params 0, eflags: 0x0
// Checksum 0x4e01875a, Offset: 0x3a8
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
// Params 0, eflags: 0x0
// Checksum 0xe62c80ac, Offset: 0x450
// Size: 0x3e
function on_player_spawned() {
    self thread watchforgrenadeduds();
    self thread watchforgrenadelauncherduds();
    self.staticweaponsstarttime = gettime();
}

// Namespace zm_weapons/player_gunchallengecomplete
// Params 1, eflags: 0x40
// Checksum 0x3ea971ea, Offset: 0x498
// Size: 0x1b4
function event_handler[player_gunchallengecomplete] player_gunchallengecomplete(s_event) {
    if (s_event.is_lastrank) {
        var_7f996688 = 0;
        var_ca31b8a8 = get_guns();
        foreach (str_weapon in var_ca31b8a8) {
            n_item_index = getbaseweaponitemindex(getweapon(str_weapon));
            var_4c077de6 = stats::get_stat(#"weaponstats", n_item_index, #"xp");
            if (isdefined(var_4c077de6)) {
                var_8c22cd80 = function_334c81ef(str_weapon);
                var_782a2717 = stats::get_stat(#"weaponstats", n_item_index, #"plevel");
                if (var_4c077de6 >= var_8c22cd80 || var_782a2717 >= 1) {
                    var_7f996688++;
                }
            }
        }
        if (var_7f996688 >= 25) {
            zm_utility::giveachievement_wrapper("zm_trophy_gold");
        }
    }
}

// Namespace zm_weapons/zm_weapons
// Params 0, eflags: 0x0
// Checksum 0xdb3a8c7, Offset: 0x658
// Size: 0x116
function get_guns() {
    var_71a6aae8 = tablelookuprowcount(#"gamedata/weapons/zm/zm_gunlevels.csv");
    var_ca31b8a8 = [];
    for (i = 0; i < var_71a6aae8; i++) {
        str_weapon = tablelookupcolumnforrow(#"gamedata/weapons/zm/zm_gunlevels.csv", i, 2);
        if (isdefined(getweapon(str_weapon))) {
            if (!isdefined(var_ca31b8a8)) {
                var_ca31b8a8 = [];
            } else if (!isarray(var_ca31b8a8)) {
                var_ca31b8a8 = array(var_ca31b8a8);
            }
            if (!isinarray(var_ca31b8a8, str_weapon)) {
                var_ca31b8a8[var_ca31b8a8.size] = str_weapon;
            }
        }
    }
    return var_ca31b8a8;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x6a778, Offset: 0x778
// Size: 0xb4
function function_71f9f646(str_weapon) {
    var_36cd7408 = [];
    for (i = 0; i < 15; i++) {
        var_d4b6b0ab = tablelookup(#"gamedata/weapons/zm/zm_gunlevels.csv", 2, str_weapon, 0, i, 1);
        if ("" == var_d4b6b0ab) {
            break;
        }
        var_36cd7408[i] = int(var_d4b6b0ab);
    }
    return var_36cd7408;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xc8be0f45, Offset: 0x838
// Size: 0x40
function function_334c81ef(weapon) {
    var_d42e33e9 = function_71f9f646(weapon);
    return var_d42e33e9[var_d42e33e9.size - 1];
}

// Namespace zm_weapons/zm_weapons
// Params 0, eflags: 0x0
// Checksum 0xe853d468, Offset: 0x880
// Size: 0xd0
function watchforgrenadeduds() {
    self endon(#"death");
    self endon(#"disconnect");
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
// Params 0, eflags: 0x0
// Checksum 0xd7eb4203, Offset: 0x958
// Size: 0xa0
function watchforgrenadelauncherduds() {
    self endon(#"death");
    self endon(#"disconnect");
    while (true) {
        waitresult = self waittill(#"grenade_launcher_fire");
        grenade = waitresult.projectile;
        weapon = waitresult.weapon;
        grenade thread checkgrenadefordud(weapon, 0, self);
    }
}

// Namespace zm_weapons/zm_weapons
// Params 2, eflags: 0x0
// Checksum 0xef5d97b2, Offset: 0xa00
// Size: 0x40
function grenade_safe_to_throw(player, weapon) {
    if (isdefined(level.grenade_safe_to_throw)) {
        return self [[ level.grenade_safe_to_throw ]](player, weapon);
    }
    return 1;
}

// Namespace zm_weapons/zm_weapons
// Params 2, eflags: 0x0
// Checksum 0x70ee3fdc, Offset: 0xa48
// Size: 0x40
function grenade_safe_to_bounce(player, weapon) {
    if (isdefined(level.grenade_safe_to_bounce)) {
        return self [[ level.grenade_safe_to_bounce ]](player, weapon);
    }
    return 1;
}

// Namespace zm_weapons/zm_weapons
// Params 0, eflags: 0x0
// Checksum 0xe3a6d83f, Offset: 0xa90
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
// Params 3, eflags: 0x0
// Checksum 0xd9590535, Offset: 0xb00
// Size: 0x102
function checkgrenadefordud(weapon, isthrowngrenade, player) {
    self endon(#"death");
    player endon(#"zombify");
    if (!isdefined(self)) {
        return;
    }
    if (!self grenade_safe_to_throw(player, weapon)) {
        self thread makegrenadedudanddestroy();
        return;
    }
    for (;;) {
        self waittilltimeout(0.25, #"grenade_bounce", #"stationary", #"death", #"zombify");
        if (!self grenade_safe_to_bounce(player, weapon)) {
            self thread makegrenadedudanddestroy();
            return;
        }
    }
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xe1c1fea7, Offset: 0xc10
// Size: 0x3c
function get_nonalternate_weapon(weapon) {
    if (isdefined(weapon.isaltmode) && weapon.isaltmode) {
        return weapon.altweapon;
    }
    return weapon;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x56fdacd5, Offset: 0xc58
// Size: 0xa8
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
// Params 2, eflags: 0x0
// Checksum 0x8596822, Offset: 0xd08
// Size: 0xcc
function give_start_weapons(takeallweapons, alreadyspawned) {
    if (isdefined(self.s_loadout) && zombie_utility::get_zombie_var("retain_weapons") && zm_custom::function_5638f689(#"zmretainweapons")) {
        self player_give_loadout(self.s_loadout, 1, 0);
        self.s_loadout = undefined;
        return;
    }
    self zm_loadout::give_start_weapon(1);
    self zm_loadout::init_player_offhand_weapons();
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x5246b576, Offset: 0xde0
// Size: 0x2c
function give_fallback_weapon(immediate = 0) {
    zm_melee_weapon::give_fallback_weapon(immediate);
}

// Namespace zm_weapons/zm_weapons
// Params 0, eflags: 0x0
// Checksum 0x3efeb944, Offset: 0xe18
// Size: 0x14
function take_fallback_weapon() {
    zm_melee_weapon::take_fallback_weapon();
}

// Namespace zm_weapons/zm_weapons
// Params 2, eflags: 0x0
// Checksum 0x5c52a0c5, Offset: 0xe38
// Size: 0x214
function switch_back_primary_weapon(oldprimary, immediate = 0) {
    if (isdefined(self.laststand) && self.laststand) {
        return;
    }
    if (!isdefined(oldprimary) || oldprimary == level.weaponnone || oldprimary.isflourishweapon || zm_loadout::is_melee_weapon(oldprimary) || zm_loadout::is_placeable_mine(oldprimary) || zm_loadout::is_lethal_grenade(oldprimary) || zm_loadout::is_tactical_grenade(oldprimary) || !self hasweapon(oldprimary)) {
        oldprimary = undefined;
    } else if ((oldprimary.isheroweapon || oldprimary.isgadget) && (!isdefined(self.hero_power) || self.hero_power <= 0)) {
        oldprimary = undefined;
    }
    primaryweapons = self getweaponslistprimaries();
    if (isdefined(oldprimary) && isinarray(primaryweapons, oldprimary)) {
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
// Params 1, eflags: 0x0
// Checksum 0x1c4efb8, Offset: 0x1058
// Size: 0x46
function function_94719ba3(name) {
    if (!isdefined(level.var_ba14e572)) {
        level.var_ba14e572 = [];
    }
    level.var_ba14e572[level.var_ba14e572.size] = name;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xa2fff284, Offset: 0x10a8
// Size: 0x9c
function updatelastheldweapontimingszm(newtime) {
    if (isdefined(self.currentweapon) && isdefined(self.currenttime)) {
        curweapon = self.currentweapon;
        totaltime = int((newtime - self.currenttime) / 1000);
        if (totaltime > 0) {
            self stats::function_4f10b697(curweapon, #"timeused", totaltime);
        }
    }
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x8250411e, Offset: 0x1150
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
// Params 0, eflags: 0x0
// Checksum 0x982df723, Offset: 0x11e8
// Size: 0x8
function default_check_firesale_loc_valid_func() {
    return true;
}

// Namespace zm_weapons/zm_weapons
// Params 11, eflags: 0x0
// Checksum 0x11c80ca1, Offset: 0x11f8
// Size: 0x424
function add_zombie_weapon(weapon_name, upgrade_name, hint, cost, weaponvo, weaponvoresp, ammo_cost, create_vox, weapon_class, is_wonder_weapon, var_e44dc8f1) {
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
    struct.var_e44dc8f1 = [];
    if ("" != var_e44dc8f1) {
        var_334cc84c = strtok(var_e44dc8f1, " ");
        assert(6 >= var_334cc84c.size, function_15979fa9(weapon_name) + "<dev string:x30>");
        foreach (attachment in var_334cc84c) {
            struct.var_e44dc8f1[struct.var_e44dc8f1.size] = attachment;
        }
    }
    println("<dev string:x59>" + function_15979fa9(weapon_name));
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
        if (isdefined(level.devgui_add_weapon)) {
            level thread [[ level.devgui_add_weapon ]](weapon, upgrade, hint, cost, weaponvo, weaponvoresp, ammo_cost);
        }
    #/
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x48da4254, Offset: 0x1628
// Size: 0x4e
function is_weapon_included(weapon) {
    if (!isdefined(level.zombie_weapons)) {
        return false;
    }
    weapon = get_nonalternate_weapon(weapon);
    return isdefined(level.zombie_weapons[weapon.rootweapon]);
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x94f48cd, Offset: 0x1680
// Size: 0x60
function is_weapon_or_base_included(weapon) {
    weapon = get_nonalternate_weapon(weapon);
    return isdefined(level.zombie_weapons[weapon.rootweapon]) || isdefined(level.zombie_weapons[get_base_weapon(weapon)]);
}

// Namespace zm_weapons/zm_weapons
// Params 2, eflags: 0x0
// Checksum 0x274cd3a5, Offset: 0x16e8
// Size: 0x9a
function include_zombie_weapon(weapon_name, in_box) {
    if (!isdefined(level.zombie_include_weapons)) {
        level.zombie_include_weapons = [];
    }
    if (!isdefined(in_box)) {
        in_box = 1;
    }
    println("<dev string:x75>" + function_15979fa9(weapon_name));
    level.zombie_include_weapons[getweapon(weapon_name)] = in_box;
}

// Namespace zm_weapons/zm_weapons
// Params 0, eflags: 0x0
// Checksum 0xf1a65025, Offset: 0x1790
// Size: 0x6c
function init_weapons() {
    if (isdefined(level.var_237b30e2)) {
        [[ level.var_237b30e2 ]]();
        return;
    }
    var_8af07157 = #"hash_5c4d06d931ca7854" + level.script + "_weapons.csv";
    load_weapon_spec_from_table(var_8af07157, 0);
}

// Namespace zm_weapons/zm_weapons
// Params 2, eflags: 0x0
// Checksum 0x766a40dd, Offset: 0x1808
// Size: 0x4a
function add_limited_weapon(weapon_name, amount) {
    if (amount == 0) {
        return;
    }
    level.limited_weapons[getweapon(weapon_name)] = amount;
}

// Namespace zm_weapons/zm_weapons
// Params 2, eflags: 0x0
// Checksum 0x237cd4ae, Offset: 0x1860
// Size: 0x40c
function limited_weapon_below_quota(weapon, ignore_player) {
    if (isdefined(level.limited_weapons[weapon])) {
        pap_machines = undefined;
        if (!isdefined(pap_machines)) {
            pap_machines = getentarray("zm_pack_a_punch", "targetname");
        }
        if (isdefined(level.no_limited_weapons) && level.no_limited_weapons) {
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
        for (k = 0; k < pap_machines.size; k++) {
            if (isdefined(pap_machines[k].unitrigger_stub.current_weapon) && (pap_machines[k].unitrigger_stub.current_weapon == weapon || pap_machines[k].unitrigger_stub.current_weapon == upgradedweapon)) {
                count++;
                if (count >= limit) {
                    return false;
                }
            }
        }
        for (var_f0013e88 = 0; var_f0013e88 < level.chests.size; var_f0013e88++) {
            if (isdefined(level.chests[var_f0013e88].zbarrier.weapon) && level.chests[var_f0013e88].zbarrier.weapon == weapon) {
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
// Checksum 0x7cd0f5e5, Offset: 0x1c78
// Size: 0x46
function add_custom_limited_weapon_check(callback) {
    if (!isdefined(level.custom_limited_weapon_checks)) {
        level.custom_limited_weapon_checks = [];
    }
    level.custom_limited_weapon_checks[level.custom_limited_weapon_checks.size] = callback;
}

// Namespace zm_weapons/zm_weapons
// Params 2, eflags: 0x0
// Checksum 0xa8f4cad, Offset: 0x1cc8
// Size: 0x5a
function add_weapon_to_content(weapon_name, package) {
    if (!isdefined(level.content_weapons)) {
        level.content_weapons = [];
    }
    level.content_weapons[getweapon(weapon_name)] = package;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xc78ef9a1, Offset: 0x1d30
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
// Params 1, eflags: 0x0
// Checksum 0x384ac4e5, Offset: 0x1d90
// Size: 0x5a
function get_weapon_hint(weapon) {
    assert(isdefined(level.zombie_weapons[weapon]), weapon.name + "<dev string:x8f>");
    return level.zombie_weapons[weapon].hint;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x78166cf1, Offset: 0x1df8
// Size: 0x5a
function get_weapon_cost(weapon) {
    assert(isdefined(level.zombie_weapons[weapon]), weapon.name + "<dev string:x8f>");
    return level.zombie_weapons[weapon].cost;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x17b28b86, Offset: 0x1e60
// Size: 0x5a
function get_ammo_cost(weapon) {
    assert(isdefined(level.zombie_weapons[weapon]), weapon.name + "<dev string:x8f>");
    return level.zombie_weapons[weapon].ammo_cost;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xe08e6e98, Offset: 0x1ec8
// Size: 0x7c
function get_upgraded_ammo_cost(weapon) {
    assert(isdefined(level.zombie_weapons[weapon]), weapon.name + "<dev string:x8f>");
    if (isdefined(level.zombie_weapons[weapon].upgraded_ammo_cost)) {
        return level.zombie_weapons[weapon].upgraded_ammo_cost;
    }
    return 4500;
}

// Namespace zm_weapons/zm_weapons
// Params 3, eflags: 0x0
// Checksum 0x4076c65, Offset: 0x1f50
// Size: 0x12e
function get_ammo_cost_for_weapon(w_current, n_base_non_wallbuy_cost = 750, n_upgraded_non_wallbuy_cost = 5000) {
    w_root = w_current.rootweapon;
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
// Checksum 0xc5a884fb, Offset: 0x2088
// Size: 0x5a
function get_is_in_box(weapon) {
    assert(isdefined(level.zombie_weapons[weapon]), weapon.name + "<dev string:x8f>");
    return level.zombie_weapons[weapon].is_in_box;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xe31fcc2e, Offset: 0x20f0
// Size: 0x3e
function function_55d25350(weapon) {
    if (isdefined(level.zombie_weapons[weapon])) {
        level.zombie_weapons[weapon].is_in_box = 1;
    }
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x722f8834, Offset: 0x2138
// Size: 0x3e
function function_503fb052(weapon) {
    if (isdefined(level.zombie_weapons[weapon])) {
        level.zombie_weapons[weapon].is_in_box = 0;
    }
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xc5f4bf6, Offset: 0x2180
// Size: 0x5a
function function_4f54ceec(weapon) {
    assert(isdefined(level.zombie_weapons[weapon]), weapon.name + "<dev string:x8f>");
    return level.zombie_weapons[weapon].var_e44dc8f1;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xd39df737, Offset: 0x21e8
// Size: 0x4a
function weapon_supports_default_attachment(weapon) {
    weapon = get_base_weapon(weapon);
    attachment = level.zombie_weapons[weapon].default_attachment;
    return isdefined(attachment);
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xe8da3d4c, Offset: 0x2240
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
// Checksum 0x3ee67cad, Offset: 0x22a8
// Size: 0x5c
function weapon_supports_attachments(weapon) {
    weapon = get_base_weapon(weapon);
    attachments = level.zombie_weapons[weapon].addon_attachments;
    return isdefined(attachments) && attachments.size > 1;
}

// Namespace zm_weapons/zm_weapons
// Params 2, eflags: 0x0
// Checksum 0x854b6dc2, Offset: 0x2310
// Size: 0x14a
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
// Checksum 0xfe444109, Offset: 0x2468
// Size: 0x140
function get_attachment_index(weapon) {
    attachments = weapon.attachments;
    if (!attachments.size) {
        return -1;
    }
    weapon = get_nonalternate_weapon(weapon);
    base = weapon.rootweapon;
    if (attachments[0] == level.zombie_weapons[base].default_attachment) {
        return 0;
    }
    if (isdefined(level.zombie_weapons[base].addon_attachments)) {
        for (i = 0; i < level.zombie_weapons[base].addon_attachments.size; i++) {
            if (level.zombie_weapons[base].addon_attachments[i] == attachments[0]) {
                return (i + 1);
            }
        }
    }
    println("<dev string:xcb>" + weapon.name);
    return -1;
}

// Namespace zm_weapons/zm_weapons
// Params 2, eflags: 0x0
// Checksum 0x9f9730ee, Offset: 0x25b0
// Size: 0xe8
function weapon_supports_this_attachment(weapon, att) {
    weapon = get_nonalternate_weapon(weapon);
    base = weapon.rootweapon;
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
// Params 1, eflags: 0x0
// Checksum 0xd84f9dc2, Offset: 0x26a0
// Size: 0x5e
function get_base_weapon(upgradedweapon) {
    upgradedweapon = get_nonalternate_weapon(upgradedweapon);
    upgradedweapon = upgradedweapon.rootweapon;
    if (isdefined(level.zombie_weapons_upgraded[upgradedweapon])) {
        return level.zombie_weapons_upgraded[upgradedweapon];
    }
    return upgradedweapon;
}

// Namespace zm_weapons/zm_weapons
// Params 2, eflags: 0x0
// Checksum 0x6646e6b4, Offset: 0x2708
// Size: 0x162
function get_upgrade_weapon(weapon, add_attachment) {
    weapon = get_nonalternate_weapon(weapon);
    rootweapon = weapon.rootweapon;
    newweapon = rootweapon;
    baseweapon = get_base_weapon(weapon);
    if (!is_weapon_upgraded(rootweapon) && isdefined(level.zombie_weapons[rootweapon])) {
        newweapon = level.zombie_weapons[rootweapon].upgrade;
    } else if (!zm_custom::function_5638f689(#"zmsuperpapenabled")) {
        return weapon;
    }
    if (isdefined(level.zombie_weapons[rootweapon]) && isdefined(level.zombie_weapons[rootweapon].default_attachment)) {
        att = level.zombie_weapons[rootweapon].default_attachment;
        newweapon = getweapon(newweapon.name, att);
    }
    return newweapon;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xc5596514, Offset: 0x2878
// Size: 0xda
function can_upgrade_weapon(weapon) {
    if (weapon == level.weaponnone || weapon == level.weaponzmfists || !is_weapon_included(weapon)) {
        return false;
    }
    weapon = get_nonalternate_weapon(weapon);
    rootweapon = weapon.rootweapon;
    if (!is_weapon_upgraded(rootweapon)) {
        upgraded_weapon = level.zombie_weapons[rootweapon].upgrade;
        return (isdefined(upgraded_weapon) && upgraded_weapon != level.weaponnone);
    }
    return false;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x3a7b8f0e, Offset: 0x2960
// Size: 0xce
function weapon_supports_aat(weapon) {
    if (!zm_custom::function_5638f689(#"zmsuperpapenabled")) {
        return false;
    }
    if (weapon == level.weaponnone || weapon == level.weaponzmfists) {
        return false;
    }
    weapontopack = get_nonalternate_weapon(weapon);
    rootweapon = weapontopack.rootweapon;
    if (!is_weapon_upgraded(rootweapon)) {
        return false;
    }
    if (!aat::is_exempt_weapon(weapontopack)) {
        return true;
    }
    return false;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x6990c0b8, Offset: 0x2a38
// Size: 0x82
function is_weapon_upgraded(weapon) {
    if (weapon == level.weaponnone || weapon == level.weaponzmfists) {
        return false;
    }
    weapon = get_nonalternate_weapon(weapon);
    rootweapon = weapon.rootweapon;
    if (isdefined(level.zombie_weapons_upgraded[rootweapon])) {
        return true;
    }
    return false;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x29c2010e, Offset: 0x2ac8
// Size: 0xee
function get_weapon_with_attachments(weapon) {
    weapon = get_nonalternate_weapon(weapon);
    if (self hasweapon(weapon.rootweapon, 1)) {
        if (is_weapon_included(weapon)) {
            var_e44dc8f1 = function_4f54ceec(weapon.rootweapon);
        }
        if (isdefined(var_e44dc8f1) && var_e44dc8f1.size) {
            return getweapon(weapon.rootweapon.name, var_e44dc8f1);
        } else {
            return self getbuildkitweapon(weapon.rootweapon);
        }
    }
    return undefined;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x131d19b4, Offset: 0x2bc0
// Size: 0x36
function has_weapon_or_attachments(weapon) {
    if (self hasweapon(weapon, 1)) {
        return true;
    }
    return false;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x6b1d4cff, Offset: 0x2c00
// Size: 0xe2
function has_upgrade(weapon) {
    weapon = get_nonalternate_weapon(weapon);
    rootweapon = weapon.rootweapon;
    has_upgrade = 0;
    if (isdefined(level.zombie_weapons[rootweapon]) && isdefined(level.zombie_weapons[rootweapon].upgrade)) {
        has_upgrade = self has_weapon_or_attachments(level.zombie_weapons[rootweapon].upgrade);
    }
    if (!has_upgrade && rootweapon.isballisticknife) {
        has_weapon = self zm_melee_weapon::function_9f93cad8();
    }
    return has_upgrade;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x2ab27fcf, Offset: 0x2cf0
// Size: 0x162
function has_weapon_or_upgrade(weapon) {
    weapon = get_nonalternate_weapon(weapon);
    rootweapon = weapon.rootweapon;
    upgradedweaponname = rootweapon;
    if (isdefined(level.zombie_weapons[rootweapon]) && isdefined(level.zombie_weapons[rootweapon].upgrade)) {
        upgradedweaponname = level.zombie_weapons[rootweapon].upgrade;
    }
    has_weapon = 0;
    if (isdefined(level.zombie_weapons[rootweapon])) {
        has_weapon = self has_weapon_or_attachments(rootweapon) || self has_upgrade(rootweapon);
    }
    if (!has_weapon && level.weaponballisticknife == rootweapon) {
        has_weapon = self zm_melee_weapon::function_52b66e86();
    }
    if (!has_weapon && zm_equipment::is_equipment(rootweapon)) {
        has_weapon = self zm_equipment::is_active(rootweapon);
    }
    return has_weapon;
}

// Namespace zm_weapons/zm_weapons
// Params 2, eflags: 0x0
// Checksum 0x3fc9964e, Offset: 0x2e60
// Size: 0x32
function add_shared_ammo_weapon(weapon, base_weapon) {
    level.zombie_weapons[weapon].shared_ammo_weapon = base_weapon;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xdb0338b6, Offset: 0x2ea0
// Size: 0x166
function get_shared_ammo_weapon(weapon) {
    weapon = get_nonalternate_weapon(weapon);
    rootweapon = weapon.rootweapon;
    weapons = self getweaponslist(1);
    foreach (w in weapons) {
        w = w.rootweapon;
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
// Params 1, eflags: 0x0
// Checksum 0xfe0c3d98, Offset: 0x3010
// Size: 0xfa
function get_player_weapon_with_same_base(weapon) {
    weapon = get_nonalternate_weapon(weapon);
    rootweapon = weapon.rootweapon;
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
// Params 0, eflags: 0x0
// Checksum 0x6e1e0e13, Offset: 0x3118
// Size: 0x12
function get_weapon_hint_ammo() {
    return #"hash_60606b68e93a29c8";
}

// Namespace zm_weapons/zm_weapons
// Params 2, eflags: 0x0
// Checksum 0xf1736ad0, Offset: 0x3138
// Size: 0x3c
function weapon_set_first_time_hint(cost, ammo_cost) {
    self sethintstring(get_weapon_hint_ammo());
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x1b59e2b7, Offset: 0x3180
// Size: 0xac
function function_11a37a(var_d074477d) {
    if (isdefined(level.pack_a_punch_camo_index_number_variants)) {
        if (isdefined(var_d074477d)) {
            var_39a21497 = var_d074477d + 1;
            if (var_39a21497 >= level.pack_a_punch_camo_index + level.pack_a_punch_camo_index_number_variants) {
                var_39a21497 = level.pack_a_punch_camo_index;
            }
            return var_39a21497;
        } else {
            var_39a21497 = randomintrange(0, level.pack_a_punch_camo_index_number_variants);
            return (level.pack_a_punch_camo_index + var_39a21497);
        }
        return;
    }
    return level.pack_a_punch_camo_index;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xdce5e55f, Offset: 0x3238
// Size: 0x198
function get_pack_a_punch_weapon_options(weapon) {
    if (!isdefined(self.pack_a_punch_weapon_options)) {
        self.pack_a_punch_weapon_options = [];
    }
    if (!is_weapon_upgraded(weapon)) {
        return self calcweaponoptions(0, 0, 0, 0, 0);
    }
    if (isdefined(self.pack_a_punch_weapon_options[weapon])) {
        return self.pack_a_punch_weapon_options[weapon];
    }
    camo_index = function_11a37a(undefined);
    reticle_index = randomintrange(0, 16);
    var_d2def126 = 0;
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
    self.pack_a_punch_weapon_options[weapon] = self calcweaponoptions(camo_index, reticle_index, var_d2def126);
    return self.pack_a_punch_weapon_options[weapon];
}

// Namespace zm_weapons/zm_weapons
// Params 0, eflags: 0x0
// Checksum 0x6d652774, Offset: 0x33d8
// Size: 0xa4
function function_f9d6b75e() {
    lethal_grenade = self zm_loadout::get_player_lethal_grenade();
    if (!self hasweapon(lethal_grenade)) {
        self giveweapon(lethal_grenade);
        self setweaponammoclip(lethal_grenade, 0);
        self switchtooffhand(lethal_grenade);
        self ability_util::gadget_reset(lethal_grenade, 0, 0, 1, 0);
    }
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xe3d3b270, Offset: 0x3488
// Size: 0x1a8
function give_build_kit_weapon(weapon) {
    camo = undefined;
    base_weapon = weapon;
    if (is_weapon_upgraded(weapon)) {
        if (isdefined(weapon.var_a61c0755)) {
            camo = weapon.var_a61c0755;
        } else {
            camo = function_11a37a(undefined);
        }
        base_weapon = get_base_weapon(weapon);
    }
    if (is_weapon_included(base_weapon)) {
        var_e44dc8f1 = function_4f54ceec(base_weapon.rootweapon);
    }
    if (isdefined(var_e44dc8f1) && var_e44dc8f1.size) {
        weapon = getweapon(weapon.rootweapon.name, var_e44dc8f1);
        if (!isdefined(camo)) {
            camo = 0;
        }
        weapon_options = self calcweaponoptions(camo, 0, 0);
    } else {
        weapon = self getbuildkitweapon(weapon);
        weapon_options = self getbuildkitweaponoptions(weapon, camo);
    }
    self giveweapon(weapon, weapon_options);
    return weapon;
}

// Namespace zm_weapons/zm_weapons
// Params 3, eflags: 0x0
// Checksum 0x833dd138, Offset: 0x3638
// Size: 0xb0
function weapon_give(weapon, nosound = 0, b_switch_weapon = 1) {
    if (!(isdefined(nosound) && nosound)) {
        self zm_utility::play_sound_on_ent("purchase");
    }
    weapon = self give_build_kit_weapon(weapon);
    if (!(isdefined(nosound) && nosound)) {
        self play_weapon_vo(weapon);
    }
    return weapon;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x10a20d45, Offset: 0x36f0
// Size: 0x3c
function weapon_take(weapon) {
    if (self hasweapon(weapon)) {
        self takeweapon(weapon);
    }
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x3650b1f6, Offset: 0x3738
// Size: 0x204
function play_weapon_vo(weapon) {
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
                self zm_audio::create_and_play_dialog("weapon_pickup", override);
                return;
            }
        }
    }
    if (isdefined(self.var_b15f6b06) && self.var_b15f6b06) {
        self.var_b15f6b06 = 0;
        self zm_audio::create_and_play_dialog("magicbox", "get_" + type);
        return;
    }
    if (type == "upgrade") {
        self zm_audio::create_and_play_dialog("weapon_pickup", "upgrade");
        return;
    }
    if (randomintrange(0, 100) <= 75 || type == "shield") {
        self zm_audio::create_and_play_dialog("weapon_pickup", type);
        return;
    }
    self zm_audio::create_and_play_dialog("weapon_pickup", "generic");
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xc9a9c03c, Offset: 0x3948
// Size: 0xc4
function weapon_type_check(weapon) {
    if (!isdefined(self.entity_num)) {
        return "crappy";
    }
    weapon = get_nonalternate_weapon(weapon);
    weapon = weapon.rootweapon;
    if (is_weapon_upgraded(weapon) && !self bgb::is_enabled(#"zm_bgb_wall_power")) {
        return "upgrade";
    }
    if (isdefined(level.zombie_weapons[weapon])) {
        return level.zombie_weapons[weapon].vox;
    }
    return "crappy";
}

// Namespace zm_weapons/zm_weapons
// Params 2, eflags: 0x0
// Checksum 0xcb65c6c9, Offset: 0x3a18
// Size: 0x29e
function ammo_give(weapon, b_purchased = 1) {
    var_ec4870b4 = 0;
    if (!zm_loadout::is_offhand_weapon(weapon)) {
        weapon = self get_weapon_with_attachments(weapon);
        if (isdefined(weapon)) {
            var_eab2ad75 = weapon.maxammo;
            var_aafdf12f = weapon.startammo;
            var_d14161fa = self getweaponammoclip(weapon);
            n_clip_size = weapon.clipsize;
            if (var_d14161fa < n_clip_size) {
                var_ec4870b4 = 1;
            }
            var_754818cc = 0;
            if (!var_ec4870b4 && weapon.dualwieldweapon != level.weaponnone) {
                var_754818cc = self getweaponammoclip(weapon.dualwieldweapon);
                var_79e798e4 = weapon.dualwieldweapon.clipsize;
                if (var_754818cc < var_79e798e4) {
                    var_ec4870b4 = 1;
                }
            }
            if (!var_ec4870b4) {
                var_8a5fff03 = self getammocount(weapon);
                if (self hasperk(#"specialty_mod_additionalprimaryweapon")) {
                    n_ammo_max = var_eab2ad75;
                } else {
                    n_ammo_max = var_aafdf12f;
                }
                if (var_8a5fff03 >= n_ammo_max + var_d14161fa + var_754818cc) {
                    var_ec4870b4 = 0;
                } else {
                    var_ec4870b4 = 1;
                }
            }
        }
    } else if (self has_weapon_or_upgrade(weapon)) {
        if (self getammocount(weapon) < weapon.maxammo) {
            var_ec4870b4 = 1;
        }
    }
    if (var_ec4870b4) {
        if (b_purchased) {
            self zm_utility::play_sound_on_ent("purchase");
        }
        self function_d13d5303(weapon);
        return 1;
    }
    if (!var_ec4870b4) {
        return 0;
    }
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x35943545, Offset: 0x3cc0
// Size: 0x216
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
// Params 2, eflags: 0x0
// Checksum 0xd9dc9612, Offset: 0x3ee0
// Size: 0x40e
function get_player_weapondata(player, weapon) {
    weapondata = [];
    if (!isdefined(weapon)) {
        weapon = player getcurrentweapon();
    }
    weapondata[#"weapon"] = weapon;
    if (weapondata[#"weapon"] != level.weaponnone) {
        weapondata[#"clip"] = player getweaponammoclip(weapon);
        weapondata[#"stock"] = player getweaponammostock(weapon);
        weapondata[#"fuel"] = player getweaponammofuel(weapon);
        weapondata[#"heat"] = player isweaponoverheating(1, weapon);
        weapondata[#"overheat"] = player isweaponoverheating(0, weapon);
        if (weapon.isgadget) {
            slot = player gadgetgetslot(weapon);
            weapondata[#"power"] = player gadgetpowerget(slot);
        }
        if (weapon.isriotshield) {
            weapondata[#"health"] = player.weaponhealth;
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
        weapondata[#"lh_clip"] = player getweaponammoclip(dw_weapon);
    } else {
        weapondata[#"lh_clip"] = 0;
    }
    alt_weapon = weapon.altweapon;
    if (alt_weapon != level.weaponnone) {
        weapondata[#"alt_clip"] = player getweaponammoclip(alt_weapon);
        weapondata[#"alt_stock"] = player getweaponammostock(alt_weapon);
    } else {
        weapondata[#"alt_clip"] = 0;
        weapondata[#"alt_stock"] = 0;
    }
    if (isdefined(player.aat) && isdefined(player.aat[weapon])) {
        weapondata[#"aat"] = player.aat[weapon];
    }
    return weapondata;
}

// Namespace zm_weapons/zm_weapons
// Params 2, eflags: 0x0
// Checksum 0x5046148b, Offset: 0x42f8
// Size: 0xce
function weapon_is_better(left, right) {
    if (left != right) {
        left_upgraded = !isdefined(level.zombie_weapons[left]);
        right_upgraded = !isdefined(level.zombie_weapons[right]);
        if (left_upgraded && right_upgraded) {
            var_74d3322f = get_attachment_index(left);
            var_c82602ca = get_attachment_index(right);
            return (var_74d3322f > var_c82602ca);
        } else if (left_upgraded) {
            return true;
        }
    }
    return false;
}

// Namespace zm_weapons/zm_weapons
// Params 2, eflags: 0x0
// Checksum 0xc0a4d838, Offset: 0x43d0
// Size: 0x616
function merge_weapons(oldweapondata, newweapondata) {
    weapondata = [];
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
// Params 1, eflags: 0x0
// Checksum 0x28f636c5, Offset: 0x49f0
// Size: 0x488
function weapondata_give(weapondata) {
    current = self get_player_weapon_with_same_base(weapondata[#"weapon"]);
    if (isdefined(current)) {
        curweapondata = get_player_weapondata(self, current);
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
    if (dw_weapon != level.weaponnone) {
        if (!self hasweapon(dw_weapon)) {
            self giveweapon(dw_weapon);
        }
        self setweaponammoclip(dw_weapon, weapondata[#"lh_clip"]);
    }
    alt_weapon = weapon.altweapon;
    if (alt_weapon != level.weaponnone) {
        if (!self hasweapon(alt_weapon)) {
            self giveweapon(alt_weapon);
        }
        self setweaponammoclip(alt_weapon, weapondata[#"alt_clip"]);
        self setweaponammostock(alt_weapon, weapondata[#"alt_stock"]);
    }
    if (isdefined(weapondata[#"aat"])) {
        self aat::acquire(weapon, weapondata[#"aat"]);
    }
    return weapon;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x862ce8a1, Offset: 0x4e80
// Size: 0x12e
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
    for (alt_weapon = weapon.altweapon; alt_weapon != level.weaponnone; alt_weapon = alt_weapon.altweapon) {
        if (self hasweapon(alt_weapon)) {
            self weapon_take(alt_weapon);
        }
    }
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xe957d32b, Offset: 0x4fb8
// Size: 0x19e
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
            println("<dev string:xff>" + weapon.name);
        }
        loadout.weapons[weapon.name] = get_default_weapondata(weapon);
        if (!isdefined(loadout.current)) {
            loadout.current = weapon;
        }
    }
    return loadout;
}

// Namespace zm_weapons/zm_weapons
// Params 0, eflags: 0x0
// Checksum 0x1ca748b2, Offset: 0x5160
// Size: 0x106
function player_get_loadout() {
    loadout = spawnstruct();
    loadout.current = self getcurrentweapon();
    loadout.stowed = self getstowedweapon();
    loadout.weapons = [];
    foreach (weapon in self getweaponslist()) {
        loadout.weapons[weapon.name] = get_player_weapondata(self, weapon);
    }
    return loadout;
}

// Namespace zm_weapons/zm_weapons
// Params 3, eflags: 0x0
// Checksum 0xc6b1dd75, Offset: 0x5270
// Size: 0x2ac
function player_give_loadout(loadout, replace_existing = 1, immediate_switch = 0) {
    if (isdefined(replace_existing) && replace_existing) {
        self takeallweapons();
    }
    foreach (weapondata in loadout.weapons) {
        if (isdefined(weapondata[#"weapon"].isheroweapon) && weapondata[#"weapon"].isheroweapon) {
            self zm_hero_weapon::hero_give_weapon(self.var_c332c9d4, 0);
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
// Checksum 0xe13b7448, Offset: 0x5528
// Size: 0x88
function player_take_loadout(loadout) {
    foreach (weapondata in loadout.weapons) {
        self weapondata_take(weapondata);
    }
}

// Namespace zm_weapons/zm_weapons
// Params 2, eflags: 0x0
// Checksum 0x832164d4, Offset: 0x55b8
// Size: 0x5e
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
// Checksum 0x634d20f4, Offset: 0x5620
// Size: 0x54
function set_stowed_weapon(weapon) {
    self.weapon_stowed = weapon;
    if (!(isdefined(self.stowed_weapon_suppressed) && self.stowed_weapon_suppressed)) {
        self setstowedweapon(self.weapon_stowed);
    }
}

// Namespace zm_weapons/zm_weapons
// Params 0, eflags: 0x0
// Checksum 0xfd2becd1, Offset: 0x5680
// Size: 0x34
function clear_stowed_weapon() {
    self notify(#"hash_70957a1035bda74b");
    self.weapon_stowed = undefined;
    self clearstowedweapon();
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0x8183125c, Offset: 0x56c0
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
// Params 1, eflags: 0x0
// Checksum 0x630b759b, Offset: 0x5738
// Size: 0x24
function checkstringvalid(hash_or_str) {
    if (hash_or_str != "") {
        return hash_or_str;
    }
    return undefined;
}

// Namespace zm_weapons/zm_weapons
// Params 2, eflags: 0x0
// Checksum 0x3cdc2d7c, Offset: 0x5768
// Size: 0x3c4
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
        var_1549a8fc = row[17];
        limit = row[12];
        upgrade_limit = row[13];
        content_restrict = row[14];
        wallbuy_autospawn = row[15];
        weapon_class = checkstringvalid(row[16]);
        is_wonder_weapon = row[18];
        var_e44dc8f1 = tolower(row[19]);
        zm_utility::include_weapon(weapon_name, in_box);
        if (isdefined(upgrade_name)) {
            zm_utility::include_weapon(upgrade_name, upgrade_in_box);
        }
        add_zombie_weapon(weapon_name, upgrade_name, hint, cost, weaponvo, weaponvoresp, ammo_cost, create_vox, weapon_class, is_wonder_weapon, var_e44dc8f1);
        if (is_limited) {
            if (isdefined(limit)) {
                add_limited_weapon(weapon_name, limit);
            }
            if (isdefined(upgrade_limit) && isdefined(upgrade_name)) {
                add_limited_weapon(upgrade_name, upgrade_limit);
            }
        }
        if (var_1549a8fc && isdefined(upgrade_name)) {
            aat::register_aat_exemption(getweapon(upgrade_name));
        }
        index++;
    }
    level flag::set("zm_weapons_table_loaded");
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xe6aaa70b, Offset: 0x5b38
// Size: 0x64
function is_wonder_weapon(w_to_check) {
    w_base = get_base_weapon(w_to_check);
    if (isdefined(level.zombie_weapons[w_base]) && level.zombie_weapons[w_base].is_wonder_weapon) {
        return true;
    }
    return false;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xbe524921, Offset: 0x5ba8
// Size: 0xc6
function is_tactical_rifle(w_to_check) {
    var_45961e97 = array(getweapon(#"tr_leveraction_t8"), getweapon(#"tr_longburst_t8"), getweapon(#"tr_midburst_t8"), getweapon(#"tr_powersemi_t8"));
    if (isinarray(var_45961e97, w_to_check)) {
        return true;
    }
    return false;
}

// Namespace zm_weapons/zm_weapons
// Params 1, eflags: 0x0
// Checksum 0xf6a83533, Offset: 0x5c78
// Size: 0x9c
function function_d13d5303(w_weapon) {
    if (zm_loadout::function_65f8e85(w_weapon)) {
        return;
    }
    self setweaponammoclip(w_weapon, w_weapon.clipsize);
    if (self hasperk(#"specialty_extraammo")) {
        self givemaxammo(w_weapon);
        return;
    }
    self givestartammo(w_weapon);
}

