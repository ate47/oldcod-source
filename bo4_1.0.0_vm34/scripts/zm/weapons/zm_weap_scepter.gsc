#using scripts\abilities\ability_player;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\throttle_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\trials\zm_trial_restrict_loadout;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_hero_weapon;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_trial_util;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace zm_weap_scepter;

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 0, eflags: 0x2
// Checksum 0x38ebd6cd, Offset: 0x3a0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_weap_scepter", &__init__, undefined, undefined);
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 0, eflags: 0x0
// Checksum 0xd195ccdd, Offset: 0x3e8
// Size: 0x4cc
function __init__() {
    clientfield::register("allplayers", "zombie_scepter_melee_impact", 1, 1, "counter");
    clientfield::register("allplayers", "zombie_scepter_melee", 1, 1, "counter");
    clientfield::register("allplayers", "zombie_scepter_heal", 1, 1, "counter");
    clientfield::register("actor", "zombie_scepter_stun", 1, 1, "int");
    clientfield::register("vehicle", "zombie_scepter_stun", 1, 1, "int");
    clientfield::register("scriptmover", "beacon_fx", 1, 1, "int");
    clientfield::register("allplayers", "skull_turret_beam_fire", 1, 2, "int");
    clientfield::register("allplayers", "scepter_beam_flash", 1, 2, "int");
    clientfield::register("toplayer", "hero_scepter_vigor_postfx", 1, 1, "counter");
    clientfield::register("allplayers", "zombie_scepter_revive", 1, 1, "int");
    clientfield::register("toplayer", "scepter_rumble", 1, 3, "counter");
    level.hero_weapon[#"scepter"][0] = getweapon("hero_scepter_lv1");
    level.hero_weapon[#"scepter"][1] = getweapon("hero_scepter_lv2");
    level.hero_weapon[#"scepter"][2] = getweapon("hero_scepter_lv3");
    zm_loadout::register_hero_weapon_for_level("hero_scepter_lv1");
    zm_loadout::register_hero_weapon_for_level("hero_scepter_lv2");
    zm_loadout::register_hero_weapon_for_level("hero_scepter_lv3");
    zm_hero_weapon::function_dceb0db8("scepter", 0, 4000, 7000);
    level.var_3c46c627 = new throttle();
    [[ level.var_3c46c627 ]]->initialize(6, 0.1);
    zm_spawner::register_zombie_death_event_callback(&function_8d85bc18);
    zm_perks::register_lost_perk_override(&function_a473f0f0);
    callback::on_connect(&on_connect);
    callback::on_disconnect(&on_player_disconnect);
    callback::on_bleedout(&reset_override);
    callback::on_revived(&reset_override);
    callback::on_bleedout(&function_b47325a7);
    zm_utility::register_slowdown(#"hash_6c580993aa401a5b", 0.6, 3);
    zm_utility::register_slowdown(#"hash_6c580f93aa40248d", 0.6, 5);
    zm_utility::register_slowdown(#"hash_59b633ea4aeff841", 0.6, 0.5);
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 0, eflags: 0x0
// Checksum 0x51e6ad26, Offset: 0x8c0
// Size: 0x7c
function on_connect() {
    self thread function_8b5fe69();
    self thread function_629d3329();
    self thread function_c723f37f();
    self thread function_750ca7f7();
    self thread function_ca2b7500();
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 0, eflags: 0x4
// Checksum 0x457dc7bf, Offset: 0x948
// Size: 0x3f0
function private function_c723f37f() {
    self endon(#"disconnect");
    while (true) {
        waitresult = self waittill(#"weapon_change");
        wpn_cur = waitresult.weapon;
        wpn_prev = waitresult.last_weapon;
        if (wpn_prev == level.hero_weapon[#"scepter"][0] || wpn_prev == level.hero_weapon[#"scepter"][1] || wpn_prev == level.hero_weapon[#"scepter"][2]) {
            self thread scepter_rumble(1);
            self clientfield::set("skull_turret_beam_fire", 0);
            self clientfield::set("scepter_beam_flash", 0);
            self notify(#"stop_damage");
        }
        if (wpn_cur == level.hero_weapon[#"scepter"][0]) {
            zm_hero_weapon::show_hint(wpn_cur, #"hash_7ebea2becf0c1aee");
            self thread function_79250c27(wpn_cur, 1);
            self thread function_7023a787(wpn_cur);
            self thread function_7023a787(wpn_cur, "weapon_melee");
            playrumbleonposition("grenade_rumble", self.origin);
            continue;
        }
        if (wpn_cur == level.hero_weapon[#"scepter"][1]) {
            zm_hero_weapon::show_hint(wpn_cur, #"hash_7ebea2becf0c1aee");
            self thread function_79250c27(wpn_cur, 2);
            self thread function_7023a787(wpn_cur);
            self thread function_7023a787(wpn_cur, "weapon_melee");
            playrumbleonposition("grenade_rumble", self.origin);
            continue;
        }
        if (wpn_cur == level.hero_weapon[#"scepter"][2]) {
            if (!self gamepadusedlast()) {
                self zm_hero_weapon::show_hint(wpn_cur, #"hash_5ba4f6bd62a74330");
            } else {
                self zm_hero_weapon::show_hint(wpn_cur, #"hash_57c3251d6df56d4");
            }
            self.var_292c2095 = wpn_prev;
            self thread function_79250c27(wpn_cur, 3);
            self thread function_7023a787(wpn_cur);
            self thread function_8db9f298(wpn_cur);
            playrumbleonposition("grenade_rumble", self.origin);
            self thread function_28e4f6c8(wpn_cur);
        }
    }
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 0, eflags: 0x4
// Checksum 0xf904efa, Offset: 0xd40
// Size: 0xe8
function private function_750ca7f7() {
    self endon(#"disconnect");
    while (true) {
        waitresult = self waittill(#"hero_weapon_give");
        weapon_given = waitresult.weapon;
        if (weapon_given == level.hero_weapon[#"scepter"][1]) {
            self thread function_ef95f156("hero_scepter_lv2", 1);
            continue;
        }
        if (weapon_given == level.hero_weapon[#"scepter"][2]) {
            self thread function_ef95f156("hero_scepter_lv3", 1);
        }
    }
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 0, eflags: 0x4
// Checksum 0xe8964646, Offset: 0xe30
// Size: 0xd8
function private function_ca2b7500() {
    self endon(#"disconnect");
    while (true) {
        waitresult = self waittill(#"hero_weapon_take");
        weapon_taken = waitresult.weapon;
        if (weapon_taken == level.hero_weapon[#"scepter"][1]) {
            self thread function_ba21a4c5();
            continue;
        }
        if (weapon_taken == level.hero_weapon[#"scepter"][2]) {
            self thread function_ba21a4c5();
        }
    }
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 1, eflags: 0x4
// Checksum 0xec237f1a, Offset: 0xf10
// Size: 0x76
function private function_3d9803ce(var_e34146dc) {
    if (var_e34146dc == "hero_weapon_power_off") {
        self clientfield::set("skull_turret_beam_fire", 0);
        self clientfield::set("scepter_beam_flash", 0);
        self.var_9adfaccf = undefined;
        self notify(#"stop_damage");
    }
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 2, eflags: 0x4
// Checksum 0xda34cacb, Offset: 0xf90
// Size: 0x19a
function private function_79250c27(w_curr, n_lvl) {
    self endoncallback(&function_3d9803ce, #"weapon_change", #"bled_out", #"disconnect", #"hero_weapon_power_off");
    while (true) {
        self waittill(#"weapon_melee_power");
        self clientfield::set("skull_turret_beam_fire", n_lvl);
        self clientfield::set("scepter_beam_flash", n_lvl);
        self.var_9adfaccf = 1;
        self thread function_4b4f81d3(w_curr);
        do {
            waitframe(1);
        } while (zm_utility::is_player_valid(self) && self attackbuttonpressed() && !self fragbuttonpressed());
        self clientfield::set("skull_turret_beam_fire", 0);
        self clientfield::set("scepter_beam_flash", 0);
        self.var_9adfaccf = undefined;
        self notify(#"stop_damage");
    }
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 2, eflags: 0x4
// Checksum 0x6ee3dac1, Offset: 0x1138
// Size: 0xb8
function private function_7023a787(weapon, var_bb956a97 = "weapon_melee_power_left") {
    self endon(#"weapon_change", #"bled_out", #"disconnect");
    while (true) {
        self waittill(var_bb956a97);
        if (zm_trial_restrict_loadout::is_active()) {
            self zm_trial_util::function_49b6503a();
            continue;
        }
        weapon thread function_f84c9b2e(self);
    }
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 2, eflags: 0x4
// Checksum 0xccbab8f9, Offset: 0x11f8
// Size: 0xba
function private function_ef95f156(str_level, b_postfx = 0) {
    if (b_postfx) {
        self clientfield::increment_to_player("hero_scepter_vigor_postfx");
    }
    self.var_6c6628c6 = 1;
    self notify(#"hash_11d4cfae418fcfe1");
    switch (str_level) {
    case #"hero_scepter_lv3":
        self.var_307a0e18 = 35;
        break;
    default:
        self.var_307a0e18 = 30;
        break;
    }
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 0, eflags: 0x4
// Checksum 0xf8d8baa7, Offset: 0x12c0
// Size: 0x16
function private function_ba21a4c5() {
    level.var_307a0e18 = undefined;
    self.var_6c6628c6 = undefined;
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 1, eflags: 0x4
// Checksum 0x66a14523, Offset: 0x12e0
// Size: 0x90
function private function_8db9f298(weapon) {
    self endon(#"weapon_change", #"disconnect", #"bled_out");
    while (true) {
        s_result = self waittill(#"weapon_melee");
        if (s_result.weapon == weapon) {
            self thread function_c06812e7(weapon);
        }
    }
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 1, eflags: 0x4
// Checksum 0xc1da1e0d, Offset: 0x1378
// Size: 0x20
function private blood_death_fx(var_d98455ab) {
    if (self.archetype == "zombie") {
    }
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 2, eflags: 0x0
// Checksum 0xc84d0e4f, Offset: 0x13a0
// Size: 0x7c
function function_5fe784f7(e_target, weapon = level.weaponnone) {
    if (isactor(e_target)) {
        self chop_actor(e_target, weapon);
        return;
    }
    self function_513ed8b2(e_target, weapon);
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 2, eflags: 0x0
// Checksum 0xced0e6fc, Offset: 0x1428
// Size: 0x214
function chop_actor(e_target, weapon = level.weaponnone) {
    self endon(#"weapon_change", #"bled_out", #"disconnect");
    if (!isalive(e_target)) {
        return;
    }
    switch (e_target.var_29ed62b2) {
    case #"popcorn":
    case #"basic":
        n_damage = e_target.health;
        break;
    case #"heavy":
        n_damage = int(e_target.maxhealth * 0.25);
        break;
    case #"miniboss":
        n_damage = int(e_target.maxhealth * 0.15);
        break;
    case #"boss":
        n_damage = 3000;
        break;
    }
    if (n_damage >= e_target.health) {
        e_target.ignoremelee = 1;
    }
    e_target thread zm_hero_weapon::function_f53ff9();
    [[ level.var_3c46c627 ]]->waitinqueue(e_target);
    e_target dodamage(n_damage, self.origin, self, self, "none", "MOD_MELEE", 0, weapon);
    e_target blood_death_fx();
    util::wait_network_frame();
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 2, eflags: 0x0
// Checksum 0x2f778493, Offset: 0x1648
// Size: 0x5c
function function_513ed8b2(e_target, weapon) {
    e_target dodamage(3000, self.origin, self, self, "none", "MOD_UNKNOWN", 0, weapon);
    util::wait_network_frame();
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 1, eflags: 0x0
// Checksum 0x155acf75, Offset: 0x16b0
// Size: 0x2ce
function melee_zombies(weapon = level.weaponnone) {
    view_pos = self getweaponmuzzlepoint();
    forward_view_angles = self getweaponforwarddir();
    var_cb905078 = 130 * 130;
    self clientfield::increment("zombie_scepter_melee");
    a_e_targets = zm_hero_weapon::function_765137a1();
    var_40aba8c5 = 0;
    foreach (e_target in a_e_targets) {
        if (!isdefined(e_target) || !isalive(e_target)) {
            continue;
        }
        test_origin = e_target getcentroid();
        dist_sq = distancesquared(view_pos, test_origin);
        dist_to_check = var_cb905078;
        if (dist_sq > dist_to_check) {
            continue;
        }
        normal = vectornormalize(test_origin - view_pos);
        dot = vectordot(forward_view_angles, normal);
        if (dot <= 0) {
            continue;
        }
        if (0 == e_target damageconetrace(view_pos, self)) {
            continue;
        }
        e_target.chopped = 1;
        if (!var_40aba8c5) {
            self clientfield::increment("zombie_scepter_melee_impact");
            var_40aba8c5 = 1;
        }
        if (isdefined(e_target.var_aa8a8a15)) {
            self thread [[ e_target.var_aa8a8a15 ]](e_target, self, weapon);
        } else {
            self thread scepter_rumble(3);
            self thread function_5fe784f7(e_target, weapon);
        }
        waitframe(1);
    }
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 1, eflags: 0x0
// Checksum 0x227a47de, Offset: 0x1988
// Size: 0x3c
function function_f84c9b2e(player) {
    player thread scepter_rumble(2);
    player thread melee_zombies(self);
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 2, eflags: 0x0
// Checksum 0xda620dfb, Offset: 0x19d0
// Size: 0x60
function reflect_shot(d, n) {
    perp = 2 * vectordot(d, n);
    var_e47d2859 = d - perp * n;
    return var_e47d2859;
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 1, eflags: 0x0
// Checksum 0x4adc8138, Offset: 0x1a38
// Size: 0x5bc
function function_4b4f81d3(w_curr) {
    self endon(#"stop_damage");
    switch (w_curr.name) {
    case #"hero_scepter_lv2":
        n_base_damage = 150;
        var_f2389f41 = 0.07;
        break;
    case #"hero_scepter_lv3":
        n_base_damage = 200;
        var_f2389f41 = 0.1;
        break;
    default:
        n_base_damage = 100;
        var_f2389f41 = 0.05;
        break;
    }
    self thread function_ba4ea65();
    while (true) {
        var_c18b4417 = 0;
        v_position = self getweaponmuzzlepoint();
        v_forward = self getweaponforwarddir();
        a_trace = beamtrace(v_position, v_position + v_forward * 20000, 1, self);
        var_93f33598 = a_trace[#"position"];
        /#
            function_cd048702(v_position, var_93f33598, (1, 1, 0));
            render_debug_sphere(v_position, (1, 1, 0));
            render_debug_sphere(var_93f33598, (1, 0, 0));
        #/
        if (isdefined(a_trace[#"entity"])) {
            e_last_target = a_trace[#"entity"];
            if (isdefined(e_last_target.var_29ed62b2) && e_last_target.team !== #"allies") {
                if (zm_trial_restrict_loadout::is_active()) {
                    self zm_trial_util::function_49b6503a();
                    return;
                }
                if (!isdefined(e_last_target.maxhealth)) {
                    e_last_target.maxhealth = e_last_target.health;
                }
                switch (e_last_target.var_29ed62b2) {
                case #"heavy":
                case #"miniboss":
                    e_last_target thread function_41ecbdf9(3);
                    n_damage = e_last_target.maxhealth * 0.02;
                    break;
                case #"boss":
                    n_damage = 100;
                    break;
                case #"popcorn":
                    n_damage = e_last_target.health + 100;
                    break;
                default:
                    n_percent_health = var_f2389f41 * e_last_target.health;
                    n_damage = max(n_percent_health, n_base_damage);
                    if (isactor(e_last_target) && !(isdefined(e_last_target.var_34ee01f) && e_last_target.var_34ee01f) && !zm_trial_restrict_loadout::is_active()) {
                        e_last_target.var_316424bf = 1;
                        e_last_target thread function_6c2485bd(5, self);
                    }
                    break;
                }
                self scepter_rumble(6);
                e_last_target dodamage(int(n_damage), var_93f33598, self, self);
            } else if (isplayer(e_last_target)) {
                e_last_target thread function_21d9cc29(self);
            }
        } else {
            var_c18b4417 = 0;
            switch (a_trace[#"surfacetype"]) {
            case #"glasscar":
            case #"rock":
            case #"metal":
            case #"metalcar":
            case #"glass":
                var_c18b4417 = 1;
                var_9449eaa2 = "reflective_geo";
                break;
            }
        }
        e_last_target = undefined;
        waitframe(1);
        if (isdefined(level.var_d9e9a35f)) {
            level notify(#"hero_weapon_hit", {#player:self, #e_entity:a_trace[#"entity"], #var_3657beb7:self.currentweapon, #v_position:a_trace[#"position"]});
        }
    }
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 0, eflags: 0x0
// Checksum 0x3666e4f2, Offset: 0x2000
// Size: 0x68
function function_ba4ea65() {
    self endon(#"disconnect", #"laststand", #"stop_damage");
    while (true) {
        self thread scepter_rumble(5);
        wait 0.5;
    }
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 0, eflags: 0x0
// Checksum 0x30829778, Offset: 0x2070
// Size: 0xb6
function function_8b5fe69() {
    if (!isdefined(self.var_f8dc72b7)) {
        self.var_f8dc72b7 = [];
    }
    s_revive_override = self zm_laststand::register_revive_override(&function_73277c01);
    if (!isdefined(self.var_f8dc72b7)) {
        self.var_f8dc72b7 = [];
    } else if (!isarray(self.var_f8dc72b7)) {
        self.var_f8dc72b7 = array(self.var_f8dc72b7);
    }
    self.var_f8dc72b7[self.var_f8dc72b7.size] = s_revive_override;
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 1, eflags: 0x0
// Checksum 0x58ebc574, Offset: 0x2130
// Size: 0x84
function reset_override(s_params) {
    if (self != level) {
        if (isdefined(s_params)) {
            e_revivee = s_params.e_revivee;
        } else {
            e_revivee = self;
        }
        e_revivee.get_revive_time = undefined;
        e_revivee.var_471b53c6 = undefined;
        e_revivee.var_f60f5bef = undefined;
        e_revivee clientfield::set("zombie_scepter_revive", 0);
    }
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 1, eflags: 0x0
// Checksum 0x39a54bd3, Offset: 0x21c0
// Size: 0x188
function function_b47325a7(s_params) {
    foreach (player in level.players) {
        player.n_level = player clientfield::get("scepter_beam_flash");
        if (player.n_level) {
            player clientfield::set("scepter_beam_flash", 0);
        }
    }
    waitframe(1);
    foreach (player in level.players) {
        if (isdefined(player.var_9adfaccf) && player.var_9adfaccf && zm_utility::is_player_valid(player)) {
            player clientfield::set("scepter_beam_flash", player.n_level);
        }
    }
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 1, eflags: 0x0
// Checksum 0xbc8fa7c6, Offset: 0x2350
// Size: 0x192
function function_73277c01(e_revivee) {
    if (!isdefined(e_revivee.revivetrigger)) {
        return false;
    }
    if (!isalive(self)) {
        return false;
    }
    if (self laststand::player_is_in_laststand() && !isdefined(self.var_e916a9ce)) {
        return false;
    }
    if (self.team != e_revivee.team) {
        return false;
    }
    if (isdefined(self.is_zombie) && self.is_zombie) {
        return false;
    }
    if (isdefined(level.can_revive_use_depthinwater_test) && level.can_revive_use_depthinwater_test && e_revivee depthinwater() > 10) {
        return true;
    }
    if (isdefined(level.can_revive) && ![[ level.can_revive ]](e_revivee)) {
        return false;
    }
    if (isdefined(level.var_ae6ced2b) && ![[ level.var_ae6ced2b ]](e_revivee)) {
        return false;
    }
    if (e_revivee zm_player::in_kill_brush() || !e_revivee zm_player::in_enabled_playable_area()) {
        return false;
    }
    if (e_revivee.var_471b53c6 === self) {
        return true;
    }
    return false;
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 1, eflags: 0x0
// Checksum 0x7e04c585, Offset: 0x24f0
// Size: 0x116
function function_21d9cc29(e_reviver) {
    self notify(#"hash_5c58f7b140ce445d");
    self endon(#"hash_5c58f7b140ce445d", #"disconnect");
    if (self laststand::player_is_in_laststand()) {
        self function_c1066647(e_reviver);
    } else {
        self.var_f60f5bef = 1;
        if (self.health < self.var_63f2cd6e) {
            self.health += 5;
            math::clamp(self.health, 1, self.var_63f2cd6e);
            self clientfield::increment("zombie_scepter_heal", 1);
            e_reviver.var_74f06e59 += 1;
        }
    }
    waitframe(1);
    self.var_f60f5bef = undefined;
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 1, eflags: 0x0
// Checksum 0xbdd2b6ff, Offset: 0x2610
// Size: 0x74
function function_c1066647(e_reviver) {
    if (!isdefined(self.var_471b53c6)) {
        e_reviver.var_74f06e59 += 100;
        self.get_revive_time = &override_revive_time;
        self.var_471b53c6 = e_reviver;
        self clientfield::set("zombie_scepter_revive", 1);
    }
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 1, eflags: 0x0
// Checksum 0xa516cbb9, Offset: 0x2690
// Size: 0x62
function override_revive_time(e_revivee) {
    n_time = 3;
    if (self hasperk(#"specialty_quickrevive")) {
        n_time /= 4;
    } else {
        n_time /= 2;
    }
    return n_time;
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 1, eflags: 0x0
// Checksum 0xf7ae0ee3, Offset: 0x2700
// Size: 0x136
function function_41ecbdf9(n_time = 5) {
    self notify(#"hash_3c2776b4262d3359");
    self endon(#"hash_3c2776b4262d3359", #"death");
    if (isdefined(self.aat_turned) && self.aat_turned) {
        return;
    }
    self.var_a2624396 = 1;
    if (n_time == 5) {
        self thread zm_utility::function_447d3917(#"hash_6c580f93aa40248d");
    } else {
        self thread zm_utility::function_447d3917(#"hash_6c580993aa401a5b");
    }
    self clientfield::set("zombie_scepter_stun", 1);
    wait n_time;
    if (!(isdefined(self.var_dac2dca9) && self.var_dac2dca9)) {
        self clientfield::set("zombie_scepter_stun", 0);
    }
    self.var_a2624396 = 0;
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 2, eflags: 0x0
// Checksum 0x7c976eaa, Offset: 0x2840
// Size: 0x1c6
function function_6c2485bd(n_time = 5, e_attacker) {
    self endon(#"hash_6b85fa3a80afb815", #"death");
    if (isdefined(self.aat_turned) && self.aat_turned) {
        return;
    }
    if (isdefined(self.var_34ee01f) && self.var_34ee01f) {
        return;
    }
    n_damage = ceil(self.maxhealth / n_time * 2 / 0.5);
    self.var_34ee01f = 1;
    if (n_time == 5) {
        self thread zm_utility::function_447d3917(#"hash_6c580f93aa40248d");
    } else {
        self thread zm_utility::function_447d3917(#"hash_6c580993aa401a5b");
    }
    self clientfield::set("zombie_scepter_stun", 1);
    for (x = 0; x < n_time / 0.5; x++) {
        wait 0.5;
        self dodamage(n_damage, self.origin, e_attacker, e_attacker);
    }
    self clientfield::set("zombie_scepter_stun", 0);
    self.var_34ee01f = 0;
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 0, eflags: 0x4
// Checksum 0xc8cec93d, Offset: 0x2a10
// Size: 0x18c
function private function_629d3329() {
    self endon(#"bled_out", #"death", #"beacon_expired");
    w_beacon = getweapon("hero_scepter_lv3");
    self function_96660e47(0);
    self.var_d8464718 = 0;
    self.disable_hero_power_charging = 0;
    self.var_544e4e53 = 0;
    self thread reset_after_bleeding_out();
    do {
        s_waitresult = self waittill(#"hash_4078956b159dd0f3");
    } while (s_waitresult.weapon != w_beacon);
    if (isdefined(self.var_5f9beef)) {
        self gadgetpowerset(self gadgetgetslot(w_beacon), self.var_5f9beef);
        self.saved_spike_power = undefined;
    } else {
        self gadgetpowerset(self gadgetgetslot(w_beacon), 100);
    }
    self.var_938309ad = undefined;
    self thread weapon_drop_watcher();
    self thread weapon_change_watcher();
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 0, eflags: 0x0
// Checksum 0x90765cb7, Offset: 0x2ba8
// Size: 0x80
function weapon_drop_watcher() {
    self endon(#"disconnect");
    while (true) {
        s_waitresult = self waittill(#"weapon_switch_started");
        if (zm_loadout::is_hero_weapon(s_waitresult.w_current)) {
            self setweaponammoclip(s_waitresult.w_current, 0);
        }
    }
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 0, eflags: 0x0
// Checksum 0xf38e2ed5, Offset: 0x2c30
// Size: 0x7e
function weapon_change_watcher() {
    self endon(#"disconnect");
    while (true) {
        s_waitresult = self waittill(#"weapon_change");
        if (isdefined(s_waitresult.w_previous) && zm_loadout::is_hero_weapon(s_waitresult.w_current)) {
            self.var_292c2095 = s_waitresult.w_previous;
        }
    }
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 0, eflags: 0x0
// Checksum 0x166814e0, Offset: 0x2cb8
// Size: 0x1b4
function reset_after_bleeding_out() {
    self endon(#"disconnect");
    w_beacon = getweapon("hero_scepter_lv3");
    if (isdefined(self.var_b4285bc3) && self.var_b4285bc3) {
        util::wait_network_frame();
        self zm_weapons::weapon_give(w_beacon, 0, 1);
        self function_96660e47(2);
    }
    self waittill(#"bled_out");
    if (self hasweapon(w_beacon)) {
        self.var_b4285bc3 = 1;
        self.var_d8fa01df = self gadgetpowerget(self gadgetgetslot(w_beacon));
        if (self.var_d8fa01df >= 100) {
            self.var_d8fa01df = undefined;
        }
        self.var_cbd03a5d[#"hero_scepter_lv3"] = self getweaponammoclip(w_beacon);
    }
    if (isdefined(self.var_938309ad)) {
        zm_unitrigger::unregister_unitrigger(self.var_938309ad);
        self.var_938309ad = undefined;
    }
    self waittill(#"spawned_player");
    self thread function_629d3329();
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 0, eflags: 0x0
// Checksum 0x5d773c44, Offset: 0x2e78
// Size: 0x4e
function function_d4a26eb6() {
    if (isdefined(level.var_ed1b24b8)) {
        return self [[ level.var_ed1b24b8 ]]();
    } else if (ispointonnavmesh(self.origin, self)) {
        return 1;
    }
    return 0;
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 1, eflags: 0x0
// Checksum 0xefdc3d67, Offset: 0x2ed0
// Size: 0x37e
function function_c06812e7(w_beacon) {
    self endoncallback(&function_5338ca27, #"disconnect");
    waitframe(14);
    self thread scepter_rumble(4);
    waitframe(1);
    if (self function_d4a26eb6()) {
        v_forward = anglestoforward(self.angles);
        v_spawn_pos = self.origin + (0, 0, 32);
        a_trace = physicstraceex(v_spawn_pos, v_spawn_pos + v_forward * 24, (-16, -16, -16), (16, 16, 16), self);
        v_spawn_pos += v_forward * a_trace[#"fraction"] * 24;
        var_226a15c3 = util::ground_position(v_spawn_pos, 1000, 12);
    } else {
        var_226a15c3 = self.origin + (0, 0, 12);
    }
    playrumbleonposition("grenade_rumble", self.origin);
    self function_27a96538(var_226a15c3);
    self beacon_fx_on(var_226a15c3);
    self ability_player::function_184edba5(w_beacon);
    self thread beacon_loop(w_beacon, self.var_226a15c3);
    self.var_e916a9ce = self.mdl_beacon;
    self.var_d8464718 = 1;
    self.var_226a15c3 = var_226a15c3;
    self notify(#"hash_45abc00ca765716");
    var_918f8afe = self gadgetpowerget(level.var_97b2d700);
    if (var_918f8afe > 5) {
        self thread function_68461932(w_beacon);
        zm_utility::function_29616508();
        self waittill(#"beacon_off", #"beacon_retrieved", #"bled_out", #"destroy_beacon", #"disconnect");
        zm_utility::function_6c8e0750();
    }
    self thread function_9c3eae90();
    self notify(#"beacon_retrieved");
    self thread function_ebb8a8ac();
    if (isdefined(self)) {
        self ability_player::function_281eba9f(w_beacon);
        self.var_e916a9ce = undefined;
        self.var_d8464718 = 0;
        self.disable_hero_power_charging = 0;
        self notify(#"destroy_beacon");
    }
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 1, eflags: 0x0
// Checksum 0xeb101c15, Offset: 0x3258
// Size: 0x34
function function_5338ca27(var_e34146dc) {
    if (isdefined(self.var_d8464718) && self.var_d8464718) {
        zm_utility::function_6c8e0750();
    }
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 1, eflags: 0x0
// Checksum 0xb0082669, Offset: 0x3298
// Size: 0xd2
function function_68461932(w_beacon) {
    self endoncallback(&function_67073e38, #"beacon_retrieved", #"disconnect");
    self.var_f5b9f476 = 1;
    while (true) {
        slot = self gadgetgetslot(w_beacon);
        n_power = self gadgetpowerget(slot);
        if (n_power <= 0) {
            break;
        }
        waitframe(1);
    }
    self notify(#"beacon_off");
    self.var_f5b9f476 = 0;
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 1, eflags: 0x0
// Checksum 0x6dba3ee3, Offset: 0x3378
// Size: 0x1e
function function_67073e38(_hash) {
    if (isdefined(self)) {
        self.var_f5b9f476 = 0;
    }
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 1, eflags: 0x0
// Checksum 0xcbbb04c1, Offset: 0x33a0
// Size: 0x114
function function_27a96538(var_226a15c3) {
    if (!isdefined(self.mdl_beacon)) {
        self.mdl_beacon = util::spawn_model("p8_fxanim_zm_zod_staff_ra_mod", var_226a15c3);
    }
    self playsound(#"hash_178614dae860a551");
    self.mdl_beacon.origin = var_226a15c3;
    self.mdl_beacon notsolid();
    self.mdl_beacon show();
    waitframe(1);
    if (!zm_trial_restrict_loadout::is_active()) {
        self.mdl_beacon thread beacon_smash(self);
    }
    self.mdl_beacon thread function_d958af69();
    if (isdefined(level.var_8e755bbc)) {
        [[ level.var_8e755bbc ]](self.mdl_beacon);
    }
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 1, eflags: 0x0
// Checksum 0x5667431e, Offset: 0x34c0
// Size: 0x2a6
function beacon_smash(player) {
    a_zombies = getaiteamarray(level.zombie_team);
    var_7c6c0ae4 = 57600;
    foreach (zombie in a_zombies) {
        if (zombie check_for_range_and_los(self.origin, 96, var_7c6c0ae4)) {
            switch (zombie.var_29ed62b2) {
            case #"basic":
                zombie dodamage(zombie.health, self.origin, player, player, "none", "MOD_UNKNOWN", 0, level.hero_weapon[#"scepter"][2]);
                n_random_x = randomfloatrange(-3, 3);
                n_random_y = randomfloatrange(-3, 3);
                v_fling = 200 * vectornormalize(zombie.origin - self.origin + (n_random_x, n_random_y, 100));
                zombie zm_utility::function_620780d9(v_fling, player);
                break;
            case #"popcorn":
                zombie dodamage(zombie.health, self.origin, player, player, "none", "MOD_UNKNOWN", 0, level.hero_weapon[#"scepter"][2]);
                break;
            case #"heavy":
            case #"miniboss":
                zombie thread function_41ecbdf9(3);
                break;
            }
        }
    }
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 1, eflags: 0x0
// Checksum 0x24ec8bd1, Offset: 0x3770
// Size: 0xa4
function beacon_fx_on(v_spawn_pos) {
    if (!isdefined(self.var_5ef33dda)) {
        self.var_5ef33dda = util::spawn_model("tag_origin", v_spawn_pos);
    }
    self.var_5ef33dda.origin = v_spawn_pos;
    self.var_5ef33dda show();
    waitframe(1);
    self.var_5ef33dda clientfield::set("beacon_fx", 1);
    self thread beacon_rumble();
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 0, eflags: 0x0
// Checksum 0x145efdb3, Offset: 0x3820
// Size: 0x46
function beacon_fx_off() {
    if (!isdefined(self.var_5ef33dda)) {
        return;
    }
    self.var_5ef33dda clientfield::set("beacon_fx", 0);
    self notify(#"beacon_fx_off");
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 0, eflags: 0x0
// Checksum 0xa056c32e, Offset: 0x3870
// Size: 0x50
function beacon_rumble() {
    self endon(#"beacon_fx_off");
    while (isdefined(self.var_5ef33dda)) {
        self.var_5ef33dda playrumbleonentity("zm_weap_scepter_planted_idle_rumble");
        wait 0.5;
    }
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 0, eflags: 0x0
// Checksum 0x70d2c5ec, Offset: 0x38c8
// Size: 0x15c
function function_9c3eae90() {
    var_c5b59f97 = self.var_c5b59f97;
    mdl_beacon = self.mdl_beacon;
    if (isdefined(var_c5b59f97)) {
        var_c5b59f97 ghost();
        if (!isdefined(self)) {
            var_c5b59f97 delete();
        }
    }
    foreach (e_player in level.players) {
        if (isdefined(e_player.var_65b947e7)) {
            arrayremovevalue(e_player.var_65b947e7, mdl_beacon);
        }
    }
    if (!isdefined(mdl_beacon)) {
        return;
    }
    mdl_beacon thread scene::stop("p8_fxanim_zm_zod_staff_ra_bundle");
    mdl_beacon delete();
    if (!isdefined(self)) {
        return;
    }
    self function_ef95f156("hero_scepter_lv3");
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 0, eflags: 0x0
// Checksum 0x9babb753, Offset: 0x3a30
// Size: 0x24
function function_d958af69() {
    self thread scene::play("p8_fxanim_zm_zod_staff_ra_bundle", self);
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 2, eflags: 0x0
// Checksum 0x96aba366, Offset: 0x3a60
// Size: 0x16c
function beacon_loop(w_beacon, var_226a15c3) {
    self endon(#"beacon_retrieved", #"death", #"bled_out");
    var_7c6c0ae4 = 57600;
    var_222d0f15 = self.var_5ef33dda.origin;
    while (true) {
        slot = self gadgetgetslot(w_beacon);
        if (self gadgetpowerget(slot) > 0) {
            if (!zm_trial_restrict_loadout::is_active()) {
                self thread function_c73d85e0(var_7c6c0ae4, var_222d0f15, 0.25);
            }
            array::thread_all(level.players, &function_ecf462a4, self);
        } else if (true) {
            self function_ebb8a8ac();
            util::wait_network_frame();
            return;
        }
        wait 0.25;
    }
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 0, eflags: 0x0
// Checksum 0x31a781a3, Offset: 0x3bd8
// Size: 0x44
function function_ebb8a8ac() {
    self beacon_fx_off();
    is_gravity_trap_fx_on = 0;
    self function_96660e47(4);
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 1, eflags: 0x0
// Checksum 0x973fb29c, Offset: 0x3c28
// Size: 0x46
function function_adb37370(ai_enemy) {
    b_callback_result = 1;
    if (isdefined(level.var_dd547712)) {
        b_callback_result = [[ level.var_dd547712 ]](ai_enemy);
    }
    return b_callback_result;
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 3, eflags: 0x0
// Checksum 0x64ce32a6, Offset: 0x3c78
// Size: 0xf8
function function_c73d85e0(var_7c6c0ae4, var_222d0f15, n_loop_time) {
    a_zombies = getaiteamarray(level.zombie_team);
    a_zombies = array::filter(a_zombies, 0, &function_adb37370);
    foreach (zombie in a_zombies) {
        zombie beacon_check(self, var_7c6c0ae4, var_222d0f15, n_loop_time);
        util::wait_network_frame();
    }
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 4, eflags: 0x0
// Checksum 0xcba502e, Offset: 0x3d78
// Size: 0x22c
function beacon_check(player, var_7c6c0ae4, var_222d0f15, n_loop_time) {
    player endon(#"beacon_retrieved", #"bled_out", #"death");
    assert(isdefined(player));
    if (!isalive(self)) {
        return;
    }
    if (self check_for_range_and_los(var_222d0f15, undefined, var_7c6c0ae4)) {
        self.var_84b69ea7 = 1;
        if (isalive(self)) {
            switch (self.var_29ed62b2) {
            case #"heavy":
            case #"miniboss":
                n_damage = self.maxhealth * 0.08 * n_loop_time;
                break;
            case #"boss":
                n_damage = 100;
                break;
            case #"popcorn":
                n_damage = self.health + 100;
                break;
            default:
                n_damage = ceil(self.maxhealth / 10 / n_loop_time);
                break;
            }
            self dodamage(n_damage, var_222d0f15, player, player, "none", "MOD_UNKNOWN", 0, level.hero_weapon[#"scepter"][2]);
            if (!(isdefined(self.var_dac2dca9) && self.var_dac2dca9)) {
                self thread function_bd61b349();
            }
        }
    }
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 1, eflags: 0x0
// Checksum 0xe69dc8ee, Offset: 0x3fb0
// Size: 0x64
function function_fd15667c(w_beacon) {
    self notify(#"hash_3367f146a3b7acb4");
    if (isdefined(self.var_d8464718) && self.var_d8464718) {
        self.disable_hero_power_charging = 1;
        self thread beacon_loop(w_beacon, self.var_226a15c3);
    }
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 3, eflags: 0x0
// Checksum 0xc8ae4664, Offset: 0x4020
// Size: 0xb2
function check_for_range_and_los(v_attack_source, n_allowed_z_diff, n_radius_sq) {
    if (isalive(self)) {
        n_z_diff = self.origin[2] - v_attack_source[2];
        if (!isdefined(n_allowed_z_diff) || abs(n_z_diff) < n_allowed_z_diff) {
            if (distancesquared(self.origin, v_attack_source) < n_radius_sq) {
                return true;
            }
        }
    }
    return false;
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 0, eflags: 0x0
// Checksum 0xa5b351a8, Offset: 0x40e0
// Size: 0xe6
function function_bd61b349() {
    self notify(#"hash_d2552753b77cbb5");
    self endon(#"hash_d2552753b77cbb5", #"death");
    if (isdefined(self.aat_turned) && self.aat_turned) {
        return;
    }
    self.var_dac2dca9 = 1;
    self thread zm_utility::function_447d3917(#"hash_59b633ea4aeff841");
    self clientfield::set("zombie_scepter_stun", 1);
    wait 0.4;
    if (!(isdefined(self.var_a2624396) && self.var_a2624396)) {
        self clientfield::set("zombie_scepter_stun", 0);
    }
    self.var_dac2dca9 = 0;
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 1, eflags: 0x0
// Checksum 0x9735752f, Offset: 0x41d0
// Size: 0x224
function function_ecf462a4(e_player) {
    e_player endon(#"beacon_retrieved", #"bled_out", #"death");
    assert(isdefined(e_player));
    var_7c6c0ae4 = 57600;
    var_222d0f15 = e_player.var_5ef33dda.origin;
    if (!isalive(self)) {
        return;
    }
    if (self check_for_range_and_los(var_222d0f15, undefined, var_7c6c0ae4)) {
        self thread function_e40127f3();
        if (self laststand::player_is_in_laststand()) {
            self function_c1066647(e_player);
        }
        if (!isdefined(self.var_65b947e7)) {
            self.var_65b947e7 = [];
        } else if (!isarray(self.var_65b947e7)) {
            self.var_65b947e7 = array(self.var_65b947e7);
        }
        if (!isinarray(self.var_65b947e7, e_player.mdl_beacon)) {
            self.var_65b947e7[self.var_65b947e7.size] = e_player.mdl_beacon;
        }
        return;
    }
    if (isdefined(self.var_65b947e7) && isinarray(self.var_65b947e7, e_player.mdl_beacon)) {
        arrayremovevalue(self.var_65b947e7, e_player.mdl_beacon);
        self reset_override();
        self function_ba21a4c5();
    }
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 1, eflags: 0x0
// Checksum 0x159840fd, Offset: 0x4400
// Size: 0x36
function function_a473f0f0(perk) {
    self thread zm_perks::function_dde955e2(perk, &function_53926a5c);
    return false;
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 2, eflags: 0x0
// Checksum 0x5fceae5, Offset: 0x4440
// Size: 0x22
function function_53926a5c(e_reviver, var_471b53c6) {
    return function_94f5d25c();
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 0, eflags: 0x0
// Checksum 0xa7050348, Offset: 0x4470
// Size: 0x54
function function_e40127f3() {
    self notify(#"hash_11eb81b5eb1a8b4f");
    self endon(#"hash_11eb81b5eb1a8b4f", #"disconnect");
    self function_ef95f156("hero_scepter_lv2");
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 1, eflags: 0x0
// Checksum 0xe1053851, Offset: 0x44d0
// Size: 0x4c
function function_8d85bc18(e_attacker) {
    if (self clientfield::get("zombie_scepter_stun")) {
        self clientfield::set("zombie_scepter_stun", 0);
    }
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 0, eflags: 0x0
// Checksum 0xf58e047c, Offset: 0x4528
// Size: 0x1c
function on_player_disconnect() {
    self beacon_fx_off();
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 1, eflags: 0x0
// Checksum 0xd2fee964, Offset: 0x4550
// Size: 0x1a
function function_96660e47(var_72076622) {
    self.var_2c11d503 = var_72076622;
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 0, eflags: 0x0
// Checksum 0x7169153b, Offset: 0x4578
// Size: 0x1a
function function_94f5d25c() {
    return isdefined(self.var_65b947e7) && self.var_65b947e7.size;
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 2, eflags: 0x0
// Checksum 0x474ab5ec, Offset: 0x45a0
// Size: 0x6c
function render_debug_sphere(origin, color) {
    if (getdvarint(#"turret_debug_server", 0)) {
        /#
            sphere(origin, 2, color, 0.75, 1, 10, 100);
        #/
    }
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 3, eflags: 0x0
// Checksum 0x6fb9fcf2, Offset: 0x4618
// Size: 0x6c
function function_cd048702(origin1, origin2, color) {
    if (getdvarint(#"turret_debug_server", 0)) {
        /#
            line(origin1, origin2, color, 0.75, 1, 100);
        #/
    }
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 1, eflags: 0x0
// Checksum 0x2bc7f9fc, Offset: 0x4690
// Size: 0x16a
function scepter_rumble(var_b35c2422) {
    if (var_b35c2422) {
        switch (var_b35c2422) {
        case 1:
            self playrumbleonentity("zm_weap_special_activate_rumble");
            break;
        case 2:
            self clientfield::increment_to_player("scepter_rumble", 2);
            break;
        case 3:
            self playrumbleonentity("zm_weap_scepter_melee_hit_rumble");
            break;
        case 4:
            playrumbleonposition("zm_weap_scepter_plant_rumble", self.origin);
            break;
        case 5:
            self clientfield::increment_to_player("scepter_rumble", 5);
            break;
        case 6:
            self clientfield::increment_to_player("scepter_rumble", 6);
            break;
        }
    }
}

// Namespace zm_weap_scepter/zm_weap_scepter
// Params 1, eflags: 0x0
// Checksum 0x3273a1, Offset: 0x4808
// Size: 0xa4
function function_28e4f6c8(w_scepter) {
    self endon(#"weapon_change", #"disconnect", #"bled_out");
    s_result = self waittill(#"weapon_melee");
    if (s_result.weapon == w_scepter) {
        self thread zm_audio::create_and_play_dialog(#"hero_level_3", #"scepter");
    }
}

