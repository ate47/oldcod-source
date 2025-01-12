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

#namespace zm_weap_sword_pistol;

// Namespace zm_weap_sword_pistol/zm_weap_sword_pistol
// Params 0, eflags: 0x2
// Checksum 0xcd1c3467, Offset: 0x2c8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_weap_sword_pistol", &__init__, undefined, undefined);
}

// Namespace zm_weap_sword_pistol/zm_weap_sword_pistol
// Params 0, eflags: 0x0
// Checksum 0x92493fd6, Offset: 0x310
// Size: 0x70c
function __init__() {
    clientfield::register("actor", "sword_pistol_slice_right", 1, 1, "counter");
    clientfield::register("vehicle", "sword_pistol_slice_right", 1, 1, "counter");
    clientfield::register("actor", "sword_pistol_slice_left", 1, 1, "counter");
    clientfield::register("vehicle", "sword_pistol_slice_left", 1, 1, "counter");
    clientfield::register("scriptmover", "viper_bite_projectile", 1, 1, "int");
    clientfield::register("actor", "viper_bite_projectile_impact", 1, 1, "counter");
    clientfield::register("vehicle", "viper_bite_projectile_impact", 1, 1, "counter");
    clientfield::register("actor", "viper_bite_bitten_fx", 1, 1, "int");
    clientfield::register("actor", "dragon_roar_impact", 1, 1, "counter");
    clientfield::register("vehicle", "dragon_roar_impact", 1, 1, "counter");
    clientfield::register("scriptmover", "dragon_roar_explosion", 1, 1, "counter");
    clientfield::register("toplayer", "swordpistol_rumble", 1, 3, "counter");
    level.hero_weapon[#"sword_pistol"][0] = getweapon(#"hero_sword_pistol_lv1");
    level.hero_weapon[#"sword_pistol"][1] = getweapon(#"hero_sword_pistol_lv2");
    level.hero_weapon[#"sword_pistol"][2] = getweapon(#"hero_sword_pistol_lv3");
    zm_loadout::register_hero_weapon_for_level("hero_sword_pistol_lv1");
    zm_loadout::register_hero_weapon_for_level("hero_sword_pistol_lv2");
    zm_loadout::register_hero_weapon_for_level("hero_sword_pistol_lv3");
    if (!isdefined(level.hero_weapon_stats)) {
        level.hero_weapon_stats = [];
    }
    level.hero_weapon_stats[#"sword_pistol"] = [];
    level.hero_weapon_stats[#"sword_pistol"][#"hash_6fba0e2bde88b416"] = 38416;
    level.hero_weapon_stats[#"sword_pistol"][#"hash_55062ef720314247"] = 270;
    level.hero_weapon_stats[#"sword_pistol"][#"hash_48e41904bfc0f47c"] = 640;
    level.hero_weapon_stats[#"sword_pistol"][#"hash_c2f67d595789176"] = 1024;
    level.hero_weapon_stats[#"sword_pistol"][#"hash_75b11282a283d609"] = 80;
    level.hero_weapon_stats[#"sword_pistol"][#"hash_ef5f7de16aa873d"] = 0.25;
    level.hero_weapon_stats[#"sword_pistol"][#"hash_c2f67d595789176"] = 1024;
    level.hero_weapon_stats[#"sword_pistol"][#"hash_4ef595c3dab3275e"] = 10;
    level.hero_weapon_stats[#"sword_pistol"][#"hash_1ec768b1d6fc1dc6"] = 64;
    level.hero_weapon_stats[#"sword_pistol"][#"hash_5fe5ad9db12d4c99"] = 32;
    level.hero_weapon_stats[#"sword_pistol"][#"hash_579056d441d637d"] = 800;
    level.hero_weapon_stats[#"sword_pistol"][#"hash_634b06c9d5064145"] = 160;
    level.var_96bfc341 = new throttle();
    [[ level.var_96bfc341 ]]->initialize(3, 0.1);
    callback::on_connect(&function_a7e97d32);
    callback::on_disconnect(&on_disconnect);
    callback::add_weapon_fired(level.hero_weapon[#"sword_pistol"][0].dualwieldweapon, &function_d2915b28);
    callback::add_weapon_fired(level.hero_weapon[#"sword_pistol"][1].dualwieldweapon, &function_d2915b28);
    callback::add_weapon_fired(level.hero_weapon[#"sword_pistol"][2].dualwieldweapon, &function_d2915b28);
}

// Namespace zm_weap_sword_pistol/zm_weap_sword_pistol
// Params 0, eflags: 0x0
// Checksum 0x44914ce3, Offset: 0xa28
// Size: 0x54
function on_disconnect() {
    if (isdefined(self.var_5d7a5e0)) {
        self.var_5d7a5e0 delete();
    }
    if (isdefined(self.var_5f9c4450)) {
        self.var_5f9c4450 delete();
    }
}

// Namespace zm_weap_sword_pistol/zm_weap_sword_pistol
// Params 0, eflags: 0x4
// Checksum 0xed30491e, Offset: 0xa88
// Size: 0x338
function private function_a7e97d32() {
    self endon(#"disconnect");
    while (true) {
        waitresult = self waittill(#"weapon_change");
        wpn_cur = waitresult.weapon;
        wpn_prev = waitresult.last_weapon;
        if (wpn_cur == level.hero_weapon[#"sword_pistol"][0]) {
            self thread swordpistol_rumble(1);
            if (!self gamepadusedlast()) {
                self zm_hero_weapon::show_hint(wpn_cur, #"hash_6514f206d5d2c57f");
            } else {
                self zm_hero_weapon::show_hint(wpn_cur, #"hash_211bb263a0e77c99");
            }
            self thread function_8d42206f(wpn_cur);
            self thread function_43c9c224(wpn_cur);
            continue;
        }
        if (wpn_cur == level.hero_weapon[#"sword_pistol"][1]) {
            self thread swordpistol_rumble(1);
            if (!self gamepadusedlast()) {
                self zm_hero_weapon::show_hint(wpn_cur, #"hash_6514f206d5d2c57f");
            } else {
                self zm_hero_weapon::show_hint(wpn_cur, #"hash_211bb263a0e77c99");
            }
            self thread function_8d42206f(wpn_cur);
            self thread function_43c9c224(wpn_cur);
            continue;
        }
        if (wpn_cur == level.hero_weapon[#"sword_pistol"][2]) {
            self thread swordpistol_rumble(1);
            if (!self gamepadusedlast()) {
                self zm_hero_weapon::show_hint(wpn_cur, #"hash_2303e09b25647ced");
            } else {
                self zm_hero_weapon::show_hint(wpn_cur, #"hash_289f1ec940a22d13");
            }
            self thread function_8d42206f(wpn_cur);
            self thread function_43c9c224(wpn_cur);
            self thread function_385b846d(wpn_cur);
            self thread function_28e4f6c8(wpn_cur);
        }
    }
}

// Namespace zm_weap_sword_pistol/zm_weap_sword_pistol
// Params 1, eflags: 0x4
// Checksum 0xbfe3a878, Offset: 0xdc8
// Size: 0x78
function private function_8d42206f(weapon) {
    self endon(#"weapon_change", #"disconnect", #"bled_out");
    while (true) {
        self waittill(#"weapon_melee_power");
        weapon function_7c22cf3(self);
    }
}

// Namespace zm_weap_sword_pistol/zm_weap_sword_pistol
// Params 1, eflags: 0x4
// Checksum 0xe4422282, Offset: 0xe48
// Size: 0x74
function private blood_death_fx(var_d98455ab) {
    if (self.archetype === "zombie") {
        if (var_d98455ab) {
            self clientfield::increment("sword_pistol_slice_left", 1);
            return;
        }
        self clientfield::increment("sword_pistol_slice_right", 1);
    }
}

// Namespace zm_weap_sword_pistol/zm_weap_sword_pistol
// Params 3, eflags: 0x0
// Checksum 0x70a4c536, Offset: 0xec8
// Size: 0x84
function function_5fe784f7(e_target, leftswing, weapon = level.weaponnone) {
    if (isactor(e_target)) {
        self thread chop_actor(e_target, leftswing, weapon);
        return;
    }
    self thread function_513ed8b2(e_target, leftswing, weapon);
}

// Namespace zm_weap_sword_pistol/zm_weap_sword_pistol
// Params 3, eflags: 0x0
// Checksum 0x9de7b50a, Offset: 0xf58
// Size: 0x22c
function chop_actor(ai, leftswing, weapon = level.weaponnone) {
    self endon(#"weapon_change", #"disconnect", #"bled_out");
    ai endon(#"death");
    switch (ai.var_29ed62b2) {
    case #"popcorn":
    case #"basic":
        n_damage = ai.health;
        break;
    case #"heavy":
        n_damage = int(ai.maxhealth * 0.25);
        break;
    case #"miniboss":
        n_damage = int(ai.maxhealth * 0.15);
        break;
    default:
        n_damage = 2500;
        break;
    }
    if (n_damage >= ai.health) {
        ai.ignoremelee = 1;
    }
    [[ level.var_96bfc341 ]]->waitinqueue(ai);
    ai blood_death_fx(leftswing);
    if (ai.health <= 0) {
        ai.ignoremelee = 1;
    }
    util::wait_network_frame();
    self thread swordpistol_rumble(3);
    self thread function_d7484666(ai, weapon, n_damage);
}

// Namespace zm_weap_sword_pistol/zm_weap_sword_pistol
// Params 3, eflags: 0x0
// Checksum 0x2786f196, Offset: 0x1190
// Size: 0x7c
function function_513ed8b2(e_target, leftswing, weapon = level.weaponnone) {
    util::wait_network_frame();
    self thread swordpistol_rumble(3);
    self thread function_d7484666(e_target, weapon, 2500);
}

// Namespace zm_weap_sword_pistol/zm_weap_sword_pistol
// Params 3, eflags: 0x0
// Checksum 0xea7a5cd5, Offset: 0x1218
// Size: 0x290
function function_bfc35dee(first_time, leftswing, weapon = level.weaponnone) {
    var_7dda366c = self getweaponmuzzlepoint();
    var_9550cc4f = self getweaponforwarddir();
    a_e_targets = zm_hero_weapon::function_765137a1();
    foreach (e_target in a_e_targets) {
        if (!isalive(e_target)) {
            continue;
        }
        if (first_time) {
            e_target.chopped = 0;
        } else if (isdefined(e_target.chopped) && e_target.chopped) {
            continue;
        }
        test_origin = e_target getcentroid();
        n_dist_sq = distancesquared(var_7dda366c, test_origin);
        var_ceedbe3d = level.hero_weapon_stats[#"sword_pistol"][#"hash_6fba0e2bde88b416"];
        var_cb4ae2be = level.hero_weapon_stats[#"sword_pistol"][#"hash_55062ef720314247"];
        if (n_dist_sq > var_ceedbe3d) {
            continue;
        }
        if (0 == e_target sightconetrace(var_7dda366c, self, var_9550cc4f, 270)) {
            continue;
        }
        e_target.chopped = 1;
        if (isdefined(e_target.chop_actor_cb)) {
            self thread [[ e_target.chop_actor_cb ]](e_target, self, weapon);
            continue;
        }
        self thread function_5fe784f7(e_target, leftswing, weapon);
    }
}

// Namespace zm_weap_sword_pistol/zm_weap_sword_pistol
// Params 1, eflags: 0x0
// Checksum 0x95c22bcb, Offset: 0x14b0
// Size: 0x124
function function_7c22cf3(player) {
    player thread function_bfc35dee(1, 1, player.var_c332c9d4);
    wait 0.15;
    player thread function_bfc35dee(0, 1, player.var_c332c9d4);
    if (player.var_c332c9d4 == level.hero_weapon[#"sword_pistol"][1] || player.var_c332c9d4 == level.hero_weapon[#"sword_pistol"][2]) {
        wait 0.35;
        player thread function_bfc35dee(1, 0, player.var_c332c9d4);
        wait 0.15;
        player thread function_bfc35dee(0, 0, player.var_c332c9d4);
    }
    wait 0.1;
}

// Namespace zm_weap_sword_pistol/zm_weap_sword_pistol
// Params 3, eflags: 0x0
// Checksum 0x37305680, Offset: 0x15e0
// Size: 0x8c
function function_d7484666(e_target, weapon, n_damage) {
    if (isalive(e_target)) {
        e_target thread zm_hero_weapon::function_f53ff9();
        e_target dodamage(n_damage, e_target.origin, self, self, "none", "MOD_MELEE", 0, weapon);
    }
}

// Namespace zm_weap_sword_pistol/zm_weap_sword_pistol
// Params 1, eflags: 0x0
// Checksum 0x25912677, Offset: 0x1678
// Size: 0x3c
function function_d2915b28(weapon) {
    self thread swordpistol_rumble(4);
    self function_a4b25782(weapon);
}

// Namespace zm_weap_sword_pistol/zm_weap_sword_pistol
// Params 1, eflags: 0x0
// Checksum 0x7060ead8, Offset: 0x16c0
// Size: 0x5c
function function_43c9c224(weapon) {
    self givemaxammo(weapon.dualwieldweapon);
    self setweaponammoclip(weapon.dualwieldweapon, weapon.dualwieldweapon.clipsize);
}

// Namespace zm_weap_sword_pistol/zm_weap_sword_pistol
// Params 1, eflags: 0x4
// Checksum 0x94a8497, Offset: 0x1728
// Size: 0x1230
function private function_a4b25782(weapon) {
    level.hero_weapon_stats[#"sword_pistol"][#"hash_5fe5ad9db12d4c99"] = 32;
    level.hero_weapon_stats[#"sword_pistol"][#"hash_579056d441d637d"] = 800;
    level.hero_weapon_stats[#"sword_pistol"][#"hash_634b06c9d5064145"] = 160;
    v_source = self getorigin();
    for (i = 0; i < level.hero_weapon[#"sword_pistol"].size; i++) {
        if (weapon == level.hero_weapon[#"sword_pistol"][i].dualwieldweapon) {
            n_level = i;
            var_fb740e96 = level.hero_weapon_stats[#"sword_pistol"][#"hash_5fe5ad9db12d4c99"];
            var_a0b5a8aa = level.hero_weapon_stats[#"sword_pistol"][#"hash_579056d441d637d"];
            weapon = level.hero_weapon[#"sword_pistol"][i];
            break;
        }
    }
    var_7dda366c = self getweaponmuzzlepoint();
    var_9550cc4f = self getweaponforwarddir();
    v_end_pos = var_7dda366c + vectorscale(var_9550cc4f, var_a0b5a8aa);
    a_beamtrace = beamtrace(var_7dda366c, v_end_pos, 0, self);
    var_28427185 = var_fb740e96 * var_fb740e96;
    var_d14ad544 = distance(var_7dda366c, a_beamtrace[#"position"]);
    var_47d2b169 = var_d14ad544 * var_d14ad544;
    var_33946fef = zm_hero_weapon::function_765137a1();
    var_33946fef = arraysortclosest(var_33946fef, var_7dda366c, undefined, undefined, var_d14ad544);
    if (isdefined(a_beamtrace[#"entity"]) && a_beamtrace[#"entity"].var_29ed62b2 === #"inanimate") {
        a_beamtrace[#"entity"].b_is_valid_target = 1;
        if (!isdefined(var_33946fef)) {
            var_33946fef = [];
        } else if (!isarray(var_33946fef)) {
            var_33946fef = array(var_33946fef);
        }
        if (!isinarray(var_33946fef, a_beamtrace[#"entity"])) {
            var_33946fef[var_33946fef.size] = a_beamtrace[#"entity"];
        }
    }
    if (n_level == 0 && var_33946fef.size <= 0) {
        return undefined;
    }
    var_fa8c9f2f = [];
    if (!isdefined(var_fa8c9f2f)) {
        var_fa8c9f2f = [];
    } else if (!isarray(var_fa8c9f2f)) {
        var_fa8c9f2f = array(var_fa8c9f2f);
    }
    var_fa8c9f2f[var_fa8c9f2f.size] = "j_head";
    if (!isdefined(var_fa8c9f2f)) {
        var_fa8c9f2f = [];
    } else if (!isarray(var_fa8c9f2f)) {
        var_fa8c9f2f = array(var_fa8c9f2f);
    }
    var_fa8c9f2f[var_fa8c9f2f.size] = "j_spine_4";
    if (!isdefined(var_fa8c9f2f)) {
        var_fa8c9f2f = [];
    } else if (!isarray(var_fa8c9f2f)) {
        var_fa8c9f2f = array(var_fa8c9f2f);
    }
    var_fa8c9f2f[var_fa8c9f2f.size] = "j_shoulder_le";
    if (!isdefined(var_fa8c9f2f)) {
        var_fa8c9f2f = [];
    } else if (!isarray(var_fa8c9f2f)) {
        var_fa8c9f2f = array(var_fa8c9f2f);
    }
    var_fa8c9f2f[var_fa8c9f2f.size] = "j_shoulder_ri";
    if (!isdefined(var_fa8c9f2f)) {
        var_fa8c9f2f = [];
    } else if (!isarray(var_fa8c9f2f)) {
        var_fa8c9f2f = array(var_fa8c9f2f);
    }
    var_fa8c9f2f[var_fa8c9f2f.size] = "j_elbow_le";
    if (!isdefined(var_fa8c9f2f)) {
        var_fa8c9f2f = [];
    } else if (!isarray(var_fa8c9f2f)) {
        var_fa8c9f2f = array(var_fa8c9f2f);
    }
    var_fa8c9f2f[var_fa8c9f2f.size] = "j_elbow_ri";
    if (!isdefined(var_fa8c9f2f)) {
        var_fa8c9f2f = [];
    } else if (!isarray(var_fa8c9f2f)) {
        var_fa8c9f2f = array(var_fa8c9f2f);
    }
    var_fa8c9f2f[var_fa8c9f2f.size] = "j_wrist_le";
    if (!isdefined(var_fa8c9f2f)) {
        var_fa8c9f2f = [];
    } else if (!isarray(var_fa8c9f2f)) {
        var_fa8c9f2f = array(var_fa8c9f2f);
    }
    var_fa8c9f2f[var_fa8c9f2f.size] = "j_wrist_ri";
    a_e_targets = [];
    for (i = 0; i < var_33946fef.size; i++) {
        if (!isalive(var_33946fef[i])) {
            continue;
        }
        if (isactor(var_33946fef[i])) {
            v_target_location = var_33946fef[i] getcentroid();
            v_target_origin = var_33946fef[i] getorigin();
            var_f6ec193d = distancesquared(var_7dda366c, v_target_location);
            var_32769d76 = pointonsegmentnearesttopoint(var_7dda366c, v_end_pos, v_target_origin);
            if (var_f6ec193d > var_47d2b169) {
                continue;
            }
            normal = vectornormalize(v_target_location - var_7dda366c);
            dot = vectordot(var_9550cc4f, normal);
            if (0 > dot) {
                continue;
            }
            if (distancesquared(v_target_location, var_32769d76) <= var_28427185 || distancesquared(v_target_origin, var_32769d76) <= var_28427185) {
                var_33946fef[i].b_is_valid_target = 1;
            } else {
                foreach (str_tag in var_fa8c9f2f) {
                    v_hitloc = var_33946fef[i] gettagorigin(str_tag);
                    if (isdefined(v_hitloc) && distancesquared(v_hitloc, var_32769d76) <= var_28427185) {
                        var_33946fef[i].b_is_valid_target = 1;
                        break;
                    }
                }
            }
        }
        if (isdefined(var_33946fef[i].b_is_valid_target) && var_33946fef[i].b_is_valid_target) {
            if (!isdefined(a_e_targets)) {
                a_e_targets = [];
            } else if (!isarray(a_e_targets)) {
                a_e_targets = array(a_e_targets);
            }
            a_e_targets[a_e_targets.size] = var_33946fef[i];
        }
    }
    if (a_e_targets.size > 0) {
        a_e_targets = array::remove_dead(a_e_targets);
        a_e_targets = arraysortclosest(a_e_targets, self.origin);
        foreach (i, e_target in a_e_targets) {
            if (!isalive(e_target) || zm_utility::is_magic_bullet_shield_enabled(e_target)) {
                continue;
            }
            if (isdefined(e_target.var_3059fa07) && e_target.var_3059fa07) {
                continue;
            }
            if (isdefined(e_target.aat_turned) && e_target.aat_turned) {
                continue;
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
            default:
                n_damage = 2500;
                break;
            }
            if (isactor(e_target)) {
                e_target clientfield::increment("dragon_roar_impact");
                if (n_level > 0 && i == a_e_targets.size - 1) {
                    var_7e409f3e = a_e_targets[i] getcentroid();
                    var_4ce0592e = a_e_targets[i];
                }
                if (n_damage >= e_target.health) {
                    e_target.ignoremelee = 1;
                }
                [[ level.var_96bfc341 ]]->waitinqueue(e_target);
                e_target thread zm_hero_weapon::function_f53ff9();
            }
            e_target dodamage(n_damage, self.origin, self, self, "none", "MOD_EXPLOSIVE", 0, weapon);
            waitframe(1);
        }
    } else if (n_level > 0) {
        v_end = var_7dda366c + var_9550cc4f * sqrt(var_47d2b169);
        a_trace = bullettrace(var_7dda366c, v_end, 0, self);
        var_7ab4c67e = a_trace[#"position"];
        check1 = distance(var_7dda366c, var_7ab4c67e);
        check2 = distance(var_7dda366c, v_end);
        if (distancesquared(var_7dda366c, var_7ab4c67e) < distancesquared(var_7dda366c, v_end)) {
            var_7e409f3e = var_7ab4c67e;
        } else {
            var_7e409f3e = v_end;
        }
    }
    if (isdefined(var_7e409f3e)) {
        if (!isdefined(self.var_ad930617)) {
            self.var_ad930617 = spawn("script_model", var_7e409f3e);
            util::wait_network_frame(2);
        }
        self.var_ad930617 dontinterpolate();
        self.var_ad930617.origin = var_7e409f3e;
        self.var_ad930617 clientfield::increment("dragon_roar_explosion");
        if (isdefined(level.var_d9e9a35f)) {
            self thread function_740b70ac(weapon, var_7e409f3e);
        }
        var_33946fef = zm_hero_weapon::function_765137a1();
        var_33946fef = arraysortclosest(var_33946fef, var_7dda366c, undefined, undefined, level.hero_weapon_stats[#"sword_pistol"][#"hash_634b06c9d5064145"]);
        if (isdefined(a_trace) && isdefined(a_trace[#"entity"]) && function_a5354464(a_trace[#"entity"].var_29ed62b2 === #"inanimate")) {
            if (!isdefined(var_33946fef)) {
                var_33946fef = [];
            } else if (!isarray(var_33946fef)) {
                var_33946fef = array(var_33946fef);
            }
            if (!isinarray(var_33946fef, a_trace[#"entity"])) {
                var_33946fef[var_33946fef.size] = a_trace[#"entity"];
            }
        }
        foreach (e_target in var_33946fef) {
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
            default:
                n_damage = 2500;
                break;
            }
            if (isactor(e_target)) {
                if (!isalive(e_target) || zm_utility::is_magic_bullet_shield_enabled(e_target)) {
                    continue;
                }
                if (isdefined(e_target.var_3059fa07) && e_target.var_3059fa07) {
                    continue;
                }
                if (isdefined(e_target.aat_turned) && e_target.aat_turned) {
                    continue;
                }
                e_target thread zm_hero_weapon::function_f53ff9();
            }
            e_target dodamage(n_damage, self.origin, self, self, "none", "MOD_EXPLOSIVE", 0, weapon);
        }
    }
}

// Namespace zm_weap_sword_pistol/zm_weap_sword_pistol
// Params 2, eflags: 0x0
// Checksum 0xe509dae9, Offset: 0x2960
// Size: 0x108
function function_740b70ac(weapon, var_7e409f3e) {
    var_7dda366c = self getweaponmuzzlepoint();
    v_forward = self getweaponforwarddir();
    v_end = var_7dda366c + v_forward * 10000;
    a_trace = bullettrace(var_7dda366c, v_end, 0, self);
    level notify(#"hero_weapon_hit", {#player:self, #e_entity:a_trace[#"entity"], #var_3657beb7:weapon, #v_position:var_7e409f3e});
}

// Namespace zm_weap_sword_pistol/zm_weap_sword_pistol
// Params 1, eflags: 0x4
// Checksum 0x990fef13, Offset: 0x2a70
// Size: 0xa0
function private function_385b846d(weapon) {
    self endon(#"weapon_change", #"disconnect", #"bled_out");
    self.var_74f7c24c = undefined;
    while (true) {
        self waittill(#"weapon_melee");
        if (!(isdefined(self.var_74f7c24c) && self.var_74f7c24c)) {
            self function_f3991d79(weapon);
        }
    }
}

// Namespace zm_weap_sword_pistol/zm_weap_sword_pistol
// Params 1, eflags: 0x4
// Checksum 0x5ec7597d, Offset: 0x2b18
// Size: 0x662
function private function_f3991d79(weapon) {
    var_14f262d8 = level.hero_weapon_stats[#"sword_pistol"][#"hash_48e41904bfc0f47c"];
    var_32a745f = level.hero_weapon_stats[#"sword_pistol"][#"hash_75b11282a283d609"];
    var_506ba506 = var_32a745f * var_32a745f;
    var_ee674ac3 = level.hero_weapon_stats[#"sword_pistol"][#"hash_ef5f7de16aa873d"];
    n_move_speed = var_14f262d8 / var_ee674ac3;
    self.var_74f7c24c = 1;
    if (!isdefined(self.var_5d7a5e0)) {
        self.var_5d7a5e0 = util::spawn_model("tag_origin", self getcentroid(), self getangles());
    } else {
        self.var_5d7a5e0.origin = self getorigin() + (0, 0, 48);
    }
    v_pos = self getweaponmuzzlepoint();
    v_forward = self getweaponforwarddir();
    var_f889e95 = v_pos + v_forward * var_14f262d8;
    var_f889e95 = bullettrace(v_pos, var_f889e95, 0, undefined)[#"position"];
    var_ae029504 = self function_a76881ed();
    if (isdefined(var_ae029504)) {
        var_ae029504.var_3059fa07 = 1;
        v_end = var_ae029504 getcentroid();
    }
    if (!isdefined(v_end) || isdefined(v_end) && var_f889e95 == v_end) {
        v_end = var_f889e95;
    }
    var_6b63f67e = distance(v_pos, v_end);
    n_time_travel = var_6b63f67e / n_move_speed;
    var_ee674ac3 = n_time_travel < 0.1 ? 0.1 : n_time_travel;
    self.var_5d7a5e0 moveto(v_end, var_ee674ac3);
    self.var_5d7a5e0 clientfield::set("viper_bite_projectile", 1);
    self thread swordpistol_rumble(5);
    n_time_started = gettime() / 1000;
    for (n_time_elapsed = 0; n_time_elapsed < var_ee674ac3; n_time_elapsed = n_time_current - n_time_started) {
        a_ai_targets = self getenemiesinradius(self.var_5d7a5e0.origin, var_32a745f);
        var_7cd99f10 = arraycopy(a_ai_targets);
        foreach (var_b836c570 in var_7cd99f10) {
            if (!(isdefined(bullettracepassed(self.var_5d7a5e0.origin, var_b836c570 geteye(), 0, self)) && bullettracepassed(self.var_5d7a5e0.origin, var_b836c570 geteye(), 0, self))) {
                arrayremovevalue(a_ai_targets, var_b836c570);
            }
        }
        if (a_ai_targets.size > 0) {
            foreach (ai_target in a_ai_targets) {
                if (isdefined(ai_target)) {
                    if (isdefined(var_ae029504) && var_ae029504 == ai_target) {
                        continue;
                    }
                    v_target = ai_target getcentroid();
                    if (distancesquared(self.var_5d7a5e0.origin, v_target) <= var_506ba506) {
                        if (isalive(ai_target)) {
                            self thread function_28e726b1(ai_target, weapon);
                        }
                    }
                }
            }
        }
        waitframe(1);
        n_time_current = gettime() / 1000;
    }
    self.var_5d7a5e0 clientfield::set("viper_bite_projectile", 0);
    if (isalive(var_ae029504)) {
        var_ae029504 thread function_84b464fc(self, weapon);
        return;
    }
    self.var_74f7c24c = undefined;
}

// Namespace zm_weap_sword_pistol/zm_weap_sword_pistol
// Params 0, eflags: 0x4
// Checksum 0x5b698b5c, Offset: 0x3188
// Size: 0x428
function private function_a76881ed() {
    v_source = self getorigin();
    var_aa35617f = level.hero_weapon_stats[#"sword_pistol"][#"hash_75b11282a283d609"];
    var_613bf0e6 = var_aa35617f * var_aa35617f;
    var_a020108b = level.hero_weapon_stats[#"sword_pistol"][#"hash_48e41904bfc0f47c"];
    var_c6499322 = var_a020108b * var_a020108b;
    var_7dda366c = self getweaponmuzzlepoint();
    var_9550cc4f = self getweaponforwarddir();
    v_end_pos = var_7dda366c + vectorscale(var_9550cc4f, var_a020108b);
    a_ai_zombies = self getenemiesinradius(var_7dda366c, var_a020108b);
    if (!a_ai_zombies.size) {
        return undefined;
    }
    var_c787480f = [];
    for (i = 0; i < a_ai_zombies.size; i++) {
        if (!isalive(a_ai_zombies[i])) {
            continue;
        }
        if (!(isdefined(bullettracepassed(var_7dda366c, a_ai_zombies[i] geteye(), 0, self)) && bullettracepassed(var_7dda366c, a_ai_zombies[i] geteye(), 0, self))) {
            continue;
        }
        if (a_ai_zombies[i].archetype !== "zombie") {
            continue;
        }
        if (isdefined(a_ai_zombies[i].var_3059fa07) && a_ai_zombies[i].var_3059fa07) {
            continue;
        }
        if (isdefined(a_ai_zombies[i].aat_turned) && a_ai_zombies[i].aat_turned) {
            continue;
        }
        v_zombie_location = a_ai_zombies[i] getcentroid();
        normal = vectornormalize(v_zombie_location - var_7dda366c);
        dot = vectordot(var_9550cc4f, normal);
        if (0 > dot) {
            continue;
        }
        var_f6ec193d = distancesquared(var_7dda366c, v_zombie_location);
        var_32769d76 = pointonsegmentnearesttopoint(var_7dda366c, v_end_pos, v_zombie_location);
        if (var_f6ec193d > var_c6499322) {
            continue;
        }
        if (distancesquared(v_zombie_location, var_32769d76) > var_613bf0e6) {
            continue;
        }
        if (!isdefined(var_c787480f)) {
            var_c787480f = [];
        } else if (!isarray(var_c787480f)) {
            var_c787480f = array(var_c787480f);
        }
        var_c787480f[var_c787480f.size] = a_ai_zombies[i];
    }
    if (var_c787480f.size <= 0) {
        return undefined;
    }
    var_c787480f = arraysortclosest(var_c787480f, v_source);
    return var_c787480f[var_c787480f.size - 1];
}

// Namespace zm_weap_sword_pistol/zm_weap_sword_pistol
// Params 2, eflags: 0x4
// Checksum 0x31924798, Offset: 0x35b8
// Size: 0x104
function private function_28e726b1(e_zombie, weapon) {
    [[ level.var_96bfc341 ]]->waitinqueue(e_zombie);
    if (isalive(e_zombie)) {
        switch (e_zombie.var_29ed62b2) {
        case #"popcorn":
        case #"basic":
            n_damage = e_zombie.health;
            break;
        default:
            n_damage = 1000;
            break;
        }
        e_zombie thread zm_hero_weapon::function_f53ff9();
        e_zombie dodamage(n_damage, self.origin, self, self, "none", "MOD_PROJECTILE", 0, weapon);
    }
}

// Namespace zm_weap_sword_pistol/zm_weap_sword_pistol
// Params 2, eflags: 0x4
// Checksum 0xe5a3751, Offset: 0x36c8
// Size: 0x12c
function private function_84b464fc(player, weapon) {
    self thread function_e06e63c8(player, weapon);
    var_483f3876 = level.hero_weapon_stats[#"sword_pistol"][#"hash_c2f67d595789176"];
    var_483a7f26 = level.hero_weapon_stats[#"sword_pistol"][#"hash_1ec768b1d6fc1dc6"];
    var_3e346af6 = level.hero_weapon_stats[#"sword_pistol"][#"hash_4ef595c3dab3275e"];
    self zm_utility::create_zombie_point_of_interest(var_483f3876, var_483a7f26, 10000);
    self zm_utility::create_zombie_point_of_interest_attractor_positions(var_3e346af6, undefined, 128);
    self thread function_fc984d27(player, weapon);
}

// Namespace zm_weap_sword_pistol/zm_weap_sword_pistol
// Params 2, eflags: 0x0
// Checksum 0xc3d48d93, Offset: 0x3800
// Size: 0x2a4
function function_fc984d27(player, weapon) {
    self endon(#"death");
    n_time_started = gettime() / 1000;
    while (true) {
        n_time_current = gettime() / 1000;
        n_time_elapsed = n_time_current - n_time_started;
        a_ai_potential_targets = getaiteamarray(level.zombie_team);
        a_ai_targets = arraysortclosest(a_ai_potential_targets, self.origin, undefined, undefined, 128);
        foreach (ai_target in a_ai_targets) {
            if (!isalive(ai_target)) {
                continue;
            }
            if (isdefined(ai_target.aat_turned) && ai_target.aat_turned) {
                continue;
            }
            if (self !== ai_target) {
                ai_target thread function_ba2512c5(player, weapon);
                waitframe(1);
            }
        }
        wait 0.25;
        if (n_time_elapsed >= 5) {
            break;
        }
    }
    self clientfield::increment("viper_bite_projectile_impact");
    self notify(#"hash_1404343e2a1a434c");
    waitframe(1);
    switch (self.var_29ed62b2) {
    case #"popcorn":
    case #"basic":
        n_damage = self.health;
        break;
    default:
        n_damage = 1000;
        break;
    }
    self thread zm_hero_weapon::function_f53ff9();
    self dodamage(n_damage, self.origin, player, player, "none", "MOD_PROJECTILE", 0, weapon);
}

// Namespace zm_weap_sword_pistol/zm_weap_sword_pistol
// Params 2, eflags: 0x0
// Checksum 0xf9f1d83f, Offset: 0x3ab0
// Size: 0xa4
function function_ba2512c5(player, weapon) {
    if (isalive(self)) {
        self thread zm_hero_weapon::function_f53ff9();
        self clientfield::increment("viper_bite_projectile_impact");
        waitframe(1);
        self dodamage(1000, self.origin, player, undefined, "none", "MOD_PROJECTILE", 0, weapon);
    }
}

// Namespace zm_weap_sword_pistol/zm_weap_sword_pistol
// Params 2, eflags: 0x4
// Checksum 0xc1bd2db, Offset: 0x3b60
// Size: 0x2c0
function private function_e06e63c8(player, weapon) {
    var_83ca04b0 = self getcentroid();
    self clientfield::set("viper_bite_bitten_fx", 1);
    if (!isdefined(player.var_5f9c4450)) {
        player.var_5f9c4450 = util::spawn_model("tag_origin", var_83ca04b0);
    } else {
        player.var_5f9c4450.origin = var_83ca04b0;
    }
    self waittill(#"hash_1404343e2a1a434c", #"death");
    self clientfield::set("viper_bite_bitten_fx", 0);
    player.var_74f7c24c = undefined;
    a_ai_zombies = player getenemiesinradius(var_83ca04b0, 192);
    if (!a_ai_zombies.size) {
        return;
    }
    var_534e9374 = 36864;
    foreach (ai_zombie in a_ai_zombies) {
        if (!isalive(ai_zombie)) {
            continue;
        }
        v_curr_zombie_origin = ai_zombie getcentroid();
        if (distancesquared(var_83ca04b0, v_curr_zombie_origin) > var_534e9374) {
            continue;
        }
        switch (ai_zombie.var_29ed62b2) {
        case #"popcorn":
        case #"basic":
            n_damage = ai_zombie.health;
            break;
        default:
            n_damage = 1000;
            break;
        }
        if (ai_zombie.health < n_damage) {
            ai_zombie.var_1f0a4486 = 1;
        }
        ai_zombie dodamage(n_damage, v_curr_zombie_origin, player, player, "none", "MOD_EXPLOSIVE", 0, weapon);
    }
}

// Namespace zm_weap_sword_pistol/zm_weap_sword_pistol
// Params 1, eflags: 0x0
// Checksum 0xbb132f54, Offset: 0x3e28
// Size: 0x13a
function swordpistol_rumble(var_b35c2422) {
    if (var_b35c2422) {
        waitframe(1);
        switch (var_b35c2422) {
        case 1:
            self playrumbleonentity("zm_weap_special_activate_rumble");
            break;
        case 2:
            self clientfield::increment_to_player("swordpistol_rumble", 2);
            break;
        case 3:
            self playrumbleonentity("zm_weap_swordpistol_melee_hit_rumble");
            break;
        case 4:
            self clientfield::increment_to_player("swordpistol_rumble", 4);
            break;
        case 5:
            self clientfield::increment_to_player("swordpistol_rumble", 5);
            break;
        }
    }
}

// Namespace zm_weap_sword_pistol/zm_weap_sword_pistol
// Params 1, eflags: 0x4
// Checksum 0xb30332ec, Offset: 0x3f70
// Size: 0xa4
function private function_28e4f6c8(w_swordpistol) {
    self endon(#"weapon_change", #"disconnect", #"bled_out");
    s_result = self waittill(#"weapon_melee");
    if (s_result.weapon === w_swordpistol) {
        self thread zm_audio::create_and_play_dialog(#"hero_level_3", #"sword_pistol");
    }
}

