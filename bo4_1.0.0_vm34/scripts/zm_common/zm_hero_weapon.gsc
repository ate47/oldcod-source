#using scripts\abilities\ability_player;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\trials\zm_trial_disable_hero_weapons;
#using scripts\zm_common\trials\zm_trial_restrict_loadout;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_cleanup_mgr;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;

#namespace zm_hero_weapon;

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 0, eflags: 0x2
// Checksum 0x80ef579a, Offset: 0x220
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_hero_weapons", &__init__, undefined, #"gadget_hero_weapon");
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 0, eflags: 0x0
// Checksum 0x5da44670, Offset: 0x270
// Size: 0x262
function __init__() {
    level.var_6684a3ec = 1;
    level.var_97b2d700 = 2;
    level.hero_power_update = &function_67f820d2;
    clientfield::register("clientuimodel", "zmhud.weaponLevel", 1, 2, "int");
    clientfield::register("clientuimodel", "zmhud.weaponProgression", 1, 5, "float");
    clientfield::register("clientuimodel", "zmhud.swordEnergy", 1, 7, "float");
    clientfield::register("clientuimodel", "zmhud.swordState", 1, 4, "int");
    clientfield::register("clientuimodel", "zmhud.swordChargeUpdate", 1, 1, "counter");
    level.var_6cea9770 = [];
    level.var_a56b2383 = [];
    level.var_b6637d85 = [];
    level.var_ab8b4742 = 1;
    if (zm_custom::function_5638f689(#"zmspecweaponchargerate") == 2) {
        level.var_ab8b4742 = 2;
    }
    if (zm_custom::function_5638f689(#"zmspecweaponchargerate") == 0) {
        level.var_ab8b4742 = 0.5;
    }
    ability_player::register_gadget_activation_callbacks(11, &hero_weapon_on, &hero_weapon_off);
    ability_player::register_gadget_ready_callbacks(11, &hero_weapon_ready);
    /#
        level thread function_6499ac95();
        level.var_3edcced1 = &function_3edcced1;
    #/
    level.var_864d5cc1 = 0;
}

/#

    // Namespace zm_hero_weapon/zm_hero_weapon
    // Params 0, eflags: 0x0
    // Checksum 0x282eb34c, Offset: 0x4e0
    // Size: 0x3c
    function function_6499ac95() {
        adddebugcommand("<dev string:x30>");
        adddebugcommand("<dev string:x86>");
    }

    // Namespace zm_hero_weapon/zm_hero_weapon
    // Params 1, eflags: 0x0
    // Checksum 0xb13e10d7, Offset: 0x528
    // Size: 0x126
    function function_3edcced1(weapon_name) {
        self.var_c332c9d4 = getweapon(weapon_name);
        var_be120776 = getsubstr(weapon_name, weapon_name.size - 1, weapon_name.size);
        weapon_level = int(var_be120776) - 1;
        self.var_4dcf5f7f = weapon_level;
        self function_d8c1ed52();
        self clientfield::set_player_uimodel("<dev string:xde>", self.var_4dcf5f7f);
        self hero_give_weapon(self.var_c332c9d4, 1);
        self.var_ee259215 = 0;
        self.var_a6ae9c19 = 0;
        self.var_d4541f5d = 0;
        self.var_dc04fa21 = 0;
        self.var_3d31f2 = 0;
    }

#/

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 2, eflags: 0x0
// Checksum 0x687a585b, Offset: 0x658
// Size: 0x74
function function_cc0db168(slot, enabled) {
    if (isdefined(level.var_b9827cc4) && level.var_b9827cc4) {
        self function_1d590050(slot, 1);
        return;
    }
    self function_1d590050(slot, enabled);
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 2, eflags: 0x0
// Checksum 0x7daf92a2, Offset: 0x6d8
// Size: 0x1e4
function function_2d770b7b(var_76bb2b3a, var_2ba9b8b7) {
    if (self gadgetisactive(level.var_97b2d700)) {
        if (isdefined(self.talisman_special_xp_rate)) {
            n_scalar = self.talisman_special_xp_rate;
        } else {
            n_scalar = 1;
        }
        if (isdefined(var_2ba9b8b7)) {
            self.var_a6ae9c19 += var_2ba9b8b7 * n_scalar;
            self.var_e4c7ec41 += var_2ba9b8b7 * n_scalar;
        } else {
            self.var_a6ae9c19 += 1 * n_scalar;
            self.var_e4c7ec41 += 1 * n_scalar;
        }
    }
    if (isdefined(level.var_b9827cc4) && level.var_b9827cc4 && var_76bb2b3a > 0 && !self gadgetisactive(level.var_97b2d700)) {
        current_power = self gadgetpowerget(level.var_97b2d700);
        if (self hasperk(#"specialty_mod_cooldown")) {
            var_76bb2b3a = 0.15 * var_76bb2b3a;
        }
        current_power += level.var_ab8b4742 * 100 / var_76bb2b3a;
        if (current_power > 100) {
            current_power = 100;
        }
        self gadgetpowerset(level.var_97b2d700, current_power);
    }
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 2, eflags: 0x0
// Checksum 0x2a48bf53, Offset: 0x8c8
// Size: 0x284
function function_ef8b2953(var_76bb2b3a, n_points) {
    if (self gadgetisactive(level.var_97b2d700) || isdefined(level.var_12d4e9a9) && level.var_12d4e9a9) {
        self.var_dc04fa21 += n_points;
        self.var_74f06e59 += n_points;
    }
    if (isdefined(level.var_6684a3ec) && level.var_6684a3ec && var_76bb2b3a > 0 && !self gadgetisactive(level.var_97b2d700)) {
        current_power = self gadgetpowerget(level.var_97b2d700);
        if (current_power == 100) {
            return;
        }
        var_18c99f37 = 0;
        if (self hasperk(#"specialty_mod_cooldown")) {
            var_18c99f37 += 0.15;
        }
        if (self bgb::is_enabled(#"zm_bgb_arsenal_accelerator")) {
            var_18c99f37 += 0.15;
        }
        if (var_18c99f37 > 0) {
            n_points += n_points * var_18c99f37;
        }
        if (current_power == 0) {
            self.var_3d31f2 = level.var_ab8b4742 * n_points;
        } else {
            var_6555109d = current_power / 100;
            self.var_3d31f2 = var_76bb2b3a * var_6555109d;
            self.var_3d31f2 += level.var_ab8b4742 * n_points;
        }
        self thread function_a9646d59(n_points);
        var_6555109d = self.var_3d31f2 / var_76bb2b3a;
        current_power = 100 * var_6555109d;
        if (current_power > 100) {
            current_power = 100;
        }
        self gadgetpowerset(level.var_97b2d700, current_power);
    }
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 1, eflags: 0x0
// Checksum 0x4d4bbff9, Offset: 0xb58
// Size: 0x24c
function function_a9646d59(n_points) {
    if (self.var_201eb678 < 100) {
        self.var_1a095052 += n_points;
        if (self.var_1a095052 >= self.var_de6dbd80) {
            self.var_1a095052 = 0;
            switch (self.var_4dcf5f7f) {
            case 1:
                if (isdefined(level.var_b6637d85[self.var_a15119ad]) && isdefined(level.var_b6637d85[self.var_a15119ad][self.var_4dcf5f7f])) {
                    self.var_de6dbd80 += level.var_b6637d85[self.var_a15119ad][self.var_4dcf5f7f];
                } else {
                    self.var_de6dbd80 += 100;
                }
                break;
            case 2:
                if (isdefined(level.var_b6637d85[self.var_a15119ad]) && isdefined(level.var_b6637d85[self.var_a15119ad][self.var_4dcf5f7f])) {
                    self.var_de6dbd80 += level.var_b6637d85[self.var_a15119ad][self.var_4dcf5f7f];
                } else {
                    self.var_de6dbd80 += 150;
                }
                break;
            default:
                if (isdefined(level.var_b6637d85[self.var_a15119ad]) && isdefined(level.var_b6637d85[self.var_a15119ad][self.var_4dcf5f7f])) {
                    self.var_de6dbd80 += level.var_b6637d85[self.var_a15119ad][self.var_4dcf5f7f];
                } else {
                    self.var_de6dbd80 += 50;
                }
                break;
            }
            self.var_201eb678++;
        }
    }
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 0, eflags: 0x0
// Checksum 0x1ea6cacd, Offset: 0xdb0
// Size: 0x2dc
function hero_weapon_player_init() {
    if (!isdefined(self.var_c332c9d4)) {
        self.var_c332c9d4 = self zm_loadout::function_2e08c289("herogadget");
        self.var_4dcf5f7f = 0;
        self.var_74f06e59 = 0;
        if (isdefined(self.talisman_special_startlv3) && self.talisman_special_startlv3) {
            self function_7c3450e(2);
            self.var_ed2ea758 = 1;
        }
        if (isdefined(self.talisman_special_startlv2) && self.talisman_special_startlv2) {
            self function_7c3450e(1);
            self.var_133121c1 = 1;
        }
        self function_d8c1ed52();
        if (isdefined(self.talisman_special_startlv2) && self.talisman_special_startlv2) {
            if (isdefined(level.var_6cea9770[self.var_a15119ad])) {
                self.var_74f06e59 = level.var_6cea9770[self.var_a15119ad][1];
            } else {
                self.var_74f06e59 = 2800;
            }
        }
        if (isdefined(self.talisman_special_startlv3) && self.talisman_special_startlv3) {
            if (isdefined(level.var_6cea9770[self.var_a15119ad])) {
                self.var_74f06e59 = level.var_6cea9770[self.var_a15119ad][2];
            } else {
                self.var_74f06e59 = 8000;
            }
        }
        self.var_e4c7ec41 = 0;
        self.var_a6ae9c19 = 0;
        self.var_ee259215 = 0;
        self.var_dc04fa21 = 0;
        self.var_d4541f5d = 0;
        self.var_3d31f2 = 0;
        self.var_1a095052 = 0;
        self.var_201eb678 = 0;
        self.var_9790532 = 0;
    }
    if (zm_custom::function_5638f689(#"zmspecweaponisenabled")) {
        self hero_give_weapon(self.var_c332c9d4, 0);
        if (self.var_c332c9d4.isgadget) {
            slot = self gadgetgetslot(self.var_c332c9d4);
            var_79b5bc7a = isdefined(self.firstspawn) ? self.firstspawn : 1;
            if (slot >= 0 && var_79b5bc7a) {
                self gadgetpowerreset(slot, 1);
            }
        }
    }
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 0, eflags: 0x0
// Checksum 0x7b8357ce, Offset: 0x1098
// Size: 0x104
function function_5a7ce105() {
    self.var_e4c7ec41 = 0;
    self.var_a6ae9c19 = 0;
    self.var_ee259215 = 0;
    self.var_dc04fa21 = 0;
    self.var_d4541f5d = 0;
    self.var_3d31f2 = 0;
    self.var_1a095052 = 0;
    self.var_201eb678 = 0;
    self.var_9790532 = 0;
    if (zm_custom::function_5638f689(#"zmspecweaponisenabled")) {
        self hero_give_weapon(self.var_c332c9d4, 0);
        if (self.var_c332c9d4.isgadget) {
            n_slot = self gadgetgetslot(self.var_c332c9d4);
            self gadgetpowerreset(n_slot, 0);
        }
    }
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 1, eflags: 0x0
// Checksum 0x4f0f3615, Offset: 0x11a8
// Size: 0xda
function function_674fdf03(n_level = 3) {
    if (isdefined(level.var_6cea9770[self.var_a15119ad])) {
        self.var_74f06e59 = level.var_6cea9770[self.var_a15119ad][n_level - 1];
        return;
    }
    switch (n_level) {
    case 3:
        self.var_74f06e59 = 8000;
        break;
    case 2:
        self.var_74f06e59 = 2800;
        break;
    case 1:
    default:
        self.var_74f06e59 = 0;
        break;
    }
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 0, eflags: 0x0
// Checksum 0x762d74d9, Offset: 0x1290
// Size: 0xe6
function function_d8c1ed52() {
    foreach (h_key, a_weaponlist in level.hero_weapon) {
        if (isinarray(a_weaponlist, self.var_c332c9d4)) {
            self.var_c332c9d4 = a_weaponlist[self.var_4dcf5f7f];
            self.var_a15119ad = h_key;
            return;
        }
    }
    self.var_c332c9d4 = level.hero_weapon[#"chakram"][self.var_4dcf5f7f];
    self.var_a15119ad = "chakram";
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 2, eflags: 0x0
// Checksum 0xf36d93cf, Offset: 0x1380
// Size: 0x2f6
function hero_give_weapon(weapon, enabled) {
    if (!self hasweapon(weapon)) {
        if (isdefined(self._gadgets_player) && isdefined(self._gadgets_player[level.var_97b2d700])) {
            self notify(#"hero_weapon_take", {#weapon:self._gadgets_player[level.var_97b2d700]});
            self takeweapon(self._gadgets_player[level.var_97b2d700]);
        }
        self zm_loadout::set_player_hero_weapon(weapon);
        self.var_c332c9d4 = weapon;
        self notify(#"hero_weapon_give", {#weapon:weapon});
        self giveweapon(weapon);
        self thread function_166dc5ca();
        if (isdefined(level.var_12d4e9a9) && level.var_12d4e9a9) {
        } else if (enabled) {
            self gadgetpowerset(level.var_97b2d700, 100);
            self gadgetcharging(level.var_97b2d700, 0);
            self function_cc0db168(level.var_97b2d700, 0);
        } else {
            self gadgetpowerset(level.var_97b2d700, 0);
            self gadgetcharging(level.var_97b2d700, 0);
            self function_cc0db168(level.var_97b2d700, 1);
        }
        function_79630e36(weapon);
        return;
    }
    if (enabled && !(isdefined(level.var_12d4e9a9) && level.var_12d4e9a9)) {
        self gadgetpowerset(level.var_97b2d700, 100);
        self gadgetcharging(level.var_97b2d700, 0);
        self function_cc0db168(level.var_97b2d700, 0);
        self.var_a6ae9c19 = 0;
        self.var_dc04fa21 = 0;
        self.var_3d31f2 = 0;
    }
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 1, eflags: 0x0
// Checksum 0x4bf1bf60, Offset: 0x1680
// Size: 0x2b4
function function_79630e36(weapon) {
    var_e5d5740e = array(#"hero_chakram_lv3", #"hero_hammer_lv3", #"hero_scepter_lv3", #"hero_sword_pistol_lv3", #"hero_flamethrower_t8_lv3", #"hero_gravityspikes_t8_lv3", #"hero_katana_t8_lv3", #"hero_minigun_t8_lv3");
    i = 0;
    var_f29689d4 = [];
    do {
        weapon_name = self stats::get_stat(#"heroweaponsmaxed", i);
        if (isdefined(weapon_name) && weapon_name) {
            if (!isdefined(var_f29689d4)) {
                var_f29689d4 = [];
            } else if (!isarray(var_f29689d4)) {
                var_f29689d4 = array(var_f29689d4);
            }
            if (!isinarray(var_f29689d4, hash(weapon_name))) {
                var_f29689d4[var_f29689d4.size] = hash(weapon_name);
            }
            i++;
            continue;
        }
        break;
    } while (i < 8);
    if (isinarray(var_e5d5740e, weapon.name)) {
        if (!isinarray(var_f29689d4, weapon.name)) {
            if (!isdefined(var_f29689d4)) {
                var_f29689d4 = [];
            } else if (!isarray(var_f29689d4)) {
                var_f29689d4 = array(var_f29689d4);
            }
            var_f29689d4[var_f29689d4.size] = weapon.name;
            stats::set_stat(#"heroweaponsmaxed", i, weapon.name);
        }
    }
    var_eba65914 = array::exclude(var_e5d5740e, var_f29689d4);
    if (!var_eba65914.size) {
        self zm_utility::giveachievement_wrapper("zm_trophy_jack_of_all_blades");
    }
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 2, eflags: 0x0
// Checksum 0xf9356271, Offset: 0x1940
// Size: 0x164
function hero_weapon_on(n_slot, w_hero) {
    self notify(#"hero_weapon_power_on");
    self addweaponstat(w_hero, #"used", 1);
    level.var_864d5cc1 = 1;
    level notify(#"hero_weapon_activated", {#e_player:self, #weapon:w_hero});
    self notify(#"hero_weapon_activated");
    self thread zm_audio::function_8de4aa95(w_hero);
    self thread function_58c005f3(w_hero);
    self zm_stats::increment_client_stat("special_weapon_used");
    self zm_stats::increment_player_stat("special_weapon_used");
    self zm_stats::increment_client_stat("special_weapon_uses");
    self zm_stats::increment_player_stat("special_weapon_uses");
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 2, eflags: 0x0
// Checksum 0xfe26188e, Offset: 0x1ab0
// Size: 0x26
function hero_weapon_off(n_slot, w_hero) {
    self notify(#"hero_weapon_power_off");
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 2, eflags: 0x0
// Checksum 0x87b317b, Offset: 0x1ae0
// Size: 0x84
function hero_weapon_ready(n_slot, w_hero) {
    self thread zm_audio::function_12c67fee(w_hero);
    if (zm_utility::is_standard()) {
        n_index = randomintrangeinclusive(0, 2);
        level thread zm_audio::sndannouncerplayvox("hero_weapon_ready_" + n_index, self);
    }
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 2, eflags: 0x0
// Checksum 0x91ad903f, Offset: 0x1b70
// Size: 0x172
function function_c72ae4f7(weapon_level, enabled) {
    self notify(#"hash_6b01968912321cc5");
    self endon(#"hash_6b01968912321cc5", #"disconnect");
    self.var_591c521 = 1;
    self.var_ee259215 = 0;
    self.var_a6ae9c19 = 0;
    self.var_dc04fa21 = 0;
    while (self gadgetisactive(level.var_97b2d700) || isdefined(self.var_809bd952) && self.var_809bd952 || isdefined(self.var_74f7c24c) && self.var_74f7c24c) {
        wait 1;
    }
    wait 0.1;
    self playsound("zmb_weapon_upgrade_to_lvl_" + weapon_level + 1);
    self hero_give_weapon(level.hero_weapon[self.var_a15119ad][weapon_level], enabled);
    self function_7c3450e(weapon_level);
    self.var_3d31f2 = 0;
    self.var_591c521 = 0;
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 2, eflags: 0x0
// Checksum 0xfc6f5b51, Offset: 0x1cf0
// Size: 0x47c
function function_f56bbe3f(e_player, ai_enemy) {
    /#
        var_51871b9c = getdvarstring(#"hash_16e05c0b86ebb83d", "<dev string:xf0>");
        if (var_51871b9c == "<dev string:xf8>") {
            return;
        }
    #/
    if (isdefined(e_player.var_f5b9f476) && e_player.var_f5b9f476) {
        return;
    }
    if (isdefined(ai_enemy) && isdefined(ai_enemy.var_f197caf2)) {
        var_2ba9b8b7 = ai_enemy.var_f197caf2;
    }
    if (isdefined(level.var_6cea9770[e_player.var_a15119ad])) {
        var_899002bf = level.var_6cea9770[e_player.var_a15119ad][0];
        var_df1e33da = level.var_6cea9770[e_player.var_a15119ad][1];
        var_81e07f85 = level.var_6cea9770[e_player.var_a15119ad][2];
    } else {
        var_899002bf = 0;
        var_df1e33da = 2;
        var_81e07f85 = 4;
    }
    if (isdefined(level.var_a56b2383[e_player.var_a15119ad])) {
        var_ef2443d9 = level.var_a56b2383[e_player.var_a15119ad][0];
        var_2a45ae16 = level.var_a56b2383[e_player.var_a15119ad][1];
        var_491d356f = level.var_a56b2383[e_player.var_a15119ad][2];
    } else {
        var_ef2443d9 = 25;
        var_2a45ae16 = 40;
        var_491d356f = 60;
    }
    if (e_player.var_e4c7ec41 >= var_81e07f85) {
        e_player function_2d770b7b(var_491d356f, var_2ba9b8b7);
    } else if (e_player.var_e4c7ec41 >= var_df1e33da) {
        e_player function_2d770b7b(var_2a45ae16, var_2ba9b8b7);
        e_player.var_ee259215 = e_player.var_a6ae9c19 / (var_81e07f85 - var_df1e33da);
    } else if (e_player.var_e4c7ec41 >= var_899002bf) {
        e_player function_2d770b7b(var_ef2443d9, var_2ba9b8b7);
        e_player.var_ee259215 = e_player.var_a6ae9c19 / (var_df1e33da - var_899002bf);
    } else {
        e_player function_2d770b7b(0, var_2ba9b8b7);
        e_player.var_ee259215 = e_player.var_a6ae9c19 / var_899002bf;
    }
    if (!isdefined(e_player.var_ed2ea758)) {
        e_player.var_ed2ea758 = 0;
    }
    if (!isdefined(e_player.var_133121c1)) {
        e_player.var_133121c1 = 0;
    }
    if (e_player.var_e4c7ec41 >= var_81e07f85 && !e_player.var_ed2ea758 && e_player.var_133121c1) {
        e_player.var_ed2ea758 = 1;
        e_player function_c72ae4f7(2, 0);
    } else if (e_player.var_e4c7ec41 >= var_df1e33da && !e_player.var_ed2ea758 && !e_player.var_133121c1) {
        e_player.var_133121c1 = 1;
        e_player function_c72ae4f7(1, 0);
    }
    e_player function_1826521d(e_player.var_ee259215);
    e_player clientfield::set_player_uimodel("zmhud.swordState", 1);
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 3, eflags: 0x0
// Checksum 0x523f2016, Offset: 0x2178
// Size: 0x58c
function function_67f820d2(e_player, n_points, str_event) {
    /#
        var_51871b9c = getdvarstring(#"hash_16e05c0b86ebb83d", "<dev string:xf0>");
        if (var_51871b9c == "<dev string:xf8>") {
            return;
        }
    #/
    if (isdefined(e_player.var_f5b9f476) && e_player.var_f5b9f476 || isentity(n_points)) {
        return;
    }
    if (isdefined(str_event) && !(isdefined(level.var_3aa3170c) && level.var_3aa3170c)) {
        switch (str_event) {
        case #"carpenter_powerup":
        case #"nuke_powerup":
        case #"bonus_points_powerup_shared":
        case #"bonus_points_powerup":
            return;
        }
    }
    var_60b7d8c4 = zm_score::get_points_multiplier(e_player);
    if (!(isdefined(level.var_3aa3170c) && level.var_3aa3170c) && var_60b7d8c4 > 1) {
        n_points /= var_60b7d8c4;
    }
    if (isdefined(e_player.talisman_special_xp_rate)) {
        n_scalar = e_player.talisman_special_xp_rate;
    } else {
        n_scalar = 1;
    }
    if (isdefined(level.var_6cea9770[e_player.var_a15119ad])) {
        var_d3dd9947 = floor(level.var_6cea9770[e_player.var_a15119ad][0] / n_scalar);
        var_c7ba75d4 = floor(level.var_6cea9770[e_player.var_a15119ad][1] / n_scalar);
        var_825ed76d = floor(level.var_6cea9770[e_player.var_a15119ad][2] / n_scalar);
    } else {
        var_d3dd9947 = floor(0 / n_scalar);
        var_c7ba75d4 = floor(2800 / n_scalar);
        var_825ed76d = floor(8000 / n_scalar);
    }
    if (isdefined(level.var_a56b2383[e_player.var_a15119ad])) {
        if (!isdefined(e_player.var_de6dbd80)) {
            e_player.var_de6dbd80 = level.var_a56b2383[e_player.var_a15119ad];
        }
    } else if (!isdefined(e_player.var_de6dbd80)) {
        e_player.var_de6dbd80 = 3000;
    }
    if (e_player.var_74f06e59 >= var_c7ba75d4) {
        e_player.var_d4541f5d = e_player.var_dc04fa21 / (var_825ed76d - var_c7ba75d4);
    } else if (e_player.var_74f06e59 >= var_d3dd9947) {
        e_player.var_d4541f5d = e_player.var_dc04fa21 / (var_c7ba75d4 - var_d3dd9947);
    } else {
        e_player.var_d4541f5d = e_player.var_dc04fa21 / var_d3dd9947;
    }
    var_6dd8dcbb = e_player.var_de6dbd80;
    e_player function_ef8b2953(var_6dd8dcbb, n_points);
    if (!isdefined(e_player.var_ed2ea758)) {
        e_player.var_ed2ea758 = 0;
    }
    if (!isdefined(e_player.var_133121c1)) {
        e_player.var_133121c1 = 0;
    }
    if (e_player.var_74f06e59 >= var_825ed76d && !e_player.var_ed2ea758 && e_player.var_133121c1) {
        e_player.var_ed2ea758 = 1;
        e_player function_c72ae4f7(2, 0);
    } else if (e_player.var_74f06e59 >= var_c7ba75d4 && !e_player.var_ed2ea758 && !e_player.var_133121c1) {
        e_player.var_133121c1 = 1;
        e_player function_c72ae4f7(1, 0);
    }
    if (!(isdefined(e_player.var_591c521) && e_player.var_591c521)) {
        e_player function_1826521d(e_player.var_d4541f5d);
        e_player clientfield::set_player_uimodel("zmhud.swordState", 1);
    }
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 1, eflags: 0x0
// Checksum 0x7804a8d3, Offset: 0x2710
// Size: 0x2c
function function_1826521d(n_progress) {
    self clientfield::set_player_uimodel("zmhud.weaponProgression", n_progress);
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 1, eflags: 0x0
// Checksum 0xb8f83a90, Offset: 0x2748
// Size: 0x44
function function_7c3450e(n_level) {
    if (self.var_4dcf5f7f < n_level) {
        self.var_4dcf5f7f = n_level;
        self clientfield::set_player_uimodel("zmhud.weaponLevel", n_level);
    }
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 4, eflags: 0x0
// Checksum 0xbde53ab6, Offset: 0x2798
// Size: 0x8c
function function_dceb0db8(str_name, n_lvl1, n_lvl2, n_lvl3) {
    level.var_6cea9770[str_name] = [];
    level.var_6cea9770[str_name][0] = n_lvl1;
    level.var_6cea9770[str_name][1] = n_lvl2;
    level.var_6cea9770[str_name][2] = n_lvl3;
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 2, eflags: 0x0
// Checksum 0xda3d424f, Offset: 0x2830
// Size: 0x42
function function_97942345(str_name, var_aa135232) {
    level.var_a56b2383[str_name] = [];
    level.var_a56b2383[str_name] = var_aa135232;
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 4, eflags: 0x0
// Checksum 0x3956ba39, Offset: 0x2880
// Size: 0x8c
function function_e1170d9b(str_name, var_f2860811, var_1888827a, var_3e8afce3) {
    level.var_b6637d85[str_name] = [];
    level.var_b6637d85[str_name][0] = var_f2860811;
    level.var_b6637d85[str_name][1] = var_1888827a;
    level.var_b6637d85[str_name][2] = var_3e8afce3;
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 1, eflags: 0x0
// Checksum 0x9db319fb, Offset: 0x2918
// Size: 0x14c
function function_58c005f3(w_weapon) {
    self notify(#"hash_5ef1cf6d910b343b");
    self endon(#"hash_5ef1cf6d910b343b", #"hero_weapon_take", #"disconnect", #"weapon_change");
    var_86825dc4 = w_weapon.var_f3ec5b6d;
    var_a9fbba86 = w_weapon.var_4c32b46e;
    if (isdefined(var_86825dc4) && var_86825dc4 > 0) {
        var_9ce8b74e = self gadgetpowerget(level.var_97b2d700);
        while (true) {
            var_6fe0fc9c = self gadgetpowerget(level.var_97b2d700);
            if (var_9ce8b74e > var_86825dc4 && var_6fe0fc9c <= var_86825dc4) {
                self playsound(var_a9fbba86);
                return;
            }
            var_9ce8b74e = var_6fe0fc9c;
            wait 0.1;
        }
    }
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 0, eflags: 0x0
// Checksum 0xd68f3eff, Offset: 0x2a70
// Size: 0x1a0
function function_166dc5ca() {
    self endon(#"hero_weapon_take", #"disconnect");
    while (true) {
        s_notify = self waittill(#"weapon_change");
        w_current = s_notify.weapon;
        w_previous = s_notify.last_weapon;
        if (zm_loadout::is_hero_weapon(w_current)) {
            self thread function_79b0db82();
            a_ai_targets = getaispeciesarray(level.zombie_team, "all");
            a_ai_targets = arraysortclosest(a_ai_targets, self getorigin(), a_ai_targets.size, 0, 160);
            a_ai_targets = array::remove_dead(a_ai_targets);
            a_ai_targets = array::remove_undefined(a_ai_targets);
            array::thread_all(a_ai_targets, &function_2aaca7c6, self, w_current);
        }
        if (w_current != level.weaponnone && zm_loadout::is_hero_weapon(w_previous)) {
            self function_2aae86f3();
        }
    }
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 0, eflags: 0x0
// Checksum 0x288c5186, Offset: 0x2c18
// Size: 0x94
function function_2aae86f3() {
    n_power = self gadgetpowerget(level.var_97b2d700);
    is_deployed = self function_49de461b(level.var_97b2d700);
    if (n_power > 50 && !is_deployed) {
        self gadgetpowerset(level.var_97b2d700, 50);
    }
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 0, eflags: 0x4
// Checksum 0x7a68e533, Offset: 0x2cb8
// Size: 0x2c
function private function_a769758c() {
    return zm_trial_restrict_loadout::is_active() || zm_trial_disable_hero_weapons::is_active();
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 0, eflags: 0x0
// Checksum 0x2bfb21de, Offset: 0x2cf0
// Size: 0x8c
function function_79b0db82() {
    self endon(#"disconnect");
    if (function_a769758c()) {
        return;
    }
    self val::set(#"hash_558d809e7921fa79", "takedamage", 0);
    wait 0.5;
    self val::reset(#"hash_558d809e7921fa79", "takedamage");
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 2, eflags: 0x0
// Checksum 0x88d90fb1, Offset: 0x2d88
// Size: 0xe4
function function_2aaca7c6(player, w_hero) {
    self endon(#"death");
    if (function_a769758c()) {
        return;
    }
    if (isdefined(self.var_e9e45f3f) && self.var_e9e45f3f) {
        self.marked_for_death = 1;
        self zm_cleanup::function_9d243698();
        v_fling = (self.origin - player.origin) * 1.5 + (0, 0, 1) * 64;
        self zm_utility::function_620780d9(v_fling, player);
        return;
    }
    self thread function_f53ff9();
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 3, eflags: 0x0
// Checksum 0xb8149a58, Offset: 0x2e78
// Size: 0x11e
function show_hint(w_hero, str_hint, var_cd66eb1e = 0) {
    if (!isdefined(self.var_a36d4995)) {
        self.var_a36d4995 = [];
    }
    if (!(isdefined(self.var_a36d4995[w_hero.name]) && self.var_a36d4995[w_hero.name])) {
        /#
            if (isdefined(self.hintelem)) {
                self.hintelem settext("<dev string:x101>");
                self.hintelem destroy();
            }
        #/
        if (var_cd66eb1e) {
            n_hint_time = 5;
        } else {
            n_hint_time = 3;
        }
        self thread zm_equipment::show_hint_text(str_hint, n_hint_time);
        self.var_a36d4995[w_hero.name] = 1;
    }
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 1, eflags: 0x0
// Checksum 0x1f76655, Offset: 0x2fa0
// Size: 0xae
function function_f53ff9(n_cooldown = 4) {
    self endon(#"death");
    if (!isalive(self)) {
        return;
    }
    if (!(isdefined(self.var_206e9b33) && self.var_206e9b33)) {
        return;
    }
    if (isdefined(self.var_8a9f51f6) && self.var_8a9f51f6) {
        return;
    }
    self.var_8a9f51f6 = 1;
    self ai::stun();
    wait n_cooldown;
    self.var_8a9f51f6 = 0;
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 0, eflags: 0x0
// Checksum 0x5af30c09, Offset: 0x3058
// Size: 0x11c
function function_765137a1() {
    var_f4d83ba0 = function_5e6ac79d();
    var_9dfd0088 = getaispeciesarray(level.zombie_team, "all");
    a_e_targets = arraycombine(var_9dfd0088, var_f4d83ba0, 0, 0);
    var_c0071e1a = [];
    foreach (target in a_e_targets) {
        if (!(isdefined(target.var_92eddb80) && target.var_92eddb80)) {
            array::add(var_c0071e1a, target);
        }
    }
    return var_c0071e1a;
}

