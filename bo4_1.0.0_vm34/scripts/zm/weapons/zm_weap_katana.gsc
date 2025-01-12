#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie_shared;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\perks;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\throttle_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\zm_common\callbacks;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_hero_weapon;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_net;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_utility;

#namespace zm_weap_katana;

// Namespace zm_weap_katana/zm_weap_katana
// Params 0, eflags: 0x2
// Checksum 0x1d88b4ba, Offset: 0x208
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_weap_katana", &__init__, undefined, undefined);
}

// Namespace zm_weap_katana/zm_weap_katana
// Params 0, eflags: 0x0
// Checksum 0x7391a285, Offset: 0x250
// Size: 0x23c
function __init__() {
    clientfield::register("toplayer", "hero_katana_vigor_postfx", 1, 1, "counter");
    clientfield::register("allplayers", "katana_rush_postfx", 1, 1, "int");
    clientfield::register("allplayers", "katana_rush_sfx", 1, 1, "int");
    level.hero_weapon[#"katana"][0] = getweapon(#"hero_katana_t8_lv1");
    level.hero_weapon[#"katana"][1] = getweapon(#"hero_katana_t8_lv2");
    level.hero_weapon[#"katana"][2] = getweapon(#"hero_katana_t8_lv3");
    zm_loadout::register_hero_weapon_for_level(#"hero_katana_t8_lv1");
    zm_loadout::register_hero_weapon_for_level(#"hero_katana_t8_lv2");
    zm_loadout::register_hero_weapon_for_level(#"hero_katana_t8_lv3");
    level.var_283a01a2 = 0;
    level.var_69119edc = new throttle();
    [[ level.var_69119edc ]]->initialize(6, 0.1);
    callback::on_connect(&function_296b5559);
    zm::register_zombie_damage_override_callback(&function_b7a52400);
}

// Namespace zm_weap_katana/zm_weap_katana
// Params 2, eflags: 0x0
// Checksum 0xd36c0102, Offset: 0x498
// Size: 0xcc
function function_78220d55(weapon, var_be5b1c67 = 1) {
    if (weapon == level.hero_weapon[#"katana"][2]) {
        return true;
    }
    if (weapon == level.hero_weapon[#"katana"][1] && var_be5b1c67 < 3) {
        return true;
    }
    if (weapon == level.hero_weapon[#"katana"][0] && var_be5b1c67 < 2) {
        return true;
    }
    return false;
}

// Namespace zm_weap_katana/zm_weap_katana
// Params 0, eflags: 0x4
// Checksum 0x68e873be, Offset: 0x570
// Size: 0x358
function private function_296b5559() {
    self endon(#"disconnect");
    self thread function_50cc5205();
    while (true) {
        waitresult = self waittill(#"weapon_change");
        wpn_cur = waitresult.weapon;
        wpn_prev = waitresult.last_weapon;
        if (isinarray(level.hero_weapon[#"katana"], wpn_cur)) {
            self clientfield::increment_to_player("hero_katana_vigor_postfx");
            self function_f42a14f1(1);
            self thread function_21ee6357();
            self thread function_635576f(wpn_cur);
        } else if (isinarray(level.hero_weapon[#"katana"], wpn_prev)) {
            self function_f42a14f1(0);
            self notify(#"hero_katana_expired");
        }
        if (wpn_cur == level.hero_weapon[#"katana"][0]) {
            zm_hero_weapon::show_hint(wpn_cur, #"hash_648a5b1eedae58b9");
            self thread function_dca397cc();
            continue;
        }
        if (wpn_cur == level.hero_weapon[#"katana"][1]) {
            zm_hero_weapon::show_hint(wpn_cur, #"hash_52cddac894472d22");
            self thread function_a408e0ba(wpn_cur);
            self thread function_d145c1c1(wpn_cur);
            self thread function_dca397cc();
            continue;
        }
        if (wpn_cur == level.hero_weapon[#"katana"][2]) {
            if (!self gamepadusedlast()) {
                self zm_hero_weapon::show_hint(wpn_cur, #"hash_4bf673fe684c7bcd");
            } else {
                self zm_hero_weapon::show_hint(wpn_cur, #"hash_33116738f78d04b3");
            }
            self thread function_a408e0ba(wpn_cur);
            self thread function_3d2ab13f(wpn_cur);
            self thread function_28e4f6c8(wpn_cur);
            self thread function_dca397cc();
        }
    }
}

// Namespace zm_weap_katana/zm_weap_katana
// Params 0, eflags: 0x4
// Checksum 0xa9c3f172, Offset: 0x8d0
// Size: 0x74
function private function_dca397cc() {
    wait 1;
    callback::on_ai_damage(&function_70f3c95d);
    self waittill(#"death", #"hero_katana_expired");
    callback::remove_on_ai_damage(&function_70f3c95d);
}

// Namespace zm_weap_katana/zm_weap_katana
// Params 0, eflags: 0x4
// Checksum 0x78a71e8a, Offset: 0x950
// Size: 0x90
function private function_50cc5205() {
    self endon(#"disconnect");
    while (true) {
        waitresult = self waittill(#"hero_weapon_give");
        var_1cf82592 = waitresult.weapon;
        if (function_78220d55(var_1cf82592, 2)) {
            self clientfield::increment_to_player("hero_katana_vigor_postfx");
        }
    }
}

// Namespace zm_weap_katana/zm_weap_katana
// Params 13, eflags: 0x0
// Checksum 0x3e6a90c4, Offset: 0x9e8
// Size: 0x1be
function function_b7a52400(willbekilled, einflictor, eattacker, idamage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
    if (function_78220d55(weapon, 1) && !(isdefined(willbekilled) && willbekilled)) {
        if (self.var_29ed62b2 == #"basic" || self.var_29ed62b2 == #"popcorn") {
            idamage = self.health + idamage;
        } else if (self.var_29ed62b2 == #"miniboss" || self.var_29ed62b2 == #"boss") {
            if (isdefined(eattacker) && isdefined(eattacker.var_79d26378)) {
                switch (eattacker.var_79d26378) {
                case 0:
                    if (isdefined(self.maxhealth)) {
                        idamage = self.maxhealth * 0.25;
                    }
                    break;
                case 1:
                    if (isdefined(self.maxhealth)) {
                        idamage = self.maxhealth * 0.5;
                    }
                    break;
                }
            }
        }
    }
    return idamage;
}

// Namespace zm_weap_katana/zm_weap_katana
// Params 1, eflags: 0x0
// Checksum 0x3795e640, Offset: 0xbb0
// Size: 0x38c
function function_70f3c95d(s_params) {
    if (!isdefined(s_params.weapon)) {
        return;
    }
    if (isplayer(s_params.eattacker)) {
        if (function_78220d55(s_params.weapon, 1)) {
            if (self.var_29ed62b2 == #"basic") {
                if (isdefined(level.no_gib_in_wolf_area) && isdefined(self [[ level.no_gib_in_wolf_area ]]()) && self [[ level.no_gib_in_wolf_area ]]()) {
                    var_dee00930 = 1;
                }
                if (level.var_283a01a2 >= 6) {
                    var_dee00930 = 1;
                }
                if (isdefined(s_params.shitloc)) {
                    if (!(isdefined(var_dee00930) && var_dee00930)) {
                        if (s_params.shitloc === "head" || s_params.shitloc === "helmet") {
                            self thread function_b7398fe3();
                            gibserverutils::gibhead(self);
                        } else if (isdefined(s_params.vpoint)) {
                            self zombie_utility::derive_damage_refs(s_params.vpoint);
                        }
                    }
                }
                waitframe(1);
                if (math::cointoss()) {
                    if (isdefined(s_params.vdir) && self.health <= 0 && !(isdefined(var_dee00930) && var_dee00930)) {
                        var_e9481891 = 75 * vectornormalize(s_params.vdir);
                        var_e9481891 = (var_e9481891[0], var_e9481891[1], 20);
                        self startragdoll();
                        self launchragdoll(var_e9481891);
                    } else {
                        self thread zombie_utility::setup_zombie_knockdown(s_params.eattacker.origin);
                    }
                }
                return;
            }
            if (self.var_29ed62b2 == #"miniboss") {
                if (s_params.shitloc === "head" || s_params.shitloc === "helmet" && isdefined(self.hashelmet) && self.hashelmet) {
                    if (isdefined(self.helmethits && isdefined(self.var_4d530b4a))) {
                        self.helmethits = self.var_4d530b4a;
                        waitframe(1);
                        if (isalive(self)) {
                            self dodamage(1, self.origin, s_params.eattacker, s_params.eattacker, s_params.shitloc, s_params.smeansofdeath, 0, undefined);
                        }
                    }
                }
            }
        }
    }
}

// Namespace zm_weap_katana/zm_weap_katana
// Params 0, eflags: 0x4
// Checksum 0x9300d122, Offset: 0xf48
// Size: 0x40
function private function_b7398fe3() {
    level.var_283a01a2++;
    self waittill(#"death", #"hero_katana_expired");
    level.var_283a01a2--;
}

// Namespace zm_weap_katana/zm_weap_katana
// Params 0, eflags: 0x0
// Checksum 0x5c7f3ffc, Offset: 0xf90
// Size: 0x3f2
function function_21ee6357() {
    while (isalive(self) && self.var_a2cdcac8 === 1) {
        foreach (e_player in level.players) {
            if (distancesquared(e_player.origin, self.origin) <= 1048576 && abs(e_player.origin[2] - self.origin[2] <= 360)) {
                if ((!isdefined(e_player.var_a2cdcac8) || e_player.var_a2cdcac8 !== 1) && !e_player laststand::player_is_in_laststand() && !isdefined(e_player.var_9aea858b)) {
                    e_player.var_eadcab15 = e_player getmovespeedscale();
                    e_player.var_9aea858b = e_player.var_eadcab15 * 1.15;
                    e_player setmovespeedscale(e_player.var_9aea858b);
                    if (!e_player hasperk(#"specialty_fastreload")) {
                        e_player perks::perk_setperk(#"specialty_fastreload");
                        e_player.var_1ef53d51 = 1;
                    }
                }
                continue;
            }
            if ((!isdefined(e_player.var_a2cdcac8) || e_player.var_a2cdcac8 !== 1) && isdefined(e_player.var_9aea858b)) {
                e_player setmovespeedscale(e_player.var_eadcab15);
                e_player.var_9aea858b = undefined;
                e_player.var_eadcab15 = undefined;
                if (isdefined(e_player.var_1ef53d51) && e_player.var_1ef53d51) {
                    e_player perks::perk_unsetperk(#"specialty_fastreload");
                    e_player.var_1ef53d51 = undefined;
                }
            }
        }
        waitframe(1);
    }
    foreach (e_player in level.players) {
        if ((!isdefined(e_player.var_a2cdcac8) || e_player.var_a2cdcac8 !== 1) && isdefined(e_player.var_9aea858b)) {
            e_player setmovespeedscale(e_player.var_eadcab15);
            e_player.var_9aea858b = undefined;
            e_player.var_eadcab15 = undefined;
        }
        if (isdefined(e_player.var_1ef53d51) && e_player.var_1ef53d51) {
            e_player perks::perk_unsetperk(#"specialty_fastreload");
            e_player.var_1ef53d51 = undefined;
        }
    }
}

// Namespace zm_weap_katana/zm_weap_katana
// Params 1, eflags: 0x0
// Checksum 0x4d966e8c, Offset: 0x1390
// Size: 0xa8
function function_635576f(w_katana) {
    self endon(#"disconnect", #"bled_out", #"death", #"hero_katana_expired");
    while (true) {
        s_result = self waittill(#"weapon_melee_power");
        if (s_result.weapon == w_katana) {
            self thread function_c012c1eb(0, w_katana);
        }
    }
}

// Namespace zm_weap_katana/zm_weap_katana
// Params 1, eflags: 0x0
// Checksum 0xe94f5b91, Offset: 0x1440
// Size: 0x146
function function_a408e0ba(w_katana) {
    self endon(#"disconnect", #"bled_out", #"death", #"hero_katana_expired");
    while (true) {
        s_result = self waittill(#"weapon_melee_juke");
        if (s_result.weapon == w_katana) {
            self playsound(#"wpn_katana_dash");
            self thread function_c012c1eb(1, w_katana);
            self thread function_909aa3dd(w_katana);
            self thread flagsys::set_for_time(1, "katana_dash");
            wait 1;
            self notify(#"hash_50c324a04c7e0b09");
            while (self adsbuttonpressed()) {
                wait 0.1;
            }
        }
        waitframe(1);
    }
}

// Namespace zm_weap_katana/zm_weap_katana
// Params 1, eflags: 0x0
// Checksum 0xadaf5920, Offset: 0x1590
// Size: 0x1ea
function function_909aa3dd(w_katana) {
    self endon(#"disconnect", #"bled_out", #"death", #"hero_katana_expired", #"hash_50c324a04c7e0b09");
    str_hitloc = "head";
    while (true) {
        var_b2f3a02b = getaiteamarray(level.zombie_team);
        var_9af2eac0 = self.origin + anglestoforward(self.angles) * 128;
        a_ai_zombies = array::get_all_closest(var_9af2eac0, var_b2f3a02b, undefined, undefined, 64);
        foreach (ai_zombie in a_ai_zombies) {
            [[ level.var_69119edc ]]->waitinqueue(ai_zombie);
            if (!isalive(ai_zombie) || isdefined(ai_zombie.marked_for_death) && ai_zombie.marked_for_death) {
                continue;
            }
            ai_zombie thread function_51f3480d(self, w_katana, str_hitloc);
        }
        waitframe(1);
    }
}

// Namespace zm_weap_katana/zm_weap_katana
// Params 3, eflags: 0x4
// Checksum 0x38450400, Offset: 0x1788
// Size: 0x1e4
function private function_51f3480d(e_player, w_katana, str_hitloc) {
    n_base_damage = 50;
    if (self.var_29ed62b2 == #"basic" || self.var_29ed62b2 == #"popcorn") {
        self dodamage(self.health + 100, e_player.origin, e_player, e_player, str_hitloc, "MOD_MELEE", 0, w_katana);
        self playsound(#"hash_762b44e67bc3761f");
        return;
    }
    switch (self.var_29ed62b2) {
    case #"heavy":
        n_base_damage = 0.15 * self.maxhealth;
        break;
    case #"miniboss":
        n_base_damage = 0.1 * self.maxhealth;
        break;
    case #"boss":
        n_base_damage = 0.05 * self.maxhealth;
        break;
    }
    n_damage = 750 < n_base_damage ? n_base_damage : 750;
    self dodamage(n_damage, e_player.origin, e_player, e_player, str_hitloc, "MOD_MELEE", 0, w_katana);
    self playsound(#"hash_762b44e67bc3761f");
}

// Namespace zm_weap_katana/zm_weap_katana
// Params 1, eflags: 0x0
// Checksum 0x76c2f33c, Offset: 0x1978
// Size: 0xa0
function function_3d2ab13f(w_katana) {
    self endon(#"disconnect", #"bled_out", #"death", #"hero_katana_expired");
    while (true) {
        s_result = self waittill(#"weapon_melee");
        if (s_result.weapon == w_katana) {
            self thread function_859d6521();
        }
    }
}

// Namespace zm_weap_katana/zm_weap_katana
// Params 0, eflags: 0x0
// Checksum 0x41754143, Offset: 0x1a20
// Size: 0x1ae
function function_859d6521() {
    self endon(#"disconnect");
    if (isdefined(self.var_1aaf8148) && self.var_1aaf8148) {
        self notify(#"hero_katana_rush_toggle");
        return;
    }
    self val::set(#"hash_6b725a8367e0178a", "ignoreme");
    self.var_1aaf8148 = 1;
    self clientfield::set("katana_rush_sfx", 1);
    self clientfield::set("katana_rush_postfx", 1);
    waitresult = self waittill(#"hero_katana_expired", #"hero_katana_rush_toggle");
    if (waitresult._notify == #"hero_katana_expired") {
        self playsound(#"hash_58397a948dd38b37");
    }
    self clientfield::set("katana_rush_sfx", 0);
    self clientfield::set("katana_rush_postfx", 0);
    self val::reset(#"hash_6b725a8367e0178a", "ignoreme");
    self.var_1aaf8148 = undefined;
}

// Namespace zm_weap_katana/zm_weap_katana
// Params 2, eflags: 0x0
// Checksum 0x1183dfcd, Offset: 0x1bd8
// Size: 0x18e
function function_c012c1eb(var_f7f1f92d, w_katana) {
    self notify(#"hash_3a8156b04bea1838");
    self endon(#"disconnect", #"bled_out", #"death", #"hash_3a8156b04bea1838");
    switch (var_f7f1f92d) {
    case 0:
        var_40cbf3a0 = 100;
        str_hitloc = array::random(array("torso_lower", "left_arm_upper", "right_arm_upper", "left_leg_upper", "right_leg_upper"));
        self.var_79d26378 = var_f7f1f92d;
        break;
    case 1:
        var_40cbf3a0 = 150;
        str_hitloc = "head";
        self.var_79d26378 = var_f7f1f92d;
        break;
    }
    waitframe(4);
    self function_9f1790b5(var_40cbf3a0, str_hitloc, w_katana);
    waitframe(10);
    self function_9f1790b5(var_40cbf3a0, str_hitloc, w_katana);
    wait 0.1;
    self.var_79d26378 = undefined;
}

// Namespace zm_weap_katana/zm_weap_katana
// Params 3, eflags: 0x0
// Checksum 0xc8ba124f, Offset: 0x1d70
// Size: 0x160
function function_9f1790b5(var_40cbf3a0, str_hitloc, w_katana) {
    var_9af2eac0 = self.origin + anglestoforward(self.angles) * var_40cbf3a0 / 2;
    a_ai_zombies = array::get_all_closest(var_9af2eac0, getaiteamarray(level.zombie_team), undefined, undefined, var_40cbf3a0);
    foreach (ai_zombie in a_ai_zombies) {
        [[ level.var_69119edc ]]->waitinqueue(ai_zombie);
        if (!isalive(ai_zombie) || isdefined(ai_zombie.marked_for_death) && ai_zombie.marked_for_death) {
            continue;
        }
        ai_zombie thread function_51f3480d(self, w_katana, str_hitloc);
    }
}

// Namespace zm_weap_katana/zm_weap_katana
// Params 1, eflags: 0x0
// Checksum 0x34360a31, Offset: 0x1ed8
// Size: 0x1a
function function_f42a14f1(var_a2cdcac8) {
    self.var_a2cdcac8 = var_a2cdcac8;
}

// Namespace zm_weap_katana/zm_weap_katana
// Params 1, eflags: 0x0
// Checksum 0x2f1b101d, Offset: 0x1f00
// Size: 0xc6
function function_d145c1c1(w_katana) {
    self endon(#"disconnect", #"bled_out", #"death", #"hero_katana_expired");
    while (true) {
        s_result = self waittill(#"weapon_melee_juke");
        if (s_result.weapon == w_katana) {
            if (zm_audio::create_and_play_dialog(#"hero_level_2", #"katana")) {
                break;
            }
        }
    }
}

// Namespace zm_weap_katana/zm_weap_katana
// Params 1, eflags: 0x0
// Checksum 0x93bff2, Offset: 0x1fd0
// Size: 0xc6
function function_28e4f6c8(w_katana) {
    self endon(#"disconnect", #"bled_out", #"death", #"hero_katana_expired");
    while (true) {
        s_result = self waittill(#"weapon_melee");
        if (s_result.weapon == w_katana) {
            if (zm_audio::create_and_play_dialog(#"hero_level_3", #"katana")) {
                break;
            }
        }
    }
}

