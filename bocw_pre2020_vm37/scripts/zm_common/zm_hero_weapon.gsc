#using script_301f64a4090c381a;
#using script_35d3717bf2cbee8f;
#using scripts\abilities\ability_player;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\trials\zm_trial_restrict_loadout;
#using scripts\zm_common\zm_armor;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_challenges;
#using scripts\zm_common\zm_cleanup_mgr;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace zm_hero_weapon;

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 0, eflags: 0x6
// Checksum 0x83ad3897, Offset: 0x258
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"zm_hero_weapons", &function_70a657d8, undefined, undefined, #"gadget_hero_weapon");
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 0, eflags: 0x5 linked
// Checksum 0xa3bba16c, Offset: 0x2a8
// Size: 0x25c
function private function_70a657d8() {
    level.var_c15ad546 = 1;
    level.var_a53a05b5 = 2;
    level.hero_power_update = &function_3fe4a02e;
    clientfield::register_clientuimodel("zmhud.weaponLevel", 1, 2, "int");
    clientfield::register_clientuimodel("zmhud.weaponProgression", 1, 5, "float");
    clientfield::register_clientuimodel("zmhud.swordEnergy", 1, 7, "float");
    clientfield::register_clientuimodel("zmhud.swordState", 1, 4, "int");
    clientfield::register_clientuimodel("zmhud.swordChargeUpdate", 1, 1, "counter");
    level.var_5ee61f18 = [];
    level.var_2d52e9af = [];
    level.var_d5075025 = [];
    level.var_a1feaa28 = 1;
    if (zm_custom::function_901b751c(#"zmspecweaponchargerate") == 2) {
        level.var_a1feaa28 = 2;
    }
    if (zm_custom::function_901b751c(#"zmspecweaponchargerate") == 0) {
        level.var_a1feaa28 = 0.5;
    }
    ability_player::register_gadget_activation_callbacks(11, &hero_weapon_on, &hero_weapon_off);
    ability_player::register_gadget_ready_callbacks(11, &hero_weapon_ready);
    /#
        level thread function_281b4073();
        level.var_124446e = &function_124446e;
    #/
    level.var_ff96c5e4 = 0;
    zm_armor::register(#"hero_weapon_armor", 0);
}

/#

    // Namespace zm_hero_weapon/zm_hero_weapon
    // Params 0, eflags: 0x0
    // Checksum 0xe70686ca, Offset: 0x510
    // Size: 0x3c
    function function_281b4073() {
        adddebugcommand("<dev string:x38>");
        adddebugcommand("<dev string:x91>");
    }

    // Namespace zm_hero_weapon/zm_hero_weapon
    // Params 1, eflags: 0x0
    // Checksum 0x96dfa11f, Offset: 0x558
    // Size: 0x20a
    function function_124446e(weapon_name) {
        self.var_fd05e363 = getweapon(weapon_name);
        var_b4b7833b = getsubstr(weapon_name, weapon_name.size - 1, weapon_name.size);
        weapon_level = int(var_b4b7833b) - 1;
        self.var_72d6f15d = weapon_level;
        self function_23978edd();
        self clientfield::set_player_uimodel("<dev string:xec>", self.var_72d6f15d);
        self hero_give_weapon(self.var_fd05e363, 1);
        self.var_c9279111 = 0;
        self.var_821c9bf3 = 0;
        self.var_1bcf6a9e = 0;
        self.var_dc37311e = 0;
        self.var_da2f5f0b = 0;
        switch (self.var_72d6f15d) {
        case 0:
            self.var_c09adff0 = 0;
            self.var_e77eadb7 = 0;
            self.var_ec334996 = 0;
            break;
        case 1:
            self.var_c09adff0 = 0;
            self.var_e77eadb7 = 1;
            self.var_ec334996 = function_c49bf808(2800);
            break;
        case 2:
            self.var_c09adff0 = 1;
            self.var_e77eadb7 = 1;
            self.var_ec334996 = function_c49bf808(8000);
            break;
        }
    }

#/

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 2, eflags: 0x1 linked
// Checksum 0x909c7581, Offset: 0x770
// Size: 0x6c
function function_76505465(slot, enabled) {
    if (is_true(level.var_697a556f)) {
        self function_19ed70ca(slot, 1);
        return;
    }
    self function_19ed70ca(slot, enabled);
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 2, eflags: 0x1 linked
// Checksum 0x13adb20c, Offset: 0x7e8
// Size: 0x1dc
function function_416eaaa2(var_deaf10fb, var_ef230d21) {
    if (self gadgetisactive(level.var_a53a05b5)) {
        if (isdefined(self.talisman_special_xp_rate)) {
            n_scalar = self.talisman_special_xp_rate;
        } else {
            n_scalar = 1;
        }
        if (isdefined(var_ef230d21)) {
            self.var_821c9bf3 += var_ef230d21 * n_scalar;
            self.var_41183060 += var_ef230d21 * n_scalar;
        } else {
            self.var_821c9bf3 += 1 * n_scalar;
            self.var_41183060 += 1 * n_scalar;
        }
    }
    if (is_true(level.var_697a556f) && var_deaf10fb > 0 && !self gadgetisactive(level.var_a53a05b5)) {
        current_power = self gadgetpowerget(level.var_a53a05b5);
        if (self hasperk(#"specialty_mod_cooldown")) {
            var_deaf10fb = 0.15 * var_deaf10fb;
        }
        current_power += level.var_a1feaa28 * 100 / var_deaf10fb;
        if (current_power > 100) {
            current_power = 100;
        }
        self gadgetpowerset(level.var_a53a05b5, current_power);
    }
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 2, eflags: 0x1 linked
// Checksum 0x5bd66475, Offset: 0x9d0
// Size: 0x2c4
function function_29f19e9a(var_deaf10fb, n_points) {
    if (self gadgetisactive(level.var_a53a05b5) || is_true(level.var_373ced84)) {
        self.var_dc37311e += n_points;
        self.var_ec334996 += n_points;
    }
    if (is_true(level.var_c15ad546) && var_deaf10fb > 0 && !self gadgetisactive(level.var_a53a05b5)) {
        current_power = self gadgetpowerget(level.var_a53a05b5);
        if (current_power == 100) {
            return;
        }
        var_f032086a = 0;
        if (self hasperk(#"specialty_mod_cooldown")) {
            var_f032086a += 0.15;
        }
        if (self bgb::is_enabled(#"zm_bgb_arsenal_accelerator")) {
            var_f032086a += 0.15;
        }
        if (self namespace_e38c57c1::function_6a7a1533(5)) {
            var_f032086a += -0.2;
        }
        n_points += n_points * var_f032086a;
        n_points = max(1, n_points);
        if (current_power == 0) {
            self.var_da2f5f0b = level.var_a1feaa28 * n_points;
        } else {
            var_d526977b = current_power / 100;
            self.var_da2f5f0b = var_deaf10fb * var_d526977b;
            self.var_da2f5f0b += level.var_a1feaa28 * n_points;
        }
        self thread function_56d2c5d0(n_points);
        var_d526977b = self.var_da2f5f0b / var_deaf10fb;
        current_power = 100 * var_d526977b;
        if (current_power > 100) {
            current_power = 100;
        }
        self gadgetpowerset(level.var_a53a05b5, current_power);
    }
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 1, eflags: 0x1 linked
// Checksum 0xd4989f48, Offset: 0xca0
// Size: 0x26c
function function_56d2c5d0(n_points) {
    if (self.var_d11656b < 100) {
        self.var_184a3854 += n_points;
        if (self.var_184a3854 >= self.var_9f176816) {
            self.var_184a3854 = 0;
            level notify(#"hash_159486ad4746f53e", {#e_player:self});
            switch (self.var_72d6f15d) {
            case 1:
                if (isdefined(level.var_d5075025[self.var_b708af7b]) && isdefined(level.var_d5075025[self.var_b708af7b][self.var_72d6f15d])) {
                    self.var_9f176816 += level.var_d5075025[self.var_b708af7b][self.var_72d6f15d];
                } else {
                    self.var_9f176816 += 100;
                }
                break;
            case 2:
                if (isdefined(level.var_d5075025[self.var_b708af7b]) && isdefined(level.var_d5075025[self.var_b708af7b][self.var_72d6f15d])) {
                    self.var_9f176816 += level.var_d5075025[self.var_b708af7b][self.var_72d6f15d];
                } else {
                    self.var_9f176816 += 150;
                }
                break;
            default:
                if (isdefined(level.var_d5075025[self.var_b708af7b]) && isdefined(level.var_d5075025[self.var_b708af7b][self.var_72d6f15d])) {
                    self.var_9f176816 += level.var_d5075025[self.var_b708af7b][self.var_72d6f15d];
                } else {
                    self.var_9f176816 += 50;
                }
                break;
            }
            self.var_d11656b++;
        }
    }
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 0, eflags: 0x0
// Checksum 0xcd8e796c, Offset: 0xf18
// Size: 0x31c
function hero_weapon_player_init() {
    if (!isdefined(self.var_fd05e363)) {
        self.var_fd05e363 = self zm_loadout::function_439b009a("herogadget");
        self.var_72d6f15d = 0;
        self.var_ec334996 = 0;
        if (is_true(self.talisman_special_startlv3)) {
            self function_45b7d6c1(2);
            self.var_c09adff0 = 1;
        }
        if (is_true(self.talisman_special_startlv2)) {
            self function_45b7d6c1(1);
            self.var_e77eadb7 = 1;
        }
        self function_23978edd();
        if (is_true(self.talisman_special_startlv2)) {
            if (isdefined(level.var_5ee61f18[self.var_b708af7b])) {
                self.var_ec334996 = level.var_5ee61f18[self.var_b708af7b][1];
            } else {
                self.var_ec334996 = function_c49bf808(2800);
            }
        }
        if (is_true(self.talisman_special_startlv3)) {
            if (isdefined(level.var_5ee61f18[self.var_b708af7b])) {
                self.var_ec334996 = level.var_5ee61f18[self.var_b708af7b][2];
            } else {
                self.var_ec334996 = function_c49bf808(8000);
            }
        }
        self.var_41183060 = 0;
        self.var_821c9bf3 = 0;
        self.var_c9279111 = 0;
        self.var_dc37311e = 0;
        self.var_1bcf6a9e = 0;
        self.var_da2f5f0b = 0;
        self.var_184a3854 = 0;
        self.var_d11656b = 0;
        self.var_9cef1b1e = 0;
    }
    if (zm_custom::function_901b751c(#"zmspecweaponisenabled") && isdefined(self.var_fd05e363)) {
        self hero_give_weapon(self.var_fd05e363, 0);
        if (self.var_fd05e363.isgadget) {
            slot = self gadgetgetslot(self.var_fd05e363);
            var_aabc1f49 = isdefined(self.firstspawn) ? self.firstspawn : 1;
            if (slot >= 0 && var_aabc1f49) {
                self gadgetpowerreset(slot, 1);
            }
        }
    }
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 0, eflags: 0x0
// Checksum 0x4e7c33f6, Offset: 0x1240
// Size: 0x104
function function_f8bf706f() {
    self.var_41183060 = 0;
    self.var_821c9bf3 = 0;
    self.var_c9279111 = 0;
    self.var_dc37311e = 0;
    self.var_1bcf6a9e = 0;
    self.var_da2f5f0b = 0;
    self.var_184a3854 = 0;
    self.var_d11656b = 0;
    self.var_9cef1b1e = 0;
    if (zm_custom::function_901b751c(#"zmspecweaponisenabled")) {
        self hero_give_weapon(self.var_fd05e363, 0);
        if (self.var_fd05e363.isgadget) {
            n_slot = self gadgetgetslot(self.var_fd05e363);
            self gadgetpowerreset(n_slot, 0);
        }
    }
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 1, eflags: 0x0
// Checksum 0x322f5427, Offset: 0x1350
// Size: 0xfa
function function_fecb38dd(n_level = 3) {
    if (isdefined(level.var_5ee61f18[self.var_b708af7b])) {
        self.var_ec334996 = level.var_5ee61f18[self.var_b708af7b][n_level - 1];
        return;
    }
    switch (n_level) {
    case 3:
        self.var_ec334996 = function_c49bf808(8000);
        break;
    case 2:
        self.var_ec334996 = function_c49bf808(2800);
        break;
    case 1:
    default:
        self.var_ec334996 = 0;
        break;
    }
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 0, eflags: 0x1 linked
// Checksum 0x6c3422c9, Offset: 0x1458
// Size: 0x146
function function_23978edd() {
    foreach (h_key, a_weaponlist in level.hero_weapon) {
        if (isinarray(a_weaponlist, self.var_fd05e363)) {
            self.var_fd05e363 = a_weaponlist[self.var_72d6f15d];
            self.var_b708af7b = h_key;
            return;
        }
    }
    if (zm_utility::get_story() == 1) {
        self.var_fd05e363 = level.hero_weapon[#"gravityspikes"][self.var_72d6f15d];
        self.var_b708af7b = "gravityspikes";
        return;
    }
    self.var_fd05e363 = level.hero_weapon[#"chakram"][self.var_72d6f15d];
    self.var_b708af7b = "chakram";
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 3, eflags: 0x1 linked
// Checksum 0x89ad04ae, Offset: 0x15a8
// Size: 0x356
function hero_give_weapon(weapon, enabled, var_b94ec3d9 = 0) {
    if (!isdefined(self) || !isdefined(weapon)) {
        return;
    }
    if (!self hasweapon(weapon)) {
        if (isdefined(self._gadgets_player) && isdefined(self._gadgets_player[level.var_a53a05b5])) {
            self notify(#"hero_weapon_take", {#weapon:self._gadgets_player[level.var_a53a05b5]});
            self takeweapon(self._gadgets_player[level.var_a53a05b5]);
        }
        self zm_loadout::set_player_hero_weapon(weapon);
        self.var_fd05e363 = weapon;
        self notify(#"hero_weapon_give", {#weapon:weapon});
        self giveweapon(weapon);
        self thread function_ac9f4b22();
        if (is_true(level.var_373ced84)) {
        } else if (enabled) {
            self gadgetpowerset(level.var_a53a05b5, 100);
            self gadgetcharging(level.var_a53a05b5, 0);
            self function_76505465(level.var_a53a05b5, 0);
        } else {
            if (is_true(var_b94ec3d9)) {
                level thread function_3fe4a02e(self, 1);
            } else {
                self gadgetpowerset(level.var_a53a05b5, 0);
            }
            self gadgetcharging(level.var_a53a05b5, 0);
            self function_76505465(level.var_a53a05b5, 0);
        }
        function_1297aefe(weapon);
        return;
    }
    if (enabled && !is_true(level.var_373ced84)) {
        self gadgetpowerset(level.var_a53a05b5, 100);
        self gadgetcharging(level.var_a53a05b5, 0);
        self function_76505465(level.var_a53a05b5, 0);
        self.var_821c9bf3 = 0;
        self.var_dc37311e = 0;
        self.var_da2f5f0b = 0;
    }
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 1, eflags: 0x1 linked
// Checksum 0x7d86ba13, Offset: 0x1908
// Size: 0x2b4
function function_1297aefe(weapon) {
    var_328c1d6e = array(#"hero_chakram_lv3", #"hero_hammer_lv3", #"hero_scepter_lv3", #"hero_sword_pistol_lv3", #"hero_flamethrower_t8_lv3", #"hero_gravityspikes_t8_lv3", #"hero_katana_t8_lv3", #"hero_minigun_t8_lv3");
    i = 0;
    var_8e233987 = [];
    do {
        weapon_name = self stats::get_stat(#"hash_3da32e638bd332a5", i);
        if (isdefined(weapon_name) && weapon_name) {
            if (!isdefined(var_8e233987)) {
                var_8e233987 = [];
            } else if (!isarray(var_8e233987)) {
                var_8e233987 = array(var_8e233987);
            }
            if (!isinarray(var_8e233987, hash(weapon_name))) {
                var_8e233987[var_8e233987.size] = hash(weapon_name);
            }
            i++;
            continue;
        }
        break;
    } while (i < 8);
    if (isinarray(var_328c1d6e, weapon.name)) {
        if (!isinarray(var_8e233987, weapon.name)) {
            if (!isdefined(var_8e233987)) {
                var_8e233987 = [];
            } else if (!isarray(var_8e233987)) {
                var_8e233987 = array(var_8e233987);
            }
            var_8e233987[var_8e233987.size] = weapon.name;
            stats::set_stat(#"hash_3da32e638bd332a5", i, weapon.name);
        }
    }
    var_a3cdb465 = array::exclude(var_328c1d6e, var_8e233987);
    if (!var_a3cdb465.size) {
        self zm_utility::function_659819fa(#"zm_trophy_jack_of_all_blades");
    }
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 2, eflags: 0x1 linked
// Checksum 0x45fbf393, Offset: 0x1bc8
// Size: 0x154
function hero_weapon_on(*n_slot, w_hero) {
    self notify(#"hero_weapon_power_on");
    self addweaponstat(w_hero, #"used", 1);
    level.var_ff96c5e4 = 1;
    self.var_479965f7 = 1;
    level notify(#"hero_weapon_activated", {#e_player:self, #weapon:w_hero});
    self notify(#"hero_weapon_activated");
    self thread zm_audio::function_cb8103f6(w_hero);
    self thread function_60878f7f(w_hero);
    self zm_stats::increment_client_stat("special_weapon_used");
    self zm_stats::increment_player_stat("special_weapon_used");
    self zm_stats::function_8f10788e("boas_special_weapon_used");
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 2, eflags: 0x1 linked
// Checksum 0xe573c9eb, Offset: 0x1d28
// Size: 0x9c
function hero_weapon_off(*n_slot, *w_hero) {
    self endon(#"death", #"hero_weapon_power_on");
    self.var_479965f7 = undefined;
    wait 2;
    self notify(#"hero_weapon_power_off");
    w_current = self getcurrentweapon();
    self zm_weapons::switch_back_primary_weapon(w_current, 0, 1);
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 2, eflags: 0x1 linked
// Checksum 0xb8fb219a, Offset: 0x1dd0
// Size: 0xac
function hero_weapon_ready(*n_slot, w_hero) {
    self thread zm_audio::function_2d93d659(w_hero);
    if (bgb::is_enabled(#"zm_bgb_arsenal_accelerator")) {
        self zm_stats::increment_challenge_stat(#"hash_1f20f53b7084fdcb");
    }
    if (zm_utility::is_standard()) {
        level thread zm_audio::sndannouncerplayvox(#"hero_weapon_ready", self, undefined, undefined, 1);
    }
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 2, eflags: 0x1 linked
// Checksum 0x2f336126, Offset: 0x1e88
// Size: 0x1c6
function function_9a100883(weapon_level, enabled) {
    self notify(#"hash_6b01968912321cc5");
    self endon(#"hash_6b01968912321cc5", #"disconnect");
    self.var_39b77a76 = 1;
    self.var_c9279111 = 0;
    self.var_821c9bf3 = 0;
    self.var_dc37311e = 0;
    while (self gadgetisactive(level.var_a53a05b5) || is_true(self.var_fbe120be) || is_true(self.var_61950f95)) {
        wait 1;
    }
    self waittilltimeout(2, #"weapon_change_complete");
    self playsound("zmb_weapon_upgrade_to_lvl_" + weapon_level + 1);
    self function_45b7d6c1(weapon_level);
    self hero_give_weapon(level.hero_weapon[self.var_b708af7b][weapon_level], enabled, 1);
    self.var_da2f5f0b = 0;
    /#
        self zm_challenges::debug_print("<dev string:x101>");
    #/
    self zm_stats::increment_challenge_stat(#"special_weapon_levels");
    self.var_39b77a76 = undefined;
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 2, eflags: 0x0
// Checksum 0x2ef57d61, Offset: 0x2058
// Size: 0x434
function function_6bba3829(e_player, ai_enemy) {
    /#
        var_ea65bd9c = getdvarstring(#"hash_16e05c0b86ebb83d", "<dev string:x132>");
        if (var_ea65bd9c == "<dev string:x13d>") {
            return;
        }
    #/
    if (is_true(e_player.var_80612bea)) {
        return;
    }
    if (isdefined(ai_enemy) && isdefined(ai_enemy.var_ab8f2b90)) {
        var_ef230d21 = ai_enemy.var_ab8f2b90;
    }
    if (isdefined(e_player.var_b708af7b) && isdefined(level.var_5ee61f18[e_player.var_b708af7b])) {
        var_4c37bfce = level.var_5ee61f18[e_player.var_b708af7b][0];
        var_c4937b1a = level.var_5ee61f18[e_player.var_b708af7b][1];
        var_75f1042 = level.var_5ee61f18[e_player.var_b708af7b][2];
    } else {
        var_4c37bfce = 0;
        var_c4937b1a = 2;
        var_75f1042 = 4;
    }
    if (isdefined(e_player.var_b708af7b) && isdefined(level.var_2d52e9af[e_player.var_b708af7b])) {
        var_7b0b50c2 = level.var_2d52e9af[e_player.var_b708af7b][0];
        var_9e2d281a = level.var_2d52e9af[e_player.var_b708af7b][1];
        var_ad6f4a1 = level.var_2d52e9af[e_player.var_b708af7b][2];
    } else {
        var_7b0b50c2 = 25;
        var_9e2d281a = 40;
        var_ad6f4a1 = 60;
    }
    if (e_player.var_41183060 >= var_75f1042) {
        e_player function_416eaaa2(var_ad6f4a1, var_ef230d21);
    } else if (e_player.var_41183060 >= var_c4937b1a) {
        e_player function_416eaaa2(var_9e2d281a, var_ef230d21);
        e_player.var_c9279111 = e_player.var_821c9bf3 / (var_75f1042 - var_c4937b1a);
    } else if (e_player.var_41183060 >= var_4c37bfce) {
        e_player function_416eaaa2(var_7b0b50c2, var_ef230d21);
        e_player.var_c9279111 = e_player.var_821c9bf3 / (var_c4937b1a - var_4c37bfce);
    } else {
        e_player function_416eaaa2(0, var_ef230d21);
        e_player.var_c9279111 = e_player.var_821c9bf3 / var_4c37bfce;
    }
    if (!isdefined(e_player.var_c09adff0)) {
        e_player.var_c09adff0 = 0;
    }
    if (!isdefined(e_player.var_e77eadb7)) {
        e_player.var_e77eadb7 = 0;
    }
    if (e_player.var_41183060 >= var_75f1042 && !e_player.var_c09adff0 && e_player.var_e77eadb7) {
        e_player.var_c09adff0 = 1;
        e_player function_9a100883(2, 0);
    } else if (e_player.var_41183060 >= var_c4937b1a && !e_player.var_c09adff0 && !e_player.var_e77eadb7) {
        e_player.var_e77eadb7 = 1;
        e_player function_9a100883(1, 0);
    }
    e_player function_1164ba7b(e_player.var_c9279111);
    e_player clientfield::set_player_uimodel("zmhud.swordState", 1);
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 3, eflags: 0x1 linked
// Checksum 0xe220fafc, Offset: 0x2498
// Size: 0x54
function function_3fe4a02e(e_player, n_points, str_event) {
    
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 1, eflags: 0x1 linked
// Checksum 0x3f9a32f4, Offset: 0x2a70
// Size: 0x64
function function_1164ba7b(n_progress) {
    if (self.var_72d6f15d === 2) {
        self clientfield::set_player_uimodel("zmhud.weaponProgression", 1);
        return;
    }
    self clientfield::set_player_uimodel("zmhud.weaponProgression", n_progress);
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 1, eflags: 0x1 linked
// Checksum 0x9455921, Offset: 0x2ae0
// Size: 0x44
function function_45b7d6c1(n_level) {
    if (self.var_72d6f15d < n_level) {
        self.var_72d6f15d = n_level;
        self clientfield::set_player_uimodel("zmhud.weaponLevel", n_level);
    }
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 4, eflags: 0x0
// Checksum 0x9c208188, Offset: 0x2b30
// Size: 0x7a
function function_7a394ec4(str_name, n_lvl1, n_lvl2, n_lvl3) {
    level.var_5ee61f18[str_name] = [];
    level.var_5ee61f18[str_name][0] = n_lvl1;
    level.var_5ee61f18[str_name][1] = n_lvl2;
    level.var_5ee61f18[str_name][2] = n_lvl3;
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 2, eflags: 0x0
// Checksum 0xdb8c204f, Offset: 0x2bb8
// Size: 0x34
function function_53cdfacf(str_name, var_75025dbf) {
    level.var_2d52e9af[str_name] = [];
    level.var_2d52e9af[str_name] = var_75025dbf;
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 4, eflags: 0x0
// Checksum 0xc5e83ebf, Offset: 0x2bf8
// Size: 0x7a
function function_5ccf482(str_name, var_a986aaed, var_f2bbbd56, var_503e1e6) {
    level.var_d5075025[str_name] = [];
    level.var_d5075025[str_name][0] = var_a986aaed;
    level.var_d5075025[str_name][1] = var_f2bbbd56;
    level.var_d5075025[str_name][2] = var_503e1e6;
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 1, eflags: 0x1 linked
// Checksum 0xcaf1833a, Offset: 0x2c80
// Size: 0x13c
function function_60878f7f(w_weapon) {
    self notify(#"hash_5ef1cf6d910b343b");
    self endon(#"hash_5ef1cf6d910b343b", #"hero_weapon_take", #"disconnect", #"weapon_change");
    var_a01a1f92 = w_weapon.var_e4109b63;
    var_bcf2cdde = w_weapon.var_fb22040b;
    if (isdefined(var_a01a1f92) && var_a01a1f92 > 0) {
        var_e3108f57 = self gadgetpowerget(level.var_a53a05b5);
        while (true) {
            var_a5be660b = self gadgetpowerget(level.var_a53a05b5);
            if (var_e3108f57 > var_a01a1f92 && var_a5be660b <= var_a01a1f92) {
                self playsound(var_bcf2cdde);
                return;
            }
            var_e3108f57 = var_a5be660b;
            wait 0.1;
        }
    }
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 0, eflags: 0x1 linked
// Checksum 0xd51c906d, Offset: 0x2dc8
// Size: 0x36a
function function_ac9f4b22() {
    self endon(#"hero_weapon_take", #"disconnect");
    while (true) {
        s_notify = self waittill(#"weapon_change");
        w_current = s_notify.weapon;
        w_previous = s_notify.last_weapon;
        if (is_true(self.var_479965f7) && (w_current == level.weaponnone || w_previous == level.weaponnone)) {
            if (w_current == level.weaponnone && zm_loadout::is_hero_weapon(w_previous)) {
                var_a88b79c6 = w_previous;
            } else {
                var_a88b79c6 = undefined;
            }
            continue;
        }
        if (zm_loadout::is_hero_weapon(w_current)) {
            self thread function_cab29b9f();
            self.var_45ce0c21 = 0;
            a_ai_targets = getaispeciesarray(level.zombie_team, "all");
            a_ai_targets = arraysortclosest(a_ai_targets, self getorigin(), a_ai_targets.size, 0, 160);
            function_1eaaceab(a_ai_targets);
            arrayremovevalue(a_ai_targets, undefined);
            array::thread_all(a_ai_targets, &function_c2dea172, self, w_current);
            if (is_true(self.var_bacee63b)) {
                self thread zm_armor::add(#"hero_weapon_armor", 100, 100);
            } else {
                self thread zm_armor::add(#"hero_weapon_armor", 50, 50);
            }
        } else if (zm_loadout::is_hero_weapon(w_previous) || w_previous == level.weaponnone && isdefined(var_a88b79c6)) {
            if (isdefined(var_a88b79c6)) {
                w_previous = var_a88b79c6;
            }
            var_a88b79c6 = undefined;
            if (!is_true(self.var_bacee63b)) {
                self thread zm_armor::remove(#"hero_weapon_armor", 1);
            }
            if (w_current != level.weaponnone) {
                self thread function_a1004d47();
            }
        }
        self notify(#"hero_weapon_change", {#weapon:w_current, #last_weapon:w_previous});
    }
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 0, eflags: 0x5 linked
// Checksum 0xd8b850fd, Offset: 0x3140
// Size: 0x7e
function private function_a1004d47() {
    self endon(#"death");
    self.var_1f23fe79 = 1;
    self function_29e4516d();
    self waittilltimeout(2, #"weapon_change_complete");
    self notify(#"hash_3eaa776332738598");
    self.var_1f23fe79 = undefined;
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 0, eflags: 0x1 linked
// Checksum 0x112e625a, Offset: 0x31c8
// Size: 0xac
function function_29e4516d() {
    if (is_true(self.var_c09e6d59)) {
        return;
    }
    n_power = self gadgetpowerget(level.var_a53a05b5);
    is_deployed = self function_36dfc05f(level.var_a53a05b5);
    if (n_power > 50 && !is_deployed) {
        self gadgetpowerset(level.var_a53a05b5, 50);
    }
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 0, eflags: 0x5 linked
// Checksum 0x69057f10, Offset: 0x3280
// Size: 0x34
function private function_9f3a3d48() {
    return zm_trial_restrict_loadout::is_active(1) || namespace_fc5170d1::is_active();
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 0, eflags: 0x1 linked
// Checksum 0xe924612a, Offset: 0x32c0
// Size: 0x8c
function function_cab29b9f() {
    self endon(#"disconnect");
    if (function_9f3a3d48()) {
        return;
    }
    self val::set(#"hash_558d809e7921fa79", "takedamage", 0);
    wait 0.5;
    self val::reset(#"hash_558d809e7921fa79", "takedamage");
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 2, eflags: 0x1 linked
// Checksum 0xd248b674, Offset: 0x3358
// Size: 0x174
function function_c2dea172(player, w_hero) {
    self endon(#"death");
    if (function_9f3a3d48() || is_true(self.marked_for_death)) {
        return;
    }
    if (self.archetype === #"zombie_dog") {
        self zm_cleanup::function_23621259();
        self dodamage(self.health + 100, player.origin, player, player, "torso_lower", "MOD_IMPACT", 0, w_hero);
        return;
    }
    if (is_true(self.var_2f68be48)) {
        self.marked_for_death = 1;
        self zm_cleanup::function_23621259();
        v_fling = (self.origin - player.origin) * 1.5 + (0, 0, 1) * 64;
        self zm_utility::function_ffc279(v_fling, player, undefined, w_hero);
        return;
    }
    self thread function_acee2761();
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 3, eflags: 0x0
// Checksum 0xec04e748, Offset: 0x34d8
// Size: 0x114
function show_hint(w_hero, str_hint, var_bdc24d5f = 0) {
    if (!isdefined(self.var_2a2832c6)) {
        self.var_2a2832c6 = [];
    }
    if (!is_true(self.var_2a2832c6[w_hero.name])) {
        /#
            if (isdefined(self.hintelem)) {
                self.hintelem settext("<dev string:x149>");
                self.hintelem destroy();
            }
        #/
        if (var_bdc24d5f) {
            n_hint_time = 5;
        } else {
            n_hint_time = 3;
        }
        self thread zm_equipment::show_hint_text(str_hint, n_hint_time);
        self.var_2a2832c6[w_hero.name] = 1;
    }
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 1, eflags: 0x1 linked
// Checksum 0x278deb79, Offset: 0x35f8
// Size: 0xbe
function function_acee2761(n_cooldown = 4) {
    if (!isalive(self)) {
        return;
    }
    self endon(#"death");
    if (!is_true(self.var_28aab32a)) {
        return;
    }
    if (is_true(self.var_9c494830)) {
        return;
    }
    self.var_9c494830 = 1;
    self ai::stun();
    wait n_cooldown;
    self.var_9c494830 = 0;
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 3, eflags: 0x0
// Checksum 0xc5fbf815, Offset: 0x36c0
// Size: 0xce
function function_4e984e83(w_hero, var_cd2d38a0 = 0.35, var_7ebb048f = 0.15) {
    self endon(#"death");
    self ability_player::function_c22f319e(w_hero);
    wait var_cd2d38a0;
    self.var_1d940ef6 = 1;
    self hideviewmodel();
    self waittill(#"weapon_change");
    wait var_7ebb048f;
    self showviewmodel();
    self.var_1d940ef6 = undefined;
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 1, eflags: 0x5 linked
// Checksum 0x871cc0bb, Offset: 0x3798
// Size: 0xce
function private function_c49bf808(var_14d0b7ab) {
    switch (level.players.size) {
    case 1:
        var_a7041269 = var_14d0b7ab * 1.4;
        break;
    case 2:
        var_a7041269 = var_14d0b7ab * 1.3;
        break;
    case 3:
        var_a7041269 = var_14d0b7ab * 1.2;
        break;
    case 4:
    default:
        var_a7041269 = var_14d0b7ab;
        break;
    }
    return var_a7041269;
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 1, eflags: 0x0
// Checksum 0x4f1a17c6, Offset: 0x3870
// Size: 0x1ac
function function_1bb7f7b1(n_level) {
    if (!isdefined(self.var_fd05e363)) {
        self.var_fd05e363 = self zm_loadout::function_439b009a("herogadget");
    }
    self function_45b7d6c1(n_level - 1);
    self function_23978edd();
    self.var_c9279111 = 0;
    self.var_821c9bf3 = 0;
    self.var_1bcf6a9e = 0;
    self.var_dc37311e = 0;
    self.var_da2f5f0b = 0;
    switch (self.var_72d6f15d) {
    case 0:
        self.var_c09adff0 = 0;
        self.var_e77eadb7 = 0;
        self.var_ec334996 = 0;
        break;
    case 1:
        self.var_c09adff0 = 0;
        self.var_e77eadb7 = 1;
        self.var_ec334996 = function_c49bf808(2800);
        break;
    case 2:
        self.var_c09adff0 = 1;
        self.var_e77eadb7 = 1;
        self.var_ec334996 = function_c49bf808(8000);
        break;
    }
    self hero_give_weapon(self.var_fd05e363, 1);
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 0, eflags: 0x0
// Checksum 0x8e6958f1, Offset: 0x3a28
// Size: 0x1b2
function function_7c3681f7() {
    var_25e2354 = function_4d8c71ce();
    var_72714481 = getaispeciesarray(level.zombie_team, "all");
    a_e_targets = arraycombine(var_72714481, var_25e2354, 0, 0);
    if (isarray(level.var_2c19331b)) {
        arrayremovevalue(level.var_2c19331b, undefined);
        a_e_targets = arraycombine(level.var_2c19331b, a_e_targets, 0, 0);
    }
    var_f7c84239 = [];
    foreach (target in a_e_targets) {
        if (!is_true(target.var_6353e3f1)) {
            if (!isdefined(var_f7c84239)) {
                var_f7c84239 = [];
            } else if (!isarray(var_f7c84239)) {
                var_f7c84239 = array(var_f7c84239);
            }
            var_f7c84239[var_f7c84239.size] = target;
        }
    }
    return var_f7c84239;
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 1, eflags: 0x0
// Checksum 0x8ea70880, Offset: 0x3be8
// Size: 0xa8
function function_7eabd65d(weapon) {
    if (!isdefined(level.var_25d0c843)) {
        level.var_25d0c843 = [];
    } else if (!isarray(level.var_25d0c843)) {
        level.var_25d0c843 = array(level.var_25d0c843);
    }
    if (!isinarray(level.var_25d0c843, weapon)) {
        level.var_25d0c843[level.var_25d0c843.size] = weapon;
    }
}

// Namespace zm_hero_weapon/zm_hero_weapon
// Params 1, eflags: 0x1 linked
// Checksum 0x5d5ee854, Offset: 0x3c98
// Size: 0x44
function function_6a32b8f(weapon) {
    return isarray(level.var_25d0c843) && isinarray(level.var_25d0c843, weapon);
}

