#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\throttle_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_hero_weapon;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_utility;

#namespace zm_weap_chakram;

// Namespace zm_weap_chakram/zm_weap_chakram
// Params 0, eflags: 0x2
// Checksum 0xa855640d, Offset: 0x338
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_weap_chakram", &__init__, undefined, undefined);
}

// Namespace zm_weap_chakram/zm_weap_chakram
// Params 0, eflags: 0x0
// Checksum 0x9645972d, Offset: 0x380
// Size: 0xa6c
function __init__() {
    clientfield::register("actor", "zombie_slice_right", 1, 2, "counter");
    clientfield::register("actor", "zombie_slice_left", 1, 2, "counter");
    clientfield::register("allplayers", "chakram_melee_hit", 1, 1, "counter");
    clientfield::register("actor", "chakram_head_pop_fx", 1, 1, "int");
    clientfield::register("vehicle", "chakram_head_pop_fx", 1, 1, "int");
    clientfield::register("scriptmover", "chakram_throw_trail_fx", 1, 1, "int");
    clientfield::register("scriptmover", "chakram_throw_impact_fx", 1, 1, "int");
    clientfield::register("actor", "chakram_throw_special_impact_fx", 1, 1, "counter");
    clientfield::register("allplayers", "chakram_whirlwind_fx", 1, 1, "int");
    clientfield::register("actor", "chakram_whirlwind_shred_fx", 1, 1, "counter");
    clientfield::register("vehicle", "chakram_whirlwind_shred_fx", 1, 1, "counter");
    clientfield::register("toplayer", "chakram_speed_buff_postfx", 1, 1, "counter");
    clientfield::register("toplayer", "chakram_rumble", 1, 3, "counter");
    level.hero_weapon[#"chakram"][0] = getweapon(#"hero_chakram_lv1");
    level.hero_weapon[#"chakram"][1] = getweapon(#"hero_chakram_lv2");
    level.hero_weapon[#"chakram"][2] = getweapon(#"hero_chakram_lv3");
    if (!isdefined(level.hero_weapon_stats)) {
        level.hero_weapon_stats = [];
    }
    level.hero_weapon_stats[#"chakram"] = [];
    level.hero_weapon_stats[#"chakram"][#"delay_start"][0] = 0.25;
    level.hero_weapon_stats[#"chakram"][#"delay_start"][1] = 0.15;
    level.hero_weapon_stats[#"chakram"][#"delay_start"][2] = 0.1;
    level.hero_weapon_stats[#"chakram"][#"delay_end"][0] = 0.4;
    level.hero_weapon_stats[#"chakram"][#"delay_end"][1] = 0.25;
    level.hero_weapon_stats[#"chakram"][#"delay_end"][2] = 0.12;
    level.hero_weapon_stats[#"chakram"][#"kill_limit"][0] = 4;
    level.hero_weapon_stats[#"chakram"][#"kill_limit"][1] = 4;
    level.hero_weapon_stats[#"chakram"][#"kill_limit"][2] = 4;
    level.hero_weapon_stats[#"chakram"][#"max_range"][0] = 512;
    level.hero_weapon_stats[#"chakram"][#"max_range"][1] = 756;
    level.hero_weapon_stats[#"chakram"][#"max_range"][2] = 1024;
    level.hero_weapon_stats[#"chakram"][#"seek_range"][0] = 256;
    level.hero_weapon_stats[#"chakram"][#"seek_range"][1] = 384;
    level.hero_weapon_stats[#"chakram"][#"seek_range"][2] = 512;
    level.hero_weapon_stats[#"chakram"][#"travel_time"][0] = 0.4;
    level.hero_weapon_stats[#"chakram"][#"travel_time"][1] = 0.5;
    level.hero_weapon_stats[#"chakram"][#"travel_time"][2] = 0.7;
    level.hero_weapon_stats[#"chakram"][#"throw_model"][0] = "wpn_t8_zm_melee_chakram_lvl1_dw_projectile";
    level.hero_weapon_stats[#"chakram"][#"throw_model"][1] = "wpn_t8_zm_melee_chakram_lvl2_dw_projectile";
    level.hero_weapon_stats[#"chakram"][#"throw_model"][2] = "wpn_t8_zm_melee_chakram_lvl3_dw_projectile";
    zm_loadout::register_hero_weapon_for_level("hero_chakram_lv1");
    zm_loadout::register_hero_weapon_for_level("hero_chakram_lv2");
    zm_loadout::register_hero_weapon_for_level("hero_chakram_lv3");
    level.var_82787269 = 160;
    level.var_4456aa24 = level.var_82787269 * level.var_82787269;
    level.var_b45a0716 = [];
    if (!isdefined(level.var_b45a0716)) {
        level.var_b45a0716 = [];
    } else if (!isarray(level.var_b45a0716)) {
        level.var_b45a0716 = array(level.var_b45a0716);
    }
    level.var_b45a0716[level.var_b45a0716.size] = "minigun";
    level.var_78c1eedc = new throttle();
    [[ level.var_78c1eedc ]]->initialize(3, 0.1);
    callback::on_connect(&function_7f17bfe8);
    callback::add_weapon_fired(level.hero_weapon[#"chakram"][0].dualwieldweapon, &function_a205093e);
    callback::add_weapon_fired(level.hero_weapon[#"chakram"][1].dualwieldweapon, &function_a205093e);
    callback::add_weapon_fired(level.hero_weapon[#"chakram"][2].dualwieldweapon, &function_a205093e);
}

// Namespace zm_weap_chakram/zm_weap_chakram
// Params 0, eflags: 0x4
// Checksum 0xa26deab9, Offset: 0xdf8
// Size: 0x3b0
function private function_7f17bfe8() {
    self endon(#"disconnect");
    /#
        var_665b863a = 0;
        var_1d9ee269 = 0;
        var_521bdc8c = 0;
    #/
    while (true) {
        waitresult = self waittill(#"weapon_change");
        wpn_cur = waitresult.weapon;
        wpn_prev = waitresult.last_weapon;
        if (wpn_cur == level.hero_weapon[#"chakram"][0]) {
            self thread chakram_rumble(1);
            if (!self gamepadusedlast()) {
                self zm_hero_weapon::show_hint(wpn_cur, #"hash_327e81e6ede21cd5");
            } else {
                self zm_hero_weapon::show_hint(wpn_cur, #"hash_52e079a39f348e1b");
            }
            self thread function_bae711b0(wpn_cur);
            self thread function_6315014a(wpn_cur);
            continue;
        }
        if (wpn_cur == level.hero_weapon[#"chakram"][1]) {
            self thread chakram_rumble(1);
            if (!self gamepadusedlast()) {
                self zm_hero_weapon::show_hint(wpn_cur, #"hash_327e81e6ede21cd5");
            } else {
                self zm_hero_weapon::show_hint(wpn_cur, #"hash_52e079a39f348e1b");
            }
            self thread function_bae711b0(wpn_cur);
            self thread function_6315014a(wpn_cur);
            self thread function_baf27075(wpn_cur);
            continue;
        }
        if (wpn_cur == level.hero_weapon[#"chakram"][2]) {
            self thread chakram_rumble(1);
            if (!self gamepadusedlast()) {
                self zm_hero_weapon::show_hint(wpn_cur, #"hash_3c4637f13f09707");
            } else {
                self zm_hero_weapon::show_hint(wpn_cur, #"hash_34a417201bd40701");
            }
            self thread function_bae711b0(wpn_cur);
            self thread function_6315014a(wpn_cur);
            self thread function_baf27075(wpn_cur);
            self thread function_52650eae(wpn_cur);
            self thread function_786e5bd2(wpn_cur);
            self thread function_28e4f6c8(wpn_cur);
        }
    }
}

// Namespace zm_weap_chakram/zm_weap_chakram
// Params 1, eflags: 0x4
// Checksum 0x74202c3b, Offset: 0x11b0
// Size: 0xc8
function private function_bae711b0(weapon) {
    self endon(#"weapon_change");
    self endon(#"disconnect");
    self endon(#"bled_out");
    while (true) {
        if (weapon == level.hero_weapon[#"chakram"][2]) {
            self waittill(#"weapon_melee_power");
        } else {
            self waittill(#"weapon_melee_power", #"weapon_melee");
        }
        weapon thread function_122dcda0(self);
    }
}

// Namespace zm_weap_chakram/zm_weap_chakram
// Params 1, eflags: 0x4
// Checksum 0x7ebe137c, Offset: 0x1280
// Size: 0x74
function private blood_death_fx(var_d98455ab) {
    if (self.archetype === "zombie") {
        if (var_d98455ab) {
            self clientfield::increment("zombie_slice_left", 1);
            return;
        }
        self clientfield::increment("zombie_slice_right", 1);
    }
}

// Namespace zm_weap_chakram/zm_weap_chakram
// Params 3, eflags: 0x0
// Checksum 0x8afe3b09, Offset: 0x1300
// Size: 0x84
function function_5fe784f7(e_target, leftswing, weapon = level.weaponnone) {
    if (isactor(e_target)) {
        self thread chop_actor(e_target, leftswing, weapon);
        return;
    }
    self thread function_513ed8b2(e_target, weapon);
}

// Namespace zm_weap_chakram/zm_weap_chakram
// Params 3, eflags: 0x0
// Checksum 0xc67cc6f6, Offset: 0x1390
// Size: 0x244
function chop_actor(e_target, leftswing, weapon = level.weaponnone) {
    self endon(#"weapon_change", #"disconnect", #"bled_out");
    if (!isdefined(e_target) || !isalive(e_target)) {
        return;
    }
    switch (e_target.var_29ed62b2) {
    case #"popcorn":
    case #"basic":
        n_damage = e_target.health;
        break;
    case #"heavy":
        n_damage = int(e_target.maxhealth * 0.2);
        break;
    case #"miniboss":
        n_damage = int(e_target.maxhealth * 0.1);
        break;
    case #"boss":
        n_damage = 2500;
        break;
    }
    if (n_damage >= e_target.health) {
        e_target.ignoremelee = 1;
    }
    self thread function_a4988858();
    [[ level.var_78c1eedc ]]->waitinqueue(e_target);
    e_target thread zm_hero_weapon::function_f53ff9();
    e_target blood_death_fx(leftswing);
    e_target dodamage(n_damage, self.origin, self, self, "none", "MOD_MELEE", 0, weapon);
    util::wait_network_frame();
}

// Namespace zm_weap_chakram/zm_weap_chakram
// Params 2, eflags: 0x0
// Checksum 0x6109807f, Offset: 0x15e0
// Size: 0xbc
function function_513ed8b2(e_target, weapon) {
    self endon(#"weapon_change", #"disconnect", #"bled_out");
    util::wait_network_frame();
    self thread function_a4988858();
    e_target dodamage(2500, self.origin, self, self, "none", "MOD_MELEE", 0, weapon);
    util::wait_network_frame();
}

// Namespace zm_weap_chakram/zm_weap_chakram
// Params 0, eflags: 0x0
// Checksum 0x845d747c, Offset: 0x16a8
// Size: 0x64
function function_a4988858() {
    self endon(#"weapon_change", #"disconnect", #"bled_out");
    wait 0.1;
    self clientfield::increment("chakram_melee_hit", 1);
}

// Namespace zm_weap_chakram/zm_weap_chakram
// Params 3, eflags: 0x0
// Checksum 0x1a43c447, Offset: 0x1718
// Size: 0x318
function chop_zombies(first_time, leftswing, weapon = level.weaponnone) {
    view_pos = self getweaponmuzzlepoint();
    forward_view_angles = self getweaponforwarddir();
    zombie_list = getaiteamarray(level.zombie_team);
    a_e_targets = zm_hero_weapon::function_765137a1();
    foreach (e_target in a_e_targets) {
        if (!isdefined(e_target) || !isalive(e_target)) {
            continue;
        }
        if (first_time) {
            e_target.chopped = 0;
        } else if (isdefined(e_target.chopped) && e_target.chopped) {
            continue;
        }
        test_origin = e_target getcentroid();
        dist_sq = distancesquared(view_pos, test_origin);
        dist_to_check = level.var_4456aa24;
        if (dist_sq > dist_to_check) {
            continue;
        }
        normal = vectornormalize(test_origin - view_pos);
        dot = vectordot(forward_view_angles, normal);
        if (dot <= 0) {
            continue;
        }
        if (dist_sq <= 1600) {
            if (0 == e_target damageconetrace(view_pos, self, forward_view_angles)) {
                continue;
            }
        } else if (0 == e_target damageconetrace(view_pos, self, forward_view_angles, 25)) {
            continue;
        }
        e_target.chopped = 1;
        if (isdefined(e_target.chop_actor_cb)) {
            self thread [[ e_target.chop_actor_cb ]](e_target, self, weapon);
            continue;
        }
        self thread chakram_rumble(3);
        self thread function_5fe784f7(e_target, leftswing, weapon);
    }
}

// Namespace zm_weap_chakram/zm_weap_chakram
// Params 1, eflags: 0x0
// Checksum 0xbb51890, Offset: 0x1a38
// Size: 0x44
function function_122dcda0(player) {
    player thread chakram_rumble(4);
    player thread chop_zombies(1, 1, self);
}

// Namespace zm_weap_chakram/zm_weap_chakram
// Params 1, eflags: 0x0
// Checksum 0x431baab5, Offset: 0x1a88
// Size: 0x4c
function function_a205093e(weapon) {
    player = self;
    player thread chakram_rumble(5);
    weapon function_8c0a650(player);
}

// Namespace zm_weap_chakram/zm_weap_chakram
// Params 1, eflags: 0x4
// Checksum 0x3a5d8c08, Offset: 0x1ae0
// Size: 0x34
function private function_6315014a(weapon) {
    self setweaponammoclip(weapon.dualwieldweapon, 1);
}

// Namespace zm_weap_chakram/zm_weap_chakram
// Params 1, eflags: 0x4
// Checksum 0xd7ca4139, Offset: 0x1b20
// Size: 0x48e
function private function_8c0a650(player) {
    player.var_f5a65081 = 1;
    var_9da03331 = level.hero_weapon_stats[#"chakram"][#"delay_start"][player.var_4dcf5f7f];
    var_8d0a132a = level.hero_weapon_stats[#"chakram"][#"delay_end"][player.var_4dcf5f7f];
    var_626ea15f = level.hero_weapon_stats[#"chakram"][#"kill_limit"][player.var_4dcf5f7f];
    var_87e15a09 = level.hero_weapon_stats[#"chakram"][#"max_range"][player.var_4dcf5f7f];
    var_9751fed1 = level.hero_weapon_stats[#"chakram"][#"seek_range"][player.var_4dcf5f7f];
    wait var_9da03331;
    n_kills = 0;
    if (!isdefined(player.e_seeker)) {
        e_seeker = util::spawn_model(level.hero_weapon_stats[#"chakram"][#"throw_model"][player.var_4dcf5f7f], player getorigin() + (0, 0, 48));
        player.e_seeker = e_seeker;
        e_seeker.var_959f46dd = [];
        e_seeker.var_7295a672 = [];
    } else {
        e_seeker = player.e_seeker;
        e_seeker.var_959f46dd = [];
        e_seeker.var_7295a672 = [];
        e_seeker.origin = player getorigin() + (0, 0, 48);
        e_seeker setmodel(level.hero_weapon_stats[#"chakram"][#"throw_model"][player.var_4dcf5f7f]);
        e_seeker show();
    }
    player.var_809bd952 = 1;
    e_seeker clientfield::set("chakram_throw_trail_fx", 1);
    b_zombie_killed = player function_53ed50a8();
    if (isdefined(b_zombie_killed) && b_zombie_killed) {
        while (n_kills < var_626ea15f) {
            if (isdefined(b_zombie_killed) && b_zombie_killed) {
                n_kills++;
            }
            e_target = e_seeker function_dee5f345(e_seeker.origin, var_9751fed1);
            if (!isdefined(e_target)) {
                break;
            }
            b_zombie_killed = player function_a6674838(e_target);
            wait 0.1;
        }
    }
    player function_a6674838();
    player thread chakram_rumble(2);
    player notify(#"seeker_done");
    e_seeker clientfield::set("chakram_throw_trail_fx", 0);
    e_seeker hide();
    wait var_8d0a132a;
    player setweaponammoclip(player.slot_weapons[#"hero_weapon"], 1);
    player.var_809bd952 = 0;
    player.var_f5a65081 = undefined;
}

// Namespace zm_weap_chakram/zm_weap_chakram
// Params 0, eflags: 0x4
// Checksum 0x8ec8ffa1, Offset: 0x1fb8
// Size: 0x6fe
function private function_53ed50a8() {
    var_87e15a09 = level.hero_weapon_stats[#"chakram"][#"max_range"][self.var_4dcf5f7f];
    var_9751fed1 = level.hero_weapon_stats[#"chakram"][#"seek_range"][self.var_4dcf5f7f] / 1.5;
    var_39d5856d = level.hero_weapon_stats[#"chakram"][#"travel_time"][self.var_4dcf5f7f];
    v_start = self geteye();
    v_forward = self getweaponforwarddir();
    v_end = v_start + v_forward * var_87e15a09;
    a_trace = bullettrace(v_start, v_end, 0, self);
    if (distancesquared(v_start, v_end) > distancesquared(v_start, a_trace[#"position"])) {
        v_end = a_trace[#"position"];
        n_dist = distance(v_start, v_end);
        var_dd5d2ace = n_dist * var_39d5856d / var_87e15a09;
        if (var_dd5d2ace <= 0) {
            return 0;
        }
        self.e_seeker.angles = vectortoangles(v_forward);
        self.e_seeker moveto(v_end, var_dd5d2ace);
        var_51b61d63 = gettime() / 1000;
    } else {
        self.e_seeker.angles = vectortoangles(v_forward);
        self.e_seeker moveto(v_end, var_39d5856d);
    }
    n_time_started = gettime() / 1000;
    var_8cd2f4c9 = v_start;
    var_8b1618ca = v_forward;
    do {
        n_time_current = gettime() / 1000;
        n_time_elapsed = n_time_current - n_time_started;
        e_target = self.e_seeker function_dee5f345(var_8cd2f4c9, var_9751fed1, var_8b1618ca);
        if (isdefined(e_target)) {
            if (isdefined(e_target.powerup_name)) {
                e_target.origin = self.e_seeker.origin;
                e_target linkto(self.e_seeker);
                if (!isdefined(self.e_seeker.var_959f46dd)) {
                    self.e_seeker.var_959f46dd = [];
                } else if (!isarray(self.e_seeker.var_959f46dd)) {
                    self.e_seeker.var_959f46dd = array(self.e_seeker.var_959f46dd);
                }
                self.e_seeker.var_959f46dd[self.e_seeker.var_959f46dd.size] = e_target;
            } else if (isalive(e_target)) {
                b_killed_zombie = self function_a6674838(e_target);
                self notify(#"hash_146bfa4c4de1779");
                return b_killed_zombie;
            }
        }
        if (isdefined(var_51b61d63)) {
            var_361da474 = n_time_current - var_51b61d63;
            if (var_361da474 >= var_dd5d2ace) {
                level thread function_d3ffbd8e(v_end, a_trace[#"normal"]);
                if (isdefined(level.var_d9e9a35f)) {
                    level notify(#"hero_weapon_hit", {#player:self, #e_entity:a_trace[#"entity"], #var_3657beb7:self.currentweapon, #v_position:a_trace[#"position"]});
                }
                v_start = v_end;
                v_forward -= 2 * a_trace[#"normal"] * vectordot(v_forward, a_trace[#"normal"]);
                n_dist = var_87e15a09 - n_dist;
                v_end = v_start + v_forward * n_dist;
                a_trace = bullettrace(v_start, v_end, 0, self);
                if (distancesquared(v_start, v_end) != distancesquared(v_start, a_trace[#"position"])) {
                    v_end = a_trace[#"position"];
                    n_dist = distance(v_start, v_end);
                    var_51b61d63 = gettime() / 1000;
                } else {
                    var_51b61d63 = undefined;
                }
                var_dd5d2ace = n_dist * var_39d5856d / var_87e15a09;
                if (var_dd5d2ace <= 0) {
                    return 0;
                }
                self.e_seeker.angles = vectortoangles(v_forward);
                self.e_seeker moveto(v_end, var_dd5d2ace);
            }
        }
        wait 0.1;
        var_8cd2f4c9 = self.e_seeker.origin;
    } while (n_time_elapsed < var_39d5856d);
    return 0;
}

// Namespace zm_weap_chakram/zm_weap_chakram
// Params 3, eflags: 0x4
// Checksum 0xb6aa18bb, Offset: 0x26c0
// Size: 0x45a
function private function_dee5f345(v_start, var_a4126b22, v_forward) {
    a_e_targets = zm_hero_weapon::function_765137a1();
    if (isdefined(v_forward)) {
        foreach (e_powerup in level.active_powerups) {
            if (!isdefined(e_powerup)) {
                continue;
            }
            if (isinarray(self.var_959f46dd, e_powerup)) {
                continue;
            }
            if (isdefined(level.var_b45a0716) && isinarray(level.var_b45a0716, e_powerup.powerup_name)) {
                continue;
            }
            if (!isdefined(a_e_targets)) {
                a_e_targets = [];
            } else if (!isarray(a_e_targets)) {
                a_e_targets = array(a_e_targets);
            }
            a_e_targets[a_e_targets.size] = e_powerup;
        }
    }
    a_e_targets = arraysortclosest(a_e_targets, v_start, undefined, undefined, var_a4126b22);
    var_c0071e1a = [];
    foreach (e_target in a_e_targets) {
        if (zm_utility::is_magic_bullet_shield_enabled(e_target)) {
            continue;
        }
        if (isinarray(self.var_959f46dd, e_target)) {
            continue;
        }
        if (isdefined(e_target.var_29ed62b2) && (e_target.var_29ed62b2 == #"heavy" || e_target.var_29ed62b2 == #"miniboss")) {
            if (isdefined(self.var_7295a672) && isinarray(self.var_7295a672, e_target)) {
                continue;
            }
        }
        if (isdefined(v_forward)) {
            v_to_target = vectornormalize(e_target.origin - v_start);
            if (vectordot(v_to_target, v_forward) < 0.7) {
                continue;
            }
        }
        if (!isdefined(var_c0071e1a)) {
            var_c0071e1a = [];
        } else if (!isarray(var_c0071e1a)) {
            var_c0071e1a = array(var_c0071e1a);
        }
        var_c0071e1a[var_c0071e1a.size] = e_target;
    }
    n_traces = 0;
    foreach (var_e65e185b in var_c0071e1a) {
        if ((isdefined(var_e65e185b.powerup_name) || function_a5354464(var_e65e185b) || isalive(var_e65e185b)) && bullettracepassed(v_start, var_e65e185b getcentroid(), 0, self, var_e65e185b)) {
            return var_e65e185b;
        }
        n_traces++;
        if (n_traces > 3) {
            n_traces = 0;
            waitframe(1);
        }
    }
    return undefined;
}

// Namespace zm_weap_chakram/zm_weap_chakram
// Params 1, eflags: 0x4
// Checksum 0x7c482436, Offset: 0x2b28
// Size: 0x2b8
function private function_a6674838(e_target) {
    var_19292017 = level.hero_weapon_stats[#"chakram"][#"travel_time"][self.var_4dcf5f7f];
    var_87e15a09 = level.hero_weapon_stats[#"chakram"][#"max_range"][self.var_4dcf5f7f];
    if (!isdefined(e_target)) {
        e_target = self;
        var_19292017 /= 2;
    }
    while (true) {
        if (!isdefined(e_target)) {
            return 0;
        }
        v_target = e_target getcentroid();
        if (distancesquared(self.e_seeker.origin, v_target) > 2304) {
            var_2cfa06e2 = distance(self.e_seeker.origin, v_target);
            n_travel_time = var_2cfa06e2 * var_19292017 / var_87e15a09;
            self.e_seeker moveto(v_target, n_travel_time);
        } else if (isplayer(e_target)) {
            self playsound(#"hash_2c86fd203e33ce7c");
            self.e_seeker.origin = self.origin + (0, 0, 48);
            a_e_powerups = array::remove_undefined(self.e_seeker.var_959f46dd);
            foreach (e_powerup in a_e_powerups) {
                e_powerup unlink();
                e_powerup.origin = self.origin;
            }
            return 0;
        } else {
            self thread function_83ab61f5(e_target);
            return 1;
        }
        wait 0.1;
    }
}

// Namespace zm_weap_chakram/zm_weap_chakram
// Params 1, eflags: 0x4
// Checksum 0x1a3538dd, Offset: 0x2de8
// Size: 0x344
function private function_83ab61f5(e_target) {
    if (isalive(e_target)) {
        if (isactor(e_target)) {
            e_target thread zm_hero_weapon::function_f53ff9();
            [[ level.var_78c1eedc ]]->waitinqueue(e_target);
        }
        switch (e_target.var_29ed62b2) {
        case #"popcorn":
        case #"basic":
            gibserverutils::gibhead(e_target);
            e_target clientfield::set("chakram_head_pop_fx", 1);
            n_damage = e_target.health;
            break;
        case #"heavy":
        case #"miniboss":
            e_target clientfield::increment("chakram_throw_special_impact_fx", 1);
            n_damage = 1000;
            if (!isdefined(self.e_seeker.var_7295a672)) {
                self.e_seeker.var_7295a672 = [];
            } else if (!isarray(self.e_seeker.var_7295a672)) {
                self.e_seeker.var_7295a672 = array(self.e_seeker.var_7295a672);
            }
            self.e_seeker.var_7295a672[self.e_seeker.var_7295a672.size] = e_target;
            break;
        case #"boss":
            n_damage = 1000;
            if (!isdefined(self.e_seeker.var_7295a672)) {
                self.e_seeker.var_7295a672 = [];
            } else if (!isarray(self.e_seeker.var_7295a672)) {
                self.e_seeker.var_7295a672 = array(self.e_seeker.var_7295a672);
            }
            self.e_seeker.var_7295a672[self.e_seeker.var_7295a672.size] = e_target;
            break;
        case #"inanimate":
            if (!(isdefined(e_target.var_6c0353f8) && e_target.var_6c0353f8)) {
                e_target thread function_3ee5d91(0.5);
            }
            n_damage = 1000;
            break;
        }
        e_target dodamage(1000, e_target.origin, self, self, "none", "MOD_PROJECTILE", 0, self.slot_weapons[#"hero_weapon"]);
    }
}

// Namespace zm_weap_chakram/zm_weap_chakram
// Params 1, eflags: 0x4
// Checksum 0x78fe7c8, Offset: 0x3138
// Size: 0x3e
function private function_3ee5d91(n_time) {
    self endon(#"death");
    self.var_6c0353f8 = 1;
    wait n_time;
    self.var_6c0353f8 = 0;
}

// Namespace zm_weap_chakram/zm_weap_chakram
// Params 2, eflags: 0x4
// Checksum 0x275ede90, Offset: 0x3180
// Size: 0x94
function private function_d3ffbd8e(v_position, v_normal) {
    mdl_fx = util::spawn_model("tag_origin", v_position, v_normal);
    mdl_fx endon(#"death");
    mdl_fx clientfield::set("chakram_throw_impact_fx", 1);
    wait 1.5;
    mdl_fx delete();
}

// Namespace zm_weap_chakram/zm_weap_chakram
// Params 1, eflags: 0x4
// Checksum 0x59547c01, Offset: 0x3220
// Size: 0x44
function private function_baf27075(weapon) {
    self endon(#"disconnect");
    self clientfield::increment_to_player("chakram_speed_buff_postfx", 1);
}

// Namespace zm_weap_chakram/zm_weap_chakram
// Params 1, eflags: 0x4
// Checksum 0x74e797e5, Offset: 0x3270
// Size: 0xd8
function private function_52650eae(weapon) {
    self endon(#"disconnect", #"weapon_change", #"bled_out", #"entering_last_stand");
    level endoncallback(&function_517b6a76, #"round_reset");
    while (self getcurrentweapon() == weapon) {
        self waittill(#"weapon_melee");
        self function_17328e2();
        self function_a367bc09();
        wait 0.5;
    }
}

// Namespace zm_weap_chakram/zm_weap_chakram
// Params 1, eflags: 0x4
// Checksum 0x5bfe8886, Offset: 0x3350
// Size: 0xb0
function private function_517b6a76(var_a6d32d) {
    assert(var_a6d32d == #"round_reset");
    foreach (player in getplayers()) {
        player function_a367bc09();
    }
}

// Namespace zm_weap_chakram/zm_weap_chakram
// Params 1, eflags: 0x4
// Checksum 0x35443c92, Offset: 0x3408
// Size: 0x94
function private function_786e5bd2(var_9c746a94) {
    self endon(#"disconnect");
    self notify("5eee201708fc8b7f");
    self endon("5eee201708fc8b7f");
    s_notify = self waittill(#"weapon_change", #"hash_1c35eb15aa210d6");
    if (s_notify.weapon !== var_9c746a94) {
        self function_a367bc09();
    }
}

// Namespace zm_weap_chakram/zm_weap_chakram
// Params 0, eflags: 0x0
// Checksum 0x4bfe34aa, Offset: 0x34a8
// Size: 0x34
function function_a367bc09() {
    self.var_5d346c5c = 0;
    if (isdefined(self)) {
        self clientfield::set("chakram_whirlwind_fx", 0);
    }
}

// Namespace zm_weap_chakram/zm_weap_chakram
// Params 0, eflags: 0x4
// Checksum 0x5cf65fbc, Offset: 0x34e8
// Size: 0x6c
function private function_17328e2() {
    self.var_5d346c5c = 1;
    self clientfield::set("chakram_whirlwind_fx", 1);
    self playsound(#"hash_6043c078f3675169");
    self function_95d422e9();
}

// Namespace zm_weap_chakram/zm_weap_chakram
// Params 0, eflags: 0x4
// Checksum 0xde07ac0d, Offset: 0x3560
// Size: 0x364
function private function_95d422e9() {
    self endon(#"weapon_melee", #"weapon_change", #"disconnect", #"bled_out", #"entering_last_stand");
    var_abc8b2ce = getweapon(#"hero_chakram_lv3");
    while (isdefined(self.var_5d346c5c) && self.var_5d346c5c) {
        self clientfield::increment_to_player("chakram_rumble", 6);
        a_e_targets = zm_hero_weapon::function_765137a1();
        a_e_targets = arraysortclosest(a_e_targets, self.origin, undefined, undefined, 128);
        foreach (e_target in a_e_targets) {
            if (isalive(e_target) && !zm_utility::is_magic_bullet_shield_enabled(e_target)) {
                var_11073d39 = 1;
                switch (e_target.var_29ed62b2) {
                case #"popcorn":
                case #"basic":
                    n_damage = 3594;
                    break;
                case #"heavy":
                case #"miniboss":
                    n_damage = 1000;
                    break;
                case #"boss":
                    n_damage = 1000;
                    var_11073d39 = 0;
                    break;
                case #"inanimate":
                    n_damage = 3594;
                    var_11073d39 = 0;
                    break;
                }
                if (e_target.health < n_damage && isactor(e_target) && var_11073d39) {
                    gibserverutils::gibhead(e_target);
                    e_target clientfield::set("chakram_head_pop_fx", 1);
                    e_target playsound(#"hash_4332e54b12b06564");
                    e_target clientfield::increment("chakram_whirlwind_shred_fx", 1);
                }
                e_target dodamage(n_damage, e_target.origin, self, self, "none", "MOD_UNKNOWN", 0, var_abc8b2ce);
                waitframe(1);
            }
        }
        wait 0.2;
    }
}

// Namespace zm_weap_chakram/zm_weap_chakram
// Params 1, eflags: 0x0
// Checksum 0x45b75f7c, Offset: 0x38d0
// Size: 0x132
function chakram_rumble(var_b35c2422) {
    if (var_b35c2422) {
        switch (var_b35c2422) {
        case 1:
            self playrumbleonentity("zm_weap_special_activate_rumble");
            break;
        case 2:
            self clientfield::increment_to_player("chakram_rumble", 2);
            break;
        case 3:
            self playrumbleonentity("zm_weap_chakram_melee_hit_rumble");
            break;
        case 4:
            self clientfield::increment_to_player("chakram_rumble", 4);
            break;
        case 5:
            self clientfield::increment_to_player("chakram_rumble", 5);
            break;
        }
    }
}

// Namespace zm_weap_chakram/zm_weap_chakram
// Params 1, eflags: 0x0
// Checksum 0x7411a704, Offset: 0x3a10
// Size: 0xdc
function function_28e4f6c8(w_chakram) {
    self endon(#"disconnect", #"weapon_change", #"bled_out", #"entering_last_stand");
    level endoncallback(&function_517b6a76, #"round_reset");
    s_result = self waittill(#"weapon_melee");
    if (s_result.weapon === w_chakram) {
        self thread zm_audio::create_and_play_dialog(#"hero_level_3", #"chakram");
    }
}

