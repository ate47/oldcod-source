#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_bgb;

#namespace zm_bgb_ctrl_z;

// Namespace zm_bgb_ctrl_z/zm_bgb_ctrl_z
// Params 0, eflags: 0x2
// Checksum 0x912b0935, Offset: 0xe8
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_bgb_ctrl_z", &__init__, undefined, #"bgb");
}

// Namespace zm_bgb_ctrl_z/zm_bgb_ctrl_z
// Params 0, eflags: 0x0
// Checksum 0xc0db597a, Offset: 0x138
// Size: 0x84
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register(#"zm_bgb_ctrl_z", "time", 15, &enable, &disable, &validation, undefined);
}

// Namespace zm_bgb_ctrl_z/zm_bgb_ctrl_z
// Params 0, eflags: 0x0
// Checksum 0xc2e673e4, Offset: 0x1c8
// Size: 0x236
function enable() {
    self endon(#"disconnect", #"bled_out", #"bgb_update");
    a_ai_targets = function_be38a63();
    self.var_5f089d34 = 0;
    if (a_ai_targets.size > 2) {
        var_9aa12b23 = [];
        var_8a9de1aa = [];
        foreach (ai in a_ai_targets) {
            if (!self function_aa4d7ad1(ai, 0.766, 0)) {
                if (!isdefined(var_9aa12b23)) {
                    var_9aa12b23 = [];
                } else if (!isarray(var_9aa12b23)) {
                    var_9aa12b23 = array(var_9aa12b23);
                }
                var_9aa12b23[var_9aa12b23.size] = ai;
                continue;
            }
            if (!isdefined(var_8a9de1aa)) {
                var_8a9de1aa = [];
            } else if (!isarray(var_8a9de1aa)) {
                var_8a9de1aa = array(var_8a9de1aa);
            }
            var_8a9de1aa[var_8a9de1aa.size] = ai;
        }
        a_ai_targets = arraycombine(var_9aa12b23, var_8a9de1aa, 0, 0);
    }
    for (x = 0; x < a_ai_targets.size; x++) {
        a_ai_targets[x] thread turn_z(self);
        if (x == 1) {
            return;
        }
    }
}

// Namespace zm_bgb_ctrl_z/zm_bgb_ctrl_z
// Params 0, eflags: 0x0
// Checksum 0x29cae586, Offset: 0x408
// Size: 0xe
function disable() {
    self.var_5f089d34 = undefined;
}

// Namespace zm_bgb_ctrl_z/zm_bgb_ctrl_z
// Params 0, eflags: 0x0
// Checksum 0xbc6fda12, Offset: 0x420
// Size: 0x30
function validation() {
    a_ai_targets = function_be38a63();
    if (a_ai_targets.size) {
        return true;
    }
    return false;
}

// Namespace zm_bgb_ctrl_z/zm_bgb_ctrl_z
// Params 1, eflags: 0x0
// Checksum 0x3d1475a8, Offset: 0x458
// Size: 0x196
function turn_z(player) {
    if (player.var_5f089d34 < 2) {
        player.var_5f089d34++;
        if (!isvehicle(self)) {
            self thread clientfield::set("zm_aat_brain_decay", 1);
        }
        self thread zombie_death_time_limit(player);
        self.team = #"allies";
        self.aat_turned = 1;
        self.n_aat_turned_zombie_kills = 0;
        self.takedamage = 0;
        self.allowdeath = 0;
        self.allowpain = 0;
        self zombie_utility::set_zombie_run_cycle("sprint");
        if (math::cointoss()) {
            if (self.zombie_arms_position == "up") {
                self.variant_type = 6;
            } else {
                self.variant_type = 7;
            }
        } else if (self.zombie_arms_position == "up") {
            self.variant_type = 7;
        } else {
            self.variant_type = 8;
        }
        if (isdefined(player) && isplayer(player)) {
            self.var_fcc82858 = player;
        }
    }
}

// Namespace zm_bgb_ctrl_z/zm_bgb_ctrl_z
// Params 1, eflags: 0x0
// Checksum 0xb5fc3bb7, Offset: 0x5f8
// Size: 0x9c
function zombie_death_time_limit(e_attacker) {
    self endon(#"death");
    wait 15;
    self clientfield::set("zm_aat_brain_decay", 0);
    self clientfield::increment("zm_aat_brain_decay_exp", 1);
    waitframe(1);
    self.takedamage = 1;
    self.allowdeath = 1;
    self zombie_death_gib(e_attacker);
}

// Namespace zm_bgb_ctrl_z/zm_bgb_ctrl_z
// Params 1, eflags: 0x0
// Checksum 0x3ee1031b, Offset: 0x6a0
// Size: 0xa4
function zombie_death_gib(e_attacker) {
    gibserverutils::gibhead(self);
    if (math::cointoss()) {
        gibserverutils::gibleftarm(self);
    } else {
        gibserverutils::gibrightarm(self);
    }
    gibserverutils::giblegs(self);
    self dodamage(self.health, self.origin);
}

// Namespace zm_bgb_ctrl_z/zm_bgb_ctrl_z
// Params 0, eflags: 0x0
// Checksum 0xe13bcd05, Offset: 0x750
// Size: 0x16a
function function_be38a63() {
    a_ai_targets = getaispeciesarray(level.zombie_team, "all");
    var_841fcf67 = [];
    foreach (ai in a_ai_targets) {
        if (ai.archetype === "zombie") {
            if (!isdefined(var_841fcf67)) {
                var_841fcf67 = [];
            } else if (!isarray(var_841fcf67)) {
                var_841fcf67 = array(var_841fcf67);
            }
            var_841fcf67[var_841fcf67.size] = ai;
        }
    }
    a_ai_targets = arraysortclosest(var_841fcf67, self getorigin(), a_ai_targets.size, 0, 400);
    a_ai_targets = array::remove_dead(var_841fcf67);
    a_ai_targets = array::remove_undefined(var_841fcf67);
    return var_841fcf67;
}

