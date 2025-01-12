#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_56577988;

// Namespace namespace_56577988/namespace_56577988
// Params 0, eflags: 0x1 linked
// Checksum 0x46948295, Offset: 0x140
// Size: 0x15c
function function_a9c3764f() {
    if (!is_true(level.aat_in_use)) {
        return;
    }
    aat::register("zm_aat_plasmatic_burst", 0.15, 0, 30, 5, 1, &result, "t7_hud_zm_aat_blastfurnace", "wpn_aat_blast_furnace_plr", undefined, #"fire");
    clientfield::register("actor", "zm_aat_plasmatic_burst" + "_explosion", 1, 1, "counter");
    clientfield::register("vehicle", "zm_aat_plasmatic_burst" + "_explosion", 1, 1, "counter");
    clientfield::register("actor", "zm_aat_plasmatic_burst" + "_burn", 1, 1, "int");
    clientfield::register("vehicle", "zm_aat_plasmatic_burst" + "_burn", 1, 1, "int");
}

// Namespace namespace_56577988/namespace_56577988
// Params 5, eflags: 0x1 linked
// Checksum 0x1e8d1eb9, Offset: 0x2a8
// Size: 0x44
function result(*death, attacker, *mod, weapon, *vpoint) {
    self thread function_988b8f91(weapon, vpoint);
}

// Namespace namespace_56577988/namespace_56577988
// Params 2, eflags: 0x1 linked
// Checksum 0x82513b83, Offset: 0x2f8
// Size: 0x348
function function_988b8f91(e_attacker, w_weapon) {
    if (self.birthtime == gettime()) {
        waitframe(1);
        if (!isalive(self)) {
            return;
        }
    }
    self thread clientfield::increment("zm_aat_plasmatic_burst" + "_explosion");
    level notify(#"plasmatic_burst", {#var_ac85a15f:self});
    a_e_blasted_zombies = array::get_all_closest(self.origin, getaiteamarray(level.zombie_team), undefined, undefined, 120);
    if (a_e_blasted_zombies.size > 0) {
        waitframe(1);
        for (i = 0; i < a_e_blasted_zombies.size; i++) {
            if (isalive(a_e_blasted_zombies[i])) {
                if (is_true(level.aat[#"zm_aat_plasmatic_burst"].immune_result_indirect[a_e_blasted_zombies[i].archetype])) {
                    arrayremovevalue(a_e_blasted_zombies, a_e_blasted_zombies[i]);
                    continue;
                }
                if (a_e_blasted_zombies[i] == self && !is_true(level.aat[#"zm_aat_plasmatic_burst"].immune_result_direct[a_e_blasted_zombies[i].archetype])) {
                    self thread zombie_death_gib(e_attacker, w_weapon);
                    arrayremovevalue(a_e_blasted_zombies, a_e_blasted_zombies[i]);
                    continue;
                }
                a_e_blasted_zombies[i] thread clientfield::set("zm_aat_plasmatic_burst" + "_burn", 1);
                util::wait_network_frame();
            }
        }
        wait 0.25;
        function_1eaaceab(a_e_blasted_zombies);
        arrayremovevalue(a_e_blasted_zombies, undefined);
        foreach (var_8eee7949 in a_e_blasted_zombies) {
            if (isdefined(var_8eee7949)) {
                var_8eee7949 thread function_cd252d6e(e_attacker, w_weapon);
                util::wait_network_frame(randomintrange(1, 3));
            }
        }
    }
}

// Namespace namespace_56577988/namespace_56577988
// Params 2, eflags: 0x1 linked
// Checksum 0xac9bc442, Offset: 0x648
// Size: 0x144
function function_cd252d6e(e_attacker, w_weapon) {
    self endon(#"death");
    self.var_1e7e5205 = 1;
    var_70ab6bc = int(0.5 * 3333.33);
    i = 0;
    while (i <= 6) {
        self dodamage(var_70ab6bc, self.origin, e_attacker, undefined, "none", "MOD_AAT", 0, w_weapon);
        i++;
        wait 0.5;
    }
    if (self ishidden()) {
        while (self ishidden()) {
            wait 0.5;
        }
        wait 0.5;
    }
    self.var_1e7e5205 = undefined;
    self thread clientfield::set("zm_aat_plasmatic_burst" + "_burn", 0);
}

// Namespace namespace_56577988/namespace_56577988
// Params 2, eflags: 0x1 linked
// Checksum 0xaba84a44, Offset: 0x798
// Size: 0x12c
function zombie_death_gib(e_attacker, w_weapon) {
    if (is_true(level.headshots_only)) {
        return;
    }
    if (is_true(self.var_ba1bd9b2)) {
        return;
    }
    self clientfield::set("zm_aat_plasmatic_burst" + "_burn", 1);
    gibserverutils::gibhead(self);
    if (math::cointoss()) {
        gibserverutils::gibleftarm(self);
    } else {
        gibserverutils::gibrightarm(self);
    }
    gibserverutils::giblegs(self);
    self dodamage(self.health, self.origin, e_attacker, e_attacker, "none", "MOD_AAT", 0, w_weapon);
}

