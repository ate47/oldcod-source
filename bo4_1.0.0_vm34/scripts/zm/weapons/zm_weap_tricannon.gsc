#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_utility;

#namespace zm_weap_tricannon;

// Namespace zm_weap_tricannon/zm_weap_tricannon
// Params 0, eflags: 0x2
// Checksum 0xf6a7615d, Offset: 0x190
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_weap_tricannon", &__init__, undefined, undefined);
}

// Namespace zm_weap_tricannon/zm_weap_tricannon
// Params 0, eflags: 0x0
// Checksum 0x3f6aad44, Offset: 0x1d8
// Size: 0x47a
function __init__() {
    callback::on_ai_damage(&function_2447056e);
    callback::add_weapon_fired(getweapon(#"ww_tricannon_t8"), &function_c80760de);
    callback::add_weapon_fired(getweapon(#"ww_tricannon_t8" + "_upgraded"), &function_c80760de);
    callback::add_weapon_fired(getweapon(#"ww_tricannon_earth_t8"), &function_c19ce653);
    callback::add_weapon_fired(getweapon(#"ww_tricannon_earth_t8" + "_upgraded"), &function_c19ce653);
    callback::add_weapon_fired(getweapon(#"ww_tricannon_air_t8"), &function_ee995e3);
    callback::add_weapon_fired(getweapon(#"ww_tricannon_air_t8" + "_upgraded"), &function_e7a32f06);
    callback::add_weapon_fired(getweapon(#"ww_tricannon_fire_t8"), &function_fe94a0db);
    callback::add_weapon_fired(getweapon(#"ww_tricannon_fire_t8" + "_upgraded"), &function_fe94a0db);
    callback::add_weapon_fired(getweapon(#"ww_tricannon_water_t8"), &function_ca05af54);
    callback::add_weapon_fired(getweapon(#"ww_tricannon_water_t8" + "_upgraded"), &function_ca05af54);
    zm_utility::register_slowdown(#"hash_7dd6cbed104dd8bd", 0.75, 1);
    zm_utility::register_slowdown(#"hash_7eece5e5a5f9cc4d", 0.85, 1);
    zm_utility::register_slowdown(#"hash_64aafe3cc04860be", 0.65, 1);
    zm_utility::register_slowdown(#"hash_111531769a0bf9e", 0.77, 1);
    clientfield::register("actor", "water_tricannon_slow_fx", 1, 1, "int");
    clientfield::register("allplayers", "fire_tricannon_muzzle_fx", 1, 1, "counter");
    clientfield::register("allplayers", "water_tricannon_muzzle_fx", 1, 1, "counter");
    level._effect[#"earth_impact"] = #"hash_4587acdb7cd704b6";
    level._effect[#"fire_impact"] = #"hash_65320106e9ad659c";
}

// Namespace zm_weap_tricannon/zm_weap_tricannon
// Params 1, eflags: 0x0
// Checksum 0x4a641f44, Offset: 0x660
// Size: 0x13c
function function_2447056e(params) {
    if (params.weapon == getweapon(#"ww_tricannon_earth_t8") || params.weapon == getweapon(#"ww_tricannon_earth_t8" + "_upgraded")) {
        self function_4596763c(params);
        return;
    }
    if (params.weapon == getweapon(#"ww_tricannon_fire_t8") || params.weapon == getweapon(#"ww_tricannon_fire_t8" + "_upgraded")) {
        var_80d46313 = self function_5e30bb26(params);
        if (var_80d46313) {
            self function_28fcf5a3(params);
        }
    }
}

// Namespace zm_weap_tricannon/zm_weap_tricannon
// Params 1, eflags: 0x0
// Checksum 0xd06d9cdd, Offset: 0x7a8
// Size: 0x250
function function_c80760de(weapon) {
    self thread function_1df276e0();
    v_start = self getweaponmuzzlepoint();
    var_9c5bd97c = self getweaponforwarddir();
    a_targets = getentitiesinradius(self.origin, 192, 15);
    foreach (ai in a_targets) {
        if (!isalive(ai) || ai.archetype !== "zombie" && ai.archetype !== "catalyst" || ai getteam() !== level.zombie_team) {
            continue;
        }
        v_ai = ai getcentroid();
        v_normal = vectornormalize(v_ai - v_start);
        dot = vectordot(var_9c5bd97c, v_normal);
        if (dot <= 0) {
            continue;
        }
        waitframe(0);
        var_bcf8b505 = vectornormalize(var_9c5bd97c);
        if (0 == ai sightconetrace(v_start, self, var_bcf8b505, 22.5)) {
            continue;
        }
        ai zombie_utility::setup_zombie_knockdown(self);
    }
}

// Namespace zm_weap_tricannon/zm_weap_tricannon
// Params 0, eflags: 0x0
// Checksum 0x268d7c21, Offset: 0xa00
// Size: 0x170
function function_1df276e0() {
    a_targets = getentitiesinradius(self.origin, 64, 15);
    v_start = self getweaponmuzzlepoint();
    foreach (ai in a_targets) {
        if (!isalive(ai) || ai.archetype !== "zombie" && ai.archetype !== "catalyst" || ai getteam() !== level.zombie_team) {
            continue;
        }
        waitframe(0);
        if (!sighttracepassed(v_start, ai getcentroid(), 0, self)) {
            continue;
        }
        ai zombie_utility::setup_zombie_knockdown(self);
    }
}

// Namespace zm_weap_tricannon/zm_weap_tricannon
// Params 1, eflags: 0x0
// Checksum 0xffbac6bf, Offset: 0xb78
// Size: 0x44
function function_e7a32f06(weapon) {
    self thread function_1df276e0();
    self function_195d6b5(weapon, 1);
}

// Namespace zm_weap_tricannon/zm_weap_tricannon
// Params 1, eflags: 0x0
// Checksum 0x110506ac, Offset: 0xbc8
// Size: 0x3c
function function_ee995e3(weapon) {
    self thread function_1df276e0();
    self function_195d6b5(weapon, 0);
}

// Namespace zm_weap_tricannon/zm_weap_tricannon
// Params 2, eflags: 0x0
// Checksum 0x782d31e9, Offset: 0xc10
// Size: 0x560
function function_195d6b5(weapon, b_packed) {
    /#
        if (!isdefined(self.var_eed271c5)) {
            self.var_eed271c5 = [];
        } else if (!isarray(self.var_eed271c5)) {
            self.var_eed271c5 = array(self.var_eed271c5);
        }
        self.var_eed271c5[weapon] = 4;
    #/
    v_start = self getweaponmuzzlepoint();
    var_9c5bd97c = self getweaponforwarddir();
    var_31de5fde = getentitiesinradius(self.origin, 350);
    var_31de5fde = arraysortclosest(var_31de5fde, self.origin, undefined);
    foreach (ai in var_31de5fde) {
        if (!isalive(ai)) {
            continue;
        }
        if (ai getentitytype() !== 15 && ai getentitytype() !== 12 && ai getentitytype() !== 6) {
            continue;
        }
        if (ai.takedamage !== 1 || ai getteam() !== level.zombie_team && ai getentitytype() !== 6) {
            continue;
        }
        var_fb2f8963 = ai getcentroid();
        normal = vectornormalize(var_fb2f8963 - v_start);
        dot = vectordot(var_9c5bd97c, normal);
        if (dot <= 0) {
            continue;
        }
        waitframe(0);
        var_bcf8b505 = vectornormalize(var_9c5bd97c);
        if (0 == ai sightconetrace(v_start, self, var_bcf8b505, 50)) {
            continue;
        }
        n_dist_sq = distancesquared(v_start, var_fb2f8963);
        n_damage = 5000 * (122500 - n_dist_sq) / 122500;
        if (n_damage < 3000) {
            n_damage = 3000;
        }
        n_launch = 75;
        if (b_packed) {
            n_damage *= 1.75;
            n_launch *= 1.5;
            n_damage = int(n_damage);
        }
        if (ai getentitytype() === 6) {
            ai dodamage(n_damage, v_start, self, self);
            continue;
        }
        if (ai.knockdown === 1) {
            var_aab69e43 = 1;
        } else {
            var_aab69e43 = 0;
        }
        ai dodamage(n_damage, v_start, self, self);
        if (!isalive(ai)) {
            ai startragdoll(1);
            ai launchragdoll(vectornormalize(var_fb2f8963 - self.origin) * n_launch);
            continue;
        }
        if (var_aab69e43 == 1) {
            continue;
        }
        if (n_dist_sq < 122500) {
            if (ai.var_29ed62b2 === #"heavy" || ai.var_29ed62b2 === #"miniboss") {
                ai ai::stun();
                continue;
            }
            ai zombie_utility::setup_zombie_knockdown(self);
        }
    }
}

// Namespace zm_weap_tricannon/zm_weap_tricannon
// Params 1, eflags: 0x0
// Checksum 0x9d66c9a4, Offset: 0x1178
// Size: 0x8c
function function_c19ce653(weapon) {
    /#
        if (!isdefined(self.var_eed271c5)) {
            self.var_eed271c5 = [];
        } else if (!isarray(self.var_eed271c5)) {
            self.var_eed271c5 = array(self.var_eed271c5);
        }
        self.var_eed271c5[weapon] = 2;
    #/
    self function_c80760de(weapon);
}

// Namespace zm_weap_tricannon/zm_weap_tricannon
// Params 1, eflags: 0x0
// Checksum 0x5079ca74, Offset: 0x1210
// Size: 0x124
function function_4596763c(params) {
    playfx(level._effect[#"earth_impact"], params.vpoint);
    if (params.idamage >= self.health) {
        if (self.archetype == "zombie") {
            self clientfield::set("zombie_gut_explosion", 1);
            waitframe(5);
            if (isdefined(self)) {
                self delete();
            }
        }
        return;
    }
    if (self.var_29ed62b2 === #"heavy" || self.var_29ed62b2 === #"miniboss") {
        self ai::stun();
        return;
    }
    if (self.knockdown !== 1) {
        self zombie_utility::setup_zombie_knockdown(params.eattacker);
    }
}

// Namespace zm_weap_tricannon/zm_weap_tricannon
// Params 1, eflags: 0x0
// Checksum 0xf99c7eaa, Offset: 0x1340
// Size: 0x1ec
function function_ca05af54(weapon) {
    /#
        if (!isdefined(self.var_eed271c5)) {
            self.var_eed271c5 = [];
        } else if (!isarray(self.var_eed271c5)) {
            self.var_eed271c5 = array(self.var_eed271c5);
        }
        self.var_eed271c5[weapon] = 1;
    #/
    self clientfield::increment("water_tricannon_muzzle_fx", 1);
    self function_c80760de(weapon);
    v_start = self getweaponmuzzlepoint();
    v_forward = self getweaponforwarddir();
    v_end = v_start + v_forward * 4000;
    e_shot = magicbullet(weapon, v_start, v_end, self);
    v_impact = function_85b928f4(e_shot);
    if (weapon == getweapon(#"ww_tricannon_water_t8" + "_upgraded")) {
        var_7f321a06 = #"hash_64aafe3cc04860be";
        n_duration = 5;
    } else {
        var_7f321a06 = #"hash_7dd6cbed104dd8bd";
        n_duration = 4;
    }
    self function_7e6e2bc1(v_impact, var_7f321a06, n_duration);
}

// Namespace zm_weap_tricannon/zm_weap_tricannon
// Params 1, eflags: 0x0
// Checksum 0x34324abd, Offset: 0x1538
// Size: 0x48
function function_85b928f4(e_shot) {
    while (isdefined(e_shot)) {
        if (isdefined(e_shot.origin)) {
            v_impact = e_shot.origin;
        }
        waitframe(1);
    }
    return v_impact;
}

// Namespace zm_weap_tricannon/zm_weap_tricannon
// Params 3, eflags: 0x0
// Checksum 0x340f5d18, Offset: 0x1588
// Size: 0x1fc
function function_7e6e2bc1(v_impact, var_7f321a06, n_duration) {
    for (n_time_passed = 0; n_time_passed <= n_duration; n_time_passed += 0.25) {
        var_31de5fde = getaiteamarray(level.zombie_team);
        var_31de5fde = arraysortclosest(var_31de5fde, v_impact, undefined, undefined, 112);
        foreach (ai in var_31de5fde) {
            if (ai.var_29ed62b2 === #"heavy" || ai.var_29ed62b2 === #"miniboss") {
                if (var_7f321a06 == #"hash_64aafe3cc04860be") {
                    ai thread zm_utility::function_447d3917(#"hash_111531769a0bf9e");
                } else {
                    ai thread zm_utility::function_447d3917(#"hash_7eece5e5a5f9cc4d");
                }
            } else {
                ai thread zm_utility::function_447d3917(var_7f321a06);
            }
            ai clientfield::set("water_tricannon_slow_fx", 1);
            ai thread function_cd8b2913();
        }
        wait 0.25;
    }
}

// Namespace zm_weap_tricannon/zm_weap_tricannon
// Params 0, eflags: 0x0
// Checksum 0x3205ca7, Offset: 0x1790
// Size: 0xd4
function function_cd8b2913() {
    self notify("3455aa15a70c0f1a");
    self endon("3455aa15a70c0f1a");
    self endon(#"death");
    do {
        waitframe(1);
    } while (isdefined(self.a_n_slowdown_timeouts[#"hash_7dd6cbed104dd8bd"]) || isdefined(self.a_n_slowdown_timeouts[#"hash_64aafe3cc04860be"]) || isdefined(self.a_n_slowdown_timeouts[#"hash_7eece5e5a5f9cc4d"]) || isdefined(self.a_n_slowdown_timeouts[#"hash_f87f19d867f4e2e"]));
    self clientfield::set("water_tricannon_slow_fx", 0);
}

// Namespace zm_weap_tricannon/zm_weap_tricannon
// Params 1, eflags: 0x0
// Checksum 0xbac11d84, Offset: 0x1870
// Size: 0xac
function function_fe94a0db(weapon) {
    /#
        if (!isdefined(self.var_eed271c5)) {
            self.var_eed271c5 = [];
        } else if (!isarray(self.var_eed271c5)) {
            self.var_eed271c5 = array(self.var_eed271c5);
        }
        self.var_eed271c5[weapon] = 3;
    #/
    self function_c80760de(weapon);
    self clientfield::increment("fire_tricannon_muzzle_fx", 1);
}

// Namespace zm_weap_tricannon/zm_weap_tricannon
// Params 1, eflags: 0x0
// Checksum 0x555b0828, Offset: 0x1928
// Size: 0x2ac
function function_5e30bb26(params) {
    if (params.smeansofdeath === "MOD_PROJECTILE_SPLASH") {
        return true;
    }
    if (params.smeansofdeath !== "MOD_PROJECTILE") {
        return false;
    }
    if (isdefined(params.einflictor) && isactor(params.einflictor)) {
        return false;
    }
    if (isalive(self)) {
        if (self.health <= params.idamage) {
            v_z_offset = (0, 0, randomfloat(0.6));
            v_launch = (vectornormalize(params.vdir) + v_z_offset) * randomintrange(75, 125);
            self startragdoll(1);
            self launchragdoll(v_launch);
            return false;
        }
        if (self.var_29ed62b2 === #"heavy" || self.var_29ed62b2 === #"miniboss") {
            self ai::stun();
            if (isdefined(params.vpoint) && isdefined(params.vdir)) {
                playfx(level._effect[#"fire_impact"], params.vpoint, params.vdir);
            }
            params.einflictor notify(#"death");
            waitframe(0);
            if (isdefined(params.einflictor) && isdefined(params.eattacker) && isplayer(params.eattacker)) {
                params.einflictor detonate(params.eattacker);
            }
        } else {
            self zombie_utility::setup_zombie_knockdown(params.eattacker);
        }
        return true;
    }
    return false;
}

// Namespace zm_weap_tricannon/zm_weap_tricannon
// Params 1, eflags: 0x0
// Checksum 0xdcff8e75, Offset: 0x1be0
// Size: 0x294
function function_28fcf5a3(params) {
    self notify(#"hash_d90566305b241c4");
    self endon(#"hash_d90566305b241c4");
    if (!isdefined(self) || self.health <= params.idamage) {
        return;
    }
    if (level.burning_zombies.size < 6 && self.archetype === "zombie") {
        if (!isdefined(level.burning_zombies)) {
            level.burning_zombies = [];
        } else if (!isarray(level.burning_zombies)) {
            level.burning_zombies = array(level.burning_zombies);
        }
        level.burning_zombies[level.burning_zombies.size] = self;
        playfxontag(level._effect[#"character_fire_death_torso"], self, "J_SpineLower");
    }
    var_fd4d2985 = 0;
    var_b574018d = 200;
    if (params.weapon == getweapon(#"ww_tricannon_fire_t8" + "_upgraded")) {
        var_b574018d *= 2;
    }
    while (var_fd4d2985 <= 5) {
        wait 1;
        if (isalive(self)) {
            var_fd4d2985 += 1;
            self ai::disable_pain();
            self dodamage(var_b574018d, self.origin, params.eattacker, params.einflictor, "torso_lower", "MOD_DOT", 2);
            continue;
        }
        break;
    }
    arrayremovevalue(level.burning_zombies, self, 0);
    if (isalive(self)) {
        self ai::enable_pain();
    }
}

