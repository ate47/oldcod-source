#using script_5f261a5d57de5f7c;
#using script_62caa307a394c18c;
#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lightning_chain;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_utility;

#namespace ammomod_deadwire;

// Namespace ammomod_deadwire/ammomod_deadwire
// Params 0, eflags: 0x1 linked
// Checksum 0x5f364355, Offset: 0x210
// Size: 0x954
function function_af1f180() {
    if (!is_true(level.aat_in_use)) {
        return;
    }
    aat::register("ammomod_deadwire", 0.2, 0, 15, 15, 1, &result, "t7_hud_zm_aat_deadwire", "wpn_aat_dead_wire_plr", undefined, #"electrical");
    aat::register("ammomod_deadwire_1", 0.2, 0, 15, 15, 1, &result, "t7_hud_zm_aat_deadwire", "wpn_aat_dead_wire_plr", undefined, #"electrical");
    aat::register("ammomod_deadwire_2", 0.2, 0, 15, 15, 1, &result, "t7_hud_zm_aat_deadwire", "wpn_aat_dead_wire_plr", undefined, #"electrical");
    aat::register("ammomod_deadwire_3", 0.2, 0, 15, 15, 1, &result, "t7_hud_zm_aat_deadwire", "wpn_aat_dead_wire_plr", undefined, #"electrical");
    aat::register("ammomod_deadwire_4", 0.2, 0, 15, 15, 1, &result, "t7_hud_zm_aat_deadwire", "wpn_aat_dead_wire_plr", undefined, #"electrical");
    aat::register("ammomod_deadwire_5", 0.2, 0, 15, 15, 1, &result, "t7_hud_zm_aat_deadwire", "wpn_aat_dead_wire_plr", undefined, #"electrical");
    clientfield::register("actor", "zm_ammomod_deadwire_explosion", 1, 1, "counter");
    clientfield::register("vehicle", "zm_ammomod_deadwire_explosion", 1, 1, "counter");
    clientfield::register("actor", "zm_ammomod_deadwire_zap", 1, 4, "int");
    clientfield::register("vehicle", "zm_ammomod_deadwire_zap", 1, 4, "int");
    level.var_6f993f47 = lightning_chain::create_lightning_chain_params(0, 1, 1);
    level.var_620d4080 = lightning_chain::create_lightning_chain_params(0, 1, 1);
    level.var_8ec0ca14 = lightning_chain::create_lightning_chain_params(0, 1, 1);
    level.var_b347489f = lightning_chain::create_lightning_chain_params(0, 1, 1);
    level.var_9d477dfa = lightning_chain::create_lightning_chain_params(0, 1, 1);
    level.var_7659ca85 = lightning_chain::create_lightning_chain_params(5, 6, 256);
    level.var_6f993f47.head_gib_chance = 0;
    level.var_6f993f47.network_death_choke = 4;
    level.var_6f993f47.should_kill_enemies = 0;
    level.var_6f993f47.challenge_stat_name = #"hash_39f67003b4faaaa1";
    level.var_6f993f47.no_fx = 0;
    level.var_6f993f47.clientside_fx = 0;
    level.var_6f993f47.str_mod = "MOD_AAT";
    level.var_6f993f47.var_a9255d36 = #"hash_ff52504bb0aceb9";
    level.var_6f993f47.var_871d3454 = 2;
    level.var_6f993f47.tier = 0;
    level.var_620d4080.head_gib_chance = 0;
    level.var_620d4080.network_death_choke = 4;
    level.var_620d4080.should_kill_enemies = 0;
    level.var_620d4080.challenge_stat_name = #"hash_39f67003b4faaaa1";
    level.var_620d4080.no_fx = 0;
    level.var_620d4080.clientside_fx = 0;
    level.var_620d4080.str_mod = "MOD_AAT";
    level.var_620d4080.var_a9255d36 = #"hash_ff52504bb0aceb9";
    level.var_620d4080.var_871d3454 = 4;
    level.var_620d4080.tier = 1;
    level.var_8ec0ca14.head_gib_chance = 0;
    level.var_8ec0ca14.network_death_choke = 4;
    level.var_8ec0ca14.should_kill_enemies = 0;
    level.var_8ec0ca14.challenge_stat_name = #"hash_39f67003b4faaaa1";
    level.var_8ec0ca14.no_fx = 0;
    level.var_8ec0ca14.clientside_fx = 0;
    level.var_8ec0ca14.str_mod = "MOD_AAT";
    level.var_8ec0ca14.var_a9255d36 = #"hash_ff52504bb0aceb9";
    level.var_8ec0ca14.var_871d3454 = 4;
    level.var_8ec0ca14.tier = 2;
    level.var_b347489f.head_gib_chance = 0;
    level.var_b347489f.network_death_choke = 4;
    level.var_b347489f.should_kill_enemies = 0;
    level.var_b347489f.challenge_stat_name = #"hash_39f67003b4faaaa1";
    level.var_b347489f.no_fx = 0;
    level.var_b347489f.clientside_fx = 0;
    level.var_b347489f.str_mod = "MOD_AAT";
    level.var_b347489f.var_a9255d36 = #"hash_ff52504bb0aceb9";
    level.var_b347489f.var_871d3454 = 4;
    level.var_b347489f.tier = 3;
    level.var_9d477dfa.head_gib_chance = 0;
    level.var_9d477dfa.network_death_choke = 4;
    level.var_9d477dfa.should_kill_enemies = 0;
    level.var_9d477dfa.challenge_stat_name = #"hash_39f67003b4faaaa1";
    level.var_9d477dfa.no_fx = 0;
    level.var_9d477dfa.clientside_fx = 0;
    level.var_9d477dfa.str_mod = "MOD_AAT";
    level.var_9d477dfa.var_a9255d36 = #"hash_ff52504bb0aceb9";
    level.var_9d477dfa.var_871d3454 = 4;
    level.var_9d477dfa.tier = 4;
    level.var_7659ca85.head_gib_chance = 0;
    level.var_7659ca85.network_death_choke = 4;
    level.var_7659ca85.should_kill_enemies = 0;
    level.var_7659ca85.challenge_stat_name = #"hash_39f67003b4faaaa1";
    level.var_7659ca85.no_fx = 0;
    level.var_7659ca85.clientside_fx = 0;
    level.var_7659ca85.str_mod = "MOD_AAT";
    level.var_7659ca85.var_a9255d36 = #"hash_ff52504bb0aceb9";
    level.var_7659ca85.var_871d3454 = 4;
    level.var_7659ca85.tier = 5;
    callback::add_callback(#"hash_210adcf09e99fba1", &function_ffe2bb2f);
}

// Namespace ammomod_deadwire/ammomod_deadwire
// Params 1, eflags: 0x5 linked
// Checksum 0xa27c96c3, Offset: 0xb70
// Size: 0xbc
function private function_832f84f6(aat_name) {
    switch (aat_name) {
    case #"ammomod_deadwire":
        return 0;
    case #"ammomod_deadwire_1":
        return 1;
    case #"ammomod_deadwire_2":
        return 2;
    case #"ammomod_deadwire_3":
        return 3;
    case #"ammomod_deadwire_4":
        return 4;
    case #"ammomod_deadwire_5":
        return 5;
    }
    return 0;
}

// Namespace ammomod_deadwire/ammomod_deadwire
// Params 5, eflags: 0x1 linked
// Checksum 0xfa5eb379, Offset: 0xc38
// Size: 0x2bc
function result(*death, attacker, *mod, weapon, vpoint = self.origin) {
    playfx("zm_weapons/fx9_aat_bul_impact_electric", vpoint);
    if (!isdefined(zombie_utility::function_d2dfacfd(#"tesla_head_gib_chance"))) {
        zombie_utility::set_zombie_var(#"tesla_head_gib_chance", 50);
    }
    aat_name = mod aat::getaatonweapon(weapon, 1);
    tier = function_832f84f6(aat_name);
    switch (tier) {
    case 0:
        level.var_6f993f47.weapon = weapon;
        s_params = level.var_6f993f47;
        break;
    case 1:
        level.var_620d4080.weapon = weapon;
        s_params = level.var_620d4080;
        break;
    case 2:
        level.var_8ec0ca14.weapon = weapon;
        s_params = level.var_8ec0ca14;
        break;
    case 3:
        level.var_b347489f.weapon = weapon;
        s_params = level.var_b347489f;
        break;
    case 4:
        level.var_9d477dfa.weapon = weapon;
        s_params = level.var_9d477dfa;
        break;
    case 5:
        level.var_7659ca85.weapon = weapon;
        s_params = level.var_7659ca85;
        break;
    }
    if (self.var_6f84b820 === #"special") {
        if (tier >= 4) {
            self thread function_e0e02bed(mod, s_params, tier);
        }
        return;
    }
    if (self.var_6f84b820 === #"normal") {
        self thread function_e0e02bed(mod, s_params, tier);
    }
}

// Namespace ammomod_deadwire/ammomod_deadwire
// Params 1, eflags: 0x1 linked
// Checksum 0x5c52561e, Offset: 0xf00
// Size: 0xc2
function function_b686c867(e_attacker) {
    n_current_time = float(gettime()) / 1000;
    if (isplayer(e_attacker)) {
        if (!isdefined(e_attacker.aat_cooldown_start[#"zm_ammomod_deadwire_explosion"])) {
            return true;
        } else if (isdefined(e_attacker.aat_cooldown_start[#"zm_ammomod_deadwire_explosion"]) && n_current_time >= e_attacker.aat_cooldown_start[#"zm_ammomod_deadwire_explosion"] + 30) {
            return true;
        }
    }
    return false;
}

// Namespace ammomod_deadwire/ammomod_deadwire
// Params 3, eflags: 0x1 linked
// Checksum 0xaac425b7, Offset: 0xfd0
// Size: 0xdc
function function_e0e02bed(player, s_params, tier) {
    self endon(#"death");
    if (isdefined(self.spawn_time) && gettime() == self.spawn_time) {
        waitframe(1);
    }
    if (!isplayer(player)) {
        return;
    }
    if (tier >= 5 && function_b686c867(player)) {
        function_5e4b580b(player, s_params, tier);
        return;
    }
    self function_de99f2ad(player, self, s_params, tier);
}

// Namespace ammomod_deadwire/ammomod_deadwire
// Params 3, eflags: 0x1 linked
// Checksum 0xc53c60bd, Offset: 0x10b8
// Size: 0x184
function function_5e4b580b(player, s_params, tier) {
    if (isdefined(self)) {
        self clientfield::increment("zm_ammomod_deadwire_explosion", 1);
    }
    n_range = player namespace_e86ffa8::function_cd6787b(2) ? 512 : 256;
    a_zombies = getentitiesinradius(self.origin, n_range, 15);
    count = 0;
    self function_de99f2ad(player, self, s_params, tier);
    foreach (e_zombie in a_zombies) {
        if (count >= 5) {
            return;
        }
        if (e_zombie == self) {
            continue;
        }
        e_zombie function_de99f2ad(player, self, s_params, tier);
        count++;
    }
}

// Namespace ammomod_deadwire/ammomod_deadwire
// Params 4, eflags: 0x1 linked
// Checksum 0xa1646b3, Offset: 0x1248
// Size: 0x124
function function_de99f2ad(player, var_fb0999c0, s_params, tier) {
    if (!isalive(self)) {
        return;
    }
    if (is_true(level.aat[#"ammomod_deadwire"].immune_result_indirect[self.archetype])) {
        return;
    }
    if (self == var_fb0999c0 && is_true(level.aat[#"ammomod_deadwire"].immune_result_direct[self.archetype])) {
        return;
    }
    if (self ai::is_stunned() || is_true(self.var_d1b39105)) {
        return;
    }
    self.var_d1b39105 = 1;
    self thread function_30c7f12c(player, s_params, tier);
}

// Namespace ammomod_deadwire/ammomod_deadwire
// Params 3, eflags: 0x1 linked
// Checksum 0xec79d53e, Offset: 0x1378
// Size: 0x154
function function_13d4bcdf(*origin, player, params) {
    if (!isplayer(player) || !isalive(self)) {
        return;
    }
    tier = isdefined(params.tier) ? params.tier : 0;
    var_871d3454 = isdefined(params.var_871d3454) ? params.var_871d3454 : 2;
    weapon = player getcurrentweapon();
    damage = tier >= 3 ? 50 : 25;
    if (zm_utility::is_survival()) {
        damage = zm_equipment::function_739fbb72(damage);
    } else {
        damage = zm_equipment::function_379f6b5d(damage);
    }
    self thread function_2bd8c11(player, damage, weapon, var_871d3454);
}

// Namespace ammomod_deadwire/ammomod_deadwire
// Params 4, eflags: 0x1 linked
// Checksum 0xe0d36125, Offset: 0x14d8
// Size: 0x1be
function function_2bd8c11(player, damage, weapon, var_871d3454) {
    self endon(#"death", #"deadwire_stunned", #"hash_3a0cc85cce9af776", #"hash_ff52504bb0aceb9");
    var_4691e777 = self.origin;
    time = 0;
    while (time <= var_871d3454) {
        a_potential_targets = getentitiesinradius(self.origin, 256, 15);
        foreach (zombie in a_potential_targets) {
            if (isalive(zombie) && isplayer(player) && isdefined(var_4691e777)) {
                zombie namespace_42457a0::function_601fabe9(#"electrical", damage, var_4691e777, player, undefined, "none", "MOD_AAT", 0, weapon);
            }
            waitframe(1);
        }
        time += 1;
        wait 1;
    }
}

// Namespace ammomod_deadwire/ammomod_deadwire
// Params 3, eflags: 0x1 linked
// Checksum 0xeea33184, Offset: 0x16a0
// Size: 0x10c
function function_30c7f12c(player, s_params, tier = 0) {
    self notify(#"deadwire_stunned");
    self endon(#"death", #"deadwire_stunned");
    self clientfield::set("zm_ammomod_deadwire_zap", tier);
    if (tier >= 1) {
        self.tesla_damage_func = &function_13d4bcdf;
    }
    if (player namespace_e86ffa8::function_cd6787b(2)) {
        s_params.radius_start *= 2;
    }
    self lightning_chain::arc_damage_ent(player, 2, s_params);
    wait 6;
    self thread function_ffe2bb2f();
}

// Namespace ammomod_deadwire/ammomod_deadwire
// Params 0, eflags: 0x1 linked
// Checksum 0x7ec8d487, Offset: 0x17b8
// Size: 0x86
function function_ffe2bb2f() {
    self endon(#"death", #"deadwire_stunned");
    waitframe(1);
    if (is_true(self.var_d1b39105)) {
        self.var_d1b39105 = 0;
        self clientfield::set("zm_ammomod_deadwire_zap", 0);
        self notify(#"hash_ff52504bb0aceb9");
    }
}

