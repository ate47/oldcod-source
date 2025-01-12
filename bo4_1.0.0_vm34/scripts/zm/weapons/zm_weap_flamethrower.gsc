#using scripts\abilities\ability_player;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_hero_weapon;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_utility;

#namespace zm_weap_flamethrower;

// Namespace zm_weap_flamethrower/zm_weap_flamethrower
// Params 0, eflags: 0x2
// Checksum 0xa35606dc, Offset: 0x248
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_weap_flamethrower", &__init__, undefined, undefined);
}

// Namespace zm_weap_flamethrower/zm_weap_flamethrower
// Params 0, eflags: 0x0
// Checksum 0x31fd6288, Offset: 0x290
// Size: 0x29e
function __init__() {
    level.hero_weapon[#"flamethrower"][0] = getweapon(#"hero_flamethrower_t8_lv1");
    level.hero_weapon[#"flamethrower"][1] = getweapon(#"hero_flamethrower_t8_lv2");
    level.hero_weapon[#"flamethrower"][2] = getweapon(#"hero_flamethrower_t8_lv3");
    zm_loadout::register_hero_weapon_for_level(#"hero_flamethrower_t8_lv1");
    zm_loadout::register_hero_weapon_for_level(#"hero_flamethrower_t8_lv2");
    zm_loadout::register_hero_weapon_for_level(#"hero_flamethrower_t8_lv3");
    clientfield::register("scriptmover", "flamethrower_tornado_fx", 1, 1, "int");
    clientfield::register("actor", "flamethrower_corpse_fx", 1, 1, "int");
    clientfield::register("toplayer", "hero_flamethrower_vigor_postfx", 1, 1, "counter");
    clientfield::register("toplayer", "flamethrower_wind_blast_flash", 1, 1, "counter");
    clientfield::register("toplayer", "flamethrower_tornado_blast_flash", 1, 1, "counter");
    callback::on_connect(&function_a52234bd);
    zm::register_zombie_damage_override_callback(&function_6820009c);
    zm_utility::register_slowdown(#"hash_6ff4731de876ab68", 0.6, 1);
    level.n_zombies_lifted_for_ragdoll = 0;
    level.var_640dcc3f = 0;
}

// Namespace zm_weap_flamethrower/zm_weap_flamethrower
// Params 2, eflags: 0x0
// Checksum 0x319f0ce8, Offset: 0x538
// Size: 0xcc
function is_flamethrower_weapon(weapon, var_be5b1c67 = 1) {
    if (weapon == level.hero_weapon[#"flamethrower"][2]) {
        return true;
    }
    if (weapon == level.hero_weapon[#"flamethrower"][1] && var_be5b1c67 < 3) {
        return true;
    }
    if (weapon == level.hero_weapon[#"flamethrower"][0] && var_be5b1c67 < 2) {
        return true;
    }
    return false;
}

// Namespace zm_weap_flamethrower/zm_weap_flamethrower
// Params 0, eflags: 0x4
// Checksum 0x97baf669, Offset: 0x610
// Size: 0x310
function private function_a52234bd() {
    self endon(#"disconnect");
    self thread function_47eed2f9();
    while (true) {
        waitresult = self waittill(#"weapon_change");
        wpn_cur = waitresult.weapon;
        wpn_prev = waitresult.last_weapon;
        if (isinarray(level.hero_weapon[#"flamethrower"], wpn_cur)) {
            self clientfield::increment_to_player("hero_flamethrower_vigor_postfx");
            self function_80d03485(1);
            self thread function_6ae464c3();
            self thread function_50cfbaa3(wpn_cur);
        } else if (isinarray(level.hero_weapon[#"flamethrower"], wpn_prev)) {
            self function_80d03485(0);
            self notify(#"hero_flamethrower_expired");
        }
        if (wpn_cur == level.hero_weapon[#"flamethrower"][0]) {
            zm_hero_weapon::show_hint(wpn_cur, #"hash_258f60f733c7a181");
            continue;
        }
        if (wpn_cur == level.hero_weapon[#"flamethrower"][1]) {
            zm_hero_weapon::show_hint(wpn_cur, #"hash_4c83bb6fd69bf1ea");
            self thread function_89511a02(wpn_cur);
            self thread function_d145c1c1(wpn_cur);
            continue;
        }
        if (wpn_cur == level.hero_weapon[#"flamethrower"][2]) {
            if (!self gamepadusedlast()) {
                self zm_hero_weapon::show_hint(wpn_cur, #"hash_1a1e29920a655055");
            } else {
                self zm_hero_weapon::show_hint(wpn_cur, #"hash_43cbc37ab728289b");
            }
            self thread function_89511a02(wpn_cur);
            self thread function_8d23e5f5(wpn_cur);
            self thread function_28e4f6c8(wpn_cur);
        }
    }
}

// Namespace zm_weap_flamethrower/zm_weap_flamethrower
// Params 0, eflags: 0x4
// Checksum 0xa5d6e6f9, Offset: 0x928
// Size: 0x90
function private function_47eed2f9() {
    self endon(#"disconnect");
    while (true) {
        waitresult = self waittill(#"hero_weapon_give");
        var_1cf82592 = waitresult.weapon;
        if (is_flamethrower_weapon(var_1cf82592, 2)) {
            self clientfield::increment_to_player("hero_flamethrower_vigor_postfx");
        }
    }
}

// Namespace zm_weap_flamethrower/zm_weap_flamethrower
// Params 13, eflags: 0x0
// Checksum 0xced2d22d, Offset: 0x9c0
// Size: 0x1c8
function function_6820009c(willbekilled, einflictor, eattacker, idamage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
    if (isplayer(eattacker) && isdefined(eattacker.var_2b545acc) && eattacker.var_2b545acc && !(isdefined(self.is_on_fire) && self.is_on_fire)) {
        if (randomint(100) <= 15) {
            self zm_spawner::zombie_flame_damage("MOD_BURNED", eattacker);
            return 0;
        }
    }
    if (isplayer(eattacker) && is_flamethrower_weapon(weapon, 1) && !(isdefined(self.var_1d6a1b01) && self.var_1d6a1b01) && meansofdeath === "MOD_BURNED") {
        self thread function_70b80326(eattacker);
        if (isdefined(willbekilled) && willbekilled && self.var_29ed62b2 == #"basic") {
            self thread function_48b4696c();
        }
    }
    return idamage;
}

// Namespace zm_weap_flamethrower/zm_weap_flamethrower
// Params 1, eflags: 0x4
// Checksum 0x71ca073, Offset: 0xb90
// Size: 0x136
function private function_70b80326(eattacker) {
    self endon(#"death");
    self.var_1d6a1b01 = 1;
    if (self.var_29ed62b2 == #"miniboss" || self.var_29ed62b2 == #"popcorn") {
        self thread zm_utility::function_447d3917(#"hash_6ff4731de876ab68");
        wait 1;
    } else if (self.var_29ed62b2 == #"boss") {
        wait 1;
    } else if (self.var_29ed62b2 == #"basic") {
        self zombie_utility::set_zombie_run_cycle_override_value("walk");
        while (isdefined(self.is_on_fire) && self.is_on_fire) {
            wait 1;
        }
        self zombie_utility::set_zombie_run_cycle_restore_from_override();
    }
    self.var_1d6a1b01 = undefined;
}

// Namespace zm_weap_flamethrower/zm_weap_flamethrower
// Params 1, eflags: 0x4
// Checksum 0x787b5214, Offset: 0xcd0
// Size: 0x6c
function private function_87fbd40(v_position) {
    self endon(#"death");
    if (self.var_29ed62b2 !== #"basic" || isdefined(self.knockdown) && self.knockdown) {
        return;
    }
    zombie_utility::setup_zombie_knockdown(v_position);
}

// Namespace zm_weap_flamethrower/zm_weap_flamethrower
// Params 0, eflags: 0x4
// Checksum 0xe0c3ffe5, Offset: 0xd48
// Size: 0x168
function private function_48b4696c() {
    if (level.var_640dcc3f > 8) {
        return;
    }
    self clientfield::set("flamethrower_corpse_fx", 1);
    s_result = self waittilltimeout(10, #"actor_corpse");
    if (isdefined(self)) {
        self clientfield::set("flamethrower_corpse_fx", 0);
    }
    if (s_result._notify == "actor_corpse") {
        if (isdefined(s_result.corpse)) {
            e_corpse = s_result.corpse;
            e_corpse thread function_14d919a1();
            e_corpse clientfield::set("flamethrower_corpse_fx", 1);
            e_corpse waittilltimeout(randomfloatrange(1.5, 6), #"death");
            if (isdefined(e_corpse)) {
                e_corpse clientfield::set("flamethrower_corpse_fx", 0);
                e_corpse notify(#"hash_244b83097f062847");
            }
        }
    }
}

// Namespace zm_weap_flamethrower/zm_weap_flamethrower
// Params 0, eflags: 0x4
// Checksum 0x21d53d59, Offset: 0xeb8
// Size: 0x48
function private function_14d919a1() {
    level.var_640dcc3f++;
    s_result = self waittill(#"death", #"hash_244b83097f062847");
    level.var_640dcc3f--;
}

// Namespace zm_weap_flamethrower/zm_weap_flamethrower
// Params 0, eflags: 0x4
// Checksum 0xf5252678, Offset: 0xf08
// Size: 0x23a
function private function_6ae464c3() {
    while (isalive(self) && self.var_f98a1470 === 1) {
        foreach (e_player in level.players) {
            if (distancesquared(e_player.origin, self.origin) <= 1048576 && abs(e_player.origin[2] - self.origin[2] <= 360)) {
                if ((!isdefined(e_player.var_f98a1470) || e_player.var_f98a1470 !== 1) && !e_player laststand::player_is_in_laststand() && !(isdefined(e_player.var_2b545acc) && e_player.var_2b545acc)) {
                    e_player.var_2b545acc = 1;
                }
                continue;
            }
            if (isdefined(e_player.var_2b545acc) && e_player.var_2b545acc) {
                e_player.var_2b545acc = undefined;
            }
        }
        waitframe(1);
    }
    foreach (e_player in level.players) {
        if (isdefined(e_player.var_2b545acc) && e_player.var_2b545acc) {
            e_player.var_2b545acc = undefined;
        }
    }
}

// Namespace zm_weap_flamethrower/zm_weap_flamethrower
// Params 1, eflags: 0x0
// Checksum 0xb4d90151, Offset: 0x1150
// Size: 0x7c
function function_50cfbaa3(w_flamethrower) {
    self endon(#"bled_out", #"death", #"hero_flamethrower_expired");
    while (true) {
        s_result = self waittill(#"weapon_fired");
        if (s_result.weapon == w_flamethrower) {
        }
    }
}

// Namespace zm_weap_flamethrower/zm_weap_flamethrower
// Params 1, eflags: 0x0
// Checksum 0xc907b924, Offset: 0x11d8
// Size: 0xb0
function function_89511a02(w_flamethrower) {
    self endon(#"bled_out", #"death", #"hero_flamethrower_expired");
    while (true) {
        s_result = self waittill(#"weapon_melee_power_left");
        if (s_result.weapon == w_flamethrower) {
            self clientfield::increment_to_player("flamethrower_wind_blast_flash");
            self thread function_dbc257f9(w_flamethrower);
        }
    }
}

// Namespace zm_weap_flamethrower/zm_weap_flamethrower
// Params 1, eflags: 0x0
// Checksum 0xabaa7c89, Offset: 0x1290
// Size: 0x2dc
function function_dbc257f9(w_flamethrower) {
    var_673f4580 = [];
    var_20a550ba = [];
    var_7dda366c = self getweaponmuzzlepoint();
    v_forward_angles = self getweaponforwarddir();
    self playrumbleonentity("grenade_rumble");
    a_ai_zombies = util::get_array_of_closest(var_7dda366c, getaispeciesarray(level.zombie_team), undefined, undefined, 400);
    foreach (ai_zombie in a_ai_zombies) {
        if (isdefined(ai_zombie sightconetrace(var_7dda366c, self, v_forward_angles, 25)) && ai_zombie sightconetrace(var_7dda366c, self, v_forward_angles, 25)) {
            if (distance(ai_zombie.origin, self.origin) <= 250) {
                if (!isdefined(var_673f4580)) {
                    var_673f4580 = [];
                } else if (!isarray(var_673f4580)) {
                    var_673f4580 = array(var_673f4580);
                }
                if (!isinarray(var_673f4580, ai_zombie)) {
                    var_673f4580[var_673f4580.size] = ai_zombie;
                }
                self.var_8231e15e = 1;
                continue;
            }
            if (!isdefined(var_20a550ba)) {
                var_20a550ba = [];
            } else if (!isarray(var_20a550ba)) {
                var_20a550ba = array(var_20a550ba);
            }
            if (!isinarray(var_20a550ba, ai_zombie)) {
                var_20a550ba[var_20a550ba.size] = ai_zombie;
            }
        }
    }
    array::thread_all(var_673f4580, &function_18eef05b, self, w_flamethrower);
    array::thread_all(var_20a550ba, &function_87fbd40, self.origin);
}

// Namespace zm_weap_flamethrower/zm_weap_flamethrower
// Params 2, eflags: 0x0
// Checksum 0x7d0a90b7, Offset: 0x1578
// Size: 0x434
function function_18eef05b(e_player, w_flamethrower) {
    if (self.var_29ed62b2 == #"miniboss" || self.var_29ed62b2 == #"boss") {
        self thread function_70b80326(e_player);
        self dodamage(self.maxhealth * 0.1, e_player.origin, e_player, e_player, "torso_lower", "MOD_IMPACT", 0, w_flamethrower);
        return;
    }
    if (self.var_29ed62b2 == #"basic") {
        n_dist = distance2d(self.origin, e_player.origin);
        if (n_dist <= 64) {
            if (isdefined(level.no_gib_in_wolf_area) && isdefined(self [[ level.no_gib_in_wolf_area ]]()) && self [[ level.no_gib_in_wolf_area ]]()) {
                self.no_gib = 1;
            }
            if (!(isdefined(self.no_gib) && self.no_gib)) {
                gibserverutils::annihilate(self);
            }
            self dodamage(self.health + 100, e_player.origin, e_player, e_player, "torso_lower", "MOD_IMPACT", 0, w_flamethrower);
            return;
        } else if (math::cointoss()) {
            if (isdefined(level.no_gib_in_wolf_area) && isdefined(self [[ level.no_gib_in_wolf_area ]]()) && self [[ level.no_gib_in_wolf_area ]]()) {
                self.no_gib = 1;
            }
            if (!(isdefined(self.no_gib) && self.no_gib)) {
                self zombie_utility::gib_random_parts();
            }
        }
        if (isdefined(level.no_gib_in_wolf_area) && isdefined(self [[ level.no_gib_in_wolf_area ]]()) && self [[ level.no_gib_in_wolf_area ]]()) {
            self dodamage(self.health + 100, e_player.origin, e_player, e_player, "torso_lower", "MOD_IMPACT", 0, w_flamethrower);
            return;
        }
        v_dir = self.origin - e_player.origin;
        var_e9481891 = 75 * vectornormalize(v_dir);
        var_e9481891 = (var_e9481891[0], var_e9481891[1], 20);
        self startragdoll();
        self launchragdoll(var_e9481891);
        self dodamage(self.health + 100, e_player.origin, e_player, e_player, "torso_lower", "MOD_IMPACT", 0, w_flamethrower);
        return;
    }
    if (self.var_29ed62b2 == #"popcorn") {
        self dodamage(self.health + 100, e_player.origin, e_player, e_player, undefined, "MOD_IMPACT", 0, w_flamethrower);
    }
}

// Namespace zm_weap_flamethrower/zm_weap_flamethrower
// Params 1, eflags: 0x0
// Checksum 0x39c7ed2f, Offset: 0x19b8
// Size: 0xb0
function function_8d23e5f5(w_flamethrower) {
    self endon(#"bled_out", #"death", #"hero_flamethrower_expired");
    while (true) {
        s_result = self waittill(#"weapon_melee");
        if (s_result.weapon == w_flamethrower) {
            self clientfield::increment_to_player("flamethrower_tornado_blast_flash");
            self function_8559d26a(w_flamethrower);
        }
    }
}

// Namespace zm_weap_flamethrower/zm_weap_flamethrower
// Params 1, eflags: 0x0
// Checksum 0x78c1934b, Offset: 0x1a70
// Size: 0x4ac
function function_8559d26a(w_flamethrower) {
    self notify(#"hash_2ca901b5ada4f20f");
    self endon(#"bled_out", #"death", #"hero_flamethrower_expired", #"hash_2ca901b5ada4f20f");
    var_86ae018a = [];
    var_7dda366c = self getweaponmuzzlepoint();
    v_forward_angles = self getweaponforwarddir();
    var_9af2eac0 = var_7dda366c + v_forward_angles * 40;
    var_9af2eac0 = getclosestpointonnavmesh(var_9af2eac0, 128, 16);
    if (!isdefined(var_9af2eac0)) {
        var_9af2eac0 = var_7dda366c;
    }
    s_trace = groundtrace(var_9af2eac0 + (0, 0, 100), var_9af2eac0 + (0, 0, -1000), 0, undefined, 0);
    if (!isdefined(self.var_8f4c892)) {
        self.var_8f4c892 = util::spawn_model("tag_origin");
        util::wait_network_frame();
    }
    self.var_8f4c892.origin = s_trace[#"position"];
    self.var_8f4c892.angles = self.angles;
    self.var_8f4c892.v_start = self.var_8f4c892.origin;
    if (!isdefined(self.var_8f4c892.t_damage)) {
        self.var_8f4c892.t_damage = spawn("trigger_radius_new", self.var_8f4c892.origin, 512 | 1, 80, 128);
        self.var_8f4c892.t_damage enablelinkto();
        self.var_8f4c892.t_damage linkto(self.var_8f4c892);
    }
    self thread function_357ddf06();
    if (self.var_8f4c892 clientfield::get("flamethrower_tornado_fx")) {
        self.var_8f4c892 clientfield::set("flamethrower_tornado_fx", 0);
        util::wait_network_frame();
    }
    self.var_8f4c892 clientfield::set("flamethrower_tornado_fx", 1);
    a_ai_zombies = util::get_array_of_closest(var_9af2eac0, getaispeciesarray(level.zombie_team), undefined, undefined, 400);
    foreach (ai_zombie in a_ai_zombies) {
        if (isdefined(ai_zombie sightconetrace(var_7dda366c, self, v_forward_angles, 25)) && ai_zombie sightconetrace(var_7dda366c, self, v_forward_angles, 25)) {
            if (!isdefined(var_86ae018a)) {
                var_86ae018a = [];
            } else if (!isarray(var_86ae018a)) {
                var_86ae018a = array(var_86ae018a);
            }
            if (!isinarray(var_86ae018a, ai_zombie)) {
                var_86ae018a[var_86ae018a.size] = ai_zombie;
            }
        }
    }
    self.var_8f4c892 thread function_52fc67e6(v_forward_angles, var_86ae018a);
    self thread function_9597835f();
}

// Namespace zm_weap_flamethrower/zm_weap_flamethrower
// Params 0, eflags: 0x0
// Checksum 0xb8da386d, Offset: 0x1f28
// Size: 0xcc
function function_9597835f() {
    self endon(#"hash_2ca901b5ada4f20f");
    self waittill(#"death", #"hero_flamethrower_expired");
    self notify(#"hash_751e0293eed9a1cf");
    self.var_8f4c892 clientfield::set("flamethrower_tornado_fx", 0);
    waitframe(1);
    if (isdefined(self.var_8f4c892.t_damage)) {
        self.var_8f4c892.t_damage delete();
    }
    self.var_8f4c892 delete();
}

// Namespace zm_weap_flamethrower/zm_weap_flamethrower
// Params 2, eflags: 0x0
// Checksum 0x3dc6507a, Offset: 0x2000
// Size: 0x712
function function_52fc67e6(v_forward_angles, var_86ae018a) {
    self endon(#"death", #"hash_2ca901b5ada4f20f");
    var_b87e5979 = (0, 0, 32);
    var_397f0751 = self.v_start + var_b87e5979;
    var_66814340 = 1;
    v_start_pos = self.v_start + var_b87e5979;
    while (true) {
        if (isdefined(var_66814340) && var_66814340) {
            var_66814340 = undefined;
            var_413a278f = 200;
            if (var_86ae018a.size) {
                ai_zombie = array::random(var_86ae018a);
                v_target_pos = ai_zombie.origin;
                arrayremovevalue(var_86ae018a, ai_zombie);
            } else if (isdefined(bullettracepassed(var_397f0751, var_397f0751 + v_forward_angles * var_413a278f, 0, self)) && bullettracepassed(var_397f0751, var_397f0751 + v_forward_angles * var_413a278f, 0, self)) {
                v_target_pos = var_397f0751 + v_forward_angles * var_413a278f;
            } else {
                v_target_pos = bullettrace(var_397f0751, var_397f0751 + v_forward_angles * var_413a278f, 0, self)[#"position"];
            }
        } else if (var_86ae018a.size) {
            ai_zombie = array::random(var_86ae018a);
            v_target_pos = ai_zombie.origin;
            arrayremovevalue(var_86ae018a, ai_zombie);
        } else {
            v_target_pos = self function_83f98b54(var_397f0751);
        }
        var_ee1f38f7 = getclosestpointonnavmesh(v_target_pos, 512, 16);
        if (isdefined(var_ee1f38f7)) {
            v_target_pos = var_ee1f38f7;
        }
        var_ee1f38f7 = groundtrace(v_target_pos + (0, 0, 100), v_target_pos + (0, 0, -1000), 0, undefined, 0)[#"position"];
        if (isdefined(var_ee1f38f7)) {
            v_target_pos = var_ee1f38f7;
        }
        n_dist = distance(v_start_pos, v_target_pos);
        n_time = n_dist / 100;
        if (n_time <= 0) {
            n_time = 0.5;
        }
        self moveto(v_target_pos, n_time);
        if (isdefined(ai_zombie)) {
            level util::waittill_any_ents(self, "movedone", ai_zombie, "death");
            ai_zombie = undefined;
        } else {
            self waittill(#"movedone");
        }
        v_start_pos = self.origin + var_b87e5979;
        if (var_86ae018a.size) {
            foreach (ai in var_86ae018a) {
                if (isvehicle(ai) && !(isdefined(bullettracepassed(v_start_pos, ai.origin, 0, self)) && bullettracepassed(v_start_pos, ai.origin, 0, self))) {
                    arrayremovevalue(var_86ae018a, ai, 1);
                    continue;
                }
                if (isalive(ai) && !(isdefined(bullettracepassed(v_start_pos, ai geteye(), 0, self)) && bullettracepassed(v_start_pos, ai geteye(), 0, self))) {
                    arrayremovevalue(var_86ae018a, ai, 1);
                }
            }
            var_86ae018a = array::remove_undefined(var_86ae018a);
        }
        if (!var_86ae018a.size) {
            var_86ae018a = util::get_array_of_closest(self.v_start, getaiteamarray(level.zombie_team), undefined, undefined, 400);
            foreach (ai in var_86ae018a) {
                if (isvehicle(ai) && !(isdefined(bullettracepassed(v_start_pos, ai.origin, 0, self)) && bullettracepassed(v_start_pos, ai.origin, 0, self))) {
                    arrayremovevalue(var_86ae018a, ai, 1);
                    continue;
                }
                if (!(isdefined(bullettracepassed(v_start_pos, ai geteye(), 0, self)) && bullettracepassed(v_start_pos, ai geteye(), 0, self))) {
                    arrayremovevalue(var_86ae018a, ai, 1);
                }
            }
            var_86ae018a = array::remove_undefined(var_86ae018a);
        }
    }
}

// Namespace zm_weap_flamethrower/zm_weap_flamethrower
// Params 1, eflags: 0x0
// Checksum 0xe7721e96, Offset: 0x2720
// Size: 0x14a
function function_83f98b54(var_397f0751) {
    self endon(#"death");
    for (var_87a20ad9 = 0; var_87a20ad9 < 4; var_87a20ad9++) {
        v_target_pos = (var_397f0751[0] + randomfloat(400), var_397f0751[1] + randomfloat(400), var_397f0751[2]);
        s_trace = bullettrace(self.origin + (0, 0, 32), v_target_pos, 0, self);
        if (isdefined(s_trace[#"position"])) {
            return s_trace[#"position"];
        }
        if (bullettracepassed(self.origin + (0, 0, 32), v_target_pos, 0, self)) {
            return v_target_pos;
        }
    }
    return var_397f0751;
}

// Namespace zm_weap_flamethrower/zm_weap_flamethrower
// Params 0, eflags: 0x0
// Checksum 0x5b5ec400, Offset: 0x2878
// Size: 0x1b6
function function_357ddf06() {
    self endon(#"disconnect", #"hash_2ca901b5ada4f20f");
    self.var_8f4c892 endon(#"death");
    self.var_8f4c892.t_damage endon(#"death");
    while (true) {
        s_result = self.var_8f4c892.t_damage waittill(#"trigger");
        if (isdefined(s_result.activator.var_f75c9d82) && s_result.activator.var_f75c9d82) {
            continue;
        }
        if (isplayer(s_result.activator)) {
            s_result.activator thread function_76ed1ecc(self.var_8f4c892.t_damage);
        } else if (isinarray(getaiteamarray(level.zombie_team), s_result.activator)) {
            s_result.activator thread function_fc915d6b(self, self.var_8f4c892, 128, randomintrange(128, 200), randomintrange(150, 200));
        }
        waitframe(1);
    }
}

// Namespace zm_weap_flamethrower/zm_weap_flamethrower
// Params 1, eflags: 0x0
// Checksum 0x36b9f192, Offset: 0x2a38
// Size: 0xa6
function function_76ed1ecc(t_damage) {
    self endon(#"disconnect");
    self.var_f75c9d82 = 1;
    self clientfield::set("burn", 1);
    while (isdefined(t_damage) && self istouching(t_damage)) {
        waitframe(1);
    }
    self clientfield::set("burn", 0);
    self.var_f75c9d82 = undefined;
}

// Namespace zm_weap_flamethrower/zm_weap_flamethrower
// Params 5, eflags: 0x4
// Checksum 0x9c935191, Offset: 0x2ae8
// Size: 0x53c
function private function_fc915d6b(e_player, var_9689d9ab, n_push_away, n_lift_height, n_lift_speed) {
    w_flamethrower = e_player.var_c332c9d4;
    self.var_f75c9d82 = 1;
    v_origin = var_9689d9ab.origin;
    if (self.var_29ed62b2 == #"popcorn") {
        self.no_powerups = 1;
        self dodamage(self.health + 100, v_origin, e_player, e_player, undefined, "MOD_BURNED", 0, w_flamethrower);
        return;
    }
    if (self.var_29ed62b2 == #"miniboss" || self.var_29ed62b2 == #"boss") {
        self endon(#"death");
        self thread function_70b80326(e_player);
        self dodamage(self.maxhealth * 0.1, v_origin, e_player, e_player, "none", "MOD_BURNED", 0, w_flamethrower);
        wait 1;
        self.var_f75c9d82 = undefined;
        return;
    }
    if (level.n_zombies_lifted_for_ragdoll < 12) {
        self thread track_lifted_for_ragdoll_count();
        self setplayercollision(0);
        self zm_spawner::zombie_flame_damage("MOD_BURNED", e_player);
        if (var_9689d9ab function_f8647166()) {
            var_9689d9ab thread scene::play(#"aib_vign_zm_mnsn_tornado_zombie", self);
            var_9689d9ab thread function_bd94028b(e_player, self);
            var_410fdabb = scene::function_3dd10dad(#"aib_vign_zm_mnsn_tornado_zombie", "Shot 1");
            n_time = randomfloatrange(2, var_410fdabb);
            e_player waittilltimeout(n_time, #"hash_20d02a4b6d08596d", #"hash_2ca901b5ada4f20f", #"hash_751e0293eed9a1cf");
            if (!isdefined(self)) {
                return;
            }
            self thread scene::stop(#"aib_vign_zm_mnsn_tornado_zombie");
        }
        if (isdefined(level.no_gib_in_wolf_area) && isdefined(self [[ level.no_gib_in_wolf_area ]]()) && self [[ level.no_gib_in_wolf_area ]]()) {
            self dodamage(self.health + 100, v_origin, e_player, e_player, "torso_lower", "MOD_BURNED", 0, w_flamethrower);
            return;
        }
        self zombie_utility::gib_random_parts();
        v_away_from_source = vectornormalize(self.origin - v_origin);
        v_away_from_source *= n_push_away;
        v_away_from_source = (v_away_from_source[0], v_away_from_source[1], n_lift_height);
        if (!(isdefined(level.ignore_gravityspikes_ragdoll) && level.ignore_gravityspikes_ragdoll)) {
            self startragdoll();
            self launchragdoll(100 * anglestoup(self.angles) + (v_away_from_source[0], v_away_from_source[1], 0));
        }
        self clientfield::set("ragdoll_impact_watch", 1);
    } else {
        if (isdefined(level.no_gib_in_wolf_area) && isdefined(self [[ level.no_gib_in_wolf_area ]]()) && self [[ level.no_gib_in_wolf_area ]]()) {
            self.no_gib = 1;
        }
        if (!(isdefined(self.no_gib) && self.no_gib)) {
            gibserverutils::annihilate(self);
        }
    }
    self dodamage(self.health + 100, v_origin, e_player, e_player, "torso_lower", "MOD_BURNED", 0, w_flamethrower);
}

// Namespace zm_weap_flamethrower/zm_weap_flamethrower
// Params 0, eflags: 0x4
// Checksum 0x61d72fd0, Offset: 0x3030
// Size: 0x30
function private track_lifted_for_ragdoll_count() {
    level.n_zombies_lifted_for_ragdoll++;
    self waittill(#"death");
    level.n_zombies_lifted_for_ragdoll--;
}

// Namespace zm_weap_flamethrower/zm_weap_flamethrower
// Params 2, eflags: 0x4
// Checksum 0x93c3ea7, Offset: 0x3068
// Size: 0x70
function private function_bd94028b(e_player, ai_zombie) {
    while (isdefined(self) && isalive(ai_zombie)) {
        if (!self function_f8647166()) {
            e_player notify(#"hash_20d02a4b6d08596d");
            return;
        }
        wait 0.5;
    }
}

// Namespace zm_weap_flamethrower/zm_weap_flamethrower
// Params 0, eflags: 0x4
// Checksum 0x688bbf9e, Offset: 0x30e0
// Size: 0x1be
function private function_f8647166() {
    if (!bullettracepassed(self.origin + (0, 0, 5), self.origin + (0, 0, 128), 0, undefined)) {
        return false;
    }
    if (!bullettracepassed(self.origin + (0, 0, 32), self.origin + anglestoforward(self.angles) * 50, 0, undefined)) {
        return false;
    }
    if (!bullettracepassed(self.origin + (0, 0, 32), self.origin + anglestoforward(self.angles) * 50 * -1, 0, undefined)) {
        return false;
    }
    if (!bullettracepassed(self.origin + (0, 0, 32), self.origin + anglestoright(self.angles) * 50, 0, undefined)) {
        return false;
    }
    if (!bullettracepassed(self.origin + (0, 0, 32), self.origin + anglestoright(self.angles) * 50 * -1, 0, undefined)) {
        return false;
    }
    return true;
}

// Namespace zm_weap_flamethrower/zm_weap_flamethrower
// Params 1, eflags: 0x0
// Checksum 0x9dec55e9, Offset: 0x32a8
// Size: 0x1a
function function_80d03485(var_f98a1470) {
    self.var_f98a1470 = var_f98a1470;
}

// Namespace zm_weap_flamethrower/zm_weap_flamethrower
// Params 1, eflags: 0x0
// Checksum 0x6fa45e0b, Offset: 0x32d0
// Size: 0xa4
function function_d145c1c1(w_flamethrower) {
    self endon(#"bled_out", #"death", #"hero_flamethrower_expired");
    s_result = self waittill(#"weapon_melee_power_left");
    if (s_result.weapon == w_flamethrower) {
        self thread zm_audio::create_and_play_dialog(#"hero_level_2", #"flamethrower");
    }
}

// Namespace zm_weap_flamethrower/zm_weap_flamethrower
// Params 1, eflags: 0x0
// Checksum 0xd134b739, Offset: 0x3380
// Size: 0xa4
function function_28e4f6c8(w_flamethrower) {
    self endon(#"bled_out", #"death", #"hero_flamethrower_expired");
    s_result = self waittill(#"weapon_melee");
    if (s_result.weapon == w_flamethrower) {
        self thread zm_audio::create_and_play_dialog(#"hero_level_3", #"flamethrower");
    }
}

