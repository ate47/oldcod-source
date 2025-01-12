#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lightning_chain;
#using scripts\core_common\system_shared;

#namespace namespace_900a0996;

// Namespace namespace_900a0996/namespace_900a0996
// Params 0, eflags: 0x1 linked
// Checksum 0xe1004c12, Offset: 0x128
// Size: 0x27c
function function_d4a047b9() {
    if (!is_true(level.aat_in_use)) {
        return;
    }
    aat::register("zm_aat_kill_o_watt", 0.33, 0, 30, 5, 1, &result, "t7_hud_zm_aat_deadwire", "wpn_aat_dead_wire_plr", undefined, #"electrical");
    clientfield::register("actor", "zm_aat_kill_o_watt" + "_explosion", 1, 1, "counter");
    clientfield::register("vehicle", "zm_aat_kill_o_watt" + "_explosion", 1, 1, "counter");
    clientfield::register("actor", "zm_aat_kill_o_watt" + "_zap", 1, 1, "int");
    clientfield::register("vehicle", "zm_aat_kill_o_watt" + "_zap", 1, 1, "int");
    level.var_7fe61e7a = lightning_chain::create_lightning_chain_params(6, 7, 160);
    level.var_7fe61e7a.head_gib_chance = 0;
    level.var_7fe61e7a.network_death_choke = 4;
    level.var_7fe61e7a.should_kill_enemies = 0;
    level.var_7fe61e7a.challenge_stat_name = #"zombie_hunter_kill_o_watt";
    level.var_7fe61e7a.no_fx = 1;
    level.var_7fe61e7a.clientside_fx = 0;
    level.var_7fe61e7a.str_mod = "MOD_AAT";
    level.var_7fe61e7a.n_damage_max = 20000;
    level.var_7fe61e7a.var_a9255d36 = #"hash_1003dc8cc0b680f2";
    callback::add_callback(#"hash_210adcf09e99fba1", &function_439d6573);
}

// Namespace namespace_900a0996/namespace_900a0996
// Params 5, eflags: 0x1 linked
// Checksum 0xcd9c20b8, Offset: 0x3b0
// Size: 0xa4
function result(*death, attacker, *mod, weapon, *vpoint) {
    if (!isdefined(zombie_utility::function_d2dfacfd(#"tesla_head_gib_chance"))) {
        zombie_utility::set_zombie_var(#"tesla_head_gib_chance", 50);
    }
    level.var_7fe61e7a.weapon = vpoint;
    self thread function_1d0f645d(weapon);
}

// Namespace namespace_900a0996/namespace_900a0996
// Params 1, eflags: 0x1 linked
// Checksum 0x2ce9a9cd, Offset: 0x460
// Size: 0x138
function function_1d0f645d(player) {
    if (isdefined(self.spawn_time) && gettime() == self.spawn_time) {
        waitframe(1);
    }
    if (isdefined(self)) {
        self clientfield::increment("zm_aat_kill_o_watt" + "_explosion", 1);
    }
    a_zombies = getaiteamarray(level.zombie_team);
    a_zombies = arraysortclosest(a_zombies, self getcentroid(), 6, 0, 160);
    foreach (e_zombie in a_zombies) {
        e_zombie function_3c98a3f4(player, self);
    }
}

// Namespace namespace_900a0996/namespace_900a0996
// Params 2, eflags: 0x1 linked
// Checksum 0x9759950c, Offset: 0x5a0
// Size: 0x10c
function function_3c98a3f4(player, var_fb0999c0) {
    if (!isalive(self)) {
        return;
    }
    if (is_true(level.aat[#"zm_aat_kill_o_watt"].immune_result_indirect[self.archetype])) {
        return;
    }
    if (self == var_fb0999c0 && is_true(level.aat[#"zm_aat_kill_o_watt"].immune_result_direct[self.archetype])) {
        return;
    }
    if (self ai::is_stunned() || is_true(self.var_661d1e79)) {
        return;
    }
    self.var_661d1e79 = 1;
    self thread function_fbd6ea47(player);
}

// Namespace namespace_900a0996/namespace_900a0996
// Params 1, eflags: 0x1 linked
// Checksum 0xd18bb4c2, Offset: 0x6b8
// Size: 0x8c
function function_fbd6ea47(player) {
    self endon(#"death");
    self clientfield::set("zm_aat_kill_o_watt" + "_zap", 1);
    self lightning_chain::arc_damage_ent(player, 2, level.var_7fe61e7a);
    wait 6;
    self thread function_439d6573();
}

// Namespace namespace_900a0996/namespace_900a0996
// Params 0, eflags: 0x1 linked
// Checksum 0xec4629ad, Offset: 0x750
// Size: 0x7e
function function_439d6573() {
    self endon(#"death");
    waitframe(1);
    if (is_true(self.var_661d1e79)) {
        self.var_661d1e79 = 0;
        self clientfield::set("zm_aat_kill_o_watt" + "_zap", 0);
        self notify(#"hash_1003dc8cc0b680f2");
    }
}

