#using script_4ce5d94e8c797350;
#using scripts\core_common\aat_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_magicbox;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace namespace_f999c142;

// Namespace namespace_f999c142/namespace_f999c142
// Params 0, eflags: 0x1 linked
// Checksum 0x3e21ad36, Offset: 0x180
// Size: 0x2c
function init() {
    if (zm_utility::is_standard()) {
        return;
    }
    function_a8243f37();
}

// Namespace namespace_f999c142/namespace_f999c142
// Params 2, eflags: 0x1 linked
// Checksum 0xdd1b1e99, Offset: 0x1b8
// Size: 0x76
function function_ab6fd86c(e_player, reward_terminal) {
    e_player.var_25a17236 = reward_terminal zm_unitrigger::create(&function_bfa2ba47, 100, &function_fc7d3519);
    zm_unitrigger::unitrigger_force_per_player_triggers(e_player.var_25a17236);
    e_player.var_25a17236.player = e_player;
}

// Namespace namespace_f999c142/namespace_f999c142
// Params 1, eflags: 0x1 linked
// Checksum 0x89b675ad, Offset: 0x238
// Size: 0x1c4
function function_bfa2ba47(e_player) {
    if (e_player != self.stub.player) {
        self sethintstringforplayer(e_player, #"");
        return false;
    } else if (level.var_2dffd020 == 0) {
        self sethintstringforplayer(e_player, #"");
        return false;
    } else if (e_player.var_9e09931e != 0) {
        str_prompt = e_player zm_utility::function_d6046228(#"hash_603d187dac2f57c", #"hash_7cc2cf9d21806bf0");
        self sethintstringforplayer(e_player, str_prompt);
        return true;
    } else if (is_true(e_player.var_43300e)) {
        self sethintstringforplayer(e_player, #"hash_603d187dac2f57c");
        return true;
    } else if (e_player.var_9e09931e == 0) {
        self sethintstringforplayer(e_player, #"hash_194fb852eef34414");
        return true;
    } else {
        self sethintstringforplayer(e_player, #"hash_194fb852eef34414");
        return true;
    }
    return false;
}

// Namespace namespace_f999c142/namespace_f999c142
// Params 0, eflags: 0x1 linked
// Checksum 0x8e50e73a, Offset: 0x408
// Size: 0x114
function function_fc7d3519() {
    self endon(#"end_game");
    while (true) {
        waitresult = self waittill(#"trigger");
        e_player = waitresult.activator;
        if (!zm_utility::can_use(e_player)) {
            continue;
        }
        /#
            iprintlnbold("<dev string:x38>");
        #/
        if (e_player.var_9e09931e != 0) {
            e_player function_123bcbcf();
            e_player function_53a333a8(undefined);
            continue;
        }
        if (is_true(e_player.var_4373c66b)) {
            e_player.var_4373c66b = undefined;
            e_player notify(#"hash_3cd13a6cb08bba96");
        }
    }
}

// Namespace namespace_f999c142/namespace_f999c142
// Params 0, eflags: 0x1 linked
// Checksum 0xe1299fe1, Offset: 0x528
// Size: 0x87c
function function_123bcbcf() {
    b_reward = 1;
    switch (self.var_9e09931e) {
    case 0:
        b_reward = 0;
        break;
    case 1:
        a_str_rewards = [];
        if (!isdefined(self.var_3703202a)) {
            self.var_3703202a = 0;
        }
        a_str_rewards[a_str_rewards.size] = #"double_points";
        a_str_rewards[a_str_rewards.size] = #"carpenter";
        a_players = getplayers();
        if (a_players.size == 1 && !is_true(self.var_6482c679) && !zm_utility::is_trials() && self.var_3703202a < 1) {
            a_str_rewards[a_str_rewards.size] = #"extra_life";
        }
        var_7fddb744 = getweapon(#"knife_loadout");
        if (!self hasweapon(var_7fddb744)) {
            a_str_rewards[a_str_rewards.size] = #"knife_loadout";
        }
        str_reward = function_56c888ce(a_str_rewards);
        switch (str_reward) {
        case #"double_points":
            self thread function_d36fb590("double_points", 6, 1);
            break;
        case #"carpenter":
            self thread function_d36fb590("carpenter", 6, 1);
            break;
        case #"extra_life":
            self thread function_d36fb590("self_revive", 6, 1);
            self.var_6482c679 = 1;
            self.var_3703202a++;
            break;
        case #"knife_loadout":
            self thread function_11be5095(undefined, 6, 0, #"knife_loadout");
            break;
        }
        break;
    case 2:
        a_str_rewards = array(#"weapon", #"hash_7c324888d4036a9a", #"full_ammo", #"fire_sale");
        str_reward = function_56c888ce(a_str_rewards);
        switch (str_reward) {
        case #"full_ammo":
            self thread function_d36fb590("full_ammo", 15, 1);
            break;
        case #"fire_sale":
            self thread function_d36fb590("fire_sale", 15, 1);
            break;
        case #"weapon":
            self thread function_11be5095(2, 15, 0, undefined);
            break;
        case #"hash_7c324888d4036a9a":
            self thread function_11be5095(1, 15, 1, undefined);
            break;
        }
        break;
    case 3:
        a_str_rewards = array(#"weapon", #"hash_7c324888d4036a9a");
        wpn_current = self getcurrentweapon();
        if (zm_weapons::is_weapon_upgraded(wpn_current)) {
            a_str_rewards[a_str_rewards.size] = #"aat";
        }
        str_reward = function_56c888ce(a_str_rewards);
        switch (str_reward) {
        case #"aat":
            self thread function_7dc3dfdb(15);
            break;
        case #"weapon":
            self thread function_11be5095(3, 15, 0, undefined);
            break;
        case #"hash_7c324888d4036a9a":
            self thread function_11be5095(2, 15, 1, undefined);
            break;
        }
        break;
    case 4:
        if (!isdefined(self.var_123836f9)) {
            self.var_123836f9 = 0;
        }
        if (!isdefined(self.var_3703202a)) {
            self.var_3703202a = 0;
        }
        a_str_rewards = array(#"weapon");
        if (self.var_123836f9 < 2) {
            a_str_rewards[a_str_rewards.size] = #"free_perk";
        }
        a_players = getplayers();
        if (a_players.size == 1 && !is_true(self.var_17d719b9) && !zm_utility::is_trials() && self.var_3703202a < 2) {
            a_str_rewards[a_str_rewards.size] = #"extra_life";
        }
        var_1ec27fb6 = getweapon(#"ww_ieu_shockwave_t9");
        if (!self hasweapon(var_1ec27fb6)) {
            a_str_rewards[a_str_rewards.size] = #"hash_1eca2dde13903d98";
        }
        str_reward = function_56c888ce(a_str_rewards);
        switch (str_reward) {
        case #"weapon":
            self thread function_11be5095(4, 15, 1, undefined);
            break;
        case #"extra_life":
            self thread function_d36fb590("self_revive", 15, 1);
            self.var_17d719b9 = 1;
            self.var_3703202a++;
            break;
        case #"hash_1eca2dde13903d98":
            self thread function_11be5095(undefined, 15, 0, #"ww_ieu_shockwave_t9");
            break;
        case #"free_perk":
            self thread function_8665509b(15);
            self.var_123836f9++;
            break;
        }
        break;
    }
    if (b_reward) {
        self thread function_6c62f074(self.var_9e09931e);
    }
    self set_tribute(0);
    self namespace_f0b43eb5::set_tributeavailable(0);
}

// Namespace namespace_f999c142/namespace_f999c142
// Params 1, eflags: 0x1 linked
// Checksum 0xb846859c, Offset: 0xdb0
// Size: 0x4c
function set_tribute(n_amount) {
    self.n_tribute = n_amount;
    n_index = self getentitynumber();
    level.var_edbe6a7f[n_index] = self.n_tribute;
}

// Namespace namespace_f999c142/namespace_f999c142
// Params 0, eflags: 0x1 linked
// Checksum 0x1ed5ffe6, Offset: 0xe08
// Size: 0x216
function function_ae2c0ba5() {
    var_1f5eb74c = self.var_9e09931e;
    n_step = level.var_8b7ab859 / 4;
    if (self.n_tribute >= n_step * 4) {
        set_tribute(level.var_8b7ab859);
        self.var_9e09931e = 4;
        self thread namespace_f0b43eb5::set_tributeavailable(4);
    } else if (self.n_tribute >= n_step * 3) {
        self.var_9e09931e = 3;
        self thread namespace_f0b43eb5::set_tributeavailable(3);
    } else if (self.n_tribute >= n_step * 2) {
        self.var_9e09931e = 2;
        self thread namespace_f0b43eb5::set_tributeavailable(2);
    } else if (self.n_tribute >= n_step * 1) {
        self.var_9e09931e = 1;
        self thread namespace_f0b43eb5::set_tributeavailable(1);
    } else {
        self.var_9e09931e = 0;
        self thread namespace_f0b43eb5::set_tributeavailable(0);
    }
    var_f3ffdc3e = 0;
    if (self.n_tribute > 0) {
        var_f3ffdc3e = math::clamp(self.var_9e09931e + 1, 0, 4);
    }
    if (var_1f5eb74c < 4) {
        namespace_f0b43eb5::function_34a533b1();
    }
    if (self.var_9e09931e == 4) {
        return 1;
    }
    return (self.n_tribute - n_step * self.var_9e09931e) / n_step;
}

// Namespace namespace_f999c142/namespace_f999c142
// Params 3, eflags: 0x1 linked
// Checksum 0x7874c50f, Offset: 0x1028
// Size: 0x234
function function_d36fb590(var_aa4f9213, var_6c9485fc, *var_b7e0faf0 = 15) {
    self endon(#"death");
    if (var_b7e0faf0) {
        self thread function_29e6dc49(0, var_b7e0faf0);
    }
    var_8b84b3ce = self.var_642ed51a.var_f693bf0b.origin;
    v_spawn_angles = self.var_642ed51a.var_f693bf0b.angles;
    var_24a867e4 = function_ed4a5d52(var_6c9485fc);
    if (!isdefined(var_24a867e4)) {
        return;
    }
    var_4d0b3b87 = util::spawn_model(var_24a867e4, var_8b84b3ce, v_spawn_angles);
    self.var_642ed51a.var_f693bf0b clientfield::set("" + #"hash_653b5827e6fbe5f9", 1);
    self.var_642ed51a.var_f92a5f81 = var_4d0b3b87;
    var_4d0b3b87 playsound(#"zmb_spawn_powerup");
    var_4d0b3b87 playloopsound(#"zmb_spawn_powerup_loop");
    b_give_reward = self function_dcda5d87(var_4d0b3b87, 1, 1);
    if (b_give_reward) {
        level thread zm_audio::sndannouncerplayvox(var_6c9485fc);
        if (var_6c9485fc == "self_revive") {
            self zm_laststand::function_3a00302e();
        } else {
            level [[ level._custom_powerups[var_6c9485fc].grab_powerup ]](self);
        }
    }
    self stoploopsound();
}

// Namespace namespace_f999c142/namespace_f999c142
// Params 2, eflags: 0x1 linked
// Checksum 0x2df8b7c7, Offset: 0x1268
// Size: 0xea
function function_29e6dc49(var_be164210 = 1, var_6c9485fc = 15) {
    self endon(#"death");
    v_loc = self.var_642ed51a.var_f693bf0b.origin;
    var_b3556b34 = self.var_642ed51a.var_e3345cac.origin;
    level thread zm_utility::function_4a25b584(v_loc, var_6c9485fc, 100, 1, 0.25, 200, var_b3556b34);
    if (var_be164210) {
        self.var_a7b66476 = 1;
        wait 5;
        self.var_a7b66476 = undefined;
    }
}

// Namespace namespace_f999c142/namespace_f999c142
// Params 0, eflags: 0x1 linked
// Checksum 0x9a1d136b, Offset: 0x1360
// Size: 0x314
function function_a8243f37() {
    level.var_433de94b = [];
    level.var_433de94b[level.var_433de94b.size] = #"shotgun_pump_t9";
    level.var_433de94b[level.var_433de94b.size] = #"pistol_burst_t9";
    level.var_2e1a7563 = 0;
    level.var_30641602 = [];
    level.var_30641602[level.var_30641602.size] = #"shotgun_semiauto_t9";
    level.var_30641602[level.var_30641602.size] = #"smg_standard_t9";
    level.var_8e5c4768 = 0;
    level.var_fc2d4a2 = [];
    level.var_fc2d4a2[level.var_fc2d4a2.size] = #"tr_longburst_t9";
    level.var_fc2d4a2[level.var_fc2d4a2.size] = #"tr_damagesemi_t9";
    level.var_fc2d4a2[level.var_fc2d4a2.size] = #"smg_heavy_t9";
    level.var_e3d39f70 = 0;
    level.var_24b50714 = [];
    level.var_24b50714[level.var_24b50714.size] = #"ar_accurate_t9";
    level.var_24b50714[level.var_24b50714.size] = #"sniper_quickscope_t9";
    level.var_24b50714[level.var_24b50714.size] = #"launcher_standard_t9";
    level.var_24b50714[level.var_24b50714.size] = #"ar_standard_t9";
    level.var_24b50714[level.var_24b50714.size] = #"sniper_standard_t9";
    level.var_de18c954 = 0;
    level.var_592fbce6 = [];
    level.var_592fbce6[#"knife_loadout"] = 3;
    level.var_592fbce6[#"shotgun_semiauto_t9"] = -9;
    level.var_592fbce6[#"smg_standard_t9"] = 0;
    level.var_592fbce6[#"tr_longburst_t9"] = -6;
    level.var_592fbce6[#"tr_damagesemi_t9"] = -7;
    level.var_592fbce6[#"smg_heavy_t9"] = -2;
    level.var_592fbce6[#"ar_accurate_t9"] = -5;
    level.var_592fbce6[#"sniper_quickscope_t9"] = -9;
    level.var_592fbce6[#"launcher_standard_t9"] = 5;
    level.var_592fbce6[#"ar_standard_t9"] = -9;
    level.var_592fbce6[#"sniper_standard_t9"] = -6;
    level.var_592fbce6[#"ww_ieu_shockwave_t9"] = 0;
}

// Namespace namespace_f999c142/namespace_f999c142
// Params 1, eflags: 0x1 linked
// Checksum 0xffde604d, Offset: 0x1680
// Size: 0x2a6
function get_weapon(var_7ed75e97) {
    str_weapon = undefined;
    switch (var_7ed75e97) {
    case 1:
        if (level.var_433de94b.size > 0) {
            level.var_2e1a7563 = function_566c19d5(level.var_433de94b, level.var_2e1a7563);
            str_weapon = level.var_433de94b[level.var_2e1a7563];
            level.var_2e1a7563++;
            if (level.var_2e1a7563 >= level.var_433de94b.size) {
                level.var_2e1a7563 = 0;
            }
        }
    case 2:
        if (level.var_30641602.size > 0) {
            level.var_8e5c4768 = function_566c19d5(level.var_30641602, level.var_8e5c4768);
            str_weapon = level.var_30641602[level.var_8e5c4768];
            level.var_8e5c4768++;
            if (level.var_8e5c4768 >= level.var_30641602.size) {
                level.var_8e5c4768 = 0;
            }
        }
        break;
    case 3:
        if (level.var_fc2d4a2.size > 0) {
            level.var_e3d39f70 = function_566c19d5(level.var_fc2d4a2, level.var_e3d39f70);
            str_weapon = level.var_fc2d4a2[level.var_e3d39f70];
            level.var_e3d39f70++;
            if (level.var_e3d39f70 >= level.var_fc2d4a2.size) {
                level.var_e3d39f70 = 0;
            }
        }
        break;
    case 4:
        if (level.var_24b50714.size > 0) {
            level.var_f2a057b1 = function_566c19d5(level.var_24b50714, level.var_de18c954);
            str_weapon = level.var_24b50714[level.var_de18c954];
            level.var_de18c954++;
            if (level.var_de18c954 >= level.var_24b50714.size) {
                level.var_de18c954 = 0;
            }
        }
        break;
    }
    return str_weapon;
}

// Namespace namespace_f999c142/namespace_f999c142
// Params 2, eflags: 0x1 linked
// Checksum 0xa522f6e8, Offset: 0x1930
// Size: 0x19e
function function_566c19d5(var_3d01acc1, n_index) {
    n_start_index = n_index;
    b_found = 0;
    a_player_weapons = self getweaponslist();
    foreach (str_weapon in var_3d01acc1) {
        var_b2425ef = str_weapon + "_upgraded";
        foreach (wpn in a_player_weapons) {
            if (wpn.name == str_weapon || wpn.name == var_b2425ef) {
                b_found = 1;
                break;
            }
        }
        if (!b_found) {
            return n_index;
        }
        n_index++;
        if (n_index >= var_3d01acc1.size) {
            n_index = 0;
        }
    }
    return n_start_index;
}

// Namespace namespace_f999c142/namespace_f999c142
// Params 4, eflags: 0x1 linked
// Checksum 0x13fc7bc1, Offset: 0x1ad8
// Size: 0x27c
function function_11be5095(var_7ed75e97, var_6c9485fc = 15, b_upgraded = 0, var_5876e0e2) {
    self endon(#"death", #"disconnect");
    if (var_6c9485fc) {
        self thread function_29e6dc49(0, var_6c9485fc);
    }
    if (isdefined(var_5876e0e2)) {
        str_weapon_name = var_5876e0e2;
    } else {
        str_weapon_name = get_weapon(var_7ed75e97);
    }
    v_loc = self.var_642ed51a.var_f693bf0b.origin;
    v_angles = self.var_642ed51a.var_f693bf0b.angles;
    if (isdefined(level.var_592fbce6[str_weapon_name])) {
        n_amount = level.var_592fbce6[str_weapon_name];
        v_forward = anglestoforward(v_angles);
        v_loc += v_forward * n_amount;
    }
    if (b_upgraded) {
        str_weapon_name += "_upgraded";
    }
    var_4d0b3b87 = zm_utility::spawn_buildkit_weapon_model(self, getweapon(str_weapon_name), undefined, v_loc, v_angles);
    self.var_642ed51a.var_f693bf0b clientfield::set("" + #"hash_653b5827e6fbe5f9", 1);
    self.var_642ed51a.var_f92a5f81 = var_4d0b3b87;
    b_rotate = 1;
    if (str_weapon_name == #"ww_ieu_shockwave_t9") {
        b_rotate = 0;
    }
    b_give_reward = self function_dcda5d87(var_4d0b3b87, b_rotate, 0);
    if (b_give_reward) {
        self function_e2a25377(str_weapon_name);
    }
}

// Namespace namespace_f999c142/namespace_f999c142
// Params 1, eflags: 0x1 linked
// Checksum 0xdb70e575, Offset: 0x1d60
// Size: 0xb2
function function_e2a25377(str_weapon_name) {
    var_498a708 = getweapon(str_weapon_name);
    if (self hasweapon(zm_weapons::get_base_weapon(var_498a708), 1, 1)) {
        self zm_weapons::weapon_take(zm_weapons::get_base_weapon(var_498a708));
    }
    weapon_given = self zm_weapons::weapon_give(var_498a708, 1);
    return weapon_given;
}

// Namespace namespace_f999c142/namespace_f999c142
// Params 1, eflags: 0x1 linked
// Checksum 0x754ed7a6, Offset: 0x1e20
// Size: 0x15c
function function_7dc3dfdb(var_6c9485fc = 0) {
    self endon(#"death");
    if (var_6c9485fc) {
        self thread function_29e6dc49(0, var_6c9485fc);
    }
    var_8b84b3ce = self.var_642ed51a.var_f693bf0b.origin;
    v_spawn_angles = self.var_642ed51a.var_f693bf0b.angles;
    v_forward = anglestoforward(v_spawn_angles);
    var_4d0b3b87 = util::spawn_model("p8_zm_powerup_aat", var_8b84b3ce, v_spawn_angles);
    self.var_642ed51a.var_f92a5f81 = var_4d0b3b87;
    b_taken = self function_dcda5d87(var_4d0b3b87, 1, 1);
    if (b_taken) {
        weapon = self getcurrentweapon();
        self thread function_fc6ae19f();
    }
}

// Namespace namespace_f999c142/namespace_f999c142
// Params 0, eflags: 0x1 linked
// Checksum 0xf9399cd1, Offset: 0x1f88
// Size: 0x9c
function function_fc6ae19f() {
    if (self validation()) {
        current_weapon = self getcurrentweapon();
        current_weapon = self zm_weapons::switch_from_alt_weapon(current_weapon);
        var_9a9544b8 = self aat::getaatonweapon(current_weapon, 1);
        self aat::acquire(current_weapon, undefined, var_9a9544b8);
    }
}

// Namespace namespace_f999c142/namespace_f999c142
// Params 1, eflags: 0x1 linked
// Checksum 0xa136defa, Offset: 0x2030
// Size: 0x7c
function function_8665509b(var_6c9485fc = 15) {
    var_62fef0f1 = self zm_perks::function_5ea0c6cf(array(#"specialty_quickrevive"));
    if (!isdefined(var_62fef0f1)) {
        return;
    }
    self thread give_perk_reward(var_62fef0f1, var_6c9485fc);
}

// Namespace namespace_f999c142/namespace_f999c142
// Params 2, eflags: 0x1 linked
// Checksum 0x37b546b6, Offset: 0x20b8
// Size: 0x18c
function give_perk_reward(var_16c042b8, var_6c9485fc = 15) {
    self endon(#"death");
    if (var_6c9485fc) {
        self thread function_29e6dc49(0, var_6c9485fc);
    }
    var_8b84b3ce = self.var_642ed51a.var_f693bf0b.origin;
    v_spawn_angles = self.var_642ed51a.var_f693bf0b.angles;
    var_fb2313c1 = zm_perks::get_perk_weapon_model(var_16c042b8);
    var_4d0b3b87 = util::spawn_model(var_fb2313c1, var_8b84b3ce, v_spawn_angles);
    self.var_642ed51a.var_f693bf0b clientfield::set("" + #"hash_653b5827e6fbe5f9", 1);
    self.var_642ed51a.var_f92a5f81 = var_4d0b3b87;
    self thread function_545834dc(var_16c042b8);
    b_taken = self function_dcda5d87(var_4d0b3b87, 1, 1);
    if (b_taken) {
        self zm_perks::function_29387491(var_16c042b8);
    }
}

// Namespace namespace_f999c142/namespace_f999c142
// Params 3, eflags: 0x1 linked
// Checksum 0x3874f691, Offset: 0x2250
// Size: 0x44c
function function_53a333a8(var_ecffa2a8, var_41f9c5ff = undefined, var_893baaf = undefined) {
    if (isbot(self)) {
        return;
    }
    if (self laststand::player_is_in_laststand()) {
        return;
    }
    if (isdefined(var_41f9c5ff)) {
        if (!is_true(self.var_4373c66b)) {
            var_41f9c5ff = self function_73fda38e(var_41f9c5ff);
            self set_tribute(self.n_tribute + var_41f9c5ff);
            self.var_6b3806e8 += var_41f9c5ff / level.var_8b7ab859;
            self.var_207f01b0 += var_41f9c5ff / level.var_8b7ab859;
            self playsoundtoplayer(#"hash_51923ec42cdda138", self);
        }
    } else if (isdefined(var_ecffa2a8)) {
        n_amount = self function_955b59b2(var_ecffa2a8, var_893baaf);
        if (is_true(self.var_4373c66b)) {
            n_amount = 0;
        } else {
            set_tribute(self.n_tribute + n_amount);
            self.var_6b3806e8 += n_amount / level.var_8b7ab859;
            self.var_207f01b0 += n_amount / level.var_8b7ab859;
            self playsoundtoplayer(#"hash_51923ec42cdda138", self);
        }
    }
    if (level.var_2dffd020 === 4 && self.var_207f01b0 >= 0.2) {
        self thread namespace_f0b43eb5::function_34b03961();
    }
    var_1f5eb74c = self.var_9e09931e;
    self function_ae2c0ba5();
    if (var_1f5eb74c != self.var_9e09931e) {
        switch (self.var_9e09931e) {
        case 1:
            self playsoundtoplayer(#"hash_15350c3643360459", self);
            /#
                iprintlnbold("<dev string:x47>");
            #/
            break;
        case 2:
            self playsoundtoplayer(#"hash_15350c3643360459", self);
            /#
                iprintlnbold("<dev string:x61>");
            #/
            break;
        case 3:
            self playsoundtoplayer(#"hash_15350c3643360459", self);
            /#
                iprintlnbold("<dev string:x7a>");
            #/
            break;
        case 4:
            self playsoundtoplayer(#"hash_15350c3643360459", self);
            /#
                iprintlnbold("<dev string:x95>");
            #/
            break;
        }
    }
    if (isplayer(self) && isdefined(self.var_642ed51a)) {
        self.var_642ed51a.var_f693bf0b clientfield::set("" + #"hash_21f5fab6a3d22093", self.var_9e09931e);
    }
}

// Namespace namespace_f999c142/namespace_f999c142
// Params 1, eflags: 0x1 linked
// Checksum 0x1b86c83e, Offset: 0x26a8
// Size: 0xf2
function function_56c888ce(a_str_rewards) {
    if (!a_str_rewards.size) {
        return #"empty";
    }
    n_max = a_str_rewards.size;
    if (n_max > 4) {
        n_max = 4;
    }
    var_c481f7e6 = randomint(n_max * 1000);
    if (var_c481f7e6 <= 1000) {
        str_reward = a_str_rewards[0];
    } else if (var_c481f7e6 <= 1000 * 2) {
        str_reward = a_str_rewards[1];
    } else if (var_c481f7e6 <= 1000 * 3) {
        str_reward = a_str_rewards[2];
    } else {
        str_reward = a_str_rewards[3];
    }
    return str_reward;
}

// Namespace namespace_f999c142/namespace_f999c142
// Params 1, eflags: 0x1 linked
// Checksum 0xc46a04c4, Offset: 0x27a8
// Size: 0xea
function function_73fda38e(n_amount) {
    if (!n_amount) {
        return 0;
    }
    switch (self.var_9e09931e) {
    case 0:
        n_amount *= 1.5;
        break;
    case 1:
        n_amount *= 0.7;
        break;
    case 2:
        n_amount *= 0.5;
        break;
    case 3:
    case 4:
        n_amount *= 0.35;
        break;
    }
    if (n_amount == 0) {
        n_amount = 1;
    }
    return n_amount;
}

// Namespace namespace_f999c142/namespace_f999c142
// Params 2, eflags: 0x1 linked
// Checksum 0xb176b3cf, Offset: 0x28a0
// Size: 0x3fa
function function_955b59b2(var_5436555f, var_893baaf) {
    n_amount = 0;
    switch (var_5436555f) {
    case 11:
        n_amount = level.var_8b7ab859 * 0.1;
        break;
    case 1:
    case 2:
    case 3:
    case 4:
    case 5:
    case 6:
    case 7:
        n_amount = level.var_8b7ab859 * 0.03;
        break;
    case 12:
        n_amount = level.var_8b7ab859 * 0.04;
        break;
    case 10:
        n_frac = var_893baaf / self.maxhealth;
        n_amount = level.var_8b7ab859 * 0.25 * n_frac;
        break;
    case 9:
        n_amount = level.var_8b7ab859 * 0.025 * var_893baaf;
        break;
    case 13:
        n_amount = level.var_8b7ab859 * 0.02;
        break;
    case 14:
    case 15:
    case 16:
    case 17:
    case 18:
        n_amount = level.var_8b7ab859 * 0.015;
        break;
    case 19:
    case 20:
    case 21:
    case 22:
    case 23:
        n_amount = level.var_8b7ab859 * 0.007;
        break;
    case 24:
    case 25:
    case 26:
    case 27:
    case 28:
    case 29:
        n_amount = level.var_8b7ab859 * 0.02;
        break;
    case 31:
        n_amount = level.var_8b7ab859 * 0.02;
        break;
    case 32:
        n_amount = level.var_8b7ab859 * 0.02;
        break;
    case 33:
        n_amount = level.var_8b7ab859 * 0.001;
        break;
    case 34:
        n_amount = level.var_8b7ab859 * 0.25;
        break;
    default:
        n_amount = 0;
        break;
    }
    n_amount = self function_73fda38e(n_amount);
    return n_amount;
}

// Namespace namespace_f999c142/namespace_f999c142
// Params 1, eflags: 0x1 linked
// Checksum 0x94e7171d, Offset: 0x2ca8
// Size: 0x3ea
function function_6c62f074(var_9e09931e) {
    switch (var_9e09931e) {
    case 2:
        if (math::cointoss()) {
            level thread function_445c5623("double_points", self.var_642ed51a.var_f693bf0b.origin, self.var_642ed51a);
        } else {
            level thread function_445c5623("carpenter", self.var_642ed51a.var_f693bf0b.origin, self.var_642ed51a);
        }
        break;
    case 3:
        if (math::cointoss()) {
            if (math::cointoss()) {
                level thread function_445c5623("double_points", self.var_642ed51a.var_f693bf0b.origin, self.var_642ed51a);
            } else {
                level thread function_445c5623("carpenter", self.var_642ed51a.var_f693bf0b.origin, self.var_642ed51a);
            }
        } else if (math::cointoss()) {
            level thread function_445c5623("full_ammo", self.var_642ed51a.var_f693bf0b.origin, self.var_642ed51a);
        } else {
            level thread function_445c5623("fire_sale", self.var_642ed51a.var_f693bf0b.origin, self.var_642ed51a);
        }
        break;
    case 4:
        var_c481f7e6 = randomint(1000);
        if (var_c481f7e6 <= 333) {
            self thread function_ae58bd73(self.var_642ed51a.var_f693bf0b.origin);
            break;
        }
        if (var_c481f7e6 <= 666) {
            if (math::cointoss()) {
                level thread function_445c5623("full_ammo", self.var_642ed51a.var_f693bf0b.origin, self.var_642ed51a);
            } else {
                level thread function_445c5623("fire_sale", self.var_642ed51a.var_f693bf0b.origin, self.var_642ed51a);
            }
        }
        if (var_c481f7e6 <= 1000) {
            if (math::cointoss()) {
                level thread function_445c5623("double_points", self.var_642ed51a.var_f693bf0b.origin, self.var_642ed51a);
            } else {
                level thread function_445c5623("carpenter", self.var_642ed51a.var_f693bf0b.origin, self.var_642ed51a);
            }
        }
        break;
    default:
        break;
    }
}

// Namespace namespace_f999c142/namespace_f999c142
// Params 1, eflags: 0x1 linked
// Checksum 0x34e46300, Offset: 0x30a0
// Size: 0x304
function function_ae58bd73(var_8b84b3ce) {
    self endon(#"death");
    v_angles = self.var_642ed51a.var_f693bf0b.angles;
    var_4d0b3b87 = util::spawn_model("p8_zm_powerup_aat", var_8b84b3ce, v_angles);
    var_4eadb6a8 = util::spawn_model("tag_origin", var_8b84b3ce, v_angles);
    var_4eadb6a8 linkto(var_4d0b3b87);
    var_4d0b3b87 playsound(#"hash_e3e5f7c83015171");
    var_4d0b3b87 playloopsound(#"hash_2adfa98b79668366");
    v_forward = anglestoforward(v_angles);
    while (true) {
        s_result = positionquery_source_navigation(self.var_642ed51a.var_e3345cac.origin, 1, 60, 4, 15, 1);
        var_cb7582a6 = s_result.data;
        random_index = randomint(var_cb7582a6.size);
        var_bbefa45e = var_cb7582a6[random_index];
        v_loc = var_bbefa45e.origin;
        n_power = length(var_8b84b3ce - v_loc);
        if (n_power != 0) {
            break;
        }
        waitframe(1);
    }
    var_4d0b3b87 clientfield::set("" + #"hash_19bbbc55e95ee629", 1);
    var_cef149e8 = var_4d0b3b87 zm_utility::fake_physicslaunch(v_loc + (0, 0, 25), n_power);
    wait var_cef149e8;
    e_player = level function_c45635c7(var_4d0b3b87, 1, 1);
    if (isplayer(e_player)) {
        weapon = e_player getcurrentweapon();
        e_player thread function_fc6ae19f();
        e_player playsound(#"hash_1c696244a9a3dbbf");
    }
}

// Namespace namespace_f999c142/namespace_f999c142
// Params 3, eflags: 0x1 linked
// Checksum 0xf682fb20, Offset: 0x33b0
// Size: 0x30c
function function_445c5623(var_aa4f9213, var_8b84b3ce, reward_terminal) {
    v_angles = reward_terminal.var_f693bf0b.angles;
    var_80f6fcee = reward_terminal.var_e3345cac.origin;
    var_24a867e4 = function_ed4a5d52(var_aa4f9213);
    if (!isdefined(var_24a867e4)) {
        return;
    }
    var_4d0b3b87 = util::spawn_model(var_24a867e4, var_8b84b3ce, v_angles);
    var_4eadb6a8 = util::spawn_model("tag_origin", var_8b84b3ce, v_angles);
    var_4eadb6a8 linkto(var_4d0b3b87);
    var_4d0b3b87 playsound(#"hash_e3e5f7c83015171");
    var_4d0b3b87 playloopsound(#"hash_2adfa98b79668366");
    while (true) {
        s_result = positionquery_source_navigation(var_80f6fcee, 1, 60, 4, 15, 1);
        var_cb7582a6 = s_result.data;
        random_index = randomint(var_cb7582a6.size);
        var_bbefa45e = var_cb7582a6[random_index];
        v_loc = var_bbefa45e.origin;
        n_power = length(reward_terminal.var_f693bf0b.origin - v_loc);
        if (n_power != 0) {
            break;
        }
        waitframe(1);
    }
    var_4d0b3b87 clientfield::set("" + #"hash_19bbbc55e95ee629", 1);
    var_cef149e8 = var_4d0b3b87 zm_utility::fake_physicslaunch(v_loc + (0, 0, 25), n_power);
    wait var_cef149e8;
    e_player = level function_c45635c7(var_4d0b3b87, 1, 1);
    if (isplayer(e_player)) {
        if (var_aa4f9213 == "self_revive") {
            e_player zm_laststand::function_3a00302e();
            return;
        }
        level [[ level._custom_powerups[var_aa4f9213].grab_powerup ]](e_player);
    }
}

// Namespace namespace_f999c142/namespace_f999c142
// Params 3, eflags: 0x1 linked
// Checksum 0xbb60f65b, Offset: 0x36c8
// Size: 0x1be
function function_c45635c7(var_4d0b3b87, b_rotate, var_b9b24) {
    var_4d0b3b87 thread pickup_timeout(undefined, "spew_reward_packed_up");
    if (b_rotate) {
        var_4d0b3b87 thread function_51fd2597(var_b9b24);
    }
    wait 2;
    while (!is_true(var_4d0b3b87.b_timeout)) {
        e_collision = undefined;
        a_players = getplayers();
        foreach (player in a_players) {
            n_dist = distance2d(player.origin, var_4d0b3b87.origin);
            if (n_dist < 25) {
                e_collision = player;
                break;
            }
        }
        if (isdefined(e_collision)) {
            break;
        }
        waitframe(1);
    }
    b_timeout = var_4d0b3b87.b_timeout;
    var_4d0b3b87 delete();
    if (is_true(b_timeout)) {
        return undefined;
    }
    return e_collision;
}

// Namespace namespace_f999c142/namespace_f999c142
// Params 1, eflags: 0x1 linked
// Checksum 0x587d8c03, Offset: 0x3890
// Size: 0xf6
function function_ed4a5d52(var_f0de9b92) {
    var_9c0bf2db = undefined;
    switch (var_f0de9b92) {
    case #"double_points":
        var_9c0bf2db = #"p7_zm_power_up_double_points";
        break;
    case #"carpenter":
        var_9c0bf2db = #"p7_zm_power_up_carpenter";
        break;
    case #"full_ammo":
        var_9c0bf2db = #"p7_zm_power_up_max_ammo";
        break;
    case #"fire_sale":
        var_9c0bf2db = #"p7_zm_power_up_firesale";
        break;
    case #"self_revive":
        var_9c0bf2db = #"p8_zm_gla_heart_zombie";
        break;
    }
    return var_9c0bf2db;
}

// Namespace namespace_f999c142/namespace_f999c142
// Params 3, eflags: 0x1 linked
// Checksum 0x138c543d, Offset: 0x3990
// Size: 0x1c6
function function_dcda5d87(var_4d0b3b87, b_rotate = 1, var_b9b24 = 1) {
    self endon(#"death");
    self.var_7a281a7e = var_4d0b3b87;
    var_4d0b3b87 thread pickup_timeout(self, "challenge_reward_timeout");
    if (b_rotate) {
        var_4d0b3b87 thread function_51fd2597(var_b9b24);
    }
    self.var_4373c66b = 1;
    self.var_43300e = 1;
    self.var_ccc18354 = gettime() / 1000 + 0.1;
    self waittill(#"hash_3cd13a6cb08bba96", #"challenge_reward_timeout", #"disconnect");
    self.var_ccc18354 = gettime() / 1000 + 0.1;
    self.var_43300e = undefined;
    self.var_4373c66b = undefined;
    b_timeout = var_4d0b3b87.b_timeout;
    var_4d0b3b87 delete();
    self.var_642ed51a.var_f693bf0b clientfield::set("" + #"hash_653b5827e6fbe5f9", 0);
    self notify(#"hash_358f065cca50b2a7");
    if (is_true(b_timeout)) {
        return false;
    }
    return true;
}

// Namespace namespace_f999c142/namespace_f999c142
// Params 3, eflags: 0x1 linked
// Checksum 0xe3d77d05, Offset: 0x3b60
// Size: 0x114
function pickup_timeout(e_player, var_cbfbd48a, var_22b0e42b = 15) {
    self endon(#"death");
    wait var_22b0e42b;
    for (i = 0; i < 40; i++) {
        if (i % 2) {
            self ghost();
        } else {
            self show();
        }
        if (i < 15) {
            wait 0.5;
            continue;
        }
        if (i < 25) {
            wait 0.25;
            continue;
        }
        wait 0.1;
    }
    self ghost();
    self.b_timeout = 1;
    if (isdefined(e_player)) {
        e_player notify(var_cbfbd48a);
    }
}

// Namespace namespace_f999c142/namespace_f999c142
// Params 1, eflags: 0x1 linked
// Checksum 0xa7d612bc, Offset: 0x3c80
// Size: 0x266
function function_51fd2597(var_b9b24 = 1) {
    self endon(#"death");
    v_center = self getcentroid();
    var_4e7cc086 = util::spawn_model(#"tag_origin", v_center, self.angles);
    self linkto(var_4e7cc086);
    var_4e7cc086 thread function_57b8a4e9(self);
    while (isdefined(self)) {
        if (var_b9b24) {
            waittime = randomfloatrange(2.5, 5);
            yaw = randomint(360);
            if (yaw > 300) {
                yaw = 300;
            } else if (yaw < 60) {
                yaw = 60;
            }
            yaw = self.angles[1] + yaw;
            new_angles = (-60 + randomint(120), yaw, -45 + randomint(90));
            var_4e7cc086 rotateto(new_angles, waittime, waittime * 0.5, waittime * 0.5);
            wait randomfloat(waittime - 0.1);
            continue;
        }
        new_angles = (self.angles[0], self.angles[1] + 45, self.angles[2]);
        var_4e7cc086 rotateto(new_angles, 2, 2 * 0.05, 2 * 0.05);
        wait 2;
    }
}

// Namespace namespace_f999c142/namespace_f999c142
// Params 1, eflags: 0x1 linked
// Checksum 0xe2c7a009, Offset: 0x3ef0
// Size: 0x3c
function function_57b8a4e9(e_pickup) {
    e_pickup waittill(#"death");
    self delete();
}

// Namespace namespace_f999c142/namespace_f999c142
// Params 1, eflags: 0x1 linked
// Checksum 0xe2e21ad6, Offset: 0x3f38
// Size: 0x8c
function function_545834dc(var_16c042b8) {
    self endon(#"death", #"hash_358f065cca50b2a7");
    while (true) {
        if (self function_6c32d092(var_16c042b8)) {
            if (isdefined(self.var_7a281a7e)) {
                self.var_7a281a7e.b_timeout = 1;
            }
            self notify(#"challenge_reward_timeout");
            break;
        }
        waitframe(1);
    }
}

// Namespace namespace_f999c142/namespace_f999c142
// Params 0, eflags: 0x1 linked
// Checksum 0xbb0d6724, Offset: 0x3fd0
// Size: 0xe2
function validation() {
    current_weapon = self getcurrentweapon();
    if (!zm_weapons::is_weapon_or_base_included(current_weapon) || !self zm_magicbox::can_buy_weapon() || self laststand::player_is_in_laststand() || is_true(self.intermission) || self isthrowinggrenade() || self isswitchingweapons() || !zm_weapons::weapon_supports_aat(current_weapon)) {
        return false;
    }
    return true;
}

