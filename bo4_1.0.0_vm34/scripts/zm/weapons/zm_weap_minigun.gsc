#using scripts\abilities\ability_player;
#using scripts\core_common\ai\zombie_shared;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm\powerup\zm_powerup_nuke;
#using scripts\zm_common\callbacks;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_hero_weapon;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_net;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_utility;

#namespace zm_weap_minigun;

// Namespace zm_weap_minigun/zm_weap_minigun
// Params 0, eflags: 0x2
// Checksum 0xa9a5ca0a, Offset: 0x218
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_weap_minigun", &__init__, undefined, undefined);
}

// Namespace zm_weap_minigun/zm_weap_minigun
// Params 0, eflags: 0x0
// Checksum 0x7fd3ba9, Offset: 0x260
// Size: 0x224
function __init__() {
    clientfield::register("toplayer", "hero_minigun_vigor_postfx", 1, 1, "counter");
    clientfield::register("allplayers", "minigun_launcher_muzzle_fx", 1, 1, "counter");
    clientfield::register("missile", "minigun_nuke_rob", 1, 1, "int");
    level.hero_weapon[#"minigun"][0] = getweapon(#"hero_minigun_t8_lv1");
    level.hero_weapon[#"minigun"][1] = getweapon(#"hero_minigun_t8_lv2");
    level.hero_weapon[#"minigun"][2] = getweapon(#"hero_minigun_t8_lv3");
    zm_loadout::register_hero_weapon_for_level(#"hero_minigun_t8_lv1");
    zm_loadout::register_hero_weapon_for_level(#"hero_minigun_t8_lv2");
    zm_loadout::register_hero_weapon_for_level(#"hero_minigun_t8_lv3");
    level._effect[#"launcher_flash"] = #"hash_65b54823a8e8631e";
    callback::on_connect(&function_49274842);
    zm::register_actor_damage_callback(&function_940f012a);
}

// Namespace zm_weap_minigun/zm_weap_minigun
// Params 2, eflags: 0x0
// Checksum 0x329ef49f, Offset: 0x490
// Size: 0xcc
function function_fbb0b0cc(weapon, var_be5b1c67 = 1) {
    if (weapon == level.hero_weapon[#"minigun"][2]) {
        return true;
    }
    if (weapon == level.hero_weapon[#"minigun"][1] && var_be5b1c67 < 3) {
        return true;
    }
    if (weapon == level.hero_weapon[#"minigun"][0] && var_be5b1c67 < 2) {
        return true;
    }
    return false;
}

// Namespace zm_weap_minigun/zm_weap_minigun
// Params 0, eflags: 0x4
// Checksum 0x15bb923d, Offset: 0x568
// Size: 0x300
function private function_49274842() {
    self endon(#"disconnect");
    self thread function_f720d6ee();
    while (true) {
        waitresult = self waittill(#"weapon_change");
        wpn_cur = waitresult.weapon;
        wpn_prev = waitresult.last_weapon;
        if (isinarray(level.hero_weapon[#"minigun"], wpn_cur)) {
            self clientfield::increment_to_player("hero_minigun_vigor_postfx");
            self function_349349ac(1);
            self thread function_6ae464c3();
            self thread function_ec432ee0(wpn_cur);
        } else if (isinarray(level.hero_weapon[#"minigun"], wpn_prev)) {
            self thread function_98bbace8(wpn_prev);
        }
        if (wpn_cur == level.hero_weapon[#"minigun"][0]) {
            zm_hero_weapon::show_hint(wpn_cur, #"hash_6933501bf415a72c");
            continue;
        }
        if (wpn_cur == level.hero_weapon[#"minigun"][1]) {
            zm_hero_weapon::show_hint(wpn_cur, #"hash_30df02915fdc6a67");
            self thread function_bae5b3f5(wpn_cur);
            self thread function_d145c1c1(wpn_cur);
            continue;
        }
        if (wpn_cur == level.hero_weapon[#"minigun"][2]) {
            if (!self gamepadusedlast()) {
                self zm_hero_weapon::show_hint(wpn_cur, #"hash_53f4514d440c7816");
            } else {
                self zm_hero_weapon::show_hint(wpn_cur, #"hash_407cc98232081886");
            }
            self thread function_bae5b3f5(wpn_cur);
            self thread function_77d172b1(wpn_cur);
            self thread function_28e4f6c8(wpn_cur);
        }
    }
}

// Namespace zm_weap_minigun/zm_weap_minigun
// Params 0, eflags: 0x4
// Checksum 0xfbc0b71f, Offset: 0x870
// Size: 0x90
function private function_f720d6ee() {
    self endon(#"disconnect");
    while (true) {
        waitresult = self waittill(#"hero_weapon_give");
        var_1cf82592 = waitresult.weapon;
        if (function_fbb0b0cc(var_1cf82592, 2)) {
            self clientfield::increment_to_player("hero_minigun_vigor_postfx");
        }
    }
}

// Namespace zm_weap_minigun/zm_weap_minigun
// Params 1, eflags: 0x4
// Checksum 0x1bd2a166, Offset: 0x908
// Size: 0x86
function private function_98bbace8(w_minigun) {
    self endon(#"disconnect");
    n_slot = self gadgetgetslot(w_minigun);
    while (self function_49de461b(n_slot)) {
        waitframe(1);
    }
    self function_349349ac(0);
    self notify(#"hero_minigun_expired");
}

// Namespace zm_weap_minigun/zm_weap_minigun
// Params 12, eflags: 0x0
// Checksum 0xa0f3d813, Offset: 0x998
// Size: 0x20e
function function_940f012a(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
    if (isplayer(attacker)) {
        if (isdefined(weapon)) {
            switch (weapon.name) {
            case #"hash_492e530f9862f6cc":
                if (isalive(self)) {
                    switch (self.var_29ed62b2) {
                    case #"basic":
                        if (isdefined(level.no_gib_in_wolf_area) && isdefined(self [[ level.no_gib_in_wolf_area ]]()) && self [[ level.no_gib_in_wolf_area ]]()) {
                            self.no_gib = 1;
                        }
                        if (!(isdefined(self.no_gib) && self.no_gib)) {
                            self zombie_utility::gib_random_parts();
                        }
                        return self.health;
                    case #"popcorn":
                        return self.health;
                    }
                }
                break;
            case #"hash_628d99860c78650f":
                if (isalive(self)) {
                    switch (self.var_29ed62b2) {
                    case #"popcorn":
                    case #"basic":
                        return 0;
                    }
                }
                break;
            }
        }
    }
    return -1;
}

// Namespace zm_weap_minigun/zm_weap_minigun
// Params 0, eflags: 0x4
// Checksum 0x420ea67b, Offset: 0xbb0
// Size: 0x3b2
function private function_6ae464c3() {
    if (self.var_6d7e825f === 1) {
        self.var_5acc4c7b = 1;
        self set_armor(100);
        self.var_307a0e18 = 40;
    }
    foreach (e_player in level.players) {
        if (distancesquared(e_player.origin, self.origin) <= 1048576 && abs(e_player.origin[2] - self.origin[2] <= 360)) {
            if ((!isdefined(e_player.var_6d7e825f) || e_player.var_6d7e825f !== 1) && !e_player laststand::player_is_in_laststand() && !(isdefined(e_player.var_5acc4c7b) && e_player.var_5acc4c7b)) {
                e_player set_armor(100);
            }
        }
    }
    while (isalive(self) && self.var_6d7e825f === 1) {
        foreach (e_player in level.players) {
            if (distancesquared(e_player.origin, self.origin) <= 1048576) {
                if ((!isdefined(e_player.var_6d7e825f) || e_player.var_6d7e825f !== 1) && !e_player laststand::player_is_in_laststand() && !(isdefined(e_player.var_5acc4c7b) && e_player.var_5acc4c7b)) {
                    e_player.var_5acc4c7b = 1;
                    e_player.var_307a0e18 = 40;
                }
                continue;
            }
            if (isdefined(e_player.var_5acc4c7b) && e_player.var_5acc4c7b) {
                e_player.var_5acc4c7b = undefined;
                e_player.var_307a0e18 = undefined;
            }
        }
        waitframe(1);
    }
    foreach (e_player in level.players) {
        if (isdefined(e_player.var_5acc4c7b) && e_player.var_5acc4c7b) {
            e_player.var_5acc4c7b = undefined;
            e_player.var_307a0e18 = undefined;
        }
    }
}

// Namespace zm_weap_minigun/zm_weap_minigun
// Params 1, eflags: 0x4
// Checksum 0x4700d2bb, Offset: 0xf70
// Size: 0x3c
function private set_armor(n_armor) {
    self thread zm_utility::add_armor(#"hash_5f20c4863d715164", n_armor, 100);
}

// Namespace zm_weap_minigun/zm_weap_minigun
// Params 1, eflags: 0x0
// Checksum 0x6052dfa1, Offset: 0xfb8
// Size: 0x7c
function function_ec432ee0(w_minigun) {
    self endon(#"bled_out", #"death", #"hero_minigun_expired");
    while (true) {
        s_result = self waittill(#"weapon_fired");
        if (s_result.weapon == w_minigun) {
        }
    }
}

// Namespace zm_weap_minigun/zm_weap_minigun
// Params 1, eflags: 0x0
// Checksum 0xc4d283ba, Offset: 0x1040
// Size: 0x226
function function_bae5b3f5(w_minigun) {
    self endon(#"bled_out", #"death", #"hero_minigun_expired");
    while (true) {
        s_result = self waittill(#"weapon_melee_power_left");
        if (s_result.weapon == w_minigun) {
            var_5226fe3 = self gettagorigin("tag_flash2");
            v_forward_angles = anglestoforward(self getplayerangles());
            v_up = anglestoup(self getplayerangles());
            var_e478827f = v_up * 10;
            var_e21e47be = anglestoright(self getplayerangles()) * 5;
            clientfield::increment("minigun_launcher_muzzle_fx");
            var_8e391fc5 = v_forward_angles[0] * 1650;
            var_6836a55c = v_forward_angles[1] * 1650;
            var_da3e1497 = v_forward_angles[2] * 1650 + 250;
            var_8e9fb2c5 = (var_8e391fc5, var_6836a55c, var_da3e1497);
            self magicgrenadetype(getweapon(#"hash_492e530f9862f6cc"), var_5226fe3 + var_e478827f + var_e21e47be, var_8e9fb2c5);
            waitframe(1);
        }
    }
}

// Namespace zm_weap_minigun/zm_weap_minigun
// Params 1, eflags: 0x0
// Checksum 0x80ea9bd2, Offset: 0x1270
// Size: 0x49a
function function_77d172b1(w_minigun) {
    self endon(#"bled_out", #"death", #"hero_minigun_expired");
    while (true) {
        s_result = self waittill(#"weapon_melee");
        if (s_result.weapon === w_minigun && s_result._notify == "weapon_melee") {
            self playsoundontag("wpn_minigun_lvl3_throw", "j_head");
            wait 1.35;
            self ability_player::function_184edba5(w_minigun);
            var_5226fe3 = self gettagorigin("tag_weapon_right");
            var_5226fe3 += (0, 0, 15);
            v_forward_angles = anglestoforward(self getplayerangles());
            var_8e391fc5 = v_forward_angles[0] * 850;
            var_6836a55c = v_forward_angles[1] * 850;
            var_da3e1497 = v_forward_angles[2] * 850 + 150;
            var_8e9fb2c5 = (var_8e391fc5, var_6836a55c, var_da3e1497);
            var_65f5946c = (0, 0, 12);
            e_grenade = self magicgrenadetype(getweapon(#"hash_628d99860c78650f"), var_5226fe3, var_8e9fb2c5, 2);
            while (isdefined(e_grenade)) {
                s_result = e_grenade waittilltimeout(4, #"stationary", #"death");
                if (isdefined(e_grenade)) {
                    if (s_result._notify == "stationary") {
                        v_ground_pos = groundtrace(e_grenade.origin + (0, 0, 50), e_grenade.origin + (0, 0, -500), 0, e_grenade, 0, 0)[#"position"];
                        if (isdefined(v_ground_pos)) {
                            v_end_pos = getclosestpointonnavmesh(v_ground_pos, 128, 24);
                            if (isdefined(v_end_pos)) {
                                e_grenade.origin = v_end_pos + var_65f5946c;
                            } else {
                                e_grenade.origin = v_ground_pos + var_65f5946c;
                            }
                        } else {
                            v_end_pos = e_grenade.origin;
                        }
                        e_grenade clientfield::set("minigun_nuke_rob", 1);
                        e_grenade playloopsound("wpn_minigun_nuke_riser");
                        continue;
                    }
                    if (s_result._notify == "timeout") {
                        v_end_pos = e_grenade.origin;
                        e_grenade delete();
                        break;
                    }
                    e_grenade clientfield::set("minigun_nuke_rob", 0);
                }
            }
            if (!isdefined(v_end_pos)) {
                v_end_pos = self.origin + anglestoforward(self.angles) * 128;
            }
            self thread function_b4d2b579(v_end_pos, w_minigun);
            self gadgetpowerset(self gadgetgetslot(w_minigun), 0);
            self ability_player::function_281eba9f(w_minigun);
            self notify(#"hero_minigun_expired");
        }
    }
}

// Namespace zm_weap_minigun/zm_weap_minigun
// Params 2, eflags: 0x0
// Checksum 0xfe823ee0, Offset: 0x1718
// Size: 0x6a0
function function_b4d2b579(v_end_pos, w_minigun) {
    level thread zm_powerup_nuke::nuke_flash(self.team);
    if (!isdefined(v_end_pos)) {
        v_end_pos = self.origin;
    }
    var_dd7aa766 = [];
    var_8692bda1 = 0;
    a_ai_zombies = array::get_all_closest(v_end_pos, getaiteamarray(level.zombie_team), undefined, undefined, 4096);
    for (i = 0; i < a_ai_zombies.size; i++) {
        if (isdefined(a_ai_zombies[i].ignore_nuke) && a_ai_zombies[i].ignore_nuke || isdefined(a_ai_zombies[i].marked_for_death) && a_ai_zombies[i].marked_for_death || zm_utility::is_magic_bullet_shield_enabled(a_ai_zombies[i])) {
            continue;
        }
        if (a_ai_zombies[i].var_29ed62b2 == #"basic" || a_ai_zombies[i].var_29ed62b2 == #"popcorn") {
            if (isdefined(a_ai_zombies[i].var_b7fcaf8e)) {
                var_8692bda1 += a_ai_zombies[i].var_b7fcaf8e;
                a_ai_zombies[i].var_b7fcaf8e = 0;
            }
            a_ai_zombies[i].marked_for_death = 1;
            a_ai_zombies[i] clientfield::set("zm_nuked", 1);
            a_ai_zombies[i] zombie_utility::set_zombie_run_cycle_override_value("walk");
        }
        if (!isdefined(var_dd7aa766)) {
            var_dd7aa766 = [];
        } else if (!isarray(var_dd7aa766)) {
            var_dd7aa766 = array(var_dd7aa766);
        }
        if (!isinarray(var_dd7aa766, a_ai_zombies[i])) {
            var_dd7aa766[var_dd7aa766.size] = a_ai_zombies[i];
        }
    }
    for (i = 0; i < var_dd7aa766.size; i++) {
        wait randomfloatrange(0.1, 0.3);
        if (!isdefined(var_dd7aa766[i])) {
            continue;
        }
        if (zm_utility::is_magic_bullet_shield_enabled(var_dd7aa766[i])) {
            continue;
        }
        if (var_dd7aa766[i].var_29ed62b2 == #"basic") {
            if (!(isdefined(var_dd7aa766[i].no_gib) && var_dd7aa766[i].no_gib)) {
                var_dd7aa766[i] zombie_utility::zombie_head_gib();
            }
            var_dd7aa766[i] playsound(#"evt_nuked");
            var_dd7aa766[i] dodamage(var_dd7aa766[i].health + 100, v_end_pos, undefined, undefined, "torso_lower", "MOD_BURNED", 0, w_minigun);
            continue;
        }
        if (var_dd7aa766[i].var_29ed62b2 == #"popcorn") {
            var_dd7aa766[i] playsound(#"evt_nuked");
            var_dd7aa766[i] dodamage(var_dd7aa766[i].health + 100, v_end_pos, undefined, undefined, "none", "MOD_BURNED", 0, w_minigun);
            continue;
        }
        if (var_dd7aa766[i].var_29ed62b2 == #"miniboss" || var_dd7aa766[i].var_29ed62b2 == #"boss") {
            if (isdefined(self.maxhealth)) {
                var_821b5652 = var_dd7aa766[i].maxhealth * 0.25;
            } else {
                var_821b5652 = var_dd7aa766[i].health * 0.25;
            }
            var_dd7aa766[i] dodamage(var_821b5652, v_end_pos, undefined, undefined, "torso_lower", "MOD_BURNED", 0, w_minigun);
        }
    }
    n_score = 0;
    if (var_8692bda1 > 0) {
        n_score = int(var_8692bda1 * 1 / level.players.size);
    }
    if (level.players.size == 1 && n_score > 400) {
        n_score = 400;
    }
    foreach (e_player in level.players) {
        e_player zm_score::add_to_player_score(n_score);
    }
}

// Namespace zm_weap_minigun/zm_weap_minigun
// Params 1, eflags: 0x0
// Checksum 0x3953ddbc, Offset: 0x1dc0
// Size: 0x1a
function function_349349ac(var_6d7e825f) {
    self.var_6d7e825f = var_6d7e825f;
}

// Namespace zm_weap_minigun/zm_weap_minigun
// Params 1, eflags: 0x0
// Checksum 0x5a53b326, Offset: 0x1de8
// Size: 0xa4
function function_d145c1c1(w_minigun) {
    self endon(#"bled_out", #"death", #"hero_minigun_expired");
    s_result = self waittill(#"weapon_melee_power_left");
    if (s_result.weapon == w_minigun) {
        self thread zm_audio::create_and_play_dialog(#"hero_level_2", #"minigun");
    }
}

// Namespace zm_weap_minigun/zm_weap_minigun
// Params 1, eflags: 0x0
// Checksum 0x746c1a3f, Offset: 0x1e98
// Size: 0xbc
function function_28e4f6c8(w_minigun) {
    self endon(#"bled_out", #"death", #"hero_minigun_expired");
    s_result = self waittill(#"weapon_melee");
    if (s_result.weapon === w_minigun && s_result._notify == "weapon_melee") {
        self thread zm_audio::create_and_play_dialog(#"hero_level_3", #"minigun");
    }
}

