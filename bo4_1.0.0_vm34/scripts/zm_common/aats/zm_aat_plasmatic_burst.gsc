#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_stats;

#namespace zm_aat_plasmatic_burst;

// Namespace zm_aat_plasmatic_burst/zm_aat_plasmatic_burst
// Params 0, eflags: 0x2
// Checksum 0xb0712075, Offset: 0x148
// Size: 0x3c
function autoexec __init__system__() {
    system::register("zm_aat_plasmatic_burst", &__init__, undefined, #"aat");
}

// Namespace zm_aat_plasmatic_burst/zm_aat_plasmatic_burst
// Params 0, eflags: 0x0
// Checksum 0xd39b983e, Offset: 0x190
// Size: 0x154
function __init__() {
    if (!(isdefined(level.aat_in_use) && level.aat_in_use)) {
        return;
    }
    aat::register("zm_aat_plasmatic_burst", 0.15, 0, 15, 0, 1, &result, "t7_hud_zm_aat_blastfurnace", "wpn_aat_blast_furnace_plr", undefined, 2);
    clientfield::register("actor", "zm_aat_plasmatic_burst" + "_explosion", 1, 1, "counter");
    clientfield::register("vehicle", "zm_aat_plasmatic_burst" + "_explosion", 1, 1, "counter");
    clientfield::register("actor", "zm_aat_plasmatic_burst" + "_burn", 1, 1, "counter");
    clientfield::register("vehicle", "zm_aat_plasmatic_burst" + "_burn", 1, 1, "counter");
}

// Namespace zm_aat_plasmatic_burst/zm_aat_plasmatic_burst
// Params 4, eflags: 0x0
// Checksum 0xa951f6b3, Offset: 0x2f0
// Size: 0x3c
function result(death, attacker, mod, weapon) {
    self thread function_be756fe(attacker, weapon);
}

// Namespace zm_aat_plasmatic_burst/zm_aat_plasmatic_burst
// Params 2, eflags: 0x0
// Checksum 0x5231dac1, Offset: 0x338
// Size: 0x3b8
function function_be756fe(e_attacker, w_weapon) {
    self thread clientfield::increment("zm_aat_plasmatic_burst" + "_explosion");
    level notify(#"plasmatic_burst", {#var_a7f2bb60:self});
    a_e_blasted_zombies = array::get_all_closest(self.origin, getaiteamarray(#"axis"), undefined, undefined, 120);
    if (a_e_blasted_zombies.size > 0) {
        waitframe(1);
        for (i = 0; i < a_e_blasted_zombies.size; i++) {
            if (isalive(a_e_blasted_zombies[i])) {
                if (isdefined(level.aat[#"zm_aat_plasmatic_burst"].immune_result_indirect[a_e_blasted_zombies[i].archetype]) && level.aat[#"zm_aat_plasmatic_burst"].immune_result_indirect[a_e_blasted_zombies[i].archetype]) {
                    arrayremovevalue(a_e_blasted_zombies, a_e_blasted_zombies[i]);
                    continue;
                }
                if (a_e_blasted_zombies[i] == self && !(isdefined(level.aat[#"zm_aat_plasmatic_burst"].immune_result_direct[a_e_blasted_zombies[i].archetype]) && level.aat[#"zm_aat_plasmatic_burst"].immune_result_direct[a_e_blasted_zombies[i].archetype])) {
                    self thread zombie_death_gib(e_attacker, w_weapon);
                    a_e_blasted_zombies[i] thread clientfield::increment("zm_aat_plasmatic_burst" + "_burn");
                    arrayremovevalue(a_e_blasted_zombies, a_e_blasted_zombies[i]);
                    continue;
                }
                a_e_blasted_zombies[i] thread clientfield::increment("zm_aat_plasmatic_burst" + "_burn");
                util::wait_network_frame();
            }
        }
        wait 0.25;
        a_e_blasted_zombies = array::remove_dead(a_e_blasted_zombies);
        a_e_blasted_zombies = array::remove_undefined(a_e_blasted_zombies);
        foreach (var_9ccc7137 in a_e_blasted_zombies) {
            if (isdefined(var_9ccc7137)) {
                var_9ccc7137 thread function_8f478819(e_attacker, w_weapon);
                util::wait_network_frame(randomintrange(1, 3));
            }
        }
    }
}

// Namespace zm_aat_plasmatic_burst/zm_aat_plasmatic_burst
// Params 2, eflags: 0x0
// Checksum 0x484ca712, Offset: 0x6f8
// Size: 0xd0
function function_8f478819(e_attacker, w_weapon) {
    self endon(#"death");
    n_damage = self.health / 6;
    i = 0;
    while (i <= 6) {
        if (self.health < n_damage) {
            e_attacker zm_stats::increment_challenge_stat("ZOMBIE_HUNTER_PLASMATIC_BURST");
        }
        self dodamage(n_damage, self.origin, e_attacker, undefined, "none", "MOD_AAT", 0, w_weapon);
        i++;
        wait 0.5;
    }
}

// Namespace zm_aat_plasmatic_burst/zm_aat_plasmatic_burst
// Params 2, eflags: 0x0
// Checksum 0x7ea55528, Offset: 0x7d0
// Size: 0x104
function zombie_death_gib(e_attacker, w_weapon) {
    gibserverutils::gibhead(self);
    if (math::cointoss()) {
        gibserverutils::gibleftarm(self);
    } else {
        gibserverutils::gibrightarm(self);
    }
    gibserverutils::giblegs(self);
    self dodamage(self.health, self.origin, e_attacker, e_attacker, "none", "MOD_AAT");
    if (isdefined(e_attacker) && isplayer(e_attacker)) {
        e_attacker zm_stats::increment_challenge_stat("ZOMBIE_HUNTER_PLASMATIC_BURST");
    }
}

