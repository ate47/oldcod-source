#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie_death;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm\zm_escape_vo_hooks;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_traps;
#using scripts\zm_common\zm_utility;

#namespace zm_escape_traps;

// Namespace zm_escape_traps/zm_escape_traps
// Params 0, eflags: 0x2
// Checksum 0x8d866c98, Offset: 0x3a0
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_escape_traps", &__init__, &__main__, undefined);
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 0, eflags: 0x0
// Checksum 0x3f595a66, Offset: 0x3f0
// Size: 0x19c
function __init__() {
    clientfield::register("actor", "fan_trap_blood_fx", 1, 1, "int");
    clientfield::register("toplayer", "rumble_fan_trap", 1, 1, "int");
    clientfield::register("actor", "acid_trap_death_fx", 1, 1, "int");
    clientfield::register("scriptmover", "acid_trap_fx", 1, 1, "int");
    clientfield::register("actor", "spinning_trap_blood_fx", 1, 1, "int");
    clientfield::register("toplayer", "rumble_spinning_trap", 1, 1, "int");
    clientfield::register("toplayer", "player_acid_trap_post_fx", 1, 1, "int");
    level thread function_1769dffa();
    level thread init_fan_trap_trigs();
    level thread init_acid_trap_trigs();
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 0, eflags: 0x0
// Checksum 0xd94e7c26, Offset: 0x598
// Size: 0x1f8
function __main__() {
    level thread function_209620c0();
    var_6d3f23ed = getentarray("zm_spinning_trap", "script_noteworthy");
    foreach (var_34982382 in var_6d3f23ed) {
        var_34982382 thread function_5e363b63();
    }
    var_4f81c51c = getentarray("zm_fan_trap", "script_noteworthy");
    foreach (var_ff54853d in var_4f81c51c) {
        var_ff54853d thread function_c94b6eda();
    }
    var_a95c0ba4 = getentarray("zm_acid_trap", "script_noteworthy");
    foreach (var_3f782535 in var_a95c0ba4) {
        var_3f782535 thread function_fca5d570();
    }
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 0, eflags: 0x0
// Checksum 0x90c6d4f3, Offset: 0x798
// Size: 0x404
function init_fan_trap_trigs() {
    var_4f81c51c = getentarray("zm_fan_trap", "script_noteworthy");
    foreach (var_ff54853d in var_4f81c51c) {
        var_ff54853d._trap_cooldown_time = 25;
        var_ff54853d.var_581c41e = [];
        a_e_trap = getentarray(var_ff54853d.target, "targetname");
        for (i = 0; i < a_e_trap.size; i++) {
            if (isdefined(a_e_trap[i].script_string)) {
                if (a_e_trap[i].script_string == "fan_trap_rumble") {
                    var_ff54853d.t_rumble = a_e_trap[i];
                    continue;
                }
                if (a_e_trap[i].script_string == "fxanim_fan") {
                    var_ff54853d.mdl_fan = a_e_trap[i];
                    continue;
                }
                if (a_e_trap[i].script_string == "trap_control_panel") {
                    if (!isdefined(var_ff54853d.var_581c41e)) {
                        var_ff54853d.var_581c41e = [];
                    } else if (!isarray(var_ff54853d.var_581c41e)) {
                        var_ff54853d.var_581c41e = array(var_ff54853d.var_581c41e);
                    }
                    if (!isinarray(var_ff54853d.var_581c41e, a_e_trap[i])) {
                        var_ff54853d.var_581c41e[var_ff54853d.var_581c41e.size] = a_e_trap[i];
                    }
                }
            }
        }
        a_s_trap = struct::get_array(var_ff54853d.target);
        for (i = 0; i < a_s_trap.size; i++) {
            if (isdefined(a_s_trap[i].script_noteworthy)) {
                if (a_s_trap[i].script_noteworthy == "brutus_trap_finder") {
                    if (!isdefined(var_ff54853d.var_7410ba73)) {
                        var_ff54853d.var_7410ba73 = [];
                    } else if (!isarray(var_ff54853d.var_7410ba73)) {
                        var_ff54853d.var_7410ba73 = array(var_ff54853d.var_7410ba73);
                    }
                    if (!isinarray(var_ff54853d.var_7410ba73, a_s_trap[i])) {
                        var_ff54853d.var_7410ba73[var_ff54853d.var_7410ba73.size] = a_s_trap[i];
                    }
                }
            }
        }
        var_ff54853d zapper_light_red();
    }
    zm_traps::register_trap_basic_info("zm_fan_trap", &activate_zm_fan_trap, &function_94917345);
    zm_traps::register_trap_damage("zm_fan_trap", &function_ec54528a, &function_6469907e);
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 0, eflags: 0x0
// Checksum 0xf74ab17f, Offset: 0xba8
// Size: 0x100
function function_c94b6eda() {
    level flag::wait_till("start_zombie_round_logic");
    if (isdefined(self.script_int)) {
        level flag::wait_till("power_on" + self.script_int);
    } else {
        level flag::wait_till("power_on");
    }
    self zapper_light_green();
    while (true) {
        s_result = level waittill(#"trap_activated");
        if (s_result.trap == self) {
            s_result.trap_activator zm_stats::increment_client_stat("prison_fan_trap_used", 0);
        }
    }
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 0, eflags: 0x0
// Checksum 0xd27687d1, Offset: 0xcb0
// Size: 0x204
function activate_zm_fan_trap() {
    self zapper_light_red();
    level.trapped_track[#"fan"] = 1;
    self.in_use = 1;
    self thread zm_traps::trap_damage();
    self.mdl_fan thread scene::init(#"p8_fxanim_zm_esc_trap_fan_play", self.mdl_fan);
    self thread fan_trap_timeout();
    self thread fan_trap_rumble_think();
    self waittill(#"trap_finished");
    self.in_use = undefined;
    self.mdl_fan thread scene::play(#"p8_fxanim_zm_esc_trap_fan_play", self.mdl_fan);
    a_players = getplayers();
    foreach (e_player in a_players) {
        if (isdefined(e_player.fan_trap_rumble) && e_player.fan_trap_rumble) {
            e_player clientfield::set_to_player("rumble_fan_trap", 0);
            e_player.fan_trap_rumble = undefined;
        }
    }
    self notify(#"trap_done");
    self waittill(#"available");
    self zapper_light_green();
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 0, eflags: 0x0
// Checksum 0x570467a9, Offset: 0xec0
// Size: 0x5c
function function_94917345() {
    self playsound(#"zmb_trap_activate");
    self waittill(#"available");
    self playsound(#"zmb_trap_available");
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 1, eflags: 0x0
// Checksum 0xaf207457, Offset: 0xf28
// Size: 0xcc
function function_ec54528a(t_damage) {
    self endon(#"death", #"disconnect");
    if (!self hasperk(#"specialty_armorvest") || self.health - 100 < 1) {
        radiusdamage(self.origin, 10, self.health + 100, self.health + 100, t_damage);
        return;
    }
    self dodamage(50, self.origin, undefined, t_damage);
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 1, eflags: 0x0
// Checksum 0xa0f8d6b6, Offset: 0x1000
// Size: 0x2e0
function function_6469907e(t_damage) {
    if (isdefined(level.custom_fan_trap_damage_func)) {
        self thread [[ level.custom_fan_trap_damage_func ]](t_damage);
        return;
    }
    if (self.var_29ed62b2 == #"miniboss" || self.var_29ed62b2 == #"boss") {
        t_damage notify(#"trap_finished");
        return;
    }
    if (isdefined(self.var_36dc13fb) && self.var_36dc13fb) {
        return;
    }
    if (level.round_number < 40) {
        self.marked_for_death = 1;
        self clientfield::set("fan_trap_blood_fx", 1);
        level notify(#"hash_528d7b7f7d6c51a1", {#e_player:t_damage.activated_by_player});
        self zombie_utility::gib_random_parts();
        self thread stop_fan_trap_blood_fx();
        self dodamage(self.health + 1000, t_damage.origin, undefined, t_damage);
        return;
    }
    if (isdefined(self.var_4fb07675) && self.var_4fb07675) {
        return;
    }
    self.var_4fb07675 = 1;
    self clientfield::set("fan_trap_blood_fx", 1);
    while (isalive(self) && self istouching(t_damage) && isdefined(t_damage.in_use) && t_damage.in_use) {
        self function_d29831a7();
        self dodamage(self.maxhealth * 0.3, t_damage.origin, undefined, t_damage);
        wait 0.1;
    }
    if (isalive(self)) {
        self clientfield::set("fan_trap_blood_fx", 0);
        self.var_4fb07675 = undefined;
        return;
    }
    level notify(#"hash_528d7b7f7d6c51a1", {#e_player:t_damage.activated_by_player});
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 0, eflags: 0x4
// Checksum 0x7115eaa9, Offset: 0x12e8
// Size: 0x10e
function private function_d29831a7() {
    if (isdefined(self.no_gib) && self.no_gib) {
        return;
    }
    if (math::cointoss()) {
        if (!gibserverutils::isgibbed(self, 32)) {
            gibserverutils::gibrightarm(self);
            return;
        }
    }
    if (math::cointoss()) {
        if (!gibserverutils::isgibbed(self, 16)) {
            gibserverutils::gibleftarm(self);
            return;
        }
    }
    if (math::cointoss()) {
        gibserverutils::gibrightleg(self);
        return;
    }
    if (math::cointoss()) {
        gibserverutils::gibleftleg(self);
        return;
    }
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 0, eflags: 0x0
// Checksum 0x33ef479b, Offset: 0x1400
// Size: 0x66
function fan_trap_timeout() {
    self endon(#"trap_finished");
    for (n_duration = 0; n_duration < 25; n_duration += 0.05) {
        wait 0.05;
    }
    self notify(#"trap_finished");
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 0, eflags: 0x0
// Checksum 0x4be7a0c6, Offset: 0x1470
// Size: 0xb0
function fan_trap_rumble_think() {
    self endon(#"trap_finished");
    while (true) {
        s_result = self.t_rumble waittill(#"trigger");
        if (isplayer(s_result.activator)) {
            if (!(isdefined(s_result.activator.fan_trap_rumble) && s_result.activator.fan_trap_rumble)) {
                self thread fan_trap_rumble(s_result.activator);
            }
        }
    }
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 1, eflags: 0x0
// Checksum 0xb0b657f4, Offset: 0x1528
// Size: 0xda
function fan_trap_rumble(e_player) {
    e_player endon(#"death", #"disconnect");
    self endon(#"trap_finished");
    while (true) {
        if (e_player istouching(self.t_rumble)) {
            e_player clientfield::set_to_player("rumble_fan_trap", 1);
            e_player.fan_trap_rumble = 1;
            wait 0.25;
            continue;
        }
        e_player clientfield::set_to_player("rumble_fan_trap", 0);
        e_player.fan_trap_rumble = 0;
        break;
    }
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 0, eflags: 0x0
// Checksum 0xf09a3509, Offset: 0x1610
// Size: 0x150
function fan_trap_damage() {
    if (isdefined(level.custom_fan_trap_damage_func)) {
        self thread [[ level.custom_fan_trap_damage_func ]]();
        return;
    }
    self endon(#"fan_trap_finished");
    while (true) {
        s_result = self waittill(#"trigger");
        if (isplayer(s_result.activator)) {
            s_result.activator thread player_fan_trap_damage();
            continue;
        }
        if (isdefined(s_result.activator.is_brutus) && s_result.activator.is_brutus) {
            self notify(#"trap_finished");
            return;
        }
        if (isdefined(self.var_36dc13fb) && self.var_36dc13fb) {
            return;
        }
        if (!isdefined(s_result.activator.marked_for_death)) {
            s_result.activator.marked_for_death = 1;
            s_result.activator thread zombie_fan_trap_death();
        }
    }
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 0, eflags: 0x0
// Checksum 0x3f819651, Offset: 0x1768
// Size: 0xc4
function player_fan_trap_damage() {
    self endon(#"death", #"disconnect");
    if (!self hasperk(#"specialty_armorvest") || self.health - 100 < 1) {
        radiusdamage(self.origin, 10, self.health + 100, self.health + 100);
        return;
    }
    self dodamage(50, self.origin);
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 0, eflags: 0x0
// Checksum 0x73d9e561, Offset: 0x1838
// Size: 0xac
function zombie_fan_trap_death() {
    self endon(#"death");
    self clientfield::set("fan_trap_blood_fx", 1);
    if (!(isdefined(self.is_brutus) && self.is_brutus)) {
        self zombie_utility::gib_random_parts();
    }
    self thread stop_fan_trap_blood_fx();
    self dodamage(self.health + 1000, self.origin);
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 0, eflags: 0x0
// Checksum 0xb491946b, Offset: 0x18f0
// Size: 0x34
function stop_fan_trap_blood_fx() {
    wait 2;
    if (isdefined(self)) {
        self clientfield::set("fan_trap_blood_fx", 0);
    }
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 0, eflags: 0x0
// Checksum 0x4366ccde, Offset: 0x1930
// Size: 0x54
function function_209620c0() {
    level flag::wait_till_any(array("activate_cafeteria", "activate_infirmary"));
    level flag::set("acid_trap_available");
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 0, eflags: 0x0
// Checksum 0xa517790d, Offset: 0x1990
// Size: 0x4a4
function init_acid_trap_trigs() {
    var_a95c0ba4 = getentarray("zm_acid_trap", "script_noteworthy");
    foreach (var_3f782535 in var_a95c0ba4) {
        var_3f782535._trap_cooldown_time = 25;
        var_3f782535.var_318d0b07 = [];
        var_3f782535.var_581c41e = [];
        var_3f782535.var_7410ba73 = [];
        a_e_trap = getentarray(var_3f782535.target, "targetname");
        for (i = 0; i < a_e_trap.size; i++) {
            if (isdefined(a_e_trap[i].script_string)) {
                if (a_e_trap[i].script_string == "trap_control_panel") {
                    if (!isdefined(var_3f782535.var_581c41e)) {
                        var_3f782535.var_581c41e = [];
                    } else if (!isarray(var_3f782535.var_581c41e)) {
                        var_3f782535.var_581c41e = array(var_3f782535.var_581c41e);
                    }
                    if (!isinarray(var_3f782535.var_581c41e, a_e_trap[i])) {
                        var_3f782535.var_581c41e[var_3f782535.var_581c41e.size] = a_e_trap[i];
                    }
                }
            }
        }
        a_s_trap = struct::get_array(var_3f782535.target, "targetname");
        for (i = 0; i < a_s_trap.size; i++) {
            if (isdefined(a_s_trap[i].script_string)) {
                if (a_s_trap[i].script_string == "acid_trap_fx") {
                    if (!isdefined(var_3f782535.var_318d0b07)) {
                        var_3f782535.var_318d0b07 = [];
                    } else if (!isarray(var_3f782535.var_318d0b07)) {
                        var_3f782535.var_318d0b07 = array(var_3f782535.var_318d0b07);
                    }
                    if (!isinarray(var_3f782535.var_318d0b07, a_s_trap[i])) {
                        var_3f782535.var_318d0b07[var_3f782535.var_318d0b07.size] = a_s_trap[i];
                    }
                }
            }
            if (isdefined(a_s_trap[i].script_noteworthy)) {
                if (a_s_trap[i].script_noteworthy == "brutus_trap_finder") {
                    if (!isdefined(var_3f782535.var_7410ba73)) {
                        var_3f782535.var_7410ba73 = [];
                    } else if (!isarray(var_3f782535.var_7410ba73)) {
                        var_3f782535.var_7410ba73 = array(var_3f782535.var_7410ba73);
                    }
                    if (!isinarray(var_3f782535.var_7410ba73, a_s_trap[i])) {
                        var_3f782535.var_7410ba73[var_3f782535.var_7410ba73.size] = a_s_trap[i];
                    }
                }
            }
        }
        var_3f782535 zapper_light_red();
    }
    zm_traps::register_trap_basic_info("zm_acid_trap", &activate_zm_acid_trap, &function_4db5de4b);
    zm_traps::register_trap_damage("zm_acid_trap", &function_30a28778, &function_3ee25670);
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 0, eflags: 0x0
// Checksum 0xd8fa205d, Offset: 0x1e40
// Size: 0xc8
function function_fca5d570() {
    level flag::wait_till("start_zombie_round_logic");
    level flag::wait_till("acid_trap_available");
    self zapper_light_green();
    while (true) {
        s_result = level waittill(#"trap_activated");
        if (s_result.trap == self) {
            s_result.trap_activator zm_stats::increment_client_stat("prison_acid_trap_used", 0);
        }
    }
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 0, eflags: 0x0
// Checksum 0x5d11cf98, Offset: 0x1f10
// Size: 0x104
function activate_zm_acid_trap() {
    self zapper_light_red();
    level.trapped_track[#"acid"] = 1;
    for (i = 0; i < self.var_318d0b07.size; i++) {
        self.var_318d0b07[i] thread acid_trap_fx(self);
        waitframe(1);
    }
    self.in_use = 1;
    self thread zm_traps::trap_damage();
    self waittilltimeout(25, #"trap_finished");
    self.in_use = undefined;
    self notify(#"trap_done");
    self waittill(#"available");
    self zapper_light_green();
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 0, eflags: 0x0
// Checksum 0x411d8dde, Offset: 0x2020
// Size: 0x5c
function function_4db5de4b() {
    self playsound(#"zmb_trap_activate");
    self waittill(#"available");
    self playsound(#"zmb_trap_available");
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 1, eflags: 0x0
// Checksum 0x4aace10a, Offset: 0x2088
// Size: 0x166
function function_30a28778(t_damage) {
    self endon(#"death", #"disconnect");
    if (!(isdefined(self.is_in_acid) && self.is_in_acid) && !self laststand::player_is_in_laststand()) {
        self.is_in_acid = 1;
        self thread function_67c18e6e(t_damage);
        while (self istouching(t_damage) && isdefined(t_damage.in_use) && t_damage.in_use && !self laststand::player_is_in_laststand()) {
            if (self.health <= 20) {
                self dodamage(self.health + 100, self.origin, undefined, t_damage);
            } else {
                self dodamage(self.maxhealth / 2.75, self.origin, undefined, t_damage);
            }
            wait 1;
        }
        self.is_in_acid = undefined;
    }
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 1, eflags: 0x0
// Checksum 0x7edf8b0a, Offset: 0x21f8
// Size: 0x310
function function_3ee25670(t_damage) {
    if (isdefined(level.custom_acid_trap_damage_func)) {
        t_damage thread [[ level.custom_acid_trap_damage_func ]]();
        return;
    }
    if (self.var_29ed62b2 === #"miniboss" || self.var_29ed62b2 === #"boss") {
        return;
    }
    if (isdefined(self.var_36dc13fb) && self.var_36dc13fb) {
        return;
    }
    if (isdefined(self.var_4fb07675) && self.var_4fb07675) {
        return;
    }
    self.var_4fb07675 = 1;
    if (level.round_number < 40) {
        self.marked_for_death = 1;
        self clientfield::set("acid_trap_death_fx", 1);
        level notify(#"hash_317f58ba0d580c27", {#e_player:t_damage.activated_by_player});
        wait randomfloatrange(0.25, 2);
        if (isalive(self)) {
            self zombie_utility::gib_random_parts();
            self thread stop_acid_death_fx();
            self dodamage(self.health + 1000, t_damage.origin, undefined, t_damage);
        }
        return;
    }
    self clientfield::set("acid_trap_death_fx", 1);
    while (isalive(self) && self istouching(t_damage) && isdefined(t_damage.in_use) && t_damage.in_use) {
        self function_d29831a7();
        self dodamage(self.maxhealth * 0.2, t_damage.origin, undefined, t_damage);
        wait 0.3;
    }
    if (isalive(self)) {
        self clientfield::set("acid_trap_death_fx", 0);
        self.var_4fb07675 = undefined;
        return;
    }
    level notify(#"hash_317f58ba0d580c27", {#e_player:t_damage.activated_by_player});
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 1, eflags: 0x0
// Checksum 0x10eeb49b, Offset: 0x2510
// Size: 0xac
function acid_trap_fx(e_trap) {
    mdl_fx = util::spawn_model("tag_origin", self.origin, self.angles);
    mdl_fx clientfield::set("acid_trap_fx", 1);
    e_trap waittilltimeout(25, #"trap_finished");
    mdl_fx clientfield::set("acid_trap_fx", 0);
    waitframe(1);
    mdl_fx delete();
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 0, eflags: 0x0
// Checksum 0xcfbdee97, Offset: 0x25c8
// Size: 0x34
function stop_acid_death_fx() {
    wait 2;
    if (isdefined(self)) {
        self clientfield::set("acid_trap_death_fx", 0);
    }
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 1, eflags: 0x0
// Checksum 0x55cdb0e, Offset: 0x2608
// Size: 0xdc
function function_67c18e6e(t_damage) {
    self endon(#"bled_out", #"disconnect");
    if (self clientfield::get_to_player("player_acid_trap_post_fx") === 1) {
        return;
    }
    self clientfield::set_to_player("player_acid_trap_post_fx", 1);
    while (self istouching(t_damage) && isdefined(t_damage.in_use) && t_damage.in_use) {
        waitframe(1);
    }
    self clientfield::set_to_player("player_acid_trap_post_fx", 0);
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 0, eflags: 0x0
// Checksum 0x91c39ff1, Offset: 0x26f0
// Size: 0x444
function function_1769dffa() {
    var_6d3f23ed = getentarray("zm_spinning_trap", "script_noteworthy");
    foreach (var_34982382 in var_6d3f23ed) {
        var_34982382._trap_cooldown_time = 25;
        a_e_targets = getentarray(var_34982382.target, "targetname");
        var_34982382.var_581c41e = [];
        var_34982382.var_7410ba73 = [];
        for (i = 0; i < a_e_targets.size; i++) {
            if (isdefined(a_e_targets[i].script_string)) {
                if (a_e_targets[i].script_string == "spinning_trap_rumble") {
                    var_34982382.t_rumble = a_e_targets[i];
                    continue;
                }
                if (a_e_targets[i].script_string == "fxanim_spinning_trap") {
                    var_34982382.mdl_trap = a_e_targets[i];
                    continue;
                }
                if (a_e_targets[i].script_string == "trap_control_panel") {
                    if (!isdefined(var_34982382.var_581c41e)) {
                        var_34982382.var_581c41e = [];
                    } else if (!isarray(var_34982382.var_581c41e)) {
                        var_34982382.var_581c41e = array(var_34982382.var_581c41e);
                    }
                    if (!isinarray(var_34982382.var_581c41e, a_e_targets[i])) {
                        var_34982382.var_581c41e[var_34982382.var_581c41e.size] = a_e_targets[i];
                    }
                }
            }
        }
        a_s_trap = struct::get_array(var_34982382.target);
        for (i = 0; i < a_s_trap.size; i++) {
            if (isdefined(a_s_trap[i].script_noteworthy)) {
                if (a_s_trap[i].script_noteworthy == "brutus_trap_finder") {
                    if (!isdefined(var_34982382.var_7410ba73)) {
                        var_34982382.var_7410ba73 = [];
                    } else if (!isarray(var_34982382.var_7410ba73)) {
                        var_34982382.var_7410ba73 = array(var_34982382.var_7410ba73);
                    }
                    if (!isinarray(var_34982382.var_7410ba73, a_s_trap[i])) {
                        var_34982382.var_7410ba73[var_34982382.var_7410ba73.size] = a_s_trap[i];
                    }
                }
            }
        }
        var_34982382.mdl_trap thread scene::play(#"p8_fxanim_zm_esc_trap_spinning_bundle", var_34982382.mdl_trap);
        var_34982382 zapper_light_red();
    }
    zm_traps::register_trap_basic_info("zm_spinning_trap", &activate_zm_spinning_trap, &function_2dfd69c8);
    zm_traps::register_trap_damage("zm_spinning_trap", &function_9da9c6fb, &function_b4ddb801);
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 0, eflags: 0x0
// Checksum 0xe834f9fe, Offset: 0x2b40
// Size: 0x100
function function_5e363b63() {
    level flag::wait_till("start_zombie_round_logic");
    if (isdefined(self.script_int)) {
        level flag::wait_till("power_on" + self.script_int);
    } else {
        level flag::wait_till("power_on");
    }
    self zapper_light_green();
    while (true) {
        s_result = level waittill(#"trap_activated");
        if (s_result.trap == self) {
            s_result.trap_activator zm_stats::increment_client_stat("prison_spinning_trap_used", 0);
        }
    }
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 0, eflags: 0x0
// Checksum 0x97bc0e0e, Offset: 0x2c48
// Size: 0x24c
function activate_zm_spinning_trap() {
    self zapper_light_red();
    level.trapped_track[#"fan"] = 1;
    self.in_use = 1;
    self.mdl_trap thread scene::init(#"p8_fxanim_zm_esc_trap_spinning_bundle", self.mdl_trap);
    var_ec1463a6 = struct::get("spinning_trap_poi", "targetname");
    self thread function_bae84c37(var_ec1463a6);
    self thread function_b60eeab7();
    self thread function_d3065700();
    wait 1.2;
    self thread zm_traps::trap_damage();
    self waittill(#"trap_finished");
    self.in_use = undefined;
    self.mdl_trap thread scene::play(#"p8_fxanim_zm_esc_trap_spinning_bundle", self.mdl_trap);
    a_players = getplayers();
    foreach (e_player in a_players) {
        if (isdefined(e_player.b_spinning_trap_rumble) && e_player.b_spinning_trap_rumble) {
            e_player clientfield::set_to_player("rumble_spinning_trap", 0);
            e_player.b_spinning_trap_rumble = undefined;
        }
    }
    self notify(#"trap_done");
    self waittill(#"available");
    self zapper_light_green();
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 0, eflags: 0x0
// Checksum 0x779470ff, Offset: 0x2ea0
// Size: 0x24
function function_2dfd69c8() {
    self playsound(#"zmb_trap_activate");
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 1, eflags: 0x0
// Checksum 0x77ace65f, Offset: 0x2ed0
// Size: 0xcc
function function_9da9c6fb(t_damage) {
    self endon(#"death", #"disconnect");
    if (!self hasperk(#"specialty_armorvest") || self.health - 100 < 1) {
        radiusdamage(self.origin, 10, self.health + 100, self.health + 100, t_damage);
        return;
    }
    self dodamage(50, self.origin, undefined, t_damage);
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 1, eflags: 0x0
// Checksum 0x7b03d872, Offset: 0x2fa8
// Size: 0x726
function function_b4ddb801(t_damage) {
    if (isdefined(level.var_48de0ec8)) {
        self thread [[ level.var_48de0ec8 ]](t_damage);
        return;
    }
    if (self.var_29ed62b2 === #"miniboss" || self.var_29ed62b2 === #"boss") {
        t_damage notify(#"trap_finished");
        return;
    }
    if (isdefined(self.var_36dc13fb) && self.var_36dc13fb || isdefined(self.var_58aafce) && self.var_58aafce) {
        return;
    }
    if (isdefined(self.var_4fb07675) && self.var_4fb07675) {
        return;
    }
    self.var_4fb07675 = 1;
    if (isai(self) && !isvehicle(self)) {
        self clientfield::set("spinning_trap_blood_fx", 1);
    }
    self playsound(#"hash_42c6cc2204b7fbbd");
    v_hook = t_damage.mdl_trap gettagorigin("tag_weapon_3");
    n_dist = distance2d(self.origin, v_hook);
    if (!(isdefined(t_damage.var_f586a1eb) && t_damage.var_f586a1eb) && self.var_29ed62b2 === #"basic" && n_dist <= 128 && self.team != #"allies") {
        t_damage.var_f586a1eb = 1;
        self.var_58aafce = 1;
        var_dab82e2 = util::spawn_model("tag_origin", t_damage.mdl_trap gettagorigin("tag_weapon_3"), t_damage.mdl_trap gettagangles("tag_weapon_3"));
        var_dab82e2 linkto(t_damage.mdl_trap, "tag_weapon_3");
        self thread function_199edac0(t_damage, var_dab82e2);
        a_e_players = util::get_array_of_closest(self.origin, level.activeplayers);
        if (distance2dsquared(a_e_players[0].origin, self.origin) < 160000) {
            a_e_players[0] zm_audio::create_and_play_dialog("spin_trap", "hook", undefined, 1);
        }
        return;
    }
    if (isai(self) && !isvehicle(self)) {
        self thread function_ea1b7b2e();
    }
    if (self.var_29ed62b2 === #"basic" && !isvehicle(self)) {
        str_tag = t_damage.mdl_trap get_closest_tag(self.origin);
        if (str_tag === "tag_weapon_1") {
            self zombie_utility::makezombiecrawler(1);
        } else if (str_tag === "tag_weapon_4") {
            gibserverutils::gibhead(self);
        } else if (str_tag === "tag_weapon_3" && randomint(100) < 75) {
            gibserverutils::annihilate(self);
        } else {
            n_lift_height = randomintrange(8, 64);
            v_away_from_source = vectornormalize(self.origin - t_damage.origin);
            v_away_from_source *= 128;
            v_away_from_source = (v_away_from_source[0], v_away_from_source[1], n_lift_height);
            a_trace = physicstraceex(self.origin + (0, 0, 32), self.origin + v_away_from_source, (-16, -16, -16), (16, 16, 16), self);
            self setplayercollision(0);
            self startragdoll();
            self launchragdoll(150 * anglestoup(self.angles) + (v_away_from_source[0], v_away_from_source[1], 0));
        }
        level notify(#"hash_148b3ce521088846", {#e_player:t_damage.activated_by_player});
        self dodamage(self.health + 1000, self.origin, undefined, t_damage);
        return;
    }
    if (self.var_29ed62b2 === #"popcorn") {
        level notify(#"hash_148b3ce521088846", {#e_player:t_damage.activated_by_player});
        self dodamage(self.health + 1000, self.origin, undefined, t_damage);
        return;
    }
    self dodamage(self.maxhealth * 0.2, self.origin, undefined, t_damage);
    wait 0.25;
    self.var_4fb07675 = undefined;
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 1, eflags: 0x4
// Checksum 0x18c02516, Offset: 0x36d8
// Size: 0xfa
function private get_closest_tag(v_pos) {
    if (!isdefined(self.var_449da6ab)) {
        self function_77145531();
    }
    var_7333bccb = undefined;
    for (i = 0; i < self.var_449da6ab.size; i++) {
        if (!isdefined(var_7333bccb)) {
            var_7333bccb = self.var_449da6ab[i];
            continue;
        }
        if (distance2dsquared(v_pos, self gettagorigin(self.var_449da6ab[i])) < distance2dsquared(v_pos, self gettagorigin(var_7333bccb))) {
            var_7333bccb = self.var_449da6ab[i];
        }
    }
    return tolower(var_7333bccb);
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 0, eflags: 0x4
// Checksum 0xf9b03bb2, Offset: 0x37e0
// Size: 0x72
function private function_77145531() {
    tags = [];
    tags[tags.size] = "tag_weapon_1";
    tags[tags.size] = "tag_weapon_2";
    tags[tags.size] = "tag_weapon_3";
    tags[tags.size] = "tag_weapon_4";
    self.var_449da6ab = tags;
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 0, eflags: 0x0
// Checksum 0x7a155a3d, Offset: 0x3860
// Size: 0x66
function function_b60eeab7() {
    self endon(#"trap_finished");
    for (n_duration = 0; n_duration < 25; n_duration += 0.05) {
        wait 0.05;
    }
    self notify(#"trap_finished");
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 0, eflags: 0x0
// Checksum 0x3f2c5704, Offset: 0x38d0
// Size: 0xb0
function function_d3065700() {
    self endon(#"trap_finished");
    while (true) {
        s_result = self.t_rumble waittill(#"trigger");
        if (isplayer(s_result.activator)) {
            if (!(isdefined(s_result.activator.b_spinning_trap_rumble) && s_result.activator.b_spinning_trap_rumble)) {
                self thread spinning_trap_rumble(s_result.activator);
            }
        }
    }
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 1, eflags: 0x0
// Checksum 0x10140abb, Offset: 0x3988
// Size: 0xd6
function spinning_trap_rumble(e_player) {
    e_player endon(#"death", #"disconnect");
    self endon(#"trap_finished");
    while (true) {
        if (e_player istouching(self.t_rumble)) {
            e_player clientfield::set_to_player("rumble_spinning_trap", 1);
            e_player.b_spinning_trap_rumble = 1;
            wait 0.25;
            continue;
        }
        e_player clientfield::set_to_player("rumble_spinning_trap", 0);
        e_player.b_spinning_trap_rumble = undefined;
        break;
    }
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 0, eflags: 0x0
// Checksum 0x4e598915, Offset: 0x3a68
// Size: 0x34
function function_ea1b7b2e() {
    wait 2;
    if (isdefined(self)) {
        self clientfield::set("spinning_trap_blood_fx", 0);
    }
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 2, eflags: 0x0
// Checksum 0xb9a294dc, Offset: 0x3aa8
// Size: 0x28e
function function_199edac0(t_damage, var_dab82e2) {
    self val::set("spinning_trap", "ignoreall", 1);
    self val::set("spinning_trap", "allowdeath", 0);
    self.b_ignore_cleanup = 1;
    self.health = 1;
    self notsolid();
    self setteam(util::get_enemy_team(self.team));
    self zombie_utility::makezombiecrawler(1);
    var_dab82e2 thread scene::init(#"aib_vign_zm_mob_hook_trap_zombie", self);
    playsoundatposition(#"hash_42c6cc2204b7fbbd", self.origin);
    t_damage waittill(#"trap_finished");
    var_59d327e8 = var_dab82e2 scene::function_3dd10dad(#"p8_fxanim_zm_esc_trap_fan_play", "Shot 2");
    var_dab82e2 scene::play(#"aib_vign_zm_mob_hook_trap_zombie", self);
    if (isdefined(self)) {
        self val::reset("spinning_trap", "ignoreall");
        self val::reset("spinning_trap", "allowdeath");
        self.b_ignore_cleanup = 0;
        self solid();
        self setteam(level.zombie_team);
    }
    if (isdefined(self)) {
        self dodamage(self.health + 1000, self.origin);
    }
    var_dab82e2 unlink();
    var_dab82e2 delete();
    t_damage.var_f586a1eb = undefined;
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 1, eflags: 0x4
// Checksum 0xecf43085, Offset: 0x3d40
// Size: 0x214
function private function_bae84c37(s_pos = self) {
    v_point = getclosestpointonnavmesh(s_pos.origin, 128, 16);
    if (!isdefined(v_point)) {
        return;
    }
    var_efb97c9e = spawn("script_origin", v_point);
    if (!(isdefined(var_efb97c9e zm_utility::in_playable_area()) && var_efb97c9e zm_utility::in_playable_area())) {
        var_efb97c9e delete();
        return;
    }
    var_efb97c9e zm_utility::create_zombie_point_of_interest(300, 4, 10000);
    var_efb97c9e zm_utility::create_zombie_point_of_interest_attractor_positions(undefined, undefined, 90);
    a_ai_zombies = getaiteamarray(level.zombie_team);
    foreach (ai_zombie in a_ai_zombies) {
        if (ai_zombie.var_29ed62b2 == #"miniboss" || ai_zombie.var_29ed62b2 == #"boss") {
            ai_zombie thread zm_utility::add_poi_to_ignore_list(var_efb97c9e);
        }
    }
    self waittill(#"trap_finished");
    var_efb97c9e delete();
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 0, eflags: 0x0
// Checksum 0xdb8f9513, Offset: 0x3f60
// Size: 0x23c
function function_eaea583() {
    self.var_581c41e = [];
    self.var_5d20c600 = [];
    foreach (var_3d4777e7 in self.var_e28c56b4) {
        var_291b7a7e = getentarray(var_3d4777e7.target, "targetname");
        for (i = 0; i < var_291b7a7e.size; i++) {
            if (var_291b7a7e[i].script_string === "trap_handle") {
                if (!isdefined(self.var_5d20c600)) {
                    self.var_5d20c600 = [];
                } else if (!isarray(self.var_5d20c600)) {
                    self.var_5d20c600 = array(self.var_5d20c600);
                }
                if (!isinarray(self.var_5d20c600, var_291b7a7e[i])) {
                    self.var_5d20c600[self.var_5d20c600.size] = var_291b7a7e[i];
                }
                continue;
            }
            if (var_291b7a7e[i].script_string === "trap_control_panel") {
                if (!isdefined(self.var_581c41e)) {
                    self.var_581c41e = [];
                } else if (!isarray(self.var_581c41e)) {
                    self.var_581c41e = array(self.var_581c41e);
                }
                if (!isinarray(self.var_581c41e, var_291b7a7e[i])) {
                    self.var_581c41e[self.var_581c41e.size] = var_291b7a7e[i];
                }
            }
        }
    }
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 0, eflags: 0x0
// Checksum 0x674dfaa2, Offset: 0x41a8
// Size: 0x5e
function zapper_light_red() {
    for (i = 0; i < self.var_581c41e.size; i++) {
        self.var_581c41e[i] setmodel(#"p7_zm_mob_trap_control_base_red");
    }
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 0, eflags: 0x0
// Checksum 0xddbc6f5f, Offset: 0x4210
// Size: 0x5e
function zapper_light_green() {
    for (i = 0; i < self.var_581c41e.size; i++) {
        self.var_581c41e[i] setmodel(#"p7_zm_mob_trap_control_base");
    }
}

// Namespace zm_escape_traps/zm_escape_traps
// Params 0, eflags: 0x0
// Checksum 0xed93a08e, Offset: 0x4278
// Size: 0x188
function trap_move_switch() {
    self zapper_light_red();
    foreach (mdl_handle in self.var_5d20c600) {
        mdl_handle rotatepitch(-180, 0.5);
        mdl_handle playsound(#"amb_sparks_l_b");
    }
    wait 0.5;
    self notify(#"switch_activated");
    self waittill(#"available");
    self zapper_light_green();
    foreach (mdl_handle in self.var_5d20c600) {
        mdl_handle rotatepitch(180, 0.5);
    }
}

