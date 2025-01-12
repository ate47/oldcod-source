#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\zm\zm_lightning_chain;
#using scripts\zm_common\callbacks;

#namespace zm_aat_kill_o_watt;

// Namespace zm_aat_kill_o_watt/zm_aat_kill_o_watt
// Params 0, eflags: 0x2
// Checksum 0x74314048, Offset: 0x128
// Size: 0x3c
function autoexec __init__system__() {
    system::register("zm_aat_kill_o_watt", &__init__, undefined, #"aat");
}

// Namespace zm_aat_kill_o_watt/zm_aat_kill_o_watt
// Params 0, eflags: 0x0
// Checksum 0x2f00daa, Offset: 0x170
// Size: 0x21c
function __init__() {
    if (!(isdefined(level.aat_in_use) && level.aat_in_use)) {
        return;
    }
    aat::register("zm_aat_kill_o_watt", 0.33, 0, 6, 4, 1, &result, "t7_hud_zm_aat_deadwire", "wpn_aat_dead_wire_plr", undefined, 3);
    clientfield::register("actor", "zm_aat_kill_o_watt" + "_explosion", 1, 1, "counter");
    clientfield::register("vehicle", "zm_aat_kill_o_watt" + "_explosion", 1, 1, "counter");
    clientfield::register("actor", "zm_aat_kill_o_watt" + "_zap", 1, 1, "int");
    clientfield::register("vehicle", "zm_aat_kill_o_watt" + "_zap", 1, 1, "int");
    level.var_fbb1e329 = lightning_chain::create_lightning_chain_params(6, 7, 160);
    level.var_fbb1e329.head_gib_chance = 0;
    level.var_fbb1e329.network_death_choke = 4;
    level.var_fbb1e329.should_kill_enemies = 0;
    level.var_fbb1e329.challenge_stat_name = "ZOMBIE_HUNTER_KILL_O_WATT";
    level.var_fbb1e329.no_fx = 1;
    level.var_fbb1e329.clientside_fx = 0;
    callback::function_5a6e6389(&function_549acdcb);
}

// Namespace zm_aat_kill_o_watt/zm_aat_kill_o_watt
// Params 4, eflags: 0x0
// Checksum 0x7d11818f, Offset: 0x398
// Size: 0x9c
function result(death, attacker, mod, weapon) {
    if (!isdefined(zombie_utility::get_zombie_var(#"tesla_head_gib_chance"))) {
        zombie_utility::set_zombie_var(#"tesla_head_gib_chance", 50);
    }
    level.var_fbb1e329.weapon = weapon;
    self thread function_25a7ad5d(attacker);
}

// Namespace zm_aat_kill_o_watt/zm_aat_kill_o_watt
// Params 1, eflags: 0x0
// Checksum 0x3ed3d3a2, Offset: 0x440
// Size: 0x100
function function_25a7ad5d(player) {
    self clientfield::increment("zm_aat_kill_o_watt" + "_explosion", 1);
    a_zombies = getaiteamarray(level.zombie_team);
    a_zombies = arraysortclosest(a_zombies, self getcentroid(), 6, 0, 160);
    foreach (e_zombie in a_zombies) {
        e_zombie function_567c3d5(player, self);
    }
}

// Namespace zm_aat_kill_o_watt/zm_aat_kill_o_watt
// Params 2, eflags: 0x0
// Checksum 0x21c5c53c, Offset: 0x548
// Size: 0x154
function function_567c3d5(player, var_7c13222e) {
    if (!isalive(self)) {
        return;
    }
    if (isdefined(level.aat[#"zm_aat_kill_o_watt"].immune_result_indirect[self.archetype]) && level.aat[#"zm_aat_kill_o_watt"].immune_result_indirect[self.archetype]) {
        return;
    }
    if (self == var_7c13222e && isdefined(level.aat[#"zm_aat_kill_o_watt"].immune_result_direct[self.archetype]) && level.aat[#"zm_aat_kill_o_watt"].immune_result_direct[self.archetype]) {
        return;
    }
    if (self ai::is_stunned() || isdefined(self.var_e17bf10a) && self.var_e17bf10a) {
        return;
    }
    self.var_e17bf10a = 1;
    self thread function_6f2b5738(player);
}

// Namespace zm_aat_kill_o_watt/zm_aat_kill_o_watt
// Params 1, eflags: 0x0
// Checksum 0x9961f111, Offset: 0x6a8
// Size: 0x8c
function function_6f2b5738(player) {
    self endon(#"death");
    self clientfield::set("zm_aat_kill_o_watt" + "_zap", 1);
    self lightning_chain::arc_damage_ent(player, 2, level.var_fbb1e329);
    wait 6;
    self thread function_549acdcb();
}

// Namespace zm_aat_kill_o_watt/zm_aat_kill_o_watt
// Params 0, eflags: 0x0
// Checksum 0x84a2d513, Offset: 0x740
// Size: 0x4c
function function_549acdcb() {
    if (isdefined(self.var_e17bf10a) && self.var_e17bf10a) {
        self.var_e17bf10a = 0;
        self clientfield::set("zm_aat_kill_o_watt" + "_zap", 0);
    }
}

